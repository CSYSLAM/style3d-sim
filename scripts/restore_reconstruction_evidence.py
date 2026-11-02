#!/usr/bin/env python3
"""Restore losslessly compressed frozen evidence;verify existing files and never overwrite a differing result."""
import gzip
import hashlib
import json
import os
from pathlib import Path
import tempfile

ROOT = Path(__file__).resolve().parents[1]


def digest(path):
    actual = hashlib.sha256()
    with path.open('rb') as stream:
        while chunk := stream.read(1024 * 1024):
            actual.update(chunk)
    return actual.hexdigest()


def restore():
    snapshot = json.loads((ROOT / 'RECONSTRUCTION_SNAPSHOT.json').read_text())
    entries = snapshot.get('compressed_evidence', [])
    for entry in entries:
        target = (ROOT / entry['path']).resolve()
        packed = (ROOT / entry['compressed_path']).resolve()
        assert target.is_relative_to(ROOT) and packed.is_relative_to(ROOT)
        assert entry['compression'] == 'gzip'
        assert packed.stat().st_size == entry['compressed_bytes'] and digest(packed) == entry['compressed_sha256']
        if target.exists():
            assert target.stat().st_size == entry['bytes'] and digest(target) == entry['sha256'], target
            print('Verified existing', target.relative_to(ROOT))
            continue
        target.parent.mkdir(parents=True, exist_ok=True)
        temporary = None
        try:
            with tempfile.NamedTemporaryFile(dir=target.parent, prefix='.restore-', delete=False) as output:
                temporary = Path(output.name)
                total, actual = 0, hashlib.sha256()
                with gzip.open(packed, 'rb') as source:
                    while chunk := source.read(1024 * 1024):
                        total += len(chunk)
                        assert total <= entry['bytes']
                        output.write(chunk)
                        actual.update(chunk)
            assert total == entry['bytes'] and actual.hexdigest() == entry['sha256']
            # Hard-link creation is atomic and refuses a concurrent writer's existing result.
            os.link(temporary, target)
            print('Restored', target.relative_to(ROOT))
        finally:
            if temporary is not None:
                temporary.unlink(missing_ok=True)
    print('Frozen compressed evidence checked:', len(entries))


if __name__ == '__main__':
    restore()
