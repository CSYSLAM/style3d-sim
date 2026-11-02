"""Run a frozen independent candidate after relocating only its recorded repository paths.

    python -B -m reconstruction.csrc.candidate_demo_worker --backend source --candidate-build BUILD_JSON \
        --example reconstruction/csrc/cable_body_constraint_scene.py --frames 3 --output NEW_OUTPUT \
        -- --constraint spring --worlds 1 --mode newton

Original manifests remain unchanged; every relocated source and image must retain its recorded SHA256.
"""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path

from .demo_source_ab import ROOT


def validated_build(path, root=ROOT):
    build = json.loads(path.read_text())
    inputs = build['input_sha256']
    suffix = '/reconstruction/csrc/native/source_solver.cpp'
    anchors = [name[:-len(suffix)] for name in inputs if name.endswith(suffix)]
    if len(set(anchors)) != 1:
        raise ValueError('The recorded candidate repository root is missing or ambiguous')
    recorded_root = Path(anchors[0])
    if not recorded_root.is_absolute():
        raise ValueError('The recorded repository root must be absolute')

    def relocate(name):
        original = Path(name)
        if '..' in original.parts:
            raise ValueError('Parent traversal is not a candidate repository path')
        relative = original.relative_to(recorded_root) if original.is_absolute() else original
        return root / relative

    for name, expected in inputs.items():
        actual = relocate(name)
        if hashlib.sha256(actual.read_bytes()).hexdigest() != expected:
            raise ValueError('Candidate input SHA256 differs: ' + name)
    image = relocate(build['image'])
    if hashlib.sha256(image.read_bytes()).hexdigest() != build['image_sha256']:
        raise ValueError('Candidate image SHA256 differs')
    return build, image, str(recorded_root)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--candidate-build', type=Path, required=True)
    parser.add_argument('--example', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--frames', type=int, default=3)
    parser.add_argument('extra', nargs=argparse.REMAINDER)
    args = parser.parse_args()
    assert args.frames > 0
    build, image, recorded_root = validated_build(args.candidate_build)
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    from . import demo_source_ab, host_particles_ab
    from .host_api_probe import REFERENCE

    def candidate():
        spec = importlib.util.spec_from_file_location('_source_solver', image)
        core = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(core)
        assert core.source_only and not core.solver_api_ready
        return core

    if args.backend == 'source':
        host_particles_ab.native_source = candidate
    extra = args.extra[1:] if args.extra[:1] == ['--'] else args.extra
    run = argparse.Namespace(worker=args.backend, output=str(args.output), tag='capture', frames=args.frames,
                             example=str(args.example.resolve(strict=True)), extra=extra)
    provenance = {'backend': args.backend, 'recorded_root': recorded_root, 'actual_root': str(ROOT),
                  'candidate_manifest_sha256': hashlib.sha256(args.candidate_build.read_bytes()).hexdigest(),
                  'candidate_image_sha256': build['image_sha256'],
                  'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                  'original_manifest_modified': False, 'complete': False, 'whole_solver_complete': False}
    try:
        demo_source_ab.worker(run)
        provenance['complete'] = True
    finally:
        mapped = str(REFERENCE.resolve()) in Path('/proc/self/maps').read_text()
        provenance['SDK_mapped'] = mapped
        (args.output / 'candidate-provenance.json').write_text(json.dumps(provenance, indent=2) + '\n')
        assert mapped == (args.backend == 'original')


if __name__ == '__main__':
    main()
