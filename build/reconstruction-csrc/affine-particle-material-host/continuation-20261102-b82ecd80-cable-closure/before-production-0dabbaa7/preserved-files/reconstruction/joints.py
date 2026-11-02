"""Body springs and augmented-Lagrangian joint springs of the legacy solver, transcribed from the sm_52 PTX
(evaluate_body_spring_force, evaluate_joint_body_spring_augmented_lagrangian_force,
initialize_joint_body_spring_state, update_joint_body_spring_augmented_lagrangian_state) plus the host-built
constant templates that combine_system_non_diagonal / initialize_step weight with constraint_alpha.

A spring end on affine body b is p = fma(w3, a2, fma(w2, a1, fma(w0, t, w1 a0))) with host weights
w = (1, p_local - com); an end with b < 0 is the stored world point. Newton joints become joint springs appended
at the end of the body-spring arrays (anchor and axis points of a revolute joint, ...).
Joint spring force: f = (k alpha/h^2) ((p1 - p0) + lambda), +w0_k f to body 0, -w1_k f to body 1;
after every Newton iteration except the last: lambda = (p1 + lambda) - p0.
"""
import numpy as np

from .numerics import F, fma
from .rigid_contact import _Ops


def spring_weights(points, bodies_of_spring, com):
    """Host weights (1, p - com) per spring end; zero for world ends."""
    w = np.zeros((len(points), 4), F)
    for s, (p, b) in enumerate(zip(points, bodies_of_spring)):
        if b >= 0:
            w[s, 0] = F(1)
            w[s, 1:] = (np.asarray(p, F)-np.asarray(com[b], F)).astype(F)
    return w


TINY_LENGTH = F(np.frombuffer(np.uint32(0x322BCC77).tobytes(), F)[0])   # 1e-8
SEGMENT_EPS = F(np.frombuffer(np.uint32(0x2B8CBCCC).tobytes(), F)[0])   # 1e-12


class Springs:
    """Body-spring arrays (Model.body_spring_*); the last `joint_count` entries are joint springs."""
    def __init__(self, pairs, points0, points1, stiffness, rest, joint_count, indices, com):
        self.pairs = np.asarray(pairs, np.int32).reshape(-1, 2)
        self.points0 = np.asarray(points0, F).reshape(-1, 3)
        self.points1 = np.asarray(points1, F).reshape(-1, 3)
        self.k = np.asarray(stiffness, F)
        self.rest = np.asarray(rest, F)
        self.joint_count = int(joint_count)
        self.indices = np.asarray(indices, np.int32).reshape(-1, 4)
        self.w0 = spring_weights(self.points0, self.pairs[:, 0], com)
        self.w1 = spring_weights(self.points1, self.pairs[:, 1], com)
        self.multiplier = np.zeros((self.joint_count, 3), F)

    @property
    def first_joint(self):
        return len(self.pairs)-self.joint_count

    def end(self, x, s, side):
        b = self.pairs[s, side]
        if b < 0:
            return (self.points0 if side == 0 else self.points1)[s].copy()
        w = (self.w0 if side == 0 else self.w1)[s]
        t, a0, a1, a2 = (np.asarray(x[i], F) for i in self.indices[b])
        p = fma(w[0], t, (w[1]*a0).astype(F))
        p = fma(w[2], a1, p)
        return np.asarray(fma(w[3], a2, p), F)

    def plain_force(self, x, alpha, include_joints, force):
        """evaluate_body_spring_force: f = k (d - rest d/|d|) with d = p1 - p0 (|d| x first, 0 direction when
        |d| = 0). Plain springs use k; the trailing joint springs are skipped unless `include_joints` (penalty
        joints), then with alpha k. Body 0 gets w0 f and body 1 w1 (-f), slots interleaved (b0 s0, b1 s0, ...)."""
        from .rigid_contact import _Ops
        ops = _Ops()
        plain = len(self.pairs)-self.joint_count
        for s in range(len(self.pairs)):
            if s >= plain and not include_joints:
                continue
            p0, p1 = self.end(x, s, 0), self.end(x, s, 1)
            d = (p1-p0).astype(F)
            k = F((F(1) if s < plain else F(alpha))*self.k[s])
            length = F(np.sqrt(fma(d[2], d[2], fma(d[1], d[1], F(d[0]*d[0])))))
            u = (d/length).astype(F) if length > 0 else np.zeros(3, F)
            f = (k*fma(-self.rest[s], u, d).astype(F)).astype(F)  # ptxas contracts d - rest u
            sides = [(self.pairs[s, 0], self.w0[s], f), (self.pairs[s, 1], self.w1[s], (-f).astype(F))]
            for slot in range(4):
                for side, (b, w, g) in enumerate(sides):
                    if b < 0:
                        continue
                    pid = self.indices[b][slot]
                    for e in range(3):
                        ops.add(s, 2*slot+side, force, pid, e, F(w[slot]*g[e]))
        ops.apply()

    def add_gauss_newton_hessian(self, x, diagonal, ell):
        """add_body_spring_gauss_newton_hessian: the per-iteration correction K = k (M - I) on top of the host
        constant k I, with M = nn^T + max(0, 1 - rest/|d|) (I - nn^T) (M = I for |d| <= 1e-8). Springs with
        rest <= 0 or k <= 0 are skipped. Jacobian entries: body 0 (-w0) then body 1 (w1); K w_a^2 into the diagonal
        block of a, K (w_a w_b) into (a, b) and (b, a) (diagonal when the particles coincide, else the ELL slot
        found by a lower-bound search over min(row_nnz, max_nnz) columns)."""
        from .rigid_contact import _red
        row_nnz, cols, blocks, max_nnz = ell
        ops = []
        for s in range(len(self.pairs)):
            rest, k = F(self.rest[s]), F(self.k[s])
            if rest <= 0 or not k > 0:
                continue
            ents = []
            for side, w in ((0, -self.w0[s]), (1, self.w1[s])):
                b = self.pairs[s, side]
                if b >= 0:
                    ents += [(int(t), F(v)) for t, v in zip(self.indices[b], w.astype(F))]
            d = (self.end(x, s, 1)-self.end(x, s, 0)).astype(F)
            length = F(np.sqrt(fma(d[2], d[2], fma(d[1], d[1], F(d[0]*d[0])))))
            if length <= TINY_LENGTH:
                m = [F(1), F(0), F(0), F(1), F(0), F(1)]
            else:
                n = [F(d[0]/length), F(d[1]/length), F(d[2]/length)]
                nn = [F(n[0]*n[0]), F(n[1]*n[0]), F(n[2]*n[0]), F(n[1]*n[1]), F(n[2]*n[1]), F(n[2]*n[2])]
                scale = max(F(0), F(F(1)-F(rest/length)))
                eye = [F(1), F(0), F(0), F(1), F(0), F(1)]
                m = [F(fma(F(e-v), scale, v)) for e, v in zip(eye, nn)]
            m00, m01, m02, m11, m12, m22 = m
            kk = [F(k*F(m00+F(-1))), F(k*m01), F(k*m02), F(k*m01), F(k*F(m11+F(-1))), F(k*m12), F(k*m02),
                  F(k*m12), F(k*F(m22+F(-1)))]
            for a, (ia, wa) in enumerate(ents):
                c = F(wa*wa)
                ops.append(((-(s//32), a, -1, 0, s % 32), ('d', ia), [F(v*c) for v in kk]))
                for b in range(a+1, len(ents)):
                    ib, wb = ents[b]
                    c = F(wa*wb)
                    block = [F(v*c) for v in kk]
                    for which, (r, col) in enumerate(((ia, ib), (ib, ia))):
                        key = ('d', r) if r == col else ('o', r, col)
                        ops.append(((-(s//32), a, b, which, s % 32), key, block))
        for _, key, block in sorted(ops, key=lambda op: op[0]):
            if key[0] == 'd':
                for e in range(9):
                    _red(diagonal[key[1]], e, block[e])
                continue
            _, r, col = key
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
                    _red(blocks[lo, r], e, block[e])

    def initialize_state(self):
        """initialize_joint_body_spring_state: lambda = 0 at the start of every step."""
        self.multiplier = np.zeros((self.joint_count, 3), F)

    def joint_force(self, x, alpha_h2, force):
        """evaluate_joint_body_spring_augmented_lagrangian_force (atomics in SIMT order)."""
        ops = _Ops()
        for i in range(self.joint_count):
            s = self.first_joint+i
            p0, p1 = self.end(x, s, 0), self.end(x, s, 1)
            c = (((p1-p0).astype(F))+self.multiplier[i]).astype(F)
            f = (c*F(self.k[s]*F(alpha_h2))).astype(F)
            for side, sign in ((0, 1), (1, -1)):
                b = self.pairs[s, side]
                if b < 0:
                    continue
                w = (self.w0 if side == 0 else self.w1)[s]
                for slot in range(4):
                    for e in range(3):
                        value = F(f[e]*w[slot]) if sign > 0 else F(w[slot]*F(-f[e]))
                        ops.add(i, 4*side+slot, force, self.indices[b][slot], e, value)
        ops.apply()

    def update_state(self, x):
        """update_joint_body_spring_augmented_lagrangian_state: lambda = (p1 + lambda) - p0."""
        for i in range(self.joint_count):
            s = self.first_joint+i
            p0, p1 = self.end(x, s, 0), self.end(x, s, 1)
            self.multiplier[i] = ((p1+self.multiplier[i]).astype(F)-p0).astype(F)

    def joint_templates(self, n):
        """Host constant templates of the joint springs: off-diagonal {(i, j): sum k (s_i w_i)(s_j w_j)} and the
        diagonal, accumulated in float32 in spring order as F(F(k w_i) w_j) (checked bitwise against the dumps)."""
        off, diag = {}, np.zeros(n, F)
        for s in range(self.first_joint, len(self.pairs)):
            ents = []
            for side, sign in ((0, F(1)), (1, F(-1))):
                b = self.pairs[s, side]
                if b >= 0:
                    w = (self.w0 if side == 0 else self.w1)[s]
                    ents += [(int(self.indices[b][j]), F(sign*w[j])) for j in range(4)]
            for i, wi in ents:
                for j, wj in ents:
                    v = F(F(self.k[s]*wi)*wj)
                    if i == j:
                        diag[i] = F(diag[i]+v)
                    else:
                        off[(i, j)] = F(off.get((i, j), F(0))+v)
        return off, diag


def _accumulate_template(off, diag, k, ents):
    """k (s_i)(s_j) over all entry pairs as F(F(k s_i) s_j), diagonal for equal particles, in entry order."""
    for i, wi in ents:
        for j, wj in ents:
            v = F(F(k*wi)*wj)
            if i == j:
                diag[i] = F(diag[i]+v)
            else:
                off[(i, j)] = F(off.get((i, j), F(0))+v)


def plain_templates(n, springs=None, lines=None):
    """Host constant templates of the plain (non-joint) body springs and point-lines: springs with weights
    (+w0, -w1) per end, point-lines with (-w_pt) for the point and (we0 + we1)/2 for the line body."""
    off, diag = {}, np.zeros(n, F)
    if springs is not None:
        for s in range(springs.first_joint):
            ents = []
            for side, sign in ((0, F(1)), (1, F(-1))):
                b = springs.pairs[s, side]
                if b >= 0:
                    w = (springs.w0 if side == 0 else springs.w1)[s]
                    ents += [(int(springs.indices[b][j]), F(sign*w[j])) for j in range(4)]
            _accumulate_template(off, diag, springs.k[s], ents)
    if lines is not None:
        for j in range(lines.first_joint):
            ents = [(int(t), F(-w)) for t, w in zip(lines.indices[lines.pairs[j, 0]], lines.w_pt[j])]
            lb = lines.pairs[j, 1]
            if lb >= 0:
                half = (F(0.5)*(lines.w_e0[j]+lines.w_e1[j]).astype(F)).astype(F)
                ents += [(int(t), F(w)) for t, w in zip(lines.indices[lb], half)]
            _accumulate_template(off, diag, lines.k[j], ents)
    return off, diag

class DistanceConstraints:
    """Augmented-Lagrangian body distance constraints (Model.body_distance_constraint_*): per constraint a target
    vector r (|r| = rest along the current separation) and a multiplier lambda; the force is
    alpha m_s ((p1 - p0) - r + lambda) (mass scale m_s), its stiffness lives in the host templates."""
    def __init__(self, pairs, points0, points1, weights0, weights1, rest, mass_scale, indices):
        self.pairs = np.asarray(pairs, np.int32).reshape(-1, 2)
        self.points0 = np.asarray(points0, F).reshape(-1, 3)
        self.points1 = np.asarray(points1, F).reshape(-1, 3)
        self.w0 = np.asarray(weights0, F).reshape(-1, 4)
        self.w1 = np.asarray(weights1, F).reshape(-1, 4)
        self.rest = np.asarray(rest, F)
        self.mass_scale = np.asarray(mass_scale, F)
        self.indices = np.asarray(indices, np.int32).reshape(-1, 4)
        m = len(self.pairs)
        self.target = np.zeros((m, 3), F)
        self.multiplier = np.zeros((m, 3), F)

    def end(self, x, c, side):
        b = self.pairs[c, side]
        if b < 0:
            return (self.points0 if side == 0 else self.points1)[c].copy()
        return _weighted((self.w0 if side == 0 else self.w1)[c], [x[i] for i in self.indices[b]])

    def templates(self, n):
        """Host templates D5/L6 (weight constraint_alpha): m_s (s_i)(s_j) with s = (+w0, -w1), constraint order."""
        off, diag = {}, np.zeros(n, F)
        for c in range(len(self.pairs)):
            ents = []
            for side, sign in ((0, F(1)), (1, F(-1))):
                b = self.pairs[c, side]
                if b >= 0:
                    w = (self.w0 if side == 0 else self.w1)[c]
                    ents += [(int(self.indices[b][j]), F(sign*w[j])) for j in range(4)]
            _accumulate_template(off, diag, self.mass_scale[c], ents)
        return off, diag

    def initialize_state(self, x):
        """initialize_body_distance_constraint_state: r = d rest/|d| (|d| x first; (rest, 0, 0) when |d| <= 1e-8,
        0 when rest <= 0), lambda = 0."""
        for c in range(len(self.pairs)):
            d = (self.end(x, c, 1)-self.end(x, c, 0)).astype(F)
            rest = F(self.rest[c])
            r = np.zeros(3, F)
            if rest > 0:
                length = F(np.sqrt(fma(d[2], d[2], fma(d[1], d[1], F(d[0]*d[0])))))
                if length > TINY_LENGTH:
                    r = (d*F(rest/length)).astype(F)
                else:
                    r = np.array([rest, 0, 0], F)
            self.target[c] = r
            self.multiplier[c] = 0

    def force(self, x, alpha, out):
        """evaluate_body_distance_constraint_force: body 0 gets w0 f (four slots), then body 1 w1 (-f)."""
        ops = _Ops()
        for c in range(len(self.pairs)):
            d = (self.end(x, c, 1)-self.end(x, c, 0)).astype(F)
            f = ((((d-self.target[c]).astype(F))+self.multiplier[c]).astype(F)*F(self.mass_scale[c]*F(alpha))).astype(F)
            for side, g in ((0, f), (1, (-f).astype(F))):
                b = self.pairs[c, side]
                if b < 0:
                    continue
                w = (self.w0 if side == 0 else self.w1)[c]
                for slot in range(4):
                    for e in range(3):
                        ops.add(c, 4*side+slot, out, self.indices[b][slot], e, F(g[e]*w[slot]))
        ops.apply()

    def update_state(self, x):
        """update_body_distance_constraint_state: e = (p1 - p0) + lambda; r = e rest/|e|, else the previous r
        rescaled, else (rest, 0, 0) (lengths y first, threshold 1e-8; r = 0 for rest <= 0); lambda = e - r."""
        for c in range(len(self.pairs)):
            d = (self.end(x, c, 1)-self.end(x, c, 0)).astype(F)
            e = (d+self.multiplier[c]).astype(F)
            old = self.target[c]
            rest = F(self.rest[c])
            r = np.zeros(3, F)
            if rest > 0:
                length = F(np.sqrt(fma(e[2], e[2], fma(e[0], e[0], F(e[1]*e[1])))))
                if length > TINY_LENGTH:
                    r = (e*F(rest/length)).astype(F)
                else:
                    length = F(np.sqrt(fma(old[2], old[2], fma(old[0], old[0], F(old[1]*old[1])))))
                    r = (old*F(rest/length)).astype(F) if length > TINY_LENGTH else np.array([rest, 0, 0], F)
            self.multiplier[c] = (e-r).astype(F)
            self.target[c] = r

# ---------------------------------------------------------------------------------------------------------------
# Joint drives (evaluate_joint_drive_load), angular branch.

ANGLE_EPS = F(np.frombuffer(np.uint32(0x322BCC77).tobytes(), F)[0])     # 1e-8
SINCOS_EPS = F(np.frombuffer(np.uint32(0x2B8CBCCC).tobytes(), F)[0])    # 1e-12
TWO_PI = F(np.frombuffer(np.uint32(0x40C90FDB).tobytes(), F)[0])
_bits = lambda u: F(np.frombuffer(np.uint32(u).tobytes(), F)[0])


def _copysign(v, s):
    return F(abs(F(v))) if not np.signbit(F(s)) else F(-abs(F(v)))


def atan2f(y, x):
    """CUDA's atan2f as inlined in the PTX (minimax rational on [0, 1], quadrant fix-ups, sign of y)."""
    y, x = F(y), F(x)
    ay, ax = F(abs(y)), F(abs(x))
    if ax == 0 and ay == 0:
        return _copysign(_bits(0x40490FDB) if np.signbit(x) else F(0), y)
    if ax == np.inf and ay == np.inf:
        return _copysign(_bits(0x4016CBE4) if np.signbit(x) else _bits(0x3F490FDB), y)
    a = F(min(ay, ax)/max(ay, ax))
    s = F(a*a)
    p = fma(s, _bits(0xBF52C7EA), _bits(0xC0B59883))
    p = fma(p, s, _bits(0xC0D21907))
    t = F(a*F(s*p))
    q = F(s+_bits(0x41355DC0))
    q = fma(q, s, _bits(0x41E6BD60))
    q = fma(q, s, _bits(0x419D92C8))
    r = fma(t, F(F(1)/q), a)
    if ay > ax:
        r = F(_bits(0x3FC90FDB)-r)
    if np.signbit(x):
        r = F(_bits(0x40490FDB)-r)
    total = F(ax+ay)
    if not total <= np.inf:
        return total
    return _copysign(r, y)


def _add_rz(a, b):
    """add.rz.f32: the exact sum rounded toward zero."""
    exact = np.float64(a)+np.float64(b)
    r = F(exact)
    if abs(np.float64(r)) > abs(exact):
        r = np.nextafter(r, F(0), dtype=F)
    return F(r)


def _weighted(w, cols):
    """fma(w3, a2, fma(w2, a1, fma(w0, t, w1 a0))) for the 4 state rows `cols`."""
    t, a0, a1, a2 = (np.asarray(c, F) for c in cols)
    p = fma(w[0], t, (F(w[1])*a0).astype(F))
    p = fma(w[2], a1, p)
    return np.asarray(fma(w[3], a2, p), F)


def _dot_y(u, v):
    return F(fma(u[2], v[2], fma(u[0], v[0], F(u[1]*v[1]))))


def _unit(v):
    length = F(np.sqrt(_dot_y(v, v)))
    if not length > 0:
        return np.zeros(3, F), length
    return np.array([F(c/length) for c in v], F), length


def _reject(e, u, proj):
    """e - u proj, contracted by ptxas to fma(-u, proj, e)."""
    return np.asarray(fma(-u, proj, e), F)


def _cross_fms(a, b):
    from .numerics import fms
    return np.array([fms(a[1], b[2], a[2], b[1]), fms(a[2], b[0], a[0], b[2]), fms(a[0], b[1], a[1], b[0])], F)


def _cross_ref(a, b):
    """p x c of the angle frame: ptxas fuses the subtrahend product in the x component and the minuend in y, z."""
    from .numerics import fms
    return np.array([F(fma(-a[2], b[1], F(a[1]*b[2]))), fms(a[2], b[0], a[0], b[2]), fms(a[0], b[1], a[1], b[0])], F)


def _angle_frame(op, ap, rp, oc, rc):
    """Axis u, |axis|, normalized perpendicular references and (sin, cos) of the child relative to the parent;
    None when the kernel exits."""
    d = (ap-op).astype(F)
    length = F(np.sqrt(_dot_y(d, d)))
    if not length > ANGLE_EPS or not length < np.inf:
        return None
    u = np.array([F(c/length) for c in d], F)
    ep = (rp-op).astype(F)
    proj_p = _dot_y(ep, u)
    perp_p = _reject(ep, u, proj_p)
    ec = (rc-oc).astype(F)
    proj_c = F(fma(u[2], ec[2], fma(u[0], ec[0], F(u[1]*ec[1]))))
    perp_c = _reject(ec, u, proj_c)
    np_, nc = F(np.sqrt(_dot_y(perp_p, perp_p))), F(np.sqrt(_dot_y(perp_c, perp_c)))
    if not np_ > ANGLE_EPS or not nc > ANGLE_EPS or not np_ < np.inf or not nc < np.inf:
        return None
    ph = np.array([F(c/np_) for c in perp_p], F)
    ch = np.array([F(c/nc) for c in perp_c], F)
    cr = _cross_ref(ph, ch)
    sin = _dot_y(u, cr)
    cos = _dot_y(ph, ch)
    mag = F(fma(cos, cos, F(sin*sin)))
    if not mag > SINCOS_EPS or not mag < np.inf:
        return None
    return dict(u=u, length=length, proj_p=proj_p, proj_c=proj_c, np=np_, nc=nc, ph=ph, ch=ch, sin=sin, cos=cos)


class Drives:
    """Joint drive arrays (Model.joint_drive_*, joint_target_*, joint_*). Weights are the host's (1, p - com)
    per drive point; world-side points stay in world space."""
    def __init__(self, pairs, types, parent_origins, parent_axis_points, parent_reference_points, child_origins,
                 child_reference_points, dof, target, indices, com):
        self.pairs = np.asarray(pairs, np.int32).reshape(-1, 2)
        self.types = np.asarray(types, np.int32)
        self.po = np.asarray(parent_origins, F).reshape(-1, 3)
        self.pa = np.asarray(parent_axis_points, F).reshape(-1, 3)
        self.pr = np.asarray(parent_reference_points, F).reshape(-1, 3)
        self.co = np.asarray(child_origins, F).reshape(-1, 3)
        self.cr = np.asarray(child_reference_points, F).reshape(-1, 3)
        self.dof = np.asarray(dof, np.int32)
        self.target = np.asarray(target, np.int32)
        self.indices = np.asarray(indices, np.int32).reshape(-1, 4)
        self.w_po = spring_weights(self.po, self.pairs[:, 0], com)
        self.w_pa = spring_weights(self.pa, self.pairs[:, 0], com)
        self.w_pr = spring_weights(self.pr, self.pairs[:, 0], com)
        self.w_co = spring_weights(self.co, self.pairs[:, 1], com)
        self.w_cr = spring_weights(self.cr, self.pairs[:, 1], com)

    def _points(self, i, x):
        b0, b1 = self.pairs[i]
        if b0 >= 0:
            cols = [x[j] for j in self.indices[b0]]
            op, ap, rp = _weighted(self.w_po[i], cols), _weighted(self.w_pa[i], cols), _weighted(self.w_pr[i], cols)
        else:
            op, ap, rp = self.po[i], self.pa[i], self.pr[i]
        cols = [x[j] for j in self.indices[b1]]
        return op, ap, rp, _weighted(self.w_co[i], cols), _weighted(self.w_cr[i], cols)


def evaluate_joint_drive_load(drives, x, previous, qd, angle, initialized, ke, kd, effort, modes, damping, feed,
                              target_q, target_qd, inv_h, force):
    """evaluate_joint_drive_load, angular drives (types != 0). The drive torque
        tau = feed + clamp(ke (q* - q0) + kd (v* - qd0)) - c qd0 - (kd + c)((q - q0)/h - qd0)
    uses the unwrapped start-of-step angle q0 (kept in `angle`/`initialized`) and the current angle q from atan2,
    and is applied through the angle Jacobian of the child and parent reference points. Indexing (single world):
    gains, effort limit, mode and passive damping by the drive's dof, feed-forward and target velocity by the dof,
    target position by the target index, qd0 and the angle state by the drive."""
    from .rigid_contact import _Ops
    ops = _Ops()
    inv_h = F(inv_h)
    for i in range(len(drives.pairs)):
        if drives.types[i] == 0:
            _prismatic_load(drives, i, x, previous, qd, ke, kd, effort, modes, damping, feed, target_q, target_qd,
                            inv_h, ops)
            continue
        b0 = drives.pairs[i, 0]
        cur = _angle_frame(*drives._points(i, x))
        if cur is None:
            continue
        u, length = cur['u'], cur['length']
        theta = atan2f(cur['sin'], cur['cos'])
        upc = _cross_fms(u, cur['ph'])
        ucc = _cross_fms(u, cur['ch'])
        sp = F(cur['proj_p']/cur['np'])
        sc = F(cur['proj_c']/cur['nc'])
        from .numerics import fms
        # ptxas fuses the subtrahend product here: fma(-sc, ucc, sp upc).
        axis_term = np.array([F(F(fma(-sc, ucc[k], F(sp*upc[k])))/length) for k in range(3)], F)
        gp = np.array([F(upc[k]/cur['np']) for k in range(3)], F)
        gp_neg = np.array([F(-upc[k]/cur['np']) for k in range(3)], F)
        gc_neg = np.array([F(-ucc[k]/cur['nc']) for k in range(3)], F)
        gc = np.array([F(ucc[k]/cur['nc']) for k in range(3)], F)
        prev = _angle_frame(*drives._points(i, previous))
        if prev is None:
            continue
        theta0 = atan2f(prev['sin'], prev['cos'])
        d, t = drives.dof[i], drives.target[i]
        if initialized[i] != 0:
            theta0 = F(angle[i])
        else:
            angle[i] = theta0
            initialized[i] = 1
        turns = F(F(theta0-theta)/TWO_PI)
        k = F(np.trunc(_add_rz(turns, _copysign(F(0.5), turns))))
        q = F(fma(k, TWO_PI, theta))
        mode = int(modes[d]) if modes is not None else 3
        load = F(0)
        if (mode | 2) == 3:
            load = F(fma(F(F(target_q[t])-theta0), F(ke[d]), F(0)))
        dq = F(q-theta0)
        v0 = F(qd[i])
        if mode == 1:
            load = F(fma(-v0, F(kd[d]), load))
        elif (mode | 1) == 3:
            load = F(fma(F(F(target_qd[d])-v0), F(kd[d]), load))
        limit = F(effort[d])
        load = min(limit, max(-limit, load))
        c = F(damping[d]) if damping is not None else F(0)
        tau = F(fma(-v0, c, F(F(feed[d])+load)))
        kd_eff = F(kd[d]) if (modes is None or 1 <= mode <= 3) else F(0)
        rate = F(fma(dq, inv_h, -v0))
        tau = F(fma(-rate, F(kd_eff+c), tau))
        if not abs(tau) < np.inf or not abs(tau) > SINCOS_EPS:
            continue
        child = drives.indices[drives.pairs[i, 1]]
        for slot in range(4):
            g = np.asarray(fma(gc_neg, drives.w_co[i][slot], (gc*drives.w_cr[i][slot]).astype(F)), F)
            for e in range(3):
                ops.add(i, slot, force, child[slot], e, F(tau*g[e]))
        if b0 < 0:
            continue
        parent = drives.indices[b0]
        diff = (gp-axis_term).astype(F)
        for slot in range(4):
            h = np.asarray(fma(diff, drives.w_po[i][slot], (axis_term*drives.w_pa[i][slot]).astype(F)), F)
            h = np.asarray(fma(gp_neg, drives.w_pr[i][slot], h), F)
            for e in range(3):
                ops.add(i, 4+slot, force, parent[slot], e, F(tau*h[e]))
    ops.ops = [op if op[4] is not None else op[:4]+(force,)+op[5:] for op in ops.ops]
    ops.apply()


def _drive_jacobian(drives, i, x, axis_minuend=False):
    """Angle Jacobian rows (child slots 0-3, parent slots 0-3 or None) of drive i at positions x, None when the
    kernels exit; identical arithmetic in the load, preconditioner and tangent kernels. evaluate_angular_limits
    differs only in the axis term, where ptxas fuses the minuend product instead (axis_minuend)."""
    cur = _angle_frame(*drives._points(i, x))
    if cur is None:
        return None
    length = cur['length']
    upc = _cross_fms(cur['u'], cur['ph'])
    ucc = _cross_fms(cur['u'], cur['ch'])
    sp, sc = F(cur['proj_p']/cur['np']), F(cur['proj_c']/cur['nc'])
    if axis_minuend:
        axis_term = np.array([F(F(fma(sp, upc[k], -F(sc*ucc[k])))/length) for k in range(3)], F)
    else:
        axis_term = np.array([F(F(fma(-sc, ucc[k], F(sp*upc[k])))/length) for k in range(3)], F)
    gp = np.array([F(upc[k]/cur['np']) for k in range(3)], F)
    gp_neg = np.array([F(-upc[k]/cur['np']) for k in range(3)], F)
    gc_neg = np.array([F(-ucc[k]/cur['nc']) for k in range(3)], F)
    gc = np.array([F(ucc[k]/cur['nc']) for k in range(3)], F)
    child = [np.asarray(fma(gc_neg, drives.w_co[i][s], (gc*drives.w_cr[i][s]).astype(F)), F) for s in range(4)]
    parent = None
    if drives.pairs[i, 0] >= 0:
        diff = (gp-axis_term).astype(F)
        parent = []
        for s in range(4):
            h = np.asarray(fma(diff, drives.w_po[i][s], (axis_term*drives.w_pa[i][s]).astype(F)), F)
            parent.append(np.asarray(fma(gp_neg, drives.w_pr[i][s], h), F))
    return child, parent


def _drive_scale(drives, i, kd, damping, modes, inv_h):
    """s = (kd [if the target mode uses it] + passive damping) / h; None when not positive and finite."""
    d = drives.dof[i]
    kd_eff = F(kd[d]) if (modes is None or 1 <= int(modes[d]) <= 3) else F(0)
    c = F(damping[d]) if damping is not None else F(0)
    s = F(F(kd_eff+c)*F(inv_h))
    if not s > 0 or not s < np.inf:
        return None
    return s


def add_joint_drive_preconditioner(drives, x, kd, damping, modes, inv_h, block):
    """add_joint_drive_preconditioner: s g g^T into the 3x3 diagonal block of every Jacobian entry."""
    from .rigid_contact import _Ops
    ops = _Ops()
    for i in range(len(drives.pairs)):
        s = _drive_scale(drives, i, kd, damping, modes, inv_h)
        if s is None:
            continue
        if drives.types[i] == 0:
            jac = _prismatic_rows(drives, i, x, minuend=True)
            if jac is None:
                continue
            child, parent = jac[2], jac[3]
        else:
            jac = _drive_jacobian(drives, i, x)
            if jac is None:
                continue
            child, parent = jac
        sides = [(0, drives.indices[drives.pairs[i, 1]], child)]
        if parent is not None:
            sides.append((1, drives.indices[drives.pairs[i, 0]], parent))
        # Prismatic lanes take the divergent branch, which the warp executes after the angular one.
        base = 100 if drives.types[i] == 0 else 0
        for side, ids, rows in sides:
            for slot, g in enumerate(rows):
                o = [F(g[0]*g[0]), F(g[1]*g[0]), F(g[2]*g[0]), F(g[1]*g[1]), F(g[2]*g[1]), F(g[2]*g[2])]
                m = [F(s*v) for v in o]
                values = (m[0], m[1], m[2], m[1], m[3], m[4], m[2], m[4], m[5])
                for comp in range(9):
                    ops.add(i, base+4*side+slot, block, ids[slot], comp, values[comp])
    block_flat = block.reshape(len(block), 9)
    from .rigid_contact import _red
    for *_, target, index, component, value in sorted(ops.ops, key=lambda op: op[:4]):
        _red(block_flat[index], component, value)


def multiply_joint_drive_tangent(drives, x, kd, damping, modes, inv_h, direction, product):
    """multiply_joint_drive_tangent: J^T (s J p), J p accumulated child slots first (starting from + 0), then parent."""
    from .rigid_contact import _Ops
    ops = _Ops()
    for i in range(len(drives.pairs)):
        s = _drive_scale(drives, i, kd, damping, modes, inv_h)
        if s is None:
            continue
        if drives.types[i] == 0:
            _prismatic_tangent(drives, i, x, s, direction, ops)
            continue
        jac = _drive_jacobian(drives, i, x)
        if jac is None:
            continue
        child, parent = jac
        sides = [(0, drives.indices[drives.pairs[i, 1]], child)]
        if parent is not None:
            sides.append((1, drives.indices[drives.pairs[i, 0]], parent))
        jp = F(0)
        for _, ids, rows in sides:
            for slot, g in enumerate(rows):
                jp = F(jp+_dot_y(g, np.asarray(direction[ids[slot]], F)))
        y = F(s*jp)
        if not abs(y) < np.inf:
            continue
        for side, ids, rows in sides:
            for slot, g in enumerate(rows):
                for e in range(3):
                    ops.add(i, 4*side+slot, product, ids[slot], e, F(y*g[e]))
    ops.ops = [op if op[4] is not None else op[:4]+(product,)+op[5:] for op in ops.ops]
    ops.apply()


def update_joint_drive_angle_state(drives, x, angle, initialized):
    """update_joint_drive_angle_state (after update_velocity): for revolute drives (type 1) store the angle at x
    unwrapped next to the stored one (or as is on first use) and mark it initialized."""
    for i in range(len(drives.pairs)):
        if drives.types[i] != 1:
            continue
        frame = _angle_frame(*drives._points(i, x))
        if frame is None:
            continue
        theta = atan2f(frame['sin'], frame['cos'])
        ref = F(angle[i]) if initialized[i] != 0 else theta
        turns = F(F(ref-theta)/TWO_PI)
        k = F(np.trunc(_add_rz(turns, _copysign(F(0.5), turns))))
        angle[i] = F(fma(k, TWO_PI, theta))
        initialized[i] = 1


def evaluate_angular_limits(drives, x, previous, angle, initialized, lower, upper, limit_ke, limit_kd, inv_h,
                            direction=None, force=None, block=None):
    """evaluate_angular_limits (revolute drives, type 1). Beyond a stop the joint gets the one-sided torque
        tau = max(0, ke (lower - q) - kd w) below `lower`, min(0, ke (upper - q) - kd w) above `upper`,
    w = (q - q0)/h with q0 the stored start-of-step angle (or the one at `previous`). Modes as in the legacy launch:
    force (tau J), preconditioner (block, s g g^T with s = kd/h + ke, child/parent interleaved per slot) and
    tangent (direction, J^T s J p with J p accumulated child/parent interleaved)."""
    from .numerics import fms
    from .rigid_contact import _Ops, _red
    ops = _Ops()
    inv_h = F(inv_h)
    for i in range(len(drives.pairs)):
        if drives.types[i] != 1:
            continue
        d = drives.dof[i]
        ke, kd = F(limit_ke[d]), F(limit_kd[d])
        if ke == 0 and kd == 0:
            continue
        cur = _angle_frame(*drives._points(i, x))
        if cur is None:
            continue
        theta = atan2f(cur['sin'], cur['cos'])
        if initialized[i] != 0:
            theta0 = F(angle[i])
        else:
            prev = _angle_frame(*drives._points(i, previous))
            if prev is None:
                continue
            theta0 = atan2f(prev['sin'], prev['cos'])
        turns = F(F(theta0-theta)/TWO_PI)
        k = F(np.trunc(_add_rz(turns, _copysign(F(0.5), turns))))
        q = F(fma(k, TWO_PI, theta))
        w = F(F(q-theta0)*inv_h)
        lo, hi = F(lower[d]), F(upper[d])
        if q < lo:
            tau = max(F(0), fms(ke, F(lo-q), kd, w))
        elif q > hi:
            tau = min(F(0), fms(ke, F(hi-q), kd, w))
        else:
            continue
        if tau == 0 or not abs(tau) < np.inf:
            continue
        s = F(fma(kd, inv_h, ke))
        child, parent = _drive_jacobian(drives, i, x, axis_minuend=True)
        cids = drives.indices[drives.pairs[i, 1]]
        pids = drives.indices[drives.pairs[i, 0]] if parent is not None else None
        if block is not None:
            for slot in range(4):
                for side, ids, rows in ((0, cids, child), (1, pids, parent)):
                    if rows is None:
                        continue
                    g = rows[slot]
                    o = [F(g[0]*g[0]), F(g[1]*g[0]), F(g[2]*g[0]), F(g[1]*g[1]), F(g[2]*g[1]), F(g[2]*g[2])]
                    m = [F(s*v) for v in o]
                    values = (m[0], m[1], m[2], m[1], m[3], m[4], m[2], m[4], m[5])
                    for comp in range(9):
                        ops.add(i, 2*slot+side, block, ids[slot], comp, values[comp])
            continue
        if direction is not None:
            jp = F(0)
            for slot in range(4):
                for ids, rows in ((cids, child), (pids, parent)):
                    if rows is not None:
                        jp = F(jp+_dot_y(rows[slot], np.asarray(direction[ids[slot]], F)))
            tau = F(s*jp)
        for side, ids, rows in ((0, cids, child), (1, pids, parent)):
            if rows is None:
                continue
            for slot in range(4):
                for e in range(3):
                    ops.add(i, 4*side+slot, force, ids[slot], e, F(tau*rows[slot][e]))
    if block is not None:
        flat = block.reshape(len(block), 9)
        for *_, target, index, component, value in sorted(ops.ops, key=lambda op: op[:4]):
            _red(flat[index], component, value)
    else:
        ops.apply()


# ---------------------------------------------------------------------------------------------------------------
# Prismatic drives (type 0): the coordinate is the child origin's displacement along the parent axis.

def _dot_x(u, v):
    return F(fma(u[2], v[2], fma(u[1], v[1], F(u[0]*v[0]))))


def _dot_yy(u, v):
    """fma(uz, vz, fma(ux, vx, uy vy)) (y first)."""
    return _dot_y(u, v)


def _prismatic_axis(op, ap):
    """Unit parent axis u and |ap - op|, or None (|u| <= 1e-8)."""
    d = (ap-op).astype(F)
    length = F(np.sqrt(_dot_y(d, d)))
    u = np.array([F(c/length) for c in d], F) if length > 0 else np.zeros(3, F)
    if not F(np.sqrt(_dot_y(u, u))) > ANGLE_EPS:
        return None
    return u, length


def _prismatic_lever(oc, op, u, length):
    """e = ((oc - op) - ((oc - op).u) u)/|axis|: the parent-axis rotation term of the displacement Jacobian."""
    d = (oc-op).astype(F)
    proj = _dot_y(d, u)
    return np.array([F(F(fma(-proj, u[k], d[k]))/length) for k in range(3)], F), d, proj


def _prismatic_load(drives, i, x, previous, qd, ke, kd, effort, modes, damping, feed, target_q, target_qd, inv_h,
                    ops):
    op, ap, _, oc, _ = drives._points(i, x)
    axis = _prismatic_axis(op, ap)
    if axis is None:
        return
    u, length = axis
    d = (oc-op).astype(F)
    disp = _dot_y(d, u)
    op0, ap0, _, oc0, _ = drives._points(i, previous)
    d0 = (ap0-op0).astype(F)
    l0 = F(np.sqrt(_dot_x(d0, d0)))
    u0 = np.array([F(c/l0) for c in d0], F) if l0 > 0 else np.zeros(3, F)
    if not F(np.sqrt(_dot_y(u0, u0))) > ANGLE_EPS:
        return
    disp0 = _dot_y((oc0-op0).astype(F), u0)
    dof, t = drives.dof[i], drives.target[i]
    mode = int(modes[dof]) if modes is not None else 3
    load = F(0)
    if (mode | 2) == 3:
        load = F(fma(F(F(target_q[t])-disp0), F(ke[dof]), F(0)))
    v0 = F(qd[i])
    if mode == 1:
        load = F(fma(-v0, F(kd[dof]), load))
    elif (mode | 1) == 3:
        load = F(fma(F(F(target_qd[dof])-v0), F(kd[dof]), load))
    limit = F(effort[dof])
    load = min(limit, max(-limit, load))
    c = F(damping[dof]) if damping is not None else F(0)
    tau = F(fma(-v0, c, F(F(feed[dof])+load)))
    kd_eff = F(kd[dof]) if (modes is None or 1 <= mode <= 3) else F(0)
    rate = F(fma(F(disp-disp0), inv_h, -v0))
    tau = F(fma(-rate, F(kd_eff+c), tau))
    if not abs(tau) < np.inf or not abs(tau) > SINCOS_EPS:
        return
    tu = (tau*u).astype(F)
    child = drives.indices[drives.pairs[i, 1]]
    for slot in range(4):
        for e in range(3):
            ops.add(i, 100+slot, None, child[slot], e, F(tu[e]*drives.w_co[i][slot]))
    if drives.pairs[i, 0] < 0 or not length > ANGLE_EPS:
        return
    parent = drives.indices[drives.pairs[i, 0]]
    lever = np.array([F(F(fma(-disp, u[k], d[k]))/length) for k in range(3)], F)
    a = (lever+u).astype(F)
    an = (a*F(-tau)).astype(F)
    for slot in range(4):
        for e in range(3):
            ops.add(i, 104+slot, None, parent[slot], e, F(an[e]*drives.w_po[i][slot]))
    et = (lever*tau).astype(F)
    for slot in range(4):
        for e in range(3):
            ops.add(i, 108+slot, None, parent[slot], e, F(et[e]*drives.w_pa[i][slot]))


def _prismatic_rows(drives, i, x, minuend):
    """Prismatic Jacobian rows: child w_co[k] u, parent e w_pa[k] - (e + u) w_po[k] (None without a parent or
    when |axis| <= 1e-8); None when the kernel exits."""
    from .numerics import fms
    op, ap, _, oc, _ = drives._points(i, x)
    axis = _prismatic_axis(op, ap)
    if axis is None:
        return None
    u, length = axis
    child = [(F(drives.w_co[i][s])*u).astype(F) for s in range(4)]
    parent = None
    if drives.pairs[i, 0] >= 0 and length > ANGLE_EPS:
        lever, _, _ = _prismatic_lever(oc, op, u, length)
        a = (lever+u).astype(F)
        if minuend:
            parent = [np.array([fms(lever[k], drives.w_pa[i][s], a[k], drives.w_po[i][s]) for k in range(3)], F)
                      for s in range(4)]
        else:
            parent = [np.array([F(fma(-a[k], drives.w_po[i][s], F(lever[k]*drives.w_pa[i][s]))) for k in range(3)], F)
                      for s in range(4)]
    return u, length, child, parent


def _prismatic_tangent(drives, i, x, s, direction, ops):
    """Prismatic branch of multiply_joint_drive_tangent: J p = (dOc - dOp).u [+ (dAp - dOp).e], y = s J p."""
    op, ap, _, oc, _ = drives._points(i, x)
    axis = _prismatic_axis(op, ap)
    if axis is None:
        return
    u, length = axis
    b0 = drives.pairs[i, 0]
    child = drives.indices[drives.pairs[i, 1]]
    d_oc = _weighted(drives.w_co[i], [direction[j] for j in child])
    d_op = np.zeros(3, F)
    if b0 >= 0:
        parent = drives.indices[b0]
        d_op = _weighted(drives.w_po[i], [direction[j] for j in parent])
    jp = _dot_y((d_oc-d_op).astype(F), u)
    if b0 >= 0:
        if not length > ANGLE_EPS:
            return
        d_ap = _weighted(drives.w_pa[i], [direction[j] for j in parent])
        lever, _, _ = _prismatic_lever(oc, op, u, length)
        jp = F(jp+_dot_y((d_ap-d_op).astype(F), lever))
    y = F(s*jp)
    yu = (y*u).astype(F)
    # Divergent paths in a warp: angular lanes, then parentless prismatic lanes (their own code block), then
    # prismatic lanes with a parent.
    cbase = 100 if b0 >= 0 else 50
    for slot in range(4):
        for e in range(3):
            ops.add(i, cbase+slot, None, child[slot], e, F(drives.w_co[i][slot]*yu[e]))
    if b0 < 0:
        return
    an = ((lever+u).astype(F)*F(-y)).astype(F)
    for slot in range(4):
        for e in range(3):
            ops.add(i, 104+slot, None, parent[slot], e, F(an[e]*drives.w_po[i][slot]))
    ey = (lever*y).astype(F)
    for slot in range(4):
        for e in range(3):
            ops.add(i, 108+slot, None, parent[slot], e, F(ey[e]*drives.w_pa[i][slot]))


# ---------------------------------------------------------------------------------------------------------------
# Joint point-line constraints (prismatic joints): a point of one body kept on a segment of another body.

def _mat_cols(m, v):
    """glm::mat3 (column-major m[0..8]) times v: fma(vz, m[6+r], fma(vx, m[r], vy m[3+r]))."""
    return np.array([F(fma(v[2], m[6+r], fma(v[0], m[r], F(v[1]*m[3+r])))) for r in range(3)], F)


def _projector(d, rel, dot):
    """(s, P): s = clamp(rel.d/|d|^2, -1/2, 1/2); P = I - d d^T/|d|^2 when strictly inside, else I."""
    eye = np.array([1, 0, 0, 0, 1, 0, 0, 0, 1], F)
    yy, xx, zz = F(d[1]*d[1]), F(d[0]*d[0]), F(d[2]*d[2])
    n2 = F(zz+F(yy+xx))
    if not n2 > SINCOS_EPS:
        return F(0), eye
    t = F(dot(rel, d)/n2)
    s = min(F(0.5), max(F(-0.5), t))
    if not (t > F(-0.5) and t < F(0.5)):
        return s, eye
    xy, xz, yz = F(F(d[1]*d[0])/n2), F(F(d[2]*d[0])/n2), F(F(d[2]*d[1])/n2)
    p = np.array([F(1)-F(xx/n2), F(0)-xy, F(0)-xz, F(0)-xy, F(1)-F(yy/n2), F(0)-yz, F(0)-xz, F(0)-yz,
                  F(1)-F(zz/n2)], F)
    return s, p


class PointLines:
    """Body point-line arrays (Model.body_point_line_*); the last `joint_count` are joint constraints with an
    augmented-Lagrangian state (segment parameter s, multiplier, frozen projector)."""
    def __init__(self, pairs, points, end0, end1, stiffness, joint_count, indices, com):
        self.pairs = np.asarray(pairs, np.int32).reshape(-1, 2)
        self.points = np.asarray(points, F).reshape(-1, 3)
        self.end0 = np.asarray(end0, F).reshape(-1, 3)
        self.end1 = np.asarray(end1, F).reshape(-1, 3)
        self.k = np.asarray(stiffness, F)
        self.joint_count = int(joint_count)
        self.indices = np.asarray(indices, np.int32).reshape(-1, 4)
        self.w_pt = spring_weights(self.points, self.pairs[:, 0], com)
        self.w_e0 = spring_weights(self.end0, self.pairs[:, 1], com)
        self.w_e1 = spring_weights(self.end1, self.pairs[:, 1], com)
        m = self.joint_count
        self.s = np.zeros(m, F)
        self.multiplier = np.zeros((m, 3), F)
        self.projector = np.tile(np.array([1, 0, 0, 0, 1, 0, 0, 0, 1], F), (m, 1))

    @property
    def first_joint(self):
        return len(self.pairs)-self.joint_count

    def _geometry(self, x, j):
        p = _weighted(self.w_pt[j], [x[i] for i in self.indices[self.pairs[j, 0]]])
        we0, we1 = self.w_e0[j], self.w_e1[j]
        dw = (we1-we0).astype(F)
        lb = self.pairs[j, 1]
        if lb >= 0:
            cols = [x[i] for i in self.indices[lb]]
            mid = _weighted((F(0.5)*(we0+we1).astype(F)).astype(F), cols)
            d = _weighted(dw, cols)
        else:
            mid = (F(0.5)*(self.end0[j]+self.end1[j]).astype(F)).astype(F)
            d = (self.end1[j]-self.end0[j]).astype(F)
        return p, mid, d, dw

    def _plain_geometry(self, x, j):
        """(p, wq, q, t) of evaluate_body_point_line_force: closest point of the segment, t clamped to [0, 1]."""
        p = _weighted(self.w_pt[j], [x[i] for i in self.indices[self.pairs[j, 0]]])
        lb = self.pairs[j, 1]
        if lb >= 0:
            cols = [x[i] for i in self.indices[lb]]
            a, b = _weighted(self.w_e0[j], cols), _weighted(self.w_e1[j], cols)
        else:
            a, b = self.end0[j].copy(), self.end1[j].copy()
        d = (b-a).astype(F)
        dd = F(fma(d[2], d[2], fma(d[0], d[0], F(d[1]*d[1]))))
        t = F(0)
        if dd > SEGMENT_EPS:
            r = (p-a).astype(F)
            t = F(min(max(F(F(fma(r[2], d[2], fma(r[0], d[0], F(r[1]*d[1]))))/dd), F(0)), F(1)))
        wq = np.asarray(fma(self.w_e0[j], F(F(1)-t), (t*self.w_e1[j]).astype(F)), F)
        q = np.asarray(fma(d, t, a), F)
        return p, wq, q, t

    def plain_force(self, x, alpha, include_joints, force):
        """evaluate_body_point_line_force: penalty f = k (q - p) towards the closest segment point (alpha k for the
        trailing joint lines, which are skipped unless `include_joints`); skipped when |f|^2 <= 1e-12. Point body
        w_pt f and line body wq (-f), slots interleaved."""
        ops = _Ops()
        plain = len(self.pairs)-self.joint_count
        for j in range(len(self.pairs)):
            if j >= plain and not include_joints:
                continue
            p, wq, q, _ = self._plain_geometry(x, j)
            k = F((F(1) if j < plain else F(alpha))*self.k[j])
            f = ((q-p).astype(F)*k).astype(F)
            if not F(fma(f[2], f[2], fma(f[0], f[0], F(f[1]*f[1])))) > SEGMENT_EPS:
                continue
            pids = self.indices[self.pairs[j, 0]]
            lb = self.pairs[j, 1]
            for slot in range(4):
                for e in range(3):
                    ops.add(j, 2*slot, force, pids[slot], e, F(f[e]*self.w_pt[j][slot]))
                if lb >= 0:
                    lid = self.indices[lb][slot]
                    for e in range(3):
                        ops.add(j, 2*slot+1, force, lid, e, F(wq[slot]*F(-f[e])))
        ops.apply()

    def add_plain_hessian(self, x, alpha, include_joints, diagonal, ell):
        """add_body_point_line_gauss_newton_hessian: Gauss-Newton blocks of the penalty k |q(t) - p|^2 with the
        closest-point parameter t differentiated while 0 < t < 1 (and |d|^2 > 1e-12). Each Jacobian entry carries a
        3x3 J (columns C_j = d v_j + base e_j) and the scalar weight s of the host constant template:
          point slot (weight w):      base = 0 t - w, v = (d w + 0 g)/dd,                       s = -w
          line slot (we0, we1):       base = fma(t, we1 - we0, we0), v = (d (0 - we0) + g (we1 - we0))/dd,
                                      s = (we0 + we1)/2
        with r = p - a, d = b - a, g = r - 2 t d. Blocks k (J_a^T J_b - s_a s_b I) (dot products y first): the
        diagonal block of a, then every later b into (a, b) and transposed into (b, a)."""
        from .rigid_contact import _red
        row_nnz, cols, blocks, max_nnz = ell
        plain = len(self.pairs)-self.joint_count
        ops = []
        for j in range(len(self.pairs)):
            if j >= plain and not include_joints:
                continue
            k = F((F(alpha) if j >= plain else F(1))*self.k[j])
            if not k > 0:
                continue
            p = _weighted(self.w_pt[j], [x[i] for i in self.indices[self.pairs[j, 0]]])
            lb = self.pairs[j, 1]
            if lb >= 0:
                lcols = [x[i] for i in self.indices[lb]]
                a, b = _weighted(self.w_e0[j], lcols), _weighted(self.w_e1[j], lcols)
            else:
                a, b = self.end0[j].copy(), self.end1[j].copy()
            r = (p-a).astype(F)
            d = (b-a).astype(F)
            dd = F(fma(d[2], d[2], fma(d[0], d[0], F(d[1]*d[1]))))
            t_raw = F(0)
            if dd > SEGMENT_EPS:
                t_raw = F(F(fma(r[2], d[2], fma(r[0], d[0], F(r[1]*d[1]))))/dd)
            t = F(min(max(t_raw, F(0)), F(1))) if t_raw == t_raw else F(0)
            interior = dd > SEGMENT_EPS and t_raw > 0 and t_raw < 1
            zero_t = F(fma(t, F(0), F(0)))
            g = fma(-d, F(t+t), r).astype(F)  # ptxas contracts r - d (2t)
            gz = (g*F(0)).astype(F)

            def jacobian(base, v):
                m = np.empty(9, F)
                for jj in range(3):
                    for ii in range(3):
                        b0 = base if ii == jj else F(base*F(0))
                        m[3*jj+ii] = F(fma(d[ii], v[jj], b0)) if interior else b0
                return m

            ents = []
            for slot in range(4):
                w = F(self.w_pt[j][slot])
                v = [F(F(fma(d[c], w, gz[c]))/dd) for c in range(3)] if interior else None
                ents.append((int(self.indices[self.pairs[j, 0]][slot]), F(-w), jacobian(F(zero_t-w), v)))
            if lb >= 0:
                for slot in range(4):
                    we0, we1 = F(self.w_e0[j][slot]), F(self.w_e1[j][slot])
                    dw = F(we1-we0)
                    base = F(fma(t, dw, we0))
                    v = [F(F(fma(d[c], F(F(0)-we0), F(g[c]*dw)))/dd) for c in range(3)] if interior else None
                    ents.append((int(self.indices[lb][slot]), F(F(we0+we1)*F(0.5)), jacobian(base, v)))

            def dot(u, v):
                return F(fma(u[2], v[2], fma(u[0], v[0], F(u[1]*v[1]))))

            for ia_, (ia, sa, ja) in enumerate(ents):
                ca = [ja[0:3], ja[3:6], ja[6:9]]
                s2 = F(sa*sa)
                s2z = F(s2*F(0))
                m = [[dot(ca[i], ca[jj]) for jj in range(3)] for i in range(3)]
                diag_block = [F(k*F(m[0][0]-s2)), F(k*F(m[1][0]-s2z)), F(k*F(m[2][0]-s2z)),
                              F(k*F(m[1][0]-s2z)), F(k*F(m[1][1]-s2)), F(k*F(m[2][1]-s2z)),
                              F(k*F(m[2][0]-s2z)), F(k*F(m[2][1]-s2z)), F(k*F(m[2][2]-s2))]
                ops.append(((-(j//32), ia_, -1, 0, j % 32), ('d', ia), diag_block))
                for ib_ in range(ia_+1, len(ents)):
                    ib, sb, jb = ents[ib_]
                    cb = [jb[0:3], jb[3:6], jb[6:9]]
                    sab = F(sa*sb)
                    sabz = F(sab*F(0))
                    block = [F(k*F(dot(ca[i], cb[jj])-(sab if i == jj else sabz))) for jj in range(3) for i in range(3)]
                    trans = [block[3*(e % 3)+e//3] for e in range(9)]
                    first = ('d', ia) if ia == ib else ('o', ia, ib)
                    second = ('d', ib) if ia == ib else ('o', ib, ia)
                    ops.append(((-(j//32), ia_, ib_, 0, j % 32), first, block))
                    ops.append(((-(j//32), ia_, ib_, 1, j % 32), second, trans))
        for _, key, block in sorted(ops, key=lambda op: op[0]):
            if key[0] == 'd':
                for e in range(9):
                    _red(diagonal[key[1]], e, block[e])
                continue
            _, r_, col = key
            count = min(int(row_nnz[r_]), int(max_nnz))
            lo, hi = 0, count
            while hi > lo:
                mid = (hi-lo)//2+lo
                if cols[mid, r_] < col:
                    lo = mid+1
                else:
                    hi = mid
            if lo < count and cols[lo, r_] == col:
                for e in range(9):
                    _red(blocks[lo, r_], e, block[e])

    def initialize_state(self, x):
        """initialize_joint_body_point_line_state (x-first projection), lambda = 0."""
        for i in range(self.joint_count):
            p, mid, d, _ = self._geometry(x, self.first_joint+i)
            self.s[i], self.projector[i] = _projector(d, (p-mid).astype(F), _dot_x)
            self.multiplier[i] = 0

    def joint_force(self, x, alpha_h2, force):
        """evaluate_joint_body_point_line_augmented_lagrangian_force."""
        from .rigid_contact import _Ops
        ops = _Ops()
        for i in range(self.joint_count):
            j = self.first_joint+i
            p, mid, d, dw = self._geometry(x, j)
            s = self.s[i]
            q = np.asarray(fma(d, s, mid), F)
            c = (((q-p).astype(F))+self.multiplier[i]).astype(F)
            f = (_mat_cols(self.projector[i], c)*F(self.k[j]*F(alpha_h2))).astype(F)
            pids = self.indices[self.pairs[j, 0]]
            for slot in range(4):
                for e in range(3):
                    ops.add(i, slot, force, pids[slot], e, F(self.w_pt[j][slot]*f[e]))
            lb = self.pairs[j, 1]
            if lb < 0:
                continue
            wq = np.asarray(fma((self.w_e0[j]+self.w_e1[j]).astype(F), F(0.5), (s*dw).astype(F)), F)
            lids = self.indices[lb]
            for slot in range(4):
                for e in range(3):
                    ops.add(i, 4+slot, force, lids[slot], e, F(wq[slot]*F(-f[e])))
        ops.apply()

    def update_state(self, x, flag):
        """update_joint_body_point_line_augmented_lagrangian_state: s and P from p - lambda (y-first projection);
        with `flag`, lambda = P((lambda + q) - p) and s, P refreshed from p - lambda."""
        for i in range(self.joint_count):
            p, mid, d, _ = self._geometry(x, self.first_joint+i)
            lam = self.multiplier[i]
            self.s[i], self.projector[i] = _projector(d, ((p-lam).astype(F)-mid).astype(F), _dot_yy)
            if not flag:
                continue
            q = np.asarray(fma(d, self.s[i], mid), F)
            lam = _mat_cols(self.projector[i], ((lam+q).astype(F)-p).astype(F))
            self.multiplier[i] = lam
            self.s[i], self.projector[i] = _projector(d, ((p-lam).astype(F)-mid).astype(F), _dot_yy)

    def _line_weights(self, i, j):
        """wq = fma(e0 + e1, 1/2, s (e1 - e0)): the line-body weights of the closest point q."""
        dw = (self.w_e1[j]-self.w_e0[j]).astype(F)
        return np.asarray(fma((self.w_e0[j]+self.w_e1[j]).astype(F), F(0.5), (self.s[i]*dw).astype(F)), F)

    def add_preconditioner(self, alpha_h2, block):
        """add_joint_body_point_line_augmented_lagrangian_preconditioner (PD_NEWTON): (w (k w)) P into the diagonal
        block of each point-body then line-body particle; no stiffness test, unlike the Gauss-Newton Hessian."""
        from .rigid_contact import _Ops
        ops = _Ops()
        for i in range(self.joint_count):
            j = self.first_joint+i
            k = F(self.k[j]*F(alpha_h2))
            pm = self.projector[i]
            sides = [(self.indices[self.pairs[j, 0]], self.w_pt[j])]
            if self.pairs[j, 1] >= 0:
                sides.append((self.indices[self.pairs[j, 1]], self._line_weights(i, j)))
            for side, (ids, w) in enumerate(sides):
                for slot in range(4):
                    d = F(w[slot]*F(k*w[slot]))
                    for e in range(9):
                        ops.add(i, 4*side+slot, block, ids[slot], e, F(d*pm[e]))
        ops.apply()

    def multiply_tangent(self, alpha_h2, direction, product):
        """multiply_joint_body_point_line_augmented_lagrangian (PD_NEWTON, matrix free): f = k P (J_p d - J_q d);
        point-body particles get w f, line-body particles wq (-f)."""
        from .rigid_contact import _Ops
        ops = _Ops()
        for i in range(self.joint_count):
            j = self.first_joint+i
            pids = self.indices[self.pairs[j, 0]]
            u = _weighted(self.w_pt[j], [direction[t] for t in pids])
            lb = self.pairs[j, 1]
            wq = self._line_weights(i, j)
            if lb >= 0:
                lids = self.indices[lb]
                u = (u-_weighted(wq, [direction[t] for t in lids])).astype(F)
            else:
                u = (u-np.zeros(3, F)).astype(F)  # the kernel subtracts a +0 line term
            f = (_mat_cols(self.projector[i], u)*F(self.k[j]*F(alpha_h2))).astype(F)
            for slot in range(4):
                for e in range(3):
                    ops.add(i, slot, product, pids[slot], e, F(f[e]*self.w_pt[j][slot]))
            if lb < 0:
                continue
            for slot in range(4):
                for e in range(3):
                    ops.add(i, 4+slot, product, lids[slot], e, F(wq[slot]*F(-f[e])))
        ops.apply()

    def add_hessian(self, alpha_h2, diagonal, ell):
        """add_joint_body_point_line_gauss_newton_hessian: c P blocks for every pair of Jacobian entries (point
        body -w_pt, line body w_q), diagonal blocks for equal particles, else both ELL blocks (binary search)."""
        from .rigid_contact import _Ops, _red
        row_nnz, cols, blocks, _ = ell
        ops = []
        for i in range(self.joint_count):
            j = self.first_joint+i
            k = F(self.k[j]*F(alpha_h2))
            if not k > 0:
                continue
            dw = (self.w_e1[j]-self.w_e0[j]).astype(F)
            wq = np.asarray(fma((self.w_e0[j]+self.w_e1[j]).astype(F), F(0.5), (self.s[i]*dw).astype(F)), F)
            ents = [(int(t), F(-w)) for t, w in zip(self.indices[self.pairs[j, 0]], self.w_pt[j])]
            if self.pairs[j, 1] >= 0:
                ents += [(int(t), F(w)) for t, w in zip(self.indices[self.pairs[j, 1]], wq)]
            pm = self.projector[i]
            for a, (ia, wa) in enumerate(ents):
                ca = F(k*wa)
                dval = F(wa*ca)
                ops.append(((-(i//32), a, -1, 0, i % 32), ('d', ia), [F(pm[e]*dval) for e in range(9)]))
                for b in range(a+1, len(ents)):
                    ib, wb = ents[b]
                    c = F(ca*wb)
                    block = [F(pm[e]*c) for e in range(9)]
                    for which, (r, col) in enumerate(((ia, ib), (ib, ia))):
                        key = ('d', r) if r == col else ('o', r, col)
                        ops.append(((-(i//32), a, b, which, i % 32), key, block))
        # SIMT order: warps descending, then the entry-pair sequence, lanes ascending.
        for _, key, block in sorted(ops, key=lambda op: op[0]):
            if key[0] == 'd':
                for e in range(9):
                    _red(diagonal[key[1]], e, block[e])
                continue
            _, r, col = key
            slots = [s_ for s_ in range(int(row_nnz[r])) if cols[s_, r] == col]
            if slots:
                for e in range(9):
                    _red(blocks[slots[0], r], e, block[e])


def _coordinate(drives, i, x):
    """Joint coordinate at x for the armature kernel: atan2 angle (type 1) or axial displacement (type 0)."""
    if drives.types[i] == 0:
        op, ap, _, oc, _ = drives._points(i, x)
        d = (ap-op).astype(F)
        length = F(np.sqrt(_dot_y(d, d)))
        if not length > ANGLE_EPS:
            return None
        u = np.array([F(c/length) for c in d], F)
        return _dot_y((oc-op).astype(F), u)
    frame = _angle_frame(*drives._points(i, x))
    if frame is None:
        return None
    return atan2f(frame['sin'], frame['cos'])


def initialize_joint_coordinate_velocities(drives, x, velocity, axis_minuend=False, prismatic_minuend=True):
    """initialize_joint_coordinate_velocities: qd_i = J_i v (child and parent rows interleaved per slot, dots y first,
    accumulated from +0); 0 for degenerate joints. Contractions: the revolute axis term as in the drive kernels
    (subtrahend-fused), the prismatic rows minuend-fused as in the armature kernel (checked in kernel_ab)."""
    out = np.zeros(len(drives.pairs), F)
    for i in range(len(drives.pairs)):
        if drives.types[i] == 0:
            rows = _prismatic_rows(drives, i, x, minuend=prismatic_minuend)
            if rows is None:
                continue
            child, parent = rows[2], rows[3]
        else:
            jac = _drive_jacobian(drives, i, x, axis_minuend=axis_minuend)
            if jac is None:
                continue
            child, parent = jac
        cids = drives.indices[drives.pairs[i, 1]]
        pids = drives.indices[drives.pairs[i, 0]] if parent is not None else None
        acc = F(0)
        for slot in range(4):
            for ids, rws in ((cids, child), (pids, parent)):
                if rws is not None:
                    acc = F(acc+_dot_y(rws[slot], np.asarray(velocity[ids[slot]], F)))
        out[i] = acc
    return out

def reset_selected_joint_drive_state(mask, initialized):
    """reset_selected_joint_drive_state: clear the angle-initialized flag of every drive with a nonzero mask."""
    initialized[np.asarray(mask) != 0] = 0

def evaluate_joint_armature(drives, armature, x, previous, qd, inv_h, direction=None, force=None, block=None):
    """evaluate_joint_armature: reflected joint inertia s = armature/h^2 on the joint coordinate. Force mode adds
    s (qd0 h - (q - q_prev)) J (the angular difference wrapped to (-pi, pi]); preconditioner and tangent modes as
    in evaluate_angular_limits (child/parent interleaved per slot). Both joint types share the scatter code."""
    from .rigid_contact import _Ops, _red
    ops = _Ops()
    inv_h = F(inv_h)
    for i in range(len(drives.pairs)):
        a = F(armature[drives.dof[i]])
        if not a > 0:
            continue
        if drives.types[i] == 0:
            rows = _prismatic_rows(drives, i, x, minuend=True)
            if rows is None:
                continue
            child, parent = rows[2], rows[3]
        else:
            jac = _drive_jacobian(drives, i, x, axis_minuend=True)
            if jac is None:
                continue
            child, parent = jac
        s = F(F(a*inv_h)*inv_h)
        cids = drives.indices[drives.pairs[i, 1]]
        pids = drives.indices[drives.pairs[i, 0]] if parent is not None else None
        if block is not None:
            for slot in range(4):
                for side, ids, rws in ((0, cids, child), (1, pids, parent)):
                    if rws is None:
                        continue
                    g = rws[slot]
                    o = [F(g[0]*g[0]), F(g[1]*g[0]), F(g[2]*g[0]), F(g[1]*g[1]), F(g[2]*g[1]), F(g[2]*g[2])]
                    m = [F(s*v) for v in o]
                    values = (m[0], m[1], m[2], m[1], m[3], m[4], m[2], m[4], m[5])
                    for comp in range(9):
                        ops.add(i, 2*slot+side, block, ids[slot], comp, values[comp])
            continue
        if direction is not None:
            jp = F(0)
            for slot in range(4):
                for ids, rws in ((cids, child), (pids, parent)):
                    if rws is not None:
                        jp = F(jp+_dot_y(rws[slot], np.asarray(direction[ids[slot]], F)))
            tau = F(s*jp)
        else:
            q = _coordinate(drives, i, x)
            q0 = _coordinate(drives, i, previous)
            if q is None or q0 is None:
                continue
            delta = F(F(F(qd[i])/inv_h)-F(q-q0))
            if drives.types[i] == 1:
                turns = F(delta/TWO_PI)
                k = F(np.trunc(_add_rz(turns, _copysign(F(0.5), turns))))
                delta = F(fma(-k, TWO_PI, delta))
            tau = F(s*delta)
        if not abs(tau) < np.inf:
            continue
        for side, ids, rws in ((0, cids, child), (1, pids, parent)):
            if rws is None:
                continue
            for slot in range(4):
                for e in range(3):
                    ops.add(i, 4*side+slot, force, ids[slot], e, F(tau*rws[slot][e]))
    if block is not None:
        flat = block.reshape(len(block), 9)
        for *_, target, index, component, value in sorted(ops.ops, key=lambda op: op[:4]):
            _red(flat[index], component, value)
    else:
        ops.apply()
