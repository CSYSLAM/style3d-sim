"""Record exact common-start inputs and the force difference already present before the first drive call."""
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
plan = json.loads((BASE / 'plan.json').read_text())
assert json.loads((BASE / 'run.status.json').read_text())['complete']
data, hashes = {}, {}
for run in plan['runs']:
    path = BASE / run['label'] / 'trace/drive0-packets/frame-00.npz'
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    with np.load(path, allow_pickle=False) as packet:
        data[run['label']] = {i: packet['before-arg-' + str(i)].copy() for i in range(27)}
groups = {}
for i in range(27):
    by_digest = {}
    for label, packet in data.items():
        digest = hashlib.sha256(packet[i].tobytes()).hexdigest()
        by_digest.setdefault(digest, []).append(label)
    groups[str(i)] = list(by_digest.values())
sdk = data['sdk0'][26].view('<u4')
assert all(np.array_equal(data['sdk' + str(i)][26].view('<u4'), sdk) for i in range(8))
assert all(len(groups[str(i)]) == 1 for i in range(26))
differences = {}
for run in plan['runs'][8:]:
    label = run['label']
    actual = data[label][26].view('<u4')
    indices = np.flatnonzero(sdk != actual)
    sdk_f, actual_f = sdk.view('<f4'), actual.view('<f4')
    differences[label] = {
        'bitwise_components_different': len(indices),
        'numeric_components_different': int(np.count_nonzero(sdk_f != actual_f)),
        'max_abs_difference': float(np.abs(sdk_f.astype('f8') - actual_f.astype('f8')).max()),
        'components': [{'flat': int(i), 'particle': int(i // 3), 'component': int(i % 3),
                        'SDK_bits': int(sdk[i]), 'source_bits': int(actual[i]),
                        'SDK_value': float(sdk_f[i]), 'source_value': float(actual_f[i])} for i in indices],
    }
result = {'first_call_rank': 31, 'all_first26_inputs_bitwise_equal': True,
          'all8_SDK_initial_force_buffers_bitwise_equal': True,
          'input_groups': groups, 'force_before_first_drive_differences': differences,
          'input_sha256': hashes, 'difference_origin_not_yet_localized_before_rank31': True,
          'cause_of_later_large_response_not_proven': True,
          'old_C8_reclassified': False, 'production_changed': False, 'whole_solver_complete': False}
output = BASE / 'first-force-context.json'
assert not output.exists()
output.write_text(json.dumps(result, indent=2) + '\n')
print('All first26 inputs equal; first force-before differences:',
      {label: (row['bitwise_components_different'], row['max_abs_difference'])
       for label, row in differences.items()})
