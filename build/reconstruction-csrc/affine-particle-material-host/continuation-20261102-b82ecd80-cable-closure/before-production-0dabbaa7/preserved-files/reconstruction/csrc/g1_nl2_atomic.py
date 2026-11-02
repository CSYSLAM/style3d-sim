"""Record actual NL2 reduction operands, isolate SDK contributors, and verify real F32 order certificates."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path

import numpy as np

from .demo_source_ab import ROOT
from .g1_contact_rhs_replay import kernel_texts
from .host_api_probe import REFERENCE, load_reference
from .host_particles_ab import native_source
from .particle_reduction_certificates import SERIAL_PTX
from .pcg_alias_replay import span_groups
from .pcg_same_buffer_probe import Dim3
from .surface_atomic_operands import instrument


BACKENDS = ('original-runtime', 'original-ptx', 'source-ptx')
STAGES = ('precondition_first', 'matrix_first', 'precondition_last', 'matrix_last')


def fold(values, order, seed):
    """Match global F32 atomic FTZ semantics, including signed zero and every intermediate sum."""
    tiny = np.finfo('f4').tiny
    normalized = values.copy()
    subnormal = (np.abs(normalized) > 0) & (np.abs(normalized) < tiny)
    normalized.view('<u4')[subnormal] &= np.uint32(0x80000000)
    total = np.float32(seed)
    if 0 < abs(total) < tiny:
        total = np.copysign(np.float32(0), total)
    history = np.empty(len(order), dtype='f4')
    for i, lane in enumerate(order):
        history[i] = total
        total = np.float32(total + normalized[lane])
        if 0 < abs(total) < tiny:
            total = np.copysign(np.float32(0), total)
    return total, history


def main():
    from reconstruction import kernel_ab as k

    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--phase', type=Path, required=True)
    args = parser.parse_args()
    phase = args.phase.resolve(strict=True)
    plan = json.loads((phase / 'atomic-plan.json').read_text())
    for name, expected in plan['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
    output = phase / 'atomic'
    output.mkdir(exist_ok=False)
    build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    build_bytes = build_path.read_bytes()
    build = json.loads(build_bytes)
    driver = k.Driver()
    load_reference()
    runtime = ct.CDLL(str(REFERENCE))
    runtime.cudaLaunchKernel.argtypes = [ct.c_void_p, Dim3, Dim3, ct.POINTER(ct.c_void_p), ct.c_size_t, ct.c_void_p]
    runtime.cudaLaunchKernel.restype = ct.c_int
    source = native_source()._KernelDriver()
    stream = ct.c_void_p()
    driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
    functions, probes = {}, {}
    for key in STAGES:
        name = plan['kernels'][key]
        texts, _ = kernel_texts(build, name)
        functions[key] = {'original-runtime': ct.cast(getattr(runtime, name), ct.c_void_p),
                          'original-ptx': driver.function(texts['original'], name),
                          'source-ptx': ct.c_void_p(source.function(name))}
        probes[key] = {}
        for side, text in texts.items():
            changed, sites = instrument(text, name)
            assert sites == 1
            (output / (key + '-' + side + '-instrumented.ptx')).write_text(changed)
            probes[key][side] = driver.function(changed, name)
    (output / 'serial-atomic.ptx').write_text(SERIAL_PTX)
    serial = driver.function(SERIAL_PTX, 'audit_serial_atomic')
    rows, calls, complete = [], {'probe': 0, 'SDK_isolation': 0, 'certificate': 0}, False

    def reset(pointer, array):
        driver.check(driver.cu.cuMemcpyHtoD_v2(pointer, ct.c_void_p(array.ctypes.data), array.nbytes))

    def launch(function, parameters, backend=None, block=256):
        holders = (ct.c_void_p * len(parameters))(*[ct.cast(ct.byref(p), ct.c_void_p) for p in parameters])
        if backend == 'original-runtime':
            assert runtime.cudaLaunchKernel(function, Dim3(1, 1, 1), Dim3(block, 1, 1), holders, 0, stream) == 0
        else:
            driver.check(driver.cu.cuLaunchKernel(function, 1, 1, 1, block, 1, 1, 0, stream, holders, None))
        driver.check(driver.cu.cuStreamSynchronize(stream))

    try:
        for case in plan['cases']:
            assert build_path.read_bytes() == build_bytes
            label, key = case['label'], case['stage']
            tag = label + '-' + key
            stage = case['layout']
            world, counter = (4, 6) if key.startswith('precondition') else (7, 9)
            pointwise = 2 if key.startswith('precondition') else 6
            packet_path = Path(case['packet'])
            with np.load(packet_path, allow_pickle=False) as packet:
                raw = [packet['parameter-' + str(i)].tobytes() for i in range(len(stage['node']['parameter_hex']))]
                bindings = {int(i): packet['before-arg-' + str(i)].tobytes() for i in stage['sizes']}
                expected_vector = packet['after-arg-' + str(pointwise)].tobytes()
            values = [int.from_bytes(value, 'little') for value in raw]
            assert values[world] == 0 and len(bindings[counter]) == 4
            initial_word = int.from_bytes(bindings[counter], 'little')
            assert initial_word == case['initial_bits']
            groups, pointers, metadata = span_groups(values, bindings), {}, []
            arrays = {}
            for group in groups:
                padding = 256 + group['start'] % 256
                upload = np.full(padding + len(group['initial']) + 256, 211, dtype='u1')
                upload[padding:padding + len(group['initial'])] = group['initial']
                device = driver.upload(upload)
                assert device.value % 256 == 0
                group.update(device=device, upload=upload, padding=padding)
                metadata.append({'indices': group['indices'], 'start': group['start'], 'end': group['end'],
                                 'padding': padding, 'device_base': device.value})
                for i in group['indices']:
                    pointers[i] = device.value + padding + values[i] - group['start']
                    assert pointers[i] % 256 == values[i] % 256
            parameters = [(ct.c_ubyte * len(value)).from_buffer_copy(
                pointers[i].to_bytes(8, 'little') if i in pointers else value) for i, value in enumerate(raw)]

            def save_abi(prefix, actual):
                for i, value in enumerate(actual):
                    arrays[prefix + '-parameter-' + str(i)] = np.frombuffer(bytes(value), dtype='u1').copy()

            def capture_groups(prefix):
                for i, group in enumerate(groups):
                    arrays[prefix + '-group-' + str(i)] = driver.download(group['device'], group['upload'])
                actual = driver.download(ct.c_uint64(pointers[pointwise]), np.zeros(len(expected_vector), dtype='u1'))
                assert actual.tobytes() == expected_vector

            trace_zero, count_zero = np.zeros((256, 128, 16), dtype='u1'), np.zeros(256, dtype='u4')
            trace, counts = driver.upload(trace_zero), driver.upload(count_zero)
            observed, targets = [], set(case['target_bits'])
            for side in ('original', 'source'):
                for group in groups:
                    reset(group['device'], group['upload'])
                reset(trace, trace_zero)
                reset(counts, count_zero)
                actual_parameters = [*parameters, trace, counts]
                save_abi(side, actual_parameters)
                launch(probes[key][side], actual_parameters)
                calls['probe'] += 1
                sizes = driver.download(counts, count_zero)
                records = driver.download(trace, trace_zero)
                assert np.all(sizes[:176] == 1) and not sizes[176:].any()
                assert not records[176:].any() and not records[:, 1:].any() and not records[:, :, 12:].any()
                addresses = records[:176, 0, :8].copy().view('<u8').reshape(-1)
                operands = records[:176, 0, 8:12].copy().view('<f4').reshape(-1)
                assert np.all(addresses == pointers[counter]) and np.isfinite(operands).all()
                arrays[side + '-raw-trace'], arrays[side + '-counts'] = records, sizes
                observed.append(operands)
                capture_groups(side)
                total = driver.download(ct.c_uint64(pointers[counter]), np.zeros(1, dtype='<u4'))
                arrays[side + '-counter'] = total
                targets.add(int(total[0]))
            assert observed[0].tobytes() == observed[1].tobytes()
            operands = observed[0]
            arrays['operands'] = operands

            # A unique world id sends each real SDK contributor to its own counter without changing vector math.
            worlds = np.arange(176, dtype='<i4')
            worlds_pointer = driver.upload(worlds)
            arrays['isolated-world-map'] = worlds
            isolated_results = []
            for zero_bits in (0, 0x80000000):
                seed = np.full(176 + 128, 211, dtype='u4')
                seed[64:240] = zero_bits
                isolated_base = driver.upload(seed)
                isolated_pointer = isolated_base.value + 256
                for backend in BACKENDS:
                    prefix = backend + '-isolated-' + str(zero_bits)
                    for group in groups:
                        reset(group['device'], group['upload'])
                    reset(isolated_base, seed)
                    isolated = list(parameters)
                    isolated[world] = ct.c_uint64(worlds_pointer.value)
                    isolated[counter] = ct.c_uint64(isolated_pointer)
                    save_abi(prefix, isolated)
                    launch(functions[key][backend], isolated, backend)
                    calls['SDK_isolation'] += 1
                    capture_groups(prefix)
                    arrays[prefix + '-counters'] = driver.download(isolated_base, seed)
                    arrays[prefix + '-world-map-after'] = driver.download(worlds_pointer, worlds)
                    isolated_results.append(prefix)

            missing, orders = set(targets), {}
            normalized = operands.copy()
            tiny = np.finfo('f4').tiny
            subnormal = (np.abs(normalized) > 0) & (np.abs(normalized) < tiny)
            normalized.view('<u4')[subnormal] &= np.uint32(0x80000000)
            initial = np.asarray([initial_word], dtype='<u4').view('<f4')[0]
            rng = np.random.default_rng(int(hashlib.sha256(tag.encode()).hexdigest()[:16], 16))
            for trial in range(plan['fixed_search_limit_per_case']):
                order = np.arange(176) if trial == 0 else rng.permutation(176)
                prefix = np.cumsum(np.concatenate((np.asarray([initial], dtype='f4'), normalized[order])), dtype='f4')
                if np.any((np.abs(prefix) > 0) & (np.abs(prefix) < tiny)):
                    total, _ = fold(operands, order, initial)
                else:
                    total = prefix[-1]
                word = int(total.view('<u4'))
                if word in missing:
                    actual_total, history = fold(operands, order, initial)
                    if int(actual_total.view('<u4')) == word:
                        missing.remove(word)
                        orders[word] = (order.astype('<u4'), history)
                if not missing:
                    break
            certificates = []
            for word in sorted(targets):
                row = {'target_bits': word, 'passed': False}
                certificates.append(row)
                if word not in orders:
                    continue
                order, wanted_history = orders[word]
                total_zero, history_zero = np.asarray([initial_word], dtype='<u4'), np.zeros(176, dtype='f4')
                device_values, device_order, device_total, device_history = [driver.upload(a) for a in
                                                                           (operands, order, total_zero, history_zero)]
                serial_parameters = [device_values, device_order, device_total, device_history, ct.c_uint(176)]
                save_abi('certificate-' + str(word), serial_parameters)
                launch(serial, serial_parameters, block=1)
                calls['certificate'] += 1
                actual_total = driver.download(device_total, total_zero)
                actual_history = driver.download(device_history, history_zero)
                assert int(actual_total[0]) == word and actual_history.tobytes() == wanted_history.tobytes()
                arrays[str(word) + '-order'], arrays[str(word) + '-history'] = order, actual_history
                arrays[str(word) + '-total'] = actual_total
                row['passed'] = True
            path = output / (tag + '.npz')
            np.savez_compressed(path, **arrays)
            rows.append({'label': label, 'stage': key, 'groups': metadata,
                         'output_sha256': hashlib.sha256(path.read_bytes()).hexdigest(),
                         'actual_recorded_operands_equal': True, 'negative_operands': int(np.count_nonzero(operands < 0)),
                         'subnormal_operands': int(np.count_nonzero(subnormal)), 'initial_bits': initial_word,
                         'isolation_prefixes': isolated_results, 'targets': sorted(targets), 'certificates': certificates,
                         'search_trials': trial + 1, 'unexplained_bits': sorted(missing)})
            driver.free()
            print(tag, 'GPU certificate targets', len(targets), 'unexplained', sorted(missing), flush=True)
        complete = True
    finally:
        driver.free()
        driver.check(driver.cu.cuStreamDestroy_v2(stream))
        (output / 'report.json').write_text(json.dumps({
            'rows': rows, 'actual_calls': calls, 'complete': complete,
            'all_certificates_passed': all(c['passed'] for r in rows for c in r['certificates']),
            'actual_production_order_inferred': False, 'strict_failures_reclassified': False,
            'production_changed': False, 'whole_solver_complete': False,
            'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}, indent=2) + '\n')
    assert complete and len(rows) == 8 and calls['probe'] == 16 and calls['SDK_isolation'] == 48
    assert all(c['passed'] for r in rows for c in r['certificates'])


if __name__ == '__main__':
    main()
