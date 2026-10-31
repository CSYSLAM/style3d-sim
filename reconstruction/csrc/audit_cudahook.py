"""Audit the diagnostic hook against the current kernel ABI and compare complete launch logs.

    .venv/bin/python -m reconstruction.csrc.audit_cudahook LEFT/launches.txt RIGHT/launches.txt --output report.json

Pointer values are compared for nullness using demangled parameter types, never address magnitude. Pointee data
must be compared separately through CUDAHOOK_DUMP; matching this report alone is not a solver equivalence proof.
"""
import argparse
import itertools
import json
import re
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
WIDTH = dict(f=4, u=8, i=4, c=1, b=1, G=24, V=112, T=12, R=248, J=120, L=32, U=296, H=312, W=120, M=1864, C=160)
SCALAR_WORDS = {
    'V': {80, 88, 96, 104},
    'R': {8, 152, 160, 168, 208, 216, 240},
    'J': {96, 104, 112},
    'L': set(),
    'C': {136, 144, 152},
    'H': {8, 152, 160, 168, 200, 208, 232, 240, 248},
    'W': {88, 96, 104, 112},
    # SourceSurfaceView in native/surface_view.h; the final word also contains four padding bytes.
    'U': {8, 72, 112, 120, 200, 208, 216, 224, 232, 264, 288},
}

# Only these fields are read by the named kernels; opaque Model regions are not a whole-Model equivalence claim.
MODEL_FIELDS = {
    '12fluid_kernel10build_grid': {
        'u32': (24, 28, 192, 216, 220, 232), 'u64': (128,), 'pointer': (48, 120, 200, 240, 256)},
    '12fluid_kernel10scale_step': {'u32': (24, 28), 'u64': (128,), 'pointer': (120,)},
    '15granular_kernel10build_grid': {'u32': (24, 28, 272), 'u64': (128,), 'pointer': (120, 136, 280)},
    '15granular_kernel12commit_bonds': {'u32': (316, 320, 324)},
    '15granular_kernel16accumulate_bonds': {'u32': (312, 316, 320, 324)},
    '15granular_kernel10form_bonds': {'u32': (332, 336, 340)},
}


def parameter_types(symbol):
    text = subprocess.check_output(['c++filt', symbol], text=True).strip()
    depth = 0
    for i, char in enumerate(text):
        depth += (char == '<') - (char == '>')
        if char == '(' and depth == 0:
            signature = text[i + 1:-1]
            break
    types, start, depth = [], 0, 0
    for i, char in enumerate(signature):
        depth += (char == '<') - (char == '>')
        if char == ',' and depth == 0:
            types.append(signature[start:i].strip())
            start = i + 1
    types.append(signature[start:].strip())
    return types


def schemas():
    source = (ROOT/'reconstruction/diagnostics/cudahook.c').read_text()
    entries = re.findall(r'\{"([^"]+)", "([^"]+)"\}', source)
    kernels = json.loads((ROOT/'build/reconstruction-csrc/host-particles/build.json').read_text())['kernels']
    result, checked = {}, 0
    for key, layout in entries:
        for name, kernel in kernels.items():
            if key not in name:
                continue
            widths = [WIDTH[c] for c in layout]
            if widths != kernel['parameters']:
                raise ValueError(f'{key}: hook widths {widths} differ from ABI {kernel["parameters"]}')
            types = parameter_types(name)
            if len(types) != len(layout):
                raise ValueError(f'{key}: demangled parameter count differs')
            normalized = ['pointer' if '*' in typ else kind for typ, kind in zip(types, layout)]
            if key in result and result[key] != normalized:
                raise ValueError(f'{key}: overloads need separate layouts')
            if name not in result:
                checked += 1
            result[key] = normalized
            result[name] = normalized
    return result, checked


def normalize(line, schema):
    fields = line.split()
    key = fields[1]
    if key not in schema:
        raise ValueError(f'Unrecognized kernel in capture: {key}')
    arguments = fields[5:]
    launch = arguments.pop() if arguments and arguments[-1].startswith('launch:') else None
    symbol = arguments.pop()[7:] if arguments and arguments[-1].startswith('symbol:') else None
    if symbol is not None and (symbol not in schema or key not in symbol):
        raise ValueError(f'{key}: actual function symbol differs from the pinned ABI inventory: {symbol}')
    types = schema[symbol] if symbol else schema[key]
    if len(arguments) != len(types):
        raise ValueError(f'{key}: logged argument count differs from ABI')
    result = [key, fields[2], fields[3], symbol, launch]
    for value, kind in zip(arguments, types):
        if kind == 'pointer':
            if not value.startswith('u:'):
                raise ValueError(f'{key}: pointer encoded with wrong width')
            result.append('pointer:NULL' if int(value[2:], 16) == 0 else 'pointer:present')
        elif kind == 'M':
            words = dict((int(off), int(word, 16)) for off, word in re.findall(r'(\d+):([0-9a-f]+)\([^)]*\)', value))
            if len(words) != 233:
                raise ValueError(f'{key}: incomplete by-value Model capture')
            fields = next((fields for token, fields in MODEL_FIELDS.items() if token in key), None)
            if fields is None:
                raise ValueError(f'{key}: kernel-read Model fields have not been audited')
            values = []
            for field_kind, offsets in fields.items():
                for offset in offsets:
                    bits = words[offset // 8 * 8]
                    if field_kind == 'u32':
                        bits = (bits >> (32 if offset % 8 else 0)) & 0xffffffff
                    values.append((offset, ('NULL' if bits == 0 else 'pointer') if field_kind == 'pointer' else bits))
            result.append(values)
        elif kind in SCALAR_WORDS:
            words = re.findall(r'(\d+):([0-9a-f]+)\([^)]*\)', value)
            if len(words) != WIDTH[kind] // 8:
                raise ValueError(f'{key}: incomplete by-value view')
            if kind == 'U':
                words = [(off, f'{int(word, 16) & 0xffffffff:x}' if int(off) == 288 else word)
                         for off, word in words]
            if kind == 'H':
                words = [(off, f'{int(word, 16) & 0x00ffffffffffffff:x}' if int(off) == 248 else word)
                         for off, word in words]
            if kind == 'W':
                words = [(off, f'{int(word, 16) & 0xffffffff:x}' if int(off) == 112 else word)
                         for off, word in words]
            result.append([(int(off), word if int(off) in SCALAR_WORDS[kind]
                            else ('NULL' if int(word, 16) == 0 else 'pointer')) for off, word in words])
        elif kind in ('M', 'V', 'W', 'H'):
            raise ValueError(f'{key}: this view still needs explicit pointer-field metadata')
        else:
            result.append(value)
    return result


def compare(left, right, schema):
    differences, mismatch_count, left_count, right_count = [], 0, 0, 0
    complete_metadata = True
    with left.open() as a, right.open() as b:
        for i, (x, y) in enumerate(itertools.zip_longest(a, b)):
            for line in (x, y):
                if line is not None and int(line.split()[0]) != i:
                    raise ValueError('Capture sequence is incomplete or was appended to an existing log')
                if line is not None:
                    fields = line.split()
                    complete_metadata &= (fields[-1].startswith('launch:') and
                                          len(fields[-1][7:].split(',')) == 8 and
                                          fields[-2].startswith('symbol:'))
            left_count += x is not None
            right_count += y is not None
            old = normalize(x, schema) if x is not None else None
            new = normalize(y, schema) if y is not None else None
            if old != new:
                mismatch_count += 1
                if len(differences) < 16:
                    differences.append({'launch': i, 'left': old, 'right': new})
    if not left_count or not right_count:
        raise ValueError('Empty launch capture')
    return {'left_launches': left_count, 'right_launches': right_count, 'different_launches': mismatch_count,
            'examples': differences, 'arguments_equal': mismatch_count == 0,
            'geometry_and_shared_memory_complete': complete_metadata,
            'equal': mismatch_count == 0 and complete_metadata}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('left', type=Path, nargs='?')
    parser.add_argument('right', type=Path, nargs='?')
    parser.add_argument('--output', type=Path)
    parser.add_argument('--source-counts', type=Path, help='C++ source_launch_counts JSON to check full coverage')
    args = parser.parse_args()
    schema, count = schemas()
    report = {'abi_entries_checked': count}
    if args.left or args.right:
        if not (args.left and args.right):
            parser.error('Both capture paths are required')
        report.update(compare(args.left, args.right, schema))
        if args.source_counts:
            expected = sum(json.loads(args.source_counts.read_text()).values())
            report['expected_source_launches'] = expected
            report['equal'] &= report['right_launches'] == expected
    if args.output:
        args.output.write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps({k: v for k, v in report.items() if k != 'examples'}))
    return 1 if report.get('equal') is False else 0


if __name__ == '__main__':
    raise SystemExit(main())
