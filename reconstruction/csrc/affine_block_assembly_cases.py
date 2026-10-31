"""Compare source-assembled 12x12 matrices against the original register-level assembly exit probe."""
from pathlib import Path

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc import ptx_compare as pc
from reconstruction.diagnostics import affine_block_ab


def run(d, rng):
    source = (pc.CSRC/'kernels/affine_block.cu').read_text()
    source = source.replace('build_affine_body_preconditioner', 'assembly_probe')
    old = 'valid[body] = invert_affine_body(matrix, active, output + body * 144);'
    assert source.count(old) == 1
    source = source.replace(old, 'for (int at = 0; at < 144; ++at) output[body * 144 + at] = matrix[at];')
    out = pc.OUT/'affine-block-audit'
    out.mkdir(parents=True, exist_ok=True)
    path = out/'source-matrix-probe.cu'
    path.write_text(source)
    text = pc.compile_ptx(path, pc.DEFAULT_NVCC)
    names = pc.entries(text)
    upload, function, launch = d.upload, d.function, d.launch
    memory, probes, reports = {}, {}, {}
    counters = {'scalar': 0, 'block': 0}

    def captured_upload(array):
        pointer = upload(array)
        memory[pointer.value] = np.ascontiguousarray(array).copy()
        return pointer

    def captured_function(ptx, name):
        result = function(ptx, name)
        if 'PROBE_LOOP:' in ptx:
            scalar = '12NonZeroEntry' in name
            tag = 'scalar' if scalar else 'block'
            probe_name = next(n for n in names if 'assembly_probe' in n and
                              ('12NonZeroEntry' if scalar else '17BlockNonZeroEntry') in n)
            probes[result.value] = function(text, probe_name), tag
        return result

    def captured_launch(fun, threads, params, block=256):
        if fun.value not in probes:
            return launch(fun, threads, params, block)
        probe, tag = probes[fun.value]
        before = memory[params[17].value]
        output = upload(before)
        selected = list(params)
        selected[17] = output
        launch(fun, threads, params, block)
        launch(probe, threads, selected, block)
        reports[f'source_assembly_{tag}_{counters[tag]}'] = k.compare(
            tag, d.download(params[17], before), d.download(output, before))
        counters[tag] += 1

    d.upload, d.function, d.launch = captured_upload, captured_function, captured_launch
    try:
        for scalar in (False, True):
            result = affine_block_ab.run(d, rng, scalar)
            for case, fields in result.items():
                for field, value in fields.items():
                    reports[f'{"scalar" if scalar else "block"}_{case}_{field}'] = value
    finally:
        d.upload, d.function, d.launch = upload, function, launch
    return reports
