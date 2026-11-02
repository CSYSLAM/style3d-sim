"""Replay complete captured self/PCG packets with identical aliases through SDK runtime, SDK PTX and source PTX."""
import argparse
from collections import defaultdict
import ctypes as ct
import hashlib
import importlib.util
import json
from pathlib import Path

import numpy as np

from .hook_parameter_bytes import decode

ROOT = Path(__file__).resolve().parents[2]
SELF_NAME = 'continuation-20261101-0dabbaa7-driven-cloth-self'
FLOW_NAME = 'continuation-20261101-7ca67172-driven-self-flow'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def verify(hashes):
    for name, expected in hashes.items():
        assert sha(Path(name)) == expected, name


def request(phase):
    output = phase / 'replay-request.json'
    assert not output.exists()
    abi_path = phase / 'raw-ABI/report.json'
    actual = json.loads(abi_path.read_text())
    assert actual['all_actual_parameter_bytes_equal'] and actual['owned_calls'] == 6272
    hashes = dict(actual['input_sha256'])
    flow = phase.parent / FLOW_NAME
    plan_path = flow / 'linear-flow-plan.json'
    plan = json.loads(plan_path.read_text())
    proof_path = flow / 'planned-write-proof.json'
    proof = json.loads(proof_path.read_text())
    assert proof['all_potential_writes_captured'] and proof['actual_PTX_entries_checked'] == 28
    hashes.update(plan['input_sha256'])
    hashes.update(proof['input_sha256'])
    for path in (Path(__file__), ROOT / 'reconstruction/csrc/hook_parameter_bytes.py', abi_path, plan_path, proof_path):
        hashes[str(path.resolve())] = sha(path)
    jobs = []
    names = set()
    for number, job in enumerate(plan['jobs']):
        stages = [stage for stage in job['stages'] if stage['all_flat_nonnull_inputs']]
        assert len(stages) == 297
        names.update(stage['symbol'] for stage in stages)
        jobs.append({'worker': number, 'case': job['case']['name'], 'backend': job['backend'],
                     'owned_launches': [stage['owned_launch'] for stage in stages]})
    assert len(jobs) == 4 and len(names) == 14
    record = {'jobs': jobs, 'kernel_names': sorted(names), 'input_sha256': hashes,
              'planned_complete_input_packets': 1188, 'planned_actual_calls': 3564,
              'backends': ['SDK-runtime', 'SDK-ptx', 'source-ptx'], 'all_three_frames_and_CG_iterations': True,
              'source_candidate_sha256': plan['candidate_image_sha256'],
              'original_fixed_samples_replaced': False, 'candidate_promoted': False, 'whole_solver_complete': False}
    verify(hashes)
    output.write_text(json.dumps(record, indent=2) + '\n')
    print('Requested1188 complete packets/3564 calls;all three frames and CG iterations;no GPU used', flush=True)


def prepare(phase):
    output = phase / 'complete-input-replays'
    output.mkdir(exist_ok=False)
    request_path = phase / 'replay-request.json'
    wanted = json.loads(request_path.read_text())
    verify(wanted['input_sha256'])
    flow, previous = phase.parent / FLOW_NAME, phase.parent / SELF_NAME
    status_path = flow / 'linear-captures-v2/status.json'
    status = json.loads(status_path.read_text())
    assert status['complete'] and len(status['completed']) == 5
    assert all(row['actual_exit'] == 0 for row in status['completed'])
    audit_path = flow / 'linear-independent-cpu-v2.json'
    audit = json.loads(audit_path.read_text())
    assert len(audit['workers']) == 4 and sum(row['actual_snapshot_files'] for row in audit['workers']) == 29844
    assert not audit['fixed_C8_failures_reclassified'] and not audit['candidate_promoted']
    hashes = {**wanted['input_sha256'], **audit['input_sha256']}
    plan_path = flow / 'linear-flow-plan.json'
    flow_plan = json.loads(plan_path.read_text())
    build_path = previous / 'candidate-force-order/build.json'
    build = json.loads(build_path.read_text())
    assert build['image_sha256'] == wanted['source_candidate_sha256']
    hashes.update(build['input_sha256'])
    image = Path(build['image'])
    assert sha(image) == build['image_sha256']
    for path in (request_path, status_path, audit_path, build_path, image):
        hashes[str(path.resolve())] = sha(path)
    packets = []
    for requested, job in zip(wanted['jobs'], flow_plan['jobs']):
        directory = flow / 'linear-captures-v2' / str(requested['worker'])
        lines = (directory / 'launches.txt').read_text().splitlines()
        counts = defaultdict(int)
        selected = {stage['owned_launch']: stage for stage in job['stages'] if stage['all_flat_nonnull_inputs']}
        assert list(selected) == requested['owned_launches']
        for stage in job['stages']:
            key = stage['key']
            call = counts[key]
            counts[key] += 1
            if stage['owned_launch'] not in selected:
                continue
            node = decode(lines[stage['owned_launch']])
            assert node['name'] == stage['symbol'] and node['owned_launch'] == stage['owned_launch']
            bindings, expected = [], {}
            for field, size in stage['fields'].items():
                argument = int(field)
                address = int.from_bytes(bytes.fromhex(node['parameter_hex'][argument]), 'little')
                assert address and size > 0
                paths = {phase_name: directory / f'dump_{key}_call{call:03d}_{phase_name}_arg{field}.bin'
                         for phase_name in ('pre', 'post')}
                for path in paths.values():
                    assert path.stat().st_size == size and sha(path) == hashes[str(path.resolve())]
                label = 'arg-' + field
                bindings.append({'label': label, 'argument': argument, 'offset': 0,
                                 'address': address, 'bytes': size, 'input': str(paths['pre'])})
                if field in stage['outputs']:
                    expected[label] = str(paths['post'])
            packets.append({'worker': requested['worker'], 'case': requested['case'],
                            'captured_backend': requested['backend'], 'key': key, 'call': call,
                            'node': node, 'bindings': bindings, 'expected': expected})
    assert len(packets) == wanted['planned_complete_input_packets'] == 1188
    verify(hashes)
    record = {**wanted, 'packets': packets, 'input_sha256': hashes, 'source_image': str(image),
              'diagnostic_process_intentionally_maps_SDK': True, 'GPU_used_during_preparation': False}
    (output / 'plan.json').write_text(json.dumps(record, indent=2) + '\n')
    print('Prepared1188 actual complete input packets;alias addresses and all captured bytes pinned', flush=True)


def execute(phase):
    from reconstruction import kernel_ab as k
    from .g1_contact_rhs_replay import kernel_texts
    from .host_api_probe import REFERENCE, REFERENCE_SHA, load_reference
    from .pcg_alias_replay import span_groups
    from .pcg_same_buffer_probe import Dim3

    output = phase / 'complete-input-replays'
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
    launch_runtime = runtime.cudaLaunchKernel
    launch_runtime.argtypes = [ct.c_void_p, Dim3, Dim3, ct.POINTER(ct.c_void_p), ct.c_size_t, ct.c_void_p]
    launch_runtime.restype = ct.c_int
    image = Path(plan['source_image'])
    assert sha(image) == plan['source_candidate_sha256']
    spec = importlib.util.spec_from_file_location('_source_solver', image)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    assert module.source_only and not module.solver_api_ready
    source = module._KernelDriver()
    functions = {}
    originals = {}
    for name in plan['kernel_names']:
        texts, original = kernel_texts(build, name)
        originals[str(original.resolve())] = sha(original)
        functions[name] = {'SDK-runtime': ct.cast(getattr(runtime, name), ct.c_void_p),
                           'SDK-ptx': driver.function(texts['original'], name),
                           'source-ptx': ct.c_void_p(source.function(name))}
    stream = ct.c_void_p()
    driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
    rows, calls, error = [], 0, None
    try:
        for number, packet in enumerate(plan['packets']):
            assert build_path.read_bytes() == build_bytes
            values = {binding['label']: Path(binding['input']).read_bytes() for binding in packet['bindings']}
            addresses = {binding['label']: binding['address'] for binding in packet['bindings']}
            expected = {label: Path(path).read_bytes() for label, path in packet['expected'].items()}
            groups = span_groups(addresses, values)
            pointers, allocations, metadata = {}, [], []
            for group in groups:
                prefix = 256 + group['start'] % 256
                initial = np.full(prefix + len(group['initial']) + 256, 211, dtype='u1')
                initial[prefix:prefix + len(group['initial'])] = group['initial']
                device = driver.upload(initial)
                assert device.value % 256 == 0
                mask = np.ones(len(initial), dtype=bool)
                for label in group['indices']:
                    offset = prefix + addresses[label] - group['start']
                    pointers[label] = device.value + offset
                    assert pointers[label] % 256 == addresses[label] % 256
                    if label in expected:
                        mask[offset:offset + len(values[label])] = False
                allocations.append((device, initial, mask))
                metadata.append({'start': group['start'], 'bytes': len(group['initial']), 'labels': group['indices'],
                                 'prefix': prefix, 'device_base': device.value})
            raw = [bytearray.fromhex(value) for value in packet['node']['parameter_hex']]
            for binding in packet['bindings']:
                argument = binding['argument']
                assert int.from_bytes(raw[argument], 'little') == binding['address']
                raw[argument] = bytearray(pointers[binding['label']].to_bytes(8, 'little'))
            parameters = [(ct.c_ubyte * len(value)).from_buffer_copy(value) for value in raw]
            holders = (ct.c_void_p * len(parameters))(*[ct.cast(ct.byref(value), ct.c_void_p) for value in parameters])
            arrays = {'actual-parameter-' + str(i): np.frombuffer(bytes(value), dtype='u1').copy()
                      for i, value in enumerate(parameters)}
            checks = []
            order = plan['backends'][number % 3:] + plan['backends'][:number % 3]
            for backend in order:
                for device, initial, _ in allocations:
                    driver.check(driver.cu.cuMemcpyHtoD_v2(device, ct.c_void_p(initial.ctypes.data), initial.nbytes))
                gx, gy, gz, bx, by, bz, shared = packet['node']['geometry']
                function = functions[packet['node']['name']][backend]
                if backend == 'SDK-runtime':
                    assert launch_runtime(function, Dim3(gx, gy, gz), Dim3(bx, by, bz), holders, shared, stream) == 0
                else:
                    driver.check(driver.cu.cuLaunchKernel(function, gx, gy, gz, bx, by, bz, shared, stream, holders, None))
                driver.check(driver.cu.cuStreamSynchronize(stream))
                calls += 1
                guards = True
                for index, (device, initial, mask) in enumerate(allocations):
                    after = driver.download(device, np.empty_like(initial))
                    arrays[backend + '-group-' + str(index)] = after.copy()
                    guards &= after[mask].tobytes() == initial[mask].tobytes()
                equal = {}
                for label, target in expected.items():
                    after = driver.download(ct.c_uint64(pointers[label]), np.zeros(len(target), dtype='u1'))
                    arrays[backend + '-output-' + label] = after.copy()
                    equal[label] = after.tobytes() == target
                checks.append({'backend': backend, 'complete_outputs_equal_to_capture': equal,
                               'all_complete_outputs_strict': all(equal.values()),
                               'readonly_and_guards_unchanged': bool(guards)})
                assert guards, (number, backend, 'Read-only/guard violation')
            target = output / 'packets' / f'{number:04d}-w{packet["worker"]}-{packet["key"]}-{packet["call"]:03d}.npz'
            np.savez_compressed(target, **arrays)
            rows.append({'number': number, 'worker': packet['worker'], 'key': packet['key'], 'call': packet['call'],
                         'checks': checks, 'groups': metadata, 'pointers': pointers,
                         'output': str(target), 'output_sha256': sha(target)})
            driver.free()
            if (number + 1) % 99 == 0:
                print('Complete actual self/PCG replay', number + 1, '/1188', flush=True)
        verify(plan['input_sha256'])
        verify(originals)
    except BaseException as problem:
        error = f'{type(problem).__name__}: {problem}'
        raise
    finally:
        report = {'packets': rows, 'actual_calls': calls, 'error': error,
                  'execution_complete': len(rows) == 1188 and calls == 3564 and error is None,
                  'strict_packets': sum(all(check['all_complete_outputs_strict'] for check in row['checks'])
                                        for row in rows),
                  'all_readonly_and_guards_unchanged': all(check['readonly_and_guards_unchanged']
                                                         for row in rows for check in row['checks']),
                  'original_PTX_input_sha256': originals, 'diagnostic_process_intentionally_maps_SDK': True,
                  'raw_contact_records_not_sorted': True, 'fixed_failures_reclassified': False,
                  'candidate_promoted': False, 'production_changed': False, 'whole_solver_complete': False}
        (output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
        driver.free()
        driver.check(driver.cu.cuStreamDestroy_v2(stream))
    print('Execution complete;strict packets', report['strict_packets'], '/1188;numeric differences remain recorded',
          flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--phase', type=Path, required=True)
    parser.add_argument('--mode', choices=('request', 'prepare', 'run'), required=True)
    args = parser.parse_args()
    phase = args.phase.resolve(strict=True)
    {'request': request, 'prepare': prepare, 'run': execute}[args.mode](phase)


if __name__ == '__main__':
    main()
