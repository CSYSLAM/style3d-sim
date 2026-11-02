"""Complete old/source cable force, tangent-product and diagonal-block comparisons."""
import ctypes
import struct
import sys

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc import ptx_compare as pc
from reconstruction.csrc.probe_cable_strain_jacobian import cases as strain_cases
from reconstruction.diagnostics.cable_cuda_ab import scene


def compare_scene(driver, rng, functions, prepare, data, q, stride, label, mode, inverse_dt=60, limit=None, tile=None):
    n, count = len(data[24]), len(data[128])
    data = dict(data)
    previous = (q + rng.normal(0, .01, q.shape)).astype(np.float32)
    direction = rng.normal(size=q.shape).astype(np.float32)
    force = rng.normal(0, .1, (len(q) + 7, 3)).astype(np.float32)
    diagonal = rng.normal(0, .1, (len(q) + 7, 9)).astype(np.float32)
    outputs, reports = [], {}
    random_cache = None
    if label.startswith('cache_random_'):
        random_cache = {off: rng.normal(size=data[off].shape).astype(np.float32) for off in (104, 112)}
        if label == 'cache_random_nan': random_cache[112][::3, :, ::2] = np.nan
        if label == 'cache_random_inf': random_cache[104][::3, :, 1::2] = np.inf
    if label == 'direction_nan_inf': direction[::3, 0], direction[1::3, 2] = np.nan, np.inf
    for backend, fun in enumerate(functions):
        ptr = {off: k.null() if array is None else driver.upload(array) for off, array in data.items()}
        def view():
            words = [ptr[off].value for off in range(0, 136, 8)] + [n if tile is None else tile,
                                                                count if limit is None else limit, stride]
            return (ctypes.c_char * 160).from_buffer_copy(struct.pack('<20Q', *words))
        qp, pp, dp = driver.upload(q), driver.upload(previous), driver.upload(direction)
        fp, mp = driver.upload(force), driver.upload(diagonal)
        driver.launch(prepare[backend if mode.startswith('pipeline_') else 0], count, [view(), qp])
        cached = {off: driver.download(ptr[off], data[off]) for off in (104, 112, 120, 128)}
        if label.startswith('cache_count_'):
            maximum = {'one': 1, 'three': 3, 'zero': 0, 'negative': -3}[label.rsplit('_', 1)[1]]
            cached[128] = np.minimum(cached[128], maximum).astype(np.int32)
            ptr[128] = driver.upload(cached[128])
        if random_cache:
            for off, array in random_cache.items(): cached[off], ptr[off] = array, driver.upload(array)
        diagonal_mode = mode.endswith('diagonal') or mode == 'mixed'
        product_mode = mode.endswith('product') or mode == 'mixed'
        if label == 'force_null_caches' and mode == 'force':
            for off in (104, 112, 120, 128): ptr[off] = k.null()
        if label == 'force_stale_caches' and mode == 'force':
            for off in (104, 112): ptr[off] = driver.upload(np.full_like(data[off], 123))
        if label.endswith('no_previous'): pp = k.null()
        if label == 'cached_null_geometry' and mode != 'force':
            for off in (0, 8, 16, 24, 32, 40, 72): ptr[off] = k.null()
            qp, pp = k.null(), k.null()
        driver.launch(fun, count + 7, [view(), qp, pp, k.f32(inverse_dt), dp if product_mode else k.null(),
                                      fp, mp if diagonal_mode else k.null()], block=128)
        outputs.append((driver.download(fp, force), driver.download(mp, diagonal)))
        for off, array in data.items():
            if ptr[off].value:
                expected = cached[off] if off in cached else array
                if label == 'force_stale_caches' and mode == 'force' and off in (104, 112):
                    expected = np.full_like(array, 123)
                tag = f'{label}_{mode}_backend{backend}_readonly{off}'
                reports[tag] = k.compare(tag, expected, driver.download(ptr[off], expected))
        for field, pointer, expected in (('q', qp, q), ('previous', pp, previous), ('direction', dp, direction)):
            if pointer.value:
                tag = f'{label}_{mode}_backend{backend}_{field}'
                reports[tag] = k.compare(tag, expected, driver.download(pointer, expected))
    for at, field in enumerate(('force', 'diagonal')):
        tag = f'{label}_{mode}_{field}'
        reports[tag] = k.compare(tag, outputs[0][at], outputs[1][at])
    if any(not row['bitwise_equal'] for row in reports.values()):
        out = pc.OUT/'cable-evaluate-audit'
        out.mkdir(parents=True, exist_ok=True)
        np.savez(out/f'diff-{label}-{mode}.npz', old_force=outputs[0][0], source_force=outputs[1][0],
                 old_diagonal=outputs[0][1], source_diagonal=outputs[1][1], q=q, previous=previous, direction=direction,
                 **{f'input_{off}': a for off, a in data.items() if a is not None})
    print('cable evaluate', label, mode, reports[f'{label}_{mode}_force']['mismatches'],
          reports[f'{label}_{mode}_diagonal']['mismatches'], file=sys.stderr, flush=True)
    return reports


def run(driver, rng):
    selected, name = k.legacy_ptx('15evaluate_cables')
    old = next(path.read_text() for path in sorted(pc.LEGACY_PTX.glob('*.ptx'))
               if name in pc.entries(path.read_text()))
    prep_selected, prep_name = k.legacy_ptx('22prepare_cable_tangents')
    functions = driver.function(old, name), driver.function(selected, name)
    prepare = driver.function(old, prep_name), driver.function(prep_selected, prep_name)
    reports = {}
    for label, data, q, stride in strain_cases(rng):
        if np.all(data[24] == -1):
            n = len(data[24])
            data[24][::2, 0] = np.arange(n)[::2] * 2
            data[24][1::2, 1] = np.arange(n)[1::2] * 2 + 1
            q.reshape(3, -1, 4, 3)[:, :, 1:] = np.eye(3, dtype=np.float32)
        for mode in ('force', 'product', 'diagonal', 'mixed', 'pipeline_product', 'pipeline_diagonal'):
            reports.update(compare_scene(driver, rng, functions, prepare, data, q, stride, label, mode))
    extra = ('null_penalty', 'null_state_bias', 'force_null_caches', 'force_stale_caches', 'cached_null_geometry',
             'undamped_no_previous', 'negative_damping_no_previous', 'nan_damping_no_previous', 'mixed_damping',
             'nan_penalty', 'inf_penalty', 'negative_penalty', 'nan_state', 'inf_state', 'nan_bias', 'inf_bias',
             'inverse_dt_zero', 'inverse_dt_negative', 'inverse_dt_nan', 'inverse_dt_inf', 'twist_rest_large',
             'disabled', 'negative_active', 'null_active', 'empty_zero_tile', 'partial_count',
             'cache_count_one', 'cache_count_three', 'cache_count_negative', 'cache_count_zero',
             'cache_random_finite', 'cache_random_nan', 'cache_random_inf', 'direction_nan_inf',
             'same_body', 'shared_slots')
    for label in extra:
        data, q, stride = scene(rng, n=16, worlds=3, variant=1)
        inverse_dt, limit, tile = 60, None, None
        if label == 'null_penalty': data[56] = None
        if label == 'null_state_bias': data[80], data[88] = None, None
        if label == 'undamped_no_previous': data[64][:] = 0
        if label == 'negative_damping_no_previous': data[64][:] = -1
        if label == 'nan_damping_no_previous': data[64][:, :], data[64][:, 1] = 0, np.nan
        if label == 'mixed_damping': data[64][:] = [1, -2, -3, -4]
        if label == 'nan_penalty': data[56][:, 1] = np.nan
        if label == 'inf_penalty': data[56][:, 2] = np.inf
        if label == 'negative_penalty': data[56] *= -3
        if label == 'nan_state': data[80][:, 0] = np.nan
        if label == 'inf_state': data[80][:, 1] = np.inf
        if label == 'nan_bias': data[88][:, 1] = np.nan
        if label == 'inf_bias': data[88][:, 2] = np.inf
        if label.startswith('inverse_dt_'):
            inverse_dt = {'zero': 0, 'negative': -60, 'nan': np.nan, 'inf': np.inf}[label.rsplit('_', 1)[1]]
        if label == 'twist_rest_large':
            data[72][:, 2] = np.resize([np.pi, -np.pi, 3*np.pi, -3*np.pi, 100, -100], len(data[24]))
        if label == 'disabled': data[96][:] = 0
        if label == 'negative_active': data[96][:] = -1
        if label == 'null_active': data[96] = None
        if label == 'empty_zero_tile': limit, tile = 0, 0
        if label == 'partial_count': limit = len(data[24]) + 3
        if label == 'same_body': data[24][:, 1] = data[24][:, 0]
        if label == 'shared_slots': data[0][:, 2:], data[0][:, 1] = data[0][:, 1:2], data[0][:, 1]
        modes = ('force', 'product', 'diagonal', 'mixed')
        if label.startswith('force_'): modes = ('force',)
        if label == 'cached_null_geometry': modes = ('product', 'diagonal', 'mixed')
        for mode in modes:
            reports.update(compare_scene(driver, rng, functions, prepare, data, q, stride, label, mode,
                                         inverse_dt, limit, tile))
    return reports
