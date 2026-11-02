"""Probe actual compiled cache-return readiness without adding a fence between the library call and consumer."""
import ctypes as ct
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction import kernel_ab as k

OUTPUT = BASE / 'report.json'
assert not OUTPUT.exists()
image = ROOT / 'build/reconstruction-csrc/host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so'
expected_image = '0dabbaa7a57b57187549f814632efebdc5612095765932be112c2c9ca1868e3e'
assert hashlib.sha256(image.read_bytes()).hexdigest() == expected_image
inputs = [Path(__file__), image, ROOT / 'build/reconstruction-csrc/host-particles/build.json',
          ROOT / 'reconstruction/csrc/native/source_solver.cpp', ROOT / 'reconstruction/csrc/native/bvh_library.cu',
          ROOT / 'build/reconstruction-csrc/host-particles/source_driver.h']
for name in ('thrust/system/cuda/detail/uninitialized_fill.h', 'thrust/system/cuda/detail/parallel_for.h',
             'thrust/system/cuda/detail/util.h', 'thrust/system/cuda/detail/par.h', 'cub/util_device.cuh'):
    inputs.append(ROOT / 'build/toolchains/cuda-12.4/include' / name)
hashes = {str(p.resolve()): hashlib.sha256(p.read_bytes()).hexdigest() for p in inputs}
free = int(subprocess.check_output(
    ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
assert free >= 4096
apps = subprocess.check_output(
    ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
PTX = '''.version 7.0
.target sm_52
.address_size 64
.visible .entry check_cache(.param .u64 data, .param .u64 errors, .param .u32 payload, .param .u32 total) {
 .reg .pred %p<5>;
 .reg .b32 %r<12>;
 .reg .b64 %rd<5>;
 ld.param.u64 %rd1,[data]; ld.param.u64 %rd2,[errors];
 ld.param.u32 %r4,[payload]; ld.param.u32 %r5,[total];
 mov.u32 %r0,%tid.x; mov.u32 %r1,%ctaid.x; mov.u32 %r2,%ntid.x;
 mad.lo.u32 %r3,%r1,%r2,%r0;
 setp.ge.u32 %p0,%r3,%r5; @%p0 bra DONE;
 add.u32 %r6,%r4,256;
 setp.ge.u32 %p1,%r3,256; setp.lt.u32 %p2,%r3,%r6; and.pred %p3,%p1,%p2;
 selp.u32 %r7,0,211,%p3;
 cvt.u64.u32 %rd3,%r3; add.u64 %rd4,%rd1,%rd3;
 ld.global.u8 %r8,[%rd4]; setp.ne.u32 %p4,%r8,%r7;
 @%p4 atom.global.add.u32 %r9,[%rd2],1;
 DONE: ret;
}
.visible .entry pending_control() {
 .reg .pred %p;
 .reg .b64 %a,%b,%c;
 mov.u64 %a,%clock64;
 LOOP: mov.u64 %b,%clock64; sub.u64 %c,%b,%a; setp.lt.u64 %p,%c,20000000; @%p bra LOOP;
 ret;
}
'''
(BASE / 'consumer-and-negative-control.ptx').write_text(PTX)
driver = k.Driver()
check = driver.function(PTX, 'check_cache')
pending = driver.function(PTX, 'pending_control')
stream = ct.c_void_p()
driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
legacy = ct.c_void_p(1)
driver.check(driver.cu.cuLaunchKernel(pending, 1, 1, 1, 1, 1, 1, 0, legacy, None, None))
negative = int(driver.cu.cuStreamQuery(legacy))
assert negative == 600, ('negative control did not observe pending work', negative)
driver.check(driver.cu.cuCtxSynchronize())
spec = importlib.util.spec_from_file_location('_source_solver', image)
core = importlib.util.module_from_spec(spec)
spec.loader.exec_module(core)
assert core.source_only and not core.solver_api_ready
library = ct.CDLL(str(image))
initialize = library.source_cache_initialize
initialize.argtypes = [ct.c_void_p, ct.c_size_t, ct.c_int]
initialize.restype = ct.c_int
initialize_integer = library.source_cache_initialize_integer
initialize_integer.argtypes = [ct.c_void_p, ct.c_size_t, ct.c_int]
initialize_integer.restype = ct.c_int
widths = [4, 12, 36, 40, 4, 4, 8, 24, 8, 12, 16]
types = ['scalar', 'vec3', 'mat3', 'block-entry', 'int', 'uint', 'index2', 'aabb', 'scalar-entry', 'index3', 'vec4']
cases = [(i, name, width, n, None) for i, (name, width) in enumerate(zip(types, widths)) for n in (1, 129, 999 * 129)]
cases += [(4, 'int-one', 4, n, 1) for n in (1, 129, 999 * 129)]
cases += [(4, 'int-minus-one', 4, n, -1) for n in (1, 129, 999 * 129)]
rows, arrays = [], {}
try:
    for number, (kind, name, width, count, value) in enumerate(cases):
        size = width * count
        initial = np.full(size + 512, 211, dtype='u1')
        error = driver.upload(np.zeros(1, dtype='<u4'))
        device = driver.upload(initial)
        pointer = device.value + 256
        # No explicit wait is inserted after the library call; the query and consumer test its return contract.
        status = (initialize(ct.c_void_p(pointer), count, kind) if value is None
                  else initialize_integer(ct.c_void_p(pointer), count, value))
        assert status == 0
        query = int(driver.cu.cuStreamQuery(legacy))
        assert query == 0, (number, name, count, query)
        parameters = [ct.c_uint64(device.value), ct.c_uint64(error.value), ct.c_uint(size), ct.c_uint(size + 512)]
        holders = (ct.c_void_p * len(parameters))(*[ct.cast(ct.byref(p), ct.c_void_p) for p in parameters])
        if value is None:
            driver.check(driver.cu.cuLaunchKernel(check, (size + 767) // 256, 1, 1, 256, 1, 1, 0, stream, holders, None))
            driver.check(driver.cu.cuStreamSynchronize(stream))
            errors = driver.download(error, np.zeros(1, dtype='<u4'))
            assert int(errors[0]) == 0
        actual = driver.download(device, np.empty_like(initial))
        expected = initial.copy()
        expected[256:-256] = (0 if value is None else np.asarray([value] * count, dtype='<i4').view('u1'))
        assert actual.tobytes() == expected.tobytes()
        arrays[f'{number}/actual'] = actual
        for i, parameter in enumerate(parameters):
            arrays[f'{number}/parameter-{i}'] = np.frombuffer(bytes(parameter), dtype='u1').copy()
        rows.append({'number': number, 'type': name, 'count': count, 'payload_bytes': size,
                     'legacy_stream_query_immediately_after_library_return': query,
                     'nonblocking_consumer_checked_without_extra_fence': value is None,
                     'actual_full_payload_and_guards_equal': True})
        driver.free()
finally:
    np.savez_compressed(BASE / 'raw.npz', **arrays)
    driver.free()
    driver.check(driver.cu.cuStreamDestroy_v2(stream))
reference = ROOT / 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so'
assert str(reference.resolve()) not in Path('/proc/self/maps').read_text()
assert len(rows) == 39
for path, expected in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
report = {'cases': rows, 'negative_control_pending_status': negative, 'actual_library_calls': len(rows),
          'all39_returned_with_legacy_work_complete': True, 'actual_nonblocking_consumer_calls': 33,
          'free_memory_MiB_before_launch': free, 'compute_apps': apps, 'input_sha256': hashes,
          'raw_sha256': hashlib.sha256((BASE / 'raw.npz').read_bytes()).hexdigest(), 'reference_mapped': False,
          'production_modified': False, 'all_other_initialization_paths_proved': False, 'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(report, indent=2) + '\n')
print('Actual39 compiled cache calls returned ready;33 nonblocking consumers correct;negative query600 verified')
