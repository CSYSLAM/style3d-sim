"""Audit the floating-point expression feeding each joint-kernel write on concrete test paths.

This is a narrow PTX dataflow diagnostic, not a replacement solver or a PTX interpreter for validation.
It follows one lane's control flow using captured input bytes, and compares expression DAGs before JIT
contraction. Only register moves, commutative add/multiply/FMA operands, and the exact IEEE predicate complement
``gtu = not le`` / ``geu = not lt`` are normalized. Unsupported instructions raise an error. GPU A/B tests remain necessary
for divergent atomic ordering and JIT behavior.
"""
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
from reconstruction.numerics import fma
from reconstruction.joints import _add_rz


def bits(value):
    return int(np.asarray(value, dtype=np.float32).view(np.uint32))


def floating(value):
    return np.asarray(value & 0xffffffff, dtype=np.uint32).view(np.float32)[()]


class Expressions:
    def __init__(self):
        self.nodes = []
        self.ids = {}

    def node(self, op, *args):
        if op in ('mul.f32', 'add.f32', 'min.f32', 'max.f32', 'and.b32', 'or.b32', 'xor.b32', 'xor.b16'):
            args = tuple(sorted(args))
        elif op == 'fma.rn.f32':
            args = (*sorted(args[:2]), args[2])
        key = (op, *args)
        if key not in self.ids:
            self.ids[key] = len(self.nodes)
            self.nodes.append(key)
        return self.ids[key]

    def difference(self, left, right, depth=0):
        if left == right:
            return None
        a, b = self.nodes[left], self.nodes[right]
        if a[0] != b[0] or len(a) != len(b) or a[0] in ('constant', 'load', 'parameter'):
            return {'depth': depth, 'legacy': a, 'source': b}
        for x, y in zip(a[1:], b[1:]):
            if x != y:
                return self.difference(x, y, depth+1)


class PathAudit:
    def __init__(self, entry, params, memory, expressions, allow_dead_undefined=False, block=256, mutable_writes=False,
                 approx_rsqrt=None, grid=1, opcode_extension=None):
        self.params, self.memory, self.expressions = params, memory, expressions
        self.allow_dead_undefined = allow_dead_undefined
        self.block, self.mutable_writes = block, mutable_writes
        self.approx_rsqrt = approx_rsqrt
        self.grid = grid
        self.opcode_extension = opcode_extension
        self.local_symbols = {name: 0x600000000000 + 4096*i for i, name in enumerate(
            re.findall(r'\.local\s+\.align\s+\d+\s+\.b8\s+(\w+)\[\d+\]', entry))}
        self.instructions, self.labels = [], {}
        for line in entry[entry.index('{')+1:entry.rindex('}')].splitlines():
            line = line.split('//')[0].strip()
            if not line or line.startswith('.') or line in ('{', '}'):
                continue
            if line.endswith(':'):
                self.labels[line[:-1]] = len(self.instructions)
            else:
                self.instructions.append(line.rstrip(';'))

    def run(self, lane, include_values=False):
        registers, formulas, writes, comparisons = {}, {}, [], []
        atomic_values = {}
        stored = {}
        local = {}
        local_undefined = set()
        undefined = set()
        registers.update({'%ctaid.x': lane//self.block, '%ntid.x': self.block, '%tid.x': lane % self.block,
                          '%nctaid.x': self.grid})
        def value(token):
            if token in self.local_symbols:
                return self.local_symbols[token]
            if token.startswith('%'):
                if token not in registers and self.allow_dead_undefined:
                    # Some legacy early-exit blocks compare uninitialized floats, then OR that predicate
                    # with a known-true rejection flag. Reject any observable use of the undefined value.
                    registers[token] = 0
                    undefined.add(token)
                    formulas[token] = self.expressions.node('undefined', token)
                return registers[token]
            if token.startswith('0f'):
                return int(token[2:], 16)
            if token.startswith('0d'):
                return int(token[2:], 16)
            return int(token)
        def formula(token):
            if token in formulas:
                return formulas[token]
            mask = 0xffffffffffffffff if token.startswith('0d') else 0xffffffff
            return self.expressions.node('constant', value(token) & mask)
        def signed(number, width):
            number &= (1 << width)-1
            return number-(1 << width) if number & (1 << (width-1)) else number
        def address(token):
            match = re.fullmatch(r'\[(%\w+)([+-]\d+)?\]', token.replace('+-', '-'))
            if not match:
                raise ValueError(token)
            base_value = value(match[1])
            if match[1] in undefined:
                raise RuntimeError('Undefined memory address: ' + token)
            return base_value+int(match[2] or 0)
        pcounter = 0
        extension_state = {'registers': registers, 'formulas': formulas, 'undefined': undefined,
                           'value': value, 'formula': formula, 'expressions': self.expressions,
                           'comparisons': comparisons}
        while pcounter < len(self.instructions):
            line = self.instructions[pcounter]
            pcounter += 1
            if line.startswith('@'):
                predicate, line = line.split(None, 1)
                token = predicate[2:] if predicate.startswith('@!') else predicate[1:]
                enabled = value(token)
                if token in undefined:
                    raise RuntimeError(f'Undefined branch predicate: {token}, lane={lane}, instruction={pcounter}, '
                                       f'undefined={sorted(undefined)}')
                if bool(enabled) == predicate.startswith('@!'):
                    continue
            op, _, operands = line.partition(' ')
            if self.opcode_extension and self.opcode_extension(op, operands, extension_state):
                continue
            args = [a.strip() for a in operands.split(',')]
            loaded_undefined = False
            if op.startswith('bra'):
                pcounter = self.labels[args[0]]
                continue
            if op == 'ret':
                break
            if op.startswith('st.local.'):
                if args[1] in undefined and not self.allow_dead_undefined:
                    raise RuntimeError('Undefined local value: ' + args[1])
                addr = address(args[0])
                local[addr] = value(args[1]), formula(args[1])
                if args[1] in undefined:
                    local_undefined.add(addr)
                else:
                    local_undefined.discard(addr)
                continue
            if op.startswith(('red.', 'st.global.')):
                stored_value = value(args[1])
                if args[1] in undefined:
                    raise RuntimeError('Undefined output value: ' + args[1])
                write = (address(args[0]), formula(args[1]))
                mask = 0xffffffffffffffff if op.endswith(('u64', 's64', 'b64', 'f64')) else 0xffffffff
                writes.append((*write, stored_value & mask) if include_values else write)
                if self.mutable_writes and op.startswith('st.global.'):
                    stored[write[0]] = stored_value & mask, write[1]
                continue
            dst, src = args[0], args[1:]
            if op.startswith('ld.local.'):
                addr = address(src[0])
                if addr not in local and self.allow_dead_undefined:
                    result, expression = 0, self.expressions.node('undefined_local', addr)
                    loaded_undefined = True
                else:
                    result, expression = local[addr]
                    loaded_undefined = addr in local_undefined
                if op.endswith('s32'):
                    result = signed(result, 32)
                formulas[dst] = expression
            elif op.startswith('ld.param'):
                match = re.search(r'_param_(\d+)(?:\+(\d+))?\]', src[0])
                index, offset = int(match[1]), int(match[2] or 0)
                param = self.params[index]
                if isinstance(param, ctypes.Array):
                    result = struct.unpack_from('<I' if op.endswith('f32') else '<Q', bytes(param), offset)[0]
                else:
                    result = bits(param.value) if op.endswith('f32') else param.value
                formulas[dst] = self.expressions.node('parameter', index, offset) if op.endswith('f32') else None
            elif op in ('atom.global.add.u32', 'atom.global.exch.b32'):
                if any(token in undefined for token in src):
                    raise RuntimeError('Undefined atomic operand')
                addr = address(src[0])
                if addr not in atomic_values:
                    base = next(base for base, data in self.memory.items() if base <= addr < base+len(data))
                    atomic_values[addr] = struct.unpack_from('<I', self.memory[base], addr-base)[0]
                result = atomic_values[addr]
                atomic_values[addr] = ((result + value(src[1])) if op.endswith('add.u32') else value(src[1])) & 0xffffffff
                expression = self.expressions.node('constant', atomic_values[addr])
                write = (addr, expression)
                writes.append((*write, atomic_values[addr]) if include_values else write)
                formulas[dst] = self.expressions.node('constant', result)
            elif op.startswith('ld.global'):
                addr = address(src[0])
                base = next(base for base, data in self.memory.items() if base <= addr < base+len(data))
                wide = op.endswith(('u64', 's64', 'b64', 'f64'))
                fmt = '<Q' if wide else '<B' if op.endswith(('u8', 's8', 'b8')) else '<I'
                result = struct.unpack_from(fmt, self.memory[base], addr-base)[0]
                expression = self.expressions.node('load', base, addr-base)
                if self.mutable_writes and addr in stored:
                    result, expression = stored[addr]
                if op.endswith('s32'):
                    result = signed(result, 32)
                elif op.endswith('s8'):
                    result = signed(result, 8)
                # Repeated loads at the same byte address have the same immutable input value.
                formulas[dst] = expression
            elif op.startswith(('mov.', 'cvta.')):
                result = value(src[0])
                formulas[dst] = formula(src[0])
            elif op == 'cvt.sat.f32.f32':
                operand = floating(value(src[0]))
                result = bits(np.fmin(np.fmax(operand, np.float32(0)), np.float32(1)))
                formulas[dst] = self.expressions.node(op, formula(src[0]))
            elif op == 'cvt.rzi.f32.f32':
                result = bits(np.trunc(floating(value(src[0]))))
                formulas[dst] = self.expressions.node(op, formula(src[0]))
            elif op == 'cvt.rmi.f32.f32':
                result = bits(np.floor(floating(value(src[0]))))
                formulas[dst] = self.expressions.node(op, formula(src[0]))
            elif op == 'cvt.rzi.s32.f32':
                operand = floating(value(src[0]))
                if not np.isfinite(operand) or not -(2**31) <= operand < 2**31:
                    raise NotImplementedError('Out-of-range float-to-int conversion')
                result = int(np.trunc(operand))
                formulas[dst] = self.expressions.node(op, formula(src[0]))
            elif op.startswith('selp.'):
                selected = src[0] if value(src[2]) else src[1]
                result = value(selected)
                formulas[dst] = formula(selected)
            elif op.startswith('cvt.'):
                result = value(src[0])
                if op.endswith('s32'):
                    result = signed(result, 32)
                if '.u32.' in op:
                    result &= 0xffffffff
            elif op.startswith('setp.'):
                kind, dtype = op.split('.')[1:]
                a, b = map(value, src)
                if dtype == 'f32':
                    a, b = floating(a), floating(b)
                elif dtype.startswith('s'):
                    a, b = signed(a, int(dtype[1:])), signed(b, int(dtype[1:]))
                elif dtype.startswith('u'):
                    a, b = a & ((1 << int(dtype[1:]))-1), b & ((1 << int(dtype[1:]))-1)
                unordered = dtype == 'f32' and (np.isnan(a) or np.isnan(b))
                if kind.endswith('u'):
                    result = unordered
                    kind = kind[:-1]
                else:
                    result = False
                result = result or {'eq': lambda: a == b, 'ne': lambda: a != b,
                                    'lt': lambda: a < b, 'le': lambda: a <= b,
                                    'gt': lambda: a > b, 'ge': lambda: a >= b}[kind]()
                if dtype == 'f32' and not any(token in undefined for token in src):
                    original_kind = op.split('.')[1]
                    complements = {'gtu': 'le', 'geu': 'lt', 'leu': 'gt', 'ltu': 'ge'}
                    canonical_kind = complements.get(original_kind, original_kind)
                    canonical_result = not result if original_kind in complements else bool(result)
                    comparisons.append((canonical_kind, formula(src[0]), formula(src[1]), canonical_result))
            elif op.endswith('.f32'):
                numbers = [floating(value(v)) for v in src]
                kind = op.split('.')[0]
                with np.errstate(all='ignore'):
                    if op == 'add.rz.f32': result = _add_rz(*numbers)
                    elif kind == 'add': result = numbers[0]+numbers[1]
                    elif kind == 'sub': result = numbers[0]-numbers[1]
                    elif kind == 'mul': result = numbers[0]*numbers[1]
                    elif kind == 'div': result = numbers[0]/numbers[1]
                    elif kind == 'sqrt': result = np.sqrt(numbers[0])
                    elif op == 'rsqrt.approx.f32' and self.approx_rsqrt is not None:
                        result = floating(self.approx_rsqrt(bits(numbers[0])))
                    elif kind == 'rcp': result = np.float32(1)/numbers[0]
                    elif kind == 'min': result = np.fmin(*numbers)
                    elif kind == 'max': result = np.fmax(*numbers)
                    elif kind == 'neg': result = -numbers[0]
                    elif kind == 'abs': result = abs(numbers[0])
                    elif kind == 'fma': result = fma(*numbers)
                    else: raise NotImplementedError(op)
                result = bits(result)
                formulas[dst] = self.expressions.node(op, *(formula(v) for v in src))
            else:
                kind = op.split('.')[0]
                values = [value(v) for v in src]
                if '.s32' in op:
                    values = [signed(v, 32) for v in values]
                elif '.u32' in op:
                    values = [v & 0xffffffff for v in values]
                elif '.u64' in op:
                    values = [v & 0xffffffffffffffff for v in values]
                if kind == 'add': result = values[0]+values[1]
                elif kind == 'mad': result = values[0]*values[1]+values[2]
                elif kind == 'sub': result = values[0]-values[1]
                elif kind == 'mul':
                    result = values[0]*values[1]
                    if '.hi.' in op:
                        result >>= 32 if op.endswith('32') else 64
                elif kind == 'div': result = values[0]//values[1]
                elif kind == 'rem': result = values[0] % values[1]
                elif kind == 'min': result = min(values)
                elif kind == 'max': result = max(values)
                elif kind == 'shr': result = values[0] >> values[1]
                elif kind == 'shl': result = values[0] << values[1]
                elif kind == 'and': result = values[0] & values[1]
                elif kind == 'or': result = values[0] | values[1]
                elif kind == 'xor': result = values[0] ^ values[1]
                elif kind == 'not': result = not values[0] if op.endswith('.pred') else ~values[0]
                else: raise NotImplementedError(op)
                if op.endswith('.b32') or kind == 'shr':
                    formulas[dst] = self.expressions.node(op, *(formula(v) for v in src))
                if op.endswith('.s32') and '.wide.' not in op:
                    result = signed(result, 32)
            tainted = loaded_undefined or any(token in undefined for token in src)
            if op == 'or.pred' and any(token not in undefined and value(token) for token in src):
                tainted = False
            elif op == 'and.pred' and any(token not in undefined and not value(token) for token in src):
                tainted = False
            elif op.startswith('selp.') and src[2] not in undefined:
                tainted = (src[0] if value(src[2]) else src[1]) in undefined
            if tainted:
                undefined.add(dst)
            else:
                undefined.discard(dst)
            registers[dst] = int(result)
        return writes, comparisons


def nonfinite_gpu_probe(driver, reference, compiled, name, threads, params, memory):
    """Compare original/compiled GPU bits directly for cases outside the finite-geometry NumPy spec domain."""
    tangent = 'multiply_joint_drive_tangent' in name
    output_index = 18 if tangent else 17
    axis_index, reference_index = (6, 7) if tangent else (5, 6)
    reports = []
    cases = [('infinite_axis', axis_index, np.inf), ('nan_axis', axis_index, np.nan),
             ('infinite_reference', reference_index, np.inf)]
    if tangent:
        cases.append(('infinite_direction', 1, np.inf))
    for label, index, value in cases:
        data = np.frombuffer(memory[params[index].value], dtype=np.float32).copy().reshape(-1, 3)
        # Lanes 1 and 17 are disjoint world-parent drives of the two joint types.
        data[[1, 17], 0] = value
        args = list(params)
        args[index] = driver.upload(data)
        before = np.frombuffer(memory[params[output_index].value], dtype=np.uint32).copy()
        results = []
        for function in (reference, compiled):
            args[output_index] = driver.upload(before)
            driver.launch(function, threads, args)
            results.append(driver.download(args[output_index], before))
        reports.append({'case': label, 'mismatches': int(np.count_nonzero(results[0] != results[1]))})
    return reports


def main():
    if os.environ.get('RECONSTRUCTION_KERNELS'):
        raise RuntimeError('Run this original/source diagnostic without RECONSTRUCTION_KERNELS set')
    seed = int(sys.argv[1]) if len(sys.argv) > 1 else 1
    ours = pc.compile_ptx(pc.CSRC/'kernels/joints.cu', pc.DEFAULT_NVCC)
    source = pc.entries(ours)
    driver = k.Driver()
    original_upload, original_function, original_launch = driver.upload, driver.function, driver.launch
    memory, targets, report, nonfinite = {}, {}, [], []
    pool = Expressions()

    def upload(array):
        pointer = original_upload(array)
        memory[pointer.value] = np.ascontiguousarray(array).tobytes()
        return pointer

    def function(ptx, name):
        result = original_function(ptx, name)
        if any(part in name for part in ('30add_joint_drive_preconditioner', '28multiply_joint_drive_tangent',
                                         '38initialize_joint_coordinate_velocities')):
            targets[result.value] = name, pc.entries(ptx)[name]
        return result

    def launch(fun, threads, params, block=256):
        if fun.value in targets:
            name, legacy = targets[fun.value]
            reference = PathAudit(legacy, params, memory, pool)
            compiled = PathAudit(source[name], params, memory, pool)
            differences, guard_differences, writes = [], [], 0
            mutant = PathAudit(source[name].replace('mul.f32', 'add.f32', 1), params, memory, pool)
            mutation_detected = False
            for lane in range(threads+1):
                left, left_guards = reference.run(lane)
                right, right_guards = compiled.run(lane)
                writes += len(left)
                if not mutation_detected:
                    mutated, _ = mutant.run(lane)
                    mutation_detected = mutated != left
                if Counter(left_guards) != Counter(right_guards):
                    guard_differences.append({'lane': lane,
                        'legacy_only': list((Counter(left_guards)-Counter(right_guards)).elements()),
                        'source_only': list((Counter(right_guards)-Counter(left_guards)).elements())})
                if left != right:
                    first = next(((a, b) for a, b in zip(left, right) if a != b), None)
                    differences.append({'lane': lane, 'legacy_writes': len(left), 'source_writes': len(right),
                                        'first': first,
                                        'expression': pool.difference(first[0][1], first[1][1]) if first else None})
            item = {'kernel': name.split('kernel')[1].split('EPK')[0], 'lanes': threads+1,
                    'write_expressions': writes, 'differences': differences, 'guard_differences': guard_differences,
                    'mul_to_add_mutation_detected': mutation_detected}
            report.append(item)
            print(json.dumps(item), flush=True)
            if threads == 79 and 'initialize_joint_coordinate_velocities' not in name:
                # Use the unwrapped methods so these direct comparisons cannot recurse into the auditor.
                plain = k.Driver()
                try:
                    rows = nonfinite_gpu_probe(plain, fun, original_function(ours, name), name, threads, params, memory)
                    nonfinite.append({'kernel': item['kernel'], 'cases': rows})
                    print(json.dumps(nonfinite[-1]), flush=True)
                finally:
                    plain.free()
        original_launch(fun, threads, params, block)

    driver.upload, driver.function, driver.launch = upload, function, launch
    try:
        k.run_joint_drives(driver, np.random.default_rng(seed))
        k.run_joint_drive_branches(driver, np.random.default_rng(seed))
    finally:
        driver.free()
    (pc.OUT/'drive-audit').mkdir(parents=True, exist_ok=True)
    target = pc.OUT/'drive-audit'/f'dataflow-seed{seed}.json'
    target.write_text(json.dumps(report, indent=2)+'\n')
    (pc.OUT/'drive-audit'/f'nonfinite-gpu-seed{seed}.json').write_text(json.dumps(nonfinite, indent=2)+'\n')
    if any(case['mismatches'] for row in nonfinite for case in row['cases']):
        sys.exit(1)
    if any(r['differences'] or r['guard_differences'] or not r['mul_to_add_mutation_detected'] for r in report):
        sys.exit(1)


if __name__ == '__main__':
    main()
