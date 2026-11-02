"""Run three predeclared SDK controls against the existing fixed SDK8 without extending any acceptance cohort."""
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

previous = BASE / 'graph-fixed-C8'
source_plan = json.loads((previous / 'plan.json').read_text())
source_status = json.loads((previous / 'status.json').read_text())
assert source_status['complete'] and source_status['running'] is None
assert len(source_status['completed']) == 3 and all(row['actual_exit'] == 0 for row in source_status['completed'])
groups = source_plan['groups']
assert len(groups) == 12
output = BASE / 'sdk-heldout3'
output.mkdir(exist_ok=False)
hashes = dict(source_plan['input_sha256'])
reference = ROOT / 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so'
reference_sha = '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
assert hashlib.sha256(reference.read_bytes()).hexdigest() == reference_sha
paths = [Path(__file__), previous / 'plan.json', previous / 'report.json', previous / 'status.json', reference]
paths += [previous / 'cohorts' / group['label'] / f'original{i}.npz' for group in groups for i in range(8)]
for path in paths:
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
(output / 'plan.json').write_text(json.dumps({
    'control_runs': 3, 'fixed_original_runs': 8, 'groups': groups, 'frames': 60, 'input_sha256': hashes,
    'controls_added_to_original_cohort': False, 'source_failures_rejudged': False,
    'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
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
    status['GPU_admission'].append({'control': index, 'UTC': datetime.now(timezone.utc).isoformat(),
                                   'free_memory_MiB': free, 'compute_apps': apps})
    assert free >= 4096
    folder = output / f'control{index}-worker'
    folder.mkdir()
    command = [sys.executable, '-B', str(BASE / 'graph-worker-v2.py'), '--backend', 'original', '--output', str(folder)]
    (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
    with (folder / 'run.log').open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env={**clean_env(), 'PYTHONDONTWRITEBYTECODE': '1'},
                                   stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'control': index, 'pid': process.pid}
        dump()
        code = process.wait()
    status['completed'].append({'control': index, 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    dump()
    assert code == 0
    runtime = json.loads((folder / 'original.runtime.json').read_text())
    assert runtime['backend'] == 'original' and runtime['image_sha256'] == reference_sha and runtime['frames'] == 60
    print('Independent SDK control', index, 'actual exit0', flush=True)
rows = []
for group in groups:
    with ExitStack() as stack:
        originals = [stack.enter_context(np.load(previous / 'cohorts' / group['label'] / f'original{i}.npz'))
                     for i in range(8)]
        controls = [stack.enter_context(np.load(output / f'control{i}-worker' /
                    ('original-' + group['case'] + '-' + str(group['graph']) + '.npz'))) for i in range(3)]
        assert all(set(data.files) == set(originals[0].files) for data in originals + controls)
        assert all(len(data[key]) == 60 and np.isfinite(data[key]).all() for data in originals + controls for key in data.files)
        statistics = [spread_report(originals, [control]) for control in controls]
        passed = [all(field['substeps_within_spread'] == field['substeps'] for field in result.values())
                  for result in statistics]
        rows.append({**group, 'control_C8_passed': passed, 'control_statistics': statistics})
status['complete'] = True
dump()
(output / 'report.json').write_text(json.dumps({
    'groups': rows, 'controls_added_to_original_cohort': False, 'source_failures_rejudged': False,
    'whole_solver_complete': False}, indent=2) + '\n')
print('Held-out SDK per-group passes', [(row['label'], row['control_C8_passed']) for row in rows], flush=True)
