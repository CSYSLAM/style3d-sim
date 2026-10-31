"""Host-side precomputation of the legacy SolverNewton::precompute_matrices, reproduced bit-exactly.

The legacy library builds these on the CPU with scalar SSE single precision (no FMA, every operation rounded) and
uploads them once. The order below was read from the x86 disassembly and checked bit-for-bit against the buffers the
legacy library uploads (captured with an LD_PRELOAD cudaMemcpy hook):

* triangles (Style3D membrane, isotropic part), then bending hinges, accumulate into per-row std::map<int, float>;
  for each element, vertex pairs (a, b >= a): a == b goes to a separate diagonal array, otherwise the same value is
  added to (a, b) and (b, a);
* membrane value ((u_a (ku+ks)) u_b + (v_a (kv+ks)) v_b) * area with u = (-m0-m2, m0, m2), v = (-m1-m3, m1, m3);
* bending value (w_a s) w_b with s = (3/area) kb and w = (-c0-c2, -c1-c3, c2+c3, c0+c1);
* tetrahedron volume 1 / (det(inverse Dm) * 6), determinant expanded along the first row.
"""
import numpy as np

F = np.float32


def _valid_hinge(idx, area):
    return (idx >= 0).all() and len(set(int(i) for i in idx)) == 4 and area > 0


def cloth_constant_matrix(n, triangles, poses, areas, stiffness, edges, cots, edge_areas, properties):
    """Return (diagonal[n], row_nnz[n], cols[max_nnz, n], values[max_nnz, n], max_nnz) of the constant matrix."""
    diagonal = np.zeros(n, F)
    rows = [dict() for _ in range(n)]

    def add(r, c, v):
        rows[r][c] = F(rows[r].get(c, F(0))+v)

    poses = np.asarray(poses, F).reshape(-1, 4)
    for t in range(len(triangles)):
        tri = triangles[t]
        p = poses[t]
        u = (F(F(-p[0])-p[2]), p[0], p[2])
        v = (F(F(-p[1])-p[3]), p[1], p[3])
        kuks = F(stiffness[t, 0]+stiffness[t, 2])
        kskv = F(stiffness[t, 2]+stiffness[t, 1])
        for a in range(3):
            pa, qa = F(u[a]*kuks), F(v[a]*kskv)
            for b in range(a, 3):
                value = F(F(F(pa*u[b])+F(qa*v[b]))*areas[t])
                if a == b:
                    diagonal[tri[a]] = F(diagonal[tri[a]]+value)
                else:
                    add(tri[a], tri[b], value)
                    add(tri[b], tri[a], value)
    for e in range(len(edges)):
        idx = edges[e]
        if not _valid_hinge(idx, edge_areas[e]):
            continue
        c0, c1, c2, c3 = (F(c) for c in cots[e])
        w = (F(F(-c0)-c2), F(F(-c1)-c3), F(c2+c3), F(c0+c1))
        s = F(F(F(3)/edge_areas[e])*properties[e, 0])
        for a in range(4):
            ws = F(w[a]*s)
            for b in range(a, 4):
                value = F(ws*w[b])
                if a == b:
                    diagonal[idx[a]] = F(diagonal[idx[a]]+value)
                else:
                    add(idx[a], idx[b], value)
                    add(idx[b], idx[a], value)
    row_nnz = np.array([len(r) for r in rows], np.int32)
    max_nnz = int(row_nnz.max()) if n else 0
    cols = np.full((max_nnz, n), -1, np.int32)
    values = np.zeros((max_nnz, n), F)
    for r, entries in enumerate(rows):
        for k, c in enumerate(sorted(entries)):  # std::map iterates columns in ascending order
            cols[k, r] = c
            values[k, r] = entries[c]
    return diagonal, row_nnz, cols, values, max_nnz


def tetrahedron_volumes(inverse_dm):
    """1 / (det * 6) with det = (m0 (m4 m8 - m5 m7) - m1 (m3 m8 - m5 m6)) + m2 (m3 m7 - m4 m6), glm column-major m."""
    m = np.asarray(inverse_dm, F).reshape(-1, 9)
    m0, m1, m2, m3, m4, m5, m6, m7, m8 = (m[:, i] for i in range(9))
    c0 = m8*m4-m5*m7
    c1 = m8*m3-m5*m6
    c2 = m3*m7-m6*m4
    det = (m0*c0-m1*c1)+m2*c2
    return (F(1)/(det*F(6))).astype(F)


def spring_constant_matrix(n, springs, stiffness):
    """Spring part of precompute_matrices (bit-exact against the uploaded buffers): diagonal[a], diagonal[b] += k in
    spring order; per-row maps add +k to (a, b) and (b, a); the ELL template stores -map value per column."""
    diagonal = np.zeros(n, F)
    rows = [dict() for _ in range(n)]
    for (a, b), k in zip(np.asarray(springs).reshape(-1, 2), np.asarray(stiffness, F)):
        if a == b:
            raise ValueError('spring with identical endpoints')  # the host rejects it as well
        rows[a][b] = F(rows[a].get(b, F(0))+k)
        rows[b][a] = F(rows[b].get(a, F(0))+k)
    for (a, b), k in zip(np.asarray(springs).reshape(-1, 2), np.asarray(stiffness, F)):
        diagonal[a] = F(diagonal[a]+k)
        diagonal[b] = F(diagonal[b]+k)
    row_nnz = np.array([len(r) for r in rows], np.int32)
    max_nnz = int(row_nnz.max()) if n else 0
    cols = np.full((max_nnz, n), -1, np.int32)
    values = np.zeros((max_nnz, n), F)
    for r, entries in enumerate(rows):
        for k, c in enumerate(sorted(entries)):
            cols[k, r] = c
            values[k, r] = -entries[c]
    return diagonal, row_nnz, cols, values, max_nnz
