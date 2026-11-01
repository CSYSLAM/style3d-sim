"""Freeze SDK per-spring isolation and all authentic joint scalar targets before followup GPU execution."""
import ast
from collections import Counter
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT = Path.cwd()
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.g1_drive_load_isolated import rendered_source as isolation_source
from reconstruction.csrc.g1_drive_load_certificates import rendered_source as certificate_source

BASE = Path(__file__).resolve().parent
assert not (BASE / 'isolation-plan.json').exists() and not (BASE / 'certification-plan.json').exists()
report_path = BASE / 'replay/report.json'
replay = json.loads(report_path.read_text())
audit = json.loads((BASE / 'independent-cpu-audit.json').read_text())
assert not audit['all_complete_outputs_strict'] and replay['all_per_thread_per_target_operand_sequences_equal']
assert replay['all_complete_thread_sequences_equal'] and replay['all_unwritten_bytes_unchanged']
hashes = dict(json.loads((BASE / 'plan.json').read_text())['input_sha256'])
for kind, text in [('isolation', isolation_source()), ('certificates', certificate_source())]:
    ast.parse(text)
    assert all(len(line) <= 128 for line in text.splitlines()), kind
    path = BASE / (kind + '-template.py')
    assert not path.exists()
    path.write_text(text)
paths = [Path(__file__), BASE / 'atomic-followup-cpu-audit.py', BASE / 'isolation-template.py',
         BASE / 'certificates-template.py', BASE / 'independent-cpu-audit.json', report_path,
         ROOT / 'reconstruction/csrc/g1_drive_load_isolated.py',
         ROOT / 'reconstruction/csrc/g1_drive_load_certificates.py']
packets, term_counts = [], Counter()
for row in replay['packets']:
    if row['stage'] != 'drive':
        continue
    side, frame = row['side'], row['frame']
    capture = BASE / side / 'drive-packets' / f'frame-{frame:02d}.npz'
    actual = BASE / 'replay' / f'drive-{side}-frame-{frame:02d}.npz'
    paths.extend((capture, actual))
    with np.load(capture, allow_pickle=False) as source, np.load(actual, allow_pickle=False) as values:
        targets = [{int(word)} for word in source['after-arg-26'].view('<u4')]
        assert len(targets) == 528
        for check in row['checks']:
            output = values[check['backend'] + '-output-26'].view('<u4')
            for target, word in zip(targets, output):
                target.add(int(word))
        seen, cursor = [set() for _ in range(528)], 0
        for lane, count in enumerate(values['original-counts']):
            per_lane = set()
            for record in values['original-records'][cursor:cursor + count]:
                address = int.from_bytes(record[:8].tobytes(), 'little')
                scalar = (address - row['actual_output_replay_addresses']['26']) // 4
                assert scalar not in per_lane
                per_lane.add(scalar)
                seen[scalar].add(lane)
            cursor += int(count)
        assert cursor == len(values['original-records'])
        term_counts.update(map(len, seen))
        assert max(map(len, seen)) <= 8
        packets.append({'side': side, 'frame': frame, 'targets': [sorted(target) for target in targets]})
assert len(packets) == 120
for path in paths:
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
common = {'replay_report_sha256': hashlib.sha256(report_path.read_bytes()).hexdigest(), 'input_sha256': hashes,
          'production_changed': False, 'frozen_failure_reclassified': False, 'whole_solver_complete': False}
isolation = {**common, 'initial_output_bits': [0, 2147483648], 'expected_calls': 30960,
             'count': 1, 'drives_per_world': 1, 'global_body_DOF_target_arrays_unchanged': True,
             'dofs_per_world': 49, 'targets_per_world': 49, 'particle_world_width': 176}
certificates = {**common, 'packets': packets, 'per_scalar_legal_orders_only': True,
                'all_actual_operands_including_signed_zero_retained': True, 'authentic_initial_used': True,
                'unique_scalar_certificates': sum(len(target) for packet in packets for target in packet['targets']),
                'max_terms_per_scalar': max(term_counts), 'term_count_histogram': dict(term_counts)}
(BASE / 'isolation-plan.json').write_text(json.dumps(isolation, indent=2) + '\n')
(BASE / 'certification-plan.json').write_text(json.dumps(certificates, indent=2) + '\n')
print('Frozen', isolation['expected_calls'], 'actual SDK/PTX/source isolated calls and',
      certificates['unique_scalar_certificates'], 'GPU scalar certificates', flush=True)
