#!/usr/bin/env python3
"""Verify the frozen handoff without importing the solver or executing project bytecode."""
import argparse
import hashlib
import json
from pathlib import Path
import sys


ROOT = Path(__file__).resolve().parents[1]
LFS_POINTER = b'version https://git-lfs.github.com/spec/v1'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--reference-only', action='store_true', help='Check only the frozen SDK binaries')
    args = parser.parse_args()
    snapshot = json.loads((ROOT / 'RECONSTRUCTION_SNAPSHOT.json').read_text(encoding='utf-8'))
    failures, count = [], 0
    for name, entry in snapshot['files'].items():
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
    if not args.reference_only:
        for name in ('build/third_party/glm-1.0.1/glm/glm.hpp',
                     'build/toolchains/cuda_nvcc-linux-x86_64-12.4.131-archive.tar.xz'):
            if name not in snapshot['files'] or not (ROOT / name).is_file():
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
