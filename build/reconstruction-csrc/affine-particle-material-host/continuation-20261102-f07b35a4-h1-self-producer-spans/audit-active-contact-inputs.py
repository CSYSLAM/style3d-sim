"""Check all observed active contact records, their same-endpoint links and every actually referenced cache element."""
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
folder = BASE / 'full-inputs'
assert json.loads((folder / 'run.status.json').read_text())['complete']
plan = json.loads((folder / 'plan.json').read_text())
hashes, endpoints, rows = {}, {}, []
with np.load(BASE / 'sdk0/static-topology.npz', allow_pickle=False) as static:
    edge_values = static['edges'].view('i4')
    active = np.unique(np.concatenate([static['mesh-vertices'].view('i4'), static['triangles'].view('i4'),
                                      edge_values[edge_values >= 0], static['opposite-vertices'].view('i4')]))
assert len(active) == 33703 and active.min() >= 0 and active.max() < 33887
for run in plan['runs']:
    endpoint, previous, current = run['label'], None, {}
    layout = json.loads((folder / endpoint / 'trace/snapshot-layout.json').read_text())
    for stage in layout['stages']:
        path = folder / endpoint / 'trace' / (stage['key'] + '-packets/frame-00.npz')
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
        span = stage['dynamic_contact_span']
        contact, counter = span['argument'], span['counter_argument']
        with np.load(path, allow_pickle=False) as packet:
            data = {key: packet[key].copy() for key in packet.files}
        before = int.from_bytes(data[f'before-arg-{counter}'].tobytes(), 'little')
        after = int.from_bytes(data.get(f'after-arg-{counter}', data[f'before-arg-{counter}']).tobytes(), 'little')
        first = data[f'before-arg-{contact}']
        last = data.get(f'after-arg-{contact}', first)
        assert 0 <= before <= after <= 131072
        if previous is not None:
            assert before == previous[0] and np.array_equal(first, previous[1])
        else:
            assert stage['key'] == 'vf' and before == 0
        assert np.array_equal(first[:before * 60], last[:before * 60])
        assert np.array_equal(first[after * 60:], last[after * 60:])
        typed = last[:after * 60].view('u4').reshape(-1, 15)
        assert np.isin(typed[:, 14], [4, 5]).all()
        for record in typed:
            arity = int(record[14])
            assert np.isin(record[:arity].view('i4'), active).all()
            assert np.isfinite(record[5:5 + arity].view('f4')).all()
            assert np.isfinite(record[10:14].view('f4')).all()
        previous = (after, last)
        current[stage['key']] = {'data': data, 'before': before, 'after': after,
                                 'new_records': last[before * 60:after * 60].copy().view('V60').ravel(),
                                 'all_records': last[:after * 60].copy().view('V60').ravel()}
    assert [(current[key]['before'], current[key]['after']) for key in ('vf', 'ee', 'ef', 'tangent')] == [
        (0, 2168), (2168, 7423), (7423, 7423), (7423, 7423)]
    endpoints[endpoint] = current
for stage, cache in [('vf', 6), ('ee', 6), ('ef', 7)]:
    a, b = endpoints['sdk0'][stage], endpoints['rebuilt0'][stage]
    raw_records_equal = np.array_equal(np.sort(a['new_records']), np.sort(b['new_records']))
    cache_a, cache_b = (row['data'][f'before-arg-{cache}'].view('u4') for row in (a, b))
    changed = np.flatnonzero(cache_a != cache_b)
    assert not len(np.intersect1d(changed, active))
    assert np.array_equal(cache_a[active], cache_b[active])
    rows.append({'stage': stage, 'new_records': len(a['new_records']),
                 'complete_60byte_new_record_multisets_equal': raw_records_equal,
                 'all_new_records_equal_including_inactive_struct_fields': raw_records_equal,
                 'cache_different_words': changed.tolist(), 'all_differences_outside_referenced_particle_indices': True})
all_records_equal = np.array_equal(np.sort(endpoints['sdk0']['tangent']['all_records']),
                                  np.sort(endpoints['rebuilt0']['tangent']['all_records']))
target = BASE / 'active-contact-inputs-independent-cpu.json'
assert not target.exists()
hashes[str(Path(__file__))] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
target.write_text(json.dumps({'cases': rows, 'input_sha256': hashes,
    'active_particle_indices': active.tolist(), 'all_valid_contact_ids_within_actual_mesh_topology': True,
    'all_stage_contact_prefix_links_byte_equal': True, 'all_actual_contact_record_counters': [0, 2168, 7423, 7423],
    'all_7423_contact_record_multisets_equal': all_records_equal,
    'EF_has_zero_new_active_records_and_active_EF_arithmetic_not_claimed': True,
    'GPU_runs': 0, 'whole_solver_complete': False}, indent=2) + '\n')
print('Active self contact input audit:', rows, '; all7423 complete records multisets equal:', all_records_equal)
