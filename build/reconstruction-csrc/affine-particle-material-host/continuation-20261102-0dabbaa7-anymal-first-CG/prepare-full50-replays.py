"""Pack every captured flat pointer of all50 first-NL core iterations, retaining nullable fields and original raw bytes."""
from collections import Counter
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import compare, parameter_types, schemas
from reconstruction.csrc.hook_parameter_bytes import decode

PHASE = BASE / 'full50'
OUTPUT = PHASE / 'full-input-replays'
OUTPUT.mkdir(exist_ok=False)
plan = json.loads((PHASE / 'plan.json').read_text())
status = json.loads((PHASE / 'status.json').read_text())
assert status['complete'] and all(row['actual_exit'] == 0 for row in status['completed'])
metadata = compare(PHASE / 'original/launches.txt', PHASE / 'source/launches.txt', schemas()[0])
assert metadata['equal'] and metadata['left_launches'] == metadata['right_launches'] == 2608
hashes, packets, names = dict(plan['input_sha256']), [], set()
counts_by_worker = []
for worker, side in enumerate(('original', 'source')):
    directory = PHASE / side
    counts, captured_counts, arrays = Counter(), Counter(), {}
    path = directory / 'launches.txt'
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
    for line in path.read_text().splitlines():
        node = decode(line)
        key = node['key']
        if key not in plan['fields']:
            continue
        ordinal = counts[key]
        counts[key] += 1
        if ordinal >= plan['dump_limit_per_key']:
            continue
        captured_counts[key] += 1
        stage_key = f'{node["owned_launch"]:04d}-{key}-call{ordinal:03d}'
        types = parameter_types(node['name'])
        actual = {i for i, kind in enumerate(types)
                  if '*' in kind and int.from_bytes(bytes.fromhex(node['parameter_hex'][i]), 'little')}
        assert actual <= {int(i) for i in plan['fields'][key]}
        bindings = []
        for field, size in plan['fields'][key].items():
            i, label = int(field), 'arg-' + field
            pointer = int.from_bytes(bytes.fromhex(node['parameter_hex'][i]), 'little')
            for source_phase, target_phase in (('pre', 'before'), ('post', 'after')):
                path = directory / f'dump_{key}_call{ordinal:03d}_{source_phase}_arg{i}.bin'
                if pointer == 0:
                    assert not path.exists()
                    continue
                raw = path.read_bytes()
                assert len(raw) == size, (path, len(raw), size)
                hashes[str(path.resolve())] = hashlib.sha256(raw).hexdigest()
                arrays[stage_key + '/' + target_phase + '/' + label] = np.frombuffer(raw, dtype='u1').copy()
            if pointer:
                bindings.append({'label': label, 'argument': i, 'offset': 0, 'address': pointer, 'bytes': size})
        assert actual == {binding['argument'] for binding in bindings}
        writes = ['arg-' + str(i) for i in plan['outputs'][key]]
        assert all(int(label[4:]) in actual for label in writes)
        if key == '19update_cg_direction':
            assert int.from_bytes(bytes.fromhex(node['parameter_hex'][0]), 'little') == ordinal
        stage = {'key': stage_key, 'kind': key, 'node': node, 'bindings': bindings, 'outputs': writes,
                 'all_nonnull_flat_pointer_inputs_captured': True, 'call_ordinal': ordinal}
        packets.append({'worker': worker, 'frame': 0, 'stage': stage, 'input': str(OUTPUT / f'worker-{worker}.npz')})
        names.add(node['name'])
    assert len(arrays) > 0 and sum(captured_counts.values()) == 215
    counts_by_worker.append(dict(captured_counts))
    path = OUTPUT / f'worker-{worker}.npz'
    np.savez_compressed(path, **arrays)
    with np.load(path, allow_pickle=False) as saved:
        assert set(saved.files) == set(arrays)
        assert all(saved[key].tobytes() == value.tobytes() for key, value in arrays.items())
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
assert len(packets) == 430 and counts_by_worker[0] == counts_by_worker[1]
origin = BASE / 'capture'
for name in ('replay-engine-as-run.py', 'audit-replays.py'):
    source, target = origin / name, PHASE / name
    text = source.read_text().replace('16', '430').replace('48', '1290').replace('ANYmal first CG', 'ANYmal50 CG')
    assert not target.exists()
    target.write_text(text)
    for path in (source, target):
        hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
image = ROOT / 'build/reconstruction-csrc/host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so'
source_hash = hashlib.sha256(image.read_bytes()).hexdigest()
assert source_hash == '0dabbaa7a57b57187549f814632efebdc5612095765932be112c2c9ca1868e3e'
hashes[str(image)] = source_hash
for path in (Path(__file__), PHASE / 'plan.json', PHASE / 'status.json'):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for path, digest in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == digest, path
result = {'packets': packets, 'kernel_names': sorted(names), 'input_sha256': hashes,
          'candidate_image': str(image), 'candidate_sha256': source_hash,
          'backends': ['SDK-runtime', 'original-ptx', 'source-ptx'], 'expected_unmodified_calls': 1290,
          'counts_by_worker': counts_by_worker, 'all50_first_NL_core_iterations_captured': True,
          'all_extra_operator_producers_captured': False, 'old_frozen_failures_reclassified': False,
          'production_changed': False, 'whole_solver_complete': False}
(OUTPUT / 'plan.json').write_text(json.dumps(result, indent=2) + '\n')
print('Prepared430 complete packets and1290 real calls;all50 first-NL core iterations plus5 SO3 RHS/inverse/apply')
