"""Run only serial, immutable-image contact-scope checks; retain all nonzero results."""
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys

root = Path.cwd().resolve()
sys.path.insert(0, str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

base = Path(__file__).resolve().parent
build = root / 'build/reconstruction-csrc/host-particles/build.json'
saved = build.read_bytes()
image = json.loads(saved)['extension_sha256']
out = base.parent / ('validation-' + image[:8] + '-tet-contact')
out.mkdir(exist_ok=False)
(out / 'build.json').write_bytes(saved)
(out / 'driver.py').write_bytes(Path(__file__).read_bytes())
python = sys.executable
tasks = [
    ('source16', [python, '-m', 'reconstruction.csrc.affine_tetrahedron_contact_ab', '--backend', 'source',
                  '--references', str(base / 'original16-view-aware'), '--output', str(out / 'source-first16')]),
    ('graph60', [python, '-m', 'reconstruction.csrc.affine_tetrahedron_contact_graph_ab',
                 '--output', str(out / 'graph60')]),
    ('constructor', [python, '-m', 'reconstruction.csrc.affine_tetrahedron_contact_constructor_ab',
                     '--output', str(out / 'constructor')]),
]
sanitizer = shutil.which('compute-sanitizer')
assert sanitizer
for backend in ('original', 'source'):
    folder = out / ('initcheck3-' + backend)
    tasks.append(('initcheck3-' + backend, [sanitizer, '--tool', 'initcheck', '--error-exitcode', '99',
                  python, '-m', 'reconstruction.csrc.affine_tetrahedron_contact_graph_ab', '--worker', backend,
                  '--frames', '3', '--output', str(folder)]))
status = {'image_sha256': image, 'complete': False, 'running': None, 'finished': [], 'whole_solver_complete': False}
for name, command in tasks:
    assert build.read_bytes() == saved
    if name.startswith('initcheck'):
        Path(command[-1]).mkdir(exist_ok=False)
    status['running'] = name
    (out / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
    (out / (name + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (out / (name + '.log')).open('w') as log:
        code = subprocess.run(command, cwd=root, env=clean_env(), stdout=log, stderr=subprocess.STDOUT,
                              timeout=7200).returncode
    status['finished'].append({'name': name, 'exit': code})
    print(name, 'exit', code, flush=True)
assert build.read_bytes() == saved
status['running'] = None
status['complete'] = True
(out / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
print('validation_output', out, flush=True)
