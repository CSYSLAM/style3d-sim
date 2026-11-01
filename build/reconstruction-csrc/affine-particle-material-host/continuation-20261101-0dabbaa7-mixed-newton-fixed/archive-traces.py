"""Losslessly bundle all six raw captures; leave every original raw file intact locally."""
import gzip
import hashlib
import io
import json
from pathlib import Path
import tarfile

BASE = Path(__file__).resolve().parent
directories = ['traces4/' + str(index) for index in range(4)]
directories += ['frozen-reproduced-mixed-pair/' + side for side in ('legacy', 'source')]
for tag in directories:
    folder = BASE / tag / 'native'
    archive = folder.with_name('native-content.tar.gz')
    assert folder.is_dir() and not archive.exists()
    rows, blobs, raw = {}, {}, 0
    for path in sorted(folder.iterdir()):
        assert path.is_file() and not path.is_symlink()
        data = path.read_bytes()
        digest = hashlib.sha256(data).hexdigest()
        if digest in blobs:
            assert blobs[digest] == data
        else:
            blobs[digest] = data
        rows[path.name] = {'bytes': len(data), 'sha256': digest}
        raw += len(data)
    manifest = json.dumps({'schema': 1, 'files': rows}, sort_keys=True, indent=2).encode() + b'\n'
    with archive.open('wb') as output, gzip.GzipFile(
            filename='', fileobj=output, mode='wb', mtime=0, compresslevel=6) as packed:
        with tarfile.open(fileobj=packed, mode='w|') as tar:
            members = [('files.json', manifest)] + [('blobs/' + sha, data) for sha, data in sorted(blobs.items())]
            for name, data in members:
                info = tarfile.TarInfo(name)
                info.size, info.mode = len(data), 0o644
                tar.addfile(info, io.BytesIO(data))
    assert archive.stat().st_size < 95 * 1024 * 1024
    with tarfile.open(archive, 'r:gz') as tar:
        assert json.load(tar.extractfile('files.json'))['files'] == rows
        for digest, data in sorted(blobs.items()):
            assert tar.extractfile('blobs/' + digest).read() == data
    metadata = {'schema': 1, 'format': 'sha256-content-store-v1', 'archive': archive.name,
                'archive_sha256': hashlib.sha256(archive.read_bytes()).hexdigest(),
                'archive_bytes': archive.stat().st_size, 'files': len(rows), 'raw_bytes': raw,
                'unique_content_files': len(blobs), 'unique_content_bytes': sum(map(len, blobs.values())),
                'relative_output_directory': 'native', 'all_raw_file_contents_preserved': True,
                'roundtrip_verified': True}
    folder.with_name('native-archive.json').write_text(json.dumps(metadata, indent=2) + '\n')
    print(tag, 'raw files', len(rows), 'archive bytes', archive.stat().st_size, flush=True)
