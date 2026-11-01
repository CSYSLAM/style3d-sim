"""Run one SDK and three source graph-definition diagnostics without adding them to the fixed cohorts."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
old = BASE.parent / 'continuation-20261101-0dabbaa7-granular-affine-contacts'
case = 'w3-b1-n2-s1-mixed-pd-b0-both-hit0'
cohort = old / 'graph-fixed-C8/cohorts' / (case + '-g1')
output = BASE / 'definitions4'
output.mkdir(exist_ok=False)
build = json.loads((old / 'candidate-guard-only/build.json').read_text())
paths = [Path(__file__), BASE / 'definition-worker.py', ROOT / 'reconstruction/csrc/graph_definition_dump.py',
         old / 'graph60-and-initcheck-v2/graph60/original-graph-as-run.py',
         *sorted(cohort.glob('*.npz'))]
hashes = dict(build['input_sha256'])
hashes.update({str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in paths})
runs = ['original', 'source', 'source', 'source']
(output / 'plan.json').write_text(json.dumps({'runs': runs, 'frames': 60, 'target': case,
    'input_sha256': hashes, 'fixed_cohort_expanded': False, 'first_samples_replaced': False,
    'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_waits': [], 'whole_solver_complete': False}
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'RECON_ORACLE_', 'DEMO_', 'CUPTI_'))
       and key not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'GRANULAR_AFFINE_MODEL_OUTPUT')}


def dump():
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


dump()
for index, backend in enumerate(runs):
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
    folder = output / str(index)
    command = [sys.executable, str(BASE / 'definition-worker.py'), '--backend', backend, '--output', str(folder)]
    (output / (str(index) + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (output / (str(index) + '.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'index': index, 'backend': backend, 'pid': process.pid}
        dump()
        code = process.wait()
    row = {'index': index, 'backend': backend, 'pid': process.pid, 'actual_exit': code}
    status['completed'].append(row)
    status['running'] = None
    dump()
    assert code == 0
    provenance = json.loads((folder / 'provenance.json').read_text())
    assert provenance['complete']
    path = folder / (backend + '-' + case + '-1.npz')
    with np.load(path, allow_pickle=False) as actual:
        for tag in ('original0', 'source0'):
            with np.load(cohort / (tag + '.npz'), allow_pickle=False) as frozen:
                assert set(actual.files) == set(frozen.files)
                same = {key: actual[key].tobytes() == frozen[key].tobytes() for key in frozen.files}
                row[tag + '_whole_trajectory_bitwise'] = all(same.values())
                row[tag + '_per_array'] = same
    dump()
    print(index, backend, 'actual0; frozen original0', row['original0_whole_trajectory_bitwise'],
          'source0', row['source0_whole_trajectory_bitwise'], flush=True)
status['complete'] = True
dump()
