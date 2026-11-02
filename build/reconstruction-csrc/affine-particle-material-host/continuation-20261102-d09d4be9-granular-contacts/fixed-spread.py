"""Freeze the first two contact failures and run exactly eight SDK and three source trajectories per case."""
from contextlib import ExitStack
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.demo_ab import spread_report

LEGACY = BASE.parent / 'continuation-20261101-0dabbaa7-granular-affine-contacts'
discovery = LEGACY / 'discovery-v2'
plan = json.loads((discovery / 'plan.json').read_text())
initial = json.loads((BASE / 'candidate-captures/report.json').read_text())
failed = [row['case'] for row in initial['cases'] if not row['strict_passed']]
assert len(failed) == 2
cases = [case for case in plan['cases'] if case['label'] in failed]
build_path = BASE / 'candidate-guard-only/build.json'
build = json.loads(build_path.read_text())
worker = BASE / 'candidate-worker.py'
fixture = ROOT / 'reconstruction/csrc/granular_affine_contacts_scene.py'
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
hashes = dict(build['input_sha256'])
for path in (Path(__file__), build_path, worker, fixture, hook, BASE / 'candidate-captures/report.json'):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
output = BASE / 'fixed-C8'
output.mkdir(exist_ok=False)
snapshot = json.loads((ROOT / 'RECONSTRUCTION_SNAPSHOT.json').read_text())
for case in cases:
    folder = output / case['label']
    folder.mkdir()
    for index in range(8):
        source = LEGACY / 'fixed-C8' / case['label'] / f'original{index}.npz'
        expected = snapshot['files'][str(source.relative_to(ROOT))]
        assert hashlib.sha256(source.read_bytes()).hexdigest() == expected['sha256']
        hashes[str(source)] = expected['sha256']
        shutil.copy2(source, folder / f'original{index}.npz')
    source = BASE / 'candidate-captures' / case['label'] / 'capture.npz'
    hashes[str(source)] = hashlib.sha256(source.read_bytes()).hexdigest()
    shutil.copy2(source, folder / 'source0.npz')
(output / 'plan.json').write_text(json.dumps({'cases': cases, 'SDK_runs': 8, 'source_runs': 3,
    'first_original_and_source_replaced': False, 'input_sha256': hashes, 'new_SDK_runs': 0,
    'source_sha256': build['image_sha256'], 'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_admission': [], 'whole_solver_complete': False}
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'RECON_ORACLE_', 'DEMO_', 'CUPTI_'))
       and key not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'GRANULAR_AFFINE_MODEL_OUTPUT')}
env['PYTHONDONTWRITEBYTECODE'] = '1'
reports = []


def dump():
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


dump()
for case in cases:
    folder = output / case['label']
    jobs = [('source', index) for index in range(1, 3)]
    for backend, index in jobs:
        for name, sha in hashes.items():
            assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == sha, name
        free = int(subprocess.check_output(
            ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
        apps = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name,used_memory', '--format=csv,noheader'], text=True).strip()
        status['GPU_admission'].append({'case': case['label'], 'UTC': datetime.now(timezone.utc).isoformat(),
                                       'free_memory_MiB': free, 'compute_apps': apps})
        dump()
        assert free >= 4096
        tag = backend + str(index)
        destination = folder / (tag + '-worker')
        destination.mkdir()
        head = [str(worker), '--candidate-build', str(build_path)] if backend == 'source' else \
            ['-m', 'reconstruction.csrc.demo_source_ab']
        command = [sys.executable, '-B', *head, '--worker', backend, '--tag', 'capture', '--example', str(fixture),
                   '--frames', '3', '--output', str(destination), '--', *case['extra']]
        task_env = {**env, 'LD_PRELOAD': str(hook), 'CUDAHOOK_DIR': str(destination), 'CUDAHOOK_DUMP_LIMIT': '1',
                    'GRANULAR_AFFINE_MODEL_OUTPUT': str(destination),
                    'CUDAHOOK_DUMP': ';'.join(key + '=' + ','.join(str(i) + ':' + str(n) for i, n in fields.items())
                                            for key, fields in case['fields'].items())}
        (destination / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
        with (destination / 'run.log').open('w') as log:
            process = subprocess.Popen(command, cwd=ROOT, env=task_env, stdout=log, stderr=subprocess.STDOUT)
            status['running'] = {'case': case['label'], 'tag': tag, 'pid': process.pid}
            dump()
            code = process.wait()
        status['completed'].append({'case': case['label'], 'tag': tag, 'pid': process.pid, 'actual_exit': code})
        status['running'] = None
        dump()
        assert code == 0
        runtime = json.loads((destination / 'capture.runtime.json').read_text())
        assert runtime['image_sha256'] == (build['image_sha256'] if backend == 'source' else
            '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63')
        shutil.copy2(destination / 'capture.npz', folder / (tag + '.npz'))
        print(case['label'], tag, 'actual exit0', flush=True)
    with ExitStack() as stack:
        originals = [stack.enter_context(np.load(folder / f'original{i}.npz')) for i in range(8)]
        sources = [stack.enter_context(np.load(folder / f'source{i}.npz')) for i in range(3)]
        assert all(set(data.files) == set(originals[0].files) for data in originals + sources)
        assert all(np.isfinite(data[key]).all() for data in originals + sources for key in data.files)
        first = spread_report(originals, sources[:1], checkpoints=3)
        all_sources = spread_report(originals, sources, checkpoints=3)
    within = lambda values: all(row['substeps_within_spread'] == row['substeps'] for row in values.values())
    row = {'case': case['label'], 'fixed_source0_within_C8': within(first), 'all3_sources_within_C8': within(all_sources),
           'source0_replaced': False, 'source0_statistics': first, 'all3_statistics': all_sources}
    reports.append(row)
    (output / 'report.json').write_text(json.dumps({'cases': reports, 'whole_solver_complete': False}, indent=2) + '\n')
    print(case['label'], 'fixed source0 C8', within(first), 'all three', within(all_sources), flush=True)
for name, sha in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == sha, name
status['complete'] = True
dump()
raise SystemExit(int(not all(row['fixed_source0_within_C8'] and row['all3_sources_within_C8'] for row in reports)))
