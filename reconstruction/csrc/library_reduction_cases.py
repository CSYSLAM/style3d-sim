"""Literal old/new CUDA reduction comparisons for exceptional values and input/output preservation."""
import ctypes
import struct

import numpy as np

from reconstruction import auxiliary
from reconstruction import kernel_ab as k


def run(driver, rng, reference, source):
    reports, used = {}, set()
    for name in sorted(source):
        if 'DeviceReduce' not in name: continue
        old_module, entry = reference[name]
        functions = driver.function(old_module, name), driver.function(source[name], name)
        used.add(name)
        single, box = 'SingleTileKernel' in name, '4Aabb' in name
        transformed = '.param .align' in entry.splitlines()[1]
        matrix = 'PreconditionedResidualInnerProductIN3glm' in name
        scalar = 'PreconditionedResidualInnerProductIf' in name
        wide = f'.param .u64 {name}_param_2' in entry
        tile = 768 if box else 5120
        for count in ((0, 1, 257, tile + 1) if single else (1, 257, tile + 1)):
            grids = (1,) if single else tuple(sorted({1, min(3, (count + tile - 1) // tile)}))
            for case in ('nan_payload', 'infinities', 'signed_zero', 'initial_nan', 'initial_negative_zero'):
                a = rng.normal(size=(count, 6 if box else 3)).astype(np.float32)
                b = rng.normal(size=(count, 9) if matrix else (count,) if scalar else (count, 3)).astype(np.float32)
                raw = rng.normal(size=count).astype(np.float32)
                initial = rng.normal(size=6 if box else 1).astype(np.float32)
                if case == 'nan_payload':
                    bits = np.array([0x7fc00001, 0xffc00002, 0x7fa01234, 0xffa05678,
                                     0x3f800000, 0xbf800000, 0, 0x80000000], np.uint32)
                elif case == 'infinities':
                    bits = np.array([0x7f800000, 0xff800000, 0x7f7fffff, 0xff7fffff,
                                     1, 0x80000001, 0, 0x80000000], np.uint32)
                else: bits = np.array([0, 0x80000000], np.uint32)
                if case in ('nan_payload', 'infinities', 'signed_zero'):
                    for array in (a, b, raw): array.view(np.uint32).flat[:] = np.resize(bits, array.size)
                if case == 'initial_nan': initial.view(np.uint32)[:] = 0xffc01234
                if case == 'initial_negative_zero': initial.view(np.uint32)[:] = 0x80000000
                for grid in grids:
                    before = rng.normal(size=(grid + 3, 6) if box else grid + 3).astype(np.float32)
                    outputs = []
                    for backend, function in enumerate(functions):
                        ap, bp, rp, op = [driver.upload(x) for x in (a, b, raw, before)]
                        input_arg = ap if box else rp
                        if transformed:
                            payload = struct.pack('<QQ', ap.value, 0 if box else bp.value) + (b'' if box else bytes(8))
                            input_arg = (ctypes.c_char * len(payload)).from_buffer_copy(payload)
                        amount = ctypes.c_uint64(count) if wide else ctypes.c_uint32(count)
                        if single:
                            params = [input_arg, op, amount, (ctypes.c_char * 1)(),
                                      (ctypes.c_char * initial.nbytes).from_buffer_copy(initial.tobytes())]
                        else:
                            desc, _ = auxiliary.grid_even_share(count, grid, tile)
                            payload = struct.pack('<iiQQQQi4xQQQ', *map(int, desc)) if wide else desc.tobytes()
                            params = [input_arg, op, amount, (ctypes.c_char * len(payload)).from_buffer_copy(payload),
                                      (ctypes.c_char * 1)()]
                        driver.launch(function, grid * 256, params)
                        outputs.append(driver.download(op, before))
                        for field, pointer, expected in (('a', ap, a), ('b', bp, b), ('raw', rp, raw)):
                            if not expected.size: continue
                            label = f'{name}/{case}/{count}/{grid}/backend{backend}/{field}'
                            reports[label] = k.compare(field, expected, driver.download(pointer, expected))
                        driver.free()
                    label = f'{name}/{case}/{count}/{grid}/output'
                    reports[label] = k.compare(label, outputs[0], outputs[1])
    return reports, used
