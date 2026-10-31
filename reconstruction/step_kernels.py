"""Per-substep particle kernels of the legacy solver (initialize_step, apply_nonlinear_step, update_velocity),
transcribed from the sm_52 PTX; reconstruction/kernel_ab.py checks them bit for bit."""
import numpy as np

from .numerics import F, fma


def initialize_step(h, gravity, world, velocity, x, mass, templates, host_diagonal, flags=None, kind=None,
                    per_world=None):
    """initialize_step: returns (x_hat, previous, diagonal); `x` is the state buffer the kernel overwrites with x_hat.

    `templates` holds the five (D_k, c_k) diagonal coefficient arrays and weights; per particle (mass, D_k and the
    host diagonal indexed by the in-world index):
      active (m > 0 and ACTIVE flag):  previous = x, x_hat = fma(h^2, g, fma(v, h, x)),
                                       diagonal = host + fma(D5, c5, ... fma(D1, c1, m)) / (h*h)
      otherwise:                       previous = x (x - h v for affine-body particles, kind != 0, so that
                                       update_velocity returns their velocity), x_hat = x, diagonal = 0.
    Gravity is gravity[clamp(world, 0, count-1)], zero without gravity or for affine columns (kind 2)."""
    h = F(h)
    x = np.asarray(x, F)
    n = len(x)
    per_world = n if per_world is None else int(per_world)
    local = np.arange(n) % per_world
    m = np.asarray(mass, F)[local]
    active = m > 0
    if flags is not None:
        active &= (np.asarray(flags)[local] & 1) != 0
    previous = x.copy()
    x_hat = x.copy()
    diagonal = np.zeros(n, F)
    velocity = np.asarray(velocity, F)
    kinds = None if kind is None else np.asarray(kind)[local]
    if kinds is not None:
        moving = ~active & (kinds != 0)
        previous[moving] = fma(-velocity[moving], h, x[moving]).astype(F)  # ptxas contracts x - v h
    gravity = np.asarray(gravity, F).reshape(-1, 3)
    g = np.zeros((n, 3), F)
    if len(gravity):
        w = np.asarray(world)[local] if world is not None else np.arange(n)//per_world
        g = gravity[np.clip(w, 0, len(gravity)-1)].copy()
        if kinds is not None:
            g[kinds == 2] = 0
    acc = m
    for coefficients, weight in templates:
        acc = fma(np.asarray(coefficients, F)[local], F(weight), acc).astype(F)
    h2 = F(h*h)
    diag = (np.asarray(host_diagonal, F)[local]+(acc/h2).astype(F)).astype(F)
    prediction = fma(h2, g, fma(velocity, h, x)).astype(F)
    x_hat[active] = prediction[active]
    diagonal[active] = diag[active]
    return x_hat, previous, diagonal


def apply_nonlinear_step(x, delta):
    """apply_nonlinear_step: x + delta; the kernel also clears delta (returned as zeros)."""
    return (np.asarray(x, F)+np.asarray(delta, F)).astype(F), np.zeros_like(delta)


def update_velocity(inv_h, x, previous):
    """update_velocity: (x - previous) * (1/h) with the host's float32 reciprocal."""
    return ((np.asarray(x, F)-np.asarray(previous, F)).astype(F)*F(inv_h)).astype(F)


def _csr_sum(values, offsets, ids, row, sign=1):
    """+0 then values[ids[k]] added (or subtracted) in k order, as the kernels' remainder-then-unrolled loops do."""
    acc = F(0)
    for k in range(int(offsets[row]), int(offsets[row+1])):
        v = F(values[int(ids[k])])
        acc = F(acc+v) if sign > 0 else F(acc-v)
    return acc


def refresh_inertial_cache_nonzeros(values_a, offsets_a, ids_a, values_b, offsets_b, ids_b, out_a, out_b):
    """refresh_inertial_cache_nonzeros: per ELL nonzero e with a non-empty CSR row, out_a[e] = sum a and
    out_b[e] = 0 - sum b (value fields only; empty rows leave the entry unchanged). Updates out_a/out_b in place."""
    for e in range(len(out_a)):
        if offsets_a[e+1] != offsets_a[e]:
            out_a[e] = _csr_sum(values_a, offsets_a, ids_a, e)
        if offsets_b[e+1] != offsets_b[e]:
            out_b[e] = _csr_sum(values_b, offsets_b, ids_b, e, sign=-1)


def refresh_inertial_cache_diagonals(values, offsets, ids, out_scaled, out_sum):
    """refresh_inertial_cache_diagonals: per row with a non-empty CSR list, s = sum values; out_scaled = 3 s and
    out_sum = s (in place; empty rows untouched)."""
    for r in range(len(out_sum)):
        if offsets[r+1] != offsets[r]:
            s = _csr_sum(values, offsets, ids, r)
            out_scaled[r] = F(s*F(3))
            out_sum[r] = s


def combine_system_non_diagonal(scale, weights, templates):
    """combine_system_non_diagonal over 7 slot-aligned NonZeroEntry value arrays L0..L6 (columns from L0):
    fma(fma(L6, c5, ... fma(L2, c1, L1)), scale, L0)."""
    l = [np.asarray(t, F) for t in templates]
    acc = l[1]
    for k in range(5):
        acc = fma(l[k+2], F(weights[k]), acc).astype(F)
    return fma(acc, F(scale), l[0]).astype(F)
