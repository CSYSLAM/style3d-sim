"""Overlapping spring/cloth columns, with a single dynamic particle per PCG world."""
import numpy as np


def fixtures(seed):
    rng = np.random.default_rng(seed)
    for worlds in (1, 2, 129):
        for variant in ('basic', 'duplicates', 'zero_stiffness', 'positive_column', 'graph',
                        'rounding_springs', 'rounding_cloth', 'positive_offdiag'):
            q = np.tile(np.array([[0, 0, 0], [1, 0, 0], [.25, .9, .15]], dtype='f4'), (worlds, 1))
            q[2::3] += rng.uniform(-.1, .1, (worlds, 3)).astype('f4')
            triangle_count, spring_count = (3, 3) if variant == 'duplicates' else (1, 1)
            pose = np.array([[1.25, .125], [-.25, 1.5]], dtype='f4')
            if variant == 'positive_column':
                pose = np.array([[1.25, -1.125], [-.875, 1.75]], dtype='f4')
            if variant == 'positive_offdiag':
                pose = np.array([[1.25, -1.25], [-.875, 2.75]], dtype='f4')
            if variant == 'rounding_springs':
                spring_count = 32
            if variant == 'rounding_cloth':
                triangle_count = 32
            case = {
                'q': q, 'v': rng.uniform(-.1, .1, q.shape).astype('f4'),
                'mass': np.array([0, 0, 1.5], dtype='f4'), 'flags': np.ones(3, dtype='i4'),
                'count': 3, 'worlds': worlds, 'iterations': 3, 'linear_iterations': 9,
                'gravity': rng.uniform(-2, 1, (worlds, 3)).astype('f4'),
                'force': rng.uniform(-.25, .25, q.shape).astype('f4'),
                'triangle_indices': np.tile(np.array([[0, 1, 2]], dtype='i4'), (triangle_count, 1)),
                'triangle_inv_dms': np.tile(pose, (triangle_count, 1, 1)),
                'triangle_rest_areas': np.linspace(.730241, .4957, triangle_count, dtype='f4'),
                'triangle_aniso_stiffnesses': np.tile(np.array([[257.175, 121.2345, 11.333]], dtype='f4'),
                                                     (triangle_count, 1)),
                'spring_indices': np.tile(np.array([[1, 2]], dtype='i4'), (spring_count, 1)),
                'spring_stiffness': np.linspace(43.12345, 27.37513, spring_count, dtype='f4'),
                'spring_rest': np.linspace(.8, .9, spring_count, dtype='f4'), 'mode': variant, 'dt': 1 / 120,
            }
            if variant == 'zero_stiffness':
                case['triangle_aniso_stiffnesses'][:] = 0
                case['spring_stiffness'][:] = 0
            if variant == 'rounding_springs':
                case['spring_stiffness'][:] = 2**-19
                case['spring_rest'][:] = .8
            if variant == 'rounding_cloth':
                case['triangle_rest_areas'][:] = .730241
                case['triangle_aniso_stiffnesses'] *= np.float32(2**-20)
                case['spring_stiffness'][:] = 32768
            yield f'mixed_w{worlds}_{variant}', case


def pd_fixtures(seed):
    for name, case in fixtures(seed):
        yield 'pd_' + name, {**case, 'solver_mode': 1}
