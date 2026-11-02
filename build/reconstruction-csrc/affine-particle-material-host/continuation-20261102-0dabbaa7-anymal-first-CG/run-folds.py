"""Verify every prepared differing hessian scalar with real guarded GPU F32 atomics;do not alter production kernels."""
import ctypes as ct
import hashlib
import json
from pathlib import Path
import subprocess
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction import kernel_ab as k
from reconstruction.csrc.particle_reduction_certificates import SERIAL_PTX

PHASE = BASE / 'capture/scalar-folds'
OUTPUT = PHASE / 'GPU-report.json'
assert not OUTPUT.exists()
plan = json.loads((PHASE / 'plan.json').read_text())
hashes = dict(plan['input_sha256'])
for path in (Path(__file__), PHASE / 'plan.json', ROOT / 'reconstruction/csrc/particle_reduction_certificates.py'):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for path, expected in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected
free = int(subprocess.check_output(
    ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
assert free >= 4096
apps = subprocess.check_output(
    ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
(PHASE / 'serial-atomic.ptx').write_text(SERIAL_PTX)
driver = k.Driver()
serial = driver.function(SERIAL_PTX, 'audit_serial_atomic')
stream = ct.c_void_p()
driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
rows, arrays, error = [], {}, None
try:
    with np.load(PHASE / 'inputs.npz', allow_pickle=False) as inputs:
        for row in plan['requests']:
            number = row['number']
            values = inputs[str(number) + '/values'].copy()
            order = inputs[str(number) + '/order'].copy()
            history = inputs[str(number) + '/expected-history'].copy()
            assert len(values) == len(order) == len(history)
            initial_target = np.asarray([row['initial_bits']], dtype='<u4').view('<f4')
            raw_inputs = [values, order, initial_target, np.zeros(len(values), dtype='<f4')]
            guarded, parameters = [], []
            for value in raw_inputs:
                initial = np.full(value.nbytes + 512, 211, dtype='u1')
                initial[256:-256] = value.view('u1')
                device = driver.upload(initial)
                guarded.append((device, initial))
                parameters.append(ct.c_uint64(device.value + 256))
            parameters.append(ct.c_uint(len(values)))
            holders = (ct.c_void_p * len(parameters))(*[ct.cast(ct.byref(p), ct.c_void_p) for p in parameters])
            driver.check(driver.cu.cuLaunchKernel(serial, 1, 1, 1, 1, 1, 1, 0, stream, holders, None))
            driver.check(driver.cu.cuStreamSynchronize(stream))
            after = []
            for index, (device, initial) in enumerate(guarded):
                actual = driver.download(device, np.empty_like(initial))
                assert actual[:256].tobytes() == initial[:256].tobytes()
                assert actual[-256:].tobytes() == initial[-256:].tobytes()
                if index < 2:
                    assert actual.tobytes() == initial.tobytes()
                arrays[f'{number}/raw-{index}'] = actual.copy()
                after.append(actual[256:-256].copy())
            assert int(after[2].view('<u4')[0]) == row['target_bits']
            assert after[3].tobytes() == history.tobytes()
            for index, parameter in enumerate(parameters):
                arrays[f'{number}/parameter-{index}'] = np.frombuffer(bytes(parameter), dtype='u1').copy()
            rows.append({'number': number, 'target_bits': row['target_bits'], 'history_words': len(history),
                         'actual_GPU_target_and_history_equal': True, 'all_readonly_and_guards_equal': True})
            driver.free()
    for path, expected in hashes.items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected
except BaseException as problem:
    error = f'{type(problem).__name__}: {problem}'
    raise
finally:
    np.savez_compressed(PHASE / 'GPU-raw.npz', **arrays)
    report = {'complete': len(rows) == len(plan['requests']) and error is None, 'error': error,
              'actual_GPU_calls': len(rows), 'rows': rows, 'input_sha256': hashes,
              'free_memory_MiB_before_launch': free, 'other_compute_apps_before_launch': apps,
              'GPU_admission_policy': 'available-memory', 'original_frozen_failure_reclassified': False,
              'production_global_order_inferred': False, 'whole_solver_complete': False}
    OUTPUT.write_text(json.dumps(report, indent=2) + '\n')
    driver.free()
    driver.check(driver.cu.cuStreamDestroy_v2(stream))
print('Real GPU contact folds:', len(rows), 'targets/histories exact;58 words covered', flush=True)
