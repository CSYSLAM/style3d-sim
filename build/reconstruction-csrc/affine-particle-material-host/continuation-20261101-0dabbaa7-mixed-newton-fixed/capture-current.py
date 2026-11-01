"""Capture the current fixed mixed failure in full worker order; keep all four planned diagnostics."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

parent = BASE.parent
production = parent / 'continuation-20261101-granular-affine-bonds-production/validation-0dabbaa7-v2'
frozen = production / 'regression-fixed-C10/mixed_cloth-seed3'
historical = parent / 'continuation-20261031-86916989-fixed-failures'
observer = historical / 'deferred-observer/deferred-observer.so'
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
saved = build_path.read_bytes()
build = json.loads(saved)
assert build['extension_sha256'] == '0dabbaa7a57b57187549f814632efebdc5612095765932be112c2c9ca1868e3e'
sdk = ROOT / 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so'
sdk_sha = '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
paths = [Path(__file__), observer, sdk, build_path,
         ROOT / 'reconstruction/csrc/regression_failure_trace.py',
         ROOT / 'reconstruction/csrc/host_particles_ab.py', ROOT / 'reconstruction/csrc/mixed_cloth_host_cases.py',
         *sorted(path for path in frozen.rglob('*') if path.is_file())]
hashes = {str(ROOT / name): sha for name, sha in build['sources'].items()}
hashes.update({str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in paths})
assert hashes[str(sdk)] == sdk_sha
output = BASE / 'traces4'
output.mkdir(exist_ok=False)
(output / 'solver-build.json').write_bytes(saved)
target = 'mixed_w129_duplicates'
runs = ['legacy', 'source', 'source', 'source']
plan = {'runs': runs, 'target': target, 'scenario': 'mixed_cloth', 'seed': 3,
        'input_sha256': hashes, 'source_sha256': build['extension_sha256'], 'reference_sha256': sdk_sha,
        'deferred_observer': str(observer), 'full_worker_order_preserved': True,
        'frozen_source0_replaced': False, 'fixed_cohort_expanded': False, 'whole_solver_complete': False}
(output / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_waits': [], 'whole_solver_complete': False}


def dump():
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


def verify():
    assert build_path.read_bytes() == saved
    for name, sha in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == sha, name


dump()
for index, backend in enumerate(runs):
    verify()
    while True:
        live = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
        status['GPU_waits'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'compute_apps': live})
        dump()
        if not live:
            break
        time.sleep(5)
    folder = output / str(index)
    command = [sys.executable, '-m', 'reconstruction.csrc.regression_failure_trace', '--backend', backend,
               '--output', str(folder), '--scenario', 'mixed_cloth', '--seed', '3', '--case', target]
    (output / (str(index) + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (output / (str(index) + '.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env={**clean_env(), 'LD_PRELOAD': str(observer)},
                                   stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'index': index, 'backend': backend, 'pid': process.pid}
        dump()
        code = process.wait()
    row = {'index': index, 'backend': backend, 'pid': process.pid, 'actual_exit': code}
    status['completed'].append(row)
    status['running'] = None
    dump()
    assert code == 0, row
    runtime = json.loads((folder / 'diagnostic-runtime.json').read_text())
    assert runtime['image_sha256'] == (sdk_sha if backend == 'legacy' else build['extension_sha256'])
    assert runtime['full_worker_order_preserved'] and runtime['target'] == target
    if backend == 'source':
        source_runtime = json.loads((folder / 'source-seed3.runtime.json').read_text())
        assert not source_runtime['original_solver_mapped'] and source_runtime['source_only']
    native = folder / 'native'
    row['deferred_receipt'] = json.loads((native / 'deferred-receipt.json').read_text())
    actual = folder / (backend + '-seed3.npz')
    with np.load(actual, allow_pickle=False) as arrays:
        assert all(np.isfinite(arrays[key]).all() for key in arrays.files)
        for reference in ('original0', 'source0'):
            with np.load(frozen / (reference + '.npz'), allow_pickle=False) as expected:
                keys = sorted(key for key in expected.files if key.startswith(target + '/'))
                assert len(keys) == 18 and all(key in arrays.files for key in keys)
                equal = {key: expected[key].tobytes() == arrays[key].tobytes() for key in keys}
                row[reference + '_target'] = {'all_arrays_bitwise': all(equal.values()), 'per_array': equal}
        applies = sorted(native.glob('*.20apply_nonlinear_stepE.after.q.bin'))
        velocities = sorted(native.glob('*.15update_velocityE.after.v.bin'))
        assert len(applies) == 9 and len(velocities) == 3
        for step in range(3):
            assert applies[step * 3 + 2].read_bytes() == arrays[f'{target}/{step}/out.particle_q'].tobytes()
            assert velocities[step].read_bytes() == arrays[f'{target}/{step}/out.particle_qd'].tobytes()
    row['captured_outputs_match_public_states'] = True
    row['actual_npz_sha256'] = hashlib.sha256(actual.read_bytes()).hexdigest()
    dump()
    print(index, backend, 'original0', row['original0_target']['all_arrays_bitwise'],
          'source0', row['source0_target']['all_arrays_bitwise'], flush=True)
verify()
status['complete'] = True
dump()
print('Four planned diagnostics complete; fixed failure and cohort unchanged', flush=True)
