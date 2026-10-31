"""Original PTX A/B for CUB radix/reduction entry instances still missing after the scan audit."""
import argparse
import ctypes
import json
from pathlib import Path
import re
import struct
import numpy as np
from reconstruction import auxiliary
from reconstruction.kernel_ab import Driver, F, LEGACY_SHA, ROOT, compare, legacy_ptx, f32, null


def entries(family):
    legacy_ptx('19update_cg_directionIfEE')
    seen = set()
    for path in sorted((ROOT/'build/reconstruction-ptx'/LEGACY_SHA[:16]).glob('*.ptx')):
        text = path.read_text()
        matches = list(re.finditer(r'\.entry\s+(\w+)\(', text))
        for i, match in enumerate(matches):
            name = match[1]
            if name in seen or not name.startswith('_ZN3cub') or family not in name:
                continue
            seen.add(name)
            end = matches[i+1].start() if i+1 < len(matches) else len(text)
            yield text, name, text[match.start():end]


def histogram(d, rng):
    result = {}
    for text, name, entry in entries('DeviceRadixSortHistogramKernel'):
        fun = d.function(text, name)
        for n in (0, 1, 2047, 2048, 2049, 12345):
            keys = rng.integers(0, 2**32, n, dtype=np.uint32)
            for begin, end in ((0, 32), (7, 19), (3, 4), (31, 32)):
                for blocks in (1, 3):
                    before = rng.integers(0, 2**32, ((end-begin+7)//8)*256+8, dtype=np.uint32)
                    expected = before.copy()
                    auxiliary.radix_histogram_u32(keys, expected, begin, end)
                    out, kp = d.upload(before), d.upload(keys)
                    params = [out, kp, ctypes.c_uint32(n), ctypes.c_int32(begin), ctypes.c_int32(end),
                              (ctypes.c_char*1)()]
                    d.launch(fun, blocks*256, params)
                    key = f'{name}/{n}/{begin}/{end}/{blocks}'
                    result[key] = compare(key, expected, d.download(out, before))
                    if n:
                        result[key+'/keys'] = compare(key, keys, d.download(kp, keys))
                    d.free()
    return result


def single_sort(d, rng):
    result = {}
    for text, name, entry in entries('DeviceRadixSortSingleTileKernel'):
        fun = d.function(text, name)
        for n in (0, 1, 255, 4863, 4864):
            keys = rng.integers(0, 2**32, n, dtype=np.uint32)
            keys[::7] = 0xffffffff
            values = rng.integers(0, 2**32, n, dtype=np.uint32)
            for begin, end in ((0, 32), (7, 19), (3, 4), (31, 32)):
                outk = rng.integers(0, 2**32, n+8, dtype=np.uint32)
                outv = rng.integers(0, 2**32, n+8, dtype=np.uint32)
                expected_k, expected_v = outk.copy(), outv.copy()
                expected_k[:n], expected_v[:n] = auxiliary.radix_sort_pairs(keys, values, begin, end)
                kp, vp, ko, vo = map(d.upload, (keys, values, outk, outv))
                d.launch(fun, 256, [kp, ko, vp, vo, ctypes.c_uint32(n), ctypes.c_int32(begin),
                                    ctypes.c_int32(end), (ctypes.c_char*1)()])
                key = f'{name}/{n}/{begin}/{end}'
                result[key+'/keys'] = compare(key, expected_k, d.download(ko, outk))
                result[key+'/values'] = compare(key, expected_v, d.download(vo, outv))
                if n:
                    result[key+'/input'] = compare(key, keys, d.download(kp, keys))
                d.free()
    return result


def sweeps(d, rng):
    result = {}
    downs = {name: (text, entry) for text, name, entry in entries('DeviceRadixSortDownsweepKernel')}
    for text, name, entry in entries('DeviceRadixSortUpsweepKernel'):
        alt = 'ELb1ELb0E' in name
        signed = 'PolicyIjijE' in name
        dn = next(n for n in downs if ('ELb1ELb0E' in n) == alt and ('PolicyIjijE' in n) == signed)
        up, down = d.function(text, name), d.function(downs[dn][0], dn)
        tile, threads, bins = (4096, 256, 64) if alt else (6240, 160, 128)
        for n in (1, tile-1, tile, tile+1, tile*7+13):
            keys = rng.integers(0, 2**32, n, dtype=np.uint32)
            keys[::5] = 0xffffffff
            if n == tile:
                keys[:] = 77
            values = rng.integers(0, 2**32, n, dtype=np.uint32)
            for max_grid in (1, 3):
                desc, ranges = auxiliary.grid_even_share(n, max_grid, tile)
                grid = len(ranges)
                view = (ctypes.c_char*40).from_buffer_copy(desc.tobytes())
                for begin, bits in ((0, 6 if alt else 7), (13, 3)):
                    hist = rng.integers(0, 2**32, bins*grid+8, dtype=np.uint32)
                    expected = hist.copy()
                    expected[:bins*grid] = auxiliary.radix_upsweep(keys, ranges, begin, bits, bins)
                    kp, vp, hp = map(d.upload, (keys, values, hist))
                    params = [kp, hp, ctypes.c_uint32(n), ctypes.c_int32(begin), ctypes.c_int32(bits),
                              view, (ctypes.c_char*1)()]
                    d.launch(up, grid*threads, params, block=threads)
                    key = f'{name}/{n}/{grid}/{begin}/{bits}'
                    result[key] = compare(key, expected, d.download(hp, hist))
                    offsets = expected[:bins*grid].copy()
                    auxiliary.exclusive_sum_u32(offsets, len(offsets))
                    ko_before = rng.integers(0, 2**32, n+8, dtype=np.uint32)
                    vo_before = rng.integers(0, 2**32, n+8, dtype=np.uint32)
                    ek, ev = ko_before.copy(), vo_before.copy()
                    auxiliary.radix_downsweep(keys, values, ranges, offsets, begin, bits, ek, ev)
                    ko, vo, sp = map(d.upload, (ko_before, vo_before, offsets))
                    d.launch(down, grid*threads, [kp, ko, vp, vo, sp, ctypes.c_uint32(n),
                                                 ctypes.c_int32(begin), ctypes.c_int32(bits), view,
                                                 (ctypes.c_char*1)()], block=threads)
                    key = f'{dn}/{n}/{grid}/{begin}/{bits}'
                    result[key+'/keys'] = compare(key, ek, d.download(ko, ko_before))
                    result[key+'/values'] = compare(key, ev, d.download(vo, vo_before))
                    result[key+'/spine'] = compare(key, offsets, d.download(sp, offsets))
                    result[key+'/input'] = compare(key, keys, d.download(kp, keys))
                    d.free()
    return result


def reductions(d, rng):
    result = {}
    for family in ('DeviceReduceSingleTileKernel', 'DeviceReduceKernel'):
        single = family == 'DeviceReduceSingleTileKernel'
        for text, name, entry in entries(family):
            box = '4Aabb' in name
            transformed = '.param .align' in entry.splitlines()[1]
            mat = 'PreconditionedResidualInnerProductIN3glm' in name
            scalar = 'PreconditionedResidualInnerProductIf' in name
            wide = bool(re.search(r'\.param \.u64 \w+_param_2', entry))
            tile = 768 if box else 5120
            fun = d.function(text, name)
            for n in ((0, 1, 31, 257, tile-1, tile, tile+1, tile*3+17) if single else
                      (1, 257, tile-1, tile, tile+1, tile*7+17)):
                a = rng.normal(size=(n, 6 if box else 3)).astype(F)
                if box:
                    a[:, 3:] = a[:, :3]+np.abs(a[:, 3:])
                b = rng.normal(size=(n, 9) if mat else (n,) if scalar else (n, 3)).astype(F)
                raw = rng.normal(size=n).astype(F)
                kind = ('centroid_aabb' if transformed else 'aabb') if box else (
                    'raw_float' if not transformed else 'block_residual' if mat else
                    'scalar_residual' if scalar else 'dot')
                for grid in ((1,) if single else tuple(sorted({1, min(3, (n+tile-1)//tile)}))):
                    init = rng.normal(size=6).astype(F) if box else F(rng.normal())
                    output = rng.normal(size=(grid+3, 6) if box else grid+3).astype(F)
                    expected = output.copy()
                    source_input = raw if kind == 'raw_float' else a
                    source_result = auxiliary.cub_reduce(source_input, b, kind,
                                                         grid=None if single else grid, initial=init if single else None)
                    if single:
                        expected[0] = source_result
                    else:
                        expected[:grid] = source_result
                    ap, bp, rp, op = map(d.upload, (a, b, raw, output))
                    if transformed:
                        payload = struct.pack('<QQ', ap.value, 0 if box else bp.value)
                        if not box:
                            payload += bytes(8)
                        input_arg = (ctypes.c_char*len(payload)).from_buffer_copy(payload)
                    else:
                        input_arg = ap if box else rp
                    count = ctypes.c_uint64(n) if wide else ctypes.c_uint32(n)
                    if single:
                        init_arg = (ctypes.c_char*24).from_buffer_copy(init.tobytes()) if box else f32(init)
                        params = [input_arg, op, count, (ctypes.c_char*1)(), init_arg]
                    else:
                        desc, _ = auxiliary.grid_even_share(n, grid, tile)
                        if wide:
                            payload = struct.pack('<iiQQQQi4xQQQ', *[int(v) for v in desc])
                        else:
                            payload = desc.tobytes()
                        params = [input_arg, op, count, (ctypes.c_char*len(payload)).from_buffer_copy(payload),
                                  (ctypes.c_char*1)()]
                    d.launch(fun, grid*256, params)
                    key = f'{name}/{n}/{grid}'
                    result[key] = compare(key, expected, d.download(op, output))
                    if not result[key]['bitwise_equal']:
                        result[key]['expected'] = expected.tolist()
                        result[key]['actual'] = d.download(op, output).tolist()
                    d.free()
    return result


def onesweep(d, rng):
    result = {}
    for text, name, entry in entries('DeviceRadixSortOnesweepKernel'):
        fun = d.function(text, name)
        for n in (0, 1, 5375, 5376, 5377, 5376*3+13):
            grid = max(1, (n+5375)//5376)
            keys = rng.integers(0, 2**32, n, dtype=np.uint32)
            keys[::7] = 0xffffffff
            if n == 5376:
                keys[:] = 77
            values = rng.integers(0, 2**32, n, dtype=np.uint32)
            for begin, bits in ((0, 8), (11, 5), (31, 1)):
                digit = ((keys >> begin) & ((1 << bits)-1)).astype(np.int64)
                bins = np.bincount(digit, minlength=256).astype(np.uint32)
                auxiliary.exclusive_sum_u32(bins, 256)
                bins += 7
                for write_bins in (False, True):
                    ko = rng.integers(0, 2**32, n+15, dtype=np.uint32)
                    vo = rng.integers(0, 2**32, n+15, dtype=np.uint32)
                    lb = np.zeros(grid*256+8, np.uint32)
                    lb[-8:] = 0x13579
                    bo = rng.integers(0, 2**32, 264, dtype=np.uint32)
                    counter = np.array([0, 0x1234], np.uint32)
                    expected = [v.copy() for v in (ko, vo, lb, bo, counter)]
                    auxiliary.radix_onesweep(keys, values, bins, begin, bits, *expected[:3],
                                             expected[3] if write_bins else None, expected[4])
                    kop, vop, lbp, bop, cp = map(d.upload, (ko, vo, lb, bo, counter))
                    kp, vp, bp = map(d.upload, (keys, values, bins))
                    params = [lbp, cp, bop if write_bins else null(), bp, kop, kp, vop, vp,
                              ctypes.c_int32(n), ctypes.c_int32(begin), ctypes.c_int32(bits), (ctypes.c_char*1)()]
                    d.launch(fun, grid*256, params)
                    key = f'{name}/{n}/{begin}/{bits}/{write_bins}'
                    for field, ptr, before, exp in zip(('keys', 'values', 'lookback', 'bins', 'counter'),
                                                       (kop, vop, lbp, bop, cp), (ko, vo, lb, bo, counter), expected):
                        result[key+'/'+field] = compare(field, exp, d.download(ptr, before))
                    result[key+'/bins_input'] = compare(key, bins, d.download(bp, bins))
                    if n:
                        result[key+'/keys_input'] = compare(key, keys, d.download(kp, keys))
                    d.free()
    return result


class SignedZeroInputs:
    """Deterministic signed-zero stress inputs for reduction arithmetic and min/max ties."""
    def normal(self, size=None):
        if size is None:
            return 0.0
        value = np.zeros(size)
        value.reshape(-1)[1::2] = -0.0
        return value


def run(d, rng):
    result = histogram(d, rng)
    result.update(single_sort(d, rng))
    result.update(sweeps(d, rng))
    result.update(reductions(d, rng))
    result.update(onesweep(d, rng))
    result.update({key+'/signed_zero': value for key, value in reductions(d, SignedZeroInputs()).items()})
    return result


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--seed', type=int, default=1)
    p.add_argument('--output', type=Path, required=True)
    args = p.parse_args()
    d = Driver()
    try:
        cases = run(d, np.random.default_rng(args.seed))
    finally:
        d.free()
    passed = all(c['bitwise_equal'] for c in cases.values())
    args.output.write_text(json.dumps({'legacy_sha256': LEGACY_SHA, 'seed': args.seed,
                                      'passed': passed, 'cases': cases}, indent=2)+'\n')
    print('passed', passed, 'checks', len(cases))
    print('failures', {k: v for k, v in cases.items() if not v['bitwise_equal']})
    raise SystemExit(0 if passed else 1)


if __name__ == '__main__':
    main()
