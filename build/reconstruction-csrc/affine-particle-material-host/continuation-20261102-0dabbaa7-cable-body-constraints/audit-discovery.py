"""Verify actual SDK support, effective force branches and independent production guard refusals."""
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
output = BASE / 'discovery-v2-3'
plan = json.loads((output / 'plan.json').read_text())
status = json.loads((output / 'status.json').read_text())
assert status['complete'] and status['running'] is None
assert len(plan['cases']) == 24 and len(status['completed']) == 48
for name, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
rows, hashes = [], dict(plan['input_sha256'])
SDK = '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
source_sha = '0dabbaa7a57b57187549f814632efebdc5612095765932be112c2c9ca1868e3e'
for case in plan['cases']:
    name, worlds = case['name'], case['worlds']
    completed = [row for row in status['completed'] if row['case'] == name]
    assert [row['backend'] for row in completed] == ['original', 'source']
    assert [row['actual_exit'] for row in completed] == [0, 1]
    counts = {}
    for backend in ('original', 'source'):
        folder = output / name / backend
        runtime = json.loads((folder / 'capture.runtime.json').read_text())
        provenance = json.loads((folder / 'wrapper-provenance.json').read_text())
        assert runtime['image_sha256'] == (SDK if backend == 'original' else source_sha)
        assert runtime['frames'] == 3 and runtime['extra'] == case['extra']
        assert provenance['complete'] == (backend == 'original')
        assert provenance['original_SDK_mapped'] == (backend == 'original')
        if backend == 'source':
            assert provenance['error'] == 'RuntimeError: Cable mixed with body constraints has not been captured'
        for path in folder.iterdir():
            if path.is_file():
                hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    folder = output / name / 'original'
    with np.load(folder / 'capture.npz', allow_pickle=False) as arrays:
        expected_shapes = {'particle_q': (3, 8 * worlds, 3), 'particle_qd': (3, 8 * worlds, 3),
                           'body_q': (3, 2 * worlds, 7), 'body_qd': (3, 2 * worlds, 6)}
        assert set(arrays.files) == set(expected_shapes)
        for key, shape in expected_shapes.items():
            assert arrays[key].shape == shape and np.isfinite(arrays[key]).all()
    token, argument = {'spring': ('26evaluate_body_spring_force', 12),
                       'point-line': ('30evaluate_body_point_line_force', 14),
                       'distance': ('39evaluate_body_distance_constraint_force', 11)}[case['constraint']]
    log = (folder / 'launches.txt').read_text().splitlines()
    for name in (token, 'evaluate_cables'):
        selected = [line for line in log if name in line]
        assert selected, name
        counts[name] = len(selected)
    for name, index in ((token, argument), ('evaluate_cables', 5)):
        before, after = [(folder / f'dump_{name}_{phase}_arg{index}.bin').read_bytes() for phase in ('pre', 'post')]
        assert len(before) == len(after) == 8 * worlds * 12
        assert before != after, (case['name'], name, 'Requested force branch did not modify RHS')
    rows.append({'case': case['name'], 'SDK_actual_exit': 0, 'production_actual_exit': 1,
                 'SDK_finite_states': True, 'both_force_modules_effective': True, 'observed_launch_counts': counts})
assert all(row['free_memory_MiB'] >= 4096 for row in status['GPU_admission'])
for path in (Path(__file__), output / 'plan.json', output / 'status.json'):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
result = {'cases': rows, 'SDK_supported_cases': 24, 'production_guard_rejections': 24,
          'both_modules_effective_cases': 24, 'input_sha256': hashes,
          'minimum_pre_worker_free_MiB': min(row['free_memory_MiB'] for row in status['GPU_admission']),
          'external_GPU_apps_allowed': True, 'own_workers_serial': True,
          'production_modified': False, 'whole_solver_complete': False}
(BASE / 'discovery-independent-cpu.json').write_text(json.dumps(result, indent=2) + '\n')
print('CPU verified24 SDK-supported active coupled cases and24 independent production guard rejections')
