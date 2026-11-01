"""Audit actual body/cloth constructor captures, including allocation positions relative to owned launches."""
import argparse
import hashlib
import json
from pathlib import Path

from .audit_cudahook import schemas
from . import initialization_trace_audit as initializers
from . import memory_pointer_audit as pointers
from .host_api_probe import REFERENCE_SHA


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--capture', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert not args.output.exists(), 'Keep the earlier audit immutable'
    root = args.capture.resolve(strict=True)
    inputs = {}
    schema = schemas()[0]

    def read(path):
        inputs[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
        return path.read_text()

    def allocation_sequence(side):
        result, live, identity, owned, phase = [], {}, 0, -1, 'initialize'
        for line in read(root/'cloth-w3-full-memory'/side/'memory.jsonl').splitlines():
            row = json.loads(line)
            assert row.get('status', 0) == 0
            if row.get('event') == 'end_initialize':
                phase = 'step'
            if row.get('kind') == -2 and row['api'] in schema:
                owned += 1
            if row.get('api') in ('cudaMalloc', 'cuMemAlloc_v2'):
                live[row['dst']] = identity
                result.append(['allocate', identity, row['bytes'], phase, owned])
                identity += 1
            elif row.get('api') in ('cudaFree', 'cuMemFree_v2'):
                result.append(['release', live.pop(row['dst']), phase, owned])
        return result

    def payloads(side):
        folder = root/'cloth-w3-payload'/side
        result = []
        for line in read(folder/'memory.jsonl').splitlines():
            row = json.loads(line)
            assert row.get('status', 0) == 0
            if 'file' in row:
                path = folder/row['file']
                data = path.read_bytes()
                inputs[str(path.resolve())] = hashlib.sha256(data).hexdigest()
                result.append(data)
        return result

    build = json.loads(read(root/'build.json'))
    for observer in ('cloth-w3-initializers', 'cloth-w3-full-memory', 'cloth-w3-payload'):
        read(root/observer/'provenance.json')
        runtimes = [json.loads(read(root/observer/side/'capture.runtime.json')) for side in ('original', 'source')]
        assert runtimes[0]['image_sha256'] == REFERENCE_SHA
        assert runtimes[1]['image_sha256'] == build['extension_sha256']
        for key in ('example_sha256', 'extra', 'frames'):
            assert runtimes[0][key] == runtimes[1][key], (observer, key)

    def kernel_timeline(side):
        result, unrecognized = [], set()
        for line in read(root/'cloth-w3-initializers'/side/'memory.jsonl').splitlines():
            row = json.loads(line)
            name = row.get('symbol', '')
            domain = 1 if side == 'source' and name.startswith('_ZN7synreal') else 2
            if row.get('domain') != domain or row.get('api') not in ('cudaLaunchKernel', 'cuLaunchKernel'):
                continue
            if name not in build['kernels']:
                if name.startswith(('_ZN7synreal', '_ZN6thrust', '_ZN3cub')):
                    unrecognized.add(name)
                continue
            result.append(name)
        assert not unrecognized, ('Unrecognized SDK/library CUDA entries', unrecognized)
        return result

    allocations = [allocation_sequence(side) for side in ('original', 'source')]
    uploads = [payloads(side) for side in ('original', 'source')]
    typed = [initializers.capture(root/'cloth-w3-initializers'/side, 2) for side in ('original', 'source')]
    flat = [pointers.capture(root/'cloth-w3-full-memory'/side, schema) for side in ('original', 'source')]
    timelines = [kernel_timeline(side) for side in ('original', 'source')]
    assert len(flat[0]) == len(flat[1]), 'Owned launch coverage differs'
    for observer in ('cloth-w3-initializers', 'cloth-w3-full-memory'):
        for side in ('original', 'source'):
            for name in ('launches.txt', 'memory.jsonl', 'capture.runtime.json'):
                read(root/observer/side/name)
    checks = {
        'allocation_release_bytes_identity_phase_and_preceding_owned_launch': allocations[0] == allocations[1],
        'upload_bytes_and_order': uploads[0] == uploads[1],
        'typed_initializer_fields_uses_and_order': list(map(initializers.signature, typed[0])) ==
                                                 list(map(initializers.signature, typed[1])),
        'flat_owned_pointer_allocation_identity_and_offset': flat[0] == flat[1],
        'owned_and_library_kernel_name_order': timelines[0] == timelines[1],
    }
    differences = [{'event': i, 'original': a, 'source': b}
                   for i, (a, b) in enumerate(zip(*allocations)) if a != b]
    report = {
        'source_sha256': build['extension_sha256'],
        'checks': checks, 'all_captured_checks_passed': all(checks.values()),
        'allocation_event_counts': list(map(len, allocations)), 'allocations': allocations,
        'allocation_differences': differences, 'upload_counts': list(map(len, uploads)),
        'typed_initializer_counts': list(map(len, typed)), 'owned_launches': len(flat[0]),
        'kernel_timeline_counts': list(map(len, timelines)), 'kernel_timelines': timelines,
        'all_cuda_api_names_identical_claimed': False, 'opaque_view_fields_compared': False,
        'noninitializer_library_geometry_compared': False,
        'all_device_copy_and_clear_semantics_compared': False, 'whole_solver_complete': False,
        'input_sha256': inputs, 'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps({key: report[key] for key in ('checks', 'allocation_event_counts', 'upload_counts',
                                                 'typed_initializer_counts', 'owned_launches')}), flush=True)
    return int(not report['all_captured_checks_passed'])


if __name__ == '__main__':
    raise SystemExit(main())
