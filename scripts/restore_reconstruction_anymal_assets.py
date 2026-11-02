#!/usr/bin/env python3
"""Restore the fixed ANYmal D assets from repository files without network or GPU access."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import tempfile


ROOT = Path(__file__).resolve().parents[1]
BUNDLE = ROOT / 'reconstruction/assets/anybotics_anymal_d'


def verify(directory, files):
    actual = {path.relative_to(directory).as_posix() for path in directory.rglob('*') if path.is_file()}
    assert actual == set(files), 'Existing ANYmal assets differ; use a separate --cache-dir'
    for name, expected in files.items():
        path = directory / name
        assert not path.is_symlink()
        raw = path.read_bytes()
        assert len(raw) == expected['bytes'] and hashlib.sha256(raw).hexdigest() == expected['sha256'], name


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    default = os.environ.get('NEWTON_CACHE_PATH', str(Path.home() / '.cache/newton'))
    parser.add_argument('--cache-dir', type=Path, default=Path(default))
    parser.add_argument('--report', type=Path)
    args = parser.parse_args()
    manifest_path = BUNDLE / 'manifest.json'
    manifest = json.loads(manifest_path.read_text())
    assert manifest['asset_reference'] == '261cd1f429619d8ef4f546bd788ab9dea906b5e1'
    assert manifest['asset_name'] == 'anybotics_anymal_d' and len(manifest['files']) == 20
    for name in manifest['files']:
        assert not Path(name).is_absolute() and '..' not in Path(name).parts
    verify(BUNDLE / 'files', manifest['files'])
    cache = args.cache_dir.expanduser().resolve()
    cache.mkdir(parents=True, exist_ok=True)
    destination = cache / manifest['cache_directory']
    if destination.exists():
        verify(destination / manifest['asset_name'], manifest['files'])
        restored = False
    else:
        with tempfile.TemporaryDirectory(prefix='reconstruction-anymal-', dir=cache) as temporary:
            staging = Path(temporary) / manifest['cache_directory']
            shutil.copytree(BUNDLE / 'files', staging / manifest['asset_name'])
            verify(staging / manifest['asset_name'], manifest['files'])
            staging.rename(destination)
        restored = True
    result = {'asset_path': str(destination / manifest['asset_name']), 'file_count': 20,
              'manifest_sha256': hashlib.sha256(manifest_path.read_bytes()).hexdigest(),
              'restored': restored, 'all_asset_bytes_verified': True, 'network_used': False,
              'GPU_context_created': False, 'solver_imported': False}
    if args.report:
        args.report.parent.mkdir(parents=True, exist_ok=True)
        args.report.write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
