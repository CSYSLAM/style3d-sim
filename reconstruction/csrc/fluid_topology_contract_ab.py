"""Compare original/source rejection of fluid particles overlapping each elastic or affine topology."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

import warp as wp

from .demo_source_ab import ROOT


def worker(backend, output):
    wp.config.kernel_cache_dir = str(ROOT/'build/reconstruction-warp')
    if backend == 'original':
        from .host_api_probe import load_reference
        core = load_reference()
    else:
        from .host_particles_ab import native_source
        from .host_bodies_ab import bridge
        core = native_source()
        bridge(core)
    from .fluid_material_scene import Example
    scene = Example(None, Example.create_parser().parse_args([]))
    model = scene.solver._synreal_model
    counts = ('triangle_count', 'edge_count', 'spring_count', 'tetrahedron_count')
    old = {key: getattr(model, key) for key in counts}
    arrays = [wp.array([(8, 15)], dtype=wp.vec2i, device='cuda:0'),
              wp.array([100.], dtype=wp.float32, device='cuda:0'),
              wp.array([.07], dtype=wp.float32, device='cuda:0')]
    model.spring_indices, model.spring_stiffnesses, model.spring_rest_lengths = (
        core.Span(array.ptr, 1) for array in arrays)
    old['spring_count'] = 1
    records = {}

    def observe(name, target):
        try:
            solver = core.Solver()
            solver.initialize(target)
            wp.synchronize()
            records[name] = 'accepted'
        except (ValueError, RuntimeError) as error:
            records[name] = [type(error).__name__, str(error)]

    for field in counts:
        for key in counts:
            setattr(model, key, old[key] if key == field else 0)
        for particle in range(model.particle_count):
            array = wp.array([particle], dtype=wp.int32, device='cuda:0')
            model.fluid_particle_count = 1
            model.fluid_particle_indices = core.Span(array.ptr, 1)
            observe(f'{field}/particle{particle}', model)
        model.fluid_particle_count = 0
        observe(field+'/no-fluid', model)
    from .fluid_host_scene import Example as BodyExample
    body = BodyExample(None, BodyExample.create_parser().parse_args(['--body']))
    model = body.solver._synreal_model
    for particle in range(model.particle_count):
        array = wp.array([particle], dtype=wp.int32, device='cuda:0')
        model.fluid_particle_count = 1
        model.fluid_particle_indices = core.Span(array.ptr, 1)
        observe(f'affine/particle{particle}', model)
    model.fluid_particle_count = 0
    observe('affine/no-fluid', model)
    output.write_text(json.dumps(records, indent=2)+'\n')
    image = Path(core.__file__)
    output.with_suffix('.runtime.json').write_text(json.dumps(
        {'backend': backend, 'image': str(image), 'image_sha256': hashlib.sha256(image.read_bytes()).hexdigest()},
        indent=2)+'\n')
    if backend == 'source':
        assert '_core.cpython-' not in Path('/proc/self/maps').read_text()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--worker', choices=('original', 'source'))
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    if args.worker:
        return worker(args.worker, args.output)
    args.output.mkdir(parents=True, exist_ok=False)
    env = {k: v for k, v in os.environ.items() if k not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD')}
    for backend in ('original', 'source'):
        command = [sys.executable, '-m', 'reconstruction.csrc.fluid_topology_contract_ab', '--worker', backend,
                   '--output', str(args.output/(backend+'.json'))]
        with (args.output/(backend+'.log')).open('w') as log:
            subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT, check=True, timeout=1800)
    a, b = [json.loads((args.output/(backend+'.json')).read_text()) for backend in ('original', 'source')]
    differences = {key: {'original': a.get(key), 'source': b.get(key)}
                   for key in a.keys() | b.keys() if a.get(key) != b.get(key)}
    report = {'checks': len(a), 'differences': differences,
              'runtimes': {backend: json.loads((args.output/(backend+'.runtime.json')).read_text())
                           for backend in ('original', 'source')}}
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps({'checks': len(a), 'differences': len(differences)}))
    return bool(differences)


if __name__ == '__main__':
    raise SystemExit(main())
