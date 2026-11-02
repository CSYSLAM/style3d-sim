"""Audit the first public H1 pair without treating a single pair as an acceptance cohort."""
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
CAPTURE = BASE / 'public-h1-probe'
report = {'input_sha256': {}, 'initial_states': {}, 'frame_states': {}, 'whole_solver_complete': False}
status = json.loads((CAPTURE / 'status.json').read_text())
assert status['complete'] and status['running'] is None
assert [row['actual_exit'] for row in status['completed']] == [0, 0]
for backend in ('original', 'source'):
    runtime = json.loads((CAPTURE / backend / 'runtime.json').read_text())
    assert runtime['exit'] == 0 and runtime['frames'] == 4
    assert runtime['reference_solver_mapped'] == (backend == 'original')
    assert runtime['public_core_abi'] and not runtime['ab_bridge_used']
    assert not runtime['original_physics_and_test_final_modified']
    assert runtime['graph_steps'][0] == {'graph_before': False, 'graph_after': True}
    assert runtime['graph_steps'][1:] == [{'graph_before': True, 'graph_after': True}] * 3
    for name in ('before.npz', 'states.npz', 'runtime.json', 'model-counts.json'):
        path = CAPTURE / backend / name
        report['input_sha256'][f'{backend}/{name}'] = hashlib.sha256(path.read_bytes()).hexdigest()
assert (CAPTURE / 'original/model-counts.json').read_bytes() == (CAPTURE / 'source/model-counts.json').read_bytes()
for file_name, destination in [('before.npz', 'initial_states'), ('states.npz', 'frame_states')]:
    with np.load(CAPTURE / 'original' / file_name, allow_pickle=False) as native:
        with np.load(CAPTURE / 'source' / file_name, allow_pickle=False) as source:
            assert set(native.files) == set(source.files)
            for key in native.files:
                a, b = native[key], source[key]
                assert a.shape == b.shape and a.dtype == b.dtype
                assert np.isfinite(a).all() and np.isfinite(b).all()
                frames = [(a, b)] if destination == 'initial_states' else zip(a, b)
                entries = []
                for left, right in frames:
                    delta = np.abs(left.astype(np.float64) - right.astype(np.float64))
                    entries.append({'bitwise_equal': left.tobytes() == right.tobytes(),
                                    'different_words': int(np.count_nonzero(left.view(np.uint32)
                                                                          != right.view(np.uint32))),
                                    'max_abs_error': float(delta.max(initial=0))})
                report[destination][key] = {'shape': list(a.shape), 'dtype': str(a.dtype), 'frames': entries}
report['all_initial_bitwise_equal'] = all(
    item['frames'][0]['bitwise_equal'] for item in report['initial_states'].values())
report['all_recorded_frames_bitwise_equal'] = all(
    frame['bitwise_equal'] for item in report['frame_states'].values() for frame in item['frames'])
report['scope'] = ('One original/source pair, four example.step calls: first captures without replay; '
                   'three graph replays follow. No fixed C8 or long-run acceptance is claimed.')
destination = BASE / 'public-h1-probe-independent-cpu.json'
destination.write_text(json.dumps(report, indent=2) + '\n')
print(json.dumps({key: report[key] for key in
                  ('all_initial_bitwise_equal', 'all_recorded_frames_bitwise_equal', 'whole_solver_complete')}))
for key, item in report['frame_states'].items():
    print(key, [frame['max_abs_error'] for frame in item['frames']])
