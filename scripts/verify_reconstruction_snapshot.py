#!/usr/bin/env python3
"""Verify the frozen handoff without importing the solver or executing project bytecode."""
import argparse
import gzip
import hashlib
import json
from pathlib import Path
import sys


ROOT = Path(__file__).resolve().parents[1]
LFS_POINTER = b'version https://git-lfs.github.com/spec/v1'


def frozen_files(snapshot, root=ROOT, include_evidence=True):
    """Resolve extra immutable file manifests without exceeding GitHub's per-file limit or shadowing entries."""
    seen = set()

    def entries(files):
        if not isinstance(files, dict):
            raise ValueError('file manifest must contain an object named files')
        for name, entry in files.items():
            path = Path(name)
            if path.is_absolute() or '..' in path.parts or name in seen:
                raise ValueError(f'unsafe or duplicate frozen path: {name}')
            seen.add(name)
            yield name, entry

    yield from entries(snapshot['files'])
    if not include_evidence:
        return
    for descriptor in snapshot.get('evidence_file_manifests', []):
        name = descriptor['path']
        if name not in snapshot['files']:
            raise ValueError(f'evidence manifest is not frozen by the primary snapshot: {name}')
        raw = (root / name).read_bytes()
        if len(raw) != descriptor['bytes'] or hashlib.sha256(raw).hexdigest() != descriptor['sha256']:
            raise ValueError(f'evidence file manifest hash or length mismatch: {name}')
        files = json.loads(raw)['files']
        if len(files) != descriptor['file_count']:
            raise ValueError(f'evidence file manifest count mismatch: {name}')
        yield from entries(files)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--reference-only', action='store_true', help='Check only the frozen SDK binaries')
    args = parser.parse_args()
    snapshot = json.loads((ROOT / 'RECONSTRUCTION_SNAPSHOT.json').read_text(encoding='utf-8'))
    failures, count, frozen_names = [], 0, set()
    try:
        for name, entry in frozen_files(snapshot, root=ROOT, include_evidence=not args.reference_only):
            frozen_names.add(name)
            if args.reference_only and not name.startswith('style3d-sim-bin/'):
                continue
            path = ROOT / name
            if not path.is_file():
                failures.append((name, 'missing'))
                continue
            data = path.read_bytes()
            if data.startswith(LFS_POINTER):
                failures.append((name, 'LFS pointer instead of actual content'))
            elif len(data) != entry['bytes'] or hashlib.sha256(data).hexdigest() != entry['sha256']:
                failures.append((name, 'hash or length mismatch'))
            elif path.suffix == '.so' and not data.startswith(b'\x7fELF'):
                failures.append((name, 'not ELF'))
            elif path.suffix == '.pyd' and not data.startswith(b'MZ'):
                failures.append((name, 'not PE'))
            count += 1
    except (OSError, ValueError, KeyError, TypeError) as error:
        failures.append(('evidence_file_manifests', str(error)))
    if not args.reference_only:
        for entry in snapshot.get('compressed_evidence', []):
            packed = ROOT / entry['compressed_path']
            actual, total = hashlib.sha256(), 0
            try:
                with gzip.open(packed, 'rb') as stream:
                    while chunk := stream.read(1024 * 1024):
                        actual.update(chunk)
                        total += len(chunk)
                if total != entry['bytes'] or actual.hexdigest() != entry['sha256']:
                    failures.append((entry['path'], 'compressed evidence payload mismatch'))
            except (OSError, EOFError) as error:
                failures.append((entry['path'], f'compressed evidence unreadable: {error}'))
        for name in ('build/third_party/glm-1.0.1/glm/glm.hpp',
                     'build/toolchains/cuda_nvcc-linux-x86_64-12.4.131-archive.tar.xz'):
            if name not in frozen_names or not (ROOT / name).is_file():
                failures.append((name, 'required build dependency missing from snapshot'))
        for folder, extension in [('host-particles', '_source_solver'), ('native', '_source_cuda')]:
            base = ROOT / 'build/reconstruction-csrc' / folder
            metadata = json.loads((base / 'build.json').read_text())
            for name, expected in metadata['sources'].items():
                path = ROOT / name
                if not path.is_file() or hashlib.sha256(path.read_bytes()).hexdigest() != expected:
                    failures.append((name, f'{folder} build provenance mismatch'))
            path = base / (extension + '.cpython-312-x86_64-linux-gnu.so')
            if hashlib.sha256(path.read_bytes()).hexdigest() != metadata['extension_sha256']:
                failures.append((str(path.relative_to(ROOT)), 'extension build provenance mismatch'))
    print(f'Checked {count} frozen files; failures={len(failures)}')
    for name, reason in failures:
        print(f'{reason}: {name}')
    return int(bool(failures))


if __name__ == '__main__':
    sys.exit(main())
