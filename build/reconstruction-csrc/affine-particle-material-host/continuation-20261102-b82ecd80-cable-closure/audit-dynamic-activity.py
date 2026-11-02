"""Confirm both bodies actually move in all SDK/source dynamic mixed captures, without rerunning GPU."""
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
folder = BASE / 'dynamic-mixed-short'
plan = json.loads((folder / 'plan.json').read_text())
hashes, rows = {}, []
for case in plan['cases']:
    for backend in ('original', 'source'):
        path = folder / case['name'] / backend / 'actual/capture.npz'
        with np.load(path, allow_pickle=False) as data:
            q = data['body_q']
            assert q.shape == (3, 2 * case['worlds'], 7) and np.isfinite(q).all()
            moved = np.any(q[1:, :, :3].copy().view('u4') != q[:-1, :, :3].copy().view('u4'), axis=(0, 2))
            assert moved.all(), (case['name'], backend, moved.tolist())
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
        rows.append({'case': case['name'], 'backend': backend, 'actual_moving_bodies': len(moved)})
for path in (Path(__file__), folder / 'plan.json', ROOT / 'reconstruction/csrc/cable_body_mixed_dynamic_scene.py'):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
(BASE / 'dynamic-activity-independent-cpu.json').write_text(json.dumps({
    'observations': rows, 'all_actual_body_position_trajectories_move': True,
    'total_body_trajectories': sum(row['actual_moving_bodies'] for row in rows), 'input_sha256': hashes,
    'GPU_used': False, 'production_modified': False, 'whole_solver_complete': False}, indent=2) + '\n')
print('CPU confirmed both bodies actually move in all32 dynamic SDK/source captures')
