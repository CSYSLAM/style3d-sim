"""Check the original radius-validation layers with shapes, selected collision particles and unselected radii."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

from .demo_source_ab import ROOT


def worker(backend, output):
    import numpy as np
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
    records = {}
    for shapes in (False, True):
        scene = Example(None, Example.create_parser().parse_args(['--contacts'] if shapes else []))
        model = scene.solver._synreal_model
        model.granular_particle_count = model.granular_bond_count = 0
        for indices in ([], [0], [1], [0, 0], [-1], [model.particle_count]):
            index_array = wp.array(indices, dtype=wp.int32, device='cuda:0')
            model.collision_particle_count = len(indices)
            model.collision_particle_indices = core.Span(index_array.ptr, len(indices)) if indices else core.Span()
            for value in (-1., 0., -0., 1., float('nan'), float('inf')):
                radii = np.ones(model.particle_count, dtype='f4')
                radii[0] = value
                array = wp.array(radii, dtype=wp.float32, device='cuda:0')
                model.particle_radii = core.Span(array.ptr, len(array))
                label = f'shapes={shapes}/indices={indices}/radius={value}'
                try:
                    solver = core.Solver()
                    solver.initialize(model)
                    wp.synchronize()
                    records[label] = 'accepted'
                except (ValueError, RuntimeError) as error:
                    records[label] = [type(error).__name__, str(error)]
    output.write_text(json.dumps(records, indent=2)+'\n')
    output.with_suffix('.runtime.json').write_text(json.dumps({'backend': backend,
        'image_sha256': hashlib.sha256(Path(core.__file__).read_bytes()).hexdigest(),
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
        command = [sys.executable, '-m', 'reconstruction.csrc.radius_contract_ab', '--worker', backend,
                   '--output', str(args.output/(backend+'.json'))]
        with (args.output/(backend+'.log')).open('w') as log:
            subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT, check=True, timeout=900)
    a, b = [json.loads((args.output/(backend+'.json')).read_text()) for backend in ('original', 'source')]
    differences = {k: {'original': a.get(k), 'source': b.get(k)} for k in a.keys() | b.keys() if a.get(k) != b.get(k)}
    (args.output/'report.json').write_text(json.dumps({'checks': len(a), 'differences': differences}, indent=2)+'\n')
    print(len(a), 'radius contracts; differences', differences)
    return bool(differences)


if __name__ == '__main__':
    raise SystemExit(main())
