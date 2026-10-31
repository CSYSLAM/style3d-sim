"""Particle soft contact, transcribed from synreal::kernel::evaluate_soft_contact_force (legacy PTX).

`soft_contact_kernel` takes the kernel's own inputs and returns its three outputs, so it can be compared
bit-for-bit with the original PTX (see reconstruction/kernel_ab.py).

Static shapes take a vectorized path. Contacts with shapes owned by an affine body (shape_body >= 0, P28-P30) or a
per-shape particle-contact filter (P38, Contact.soft_particle_only_shapes) take the per-contact path `_body_path`:
the body-local contact point p maps to x_t + sum_k (p - com)_k a_k, the body-local surface velocity bv to A bv, and
the reaction goes to the body's translation (-F) and columns (-F (p - com)_k), normal and friction parts separately
(friction uses the sphere surface point p + A^-1 (r n) as lever).
"""
from dataclasses import dataclass

import numpy as np

from .numerics import F, atomic_add_at, fma, fms

SPHERE = 3  # Newton GeoType.SPHERE; the kernel recomputes the normal from the sphere centre for this type.


@dataclass
class SoftContactInputs:
    """Kernel parameters, in the kernel's terms (single world: particle/shape tiles equal the array sizes)."""
    count: int
    particle: np.ndarray        # P2  int[count]
    shape: np.ndarray           # P3  int[count]
    body_pos: np.ndarray        # P4  vec3[count], contact point in world space for static shapes
    body_vel: np.ndarray        # P5  vec3[count]
    normal: np.ndarray          # P6  vec3[count], normalized in-kernel
    radius: np.ndarray          # P7  float[particles]
    mass: np.ndarray            # P8  float[particles]
    shape_body: np.ndarray      # P12 int[shapes]
    shape_type: np.ndarray      # P13 int[shapes]
    shape_position: np.ndarray  # P14 Transform[shapes] translation (first 3 of 7 floats)
    shape_scale: np.ndarray     # P15 vec3[shapes]; x is the sphere radius
    shape_margin: np.ndarray    # P16 float[shapes]
    shape_ke: np.ndarray        # P17
    shape_kd: np.ndarray        # P18
    shape_kf: np.ndarray        # P19
    shape_mu: np.ndarray        # P20
    ke: float                   # P24
    kd: float                   # P25
    kf: float                   # P26
    mu: float                   # P27
    x: np.ndarray               # P32 current iterate
    previous: np.ndarray        # P34 step-start positions; velocity is (x - previous) * inv_dt
    inv_dt: float               # P35
    particle_flags: np.ndarray | None = None  # P9: particle kind (affine coordinates are nonzero): skipped
    body_ids: np.ndarray | None = None        # P28 Newton body of each affine slot
    body_indices: np.ndarray | None = None    # P29 ivec4 state particles (translation, columns) per slot
    body_com: np.ndarray | None = None        # P30 centre of mass per slot (body frame)
    velocity: np.ndarray | None = None        # P33 particle velocities, used when previous is None
    shape_filter: np.ndarray | None = None    # P38 per-shape flags: only flagged shapes take particle contacts


def soft_contact_kernel(c: SoftContactInputs, force=None, scalar=None, block=None):
    """Return (force[n,3], scalar[n], block[n,3,3]) exactly as the kernel accumulates them.

    Outputs start from zero unless arrays are passed; the legacy solver accumulates contact forces directly into
    the Newton right-hand side and scalars into the diagonal copy, one atomic add per contact.

    The tangent is split like the original: an isotropic scalar (P37) plus a 3x3 correction (P40/P41);
    their sum is a*nn^T + G*(I - nn^T).
    """
    n_particles = len(c.x)
    force = np.zeros((n_particles, 3), F) if force is None else force
    scalar = np.zeros(n_particles, F) if scalar is None else scalar
    block = np.zeros((n_particles, 3, 3), F) if block is None else block
    if c.shape_filter is not None or (c.count and np.any(c.shape_body[np.clip(c.shape[:c.count], 0, None)] >= 0)):
        return _body_path(c, force, scalar, block)
    i = np.arange(c.count)
    p = c.particle[:c.count].astype(np.int64)
    s = c.shape[:c.count].astype(np.int64)
    keep = (p >= 0) & (p < n_particles) & (s >= 0) & (s < len(c.shape_type))
    keep[keep] &= c.mass[p[keep]] > 0
    if c.particle_flags is not None:
        keep[keep] &= c.particle_flags[p[keep]] == 0
    i, p, s = i[keep], p[keep], s[keep]
    sphere = c.shape_type[s] == SPHERE
    raw = c.normal[i]
    length = np.sqrt(fma(raw[:, 2], raw[:, 2], fma(raw[:, 0], raw[:, 0], raw[:, 1]*raw[:, 1])))
    n = np.where((length > 0)[:, None], raw/np.where(length > 0, length, F(1))[:, None], F(0)).astype(F)
    point = np.where(sphere[:, None], c.shape_position[s], c.body_pos[i]).astype(F)
    x = c.x[p]
    if np.any(sphere):
        # Sphere: prefer the direction from the centre unless it is degenerate (squared length < 0.5).
        d = x-point
        dl = np.sqrt(fma(d[:, 2], d[:, 2], fma(d[:, 0], d[:, 0], d[:, 1]*d[:, 1])))
        u = np.where((dl > 0)[:, None], d/np.where(dl > 0, dl, F(1))[:, None], F(0)).astype(F)
        u2 = fma(u[:, 2], u[:, 2], fma(u[:, 0], u[:, 0], u[:, 1]*u[:, 1]))
        use_u = sphere & ~(u2 < F(0.5)) & ~np.isnan(u2)
        n = np.where(use_u[:, None], u, n).astype(F)
    nx2, ny2, nz2 = n[:, 0]*n[:, 0], n[:, 1]*n[:, 1], n[:, 2]*n[:, 2]
    valid = (nz2+(ny2+nx2)) > 0
    point = np.where(sphere[:, None], fma(c.shape_scale[s, 0][:, None], n, point), point).astype(F)
    d = x-point
    distance = fma(d[:, 2], n[:, 2], fma(d[:, 0], n[:, 0], d[:, 1]*n[:, 1]))
    penetration = (c.radius[p]+c.shape_margin[s])-distance
    valid &= penetration > 0
    i, p, s, n, penetration, sphere = i[valid], p[valid], s[valid], n[valid], penetration[valid], sphere[valid]
    nx2, ny2, nz2 = nx2[valid], ny2[valid], nz2[valid]
    if not len(p):
        return force, scalar, block
    velocity = (c.x[p]-c.previous[p])*F(c.inv_dt)
    r = velocity-c.body_vel[i]
    vn = fma(r[:, 2], n[:, 2], fma(r[:, 0], n[:, 0], r[:, 1]*n[:, 1]))
    ke = np.minimum(F(c.ke), c.shape_ke[s])
    root = np.sqrt(ke*c.mass[p])
    kd = np.minimum(np.minimum(F(c.kd), c.shape_kd[s]), root+root)
    mu = np.minimum(F(c.mu), c.shape_mu[s])
    # ptxas contracts PTX `mul; mul; sub` into FFMA(pen, ke, -(vn*kd)) (verified in the sm_120 SASS).
    normal_force = np.maximum(fms(penetration, ke, vn, kd), F(0))
    # The tangential projection recomputes the normal speed with x*n leading the fma chain.
    vn2 = fma(r[:, 2], n[:, 2], fma(r[:, 1], n[:, 1], r[:, 0]*n[:, 0]))
    t = fma(-vn2[:, None], n, r)  # contracted to FFMA(-vn2, n, r)
    t2 = fma(t[:, 2], t[:, 2], fma(t[:, 0], t[:, 0], t[:, 1]*t[:, 1]))
    limit = mu*normal_force
    speed = np.maximum(np.sqrt(t2), F(1e-8))
    kf = np.minimum(F(c.kf), c.shape_kf[s])
    gain = np.where(limit > 0, np.minimum(kf, limit/np.where(limit > 0, speed, F(1))), F(0)).astype(F)
    local_force = normal_force[:, None]*n+t*(-gain)[:, None]
    stiffness = fma(kd, F(c.inv_dt), ke)
    friction = gain*F(c.inv_dt)
    # Spheres add both terms to the isotropic scalar; other shapes take the larger one.
    iso = np.where(sphere, stiffness+friction, np.maximum(stiffness, friction)).astype(F)
    local_scalar = np.where(sphere, friction+stiffness, np.maximum(stiffness, friction)).astype(F)
    a = np.where(normal_force > 0, stiffness, F(0)).astype(F)
    nxy, nxz, nyz = n[:, 1]*n[:, 0], n[:, 2]*n[:, 0], n[:, 2]*n[:, 1]
    xx = fma(a, nx2, (F(1)-nx2)*friction)-iso
    xy = fma(a, nxy, (F(0)-nxy)*friction)
    xz = fma(a, nxz, (F(0)-nxz)*friction)
    yy = fma(a, ny2, (F(1)-ny2)*friction)-iso
    yz = fma(a, nyz, (F(0)-nyz)*friction)
    zz = fma(a, nz2, (F(1)-nz2)*friction)-iso
    local_block = np.stack((xx, xy, xz, xy, yy, yz, xz, yz, zz), axis=1).reshape(-1, 3, 3)
    atomic_add_at(force, p, local_force)
    atomic_add_at(scalar, p, local_scalar)
    atomic_add_at(block, p, local_block)
    return force, scalar, block


def _body_path(c, force, scalar, block):
    """Per-contact transcription of the full kernel, atomics in SIMT order (warps descending, instruction, lanes
    ascending). Instruction ids: force 0-2 particle, 3-14 body normal part, 15-26 body friction part; scalar 0
    particle, 1-4 body stiffness, 5-8 body sphere friction; block 18 j + 2 component (+1 for the second copy)."""
    from .rigid_contact import Bodies, _Ops, _dot, _dot_x_first, _normalize, _point_velocity, _sphere_local_offset
    from .rigid_contact import _vec, _world_point
    bodies = None
    if c.body_ids is not None:
        bodies = Bodies(c.body_ids, c.body_indices, c.body_com)
    n_particles = len(c.x)
    f_ops, s_ops, b_ops = _Ops(), _Ops(), _Ops()
    inv_dt = F(c.inv_dt)
    for i in range(int(c.count)):
        s = int(c.shape[i])
        if c.shape_filter is not None and (s < 0 or s >= len(c.shape_filter) or c.shape_filter[s] == 0):
            continue
        p = int(c.particle[i])
        if p < 0 or p >= n_particles or s < 0:
            continue
        mass = F(c.mass[p])
        if not mass > 0 or (c.particle_flags is not None and c.particle_flags[p] != 0):
            continue
        b = int(c.shape_body[s])
        k = bodies.slot(b) if bodies is not None else -1
        if b > -1 and k < 0:
            continue
        sphere = int(c.shape_type[s]) == SPHERE
        raw = _vec(c.shape_position[s]) if sphere else _vec(c.body_pos[i])
        w = _world_point(raw, k, bodies, c.x)
        n = _normalize(c.normal[i])
        x = _vec(c.x[p])
        r = F(c.shape_scale[s][0])
        adj = raw
        if sphere:
            u = _normalize(_vec(x-w))
            if _dot(u, u) >= F(0.5):
                n = u
            if k >= 0:
                adj = _vec(raw+_sphere_local_offset(_vec(r*n), k, bodies, c.x))
            else:
                adj = _vec(fma(r, n, raw))
        nx2, ny2, nz2 = F(n[0]*n[0]), F(n[1]*n[1]), F(n[2]*n[2])
        if not F(nz2+F(ny2+nx2)) > 0:
            continue
        if sphere:
            w = _vec(fma(r, n, w))
        depth = F(F(F(c.radius[p])+F(c.shape_margin[s]))-_dot(_vec(x-w), n))
        if not depth > 0:
            continue
        if c.previous is not None:
            vp = _vec(_vec(x-c.previous[p])*inv_dt)
        else:
            vp = _vec(c.velocity[p])
        bv = _vec(c.body_vel[i])
        v_raw = v_adj = bv
        if k >= 0:
            ids = bodies.indices[k]
            a0, a1, a2 = (_vec(c.x[j]) for j in ids[1:])
            bv = _vec(fma(a2, bv[2], fma(a0, bv[0], _vec(a1*bv[1]))))
            v_raw = _vec(_point_velocity(raw, k, bodies, c.x, c.previous, c.velocity, inv_dt)+bv)
            v_adj = _vec(_point_velocity(adj, k, bodies, c.x, c.previous, c.velocity, inv_dt)+bv)
        r1, r2 = _vec(vp-v_raw), _vec(vp-v_adj)
        vn = _dot(r1, n)
        ke = min(F(c.ke), F(c.shape_ke[s]))
        root = F(np.sqrt(F(ke*mass)))
        kd = min(min(F(c.kd), F(c.shape_kd[s])), F(root+root))
        mu = min(F(c.mu), F(c.shape_mu[s]))
        fn = fms(depth, ke, vn, kd)
        fn = fn if fn > 0 else F(0)
        vn2 = _dot_x_first(r2, n)
        t = _vec(fma(-vn2, n, r2))
        t2 = _dot(t, t)
        limit = F(mu*fn)
        eta = F(0)
        if limit > 0:
            eta = min(min(F(c.kf), F(c.shape_kf[s])), F(limit/max(F(np.sqrt(t2)), F(1e-8))))
        fnv = _vec(fn*n)
        ftv = _vec(t*(-eta))
        for e in range(3):
            f_ops.add(i, e, force, p, e, F(fnv[e]+ftv[e]))
        stiff = F(fma(kd, inv_dt, ke))
        fric = F(eta*inv_dt)
        iso = stiff if sphere else max(stiff, fric)
        s_ops.add(i, 0, scalar, p, None, F((fric if sphere else F(0))+iso))
        entries = [(p, F(1), F(1))]
        if k >= 0:
            ids = bodies.indices[k]
            com = bodies.com[k]
            d, ea = _vec(raw-com), _vec(adj-com)
            for e in range(3):
                f_ops.add(i, 3+e, force, ids[0], e, -fnv[e])
            for j in range(3):
                for e in range(3):
                    f_ops.add(i, 6+3*j+e, force, ids[j+1], e, -F(fnv[e]*d[j]))
            for e in range(3):
                f_ops.add(i, 15+e, force, ids[0], e, -ftv[e])
            for j in range(3):
                for e in range(3):
                    f_ops.add(i, 18+3*j+e, force, ids[j+1], e, -F(ftv[e]*ea[j]))
            s_ops.add(i, 1, scalar, ids[0], None, iso)
            for j in range(3):
                s_ops.add(i, 2+j, scalar, ids[j+1], None, F(d[j]*F(iso*d[j])))
            if sphere and fric > 0:
                s_ops.add(i, 5, scalar, ids[0], None, fric)
                for j in range(3):
                    s_ops.add(i, 6+j, scalar, ids[j+1], None, F(ea[j]*F(fric*ea[j])))
            entries += [(ids[0], F(-1), F(-1))] + [(ids[j+1], -d[j], -ea[j]) for j in range(3)]
        a_scale = stiff if fn > 0 else F(0)
        nxy, nxz, nyz = F(n[1]*n[0]), F(n[2]*n[0]), F(n[2]*n[1])
        for j, (target, wn, wf) in enumerate(entries):
            wn2, wf2 = F(wn*wn), F(wf*wf)
            g = F(fric*wf2)
            iso_j = F(fma(stiff, wn2, g)) if sphere else F(wn2*max(stiff, fric))
            a = F(a_scale*wn2)
            zero = F(iso_j*F(0))
            xx = F(fma(a, nx2, F(F(F(1)-nx2)*g))-iso_j)
            xy = F(fma(a, nxy, F(F(F(0)-nxy)*g))-zero)
            xz = F(fma(a, nxz, F(F(F(0)-nxz)*g))-zero)
            yy = F(fma(a, ny2, F(F(F(1)-ny2)*g))-iso_j)
            yz = F(fma(a, nyz, F(F(F(0)-nyz)*g))-zero)
            zz = F(fma(a, nz2, F(F(F(1)-nz2)*g))-iso_j)
            values = (xx, xy, xz, xy, yy, yz, xz, yz, zz)
            for comp in range(9):
                b_ops.add(i, 18*j+2*comp, block, target, comp, values[comp])
    f_ops.apply()
    s_ops.apply()
    _apply_block(b_ops, block.reshape(len(block), 9))
    return force, scalar, block


def _apply_block(ops, flat):
    from .rigid_contact import _red
    for *_, target, index, component, value in sorted(ops.ops, key=lambda op: op[:4]):
        _red(flat[index], component, value)


def multiply_soft_contact_hessian_off_diagonal(c: SoftContactInputs, direction, product):
    """Adds the particle <-> affine-body coupling blocks of the soft-contact Hessian times `direction` to `product`
    (multiply_soft_contact_hessian_off_diagonal, run in every PCG iteration). Only contacts with body shapes take part.

    Per contact the Jacobian entries are (particle, +1), (translation, -1) and (column j, -d_j) for the normal part
    (d = p - com) and (column j, -e_j) for friction (e = sphere surface point - com). Each entry a receives
    w_a K sum_{b != a} w_b direction_b, with K_n = s' n n^T (s' = kd/h + ke when fn > 0) and K_f = (eta/h)(I - n n^T);
    entries sharing the particle index of a are left out (their blocks are diagonal). Atomics in SIMT order: normal
    part for particle, translation, columns 0-2, then the friction part in the same order."""
    from .rigid_contact import Bodies, _Ops, _dot, _normalize, _point_velocity, _sphere_local_offset, _vec
    from .rigid_contact import _world_point
    if c.body_ids is None or c.previous is None:
        return product
    bodies = Bodies(c.body_ids, c.body_indices, c.body_com)
    n_particles = len(c.x)
    inv_dt = F(c.inv_dt)
    ops = _Ops()
    for i in range(int(c.count)):
        p, s = int(c.particle[i]), int(c.shape[i])
        if p >= n_particles or (p | s) < 0:
            continue
        mass = F(c.mass[p])
        if not mass > 0 or (c.particle_flags is not None and c.particle_flags[p] != 0):
            continue
        if c.shape_filter is not None and (s >= len(c.shape_filter) or c.shape_filter[s] == 0):
            continue
        k = bodies.slot(int(c.shape_body[s]))
        if k < 0:
            continue
        ids = [int(j) for j in bodies.indices[k]]
        com = bodies.com[k]
        sphere = int(c.shape_type[s]) == SPHERE
        raw = _vec(c.shape_position[s]) if sphere else _vec(c.body_pos[i])
        w = _world_point(raw, k, bodies, c.x)
        n = _normalize(c.normal[i])
        x = _vec(c.x[p])
        r = F(c.shape_scale[s][0])
        if sphere:
            u = _normalize(_vec(x-w))
            if _dot(u, u) >= F(0.5):
                n = u
            w = _vec(fma(r, n, w))
        nx2, ny2, nz2 = F(n[0]*n[0]), F(n[1]*n[1]), F(n[2]*n[2])
        if not F(nz2+F(ny2+nx2)) > 0:
            continue
        depth = F(F(F(c.radius[p])+F(c.shape_margin[s]))-_dot(_vec(x-w), n))
        if not depth > 0:
            continue
        ke = min(F(c.ke), F(c.shape_ke[s]))
        root = F(np.sqrt(F(ke*mass)))
        kd = min(min(F(c.kd), F(c.shape_kd[s])), F(root+root))
        adj = _vec(raw+_sphere_local_offset(_vec(r*n), k, bodies, c.x)) if sphere else raw
        a0, a1, a2 = (_vec(c.x[j]) for j in ids[1:])
        bv = _vec(c.body_vel[i])
        bv = _vec(fma(a2, bv[2], fma(a0, bv[0], _vec(a1*bv[1]))))
        dxp = _vec(x-c.previous[p])
        v_raw = _vec(_point_velocity(raw, k, bodies, c.x, c.previous, None, inv_dt)+bv)
        v_adj = _vec(_point_velocity(adj, k, bodies, c.x, c.previous, None, inv_dt)+bv)
        # ptxas fuses the particle velocity (x - x_prev)/h into the relative velocity: fma(dx, 1/h, -v_body).
        r1, r2 = _vec(fma(dxp, inv_dt, -v_raw)), _vec(fma(dxp, inv_dt, -v_adj))
        fn = fms(depth, ke, kd, _dot(r1, n))
        fn = fn if fn > 0 else F(0)
        vn2 = _dot(r2, n)                     # y first here (x first in evaluate_soft_contact_force)
        t = _vec(fma(-vn2, n, r2))
        mu = min(F(c.mu), F(c.shape_mu[s]))
        limit = F(fn*mu)
        eta = F(0)
        if limit > 0:
            eta = min(min(F(c.kf), F(c.shape_kf[s])), F(limit/max(F(np.sqrt(_dot(t, t))), F(1e-8))))
        stiff = F(fma(kd, inv_dt, ke)) if fn > 0 else F(0)
        nxy, nxz, nyz = F(n[1]*n[0]), F(n[2]*n[0]), F(n[2]*n[1])
        kn = (F(stiff*nx2), F(stiff*nxy), F(stiff*nxz), F(stiff*ny2), F(stiff*nyz), F(stiff*nz2))
        cf = F(eta*inv_dt)
        # 1 - n_k^2 is a single-use product here, which ptxas contracts into fma(-n_k, n_k, 1).
        kf = (F(cf*F(fma(-n[0], n[0], F(1)))), F(cf*F(F(0)-nxy)), F(cf*F(F(0)-nxz)), F(cf*F(fma(-n[1], n[1], F(1)))),
              F(cf*F(F(0)-nyz)), F(cf*F(fma(-n[2], n[2], F(1)))))
        d = _vec(raw-com)
        e = _vec(adj-com)
        for part, (m, lever) in enumerate(((kn, d), (kf, e))):
            weights = [F(1), F(-1)] + [F(-lever[j]) for j in range(3)]
            targets = [p] + ids
            for a in range(5):
                acc = None
                for b in range(5):
                    if b == a or targets[b] == targets[a]:
                        continue
                    db = _vec(direction[targets[b]])
                    if acc is None:
                        # The first term starts from zero: 0 - d (translation) or d + 0 (particle).
                        acc = _vec(F(0)-db) if b == 1 else (_vec(db+F(0)) if b == 0 else _vec(fma(db, weights[b], F(0))))
                    elif b == 1:
                        acc = _vec(acc-db)
                    else:
                        acc = _vec(fma(db, weights[b], acc))
                if acc is None:
                    acc = np.zeros(3, F)
                k00, k01, k02, k11, k12, k22 = m
                y = _vec([fma(k02, acc[2], fma(k00, acc[0], F(k01*acc[1]))),
                          fma(k12, acc[2], fma(k01, acc[0], F(k11*acc[1]))),
                          fma(k22, acc[2], fma(k02, acc[0], F(k12*acc[1])))])
                if a == 1:
                    y = _vec(-y)
                elif a >= 2:
                    y = _vec(y*weights[a])
                for comp in range(3):
                    ops.add(i, 5*part+a, product, targets[a], comp, y[comp])
    ops.apply()
    return product
