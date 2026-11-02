"""Admit one fenced three-backend replay, then check all complete outputs on CPU without resampling demos."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

assert not (BASE / 'replay.status.json').exists()
status = {'complete': False, 'running': None, 'completed': [], 'GPU_admission': [], 'whole_solver_complete': False}
script = BASE / 'replay-as-run.py'
hashes = {str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in
          (Path(__file__), script, BASE / 'plan.json')}
(BASE / 'replay-plan.json').write_text(json.dumps({'input_sha256': hashes, 'actual_calls': 18,
    'reset_uploads_fenced_before_nonblocking_launch': True, 'numeric_cohorts_modified': False,
    'whole_solver_complete': False}, indent=2) + '\n')


def dump():
    (BASE / 'replay.status.json').write_text(json.dumps(status, indent=2) + '\n')


dump()
for label, extra in [('GPU', []), ('independent-CPU', ['--audit'])]:
    for name, expected in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
    if label == 'GPU':
        free = int(subprocess.check_output(
            ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
        apps = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name,used_memory', '--format=csv,noheader'], text=True).strip()
        status['GPU_admission'].append({'UTC': datetime.now(timezone.utc).isoformat(),
                                       'free_memory_MiB': free, 'compute_apps': apps})
        assert free >= 4096
    command = [sys.executable, '-B', str(script), '--phase', str(BASE), *extra]
    (BASE / ('replay-' + label + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (BASE / ('replay-' + label + '.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env={**clean_env(), 'PYTHONDONTWRITEBYTECODE': '1'},
                                   stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'label': label, 'pid': process.pid}
        dump()
        code = process.wait()
    status['completed'].append({'label': label, 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    dump()
    print('H1 first-NL replay', label, 'actual exit', code, flush=True)
    if code:
        raise SystemExit(code)
status['complete'] = True
dump()
