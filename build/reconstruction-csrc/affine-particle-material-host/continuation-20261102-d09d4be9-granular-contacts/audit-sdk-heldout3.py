"""Independently recompute every SDK control frame and report statistic without changing any frozen cohort."""
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
output = BASE / 'sdk-heldout3'
plan = json.loads((output / 'plan.json').read_text())
status = json.loads((output / 'status.json').read_text())
report = json.loads((output / 'report.json').read_text())
assert plan['control_runs'] == 3 and plan['fixed_original_runs'] == 8
assert status['complete'] and status['running'] is None and len(status['completed']) == 3
assert all(row['actual_exit'] == 0 for row in status['completed'])
for name, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
hashes, rows = {}, []
for group in report['groups']:
    original_paths = [BASE / 'graph-fixed-C8/cohorts' / group['label'] / f'original{i}.npz' for i in range(8)]
    control_paths = [output / f'control{i}-worker' / ('original-' + group['case'] + '-' + str(group['graph']) + '.npz')
                     for i in range(3)]
    with ExitStack() as stack:
        originals = [stack.enter_context(np.load(path, allow_pickle=False)) for path in original_paths]
        controls = [stack.enter_context(np.load(path, allow_pickle=False)) for path in control_paths]
        hashes.update({str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in original_paths + control_paths})
        passed, outside = [True] * 3, []
        for key in originals[0].files:
            arrays = [run[key] for run in originals + controls]
            assert all(a.shape == arrays[0].shape and a.dtype == arrays[0].dtype for a in arrays)
            assert len(arrays[0]) == 60 and all(np.isfinite(a).all() for a in arrays)
            old = np.asarray(arrays[:8], dtype='f8').reshape(8, 60, -1)
            total = np.zeros_like(old[0])
            for array in old:
                total += array
            envelope = np.max([np.max(np.abs(array - (total - array) / 7), axis=1) for array in old], axis=0)
            for index, current in enumerate(arrays[8:]):
                error = np.max(np.abs(current.astype('f8').reshape(60, -1) - total / 8), axis=1)
                with np.errstate(divide='ignore', invalid='ignore'):
                    ratios = np.where(envelope > 0, error / envelope, np.where(error > 0, np.inf, 0.))
                saved = group['control_statistics'][index][key]
                values = {'substeps': 60, 'legacy_runs': 8, 'reconstruction_runs': 1,
                          'legacy_spread_max': float(envelope.max()), 'reconstruction_error_max': float(error.max()),
                          'substeps_within_spread': int(np.count_nonzero(error <= envelope)),
                          'ratio_median': float(np.median(ratios)), 'ratio_max': float(ratios.max())}
                assert all(saved[name] == value for name, value in values.items())
                for frame, checkpoint in saved['checkpoints'].items():
                    i = int(frame)
                    assert checkpoint == {'legacy_spread': float(envelope[i]), 'reconstruction_error': float(error[i]),
                                          'ratio': float(ratios[i])}
                passed[index] &= bool(np.all(error <= envelope))
                indices = np.flatnonzero(error > envelope)
                if len(indices):
                    frame = int(indices[0])
                    outside.append({'control': index, 'field': key, 'first_frame': frame,
                                    'error': float(error[frame]), 'spread': float(envelope[frame])})
        assert passed == group['control_C8_passed']
        rows.append({'label': group['label'], 'control_C8_passed': passed, 'first_outside': outside})
assert len(rows) == 12
path = BASE / 'sdk-heldout3-independent-cpu.json'
assert not path.exists()
path.write_text(json.dumps({'groups': rows, 'all_statistics_reproduced': True, 'input_sha256': hashes,
    'control_passed_counts': [sum(row['control_C8_passed'][i] for row in rows) for i in range(3)],
    'controls_added_to_original_cohort': False, 'source_failures_rejudged': False, 'GPU_used': False,
    'whole_solver_complete': False}, indent=2) + '\n')
print('SDK held-out independent CPU passed group counts',
      [sum(row['control_C8_passed'][i] for row in rows) for i in range(3)], '/12 each; source failures unchanged')
