"""Original/source grain probes: disjoint bonds, replicated grids, exact hash lists and approximate-normal contacts."""
import hashlib
import struct

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc import ptx_compare as pc


def modules(suffix):
    if hashlib.sha256(k.LEGACY.read_bytes()).hexdigest() != k.LEGACY_SHA:
        raise RuntimeError('Unexpected original library')
    chosen, name = k.legacy_ptx('_ZN7synreal15granular_kernel' + suffix)
    original = next(path.read_text() for path in sorted(pc.LEGACY_PTX.glob('*.ptx'))
                    if name in pc.entries(path.read_text()))
    return name, (original, chosen)


def run(d, rng):
    out = {}

    def probe(label, suffix, count, params, outputs):
        name, texts = modules(suffix)
        results = []
        for text in texts:
            args = params.copy()
            buffers = {index: d.upload(initial) for index, (_, initial) in outputs.items()}
            for index, pointer in buffers.items(): args[index] = pointer
            d.launch(d.function(text, name), count + 17, args, block=128)
            results.append({field: d.download(buffers[index], initial)
                            for index, (field, initial) in outputs.items()})
        for field in results[0]: out[label + '_' + field] = k.compare(field, results[0][field], results[1][field])
        return results[0]

    material = k.granular.Material(0.3, 0.03, 0.4, 0.1, 50, 0.002, 1, 4)
    per_world, grains, worlds, slots = 17, 7, 3, 1024
    indices = np.array((14, 2, 11, 6, 0, 15, 8), np.int32)
    positions = rng.uniform(-1, 1, (per_world*worlds + 5, 3)).astype(k.F)
    occupied = set()
    for world in range(worlds):
        for particle in indices:
            while True:
                cell = rng.integers(-100, 100, 3).astype(np.int32)
                slot = int(k.fluid.hash_cells(cell[None], slots)[0])
                if slot not in occupied: break
            occupied.add(slot)
            positions[world*per_world + particle] = (cell.astype(k.F) + k.F(0.25))*k.F(0.125)
    previous = (positions + rng.uniform(-0.01, 0.01, positions.shape)).astype(k.F)
    world_ids = np.resize(np.array((-1, 0, 2), np.int32), per_world)
    radius = rng.uniform(0.01, 0.03, per_world).astype(k.F)
    for replicated, table in ((False, True), (False, False), (True, True), (True, False)):
        count = grains*worlds if replicated else grains
        model = k.granular_model_bytes(d, per_world, indices, world_ids, radius, material)
        struct.pack_into('<i', model, 28, per_world*worlds if replicated else per_world)
        if not table: struct.pack_into('<QQ', model, 120, 0, 0)
        p = k.granular.Params(count, slots, 0.125, 2000, 0.5, 20, 1/240)
        view = k.granular_view_bytes([k.null()]*11, p)
        outputs = {4: ('positions', np.full((count + 5, 3), 17, k.F)),
                   5: ('previous', np.full((count + 5, 3), 17, k.F)),
                   6: ('radius', np.full(count + 5, 17, k.F)), 7: ('ids', np.full(count + 5, 17, np.int32)),
                   8: ('world', np.full(count + 5, 17, np.int32)),
                   9: ('cells', np.full((count + 5, 3), 17, np.int32)),
                   10: ('head', np.full(slots, -1, np.int32)), 11: ('next', np.full(count + 5, -1, np.int32))}
        result = probe(f'grid_replica{replicated}_table{table}', '10build_grid', count,
                       [model, d.upload(positions), d.upload(previous), view] + [k.null()]*8, outputs)
        expected = np.concatenate([indices + w*per_world for w in range(worlds)]) if replicated else indices
        out[f'grid_replica{replicated}_table{table}_mapping'] = {
            'bitwise_equal': bool(np.array_equal(result['ids'][:count], expected)
                                  and np.all(result['next'][:count] == -1))}

    # Each bond owns two particles, so force/diagonal atomics cannot race with another bond.
    nb, count = 64, 61
    pairs = rng.permutation(2*nb).astype(np.int32).reshape(nb, 2)
    x = rng.uniform(-0.1, 0.1, (2*nb + 5, 3)).astype(k.F)
    old = x.copy()
    rest, history = np.ones(nb, k.F), np.ones(nb, k.F)
    active = np.ones(nb, np.int32)
    lengths = (1, 1.2, 0.5, 0.8, 1, 0, 1e-8, np.nextafter(k.F(1e-8), k.F(np.inf)),
               1.1, np.nextafter(k.F(1.1), k.F(np.inf)), 0.9, 0.9, np.nan, np.inf, 0.9, 0.9)
    for i, (a, b) in enumerate(pairs):
        x[b], x[a] = (0, 0, 0), (lengths[i % 16], 0, 0)
        old[b], old[a] = (0, 0, 0), (0.9, 0, 0)
        if i % 16 == 0: active[i] = 0
        if i % 16 == 10: rest[i] = np.nan
        if i % 16 == 11: history[i] = np.nan
        if i % 16 == 14: rest[i] = np.inf
        if i % 16 == 15: history[i] = np.inf
    force = rng.uniform(-1, 1, x.shape).astype(k.F)
    diagonal = rng.uniform(-1, 1, (len(x), 9)).astype(k.F)
    for damping, dt, stiffness in ((0.3, 1/240, 200), (0, 1/240, 200), (-1, 1/240, 200),
                                    (np.nan, 1/240, 200), (0.3, 0, 200), (0.3, 1/240, 0), (0.3, 1/240, -1)):
        current = k.granular.Material(damping, 0.03, 0.4, 0.1, 50, 0.002, 1, 4)
        model = k.granular_model_bytes(d, len(x), np.arange(len(x), dtype=np.int32),
                                       np.zeros(len(x), np.int32), np.full(len(x), 0.01, k.F), current)
        args = [model, d.upload(x), d.upload(old), k.f32(dt), d.upload(pairs), d.upload(rest), d.upload(history),
                d.upload(active), k.ctypes.c_int32(count), k.f32(stiffness), k.null(), k.null(), k.null()]
        probe(f'bonds_d{damping}_dt{dt}_k{stiffness}', '16accumulate_bonds', count, args,
              {10: ('force', force), 11: ('diagonal', diagonal), 12: ('tangent', np.full((nb, 9), 17, k.F))})
        probe(f'commit_d{damping}_dt{dt}_k{stiffness}', '12commit_bonds', count,
              [model, d.upload(x), d.upload(pairs), d.upload(rest), k.null(), k.null(), k.ctypes.c_int32(count)],
              {4: ('history', history), 5: ('active', active)})

    grains, slots = 120, 512
    ids = rng.permutation(grains).astype(np.int32)
    positions = rng.uniform(-0.01, 0.01, (grains, 3)).astype(k.F)
    previous = (positions + rng.uniform(-0.001, 0.001, positions.shape)).astype(k.F)
    positions[:4] = ((0, 0, 0), (0, 0, 0), (0, 0, 0), (1e-8, 0, 0))
    previous[:4] = ((0.001, -0.002, 0.003), (0, 0, 0), (0, 0, 0), (0, 0, 0))
    positions[8:10] = ((0.01, 0, 0), (-0.01, 0, 0))
    previous[8:10] = positions[8:10]
    positions[-1] = (1, 1, 1)
    radius = np.full(grains, 0.02, k.F)
    world_ids = np.repeat(np.arange(3, dtype=np.int32), 40)
    world_ids[39] = -1
    cells = np.floor(positions/k.F(0.125)).astype(np.int32)
    head, next_ = np.full(slots, -1, np.int32), np.full(grains, -1, np.int32)
    for i, slot in enumerate(k.fluid.hash_cells(cells, slots)): next_[i], head[slot] = head[slot], i
    grid = [d.upload(a) for a in (head, next_, ids, world_ids, cells, positions, previous, radius)]
    p = k.granular.Params(grains, slots, 0.125, 2000, 0.5, 20, 1/240)
    force = rng.uniform(-1, 1, (grains + 5, 3)).astype(k.F)
    diagonal = rng.uniform(-1, 1, (grains + 5, 9)).astype(k.F)
    direction = rng.uniform(-1, 1, force.shape).astype(k.F)
    for mu, damping, dt, empty in ((0.5, 20, 1/240, False), (0, 20, 1/240, False),
                                   (-1, 20, 1/240, False), (np.nan, 20, 1/240, False), (0.5, 20, 0, False),
                                   (0.5, -1, 1/240, False), (0.5, 20, 1/240, True)):
        p.mu, p.cd, p.dt = k.F(mu), k.F(damping), k.F(dt)
        current_grid = [d.upload(np.full(slots, -1, np.int32))] + grid[1:] if empty else grid
        view = k.granular_view_bytes(current_grid + [k.null()]*3, p)
        label = f'contacts_mu{mu}_d{damping}_dt{dt}_empty{empty}'
        result = probe(label, '19accumulate_contacts', grains,
                       [view] + [k.null()]*5,
                       {1: ('force', force), 2: ('diagonal', diagonal),
                        3: ('counts', np.full(grains + 5, 17, np.int32)),
                        4: ('neighbours', np.full((32, grains), -7, np.int32)),
                        5: ('cache', np.full((32, grains, 4), 17, k.F))})
        for limit in (0, -1, 1, 3, 4, 31, 32, 33):
            counts = result['counts'][:grains].copy()
            counts = np.minimum(counts, limit) if limit < 33 else counts
            view = k.granular_view_bytes(current_grid + [d.upload(counts), d.upload(result['neighbours']),
                                                        d.upload(result['cache'])], p)
            probe(label + f'_count{limit}', '17multiply_contacts', grains,
                  [view, d.upload(direction), k.null()], {2: ('product', force)})

    offsets = np.zeros(grains + 1, np.int32)
    columns = np.array([j for j in range(1, 40) if j not in (8, 9)], np.int32)
    offsets[1:] = len(columns)
    for capacity in (0, 1, 3, 4, 5):
        material.max_dynamic = capacity
        model = k.granular_model_bytes(d, grains, ids, world_ids, radius, material)
        p.mu, p.cd, p.dt = k.F(0.5), k.F(20), k.F(1/240)
        view = k.granular_view_bytes(grid + [k.null()]*3, p)
        size = max(capacity, 1)*grains + 5
        partner = np.full(size, -1, np.int32)
        active = np.zeros(size, np.int32)
        if capacity:
            partner[0] = 8
            partner[capacity] = grains - 1
            partner[2*capacity], active[2*capacity] = 8, 1
        probe(f'formation_capacity{capacity}', '10form_bonds', grains,
              [model, view, d.upload(offsets), d.upload(columns)] + [k.null()]*5,
              {4: ('partner', partner), 5: ('bonds', np.full((size, 2), -7, np.int32)),
               6: ('rest', np.full(size, 17, k.F)), 7: ('history', np.full(size, 17, k.F)), 8: ('active', active)})
    return out
