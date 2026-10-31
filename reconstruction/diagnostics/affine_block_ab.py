"""Targeted A/B for build_affine_body_preconditioner, with explicit feature coverage."""
import argparse
import ctypes
import json
from pathlib import Path
import struct

import numpy as np
from reconstruction import affine_preconditioner as ap
from reconstruction.kernel_ab import Driver, legacy_ptx, compare, u64, f32, null, LEGACY_SHA
from reconstruction.numerics import F


def run(d, rng, scalar=False):
    ptx, symbol = legacy_ptx('32build_affine_body_preconditionerINS_'+
                             ('12NonZeroEntry' if scalar else '17BlockNonZeroEntry'))
    fun = d.function(ptx, symbol)
    # Only the register-level assembly probe uses original fixed labels; the actual inverse launch above
    # remains selected by RECONSTRUCTION_KERNELS.
    from reconstruction.csrc import ptx_compare
    ptx = next(path.read_text() for path in sorted(ptx_compare.LEGACY_PTX.glob('*.ptx'))
               if symbol in ptx_compare.entries(path.read_text()))
    # Diagnostic-only exit after assembly; arithmetic before this point is unchanged.
    start = ptx.index('.entry '+symbol)
    label = '$L__BB82_264:' if scalar else '$L__BB81_264:'
    pos = ptx.index(label, start)+len(label)
    probe = f"""
ld.param.u64 %rd440, [{symbol}_param_17];
mul.lo.s64 %rd441, %rd4, 576;
add.s64 %rd440, %rd440, %rd441;
mov.u32 %r300, 0;
PROBE_LOOP:
mul.wide.u32 %rd442, %r300, 4;
add.s64 %rd443, %rd1, %rd442;
ld.local.f32 %f4400, [%rd443];
add.s64 %rd444, %rd440, %rd442;
st.global.f32 [%rd444], %f4400;
add.u32 %r300, %r300, 1;
setp.lt.u32 %p320, %r300, 144;
@%p320 bra PROBE_LOOP;
ret;
"""
    probe_fun = d.function(ptx[:pos]+probe+ptx[pos:], symbol)
    result = {}
    nb, per_world, npw = 12, 6, 24
    ids = rng.permutation(npw).astype(np.int32).reshape(per_world, 4)
    mass = np.ones(npw, F)
    flags = np.ones(npw, np.int32)
    flags[ids[1, 1]] = 0
    mass[ids[2, 3]] = 0
    enabled = np.ones(per_world, np.int32)
    enabled[-1] = 0
    weight = rng.uniform(.2, 1, per_world).astype(F)
    rotation = rng.normal(size=(nb, 9)).astype(F)
    dt = F(23.7)
    for case in ('diagonal', 'cache', 'ell', 'so3', 'cable', 'combined', 'indefinite', 'bounds', 'no_flags'):
        dense = rng.normal(scale=.08, size=(nb, 12, 12)).astype(F)
        dense = (dense @ dense.transpose(0, 2, 1)+np.eye(12, dtype=F)*F(2)).astype(F)
        diagonal = np.zeros((2*npw, 9), F)
        for b in range(nb):
            for j, p in enumerate(ids[b % per_world]+(b//per_world)*npw):
                diagonal[p] = dense[b, 3*j:3*j+3, 3*j:3*j+3].T.reshape(9)
        cache = dense.copy() if case in ('cache', 'combined') else None
        entries = None
        rows = None
        if case in ('ell', 'combined', 'bounds'):
            entries = np.zeros((4, npw), np.dtype([('col', '<i4'), ('value', '<f4')] if scalar else
                                                        [('col', '<i4'), ('value', '<f4', (9,))]))
            rows = np.full(npw, 4, np.int32)
            for ids_b in ids:
                for i, p in enumerate(ids_b):
                    for j, q in enumerate(ids_b):
                        entries[j, p]['col'] = q
                        v = F(.01 if i != j else .1)
                        entries[j, p]['value'] = v if scalar else (np.eye(3, dtype=F)*v).reshape(9)
            if case == 'bounds':
                rows[ids[0, 0]], rows[ids[1, 0]] = -1, 100
                entries[0, ids[2, 0]]['col'] = -1
                entries[1, ids[2, 0]]['col'] = npw
        alpha = F(.7 if case in ('so3', 'combined') else 0)
        if case == 'indefinite':
            diagonal[ids[0, 0], 0] = -1
            diagonal[ids[1, 0], [0, 4, 8]] = [1, 1, 1]
            diagonal[ids[1, 0], [1, 3]] = 2
        cb = None
        offsets = np.zeros(per_world+1, np.uint64)
        cable_ids = np.zeros(per_world, np.int32)
        view = (ctypes.c_char*160)()
        if case in ('cable', 'combined'):
            offsets = np.arange(per_world+1, dtype=np.uint64)
            cable_ids = np.arange(per_world, dtype=np.int32)
            cb = {'per_world': per_world, 'count': np.full(nb, 4, np.int32),
                  'indices': np.full((nb, 8), -1, np.int32),
                  'linear': rng.normal(scale=.1, size=(nb, 8, 9)).astype(F),
                  'angular': rng.normal(scale=.1, size=(nb, 8, 9)).astype(F),
                  'base': rng.uniform(.1, 2, (per_world, 4)).astype(F),
                  'damping': rng.uniform(.001, .01, (per_world, 4)).astype(F),
                  'active': np.ones(per_world, np.int32),
                  'penalty': None, 'bias': None}
            for b in range(nb):
                cb['indices'][b, :4] = ids[b % per_world]+(b//per_world)*npw
            if case == 'combined':
                cb['active'][2] = 0
                offsets = np.arange(per_world+1, dtype=np.uint64)*2
                cable_ids = np.repeat(cable_ids, 2)
                cb['count'][:] = 7
                cb['count'][0] = 0
                cb['indices'][:, 4:7] = cb['indices'][:, :3]
                cb['penalty'] = rng.uniform(.1, 2, (nb, 4)).astype(F)
                cb['bias'] = rng.uniform(0, .3, (nb, 3)).astype(F)
            words = [0]*20
            for off, name in ((48, 'base'), (56, 'penalty'), (64, 'damping'), (88, 'bias'), (96, 'active'),
                              (104, 'linear'), (112, 'angular'), (120, 'indices'), (128, 'count')):
                words[off//8] = 0 if cb[name] is None else d.upload(cb[name]).value
            words[17] = per_world
            view = (ctypes.c_char*160).from_buffer_copy(struct.pack('<20Q', *words))
        before = rng.normal(size=(nb, 144)).astype(F)
        out, valid = d.upload(before), d.upload(np.full(nb, -19, np.int32))
        params = [d.upload(ids), d.upload(weight), d.upload(mass),
                          null() if case == 'no_flags' else d.upload(flags), d.upload(diagonal),
                          null() if rows is None else d.upload(rows), null() if entries is None else d.upload(entries),
                          u64(0 if entries is None else len(entries)), u64(npw), d.upload(rotation), f32(alpha), view,
                          d.upload(offsets), d.upload(cable_ids), f32(dt), d.upload(enabled),
                          null() if cache is None else d.upload(cache), out, valid, u64(nb), u64(per_world), u64(npw)]
        d.launch(fun, nb, params)
        actual, ok = before.copy(), np.full(nb, -19, np.int32)
        matrices = before.reshape(nb, 12, 12).copy()
        ap.build(ids, mass, None if case == 'no_flags' else flags, diagonal, enabled, actual, ok,
                 npw, rows, entries, npw, cache,
                 weight, rotation, alpha, offsets, cable_ids, cb, dt, matrices)
        native, native_ok = d.download(out, before), d.download(valid, ok)
        result[case] = {'inverse': compare('inverse', native, actual), 'valid': compare('valid', native_ok, ok)}
        if probe_fun is not None:
            probe_out = d.upload(before)
            params[17] = probe_out
            d.launch(probe_fun, nb, params)
            native_matrix = d.download(probe_out, before).reshape(nb, 12, 12)
            result[case]['assembly_probe'] = compare('matrix', native_matrix, matrices)
            bad = np.argwhere(native_matrix.view(np.uint32) != matrices.view(np.uint32))
            result[case]['assembly_probe']['locations'] = bad.tolist()
        print(case, result[case], flush=True)
    return result


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--scalar', action='store_true')
    p.add_argument('--seed', type=int, default=1)
    p.add_argument('--output', type=Path, required=True)
    args = p.parse_args()
    d = Driver()
    try:
        result = run(d, np.random.default_rng(args.seed), args.scalar)
    finally:
        d.free()
    passed = all(v['bitwise_equal'] for c in result.values() for v in c.values())
    args.output.write_text(json.dumps({'legacy_sha256': LEGACY_SHA, 'seed': args.seed,
                                      'passed': passed, 'scalar': args.scalar, 'cases': result}, indent=2)+'\n')
    raise SystemExit(0 if passed else 1)


if __name__ == '__main__':
    main()
