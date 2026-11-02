"""Independently recompute all current three-frame C8 statistics while retaining every original failure."""
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
folder = BASE / 'short-fixed-C8'
plan = json.loads((folder / 'plan.json').read_text())
status = json.loads((folder / 'status.json').read_text())
report = json.loads((folder / 'report.json').read_text())
assert status['complete'] and status['running'] is None and len(status['completed']) == 4
assert all(row['actual_exit'] == 0 for row in status['completed'])
for name, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
hashes, rows = {}, []
for case in report['cases']:
    cohort = folder / 'cohorts' / case['case']
    assert (cohort / 'source0.npz').read_bytes() == (
        BASE / 'force-order-captures' / case['case'] / 'capture.npz').read_bytes()
    passed = [True] * 3
    outside = []
    with ExitStack() as stack:
        paths = [cohort / f'{backend}{i}.npz' for backend, count in [('original', 8), ('source', 3)] for i in range(count)]
        arrays = [stack.enter_context(np.load(path, allow_pickle=False)) for path in paths]
        hashes.update({str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in paths})
        assert all(set(data.files) == set(arrays[0].files) for data in arrays)
        for key in arrays[0].files:
            assert all(data[key].shape == arrays[0][key].shape and data[key].dtype == arrays[0][key].dtype for data in arrays)
            assert len(arrays[0][key]) == 3 and all(np.isfinite(data[key]).all() for data in arrays)
            original = np.asarray([data[key] for data in arrays[:8]], dtype='f8').reshape(8, 3, -1)
            total = np.zeros_like(original[0])
            for array in original:
                total += array
            envelope = np.max([np.max(np.abs(a - (total - a) / 7), axis=1) for a in original], axis=0)
            for index, source in enumerate(arrays[8:]):
                delta = np.abs(source[key].astype('f8').reshape(3, -1) - total / 8)
                errors = np.max(delta, axis=1)
                with np.errstate(divide='ignore', invalid='ignore'):
                    ratios = np.where(envelope > 0, errors / envelope, np.where(errors > 0, np.inf, 0.))
                saved = case['statistics'][index][key]
                values = {'substeps': 3, 'legacy_runs': 8, 'reconstruction_runs': 1,
                          'substeps_within_spread': int(np.count_nonzero(errors <= envelope)),
                          'legacy_spread_max': float(envelope.max()), 'reconstruction_error_max': float(errors.max()),
                          'ratio_median': float(np.median(ratios)), 'ratio_max': float(ratios.max())}
                assert all(saved[name] == value for name, value in values.items())
                for frame, checkpoint in saved['checkpoints'].items():
                    i = int(frame)
                    assert checkpoint == {'legacy_spread': float(envelope[i]), 'reconstruction_error': float(errors[i]),
                                          'ratio': float(ratios[i])}
                passed[index] &= bool(np.all(errors <= envelope))
                for frame in np.flatnonzero(errors > envelope):
                    outside.append({'source': index, 'field': key, 'frame': int(frame),
                                    'flat_component': int(np.argmax(delta[frame])),
                                    'error': float(errors[frame]), 'spread': float(envelope[frame])})
    assert passed == case['sources_within_C8'] == [False, False, False]
    rows.append({'case': case['case'], 'source_C8_passed': passed, 'outside': outside})
output = BASE / 'short-fixed-C8-independent-cpu.json'
assert not output.exists() and len(rows) == 2
output.write_text(json.dumps({'cases': rows, 'input_sha256': hashes, 'all_statistics_reproduced': True,
    'first_source0_replaced': False, 'new_SDK_runs': 0, 'GPU_runs': 0,
    'whole_solver_complete': False}, indent=2) + '\n')
print('Current C8 all statistics independently reproduced; both groups all3 false retained')
