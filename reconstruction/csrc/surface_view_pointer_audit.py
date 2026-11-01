"""Resolve captured SurfaceContactView words using same-run allocation lifetimes and Model pointer labels."""
import argparse
import hashlib
import json
from pathlib import Path
import re

from .audit_cudahook import SCALAR_WORDS, schemas
from .host_api_probe import REFERENCE_SHA


POINTER_FIELDS = {
    0: 'count', 16: 'indices', 24: 'barycentric', 32: 'shape', 40: 'body_pos', 48: 'body_vel', 56: 'normal',
    64: 'particle_only', 80: 'radius', 88: 'mass', 96: 'flags', 104: 'kind', 128: 'shape_body',
    136: 'shape_type', 144: 'transform', 152: 'shape_scale', 160: 'shape_margin', 168: 'shape_ke',
    176: 'shape_kd', 184: 'shape_kf', 192: 'shape_mu', 240: 'body_ids', 248: 'body_indices',
    256: 'body_com', 272: 'x', 280: 'previous',
}
assert set(POINTER_FIELDS) | SCALAR_WORDS['U'] == set(range(0, 296, 8))
assert not set(POINTER_FIELDS) & SCALAR_WORDS['U']


def capture(directory, schema, step_bindings=False):
    lines = (directory / 'launches.txt').read_text().splitlines()
    labels = json.loads((directory / 'capture.pointers.json').read_text())
    bindings = ([json.loads(line) for line in (directory / 'step-bindings.jsonl').read_text().splitlines()]
                if step_bindings else [])
    context = None
    live, identity, launch, views = {}, 0, 0, []
    for line in (directory / 'memory.jsonl').read_text().splitlines():
        row = json.loads(line)
        assert row.get('status', 0) == 0
        api = row.get('api', '')
        if step_bindings and row.get('event', '').startswith('surface_binding_step_'):
            step_index = int(row['event'].removeprefix('surface_binding_step_'))
            context = bindings[step_index]
            assert context['step'] == step_index
        elif api in ('cudaMalloc', 'cuMemAlloc_v2'):
            start = int(row['dst'], 16)
            assert start not in live
            live[start] = (identity, row['bytes'])
            identity += 1
        elif api in ('cudaFree', 'cuMemFree_v2'):
            live.pop(int(row['dst'], 16))
        elif row.get('kind') == -2 and api in schema:
            head, suffix = lines[launch].split(' symbol:', 1)
            assert suffix.split()[0] == api and int(head.split()[0]) == launch
            arguments = head.split()[5:]
            assert len(arguments) == len(schema[api])
            for index, (value, kind) in enumerate(zip(arguments, schema[api])):
                if kind != 'U':
                    continue
                words = {int(off): int(bits, 16) for off, bits in re.findall(r'(\d+):([0-9a-f]+)\([^)]*\)', value)}
                assert set(words) == set(range(0, 296, 8)), (launch, index)
                pointers = []
                for offset, field in POINTER_FIELDS.items():
                    address = words[offset]
                    found = [(owned_id, address - start) for start, (owned_id, size) in live.items()
                             if start <= address < start + size]
                    assert len(found) <= 1
                    if not address:
                        target = ['null']
                    elif found:
                        target = ['owned', *found[0]]
                    elif hex(address) in labels:
                        target = ['model', labels[hex(address)]]
                    else:
                        aliases = sorted(group + '.' + name for group, spans in (context or {}).get('spans', {}).items()
                                         for name, span in spans.items() if span['ptr'] == address and span['size'])
                        # A step marker selects the exact native State/Contact instances for this launch.
                        target = (['native_step_span', aliases] if aliases else
                                  ['unresolved_external_address', hex(address)])
                    pointers.append([offset, field, *target])
                scalars = [[offset, words[offset] & (0xffffffff if offset == 288 else 0xffffffffffffffff)]
                           for offset in sorted(SCALAR_WORDS['U'])]
                assert not step_bindings or context is not None
                views.append({'owned_launch': launch, 'kernel': api, 'argument': index,
                              'pointers': pointers, 'scalar_words': scalars})
            launch += 1
    assert launch == len(lines) and views, 'Require complete owned coverage and actual surface view calls'
    return views


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--capture', type=Path, required=True, help='Full-memory folder containing original and source')
    parser.add_argument('--build', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--step-bindings', action='store_true', help='Use actual native step spans and memory markers')
    args = parser.parse_args()
    assert not args.output.exists()
    metadata = json.loads(args.build.read_text())
    schema = schemas()[0]
    inputs = [Path(__file__), Path(__file__).parent / 'native/surface_view.h', args.build]
    runtimes = []
    for side in ('original', 'source'):
        folder = args.capture / side
        for name in ('memory.jsonl', 'launches.txt', 'capture.runtime.json', 'capture.pointers.json'):
            inputs.append(folder / name)
        if args.step_bindings:
            inputs.extend((folder / 'step-bindings.jsonl', folder / 'binding-runtime.json'))
        runtimes.append(json.loads((folder / 'capture.runtime.json').read_text()))
    assert runtimes[0]['image_sha256'] == REFERENCE_SHA
    assert runtimes[1]['image_sha256'] == metadata['extension_sha256']
    for key in ('example_sha256', 'extra', 'frames'):
        assert runtimes[0][key] == runtimes[1][key], key
    original, source = [capture(args.capture / side, schema, args.step_bindings) for side in ('original', 'source')]
    assert len(original) == len(source)
    differences = [{'view': i, 'original': a, 'source': b}
                   for i, (a, b) in enumerate(zip(original, source)) if a != b]
    counts = {}
    for row in original:
        for pointer in row['pointers']:
            counts[pointer[2]] = counts.get(pointer[2], 0) + 1
    report = {'source_sha256': metadata['extension_sha256'], 'view_calls': len(original),
              'pointer_fields_per_view': len(POINTER_FIELDS), 'pointer_target_counts': counts,
              'all_captured_view_records_equal': not differences, 'differences': differences,
              'original': original, 'source': source, 'allocation_lifetimes_respected': True,
              'external_semantic_identity_proved': not counts.get('unresolved_external_address', 0),
              'actual_native_step_bindings_used': args.step_bindings,
              'unresolved_external_addresses_compared_verbatim': True, 'inv_dt_padding_compared': False,
              'pointee_contents_compared': False, 'all_opaque_views_compared': False, 'whole_solver_complete': False,
              'input_sha256': {str(p.resolve()): hashlib.sha256(p.read_bytes()).hexdigest() for p in inputs}}
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2) + '\n')
    print('Surface view records', len(original), 'equal', not differences, 'targets', counts, flush=True)
    return int(bool(differences))


if __name__ == '__main__':
    raise SystemExit(main())
