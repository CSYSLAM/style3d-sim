"""Resolve the actual CableView's opaque pointer fields against live solver allocations and model spans."""
import hashlib
import json
from pathlib import Path
import re
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import schemas

hashes = {}


def read(path):
    raw = path.read_bytes()
    hashes[str(path)] = hashlib.sha256(raw).hexdigest()
    return raw.decode()


def capture(folder, schema):
    lines = read(folder / 'launches.txt').splitlines()
    labels = json.loads(read(folder / 'capture.pointers.json'))
    live, identity, ordinal, result = {}, 0, 0, []
    for line in read(folder / 'memory.jsonl').splitlines():
        event = json.loads(line)
        assert not event.get('status', 0)
        api = event.get('api', '')
        if api in ('cudaMalloc', 'cuMemAlloc_v2'):
            address = int(event['dst'], 16)
            assert address not in live
            live[address] = (identity, event['bytes'])
            identity += 1
        elif api in ('cudaFree', 'cuMemFree_v2'):
            del live[int(event['dst'], 16)]
        elif event.get('kind') == -2 and api in schema:
            head, tail = lines[ordinal].split(' symbol:', 1)
            assert tail.split()[0] == api
            args = head.split()[5:]
            for argument, kind in enumerate(schema[api]):
                if kind != 'C':
                    continue
                words = {int(offset): int(value, 16) for offset, value in
                         re.findall(r'(\d+):([0-9a-f]+)\([^)]*\)', args[argument])}
                assert set(words) == set(range(0, 160, 8))
                local, total, particles = [words[offset] for offset in (136, 144, 152)]
                assert local == total and particles == total * 8
                fields = []
                for offset in range(0, 136, 8):
                    pointer = words[offset]
                    if not pointer:
                        assert offset == 56, (api, offset)
                        target = ['null']
                    elif offset >= 104:
                        span = {104: total * 8 * 36, 112: total * 8 * 36,
                                120: total * 8 * 4, 128: total * 4}[offset]
                        matches = [(start, number, size) for start, (number, size) in live.items()
                                   if start <= pointer < start + size]
                        assert len(matches) == 1
                        start, number, size = matches[0]
                        assert pointer - start + span <= size
                        target = ['owned', number, pointer - start, size, span]
                    else:
                        label = labels.get(hex(pointer))
                        assert label is not None, (api, offset, hex(pointer))
                        target = ['external-exact-address', hex(pointer), label]
                    fields.append([offset, *target])
                result.append({'launch': ordinal, 'name': api, 'argument': argument,
                               'scalars': [local, total, particles], 'pointer_fields': fields})
            ordinal += 1
    assert ordinal == len(lines)
    return result


schema = schemas()[0]
root = BASE / 'constructors-cache-order'
status = json.loads(read(root / 'status.json'))
assert status['complete'] and status['running'] is None
plan = json.loads(read(root / 'plan.json'))
cases = []
for case in plan['cases']:
    group = root / case['name'] / 'external-full-memory'
    original, source = [capture(group / side, schema) for side in ('original', 'source')]
    assert original == source and original, case['name']
    cases.append({'case': case['name'], 'complete_view_pairs': len(original), 'all_fields_equal': True,
                  'observations': original})
for path in (Path(__file__), ROOT / 'reconstruction/csrc/kernels/cable_types.cuh',
             BASE / 'candidate-cache-order/source_solver.cpp'):
    read(path)
report = {'cases': cases, 'complete_view_pairs': sum(row['complete_view_pairs'] for row in cases),
          'owned_cache_complete_spans_with_live_allocation_identity_checked': True,
          'external_fields_exact_addresses_and_model_labels_checked': True,
          'external_Warp_allocation_bounds_independently_recorded': False, 'pointee_contents_compared': False,
          'input_sha256': hashes, 'GPU_used': False, 'production_modified': False, 'whole_solver_complete': False}
(BASE / 'cable-view-independent-cpu.json').write_text(json.dumps(report, indent=2) + '\n')
print('CPU checked', report['complete_view_pairs'], 'complete CableView pairs and live owned-cache spans')
