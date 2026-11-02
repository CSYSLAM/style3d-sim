"""Direct original/source GPU probes of replicated rigid contact, optional outputs and exceptional materials."""
import copy

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc.hard_state_cases import cases, fixture
from reconstruction.csrc.soft_contact_cases import modules


def launch_case(d, c, rng, epsilon=0.0, mode='all', tangent=False, use_previous=True):
    n = len(c['q'])
    initial = [rng.uniform(-1, 1, shape).astype(k.F) for shape in
               ((n, 3), (n,), (n, 3), (n, 3, 3), (n, 3, 3))]
    if mode == 'alias_blocks': initial[4] = initial[3].copy()
    velocity = rng.uniform(-1, 1, (n, 3)).astype(k.F)
    direction = rng.uniform(-1, 1, (n, 3)).astype(k.F)
    name, texts = modules('24evaluate_contact_tangent' if tangent else '22evaluate_contact_force')
    results = []
    for text in texts:
        buffers = [d.upload(a) for a in initial]
        if mode == 'alias_blocks': buffers[4] = buffers[3]
        upload = lambda a: k.null() if a is None else d.upload(a)
        contacts, mat = c['c'], c['mat']
        prefix = [upload(None if c['count'] is None else np.array([c['count']], np.int32)), k.u64(c['capacity'])]
        prefix += [upload(contacts[key]) for key in ('shape0', 'shape1', 'point0', 'point1', 'offset0', 'offset1',
                                                    'normal', 'margin0', 'margin1')]
        prefix += [upload(c[key]) for key in ('sb', 'st', 'transform', 'scale')]
        prefix += [upload(mat[key]) for key in ('ke', 'kd', 'kf', 'mu')]
        prefix += [k.f32(epsilon), k.u64(len(c['sb'])), k.u64(c['shape_stride']), k.u64(c['worlds'])]
        prefix += [upload(c[key]) for key in ('body_ids', 'indices', 'com')] + [k.u64(c['body_count'])]
        enabled = {'all': (0, 1, 2, 3, 4), 'alias_blocks': (0, 1, 2, 3, 4), 'none': (),
                   'force': (0,), 'scalar': (1,), 'product': (2,), 'system': (3,), 'precond': (4,)}[mode]
        get = lambda i: buffers[i] if i in enabled else k.null()
        if tangent:
            args = prefix + [upload(c['q']), upload(c['previous']), upload(direction) if 2 in enabled else k.null(),
                             get(2), k.f32(240), k.u64(c['particle_stride']), get(3), get(4)]
        else:
            args = prefix + [k.u64(c['particle_stride']), upload(c['q']), upload(velocity),
                             upload(c['previous']) if use_previous else k.null(), k.f32(240), get(0), get(1)]
        d.launch(d.function(text, name), len(contacts['shape0']) + 17, args, block=32)
        results.append([d.download(pointer, a) for pointer, a in zip(buffers, initial)])
    fields = ('force', 'scalar', 'product', 'system', 'precond')
    return {key: k.compare(key, a, b) for index, (key, a, b) in enumerate(zip(fields, *results))
            if (index >= 2) == tangent}


def run(d, rng):
    out = {}
    keep = {'baseline', 'null_count', 'negative_count', 'zero_capacity', 'partial_capacity', 'normal_special',
            'material_special', 'no_bodies', 'reordered_bodies', 'invalid_shapes', 'multiverse',
            'shared_static_shapes', 'shared_body_shapes', 'zero_offsets'}
    scenarios = [(label, c, eps, 'all', True) for label, c in cases(rng) if label in keep for eps in (0.0, 0.05)]
    base = fixture(rng)
    for mode in ('none', 'force', 'scalar', 'product', 'system', 'precond', 'alias_blocks'):
        scenarios.append(('mode_' + mode, base, 0.0, mode, True))
    for epsilon in (-1.0, np.nan, np.inf): scenarios.append((f'eps{epsilon}', base, epsilon, 'all', True))
    scenarios.append(('velocity', base, 0.05, 'all', False))
    for label in ('alias_indices', 'same_body', 'zero_material', 'material_kf_special', 'swapped_sides',
                  'point_special', 'position_special'):
        c = copy.deepcopy(base)
        if label == 'alias_indices': c['indices'][:, 3] = c['indices'][:, 2]
        elif label == 'same_body': c['c']['shape1'][:] = c['c']['shape0']
        elif label == 'zero_material':
            for key in ('ke', 'kd', 'kf', 'mu'): c['mat'][key][:] = 0
        elif label == 'material_kf_special': c['mat']['kf'][:6] = (np.nan, np.inf, -np.inf, 0, -1, -0.0)
        elif label == 'swapped_sides':
            for key in ('shape', 'point', 'offset', 'margin'):
                c['c'][key + '0'], c['c'][key + '1'] = c['c'][key + '1'], c['c'][key + '0']
            c['c']['normal'] = -c['c']['normal']
        elif label == 'point_special':
            c['c']['point0'][:3] = ((np.nan, 0, 1), (np.inf, 1, 0), (-np.inf, -0.0, 1))
            c['c']['offset0'] = c['c']['offset1'] = None
        elif label == 'position_special': c['q'][:4, 0] = (np.nan, np.inf, -np.inf, -0.0)
        scenarios.append((label, c, 0.0, 'all', True))
    for label, c, epsilon, mode, use_previous in scenarios:
        for tangent in (False, True) if use_previous else (False,):
            out.update({label + f'_eps{epsilon}_tangent{tangent}_' + key: value for key, value in
                        launch_case(d, c, rng, epsilon, mode, tangent, use_previous).items()})
    return out
