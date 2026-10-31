"""Diagnostic PTX operand recording; preserve the production source and original shared library verbatim."""
import ctypes as ct
import hashlib
import re

import numpy as np

from .library_entries import entries


def instrument(module, symbol):
    original = entries(module)[symbol]
    assert 'audit_trace' not in original
    end = original.index(')')
    entry = original[:end] + ',\n.param .u64 audit_trace,\n.param .u64 audit_counts\n' + original[end:]
    entry = entry.replace('{', '''{
.reg .b32 %audit_tid, %audit_block, %audit_ntid, %audit_lane, %audit_ordinal;
.reg .b64 %audit_base, %audit_count_base, %audit_count_ptr, %audit_offset;
.reg .b64 %audit_record, %audit_address, %audit_lane_offset;
''', 1)
    pattern = r'red\.global\.add\.f32\s+\[(%rd\d+)([+-]\d+)?\],\s*(%f\d+);'
    count = len(re.findall(pattern, entry))
    assert count > 0

    def replace(match):
        offset = int(match[2] or 0)
        return match[0] + f'''
mov.u32 %audit_tid, %tid.x;
mov.u32 %audit_block, %ctaid.x;
mov.u32 %audit_ntid, %ntid.x;
mad.lo.s32 %audit_lane, %audit_block, %audit_ntid, %audit_tid;
ld.param.u64 %audit_base, [audit_trace];
ld.param.u64 %audit_count_base, [audit_counts];
mul.wide.u32 %audit_offset, %audit_lane, 4;
add.u64 %audit_count_ptr, %audit_count_base, %audit_offset;
ld.global.u32 %audit_ordinal, [%audit_count_ptr];
mul.wide.u32 %audit_lane_offset, %audit_lane, 2048;
add.u64 %audit_record, %audit_base, %audit_lane_offset;
mul.wide.u32 %audit_offset, %audit_ordinal, 16;
add.u64 %audit_record, %audit_record, %audit_offset;
add.u64 %audit_address, {match[1]}, {offset};
st.global.u64 [%audit_record], %audit_address;
st.global.f32 [%audit_record+8], {match[3]};
add.u32 %audit_ordinal, %audit_ordinal, 1;
st.global.u32 [%audit_count_ptr], %audit_ordinal;
'''

    changed = re.sub(pattern, replace, entry)
    return module.replace(original, changed), count


def capture(driver, module, symbol, view, output, initial, stream, count=45, direction=None):
    instrumented, sites = instrument(module, symbol)
    # The matrix accumulator has at most 7 targets times 9 components times 2 parts per contact.
    trace = driver.upload(np.zeros((256, 128, 16), dtype='u1'))
    counts = driver.upload(np.zeros(256, dtype='u4'))
    function = driver.function(instrumented, symbol)
    driver.check(driver.cu.cuMemcpyHtoD_v2(output, ct.c_void_p(initial.ctypes.data), initial.nbytes))
    packed = ct.create_string_buffer(bytes(view))
    pointers = [direction] if direction is not None else []
    pointers += [output, trace, counts]
    args = (ct.c_void_p * (1 + len(pointers)))(ct.cast(packed, ct.c_void_p),
        *[ct.cast(ct.byref(p), ct.c_void_p) for p in pointers])
    driver.check(driver.cu.cuLaunchKernel(function, 1, 1, 1, 256, 1, 1, 0, stream, args, None))
    driver.check(driver.cu.cuStreamSynchronize(stream))
    sizes = driver.download(counts, np.zeros(256, dtype='u4'))
    data = driver.download(trace, np.zeros((256, 128, 16), dtype='u1'))
    assert sizes.max() <= 128 and not sizes[count:].any()
    rows = []
    for lane in range(count):
        values = []
        for ordinal in range(sizes[lane]):
            record = data[lane, ordinal]
            address = int.from_bytes(record[:8].tobytes(), 'little')
            assert output.value <= address < output.value + initial.nbytes
            assert (address - output.value) % 4 == 0
            values.append([(address - output.value) // 4, int.from_bytes(record[8:12].tobytes(), 'little')])
        rows.append(values)
    return {'thread_operands': rows, 'static_atomic_sites': sites,
            'instrumented_ptx_sha256': hashlib.sha256(instrumented.encode()).hexdigest(),
            'production_ptx_sha256': hashlib.sha256(module.encode()).hexdigest()}, driver.download(output, initial)
