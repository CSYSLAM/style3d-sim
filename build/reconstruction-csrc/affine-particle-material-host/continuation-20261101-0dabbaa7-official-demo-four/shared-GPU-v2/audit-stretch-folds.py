"""Independently reproduce all recorded GPU scalar fold histories and guard bytes on CPU."""
import ast
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
PHASE = BASE / 'particles-full-inputs/stretch-folds'
OUTPUT = PHASE / 'independent-cpu.json'
assert not OUTPUT.exists()
plan = json.loads((PHASE / 'plan.json').read_text())
report = json.loads((PHASE / 'GPU-report.json').read_text())
assert report['complete'] and report['error'] is None and report['actual_GPU_calls'] == len(plan['requests']) == 430
hashes = {**plan['input_sha256'], **report['input_sha256']}
protected, history_words, parameter_bytes = 0, 0, 0
tiny = np.finfo('f4').tiny


def ftz(value):
    return np.copysign(np.float32(0), value) if 0 < abs(value) < tiny else value


with np.load(PHASE / 'inputs.npz', allow_pickle=False) as inputs, np.load(PHASE / 'GPU-raw.npz') as raw:
    for request, row in zip(plan['requests'], report['rows']):
        number = request['number']
        assert number == row['number'] and request['target_bits'] == row['target_bits']
        values = inputs[f'{number}/values']
        order = inputs[f'{number}/order']
        expected_history = inputs[f'{number}/expected-history']
        assert np.array_equal(np.sort(order), np.arange(len(values), dtype='<u4'))
        history, total = [], np.float32(0)
        for index in order:
            history.append(total)
            total = ftz(np.float32(total + ftz(values[index])))
        assert np.asarray(history, dtype='<f4').tobytes() == expected_history.tobytes()
        assert int(total.view('<u4')) == request['target_bits']
        for index in range(4):
            actual = raw[f'{number}/raw-{index}']
            assert np.all(actual[:256] == 211) and np.all(actual[-256:] == 211)
            protected += 512
            expected = [values.view('u1'), order.view('u1'),
                        np.asarray([request['target_bits']], dtype='<u4').view('u1'), expected_history.view('u1')][index]
            assert actual[256:-256].tobytes() == expected.tobytes()
            if index < 2:
                protected += len(expected)
            parameter = raw[f'{number}/parameter-{index}']
            assert parameter.shape == (8,) and int.from_bytes(parameter.tobytes(), 'little') % 256 == 0
            parameter_bytes += 8
        count = raw[f'{number}/parameter-4']
        assert count.shape == (4,) and int.from_bytes(count.tobytes(), 'little') == len(values)
        parameter_bytes += 4
        history_words += len(values)
for path in (Path(__file__), PHASE / 'GPU-raw.npz', PHASE / 'GPU-report.json', PHASE / 'serial-atomic.ptx'):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for path, expected in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
result = {'actual_GPU_scalar_calls': 430, 'differing_captured_stretch_words_covered': 215,
          'history_words_checked': history_words, 'protected_bytes_checked': protected,
          'actual_parameter_bytes_checked': parameter_bytes, 'input_sha256': hashes,
          'GPU_used_for_this_audit': False, 'production_global_order_inferred': False,
          'whole_trajectory_failure_reclassified': False, 'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(result, indent=2) + '\n')
print('Independent GPU fold CPU:430 exact targets,215 differing words;', history_words, 'history words')
