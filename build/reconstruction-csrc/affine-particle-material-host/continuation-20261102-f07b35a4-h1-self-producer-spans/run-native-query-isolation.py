"""Run all declared real self queries serially on GPU, preserving actual exits and each admission."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

status_path = BASE / 'native-query-isolation.status.json'
assert not status_path.exists()
plan = json.loads((BASE / 'native-query-plan.json').read_text())
hashes = dict(plan['input_sha256'])
hashes[str(Path(__file__))] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
(BASE / 'native-query-run-plan.json').write_text(json.dumps({'input_sha256': hashes,
    'original_normalized_case_plan': str(BASE / 'native-query-plan.json'),
    'planned_native_PTX_source_calls': plan['planned_native_PTX_source_calls'],
    'old_failures_rejudged': False, 'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_admission': [], 'whole_solver_complete': False}


def dump():
    status_path.write_text(json.dumps(status, indent=2) + '\n')


dump()
for case in plan['cases']:
    for name, expected in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
    free = int(subprocess.check_output(
        ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
    apps = subprocess.check_output(
        ['nvidia-smi', '--query-compute-apps=pid,process_name,used_memory', '--format=csv,noheader'], text=True).strip()
    assert free >= 4096
    status['GPU_admission'].append({'case': case['tag'], 'UTC': datetime.now(timezone.utc).isoformat(),
                                   'free_memory_MiB': free, 'compute_apps': apps})
    command = [sys.executable, '-B', str(BASE / 'native-query-isolation.py'), '--case', case['tag']]
    (BASE / (case['tag'] + '-native.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (BASE / (case['tag'] + '-native.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env={**clean_env(), 'PYTHONDONTWRITEBYTECODE': '1'},
                                   stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'case': case['tag'], 'pid': process.pid}
        dump()
        code = process.wait()
    status['completed'].append({'case': case['tag'], 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    dump()
    print(case['tag'], 'native query isolation actual exit', code, flush=True)
    if code:
        raise SystemExit(code)
status['complete'] = True
dump()
