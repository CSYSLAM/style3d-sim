"""Prepare ten complete captured cable PCG packets, preserving aliases and excluding incomplete matrix/RHS inputs."""
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import schemas, compare
from reconstruction.csrc.hook_parameter_bytes import decode

PHASE = BASE / 'first-CG'
OUTPUT = PHASE / 'full-input-replays'
OUTPUT.mkdir(exist_ok=False)
plan = json.loads((PHASE / 'plan.json').read_text())
status = json.loads((PHASE / 'status.json').read_text())
assert status['complete'] and all(row['actual_exit'] == 0 for row in status['completed'])
metadata = compare(PHASE / 'original/launches.txt', PHASE / 'source/launches.txt', schemas()[0])
assert metadata['equal'] and metadata['left_launches'] == metadata['right_launches'] == 470
schema = schemas()[0]
writes = {'27invert_block_preconditioner': ['0', '3'], '23precondition_and_reduce': ['2', '6'],
          '19update_cg_direction': ['6'], '28update_solution_and_residual': ['6', '7'],
          '20apply_nonlinear_step': ['1', '2']}
hashes = dict(plan['input_sha256'])
packets, names = [], set()
for worker, side in enumerate(('original', 'source')):
    directory = PHASE / side
    arrays, seen = {}, set()
    path = directory / 'launches.txt'
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
    for line in path.read_text().splitlines():
        node = decode(line)
        key = node['key']
        if key not in writes or key in seen:
            continue
        seen.add(key)
        fields = plan['fields'][key]
        stage_key = f'{node["owned_launch"]:04d}-{key}'
        bindings = []
        expected = []
        for field, size in fields.items():
            argument = int(field)
            address = int.from_bytes(bytes.fromhex(node['parameter_hex'][argument]), 'little')
            assert address
            label = 'arg-' + field
            for source_phase, target_phase in (('pre', 'before'), ('post', 'after')):
                path = directory / f'dump_{key}_{source_phase}_arg{field}.bin'
                raw = path.read_bytes()
                assert len(raw) == size
                hashes[str(path.resolve())] = hashlib.sha256(raw).hexdigest()
                arrays[stage_key + '/' + target_phase + '/' + label] = np.frombuffer(raw, dtype='u1').copy()
            bindings.append({'label': label, 'argument': argument, 'offset': 0, 'address': address, 'bytes': size})
            if field in writes[key]:
                expected.append(label)
        actual = {i for i, kind in enumerate(schema[node['name']]) if kind == 'pointer'
                  and int.from_bytes(bytes.fromhex(node['parameter_hex'][i]), 'little')}
        assert actual == {b['argument'] for b in bindings}, (key, actual, bindings)
        stage = {'key': stage_key, 'kind': key, 'node': node, 'bindings': bindings, 'outputs': expected,
                 'all_flat_nonnull_inputs_captured': True}
        packets.append({'worker': worker, 'frame': 0, 'stage': stage, 'input': str(OUTPUT / f'worker-{worker}.npz')})
        names.add(node['name'])
    assert seen == set(writes)
    path = OUTPUT / f'worker-{worker}.npz'
    np.savez_compressed(path, **arrays)
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
origin = BASE.parent / 'continuation-20261101-7ca67172-driven-self-body-block'
engine = origin / 'replay-engine-as-run.py'
text = engine.read_text().replace('198', '10').replace('594', '30').replace('Body-block', 'Cable first CG')
derived = PHASE / 'replay-engine-as-run.py'
assert not derived.exists()
derived.write_text(text)
auditor = origin / 'audit-replays.py'
text = auditor.read_text().replace('198', '10').replace('594', '30')
derived_audit = PHASE / 'audit-replays.py'
assert not derived_audit.exists()
derived_audit.write_text(text)
for path in (engine, auditor, derived, derived_audit, Path(__file__), PHASE / 'plan.json', PHASE / 'status.json'):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
image = ROOT / 'build/reconstruction-csrc/host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so'
source_hash = hashlib.sha256(image.read_bytes()).hexdigest()
assert source_hash == '0dabbaa7a57b57187549f814632efebdc5612095765932be112c2c9ca1868e3e'
hashes[str(image)] = source_hash
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
result = {'packets': packets, 'kernel_names': sorted(names), 'input_sha256': hashes,
          'candidate_image': str(image), 'candidate_sha256': source_hash,
          'backends': ['SDK-runtime', 'original-ptx', 'source-ptx'], 'expected_unmodified_calls': 30,
          'original_fixed_samples_replaced': False, 'production_changed': False, 'whole_solver_complete': False}
assert len(packets) == 10
(OUTPUT / 'plan.json').write_text(json.dumps(result, indent=2) + '\n')
(PHASE / 'engine-origin.json').write_text(json.dumps({'source_engine': str(engine),
    'source_sha256': hashes[str(engine.resolve())], 'derived_sha256': hashes[str(derived.resolve())],
    'allowed_changes': 'Only fixed counts10/30 and log text;pointer/alias replay arithmetic unchanged'}, indent=2) + '\n')
print('Prepared10 complete first cable CG/inverse/apply packets;30 calls;partial matrix excluded', flush=True)
