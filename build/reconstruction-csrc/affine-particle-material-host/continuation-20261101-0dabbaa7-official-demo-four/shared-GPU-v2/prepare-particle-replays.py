"""Prepare eighteen complete actual particle-cloth packets;keep full pointer aliases and all captured output bytes."""
import hashlib
import json
from pathlib import Path
import sys
import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import schemas, compare
from reconstruction.csrc.hook_parameter_bytes import decode

PHASE = BASE / 'particles-full-inputs'
OUTPUT = PHASE / 'full-input-replays'
OUTPUT.mkdir(exist_ok=False)
plan = json.loads((PHASE / 'plan.json').read_text())
status = json.loads((PHASE / 'status.json').read_text())
assert status['complete'] and all(row['actual_exit'] == 0 for row in status['completed'])
metadata = compare(PHASE / 'original/launches.txt', PHASE / 'source/launches.txt', schemas()[0])
assert metadata['equal']
schema = schemas()[0]
writes = {'22evaluate_stretch_force': ['5'], '22evaluate_bending_force': ['7'],
    'add_cloth_membrane_gauss_newton_hessian': ['5', '7'],
    '27invert_block_preconditioner': ['0', '3'], '23precondition_and_reduce': ['2', '6'],
    '19update_cg_direction': ['6'], '26multiply_matrix_and_reduce': ['6', '9'],
    '28update_solution_and_residual': ['6', '7'], '20apply_nonlinear_step': ['1', '2']}
hashes, packets, names = dict(plan['input_sha256']), [], set()
for worker, side in enumerate(('original', 'source')):
    directory = PHASE / side
    path = directory / 'launches.txt'
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
    arrays, seen = {}, set()
    for line in path.read_text().splitlines():
        node = decode(line)
        key = node['key']
        if key not in writes or key in seen:
            continue
        seen.add(key)
        stage_key = f'{node["owned_launch"]:04d}-{key}'
        bindings, expected = [], []
        for field, size in plan['fields'][key].items():
            argument, label = int(field), 'arg-' + field
            address = int.from_bytes(bytes.fromhex(node['parameter_hex'][argument]), 'little')
            assert address
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
        assert actual == {b['argument'] for b in bindings}, (key, actual)
        stage = {'key': stage_key, 'kind': key, 'node': node, 'bindings': bindings, 'outputs': expected,
                 'all_flat_nonnull_inputs_captured': True}
        packets.append({'worker': worker, 'frame': 0, 'stage': stage, 'input': str(OUTPUT / f'worker-{worker}.npz')})
        names.add(node['name'])
    assert seen == set(writes)
    path = OUTPUT / f'worker-{worker}.npz'
    np.savez_compressed(path, **arrays)
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
origin = BASE.parent.parent / 'continuation-20261101-7ca67172-driven-self-body-block'
engine, auditor = origin / 'replay-engine-as-run.py', origin / 'audit-replays.py'
for original, target in [(engine, PHASE / 'replay-engine-as-run.py'), (auditor, PHASE / 'audit-replays.py')]:
    text = original.read_text().replace('198', '18').replace('594', '54').replace('Body-block', 'Particle complete')
    assert not target.exists()
    target.write_text(text)
    for path in (original, target):
        hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for path in (Path(__file__), PHASE / 'plan.json', PHASE / 'status.json'):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
image = ROOT / 'build/reconstruction-csrc/host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so'
source_hash = hashlib.sha256(image.read_bytes()).hexdigest()
assert source_hash == '0dabbaa7a57b57187549f814632efebdc5612095765932be112c2c9ca1868e3e'
hashes[str(image)] = source_hash
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
assert len(packets) == 18
result = {'packets': packets, 'kernel_names': sorted(names), 'input_sha256': hashes,
          'candidate_image': str(image), 'candidate_sha256': source_hash,
          'backends': ['SDK-runtime', 'original-ptx', 'source-ptx'], 'expected_unmodified_calls': 54,
          'original_fixed_samples_replaced': False, 'production_changed': False, 'whole_solver_complete': False}
(OUTPUT / 'plan.json').write_text(json.dumps(result, indent=2) + '\n')
print('Prepared18 actual complete force/Hessian/CG packets;54 calls;all nonnull pointer fields captured', flush=True)
