"""Legacy 12x12 affine preconditioner. Matrices here are row-major, unlike glm mat3 inputs."""
import numpy as np
from .numerics import F, fma


def invert(matrix, active, output):
    """Scaled Cholesky and triangular solves; returns validity, preserving native partial writes on failure."""
    scale = np.ones(12, F)
    for i in range(12):
        value = matrix[i, i] if active[i] else F(1)
        if not (value > 0 and np.isfinite(value)):
            return False
        scale[i] = F(F(1)/F(np.sqrt(value)))
    lower = np.zeros((12, 12), F)
    for i in range(12):
        for j in range(i+1):
            value = F(i == j)
            if active[i] and active[j]:
                value = F(F(scale[i]*F(F(matrix[i, j]+matrix[j, i])*F(0.5)))*scale[j])
            for k in range(j):
                value = fma(-lower[i, k], lower[j, k], value)
            if i == j:
                if not (value > 0 and np.isfinite(value)):
                    return False
                lower[i, j] = F(np.sqrt(value))
            else:
                lower[i, j] = F(value/lower[j, j])
    for col in range(12):
        y, x = np.zeros(12, F), np.zeros(12, F)
        for i in range(12):
            value = F(i == col)
            for k in range(i):
                value = fma(-lower[i, k], y[k], value)
            y[i] = F(value/lower[i, i])
        for i in range(11, -1, -1):
            value = y[i]
            for k in range(i+1, 12):
                value = fma(-lower[k, i], x[k], value)
            x[i] = F(value/lower[i, i])
        for i in range(12):
            value = F(F(scale[i]*x[i])*scale[col]) if active[i] and active[col] else F(0)
            if not np.isfinite(value):
                return False
            output[i, col] = value
    for i in range(12):
        for j in range(i):
            value = F(F(output[i, j]+output[j, i])*F(0.5))
            output[i, j] = output[j, i] = value
    return True


def build(indices, mass, flags, diagonal, enabled, output, valid, particles_per_world,
          rows=None, entries=None, tile=None, cache=None, weight=None, rotation=None, alpha=0,
          cable_offsets=None, cable_ids=None, cables=None, inv_dt=0, matrices=None):
    """Build block/scalar ELL specializations; cached blocks seed only off-diagonal entries."""
    per_world = len(indices)
    tile = particles_per_world if tile is None else tile
    for body in range(len(valid)):
        valid[body] = 0
        local, world = body % per_world, body // per_world
        if enabled[local] == 0:
            continue
        ids = np.asarray(indices[local])+world*particles_per_world
        matrix = np.zeros((12, 12), F) if cache is None else cache[body].reshape(12, 12).copy()
        active = np.repeat([(mass[p % particles_per_world] > 0 and
                             (flags is None or flags[p % particles_per_world] & 1)) for p in ids], 3)
        for i, particle in enumerate(ids):
            matrix[i*3:i*3+3, i*3:i*3+3] = diagonal[particle].reshape(3, 3).T
            if entries is not None:
                row = particle % tile
                for slot in range(min(max(int(rows[row]), 0), entries.shape[0])):
                    entry = entries[slot, row]
                    column = int(entry['col'])
                    if column < 0 or column >= tile:
                        continue
                    target = particle-row+column
                    for j, other in enumerate(ids):
                        if target == other:
                            region = np.s_[i*3:i*3+3, j*3:j*3+3]
                            value = entry['value']
                            if np.ndim(value) == 0:
                                block = matrix[region]
                                for axis in range(3):
                                    block[axis, axis] = F(block[axis, axis]+value)
                            else:
                                matrix[region] = (matrix[region]+value.reshape(3, 3).T).astype(F)
        if F(alpha) > 0:
            r = rotation[body].reshape(3, 3).T
            factor = F(F(F(weight[local])*F(alpha))*F(0.5))
            for j in range(3):
                for k in range(3):
                    for a in range(3):
                        for b in range(3):
                            value = F(r[a, k]*r[b, j])
                            if j == k:
                                if a == b == 2:
                                    # SASS contracts the initial product into the first add; the x square
                                    # stays rounded. The following y/z squares are both fused additions.
                                    value = fma(r[2, k], r[2, j], F(r[2, 0]*r[2, 0]))
                                    value = fma(r[2, 1], r[2, 1], value)
                                    value = fma(r[2, 2], r[2, 2], value)
                                else:
                                    for c in range(3):
                                        value = fma(r[a, c], r[b, c], value)
                            row, col = 3+3*j+a, 3+3*k+b
                            matrix[row, col] = fma(factor, value, matrix[row, col])
        if cable_offsets is not None:
            for at in range(int(cable_offsets[local]), int(cable_offsets[local+1])):
                c = int(cable_ids[at])+world*cables['per_world']
                lc = c % cables['per_world']
                if cables.get('active') is not None and cables['active'][lc] == 0:
                    continue
                linear, angular = np.zeros((3, 12), F), np.zeros((3, 12), F)
                for node in range(int(cables['count'][c])):
                    for i, p in enumerate(ids):
                        if cables['indices'][c, node] == p:
                            for dst, name in ((linear, 'linear'), (angular, 'angular')):
                                dst[:, 3*i:3*i+3] = (cables[name][c, node].reshape(3, 3).T+
                                                      dst[:, 3*i:3*i+3]).astype(F)
                penalty = cables['base'][lc] if cables.get('penalty') is None else cables['penalty'][c]
                stiff = fma(cables['damping'][lc], F(inv_dt), penalty)
                lin = stiff[[1, 1, 0]]
                ang = stiff[[2, 2, 3]].copy()
                if cables.get('bias') is not None:
                    ang = (ang+cables['bias'][c]).astype(F)
                for i in range(12):
                    for j in range(12):
                        for axis in range(3):
                            term = fma(F(lin[axis]*linear[axis, i]), linear[axis, j],
                                       F(F(ang[axis]*angular[axis, i])*angular[axis, j]))
                            matrix[i, j] = F(matrix[i, j]+term)
        if matrices is not None:
            matrices[body] = matrix
        valid[body] = int(invert(matrix, active, output[body].reshape(12, 12)))
