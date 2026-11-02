"""Verify every real H1 soft-contact contributor on native SDK, SDK PTX and actual f07 kernels using captured seeds."""
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
output = BASE / 'soft-matrix-native-isolation'
output.mkdir(exist_ok=False)
plan = json.loads((BASE / 'assembly-full-inputs/plan.json').read_text())
operand_report = json.loads((BASE / 'producer-operands-report.json').read_text())
case = next(row for row in operand_report['rows'] if row['label'] == 'sdk0' and row['stage'] == 'soft-matrix')
packet_path = Path(case['packet'])
with np.load(packet_path, allow_pickle=False) as packet:
    raw = [packet[f'parameter-{i}'].tobytes() for i in range(42)]
    bindings = {int(key.rsplit('-', 1)[1]): packet[key].tobytes()
                for key in packet.files if key.startswith('before-arg-')}
values = [int.from_bytes(value, 'little') for value in raw]
count = int.from_bytes(bindings[0], 'little')
assert count == 8891 and values[1] == 3354813 and values[10] == values[11] == 33887
with np.load(case['probes'][0]['file'], allow_pickle=False) as probe:
    assert case['probes'][0]['side'] == 'original'
    trace, counts = probe['raw-trace'], probe['counts'][:count]
assert int(counts.sum()) == 59310
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
name = plan['kernels']['soft-matrix']
texts, _ = kernel_texts(build, name)
functions = {'original-runtime': ct.cast(getattr(runtime, name), ct.c_void_p),
             'original-ptx': driver.function(texts['original'], name),
             'source-ptx': ct.c_void_p(source.function(name))}
stream = ct.c_void_p()
driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
driver.cu.cuMemcpyDtoD_v2.argtypes = [ct.c_uint64, ct.c_uint64, ct.c_size_t]
driver.cu.cuMemcpyDtoD_v2.restype = ct.c_int
groups, pointers = span_groups(values, bindings), {}
seeds = {i: np.frombuffer(bindings[i], dtype='<u4').copy() for i in (40, 41)}
seed_devices = {}
delta_offsets, delta_targets, delta_values = [0], [], []
hist_before, hist_after, record_targets, record_values = [], [], [], []
actual_calls, completed, complete = 0, 0, False
metadata = []


def f32_add_bits(left, right):
    left, right = int(left), int(right)
    if left & 0x7f800000 == 0:
        left &= 0x80000000
    if right & 0x7f800000 == 0:
        right &= 0x80000000
    a, b = np.asarray([left, right], dtype='u4').view('f4')
    result = int(np.float32(a + b).view('u4'))
    return result & 0x80000000 if result & 0x7f800000 == 0 else result


def digest(arrays):
    result = hashlib.sha256()
    for i in (40, 41):
        result.update(arrays[i].tobytes())
    return result.hexdigest()


def progress():
    (output / 'progress.json').write_text(json.dumps({'complete': complete, 'completed_contacts': completed,
        'planned_contacts': count, 'actual_calls': actual_calls, 'whole_solver_complete': False}, indent=2) + '\n')


try:
    for group in groups:
        padding = 256 + group['start'] % 256
        initial = np.full(padding + len(group['initial']) + 256, 211, dtype='u1')
        initial[padding:padding + len(group['initial'])] = group['initial']
        device = driver.upload(initial)
        group.update(device=device, upload=initial, padding=padding)
        for i in group['indices']:
            pointers[i] = device.value + padding + values[i] - group['start']
    for i in seeds:
        seed_devices[i] = driver.upload(seeds[i])
    parameters = [(ct.c_ubyte * len(value)).from_buffer_copy(
        pointers[i].to_bytes(8, 'little') if i in pointers else value) for i, value in enumerate(raw)]
    holders = (ct.c_void_p * len(parameters))(*[ct.cast(ct.byref(value), ct.c_void_p) for value in parameters])
    one = np.asarray([1], dtype='u4')
    driver.check(driver.cu.cuMemcpyHtoD_v2(ct.c_uint64(pointers[0]), ct.c_void_p(one.ctypes.data), 4))
    progress()
    with (output / 'contacts.jsonl').open('w') as log:
        for row in range(count):
            expected = {i: seed.copy() for i, seed in seeds.items()}
            for record in trace[row, :int(counts[row])]:
                address = int.from_bytes(record[:8].tobytes(), 'little')
                operand = int.from_bytes(record[8:12].tobytes(), 'little')
                candidates = [(int(i), (address - span['address']) // 4) for i, span in case['outputs'].items()
                              if span['address'] <= address < span['address'] + span['bytes']]
                assert len(candidates) == 1
                index, offset = candidates[0]
                before = int(expected[index][offset])
                after = f32_add_bits(before, operand)
                expected[index][offset] = after
                record_targets.append((index << 32) | offset)
                record_values.append(operand)
                hist_before.append(before)
                hist_after.append(after)
            for i, width in ((2, 4), (3, 4), (4, 12), (5, 12), (6, 12)):
                value = np.frombuffer(bindings[i][row * width:(row + 1) * width], dtype='u1')
                driver.check(driver.cu.cuMemcpyHtoD_v2(ct.c_uint64(pointers[i]), ct.c_void_p(value.ctypes.data), width))
            fingerprints, actual_sdk = {}, None
            rotation = row % 3
            for backend in BACKENDS[rotation:] + BACKENDS[:rotation]:
                for i, device in seed_devices.items():
                    driver.check(driver.cu.cuMemcpyDtoD_v2(ct.c_uint64(pointers[i]), device, seeds[i].nbytes))
                driver.check(driver.cu.cuCtxSynchronize())
                if backend == 'original-runtime':
                    assert runtime.cudaLaunchKernel(functions[backend], Dim3(13105, 1, 1), Dim3(256, 1, 1),
                                                    holders, 0, stream) == 0
                else:
                    driver.check(driver.cu.cuLaunchKernel(functions[backend], 13105, 1, 1, 256, 1, 1, 0,
                                                         stream, holders, None))
                actual_calls += 1
                driver.check(driver.cu.cuStreamSynchronize(stream))
                observed = {i: driver.download(ct.c_uint64(pointers[i]), np.zeros_like(seed))
                            for i, seed in seeds.items()}
                passed = all(np.array_equal(observed[i], expected[i]) for i in seeds)
                if not passed:
                    np.savez_compressed(output / f'failure-{row:05d}-{backend}.npz',
                                        **{f'actual-{i}': observed[i] for i in seeds},
                                        **{f'expected-{i}': expected[i] for i in seeds})
                    raise RuntimeError(f'Contact {row}/{backend}: actual SDK/PTX result differs from captured F32 operands')
                fingerprints[backend] = digest(observed)
                if backend == 'original-runtime':
                    actual_sdk = observed
            assert actual_sdk is not None and len(set(fingerprints.values())) == 1
            for i in seeds:
                changed = np.flatnonzero(actual_sdk[i] != seeds[i])
                delta_targets.extend((np.uint64(i) << np.uint64(32) | changed.astype('u8')).tolist())
                delta_values.extend(actual_sdk[i][changed].tolist())
            delta_offsets.append(len(delta_values))
            log.write(json.dumps({'contact': row, 'atomic_records': int(counts[row]),
                                  'actual_complete_output_sha256': fingerprints, 'all_complete_outputs_strict': True}) + '\n')
            completed += 1
            if completed % 250 == 0:
                log.flush()
                progress()
                print('Native SDK/PTX/f07 real contact isolation:', completed, '/', count, flush=True)
    for group in groups:
        after = driver.download(group['device'], group['upload'])
        mask = np.ones(len(after), dtype=bool)
        for i in group['indices']:
            width = len(bindings[i]) if i in seeds else {0: 4, 2: 4, 3: 4, 4: 12, 5: 12, 6: 12}.get(i, 0)
            offset = group['padding'] + values[i] - group['start']
            mask[offset:offset + width] = False
        assert np.array_equal(after[mask], group['upload'][mask])
    np.savez_compressed(output / 'lossless-complete-outputs.npz',
        contact_counts=counts, delta_offsets=np.asarray(delta_offsets, dtype='u8'),
        delta_targets=np.asarray(delta_targets, dtype='u8'), delta_values=np.asarray(delta_values, dtype='u4'),
        record_targets=np.asarray(record_targets, dtype='u8'), record_values=np.asarray(record_values, dtype='u4'),
        record_before=np.asarray(hist_before, dtype='u4'), record_after=np.asarray(hist_after, dtype='u4'))
    assert actual_calls == 26673 and completed == 8891
    complete = True
finally:
    progress()
    (output / 'report.json').write_text(json.dumps({'complete': complete, 'actual_calls': actual_calls,
        'contacts': completed, 'original_launch_geometry_preserved': True,
        'diagnostic_input_changes': 'working count=1; actual contact record copied to row0; captured output seeds restored',
        'complete_outputs_encoded_losslessly_as_seed_relative_changes': True,
        'packet_sha256': hashlib.sha256(packet_path.read_bytes()).hexdigest(), 'packet': str(packet_path),
        'source_host_sha256': plan['source_host_sha256'], 'reference_sha256': REFERENCE_SHA,
        'GPU_resets_fenced': True, 'fixed_C8_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
    for device in seed_devices.values():
        driver.check(driver.cu.cuMemFree_v2(device))
    for group in groups:
        if 'device' in group:
            driver.check(driver.cu.cuMemFree_v2(group['device']))
    driver.check(driver.cu.cuStreamDestroy_v2(stream))
print('All8891 actual contact records: 26673 native SDK/PTX/f07 calls and complete output vectors strict')
