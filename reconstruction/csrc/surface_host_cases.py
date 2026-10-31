"""Static-shape, barycentric soft-contact host fixtures with one dynamic vertex per world."""
import numpy as np

from .soft_contact_host_cases import base_fixtures as particle_contact_fixtures


def base_fixtures(seed):
    rng = np.random.default_rng(seed)
    soft = next(case for name, case in particle_contact_fixtures(seed) if name == 'soft_w2_friction')
    fields = {key: value for key, value in soft.items() if key.startswith(('shape_', 'soft_contact_'))}
    for worlds in (1, 2, 129):
        for variant in ('basic', 'sphere', 'no_hessian', 'particle_only', 'zero_filter', 'graph'):
            q = np.tile(np.array([[-.05, 0, .025], [.05, 0, .025], [0, .05, .025]], dtype='f4'), (worlds, 1))
            q[2::3] += rng.uniform(-.002, .002, (worlds, 3)).astype('f4')
            case = {
                **fields, 'q': q, 'v': rng.uniform(-.1, .1, q.shape).astype('f4'),
                'mass': np.array([0, 0, 1.5], dtype='f4'), 'flags': np.ones(3, dtype='i4'),
                'count': 3, 'worlds': worlds, 'iterations': 3, 'linear_iterations': 9,
                'gravity': rng.uniform(-2, 1, (worlds, 3)).astype('f4'),
                'force': rng.uniform(-.1, .1, q.shape).astype('f4'),
                'particle_radii': np.full(3, .05, dtype='f4'), 'soft_max_count': worlds,
                'soft_count': np.array([worlds], dtype='i4'),
                'soft_particle': np.arange(worlds, dtype='i4')*3+2 if variant == 'particle_only' else None,
                'soft_indices': np.arange(worlds*3, dtype='i4').reshape(-1, 3),
                'soft_barycentric': np.tile(np.array([[.2, .3, .5]], dtype='f4'), (worlds, 1)),
                'soft_shape': np.zeros(worlds, dtype='i4'), 'soft_body_pos': np.zeros((worlds, 3), dtype='f4'),
                'soft_body_vel': np.zeros((worlds, 3), dtype='f4'),
                'soft_normal': np.tile(np.array([[0, 0, 2]], dtype='f4'), (worlds, 1)),
                'mode': variant, 'dt': 1 / 120,
            }
            if variant == 'sphere':
                case['shape_types'] = np.array([3], dtype='i4')
                case['shape_scales'] = np.array([[.025, 1, 1]], dtype='f4')
            if variant == 'no_hessian':
                case['config'] = {'enable_collision_hessian_non_diagonal': False}
            if variant in ('particle_only', 'zero_filter'):
                case['soft_particle_only_shapes'] = np.array([int(variant == 'particle_only')], dtype='i4')
            if variant == 'zero_filter':
                case['expected_error'] = 'ValueError'
            yield f'surface_w{worlds}_{variant}', case


def fixtures(seed):
    yield from base_fixtures(seed)
    base = next(case for name, case in base_fixtures(seed) if name == 'surface_w2_basic')
    for variant in ('particle_no_filter', 'particle_zero_filter', 'filter_missing_particle'):
        case = dict(base)
        if variant != 'filter_missing_particle':
            case['soft_particle'] = np.array([2, 5], dtype='i4')
        if variant != 'particle_no_filter':
            case['soft_particle_only_shapes'] = np.array([int(variant == 'filter_missing_particle')], dtype='i4')
        if variant == 'filter_missing_particle':
            case['expected_error'] = 'ValueError'
        yield 'surface_extra_' + variant, case
    yield 'surface_extra_particle_only_no_hessian', {
        **base, 'soft_particle': np.array([2, 5], dtype='i4'),
        'soft_particle_only_shapes': np.array([1], dtype='i4'),
        'config': {'enable_collision_hessian_non_diagonal': False},
    }
    from .drag_host_cases import fixtures as drag_fixtures
    for name, case in drag_fixtures(seed):
        if not name.startswith('drag_all_'):
            continue
        worlds = case['worlds']
        yield 'surface_combo_' + name, {
            **case, 'soft_particle': None,
            'soft_indices': np.array([[0, 1, 3]], dtype='i4') + (np.arange(worlds, dtype='i4')*4)[:, None],
            'soft_barycentric': np.tile(np.array([[.2, .3, .5]], dtype='f4'), (worlds, 1)),
        }


def pd_fixtures(seed):
    for name, case in fixtures(seed):
        yield 'pd_' + name, {**case, 'solver_mode': 1}
