"""Triangle air drag of the legacy solver (only faces with drag coefficient > 0, compacted once by the host).

Per substep, after initialize_step: initialize_triangle_drag on the substep-start positions gives the unit normal
n = (b - a) x (c - a) / |.| (0 if |.| <= 1e-12) and area |.|/2. Per Newton iteration, right after initialize_rhs:
evaluate_triangle_drag with v = (sum of vertex displacements) (1/h)/3 relative to the wind,
vn = n . (v - wind), q = (rho/2) Cd area, force -(q vn |vn|)/3 n on each vertex and the tangent scalar
c = 2 q |vn| (1/h) / 9. add_triangle_drag_preconditioner adds c n n^T to the three diagonal blocks of B;
multiply_triangle_drag_tangent adds n c (n . (p_a + p_b + p_c)) to each vertex of T.
ptxas fusions (SASS): the cross product products (numerics.fms) and fma(sum, (1/h)/3, -wind).
"""
import numpy as np

from .fluid import _Atomics
from .numerics import F, fma, fms


def _dot(n, v):
    return fma(n[:, 2], v[:, 2], fma(n[:, 0], v[:, 0], n[:, 1]*v[:, 1]))


def initialize(x, triangles):
    a, b, c = (x[triangles[:, k]] for k in range(3))
    e1, e2 = (b-a).astype(F), (c-a).astype(F)
    cross = np.stack((fms(e1[:, 1], e2[:, 2], e1[:, 2], e2[:, 1]), fms(e1[:, 2], e2[:, 0], e1[:, 0], e2[:, 2]),
                      fms(e1[:, 0], e2[:, 1], e1[:, 1], e2[:, 0])), axis=1).astype(F)
    length = np.sqrt(fma(cross[:, 2], cross[:, 2], fma(cross[:, 0], cross[:, 0], cross[:, 1]*cross[:, 1]))).astype(F)
    area = (length*F(0.5)).astype(F)
    normal = np.zeros_like(cross)
    ok = length > F(1e-12)
    normal[ok] = (cross[ok]/length[ok, None]).astype(F)
    return normal, area


def _scatter(triangles, values, target):
    rows = np.arange(len(triangles))
    ops = _Atomics()
    for k in range(3):
        ops.add(rows, k, triangles[:, k], values)
    ops.apply(target)


def evaluate(x, previous, triangles, coefficient, normal, area, density, wind, inv_h, force):
    """Adds the drag forces to `force`; returns the per-triangle tangent scalar."""
    d = [(x[triangles[:, k]]-previous[triangles[:, k]]).astype(F) for k in range(3)]
    total = ((d[0]+d[1]).astype(F)+d[2]).astype(F)
    third = F(F(inv_h)/F(3))
    rel = fma(total, third, -np.asarray(wind, F)[None, :])
    vn = _dot(normal, rel)
    q = ((F(density)*F(0.5))*coefficient).astype(F)
    qa = (q*area).astype(F)
    f = ((np.abs(vn)*(qa*vn).astype(F)).astype(F)/F(-3)).astype(F)
    _scatter(triangles, (normal*f[:, None]).astype(F), force)
    return (((np.abs(vn)*(qa+qa)).astype(F)*F(inv_h)).astype(F)/F(9)).astype(F)


def add_preconditioner(triangles, normal, scalar, precond):
    n0, n1, n2 = normal[:, 0], normal[:, 1], normal[:, 2]
    e = [scalar*(p*q) for p, q in ((n0, n0), (n1, n0), (n2, n0), (n1, n1), (n2, n1), (n2, n2))]
    block = np.stack((e[0], e[1], e[2], e[1], e[3], e[4], e[2], e[4], e[5]), axis=1).astype(F)
    _scatter(triangles, block, precond)


def multiply_tangent(direction, triangles, normal, scalar, product):
    total = ((direction[triangles[:, 1]]+direction[triangles[:, 0]]).astype(F)+direction[triangles[:, 2]]).astype(F)
    g = (scalar*_dot(normal, total)).astype(F)
    _scatter(triangles, (normal*g[:, None]).astype(F), product)
