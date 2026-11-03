"""Build one fresh recovered Core for CMake and atomically publish the successful extension to its build directory."""
import argparse
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--project', type=Path, required=True)
    parser.add_argument('--build-dir', type=Path, required=True)
    parser.add_argument('--target', type=Path, required=True)
    parser.add_argument('--nvcc', type=Path, required=True)
    parser.add_argument('--glm', type=Path, required=True)
    parser.add_argument('--cxx', required=True)
    args = parser.parse_args()
    project, build, target = args.project.resolve(strict=True), args.build_dir.resolve(), args.target.resolve()
    assert target.parent == build.parent and target.name.startswith('_core.') and target.suffix == '.so'
    assert not target.is_relative_to(project / 'style3d-sim-bin')
    build.mkdir(parents=True, exist_ok=True)
    attempt = Path(tempfile.mkdtemp(prefix='attempt-', dir=build))
    output = attempt / 'compiled'
    command = [sys.executable, '-B', '-m', 'reconstruction.csrc.build_standalone', '--output', str(output),
               '--nvcc', str(args.nvcc.resolve(strict=True)), '--glm', str(args.glm.resolve(strict=True)),
               '--cxx', args.cxx]
    (attempt / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
    subprocess.run(command, cwd=project, check=True)
    metadata = json.loads((output / 'build.json').read_text())
    image = Path(metadata['extension'])
    assert metadata['source_only'] and not metadata['reference_solver_read_or_linked']
    assert hashlib.sha256(image.read_bytes()).hexdigest() == metadata['extension_sha256']
    temporary = target.with_name(target.name + '.tmp')
    shutil.copy2(image, temporary)
    temporary.replace(target)
    (build / 'selected-build.json').write_text(json.dumps({
        'build': str(output / 'build.json'), 'extension': str(target),
        'extension_sha256': metadata['extension_sha256'], 'source_only': True,
        'reference_solver_read_or_linked': False, 'solver_api_ready': metadata['solver_api_ready'],
        'runtime_numeric_validation_complete': False}, indent=2) + '\n')
    print('Installed recovered source build artifact:', target, flush=True)


if __name__ == '__main__':
    main()
