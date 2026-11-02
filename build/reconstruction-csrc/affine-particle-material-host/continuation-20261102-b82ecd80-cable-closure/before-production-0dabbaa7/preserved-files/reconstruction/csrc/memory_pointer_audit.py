"""Resolve flat owned-kernel pointers against live allocation IDs and offsets in a same-run memory trace."""
import argparse
import hashlib
import json
from pathlib import Path

from .audit_cudahook import schemas


def capture(directory, schema):
    lines = (directory/'launches.txt').read_text().splitlines()
    result, live, next_id = [], {}, 0
    for text in (directory/'memory.jsonl').read_text().splitlines():
        row = json.loads(text)
        api = row.get('api', '')
        if api in ('cudaMalloc', 'cuMemAlloc_v2'):
            assert not row['status']
            live[int(row['dst'], 16)] = (next_id, row['bytes'])
            next_id += 1
        elif api in ('cudaFree', 'cuMemFree_v2'):
            live.pop(int(row['dst'], 16))
        elif row.get('kind') == -2 and api in schema:
            head, symbol = lines[len(result)].split(' symbol:', 1)
            assert symbol.split()[0] == api
            arguments = head.split()[5:]
            assert len(arguments) == len(schema[api])
            pointers = []
            for index, (value, kind) in enumerate(zip(arguments, schema[api])):
                if kind != 'pointer':
                    continue
                assert value.startswith('u:')
                address = int(value[2:], 16)
                found = [(identity, address-start) for start, (identity, size) in live.items()
                         if start <= address < start+size]
                assert len(found) <= 1
                target = ['owned', *found[0]] if found else ['external', hex(address)] if address else ['null']
                pointers.append([index, *target])
            result.append({'name': api, 'pointers': pointers})
    assert len(result) == len(lines), 'Memory/kernel capture coverage differs'
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--capture', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    schema = schemas()[0]
    original, source = [capture(args.capture/name, schema) for name in ('original', 'source')]
    assert len(original) == len(source)
    differences = [{'launch': i, 'original': a, 'source': b}
                   for i, (a, b) in enumerate(zip(original, source)) if a != b]
    files = [Path(__file__), *[args.capture/name/file for name in ('original', 'source')
                             for file in ('memory.jsonl', 'launches.txt', 'capture.runtime.json')]]
    report = {'launches': len(original), 'all_flat_pointer_targets_equal': not differences,
              'differences': differences, 'original': original, 'source': source,
              'allocation_lifetimes_respected': True, 'opaque_view_fields_compared': False,
              'pointee_data_compared': False, 'whole_solver_equality_claimed': False,
              'sha256': {str(p.resolve()): hashlib.sha256(p.read_bytes()).hexdigest() for p in files}}
    assert not args.output.exists()
    args.output.write_text(json.dumps(report, indent=2)+'\n')
    print('Pointer targets', len(original), 'launches, equal', not differences, flush=True)
    return int(bool(differences))


if __name__ == '__main__':
    raise SystemExit(main())
