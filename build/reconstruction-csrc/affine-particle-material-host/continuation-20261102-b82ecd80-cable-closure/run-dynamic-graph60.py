"""Run the complete coupled cable matrix through actual SDK/source eager and graph workers, serially."""
from contextlib import ExitStack
from datetime import datetime, timezone
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.demo_ab import compare

candidate_path = BASE.parent / 'continuation-20261102-0dabbaa7-cable-body-constraints/candidate-cache-order/build.json'
candidate = json.loads(candidate_path.read_text())
short = json.loads((BASE / 'dynamic-mixed-short/status.json').read_text())
assert short['complete'] and len(short['completed']) == 32
assert all(row['actual_exit'] == 0 for row in short['completed'])
assert all(row['passed'] for row in json.loads((BASE / 'dynamic-mixed-short/report.json').read_text())['cases'])
output = BASE / 'dynamic-mixed-graph60'
output.mkdir(exist_ok=False)
worker = BASE / 'dynamic-graph-worker.py'
spec = importlib.util.spec_from_file_location('cable_graph_cases', worker)
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)
cases = list(module.cases())
assert len(cases) == 16
hashes = dict(candidate['input_sha256'])
hashes.update({str(path): hashlib.sha256(path.read_bytes()).hexdigest()
               for path in (Path(__file__), worker, candidate_path, BASE / 'dynamic-mixed-short/status.json',
                            ROOT / 'reconstruction/csrc/cable_body_mixed_dynamic_scene.py')})
hashes[candidate['image']] = candidate['image_sha256']
plan = {'cases': cases, 'frames': 60, 'input_sha256': hashes, 'source_image_sha256': candidate['image_sha256'],
        'eager_and_real_graph': True, 'own_GPU_workers_serial': True, 'external_apps_allowed': True,
        'production_modified': False, 'whole_solver_complete': False}
(output / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_admission': [], 'whole_solver_complete': False}


def dump():
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


dump()
for backend in ('original', 'source'):
    for path, expected in hashes.items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
    free = int(subprocess.check_output(
        ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
    apps = subprocess.check_output(
        ['nvidia-smi', '--query-compute-apps=pid,process_name,used_memory', '--format=csv,noheader'], text=True).strip()
    status['GPU_admission'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'backend': backend,
                                    'free_memory_MiB': free, 'compute_apps': apps})
    assert free >= 4096
    command = [sys.executable, '-B', str(worker), '--worker', backend, '--frames', '60',
               '--candidate-build', str(candidate_path), '--output', str(output)]
    (output / (backend + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (output / (backend + '.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env={**clean_env(), 'PYTHONDONTWRITEBYTECODE': '1'},
                                   stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'backend': backend, 'pid': process.pid}
        dump()
        code = process.wait()
    status['completed'].append({'backend': backend, 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    dump()
    print(backend, 'complete coupled graph60 worker actual exit', code, flush=True)
    assert code == 0
rows = {}
for name, worlds, _ in cases:
    with ExitStack() as stack:
        arrays = {(backend, graph): stack.enter_context(np.load(output / f'{backend}-{name}-{graph}.npz',
                                                                 allow_pickle=False))
                  for backend in ('original', 'source') for graph in (0, 1)}
        assert all(data['particle_q'].shape == (60, 8 * worlds, 3) for data in arrays.values())
        assert all(np.isfinite(data[key]).all() for data in arrays.values() for key in data.files)
        for graph in (0, 1):
            rows[f'original-source/{name}/{graph}'] = compare(arrays['original', graph], arrays['source', graph])
        for backend in ('original', 'source'):
            rows[f'{backend}-eager-graph/{name}'] = compare(arrays[backend, 0], arrays[backend, 1])
result = {'comparisons': rows, 'strict': sum(row['bitwise'] for row in rows.values()), 'total': len(rows),
          'source_image_sha256': candidate['image_sha256'], 'production_modified': False, 'whole_solver_complete': False}
(output / 'report.json').write_text(json.dumps(result, indent=2) + '\n')
status['complete'] = True
dump()
print('Coupled cable graph60 comparisons', result['strict'], '/', result['total'], flush=True)
raise SystemExit(int(result['strict'] != result['total']))
