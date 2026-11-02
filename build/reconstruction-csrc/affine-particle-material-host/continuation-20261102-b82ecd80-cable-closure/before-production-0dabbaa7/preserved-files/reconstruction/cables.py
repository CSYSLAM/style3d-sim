"""Recovered cable kernels. Full cable force/tangent scheduling is not implemented yet."""
import numpy as np

from .numerics import F


def prepare_penalties(base, penalty, initialized, per_world, beta0, beta1, scale, cap0, cap1,
                      reset, rescale, mask=None, count=None):
    """Prepare vec4 penalties in place, matching legacy prepare_cable_penalties.

    The base table repeats per world; history and the optional update mask are global arrays.
    The two beta parameters only select whether each pair is capped in this kernel.
    """
    n = len(penalty) if count is None else count
    if per_world <= 0 or len(base) < per_world or n < 0 or n > len(penalty):
        raise ValueError('Invalid cable table dimensions')
    factor = F(scale) if rescale else F(1)
    for i in range(n):
        if mask is not None and mask[i] == 0:
            continue
        upper = np.asarray(base[i % per_world], dtype=F)
        lower = upper.copy()
        if F(beta0) > F(0):
            lower[:2] = np.fmin(F(cap0), lower[:2])
        if F(beta1) > F(0):
            lower[2:] = np.fmin(F(cap1), lower[2:])
        old = lower if reset or initialized[i] == 0 else penalty[i].copy()
        # PTX uses separate mul/max/min; no contraction or float64 intermediates.
        penalty[i] = np.fmin(upper, np.fmax(lower, np.multiply(factor, old, dtype=F)))
        initialized[i] = 1
