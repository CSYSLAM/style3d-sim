"""Compare old/source full cable-update write expressions, exact values and floating guard paths."""
import json
import os
import re
import struct
import sys
from collections import Counter

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc import ptx_compare as pc
from reconstruction.csrc.audit_drive_ptx import PathAudit
from reconstruction.csrc.audit_fluid_ptx import lower_memory
from reconstruction.csrc.cable_ptx_ops import CableExpressions, double_operations


def main():
    if os.environ.get('RECONSTRUCTION_KERNELS'):
        raise RuntimeError('Capture literal old backend')
    seed = int(sys.argv[1]) if len(sys.argv) > 1 else 1
    source = pc.entries(pc.compile_ptx(pc.CSRC/'kernels/cables.cu', pc.DEFAULT_NVCC))
    out = pc.OUT/'cable-update-audit'
    if os.environ.get('CABLE_UPDATE_AUDIT_TAG'): out /= os.environ['CABLE_UPDATE_AUDIT_TAG']
    out.mkdir(parents=True, exist_ok=True)
    driver = k.Driver()
    upload, function, launch = driver.upload, driver.function, driver.launch
    memory, targets, reports, calls = {}, {}, [], Counter()

    def capture_upload(array):
        pointer = upload(array)
        memory[pointer.value] = np.ascontiguousarray(array).tobytes()
        return pointer

    def capture_function(text, name):
        result = function(text, name)
        if '22update_cable_penalties' in name:
            targets[result.value] = name, pc.entries(text)[name]
        return result

    def capture_launch(fun, threads, params, block=128):
        if fun.value in targets:
            name, original = targets[fun.value]
            calls[name] += 1
            if calls[name] % 2 == 0: return launch(fun, threads, params, block)
            left, right = (lower_memory(text, params, memory) for text in (original, source[name]))
            pool = CableExpressions()
            options = {'block': block, 'allow_dead_undefined': True, 'opcode_extension': double_operations}
            old, new = PathAudit(left, [], memory, pool, **options), PathAudit(right, [], memory, pool, **options)
            wrong = re.sub(r'st\.global\.f32\s+(\[[^]]+\]),\s*([^;]+);',
                           lambda m: f'neg.f32 %audit_wrong_sign, {m[2]};\nst.global.f32 {m[1]}, %audit_wrong_sign;', right)
            mutant = PathAudit(wrong, [], memory, pool, **options)
            per_world, count = struct.unpack_from('<QQ', bytes(params[0]), 136)
            lanes = sorted({0, 1, 2, 3, 7, 8, 16, 31, per_world, per_world + 1, count - 1, count, threads})
            lanes = [lane for lane in lanes if lane >= 0]
            if os.environ.get('CABLE_UPDATE_AUDIT_LANES'):
                lanes = [int(lane) for lane in os.environ['CABLE_UPDATE_AUDIT_LANES'].split(',')]
            differences, guards, writes, mutation = [], [], 0, False
            for lane in lanes:
                a, ga = old.run(lane, include_values=True)
                b, gb = new.run(lane, include_values=True)
                writes += len(a)
                if b and not mutation:
                    changed, _ = mutant.run(lane, include_values=True)
                    mutation = changed != b
                if a != b:
                    first = next(((x, y) for x, y in zip(a, b) if x != y), None)
                    differences.append({'lane': lane, 'legacy_writes': len(a), 'source_writes': len(b),
                                        'first': first, 'expression': pool.difference(first[0][1], first[1][1])
                                        if first else None})
                if Counter(ga) != Counter(gb):
                    guards.append({'lane': lane, 'legacy_only': list((Counter(ga) - Counter(gb)).elements()),
                                   'source_only': list((Counter(gb) - Counter(ga)).elements())})
            row = {'call': len(reports), 'lanes': lanes, 'writes': writes,
                   'differences': differences, 'guards': guards, 'mutation_detected': mutation}
            reports.append(row)
            (out/'progress.json').write_text(json.dumps(reports, indent=2) + '\n')
            print({'call': row['call'], 'writes': writes, 'differences': len(differences),
                   'guards': len(guards)}, flush=True)
            if (differences or guards) and os.environ.get('CABLE_UPDATE_AUDIT_STOP_FIRST'):
                (out/'debug-first.json').write_text(json.dumps(row, indent=2) + '\n')
                (out/'debug-expressions.json').write_text(json.dumps(pool.nodes))
                raise RuntimeError('Stopped at first audit difference')
        launch(fun, threads, params, block)

    driver.upload, driver.function, driver.launch = capture_upload, capture_function, capture_launch
    try:
        k.run_cable_update(driver, np.random.default_rng(seed))
    finally:
        driver.free()
        (out/f'dataflow-seed{seed}.json').write_text(json.dumps(reports, indent=2) + '\n')
    return int(not reports or any(row['differences'] or row['guards'] or
                                 (row['writes'] and not row['mutation_detected']) for row in reports))


if __name__ == '__main__':
    sys.exit(main())
