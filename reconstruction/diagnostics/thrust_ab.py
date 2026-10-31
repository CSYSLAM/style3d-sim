"""Validate every embedded Thrust fill/sequence symbol and CUB's empty kernel."""
import argparse
import ctypes
import json
from pathlib import Path
import re
import struct
import numpy as np
from reconstruction import auxiliary
from reconstruction.kernel_ab import Driver, LEGACY_SHA, ROOT, legacy_ptx, u64


def definitions():
    legacy_ptx('19update_cg_directionIfEE')  # Verify reference hash and ensure full extraction exists.
    seen = set()
    for path in sorted((ROOT/'build/reconstruction-ptx'/LEGACY_SHA[:16]).glob('*.ptx')):
        text = path.read_text()
        matches = list(re.finditer(r'\.entry\s+(\w+)\(', text))
        for index, match in enumerate(matches):
            name = match[1]
            if name in seen or not name.startswith('_ZN6thrust'):
                continue
            seen.add(name)
            end = matches[index+1].start() if index+1 < len(matches) else len(text)
            yield text, name, text[match.start():end]


def width(name):
    if '3matILi3ELi3Ef' in name:
        return 36
    vector = re.search(r'3vecILi(\d)E[fi]', name)
    if vector:
        return int(vector[1])*4
    for marker, size in [('17BlockNonZeroEntry', 40), ('12NonZeroEntry', 8), ('4Aabb', 24),
                         ('device_ptrIh', 1), ('device_ptrIf', 4), ('device_ptrIi', 4), ('device_ptrIj', 4)]:
        if marker in name:
            return size
    raise ValueError('Unreviewed element type: '+name)


def compare_bytes(ref, actual):
    ref, actual = ref.view(np.uint8), actual.view(np.uint8)
    return {'bitwise_equal': bool(np.array_equal(ref, actual)),
            'mismatches': int(np.count_nonzero(ref != actual)), 'elements': int(ref.size)}


def run(d, rng):
    results = {}
    for text, name, entry in definitions():
        size = width(name)
        param_size = int(re.search(r'\.param \.align 8 \.b8 [^\[]+\[(\d+)\]', entry)[1])
        assert '512;' in entry and '.maxntid 256, 1, 1' in entry
        function = d.function(text, name)
        for count in (0, 1, 255, 256, 511, 512, 513, 1025):
            before = rng.integers(0, 256, (count+8)*size, dtype=np.uint8)
            expected = before.copy()
            output = d.upload(before)
            if '__tabulate' in name:
                initial, step = (2147483640, 1073741823) if count > 256 else (-23, -7)
                value = struct.pack('<ii', initial, step)
                auxiliary.sequence_int32(expected.view(np.int32), initial, step, count)
            else:
                raw_value = rng.integers(0, 256, size, dtype=np.uint8)
                value = raw_value.tobytes()
                auxiliary.fill_bytes(expected, raw_value, count)
            raw = (struct.pack('<Q', output.value)+value).ljust(param_size, b'\xa5')
            param = (ctypes.c_char*param_size).from_buffer_copy(raw)
            # Each 256-thread block handles 512 items. Extra unsigned-count blocks would overrun.
            d.launch(function, max(1, (count+511)//512)*256, [param, u64(count)])
            results[f'{name}/{count}'] = compare_bytes(expected, d.download(output, before))
            d.free()
    for path in sorted((ROOT/'build/reconstruction-ptx'/LEGACY_SHA[:16]).glob('*.ptx')):
        text = path.read_text()
        match = re.search(r'\.entry (_ZN3cub\w*EmptyKernel\w*)\(', text)
        if match:
            fun = d.function(text, match[1])
            before = rng.integers(0, 256, 64, dtype=np.uint8)
            ptr = d.upload(before)
            d.launch(fun, 256, [])
            auxiliary.empty()
            results[match[1]] = compare_bytes(before, d.download(ptr, before))
            d.free()
            break
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
