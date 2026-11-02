"""Preserve the first H1 pair and complete one fixed eight-SDK/three-source public API cohort."""
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
from reconstruction.csrc.host_api_probe import REFERENCE, REFERENCE_SHA
from reconstruction.demo_ab import compare, spread_report

core_path = BASE / 'candidate-public-core/build.json'
core = json.loads(core_path.read_text())
assert core['extension_sha256'] == 'aa3466efe4e3fbcdd65f9ba27b6edbe16857c5bd6fcd46aa0cdc83b7340c2830'
first = BASE / 'public-h1-probe'
first_status = json.loads((first / 'status.json').read_text())
assert first_status['complete'] and [row['actual_exit'] for row in first_status['completed']] == [0, 0]
output = BASE / 'public-h1-fixed-C8'
output.mkdir(exist_ok=False)
hashes = {str(ROOT / name): expected for name, expected in core['sources'].items()}
hashes[str(REFERENCE)] = REFERENCE_SHA
for path in (Path(__file__), BASE / 'public-h1-worker.py', core_path, BASE / 'h1-asset-manifest.json',
             ROOT / 'examples/example_cloth_h1_free.py', first / 'plan.json', first / 'status.json'):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
for backend in ('original', 'source'):
    for name in ('states.npz', 'before.npz', 'runtime.json', 'model-counts.json'):
        path = first / backend / name
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    shutil.copytree(first / backend, output / (backend + '0'))
    shutil.copyfile(first / backend / 'states.npz', output / (backend + '0.npz'))
jobs = [('original', index) for index in range(1, 8)] + [('source', index) for index in (1, 2)]
(output / 'plan.json').write_text(json.dumps({'input_sha256': hashes, 'jobs': jobs,
    'SDK_runs': 8, 'source_runs': 3, 'new_SDK_runs': 7, 'new_source_runs': 2, 'frames': 4,
    'source_core_sha256': core['extension_sha256'], 'reference_sha256': REFERENCE_SHA,
    'first_failed_source0_copied_byte_for_byte': True, 'first_original0_copied_byte_for_byte': True,
    'first_frame_capture_only_followed_by_three_replays': True, 'original_physics_and_test_final_modified': False,
    'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_admission': [], 'whole_solver_complete': False}


def dump():
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


dump()
for backend, index in jobs:
    for name, expected in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
    free = int(subprocess.check_output(
        ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
    apps = subprocess.check_output(
        ['nvidia-smi', '--query-compute-apps=pid,process_name,used_memory', '--format=csv,noheader'], text=True).strip()
    status['GPU_admission'].append({'backend': backend, 'index': index, 'UTC': datetime.now(timezone.utc).isoformat(),
                                   'free_memory_MiB': free, 'compute_apps': apps})
    assert free >= 4096
    folder = output / (backend + str(index))
    command = [sys.executable, '-B', str(BASE / 'public-h1-worker.py'), '--backend', backend,
               '--core-build', str(core_path), '--output', str(folder), '--frames', '4']
    (output / (folder.name + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (output / (folder.name + '.log')).open('w') as log:
        worker = subprocess.Popen(command, cwd=ROOT, env={**clean_env(), 'PYTHONDONTWRITEBYTECODE': '1'},
                                  stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'backend': backend, 'index': index, 'pid': worker.pid}
        dump()
        code = worker.wait()
    status['completed'].append({**status['running'], 'actual_exit': code})
    status['running'] = None
    dump()
    print(folder.name, 'H1 original graph/test actual exit', code, flush=True)
    assert code == 0
    shutil.copyfile(folder / 'states.npz', output / (folder.name + '.npz'))
with ExitStack() as stack:
    originals = [stack.enter_context(np.load(output / f'original{i}.npz', allow_pickle=False)) for i in range(8)]
    sources = [stack.enter_context(np.load(output / f'source{i}.npz', allow_pickle=False)) for i in range(3)]
    assert all(set(data.files) == set(originals[0].files) for data in originals + sources)
    assert all(len(data[key]) == 4 and np.isfinite(data[key]).all() for data in originals + sources for key in data.files)
    statistics = [spread_report(originals, [data], checkpoints=4) for data in sources]
    within = [all(row['substeps_within_spread'] == 4 for row in fields.values()) for fields in statistics]
    strict = [compare(originals[0], data) for data in sources]
(output / 'report.json').write_text(json.dumps({'source_statistics': statistics, 'source_C8_passed': within,
    'strict': strict, 'source0_replaced': False, 'whole_solver_complete': False}, indent=2) + '\n')
status['complete'] = True
dump()
print('H1 graph4 fixed C8:', within, flush=True)
raise SystemExit(int(not all(within)))
