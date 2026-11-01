"""Run the existing procedural beef demo through the fixed SDK and isolated source candidate, serially."""
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
from reconstruction.csrc.audit_cudahook import compare as compare_launches, schemas

build_path = BASE / 'candidate-guard-only/build.json'
build = json.loads(build_path.read_text())
fixture = ROOT / 'examples/example_granular_beaf.py'
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
output = BASE / 'beef-demo3'
output.mkdir(exist_ok=False)
extra = ['--resolution', '12', '--substeps', '1', '--iterations', '3', '--linear-iterations', '5', '--no-capture']
hashes = dict(build['input_sha256'])
for path in (Path(__file__), fixture, hook, BASE / 'candidate-worker.py'):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
(output / 'plan.json').write_text(json.dumps({'frames': 3, 'extra': extra, 'input_sha256': hashes,
    'source_sha256': build['image_sha256'], 'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'RECON_ORACLE_', 'DEMO_', 'CUPTI_'))
       and key not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'GRANULAR_AFFINE_MODEL_OUTPUT')}
rows = []
for backend in ('original', 'source'):
    for path, sha in hashes.items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == sha, path
    while subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip():
        time.sleep(5)
    folder = output / backend
    folder.mkdir()
    head = [str(BASE / 'candidate-worker.py'), '--candidate-build', str(build_path)] if backend == 'source' else \
        ['-m', 'reconstruction.csrc.demo_source_ab']
    command = [sys.executable, *head, '--worker', backend, '--tag', 'capture', '--example', str(fixture),
               '--frames', '3', '--output', str(folder), '--', *extra]
    (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
    with (folder / 'run.log').open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env={**env, 'LD_PRELOAD': str(hook), 'CUDAHOOK_DIR': str(folder)},
                                   stdout=log, stderr=subprocess.STDOUT)
        code = process.wait()
    rows.append({'backend': backend, 'pid': process.pid, 'actual_exit': code})
    (output / 'status.json').write_text(json.dumps({'completed': rows, 'complete': len(rows) == 2}, indent=2) + '\n')
    print('Existing beef demo', backend, 'actual exit', code, flush=True)
report = {'workers': rows, 'frames': 3, 'whole_solver_complete': False}
if all(row['actual_exit'] == 0 for row in rows):
    with np.load(output / 'original/capture.npz') as old, np.load(output / 'source/capture.npz') as new:
        assert all(np.isfinite(data[key]).all() for data in (old, new) for key in data.files)
        report['states'] = compare(old, new)
    report['metadata'] = compare_launches(output / 'original/launches.txt', output / 'source/launches.txt', schemas()[0])
(output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
raise SystemExit(int(not (report.get('states', {}).get('bitwise') and report.get('metadata', {}).get('equal'))))
