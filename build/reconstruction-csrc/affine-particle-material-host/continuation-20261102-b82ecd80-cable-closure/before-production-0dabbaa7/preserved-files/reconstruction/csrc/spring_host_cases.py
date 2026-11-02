"""Particle-spring host fixtures, including deterministic one-active-particle-per-world cases."""
import numpy as np


def fixtures(seed):
    rng = np.random.default_rng(seed)
    for worlds in (1, 2, 7, 129):
        for mode in ('basic', 'zero_rest', 'zero_stiffness', 'duplicate', 'graph'):
            local = 2
            q = np.tile(np.array([[0, 0, 0], [1.2, .3, -.2]], dtype='f4'), (worlds, 1))
            q[1::2] += rng.uniform(-.1, .1, (worlds, 3)).astype('f4')
            v = np.zeros_like(q)
            v[1::2] = rng.uniform(-.2, .2, (worlds, 3)).astype('f4')
            indices = np.array([[0, 1], [0, 1]], dtype='i4') if mode == 'duplicate' else np.array([[0, 1]], dtype='i4')
            yield f'spring_w{worlds}_{mode}', {
                'q': q, 'v': v, 'mass': np.array([0, 1.5], dtype='f4'), 'flags': np.ones(local, dtype='i4'),
                'count': local, 'worlds': worlds, 'iterations': 3, 'linear_iterations': 9,
                'gravity': rng.uniform(-2, 1, (worlds, 3)).astype('f4'),
                'force': rng.uniform(-.25, .25, q.shape).astype('f4'),
                'spring_indices': indices,
                'spring_stiffness': np.full(len(indices), 0 if mode == 'zero_stiffness' else 37.5, dtype='f4'),
                'spring_rest': np.full(len(indices), 0 if mode == 'zero_rest' else .7, dtype='f4'),
                'mode': mode, 'dt': 1 / 120,
                'expected_error': 'ValueError' if mode == 'zero_rest' else None,
            }
    for mode in ('basic', 'graph'):
        q = np.array([[0, 0, 0], [.8, .3, .2], [2, -.2, .1]], dtype='f4')
        yield f'spring_chain_{mode}', {
            'q': q, 'v': rng.uniform(-.1, .1, q.shape).astype('f4'),
            'mass': np.array([0, 1.5, 0], dtype='f4'), 'flags': np.ones(3, dtype='i4'),
            'count': 3, 'worlds': 1, 'iterations': 5, 'linear_iterations': 11,
            'gravity': np.array([[0, 0, -9.81]], dtype='f4'),
            'force': rng.uniform(-.25, .25, q.shape).astype('f4'),
            'spring_indices': np.array([[2, 1], [1, 0]], dtype='i4'),
            'spring_stiffness': np.array([41.75, 73.25], dtype='f4'),
            'spring_rest': np.array([.9, .6], dtype='f4'), 'mode': mode, 'dt': 1/120,
        }
    for mode in ('negative_stiffness', 'nan_stiffness', 'infinite_stiffness', 'negative_rest', 'nan_rest',
                 'infinite_rest', 'same_endpoint', 'invalid_endpoint'):
        indices = np.array([[0, 1]], dtype='i4')
        stiffness, rest = np.array([3], dtype='f4'), np.array([1], dtype='f4')
        if 'stiffness' in mode:
            stiffness[0] = -1 if mode.startswith('negative') else np.nan if mode.startswith('nan') else np.inf
        if 'rest' in mode:
            rest[0] = -1 if mode.startswith('negative') else np.nan if mode.startswith('nan') else np.inf
        if mode == 'same_endpoint':
            indices[0] = [0, 0]
        if mode == 'invalid_endpoint':
            indices[0] = [0, 2]
        yield 'spring_invalid_' + mode, {
            'q': np.array([[0, 0, 0], [1, 0, 0]], dtype='f4'), 'v': np.zeros((2, 3), dtype='f4'),
            'mass': np.ones(2, dtype='f4'), 'flags': np.ones(2, dtype='i4'), 'count': 2, 'worlds': 1,
            'gravity': np.zeros((1, 3), dtype='f4'), 'force': None, 'iterations': 1,
            'spring_indices': indices, 'spring_stiffness': stiffness, 'spring_rest': rest,
            'expected_error': 'ValueError',
        }


def pd_fixtures(seed):
    for name, case in fixtures(seed):
        if not case.get('expected_error'):
            yield name.replace('spring_', 'pd_spring_', 1), {**case, 'solver_mode': 1}


def switching_fixtures(seed):
    for name, case in fixtures(seed):
        if name in ('spring_w1_basic', 'spring_w129_basic', 'spring_w2_graph'):
            yield 'switch_' + name, {**case, 'step_modes': [0, 1, 0]}


def pd_particle_fixtures(seed):
    rng = np.random.default_rng(seed)
    for worlds in (1, 129):
        for mode in ('basic', 'graph'):
            yield f'pd_particle_w{worlds}_{mode}', {
                'q': rng.uniform(-1, 1, (worlds, 3)).astype('f4'),
                'v': rng.uniform(-.1, .1, (worlds, 3)).astype('f4'),
                'mass': np.array([1.5], dtype='f4'), 'flags': np.ones(1, dtype='i4'),
                'count': 1, 'worlds': worlds, 'iterations': 3, 'linear_iterations': 9,
                'gravity': rng.uniform(-2, 1, (worlds, 3)).astype('f4'),
                'force': rng.uniform(-.25, .25, (worlds, 3)).astype('f4'), 'mode': mode, 'solver_mode': 1,
            }
