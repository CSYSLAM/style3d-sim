"""Capture a fixed 16-case self/tet/body suite before changing its source guard."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys

root = Path.cwd().resolve()
sys.path.insert(0, str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

output = Path(__file__).resolve().parent
build = root / 'build/reconstruction-csrc/host-particles/build.json'
saved = build.read_bytes()
(output / 'capture-build.json').write_bytes(saved)
fixture = root / 'reconstruction/csrc/affine_tetrahedron_self_scene.py'
runner = root / 'reconstruction/csrc/self_material_ab.py'
hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in (fixture, runner, Path(__file__))}
(output / 'capture-provenance.json').write_text(json.dumps(hashes, indent=2) + '\n')
cases = [f'tet-w{worlds}-{mode}-d{diagonal}' for worlds in (1, 3) for mode in ('newton', 'pd') for diagonal in (0, 1)]
for block in (False, True):
    assert build.read_bytes() == saved
    assert all(hashlib.sha256(Path(p).read_bytes()).hexdigest() == sha for p, sha in hashes.items())
    command = [sys.executable, '-m', 'reconstruction.csrc.self_material_ab', '--backend', 'original',
        '--fixture', str(fixture), '--particles-per-world', '24', '--only-case', *cases,
        '--output', str(output / ('original-b' + str(int(block))))]
    if block:
        command.append('--body-block')
    (output / f'original-b{int(block)}.command.json').write_text(json.dumps(command, indent=2) + '\n')
    with (output / f'original-b{int(block)}.log').open('w') as log:
        subprocess.run(command, cwd=root, env=clean_env(), stdout=log, stderr=subprocess.STDOUT, check=True, timeout=3600)
    print('original body/tet/self block', block, 'complete', flush=True)
