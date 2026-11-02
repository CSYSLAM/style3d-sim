"""Record real PCG atomic operands and verify exact addition-order certificates on the GPU."""
import ctypes as ct
import hashlib
import json
from pathlib import Path

import numpy as np

from .surface_atomic_operands import instrument


# A single diagnostic lane executes the proposed order using the real global F32 atomic instruction.
SERIAL_PTX = '''.version 8.4
.target sm_52
.address_size 64
.visible .entry audit_serial_atomic(
    .param .u64 values, .param .u64 order, .param .u64 total, .param .u64 history, .param .u32 count)
{
    .reg .b64 %rd<12>;
    .reg .b32 %r<5>;
    .reg .f32 %f<3>;
    .reg .pred %p<2>;
    ld.param.u64 %rd0, [values];
    ld.param.u64 %rd1, [order];
    ld.param.u64 %rd2, [total];
    ld.param.u64 %rd3, [history];
    ld.param.u32 %r0, [count];
    mov.u32 %r1, 0;
LOOP:
    mul.wide.u32 %rd4, %r1, 4;
    add.u64 %rd5, %rd1, %rd4;
    ld.global.u32 %r2, [%rd5];
    mul.wide.u32 %rd6, %r2, 4;
    add.u64 %rd7, %rd0, %rd6;
    ld.global.f32 %f0, [%rd7];
    atom.global.add.f32 %f1, [%rd2], %f0;
    add.u64 %rd8, %rd3, %rd4;
    st.global.f32 [%rd8], %f1;
    membar.gl;
    add.u32 %r1, %r1, 1;
    setp.lt.u32 %p0, %r1, %r0;
    @%p0 bra LOOP;
    ret;
}
'''


class Certificates:
    def __init__(self, driver, stream, original, source, output):
        self.driver, self.stream = driver, stream
        self.modules = {'original-ptx': original, 'source-ptx': source}
        self.output, self.functions, self.arrays, self.cases = output, {}, {}, []
        (output / 'serial-atomic.ptx').write_text(SERIAL_PTX)
        self.serial = driver.function(SERIAL_PTX, 'audit_serial_atomic')

    def launch(self, function, parameters, grid, block):
        args = (ct.c_void_p * len(parameters))(*[ct.cast(ct.byref(v), ct.c_void_p) for v in parameters])
        self.driver.check(self.driver.cu.cuLaunchKernel(function, grid, 1, 1, block, 1, 1, 0, self.stream, args, None))
        self.driver.check(self.driver.cu.cuStreamSynchronize(self.stream))

    def verify(self, tag, name, parameters, reset, pointwise, expected, counter, initial, target, n, grid, block):
        assert len(initial) == len(target) == 4 and int.from_bytes(initial, 'little') == 0
        assert n > 0 and grid * block >= n
        row = {'tag': tag, 'target_bits': int.from_bytes(target, 'little'), 'passed': False}
        self.cases.append(row)
        lanes = grid * block
        trace_zero, count_zero = np.zeros((lanes, 128, 16), dtype='u1'), np.zeros(lanes, dtype='u4')
        trace, counts = self.driver.upload(trace_zero), self.driver.upload(count_zero)
        observed = []
        for backend in ('original-ptx', 'source-ptx'):
            key = (backend, name)
            if key not in self.functions:
                module = self.modules[backend][name]
                changed, sites = instrument(module, name)
                assert sites == 1
                path = self.output / ('instrumented-' + backend + '-' + hashlib.sha256(name.encode()).hexdigest()[:12] + '.ptx')
                path.write_text(changed)
                self.functions[key] = self.driver.function(changed, name)
            reset()
            for pointer, zero in ((trace, trace_zero), (counts, count_zero)):
                self.driver.check(self.driver.cu.cuMemcpyHtoD_v2(pointer, ct.c_void_p(zero.ctypes.data), zero.nbytes))
            self.launch(self.functions[key], [*parameters, trace, counts], grid, block)
            sizes = self.driver.download(counts, count_zero)
            records = self.driver.download(trace, trace_zero)[:n, 0].copy()
            addresses = records[:, :8].copy().view('u8').reshape(-1)
            values = records[:, 8:12].copy().view('f4').reshape(-1)
            self.arrays[tag + '-' + backend + '-raw'] = values.copy()
            assert np.all(sizes[:n] == 1) and not sizes[n:].any()
            assert np.all(addresses == counter.value), 'One group with the actual counter target is required'
            assert self.driver.download(pointwise, np.zeros(len(expected), dtype='u1')).tobytes() == expected
            assert np.isfinite(values).all() and np.all(values >= 0)
            observed.append(values)
        assert observed[0].tobytes() == observed[1].tobytes(), 'The original/source atomic operands differ'
        values = observed[0]
        normalized = values.copy()
        tiny = (np.abs(normalized) > 0) & (np.abs(normalized) < np.finfo('f4').tiny)
        normalized.view('u4')[tiny] &= np.uint32(0x80000000)
        target_bits = int.from_bytes(target, 'little')
        rng = np.random.default_rng(int(hashlib.sha256(tag.encode()).hexdigest()[:16], 16))
        order = None
        for trial in range(10000):
            proposed = np.arange(n) if trial == 0 else rng.permutation(n)
            result = np.cumsum(normalized[proposed], dtype='f4')[-1]
            if int(result.view('u4')) == target_bits:
                order = proposed.astype('u4')
                break
        row.update(equal_recorded_operands=True, subnormal_operands=int(tiny.sum()), search_trials=trial + 1)
        self.arrays[tag + '-ftz-operands'] = normalized
        if order is None:
            row['unexplained_bits'] = target_bits
            return row
        before = np.empty(n, dtype='f4')
        accumulator = np.float32(0)
        for index, lane in enumerate(order):
            before[index] = accumulator
            accumulator = np.float32(accumulator + normalized[lane])
        assert int(accumulator.view('u4')) == target_bits
        pointers = [self.driver.upload(array) for array in
                    (values, order, np.zeros(1, dtype='f4'), np.zeros(n, dtype='f4'))]
        self.launch(self.serial, [*pointers, ct.c_uint(n)], 1, 1)
        result = self.driver.download(pointers[2], np.zeros(1, dtype='f4'))
        history = self.driver.download(pointers[3], np.zeros(n, dtype='f4'))
        assert result.tobytes() == target and history.tobytes() == before.tobytes()
        self.arrays[tag + '-order'] = order
        self.arrays[tag + '-hardware-before-values'] = history
        row.update(passed=True, hardware_atomic_order_verified=True, actual_production_order_inferred=False)
        return row

    def save(self):
        np.savez_compressed(self.output / 'reduction-certificates.npz', **self.arrays)
        (self.output / 'reduction-certificates.json').write_text(json.dumps({
            'cases': self.cases, 'all_passed': bool(self.cases) and all(row['passed'] for row in self.cases),
            'FTZ_reference': 'https://docs.nvidia.com/cuda/archive/12.6.0/parallel-thread-execution/index.html',
            'production_order_inferred': False, 'cohort_expanded': False, 'whole_solver_complete': False,
            'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}, indent=2) + '\n')
