"""Compare soft-contact write expressions and guards on captured original GPU test paths."""
import json
import math
import os
import re
import sys
from collections import Counter

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc import ptx_compare as pc
from reconstruction.csrc.audit_drive_ptx import Expressions, PathAudit
from reconstruction.csrc.audit_fluid_ptx import lower_memory


def contract_single_use_square(entry):
    """Diagnostic-only representation of the three old JIT projection contractions, verified by GPU probes."""
    one = set(re.findall(r'mov\.f32\s+(%\w+),\s*0f3F800000;', entry))
    squares = {dst: left for dst, left, right in re.findall(
        r'mul\.f32\s+(%\w+),\s*(%\w+),\s*(%\w+);', entry) if left == right}
    changed = []

    def replace(match):
        dst, left, right = match.groups()
        if left not in one or right not in squares or len(re.findall(re.escape(right) + r'\b', entry)) != 2:
            return match[0]
        n = squares[right]
        temp = '%audit_projection_negative' + str(len(changed))
        changed.append((dst, n))
        return f'neg.f32 {temp}, {n};\nfma.rn.f32 {dst}, {temp}, {n}, 0f3F800000;'

    result = re.sub(r'sub\.f32\s+(%\w+),\s*(%\w+),\s*(%\w+);', replace, entry)
    if len(changed) != 3:
        raise RuntimeError(f'Expected exactly three single-use projection squares, got {changed}')
    return result


def main():
    if os.environ.get('RECONSTRUCTION_KERNELS'):
        raise RuntimeError('Use original backend for audit capture')
    seed = int(sys.argv[1]) if len(sys.argv) > 1 else 1
    full = len(sys.argv) > 2 and sys.argv[2] == 'full'
    source = pc.entries(pc.compile_ptx(pc.CSRC/'kernels/soft_contacts.cu', pc.DEFAULT_NVCC))
    d = k.Driver()
    upload, function, launch = d.upload, d.function, d.launch
    memory, targets, reports = {}, {}, []
    seen = Counter()
    paired = False
    expressions = Expressions()

    def captured_upload(array):
        result = upload(array)
        memory[result.value] = np.ascontiguousarray(array).tobytes()
        return result

    def captured_function(text, name):
        result = function(text, name)
        if name in source:
            seen[name] += 1
            targets[result.value] = (name, pc.entries(text)[name]) if not paired or seen[name] % 2 else None
        return result

    def captured_launch(fun, threads, params, block=256):
        if targets.get(fun.value):
            name, original = targets[fun.value]
            if 'multiply_soft_contact_hessian_off_diagonal' in name:
                original = contract_single_use_square(original)
            left, right = (lower_memory(text, params, memory) for text in (original, source[name]))
            settings = dict(block=block, grid=math.ceil(threads/block), mutable_writes=True, allow_dead_undefined=True)
            old = PathAudit(left, [], memory, expressions, **settings)
            new = PathAudit(right, [], memory, expressions, **settings)
            mutant_text = re.sub(r'red\.global\.add\.f32\s+(\[[^]]+\]),\s*(%\w+);',
                lambda m: f'neg.f32 %audit_wrong_sign, {m[2]};\nred.global.add.f32 {m[1]}, %audit_wrong_sign;', right)
            mutant = PathAudit(mutant_text, [], memory, expressions, **settings)
            mutation_detected = False
            differences, guards, writes = [], [], 0
            if full and paired:
                lanes = list(range(block*math.ceil(threads/block)))
            elif paired:
                # Cover degeneracies, both world boundaries, shared/filter tails, and all physical grid-stride lanes.
                lanes = (list(range(block)) if threads == 1 else
                         sorted(set(range(9)) | {17, 23, 24, 25, 26, 28, 47, 48, 49, 50, 52, 70, 71, 72,
                                                threads - 1, threads}))
            else:
                lanes = sorted(set(range(min(threads, 32))) | {threads - 1, threads})
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
    try:
        k.run_soft_body_contact(d, np.random.default_rng(seed))
        targets.clear()
        seen.clear()
        paired = True
        k.run_soft_contact_branches(d, np.random.default_rng(seed))
    finally:
        d.free()
    out = pc.OUT/'soft-contact-audit'
    out.mkdir(parents=True, exist_ok=True)
    (out/f'dataflow-seed{seed}.json').write_text(json.dumps(reports, indent=2) + '\n')
    return int(not reports or any(row['differences'] or row['guards'] or (row['writes'] and not row['mutation_detected'])
                                 for row in reports))


if __name__ == '__main__':
    sys.exit(main())
