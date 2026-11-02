"""Isolate every actual VF/EE query and tangent contact on native SDK/PTX/f07, checking all outputs and guards."""
import argparse
import ctypes as ct
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction import kernel_ab as k
from reconstruction.csrc.g1_contact_rhs_replay import kernel_texts
from reconstruction.csrc.host_api_probe import REFERENCE, REFERENCE_SHA, load_reference
from reconstruction.csrc.library_entries import entries
from reconstruction.csrc.pcg_alias_replay import span_groups
from reconstruction.csrc.pcg_same_buffer_probe import Dim3

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--case', required=True)
args = parser.parse_args()
plan = json.loads((BASE / 'native-query-plan.json').read_text())
case = next(row for row in plan['cases'] if row['tag'] == args.case)
output = BASE / 'native-query-isolation' / case['tag']
output.mkdir(parents=True, exist_ok=False)
capture_plan = json.loads((BASE / 'full-inputs/plan.json').read_text())
with np.load(case['packet'], allow_pickle=False) as packet:
    raw = [packet[f'parameter-{i}'].tobytes() for i in range(case['parameter_count'])]
    bindings = {int(key.rsplit('-', 1)[1]): packet[key].tobytes()
                for key in packet.files if key.startswith('before-arg-')}
with np.load(case['normalized_file'], allow_pickle=False) as archive:
    normalized = {key: archive[key] for key in archive.files}
values = [int.from_bytes(value, 'little') for value in raw]
key, count = case['stage'], len(normalized['counts'])
contact, counter = case['contact_argument'], case['counter_argument']
before_counter = int.from_bytes(bindings[counter], 'little')
assert count == case['queries'] and before_counter == case['counter_before']
outputs = [3] if key == 'tangent' else ([11, 12, 13, 14] if key == 'vf' else [9, 10, 11, 12])
count_arg = None if key == 'tangent' else (15 if key == 'vf' else 13)
mutable = {0: 60, 1: 4} if key == 'tangent' else (
    {1: 4, 4: 4, 5: 31 * 4} if key == 'vf' else {1: 16, 2: 8, 4: 4, 5: 31 * 4})
fields, cursor = {}, 0
for i in outputs:
    size = len(bindings[i])
    if i == contact:
        size = (before_counter + 31) * 60
    start = (cursor + 255) // 256 * 256 + 256 + values[i] % 256
    fields[i] = {'offset': start, 'bytes': size}
    cursor = start + size + 256
flat_seed = np.full((cursor + 3) // 4 * 4, 211, dtype='u1')
for i, field in fields.items():
    flat_seed[field['offset']:field['offset'] + field['bytes']] = np.frombuffer(bindings[i][:field['bytes']], dtype='u1')
seed_words = flat_seed.view('u4')
dummy_seed = np.full(512, 211, dtype='u1')
status_seed = np.asarray([0, 0xffffffff], dtype='u4')
small_seed = np.zeros(2048, dtype='u4')
starts = np.concatenate(([0], np.cumsum(normalized['counts'], dtype='i8')))
append_starts = np.concatenate(([0], np.cumsum(normalized['append_counts'], dtype='i8')))
assert np.all(normalized['append_counts'] <= 31)
driver = k.Driver()
load_reference()
assert hashlib.sha256(REFERENCE.read_bytes()).hexdigest() == REFERENCE_SHA
runtime = ct.CDLL(str(REFERENCE))
runtime.cudaLaunchKernel.argtypes = [ct.c_void_p, Dim3, Dim3, ct.POINTER(ct.c_void_p), ct.c_size_t, ct.c_void_p]
runtime.cudaLaunchKernel.restype = ct.c_int
candidate = json.loads(Path(capture_plan['source_host_build']).read_text())
assert hashlib.sha256(Path(candidate['image']).read_bytes()).hexdigest() == capture_plan['source_host_sha256']
spec = importlib.util.spec_from_file_location('_source_solver', candidate['image'])
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)
assert module.source_only
source = module._KernelDriver()
build = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
name = capture_plan['kernels'][key]
texts, _ = kernel_texts(build, name)
functions = {'original-runtime': ct.cast(getattr(runtime, name), ct.c_void_p),
             'original-ptx': driver.function(texts['original'], name),
             'source-ptx': ct.c_void_p(source.function(name))}


def gated_original(text):
    original = entries(text)[name]
    end = original.index(')')
    entry = original[:end] + ',\n.param .u32 native_selected_query\n' + original[end:]
    entry = entry.replace('{', '''{
.reg .b32 %native_tid, %native_block, %native_ntid, %native_lane, %native_selected;
.reg .pred %native_drop;
''', 1)
    first = re.search(r'(?m)^ld\.param\.', entry)
    assert first
    gate = '''mov.u32 %native_tid, %tid.x;
mov.u32 %native_block, %ctaid.x;
mov.u32 %native_ntid, %ntid.x;
mad.lo.u32 %native_lane, %native_block, %native_ntid, %native_tid;
ld.param.u32 %native_selected, [native_selected_query];
setp.ne.u32 %native_drop, %native_lane, %native_selected;
@%native_drop ret;
'''
    entry = entry[:first.start()] + gate + entry[first.start():]
    return text.replace(original, entry)


gated_text = gated_original(texts['original'])
(output / 'original-selected-query.ptx').write_text(gated_text)
gate_function = driver.function(gated_text, name)
previous = BASE.parent / 'continuation-20261102-f07b35a4-h1-first-cg'
helper_text = (previous / 'membrane-complete-word-check.ptx').read_text()
helpers = {name: driver.function(helper_text, name) for name in ('patch_words', 'gather_words', 'compare_words')}
stream = ct.c_void_p()
driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
driver.cu.cuMemcpyDtoD_v2.argtypes = [ct.c_uint64, ct.c_uint64, ct.c_size_t]
driver.cu.cuMemcpyDtoD_v2.restype = ct.c_int
groups = span_groups(values, {i: value for i, value in bindings.items() if i not in outputs})
pointers, devices = {}, []
actual_calls, gate_calls, completed, helper_calls, complete = 0, 0, 0, 0, False
chunk_reports, controls, gated_controls = [], [], []
BACKENDS = ('original-runtime', 'original-ptx', 'source-ptx')


def put(pointer, array):
    driver.check(driver.cu.cuMemcpyHtoD_v2(ct.c_uint64(pointer), ct.c_void_p(array.ctypes.data), ct.c_size_t(array.nbytes)))


def copy(destination, source_pointer, size):
    driver.check(driver.cu.cuMemcpyDtoD_v2(ct.c_uint64(destination), source_pointer, ct.c_size_t(size)))


def helper(symbol, parameters, threads):
    global helper_calls
    holders = (ct.c_void_p * len(parameters))(*[ct.cast(ct.byref(value), ct.c_void_p) for value in parameters])
    driver.check(driver.cu.cuLaunchKernel(helpers[symbol], max(1, (threads + 255) // 256), 1, 1, 256, 1, 1, 0,
                                         stream, holders, None))
    helper_calls += 1


def f32_add(left, right):
    if left & 0x7f800000 == 0:
        left &= 0x80000000
    if right & 0x7f800000 == 0:
        right &= 0x80000000
    if right & 0x7fffffff == 0:
        return left if left & 0x7fffffff else left & right & 0x80000000
    if left & 0x7fffffff == 0:
        return right
    pair = np.asarray([left, right], dtype='u4').view('f4')
    result = int(np.float32(pair[0] + pair[1]).view('u4'))
    return result & 0x80000000 if result & 0x7f800000 == 0 else result


def expected_query(row):
    updates, history_before, history_after = {}, [], []
    for pos in range(int(starts[row]), int(starts[row + 1])):
        target = int(normalized['targets'][pos])
        i, word = target >> 32, target & 0xffffffff
        index = fields[i]['offset'] // 4 + word
        left = updates.get(index, int(seed_words[index]))
        right = f32_add(left, int(normalized['operands'][pos]))
        updates[index] = right
        history_before.append(left)
        history_after.append(right)
    if key != 'tangent':
        left, right = int(append_starts[row]), int(append_starts[row + 1])
        records = normalized['contact_records'][left:right].view('u4').ravel()
        offset = fields[contact]['offset'] // 4 + before_counter * 15
        for pos, value in enumerate(records):
            updates[offset + pos] = int(value)
        updates[fields[counter]['offset'] // 4] = before_counter + right - left
    changed = sorted(index for index, value in updates.items() if value != int(seed_words[index]))
    targets = np.asarray(changed, dtype='u4')
    result = np.asarray([updates[index] for index in changed], dtype='u4')
    assert len(targets) <= len(small_seed)
    return targets, result, history_before, history_after


def metadata(row, original=False):
    arrays = []
    for i, width in mutable.items():
        if original:
            data = np.frombuffer(bindings[i][:width], dtype='u1')
        elif key == 'tangent' and i == counter:
            data = np.asarray([1], dtype='u4').view('u1')
        elif key == 'ee' and i == 2:
            data = np.frombuffer(bindings[i][row * 4:row * 4 + 8], dtype='u1')
        else:
            data = np.frombuffer(bindings[i][row * width:(row + 1) * width], dtype='u1')
            if key == 'ee' and i == 5:
                slots = data.view('i4').copy()
                qcount = int.from_bytes(bindings[4][row * 4:row * 4 + 4], 'little')
                assert np.all((slots[:qcount] >= 0) & (slots[:qcount] < 100634))
                slots[slots <= row] = 0
                data = slots.view('u1')
        put(pointers[i], data)
        arrays.append(data)
    driver.check(driver.cu.cuCtxSynchronize())


def prepare_expected(targets, values_to_write):
    copy(expected_flat.value, baseline_flat, flat_seed.nbytes)
    if len(targets):
        put(target_device.value, targets)
        put(value_device.value, values_to_write)
    driver.check(driver.cu.cuCtxSynchronize())
    if len(targets):
        helper('patch_words', [expected_flat, expected_dummy, ct.c_uint(n0), target_device, value_device,
                               ct.c_uint(len(targets))], len(targets))
    driver.check(driver.cu.cuStreamSynchronize(stream))


def restore_actual():
    copy(actual_flat.value, baseline_flat, flat_seed.nbytes)
    copy(actual_dummy.value, baseline_dummy, dummy_seed.nbytes)
    put(status_device.value, status_seed)
    driver.check(driver.cu.cuCtxSynchronize())


def inspect_outputs(targets):
    helper('compare_words', [actual_flat, actual_dummy, expected_flat, expected_dummy,
                            ct.c_uint(n0), ct.c_uint(n1), status_device], n0 + n1)
    if len(targets):
        helper('gather_words', [actual_flat, actual_dummy, ct.c_uint(n0), target_device,
                               actual_device, ct.c_uint(len(targets))], len(targets))
    driver.check(driver.cu.cuStreamSynchronize(stream))
    return driver.download(status_device, status_seed), driver.download(actual_device, small_seed)[:len(targets)]


def progress():
    (output / 'progress.json').write_text(json.dumps({'complete': complete, 'completed_queries': completed,
        'planned_queries': count, 'actual_native_PTX_source_calls': actual_calls, 'original_selected_query_calls': gate_calls,
        'diagnostic_helper_calls': helper_calls, 'whole_solver_complete': False}, indent=2) + '\n')


def verify_actual(row, backend, targets, expected_values):
    status, observed = inspect_outputs(targets)
    if status.tolist() != [0, 0xffffffff] or not np.array_equal(observed, expected_values):
        np.savez_compressed(output / f'failure-{row:06d}-{backend}.npz', status=status, actual_sparse=observed,
                            expected_sparse=expected_values, actual_flat=driver.download(actual_flat, flat_seed),
                            expected_flat=driver.download(expected_flat, flat_seed),
                            actual_dummy=driver.download(actual_dummy, dummy_seed))
        raise RuntimeError(f'{case["tag"]}/{row}/{backend}: complete output or guard differs')
    return status, observed


try:
    for group in groups:
        padding = 256 + group['start'] % 256
        initial = np.full(padding + len(group['initial']) + 256, 211, dtype='u1')
        initial[padding:padding + len(group['initial'])] = group['initial']
        group.update(device=driver.upload(initial), upload=initial, padding=padding)
        for i in group['indices']:
            pointers[i] = group['device'].value + padding + values[i] - group['start']
            assert pointers[i] % 256 == values[i] % 256
    actual_flat, actual_dummy = driver.upload(flat_seed), driver.upload(dummy_seed)
    baseline_flat, baseline_dummy = driver.upload(flat_seed), driver.upload(dummy_seed)
    expected_flat, expected_dummy = driver.upload(flat_seed), driver.upload(dummy_seed)
    target_device, value_device = driver.upload(small_seed), driver.upload(small_seed)
    actual_device, status_device = driver.upload(small_seed), driver.upload(status_seed)
    devices = [actual_flat, actual_dummy, baseline_flat, baseline_dummy, expected_flat, expected_dummy,
               target_device, value_device, actual_device, status_device]
    n0, n1 = flat_seed.nbytes // 4, dummy_seed.nbytes // 4
    for i, field in fields.items():
        pointers[i] = actual_flat.value + field['offset']
        assert pointers[i] % 256 == values[i] % 256
    parameters, gate_parameters = [], []
    for i, value in enumerate(raw):
        translated = pointers[i].to_bytes(8, 'little') if i in pointers else value
        gate_parameters.append((ct.c_ubyte * len(value)).from_buffer_copy(translated))
        if i == count_arg:
            translated = (1).to_bytes(len(value), 'little')
        parameters.append((ct.c_ubyte * len(value)).from_buffer_copy(translated))
    holders = (ct.c_void_p * len(parameters))(*[ct.cast(ct.byref(value), ct.c_void_p) for value in parameters])
    layout = {'fields': fields, 'flat_bytes': flat_seed.nbytes, 'dummy_bytes': dummy_seed.nbytes,
              'actual_parameter_hex': [bytes(value).hex() for value in parameters],
              'gated_actual_parameter_hex': [bytes(value).hex() for value in gate_parameters],
              'mutable_input_prefix_bytes': mutable, 'counter_before': before_counter,
              'original_count_parameter_replaced_with_one': count_arg}
    (output / 'layout.json').write_text(json.dumps(layout, indent=2) + '\n')
    points = {0, n0 - 1, n0, n0 + n1 // 2, n0 + n1 - 1}
    for field in fields.values():
        start, size = field['offset'] // 4, field['bytes'] // 4
        points.update((start - 1, start, start + size // 2, start + size - 1, start + size))
    points = sorted(points)
    for selected in [[], *[[point] for point in points], points]:
        restore_actual()
        cpu = [flat_seed.view('u4').copy(), dummy_seed.view('u4').copy()]
        changed = []
        for point in selected:
            side, index = (0, point) if point < n0 else (1, point - n0)
            cpu[side][index] ^= np.uint32(1)
            changed.append(cpu[side][index])
        targets, bits = np.asarray(selected, dtype='u4'), np.asarray(changed, dtype='u4')
        if len(targets):
            put(target_device.value, targets)
            put(value_device.value, bits)
        driver.check(driver.cu.cuCtxSynchronize())
        if len(targets):
            helper('patch_words', [actual_flat, actual_dummy, ct.c_uint(n0), target_device, value_device,
                                   ct.c_uint(len(targets))], len(targets))
        status, observed = inspect_outputs(targets)
        actual_cpu = [driver.download(actual_flat, flat_seed), driver.download(actual_dummy, dummy_seed)]
        assert all(np.array_equal(a.view('u4'), b) for a, b in zip(actual_cpu, cpu, strict=True))
        assert status.tolist() == [len(selected), min(selected) if selected else 0xffffffff]
        assert np.array_equal(observed, bits)
        controls.append({'mutated_words': selected, 'GPU_status': status.tolist(), 'complete_CPU_readback_verified': True,
                         'actual_complete_SHA256': [hashlib.sha256(a.tobytes()).hexdigest() for a in actual_cpu]})
    (output / 'helper-controls.json').write_text(json.dumps(controls, indent=2) + '\n')
    gx, gy, gz, bx, by, bz, shared = case['geometry']
    for row in case['gated_control_queries']:
        metadata(row, original=True)
        targets, expected_values, _, _ = expected_query(row)
        prepare_expected(targets, expected_values)
        restore_actual()
        selected = ct.c_uint(row)
        gate_values = [*gate_parameters, selected]
        gate_holders = (ct.c_void_p * len(gate_values))(*[ct.cast(ct.byref(value), ct.c_void_p) for value in gate_values])
        driver.check(driver.cu.cuLaunchKernel(gate_function, gx, gy, gz, bx, by, bz, shared, stream, gate_holders, None))
        gate_calls += 1
        status, observed = verify_actual(row, 'original-selected-query', targets, expected_values)
        gated_controls.append({'query': row, 'status': status.tolist(), 'targets': targets.tolist(),
                               'actual_words': observed.tolist()})
    (output / 'original-selected-query-controls.json').write_text(json.dumps(gated_controls, indent=2) + '\n')
    for first in range(0, count, 4096):
        last = min(count, first + 4096)
        offsets, patch_targets, patch_values = [0], [], []
        actual_values, history_left, history_right = [[], [], []], [], []
        all_status = np.zeros((last - first, 3, 2), dtype='u4')
        for row in range(first, last):
            metadata(row)
            targets, expected_values, left, right = expected_query(row)
            prepare_expected(targets, expected_values)
            rotation = row % 3
            for backend in BACKENDS[rotation:] + BACKENDS[:rotation]:
                restore_actual()
                if backend == 'original-runtime':
                    assert runtime.cudaLaunchKernel(functions[backend], Dim3(gx, gy, gz), Dim3(bx, by, bz),
                                                    holders, shared, stream) == 0
                else:
                    driver.check(driver.cu.cuLaunchKernel(functions[backend], gx, gy, gz, bx, by, bz, shared,
                                                         stream, holders, None))
                actual_calls += 1
                status, observed = verify_actual(row, backend, targets, expected_values)
                all_status[row - first, BACKENDS.index(backend)] = status
                actual_values[BACKENDS.index(backend)].extend(observed.tolist())
            patch_targets.extend(targets.tolist())
            patch_values.extend(expected_values.tolist())
            offsets.append(len(patch_targets))
            history_left.extend(left)
            history_right.extend(right)
            completed += 1
        for group in groups:
            current = driver.download(group['device'], group['upload'])
            mask = np.ones(len(current), dtype=bool)
            for i, width in mutable.items():
                if i in group['indices']:
                    start = group['padding'] + values[i] - group['start']
                    mask[start:start + width] = False
            assert np.array_equal(current[mask], group['upload'][mask])
        path = output / f'queries-{first:06d}-{last:06d}.npz'
        np.savez_compressed(path, patch_offsets=np.asarray(offsets, dtype='u8'),
                            patch_targets=np.asarray(patch_targets, dtype='u4'),
                            patch_expected=np.asarray(patch_values, dtype='u4'),
                            patch_actual=np.asarray(actual_values, dtype='u4'), status=all_status,
                            F32_before=np.asarray(history_left, dtype='u4'), F32_after=np.asarray(history_right, dtype='u4'))
        chunk_reports.append({'first': first, 'last': last, 'file': str(path),
                              'sha256': hashlib.sha256(path.read_bytes()).hexdigest()})
        progress()
        print(case['tag'], 'native full-output queries', completed, '/', count, flush=True)
    assert completed == count and actual_calls == count * 3
    complete = True
finally:
    progress()
    (output / 'report.json').write_text(json.dumps({'complete': complete, 'case': case['tag'], 'queries': completed,
        'native_PTX_source_calls': actual_calls, 'original_selected_query_calls': gate_calls, 'chunks': chunk_reports,
        'words_compared_per_call': flat_seed.nbytes // 4 + dummy_seed.nbytes // 4,
        'output_contact_capacity_is_before_counter_plus_31': key != 'tangent',
        'full_outputs_losslessly_encoded_by_seeds_changed_actual_words_and_complete_GPU_checks': True,
        'all_resets_fenced': True, 'reference_sha256': REFERENCE_SHA,
        'source_host_sha256': capture_plan['source_host_sha256'], 'old_failures_rejudged': False,
        'whole_solver_complete': False}, indent=2) + '\n')
    for device in devices:
        driver.check(driver.cu.cuMemFree_v2(device))
    for group in groups:
        if 'device' in group:
            driver.check(driver.cu.cuMemFree_v2(group['device']))
    driver.check(driver.cu.cuStreamDestroy_v2(stream))
print(case['tag'], 'all native SDK/PTX/f07 full query outputs strict', actual_calls, flush=True)
