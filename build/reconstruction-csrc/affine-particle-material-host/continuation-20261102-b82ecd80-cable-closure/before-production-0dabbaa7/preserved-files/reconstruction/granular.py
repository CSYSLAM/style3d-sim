"""Granular grains of the legacy library (synreal::Granular + granular_kernel), transcribed from the sm_52 PTX.

Per substep (nsys trace, 128 threads per block):

    Newton iteration: initialize_rhs -> memset(head = -1, D = 0) -> build_grid(x, x_previous) -> accumulate_contacts
        -> accumulate_bonds(initial, cohesion) -> accumulate_bonds(dynamic, adhesion) -> soft contact ...
        -> contact block -> add_diagonal(D into B) -> invert; PCG: memset T -> multiply_contacts -> multiply_bonds x2
    after the last iteration: commit_bonds(initial, dynamic) on the result -> build_grid(result) -> form_bonds
        -> update_velocity

Grains are hashed exactly like the fluid (fluid.py) with cell size 2 max(radius) + gap (gap only with adhesion) and
2 next_pow2(count) slots (Granular::initialize). Contacts are row-owned (each grain sums its own pairs, no atomics);
bonds use red.global.add. Arithmetic is float32 as in the SASS of the driver JIT; ptxas contractions are written out
explicitly (tangent fma(-dn, n, rel), contact force fma(k pen, n, -(eta t)), bond damping fma(l - l_ref, -d, f)).

Not reproducible bit for bit: the hash-list insertion order and the bond atomics vary run to run on the GPU (see
fluid.py for the emulated order), and the contact normal of two grains closer than 1e-8 with a nonzero relative
displacement uses rsqrt.approx (MUFU.RSQ), emulated here with a correctly rounded 1/sqrt.
"""
import numpy as np

from .fluid import _Atomics, _slot_lists, hash_cells, slot_count
from .numerics import F, fma

TINY = F(1e-8)
TINY2 = F(1e-16)
CONTACT_SLOTS = 32


class Grid:
    def __init__(self, ids, world, positions, previous, radius, cells, head, next_):
        self.ids, self.world, self.positions, self.previous = ids, world, positions, previous
        self.radius, self.cells, self.head, self.next = radius, cells, head, next_


class Params:
    """granular_kernel::View scalars: count, slots, cell size, contact stiffness, friction, friction damping, dt."""
    def __init__(self, count, slots, cell, stiffness, friction, friction_damping, dt):
        self.count, self.slots = count, slots
        self.cell, self.k, self.mu, self.cd, self.dt = F(cell), F(stiffness), F(friction), F(friction_damping), F(dt)


class Material:
    """Model fields read by the bond kernels (Model+312..+340)."""
    def __init__(self, bond_damping, yield_strain, max_compaction, break_strain, adhesion, formation_gap,
                 formation_speed, max_dynamic_bonds):
        self.damping, self.yield_strain = F(bond_damping), F(yield_strain)
        self.compaction, self.break_strain = F(max_compaction), F(break_strain)
        self.adhesion, self.gap, self.speed = F(adhesion), F(formation_gap), F(formation_speed)
        self.max_dynamic = int(max_dynamic_bonds)


def cell_size(radius, indices, adhesion, gap):
    """Granular::initialize: 2 max(radius) (+ formation gap when adhesion is enabled), in float32."""
    rmax = F(0)
    for r in radius[indices]:
        rmax = max(rmax, F(r))
    size = F(rmax+rmax)
    return F(size+(F(gap) if adhesion > 0 else F(0)))


def build_grid(x, previous, indices, particle_world, radius, p, insertion=None):
    ids = np.asarray(indices, np.int32)
    if particle_world is not None and len(particle_world):
        world = np.maximum(particle_world[ids], 0).astype(np.int32)
    else:
        world = np.zeros(len(ids), np.int32)
    positions = x[ids].astype(F)
    cells = np.floor((positions/p.cell).astype(F)).astype(np.int32)
    slot = hash_cells(cells, p.slots)
    head = np.full(p.slots, -1, np.int32)
    next_ = np.full(len(ids), -1, np.int32)
    for i in (np.arange(len(ids)) if insertion is None else insertion):
        next_[i] = head[slot[i]]
        head[slot[i]] = i
    return Grid(ids, world, positions, previous[ids].astype(F), radius[ids].astype(F), cells, head, next_)


def candidates(grid, rows, slots):
    """Traversal order of the 27 cells; same cell coordinates and the same world (no world -1 here)."""
    k = np.arange(27)
    offsets = np.stack((k % 3, (k//3) % 3, k//9), axis=1)-1
    target = grid.cells[rows][:, None, :]+offsets[None]
    start, items = _slot_lists(grid.head, grid.next)
    slot = hash_cells(target, slots)
    length = (start[slot+1]-start[slot]).reshape(-1)
    pair = np.repeat(np.arange(len(length)), length)
    first = np.repeat(start[slot].reshape(-1), length)
    within = np.arange(len(pair))-np.repeat(np.cumsum(length)-length, length)
    j = items[first+within]
    row = pair//27
    keep = np.all(grid.cells[j] == target.reshape(-1, 3)[pair], axis=1) & (grid.world[j] == grid.world[rows][row])
    return row[keep], j[keep]


def _columns(row, n_rows):
    counts = np.bincount(row, minlength=n_rows)
    column = np.arange(len(row))-np.repeat(np.cumsum(counts)-counts, counts)
    return column, int(counts.max()) if len(counts) else 0


def _axis_normal(i, j):
    """Coincident grains without relative motion: +-1 on axis (min + max) % 3, positive when i < j."""
    sign = np.where(i < j, F(1), F(-1)).astype(F)
    axis = (np.minimum(i, j)+np.maximum(i, j)) % 3
    n = np.zeros((len(i), 3), F)
    n[np.arange(len(i)), np.where(axis == 1, 1, np.where(axis == 2, 2, 0))] = sign
    return n


def _dot(a, b):
    return fma(a[:, 2], b[:, 2], fma(a[:, 0], b[:, 0], a[:, 1]*b[:, 1]))


def contacts(grid, p, i, j):
    """Overlapping pairs among candidates: returns (keep mask, normal, eta) for the kept pairs."""
    d = (grid.positions[i]-grid.positions[j]).astype(F)
    reach = (grid.radius[i]+grid.radius[j]).astype(F)
    r2 = _dot(d, d)
    keep = (j != i) & ~(r2 >= reach*reach)
    d, reach, r2, i, j = d[keep], reach[keep], r2[keep], i[keep], j[keep]
    v = (grid.previous[i]-grid.previous[j]).astype(F)
    dist = np.sqrt(r2).astype(F)
    n = np.empty_like(d)
    far = dist > TINY
    n[far] = (d[far]/dist[far, None]).astype(F)
    v2 = _dot(v, v)
    moving = ~far & (v2 > TINY2)
    n[moving] = (v[moving]*(F(1)/np.sqrt(v2[moving]))[:, None]).astype(F)  # rsqrt.approx on the GPU
    rest = ~far & ~moving
    n[rest] = _axis_normal(i[rest], j[rest])
    rel = (d-v).astype(F)
    dn = _dot(rel, n)
    t = fma(-dn[:, None], n, rel)
    fn = p.k*(reach-dist)
    limit = p.mu*fn
    tl = np.sqrt(_dot(t, t)).astype(F)
    eta = np.minimum(p.cd/p.dt, limit/np.maximum(tl, TINY)).astype(F)
    force = fma(fn[:, None], n, -(t*eta[:, None]))
    return keep, n, eta, force


def _contact_block(p, n, eta):
    om = (p.k-eta).astype(F)
    n0, n1, n2 = n[:, 0], n[:, 1], n[:, 2]
    zero = F(0)
    d0, d1, d2 = (fma(om, c*c, eta) for c in (n0, n1, n2))
    o10, o20, o21 = (fma(eta, zero, om*(a*b)) for a, b in ((n1, n0), (n2, n0), (n2, n1)))
    return np.stack((d0, o10, o20, o10, d1, o21, o20, o21, d2), axis=1).astype(F)


def accumulate_contacts(grid, p, force, diagonal):
    """rhs[ids] += sum of contact forces, D[ids] = sum of contact blocks; returns (count, cache_ids, cache)."""
    g = p.count
    rows = np.arange(g)
    r, j = candidates(grid, rows, p.slots)
    keep, n, eta, f = contacts(grid, p, r, j)
    r, j = r[keep], j[keep]
    block = _contact_block(p, n, eta)
    column, width = _columns(r, g)
    acc_f = np.zeros((g, 3), F)
    acc_d = np.zeros((g, 9), F)
    for c in range(width):
        m = column == c
        acc_f[r[m]] = acc_f[r[m]]+f[m]
        acc_d[r[m]] = acc_d[r[m]]+block[m]
    count = np.bincount(r, minlength=g).astype(np.int32)
    cache_ids = np.zeros((CONTACT_SLOTS, g), np.int32)  # slot-major: [slot * count + grain]
    cache = np.zeros((CONTACT_SLOTS, g, 4), F)
    store = column < CONTACT_SLOTS
    cache_ids[column[store], r[store]] = j[store]
    cache[column[store], r[store], :3] = n[store]
    cache[column[store], r[store], 3] = eta[store]
    a = grid.ids
    force[a] = (acc_f+force[a]).astype(F)
    diagonal[a] = acc_d
    return count, cache_ids, cache


def multiply_contacts(grid, p, count, cache_ids, cache, direction, product):
    g = p.count
    rows = np.arange(g)
    a = grid.ids
    pa = direction[a]
    acc = np.zeros((g, 3), F)
    cached = count <= CONTACT_SLOTS
    for m in range(int(count[cached].max()) if cached.any() else 0):
        sel = cached & (count > m)
        rs = rows[sel]
        c4 = cache[m, rs]
        dp = (pa[rs]-direction[a[cache_ids[m, rs]]]).astype(F)
        om = (p.k-c4[:, 3]).astype(F)
        s = (om*_dot(c4[:, :3], dp)).astype(F)
        y = fma(c4[:, 3:4], dp, c4[:, :3]*s[:, None])
        acc[rs] = acc[rs]+y
    fallback = rows[~cached]
    if len(fallback):
        r, j = candidates(grid, fallback, p.slots)
        rr = fallback[r]
        keep, n, eta, _ = contacts(grid, p, rr, j)
        rr, j = rr[keep], j[keep]
        dp = (pa[rr]-direction[a[j]]).astype(F)
        s = ((p.k-eta)*_dot(dp, n)).astype(F)
        y = fma(eta[:, None], dp, s[:, None]*n)
        column, width = _columns(np.searchsorted(fallback, rr), len(fallback))
        for c in range(width):
            m = column == c
            acc[rr[m]] = acc[rr[m]]+y[m]
    product[a] = (acc+product[a]).astype(F)


def effective_length(material, l, rest, history):
    """max(L0 (1 - c), min(Lh, fma(L0, yield, l)))."""
    floor = (rest*(F(1)-material.compaction)).astype(F)
    return np.maximum(floor, np.minimum(history, fma(rest, material.yield_strain, l))).astype(F), floor


def accumulate_bonds(material, x, previous, dt, bonds, rest, history, active, stiffness, force, diagonal):
    """Returns the per-bond 3x3 tangent B (zero for inactive or broken bonds); force/diagonal updated in place."""
    nb = len(bonds)
    tangent = np.zeros((nb, 9), F)
    idx = np.flatnonzero(active != 0)
    a, b = bonds[idx, 0], bonds[idx, 1]
    d = (x[a]-x[b]).astype(F)
    l = np.sqrt(_dot(d, d)).astype(F)
    intact = ~(l > history[idx]*(material.break_strain+F(1)))
    idx, a, b, d, l = idx[intact], a[intact], b[intact], d[intact], l[intact]
    n = np.empty_like(d)
    far = l > TINY
    n[far] = (d[far]/l[far, None]).astype(F)
    n[~far] = _axis_normal(a[~far], b[~far])
    k = F(stiffness)
    leff, floor = effective_length(material, l, rest[idx], history[idx])
    stretch = (l-leff).astype(F)
    f = -(stretch*k)
    ds = material.damping/F(dt)
    if ds > 0:
        dr = (previous[a]-previous[b]).astype(F)
        lref = np.sqrt(_dot(dr, dr)).astype(F)
        f = fma((l-lref).astype(F), -ds, f)
    plastic = (leff > floor) & (leff < history[idx])
    ka = np.where(plastic, F(0), k).astype(F)
    kt = ((np.maximum(stretch, F(0))*k)/np.maximum(l, TINY)).astype(F)
    w = ((ds+ka)-kt).astype(F)
    n0, n1, n2 = n[:, 0], n[:, 1], n[:, 2]
    zero = F(0)
    d0, d1, d2 = (fma(w, c*c, kt) for c in (n0, n1, n2))
    o10, o20, o21 = (fma(kt, zero, w*(p*q)) for p, q in ((n1, n0), (n2, n0), (n2, n1)))
    block = np.stack((d0, o10, o20, o10, d1, o21, o20, o21, d2), axis=1).astype(F)
    tangent[idx] = block
    fa = (n*f[:, None]).astype(F)
    force_ops, diag_ops = _Atomics(), _Atomics()
    force_ops.add(idx, 0, a, fa)
    force_ops.add(idx, 1, b, -fa)
    diag_ops.add(idx, 2, a, block)
    diag_ops.add(idx, 3, b, block)
    force_ops.apply(force)
    diag_ops.apply(diagonal)
    return tangent


def multiply_bonds(bonds, active, tangent, direction, product):
    idx = np.flatnonzero(active != 0)
    a, b = bonds[idx, 0], bonds[idx, 1]
    dp = (direction[a]-direction[b]).astype(F)
    m = tangent[idx]
    z = np.stack([fma(dp[:, 2], m[:, 6+c], fma(dp[:, 0], m[:, c], dp[:, 1]*m[:, 3+c])) for c in range(3)], axis=1)
    ops = _Atomics()
    ops.add(idx, 0, a, z)
    ops.add(idx, 1, b, -z)
    ops.apply(product)


def commit_bonds(material, x, bonds, rest, history, active):
    """Break (active = 0) or commit the plastic history length, in place."""
    idx = np.flatnonzero(active != 0)
    a, b = bonds[idx, 0], bonds[idx, 1]
    d = (x[a]-x[b]).astype(F)
    l = np.sqrt(_dot(d, d)).astype(F)
    broken = l > history[idx]*(material.break_strain+F(1))
    active[idx[broken]] = 0
    keep = idx[~broken]
    history[keep] = effective_length(material, l[~broken], rest[keep], history[keep])[0]


def initial_adjacency(bonds_grid, count):
    """Host CSR of the initial bonds in grid indices: each bond once, in the row of its lower end, sorted."""
    lo, hi = np.minimum(bonds_grid[:, 0], bonds_grid[:, 1]), np.maximum(bonds_grid[:, 0], bonds_grid[:, 1])
    order = np.lexsort((hi, lo))
    offsets = np.concatenate(([0], np.cumsum(np.bincount(lo, minlength=count)))).astype(np.int32)
    return offsets, hi[order].astype(np.int32)


def form_bonds(grid, p, material, offsets, columns, partner, bonds, rest, history, active):
    """Release separated broken slots, then fill free slots with the nearest eligible neighbour (in place)."""
    m = material.max_dynamic
    if m == 0:
        return
    g = p.count
    pos, rad = grid.positions, grid.radius

    def reach(i, j):
        return F(F(rad[i]+rad[j])+material.gap)

    def dist2(i, j):
        d = (pos[i]-pos[j]).astype(F)[None]
        return _dot(d, d)[0]

    rows = np.arange(g)
    r_all, j_all = candidates(grid, rows, p.slots)
    speed2 = (p.dt*material.speed)*(p.dt*material.speed)
    for i in range(g):
        slots = np.arange(m*i, m*i+m)
        for s in slots:
            q = partner[s]
            if q >= 0 and active[s] == 0:
                rr = reach(i, q)
                if dist2(i, q) > rr*rr:
                    partner[s] = -1
        order = j_all[r_all == i]
        for s in slots:
            if partner[s] > -1:
                continue
            best, best_d2 = -1, F(np.inf)
            for j in order:
                if j <= i:
                    continue
                lo, hi = offsets[i], offsets[i+1]
                k = lo+np.searchsorted(columns[lo:hi], j)
                if k < hi and columns[k] == j:
                    continue
                d = (pos[i]-pos[j]).astype(F)[None]
                d2 = _dot(d, d)[0]
                rr = reach(i, j)
                if d2 <= TINY2 or d2 > rr*rr:
                    continue
                rel = (d-(grid.previous[i]-grid.previous[j]).astype(F)[None]).astype(F)
                if _dot(rel, rel)[0] > speed2:
                    continue
                if np.any(partner[slots] == j):
                    continue
                if d2 < best_d2 or (d2 == best_d2 and j < best):
                    best, best_d2 = j, d2
            if best < 0:
                break  # the PTX returns: later free slots of this grain stay empty
            partner[s] = best
            bonds[s] = (grid.ids[i], grid.ids[best])
            length = np.sqrt(best_d2).astype(F)
            rest[s] = length
            history[s] = length
            active[s] = 1


class GranularState:
    """Host side of synreal::Granular for one solver: material, initial and dynamic bond buffers and their history,
    which persists across substeps (commit/form after every accepted substep)."""
    def __init__(self, model, mass):
        def value(name):
            return getattr(model, 'synreal_granular_'+name)
        self.indices = value('particle_indices').numpy().astype(np.int32)
        self.radius = model.particle_radius.numpy().astype(F)
        world = getattr(model, 'particle_world', None)
        self.world = world.numpy().astype(np.int32) if world is not None else None
        self.material = Material(value('bond_damping'), value('yield_strain'), value('max_compaction'),
                                 value('break_strain'), value('adhesion'), value('bond_formation_gap'),
                                 value('bond_formation_speed'), value('max_dynamic_bonds'))
        self.stiffness, self.friction = F(value('contact_stiffness')), F(value('friction'))
        self.friction_damping, self.cohesion = F(value('friction_damping')), F(value('cohesion'))
        count = len(self.indices)
        self.cell = cell_size(self.radius, self.indices, self.material.adhesion, self.material.gap)
        self.slots = slot_count(count)
        self.bonds = value('bond_indices').numpy().astype(np.int32).reshape(-1, 2)
        self.rest = value('bond_rest_lengths').numpy().astype(F)
        self.history = self.rest.copy()
        self.active = np.ones(len(self.bonds), np.int32)
        grid_index = np.full(len(mass), -1, np.int64)
        grid_index[self.indices] = np.arange(count)
        self.offsets, self.columns = initial_adjacency(grid_index[self.bonds].reshape(-1, 2), count)
        dynamic = self.material.max_dynamic*count if self.material.adhesion > 0 else 0
        self.partner = np.full(dynamic, -1, np.int32)
        self.dyn_bonds = np.zeros((dynamic, 2), np.int32)
        self.dyn_rest = np.zeros(dynamic, F)
        self.dyn_history = np.zeros(dynamic, F)
        self.dyn_active = np.zeros(dynamic, np.int32)

    def params(self, h):
        return Params(len(self.indices), self.slots, self.cell, self.stiffness, self.friction, self.friction_damping, h)

    def accumulate(self, x, previous, h, rhs):
        """One Newton iteration: returns (block diagonal D, operator data for multiply)."""
        p = self.params(h)
        n = len(x)
        diagonal = np.zeros((n, 9), F)
        grid = build_grid(x, previous, self.indices, self.world, self.radius, p)
        contacts_data = accumulate_contacts(grid, p, rhs, diagonal)
        tangent = dyn_tangent = None
        if len(self.bonds):
            tangent = accumulate_bonds(self.material, x, previous, h, self.bonds, self.rest, self.history,
                                       self.active, self.cohesion, rhs, diagonal)
        if len(self.partner):
            dyn_tangent = accumulate_bonds(self.material, x, previous, h, self.dyn_bonds, self.dyn_rest,
                                           self.dyn_history, self.dyn_active, self.material.adhesion, rhs, diagonal)
        return diagonal, (grid, p, contacts_data, tangent, dyn_tangent)

    def multiply(self, data, direction, product):
        grid, p, (count, cache_ids, cache), tangent, dyn_tangent = data
        multiply_contacts(grid, p, count, cache_ids, cache, direction, product)
        if tangent is not None:
            multiply_bonds(self.bonds, self.active, tangent, direction, product)
        if dyn_tangent is not None:
            multiply_bonds(self.dyn_bonds, self.dyn_active, dyn_tangent, direction, product)

    def finish(self, x, previous, h):
        """After the accepted substep: commit both bond sets, rebuild the grid on the result, form new bonds."""
        if len(self.bonds):
            commit_bonds(self.material, x, self.bonds, self.rest, self.history, self.active)
        if len(self.partner):
            commit_bonds(self.material, x, self.dyn_bonds, self.dyn_rest, self.dyn_history, self.dyn_active)
            p = self.params(h)
            grid = build_grid(x, previous, self.indices, self.world, self.radius, p)
            form_bonds(grid, p, self.material, self.offsets, self.columns, self.partner, self.dyn_bonds,
                       self.dyn_rest, self.dyn_history, self.dyn_active)
