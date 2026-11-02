"""Recompute held-out SDK control errors against the unchanged fixed C8 cohort entirely on CPU."""
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
OUTPUT = BASE / 'native-controls/independent-cpu.json'
assert not OUTPUT.exists()
plan = json.loads((BASE / 'native-controls/plan.json').read_text())
report = json.loads((BASE / 'native-controls/report.json').read_text())
status = json.loads((BASE / 'native-controls/status.json').read_text())
assert status['complete'] and len(status['completed']) == 6
assert all(row['actual_exit'] == 0 for row in status['completed'])
hashes = dict(plan['input_sha256'])


def read(path):
    raw = path.read_bytes()
    hashes[str(path.resolve())] = hashlib.sha256(raw).hexdigest()
    return raw


rows = []
for mode, controls in report['modes'].items():
    paths = plan['original_cohort_paths'][mode]
    assert len(paths) == 8 and len(controls) == 3
    original_states = []
    for path in paths:
        read(Path(path))
        with np.load(path, allow_pickle=False) as data:
            original_states.append({key: data[key].astype('f8') for key in data.files})
    for number, control in enumerate(controls):
        assert control['run'] == number and control['candidate_backend'] == 'fixed_original_SDK'
        path = Path(control['path'])
        read(path)
        runtime = json.loads(read(path.with_suffix('.runtime.json')))
        assert runtime['backend'] == 'original' and runtime['frames'] == 60
        assert runtime['image_sha256'] == '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
        assert runtime['extra'] == ['--solver', mode]
        fields = {}
        with np.load(path, allow_pickle=False) as data:
            assert set(data.files) == set(original_states[0]) == set(control['spread'])
            for key in data.files:
                raw = data[key]
                assert raw.dtype == np.dtype('<f4') and len(raw) == 600 and np.isfinite(raw).all()
                original = np.stack([state[key] for state in original_states])
                total = original.sum(0)
                axes = tuple(range(1, raw.ndim))
                spread = np.stack([np.abs(original[i] - (total - original[i]) / 7).max(axis=axes)
                                   for i in range(8)]).max(0)
                error = np.abs(raw.astype('f8') - total / 8).max(axis=axes)
                inside = error <= spread
                stats = control['spread'][key]
                assert stats['substeps_within_spread'] == int(inside.sum())
                assert stats['legacy_spread_max'] == float(spread.max())
                assert stats['reconstruction_error_max'] == float(error.max())
                for step in range(600):
                    point = stats['checkpoints'][str(step)]
                    assert point['legacy_spread'] == float(spread[step])
                    assert point['reconstruction_error'] == float(error[step])
                fields[key] = {'within_steps': int(inside.sum()), 'total_steps': 600,
                               'first_outside_step': int(np.flatnonzero(~inside)[0]) if not inside.all() else None}
        outside = [key for key in fields if fields[key]['within_steps'] != 600]
        assert sorted(outside) == sorted(control['outside'])
        assert (not outside) == control['all_steps_within_fixed_C8']
        rows.append({'mode': mode, 'run': number, 'actual_backend': 'fixed_original_SDK',
                     'within_C8': not outside, 'arrays': fields})
for path in (Path(__file__), BASE / 'native-controls/plan.json',
             BASE / 'native-controls/report.json', BASE / 'native-controls/status.json'):
    read(path)
for path, expected in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
result = {'rows': rows, 'input_sha256': hashes, 'original_control_runs': len(rows),
          'original_control_runs_outside_fixed_C8': sum(not row['within_C8'] for row in rows),
          'GPU_used': False, 'fixed_samples_replaced': False, 'source_failures_reclassified': False,
          'production_changed': False, 'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(result, indent=2) + '\n')
print('Independent SDK controls CPU:', result['original_control_runs_outside_fixed_C8'],
      '/', len(rows), 'original controls outside unchanged C8;source failures retained', flush=True)
