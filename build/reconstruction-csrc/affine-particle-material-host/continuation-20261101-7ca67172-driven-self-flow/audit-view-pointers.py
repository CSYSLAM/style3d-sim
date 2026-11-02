"""Resolve every captured surface-view pointer against same-run live allocations without launching CUDA."""
import ctypes as ct
import hashlib
import json
from pathlib import Path
import re
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import SCALAR_WORDS, schemas

SELF = BASE.parent / 'continuation-20261101-0dabbaa7-driven-cloth-self'
OUTPUT = BASE / 'surface-view-pointer-audit.json'
assert not OUTPUT.exists(), 'Preserve earlier audit results'
HASHES = {}


def read(path):
    data = path.read_bytes()
    HASHES[str(path.resolve())] = hashlib.sha256(data).hexdigest()
    return data.decode()


def spans(words):
    capacity, local, total, shapes, bodies = [words[i] for i in (8, 112, 120, 200, 264)]
    assert (capacity, local, total, shapes, bodies) == (180, 16, 48, 2, 2)
    result = {0: 4, 64: words[72] * 4}
    result.update({off: capacity * width for off, width in
                   ((16, 12), (24, 12), (32, 4), (40, 12), (48, 12), (56, 12))})
    result.update({off: local * 4 for off in (80, 88, 96, 104)})
    result.update({off: shapes * width for off, width in
                   ((128, 4), (136, 4), (144, 28), (152, 12), (160, 4), (168, 4),
                    (176, 4), (184, 4), (192, 4))})
    result.update({240: bodies * 4, 248: bodies * 16, 256: bodies * 12, 272: total * 12, 280: total * 12})
    assert set(result) == set(range(0, 296, 8)) - SCALAR_WORDS['U']
    return result


def capture(directory, schema):
    lines = read(directory / 'launches.txt').splitlines()
    model = json.loads(read(directory / 'capture.pointers.json'))
    runtime = json.loads(read(directory / 'capture.runtime.json'))
    read(directory / 'wrapper-provenance.json')
    assert runtime['frames'] == 3
    live, identity, launch, result, owned_fields, external_fields = {}, 0, 0, [], 0, 0
    for line in read(directory / 'memory.jsonl').splitlines():
        row = json.loads(line)
        assert not row.get('status', 0)
        api = row.get('api', '')
        if api in ('cudaMalloc', 'cuMemAlloc_v2'):
            address = int(row['dst'], 16)
            assert address not in live
            live[address] = (identity, row['bytes'])
            identity += 1
        elif api in ('cudaFree', 'cuMemFree_v2'):
            del live[int(row['dst'], 16)]
        elif row.get('kind') == -2 and api in schema:
            head, tail = lines[launch].split(' symbol:', 1)
            assert tail.split()[0] == api
            args = head.split()[5:]
            assert len(args) == len(schema[api])
            for argument, typ in enumerate(schema[api]):
                if typ != 'U':
                    continue
                assert args[argument].startswith('Uview:')
                words = {int(off): int(word, 16) for off, word in
                         re.findall(r'(\d+):([0-9a-f]+)\([^)]*\)', args[argument])}
                assert set(words) == set(range(0, 296, 8))
                fields = []
                for offset, size in sorted(spans(words).items()):
                    address = words[offset]
                    matches = [(key, number, length) for key, (number, length) in live.items()
                               if key <= address < key + length]
                    assert len(matches) <= 1
                    if not address:
                        assert offset == 64 and size == 0
                        target = ['null']
                    elif matches:
                        start, number, length = matches[0]
                        assert address - start + size <= length, (launch, offset, size, length)
                        target = ['owned', number, address - start, length, size]
                        owned_fields += 1
                    else:
                        # External Warp allocation bounds are absent from this solver-scoped memory observer.
                        target = ['external-exact-address', hex(address), model.get(hex(address)), size]
                        external_fields += 1
                    fields.append([offset, *target])
                scalars = [[off, words[off] & 0xffffffff if off == 288 else words[off]]
                           for off in sorted(SCALAR_WORDS['U'])]
                result.append({'launch': launch, 'name': api, 'argument': argument,
                               'scalars': scalars, 'pointer_fields': fields})
            launch += 1
    assert launch == len(lines)
    return result, {'owned_launches': launch, 'surface_view_calls': len(result),
                    'owned_fields_with_valid_complete_span': owned_fields,
                    'external_exact_address_fields_without_allocation_bounds': external_fields}


schema, _ = schemas()
cases = []
for name in ('so3-w3-pd-b0-surface-d0', 'six-springs-w3-pd-b1-surface-d0'):
    directory = SELF / 'constructors-force-order' / name / 'external-full-memory'
    original, original_counts = capture(directory / 'original', schema)
    source, source_counts = capture(directory / 'source', schema)
    assert len(original) == len(source) == 72
    differences = [{'view_index': i, 'original': a, 'source': b}
                   for i, (a, b) in enumerate(zip(original, source)) if a != b]
    cases.append({'case': name, 'original_counts': original_counts, 'source_counts': source_counts,
                  'all_captured_view_fields_equal': not differences, 'differences': differences,
                  'original': original, 'source': source})
for path in (Path(__file__), ROOT / 'reconstruction/csrc/audit_cudahook.py',
             ROOT / 'reconstruction/csrc/native/surface_view.h',
             ROOT / 'build/reconstruction-csrc/host-particles/build.json'):
    read(path)
report = {'cases': cases, 'all_captured_surface_views_equal': all(not row['differences'] for row in cases),
          'original_source_view_pairs': sum(row['original_counts']['surface_view_calls'] for row in cases),
          'external_Warp_allocation_bounds_proven': False, 'pointee_values_compared': False,
          'remaining_host_copy_or_clear_semantics_proven': False, 'GPU_used': False,
          'fixed_C8_failures_reclassified': False, 'candidate_promoted': False, 'whole_solver_complete': False,
          'input_sha256': HASHES}
OUTPUT.write_text(json.dumps(report, indent=2) + '\n')
print(json.dumps({k: v for k, v in report.items() if k not in ('cases', 'input_sha256')}), flush=True)
raise SystemExit(int(not report['all_captured_surface_views_equal']))
