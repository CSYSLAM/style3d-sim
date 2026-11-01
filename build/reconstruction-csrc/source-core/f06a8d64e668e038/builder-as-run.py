"""Build an independent _core extension from the pinned source host without changing the reference SDK."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

from .demo_source_ab import ROOT


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, help='New output directory; defaults to a content-keyed build directory')
    args = parser.parse_args()
    base = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    saved = base.read_bytes()
    metadata = json.loads(saved)
    assert metadata['source_only'] and metadata['kernel_count'] == 176
    wrapper = ROOT / 'reconstruction/csrc/native/source_core.cpp'
    sources = dict(metadata['sources'])
    for path in (wrapper, Path(__file__).resolve()):
        sources[str(path.relative_to(ROOT))] = hashlib.sha256(path.read_bytes()).hexdigest()
    identity = hashlib.sha256(json.dumps(sources, sort_keys=True).encode()).hexdigest()[:16]
    output = args.output or ROOT / 'build/reconstruction-csrc/source-core' / identity
    output = output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    extension = output / '_core.cpython-312-x86_64-linux-gnu.so'
    command = list(metadata['build_command'])
    original = str(ROOT / 'reconstruction/csrc/native/source_solver.cpp')
    assert command.count(original) == 1 and command.count('-o') == 1
    command[command.index(original)] = str(wrapper)
    command[command.index('-o') + 1] = str(extension)
    (output / 'base-build.json').write_bytes(saved)
    (output / 'build.command.json').write_text(json.dumps(command, indent=2) + '\n')

    def verify_inputs():
        assert base.read_bytes() == saved
        for name, digest in sources.items():
            assert hashlib.sha256((ROOT / name).read_bytes()).hexdigest() == digest, name

    verify_inputs()
    with (output / 'build.log').open('w') as log:
        subprocess.run(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT, check=True)
    verify_inputs()
    symbols = subprocess.check_output(['nm', '-D', '--defined-only', str(extension)], text=True)
    init = [line.split()[-1] for line in symbols.splitlines() if ' PyInit_' in line]
    assert init == ['PyInit__core'], init
    report = {
        'module': '_core', 'source_only': True, 'solver_api_ready': False,
        'source_host_sha256': metadata['extension_sha256'],
        'extension_sha256': hashlib.sha256(extension.read_bytes()).hexdigest(),
        'cuda_source_digest': metadata['cuda_source_digest'], 'kernel_count': metadata['kernel_count'],
        'sources': sources, 'build_command': command, 'initialization_symbols': init,
        'reference_sdk_modified': False, 'default_package_switched': False,
        'runtime_example_validation_complete': False,
        'login_compatibility': 'Readiness hook returns true; explicit login raises; no account or network is used',
    }
    (output / 'build.json').write_text(json.dumps(report, indent=2) + '\n')
    print(extension, flush=True)


if __name__ == '__main__':
    main()
