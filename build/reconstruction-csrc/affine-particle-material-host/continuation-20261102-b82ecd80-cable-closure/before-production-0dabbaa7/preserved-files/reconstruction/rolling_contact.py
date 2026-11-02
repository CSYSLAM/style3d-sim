"""Rolling and torsional contact friction of the legacy solver (evaluate_rolling_contact_force), from the sm_52 PTX.

The kernel takes a RollingContactView (248 B) by value; byte offsets of the fields used here:
  0 count ptr, 8 max count, 16/24 shape0/1, 32/40 point0/1, 48/56 offset0/1, 64 normal, 72/80 margin0/1,
  88 shape_body, 96 shape_type, 104 shape_transform, 112 shape_scale, 120 ke, 128 kd, 136 rolling friction,
  144 torsional friction, 152 shape count, 160 shapes per world, 168 world count, 176 affine ids, 184 affine indices,
  192 centres of mass, 200 body inertia tensors (body frame, row-major 3x3), 208 body count, 216 particle stride,
  224 x, 232 previous x, 240 1/h, 244 rolling_friction_velocity_epsilon.

Law (per contact, one thread):
  depth = (margin0 + margin1) - n.(w1 - w0) > 0, fn = max(depth ke - vn kd, 0) with ke, kd, mu_r, mu_t maxima over
  the two shapes; r_eff = min over the bodies of |A (p_contact - com)|; tau_r = r_eff mu_r fn, tau_t = r_eff mu_t fn.
  Tangents t1 = normalize(n x a) (a = e_x unless |n_x| >= 0.9, then e_y) and t2 = n x t1. For each body the world
  inertia is I_w = tr(W) 1 - W with W = A J A^T and J = tr(I)/2 1 - I; u_d = +-I_w^-1 d for d in (t1, t2, n) (sign
  - on body 1). The column particle k of A gets the rows g_dk = u_d x B_k with B_k = sum_j a_j J[k, j]; the relative
  angular rates are w_d = sum g_dk . v_k with v_k = (a_k - a_k_prev)/h.
  c_r = tau_r / max(eps, |(w1, w2)|), c_t = tau_t / max(eps, |w3|) and column k receives
  fma(g3, -c_t w3, fma(g1, -c_r w1, g2 (-c_r w2))).
"""
import numpy as np

from .affine import _cross
from .numerics import F, fma, fms
from .rigid_contact import _dot, _red, _normalize, _point_velocity, _sphere_local_offset, _vec, _world_point

SPHERE = 3
NORMAL_THRESHOLD = F(0.5)
AXIS_SWITCH = F(np.frombuffer(np.uint32(0x3F666666).tobytes(), F)[0])     # 0.9
DET_MIN = F(np.frombuffer(np.uint32(0x0DA24260).tobytes(), F)[0])         # 1e-30


def _fmax(a, b):
    """max.f32: returns the non-NaN operand."""
    a, b = F(a), F(b)
    if np.isnan(a):
        return b
    if np.isnan(b):
        return a
    return max(a, b)


def _finite(v):
    return bool(np.all(np.abs(np.asarray(v, F)) < np.inf))


def _world_inertia_inverse(cols, inertia):
    """B_k (A J rows) and the inverse of I_w = tr(W) 1 - W, or (B, None) when det <= 1e-30 or not finite."""
    i = [F(v) for v in np.asarray(inertia, F).reshape(9)]
    half = F(F(F(i[0]+i[4])+i[8])*F(0.5))
    zero = F(half*F(0))
    j = [F((half if r == c else zero)-i[3*r+c]) for r in range(3) for c in range(3)]
    a0, a1, a2 = cols
    b = [_vec(fma(a2, j[3*k+2], fma(a0, j[3*k], _vec(a1*j[3*k+1])))) for k in range(3)]
    w = [[F(fma(a2[r], b[2][c], fma(a0[r], b[0][c], F(a1[r]*b[1][c])))) for c in range(3)] for r in range(3)]
    tw = F(w[2][2]+F(w[0][0]+w[1][1]))
    zw = F(tw*F(0))
    m = [[F((tw if r == c else zw)-w[r][c]) for c in range(3)] for r in range(3)]
    c00 = fms(m[1][1], m[2][2], m[2][1], m[1][2])
    c01 = fms(m[1][2], m[2][0], m[2][2], m[1][0])
    c02 = fms(m[1][0], m[2][1], m[1][1], m[2][0])
    det = F(fma(m[0][2], c02, fma(m[0][0], c00, F(m[0][1]*c01))))
    if not det > DET_MIN or not abs(det) < np.inf:
        return b, None
    r = F(F(1)/det)
    rows = ((c00, c01, c02),
            (fms(m[2][1], m[0][2], m[2][2], m[0][1]), fms(m[2][2], m[0][0], m[0][2], m[2][0]),
             fms(m[2][0], m[0][1], m[0][0], m[2][1])),
            (fms(m[0][1], m[1][2], m[1][1], m[0][2]), fms(m[0][2], m[1][0], m[0][0], m[1][2]),
             fms(m[0][0], m[1][1], m[1][0], m[0][1])))
    return b, [[F(e*r) for e in row] for row in rows]


def _apply_inverse(inv, d, negate):
    """I_w^-1 d (body 0) or I_w^-1 (-d) (body 1) with the kernel's fma order."""
    if not negate:
        return _vec([fma(inv[k][2], d[2], fma(inv[k][0], d[0], F(inv[k][1]*d[1]))) for k in range(3)])
    return _vec([fma(-inv[k][2], d[2], fms(inv[k][0], -d[0], inv[k][1], d[1])) for k in range(3)])


def _rows(u, b):
    """g_k = u x B_k as fms(Bz, uy, By, uz), fms(Bx, uz, Bz, ux), fms(By, ux, Bx, uy)."""
    return [_vec([fms(bk[2], u[1], bk[1], u[2]), fms(bk[0], u[2], bk[2], u[0]), fms(bk[1], u[0], bk[0], u[1])])
            for bk in b]


class _Rolling:
    pass


def _lever(adj, slot, bodies, x):
    """|A (p - com)| with fma(e2, a2, fma(e0, a0, e1 a1))."""
    _, i1, i2, i3 = bodies.indices[slot]
    e = _vec(_vec(adj)-bodies.com[slot])
    v = fma(e[2], x[i3], fma(e[0], x[i1], _vec(e[1]*x[i2])))
    return F(np.sqrt(_dot(v, v)))


def _contact(c, i, shapes, bodies, inertia, x, previous, inv_h, eps):
    """Geometry, damping coefficients and Jacobian rows of one contact, or None when the kernel exits early."""
    s0, s1 = int(c['shape0'][i]), int(c['shape1'][i])
    if s0 < 0 or s1 < 0:
        return None
    b0, b1 = int(shapes['body'][s0]), int(shapes['body'][s1])
    k0, k1 = bodies.slot(b0), bodies.slot(b1)
    if (b0 > -1 and k0 < 0) or (b1 > -1 and k1 < 0) or (k0 < 0 and k1 < 0) or k0 == k1:
        return None
    rolling = shapes.get('rolling')
    torsional = shapes.get('torsional')
    mu_r = _fmax(rolling[s0], rolling[s1]) if rolling is not None else F(0)
    mu_t = _fmax(torsional[s0], torsional[s1]) if torsional is not None else F(0)
    if not mu_t > 0 and not mu_r > 0:
        return None
    n = _normalize(c['normal'][i])
    t0, t1 = int(shapes['type'][s0]), int(shapes['type'][s1])
    raw0 = _vec(shapes['position'][s0]) if t0 == SPHERE else _vec(c['point0'][i])
    raw1 = _vec(shapes['position'][s1]) if t1 == SPHERE else _vec(c['point1'][i])
    w0 = _world_point(raw0, k0, bodies, x)
    w1 = _world_point(raw1, k1, bodies, x)
    if t0 == SPHERE and t1 == SPHERE:
        alt = _normalize(_vec(w1-w0))               # |d|^2 accumulated y first here (x first in the force kernel)
        if _dot(alt, alt) >= NORMAL_THRESHOLD:
            n = alt
    if not _dot(n, n) >= NORMAL_THRESHOLD:
        return None
    adj0, adj1 = raw0, raw1
    if t0 == SPHERE:
        radius = F(shapes['scale'][s0][0])
        if k0 >= 0:
            adj0 = _vec(raw0+_sphere_local_offset(_vec(radius*n), k0, bodies, x))
        else:
            adj0 = _vec(fma(radius, n, raw0))
    if t1 == SPHERE:
        radius = F(shapes['scale'][s1][0])
        if k1 >= 0:
            adj1 = _vec(raw1+_sphere_local_offset(_vec(-(radius*n)), k1, bodies, x))
        else:
            adj1 = _vec(fma(-radius, n, raw1))
    if c.get('offset0') is not None:
        adj0 = _vec(_vec(c['point0'][i])+_vec(c['offset0'][i]))
    if c.get('offset1') is not None:
        adj1 = _vec(_vec(c['point1'][i])+_vec(c['offset1'][i]))
    depth = F(F(F(c['margin0'][i])+F(c['margin1'][i]))-_dot(_vec(w1-w0), n))
    if not depth > 0:
        return None
    zero = np.zeros(3, F)
    v0 = v1 = zero
    radius0 = radius1 = F(0)
    if k0 >= 0:
        v0 = _point_velocity(raw0, k0, bodies, x, previous, None, inv_h)
        radius0 = _lever(adj0, k0, bodies, x)
        if not radius0 > 0 or not radius0 < np.inf:
            return None
    radius = radius0
    if k1 >= 0:
        v1 = _point_velocity(raw1, k1, bodies, x, previous, None, inv_h)
        radius1 = _lever(adj1, k1, bodies, x)
        if not radius1 > 0 or not radius1 < np.inf:
            return None
        radius = min(radius0, radius1) if radius0 > 0 else radius1
    dvn = _dot(_vec(v1-v0), n)
    ke = _fmax(shapes['ke'][s0], shapes['ke'][s1])
    kd = _fmax(shapes['kd'][s0], shapes['kd'][s1])
    fn = _fmax(fms(depth, ke, dvn, kd), F(0))
    tau_r = F(radius*F(mu_r*fn))
    tau_t = F(radius*F(mu_t*fn))
    if not fn > 0 or not _finite(tau_r) or not _finite(tau_t):
        return None
    # Tangent basis.
    near_x = abs(n[0]) < AXIS_SWITCH
    ax, ay = (F(1), F(0)) if near_x else (F(0), F(1))
    t1v = _normalize(_vec([fms(n[1], F(0), ay, n[2]), fms(ax, n[2], n[0], F(0)), fms(ay, n[0], ax, n[1])]))
    t2v = _vec(_cross(n, t1v))
    entries = []
    omega = [F(0), F(0), F(0)]
    for side, slot in ((0, k0), (1, k1)):
        if slot < 0:
            continue
        ids = bodies.indices[slot]
        cols = [_vec(x[ids[k]]) for k in (1, 2, 3)]
        b, inv = _world_inertia_inverse(cols, inertia[slot])
        if inv is None:
            return None
        rows = []
        for d in (t1v, t2v, n):
            u = _apply_inverse(inv, d, side == 1)
            if not _finite(u):
                return None
            rows.append(_rows(u, b))
        for k in range(3):
            v = _vec(F(inv_h)*_vec(x[ids[k+1]]-previous[ids[k+1]]))
            g = [rows[0][k], rows[1][k], rows[2][k]]
            for dim in range(3):
                omega[dim] = F(_dot(v, g[dim])+omega[dim])
            entries.append((int(ids[k+1]), g))
    roll = F(np.sqrt(F(fma(omega[0], omega[0], F(omega[1]*omega[1])))))
    spin = F(abs(omega[2]))
    if not _finite(roll) or not _finite(spin):
        return None
    c_r = F(tau_r/_fmax(eps, roll))
    c_t = F(tau_t/_fmax(eps, spin))
    if not _finite(c_r) or not _finite(c_t):
        return None
    r = _Rolling()
    r.entries, r.omega, r.c_r, r.c_t = entries, omega, c_r, c_t
    return r


def _contacts(contacts, shapes, bodies, inertia, x, previous, inv_h, epsilon):
    inv_h, eps = F(inv_h), F(epsilon)
    for i in range(int(contacts['count'])):
        r = _contact(contacts, i, shapes, bodies, inertia, x, previous, inv_h, eps)
        if r is not None:
            yield i, r


def _scatter(ops, target):
    for key in sorted(range(len(ops)), key=lambda k: ops[k][:4]):
        _, _, comp, _, particle, value = ops[key]
        _red(target[particle], comp, value)


def _entry_vectors(ops, i, r, scale):
    """Adds fma(g3, s3, fma(g1, s1, g2 s2)) per Jacobian entry. The entry loop is unrolled by four; lanes reconverge
    before the remainder loop, and atomics are applied warp by warp, instruction by instruction, lanes ascending."""
    count = len(r.entries)
    unrolled = count - count % 4 if count >= 4 else 0
    for e, (particle, g) in enumerate(r.entries):
        f = _vec(fma(g[2], scale[2], fma(g[0], scale[0], _vec(g[1]*scale[1]))))
        step = (0, e) if e < unrolled else (1, e-unrolled)
        for comp in range(3):
            ops.append((-(i//32), step, comp, i % 32, particle, f[comp]))


def evaluate_rolling_contact_force(contacts, shapes, bodies, inertia, x, previous, inv_h, epsilon, force):
    """Adds the rolling/torsional friction forces -J^T D J v to `force` [n, 3]."""
    ops = []
    for i, r in _contacts(contacts, shapes, bodies, inertia, x, previous, inv_h, epsilon):
        tau = (F(-F(r.c_r*r.omega[0])), F(-F(r.c_r*r.omega[1])), F(-F(r.c_t*r.omega[2])))
        _entry_vectors(ops, i, r, tau)
    _scatter(ops, force)


def add_rolling_contact_preconditioner(contacts, shapes, bodies, inertia, x, previous, inv_h, epsilon, block):
    """Adds the 3x3 blocks sum_d (D_d/h) g_d g_d^T of every Jacobian entry to `block` [n, 9] (plain entry loop)."""
    ops = []
    for i, r in _contacts(contacts, shapes, bodies, inertia, x, previous, inv_h, epsilon):
        h = F(inv_h)
        scale = (F(h*r.c_r), F(h*r.c_r), F(h*r.c_t))
        for e, (particle, g) in enumerate(r.entries):
            outer = [[[F(gd[a]*gd[b]) for b in range(3)] for a in range(3)] for gd in g]
            m = [[F(fma(scale[2], outer[2][a][b], fma(scale[0], outer[0][a][b], F(scale[1]*outer[1][a][b]))))
                  for b in range(3)] for a in range(3)]
            for comp in range(9):
                a, b = divmod(comp, 3)
                lo, hi = min(a, b), max(a, b)
                ops.append((-(i//32), e, comp, i % 32, particle, m[lo][hi]))
    _scatter(ops, block)


def multiply_rolling_contact_tangent(contacts, shapes, bodies, inertia, x, previous, inv_h, epsilon, direction,
                                     product):
    """Adds J^T (D/h) J p to `product` [n, 3]."""
    ops = []
    for i, r in _contacts(contacts, shapes, bodies, inertia, x, previous, inv_h, epsilon):
        s = [F(0), F(0), F(0)]
        for particle, g in r.entries:
            p = _vec(direction[particle])
            for d in range(3):
                s[d] = F(_dot(g[d], p)+s[d])
        h = F(inv_h)
        y = (F(F(h*r.c_r)*s[0]), F(F(h*r.c_r)*s[1]), F(F(h*r.c_t)*s[2]))
        _entry_vectors(ops, i, r, y)
    _scatter(ops, product)
