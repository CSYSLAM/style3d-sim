"""Block-Jacobi PCG kernels of the legacy solver (pcg_solver.cu / solver_newton.cu), transcribed bit-exactly.

Every function mirrors one CUDA kernel launched with 256 threads per block, including the two-level dot-product
reduction: a per-block warp-shuffle tree (offsets 1..16, then warps 0..7 summed by thread 0) followed by
cub::DeviceReduceSingleTileKernel over the block partials. Arithmetic order and ptxas FFMA contraction follow
the sm_120 SASS of the legacy PTX; see reconstruction/kernel_ab.py for the bit-for-bit checks.
Matrices are glm::mat3 (column-major) stored as flat [..., 9] float32 arrays.
"""
import numpy as np

from .numerics import F, fma, fms

BLOCK = 256
WARP = 32
TINY_DENOMINATOR = F(1e-30)


def warp_tree(values, valid):
    """Lane-0 result of shfl.sync.down reductions with offsets 1,2,4,8,16 over `valid` leading lanes."""
    v = np.zeros(WARP, F)
    v[:len(values)] = values
    last = valid-1
    for offset in (1, 2, 4, 8, 16):
        nxt = v.copy()
        lanes = np.arange(WARP)
        ok = lanes+offset <= last
        nxt[ok] = v[lanes[ok]+offset]+v[ok]
        v = nxt
    return v[0]


def block_partials(values):
    """Per-block partial sums written by the *_and_reduce kernels (invalid threads contribute +0)."""
    values = np.asarray(values, F)
    blocks = max(1, -(-len(values)//BLOCK))
    padded = np.zeros(blocks*BLOCK, F)
    padded[:len(values)] = values
    out = np.empty(blocks, F)
    for b in range(blocks):
        chunk = padded[b*BLOCK:(b+1)*BLOCK]
        warps = [warp_tree(chunk[w*WARP:(w+1)*WARP], WARP) for w in range(BLOCK//WARP)]
        total = warps[0]
        for w in warps[1:]:
            total = F(total+w)
        out[b] = total
    return out


TILE = BLOCK*20           # cub Policy600 scaled for 4-byte items: 256 threads x 20 items per tile
VECTOR = 4                # full tiles of a float* input are loaded as float4 (VECTOR_LOAD_LENGTH)
MAX_REDUCE_TILES = 200    # see cub_sum: beyond this the grid size would depend on the device occupancy


def _block_reduce(aggregates, valid):
    """BLOCK_REDUCE_WARP_REDUCTIONS: shuffle tree per warp, then warp aggregates summed in warp order."""
    warps = [warp_tree(aggregates[w:min(w+WARP, valid)], min(WARP, valid-w)) for w in range(0, valid, WARP)]
    total = warps[0]
    for value in warps[1:]:
        total = F(total+value)
    return total


def _consume_range(items, offset, end):
    """AgentReduce::ConsumeRange over items[offset:end] with tile stride TILE for one block.

    Full tiles of an aligned float* are vector-loaded: thread t reads items[base + 4t + 1024i + j] for i in 0..4 and
    j in 0..3 and reduces them in that order (the first tile without a prefix). A trailing partial tile is read
    block-striped (thread t takes t, t+256, ...) onto the running aggregates. A range that starts with a partial tile
    reduces only its valid threads."""
    if offset+TILE > end:
        valid = end-offset
        threads = min(valid, BLOCK)
        aggregates = items[offset:offset+threads].copy()
        for t in range(threads):
            for j in range(t+BLOCK, valid, BLOCK):
                aggregates[t] = F(aggregates[t]+items[offset+j])
        return _block_reduce(aggregates, threads)
    lanes = np.arange(BLOCK)*VECTOR
    order = [lanes+BLOCK*VECTOR*i+j for i in range(TILE//(BLOCK*VECTOR)) for j in range(VECTOR)]
    aggregates = items[offset+order[0]].copy()
    for index in order[1:]:
        aggregates = (aggregates+items[offset+index]).astype(F)
    offset += TILE
    while offset+TILE <= end:
        for index in order:
            aggregates = (aggregates+items[offset+index]).astype(F)
        offset += TILE
    for start in range(offset, end, BLOCK):
        count = min(BLOCK, end-start)
        aggregates[:count] = (aggregates[:count]+items[start:start+count]).astype(F)
    return _block_reduce(aggregates, BLOCK)


def cub_sum(items, init=F(0)):
    """cub::DeviceReduce::Sum<Policy600, float> over an aligned float* input, as dispatched by the legacy solver.

    Up to one tile (5120 items) runs DeviceReduceSingleTileKernel over the input directly. Larger inputs run
    DeviceReduceKernel (GRID_MAPPING_STRIP_MINE: block b takes tiles b, b+grid, ...) over min(tiles, max_blocks)
    blocks, then the single-tile kernel over the block partials; init is applied only in that final kernel.
    max_blocks = occupancy * SMs * 5 is device dependent, so inputs with more tiles than any supported GPU launches
    as one block per tile are rejected."""
    items = np.asarray(items, F)
    n = len(items)
    if n == 0:
        return F(init)
    if n <= TILE:
        return F(F(init)+_consume_range(items, 0, n))
    tiles = -(-n//TILE)
    if tiles > MAX_REDUCE_TILES:
        raise NotImplementedError('cub reduction over more tiles than one block each is not reconstructed')
    # grid_size == tiles: every block consumes exactly one tile, the last one possibly partial.
    partials = np.array([_consume_range(items, b*TILE, min(n, (b+1)*TILE)) for b in range(tiles)], F)
    return F(F(init)+_consume_range(partials, 0, tiles))


def reduce_sum(values):
    return cub_sum(block_partials(values))


def mat_vec(m, v):
    """glm mat3 * vec3 as compiled: row r = fma(m[6+r], z, fma(m[r], x, m[3+r]*y))."""
    return np.stack([fma(m[:, 6+r], v[:, 2], fma(m[:, r], v[:, 0], m[:, 3+r]*v[:, 1])) for r in range(3)], axis=1)


def dot(u, v):
    """fma(uz, vz, fma(ux, vx, uy*vy))."""
    return fma(u[:, 2], v[:, 2], fma(u[:, 0], v[:, 0], u[:, 1]*v[:, 1]))


def initialize_rhs(scale, x, target, mass, base, mask=None, mass_ell=None):
    """rhs = fma(m (target - x) + sum_j M_ij (target_j - x_j), 1/h^2, base); zero for nonpositive mass or inactive
    mask. `mass_ell` = (row_nnz, cols[max_nnz, n], values[max_nnz, n], max_nnz) holds the off-diagonal mass
    (affine-body second moments); the sum starts at +0 and accumulates fma(M_ij, d_j, acc) slot by slot."""
    inertia = mass[:, None]*(target-x)
    acc = np.zeros_like(x)
    if mass_ell is not None:
        row_nnz, cols, values, max_nnz = mass_ell
        n = len(x)
        d = (target-x).astype(F)
        limit = np.minimum(np.maximum(row_nnz, 0), max_nnz)
        for k in range(max_nnz):
            col = cols[k]
            ok = (k < limit) & (col >= 0) & (col < n)
            rows = np.flatnonzero(ok)
            acc[rows] = fma(values[k, rows][:, None], d[col[rows]], acc[rows])
    inertia = inertia+acc
    rhs = fma(inertia, F(scale), np.zeros_like(x) if base is None else base)
    off = mass <= 0
    if mask is not None:
        off |= (mask & 1) != 1
    rhs[off] = 0
    return rhs.astype(F)


def initialize_block_diagonal(diagonal):
    """Diagonal mat3 blocks diag(a, a, a); the off-diagonal entries are a*0 (keeps -0 for negative a)."""
    a = np.asarray(diagonal, F)
    z = a*F(0)
    return np.stack((a, z, z, z, a, z, z, z, a), axis=1)


def invert_block_preconditioner(blocks, scale, mask=None):
    """Symmetrized cofactor inverse; nonpositive/degenerate determinants fall back to inverted diagonals."""
    m = np.asarray(blocks, F)
    s00, s11, s22 = m[:, 0], m[:, 4], m[:, 8]
    s01 = (m[:, 1]+m[:, 3])*F(0.5)
    s02 = (m[:, 2]+m[:, 6])*F(0.5)
    s12 = (m[:, 5]+m[:, 7])*F(0.5)
    c00 = fms(s11, s22, s12, s12)
    c01 = fms(s02, s12, s01, s22)
    c02 = fms(s01, s12, s11, s02)
    det = fma(s02, c02, fma(s00, c00, s01*c01))
    regular = (det > TINY_DENOMINATOR) & (np.abs(det) < np.inf)
    safe = np.where(regular, det, F(1))
    inv = F(1)/safe
    c11 = fms(s00, s22, s02, s02)
    c12 = fms(s01, s02, s00, s12)
    c22 = fms(s00, s11, s01, s01)
    full = np.stack((c00*inv, c01*inv, c02*inv, c01*inv, c11*inv, c12*inv, c02*inv, c12*inv, c22*inv), axis=1)
    def rcp(v):
        return np.where(v > 0, F(1)/np.where(v > 0, v, F(1)), F(0)).astype(F)
    zero = np.zeros_like(s00)
    fallback = np.stack((rcp(s00), zero, zero, zero, rcp(s11), zero, zero, zero, rcp(s22)), axis=1)
    out = np.where(regular[:, None], full, fallback).astype(F)
    off = ~(np.asarray(scale) > 0)
    if mask is not None:
        off |= (mask & 1) != 1
    out[off] = 0
    return out


def initialize_zero_solution_and_reduce(rhs, preconditioner):
    """Residual r = rhs, solution 0, and the block partials of r^T M r."""
    r = np.asarray(rhs, F).copy()
    z = mat_vec(preconditioner, r)
    return r, np.zeros_like(r), block_partials(dot(z, r))


def guarded_ratio(numerator, denominator):
    if abs(denominator) <= TINY_DENOMINATOR or not abs(denominator) <= np.inf or not abs(numerator) <= np.inf:
        return F(0)
    return F(F(numerator)/F(denominator))


def update_cg_direction(k, preconditioner, residual, num, direction):
    """p = M r + beta p with beta = num[k] / num[k-1] (k > 0)."""
    preconditioner = np.asarray(preconditioner, F)
    z = (preconditioner[:, None]*np.asarray(residual, F)).astype(F) if preconditioner.ndim == 1 else mat_vec(
        preconditioner, residual)
    if k <= 0:
        return z
    beta = guarded_ratio(num[k], num[k-1])
    return fma(beta, direction, z)


def ell_product(row_nnz, cols, blocks, max_nnz, direction):
    """Sum over the first min(row_nnz, max_nnz) block-ELL entries of a row, k ascending, starting from +0.

    cols [max_nnz, n] and blocks [max_nnz, n, 9] use the kernel layout entries[k*tile + row] with tile = n.
    """
    n = len(direction)
    total = np.zeros((n, 3), F)
    count = np.minimum(np.maximum(np.asarray(row_nnz), 0), max_nnz)
    for k in range(max_nnz):
        rows = np.flatnonzero(count > k)
        c = cols[k, rows]
        ok = (c >= 0) & (c < n)
        rows, c = rows[ok], c[ok]
        term = mat_vec(blocks[k, rows], direction[c])
        total[rows] = (term+total[rows]).astype(F)
    return total


def multiply_matrix_and_reduce(diagonal, direction, extra, ell=None):
    """Ap = (D p + sum of ELL blocks) + extra; returns (Ap, partials of p.Ap). ell = (row_nnz, cols, blocks, max_nnz)."""
    off = np.zeros_like(direction) if ell is None else ell_product(*ell, direction)
    ap = mat_vec(diagonal, direction)+off
    if extra is not None:
        ap = ap+extra
    return ap.astype(F), block_partials(dot(ap, direction))


def update_solution_residual_and_reduce(k, num, den, direction, product, preconditioner, solution, residual):
    """alpha = num[k]/den[k]; r = FFMA(Ap, -alpha, r); x = FFMA(p, alpha, x); partials of r^T M r."""
    alpha = guarded_ratio(num[k], den[k])
    residual = fma(product, -alpha, residual)
    solution = fma(direction, alpha, solution)
    z = mat_vec(preconditioner, residual)
    return solution, residual, block_partials(dot(z, residual))


def initialize_block_non_diagonal(row_nnz, cols, values, max_nnz):
    """Expand scalar ELL entries v into diag(v, v, v) blocks (off-diagonals are v*0); single world (offset 0)."""
    v = np.asarray(values, F)
    z = v*F(0)
    blocks = np.stack((v, z, z, z, v, z, z, z, v), axis=-1).astype(F)
    return np.asarray(cols).copy(), blocks


# ---------------------------------------------------------------------------------------------------------------
# PD_NEWTON linear solve: scalar-valued ELL (combine_system_non_diagonal output used directly), thrust/cub
# transform reductions over particles instead of per-block partials.

def scalar_ell_product(row_nnz, cols, values, max_nnz, direction):
    """multiply_matrix<NonZeroEntry, mat3> off-diagonal part: acc = fma(v, p_col, acc) slot by slot from +0."""
    n = len(direction)
    total = np.zeros((n, 3), F)
    count = np.minimum(np.maximum(np.asarray(row_nnz), 0), max_nnz)
    for k in range(max_nnz):
        rows = np.flatnonzero(count > k)
        c = cols[k, rows]
        ok = (c >= 0) & (c < n)
        rows, c = rows[ok], c[ok]
        total[rows] = fma(values[k, rows][:, None], direction[c], total[rows])
    return total


def multiply_matrix(diagonal, direction, extra, scalar_ell=None):
    """Ap = (D p + scalar ELL p) + extra (multiply_matrix<NonZeroEntry, mat3>)."""
    off = np.zeros_like(direction) if scalar_ell is None else scalar_ell_product(*scalar_ell, direction)
    ap = (mat_vec(diagonal, direction)+off).astype(F)
    if extra is not None:
        ap = (ap+extra).astype(F)
    return ap


def update_solution_and_residual(k, num, den, direction, product, solution, residual):
    """alpha = num[k]/den[k] (guarded); r = fma(-alpha, Ap, r); x = fma(alpha, p, x)."""
    alpha = guarded_ratio(num[k], den[k])
    residual = fma(-alpha, product, residual)
    solution = fma(alpha, direction, solution)
    return solution.astype(F), residual.astype(F)


# ---------------------------------------------------------------------------------------------------------------
# PD_NEWTON scalar-preconditioner path (solve_pd_newton_system without the affine-body block preconditioner).

def prepare_inverse_preconditioner(diagonal, mass, flags=None):
    """prepare_inverse_preconditioner: 1/d (rcp) for active particles (m > 0 and ACTIVE flag) with d > 0, else 0."""
    d = np.asarray(diagonal, F)
    m = np.asarray(mass, F)
    active = m > 0
    if flags is not None:
        active &= (np.asarray(flags) & 1) != 0
    out = np.zeros_like(d)
    ok = active & (d > 0)
    out[ok] = (F(1)/d[ok]).astype(F)
    return out


def apply_block_diagonal_preconditioner(blocks, vector):
    """apply_block_diagonal_preconditioner: z = M r per particle (glm mat3 times vec3)."""
    return mat_vec(np.asarray(blocks, F), np.asarray(vector, F)).astype(F)


def update_preconditioned_cg_direction(k, z, num, direction):
    """update_preconditioned_cg_direction: p = fma(beta, p, z), beta = num[k]/num[k-1] (0 at k = 0, or when the
    denominator is tiny/non-finite or the numerator is non-finite)."""
    beta = F(0)
    if k > 0:
        beta = guarded_ratio(num[k], num[k-1])
    return fma(beta, np.asarray(direction, F), np.asarray(z, F)).astype(F)


def evaluate_residual(row_nnz, cols, values, max_nnz, diagonal, x, b, extra=None):
    """Residual for scalar/block ELL entries and scalar/mat3 diagonals; preserve native sum order."""
    x, diagonal, values = np.asarray(x, F), np.asarray(diagonal, F), np.asarray(values, F)
    ax = (diagonal[:, None]*x).astype(F) if diagonal.ndim == 1 else mat_vec(diagonal, x)
    off = (ell_product if values.ndim == 3 else scalar_ell_product)(row_nnz, cols, values, max_nnz, x)
    ax = (ax+off).astype(F)
    if extra is not None:
        ax = (ax+np.asarray(extra, F)).astype(F)
    return (np.asarray(b, F)-ax).astype(F)


# ---------------------------------------------------------------------------------------------------------------
# Affine-body block preconditioner (Config.affine_body_block_preconditioner).

def apply_affine_body_preconditioner(indices, inverse, valid, residual, z):
    """apply_affine_body_preconditioner: for every body with a valid 12x12 block (row-major, 144 floats), the four
    state rows of z become M r with r = (r_t, r_a0, r_a1, r_a2); each row is fma(M_rk, r_k, acc) from +0 in k order.
    Other rows of z are left as they are (in place)."""
    r = np.asarray(residual, F)
    for b, ids in enumerate(np.asarray(indices).reshape(-1, 4)):
        if not valid[b]:
            continue
        m = np.asarray(inverse[b], F).reshape(12, 12)
        vec = np.concatenate([r[i] for i in ids])
        out = []
        for row in range(12):
            acc = F(0)
            for k in range(12):
                acc = F(fma(m[row, k], vec[k], acc))
            out.append(acc)
        for slot, i in enumerate(ids):
            z[i] = out[3*slot:3*slot+3]
