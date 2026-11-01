"""Capture one SDK and three source diagnostics for the current fixed PD failure without changing its cohort."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys

import numpy as np

root = Path.cwd()
sys.path.insert(0, str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

base = Path(__file__).resolve().parent
validation = base.parent / 'continuation-20261101-141c18f6-plain-contact/validation-eb661284'
cohort = validation / 'regression-fixed-C10/pd_mixed_cloth-seed3'
target = 'pd_mixed_w129_duplicates'
build_path = root / 'build/reconstruction-csrc/host-particles/build.json'
saved = build_path.read_bytes()
build = json.loads(saved)
assert build['extension_sha256'] == 'eb661284fd3852610e81857ccb7cc5731f76a843abd417e8772bdd6693a4efb7'
old = base.parent / 'continuation-20261031-86916989-fixed-failures'
old_build = json.loads((old / 'frozen-reproduced-mixed-pair/solver-build.json').read_text())
assert build['kernels'] == old_build['kernels'], 'Do not reuse a diagnostic observer across changed kernel ABIs'
observer = base / 'raw-only-observer/deferred-raw-only.so'
helper = root / 'reconstruction/csrc/regression_failure_trace.py'
files = (Path(__file__), observer, base / 'raw-only-observer/deferred-raw-only.cpp', helper,
         root / 'reconstruction/csrc/host_particles_ab.py',
         *sorted((root / 'reconstruction/csrc').glob('*host_cases.py')))
hashes = {str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in files}
frozen = {side: cohort / name for side, name in (('legacy', 'original0.npz'), ('source', 'source0.npz'))}
frozen_hashes = {side: hashlib.sha256(path.read_bytes()).hexdigest() for side, path in frozen.items()}
assert not json.loads((cohort / 'report.json').read_text())['every_array_and_step_within']
output = base / 'raw-only-trace4'
output.mkdir(exist_ok=False)
(output / 'driver-as-run.py').write_bytes(Path(__file__).read_bytes())
(output / 'build.json').write_bytes(saved)
(output / 'plan.json').write_text(json.dumps({
    'runs': ['legacy', 'source', 'source', 'source'], 'target': target,
    'observer_sha256': hashes[str(observer)], 'input_sha256': hashes, 'frozen_sha256': frozen_hashes,
    'deferred_capture': True, 'full_worker_order_preserved': True,
    'production_changed': False, 'cohort_expanded': False, 'frozen_candidate_replaced': False,
}, indent=2) + '\n')
rows = []
for number, side in enumerate(('legacy', 'source', 'source', 'source')):
    assert build_path.read_bytes() == saved
    assert all(hashlib.sha256(Path(path).read_bytes()).hexdigest() == sha for path, sha in hashes.items())
    for path, digest in build['sources'].items():
        assert hashlib.sha256((root / path).read_bytes()).hexdigest() == digest, path
    assert all(hashlib.sha256(path.read_bytes()).hexdigest() == frozen_hashes[tag] for tag, path in frozen.items())
    folder = output / str(number)
    command = [sys.executable, '-m', 'reconstruction.csrc.regression_failure_trace', '--backend', side,
               '--output', str(folder), '--scenario', 'pd_mixed_cloth', '--seed', '3', '--case', target]
    (output / f'{number}.command.json').write_text(json.dumps(command, indent=2) + '\n')
    (output / 'status.json').write_text(json.dumps({'complete': False, 'running': number, 'rows': rows}, indent=2) + '\n')
    with (output / f'{number}.log').open('w') as log:
        code = subprocess.run(command, cwd=root, env={**clean_env(), 'LD_PRELOAD': str(observer)},
                              stdout=log, stderr=subprocess.STDOUT, timeout=1800).returncode
    row = {'run': number, 'backend': side, 'exit': code, 'target': target, 'diagnostic_only': True}
    if code == 0:
        native = folder / 'native'
        row['receipt'] = json.loads((native / 'deferred-receipt.json').read_text())
        actual = folder / f'{side}-seed3.npz'
        with np.load(frozen[side]) as a, np.load(actual) as b:
            keys = [key for key in a.files if key.startswith(target + '/')]
            assert len(keys) == 18 and all(key in b for key in keys)
            matches = {key: a[key].dtype == b[key].dtype and a[key].shape == b[key].shape
                       and a[key].tobytes() == b[key].tobytes() for key in keys}
            row.update(target_arrays=18, target_arrays_equal=sum(matches.values()),
                       frozen_target_reproduced=all(matches.values()), per_array=matches)
            applies = sorted(native.glob('*.20apply_nonlinear_stepE.after.q.bin'))
            velocities = sorted(native.glob('*.15update_velocityE.after.v.bin'))
            assert len(applies) == 9 and len(velocities) == 3
            for step in range(3):
                assert applies[step * 3 + 2].read_bytes() == b[f'{target}/{step}/out.particle_q'].tobytes()
                assert velocities[step].read_bytes() == b[f'{target}/{step}/out.particle_qd'].tobytes()
            row['deferred_public_step_outputs_equal'] = True
        row['actual_npz_sha256'] = hashlib.sha256(actual.read_bytes()).hexdigest()
    rows.append(row)
    (output / 'report.json').write_text(json.dumps({
        'source_sha256': build['extension_sha256'], 'rows': rows, 'complete': len(rows) == 4,
        'original_frozen_npz_sha256': frozen_hashes['legacy'], 'source_frozen_npz_sha256': frozen_hashes['source'],
        'original_cohort_changed': False, 'frozen_candidate_replaced': False,
        'production_changed': False, 'whole_solver_complete': False,
    }, indent=2) + '\n')
    print(number, side, code, row.get('target_arrays_equal'), '/18 frozen arrays reproduced', flush=True)
    assert code == 0, (number, side, code)
(output / 'status.json').write_text(json.dumps({'complete': True, 'running': None, 'rows': rows}, indent=2) + '\n')
