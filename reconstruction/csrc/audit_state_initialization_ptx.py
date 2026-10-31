"""Audit hard-history/cable-state writes and floating guards using the shared parameter-memory lowering."""
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
        raise RuntimeError('Use original backend for audit capture')
    seed = int(sys.argv[1]) if len(sys.argv) > 1 else 1
    source = {}
    for stem in ('hard_contacts', 'cables'):
        source.update(pc.entries(pc.compile_ptx(pc.CSRC/'kernels'/(stem + '.cu'), pc.DEFAULT_NVCC)))
    d = k.Driver()
    upload, function, launch = d.upload, d.function, d.launch
    memory, targets, seen, reports = {}, {}, Counter(), []
    expressions = Expressions()

    def captured_upload(array):
        result = upload(array)
        memory[result.value] = np.ascontiguousarray(array).tobytes()
        return result

    def captured_function(text, name):
        result = function(text, name)
        if name in source:
            seen[name] += 1
            if seen[name] % 2: targets[result.value] = name, pc.entries(text)[name]
        return result

    def captured_launch(fun, threads, params, block=256):
        if fun.value in targets:
            name, original = targets.pop(fun.value)
            left = lower_memory(original, params, memory)
            right = lower_memory(source[name], params, memory)
            old = PathAudit(left, [], memory, expressions, block=block, mutable_writes=True)
            new = PathAudit(right, [], memory, expressions, block=block, mutable_writes=True)
            mutated = right.replace('mul.f32', 'add.f32').replace('div.rn.f32', 'mul.f32').replace('min.f32', 'max.f32')
            mutant = PathAudit(mutated, [], memory, expressions,
                               block=block, mutable_writes=True)
            differences, guards, writes, mutation_detected = [], [], 0, False
            lanes = list(range(threads + 1))
            for lane in lanes:
                a, ga = old.run(lane, include_values=True)
                b, gb = new.run(lane, include_values=True)
                writes += len(a)
                if not mutation_detected:
                    m, gm = mutant.run(lane, include_values=True)
                    mutation_detected = a != m or Counter(ga) != Counter(gm)
                if a != b:
                    first = next(((x, y) for x, y in zip(a, b) if x != y), None)
                    differences.append({'lane': lane, 'legacy_writes': len(a), 'source_writes': len(b),
                                        'first': first, 'expression': expressions.difference(first[0][1], first[1][1])
                                        if first else None})
                if Counter(ga) != Counter(gb):
                    guards.append({'lane': lane, 'legacy_only': list((Counter(ga) - Counter(gb)).elements()),
                                   'source_only': list((Counter(gb) - Counter(ga)).elements())})
            if 'snapshot_hard_contacts' in name:
                raw = bytes(params[0])
                pointer, capacity = struct.unpack_from('<QQ', raw, 0)
                count = struct.unpack_from('<i', memory[pointer], 0)[0] if pointer else 0
                mutation_required = min(max(count, 0), capacity) > 0
            else:
                pointer, count = params[12].value, params[4].value
                mutation_required = not pointer or bool(np.any(np.frombuffer(memory[pointer], np.int32)[:count]))
            row = {'kernel': name, 'call': seen[name], 'lanes': len(lanes), 'writes': writes,
                   'differences': differences, 'guards': guards, 'mutation_detected': mutation_detected,
                   'mutation_required': mutation_required}
            reports.append(row)
            print({'kernel': name.split('kernel')[1].split('E')[0], 'call': seen[name], 'writes': writes,
                   'differences': len(differences), 'guards': len(guards)}, flush=True)
        launch(fun, threads, params, block)

    d.upload, d.function, d.launch = captured_upload, captured_function, captured_launch
    try:
        k.run_state_initialization_branches(d, np.random.default_rng(seed))
    finally:
        d.free()
    out = pc.OUT/'state-initialization-audit'
    out.mkdir(parents=True, exist_ok=True)
    (out/f'dataflow-seed{seed}.json').write_text(json.dumps(reports, indent=2) + '\n')
    return int(not reports or any(row['differences'] or row['guards'] or
                                 (row['mutation_required'] and not row['mutation_detected']) for row in reports))


if __name__ == '__main__':
    sys.exit(main())
