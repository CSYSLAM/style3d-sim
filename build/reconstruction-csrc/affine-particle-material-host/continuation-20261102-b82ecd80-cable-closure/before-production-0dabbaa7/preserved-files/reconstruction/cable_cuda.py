"""Build and launch reconstructed cable CUDA kernels without the vendor solver or its PTX.

The caller owns the CUDA context, device arrays and the 160-byte CableView. This is a low-level
kernel backend; solver host scheduling is deliberately a separate integration task.
"""
import hashlib
import json
from pathlib import Path
import shutil
import subprocess

ROOT = Path(__file__).resolve().parents[1]
NAMES = ('prepare_cable_tangents', 'update_cable_penalties', 'evaluate_cables')


def compile_sources():
    """Always compile from checked-in sources, recording the exact compiler and input hashes."""
    out = ROOT/'build/reconstruction-cables'
    out.mkdir(parents=True, exist_ok=True)
    src = ROOT/'reconstruction/cuda_cables'
    nvcc = shutil.which('nvcc') or '/usr/local/cuda-12.8/bin/nvcc'
    report = {'compiler': subprocess.check_output([nvcc, '--version'], text=True),
              'source_sha256': {p.name: hashlib.sha256(p.read_bytes()).hexdigest()
                                for p in sorted(src.iterdir()) if p.suffix in ('.cu', '.h')}, 'builds': []}
    for name in NAMES:
        command = [nvcc, '-ptx', '-arch=compute_120', '-std=c++14', '-diag-suppress=177',
                   '-I', str(src), str(src/f'synreal__kernel__{name}.cu'), '-o', str(out/f'{name}.ptx')]
        result = subprocess.run(command, capture_output=True, text=True)
        (out/f'{name}-build.log').write_text(result.stdout+result.stderr)
        report['builds'].append({'command': command, 'exit_code': result.returncode})
        (out/'build.json').write_text(json.dumps(report, indent=2)+'\n')
        result.check_returncode()
    return out


class CableKernels:
    """Use a driver with function(text, symbol) and launch(handle, count, ctypes_params)."""
    def __init__(self, driver):
        self.driver = driver
        compiled = compile_sources()
        self.functions = {name: driver.function((compiled/f'{name}.ptx').read_text(), f'synreal__kernel__{name}')
                          for name in NAMES}

    def prepare(self, view, positions, count):
        self.driver.launch(self.functions[NAMES[0]], count, [view, positions])

    def update_penalties(self, view, positions, linear_beta, angular_beta, count):
        self.driver.launch(self.functions[NAMES[1]], count, [view, positions, linear_beta, angular_beta])

    def evaluate(self, view, positions, previous, inverse_dt, direction, force, preconditioner, count):
        self.driver.launch(self.functions[NAMES[2]], count,
                           [view, positions, previous, inverse_dt, direction, force, preconditioner])
