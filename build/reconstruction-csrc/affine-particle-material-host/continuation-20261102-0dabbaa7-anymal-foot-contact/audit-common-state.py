"""Audit shared public inputs, resulting single-step differences, launch metadata and actual foot RHS contributions on CPU."""
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import compare, schemas

OUTPUT = BASE / 'common-state-independent-cpu.json'
assert not OUTPUT.exists()
hashes = {}


def read(path):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
    return json.loads(path.read_text())


original, source = [read(BASE / ('common-' + backend) / 'report.json') for backend in ('original', 'source')]
assert original['config'] == source['config'] and original['native_model_span_sizes'] == source['native_model_span_sizes']
assert original['solver_steps_run'] == source['solver_steps_run'] == 1
metadata = {}
for prefix in ('common-', 'native-contact/'):
    paths = [BASE / (prefix + backend) / 'launches.txt' for backend in ('original', 'source')]
    result = compare(*paths, schemas()[0])
    assert result['equal'] and result['left_launches'] == result['right_launches'] == 2608
    metadata[prefix] = result
    for path in paths:
        hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
paths = [BASE / ('common-' + backend) / 'raw.npz' for backend in ('original', 'source')]
with np.load(paths[0], allow_pickle=False) as a, np.load(paths[1], allow_pickle=False) as b:
    differences = {}
    for field in ('particle_q', 'particle_qd', 'body_q', 'body_qd'):
        assert a[field].tobytes() == b[field].tobytes()
        key = 'output_' + field
        differences[field] = {'bitwise': a[key].tobytes() == b[key].tobytes(),
                              'max_abs': float(np.max(np.abs(a[key].astype('f8') - b[key].astype('f8'))))}
for path in paths:
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
plan = read(BASE / 'native-contact/full-input-replays/plan.json')
traces = read(BASE / 'native-contact/atomic-operands/report.json')
packet = plan['packets'][0]
stage, foot_rows = packet['stage'], []
with np.load(packet['input'], allow_pickle=False) as captured:
    prefix = stage['key'] + '/before/arg-'
    count = int(captured[prefix + '0'].view('<i4')[0])
    body = captured[prefix + '11'].view('<i4')
    indices = captured[prefix + '24'].view('<i4').reshape(-1, 4)
    shapes = captured[prefix + '3'].view('<i4')
    normal = captured[prefix + '8'].view('<f4').reshape(-1, 3)
    for lane in range(count):
        shape = int(shapes[lane])
        world, local = divmod(shape, 55)
        if local not in (38, 39, 40, 41):
            continue
        assert np.array_equal(normal[lane], [0., 0., 1.])
        center = int(indices[body[local], 0]) + world * 68
        bits = [value for label, index, value in traces['rows'][0]['thread_operands']['original'][lane]
                if label == 'arg-32' and index == center * 3 + 2]
        assert len(bits) == 2
        values = np.asarray(bits, dtype='<u4').view('<f4')
        assert values[0] > 0 and values[1] == 0
        foot_rows.append({'contact_row': lane, 'global_shape': shape, 'center_particle': center,
                          'actual_center_z_atomic_addends': values.tolist()})
assert len(foot_rows) == 32
for path in (Path(__file__), Path(packet['input'])):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for path, digest in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == digest
OUTPUT.write_text(json.dumps({'config': original['config'], 'public_state_inputs_bitwise_equal': True,
    'one_step_outputs': differences, 'metadata': metadata,
    'metadata_pointer_comparison_scope': 'NULL/present only;not addresses, alias relationships or pointed-to contents',
    'actual_foot_center_z_atomic_contributions': foot_rows, 'input_sha256': hashes, 'GPU_used': False,
    'static_support_balance_proved': False, 'full_trajectory_accepted': False}, indent=2) + '\n')
print('CPU verified common inputs/2608 normalized launches and32 real foot center RHS contributions')
