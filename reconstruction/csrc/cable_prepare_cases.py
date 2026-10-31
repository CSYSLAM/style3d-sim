"""Direct complete prepare comparisons with literal legacy PTX and the selected source entry."""
import ctypes
import struct
import sys

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc import ptx_compare as pc
from reconstruction.csrc.probe_cable_strain_jacobian import cases as strain_cases
from reconstruction.diagnostics.cable_cuda_ab import scene


def compare_scene(driver, functions, data, q, stride, label, limit=None, tile=None):
    n, count = len(data[24]), len(data[128])
    data = dict(data)
    for off in (104, 112, 120, 128):
        data[off] = np.concatenate([data[off], np.full((7,) + data[off].shape[1:], -71, data[off].dtype)])
    outputs, reports = [], {}
    for backend, fun in enumerate(functions):
        ptr = {off: k.null() if array is None else driver.upload(array) for off, array in data.items()}
        words = [ptr[off].value for off in range(0, 136, 8)] + [n if tile is None else tile,
                                                            count if limit is None else limit, stride]
        view = (ctypes.c_char * 160).from_buffer_copy(struct.pack('<20Q', *words))
        qp = driver.upload(q)
        driver.launch(fun, count + 13, [view, qp], block=128)
        outputs.append({off: driver.download(ptr[off], data[off]) for off in (104, 112, 120, 128)})
        reports[f'{label}_backend{backend}_positions'] = k.compare('positions', q, driver.download(qp, q))
        for off, array in data.items():
            if array is not None and off not in (104, 112, 120, 128):
                tag = f'{label}_backend{backend}_readonly{off}'
                reports[tag] = k.compare(tag, array, driver.download(ptr[off], array))
    for off, old in outputs[0].items():
        tag = f'{label}_output{off}'
        reports[tag] = k.compare(tag, old, outputs[1][off])
    if any(not row['bitwise_equal'] for row in reports.values()):
        out = pc.OUT/'cable-prepare-audit'
        out.mkdir(parents=True, exist_ok=True)
        np.savez(out/f'diff-{label}.npz', q=q, **{f'old_{off}': a for off, a in outputs[0].items()},
                 **{f'source_{off}': a for off, a in outputs[1].items()},
                 **{f'input_{off}': a for off, a in data.items() if a is not None})
    print('cable prepare', label, [(off, reports[f'{label}_output{off}']['mismatches'])
                                  for off in (104, 112, 120, 128)], file=sys.stderr, flush=True)
    return reports


def run(driver, rng):
    selected, name = k.legacy_ptx('22prepare_cable_tangents')
    old = next(path.read_text() for path in sorted(pc.LEGACY_PTX.glob('*.ptx'))
               if name in pc.entries(path.read_text()))
    functions = driver.function(old, name), driver.function(selected, name)
    reports = {}
    for case, data, q, stride in strain_cases(rng):
        # Exercise actual prepared Jacobians at singular orientations. A static
        # pair alone would only test count=0 and leave all Jacobian slots untouched.
        if np.all(data[24] == -1):
            n = len(data[24])
            data[24][::2, 0] = np.arange(n)[::2] * 2
            data[24][1::2, 1] = np.arange(n)[1::2] * 2 + 1
            q.reshape(3, -1, 4, 3)[:, :, 1:] = np.eye(3, dtype=np.float32)
        reports.update(compare_scene(driver, functions, data, q, stride, case))
    for case in ('same_body', 'shared_slots', 'empty', 'empty_zero_tile', 'partial_count',
                 'null_unused', 'mask_disabled', 'null_mask', 'rank_one', 'huge_affine', 'tiny_affine'):
        data, q, stride = scene(rng, n=137 if case == 'same_body' else 16, worlds=3, variant=1)
        limit, tile = None, None
        if case == 'same_body': data[24][:, 1] = data[24][:, 0]
        if case == 'shared_slots':
            data[0][:, 2] = data[0][:, 1]
            data[0][:, 3] = data[0][:, 1]
        if case.startswith('empty'): limit = 0
        if case == 'empty_zero_tile': tile = 0
        if case == 'partial_count': limit = len(data[24]) + 3
        if case == 'null_unused':
            for off in (48, 56, 64, 80, 88, 96): data[off] = None
        if case == 'mask_disabled': data[96][:] = 0
        if case == 'null_mask': data[96] = None
        affine = q.reshape(3, -1, 4, 3)[:, :, 1:]
        if case == 'rank_one': affine[:, :, 1:] = affine[:, :, :1]
        if case == 'huge_affine': affine *= np.float32(1e20)
        if case == 'tiny_affine': affine *= np.float32(1e-20)
        reports.update(compare_scene(driver, functions, data, q, stride, case, limit, tile))
    return reports
