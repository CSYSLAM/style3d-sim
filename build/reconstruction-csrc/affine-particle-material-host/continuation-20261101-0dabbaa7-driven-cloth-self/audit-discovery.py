"""Verify SDK support, unchanged production rejections, matched layouts and actual self-contact force activity."""
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
folder = BASE / 'discovery'
plan = json.loads((folder / 'plan.json').read_text())
status = json.loads((folder / 'status.json').read_text())
assert status['complete'] and len(status['completed']) == 24
hashes = dict(plan['input_sha256'])
hashes[str(Path(__file__))] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
rows = []
for case in plan['cases']:
    name = case['name']
    actual = [next(r for r in status['completed'] if r['case'] == name and r['backend'] == backend)
              for backend in ('original', 'source')]
    assert actual[0]['actual_exit'] == 0 and actual[1]['actual_exit'] == 1
    assert actual[1]['provenance']['error'] == 'RuntimeError: This constrained cloth/body combination has not been captured'
    layouts = []
    for backend in ('original', 'source'):
        directory = folder / name / backend
        runtime = json.loads((directory / 'capture.runtime.json').read_text())
        assert runtime['image_sha256'] == plan['SDK_sha256' if backend == 'original' else 'source_sha256']
        assert runtime['extra'] == case['extra'] and runtime['frames'] == 3
        layouts.append(json.loads((directory / 'layout.json').read_text()))
        assert actual[0 if backend == 'original' else 1]['provenance']['original_SDK_mapped'] == (backend == 'original')
    assert layouts[0] == layouts[1] and layouts[0]['self_enabled']
    assert layouts[0]['particle_state_count'] == 16 * case['worlds']
    original = folder / name / 'original'
    with np.load(original / 'capture.npz', allow_pickle=False) as data:
        assert data['particle_q'].shape == (3, 16 * case['worlds'], 3)
        assert all(np.isfinite(data[key]).all() for key in data.files)
    activity = {}
    for kernel, rhs, counter in (('22accumulate_vertex_face', 11, 14), ('20accumulate_edge_edge', 9, 12),
                                  ('20accumulate_edge_face', 10, 13)):
        a, b = [original / f'dump_{kernel}_{phase}_arg{rhs}.bin' for phase in ('pre', 'post')]
        left, right = np.fromfile(a, dtype='<u4'), np.fromfile(b, dtype='<u4')
        assert left.shape == right.shape == (48 * case['worlds'],)
        row = {'changed_RHS_words': int(np.count_nonzero(left != right))}
        if not case['diagonal']:
            before, after = [int(np.fromfile(original / f'dump_{kernel}_{phase}_arg{counter}.bin', dtype='<u4')[0])
                             for phase in ('pre', 'post')]
            row['contact_counter_increment'] = after - before
        activity[kernel] = row
    assert activity['22accumulate_vertex_face']['changed_RHS_words'] > 0
    assert activity['20accumulate_edge_edge']['changed_RHS_words'] > 0
    if not case['diagonal']:
        assert activity['22accumulate_vertex_face']['contact_counter_increment'] > 0
        assert activity['20accumulate_edge_edge']['contact_counter_increment'] > 0
    rows.append({'case': name, 'SDK_supported': True, 'production_scope_guard_reproduced': True,
                 'layouts_equal': True, 'self_activity': activity,
                 'edge_face_arithmetic_active': activity['20accumulate_edge_face']['changed_RHS_words'] > 0})
for path in folder.rglob('*'):
    if path.is_file():
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
record = {'cases': rows, 'input_sha256': hashes, 'GPU_used': False,
          'SDK_supported_cases': 12, 'production_guard_rejections': 12, 'whole_solver_complete': False}
(BASE / 'discovery-independent-cpu.json').write_text(json.dumps(record, indent=2) + '\n')
print('CPU:SDK12 supported/source12 guarded;layouts match;VF/EE forces and contact increments active')
