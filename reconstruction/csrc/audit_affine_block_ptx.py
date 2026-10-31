"""Compare actual old/source affine preconditioner writes and floating guards on captured fixture paths."""
import contextlib
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
from reconstruction.csrc.affine_ptx_moves import contract_so3_shared_squares, lower_packed_moves
from reconstruction.diagnostics import affine_block_ab


def main():
    if os.environ.get('RECONSTRUCTION_KERNELS'):
        raise RuntimeError('Capture original backend')
    seed = int(sys.argv[1]) if len(sys.argv) > 1 else 1
    source = pc.entries(pc.compile_ptx(pc.CSRC/'kernels/affine_block.cu', pc.DEFAULT_NVCC))
    assembly = bool(os.environ.get('AFFINE_BLOCK_AUDIT_ASSEMBLY'))
    if assembly:
        code = (pc.CSRC/'kernels/affine_block.cu').read_text()
        code = code.replace('build_affine_body_preconditioner', 'assembly_probe')
        code = code.replace('valid[body] = invert_affine_body(matrix, active, output + body * 144);',
                            'for (int at = 0; at < 144; ++at) output[body * 144 + at] = matrix[at];')
        probe = pc.OUT/'affine-block-audit/source-matrix-probe.cu'
        probe.write_text(code)
        probes = pc.entries(pc.compile_ptx(probe, pc.DEFAULT_NVCC))
        source = {name: next(entry for symbol, entry in probes.items()
                             if ('12NonZeroEntry' in symbol) == ('12NonZeroEntry' in name)) for name in source}
    out = pc.OUT/'affine-block-audit'
    if os.environ.get('AFFINE_BLOCK_AUDIT_TAG'):
        out /= os.environ['AFFINE_BLOCK_AUDIT_TAG']
    out.mkdir(parents=True, exist_ok=True)
    driver = k.Driver()
    upload, function, launch = driver.upload, driver.function, driver.launch
    memory, targets, reports = {}, {}, []
    branch_phase, branch_calls = False, Counter()

    def assembly_exit(entry, name):
        label = '$L__BB82_264:' if '12NonZeroEntry' in name else '$L__BB81_264:'
        at = entry.index(label) + len(label)
        probe = f'''
ld.param.u64 %audit_matrix_output, [{name}_param_17];
mul.lo.s64 %audit_matrix_offset, %rd4, 576;
add.s64 %audit_matrix_output, %audit_matrix_output, %audit_matrix_offset;
mov.u32 %audit_matrix_at, 0;
AUDIT_ASSEMBLY_LOOP:
mul.wide.u32 %audit_matrix_offset, %audit_matrix_at, 4;
add.s64 %audit_matrix_input, %rd1, %audit_matrix_offset;
ld.local.f32 %audit_matrix_value, [%audit_matrix_input];
add.s64 %audit_matrix_target, %audit_matrix_output, %audit_matrix_offset;
st.global.f32 [%audit_matrix_target], %audit_matrix_value;
add.u32 %audit_matrix_at, %audit_matrix_at, 1;
setp.lt.u32 %audit_matrix_more, %audit_matrix_at, 144;
@%audit_matrix_more bra AUDIT_ASSEMBLY_LOOP;
ret;
'''
        return entry[:at] + probe + entry[at:]

    def captured_upload(array):
        pointer = upload(array)
        memory[pointer.value] = np.ascontiguousarray(array).tobytes()
        return pointer

    def captured_function(text, name):
        result = function(text, name)
        if name in source and (('PROBE_LOOP:' in text) == (assembly and not branch_phase)):
            entry = pc.entries(text)[name]
            if assembly and branch_phase:
                entry = assembly_exit(entry, name)
            targets[result.value] = name, entry
        return result

    def captured_launch(fun, threads, params, block=256):
        if fun.value in targets:
            name, original = targets[fun.value]
            if branch_phase:
                branch_calls[name] += 1
                if branch_calls[name] % 2 == 0:
                    return launch(fun, threads, params, block)
            original = contract_so3_shared_squares(original)
            left, right = (lower_packed_moves(lower_memory(text, params, memory))
                           for text in (original, source[name]))
            pool = Expressions()
            old = PathAudit(left, [], memory, pool, block=block, mutable_writes=True, allow_dead_undefined=True)
            new = PathAudit(right, [], memory, pool, block=block, mutable_writes=True, allow_dead_undefined=True)
            mutated = re.sub(r'st\.global\.f32\s+(\[[^]]+\]),\s*([^;]+);',
                             lambda m: f'neg.f32 %audit_wrong_sign, {m[2]};\nst.global.f32 {m[1]}, %audit_wrong_sign;',
                             right)
            mutant = PathAudit(mutated, [], memory, pool, block=block, mutable_writes=True, allow_dead_undefined=True)
            lanes = sorted({0, 1, 2, 5, 6, 7, 11, threads})
            if os.environ.get('AFFINE_BLOCK_AUDIT_LANES'):
                lanes = [int(x) for x in os.environ['AFFINE_BLOCK_AUDIT_LANES'].split(',')]
            differences, guards, duplicate_guards, writes = [], [], [], 0
            mutation_detected, float_writes = False, False
            for lane in lanes:
                a, ga = old.run(lane, include_values=True)
                b, gb = new.run(lane, include_values=True)
                writes += len(a)
                # An enabled-but-rejected lane may only write the integer validity flag.
                has_float_write = any(params[17].value <= w[0] < params[17].value + len(memory[params[17].value])
                                      for w in b)
                float_writes |= has_float_write
                if not mutation_detected and has_float_write:
                    changed, _ = mutant.run(lane, include_values=True)
                    mutation_detected = changed != b
                if a != b:
                    first = next(((x, y) for x, y in zip(a, b) if x != y), None)
                    differences.append({'lane': lane, 'legacy_writes': len(a), 'source_writes': len(b),
                                        'first': first, 'expression': pool.difference(first[0][1], first[1][1])
                                        if first else None})
                ca, cb = Counter(ga), Counter(gb)
                # NVCC speculates the null-flags mass comparison before the branch, duplicating the
                # same immutable mass > 0 predicate on the flags-present path. Record only that exact case.
                for key in ca.keys() | cb.keys():
                    operand = pool.nodes[key[1]]
                    mass_guard = (key[0] == 'gt' and pool.nodes[key[2]] == ('constant', 0) and
                                  operand[0] == 'load' and operand[1] == params[2].value)
                    if assembly and mass_guard:
                        # The assembly-only source probe no longer uses the active mask. Its dead mass
                        # checks disappear; the complete inverse audit below still checks them separately.
                        duplicate_guards.append({'lane': lane, 'predicate': key, 'legacy_count': ca[key],
                                                 'source_count': cb[key], 'dead_in_assembly_probe': True})
                        ca[key] = cb[key] = 0
                    elif mass_guard and {ca[key], cb[key]} == {1, 2}:
                        duplicate_guards.append({'lane': lane, 'predicate': key, 'legacy_count': ca[key],
                                                 'source_count': cb[key]})
                        ca[key] = cb[key] = 1
                if ca != cb:
                    guards.append({'lane': lane, 'legacy_only': list((ca - cb).elements()),
                                   'source_only': list((cb - ca).elements())})
            row = {'kernel': name, 'call': len(reports), 'lanes': lanes, 'writes': writes,
                   'differences': differences, 'guards': guards, 'float_writes': float_writes,
                   'mutation_detected': mutation_detected, 'duplicate_mass_guards': duplicate_guards}
            reports.append(row)
            (out/'progress.json').write_text(json.dumps(reports, indent=2) + '\n')
            if (differences or guards) and os.environ.get('AFFINE_BLOCK_AUDIT_STOP_FIRST'):
                (out/'debug-first.json').write_text(json.dumps(row, indent=2) + '\n')
                (out/'debug-expressions.json').write_text(json.dumps(pool.nodes))
                raise RuntimeError('Stopped at first audit difference for diagnosis')
            print({'call': row['call'], 'writes': writes, 'differences': len(differences),
                   'guards': len(guards)}, flush=True)
        launch(fun, threads, params, block)

    driver.upload, driver.function, driver.launch = captured_upload, captured_function, captured_launch
    try:
        for scalar in (False, True):
            with (out/f'fixtures-{"scalar" if scalar else "block"}-seed{seed}.log').open('w') as log:
                with contextlib.redirect_stdout(log):
                    affine_block_ab.run(driver, np.random.default_rng(seed), scalar)
        branch_phase = True
        with (out/f'fixtures-branches-seed{seed}.log').open('w') as log, contextlib.redirect_stdout(log):
            k.run_affine_block_branches(driver, np.random.default_rng(seed))
    finally:
        driver.free()
        (out/f'dataflow-seed{seed}.json').write_text(json.dumps(reports, indent=2) + '\n')
    return int(not reports or any(row['differences'] or row['guards'] or
                                 (row['float_writes'] and not row['mutation_detected']) for row in reports))


if __name__ == '__main__':
    sys.exit(main())
