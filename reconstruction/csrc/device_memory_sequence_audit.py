"""Compare captured D2D copies and byte fills by live allocation, external pointer-use anchor and launch boundary."""
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path

from .audit_cudahook import schemas


def capture(directory, schema):
    labels = json.loads((directory / 'capture.pointers.json').read_text())
    launches = (directory / 'launches.txt').read_text().splitlines()
    # External anchors describe pointer equality/use relationships; they do not establish pointee equality.
    external = {}
    for index, line in enumerate(launches):
        head, suffix = line.split(' symbol:', 1)
        name = suffix.split()[0]
        for argument, (value, kind) in enumerate(zip(head.split()[5:], schema[name])):
            if kind == 'pointer':
                address = int(value.removeprefix('u:'), 16)
                if address:
                    external.setdefault(address, ['external_first_flat_use', index, argument])
    live, next_id, owned, phase = {}, 0, -1, 'initialize'
    streams, operations, unresolved = {}, [], []

    def pointer(address, size):
        if not address:
            assert size == 0
            return ['null']
        found = [(identity, address - start, capacity) for start, (identity, capacity) in live.items()
                 if start <= address < start + capacity]
        assert len(found) <= 1
        if found:
            identity, offset, capacity = found[0]
            assert offset + size <= capacity
            return ['owned', identity, offset]
        if hex(address) in labels:
            return ['model_span', labels[hex(address)]]
        if address in external:
            return external[address]
        result = ['unresolved_external', hex(address)]
        unresolved.append(result)
        return result

    def stream_label(raw):
        value = int(raw, 16)
        if value <= 2:
            return ['special', value]
        streams.setdefault(value, len(streams))
        return ['observed_stream', streams[value]]

    for text in (directory / 'memory.jsonl').read_text().splitlines():
        row = json.loads(text)
        assert row.get('status', 0) == 0
        api = row.get('api', '')
        if row.get('event') == 'end_initialize':
            phase = 'step'
        if row.get('kind') == -2 and api in schema:
            owned += 1
        if api in ('cudaMalloc', 'cuMemAlloc_v2'):
            address = int(row['dst'], 16)
            assert address not in live
            live[address] = next_id, row['bytes']
            next_id += 1
        elif api in ('cudaFree', 'cuMemFree_v2'):
            live.pop(int(row['dst'], 16))
        elif api in ('cudaMemset', 'cudaMemsetAsync', 'cuMemsetD8_v2', 'cuMemsetD8Async'):
            operations.append({'operation': 'byte_fill', 'phase': phase, 'preceding_owned_launch': owned,
                               'destination': pointer(int(row['dst'], 16), row['bytes']), 'bytes': row['bytes'],
                               'value': row['kind'] & 255, 'asynchronous': 'Async' in api,
                               'stream': stream_label(row['stream'])})
        elif api in ('cuMemcpyDtoD_v2', 'cuMemcpyDtoDAsync_v2') or (
                api in ('cudaMemcpy', 'cudaMemcpyAsync') and row['kind'] == 3):
            operations.append({'operation': 'device_copy', 'phase': phase, 'preceding_owned_launch': owned,
                               'source': pointer(int(row['src'], 16), row['bytes']),
                               'destination': pointer(int(row['dst'], 16), row['bytes']), 'bytes': row['bytes'],
                               'asynchronous': 'Async' in api, 'stream': stream_label(row['stream'])})
    assert owned + 1 == len(launches)
    return {'operations': operations, 'unresolved_targets': unresolved, 'owned_launches': owned + 1,
            'counts': dict(Counter(row['operation'] for row in operations))}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--capture', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert not args.output.exists()
    schema = schemas()[0]
    results = [capture(args.capture / side, schema) for side in ('original', 'source')]
    left, right = [row['operations'] for row in results]
    differences = [{'operation': i, 'original': a, 'source': b}
                   for i, (a, b) in enumerate(zip(left, right)) if a != b]
    files = [Path(__file__), *[args.capture / side / name for side in ('original', 'source')
                              for name in ('memory.jsonl', 'launches.txt', 'capture.pointers.json')]]
    report = {'operation_counts_equal': len(left) == len(right), 'all_captured_sequences_equal': left == right,
              'differences': differences, 'captures': results,
              'external_anchor_pointee_equality_proven': False, 'all_cuda_apis_captured': False,
              'same_run_allocation_lifetimes_respected': True, 'no_additional_gpu_runs': True,
              'whole_solver_complete': False,
              'input_sha256': {str(p.resolve()): hashlib.sha256(p.read_bytes()).hexdigest() for p in files}}
    args.output.write_text(json.dumps(report, indent=2) + '\n')
    print('Device copies/fills', [r['counts'] for r in results], 'equal', left == right,
          'differences', len(differences), flush=True)
    return int(left != right)


if __name__ == '__main__':
    raise SystemExit(main())
