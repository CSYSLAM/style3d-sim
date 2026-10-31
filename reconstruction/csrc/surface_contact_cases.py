"""Surface-contact original/source GPU probes with exact 296-byte views and full output comparisons."""
import copy
import struct

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc.soft_contact_cases import modules


def cases(rng):
    base, transform = k.surface_contact_case(rng, count=64, n_bodies=8)
    yield 'baseline', base, transform, {}
    for label in ('negative_count', 'zero_capacity', 'partial_capacity', 'flags_null', 'kind_null', 'flags_zero',
                  'mass_zero', 'kind_skip', 'filter', 'filter_short', 'normal_special', 'bary_special',
                  'invalid_indices', 'zero_weights', 'cross_world_vertex', 'worlds', 'shared_static',
                  'shared_body', 'reordered_bodies', 'empty_bodies', 'material_special', 'point_special',
                  'velocity_special', 'alias_indices', 'grid_stride', 'zero_tile'):
        c, t, options = copy.deepcopy(base), transform.copy(), {}
        if label == 'negative_count': options['count'] = -5
        elif label == 'zero_capacity': options['capacity'] = 0
        elif label == 'partial_capacity': options.update(count=99, capacity=19)
        elif label == 'flags_null': c.flags = None
        elif label == 'kind_null': c.kind = None
        elif label == 'flags_zero': c.flags[:] = 0
        elif label == 'mass_zero': c.mass[:] = 0
        elif label == 'kind_skip': c.kind[:] = -1
        elif label.startswith('filter'):
            c.particle_only = np.resize(np.array((0, -1, 2), np.int32), len(c.shape_type))
            if label == 'filter_short': c.particle_only = c.particle_only[:3]
        elif label == 'normal_special':
            c.normal[:6] = ((0, 0, 0), (np.nan, 0, 1), (np.inf, 1, 0), (1e-20, 0, 1e-20),
                            (1e20, 0, 1e20), (-0.0, 0.0, -0.0))
        elif label == 'bary_special':
            c.barycentric[:8] = ((np.nan, 0, 0), (np.inf, 0, 0), (-1, 2, 0), (0.5, 0.5, 0),
                                  (0, 1, 0), (1, np.nan, np.inf), (1.0001, 0, 0), (0.9999, 0, 0))
        elif label == 'invalid_indices':
            c.indices[::3, 0] = -1
            c.indices[1::3, 1] = len(c.x)
            c.indices[2::3, 2] = -2
        elif label == 'zero_weights': c.barycentric[:] = 0
        elif label == 'cross_world_vertex':
            c.x = np.concatenate((c.x, c.x)); c.previous = np.concatenate((c.previous, c.previous))
            c.indices[:, 1] = c.indices[:, 0] + len(base.x)
            options.update(particles_per_world=len(base.x), worlds=2)
        elif label == 'worlds':
            n, tile, count = len(c.x), len(c.shape_type), c.count
            for key in ('x', 'previous'): setattr(c, key, np.concatenate([getattr(c, key)] * 3))
            c.indices = np.concatenate([np.where(c.indices < 0, c.indices, c.indices + world*n) for world in range(3)])
            c.shape = np.concatenate([c.shape + world*tile for world in range(3)])
            for key in ('barycentric', 'body_pos', 'body_vel', 'normal'):
                setattr(c, key, np.concatenate([getattr(c, key)] * 3))
            c.count = 3*count
            options.update(particles_per_world=n, worlds=3)
        elif label.startswith('shared_'):
            options['shapes_per_world'] = len(c.shape_type) - 2
            c.shape[:] = len(c.shape_type) - 2
            c.shape_body[-2:] = -1 if label == 'shared_static' else c.bodies.ids[0]
        elif label == 'reordered_bodies':
            order = rng.permutation(len(c.bodies.ids))
            for key in ('ids', 'indices', 'com'): setattr(c.bodies, key, getattr(c.bodies, key)[order])
        elif label == 'empty_bodies': options['body_count'] = 0
        elif label == 'material_special':
            for key in ('shape_ke', 'shape_kd', 'shape_kf', 'shape_mu'):
                getattr(c, key)[:6] = (np.nan, np.inf, -np.inf, 0, -1, -0.0)
        elif label == 'point_special': c.body_pos[:3] = ((np.nan, 0, 1), (np.inf, 1, 0), (-np.inf, 0, 0))
        elif label == 'velocity_special': c.body_vel[:3] = ((np.nan, 0, 1), (np.inf, 1, 0), (-np.inf, 0, 0))
        elif label == 'alias_indices': c.indices[:, 1:] = c.indices[:, :1]; c.barycentric[:] = (0.2, 0.3, 0.5)
        elif label == 'grid_stride': options['threads'] = 1
        elif label == 'zero_tile': options['particles_per_world'] = 0
        yield label, c, t, options


def launch_case(d, c, transform, options, rng, suffix):
    n = len(c.x)
    like = rng.uniform(-1, 1, (n, 3, 3) if 'preconditioner' in suffix else
                       (n,) if 'stiffness_scale' in suffix else (n, 3)).astype(k.F)
    direction = rng.uniform(-1, 1, (n, 3)).astype(k.F)
    name, texts = modules(suffix)
    results = []
    for text in texts:
        raw = bytearray(bytes(k.surface_view(d, c, transform)))
        patch = lambda offset, value: struct.pack_into('<Q', raw, offset, int(value))
        if 'count' in options: patch(0, d.upload(np.array([options['count']], np.int32)).value)
        for key, offset in (('capacity', 8), ('particles_per_world', 112), ('shapes_per_world', 208),
                            ('worlds', 216), ('body_count', 264)):
            if key in options: patch(offset, options[key])
        output = d.upload(like)
        args = [(k.ctypes.c_char*296).from_buffer_copy(raw)]
        if 'tangent' in suffix: args.append(d.upload(direction))
        args.append(output)
        d.launch(d.function(text, name), options.get('threads', c.count + 17), args, block=32)
        results.append(d.download(output, like))
    return k.compare(suffix, *results)


def run(d, rng):
    out = {}
    for label, c, t, options in cases(rng):
        for suffix in ('30evaluate_surface_contact_force', '34add_surface_contact_preconditioner',
                       '32multiply_surface_contact_tangent', '35add_surface_contact_stiffness_scale'):
            out[label + '_' + suffix] = launch_case(d, c, t, options, rng, suffix)
    return out
