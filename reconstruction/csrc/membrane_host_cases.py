"""Anisotropic membrane scenes with one active vertex per replicated world."""
import numpy as np


def fixtures(seed):
    rng = np.random.default_rng(seed)
    for worlds in (1, 2, 129):
        for variant in ('basic', 'graph', 'zero_shear', 'zero_stiffness'):
            q = np.tile(np.array([[0, 0, 0], [1, 0, 0], [.25, .9, .15]], dtype='f4'), (worlds, 1))
            q[2::3] += rng.uniform(-.1, .1, (worlds, 3)).astype('f4')
            stiffness = np.array([[37.5, 53.75, 11.25]], dtype='f4')
            if variant == 'zero_shear':
                stiffness[:, 2] = 0
            if variant == 'zero_stiffness':
                stiffness[:] = 0
            yield f'membrane_w{worlds}_{variant}', {
                'q': q, 'v': rng.uniform(-.1, .1, q.shape).astype('f4'),
                'mass': np.array([0, 0, 1.5], dtype='f4'), 'flags': np.ones(3, dtype='i4'),
                'count': 3, 'worlds': worlds, 'iterations': 3, 'linear_iterations': 9,
                'gravity': rng.uniform(-2, 1, (worlds, 3)).astype('f4'),
                'force': rng.uniform(-.25, .25, q.shape).astype('f4'),
                'triangle_indices': np.array([[0, 1, 2]], dtype='i4'),
                'triangle_inv_dms': np.array([[[1.25, .125], [-.25, 1.5]]], dtype='f4'),
                'triangle_rest_areas': np.array([.45], dtype='f4'),
                'triangle_aniso_stiffnesses': stiffness, 'mode': variant, 'dt': 1 / 120,
            }


def pd_fixtures(seed):
    for name, case in fixtures(seed):
        yield 'pd_' + name, {**case, 'solver_mode': 1}
