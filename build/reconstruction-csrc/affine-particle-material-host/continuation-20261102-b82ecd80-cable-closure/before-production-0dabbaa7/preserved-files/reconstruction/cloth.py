"""Cloth kernels of the legacy solver (Style3D membrane + cotangent bending), transcribed bit-exactly.

Each function mirrors one CUDA kernel of solver_newton.cu; ptxas FFMA contractions follow the sm_120 SASS.
Inputs use Newton's layouts: tri_poses as glm mat2 column-major flat [m00, m10, m01, m11] (numpy [[a, b], [c, d]]
row-major gives the same flat order), edge indices (o0, o1, e0, e1) with cotangents (c0, c1, c2, c3).
"""
import numpy as np

from .numerics import F, fma


def _valid_edges(edges, area):
    e = np.asarray(edges)
    distinct = ((e[:, 0] != e[:, 1]) & (e[:, 0] != e[:, 2]) & (e[:, 0] != e[:, 3]) & (e[:, 1] != e[:, 2])
                & (e[:, 1] != e[:, 3]) & (e[:, 2] != e[:, 3]))
    return (e >= 0).all(axis=1) & distinct & ~(area <= 0)


def bending_weights(cots):
    c0, c1, c2, c3 = (cots[:, i] for i in range(4))
    return (-c0)-c2, (-c1)-c3, c2+c3, c0+c1


def _hinge_vector(x, edges, w1, w2, w3):
    base = x[edges[:, 0]]
    q = fma(w1[:, None], x[edges[:, 1]]-base, F(0))
    q = fma(w2[:, None], x[edges[:, 2]]-base, q)
    return fma(w3[:, None], x[edges[:, 3]]-base, q)


def bending_force_ptx(x, previous, area, cots, edges, properties, inv_dt):
    """evaluate_bending_force: per-edge vertex forces [m, 4, 3] (zero rows for skipped edges).

    q = sum_k w_k (x_k - x_0); F = FFMA(-q, (3/A) kb, damping) with damping = -(3/A) kd ((q - q_prev)/h . n) n.
    """
    edges = np.asarray(edges)
    valid = _valid_edges(edges, area)
    safe = np.where(valid[:, None], edges, 0)
    w0, w1, w2, w3 = bending_weights(cots)
    q = _hinge_vector(x, safe, w1, w2, w3)
    scale = F(3)/np.where(valid, area, F(1))
    stiffness, damping = properties[:, 0], properties[:, 1]
    damp_coef = scale*damping
    damped = damp_coef > 0
    length = np.sqrt(fma(q[:, 2], q[:, 2], fma(q[:, 0], q[:, 0], q[:, 1]*q[:, 1])))
    ok = length > F(1e-12)
    n = np.where(ok[:, None], q/np.where(ok, length, F(1))[:, None], F(0)).astype(F)
    rate = (q-_hinge_vector(previous, safe, w1, w2, w3))*F(inv_dt)
    vn = fma(rate[:, 2], n[:, 2], fma(rate[:, 0], n[:, 0], rate[:, 1]*n[:, 1]))
    damp = np.where(damped[:, None], n*(-(damp_coef*vn))[:, None], F(0)).astype(F)
    total = fma(-q, (scale*stiffness)[:, None], damp)
    out = np.stack([total*w[:, None] for w in (w0, w1, w2, w3)], axis=1).astype(F)
    out[~valid] = 0
    return out, valid


def _norm(v):
    return fma(v[:, 2], v[:, 2], fma(v[:, 0], v[:, 0], v[:, 1]*v[:, 1]))


def _safe_unit(v, length):
    ok = length > 0
    return np.where(ok[:, None], v/np.where(ok, length, F(1))[:, None], F(0)).astype(F)


def _membrane_frame(x, triangles, poses):
    """Deformed warp/weft vectors a, b and per-vertex weights (u, v) of evaluate_stretch_force."""
    p = poses.reshape(-1, 4)
    m0, m1, m2, m3 = p[:, 0], p[:, 1], p[:, 2], p[:, 3]
    x0 = x[triangles[:, 0]]
    e1, e2 = x[triangles[:, 1]]-x0, x[triangles[:, 2]]-x0
    a = fma(e1, m0[:, None], e2*m2[:, None])
    b = fma(e1, m1[:, None], e2*m3[:, None])
    weights = (((-m0)-m2, (-m1)-m3), (m0, m1), (m2, m3))
    return a, b, weights


def stretch_force_ptx(x, area, poses, triangles, stiffness):
    """evaluate_stretch_force: per-triangle vertex forces [t, 3, 3] of the Style3D anisotropic membrane."""
    triangles = np.asarray(triangles)
    a, b, weights = _membrane_frame(x, triangles, poses)
    a2, b2 = _norm(a), _norm(b)
    la, lb = np.sqrt(a2), np.sqrt(b2)
    na, nb = _safe_unit(a, la), _safe_unit(b, lb)
    ea, eb = np.sqrt(a2+F(1e-12)), np.sqrt(b2+F(1e-12))
    aa, bb = a/ea[:, None], b/eb[:, None]
    shear = fma(aa[:, 2], bb[:, 2], fma(aa[:, 0], bb[:, 0], aa[:, 1]*bb[:, 1]))
    # `mul; sub` contracts: bb - aa*shear -> FFMA(-aa, shear, bb).
    da = fma(-aa, shear[:, None], bb)/ea[:, None]
    db = fma(-bb, shear[:, None], aa)/eb[:, None]
    ku, kv, ks = stiffness[:, 0], stiffness[:, 1], stiffness[:, 2]
    ca = ku*(la+F(-1))
    cb = kv*(lb+F(-1))
    cs = ks*shear
    out = np.empty((len(triangles), 3, 3), F)
    for k, (wu, wv) in enumerate(weights):
        ta, tb = wu[:, None]*na, wv[:, None]*nb
        ts = fma(da, wu[:, None], db*wv[:, None])
        total = fma(ts, cs[:, None], fma(ta, ca[:, None], tb*cb[:, None]))
        out[:, k] = total*(-area)[:, None]
    return out


def _stretch_projector(v, length):
    """n n^T + max(0, 1 - 1/|v|) (I - n n^T) as 6 symmetric entries (00, 10, 20, 11, 21, 22); identity if |v| <= 1e-8."""
    ok = length > F(1e-8)
    safe = np.where(ok, length, F(1))
    n = v/safe[:, None]
    c = np.maximum(F(0), F(1)-F(1)/safe)
    pairs = ((0, 0), (1, 0), (2, 0), (1, 1), (2, 1), (2, 2))
    out = []
    for r, k in pairs:
        p = n[:, r]*n[:, k]
        delta = F(1) if r == k else F(0)
        out.append(np.where(ok, fma(delta-p, c, p), delta).astype(F))
    return out


def membrane_gn_blocks_ptx(x, triangles, poses, area, stiffness):
    """add_cloth_membrane_gauss_newton_hessian: blocks [t, i, j, 9] (glm column-major) for vertex pairs (i, j).

    The isotropic part (ku+ks) u_i u_j + (kv+ks) v_i v_j already lives in the host-precomputed constant matrix and
    is subtracted here, so the sum equals the full Gauss-Newton membrane Hessian.
    """
    triangles = np.asarray(triangles)
    a, b, weights = _membrane_frame(x, triangles, poses)
    a2, b2 = _norm(a), _norm(b)
    la, lb = np.sqrt(a2), np.sqrt(b2)
    ea, eb = np.sqrt(a2+F(1e-12)), np.sqrt(b2+F(1e-12))
    aa, bb = a/ea[:, None], b/eb[:, None]
    shear = fma(aa[:, 2], bb[:, 2], fma(aa[:, 0], bb[:, 0], aa[:, 1]*bb[:, 1]))
    da = fma(-aa, shear[:, None], bb)/ea[:, None]
    db = fma(-bb, shear[:, None], aa)/eb[:, None]
    ts = [fma(da, wu[:, None], db*wv[:, None]) for wu, wv in weights]
    qa, qb = _stretch_projector(a, la), _stretch_projector(b, lb)
    sym = (0, 1, 2, 1, 3, 4, 2, 4, 5)  # column-major 3x3 from the 6 symmetric entries
    ku, kv, ks = stiffness[:, 0], stiffness[:, 1], stiffness[:, 2]
    kua, kvb = ku+ks, kv+ks
    out = np.empty((len(triangles), 3, 3, 9), F)
    for i in range(3):
        ui, vi = weights[i]
        for j in range(3):
            uj, vj = weights[j]
            uu, vv = ui*uj, vi*vj
            iso = fma(kua, uu, kvb*vv)
            su, sv = ku*uu, kv*vv
            for e in range(9):
                r, c = e % 3, e//3
                value = fma(su, qa[sym[e]], sv*qb[sym[e]])
                value = fma(ks, ts[i][:, r]*ts[j][:, c], value)
                value = value-iso if r == c else value-iso*F(0)
                out[:, i, j, e] = area*value
    return out


def scatter_membrane_gn(blocks, triangles, diagonal, row_nnz, entries, max_nnz, tile, warp=32):
    """Accumulate blocks like the kernel: same-particle pairs into `diagonal` [n, 9]; others into the ELL entry of
    row i whose column equals j (binary search over the sorted first min(row_nnz, max_nnz) columns), else dropped.

    `entries` is (cols [max_nnz, tile], blocks [max_nnz, tile, 9]). Atomic order follows numerics.element_atomic_add:
    warps descending, then pair (i, j) in kernel order, then lanes ascending.
    """
    cols, ell = entries
    count = len(triangles)
    for start in reversed(range(0, count, warp)):
        lanes = range(start, min(start+warp, count))
        for i in range(3):
            for j in range(3):
                for t in lanes:
                    row, col = triangles[t][i], triangles[t][j]
                    value = blocks[t, i, j]
                    # red.global.add.f32 compiles to REDG...FTZ: subnormals are flushed before accumulation.
                    value = np.where(np.abs(value) < np.finfo(F).tiny, F(0), value).astype(F)
                    if col == row:
                        diagonal[row] = (diagonal[row]+value).astype(F)
                        continue
                    limit = min(int(row_nnz[row]), int(max_nnz))
                    lo, hi = 0, limit
                    while hi > lo:
                        mid = lo+((hi-lo) >> 1)
                        if cols[mid, row] < col:
                            lo = mid+1
                        else:
                            hi = mid
                    if lo < limit and cols[lo, row] == col:
                        ell[lo, row] = (ell[lo, row]+value).astype(F)


def _damped_hinges(edges, area, properties):
    """Hinges processed by the bending-damping kernels: valid stencil, positive area and positive damping."""
    return _valid_edges(edges, area) & ~(properties[:, 1] <= 0)


def _hinge_normal(x, edges, cots):
    w = bending_weights(cots)
    q = _hinge_vector(x, edges, *w[1:])
    length = np.sqrt(fma(q[:, 2], q[:, 2], fma(q[:, 0], q[:, 0], q[:, 1]*q[:, 1])))
    ok = length > F(1e-12)
    return np.where(ok[:, None], q/np.where(ok, length, F(1))[:, None], F(0)).astype(F), w


def bending_damping_preconditioner_ptx(x, area, cots, edges, properties, inv_dt):
    """add_bending_damping_preconditioner: per-hinge vertex blocks [m, 4, 9] = w_k^2 ((kd 3/A)/h) n n^T."""
    edges = np.asarray(edges)
    valid = _damped_hinges(edges, area, properties)
    safe = np.where(valid[:, None], edges, 0)
    n, w = _hinge_normal(x, safe, cots)
    coef = (properties[:, 1]*(F(3)/np.where(valid, area, F(1))))*F(inv_dt)
    nn = [n[:, 0]*n[:, 0], n[:, 1]*n[:, 0], n[:, 2]*n[:, 0], n[:, 1]*n[:, 1], n[:, 2]*n[:, 1], n[:, 2]*n[:, 2]]
    scaled = [coef*v for v in nn]
    out = np.zeros((len(edges), 4, 9), F)
    for k, wk in enumerate(w):
        w2 = wk*wk
        e00, e10, e20, e11, e21, e22 = (s*w2 for s in scaled)
        out[:, k] = np.stack((e00, e10, e20, e10, e11, e21, e20, e21, e22), axis=1)
    out[~valid] = 0
    return out, valid


def bending_damping_tangent_ptx(x, direction, area, cots, edges, properties, inv_dt):
    """multiply_bending_damping_tangent: per-hinge vertex products [m, 4, 3] = w_k ((kd 3/A)/h (dq . n)) n."""
    edges = np.asarray(edges)
    valid = _damped_hinges(edges, area, properties)
    safe = np.where(valid[:, None], edges, 0)
    n, w = _hinge_normal(x, safe, cots)
    dq = _hinge_vector(direction, safe, *w[1:])
    coef = (properties[:, 1]*(F(3)/np.where(valid, area, F(1))))*F(inv_dt)
    vn = fma(dq[:, 2], n[:, 2], fma(dq[:, 0], n[:, 0], dq[:, 1]*n[:, 1]))
    g = (coef*vn)[:, None]*n
    out = np.stack([g*wk[:, None] for wk in w], axis=1).astype(F)
    out[~valid] = 0
    return out, valid
