"""Capture the formal joint-drive tangent calls and compare untouched legacy/compiled outputs directly."""
import ctypes
import json
import sys
import numpy as np
from reconstruction import kernel_ab as k
from reconstruction.csrc import ptx_compare as pc

seed = int(sys.argv[1]) if len(sys.argv) > 1 else 2
ours = pc.compile_ptx(pc.CSRC/'kernels'/'joints.cu', pc.DEFAULT_NVCC)
prefix = '28multiply_joint_drive_tangent'
text, name = k.legacy_ptx(prefix)
d = k.Driver()
original_function, original_launch = d.function, d.launch
reference = original_function(text, name)
compiled = original_function(ours, name)
reports = []

def function(ptx, symbol):
    return reference if symbol == name else original_function(ptx, symbol)


def launch(fun, threads, params, block=256):
    if fun.value != reference.value:
        return original_launch(fun, threads, params, block)
    shape = (params[-1].value, 3)
    output = params[18]
    before = d.download(output, np.zeros(shape, k.F))
    def reset():
        d.check(d.cu.cuMemcpyHtoD_v2(output, before.ctypes.data_as(ctypes.c_void_p), ctypes.c_size_t(before.nbytes)))
    original_launch(reference, threads, params, block)
    expected = d.download(output, before)
    reset()
    original_launch(compiled, threads, params, block)
    actual = d.download(output, before)
    bad = np.argwhere(expected.view(np.uint32) != actual.view(np.uint32))
    types = d.download(params[3], np.zeros(threads, np.int32))
    pairs = d.download(params[4], np.zeros((threads, 2), np.int32))
    affected = {int(row//4) for row, _ in bad}
    report = {'call': len(reports), 'mismatches': len(bad), 'locations': bad.tolist(),
              'drives': [(i, int(types[i]), pairs[i].tolist()) for i in range(threads)
                         if any(int(body) in affected for body in pairs[i])],
              'values': [(float(expected[row, col]), float(actual[row, col])) for row, col in bad]}
    print(report, flush=True)
    if len(bad):
        dofs = d.download(params[13], np.zeros(threads, np.int32))
        kd_all = d.download(params[16], np.zeros(threads, k.F))
        damping_all = (d.download(params[15], np.zeros(threads, k.F))
                       if params[15].value else np.zeros(threads, k.F))
        isolated = []
        for active in range(threads):
            kd, damping = np.zeros_like(kd_all), np.zeros_like(damping_all)
            kd[dofs[active]], damping[dofs[active]] = kd_all[dofs[active]], damping_all[dofs[active]]
            args = list(params)
            args[16], args[15] = d.upload(kd), d.upload(damping)
            reset()
            original_launch(reference, threads, args, block)
            isolated_ref = d.download(output, before)
            reset()
            original_launch(compiled, threads, args, block)
            isolated_src = d.download(output, before)
            locations = np.argwhere(isolated_ref.view(np.uint32) != isolated_src.view(np.uint32))
            if len(locations):
                isolated.append({'drive': active, 'type': int(types[active]), 'locations': locations.tolist()})
        report['isolated_failures'] = isolated
        print('isolated', isolated, flush=True)
    reports.append(report)
    np.savez(pc.OUT/f'drive-tangent-seed{seed}-call{report["call"]}.npz', reference=expected, source=actual)
    reset()
    original_launch(reference, threads, params, block)

d.function, d.launch = function, launch
try:
    result = k.run_joint_drives(d, np.random.default_rng(seed))
finally:
    d.free()
(pc.OUT/f'drive-tangent-seed{seed}-probe.json').write_text(json.dumps(reports, indent=2)+'\n')
