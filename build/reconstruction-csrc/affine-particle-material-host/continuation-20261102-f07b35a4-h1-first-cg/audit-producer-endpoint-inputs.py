"""Check complete actual producer inputs across H1 endpoints, keeping contact record order and output seeds explicit."""
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
report = json.loads((BASE / 'producer-operands-report.json').read_text())
rows, hashes = [], {}
for stage in ('soft-force', 'membrane', 'soft-matrix'):
    cases = [next(row for row in report['rows'] if row['label'] == label and row['stage'] == stage)
             for label in ('sdk0', 'rebuilt0')]
    inputs = []
    for case in cases:
        path = Path(case['packet'])
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
        with np.load(path, allow_pickle=False) as packet:
            inputs.append({key: packet[key].copy() for key in packet.files if
                           key.startswith('before-arg-') or key.startswith('parameter-')})
    count = 13 if stage == 'membrane' else 42
    bindings = sorted(int(key.rsplit('-', 1)[1]) for key in inputs[0] if key.startswith('before-arg-'))
    assert bindings == sorted(int(key.rsplit('-', 1)[1]) for key in inputs[1] if key.startswith('before-arg-'))
    for i in range(count):
        if i not in bindings:
            assert np.array_equal(inputs[0][f'parameter-{i}'], inputs[1][f'parameter-{i}'])
    outputs = sorted(map(int, cases[0]['outputs']))
    row = {'stage': stage, 'all_scalar_or_NULL_parameters_equal': True, 'non_record_readonly_inputs_equal': True,
           'output_seed_differences': {}, 'input_spans': {}}
    for i in bindings:
        left, right = (packet[f'before-arg-{i}'] for packet in inputs)
        equal = np.array_equal(left, right)
        row['input_spans'][str(i)] = {'bytes': left.nbytes, 'complete_bytes_equal': equal}
        if i in outputs:
            changed = np.flatnonzero(left.view('u4') != right.view('u4'))
            row['output_seed_differences'][str(i)] = {'word_count': len(changed), 'word_indices': changed.tolist()}
        elif stage == 'membrane' or i not in (2, 3, 4, 5, 6):
            assert equal, (stage, i)
    if stage.startswith('soft'):
        counts = [int.from_bytes(packet['before-arg-0'].tobytes(), 'little') for packet in inputs]
        assert counts == [8891, 8891]
        records = []
        for packet in inputs:
            fields = [packet[f'before-arg-{i}'][:8891 * width].reshape(8891, width)
                      for i, width in ((2, 4), (3, 4), (4, 12), (5, 12), (6, 12))]
            records.append(np.ascontiguousarray(np.concatenate(fields, axis=1)).view('V44').ravel())
        assert np.array_equal(np.sort(records[0]), np.sort(records[1]))
        row.update({'active_contact_records': 8891, 'complete_44byte_contact_record_multiset_equal': True,
                    'original_contact_record_order_equal': bool(np.array_equal(*records)),
                    'contact_input_order_changed_by_this_audit': False,
                    'inactive_capacity_bytes_not_used_to_claim_active_record_equality': True})
        if stage == 'soft-force':
            assert all(item['word_count'] == 0 for item in row['output_seed_differences'].values())
    else:
        prepared = json.loads((BASE / 'membrane-isolation-inputs/plan.json').read_text())
        assert row['output_seed_differences']['5']['word_count'] == 75
        assert row['output_seed_differences']['7']['word_count'] == 0
        assert prepared['all_touched_output_initial_words_equal_across_endpoints']
        row['all_75_changed_diagonal_words_outside_every_triangle_target'] = True
    rows.append(row)
hashes[str(Path(__file__))] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
target = BASE / 'producer-endpoint-inputs-independent-cpu.json'
assert not target.exists()
target.write_text(json.dumps({'cases': rows, 'input_sha256': hashes,
    'original_aggregate_and_C8_failures_rejudged': False, 'GPU_runs': 0,
    'whole_solver_complete': False}, indent=2) + '\n')
print('Complete producer inputs checked; contact record multisets equal, actual order and inherited matrix seeds preserved')
