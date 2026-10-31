"""Readable formulas recovered from _re_analysis/ALGORITHM_ANALYSIS_ZH.md, sections 6–9.

All arrays use float32. Sparse assembly/host reductions intentionally have a
separate implementation from the reference binary; equivalence is measured,
not inferred from the formulas. No extracted PTX or original solver is loaded.
"""
import numpy as np
from scipy import sparse

F = np.float32
I3 = np.eye(3, dtype=F)


def length_tangent(d, rest):
    length = np.linalg.norm(d, axis=-1)
    normal = np.divide(d, length[..., None], out=np.zeros_like(d), where=length[..., None] > 0)
    transverse = np.maximum(F(0), F(1) - np.divide(rest, length, out=np.zeros_like(length), where=length > 0))
    outer = normal[..., :, None] * normal[..., None, :]
    result = outer + transverse[..., None, None] * (I3 - outer)
    result[length <= F(1e-8)] = I3
    return length, normal, result


def spring_terms(x, indices, stiffness, rest):
    d = x[indices[:, 1]] - x[indices[:, 0]]
    length, normal, tangent = length_tangent(d, rest)
    force = stiffness[:, None] * (d - rest[:, None] * normal)
    k = stiffness[:, None, None] * tangent
    # Nonpositive rest length skips only the Newton correction, retaining kI.
    k[rest <= 0] = stiffness[rest <= 0, None, None] * I3
    forces = np.stack((force, -force), axis=1)
    blocks = np.stack((k, -k, -k, k), axis=1).reshape(-1, 2, 2, 3, 3)
    return forces, blocks


def membrane_terms(x, indices, inverse_dm, area, stiffness):
    # Warp exposes row-major mat22; the native GLM load uses flat offsets 0,8 / 4,12.
    uv = np.concatenate((-inverse_dm.sum(axis=1)[:, None, :], inverse_dm), axis=1)
    u, v = uv[:, :, 0], uv[:, :, 1]
    positions = x[indices]
    a = np.einsum('ei,eij->ej', u, positions)
    b = np.einsum('ei,eij->ej', v, positions)
    la, na, qa = length_tangent(a, F(1))
    lb, nb, qb = length_tangent(b, F(1))
    ea = np.sqrt(np.sum(a*a, axis=1) + F(1e-12))
    eb = np.sqrt(np.sum(b*b, axis=1) + F(1e-12))
    aa, bb = a / ea[:, None], b / eb[:, None]
    shear = np.sum(aa*bb, axis=1)
    da = (bb - shear[:, None]*aa) / ea[:, None]
    db = (aa - shear[:, None]*bb) / eb[:, None]
    gs = u[:, :, None]*da[:, None, :] + v[:, :, None]*db[:, None, :]
    ku, kv, ks = (area * stiffness[:, i] for i in range(3))
    forces = -(ku*(la-F(1)))[:, None, None]*u[:, :, None]*na[:, None, :]
    forces -= (kv*(lb-F(1)))[:, None, None]*v[:, :, None]*nb[:, None, :]
    forces -= (ks*shear)[:, None, None]*gs
    blocks = (ku[:, None, None] * u[:, :, None] * u[:, None, :])[..., None, None]*qa[:, None, None, :, :]
    blocks += (kv[:, None, None] * v[:, :, None] * v[:, None, :])[..., None, None]*qb[:, None, None, :, :]
    blocks += ks[:, None, None, None, None]*gs[:, :, None, :, None]*gs[:, None, :, None, :]
    return forces, blocks


def bending_terms(x, previous, indices, cots, area, properties, dt):
    c0, c1, c2, c3 = cots.T
    w = np.stack((-c0-c2, -c1-c3, c2+c3, c0+c1), axis=1)
    q = np.einsum('ei,eij->ej', w, x[indices])
    q0 = np.einsum('ei,eij->ej', w, previous[indices])
    length = np.linalg.norm(q, axis=1)
    n = np.divide(q, length[:, None], out=np.zeros_like(q), where=length[:, None] > F(1e-8))
    scale = F(3)/area
    elastic, damping = properties.T * scale
    force = -elastic[:, None]*q
    force -= (damping/F(dt)*np.sum(n*(q-q0), axis=1))[:, None]*n
    tangent = elastic[:, None, None]*I3 + (damping/F(dt))[:, None, None]*n[:, :, None]*n[:, None, :]
    blocks = (w[:, :, None]*w[:, None, :])[..., None, None]*tangent[:, None, None, :, :]
    return w[:, :, None]*force[:, None, :], blocks


def assemble(n, terms, mass_diagonal):
    force = np.zeros((n, 3), dtype=F)
    rows, columns, values = [], [], []
    dofs = np.arange(n*3)
    rows.append(dofs)
    columns.append(dofs)
    values.append(np.repeat(mass_diagonal, 3))
    for indices, local_force, blocks in terms:
        np.add.at(force, indices.reshape(-1), local_force.reshape(-1, 3))
        d = (indices[:, :, None]*3 + np.arange(3)).reshape(len(indices), -1)
        width = d.shape[1]
        rows.append(np.broadcast_to(d[:, :, None], (len(d), width, width)).reshape(-1))
        columns.append(np.broadcast_to(d[:, None, :], (len(d), width, width)).reshape(-1))
        values.append(blocks.transpose(0, 1, 3, 2, 4).reshape(-1))
    matrix = sparse.coo_matrix((np.concatenate(values), (np.concatenate(rows), np.concatenate(columns))),
                              shape=(n*3, n*3), dtype=F).tocsr()
    return force, matrix


def pcg(matrix, rhs, iterations):
    n = len(rhs)//3
    offsets = np.arange(n)*3
    diagonal = np.empty((n, 3, 3), dtype=F)
    for i in range(3):
        for j in range(3):
            diagonal[:, i, j] = np.asarray(matrix[offsets+i, offsets+j]).reshape(-1)
    diagonal = (diagonal + diagonal.transpose(0, 2, 1))*F(0.5)
    inverse = np.linalg.inv(diagonal)
    def precondition(r):
        return np.einsum('nij,nj->ni', inverse, r.reshape(n, 3)).reshape(-1)
    solution = np.zeros_like(rhs)
    residual = rhs.copy()
    z = precondition(residual)
    direction = z.copy()
    rho = np.dot(residual, z)
    for _ in range(iterations):
        product = matrix @ direction
        denom = np.dot(direction, product)
        alpha = F(rho/denom) if abs(denom) > F(1e-30) else F(0)
        solution += alpha*direction
        residual -= alpha*product
        z = precondition(residual)
        rho_new = np.dot(residual, z)
        beta = F(rho_new/rho) if abs(rho) > F(1e-30) else F(0)
        direction = z + beta*direction
        rho = rho_new
    return solution


def fma(a, b, c):
    """Correctly rounded float32 fused multiply-add (fma.rn.f32).

    The float32 product is exact in x87 extended precision (64-bit mantissa); the extended sum s = p + c is not, so
    its exact error e comes from TwoSum. Rounding s to float32 is then wrong only when s sits exactly on a float32
    midpoint and e != 0 (double rounding): the true value lies beyond the midpoint on the side of e. Example from
    evaluate_body_point_line_force: 0.69999969 * 3 is a float32 tie and the subnormal addend 2.7e-44 decides it."""
    L = np.longdouble
    p = np.asarray(a, L)*np.asarray(b, L)
    c = np.asarray(c, L)
    s = p+c
    r = s.astype(F)
    bb = s-p
    e = (p-(s-bb))+(c-bb)
    if not np.any(e != 0):
        return r
    r = np.array(r, copy=True)
    s_b, e_b, r_b = np.broadcast_arrays(s, e, r)
    flat_r = r.reshape(-1) if r.shape == s_b.shape else np.array(r_b, copy=True).reshape(-1)
    for k in np.flatnonzero((e_b != 0).reshape(-1)):
        sk, ek, rk = s_b.reshape(-1)[k], e_b.reshape(-1)[k], F(flat_r[k])
        d = sk-L(rk)
        if d == 0 or not np.isfinite(rk):
            continue
        neighbour = np.nextafter(rk, F(np.inf) if d > 0 else F(-np.inf))
        if abs(d)*2 == abs(L(neighbour)-L(rk)) and (ek > 0) == (d > 0):
            flat_r[k] = neighbour            # tie broken by the lost low part, away from the even choice
    out = flat_r.reshape(s_b.shape)
    return out if np.ndim(out) else F(out)


def _deformation_columns(x, indices, a):
    """F columns in evaluate_tetrahedron_force order: fma(e3, A[2,j], fma(e1, A[0,j], e2*A[1,j]))."""
    x0 = x[indices[:, 0]]
    e1, e2, e3 = (x[indices[:, k]]-x0 for k in (1, 2, 3))
    return [fma(e3, a[:, 2, j, None], fma(e1, a[:, 0, j, None], e2*a[:, 1, j, None])) for j in range(3)]


def atomic_add_at(target, indices, values):
    """Scatter-add with the semantics of the kernels' red.global.add.f32, which compiles to REDG...FTZ:
    subnormal operands are flushed to zero before accumulation."""
    values = np.where(np.abs(values) < np.finfo(F).tiny, F(0), values).astype(F)
    np.add.at(target, indices, values)


def element_atomic_add(target, indices, values, valid=None, warp=32):
    """Accumulate per-element vertex values like the GPU's red.global.add: within a warp, vertex slot by slot with
    lanes ascending; warps in descending order.

    The legacy kernels are not run-to-run reproducible (10 launches on the same input gave 10 different sums), so no
    order is exact. Descending warp order matched the GPU best and removed a systematic centre-of-mass drift that
    ascending order produced in 300-step free fall (-5.4e-6 m vs a native spread of 4.4e-7 m).
    """
    count = len(indices)
    for start in reversed(range(0, count, warp)):
        lanes = np.arange(start, min(start+warp, count))
        if valid is not None:
            lanes = lanes[valid[lanes]]  # skipped elements issue no atomics at all
        for slot in range(indices.shape[1]):
            atomic_add_at(target, indices[lanes, slot], values[lanes, slot])


def fms(a, b, c, d):
    """a*b - c*d as emitted by ptxas for PTX `mul; mul; sub`: FFMA(a, b, -(c*d)), only c*d rounded."""
    return fma(a, b, -(c*d))


def _cross(u, v):
    return np.stack((fms(u[:, 1], v[:, 2], v[:, 1], u[:, 2]), fms(v[:, 0], u[:, 2], u[:, 0], v[:, 2]),
                     fms(u[:, 0], v[:, 1], v[:, 0], u[:, 1])), axis=1)


def _dot3(u, v):
    return fma(u[:, 2], v[:, 2], fma(u[:, 0], v[:, 0], u[:, 1]*v[:, 1]))


def tetrahedron_force_ptx(x, previous, indices, inverse_dm, volume, materials, activation, inv_dt):
    """Per-vertex tetrahedron forces with the operation order of evaluate_tetrahedron_force.

    The converged Newton state is the float32-rounded root of the residual, so the rounding pattern of
    this force decides which neighbouring float the solve lands on; einsum ordering drifts measurably.
    """
    a = inverse_dm
    c0, c1, c2 = _deformation_columns(x, indices, a)
    k12 = _cross(c1, c2)
    determinant = fma(c0[:, 2], k12[:, 2], fma(c0[:, 0], k12[:, 0], c0[:, 1]*k12[:, 1]))
    mu, lam, damping = materials[:, 0], materials[:, 1], materials[:, 2]
    bulk = mu+lam
    safe = np.where(bulk > 0, bulk, F(1))
    target = np.where(bulk > 0, mu/safe+F(1), F(1)).astype(F)
    scale = bulk*(activation+(determinant-target))
    # Cofactor columns: c1 x c2, c2 x c0, c0 x c1 (component products rounded before the scale multiply).
    k20 = np.stack((fms(c2[:, 1], c0[:, 2], c0[:, 1], c2[:, 2]), fms(c0[:, 0], c2[:, 2], c2[:, 0], c0[:, 2]),
                    fms(c2[:, 0], c0[:, 1], c0[:, 0], c2[:, 1])), axis=1)
    k01 = np.stack((fms(c0[:, 1], c1[:, 2], c1[:, 1], c0[:, 2]), fms(c1[:, 0], c0[:, 2], c0[:, 0], c1[:, 2]),
                    fms(c0[:, 0], c1[:, 1], c1[:, 0], c0[:, 1])), axis=1)
    p0 = fma(mu[:, None], c0, k12*scale[:, None])
    p1 = fma(mu[:, None], c1, k20*scale[:, None])
    p2 = fma(mu[:, None], c2, k01*scale[:, None])
    damped = damping > 0
    g00 = g01 = g02 = g11 = g12 = g22 = np.zeros(len(a), F)
    if np.any(damped):
        r0, r1, r2 = _deformation_columns(previous, indices, a)
        def rate(u, v, w, z):
            return _dot3(u, v)-_dot3(w, z)
        d00, d01, d02 = rate(c0, c0, r0, r0), rate(c0, c1, r0, r1), rate(c0, c2, r0, r2)
        d11, d12, d22 = rate(c1, c1, r1, r1), rate(c1, c2, r1, r2), rate(c2, c2, r2, r2)
        g00, g11, g22 = d00*inv_dt, d11*inv_dt, d22*inv_dt
        # Off-diagonal entries appear twice in the symmetric contraction; the kernel folds that into one fma.
        g01, g02, g12 = (fma(d, inv_dt, d*inv_dt) for d in (d01, d02, d12))
        g00, g01, g02, g11, g12, g22 = (np.where(damped, g, F(0)).astype(F) for g in (g00, g01, g02, g11, g12, g22))
    weight = damping*volume
    neg_volume = -volume
    gradients = [(-a[:, 0, j]-a[:, 1, j])-a[:, 2, j] for j in range(3)]
    gradients = [gradients] + [[a[:, k, j] for j in range(3)] for k in range(3)]
    forces = np.empty((len(a), 4, 3), F)
    for vertex, (h0, h1, h2) in enumerate(gradients):
        h0, h1, h2 = h0[:, None], h1[:, None], h2[:, None]
        force = fma(p2, h2, fma(p0, h0, p1*h1))*neg_volume[:, None]
        if np.any(damped):
            t00 = c0*(h0+h0)
            t01 = fma(c1, h0, c0*h1)
            t02 = fma(c2, h0, c0*h2)
            t11 = c1*(h1+h1)
            t12 = fma(c2, h1, c1*h2)
            t22 = c2*(h2+h2)
            total = fma(g00[:, None], t00, g01[:, None]*t01)
            for g, t in ((g02, t02), (g11, t11), (g12, t12), (g22, t22)):
                total = fma(g[:, None], t, total)
            # `mul; sub` contracts to FFMA(-damping*volume, total, elastic).
            force = np.where(damped[:, None], fma(-weight[:, None], total, force), force).astype(F)
        forces[:, vertex] = force
    return forces



def _vertex_gradients(a):
    """Rows of the shape-function gradient per vertex; vertex 0 is ((-A0 - A1) - A2) as in the kernels."""
    first = [(-a[:, 0, j]-a[:, 1, j])-a[:, 2, j] for j in range(3)]
    return [first] + [[a[:, k, j] for j in range(3)] for k in range(3)]


def _damping_basis(c0, c1, c2, h0, h1, h2):
    """d(F_a . F_b)/dx for one vertex, in kernel order: t00, t01, t02, t11, t12, t22."""
    return (c0*(h0+h0), fma(c1, h0, c0*h1), fma(c2, h0, c0*h2), c1*(h1+h1), fma(c2, h1, c1*h2), c2*(h2+h2))


def tetrahedron_tangent_ptx(x, direction, indices, inverse_dm, materials, volume, inv_dt):
    """Per-vertex K*p of multiply_tetrahedron_tangent (matrix-free tangent used inside every PCG iteration).

    Elastic part: vol * (dP g) with dP = mu*dF + (mu+lam)*(cof(F):dF)*cof(F); damping part is the Gauss-Newton
    strain-rate term (damping*vol/h) * sum_ab dS_ab t_ab, where dS uses F and dF.
    """
    a = inverse_dm
    c0, c1, c2 = _deformation_columns(x, indices, a)
    d0, d1, d2 = _deformation_columns(direction, indices, a)
    k12, k20, k01 = _cross(c1, c2), _cross(c2, c0), _cross(c0, c1)
    mu, lam, damping = materials[:, 0], materials[:, 1], materials[:, 2]
    bulk = mu+lam
    dj = _dot3_k(k01, d2)+(_dot3_k(k12, d0)+_dot3_k(k20, d1))
    scale = bulk*dj
    dp0 = fma(mu[:, None], d0, k12*scale[:, None])
    dp1 = fma(mu[:, None], d1, k20*scale[:, None])
    dp2 = fma(mu[:, None], d2, k01*scale[:, None])
    damped = damping > 0
    s00 = _dot3(c0, d0); s00 = s00+s00
    s01 = _dot3(c1, d0)+_dot3(c0, d1); s01 = s01+s01
    s02 = _dot3(c2, d0)+_dot3(c0, d2); s02 = s02+s02
    s11 = _dot3(c1, d1); s11 = s11+s11
    s12 = _dot3(c2, d1)+_dot3(c1, d2); s12 = s12+s12
    s22 = _dot3(c2, d2); s22 = s22+s22
    weight = (damping*volume)*inv_dt
    out = np.empty((len(a), 4, 3), F)
    for vertex, (h0, h1, h2) in enumerate(_vertex_gradients(a)):
        h0, h1, h2 = h0[:, None], h1[:, None], h2[:, None]
        value = volume[:, None]*fma(dp2, h2, fma(dp0, h0, dp1*h1))
        if np.any(damped):
            t00, t01, t02, t11, t12, t22 = _damping_basis(c0, c1, c2, h0, h1, h2)
            total = fma(s00[:, None], t00, s01[:, None]*t01)
            for g, t in ((s02, t02), (s11, t11), (s12, t12), (s22, t22)):
                total = fma(g[:, None], t, total)
            value = np.where(damped[:, None], fma(weight[:, None], total, value), value).astype(F)
        out[:, vertex] = value
    return out



# Symmetric 3x3 entries in kernel order (row-major lower triangle); off-diagonals are mirrored on store.
_SYM = ((0, 0), (1, 0), (2, 0), (1, 1), (2, 1), (2, 2))


def _sym_to_mat(entries):
    e00, e10, e20, e11, e21, e22 = entries
    return np.stack((e00, e10, e20, e10, e11, e21, e20, e21, e22), axis=1).reshape(-1, 3, 3)


def tetrahedron_preconditioner_ptx(x, indices, inverse_dm, materials, volume, inv_dt):
    """Per-vertex 3x3 diagonal blocks of add_tetrahedron_preconditioner (added only to the preconditioner)."""
    a = inverse_dm
    c0, c1, c2 = _deformation_columns(x, indices, a)
    k12, k20, k01 = _cross(c1, c2), _cross(c2, c0), _cross(c0, c1)
    mu, lam, damping = materials[:, 0], materials[:, 1], materials[:, 2]
    w_mu = mu*volume
    w_bulk = (mu+lam)*volume
    w_damp = (damping*volume)*inv_dt
    damped = damping > 0
    zero = F(0)
    out = np.empty((len(a), 4, 3, 3), F)
    for vertex, (h0, h1, h2) in enumerate(_vertex_gradients(a)):
        cg = fma(k01, h2[:, None], fma(k12, h0[:, None], k20*h1[:, None]))
        gg = fma(h2, h2, fma(h0, h0, h1*h1))
        iso = w_mu*gg
        products = [cg[:, i]*cg[:, j] for i, j in _SYM]
        entries = [fma(w_bulk, prod, iso) if i == j else fma(iso, zero, w_bulk*prod)
                   for (i, j), prod in zip(_SYM, products)]
        if np.any(damped):
            t00, t01, t02, t11, t12, t22 = _damping_basis(c0, c1, c2, h0[:, None], h1[:, None], h2[:, None])
            sums = []
            for i, j in _SYM:
                acc = fma(t01[:, i], t01[:, j], t01[:, i]*t01[:, j])
                acc = fma(t00[:, i], t00[:, j], acc)
                acc = fma(t02[:, i]*t02[:, j], F(2), acc)
                acc = fma(t11[:, i], t11[:, j], acc)
                acc = fma(t12[:, i]*t12[:, j], F(2), acc)
                acc = fma(t22[:, i], t22[:, j], acc)
                sums.append(acc)
            entries = [np.where(damped, fma(w_damp, total, e), e).astype(F) for e, total in zip(entries, sums)]
        out[:, vertex] = _sym_to_mat(entries)
    return out

def _dot3_k(k, d):
    """Cofactor-column . dF-column with the y product leading: fma(kz, dz, fma(kx, dx, ky*dy))."""
    return fma(k[:, 2], d[:, 2], fma(k[:, 0], d[:, 0], k[:, 1]*d[:, 1]))

def tetrahedron_terms(x, previous, indices, inverse_dm, volume, materials, activation, dt):
    """Polynomial volume stress and strain-rate damping, with the recovered GN tangent."""
    g = np.concatenate((-inverse_dm.sum(axis=1)[:, None, :], inverse_dm), axis=1)
    deformation = np.einsum('eia,eib->eab', x[indices[:, 1:]]-x[indices[:, :1]], inverse_dm)
    reference = np.einsum('eia,eib->eab', previous[indices[:, 1:]]-previous[indices[:, :1]], inverse_dm)
    a, b, c = (deformation[:, :, i] for i in range(3))
    cof = np.stack((np.cross(b, c), np.cross(c, a), np.cross(a, b)), axis=2)
    determinant = np.sum(a*cof[:, :, 0], axis=1)
    mu, lam, damping = materials.T
    bulk = mu+lam
    target = F(1)+np.divide(mu, bulk, out=np.zeros_like(mu), where=bulk > 0)
    stress = mu[:, None, None]*deformation + (bulk*(determinant-target+activation))[:, None, None]*cof
    strain_delta = (deformation.transpose(0, 2, 1)@deformation-reference.transpose(0, 2, 1)@reference)/F(dt)
    stress += (F(2)*damping)[:, None, None]*(deformation@strain_delta)
    forces = tetrahedron_force_ptx(x, previous, indices, inverse_dm, volume, materials, activation, F(1)/F(dt))
    gram = np.einsum('eia,eja->eij', g, g)
    cg = np.einsum('eab,eib->eia', cof, g)
    fg = np.einsum('eab,eib->eia', deformation, g)
    blocks = (mu[:, None, None]*gram)[..., None, None]*I3
    blocks += bulk[:, None, None, None, None]*cg[:, :, None, :, None]*cg[:, None, :, None, :]
    fft = deformation@deformation.transpose(0, 2, 1)
    damping_blocks = fg[:, None, :, :, None]*fg[:, :, None, None, :] + gram[..., None, None]*fft[:, None, None, :, :]
    blocks += (F(2)*damping/F(dt))[:, None, None, None, None]*damping_blocks
    blocks *= volume[:, None, None, None, None]
    return forces, blocks
