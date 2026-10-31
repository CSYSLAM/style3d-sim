"""Four-vertex bending stencils with one active vertex per PCG world."""
import numpy as np


def fixtures(seed):
    rng = np.random.default_rng(seed)
    for worlds in (1, 2, 129):
        for variant in ('elastic', 'damped', 'graph', 'boundary', 'zero_area', 'membrane', 'soft_contact'):
            q = np.tile(np.array([[0, .6, 0], [0, -.6, 0], [-.5, 0, 0], [.6, .1, .2]], dtype='f4'), (worlds, 1))
            q[3::4] += rng.uniform(-.05, .05, (worlds, 3)).astype('f4')
            indices = np.array([[0, 1, 2, 3]], dtype='i4')
            if variant == 'boundary':
                indices[0, 0] = -1
            case = {
                'q': q, 'v': rng.uniform(-.1, .1, q.shape).astype('f4'),
                'mass': np.array([0, 0, 0, 1.5], dtype='f4'), 'flags': np.ones(4, dtype='i4'),
                'count': 4, 'worlds': worlds, 'iterations': 3, 'linear_iterations': 9,
                'gravity': rng.uniform(-2, 1, (worlds, 3)).astype('f4'),
                'force': rng.uniform(-.25, .25, q.shape).astype('f4'),
                'edge_indices': indices, 'edge_rest_areas': np.array([0 if variant == 'zero_area' else .85], dtype='f4'),
                'edge_bending_cots': np.array([[.7, .4, .6, .8]], dtype='f4'),
                'edge_bending_properties': np.array([[17.5, 0 if variant == 'elastic' else .75]], dtype='f4'),
                'mode': variant, 'dt': 1 / 120,
            }
            if variant == 'membrane':
                case.update(triangle_indices=np.array([[0, 2, 3]], dtype='i4'),
                            triangle_inv_dms=np.array([[[1.25, .125], [-.25, 1.5]]], dtype='f4'),
                            triangle_rest_areas=np.array([.45], dtype='f4'),
                            triangle_aniso_stiffnesses=np.array([[37.5, 53.75, 11.25]], dtype='f4'))
            if variant == 'soft_contact':
                from .soft_contact_host_cases import base_fixtures
                contact_case = next(case for name, case in base_fixtures(seed) if name == 'soft_w2_friction')
                case.update({key: value for key, value in contact_case.items() if key.startswith(('shape_', 'soft_'))})
                case.update(particle_radii=np.full(4, .35, dtype='f4'), soft_max_count=worlds,
                            soft_count=np.array([worlds], dtype='i4'),
                            soft_particle=np.arange(worlds, dtype='i4') * 4 + 3,
                            soft_shape=np.zeros(worlds, dtype='i4'), soft_body_pos=np.zeros((worlds, 3), dtype='f4'),
                            soft_body_vel=np.zeros((worlds, 3), dtype='f4'),
                            soft_normal=np.tile(np.array([[0, 0, 2]], dtype='f4'), (worlds, 1)))
            yield f'bending_w{worlds}_{variant}', case


def pd_fixtures(seed):
    for name, case in fixtures(seed):
        yield 'pd_' + name, {**case, 'solver_mode': 1}
