"""Direct old/selected-GPU tests for affine preconditioner rejection, alias and optional-input paths."""
import ctypes
import struct
import sys

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc import ptx_compare as pc


CASES = (
    'baseline', 'empty', 'partial_count', 'disabled', 'negative_enabled', 'null_flags', 'flags_zero',
    'flags_bit2', 'flags_bit3', 'flags_negative', 'mass_zero', 'mass_negative', 'mass_nan', 'mass_inf',
    'diagonal_zero', 'diagonal_negative', 'diagonal_nan', 'diagonal_inf', 'pinned_bad_diagonal',
    'tiny_diagonal', 'huge_diagonal', 'asymmetric_diagonal', 'cache', 'cache_nan', 'cache_inf',
    'cholesky_failure', 'partial_inverse_failure', 'so3', 'so3_negative', 'so3_nan', 'so3_inf',
    'ell', 'ell_zero_capacity_null_rows', 'ell_null_entries', 'ell_zero_capacity', 'ell_negative_rows',
    'ell_capacity_signed_negative', 'ell_capacity_low32_zero',
    'ell_excess_rows', 'ell_invalid_columns', 'ell_duplicate_columns', 'ell_nan', 'ell_inf', 'ell_signed_zero',
    'cable', 'cable_null_penalty', 'cable_null_active', 'cable_inactive', 'cable_null_bias',
    'cable_zero_nodes', 'cable_negative_nodes', 'cable_duplicate_nodes', 'cable_unmatched_nodes',
    'cable_nan_penalty', 'cable_inf_damping', 'cable_nan_bias', 'cable_zero_nodes_nan_penalty',
)


def run(d, rng):
    original = {}
    for path in sorted(pc.LEGACY_PTX.glob('*.ptx')):
        text = path.read_text()
        for name in pc.entries(text):
            if '32build_affine_body_preconditioner' in name:
                original[name] = text
    reports = {}
    nb, per_world, npw = 12, 4, 16
    ids = rng.permutation(npw).astype(np.int32).reshape(per_world, 4)
    random = rng.normal(scale=.1, size=(3 * npw, 3, 3)).astype(np.float32)
    diagonal = (random @ random.transpose(0, 2, 1) + np.eye(3, dtype=np.float32) * 2).astype(np.float32)
    rotation = rng.normal(size=(nb, 9)).astype(np.float32)
    weight = rng.uniform(.1, 1, per_world).astype(np.float32)
    cache = rng.normal(scale=.02, size=(nb, 12, 12)).astype(np.float32)
    jacobian = rng.normal(scale=.1, size=(nb, 8, 9)).astype(np.float32)
    angular = rng.normal(scale=.1, size=(nb, 8, 9)).astype(np.float32)
    for scalar in (False, True):
        prefix = '32build_affine_body_preconditionerINS_' + ('12NonZeroEntry' if scalar else '17BlockNonZeroEntry')
        text, name = k.legacy_ptx(prefix)
        functions = (d.function(original[name], name), d.function(text, name))
        entries = np.zeros((4, npw), np.dtype([('column', '<i4'),
                           ('value', '<f4')] if scalar else [('column', '<i4'), ('value', '<f4', (9,))]))
        for body in ids:
            for p in body:
                for at, q in enumerate(body):
                    entries[at, p]['column'] = q
                    entries[at, p]['value'] = .01 if scalar else (np.eye(3) * .01).reshape(9)
        for case in CASES:
            print(f'affine branch {"scalar" if scalar else "block"}: {case}', file=sys.stderr, flush=True)
            mass = np.ones(npw, np.float32)
            flags = np.ones(npw, np.int32)
            enabled = np.ones(per_world, np.int32)
            diag, cached, ell, rows = diagonal.copy(), None, None, None
            alpha, total = 0.0, nb
            if case == 'empty': total = 0
            if case == 'partial_count': total = 5
            if case == 'disabled': enabled[:] = 0
            if case == 'negative_enabled': enabled[:] = -1
            if case == 'null_flags': flags = None
            if case.startswith('flags_'):
                flags[:] = {'flags_zero': 0, 'flags_bit2': 2, 'flags_bit3': 3, 'flags_negative': -1}[case]
            if case.startswith('mass_'):
                mass[:] = {'mass_zero': 0, 'mass_negative': -1, 'mass_nan': np.nan, 'mass_inf': np.inf}[case]
            if case.startswith('diagonal_'):
                diag[:, range(3), range(3)] = {'diagonal_zero': 0, 'diagonal_negative': -1,
                                              'diagonal_nan': np.nan, 'diagonal_inf': np.inf}[case]
            if case == 'pinned_bad_diagonal':
                flags[ids[0, 1]] = 0
                diag[ids[0, 1]] = np.nan
            if case in ('tiny_diagonal', 'huge_diagonal'):
                diag[:] = np.eye(3, dtype=np.float32) * (1e-35 if case == 'tiny_diagonal' else 1e35)
            if case == 'asymmetric_diagonal': diag[:, 0, 1] += .2
            if case.startswith('cache') or case == 'cholesky_failure':
                cached = cache.copy()
                if case != 'cache':
                    cached[0, 0, 3] = {'cache_nan': np.nan, 'cache_inf': np.inf, 'cholesky_failure': 20}[case]
                    cached[0, 3, 0] = cached[0, 0, 3]
            if case == 'partial_inverse_failure':
                diag[:] = np.eye(3, dtype=np.float32) * 2
                diag[ids[0, 3]] = np.eye(3, dtype=np.float32) * np.float32(1e-40)
            if case.startswith('so3'):
                alpha = {'so3': .7, 'so3_negative': -1, 'so3_nan': np.nan, 'so3_inf': np.inf}[case]
            if case.startswith('ell'):
                ell, rows = entries.copy(), np.full(npw, 4, np.int32)
                if case == 'ell_zero_capacity_null_rows': rows = None
                if case == 'ell_null_entries': ell = None
                if case == 'ell_negative_rows': rows[:] = -1
                if case == 'ell_excess_rows': rows[:] = 100
                if case == 'ell_invalid_columns': ell[:, ::2]['column'] = -1; ell[:, 1::2]['column'] = npw
                if case == 'ell_duplicate_columns': ell[1:]['column'] = ell[0]['column']
                if case == 'ell_nan': ell['value'] = np.nan
                if case == 'ell_inf': ell['value'] = np.inf
                if case == 'ell_signed_zero':
                    diag[:] = np.full((3, 3), -0.0, np.float32)
                    diag[:, range(3), range(3)] = 2
                    ell['value'] = -0.0
            words = [0] * 20
            offsets, cable_ids = np.zeros(per_world + 1, np.uint64), None
            if case.startswith('cable'):
                offsets = np.arange(per_world + 1, dtype=np.uint64) * 2
                cable_ids = np.repeat(np.arange(per_world, dtype=np.int32), 2)
                cb = {'base': np.full((per_world, 4), .3, np.float32),
                      'penalty': np.full((nb, 4), .7, np.float32),
                      'damping': np.full((per_world, 4), .01, np.float32),
                      'bias': np.full((nb, 3), .05, np.float32), 'active': np.ones(per_world, np.int32),
                      'linear': jacobian, 'angular': angular, 'count': np.full(nb, 8, np.int32),
                      'indices': np.concatenate([np.tile(ids[b % per_world], 2) + (b // per_world) * npw
                                                 for b in range(nb)]).astype(np.int32).reshape(nb, 8)}
                if case == 'cable_null_penalty': cb['penalty'] = None
                if case == 'cable_null_active': cb['active'] = None
                if case == 'cable_inactive': cb['active'][:] = 0
                if case == 'cable_null_bias': cb['bias'] = None
                if case in ('cable_zero_nodes', 'cable_zero_nodes_nan_penalty'): cb['count'][:] = 0
                if case == 'cable_negative_nodes': cb['count'][:] = -1
                if case == 'cable_duplicate_nodes': cb['indices'][:, 1:] = cb['indices'][:, :1]
                if case == 'cable_unmatched_nodes': cb['indices'][:] = -1
                if case in ('cable_nan_penalty', 'cable_zero_nodes_nan_penalty'): cb['penalty'][:] = np.nan
                if case == 'cable_inf_damping': cb['damping'][:] = np.inf
                if case == 'cable_nan_bias': cb['bias'][:] = np.nan
                for off, key in ((48, 'base'), (56, 'penalty'), (64, 'damping'), (88, 'bias'), (96, 'active'),
                                 (104, 'linear'), (112, 'angular'), (120, 'indices'), (128, 'count')):
                    words[off // 8] = 0 if cb[key] is None else d.upload(cb[key]).value
                words[17:20] = [per_world, nb, npw]
            view = (ctypes.c_char * 160).from_buffer_copy(struct.pack('<20Q', *words))
            before = rng.normal(size=(nb + 3, 144)).astype(np.float32)
            valid_before = np.full(nb + 3, -19, np.int32)
            pointer = lambda array: k.null() if array is None else d.upload(array)
            params = [pointer(ids), pointer(weight), pointer(mass), pointer(flags),
                      pointer(diag.transpose(0, 2, 1).copy().reshape(-1, 9)), pointer(rows), pointer(ell),
                      k.u64(0 if ell is None or case.startswith('ell_zero_capacity') else
                            2**31 if case == 'ell_capacity_signed_negative' else
                            2**32 if case == 'ell_capacity_low32_zero' else len(ell)), k.u64(npw),
                      pointer(rotation), k.f32(alpha), view, pointer(offsets), pointer(cable_ids), k.f32(23.7),
                      pointer(enabled), pointer(cached), k.null(), k.null(), k.u64(total), k.u64(per_world), k.u64(npw)]
            outputs = []
            for fun in functions:
                params[17], params[18] = d.upload(before), d.upload(valid_before)
                d.launch(fun, nb + 3, params, block=32)
                outputs.append((d.download(params[17], before), d.download(params[18], valid_before)))
            tag = f'{"scalar" if scalar else "block"}_{case}'
            reports[tag + '_inverse'] = k.compare(tag, outputs[0][0], outputs[1][0])
            reports[tag + '_valid'] = k.compare(tag, outputs[0][1], outputs[1][1])
            if case == 'partial_inverse_failure':
                changed = np.count_nonzero(outputs[0][0][0].view(np.uint32) != before[0].view(np.uint32))
                reports[tag + '_partial_writes_exercised'] = k.compare(
                    tag, np.array([0 < changed < 144 and outputs[0][1][0] == 0], np.int32), np.array([1], np.int32))
    return reports
