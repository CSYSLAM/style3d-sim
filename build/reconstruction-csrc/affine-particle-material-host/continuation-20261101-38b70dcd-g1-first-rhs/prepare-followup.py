"""Freeze SDK spring isolation and all scalar targets only after the real operand probes pass."""
import hashlib
import json
from pathlib import Path

import numpy as np

PARENT = Path(__file__).resolve().parent
BASE = PARENT / 'atomic'
plan = json.loads((BASE / 'plan.json').read_text())
report_path = BASE / 'replay/report.json'
report = json.loads(report_path.read_text())
assert report['complete'] and report['all_per_thread_per_target_operand_sequences_equal']
assert json.loads((BASE / 'probe-independent-cpu-audit.json').read_text())['all_recorded_thread_sequences_equal']
hashes = dict(plan['input_sha256'])
paths = [report_path, BASE / 'plan.json', BASE / 'probe-independent-cpu-audit.json']
paths.extend((BASE / 'replay').glob('*.npz'))
all_outputs, raw_cases = [], []
for side, label in [('original', 'sdk0'), ('source', 'rebuilt0')]:
    path = BASE / side / 'joint-packets/frame-00.npz'
    with np.load(path, allow_pickle=False) as saved:
        all_outputs.append(saved['after-arg-10'].view('<u4').copy())
        raw = {key: saved[key].tobytes() for key in saved.files if key.startswith('before-arg-')}
        raw.update({str(i): saved['parameter-' + str(i)].tobytes() for i in (9, 11, 12, 13, 14)})
        raw_cases.append(raw)
    path = PARENT / 'replay' / (label + '-joint.npz')
    paths.append(path)
    with np.load(path, allow_pickle=False) as saved:
        all_outputs.extend(saved[tag + '-output-10'].view('<u4').copy()
                           for tag in ('original-runtime', 'original-ptx', 'source-ptx'))
    with np.load(BASE / 'replay' / ('joint-' + side + '-frame-00.npz'), allow_pickle=False) as saved:
        all_outputs.extend(saved[tag + '-probe-output-10'].view('<u4').copy() for tag in ('original', 'source'))
assert raw_cases[0] == raw_cases[1], 'The two first-joint calls must really share every input, including scalar bytes'
targets = [sorted({int(array[i]) for array in all_outputs}) for i in range(528)]
packets = [{'side': side, 'frame': 0, 'targets': targets} for side in ('original', 'source')]
for path in paths:
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
shared = {'input_sha256': hashes, 'replay_report_sha256': hashlib.sha256(report_path.read_bytes()).hexdigest(),
          'production_changed': False, 'whole_solver_complete': False}
isolation = {**shared, 'initial_output_bits': [0, 2147483648], 'expected_calls': 1032}
certification = {**shared, 'packets': packets,
                 'unique_scalar_certificates': sum(len(words) for case in packets for words in case['targets']),
                 'all_actual_operands_and_signed_zeros_retained': True, 'per_scalar_legal_orders_only': True}
for name, value in [('isolation-plan.json', isolation), ('certification-plan.json', certification)]:
    path = BASE / name
    assert not path.exists()
    path.write_text(json.dumps(value, indent=2) + '\n')
print('Fixed1032 SDK/PTX/source isolated calls and', certification['unique_scalar_certificates'], 'GPU scalar targets')
