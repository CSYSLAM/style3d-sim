"""Retain both first beef-demo samples and collect a fixed SDK8/source3 cohort without login."""
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

first = BASE / 'beef-demo3'
original_plan = json.loads((first / 'plan.json').read_text())
assert all(row['actual_exit'] == 0 for row in json.loads((first / 'status.json').read_text())['completed'])
build_path = BASE / 'candidate-guard-only/build.json'
build = json.loads(build_path.read_text())
output = BASE / 'beef-fixed-C8'
output.mkdir(exist_ok=False)
hashes = dict(original_plan['input_sha256'])
hashes[str(Path(__file__))] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
for backend in ('original', 'source'):
    path = first / backend / 'capture.npz'
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    shutil.copy2(path, output / (backend + '0.npz'))
(output / 'plan.json').write_text(json.dumps({'SDK_runs': 8, 'source_runs': 3, 'frames': 3,
    'extra': original_plan['extra'], 'input_sha256': hashes, 'first_samples_replaced': False,
    'whole_solver_complete': False}, indent=2) + '\n')
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'RECON_ORACLE_', 'DEMO_', 'CUPTI_'))
       and key not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'GRANULAR_AFFINE_MODEL_OUTPUT')}
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
rows = []
for backend, index in [('original', i) for i in range(1, 8)] + [('source', i) for i in range(1, 3)]:
    for path, sha in hashes.items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == sha, path
    while subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip():
        time.sleep(5)
    tag = backend + str(index)
    folder = output / (tag + '-worker')
    folder.mkdir()
    head = [str(BASE / 'candidate-worker.py'), '--candidate-build', str(build_path)] if backend == 'source' else \
        ['-m', 'reconstruction.csrc.demo_source_ab']
    command = [sys.executable, *head, '--worker', backend, '--tag', 'capture', '--example',
               str(ROOT / 'examples/example_granular_beaf.py'), '--frames', '3', '--output', str(folder),
               '--', *original_plan['extra']]
    (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
    with (folder / 'run.log').open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env={**env, 'LD_PRELOAD': str(hook), 'CUDAHOOK_DIR': str(folder)},
                                   stdout=log, stderr=subprocess.STDOUT)
        code = process.wait()
    rows.append({'tag': tag, 'pid': process.pid, 'actual_exit': code})
    (output / 'status.json').write_text(json.dumps({'completed': rows, 'complete': False}, indent=2) + '\n')
    assert code == 0
    runtime = json.loads((folder / 'capture.runtime.json').read_text())
    assert runtime['image_sha256'] == (build['image_sha256'] if backend == 'source' else
        '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63')
    shutil.copy2(folder / 'capture.npz', output / (tag + '.npz'))
    print('Existing beef demo', tag, 'actual exit0', flush=True)
with ExitStack() as stack:
    originals = [stack.enter_context(np.load(output / f'original{i}.npz')) for i in range(8)]
    sources = [stack.enter_context(np.load(output / f'source{i}.npz')) for i in range(3)]
    assert all(set(data.files) == set(originals[0].files) for data in originals + sources)
    assert all(len(data[key]) == 3 and np.isfinite(data[key]).all() for data in originals + sources for key in data.files)
    first_statistics, all_statistics = spread_report(originals, sources[:1], checkpoints=3), \
        spread_report(originals, sources, checkpoints=3)
within = lambda values: all(row['substeps_within_spread'] == row['substeps'] for row in values.values())
report = {'fixed_source0_within_C8': within(first_statistics), 'all3_sources_within_C8': within(all_statistics),
          'source0_statistics': first_statistics, 'all3_statistics': all_statistics, 'first_samples_replaced': False,
          'whole_solver_complete': False}
(output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
(output / 'status.json').write_text(json.dumps({'completed': rows, 'complete': True}, indent=2) + '\n')
print('Beef demo fixed source0 C8', within(first_statistics), 'all three', within(all_statistics), flush=True)
raise SystemExit(int(not within(first_statistics) or not within(all_statistics)))
