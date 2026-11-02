"""Cloth self-collision of the legacy solver (self_collision_kernel), transcribed bit-exactly from the PTX/SASS.

Queries walk the LBVH (reconstruction/lbvh.py) without a stack: a node entered from its parent is tested and,
when it overlaps an internal node, the walk descends to the left child; returning from the left child continues
to the right child, returning from the right child climbs to the parent. Every query thread owns a fixed block of
`max_slots` output entries, so candidate lists are deterministic (no atomics).

Scalar arithmetic is float32 with the contractions observed in the sm_120 SASS: every `a*b - c*d` here is
FFMA(a, b, -(c*d)).
"""
import numpy as np

from .numerics import F, fma

TINY_AREA2 = F(1e-20)


def _fms(a, b, c, d):
    return F(fma(a, b, -F(c*d)))


def _dot(u, v):
    return F(fma(u[2], v[2], fma(u[0], v[0], F(u[1]*v[1]))))


def _dot_b(u, v):
    """Dot product with the y product leading and v's components first: fma(uz, vz, fma(ux, vx, uy*vy))."""
    return _dot(u, v)


def _sub(a, b):
    return np.array((F(a[0]-b[0]), F(a[1]-b[1]), F(a[2]-b[2])), F)


def _axpy(d, t, base):
    """fma(d, t, base) per component."""
    return np.array([F(fma(d[i], t, base[i])) for i in range(3)], F)


def _norm2(v):
    return F(fma(v[2], v[2], fma(v[0], v[0], F(v[1]*v[1]))))


def _point_segment2(p, a, d):
    """Squared distance from p to a + t d, t = sat(((p - a) . d) / |d|^2) (0 for a degenerate segment)."""
    length2 = _norm2(d)
    t = F(0)
    if length2 > 0:
        ap = _sub(p, a)
        t = F(F(fma(d[2], ap[2], fma(d[0], ap[0], F(d[1]*ap[1]))))/length2)
        t = F(min(max(t, F(0)), F(1))) if not np.isnan(t) else F(0)  # cvt.sat.f32 maps NaN to 0
    return _norm2(_sub(p, _axpy(d, t, a)))


def point_triangle_distance2(p, a, b, c):
    """Squared distance of query_vertex_face: Ericson's regions, or the closest edge for degenerate triangles."""
    ab, ac = _sub(b, a), _sub(c, a)
    nx = _fms(ab[1], ac[2], ab[2], ac[1])
    ny = _fms(ab[2], ac[0], ab[0], ac[2])
    nz = _fms(ab[0], ac[1], ab[1], ac[0])
    if F(fma(nz, nz, fma(nx, nx, F(ny*ny)))) < TINY_AREA2:
        return F(min(_point_segment2(p, a, ab), min(_point_segment2(p, b, _sub(c, b)), _point_segment2(p, c, _sub(a, c)))))
    ap = _sub(p, a)
    d1, d2 = _dot(ab, ap), _dot(ac, ap)
    if d1 <= 0 and d2 <= 0:
        return _norm2(ap)
    bp = _sub(p, b)
    d3, d4 = _dot(ab, bp), _dot(ac, bp)
    if d3 >= 0 and d4 <= d3:
        return _norm2(bp)
    vc = _fms(d1, d4, d2, d3)
    if vc <= 0 and d1 >= 0 and d3 <= 0:
        v = F(d1/F(d1-d3))
        return _norm2(_sub(p, _axpy(ab, v, a)))
    cp = _sub(p, c)
    d5, d6 = _dot(ab, cp), _dot(ac, cp)
    if d6 >= 0 and d5 <= d6:
        return _norm2(cp)
    vb = _fms(d2, d5, d1, d6)
    if vb <= 0 and d2 >= 0 and d6 <= 0:
        w = F(d2/F(d2-d6))
        return _norm2(_sub(p, _axpy(ac, w, a)))
    va = _fms(d3, d6, d4, d5)
    e, f = F(d4-d3), F(d5-d6)
    if va <= 0 and e >= 0 and f >= 0:
        w = F(e/F(e+f))
        return _norm2(_sub(p, np.array([F(fma(w, F(c[i]-b[i]), b[i])) for i in range(3)], F)))
    denom = F(F(1)/F(vc+F(va+vb)))
    v, w = F(vb*denom), F(vc*denom)
    q = np.array([F(fma(ac[i], w, fma(ab[i], v, a[i]))) for i in range(3)], F)
    return _norm2(_sub(p, q))


def _overlap(lo, hi, node):
    """Node box test of the queries (unordered comparisons reject NaN)."""
    return (not (lo[0] > node[3]) and not np.isnan(node[3]) and not (hi[0] < node[0]) and not np.isnan(node[0])
            and not (lo[1] > node[4]) and not np.isnan(node[4]) and not (hi[1] < node[1]) and not np.isnan(node[1])
            and not (lo[2] > node[5]) and not np.isnan(node[5]) and hi[2] >= node[2])


def traverse(tree, lo, hi, visit, max_hits):
    """Stackless walk of query_*: calls visit(primitive) at overlapping leaves; visit returns True on a hit."""
    n = len(tree.order)
    internal = n-1
    hits = 0
    previous, current = -1, 0
    while True:
        parent = int(tree.parent[current])
        if previous == parent:
            nxt = previous
            if _overlap(lo, hi, tree.nodes[current]):
                if current < internal:
                    nxt = int(tree.children[current, 0])
                elif visit(int(tree.order[current-internal])):
                    hits += 1
        elif current >= internal:
            nxt = parent
        elif previous == int(tree.children[current, 0]):
            nxt = int(tree.children[current, 1])
        else:
            nxt = parent
        previous, current = current, nxt
        if not (hits < max_hits and current > -1):
            return hits


def query_vertex_face(x, vertices, triangles, tree, radius, extra, skip_incident, groups, max_slots,
                      vertex_radius=None):
    """query_vertex_face: per query vertex, up to max_slots triangle indices with squared distance below
    ((r + extra) * 1.5)^2, in traversal order. Returns (counts, slots[len(vertices), max_slots])."""
    counts = np.zeros(len(vertices), np.int32)
    slots = np.full((len(vertices), max_slots), -1, np.int32)
    for k, v in enumerate(vertices):
        r = F(radius if vertex_radius is None else vertex_radius[v])
        p = x[v]
        lo = np.array([F(p[i]-r) for i in range(3)], F)
        hi = np.array([F(p[i]+r) for i in range(3)], F)
        limit = F(F(F(r+F(extra))*F(1.5))*F(F(r+F(extra))*F(1.5)))
        found = []

        def visit(prim):
            tri = triangles[prim]
            if skip_incident and v in (tri[0], tri[1], tri[2]):
                return False
            if groups is not None:
                for t in tri:
                    if not (groups[v] == groups[t] or (int(groups[v]) | int(groups[t])) < 0):
                        return False
            if point_triangle_distance2(p, x[tri[0]], x[tri[1]], x[tri[2]]) < limit:
                found.append(prim)
                return True
            return False

        counts[k] = traverse(tree, lo, hi, visit, max_slots) if max_slots >= 1 else 0
        slots[k, :len(found)] = found
    return counts, slots


EPS_SEGMENT = F(1e-5)


def _sat(v):
    return F(0) if np.isnan(v) else F(min(max(v, F(0)), F(1)))


def _difference_of_products(a, b, c, d):
    """a*b - c*d with Kahan's error compensation, written with explicit fma in the PTX."""
    cd = F(c*d)
    return F(F(fma(a, b, -cd))+F(fma(-c, d, cd)))


def segment_parameters(p1, q1, p2, q2):
    """Closest-point parameters (s, t) on segments p1q1 and p2q2 (Ericson), shared by query and accumulate."""
    d1, d2 = _sub(q1, p1), _sub(q2, p2)
    r = _sub(p1, p2)
    a, e, f = _norm2(d1), _norm2(d2), _dot(d2, r)
    s = t = F(0)
    if a <= EPS_SEGMENT and e <= EPS_SEGMENT:
        pass
    elif not a > EPS_SEGMENT:
        t = _sat(F(f/e))
    else:
        c = _dot(d1, r)
        if not e > EPS_SEGMENT:
            s = _sat(F(F(-c)/a))
        else:
            b = _dot(d1, d2)
            denom = _difference_of_products(a, e, b, b)
            if denom > 0:
                s = _sat(F(_difference_of_products(b, f, c, e)/denom))
            t = F(F(fma(b, s, f))/e)
            if t < 0:
                t = F(0)
                s = _sat(F(F(-c)/a))
            elif t > 1:
                t = F(1)
                s = _sat(F(F(b-c)/a))
    return s, t, d1, d2


def segment_segment_distance2(p1, q1, p2, q2):
    """Squared distance between segments p1q1 and p2q2, as in query_edge_edge."""
    s, t, d1, d2 = segment_parameters(p1, q1, p2, q2)
    return _norm2(_sub(_axpy(d1, s, p1), _axpy(d2, t, p2)))


def _groups_ok(groups, pairs):
    if groups is None:
        return True
    return all(groups[u] == groups[w] or (int(groups[u]) | int(groups[w])) < 0 for u, w in pairs)


def query_edge_edge(x, edges, tree, radius, groups, max_slots):
    """query_edge_edge: per edge i, edges j > i not sharing a vertex with squared segment distance < (3r)^2."""
    count = len(edges)
    counts = np.zeros(count, np.int32)
    slots = np.full((count, max_slots), -1, np.int32)
    r = F(radius)
    limit = F(F(r*F(9))*r)
    for i in range(count):
        a, b = int(edges[i, 2]), int(edges[i, 3])
        p1, q1 = x[a], x[b]
        lo = np.array([F(min(p1[k], q1[k])-r) for k in range(3)], F)
        hi = np.array([F(max(p1[k], q1[k])+r) for k in range(3)], F)
        found = []

        def visit(j):
            c, d = int(edges[j, 2]), int(edges[j, 3])
            if i >= j or a in (c, d) or b in (c, d):
                return False
            if not _groups_ok(groups, ((a, c), (a, d), (b, c), (b, d))):
                return False
            if segment_segment_distance2(p1, q1, x[c], x[d]) < limit:
                found.append(j)
                return True
            return False

        counts[i] = traverse(tree, lo, hi, visit, max_slots) if max_slots >= 1 else 0
        slots[i, :len(found)] = found
    return counts, slots


def query_edge_face(x, edges, triangles, tree, radius, groups, max_slots):
    """query_edge_face: per edge, triangles whose box overlaps the edge box grown by 2r and that share no vertex
    with the edge (no distance test here; accumulate_edge_face does the geometry)."""
    count = len(edges)
    counts = np.zeros(count, np.int32)
    slots = np.full((count, max_slots), -1, np.int32)
    grow = F(F(radius)+F(radius))
    for i in range(count):
        a, b = int(edges[i, 2]), int(edges[i, 3])
        p, q = x[a], x[b]
        lo = np.array([F(min(p[k], q[k])-grow) for k in range(3)], F)
        hi = np.array([F(grow+max(p[k], q[k])) for k in range(3)], F)
        found = []

        def visit(t):
            tri = [int(v) for v in triangles[t]]
            if a in tri or b in tri:
                return False
            if not _groups_ok(groups, [(a, v) for v in tri]+[(b, v) for v in tri]):
                return False
            found.append(t)
            return True

        counts[i] = traverse(tree, lo, hi, visit, max_slots) if max_slots >= 1 else 0
        slots[i, :len(found)] = found
    return counts, slots


def _finite(*values):
    return all(abs(v) < np.inf for v in values)


def _harmonic_stiffness(m_vertex, m_face, stiffness, scaled):
    """stiffness * mv mf / (mv + mf) as in accumulate_vertex_face (scaled = mv * stiffness)."""
    if m_vertex == 0 or m_face == 0:
        return F(F(m_vertex+m_face)*stiffness)
    num, den = F(scaled*m_face), F(m_vertex+m_face)
    if _finite(num, den):
        return F(num/den)
    lo, hi = F(min(m_vertex, m_face)), F(max(m_vertex, m_face))
    return F(F(lo/F(F(lo/hi)+F(1)))*stiffness)


def accumulate_vertex_face(x, vertices, triangles, counts, slots, mass, radius, extra, skip_incident, stiffness,
                           force, diagonal, contacts=None):
    """accumulate_vertex_face: penalty forces into `force` [n,3], k n n^T blocks into `diagonal` [n,9] and, if a list
    is given, SelfCollisionContactTangent records (vertex, a, b, c, weights (1, -u, -v, -w), n, k).

    Accumulation order: thread by thread, triangle vertices per contact, the query vertex once at the end."""
    limit = F(F(radius)+F(extra))

    def add(target, index, values):
        for i, value in enumerate(values):
            value = F(0) if abs(value) < np.finfo(F).tiny else value  # REDG...FTZ
            target[index, i] = F(target[index, i]+value)

    for k_thread, v in enumerate(vertices):
        p = x[v]
        m_v = F(mass[v])
        if not (_finite(*p, m_v, F(radius), limit)):
            continue
        scaled = F(m_v*F(stiffness))
        acc_f = [F(0)]*3
        acc_h = [F(0)]*9
        for slot in range(int(counts[k_thread])):
            t = int(slots[k_thread, slot])
            ia, ib, ic = (int(i) for i in triangles[t])
            if skip_incident and v in (ia, ib, ic):
                continue
            a, b, c = x[ia], x[ib], x[ic]
            if not (_finite(*a) and _finite(*b) and _finite(*c)):
                continue
            ab, ac = _sub(b, a), _sub(c, a)
            n = np.array((_fms(ab[1], ac[2], ab[2], ac[1]), _fms(ab[2], ac[0], ab[0], ac[2]),
                          _fms(ab[0], ac[1], ab[1], ac[0])), F)
            length = F(np.sqrt(_norm2(n)))
            n = n/length if not length < F(1e-12) else np.zeros(3, F)
            n = n.astype(F)
            if not _finite(*n) or F(F(n[2]*n[2])+F(F(n[0]*n[0])+F(n[1]*n[1]))) == 0:
                continue
            d = _dot(_sub(p, a), n)
            if not abs(d) < np.inf or abs(d) > limit:
                continue
            q = np.array([F(fma(-d, n[i], p[i])) for i in range(3)], F)
            v0, v1, v2 = _sub(a, c), _sub(b, c), _sub(q, c)
            d00, d01, d02 = _norm2(v0), _dot(v0, v1), _dot(v0, v2)
            d11, d12 = _norm2(v1), _dot(v1, v2)
            denom = _fms(d00, d11, d01, d01)
            if abs(denom) < F(1e-12):
                continue
            inv = F(F(1)/denom)
            wa = F(inv*_fms(d11, d02, d01, d12))
            wb = F(inv*_fms(d00, d12, d01, d02))
            wc = F(F(F(1)-wa)-wb)
            if not _finite(wa, wb, wc) or wa < 0 or wb < 0 or wc < 0:
                continue
            m_face = F(F(F(F(mass[ib])+F(mass[ia]))+F(mass[ic]))/F(3))
            k = _harmonic_stiffness(m_v, m_face, F(stiffness), scaled)
            sign = F(1) if d > 0 else (F(-1) if d < 0 else F(0))
            magnitude = F(sign*F(F(limit-F(abs(d)))*k))
            f = [F(magnitude*n[0]), F(magnitude*n[1]), F(magnitude*n[2])]
            h00, h10, h20 = F(F(n[0]*n[0])*k), F(F(n[1]*n[0])*k), F(F(n[2]*n[0])*k)
            h11, h21, h22 = F(F(n[1]*n[1])*k), F(F(n[2]*n[1])*k), F(F(n[2]*n[2])*k)
            if not (_finite(*f) and _finite(h00, h10, h20, h11, h21, h22)):
                continue
            acc_f = [F(acc_f[i]+f[i]) for i in range(3)]
            for i, h in enumerate((h00, h10, h20, h10, h11, h21, h20, h21, h22)):
                acc_h[i] = F(acc_h[i]+h)
            if contacts is not None:
                contacts.append((v, ia, ib, ic, F(0), F(1), F(-wa), F(-wb), F(-wc), F(0), n[0], n[1], n[2], k))
            for index, w in ((ia, F(-wa)), (ib, F(-wb)), (ic, F(-wc))):
                add(force, index, [F(f[i]*w) for i in range(3)])
                w2 = F(F(-w)*F(-w))
                hw = [F(w2*h) for h in (h00, h10, h20, h11, h21, h22)]
                add(diagonal, index, [hw[0], hw[1], hw[2], hw[1], hw[3], hw[4], hw[2], hw[4], hw[5]])
        add(force, v, acc_f)
        add(diagonal, v, acc_h)


def _member(offsets, data, row, value):
    return value in data[offsets[row]:offsets[row+1]]


def accumulate_edge_edge(x, edges, opposite_offsets, opposite, counts, slots, mass, thickness, stiffness,
                         force, diagonal, contacts=None):
    """accumulate_edge_edge: interior closest points only (0 < s, t < 1); threshold `thickness`, reduced to
    min(thickness, average edge length / 4) when an endpoint of one edge is an opposite vertex of the other.
    Query edge endpoints accumulate locally with fma (weights 1-s, s); candidate endpoints atomically (-(1-t), -t)."""
    def add(target, index, values):
        for i, value in enumerate(values):
            value = F(0) if abs(value) < np.finfo(F).tiny else value
            target[index, i] = F(target[index, i]+value)

    stiffness = F(stiffness)
    for i in range(len(edges)):
        za, wa = int(edges[i, 2]), int(edges[i, 3])
        p, q = x[za], x[wa]
        length = F(np.sqrt(_norm2(_sub(p, q))))
        m_edge = F(F(F(mass[za])+F(mass[wa]))*F(0.5))
        if not _finite(*p, *q, length, m_edge):
            continue
        scaled = F(m_edge*stiffness)
        acc = {za: ([F(0)]*3, [F(0)]*9), wa: ([F(0)]*3, [F(0)]*9)}
        for slot in range(int(counts[i])):
            j = int(slots[i, slot])
            if i >= j:
                continue
            zc, wc = int(edges[j, 2]), int(edges[j, 3])
            if za in (zc, wc) or wa in (zc, wc):
                continue
            c, dpt = x[zc], x[wc]
            if not (_finite(*c) and _finite(*dpt)):
                continue
            s, t, d1, d2 = segment_parameters(p, q, c, dpt)
            if not (s > 0 and s < 1 and t > 0 and t < 1):
                continue
            diff = _sub(_axpy(d1, s, p), _axpy(d2, t, c))
            distance = F(np.sqrt(_norm2(diff)))
            other = F(np.sqrt(_norm2(_sub(c, dpt))))
            mean = F(F(length+other)*F(0.5))
            if not _finite(distance, mean):
                continue
            limit = F(thickness)
            if (_member(opposite_offsets, opposite, i, zc) or _member(opposite_offsets, opposite, i, wc)
                    or _member(opposite_offsets, opposite, j, za) or _member(opposite_offsets, opposite, j, wa)):
                limit = F(min(F(thickness), F(mean*F(0.5))))
            if distance >= limit or distance <= F(1e-6):
                continue
            n = np.array([F(diff[k]/distance) for k in range(3)], F)
            m_other = F(F(F(mass[wc])+F(mass[zc]))*F(0.5))
            k = _harmonic_stiffness(m_edge, m_other, stiffness, scaled)
            magnitude = F(F(limit-distance)*k)
            h = [F(F(n[0]*n[0])*k), F(F(n[1]*n[0])*k), F(F(n[2]*n[0])*k), F(F(n[1]*n[1])*k), F(F(n[2]*n[1])*k),
                 F(F(n[2]*n[2])*k)]
            f = [F(n[0]*magnitude), F(n[1]*magnitude), F(n[2]*magnitude)]
            if not (_finite(*f) and _finite(*h)):
                continue
            hm = (h[0], h[1], h[2], h[1], h[3], h[4], h[2], h[4], h[5])
            one_s, one_t = F(F(1)-s), F(F(1)-t)
            if contacts is not None:
                contacts.append((za, wa, zc, wc, F(0), one_s, s, F(-one_t), F(-t), F(0), n[0], n[1], n[2], k))
            for vertex, weight, local, other_vertex, other_weight in ((za, one_s, True, zc, F(-one_t)),
                                                                      (wa, s, True, wc, F(-t))):
                fa, ha = acc[vertex]
                acc[vertex] = ([F(fma(f[e], weight, fa[e])) for e in range(3)],
                               [F(fma(hm[e], F(weight*weight), ha[e])) for e in range(9)])
                add(force, other_vertex, [F(f[e]*other_weight) for e in range(3)])
                w2 = F(F(-other_weight)*F(-other_weight))
                add(diagonal, other_vertex, [F(w2*v) for v in hm])
        for vertex in (za, wa):
            add(force, vertex, acc[vertex][0])
            add(diagonal, vertex, acc[vertex][1])


def _cross_fms(u, v):
    return np.array((_fms(u[1], v[2], u[2], v[1]), _fms(u[2], v[0], u[0], v[2]), _fms(u[0], v[1], u[1], v[0])), F)


def accumulate_edge_face(x, edges, opposite_offsets, opposite, triangles, counts, slots, mass, thickness, stiffness,
                         force, diagonal, contacts=None):
    """accumulate_edge_face: an edge crossing a triangle (endpoints on both sides, barycentric weights >= 0.01) is
    pushed with constant magnitude 2*thickness*k along a direction built from the edge's adjacent faces (opposite
    vertices), each folded by the triangle normal. Edge endpoints accumulate locally with fma (weights from the
    crossing point), triangle vertices atomically (-u, -v, -w)."""
    def add(target, index, values):
        for i, value in enumerate(values):
            value = F(0) if abs(value) < np.finfo(F).tiny else value
            target[index, i] = F(target[index, i]+value)

    stiffness = F(stiffness)
    twice = F(F(thickness)+F(thickness))
    for i in range(len(edges)):
        z, w = int(edges[i, 2]), int(edges[i, 3])
        xz, xw = x[z], x[w]
        e = _sub(xz, xw)
        length = F(np.sqrt(_norm2(e)))
        if not _finite(*xz, *xw, length) or length < F(0.0005):
            continue
        direction = (e/length).astype(F) if length > 0 else np.zeros(3, F)
        m_edge = F(F(F(mass[w])+F(mass[z]))*F(0.5))
        if not _finite(m_edge):
            continue
        scaled = F(m_edge*stiffness)
        acc_f = {z: [F(0)]*3, w: [F(0)]*3}
        acc_h = {z: [F(0)]*9, w: [F(0)]*9}
        for slot in range(int(counts[i])):
            t = int(slots[i, slot])
            ia, ib, ic = (int(v) for v in triangles[t])
            if z in (ia, ib, ic) or w in (ia, ib, ic):
                continue
            a, b, c = x[ia], x[ib], x[ic]
            if not (_finite(*a) and _finite(*b) and _finite(*c)):
                continue
            cross = _cross_fms(_sub(b, a), _sub(c, b))  # (b - a) x (c - b) in this kernel
            area = F(np.sqrt(_norm2(cross)))
            if area < F(1e-8) or not _finite(area):
                continue
            tn = (cross/area).astype(F)
            dz, dw = _dot(_sub(xz, a), tn), _dot(_sub(xw, a), tn)
            if not _finite(dz, dw) or F(dz*dw) >= 0:
                continue
            az, aw = F(abs(dz)), F(abs(dw))
            total = F(az+aw)
            if not _finite(total) or total <= 0:
                continue
            point = np.array([F(F(fma(xw[k], az, F(xz[k]*aw)))/total) for k in range(3)], F)
            v0, v1, v2 = _sub(a, c), _sub(b, c), _sub(point, c)
            d00, d01, d02 = _norm2(v0), _dot(v0, v1), _dot(v0, v2)
            d11, d12 = _norm2(v1), _dot(v1, v2)
            denom = _fms(d00, d11, d01, d01)
            if abs(denom) < F(1e-12):
                continue
            inv = F(F(1)/denom)
            wa = F(inv*_fms(d11, d02, d01, d12))
            wb = F(inv*_fms(d00, d12, d01, d02))
            wc = F(F(F(1)-wa)-wb)
            if not _finite(wa, wb, wc) or wa < F(0.01) or wb < F(0.01) or wc < F(0.01):
                continue
            accum = np.zeros(3, F)
            ewz = _sub(xw, xz)
            tn_dir = F(fma(tn[2], direction[2], fma(tn[0], direction[0], F(tn[1]*direction[1]))))
            for o in opposite[opposite_offsets[i]:opposite_offsets[i+1]]:
                xo = x[int(o)]
                fn = _cross_fms(ewz, _sub(xo, xz))
                fl = F(np.sqrt(_norm2(fn)))
                fn = (fn/fl).astype(F) if not fl < F(1e-12) else np.zeros(3, F)
                if not _finite(*fn):
                    continue
                g = _cross_fms(tn, fn)
                gl = F(np.sqrt(_norm2(g)))
                g = (g/gl).astype(F) if not gl < F(1e-6) else np.zeros(3, F)
                h = _cross_fms(direction, g)
                r = _sub(xo, point)
                m = np.array((_fms(r[2], direction[1], r[1], direction[2]), _fms(r[0], direction[2], r[2], direction[0]),
                              _fms(r[1], direction[0], r[0], direction[1])), F)
                if F(fma(m[2], h[2], fma(m[0], h[0], F(m[1]*h[1])))) < 0:  # setp.geu: NaN keeps g
                    g = (-g).astype(F)
                if abs(tn_dir) > F(1e-6):
                    dg = F(fma(direction[2], g[2], fma(direction[1], g[1], F(direction[0]*g[0]))))
                    g = np.array([F(g[k]-F(F(F(tn[k]+tn[k])*dg)/tn_dir)) for k in range(3)], F)
                accum = (accum+g).astype(F)
            dl = F(np.sqrt(_norm2(accum)))
            if not _finite(dl) or dl < F(1e-12):
                continue
            nd = (accum/dl).astype(F)
            m_face = F(F(F(F(mass[ib])+F(mass[ia]))+F(mass[ic]))/F(3))
            k = _harmonic_stiffness(m_edge, m_face, stiffness, scaled)
            if not _finite(k):
                continue
            magnitude = F(twice*k)
            f = [F(nd[0]*magnitude), F(nd[1]*magnitude), F(nd[2]*magnitude)]
            hh = [F(F(nd[0]*nd[0])*k), F(F(nd[1]*nd[0])*k), F(F(nd[2]*nd[0])*k), F(F(nd[1]*nd[1])*k),
                  F(F(nd[2]*nd[1])*k), F(F(nd[2]*nd[2])*k)]
            if not (_finite(*f) and _finite(*hh)):
                continue
            hm = (hh[0], hh[1], hh[2], hh[1], hh[3], hh[4], hh[2], hh[4], hh[5])
            wz, ww = F(aw/total), F(az/total)
            if contacts is not None:
                contacts.append(((z, w, ia, ib, ic), (wz, ww, F(-wa), F(-wb), F(-wc)), nd, k, 5))
            for vertex, weight in ((z, wz), (w, ww)):
                acc_f[vertex] = [F(fma(f[q], weight, acc_f[vertex][q])) for q in range(3)]
                acc_h[vertex] = [F(fma(hm[q], F(weight*weight), acc_h[vertex][q])) for q in range(9)]
            for vertex, weight in ((ia, F(-wa)), (ib, F(-wb)), (ic, F(-wc))):
                add(force, vertex, [F(f[q]*weight) for q in range(3)])
                w2 = F(F(-weight)*F(-weight))
                add(diagonal, vertex, [F(w2*v) for v in hm])
        for vertex in (z, w):
            add(force, vertex, acc_f[vertex])
            add(diagonal, vertex, acc_h[vertex])


def particle_aabbs(x, ids, radius):
    """build_particle_aabbs (single world): x[id] -/+ radius[id]."""
    pts, r = x[ids], radius[ids][:, None]
    return np.concatenate(((pts-r).astype(F), (pts+r).astype(F)), axis=1)


def query_particle_pairs(x, ids, radius, world, groups, tree, max_slots):
    """query_particle_pairs (single world). From each particle's leaf, climb to the root and walk every sibling
    subtree in preorder through escape links; keep j > i (particle ids), not in the same nonzero group, the same
    world or a negative one, and |x_i - x_j|^2 < (r_i + r_j)^2. Returns (counts, slots[len(ids), max_slots])."""
    n = len(ids)
    internal = n-1
    counts = np.zeros(n, np.int32)
    slots = np.zeros((n, max_slots), np.int32)
    for t in range(n):
        i = int(ids[t])
        p = x[i]
        r = F(radius[i])
        lo, hi = (p-r).astype(F), (p+r).astype(F)
        found = 0
        node = int(tree.leaf[t])
        parent = int(tree.parent[node])
        if parent < 0 or max_slots < 1:
            continue
        while True:
            previous, node = node, parent
            a, b = int(tree.children[node, 0]), int(tree.children[node, 1])
            s = b if a == previous else a
            stop = int(tree.escape[s]) if s >= 0 else -1
            if not (s < 0 or s == stop or found >= max_slots):
                while True:
                    if _overlap(lo, hi, tree.nodes[s]):
                        if s < internal:
                            nxt = int(tree.children[s, 0])
                        else:
                            j = int(ids[tree.order[s-internal]])
                            if j > i and not (groups[i] != 0 and groups[i] == groups[j]) and (
                                    world is None or world[i] == world[j] or (world[i] | world[j]) < 0):
                                d = (p-x[j]).astype(F)
                                reach = F(r+F(radius[j]))
                                if _norm2(d) < F(reach*reach):
                                    slots[t, found] = j
                                    found += 1
                            nxt = int(tree.escape[s])
                    else:
                        nxt = int(tree.escape[s])
                    s = nxt
                    if not (s != stop and s > -1 and found < max_slots):
                        break
            parent = int(tree.parent[node])
            if not (parent > -1 and found < max_slots):
                break
        counts[t] = found
    return counts, slots


def _simt_warps_descending(t, m, warp):
    return (-(t//warp), m)


_PAIR_ORDER = _simt_warps_descending
_LANE_SIGN = 1


def accumulate_particle_pairs(x, ids, radius, counts, slots, weight, stiffness, force, diagonal, contacts=None,
                              warp=32):
    """accumulate_particle_pairs (single world): penalty (r_i + r_j - |d|) k n with k the harmonic mean of the two
    weights times stiffness, k n n^T on both diagonal blocks, and 2-point contact records (weights 1, -1).

    Atomics and the contact counter follow SIMT order: warps descending, then loop iteration (pair slot), then the
    kernel's instruction order, lanes ascending (as numerics.element_atomic_add)."""
    k = F(stiffness)
    zero = F(0)
    ops = []  # (warp key, slot, instruction, lane, payload)
    for t in range(len(ids)):
        i = int(ids[t])
        xi, mi = x[i], F(weight[i])
        if not _finite(xi[0], xi[1], xi[2], mi) or counts[t] < 1:
            continue
        for m in range(int(counts[t])):
            j = int(slots[t, m])
            xj = x[j]
            if not _finite(xj[0], xj[1], xj[2], radius[j]):
                continue
            d = (xi-xj).astype(F)
            dist = F(np.sqrt(_norm2(d)))
            reach = F(F(radius[i])+F(radius[j]))
            if not _finite(dist, reach) or not dist < reach:
                continue
            if dist > F(1e-8):
                nrm = [F(d[0]/dist), F(d[1]/dist), F(d[2]/dist)]
            else:
                axis = (j ^ i) % 3
                nrm = [F(axis == 0), F(axis == 1), F(axis == 2)]
            kk = _harmonic_stiffness(mi, F(weight[j]), k, F(mi*k))
            if not _finite(kk):
                continue
            s = F(F(reach-dist)*kk)
            f = [F(s*nrm[0]), F(s*nrm[1]), F(s*nrm[2])]
            h = [F(F(a*b)*kk) for a, b in ((nrm[0], nrm[0]), (nrm[0], nrm[1]), (nrm[0], nrm[2]), (nrm[1], nrm[1]),
                                           (nrm[1], nrm[2]), (nrm[2], nrm[2]))]
            block = [h[0], h[1], h[2], h[1], h[3], h[4], h[2], h[4], h[5]]
            if not (_finite(*f) and _finite(h[0], h[1], h[2]) and _finite(h[1], h[3], h[4])
                    and _finite(h[2], h[4], h[5])):
                continue
            key = _PAIR_ORDER(t, m, warp)
            ops.append((*key, 0, _LANE_SIGN*(t % warp), (force, i, f)))
            ops.append((*key, 1, _LANE_SIGN*(t % warp), (force, j, [-v for v in f])))
            ops.append((*key, 2, _LANE_SIGN*(t % warp), (diagonal, i, block)))
            ops.append((*key, 3, _LANE_SIGN*(t % warp), (diagonal, j, block)))
            if contacts is not None:
                ops.append((*key, 4, _LANE_SIGN*(t % warp), ((i, j, 0, 0, 0), (1, -1, zero, zero, zero), tuple(nrm), kk, 2)))
    for *_, payload in sorted(ops, key=lambda op: op[:4]):
        if len(payload) == 3:
            target, index, values = payload
            for q, value in enumerate(values):
                value = F(0) if abs(value) < np.finfo(F).tiny else value  # REDG...FTZ
                target[index, q] = F(target[index, q]+value)
        else:
            contacts.append(payload)


CONTACT_TANGENT = np.dtype([('ids', '<i4', (5,)), ('w', '<f4', (5,)), ('n', '<f4', (3,)), ('k', '<f4'),
                            ('count', '<i4')])  # synreal::SelfCollisionContactTangent, 60 bytes


def contact_records(contacts):
    """Pack accumulate_* tuples into SelfCollisionContactTangent records (4-point records pad id/weight 4 with 0)."""
    records = np.zeros(len(contacts), CONTACT_TANGENT)
    for i, c in enumerate(contacts):
        if len(c) == 5:  # edge-face: (ids5, weights5, n, k, count)
            records[i] = c
        else:  # vertex-face / edge-edge: (id0..id3, pad, w0..w3, pad, nx, ny, nz, k) with ids before weights
            records[i] = ((c[0], c[1], c[2], c[3], 0), (c[5], c[6], c[7], c[8], c[9]), (c[10], c[11], c[12]), c[13], 4)
    return records


def multiply_hessian_diagonal(blocks, direction, product):
    """self_collision_kernel::multiply_hessian_diagonal: product += M p per particle (M p first, then + product)."""
    from .pcg import mat_vec
    product[:] = (mat_vec(np.asarray(blocks, F), np.asarray(direction, F))+product).astype(F)

def add_hessian_diagonal(source, target):
    """add_hessian_diagonal: target += source per 3x3 block."""
    target[:] = (target+source).astype(F)


_TANGENT_SIMT = -1  # 0: list order; -1: SIMT, warps descending; 1: SIMT, warps ascending


def multiply_contact_tangents(records, direction, out, warp=32):
    """multiply_contact_tangents: out[id_i] += w_i ((k n . sum_j w_j p[id_j]) n), one thread per record.

    With _TANGENT_SIMT the atomics are applied warps descending, then point index, lanes ascending; otherwise
    record by record in list order."""
    ops = []
    for r, rec in enumerate(records):
        count = int(rec['count'])
        s = [F(0)]*3
        for i in range(count):
            pi = direction[int(rec['ids'][i])]
            wi = F(rec['w'][i])
            s = [F(fma(wi, pi[q], s[q])) for q in range(3)]
        n = rec['n']
        vn = F(fma(s[2], n[2], fma(s[0], n[0], F(s[1]*n[1]))))
        scale = F(F(rec['k'])*vn)
        g = [F(scale*n[0]), F(scale*n[1]), F(scale*n[2])]
        for i in range(count):
            key = (_TANGENT_SIMT*(r//warp), i, r % warp) if _TANGENT_SIMT else (r, i, 0)
            ops.append((key, int(rec['ids'][i]), [F(g[q]*F(rec['w'][i])) for q in range(3)]))
    for _, index, values in sorted(ops, key=lambda op: op[0]):
        for q, value in enumerate(values):
            value = F(0) if abs(value) < np.finfo(F).tiny else value
            out[index, q] = F(out[index, q]+value)


def opposite_vertex_csr(edges):
    """Per-edge CSR of the valid opposite vertices (o0, o1) in ascending order, as uploaded by the legacy host."""
    rows = [sorted(int(v) for v in e[:2] if v >= 0) for e in np.asarray(edges)]
    offsets = np.concatenate(([0], np.cumsum([len(r) for r in rows]))).astype(np.int32)
    data = np.array([v for r in rows for v in r], np.int32)
    return offsets, data


class SelfCollision:
    """Cloth self-collision state: LBVHs built once from the initial positions, then refit and queried per substep,
    and accumulated every Newton iteration (legacy order: vertex-face, edge-edge, edge-face)."""
    MAX_SLOTS = 31

    def __init__(self, x_initial, triangles, edges, mass, groups, radius, stiffness=(0.5, 0.1, 1.0),
                 free_particles=None, particle_radius=None, particle_stiffness=1.0):
        from . import lbvh
        self.triangles = np.asarray(triangles, np.int32)
        self.edges = np.asarray(edges, np.int32)
        self.mass, self.groups = mass, groups
        self.radius = F(radius)
        self.stiffness = tuple(F(s) for s in stiffness)
        self.cloth = len(self.triangles) > 0
        if self.cloth:
            self.tri_tree = lbvh.Lbvh(lbvh.triangle_aabbs(x_initial, self.triangles, 0))
            self.edge_tree = lbvh.Lbvh(lbvh.edge_aabbs(x_initial, self.edges, 0))
            self.offsets, self.opposite = opposite_vertex_csr(self.edges)
            self.vertices = np.arange(len(x_initial), dtype=np.int32)
        # Free particles (no topology) collide pairwise with radii r_i + r_j of the model's particle radius; their
        # tree is built from the initial boxes x -/+ r (not zero thickness as the triangle and edge trees).
        self.free = np.asarray(free_particles if free_particles is not None else [], np.int32)
        if len(self.free) > 1:
            self.particle_radius = np.asarray(particle_radius, F)
            self.particle_stiffness = F(particle_stiffness)
            self.particle_tree = lbvh.Lbvh(particle_aabbs(x_initial, self.free, self.particle_radius))
            # The query's own group filter (P4) is a separate per-particle array, all zero in the legacy captures.
            self.particle_filter = np.zeros(len(x_initial), np.int32)

    def query(self, x):
        from . import lbvh
        r = self.radius
        if self.cloth:
            self.tri_tree.refit(lbvh.triangle_aabbs(x, self.triangles, r))
            self.edge_tree.refit(lbvh.edge_aabbs(x, self.edges, r))
            self.vf = query_vertex_face(x, self.vertices, self.triangles, self.tri_tree, r, r, True, self.groups,
                                        self.MAX_SLOTS)
            self.ee = query_edge_edge(x, self.edges, self.edge_tree, r, self.groups, self.MAX_SLOTS)
            self.ef = query_edge_face(x, self.edges, self.triangles, self.tri_tree, r, self.groups, self.MAX_SLOTS)
        if len(self.free) > 1:
            self.particle_tree.refit(particle_aabbs(x, self.free, self.particle_radius))
            self.pp = query_particle_pairs(x, self.free, self.particle_radius, self.groups, self.particle_filter,
                                           self.particle_tree, self.MAX_SLOTS)

    def accumulate(self, x, rhs, weight):
        """Forces into rhs; returns (diagonal blocks [n, 9] for the preconditioner, contact records).

        `weight` is the per-particle system diagonal copied before the accumulate kernels (inertia m/h^2, constant
        stiffness diagonal and contact scalars); the kernels' harmonic-mean stiffness is taken over it, not the mass."""
        diagonal = np.zeros((len(x), 9), F)
        contacts = []
        r = self.radius
        thickness = F(r+r)
        if not self.cloth:
            self._accumulate_particles(x, rhs, weight, diagonal, contacts)
            return diagonal, contact_records(contacts)
        accumulate_vertex_face(x, self.vertices, self.triangles, *self.vf, weight, r, r, True, self.stiffness[0],
                               rhs, diagonal, contacts)
        accumulate_edge_edge(x, self.edges, self.offsets, self.opposite, *self.ee, weight, thickness,
                             self.stiffness[1], rhs, diagonal, contacts)
        accumulate_edge_face(x, self.edges, self.offsets, self.opposite, self.triangles, *self.ef, weight,
                             thickness, self.stiffness[2], rhs, diagonal, contacts)
        self._accumulate_particles(x, rhs, weight, diagonal, contacts)
        return diagonal, contact_records(contacts)

    def _accumulate_particles(self, x, rhs, weight, diagonal, contacts):
        if len(self.free) > 1:
            accumulate_particle_pairs(x, self.free, self.particle_radius, *self.pp, weight, self.particle_stiffness,
                                      rhs, diagonal, contacts)
