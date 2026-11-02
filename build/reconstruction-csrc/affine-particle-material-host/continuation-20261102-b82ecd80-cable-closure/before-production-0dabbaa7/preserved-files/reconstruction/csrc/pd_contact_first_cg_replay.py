"""Certify the three first observed PD denominator differences with actual SDK calls and hardware F32 atomics."""
import argparse
import ctypes as ct
import hashlib
import importlib.util
import json
from pathlib import Path

import numpy as np

from .demo_source_ab import ROOT


ROW_ATOMIC = r'''.version 7.2
.target sm_52
.address_size 64
.visible .entry audit_atomic_rows(.param .u64 input, .param .u64 output, .param .u32 count) {
 .reg .pred %p; .reg .b32 %r<4>; .reg .b64 %d<6>; .reg .f32 %f;
 ld.param.u64 %d0, [input]; ld.param.u64 %d1, [output]; ld.param.u32 %r0, [count];
 mov.u32 %r1, %tid.x; mov.u32 %r2, %ctaid.x; mov.u32 %r3, %ntid.x;
 mad.lo.u32 %r1, %r2, %r3, %r1; setp.ge.u32 %p, %r1, %r0; @%p ret;
 mul.wide.u32 %d2, %r1, 4; add.u64 %d3, %d0, %d2; add.u64 %d4, %d1, %d2;
 ld.global.f32 %f, [%d3]; red.global.add.f32 [%d4], %f; ret;
}
'''


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def verify(hashes):
    for path, expected in hashes.items():
        assert sha(Path(path)) == expected, path


def prepare(phase):
    from .g1_contact_rhs_replay import kernel_texts
    from .ptx_atomic_literal_probe import instrument

    audit_path = phase / 'rhs-independent-cpu-audit.json'
    audit = json.loads(audit_path.read_text())
    hashes = dict(audit['input_sha256'])
    hashes[str(audit_path)] = sha(audit_path)
    hashes[str(Path(__file__))] = sha(Path(__file__))
    build = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
    metadata_path = phase.parent / 'continuation-20261101-0dabbaa7-granular-affine-contacts/candidate-guard-only/build.json'
    candidate = json.loads(metadata_path.read_text())
    image = Path(candidate['image'])
    hashes.update({str(p): sha(p) for p in (metadata_path, image)})
    assert sha(image) == candidate['image_sha256'] == '4f638b4b9141e6ad6e2aabfb6533f8ed23bdfedbf7c1508063ea96bdb7e09326'
    output = phase / 'first-CG-replay'
    output.mkdir(exist_ok=False)
    cases = []
    for row in audit['comparisons']:
        first, worker = row['first_numeric_output_difference'], row['source_worker']
        assert first['kind'] == 'CG-product' and first['label'] == 'arg-9'
        assert first['before_differing_observed_labels'] == [] and first['all_flat_inputs_captured']
        frame, graph, key = first['frame'], first['frame'] % 2, first['stage']
        folders = [phase / f'rhs-captures-v2/{w}/rhs-graph-{graph}' for w in (0, worker)]
        layouts = [json.loads((folder / 'snapshot-layout.json').read_text()) for folder in folders]
        stages = [next(s for s in layout['stages'] if s['key'] == key) for layout in layouts]
        paths = [folder / f'frames/frame-{frame:02d}.npz' for folder in folders]
        arrays = {}
        for side, path, stage in zip(('SDK', 'source'), paths, stages):
            with np.load(path, allow_pickle=False) as data:
                for binding in stage['bindings']:
                    label = binding['label']
                    arrays[side + '-before-' + label] = data[key + '/before/' + label].copy()
                for label in stage['outputs']:
                    arrays[side + '-after-' + label] = data[key + '/after/' + label].copy()
        for binding in stages[0]['bindings']:
            label = binding['label']
            assert arrays['SDK-before-' + label].tobytes() == arrays['source-before-' + label].tobytes()
        assert not arrays['SDK-before-arg-9'].any()
        assert arrays['SDK-after-arg-6'].tobytes() == arrays['source-after-arg-6'].tobytes()
        assert arrays['SDK-after-arg-9'].tobytes() != arrays['source-after-arg-9'].tobytes()
        packet_path = output / f'case-{worker}-input.npz'
        np.savez_compressed(packet_path, **arrays)
        hashes[str(packet_path)] = sha(packet_path)
        cases.append({'source_worker': worker, 'frame': frame, 'stage': key, 'actual_stages': stages,
                      'input_packet': str(packet_path)})
    names = {case['actual_stages'][0]['node']['name'] for case in cases}
    assert len(cases) == 3 and len(names) == 1
    name = names.pop()
    texts, original = kernel_texts(build, name)
    hashes[str(original)] = sha(original)
    probes = {}
    for side, text in texts.items():
        changed, sites = instrument(text, name)
        assert sites == 1
        path = output / (side + '-probe.ptx')
        path.write_text(changed)
        hashes[str(path)] = sha(path)
        probes[side] = str(path)
    plan = {'input_sha256': hashes, 'cases': cases, 'kernel': name, 'probes': probes,
            'candidate_image': str(image), 'candidate_sha256': sha(image), 'unmodified_trials_per_backend': 4,
            'permutation_search_trials': 10000, 'runtime_isolation_changes_only_coefficient_address_map': True,
            'controlled_isolation_not_independent_source_trajectory': True, 'original_fixed_failure_replaced': False,
            'cohort_expanded': False, 'production_changed': False, 'whole_solver_complete': False}
    (output / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
    print('Prepared3 first differences:all seven complete before spans and Ap are byte-identical', flush=True)


def execute(phase):
    from reconstruction import kernel_ab as k
    from .g1_contact_rhs_replay import kernel_texts
    from .host_api_probe import REFERENCE, REFERENCE_SHA, load_reference
    from .particle_reduction_certificates import SERIAL_PTX
    from .pcg_same_buffer_probe import Dim3

    output = phase / 'first-CG-replay'
    plan = json.loads((output / 'plan.json').read_text())
    verify(plan['input_sha256'])
    assert sha(REFERENCE) == REFERENCE_SHA
    build = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
    texts, _ = kernel_texts(build, plan['kernel'])
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
    functions = {'original-runtime': ct.cast(getattr(runtime, plan['kernel']), ct.c_void_p),
                 'original-ptx': driver.function(texts['original'], plan['kernel']),
                 'source-ptx': ct.c_void_p(source.function(plan['kernel']))}
    probes = {side: driver.function(Path(path).read_text(), plan['kernel']) for side, path in plan['probes'].items()}
    serial = driver.function(SERIAL_PTX, 'audit_serial_atomic')
    atomic_rows = driver.function(ROW_ATOMIC, 'audit_atomic_rows')
    (output / 'serial-atomic.ptx').write_text(SERIAL_PTX)
    (output / 'row-atomic.ptx').write_text(ROW_ATOMIC)
    stream = ct.c_void_p()
    driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
    rows, actual_calls, error = [], 0, None

    def reset(pointer, value):
        driver.check(driver.cu.cuMemcpyHtoD_v2(pointer, ct.c_void_p(value.ctypes.data), value.nbytes))

    def launch(function, parameters, geometry, is_runtime=False):
        nonlocal actual_calls
        holders = (ct.c_void_p * len(parameters))(*[ct.cast(ct.byref(v), ct.c_void_p) for v in parameters])
        gx, gy, gz, bx, by, bz, shared = geometry
        if is_runtime:
            assert runtime_launch(function, Dim3(gx, gy, gz), Dim3(bx, by, bz), holders, shared, stream) == 0
        else:
            driver.check(driver.cu.cuLaunchKernel(function, gx, gy, gz, bx, by, bz, shared, stream, holders, None))
        driver.check(driver.cu.cuStreamSynchronize(stream))
        actual_calls += 1

    try:
        for case in plan['cases']:
            node, bindings = case['actual_stages'][0]['node'], case['actual_stages'][0]['bindings']
            assert node['geometry'] == [1, 1, 1, 256, 1, 1, 0]
            with np.load(case['input_packet'], allow_pickle=False) as packet:
                payload = {b['argument']: packet['SDK-before-' + b['label']].copy() for b in bindings}
                expected_ap = packet['SDK-after-arg-6'].tobytes()
                targets = {side: packet[side + '-after-arg-9'].copy() for side in ('SDK', 'source')}
            values = [int.from_bytes(bytes.fromhex(v), 'little') for v in node['parameter_hex']]
            assert [values[i] for i in (2, 7, 8, 10, 11)] == [2, 0, 12, 36, 36]
            for a in payload:
                for b in payload:
                    if a < b:
                        assert min(values[a] + len(payload[a]), values[b] + len(payload[b])) <= max(values[a], values[b])
            initial, devices, pointers, padding = {}, {}, {}, {}
            for i, value in payload.items():
                prefix = 256 + values[i] % 256
                data = np.full(prefix + len(value) + 256, 211, dtype='u1')
                data[prefix:prefix + len(value)] = value
                devices[i] = driver.upload(data)
                assert devices[i].value % 256 == 0
                initial[i], pointers[i], padding[i] = data, devices[i].value + prefix, prefix
                assert pointers[i] % 256 == values[i] % 256
            arrays, checks = {}, []
            mapping = np.arange(36, dtype='<i4')
            map_pointer = driver.upload(mapping)
            counter_initial = np.full(36 * 4 + 512, 211, dtype='u1')
            counter_initial[256:-256] = 0
            counter = driver.upload(counter_initial)
            controlled_counter = counter.value + 256

            def run(tag, function, is_runtime=False, extra=(), isolated=False):
                for i, data in initial.items():
                    reset(devices[i], data)
                if isolated:
                    reset(counter, counter_initial)
                raw = [bytearray.fromhex(v) for v in node['parameter_hex']]
                for i, pointer in pointers.items():
                    raw[i][:] = pointer.to_bytes(8, 'little')
                if isolated:
                    raw[7][:] = map_pointer.value.to_bytes(8, 'little')
                    raw[9][:] = controlled_counter.to_bytes(8, 'little')
                parameters = [(ct.c_ubyte * len(v)).from_buffer_copy(v) for v in raw]
                arrays.update({tag + '-parameter-' + str(i): np.frombuffer(bytes(v), dtype='u1').copy()
                               for i, v in enumerate(parameters)})
                launch(function, [*parameters, *extra], node['geometry'], is_runtime)
                for i, before in initial.items():
                    after = driver.download(devices[i], np.empty_like(before))
                    arrays[tag + '-buffer-' + str(i)] = after.copy()
                    mask = np.ones(len(before), dtype=bool)
                    if i == 6 or (i == 9 and not isolated):
                        mask[padding[i]:padding[i] + len(payload[i])] = False
                    assert after[mask].tobytes() == before[mask].tobytes(), ('Unwritten/guard changed', tag, i)
                product = arrays[tag + '-buffer-6'][padding[6]:padding[6] + 432].copy()
                assert product.tobytes() == expected_ap, ('Pointwise Ap mismatch', tag)
                if isolated:
                    after = driver.download(counter, np.empty_like(counter_initial))
                    assert after[:256].tobytes() == counter_initial[:256].tobytes()
                    assert after[-256:].tobytes() == counter_initial[-256:].tobytes()
                    assert driver.download(map_pointer, np.empty_like(mapping)).tobytes() == mapping.tobytes()
                    arrays[tag + '-controlled-counter-buffer'] = after.copy()
                    return after[256:-256].copy()
                total = arrays[tag + '-buffer-9'][padding[9]:padding[9] + 12].copy()
                checks.append({'tag': tag, 'pointwise_Ap_strict': True, 'counter_bits': total.view('<u4').tolist(),
                               'same_as_captured_SDK': total.tobytes() == targets['SDK'].tobytes(),
                               'same_as_captured_source': total.tobytes() == targets['source'].tobytes(),
                               'all_unwritten_and_guards_equal': True})
                return total

            order = list(functions)
            for trial in range(plan['unmodified_trials_per_backend']):
                rotation = trial % 3
                for backend in order[rotation:] + order[:rotation]:
                    run(backend + '-trial-' + str(trial), functions[backend], backend == 'original-runtime')
            lane_values = []
            trace_zero, count_zero = np.zeros((256, 128, 16), dtype='u1'), np.zeros(256, dtype='<u4')
            trace, counts = driver.upload(trace_zero), driver.upload(count_zero)
            for side, function in probes.items():
                reset(trace, trace_zero)
                reset(counts, count_zero)
                run(side + '-probe', function, extra=(trace, counts))
                sizes = driver.download(counts, np.empty_like(count_zero))
                records = driver.download(trace, np.empty_like(trace_zero))
                assert np.all(sizes[:36] == 1) and not sizes[36:].any()
                addresses = records[:36, 0, :8].copy().view('<u8').reshape(-1)
                operands = records[:36, 0, 8:12].copy().view('<f4').reshape(-1)
                assert np.array_equal(addresses, pointers[9] + (np.arange(36, dtype='<u8') // 12) * 4)
                assert np.isfinite(operands).all()
                arrays[side + '-trace'], arrays[side + '-counts'] = records.copy(), sizes.copy()
                arrays[side + '-operands'] = operands.copy()
                lane_values.append(operands.copy())
            assert lane_values[0].tobytes() == lane_values[1].tobytes()
            operand_pointer = driver.upload(lane_values[0])
            reset(counter, counter_initial)
            launch(atomic_rows, [operand_pointer, ct.c_uint64(controlled_counter), ct.c_uint(36)], [1, 1, 1, 256, 1, 1, 0])
            effective_buffer = driver.download(counter, np.empty_like(counter_initial))
            assert effective_buffer[:256].tobytes() == counter_initial[:256].tobytes()
            assert effective_buffer[-256:].tobytes() == counter_initial[-256:].tobytes()
            effective = effective_buffer[256:-256].copy()
            arrays['effective-hardware-atomic-buffer'] = effective_buffer.copy()
            for backend, function in functions.items():
                isolated = run(backend + '-isolated', function, backend == 'original-runtime', isolated=True)
                assert isolated.tobytes() == effective.tobytes(), ('Runtime isolated contribution mismatch', backend)
            certificates = []
            tiny = np.finfo('f4').tiny

            def ftz(value):
                return np.copysign(np.float32(0), value) if 0 < abs(value) < tiny else value

            for side, target in targets.items():
                for group, target_word in enumerate(target.view('<u4')):
                    data = lane_values[0][group * 12:(group + 1) * 12].copy()
                    normalized = np.asarray([ftz(v) for v in data], dtype='<f4')
                    seed = f'{case["source_worker"]}/{side}/{group}/{int(target_word)}'
                    rng = np.random.default_rng(int(hashlib.sha256(seed.encode()).hexdigest()[:16], 16))
                    found = None
                    for attempt in range(plan['permutation_search_trials']):
                        proposed = np.arange(12) if attempt == 0 else rng.permutation(12)
                        history, total = [], np.float32(0)
                        for lane in proposed:
                            history.append(total)
                            total = ftz(np.float32(total + normalized[lane]))
                        if int(total.view('<u4')) == int(target_word):
                            found = proposed.astype('<u4'), np.asarray(history, dtype='<f4')
                            break
                    assert found is not None, ('No F32 fold witness', side, group, int(target_word))
                    sequence, history = found
                    zero, history_zero = np.zeros(1, dtype='<f4'), np.zeros(12, dtype='<f4')
                    gpu = [driver.upload(v) for v in (data, sequence, zero, history_zero)]
                    launch(serial, [*gpu, ct.c_uint(12)], [1, 1, 1, 1, 1, 1, 0])
                    total = driver.download(gpu[2], np.empty_like(zero))
                    actual_history = driver.download(gpu[3], np.empty_like(history_zero))
                    assert int(total.view('<u4')[0]) == int(target_word)
                    assert actual_history.tobytes() == history.tobytes()
                    tag = side + '-group-' + str(group)
                    arrays[tag + '-fold-operands'], arrays[tag + '-fold-order'] = data.copy(), sequence.copy()
                    arrays[tag + '-fold-total'], arrays[tag + '-fold-history'] = total.copy(), actual_history.copy()
                    certificates.append({'side': side, 'group': group, 'target_bits': int(target_word),
                                         'search_attempts': attempt + 1, 'real_GPU_atomic_witness_passed': True,
                                         'actual_global_schedule_inferred': False})
            path = output / f'case-{case["source_worker"]}-outputs.npz'
            np.savez_compressed(path, **arrays)
            rows.append({'source_worker': case['source_worker'], 'frame': case['frame'], 'stage': case['stage'],
                         'checks': checks, 'certificates': certificates, 'actual_output_packet': str(path),
                         'actual_output_sha256': sha(path), 'real_per_lane_raw_operands_equal': True,
                         'actual_SDK_runtime_isolated_effective_contributions_equal': True,
                         'base_pointers': {str(i): v.value for i, v in devices.items()}, 'padding': padding,
                         'unmodified_replay_pointers': pointers, 'controlled_world_pointer': map_pointer.value,
                         'controlled_counter_base': counter.value, 'controlled_counter_pointer': controlled_counter})
            print('FirstCG source', case['source_worker'], 'SDK/PTX/source Ap strict;36 operands same;6 GPU folds pass',
                  flush=True)
            driver.free()
        verify(plan['input_sha256'])
    except BaseException as problem:
        error = f'{type(problem).__name__}: {problem}'
        raise
    finally:
        report = {'cases': rows, 'error': error, 'complete': len(rows) == 3 and error is None,
                  'actual_calls': actual_calls, 'controlled_counter_address_mapping_is_diagnostic_only': True,
                  'original_fixed_failure_reclassified': False, 'production_changed': False, 'whole_solver_complete': False}
        (output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
        driver.free()
        driver.check(driver.cu.cuStreamDestroy_v2(stream))
    assert report['complete'] and actual_calls == 72
    print('Three first differences certified:72 actual calls;all18 captured group scalars have GPU F32 witnesses', flush=True)


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
