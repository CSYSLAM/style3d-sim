"""Record real self-contact F32 additions and returned append rows without changing any original instruction."""
import re

from .library_entries import entries
from .surface_atomic_operands import instrument


def instrument_self(module, symbol, trace_lanes, capacity):
    original = entries(module)[symbol]
    changed, sites = instrument(module, symbol)
    entry = entries(changed)[symbol]
    anchor = '.reg .b64 %audit_record, %audit_address, %audit_lane_offset;'
    assert entry.count(anchor) == 1
    entry = entry.replace(anchor, anchor + '''
.reg .pred %audit_outside, %audit_contact_outside;
.reg .b32 %audit_contact_ordinal;
.reg .b64 %audit_contact_base, %audit_contact_count_base, %audit_contact_count_ptr;
.reg .b64 %audit_contact_offset, %audit_contact_record;
''', 1)
    assert entry.count('.param .u64 audit_counts') == 1
    entry = entry.replace('.param .u64 audit_counts', '.param .u64 audit_counts,\n.param .u64 audit_contacts,\n'
                          '.param .u64 audit_contact_counts', 1)
    stride = 'mul.wide.u32 %audit_lane_offset, %audit_lane, 2048;'
    assert entry.count(stride) == sites
    entry = entry.replace(stride, f'mul.wide.u32 %audit_lane_offset, %audit_lane, {capacity * 16};')
    pattern = (r'(ld\.global\.u32 %audit_ordinal, \[%audit_count_ptr\];)'
               r'(.*?)'
               r'(add\.u32 %audit_ordinal, %audit_ordinal, 1;)')
    seen = 0

    def bounded(match):
        nonlocal seen
        label = 'SELF_AUDIT_SKIP_' + str(seen)
        seen += 1
        checks = (f'\nsetp.ge.u32 %audit_outside, %audit_lane, {trace_lanes};\n'
                  f'@%audit_outside bra {label};\n'
                  f'setp.ge.u32 %audit_outside, %audit_ordinal, {capacity};\n'
                  f'@%audit_outside bra {label};\n')
        return match[1] + checks + match[2] + label + ':\n' + match[3]

    entry = re.sub(pattern, bounded, entry, flags=re.S)
    assert seen == sites
    atomic = r'atom\.global\.add\.u32\s+(%r\d+),\s*\[(%rd\d+)\],\s*1;'
    matches = list(re.finditer(atomic, entry))
    assert len(matches) == (0 if 'multiply_contact_tangents' in symbol else 1)
    assert not re.search(r'@!?%p\d+\s+atom\.global\.add\.u32', entry)

    def append_row(match):
        return match[0] + f'''
mov.u32 %audit_tid, %tid.x;
mov.u32 %audit_block, %ctaid.x;
mov.u32 %audit_ntid, %ntid.x;
mad.lo.s32 %audit_lane, %audit_block, %audit_ntid, %audit_tid;
ld.param.u64 %audit_contact_base, [audit_contacts];
ld.param.u64 %audit_contact_count_base, [audit_contact_counts];
mul.wide.u32 %audit_contact_offset, %audit_lane, 4;
add.u64 %audit_contact_count_ptr, %audit_contact_count_base, %audit_contact_offset;
ld.global.u32 %audit_contact_ordinal, [%audit_contact_count_ptr];
setp.ge.u32 %audit_contact_outside, %audit_lane, {trace_lanes};
@%audit_contact_outside bra SELF_AUDIT_CONTACT_SKIP;
setp.ge.u32 %audit_contact_outside, %audit_contact_ordinal, 32;
@%audit_contact_outside bra SELF_AUDIT_CONTACT_SKIP;
mul.wide.u32 %audit_contact_offset, %audit_lane, 128;
add.u64 %audit_contact_record, %audit_contact_base, %audit_contact_offset;
mul.wide.u32 %audit_contact_offset, %audit_contact_ordinal, 4;
add.u64 %audit_contact_record, %audit_contact_record, %audit_contact_offset;
st.global.u32 [%audit_contact_record], {match[1]};
SELF_AUDIT_CONTACT_SKIP:
add.u32 %audit_contact_ordinal, %audit_contact_ordinal, 1;
st.global.u32 [%audit_contact_count_ptr], %audit_contact_ordinal;
'''

    entry = re.sub(atomic, append_row, entry)
    result = changed.replace(entries(changed)[symbol], entry)
    assert len(re.findall(r'\bred\.global\.add\.f32\b', original)) == sites
    assert len(re.findall(r'\bred\.global\.add\.f32\b', entries(result)[symbol])) == sites
    assert len(re.findall(atomic, original)) == len(re.findall(atomic, entries(result)[symbol]))
    return result, {'F32_static_sites': sites, 'append_static_sites': len(matches), 'F32_record_capacity': capacity}
