"""Audit original/source armature write expressions, addresses and float predicates on captured test paths."""
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
        raise RuntimeError('Run without RECONSTRUCTION_KERNELS so the reference stays original')
    seed = int(sys.argv[1]) if len(sys.argv) > 1 else 1
    ours = pc.compile_ptx(pc.CSRC/'kernels/joints.cu', pc.DEFAULT_NVCC)
    legacy, name = k.legacy_ptx('23evaluate_joint_armature')
    reference_entry, compiled_entry = pc.entries(legacy)[name], pc.entries(ours)[name]
    driver = k.Driver()
    original_upload, original_function, original_launch = driver.upload, driver.function, driver.launch
    reference = original_function(legacy, name)
    memory, report = {}, []
    pool = Expressions()

    def upload(array):
        pointer = original_upload(array)
        memory[pointer.value] = np.ascontiguousarray(array).tobytes()
        return pointer

    def function(ptx, symbol):
        return reference if symbol == name else original_function(ptx, symbol)

    def launch(fun, threads, params, block=256):
        if fun.value == reference.value:
            old = PathAudit(reference_entry, params, memory, pool)
            new = PathAudit(compiled_entry, params, memory, pool)
            differences, guards, write_count = [], [], 0
            mutant = PathAudit(compiled_entry.replace('mul.f32', 'add.f32', 1), params, memory, pool)
            mutation_detected = False
            for lane in range(threads+1):
                left, left_guards = old.run(lane)
                right, right_guards = new.run(lane)
                write_count += len(left)
                if not mutation_detected:
                    mutated, _ = mutant.run(lane)
                    mutation_detected = mutated != left
                if left != right:
                    first = next(((a,b) for a,b in zip(left,right) if a != b), None)
                    differences.append({'lane':lane, 'legacy_writes':len(left), 'source_writes':len(right),
                                        'expression':pool.difference(first[0][1],first[1][1]) if first else None})
                if Counter(left_guards) != Counter(right_guards):
                    guards.append({'lane':lane, 'legacy_only':list((Counter(left_guards)-Counter(right_guards)).elements()),
                                   'source_only':list((Counter(right_guards)-Counter(left_guards)).elements())})
            mode = 'block' if params[8].value else 'tangent' if params[6].value else 'force'
            row = {'mode':mode, 'lanes':threads+1, 'writes':write_count, 'differences':differences, 'guards':guards,
                   'mul_to_add_mutation_detected':mutation_detected}
            report.append(row)
            print(json.dumps(row), flush=True)
        original_launch(fun, threads, params, block)

    driver.upload, driver.function, driver.launch = upload, function, launch
    try:
        k.run_joint_drives(driver, np.random.default_rng(seed))
        k.run_joint_armature_branches(driver, np.random.default_rng(seed))
    finally:
        driver.free()
    out = pc.OUT/'armature-audit'
    out.mkdir(parents=True, exist_ok=True)
    (out/f'dataflow-seed{seed}.json').write_text(json.dumps(report, indent=2)+'\n')
    return 1 if (not report or any(row['differences'] or row['guards'] or
                                  (row['writes'] and not row['mul_to_add_mutation_detected'])
                                  for row in report)) else 0


if __name__ == '__main__':
    sys.exit(main())
