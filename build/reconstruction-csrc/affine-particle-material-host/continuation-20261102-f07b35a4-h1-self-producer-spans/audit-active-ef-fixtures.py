"""Independently compare all saved actual native/PTX/source fixture inputs and complete outputs on CPU."""
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
folder = BASE / 'active-ef-fixtures'
terminal = json.loads((BASE / 'active-ef-fixtures.status.json').read_text())
assert terminal['complete'] and terminal['running'] is None
assert [row['actual_exit'] for row in terminal['completed']] == [0]
report = json.loads((folder / 'report.json').read_text())
assert report['complete'] and report['actual_GPU_calls'] == len(report['calls']) == 76
hashes, loaded, groups, active_records = {}, [], {}, {'ee': 0, 'ef': 0}
for call in report['calls']:
    path = Path(call['file'])
    digest = hashlib.sha256(path.read_bytes()).hexdigest()
    assert digest == call['sha256']
    hashes[str(path)] = digest
    with np.load(path, allow_pickle=False) as packet:
        data = {key: packet[key].copy() for key in packet.files}
    assert call['all_readonly_inputs_and_physical_guards_unchanged']
    for name in [key for key in data if key.startswith('before-')]:
        index = int(name.split('-')[1])
        if index not in call['output_indices']:
            assert np.array_equal(data[name], data[f'after-{index}'])
    if 'accumulate_edge' in call['symbol']:
        kind = 'ee' if 'accumulate_edge_edge' in call['symbol'] else 'ef'
        contact, counter = (11, 12) if kind == 'ee' else (12, 13)
        if f'after-{counter}' in data:
            used = int.from_bytes(data[f'after-{counter}'].tobytes(), 'little')
            assert used * 60 <= len(data[f'after-{contact}'])
            assert np.array_equal(data[f'after-{contact}'][used * 60:], data[f'before-{contact}'][used * 60:])
            records = data[f'after-{contact}'][:used * 60].view('u4').reshape(-1, 15)
            assert np.all(records[:, 14] == (4 if kind == 'ee' else 5))
            active_records[kind] += used
    loaded.append(data)
for index in range(0, 76, 2):
    a, b = report['calls'][index:index + 2]
    first, second = loaded[index:index + 2]
    assert a['mode'] == b['mode'] and a['side'] == a['mode'] and b['side'] == 'source'
    assert a['symbol'] == b['symbol'] and a['geometry'] == b['geometry'] and a['output_indices'] == b['output_indices']
    assert set(first) == set(second)
    for key in first:
        if key.startswith('before-'):
            assert np.array_equal(first[key], second[key])
        if key.startswith('parameter-'):
            arg = int(key.split('-')[1])
            if f'before-{arg}' not in first:
                assert np.array_equal(first[key], second[key])
    contact = 11 if 'accumulate_edge_edge' in a['symbol'] else 12 if 'accumulate_edge_face' in a['symbol'] else None
    for output in a['output_indices']:
        if output == contact:
            counter = contact + 1
            used = int.from_bytes(first[f'after-{counter}'].tobytes(), 'little')
            assert used == int.from_bytes(second[f'after-{counter}'].tobytes(), 'little')
            left = first[f'after-{contact}'][:used * 60].copy().view('V60').ravel()
            right = second[f'after-{contact}'][:used * 60].copy().view('V60').ravel()
            assert np.array_equal(np.sort(left), np.sort(right))
        else:
            assert np.array_equal(first[f'after-{output}'], second[f'after-{output}'])
    groups[a['mode']] = groups.get(a['mode'], 0) + 1
for index in range(38):
    first, second = loaded[index], loaded[index + 38]
    assert report['calls'][index]['symbol'] == report['calls'][index + 38]['symbol']
    for key in first:
        if key.startswith('before-'):
            assert np.array_equal(first[key], second[key])
assert groups == {'original-runtime': 19, 'original-ptx': 19} and active_records['ef'] > 0
for mode in ('original-runtime', 'original-ptx'):
    comparisons = report['comparisons'][mode + '-edge-branches']
    assert all(row['bitwise_equal'] for row in comparisons.values())
    assert comparisons['ef_k0.5_r0.03125_records1_records']['contacts'] > 0
    for grid in (1, 7, 256):
        entry = report['comparisons'][f'{mode}-tangent-grid{grid}']
        assert entry['bitwise_equal'] and entry['five_point_contacts'] > 0 and entry['four_point_contacts'] > 0
for path in (Path(__file__), folder / 'report.json', BASE / 'active-ef-fixtures.status.json'):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
target = BASE / 'active-ef-fixtures-independent-cpu.json'
assert not target.exists()
target.write_text(json.dumps({'actual_GPU_calls': 76, 'complete_output_pairs_verified': 38,
    'active_contact_records_in_saved_calls': active_records, 'input_sha256': hashes,
    'all_native_SDK_original_PTX_actual_source_outputs_strict': True,
    'EF_active_five_point_records_and_three_world_branch_fixtures_verified': True,
    'four_and_five_point_tangent_grid_strides_1_7_256_verified': True,
    'old_trajectory_or_aggregate_failures_rejudged': False, 'GPU_runs': 0, 'whole_solver_complete': False}, indent=2) + '\n')
print('Actual active EF/EE/five-point tangent outputs independently audited:', groups, active_records)
