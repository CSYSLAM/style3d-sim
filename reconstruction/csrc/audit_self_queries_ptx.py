"""Audit original/source particle-query write expressions, addresses and float predicates on captured test paths."""
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
    ours = pc.compile_ptx(pc.CSRC/'kernels/self_collision.cu', pc.DEFAULT_NVCC)
    driver = k.Driver()
    original_upload, original_function, original_launch = driver.upload, driver.function, driver.launch
    targets, compiled_entries = {}, pc.entries(ours)
    for prefix in ('15query_edge_face', '15query_edge_edge', '17query_vertex_face'):
        legacy, name = k.legacy_ptx('_ZN7synreal21self_collision_kernel'+prefix)
        reference = original_function(legacy, name)
        targets[reference.value] = (name, pc.entries(legacy)[name], compiled_entries[name])
    memory, report = {}, []
    pool = Expressions()

    def upload(array):
        pointer = original_upload(array)
        memory[pointer.value] = np.ascontiguousarray(array).tobytes()
        return pointer

    def function(ptx, symbol):
        for handle, (name, _, _) in targets.items():
            if symbol == name:
                import ctypes
                return ctypes.c_void_p(handle)
        return original_function(ptx, symbol)

    def launch(fun, threads, params, block=256):
        if fun.value in targets:
            name, reference_entry, compiled_entry = targets[fun.value]
            old = PathAudit(reference_entry, params, memory, pool)
            new = PathAudit(compiled_entry, params, memory, pool)
            differences, guards, write_count = [], [], 0
            mutated_entry = (compiled_entry.replace('add.f32', 'sub.f32') if '15query_edge_face' in name
                             else compiled_entry.replace('mul.f32', 'add.f32'))
            mutant = PathAudit(mutated_entry, params, memory, pool)
            mutation_detected = False
            for lane in range(threads+1):
                left, left_guards = old.run(lane, include_values=True)
                right, right_guards = new.run(lane, include_values=True)
                write_count += len(left)
                if not mutation_detected:
                    mutated, mutated_guards = mutant.run(lane, include_values=True)
                    mutation_detected = mutated != left or Counter(mutated_guards) != Counter(left_guards)
                if left != right:
                    first = next(((a,b) for a,b in zip(left,right) if a != b), None)
                    differences.append({'lane':lane, 'legacy_writes':len(left), 'source_writes':len(right),
                                        'expression':pool.difference(first[0][1],first[1][1]) if first else None,
                                        'first':first})
                if Counter(left_guards) != Counter(right_guards):
                    guards.append({'lane':lane, 'legacy_only':list((Counter(left_guards)-Counter(right_guards)).elements()),
                                   'source_only':list((Counter(right_guards)-Counter(left_guards)).elements())})
            mode = name.split('kernel')[1].split('EPK')[0]
            row = {'mode':mode, 'lanes':threads+1, 'writes':write_count, 'differences':differences, 'guards':guards,
                   'mul_to_add_mutation_detected':mutation_detected,
                   'mutation_required':write_count > threads}
            report.append(row)
            print(json.dumps({'mode':mode, 'lanes':threads+1, 'writes':write_count,
                              'write_differences':len(differences), 'guard_differences':len(guards)}), flush=True)
        original_launch(fun, threads, params, block)

    driver.upload, driver.function, driver.launch = upload, function, launch
    try:
        if len(sys.argv) > 2 and sys.argv[2] == 'folded':
            k.run_self_collision(driver, np.random.default_rng(seed))
        else:
            k.run_mesh_query_branches(driver, np.random.default_rng(seed))
    finally:
        driver.free()
    out = pc.OUT/'self-query-audit'
    out.mkdir(parents=True, exist_ok=True)
    label = 'folded-dataflow' if len(sys.argv) > 2 and sys.argv[2] == 'folded' else 'dataflow'
    (out/f'{label}-seed{seed}.json').write_text(json.dumps(report, indent=2)+'\n')
    return 1 if (not report or any(row['differences'] or row['guards'] or
                                  (row['mutation_required'] and not row['mul_to_add_mutation_detected'])
                                  for row in report)) else 0


if __name__ == '__main__':
    sys.exit(main())
