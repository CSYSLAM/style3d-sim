"""Check initialization of the new candidate in all four constructor classes without changing numeric cohorts."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

build_path = BASE / 'candidate-guard-only/build.json'
build = json.loads(build_path.read_text())
legacy = BASE.parent / 'continuation-20261101-0dabbaa7-granular-affine-contacts/discovery-v2/plan.json'
cases = [json.loads(legacy.read_text())['cases'][i] for i in (0, 1, 4, 3)]
output = BASE / 'source-initcheck'
output.mkdir(exist_ok=False)
hashes = dict(build['input_sha256'])
for path in (Path(__file__), build_path, BASE / 'candidate-worker.py', legacy):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
(output / 'plan.json').write_text(json.dumps({'input_sha256': hashes, 'cases': cases, 'frames': 3,
    'source_sha256': build['image_sha256'], 'numeric_cohorts_changed': False,
    'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_admission': [], 'whole_solver_complete': False}


def dump():
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


dump()
for case in cases:
    for name, expected in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
    free = int(subprocess.check_output(
        ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
    apps = subprocess.check_output(
        ['nvidia-smi', '--query-compute-apps=pid,process_name,used_memory', '--format=csv,noheader'], text=True).strip()
    status['GPU_admission'].append({'case': case['label'], 'UTC': datetime.now(timezone.utc).isoformat(),
                                   'free_memory_MiB': free, 'compute_apps': apps})
    assert free >= 4096
    folder = output / case['label']
    folder.mkdir()
    command = ['compute-sanitizer', '--tool', 'initcheck', '--error-exitcode', '97', sys.executable, '-B',
               str(BASE / 'candidate-worker.py'), '--candidate-build', str(build_path), '--worker', 'source',
               '--tag', 'capture', '--example', str(ROOT / 'reconstruction/csrc/granular_affine_contacts_scene.py'),
               '--frames', '3', '--output', str(folder), '--', *case['extra']]
    (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
    with (folder / 'run.log').open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env={**clean_env(), 'PYTHONDONTWRITEBYTECODE': '1'},
                                   stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'case': case['label'], 'pid': process.pid}
        dump()
        code = process.wait()
    zero = 'ERROR SUMMARY: 0 errors' in (folder / 'run.log').read_text()
    status['completed'].append({'case': case['label'], 'pid': process.pid, 'actual_exit': code, 'error_summary_zero': zero})
    status['running'] = None
    dump()
    print(case['label'], 'actual sanitizer exit', code, 'zero errors', zero, flush=True)
status['complete'] = True
dump()
assert all(row['actual_exit'] == 0 and row['error_summary_zero'] for row in status['completed'])
