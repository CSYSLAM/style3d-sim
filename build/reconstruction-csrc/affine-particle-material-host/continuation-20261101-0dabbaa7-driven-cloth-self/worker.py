"""Run one explicit SDK/source image and preserve mapping evidence even when an unsupported-scope guard fires."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import sys

ROOT = Path.cwd()
sys.path.insert(0, str(ROOT))
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--backend', choices=('original', 'source'), required=True)
parser.add_argument('--candidate-build', type=Path)
parser.add_argument('--output', type=Path, required=True)
parser.add_argument('--frames', type=int, default=3)
parser.add_argument('extra', nargs=argparse.REMAINDER)
args = parser.parse_args()
assert args.output.is_dir()
if args.candidate_build:
    from reconstruction.csrc import host_particles_ab
    build = json.loads(args.candidate_build.read_text())
    image = Path(build['image'])
    assert hashlib.sha256(image.read_bytes()).hexdigest() == build['image_sha256']
    for name, expected in build['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name

    def candidate():
        spec = importlib.util.spec_from_file_location('_source_solver', image)
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        assert module.source_only and not module.solver_api_ready
        return module

    host_particles_ab.native_source = candidate
from reconstruction.csrc import demo_source_ab
from reconstruction.csrc.host_api_probe import REFERENCE

extra = args.extra[1:] if args.extra[:1] == ['--'] else args.extra
run = argparse.Namespace(worker=args.backend, output=str(args.output), tag='capture', frames=args.frames,
                         example=str(ROOT / 'reconstruction/csrc/driven_cloth_self_scene.py'), extra=extra)
record = {'backend': args.backend, 'complete': False, 'error': None,
          'wrapper_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
          'source_uses_no_reference_calculation': args.backend == 'source', 'whole_solver_complete': False}
try:
    demo_source_ab.worker(run)
    record['complete'] = True
except BaseException as error:
    record['error'] = f'{type(error).__name__}: {error}'
    raise
finally:
    record['original_SDK_mapped'] = str(REFERENCE) in Path('/proc/self/maps').read_text()
    (args.output / 'wrapper-provenance.json').write_text(json.dumps(record, indent=2) + '\n')
    assert record['original_SDK_mapped'] == (args.backend == 'original')
