"""Direct fluid GPU probes with deterministic hash lists and one active row per world."""
import hashlib
import struct

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc import ptx_compare as pc


def modules(suffix):
    if hashlib.sha256(k.LEGACY.read_bytes()).hexdigest() != k.LEGACY_SHA:
        raise RuntimeError('Unexpected original library')
    chosen, name = k.legacy_ptx('_ZN7synreal12fluid_kernel' + suffix)
    original = next(path.read_text() for path in sorted(pc.LEGACY_PTX.glob('*.ptx'))
                    if name in pc.entries(path.read_text()))
    return name, (original, chosen)


def run(driver, rng):
    d, out = driver, {}
    # No slot collisions: compare the entire hash head/next arrays byte-for-byte as well as all other fields.
    per_world, nf, nb, worlds, slots = 17, 7, 0, 3, 1024
    ids = np.array((14, 2, 11, 6, 0, 15, 8), np.int32)
    x = rng.uniform(-2, 2, (worlds*per_world + 5, 3)).astype(k.F)
    local_world = np.resize(np.array((-1, 0, 2), np.int32), per_world)
    mass = rng.uniform(0.1, 2, per_world).astype(k.F)
    occupied = set()
    for world in range(worlds):
        for particle in ids:
            while True:
                cell = rng.integers(-100, 100, 3).astype(np.int32)
                slot = int(k.fluid.hash_cells(cell[None], slots)[0])
                if slot not in occupied: break
            occupied.add(slot)
            x[world*per_world + particle] = (cell.astype(k.F) + k.F(0.25))*k.F(0.125)
    fields = (('positions', (worlds*nf + 5, 3), k.F), ('volumes', worlds*nf + 5, k.F),
              ('ids', worlds*nf + 5, np.int32), ('world', worlds*nf + 5, np.int32),
              ('cells', (worlds*nf + 5, 3), np.int32), ('head', slots, np.int32),
              ('next', worlds*nf + 5, np.int32))
    for replicated, table in ((False, True), (False, False), (True, True), (True, False)):
        model = k.fluid_model_bytes(d, per_world, ids, local_world, mass, np.zeros((nb, 3), k.F),
                                    np.zeros(nb, k.F), 1000, 0.125)
        struct.pack_into('<i', model, 28, worlds*per_world if replicated else per_world)
        if not table:
            struct.pack_into('<QQ', model, 120, 0, 0)
        count = worlds*nf if replicated else nf
        name, texts = modules('10build_grid')
        outputs = []
        for text in texts:
            initial = {label: np.full(shape, -1 if label in ('head', 'next') else 17, dtype)
                       for label, shape, dtype in fields}
            buffers = {label: d.upload(data) for label, data in initial.items()}
            params = [model, d.upload(x)] + [buffers[label] for label in
                      ('positions', 'volumes', 'ids', 'world', 'cells', 'head', 'next')]
            params += [k.ctypes.c_int32(count), k.ctypes.c_int32(slots)]
            d.launch(d.function(text, name), count + 17, params, block=128)
            outputs.append({label: d.download(buffers[label], data) for label, data in initial.items()})
        label = f'grid_replicated{int(replicated)}_table{int(table)}'
        for field in initial:
            out[label + '_' + field] = k.compare(field, outputs[0][field], outputs[1][field])
        expected_ids = np.concatenate([ids + world*per_world for world in range(worlds)]) if replicated else ids
        out[label + '_mapping'] = {'bitwise_equal': bool(np.array_equal(outputs[0]['ids'][:count], expected_ids)
                                                        and np.all(outputs[0]['next'][:count] == -1)),
                                   'unique_slots': count}
        scale = np.array((0.125, 0.5, 0.875), k.F)
        solution = rng.uniform(-2, 2, x.shape).astype(k.F)
        name, texts = modules('10scale_step')
        scaled = []
        n = worlds*per_world if replicated else per_world
        for text in texts:
            result = d.upload(solution)
            d.launch(d.function(text, name), n + 17,
                     [model, result, d.upload(scale), k.ctypes.c_int32(n)], block=128)
            scaled.append(d.download(result, solution))
        expected = solution.copy()
        world_ids = np.arange(n)//per_world if replicated else np.maximum(local_world[:n], 0) if table else np.zeros(n, int)
        expected[:n] *= scale[world_ids, None]
        out[label + '_scale'] = k.compare('x', *scaled)
        out[label + '_scale_mapping'] = k.compare('x', expected, scaled[0])

    # Boundary samples are shared in a single-copy model and acquire their replica's world in replicated models.
    for replicated in (False, True):
        boundary = x[ids[1:3]].copy()
        bvol = np.array((0.003, 0.005), k.F)
        model = k.fluid_model_bytes(d, per_world, ids[:1], local_world, mass, boundary, bvol, 1000, 0.125)
        struct.pack_into('<i', model, 28, worlds*per_world if replicated else per_world)
        n = 3*worlds if replicated else 3
        name, texts = modules('10build_grid')
        outputs = []
        for text in texts:
            initial = (np.full((n + 3, 3), 17, k.F), np.full(n + 3, 17, k.F), np.full(n + 3, 17, np.int32),
                       np.full(n + 3, 17, np.int32), np.full((n + 3, 3), 17, np.int32),
                       np.full(slots, -1, np.int32), np.full(n + 3, -1, np.int32))
            buffers = [d.upload(a) for a in initial]
            d.launch(d.function(text, name), n + 17,
                     [model, d.upload(x)] + buffers + [k.ctypes.c_int32(n), k.ctypes.c_int32(slots)], block=128)
            outputs.append(tuple(d.download(pointer, a) for pointer, a in zip(buffers, initial)))
        for field, a, b in zip(('positions', 'volumes', 'ids', 'world', 'cells', 'head', 'next'), *outputs):
            out[f'boundary_replicated{int(replicated)}_{field}'] = k.compare(field, a, b)
        expected_world = (np.repeat(np.arange(worlds), 3) if replicated else
                          np.array((max(int(local_world[ids[0]]), 0), -1, -1)))
        out[f'boundary_replicated{int(replicated)}_world_mapping'] = {
            'bitwise_equal': bool(np.array_equal(outputs[0][3][:n], expected_world))}

    # Fixed linked-list order removes the build_grid insertion race from density/force/product comparisons.
    nf, stride, worlds, count, slots = 70, 72, 3, 143, 512
    points = worlds*stride
    ids = np.arange(points, dtype=np.int32)
    ids[np.arange(points) % stride >= nf] = -1
    positions = rng.uniform(-0.03, 0.03, (worlds, stride, 3)).astype(k.F)
    for world in range(worlds): positions[world, :, 0] += k.F(4*world)
    positions = positions.reshape(-1, 3)
    world_ids = np.repeat(np.arange(worlds, dtype=np.int32), stride)
    world_ids[np.arange(points) % stride == nf] = -1
    volumes = rng.uniform(0.001, 0.004, points).astype(k.F)
    h = k.F(0.25)
    cells = np.floor(positions/h).astype(np.int32)
    head, next_ = np.full(slots, -1, np.int32), np.full(points, -1, np.int32)
    for point, slot in enumerate(k.fluid.hash_cells(cells, slots)):
        next_[point], head[slot] = head[slot], point
    grid = [d.upload(a) for a in (head, next_, ids, world_ids, cells, positions, volumes)]
    p = k.fluid.Params(h, 1000, 0.3, 1/240, nf, stride, count, slots)
    active = np.array((0, nf, 2*nf))
    evaluated = None
    for viscosity in (0.3, 0, -1, np.nan, 'empty'):
        empty_grid = viscosity == 'empty'
        p.mu = k.F(0.3 if empty_grid else viscosity)
        name, texts = modules('13evaluate_rows')
        result = []
        initial = (np.full((count + 5, 3), 17, k.F), np.full(count + 5, 17, k.F),
                   np.full(count + 5, 17, k.F), np.full(count + 5, 17, np.int32),
                   np.full((count + 5, 64), -7, np.int32), np.full((count + 5, 64, 4), 17, k.F))
        for text in texts:
            buffers = [d.upload(data) for data in initial]
            evaluation_grid = ([d.upload(np.full(slots, -1, np.int32))] + grid[1:]) if empty_grid else grid
            view = k.fluid_view_bytes(evaluation_grid + [k.null(), k.null(), k.null()], p)
            d.launch(d.function(text, name), count + 17, [view] + buffers, block=128)
            result.append(tuple(d.download(pointer, data) for pointer, data in zip(buffers, initial)))
        for field, a, b in zip(('gradient', 'residual', 'weight', 'counts', 'neighbours', 'cache'), *result):
            out[f'evaluate_mu{viscosity}_{field}'] = k.compare(field, a, b)
        covered = ((result[0][3][:count] > 64).any() and (result[0][2][:count] > 0).any())
        if empty_grid:
            covered = all(not np.any(a[:count]) for a in result[0][:4])
            covered = covered and all(a.tobytes() == b.tobytes() for a, b in zip(result[0][4:], initial[4:]))
        out[f'evaluate_mu{viscosity}_coverage'] = {'bitwise_equal': bool(covered)}
        if viscosity == 0.3: evaluated = result[0]
    gradients, residual, weight, found, neighbours, cache = evaluated
    initial_f = rng.uniform(-1, 1, (points + 5, 3)).astype(k.F)
    initial_h = rng.uniform(1, 2, (points + 5, 9)).astype(k.F)
    previous = (positions + rng.uniform(-0.001, 0.001, positions.shape)).astype(k.F)
    direction = rng.uniform(-1, 1, initial_f.shape).astype(k.F)
    initial_t = rng.uniform(-1, 1, initial_f.shape).astype(k.F)
    p.mu = k.F(0.3)
    for n, exceptional in ((0, None), (-1, None), (1, None), (3, None), (4, None), (63, None), (64, None),
                            (65, None), (70, None), (1, -1), (1, np.nan), (65, 'empty')):
        local_counts = np.zeros_like(found)
        local_counts[active] = n
        local_gradient = np.zeros_like(gradients)
        local_gradient[active] = gradients[active]
        local_weight = np.zeros_like(weight)
        local_weight[active] = weight[active]
        local_cache = cache.copy()
        empty_grid = exceptional == 'empty'
        if exceptional is not None and not empty_grid: local_cache[active, 0, 3] = exceptional
        current_grid = ([d.upload(np.full(slots, -1, np.int32))] + grid[1:]) if empty_grid else grid
        view = k.fluid_view_bytes(current_grid + [d.upload(local_counts), d.upload(neighbours), d.upload(local_cache)], p)
        label = f'rows_count{n}_nu{exceptional}'
        name, texts = modules('15accumulate_rows')
        result = []
        for text in texts:
            force, diagonal = d.upload(initial_f), d.upload(initial_h)
            params = [view, d.upload(local_gradient), d.upload(residual), d.upload(local_weight), d.upload(previous),
                      force, diagonal]
            d.launch(d.function(text, name), count + 17, params, block=128)
            result.append((d.download(force, initial_f), d.download(diagonal, initial_h)))
        out[label + '_force'] = k.compare('f', result[0][0], result[1][0])
        out[label + '_diagonal'] = k.compare('h', result[0][1], result[1][1])
        out[label + '_coverage'] = {'bitwise_equal': bool(np.any(result[0][0] != initial_f))}
        name, texts = modules('13multiply_rows')
        result = []
        for text in texts:
            product = d.upload(initial_t)
            d.launch(d.function(text, name), count + 17,
                     [view, d.upload(local_gradient), d.upload(local_weight), d.upload(direction), product], block=128)
            result.append(d.download(product, initial_t))
        out[label + '_product'] = k.compare('t', *result)
        out[label + '_tail'] = k.compare('t', initial_t[points:], result[1][points:])
    return out
