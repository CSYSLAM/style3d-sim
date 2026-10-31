"""Particle fluid of the legacy library (synreal::Fluid + fluid_kernel), transcribed from the sm_52 PTX.

Per Newton iteration the legacy step runs (nsys trace, 128 threads per block):

    initialize_rhs -> memset(head = -1, D = 0) -> build_grid(x) -> evaluate_rows -> accumulate_rows(y = x_previous)
    -> ... initialize_block_diagonal -> copy A->B -> contact block -> add_diagonal(D into B) -> invert ...
    -> PCG [memset T -> multiply_rows(direction, T) -> ...]
    -> initialize_scale(1) -> bound_scale(relaxation, ratio * h_f) -> scale_step(solution) -> apply_nonlinear_step

Grid points are the fluid particles followed by the static boundary samples (stride P per world). Each fluid row has
a one-sided density constraint c = max(sum_j V_j W(x_q - x_j) - 1, 0) with Poly6 W and weight k = K V_q when
compressed, plus a frozen-coefficient pair viscosity. The Gauss-Newton operator J^T k J is never assembled: its
block diagonal D goes into the preconditioner and multiply_rows applies it to the PCG direction.

Numerics follow the sm_120 SASS of the driver JIT: every operation is a rounded float32 op except the explicit
fma.rn and one contraction by ptxas, fma(0.01 h, h, r2), in the viscosity denominator. Hash-list insertion
(atom.exch) and the red.global.add accumulations are not reproducible on the GPU (warp order varies run to run);
the emulation below inserts in ascending index order and applies atomics warps descending, then in SIMT
instruction order, lanes ascending, as numerics.element_atomic_add does.
"""
import numpy as np

from .numerics import F, fma

POLY6 = F(np.frombuffer(np.uint32(0x3FC88904).tobytes(), F)[0])     # 315 / (64 pi)
SPIKY = F(np.frombuffer(np.uint32(0xC11666C3).tobytes(), F)[0])     # -945 / (32 pi)
CACHE = 64                                                          # neighbour cache slots per row
HASH = (73856093, 19349663, 83492791)


def slot_count(points):
    """Fluid::initialize: twice the smallest power of two >= the number of grid points."""
    if 2*points <= 1:
        return 1
    slots, previous = 1, 0
    while True:
        previous, slots = slots, slots*2
        if not previous < points:
            return slots


def hash_cells(cells, slots):
    c = cells.astype(np.int64).astype(np.uint32)
    h = (c[..., 0]*np.uint32(HASH[0])) ^ (c[..., 1]*np.uint32(HASH[1])) ^ (c[..., 2]*np.uint32(HASH[2]))
    return (h & np.uint32(slots-1)).astype(np.int64)


class Grid:
    """Buffers of fluid_kernel::View (positions, cells, volumes, ids, worlds and the hash lists)."""
    def __init__(self, ids, world, positions, volumes, cells, head, next_):
        self.ids, self.world, self.positions, self.volumes, self.cells = ids, world, positions, volumes, cells
        self.head, self.next = head, next_


def build_grid(x, fluid_indices, particle_world, mass, rest_density, smoothing_radius, boundary_positions,
               boundary_volumes, slots, insertion=None):
    """build_grid for a single world. `insertion` is the atom.exch order (default: ascending grid index)."""
    nf, nb = len(fluid_indices), len(boundary_positions)
    ids = np.concatenate((fluid_indices, np.full(nb, -1))).astype(np.int32)
    if particle_world is not None and len(particle_world):
        fluid_world = np.maximum(particle_world[fluid_indices], 0)
    else:
        fluid_world = np.zeros(nf, np.int32)
    world = np.concatenate((fluid_world, np.full(nb, -1))).astype(np.int32)
    positions = np.concatenate((x[fluid_indices], boundary_positions)).astype(F)
    volumes = np.concatenate((mass[fluid_indices]/F(rest_density), boundary_volumes)).astype(F)
    # div.rn, cvt.rmi (floor) and cvt.rzi to int: floor division, not truncation, for negative coordinates.
    cells = np.floor((positions/F(smoothing_radius)).astype(F)).astype(np.int32)
    slot = hash_cells(cells, slots)
    order = np.arange(nf+nb) if insertion is None else np.asarray(insertion)
    head = np.full(slots, -1, np.int32)
    next_ = np.full(nf+nb, -1, np.int32)
    for i in order:  # atom.exch: the new element becomes the head, the old head its successor
        next_[i] = head[slot[i]]
        head[slot[i]] = i
    return Grid(ids, world, positions, volumes, cells, head, next_)


def _slot_lists(head, next_):
    """Every hash list in traversal order as CSR (start per slot, items)."""
    slots = np.flatnonzero(head >= 0)
    cur = head[slots].astype(np.int64)
    owner, depth, item = [], [], []
    d = 0
    while len(cur):
        owner.append(slots)
        depth.append(np.full(len(cur), d))
        item.append(cur)
        nxt = next_[cur]
        keep = nxt >= 0
        slots, cur = slots[keep], nxt[keep].astype(np.int64)
        d += 1
    owner, depth, item = (np.concatenate(v) if v else np.empty(0, np.int64) for v in (owner, depth, item))
    order = np.lexsort((depth, owner))
    counts = np.bincount(owner, minlength=len(head))
    start = np.concatenate(([0], np.cumsum(counts)))
    return start, item[order]


def row_points(rows, fluid_count, stride):
    """sample_of_row: q = (r / F) P + r % F."""
    return (rows//fluid_count)*stride+rows % fluid_count


def candidates(grid, rows, q, slots):
    """All grid points visited by a row, in traversal order: 27 cells (dx = k % 3, dy = k / 3 % 3, dz = k / 9),
    each hash list from its head, keeping points of that exact cell in the row's world or world -1."""
    k = np.arange(27)
    offsets = np.stack((k % 3, (k//3) % 3, k//9), axis=1)-1
    target = grid.cells[q][:, None, :]+offsets[None]                     # rows x 27 x 3
    start, items = _slot_lists(grid.head, grid.next)
    slot = hash_cells(target, slots)
    length = (start[slot+1]-start[slot]).reshape(-1)
    pair = np.repeat(np.arange(len(length)), length)
    first = np.repeat(start[slot].reshape(-1), length)
    within = np.arange(len(pair))-np.repeat(np.cumsum(length)-length, length)
    j = items[first+within]
    row = pair//27
    cell = target.reshape(-1, 3)[pair]
    world_q = grid.world[q][row]
    keep = np.all(grid.cells[j] == cell, axis=1) & ((grid.world[j] == world_q) | (grid.world[j] == -1))
    return rows[row[keep]], row[keep], j[keep]


def _pad(row, n_rows):
    """Column index of each candidate within its row, for column-by-column sequential accumulation."""
    counts = np.bincount(row, minlength=n_rows)
    column = np.arange(len(row))-np.repeat(np.cumsum(counts)-counts, counts)
    return column, int(counts.max()) if len(counts) else 0


class Params:
    def __init__(self, smoothing_radius, bulk_modulus, viscosity, dt, fluid_count, stride, rows, slots):
        self.h, self.K, self.mu, self.dt = F(smoothing_radius), F(bulk_modulus), F(viscosity), F(dt)
        self.F, self.P, self.rows, self.slots = fluid_count, stride, rows, slots
        self.h2 = self.h*self.h
        self.h3 = self.h*self.h2
        self.h5 = self.h*(self.h*self.h3)
        self.minus_two_mu = self.mu*F(-2)
        self.soft = self.h*F(0.01)


def _geometry(grid, p, q, j):
    """d = x_q - x_j, r2, z = max(1 - r2/h^2, 0) and the Poly6 gradient (d z^2 C2) / h^5."""
    d = (grid.positions[q]-grid.positions[j]).astype(F)
    r2 = fma(d[:, 2], d[:, 2], fma(d[:, 0], d[:, 0], d[:, 1]*d[:, 1]))
    z = np.maximum(F(1)-r2/p.h2, F(0)).astype(F)
    zz = z*(z*SPIKY)
    g = ((d*zz[:, None])/p.h5).astype(F)
    return d, r2, z, g


def _viscosity(p, grid, q, j, d, r2, g):
    """nu = ((-2 mu V_q V_j (d . g)) / fma(0.01 h, h, r2)) / dt; zero unless mu > 0 and j > q."""
    dot = fma(d[:, 2], g[:, 2], fma(d[:, 0], g[:, 0], d[:, 1]*g[:, 1]))
    scale = (p.minus_two_mu*grid.volumes[q])*grid.volumes[j]
    nu = ((dot*scale)/fma(p.soft, p.h, r2))/p.dt
    return np.where((p.mu > 0) & (j > q), nu, F(0)).astype(F)


def evaluate_rows(grid, p):
    """Returns grad[rows, 3], residual[rows], weight[rows], count[rows], cache_ids[rows, 64], cache[rows, 64, 4]."""
    rows = np.arange(p.rows)
    q_all = row_points(rows, p.F, p.P)
    _, r, j = candidates(grid, rows, q_all, p.slots)
    q = q_all[r]
    d, r2, z, g = _geometry(grid, p, q, j)
    w = (((z*(z*(z*POLY6))))/p.h3).astype(F)
    v = grid.volumes[j]
    column, width = _pad(r, p.rows)
    density = np.zeros(p.rows, F)
    grad = np.zeros((p.rows, 3), F)
    other = j != q
    for c in range(width):
        m = column == c
        rr = r[m]
        density[rr] = fma(v[m], w[m], density[rr])
        o = m & other
        ro = r[o]
        grad[ro] = fma(g[o], v[o][:, None], grad[ro])
    dynamic = other & (grid.ids[j] >= 0) & (r2 < p.h2)
    rank = np.cumsum(dynamic)-1
    first = np.concatenate(([0], np.cumsum(np.bincount(r[dynamic], minlength=p.rows))))[r]
    slot = rank-first
    count = np.bincount(r[dynamic], minlength=p.rows).astype(np.int32)
    cache_ids = np.zeros((p.rows, CACHE), np.int32)
    cache = np.zeros((p.rows, CACHE, 4), F)
    store = dynamic & (slot < CACHE)
    nu = _viscosity(p, grid, q[store], j[store], d[store], r2[store], g[store])
    cache_ids[r[store], slot[store]] = j[store]
    cache[r[store], slot[store], :3] = g[store]*(-v[store])[:, None]
    cache[r[store], slot[store], 3] = nu
    residual = np.maximum(density+F(-1), F(0)).astype(F)
    weight = np.where(density > 1, p.K*grid.volumes[q_all], F(0)).astype(F)
    return grad, residual, weight, count, cache_ids, cache


WARP_SIGN = -1  # -1: warps descending (default emulation); +1: ascending (experiments)
LANE_SIGN = 1


class _Atomics:
    """Collects red.global.add operations with (warp, instruction, lane) keys and applies them in emulated order."""
    def __init__(self):
        self.keys, self.index, self.values = [], [], []

    def add(self, rows, instruction, index, values):
        rows = np.asarray(rows)
        n = len(rows)
        if not n:
            return
        width = values.shape[1]
        key = np.stack((WARP_SIGN*(rows//32), np.broadcast_to(instruction, n), LANE_SIGN*(rows % 32)), axis=1)
        self.keys.append(np.repeat(key, width, axis=0))
        self.index.append((np.asarray(index)[:, None]*width+np.arange(width)).reshape(-1))
        self.values.append(np.asarray(values, F).reshape(-1))

    def apply(self, target):
        if not self.keys:
            return
        keys = np.concatenate(self.keys)
        order = np.lexsort((keys[:, 2], keys[:, 1], keys[:, 0]))
        values = np.concatenate(self.values)[order]
        values = np.where(np.abs(values) < np.finfo(F).tiny, F(0), values).astype(F)  # REDG...FTZ
        flat = target.reshape(-1)  # a view: targets are C-contiguous buffers
        np.add.at(flat, np.concatenate(self.index)[order], values)


def _outer(k, c):
    """k * (c c^T) in the PTX order: products c_i c_j first, then scaled; glm column-major symmetric layout."""
    c0, c1, c2 = c[:, 0], c[:, 1], c[:, 2]
    e00, e10, e20, e11, e21, e22 = (k*(a*b) for a, b in ((c0, c0), (c1, c0), (c2, c0), (c1, c1), (c2, c1), (c2, c2)))
    return np.stack((e00, e10, e20, e10, e11, e21, e20, e21, e22), axis=1).astype(F)


def _isotropic(nu):
    zero = np.zeros_like(nu)
    return np.stack((nu, zero, zero, zero, nu, zero, zero, zero, nu), axis=1).astype(F)


def accumulate_rows(grid, p, grad, residual, weight, count, cache_ids, cache, y, force, diagonal, rows=None):
    """f -= k c J^T and D += k J^T J, plus viscosity; `force` (n x 3) and `diagonal` (n x 9) are updated in place.
    `rows` restricts the launch (for kernel A/B); the default is every fluid row."""
    rows = np.arange(p.rows) if rows is None else np.asarray(rows)
    q = row_points(rows, p.F, p.P)
    a = grid.ids[q]
    k = weight[rows]
    kc = -(k*residual[rows])
    force_ops, diag_ops = _Atomics(), _Atomics()
    force_ops.add(rows, 0, a, grad[rows]*kc[:, None])
    diag_ops.add(rows, 0, a, _outer(k, grad[rows]))
    cached = count[rows] < CACHE+1
    # Cached rows: one loop iteration per neighbour slot, six atomic instructions per iteration.
    for m in range(int(count[rows][cached].max()) if cached.any() else 0):
        sel = cached & (count[rows] > m)
        rs, qs, as_, ks, kcs = rows[sel], q[sel], a[sel], k[sel], kc[sel]
        jj = cache_ids[rs, m]
        aj = grid.ids[jj]
        c4 = cache[rs, m]
        base = 1+6*m
        force_ops.add(rs, base, aj, c4[:, :3]*kcs[:, None])
        diag_ops.add(rs, base+1, aj, _outer(ks, c4[:, :3]))
        nu = c4[:, 3]
        v = nu > 0
        if v.any():
            dx = (grid.positions[qs[v]]-grid.positions[jj[v]]).astype(F)
            dy = (y[as_[v]]-y[aj[v]]).astype(F)
            f = ((dx-dy)*(-nu[v])[:, None]).astype(F)
            force_ops.add(rs[v], base+2, as_[v], f)
            force_ops.add(rs[v], base+3, aj[v], -f)
            diag_ops.add(rs[v], base+4, as_[v], _isotropic(nu[v]))
            diag_ops.add(rs[v], base+5, aj[v], _isotropic(nu[v]))
    fallback = rows[~cached]
    if len(fallback):
        _accumulate_fallback(grid, p, fallback, weight, residual, y, force_ops, diag_ops)
    force_ops.apply(force)
    diag_ops.apply(diagonal)


def _accumulate_fallback(grid, p, rows, weight, residual, y, force_ops, diag_ops):
    """More than 64 dynamic neighbours: traverse the grid again, without the support-radius test."""
    qr = row_points(rows, p.F, p.P)
    rr, r, j = candidates(grid, rows, qr, p.slots)
    q = qr[r]
    keep = (j != q) & (grid.ids[j] >= 0)
    rr, q, j = rr[keep], q[keep], j[keep]
    a, aj = grid.ids[q], grid.ids[j]
    d, r2, z, g = _geometry(grid, p, q, j)
    c = (g*(-grid.volumes[j])[:, None]).astype(F)
    k = weight[rr]
    kc = -(k*residual[rr])
    column, _ = _pad(np.searchsorted(rows, rr), len(rows))
    base = 10**6+6*column  # after the cached rows' instructions
    force_ops.add(rr, base, aj, c*kc[:, None])
    diag_ops.add(rr, base+1, aj, _outer(k, c))
    v = (p.mu > 0) & (j > q)
    if v.any():
        nu = _viscosity(p, grid, q[v], j[v], d[v], r2[v], g[v])
        dy = (y[a[v]]-y[aj[v]]).astype(F)
        f = ((d[v]-dy)*(-nu)[:, None]).astype(F)
        force_ops.add(rr[v], base[v]+2, a[v], f)
        force_ops.add(rr[v], base[v]+3, aj[v], -f)
        diag_ops.add(rr[v], base[v]+4, a[v], _isotropic(nu))
        diag_ops.add(rr[v], base[v]+5, aj[v], _isotropic(nu))


def multiply_rows(grid, p, grad, weight, count, cache_ids, cache, direction, product, rows=None):
    """product += J^T k J direction + viscosity Laplacian (frozen coefficients), in place."""
    rows = np.arange(p.rows) if rows is None else np.asarray(rows)
    q = row_points(rows, p.F, p.P)
    a = grid.ids[q]
    g = grad[rows]
    pa = direction[a]
    s = fma(g[:, 2], pa[:, 2], fma(g[:, 0], pa[:, 0], g[:, 1]*pa[:, 1]))
    n = count[rows]
    cached = n < CACHE+1
    ops = _Atomics()
    width = int(n[cached].max()) if cached.any() else 0
    for m in range(width):
        sel = cached & (n > m)
        c4 = cache[rows[sel], m]
        pj = direction[grid.ids[cache_ids[rows[sel], m]]]
        t = fma(c4[:, 2], pj[:, 2], fma(c4[:, 0], pj[:, 0], c4[:, 1]*pj[:, 1]))
        s[sel] = s[sel]+t
    ks = (s*weight[rows]).astype(F)
    out = (g*ks[:, None]).astype(F)
    for m in range(width):
        sel = cached & (n > m)
        rs = rows[sel]
        c4 = cache[rs, m]
        aj = grid.ids[cache_ids[rs, m]]
        dp = (direction[a[sel]]-direction[aj]).astype(F)
        v = (c4[:, 3:4]*dp).astype(F)
        out[sel] = out[sel]+v
        ops.add(rs, 1+m, aj, fma(ks[sel][:, None], c4[:, :3], -v))  # FFMA(k s, c, -(nu dp))
    ops.add(rows[cached], 1+CACHE, a[cached], out[cached])
    fallback = ~cached
    if fallback.any():
        _multiply_fallback(grid, p, rows[fallback], s[fallback], weight, g[fallback], direction, ops)
    ops.apply(product)


def _multiply_fallback(grid, p, rows, s, weight, g, direction, ops):
    qr = row_points(rows, p.F, p.P)
    rr, r, j = candidates(grid, rows, qr, p.slots)
    q = qr[r]
    keep = (j != q) & (grid.ids[j] >= 0)
    rr, r, q, j = rr[keep], r[keep], q[keep], j[keep]
    a, aj = grid.ids[q], grid.ids[j]
    d, r2, _, gj = _geometry(grid, p, q, j)
    pj = direction[aj]
    dot = fma(gj[:, 2], pj[:, 2], fma(pj[:, 0], gj[:, 0], pj[:, 1]*gj[:, 1]))
    vj = grid.volumes[j]
    column, width = _pad(r, len(rows))
    for c in range(width):
        m = column == c
        s[r[m]] = fma(dot[m], -vj[m], s[r[m]])
    ks = (s*weight[rows]).astype(F)
    base = 10**6
    ops.add(rows, base, grid.ids[row_points(rows, p.F, p.P)], (g*ks[:, None]).astype(F))
    ops.add(rr, base+1+3*column, aj, (gj*(-(ks[r]*vj))[:, None]).astype(F))
    v = (p.mu > 0) & (j > q)
    if v.any():
        nu = _viscosity(p, grid, q[v], j[v], d[v], r2[v], gj[v])
        f = ((direction[a[v]]-direction[aj[v]])*nu[:, None]).astype(F)
        ops.add(rr[v], base+2+3*column[v], a[v], f)
        ops.add(rr[v], base+3+3*column[v], aj[v], -f)


def add_diagonal(diagonal, preconditioner):
    """B += D per 3x3 block."""
    preconditioner += diagonal.reshape(preconditioner.shape)


def limit_step(grid, p, solution, relaxation, max_step, worlds=1):
    """initialize_scale(1) -> bound_scale -> scale_step for a single world (particle_world absent or >= 0)."""
    scale = np.ones(worlds, F)
    rows = np.arange(p.rows)
    q = row_points(rows, p.F, p.P)
    dx = solution[grid.ids[q]]
    length = np.sqrt(fma(dx[:, 2], dx[:, 2], fma(dx[:, 0], dx[:, 0], dx[:, 1]*dx[:, 1]))).astype(F)
    eta = np.full(len(rows), F(relaxation))
    if max_step > 0:
        over = length > F(max_step)
        eta[over] = np.minimum(eta[over], (F(max_step)/length[over]).astype(F))
    # red.global.min.s32 on the float bits: equal to a float minimum for non-negative values.
    np.minimum.at(scale, grid.world[q], eta)
    return scale


def scale_step(solution, scale, particle_world=None):
    world = np.zeros(len(solution), np.int64) if particle_world is None or not len(particle_world) \
        else np.maximum(particle_world, 0)
    return (scale[world][:, None]*solution).astype(F)
