"""Test three predeclared SDK controls against the frozen H1 SDK8 without extending that cohort."""
from contextlib import ExitStack
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.demo_ab import spread_report

cohort = BASE / 'public-h1-fixed-C8'
plan = json.loads((cohort / 'plan.json').read_text())
assert json.loads((cohort / 'status.json').read_text())['complete']
assert json.loads((cohort / 'report.json').read_text())['source_C8_passed'] == [True, False, False]
output = BASE / 'public-h1-sdk-heldout3'
output.mkdir(exist_ok=False)
hashes = dict(plan['input_sha256'])
for path in [Path(__file__), cohort / 'plan.json', cohort / 'report.json'] + [
        cohort / f'original{i}.npz' for i in range(8)]:
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
(output / 'plan.json').write_text(json.dumps({'input_sha256': hashes, 'control_runs': 3,
    'controls_added_to_fixed_SDK8': False, 'source_failures_rejudged': False, 'frames': 4,
    'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_admission': [], 'whole_solver_complete': False}


def dump():
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


dump()
for index in range(3):
    for name, expected in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
    free = int(subprocess.check_output(
        ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
    apps = subprocess.check_output(
        ['nvidia-smi', '--query-compute-apps=pid,process_name,used_memory', '--format=csv,noheader'], text=True).strip()
    status['GPU_admission'].append({'index': index, 'UTC': datetime.now(timezone.utc).isoformat(),
                                   'free_memory_MiB': free, 'compute_apps': apps})
    assert free >= 4096
    command = [sys.executable, '-B', str(BASE / 'public-h1-worker.py'), '--backend', 'original',
               '--core-build', str(BASE / 'candidate-public-core/build.json'), '--frames', '4',
               '--output', str(output / f'control{index}')]
    (output / f'control{index}.command.json').write_text(json.dumps(command, indent=2) + '\n')
    with (output / f'control{index}.log').open('w') as log:
        worker = subprocess.Popen(command, cwd=ROOT, env={**clean_env(), 'PYTHONDONTWRITEBYTECODE': '1'},
                                  stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'index': index, 'pid': worker.pid}
        dump()
        code = worker.wait()
    status['completed'].append({**status['running'], 'actual_exit': code})
    status['running'] = None
    dump()
    assert code == 0
    print('H1 SDK control', index, 'actual exit', code, flush=True)
with ExitStack() as stack:
    originals = [stack.enter_context(np.load(cohort / f'original{i}.npz', allow_pickle=False)) for i in range(8)]
    controls = [stack.enter_context(np.load(output / f'control{i}/states.npz', allow_pickle=False)) for i in range(3)]
    statistics = [spread_report(originals, [control], checkpoints=4) for control in controls]
    within = [all(row['substeps_within_spread'] == 4 for row in fields.values()) for fields in statistics]
(output / 'report.json').write_text(json.dumps({'control_statistics': statistics, 'control_C8_passed': within,
    'controls_added_to_fixed_SDK8': False, 'source_failures_rejudged': False, 'whole_solver_complete': False},
    indent=2) + '\n')
status['complete'] = True
dump()
print('H1 held-out SDK controls, unchanged fixed C8:', within, flush=True)
