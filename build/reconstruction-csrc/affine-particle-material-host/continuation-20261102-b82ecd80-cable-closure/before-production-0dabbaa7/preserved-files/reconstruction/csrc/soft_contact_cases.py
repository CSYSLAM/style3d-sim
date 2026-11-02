"""Disjoint-contact GPU probes: compare untouched original PTX with the selected backend, including guard tails."""
import copy
import hashlib

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc import ptx_compare as pc


def modules(suffix):
    if hashlib.sha256(k.LEGACY.read_bytes()).hexdigest() != k.LEGACY_SHA:
        raise RuntimeError('Unexpected original library')
    selected, name = k.legacy_ptx(suffix)
    original = next(path.read_text() for path in sorted(pc.LEGACY_PTX.glob('*.ptx'))
                    if name in pc.entries(path.read_text()))
    return name, (original, selected)


def fixture(rng, static=False):
    local, worlds = 24, 3
    per_world, total = 5*local, 5*local*worlds
    x = rng.uniform(-0.2, 0.2, (total, 3)).astype(k.F)
    indices = (5*np.arange(local)[:, None] + np.arange(4)[None, :]).astype(np.int32)
    for world in range(worlds):
        for j, ids in enumerate(indices):
            a = np.eye(3, dtype=k.F) + rng.uniform(-0.1, 0.1, (3, 3)).astype(k.F)
            if j == 2: a[:] = 0
            if j == 4: a *= k.F(1e-5)
            if j == 6: a[2] = a[1]
            if j == 8: a[0] *= -1
            x[ids[1:] + world*per_world] = a
    com = rng.uniform(-0.03, 0.03, (local, 3)).astype(k.F)
    body_ids = (100 + 3*np.arange(local)).astype(np.int32)
    order = rng.permutation(local)
    shape_body = np.r_[body_ids.copy(), -1, body_ids[0]].astype(np.int32)
    if static: shape_body[:] = -1
    shape_type = np.resize(np.array((3, 1, 3, 7), np.int32), local + 2)
    transform = np.zeros((local + 2, 7), k.F)
    transform[:, :3] = rng.uniform(-0.02, 0.02, (local + 2, 3))
    transform[:, 6] = 1
    scale = rng.uniform(0.04, 0.08, (local + 2, 3)).astype(k.F)
    count = local*worlds
    normal = rng.normal(size=(count, 3)).astype(k.F)
    pos = rng.uniform(-0.05, 0.05, (count, 3)).astype(k.F)
    particle = np.concatenate([5*np.arange(local) + 4 + w*per_world for w in range(worlds)]).astype(np.int32)
    shape = np.arange(count, dtype=np.int32)
    for i in range(count):
        j, world = i % local, i // local
        raw = transform[j, :3] if shape_type[j] == 3 else pos[i]
        if static:
            centre = raw
        else:
            ids = indices[j] + world*per_world
            centre = x[ids[0]].astype(np.float64) + (raw - com[j]).astype(np.float64) @ x[ids[1:]].astype(np.float64)
        unit = normal[i].astype(np.float64) / np.linalg.norm(normal[i].astype(np.float64))
        x[particle[i]] = centre + unit*(float(scale[j, 0]) + 0.04 if shape_type[j] == 3 else 0.04)
    velocity = rng.uniform(-0.02, 0.02, (total, 3)).astype(k.F)
    c = dict(count=count, capacity=count, local=local, worlds=worlds, per_world=per_world, total=total,
             particle=particle, shape=shape, pos=pos, normal=normal, x=x, velocity=velocity,
             previous=(x - velocity/k.F(200)).astype(k.F), bv=rng.uniform(-0.01, 0.01, (count, 3)).astype(k.F),
             radius=rng.uniform(0.08, 0.12, per_world).astype(k.F), mass=np.ones(per_world, k.F),
             kind=np.zeros(per_world, np.int32), shape_body=shape_body, shape_type=shape_type,
             transform=transform, scale=scale, margin=rng.uniform(0, 0.02, local + 2).astype(k.F),
             ke=rng.uniform(100, 1000, local + 2).astype(k.F), kd=rng.uniform(0.01, 2, local + 2).astype(k.F),
             kf=rng.uniform(20, 100, local + 2).astype(k.F), mu=rng.uniform(0.1, 0.8, local + 2).astype(k.F),
             ids=body_ids[order], indices=indices[order], com=com[order], body_count=local, shape_filter=None,
             filter_count=count + 2, inv_dt=200.0, global_ke=900.0, global_kd=1.0, global_kf=80.0, global_mu=0.6,
             output='all', grid_stride=False)
    return c


def launch_case(d, c, rng, offdiag=False):
    n = len(c['x'])
    initial = [rng.uniform(-1, 1, (n, 3)).astype(k.F), rng.uniform(-1, 1, n).astype(k.F),
               rng.uniform(-1, 1, (n, 3, 3)).astype(k.F), rng.uniform(-1, 1, (n, 3, 3)).astype(k.F)]
    if c['output'] == 'aliased_blocks': initial[3] = initial[2].copy()
    direction = rng.uniform(-1, 1, (n, 3)).astype(k.F)
    name, texts = modules('42multiply_soft_contact_hessian_off_diagonal' if offdiag else '27evaluate_soft_contact_force')
    results = []
    for text in texts:
        buffers = [d.upload(a) for a in initial]
        if c['output'] == 'aliased_blocks': buffers[3] = buffers[2]
        cache = {}

        def u(key):
            if key not in cache: cache[key] = k.null() if c[key] is None else d.upload(c[key])
            return cache[key]

        count = k.null() if c['count'] is None else d.upload(np.array([c['count']], np.int32))
        prefix = [count, k.u64(c['capacity']), u('particle'), u('shape'), u('pos')]
        if offdiag:
            args = prefix + [u('normal'), u('radius'), u('shape_body'), u('shape_type'), u('transform'), u('scale'),
                             u('mass'), u('kind'), u('margin'), u('ke'), u('kd'), k.u64(c['local'] + 2),
                             k.u64(c['local']), k.u64(c['worlds']), u('ids'), u('indices'), u('com'),
                             k.u64(c['body_count']), u('x'), d.upload(direction), buffers[0], k.f32(c['inv_dt']),
                             k.u64(c['per_world']), k.f32(c['global_ke']), k.f32(c['global_kd']), k.u64(c['total']),
                             u('shape_filter'), k.u64(c['filter_count']), u('kf'), u('mu'), k.f32(c['global_kf']),
                             k.f32(c['global_mu']), u('bv'), u('previous')]
        else:
            mode = c['output']
            outputs = [buffers[0] if mode not in ('no_force', 'none') else k.null(),
                       buffers[1] if mode not in ('no_scalar', 'none') else k.null(), u('shape_filter'),
                       k.u64(c['filter_count']), buffers[2] if mode not in ('precond_only', 'no_blocks', 'none')
                       else k.null(), buffers[3] if mode not in ('system_only', 'no_blocks', 'none') else k.null()]
            args = prefix + [u('bv'), u('normal'), u('radius'), u('mass'), u('kind'), k.u64(c['per_world']),
                             k.u64(c['total']), u('shape_body'), u('shape_type'), u('transform'), u('scale'),
                             u('margin'), u('ke'), u('kd'), u('kf'), u('mu'), k.u64(c['local'] + 2),
                             k.u64(c['local']), k.u64(c['worlds']), k.f32(c['global_ke']), k.f32(c['global_kd']),
                             k.f32(c['global_kf']), k.f32(c['global_mu']), u('ids'), u('indices'), u('com'),
                             k.u64(c['body_count']), u('x'), u('velocity'), u('previous'), k.f32(c['inv_dt'])] + outputs
        threads = 1 if offdiag and c['grid_stride'] else len(c['particle']) + 17
        d.launch(d.function(text, name), threads, args, block=32)
        results.append([d.download(buf, a) for buf, a in zip(buffers, initial)])
    return {key: k.compare(key, a, b) for key, a, b in zip(('force', 'scalar', 'system', 'precond'), *results)
            if not offdiag or key == 'force'}


def cases(rng):
    base = fixture(rng)
    yield 'multiworld_reordered_bodies', base
    yield 'static', fixture(rng, static=True)
    for mode in ('no_force', 'no_scalar', 'system_only', 'precond_only', 'no_blocks', 'aliased_blocks', 'none'):
        c = copy.deepcopy(base); c['output'] = mode
        yield mode, c
    for count, capacity in ((None, 72), (-5, 72), (0, 72), (72, 0), (999, 19), (19, 72)):
        c = copy.deepcopy(base); c.update(count=count, capacity=capacity)
        yield f'count{count}_cap{capacity}', c
    for label in ('velocity', 'kind_null', 'empty_bodies', 'missing_bodies', 'invalid_particles', 'invalid_shapes',
                  'cross_world_shapes', 'shared_shapes', 'filter', 'filter_short', 'zero_mass', 'kind_skip',
                  'normal_special', 'depth_special', 'material_special', 'alias_indices', 'alias_particle',
                  'duplicate_body_ids', 'global_zero', 'global_nan', 'global_negative', 'grid_stride', 'zero_tile'):
        c = copy.deepcopy(base)
        if label == 'velocity': c['previous'] = None
        elif label == 'kind_null': c['kind'] = None
        elif label == 'empty_bodies': c['body_count'] = 0; c['ids'] = None
        elif label == 'missing_bodies': c['shape_body'][::3] = 9999
        elif label == 'invalid_particles': c['particle'][::3] = -1; c['particle'][1::3] = c['total']
        elif label == 'invalid_shapes': c['shape'][::3] = -1; c['shape'][1::3] = 9999
        elif label == 'cross_world_shapes': c['shape'] = (c['shape'] + c['local']) % 72
        elif label == 'shared_shapes': c['shape'][::2] = 72; c['shape'][1::2] = 73
        elif label.startswith('filter'):
            c['shape_filter'] = np.resize(np.array((1, 0, -1), np.int32), 74)
            if label == 'filter_short': c['filter_count'] = 11
        elif label == 'zero_mass': c['mass'][4::15] = 0; c['mass'][9::15] = -1; c['mass'][14::15] = np.nan
        elif label == 'kind_skip': c['kind'][4::10] = -1
        elif label == 'normal_special':
            c['normal'][:6] = ((0, 0, 0), (np.nan, 0, 1), (np.inf, 1, 0), (1e-20, 0, 1e-20),
                                (1e20, 0, 1e20), (-0.0, 0.0, -0.0))
        elif label == 'depth_special': c['radius'][4:24:5] = (np.nan, np.inf, -np.inf, -0.0)
        elif label == 'material_special':
            for key in ('ke', 'kd', 'kf', 'mu'): c[key][:6] = (np.nan, np.inf, -np.inf, 0, -1, -0.0)
        elif label == 'alias_indices':
            c['indices'][:, 0] = c['indices'][:, 3]
            c['indices'][:, 1] = c['indices'][:, 2]
            c['radius'][:] = 1e3
        elif label == 'alias_particle':
            c['particle'] -= 3
            c['radius'][:] = 1e3
        elif label == 'duplicate_body_ids':
            c['ids'][1] = c['ids'][0]
            c['shape_body'][:] = -1
            c['shape_body'][0] = c['ids'][0]
            c['radius'][:] = 1e3
        elif label.startswith('global_'):
            value = {'global_zero': 0.0, 'global_nan': np.nan, 'global_negative': -1.0}[label]
            for key in ('global_ke', 'global_kd', 'global_kf', 'global_mu'): c[key] = value
        elif label == 'grid_stride': c['grid_stride'] = True
        elif label == 'zero_tile': c['per_world'] = 0
        yield label, c


def run(d, rng):
    out = {}
    for label, c in cases(rng):
        out.update({label + '_' + key: value for key, value in launch_case(d, c, rng).items()})
        if c['previous'] is not None:
            out.update({label + '_offdiag_' + key: value for key, value in launch_case(d, c, rng, True).items()})
    return out
