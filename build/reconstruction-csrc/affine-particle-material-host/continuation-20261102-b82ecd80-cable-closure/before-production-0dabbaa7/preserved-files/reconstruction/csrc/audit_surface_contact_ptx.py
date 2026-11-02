"""Capture original surface-contact force/scale/preconditioner/tangent paths and compare source write dataflow."""
import json
import os
import re
import sys
from collections import Counter

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc import ptx_compare as pc
from reconstruction.csrc.audit_drive_ptx import Expressions, PathAudit
from reconstruction.csrc.audit_fluid_ptx import lower_memory


def main():
    if os.environ.get('RECONSTRUCTION_KERNELS'):
        raise RuntimeError('Capture original backend')
    seed = int(sys.argv[1]) if len(sys.argv) > 1 else 1
    source = pc.entries(pc.compile_ptx(pc.CSRC/'kernels/surface_contacts.cu', pc.DEFAULT_NVCC))
    d = k.Driver()
    upload, function, launch = d.upload, d.function, d.launch
    memory, targets, reports = {}, {}, []
    paired, seen = False, Counter()

    def captured_upload(array):
        pointer = upload(array)
        memory[pointer.value] = np.ascontiguousarray(array).tobytes()
        return pointer

    def captured_function(text, name):
        result = function(text, name)
        if name in source:
            seen[name] += 1
            targets[result.value] = (name, pc.entries(text)[name]) if not paired or seen[name] % 2 else None
        return result

    def captured_launch(fun, threads, params, block=256):
        if targets.get(fun.value):
            name, original = targets[fun.value]
            left, right = (lower_memory(text, params, memory) for text in (original, source[name]))
            # Explicit rounded additions preserve the original unfused normal-length guard; default add.f32
            # has the same round-to-nearest arithmetic as add.rn.f32. Actual GPU PTX is never rewritten.
            if right.count('add.rn.f32') != 2:
                raise RuntimeError('Expected exactly two rounded normal-length additions')
            right = right.replace('add.rn.f32', 'add.f32')
            expressions = Expressions()
            settings = dict(block=block, allow_dead_undefined=True, grid=max(1, (threads + block - 1)//block))
            old = PathAudit(left, [], memory, expressions, **settings)
            new = PathAudit(right, [], memory, expressions, **settings)
            mutated = re.sub(r'red\.global\.add\.f32\s+(\[[^]]+\]),\s*(%\w+);',
                lambda m: f'neg.f32 %audit_wrong_sign, {m[2]};\nred.global.add.f32 {m[1]}, %audit_wrong_sign;', right)
            mutant = PathAudit(mutated, [], memory, expressions, **settings)
            mutation_detected = False
            differences, guards, writes = [], [], 0
            lanes = sorted({0, 1, 2, 3, 7, 16, 18, 19, 24, 25, threads} if paired else
                           {0, 1, 2, 7, 16, 31, 32, threads - 1, threads})
            if paired and threads == 1:
                lanes = list(range(block))
            for lane in lanes:
                a, ga = old.run(lane, include_values=True)
                b, gb = new.run(lane, include_values=True)
                writes += len(a)
                if not mutation_detected and b:
                    changed, _ = mutant.run(lane, include_values=True)
                    mutation_detected = changed != b
                if a != b:
                    first = next(((x, y) for x, y in zip(a, b) if x != y), None)
                    differences.append({'lane': lane, 'legacy_writes': len(a), 'source_writes': len(b),
                                        'first': first, 'expression': expressions.difference(first[0][1], first[1][1])
                                        if first else None, 'legacy_prefix': a[:40], 'source_prefix': b[:40]})
                if Counter(ga) != Counter(gb):
                    guards.append({'lane': lane, 'legacy_only': list((Counter(ga) - Counter(gb)).elements()),
                                   'source_only': list((Counter(gb) - Counter(ga)).elements())})
            row = {'kernel': name, 'call': len(reports), 'lanes': lanes, 'writes': writes,
                   'differences': differences, 'guards': guards, 'mutation_detected': mutation_detected}
            reports.append(row)
            (out/'progress.json').write_text(json.dumps(reports, indent=2))
            if (differences or guards) and os.environ.get('SURFACE_CONTACT_AUDIT_STOP_FIRST'):
                (out/'debug-first.json').write_text(json.dumps(row, indent=2))
                (out/'debug-expressions.json').write_text(json.dumps(expressions.nodes))
                raise RuntimeError('Stopped at first audit difference for diagnosis')
            print({'call': row['call'], 'writes': writes, 'differences': len(differences),
                   'guards': len(guards)}, flush=True)
        launch(fun, threads, params, block)

    d.upload, d.function, d.launch = captured_upload, captured_function, captured_launch
    out = pc.OUT/'surface-contact-audit'
    if os.environ.get('SURFACE_CONTACT_AUDIT_TAG'):
        out /= os.environ['SURFACE_CONTACT_AUDIT_TAG']
    out.mkdir(parents=True, exist_ok=True)
    try:
        k.run_surface_contact(d, np.random.default_rng(seed))
        targets.clear()
        seen.clear()
        paired = True
        k.run_surface_contact_branches(d, np.random.default_rng(seed))
    finally:
        d.free()
        (out/f'dataflow-seed{seed}.json').write_text(json.dumps(reports, indent=2) + '\n')
    return int(not reports or any(r['differences'] or r['guards'] or (r['writes'] and not r['mutation_detected'])
                                 for r in reports))


if __name__ == '__main__':
    sys.exit(main())
