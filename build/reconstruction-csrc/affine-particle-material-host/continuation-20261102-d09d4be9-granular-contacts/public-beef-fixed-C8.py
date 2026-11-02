"""Test three predeclared public Core runs of the existing beef configuration against its fixed eight SDK captures."""
from contextlib import ExitStack
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.demo_ab import compare, spread_report

legacy = BASE.parent / 'continuation-20261101-0dabbaa7-granular-affine-contacts/beef-fixed-C8'
old_plan = json.loads((legacy / 'plan.json').read_text())
extra = old_plan['extra']
assert extra == ['--resolution', '12', '--substeps', '1', '--iterations', '3', '--linear-iterations', '5', '--no-capture']
core_path = BASE / 'candidate-public-core/build.json'
core = json.loads(core_path.read_text())
assert core['source_host_sha256'] == 'ae3a599746804de7218285712a29428138ffe78892d6e28953d77408ed8264e8'
output = BASE / 'public-beef-fixed-C8'
output.mkdir(exist_ok=False)
example = ROOT / 'examples/example_granular_beaf.py'
assert hashlib.sha256(example.read_bytes()).hexdigest() == old_plan['input_sha256'][str(example)]
hashes = {str(ROOT / name): value for name, value in core['sources'].items()}
for path in (Path(__file__), BASE / 'public-demo-worker.py', core_path, example, legacy / 'plan.json'):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
for index in range(8):
    path = legacy / f'original{index}.npz'
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    shutil.copy2(path, output / f'original{index}.npz')
(output / 'plan.json').write_text(json.dumps({'input_sha256': hashes, 'SDK_runs': 8, 'source_runs': 3,
    'source_host_sha256': core['source_host_sha256'], 'source_core_sha256': core['extension_sha256'],
    'frames': 3, 'extra': extra, 'original_example_test_final_unmodified': True, 'new_SDK_runs': 0,
    'source0_is_first_run_of_current_public_Core': True, 'old_failures_rejudged': False,
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
    status['GPU_admission'].append({'source': index, 'UTC': datetime.now(timezone.utc).isoformat(),
                                   'free_memory_MiB': free, 'compute_apps': apps})
    assert free >= 4096
    capture = output / f'source{index}.npz'
    report = output / f'source{index}.runtime.json'
    command = [sys.executable, '-B', str(BASE / 'public-demo-worker.py'), '--core-build', str(core_path),
               '--report', str(report), str(example), '--', '--viewer', 'null', '--num-frames', '3', '--test', *extra]
    (output / f'source{index}.command.json').write_text(json.dumps(command, indent=2) + '\n')
    with (output / f'source{index}.log').open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT,
            env={**clean_env(), 'PYTHONDONTWRITEBYTECODE': '1', 'PUBLIC_DEMO_STATES': str(capture)},
            stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'source': index, 'pid': process.pid}
        dump()
        code = process.wait()
    status['completed'].append({'source': index, 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    dump()
    assert code == 0
    runtime = json.loads(report.read_text())
    assert runtime['exit'] == 0 and runtime['source_sha256'] == core['extension_sha256']
    assert runtime['public_core_abi'] and not runtime['ab_bridge_used'] and not runtime['reference_solver_mapped']
    print('Normal public beef3 source', index, 'actual exit0, no SDK or bridge, original test_final passed', flush=True)
with ExitStack() as stack:
    originals = [stack.enter_context(np.load(output / f'original{i}.npz')) for i in range(8)]
    sources = [stack.enter_context(np.load(output / f'source{i}.npz')) for i in range(3)]
    assert all(set(data.files) == set(originals[0].files) for data in originals + sources)
    assert all(len(data[key]) == 3 and np.isfinite(data[key]).all() for data in originals + sources for key in data.files)
    statistics = [spread_report(originals, [run], checkpoints=3) for run in sources]
    within = [all(value['substeps_within_spread'] == 3 for value in fields.values()) for fields in statistics]
    strict = [compare(originals[0], run) for run in sources]
(output / 'report.json').write_text(json.dumps({'source_statistics': statistics, 'source_C8_passed': within,
    'strict': strict, 'source0_replaced': False, 'whole_solver_complete': False}, indent=2) + '\n')
status['complete'] = True
dump()
print('Normal public beef3 fixed SDK8: three current Core trajectories within', within, flush=True)
raise SystemExit(int(not all(within)))
