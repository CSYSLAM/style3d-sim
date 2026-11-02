"""Audit real final-test execution, final raw states and public-backend isolation without loading either native solver."""
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
PHASE = BASE / 'functional-tests'
OUTPUT = PHASE / 'independent-cpu.json'
assert not OUTPUT.exists()
plan = json.loads((PHASE / 'plan.json').read_text())
status = json.loads((PHASE / 'status.json').read_text())
assert status['complete'] and status['running'] is None and len(status['completed']) == 10
hashes = dict(plan['input_sha256'])
rows = []
for case, example, frames in plan['cases']:
    for backend in ('original', 'source'):
        worker = [row for row in status['completed'] if row['case'] == case and row['backend'] == backend]
        assert len(worker) == 1 and worker[0]['actual_exit'] == 0
        gates = [row for row in status['GPU_waits'] if row['case'] == case and row['backend'] == backend]
        assert gates[-1]['free_memory_MiB'] >= 4096
        directory = PHASE / case
        report = json.loads((directory / (backend + '.json')).read_text())
        assert report['exit'] == 0 and report['final_test_entered'] and report['final_test_returned']
        assert report['frames_requested'] == frames
        assert report['arguments'] == ['--viewer', 'null', '--num-frames', str(frames), '--test']
        assert report['public_core_abi'] and not report['ab_bridge_used'] and not report['capture_or_step_replaced']
        assert report['example'] == str(ROOT / example)
        assert hashlib.sha256((ROOT / example).read_bytes()).hexdigest() == report['example_sha256']
        assert report['reference_solver_mapped'] == (backend == 'original')
        expected = ('64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63' if backend == 'original'
                    else '7151054e4597e6ea919c0caee576579e577aca233ea4de4dc8ad7aa20fa4b4e7')
        assert report['image_sha256'] == expected
        assert hashlib.sha256(Path(report['image']).read_bytes()).hexdigest() == expected
        assert hashlib.sha256((BASE / 'functional-worker.py').read_bytes()).hexdigest() == report['runner_sha256']
        if backend == 'source':
            assert report['source_launch_counts'] and sum(report['source_launch_counts'].values()) > 0
        metrics = {}
        with np.load(directory / (backend + '.npz'), allow_pickle=False) as final:
            assert final.files
            for field in final.files:
                value = final[field]
                assert value.dtype == np.dtype('<f4') and list(value.shape) == report['final_state_shapes'][field]
                assert np.isfinite(value).all()
            if case == 'anymal':
                metrics['minimum_body_z'] = float(final['body_q'][:, 2].min())
                metrics['maximum_absolute_body_velocity'] = float(np.abs(final['body_qd']).max())
                metrics['all_body_height_and_velocity_constraints_directly_checked'] = bool(
                    metrics['minimum_body_z'] > -0.006 and metrics['maximum_absolute_body_velocity'] < 0.25)
            if case == 'cable-bundle':
                assert report['final_sim_time'] >= 2.4, 'The authored test would otherwise skip its assertions'
        assert report['all_final_states_finite']
        for suffix in ('.json', '.npz', '.log', '.command.json'):
            path = directory / (backend + suffix)
            hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
        rows.append({'case': case, 'backend': backend, 'frames': frames, 'actual_exit': 0,
                     'authored_final_test_entered_and_returned': True, 'all_final_states_finite': True,
                     'reference_mapped': report['reference_solver_mapped'], 'additional_metrics': metrics})
for path in (Path(__file__), PHASE / 'plan.json', PHASE / 'status.json'):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for path, digest in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == digest, path
result = {'rows': rows, 'authored_final_tests_passed': len(rows), 'input_sha256': hashes, 'GPU_used': False,
          'strict_trajectory_failures_reclassified': False, 'C8_acceptance_claimed': False, 'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(result, indent=2) + '\n')
print('CPU verified10 real public-API authored final tests and all raw final states')
for row in rows:
    if row['additional_metrics']:
        print(row['backend'], row['additional_metrics'])
