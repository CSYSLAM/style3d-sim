"""Serial original/source fluid initialization and conditional step-configuration contracts."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

from .demo_source_ab import ROOT


def worker(backend, output):
    import warp as wp
    wp.config.kernel_cache_dir = str(ROOT/'build/reconstruction-warp')
    if backend == 'original':
        from .host_api_probe import load_reference
        core = load_reference()
    else:
        from .host_particles_ab import native_source
        from .host_bodies_ab import bridge
        core = native_source()
        bridge(core)
    from .fluid_host_scene import Example
    scene = Example(None, Example.create_parser().parse_args(['--layout', 'isolated']))
    model = scene.solver._synreal_model
    result = {}

    def observe(name, callback):
        try:
            callback()
            wp.synchronize()
            result[name] = 'accepted'
        except (ValueError, RuntimeError) as error:
            result[name] = [type(error).__name__, str(error)]

    def initialize():
        solver = core.Solver()
        solver.initialize(model)

    for field in ('fluid_rest_density', 'fluid_smoothing_radius', 'fluid_bulk_modulus', 'fluid_viscosity'):
        old = getattr(model, field)
        for value in (-1., 0., 1., float('nan'), float('inf')):
            setattr(model, field, value)
            observe(f'initialize/{field}/{value}', initialize)
        setattr(model, field, old)
    old_count, old_indices = model.fluid_particle_count, model.fluid_particle_indices
    for values in ([-1], [1], [0, 0]):
        array = wp.array(values, dtype=wp.int32, device='cuda:0')
        model.fluid_particle_count = len(values)
        model.fluid_particle_indices = core.Span(array.ptr, len(values))
        observe('indices/'+str(values), initialize)
    model.fluid_particle_count, model.fluid_particle_indices = old_count, old_indices
    old_mass = model.particle_masses
    for value in (-1., 0., 1., float('nan'), float('inf')):
        array = wp.array([value], dtype=wp.float32, device='cuda:0')
        model.particle_masses = core.Span(array.ptr, 1)
        observe('mass/'+str(value), initialize)
    model.particle_masses = old_mass
    model.fluid_particle_count = 0
    for value in (-1., 0., 1., float('nan'), float('inf')):
        array = wp.array([value], dtype=wp.float32, device='cuda:0')
        model.particle_masses = core.Span(array.ptr, 1)
        observe('non-fluid-mass/'+str(value), initialize)
    model.particle_masses = old_mass
    model.fluid_particle_count = old_count
    old_flags = model.particle_flags
    for value in (None, 0, 1, 2, 3):
        if value is None:
            model.particle_flags = core.Span()
        else:
            array = wp.array([value], dtype=wp.int32, device='cuda:0')
            model.particle_flags = core.Span(array.ptr, 1)
        observe('flags/'+str(value), initialize)
    model.particle_flags = old_flags
    old_boundary = (model.fluid_boundary_count, model.fluid_boundary_positions, model.fluid_boundary_volumes)
    position = wp.array([(0., 0., 0.)], dtype=wp.vec3, device='cuda:0')
    model.fluid_boundary_count = 1
    model.fluid_boundary_positions = core.Span(position.ptr, 1)
    for value in (-1., 0., 1., float('nan'), float('inf')):
        array = wp.array([value], dtype=wp.float32, device='cuda:0')
        model.fluid_boundary_volumes = core.Span(array.ptr, 1)
        observe('boundary-volume/'+str(value), initialize)
    array = wp.array([1.], dtype=wp.float32, device='cuda:0')
    model.fluid_boundary_volumes = core.Span(array.ptr, 1)
    for value in (float('nan'), float('inf')):
        position = wp.array([(value, 0., 0.)], dtype=wp.vec3, device='cuda:0')
        model.fluid_boundary_positions = core.Span(position.ptr, 1)
        observe('boundary-position/'+str(value), initialize)
    model.fluid_boundary_count, model.fluid_boundary_positions, model.fluid_boundary_volumes = old_boundary
    for field in ('fluid_relaxation', 'fluid_max_step_ratio'):
        old = getattr(scene.solver.config, field)
        for value in (-1., 0., 1., 1.1, float('nan'), float('inf')):
            setattr(scene.solver.config, field, value)
            observe(f'step/{field}/{value}', lambda: scene.solver.step(scene.model.state(), scene.model.state(),
                                                                     scene.model.control(), None, 1/240))
        setattr(scene.solver.config, field, old)
    if backend == 'source':
        assert '_core.cpython-' not in Path('/proc/self/maps').read_text()
    output.write_text(json.dumps(result, indent=2)+'\n')
    image = Path(core.__file__)
    output.with_suffix('.runtime.json').write_text(json.dumps(
        {'backend': backend, 'image': str(image), 'image_sha256': hashlib.sha256(image.read_bytes()).hexdigest()},
        indent=2)+'\n')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--worker', choices=('original', 'source'))
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    if args.worker:
        return worker(args.worker, args.output)
    args.output.mkdir(parents=True, exist_ok=False)
    env = {k: v for k, v in os.environ.items() if k not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
    for backend in ('original', 'source'):
        command = [sys.executable, '-m', 'reconstruction.csrc.fluid_contract_ab', '--worker', backend,
                   '--output', str(args.output/(backend+'.json'))]
        with (args.output/(backend+'.log')).open('w') as log:
            subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT, check=True, timeout=900)
    a, b = [json.loads((args.output/(backend+'.json')).read_text()) for backend in ('original', 'source')]
    differences = {k: {'original': a.get(k), 'source': b.get(k)} for k in a.keys() | b.keys() if a.get(k) != b.get(k)}
    report = {'checks': len(a), 'differences': differences,
              'runtimes': {backend: json.loads((args.output/(backend+'.runtime.json')).read_text())
                           for backend in ('original', 'source')}}
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps(report))
    return bool(differences)


if __name__ == '__main__':
    sys.exit(main())
