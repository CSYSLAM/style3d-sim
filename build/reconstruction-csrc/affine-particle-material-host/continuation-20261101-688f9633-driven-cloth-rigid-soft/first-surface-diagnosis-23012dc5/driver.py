"""Diagnose the frozen first surface-force difference after the existing serial GPU queue ends."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys

root = Path.cwd().resolve()
sys.path.insert(0, str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
base = Path(__file__).resolve().parent
assert json.loads((base / 'after-regression-23012dc5/status.json').read_text())['complete']
case = base / 'fixed-C8-23012dc5/soft__surface-so3-w3-newton-b0'
output = base / 'first-surface-diagnosis-23012dc5'
output.mkdir(exist_ok=False)
(output / 'driver.py').write_bytes(Path(__file__).read_bytes())
build = root / 'build/reconstruction-csrc/host-particles/build.json'
saved = build.read_bytes()
metadata = json.loads(saved)
assert metadata['extension_sha256'] == '23012dc5b44e7b4694daa318bf2fc2e3186d984664d22e3ec0dfbf4cb7a4e046'
(output / 'build.json').write_bytes(saved)
status = {'source_sha256': metadata['extension_sha256'], 'complete': False, 'completed': [],
          'running': None, 'acceptance_cohort_changed': False, 'whole_solver_complete': False}
jobs = []
for backend in ('original', 'source'):
    jobs.append((backend + '-capture', ['-m', 'reconstruction.csrc.driven_cloth_surface_capture',
                 '--case', str(case), '--backend', backend, '--output', str(output / backend)]))
for backend in ('original', 'source'):
    jobs.append((backend + '-same-buffer-replay', ['-m', 'reconstruction.csrc.surface_common_input_replay',
                 '--capture', str(output / backend / 'first-packet'),
                 '--output', str(output / (backend + '-replay'))]))
for name, arguments in jobs:
    assert build.read_bytes() == saved
    for path, digest in metadata['sources'].items():
        assert hashlib.sha256((root / path).read_bytes()).hexdigest() == digest
    command = [sys.executable, *arguments]
    status['running'] = name
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
    (output / (name + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (output / (name + '.log')).open('w') as log:
        code = subprocess.run(command, cwd=root, env=clean_env(), stdout=log,
                              stderr=subprocess.STDOUT, timeout=3600).returncode
    status['completed'].append({'name': name, 'exit': code})
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
    assert code == 0, (name, code)
    print(name, code, flush=True)
left, right = [output / backend / 'first-packet' for backend in ('original', 'source')]
assert (left / 'fields.json').read_bytes() == (right / 'fields.json').read_bytes()
inputs = {p.name: p.read_bytes() == (right / p.name).read_bytes() for p in left.glob('*_pre_*.bin')}
# Input equality alone does not prove that observation reproduced either frozen target or its full trajectory.
(output / 'input-equality.json').write_text(json.dumps(inputs, indent=2) + '\n')
status['complete'], status['running'] = True, None
(output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
