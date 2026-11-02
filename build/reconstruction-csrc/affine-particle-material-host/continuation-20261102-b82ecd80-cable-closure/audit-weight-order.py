"""Prove the failed constructor differs only by the five distance/point-line weight upload identities."""
import hashlib
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import schemas
from reconstruction.csrc.memory_pointer_audit import capture

group = BASE / 'constructors-dynamic/point-line-distance-w3-pd-b1'
layout = schemas()[0]
original, source = [capture(group / 'external-full-memory' / side, layout) for side in ('original', 'source')]
identity = {51: 48, 52: 49, 48: 50, 49: 51, 50: 52}
for left, right in zip(original, source):
    assert left['name'] == right['name']
    remapped = json.loads(json.dumps(right))
    for pointer in remapped['pointers']:
        if pointer[1] == 'owned':
            pointer[2] = identity.get(pointer[2], pointer[2])
    assert left == remapped, left['name']
assert len(original) == len(source)
arrays, hashes = [], {}
for side in ('original', 'source'):
    folder = group / 'external-payload' / side
    uploaded = []
    for line in (folder / 'memory.jsonl').read_text().splitlines():
        row = json.loads(line)
        if 'file' in row:
            path = folder / row['file']
            uploaded.append(path.read_bytes())
            hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    arrays.append(uploaded)
    for observer in ('external-full-memory', 'external-payload'):
        for name in ('memory.jsonl', 'launches.txt', 'capture.runtime.json'):
            path = group / observer / side / name
            hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
assert len(arrays[0]) == len(arrays[1]) == 32
order = list(range(24)) + [27, 28, 24, 25, 26] + list(range(29, 32))
assert arrays[0] == [arrays[1][i] for i in order]
for index in range(24, 29):
    assert len(arrays[0][index]) == len(arrays[1][index]) == 48
path = BASE.parent / 'continuation-20261102-0dabbaa7-cable-body-constraints/candidate-cache-order/source_solver.cpp'
hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
hashes[str(Path(__file__))] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
record = {'owned_calls': len(original), 'all_flat_targets_equal_after_exact5_identity_mapping': True,
          'source_to_original_allocation_identity': identity, 'complete_upload_buffers': 32,
          'source_upload_indices_in_original_order': order, 'only_upload_indices_permuted': [24, 25, 26, 27, 28],
          'each_weight_upload_bytes': 48, 'input_sha256': hashes,
          'production_modified': False, 'whole_solver_complete': False}
(BASE / 'weight-order-independent-cpu.json').write_text(json.dumps(record, indent=2) + '\n')
print('CPU isolated exact five weight-upload identity/order permutation; all other uploads and flat targets match')
