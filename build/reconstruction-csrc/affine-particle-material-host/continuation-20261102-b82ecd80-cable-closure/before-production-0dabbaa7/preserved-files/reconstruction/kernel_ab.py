"""Bit-for-bit A/B of reconstructed kernels against the legacy library's own PTX.

The legacy _core.so only embeds sm_52 PTX/cubins, so on newer GPUs the driver JIT-compiles that PTX at run
time. Loading the same PTX through the CUDA driver API therefore executes the original arithmetic without
the solver host code or authentication. Inputs are random but steered so that every reconstructed branch
is exercised; each contact/element writes a distinct particle so atomic accumulation order cannot matter.

Usage: .venv/bin/python -m reconstruction.kernel_ab [--seed N] [--count N]
"""
import argparse
import ctypes
import hashlib
import os
import json
import re
import struct
import subprocess
import sys
from pathlib import Path

import numpy as np

from . import affine, cables, cloth, drag, hard_contacts, rigid_contact, rolling_contact, fluid, granular, lbvh, pcg, selfcollision, springs
from .contact import SPHERE, SoftContactInputs, soft_contact_kernel
from .contact import multiply_soft_contact_hessian_off_diagonal as soft_contact_offdiag
from .numerics import (F, atomic_add_at, tetrahedron_force_ptx, tetrahedron_preconditioner_ptx,
                       tetrahedron_tangent_ptx)

ROOT = Path(__file__).resolve().parents[1]
LEGACY = ROOT/'reconstruction/references/legacy-4c223854/_core.cpython-312-x86_64-linux-gnu.so'
LEGACY_SHA = '4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6'


# RECONSTRUCTION_KERNELS=csrc runs every kernel that reconstruction/csrc already provides from our compiled PTX instead
# of the legacy PTX. The suite compares against the numpy spec, which is bitwise-checked against the legacy kernels,
# so a pass means the compiled source matches the legacy binary on this GPU. Kernels not ported yet stay legacy.
# Kept in csrc.ptx_compare so diagnostics modules that import this file (a second module instance when it runs
# as __main__) record into the same set.
from .csrc.ptx_compare import CSRC_ENTRIES_USED  # noqa: E402


def _csrc_modules():
    if not hasattr(_csrc_modules, 'cache'):
        from .csrc import ptx_compare
        modules = []
        for source in sorted((ptx_compare.CSRC/'kernels').glob('*.cu')):
            modules.append(ptx_compare.compile_ptx(source, ptx_compare.DEFAULT_NVCC))
        _csrc_modules.cache = modules
    return _csrc_modules.cache


def legacy_ptx(kernel):
    """Extract (once) the PTX modules of the legacy library and return (module text, mangled entry name)."""
    prefix = kernel if kernel.startswith('_ZN') else '_ZN7synreal6kernel' + kernel
    if os.environ.get('RECONSTRUCTION_KERNELS') == 'csrc':
        for text in _csrc_modules():
            match = re.search(r'\.entry (' + prefix + r'\w*)\(', text)
            if match:
                CSRC_ENTRIES_USED.add(match.group(1))
                return text, match.group(1)
    digest = hashlib.sha256(LEGACY.read_bytes()).hexdigest()
    if digest != LEGACY_SHA:
        raise RuntimeError(f'Unexpected legacy library hash {digest}')
    out = ROOT/'build/reconstruction-ptx'/digest[:16]
    if not any(out.glob('*.ptx')):
        out.mkdir(parents=True, exist_ok=True)
        subprocess.run(['cuobjdump', '-xptx', 'all', str(LEGACY)], cwd=out, check=True, stdout=subprocess.DEVNULL)
    for path in sorted(out.glob('*.ptx')):
        text = path.read_text()
        prefix = kernel if kernel.startswith('_ZN') else '_ZN7synreal6kernel' + kernel
        match = re.search(r'\.entry (' + prefix + r'\w*)\(', text)
        if match:
            return text, match.group(1)
    raise LookupError(kernel)


class Driver:
    """Minimal CUDA driver API wrapper (no Warp/PyTorch context involved)."""
    def __init__(self):
        self.cu = ctypes.CDLL('libcuda.so.1')
        self.check(self.cu.cuInit(0))
        device = ctypes.c_int()
        self.check(self.cu.cuDeviceGet(ctypes.byref(device), 0))
        self.context = ctypes.c_void_p()
        self.check(self.cu.cuDevicePrimaryCtxRetain(ctypes.byref(self.context), device))
        self.check(self.cu.cuCtxSetCurrent(self.context))
        self.allocations = []

    def check(self, status):
        if status:
            name = ctypes.c_char_p()
            self.cu.cuGetErrorName(status, ctypes.byref(name))
            raise RuntimeError(f'CUDA driver error {status}: {name.value}')

    def function(self, ptx, name):
        module = ctypes.c_void_p()
        self.check(self.cu.cuModuleLoadDataEx(ctypes.byref(module), ctypes.c_char_p(ptx.encode()+b'\0'), 0, None, None))
        function = ctypes.c_void_p()
        self.check(self.cu.cuModuleGetFunction(ctypes.byref(function), module, name.encode()))
        return function

    def upload(self, array):
        array = np.ascontiguousarray(array)
        pointer = ctypes.c_uint64()
        self.check(self.cu.cuMemAlloc_v2(ctypes.byref(pointer), ctypes.c_size_t(max(array.nbytes, 4))))
        self.check(self.cu.cuMemcpyHtoD_v2(pointer, array.ctypes.data_as(ctypes.c_void_p), ctypes.c_size_t(array.nbytes)))
        self.allocations.append(pointer)
        return pointer

    def download(self, pointer, like):
        result = np.empty_like(like)
        self.check(self.cu.cuMemcpyDtoH_v2(result.ctypes.data_as(ctypes.c_void_p), pointer, ctypes.c_size_t(result.nbytes)))
        return result

    def launch(self, function, threads, params, block=256):
        # Solver launches use 256 threads (the *_and_reduce kernels depend on it); the fluid module uses 128.
        holders = (ctypes.c_void_p*len(params))(*[ctypes.cast(ctypes.byref(p), ctypes.c_void_p) for p in params])
        grid = max(1, (threads+block-1)//block)
        self.check(self.cu.cuLaunchKernel(function, grid, 1, 1, block, 1, 1, 0, None, holders, None))
        self.check(self.cu.cuCtxSynchronize())

    def free(self):
        for pointer in self.allocations:
            self.cu.cuMemFree_v2(pointer)
        self.allocations.clear()


def u64(value):
    return ctypes.c_uint64(int(value))


def f32(value):
    return ctypes.c_float(float(value))


def null():
    return ctypes.c_uint64(0)


def compare(name, reference, actual):
    reference, actual = np.asarray(reference), np.asarray(actual)
    same = (reference.view(np.uint32) == actual.view(np.uint32))
    return {'bitwise_equal': bool(same.all()), 'mismatches': int((~same).sum()), 'elements': int(same.size),
            'max_abs_diff': float(np.abs(reference.astype(np.float64)-actual.astype(np.float64)).max()),
            'nonzero_outputs': int(np.count_nonzero(reference))}


def soft_contact_case(rng, count):
    """Random contacts, one per particle and per shape, covering plane/box/sphere and every force branch.

    Geometry is generated per contact and then scattered to a permuted particle index, so the kernel's
    particle and shape indirections are exercised.
    """
    n = count
    shape_type = rng.choice([1, 7, SPHERE], size=n).astype(np.int32)
    raw_normal = rng.normal(size=(n, 3)).astype(F)*rng.uniform(0.2, 3, size=(n, 1)).astype(F)
    raw_normal[rng.random(n) < 0.03] = 0  # zero normals are rejected by the kernel
    unit = raw_normal/np.maximum(np.linalg.norm(raw_normal, axis=1, keepdims=True), 1e-12)
    radius = rng.uniform(0.01, 0.1, n).astype(F)
    margin = np.where(rng.random(n) < 0.5, 0, rng.uniform(0, 0.02, n)).astype(F)
    sphere_radius = rng.uniform(0.2, 1.0, n).astype(F)
    gap = rng.uniform(-0.08, 0.06, n)  # signed surface gap; negative means penetration
    x = rng.uniform(-3, 3, size=(n, 3)).astype(F)
    centre = (x-unit*(sphere_radius+radius+gap)[:, None]).astype(F)
    degenerate = rng.random(n) < 0.02  # centre at the particle: kernel falls back to the contact normal
    centre[degenerate] = x[degenerate]
    body_pos = (x-unit*(radius+gap)[:, None]).astype(F)
    velocity = rng.normal(scale=2, size=(n, 3)).astype(F)
    velocity[rng.random(n) < 0.3] *= F(1e-4)  # nearly static: friction capped by kf
    separating = rng.random(n) < 0.1  # fast separation: zero normal force
    velocity[separating] += (unit[separating]*40).astype(F)
    dt = F(1/400)
    previous = (x-velocity*dt).astype(F)
    mass = rng.uniform(0.01, 2, n).astype(F)
    mass[rng.random(n) < 0.03] = 0
    flags = (rng.random(n) < 0.03).astype(np.int32)
    particle = rng.permutation(n).astype(np.int32)
    def scatter(values):
        out = np.empty_like(values)
        out[particle] = values
        return out
    transform = np.zeros((n, 7), F)
    transform[:, :3] = centre
    transform[:, 6] = 1
    scale = np.zeros((n, 3), F)
    scale[:, 0] = sphere_radius
    materials = [rng.uniform(lo, hi, n).astype(F) for lo, hi in ((1e3, 1e5), (0, 50), (1, 2e3), (0, 1))]
    inputs = SoftContactInputs(
        count=n, particle=particle, shape=np.arange(n, dtype=np.int32),
        body_pos=body_pos, body_vel=rng.normal(scale=0.5, size=(n, 3)).astype(F), normal=raw_normal,
        radius=scatter(radius), mass=scatter(mass), shape_body=np.full(n, -1, np.int32), shape_type=shape_type,
        shape_position=centre, shape_scale=scale, shape_margin=margin, shape_ke=materials[0],
        shape_kd=materials[1], shape_kf=materials[2], shape_mu=materials[3], ke=5e4, kd=30.0, kf=1e3, mu=0.6,
        x=scatter(x), previous=scatter(previous), inv_dt=F(1)/dt, particle_flags=scatter(flags))
    return inputs, transform, scatter(velocity)


def run_soft_contact(driver, rng, count):
    ptx, name = legacy_ptx('27evaluate_soft_contact_force')
    function = driver.function(ptx, name)
    c, transform, velocity = soft_contact_case(rng, count)
    n = len(c.x)
    force0, scalar0, block0 = np.zeros((n, 3), F), np.zeros(n, F), np.zeros((n, 3, 3), F)
    d = driver
    buffers = dict(force=d.upload(force0), scalar=d.upload(scalar0), block=d.upload(block0), block2=d.upload(block0))
    params = [
        d.upload(np.array([c.count], np.int32)), u64(c.count), d.upload(c.particle), d.upload(c.shape),
        d.upload(c.body_pos), d.upload(c.body_vel), d.upload(c.normal), d.upload(c.radius), d.upload(c.mass),
        d.upload(c.particle_flags), u64(n), u64(n), d.upload(c.shape_body), d.upload(c.shape_type),
        d.upload(transform), d.upload(c.shape_scale), d.upload(c.shape_margin), d.upload(c.shape_ke),
        d.upload(c.shape_kd), d.upload(c.shape_kf), d.upload(c.shape_mu), u64(n), u64(n), u64(1),
        f32(c.ke), f32(c.kd), f32(c.kf), f32(c.mu), null(), null(), null(), u64(0),
        d.upload(c.x), d.upload(velocity), d.upload(c.previous), f32(c.inv_dt),
        buffers['force'], buffers['scalar'], null(), u64(0), buffers['block'], buffers['block2']]
    d.launch(function, c.count, params)
    native = [d.download(buffers[k], v) for k, v in (('force', force0), ('scalar', scalar0), ('block', block0))]
    second = d.download(buffers['block2'], block0)
    source = soft_contact_kernel(c)
    report = {key: compare(key, a, b) for key, a, b in zip(('force', 'scalar', 'block'), native, source)}
    report['block_copy_equal'] = bool(np.array_equal(native[2].view(np.uint32), second.view(np.uint32)))
    report['coverage'] = soft_contact_coverage(c, native)
    return report


def soft_contact_coverage(c, native):
    """Count how many active contacts hit each branch, judged from the original's own outputs."""
    force, scalar, block = native
    p = c.particle
    active = scalar[p] != 0
    sphere = c.shape_type == SPHERE
    n_force = np.einsum('ij,ij->i', force[p], np.nan_to_num(c.normal/np.linalg.norm(c.normal, axis=1, keepdims=True)))
    tangent = force[p]-n_force[:, None]*np.nan_to_num(c.normal/np.linalg.norm(c.normal, axis=1, keepdims=True))
    sliding = np.linalg.norm(tangent, axis=1) > 0
    return {'contacts': int(c.count), 'active': int(active.sum()), 'active_sphere': int((active & sphere).sum()),
            'active_non_sphere': int((active & ~sphere).sum()),
            'zero_normal_force': int((active & (np.abs(force[p]).sum(axis=1) == 0)).sum()),
            'with_friction': int((active & sliding).sum()),
            'skipped_mass_or_flag': int(((c.mass[p] <= 0) | (c.particle_flags[p] != 0)).sum())}


def tetrahedron_case(rng, count):
    """Random tetrahedra on disjoint vertices (no atomic races), mixing damped/undamped and activated elements."""
    n = count*4
    indices = rng.permutation(n).astype(np.int32).reshape(count, 4)
    rest = rng.normal(size=(count, 3, 3)).astype(F)
    rest += np.eye(3, dtype=F)*F(1.5)
    inverse = np.linalg.inv(rest).astype(F)
    x = rng.normal(size=(n, 3)).astype(F)
    previous = (x+rng.normal(scale=0.01, size=(n, 3))).astype(F)
    direction = rng.normal(size=(n, 3)).astype(F)
    materials = np.stack((rng.uniform(0, 5e4, count), rng.uniform(0, 5e4, count), rng.uniform(0, 20, count)), 1)
    materials = materials.astype(F)
    materials[rng.random(count) < 0.2, 2] = 0   # undamped elements
    materials[rng.random(count) < 0.05, :2] = 0  # zero bulk modulus
    volume = rng.uniform(1e-4, 1e-2, count).astype(F)
    activation = np.where(rng.random(count) < 0.5, 0, rng.uniform(-0.2, 0.2, count)).astype(F)
    return dict(indices=indices, inverse=inverse, x=x, previous=previous, direction=direction, materials=materials,
                volume=volume, activation=activation, inv_dt=F(1)/F(1/400))


def tetrahedron_coverage(t):
    return {'elements': len(t['indices']), 'damped': int((t['materials'][:, 2] > 0).sum()),
            'activated': int((t['activation'] != 0).sum())}


def run_tetrahedron(driver, rng, count):
    ptx, name = legacy_ptx('26evaluate_tetrahedron_force')
    function = driver.function(ptx, name)
    t = tetrahedron_case(rng, count)
    n = len(t['x'])
    force0 = np.zeros((n, 3), F)
    d = driver
    out = d.upload(force0)
    params = [d.upload(t['x']), d.upload(t['previous']), d.upload(t['indices']), d.upload(t['inverse']),
              d.upload(t['materials']), d.upload(t['volume']), d.upload(t['activation']), f32(t['inv_dt']), out,
              u64(count), u64(count), u64(0)]
    d.launch(function, count, params)
    native = d.download(out, force0)
    source = np.zeros_like(force0)
    local = tetrahedron_force_ptx(t['x'], t['previous'], t['indices'], t['inverse'], t['volume'], t['materials'],
                                  t['activation'], t['inv_dt'])
    atomic_add_at(source, t['indices'].reshape(-1), local.reshape(-1, 3))
    return {'force': compare('force', native, source), 'coverage': tetrahedron_coverage(t)}


def run_tetrahedron_tangent(driver, rng, count):
    ptx, name = legacy_ptx('28multiply_tetrahedron_tangent')
    function = driver.function(ptx, name)
    t = tetrahedron_case(rng, count)
    n = len(t['x'])
    zero = np.zeros((n, 3), F)
    d = driver
    out = d.upload(zero)
    params = [d.upload(t['x']), d.upload(t['direction']), d.upload(t['indices']), d.upload(t['inverse']),
              d.upload(t['materials']), d.upload(t['volume']), f32(t['inv_dt']), out, u64(count), u64(count), u64(0)]
    d.launch(function, count, params)
    native = d.download(out, zero)
    source = np.zeros_like(zero)
    local = tetrahedron_tangent_ptx(t['x'], t['direction'], t['indices'], t['inverse'], t['materials'], t['volume'],
                                    t['inv_dt'])
    atomic_add_at(source, t['indices'].reshape(-1), local.reshape(-1, 3))
    return {'product': compare('product', native, source), 'coverage': tetrahedron_coverage(t)}


def run_tetrahedron_preconditioner(driver, rng, count):
    ptx, name = legacy_ptx('30add_tetrahedron_preconditioner')
    function = driver.function(ptx, name)
    t = tetrahedron_case(rng, count)
    n = len(t['x'])
    zero = np.zeros((n, 3, 3), F)
    d = driver
    out = d.upload(zero)
    params = [d.upload(t['x']), d.upload(t['indices']), d.upload(t['inverse']), d.upload(t['materials']),
              d.upload(t['volume']), f32(t['inv_dt']), out, u64(count), u64(count), u64(0)]
    d.launch(function, count, params)
    native = d.download(out, zero)
    source = np.zeros_like(zero)
    local = tetrahedron_preconditioner_ptx(t['x'], t['indices'], t['inverse'], t['materials'], t['volume'], t['inv_dt'])
    atomic_add_at(source, t['indices'].reshape(-1), local.reshape(-1, 3, 3))
    return {'block': compare('block', native, source), 'coverage': tetrahedron_coverage(t)}


CUB_SUM = ('_ZN3cub17CUB_200302_520_NS28DeviceReduceSingleTileKernelINS0_18DeviceReducePolicyIfjN4cuda3std3__44plusIvEEE'
           '9Policy600EPKfPfjS7_ffEEvT0_T1_T2_T3_T4_')


CUB_REDUCE = ('_ZN3cub17CUB_200302_520_NS18DeviceReduceKernelINS0_18DeviceReducePolicyIfjN4cuda3std3__44plusIvEEE'
              '9Policy600EPKfjS7_fEEvT0_PT3_T1_NS0_13GridEvenShareISF_EET2_')


class Empty(ctypes.Structure):
    _fields_ = [('pad', ctypes.c_uint8)]


class GridEvenShare(ctypes.Structure):
    """cub::GridEvenShare<unsigned> as filled by DispatchInit (block_* fields are reset by BlockInit)."""
    _fields_ = [('total_tiles', ctypes.c_int32), ('big_shares', ctypes.c_int32), ('big_share_items', ctypes.c_uint32),
                ('normal_share_items', ctypes.c_uint32), ('normal_base_offset', ctypes.c_uint32),
                ('num_items', ctypes.c_uint32), ('grid_size', ctypes.c_int32), ('block_offset', ctypes.c_uint32),
                ('block_end', ctypes.c_uint32), ('block_stride', ctypes.c_uint32)]


def run_pcg(driver, rng, count):
    """A/B of every PCG-path kernel launched per Newton iteration, on multi-block sizes."""
    d = driver
    n = count
    report = {}
    def kernel(name):
        return d.function(*legacy_ptx(name))
    def vec(scale=1.0):
        return (rng.normal(size=(n, 3))*scale).astype(F)
    def sym_blocks():
        b = rng.normal(size=(n, 3, 3)).astype(F)
        b = (b @ b.transpose(0, 2, 1)+np.eye(3, dtype=F)*F(0.1)).astype(F)
        b[rng.random(n) < 0.05] *= F(-1)              # negative determinant: diagonal fallback
        b[rng.random(n) < 0.05, :, 2] = 0              # singular blocks
        b += (rng.normal(size=(n, 3, 3))*1e-3).astype(F)  # slight asymmetry: kernel symmetrizes
        return b.transpose(0, 2, 1).reshape(n, 9).astype(F)  # glm column-major

    # cub single-tile sum over block partials of assorted lengths.
    cub = kernel(CUB_SUM)
    lengths = [1, 7, 32, 33, 255, 256, 257, 1000, 4095]
    mism = 0
    for length in lengths:
        items = (rng.normal(size=length)*10.0**rng.uniform(-3, 3, length)).astype(F)
        out = d.upload(np.zeros(1, F))
        d.launch(cub, 1, [d.upload(items), out, ctypes.c_uint32(length), Empty(), f32(0)])
        mism += int(d.download(out, np.zeros(1, F)).view(np.uint32)[0] != np.float32(pcg.cub_sum(items)).view(np.uint32))
    report['cub_single_tile_sum'] = {'bitwise_equal': mism == 0, 'mismatches': mism, 'elements': len(lengths)}

    # Full tiles: the single-tile kernel consuming several (vector-loaded) tiles in one block, and the two-pass
    # DeviceReduceKernel (one block per tile, strip-mine mapping) + single-tile pass that cub uses above 5120 items.
    multi = kernel(CUB_REDUCE)
    mism_single = mism_multi = 0
    long_lengths = [4096, 5119, 5120, 5121, 5375, 6007, 10240, 10241, 15377, 60000]
    for length in long_lengths:
        items = (rng.normal(size=length)*10.0**rng.uniform(-3, 3, length)).astype(F)
        init = F(rng.normal())
        in_buf, out = d.upload(items), d.upload(np.zeros(1, F))
        d.launch(cub, 1, [in_buf, out, ctypes.c_uint32(length), Empty(), f32(init)])
        single = d.download(out, np.zeros(1, F))[0]
        mism_single += int(F(single).view(np.uint32) != F(F(init)+pcg._consume_range(items, 0, length)).view(np.uint32))
        tiles = -(-length//pcg.TILE)
        # The strip-mine kernel reads only num_items and grid_size; the rest mirrors DispatchInit.
        share = GridEvenShare(tiles, 0, 2*pcg.TILE, pcg.TILE, 0, length, tiles, length, length, 0)
        partial_buf = d.upload(np.zeros(tiles, F))
        d.launch(multi, tiles*pcg.BLOCK, [in_buf, partial_buf, ctypes.c_uint32(length), share, Empty()])
        out = d.upload(np.zeros(1, F))
        d.launch(cub, 1, [partial_buf, out, ctypes.c_uint32(tiles), Empty(), f32(init)])
        total = d.download(out, np.zeros(1, F))[0]
        mism_multi += int(F(total).view(np.uint32) != F(pcg.cub_sum(items, init)).view(np.uint32))
    report['cub_single_tile_multi_tile_sum'] = {'bitwise_equal': mism_single == 0, 'mismatches': mism_single,
                                               'elements': len(long_lengths)}
    report['cub_two_pass_sum'] = {'bitwise_equal': mism_multi == 0, 'mismatches': mism_multi,
                                  'elements': len(long_lengths)}

    blocks = -(-n//256)
    partial0 = np.zeros(blocks, F)

    # initialize_rhs without non-diagonal mass entries.
    x, target, base = vec(), vec(), vec()
    mass = rng.uniform(-0.1, 2, n).astype(F)
    mask = rng.integers(0, 4, n).astype(np.int32)
    out = d.upload(np.zeros((n, 3), F))
    scale = F(1)/(F(1/400)*F(1/400))
    d.launch(kernel('14initialize_rhs'), n, [f32(scale), d.upload(x), d.upload(target), d.upload(mass), null(), null(),
                                              u64(0), d.upload(base), d.upload(mask), out, u64(n), u64(n)])
    report['initialize_rhs'] = compare('rhs', d.download(out, x), pcg.initialize_rhs(scale, x, target, mass, base, mask))
    # initialize_rhs with off-diagonal mass rows (scalar ELL, slot-major [max_nnz, n]); columns include
    # out-of-range values that the kernel must skip.
    slots = 5
    row_count = rng.integers(-1, slots+2, n).astype(np.int32)
    ell = np.zeros((slots, n), dtype=np.dtype([('col', np.int32), ('value', F)]))
    ell['col'] = rng.integers(-2, n+2, (slots, n))
    ell['value'] = rng.normal(size=(slots, n)).astype(F)
    out = d.upload(np.zeros((n, 3), F))
    d.launch(kernel('14initialize_rhs'), n, [f32(scale), d.upload(x), d.upload(target), d.upload(mass),
                                              d.upload(row_count), d.upload(ell), u64(slots), d.upload(base),
                                              d.upload(mask), out, u64(n), u64(n)])
    report['initialize_rhs_mass_ell'] = compare('rhs', d.download(out, x), pcg.initialize_rhs(
        scale, x, target, mass, base, mask, (row_count, ell['col'], ell['value'], slots)))

    # initialize_block_diagonal into both system and preconditioner blocks.
    a = rng.normal(size=n).astype(F)
    out_a, out_b = d.upload(np.zeros((n, 9), F)), d.upload(np.zeros((n, 9), F))
    d.launch(kernel('25initialize_block_diagonal'), n, [d.upload(a), out_a, out_b, u64(n)])
    expected = pcg.initialize_block_diagonal(a)
    report['initialize_block_diagonal'] = compare('A', d.download(out_a, expected), expected)
    report['initialize_block_diagonal']['copy_equal'] = bool(
        np.array_equal(d.download(out_b, expected), d.download(out_a, expected)))

    # invert_block_preconditioner with scale/mask gating.
    blocks_m = sym_blocks()
    scale_v = np.where(rng.random(n) < 0.05, 0, rng.uniform(0.1, 1, n)).astype(F)
    out = d.upload(np.zeros((n, 9), F))
    d.launch(kernel('27invert_block_preconditioner'), n, [d.upload(blocks_m), d.upload(scale_v), d.upload(mask), out,
                                                           u64(n), u64(n)])
    expected = pcg.invert_block_preconditioner(blocks_m, scale_v, mask)
    report['invert_block_preconditioner'] = compare('inverse', d.download(out, expected), expected)

    preconditioner = sym_blocks()
    rhs = vec()
    r_out, x_out, part = d.upload(np.zeros((n, 3), F)), d.upload(vec()), d.upload(partial0)
    d.launch(kernel('35initialize_zero_solution_and_reduceILj256EN3glm'), n,
             [d.upload(rhs), d.upload(preconditioner), r_out, x_out, part, u64(n)])
    r_exp, x_exp, p_exp = pcg.initialize_zero_solution_and_reduce(rhs, preconditioner)
    report['initialize_zero_solution_and_reduce'] = compare('partials', d.download(part, partial0), p_exp)
    report['initialize_zero_solution_and_reduce']['vectors_equal'] = bool(
        np.array_equal(d.download(r_out, rhs), r_exp) and np.array_equal(d.download(x_out, rhs), x_exp))

    residual, direction = vec(), vec()
    num = (rng.uniform(0.1, 10, 9)).astype(F)
    for k in (0, 3):
        p_buf = d.upload(direction)
        d.launch(kernel('19update_cg_directionIN3glm'), n,
                 [ctypes.c_int32(k), d.upload(preconditioner), d.upload(residual), d.upload(num), p_buf, u64(n)])
        report[f'update_cg_direction_k{k}'] = compare('p', d.download(p_buf, direction),
                                                       pcg.update_cg_direction(k, preconditioner, residual, num, direction))

    diagonal, extra = sym_blocks(), vec()
    ap_buf, part = d.upload(np.zeros((n, 3), F)), d.upload(partial0)
    d.launch(kernel('26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntry'), n,
             [null(), null(), u64(0), d.upload(diagonal), d.upload(direction), d.upload(extra), ap_buf, part, u64(n),
              u64(n)])
    ap_exp, part_exp = pcg.multiply_matrix_and_reduce(diagonal, direction, extra)
    report['multiply_matrix_and_reduce'] = compare('Ap', d.download(ap_buf, ap_exp), ap_exp)
    report['multiply_matrix_and_reduce']['partials'] = compare('partials', d.download(part, partial0), part_exp)

    # Same kernel with block-ELL off-diagonal entries (some rows clamped by max_nnz, some invalid columns).
    max_nnz = 5
    row_nnz = rng.integers(0, max_nnz+3, n).astype(np.int32)
    cols = rng.integers(-1, n+2, (max_nnz, n)).astype(np.int32)
    blocks_ell = rng.normal(size=(max_nnz, n, 9)).astype(F)
    entries = np.zeros(max_nnz*n, np.dtype([('col', '<i4'), ('m', '<f4', (9,))]))
    entries['col'] = cols.reshape(-1)
    entries['m'] = blocks_ell.reshape(-1, 9)
    ap_buf, part = d.upload(np.zeros((n, 3), F)), d.upload(partial0)
    d.launch(kernel('26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntry'), n,
             [d.upload(row_nnz), d.upload(entries), u64(max_nnz), d.upload(diagonal), d.upload(direction),
              d.upload(extra), ap_buf, part, u64(n), u64(n)])
    ap_exp, part_exp = pcg.multiply_matrix_and_reduce(diagonal, direction, extra, (row_nnz, cols, blocks_ell, max_nnz))
    report['multiply_matrix_and_reduce_ell'] = compare('Ap', d.download(ap_buf, ap_exp), ap_exp)
    report['multiply_matrix_and_reduce_ell']['partials'] = compare('partials', d.download(part, partial0), part_exp)

    den = (rng.uniform(0.1, 10, 9)).astype(F)
    solution = vec()
    sol_buf, res_buf, part = d.upload(solution), d.upload(residual), d.upload(partial0)
    d.launch(kernel('35update_solution_residual_and_reduceILj256EN3glm'), n,
             [ctypes.c_int32(2), d.upload(num), d.upload(den), d.upload(direction), d.upload(extra),
              d.upload(preconditioner), sol_buf, res_buf, part, ctypes.c_uint8(1), u64(n)])
    s_exp, r_exp, p_exp = pcg.update_solution_residual_and_reduce(2, num, den, direction, extra, preconditioner,
                                                                    solution, residual)
    report['update_solution_residual_and_reduce'] = compare('partials', d.download(part, partial0), p_exp)
    report['update_solution_residual_and_reduce']['vectors_equal'] = bool(
        np.array_equal(d.download(sol_buf, solution).view(np.uint32), s_exp.view(np.uint32))
        and np.array_equal(d.download(res_buf, residual).view(np.uint32), r_exp.view(np.uint32)))
    # The final host-scheduled PCG update disables reduction and leaves its output buffer untouched.
    sentinel = np.arange(blocks, dtype=F)+F(0.75)
    sol_buf, res_buf, part = d.upload(solution), d.upload(residual), d.upload(sentinel)
    d.launch(kernel('35update_solution_residual_and_reduceILj256EN3glm'), n,
             [ctypes.c_int32(2), d.upload(num), d.upload(den), d.upload(direction), d.upload(extra),
              d.upload(preconditioner), sol_buf, res_buf, part, ctypes.c_uint8(0), u64(n)])
    report['update_without_reduction_solution'] = compare('solution', d.download(sol_buf, solution), s_exp)
    report['update_without_reduction_residual'] = compare('residual', d.download(res_buf, residual), r_exp)
    report['update_without_reduction_preserves_buffer'] = compare('partial', d.download(part, sentinel), sentinel)
    # PD_NEWTON kernels: multiply_matrix (mat3 and float diagonal), and the scalar-preconditioner path.
    entry_t = np.dtype([('col', '<i4'), ('v', '<f4')])
    max_nnz = 7
    row_nnz = rng.integers(-1, max_nnz+3, n).astype(np.int32)
    cols = rng.integers(-2, n+2, (max_nnz, n)).astype(np.int32)
    vals = rng.normal(size=(max_nnz, n)).astype(F)
    ell = np.zeros(max_nnz*n, entry_t)
    ell['col'], ell['v'] = cols.reshape(-1), vals.reshape(-1)
    scalar_diag = rng.uniform(-2, 5, n).astype(F)
    for label, diag_arr, name in (('mat3', preconditioner, '15multiply_matrixINS_12NonZeroEntryEN3glm3mat'),
                                  ('float', scalar_diag, '15multiply_matrixINS_12NonZeroEntryEfEE')):
        out_buf = d.upload(np.zeros((n, 3), F))
        d.launch(kernel(name), n, [d.upload(row_nnz), d.upload(ell), u64(max_nnz), d.upload(diag_arr),
                                   d.upload(direction), d.upload(extra), out_buf, u64(n), u64(n)])
        if label == 'mat3':
            exp = pcg.multiply_matrix(diag_arr, direction, extra, (row_nnz, cols, vals, max_nnz))
        else:
            off = pcg.scalar_ell_product(row_nnz, cols, vals, max_nnz, direction)
            exp = (((scalar_diag[:, None]*direction).astype(F)+off).astype(F)+extra).astype(F)
        report[f'multiply_matrix_{label}'] = compare('Ap', d.download(out_buf, exp), exp)
    mass_s = rng.uniform(-0.5, 2, n).astype(F)
    flags_s = rng.integers(0, 4, n).astype(np.int32)
    inv_buf = d.upload(np.full(n, F(7)))
    d.launch(kernel('30prepare_inverse_preconditioner'), n,
             [d.upload(scalar_diag), d.upload(mass_s), d.upload(flags_s), inv_buf, u64(n), u64(n)])
    report['prepare_inverse_preconditioner'] = compare(
        'i', d.download(inv_buf, scalar_diag), pcg.prepare_inverse_preconditioner(scalar_diag, mass_s, flags_s))
    z_buf = d.upload(np.zeros((n, 3), F))
    d.launch(kernel('35apply_block_diagonal_preconditioner'), n,
             [d.upload(preconditioner), d.upload(residual), z_buf, u64(n)])
    z = pcg.apply_block_diagonal_preconditioner(preconditioner, residual)
    report['apply_block_diagonal_preconditioner'] = compare('z', d.download(z_buf, z), z)
    nums = rng.uniform(0.1, 10, 6).astype(F)
    nums[2] = 0
    for k in (0, 1, 3, 4):
        p_buf = d.upload(direction)
        d.launch(kernel('34update_preconditioned_cg_direction'), n,
                 [ctypes.c_int32(k), d.upload(z), d.upload(nums), p_buf, u64(n)])
        exp = pcg.update_preconditioned_cg_direction(k, z, nums, direction)
        report[f'update_preconditioned_cg_direction_{k}'] = compare('p', d.download(p_buf, exp), exp)
    x_s, b_s = vec(), vec()
    for use_extra in (False, True):
        r_buf = d.upload(np.zeros((n, 3), F))
        d.launch(kernel('17evaluate_residualINS_12NonZeroEntryEfEE'), n,
                 [d.upload(row_nnz), d.upload(ell), u64(max_nnz), d.upload(scalar_diag), d.upload(x_s), d.upload(b_s),
                  d.upload(extra) if use_extra else null(), r_buf, u64(n), u64(n)])
        exp = pcg.evaluate_residual(row_nnz, cols, vals, max_nnz, scalar_diag, x_s, b_s, extra if use_extra else None)
        report[f'evaluate_residual_{use_extra}'] = compare('r', d.download(r_buf, exp), exp)
    return report


def run_cloth(driver, rng, count):
    """Cloth kernels on random hinges/triangles over disjoint vertices."""
    d = driver
    report = {}
    # Bending: random hinges, some invalid (duplicate/negative index, nonpositive area), mixed damping.
    m = count
    n = 4*m
    edges = rng.permutation(n).astype(np.int32).reshape(m, 4)
    edges[rng.random(m) < 0.03, 0] = -1
    dup = rng.random(m) < 0.03
    edges[dup, 1] = edges[dup, 2]
    cots = rng.uniform(-1, 3, (m, 4)).astype(F)
    area = rng.uniform(1e-3, 1e-1, m).astype(F)
    area[rng.random(m) < 0.03] = 0
    props = np.stack((rng.uniform(1e-7, 1e-3, m), np.where(rng.random(m) < 0.5, 0, rng.uniform(0, 1e-4, m))), 1).astype(F)
    x = rng.normal(size=(n, 3)).astype(F)
    x[rng.random(n) < 0.02] = 0
    previous = (x+rng.normal(scale=1e-3, size=(n, 3))).astype(F)
    inv_dt = F(1)/F(1/120)
    out = d.upload(np.zeros((n, 3), F))
    d.launch(d.function(*legacy_ptx('22evaluate_bending_force')), m,
             [d.upload(x), d.upload(previous), d.upload(area), d.upload(cots), d.upload(edges), d.upload(props),
              f32(inv_dt), out, u64(m), u64(m), u64(0)])
    local, valid = cloth.bending_force_ptx(x, previous, area, cots, edges, props, inv_dt)
    source = np.zeros((n, 3), F)
    atomic_add_at(source, np.where(valid[:, None], edges, 0).reshape(-1), local.reshape(-1, 3))
    report['evaluate_bending_force'] = compare('force', d.download(out, source), source)
    report['evaluate_bending_force']['valid_hinges'] = int(valid.sum())

    zero9 = np.zeros((n, 9), F)
    out = d.upload(zero9)
    d.launch(d.function(*legacy_ptx('34add_bending_damping_preconditioner')), m,
             [d.upload(x), d.upload(area), d.upload(cots), d.upload(edges), d.upload(props), f32(inv_dt), out,
              u64(m), u64(m), u64(0)])
    local, valid = cloth.bending_damping_preconditioner_ptx(x, area, cots, edges, props, inv_dt)
    source9 = np.zeros((n, 9), F)
    atomic_add_at(source9, np.where(valid[:, None], edges, 0).reshape(-1), local.reshape(-1, 9))
    report['add_bending_damping_preconditioner'] = compare('block', d.download(out, zero9), source9)
    report['add_bending_damping_preconditioner']['damped_hinges'] = int(valid.sum())

    direction = rng.normal(size=(n, 3)).astype(F)
    out = d.upload(np.zeros((n, 3), F))
    d.launch(d.function(*legacy_ptx('32multiply_bending_damping_tangent')), m,
             [d.upload(x), d.upload(direction), d.upload(area), d.upload(cots), d.upload(edges), d.upload(props),
              f32(inv_dt), out, u64(m), u64(m), u64(0)])
    local, valid = cloth.bending_damping_tangent_ptx(x, direction, area, cots, edges, props, inv_dt)
    source = np.zeros((n, 3), F)
    atomic_add_at(source, np.where(valid[:, None], edges, 0).reshape(-1), local.reshape(-1, 3))
    report['multiply_bending_damping_tangent'] = compare('product', d.download(out, source), source)

    # Membrane: random triangles on disjoint vertices, stretched/compressed and sheared, some degenerate.
    t = count
    n = 3*t
    triangles = rng.permutation(n).astype(np.int32).reshape(t, 3)
    poses = rng.normal(scale=10, size=(t, 4)).astype(F)
    area = rng.uniform(1e-3, 1e-2, t).astype(F)
    stiffness = np.stack((rng.uniform(1e3, 1e5, t), rng.uniform(1e3, 1e5, t), rng.uniform(1e2, 1e4, t)), 1).astype(F)
    x = rng.normal(scale=0.1, size=(n, 3)).astype(F)
    collapse = rng.random(t) < 0.02
    x[triangles[collapse, 1]] = x[triangles[collapse, 0]]
    x[triangles[collapse, 2]] = x[triangles[collapse, 0]]
    out = d.upload(np.zeros((n, 3), F))
    d.launch(d.function(*legacy_ptx('22evaluate_stretch_force')), t,
             [d.upload(x), d.upload(area), d.upload(poses), d.upload(triangles), d.upload(stiffness), out,
              u64(t), u64(t), u64(0)])
    source = np.zeros((n, 3), F)
    atomic_add_at(source, triangles.reshape(-1), cloth.stretch_force_ptx(x, area, poses, triangles, stiffness).reshape(-1, 3))
    report['evaluate_stretch_force'] = compare('force', d.download(out, source), source)

    # Membrane Gauss-Newton blocks into a block ELL whose rows hold the triangle neighbours plus random extra columns.
    entry_t = np.dtype([('col', '<i4'), ('m', '<f4', (9,))])
    max_nnz = 6
    rows = [[] for _ in range(n)]
    for tri in triangles:
        for i in range(3):
            neighbours = [int(tri[j]) for j in range(3) if j != i and rng.random() > 0.05]  # some missing: dropped
            extra = rng.choice(n, size=rng.integers(0, 3), replace=False).tolist()
            rows[tri[i]] = sorted(set(neighbours+extra)-{int(tri[i])})[:max_nnz]
    row_nnz = np.array([len(r) for r in rows], np.int32)
    row_nnz[rng.random(n) < 0.02] = max_nnz+3  # counts above max_nnz are clamped by the kernel
    entries = np.zeros(max_nnz*n, entry_t)
    entries['col'] = -1
    for r, cols in enumerate(rows):
        for k, c in enumerate(cols):
            entries[k*n+r]['col'] = c
            entries[k*n+r]['m'] = rng.normal(size=9)
    for k in range(max_nnz):
        empty = entries['col'][k*n:(k+1)*n] < 0
        entries['col'][k*n:(k+1)*n][empty] = n+1  # padding sorts after real columns
    diagonal = rng.normal(size=(n, 9)).astype(F)
    diag_buf, ent_buf = d.upload(diagonal), d.upload(entries)
    d.launch(d.function(*legacy_ptx('39add_cloth_membrane_gauss_newton_hessian')), t,
             [d.upload(x), d.upload(triangles), d.upload(poses), d.upload(area), d.upload(stiffness), diag_buf,
              d.upload(row_nnz), ent_buf, u64(max_nnz), u64(t), u64(t), u64(0), u64(n)])
    src_diag, src_entries = diagonal.copy(), entries.copy()
    blocks = cloth.membrane_gn_blocks_ptx(x, triangles, poses, area, stiffness)
    ell_cols = src_entries['col'].reshape(max_nnz, n)
    ell_blocks = src_entries['m'].reshape(max_nnz, n, 9).copy()
    cloth.scatter_membrane_gn(blocks, triangles, src_diag, row_nnz, (ell_cols, ell_blocks), max_nnz, n)
    src_entries['m'] = ell_blocks.reshape(-1, 9)
    report['add_cloth_membrane_gauss_newton_hessian'] = compare('diagonal', d.download(diag_buf, diagonal), src_diag)
    native_entries = d.download(ent_buf, entries)
    report['add_cloth_membrane_gauss_newton_hessian']['partials'] = compare('ell', native_entries['m'], src_entries['m'])
    return report


class AabbArg(ctypes.Structure):
    _fields_ = [('v', ctypes.c_float*6)]


def run_lbvh(driver, rng, count):
    """LBVH build and refit kernels on random triangle soups and edges (with duplicate Morton codes)."""
    d = driver
    report = {}
    def sc(name):
        return d.function(*legacy_ptx('_ZN7synreal21self_collision_kernel'+name))
    for label, prims in (('triangles', 3), ('edges', 4)):
        m = count
        n = 3*m
        x = rng.uniform(-1, 1, (n, 3)).astype(F)
        x[rng.random(n) < 0.3, 2] = 0  # flat regions: many equal coordinates
        x[rng.integers(0, n, n//20)] = x[0]  # repeated points produce duplicate Morton codes
        if prims == 3:
            elems = rng.integers(0, n, (m, 3)).astype(np.int32)
            build, host = sc('20build_triangle_aabbs'), lbvh.triangle_aabbs
        else:
            elems = rng.integers(-1, n, (m, 4)).astype(np.int32)
            elems[:, 2:] = rng.integers(0, n, (m, 2))
            build, host = sc('16build_edge_aabbs'), lbvh.edge_aabbs
        thickness = F(0.01)
        out = d.upload(np.zeros((m, 6), F))
        d.launch(build, m, [d.upload(x), d.upload(elems), out, f32(thickness), u64(m), u64(m), u64(0)])
        boxes = host(x, elems, thickness)
        native_boxes = d.download(out, boxes)
        report[f'{label}_aabbs'] = compare('aabbs', native_boxes, boxes)
        bounds = lbvh.centroid_bounds(boxes)
        codes_buf = d.upload(np.zeros(m, np.uint32))
        arg = AabbArg((ctypes.c_float*6)(*bounds.tolist()))
        d.launch(d.function(*legacy_ptx('21generate_morton_codes')), m, [codes_buf, d.upload(boxes), arg, ctypes.c_uint32(m)])
        codes = lbvh.morton_codes(boxes, bounds)
        native_codes = d.download(codes_buf, codes)
        report[f'{label}_morton'] = compare('codes', native_codes, codes)
        sorted_codes, order = lbvh.sort_primitives(codes)
        parent_buf = d.upload(np.full(2*m-1, -1, np.int32))
        child_buf = d.upload(np.zeros((m-1, 2), np.int32))
        d.launch(d.function(*legacy_ptx('16build_radix_tree')), m, [parent_buf, child_buf, d.upload(sorted_codes),
                                                                     ctypes.c_uint32(m)])
        parent, children = lbvh.radix_tree(sorted_codes)
        n_parent, n_children = d.download(parent_buf, parent), d.download(child_buf, children)
        same = np.array_equal(n_parent, parent) and np.array_equal(n_children, children)
        report[f'{label}_radix_tree'] = {'bitwise_equal': bool(same),
                                         'mismatches': int((n_parent != parent).sum()+(n_children != children).sum()),
                                         'elements': int(parent.size+children.size),
                                         'duplicate_codes': int(m-len(np.unique(codes)))}
        esc_buf = d.upload(np.zeros(2*m-1, np.int32))
        d.launch(d.function(*legacy_ptx('18build_escape_nodes')), 2*m-1, [esc_buf, d.upload(parent), d.upload(children),
                                                                         ctypes.c_uint32(2*m-1)])
        escape = lbvh.escape_nodes(parent, children)
        report[f'{label}_escape'] = {'bitwise_equal': bool(np.array_equal(d.download(esc_buf, escape), escape)),
                                     'mismatches': int((d.download(esc_buf, escape) != escape).sum()), 'elements': escape.size}
        leaf_buf = d.upload(np.zeros(m, np.int32))
        d.launch(d.function(*legacy_ptx('26build_primitive_leaf_nodes')), m, [leaf_buf, d.upload(order), ctypes.c_uint32(m)])
        leaf = lbvh.primitive_leaves(order)
        report[f'{label}_leaves'] = {'bitwise_equal': bool(np.array_equal(d.download(leaf_buf, leaf), leaf)),
                                     'mismatches': int((d.download(leaf_buf, leaf) != leaf).sum()), 'elements': leaf.size}
        moved = (x+rng.normal(scale=0.05, size=x.shape)).astype(F)
        boxes2 = host(moved, elems, thickness)
        nodes_buf, flags = d.upload(np.zeros((2*m-1, 6), F)), d.upload(np.zeros(2*m-1, np.uint32))
        d.launch(sc('9refit_bvh'), m, [d.upload(boxes2), d.upload(order), d.upload(parent), d.upload(children), flags,
                                       nodes_buf, u64(m), u64(m)])
        nodes = lbvh.refit(boxes2, order, parent, children)
        report[f'{label}_refit'] = compare('nodes', d.download(nodes_buf, nodes), nodes)
        # kernel::refit_aabbs: the same bottom-up refit with the node buffer first and a 32-bit count.
        nodes_buf, flags = d.upload(np.zeros((2*m-1, 6), F)), d.upload(np.zeros(2*m-1, np.uint32))
        d.launch(d.function(*legacy_ptx('11refit_aabbs')), m, [nodes_buf, d.upload(boxes2), d.upload(order),
                                                              d.upload(parent), d.upload(children), flags,
                                                              ctypes.c_uint32(m)])
        report[f'{label}_refit_aabbs'] = compare('nodes', d.download(nodes_buf, nodes), nodes)
    return report


def folded_cloth(rng, nx, ny):
    """A grid cloth folded over itself with noise, so vertex-face, edge-edge and edge-face pairs all occur."""
    u, v = np.meshgrid(np.linspace(0, 1, nx), np.linspace(0, 1, ny), indexing='ij')
    angle = np.pi*u
    x = np.stack((0.2*np.cos(angle), v, 0.2*np.sin(angle)+0.003*rng.normal(size=u.shape)), -1).reshape(-1, 3)
    x += rng.normal(scale=0.002, size=x.shape)
    idx = np.arange(nx*ny).reshape(nx, ny)
    a, b, c, d = idx[:-1, :-1].ravel(), idx[1:, :-1].ravel(), idx[:-1, 1:].ravel(), idx[1:, 1:].ravel()
    triangles = np.concatenate((np.stack((a, b, d), 1), np.stack((a, d, c), 1))).astype(np.int32)
    return x.astype(F), triangles


def unique_edges(triangles):
    """Mesh edges as (o0, o1, e0, e1) stencils (opposite vertices unused by the queries, set to -1)."""
    pairs = np.sort(np.concatenate([triangles[:, [0, 1]], triangles[:, [1, 2]], triangles[:, [2, 0]]]), axis=1)
    pairs = np.unique(pairs, axis=0)
    return np.concatenate((np.full((len(pairs), 2), -1), pairs), axis=1).astype(np.int32)


def run_self_collision(driver, rng):
    d = driver
    report = {}
    x, triangles = folded_cloth(rng, 24, 16)
    n, m = len(x), len(triangles)
    radius, extra, slots = F(0.01), F(0.01), 31
    tree = lbvh.Lbvh(lbvh.triangle_aabbs(x, triangles, 0))
    tree.refit(lbvh.triangle_aabbs(x, triangles, radius))
    vertices = np.arange(n, dtype=np.int32)
    for label, groups in (('plain', None), ('groups', rng.integers(-1, 3, n).astype(np.int32))):
        counts_buf, slots_buf = d.upload(np.zeros(n, np.int32)), d.upload(np.full(n*slots, -1, np.int32))
        d.launch(d.function(*legacy_ptx('_ZN7synreal21self_collision_kernel17query_vertex_face')), n,
                 [d.upload(x), d.upload(vertices), null(), d.upload(triangles),
                  d.upload(groups) if groups is not None else null(), d.upload(tree.nodes), d.upload(tree.parent),
                  d.upload(tree.children), d.upload(tree.order), f32(radius), f32(extra), ctypes.c_uint8(1),
                  counts_buf, slots_buf, u64(n), u64(n), u64(m), u64(n), ctypes.c_int32(slots)])
        counts, found = selfcollision.query_vertex_face(x, vertices, triangles, tree, radius, extra, True, groups, slots)
        n_counts = d.download(counts_buf, counts)
        n_slots = d.download(slots_buf, found.reshape(-1)).reshape(n, slots)
        mask = np.arange(slots)[None, :] < counts[:, None]
        same = np.array_equal(n_counts, counts) and np.array_equal(n_slots[mask], found[mask])
        report[f'query_vertex_face_{label}'] = {'bitwise_equal': bool(same), 'mismatches': int((n_counts != counts).sum()),
                                                'elements': n, 'candidates': int(counts.sum())}
    # Large radius: candidate lists saturate at max_slots, exercising the early stop.
    big = F(0.08)
    big_tree = lbvh.Lbvh(lbvh.triangle_aabbs(x, triangles, 0))
    big_tree.refit(lbvh.triangle_aabbs(x, triangles, big))
    counts_buf, slots_buf = d.upload(np.zeros(n, np.int32)), d.upload(np.full(n*slots, -1, np.int32))
    d.launch(d.function(*legacy_ptx('_ZN7synreal21self_collision_kernel17query_vertex_face')), n,
             [d.upload(x), d.upload(vertices), null(), d.upload(triangles), null(), d.upload(big_tree.nodes),
              d.upload(big_tree.parent), d.upload(big_tree.children), d.upload(big_tree.order), f32(big), f32(big),
              ctypes.c_uint8(0), counts_buf, slots_buf, u64(n), u64(n), u64(m), u64(n), ctypes.c_int32(slots)])
    counts, found = selfcollision.query_vertex_face(x, vertices, triangles, big_tree, big, big, False, None, slots)
    n_counts = d.download(counts_buf, counts)
    n_slots = d.download(slots_buf, found.reshape(-1)).reshape(n, slots)
    mask = np.arange(slots)[None, :] < counts[:, None]
    same = np.array_equal(n_counts, counts) and np.array_equal(n_slots[mask], found[mask])
    report['query_vertex_face_saturated'] = {'bitwise_equal': bool(same), 'mismatches': int((n_counts != counts).sum()),
                                             'elements': n, 'saturated': int((counts == slots).sum())}
    edges = unique_edges(triangles)
    e = len(edges)
    edge_tree = lbvh.Lbvh(lbvh.edge_aabbs(x, edges, 0))
    edge_tree.refit(lbvh.edge_aabbs(x, edges, radius))
    for label, groups in (('plain', None), ('groups', rng.integers(-1, 3, n).astype(np.int32))):
        counts_buf, slots_buf = d.upload(np.zeros(e, np.int32)), d.upload(np.full(e*slots, -1, np.int32))
        d.launch(d.function(*legacy_ptx('_ZN7synreal21self_collision_kernel15query_edge_edge')), e,
                 [d.upload(x), d.upload(edges), d.upload(groups) if groups is not None else null(),
                  d.upload(edge_tree.nodes), d.upload(edge_tree.parent), d.upload(edge_tree.children),
                  d.upload(edge_tree.order), f32(radius), counts_buf, slots_buf, u64(e), u64(e), u64(n),
                  ctypes.c_int32(slots)])
        counts, found = selfcollision.query_edge_edge(x, edges, edge_tree, radius, groups, slots)
        n_counts = d.download(counts_buf, counts)
        n_slots = d.download(slots_buf, found.reshape(-1)).reshape(e, slots)
        mask = np.arange(slots)[None, :] < counts[:, None]
        same = np.array_equal(n_counts, counts) and np.array_equal(n_slots[mask], found[mask])
        report[f'query_edge_edge_{label}'] = {'bitwise_equal': bool(same), 'mismatches': int((n_counts != counts).sum()),
                                              'elements': e, 'candidates': int(counts.sum())}
    for label, groups in (('plain', None), ('groups', rng.integers(-1, 3, n).astype(np.int32))):
        counts_buf, slots_buf = d.upload(np.zeros(e, np.int32)), d.upload(np.full(e*slots, -1, np.int32))
        d.launch(d.function(*legacy_ptx('_ZN7synreal21self_collision_kernel15query_edge_face')), e,
                 [d.upload(x), d.upload(edges), d.upload(triangles), d.upload(groups) if groups is not None else null(),
                  d.upload(tree.nodes), d.upload(tree.parent), d.upload(tree.children), d.upload(tree.order),
                  f32(radius), counts_buf, slots_buf, u64(e), u64(e), u64(m), u64(n), ctypes.c_int32(slots)])
        counts, found = selfcollision.query_edge_face(x, edges, triangles, tree, radius, groups, slots)
        n_counts = d.download(counts_buf, counts)
        n_slots = d.download(slots_buf, found.reshape(-1)).reshape(e, slots)
        mask = np.arange(slots)[None, :] < counts[:, None]
        same = np.array_equal(n_counts, counts) and np.array_equal(n_slots[mask], found[mask])
        report[f'query_edge_face_{label}'] = {'bitwise_equal': bool(same), 'mismatches': int((n_counts != counts).sum()),
                                              'elements': e, 'candidates': int(counts.sum()),
                                              'saturated': int((counts == slots).sum())}
    return report


CONTACT_T = np.dtype([('ids', '<i4', (4,)), ('w', '<f4', (6,)), ('n', '<f4', (3,)), ('k', '<f4'), ('count', '<i4')])


def run_accumulate(driver, rng):
    """accumulate_* on disjoint stencils so that every output address receives at most one atomic contribution."""
    d = driver
    report = {}
    t = 500
    tri_x = rng.normal(size=(t, 3, 3)).astype(F)*F(0.05)+np.repeat(np.arange(t)[:, None, None], 3, 1).astype(F)
    centroid = tri_x.mean(axis=1)
    normal = np.cross(tri_x[:, 1]-tri_x[:, 0], tri_x[:, 2]-tri_x[:, 0])
    normal /= np.linalg.norm(normal, axis=1, keepdims=True)
    offset = rng.uniform(-0.012, 0.012, t)  # some beyond r + extra: skipped
    lateral = rng.normal(scale=0.02, size=(t, 3))*(rng.random(t) < 0.2)[:, None]  # some outside: skipped
    query = (centroid+normal*offset[:, None]+lateral).astype(F)
    x = np.concatenate((tri_x.reshape(-1, 3), query)).astype(F)
    n = len(x)
    triangles = np.arange(3*t, dtype=np.int32).reshape(t, 3)
    vertices = np.arange(3*t, 4*t, dtype=np.int32)
    counts = np.ones(t, np.int32)
    slots_arr = np.arange(t, dtype=np.int32)[:, None]
    mass = rng.uniform(0.01, 1, n).astype(F)
    mass[rng.random(n) < 0.05] = 0
    radius, extra, stiffness = F(0.01), F(0.0), F(0.5)
    force0, diag0 = rng.normal(size=(n, 3)).astype(F), rng.normal(size=(n, 9)).astype(F)
    f_buf, h_buf = d.upload(force0), d.upload(diag0)
    list_buf, counter = d.upload(np.zeros(t, CONTACT_T)), d.upload(np.zeros(1, np.uint32))
    d.launch(d.function(*legacy_ptx('_ZN7synreal21self_collision_kernel22accumulate_vertex_face')), t,
             [d.upload(x), d.upload(vertices), null(), d.upload(triangles), d.upload(counts), d.upload(slots_arr),
              d.upload(mass), f32(radius), f32(extra), ctypes.c_uint8(1), f32(stiffness), f_buf, h_buf, list_buf,
              counter, u64(t), u64(t), u64(n), ctypes.c_int32(1)])
    force, diag, contacts = force0.copy(), diag0.copy(), []
    selfcollision.accumulate_vertex_face(x, vertices, triangles, counts, slots_arr, mass, radius, extra, True,
                                         stiffness, force, diag, contacts)
    report['accumulate_vertex_face'] = compare('force', d.download(f_buf, force), force)
    report['accumulate_vertex_face']['partials'] = compare('diagonal', d.download(h_buf, diag), diag)
    used = int(d.download(counter, np.zeros(1, np.uint32))[0])
    native_list = np.sort(d.download(list_buf, np.zeros(t, CONTACT_T))[:used], order='ids')
    mine = np.zeros(len(contacts), CONTACT_T)
    for i, c in enumerate(contacts):
        mine[i] = ((c[0], c[1], c[2], c[3]), c[4:10], c[10:13], c[13], 4)
    mine = np.sort(mine, order='ids')
    report['accumulate_vertex_face']['copy_equal'] = bool(used == len(contacts) and native_list.tobytes() == mine.tobytes())
    report['accumulate_vertex_face']['contacts'] = used

    # Edge-edge: disjoint pairs of skew segments; some pairs flagged adjacent through the opposite-vertex CSR.
    pairs = 600
    centre = np.repeat(np.arange(pairs)[:, None], 3, 1).astype(F)
    u = rng.normal(size=(pairs, 3)); u /= np.linalg.norm(u, axis=1, keepdims=True)
    w = np.cross(u, rng.normal(size=(pairs, 3))); w /= np.linalg.norm(w, axis=1, keepdims=True)
    gap = np.cross(u, w); gap /= np.linalg.norm(gap, axis=1, keepdims=True)
    sep = rng.uniform(0, 0.025, pairs)[:, None]
    ls, lt = rng.uniform(0.02, 0.1, (pairs, 1)), rng.uniform(0.02, 0.1, (pairs, 1))
    sh_s, sh_t = rng.uniform(-1.2, 1.2, (pairs, 1)), rng.uniform(-1.2, 1.2, (pairs, 1))  # some ends: s or t clamps
    a0 = centre-u*ls*(1+sh_s*0.5); a1 = centre+u*ls*(1-sh_s*0.5)
    b0 = centre+gap*sep-w*lt*(1+sh_t*0.5); b1 = centre+gap*sep+w*lt*(1-sh_t*0.5)
    x = np.stack((a0, a1, b0, b1), 1).reshape(-1, 3).astype(F)
    n = len(x)
    edges = np.full((2*pairs, 4), -1, np.int32)
    edges[0::2, 2], edges[0::2, 3] = np.arange(pairs)*4, np.arange(pairs)*4+1
    edges[1::2, 2], edges[1::2, 3] = np.arange(pairs)*4+2, np.arange(pairs)*4+3
    counts = np.zeros(2*pairs, np.int32); counts[0::2] = 1
    slots_arr = np.zeros((2*pairs, 1), np.int32); slots_arr[0::2, 0] = np.arange(pairs)*2+1
    rows = [[] for _ in range(2*pairs)]
    for k in np.flatnonzero(rng.random(pairs) < 0.3):
        rows[2*k].append(int(edges[2*k+1, 2]))
    offsets = np.concatenate(([0], np.cumsum([len(r) for r in rows]))).astype(np.int32)
    opposite = np.array([v for r in rows for v in r] or [0], np.int32)
    mass = rng.uniform(0.01, 1, n).astype(F)
    mass[rng.random(n) < 0.05] = 0
    thickness, stiffness = F(0.02), F(0.1)
    force0, diag0 = rng.normal(size=(n, 3)).astype(F), rng.normal(size=(n, 9)).astype(F)
    f_buf, h_buf = d.upload(force0), d.upload(diag0)
    list_buf, counter = d.upload(np.zeros(2*pairs, CONTACT_T)), d.upload(np.zeros(1, np.uint32))
    d.launch(d.function(*legacy_ptx('_ZN7synreal21self_collision_kernel20accumulate_edge_edge')), 2*pairs,
             [d.upload(x), d.upload(edges), d.upload(offsets), d.upload(opposite), d.upload(counts), d.upload(slots_arr),
              d.upload(mass), f32(thickness), f32(stiffness), f_buf, h_buf, list_buf, counter, u64(2*pairs),
              u64(2*pairs), u64(n), ctypes.c_int32(1)])
    force, diag, contacts = force0.copy(), diag0.copy(), []
    selfcollision.accumulate_edge_edge(x, edges, offsets, opposite, counts, slots_arr, mass, thickness, stiffness,
                                       force, diag, contacts)
    report['accumulate_edge_edge'] = compare('force', d.download(f_buf, force), force)
    report['accumulate_edge_edge']['partials'] = compare('diagonal', d.download(h_buf, diag), diag)
    used = int(d.download(counter, np.zeros(1, np.uint32))[0])
    native_list = np.sort(d.download(list_buf, np.zeros(2*pairs, CONTACT_T))[:used], order='ids')
    mine = np.zeros(len(contacts), CONTACT_T)
    for i, c in enumerate(contacts):
        mine[i] = ((c[0], c[1], c[2], c[3]), c[4:10], c[10:13], c[13], 4)
    mine = np.sort(mine, order='ids')
    report['accumulate_edge_edge']['copy_equal'] = bool(used == len(contacts) and native_list.tobytes() == mine.tobytes())
    report['accumulate_edge_edge']['contacts'] = used

    # Edge-face: each edge crosses its own triangle; opposite vertices (1-2 per edge) are separate points.
    t = 400
    centre = (np.arange(t)[:, None]*np.array([[1.0, 0, 0]])).astype(F)
    tri_x = centre[:, None, :]+rng.normal(scale=0.05, size=(t, 3, 3))
    normal = np.cross(tri_x[:, 1]-tri_x[:, 0], tri_x[:, 2]-tri_x[:, 0])
    normal /= np.linalg.norm(normal, axis=1, keepdims=True)
    bary = rng.dirichlet((2, 2, 2), t)
    hit = np.einsum('tk,tkd->td', bary, tri_x)
    tilt = rng.normal(scale=0.5, size=(t, 3))
    axis = normal+tilt
    axis /= np.linalg.norm(axis, axis=1, keepdims=True)
    depth = rng.uniform(-0.02, 0.02, t)[:, None]
    half = rng.uniform(0.0002, 0.03, t)[:, None]  # some shorter than 5e-4: skipped
    e0, e1 = hit+axis*(depth-half), hit+axis*(depth+half)
    opp = hit[:, None, :]+rng.normal(scale=0.03, size=(t, 2, 3))
    x = np.concatenate((tri_x.reshape(-1, 3), e0, e1, opp.reshape(-1, 3))).astype(F)
    n = len(x)
    triangles = np.arange(3*t, dtype=np.int32).reshape(t, 3)
    edges = np.full((t, 4), -1, np.int32)
    edges[:, 2], edges[:, 3] = 3*t+np.arange(t), 4*t+np.arange(t)
    rows = [[5*t+2*i] if rng.random() < 0.4 else [5*t+2*i, 5*t+2*i+1] for i in range(t)]
    offsets = np.concatenate(([0], np.cumsum([len(r) for r in rows]))).astype(np.int32)
    opposite = np.array([v for r in rows for v in r], np.int32)
    counts = np.ones(t, np.int32)
    slots_arr = np.arange(t, dtype=np.int32)[:, None]
    mass = rng.uniform(0.01, 1, n).astype(F)
    mass[rng.random(n) < 0.05] = 0
    thickness, stiffness = F(0.02), F(1.0)
    force0, diag0 = rng.normal(size=(n, 3)).astype(F), rng.normal(size=(n, 9)).astype(F)
    f_buf, h_buf = d.upload(force0), d.upload(diag0)
    contact5 = np.dtype([('ids', '<i4', (5,)), ('w', '<f4', (5,)), ('n', '<f4', (3,)), ('k', '<f4'), ('count', '<i4')])
    list_buf, counter = d.upload(np.zeros(t, contact5)), d.upload(np.zeros(1, np.uint32))
    d.launch(d.function(*legacy_ptx('_ZN7synreal21self_collision_kernel20accumulate_edge_face')), t,
             [d.upload(x), d.upload(edges), d.upload(offsets), d.upload(opposite), d.upload(triangles), d.upload(counts),
              d.upload(slots_arr), d.upload(mass), f32(thickness), f32(stiffness), f_buf, h_buf, list_buf, counter,
              u64(t), u64(t), u64(n), ctypes.c_int32(1)])
    force, diag, contacts = force0.copy(), diag0.copy(), []
    selfcollision.accumulate_edge_face(x, edges, offsets, opposite, triangles, counts, slots_arr, mass, thickness,
                                       stiffness, force, diag, contacts)
    report['accumulate_edge_face'] = compare('force', d.download(f_buf, force), force)
    report['accumulate_edge_face']['partials'] = compare('diagonal', d.download(h_buf, diag), diag)
    used = int(d.download(counter, np.zeros(1, np.uint32))[0])
    native_list = np.sort(d.download(list_buf, np.zeros(t, contact5))[:used], order='ids')
    mine = np.zeros(len(contacts), contact5)
    for i, c in enumerate(contacts):
        mine[i] = c
    mine = np.sort(mine, order='ids')
    report['accumulate_edge_face']['copy_equal'] = bool(used == len(contacts) and native_list.tobytes() == mine.tobytes())
    report['accumulate_edge_face']['contacts'] = used

    # multiply_contact_tangents on disjoint 4- and 5-point records; add_hessian_diagonal on random blocks.
    count = 3000
    records = np.zeros(count, selfcollision.CONTACT_TANGENT)
    records['count'] = rng.choice([4, 5], count)
    records['ids'] = np.arange(5*count, dtype=np.int32).reshape(count, 5)
    records['w'] = rng.normal(size=(count, 5))
    nrm = rng.normal(size=(count, 3)); nrm /= np.linalg.norm(nrm, axis=1, keepdims=True)
    records['n'], records['k'] = nrm, rng.uniform(0, 100, count)
    direction = rng.normal(size=(5*count, 3)).astype(F)
    out0 = rng.normal(size=(5*count, 3)).astype(F)
    out_buf = d.upload(out0)
    d.launch(d.function(*legacy_ptx('_ZN7synreal21self_collision_kernel25multiply_contact_tangents')), count,
             [d.upload(records), d.upload(np.array([count], np.uint32)), d.upload(direction), out_buf])
    out = out0.copy()
    selfcollision.multiply_contact_tangents(records, direction, out)
    report['multiply_contact_tangents'] = compare('product', d.download(out_buf, out), out)
    source, target = rng.normal(size=(1000, 9)).astype(F), rng.normal(size=(1000, 9)).astype(F)
    t_buf = d.upload(target)
    d.launch(d.function(*legacy_ptx('_ZN7synreal21self_collision_kernel20add_hessian_diagonal')), 1000,
             [d.upload(source), t_buf, u64(1000)])
    expected = target.copy()
    selfcollision.add_hessian_diagonal(source, expected)
    report['add_hessian_diagonal'] = compare('blocks', d.download(t_buf, expected), expected)
    vecs, out0 = rng.normal(size=(1000, 3)).astype(F), rng.normal(size=(1000, 3)).astype(F)
    o_buf = d.upload(out0)
    d.launch(d.function(*legacy_ptx('_ZN7synreal21self_collision_kernel25multiply_hessian_diagonal')), 1000,
             [d.upload(source), d.upload(vecs), o_buf, u64(1000)])
    expected = out0.copy()
    selfcollision.multiply_hessian_diagonal(source, vecs, expected)
    report['multiply_hessian_diagonal'] = compare('p', d.download(o_buf, expected), expected)
    return report


def fluid_scene(rng):
    """Permuted fluid subset of a larger particle set, two boundary layers, and a compressed cluster whose rows have
    more than 64 dynamic neighbours (the re-traversal path)."""
    spacing = F(0.05)
    lattice = np.stack(np.meshgrid(np.arange(7), np.arange(5), np.arange(5), indexing='ij'), -1).reshape(-1, 3)
    lattice = (lattice+0.5)*spacing+rng.uniform(-0.15, 0.15, lattice.shape)*spacing
    lattice[lattice[:, 0] < 2*spacing] *= F(0.8)  # compress one side so some rows are active
    cluster = rng.uniform(0, 1.6*spacing, (80, 3))+np.array([0.2, 0.1, 0.1])
    fluid_x = np.concatenate((lattice, cluster)).astype(F)
    walls = np.stack(np.meshgrid(np.arange(-2, 9), np.arange(-2, 7), np.arange(-2, 0), indexing='ij'), -1).reshape(-1, 3)
    boundary = ((walls+0.5)*spacing).astype(F)
    n = len(fluid_x)+40
    fluid_indices = rng.permutation(n)[:len(fluid_x)].astype(np.int32)
    x = rng.uniform(-1, 1, (n, 3)).astype(F)
    x[fluid_indices] = fluid_x
    mass = rng.uniform(0.08, 0.12, n).astype(F)
    world = np.zeros(n, np.int32)
    world[rng.random(n) < 0.2] = -1  # build_grid clamps negative particle worlds to 0
    return x, fluid_indices, world, mass, boundary, rng.uniform(0.9e-4, 1.1e-4, len(boundary)).astype(F)


def fluid_model_bytes(d, n, fluid_indices, world, mass, boundary, volumes, rest_density, h):
    """synreal::Model by value (1864 bytes) with only the fields the fluid kernels read (MODEL_INTERNAL.md)."""
    model = (ctypes.c_ubyte*1864)()
    buf = memoryview(model).cast('B')
    def put(offset, fmt, value):
        struct.pack_into(fmt, buf, offset, value)
    put(24, '<i', n)
    put(28, '<i', n)  # equal counts: worlds come from particle_world, not from replication
    put(48, '<Q', d.upload(mass).value)
    put(120, '<Q', d.upload(world).value)
    put(128, '<Q', len(world))
    put(192, '<i', len(fluid_indices))
    put(200, '<Q', d.upload(fluid_indices).value)
    put(216, '<f', rest_density)
    put(220, '<f', h)
    put(232, '<i', len(boundary))
    put(240, '<Q', d.upload(boundary).value)
    put(256, '<Q', d.upload(volumes).value)
    return model


def fluid_view_bytes(buffers, params):
    view = (ctypes.c_ubyte*112)()
    buf = memoryview(view).cast('B')
    for k, pointer in enumerate(buffers):
        struct.pack_into('<Q', buf, 8*k, pointer.value)
    struct.pack_into('<iiii', buf, 80, params.slots, params.P, params.F, params.rows)
    struct.pack_into('<ffff', buf, 96, params.h, params.K, params.mu, params.dt)
    return view


def run_fluid(driver, rng):
    """fluid_kernel: grid, rows, row accumulation/product (one active row per launch, so atomics are ordered), and
    the step limiter."""
    d = driver
    ptx = lambda name: d.function(*legacy_ptx('_ZN7synreal12fluid_kernel'+name))
    x, fluid_indices, world, mass, boundary, bvol = fluid_scene(rng)
    n, nf, nb = len(x), len(fluid_indices), len(boundary)
    g_count = nf+nb
    rho, h, dt = F(1000.0), F(0.1), F(1/240)
    slots = fluid.slot_count(g_count)
    p = fluid.Params(h, 2.0e5, 0.3, dt, nf, g_count, nf, slots)
    out = {}
    # build_grid: deterministic fields bitwise; hash lists compared as per-slot sets (atom.exch order varies).
    model = fluid_model_bytes(d, n, fluid_indices, world, mass, boundary, bvol, rho, h)
    bufs = {name: d.upload(np.zeros(shape, dtype)) for name, shape, dtype in (
        ('positions', (g_count, 3), F), ('volumes', g_count, F), ('ids', g_count, np.int32),
        ('world', g_count, np.int32), ('cells', (g_count, 3), np.int32), ('next', g_count, np.int32))}
    bufs['head'] = d.upload(np.full(slots, -1, np.int32))
    d.launch(ptx('10build_grid'), g_count, [model, d.upload(x), bufs['positions'], bufs['volumes'], bufs['ids'],
             bufs['world'], bufs['cells'], bufs['head'], bufs['next'], ctypes.c_int32(g_count),
             ctypes.c_int32(slots)], block=128)
    like = {'positions': np.zeros((g_count, 3), F), 'volumes': np.zeros(g_count, F), 'ids': np.zeros(g_count, np.int32),
            'world': np.zeros(g_count, np.int32), 'cells': np.zeros((g_count, 3), np.int32),
            'next': np.zeros(g_count, np.int32), 'head': np.zeros(slots, np.int32)}
    native = {k: d.download(bufs[k], v) for k, v in like.items()}
    mine = fluid.build_grid(x, fluid_indices, world, mass, rho, h, boundary, bvol, slots)
    for name in ('positions', 'volumes', 'ids', 'world', 'cells'):
        out['build_grid_'+name] = compare(name, native[name], getattr(mine, name))
    def slot_sets(head, nxt):
        sets = {}
        for s in np.flatnonzero(head >= 0):
            items, j = [], head[s]
            while j >= 0:
                items.append(int(j))
                j = nxt[j]
            sets[int(s)] = sorted(items)
        return sets
    same = slot_sets(native['head'], native['next']) == slot_sets(mine.head, mine.next)
    out['build_grid_lists'] = {'bitwise_equal': bool(same), 'note': 'per-slot membership; insertion order differs'}
    # Rows run on the native hash lists so that both sides traverse neighbours in the same order.
    grid = fluid.Grid(native['ids'], native['world'], native['positions'], native['volumes'], native['cells'],
                      native['head'], native['next'])
    view_buffers = [bufs['head'], bufs['next'], bufs['ids'], bufs['world'], bufs['cells'], bufs['positions'],
                    bufs['volumes']]
    counts_buf = d.upload(np.zeros(nf, np.int32))
    ids_buf = d.upload(np.zeros((nf, 64), np.int32))
    cache_buf = d.upload(np.zeros((nf, 64, 4), F))
    view = fluid_view_bytes(view_buffers+[counts_buf, ids_buf, cache_buf], p)
    row_like = (np.zeros((nf, 3), F), np.zeros(nf, F), np.zeros(nf, F))
    grad_buf, res_buf, w_buf = (d.upload(a) for a in row_like)
    d.launch(ptx('13evaluate_rows'), nf, [view, grad_buf, res_buf, w_buf, counts_buf, ids_buf, cache_buf], block=128)
    ref = (d.download(grad_buf, row_like[0]), d.download(res_buf, row_like[1]), d.download(w_buf, row_like[2]),
           d.download(counts_buf, np.zeros(nf, np.int32)), d.download(ids_buf, np.zeros((nf, 64), np.int32)),
           d.download(cache_buf, np.zeros((nf, 64, 4), F)))
    rows = fluid.evaluate_rows(grid, p)
    for name, a, b in zip(('grad', 'residual', 'weight', 'count', 'cache_ids', 'cache'), ref, rows):
        out['evaluate_rows_'+name] = compare(name, a, b)
    grad, residual, weight, count, cache_ids, cache = ref
    out['evaluate_rows_coverage'] = {
        'bitwise_equal': bool((count > 64).any() and (weight > 0).any() and (weight == 0).any()
                              and (cache[..., 3] > 0).any()),
        'fallback_rows': int((count > 64).sum()), 'active_rows': int((weight > 0).sum())}
    # One active row per launch: the other rows get weight 0 and count 0, so they only add +-0 to nonzero data.
    picks = np.concatenate((rng.choice(np.flatnonzero((weight > 0) & (count <= 64)), 8, replace=False),
                            rng.choice(np.flatnonzero(count > 64), 3, replace=False),
                            rng.choice(np.flatnonzero(weight == 0), 3, replace=False)))
    y = (x+rng.uniform(-1e-3, 1e-3, x.shape)).astype(F)
    force0 = rng.uniform(-1, 1, (n, 3)).astype(F)
    diag0 = rng.uniform(1, 2, (n, 9)).astype(F)
    direction = rng.uniform(-1, 1, (n, 3)).astype(F)
    product0 = rng.uniform(-1, 1, (n, 3)).astype(F)
    res_ok, prod_ok, changed, changed_t = [], [], [], []
    for r in picks:
        only_w = np.where(np.arange(nf) == r, weight, F(0)).astype(F)
        only_c = np.where(np.arange(nf) == r, count, 0).astype(np.int32)
        view_r = fluid_view_bytes(view_buffers+[d.upload(only_c), ids_buf, cache_buf], p)
        f_buf, dg_buf = d.upload(force0), d.upload(diag0)
        d.launch(ptx('15accumulate_rows'), nf, [view_r, grad_buf, res_buf, d.upload(only_w), d.upload(y), f_buf,
                 dg_buf], block=128)
        f_ref, dg_ref = d.download(f_buf, force0), d.download(dg_buf, diag0)
        f_mine, dg_mine = force0.copy(), diag0.copy()
        fluid.accumulate_rows(grid, p, grad, residual, weight, count, cache_ids, cache, y, f_mine, dg_mine, rows=[r])
        res_ok.append((compare('f', f_ref, f_mine), compare('d', dg_ref, dg_mine)))
        changed.append((int(np.count_nonzero(f_ref != force0)), int(np.count_nonzero(dg_ref != diag0))))
        t_buf = d.upload(product0)
        d.launch(ptx('13multiply_rows'), nf, [view_r, grad_buf, d.upload(only_w), d.upload(direction), t_buf],
                 block=128)
        t_ref = d.download(t_buf, product0)
        t_mine = product0.copy()
        fluid.multiply_rows(grid, p, grad, weight, count, cache_ids, cache, direction, t_mine, rows=[r])
        prod_ok.append(compare('t', t_ref, t_mine))
        changed_t.append(int(np.count_nonzero(t_ref != product0)))
    out['accumulate_rows'] = {'bitwise_equal': all(a['bitwise_equal'] and b['bitwise_equal'] for a, b in res_ok),
                              'rows': [int(r) for r in picks],
                              'changed_force_diagonal_per_row': changed,
                              'viscous_rows': int(sum((cache[r, :min(count[r], 64), 3] > 0).any() for r in picks)),
                              'mismatches': int(sum(a['mismatches']+b['mismatches'] for a, b in res_ok))}
    out['multiply_rows'] = {'bitwise_equal': all(t['bitwise_equal'] for t in prod_ok),
                            'changed_per_row': changed_t, 'mismatches': int(sum(t['mismatches'] for t in prod_ok))}
    # add_diagonal and the step limiter.
    b0 = rng.uniform(-1, 1, (n, 9)).astype(F)
    dmat = rng.uniform(-1, 1, (n, 9)).astype(F)
    b_buf = d.upload(b0)
    d.launch(ptx('12add_diagonal'), n, [d.upload(dmat), b_buf, ctypes.c_int32(n)], block=128)
    b_mine = b0.copy()
    fluid.add_diagonal(dmat, b_mine)
    out['add_diagonal'] = compare('b', d.download(b_buf, b0), b_mine)
    solution = (rng.standard_normal((n, 3))*0.05).astype(F)
    for label, ratio in (('limited', 0.25), ('relaxation_only', 0.0)):
        max_step = F(ratio)*h
        scale_buf = d.upload(np.zeros(1, F))
        d.launch(ptx('16initialize_scale'), 1, [scale_buf, f32(1.0), ctypes.c_int32(1)], block=128)
        d.launch(ptx('11bound_scale'), nf, [view, d.upload(solution), f32(0.5), f32(max_step), scale_buf], block=128)
        scale_ref = d.download(scale_buf, np.zeros(1, F))
        sol_buf = d.upload(solution)
        d.launch(ptx('10scale_step'), n, [model, sol_buf, scale_buf, ctypes.c_int32(n)], block=128)
        scale_mine = fluid.limit_step(grid, p, solution, 0.5, max_step)
        out['bound_scale_'+label] = compare('s', scale_ref, scale_mine)
        out['scale_step_'+label] = compare('x', d.download(sol_buf, solution), fluid.scale_step(solution, scale_mine, world))
    return out


def run_particle_pairs(driver, rng):
    """build_particle_aabbs, query_particle_pairs (plain, with world filter, saturated slots) and
    accumulate_particle_pairs on disjoint pairs (each particle in at most one pair, so atomics cannot reorder)."""
    d = driver
    sc = lambda name: d.function(*legacy_ptx('_ZN7synreal21self_collision_kernel'+name))
    out = {}
    n = 300
    x = rng.uniform(0, 0.12, (n, 3)).astype(F)
    radius = rng.uniform(0.004, 0.009, n).astype(F)
    ids = rng.permutation(n)[:250].astype(np.int32)
    groups = np.where(rng.random(n) < 0.3, rng.integers(1, 4, n), 0).astype(np.int32)
    world = rng.integers(-1, 2, n).astype(np.int32)
    # Two coincident pairs among the colliding particles (same group 0 and world 0) exercise the axis normal.
    twins = np.sort(ids[:4].reshape(2, 2), axis=1)
    x[twins[:, 1]] = x[twins[:, 0]]
    groups[twins.ravel()] = 0
    world[twins.ravel()] = 0
    boxes = selfcollision.particle_aabbs(x, ids, radius)
    box_buf = d.upload(np.zeros_like(boxes))
    d.launch(sc('20build_particle_aabbs'), len(ids), [d.upload(x), d.upload(ids), d.upload(radius), box_buf,
             u64(len(ids)), u64(len(ids)), u64(n)])
    out['build_particle_aabbs'] = compare('aabb', d.download(box_buf, boxes), boxes)
    tree = lbvh.Lbvh(selfcollision.particle_aabbs(x, ids, np.zeros(n, F)))
    tree.refit(boxes)
    for label, w, slots in (('plain', None, 31), ('worlds', world, 31), ('saturated', world, 3)):
        counts_buf = d.upload(np.zeros(len(ids), np.int32))
        slots_buf = d.upload(np.zeros((len(ids), slots), np.int32))
        d.launch(sc('20query_particle_pairs'), len(ids), [
            d.upload(x), d.upload(ids), d.upload(radius), d.upload(w) if w is not None else null(), d.upload(groups),
            d.upload(tree.nodes), d.upload(tree.parent), d.upload(tree.children), d.upload(tree.order),
            d.upload(tree.escape), d.upload(tree.leaf), counts_buf, slots_buf, u64(len(ids)), u64(len(ids)), u64(n),
            ctypes.c_int32(slots)])
        ref_counts = d.download(counts_buf, np.zeros(len(ids), np.int32))
        ref_slots = d.download(slots_buf, np.zeros((len(ids), slots), np.int32))
        counts, found = selfcollision.query_particle_pairs(x, ids, radius, w, groups, tree, slots)
        mask = np.arange(slots)[None] < ref_counts[:, None]
        same = np.array_equal(ref_counts, counts) and np.array_equal(ref_slots[mask], found[mask])
        out['query_particle_pairs_'+label] = {'bitwise_equal': bool(same), 'pairs': int(ref_counts.sum()),
                                              'saturated_threads': int((ref_counts == slots).sum())}
    # Disjoint pairs: greedily keep found pairs whose particles are still unused.
    counts, found = selfcollision.query_particle_pairs(x, ids, radius, None, groups, tree, 31)
    used = np.zeros(n, bool)
    keep_counts = np.zeros_like(counts)
    keep_slots = np.zeros_like(found)
    thread = {int(i): t for t, i in enumerate(ids)}
    for i, j in twins:  # keep the coincident pairs first so the axis-normal branch is always covered
        t = thread[int(i)]
        if j in found[t, :counts[t]]:
            used[i] = used[j] = True
            keep_slots[t, 0], keep_counts[t] = j, 1
    for t, i in enumerate(ids):
        if keep_counts[t]:
            continue
        for j in found[t, :counts[t]]:
            if not used[i] and not used[j]:
                used[i] = used[j] = True
                keep_slots[t, 0] = j
                keep_counts[t] = 1
                break
    weight = rng.uniform(10, 1000, n).astype(F)
    weight[rng.random(n) < 0.1] = 0
    force0, diag0 = rng.uniform(-1, 1, (n, 3)).astype(F), rng.uniform(-1, 1, (n, 9)).astype(F)
    f_buf, dg_buf = d.upload(force0), d.upload(diag0)
    list_buf, counter = d.upload(np.zeros(len(ids), CONTACT_T)), d.upload(np.zeros(1, np.uint32))
    d.launch(sc('25accumulate_particle_pairs'), len(ids), [
        d.upload(x), d.upload(ids), d.upload(radius), d.upload(keep_counts), d.upload(keep_slots), d.upload(weight),
        f32(0.7), f_buf, dg_buf, list_buf, counter, u64(len(ids)), u64(len(ids)), u64(n), ctypes.c_int32(31)])
    f_mine, dg_mine, contacts = force0.copy(), diag0.copy(), []
    selfcollision.accumulate_particle_pairs(x, ids, radius, keep_counts, keep_slots, weight, 0.7, f_mine, dg_mine,
                                            contacts)
    out['accumulate_particle_pairs_force'] = compare('f', d.download(f_buf, force0), f_mine)
    out['accumulate_particle_pairs_diagonal'] = compare('d', d.download(dg_buf, diag0), dg_mine)
    used_count = int(d.download(counter, np.zeros(1, np.uint32))[0])
    native_list = np.sort(d.download(list_buf, np.zeros(len(ids), CONTACT_T))[:used_count], order='ids')
    mine = np.sort(selfcollision.contact_records(contacts), order='ids')
    pairs = [(int(i), int(keep_slots[t, 0])) for t, i in enumerate(ids) if keep_counts[t]]
    out['accumulate_particle_pairs_coverage'] = {
        'bitwise_equal': bool(any(np.linalg.norm(x[i]-x[j]) <= 1e-8 for i, j in pairs)
                              and any(weight[i] == 0 or weight[j] == 0 for i, j in pairs)),
        'pairs': len(pairs), 'coincident': int(sum(np.linalg.norm(x[i]-x[j]) <= 1e-8 for i, j in pairs)),
        'zero_weight': int(sum(weight[i] == 0 or weight[j] == 0 for i, j in pairs))}
    out['accumulate_particle_pairs_list'] = {
        'bitwise_equal': bool(len(mine) == used_count and native_list.tobytes() == mine.tobytes()),
        'contacts': used_count}
    return out


def random_affine_bodies(rng, count):
    """4 state particles per body: translation and the columns of A (rotations, scaled/sheared, reflected,
    near-singular and zero matrices)."""
    q = np.zeros((4*count, 3), F)
    for k in range(count):
        axis = rng.normal(size=3)
        axis /= np.linalg.norm(axis)
        angle = rng.uniform(0, np.pi)
        kx = np.array([[0, -axis[2], axis[1]], [axis[2], 0, -axis[0]], [-axis[1], axis[0], 0]])
        rot = np.eye(3)+np.sin(angle)*kx+(1-np.cos(angle))*kx@kx
        kind = k % 6
        if kind == 1:
            rot = rot@(np.eye(3)+rng.uniform(-0.3, 0.3, (3, 3)))
        elif kind == 2:
            rot = rot*rng.uniform(0.01, 100.0)
        elif kind == 3:
            rot = rot@np.diag([1, 1, -1])
        elif kind == 4:
            rot = rot@np.diag([1, 1, 1e-6])
        elif kind == 5 and k % 12 == 5:
            rot = np.zeros((3, 3))
        q[4*k] = rng.uniform(-1, 1, 3)
        q[4*k+1:4*k+4] = (rot+rng.normal(scale=1e-3, size=(3, 3))*(kind == 0)).T  # rows = columns of A
    return q, np.arange(4*count, dtype=np.int32).reshape(-1, 4)


def run_affine(driver, rng):
    """Affine-body kernels."""
    d = driver
    out = {}
    count = 600
    q, indices = random_affine_bodies(rng, count)
    r_buf, l_buf = d.upload(np.full((count, 9), F(7))), d.upload(np.full((count, 9), F(7)))
    d.launch(d.function(*legacy_ptx('32initialize_affine_body_so3_state')), count,
             [d.upload(q), d.upload(indices), r_buf, l_buf, u64(count), u64(count), u64(len(q))])
    rotation, multiplier = affine.initialize_so3_state(q, indices)
    out['initialize_so3_rotation'] = compare('r', d.download(r_buf, rotation), rotation)
    out['initialize_so3_multiplier'] = compare('l', d.download(l_buf, multiplier), multiplier)
    multiplier = rng.normal(scale=0.05, size=(count, 9)).astype(F)
    weight = rng.uniform(0.1, 10, count).astype(F)
    force0 = rng.uniform(-1, 1, q.shape).astype(F)
    f_buf = d.upload(force0)
    d.launch(d.function(*legacy_ptx('51evaluate_affine_body_so3_augmented_lagrangian_force')), count,
             [d.upload(q), d.upload(indices), d.upload(weight), d.upload(rotation), d.upload(multiplier), f32(100.0),
              f_buf, u64(count), u64(count), u64(len(q))])
    f_mine = force0.copy()
    affine.so3_force(q, indices, weight, rotation, multiplier, 100.0, f_mine)
    out['so3_force'] = compare('f', d.download(f_buf, force0), f_mine)
    # apply_affine_body_preconditioner: 12x12 blocks, some bodies flagged invalid (rows untouched).
    inv12 = rng.normal(size=(count, 144)).astype(F)
    valid12 = (rng.random(count) < 0.8).astype(np.int32)
    res12 = rng.normal(size=q.shape).astype(F)
    z0 = rng.normal(size=q.shape).astype(F)
    z_buf = d.upload(z0)
    d.launch(d.function(*legacy_ptx('32apply_affine_body_preconditioner')), count,
             [d.upload(indices), d.upload(inv12), d.upload(valid12), d.upload(res12), z_buf, u64(count), u64(count),
              u64(len(q))])
    z_mine = z0.copy()
    pcg.apply_affine_body_preconditioner(indices, inv12, valid12, res12, z_mine)
    out['apply_affine_body_preconditioner'] = compare('z', d.download(z_buf, z0), z_mine)
    # apply_affine_body_torques: body inertia tensors, some zero torques (skipped).
    inertia_t = np.zeros((count, 9), F)
    for b_ in range(count):
        g = rng.normal(size=(3, 3))
        inertia_t[b_] = (g@g.T+np.eye(3)*rng.uniform(0.01, 1)).astype(F).reshape(9)
    tau = rng.normal(size=(count, 3)).astype(F)
    tau[rng.random(count) < 0.1] = 0
    f_buf = d.upload(force0)
    d.launch(d.function(*legacy_ptx('25apply_affine_body_torques')), count,
             [d.upload(q), d.upload(indices), d.upload(inertia_t), d.upload(tau), f_buf, u64(count), u64(count),
              u64(len(q))])
    f_mine = force0.copy()
    affine.apply_affine_body_torques(q, indices, inertia_t, tau, f_mine)   # minuend-fused cofactors and crosses
    out['affine_body_torques'] = compare('f', d.download(f_buf, force0), f_mine)
    # SIX_SPRINGS rigidity: column springs (some bodies exactly rigid, hitting the strain snap).
    q6 = q.copy()
    q6[1:4*8:4] = np.array([1, 0, 0], F)
    q6[2:4*8:4] = np.array([0, 1, 0], F)
    q6[3:4*8:4] = np.array([0, 0, 1], F)
    f_buf = d.upload(force0)
    d.launch(d.function(*legacy_ptx('33evaluate_affine_body_spring_force')), count,
             [d.upload(q6), d.upload(indices), d.upload(weight), f32(100.0), f_buf, u64(count), u64(count), u64(len(q))])
    f_mine = force0.copy()
    affine.six_spring_force(q6, indices, weight, 100.0, f_mine)
    out['six_spring_force'] = compare('f', d.download(f_buf, force0), f_mine)
    for model in (0, 1):
        f_buf = d.upload(force0)
        d.launch(d.function(*legacy_ptx('39evaluate_affine_body_constitutive_force')), count,
                 [d.upload(q), d.upload(indices), d.upload(weight), f32(100.0), ctypes.c_uint32(model), f_buf,
                  u64(count), u64(count), u64(len(q))])
        f_mine = force0.copy()
        affine.constitutive_force(q, indices, weight, 100.0, model, f_mine)
        out[f'constitutive_force_{model}'] = compare('f', d.download(f_buf, force0), f_mine)
        direction6 = rng.uniform(-1, 1, q.shape).astype(F)
        t_buf = d.upload(force0)
        d.launch(d.function(*legacy_ptx('41multiply_affine_body_constitutive_tangent')), count,
                 [d.upload(q), d.upload(direction6), d.upload(indices), d.upload(weight), f32(100.0),
                  ctypes.c_uint32(model), t_buf, u64(count), u64(count), u64(len(q))])
        t_mine = force0.copy()
        affine.constitutive_tangent(q, direction6, indices, weight, 100.0, model, t_mine)
        out[f'constitutive_tangent_{model}'] = compare('t', d.download(t_buf, force0), t_mine)
        b0 = rng.uniform(-1, 1, (len(q), 9)).astype(F)
        b_buf = d.upload(b0)
        d.launch(d.function(*legacy_ptx('43add_affine_body_constitutive_preconditioner')), count,
                 [d.upload(q), d.upload(indices), d.upload(weight), f32(100.0), ctypes.c_uint32(model), b_buf,
                  u64(count), u64(count), u64(len(q))])
        b_mine = b0.copy()
        affine.constitutive_preconditioner(q, indices, weight, 100.0, model, b_mine)
        out[f'constitutive_preconditioner_{model}'] = compare('b', d.download(b_buf, b0), b_mine)
    # SIX_SPRINGS Gauss-Newton Hessian into the diagonal and an ELL holding each body's column couplings.
    n = len(q)
    max_nnz = 3
    cols = np.full((max_nnz, n), -1, np.int32)
    row_nnz = np.zeros(n, np.int32)
    for ids in indices.reshape(-1, 4):
        for r in ids:
            others = sorted(int(c) for c in ids if c != r)
            row_nnz[r] = len(others)
            cols[:, r] = others
    blocks = rng.uniform(-1, 1, (max_nnz, n, 9)).astype(F)
    diag0 = rng.uniform(-1, 1, (n, 9)).astype(F)
    raw = np.zeros((max_nnz, n, 10), np.uint32)
    raw[..., 0] = cols.view(np.uint32)
    raw[..., 1:] = blocks.view(np.uint32)
    weight6 = weight.copy()
    weight6[5] = 0
    e_buf, dg_buf = d.upload(raw), d.upload(diag0)
    d.launch(d.function(*legacy_ptx('43add_affine_body_spring_gauss_newton_hessian')), count,
             [d.upload(q6), d.upload(indices), d.upload(weight6), f32(100.0), dg_buf, d.upload(row_nnz), e_buf,
              u64(max_nnz), u64(count), u64(count), u64(n), u64(n)])
    dg_mine, b_mine = diag0.copy(), blocks.copy()
    affine.six_spring_hessian(q6, indices, weight6, 100.0, dg_mine, (row_nnz, cols, b_mine, max_nnz))
    out['six_spring_hessian_diag'] = compare('d', d.download(dg_buf, diag0), dg_mine)
    out['six_spring_hessian_ell'] = compare('b', d.download(e_buf, raw)[..., 1:].copy().view(F), b_mine)
    direction = rng.uniform(-1, 1, q.shape).astype(F)
    t_buf = d.upload(force0)
    d.launch(d.function(*legacy_ptx('53multiply_affine_body_so3_augmented_lagrangian_tangent')), count,
             [d.upload(direction), d.upload(indices), d.upload(weight), d.upload(rotation), f32(100.0), t_buf,
              u64(count), u64(count), u64(len(q))])
    t_mine = force0.copy()
    affine.so3_tangent(direction, indices, weight, rotation, 100.0, t_mine)
    out['so3_tangent'] = compare('t', d.download(t_buf, force0), t_mine)
    b0 = rng.uniform(-1, 1, (len(q), 9)).astype(F)
    b_buf = d.upload(b0)
    d.launch(d.function(*legacy_ptx('55add_affine_body_so3_augmented_lagrangian_preconditioner')), count,
             [d.upload(indices), d.upload(weight), d.upload(rotation), f32(100.0), b_buf, u64(count), u64(count),
              u64(len(q))])
    b_mine = b0.copy()
    affine.so3_preconditioner(indices, weight, rotation, 100.0, b_mine)
    out['so3_preconditioner'] = compare('b', d.download(b_buf, b0), b_mine)
    for flag in (False, True):
        r_buf, l_buf = d.upload(rotation), d.upload(multiplier)
        d.launch(d.function(*legacy_ptx('49update_affine_body_so3_augmented_lagrangian_state')), count,
                 [d.upload(q), d.upload(indices), r_buf, l_buf, ctypes.c_bool(flag), u64(count), u64(count),
                  u64(len(q))])
        r_mine, l_mine = rotation.copy(), multiplier.copy()
        affine.update_so3_state(q, indices, r_mine, l_mine, flag)
        out[f'so3_update_rotation_{flag}'] = compare('r', d.download(r_buf, rotation), r_mine)
        out[f'so3_update_multiplier_{flag}'] = compare('l', d.download(l_buf, multiplier), l_mine)
    return out


def rigid_contact_scene(rng, count):
    """Each contact has its own pair of shapes and bodies (no shared particles): body box-like shapes (type 7) and
    spheres (type 3) on affine bodies, static planes (type 0) and static spheres; overlapping and separated pairs."""
    n_bodies = 2*count
    q, indices = random_affine_bodies(rng, n_bodies)
    q[0::4] = rng.uniform(-1, 1, (n_bodies, 3))
    com = rng.uniform(-0.05, 0.05, (n_bodies, 3)).astype(F)
    shapes = 2*count
    shape_body = np.arange(shapes, dtype=np.int32)
    static = rng.random(shapes) < 0.3
    static[0::2] = False                                   # shape0 always on a body
    shape_body[static] = -1
    shape_type = np.where(rng.random(shapes) < 0.4, 3, 7).astype(np.int32)
    shape_type[static & (rng.random(shapes) < 0.5)] = 0
    transform = np.zeros((shapes, 7), F)
    transform[:, :3] = rng.uniform(-0.05, 0.05, (shapes, 3))
    transform[:, 6] = 1
    scale = rng.uniform(0.02, 0.1, (shapes, 3)).astype(F)
    mat = {k: rng.uniform(lo, hi, shapes).astype(F) for k, lo, hi in
           (('ke', 1e3, 1e5), ('kd', 0, 50), ('kf', 0, 500), ('mu', 0, 1))}
    contacts = {
        'count': count, 'shape0': np.arange(0, shapes, 2, dtype=np.int32),
        'shape1': np.arange(1, shapes, 2, dtype=np.int32),
        'point0': rng.uniform(-0.1, 0.1, (count, 3)).astype(F), 'point1': rng.uniform(-0.1, 0.1, (count, 3)).astype(F),
        'offset0': rng.uniform(-0.01, 0.01, (count, 3)).astype(F), 'offset1': rng.uniform(-0.01, 0.01, (count, 3)).astype(F),
        'normal': rng.normal(size=(count, 3)).astype(F), 'margin0': rng.uniform(0, 3, count).astype(F),
        'margin1': rng.uniform(0, 3, count).astype(F)}
    return q, indices, com, shape_body, shape_type, transform, scale, mat, contacts


def run_rigid_contact(driver, rng):
    """evaluate_contact_force on contacts with disjoint bodies: offsets on/off, native and smoothed friction."""
    d = driver
    out = {}
    count = 400
    q, indices, com, shape_body, shape_type, transform, scale, mat, contacts = rigid_contact_scene(rng, count)
    n = len(q)
    previous = (q+rng.normal(scale=2e-3, size=q.shape)).astype(F)
    velocity = rng.normal(size=q.shape).astype(F)
    bodies = rigid_contact.Bodies(np.arange(len(indices), dtype=np.int32), indices, com)
    shapes = {'body': shape_body, 'type': shape_type, 'position': transform[:, :3], 'scale': scale, **mat}
    fn = d.function(*legacy_ptx('22evaluate_contact_force'))
    for label, offsets, eps, use_prev in (('offsets', True, 0.0, True), ('plain', False, 0.0, True),
                                          ('smooth', True, 0.05, True), ('velocity', False, 0.0, False)):
        c = dict(contacts)
        if not offsets:
            c['offset0'] = c['offset1'] = None
        force0 = rng.uniform(-1, 1, (n, 3)).astype(F)
        scalar0 = rng.uniform(0, 1, n).astype(F)
        f_buf, s_buf = d.upload(force0), d.upload(scalar0)
        arr = lambda a: d.upload(a) if a is not None else null()
        d.launch(fn, count, [
            d.upload(np.array([count], np.int32)), u64(count), d.upload(c['shape0']), d.upload(c['shape1']),
            d.upload(c['point0']), d.upload(c['point1']), arr(c['offset0']), arr(c['offset1']), d.upload(c['normal']),
            d.upload(c['margin0']), d.upload(c['margin1']), d.upload(shape_body), d.upload(shape_type),
            d.upload(transform), d.upload(scale), d.upload(mat['ke']), d.upload(mat['kd']), d.upload(mat['kf']),
            d.upload(mat['mu']), f32(eps), u64(len(shape_body)), u64(len(shape_body)), u64(1),
            d.upload(bodies.ids), d.upload(indices), d.upload(com), u64(len(indices)), u64(n), d.upload(q),
            d.upload(velocity), d.upload(previous) if use_prev else null(), f32(240.0), f_buf, s_buf])
        f_mine, s_mine = force0.copy(), scalar0.copy()
        rigid_contact.evaluate_contact_force(c, shapes, bodies, q, previous if use_prev else None, velocity, 240.0,
                                             eps, f_mine, s_mine)
        f_ref, s_ref = d.download(f_buf, force0), d.download(s_buf, scalar0)
        out['contact_force_'+label] = compare('f', f_ref, f_mine)
        out['contact_scalar_'+label] = compare('s', s_ref, s_mine)
        out['contact_coverage_'+label] = {'bitwise_equal': bool(np.any(f_ref != force0)),
                                          'changed_particles': int(np.any(f_ref != force0, axis=1).sum())}
        # evaluate_contact_tangent: block mode (A and B) and product mode. It has no velocity array: the host always
        # passes previous positions (a null pointer faults on the GPU), so the velocity-array case is skipped.
        if not use_prev:
            continue
        tangent = d.function(*legacy_ptx('24evaluate_contact_tangent'))
        common = [d.upload(np.array([count], np.int32)), u64(count), d.upload(c['shape0']), d.upload(c['shape1']),
                  d.upload(c['point0']), d.upload(c['point1']), arr(c['offset0']), arr(c['offset1']),
                  d.upload(c['normal']), d.upload(c['margin0']), d.upload(c['margin1']), d.upload(shape_body),
                  d.upload(shape_type), d.upload(transform), d.upload(scale), d.upload(mat['ke']),
                  d.upload(mat['kd']), d.upload(mat['kf']), d.upload(mat['mu']), f32(eps), u64(len(shape_body)),
                  u64(len(shape_body)), u64(1), d.upload(bodies.ids), d.upload(indices), d.upload(com),
                  u64(len(indices)), d.upload(q), d.upload(previous) if use_prev else null()]
        a0, b0 = rng.uniform(-1, 1, (n, 9)).astype(F), rng.uniform(-1, 1, (n, 9)).astype(F)
        a_buf, b_buf = d.upload(a0), d.upload(b0)
        d.launch(tangent, count, common+[null(), null(), f32(240.0), u64(n), a_buf, b_buf])
        a_mine, b_mine = a0.copy(), b0.copy()
        rigid_contact.evaluate_contact_tangent(c, shapes, bodies, q, previous if use_prev else None, velocity, 240.0,
                                               eps, system=a_mine, precond=b_mine)
        out['contact_tangent_blockA_'+label] = compare('a', d.download(a_buf, a0), a_mine)
        out['contact_tangent_blockB_'+label] = compare('b', d.download(b_buf, b0), b_mine)
        direction = rng.uniform(-1, 1, (n, 3)).astype(F)
        t0 = rng.uniform(-1, 1, (n, 3)).astype(F)
        t_buf = d.upload(t0)
        d.launch(tangent, count, common+[d.upload(direction), t_buf, f32(240.0), u64(n), null(), null()])
        t_mine = t0.copy()
        rigid_contact.evaluate_contact_tangent(c, shapes, bodies, q, previous if use_prev else None, velocity, 240.0,
                                               eps, direction=direction, product=t_mine)
        out['contact_tangent_product_'+label] = compare('t', d.download(t_buf, t0), t_mine)
    return out


def random_inertia(rng, count):
    """Symmetric body-frame inertia tensors with principal moments satisfying the triangle inequality."""
    out = np.zeros((count, 3, 3), F)
    for k in range(count):
        m = rng.uniform(0.5, 2.0, 3)
        moments = np.array([m[1]+m[2], m[0]+m[2], m[0]+m[1]])*0.01
        rot, _ = np.linalg.qr(rng.normal(size=(3, 3)))
        out[k] = (rot*moments) @ rot.T
    return out.reshape(count, 9)


def rolling_view(d, count, c, shape_body, shape_type, transform, scale, mat, rolling, torsional, bodies, inertia, q,
                 previous, inv_h, eps):
    """RollingContactView (248 B, passed by value) as a ctypes byte array."""
    arr = lambda a: d.upload(a).value if a is not None else 0
    shapes = len(shape_body)
    words = [d.upload(np.array([count], np.int32)).value, count, arr(c['shape0']), arr(c['shape1']),
             arr(c['point0']), arr(c['point1']), arr(c['offset0']), arr(c['offset1']), arr(c['normal']),
             arr(c['margin0']), arr(c['margin1']), arr(shape_body), arr(shape_type), arr(transform), arr(scale),
             arr(mat['ke']), arr(mat['kd']), arr(rolling), arr(torsional), shapes, shapes, 1, arr(bodies.ids),
             arr(bodies.indices), arr(bodies.com), arr(inertia), len(bodies.indices), len(q), arr(q), arr(previous)]
    raw = struct.pack('<30Q', *[int(w) for w in words]) + struct.pack('<ff', inv_h, eps)
    assert len(raw) == 248
    return (ctypes.c_char*248).from_buffer_copy(raw)


def run_rolling_contact(driver, rng):
    """evaluate_rolling_contact_force on disjoint body pairs (static shape0/1 too) and on contacts sharing bodies."""
    d = driver
    out = {}
    count = 400
    q, indices, com, shape_body, shape_type, transform, scale, mat, contacts = rigid_contact_scene(rng, count)
    shape_body[0::2][rng.random(count) < 0.15] = -1          # some static shape0
    shape_body[1:20:2] = shape_body[0:19:2]                  # same-body pairs (skipped by the kernel)
    n = len(q)
    previous = (q+rng.normal(scale=2e-3, size=q.shape)).astype(F)
    bodies = rigid_contact.Bodies(np.arange(len(indices), dtype=np.int32), indices, com)
    inertia = random_inertia(rng, len(indices))
    rolling = rng.uniform(0, 0.02, len(shape_body)).astype(F)
    torsional = rng.uniform(0, 0.05, len(shape_body)).astype(F)
    rolling[rng.random(len(rolling)) < 0.2] = 0
    torsional[rng.random(len(torsional)) < 0.2] = 0
    fn = d.function(*legacy_ptx('30evaluate_rolling_contact_force'))
    for label, offsets, shared, eps in (('offsets', True, False, 0.1), ('plain', False, False, 0.1),
                                        ('tiny_eps', False, False, 1e-4), ('shared', True, True, 0.1)):
        c = dict(contacts)
        sb = shape_body.copy()
        if shared:
            # In warp 0 every shape1 belongs to one of 3 bodies and half of the shape0 are static, so lanes with 3 and
            # 6 Jacobian entries hit the same particles. Across warps the GPU order is nondeterministic (checked).
            sb[1:64:2] = np.where(sb[1:64:2] >= 0, rng.integers(1, 7, 32)*2-1, -1)
            sb[0:64:2] = np.where(rng.random(32) < 0.5, sb[0:64:2], -1)
        if not offsets:
            c['offset0'] = c['offset1'] = None
        shapes = {'body': sb, 'type': shape_type, 'position': transform[:, :3], 'scale': scale,
                  'rolling': rolling, 'torsional': torsional, **mat}
        force0 = rng.uniform(-1, 1, (n, 3)).astype(F)
        f_buf = d.upload(force0)
        view = rolling_view(d, count, c, sb, shape_type, transform, scale, mat, rolling, torsional, bodies, inertia,
                            q, previous, 240.0, eps)
        d.launch(fn, count, [view, f_buf])
        f_mine = force0.copy()
        rolling_contact.evaluate_rolling_contact_force(c, shapes, bodies, inertia, q, previous, 240.0, eps, f_mine)
        f_ref = d.download(f_buf, force0)
        out['rolling_force_'+label] = compare('f', f_ref, f_mine)
        out['rolling_coverage_'+label] = {'bitwise_equal': bool(np.any(f_ref != force0)),
                                          'changed_particles': int(np.any(f_ref != force0, axis=1).sum())}
        b0 = rng.uniform(-1, 1, (n, 9)).astype(F)
        b_buf = d.upload(b0)
        d.launch(d.function(*legacy_ptx('34add_rolling_contact_preconditioner')), count, [view, b_buf])
        b_mine = b0.copy()
        rolling_contact.add_rolling_contact_preconditioner(c, shapes, bodies, inertia, q, previous, 240.0, eps,
                                                           b_mine)
        out['rolling_preconditioner_'+label] = compare('b', d.download(b_buf, b0), b_mine)
        direction = rng.uniform(-1, 1, (n, 3)).astype(F)
        t0 = rng.uniform(-1, 1, (n, 3)).astype(F)
        t_buf = d.upload(t0)
        d.launch(d.function(*legacy_ptx('32multiply_rolling_contact_tangent')), count,
                 [view, d.upload(direction), t_buf])
        t_mine = t0.copy()
        rolling_contact.multiply_rolling_contact_tangent(c, shapes, bodies, inertia, q, previous, 240.0, eps,
                                                         direction, t_mine)
        out['rolling_tangent_'+label] = compare('t', d.download(t_buf, t0), t_mine)
    return out


def run_soft_body_contact(driver, rng):
    """evaluate_soft_contact_force with shapes on affine bodies (P28-P30), static shapes, the per-shape particle
    contact filter (P38) and the velocity-array path. In warp 0 many contacts share one body (atomic order)."""
    d = driver
    out = {}
    count = 512
    n_bodies = 32
    q, indices = random_affine_bodies(rng, n_bodies)
    q[0::4] = rng.uniform(-2, 2, (n_bodies, 3))
    com = rng.uniform(-0.05, 0.05, (n_bodies, 3)).astype(F)
    n_body_particles = len(q)
    shapes = 3*n_bodies
    shape_body = np.repeat(np.arange(n_bodies, dtype=np.int32), 3)
    shape_body[rng.random(shapes) < 0.25] = -1
    shape_type = rng.choice([1, 7, SPHERE], size=shapes).astype(np.int32)
    transform = np.zeros((shapes, 7), F)
    transform[:, :3] = rng.uniform(-0.05, 0.05, (shapes, 3))
    transform[:, 6] = 1
    scale = np.zeros((shapes, 3), F)
    scale[:, 0] = rng.uniform(0.05, 0.3, shapes)
    # Warp w only touches the shapes of bodies 2w and 2w+1 (and static shapes), so every body particle is written by
    # a single warp; across warps the GPU's atomic order is not reproducible (its two block copies differ).
    shape = np.zeros(count, np.int32)
    for i in range(count):
        w = i//32
        own = np.flatnonzero((shape_body == 2*w) | (shape_body == 2*w+1) | ((shape_body < 0) & (np.arange(shapes) % 16 == w)))
        shape[i] = rng.choice(own) if len(own) else rng.integers(0, shapes)
    radius_p = rng.uniform(0.01, 0.05, count).astype(F)
    raw_normal = rng.normal(size=(count, 3)).astype(F)
    unit = raw_normal/np.linalg.norm(raw_normal, axis=1, keepdims=True)
    body_pos = rng.uniform(-0.2, 0.2, (count, 3)).astype(F)
    x = np.zeros((count, 3), F)
    gap = rng.uniform(-0.04, 0.02, count)
    for i in range(count):
        sh = shape[i]
        b = shape_body[sh]
        local = transform[sh, :3].astype(np.float64) if shape_type[sh] == SPHERE else body_pos[i].astype(np.float64)
        if b >= 0:
            t, a0, a1, a2 = (q[j].astype(np.float64) for j in indices[b])
            dl = local-com[b]
            world = t+dl[0]*a0+dl[1]*a1+dl[2]*a2
        else:
            world = local
        extra = scale[sh, 0] if shape_type[sh] == SPHERE else 0
        x[i] = world+unit[i]*(extra+radius_p[i]+gap[i])
    n = n_body_particles+count
    xs = np.concatenate([q, x]).astype(F)
    velocity = rng.normal(scale=1.0, size=(n, 3)).astype(F)
    previous = (xs-velocity/F(400)).astype(F)
    radius = np.concatenate([np.zeros(n_body_particles, F), radius_p])
    mass = np.concatenate([np.ones(n_body_particles, F), rng.uniform(0.01, 1, count).astype(F)])
    flags = np.concatenate([np.ones(n_body_particles, np.int32), np.zeros(count, np.int32)])
    particle = (n_body_particles+np.arange(count)).astype(np.int32)
    particle[16:32] = particle[0:16]                           # two contacts on the same particle (one warp)
    body_vel = rng.normal(scale=0.3, size=(count, 3)).astype(F)
    margin = rng.uniform(0, 0.01, shapes).astype(F)
    materials = [rng.uniform(lo, hi, shapes).astype(F) for lo, hi in ((1e3, 1e5), (0, 50), (1, 2e3), (0, 1))]
    ids = np.arange(n_bodies, dtype=np.int32)
    for label, use_prev, use_filter in (('previous', True, False), ('velocity', False, False),
                                        ('filter', True, True)):
        shape_filter = (rng.random(shapes) < 0.6).astype(np.int32) if use_filter else None
        c = SoftContactInputs(
            count=count, particle=particle, shape=shape, body_pos=body_pos, body_vel=body_vel, normal=raw_normal,
            radius=radius, mass=mass, shape_body=shape_body, shape_type=shape_type, shape_position=transform[:, :3],
            shape_scale=scale, shape_margin=margin, shape_ke=materials[0], shape_kd=materials[1],
            shape_kf=materials[2], shape_mu=materials[3], ke=5e4, kd=30.0, kf=1e3, mu=0.6, x=xs,
            previous=previous if use_prev else None, inv_dt=F(400), particle_flags=flags, body_ids=ids,
            body_indices=indices, body_com=com, velocity=velocity, shape_filter=shape_filter)
        force0 = rng.uniform(-1, 1, (n, 3)).astype(F)
        scalar0 = rng.uniform(0, 1, n).astype(F)
        block0 = rng.uniform(-1, 1, (n, 3, 3)).astype(F)
        bufs = [d.upload(force0), d.upload(scalar0), d.upload(block0), d.upload(block0)]
        d.launch(d.function(*legacy_ptx('27evaluate_soft_contact_force')), count, [
            d.upload(np.array([count], np.int32)), u64(count), d.upload(particle), d.upload(shape),
            d.upload(body_pos), d.upload(body_vel), d.upload(raw_normal), d.upload(radius), d.upload(mass),
            d.upload(flags), u64(n), u64(n), d.upload(shape_body), d.upload(shape_type), d.upload(transform),
            d.upload(scale), d.upload(margin), d.upload(materials[0]), d.upload(materials[1]), d.upload(materials[2]),
            d.upload(materials[3]), u64(shapes), u64(shapes), u64(1), f32(5e4), f32(30.0), f32(1e3), f32(0.6),
            d.upload(ids), d.upload(indices), d.upload(com), u64(n_bodies), d.upload(xs), d.upload(velocity),
            d.upload(previous) if use_prev else null(), f32(400), bufs[0], bufs[1],
            d.upload(shape_filter) if use_filter else null(), u64(shapes), bufs[2], bufs[3]])
        mine = soft_contact_kernel(c, force0.copy(), scalar0.copy(), block0.copy())
        ref = [d.download(bufs[0], force0), d.download(bufs[1], scalar0), d.download(bufs[2], block0)]
        for key, a, b in zip(('force', 'scalar', 'block'), ref, mine):
            out[f'soft_body_{key}_{label}'] = compare(key, a, b)
        out[f'soft_body_copy_{label}'] = compare('copy', ref[2], d.download(bufs[3], block0))
        if use_prev:
            # multiply_soft_contact_hessian_off_diagonal (the host always passes previous positions).
            direction = rng.uniform(-1, 1, (n, 3)).astype(F)
            t0 = rng.uniform(-1, 1, (n, 3)).astype(F)
            t_buf = d.upload(t0)
            d.launch(d.function(*legacy_ptx('42multiply_soft_contact_hessian_off_diagonal')), count, [
                d.upload(np.array([count], np.int32)), u64(count), d.upload(particle), d.upload(shape),
                d.upload(body_pos), d.upload(raw_normal), d.upload(radius), d.upload(shape_body),
                d.upload(shape_type), d.upload(transform), d.upload(scale), d.upload(mass), d.upload(flags),
                d.upload(margin), d.upload(materials[0]), d.upload(materials[1]), u64(shapes), u64(shapes), u64(1),
                d.upload(ids), d.upload(indices), d.upload(com), u64(n_bodies), d.upload(xs), d.upload(direction),
                t_buf, f32(400), u64(n), f32(5e4), f32(30.0), u64(n),
                d.upload(shape_filter) if use_filter else null(), u64(shapes), d.upload(materials[2]),
                d.upload(materials[3]), f32(1e3), f32(0.6), d.upload(body_vel), d.upload(previous)])
            t_mine = soft_contact_offdiag(c, direction, t0.copy())
            out[f'soft_offdiag_{label}'] = compare('t', d.download(t_buf, t0), t_mine)
        changed = np.any(ref[0][:n_body_particles] != force0[:n_body_particles], axis=1)
        out[f'soft_body_coverage_{label}'] = {'bitwise_equal': bool(changed.any()),
                                              'body_particles_hit': int(changed.sum())}
    return out


def run_joint_springs(driver, rng):
    """evaluate_joint_body_spring_augmented_lagrangian_force and update_joint_body_spring_augmented_lagrangian_state
    on random joint springs (world and body ends); warp 0 shares bodies, other warps use their own bodies."""
    from .joints import Springs
    d = driver
    out = {}
    count, n_bodies = 60, 48
    q, indices = random_affine_bodies(rng, n_bodies)
    q[0::4] = rng.uniform(-1, 1, (n_bodies, 3))
    com = rng.uniform(-0.05, 0.05, (n_bodies, 3)).astype(F)
    # Joint thread t handles spring t+plain: threads 0-31 (warp 0) share bodies 0-3, every later thread owns a
    # distinct body pair (bodies shared across warps would make the GPU's atomic order nondeterministic).
    pairs = np.zeros((count, 2), np.int32)
    for t in range(count-6):
        s_ = t+6
        if t < 32:
            pairs[s_] = rng.choice(4, 2, replace=False)
        else:
            pairs[s_] = (4+2*(t-32), 5+2*(t-32))
        if t % 5 == 0:
            pairs[s_, rng.integers(2)] = -1
    pairs[:6] = (0, 1)
    plain = 6                                        # leading plain springs (skipped by the joint kernels)
    points0 = rng.uniform(-0.2, 0.2, (count, 3)).astype(F)
    points1 = rng.uniform(-0.2, 0.2, (count, 3)).astype(F)
    k = rng.uniform(0.001, 0.1, count).astype(F)
    springs = Springs(pairs, points0, points1, k, np.zeros(count, F), count-plain, indices, com)
    springs.multiplier = rng.normal(scale=0.01, size=(count-plain, 3)).astype(F)
    lam0 = springs.multiplier.copy()
    force0 = rng.uniform(-1, 1, q.shape).astype(F)
    f_buf, l_buf = d.upload(force0), d.upload(lam0)
    common = [d.upload(q), d.upload(indices), d.upload(pairs), d.upload(points0), d.upload(points1),
              d.upload(springs.w0), d.upload(springs.w1)]
    d.launch(d.function(*legacy_ptx('53evaluate_joint_body_spring_augmented_lagrangian_force')), count-plain,
             common+[d.upload(k), l_buf, f32(5759999.0), f_buf, u64(count-plain), u64(count), u64(count-plain),
                     u64(len(q))])
    mine = force0.copy()
    springs.joint_force(q, F(5759999.0), mine)
    out['joint_spring_force'] = compare('f', d.download(f_buf, force0), mine)
    d.launch(d.function(*legacy_ptx('51update_joint_body_spring_augmented_lagrangian_state')), count-plain,
             common+[l_buf, u64(count-plain), u64(count), u64(count-plain), u64(len(q))])
    springs.update_state(q)
    out['joint_spring_update'] = compare('l', d.download(l_buf, lam0), springs.multiplier)
    # evaluate_body_spring_force over all springs (one thread each): warp 0 shares bodies 0-3, later warps own
    # distinct body pairs; nonzero rest lengths, world ends, a zero-length spring; joint springs at the end.
    count2, joints2 = 54, 15
    pairs2 = np.zeros((count2, 2), np.int32)
    for t in range(count2):
        pairs2[t] = rng.choice(4, 2, replace=False) if t < 32 else (4+2*(t-32), 5+2*(t-32))
        if t % 6 == 1:
            pairs2[t, rng.integers(2)] = -1
    p0 = rng.uniform(-0.2, 0.2, (count2, 3)).astype(F)
    p1 = rng.uniform(-0.2, 0.2, (count2, 3)).astype(F)
    pairs2[7] = (-1, -1)
    p1[7] = p0[7]
    k2 = rng.uniform(0.001, 0.1, count2).astype(F)
    rest2 = rng.uniform(0, 0.3, count2).astype(F)
    plain_springs = Springs(pairs2, p0, p1, k2, rest2, joints2, indices, com)
    for flag in (False, True):
        f_buf = d.upload(force0)
        d.launch(d.function(*legacy_ptx('26evaluate_body_spring_force')), count2,
                 [d.upload(q), d.upload(indices), d.upload(pairs2), d.upload(p0), d.upload(p1),
                  d.upload(plain_springs.w0), d.upload(plain_springs.w1), d.upload(k2), d.upload(rest2),
                  f32(100.0), u64(joints2), ctypes.c_bool(flag), f_buf, u64(count2), u64(count2), u64(len(q))])
        mine = force0.copy()
        plain_springs.plain_force(q, F(100.0), flag, mine)
        out[f'body_spring_force_{flag}'] = compare('f', d.download(f_buf, force0), mine)
    # add_body_spring_gauss_newton_hessian: dense coupling ELL over the bodies of each spring; some springs with
    # rest <= 0 or k <= 0 (skipped).
    rest3 = rest2.copy()
    rest3[rng.random(count2) < 0.15] = 0
    k3 = k2.copy()
    k3[5] = 0
    hs = Springs(pairs2, p0, p1, k3, rest3, joints2, indices, com)
    n = len(q)
    coupled = [set() for _ in range(n)]
    for a, b in pairs2:
        parts = (list(indices[a]) if a >= 0 else [])+(list(indices[b]) if b >= 0 else [])
        for i in parts:
            coupled[i].update(j for j in parts if j != i)
    row_nnz = np.array([len(c) for c in coupled], np.int32)
    max_nnz = int(row_nnz.max())
    cols = np.full((max_nnz, n), -1, np.int32)
    for r in range(n):
        cols[:row_nnz[r], r] = sorted(coupled[r])
    blocks = rng.uniform(-1, 1, (max_nnz, n, 9)).astype(F)
    diag0 = rng.uniform(-1, 1, (n, 9)).astype(F)
    raw = np.zeros((max_nnz, n, 10), np.uint32)
    raw[..., 0] = cols.view(np.uint32)
    raw[..., 1:] = blocks.view(np.uint32)
    e_buf, dg_buf = d.upload(raw), d.upload(diag0)
    d.launch(d.function(*legacy_ptx('36add_body_spring_gauss_newton_hessian')), count2,
             [d.upload(q), d.upload(indices), d.upload(pairs2), d.upload(p0), d.upload(p1), d.upload(hs.w0),
              d.upload(hs.w1), d.upload(k3), d.upload(rest3), dg_buf, d.upload(row_nnz), e_buf, u64(max_nnz),
              u64(count2), u64(count2), u64(n), u64(n)])
    dg_mine, b_mine = diag0.copy(), blocks.copy()
    hs.add_gauss_newton_hessian(q, dg_mine, (row_nnz, cols, b_mine, max_nnz))
    out['body_spring_hessian_diag'] = compare('d', d.download(dg_buf, diag0), dg_mine)
    out['body_spring_hessian_ell'] = compare('b', d.download(e_buf, raw)[..., 1:].copy().view(F), b_mine)
    # Body distance constraints: state init, AL force, state update (same body layout as the plain springs).
    from .joints import DistanceConstraints
    w0 = rng.uniform(-0.3, 1.2, (count2, 4)).astype(F)
    w1 = rng.uniform(-0.3, 1.2, (count2, 4)).astype(F)
    rest_dc = rng.uniform(0, 0.4, count2).astype(F)
    rest_dc[rng.random(count2) < 0.15] = 0
    p1[9] = p0[9]
    pairs3 = pairs2.copy()
    pairs3[9] = (-1, -1)
    scale_dc = rng.uniform(0.1, 3, count2).astype(F)
    dc = DistanceConstraints(pairs3, p0, p1, w0, w1, rest_dc, scale_dc, indices)
    geo = [d.upload(q), d.upload(indices), d.upload(pairs3), d.upload(p0), d.upload(p1), d.upload(w0), d.upload(w1)]
    sizes = [u64(count2), u64(count2), u64(len(q))]
    t_buf, l_buf = d.upload(np.ones((count2, 3), F)), d.upload(np.ones((count2, 3), F))
    d.launch(d.function(*legacy_ptx('41initialize_body_distance_constraint_state')), count2,
             geo+[d.upload(rest_dc), t_buf, l_buf]+sizes)
    dc.initialize_state(q)
    out['distance_init_target'] = compare('r', d.download(t_buf, dc.target), dc.target)
    out['distance_init_lambda'] = compare('l', d.download(l_buf, dc.multiplier), dc.multiplier)
    dc.multiplier = rng.normal(scale=0.02, size=(count2, 3)).astype(F)
    dc.target[rng.random(count2) < 0.2] = 0
    f_buf = d.upload(force0)
    d.launch(d.function(*legacy_ptx('39evaluate_body_distance_constraint_force')), count2,
             geo+[d.upload(scale_dc), d.upload(dc.target), d.upload(dc.multiplier), f32(5759999.0), f_buf]+sizes)
    mine = force0.copy()
    dc.force(q, F(5759999.0), mine)
    out['distance_force'] = compare('f', d.download(f_buf, force0), mine)
    t_buf, l_buf = d.upload(dc.target), d.upload(dc.multiplier)
    d.launch(d.function(*legacy_ptx('37update_body_distance_constraint_state')), count2,
             geo+[d.upload(rest_dc), t_buf, l_buf]+sizes)
    dc.update_state(q)
    out['distance_update_target'] = compare('r', d.download(t_buf, dc.target), dc.target)
    out['distance_update_lambda'] = compare('l', d.download(l_buf, dc.multiplier), dc.multiplier)
    return out


def run_joint_drives(driver, rng):
    """evaluate_joint_drive_load (angular drives) with every target mode, effort clamping, the angle-state branch
    (stored unwrapped angles) and world parents; warp 0 shares bodies, later drives own theirs."""
    from .joints import (Drives, add_joint_drive_preconditioner, evaluate_joint_drive_load,
                         multiply_joint_drive_tangent, update_joint_drive_angle_state,
                         evaluate_angular_limits, evaluate_joint_armature)
    d = driver
    out = {}
    count, n_bodies = 48, 4+2*16
    q, indices = random_affine_bodies(rng, n_bodies)
    q[0::4] = rng.uniform(-1, 1, (n_bodies, 3))
    com = rng.uniform(-0.05, 0.05, (n_bodies, 3)).astype(F)
    previous = (q+rng.normal(scale=3e-3, size=q.shape)).astype(F)
    pairs = np.zeros((count, 2), np.int32)
    for i in range(count):
        pairs[i] = rng.choice(4, 2, replace=False) if i < 32 else (4+2*(i-32), 5+2*(i-32))
        if i % 6 == 0:
            pairs[i, 0] = -1
    pts = lambda: rng.uniform(-0.2, 0.2, (count, 3)).astype(F)
    po, co = pts(), pts()
    axis = rng.normal(size=(count, 3)).astype(F)
    pa = (po+0.1*axis/np.linalg.norm(axis, axis=1, keepdims=True)).astype(F)
    pr, cr = pts(), pts()
    dof = rng.permutation(count).astype(np.int32)
    target = rng.permutation(count).astype(np.int32)
    types = np.ones(count, np.int32)
    types[2::5] = 0                                       # prismatic drives
    drives = Drives(pairs, types, po, pa, pr, co, cr, dof, target, indices, com)
    qd = rng.normal(size=count).astype(F)
    angle0 = rng.uniform(-20, 20, count).astype(F)
    init0 = (rng.random(count) < 0.5).astype(np.int32)
    ke = rng.uniform(0, 500, count).astype(F)
    kd = rng.uniform(0, 20, count).astype(F)
    effort = np.where(rng.random(count) < 0.3, rng.uniform(0.1, 2, count), 1e6).astype(F)
    modes = rng.integers(0, 5, count).astype(np.int32)
    damping = rng.uniform(0, 3, count).astype(F)
    feed = rng.normal(size=count).astype(F)
    tq, tqd = rng.uniform(-3, 3, count).astype(F), rng.normal(size=count).astype(F)
    force0 = rng.uniform(-1, 1, q.shape).astype(F)
    for label, use_modes, use_damping in (('modes', True, True), ('nomodes', False, False)):
        f_buf, a_buf, i_buf = d.upload(force0), d.upload(angle0), d.upload(init0)
        up = d.upload
        d.launch(d.function(*legacy_ptx('25evaluate_joint_drive_load')), count, [
            up(q), up(previous), up(qd), a_buf, i_buf, up(indices), up(drives.types), up(pairs), up(po), up(pa),
            up(pr), up(drives.w_po), up(drives.w_co), up(drives.w_pa), up(drives.w_pr), up(drives.w_cr), up(dof),
            up(target), up(ke), up(kd), up(effort), up(modes) if use_modes else null(),
            up(damping) if use_damping else null(), up(feed), up(tq), up(tqd), f_buf, u64(count), u64(count),
            u64(len(q)), u64(count), u64(count), f32(240.0)])
        f_mine, a_mine, i_mine = force0.copy(), angle0.copy(), init0.copy()
        evaluate_joint_drive_load(drives, q, previous, qd, a_mine, i_mine, ke, kd, effort,
                                  modes if use_modes else None, damping if use_damping else None, feed, tq, tqd,
                                  240.0, f_mine)
        out['drive_load_'+label] = compare('f', d.download(f_buf, force0), f_mine)
        out['drive_angle_'+label] = compare('a', d.download(a_buf, angle0), a_mine)
        out['drive_init_'+label] = compare('i', d.download(i_buf, init0).view(F), i_mine.view(F))
        geometry = [up(pairs), up(po), up(pa), up(pr), up(drives.w_po), up(drives.w_co), up(drives.w_pa),
                    up(drives.w_pr), up(drives.w_cr), up(dof), up(modes) if use_modes else null(),
                    up(damping) if use_damping else null(), up(kd), f32(240.0)]
        b0 = rng.uniform(-1, 1, (len(q), 9)).astype(F)
        b_buf = d.upload(b0)
        d.launch(d.function(*legacy_ptx('30add_joint_drive_preconditioner')), count,
                 [up(q), up(indices), up(drives.types)]+geometry+[b_buf, u64(count), u64(count), u64(len(q))])
        b_mine = b0.copy()
        add_joint_drive_preconditioner(drives, q, kd, damping if use_damping else None,
                                       modes if use_modes else None, 240.0, b_mine)
        out['drive_preconditioner_'+label] = compare('b', d.download(b_buf, b0), b_mine)
        direction = rng.uniform(-1, 1, q.shape).astype(F)
        t_buf = d.upload(force0)
        d.launch(d.function(*legacy_ptx('28multiply_joint_drive_tangent')), count,
                 [up(q), up(direction), up(indices), up(drives.types)]+geometry+[t_buf, u64(count), u64(count),
                                                                               u64(len(q))])
        t_mine = force0.copy()
        multiply_joint_drive_tangent(drives, q, kd, damping if use_damping else None, modes if use_modes else None,
                                     240.0, direction, t_mine)
        out['drive_tangent_'+label] = compare('t', d.download(t_buf, force0), t_mine)
    # evaluate_angular_limits in its three modes; JointCoordinateView (120 B) and AngularLimitView (32 B) by value.
    lower = np.where(rng.random(count) < 0.5, rng.uniform(-1, 0.5, count), -1e10).astype(F)
    upper = np.where(rng.random(count) < 0.5, rng.uniform(-0.5, 1, count), 1e10).astype(F)
    lke = np.where(rng.random(count) < 0.1, 0, rng.uniform(0, 1e3, count)).astype(F)
    lkd = np.where(rng.random(count) < 0.1, 0, rng.uniform(0, 10, count)).astype(F)
    words = [up(indices).value, up(drives.types).value, up(pairs).value, up(po).value, up(pa).value, up(pr).value,
             up(drives.w_po).value, up(drives.w_co).value, up(drives.w_pa).value, up(drives.w_pr).value,
             up(drives.w_cr).value, up(dof).value, count, count, len(q)]
    jview = (ctypes.c_char*120).from_buffer_copy(struct.pack('<15Q', *[int(w) for w in words]))
    lview = (ctypes.c_char*32).from_buffer_copy(struct.pack('<4Q', up(lower).value, up(upper).value, up(lke).value,
                                                             up(lkd).value))
    limits = d.function(*legacy_ptx('23evaluate_angular_limits'))
    direction = rng.uniform(-1, 1, q.shape).astype(F)
    for label, use_dir, use_block in (('force', False, False), ('tangent', True, False), ('precond', False, True)):
        f0 = rng.uniform(-1, 1, q.shape).astype(F)
        b0 = rng.uniform(-1, 1, (len(q), 9)).astype(F)
        f_buf, b_buf = d.upload(f0), d.upload(b0)
        d.launch(limits, count, [jview, lview, up(q), up(previous), up(angle0), up(init0), f32(240.0),
                                 up(direction) if use_dir else null(), null() if use_block else f_buf,
                                 b_buf if use_block else null()])
        f_mine, b_mine = f0.copy(), b0.copy()
        evaluate_angular_limits(drives, q, previous, angle0, init0, lower, upper, lke, lkd, 240.0,
                                direction=direction if use_dir else None, force=None if use_block else f_mine,
                                block=b_mine if use_block else None)
        if use_block:
            out['limits_'+label] = compare('b', d.download(b_buf, b0), b_mine)
        else:
            out['limits_'+label] = compare('f', d.download(f_buf, f0), f_mine)
    # evaluate_joint_armature (both joint types) in its three modes.
    armature = np.where(rng.random(count) < 0.15, 0, rng.uniform(0.001, 0.1, count)).astype(F)
    arm = d.function(*legacy_ptx('23evaluate_joint_armature'))
    for label, use_dir, use_block in (('force', False, False), ('tangent', True, False), ('precond', False, True)):
        f0 = rng.uniform(-1, 1, q.shape).astype(F)
        b0 = rng.uniform(-1, 1, (len(q), 9)).astype(F)
        f_buf, b_buf = d.upload(f0), d.upload(b0)
        d.launch(arm, count, [jview, up(armature), up(q), up(previous), up(qd), f32(240.0),
                              up(direction) if use_dir else null(), null() if use_block else f_buf,
                              b_buf if use_block else null()])
        f_mine, b_mine = f0.copy(), b0.copy()
        evaluate_joint_armature(drives, armature, q, previous, qd, 240.0, direction=direction if use_dir else None,
                                force=None if use_block else f_mine, block=b_mine if use_block else None)
        if use_block:
            out['armature_'+label] = compare('b', d.download(b_buf, b0), b_mine)
        else:
            out['armature_'+label] = compare('f', d.download(f_buf, f0), f_mine)
    from .joints import initialize_joint_coordinate_velocities
    vel = rng.normal(size=q.shape).astype(F)
    o_buf = d.upload(np.full(count, F(7)))
    d.launch(d.function(*legacy_ptx('38initialize_joint_coordinate_velocities')), count, [jview, up(q), up(vel), o_buf])
    out['joint_coordinate_velocities'] = compare('qd', d.download(o_buf, np.zeros(count, F)),
                                                 initialize_joint_coordinate_velocities(drives, q, vel))
    from .joints import reset_selected_joint_drive_state
    mask = rng.integers(-1, 2, count).astype(np.int32)
    flags0 = rng.integers(0, 3, count).astype(np.int32)
    f_buf = d.upload(flags0)
    d.launch(d.function(*legacy_ptx('32reset_selected_joint_drive_state')), count, [up(mask), f_buf, u64(count)])
    f_mine = flags0.copy()
    reset_selected_joint_drive_state(mask, f_mine)
    out['reset_selected_joint_drive_state'] = {'bitwise_equal': bool(np.array_equal(d.download(f_buf, flags0), f_mine))}
    a_buf, i_buf = d.upload(angle0), d.upload(init0)
    d.launch(d.function(*legacy_ptx('30update_joint_drive_angle_state')), count, [
        up(q), a_buf, i_buf, up(indices), up(drives.types), up(pairs), up(po), up(pa), up(pr), up(drives.w_po),
        up(drives.w_co), up(drives.w_pa), up(drives.w_pr), up(drives.w_cr), u64(count), u64(count), u64(len(q))])
    a_mine, i_mine = angle0.copy(), init0.copy()
    update_joint_drive_angle_state(drives, q, a_mine, i_mine)
    out['drive_angle_update'] = compare('a', d.download(a_buf, angle0), a_mine)
    out['drive_init_update'] = compare('i', d.download(i_buf, init0).view(F), i_mine.view(F))
    return out


def run_joint_drive_branches(driver, rng):
    """Drive diagonal/tangent guards, world offsets and a partially filled last world; bodies are disjoint."""
    import copy
    from .joints import Drives, add_joint_drive_preconditioner, multiply_joint_drive_tangent
    d, out = driver, {}
    per_world, worlds = 32, 3
    count, bodies = 2*per_world+15, 2*per_world
    particles = 4*bodies
    indices = np.arange(particles, dtype=np.int32).reshape(-1, 4)
    positions = np.zeros((worlds, particles, 3), F)
    for world in range(worlds):
        positions[world, 0::4] = rng.uniform(-0.5, 0.5, (bodies, 3))
        for axis in range(3):
            positions[world, axis+1::4, axis] = 1
    pairs = np.arange(bodies, dtype=np.int32).reshape(-1, 2)
    types = np.repeat(np.array([0, 1], np.int32), 16)
    points = lambda: rng.uniform(-0.2, 0.2, (per_world, 3)).astype(F)
    po, co, pr, cr = points(), points(), points(), points()
    pa = (po+np.array([0.1, 0.2, 0.3], F)).astype(F)
    dofs = rng.permutation(per_world).astype(np.int32)
    kd = rng.uniform(0.2, 3, per_world).astype(F)
    damping = np.zeros(per_world, F)
    modes = np.full(per_world, 3, np.int32)
    scenarios = ('parent', 'world', 'zero_axis', 'tiny_axis', 'threshold_axis', 'above_threshold_axis',
                 'parallel_parent_reference', 'zero_child_reference', 'disabled_mode', 'negative_scale',
                 'nan_scale', 'infinite_scale', 'passive_disabled_mode', 'negative_mode', 'passive_only', 'mode_one')
    for i in range(per_world):
        case = i % 16
        if case in (1, 2, 3, 4, 5, 6, 7):
            pairs[i, 0] = -1
            po[i] = 0
        if case in (2, 3, 4, 5):
            length = (0, F(1e-10), F(1e-8), np.nextafter(F(1e-8), F(np.inf)))[case-2]
            pa[i] = (length, 0, 0)
        if case == 6:
            pr[i] = pa[i]
        if case == 7:
            cr[i] = co[i]
        if case == 8:
            modes[dofs[i]] = 0
        if case in (9, 10, 11):
            kd[dofs[i]] = (-1, np.nan, np.inf)[case-9]
        if case == 12:
            modes[dofs[i]], damping[dofs[i]] = 4, F(0.7)
        if case == 13:
            modes[dofs[i]] = -1
        if case == 14:
            kd[dofs[i]], damping[dofs[i]] = 0, F(0.8)
        if case == 15:
            modes[dofs[i]] = 1
    drives = Drives(pairs, types, po, pa, pr, co, cr, dofs, dofs, indices, np.zeros((bodies, 3), F))
    flat = positions.reshape(-1, 3)
    direction = rng.uniform(-2, 2, flat.shape).astype(F)
    initial_block = rng.uniform(-1, 1, (len(flat), 9)).astype(F)
    initial_product = rng.uniform(-1, 1, flat.shape).astype(F)
    up = d.upload
    geometry = [up(pairs), up(po), up(pa), up(pr), up(drives.w_po), up(drives.w_co), up(drives.w_pa),
                up(drives.w_pr), up(drives.w_cr), up(dofs), up(modes), up(damping), up(kd), f32(240)]
    block_buffer, product_buffer = up(initial_block), up(initial_product)
    sizes = [u64(count), u64(per_world), u64(particles)]
    d.launch(d.function(*legacy_ptx('30add_joint_drive_preconditioner')), count,
             [up(flat), up(indices), up(types)]+geometry+[block_buffer]+sizes)
    d.launch(d.function(*legacy_ptx('28multiply_joint_drive_tangent')), count,
             [up(flat), up(direction), up(indices), up(types)]+geometry+[product_buffer]+sizes)
    expected_block, expected_product = initial_block.copy(), initial_product.copy()
    for world in range(worlds):
        local = copy.copy(drives)
        local.pairs = drives.pairs[:min(per_world, count-world*per_world)]
        start, end = world*particles, (world+1)*particles
        with np.errstate(all='ignore'):
            add_joint_drive_preconditioner(local, positions[world], kd, damping, modes, 240,
                                           expected_block[start:end])
            multiply_joint_drive_tangent(local, positions[world], kd, damping, modes, 240,
                                         direction[start:end], expected_product[start:end])
    actual_block = d.download(block_buffer, initial_block)
    actual_product = d.download(product_buffer, initial_product)
    out['branches_preconditioner'] = compare('b', actual_block, expected_block)
    out['branches_tangent'] = compare('t', actual_product, expected_product)
    # The velocity kernel rejects physical axis lengths <= 1e-8; drive damping instead tests the normalized
    # axis. Use the legacy GPU directly for these boundary cases, keeping the frozen NumPy spec unchanged.
    from .csrc.ptx_compare import LEGACY_PTX
    if hashlib.sha256(LEGACY.read_bytes()).hexdigest() != LEGACY_SHA:
        raise RuntimeError('Unexpected legacy library hash')
    velocity_ptx, velocity_name = legacy_ptx('38initialize_joint_coordinate_velocities')
    original_ptx = next(path.read_text() for path in sorted(LEGACY_PTX.glob('*.ptx'))
                        if velocity_name in path.read_text())
    words = [up(indices).value, up(types).value, up(pairs).value, up(po).value, up(pa).value, up(pr).value,
             up(drives.w_po).value, up(drives.w_co).value, up(drives.w_pa).value, up(drives.w_pr).value,
             up(drives.w_cr).value, up(dofs).value, per_world, count, particles]
    view = (ctypes.c_char*120).from_buffer_copy(struct.pack('<15Q', *words))
    initial_velocity = np.full(count+5, F(7))
    velocities = []
    for module in (original_ptx, velocity_ptx):
        result = up(initial_velocity)
        d.launch(d.function(module, velocity_name), count, [view, up(flat), up(direction), result])
        velocities.append(d.download(result, initial_velocity))
    out['branches_coordinate_velocity'] = compare('qd', velocities[0], velocities[1])
    out['branches_coordinate_velocity_tail'] = compare('qd', velocities[1][count:], initial_velocity[count:])
    for label, field, exceptional in (('infinite_axis', 4, np.inf), ('nan_axis', 4, np.nan),
                                       ('infinite_reference', 5, np.inf), ('infinite_velocity', None, np.inf)):
        exceptional_words = words.copy()
        exceptional_direction = direction.copy()
        if field is None:
            exceptional_direction[[1, 17], 0] = exceptional
        else:
            data = (pa if field == 4 else pr).copy()
            data[[1, 17], 0] = exceptional
            exceptional_words[field] = up(data).value
        exceptional_view = (ctypes.c_char*120).from_buffer_copy(struct.pack('<15Q', *exceptional_words))
        velocities = []
        for module in (original_ptx, velocity_ptx):
            result = up(initial_velocity)
            d.launch(d.function(module, velocity_name), count,
                     [exceptional_view, up(flat), up(exceptional_direction), result])
            velocities.append(d.download(result, initial_velocity))
        out['branches_coordinate_velocity_'+label] = compare('qd', velocities[0], velocities[1])
    for i, label in enumerate(scenarios):
        # The second world contains both types of every scenario, including the last angular lane.
        body_ids = (2*i, 2*i+1, 2*(i+16), 2*(i+16)+1)
        selected = np.concatenate([indices[body]+particles for body in body_ids])
        out['branches_'+label+'_preconditioner'] = compare('b', actual_block[selected], expected_block[selected])
        out['branches_'+label+'_tangent'] = compare('t', actual_product[selected], expected_product[selected])
    return out


def run_joint_armature_branches(driver, rng):
    """Direct legacy/source checks of armature modes, sparse final world, guards and wrapped angular deltas."""
    from .joints import Drives
    from .csrc.ptx_compare import LEGACY_PTX
    d, out = driver, {}
    per_world, worlds, count = 32, 3, 79
    particles = 8*per_world
    indices = np.arange(particles, dtype=np.int32).reshape(-1, 4)
    pairs = np.arange(2*per_world, dtype=np.int32).reshape(-1, 2)
    types = np.repeat(np.array([0, 1], np.int32), 16)
    points = lambda: rng.uniform(-0.2, 0.2, (per_world, 3)).astype(F)
    po, co, pr, cr = points(), points(), points(), points()
    pa = (po+np.array([0.1, 0.2, 0.3], F)).astype(F)
    positions = np.zeros((worlds, particles, 3), F)
    for world in range(worlds):
        positions[world, 0::4] = rng.uniform(-0.5, 0.5, (2*per_world, 3))
        for axis in range(3):
            positions[world, axis+1::4, axis] = 1
    previous = (positions+rng.normal(scale=0.002, size=positions.shape)).astype(F)
    dofs = rng.permutation(per_world).astype(np.int32)
    armature = rng.uniform(0.01, 0.1, per_world).astype(F)
    qd = rng.uniform(-10, 10, worlds*per_world).astype(F)
    scenarios = ('parent', 'world', 'zero_axis', 'tiny_axis', 'threshold_axis', 'above_threshold_axis',
                 'parallel_parent_reference', 'zero_child_reference', 'invalid_previous', 'zero_armature',
                 'negative_armature', 'nan_armature', 'infinite_armature', 'nan_velocity', 'half_turn', 'many_turns')
    for joint in range(per_world):
        case = joint % 16
        if case in range(1, 8):
            pairs[joint, 0] = -1
            po[joint] = 0
        if case in (2, 3, 4, 5):
            pa[joint] = ((0, F(1e-10), F(1e-8), np.nextafter(F(1e-8), F(np.inf)))[case-2], 0, 0)
        if case == 6:
            pr[joint] = pa[joint]
        if case == 7:
            cr[joint] = co[joint]
        if case == 8:
            previous[:, indices[pairs[joint, 0]][1:]] = 0
        if case in (9, 10, 11, 12):
            armature[dofs[joint]] = (0, -1, np.nan, np.inf)[case-9]
        if case == 13:
            qd[joint::per_world] = np.nan
        if case in (14, 15):
            for body in pairs[joint]:
                previous[:, indices[body]] = positions[:, indices[body]]
            delta = F(np.pi if case == 14 else -9*np.pi)
            qd[joint::per_world] = F(delta*F(240))
    drives = Drives(pairs, types, po, pa, pr, co, cr, dofs, dofs, indices, np.zeros((2*per_world, 3), F))
    up = d.upload
    words = [up(indices).value, up(types).value, up(pairs).value, up(po).value, up(pa).value, up(pr).value,
             up(drives.w_po).value, up(drives.w_co).value, up(drives.w_pa).value, up(drives.w_pr).value,
             up(drives.w_cr).value, up(dofs).value, per_world, count, particles]
    view = (ctypes.c_char*120).from_buffer_copy(struct.pack('<15Q', *words))
    if hashlib.sha256(LEGACY.read_bytes()).hexdigest() != LEGACY_SHA:
        raise RuntimeError('Unexpected legacy library hash')
    selected_ptx, name = legacy_ptx('23evaluate_joint_armature')
    original_ptx = next(path.read_text() for path in sorted(LEGACY_PTX.glob('*.ptx')) if name in path.read_text())
    functions = [d.function(module, name) for module in (original_ptx, selected_ptx)]
    initial_force = rng.uniform(-1, 1, (worlds*particles+5, 3)).astype(F)
    initial_block = rng.uniform(-1, 1, (worlds*particles+5, 9)).astype(F)
    direction = rng.uniform(-2, 2, (worlds*particles, 3)).astype(F)
    for mode, inverse_dt in (('force', 240), ('tangent', 240), ('block', 240), ('block_priority', 240),
                             ('force', 0), ('tangent', 0), ('block', 0), ('force', -240)):
        outputs = []
        for fun in functions:
            force_buffer, block_buffer = up(initial_force), up(initial_block)
            args = [view, up(armature), up(positions.reshape(-1, 3)),
                    up(previous.reshape(-1, 3)) if mode == 'force' else null(), up(qd) if mode == 'force' else null(),
                    f32(inverse_dt), up(direction) if mode in ('tangent', 'block_priority') else null(),
                    force_buffer, block_buffer if mode.startswith('block') else null()]
            d.launch(fun, count, args)
            outputs.append((d.download(force_buffer, initial_force), d.download(block_buffer, initial_block)))
        label = f'armature_branches_{mode}_{inverse_dt}'
        for index, field in enumerate(('force', 'block')):
            out[label+'_'+field] = compare(field, outputs[0][index], outputs[1][index])
            out[label+'_'+field+'_tail'] = compare(field, outputs[1][index][-5:],
                                                   (initial_force, initial_block)[index][-5:])
        if inverse_dt == 240:
            for case, scenario in enumerate(scenarios):
                selected = np.concatenate([indices[body]+particles for joint in (case, case+16)
                                            for body in (2*joint, 2*joint+1)])
                field = 1 if mode.startswith('block') else 0
                out[label+'_'+scenario] = compare('output', outputs[0][field][selected], outputs[1][field][selected])
    return out


def run_joint_limit_branches(driver, rng):
    """Direct angular-stop GPU checks, including activation, state selection and exceptional inputs."""
    from .joints import Drives
    from .csrc.ptx_compare import LEGACY_PTX
    d, out = driver, {}
    per_world, worlds, count = 32, 3, 79
    particles = 8*per_world
    indices = np.arange(particles, dtype=np.int32).reshape(-1, 4)
    pairs = np.arange(2*per_world, dtype=np.int32).reshape(-1, 2)
    pairs[1::4, 0] = -1
    pairs[17, 0] = 34
    types = np.ones(per_world, np.int32)
    types[[12, 13, 14]] = (0, 2, -1)
    po = np.zeros((per_world, 3), F)
    pa = np.tile(np.array([0, 0, 1], F), (per_world, 1))
    pr = np.tile(np.array([1, 0, 0], F), (per_world, 1))
    co, cr = po.copy(), pr.copy()
    positions = np.zeros((worlds, particles, 3), F)
    for world in range(worlds):
        positions[world, 0::4] = F(world*0.25)
        for axis in range(3):
            positions[world, axis+1::4, axis] = 1
    # Exact quarter-turn geometry gives a normal-valued, adjacent-float limit boundary.
    for joint in (5, 6):
        positions[:, indices[pairs[joint, 1]][1:]] = np.array([[0, 1, 0], [-1, 0, 0], [0, 0, 1]], F)
    previous = positions.copy()
    for joint in (15,):
        previous[:, indices[pairs[joint, 1]][1:]] = np.array([[0, 1, 0], [-1, 0, 0], [0, 0, 1]], F)
    for joint in (16, 17):
        previous[:, indices[pairs[joint, 0]][1:]] = 0
    pa[18] = po[18]
    pr[19] = pa[19]
    cr[20] = co[20]
    dofs = rng.permutation(per_world).astype(np.int32)
    lower, upper = np.full(per_world, F(0.5)), np.full(per_world, F(10))
    ke, kd = np.full(per_world, F(100)), np.full(per_world, F(1))
    angles = np.zeros((worlds, per_world), F)
    flags = np.ones((worlds, per_world), np.int32)
    flags[:, 1] = -1
    flags[:, 17] = -7
    scenarios = ('below', 'above', 'inside', 'at_lower', 'at_upper', 'adjacent_lower', 'adjacent_upper',
                 'lower_damping_clamp', 'upper_damping_clamp', 'lower_damping_only', 'upper_damping_only',
                 'zero_coefficients', 'type_zero', 'type_two', 'type_negative', 'previous_state',
                 'invalid_previous', 'stored_state_ignores_previous', 'zero_axis', 'parallel_parent_reference',
                 'zero_child_reference', 'nan_lower', 'nan_upper', 'nan_both_bounds', 'nan_stiffness',
                 'nan_damping', 'infinite_stiffness', 'infinite_damping', 'infinite_angle', 'many_turns',
                 'negative_coefficients', 'zero_tangent_scale')
    for joint in (1, 8, 10):
        lower[dofs[joint]], upper[dofs[joint]] = -10, F(-0.5)
    lower[dofs[2]], upper[dofs[2]] = F(-0.5), F(0.5)
    lower[dofs[3]], upper[dofs[3]] = 0, F(0.5)
    lower[dofs[4]], upper[dofs[4]] = F(-0.5), 0
    half_pi = F(np.pi/2)
    angles[:, 5:7] = half_pi
    lower[dofs[5]] = np.nextafter(half_pi, F(np.inf))
    lower[dofs[6]], upper[dofs[6]] = -10, np.nextafter(half_pi, F(-np.inf))
    angles[:, 7], angles[:, 8] = F(-0.25), F(0.25)
    angles[:, 9], angles[:, 10] = F(0.25), F(-0.25)
    ke[dofs[[9, 10]]] = 0
    ke[dofs[11]], kd[dofs[11]] = 0, 0
    flags[:, [15, 16]] = 0
    angles[:, [15, 16]] = np.nan
    lower[dofs[21]], upper[dofs[21]] = np.nan, F(-0.5)
    lower[dofs[22]], upper[dofs[22]] = F(0.5), np.nan
    lower[dofs[23]], upper[dofs[23]] = np.nan, np.nan
    ke[dofs[24]], kd[dofs[25]] = np.nan, np.nan
    ke[dofs[26]], kd[dofs[27]] = np.inf, np.inf
    angles[:, 28] = np.inf
    two_pi = F(2*np.pi)
    for world in range(worlds):
        angles[world, 29] = F(F((-100+world)*two_pi)+F(0.125))
    lower[dofs[29]], upper[dofs[29]] = F(F(-100*two_pi)+F(0.5)), np.inf
    ke[dofs[30]], kd[dofs[30]], angles[:, 30] = -100, -2, F(-0.5)
    ke[dofs[31]], kd[dofs[31]], angles[:, 31] = 240, -1, F(-0.5)
    drives = Drives(pairs, types, po, pa, pr, co, cr, dofs, dofs, indices, np.zeros((2*per_world, 3), F))
    up = d.upload
    words = [up(indices).value, up(types).value, up(pairs).value, up(po).value, up(pa).value, up(pr).value,
             up(drives.w_po).value, up(drives.w_co).value, up(drives.w_pa).value, up(drives.w_pr).value,
             up(drives.w_cr).value, up(dofs).value, per_world, count, particles]
    view = (ctypes.c_char*120).from_buffer_copy(struct.pack('<15Q', *words))
    limit_words = [up(array).value for array in (lower, upper, ke, kd)]
    limits = (ctypes.c_char*32).from_buffer_copy(struct.pack('<4Q', *limit_words))
    if hashlib.sha256(LEGACY.read_bytes()).hexdigest() != LEGACY_SHA:
        raise RuntimeError('Unexpected legacy library hash')
    selected_ptx, name = legacy_ptx('23evaluate_angular_limits')
    original_ptx = next(path.read_text() for path in sorted(LEGACY_PTX.glob('*.ptx')) if name in path.read_text())
    functions = [d.function(module, name) for module in (original_ptx, selected_ptx)]
    initial_force = rng.uniform(-1, 1, (worlds*particles+5, 3)).astype(F)
    initial_block = rng.uniform(-1, 1, (worlds*particles+5, 9)).astype(F)
    direction = rng.uniform(-2, 2, (worlds*particles, 3)).astype(F)
    configurations = [(mode, 'mixed', 240) for mode in ('force', 'tangent', 'block', 'block_priority')]
    configurations += [(mode, state, 240) for state in ('stored', 'previous')
                        for mode in ('force', 'tangent', 'block', 'block_priority')]
    configurations += [('tangent_nonfinite', 'mixed', 240), ('block_nonfinite', 'mixed', 240),
                        ('force', 'mixed', 0), ('force', 'mixed', -240)]
    for mode, state, inverse_dt in configurations:
        state_flags = flags.copy() if state == 'mixed' else np.full_like(flags, -3 if state == 'stored' else 0)
        state_direction = direction.copy()
        if mode.endswith('nonfinite'):
            state_direction[indices[pairs[0, 1]][1], 0] = np.inf
        outputs = []
        for fun in functions:
            force_buffer, block_buffer, flag_buffer = up(initial_force), up(initial_block), up(state_flags.ravel())
            angle_buffer = up(angles.ravel()) if state != 'previous' else null()
            args = [view, limits, up(positions.reshape(-1, 3)),
                    up(previous.reshape(-1, 3)) if state != 'stored' else null(), angle_buffer, flag_buffer,
                    f32(inverse_dt), up(state_direction) if mode != 'force' and mode != 'block' else null(),
                    null() if mode == 'block' else force_buffer, block_buffer if mode.startswith('block') else null()]
            d.launch(fun, count, args)
            outputs.append((d.download(force_buffer, initial_force), d.download(block_buffer, initial_block)))
            label = f'limit_{mode}_{state}_{inverse_dt}'
            side = 'legacy' if fun.value == functions[0].value else 'selected'
            out[label+'_'+side+'_flags_unchanged'] = compare('flags', d.download(flag_buffer, state_flags.ravel()),
                                                           state_flags.ravel())
            if angle_buffer.value:
                out[label+'_'+side+'_angle_unchanged'] = compare('angle', d.download(angle_buffer, angles.ravel()),
                                                               angles.ravel())
        for field, initial in enumerate((initial_force, initial_block)):
            out[label+f'_output_{field}'] = compare('out', outputs[0][field], outputs[1][field])
            out[label+f'_tail_{field}'] = compare('tail', outputs[1][field][-5:], initial[-5:])
        if state == 'mixed' and inverse_dt == 240 and mode in ('force', 'tangent', 'block', 'block_priority'):
            field = 1 if mode.startswith('block') else 0
            for joint, scenario in enumerate(scenarios):
                selected = np.concatenate([indices[body] for body in (2*joint, 2*joint+1)])
                out[label+'_'+scenario] = compare('output', outputs[0][field][selected], outputs[1][field][selected])
                if mode == 'force':
                    expected_active = joint in (0, 1, 5, 6, 9, 10, 15, 17, 21, 22, 29, 30, 31)
                    actual_active = bool(np.any(outputs[0][0][selected].view(np.uint32) !=
                                                initial_force[selected].view(np.uint32)))
                    out[label+'_'+scenario+'_activation'] = {
                        'bitwise_equal': actual_active == expected_active,
                        'expected_active': expected_active, 'actual_active': actual_active}
    return out


def run_particle_query_branches(driver, rng):
    """Particle BVH queries: deterministic slot order, boundary contacts, filters, multiple worlds and sentinels."""
    import copy
    d, out = driver, {}
    ids = np.array([7, 1, 5, 0, 6, 3, 4, 2], np.int32)
    n, worlds = 12, 3
    base = np.zeros((n, 3), F)
    base[:8, 0] = [0, 1, np.nextafter(F(1), F(0)), np.nextafter(F(1), F(np.inf)), 0, 3, 0, F(0.4)]
    radius = np.full(n, F(0.5))
    radius[5] = 0
    positions = np.stack((base, (base*F(0.5)+F(4)).astype(F), (base*F(2)-F(4)).astype(F)))
    groups = np.zeros(n, np.int32)
    groups[[6, 7]] = 3
    tags = np.zeros(n, np.int32)
    tags[:8] = [0, 1, -1, -2, 0, 0, 2, -1]
    for case in ('plain', 'filtered', 'same_group', 'nan_box', 'nan_position', 'single_leaf', 'empty'):
        particles = ids[:1] if case == 'single_leaf' else ids
        per_world = len(particles)
        count = 0 if case == 'empty' else worlds*per_world-1 if per_world == 1 else worlds*per_world-5
        points = positions.copy()
        use_groups = np.ones(n, np.int32) if case == 'same_group' else groups if case == 'filtered' else np.zeros(n, np.int32)
        use_world = tags if case == 'filtered' else None
        tree = lbvh.Lbvh(selfcollision.particle_aabbs(base, particles, np.zeros(n, F)))
        trees = []
        for world in range(worlds):
            local = copy.copy(tree)
            local.refit(selfcollision.particle_aabbs(points[world], particles, radius))
            if case == 'nan_box':
                local.nodes[local.leaf[0], 3] = np.nan
            trees.append(local)
        if case == 'nan_position':
            points[:, 4, 0] = np.nan
        for capacity in (-1, 0, 1, 3, 12):
            rows = worlds*per_world+5
            initial_counts = np.full(rows, -777, np.int32)
            initial_slots = np.full((rows, max(capacity, 1)), -888, np.int32)
            expected_counts, expected_slots = initial_counts.copy(), initial_slots.copy()
            for world in range(worlds):
                counts, found = selfcollision.query_particle_pairs(points[world], particles, radius, use_world,
                                                                   use_groups, trees[world], max(capacity, 0))
                active = max(0, min(per_world, count-world*per_world))
                for entry in range(active):
                    row = world*per_world+entry
                    expected_counts[row] = counts[entry]
                    if capacity > 0:
                        expected_slots[row, :counts[entry]] = found[entry, :counts[entry]]
            count_buffer, slot_buffer = d.upload(initial_counts), d.upload(initial_slots)
            function = d.function(*legacy_ptx('_ZN7synreal21self_collision_kernel20query_particle_pairs'))
            d.launch(function, count, [d.upload(points.reshape(-1, 3)), d.upload(particles), d.upload(radius),
                d.upload(use_world) if use_world is not None else null(), d.upload(use_groups),
                d.upload(np.concatenate([t.nodes for t in trees])), d.upload(tree.parent), d.upload(tree.children),
                d.upload(tree.order), d.upload(tree.escape), d.upload(tree.leaf), count_buffer,
                slot_buffer if capacity > 0 else null(), u64(count), u64(per_world), u64(n), ctypes.c_int32(capacity)])
            actual_counts = d.download(count_buffer, initial_counts)
            actual_slots = d.download(slot_buffer, initial_slots)
            label = f'particle_query_{case}_{capacity}'
            out[label+'_counts'] = compare('counts', actual_counts, expected_counts)
            out[label+'_slots'] = compare('slots', actual_slots, expected_slots)
            if case == 'plain' and capacity == 12:
                row = int(np.flatnonzero(particles == 0)[0])
                hits = set(int(v) for v in actual_slots[row, :actual_counts[row]])
                out[label+'_strict_distance_coverage'] = {'bitwise_equal': hits == {2, 4, 6, 7}, 'hits': sorted(hits)}
            if case == 'plain' and capacity == 1:
                out[label+'_saturated_coverage'] = {'bitwise_equal': bool(np.any(actual_counts[:count] == 1))}
            if case in ('same_group', 'single_leaf'):
                out[label+'_zero_hits_coverage'] = {'bitwise_equal': bool(np.all(actual_counts[:count] == 0))}
    return out


def run_mesh_query_branches(driver, rng):
    """All mesh query kernels on explicit geometric regions, degeneracies, filters and world/tail offsets."""
    import copy
    d, out = driver, {}
    triangle_points = np.array([[0,0,0],[1,0,0],[0,1,0], [2,0,0],[3,0,0],[4,0,0],
                                [5,0,0],[5,0,0],[5,0,0]], F)
    query_points = np.array([[-.1,-.1,.02],[1.1,-.1,.02],[.5,-.1,.02],[-.1,1.1,.02],[-.1,.5,.02],
                             [.6,.6,.02],[.2,.2,.02],[2.5,.02,0],[5,.02,0],
                             [-.125,-.25,.25],[-.124999,-.25,.25],[-.125001,-.25,.25]], F)
    edge_points = np.array([[-.5,0,0],[.5,0,0],[0,-.5,.05],[0,.5,.05],
                            [0,0,.1],[0,0,.1],[.1,0,.1],[.1,0,.1],
                            [-.5,.05,0],[.5,.05,0], [.2,.2,.001],[.200001,.2,.001],
                            [.9,.9,.02],[1,1,.02]], F)
    base = np.concatenate((triangle_points, query_points, edge_points))
    n, worlds, radius = len(base), 3, F(.125)
    triangles = np.array([[0,1,2],[3,4,5],[6,7,8],[1,0,2]], np.int32)
    vertices = np.concatenate((np.arange(9,len(triangle_points)+len(query_points)),[0,1,2])).astype(np.int32)
    first_edge = len(triangle_points)+len(query_points)
    edges = np.full((8,4),-1,np.int32)
    edges[:7,2:] = np.arange(first_edge,first_edge+14).reshape(-1,2)
    edges[7,2:] = (0,1)  # incident edge/face and shared endpoint filtering
    thin_base = len(base)
    thin_points = np.array(
        [[6,0,0],[7,0,0],[6,F(5e-11),0], [6,0,0],[7,0,0],[6,F(1e-10),0],
         [6,0,0],[7,0,0],[6,F(2e-10),0]], F)
    near_thin = np.array([[6.25,F(1e-11),.02]]*3,F)
    base = np.concatenate((base,thin_points,near_thin))
    triangles = np.concatenate((triangles,np.arange(thin_base,thin_base+9,dtype=np.int32).reshape(-1,3)))
    vertices = np.concatenate((vertices,np.arange(thin_base+9,thin_base+12,dtype=np.int32)))
    n = len(base)
    positions = np.stack([base+F(world*.25) for world in range(worlds)]).astype(F)
    positions[1,len(triangle_points):len(triangle_points)+9,2] += F(.01)
    group_values = rng.integers(-2,3,n).astype(np.int32)
    vertex_radius = np.full(n,radius,F)
    vertex_radius[vertices[::3]] = F(.0625)
    vertex_radius[vertices[1::4]] = 0
    tri_tree = lbvh.Lbvh(lbvh.triangle_aabbs(base,triangles,0))
    edge_tree = lbvh.Lbvh(lbvh.edge_aabbs(base,edges,0))
    tri_trees, edge_trees = [], []
    for world in range(worlds):
        t,e = copy.copy(tri_tree),copy.copy(edge_tree)
        t.refit(lbvh.triangle_aabbs(positions[world],triangles,radius))
        e.refit(lbvh.edge_aabbs(positions[world],edges,radius))
        tri_trees.append(t);edge_trees.append(e)
    for profile in ('plain','incident','groups','vertex_radius','nan'):
        groups = group_values if profile=='groups' else None
        skip = profile!='incident'
        radii = vertex_radius if profile=='vertex_radius' else None
        for capacity in (0,1,4,20):
            for kind in ('vertex_face','edge_edge','edge_face'):
                case_positions = positions.copy()
                if profile == 'nan' and kind != 'edge_face':
                    particle = int(vertices[0]) if kind == 'vertex_face' else first_edge
                    case_positions[:, particle, 0] = np.nan
                per_world = len(vertices) if kind=='vertex_face' else len(edges)
                count = worlds*per_world-3
                rows = worlds*per_world+5
                c0 = np.full(rows,-777,np.int32)
                s0 = np.full((rows,max(capacity,1)),-888,np.int32)
                expected_c,expected_s = c0.copy(),s0.copy()
                for world in range(worlds):
                    if kind=='vertex_face':
                        counts,found=selfcollision.query_vertex_face(case_positions[world],vertices,triangles,
                            tri_trees[world],radius,radius,skip,groups,capacity,vertex_radius=radii)
                    elif kind=='edge_edge':
                        counts,found=selfcollision.query_edge_edge(case_positions[world],edges,edge_trees[world],
                                                                  radius,groups,capacity)
                    else:
                        counts,found=selfcollision.query_edge_face(case_positions[world],edges,triangles,
                                                                  tri_trees[world],radius,groups,capacity)
                    for entry in range(max(0,min(per_world,count-world*per_world))):
                        row=world*per_world+entry
                        expected_c[row]=counts[entry]
                        expected_s[row,:counts[entry]]=found[entry,:counts[entry]]
                up=d.upload
                cb,sb=up(c0),up(s0)
                ptr_slots=sb if capacity else null()
                trees=edge_trees if kind=='edge_edge' else tri_trees
                topology=edge_tree if kind=='edge_edge' else tri_tree
                common=[up(np.concatenate([t.nodes for t in trees])),up(topology.parent),
                        up(topology.children),up(topology.order)]
                if kind=='vertex_face':
                    fun=d.function(*legacy_ptx('_ZN7synreal21self_collision_kernel17query_vertex_face'))
                    params=[up(case_positions.reshape(-1,3)),up(vertices),up(radii) if radii is not None else null(),
                            up(triangles),up(groups) if groups is not None else null()]+common+[
                            f32(radius),f32(radius),ctypes.c_uint8(skip),cb,ptr_slots,u64(count),u64(per_world),
                            u64(len(triangles)),u64(n),ctypes.c_int32(capacity)]
                elif kind=='edge_edge':
                    fun=d.function(*legacy_ptx('_ZN7synreal21self_collision_kernel15query_edge_edge'))
                    params=[up(case_positions.reshape(-1,3)),up(edges),up(groups) if groups is not None else null()]+common+[
                            f32(radius),cb,ptr_slots,u64(count),u64(per_world),u64(n),ctypes.c_int32(capacity)]
                else:
                    fun=d.function(*legacy_ptx('_ZN7synreal21self_collision_kernel15query_edge_face'))
                    params=[up(case_positions.reshape(-1,3)),up(edges),up(triangles),
                            up(groups) if groups is not None else null()]+common+[
                            f32(radius),cb,ptr_slots,u64(count),u64(per_world),u64(len(triangles)),u64(n),
                            ctypes.c_int32(capacity)]
                d.launch(fun,count,params)
                actual_c,actual_s=d.download(cb,c0),d.download(sb,s0)
                label=f'mesh_query_{kind}_{profile}_{capacity}'
                out[label+'_counts']=compare('count',actual_c,expected_c)
                out[label+'_slots']=compare('slots',actual_s,expected_s)
                if profile=='plain' and capacity==20:
                    if kind=='vertex_face':
                        hits=lambda entry:set(int(v) for v in actual_s[entry,:actual_c[entry]])
                        out[label+'_exact_distance_rejected']={'bitwise_equal':0 not in hits(9)}
                        out[label+'_inside_distance_accepted']={'bitwise_equal':0 in hits(10)}
                        out[label+'_outside_distance_rejected']={'bitwise_equal':0 not in hits(11)}
                        out[label+'_thin_triangles']={'bitwise_equal': all(
                            face in hits(entry) for entry in (15,16,17) for face in (4,5,6))}
                    if kind=='edge_face':
                        out[label+'_broad_phase_only']={'bitwise_equal':0 in actual_s[6,:actual_c[6]]}
                if profile=='plain' and capacity==1:
                    out[label+'_saturated']={'bitwise_equal':bool(np.any(actual_c[:count]==1))}
    return out


def run_point_lines(driver, rng):
    """Joint point-line kernels: state init, AL force, update (flag off/on) and the Gauss-Newton Hessian into the
    diagonal and the slot-major block ELL; world lines, segment ends and interior points."""
    from .joints import PointLines
    d = driver
    out = {}
    count, n_bodies = 48, 4+2*16
    q, indices = random_affine_bodies(rng, n_bodies)
    q[0::4] = rng.uniform(-1, 1, (n_bodies, 3))
    com = rng.uniform(-0.05, 0.05, (n_bodies, 3)).astype(F)
    pairs = np.zeros((count, 2), np.int32)
    for i in range(count):
        pairs[i] = rng.choice(4, 2, replace=False) if i < 32 else (4+2*(i-32), 5+2*(i-32))
        if i % 7 == 3:
            pairs[i, 1] = -1
    pts = lambda scale: rng.uniform(-scale, scale, (count, 3)).astype(F)
    points, e0 = pts(0.2), pts(0.3)
    e1 = (e0+pts(0.4)).astype(F)
    k = rng.uniform(0.001, 0.1, count).astype(F)
    pl = PointLines(pairs, points, e0, e1, k, count, indices, com)
    up = d.upload
    n = len(q)
    geo = [up(q), up(indices), up(pairs), up(pl.w_pt), up(pl.w_e0), up(pl.w_e1), up(e0), up(e1)]
    sizes = [u64(count), u64(count), u64(count), u64(n)]
    s_buf, l_buf, p_buf = up(np.zeros(count, F)), up(np.ones((count, 3), F)), up(np.zeros((count, 9), F))
    d.launch(d.function(*legacy_ptx('38initialize_joint_body_point_line_state')), count,
             geo+[s_buf, l_buf, p_buf]+sizes)
    pl.initialize_state(q)
    out['point_line_init_s'] = compare('s', d.download(s_buf, pl.s), pl.s)
    out['point_line_init_proj'] = compare('p', d.download(p_buf, pl.projector), pl.projector)
    # Perturb the state (multipliers, positions) before the force/update kernels.
    pl.multiplier = rng.normal(scale=0.02, size=(count, 3)).astype(F)
    q2 = (q+rng.normal(scale=0.01, size=q.shape)).astype(F)
    geo[0] = up(q2)
    f0 = rng.uniform(-1, 1, q.shape).astype(F)
    f_buf = up(f0)
    d.launch(d.function(*legacy_ptx('57evaluate_joint_body_point_line_augmented_lagrangian_force')), count,
             geo+[up(k), up(pl.s), up(pl.multiplier), up(pl.projector), f32(5759999.0), f_buf]+sizes)
    f_mine = f0.copy()
    pl.joint_force(q2, F(5759999.0), f_mine)
    out['point_line_force'] = compare('f', d.download(f_buf, f0), f_mine)
    # Gauss-Newton Hessian: dense coupling ELL over the bodies of each constraint.
    coupled = [set() for _ in range(n)]
    for a, b in pairs:
        parts = list(indices[a])+(list(indices[b]) if b >= 0 else [])
        for i in parts:
            coupled[i].update(j for j in parts if j != i)
    row_nnz = np.array([len(c) for c in coupled], np.int32)
    max_nnz = int(row_nnz.max())
    cols = np.full((max_nnz, n), -1, np.int32)
    for r in range(n):
        cols[:row_nnz[r], r] = sorted(coupled[r])
    blocks = rng.uniform(-1, 1, (max_nnz, n, 9)).astype(F)
    diag0 = rng.uniform(-1, 1, (n, 9)).astype(F)
    raw = np.zeros((max_nnz, n, 10), np.uint32)
    raw[..., 0] = cols.view(np.uint32)
    raw[..., 1:] = blocks.view(np.uint32)
    e_buf, dg_buf = up(raw), up(diag0)
    d.launch(d.function(*legacy_ptx('46add_joint_body_point_line_gauss_newton_hessian')), count,
             [up(indices), up(pairs), up(pl.w_pt), up(pl.w_e0), up(pl.w_e1), up(k), up(pl.s), up(pl.projector),
              f32(5759999.0), dg_buf, up(row_nnz), e_buf, u64(max_nnz), u64(count), u64(count), u64(count),
              u64(n), u64(n)])
    dg_mine, b_mine = diag0.copy(), blocks.copy()
    pl.add_hessian(F(5759999.0), dg_mine, (row_nnz, cols, b_mine, max_nnz))
    out['point_line_hessian_diag'] = compare('d', d.download(dg_buf, diag0), dg_mine)
    got = d.download(e_buf, raw)
    out['point_line_hessian_ell'] = compare('b', got[..., 1:].copy().view(F), b_mine)
    # evaluate_body_point_line_force: plain lines (penalty), joint lines only with the include flag.
    for flag in (False, True):
        f_buf = up(f0)
        d.launch(d.function(*legacy_ptx('30evaluate_body_point_line_force')), count,
                 [up(q2), up(np.zeros_like(q2)), up(indices), up(pairs), up(pl.w_pt), up(pl.w_e0), up(pl.w_e1), up(e0),
                  up(e1), up(k), up(np.zeros(count, F)), f32(100.0), u64(count//3), ctypes.c_bool(flag), f_buf,
                  u64(count), u64(count), u64(n)])
        f_mine = f0.copy()
        pl_plain = PointLines(pairs, points, e0, e1, k, count//3, indices, com)
        pl_plain.plain_force(q2, F(100.0), flag, f_mine)
        out[f'body_point_line_force_{flag}'] = compare('f', d.download(f_buf, f0), f_mine)
        e_buf, dg_buf = up(raw), up(diag0)
        d.launch(d.function(*legacy_ptx('40add_body_point_line_gauss_newton_hessian')), count,
                 [up(q2), up(indices), up(pairs), up(pl.w_pt), up(pl.w_e0), up(pl.w_e1), up(e0), up(e1), up(k),
                  f32(100.0), u64(count//3), ctypes.c_bool(flag), dg_buf, up(row_nnz), e_buf, u64(max_nnz),
                  u64(count), u64(count), u64(n), u64(n)])
        dg_mine, b_mine = diag0.copy(), blocks.copy()
        pl_plain.add_plain_hessian(q2, F(100.0), flag, dg_mine, (row_nnz, cols, b_mine, max_nnz))
        out[f'body_point_line_hessian_diag_{flag}'] = compare('d', d.download(dg_buf, diag0), dg_mine)
        out[f'body_point_line_hessian_ell_{flag}'] = compare('b', d.download(e_buf, raw)[..., 1:].copy().view(F), b_mine)
    # PD_NEWTON: block-diagonal AL preconditioner and the matrix-free AL tangent.
    pc_buf = up(diag0)
    d.launch(d.function(*legacy_ptx('61add_joint_body_point_line_augmented_lagrangian_preconditioner')), count,
             [up(indices), up(pairs), up(pl.w_pt), up(pl.w_e0), up(pl.w_e1), up(k), up(pl.s), up(pl.projector),
              f32(5759999.0), pc_buf, u64(count), u64(count), u64(count), u64(n)])
    pc_mine = diag0.copy()
    pl.add_preconditioner(F(5759999.0), pc_mine)
    out['point_line_al_preconditioner'] = compare('d', d.download(pc_buf, diag0), pc_mine)
    direction = rng.normal(size=q.shape).astype(F)
    t0 = rng.uniform(-1, 1, q.shape).astype(F)
    t_buf = up(t0)
    d.launch(d.function(*legacy_ptx('51multiply_joint_body_point_line_augmented_lagrangian')), count,
             [up(direction), up(indices), up(pairs), up(pl.w_pt), up(pl.w_e0), up(pl.w_e1), up(k), up(pl.s),
              up(pl.projector), f32(5759999.0), t_buf, u64(count), u64(count), u64(count), u64(n)])
    t_mine = t0.copy()
    pl.multiply_tangent(F(5759999.0), direction, t_mine)
    out['point_line_al_tangent'] = compare('t', d.download(t_buf, t0), t_mine)
    for flag in (False, True):
        s_buf, l_buf, p_buf = up(pl.s), up(pl.multiplier), up(pl.projector)
        d.launch(d.function(*legacy_ptx('55update_joint_body_point_line_augmented_lagrangian_state')), count,
                 geo+[s_buf, l_buf, p_buf, ctypes.c_bool(flag)]+sizes)
        ref = (d.download(s_buf, pl.s), d.download(l_buf, pl.multiplier), d.download(p_buf, pl.projector))
        saved = (pl.s.copy(), pl.multiplier.copy(), pl.projector.copy())
        pl.update_state(q2, flag)
        for name, a, b in zip(('s', 'lambda', 'proj'), ref, (pl.s, pl.multiplier, pl.projector)):
            out[f'point_line_update_{name}_{flag}'] = compare(name, a, b)
        pl.s, pl.multiplier, pl.projector = saved
    return out


def run_step(driver, rng, count=1500):
    """initialize_step (two worlds, all five diagonal templates, inactive and affine-body particles),
    apply_nonlinear_step and update_velocity."""
    from . import step_kernels
    d = driver
    out = {}
    per_world, worlds = count, 2
    n = per_world*worlds
    h = F(1/240)
    gravity = np.array([[0, 0, -9.81], [0.3, -9.0, -1.0]], F)
    world = rng.integers(-1, 3, per_world).astype(np.int32)  # in-world index; clamped to the gravity table
    velocity = rng.normal(size=(n, 3)).astype(F)
    x = rng.normal(size=(n, 3)).astype(F)
    mass = rng.uniform(0.001, 1, per_world).astype(F)
    mass[rng.random(per_world) < 0.1] = 0
    flags = rng.integers(0, 4, per_world).astype(np.int32)
    kind = rng.integers(0, 3, per_world).astype(np.int32)
    templates = [(rng.uniform(0, 10, per_world).astype(F), F(rng.uniform(0, 100))) for _ in range(5)]
    host = rng.uniform(0, 1e4, per_world).astype(F)
    for label, fl, kd in (('plain', None, None), ('flags_kind', flags, kind)):
        x_buf, prev_buf, hat_buf, diag_buf = d.upload(x), d.upload(np.zeros_like(x)), d.upload(np.zeros_like(x)), \
            d.upload(np.zeros(n, F))
        # Parameter 6 is the host diagonal, parameter 17 the mass that starts the template fma chain.
        params = [f32(h), d.upload(gravity), u64(len(gravity)), d.upload(world), d.upload(velocity), x_buf,
                  d.upload(host)]
        for coefficients, weight in templates:
            params += [d.upload(coefficients), f32(weight)]
        params += [d.upload(mass), d.upload(fl) if fl is not None else null(), d.upload(kd) if kd is not None else null(),
                   prev_buf, hat_buf, diag_buf, u64(n), u64(per_world)]
        d.launch(d.function(*legacy_ptx('15initialize_step')), n, params)
        x_hat, previous, diagonal = step_kernels.initialize_step(h, gravity, world, velocity, x, mass, templates, host,
                                                                 fl, kd, per_world)
        out[f'initialize_step_{label}_x_hat'] = compare('x_hat', d.download(hat_buf, x), x_hat)
        out[f'initialize_step_{label}_state'] = compare('x', d.download(x_buf, x), x_hat)
        out[f'initialize_step_{label}_previous'] = compare('prev', d.download(prev_buf, x), previous)
        out[f'initialize_step_{label}_diagonal'] = compare('diag', d.download(diag_buf, host.repeat(worlds)), diagonal)
    delta = rng.normal(size=(n, 3)).astype(F)
    x_buf, delta_buf, out_buf = d.upload(x), d.upload(delta), d.upload(np.zeros_like(x))
    d.launch(d.function(*legacy_ptx('20apply_nonlinear_step')), n, [x_buf, out_buf, delta_buf, u64(n)])
    applied, cleared = step_kernels.apply_nonlinear_step(x, delta)
    out['apply_nonlinear_step'] = compare('x', d.download(out_buf, x), applied)
    out['apply_nonlinear_step_clear'] = compare('d', d.download(delta_buf, delta), cleared)
    prev = (x+rng.normal(scale=1e-3, size=x.shape)).astype(F)
    v_buf = d.upload(np.zeros_like(x))
    d.launch(d.function(*legacy_ptx('15update_velocity')), n, [f32(F(1)/h), d.upload(prev), d.upload(x), v_buf, u64(n)])
    out['update_velocity'] = compare('v', d.download(v_buf, x), step_kernels.update_velocity(F(1)/h, x, prev))
    # combine_system_non_diagonal over 7 templates of NonZeroEntry (int column, float value).
    entry = np.dtype([('col', '<i4'), ('v', '<f4')])
    m = 4000
    cols = rng.integers(-1, n, m).astype(np.int32)
    templates = [(rng.normal(size=m)*10.0**rng.uniform(-3, 3, m)).astype(F) for _ in range(7)]
    weights = [F(w) for w in rng.uniform(-5, 100, 5)]
    bufs = []
    for t in templates:
        e = np.zeros(m, entry)
        e['col'], e['v'] = cols, t
        bufs.append(d.upload(e))
    out_buf = d.upload(np.zeros(m, entry))
    scale = F(57599.9922)
    d.launch(d.function(*legacy_ptx('27combine_system_non_diagonal')), m,
             [f32(scale)]+[f32(w) for w in weights]+bufs+[out_buf, u64(m)])
    got = d.download(out_buf, np.zeros(m, entry))
    out['combine_system_non_diagonal'] = compare('v', got['v'].copy(),
                                                 step_kernels.combine_system_non_diagonal(scale, weights, templates))
    out['combine_system_non_diagonal_cols'] = {'bitwise_equal': bool(np.array_equal(got['col'], cols))}
    # initialize_block_non_diagonal: scalar ELL (slot-major over the rows of one world) to mat3 blocks, two worlds.
    rows, max_nnz, worlds2 = 300, 7, 2
    row_nnz = rng.integers(0, max_nnz+1, rows).astype(np.int32)
    e = np.zeros(max_nnz*rows, entry)
    e['col'] = rng.integers(0, rows, max_nnz*rows)
    e['v'] = rng.normal(size=max_nnz*rows).astype(F)
    e['v'][rng.random(len(e)) < 0.05] *= -1
    block_t = np.dtype([('col', '<i4'), ('m', '<f4', (9,))])
    total = rows*worlds2
    sentinel = np.zeros(max_nnz*total, block_t)
    sentinel['col'] = -7
    sentinel['m'] = 3.5
    b_buf = d.upload(sentinel)
    d.launch(d.function(*legacy_ptx('29initialize_block_non_diagonal')), max_nnz*total,
             [d.upload(e), d.upload(row_nnz), u64(rows), u64(max_nnz), b_buf, u64(total)])
    got = d.download(b_buf, sentinel)
    ref = sentinel.copy()
    cols_src, blocks_src = pcg.initialize_block_non_diagonal(row_nnz, e['col'].reshape(max_nnz, rows), e['v'].reshape(max_nnz, rows), max_nnz)
    for w in range(worlds2):
        for slot in range(max_nnz):
            for r in range(rows):
                if slot < row_nnz[r]:
                    i = slot*total+w*rows+r
                    ref[i]['col'] = cols_src[slot, r]+w*rows
                    ref[i]['m'] = blocks_src[slot, r]
    out['initialize_block_non_diagonal'] = compare('m', got['m'].copy(), ref['m'])
    out['initialize_block_non_diagonal_cols'] = {'bitwise_equal': bool(np.array_equal(got['col'], ref['col']))}
    # refresh_inertial_cache_*: CSR sums (size_t offsets) into the value fields / diagonal arrays.
    def csr(rows_, values_count):
        counts = rng.integers(0, 6, rows_)
        counts[rng.random(rows_) < 0.2] = 0
        offsets = np.concatenate(([0], np.cumsum(counts))).astype(np.uint64)
        return offsets, rng.integers(0, values_count, int(offsets[-1])).astype(np.int32)
    va, vb = (rng.normal(size=500)*10.0**rng.uniform(-3, 3, 500)).astype(F), rng.normal(size=500).astype(F)
    oa, ia = csr(m, 500)
    ob, ib = csr(m, 500)
    ea, eb = np.zeros(m, entry), np.zeros(m, entry)
    ea['col'], ea['v'] = cols, templates[1]
    eb['col'], eb['v'] = cols, templates[2]
    a_buf, b_buf = d.upload(ea), d.upload(eb)
    d.launch(d.function(*legacy_ptx('31refresh_inertial_cache_nonzeros')), m,
             [d.upload(va), d.upload(oa), d.upload(ia), d.upload(vb), d.upload(ob), d.upload(ib), a_buf, b_buf, u64(m)])
    ra, rb = templates[1].copy(), templates[2].copy()
    step_kernels.refresh_inertial_cache_nonzeros(va, oa, ia, vb, ob, ib, ra, rb)
    out['refresh_inertial_cache_nonzeros_a'] = compare('a', d.download(a_buf, ea)['v'].copy(), ra)
    out['refresh_inertial_cache_nonzeros_b'] = compare('b', d.download(b_buf, eb)['v'].copy(), rb)
    od, idd = csr(n, 500)
    s0, s1 = rng.normal(size=n).astype(F), rng.normal(size=n).astype(F)
    s0_buf, s1_buf = d.upload(s0), d.upload(s1)
    d.launch(d.function(*legacy_ptx('32refresh_inertial_cache_diagonals')), n,
             [d.upload(va), d.upload(od), d.upload(idd), s0_buf, s1_buf, u64(n)])
    r0, r1 = s0.copy(), s1.copy()
    step_kernels.refresh_inertial_cache_diagonals(va, od, idd, r0, r1)
    out['refresh_inertial_cache_diagonals_scaled'] = compare('d3', d.download(s0_buf, s0), r0)
    out['refresh_inertial_cache_diagonals_sum'] = compare('d1', d.download(s1_buf, s1), r1)
    # PD_NEWTON update_solution_and_residual (no reduction), including a zero denominator (guarded alpha).
    num = rng.uniform(0.1, 10, 6).astype(F)
    den = rng.uniform(0.1, 10, 6).astype(F)
    den[3] = 0
    p_, ap = rng.normal(size=(n, 3)).astype(F), rng.normal(size=(n, 3)).astype(F)
    sol, res = rng.normal(size=(n, 3)).astype(F), rng.normal(size=(n, 3)).astype(F)
    for k in (2, 3):
        sb, rb = d.upload(sol), d.upload(res)
        d.launch(d.function(*legacy_ptx('28update_solution_and_residual')), n,
                 [ctypes.c_int32(k), d.upload(num), d.upload(den), d.upload(p_), d.upload(ap), sb, rb, u64(n)])
        s_exp, r_exp = pcg.update_solution_and_residual(k, num, den, p_, ap, sol, res)
        out[f'pd_update_solution_{k}'] = compare('x', d.download(sb, sol), s_exp)
        out[f'pd_update_residual_{k}'] = compare('r', d.download(rb, res), r_exp)
    lam = rng.normal(size=(77, 3)).astype(F)
    l_buf = d.upload(lam)
    d.launch(d.function(*legacy_ptx('34initialize_joint_body_spring_state')), 77, [l_buf, u64(77)])
    out['initialize_joint_body_spring_state'] = compare('l', d.download(l_buf, lam), np.zeros_like(lam))
    return out


def surface_contact_case(rng, count=256, n_bodies=16):
    """Vertex/edge/face soft contacts (3 own particles each, placed around a target point) against box and sphere
    shapes on affine bodies or static; warp w only touches bodies 2w, 2w+1 (cross-warp sharing is nondeterministic
    on the GPU)."""
    from .surface_contact import SurfaceContacts
    q, indices = random_affine_bodies(rng, n_bodies)
    q[0::4] = rng.uniform(-2, 2, (n_bodies, 3))
    com = rng.uniform(-0.05, 0.05, (n_bodies, 3)).astype(F)
    shapes = 3*n_bodies
    shape_body = np.repeat(np.arange(n_bodies, dtype=np.int32), 3)
    shape_body[rng.random(shapes) < 0.25] = -1
    shape_type = rng.choice([7, SPHERE], size=shapes).astype(np.int32)
    transform = np.zeros((shapes, 7), F)
    transform[:, :3] = rng.uniform(-0.05, 0.05, (shapes, 3))
    transform[:, 6] = 1
    scale = np.zeros((shapes, 3), F)
    scale[:, 0] = rng.uniform(0.05, 0.3, shapes)
    nb = len(q)
    n = nb+3*count
    x = np.concatenate([q, np.zeros((3*count, 3), F)]).astype(F)
    tri = np.full((count, 3), -1, np.int32)
    bary = np.zeros((count, 3), F)
    shape = np.zeros(count, np.int32)
    body_pos = rng.uniform(-0.2, 0.2, (count, 3)).astype(F)
    raw_normal = rng.normal(size=(count, 3)).astype(F)
    radius = np.concatenate([np.zeros(nb, F), rng.uniform(0.005, 0.03, 3*count).astype(F)])
    for i in range(count):
        w_ = i//32
        own = np.flatnonzero((shape_body == (2*w_) % n_bodies) | (shape_body == (2*w_+1) % n_bodies)
                             | ((shape_body < 0) & (np.arange(shapes) % 8 == w_ % 8)))
        sh = rng.choice(own)
        shape[i] = sh
        kind = rng.integers(1, 4)
        ids = nb+3*i+np.arange(3)
        tri[i, :kind] = ids[:kind]
        b = rng.dirichlet(np.ones(kind)).astype(F)
        if kind > 1 and rng.random() < 0.1:
            b[0] = 0                                    # zero weights are listed but contribute no entry
            b = (b/b.sum()).astype(F)
        bary[i, :kind] = b
        if rng.random() < 0.03:
            bary[i, 0] += F(3e-4)                       # off the 1e-4 tolerance: rejected
        b_ = int(shape_body[sh])
        local = transform[sh, :3].astype(np.float64) if shape_type[sh] == SPHERE else body_pos[i].astype(np.float64)
        if b_ >= 0:
            t, a0, a1, a2 = (q[j].astype(np.float64) for j in indices[b_])
            dl = local-com[b_]
            world = t+dl[0]*a0+dl[1]*a1+dl[2]*a2
        else:
            world = local
        unit = raw_normal[i]/np.linalg.norm(raw_normal[i])
        extra = scale[sh, 0] if shape_type[sh] == SPHERE else 0
        target = world+unit*(extra+rng.uniform(-0.03, 0.02))
        x[ids] = (target+rng.normal(scale=0.002, size=(3, 3))).astype(F)
    velocity = rng.normal(scale=0.5, size=(n, 3)).astype(F)
    previous = (x-velocity/F(240)).astype(F)
    mass = np.concatenate([np.ones(nb, F), rng.uniform(0.001, 0.05, 3*count).astype(F)])
    mass[nb+rng.integers(0, 3*count, 10)] = 0
    flags = np.concatenate([np.ones(nb, np.int32), (rng.random(3*count) < 0.95).astype(np.int32)])
    kind_arr = np.concatenate([np.ones(nb, np.int32), np.zeros(3*count, np.int32)])
    margin = rng.uniform(0, 0.01, shapes).astype(F)
    mats = [rng.uniform(lo, hi, shapes).astype(F) for lo, hi in ((1e2, 1e4), (0, 50), (1, 2e3), (0, 1))]
    bodies = rigid_contact.Bodies(np.arange(n_bodies, dtype=np.int32), indices, com)
    c = SurfaceContacts(count, tri, bary, shape, body_pos, rng.normal(scale=0.3, size=(count, 3)).astype(F),
                        raw_normal, radius, mass, flags, kind_arr, shape_body, shape_type, transform[:, :3], scale,
                        margin, *mats, 1e3, 10.0, 1e3, 0.5, bodies, x, previous, 240.0)
    return c, transform


def surface_view(d, c, transform):
    """SurfaceContactView (296 B) for the inputs `c`."""
    up = lambda a: d.upload(a).value if a is not None else 0
    n = len(c.x)
    shapes = len(c.shape_type)
    words = [d.upload(np.array([c.count], np.int32)).value, c.count, up(c.indices), up(c.barycentric), up(c.shape),
             up(c.body_pos), up(c.body_vel), up(c.normal), up(c.particle_only),
             len(c.particle_only) if c.particle_only is not None else 0, up(c.radius), up(c.mass), up(c.flags),
             up(c.kind), n, n, up(c.shape_body), up(c.shape_type), up(transform), up(c.shape_scale),
             up(c.shape_margin), up(c.shape_ke), up(c.shape_kd), up(c.shape_kf), up(c.shape_mu), shapes, shapes, 1]
    raw = struct.pack('<28Q', *[int(w) for w in words])
    raw += struct.pack('<ffff', c.ke, c.kd, c.kf, c.mu)
    raw += struct.pack('<5Q', up(c.bodies.ids), up(c.bodies.indices), up(c.bodies.com), len(c.bodies.ids), up(c.x))
    raw += struct.pack('<Q', up(c.previous)) + struct.pack('<ff', c.inv_h, 0.0)
    assert len(raw) == 296, len(raw)
    return (ctypes.c_char*296).from_buffer_copy(raw)


def run_surface_contact(driver, rng):
    """evaluate_surface_contact_force (+ preconditioner and tangent once transcribed)."""
    from . import surface_contact
    d = driver
    out = {}
    c, transform = surface_contact_case(rng)
    view = surface_view(d, c, transform)
    f0 = rng.uniform(-1, 1, c.x.shape).astype(F)
    f_buf = d.upload(f0)
    d.launch(d.function(*legacy_ptx('30evaluate_surface_contact_force')), c.count, [view, f_buf])
    f_mine = f0.copy()
    surface_contact.evaluate_surface_contact_force(c, f_mine)
    ref = d.download(f_buf, f0)
    out['surface_force'] = compare('f', ref, f_mine)
    out['surface_force_coverage'] = {'bitwise_equal': bool(np.any(ref != f0)),
                                     'changed': int(np.any(ref != f0, axis=1).sum())}
    b0 = rng.uniform(-1, 1, (len(c.x), 9)).astype(F)
    b_buf = d.upload(b0)
    d.launch(d.function(*legacy_ptx('34add_surface_contact_preconditioner')), c.count, [view, b_buf])
    b_mine = b0.copy()
    surface_contact.add_surface_contact_preconditioner(c, b_mine)
    out['surface_preconditioner'] = compare('b', d.download(b_buf, b0), b_mine)
    direction = rng.uniform(-1, 1, c.x.shape).astype(F)
    t_buf = d.upload(f0)
    d.launch(d.function(*legacy_ptx('32multiply_surface_contact_tangent')), c.count, [view, d.upload(direction), t_buf])
    t_mine = f0.copy()
    surface_contact.multiply_surface_contact_tangent(c, direction, t_mine)
    out['surface_tangent'] = compare('t', d.download(t_buf, f0), t_mine)
    s0 = rng.uniform(1, 1e4, len(c.x)).astype(F)
    s_buf = d.upload(s0)
    d.launch(d.function(*legacy_ptx('35add_surface_contact_stiffness_scale')), c.count, [view, s_buf])
    s_mine = s0.copy()
    surface_contact.add_surface_contact_stiffness_scale(c, s_mine)
    ref = d.download(s_buf, s0)
    out['surface_stiffness_scale'] = compare('s', ref, s_mine)
    out['surface_stiffness_scale']['changed'] = int((ref != s0).sum())
    return out


def run_drag(driver, rng):
    """Triangle drag kernels on disjoint triangles (no atomic races), including degenerate triangles."""
    d = driver
    out = {}
    count = 500
    n = 3*count
    tris = rng.permutation(n).reshape(-1, 3).astype(np.int32)
    previous = rng.uniform(-1, 1, (n, 3)).astype(F)
    previous[tris[:5, 2]] = previous[tris[:5, 0]]  # zero area
    x = (previous+rng.uniform(-0.02, 0.02, (n, 3))).astype(F)
    coef = rng.uniform(0.1, 2.0, count).astype(F)
    normal_buf, area_buf = d.upload(np.zeros((count, 3), F)), d.upload(np.zeros(count, F))
    d.launch(d.function(*legacy_ptx('24initialize_triangle_drag')), count,
             [d.upload(previous), d.upload(tris), normal_buf, area_buf, u64(count), u64(count), u64(n)])
    normal, area = drag.initialize(previous, tris)
    out['initialize_normal'] = compare('n', d.download(normal_buf, normal), normal)
    out['initialize_area'] = compare('a', d.download(area_buf, area), area)
    force0 = rng.uniform(-1, 1, (n, 3)).astype(F)
    f_buf, c_buf = d.upload(force0), d.upload(np.zeros(count, F))
    wind = (ctypes.c_float*3)(1.5, -0.5, 0.25)
    d.launch(d.function(*legacy_ptx('22evaluate_triangle_drag')), count,
             [d.upload(x), d.upload(previous), d.upload(tris), d.upload(coef), d.upload(normal), d.upload(area),
              f32(1.225), wind, f32(240.0), f_buf, c_buf, u64(count), u64(count), u64(n)])
    f_mine = force0.copy()
    scalar = drag.evaluate(x, previous, tris, coef, normal, area, 1.225, (1.5, -0.5, 0.25), 240.0, f_mine)
    out['evaluate_force'] = compare('f', d.download(f_buf, force0), f_mine)
    out['evaluate_scalar'] = compare('c', d.download(c_buf, scalar), scalar)
    b0 = rng.uniform(-1, 1, (n, 9)).astype(F)
    b_buf = d.upload(b0)
    d.launch(d.function(*legacy_ptx('32add_triangle_drag_preconditioner')), count,
             [d.upload(tris), d.upload(normal), d.upload(scalar), b_buf, u64(count), u64(count), u64(n)])
    b_mine = b0.copy()
    drag.add_preconditioner(tris, normal, scalar, b_mine)
    out['add_preconditioner'] = compare('b', d.download(b_buf, b0), b_mine)
    p = rng.uniform(-1, 1, (n, 3)).astype(F)
    t_buf = d.upload(force0)
    d.launch(d.function(*legacy_ptx('30multiply_triangle_drag_tangent')), count,
             [d.upload(p), d.upload(tris), d.upload(normal), d.upload(scalar), t_buf, u64(count), u64(count), u64(n)])
    t_mine = force0.copy()
    drag.multiply_tangent(p, tris, normal, scalar, t_mine)
    out['multiply_tangent'] = compare('t', d.download(t_buf, force0), t_mine)
    return out


def run_springs(driver, rng):
    """evaluate_spring_force and add_spring_gauss_newton_hessian on disjoint springs (no atomic races), including
    zero length, compressed (H = n n^T), nonpositive stiffness or rest length, and springs without an ELL entry."""
    d = driver
    out = {}
    count = 600
    n = 2*count
    x = rng.uniform(-1, 1, (n, 3)).astype(F)
    pairs = rng.permutation(n).reshape(-1, 2).astype(np.int32)
    x[pairs[:5, 1]] = x[pairs[:5, 0]]  # zero length
    length = np.linalg.norm(x[pairs[:, 1]]-x[pairs[:, 0]], axis=1).astype(F)
    rest = (length*rng.choice([0.5, 0.9, 1.0, 1.2, 2.0], count)).astype(F)
    stiffness = rng.uniform(10, 500, count).astype(F)
    stiffness[5:15] = 0
    rest[15:20] = 0
    force0 = rng.uniform(-1, 1, (n, 3)).astype(F)
    f_buf = d.upload(force0)
    d.launch(d.function(*legacy_ptx('21evaluate_spring_force')), count,
             [d.upload(x), d.upload(pairs), d.upload(stiffness), d.upload(rest), f_buf, u64(count), u64(count), u64(n)])
    f_mine = force0.copy()
    springs.evaluate_spring_force(x, pairs, stiffness, rest, f_mine)
    out['evaluate_spring_force'] = compare('f', d.download(f_buf, force0), f_mine)
    # ELL: each spring endpoint row holds its partner plus random other columns; the last 30 springs have none.
    max_nnz = 4
    cols = np.full((max_nnz, n), -1, np.int32)
    row_nnz = np.zeros(n, np.int32)
    for t, (a, b) in enumerate(pairs):
        for row, col in ((a, b), (b, a)):
            entries = set(rng.choice(n, rng.integers(0, 3), replace=False).tolist()) - {row}
            if t < count-30:
                entries.add(int(col))
            entries = sorted(entries)[:max_nnz]
            cols[:len(entries), row] = entries
            row_nnz[row] = len(entries)
    blocks0 = rng.uniform(-1, 1, (max_nnz, n, 9)).astype(F)
    entry = np.dtype([('col', '<i4'), ('m', '<f4', (9,))])
    packed = np.zeros((max_nnz, n), entry)
    packed['col'], packed['m'] = cols, blocks0
    diag0 = rng.uniform(-1, 1, (n, 9)).astype(F)
    dg_buf, e_buf = d.upload(diag0), d.upload(packed)
    d.launch(d.function(*legacy_ptx('31add_spring_gauss_newton_hessian')), count,
             [d.upload(x), d.upload(pairs), d.upload(stiffness), d.upload(rest), dg_buf, d.upload(row_nnz), e_buf,
              u64(max_nnz), u64(count), u64(count), u64(n), u64(n)])
    dg_mine, bl_mine = diag0.copy(), blocks0.copy()
    springs.add_spring_hessian(x, pairs, stiffness, rest, dg_mine, (row_nnz, cols, bl_mine, max_nnz))
    out['add_spring_hessian_diagonal'] = compare('d', d.download(dg_buf, diag0), dg_mine)
    out['add_spring_hessian_offdiagonal'] = compare('e', d.download(e_buf, packed)['m'], bl_mine)
    return out


def granular_model_bytes(d, n, indices, world, radius, material):
    """synreal::Model by value with the fields the granular kernels read."""
    model = (ctypes.c_ubyte*1864)()
    buf = memoryview(model).cast('B')
    for offset, fmt, value in ((24, '<i', n), (28, '<i', n), (120, '<Q', d.upload(world).value), (128, '<Q', len(world)),
                               (136, '<Q', d.upload(radius).value), (272, '<i', len(indices)),
                               (280, '<Q', d.upload(indices).value), (312, '<f', material.damping),
                               (316, '<f', material.yield_strain), (320, '<f', material.compaction),
                               (324, '<f', material.break_strain), (328, '<f', material.adhesion),
                               (332, '<f', material.gap), (336, '<f', material.speed),
                               (340, '<i', material.max_dynamic)):
        struct.pack_into(fmt, buf, offset, value)
    return model


def granular_view_bytes(buffers, p):
    view = (ctypes.c_ubyte*120)()
    buf = memoryview(view).cast('B')
    for k, pointer in enumerate(buffers):
        struct.pack_into('<Q', buf, 8*k, pointer.value)
    struct.pack_into('<ii', buf, 88, p.count, p.slots)
    struct.pack_into('<fffff', buf, 96, p.cell, p.k, p.mu, p.cd, p.dt)
    return view


def run_granular(driver, rng):
    """granular_kernel: grid, row-owned contacts (incl. the >32 re-traversal and coincident grains), bonds (one
    active bond per launch for the atomics), commit and dynamic bond formation."""
    d = driver
    ptx = lambda name: d.function(*legacy_ptx('_ZN7synreal15granular_kernel'+name))
    out = {}
    # Grains: a loose block, a dense cluster (more than 32 contacts) and coincident pairs.
    block = (np.stack(np.meshgrid(np.arange(6), np.arange(5), np.arange(4), indexing='ij'), -1).reshape(-1, 3)
             * 0.018+rng.uniform(-0.003, 0.003, (120, 3)))
    cluster = rng.uniform(0, 0.022, (70, 3))+np.array([0.03, 0.03, 0.12])
    twins = np.repeat(rng.uniform(0, 0.08, (4, 3))+np.array([0.0, 0.1, 0.0]), 2, axis=0)
    grains = np.concatenate((block, cluster, twins)).astype(F)
    n = len(grains)+30
    indices = rng.permutation(n)[:len(grains)].astype(np.int32)
    x = rng.uniform(-1, 1, (n, 3)).astype(F)
    x[indices] = grains
    previous = (x+rng.uniform(-2e-3, 2e-3, x.shape)).astype(F)
    # Coincident twins at rest take the axis normal. Twins with relative motion would use rsqrt.approx (MUFU.RSQ),
    # which is not emulated bit for bit, so they are kept out of this scene.
    previous[indices[-8:]] = x[indices[-8:]]
    radius = rng.uniform(0.008, 0.011, n).astype(F)
    world = np.zeros(n, np.int32)
    world[indices[rng.random(len(indices)) < 0.1]] = 1
    material = granular.Material(0.3, 0.03, 0.4, 0.1, 50.0, 0.002, 1.0, 4)
    g = len(indices)
    p = granular.Params(g, fluid.slot_count(g), granular.cell_size(radius, indices, 50.0, 0.002), 2000.0, 0.5, 20.0,
                        1/240)
    model = granular_model_bytes(d, n, indices, world, radius, material)
    like = {'head': np.full(p.slots, -1, np.int32), 'next': np.zeros(g, np.int32), 'ids': np.zeros(g, np.int32),
            'world': np.zeros(g, np.int32), 'cells': np.zeros((g, 3), np.int32), 'positions': np.zeros((g, 3), F),
            'previous': np.zeros((g, 3), F), 'radius': np.zeros(g, F)}
    bufs = {k: d.upload(v) for k, v in like.items()}
    counts_buf = d.upload(np.zeros(g, np.int32))
    cids_buf = d.upload(np.zeros((32, g), np.int32))
    cache_buf = d.upload(np.zeros((32, g, 4), F))
    order = ['head', 'next', 'ids', 'world', 'cells', 'positions', 'previous', 'radius']
    view = granular_view_bytes([bufs[k] for k in order]+[counts_buf, cids_buf, cache_buf], p)
    d.launch(ptx('10build_grid'), g, [model, d.upload(x), d.upload(previous), view, bufs['positions'],
             bufs['previous'], bufs['radius'], bufs['ids'], bufs['world'], bufs['cells'], bufs['head'], bufs['next']],
             block=128)
    native = {k: d.download(bufs[k], v) for k, v in like.items()}
    mine = granular.build_grid(x, previous, indices, world, radius, p)
    for name in ('ids', 'world', 'cells', 'positions', 'previous', 'radius'):
        out['build_grid_'+name] = compare(name, native[name], getattr(mine, name))
    grid = granular.Grid(native['ids'], native['world'], native['positions'], native['previous'], native['radius'],
                         native['cells'], native['head'], native['next'])
    # accumulate_contacts: no atomics, so the whole launch is compared.
    force0 = rng.uniform(-1, 1, (n, 3)).astype(F)
    diag0 = rng.uniform(-1, 1, (n, 9)).astype(F)
    f_buf, dg_buf = d.upload(force0), d.upload(diag0)
    d.launch(ptx('19accumulate_contacts'), g, [view, f_buf, dg_buf, counts_buf, cids_buf, cache_buf], block=128)
    ref = (d.download(f_buf, force0), d.download(dg_buf, diag0), d.download(counts_buf, np.zeros(g, np.int32)),
           d.download(cids_buf, np.zeros((32, g), np.int32)), d.download(cache_buf, np.zeros((32, g, 4), F)))
    f_mine, dg_mine = force0.copy(), diag0.copy()
    count, cids, cache = granular.accumulate_contacts(grid, p, f_mine, dg_mine)
    for name, a, b in zip(('force', 'diagonal', 'count', 'cache_ids', 'cache'), ref, (f_mine, dg_mine, count, cids, cache)):
        out['accumulate_contacts_'+name] = compare(name, a, b)
    out['contacts_coverage'] = {'bitwise_equal': bool((ref[2] > 32).any() and (ref[2] > 0).sum() > 50),
                                'max_contacts': int(ref[2].max()),
                                'over_32': int((ref[2] > 32).sum()), 'with_contacts': int((ref[2] > 0).sum())}
    direction = rng.uniform(-1, 1, (n, 3)).astype(F)
    t0 = rng.uniform(-1, 1, (n, 3)).astype(F)
    t_buf = d.upload(t0)
    d.launch(ptx('17multiply_contacts'), g, [view, d.upload(direction), t_buf], block=128)
    t_mine = t0.copy()
    granular.multiply_contacts(grid, p, ref[2], ref[3], ref[4], direction, t_mine)
    out['multiply_contacts'] = compare('t', d.download(t_buf, t0), t_mine)
    # Bonds: intact, plastic, broken, inactive and coincident (zero length) cases.
    nb = 400
    pairs = np.stack([rng.choice(indices, 2, replace=False) for _ in range(nb)]).astype(np.int32)
    pairs[:4] = np.stack((indices[-8:-4:2], indices[-7:-3:2]), axis=1).repeat(2, axis=0)[:4]
    dist = np.linalg.norm(x[pairs[:, 0]]-x[pairs[:, 1]], axis=1).astype(F)
    rest = (dist*rng.choice([0.6, 0.9, 1.0, 1.05, 1.3], nb)).astype(F)
    rest[:4] = F(0.01)
    history = (rest*rng.uniform(0.7, 1.0, nb)).astype(F)
    active = (rng.random(nb) < 0.9).astype(np.int32)
    bonds_buf, rest_buf, hist_buf, act_buf = d.upload(pairs), d.upload(rest), d.upload(history), d.upload(active)
    b_buf = d.upload(np.full((nb, 9), F(7)))
    d.launch(ptx('16accumulate_bonds'), nb, [model, d.upload(x), d.upload(previous), f32(1/240), bonds_buf, rest_buf,
             hist_buf, act_buf, ctypes.c_int32(nb), f32(200.0), d.upload(np.zeros((n, 3), F)),
             d.upload(np.zeros((n, 9), F)), b_buf], block=128)
    tangent_ref = d.download(b_buf, np.zeros((nb, 9), F))
    tangent = granular.accumulate_bonds(material, x, previous, 1/240, pairs, rest, history, active, 200.0,
                                        np.zeros((n, 3), F), np.zeros((n, 9), F))
    out['accumulate_bonds_tangent'] = compare('b', tangent_ref, tangent)
    ok, picks = [], rng.choice(np.flatnonzero(tangent_ref.any(axis=1)), 12, replace=False)
    picks = np.concatenate((picks, [0, 1]))
    for b in picks:  # one active bond per launch: atomic contributions in a fixed order
        only = np.where(np.arange(nb) == b, active, 0).astype(np.int32)
        f_buf, dg_buf = d.upload(force0), d.upload(diag0)
        d.launch(ptx('16accumulate_bonds'), nb, [model, d.upload(x), d.upload(previous), f32(1/240), bonds_buf,
                 rest_buf, hist_buf, d.upload(only), ctypes.c_int32(nb), f32(200.0), f_buf, dg_buf,
                 d.upload(np.zeros((nb, 9), F))],
                 block=128)
        f_mine, dg_mine = force0.copy(), diag0.copy()
        granular.accumulate_bonds(material, x, previous, 1/240, pairs, rest, history, only, 200.0, f_mine, dg_mine)
        ok.append(compare('f', d.download(f_buf, force0), f_mine)['bitwise_equal']
                  and compare('d', d.download(dg_buf, diag0), dg_mine)['bitwise_equal'])
        t_buf = d.upload(t0)
        d.launch(ptx('14multiply_bonds'), nb, [bonds_buf, d.upload(only), d.upload(tangent_ref), ctypes.c_int32(nb),
                 d.upload(direction), t_buf], block=128)
        t_mine = t0.copy()
        granular.multiply_bonds(pairs, only, tangent_ref, direction, t_mine)
        ok.append(compare('t', d.download(t_buf, t0), t_mine)['bitwise_equal'])
    out['bond_atomics'] = {'bitwise_equal': all(ok), 'bonds': [int(b) for b in picks],
                           'nonzero_tangents': int(tangent_ref.any(axis=1).sum()), 'plastic_or_broken_mix': True}
    d.launch(ptx('12commit_bonds'), nb, [model, d.upload(x), bonds_buf, rest_buf, hist_buf, act_buf, ctypes.c_int32(nb)],
             block=128)
    h_mine, a_mine = history.copy(), active.copy()
    granular.commit_bonds(material, x, pairs, rest, h_mine, a_mine)
    out['commit_bonds_history'] = compare('h', d.download(hist_buf, history), h_mine)
    out['commit_bonds_active'] = compare('a', d.download(act_buf, active), a_mine)
    out['commit_coverage'] = {'bitwise_equal': bool((a_mine < active).any() and (h_mine != history).any()),
                              'broken': int((a_mine < active).sum()), 'changed_history': int((h_mine != history).sum())}
    # form_bonds: partially filled slots, broken-and-separated slots, initial-bond exclusions (CSR).
    m = material.max_dynamic
    grid_pairs = np.stack([rng.choice(g, 2, replace=False) for _ in range(150)]).astype(np.int32)
    grid_pairs = np.unique(np.sort(grid_pairs, axis=1), axis=0)
    offsets, columns = granular.initial_adjacency(grid_pairs, g)
    partner = np.full(m*g, -1, np.int32)
    filled = rng.random(m*g) < 0.15
    partner[filled] = rng.integers(0, g, filled.sum())
    dyn_active = (filled & (rng.random(m*g) < 0.5)).astype(np.int32)
    dyn_bonds = np.zeros((m*g, 2), np.int32)
    dyn_rest = np.zeros(m*g, F)
    dyn_hist = np.zeros(m*g, F)
    bufs2 = [d.upload(a) for a in (partner, dyn_bonds, dyn_rest, dyn_hist, dyn_active)]
    d.launch(ptx('10form_bonds'), g, [model, view, d.upload(offsets), d.upload(columns), *bufs2], block=128)
    mine = [a.copy() for a in (partner, dyn_bonds, dyn_rest, dyn_hist, dyn_active)]
    granular.form_bonds(grid, p, material, offsets, columns, *mine)
    names = ('partner', 'bonds', 'rest', 'history', 'active')
    for name, buf, a, b in zip(names, bufs2, (partner, dyn_bonds, dyn_rest, dyn_hist, dyn_active), mine):
        out['form_bonds_'+name] = compare(name, d.download(buf, a), b)
    out['form_coverage'] = {'bitwise_equal': bool((mine[4] > dyn_active).any() and (mine[0] < partner).any()),
                            'formed': int((mine[4] > dyn_active).sum()),
                            'released': int(((mine[0] == -1) & (partner >= 0)).sum())}
    # add_diagonal (B += D).
    b0, dmat = rng.uniform(-1, 1, (n, 9)).astype(F), rng.uniform(-1, 1, (n, 9)).astype(F)
    b_buf = d.upload(b0)
    d.launch(ptx('12add_diagonal'), n, [d.upload(dmat), b_buf, ctypes.c_int32(n)], block=128)
    b_mine = b0.copy()
    b_mine += dmat
    out['add_diagonal'] = compare('b', d.download(b_buf, b0), b_mine)
    return out


def run_hard_contact_history(driver, rng):
    """Snapshot capacity/count guards, preserved tails, dual copies and normal normalization."""
    d, out = driver, {}
    fun = d.function(*legacy_ptx('22snapshot_hard_contacts'))
    for case, (capacity, count) in enumerate(((0, 4), (7, None), (7, -2), (7, 0), (7, 3), (7, 7), (7, 12),
                                             (513, 511), (513, 513), (513, 900))):
        size = capacity+9
        ln = rng.normal(size=size).astype(F)
        lt = rng.normal(size=(size, 3)).astype(F)
        normal = rng.normal(size=(size, 3)).astype(F)*F(3)
        normal[:3] = [[0, 0, 0], [1, 0, 0], [0, -2, 0]]
        before = [rng.normal(size=size).astype(F), rng.normal(size=(size, 3)).astype(F),
                  rng.normal(size=(size, 3)).astype(F), np.array([-19], np.int32)]
        sources = [d.upload(v) for v in (ln, lt, normal)]
        outputs = [d.upload(v) for v in before]
        words = [0]*39
        words[0] = 0 if count is None else d.upload(np.array([count], np.int32)).value
        words[1] = capacity
        for offset, ptr in zip((256, 264, 64, 280, 288, 296, 304), sources+outputs):
            words[offset//8] = ptr.value
        view = (ctypes.c_char*312).from_buffer_copy(struct.pack('<39Q', *words))
        d.launch(fun, max(1, capacity), [view])
        actual = [a.copy() for a in before]
        hard_contacts.snapshot(count, capacity, ln, lt, normal, *actual)
        for label, ptr, expected, mine in zip(('n', 't', 'normal', 'count'), outputs, before, actual):
            out[f'snapshot_{case}_{label}'] = compare(label, d.download(ptr, expected), mine)
        for label, ptr, values in zip(('n', 't', 'normal'), sources, (ln, lt, normal)):
            out[f'snapshot_{case}_{label}_input'] = compare(label, d.download(ptr, values), values)
    return out


def run_cables(driver, rng):
    """Penalty initialization: reset/history, both beta switches, mask, world stride and tail writes."""
    d = driver
    fun = d.function(*legacy_ptx('23prepare_cable_penalties'))
    out = {}
    per_world, count, padding = 19, 57, 7
    base = rng.uniform(0, 20, (per_world, 4)).astype(F)
    base[0] = [0, 1, 3, 8]
    base[1] = [3, 8, 0, 1]
    for case in range(192):
        reset, rescale = bool(case & 1), bool(case & 2)
        beta0, beta1 = (-1.0 if case & 4 else 0.3), (0.0 if case & 8 else 0.7)
        mask_kind = (case // 16) % 3
        mask = None if mask_kind == 0 else (rng.integers(0, 2, count+padding, dtype=np.int32)
                                           if mask_kind == 1 else np.zeros(count+padding, np.int32))
        old = rng.uniform(0, 30, (count+padding, 4)).astype(F)
        init = rng.integers(0, 2, count+padding, dtype=np.int32)
        # Include exact clamp boundaries and noncanonical nonzero initialization values.
        old[:2] = base[:2]
        init[:3] = [0, 1, -1]
        scale = (0.0, 0.5, 1.0, 1.5)[case // 48]
        args = (per_world, beta0, beta1, scale, 3.0, 8.0, reset, rescale)
        pb, ib, bb = d.upload(old), d.upload(init), d.upload(base)
        mb = null() if mask is None else d.upload(mask)
        d.launch(fun, count, [bb, pb, ib, u64(per_world), u64(count), f32(beta0), f32(beta1), f32(scale),
                             f32(3), f32(8), ctypes.c_uint8(reset), ctypes.c_uint8(rescale), mb])
        actual, flags = old.copy(), init.copy()
        cables.prepare_penalties(base, actual, flags, *args, mask=mask, count=count)
        out[f'prepare_penalties_{case}'] = compare('penalty', d.download(pb, old), actual)
        out[f'prepare_flags_{case}'] = compare('initialized', d.download(ib, init), flags)
        out[f'base_unchanged_{case}'] = compare('base', d.download(bb, base), base)
        if mask is not None:
            out[f'mask_unchanged_{case}'] = compare('mask', d.download(mb, mask), mask)
    return out


def run_affine_block(driver, rng):
    from .diagnostics.affine_block_ab import run
    result = {}
    for scalar in (False, True):
        cases = run(driver, rng, scalar)
        for case, checks in cases.items():
            for field, value in checks.items():
                result[f'{"scalar" if scalar else "block"}_{case}_{field}'] = value
    return result


def run_hard_constraints(driver, rng):
    from .diagnostics.hard_contact_ab import run
    return run(driver, rng)


def run_cable_cuda(driver, rng):
    from .diagnostics.cable_cuda_ab import compile_sources, run
    return run(driver, rng, compile_sources())


def run_self_accumulate_branches(driver, rng):
    """Direct original/source checks of contact guards, optional records, worlds and tangent grid strides."""
    from .csrc.self_accumulate_cases import run
    return run(driver, rng)


def run_edge_accumulate_branches(driver, rng):
    """Direct old/source edge-contact comparisons on disjoint world-local stencils and exceptional inputs."""
    from .csrc.edge_accumulate_cases import run
    return run(driver, rng)


def run_fluid_branches(driver, rng):
    """World mapping, exact hash buffers and controlled fluid cache/fallback comparisons against the old GPU."""
    from .csrc.fluid_cases import run
    return run(driver, rng)


def run_granular_branches(driver, rng):
    """Direct original/source tests of grain world mapping, bond history, friction and contact cache boundaries."""
    from .csrc.granular_cases import run
    return run(driver, rng)


def run_soft_contact_branches(driver, rng):
    from .csrc.soft_contact_cases import run
    return run(driver, rng)


def run_hard_state_branches(driver, rng):
    from .csrc.hard_state_cases import run
    return run(driver, rng)


def run_hard_evaluate_branches(driver, rng):
    from .csrc.hard_evaluate_cases import run
    return run(driver, rng)


def run_rigid_contact_branches(driver, rng):
    from .csrc.rigid_contact_cases import run
    return run(driver, rng)


def run_surface_contact_branches(driver, rng):
    from .csrc.surface_contact_cases import run
    return run(driver, rng)


def run_rolling_contact_branches(driver, rng):
    from .csrc.rolling_contact_cases import run
    return run(driver, rng)


def run_affine_block_assembly(driver, rng):
    from .csrc.affine_block_assembly_cases import run
    return run(driver, rng)


def run_affine_block_branches(driver, rng):
    from .csrc.affine_block_cases import run
    return run(driver, rng)


def run_cable_update(driver, rng):
    from .csrc.cable_update_cases import run
    return run(driver, rng)


def run_cable_prepare(driver, rng):
    from .csrc.cable_prepare_cases import run
    return run(driver, rng)


def run_cable_evaluate(driver, rng):
    from .csrc.cable_evaluate_cases import run
    return run(driver, rng)


def run_soft_contact_static(driver, rng):
    result = run_soft_contact(driver, rng, 1000)
    coverage = result.pop('coverage')
    result['coverage'] = {'bitwise_equal': all(coverage[key] > 0 for key in
                          ('active_sphere', 'active_non_sphere', 'with_friction', 'skipped_mass_or_flag')), **coverage}
    return {key: value if isinstance(value, dict) else {'bitwise_equal': value} for key, value in result.items()}


def run_state_initialization_branches(driver, rng):
    """Exceptional-value direct GPU comparisons for hard-contact history and cable penalty initialization."""
    from .csrc.state_initialization_cases import run
    return run(driver, rng)


def run_pcg_templates(driver, rng):
    from .diagnostics.pcg_templates_ab import run
    return run(driver, rng)


def run_thrust(driver, rng):
    from .diagnostics.thrust_ab import run
    return run(driver, rng)


def run_cub_scans(driver, rng):
    from .diagnostics.cub_scan_ab import run
    return run(driver, rng)


def run_cub_remaining(driver, rng):
    from .diagnostics.cub_remaining_ab import run
    return run(driver, rng)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--seed', type=int, default=1)
    parser.add_argument('--count', type=int, default=20000)
    parser.add_argument('--output', type=Path, default=ROOT/'build/reconstruction-kernels/kernel_ab.json')
    parser.add_argument('--only', choices=('cable_evaluate', 'cable_prepare', 'cable_update',
                                           'affine_block_branches', 'affine_block_assembly',
                                          'rolling_contact_branches',
                                          'surface_contact_branches', 'rigid_contact_branches',
                                          'hard_evaluate_branches', 'hard_state_branches',
                                          'soft_contact_branches', 'soft_contact',
                                          'state_initialization_branches', 'granular_branches',
                                           'fluid_branches', 'edge_accumulate_branches',
                                           'self_accumulate', 'self_accumulate_branches',
                                           'pcg', 'fluid', 'granular', 'particle_pairs', 'particle_query_branches',
                                           'springs', 'drag', 'affine',
                                           'rigid_contact', 'rolling_contact', 'soft_body_contact', 'joint_springs', 'joint_drives', 'joint_drive_branches', 'joint_armature_branches', 'joint_limit_branches', 'point_lines', 'surface_contact', 'step', 'cables', 'hard_history', 'affine_block', 'hard_constraints', 'cable_cuda', 'pcg_templates', 'thrust', 'cub_scans', 'cub_remaining', 'lbvh', 'self_collision', 'self_queries', 'mesh_query_branches', 'cloth'), help='Run a single group (report is not written).')
    args = parser.parse_args()
    if args.only:
        driver = Driver()
        try:
            runs = {'cable_evaluate': run_cable_evaluate, 'cable_prepare': run_cable_prepare,
                    'cable_update': run_cable_update,
                    'affine_block_branches': run_affine_block_branches, 'affine_block_assembly': run_affine_block_assembly,
                    'rolling_contact_branches': run_rolling_contact_branches,
                    'surface_contact_branches': run_surface_contact_branches,
                    'rigid_contact_branches': run_rigid_contact_branches,
                    'hard_evaluate_branches': run_hard_evaluate_branches, 'hard_state_branches': run_hard_state_branches,
                    'soft_contact_branches': run_soft_contact_branches, 'soft_contact': run_soft_contact_static,
                    'state_initialization_branches': run_state_initialization_branches,
                    'granular_branches': run_granular_branches,
                    'fluid_branches': run_fluid_branches, 'edge_accumulate_branches': run_edge_accumulate_branches,
                    'self_accumulate': run_accumulate, 'self_accumulate_branches': run_self_accumulate_branches,
                    'fluid': run_fluid, 'granular': run_granular, 'particle_pairs': run_particle_pairs,
                    'particle_query_branches': run_particle_query_branches,
                    'springs': run_springs, 'drag': run_drag, 'affine': run_affine,
                    'rigid_contact': run_rigid_contact, 'rolling_contact': run_rolling_contact,
                    'soft_body_contact': run_soft_body_contact, 'joint_springs': run_joint_springs,
                    'joint_drives': run_joint_drives, 'joint_drive_branches': run_joint_drive_branches,
                    'joint_armature_branches': run_joint_armature_branches,
                    'joint_limit_branches': run_joint_limit_branches,
                    'point_lines': run_point_lines,
                    'surface_contact': run_surface_contact, 'step': run_step, 'cables': run_cables, 'hard_history': run_hard_contact_history, 'affine_block': run_affine_block, 'hard_constraints': run_hard_constraints,
                    'pcg_templates': run_pcg_templates, 'thrust': run_thrust, 'cub_scans': run_cub_scans,
                    'cub_remaining': run_cub_remaining, 'lbvh': lambda d, r: run_lbvh(d, r, 3000),
                    'self_collision': lambda d, r: {**run_self_collision(d, r), **run_accumulate(d, r)},
                    'self_queries': run_self_collision, 'mesh_query_branches': run_mesh_query_branches,
                    'cloth': lambda d, r: run_cloth(d, r, args.count),
                    'cable_cuda': run_cable_cuda, 'pcg': lambda d, r: run_pcg(d, r, args.count)}
            result = runs[args.only](driver, np.random.default_rng(args.seed))
        finally:
            driver.free()
        print(json.dumps(result, indent=2))
        if CSRC_ENTRIES_USED:
            print('csrc entries:', sorted(CSRC_ENTRIES_USED), file=sys.stderr)
        sys.exit(0 if all(item['bitwise_equal'] and item.get('copy_equal', True) and item.get('vectors_equal', True)
                         and item.get('partials', {'bitwise_equal': True})['bitwise_equal']
                         for item in result.values()) else 1)
    rng = np.random.default_rng(args.seed)
    driver = Driver()
    report = {'legacy_sha256': LEGACY_SHA, 'seed': args.seed}
    try:
        report['evaluate_soft_contact_force'] = run_soft_contact(driver, rng, args.count)
        report['evaluate_tetrahedron_force'] = run_tetrahedron(driver, rng, args.count)
        report['multiply_tetrahedron_tangent'] = run_tetrahedron_tangent(driver, rng, args.count)
        report['add_tetrahedron_preconditioner'] = run_tetrahedron_preconditioner(driver, rng, args.count)
        report['pcg'] = run_pcg(driver, rng, 1000)
        report['cloth'] = run_cloth(driver, rng, args.count)
        report['lbvh'] = run_lbvh(driver, rng, min(args.count, 3000))
        report['self_collision'] = run_self_collision(driver, rng)
        report['self_collision'].update(run_accumulate(driver, rng))
        report['self_collision'].update(run_particle_pairs(driver, rng))
        report['self_collision'].update(run_particle_query_branches(driver, rng))
        report['self_collision'].update(run_mesh_query_branches(driver, rng))
        report['fluid'] = run_fluid(driver, rng)
        report['granular'] = run_granular(driver, rng)
        report['springs'] = run_springs(driver, rng)
        report['drag'] = run_drag(driver, rng)
        report['affine'] = run_affine(driver, rng)
        report['rigid_contact'] = run_rigid_contact(driver, rng)
        report['rolling_contact'] = run_rolling_contact(driver, rng)
        report['rolling_contact'].update(run_soft_body_contact(driver, rng))
        report['rolling_contact'].update(run_joint_springs(driver, rng))
        report['rolling_contact'].update(run_joint_drives(driver, rng))
        report['rolling_contact'].update(run_joint_drive_branches(driver, rng))
        report['rolling_contact'].update(run_joint_armature_branches(driver, rng))
        report['rolling_contact'].update(run_joint_limit_branches(driver, rng))
        report['rolling_contact'].update(run_point_lines(driver, rng))
        report['surface_contact'] = run_surface_contact(driver, rng)
        report['step'] = run_step(driver, rng)
        report['cables'] = run_cables(driver, rng)
        report['hard_history'] = run_hard_contact_history(driver, rng)
        report['affine_block'] = run_affine_block(driver, rng)
        report['hard_constraints'] = run_hard_constraints(driver, rng)
        report['cable_cuda'] = run_cable_cuda(driver, rng)
        report['pcg_templates'] = run_pcg_templates(driver, rng)
        report['thrust'] = run_thrust(driver, rng)
        report['cub_scans'] = run_cub_scans(driver, rng)
        report['cub_remaining'] = run_cub_remaining(driver, rng)
    finally:
        driver.free()
    checks = [report['evaluate_soft_contact_force'][k]['bitwise_equal'] for k in ('force', 'scalar', 'block')]
    checks.append(report['evaluate_soft_contact_force']['block_copy_equal'])
    checks.append(report['evaluate_tetrahedron_force']['force']['bitwise_equal'])
    checks.append(report['multiply_tetrahedron_tangent']['product']['bitwise_equal'])
    checks.append(report['add_tetrahedron_preconditioner']['block']['bitwise_equal'])
    groups = ('pcg', 'cloth', 'lbvh', 'self_collision', 'fluid', 'granular', 'springs', 'drag', 'affine',
              'rigid_contact', 'rolling_contact', 'surface_contact', 'step', 'cables', 'hard_history', 'affine_block', 'hard_constraints', 'cable_cuda', 'pcg_templates', 'thrust', 'cub_scans', 'cub_remaining')
    for name, item in [entry for g in groups for entry in report[g].items()]:
        checks.append(item['bitwise_equal'] and item.get('copy_equal', True) and item.get('vectors_equal', True)
                      and item.get('partials', {'bitwise_equal': True})['bitwise_equal'])
    report['passed'] = all(checks)
    report['csrc_entries'] = sorted(CSRC_ENTRIES_USED)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps(report, indent=2))
    sys.exit(0 if report['passed'] else 1)


if __name__ == '__main__':
    main()
