"""Aerodynamic triangle drag host fixtures, including compacted zero-coefficient faces."""
import numpy as np


def base_fixtures(seed):
    rng = np.random.default_rng(seed)
    for worlds in (1, 2, 129):
        for variant in ('basic', 'wind', 'zero_density', 'zero_coefficient', 'compaction', 'degenerate', 'graph'):
            q = np.tile(np.array([[0, 0, 0], [1, 0, 0], [.25, .9, .15]], dtype='f4'), (worlds, 1))
            q[2::3] += rng.uniform(-.1, .1, (worlds, 3)).astype('f4')
            if variant == 'degenerate':
                q[2::3] = q[1::3]
            indices = np.array([[0, 1, 2]], dtype='i4')
            coefficient = np.array([.875], dtype='f4')
            if variant == 'compaction':
                indices = np.tile(indices, (3, 1))
                coefficient = np.array([0, .875, 0], dtype='f4')
            if variant == 'zero_coefficient':
                coefficient[:] = 0
            yield f'drag_w{worlds}_{variant}', {
                'q': q, 'v': rng.uniform(-.1, .1, q.shape).astype('f4'),
                'mass': np.array([0, 0, 1.5], dtype='f4'), 'flags': np.ones(3, dtype='i4'),
                'count': 3, 'worlds': worlds, 'iterations': 3, 'linear_iterations': 9,
                'gravity': rng.uniform(-2, 1, (worlds, 3)).astype('f4'),
                'force': rng.uniform(-.25, .25, q.shape).astype('f4'),
                'collision_triangle_indices': indices, 'triangle_drag_coefficients': coefficient,
                'config': {'air_density': 0 if variant == 'zero_density' else 1.225,
                           'wind_velocity': (.35, -.25, 1.5) if variant == 'wind' else (0, 0, 0)},
                'mode': variant, 'dt': 1 / 120,
            }


def fixtures(seed):
    yield from base_fixtures(seed)
    base = next(base_fixtures(seed))[1]
    for variant in ('negative_density', 'nan_density', 'negative_coefficient', 'nan_coefficient'):
        case = {**base, 'config': dict(base['config'])}
        if variant.endswith('density'):
            case['config']['air_density'] = -1 if variant.startswith('negative') else float('nan')
            case['expected_error'] = 'ValueError'
        else:
            case['triangle_drag_coefficients'] = np.array([-1 if variant.startswith('negative') else np.nan], dtype='f4')
            case['expected_error'] = 'ValueError'
        yield 'drag_extra_' + variant, case
    from .tetrahedron_host_cases import fixtures as tetrahedron_fixtures
    for name, case in tetrahedron_fixtures(seed):
        if not name.endswith(('_soft_contact', '_spring_cloth')):
            continue
        yield 'drag_combo_' + name, {
            **case, 'collision_triangle_indices': np.array([[0, 1, 3]], dtype='i4'),
            'triangle_drag_coefficients': np.array([.875], dtype='f4'),
            'config': {'air_density': 1.225, 'wind_velocity': (.35, -.25, 1.5)},
        }
        if name.endswith('_soft_contact'):
            yield 'drag_all_' + name, {
                **case, 'collision_triangle_indices': np.array([[0, 1, 3]], dtype='i4'),
                'triangle_drag_coefficients': np.array([.875], dtype='f4'),
                'config': {'air_density': 1.225, 'wind_velocity': (.35, -.25, 1.5)},
                'spring_indices': np.array([[1, 3]], dtype='i4'),
                'spring_stiffness': np.array([43.12345], dtype='f4'), 'spring_rest': np.array([.8], dtype='f4'),
                'triangle_indices': np.array([[0, 1, 3]], dtype='i4'),
                'triangle_inv_dms': np.array([[[1.25, .125], [-.25, 1.5]]], dtype='f4'),
                'triangle_rest_areas': np.array([.730241], dtype='f4'),
                'triangle_aniso_stiffnesses': np.array([[37.5, 53.75, 11.25]], dtype='f4'),
                'edge_indices': np.array([[0, 1, 2, 3]], dtype='i4'), 'edge_rest_areas': np.array([.85], dtype='f4'),
                'edge_bending_cots': np.array([[.7, .4, .6, .8]], dtype='f4'),
                'edge_bending_properties': np.array([[17.5, .75]], dtype='f4'),
            }


def pd_fixtures(seed):
    for name, case in fixtures(seed):
        yield 'pd_' + name, {**case, 'solver_mode': 1}
