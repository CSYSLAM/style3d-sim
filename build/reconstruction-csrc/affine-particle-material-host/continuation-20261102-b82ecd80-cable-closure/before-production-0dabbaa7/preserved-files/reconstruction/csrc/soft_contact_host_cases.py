"""Small static-shape contact scenes with one active particle per PCG coefficient group."""
import numpy as np


def base_fixtures(seed):
    rng = np.random.default_rng(seed)
    for worlds in (1, 2, 129, 257):
        for variant in ('plane', 'sphere', 'friction', 'no_hit', 'inactive', 'graph'):
            q = np.tile(np.array([[.01, .02, .025]], dtype='f4'), (worlds, 1))
            q += rng.uniform(-.002, .002, q.shape).astype('f4')
            if variant == 'no_hit':
                q[:, 2] += 1
            sphere = variant == 'sphere'
            yield f'soft_w{worlds}_{variant}', {
                'q': q, 'v': rng.uniform(-.1, .1, q.shape).astype('f4'),
                'mass': np.array([1.5], dtype='f4'),
                'flags': np.array([0 if variant == 'inactive' else 1], dtype='i4'),
                'count': 1, 'worlds': worlds, 'iterations': 3, 'linear_iterations': 9,
                'gravity': np.tile(np.array([[.1, -.2, -9.81]], dtype='f4'), (worlds, 1)),
                'force': rng.uniform(-.1, .1, q.shape).astype('f4'),
                'particle_radii': np.array([.05], dtype='f4'),
                'shape_count': 1, 'shape_replicated_count': 0,
                'shape_bodies': np.array([-1], dtype='i4'),
                'shape_types': np.array([3 if sphere else 6], dtype='i4'),
                'shape_transforms': np.array([[0, 0, -.02, 0, 0, 0, 1]], dtype='f4'),
                'shape_scales': np.array([[.025 if sphere else 1, 1, 1]], dtype='f4'),
                'shape_margins': np.array([.003], dtype='f4'),
                'shape_contact_stiffnesses': np.array([1737.5], dtype='f4'),
                'shape_contact_dampings': np.array([7.5], dtype='f4'),
                'shape_contact_friction_gains': np.array([71.25], dtype='f4'),
                'shape_frictions': np.array([.35], dtype='f4'),
                'soft_contact_stiffness': 2037.5,
                'soft_contact_damping': 3.75 if variant == 'friction' else 0,
                'soft_contact_friction_gain': 93.75,
                'soft_contact_friction': .3 if variant == 'friction' else 0,
                'soft_max_count': worlds, 'soft_count': np.array([worlds], dtype='i4'),
                'soft_particle': np.arange(worlds, dtype='i4'),
                'soft_shape': np.zeros(worlds, dtype='i4'),
                'soft_body_pos': np.zeros((worlds, 3), dtype='f4'),
                'soft_body_vel': np.zeros((worlds, 3), dtype='f4'),
                'soft_normal': np.tile(np.array([[0, 0, 2]], dtype='f4'), (worlds, 1)),
                'mode': variant, 'dt': 1 / 120,
            }


def fixtures(seed):
    cases = list(base_fixtures(seed))
    yield from cases
    base = dict(cases[8][1])  # Two worlds, friction enabled.
    for variant in ('oblique', 'no_hessian', 'no_contact_preconditioner', 'zero_count', 'negative_count',
                    'capped_count', 'invalid_particle', 'invalid_shape', 'damping_cap', 'moving_surface',
                    'zero_normal', 'spring_contact', 'raw_stream', 'protocol_stream', 'iterations0', 'replicated_shape',
                    'other_world_shape', 'zero_mass', 'mode_switch'):
        case = dict(base)
        if variant == 'oblique':
            case['soft_normal'] = np.tile(np.array([[.3, -.4, 1]], dtype='f4'), (2, 1))
        if variant == 'no_hessian':
            case['config'] = {'enable_collision_hessian_non_diagonal': False}
        if variant == 'no_contact_preconditioner':
            case['config'] = {'affine_body_contact_block_preconditioner': False}
        if variant in ('zero_count', 'negative_count', 'capped_count'):
            case['soft_count'] = np.array([0 if variant == 'zero_count' else -3 if variant == 'negative_count' else 7],
                                          dtype='i4')
        if variant == 'invalid_particle':
            case['soft_particle'] = np.array([-1, 20], dtype='i4')
        if variant == 'invalid_shape':
            case['soft_shape'] = np.array([-1, 20], dtype='i4')
        if variant == 'damping_cap':
            case['shape_contact_dampings'] = np.array([900], dtype='f4')
            case['soft_contact_damping'] = 2000
        if variant == 'moving_surface':
            case['soft_body_vel'] = np.tile(np.array([[.15, -.2, .125]], dtype='f4'), (2, 1))
        if variant == 'zero_normal':
            case['soft_normal'] = np.zeros((2, 3), dtype='f4')
        if variant == 'zero_mass':
            case['mass'] = np.zeros(1, dtype='f4')
        if variant == 'mode_switch':
            case['step_modes'] = [0, 1, 0]
        if variant in ('replicated_shape', 'other_world_shape'):
            case['shape_replicated_count'] = 1
            case['soft_shape'] = np.array([0, 1] if variant == 'replicated_shape' else [1, 0], dtype='i4')
        if variant == 'spring_contact':
            for field in ('q', 'v', 'force'):
                data = np.zeros((4, 3), dtype='f4')
                data[1::2] = base[field]
                if field == 'q':
                    data[::2] = np.array([-.7, 0, .3], dtype='f4')
                case[field] = data
            case.update(count=2, mass=np.array([0, 1.5], dtype='f4'), flags=np.ones(2, dtype='i4'),
                        particle_radii=np.array([.05, .05], dtype='f4'),
                        soft_particle=np.array([1, 3], dtype='i4'), spring_indices=np.array([[0, 1]], dtype='i4'),
                        spring_stiffness=np.array([37.5], dtype='f4'), spring_rest=np.array([.7], dtype='f4'))
        if variant == 'iterations0':
            case['iterations'] = 0
        case['mode'] = variant
        yield 'soft_extra_' + variant, case


def pd_fixtures(seed):
    for name, case in fixtures(seed):
        yield name.replace('soft_', 'pd_soft_', 1), {**case, 'solver_mode': 1}
