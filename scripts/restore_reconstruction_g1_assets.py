#!/usr/bin/env python3
"""Restore the exact G1 asset bytes used by reconstruction tests, without importing a solver or accessing the network."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import tarfile
import tempfile


ROOT = Path(__file__).resolve().parents[1]
BUNDLE = ROOT / 'reconstruction/assets/unitree_g1'


def digest(path):
    with path.open('rb') as stream:
        return hashlib.file_digest(stream, 'sha256').hexdigest()


def verify(folder, files):
    actual = {p.relative_to(folder).as_posix() for p in folder.rglob('*') if p.is_file()}
    assert actual == set(files), 'The existing asset directory differs; use a separate --cache-dir.'
    for name, spec in files.items():
        path = folder / name
        assert not path.is_symlink() and path.stat().st_size == spec['bytes'] and digest(path) == spec['sha256'], name


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    default = Path(os.environ.get('NEWTON_CACHE_PATH', Path(os.environ.get('XDG_CACHE_HOME', Path.home() / '.cache'))
                                  / 'newton'))
    parser.add_argument('--cache-dir', type=Path, default=default, help='Newton cache root; defaults to Linux/WSL cache')
    parser.add_argument('--report', type=Path)
    args = parser.parse_args()
    manifest_path = BUNDLE / 'manifest.json'
    manifest = json.loads(manifest_path.read_text())
    assert manifest['asset_reference'] == '261cd1f429619d8ef4f546bd788ab9dea906b5e1'
    assert len(manifest['files']) == 203
    for name in manifest['files']:
        relative = Path(name)
        assert not relative.is_absolute() and '..' not in relative.parts
    cache = args.cache_dir.expanduser().resolve()
    cache.mkdir(parents=True, exist_ok=True)
    destination = cache / manifest['cache_directory']
    asset = destination / 'unitree_g1'
    if destination.exists():
        verify(asset, manifest['files'])
        restored = False
    else:
        with tempfile.TemporaryFile() as archive, tempfile.TemporaryDirectory(prefix='reconstruction-g1-', dir=cache) as tmp:
            combined = hashlib.sha256()
            for chunk in manifest['archive_chunks']:
                path = BUNDLE / chunk['path']
                assert path.stat().st_size == chunk['bytes'] and digest(path) == chunk['sha256'], chunk['path']
                with path.open('rb') as stream:
                    while data := stream.read(1024 * 1024):
                        archive.write(data)
                        combined.update(data)
            assert archive.tell() == manifest['archive_bytes']
            assert combined.hexdigest() == manifest['archive_sha256']
            archive.seek(0)
            staging = Path(tmp) / manifest['cache_directory']
            staging.mkdir()
            seen = set()
            with tarfile.open(fileobj=archive, mode='r:gz') as packed:
                for member in packed:
                    assert member.isfile() and member.name.startswith('unitree_g1/')
                    name = member.name.removeprefix('unitree_g1/')
                    assert name in manifest['files'] and name not in seen
                    assert member.size == manifest['files'][name]['bytes']
                    path = staging / 'unitree_g1' / name
                    path.parent.mkdir(parents=True, exist_ok=True)
                    with packed.extractfile(member) as source, path.open('wb') as target:
                        shutil.copyfileobj(source, target)
                    path.chmod(member.mode & 0o777)
                    seen.add(name)
            assert seen == set(manifest['files'])
            verify(staging / 'unitree_g1', manifest['files'])
            staging.rename(destination)
            restored = True
    report = {'cache_asset_path': str(asset), 'file_count': 203, 'restored': restored,
              'asset_reference': manifest['asset_reference'], 'all_asset_bytes_verified': True,
              'manifest_sha256': digest(manifest_path), 'network_access': False,
              'GPU_context_created': False, 'solver_imported': False, 'whole_solver_complete': False}
    if args.report:
        args.report.parent.mkdir(parents=True, exist_ok=True)
        args.report.write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps(report, indent=2))


if __name__ == '__main__':
    main()
