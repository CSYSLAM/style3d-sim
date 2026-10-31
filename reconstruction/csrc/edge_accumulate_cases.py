"""Disjoint edge-contact fixtures for direct original/source GPU comparisons, including exceptional inputs."""
import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc.self_accumulate_cases import modules


def run(driver, rng):
    d, out = driver, {}

    def check(label, suffix, threads, args, f0, h0, capacity, enabled, expect_change=None):
        name, texts = modules(suffix)
        results = []
        for text in texts:
            f, h = d.upload(f0), d.upload(h0)
            empty = np.zeros(capacity + 5, k.selfcollision.CONTACT_TANGENT)
            records, counter = d.upload(empty), d.upload(np.zeros(1, np.uint32))
            params = args[:]
            params[output_index:output_index] = [f, h, records if enabled else k.null(),
                                                counter if enabled else k.null()]
            d.launch(d.function(text, name), threads + 19, params)
            used = int(d.download(counter, np.zeros(1, np.uint32))[0])
            if used > capacity:
                raise AssertionError('Contact record overflow')
            records = d.download(records, empty)
            results.append((d.download(f, f0), d.download(h, h0), np.sort(records[:used], order='ids'),
                            used, records[used:]))
        a, b = results
        out[label + '_force'] = k.compare('f', a[0], b[0])
        out[label + '_diagonal'] = k.compare('h', a[1], b[1])
        out[label + '_records'] = {'bitwise_equal': a[3] == b[3] and a[2].tobytes() == b[2].tobytes(),
                                   'contacts': a[3]}
        changed = bool(np.any(a[0] != f0) or np.any(a[1] != h0))
        out[label + '_coverage'] = {'bitwise_equal': bool((expect_change is None or changed == expect_change)
                                                         and (enabled or a[3] == 0)
                                                         and not np.any(a[4].view(np.uint8))
                                                         and not np.any(b[4].view(np.uint8))),
                                   'changed_particles': int(np.any(a[0] != f0, axis=1).sum()), 'contacts': a[3]}
        out[label + '_tail_force'] = k.compare('f', f0[tail:], b[0][tail:])
        out[label + '_tail_diagonal'] = k.compare('h', h0[tail:], b[1][tail:])

    cases = ('valid', 'minimum_distance', 'above_minimum', 'distance_boundary', 'below_boundary',
             'both_degenerate', 'first_degenerate', 'second_degenerate', 'parallel', 'endpoint',
             'shared_vertex', 'self_pair', 'adjacent_az', 'adjacent_aw', 'adjacent_bz', 'adjacent_bw',
             'adjacent_rejected', 'zero_mass', 'zero_other_mass', 'overflow_product', 'overflow_other_sum',
             'nan_position', 'inf_position', 'nan_candidate', 'inf_candidate', 'nan_mass', 'nan_other_mass',
             'inf_other_mass', 'empty', 'negative_count', 'multiple', 'subnormal_mass')
    per_world, worlds, count = 96, 3, 231
    size = 8*len(cases)
    x = np.zeros((worlds + 1, size, 3), k.F)
    edges = np.full((per_world, 4), -1, np.int32)
    mass = rng.uniform(0.2, 2, (worlds + 1, size)).astype(k.F)
    counts = np.zeros(worlds*per_world, np.int32)
    slots = np.full((worlds*per_world, 2), 0, np.int32)
    opposite_rows = [[] for _ in range(per_world)]
    for world in range(worlds + 1):
        for i, case in enumerate(cases):
            base, edge = 8*i, 3*i
            p = x[world, base:base + 8]
            p[:6] = ((-0.5, 0, 0), (0.5, 0, 0), (0, -0.5, 0.015625), (0, 0.5, 0.015625),
                     (0.0625, -0.5, -0.015625), (0.0625, 0.5, -0.015625))
            edges[edge:edge + 3, 2:] = np.arange(base, base + 6).reshape(3, 2)
            if case == 'minimum_distance': p[2:4, 2] = k.F(1e-6)
            if case == 'above_minimum': p[2:4, 2] = np.nextafter(k.F(1e-6), k.F(np.inf))
            if case == 'distance_boundary': p[2:4, 2] = k.F(0.03125)
            if case == 'below_boundary': p[2:4, 2] = np.nextafter(k.F(0.03125), k.F(0))
            if case in ('both_degenerate', 'first_degenerate'): p[1] = p[0]
            if case in ('both_degenerate', 'second_degenerate'): p[3] = p[2]
            if case == 'parallel': p[2:4] = p[:2] + np.array((0, 0, 0.015625), k.F)
            if case == 'endpoint': p[2:4, 0] = 1
            if case == 'shared_vertex': edges[edge + 1, 2] = base
            if case.startswith('adjacent'):
                p[:4, :2] *= k.F(0.02)
                p[2:4, 2] = k.F(0.008 if case != 'adjacent_rejected' else 0.015)
                row, vertex = ((edge, base + 2), (edge, base + 3), (edge + 1, base),
                               (edge + 1, base + 1), (edge, base + 2))[
                                   ('adjacent_az', 'adjacent_aw', 'adjacent_bz', 'adjacent_bw',
                                    'adjacent_rejected').index(case)]
                if world == 0: opposite_rows[row] = [base + 7, vertex]
            if case == 'zero_mass': mass[world, base:base + 2] = 0
            if case == 'zero_other_mass': mass[world, base + 2:base + 4] = 0
            if case == 'overflow_product': mass[world, base:base + 4] = k.F(1e25)
            if case == 'overflow_other_sum': mass[world, base + 2:base + 4] = np.finfo(k.F).max
            if case == 'nan_position': p[0, 0] = np.nan
            if case == 'inf_position': p[1, 1] = np.inf
            if case == 'nan_candidate': p[2, 2] = np.nan
            if case == 'inf_candidate': p[3, 0] = np.inf
            if case == 'nan_mass': mass[world, base] = np.nan
            if case == 'nan_other_mass': mass[world, base + 2] = np.nan
            if case == 'inf_other_mass': mass[world, base + 2] = np.inf
            if case == 'subnormal_mass': mass[world, base:base + 4] = np.finfo(k.F).tiny / k.F(2)
            if world < worlds:
                row = world*per_world + edge
                counts[row] = 0 if case == 'empty' else -1 if case == 'negative_count' else 2 if case == 'multiple' else 1
                slots[row] = (edge if case == 'self_pair' else edge + 1, edge + 2)
    offsets = np.concatenate(([0], np.cumsum([len(row) for row in opposite_rows]))).astype(np.int32)
    opposite = np.array([value for row in opposite_rows for value in row] or [0], np.int32)
    flat = x.reshape(-1, 3)
    f0 = rng.uniform(-1, 1, flat.shape).astype(k.F)
    h0 = rng.uniform(-1, 1, (len(flat), 9)).astype(k.F)
    f0[::2], h0[::2] = 0, 0
    args = [d.upload(flat), d.upload(edges), d.upload(offsets), d.upload(opposite), d.upload(counts),
            d.upload(slots), d.upload(mass)]
    output_index = 9
    tail = 2*size + 8*((count - 2*per_world)//3)
    for stiffness, thickness, enabled in ((0.5, 0.03125, True), (0.5, 0.03125, False), (0, 0.03125, True),
                                          (-1, 0.03125, True), (np.inf, 0.03125, True), (np.nan, 0.03125, True),
                                          (0.5, np.nan, True), (0.5, np.inf, True)):
        current = args + [k.f32(thickness), k.f32(stiffness)]
        current += [k.u64(count), k.u64(per_world), k.u64(size), k.ctypes.c_int32(2)]
        check(f'ee_k{stiffness}_r{thickness}_records{int(enabled)}', '20accumulate_edge_edge', count, current,
              f0, h0, 2*count, enabled, expect_change=stiffness != 0 if np.isfinite(stiffness) and
              np.isfinite(thickness) else None)

    cases = ('valid', 'one_opposite', 'empty_opposite', 'degenerate_opposite', 'cancelled_opposites',
             'same_side', 'endpoint_on_plane', 'outside_triangle', 'barycentric_boundary', 'below_barycentric',
             'zero_length', 'short_length', 'length_boundary', 'above_length', 'degenerate_triangle',
             'tiny_area', 'tiny_barycentric_denominator', 'nearly_parallel', 'nan_opposite', 'inf_opposite',
             'shared_vertex', 'zero_mass', 'zero_other_mass', 'overflow_product', 'nan_mass', 'nan_other_mass',
             'nan_position', 'inf_candidate', 'empty', 'negative_count', 'multiple', 'subnormal_mass')
    per_world, count = 32, 79
    size = 11*per_world
    x = np.zeros((worlds + 1, size, 3), k.F)
    edges = np.full((per_world, 4), -1, np.int32)
    triangles = np.zeros((2*per_world, 3), np.int32)
    mass = rng.uniform(0.2, 2, (worlds + 1, size)).astype(k.F)
    counts = np.ones(worlds*per_world, np.int32)
    slots = np.tile(np.arange(2*per_world, dtype=np.int32).reshape(-1, 2), (worlds, 1))
    opposite_rows = []
    for i, case in enumerate(cases):
        base = 11*i
        edges[i, 2:] = (base, base + 1)
        triangles[2*i:2*i + 2] = np.arange(base + 2, base + 8).reshape(2, 3)
        opposite_rows.append([] if case == 'empty_opposite' else [base + 8] if case == 'one_opposite' else
                             [base + 8, base + 9])
        if case == 'shared_vertex': triangles[2*i, 0] = base
        for world in range(worlds + 1):
            p = x[world, base:base + 11]
            p[:2] = ((0.25, 0.25, 0.015625), (0.25, 0.25, -0.015625))
            p[2:5] = ((0, 0, 0), (1, 0, 0), (0, 1, 0))
            p[5:8] = p[2:5] + np.array((0, 0, 0.00390625), k.F)
            p[8:10] = ((0.5, 0.25, 0), (0.25, 0.5, 0))
            if case == 'degenerate_opposite': p[8:10] = p[0]
            if case == 'cancelled_opposites': p[8:10] = ((0.5, 0.25, 0), (0, 0.25, 0))
            if case == 'same_side': p[1, 2] = p[0, 2]*2
            if case == 'endpoint_on_plane': p[1, 2] = 0
            if case == 'outside_triangle': p[:2, :2] = 2
            if case == 'barycentric_boundary': p[:2, 0] = k.F(0.01)
            if case == 'below_barycentric': p[:2, 0] = np.nextafter(k.F(0.01), k.F(0))
            if case == 'zero_length': p[1] = p[0]
            if case in ('short_length', 'length_boundary', 'above_length'):
                length = k.F(0.0005)
                if case == 'short_length': length = np.nextafter(length, k.F(0))
                if case == 'above_length': length = np.nextafter(length, k.F(np.inf))
                p[0, 2], p[1, 2] = length/k.F(2), -length/k.F(2)
            if case == 'degenerate_triangle': p[4] = p[3]
            if case == 'tiny_area': p[3, 0], p[4, 1] = k.F(1e-5), k.F(1e-5)
            if case == 'tiny_barycentric_denominator': p[3, 0], p[4, 1] = k.F(1e-4), k.F(1e-4)
            if case == 'nearly_parallel':
                p[:2] = ((-0.25, 0.25, 1e-8), (0.75, 0.25, -1e-8))
                p[8:10] = ((0.5, 0.5, 0.1), (0.25, 0.5, -0.1))
            if case == 'nan_opposite': p[8, 0] = np.nan
            if case == 'inf_opposite': p[9, 1] = np.inf
            if case == 'zero_mass': mass[world, base:base + 2] = 0
            if case == 'zero_other_mass': mass[world, base + 2:base + 5] = 0
            if case == 'overflow_product': mass[world, base:base + 5] = k.F(1e25)
            if case == 'nan_mass': mass[world, base] = np.nan
            if case == 'nan_other_mass': mass[world, base + 2] = np.nan
            if case == 'nan_position': p[0, 0] = np.nan
            if case == 'inf_candidate': p[3, 2] = np.inf
            if case == 'subnormal_mass': mass[world, base:base + 5] = np.finfo(k.F).tiny/k.F(2)
            if world < worlds:
                row = world*per_world + i
                if case == 'empty': counts[row] = 0
                if case == 'negative_count': counts[row] = -1
                if case == 'multiple': counts[row] = 2
    offsets = np.concatenate(([0], np.cumsum([len(row) for row in opposite_rows]))).astype(np.int32)
    opposite = np.array([value for row in opposite_rows for value in row], np.int32)
    flat = x.reshape(-1, 3)
    f0 = rng.uniform(-1, 1, flat.shape).astype(k.F)
    h0 = rng.uniform(-1, 1, (len(flat), 9)).astype(k.F)
    f0[::2], h0[::2] = 0, 0
    args = [d.upload(flat), d.upload(edges), d.upload(offsets), d.upload(opposite), d.upload(triangles),
            d.upload(counts), d.upload(slots), d.upload(mass)]
    output_index = 10
    tail = 2*size + 11*(count - 2*per_world)
    for stiffness, thickness, enabled in ((0.5, 0.03125, True), (0.5, 0.03125, False), (0, 0.03125, True),
                                          (-1, 0.03125, True), (np.inf, 0.03125, True), (np.nan, 0.03125, True),
                                          (0.5, np.nan, True), (0.5, np.inf, True)):
        current = args + [k.f32(thickness), k.f32(stiffness)]
        current += [k.u64(count), k.u64(per_world), k.u64(size), k.ctypes.c_int32(2)]
        check(f'ef_k{stiffness}_r{thickness}_records{int(enabled)}', '20accumulate_edge_face', count, current,
              f0, h0, 2*count, enabled, expect_change=stiffness != 0 if np.isfinite(stiffness) and
              np.isfinite(thickness) else None)
    return out
