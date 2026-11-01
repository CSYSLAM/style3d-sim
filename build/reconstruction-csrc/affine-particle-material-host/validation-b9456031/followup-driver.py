"""Continue GPU validation serially after the main pinned-image queue, without replacing its first candidates."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time


root = Path.cwd()
output = Path(__file__).resolve().parent
build = root / 'build/reconstruction-csrc/host-particles/build.json'
saved = build.read_bytes()
assert json.loads(saved)['extension_sha256'] == 'b94560319d3a1c8aa7c898ce49b37748ae254ec30de28533deae292b4970a278'
while not (output / 'status.json').exists() or not json.loads((output / 'status.json').read_text()).get('complete'):
    assert build.read_bytes() == saved
    time.sleep(2)
jobs = [
    ('body-tet-constructor', 'reconstruction.csrc.affine_tetrahedron_constructor_ab',
     ['--output', str(output / 'body-tet-constructor')], [0]),
    ('regression-fixed-C10', 'reconstruction.csrc.regression_fixed_spread',
     ['--validation', str(output / 'full-validation'), '--output', str(output / 'regression-fixed-C10')], [0, 1]),
    ('regression-C10-cpu-audit', 'reconstruction.csrc.audit_regression_fixed_spread',
     ['--cohort', str(output / 'regression-fixed-C10'), '--report', 'report.json',
      '--output', str(output / 'regression-fixed-C10/cpu-audit.json')], [0]),
]
status = {'source_sha256': json.loads(saved)['extension_sha256'], 'jobs': [], 'complete': False,
          'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
for name, module, arguments, allowed in jobs:
    assert build.read_bytes() == saved
    command = [sys.executable, '-m', module, *arguments]
    (output / (name + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    start = time.monotonic()
    with (output / (name + '.log')).open('w') as log:
        result = subprocess.run(command, cwd=root, stdout=log, stderr=subprocess.STDOUT, timeout=14400)
    status['jobs'].append({'name': name, 'exit': result.returncode, 'seconds': time.monotonic() - start})
    (output / 'followup-status.json').write_text(json.dumps(status, indent=2) + '\n')
    print(name, result.returncode, flush=True)
    assert result.returncode in allowed, name
status['complete'] = True
(output / 'followup-status.json').write_text(json.dumps(status, indent=2) + '\n')
