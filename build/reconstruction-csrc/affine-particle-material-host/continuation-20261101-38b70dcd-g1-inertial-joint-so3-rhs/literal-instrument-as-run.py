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
    pattern = r'red\.global\.add\.f32\s+\[(%rd\d+)([+-]\d+)?\],\s*(%f\d+|0f[0-9a-fA-F]{8});'
    count = len(re.findall(pattern, entry))
    assert count > 0 and count == len(re.findall(r'\bred\.global\.add\.f32\b', entry))
    # A predicated reduction needs equally predicated instrumentation; this recorder handles only unpredicated sites.
    assert not re.search(r'@!?%p\d+\s+red\.global\.add\.f32\b', entry)

    def replace(match):
        offset = int(match[2] or 0)
        value = match[3]
        record = ('st.global.u32 [%audit_record+8], 0x' + value[2:] + ';' if value.startswith('0f')
                  else 'st.global.f32 [%audit_record+8], ' + value + ';')
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
{record}
add.u32 %audit_ordinal, %audit_ordinal, 1;
st.global.u32 [%audit_count_ptr], %audit_ordinal;
'''

    changed = re.sub(pattern, replace, entry)
    return module.replace(original, changed), count
