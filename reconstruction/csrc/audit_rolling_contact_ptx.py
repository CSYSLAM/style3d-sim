"""Capture original rolling-friction force/preconditioner/tangent paths and compare source write dataflow."""
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


class RollingExpressions(Expressions):
    def node(self, op, *args):
        # All three inverse-applied basis vectors must be finite before any rolling write. On those paths,
        # moving a unary minus through an RN multiply preserves its exact bits, including signed zero.
        # Numeric write bits and all guard results are compared separately; no FMA/subtraction is rewritten.
        if op == 'mul.f32':
            negative = False
            factors = []
            for argument in args:
                if self.nodes[argument][0] == 'neg.f32':
                    negative = not negative
                    argument = self.nodes[argument][1]
                factors.append(argument)
            product = super().node(op, *factors)
            return super().node('neg.f32', product) if negative else product
        if op == 'neg.f32' and self.nodes[args[0]][0] == 'neg.f32':
            return self.nodes[args[0]][1]
        return super().node(op, *args)


def main():
    if os.environ.get('RECONSTRUCTION_KERNELS'):
        raise RuntimeError('Capture original backend')
    seed = int(sys.argv[1]) if len(sys.argv) > 1 else 1
    source = pc.entries(pc.compile_ptx(pc.CSRC/'kernels/rolling_contacts.cu', pc.DEFAULT_NVCC))
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
            expressions = RollingExpressions()
            old = PathAudit(left, [], memory, expressions, block=block, allow_dead_undefined=True)
            new = PathAudit(right, [], memory, expressions, block=block, allow_dead_undefined=True)
            mutated = re.sub(r'red\.global\.add\.f32\s+(\[[^]]+\]),\s*(%\w+);',
                lambda m: f'neg.f32 %audit_wrong_sign, {m[2]};\nred.global.add.f32 {m[1]}, %audit_wrong_sign;', right)
            mutant = PathAudit(mutated, [], memory, expressions, block=block, allow_dead_undefined=True)
            mutation_detected = False
            differences, guards, duplicate_guards, writes = [], [], [], 0
            lanes = sorted({0, 1, 2, 3, 7, 16, 18, 19, 24, 25, threads} if paired else
                           {0, 1, 2, 7, 16, 31, 32, threads - 1, threads})
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
                ca, cb = Counter(ga), Counter(gb)
                # The original rechecks the same positive determinant for all three axes. NVCC removes the
                # dominated repeats. Collapse only this exact true predicate; keep raw multiplicities as evidence.
                for key in ca.keys() | cb.keys():
                    if (key[0] == 'gt' and key[3] and expressions.nodes[key[2]] == ('constant', 0x0da24260)
                            and ca[key] and cb[key]):
                        if ca[key] != cb[key]:
                            duplicate_guards.append({'lane': lane, 'predicate': key, 'legacy_count': ca[key],
                                                     'source_count': cb[key]})
                        ca[key], cb[key] = 1, 1
                if ca != cb:
                    guards.append({'lane': lane, 'legacy_only': list((ca - cb).elements()),
                                   'source_only': list((cb - ca).elements())})
            row = {'kernel': name, 'call': len(reports), 'lanes': lanes, 'writes': writes,
                   'differences': differences, 'guards': guards, 'duplicate_guards': duplicate_guards,
                   'mutation_detected': mutation_detected}
            reports.append(row)
            (out/'progress.json').write_text(json.dumps(reports, indent=2))
            if (differences or guards) and os.environ.get('ROLLING_CONTACT_AUDIT_STOP_FIRST'):
                (out/'debug-first.json').write_text(json.dumps(row, indent=2))
                (out/'debug-expressions.json').write_text(json.dumps(expressions.nodes))
                raise RuntimeError('Stopped at first audit difference for diagnosis')
            print({'call': row['call'], 'writes': writes, 'differences': len(differences),
                   'guards': len(guards)}, flush=True)
        launch(fun, threads, params, block)

    d.upload, d.function, d.launch = captured_upload, captured_function, captured_launch
    out = pc.OUT/'rolling-contact-audit'
    if os.environ.get('ROLLING_CONTACT_AUDIT_TAG'):
        out /= os.environ['ROLLING_CONTACT_AUDIT_TAG']
    out.mkdir(parents=True, exist_ok=True)
    try:
        k.run_rolling_contact(d, np.random.default_rng(seed))
        targets.clear()
        seen.clear()
        paired = True
        k.run_rolling_contact_branches(d, np.random.default_rng(seed))
    finally:
        d.free()
        (out/f'dataflow-seed{seed}.json').write_text(json.dumps(reports, indent=2) + '\n')
    return int(not reports or any(r['differences'] or r['guards'] or (r['writes'] and not r['mutation_detected'])
                                 for r in reports))


if __name__ == '__main__':
    sys.exit(main())
