"""Check the combined candidate's four self/drive classes and both actual public H1 backends without resampling C8."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

legacy = BASE.parent / 'continuation-20261101-0dabbaa7-driven-cloth-self/discovery/plan.json'
cases = [json.loads(legacy.read_text())['cases'][index] for index in (0, 2, 7, 11)]
build_path = BASE / 'candidate-force-order/build.json'
core_path = BASE / 'candidate-public-core/build.json'
build, core = (json.loads(path.read_text()) for path in (build_path, core_path))
assert core['source_host_sha256'] == build['image_sha256']
output = BASE / 'combined-initcheck'
output.mkdir(exist_ok=False)
hashes = {**build['input_sha256'], **{str(ROOT / name): expected for name, expected in core['sources'].items()}}
for path in (Path(__file__), build_path, core_path, legacy, BASE / 'worker.py', BASE / 'public-h1-worker.py',
             BASE / 'h1-asset-manifest.json', ROOT / 'examples/example_cloth_h1_free.py'):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
sanitizer = '/usr/local/cuda-12.8/bin/compute-sanitizer'
hashes[sanitizer] = hashlib.sha256(Path(sanitizer).read_bytes()).hexdigest()
jobs = [{'kind': 'self', 'case': case} for case in cases] + [
    {'kind': 'h1', 'backend': backend} for backend in ('original', 'source')]
(output / 'plan.json').write_text(json.dumps({'input_sha256': hashes, 'jobs': jobs, 'sanitizer': sanitizer,
    'numeric_cohorts_changed': False, 'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_admission': [], 'whole_solver_complete': False}


def dump():
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


dump()
for job in jobs:
    label = job['case']['name'] if job['kind'] == 'self' else 'public-h1-' + job['backend']
    for name, expected in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
    free = int(subprocess.check_output(
        ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
    apps = subprocess.check_output(
        ['nvidia-smi', '--query-compute-apps=pid,process_name,used_memory', '--format=csv,noheader'], text=True).strip()
    status['GPU_admission'].append({'case': label, 'UTC': datetime.now(timezone.utc).isoformat(),
                                   'free_memory_MiB': free, 'compute_apps': apps})
    assert free >= 4096
    folder = output / label
    command = [sanitizer, '--tool', 'initcheck', '--error-exitcode', '97', sys.executable, '-B']
    if job['kind'] == 'self':
        folder.mkdir()
        command.extend([str(BASE / 'worker.py'), '--backend', 'source', '--candidate-build', str(build_path),
                        '--output', str(folder), '--frames', '3', '--', *job['case']['extra']])
    else:
        command.extend([str(BASE / 'public-h1-worker.py'), '--backend', job['backend'], '--core-build', str(core_path),
                        '--output', str(folder), '--frames', '4'])
    (output / (label + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (output / (label + '.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env={**clean_env(), 'PYTHONDONTWRITEBYTECODE': '1'},
                                   stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'case': label, 'pid': process.pid}
        dump()
        code = process.wait()
    zero = 'ERROR SUMMARY: 0 errors' in (output / (label + '.log')).read_text()
    status['completed'].append({**status['running'], 'actual_exit': code, 'error_summary_zero': zero})
    status['running'] = None
    dump()
    print(label, 'actual initcheck exit', code, 'zero errors', zero, flush=True)
status['complete'] = True
dump()
raise SystemExit(int(not all(row['actual_exit'] == 0 and row['error_summary_zero'] for row in status['completed'])))
