"""Run and independently compare actual60-step eager/graph trajectories for all four isolated candidate cases."""
from contextlib import ExitStack
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.demo_ab import compare

short = json.loads((BASE / 'candidate2-independent-cpu-audit.json').read_text())
assert short['passed'] == short['cases'] == 4
build = json.loads((BASE / 'candidate2/build.json').read_text())
output = BASE / 'graph60-candidate2'
output.mkdir(exist_ok=False)
paths = [Path(__file__), BASE / 'graph2-worker.py', ROOT / 'reconstruction/csrc/affine_particle_spring_graph_ab.py',
         ROOT / 'reconstruction/csrc/granular_affine_scene.py', ROOT / 'reconstruction/demo_ab.py', Path(build['image'])]
hashes = dict(build['input_sha256'])
hashes.update({str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths})
(output / 'plan.json').write_text(json.dumps({'input_sha256': hashes, 'frames': 60,
                                            'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_wait_observations': [], 'whole_solver_complete': False}


def dump():
    (output / 'run.status.json').write_text(json.dumps(status, indent=2) + '\n')


def verify():
    for name, digest in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name


def wait_gpu():
    while True:
        live = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
        status['GPU_wait_observations'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'compute_apps': live})
        dump()
        if not live:
            return
        print('Graph waiting for real GPU processes', live, flush=True)
        time.sleep(5)


env = {k: v for k, v in os.environ.items() if not k.startswith(('CUDAHOOK_', 'RECON_ORACLE_', 'DEMO_', 'CUPTI_'))
       and k not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'GRANULAR_AFFINE_MODEL_OUTPUT')}
dump()
for backend in ('original', 'source'):
    verify()
    wait_gpu()
    command = [sys.executable, str(BASE / 'graph2-worker.py'), '--backend', backend, '--output', str(output)]
    (output / (backend + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (output / (backend + '.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'backend': backend, 'pid': process.pid}
        dump()
        code = process.wait()
    status['completed'].append({'backend': backend, 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    dump()
    print('graph', backend, 'actual exit', code, flush=True)
status['complete'] = True
dump()
assert all(r['actual_exit'] == 0 for r in status['completed'])
rows = {}
for backend in ('original', 'source'):
    runtime = json.loads((output / (backend + '.runtime.json')).read_text())
    expected = ('64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63' if backend == 'original'
                else build['image_sha256'])
    assert runtime['image_sha256'] == expected and runtime['frames'] == 60
    for name, digest in runtime['sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
for mode in ('newton', 'pd'):
    for block in (0, 1):
        case = mode + '-b' + str(block)
        with ExitStack() as stack:
            arrays = {(backend, graph): stack.enter_context(np.load(output / (backend + '-' + case + '-' + str(graph) + '.npz'),
                                                                    allow_pickle=False))
                      for backend in ('original', 'source') for graph in (0, 1)}
            for saved in arrays.values():
                assert all(np.isfinite(saved[key]).all() for key in saved.files)
                assert saved['particle_q'].shape == (60, 12, 3) and saved['body_q'].shape == (60, 1, 7)
            for graph in (0, 1):
                rows[case + '-original-source-g' + str(graph)] = compare(arrays['original', graph], arrays['source', graph])
            for backend in ('original', 'source'):
                rows[case + '-' + backend + '-eager-graph'] = compare(arrays[backend, 0], arrays[backend, 1])
verify()
(output / 'independent-cpu-audit.json').write_text(json.dumps({'comparisons': rows,
    'passed': sum(row['bitwise'] for row in rows.values()), 'total': len(rows),
    'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
print('Actual60 eager/graph comparisons', sum(row['bitwise'] for row in rows.values()), '/', len(rows), flush=True)
