"""Compare six real eager/graph trajectories and run dual SDK/source initialization sanitizers."""
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

ctor = BASE / 'constructors-guard-only'
assert json.loads((ctor / 'status.json').read_text())['complete']
assert len(json.loads((ctor / 'report.json').read_text())['cases']) == 3
build_path = BASE / 'candidate-guard-only/build.json'
build = json.loads(build_path.read_text())
plan = json.loads((BASE / 'discovery-v2/plan.json').read_text())
output = BASE / 'graph60-and-initcheck-v2'
output.mkdir(exist_ok=False)
graph = output / 'graph60'
graph.mkdir()
paths = [Path(__file__), BASE / 'graph-worker-v2.py', BASE / 'candidate-worker.py', build_path,
         ROOT / 'reconstruction/csrc/affine_particle_spring_graph_ab.py', ROOT / 'reconstruction/demo_ab.py',
         ROOT / 'reconstruction/csrc/granular_affine_contacts_scene.py', BASE / 'discovery-v2/plan.json']
hashes = dict(build['input_sha256'])
hashes.update({str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths})
hashes[build['image']] = build['image_sha256']
(output / 'plan.json').write_text(json.dumps({'input_sha256': hashes, 'frames': 60,
    'source_sha256': build['image_sha256'], 'fixed_cases': plan['cases'],
    'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_waits': [], 'whole_solver_complete': False}


def dump():
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


def verify():
    for name, sha in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == sha, name


env = {k: v for k, v in os.environ.items() if not k.startswith(('CUDAHOOK_', 'RECON_ORACLE_', 'DEMO_', 'CUPTI_'))
       and k not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'GRANULAR_AFFINE_MODEL_OUTPUT')}


def run(label, command, folder):
    verify()
    while True:
        live = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
        status['GPU_waits'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'compute_apps': live})
        dump()
        if not live:
            break
        time.sleep(5)
    (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
    with (folder / 'run.log').open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'label': label, 'pid': process.pid}
        dump()
        code = process.wait()
    status['completed'].append({'label': label, 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    dump()
    print(label, 'actual exit', code, flush=True)
    assert code == 0
    verify()


dump()
for backend in ('original', 'source'):
    logs = output / ('graph-' + backend)
    logs.mkdir()
    run('graph-' + backend, [sys.executable, str(BASE / 'graph-worker-v2.py'), '--backend', backend,
                             '--output', str(graph)], logs)
    runtime = json.loads((graph / (backend + '.runtime.json')).read_text())
    expected = ('64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
                if backend == 'original' else build['image_sha256'])
    assert runtime['image_sha256'] == expected and runtime['frames'] == 60
    for name, sha in runtime['sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == sha, name
rows = {}
for case in plan['cases']:
    name, worlds, n, bodies = case['label'], case['worlds'], case['width'] ** 3, case['bodies']
    with ExitStack() as stack:
        arrays = {(backend, g): stack.enter_context(np.load(graph / (backend + '-' + name + '-' + str(g) + '.npz'),
                                                           allow_pickle=False))
                  for backend in ('original', 'source') for g in (0, 1)}
        for saved in arrays.values():
            assert all(np.isfinite(saved[key]).all() for key in saved.files)
            assert saved['particle_q'].shape == (60, worlds * (n + 4 * bodies), 3)
            assert saved['body_q'].shape == (60, worlds * bodies, 7)
        for g in (0, 1):
            rows[name + '-cross-g' + str(g)] = compare(arrays['original', g], arrays['source', g])
        for backend in ('original', 'source'):
            rows[name + '-' + backend + '-eager-graph'] = compare(arrays[backend, 0], arrays[backend, 1])
report = {'comparisons': rows, 'passed': sum(row['bitwise'] for row in rows.values()), 'total': len(rows),
          'production_changed': False, 'whole_solver_complete': False}
(output / 'graph-report.json').write_text(json.dumps(report, indent=2) + '\n')
print('Actual60 graph comparisons', report['passed'], '/', report['total'], flush=True)
for backend in ('original', 'source'):
    for index in (0, 1, 4):
        case = plan['cases'][index]
        folder = output / ('initcheck-' + backend + '-' + case['label'])
        folder.mkdir()
        command = ['compute-sanitizer', '--tool', 'initcheck', '--error-exitcode', '97', sys.executable,
                   str(BASE / 'candidate-worker.py'), '--candidate-build', str(build_path), '--worker', backend,
                   '--tag', 'capture', '--example', str(ROOT / 'reconstruction/csrc/granular_affine_contacts_scene.py'),
                   '--frames', '3', '--output', str(folder), '--', *case['extra']]
        run('initcheck-' + backend + '-' + case['label'], command, folder)
        assert 'ERROR SUMMARY: 0 errors' in (folder / 'run.log').read_text()
status['complete'] = True
dump()
verify()
print('Graph and six sanitizer tasks terminal; strict graph differences retained if any', flush=True)
