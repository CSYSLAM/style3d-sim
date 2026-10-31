"""Penalty rigid contact of the legacy solver (evaluate_contact_force), transcribed from the sm_52 PTX.

Contacts come from Newton's collision pipeline (shape0/1, body-local points, offsets, normal, margins). A shape owned
by an affine body maps a body-local point p to x_t + sum_k (p - com)_k a_k (translation x_t, affine columns a_k);
static shapes use world points. Forces are distributed to the translation (F) and to column k (F (p - com)_k).

Native law (friction_epsilon == 0): ke, kd, kf and mu are the maxima over the two shapes;
d = (margin0 + margin1) - n.(p1 - p0) > 0; fn = max(fma(-vn, kd, d ke), 0) with vn from the raw contact points;
vt = fma(-(dv.n), n, dv) from the offset points; eta = min(kf, mu fn / max(|vt|, 1e-8)) when mu fn > 0.
With friction_epsilon > 0 (VBD-style): averaged ke/kd, mu = sqrt(max(mu0 mu1, 0)), no clamp of fn, kd dropped for
separating contacts and a smoothed friction coefficient.
Diagonal scalars: s_n = fma(kd_eff, 1/h, ke) and s_f = eta/h (column k gets r_k (s r_k)).
"""
import numpy as np

from .affine import nearest_rotation
from .numerics import F, fma

SPHERE = 3
TINY = F(1e-8)
DET_EPS = F(np.frombuffer(np.uint32(0x2EDBE6FF).tobytes(), F)[0])


def _dot(u, v):
    return F(fma(u[2], v[2], fma(u[0], v[0], F(u[1]*v[1]))))


def _dot_x_first(u, v):
    """fma(u2 v2, fma(u1 v1, u0 v0)): the velocity projections accumulate x first."""
    return F(fma(u[2], v[2], fma(u[1], v[1], F(u[0]*v[0]))))


def _normalize(v):
    length = F(np.sqrt(_dot(v, v)))
    if not length > 0:
        return np.zeros(3, F)
    return np.array([F(c/length) for c in v], F)


def _vec(v):
    return np.asarray(v, F)


class Bodies:
    """Affine-body maps of the contact kernels: shape body -> affine slot, state indices, centres of mass."""
    def __init__(self, ids, indices, com):
        self.ids = np.asarray(ids, np.int32)
        self.indices = np.asarray(indices, np.int32).reshape(-1, 4)
        self.com = np.asarray(com, F).reshape(-1, 3)

    def slot(self, body):
        """Affine slot of a Newton body: direct index first, then a linear search (as in the PTX)."""
        if body < 0:
            return -1
        if body < len(self.ids) and self.ids[body] == body:
            return body
        hits = np.flatnonzero(self.ids == body)
        return int(hits[0]) if len(hits) else -1


def _world_point(p, slot, bodies, x):
    """x_t + sum_k (p - com)_k a_k with the PTX fma order (translation, then columns 0, 1, 2)."""
    if slot < 0:
        return _vec(p)
    t, a0, a1, a2 = (x[i] for i in bodies.indices[slot])
    d = _vec(_vec(p)-bodies.com[slot])
    w = fma(d[0], a0, t)
    w = fma(d[1], a1, w)
    return _vec(fma(d[2], a2, w))


def _point_velocity(p, slot, bodies, x, previous, velocity, inv_h):
    if slot < 0:
        return np.zeros(3, F)
    v = []
    for i in bodies.indices[slot]:
        if previous is not None:
            v.append(_vec(_vec(x[i]-previous[i])*F(inv_h)))
        else:
            v.append(_vec(velocity[i]))
    d = _vec(_vec(p)-bodies.com[slot])
    w = fma(d[0], v[1], v[0])
    w = fma(d[1], v[2], w)
    return _vec(fma(d[2], v[3], w))


def _sphere_local_offset(v, slot, bodies, x):
    """Body-local offset of a world vector v: A^-1 v via cofactors when |det A| > 1e-10, else R^T v."""
    _, i1, i2, i3 = bodies.indices[slot]
    a, b, c = _vec(x[i1]), _vec(x[i2]), _vec(x[i3])
    # PTX naming: rows of cof(A) / det are (b x c), (c x a), (a x b) built from mul;mul;sub (minuend fused).
    from .affine import _cross
    bc = _cross(b, c)
    det = F(fma(a[2], bc[2], fma(a[0], bc[0], F(a[1]*bc[1]))))
    if abs(det) > DET_EPS and abs(det) < np.inf:
        r = F(F(1)/det)
        ca, ab = _cross(c, a), _cross(a, b)
        rows = [[F(e*r) for e in row] for row in (bc, ca, ab)]
        return _vec([F(fma(v[2], rows[k][2], fma(v[0], rows[k][0], F(v[1]*rows[k][1])))) for k in range(3)])
    cols = nearest_rotation(a, b, c)
    return _vec([F(fma(v[2], cols[k][2], fma(v[0], cols[k][0], F(v[1]*cols[k][1])))) for k in range(3)])


class _Contact:
    pass


def _contact(c, i, shapes, bodies, x, previous, velocity, inv_h, eps, tangent_check=False):
    """Per-contact geometry and coefficients shared by evaluate_contact_force and evaluate_contact_tangent;
    None for skipped contacts."""
    smooth = eps > 0
    s0, s1 = int(c['shape0'][i]), int(c['shape1'][i])
    if s0 < 0 or s1 < 0:
        return None
    b0, b1 = int(shapes['body'][s0]), int(shapes['body'][s1])
    k0, k1 = bodies.slot(b0), bodies.slot(b1)
    if (b0 > -1 and k0 < 0) or (b1 > -1 and k1 < 0) or (k0 < 0 and k1 < 0):
        return None
    n = _normalize(c['normal'][i])
    t0, t1 = int(shapes['type'][s0]), int(shapes['type'][s1])
    raw0 = _vec(shapes['position'][s0]) if t0 == SPHERE else _vec(c['point0'][i])
    raw1 = _vec(shapes['position'][s1]) if t1 == SPHERE else _vec(c['point1'][i])
    w0 = _world_point(raw0, k0, bodies, x)
    w1 = _world_point(raw1, k1, bodies, x)
    if t0 == SPHERE and t1 == SPHERE:
        diff = _vec(w1-w0)
        length = F(np.sqrt(_dot_x_first(diff, diff)))   # sphere-sphere direction: |d|^2 accumulated x first
        alt = np.array([F(e/length) for e in diff], F) if length > 0 else np.zeros(3, F)
        if not _dot(alt, alt) < F(0.5):
            n = alt
    # The tangent kernel tests (n0^2 + n1^2) + n2^2, the force kernel the y-first fma dot.
    norm2 = F(F(F(n[0]*n[0])+F(n[1]*n[1]))+F(n[2]*n[2])) if tangent_check else _dot(n, n)
    if not norm2 >= F(0.5):
        return None
    adj0, adj1 = raw0, raw1
    if t0 == SPHERE:
        v = _vec(F(shapes['scale'][s0][0])*n)
        adj0 = _vec(raw0+(_sphere_local_offset(v, k0, bodies, x) if k0 >= 0 else v))
    if t1 == SPHERE:
        v = _vec(-(F(shapes['scale'][s1][0])*n))
        adj1 = _vec(raw1+(_sphere_local_offset(v, k1, bodies, x) if k1 >= 0 else v))
    if c.get('offset0') is not None:
        adj0 = _vec(_vec(c['point0'][i])+_vec(c['offset0'][i]))
    if c.get('offset1') is not None:
        adj1 = _vec(_vec(c['point1'][i])+_vec(c['offset1'][i]))
    margin = F(F(c['margin1'][i])+F(c['margin0'][i]))
    depth = F(margin-_dot(_vec(w1-w0), n))
    if not depth > 0:
        return None
    v0 = _point_velocity(raw0, k0, bodies, x, previous, velocity, inv_h)
    v1 = _point_velocity(raw1, k1, bodies, x, previous, velocity, inv_h)
    vn = _dot_x_first(_vec(v1-v0), n)
    ke0, ke1 = F(shapes['ke'][s0]), F(shapes['ke'][s1])
    kd0, kd1 = F(shapes['kd'][s0]), F(shapes['kd'][s1])
    ke = F(F(ke0+ke1)*F(0.5)) if smooth else max(ke0, ke1)
    kd = F(F(kd0+kd1)*F(0.5)) if smooth else max(kd0, kd1)
    elastic = F(depth*ke)
    kd_eff = F(0) if (smooth and vn >= 0) else kd
    if smooth:
        fn = F(fma(-vn, kd_eff, elastic))
    else:
        fn = max(F(fma(-vn, kd, elastic)), F(0))
    a0 = _point_velocity(adj0, k0, bodies, x, previous, velocity, inv_h)
    a1 = _point_velocity(adj1, k1, bodies, x, previous, velocity, inv_h)
    dv = _vec(a1-a0)
    dvn = _dot_x_first(dv, n)
    vt = _vec(fma(-dvn, n, dv))
    vtl = F(np.sqrt(_dot(vt, vt)))
    mu0, mu1 = F(shapes['mu'][s0]), F(shapes['mu'][s1])
    mu = F(np.sqrt(max(F(mu0*mu1), F(0)))) if smooth else max(mu0, mu1)
    bound = F((elastic if smooth else fn)*mu)
    eta = F(0)
    if smooth:
        if bound > 0 and vtl > 0:
            eta = F(bound/vtl) if vtl > eps else F(F(F(F(2)-F(vtl/eps))*bound)/eps)
    else:
        kf = max(F(shapes['kf'][s0]), F(shapes['kf'][s1]))
        if bound > 0:
            eta = min(kf, F(bound/max(vtl, TINY)))
    r = _Contact()
    r.n, r.vt, r.fn, r.eta = n, vt, fn, eta
    r.k0, r.k1, r.raw0, r.raw1, r.adj0, r.adj1 = k0, k1, raw0, raw1, adj0, adj1
    r.s_n = F(fma(kd_eff, inv_h, ke))
    r.s_f = F(eta*inv_h)
    r.separate = c.get('offset0') is not None or c.get('offset1') is not None or t0 == SPHERE or t1 == SPHERE
    return r


class _Ops:
    """red.global.add operations keyed (warp descending, instruction, lane ascending), applied in that order: the
    GPU executes each atomic instruction for all lanes of a warp before the next one."""
    def __init__(self):
        self.ops = []

    def add(self, thread, instruction, target, index, component, value):
        self.ops.append((-(thread//32), instruction, thread % 32, len(self.ops), target, index, component, F(value)))

    def apply(self):
        for *_, target, index, component, value in sorted(self.ops, key=lambda op: op[:4]):
            if component is None:
                _red(target, index, value)
            else:
                _red(target[index], component, value)


def _scatter_ops(ops, i, base, force, ids, f, r, sign):
    for e in range(3):
        ops.add(i, base, force, ids[0], e, f[e] if sign > 0 else -f[e])
    for k in range(3):
        for e in range(3):
            v = F(f[e]*r[k])
            ops.add(i, base+1+k, force, ids[k+1], e, v if sign > 0 else -v)


def _scalar_ops(ops, i, base, scalar, ids, s, r):
    ops.add(i, base, scalar, ids[0], None, s)
    for k in range(3):
        ops.add(i, base+1+k, scalar, ids[k+1], None, F(r[k]*F(s*r[k])))


def evaluate_contact_force(contacts, shapes, bodies, x, previous, velocity, inv_h, epsilon, force, scalar):
    """Adds contact forces to `force` [n, 3] and diagonal scalars to `scalar` [n], one thread per contact with the
    atomics in SIMT order (_Ops). Instruction ids follow the kernel: the separate branch (offsets or spheres) and the
    combined branch are different code paths."""
    inv_h = F(inv_h)
    eps = F(epsilon)
    ops = _Ops()
    for i in range(int(contacts['count'])):
        r = _contact(contacts, i, shapes, bodies, x, previous, velocity, inv_h, eps)
        if r is None:
            continue
        fnv = _vec(r.n*(-r.fn))
        ftv = _vec(r.vt*r.eta)
        base = 0 if r.separate else 100
        for side, (slot, raw, adj, sign) in enumerate(((r.k0, r.raw0, r.adj0, 1), (r.k1, r.raw1, r.adj1, -1))):
            if slot < 0:
                continue
            ids = bodies.indices[slot]
            com = bodies.com[slot]
            if r.separate:
                _scatter_ops(ops, i, base+8*side, force, ids, fnv, _vec(raw-com), sign)
                _scatter_ops(ops, i, base+8*side+4, force, ids, ftv, _vec(adj-com), sign)
            else:
                _scatter_ops(ops, i, base+8*side, force, ids, _vec(fnv+ftv), _vec(raw-com), sign)
        for side, (slot, raw, adj) in enumerate(((r.k0, r.raw0, r.adj0), (r.k1, r.raw1, r.adj1))):
            if slot < 0:
                continue
            ids = bodies.indices[slot]
            com = bodies.com[slot]
            if r.separate:
                _scalar_ops(ops, i, base+16+8*side, scalar, ids, r.s_n, _vec(raw-com))
                if r.s_f > 0:
                    _scalar_ops(ops, i, base+16+8*side+4, scalar, ids, r.s_f, _vec(adj-com))
            else:
                _scalar_ops(ops, i, base+16+8*side, scalar, ids, max(r.s_n, r.s_f), _vec(raw-com))
    ops.apply()


def _entries(r, bodies):
    """Jacobian entries (particle, normal weight, friction weight): body 0 negative, body 1 positive."""
    out = []
    for slot, raw, adj, sign in ((r.k0, r.raw0, r.adj0, F(-1)), (r.k1, r.raw1, r.adj1, F(1))):
        if slot < 0:
            continue
        com = bodies.com[slot]
        rn, rf = _vec(raw-com), _vec(adj-com)
        ids = bodies.indices[slot]
        out.append((int(ids[0]), sign, sign))
        for k in range(3):
            out.append((int(ids[k+1]), F(sign*rn[k]) if sign > 0 else -rn[k], F(sign*rf[k]) if sign > 0 else -rf[k]))
    return out


def _apply(m, u):
    """Symmetric 3x3 (xx, xy, xz, yy, yz, zz) times u in the PTX order."""
    xx, xy, xz, yy, yz, zz = m
    return _vec([F(fma(xz, u[2], fma(xx, u[0], F(xy*u[1])))), F(fma(yz, u[2], fma(xy, u[0], F(yy*u[1])))),
                 F(fma(zz, u[2], fma(xz, u[0], F(yz*u[1]))))])


def evaluate_contact_tangent(contacts, shapes, bodies, x, previous, velocity, inv_h, epsilon, direction=None,
                             product=None, system=None, precond=None):
    """Product mode (direction, product): the off-diagonal coupling w_i K sum_{j, other particle} w_j p_j with
    K = c n n^T (normal list, c = s_n when fn > 0) and (eta/h)(I - n n^T) (friction list).
    Block mode (system and/or precond [n, 9]): per entry the block K - s_iso I, where s_iso is the isotropic part
    evaluate_contact_force put into the diagonal scalar."""
    inv_h = F(inv_h)
    eps = F(epsilon)
    ops = _Ops()
    for i in range(int(contacts['count'])):
        r = _contact(contacts, i, shapes, bodies, x, previous, velocity, inv_h, eps, tangent_check=True)
        if r is None:
            continue
        n = r.n
        nxx, nyy, nzz = F(n[0]*n[0]), F(n[1]*n[1]), F(n[2]*n[2])
        nxy, nxz, nyz = F(n[1]*n[0]), F(n[2]*n[0]), F(n[2]*n[1])
        c = r.s_n if r.fn > 0 else F(0)
        f = F(r.eta*inv_h)
        proj = (F(F(1)-nxx), F(F(0)-nxy), F(F(0)-nxz), F(F(1)-nyy), F(F(0)-nyz), F(F(1)-nzz))
        entries = _entries(r, bodies)
        if direction is not None and product is not None:
            kn = tuple(F(c*e) for e in (nxx, nxy, nxz, nyy, nyz, nzz))
            kf = tuple(F(f*e) for e in proj)
            for which, k in ((1, kn), (2, kf)):
                for slot_i, (p_i, *w_i) in enumerate(entries):
                    u = np.zeros(3, F)
                    for p_j, *w_j in entries:
                        if p_j == p_i:
                            continue
                        u = _vec(fma(w_j[which-1], direction[p_j], u))
                    ku = _apply(k, u)
                    for e in range(3):
                        ops.add(i, 10*which+slot_i, product, p_i, e, F(ku[e]*w_i[which-1]))
        if system is None and precond is None:
            continue
        for slot_e, (p_e, wn, wf) in enumerate(entries):
            n2, f2 = F(wn*wn), F(wf*wf)
            if r.separate:
                s_f = F(f*f2)
                s_iso = F(fma(r.s_n, n2, s_f))
            else:
                s_iso = F(n2*max(r.s_n, f))
                s_f = F(f*f2)
            cn = F(c*n2)
            d00 = F(fma(cn, nxx, F(proj[0]*s_f)))
            d01 = F(fma(cn, nxy, F(proj[1]*s_f)))
            d02 = F(fma(cn, nxz, F(proj[2]*s_f)))
            d11 = F(fma(cn, nyy, F(proj[3]*s_f)))
            d12 = F(fma(cn, nyz, F(proj[4]*s_f)))
            d22 = F(fma(cn, nzz, F(proj[5]*s_f)))
            zero = F(s_iso*F(0))
            block = (F(d00-s_iso), F(d01-zero), F(d02-zero), F(d01-zero), F(d11-s_iso), F(d12-zero),
                     F(d02-zero), F(d12-zero), F(d22-s_iso))
            for q in range(9):
                if system is not None:
                    ops.add(i, 100+20*slot_e+2*q, system, p_e, q, block[q])
                if precond is not None:
                    ops.add(i, 100+20*slot_e+2*q+1, precond, p_e, q, block[q])
    ops.apply()


def _red(target, index, value):
    value = F(value)
    if abs(value) < np.finfo(F).tiny:
        value = F(0)
    target[index] = F(target[index]+value)


def _scatter(force, ids, f, r, sign):
    for e in range(3):
        _red(force[ids[0]], e, f[e] if sign > 0 else -f[e])
    for k in range(3):
        for e in range(3):
            v = F(f[e]*r[k])
            _red(force[ids[k+1]], e, v if sign > 0 else -v)


def _scatter_scalar(scalar, ids, s, r):
    _red(scalar, ids[0], s)
    for k in range(3):
        _red(scalar, ids[k+1], F(r[k]*F(s*r[k])))
