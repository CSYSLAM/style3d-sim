"""Check six actual coupled classes on both fixed SDK and cache candidate, serially with initcheck."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

candidate_path = BASE / 'candidate-cache-order/build.json'
candidate = json.loads(candidate_path.read_text())
cases = json.loads((BASE / 'candidate-cache-order-v2-3/plan.json').read_text())['cases']
selected = [cases[index] for index in (0, 7, 8, 15, 16, 23)]
tool = ROOT / 'build/toolchains/diagnostics-13.2/compute-sanitizer/compute-sanitizer'
output = BASE / 'initcheck60-cache-order'
output.mkdir(exist_ok=False)
hashes = dict(candidate['input_sha256'])
hashes.update({str(path): hashlib.sha256(path.read_bytes()).hexdigest()
               for path in (Path(__file__), candidate_path, tool, BASE / 'worker.py')})
hashes[candidate['image']] = candidate['image_sha256']
plan = {'cases': selected, 'frames': 60, 'input_sha256': hashes, 'source_image_sha256': candidate['image_sha256'],
        'own_GPU_workers_serial': True, 'external_apps_allowed': True,
        'production_modified': False, 'whole_solver_complete': False}
(output / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_admission': [], 'whole_solver_complete': False}


def dump():
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


dump()
for case in selected:
    for backend in ('original', 'source'):
        for path, expected in hashes.items():
            assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
        free = int(subprocess.check_output(
            ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
        apps = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name,used_memory', '--format=csv,noheader'], text=True).strip()
        status['GPU_admission'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'case': case['name'],
                                        'backend': backend, 'free_memory_MiB': free, 'compute_apps': apps})
        assert free >= 4096
        folder = output / case['name'] / backend
        folder.mkdir(parents=True)
        command = [str(tool), '--tool', 'initcheck', '--error-exitcode', '99', '--log-file',
                   str(folder / 'sanitizer.log'), sys.executable, '-B', str(BASE / 'worker.py'),
                   '--backend', backend, '--candidate-build', str(candidate_path), '--frames', '60',
                   '--output', str(folder), '--', *case['extra']]
        (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
        with (folder / 'run.log').open('w') as log:
            process = subprocess.Popen(command, cwd=ROOT, env={**clean_env(), 'PYTHONDONTWRITEBYTECODE': '1'},
                                       stdout=log, stderr=subprocess.STDOUT)
            status['running'] = {'case': case['name'], 'backend': backend, 'pid': process.pid}
            dump()
            code = process.wait()
        message = (folder / 'sanitizer.log').read_text()
        row = {'case': case['name'], 'backend': backend, 'pid': process.pid, 'actual_exit': code,
               'zero_error_summary': 'ERROR SUMMARY: 0 errors' in message}
        status['completed'].append(row)
        status['running'] = None
        dump()
        print(case['name'], backend, 'initcheck actual exit', code, 'zero errors', row['zero_error_summary'], flush=True)
status['complete'] = True
dump()
assert len(status['completed']) == 12
raise SystemExit(int(not all(row['actual_exit'] == 0 and row['zero_error_summary'] for row in status['completed'])))
