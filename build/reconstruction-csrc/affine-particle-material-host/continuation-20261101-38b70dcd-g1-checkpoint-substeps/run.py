"""Collect the fixed controlled restart once per worker, preserving original final-test failures and exit codes."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time

import numpy as np

ROOT = Path.cwd()
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

BASE = Path(__file__).resolve().parent
plan = json.loads((BASE / 'plan.json').read_text())
status_path = BASE / 'run.status.json'
assert not status_path.exists()
status = {'complete': False, 'running': None, 'completed': [], 'GPU_wait_observations': [], 'whole_solver_complete': False}
status_path.write_text(json.dumps(status, indent=2) + '\n')
for run in plan['runs']:
    for name, expected in plan['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
    while True:
        live = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
        if not live:
            break
        status['GPU_wait_observations'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'compute_apps': live})
        status_path.write_text(json.dumps(status, indent=2) + '\n')
        print('Waiting for observed GPU processes:', live, flush=True)
        time.sleep(2)
    label, backend = run['label'], run['backend']
    folder = BASE / label
    command = [sys.executable, '-m', 'reconstruction.csrc.g1_checkpoint_substeps', '--backend', backend,
               '--plan', str(BASE / 'plan.json'), '--output', str(folder)]
    (BASE / (label + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (BASE / (label + '.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=clean_env(), stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'label': label, 'pid': process.pid, 'started_UTC': datetime.now(timezone.utc).isoformat()}
        status_path.write_text(json.dumps(status, indent=2) + '\n')
        code = process.wait()
    record = {'label': label, 'backend': backend, 'pid': process.pid, 'actual_exit': code,
              'normal_demo_test_passed': code == 0, 'completed_frame_saved': False, 'end_test_failure': False}
    status['running'] = None
    status['completed'].append(record)
    status_path.write_text(json.dumps(status, indent=2) + '\n')
    runtime = json.loads((folder / 'worker/runtime.json').read_text())
    assert runtime['real_graph_observed'] and runtime['public_core_abi'] and not runtime['ab_bridge_used']
    assert runtime['reference_solver_mapped'] == (backend == 'original')
    assert all(value == 1 for value in runtime['recorded_frames'].values())
    with np.load(folder / 'recorded-states.npz', allow_pickle=False) as data:
        assert set(data.files) == {'body_q', 'body_qd', 'particle_q', 'particle_qd'}
        assert all(len(data[key]) == 1 and np.isfinite(data[key]).all() for key in data.files)
    record['completed_frame_saved'] = True
    if code != 0:
        exception = json.loads((folder / 'exception.json').read_text())
        assert code == 1 and runtime['exit'] == 1
        assert any(frame['function'] == 'test_final' and frame['file'] == str(ROOT / 'examples/example_robot_g1.py')
                   for frame in exception['frames']), 'A non-final-test error must not be accepted as completed data'
        record['end_test_failure'] = True
    else:
        assert runtime['exit'] == 0
    status_path.write_text(json.dumps(status, indent=2) + '\n')
    print(label, 'actual exit', code, 'full frame saved', record['completed_frame_saved'], flush=True)
status['complete'] = True
status['normal_demo_test_failures'] = sum(not row['normal_demo_test_passed'] for row in status['completed'])
status_path.write_text(json.dumps(status, indent=2) + '\n')
command = [sys.executable, str(BASE / 'independent-cpu-audit.py')]
(BASE / 'independent-cpu-audit.command.json').write_text(json.dumps(command, indent=2) + '\n')
with (BASE / 'independent-cpu-audit.log').open('w') as log:
    code = subprocess.run(command, cwd=ROOT, env=clean_env(), stdout=log, stderr=subprocess.STDOUT).returncode
(BASE / 'independent-cpu-audit.status.json').write_text(json.dumps({'actual_exit': code, 'complete': code == 0,
                                                                 'whole_solver_complete': False}, indent=2) + '\n')
print('Independent controlled-restart CPU audit actual exit', code, flush=True)
assert code == 0

followup = {'complete': False, 'running': None, 'completed': [], 'GPU_wait_observations': []}
followup_path = BASE / 'followup.status.json'
assert not followup_path.exists()
followup_path.write_text(json.dumps(followup, indent=2) + '\n')
for label, command, gpu in [
    ('trace-cpu-audit', [sys.executable, str(BASE / 'trace-cpu-audit.py')], False),
    ('replay', [sys.executable, '-m', 'reconstruction.csrc.g1_checkpoint_substeps_replay',
                '--phase', str(BASE)], True),
    ('replay-independent-cpu-audit', [sys.executable, '-m', 'reconstruction.csrc.g1_checkpoint_substeps_replay',
                                    '--phase', str(BASE), '--audit'], False),
]:
    for name, expected in plan['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
    if gpu:
        while True:
            live = subprocess.check_output(
                ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
            followup['GPU_wait_observations'].append({'UTC': datetime.now(timezone.utc).isoformat(),
                                                      'compute_apps': live})
            if not live:
                break
            followup_path.write_text(json.dumps(followup, indent=2) + '\n')
            print('Waiting for observed GPU processes:', live, flush=True)
            time.sleep(2)
    (BASE / (label + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (BASE / (label + '.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=clean_env(), stdout=log, stderr=subprocess.STDOUT)
        followup['running'] = {'step': label, 'pid': process.pid}
        followup_path.write_text(json.dumps(followup, indent=2) + '\n')
        code = process.wait()
    (BASE / (label + '.status.json')).write_text(json.dumps({
        'actual_exit': code, 'complete': code == 0, 'whole_solver_complete': False}, indent=2) + '\n')
    followup['completed'].append({'step': label, 'pid': process.pid, 'actual_exit': code})
    followup['running'] = None
    followup_path.write_text(json.dumps(followup, indent=2) + '\n')
    print(label, 'actual exit', code, flush=True)
    assert code == 0, (label, code)
followup['complete'] = True
followup_path.write_text(json.dumps(followup, indent=2) + '\n')
