"""Record every real self-contact F32 addition and contact append row on original/source PTX, losslessly packed."""
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
from reconstruction.csrc.host_api_probe import load_reference
from reconstruction.csrc.pcg_alias_replay import span_groups
from reconstruction.csrc.self_contact_operand_trace import instrument_self

folder = BASE / 'full-inputs'
plan = json.loads((folder / 'plan.json').read_text())
assert json.loads((folder / 'run.status.json').read_text())['complete']
assert json.loads((folder / 'replay.status.json').read_text())['complete']
for name, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
output = BASE / 'producer-operands'
output.mkdir(exist_ok=False)
build = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
candidate = json.loads(Path(plan['source_host_build']).read_text())
assert hashlib.sha256(Path(candidate['image']).read_bytes()).hexdigest() == plan['source_host_sha256']
driver = k.Driver()
load_reference()
spec = importlib.util.spec_from_file_location('_source_solver', candidate['image'])
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)
assert module.source_only
source = module._KernelDriver()
stream = ct.c_void_p()
driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
rows, hashes, calls, complete = [], {}, 0, False


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def reset(pointer, array):
    driver.check(driver.cu.cuMemcpyHtoD_v2(pointer, ct.c_void_p(array.ctypes.data), ct.c_size_t(array.nbytes)))


try:
    for run in plan['runs']:
        layout = json.loads((folder / run['label'] / 'trace/snapshot-layout.json').read_text())
        for stage in layout['stages']:
            key, tag = stage['key'], run['label'] + '-' + stage['key']
            path = folder / run['label'] / 'trace' / (key + '-packets/frame-00.npz')
            hashes[str(path)] = sha(path)
            with np.load(path, allow_pickle=False) as packet:
                raw = [packet[f'parameter-{i}'].tobytes() for i in range(len(stage['node']['parameter_hex']))]
                bindings = {int(i): packet[f'before-arg-{i}'].tobytes() for i in stage['sizes']}
            values = [int.from_bytes(value, 'little') for value in raw]
            dynamic = stage['dynamic_contact_span']
            contact, counter = dynamic['argument'], dynamic['counter_argument']
            before = int.from_bytes(bindings[counter], 'little')
            count = {'vf': 33703, 'ee': 100634, 'ef': 100634, 'tangent': before}[key]
            capacity = 128 if key == 'tangent' else 1152
            lanes = (count + 255) // 256 * 256
            gx, gy, gz, bx, by, bz, shared = stage['node']['geometry']
            assert (gy, gz, bx, by, bz, shared) == (1, 1, 256, 1, 1, 0)
            trace_zero = np.zeros((lanes, capacity, 16), dtype='u1')
            count_zero = np.zeros(gx * bx, dtype='u4')
            append_zero = np.zeros((lanes, 32), dtype='u4')
            groups, pointers, allocations = span_groups(values, bindings), {}, []
            try:
                for group in groups:
                    padding = 256 + group['start'] % 256
                    reserve = 437046060 if contact in group['indices'] else len(group['initial'])
                    initial = np.full(padding + reserve + 256, 211, dtype='u1')
                    initial[padding:padding + len(group['initial'])] = group['initial']
                    device = driver.upload(initial)
                    group.update(device=device, upload=initial)
                    mask = np.ones(len(initial), dtype=bool)
                    for i in group['indices']:
                        offset = padding + values[i] - group['start']
                        pointers[i] = device.value + offset
                        assert pointers[i] % 256 == values[i] % 256
                        if i in stage['outputs']:
                            mask[offset:offset + len(bindings[i])] = False
                    group['unwritten'] = mask
                parameters = [(ct.c_ubyte * len(value)).from_buffer_copy(
                    pointers[i].to_bytes(8, 'little') if i in pointers else value) for i, value in enumerate(raw)]
                trace, counts = driver.upload(trace_zero), driver.upload(count_zero)
                append_rows, append_counts = driver.upload(append_zero), driver.upload(count_zero)
                allocations = [trace, counts, append_rows, append_counts]
                texts, original_path = kernel_texts(build, stage['node']['name'])
                hashes[str(original_path)] = sha(original_path)
                probes = []
                for side in ('original', 'source'):
                    changed, sites = instrument_self(texts[side], stage['node']['name'], lanes, capacity)
                    ptx = output / (key + '-' + side + '.ptx')
                    if ptx.exists():
                        assert ptx.read_text() == changed
                    else:
                        ptx.write_text(changed)
                    function = driver.function(changed, stage['node']['name'])
                    for group in groups:
                        reset(group['device'], group['upload'])
                    for pointer, zero in zip(allocations, (trace_zero, count_zero, append_zero, count_zero), strict=True):
                        reset(pointer, zero)
                    driver.check(driver.cu.cuCtxSynchronize())
                    actual = [*parameters, *allocations]
                    holders = (ct.c_void_p * len(actual))(*[ct.cast(ct.byref(value), ct.c_void_p) for value in actual])
                    driver.check(driver.cu.cuLaunchKernel(function, gx, gy, gz, bx, by, bz, shared, stream, holders, None))
                    calls += 1
                    driver.check(driver.cu.cuStreamSynchronize(stream))
                    records, sizes = driver.download(trace, trace_zero), driver.download(counts, count_zero)
                    appends = driver.download(append_rows, append_zero)
                    append_sizes = driver.download(append_counts, count_zero)
                    if sizes[count:].any() or int(sizes.max()) > capacity or int(append_sizes.max()) > 31:
                        np.savez_compressed(output / (tag + '-' + side + '-overflow.npz'),
                                            counts=sizes, append_counts=append_sizes)
                        raise RuntimeError(tag + '/' + side + ': bounded diagnostic trace overflow')
                    assert not append_sizes[count:].any() and not records[count:].any()
                    for first in range(0, lanes, 256):
                        last = min(lanes, first + 256)
                        used = np.arange(capacity)[None, :] < sizes[first:last, None]
                        assert not records[first:last][~used].any() and not records[first:last, :, 12:].any()
                    used = np.arange(capacity)[None, :] < sizes[:lanes, None]
                    append_used = np.arange(32)[None, :] < append_sizes[:lanes, None]
                    assert not appends[~append_used].any()
                    packed_records, packed_appends = records[used], appends[append_used]
                    del records
                    arrays = {'raw-trace': packed_records, 'counts': sizes,
                              'contact-append-rows': packed_appends, 'contact-append-counts': append_sizes}
                    for i, value in enumerate(actual):
                        arrays[f'actual-parameter-{i}'] = np.frombuffer(bytes(value), dtype='u1').copy()
                    for group in groups:
                        after_group = driver.download(group['device'], group['upload'])
                        assert np.array_equal(after_group[group['unwritten']], group['upload'][group['unwritten']])
                    for i in stage['outputs']:
                        arrays[f'output-{i}'] = driver.download(ct.c_uint64(pointers[i]),
                                                             np.zeros(len(bindings[i]), dtype='u1'))
                    after = int.from_bytes(arrays.get(f'output-{counter}',
                        np.frombuffer(bindings[counter], dtype='u1')).tobytes(), 'little')
                    assert before <= after <= 131072 and int(append_sizes.sum()) == after - before
                    assert np.array_equal(np.sort(packed_appends), np.arange(before, after, dtype='u4'))
                    if contact in stage['outputs']:
                        seed = np.frombuffer(bindings[contact], dtype='u1')
                        observed = arrays[f'output-{contact}']
                        assert np.array_equal(seed[:before * 60], observed[:before * 60])
                        assert np.array_equal(seed[after * 60:], observed[after * 60:])
                    target = output / (tag + '-' + side + '.npz')
                    np.savez_compressed(target, **arrays)
                    probes.append({'side': side, 'file': str(target), 'sha256': sha(target), 'site_info': sites,
                                   'actual_atomic_records': int(sizes.sum()), 'actual_contact_appends': len(packed_appends),
                                   'maximum_records_per_lane': int(sizes.max()), 'counter_after': after,
                                   'all_unused_trace_bytes_checked_zero': True, 'readonly_and_full_tail_guard_checked': True})
                    print(tag, side, 'GPU F32/appends:', len(packed_records), len(packed_appends), flush=True)
                rows.append({'label': run['label'], 'stage': key, 'packet': str(path), 'active_lanes': count,
                             'trace_lanes': lanes, 'counts_lanes': len(count_zero), 'record_capacity': capacity,
                             'contact_span': dynamic, 'counter_before': before,
                             'outputs': {str(i): {'address': pointers[i], 'bytes': len(bindings[i])}
                                         for i in stage['outputs']}, 'probes': probes})
            finally:
                for pointer in allocations:
                    driver.check(driver.cu.cuMemFree_v2(pointer))
                for group in groups:
                    if 'device' in group:
                        driver.check(driver.cu.cuMemFree_v2(group['device']))
    assert calls == 16 and len(rows) == 8
    complete = True
finally:
    driver.check(driver.cu.cuStreamDestroy_v2(stream))
    (BASE / 'producer-operands-report.json').write_text(json.dumps({'rows': rows, 'complete': complete,
        'actual_probe_calls': calls, 'input_sha256': hashes, 'runner_sha256': sha(Path(__file__)),
        'raw_traces_losslessly_packed_in_lane_major_order_with_all_unused_slots_verified_zero': True,
        'original_F32_and_append_atomic_instructions_preserved': True, 'whole_solver_complete': False}, indent=2) + '\n')
