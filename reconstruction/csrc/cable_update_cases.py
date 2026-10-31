"""Direct old/selected full cable penalty-update entry comparisons; no mechanical CUDA reference."""
import ctypes
import struct
import sys

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc import ptx_compare as pc
from reconstruction.diagnostics.cable_cuda_ab import scene


def compare_scene(d, rng, functions, data, q, stride, label, beta=(2, 3), limit=None, tile=None):
    n, count = len(data[24]), len(data[56])
    data = dict(data)
    data[56] = np.concatenate([data[56], rng.normal(size=(7, 4)).astype(np.float32)])
    outputs, reports = [], {}
    for backend, fun in enumerate(functions):
        ptr = {off: k.null() if array is None else d.upload(array) for off, array in data.items()}
        words = [ptr[off].value for off in range(0, 136, 8)] + [n if tile is None else tile,
                                                            count if limit is None else limit, stride]
        view = (ctypes.c_char * 160).from_buffer_copy(struct.pack('<20Q', *words))
        qp = d.upload(q)
        d.launch(fun, count + 13, [view, qp, k.f32(beta[0]), k.f32(beta[1])], block=128)
        outputs.append(d.download(ptr[56], data[56]))
        reports[f'{label}_backend{backend}_positions'] = k.compare('positions', q, d.download(qp, q))
        for off, array in data.items():
            if array is not None and off != 56:
                tag = f'{label}_backend{backend}_readonly_{off}'
                reports[tag] = k.compare(tag, array, d.download(ptr[off], array))
    tag = f'{label}_penalty'
    reports[tag] = k.compare(tag, outputs[0], outputs[1])
    if not reports[tag]['bitwise_equal']:
        out = pc.OUT/'cable-update-audit'
        out.mkdir(parents=True, exist_ok=True)
        np.savez(out/f'{label}-difference.npz', original=outputs[0], source=outputs[1], q=q,
                 **{f'input_{off}': value for off, value in data.items() if value is not None})
    return reports


def branches(d, rng, functions):
    reports = {}
    cases = ['parallel', 'opposite_x', 'opposite_y', 'opposite_degenerate_parent', 'cap_boundary',
             'rest_large', 'rest_pi', 'empty', 'empty_zero_tile', 'partial_count', 'disabled', 'negative_active',
             'null_unused', 'nan_parent_quaternion', 'inf_child_quaternion', 'nan_positions', 'inf_positions',
             'nan_inertia', 'inf_inertia', 'nan_base', 'inf_base', 'nan_old_penalty', 'negative_old_penalty',
             'nan_rest', 'beta_zero', 'beta_negative', 'beta_nan', 'beta_inf', 'beta_negative_inf']
    cases += [f'near_opposite_{i}' for i in range(8)]
    cases += [f'denominator_boundary_{i}' for i in range(3)]
    for case in cases:
        print('cable update branch', case, file=sys.stderr, flush=True)
        data, q, stride = scene(rng, n=16, worlds=3, variant=1)
        n, count = len(data[24]), len(data[56])
        beta, limit, tile = (2, 3), None, None
        # Static authored frames isolate bending/transport thresholds from body rotation roundoff.
        if case in ('parallel', 'opposite_x', 'opposite_y', 'opposite_degenerate_parent', 'cap_boundary') or \
                case.startswith(('near_opposite_', 'denominator_boundary_')):
            data[24][:] = -1
            data[32][:, 3:], data[40][:, 3:] = [0, 0, 0, 1], [0, 0, 0, 1]
            if case == 'opposite_x': data[40][:, 3:] = [1, 0, 0, 0]
            if case == 'opposite_y': data[40][:, 3:] = [0, 1, 0, 0]
            if case == 'opposite_degenerate_parent':
                data[32][:, 3:], data[40][:, 3:] = [0, .5, .5, 0], [1, 0, 0, .5]
            if case == 'cap_boundary':
                angle = np.float32(np.arctan(10))
                data[40][:, 3:] = [np.sin(angle), 0, 0, np.cos(angle)]
            if case.startswith('near_opposite_'):
                epsilon = (-1e-4, -1e-6, -1e-7, -1e-8, 1e-8, 1e-7, 1e-6, 1e-4)[int(case.rsplit('_', 1)[1])]
                data[40][:, 3:] = [1, 0, 0, epsilon]
            if case.startswith('denominator_boundary_'):
                x = np.float32(1)
                for _ in range(int(case.rsplit('_', 1)[1])): x = np.nextafter(x, np.float32(0))
                data[40][:, 3:] = [x, 0, 0, 1e-4]
        if case == 'rest_large': data[72][:] = rng.uniform(-40, 40, (n, 3))
        if case == 'rest_pi': data[72][:, 2] = np.resize(np.array([np.pi, -np.pi, 3*np.pi, -3*np.pi]), n)
        if case in ('empty', 'empty_zero_tile'): limit = 0
        if case == 'empty_zero_tile': tile = 0
        if case == 'partial_count': limit = n + 3
        if case == 'disabled': data[96][:] = 0
        if case == 'negative_active': data[96][:] = -1
        if case == 'null_unused':
            for off in (64, 80, 88, 96, 104, 112, 120, 128): data[off] = None
        if case == 'nan_parent_quaternion': data[32][:, 3] = np.nan
        if case == 'inf_child_quaternion': data[40][:, 6] = np.inf
        if case == 'nan_positions': q[:, 0] = np.nan
        if case == 'inf_positions': q[:, 1] = np.inf
        if case == 'nan_inertia': data[16][:, 0, 0] = np.nan
        if case == 'inf_inertia': data[16][:, 1, 1] = np.inf
        if case == 'nan_base': data[48][:, ::2] = np.nan
        if case == 'inf_base': data[48][:, 1::2] = np.inf
        if case == 'nan_old_penalty': data[56][:, ::2] = np.nan
        if case == 'negative_old_penalty': data[56] *= -3
        if case == 'nan_rest': data[72][:, 2] = np.nan
        if case == 'beta_zero': beta = (0, 0)
        if case == 'beta_negative': beta = (-2, -3)
        if case == 'beta_nan': beta = (np.nan, np.nan)
        if case == 'beta_inf': beta = (np.inf, np.inf)
        if case == 'beta_negative_inf': beta = (-np.inf, -np.inf)
        reports.update(compare_scene(d, rng, functions, data, q, stride, case, beta, limit, tile))
    return reports


def run(d, rng):
    text, name = k.legacy_ptx('22update_cable_penalties')
    original = next(path.read_text() for path in sorted(pc.LEGACY_PTX.glob('*.ptx'))
                    if name in pc.entries(path.read_text()))
    functions = d.function(original, name), d.function(text, name)
    reports = {}
    for variant in range(9):
        print('cable update variant', variant, file=sys.stderr, flush=True)
        data, q, stride = scene(rng, n=137 if variant == 7 else 32, variant=variant)
        n, count = len(data[24]), len(data[56])
        if variant == 2:
            data[96], data[80], data[88] = None, None, None
        if variant == 3:
            data[64][:], data[48][:], data[56][:] = 0, 0, 0
        if variant == 4: q.reshape(2, -1, 4, 3)[:, :, 1:] *= np.float32(1e-7)
        if variant == 5: q.reshape(2, -1, 4, 3)[:, :, 1:] = 0
        if variant == 6:
            data[16][:] += rng.normal(0, .1, data[16].shape).astype(np.float32)
            data[72][:] = rng.uniform(-4, 4, data[72].shape).astype(np.float32)
        if variant == 7:
            data[24][::3, 1] = data[24][::3, 0]
            data[32][:, 3:] = rng.normal(size=(n, 4))
            data[32][:, 3:] /= np.linalg.norm(data[32][:, 3:], axis=1)[:, None]
        if variant == 8:
            q = np.roll(q.reshape(2, -1, 4, 3), -1, axis=2).reshape(-1, 3).copy()
        reports.update(compare_scene(d, rng, functions, data, q, stride, str(variant)))
    reports.update(branches(d, rng, functions))
    return reports
