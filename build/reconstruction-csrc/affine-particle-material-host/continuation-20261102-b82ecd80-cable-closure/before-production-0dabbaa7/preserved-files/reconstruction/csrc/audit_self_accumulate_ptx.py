"""Compare write DAGs, ordered float guards and integer outputs of the two contact accumulation kernels.

Atomic allocations are modeled independently per lane, preserving that lane's allocation sequence. Cross-lane
counter order is deliberately left to the real GPU tests, which compare sorted contact record bytes.
"""
import json
import os
import sys
from collections import Counter

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc import ptx_compare as pc
from reconstruction.csrc.audit_drive_ptx import Expressions, PathAudit


def main():
    if os.environ.get('RECONSTRUCTION_KERNELS'):
        raise RuntimeError('Run with the original reference backend')
    seed = int(sys.argv[1]) if len(sys.argv) > 1 else 1
    source = pc.entries(pc.compile_ptx(pc.CSRC/'kernels/self_collision.cu', pc.DEFAULT_NVCC))
    driver = k.Driver()
    upload, function, launch = driver.upload, driver.function, driver.launch
    memory, targets, seen, report = {}, {}, Counter(), []
    expressions = Expressions()

    def captured_upload(array):
        pointer = upload(array)
        memory[pointer.value] = np.ascontiguousarray(array).tobytes()
        return pointer

    def captured_function(text, name):
        result = function(text, name)
        if any(part in name for part in ('22accumulate_vertex_face', '25accumulate_particle_pairs')):
            seen[name] += 1
            if seen[name] % 2:
                targets[result.value] = name, pc.entries(text)[name]
        return result

    def captured_launch(fun, threads, params, block=256):
        if fun.value in targets:
            name, legacy = targets.pop(fun.value)
            original = PathAudit(legacy, params, memory, expressions, allow_dead_undefined=True)
            compiled = PathAudit(source[name], params, memory, expressions)
            mutant = PathAudit(source[name].replace('mul.f32', 'add.f32'), params, memory, expressions)
            differences, guards, writes, mutation_detected = [], [], 0, False
            for lane in range(threads + 1):
                a, ga = original.run(lane, include_values=True)
                b, gb = compiled.run(lane, include_values=True)
                writes += len(a)
                if not mutation_detected:
                    m, gm = mutant.run(lane, include_values=True)
                    mutation_detected = a != m or Counter(ga) != Counter(gm)
                if a != b:
                    first = next(((left, right) for left, right in zip(a, b) if left != right), None)
                    differences.append({'lane': lane, 'legacy_writes': len(a), 'source_writes': len(b),
                                        'first': first, 'expression': expressions.difference(first[0][1], first[1][1])
                                        if first else None})
                if Counter(ga) != Counter(gb):
                    guards.append({'lane': lane, 'legacy_only': list((Counter(ga) - Counter(gb)).elements()),
                                   'source_only': list((Counter(gb) - Counter(ga)).elements())})
            row = {'kernel': name, 'call': seen[name], 'lanes': threads + 1, 'writes': writes,
                   'differences': differences, 'guards': guards, 'mutation_detected': mutation_detected}
            report.append(row)
            print({key: (len(value) if key in ('differences', 'guards') else value)
                   for key, value in row.items() if key != 'kernel'}, flush=True)
        launch(fun, threads, params, block)

    driver.upload, driver.function, driver.launch = captured_upload, captured_function, captured_launch
    try:
        k.run_self_accumulate_branches(driver, np.random.default_rng(seed))
    finally:
        driver.free()
    out = pc.OUT/'self-accumulate-audit'
    out.mkdir(parents=True, exist_ok=True)
    (out/f'dataflow-seed{seed}.json').write_text(json.dumps(report, indent=2) + '\n')
    return int(not report or any(row['differences'] or row['guards'] or not row['mutation_detected'] for row in report))


if __name__ == '__main__':
    sys.exit(main())
