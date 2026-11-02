"""Record real original/source atomic operands for contact and first PCG kernels on all complete captured inputs."""
from collections import Counter
import ctypes as ct
import hashlib
import json
from pathlib import Path
import sys
import subprocess

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction import kernel_ab as k
from reconstruction.csrc.g1_contact_rhs_replay import kernel_texts
from reconstruction.csrc.pcg_alias_replay import span_groups
from reconstruction.csrc.surface_atomic_operands import instrument

PHASE = BASE / 'capture'
OUTPUT = PHASE / 'atomic-operands'
OUTPUT.mkdir(exist_ok=False)
plan_path = PHASE / 'full-input-replays/plan.json'
plan = json.loads(plan_path.read_text())
hashes = dict(plan['input_sha256'])
kinds = {'22evaluate_contact_force', '24evaluate_contact_tangent',
         '23precondition_and_reduce', '26multiply_matrix_and_reduce'}
selected = [(i, packet) for i, packet in enumerate(plan['packets']) if packet['stage']['kind'] in kinds]
assert len(selected) == 8
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
build = json.loads(build_path.read_text())
for path in (Path(__file__), plan_path, build_path, ROOT / 'reconstruction/csrc/surface_atomic_operands.py'):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
(OUTPUT / 'serial-input-lock.json').write_text(json.dumps({'input_sha256': hashes}, indent=2) + '\n')
free = int(subprocess.check_output(
    ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
assert free >= 4096
apps = subprocess.check_output(
    ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
driver = k.Driver()
stream = ct.c_void_p()
driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
rows = []
try:
    for number, (packet_index, packet) in enumerate(selected):
        stage = packet['stage']
        with np.load(packet['input'], allow_pickle=False) as data:
            before = {b['label']: data[stage['key'] + '/before/' + b['label']].tobytes() for b in stage['bindings']}
        addresses = {b['label']: b['address'] for b in stage['bindings']}
        pointers, groups = {}, []
        for group in span_groups(addresses, before):
            prefix = 256 + group['start'] % 256
            initial = np.full(prefix + len(group['initial']) + 256, 211, dtype='u1')
            initial[prefix:prefix + len(group['initial'])] = group['initial']
            device = driver.upload(initial)
            mask = np.ones(len(initial), dtype=bool)
            for label in group['indices']:
                offset = prefix + addresses[label] - group['start']
                pointers[label] = device.value + offset
                assert pointers[label] % 256 == addresses[label] % 256
                if label in stage['outputs']:
                    mask[offset:offset + len(before[label])] = False
            groups.append((device, initial, mask, group, prefix))
        node = stage['node']
        gx, gy, gz, bx, by, bz, shared = node['geometry']
        assert gy == gz == by == bz == 1
        lanes = gx * bx
        trace_bytes = lanes * 128 * 16
        count_bytes = lanes * 4
        trace_initial = np.full(trace_bytes + 512, 211, dtype='u1')
        trace_initial[256:-256] = 0
        count_initial = np.full(count_bytes + 512, 211, dtype='u1')
        count_initial[256:-256] = 0
        trace_device, count_device = driver.upload(trace_initial), driver.upload(count_initial)
        raw = [bytearray.fromhex(value) for value in node['parameter_hex']]
        for binding in stage['bindings']:
            i = binding['argument']
            assert int.from_bytes(raw[i], 'little') == binding['address']
            raw[i] = bytearray(pointers[binding['label']].to_bytes(8, 'little'))
        raw += [bytearray((d.value + 256).to_bytes(8, 'little')) for d in (trace_device, count_device)]
        parameters = [(ct.c_ubyte * len(value)).from_buffer_copy(value) for value in raw]
        holders = (ct.c_void_p * len(parameters))(*[ct.cast(ct.byref(v), ct.c_void_p) for v in parameters])
        arrays = {'actual-parameter-' + str(i): np.frombuffer(bytes(v), dtype='u1') for i, v in enumerate(parameters)}
        modules, original_path = kernel_texts(build, node['name'])
        hashes[str(original_path.resolve())] = hashlib.sha256(original_path.read_bytes()).hexdigest()
        operands, counts_by_side, static_sites = {}, {}, {}
        for side in ('original', 'source'):
            changed, sites = instrument(modules[side], node['name'])
            (OUTPUT / f'{number}-{side}-instrumented.ptx').write_text(changed)
            function = driver.function(changed, node['name'])
            for device, initial in [(g[0], g[1]) for g in groups] + [
                    (trace_device, trace_initial), (count_device, count_initial)]:
                driver.check(driver.cu.cuMemcpyHtoD_v2(device, ct.c_void_p(initial.ctypes.data), initial.nbytes))
            driver.check(driver.cu.cuLaunchKernel(function, gx, gy, gz, bx, by, bz, shared, stream, holders, None))
            driver.check(driver.cu.cuStreamSynchronize(stream))
            trace = driver.download(trace_device, np.empty_like(trace_initial))
            count = driver.download(count_device, np.empty_like(count_initial))
            for actual, initial in ((trace, trace_initial), (count, count_initial)):
                assert actual[:256].tobytes() == initial[:256].tobytes()
                assert actual[-256:].tobytes() == initial[-256:].tobytes()
            arrays[side + '-raw-trace'], arrays[side + '-raw-counts'] = trace.copy(), count.copy()
            counts = count[256:-256].copy().view('<u4')
            records = trace[256:-256].reshape(lanes, 128, 16)
            assert counts.max() <= 128
            output_ranges = [(label, pointers[label], len(before[label])) for label in stage['outputs']]
            thread_rows = []
            for lane in range(lanes):
                thread = []
                for ordinal in range(int(counts[lane])):
                    address = int.from_bytes(records[lane, ordinal, :8].tobytes(), 'little')
                    value = int.from_bytes(records[lane, ordinal, 8:12].tobytes(), 'little')
                    matches = [(label, (address - start) // 4) for label, start, size in output_ranges
                               if start <= address < start + size and (address - start) % 4 == 0]
                    assert len(matches) == 1, (number, lane, ordinal, address)
                    thread.append([*matches[0], value])
                thread_rows.append(thread)
            operands[side] = thread_rows
            counts_by_side[side], static_sites[side] = counts.tolist(), sites
            for index, (device, initial, mask, _, _) in enumerate(groups):
                actual = driver.download(device, np.empty_like(initial))
                assert actual[mask].tobytes() == initial[mask].tobytes()
                arrays[side + '-raw-group-' + str(index)] = actual.copy()
        equal_counts = counts_by_side['original'] == counts_by_side['source']
        equal_sequences = operands['original'] == operands['source']
        equal_multisets = all(Counter(map(tuple, a)) == Counter(map(tuple, b))
                              for a, b in zip(operands['original'], operands['source']))
        path = OUTPUT / f'{number}-raw.npz'
        np.savez_compressed(path, **arrays)
        row = {'packet_index': packet_index, 'stage': stage, 'kind': stage['kind'], 'captured_input': packet['input'],
               'counts_equal': equal_counts, 'per_thread_sequences_equal': equal_sequences,
               'per_thread_operand_multisets_equal': equal_multisets,
               'atomic_operations': sum(counts_by_side['original']), 'static_sites': static_sites,
               'thread_operands': operands, 'counts': counts_by_side,
               'raw_output': str(path), 'raw_output_sha256': hashlib.sha256(path.read_bytes()).hexdigest(),
               'groups': [{'device_base': g[0].value, 'prefix': g[4], 'start': g[3]['start'],
                           'bytes': len(g[3]['initial']), 'labels': g[3]['indices']} for g in groups],
               'pointers': pointers, 'all_readonly_and_guards_equal': True,
               'production_global_thread_order_inferred': False}
        rows.append(row)
        print(stage['kind'], 'atomics', row['atomic_operations'], 'sequence_equal', equal_sequences,
              'multisets_equal', equal_multisets, flush=True)
        driver.free()
    for name, expected in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
    report = {'rows': rows, 'input_sha256': hashes, 'actual_instrumented_GPU_calls': 16,
              'free_memory_MiB_before_launch': free, 'compute_apps': apps,
              'production_math_changed': False, 'frozen_failures_reclassified': False, 'whole_solver_complete': False}
    (OUTPUT / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
finally:
    driver.free()
    driver.check(driver.cu.cuStreamDestroy_v2(stream))
