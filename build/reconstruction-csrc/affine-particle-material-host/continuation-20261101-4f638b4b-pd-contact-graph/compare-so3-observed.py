"""Locate semantic differences between the newly observed runs without adopting them as frozen failures."""
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
capture = BASE / 'so3-captures'
hashes, comparisons = {}, []
fields = {'before-arg-0': ('<f4', (36, 3)), 'before-arg-1': ('<i4', (3, 4)),
          'before-arg-2': ('<f4', (3, 3, 3)), 'before-arg-3': ('<f4', (3, 3, 3)),
          'after-arg-2': ('<f4', (3, 3, 3)), 'after-arg-3': ('<f4', (3, 3, 3))}
for source in (1, 2, 3):
    first = {}
    unequal_packets, counts = 0, {key: 0 for key in fields}
    for frame in range(60):
        for stage in ('initialize', 'update-1', 'update-2', 'update-3'):
            name = f'{stage}-frame-{frame:02d}.npz'
            paths = [capture / str(w) / f'so3-graph-{frame % 2}/packets' / name for w in (0, source)]
            hashes.update({str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in paths})
            with np.load(paths[0]) as left, np.load(paths[1]) as right:
                different = False
                for field, (dtype, shape) in fields.items():
                    if stage == 'initialize' and field in ('before-arg-2', 'before-arg-3'):
                        continue
                    a, b = left[field], right[field]
                    if a.tobytes() == b.tobytes():
                        continue
                    different = True
                    counts[field] += 1
                    if field not in first:
                        x, y = a.view(dtype).reshape(shape), b.view(dtype).reshape(shape)
                        word_x, word_y = a.view('<u4').reshape(shape), b.view('<u4').reshape(shape)
                        at = tuple(int(i) for i in np.argwhere(word_x != word_y)[0])
                        first[field] = {'frame': frame, 'stage': stage, 'index_in_storage_order': at,
                                        'SDK_bits': int(word_x[at]), 'source_bits': int(word_y[at]),
                                        'SDK_value': float(x[at]), 'source_value': float(y[at])}
                unequal_packets += different
    comparisons.append({'source_worker': source, 'paired_packets': 240, 'unequal_packets': unequal_packets,
                        'per_field_differing_packet_counts': counts, 'first_per_field': first})
result = {'comparisons': comparisons, 'input_sha256': hashes, 'GPU_used': False,
          'matrix_storage_order': 'body, column, row', 'initializer_before_history_not_semantically_compared': True,
          'observed_runs_are_not_original_frozen_source0': True, 'cause_of_frozen_failure_claimed': False,
          'fixed_C8_reclassified': False, 'whole_solver_complete': False}
(BASE / 'so3-observed-differences.json').write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps(comparisons, indent=2))
