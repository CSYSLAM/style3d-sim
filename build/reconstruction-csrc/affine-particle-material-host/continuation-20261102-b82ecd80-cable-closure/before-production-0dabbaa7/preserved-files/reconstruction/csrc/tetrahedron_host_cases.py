"""Volumetric host fixtures with one dynamic vertex per independent coefficient world."""
import numpy as np


def base_fixtures(seed):
    rng = np.random.default_rng(seed)
    for worlds in (1, 2, 129):
        for variant in ('elastic', 'damped', 'activation', 'inverted', 'zero_material', 'graph',
                        'soft_contact', 'spring_cloth', 'two_tets', 'short_activation'):
            if variant == 'short_activation' and worlds == 1:
                continue
            q = np.tile(np.array([[0, 0, 0], [1, 0, 0], [0, 1, 0], [.1, .2, 1.1]], dtype='f4'), (worlds, 1))
            q[3::4] += rng.uniform(-.05, .05, (worlds, 3)).astype('f4')
            if variant == 'inverted':
                q[3::4, 2] *= -1
            material = np.array([[113.75, 257.125, 0 if variant == 'elastic' else .625]], dtype='f4')
            if variant == 'zero_material':
                material[:] = 0
            case = {
                'q': q, 'v': rng.uniform(-.1, .1, q.shape).astype('f4'),
                'mass': np.array([0, 0, 0, 1.5], dtype='f4'), 'flags': np.ones(4, dtype='i4'),
                'count': 4, 'worlds': worlds, 'iterations': 3, 'linear_iterations': 9,
                'gravity': rng.uniform(-2, 1, (worlds, 3)).astype('f4'),
                'force': rng.uniform(-.25, .25, q.shape).astype('f4'),
                'tetrahedron_indices': np.array([[0, 1, 2, 3]], dtype='i4'),
                'tetrahedron_inverse_dms': np.array([[[1.2, .1, .025], [-.15, .9, -.05], [.075, .125, 1.1]]],
                                                    dtype='f4'),
                'tetrahedron_materials': material,
                'tetrahedron_activations': np.linspace(.125, .375, worlds, dtype='f4') if variant == 'activation' else None,
                'mode': variant, 'dt': 1 / 120,
            }
            if variant == 'soft_contact':
                from .soft_contact_host_cases import base_fixtures
                soft = next(c for name, c in base_fixtures(seed) if name == 'soft_w2_friction')
                case.update({key: value for key, value in soft.items() if key.startswith(('shape_', 'soft_'))})
                case.update(particle_radii=np.full(4, 1.25, dtype='f4'), soft_max_count=worlds,
                            soft_count=np.array([worlds], dtype='i4'),
                            soft_particle=np.arange(worlds, dtype='i4')*4+3,
                            soft_shape=np.zeros(worlds, dtype='i4'), soft_body_pos=np.zeros((worlds, 3), dtype='f4'),
                            soft_body_vel=np.zeros((worlds, 3), dtype='f4'),
                            soft_normal=np.tile(np.array([[0, 0, 2]], dtype='f4'), (worlds, 1)))
            if variant == 'spring_cloth':
                case.update(spring_indices=np.array([[1, 3]], dtype='i4'),
                            spring_stiffness=np.array([43.12345], dtype='f4'), spring_rest=np.array([.8], dtype='f4'),
                            triangle_indices=np.array([[0, 1, 3]], dtype='i4'),
                            triangle_inv_dms=np.array([[[1.25, .125], [-.25, 1.5]]], dtype='f4'),
                            triangle_rest_areas=np.array([.730241], dtype='f4'),
                            triangle_aniso_stiffnesses=np.array([[37.5, 53.75, 11.25]], dtype='f4'))
            if variant == 'two_tets':
                for field in ('q', 'v', 'force'):
                    array = np.zeros((5*worlds, 3), dtype='f4')
                    array.reshape(worlds, 5, 3)[:, :4] = case[field].reshape(worlds, 4, 3)
                    array[4::5] = np.array([-.1, .25, 1.2], dtype='f4') if field == 'q' else .025
                    case[field] = array
                case.update(count=5, mass=np.array([0, 0, 0, 1.5, 1.25], dtype='f4'), flags=np.ones(5, dtype='i4'),
                            tetrahedron_indices=np.array([[0, 1, 2, 3], [0, 1, 2, 4]], dtype='i4'),
                            tetrahedron_inverse_dms=np.concatenate((case['tetrahedron_inverse_dms'],
                                                                   case['tetrahedron_inverse_dms']*.875)),
                            tetrahedron_materials=np.concatenate((material, material*.75)),
                            tetrahedron_activations=np.linspace(-.15, .3, 2*worlds, dtype='f4'))
            if variant == 'short_activation':
                case.update(tetrahedron_activations=np.array([.125], dtype='f4'), expected_error='ValueError')
            yield f'tet_w{worlds}_{variant}', case


def fixtures(seed):
    yield from base_fixtures(seed)
    for name, case in base_fixtures(seed):
        if name.endswith('_soft_contact'):
            yield f'tet_extra_contact_no_hessian_w{case["worlds"]}', {
                **case, 'config': {'enable_collision_hessian_non_diagonal': False},
            }


def pd_fixtures(seed):
    for name, case in fixtures(seed):
        yield 'pd_' + name, {**case, 'solver_mode': 1}
