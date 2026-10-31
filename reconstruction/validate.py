"""Run isolated, authenticated native references and compare complete trajectories.

Usage: .venv/bin/python -m reconstruction.validate --frames 30 --width 4 --height 4
"""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import subprocess
import sys
import time

import numpy as np

ROOT = Path(__file__).resolve().parents[1]
ANALYSIS = ROOT / 'reconstruction/reference_analysis'
LEGACY = ROOT / 'reconstruction/references/legacy-4c223854/_core.cpython-312-x86_64-linux-gnu.so'
INSTALLED = ROOT / '.venv/lib/python3.12/site-packages/style3d_sim/_core.cpython-312-x86_64-linux-gnu.so'
ANALYSIS_SHA = '4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6'
# Fixed before the first trajectory comparison; never relaxed to obtain a pass.
TOLERANCES = {'q': (2e-5, 1e-5), 'qd': (3e-4, 1e-4)}  # atol, rtol; metres and metres/second


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def install_reference(path):
    # Load the selected unmodified official library under its normal module name.
    # Its ordinary login and native permission checks remain in effect.
    spec = importlib.util.spec_from_file_location('style3d_sim._core', path)
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)


def model_snapshot(model):
    data = {}
    names = ('particle_q', 'particle_qd', 'particle_mass', 'particle_flags', 'particle_world', 'gravity',
             'spring_indices', 'spring_stiffness', 'spring_rest_length', 'tri_indices', 'tri_poses', 'tri_areas',
             'tet_indices', 'tet_poses', 'tet_materials', 'tet_activations', 'edge_indices', 'edge_bending_properties',
             'shape_transform', 'shape_type', 'shape_scale', 'shape_body', 'shape_margin', 'tri_materials',
             'shape_material_ke', 'shape_material_kd', 'shape_material_kf', 'shape_material_mu')
    for name in names:
        value = getattr(model, name, None)
        if value is not None and hasattr(value, 'numpy'):
            data[name] = value.numpy()
    style = getattr(model, 'style3d', None)
    if style is not None:
        for name in ('tri_aniso_ke', 'edge_rest_area', 'edge_bending_cot'):
            data['style3d.'+name] = getattr(style, name).numpy()
    return data


# Contact-free cable examples (examples/cable).
CABLE_DEMOS = {'cable_bend': 'example_cable_bend_stiffness', 'cable_twist_transfer': 'example_cable_twist_transfer'}
# body_constraints with the alternative affine-body rigidity models.
RIGIDITY_DEMOS = {'body_corotated': 'CO_ROTATED', 'body_abd': 'ABD_ORTHOGONALITY', 'body_six_springs': 'SIX_SPRINGS'}


def make_example(args, backend):
    import warp as wp
    wp.config.kernel_cache_dir = str(ROOT / 'build/reconstruction-warp')
    if backend == 'native':
        install_reference(args.reference)
    elif backend == 'shim':
        # The unmodified wrapper on the pure-Python reconstruction of _core (reconstruction/core.py).
        from . import core
        core.install()
        backend = 'native'
    if args.demo == 'fluid':
        # --width is the lattice resolution of the fluid tank.
        from .scenes import FluidTank
        return FluidTank(backend, resolution=args.width)
    if args.demo == 'cloth_drag':
        from .scenes import ClothDrag
        return ClothDrag(backend, width=args.width, height=args.height)
    if args.demo in ('pendulum', 'pendulum_ball', 'pendulum_drive', 'pendulum_limits', 'pendulum_prismatic',
                     'pendulum_armature', 'pendulum_pd', 'pendulum_prismatic_pd'):
        from .scenes import Pendulum
        joint = {'pendulum_ball': 'ball', 'pendulum_prismatic': 'prismatic',
                 'pendulum_prismatic_pd': 'prismatic'}.get(args.demo, 'revolute')
        return Pendulum(backend, links=args.width, joint=joint,
                        drive=args.demo in ('pendulum_drive', 'pendulum_limits', 'pendulum_prismatic',
                                            'pendulum_armature', 'pendulum_pd', 'pendulum_prismatic_pd'),
                        limits=args.demo in ('pendulum_limits', 'pendulum_armature'),
                        armature=0.01 if args.demo == 'pendulum_armature' else 0.0,
                        pd=args.demo in ('pendulum_pd', 'pendulum_prismatic_pd'))
    if args.demo in ('body_constraints', 'body_constraints_pd', 'body_distance') or args.demo in RIGIDITY_DEMOS:
        from .scenes import BodyConstraints
        return BodyConstraints(backend, pd=args.demo == 'body_constraints_pd', distance=args.demo == 'body_distance',
                               rigidity=RIGIDITY_DEMOS.get(args.demo))
    if args.demo in ('cloth_on_box', 'cloth_on_box_pd', 'cloth_on_box_particle'):
        from .scenes import ClothOnBox
        return ClothOnBox(backend, size=args.width, full_surface=args.demo != 'cloth_on_box_particle',
                          pd=args.demo == 'cloth_on_box_pd', edge_kd=getattr(args, 'edge_damping', 0.0))
    if args.demo == 'particles_on_body':
        from .scenes import ParticlesOnBody
        return ParticlesOnBody(backend, resolution=args.width)
    if args.demo in ('body_drop', 'body_drop_norolling', 'body_drop_hard'):
        from .scenes import BodyDrop
        return BodyDrop(backend, count=args.width, rolling=args.demo != 'body_drop_norolling',
                        hard=args.demo == 'body_drop_hard')
    if args.demo == 'spinning_box':
        from .scenes import SpinningBox
        return SpinningBox(backend, count=args.width)
    if args.demo == 'springs':
        from .scenes import SpringNet
        return SpringNet(backend, resolution=args.width)
    if args.demo == 'particles':
        # --width is the edge length of the particle block; free particles collide through self collision.
        from .scenes import ParticlePile
        return ParticlePile(backend, resolution=args.width)
    if args.demo in ('granular', 'granular_adhesion'):
        # --width is the edge length (in grains) of the granular block; the adhesion variant has no initial bonds.
        from .scenes import GranularPile
        return GranularPile(backend, resolution=args.width, cohesion=200.0 if args.demo == 'granular' else 0.0)
    if args.demo in CABLE_DEMOS:
        # A cable example from examples/cable (cable kernels; the example's own SynReal profile).
        import importlib
        import newton.examples
        from examples.cable.cable_utils import create_cable_parser
        Example = importlib.import_module('examples.cable.'+CABLE_DEMOS[args.demo]).Example
        sys.argv = [args.demo, '--solver', 'synreal', '--viewer', 'null', '--num-frames', str(args.frames)]
        viewer, demo_args = newton.examples.init(create_cable_parser(CABLE_DEMOS[args.demo]))
        example = Example(viewer, demo_args)
        example.contacts = None
        if hasattr(example, '_update_tip_wrench'):
            # The example's own input schedule: the tip wrench is ramped once per frame and written to body_f
            # before every substep.
            counter = {'substep': 0}

            def validate_prepare():
                if counter['substep'] % example.sim_substeps == 0:
                    if counter['substep']:
                        example.sim_time += example.frame_dt
                    example._update_tip_wrench(example._force_at_time(example.sim_time))
                example.state_0.body_f.assign(example.tip_wrench)
                counter['substep'] += 1
            example.validate_prepare = validate_prepare
        return example
    if args.demo == 'ball':
        from examples.example_ball import Example
    else:
        from examples.example_cloth_hanging import Example
    import newton.examples
    sys.argv = [args.demo, '--solver', 'synreal' if backend == 'native' else 'reconstructed',
                '--viewer', 'null', '--no-capture',
                '--num-frames', str(args.frames)]
    if args.demo == 'ball':
        sys.argv += ['--initial-stretch', str(args.initial_stretch), '--initial-vx', str(args.initial_vx)]
    else:
        sys.argv += ['--width', str(args.width), '--height', str(args.height)]
        if getattr(args, 'self_collision', False):
            sys.argv += ['--self-collision', '--self-collision-radius', str(args.self_collision_radius)]
    viewer, demo_args = newton.examples.init(Example.create_parser())
    return Example(viewer, demo_args)


def prepare_inputs(example):
    example.state_0.clear_forces()
    if hasattr(example, 'validate_prepare'):
        example.validate_prepare()
    example.viewer.apply_forces(example.state_0)
    if getattr(example, 'contacts', None) is None:
        return
    if hasattr(example, 'collision_pipeline'):
        example.collision_pipeline.collide(example.state_0, example.contacts)
    else:
        example.model.collide(example.state_0, example.contacts)


def worker(args):
    import resource
    resource.setrlimit(resource.RLIMIT_CORE, (0, 0))
    import warp as wp
    example = make_example(args, args.worker)
    if getattr(args, 'pd', False):
        # Any scene on the target-demo solver settings: PD_NEWTON without an inertia model.
        import style3d_sim as s3d
        example.solver.config.nonlinear_solver = s3d.NonlinearSolver.PD_NEWTON
        example.solver.config.inertia_mode = s3d.InertiaMode.NONE
    arrays = model_snapshot(example.model)
    output = Path(args.output)
    np.savez_compressed(output / (args.worker+'-model.npz'), **arrays)
    q, qd, forces, contact_counts = [], [], [], []
    q.append(example.state_0.particle_q.numpy())
    qd.append(example.state_0.particle_qd.numpy())
    for _ in range(args.frames*example.sim_substeps):
        prepare_inputs(example)
        forces.append(example.state_0.particle_f.numpy())
        contact_counts.append(int(example.contacts.soft_contact_count.numpy()[0]) if example.contacts is not None else 0)
        example.solver.step(example.state_0, example.state_1, example.control, example.contacts, example.sim_dt)
        example.state_0, example.state_1 = example.state_1, example.state_0
        q.append(example.state_0.particle_q.numpy())
        qd.append(example.state_0.particle_qd.numpy())
    # Save numerical evidence before normal native teardown, which may abort.
    np.savez_compressed(output / (args.worker+'-trajectory.npz'), q=np.asarray(q), qd=np.asarray(qd),
                        forces=np.asarray(forces), contact_counts=contact_counts)
    example.test_final()
    loaded = sys.modules.get('style3d_sim._core')
    mapped = [line.split()[-1] for line in Path('/proc/self/maps').read_text().splitlines()
              if '_core.cpython' in line and 'style3d' in line]
    if args.worker == 'shim' and (mapped or not getattr(loaded, 'RECONSTRUCTED', False)):
        raise RuntimeError('Shim backend unexpectedly loaded the official native solver')
    if args.worker == 'source' and (loaded is not None or mapped):
        raise RuntimeError('Source backend unexpectedly loaded the official native solver')
    config = example.solver.config
    metadata = {
        'completed': True, 'demo_test_final_passed': True, 'backend': args.worker, 'demo': args.demo,
        'initial_stretch': args.initial_stretch, 'initial_vx': args.initial_vx,
        'self_collision': getattr(args, 'self_collision', False),
        'self_collision_radius': getattr(args, 'self_collision_radius', 0.01),
        'pd': bool(getattr(args, 'pd', False)),
        'frames': args.frames, 'substeps': example.sim_substeps, 'dt': example.sim_dt,
        'width': args.width, 'height': args.height,
        'nonlinear_iterations': config.nonlinear_iterations, 'linear_iterations': config.linear_iterations,
        'native_module': (str(loaded.__file__) if loaded and not getattr(loaded, 'RECONSTRUCTED', False) else None),
        'reconstructed_core': bool(getattr(loaded, 'RECONSTRUCTED', False)), 'native_maps': sorted(set(mapped)),
        'native_sha256': sha(loaded.__file__) if loaded and not getattr(loaded, 'RECONSTRUCTED', False) else None,
        'source_sha256': {str(p.relative_to(ROOT)): sha(p) for p in sorted((ROOT/'reconstruction').glob('*.py'))},
        'python': sys.version, 'numpy': np.__version__, 'warp': wp.__version__,
        'device': str(example.model.device),
    }
    (output/(args.worker+'-metadata.json')).write_text(json.dumps(metadata, indent=2)+'\n')
    print(json.dumps({'trajectory_complete': True, 'backend': args.worker, 'steps': len(q)-1}), flush=True)


def replay(args):
    """Restart the source solver from every saved native state and compare one step.

    Free-running trajectories through stiff contact amplify float32 rounding: two runs of the official
    binary already differ by more than the trajectory tolerance after impact. One-step replay isolates
    per-step model agreement from that chaotic growth, under the same tolerances.
    """
    output = Path(args.output)
    meta = json.loads((output/'native-metadata.json').read_text())
    for key in ('demo', 'initial_stretch', 'initial_vx', 'width', 'height', 'self_collision', 'self_collision_radius'):
        if key in meta:
            setattr(args, key, meta[key])
    args.frames = meta['frames']
    example = make_example(args, 'source')
    with np.load(output/'native-trajectory.npz') as data:
        ref = {k: data[k] for k in data.files}
    ratios = {k: [] for k in TOLERANCES}
    mismatched_inputs = []
    for step in range(len(ref['contact_counts'])):
        example.state_0.particle_q.assign(ref['q'][step])
        example.state_0.particle_qd.assign(ref['qd'][step])
        prepare_inputs(example)
        count = int(example.contacts.soft_contact_count.numpy()[0])
        if count != ref['contact_counts'][step] or not np.array_equal(example.state_0.particle_f.numpy(), ref['forces'][step]):
            mismatched_inputs.append(step)
        example.solver.step(example.state_0, example.state_1, example.control, example.contacts, example.sim_dt)
        for field, (atol, rtol) in TOLERANCES.items():
            expected = ref[field][step+1]
            actual = getattr(example.state_1, 'particle_'+field).numpy()
            ratios[field].append(float((np.abs(actual-expected)/(atol+rtol*np.abs(expected))).max()))
    loaded = sys.modules.get('style3d_sim._core')
    report = {'steps': len(ref['contact_counts']), 'contact_steps': int(np.count_nonzero(ref['contact_counts'])),
              'mismatched_input_steps': mismatched_inputs, 'source_independent': loaded is None}
    for field, values in ratios.items():
        values = np.asarray(values)
        report[field] = {'max_tolerance_ratio': float(values.max()), 'worst_step': int(values.argmax()),
                         'finite': bool(np.isfinite(values).all())}
    report['numerical_pass'] = (not mismatched_inputs and report['source_independent']
                                and all(report[f]['finite'] and report[f]['max_tolerance_ratio'] <= 1 for f in ratios))
    (output/'replay.json').write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps(report, indent=2), flush=True)
    if not report['numerical_pass']:
        raise SystemExit(1)


def compare(output, candidate='source'):
    output = Path(output)
    report = {'tolerances': {k: {'atol': a, 'rtol': r} for k, (a, r) in TOLERANCES.items()}}
    with np.load(output/'native-model.npz') as a, np.load(output/(candidate+'-model.npz')) as b:
        mismatches = sorted(set(a.files)^set(b.files))
        mismatches += [k for k in a.files if k in b.files and not np.array_equal(a[k], b[k])]
    report['identical_model'] = not mismatches
    report['model_mismatches'] = mismatches
    native_meta = json.loads((output/'native-metadata.json').read_text())
    source_meta = json.loads((output/(candidate+'-metadata.json')).read_text())
    settings = ('demo', 'initial_stretch', 'initial_vx', 'self_collision', 'pd', 'frames', 'substeps', 'dt', 'width',
                'height', 'nonlinear_iterations', 'linear_iterations')
    # Older metadata predates the ball options (defaults apply) and stored demo as a script path.
    defaults = {'initial_vx': 0.0, 'initial_stretch': 1.0, 'self_collision': False, 'pd': False}
    def setting(meta, key):
        value = meta.get(key, defaults.get(key))
        return Path(value).stem.removeprefix('example_') if key == 'demo' else value
    report['identical_settings'] = all(setting(native_meta, k) == setting(source_meta, k) for k in settings)
    report['source_independent'] = source_meta['native_module'] is None and not source_meta['native_maps']
    passed = not mismatches and report['identical_settings'] and report['source_independent']
    with np.load(output/'native-trajectory.npz') as a, np.load(output/(candidate+'-trajectory.npz')) as b:
        report['identical_inputs'] = all(np.array_equal(a[k], b[k]) for k in ('forces', 'contact_counts'))
        passed &= report['identical_inputs']
        for field, (atol, rtol) in TOLERANCES.items():
            expected, actual = a[field], b[field]
            if expected.shape != actual.shape:
                report[field] = {'passed': False, 'error': 'shape mismatch'}
                passed = False
                continue
            finite = bool(np.isfinite(expected).all() and np.isfinite(actual).all())
            diff = np.abs(actual.astype(np.float64)-expected)
            allowed = atol + rtol*np.abs(expected)
            bad = (~np.isfinite(actual)) | (~np.isfinite(expected)) | (diff > allowed)
            where = np.argwhere(bad)
            first = where[0].tolist() if len(where) else None
            field_passed = finite and first is None
            report[field] = {'passed': field_passed, 'finite': finite, 'shape': list(expected.shape),
                             'max_abs': float(diff.max()), 'rms': float(np.sqrt(np.mean(diff*diff))),
                             'max_tolerance_ratio': float(np.max(diff/allowed)),
                             'first_failure_step_particle_component': first,
                             'initial_equal': bool(np.array_equal(expected[0], actual[0])),
                             'max_reference_motion': float(np.max(np.abs(expected-expected[0])))}
            if first is not None:
                idx = tuple(first)
                report[field].update(reference_at_first=float(expected[idx]), source_at_first=float(actual[idx]))
            passed &= field_passed and report[field]['initial_equal']
    report['numerical_pass'] = bool(passed)
    return report


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--demo', default='cloth_hanging',
                        choices=['cloth_hanging', 'ball', 'fluid', 'granular', 'granular_adhesion', 'particles',
                                 'springs', 'cloth_drag', 'spinning_box', 'body_drop', 'body_drop_norolling',
                                 'body_drop_hard',
                                 'particles_on_body', 'pendulum', 'pendulum_ball',
                                 'pendulum_drive', 'pendulum_limits', 'pendulum_prismatic',
                                 'pendulum_armature', 'pendulum_pd', 'pendulum_prismatic_pd', 'cloth_on_box',
                                 'cloth_on_box_pd', 'cloth_on_box_particle', 'body_constraints',
                                 'body_constraints_pd', 'body_distance', *RIGIDITY_DEMOS, *CABLE_DEMOS])
    parser.add_argument('--initial-stretch', type=float, default=1.0)
    parser.add_argument('--initial-vx', type=float, default=0.0)
    parser.add_argument('--self-collision', action='store_true')
    parser.add_argument('--pd', action='store_true', help='Run the scene with PD_NEWTON and inertia NONE.')
    parser.add_argument('--self-collision-radius', type=float, default=0.01)
    parser.add_argument('--worker', choices=('native', 'source', 'shim'))
    parser.add_argument('--candidate', choices=('source', 'shim'), default='source',
                        help='Backend compared against the native trajectory by --compare-only.')
    parser.add_argument('--reference', type=Path, default=LEGACY)
    parser.add_argument('--frames', type=int, default=30)
    parser.add_argument('--width', type=int, default=4)
    parser.add_argument('--height', type=int, default=4)
    parser.add_argument('--output', type=Path)
    parser.add_argument('--compare-only', action='store_true')
    parser.add_argument('--replay', action='store_true',
                        help='One-step source replay from the saved native trajectory in --output.')
    args = parser.parse_args()
    if args.frames < 1 or args.width < 1 or args.height < 1:
        parser.error('frames and grid dimensions must be positive')
    if args.worker:
        worker(args)
        return
    if args.replay:
        if args.output is None:
            parser.error('--replay needs --output with a native trajectory')
        replay(args)
        return
    output = args.output or ROOT/'build/reconstruction-validation'/time.strftime('%Y%m%d-%H%M%S')
    output.mkdir(parents=True, exist_ok=True)
    if args.compare_only:
        report = compare(output, args.candidate)
        report['clean_execution'] = None
        report['note'] = 'Numerical re-comparison only; process exit status was not measured by this command.'
    else:
        if any((output/(b+'-trajectory.npz')).exists() for b in ('native', 'source')):
            raise FileExistsError('Use a new output directory; existing reference evidence is immutable')
        reference_sha = sha(args.reference)
        status = {}
        for backend in ('native', 'source'):
            command = [sys.executable, '-m', 'reconstruction.validate', '--worker', backend,
                       '--demo', args.demo, '--initial-stretch', str(args.initial_stretch),
                       '--initial-vx', str(args.initial_vx),
                       *(['--self-collision', '--self-collision-radius', str(args.self_collision_radius)]
                         if args.self_collision else []),
                       '--reference', str(args.reference.resolve()), '--frames', str(args.frames),
                       '--width', str(args.width), '--height', str(args.height), '--output', str(output.resolve())]
            print(f'Running {backend}; log: {output/backend}.log', flush=True)
            with (output/(backend+'.log')).open('w') as log:
                try:
                    result = subprocess.run(command, cwd=ROOT, stdin=subprocess.DEVNULL, stdout=log, stderr=subprocess.STDOUT,
                                            timeout=900,
                                            env={**os.environ, 'PYTHONUNBUFFERED': '1', 'OPENBLAS_NUM_THREADS': '1'})
                    code = result.returncode
                except subprocess.TimeoutExpired:
                    code = 'timeout'
            status[backend] = {'returncode': code, 'completed': (output/(backend+'-metadata.json')).exists()}
        if all(v['completed'] for v in status.values()):
            report = compare(output)
        else:
            report = {'numerical_pass': False, 'error': 'Incomplete worker; inspect logs'}
        report.update(workers=status, reference_sha256=reference_sha, analysis_sha256=ANALYSIS_SHA,
                      reference_matches_analysis=reference_sha == ANALYSIS_SHA)
        report['clean_execution'] = all(v['returncode'] == 0 for v in status.values())
    name = 'report.json' if args.candidate == 'source' else f'report-{args.candidate}.json'
    (output/name).write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps(report, indent=2), flush=True)
    print(f'Report: {output}/{name}', flush=True)
    if not report['numerical_pass']:
        raise SystemExit(1)
    if not report.get('clean_execution', True):
        raise SystemExit(2)


if __name__ == '__main__':
    main()
