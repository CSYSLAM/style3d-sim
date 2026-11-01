"""Keep every out-of-envelope frame and its exact component for the current immutable G1 cohort."""
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path

import numpy as np

base = Path(__file__).resolve().parent
report_path = base / 'graph60-fixed-original-C8/report.json'
report = json.loads(report_path.read_text())
rows, worst = [], {}
with ExitStack() as stack:
    originals = [stack.enter_context(np.load(report['input_npz_paths'][f'original{i}'])) for i in range(8)]
    sources = [stack.enter_context(np.load(report['input_npz_paths'][f'source{i}'])) for i in range(3)]
    for key in originals[0].files:
        a = np.asarray([run[key] for run in originals], dtype='f8')
        original = a.reshape(8, 60, -1)
        total = original.sum(axis=0)
        envelope = np.max(np.asarray([np.max(np.abs(original[i] - (total - original[i]) / 7), axis=1)
                                      for i in range(8)]), axis=0)
        for index, source in enumerate(sources):
            values = source[key].astype('f8').reshape(60, -1)
            delta = np.abs(values - total / 8)
            error = delta.max(axis=1)
            with np.errstate(divide='ignore', invalid='ignore'):
                ratios = np.where(envelope > 0, error / envelope, np.where(error > 0, np.inf, 0.))
            for frame in np.flatnonzero(error > envelope):
                component = int(np.argmax(delta[frame]))
                rows.append({'source': index, 'field': key, 'frame': int(frame),
                             'error': float(error[frame]), 'spread': float(envelope[frame]),
                             'ratio': float(ratios[frame]), 'flat_component': component})
            worst[f'source{index}/{key}'] = {'within_frames': int(np.count_nonzero(error <= envelope)),
                'max_ratio_frame': int(np.argmax(ratios)), 'max_ratio': float(ratios.max()),
                'max_absolute_error': float(error.max())}
result = {'source_host_sha256': report['source_sha256'], 'public_core_sha256': report['public_core_sha256'],
          'outside': rows, 'worst': worst, 'outside_field_frames': len(rows), 'GPU_used': False,
          'frozen_candidate_replaced': False, 'whole_solver_complete': False,
          'report_sha256': hashlib.sha256(report_path.read_bytes()).hexdigest(),
          'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(base / 'current-outside-frames.json').write_text(json.dumps(result, indent=2) + '\n')
print('outside field/frames', len(rows))
for index in range(3):
    selected = [row for row in rows if row['source'] == index]
    print('source', index, 'first outside frame', min(row['frame'] for row in selected),
          'largest ratio', max(selected, key=lambda row: row['ratio']))
