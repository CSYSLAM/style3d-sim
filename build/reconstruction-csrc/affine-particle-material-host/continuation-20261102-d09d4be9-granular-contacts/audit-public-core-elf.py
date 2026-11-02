"""Verify the final public Core export and linked libraries directly from the compiled ELF."""
import hashlib
import json
from pathlib import Path
import subprocess

BASE = Path(__file__).resolve().parent
folder = BASE / 'candidate-public-core'
metadata = json.loads((folder / 'build.json').read_text())
image = folder / '_core.cpython-312-x86_64-linux-gnu.so'
assert hashlib.sha256(image.read_bytes()).hexdigest() == metadata['extension_sha256']
dynamic = subprocess.check_output(['readelf', '-d', str(image)], text=True)
symbols = subprocess.check_output(['nm', '-D', '--defined-only', str(image)], text=True)
needed = [line.split('[', 1)[1].split(']', 1)[0] for line in dynamic.splitlines() if '(NEEDED)' in line]
assert needed and 'libstdc++.so.6' in needed
initializers = [line.split()[-1] for line in symbols.splitlines() if ' PyInit_' in line]
assert initializers == ['PyInit__core']
assert all('_core' not in name and 'synreal' not in name and 'style3d' not in name for name in needed)
(folder / 'elf-dynamic.txt').write_text(dynamic)
(folder / 'elf-exports.txt').write_text(symbols)
(folder / 'elf-independent-cpu.json').write_text(json.dumps({
    'image_sha256': metadata['extension_sha256'], 'initialization_symbols': initializers,
    'ELF_needed': needed, 'SDK_ELF_dependency_absent': True, 'GPU_runs': 0,
    'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    'whole_solver_complete': False}, indent=2) + '\n')
print('Public Core ELF has sole PyInit__core and no SDK dependency:', needed)
