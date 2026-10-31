"""Particle springs of the legacy solver (evaluate_spring_force, add_spring_gauss_newton_hessian), from the PTX.

The force kernel adds k (d - L n) to particle a and its negative to b (d = x_b - x_a, n = d / |d|, 0 if |d| = 0);
ptxas fuses d - L n into fma(-L, n, d). The Hessian kernel adds the Gauss-Newton correction k (H - I) with
H = n n^T + max(0, 1 - L / l) (I - n n^T) (H = I when l <= 1e-8) to both diagonal blocks and its negative to the
(a, b) and (b, a) blocks of the ELL matrix: the host constant matrix already holds the k I part.
"""
import numpy as np

from .fluid import _Atomics
from .numerics import F, fma


def spring_forces(x, springs, stiffness, rest):
    """Per-spring force on endpoint a (b receives the negative)."""
    a, b = springs[:, 0], springs[:, 1]
    d = (x[b]-x[a]).astype(F)
    length = np.sqrt(fma(d[:, 2], d[:, 2], fma(d[:, 0], d[:, 0], d[:, 1]*d[:, 1]))).astype(F)
    n = np.zeros_like(d)
    ok = length > 0
    n[ok] = (d[ok]/length[ok, None]).astype(F)
    return (stiffness[:, None]*fma(-rest[:, None], n, d)).astype(F)


def evaluate_spring_force(x, springs, stiffness, rest, force):
    """red.global.add of +f to a and -f to b, warps descending / lanes ascending (see fluid._Atomics)."""
    f = spring_forces(x, springs, stiffness, rest)
    rows = np.arange(len(springs))
    ops = _Atomics()
    ops.add(rows, 0, springs[:, 0], f)
    ops.add(rows, 1, springs[:, 1], -f)
    ops.apply(force)


def spring_hessian_blocks(x, springs, stiffness, rest):
    """k (H - I) per spring in glm column-major order, and the mask of springs the kernel processes."""
    a, b = springs[:, 0], springs[:, 1]
    d = (x[b]-x[a]).astype(F)
    k = stiffness.astype(F)
    active = ~(k <= 0) & ~(rest <= 0)  # setp.leu k, 0 / setp.le L, 0
    length = np.sqrt(fma(d[:, 2], d[:, 2], fma(d[:, 0], d[:, 0], d[:, 1]*d[:, 1]))).astype(F)
    one, zero = F(1), F(0)
    h = np.zeros((len(springs), 6), F)  # H00, H10, H20, H11, H21, H22
    h[:, 0] = h[:, 3] = h[:, 5] = one
    far = length > F(1e-8)
    with np.errstate(divide='ignore', invalid='ignore'):
        n = (d/length[:, None]).astype(F)
        s = np.maximum(zero, (one-(rest/length).astype(F)).astype(F)).astype(F)
    nn = [n[:, 0]*n[:, 0], n[:, 1]*n[:, 0], n[:, 2]*n[:, 0], n[:, 1]*n[:, 1], n[:, 2]*n[:, 1], n[:, 2]*n[:, 2]]
    identity = (one, zero, zero, one, zero, one)
    for c in range(6):
        value = fma((identity[c]-nn[c]).astype(F), s, nn[c].astype(F))
        h[far, c] = value[far]
    h00, h10, h20, h11, h21, h22 = (h[:, c] for c in range(6))
    block = np.stack((h00+F(-1), h10, h20, h10, h11+F(-1), h21, h20, h21, h22+F(-1)), axis=1).astype(F)
    return (k[:, None]*block).astype(F), active


def add_spring_hessian(x, springs, stiffness, rest, diagonal, ell):
    """diagonal [n, 9] += B at a and b; ELL (row_nnz, cols[max_nnz, n], blocks[max_nnz, n, 9], max_nnz)
    off-diagonal (a, b), (b, a) -= B. Degenerate a == b adds -B to the diagonal instead."""
    blocks, active = spring_hessian_blocks(x, springs, stiffness, rest)
    idx = np.flatnonzero(active)
    a, b = springs[idx, 0], springs[idx, 1]
    bl = blocks[idx]
    diag_ops = _Atomics()
    diag_ops.add(idx, 0, a, bl)
    diag_ops.add(idx, 1, b, bl)
    same = a == b
    diag_ops.add(idx[same], 2, a[same], -bl[same])
    diag_ops.add(idx[same], 3, b[same], -bl[same])
    diag_ops.apply(diagonal)
    if ell is None:
        return
    row_nnz, cols, values, max_nnz = ell
    n_rows = cols.shape[1]
    flat = values.reshape(-1, 9)
    off_ops = _Atomics()
    for slot_instr, rows, other in ((2, a, b), (3, b, a)):
        for t in np.flatnonzero(~same):
            r, c = int(rows[t]), int(other[t])
            count = min(int(row_nnz[r]), max_nnz)
            k = np.searchsorted(cols[:count, r], c)  # lower_bound on the sorted ELL column list
            if k < count and cols[k, r] == c:
                off_ops.add(idx[t:t+1], slot_instr, np.array([k*n_rows+r]), -bl[t:t+1])
    off_ops.apply(flat)
