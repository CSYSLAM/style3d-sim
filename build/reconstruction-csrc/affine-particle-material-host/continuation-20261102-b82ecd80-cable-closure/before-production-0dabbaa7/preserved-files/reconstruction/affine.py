"""Affine bodies (ABD) of the legacy solver, transcribed from the sm_52 PTX (checked against the sm_120 SASS).

The wrapper (style3d_sim.NewtonSolver) represents each affine body by four state "particles" given by
affine_body_indices (x, y, z, w): the translation q[x] and the three columns of the affine matrix A = [q[y] q[z] q[w]].
The SO(3) augmented-Lagrangian rigidity keeps A close to a rotation R with multiplier matrix Lambda.
"""
import numpy as np

from .numerics import F, fma, fms

POLAR_ITERATIONS = 8      # Newton steps X <- (X + cof(X)/det X)/2, in pairs, each guarded by |det X| > 1e-10
DET_EPS = F(np.frombuffer(np.uint32(0x2EDBE6FF).tobytes(), F)[0])   # 1e-10
TINY = F(1e-8)


def _cross(u, v):
    """u x v with ptxas' minuend-fused mul;mul;sub (numerics.fms)."""
    return [fms(u[1], v[2], u[2], v[1]), fms(u[2], v[0], u[0], v[2]), fms(u[0], v[1], u[1], v[0])]


def _dot(u, v):
    return F(fma(u[2], v[2], fma(u[0], v[0], F(u[1]*v[1]))))


def _normalize(v):
    length = F(np.sqrt(_dot(v, v)))
    if not length > 0:
        return [F(0)]*3
    return [F(c/length) for c in v]


def nearest_rotation(a, b, c):
    """Rotation columns closest to A = [a b c] as in initialize_affine_body_so3_state (scalar float32)."""
    a, b, c = ([F(v) for v in col] for col in (a, b, c))
    norm2 = F(F(_dot(a, a)+_dot(b, b))+_dot(c, c))
    scale = F(np.sqrt(F(norm2/F(3))))
    identity = ([F(1), F(0), F(0)], [F(0), F(1), F(0)], [F(0), F(0), F(1)])
    if not scale > TINY or not abs(scale) < np.inf:
        return identity
    inv = F(F(1)/scale)
    a, b, c = ([F(v*inv) for v in col] for col in (a, b, c))
    for _ in range(POLAR_ITERATIONS):
        bc = _cross(b, c)
        det = F(fma(a[2], bc[2], fma(a[0], bc[0], F(a[1]*bc[1]))))
        if not (abs(det) > DET_EPS) or not abs(det) < np.inf:
            break
        r = F(F(1)/det)
        ca, ab = _cross(c, a), _cross(a, b)
        a, b, c = ([F(F(fma(cof[k], r, col[k]))*F(0.5)) for k in range(3)]
                   for cof, col in ((bc, a), (ca, b), (ab, c)))
    n0 = _normalize(a)
    proj = _dot(b, n0)
    n1 = _normalize([F(fma(-proj, n0[k], b[k])) for k in range(3)])
    if not F(np.sqrt(_dot(n0, n0))) > TINY:
        return identity
    if not F(np.sqrt(_dot(n1, n1))) > TINY:
        return identity
    n2 = _normalize(_cross(n0, n1))
    if _dot(c, n2) < 0:
        n1, n2 = [-v for v in n1], [-v for v in n2]
    return n0, n1, n2


def initialize_so3_state(q, indices):
    """initialize_affine_body_so3_state: per body R (glm column-major mat3) and a zero multiplier matrix."""
    rotation = np.zeros((len(indices), 9), F)
    for k, (_, y, z, w) in enumerate(np.asarray(indices)):
        cols = nearest_rotation(q[y], q[z], q[w])
        rotation[k] = np.concatenate(cols)
    return rotation, np.zeros((len(indices), 9), F)


def _columns(m):
    m = np.asarray(m, F)
    return m[0:3], m[3:6], m[6:9]


def so3_force(q, indices, weight, rotation, multiplier, alpha, force):
    """evaluate_affine_body_so3_augmented_lagrangian_force: with G_j = (a_j - r_j) + lambda_j, S_jk = G_j . r_k and
    Y = (S + S^T)/2, column j receives -(w alpha) (R Y)_j; the translation receives +0 (red.add of 0)."""
    zero3 = np.zeros(3, F)
    for k, (x, y, z, w) in enumerate(np.asarray(indices)):
        r = _columns(rotation[k])
        lam = _columns(multiplier[k])
        g = [F_vec(F_vec(q[p]-r[j])+lam[j]) for j, p in enumerate((y, z, w))]
        s = [[_dot(g[j], r[i]) for i in range(3)] for j in range(3)]
        y00, y01, y02 = (F(F(s[0][0]+s[0][0])*F(0.5)), F(F(s[0][1]+s[1][0])*F(0.5)), F(F(s[0][2]+s[2][0])*F(0.5)))
        y11, y12, y22 = (F(F(s[1][1]+s[1][1])*F(0.5)), F(F(s[1][2]+s[2][1])*F(0.5)), F(F(s[2][2]+s[2][2])*F(0.5)))
        out = [[F(fma(c2, r[2][e], fma(c0, r[0][e], F(c1*r[1][e])))) for e in range(3)]
               for c0, c1, c2 in ((y00, y01, y02), (y01, y11, y12), (y02, y12, y22))]
        scale = -F(F(weight[k])*F(alpha))
        _red_add(force, x, zero3)
        for j, p in enumerate((y, z, w)):
            _red_add(force, p, [F(v*scale) for v in out[j]])


def F_vec(v):
    return np.asarray(v, F)


def _red_add(target, index, values):
    """red.global.add.f32 (REDG...FTZ): subnormal addends are flushed to zero."""
    for c, value in enumerate(values):
        value = F(value)
        if abs(value) < np.finfo(F).tiny:
            value = F(0)
        target[index, c] = F(target[index, c]+value)


def _sym_project(cols, r):
    """R sym(S) with S_jk = cols_j . r_k, in the PTX's operation order (shared by the force and the tangent)."""
    s = [[_dot(cols[j], r[i]) for i in range(3)] for j in range(3)]
    y00, y01, y02 = (F(F(s[0][0]+s[0][0])*F(0.5)), F(F(s[0][1]+s[1][0])*F(0.5)), F(F(s[0][2]+s[2][0])*F(0.5)))
    y11, y12, y22 = (F(F(s[1][1]+s[1][1])*F(0.5)), F(F(s[1][2]+s[2][1])*F(0.5)), F(F(s[2][2]+s[2][2])*F(0.5)))
    return [[F(fma(c2, r[2][e], fma(c0, r[0][e], F(c1*r[1][e])))) for e in range(3)]
            for c0, c1, c2 in ((y00, y01, y02), (y01, y11, y12), (y02, y12, y22))]


def so3_tangent(direction, indices, weight, rotation, alpha, product):
    """multiply_affine_body_so3_augmented_lagrangian_tangent: column j += (w alpha) (R sym(R^T D))_j."""
    for k, (_, y, z, w) in enumerate(np.asarray(indices)):
        r = _columns(rotation[k])
        out = _sym_project([direction[y], direction[z], direction[w]], r)
        scale = F(F(weight[k])*F(alpha))
        for j, p in enumerate((y, z, w)):
            _red_add(product, p, [F(scale*v) for v in out[j]])


def so3_preconditioner(indices, weight, rotation, alpha, precond):
    """add_affine_body_so3_augmented_lagrangian_preconditioner: the 3x3 diagonal blocks of the tangent operator,
    i.e. the tangent applied to unit directions (e_c in column j, zero elsewhere); block column c = response."""
    zero = np.zeros(3, F)
    for k, (_, y, z, w) in enumerate(np.asarray(indices)):
        r = _columns(rotation[k])
        scale = F(F(weight[k])*F(alpha))
        for j, p in enumerate((y, z, w)):
            block = np.zeros(9, F)
            for c in range(3):
                unit = np.zeros(3, F)
                unit[c] = F(1)
                cols = [unit if i == j else zero for i in range(3)]
                out = _sym_project(cols, r)[j]
                block[3*c:3*c+3] = [F(scale*v) for v in out]
            _red_add(precond, p, block)


def update_so3_state(q, indices, rotation, multiplier, update_multiplier):
    """update_affine_body_so3_augmented_lagrangian_state (in place): B = A + Lambda, R = nearest_rotation(B), and when
    update_multiplier: Lambda = R sym(R^T (B - R))."""
    for k, (_, y, z, w) in enumerate(np.asarray(indices)):
        lam = _columns(multiplier[k])
        b = [F_vec(q[p]+lam[j]) for j, p in enumerate((y, z, w))]
        r = [F_vec(c) for c in nearest_rotation(*b)]
        rotation[k] = np.concatenate(r)
        if update_multiplier:
            e = [F_vec(b[j]-r[j]) for j in range(3)]
            multiplier[k] = np.concatenate(_sym_project(e, r))


SQRT2 = F(np.frombuffer(np.uint32(0x3FB504F3).tobytes(), F)[0])
UNIT_SNAP = F(np.frombuffer(np.uint32(0x35800000).tobytes(), F)[0])    # 2^-20: |len - 1| below this is no strain
DIAG_SNAP = F(np.frombuffer(np.uint32(0x35B504F3).tobytes(), F)[0])    # sqrt(2) 2^-20


def _six_spring(v, k, rest, snap):
    """Force of one column spring: (v (k e)) / |v| with e = |v| - rest (0 when |e| <= snap or |v| <= 0)."""
    length = F(np.sqrt(fma(v[2], v[2], fma(v[1], v[1], F(v[0]*v[0])))))
    if not length > 0:
        return np.zeros(3, F)
    e = F(length+F(-rest))
    if abs(e) <= snap:
        e = F(0)
    ke = F(k*e)
    return np.array([F(F(c*ke)/length) for c in v], F)


def six_spring_force(q, indices, weight, alpha, force):
    """evaluate_affine_body_spring_force (SIX_SPRINGS rigidity): springs on the columns a0, a1, a2 (rest 1) and on
    a1 - a0, a2 - a0, a2 - a1 (rest sqrt 2), stiffness weight * alpha. Columns receive
    F0 = f20 + (f10 + (0 - fa0)), F1 = f21 + ((0 - fa1) - f10), F2 = ((0 - fa2) - f20) - f21; the translation gets +0."""
    from .rigid_contact import _Ops
    ops = _Ops()
    for b, ids in enumerate(np.asarray(indices).reshape(-1, 4)):
        k = F(F(weight[b])*F(alpha))
        a0, a1, a2 = (np.asarray(q[i], F) for i in ids[1:])
        fa0, fa1, fa2 = (_six_spring(a, k, F(1), UNIT_SNAP) for a in (a0, a1, a2))
        f10 = _six_spring((a1-a0).astype(F), k, SQRT2, DIAG_SNAP)
        f20 = _six_spring((a2-a0).astype(F), k, SQRT2, DIAG_SNAP)
        f21 = _six_spring((a2-a1).astype(F), k, SQRT2, DIAG_SNAP)
        zero = np.zeros(3, F)
        c0 = ((f20+((f10+((zero-fa0).astype(F))).astype(F))).astype(F))
        c1 = ((f21+(((zero-fa1).astype(F)-f10).astype(F))).astype(F))
        c2 = ((((zero-fa2).astype(F)-f20).astype(F)-f21).astype(F))
        for slot, value in enumerate((zero, c0, c1, c2)):
            for e in range(3):
                ops.add(b, slot, force, ids[slot], e, value[e])
    ops.apply()

TINY = F(np.frombuffer(np.uint32(0x322BCC77).tobytes(), F)[0])          # 1e-8


def _spring_correction(v, k, column):
    """k (M - I) with M = nn^T + s (I - nn^T): column springs s = max(0, 1 - rcp|v|), column differences
    s = max(0, (-sqrt2/|v|) + 1); M = I for |v| <= 1e-8 (|v| y first). Row-major 9 values."""
    length = F(np.sqrt(fma(v[2], v[2], fma(v[0], v[0], F(v[1]*v[1])))))
    if length <= TINY:
        m00 = m11 = m22 = F(1)
        m01 = m02 = m12 = F(0)
    else:
        n = [F(c/length) for c in v]
        nn = [F(n[0]*n[0]), F(n[1]*n[0]), F(n[2]*n[0]), F(n[1]*n[1]), F(n[2]*n[1]), F(n[2]*n[2])]
        scale = F(F(1)-F(F(1)/length)) if column else F(F(-SQRT2/length)+F(1))
        scale = max(F(0), scale)
        eye = [F(1), F(0), F(0), F(1), F(0), F(1)]
        m00, m01, m02, m11, m12, m22 = (F(fma(F(e-a), scale, a)) for e, a in zip(eye, nn))
    return [F(k*F(m00+F(-1))), F(k*m01), F(k*m02), F(k*m01), F(k*F(m11+F(-1))), F(k*m12), F(k*m02), F(k*m12),
            F(k*F(m22+F(-1)))]


def _ell_add(ell, r, col, block):
    """Lower-bound search over min(row_nnz, max_nnz) slot columns of row r; add when the column matches."""
    row_nnz, cols, blocks, max_nnz = ell
    count = min(int(row_nnz[r]), int(max_nnz))
    lo, hi = 0, count
    while hi > lo:
        mid = (hi-lo)//2+lo
        if cols[mid, r] < col:
            lo = mid+1
        else:
            hi = mid
    if lo < count and cols[lo, r] == col:
        for e in range(9):
            blocks[lo, r, e] = _red_value(blocks[lo, r, e], block[e])


def _red_value(target, value):
    value = F(value)
    if abs(value) < np.finfo(F).tiny:
        value = F(0)
    return F(target+value)


def six_spring_hessian(q, indices, weight, alpha, diagonal, ell):
    """add_affine_body_spring_gauss_newton_hessian: per body (one thread, program order) the column springs into
    the column diagonals, then for (c0, c1), (c0, c2), (c1, c2) (skipped when k <= 0): K into both diagonals and
    -K into (ci, cj) and (cj, ci) (diagonal when equal, else the ELL slot)."""
    for b, ids in enumerate(np.asarray(indices).reshape(-1, 4)):
        k = F(F(weight[b])*F(alpha))
        cols_ = [int(i) for i in ids[1:]]
        for c in cols_:
            block = _spring_correction(np.asarray(q[c], F), k, True)
            for e in range(9):
                diagonal[c, e] = _red_value(diagonal[c, e], block[e])
        if not k > 0:
            continue
        for i, j in ((0, 1), (0, 2), (1, 2)):
            ci, cj = cols_[i], cols_[j]
            block = _spring_correction((np.asarray(q[cj], F)-np.asarray(q[ci], F)).astype(F), k, False)
            for target in (ci, cj):
                for e in range(9):
                    diagonal[target, e] = _red_value(diagonal[target, e], block[e])
            neg = [F(-v) for v in block]
            for r, col in ((ci, cj), (cj, ci)):
                if r == col:
                    for e in range(9):
                        diagonal[r, e] = _red_value(diagonal[r, e], neg[e])
                else:
                    _ell_add(ell, r, col, neg)

CO_ROTATED, ABD_ORTHOGONALITY = 0, 1


def _constitutive_columns(a0, a1, a2, model):
    """Column gradients G_j of evaluate_affine_body_constitutive_force (before the -weight*alpha scale).

    CO_ROTATED: R = nearest_rotation(A), S_ij = r_i . a_j, P = (S + S^T - 2 I) + (tr S - 3) I, G = R P.
    ABD_ORTHOGONALITY: B = A A^T, C = B - I, G = C A. Products and sums in the kernel's order."""
    if model == ABD_ORTHOGONALITY:
        def row(i, j):   # (A A^T)_ij: column 1 product first, then columns 0 and 2 (fma)
            return F(fma(a2[i], a2[j], fma(a0[i], a0[j], F(a1[i]*a1[j]))))
        b00, b01, b02, b11, b12, b22 = row(0, 0), row(0, 1), row(0, 2), row(1, 1), row(1, 2), row(2, 2)
        c00, c11, c22 = F(b00+F(-1)), F(b11+F(-1)), F(b22+F(-1))
        out = []
        for a in (a0, a1, a2):
            gx = F(fma(b02, a[2], fma(c00, a[0], F(b01*a[1]))))
            gy = F(fma(b12, a[2], fma(b01, a[0], F(c11*a[1]))))
            gz = F(fma(c22, a[2], fma(b02, a[0], F(b12*a[1]))))
            out.append(np.array([gx, gy, gz], F))
        return out
    n0, n1, n2 = nearest_rotation(a0, a1, a2)

    def dot_x(r, a):     # x first
        return F(fma(r[2], a[2], fma(r[1], a[1], F(r[0]*a[0]))))
    s = [[dot_x(r, a) for a in (a0, a1, a2)] for r in (n0, n1, n2)]   # s[i][j] = r_i . a_j
    e00, e11, e22 = F(F(s[0][0]+s[0][0])+F(-2)), F(F(s[1][1]+s[1][1])+F(-2)), F(F(s[2][2]+s[2][2])+F(-2))
    e10, e20, e21 = F(s[1][0]+s[0][1]), F(s[2][0]+s[0][2]), F(s[2][1]+s[1][2])
    tr = F(F(s[2][2]+F(s[1][1]+s[0][0]))+F(-3))
    p00, p11, p22 = F(e00+tr), F(e11+tr), F(e22+tr)
    p10, p20, p21 = F(fma(tr, F(0), e10)), F(fma(tr, F(0), e20)), F(fma(tr, F(0), e21))
    g0 = [F(fma(n2[k], p20, fma(n0[k], p00, F(n1[k]*p10)))) for k in range(3)]
    g1 = [F(fma(n2[k], p21, fma(n1[k], p11, F(n0[k]*p10)))) for k in range(3)]
    g2 = [F(fma(n2[k], p22, fma(n0[k], p20, F(n1[k]*p21)))) for k in range(3)]
    return [np.array(g, F) for g in (g0, g1, g2)]


def constitutive_force(q, indices, weight, alpha, model, force):
    """evaluate_affine_body_constitutive_force (CO_ROTATED / ABD_ORTHOGONALITY rigidity): with s = weight alpha the
    translation receives s (-0) and column j receives G_j (-s)."""
    from .rigid_contact import _Ops
    ops = _Ops()
    for b, ids in enumerate(np.asarray(indices).reshape(-1, 4)):
        a0, a1, a2 = ([F(v) for v in q[i]] for i in ids[1:])
        g = _constitutive_columns(a0, a1, a2, model)
        sc = F(F(weight[b])*F(alpha))
        for e in range(3):
            ops.add(b, 0, force, ids[0], e, F(sc*F(-0.0)))
        for j in range(3):
            for e in range(3):
                ops.add(b, j+1, force, ids[j+1], e, F(g[j][e]*F(-sc)))
    ops.apply()

def _constitutive_tangent_columns(a0, a1, a2, d0, d1, d2, model):
    """Column products of multiply_affine_body_constitutive_tangent (before the weight*alpha scale).

    CO_ROTATED: T_ij = r_i . d_j (y first), P = (T + T^T) + tr(T) I, G = R P (force order).
    ABD_ORTHOGONALITY: M = A D^T (column 1 product first), Y = M + M^T, G = Y A."""
    if model == ABD_ORTHOGONALITY:
        a, dd = (a0, a1, a2), (d0, d1, d2)

        def m(i, j):
            return F(fma(a[2][i], dd[2][j], fma(a[0][i], dd[0][j], F(a[1][i]*dd[1][j]))))
        y00, y11, y22 = F(m(0, 0)+m(0, 0)), F(m(1, 1)+m(1, 1)), F(m(2, 2)+m(2, 2))
        y01, y02, y12 = F(m(1, 0)+m(0, 1)), F(m(2, 0)+m(0, 2)), F(m(2, 1)+m(1, 2))
        out = []
        for col in a:
            gx = F(fma(y02, col[2], fma(y00, col[0], F(y01*col[1]))))
            gy = F(fma(y12, col[2], fma(y01, col[0], F(y11*col[1]))))
            gz = F(fma(y22, col[2], fma(y02, col[0], F(y12*col[1]))))
            out.append(np.array([gx, gy, gz], F))
        return out
    n0, n1, n2 = nearest_rotation(a0, a1, a2)
    t = [[_dot(r, dj) for dj in (d0, d1, d2)] for r in (n0, n1, n2)]   # y first
    e00, e11, e22 = F(t[0][0]+t[0][0]), F(t[1][1]+t[1][1]), F(t[2][2]+t[2][2])
    e10, e20, e21 = F(t[1][0]+t[0][1]), F(t[2][0]+t[0][2]), F(t[2][1]+t[1][2])
    tr = F(F(t[0][0]+t[1][1])+t[2][2])
    p00, p11, p22 = F(e00+tr), F(e11+tr), F(e22+tr)
    p10, p20, p21 = F(fma(tr, F(0), e10)), F(fma(tr, F(0), e20)), F(fma(tr, F(0), e21))
    g0 = [F(fma(n2[k], p20, fma(n0[k], p00, F(n1[k]*p10)))) for k in range(3)]
    g1 = [F(fma(n2[k], p21, fma(n1[k], p11, F(n0[k]*p10)))) for k in range(3)]
    g2 = [F(fma(n2[k], p22, fma(n0[k], p20, F(n1[k]*p21)))) for k in range(3)]
    return [np.array(g, F) for g in (g0, g1, g2)]


def constitutive_tangent(q, direction, indices, weight, alpha, model, product):
    """multiply_affine_body_constitutive_tangent: translation += s 0, column j += s G_j (s = weight alpha)."""
    from .rigid_contact import _Ops
    ops = _Ops()
    for b, ids in enumerate(np.asarray(indices).reshape(-1, 4)):
        a0, a1, a2 = ([F(v) for v in q[i]] for i in ids[1:])
        d0, d1, d2 = ([F(v) for v in direction[i]] for i in ids[1:])
        g = _constitutive_tangent_columns(a0, a1, a2, d0, d1, d2, model)
        sc = F(F(weight[b])*F(alpha))
        for e in range(3):
            ops.add(b, 0, product, ids[0], e, F(sc*F(0)))
        for j in range(3):
            for e in range(3):
                ops.add(b, j+1, product, ids[j+1], e, F(sc*g[j][e]))
    ops.apply()

def constitutive_preconditioner(q, indices, weight, alpha, model, block):
    """add_affine_body_constitutive_preconditioner: the diagonal block of each column particle, probed with the
    tangent on unit directions (column k of the block = s G at that particle for e_k); the translation gets s 0."""
    from .rigid_contact import _Ops
    ops = _Ops()
    zero = [F(0)]*3
    for b, ids in enumerate(np.asarray(indices).reshape(-1, 4)):
        a0, a1, a2 = ([F(v) for v in q[i]] for i in ids[1:])
        sc = F(F(weight[b])*F(alpha))
        for e in range(9):
            ops.add(b, 0, block, ids[0], e, F(sc*F(0)))
        for j in range(3):
            cols = []
            for k in range(3):
                d = [list(zero), list(zero), list(zero)]
                d[j][k] = F(1)
                cols.append(_constitutive_tangent_columns(a0, a1, a2, *d, model)[j])
            values = [F(sc*cols[k][r]) for k in range(3) for r in range(3)]
            for e in range(9):
                ops.add(b, j+1, block, ids[j+1], e, values[e])
    ops.apply()

TORQUE_EPS = F(np.frombuffer(np.uint32(0x2B8CBCCC).tobytes(), F)[0])   # 1e-12
DET_TINY = F(np.frombuffer(np.uint32(0x0DA24260).tobytes(), F)[0])     # 1e-30


def apply_affine_body_torques(q, indices, inertia, torque, force, sub=fms):
    """apply_affine_body_torques: with K = (tr J / 2) I - J (J the body inertia), M = A K, N = A M^T (column 1
    product first) and E = tr(N) I - N, omega = E^-1 tau (cofactors, skipped for det <= 1e-30 or non-finite
    results; bodies with |tau_i| <= 1e-12 everywhere are skipped); column j += omega x M_j, translation += 0."""
    from .rigid_contact import _Ops
    ops = _Ops()
    for b, ids in enumerate(np.asarray(indices).reshape(-1, 4)):
        tau = [F(v) for v in torque[b]]
        if all(abs(v) <= TORQUE_EPS for v in tau):
            continue
        j = [F(v) for v in np.asarray(inertia[b], F).reshape(9)]
        half = F(F(F(j[0]+j[4])+j[8])*F(0.5))
        hz = F(half*F(0))
        k = [F(half-j[0]), F(hz-j[1]), F(hz-j[2]), F(hz-j[3]), F(half-j[4]), F(hz-j[5]), F(hz-j[6]), F(hz-j[7]),
             F(half-j[8])]
        a0, a1, a2 = ([F(v) for v in q[i]] for i in ids[1:])
        m = [[F(fma(a2[c], k[3*col+2], fma(a0[c], k[3*col], F(a1[c]*k[3*col+1])))) for c in range(3)]
             for col in range(3)]                      # m[col] = A k_col
        nmat = [[F(fma(a2[r], m[2][cc], fma(a0[r], m[0][cc], F(a1[r]*m[1][cc])))) for cc in range(3)]
                for r in range(3)]                     # N_rc = sum_j A_rj M_cj
        tr = F(nmat[2][2]+F(nmat[0][0]+nmat[1][1]))
        tz = F(tr*F(0))
        e = [F((tr if r == c else tz)-nmat[r][c]) for r in range(3) for c in range(3)]
        c20 = sub(e[4], e[8], e[7], e[5])
        c21 = sub(e[5], e[6], e[8], e[3])
        c22 = sub(e[3], e[7], e[4], e[6])
        det = F(fma(e[2], c22, fma(e[0], c20, F(e[1]*c21))))
        if not det > DET_TINY or not abs(det) < np.inf:
            continue
        r = F(F(1)/det)
        inv = [F(c20*r), F(c21*r), F(c22*r),
               F(sub(e[7], e[2], e[8], e[1])*r), F(sub(e[8], e[0], e[2], e[6])*r), F(sub(e[6], e[1], e[0], e[7])*r),
               F(sub(e[1], e[5], e[4], e[2])*r), F(sub(e[2], e[3], e[0], e[5])*r), F(sub(e[0], e[4], e[3], e[1])*r)]
        w = [F(fma(inv[3*row+2], tau[2], fma(tau[0], inv[3*row], F(inv[3*row+1]*tau[1])))) for row in range(3)]
        if not all(abs(v) < np.inf for v in w):
            continue
        for e_ in range(3):
            ops.add(b, 0, force, ids[0], e_, F(0))
        for col in range(3):
            mc = m[col]
            g = [sub(mc[2], w[1], mc[1], w[2]), sub(mc[0], w[2], mc[2], w[0]), sub(mc[1], w[0], mc[0], w[1])]
            for e_ in range(3):
                ops.add(b, col+1, force, ids[col+1], e_, g[e_])
    ops.apply()

def mass_ell(n, pairs, values):
    """Off-diagonal mass ELL (row_nnz, cols[max_nnz, n], values[max_nnz, n], max_nnz) as the native host builds it:
    each pair (i, j) contributes to rows i and j, columns ascending, values summed in pair order."""
    rows = [dict() for _ in range(n)]
    for (i, j), v in zip(np.asarray(pairs).reshape(-1, 2), np.asarray(values, F)):
        rows[i][j] = F(rows[i].get(j, F(0))+v)
        rows[j][i] = F(rows[j].get(i, F(0))+v)
    row_nnz = np.array([len(r) for r in rows], np.int32)
    max_nnz = int(row_nnz.max()) if n else 0
    cols = np.full((max_nnz, n), -1, np.int32)
    vals = np.zeros((max_nnz, n), F)
    for r, entries in enumerate(rows):
        for k, c in enumerate(sorted(entries)):
            cols[k, r], vals[k, r] = c, entries[c]
    return row_nnz, cols, vals, max_nnz


def union_ell(n, mass, joint_off):
    """ELL over the union of the mass pattern and the joint-spring template, columns ascending per row; returns
    (row_nnz, cols, mass_values, joint_values, max_nnz) with zeros where a template has no entry."""
    row_nnz0, cols0, vals0, max0 = mass
    rows = [dict() for _ in range(n)]
    for r in range(n):
        for k in range(row_nnz0[r]):
            rows[r][int(cols0[k, r])] = [vals0[k, r], F(0)]
    for (i, j), v in joint_off.items():
        rows[i].setdefault(j, [F(0), F(0)])[1] = v
    row_nnz = np.array([len(r) for r in rows], np.int32)
    max_nnz = int(row_nnz.max()) if n else 0
    cols = np.full((max_nnz, n), -1, np.int32)
    mv, jv = np.zeros((max_nnz, n), F), np.zeros((max_nnz, n), F)
    for r, entries in enumerate(rows):
        for k, c in enumerate(sorted(entries)):
            cols[k, r] = c
            mv[k, r], jv[k, r] = entries[c]
    return row_nnz, cols, mv, jv, max_nnz


def merge_ell(a, b):
    """Union of an ELL with several value arrays a = (row_nnz, cols, (values...), max_nnz) and a single-valued ELL
    b = (row_nnz, cols, values, max_nnz); returns the same layout with b's values appended (zeros where absent)."""
    rows_a, cols_a, vals_a, max_a = a
    rows_b, cols_b, vals_b, max_b = b
    n = len(rows_a)
    rows = [dict() for _ in range(n)]
    k = len(vals_a)
    for r in range(n):
        for s in range(int(rows_a[r])):
            rows[r][int(cols_a[s, r])] = [v[s, r] for v in vals_a]+[F(0)]
        for s in range(int(rows_b[r])):
            rows[r].setdefault(int(cols_b[s, r]), [F(0)]*k+[F(0)])[k] = vals_b[s, r]
    row_nnz = np.array([len(r) for r in rows], np.int32)
    max_nnz = int(row_nnz.max()) if n else 0
    cols = np.full((max_nnz, n), -1, np.int32)
    out = [np.zeros((max_nnz, n), F) for _ in range(k+1)]
    for r, entries in enumerate(rows):
        for s, c in enumerate(sorted(entries)):
            cols[s, r] = c
            for j in range(k+1):
                out[j][s, r] = entries[c][j]
    return row_nnz, cols, tuple(out), max_nnz


class AffineBodies:
    """Affine-body data of one solver: state particle indices, per-body weights (Model.body_masses), the
    off-diagonal mass ELL, the particle kinds (1 translation, 2 column) and the SO(3) AL state."""
    def __init__(self, indices, body_masses, n, mass_pairs, mass_values):
        self.indices = np.asarray(indices, np.int32).reshape(-1, 4)
        self.weight = np.asarray(body_masses, F)
        self.kind = np.zeros(n, np.int32)
        self.kind[self.indices[:, 0]] = 1
        self.kind[self.indices[:, 1:].reshape(-1)] = 2
        self.mass_ell = mass_ell(n, mass_pairs, mass_values)
        self.rotation = self.multiplier = None
