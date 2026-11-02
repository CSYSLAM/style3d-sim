"""Recover launch parameter bytes from the complete hook log, preserving every recorded view word."""
from functools import lru_cache
import json
import math
from pathlib import Path
import re
import struct

from .audit_cudahook import WIDTH

ROOT = Path(__file__).resolve().parents[2]


@lru_cache(maxsize=1)
def layouts():
    text = (ROOT / 'reconstruction/diagnostics/cudahook.c').read_text()
    pairs = re.findall(r'\{"([^"]+)", "([^"]+)"\}', text)
    table = dict(pairs)
    assert len(table) == len(pairs), 'Ambiguous hook layout keys'
    abi = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())['kernels']
    return table, abi


def float_bytes(text):
    value = float(text)
    if math.isnan(value):
        raise ValueError('Textual NaN cannot preserve its original payload;use a raw parameter capture')
    return struct.pack('<f', value)


def decode(line):
    fields = line.split()
    assert len(fields) >= 7 and fields[-2].startswith('symbol:') and fields[-1].startswith('launch:')
    key, name = fields[1], fields[-2][7:]
    table, abi = layouts()
    layout = table[key]
    assert key in name and name in abi
    widths = [WIDTH[kind] for kind in layout]
    assert widths == abi[name]['parameters']
    arguments = fields[5:-2]
    assert len(arguments) == len(layout)
    raw = []
    for argument, kind, width in zip(arguments, layout, widths):
        if kind == 'f':
            assert argument.startswith('f:')
            value = float_bytes(argument[2:])
        elif kind in ('G', 'T'):
            prefix, values = argument.split(':', 1)
            assert prefix == ('aabb' if kind == 'G' else 'vec3')
            value = b''.join(float_bytes(v) for v in values.split(','))
        elif kind in ('u', 'i', 'c', 'b'):
            assert argument.startswith(('c:' if kind == 'b' else kind + ':'))
            value = int(argument[2:], 16 if kind == 'u' else 10).to_bytes(width, 'little')
        else:
            words = re.findall(r'(\d+):([0-9a-f]+)\([^)]*\),', argument)
            assert [int(offset) for offset, _ in words] == list(range(0, width, 8))
            value = b''.join(int(word, 16).to_bytes(8, 'little') for _, word in words)
        assert len(value) == width, (key, kind, len(value), width)
        raw.append(value.hex())
    geometry = list(map(int, fields[-1][7:].split(',')))
    assert len(geometry) == 8 and all(value > 0 for value in geometry[:6])
    assert geometry[0] == int(fields[2].removeprefix('grid='))
    assert geometry[3] == int(fields[3].removeprefix('block='))
    return {'name': name, 'key': key, 'parameter_widths': widths, 'parameter_hex': raw,
            'geometry': geometry[:7], 'stream_kind': geometry[7], 'owned_launch': int(fields[0])}
