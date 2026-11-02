"""Wait for the existing scalar audit, then capture the preplanned failure-flow workers serially on an idle GPU."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
SELF = BASE.parent / 'continuation-20261101-0dabbaa7-driven-cloth-self'
PLAN = json.loads((BASE / 'linear-flow-plan.json').read_text())
OUTPUT = BASE / 'linear-captures-v2'
OUTPUT.mkdir(exist_ok=False)
STATUS = {'complete': False, 'running': None, 'completed': [], 'wait_count': 0, 'last_waits': [],
          'original_frozen_samples_replaced': False, 'candidate_promoted': False, 'whole_solver_complete': False}
HASHES = {**PLAN['input_sha256']}
interface = json.loads((BASE / 'audit-interface-preflight.json').read_text())
assert len(interface['cases']) == 2 and all(row['adapter_result_matches_real_NPZ_and_frozen_report']
                                          for row in interface['cases'])
HASHES.update(interface['input_sha256'])
proof = json.loads((BASE / 'planned-write-proof.json').read_text())
assert proof['all_potential_writes_captured'] and proof['actual_PTX_entries_checked'] == 28
HASHES.update(proof['input_sha256'])
for path in (Path(__file__), BASE / 'audit-linear-flow-v2.py', BASE / 'linear-flow-plan.json',
             BASE / 'planned-write-proof.json', BASE / 'audit-interface-preflight.json'):
    HASHES[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
(OUTPUT / 'runner-inputs.json').write_text(json.dumps(HASHES, indent=2) + '\n')
proc = Path('/proc') / str(os.getpid())
identity = {'pid': os.getpid(), 'start_ticks': int((proc / 'stat').read_text().split(') ', 1)[1].split()[19]),
            'boot_id': Path('/proc/sys/kernel/random/boot_id').read_text().strip()}
(OUTPUT / 'runner-identity.json').write_text(json.dumps(identity, indent=2) + '\n')


def save():
    path = OUTPUT / 'status.json.tmp'
    path.write_text(json.dumps(STATUS, indent=2) + '\n')
    path.replace(OUTPUT / 'status.json')


def verify():
    for name, expected in HASHES.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name


def waiting(reason):
    STATUS['wait_count'] += 1
    STATUS['last_waits'] = (STATUS['last_waits'] + [{'epoch': time.time(), 'reason': reason}])[-20:]
    save()
    time.sleep(5)


def read_live_json(path):
    try:
        return json.loads(path.read_text())
    except (FileNotFoundError, json.JSONDecodeError):
        return None


save()
if '--fresh-machine' not in sys.argv:
    expected = json.loads((SELF / 'surface-scalar-certificates-isolated/waiter-identity.json').read_text())
    assert expected['boot_id'] == identity['boot_id'], 'Use --fresh-machine only for a new independent diagnostic batch'
    while True:
        old = Path('/proc') / str(expected['pid'])
        try:
            stat = (old / 'stat').read_text().split(') ', 1)[1].split()
            same = int(stat[19]) == expected['start_ticks'] and stat[0] != 'Z'
            if same:
                assert 'certify-surface-scalars-isolated.py' in (old / 'cmdline').read_bytes().decode()
        except (FileNotFoundError, ProcessLookupError):
            same = False
        if same:
            waiting({'same_previous_scalar_worker_live': expected})
            continue
        followup = read_live_json(SELF / 'isolated-followup-status.json')
        if followup is None or not followup['complete']:
            if followup and followup['completed']:
                assert all(row['actual_exit'] == 0 for row in followup['completed'])
            waiting('Previous independent CPU scalar audit not complete;no new GPU context created')
            continue
        audit = json.loads((SELF / 'surface-scalar-certificates-isolated/independent-cpu-audit.json').read_text())
        assert audit['isolated_gate_satisfied'] and audit['metrics']['actual_GPU_calls'] == 593
        break
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'DEMO_', 'RECON_ORACLE_', 'CUPTI_'))
       and key not in ('LD_PRELOAD', 'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
try:
    for number, job in enumerate(PLAN['jobs']):
        verify()
        while True:
            apps = subprocess.check_output(
                ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
            if not apps:
                break
            waiting({'GPU_compute_apps': apps})
        directory = OUTPUT / str(number)
        directory.mkdir()
        specification = ';'.join(key + '=' + ','.join(argument + ':' + str(size) for argument, size in fields.items())
                                 for key, fields in job['specifications'].items())
        command = [sys.executable, str(SELF / 'worker.py'), '--backend', job['backend'], '--output', str(directory),
                   '--frames', '3', '--candidate-build', str(SELF / 'candidate-force-order/build.json'),
                   '--', *job['case']['extra']]
        (directory / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
        task_env = {**env, 'LD_PRELOAD': str(ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'),
                    'CUDAHOOK_DIR': str(directory), 'CUDAHOOK_DUMP': specification, 'CUDAHOOK_DUMP_LIMIT': '999',
                    'DRIVEN_SELF_LAYOUT_OUTPUT': str(directory / 'layout.json')}
        with (directory / 'run.log').open('w') as log:
            process = subprocess.Popen(command, cwd=ROOT, env=task_env, stdout=log, stderr=subprocess.STDOUT)
            STATUS['running'] = {'job': number, 'pid': process.pid, 'case': job['case']['name']}
            save()
            code = process.wait()
        STATUS['completed'].append({'job': number, 'pid': process.pid, 'actual_exit': code})
        STATUS['running'] = None
        save()
        assert code == 0
        verify()
        print('Linear/self actual worker', number, 'exit', code, flush=True)
    STATUS['captures_complete'] = True
    save()
    command = [sys.executable, str(BASE / 'audit-linear-flow-v2.py')]
    with (BASE / 'linear-independent-cpu-v2.log').open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
        STATUS['running'] = {'label': 'independent-CPU', 'pid': process.pid}
        save()
        code = process.wait()
    STATUS['completed'].append({'label': 'independent-CPU', 'pid': process.pid, 'actual_exit': code})
    STATUS['running'] = None
    assert code == 0
    verify()
    STATUS['complete'] = True
finally:
    save()
