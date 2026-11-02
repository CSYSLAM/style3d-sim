"""After the existing serial short queue, run supported demos through the unchanged public source _core entrypoint."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
OUTPUT = BASE / 'normal-core60'
OUTPUT.mkdir(exist_ok=False)
identity = json.loads((BASE / 'short-waiter-identity.json').read_text())['process']
short_plan = json.loads((BASE / 'short3/plan.json').read_text())
core_path = ROOT / 'build/reconstruction-csrc/source-core/5037032b98b9d614/build.json'
core = json.loads(core_path.read_text())
assert core['source_host_sha256'] == '0dabbaa7a57b57187549f814632efebdc5612095765932be112c2c9ca1868e3e'
assert core['extension_sha256'] == '7151054e4597e6ea919c0caee576579e577aca233ea4de4dc8ad7aa20fa4b4e7'
hashes = dict(short_plan['input_sha256'])
for path in (Path(__file__), core_path, core_path.parent / '_core.cpython-312-x86_64-linux-gnu.so',
             ROOT / 'reconstruction/core_demo.py', BASE / 'short-waiter-identity.json'):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
plan = {'cases': short_plan['cases'], 'frames': 60, 'input_sha256': hashes,
        'dependency': 'Existing short3 queue;do not restart it', 'original_ABI_bridge_used': False,
        'only_source_short_success_cases_run': True, 'production_changed': False,
        'GPU_admission_policy': 'available-memory', 'whole_solver_complete': False}
(OUTPUT / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
status = {'complete': False, 'waiting_for_short': True, 'completed': [], 'skipped': [], 'GPU_waits': [], 'error': None}
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'DEMO_', 'RECON_ORACLE_', 'CUPTI_'))
       and key not in ('LD_PRELOAD', 'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
env.update({'PYTHONPATH': str(ROOT), 'PYTHONDONTWRITEBYTECODE': '1', 'NEWTON_CACHE_PATH': str(BASE / 'asset-cache')})


def save():
    temporary = OUTPUT / 'status.json.tmp'
    temporary.write_text(json.dumps(status, indent=2) + '\n')
    temporary.replace(OUTPUT / 'status.json')


save()
try:
    while True:
        preceding = json.loads((BASE / 'short3/status.json').read_text())
        if preceding['complete']:
            break
        assert not preceding['error'], preceding['error']
        assert Path('/proc/sys/kernel/random/boot_id').read_text().strip() == identity['boot_id']
        directory = Path('/proc') / str(identity['pid'])
        raw = (directory / 'stat').read_text().rsplit(')', 1)[1].split()
        assert int(raw[19]) == identity['start_ticks'] and raw[0] != 'Z'
        time.sleep(5)
    status['waiting_for_short'] = False
    save()
    for case in short_plan['cases']:
        workers = [row for row in preceding['completed'] if row['case'] == case['name'] and row['backend'] == 'source']
        assert len(workers) == 1
        if workers[0]['actual_exit'] or not workers[0]['capture_exists']:
            status['skipped'].append({'case': case['name'], 'reason': 'Identical source host already failed short run'})
            save()
            continue
        for name, expected in hashes.items():
            assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
        while True:
            live = subprocess.check_output(
                ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
            free = int(subprocess.check_output(
                ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
            status['GPU_waits'].append({'case': case['name'], 'compute_apps': live, 'epoch': time.time(),
                                        'free_memory_MiB': free, 'GPU_admission_policy': 'available-memory'})
            save()
            if free >= 4096:
                break
            time.sleep(5)
        command = [sys.executable, '-B', '-m', 'reconstruction.core_demo', '--core-build', str(core_path),
                   '--report', str(OUTPUT / (case['name'] + '.json')), str(ROOT / case['example']),
                   '--', '--viewer', 'null', '--num-frames', '60']
        (OUTPUT / (case['name'] + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
        with (OUTPUT / (case['name'] + '.log')).open('w') as log:
            child = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
            code = child.wait()
        status['completed'].append({'case': case['name'], 'pid': child.pid, 'actual_exit': code})
        save()
        print('Actual public source _core', case['name'], 'exit', code, flush=True)
    status['complete'] = True
except BaseException as error:
    status['error'] = f'{type(error).__name__}: {error}'
    raise
finally:
    save()
print('Public source _core tasks finished;short failures and normal execution failures retained', flush=True)

# The bend demo already has a current-host sixty-frame A/B baseline;also verify its public entrypoint.
while True:
    free = int(subprocess.check_output(
        ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
    if free >= 4096:
        break
    time.sleep(5)
command = [sys.executable, '-B', '-m', 'reconstruction.core_demo', '--core-build', str(core_path),
           '--report', str(OUTPUT / 'cable-bend.json'), str(ROOT / 'examples/cable/example_cable_bend_stiffness.py'),
           '--', '--viewer', 'null', '--num-frames', '60']
with (OUTPUT / 'cable-bend.log').open('w') as log:
    child = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
    code = child.wait()
(OUTPUT / 'cable-bend-actual-exit.json').write_text(json.dumps(
    {'pid': child.pid, 'actual_exit': code, 'free_memory_MiB_before_launch': free}, indent=2) + '\n')
print('Actual public source _core cable-bend exit', code, flush=True)
