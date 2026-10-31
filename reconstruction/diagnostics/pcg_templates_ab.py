"""A/B for the three template instances omitted by the earlier base-name coverage metric."""
import argparse
import ctypes
import json
from pathlib import Path
import numpy as np
from reconstruction import pcg
from reconstruction.kernel_ab import Driver, F, LEGACY_SHA, compare, f32, legacy_ptx, null, u64


def run(d, rng):
    result = {}
    def kernel(prefix):
        return d.function(*legacy_ptx(prefix))
    scalar_direction = kernel('19update_cg_directionIfEE')
    for n in (1, 33, 513):
        residual = rng.normal(size=(n, 3)).astype(F)
        direction = rng.normal(size=(n+7, 3)).astype(F)
        preconditioner = rng.uniform(-1, 3, n).astype(F)
        preconditioner[::7] = 0
        nums = np.array([1, 2, 0, 3, 1e-35, 4, np.nan, 2, np.inf, 0, -3], F)
        for k in (-1, 0, 1, 3, 5, 7, 9, 10):
            pp, rp, nptr, output = map(d.upload, (preconditioner, residual, nums, direction))
            d.launch(scalar_direction, n, [ctypes.c_int32(k), pp, rp, nptr, output, u64(n)])
            expected = direction.copy()
            expected[:n] = pcg.update_cg_direction(k, preconditioner, residual, nums, direction[:n])
            key = f'direction/{n}/{k}'
            result[key] = compare(key, expected, d.download(output, direction))
            result[key+'/input'] = compare(key, residual, d.download(rp, residual))
        diag = rng.normal(size=(n, 9)).astype(F)
        x, b, extra = [rng.normal(size=(n, 3)).astype(F) for _ in range(3)]
        slots = 5
        rows = rng.integers(-2, slots+3, n, dtype=np.int32)
        cols = rng.integers(-2, n+2, (slots, n), dtype=np.int32)
        for blocks in (False, True):
            value_shape = (slots, n, 9) if blocks else (slots, n)
            values = rng.normal(size=value_shape).astype(F)
            dtype = np.dtype([('col', np.int32), ('value', F, (9,))]) if blocks else np.dtype(
                [('col', np.int32), ('value', F)])
            entries = np.zeros((slots, n), dtype=dtype)
            entries['col'], entries['value'] = cols, values
            prefix = '17evaluate_residualINS_'+('17BlockNonZeroEntry' if blocks else '12NonZeroEntry')+'EN3glm'
            fun = kernel(prefix)
            for use_extra in (False, True):
                for empty in (False, True):
                    before = rng.normal(size=(n+7, 3)).astype(F)
                    xp, bp, dp, output = map(d.upload, (x, b, diag, before))
                    d.launch(fun, n, [null() if empty else d.upload(rows), null() if empty else d.upload(entries),
                                     u64(0 if empty else slots), dp, xp, bp,
                                     d.upload(extra) if use_extra else null(), output, u64(n), u64(n)])
                    expected = before.copy()
                    expected[:n] = pcg.evaluate_residual(rows, cols, values, 0 if empty else slots, diag, x, b,
                                                         extra if use_extra else None)
                    key = f'residual/{n}/{blocks}/{use_extra}/{empty}'
                    result[key] = compare(key, expected, d.download(output, before))
                    for label, ptr, value in (('x', xp, x), ('b', bp, b), ('diag', dp, diag)):
                        result[key+'/'+label] = compare(label, value, d.download(ptr, value))
        d.free()
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
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps({'legacy_sha256': LEGACY_SHA, 'seed': args.seed,
                                      'passed': passed, 'cases': cases}, indent=2)+'\n')
    print('passed', passed, 'checks', len(cases))
    print('failures', {k: v for k, v in cases.items() if not v['bitwise_equal']})
    raise SystemExit(0 if passed else 1)


if __name__ == '__main__':
    main()
