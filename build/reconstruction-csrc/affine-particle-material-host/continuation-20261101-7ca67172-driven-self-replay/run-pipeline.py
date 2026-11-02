"""Wait for the same linear-flow capture, then replay immutable packets serially and audit their complete bytes."""
import json
import os
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.driven_self_flow_replay import sha, verify

FLOW = BASE.parent / 'continuation-20261101-7ca67172-driven-self-flow'
DIRECTORY = BASE / 'pipeline'
DIRECTORY.mkdir(exist_ok=False)
request = json.loads((BASE / 'replay-request.json').read_text())
hashes = dict(request['input_sha256'])
for path in (Path(__file__), BASE / 'replay-request.json',
             ROOT / 'reconstruction/csrc/driven_self_flow_replay_audit.py'):
    hashes[str(path.resolve())] = sha(path)
verify(hashes)
(DIRECTORY / 'runner-inputs.json').write_text(json.dumps(hashes, indent=2) + '\n')
proc = Path('/proc') / str(os.getpid())
identity = {'pid': os.getpid(), 'start_ticks': int((proc / 'stat').read_text().split(') ', 1)[1].split()[19]),
            'boot_id': Path('/proc/sys/kernel/random/boot_id').read_text().strip()}
(DIRECTORY / 'runner-identity.json').write_text(json.dumps(identity, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'stage': 'waiting-for-linear-flow',
          'wait_count': 0, 'last_waits': [], 'error': None,
          'predecessor_tool_session_actual_exit_not_observed_by_this_process': 37865,
          'fixed_failures_reclassified': False, 'candidate_promoted': False, 'whole_solver_complete': False}


def save():
    path = DIRECTORY / 'status.json.tmp'
    path.write_text(json.dumps(status, indent=2) + '\n')
    path.replace(DIRECTORY / 'status.json')


def waiting(reason):
    status['wait_count'] += 1
    status['last_waits'] = (status['last_waits'] + [{'epoch': time.time(), 'reason': reason}])[-20:]
    save()
    time.sleep(5)


def run(label, command, gpu=False):
    verify(hashes)
    if gpu:
        while True:
            apps = subprocess.check_output(
                ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
            if not apps:
                break
            waiting({'GPU_compute_apps': apps})
    directory = DIRECTORY / label
    directory.mkdir()
    (directory / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
    env = {key: value for key, value in os.environ.items()
           if not key.startswith(('CUDAHOOK_', 'DEMO_', 'RECON_ORACLE_', 'CUPTI_'))
           and key not in ('LD_PRELOAD', 'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
    with (directory / 'run.log').open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'label': label, 'pid': process.pid}
        status['stage'] = label
        save()
        code = process.wait()
    status['completed'].append({'label': label, 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    save()
    assert code == 0, (label, code)
    verify(hashes)
    print(label, 'actual exit', code, flush=True)


save()
try:
    expected = json.loads((FLOW / 'linear-captures-v2/runner-identity.json').read_text())
    assert expected['boot_id'] == identity['boot_id'], 'Existing-PID continuation only;use a new phase on another machine'
    while True:
        previous = Path('/proc') / str(expected['pid'])
        try:
            stat = (previous / 'stat').read_text().split(') ', 1)[1].split()
            same = int(stat[19]) == expected['start_ticks'] and stat[0] != 'Z'
            if same:
                assert 'run-linear-flow-v2.py' in (previous / 'cmdline').read_bytes().decode()
        except (FileNotFoundError, ProcessLookupError):
            same = False
        if not same:
            break
        waiting({'same_linear_capture_queue_verified_live': expected})
    previous = json.loads((FLOW / 'linear-captures-v2/status.json').read_text())
    assert previous['complete'] and len(previous['completed']) == 5
    assert all(row['actual_exit'] == 0 for row in previous['completed'])
    common = [sys.executable, '-m', 'reconstruction.csrc.driven_self_flow_replay', '--phase', str(BASE)]
    run('prepare-actual-packets', [*common, '--mode', 'prepare'])
    run('three-backend-GPU', [*common, '--mode', 'run'], gpu=True)
    run('independent-CPU', [sys.executable, '-m', 'reconstruction.csrc.driven_self_flow_replay_audit',
                            '--phase', str(BASE)])
    audit = json.loads((BASE / 'complete-input-replays/independent-cpu.json').read_text())
    assert audit['metrics']['packets'] == 1188 and audit['metrics']['calls'] == 3564
    status['metrics'] = audit['metrics']
    status['complete'] = True
    status['stage'] = 'execution-complete-numeric-differences-remain-explicit'
except BaseException as error:
    status['error'] = f'{type(error).__name__}: {error}'
    raise
finally:
    save()
