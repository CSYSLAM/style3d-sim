"""Run exactly two predeclared H1 capture workers serially without changing any frozen numeric cohorts."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

plan = json.loads((BASE / 'plan.json').read_text())
assert not (BASE / 'run.status.json').exists()
status = {'complete': False, 'running': None, 'completed': [], 'GPU_admission': [], 'whole_solver_complete': False}


def dump():
    (BASE / 'run.status.json').write_text(json.dumps(status, indent=2) + '\n')


dump()
for run in plan['runs']:
    for path, expected in plan['input_sha256'].items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
    free = int(subprocess.check_output(
        ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
    apps = subprocess.check_output(
        ['nvidia-smi', '--query-compute-apps=pid,process_name,used_memory', '--format=csv,noheader'], text=True).strip()
    status['GPU_admission'].append({'label': run['label'], 'UTC': datetime.now(timezone.utc).isoformat(),
                                   'free_memory_MiB': free, 'compute_apps': apps})
    assert free >= 4096
    command = [sys.executable, '-B', str(BASE / 'probe-worker.py'), '--backend', run['backend'],
               '--output', str(BASE / run['label'])]
    (BASE / (run['label'] + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (BASE / (run['label'] + '.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env={**clean_env(), 'PYTHONDONTWRITEBYTECODE': '1'},
                                   stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {**run, 'pid': process.pid}
        dump()
        code = process.wait()
    status['completed'].append({**run, 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    dump()
    print(run['label'], 'actual capture exit', code, flush=True)
    if code:
        raise SystemExit(code)
status['complete'] = True
dump()
