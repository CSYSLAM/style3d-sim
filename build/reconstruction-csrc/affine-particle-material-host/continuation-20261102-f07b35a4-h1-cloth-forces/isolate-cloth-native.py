"""Verify all actual cloth primitives on native SDK/PTX/f07, including every RHS and guard word."""
import argparse
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

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--case', required=True)
args = parser.parse_args()
prepared = json.loads((BASE / 'cloth-native-inputs-v2/plan.json').read_text())
case = next(row for row in prepared['cases'] if row['tag'] == args.case)
output = BASE / 'cloth-native-isolation' / case['tag']
output.mkdir(parents=True, exist_ok=False)
plan = json.loads((BASE / 'plan.json').read_text())
with np.load(case['packet'], allow_pickle=False) as packet:
    raw = [packet[f'parameter-{i}'].tobytes() for i in range(9 if case['stage'] == 'stretch' else 11)]
    bindings = {int(key.rsplit('-', 1)[1]): packet[key].tobytes()
                for key in packet.files if key.startswith('before-arg-')}
values = [int.from_bytes(value, 'little') for value in raw]
out_arg, count = case['output_arg'], case['count']
assert out_arg == (5 if case['stage'] == 'stretch' else 7)
count_arg = 6 if case['stage'] == 'stretch' else 8
assert values[count_arg:count_arg + 3] == [count, count, 33887]
fields = ((1, 4), (2, 16), (3, 12), (4, 12)) if case['stage'] == 'stretch' else (
    (2, 4), (3, 16), (4, 16), (5, 8))
blocks = 262 if case['stage'] == 'stretch' else 394
BACKENDS = ('original-runtime', 'original-ptx', 'source-ptx')
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
name = plan['kernels'][case['stage']]
build = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
texts, _ = kernel_texts(build, name)
functions = {'original-runtime': ct.cast(getattr(runtime, name), ct.c_void_p),
             'original-ptx': driver.function(texts['original'], name),
             'source-ptx': ct.c_void_p(source.function(name))}
previous = BASE.parent / 'continuation-20261102-f07b35a4-h1-first-cg'
helper_text = (previous / 'membrane-complete-word-check.ptx').read_text()
helpers = {key: driver.function(helper_text, key) for key in ('patch_words', 'gather_words', 'compare_words')}
stream = ct.c_void_p()
driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
driver.cu.cuMemcpyDtoD_v2.argtypes = [ct.c_uint64, ct.c_uint64, ct.c_size_t]
driver.cu.cuMemcpyDtoD_v2.restype = ct.c_int
groups, pointers = span_groups(values, bindings), {}
baselines, expected_devices, outputs, small_devices = [], [], [], []
status_seed = np.asarray([0, 0xffffffff], dtype='u4')
gather_seed = np.zeros(12, dtype='u4')
completed, actual_calls, helper_calls, complete = 0, 0, 0, False
n0, n1, chunk_rows, controls = 0, 0, [], []


def put(pointer, array):
    driver.check(driver.cu.cuMemcpyHtoD_v2(ct.c_uint64(pointer), ct.c_void_p(array.ctypes.data), array.nbytes))


def copy(destination, source_pointer, size):
    driver.check(driver.cu.cuMemcpyDtoD_v2(ct.c_uint64(destination), source_pointer, size))


def helper(key, params, threads):
    global helper_calls
    holders = (ct.c_void_p * len(params))(*[ct.cast(ct.byref(value), ct.c_void_p) for value in params])
    driver.check(driver.cu.cuLaunchKernel(helpers[key], max(1, (threads + 255) // 256), 1, 1, 256, 1, 1, 0,
                                         stream, holders, None))
    helper_calls += 1


def restore():
    for group, device in zip(outputs, baselines, strict=True):
        copy(group['device'].value, device, len(group['upload']))


def inspect_outputs(length):
    helper('compare_words', [outputs[0]['device'], outputs[1]['device'], *expected_devices,
                            ct.c_uint(n0), ct.c_uint(n1), status_device], n0 + n1)
    if length:
        helper('gather_words', [outputs[0]['device'], outputs[1]['device'], ct.c_uint(n0), target_device,
                               actual_device, ct.c_uint(length)], length)
    driver.check(driver.cu.cuStreamSynchronize(stream))
    return driver.download(status_device, status_seed), driver.download(actual_device, gather_seed)[:length]


def progress():
    (output / 'progress.json').write_text(json.dumps({'complete': complete, 'completed_primitives': completed,
        'planned_primitives': count, 'actual_native_PTX_source_calls': actual_calls,
        'diagnostic_helper_calls': helper_calls, 'whole_solver_complete': False}, indent=2) + '\n')


try:
    for group in groups:
        padding = 256 + group['start'] % 256
        initial = np.full(padding + len(group['initial']) + 256, 211, dtype='u1')
        initial[padding:padding + len(group['initial'])] = group['initial']
        group.update(device=driver.upload(initial), upload=initial, padding=padding)
        assert group['device'].value % 256 == 0
        for i in group['indices']:
            pointers[i] = group['device'].value + padding + values[i] - group['start']
            assert pointers[i] % 256 == values[i] % 256
    main = next(group for group in groups if out_arg in group['indices'])
    assert main['indices'] == [out_arg] and main['padding'] % 4 == 0
    dummy = np.full(512, 211, dtype='u1')
    outputs = [main, {'device': driver.upload(dummy), 'upload': dummy, 'padding': 256}]
    for group in outputs:
        baselines.append(driver.upload(group['upload']))
        expected_devices.append(driver.upload(group['upload']))
    n0, n1 = (len(group['upload']) // 4 for group in outputs)
    target_device, value_device = driver.upload(np.zeros(12, dtype='u4')), driver.upload(gather_seed)
    actual_device, status_device = driver.upload(gather_seed), driver.upload(status_seed)
    small_devices = [target_device, value_device, actual_device, status_device]
    parameters = [(ct.c_ubyte * len(value)).from_buffer_copy(pointers[i].to_bytes(8, 'little') if i in pointers else
                   (1).to_bytes(len(value), 'little') if i == count_arg else value) for i, value in enumerate(raw)]
    holders = (ct.c_void_p * len(parameters))(*[ct.cast(ct.byref(value), ct.c_void_p) for value in parameters])
    points = sorted(set([0, main['padding'] // 4, n0 // 2, n0 - 1, n0, n0 + n1 // 2, n0 + n1 - 1]))
    for selected in [[], *[[point] for point in points], points]:
        restore()
        expected_cpu = [group['upload'].view('u4').copy() for group in outputs]
        targets, changed = np.zeros(12, dtype='u4'), np.zeros(12, dtype='u4')
        for i, point in enumerate(selected):
            side, offset = (0, point) if point < n0 else (1, point - n0)
            expected_cpu[side][offset] ^= np.uint32(1)
            targets[i], changed[i] = point, expected_cpu[side][offset]
        put(target_device.value, targets)
        put(value_device.value, changed)
        put(status_device.value, status_seed)
        driver.check(driver.cu.cuCtxSynchronize())
        if selected:
            helper('patch_words', [outputs[0]['device'], outputs[1]['device'], ct.c_uint(n0), target_device,
                                   value_device, ct.c_uint(len(selected))], len(selected))
        status, actual = inspect_outputs(len(selected))
        readback = [driver.download(group['device'], group['upload']).view('u4') for group in outputs]
        assert all(np.array_equal(a, b) for a, b in zip(readback, expected_cpu, strict=True))
        assert status.tolist() == [len(selected), min(selected) if selected else 0xffffffff]
        assert np.array_equal(actual, changed[:len(selected)])
        controls.append({'mutated_word_indices': selected, 'GPU_status': status.tolist(),
                         'complete_CPU_readback_verified': True,
                         'actual_complete_sha256': [hashlib.sha256(a.tobytes()).hexdigest() for a in readback]})
    (output / 'helper-controls.json').write_text(json.dumps({'complete': True, 'controls': controls,
        'all_word_counts_including_guards': [n0, n1]}, indent=2) + '\n')
    progress()
    for chunk in case['chunks']:
        path = Path(chunk['file'])
        assert hashlib.sha256(path.read_bytes()).hexdigest() == chunk['sha256']
        with np.load(path, allow_pickle=False) as packet:
            counts, targets, after = packet['counts'], packet['targets'], packet['after']
        actual_words = np.zeros((chunk['stop'] - chunk['start'], 3, 12), dtype='u4')
        statuses = np.zeros((chunk['stop'] - chunk['start'], 3, 2), dtype='u4')
        for local, row in enumerate(range(chunk['start'], chunk['stop'])):
            length = int(counts[local])
            flat = targets[local] + main['padding'] // 4
            assert length <= 12 and np.all(flat[:length] < n0 - 64)
            assert len(np.unique(flat[:length])) == length
            put(target_device.value, flat)
            put(value_device.value, after[local])
            for i, width in fields:
                field = np.frombuffer(bindings[i][row * width:(row + 1) * width], dtype='u1')
                put(pointers[i], field)
            for group, seed_device, expected_device in zip(outputs, baselines, expected_devices, strict=True):
                copy(expected_device.value, seed_device, len(group['upload']))
            driver.check(driver.cu.cuCtxSynchronize())
            if length:
                helper('patch_words', [*expected_devices, ct.c_uint(n0), target_device, value_device,
                                       ct.c_uint(length)], length)
            driver.check(driver.cu.cuStreamSynchronize(stream))
            rotation = row % 3
            for backend in BACKENDS[rotation:] + BACKENDS[:rotation]:
                restore()
                put(status_device.value, status_seed)
                driver.check(driver.cu.cuCtxSynchronize())
                if backend == 'original-runtime':
                    assert runtime.cudaLaunchKernel(functions[backend], Dim3(blocks, 1, 1), Dim3(256, 1, 1),
                                                    holders, 0, stream) == 0
                else:
                    driver.check(driver.cu.cuLaunchKernel(functions[backend], blocks, 1, 1, 256, 1, 1, 0,
                                                         stream, holders, None))
                actual_calls += 1
                status, actual = inspect_outputs(length)
                actual_words[local, BACKENDS.index(backend), :length] = actual
                statuses[local, BACKENDS.index(backend)] = status
                if status.tolist() != [0, 0xffffffff] or not np.array_equal(actual, after[local, :length]):
                    failure = {'status': status, 'actual_sparse': actual, 'expected_sparse': after[local, :length]}
                    for side, group in enumerate(outputs):
                        failure[f'actual-{side}'] = driver.download(group['device'], group['upload'])
                        failure[f'expected-{side}'] = driver.download(expected_devices[side], group['upload'])
                    np.savez_compressed(output / f'failure-{row:06d}-{backend}.npz', **failure)
                    raise RuntimeError(f'{case["tag"]}/{row}/{backend}: complete RHS or guard differs')
            completed += 1
            if completed % 4096 == 0:
                progress()
                print(case['tag'], 'complete native primitive checks', completed, '/', count, flush=True)
        for group in groups:
            if group is main:
                continue
            observed = driver.download(group['device'], group['upload'])
            mask = np.ones(len(observed), dtype=bool)
            for i, width in fields:
                if i in group['indices']:
                    offset = group['padding'] + values[i] - group['start']
                    mask[offset:offset + width] = False
            assert np.array_equal(observed[mask], group['upload'][mask])
        target = output / path.name
        np.savez_compressed(target, actual_words=actual_words, complete_comparison_status=statuses)
        chunk_rows.append({'start': chunk['start'], 'stop': chunk['stop'], 'file': str(target),
                           'sha256': hashlib.sha256(target.read_bytes()).hexdigest()})
    assert completed == count and actual_calls == count * 3
    complete = True
finally:
    progress()
    (output / 'report.json').write_text(json.dumps({'complete': complete, 'tag': case['tag'],
        'actual_calls': actual_calls, 'primitives': completed, 'chunks': chunk_rows, 'backends': BACKENDS,
        'full_output_and_guard_words_checked_per_backend_call': n0 + n1,
        'original_launch_geometry_preserved': [blocks, 1, 1, 256, 1, 1, 0],
        'diagnostic_input_changes': 'count=1; four original primitive fields to row0; original RHS seeds restored',
        'all_full_RHS_outputs_losslessly_encoded_by_seeds_actual_values_and_full_word_checks': True,
        'source_host_sha256': plan['source_host_sha256'], 'reference_sha256': REFERENCE_SHA,
        'GPU_resets_fenced': True, 'fixed_C8_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
    for device in baselines + expected_devices + small_devices:
        driver.check(driver.cu.cuMemFree_v2(device))
    for group in groups:
        if 'device' in group:
            driver.check(driver.cu.cuMemFree_v2(group['device']))
    if len(outputs) == 2:
        driver.check(driver.cu.cuMemFree_v2(outputs[1]['device']))
    driver.check(driver.cu.cuStreamDestroy_v2(stream))
print(case['tag'], 'all actual native SDK/PTX/f07 primitive RHS outputs strict:', actual_calls)
