#!/usr/bin/env python3
"""Restore a lossless diagnostic bundle and verify every original filename, byte length and SHA256."""
import argparse
import hashlib
import json
from pathlib import Path
import tarfile
import tempfile


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('metadata', type=Path, help='Path to native-archive.json')
    parser.add_argument('--output', type=Path, help='Default: the original native directory beside the metadata')
    args = parser.parse_args()
    metadata = json.loads(args.metadata.read_text())
    assert metadata['schema'] == 1 and metadata['format'] == 'sha256-content-store-v1'
    assert Path(metadata['archive']).name == metadata['archive']
    archive = args.metadata.parent / metadata['archive']
    assert hashlib.sha256(archive.read_bytes()).hexdigest() == metadata['archive_sha256']
    output = args.output or args.metadata.parent / metadata['relative_output_directory']
    with tarfile.open(archive, 'r|gz') as tar:
        members = iter(tar)
        first = next(members)
        assert first.name == 'files.json' and first.isfile()
        files = json.load(tar.extractfile(first))['files']
        assert len(files) == metadata['files']
        assert all(Path(name).name == name and name not in ('', '.', '..') for name in files)
        digests = {entry['sha256'] for entry in files.values()}
        expected_members = {'files.json', *('blobs/' + digest for digest in digests)}
        if output.exists():
            assert {p.name for p in output.iterdir()} == set(files), 'Existing directory has different coverage'
            for name, entry in files.items():
                data = (output / name).read_bytes()
                assert len(data) == entry['bytes'] and hashlib.sha256(data).hexdigest() == entry['sha256'], name
            print(f'Verified {len(files)} existing raw files in {output}')
            return
        contents, seen = {}, {'files.json'}
        for member in members:
            assert member.isfile() and member.name in expected_members and member.name not in seen
            seen.add(member.name)
            digest = member.name.removeprefix('blobs/')
            data = tar.extractfile(member).read()
            assert hashlib.sha256(data).hexdigest() == digest
            contents[digest] = data
        assert seen == expected_members
    output.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory(prefix='.reconstruction-unpack-', dir=output.parent) as temporary:
        restored = Path(temporary) / 'native'
        restored.mkdir()
        for name, entry in files.items():
            data = contents[entry['sha256']]
            assert len(data) == entry['bytes']
            (restored / name).write_bytes(data)
        restored.rename(output)
    print(f'Restored and verified {len(files)} raw files in {output}')


if __name__ == '__main__':
    main()
