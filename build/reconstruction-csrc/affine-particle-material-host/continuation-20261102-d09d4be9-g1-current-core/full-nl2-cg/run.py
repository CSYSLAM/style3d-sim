"""Capture the two fixed checkpoints and replay all NL2 CG calls, preserving every actual exit."""
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
status_path = BASE / 'run.status.json'
assert not status_path.exists()
status = {'complete': False, 'running': None, 'completed': [], 'GPU_admission': [], 'whole_solver_complete': False}


def dump():
    status_path.write_text(json.dumps(status, indent=2) + '\n')


def admit_gpu():
    free = int(subprocess.check_output(
        ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
    apps = subprocess.check_output(
        ['nvidia-smi', '--query-compute-apps=pid,process_name,used_memory', '--format=csv,noheader'], text=True).strip()
    status['GPU_admission'].append({'UTC': datetime.now(timezone.utc).isoformat(),
                                   'free_memory_MiB': free, 'compute_apps': apps})
    dump()
    assert free >= 4096


def execute(label, command):
    for name, expected in plan['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
    (BASE / (label + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (BASE / (label + '.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env={**clean_env(), 'PYTHONDONTWRITEBYTECODE': '1'},
                                   stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'label': label, 'pid': process.pid}
        dump()
        code = process.wait()
    status['completed'].append({'label': label, 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    dump()
    (BASE / (label + '.status.json')).write_text(json.dumps({
        'actual_exit': code, 'complete': code == 0, 'whole_solver_complete': False}, indent=2) + '\n')
    print(label, 'actual exit', code, flush=True)
    assert code == 0, (label, code)


dump()
for run in plan['runs']:
    admit_gpu()
    execute(run['label'], [sys.executable, '-B', '-m', 'reconstruction.csrc.g1_nl2_full_cg',
                          '--backend', run['backend'], '--plan', str(BASE / 'plan.json'),
                          '--output', str(BASE / run['label'])])
status['complete'] = True
dump()
status_path = BASE / 'followup.status.json'
assert not status_path.exists()
status = {'complete': False, 'running': None, 'completed': [], 'GPU_admission': [], 'whole_solver_complete': False}
dump()
execute('independent-cpu-audit', [sys.executable, '-B', str(BASE / 'independent-cpu-audit.py')])
admit_gpu()
execute('replay', [sys.executable, '-B', '-m', 'reconstruction.csrc.g1_nl2_full_cg', '--phase', str(BASE), '--replay'])
execute('replay-independent-cpu-audit',
        [sys.executable, '-B', '-m', 'reconstruction.csrc.g1_nl2_full_cg', '--phase', str(BASE), '--audit'])
status['complete'] = True
dump()
