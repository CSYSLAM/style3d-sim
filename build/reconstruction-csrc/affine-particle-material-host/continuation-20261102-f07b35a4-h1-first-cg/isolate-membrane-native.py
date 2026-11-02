"""Isolate every real triangle on SDK/PTX/f07; bitwise-check all output/guard words with validated GPU diagnostics."""
import ctypes as ct
import hashlib
import importlib.util
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction import kernel_ab as k
from reconstruction.csrc.g1_contact_rhs_replay import kernel_texts
from reconstruction.csrc.host_api_probe import REFERENCE, REFERENCE_SHA, load_reference
from reconstruction.csrc.pcg_alias_replay import span_groups
from reconstruction.csrc.pcg_same_buffer_probe import Dim3

BACKENDS = ('original-runtime', 'original-ptx', 'source-ptx')
output = BASE / 'membrane-native-isolation'
output.mkdir(exist_ok=False)
prepared = json.loads((BASE / 'membrane-isolation-inputs/plan.json').read_text())
plan = json.loads((BASE / 'assembly-full-inputs/plan.json').read_text())
packet_path = Path(prepared['SDK_packet'])
with np.load(packet_path, allow_pickle=False) as packet:
    raw = [packet[f'parameter-{i}'].tobytes() for i in range(13)]
    bindings = {i: packet[f'before-arg-{i}'].tobytes() for i in range(8)}
values = [int.from_bytes(value, 'little') for value in raw]
assert values[8:] == [27, 66930, 66930, 33887, 33887]
build = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
candidate = json.loads(Path(plan['source_host_build']).read_text())
assert hashlib.sha256(Path(candidate['image']).read_bytes()).hexdigest() == plan['source_host_sha256']
driver = k.Driver()
load_reference()
assert hashlib.sha256(REFERENCE.read_bytes()).hexdigest() == REFERENCE_SHA
runtime = ct.CDLL(str(REFERENCE))
runtime.cudaLaunchKernel.argtypes = [ct.c_void_p, Dim3, Dim3, ct.POINTER(ct.c_void_p), ct.c_size_t, ct.c_void_p]
runtime.cudaLaunchKernel.restype = ct.c_int
spec = importlib.util.spec_from_file_location('_source_solver', candidate['image'])
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)
assert module.source_only
source = module._KernelDriver()
name = plan['kernels']['membrane']
texts, _ = kernel_texts(build, name)
functions = {'original-runtime': ct.cast(getattr(runtime, name), ct.c_void_p),
             'original-ptx': driver.function(texts['original'], name),
             'source-ptx': ct.c_void_p(source.function(name))}
helper_text = (BASE / 'membrane-complete-word-check.ptx').read_text()
helpers = {key: driver.function(helper_text, key) for key in ('patch_words', 'gather_words', 'compare_words')}
stream = ct.c_void_p()
driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
driver.cu.cuMemcpyDtoD_v2.argtypes = [ct.c_uint64, ct.c_uint64, ct.c_size_t]
driver.cu.cuMemcpyDtoD_v2.restype = ct.c_int
groups, pointers = span_groups(values, bindings), {}
outputs, baselines, expected_devices = [], [], []
actual_calls, completed, complete, helper_calls = 0, 0, False, 0
n0, n1 = 0, 0
chunk_rows, controls = [], []
status_seed = np.asarray([0, 0xffffffff], dtype='u4')
gather_seed = np.zeros(81, dtype='u4')
small_devices = []


def put(pointer, array):
    driver.check(driver.cu.cuMemcpyHtoD_v2(ct.c_uint64(pointer), ct.c_void_p(array.ctypes.data), array.nbytes))


def copy(destination, source_pointer, size):
    driver.check(driver.cu.cuMemcpyDtoD_v2(ct.c_uint64(destination), source_pointer, size))


def helper(key, params, threads):
    global helper_calls
    holders = (ct.c_void_p * len(params))(*[ct.cast(ct.byref(value), ct.c_void_p) for value in params])
    driver.check(driver.cu.cuLaunchKernel(helpers[key], (threads + 255) // 256, 1, 1, 256, 1, 1, 0,
                                         stream, holders, None))
    helper_calls += 1


def check_outputs(target_device, actual_device, count):
    helper('compare_words', [outputs[0]['device'], outputs[1]['device'], *expected_devices,
                            ct.c_uint(n0), ct.c_uint(n1), status_device], n0 + n1)
    helper('gather_words', [outputs[0]['device'], outputs[1]['device'], ct.c_uint(n0), target_device,
                           actual_device, ct.c_uint(count)], count)
    driver.check(driver.cu.cuStreamSynchronize(stream))
    return driver.download(status_device, status_seed), driver.download(actual_device, gather_seed)[:count]


def restore_outputs():
    for group, seed_device in zip(outputs, baselines, strict=True):
        copy(group['device'].value, seed_device, len(group['upload']))


def check_readonly():
    for group in groups:
        if any(group is output_group for output_group in outputs):
            continue
        actual = driver.download(group['device'], group['upload'])
        mask = np.ones(len(actual), dtype=bool)
        for i in group['indices']:
            width = {1: 12, 2: 16, 3: 4, 4: 12}.get(i, 0)
            offset = group['padding'] + values[i] - group['start']
            mask[offset:offset + width] = False
        assert np.array_equal(actual[mask], group['upload'][mask])


def progress():
    (output / 'progress.json').write_text(json.dumps({'complete': complete, 'completed_triangles': completed,
        'planned_triangles': 66930, 'actual_native_PTX_source_calls': actual_calls,
        'diagnostic_helper_calls': helper_calls, 'whole_solver_complete': False}, indent=2) + '\n')


try:
    for group in groups:
        padding = 256 + group['start'] % 256
        initial = np.full(padding + len(group['initial']) + 256, 211, dtype='u1')
        initial[padding:padding + len(group['initial'])] = group['initial']
        device = driver.upload(initial)
        group.update(device=device, upload=initial, padding=padding)
        for i in group['indices']:
            pointers[i] = device.value + padding + values[i] - group['start']
    for i in (5, 7):
        group = next(group for group in groups if i in group['indices'])
        assert group['indices'] == [i] and len(group['upload']) % 4 == 0 and group['padding'] % 4 == 0
        outputs.append(group)
        baselines.append(driver.upload(group['upload']))
        expected_devices.append(driver.upload(group['upload']))
    n0, n1 = (len(group['upload']) // 4 for group in outputs)
    assert n0 + n1 < 2**32
    target_device = driver.upload(np.zeros(81, dtype='u4'))
    value_device = driver.upload(gather_seed)
    actual_device = driver.upload(gather_seed)
    status_device = driver.upload(status_seed)
    small_devices = [target_device, value_device, actual_device, status_device]
    parameters = [(ct.c_ubyte * len(value)).from_buffer_copy(
        pointers[i].to_bytes(8, 'little') if i in pointers else (1).to_bytes(8, 'little') if i == 9 else value)
        for i, value in enumerate(raw)]
    holders = (ct.c_void_p * len(parameters))(*[ct.cast(ct.byref(value), ct.c_void_p) for value in parameters])

    # Full CPU readback controls check both outputs, both guards, the boundary, and ELL column words.
    points = sorted(set([0, outputs[0]['padding'] // 4, n0 // 2, n0 - 1, n0,
                         n0 + outputs[1]['padding'] // 4, n0 + n1 // 2, n0 + n1 - 1]))
    for selected in [[], *[[point] for point in points], points]:
        restore_outputs()
        expected_cpu = [group['upload'].view('u4').copy() for group in outputs]
        mutated = []
        for point in selected:
            side, offset = (0, point) if point < n0 else (1, point - n0)
            expected_cpu[side][offset] ^= np.uint32(1)
            mutated.append(expected_cpu[side][offset])
        padded_targets = np.zeros(81, dtype='u4')
        padded_values = np.zeros(81, dtype='u4')
        padded_targets[:len(selected)] = selected
        padded_values[:len(selected)] = mutated
        put(target_device.value, padded_targets)
        put(value_device.value, padded_values)
        put(status_device.value, status_seed)
        driver.check(driver.cu.cuCtxSynchronize())
        if selected:
            helper('patch_words', [outputs[0]['device'], outputs[1]['device'], ct.c_uint(n0), target_device,
                                   value_device, ct.c_uint(len(selected))], len(selected))
        status, gathered = check_outputs(target_device, actual_device, max(1, len(selected)))
        actual_cpu = [driver.download(group['device'], group['upload']).view('u4') for group in outputs]
        assert all(np.array_equal(a, b) for a, b in zip(actual_cpu, expected_cpu, strict=True))
        assert status.tolist() == [len(selected), min(selected) if selected else 0xffffffff]
        if selected:
            assert np.array_equal(gathered, np.asarray(mutated, dtype='u4'))
        controls.append({'mutated_word_indices': selected, 'GPU_status': status.tolist(),
                         'complete_CPU_readback_verified': True,
                         'actual_complete_sha256': [hashlib.sha256(a.tobytes()).hexdigest() for a in actual_cpu]})
    (output / 'helper-controls.json').write_text(json.dumps({'controls': controls,
        'all_word_counts_including_guards': [n0, n1], 'complete': True}, indent=2) + '\n')
    progress()
    for chunk in prepared['chunks']:
        path = Path(chunk['file'])
        assert hashlib.sha256(path.read_bytes()).hexdigest() == chunk['sha256']
        with np.load(path, allow_pickle=False) as packet:
            targets, expected_values = packet['targets'], packet['after']
        saved_actual = np.zeros((chunk['stop'] - chunk['start'], 3, 81), dtype='u4')
        saved_status = np.zeros((chunk['stop'] - chunk['start'], 3, 2), dtype='u4')
        for local, row in enumerate(range(chunk['start'], chunk['stop'])):
            words = (targets[local] & np.uint64(0xffffffff)).astype('u4')
            flat = np.zeros(81, dtype='u4')
            for side, i in enumerate((5, 7)):
                mask = targets[local] >> np.uint64(32) == i
                flat[mask] = words[mask] + outputs[side]['padding'] // 4 + (n0 if side else 0)
            assert len(np.unique(flat)) == 81 and int(flat.max()) < n0 + n1
            put(target_device.value, flat)
            put(value_device.value, expected_values[local])
            for i, width in ((1, 12), (2, 16), (3, 4), (4, 12)):
                field = np.frombuffer(bindings[i][row * width:(row + 1) * width], dtype='u1')
                put(pointers[i], field)
            for group, seed_device, expected_device in zip(outputs, baselines, expected_devices, strict=True):
                copy(expected_device.value, seed_device, len(group['upload']))
            driver.check(driver.cu.cuCtxSynchronize())
            helper('patch_words', [*expected_devices, ct.c_uint(n0), target_device, value_device, ct.c_uint(81)], 81)
            driver.check(driver.cu.cuStreamSynchronize(stream))
            rotation = row % 3
            for backend in BACKENDS[rotation:] + BACKENDS[:rotation]:
                restore_outputs()
                put(status_device.value, status_seed)
                driver.check(driver.cu.cuCtxSynchronize())
                if backend == 'original-runtime':
                    assert runtime.cudaLaunchKernel(functions[backend], Dim3(262, 1, 1), Dim3(256, 1, 1),
                                                    holders, 0, stream) == 0
                else:
                    driver.check(driver.cu.cuLaunchKernel(functions[backend], 262, 1, 1, 256, 1, 1, 0,
                                                         stream, holders, None))
                actual_calls += 1
                status, gathered = check_outputs(target_device, actual_device, 81)
                saved_actual[local, BACKENDS.index(backend)] = gathered
                saved_status[local, BACKENDS.index(backend)] = status
                if status.tolist() != [0, 0xffffffff] or not np.array_equal(gathered, expected_values[local]):
                    failure = {'status': status, 'actual_sparse': gathered, 'expected_sparse': expected_values[local]}
                    for side, group in enumerate(outputs):
                        failure[f'actual-{side}'] = driver.download(group['device'], group['upload'])
                        failure[f'expected-{side}'] = driver.download(expected_devices[side], group['upload'])
                    np.savez_compressed(output / f'failure-{row:05d}-{backend}.npz', **failure)
                    raise RuntimeError(f'Triangle {row}/{backend}: complete output or gathered actual F32 mismatch')
            completed += 1
            if completed % 1024 == 0:
                progress()
                print('All-word native SDK/PTX/f07 triangle checks:', completed, '/66930', flush=True)
        check_readonly()
        target = output / path.name
        np.savez_compressed(target, actual_words=saved_actual, complete_comparison_status=saved_status)
        chunk_rows.append({'start': chunk['start'], 'stop': chunk['stop'], 'file': str(target),
                           'sha256': hashlib.sha256(target.read_bytes()).hexdigest()})
    assert actual_calls == 200790 and completed == 66930
    complete = True
finally:
    progress()
    (output / 'report.json').write_text(json.dumps({'complete': complete, 'triangles': completed,
        'actual_calls': actual_calls, 'backends': BACKENDS, 'chunks': chunk_rows,
        'original_launch_geometry_preserved': [262, 1, 1, 256, 1, 1, 0],
        'diagnostic_input_changes': 'count=1; four actual triangle fields moved to row0; all output seeds restored',
        'full_output_and_guard_words_checked_per_backend_call': n0 + n1 if outputs else None,
        'all_complete_actual_outputs_losslessly_encoded_by_seeds_and_exact_gathered_values': True,
        'GPU_comparator_controls_include_full_CPU_readback_and_deliberate_bit_flips': True,
        'source_host_sha256': plan['source_host_sha256'], 'reference_sha256': REFERENCE_SHA,
        'GPU_resets_fenced': True, 'joint_global_schedule_proven': False,
        'fixed_C8_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
    for device in baselines + expected_devices + small_devices:
        driver.check(driver.cu.cuMemFree_v2(device))
    for group in groups:
        if 'device' in group:
            driver.check(driver.cu.cuMemFree_v2(group['device']))
    driver.check(driver.cu.cuStreamDestroy_v2(stream))
print('All66930 triangles /200790 actual SDK/PTX/f07 calls: every output/guard word strict')
