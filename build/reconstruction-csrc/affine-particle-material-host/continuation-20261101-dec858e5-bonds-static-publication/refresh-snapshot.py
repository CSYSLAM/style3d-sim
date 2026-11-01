"""Pin finished current regression and provisional bond-constructor source, without claiming pending GPU gates."""
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path.cwd()
path = ROOT / 'RECONSTRUCTION_SNAPSHOT.json'
snapshot = json.loads(path.read_text())
prior = snapshot['files']
pyc = {name: item for name, item in prior.items() if name.endswith('.pyc')}
assert len(pyc) == snapshot['pyc_count'] == 360
changed = subprocess.check_output(['git', 'diff', '--cached', '--name-only', '--diff-filter=ACMRT', '-z'])
names = set(prior) | {name for name in changed.decode().split('\0') if name and name != path.name}
files = {}
for name in sorted(names):
    data = (ROOT / name).read_bytes()
    assert len(data) < 100 * 1024 * 1024, name
    files[name] = {'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()}
assert all(files[name] == item for name, item in pyc.items())
fixed = {
    'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so':
        '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63',
    'build/reconstruction-csrc/host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so':
        'dec858e551f015374453713edc46910028cae95a210b33acd6c9e9006a1c0282',
    'build/reconstruction-csrc/source-core/95f700673f9a3e0b/_core.cpython-312-x86_64-linux-gnu.so':
        '47ae97200081256af5f5530d180bca1f664fd31214474db4efc0216a52aec2e7',
}
for name, sha in fixed.items():
    assert files[name]['sha256'] == sha, name
reg = 'build/reconstruction-csrc/affine-particle-material-host/' \
    'continuation-20261101-granular-affine-production/validation-dec858e5/regression74/status.json'
status = json.loads((ROOT / reg).read_text())
assert status['complete'] and len(status['completed']) == 74
failed = [row['name'] for row in status['completed'] if row['exit']]
assert failed == ['particles-seed1', 'particles-seed2', 'particles-seed3']
validation = (ROOT / reg).parent.parent
cohort = json.loads((validation / 'regression-fixed-C10/report.json').read_text())
assert len(cohort['cases']) == 3 and all(row['every_array_and_step_within'] for row in cohort['cases'])
ctor = validation.parent / 'constructors-dec858e5/audit.json'
assert json.loads(ctor.read_text())['all_captured_checks_passed']
snapshot.update(current_host_regression74_status=reg, current_host_regression74_strict=71,
                current_host_regression74_failures=failed, current_host_fixed_C10_three_passed=True,
                current_host_constructor_five_checks_passed=True, checkpoint_runtime_validation_complete=False,
                solver_api_ready=False)
snapshot['checkpoint_note'] = 'Current 74:71 strict, three fixed C10/constructor passed; verified bond candidate not promoted'
snapshot['files'] = files
path.write_text(json.dumps(snapshot, indent=2) + '\n')
print(json.dumps({'files_before': len(prior), 'files_after': len(files), 'SDK_host_Core_360pyc_unchanged': True,
                  'current_regression74_strict': 71, 'three_current_fixed_C10_passed': True,
                  'whole_solver_complete': False}, indent=2))
