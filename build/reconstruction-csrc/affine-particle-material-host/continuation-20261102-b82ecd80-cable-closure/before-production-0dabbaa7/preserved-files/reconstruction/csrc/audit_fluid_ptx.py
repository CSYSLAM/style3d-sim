"""Fluid write/guard audit. Vector memory operations are expanded; parameter bytes occupy synthetic read-only memory."""
import ctypes
import json
import os
import re
import struct
import sys
from collections import Counter

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc import ptx_compare as pc
from reconstruction.csrc.audit_drive_ptx import Expressions, PathAudit


def lower_memory(entry, params, memory):
    # This is a diagnostic lowering only: the actual CUDA launches always use untouched original/source PTX.
    symbol = re.search(r'\.entry (\S+)\(', entry)[1]
    bases = [0x700000000000 + 4096*i for i in range(len(params))]
    for base, param in zip(bases, params):
        memory[base] = ctypes.string_at(ctypes.byref(param), ctypes.sizeof(param))

    def offset(address, amount):
        match = re.fullmatch(r'(.*?)([+-]\d+)?', address.replace('+-', '-'))
        value = int(match[2] or 0) + amount
        return match[1] + (f'+{value}' if value >= 0 else str(value))

    def vector_load(match):
        space, size, dtype, registers, address = match.groups()
        regs = registers.split(',')
        assert len(regs) == int(size)
        width = int(re.search(r'\d+', dtype)[0])//8
        return '\n'.join(f'ld.{space}.{dtype} {reg.strip()}, [{offset(address, width*i)}];'
                         for i, reg in enumerate(regs))

    entry = re.sub(r'ld\.(param|global|local)\.v([24])\.(\w+)\s+\{([^}]+)\},\s*\[([^]]+)\];', vector_load, entry)

    def vector_store(match):
        space, size, dtype, address, registers = match.groups()
        regs = registers.split(',')
        assert len(regs) == int(size)
        width = int(re.search(r'\d+', dtype)[0])//8
        return '\n'.join(f'st.{space}.{dtype} [{offset(address, width*i)}], {reg.strip()};'
                         for i, reg in enumerate(regs))

    entry = re.sub(r'st\.(global|local)\.v([24])\.(\w+)\s+\[([^]]+)\],\s*\{([^}]+)\};', vector_store, entry)

    def parameter_load(match):
        dtype, register, address = match.groups()
        parameter = re.fullmatch(re.escape(symbol) + r'_param_(\d+)([+-]\d+)?', address)
        if parameter:
            absolute = bases[int(parameter[1])] + int(parameter[2] or 0)
            return f'mov.u64 %audit_parameter_address, {absolute};\nld.global.{dtype} {register}, [%audit_parameter_address];'
        return f'ld.global.{dtype} {register}, [{address}];'

    entry = re.sub(r'ld\.param\.(\w+)\s+(%\w+),\s*\[([^]]+)\];', parameter_load, entry)
    entry = re.sub(re.escape(symbol) + r'_param_(\d+)', lambda m: str(bases[int(m[1])]), entry)
    return entry


def main():
    if os.environ.get('RECONSTRUCTION_KERNELS'):
        raise RuntimeError('Use original backend for audit capture')
    seed = int(sys.argv[1]) if len(sys.argv) > 1 else 1
    sampled = len(sys.argv) > 2 and sys.argv[2] == 'sampled'
    source = pc.entries(pc.compile_ptx(pc.CSRC/'kernels/fluid.cu', pc.DEFAULT_NVCC))
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
        if name.startswith('_ZN7synreal12fluid_kernel') and name in source:
            seen[name] += 1
            if seen[name] % 2: targets[result.value] = name, pc.entries(text)[name]
        return result

    def captured_launch(fun, threads, params, block=128):
        if fun.value in targets:
            name, original = targets.pop(fun.value)
            left = lower_memory(original, params, memory)
            right = lower_memory(source[name], params, memory)
            old = PathAudit(left, [], memory, expressions, block=block, mutable_writes=True)
            new = PathAudit(right, [], memory, expressions, block=block, mutable_writes=True)
            mutated = right.replace('mul.f32', 'add.f32').replace('div.rn.f32', 'mul.f32')
            mutant = PathAudit(mutated, [], memory, expressions,
                               block=block, mutable_writes=True)
            differences, guards, writes, mutation_detected = [], [], 0, False
            # One complete seed audits all density lanes. Additional seeds can sample both ends of each world;
            # real GPU A/B still covers the complete output arrays, including all density rows and guard tails.
            lanes = list(range(threads + 1))
            if sampled and 'evaluate_rows' in name:
                raw = bytes(params[0])
                nf, rows = struct.unpack_from('<ii', raw, 88)
                lanes = sorted({0, 1, nf - 1, nf, nf + 1, 2*nf, rows - 1, rows, threads})
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
            # With an empty grid the selected mul/div mutations cannot affect the density output; its exact
            # zero initialization, cache preservation and all writes are still checked against the original.
            mutation_required = True
            if 'evaluate_rows' in name:
                head = struct.unpack_from('<Q', bytes(params[0]), 0)[0]
                mutation_required = bool(np.any(np.frombuffer(memory[head], np.int32) != -1))
            row = {'kernel': name, 'call': seen[name], 'lanes': len(lanes), 'writes': writes,
                   'differences': differences, 'guards': guards, 'mutation_detected': mutation_detected,
                   'mutation_required': mutation_required}
            reports.append(row)
            print({'kernel': name.split('kernel')[1].split('E')[0], 'call': seen[name], 'writes': writes,
                   'differences': len(differences), 'guards': len(guards)}, flush=True)
        launch(fun, threads, params, block)

    d.upload, d.function, d.launch = captured_upload, captured_function, captured_launch
    try:
        k.run_fluid_branches(d, np.random.default_rng(seed))
    finally:
        d.free()
    out = pc.OUT/'fluid-rows-audit'
    out.mkdir(parents=True, exist_ok=True)
    (out/f'dataflow-seed{seed}.json').write_text(json.dumps(reports, indent=2) + '\n')
    return int(not reports or any(row['differences'] or row['guards'] or
                                 (row['mutation_required'] and not row['mutation_detected']) for row in reports))


if __name__ == '__main__':
    sys.exit(main())
