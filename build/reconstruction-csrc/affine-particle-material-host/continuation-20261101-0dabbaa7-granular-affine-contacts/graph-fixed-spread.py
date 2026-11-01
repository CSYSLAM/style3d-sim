"""Keep the first 60-frame eager/graph samples and collect exactly eight SDK and three candidate workers."""
from contextlib import ExitStack
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import time

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.demo_ab import spread_report

initial = BASE / 'graph60-and-initcheck-v2'
assert json.loads((initial / 'status.json').read_text())['complete']
plan = json.loads((BASE / 'discovery-v2/plan.json').read_text())
build_path = BASE / 'candidate-guard-only/build.json'
build = json.loads(build_path.read_text())
worker = BASE / 'graph-worker-v2.py'
output = BASE / 'graph-fixed-C8'
output.mkdir(exist_ok=False)
hashes = dict(build['input_sha256'])
for path in (Path(__file__), worker, build_path, ROOT / 'reconstruction/csrc/affine_particle_spring_graph_ab.py',
             ROOT / 'reconstruction/csrc/granular_affine_contacts_scene.py'):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
groups = []
for case in plan['cases']:
    for graph in (0, 1):
        label = case['label'] + '-g' + str(graph)
        folder = output / 'cohorts' / label
        folder.mkdir(parents=True)
        for backend in ('original', 'source'):
            path = initial / 'graph60' / (backend + '-' + case['label'] + '-' + str(graph) + '.npz')
            hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
            shutil.copy2(path, folder / (backend + '0.npz'))
        groups.append({'label': label, 'case': case['label'], 'graph': graph})
(output / 'plan.json').write_text(json.dumps({'input_sha256': hashes, 'groups': groups, 'SDK_workers': 8,
    'source_workers': 3, 'frames': 60, 'full_case_and_mode_worker_order_preserved': True,
    'first_samples_replaced': False, 'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_waits': [], 'whole_solver_complete': False}
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'RECON_ORACLE_', 'DEMO_', 'CUPTI_'))
       and key not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'GRANULAR_AFFINE_MODEL_OUTPUT')}


def dump():
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


dump()
jobs = [('original', index) for index in range(1, 8)] + [('source', index) for index in range(1, 3)]
for backend, index in jobs:
    for path, sha in hashes.items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == sha, path
    while True:
        live = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
        status['GPU_waits'].append(live)
        dump()
        if not live:
            break
        time.sleep(5)
    tag = backend + str(index)
    folder = output / (tag + '-worker')
    folder.mkdir()
    command = [sys.executable, str(worker), '--backend', backend, '--output', str(folder)]
    (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
    with (folder / 'run.log').open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'tag': tag, 'pid': process.pid}
        dump()
        code = process.wait()
    status['completed'].append({'tag': tag, 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    dump()
    assert code == 0
    runtime = json.loads((folder / (backend + '.runtime.json')).read_text())
    expected = (build['image_sha256'] if backend == 'source' else
                '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63')
    assert runtime['image_sha256'] == expected and runtime['frames'] == 60
    for group in groups:
        source = folder / (backend + '-' + group['case'] + '-' + str(group['graph']) + '.npz')
        shutil.copy2(source, output / 'cohorts' / group['label'] / (tag + '.npz'))
    print(tag, 'actual exit0; six cases and both modes retained', flush=True)
reports = []
for group in groups:
    folder = output / 'cohorts' / group['label']
    with ExitStack() as stack:
        originals = [stack.enter_context(np.load(folder / f'original{i}.npz')) for i in range(8)]
        sources = [stack.enter_context(np.load(folder / f'source{i}.npz')) for i in range(3)]
        assert set(originals[0].files) == {'particle_q', 'particle_qd', 'body_q', 'body_qd', 'rigid_count', 'soft_count'}
        assert all(set(data.files) == set(originals[0].files) for data in originals + sources)
        assert all(len(data[key]) == 60 and np.isfinite(data[key]).all()
                   for data in originals + sources for key in data.files)
        first, all_sources = spread_report(originals, sources[:1]), spread_report(originals, sources)
    within = lambda values: all(row['substeps_within_spread'] == row['substeps'] for row in values.values())
    row = {**group, 'fixed_source0_within_C8': within(first), 'all3_sources_within_C8': within(all_sources),
           'source0_statistics': first, 'all3_statistics': all_sources, 'first_samples_replaced': False}
    reports.append(row)
    (output / 'report.json').write_text(json.dumps({'cases': reports, 'whole_solver_complete': False}, indent=2) + '\n')
    print(group['label'], 'source0', within(first), 'all three', within(all_sources), flush=True)
for path, sha in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == sha, path
status['complete'] = True
dump()
raise SystemExit(int(not all(row['fixed_source0_within_C8'] and row['all3_sources_within_C8'] for row in reports)))
