"""User-processed original/native-source host A/B, without credentials or login calls in either worker."""
import argparse
import ctypes
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import subprocess
import sys

import numpy as np

from reconstruction import validate

OUT = validate.ROOT / 'build/reconstruction-csrc/host-particles'


def result_directory(args):
    base = Path(args.output) if args.output else (OUT if args.scenario == 'particles' else OUT/args.scenario)
    directory = base/f'trace-seed{args.seed}'/args.trace_label if args.trace_case else base
    directory.mkdir(parents=True, exist_ok=True)
    return directory


def selected_fixtures(args):
    if args.scenario in ('surface', 'pd_surface'):
        from .surface_host_cases import fixtures as surface_fixtures, pd_fixtures as pd_surface_fixtures
        return (pd_surface_fixtures if args.scenario == 'pd_surface' else surface_fixtures)(args.seed)
    if args.scenario in ('drag', 'pd_drag'):
        from .drag_host_cases import fixtures as drag_fixtures, pd_fixtures as pd_drag_fixtures
        return (pd_drag_fixtures if args.scenario == 'pd_drag' else drag_fixtures)(args.seed)
    if args.scenario in ('tetrahedra', 'pd_tetrahedra'):
        from .tetrahedron_host_cases import fixtures as tet_fixtures, pd_fixtures as pd_tet_fixtures
        return (pd_tet_fixtures if args.scenario == 'pd_tetrahedra' else tet_fixtures)(args.seed)
    if args.scenario in ('mixed_cloth', 'pd_mixed_cloth'):
        from .mixed_cloth_host_cases import fixtures as mixed_fixtures, pd_fixtures as pd_mixed_fixtures
        return (pd_mixed_fixtures if args.scenario == 'pd_mixed_cloth' else mixed_fixtures)(args.seed)
    if args.scenario in ('bending', 'pd_bending'):
        from .bending_host_cases import fixtures as bending_fixtures, pd_fixtures as pd_bending_fixtures
        return (pd_bending_fixtures if args.scenario == 'pd_bending' else bending_fixtures)(args.seed)
    if args.scenario in ('membranes', 'pd_membranes'):
        from .membrane_host_cases import fixtures as membrane_fixtures, pd_fixtures as pd_membrane_fixtures
        return (pd_membrane_fixtures if args.scenario == 'pd_membranes' else membrane_fixtures)(args.seed)
    if args.scenario in ('soft_contacts', 'pd_soft_contacts'):
        from .soft_contact_host_cases import fixtures as soft_fixtures, pd_fixtures as pd_soft_fixtures
        return (pd_soft_fixtures if args.scenario == 'pd_soft_contacts' else soft_fixtures)(args.seed)
    if args.scenario != 'particles':
        from .spring_host_cases import fixtures as spring_fixtures, pd_fixtures, pd_particle_fixtures, switching_fixtures
        factories = {'springs': spring_fixtures, 'pd_springs': pd_fixtures,
                     'pd_particles': pd_particle_fixtures, 'switching': switching_fixtures}
        return factories[args.scenario](args.seed)
    return fixtures(args.seed)


def native_source():
    import sysconfig
    path = OUT / ('_source_solver' + sysconfig.get_config_var('EXT_SUFFIX'))
    manifest = json.loads((OUT/'build.json').read_text())
    assert hashlib.sha256(path.read_bytes()).hexdigest() == manifest['extension_sha256'], 'Source image changed'
    for name, expected in manifest['sources'].items():
        assert hashlib.sha256((validate.ROOT/name).read_bytes()).hexdigest() == expected, 'Rebuild source image: ' + name
    spec = importlib.util.spec_from_file_location('_source_solver', path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def fixtures(seed):
    rng = np.random.default_rng(seed)
    for count, worlds in ((1, 1), (17, 1), (257, 1), (11, 3)):
        n = count * worlds
        q = rng.uniform(-2, 2, (n, 3)).astype('f4')
        v = rng.uniform(-1, 1, (n, 3)).astype('f4')
        mass = rng.uniform(.1, 4, count).astype('f4')
        flags = np.ones(count, dtype='i4')
        if count > 1:
            mass[::5] = 0
            flags[::7] = 0
        for iterations in (0, 1, 5):
            for force in (False, True):
                yield f'n{count}_w{worlds}_it{iterations}_f{int(force)}', {
                    'q': q, 'v': v, 'mass': mass, 'flags': flags,
                    'gravity': rng.uniform(-10, 2, (worlds, 3)).astype('f4'),
                    'force': rng.uniform(-4, 4, (n, 3)).astype('f4') if force else None,
                    'count': count, 'worlds': worlds, 'iterations': iterations,
                }
    for variant in ('alias_both', 'alias_q', 'alias_qd', 'no_flags', 'no_gravity', 'world_ids', 'world_ids_unreplicated',
                    'state_count_fallback', 'raw_stream', 'protocol_stream', 'graph', 'many_blocks', 'default_linear'):
        count, worlds = (4097, 1) if variant == 'many_blocks' else (19, 3) if variant == 'world_ids' else (33, 1)
        n = count * worlds
        yield variant, {
            'q': rng.uniform(-2, 2, (n, 3)).astype('f4'),
            'v': rng.uniform(-1, 1, (n, 3)).astype('f4'),
            'mass': rng.uniform(.1, 4, count).astype('f4'),
            'flags': None if variant == 'no_flags' else rng.choice([0, 1, 2, 3], count).astype('i4'),
            'gravity': None if variant == 'no_gravity' else rng.uniform(
                -10, 2, (3 if variant == 'world_ids_unreplicated' else worlds, 3)).astype('f4'),
            'world_ids': rng.integers(0, 3, count, dtype='i4') if variant in (
                'world_ids', 'world_ids_unreplicated') else None,
            'force': rng.uniform(-4, 4, (n, 3)).astype('f4'),
            'count': count, 'worlds': worlds, 'iterations': 3, 'variant': variant,
        }


def worker(args):
    import warp as wp
    wp.init()
    if args.worker == 'legacy':
        from .host_api_probe import load_reference
        core = load_reference()
        assert core.is_logged_in()
        print('user_processed_reference=True login_called=False', flush=True)
    else:
        core = native_source()
        assert core.source_only
    from .host_api_probe import describe
    schema = json.loads((validate.ROOT/'reconstruction/csrc/native/api_schema.json').read_text())
    assert describe(core) == schema, 'Public fields/enums/defaults differ from the old module'
    records, status, launches = {}, {}, {}
    for name, case in selected_fixtures(args):
        if args.trace_case and name != args.trace_case:
            continue
        keep = []

        def span(data, dtype):
            if data is None:
                return core.Span()
            array = wp.array(data, dtype=dtype, device='cuda:0')
            keep.append(array)
            return core.Span(array.ptr, len(array))

        model = core.Model()
        model.particle_count = case['count']
        model.particle_state_count = 0 if name == 'state_count_fallback' else len(case['q'])
        model.world_count = case['worlds']
        model.gravity = span(case['gravity'], wp.vec3)
        model.particle_rest_positions = span(case['q'], wp.vec3)
        model.particle_indices = span(np.arange(case['count'], dtype='i4'), wp.int32)
        model.particle_masses = span(case['mass'], wp.float32)
        model.particle_flags = span(case['flags'], wp.int32)
        model.particle_world = span(case.get('world_ids'), wp.int32)
        if 'shape_count' in case:
            model.shape_count = case['shape_count']
            model.shape_replicated_count = case['shape_replicated_count']
            for field, dtype in (('particle_radii', wp.float32), ('shape_bodies', wp.int32),
                                 ('shape_types', wp.int32), ('shape_transforms', wp.transform),
                                 ('shape_scales', wp.vec3), ('shape_margins', wp.float32),
                                 ('shape_contact_stiffnesses', wp.float32), ('shape_contact_dampings', wp.float32),
                                 ('shape_contact_friction_gains', wp.float32), ('shape_frictions', wp.float32)):
                setattr(model, field, span(case[field], dtype))
            for field in ('soft_contact_stiffness', 'soft_contact_damping', 'soft_contact_friction_gain',
                          'soft_contact_friction'):
                setattr(model, field, case[field])
        if 'spring_indices' in case:
            model.spring_count = len(case['spring_indices'])
            model.spring_indices = span(case['spring_indices'], wp.vec2i)
            model.spring_stiffnesses = span(case['spring_stiffness'], wp.float32)
            model.spring_rest_lengths = span(case['spring_rest'], wp.float32)
        if 'triangle_indices' in case:
            model.triangle_count = len(case['triangle_indices'])
            for field, dtype in (('triangle_indices', wp.vec3i), ('triangle_inv_dms', wp.mat22),
                                 ('triangle_rest_areas', wp.float32), ('triangle_aniso_stiffnesses', wp.vec3)):
                setattr(model, field, span(case[field], dtype))
        if 'edge_indices' in case:
            model.edge_count = len(case['edge_indices'])
            for field, dtype in (('edge_indices', wp.vec4i), ('edge_rest_areas', wp.float32),
                                 ('edge_bending_cots', wp.vec4), ('edge_bending_properties', wp.vec2)):
                setattr(model, field, span(case[field], dtype))
        if 'tetrahedron_indices' in case:
            model.tetrahedron_count = len(case['tetrahedron_indices'])
            for field, dtype in (('tetrahedron_indices', wp.vec4i), ('tetrahedron_inverse_dms', wp.mat33),
                                 ('tetrahedron_materials', wp.vec3)):
                setattr(model, field, span(case[field], dtype))
        if 'collision_triangle_indices' in case:
            model.collision_triangle_count = len(case['collision_triangle_indices'])
            model.collision_triangle_indices = span(case['collision_triangle_indices'], wp.vec3i)
            model.triangle_drag_coefficients = span(case['triangle_drag_coefficients'], wp.float32)
        state_in, state_out = core.State(), core.State()
        state_in.particle_q = span(case['q'], wp.vec3)
        state_in.particle_qd = span(case['v'], wp.vec3)
        state_in.particle_f = span(case['force'], wp.vec3)
        state_out.particle_q = span(np.full_like(case['q'], -123), wp.vec3)
        state_out.particle_qd = span(np.full_like(case['v'], -456), wp.vec3)
        state_out.particle_f = span(np.full_like(case['q'], -789), wp.vec3)
        mode = case.get('mode', name)
        if mode in ('alias_both', 'alias_q'):
            state_out.particle_q = state_in.particle_q
        if mode in ('alias_both', 'alias_qd'):
            state_out.particle_qd = state_in.particle_qd
        solver = core.Solver()
        contact = core.Contact()
        control = core.Control()
        if 'tetrahedron_activations' in case:
            control.tetrahedron_activations = span(case['tetrahedron_activations'], wp.float32)
        if 'soft_max_count' in case:
            contact.soft_max_count = case['soft_max_count']
            for field, dtype in (('soft_count', wp.int32), ('soft_particle', wp.int32), ('soft_shape', wp.int32),
                                 ('soft_body_pos', wp.vec3), ('soft_body_vel', wp.vec3), ('soft_normal', wp.vec3)):
                setattr(contact, field, span(case[field], dtype))
            for field, dtype in (('soft_indices', wp.vec3i), ('soft_barycentric', wp.vec3),
                                 ('soft_particle_only_shapes', wp.int32)):
                if field in case:
                    setattr(contact, field, span(case[field], dtype))
        if 'solver_mode' in case:
            solver.config.nonlinear_solver = core.NonlinearSolver(case['solver_mode'])
        solver.config.nonlinear_iterations = case['iterations']
        if mode != 'default_linear':
            solver.config.linear_iterations = case.get('linear_iterations', 7)
        wp.synchronize()
        unchanged = [array.numpy().tobytes() for array in keep] if case.get('expected_error') else None
        try:
            for field, value in case.get('config', {}).items():
                setattr(solver.config, field, value)
            solver.initialize(model)
            if args.trace_case:
                observer = ctypes.CDLL(None)
                observer.solver_trace_begin.argtypes = [ctypes.c_char_p]
                path = result_directory(args)/args.worker
                observer.solver_trace_begin(str(path).encode())
            cuda_stream = wp.Stream('cuda:0') if mode in ('raw_stream', 'protocol_stream', 'graph') else None
            for step in range(3):
                if 'step_modes' in case:
                    solver.config.nonlinear_solver = core.NonlinearSolver(case['step_modes'][step])
                dt = case.get('dt', 1 / 1000 if case.get('variant') else 1 / 120)
                if mode == 'graph':
                    wp.capture_begin(stream=cuda_stream)
                    try:
                        solver.step(state_in, state_out, control, contact, dt, cuda_stream)
                    finally:
                        graph = wp.capture_end(stream=cuda_stream)
                    wp.capture_launch(graph, stream=cuda_stream)
                elif mode == 'raw_stream':
                    solver.step(state_in, state_out, control, contact, dt, int(cuda_stream.cuda_stream))
                elif mode == 'protocol_stream':
                    solver.step(state_in, state_out, control, contact, dt, cuda_stream)
                elif contact.soft_max_count or control.tetrahedron_activations.size:
                    solver.step(state_in, state_out, control, contact, dt)
                else:
                    solver.step(state_in, state_out, dt)
                wp.synchronize()
                for tag, state in (('in', state_in), ('out', state_out)):
                    for field in ('particle_q', 'particle_qd', 'particle_f'):
                        view = getattr(state, field)
                        if view.size:
                            a = wp.array(ptr=view.ptr, dtype=wp.vec3, shape=(view.size,), device='cuda:0', copy=False)
                            records[f'{name}/{step}/{tag}.{field}'] = a.numpy().copy()
                state_in, state_out = state_out, state_in
            if args.trace_case:
                observer.solver_trace_end()
            status[name] = 'ok'
            if args.worker == 'source':
                launches[name] = dict(solver.source_launch_counts)
        except Exception as exc:
            status[name] = {'error_type': type(exc).__name__, 'message': str(exc)}
            if unchanged is not None:
                wp.synchronize()
                assert unchanged == [array.numpy().tobytes() for array in keep], 'Invalid initialization changed device inputs'
                status[name]['device_inputs_unchanged_on_error'] = True
            print(name, status[name], flush=True)
        del solver
    if args.adapter:
        from .host_adapter_demo import run
        demo_records, demo_launches = run(core, args.seed, args.worker == 'source',
                                         args.scenario in ('springs', 'pd_springs', 'switching'),
                                         args.scenario in ('pd_springs', 'pd_particles', 'pd_soft_contacts',
                                                           'pd_membranes', 'pd_bending'),
                                         args.scenario in ('soft_contacts', 'pd_soft_contacts'),
                                         'membrane' if args.scenario in ('membranes', 'pd_membranes') else
                                         'bending' if args.scenario in ('bending', 'pd_bending') else None)
        records.update(demo_records)
        launches.update(demo_launches)
    target = result_directory(args) / f'{args.worker}-seed{args.seed}'
    np.savez(target.with_suffix('.npz'), **records)
    target.with_suffix('.json').write_text(json.dumps(status, indent=2) + '\n')
    if args.worker == 'source':
        target.with_suffix('.launches.json').write_text(json.dumps(launches, indent=2) + '\n')
        maps = Path('/proc/self/maps').read_text()
        assert '_core.cpython-' not in maps, 'Original solver was unexpectedly mapped in the source worker'
        target.with_suffix('.runtime.json').write_text(json.dumps({
            'original_solver_mapped': False, 'source_only': core.source_only,
            'source_digest': core.source_digest, 'solver_api_ready': core.solver_api_ready,
            'extension_sha256': json.loads((OUT/'build.json').read_text())['extension_sha256'],
        }, indent=2)+'\n')
    print(f'{args.worker}: {len(status)} cases, {len(records)} arrays', flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--worker', choices=('legacy', 'source'))
    parser.add_argument('--seed', type=int, default=1)
    parser.add_argument('--legacy-only', action='store_true')
    parser.add_argument('--adapter', action='store_true')
    parser.add_argument('--output', help='Independent result directory; does not change the source image path')
    parser.add_argument('--trace-case')
    parser.add_argument('--trace-label', default='first')
    parser.add_argument('--scenario', choices=('particles', 'springs', 'pd_springs', 'pd_particles', 'switching',
                                             'soft_contacts', 'pd_soft_contacts', 'membranes', 'pd_membranes',
                                             'bending', 'pd_bending', 'mixed_cloth', 'pd_mixed_cloth',
                                             'tetrahedra', 'pd_tetrahedra', 'drag', 'pd_drag', 'surface', 'pd_surface'),
                        default='particles')
    args = parser.parse_args()
    OUT.mkdir(parents=True, exist_ok=True)
    if args.worker:
        worker(args)
        return
    results = result_directory(args)
    env = {k: v for k, v in os.environ.items() if k not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
    if args.trace_case:
        assert not args.adapter
        env['LD_PRELOAD'] = str(OUT/'host_trace.so')
    exit_codes = {}
    for backend in ('legacy',) if args.legacy_only else ('legacy', 'source'):
        log = results/f'{backend}-seed{args.seed}.log'
        with log.open('w') as handle:
            result = subprocess.run([sys.executable, '-m', 'reconstruction.csrc.host_particles_ab',
                                     '--worker', backend, '--seed', str(args.seed)] +
                                    ['--scenario', args.scenario] +
                                    (['--output', args.output] if args.output else []) +
                                    (['--adapter'] if args.adapter else []) +
                                    (['--trace-case', args.trace_case, '--trace-label', args.trace_label]
                                     if args.trace_case else []), env=env, stdout=handle,
                                    stderr=subprocess.STDOUT, check=True, timeout=180)
            exit_codes[backend] = result.returncode
        print(log, flush=True)
    if args.legacy_only:
        return
    for backend in ('legacy', 'source'):
        status = json.loads((results/f'{backend}-seed{args.seed}.json').read_text())
        cases = {name: case for name, case in selected_fixtures(args) if not args.trace_case or name == args.trace_case}
        assert set(status) == set(cases), 'Scene status coverage differs'
        for name, case in cases.items():
            if case.get('expected_error'):
                assert isinstance(status[name], dict) and status[name]['error_type'] == case['expected_error'], status
            else:
                assert status[name] == 'ok', status
    reference_status = json.loads((results/f'legacy-seed{args.seed}.json').read_text())
    source_status = json.loads((results/f'source-seed{args.seed}.json').read_text())
    assert reference_status == source_status, 'Scene/error statuses differ from the original'
    old = np.load(results/f'legacy-seed{args.seed}.npz')
    new = np.load(results/f'source-seed{args.seed}.npz')
    assert set(old.files) == set(new.files), 'Recorded state coverage differs'
    report = {name: bool(np.array_equal(old[name].view('u4'), new[name].view('u4'))) for name in old.files}
    eager_graph = {}
    if args.adapter:
        for backend, data in (('legacy', old), ('source', new)):
            for name in data.files:
                if name.startswith('adapter_eager/'):
                    graph_name = name.replace('adapter_eager/', 'adapter_graph/', 1)
                    eager_graph[backend+'/'+name] = bool(np.array_equal(data[name].view('u4'), data[graph_name].view('u4')))
    failures = [name for name, equal in report.items() if not equal]
    failures += [name for name, equal in eager_graph.items() if not equal]
    from .host_api_probe import REFERENCE, REFERENCE_SHA
    metadata = {'checks': report, 'eager_graph_checks': eager_graph, 'failures': failures, 'worker_exit_codes': exit_codes,
                'reference_path': str(REFERENCE), 'reference_sha256': REFERENCE_SHA,
                'login_called': False, 'credentials_read': False, 'adapter_demo': args.adapter, 'scenario': args.scenario,
                'source_runtime': json.loads((results/f'source-seed{args.seed}.runtime.json').read_text())}
    (results/f'comparison-seed{args.seed}.json').write_text(json.dumps(metadata, indent=2)+'\n')
    print('arrays', len(report), 'failures', len(failures), failures[:12])
    assert not failures


if __name__ == '__main__':
    main()
