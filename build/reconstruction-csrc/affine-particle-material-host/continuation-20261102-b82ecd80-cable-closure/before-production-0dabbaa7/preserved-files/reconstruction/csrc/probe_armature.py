"""Compare original and compiled armature calls, isolating each joint coefficient when a call differs."""
import ctypes
import json
import os
import struct
import sys

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc import ptx_compare as pc


def main():
    if os.environ.get('RECONSTRUCTION_KERNELS'):
        raise RuntimeError('Run without RECONSTRUCTION_KERNELS so the reference stays original')
    seed = int(sys.argv[1]) if len(sys.argv) > 1 else 1
    source = pc.compile_ptx(pc.CSRC/'kernels/joints.cu', pc.DEFAULT_NVCC)
    legacy, name = k.legacy_ptx('23evaluate_joint_armature')
    driver = k.Driver()
    original_function, original_launch = driver.function, driver.launch
    reference, compiled = original_function(legacy, name), original_function(source, name)
    report = []

    def function(ptx, symbol):
        return reference if symbol == name else original_function(ptx, symbol)

    def launch(fun, threads, params, block=256):
        if fun.value != reference.value:
            return original_launch(fun, threads, params, block)
        words = struct.unpack('<15Q', bytes(params[0]))
        is_block = bool(params[8].value)
        mode = 'block' if is_block else 'tangent' if params[6].value else 'force'
        output = params[8] if is_block else params[7]
        shape = (words[14], 9 if is_block else 3)
        before = driver.download(output, np.zeros(shape, k.F))
        def reset():
            driver.check(driver.cu.cuMemcpyHtoD_v2(output, before.ctypes.data_as(ctypes.c_void_p),
                                                  ctypes.c_size_t(before.nbytes)))
        def compare(args):
            values = []
            for f in (reference, compiled):
                reset()
                original_launch(f, threads, args, block)
                values.append(driver.download(output, before))
            bad = np.argwhere(values[0].view(np.uint32) != values[1].view(np.uint32))
            return values, bad
        values, bad = compare(params)
        row = {'mode': mode, 'mismatches': len(bad), 'locations': bad.tolist(),
               'values': [(float(values[0][r,c]), float(values[1][r,c])) for r,c in bad[:8]], 'isolated': []}
        if len(bad):
            coefficients = driver.download(params[1], np.zeros(words[12], k.F))
            dofs = driver.download(k.u64(words[11]), np.zeros(words[12], np.int32))
            types = driver.download(k.u64(words[1]), np.zeros(words[12], np.int32))
            pairs = driver.download(k.u64(words[2]), np.zeros((words[12], 2), np.int32))
            for joint in range(words[12]):
                isolated = np.zeros_like(coefficients)
                isolated[dofs[joint]] = coefficients[dofs[joint]]
                args = list(params)
                args[1] = driver.upload(isolated)
                _, errors = compare(args)
                if len(errors):
                    row['isolated'].append({'joint': joint, 'type': int(types[joint]), 'pair': pairs[joint].tolist(),
                                             'mismatches': len(errors), 'locations': errors.tolist()})
        report.append(row)
        print(json.dumps(row), flush=True)
        reset()
        original_launch(reference, threads, params, block)

    driver.function, driver.launch = function, launch
    try:
        k.run_joint_drives(driver, np.random.default_rng(seed))
    finally:
        driver.free()
    out = pc.OUT/'armature-audit'
    out.mkdir(parents=True, exist_ok=True)
    (out/f'probe-seed{seed}.json').write_text(json.dumps(report, indent=2)+'\n')
    return 1 if any(row['mismatches'] for row in report) else 0


if __name__ == '__main__':
    sys.exit(main())
