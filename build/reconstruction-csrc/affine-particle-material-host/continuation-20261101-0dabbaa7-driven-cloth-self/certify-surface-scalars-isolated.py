"""Certify every captured/aggregate scalar with real GPU F32 atomics and each thread's same-target order preserved."""
import ctypes as ct
import hashlib
import heapq
import json
from pathlib import Path
import sys
import os
import subprocess
import time

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction import kernel_ab as k
from reconstruction.csrc.particle_reduction_certificates import SERIAL_PTX

out = BASE / 'surface-scalar-certificates-isolated'
out.mkdir(exist_ok=False)
packets, hashes, expected_calls = [], {}, 0
hashes[str(Path(__file__))] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
for folder in sorted((BASE / 'first-surface-replays').glob('*/*')):
    if not (folder / 'report.json').exists():
        continue
    report = json.loads((folder / 'report.json').read_text())
    raw = json.loads((folder / 'atomic-operands.json').read_text())
    assert report['all_isolated_contact_outputs_equal'] and report['all_per_contact_atomic_operand_sequences_identical']
    assert raw['original']['thread_operands'] == raw['source']['thread_operands']
    for path in (folder / 'report.json', folder / 'atomic-operands.json', folder / 'outputs.npz'):
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    terms = [[] for _ in range(144)]
    for lane, operations in enumerate(raw['original']['thread_operands']):
        for ordinal, (target, bits) in enumerate(operations):
            terms[target].append((lane, ordinal, bits))
    with np.load(folder / 'outputs.npz', allow_pickle=False) as data:
        before = data['before'].copy()
        vectors = {'captured': data['captured_after'].copy(),
                   **{name: data[name + '-aggregate'].copy() for name in
                      ('original-runtime', 'original-ptx', 'source-ptx')}}
    certificates = []
    for scalar, original_terms in enumerate(terms):
        values = np.asarray([bits for _, _, bits in original_terms], dtype='<u4').view('<f4')
        selected = {}
        for name, target in vectors.items():
            selected.setdefault(int(target.view('<u4')[scalar]), []).append(name)
        for target_word, origins in selected.items():
            if not len(values):
                assert int(before.view('<u4')[scalar]) == target_word
                certificates.append({'scalar': scalar, 'target_bits': target_word, 'origins': origins,
                                     'untouched': True, 'order': [], 'terms': []})
                continue
            proposal = report['witnesses'][origins[0]][scalar]
            assert proposal['exact_float32_witness'] and proposal['target_bits'] == target_word
            # Zero writes may be scheduled freely for proposal construction; the final full order is checked exactly.
            nonzero = [i for i in proposal['order'] if original_terms[i][2] & 0x7fffffff]
            by_lane, edges = {}, [set() for _ in original_terms]
            for index, (lane, ordinal, _) in enumerate(original_terms):
                by_lane.setdefault(lane, []).append((ordinal, index))
            assert all(sum(bool(original_terms[i][2] & 0x7fffffff) for _, i in chain) <= 1
                       for chain in by_lane.values())
            for chain in by_lane.values():
                chain.sort()
                for a, b in zip(chain, chain[1:]):
                    edges[a[1]].add(b[1])
            for a, b in zip(nonzero, nonzero[1:]):
                edges[a].add(b)
            degree = [0] * len(original_terms)
            for successors in edges:
                for index in successors:
                    degree[index] += 1
            ready, order = [i for i, n in enumerate(degree) if not n], []
            heapq.heapify(ready)
            while ready:
                index = heapq.heappop(ready)
                order.append(index)
                for nxt in edges[index]:
                    degree[nxt] -= 1
                    if not degree[nxt]:
                        heapq.heappush(ready, nxt)
            assert len(order) == len(values)
            history, total = [], before[scalar]
            for index in order:
                history.append(total)
                total = np.float32(total + values[index])
            assert int(total.view('<u4')) == target_word
            certificates.append({'scalar': scalar, 'target_bits': target_word, 'origins': origins, 'untouched': False,
                                 'order': order, 'terms': original_terms,
                                 'before_bits': int(before.view('<u4')[scalar]),
                                 'CPU_history_bits': np.asarray(history, dtype='<f4').view('<u4').tolist()})
            expected_calls += 1
    packets.append({'folder': str(folder), 'certificates': certificates})
assert len(packets) == 4
plan = {'input_sha256': hashes, 'packets': packets, 'expected_GPU_calls': expected_calls,
        'per_thread_same_target_order_respected': True, 'cross_target_joint_global_order_proven': False,
        'fixed_C8_failures_reclassified': False, 'production_changed': False, 'whole_solver_complete': False}
(out / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
(out / 'serial-atomic.ptx').write_text(SERIAL_PTX)
waits = []
(out / 'waiter-identity.json').write_text(json.dumps({'pid': os.getpid(),
    'boot_id': Path('/proc/sys/kernel/random/boot_id').read_text().strip(),
    'start_ticks': int(Path('/proc/self/stat').read_text().split(') ', 1)[1].split()[19]),
    'GPU_context_not_created_before_idle_check': True}, indent=2) + '\n')
while True:
    active = subprocess.check_output(
        ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
    waits.append({'observed_epoch': time.time(), 'compute_apps': active})
    (out / 'GPU-waits.json').write_text(json.dumps({'waits': waits, 'GPU_worker_started': not bool(active)}, indent=2) + '\n')
    if not active:
        break
    time.sleep(5)
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
driver = k.Driver()
function = driver.function(SERIAL_PTX, 'audit_serial_atomic')
stream = ct.c_void_p()
driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
rows, calls, error = [], 0, None
try:
    for packet_index, packet in enumerate(packets):
        arrays, checks = {}, []
        maximum = max(len(c['terms']) for c in packet['certificates'])
        lengths = (maximum * 4 + 512, maximum * 4 + 512, 516, maximum * 4 + 512)
        devices = [driver.upload(np.full(n, 211, dtype='u1')) for n in lengths]
        for index, certificate in enumerate(packet['certificates']):
            if certificate['untouched']:
                continue
            n = len(certificate['terms'])
            values = np.asarray([row[2] for row in certificate['terms']], dtype='<u4')
            order = np.asarray(certificate['order'], dtype='<u4')
            buffers = [np.full(size, 211, dtype='u1') for size in lengths]
            buffers[0][256:256 + n * 4] = values.view('u1')
            buffers[1][256:256 + n * 4] = order.view('u1')
            buffers[2][256:260] = np.asarray([certificate['before_bits']], dtype='<u4').view('u1')
            for device, before in zip(devices, buffers):
                driver.check(driver.cu.cuMemcpyHtoD_v2(device, ct.c_void_p(before.ctypes.data), before.nbytes))
            params = [*(ct.c_uint64(p.value + 256) for p in devices), ct.c_uint(n)]
            holders = (ct.c_void_p * len(params))(*[ct.cast(ct.byref(value), ct.c_void_p) for value in params])
            driver.check(driver.cu.cuLaunchKernel(function, 1, 1, 1, 1, 1, 1, 0, stream, holders, None))
            driver.check(driver.cu.cuStreamSynchronize(stream))
            calls += 1
            after = [driver.download(device, before) for device, before in zip(devices, buffers)]
            assert after[0].tobytes() == buffers[0].tobytes() and after[1].tobytes() == buffers[1].tobytes()
            assert int(after[2][256:260].copy().view('<u4')[0]) == certificate['target_bits']
            history = np.asarray(certificate['CPU_history_bits'], dtype='<u4').tobytes()
            assert after[3][256:256 + n * 4].tobytes() == history
            for i, end in ((2, 260), (3, 256 + n * 4)):
                assert after[i][:256].tobytes() == buffers[i][:256].tobytes()
                assert after[i][end:].tobytes() == buffers[i][end:].tobytes()
            tag = f'certificate-{index:03d}'
            arrays.update({tag + '-buffer-' + str(i): value.copy() for i, value in enumerate(after)})
            arrays.update({tag + '-parameter-' + str(i): np.frombuffer(bytes(value), dtype='u1').copy()
                           for i, value in enumerate(params)})
            checks.append({'index': index, 'scalar': certificate['scalar'], 'target_bits': certificate['target_bits'],
                           'actual_GPU_scalar_and_history_equal': True})
        path = out / f'packet-{packet_index}-GPU.npz'
        np.savez_compressed(path, **arrays)
        rows.append({'packet': packet['folder'], 'actual_GPU_checks': checks, 'output': str(path),
                     'output_sha256': hashlib.sha256(path.read_bytes()).hexdigest()})
        driver.free()
        print('Actual surface scalar GPU proofs', packet_index + 1, '/4;calls', calls, flush=True)
    for name, expected in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
except BaseException as problem:
    error = f'{type(problem).__name__}: {problem}'
    raise
finally:
    result = {'packets': rows, 'actual_calls': calls, 'expected_calls': expected_calls, 'error': error,
              'complete': len(rows) == 4 and error is None and calls == expected_calls,
              'cross_target_joint_global_order_proven': False, 'actual_production_order_inferred': False,
              'fixed_C8_failures_reclassified': False, 'production_changed': False, 'whole_solver_complete': False}
    (out / 'report.json').write_text(json.dumps(result, indent=2) + '\n')
    driver.free()
    driver.check(driver.cu.cuStreamDestroy_v2(stream))
assert result['complete']
print('All complete captured/aggregate vectors covered by same-target GPU scalar proofs;calls', calls, flush=True)
