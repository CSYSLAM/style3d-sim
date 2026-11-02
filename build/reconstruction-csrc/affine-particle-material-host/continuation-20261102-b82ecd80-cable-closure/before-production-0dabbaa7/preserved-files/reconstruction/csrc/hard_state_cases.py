"""Original/source GPU checks for hard-state guards and history values outside the finite NumPy spec domain."""
import copy
import struct

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc.soft_contact_cases import modules


def fixture(rng):
    count = 25
    q, indices, com, sb, st, transform, scale, mat, contacts = k.rigid_contact_scene(rng, count)
    return dict(count=count, capacity=count, q=q, previous=(q + rng.normal(scale=0.001, size=q.shape)).astype(k.F),
                indices=indices, com=com, sb=sb, st=st, transform=transform, scale=scale, mat=mat, c=contacts,
                body_ids=np.arange(len(indices), dtype=np.int32), body_count=len(indices),
                particle_stride=len(q), shape_stride=len(sb), worlds=1, alpha=0.95, beta=0.2, gamma=0.8,
                start=100, history=1, reset=1, previous_count=count,
                mapping=rng.integers(-1, count + 2, count, dtype=np.int32),
                old_penalty=rng.uniform(0, 1e5, count).astype(k.F),
                old_dual=rng.normal(size=(count, 3)).astype(k.F), old_normal=rng.normal(size=(count, 3)).astype(k.F),
                penalty=rng.uniform(0, 1e5, count + 7).astype(k.F),
                dual=rng.normal(size=(count + 7, 3)).astype(k.F), anchor=rng.normal(size=(count + 7, 3)).astype(k.F))


def cases(rng):
    base = fixture(rng)
    yield 'baseline', base
    for label in ('null_count', 'negative_count', 'zero_capacity', 'partial_capacity', 'zero_history_count',
                  'negative_history_count', 'mapping_null', 'mapping_outside', 'reuse', 'reset_no_history',
                  'noncanonical_flags', 'normal_special', 'penalty_special', 'history_special', 'scales_special',
                  'material_special', 'no_bodies', 'reordered_bodies', 'invalid_shapes', 'multiverse',
                  'shared_static_shapes', 'shared_body_shapes', 'zero_offsets'):
        c = copy.deepcopy(base)
        if label == 'null_count': c['count'] = None
        elif label == 'negative_count': c['count'] = -1
        elif label == 'zero_capacity': c['capacity'] = 0
        elif label == 'partial_capacity': c['capacity'] = 19; c['count'] = 99
        elif label == 'zero_history_count': c['previous_count'] = 0
        elif label == 'negative_history_count': c['previous_count'] = -5
        elif label == 'mapping_null': c['mapping'] = None
        elif label == 'mapping_outside': c['mapping'][:] = 9999; c['mapping'][::2] = -1
        elif label == 'reuse': c['reset'] = 0
        elif label == 'reset_no_history': c['history'] = 0
        elif label == 'noncanonical_flags': c['history'] = 255; c['reset'] = 2
        elif label == 'normal_special':
            c['c']['normal'][:6] = ((0, 0, 0), (np.nan, 0, 1), (np.inf, 1, 0), (1e-20, 0, 1e-20),
                                    (1e20, 0, 1e20), (-0.0, 0.0, -0.0))
        elif label == 'penalty_special':
            c['penalty'][:6] = (np.nan, np.inf, -np.inf, -1, 0, -0.0)
            c['dual'][:2] = ((np.nan, np.inf, -0.0), (1, 2, -np.inf))
            c['anchor'][:2] = ((np.inf, 1, 0), (-np.inf, -0.0, np.nan))
            c['reset'] = 0
        elif label == 'history_special':
            c['mapping'][:] = np.arange(len(c['mapping']))
            c['old_penalty'][:4] = (np.nan, np.inf, -np.inf, -0.0)
            c['old_dual'][:3] = ((np.nan, 1, 2), (np.inf, -np.inf, 0), (0, 0, -0.0))
            c['old_normal'][:3] = ((0, 0, 0), (np.inf, -0.0, 0), (np.nan, 1, 0))
        elif label == 'scales_special': c.update(alpha=np.nan, beta=-1, gamma=-0.5, start=np.inf)
        elif label == 'material_special':
            for key in ('ke', 'kd', 'mu'): c['mat'][key][:6] = (np.nan, np.inf, -np.inf, 0, -1, -0.0)
        elif label == 'no_bodies': c['body_count'] = 0; c['body_ids'] = None
        elif label == 'reordered_bodies':
            order = rng.permutation(c['body_count'])
            for key in ('body_ids', 'indices', 'com'): c[key] = c[key][order]
        elif label == 'invalid_shapes': c['c']['shape0'][::3] = -1; c['c']['shape1'][1::3] = 9999
        elif label == 'multiverse':
            c['worlds'] = 2
            c['q'] = np.concatenate((c['q'], c['q'] + k.F(0.013)))
            c['previous'] = np.concatenate((c['previous'], c['previous'] - k.F(0.007)))
            for key in ('shape0', 'shape1'): c['c'][key][::2] += len(c['sb'])
            c['c']['shape1'][0] -= len(c['sb'])
        elif label.startswith('shared_'):
            c['shape_stride'] -= 2
            c['c']['shape1'][:] = c['shape_stride']
            c['sb'][-2:] = -1 if label == 'shared_static_shapes' else c['body_ids'][0]
        elif label == 'zero_offsets': c['c']['offset0'] = c['c']['offset1'] = None
        yield label, c


def launch_case(d, c, suffix):
    name, texts = modules(suffix)
    initial = [c['penalty'], c['dual'], c['anchor']]
    results = []
    for text in texts:
        outputs = [d.upload(a) for a in initial]
        arr = lambda a: 0 if a is None else d.upload(a).value
        contacts, mat = c['c'], c['mat']
        words = [arr(None if c['count'] is None else np.array([c['count']], np.int32)), c['capacity']]
        words += [arr(contacts[key]) for key in ('shape0', 'shape1', 'point0', 'point1', 'offset0', 'offset1',
                                                'normal', 'margin0', 'margin1')]
        words += [arr(c['mapping']), arr(c['sb']), arr(c['st']), arr(c['transform']), arr(c['scale'])]
        words += [arr(mat[key]) for key in ('ke', 'kd', 'mu')]
        words += [len(c['sb']), c['shape_stride'], c['worlds'], arr(c['body_ids']), arr(c['indices']), arr(c['com']),
                  c['body_count'], c['particle_stride'], arr(c['q']), arr(c['previous'])]
        raw = struct.pack('<29Q', *words)
        raw += struct.pack('<5f4B', 240, c['alpha'], c['beta'], c['gamma'], c['start'], c['history'], 0, c['reset'], 0)
        raw += struct.pack('<7Q', *(pointer.value for pointer in outputs), arr(c['old_penalty']), arr(c['old_dual']),
                           arr(c['old_normal']), arr(np.array([c['previous_count']], np.int32)))
        assert len(raw) == 312
        d.launch(d.function(text, name), len(c['c']['shape0']) + 17,
                 [(k.ctypes.c_char*312).from_buffer_copy(raw)], block=32)
        results.append([d.download(pointer, a) for pointer, a in zip(outputs, initial)])
    return {key: k.compare(key, a, b) for key, a, b in zip(('penalty', 'dual', 'anchor'), *results)}


def run(d, rng):
    out = {}
    for label, c in cases(rng):
        for suffix in ('24initialize_hard_contacts', '25update_hard_contact_duals'):
            out.update({label + '_' + suffix + '_' + key: value for key, value in launch_case(d, c, suffix).items()})
    return out
