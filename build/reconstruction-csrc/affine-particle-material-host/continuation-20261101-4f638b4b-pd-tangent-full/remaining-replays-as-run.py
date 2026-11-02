"""Replay every complementary RHS/preconditioner/CG stage at the four preplanned early/late PD frames."""
import argparse
import ctypes as ct
import hashlib
import importlib.util
import json
from pathlib import Path

import numpy as np

from .demo_source_ab import ROOT


KINDS = {
    'CG-direction',
    'CG-precondition',
    'CG-product',
    'CG-solution',
    'SO3-force',
    'apply',
    'authored-bonds',
    'dynamic-bonds',
    'grain-contacts',
    'inverse-block',
    'rhs-initialize',
}


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def verify(hashes):
    for path, expected in hashes.items():
        assert sha(Path(path)) == expected, path


def prepare(phase):
    from .g1_contact_rhs_replay import kernel_texts

    capture = phase / 'tangent-captures'
    terminal = json.loads((capture / 'status.json').read_text())
    assert terminal['complete'] and len(terminal['completed']) == 4
    audit = json.loads((phase / 'tangent-independent-cpu-audit.json').read_text())
    assert audit['stage_packets_checked'] == 51120 and audit['public_q_matches'] == 240
    hashes = dict(audit['input_sha256'])
    hashes[str(Path(__file__))] = sha(Path(__file__))
    preflight_path = phase / 'CPU-preflight.json'
    preflight = json.loads(preflight_path.read_text())
    frames = preflight['preplanned_replay_frames']
    assert frames == [0, 31, 32, 59]
    hashes[str(preflight_path)] = sha(preflight_path)
    metadata_path = phase.parent / 'continuation-20261101-0dabbaa7-granular-affine-contacts/candidate-guard-only/build.json'
    candidate = json.loads(metadata_path.read_text())
    image = Path(candidate['image'])
    assert sha(image) == candidate['image_sha256'] == '4f638b4b9141e6ad6e2aabfb6533f8ed23bdfedbf7c1508063ea96bdb7e09326'
    hashes.update({str(p): sha(p) for p in (image, metadata_path)})
    packets, kernels = [], set()
    for worker in range(4):
        for frame in frames:
            folder = capture / str(worker) / f'tangent-graph-{frame % 2}'
            layout = json.loads((folder / 'snapshot-layout.json').read_text())
            selected = [stage for stage in layout['stages'] if stage['kind'] in KINDS]
            assert len(selected) == 81 and all(s['all_flat_pointer_inputs_captured'] for s in selected)
            for stage in selected:
                kernels.add(stage['node']['name'])
                packets.append({'worker': worker, 'frame': frame, 'stage': stage,
                                'input': str(folder / f'frames/frame-{frame:02d}.npz')})
    assert len(packets) == 1296
    build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    build = json.loads(build_path.read_text())
    for name in kernels:
        _, original = kernel_texts(build, name)
        hashes[str(original)] = sha(original)
    hashes[str(build_path)] = sha(build_path)
    output = phase / 'remaining-input-replays'
    output.mkdir(exist_ok=False)
    plan = {'input_sha256': hashes, 'packets': packets, 'frames': frames, 'kernel_names': sorted(kernels),
            'candidate_image': str(image), 'candidate_sha256': sha(image),
            'backends': ['SDK-runtime', 'original-ptx', 'source-ptx'], 'expected_unmodified_calls': 3888,
            'original_frozen_failure_replaced': False, 'cohort_expanded': False,
            'production_changed': False, 'whole_solver_complete': False}
    verify(hashes)
    (output / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
    print('Prepared2112 complete input packets at preplanned frames0/31/32/59;3888 actual calls planned', flush=True)


def execute(phase):
    from reconstruction import kernel_ab as k
    from .g1_contact_rhs_replay import kernel_texts
    from .host_api_probe import REFERENCE, REFERENCE_SHA, load_reference
    from .pcg_alias_replay import span_groups
    from .pcg_same_buffer_probe import Dim3

    output = phase / 'remaining-input-replays'
    plan = json.loads((output / 'plan.json').read_text())
    verify(plan['input_sha256'])
    assert sha(REFERENCE) == REFERENCE_SHA
    (output / 'packets').mkdir(exist_ok=False)
    build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    build_bytes = build_path.read_bytes()
    build = json.loads(build_bytes)
    driver = k.Driver()
    load_reference()
    runtime = ct.CDLL(str(REFERENCE))
    runtime_launch = runtime.cudaLaunchKernel
    runtime_launch.argtypes = [ct.c_void_p, Dim3, Dim3, ct.POINTER(ct.c_void_p), ct.c_size_t, ct.c_void_p]
    runtime_launch.restype = ct.c_int
    image = Path(plan['candidate_image'])
    assert sha(image) == plan['candidate_sha256']
    spec = importlib.util.spec_from_file_location('_source_solver', image)
    core = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(core)
    assert core.source_only and not core.solver_api_ready
    source = core._KernelDriver()
    functions = {}
    for name in plan['kernel_names']:
        texts, _ = kernel_texts(build, name)
        functions[name] = {'SDK-runtime': ct.cast(getattr(runtime, name), ct.c_void_p),
                           'original-ptx': driver.function(texts['original'], name),
                           'source-ptx': ct.c_void_p(source.function(name))}
    stream = ct.c_void_p()
    driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
    rows, calls, error = [], 0, None
    loaded_path, loaded_arrays = None, None
    try:
        for number, packet in enumerate(plan['packets']):
            assert build_path.read_bytes() == build_bytes
            stage, path = packet['stage'], Path(packet['input'])
            if loaded_path != path:
                if loaded_arrays is not None:
                    loaded_arrays.close()
                loaded_arrays, loaded_path = np.load(path, allow_pickle=False), path
            bindings = {b['label']: loaded_arrays[stage['key'] + '/before/' + b['label']].tobytes()
                        for b in stage['bindings']}
            addresses = {b['label']: b['address'] for b in stage['bindings']}
            expected = {label: loaded_arrays[stage['key'] + '/after/' + label].tobytes() for label in stage['outputs']}
            groups = span_groups(addresses, bindings)
            pointers, raw_groups, metadata = {}, [], []
            for group in groups:
                prefix = 256 + group['start'] % 256
                data = np.full(prefix + len(group['initial']) + 256, 211, dtype='u1')
                data[prefix:prefix + len(group['initial'])] = group['initial']
                device = driver.upload(data)
                assert device.value % 256 == 0
                mask = np.ones(len(data), dtype=bool)
                for label in group['indices']:
                    offset = prefix + addresses[label] - group['start']
                    pointers[label] = device.value + offset
                    assert pointers[label] % 256 == addresses[label] % 256
                    if label in expected:
                        mask[offset:offset + len(bindings[label])] = False
                raw_groups.append((device, data, mask))
                metadata.append({'start': group['start'], 'bytes': len(group['initial']), 'labels': group['indices'],
                                 'prefix': prefix, 'device_base': device.value})
            node = stage['node']
            raw = [bytearray.fromhex(value) for value in node['parameter_hex']]
            for binding in stage['bindings']:
                index, offset = binding['argument'], binding['offset']
                assert int.from_bytes(raw[index][offset:offset + 8], 'little') == binding['address']
                raw[index][offset:offset + 8] = pointers[binding['label']].to_bytes(8, 'little')
            parameters = [(ct.c_ubyte * len(value)).from_buffer_copy(value) for value in raw]
            holders = (ct.c_void_p * len(parameters))(*[ct.cast(ct.byref(v), ct.c_void_p) for v in parameters])
            arrays = {'actual-parameter-' + str(i): np.frombuffer(bytes(v), dtype='u1').copy()
                      for i, v in enumerate(parameters)}
            checks = []
            rotation = number % 3
            order = plan['backends'][rotation:] + plan['backends'][:rotation]
            for backend in order:
                for device, before, _ in raw_groups:
                    driver.check(driver.cu.cuMemcpyHtoD_v2(device, ct.c_void_p(before.ctypes.data), before.nbytes))
                gx, gy, gz, bx, by, bz, shared = node['geometry']
                function = functions[node['name']][backend]
                if backend == 'SDK-runtime':
                    assert runtime_launch(function, Dim3(gx, gy, gz), Dim3(bx, by, bz), holders, shared, stream) == 0
                else:
                    driver.check(driver.cu.cuLaunchKernel(function, gx, gy, gz, bx, by, bz, shared, stream, holders, None))
                driver.check(driver.cu.cuStreamSynchronize(stream))
                calls += 1
                for index, (device, before, mask) in enumerate(raw_groups):
                    after = driver.download(device, np.empty_like(before))
                    arrays[backend + '-group-' + str(index)] = after.copy()
                    assert after[mask].tobytes() == before[mask].tobytes(), (number, backend, 'Read-only/guard changed')
                equal = {}
                for label, target in expected.items():
                    actual = driver.download(ct.c_uint64(pointers[label]), np.zeros(len(target), dtype='u1'))
                    arrays[backend + '-output-' + label] = actual.copy()
                    equal[label] = actual.tobytes() == target
                checks.append({'backend': backend, 'complete_output_equal_to_capture': equal,
                               'all_complete_outputs_strict': all(equal.values()), 'all_unwritten_and_guards_equal': True})
            target = output / 'packets' / f'{number:04d}-w{packet["worker"]}-f{packet["frame"]:02d}-{stage["key"]}.npz'
            np.savez_compressed(target, **arrays)
            rows.append({'number': number, 'worker': packet['worker'], 'frame': packet['frame'], 'stage': stage['key'],
                         'kind': stage['kind'], 'checks': checks, 'groups': metadata, 'pointers': pointers,
                         'output': str(target), 'output_sha256': sha(target)})
            driver.free()
            if number % 81 == 0:
                print('Full contact/tangent packet', number + 1, '/', len(plan['packets']), flush=True)
        verify(plan['input_sha256'])
    except BaseException as problem:
        error = f'{type(problem).__name__}: {problem}'
        raise
    finally:
        if loaded_arrays is not None:
            loaded_arrays.close()
        result = {'packets': rows, 'actual_calls': calls, 'error': error,
                  'complete': len(rows) == 1296 and error is None,
                  'strict_packets': sum(all(c['all_complete_outputs_strict'] for c in r['checks']) for r in rows),
                  'all_unwritten_and_guards_equal': all(c['all_unwritten_and_guards_equal'] for r in rows for c in r['checks']),
                  'original_frozen_failure_reclassified': False, 'production_changed': False, 'whole_solver_complete': False}
        (output / 'report.json').write_text(json.dumps(result, indent=2) + '\n')
        driver.free()
        driver.check(driver.cu.cuStreamDestroy_v2(stream))
    assert result['complete'] and calls == 3888 and result['all_unwritten_and_guards_equal']
    print('Full contact/tangent complete:', result['strict_packets'], '/1296 strict;3888 actual calls', flush=True)
    return int(result['strict_packets'] != 1296)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--phase', type=Path, required=True)
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument('--prepare', action='store_true')
    mode.add_argument('--execute', action='store_true')
    args = parser.parse_args()
    if args.prepare:
        prepare(args.phase.resolve())
        return 0
    return execute(args.phase.resolve())


if __name__ == '__main__':
    raise SystemExit(main())
