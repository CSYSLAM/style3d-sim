"""Continue serially after the identified live candidate driver, requiring real results before each next check."""
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
output = BASE / 'candidate2-followup'
output.mkdir(exist_ok=False)
driver_path = (BASE / 'run-candidate2.py').resolve()
matches = []
for proc in Path('/proc').iterdir():
    if not proc.name.isdigit():
        continue
    try:
        argv = (proc / 'cmdline').read_bytes().split(b'\0')
        if len(argv) > 1 and argv[1] and Path(os.fsdecode(argv[1])).resolve() == driver_path:
            stamp = (proc / 'stat').read_text().rsplit(')', 1)[1].split()[19]
            matches.append({'pid': int(proc.name), 'starttime': stamp})
    except (OSError, ValueError):
        continue
assert len(matches) <= 1
plan = json.loads((BASE / 'candidate2-run-plan.json').read_text())
paths = [Path(__file__), BASE / 'check-constructors2.py', BASE / 'constructor2-audit.py',
         BASE / 'check-graphs2.py', BASE / 'graph2-worker.py']
hashes = dict(plan['input_sha256'])
hashes.update({str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths})
(output / 'plan.json').write_text(json.dumps({'input_sha256': hashes, 'preceding_driver': matches,
                                            'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'driver_waits': [], 'GPU_waits': [],
          'whole_solver_complete': False}


def dump():
    (output / 'run.status.json').write_text(json.dumps(status, indent=2) + '\n')


def verify():
    for name, digest in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name


def execute(label, command, env=None):
    verify()
    (output / (label + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (output / (label + '.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'label': label, 'pid': process.pid}
        dump()
        code = process.wait()
    status['completed'].append({'label': label, 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    dump()
    print(label, 'actual exit', code, flush=True)
    assert code == 0, (label, code)


dump()
if matches:
    identity = matches[0]
    while True:
        try:
            current = Path('/proc', str(identity['pid']), 'stat').read_text().rsplit(')', 1)[1].split()[19]
        except FileNotFoundError:
            break
        if current != identity['starttime']:
            break
        status['driver_waits'].append({'UTC': datetime.now(timezone.utc).isoformat(), **identity})
        dump()
        time.sleep(2)
verify()
previous = json.loads((BASE / 'candidate2.run.status.json').read_text())
assert previous['complete'] and previous['running'] is None
assert all(r['actual_exit'] == 0 for r in previous['completed'])
strict = json.loads((BASE / 'candidate2-independent-cpu-audit.json').read_text())
assert strict['passed'] == strict['cases'] == 4
execute('constructors2', [sys.executable, str(BASE / 'check-constructors2.py')])
constructor_status = json.loads((BASE / 'constructors2/run.status.json').read_text())
assert constructor_status['complete'] and constructor_status['running'] is None
assert all(r['actual_exit'] == 0 for r in constructor_status['completed'])
constructor = json.loads((BASE / 'constructors2/audit.json').read_text())
assert constructor['all_captured_checks_passed'] and all(constructor['checks'].values())
execute('graphs2', [sys.executable, str(BASE / 'check-graphs2.py')])
graph = json.loads((BASE / 'graph60-candidate2/independent-cpu-audit.json').read_text())
assert graph['passed'] == graph['total'] == 16
env = {k: v for k, v in os.environ.items() if not k.startswith(('CUDAHOOK_', 'RECON_ORACLE_', 'DEMO_', 'CUPTI_'))
       and k not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'GRANULAR_AFFINE_MODEL_OUTPUT')}
for backend in ('original', 'source'):
    while True:
        apps = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
        status['GPU_waits'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'compute_apps': apps})
        dump()
        if not apps:
            break
        time.sleep(5)
    folder = output / ('initcheck-' + backend)
    folder.mkdir()
    command = ['compute-sanitizer', '--tool', 'initcheck', '--error-exitcode', '97', sys.executable,
               str(BASE / 'candidate2-worker.py'), '--worker', backend, '--tag', 'capture',
               '--example', str(ROOT / 'reconstruction/csrc/granular_affine_scene.py'), '--frames', '3',
               '--output', str(folder), '--', '--mode', 'newton', '--body-block']
    execute('initcheck-' + backend, command, env)
    log = (output / ('initcheck-' + backend + '.log')).read_text()
    assert 'ERROR SUMMARY: 0 errors' in log
status['complete'] = True
dump()
