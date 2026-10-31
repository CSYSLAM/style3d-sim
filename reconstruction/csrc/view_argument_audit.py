"""Resolve captured by-value view words against same-run live allocations, preserving scalar fields."""
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import re

from .audit_cudahook import SCALAR_WORDS, WIDTH, schemas


def capture(folder, schema):
    launches = (folder / 'launches.txt').read_text().splitlines()
    live, identity, result = {}, 0, []
    for text in (folder / 'memory.jsonl').read_text().splitlines():
        row = json.loads(text)
        api = row.get('api', '')
        if api in ('cudaMalloc', 'cuMemAlloc_v2'):
            assert not row['status']
            live[int(row['dst'], 16)] = (identity, row['bytes'])
            identity += 1
        elif api in ('cudaFree', 'cuMemFree_v2'):
            assert not row['status']
            live.pop(int(row['dst'], 16))
        elif row.get('kind') == -2 and api in schema:
            head, symbol = launches[len(result)].split(' symbol:', 1)
            assert symbol.split()[0] == api
            arguments = head.split()[5:]
            assert len(arguments) == len(schema[api])
            fields = []
            for index, (value, kind) in enumerate(zip(arguments, schema[api])):
                if kind not in SCALAR_WORDS:
                    continue
                words = re.findall(r'(\d+):([0-9a-f]+)\([^)]*\)', value)
                assert len(words) == WIDTH[kind] // 8
                for offset, bits in words:
                    offset, bits = int(offset), int(bits, 16)
                    if kind == 'U' and offset == 288 or kind == 'W' and offset == 112:
                        bits &= 0xffffffff
                    if kind == 'H' and offset == 248:
                        bits &= 0x00ffffffffffffff
                    if offset in SCALAR_WORDS[kind]:
                        target = ['scalar', bits]
                    else:
                        found = [(i, bits - base) for base, (i, size) in live.items() if base <= bits < base + size]
                        assert len(found) <= 1
                        target = ['owned', *found[0]] if found else ['external', hex(bits)] if bits else ['null']
                    fields.append([index, kind, offset, *target])
            result.append({'name': api, 'fields': fields})
    assert len(result) == len(launches)
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--capture', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert not args.output.exists()
    schema = schemas()[0]
    old, new = [capture(args.capture / side, schema) for side in ('original', 'source')]
    assert len(old) == len(new) and [r['name'] for r in old] == [r['name'] for r in new]
    differences = [{'launch': i, 'original': a, 'source': b} for i, (a, b) in enumerate(zip(old, new)) if a != b]
    files = [Path(__file__), *[args.capture / side / name for side in ('original', 'source')
                              for name in ('launches.txt', 'memory.jsonl', 'capture.runtime.json')]]
    report = {
        'launches': len(old), 'view_words': dict(Counter(v[1] for row in old for v in row['fields'])),
        'all_captured_view_words_equal': not differences, 'differences': differences,
        'allocation_lifetimes_and_offsets_respected': True, 'pointee_values_compared': False,
        'whole_solver_complete': False,
        'sha256': {str(path.resolve()): hashlib.sha256(path.read_bytes()).hexdigest() for path in files},
    }
    args.output.write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({key: value for key, value in report.items() if key not in ('sha256', 'differences')}), flush=True)
    return int(bool(differences))


if __name__ == '__main__':
    raise SystemExit(main())
