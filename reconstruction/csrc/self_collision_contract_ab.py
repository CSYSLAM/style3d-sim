"""Observe current-original validation before restoring source self-collision config contracts."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

from .demo_source_ab import ROOT

FIELDS = ('self_collision_radius', 'self_collision_vertex_face_stiffness', 'self_collision_edge_edge_stiffness',
          'self_collision_edge_face_stiffness', 'self_collision_particle_particle_stiffness')
VALUES = (-1., -0., 0., .003, 1., float('nan'), float('inf'), -float('inf'))


def worker(backend, output):
    import warp as wp
    wp.config.kernel_cache_dir = str(ROOT/'build/reconstruction-warp')
    if backend == 'original':
        from .host_api_probe import load_reference
        core = load_reference()
    else:
        from .host_bodies_ab import bridge
        from .host_particles_ab import native_source
        core = native_source()
        bridge(core)
    from .self_particle_scene import Example
    records = {}
    for geometry, options in (('pp', []), ('one', ['--count', '1']), ('empty', ['--empty'])):
        scene = Example(None, Example.create_parser().parse_args(options))
        config = scene.solver.config
        defaults = {name: getattr(config, name) for name in FIELDS}
        config.nonlinear_iterations = 0
        for enabled in (False, True):
            config.enable_self_collision = enabled
            for field in FIELDS:
                for value in VALUES:
                    for name, default in defaults.items():
                        setattr(config, name, default)
                    label = f'{geometry}/enabled={enabled}/{field}={value}'
                    try:
                        setattr(config, field, value)
                        scene.state_0.clear_forces()
                        scene.solver.step(scene.state_0, scene.state_1, scene.control, None, 1/240)
                        wp.synchronize()
                        records[label] = 'accepted'
                    except (ValueError, RuntimeError) as error:
                        records[label] = [type(error).__name__, str(error)]
            # Check error precedence using simultaneous invalid settings.
            for name, default in defaults.items():
                setattr(config, name, default)
            config.self_collision_radius = 0.
            config.self_collision_particle_particle_stiffness = -1.
            try:
                scene.solver.step(scene.state_0, scene.state_1, scene.control, None, 1/240)
                wp.synchronize()
                records[f'{geometry}/enabled={enabled}/radius-zero-and-negative-scale'] = 'accepted'
            except (ValueError, RuntimeError) as error:
                records[f'{geometry}/enabled={enabled}/radius-zero-and-negative-scale'] = \
                    [type(error).__name__, str(error)]
    output.write_text(json.dumps(records, indent=2)+'\n')
    output.with_suffix('.runtime.json').write_text(json.dumps({
        'backend': backend, 'image_sha256': hashlib.sha256(Path(core.__file__).read_bytes()).hexdigest(),
        'harness_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        'fixture_sha256': hashlib.sha256((ROOT/'reconstruction/csrc/self_particle_scene.py').read_bytes()).hexdigest()
    }, indent=2)+'\n')
    if backend == 'source':
        assert '_core.cpython-' not in Path('/proc/self/maps').read_text()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--worker', choices=('original', 'source'))
    args = parser.parse_args()
    if args.worker:
        return worker(args.worker, args.output)
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    build = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    (args.output/'build.json').write_bytes(saved)
    env = {k: v for k, v in os.environ.items() if k not in
           ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR', 'CUDAHOOK_DUMP')}
    workers = {}
    for backend in ('original', 'source'):
        assert build.read_bytes() == saved
        command = [sys.executable, '-m', 'reconstruction.csrc.self_collision_contract_ab', '--worker', backend,
                   '--output', str(args.output/(backend+'.json'))]
        with (args.output/(backend+'.log')).open('w') as log:
            workers[backend] = subprocess.run(command, cwd=ROOT, env=env, stdout=log,
                                              stderr=subprocess.STDOUT, timeout=900).returncode
    report = {'workers': workers, 'source_sha256': json.loads(saved)['extension_sha256']}
    if not any(workers.values()):
        a, b = [json.loads((args.output/(backend+'.json')).read_text()) for backend in ('original', 'source')]
        report.update(checks=len(a), differences={k: {'original': a.get(k), 'source': b.get(k)}
                                                for k in a.keys() | b.keys() if a.get(k) != b.get(k)})
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    print('workers', workers, 'checks', report.get('checks'), 'differences', len(report.get('differences', {})), flush=True)
    return int(bool(any(workers.values()) or report.get('differences')))


if __name__ == '__main__':
    raise SystemExit(main())
