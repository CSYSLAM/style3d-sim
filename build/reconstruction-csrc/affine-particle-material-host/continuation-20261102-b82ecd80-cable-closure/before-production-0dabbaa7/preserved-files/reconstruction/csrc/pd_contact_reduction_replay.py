"""Audit every remaining PD reduction difference with actual operands, SDK isolation and joint GPU witnesses."""
import argparse
import ctypes as ct
import hashlib
import importlib.util
import json
from pathlib import Path

import numpy as np

from .demo_source_ab import ROOT


JOINT_PTX = r'''.version 8.4
.target sm_52
.address_size 64
.visible .entry audit_joint_atomic(
 .param .u64 values, .param .u64 order, .param .u64 groups,
 .param .u64 total, .param .u64 history, .param .u32 count) {
 .reg .pred %p; .reg .b32 %r<5>; .reg .b64 %d<15>; .reg .f32 %f<2>;
 ld.param.u64 %d0, [values]; ld.param.u64 %d1, [order]; ld.param.u64 %d2, [groups];
 ld.param.u64 %d3, [total]; ld.param.u64 %d4, [history]; ld.param.u32 %r0, [count];
 mov.u32 %r1, 0;
LOOP:
 mul.wide.u32 %d5, %r1, 4; add.u64 %d6, %d1, %d5; ld.global.u32 %r2, [%d6];
 mul.wide.u32 %d7, %r2, 4; add.u64 %d8, %d0, %d7; ld.global.f32 %f0, [%d8];
 add.u64 %d9, %d2, %d7; ld.global.u32 %r3, [%d9]; mul.wide.u32 %d10, %r3, 4;
 add.u64 %d11, %d3, %d10; atom.global.add.f32 %f1, [%d11], %f0;
 add.u64 %d12, %d4, %d5; st.global.f32 [%d12], %f1; membar.gl;
 add.u32 %r1, %r1, 1; setp.lt.u32 %p, %r1, %r0; @%p bra LOOP; ret;
}
'''


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def verify(hashes):
    for name, expected in hashes.items():
        assert sha(Path(name)) == expected, name


def prepare(phase):
    from .g1_contact_rhs_replay import kernel_texts
    from .ptx_atomic_literal_probe import instrument

    folder = phase / 'remaining-input-replays'
    report = json.loads((folder / 'report.json').read_text())
    plan = json.loads((folder / 'plan.json').read_text())
    audit_path = phase / 'remaining-independent-cpu-audit.json'
    audit = json.loads(audit_path.read_text())
    assert report['complete'] and report['actual_calls'] == audit['counts']['actual_calls'] == 3888
    assert report['strict_packets'] == audit['strict_packets'] == 1165
    assert report['all_unwritten_and_guards_equal']
    cases = []
    for packet, row in zip(plan['packets'], report['packets']):
        if all(check['all_complete_outputs_strict'] for check in row['checks']):
            continue
        kind = row['kind']
        assert kind in ('CG-product', 'CG-precondition')
        counter, world, point = (9, 7, 6) if kind == 'CG-product' else (6, 4, 2)
        label, point_label = 'arg-' + str(counter), 'arg-' + str(point)
        assert set(packet['stage']['outputs']) == {label, point_label}
        for check in row['checks']:
            assert check['complete_output_equal_to_capture'][point_label]
        cases.append({'packet': packet, 'replay': row, 'counter': counter, 'world': world, 'point': point})
    assert len(cases) == 131 and len(audit['failures']) == 382
    metadata = phase.parent / 'continuation-20261101-0dabbaa7-granular-affine-contacts/candidate-guard-only/build.json'
    candidate = json.loads(metadata.read_text())
    image = Path(candidate['image'])
    assert sha(image) == candidate['image_sha256'] == '4f638b4b9141e6ad6e2aabfb6533f8ed23bdfedbf7c1508063ea96bdb7e09326'
    build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    build = json.loads(build_path.read_text())
    output = phase / 'reduction-differences'
    output.mkdir(exist_ok=False)
    hashes = dict(audit['input_sha256'])
    hashes.update({str(p): sha(p) for p in (Path(__file__), audit_path, metadata, image, build_path,
                                          ROOT / 'build/reconstruction-csrc/host-particles/source_ptx_bundle.h')})
    names = {case['packet']['stage']['node']['name'] for case in cases}
    probes = {}
    assert len(names) == 2
    for index, name in enumerate(sorted(names)):
        texts, original = kernel_texts(build, name)
        hashes[str(original)] = sha(original)
        probes[name] = {}
        for side, text in texts.items():
            changed, sites = instrument(text, name)
            assert sites == 1
            path = output / f'probe-{index}-{side}.ptx'
            path.write_text(changed)
            hashes[str(path)] = sha(path)
            probes[name][side] = str(path)
    record = {'cases': cases, 'probes': probes, 'candidate_image': str(image), 'candidate_sha256': sha(image),
              'input_sha256': hashes, 'search_limit': 10000,
              'selection': 'Every131 reported scalar-reduction difference;all original and replay targets retained',
              'cohort_expanded': False, 'production_changed': False, 'whole_solver_complete': False}
    verify(hashes)
    (output / 'plan.json').write_text(json.dumps(record, indent=2) + '\n')
    print('Prepared131 reduction-difference inputs;two kernels;all captured/replayed scalar vectors retained', flush=True)


def execute(phase):
    from reconstruction import kernel_ab as k
    from .g1_contact_rhs_replay import kernel_texts
    from .host_api_probe import REFERENCE, REFERENCE_SHA, load_reference
    from .pcg_same_buffer_probe import Dim3
    from .pd_contact_first_cg_replay import ROW_ATOMIC

    output = phase / 'reduction-differences'
    plan = json.loads((output / 'plan.json').read_text())
    verify(plan['input_sha256'])
    assert sha(REFERENCE) == REFERENCE_SHA
    driver = k.Driver()
    load_reference()
    runtime = ct.CDLL(str(REFERENCE))
    runtime_launch = runtime.cudaLaunchKernel
    runtime_launch.argtypes = [ct.c_void_p, Dim3, Dim3, ct.POINTER(ct.c_void_p), ct.c_size_t, ct.c_void_p]
    runtime_launch.restype = ct.c_int
    image = Path(plan['candidate_image'])
    assert sha(image) == plan['candidate_sha256']
    spec = importlib.util.spec_from_file_location('_source_solver', image)
    source = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(source)
    assert source.source_only and not source.solver_api_ready
    native = source._KernelDriver()
    build = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
    functions, probes = {}, {}
    for name, paths in plan['probes'].items():
        texts, _ = kernel_texts(build, name)
        functions[name] = {'SDK-runtime': ct.cast(getattr(runtime, name), ct.c_void_p),
                           'original-ptx': driver.function(texts['original'], name),
                           'source-ptx': ct.c_void_p(native.function(name))}
        probes[name] = {side: driver.function(Path(path).read_text(), name) for side, path in paths.items()}
    joint, row_atomic = driver.function(JOINT_PTX, 'audit_joint_atomic'), driver.function(ROW_ATOMIC, 'audit_atomic_rows')
    (output / 'joint-atomic.ptx').write_text(JOINT_PTX)
    (output / 'row-atomic.ptx').write_text(ROW_ATOMIC)
    stream = ct.c_void_p()
    driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
    rows, calls, error = [], 0, None

    def reset(pointer, array):
        driver.check(driver.cu.cuMemcpyHtoD_v2(pointer, ct.c_void_p(array.ctypes.data), array.nbytes))

    def launch(function, params, geometry, runtime_call=False):
        nonlocal calls
        holders = (ct.c_void_p * len(params))(*[ct.cast(ct.byref(v), ct.c_void_p) for v in params])
        gx, gy, gz, bx, by, bz, shared = geometry
        if runtime_call:
            assert runtime_launch(function, Dim3(gx, gy, gz), Dim3(bx, by, bz), holders, shared, stream) == 0
        else:
            driver.check(driver.cu.cuLaunchKernel(function, gx, gy, gz, bx, by, bz, shared, stream, holders, None))
        driver.check(driver.cu.cuStreamSynchronize(stream))
        calls += 1

    def ftz(value):
        return np.copysign(np.float32(0), value) if 0 < abs(value) < np.finfo('f4').tiny else value

    try:
        for case_index, case in enumerate(plan['cases']):
            packet, row = case['packet'], case['replay']
            stage, node = packet['stage'], packet['stage']['node']
            counter, world, point = case['counter'], case['world'], case['point']
            assert node['geometry'] == [1, 1, 1, 256, 1, 1, 0]
            with np.load(packet['input'], allow_pickle=False) as saved:
                before = {b['argument']: saved[stage['key'] + '/before/' + b['label']].copy() for b in stage['bindings']}
                expected_point = saved[stage['key'] + '/after/arg-' + str(point)].tobytes()
                captured = saved[stage['key'] + '/after/arg-' + str(counter)].copy()
            assert len(before[counter]) == 12 and not before[counter].any()
            arrays, target_map = {'captured-counter': captured.copy()}, {captured.tobytes(): ['captured']}
            with np.load(row['output'], allow_pickle=False) as saved:
                for backend in functions[node['name']]:
                    value = saved[backend + '-output-arg-' + str(counter)].copy()
                    arrays[backend + '-replayed-counter'] = value
                    target_map.setdefault(value.tobytes(), []).append(backend)
            raw = [bytearray.fromhex(v) for v in node['parameter_hex']]
            addresses = {b['argument']: b['address'] for b in stage['bindings']}
            assert int.from_bytes(raw[world], 'little') == 0
            assert int.from_bytes(raw[world + 1], 'little') == 12
            for a in before:
                for b in before:
                    if a < b:
                        assert min(addresses[a] + len(before[a]), addresses[b] + len(before[b])) <= max(
                            addresses[a], addresses[b])
            spans, pointers, metadata = {}, {}, {}
            for index, data in before.items():
                prefix = 256 + addresses[index] % 256
                padded = np.full(prefix + len(data) + 256, 211, dtype='u1')
                padded[prefix:prefix + len(data)] = data
                device = driver.upload(padded)
                assert device.value % 256 == 0
                spans[index], pointers[index] = (device, padded, prefix), device.value + prefix
                metadata[index] = {'base': device.value, 'prefix': prefix, 'bytes': len(data)}
            map_value = np.arange(36, dtype='<i4')
            map_pointer = driver.upload(map_value)
            prefix = 256 + addresses[counter] % 256
            controlled_zero = np.full(prefix + 144 + 256, 211, dtype='u1')
            controlled_zero[prefix:prefix + 144] = 0
            controlled = driver.upload(controlled_zero)
            arrays['controlled-map-input'] = map_value.copy()

            def run(tag, function, isolated=False, extra=(), runtime_call=False):
                for device, padded, _ in spans.values():
                    reset(device, padded)
                actual = [bytearray(v) for v in raw]
                for index, pointer in pointers.items():
                    actual[index][:] = pointer.to_bytes(8, 'little')
                if isolated:
                    reset(controlled, controlled_zero)
                    actual[world][:] = map_pointer.value.to_bytes(8, 'little')
                    actual[counter][:] = (controlled.value + prefix).to_bytes(8, 'little')
                params = [(ct.c_ubyte * len(v)).from_buffer_copy(v) for v in actual]
                arrays.update({tag + '-parameter-' + str(i): np.frombuffer(bytes(v), dtype='u1').copy()
                               for i, v in enumerate(params)})
                launch(function, [*params, *extra], node['geometry'], runtime_call)
                for index, (device, padded, offset) in spans.items():
                    after = driver.download(device, np.empty_like(padded))
                    arrays[tag + '-buffer-' + str(index)] = after.copy()
                    mask = np.ones(len(after), dtype=bool)
                    if index == point or (index == counter and not isolated):
                        mask[offset:offset + len(before[index])] = False
                    assert after[mask].tobytes() == padded[mask].tobytes(), (case_index, tag, index, 'RO/guard changed')
                point_after = arrays[tag + '-buffer-' + str(point)]
                offset = spans[point][2]
                assert point_after[offset:offset + len(expected_point)].tobytes() == expected_point
                if isolated:
                    after = driver.download(controlled, np.empty_like(controlled_zero))
                    assert after[:prefix].tobytes() == controlled_zero[:prefix].tobytes()
                    assert after[prefix + 144:].tobytes() == controlled_zero[prefix + 144:].tobytes()
                    arrays[tag + '-controlled-buffer'] = after.copy()
                    readback = driver.download(map_pointer, np.empty_like(map_value))
                    arrays[tag + '-controlled-map-readback'] = readback.copy()
                    assert readback.tobytes() == map_value.tobytes()
                    return after[prefix:prefix + 144].copy()

            trace_zero, count_zero = np.zeros((256, 128, 16), dtype='u1'), np.zeros(256, dtype='<u4')
            trace, counts = driver.upload(trace_zero), driver.upload(count_zero)
            operands = []
            for side, function in probes[node['name']].items():
                reset(trace, trace_zero)
                reset(counts, count_zero)
                run(side + '-probe', function, extra=(trace, counts))
                sizes = driver.download(counts, np.empty_like(count_zero))
                records = driver.download(trace, np.empty_like(trace_zero))
                assert np.all(sizes[:36] == 1) and not sizes[36:].any()
                target_addresses = records[:36, 0, :8].copy().view('<u8').reshape(-1)
                assert np.array_equal(target_addresses, pointers[counter] + (np.arange(36, dtype='<u8') // 12) * 4)
                value = records[:36, 0, 8:12].copy().view('<f4').reshape(-1)
                assert np.isfinite(value).all()
                arrays[side + '-raw-trace'], arrays[side + '-trace-counts'] = records.copy(), sizes.copy()
                arrays[side + '-raw-operands'] = value.copy()
                operands.append(value.copy())
            assert operands[0].tobytes() == operands[1].tobytes(), ('Raw operands differ', case_index)
            values = operands[0]
            value_pointer = driver.upload(values)
            reset(controlled, controlled_zero)
            launch(row_atomic, [value_pointer, ct.c_uint64(controlled.value + prefix), ct.c_uint(36)], node['geometry'])
            effective = driver.download(controlled, np.empty_like(controlled_zero))
            assert effective[:prefix].tobytes() == controlled_zero[:prefix].tobytes()
            assert effective[prefix + 144:].tobytes() == controlled_zero[prefix + 144:].tobytes()
            arrays['effective-row-buffer'] = effective.copy()
            for backend, function in functions[node['name']].items():
                actual = run(backend + '-isolated', function, isolated=True, runtime_call=backend == 'SDK-runtime')
                assert actual.tobytes() == effective[prefix:prefix + 144].tobytes(), ('Isolated operands differ', backend)
            groups = np.arange(36, dtype='<u4') // 12
            group_pointer = driver.upload(groups)
            certificates = []
            for target_index, (target, origins) in enumerate(target_map.items()):
                wanted = np.frombuffer(target, dtype='<u4')
                order, history = [], []
                normalized = np.asarray([ftz(value) for value in values], dtype='<f4')
                for group in range(3):
                    seed = f'{row["number"]}/{target.hex()}/{group}'
                    rng = np.random.default_rng(int(hashlib.sha256(seed.encode()).hexdigest()[:16], 16))
                    found = None
                    for trial in range(plan['search_limit']):
                        proposed = np.arange(12) if trial == 0 else rng.permutation(12)
                        total, previous = np.float32(0), []
                        for lane in proposed:
                            previous.append(total)
                            total = ftz(np.float32(total + normalized[group * 12 + lane]))
                        if int(total.view('<u4')) == int(wanted[group]):
                            found = proposed + group * 12, previous
                            break
                    assert found is not None, ('No GPU-fold proposal found', row['number'], origins, group)
                    order.extend(found[0])
                    history.extend(found[1])
                sequence = np.asarray(order, dtype='<u4')
                assert sorted(sequence.tolist()) == list(range(36))
                history_expected = np.asarray(history, dtype='<f4')
                sequence_pointer = driver.upload(sequence)
                total_zero, history_zero = np.full(524, 211, dtype='u1'), np.full(656, 211, dtype='u1')
                total_zero[256:268], history_zero[256:400] = 0, 0
                total_device, history_device = driver.upload(total_zero), driver.upload(history_zero)
                params = [value_pointer, sequence_pointer, group_pointer, ct.c_uint64(total_device.value + 256),
                          ct.c_uint64(history_device.value + 256), ct.c_uint(36)]
                launch(joint, params, [1, 1, 1, 1, 1, 1, 0])
                total_after = driver.download(total_device, np.empty_like(total_zero))
                history_after = driver.download(history_device, np.empty_like(history_zero))
                assert total_after[256:268].tobytes() == target
                assert history_after[256:400].tobytes() == history_expected.tobytes()
                for after, zero, end in ((total_after, total_zero, 268), (history_after, history_zero, 400)):
                    assert after[:256].tobytes() == zero[:256].tobytes() and after[end:].tobytes() == zero[end:].tobytes()
                tag = 'joint-' + str(target_index)
                arrays[tag + '-order'] = driver.download(sequence_pointer, np.empty_like(sequence))
                arrays[tag + '-groups'] = driver.download(group_pointer, np.empty_like(groups))
                arrays[tag + '-operands'] = driver.download(value_pointer, np.empty_like(values))
                assert arrays[tag + '-order'].tobytes() == sequence.tobytes()
                assert arrays[tag + '-groups'].tobytes() == groups.tobytes()
                assert arrays[tag + '-operands'].tobytes() == values.tobytes()
                arrays[tag + '-total-buffer'], arrays[tag + '-history-buffer'] = total_after.copy(), history_after.copy()
                arrays.update({tag + '-parameter-' + str(i): np.frombuffer(bytes(v), dtype='u1').copy()
                               for i, v in enumerate(params)})
                certificates.append({'tag': tag, 'target_bits': wanted.tolist(), 'origins': origins,
                                     'joint_three_group_GPU_atomic_witness': True, 'actual_global_schedule_inferred': False})
            path = output / f'case-{case_index:03d}-packet-{row["number"]:04d}.npz'
            np.savez_compressed(path, **arrays)
            rows.append({'case_index': case_index, 'packet_number': row['number'], 'kind': row['kind'],
                         'output': str(path), 'output_sha256': sha(path), 'buffer_metadata': metadata,
                         'pointers': pointers, 'controlled_base': controlled.value, 'controlled_prefix': prefix,
                         'controlled_map_pointer': map_pointer.value, 'certificates': certificates,
                         'equal_raw_original_source_operands': True, 'equal_isolated_three_backend_contributions': True})
            driver.free()
            if case_index % 16 == 0:
                print('Reduction differences certified', case_index + 1, '/131', flush=True)
        verify(plan['input_sha256'])
    except BaseException as problem:
        error = f'{type(problem).__name__}: {problem}'
        raise
    finally:
        report = {'cases': rows, 'actual_calls': calls, 'error': error, 'complete': len(rows) == 131 and error is None,
                  'actual_global_schedule_inferred': False, 'cohort_expanded': False,
                  'original_fixed_failure_reclassified': False, 'production_changed': False, 'whole_solver_complete': False}
        (output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
        driver.free()
        driver.check(driver.cu.cuStreamDestroy_v2(stream))
    assert report['complete']
    print('All131 reduction differences certified;actual calls', calls, flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--phase', type=Path, required=True)
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument('--prepare', action='store_true')
    mode.add_argument('--execute', action='store_true')
    args = parser.parse_args()
    (prepare if args.prepare else execute)(args.phase.resolve())


if __name__ == '__main__':
    main()
