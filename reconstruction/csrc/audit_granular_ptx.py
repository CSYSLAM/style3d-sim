"""Concrete grain paths with real-GPU rsqrt.approx values; this diagnostic never substitutes NumPy sqrt for MUFU.RSQ."""
import ctypes
import json
import os
import struct
import sys
from collections import Counter

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc import ptx_compare as pc
from reconstruction.csrc.audit_drive_ptx import Expressions, PathAudit
from reconstruction.csrc.audit_fluid_ptx import lower_memory


def main():
    if os.environ.get('RECONSTRUCTION_KERNELS'):
        raise RuntimeError('Capture with the original backend')
    seed = int(sys.argv[1]) if len(sys.argv) > 1 else 1
    out = pc.OUT/'granular-audit'
    out.mkdir(parents=True, exist_ok=True)
    source = pc.entries(pc.compile_ptx(pc.CSRC/'kernels/granular.cu', pc.DEFAULT_NVCC))
    d = k.Driver()
    upload, function, launch = d.upload, d.function, d.launch
    helper = out/'approximate_rsqrt.cu'
    helper.write_text('#include <cuda_runtime.h>\nextern "C" __global__ void approximate_rsqrt('
                      'const float* input, float* output) { if (threadIdx.x == 0) output[0] = rsqrtf(input[0]); }\n')
    oracle_ptx = pc.compile_ptx(helper, pc.DEFAULT_NVCC)
    if oracle_ptx.count('rsqrt.approx.f32') != 1:
        raise RuntimeError('The approximation oracle must contain exactly the original rsqrt instruction')
    oracle_function = function(oracle_ptx, 'approximate_rsqrt')
    oracle_input, oracle_output = upload(np.zeros(1, np.uint32)), upload(np.zeros(1, np.uint32))
    oracle_values = {}

    def rsqrt(operand):
        if operand not in oracle_values:
            data = np.array([operand], np.uint32)
            d.check(d.cu.cuMemcpyHtoD_v2(oracle_input, data.ctypes.data_as(ctypes.c_void_p), ctypes.c_size_t(4)))
            launch(oracle_function, 1, [oracle_input, oracle_output], block=128)
            oracle_values[operand] = int(d.download(oracle_output, data)[0])
        return oracle_values[operand]

    memory, targets, seen, reports = {}, {}, Counter(), []
    expressions = Expressions()

    def captured_upload(array):
        result = upload(array)
        memory[result.value] = np.ascontiguousarray(array).tobytes()
        return result

    def captured_function(text, name):
        result = function(text, name)
        if name.startswith('_ZN7synreal15granular_kernel') and name in source:
            seen[name] += 1
            if seen[name] % 2: targets[result.value] = name, pc.entries(text)[name]
        return result

    def captured_launch(fun, threads, params, block=128):
        if fun.value in targets:
            name, legacy = targets.pop(fun.value)
            a, b = lower_memory(legacy, params, memory), lower_memory(source[name], params, memory)
            options = dict(block=block, mutable_writes=True, approx_rsqrt=rsqrt)
            old, new = (PathAudit(text, [], memory, expressions, **options) for text in (a, b))
            mutated = b.replace('mul.f32', 'add.f32').replace('div.rn.f32', 'mul.f32')
            mutant = PathAudit(mutated, [], memory, expressions, **options)
            lanes = list(range(threads + 1))
            contact_kernel = 'contacts' in name
            formation = 'form_bonds' in name
            if contact_kernel or formation:
                lanes = sorted(set(range(10)) | {31, 32, 38, 39, 40, 79, 80, 118, 119, 120, threads})
            differences, guards, writes, mutation_detected = [], [], 0, False
            for lane in lanes:
                left, ga = old.run(lane, True)
                right, gb = new.run(lane, True)
                writes += len(left)
                if not mutation_detected:
                    m, gm = mutant.run(lane, True)
                    mutation_detected = m != left or Counter(gm) != Counter(ga)
                if left != right:
                    first = next(((x, y) for x, y in zip(left, right) if x != y), None)
                    differences.append({'lane': lane, 'legacy_writes': len(left), 'source_writes': len(right),
                                        'first': first, 'expression': expressions.difference(first[0][1], first[1][1])
                                        if first else None})
                if Counter(ga) != Counter(gb):
                    guards.append({'lane': lane, 'legacy_only': list((Counter(ga) - Counter(gb)).elements()),
                                   'source_only': list((Counter(gb) - Counter(ga)).elements())})
            required = True
            if contact_kernel:
                raw = bytes(params[0])
                head, counts = struct.unpack_from('<Q', raw, 0)[0], struct.unpack_from('<Q', raw, 64)[0]
                required = bool(np.any(np.frombuffer(memory[head], np.int32) != -1))
                if 'multiply_contacts' in name:
                    required = bool(np.any(np.frombuffer(memory[counts], np.int32) > 0))
            if formation: required = struct.unpack_from('<i', bytes(params[0]), 340)[0] != 0
            row = {'kernel': name, 'call': seen[name], 'lanes': len(lanes), 'writes': writes,
                   'differences': differences, 'guards': guards, 'mutation_required': required,
                   'mutation_detected': mutation_detected}
            reports.append(row)
            print({'kernel': name.split('kernel')[1].split('E')[0], 'call': seen[name], 'writes': writes,
                   'differences': len(differences), 'guards': len(guards)}, flush=True)
        launch(fun, threads, params, block)

    d.upload, d.function, d.launch = captured_upload, captured_function, captured_launch
    try:
        k.run_granular_branches(d, np.random.default_rng(seed))
    finally:
        d.free()
    (out/f'dataflow-seed{seed}.json').write_text(json.dumps(reports, indent=2) + '\n')
    (out/f'rsqrt-oracle-seed{seed}.json').write_text(json.dumps(oracle_values, indent=2) + '\n')
    return int(not reports or any(row['differences'] or row['guards'] or
                                 (row['mutation_required'] and not row['mutation_detected']) for row in reports))


if __name__ == '__main__':
    sys.exit(main())
