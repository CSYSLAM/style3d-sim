"""Direct original/source comparisons of combined hard-contact outputs and exceptional material/history inputs."""
import copy
import struct

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc.hard_state_cases import cases, fixture
from reconstruction.csrc.soft_contact_cases import modules


def launch_case(d, c, rng, exact=False, mode='all'):
    name, texts = modules('22evaluate_hard_contacts')
    n, bodies = len(c['q']), c['body_count'] * c['worlds']
    initial = [rng.uniform(-1, 1, shape).astype(k.F) for shape in
               ((n, 3), (n,), (n, 3), (n, 3, 3), (n, 3, 3), (max(1, bodies), 144))]
    if mode == 'alias_blocks': initial[4] = initial[3].copy()
    direction = rng.uniform(-1, 1, (n, 3)).astype(k.F)
    results = []
    for text in texts:
        outputs = [d.upload(a) for a in initial]
        if mode == 'alias_blocks': outputs[4] = outputs[3]
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
        raw += struct.pack('<5f4B', 240, c['alpha'], c['beta'], c['gamma'], c['start'], c['history'], exact, c['reset'], 0)
        raw += struct.pack('<7Q', arr(c['penalty']), arr(c['dual']), arr(c['anchor']), arr(c['old_penalty']),
                           arr(c['old_dual']), arr(c['old_normal']), arr(np.array([c['previous_count']], np.int32)))
        assert len(raw) == 312
        enabled = {'all': (0, 1, 2, 3, 4, 5), 'alias_blocks': (0, 1, 2, 3, 4, 5), 'none': (), 'force': (0, 1),
                   'product': (2,), 'blocks': (3, 4), 'system': (3,), 'precond': (4,), 'affine': (5,)}[mode]
        get = lambda i: outputs[i] if i in enabled else k.null()
        args = [(k.ctypes.c_char*312).from_buffer_copy(raw), get(0), get(1),
                d.upload(direction) if 2 in enabled else k.null(), get(2), get(3), get(4), get(5)]
        d.launch(d.function(text, name), len(c['c']['shape0']) + 17, args, block=32)
        results.append([d.download(pointer, a) for pointer, a in zip(outputs, initial)])
    return {key: k.compare(key, a, b) for key, a, b in
            zip(('force', 'scalar', 'product', 'system', 'precond', 'affine'), *results)}


def run(d, rng):
    out = {}
    base = fixture(rng)
    extra = []
    for mode in ('none', 'force', 'product', 'blocks', 'system', 'precond', 'affine', 'alias_blocks'):
        extra.append(('mode_' + mode, base, mode))
    for label in ('alias_indices', 'same_body', 'zero_penalty', 'zero_mu', 'gap_boundary'):
        c = copy.deepcopy(base)
        if label == 'alias_indices': c['indices'][:, 3] = c['indices'][:, 2]
        elif label == 'same_body': c['c']['shape1'][:] = c['c']['shape0']
        elif label == 'zero_penalty': c['penalty'][:] = 0
        elif label == 'zero_mu': c['mat']['mu'][:] = 0
        elif label == 'gap_boundary': c['c']['margin0'][:] = np.nan; c['alpha'] = 0
        extra.append((label, c, 'all'))
    scenarios = [(label, c, 'all') for label, c in cases(rng)] + extra
    for label, c, mode in scenarios:
        for exact in (False, True):
            out.update({label + f'_exact{exact}_' + key: value for key, value in
                        launch_case(d, c, rng, exact, mode).items()})
    return out
