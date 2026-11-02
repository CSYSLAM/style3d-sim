"""Rebuild every H1 static self-CSR entry from actual triangles and edges and check both SDK and source arrays."""
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
plan = json.loads((BASE / 'plan.json').read_text())
terminal = json.loads((BASE / 'run.status.json').read_text())
assert terminal['complete'] and terminal['running'] is None
assert [row['actual_exit'] for row in terminal['completed']] == [0, 0]
hashes = dict(plan['input_sha256'])
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
previous_arrays, rows = None, []
for run in plan['runs']:
    folder = BASE / run['label']
    report = json.loads((folder / 'span-report.json').read_text())
    runtime = json.loads((folder / 'worker/runtime.json').read_text())
    assert runtime['exit'] == 0 and runtime['public_core_abi'] and not runtime['ab_bridge_used']
    assert runtime['reference_solver_mapped'] == (run['backend'] == 'original')
    assert report['graph_nodes_added'] == report['GPU_allocations_added'] == report['physics_replays'] == 0
    assert report['initial_counter'] == 0
    assert report['reachable_tangent_records'] == (33703 + 2 * 100634) * 31 == 7284101
    assert report['reachable_tangent_bytes'] == 437046060
    for name, span in report['ranges'].items():
        assert span['backing_base'] <= span['address']
        assert span['address'] + span['logical_bytes'] <= span['backing_base'] + span['backing_bytes']
        assert span['read_bytes'] == (0 if name == 'tangent-full-reachable-capacity' else span['logical_bytes'])
    tangent = report['ranges']['tangent-full-reachable-capacity']
    assert tangent['provider'] == 'cuMemGetAddressRange_v2' and tangent['read_bytes'] == 0
    with np.load(folder / 'static-topology.npz', allow_pickle=False) as archive:
        arrays = {key: archive[key].copy() for key in archive.files}
    triangles = arrays['triangles'].view('i4').reshape(66930, 3)
    edges = arrays['edges'].view('i4').reshape(100634, 4)
    actual_offsets = arrays['opposite-offsets'].view('i4')
    actual_vertices = arrays['opposite-vertices'].view('i4')
    neighbors, vertices = {}, set()
    for triangle in triangles.tolist():
        vertices.update(triangle)
        for i in range(3):
            edge = tuple(sorted((triangle[(i + 1) % 3], triangle[(i + 2) % 3])))
            neighbors.setdefault(edge, set()).add(triangle[i])
    offsets, opposite = [0], []
    for edge in edges.tolist():
        vertices.update(edge[2:])
        values = set(neighbors.get(tuple(sorted(edge[2:])), set()))
        values.update(vertex for vertex in edge[:2] if vertex >= 0)
        opposite.extend(sorted(values))
        offsets.append(len(opposite))
    assert np.array_equal(arrays['mesh-vertices'].view('i4'), np.asarray(sorted(vertices), dtype='i4'))
    assert np.array_equal(actual_offsets, np.asarray(offsets, dtype='i4'))
    assert np.array_equal(actual_vertices, np.asarray(opposite, dtype='i4'))
    assert len(vertices) == 33703 and len(opposite) == report['opposite_vertices'] == 200790
    if previous_arrays is not None:
        assert set(arrays) == set(previous_arrays)
        assert all(np.array_equal(array, previous_arrays[key]) for key, array in arrays.items())
    previous_arrays = arrays
    rows.append({'backend': run['backend'], 'mesh_vertices': 33703, 'CSR_offsets': len(offsets),
                 'opposite_vertices': len(opposite), 'all_static_bytes_equal_and_CSR_rebuilt': True,
                 'real_tangent_backing_bytes': tangent['backing_bytes'],
                 'first_CG_tangent_consumer': report['first_CG_tangent_consumer']})
    for path in (folder / 'static-topology.npz', folder / 'span-report.json', folder / 'worker/runtime.json'):
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
hashes[str(Path(__file__))] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
target = BASE / 'static-csr-independent-cpu.json'
assert not target.exists()
target.write_text(json.dumps({'cases': rows, 'input_sha256': hashes, 'GPU_runs': 0,
    'all_static_CSR_entries_rebuilt_from_actual_model_topology': True,
    'all_static_arrays_byte_equal_between_endpoints': True, 'full_tangent_backing_ranges_checked_without_reading_tail': True,
    'active_dynamic_contact_records_not_yet_captured': True, 'whole_solver_complete': False}, indent=2) + '\n')
print('H1 actual self static topology/CSR and real tangent allocation checked:', rows)
