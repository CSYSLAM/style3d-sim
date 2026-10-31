"""Observe real native granular constructor contracts without inventing expected error messages."""
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
    from .granular_host_scene import Example
    scene = Example(None, Example.create_parser().parse_args([]))
    model = scene.solver._synreal_model
    result = {}

    def observe(name):
        try:
            solver = core.Solver()
            solver.initialize(model)
            wp.synchronize()
            result[name] = 'accepted'
        except (ValueError, RuntimeError) as error:
            result[name] = [type(error).__name__, str(error)]

    parameters = ('contact_stiffness', 'friction', 'friction_damping', 'cohesion', 'bond_damping', 'yield_strain',
                  'max_compaction', 'break_strain', 'adhesion', 'bond_formation_gap', 'bond_formation_speed')
    for name in parameters:
        field = 'granular_'+name
        old = getattr(model, field)
        for value in (-1., 0., .2, 1., float('nan'), float('inf')):
            setattr(model, field, value)
            observe(field+'/'+str(value))
        setattr(model, field, old)
    old = model.granular_max_dynamic_bonds
    for value in (0, 1, 64, 65):
        model.granular_max_dynamic_bonds = value
        observe('dynamic-capacity/'+str(value))
    model.granular_max_dynamic_bonds = old
    for field in ('particle_masses', 'particle_radii'):
        old = getattr(model, field)
        for value in (-1., 0., 1., float('nan'), float('inf')):
            array = wp.full(model.particle_count, value, dtype=wp.float32, device='cuda:0')
            setattr(model, field, core.Span(array.ptr, len(array)))
            observe(field+'/'+str(value))
        setattr(model, field, old)
    old = model.particle_flags
    for value in (None, 0, 1, 2, 3):
        array = wp.full(model.particle_count, value or 0, dtype=wp.int32, device='cuda:0')
        model.particle_flags = core.Span() if value is None else core.Span(array.ptr, len(array))
        observe('flags/'+str(value))
    model.particle_flags = old
    old_count, old_indices = model.granular_particle_count, model.granular_particle_indices
    for values in ([-1], [model.particle_count], [0, 0], [0, 2]):
        array = wp.array(values, dtype=wp.int32, device='cuda:0')
        model.granular_particle_count, model.granular_particle_indices = len(values), core.Span(array.ptr, len(array))
        observe('indices/'+str(values))
    model.granular_particle_count, model.granular_particle_indices = old_count, old_indices
    model.granular_particle_indices = core.Span(old_indices.ptr, old_count-1)
    observe('indices/short-span')
    model.granular_particle_indices = old_indices
    saved = {field: getattr(model, field) for field in
             ('granular_bond_count', 'granular_bond_indices', 'granular_bond_rest_lengths', 'granular_cohesion')}
    model.granular_cohesion = 200.
    for pairs in ([[-1, 0]], [[0, model.particle_count]], [[0, 0]], [[0, 1]], [[0, 1], [1, 0]], [[0, 1], [1, 2]]):
        array = wp.array(pairs, dtype=wp.vec2i, device='cuda:0')
        rest = wp.full(len(pairs), .04, dtype=wp.float32, device='cuda:0')
        model.granular_bond_count = len(pairs)
        model.granular_bond_indices, model.granular_bond_rest_lengths = core.Span(array.ptr, len(array)), core.Span(
            rest.ptr, len(rest))
        observe('bond-pairs/'+str(pairs))
    array = wp.array([[0, 1]], dtype=wp.vec2i, device='cuda:0')
    model.granular_bond_count, model.granular_bond_indices = 1, core.Span(array.ptr, 1)
    for value in (-1., 0., .04, float('nan'), float('inf')):
        rest = wp.array([value], dtype=wp.float32, device='cuda:0')
        model.granular_bond_rest_lengths = core.Span(rest.ptr, 1)
        observe('bond-rest/'+str(value))
    rest = wp.array([.04], dtype=wp.float32, device='cuda:0')
    model.granular_bond_rest_lengths = core.Span(rest.ptr, 1)
    old_world = model.particle_world
    worlds = wp.array([0, 1]+[0]*(model.particle_count-2), dtype=wp.int32, device='cuda:0')
    model.particle_world = core.Span(worlds.ptr, len(worlds))
    observe('bond-worlds/distinct')
    model.particle_world = old_world
    model.granular_particle_count = 0
    observe('bonds-without-grains')
    model.granular_particle_count = old_count
    for field, value in saved.items():
        setattr(model, field, value)
    output.write_text(json.dumps(result, indent=2)+'\n')
    image = Path(core.__file__)
    output.with_suffix('.runtime.json').write_text(json.dumps(
        {'backend': backend, 'image_sha256': hashlib.sha256(image.read_bytes()).hexdigest(),
         'fixture_sha256': hashlib.sha256((ROOT/'reconstruction/csrc/granular_host_scene.py').read_bytes()).hexdigest(),
         'harness_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}, indent=2)+'\n')
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
        command = [sys.executable, '-m', 'reconstruction.csrc.granular_contract_ab', '--worker', backend,
                   '--output', str(args.output/(backend+'.json'))]
        with (args.output/(backend+'.log')).open('w') as log:
            subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT, check=True, timeout=900)
    a, b = [json.loads((args.output/(backend+'.json')).read_text()) for backend in ('original', 'source')]
    differences = {k: {'original': a.get(k), 'source': b.get(k)} for k in a.keys() | b.keys() if a.get(k) != b.get(k)}
    report = {'checks': len(a), 'differences': differences}
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps(report))
    return bool(differences)


if __name__ == '__main__':
    raise SystemExit(main())
