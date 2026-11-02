"""Independently recompute complete sixty-frame A/B states without accepting strict failures or missing outputs."""
import hashlib
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
import numpy as np
from reconstruction.csrc.official_demo_audit import compare_states, load_states, HOST, SDK

DIRECTORY = BASE / 'long60'
OUTPUT = DIRECTORY / 'independent-cpu.json'
assert not OUTPUT.exists()
plan = json.loads((DIRECTORY / 'plan.json').read_text())
status = json.loads((DIRECTORY / 'status.json').read_text())
assert status['complete'] and not status['error'] and len(status['completed']) == 8
assert plan['frames'] == 60 and plan['GPU_admission_policy'] == 'available-memory'
hashes, rows = dict(plan['input_sha256']), []


def read(path):
    raw = path.read_bytes()
    hashes[str(path.resolve())] = hashlib.sha256(raw).hexdigest()
    return raw


for case in plan['cases']:
    folder = DIRECTORY / case['name']
    report = json.loads(read(folder / 'report.json'))
    states = {}
    workers = []
    for side in ('original', 'source'):
        workers_for_side = [r for r in status['completed'] if r['case'] == case['name'] and r['backend'] == side]
        assert len(workers_for_side) == 1
        worker = workers_for_side[0]
        assert worker in report['workers']
        workers.append(worker)
        read(folder / (side + '.log'))
        read(folder / (side + '.command.json'))
        runtime_path = folder / (side + '.runtime.json')
        if runtime_path.exists():
            runtime = json.loads(read(runtime_path))
            assert runtime['frames'] == 60 and runtime['extra'] == [] and runtime['backend'] == side
            assert runtime['image_sha256'] == (HOST if side == 'source' else SDK)
        gates = [r for r in status['GPU_waits'] if r['case'] == case['name'] and r['backend'] == side]
        assert gates[-1]['free_memory_MiB'] >= 4096
        path = folder / (side + '.npz')
        assert path.exists() == worker['capture_exists']
        if path.exists():
            read(path)
        if worker['actual_exit'] == 0:
            assert runtime_path.exists()
            states[side] = load_states(path)
            assert all(len(v) == case['substeps'] for v in states[side].values())
            if side == 'source':
                calls = json.loads(read(folder / 'source.launches.json'))
                assert calls and sum(calls.values()) > 0
    row = {'case': case['name'], 'workers': workers, 'full_demo_accepted': False}
    if len(states) == 2:
        actual = compare_states(states['original'], states['source'])
        finite = all(np.isfinite(v).all() for state in states.values() for v in state.values())
        assert actual == report['comparison'] and finite == report['states_finite']
        row.update(comparison=actual, all_states_finite=bool(finite))
    else:
        row['comparison_not_claimed_due_to_worker_failure'] = True
    rows.append(row)
for path in (Path(__file__), ROOT / 'reconstruction/csrc/official_demo_audit.py',
             DIRECTORY / 'plan.json', DIRECTORY / 'status.json'):
    read(path)
for path, expected in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
result = {'cases': rows, 'input_sha256': hashes, 'GPU_used_for_this_audit': False,
          'concurrent_external_GPU_jobs_allowed': True, 'own_GPU_workers_serial': True,
          'full_demo_accepted': False, 'old_failures_reclassified': False, 'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(result, indent=2) + '\n')
print('Independent60 CPU:', [(r['case'], r.get('comparison', {}).get('bitwise')) for r in rows], flush=True)
