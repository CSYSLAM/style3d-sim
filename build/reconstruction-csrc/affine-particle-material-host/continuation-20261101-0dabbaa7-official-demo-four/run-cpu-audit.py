"""Wait for the existing normal-core queue, then independently audit its actual outputs on CPU."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.official_demo_audit import wait_for_normal

REQUEST = BASE / 'audit-request.json'
STATUS = BASE / 'audit-status.json'
assert not REQUEST.exists() and not STATUS.exists()
paths = [Path(__file__), ROOT / 'reconstruction/csrc/official_demo_audit.py', BASE / 'auditor-preflight.json',
         BASE / 'normal-waiter-identity.json', BASE / 'normal-core3/plan.json', BASE / 'short3/plan.json']
hashes = {str(path.resolve()): hashlib.sha256(path.read_bytes()).hexdigest() for path in paths}
request = {'input_sha256': hashes, 'depends_on_existing_normal_queue': True,
           'normal_queue_tool_session': 99307, 'only_CPU_audit': True, 'new_GPU_claims': False,
           'whole_solver_complete': False}
REQUEST.write_text(json.dumps(request, indent=2) + '\n')
status = {'complete': False, 'waiting_for_existing_normal_queue': True, 'child': None, 'error': None}


def save():
    temporary = BASE / 'audit-status.json.tmp'
    temporary.write_text(json.dumps(status, indent=2) + '\n')
    temporary.replace(STATUS)


def verify():
    for path, expected in hashes.items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path


save()
try:
    verify()
    wait_for_normal(BASE)
    verify()
    status['waiting_for_existing_normal_queue'] = False
    save()
    command = [sys.executable, '-B', '-m', 'reconstruction.csrc.official_demo_audit', '--phase', str(BASE)]
    (BASE / 'CPU-audit.command.json').write_text(json.dumps(command, indent=2) + '\n')
    env = {key: value for key, value in os.environ.items()
           if key not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD')}
    env.update({'PYTHONPATH': str(ROOT), 'PYTHONDONTWRITEBYTECODE': '1'})
    with (BASE / 'CPU-audit.log').open('w') as log:
        child = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
        code = child.wait()
    status['child'] = {'pid': child.pid, 'actual_exit': code}
    save()
    assert code == 0
    verify()
    status['complete'] = True
    print('Actual independent official-demo CPU audit exit', code, flush=True)
except BaseException as problem:
    status['error'] = f'{type(problem).__name__}: {problem}'
    raise
finally:
    save()
