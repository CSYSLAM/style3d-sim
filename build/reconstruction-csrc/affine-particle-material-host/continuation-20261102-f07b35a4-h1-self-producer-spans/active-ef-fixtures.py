"""Run existing disjoint EF/EE branch fixtures on actual SDK/PTX/f07, plus active five-point tangent grid strides."""
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
from reconstruction.csrc import edge_accumulate_cases
from reconstruction.csrc.g1_contact_rhs_replay import kernel_texts
from reconstruction.csrc.host_api_probe import REFERENCE, REFERENCE_SHA, load_reference
from reconstruction.csrc.pcg_same_buffer_probe import Dim3

output = BASE / 'active-ef-fixtures'
output.mkdir(exist_ok=False)
capture = json.loads((BASE / 'full-inputs/plan.json').read_text())
build = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
candidate = json.loads(Path(capture['source_host_build']).read_text())
assert hashlib.sha256(Path(candidate['image']).read_bytes()).hexdigest() == capture['source_host_sha256']
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
texts, functions = {}, {}
for key in ('ee', 'ef', 'tangent'):
    symbol = capture['kernels'][key]
    texts[symbol], _ = kernel_texts(build, symbol)
    functions[symbol] = {'original-runtime': ct.cast(getattr(runtime, symbol), ct.c_void_p),
                         'original-ptx': driver.function(texts[symbol]['original'], symbol),
                         'source': ct.c_void_p(source.function(symbol))}


def current_modules(suffix):
    symbol = next(name for name in texts if name.startswith('_ZN7synreal21self_collision_kernel' + suffix))
    return symbol, (texts[symbol]['original'], texts[symbol]['source'])


edge_accumulate_cases.modules = current_modules
records, comparisons, complete = [], {}, False


class GuardedDriver:
    def __init__(self, mode):
        self.mode, self.allocations = mode, {}

    def upload(self, array):
        contiguous = np.ascontiguousarray(array)
        data = contiguous.view('u1').ravel()
        initial = np.full(256 + data.nbytes + 256, 211, dtype='u1')
        initial[256:256 + data.nbytes] = data
        device = driver.upload(initial)
        pointer = ct.c_uint64(device.value + 256)
        self.allocations[pointer.value] = {'device': device, 'initial': initial, 'bytes': data.nbytes,
                                           'dtype': contiguous.dtype.str, 'shape': contiguous.shape}
        return pointer

    def download(self, pointer, like):
        return driver.download(pointer, like)

    def function(self, text, symbol):
        assert text in texts[symbol].values()
        side = 'source' if text == texts[symbol]['source'] else self.mode
        return symbol, side

    def launch(self, descriptor, threads, params, block=256, grid=None):
        symbol, side = descriptor
        gx = max(1, (threads + block - 1) // block) if grid is None else grid
        out_start = 3 if 'multiply_contact_tangents' in symbol else (9 if 'accumulate_edge_edge' in symbol else 10)
        out_indices = {out_start} if out_start == 3 else set(range(out_start, out_start + 4))
        arrays, pointers = {}, {}
        for i, param in enumerate(params):
            arrays[f'parameter-{i}'] = np.frombuffer(bytes(param), dtype='u1').copy()
            if isinstance(param, ct.c_uint64) and param.value in self.allocations:
                allocation = self.allocations[param.value]
                arrays[f'before-{i}'] = driver.download(param, np.zeros(allocation['bytes'], dtype='u1'))
                pointers[i] = allocation
        holders = (ct.c_void_p * len(params))(*[ct.cast(ct.byref(param), ct.c_void_p) for param in params])
        driver.check(driver.cu.cuCtxSynchronize())
        if side == 'original-runtime':
            assert runtime.cudaLaunchKernel(functions[symbol][side], Dim3(gx, 1, 1), Dim3(block, 1, 1),
                                            holders, 0, None) == 0
        else:
            driver.check(driver.cu.cuLaunchKernel(functions[symbol][side], gx, 1, 1, block, 1, 1, 0,
                                                 None, holders, None))
        driver.check(driver.cu.cuCtxSynchronize())
        for i, allocation in pointers.items():
            raw_after = driver.download(allocation['device'], allocation['initial'])
            assert np.array_equal(raw_after[:256], allocation['initial'][:256])
            assert np.array_equal(raw_after[-256:], allocation['initial'][-256:])
            arrays[f'after-{i}'] = raw_after[256:-256].copy()
            if i not in out_indices:
                assert np.array_equal(arrays[f'before-{i}'], arrays[f'after-{i}'])
        path = output / f'call-{len(records):03d}.npz'
        np.savez_compressed(path, **arrays)
        records.append({'mode': self.mode, 'side': side, 'symbol': symbol, 'geometry': [gx, 1, 1, block, 1, 1, 0],
                        'output_indices': sorted(i for i in out_indices if i in pointers), 'file': str(path),
                        'sha256': hashlib.sha256(path.read_bytes()).hexdigest(),
                        'all_readonly_inputs_and_physical_guards_unchanged': True})

    def free(self):
        for allocation in self.allocations.values():
            driver.check(driver.cu.cuMemFree_v2(allocation['device']))


try:
    for mode in ('original-runtime', 'original-ptx'):
        guarded = GuardedDriver(mode)
        try:
            result = edge_accumulate_cases.run(guarded, np.random.default_rng(20261102))
            comparisons[mode + '-edge-branches'] = result
            assert all(row['bitwise_equal'] for row in result.values()), mode
            rng = np.random.default_rng(20261103)
            count = 3000
            contacts = np.zeros(count, k.selfcollision.CONTACT_TANGENT)
            contacts['count'] = rng.choice([4, 5], count)
            contacts['ids'] = np.arange(count * 5, dtype='i4').reshape(count, 5)
            contacts['w'] = rng.normal(size=(count, 5))
            normal = rng.normal(size=(count, 3))
            normal /= np.linalg.norm(normal, axis=1, keepdims=True)
            contacts['n'], contacts['k'] = normal, rng.uniform(0, 100, count)
            direction = rng.normal(size=(count * 5, 3)).astype('f4')
            product0 = rng.normal(size=direction.shape).astype('f4')
            product0[::2] = 0
            symbol = capture['kernels']['tangent']
            shared = [guarded.upload(contacts), guarded.upload(np.asarray([count], dtype='u4')),
                      guarded.upload(direction)]
            for grid in (1, 7, 256):
                outputs = []
                for side in ('original', 'source'):
                    product = guarded.upload(product0)
                    guarded.launch(guarded.function(texts[symbol][side], symbol), count, [*shared, product], grid=grid)
                    actual = guarded.download(product, product0)
                    ids = contacts['ids'][contacts['count'] == 4, 4]
                    assert np.array_equal(actual[ids].view('u4'), product0[ids].view('u4'))
                    outputs.append(actual)
                assert np.array_equal(outputs[0].view('u4'), outputs[1].view('u4'))
                comparisons[f'{mode}-tangent-grid{grid}'] = {'bitwise_equal': True,
                    'four_point_contacts': int((contacts['count'] == 4).sum()),
                    'five_point_contacts': int((contacts['count'] == 5).sum())}
            print(mode, 'actual active EF/EE branch fixtures and4/5point tangent all strict', flush=True)
        finally:
            guarded.free()
    assert len(records) == 76
    complete = True
finally:
    (output / 'report.json').write_text(json.dumps({'complete': complete, 'actual_GPU_calls': len(records),
        'calls': records, 'comparisons': comparisons, 'reference_sha256': REFERENCE_SHA,
        'source_host_sha256': capture['source_host_sha256'], 'existing_branch_fixture_source_sha256':
        hashlib.sha256((ROOT / 'reconstruction/csrc/edge_accumulate_cases.py').read_bytes()).hexdigest(),
        'all_H2D_uploads_context_fenced': True, 'old_failures_rejudged': False,
        'whole_solver_complete': False}, indent=2) + '\n')
