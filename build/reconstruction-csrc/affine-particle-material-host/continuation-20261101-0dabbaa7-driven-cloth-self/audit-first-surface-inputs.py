"""Audit all meaningful paired surface inputs, complete first RHS outputs and the actual three-backend replays."""
import hashlib
import json
from pathlib import Path
import re

import numpy as np

BASE = Path(__file__).resolve().parent
plan = json.loads((BASE / 'first-surface-inputs/plan.json').read_text())
replay_status = json.loads((BASE / 'first-surface-replays/status.json').read_text())
assert replay_status['complete'] and all(row['actual_exit'] == 0 for row in replay_status['completed'])
hashes = dict(plan['input_sha256'])
hashes[str(Path(__file__))] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
rows, isolated_calls, operands = [], 0, 0
for case in plan['cases']:
    inputs = [BASE / 'first-surface-inputs' / case['name'] / side for side in ('original', 'source')]
    fields = json.loads((inputs[0] / 'fields.json').read_text())
    count = int(np.fromfile(inputs[0] / 'dump_30evaluate_surface_contact_force_pre_arg0.bin', dtype='<i4')[0])
    assert count == 66
    compared = []
    for off, (name, size) in fields.items():
        suffix = '_offset' + off if int(off) else ''
        values = [(p / ('dump_30evaluate_surface_contact_force_pre_arg0' + suffix + '.bin')).read_bytes() for p in inputs]
        assert len(values[0]) == len(values[1]) == size
        width = {16: 12, 24: 12, 32: 4, 40: 12, 48: 12, 56: 12}.get(int(off))
        if width:
            values = [value[:count * width] for value in values]
        assert values[0] == values[1], (case['name'], name)
        compared.append({'offset': int(off), 'name': name, 'meaningful_bytes': len(values[0])})
    rhs = []
    for side, directory in zip(('original', 'source'), inputs):
        initial = (directory / 'dump_14initialize_rhs_post_arg9.bin').read_bytes()
        before = (directory / 'dump_30evaluate_surface_contact_force_pre_arg1.bin').read_bytes()
        after = (directory / 'dump_30evaluate_surface_contact_force_post_arg1.bin').read_bytes()
        assert initial == before and len(before) == len(after) == 576
        rhs.append((before, after))
        replay = BASE / 'first-surface-replays' / case['name'] / side
        report = json.loads((replay / 'report.json').read_text())
        recorded = json.loads((replay / 'atomic-operands.json').read_text())
        assert recorded['original']['thread_operands'] == recorded['source']['thread_operands']
        assert report['contacts'] == count and report['actual_atomic_operands'] == 2124
        assert report['all_isolated_contact_outputs_equal']
        with np.load(replay / 'outputs.npz', allow_pickle=False) as data:
            assert data['before'].tobytes() == before and data['captured_after'].tobytes() == after
            reference = data['original-runtime-isolated']
            assert reference.shape == (66, 144)
            assert reference.tobytes() == data['original-ptx-isolated'].tobytes()
            assert reference.tobytes() == data['source-ptx-isolated'].tobytes()
            assert all(not report['aggregate_matches_captured'][backend] for backend in
                       ('original-runtime', 'original-ptx', 'source-ptx'))
        isolated_calls += count * 3
        operands += sum(map(len, recorded['original']['thread_operands']))
        for folder in (directory, replay):
            for path in folder.glob('*'):
                if path.is_file():
                    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    assert rhs[0][0] == rhs[1][0] and rhs[0][1] != rhs[1][1]
    rows.append({'case': case['name'], 'all25_meaningful_inputs_equal': compared,
                 'complete_rhs_initial_and_before_equal': True, 'complete_surface_after_differs': True,
                 'same_input_aggregate_replay_does_not_reproduce_captured_output': True})
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
record = {'cases': rows, 'isolated_three_backend_calls': isolated_calls,
          'original_source_equal_recorded_operands_per_side': operands, 'input_sha256': hashes,
          'GPU_used': False, 'late_large_trajectory_error_explained': False,
          'old_source0_replaced': False, 'whole_solver_complete': False}
(BASE / 'first-surface-independent-cpu.json').write_text(json.dumps(record, indent=2) + '\n')
print('CPU:both25-field inputs/RHS same;792 SDK/PTX/source isolated contacts strict;8496 operands per side equal')
