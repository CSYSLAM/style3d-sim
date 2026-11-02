"""Compare old/source full cable-prepare write expressions, exact values and floating guard paths."""
import json
import os
import re
import struct
import sys
from collections import Counter, defaultdict

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc import ptx_compare as pc
from reconstruction.csrc.audit_drive_ptx import PathAudit
from reconstruction.csrc.audit_fluid_ptx import lower_memory
from reconstruction.csrc.cable_ptx_ops import double_operations
from reconstruction.csrc.audit_cable_spin_ptx import SpinExpressions, contract_old_spin_diagonals


class PrepareExpressions(SpinExpressions):
    def node(self, op, *args):
        if op in ('add.rn.f32', 'mul.rn.f32'): op = op.replace('.rn.', '.')
        if op == 'mul.f32':
            for at in range(2):
                factor, other = self.nodes[args[at]], args[1 - at]
                if factor == ('constant', 0x3f800000): return other
                if factor == ('constant', 0xbf800000): return self.node('neg.f32', other)
        if op == 'neg.f32' and self.nodes[args[0]][0] == 'constant':
            return super().node('constant', self.nodes[args[0]][1] ^ 0x80000000)
        return super().node(op, *args)


def guard_locations(entry):
    label, result = 'entry', {}
    for line in entry.splitlines():
        line = line.strip()
        if line.endswith(':'): label = line[:-1]
        match = re.match(r'setp\.\w+\.f(?:32|64)\s+(%\w+),', line)
        if match: result[match[1]] = label
    return result


def tracked_operations(locations, definitions):
    def extension(op, operands, state):
        handled = double_operations(op, operands, state)
        if re.fullmatch(r'setp\.\w+\.f(?:32|64)', op):
            dst, *src = [part.strip() for part in operands.split(',')]
            kind = op.split('.')[1]
            kind = {'gtu': 'le', 'geu': 'lt', 'leu': 'gt', 'ltu': 'ge'}.get(kind, kind)
            key = (kind, state['formula'](src[0]), state['formula'](src[1]))
            definitions[key].add(locations[dst])
        return handled
    return extension


def main():
    if os.environ.get('RECONSTRUCTION_KERNELS'):
        raise RuntimeError('Capture literal old backend')
    seed = int(sys.argv[1]) if len(sys.argv) > 1 else 1
    source = pc.entries(pc.compile_ptx(pc.CSRC/'kernels/cable_tangents.cu', pc.DEFAULT_NVCC))
    out = pc.OUT/'cable-prepare-audit'
    if os.environ.get('CABLE_PREPARE_AUDIT_TAG'): out /= os.environ['CABLE_PREPARE_AUDIT_TAG']
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
        if '22prepare_cable_tangents' in name:
            targets[result.value] = name, pc.entries(text)[name]
        return result

    def capture_launch(fun, threads, params, block=128):
        if fun.value in targets:
            name, original = targets[fun.value]
            calls[name] += 1
            if calls[name] % 2 == 0: return launch(fun, threads, params, block)
            original = contract_old_spin_diagonals(original, include_child=True)
            left, right = (lower_memory(text, params, memory) for text in (original, source[name]))
            pool = PrepareExpressions()
            definitions = defaultdict(set)
            options = {'block': block, 'allow_dead_undefined': True}
            old = PathAudit(left, [], memory, pool,
                            opcode_extension=tracked_operations(guard_locations(left), definitions), **options)
            new = PathAudit(right, [], memory, pool, opcode_extension=double_operations, **options)
            wrong = re.sub(r'st\.global\.(u32|f32)\s+(\[[^]]+\]),\s*([^;]+);',
                           lambda m: f'xor.b32 %audit_wrong_sign, {m[3]}, 2147483648;\n'
                           f'st.global.{m[1]} {m[2]}, %audit_wrong_sign;', right)
            mutant = PathAudit(wrong, [], memory, pool, opcode_extension=double_operations, **options)
            per_world, count = struct.unpack_from('<QQ', bytes(params[0]), 136)
            lanes = sorted({0, 1, 2, 3, 7, 8, 16, 31, per_world, per_world + 1, count - 1, count, threads})
            lanes = [lane for lane in lanes if lane >= 0]
            if os.environ.get('CABLE_PREPARE_AUDIT_LANES'):
                lanes = [int(lane) for lane in os.environ['CABLE_PREPARE_AUDIT_LANES'].split(',')]
            differences, guards, writes, mutation, nan_signs = [], [], 0, False, 0
            for lane in lanes:
                a, ga = old.run(lane, include_values=True)
                b, gb = new.run(lane, include_values=True)
                # NumPy preserves an operand's NaN sign, unlike the GPU arithmetic.
                # Keep every address/DAG check and finite bit check; log this CPU-only
                # sign discrepancy. Separate actual GPU comparisons remain bitwise.
                canonical = []
                for left_write, right_write in zip(a, b):
                    addr, expression, value = right_write
                    same_expression = left_write[:2] == right_write[:2]
                    left_nan = (left_write[2] & 0x7fffffff) > 0x7f800000
                    right_nan = (value & 0x7fffffff) > 0x7f800000
                    if same_expression and left_nan and right_nan and left_write[2] ^ value == 0x80000000:
                        value = left_write[2]
                        nan_signs += 1
                    canonical.append((addr, expression, value))
                if len(a) == len(b): b = canonical
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
                    legacy_extra = list(set(ga) - set(gb))
                    origins = [{'guard': item, 'blocks': sorted(definitions[item[:3]])} for item in legacy_extra]
                    unexplained = [item for item in origins if not item['blocks'] or any(
                        not re.fullmatch(r'\$L__BB72_(?:8[2-9]|9[0-9]|1[0-2][0-9]|13[0-7])', block)
                        for block in item['blocks'])]
                    guards.append({'lane': lane, 'legacy_only': list((Counter(ga) - Counter(gb)).elements()),
                                   'source_only': list((Counter(gb) - Counter(ga)).elements()),
                                   'unique_legacy_only': legacy_extra, 'legacy_extra_origins': origins,
                                   'unexplained_legacy_only': unexplained,
                                   'unique_source_only': list(set(gb) - set(ga))})
            row = {'call': len(reports), 'lanes': lanes, 'writes': writes,
                   'differences': differences, 'guards': guards, 'mutation_detected': mutation,
                   'cpu_nan_sign_adjustments': nan_signs}
            reports.append(row)
            (out/'progress.json').write_text(json.dumps(reports, indent=2) + '\n')
            print({'call': row['call'], 'writes': writes, 'differences': len(differences),
                   'guards': len(guards)}, flush=True)
            if differences and os.environ.get('CABLE_PREPARE_AUDIT_STOP_FIRST'):
                (out/'debug-first.json').write_text(json.dumps(row, indent=2) + '\n')
                (out/'debug-expressions.json').write_text(json.dumps(pool.nodes))
                raise RuntimeError('Stopped at first audit difference')
        launch(fun, threads, params, block)

    driver.upload, driver.function, driver.launch = capture_upload, capture_function, capture_launch
    try:
        k.run_cable_prepare(driver, np.random.default_rng(seed))
    finally:
        driver.free()
        (out/f'dataflow-seed{seed}.json').write_text(json.dumps(reports, indent=2) + '\n')
    return int(not reports or any(row['differences'] or
                                 any(g['unexplained_legacy_only'] or g['unique_source_only'] for g in row['guards']) or
                                 (row['writes'] and not row['mutation_detected']) for row in reports))


if __name__ == '__main__':
    sys.exit(main())
