"""A/B of both signed/unsigned value-template CUB radix histogram scan helpers."""
import argparse
import ctypes
import json
from pathlib import Path
import re
import numpy as np
from reconstruction import auxiliary
from reconstruction.kernel_ab import Driver, LEGACY_SHA, ROOT, compare, legacy_ptx


def run(d, rng):
    legacy_ptx('19update_cg_directionIfEE')
    seen, results = set(), {}
    for path in sorted((ROOT/'build/reconstruction-ptx'/LEGACY_SHA[:16]).glob('*.ptx')):
        text = path.read_text()
        for name in re.findall(r'\.entry (\w+)\(', text):
            if name in seen or not any(part in name for part in ('RadixSortScanBinsKernel',
                                                                 'DeviceRadixSortExclusiveSumKernel')):
                continue
            seen.add(name)
            segmented = 'ExclusiveSumKernel' in name
            fun = d.function(text, name)
            counts = (256, 768, 1024) if segmented else (0, 1, 511, 512, 11775, 11776, 11777, 23559)
            for count in counts:
                for overflow in (False, True):
                    before = rng.integers(0, 2**32 if overflow else 1000, count+8, dtype=np.uint32)
                    expected = before.copy()
                    auxiliary.exclusive_sum_u32(expected, count, 256 if segmented else None)
                    ptr = d.upload(before)
                    params = [ptr] if segmented else [ptr, ctypes.c_int32(count)]
                    d.launch(fun, count if segmented else 512, params, block=256 if segmented else 512)
                    key = f'{name}/{count}/{overflow}'
                    results[key] = compare(key, expected, d.download(ptr, before))
                    d.free()
    return results


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
