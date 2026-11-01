"""Independently recompute all three frames of the fixed eight/three cohorts from their raw state arrays."""
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
cohort = BASE / 'fixed-C8'
plan = json.loads((cohort / 'plan.json').read_text())
terminal = json.loads((cohort / 'status.json').read_text())
report = json.loads((cohort / 'report.json').read_text())
assert terminal['complete'] and len(terminal['completed']) == 18
assert all(row['actual_exit'] == 0 for row in terminal['completed'])
assert plan['SDK_runs'] == 8 and plan['source_runs'] == 3
for path, sha in plan['input_sha256'].items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == sha, path
rows = []
for case in report['cases']:
    label = case['case']
    folder = cohort / label
    assert (folder / 'source0.npz').read_bytes() == (BASE / 'candidate-captures' / label / 'capture.npz').read_bytes()
    assert (folder / 'original0.npz').read_bytes() == (BASE / 'discovery-v2' / label / 'original/capture.npz').read_bytes()
    frame_results = {}
    with ExitStack() as stack:
        originals = [stack.enter_context(np.load(folder / f'original{i}.npz')) for i in range(8)]
        sources = [stack.enter_context(np.load(folder / f'source{i}.npz')) for i in range(3)]
        assert set(originals[0].files) == {'particle_q', 'particle_qd', 'body_q', 'body_qd'}
        for key in originals[0].files:
            arrays = [data[key] for data in originals + sources]
            assert all(value.dtype == arrays[0].dtype and value.shape == arrays[0].shape for value in arrays)
            assert arrays[0].shape[0] == 3 and all(np.isfinite(value).all() for value in arrays)
            frames = []
            for frame in range(3):
                old = [data[key][frame].astype('f8') for data in originals]
                new = [data[key][frame].astype('f8') for data in sources]
                total = np.zeros_like(old[0])
                for value in old:
                    total += value
                spread = max(float(np.max(np.abs(value - (total - value) / 7))) for value in old)
                errors = [float(np.max(np.abs(value - total / 8))) for value in new]
                expected = (case['source0_statistics'][key]['checkpoints'][str(frame)],
                            case['all3_statistics'][key]['checkpoints'][str(frame)])
                for saved, actual in zip(expected, (errors[0], max(errors))):
                    ratio = actual / spread if spread else (float('inf') if actual else 0.)
                    assert saved == {'legacy_spread': spread, 'reconstruction_error': actual, 'ratio': ratio}
                frames.append({'frame': frame, 'SDK_leave_one_out_spread': spread,
                               'source_errors': errors, 'all_sources_within': max(errors) <= spread})
            frame_results[key] = frames
    first_pass = all(row['source_errors'][0] <= row['SDK_leave_one_out_spread']
                     for frames in frame_results.values() for row in frames)
    all_pass = all(row['all_sources_within'] for frames in frame_results.values() for row in frames)
    assert first_pass == case['fixed_source0_within_C8'] and all_pass == case['all3_sources_within_C8']
    rows.append({'case': label, 'fixed_source0_within_C8': first_pass, 'all3_sources_within_C8': all_pass,
                 'every_saved_checkpoint_reproduced': True, 'raw_frames': frame_results})
result = {'cases': rows, 'source0_replaced': False, 'cohort_expanded': False, 'GPU_used': False,
          'whole_solver_complete': False, 'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(BASE / 'fixed-C8-cpu-audit.json').write_text(json.dumps(result, indent=2) + '\n')
print('Independent C8 audit:', [(row['case'], row['all3_sources_within_C8']) for row in rows])
