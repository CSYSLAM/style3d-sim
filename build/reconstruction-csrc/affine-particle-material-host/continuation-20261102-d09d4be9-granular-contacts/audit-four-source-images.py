"""Check actual NEEDED entries for production and candidate images without relying on localized labels."""
import hashlib
import json
from pathlib import Path
import subprocess

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
images = [
    ('production-host', ROOT / 'build/reconstruction-csrc/host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so',
     'd09d4be940335764a1e1e7d2f4978366c47e96caf20a3b556d3ac6cfe79e5c68', 'PyInit__source_solver'),
    ('production-core', ROOT / 'build/reconstruction-csrc/source-core/9cb2fcaa1082d1df/_core.cpython-312-x86_64-linux-gnu.so',
     '55d626f06c10c7f6cbc48663bf7fde25be1cfcd8edfb4ce8cf57f30fd300dab5', 'PyInit__core'),
    ('candidate-host', BASE / 'candidate-guard-only/_source_solver.cpython-312-x86_64-linux-gnu.so',
     'ae3a599746804de7218285712a29428138ffe78892d6e28953d77408ed8264e8', 'PyInit__source_solver'),
    ('candidate-core', BASE / 'candidate-public-core/_core.cpython-312-x86_64-linux-gnu.so',
     '5688f23b64d3de2fa01242e31777191820b069e4bdf935675e540d5a1b980417', 'PyInit__core'),
]
allowed = {'libcuda.so.1', 'libcudart.so.12', 'libstdc++.so.6', 'libgcc_s.so.1', 'libc.so.6', 'ld-linux-x86-64.so.2'}
output = BASE / 'four-source-images-elf'
output.mkdir(exist_ok=False)
rows = []
for label, path, expected, initializer in images:
    assert hashlib.sha256(path.read_bytes()).hexdigest() == expected
    dynamic = subprocess.check_output(['readelf', '-d', str(path)], text=True)
    symbols = subprocess.check_output(['nm', '-D', '--defined-only', str(path)], text=True)
    needed = [line.split('[', 1)[1].split(']', 1)[0] for line in dynamic.splitlines() if '(NEEDED)' in line]
    init = [line.split()[-1] for line in symbols.splitlines() if ' PyInit_' in line]
    assert needed and set(needed) == allowed and init == [initializer]
    (output / (label + '-dynamic.txt')).write_text(dynamic)
    (output / (label + '-exports.txt')).write_text(symbols)
    rows.append({'label': label, 'image': str(path), 'sha256': expected, 'ELF_needed': needed,
                 'initialization_symbols': init, 'only_CUDA_and_standard_system_dependencies': True})
(output / 'report.json').write_text(json.dumps({'images': rows, 'GPU_runs': 0,
    'localized_dependency_labels_not_used': True, 'empty_needed_list_rejected': True,
    'whole_solver_complete': False}, indent=2) + '\n')
print('All four actual source images: expected SHA/init, six CUDA/system dependencies, no SDK shared library')
