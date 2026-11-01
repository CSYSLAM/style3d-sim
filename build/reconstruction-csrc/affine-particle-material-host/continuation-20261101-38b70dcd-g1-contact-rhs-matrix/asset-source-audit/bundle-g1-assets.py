"""Bundle the exact already-verified cache bytes; use small Git files and retain both upstream licenses."""
import gzip
import hashlib
import io
import json
import os
from pathlib import Path
import tarfile
import tempfile

root = Path.cwd()
base = Path(__file__).resolve().parents[1]
plan = json.loads((base / 'plan.json').read_text())
cache = Path('/home/oem/.cache/newton/newton-assets_unitree_g1_110bd790_261cd1f4')
assets = cache / 'unitree_g1'
paths = sorted(Path(name) for name in plan['input_sha256'] if '/.cache/newton/' in name)
assert len(paths) == 203
assert set(paths) == {p for p in assets.rglob('*') if p.is_file()}
output = root / 'reconstruction/assets/unitree_g1'
output.mkdir(parents=True, exist_ok=False)
files = {}
with tempfile.TemporaryFile() as archive:
    with gzip.GzipFile(fileobj=archive, mode='wb', filename='', mtime=0, compresslevel=6) as zipped:
        with tarfile.open(fileobj=zipped, mode='w|', format=tarfile.PAX_FORMAT) as packed:
            for path in paths:
                assert not path.is_symlink()
                data = path.read_bytes()
                sha = hashlib.sha256(data).hexdigest()
                assert sha == plan['input_sha256'][str(path)]
                name = path.relative_to(assets).as_posix()
                files[name] = {'bytes': len(data), 'sha256': sha}
                info = tarfile.TarInfo('unitree_g1/' + name)
                info.size, info.mtime, info.uid, info.gid = len(data), 0, 0, 0
                info.mode = path.stat().st_mode & 0o777
                info.uname = info.gname = ''
                packed.addfile(info, io.BytesIO(data))
    archive_bytes = archive.tell()
    archive.seek(0)
    chunks, whole = [], hashlib.sha256()
    while data := archive.read(32 * 1024 * 1024):
        name = 'unitree_g1.tar.gz.part' + str(len(chunks)).zfill(3)
        (output / name).write_bytes(data)
        chunks.append({'path': name, 'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()})
        whole.update(data)
identity = hashlib.md5(
    b'https://github.com/newton-physics/newton-assets.git#unitree_g1#261cd1f429619d8ef4f546bd788ab9dea906b5e1'
).hexdigest()[:8]
assert identity == '110bd790'
manifest = {'schema': 1, 'asset_reference': '261cd1f429619d8ef4f546bd788ab9dea906b5e1',
            'upstream_repository': 'https://github.com/newton-physics/newton-assets.git',
            'cache_directory': cache.name, 'cache_identity_hash': identity, 'files': files,
            'archive_bytes': archive_bytes, 'archive_sha256': whole.hexdigest(), 'archive_chunks': chunks,
            'used_by_fixed_reference_and_source_captures': True, 'downloaded_for_this_bundle': False,
            'licenses_included': ['LICENSE', 'rl_policies/LICENSE']}
(output / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
(output / 'LICENSE').write_bytes((assets / 'LICENSE').read_bytes())
report = {'file_count': len(files), 'uncompressed_bytes': sum(item['bytes'] for item in files.values()),
          'archive_bytes': archive_bytes, 'chunk_count': len(chunks), 'source_cache_modified': False,
          'all_fixed_input_hashes_match': True, 'GPU_context_created': False, 'solver_imported': False,
          'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(base / 'asset-source-audit/g1-bundle-build.json').write_text(json.dumps(report, indent=2) + '\n')
print(json.dumps(report, indent=2), flush=True)
