"""Typed double/bit-move diagnostic operations for cable PTX; the existing float32 auditor stays unchanged."""
import ctypes
import math
import re
import struct

import numpy as np

from reconstruction.csrc.audit_drive_ptx import Expressions, bits, floating


def bits64(value):
    return struct.unpack('<Q', struct.pack('<d', value))[0]


def floating64(value):
    return struct.unpack('<d', struct.pack('<Q', value & 0xffffffffffffffff))[0]


_fma64 = ctypes.CDLL('libm.so.6').fma
_fma64.argtypes = (ctypes.c_double, ctypes.c_double, ctypes.c_double)
_fma64.restype = ctypes.c_double


class CableExpressions(Expressions):
    def node(self, op, *args):
        if op in ('mul.f64', 'add.f64', 'min.f64', 'max.f64'):
            args = tuple(sorted(args))
        elif op == 'fma.rn.f64':
            args = (*sorted(args[:2]), args[2])
        return super().node(op, *args)


def double_operations(op, operands, state):
    operands = operands.strip()
    value, formula = state['value'], state['formula']
    pool, undefined = state['expressions'], state['undefined']

    def put(dst, result, expression, sources):
        state['registers'][dst] = int(result)
        state['formulas'][dst] = expression
        if any(token in undefined for token in sources):
            undefined.add(dst)
        else:
            undefined.discard(dst)

    if op == 'mov.b64' and operands.startswith('{'):
        low, high, src = re.fullmatch(r'\{(%\w+),\s*(%\w+)\},\s*(%\w+)', operands).groups()
        raw = value(src)
        put(low, raw & 0xffffffff, pool.node('low32', formula(src)), [src])
        put(high, (raw >> 32) & 0xffffffff, pool.node('high32', formula(src)), [src])
        return True
    args = [part.strip() for part in operands.split(',')]
    dst, src = args[0], args[1:]
    if op in ('cvt.f64.f32', 'cvt.rn.f64.f32'):
        result = bits64(float(floating(value(src[0]))))
        put(dst, result, pool.node('cvt.f64.f32', formula(src[0])), src)
        return True
    if op == 'cvt.rn.f32.f64':
        with np.errstate(all='ignore'):
            result = bits(floating64(value(src[0])))
        put(dst, result, pool.node(op, formula(src[0])), src)
        return True
    if op == 'cvt.rn.f64.s64':
        raw = value(src[0]) & 0xffffffffffffffff
        result = float(raw - 2**64 if raw & 2**63 else raw)
        put(dst, bits64(result), pool.node(op, formula(src[0])), src)
        return True
    if op == 'cvt.rn.f32.s32':
        raw = value(src[0]) & 0xffffffff
        put(dst, bits(raw - 2**32 if raw & 2**31 else raw), pool.node(op, formula(src[0])), src)
        return True
    if op == 'cvt.rni.s32.f32':
        number = floating(value(src[0]))
        if not np.isfinite(number) or not -(2**31) <= number < 2**31:
            raise NotImplementedError('Out-of-range rni float-to-int conversion')
        put(dst, int(np.rint(number)), pool.node(op, formula(src[0])), src)
        return True
    if op in ('bfe.u32', 'bfi.b64'):
        raw = [value(token) for token in src]
        if op == 'bfe.u32':
            number, start, width = raw
            start, width = start & 0xff, width & 0xff
            width = min(width, max(0, 32 - start))
            result = ((number & 0xffffffff) >> start) & ((1 << width) - 1)
        else:
            number, old, start, width = raw
            start, width = start & 0xff, width & 0xff
            width = min(width, max(0, 64 - start))
            mask = ((1 << width) - 1) << start
            result = ((old & ~mask) | ((number << start) & mask)) & 0xffffffffffffffff
        put(dst, result, pool.node(op, *(formula(token) for token in src)), src)
        return True
    if op.startswith('setp.') and op.endswith('.f64'):
        kind = op.split('.')[1]
        a, b = (floating64(value(token)) for token in src)
        unordered = math.isnan(a) or math.isnan(b)
        ordered = kind[:-1] if kind.endswith('u') else kind
        result = (unordered and kind.endswith('u')) or {
            'eq': lambda: a == b, 'ne': lambda: a != b, 'lt': lambda: a < b,
            'le': lambda: a <= b, 'gt': lambda: a > b, 'ge': lambda: a >= b}[ordered]()
        if not any(token in undefined for token in src):
            complement = {'gtu': 'le', 'geu': 'lt', 'leu': 'gt', 'ltu': 'ge'}
            state['comparisons'].append((complement.get(kind, kind), formula(src[0]), formula(src[1]),
                                         not bool(result) if kind in complement else bool(result)))
        put(dst, result, pool.node('constant', int(result)), src)
        return True
    if not op.endswith('.f64') or op.startswith(('ld.', 'st.')):
        return False
    if op == 'mov.f64':
        put(dst, value(src[0]), formula(src[0]), src)
        return True
    kind = op.split('.')[0]
    numbers = [floating64(value(token)) for token in src]
    with np.errstate(all='ignore'):
        if kind == 'add': result = np.float64(numbers[0]) + numbers[1]
        elif kind == 'sub': result = np.float64(numbers[0]) - numbers[1]
        elif kind == 'mul': result = np.float64(numbers[0]) * numbers[1]
        elif kind == 'div': result = np.float64(numbers[0]) / numbers[1]
        elif kind == 'sqrt': result = np.sqrt(numbers[0])
        elif kind == 'abs': result = abs(numbers[0])
        elif kind == 'neg': result = -numbers[0]
        elif kind == 'rcp': result = np.float64(1) / numbers[0]
        elif kind == 'max': result = np.fmax(*numbers)
        elif kind == 'min': result = np.fmin(*numbers)
        elif kind == 'fma': result = _fma64(*numbers)
        else: raise NotImplementedError(op)
    put(dst, bits64(result), pool.node(op, *(formula(token) for token in src)), src)
    return True
