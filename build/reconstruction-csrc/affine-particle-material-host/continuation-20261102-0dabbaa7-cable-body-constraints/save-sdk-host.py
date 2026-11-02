"""Save the actual fixed SDK's host functions before changing any isolated candidate scope."""
import hashlib
import json
from pathlib import Path
import subprocess

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
image = ROOT / 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so'
expected = '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
assert hashlib.sha256(image.read_bytes()).hexdigest() == expected
rows = []
for name, begin, end in (('step', 0xfb060, 0x104370), ('precompute', 0x104370, 0x10cd30),
                         ('initialize', 0x10cd30, 0x10f2f0)):
    command = ['objdump', '-d', '-C', f'--start-address={begin:#x}', f'--stop-address={end:#x}', str(image)]
    target = BASE / ('SDK-' + name + '.asm')
    assert not target.exists()
    result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=False)
    assert result.returncode == 0 and not result.stderr
    target.write_bytes(result.stdout)
    rows.append({'name': name, 'command': command, 'actual_exit': result.returncode,
                 'path': str(target), 'bytes': len(result.stdout), 'sha256': hashlib.sha256(result.stdout).hexdigest()})
(BASE / 'SDK-host-provenance.json').write_text(json.dumps({
    'image': str(image), 'image_sha256': expected, 'functions': rows,
    'script_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    'production_modified': False, 'whole_solver_complete': False}, indent=2) + '\n')
print('Saved actual fixed SDK step/precompute/initialize; no solver code changed')
