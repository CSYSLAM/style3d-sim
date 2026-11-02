"""Audit hard-contact initialization/update writes and guards against untouched original PTX test paths."""
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
    source = pc.entries(pc.compile_ptx(pc.CSRC/'kernels/hard_contacts.cu', pc.DEFAULT_NVCC))
    d = k.Driver()
    upload, function, launch = d.upload, d.function, d.launch
    memory, targets, reports = {}, {}, []
    paired, seen = False, Counter()
    expressions = Expressions()

    def captured_upload(array):
        pointer = upload(array)
        memory[pointer.value] = np.ascontiguousarray(array).tobytes()
        return pointer

    def captured_function(text, name):
        result = function(text, name)
        if name in source and ('initialize_hard_contacts' in name or 'update_hard_contact_duals' in name):
            # The original test also builds a register-level geometry probe ending in ret; omit that probe.
            if 'st.global.u32 [%rd400]' not in text:
                seen[name] += 1
                targets[result.value] = (name, pc.entries(text)[name]) if not paired or seen[name] % 2 else None
        return result

    def captured_launch(fun, threads, params, block=256):
        if targets.get(fun.value):
            name, original = targets[fun.value]
            left, right = (lower_memory(text, params, memory) for text in (original, source[name]))
            old = PathAudit(left, [], memory, expressions, block=block, allow_dead_undefined=True)
            new = PathAudit(right, [], memory, expressions, block=block, allow_dead_undefined=True)
            mutant_text = re.sub(r'st\.global\.(?:f32|u32|b32)\s+(\[[^]]+\]),\s*(%\w+);',
                lambda m: f'mov.b32 %audit_float_value, {m[2]};\nneg.f32 %audit_wrong_sign, %audit_float_value;\n'
                          f'st.global.f32 {m[1]}, %audit_wrong_sign;', right)
            mutant = PathAudit(mutant_text, [], memory, expressions, block=block, allow_dead_undefined=True)
            mutation_detected = False
            differences, guards, writes = [], [], 0
            lanes = sorted({0, 1, 2, 3, 4, 5, 6, 7, 16, 18, 19, 24, 25, 31, 32, threads - 1, threads})
            for lane in lanes:
                a, ga = old.run(lane, include_values=True)
                b, gb = new.run(lane, include_values=True)
                writes += len(a)
                if not mutation_detected and b:
                    mutated, _ = mutant.run(lane, include_values=True)
                    mutation_detected = mutated != b
                if a != b:
                    first = next(((x, y) for x, y in zip(a, b) if x != y), None)
                    differences.append({'lane': lane, 'legacy_writes': len(a), 'source_writes': len(b),
                                        'first': first, 'expression': expressions.difference(first[0][1], first[1][1])
                                        if first else None})
                if Counter(ga) != Counter(gb):
                    guards.append({'lane': lane, 'legacy_only': list((Counter(ga) - Counter(gb)).elements()),
                                   'source_only': list((Counter(gb) - Counter(ga)).elements())})
            row = {'kernel': name, 'call': len(reports), 'lanes': lanes, 'writes': writes,
                   'differences': differences, 'guards': guards, 'mutation_detected': mutation_detected}
            reports.append(row)
            print({'call': row['call'], 'writes': writes, 'differences': len(differences),
                   'guards': len(guards)}, flush=True)
        launch(fun, threads, params, block)

    d.upload, d.function, d.launch = captured_upload, captured_function, captured_launch
    out = pc.OUT/'hard-state-audit'
    out.mkdir(parents=True, exist_ok=True)
    try:
        k.run_hard_constraints(d, np.random.default_rng(seed))
        targets.clear()
        seen.clear()
        paired = True
        k.run_hard_state_branches(d, np.random.default_rng(seed))
    finally:
        d.free()
        (out/f'dataflow-seed{seed}.json').write_text(json.dumps(reports, indent=2) + '\n')
    return int(not reports or any(r['differences'] or r['guards'] or (r['writes'] and not r['mutation_detected'])
                                 for r in reports))


if __name__ == '__main__':
    sys.exit(main())
