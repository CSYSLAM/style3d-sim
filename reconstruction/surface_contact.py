"""Full-surface rigid-soft contact of the legacy solver (evaluate_surface_contact_force and its preconditioner and
tangent kernels), transcribed from the sm_52 PTX.

With Newton's `enable_rigid_soft_full_surface_contact` the soft contacts carry up to three deformable vertices with
barycentric weights (Contact.soft_indices / soft_barycentric): vertex, edge or face contacts against a shape. The
kernels take a SurfaceContactView (296 B) by value; byte offsets of its fields:
  0 count ptr, 8 max count, 16 indices (ivec3, -1 padded), 24 barycentric, 32 shape, 40 body_pos, 48 body_vel,
  56 normal, 64 particle-only shape flags (+72 their count), 80 radius, 88 mass, 96 particle flags, 104 particle kind,
  112 particles per world, 120 particle count, 128 shape_body, 136 shape_type, 144 shape_transform, 152 shape_scale,
  160 shape_margin, 168/176/184/192 shape ke/kd/kf/mu, 200 shape count, 208 shapes per world, 216 world count,
  224 ke, 228 kd, 232 kf, 236 mu (model soft-contact defaults), 240 affine ids, 248 affine indices, 256 com,
  264 body count, 272 x, 280 previous x, 288 1/h.

Per contact: p = sum b_i x_i, v = sum (b_i/h)(x_i - x_i_prev), r = max radius of the listed vertices, inverse
effective mass sum b_i^2/m_i over active vertices; the shape side as in the particle soft contact (affine-body
point map, sphere surface point, A bv body velocity). Normal law (implicit damping):
  d = (r + margin) - (p - w).n,  fn = max(ke d + (kd/h)(d - max(d + h vn, 0)), 0),  kd <= 2 sqrt(ke/sum b^2/m).
Friction: eta = min(kf, mu fn/max(|vt|, 1e-8)). The force is scattered through two Jacobian lists: normal
(vertices b_i, body translation -1, columns -(p_raw - com)_k) and friction (columns -(p_surface - com)_k).
"""
import numpy as np

from .numerics import F, fma
from .rigid_contact import Bodies, _dot, _dot_x_first, _normalize, _point_velocity, _red, _sphere_local_offset, _vec
from .rigid_contact import _world_point

SPHERE = 3
BARY_TOLERANCE = F(np.frombuffer(np.uint32(0x38D1B717).tobytes(), F)[0])    # 1e-4
TINY = F(np.frombuffer(np.uint32(0x322BCC77).tobytes(), F)[0])              # 1e-8


class SurfaceContacts:
    """Inputs of the surface-contact kernels in the kernel's terms (single world)."""
    def __init__(self, count, indices, barycentric, shape, body_pos, body_vel, normal, radius, mass, flags, kind,
                 shape_body, shape_type, shape_position, shape_scale, shape_margin, shape_ke, shape_kd, shape_kf,
                 shape_mu, ke, kd, kf, mu, bodies, x, previous, inv_h, particle_only=None):
        self.count = int(count)
        self.indices = np.asarray(indices, np.int32).reshape(-1, 3)
        self.barycentric = np.asarray(barycentric, F).reshape(-1, 3)
        self.shape = np.asarray(shape, np.int32)
        self.body_pos = np.asarray(body_pos, F).reshape(-1, 3)
        self.body_vel = np.asarray(body_vel, F).reshape(-1, 3)
        self.normal = np.asarray(normal, F).reshape(-1, 3)
        self.radius, self.mass = np.asarray(radius, F), np.asarray(mass, F)
        self.flags = None if flags is None else np.asarray(flags, np.int32)
        self.kind = None if kind is None else np.asarray(kind, np.int32)
        self.shape_body, self.shape_type = np.asarray(shape_body, np.int32), np.asarray(shape_type, np.int32)
        self.shape_position = np.asarray(shape_position, F).reshape(-1, 3)
        self.shape_scale = np.asarray(shape_scale, F).reshape(-1, 3)
        self.shape_margin = np.asarray(shape_margin, F)
        self.shape_ke, self.shape_kd = np.asarray(shape_ke, F), np.asarray(shape_kd, F)
        self.shape_kf, self.shape_mu = np.asarray(shape_kf, F), np.asarray(shape_mu, F)
        self.ke, self.kd, self.kf, self.mu = F(ke), F(kd), F(kf), F(mu)
        self.bodies = bodies
        self.x, self.previous = np.asarray(x, F), np.asarray(previous, F)
        self.inv_h = F(inv_h)
        self.particle_only = None if particle_only is None else np.asarray(particle_only, np.int32)


class _Record:
    pass


def _contact(c, i, vn_x_first=False, vt_x_first=True):
    """Geometry, coefficients and Jacobian lists of contact i, or None when the kernel skips it. Dot-product orders
    differ per kernel: normal speed y first (force, tangent) or x first (preconditioner); tangential projection
    x first (force, preconditioner) or y first (tangent)."""
    s = int(c.shape[i])
    if c.particle_only is not None and 0 <= s < len(c.particle_only) and c.particle_only[s] != 0:
        return None
    n_particles = len(c.x)
    inv_h = c.inv_h
    normal_list, friction_list = [], []
    rmax, invm, total = F(0), F(0), None
    p = np.zeros(3, F)
    vel = np.zeros(3, F)
    for j in range(3):
        v, b = int(c.indices[i, j]), F(c.barycentric[i, j])
        if j == 0 and not (v > -1 and v < n_particles):
            return None
        if v < 0:
            continue
        if not abs(b) < np.inf or b < 0 or v >= n_particles:
            return None
        if c.kind is not None and c.kind[v] != 0:
            return None
        rmax = max(rmax, F(c.radius[v])) if j else max(F(0), F(c.radius[v]))
        if b == 0:
            continue
        normal_list.append((v, b))
        friction_list.append((v, b))
        total = F(b+F(0)) if total is None else F(total+b)
        xv = c.x[v]
        p = np.asarray(fma(b, xv, p), F)
        vel = np.asarray(fma(F(b*inv_h), (xv-c.previous[v]).astype(F), vel), F)
        m = F(c.mass[v])
        if m > 0 and (c.flags is None or (c.flags[v] & 1)):
            invm = F(F(F(b*b)/m)+invm)
    if not abs(rmax) < np.inf or not normal_list or abs(F(total+F(-1))) > BARY_TOLERANCE:
        return None
    if s < 0 or s >= len(c.shape_type):
        return None
    body = int(c.shape_body[s])
    bodies = c.bodies
    k = bodies.slot(body) if (bodies is not None and body >= 0) else -1
    if body > -1 and k < 0:
        return None
    n = _normalize(c.normal[i])
    sphere = int(c.shape_type[s]) == SPHERE
    raw = _vec(c.shape_position[s]) if sphere else _vec(c.body_pos[i])
    w = _world_point(raw, k, bodies, c.x)
    adj = raw
    if sphere:
        dvec = _vec(p-w)
        dl = F(np.sqrt(_dot_x_first(dvec, dvec)))      # |p - c|^2 accumulated x first in this kernel
        u = np.array([F(e/dl) for e in dvec], F) if dl > 0 else np.zeros(3, F)
        if _dot(u, u) >= F(0.5):
            n = u
        radius_s = F(c.shape_scale[s][0])
        rn = _vec(radius_s*n)
        if k >= 0:
            adj = _vec(raw+_sphere_local_offset(rn, k, bodies, c.x))
        else:
            adj = _vec(rn+raw)
        w = _vec(rn+w)
    nx2, ny2, nz2 = F(n[0]*n[0]), F(n[1]*n[1]), F(n[2]*n[2])
    if not F(nz2+F(ny2+nx2)) >= F(0.5):
        return None
    bv = _vec(c.body_vel[i])
    v_raw = v_adj = bv
    if k >= 0:
        ids = bodies.indices[k]
        a0, a1, a2 = (_vec(c.x[q]) for q in ids[1:])
        bvw = _vec(fma(a2, bv[2], fma(a0, bv[0], _vec(a1*bv[1]))))
        v_raw = _vec(bvw+_point_velocity(raw, k, bodies, c.x, c.previous, None, inv_h))
        v_adj = _vec(bvw+_point_velocity(adj, k, bodies, c.x, c.previous, None, inv_h))
        com = bodies.com[k]
        d_raw, d_adj = _vec(raw-com), _vec(adj-com)
        normal_list += [(int(ids[0]), F(-1))]+[(int(ids[q+1]), F(-d_raw[q])) for q in range(3)]
        friction_list += [(int(ids[0]), F(-1))]+[(int(ids[q+1]), F(-d_adj[q])) for q in range(3)]
    rel = _vec(p-w)
    r1, r2 = _vec(vel-v_raw), _vec(vel-v_adj)
    if not (np.all(np.abs(rel) < np.inf) and np.all(np.abs(r1) < np.inf) and np.all(np.abs(r2) < np.inf)):
        return None
    depth = F(F(rmax+F(c.shape_margin[s]))-_dot(rel, n))
    if not abs(depth) < np.inf or not depth > 0:
        return None
    ke = min(c.ke, F(c.shape_ke[s]))
    kd = min(c.kd, F(c.shape_kd[s]))
    if invm > 0:
        root = F(np.sqrt(F(ke/invm)))
        kd = min(kd, F(root+root))
    vn = _dot_x_first(r1, n) if vn_x_first else _dot(r1, n)
    if not abs(vn) < np.inf:
        return None
    kdh = F(kd*inv_h)
    ahead = max(F(depth+F(vn/inv_h)), F(0))
    fn = max(F(fma(depth, ke, F(kdh*F(depth-ahead)))), F(0))
    if not fn > 0:
        return None
    vn2 = _dot_x_first(r2, n) if vt_x_first else _dot(r2, n)
    t = _vec(fma(-vn2, n, r2))
    tl = F(np.sqrt(_dot(t, t)))
    if not abs(tl) < np.inf:
        return None
    mu = min(c.mu, F(c.shape_mu[s]))
    limit = F(fn*mu)
    eta = F(0)
    if limit > 0:
        eta = min(min(c.kf, F(c.shape_kf[s])), F(limit/max(tl, TINY)))
    r = _Record()
    r.n, r.fn, r.eta, r.t = n, fn, eta, t
    r.normal_list, r.friction_list = normal_list, friction_list
    r.stiffness = F(fma(kd, inv_h, ke))         # fused in the preconditioner and tangent kernels
    r.stiffness_sum = F(ke+kdh)                 # unfused in add_surface_contact_stiffness_scale
    r.friction = F(eta*inv_h)
    return r


def _list_steps(count):
    """(phase, step) of each entry of a scatter loop unrolled by four (remainder after the unrolled part)."""
    unrolled = count-count % 4 if count >= 4 else 0
    return [(0, e) if e < unrolled else (1, e-unrolled) for e in range(count)]


def evaluate_surface_contact_force(c, force):
    """Adds the normal force through the normal list and the friction force through the friction list (atomics in
    SIMT order: warps descending, list, unrolled step, component, lanes ascending)."""
    ops = []
    for i in range(c.count):
        r = _contact(c, i)
        if r is None:
            continue
        fnv = _vec(r.fn*r.n)
        ftv = _vec(r.t*(-r.eta))
        for section, (entries, vec) in enumerate(((r.normal_list, fnv), (r.friction_list, ftv))):
            for (particle, w), step in zip(entries, _list_steps(len(entries))):
                for e in range(3):
                    ops.append((-(i//32), section, step, e, i % 32, particle, F(w*vec[e])))
    for op in sorted(ops, key=lambda op: op[:5]):
        _red(force[op[5]], op[3], op[6])


def add_surface_contact_stiffness_scale(c, scale, vn_x_first=False):
    """add_surface_contact_stiffness_scale: w^2 (ke + kd/h) per normal-list entry into the per-particle scalar
    stiffness scale (the self-collision "mass", seeded with the scalar diagonal). Only launched with self-collision
    and surface contacts."""
    ops = []
    for i in range(c.count):
        r = _contact(c, i, vn_x_first=vn_x_first)
        if r is None:
            continue
        for (particle, w), step in zip(r.normal_list, _list_steps(len(r.normal_list))):
            ops.append((-(i//32), step, i % 32, particle, F(F(w*w)*r.stiffness_sum)))
    for op in sorted(ops, key=lambda op: op[:3]):
        _red(scale, op[3], op[4])


def _blocks(r):
    """Normal block s_n n n^T (s_n = ke + kd/h) and friction block (eta/h)(I - n n^T), row-major 3x3."""
    n = r.n
    nx2, ny2, nz2 = F(n[0]*n[0]), F(n[1]*n[1]), F(n[2]*n[2])
    xy, xz, yz = F(n[1]*n[0]), F(n[2]*n[0]), F(n[2]*n[1])
    s, f = r.stiffness, r.friction
    kn = [F(s*nx2), F(s*xy), F(s*xz), F(s*xy), F(s*ny2), F(s*yz), F(s*xz), F(s*yz), F(s*nz2)]
    a, b, c = F(F(1)-nx2)*f, F(F(0)-xy)*f, F(F(0)-xz)*f
    kf = [F(a), F(b), F(c), F(b), F(F(F(1)-ny2)*f), F(F(F(0)-yz)*f), F(c), F(F(F(0)-yz)*f), F(F(F(1)-nz2)*f)]
    return np.array(kn, F), np.array(kf, F)


def add_surface_contact_preconditioner(c, block):
    """add_surface_contact_preconditioner: w^2 K_n per normal-list entry, then w^2 K_f per friction-list entry."""
    ops = []
    flat = block.reshape(len(block), 9)
    for i in range(c.count):
        r = _contact(c, i, vn_x_first=True)
        if r is None:
            continue
        kn, kf = _blocks(r)
        for section, (entries, k) in enumerate(((r.normal_list, kn), (r.friction_list, kf))):
            for (particle, w), step in zip(entries, _list_steps(len(entries))):
                w2 = F(w*w)
                for e in range(9):
                    ops.append((-(i//32), section, step, e, i % 32, particle, F(k[e]*w2)))
    for op in sorted(ops, key=lambda op: op[:5]):
        _red(flat[op[5]], op[3], op[6])


def multiply_surface_contact_tangent(c, direction, product):
    """multiply_surface_contact_tangent: per list, J p = sum fma(w, p_j) from +0, y = K (J p), w y scattered."""
    ops = []
    for i in range(c.count):
        r = _contact(c, i, vt_x_first=False)
        if r is None:
            continue
        kn, kf = _blocks(r)
        for section, (entries, k) in enumerate(((r.normal_list, kn), (r.friction_list, kf))):
            jp = np.zeros(3, F)
            for particle, w in entries:
                jp = np.asarray(fma(w, np.asarray(direction[particle], F), jp), F)
            y = np.array([fma(k[6+q], jp[2], fma(k[q], jp[0], F(k[3+q]*jp[1]))) for q in range(3)], F)
            for (particle, w), step in zip(entries, _list_steps(len(entries))):
                for e in range(3):
                    ops.append((-(i//32), section, step, e, i % 32, particle, F(y[e]*w)))
    for op in sorted(ops, key=lambda op: op[:5]):
        _red(product[op[5]], op[3], op[6])
