"""Independently audit all raw 60-frame fixed cohorts and locate each source run's first outside-spread frame."""
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
root = BASE / 'graph-fixed-C8'
plan = json.loads((root / 'plan.json').read_text())
terminal = json.loads((root / 'status.json').read_text())
report = json.loads((root / 'report.json').read_text())
assert terminal['complete'] and len(terminal['completed']) == 9
assert all(row['actual_exit'] == 0 for row in terminal['completed'])
assert plan['SDK_workers'] == 8 and plan['source_workers'] == 3 and plan['frames'] == 60
for path, sha in plan['input_sha256'].items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == sha, path
specifications = {case['label']: case for case in json.loads((BASE / 'discovery-v2/plan.json').read_text())['cases']}
rows, hashes = [], {}
for case in report['cases']:
    label, scene = case['label'], case['case']
    spec = specifications[scene]
    folder = root / 'cohorts' / label
    for backend in ('original', 'source'):
        path = folder / (backend + '0.npz')
        baseline = BASE / 'graph60-and-initcheck-v2/graph60' / (backend + '-' + scene + '-' + str(case['graph']) + '.npz')
        assert path.read_bytes() == baseline.read_bytes()
    first_pass, all_pass, outside = True, True, []
    with ExitStack() as stack:
        paths = [folder / f'{backend}{i}.npz' for backend, count in (('original', 8), ('source', 3)) for i in range(count)]
        arrays = [stack.enter_context(np.load(path, allow_pickle=False)) for path in paths]
        hashes.update({str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in paths})
        assert all(set(data.files) == set(arrays[0].files) for data in arrays)
        for key in arrays[0].files:
            values = [data[key] for data in arrays]
            assert all(value.dtype == values[0].dtype and value.shape == values[0].shape for value in values)
            assert values[0].shape[0] == 60 and all(np.isfinite(value).all() for value in values)
            envelopes, errors = [], []
            first_outside = set()
            for frame in range(60):
                old = [value[frame].astype('f8') for value in values[:8]]
                new = [value[frame].astype('f8') for value in values[8:]]
                total = np.zeros_like(old[0])
                for value in old:
                    total += value
                spread = max(float(np.max(np.abs(value - (total - value) / 7))) for value in old)
                delta = [np.abs(value - total / 8) for value in new]
                error = [float(np.max(value)) for value in delta]
                envelopes.append(spread)
                errors.append(error)
                for source_index in range(3):
                    if error[source_index] <= spread or source_index in first_outside:
                        continue
                    first_outside.add(source_index)
                    coordinate = tuple(int(i) for i in np.unravel_index(np.argmax(delta[source_index]), old[0].shape))
                    world = None
                    if key.startswith('particle_'):
                        world = coordinate[0] // (spec['width'] ** 3 + 4 * spec['bodies'])
                    elif key.startswith('body_'):
                        world = coordinate[0] // spec['bodies']
                    outside.append({'field': key, 'source_index': source_index, 'first_frame': frame,
                                    'max_error_coordinate': coordinate, 'world': world,
                                    'source_error': error[source_index], 'SDK_spread': spread})
            envelope = np.asarray(envelopes)
            errors = np.asarray(errors)
            for name, curve in (('source0_statistics', errors[:, 0]), ('all3_statistics', errors.max(axis=1))):
                saved = case[name][key]
                with np.errstate(divide='ignore', invalid='ignore'):
                    ratios = np.where(envelope > 0, curve / envelope, np.where(curve > 0, np.inf, 0.))
                assert saved['substeps'] == 60 and saved['legacy_runs'] == 8
                assert saved['reconstruction_runs'] == (1 if name == 'source0_statistics' else 3)
                assert saved['legacy_spread_max'] == float(envelope.max())
                assert saved['reconstruction_error_max'] == float(curve.max())
                assert saved['substeps_within_spread'] == int((curve <= envelope).sum())
                assert saved['ratio_max'] == float(ratios.max()) and saved['ratio_median'] == float(np.median(ratios))
                for frame, checkpoint in saved['checkpoints'].items():
                    i = int(frame)
                    assert checkpoint == {'legacy_spread': float(envelope[i]),
                                          'reconstruction_error': float(curve[i]), 'ratio': float(ratios[i])}
            first_pass &= bool(np.all(errors[:, 0] <= envelope))
            all_pass &= bool(np.all(errors <= envelope[:, None]))
    assert first_pass == case['fixed_source0_within_C8'] and all_pass == case['all3_sources_within_C8']
    rows.append({'label': label, 'fixed_source0_within_C8': first_pass, 'all3_sources_within_C8': all_pass,
                 'every_frame_and_report_statistic_reproduced': True, 'first_outside_frames': outside})
assert len(rows) == 12
result = {'cases': rows, 'fixed_source0_passed_groups': sum(row['fixed_source0_within_C8'] for row in rows),
          'all3_passed_groups': sum(row['all3_sources_within_C8'] for row in rows), 'total_groups': 12,
          'input_sha256': hashes, 'GPU_used': False, 'first_samples_replaced': False,
          'all_acceptance_passed': all(row['all3_sources_within_C8'] for row in rows), 'whole_solver_complete': False,
          'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(BASE / 'graph-fixed-C8-cpu-audit.json').write_text(json.dumps(result, indent=2) + '\n')
print('Long C8 independently reproduced: first source', result['fixed_source0_passed_groups'],
      '/12; all three', result['all3_passed_groups'], '/12')
