"""Recovered hard-contact kernels; native_step host scheduling is not integrated yet."""
import numpy as np

from .numerics import F, fma


def snapshot(count, capacity, lambda_n, lambda_t, normal, previous_n, previous_t, previous_normal, previous_count):
    """Save the active prefix and normalized normals; preserve unused history slots.

    A missing count pointer is represented by None. The native view uses signed int32 contact counts
    and a size_t capacity; valid allocated capacities are assumed to fit in int32.
    """
    n = 0 if count is None else min(max(int(count), 0), capacity)
    previous_count[0] = n
    for i in range(n):
        previous_n[i] = lambda_n[i]
        previous_t[i] = lambda_t[i]
        x, y, z = normal[i]
        length = F(np.sqrt(fma(z, z, fma(x, x, F(y*y)))))
        previous_normal[i] = normal[i] / length if length > F(0) else F(0)


def geometry(c, i, shapes, bodies, x, particles_per_world, worlds=1, shapes_per_world=None):
    """Resolve hard-contact geometry; depth uses raw points, while friction uses adjusted points."""
    from .rigid_contact import Bodies, _normalize, _dot, _dot_x_first, _world_point, _sphere_local_offset
    stride = len(shapes['body']) if shapes_per_world is None else shapes_per_world
    resolved, slots, worlds_for_shape = [], [], []
    for name in ('shape0', 'shape1'):
        shape = int(c[name][i])
        if shape < 0:
            return None
        world, local = divmod(shape, stride) if shape < stride*worlds else (-1, shape-stride*worlds+stride)
        if local >= len(shapes['body']):
            return None
        body = int(shapes['body'][local])
        slot = bodies.slot(body)
        if body >= 0 and slot < 0 or slot >= 0 and world < 0:
            return None
        resolved.append(local)
        slots.append(slot)
        worlds_for_shape.append(world)
    if all(k < 0 for k in slots) or (all(w >= 0 for w in worlds_for_shape) and
                                   worlds_for_shape[0] != worlds_for_shape[1]):
        return None
    mapped = Bodies(np.arange(2), np.array([bodies.indices[k]+w*particles_per_world if k >= 0 else np.zeros(4)
                                           for k, w in zip(slots, worlds_for_shape)], dtype=np.int32),
                    np.array([bodies.com[k] if k >= 0 else np.zeros(3) for k in slots], dtype=F))
    use = [j if k >= 0 else -1 for j, k in enumerate(slots)]
    n = _normalize(c['normal'][i])
    raw = [shapes['position'][s].copy() if shapes['type'][s] == 3 else c[f'point{j}'][i].copy()
           for j, s in enumerate(resolved)]
    adjusted = [v.copy() for v in raw]
    direction = n
    if all(shapes['type'][s] == 3 for s in resolved):
        diff = (_world_point(raw[1], use[1], mapped, x)-_world_point(raw[0], use[0], mapped, x)).astype(F)
        length = F(np.sqrt(_dot(diff, diff)))
        alt = (diff/length).astype(F) if length > 0 else np.zeros(3, F)
        if not _dot(alt, alt) < F(.5):
            direction = alt
    for j, s in enumerate(resolved):
        if shapes['type'][s] == 3:
            offset = (F(shapes['scale'][s, 0])*direction).astype(F)
            if j == 1:
                offset = -offset
            if use[j] >= 0:
                adjusted[j] = (raw[j]+_sphere_local_offset(offset, use[j], mapped, x)).astype(F)
            else:
                radius = F(shapes['scale'][s, 0])
                adjusted[j] = fma(radius if j == 0 else -radius, direction, raw[j])
        if c.get(f'offset{j}') is not None:
            adjusted[j] = (c[f'point{j}'][i]+c[f'offset{j}'][i]).astype(F)
    if _dot_x_first(n, n) < F(.5):
        return None
    point = [_world_point(c[f'point{j}'][i], use[j], mapped, x) for j in range(2)]
    depth = F(F(c['margin0'][i]+c['margin1'][i])-_dot((point[1]-point[0]).astype(F), n))
    return resolved, use, mapped, n, adjusted, depth


def initialize(c, shapes, bodies, x, previous, penalty, dual, anchor, previous_penalty, previous_dual,
               previous_normal, previous_count, match, alpha, beta, gamma, start, history, reset,
               particles_per_world, worlds=1, shapes_per_world=None):
    """Initialize penalty, warm-started vector dual and displacement anchor (HardContactView offsets 256/264/272)."""
    from .rigid_contact import _dot, _world_point
    count = min(max(int(c['count']), 0), len(penalty)) if c['count'] is not None else 0
    for i in range(count):
        g = geometry(c, i, shapes, bodies, x, particles_per_world, worlds, shapes_per_world)
        if g is None:
            penalty[i], dual[i], anchor[i] = F(0), F(0), F(0)
            continue
        shapes_i, use, mapped, n, adjusted, depth = g
        upper = F(F(shapes['ke'][shapes_i[0]]+shapes['ke'][shapes_i[1]])*F(.5))
        lower = np.fmin(F(start), upper) if F(beta) > 0 else upper
        old, vector = lower, np.zeros(3, F)
        if not reset and previous_count != 0:
            old, vector = penalty[i], dual[i].copy()
        else:
            idx = int(match[i]) if history and match is not None else -1
            if 0 <= idx < previous_count:
                old = np.fmin(np.fmax(previous_penalty[idx], lower), upper)
                old_n = previous_normal[idx]
                normal_part = _dot(old_n, previous_dual[idx])
                tangent = fma(-old_n, normal_part, previous_dual[idx])
                vector = fma(normal_part, n, tangent)
                vector = fma(-_dot(tangent, n), n, vector)
        penalty[i] = np.fmin(np.fmax(F(F(old)*F(gamma)), lower), upper)
        dual[i] = F(0) if not history and reset else (vector*F(F(alpha)*F(gamma))).astype(F)
        p0 = _world_point(adjusted[0], use[0], mapped, x)
        p1 = _world_point(adjusted[1], use[1], mapped, x)
        diff = (p1-p0).astype(F)
        tangent = fma(-_dot(diff, n), n, diff)
        anchor[i] = fma(F(depth), n, -tangent)


def update_duals(c, shapes, bodies, x, previous, penalty, dual, anchor, alpha, beta,
                 particles_per_world, worlds=1, shapes_per_world=None):
    """Projected vector dual and adaptive penalty update, keeping the PTX displacement subtraction order."""
    from .rigid_contact import _dot, _world_point
    count = min(max(int(c['count']), 0), len(penalty)) if c['count'] is not None else 0
    for i in range(count):
        g = geometry(c, i, shapes, bodies, x, particles_per_world, worlds, shapes_per_world)
        if g is None:
            continue
        shapes_i, use, mapped, n, adjusted, depth = g
        an, dn = _dot(anchor[i], n), _dot(dual[i], n)
        corrected_depth = depth if depth < 0 else fma(-F(alpha), an, depth)
        normal_force = np.fmax(fma(penalty[i], corrected_depth, dn), F(0))
        now = [_world_point(adjusted[j], use[j], mapped, x) for j in range(2)]
        old = [_world_point(adjusted[j], use[j], mapped, previous) for j in range(2)]
        delta = (((now[1]-old[1]).astype(F)-now[0]).astype(F)+old[0]).astype(F)
        correction = fma(_dot(delta, n), n, -delta)
        correction = fma(fma(-an, n, anchor[i]), F(F(1)-F(alpha)), correction)
        tangent = fma(penalty[i], correction, fma(-dn, n, dual[i]))
        length = F(np.sqrt(_dot(tangent, tangent)))
        bound = F(normal_force*F(np.sqrt(np.fmax(F(shapes['mu'][shapes_i[0]]*shapes['mu'][shapes_i[1]]), F(0)))))
        if length > bound and length > 0:
            tangent = (F(bound/length)*tangent).astype(F)
        dual[i] = fma(normal_force, n, tangent)
        if depth > 0:
            upper = F(F(shapes['ke'][shapes_i[0]]+shapes['ke'][shapes_i[1]])*F(.5))
            penalty[i] = np.fmin(upper, fma(F(beta), depth, penalty[i]))


def evaluate(c, shapes, bodies, x, previous, penalty, dual, anchor, alpha, inv_h, exact_friction,
             particles_per_world, worlds=1, shapes_per_world=None, force=None, scalar=None,
             direction=None, product=None, system=None, precond=None, affine_blocks=None):
    """Hard-contact force, scalar diagonal, off-diagonal product and block corrections."""
    from .rigid_contact import _dot, _world_point, _point_velocity, _red, _apply
    count = min(max(int(c['count']), 0), len(penalty)) if c['count'] is not None else 0
    for i in range(count):
        g = geometry(c, i, shapes, bodies, x, particles_per_world, worlds, shapes_per_world)
        if g is None:
            continue
        si, use, mapped, n, adj, depth = g
        p, dn, an = F(penalty[i]), _dot(dual[i], n), _dot(anchor[i], n)
        gap = fma(-F(alpha), an, depth)
        if not p > 0 or ((depth <= F(1e-9) or gap <= F(1e-9)) and dn <= 0):
            continue
        fn = np.fmax(fma(p, gap, dn), F(0))
        now = [_world_point(adj[j], use[j], mapped, x) for j in range(2)]
        old = [_world_point(adj[j], use[j], mapped, previous) for j in range(2)]
        delta = (((now[1]-old[1]).astype(F)-now[0]).astype(F)+old[0]).astype(F)
        mu = F(np.sqrt(np.fmax(F(shapes['mu'][si[0]]*shapes['mu'][si[1]]), F(0))))
        tangent, unit = np.zeros(3, F), np.zeros(3, F)
        kt, sliding = F(0), False
        if mu > 0 and fn > 0:
            correction = fma(_dot(delta, n), n, -delta)
            correction = fma(fma(-an, n, anchor[i]), F(F(1)-F(alpha)), correction)
            tangent = fma(-dn, n, fma(p, correction, dual[i]))
            length = F(np.sqrt(_dot(tangent, tangent)))
            bound, kt = F(fn*mu), p
            if length > bound and length > 0:
                factor = F(bound/length)
                if exact_friction:
                    unit, kt, sliding = (tangent/length).astype(F), F(p*factor), True
                tangent = (tangent*factor).astype(F)
        raw = [c[f'point{j}'][i] for j in range(2)]
        velocity = [_point_velocity(raw[j], use[j], mapped, x, previous, None, F(inv_h)) for j in range(2)]
        vn = _dot((velocity[1]-velocity[0]).astype(F), n)
        damping = F(F(shapes['kd'][si[0]]+shapes['kd'][si[1]])*F(.5)) if fn > 0 and vn < 0 else F(0)
        normal_force = fma(fn, n, -(F(vn*damping)*n).astype(F))
        kn = fma(damping, F(inv_h), p)
        entries = []
        for j in range(2):
            if use[j] < 0:
                continue
            rn, rt = (raw[j]-mapped.com[j]).astype(F), (adj[j]-mapped.com[j]).astype(F)
            sign = F(-1 if j == 0 else 1)
            weights = [(sign, sign)]+[(F(sign*rn[k]), F(sign*rt[k])) for k in range(3)]
            ids = mapped.indices[j]
            entries.extend((int(pid), wn, wt) for pid, (wn, wt) in zip(ids, weights))
            for which, vec, stiffness in ((0, normal_force, kn), (1, tangent, kt)):
                for pid, w in zip(ids, weights):
                    if force is not None:
                        for a in range(3):
                            _red(force[pid], a, F(w[which]*vec[a]))
                    if scalar is not None:
                        _red(scalar, pid, F(w[which]*F(stiffness*w[which])))
        pairs = ((0, 0), (1, 0), (2, 0), (1, 1), (2, 1), (2, 2))
        nn = [F(n[a]*n[b]) for a, b in pairs]
        normal_matrix = [F(kn*v) for v in nn]
        tangent_matrix = [F(kt*F(F(a == b)-v)) for (a, b), v in zip(pairs, nn)]
        if sliding:
            tangent_matrix = [fma(-kt, F(unit[a]*unit[b]), v)
                              for (a, b), v in zip(pairs, tangent_matrix)]
        if direction is not None and product is not None:
            for which, matrix in ((1, normal_matrix), (2, tangent_matrix)):
                for entry in entries:
                    pid, w = entry[0], entry[which]
                    u = np.zeros(3, F)
                    for other in entries:
                        if other[0] != pid:
                            u = fma(other[which], direction[other[0]], u)
                    v = _apply(matrix, u)
                    for a in range(3):
                        _red(product[pid], a, F(w*v[a]))
        for pid, wn, wt in entries:
            if system is None and precond is None:
                break
            n2, t2 = F(wn*wn), F(wt*wt)
            iso = fma(kn, n2, F(kt*t2))
            block6 = [fma(n2, nv, F(t2*tv)) for nv, tv in zip(normal_matrix, tangent_matrix)]
            block6 = [F(v-F(iso*(F(1) if a == b else F(0)))) for (a, b), v in zip(pairs, block6)]
            block9 = [block6[k] for k in (0, 1, 2, 1, 3, 4, 2, 4, 5)]
            for target in (system, precond):
                if target is not None:
                    for a, value in enumerate(block9):
                        _red(target[pid], a, value)
        if affine_blocks is not None:
            stride = len(shapes['body']) if shapes_per_world is None else shapes_per_world
            seen_bodies = set()
            for j in range(2):
                if use[j] < 0:
                    continue
                world = int(c[f'shape{j}'][i])//stride
                body = bodies.slot(int(shapes['body'][si[j]]))+world*len(bodies.ids)
                if body in seen_bodies:
                    continue
                seen_bodies.add(body)
                weights = np.zeros((4, 2), F)
                for pid, wn, wt in entries:
                    for k, dest in enumerate(mapped.indices[j]):
                        if pid == dest:
                            weights[k] = (weights[k]+np.array([wn, wt], F)).astype(F)
                target = affine_blocks[body].reshape(12, 12)
                for row in range(4):
                    for col in range(4):
                        if row == col:
                            continue
                        a, b = F(weights[row, 0]*weights[col, 0]), F(weights[row, 1]*weights[col, 1])
                        values = [fma(a, nv, F(b*tv)) for nv, tv in zip(normal_matrix, tangent_matrix)]
                        for k, value in enumerate(values):
                            x0, x1 = pairs[k]
                            _red(target[3*row+x0], 3*col+x1, value)
                            if x0 != x1:
                                _red(target[3*row+x1], 3*col+x0, value)
