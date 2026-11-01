"""Current-image complete regression; preserve all first failures and fixed C10 cohorts."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys
root = Path.cwd().resolve()
sys.path.insert(0, str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
base = Path(__file__).resolve().parent
out = base.parent / 'validation-04b46fb0-self-tet'
build = root / 'build/reconstruction-csrc/host-particles/build.json'
saved = build.read_bytes()
metadata = json.loads(saved)
assert (out / 'build.json').read_bytes() == saved
assert json.loads((out / 'status.json').read_text())['complete']
(out / 'regression-driver.py').write_bytes(Path(__file__).read_bytes())
status = {'source_sha256': metadata['extension_sha256'], 'complete': False, 'finished': [], 'running': None}
def run(name, module, options):
    assert build.read_bytes() == saved
    for path, sha in metadata['sources'].items():
        assert hashlib.sha256((root / path).read_bytes()).hexdigest() == sha
    command = [sys.executable, '-m', 'reconstruction.csrc.' + module, *map(str, options)]
    status['running'] = name
    (out / 'regression-driver-status.json').write_text(json.dumps(status, indent=2) + '\n')
    (out / (name + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (out / (name + '.log')).open('w') as log:
        code = subprocess.run(command, env=clean_env(), stdout=log, stderr=subprocess.STDOUT,
                              timeout=14400).returncode
    status['finished'].append({'name': name, 'exit': code})
    print(name, code, flush=True)
    assert code in (0, 1)
run('regression74', 'joint_continuation_regression', ['--output', out / 'regression74'])
r = json.loads((out / 'regression74/status.json').read_text())
assert r['complete']
if any(row['exit'] for row in r['completed']):
    run('regression-fixed-C10', 'regression_fixed_spread',
        ['--validation', out, '--output', out / 'regression-fixed-C10'])
    run('regression-fixed-C10-cpu-audit', 'audit_regression_fixed_spread',
        ['--cohort', out / 'regression-fixed-C10', '--report', 'report.json',
         '--output', out / 'regression-fixed-C10/cpu-audit.json'])
status['complete'], status['running'] = True, None
(out / 'regression-driver-status.json').write_text(json.dumps(status, indent=2) + '\n')
