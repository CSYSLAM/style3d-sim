"""Old/source rolling-friction checks, including singular inertia, nullable coefficients and replicated worlds."""
import copy
import struct

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc.hard_state_cases import cases, fixture
from reconstruction.csrc.soft_contact_cases import modules


def scenarios(rng):
    keep = {'baseline', 'null_count', 'negative_count', 'zero_capacity', 'partial_capacity', 'normal_special',
            'material_special', 'no_bodies', 'reordered_bodies', 'invalid_shapes', 'multiverse',
            'shared_static_shapes', 'shared_body_shapes', 'zero_offsets'}
    for label, c in cases(rng):
        if label not in keep: continue
        c['rolling'] = rng.uniform(0, 0.02, len(c['sb'])).astype(k.F)
        c['torsional'] = rng.uniform(0, 0.05, len(c['sb'])).astype(k.F)
        c['inertia'] = k.random_inertia(rng, c['body_count'])
        c['epsilon'] = 0.1
        yield label, c
    base = fixture(rng)
    base.update(rolling=rng.uniform(0, 0.02, len(base['sb'])).astype(k.F),
                torsional=rng.uniform(0, 0.05, len(base['sb'])).astype(k.F),
                inertia=k.random_inertia(rng, base['body_count']), epsilon=0.1)
    for label in ('rolling_only', 'torsion_only', 'both_null', 'coefficients_special', 'inertia_zero',
                  'inertia_special', 'epsilon_zero', 'epsilon_negative', 'epsilon_nan', 'epsilon_inf',
                  'zero_velocity', 'zero_velocity_zero_eps', 'same_body', 'swapped_sides', 'alias_indices',
                  'axis_switch', 'position_special', 'previous_special'):
        c = copy.deepcopy(base)
        if label == 'rolling_only': c['torsional'] = None
        elif label == 'torsion_only': c['rolling'] = None
        elif label == 'both_null': c['rolling'] = c['torsional'] = None
        elif label == 'coefficients_special':
            for key in ('rolling', 'torsional'): c[key][:6] = (np.nan, np.inf, -np.inf, 0, -1, -0.0)
        elif label == 'inertia_zero': c['inertia'][:] = 0
        elif label == 'inertia_special':
            c['inertia'][:4] = ((np.nan, 0, 0, 0, 1, 0, 0, 0, 1), (np.inf, 0, 0, 0, 1, 0, 0, 0, 1),
                                (-1, 0, 0, 0, -1, 0, 0, 0, -1), (1, 2, 3, 4, 5, 6, 7, 8, 9))
        elif label.startswith('epsilon_'):
            c['epsilon'] = {'epsilon_zero': 0, 'epsilon_negative': -1, 'epsilon_nan': np.nan, 'epsilon_inf': np.inf}[label]
        elif label.startswith('zero_velocity'):
            c['previous'] = c['q'].copy()
            if label.endswith('zero_eps'): c['epsilon'] = 0
        elif label == 'same_body': c['c']['shape1'][:] = c['c']['shape0']
        elif label == 'swapped_sides':
            for key in ('shape', 'point', 'offset', 'margin'):
                c['c'][key + '0'], c['c'][key + '1'] = c['c'][key + '1'], c['c'][key + '0']
            c['c']['normal'] = -c['c']['normal']
        elif label == 'alias_indices': c['indices'][:, 3] = c['indices'][:, 2]
        elif label == 'axis_switch':
            c['st'][:] = 7
            c['c']['normal'][:6] = ((1, 0, 0), (-1, 0, 0), (0, 1, 0), (0, 0, 1),
                                    (0.9, 0.4358899, 0), (-0.9, 0.4358899, 0))
        elif label == 'position_special': c['q'][:4, 0] = (np.nan, np.inf, -np.inf, -0.0)
        elif label == 'previous_special': c['previous'][:4, 1] = (np.nan, np.inf, -np.inf, -0.0)
        yield label, c


def launch_case(d, c, rng, suffix):
    name, texts = modules(suffix)
    n = len(c['q'])
    like = rng.uniform(-1, 1, (n, 9) if 'preconditioner' in suffix else (n, 3)).astype(k.F)
    direction = rng.uniform(-1, 1, (n, 3)).astype(k.F)
    results = []
    for text in texts:
        contacts, mat = c['c'], c['mat']
        arr = lambda a: 0 if a is None else d.upload(a).value
        words = [arr(None if c['count'] is None else np.array([c['count']], np.int32)), c['capacity']]
        words += [arr(contacts[key]) for key in ('shape0', 'shape1', 'point0', 'point1', 'offset0', 'offset1',
                                                'normal', 'margin0', 'margin1')]
        words += [arr(c[key]) for key in ('sb', 'st', 'transform', 'scale')]
        words += [arr(mat[key]) for key in ('ke', 'kd')]
        words += [arr(c['rolling']), arr(c['torsional']), len(c['sb']), c['shape_stride'], c['worlds']]
        words += [arr(c[key]) for key in ('body_ids', 'indices', 'com', 'inertia')]
        words += [c['body_count'], c['particle_stride'], arr(c['q']), arr(c['previous'])]
        raw = struct.pack('<30Q', *words) + struct.pack('<ff', 240, c['epsilon'])
        output = d.upload(like)
        args = [(k.ctypes.c_char*248).from_buffer_copy(raw)]
        if 'tangent' in suffix: args.append(d.upload(direction))
        args.append(output)
        d.launch(d.function(text, name), len(contacts['shape0']) + 17, args, block=32)
        results.append(d.download(output, like))
    return k.compare(suffix, *results)


def run(d, rng):
    out = {}
    for label, c in scenarios(rng):
        for suffix in ('30evaluate_rolling_contact_force', '34add_rolling_contact_preconditioner',
                       '32multiply_rolling_contact_tangent'):
            out[label + '_' + suffix] = launch_case(d, c, rng, suffix)
    return out
