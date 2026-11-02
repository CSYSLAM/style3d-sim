"""Direct GPU comparisons of self-contact guards and layouts, independent of the frozen NumPy formulas."""
import hashlib

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc import ptx_compare as pc


PREFIX = '_ZN7synreal21self_collision_kernel'


def modules(suffix):
    if hashlib.sha256(k.LEGACY.read_bytes()).hexdigest() != k.LEGACY_SHA:
        raise RuntimeError('Unexpected legacy library hash')
    selected, name = k.legacy_ptx(PREFIX + suffix)
    original = next(path.read_text() for path in sorted(pc.LEGACY_PTX.glob('*.ptx'))
                    if name in pc.entries(path.read_text()))
    return name, (original, selected)


def run(driver, rng):
    d, out = driver, {}
    per_world, worlds, count = 32, 3, 79
    cases = ('valid', 'negative_distance', 'zero_distance', 'distance_boundary', 'above_boundary',
             'outside_triangle', 'degenerate', 'tiny_normal', 'tiny_barycentric_denominator', 'zero_mass',
             'zero_other_mass', 'overflow_product', 'overflow_sum', 'nan_other_mass', 'inf_other_mass',
             'negative_mass', 'nan_position', 'inf_position', 'nan_candidate', 'inf_candidate',
             'incident', 'empty', 'negative_count', 'multiple', 'nan_radius', 'inf_radius',
             'negative_radius', 'subnormal_mass', 'zero_stiffness_scale', 'coincident', 'threshold', 'above_threshold')

    def accumulate(label, suffix, positions, initial_f, initial_h, make_args, record_count, enabled,
                   expect_change=True, expect_contacts=None):
        name, texts = modules(suffix)
        results = []
        for text in texts:
            f, h = d.upload(initial_f), d.upload(initial_h)
            empty = np.zeros(record_count + 7, k.selfcollision.CONTACT_TANGENT)
            records, counter = d.upload(empty), d.upload(np.zeros(1, np.uint32))
            args = make_args(f, h, records if enabled else k.null(), counter if enabled else k.null())
            d.launch(d.function(text, name), count + 17, args)
            used = int(d.download(counter, np.zeros(1, np.uint32))[0])
            if used > record_count:
                raise AssertionError('Contact list overflow')
            data = d.download(records, empty)
            ordered = np.sort(data[:used], order='ids')
            results.append((d.download(f, initial_f), d.download(h, initial_h), ordered, used, data[used:]))
        a, b = results
        out[label + '_force'] = k.compare('f', a[0], b[0])
        out[label + '_diagonal'] = k.compare('h', a[1], b[1])
        out[label + '_records'] = {'bitwise_equal': a[3] == b[3] and a[2].tobytes() == b[2].tobytes(),
                                   'contacts': a[3]}
        out[label + '_coverage'] = {
            'bitwise_equal': bool((bool(np.any(a[0] != initial_f) or np.any(a[1] != initial_h)) == expect_change)
                                  and (a[3] > 0 if (enabled if expect_contacts is None else expect_contacts) else a[3] == 0)
                                  and not np.any(a[4].view(np.uint8)) and not np.any(b[4].view(np.uint8))),
            'changed_particles': int(np.any(a[0] != initial_f, axis=1).sum()), 'contacts': a[3],
            'scenarios': list(cases)}
        # The unlaunched tail of the last world and the extra guard world are untouched.
        tail = positions * (count % per_world) + positions * per_world * (worlds - 1)
        out[label + '_tail_force'] = k.compare('f', initial_f[tail:], b[0][tail:])
        out[label + '_tail_diagonal'] = k.compare('h', initial_h[tail:], b[1][tail:])

    # Each query owns eight particles, two triangles and a separate optional radius. Worlds share topology only.
    size = 8 * per_world
    x = np.zeros((worlds + 1, size, 3), k.F)
    mass = rng.uniform(0.2, 3, (worlds + 1, size)).astype(k.F)
    radius = np.full(size, k.F(0.03125))
    vertices = np.arange(per_world, dtype=np.int32) * 8 + 7
    triangles = np.array([[8*i + j for j in (0, 1, 2)] for i in range(per_world)
                          for _ in range(2)], np.int32)
    triangles[1::2] += 3
    counts = np.ones(worlds * per_world, np.int32)
    slots = np.tile(np.arange(2 * per_world, dtype=np.int32).reshape(-1, 2), (worlds, 1))
    for world in range(worlds + 1):
        for i, case in enumerate(cases):
            base = 8*i
            p = x[world, base:base + 8]
            p[:3] = ((0, 0, 0), (1, 0, 0), (0, 1, 0))
            p[3:6] = p[:3] + np.array((0, 0, 0.015625), k.F)
            p[7] = (0.25, 0.25, 0.015625)
            if case == 'negative_distance': p[7, 2] *= -1
            if case == 'zero_distance': p[7, 2] = 0
            if case == 'distance_boundary': p[7, 2] = k.F(0.0625)
            if case == 'above_boundary': p[7, 2] = np.nextafter(k.F(0.0625), k.F(np.inf))
            if case == 'outside_triangle': p[7, :2] = 2
            if case == 'degenerate': p[2] = p[1]
            if case == 'tiny_normal': p[1, 0], p[2, 1] = k.F(1e-7), k.F(1e-7)
            if case == 'tiny_barycentric_denominator': p[1, 0], p[2, 1] = k.F(1e-4), k.F(1e-4)
            if case == 'zero_mass': mass[world, base + 7] = 0
            if case == 'zero_other_mass': mass[world, base:base + 3] = 0
            if case == 'overflow_product': mass[world, base:base + 8] = k.F(1e25)
            if case == 'overflow_sum': mass[world, base:base + 8] = np.finfo(k.F).max
            if case == 'nan_other_mass': mass[world, base] = np.nan
            if case == 'inf_other_mass': mass[world, base] = np.inf
            if case == 'negative_mass': mass[world, base + 7] = -1
            if case == 'nan_position': p[7, 0] = np.nan
            if case == 'inf_position': p[7, 2] = np.inf
            if case == 'nan_candidate': p[0, 1] = np.nan
            if case == 'inf_candidate': p[1, 2] = np.inf
            if case == 'incident': triangles[2*i, 0] = base + 7
            if world < worlds:
                if case == 'empty': counts[world*per_world + i] = 0
                if case == 'negative_count': counts[world*per_world + i] = -1
                if case == 'multiple': counts[world*per_world + i] = 2
            if case == 'nan_radius': radius[base + 7] = np.nan
            if case == 'inf_radius': radius[base + 7] = np.inf
            if case == 'negative_radius': radius[base + 7] = -0.25
            if case == 'subnormal_mass': mass[world, base:base + 8] = np.finfo(k.F).tiny / k.F(2)
            if case == 'zero_stiffness_scale': mass[world, base + 7] = -0.0
    flat = x.reshape(-1, 3)
    f0 = rng.uniform(-1, 1, flat.shape).astype(k.F)
    h0 = rng.uniform(-1, 1, (len(flat), 9)).astype(k.F)
    f0[::2], h0[::2] = 0, 0
    common = [d.upload(flat), d.upload(vertices)]
    geometry = [d.upload(triangles), d.upload(counts), d.upload(slots), d.upload(mass)]
    for optional, enabled, skip in ((False, True, True), (True, True, True), (True, False, False), (False, False, False)):
        args = common + [d.upload(radius) if optional else k.null()] + geometry
        args += [k.f32(0.03125), k.f32(0.03125), k.ctypes.c_uint8(skip), k.f32(0.5)]
        sizes = [k.u64(count), k.u64(per_world), k.u64(size), k.ctypes.c_int32(2)]
        accumulate(f'vf_radius{int(optional)}_records{int(enabled)}_skip{int(skip)}', '22accumulate_vertex_face',
                   8, f0, h0, lambda f, h, r, c: args + [f, h, r, c] + sizes, 2*count, enabled)
    for stiffness in (0, -1, np.inf, np.nan):
        args = common + [k.null()] + geometry
        args += [k.f32(0.03125), k.f32(0.03125), k.ctypes.c_uint8(True), k.f32(stiffness)]
        accumulate(f'vf_k{stiffness}', '22accumulate_vertex_face', 8, f0, h0,
                   lambda f, h, r, c: args + [f, h, r, c] + sizes, 2*count, True,
                   expect_change=bool(np.isfinite(stiffness) and stiffness != 0),
                   expect_contacts=bool(np.isfinite(stiffness)))

    # Disjoint three-candidate particle rows cover all three coincidence axes and multiple contacts per query.
    size = 4*per_world
    x = rng.uniform(-0.01, 0.01, (worlds + 1, size, 3)).astype(k.F)
    ids = 4*np.arange(per_world, dtype=np.int32)
    slots = np.tile((ids[:, None] + np.arange(1, 4, dtype=np.int32)), (worlds, 1))
    counts = np.ones(worlds*per_world, np.int32)
    mass = rng.uniform(0.2, 3, (worlds + 1, size)).astype(k.F)
    radius = np.full(size, k.F(0.03125))
    for world in range(worlds + 1):
        for i, case in enumerate(cases):
            base = 4*i
            p = x[world, base:base + 4]
            if case in ('distance_boundary', 'above_boundary'):
                p[0], p[1] = (0, 0, 0), (0.0625, 0, 0)
                if case == 'above_boundary': p[1, 0] = np.nextafter(k.F(0.0625), k.F(np.inf))
            if case == 'zero_mass': mass[world, base] = 0
            if case == 'zero_other_mass': mass[world, base + 1] = 0
            if case == 'overflow_product': mass[world, base:base + 4] = k.F(1e25)
            if case == 'overflow_sum': mass[world, base:base + 4] = np.finfo(k.F).max
            if case == 'nan_other_mass': mass[world, base + 1] = np.nan
            if case == 'inf_other_mass': mass[world, base + 1] = np.inf
            if case == 'negative_mass': mass[world, base], mass[world, base + 1] = -1, 1
            if case == 'nan_position': p[0, 0] = np.nan
            if case == 'inf_position': p[0, 1] = np.inf
            if case == 'nan_candidate': p[1, 2] = np.nan
            if case == 'inf_candidate': p[1, 0] = np.inf
            if case == 'nan_radius': radius[base] = np.nan
            if case == 'inf_radius': radius[base + 1] = np.inf
            if case == 'negative_radius': radius[base] = -1
            if case == 'subnormal_mass': mass[world, base:base + 4] = np.finfo(k.F).tiny / k.F(2)
            if case in ('zero_distance', 'coincident'):
                p[:] = 0
                if world < worlds: counts[world*per_world + i] = 3
            if case in ('threshold', 'above_threshold'):
                p[0], p[1] = (0, 0, 0), (1e-8, 0, 0)
                if case == 'above_threshold': p[1, 0] = np.nextafter(k.F(1e-8), k.F(np.inf))
            if world < worlds:
                if case == 'empty': counts[world*per_world + i] = 0
                if case == 'negative_count': counts[world*per_world + i] = -1
                if case == 'multiple': counts[world*per_world + i] = 3
    flat = x.reshape(-1, 3)
    f0 = rng.uniform(-1, 1, flat.shape).astype(k.F)
    h0 = rng.uniform(-1, 1, (len(flat), 9)).astype(k.F)
    f0[::2], h0[::2] = 0, 0
    args = [d.upload(flat), d.upload(ids), d.upload(radius), d.upload(counts), d.upload(slots), d.upload(mass)]
    sizes = [k.u64(count), k.u64(per_world), k.u64(size), k.ctypes.c_int32(3)]
    for stiffness, enabled in ((0.5, True), (0.5, False), (0, True), (-1, True), (np.inf, True), (np.nan, True)):
        accumulate(f'pp_k{stiffness}_records{int(enabled)}', '25accumulate_particle_pairs', 4, f0, h0,
                   lambda f, h, r, c: args + [k.f32(stiffness), f, h, r, c] + sizes, 3*count, enabled,
                   expect_change=bool(np.isfinite(stiffness) and stiffness != 0),
                   expect_contacts=bool(enabled and np.isfinite(stiffness)))

    # Launch one small block for 111 records to require several grid-stride iterations; counts cover -1 through 5.
    n = 111
    records = np.zeros(n, k.selfcollision.CONTACT_TANGENT)
    records['ids'] = np.arange(5*n, dtype=np.int32).reshape(n, 5)
    records['count'] = np.resize(np.arange(-1, 6, dtype=np.int32), n)
    records['w'] = rng.uniform(-2, 2, (n, 5))
    records['n'] = rng.uniform(-1, 1, (n, 3))
    records['k'] = rng.uniform(-2, 2, n)
    direction = rng.uniform(-2, 2, (5*n + 7, 3)).astype(k.F)
    initial = rng.uniform(-1, 1, direction.shape).astype(k.F)
    name, texts = modules('25multiply_contact_tangents')
    for used in (0, n):
        results = []
        for text in texts:
            result = d.upload(initial)
            d.launch(d.function(text, name), 16,
                     [d.upload(records), d.upload(np.array([used], np.uint32)), d.upload(direction), result], block=16)
            results.append(d.download(result, initial))
        out[f'tangent_grid_stride_{used}'] = k.compare('p', *results)
        out[f'tangent_guard_tail_{used}'] = k.compare('p', initial[-7:], results[1][-7:])
        out[f'tangent_coverage_{used}'] = {'bitwise_equal': bool(np.any(results[0] != initial)) if used else
                                         results[0].tobytes() == initial.tobytes()}
    return out
