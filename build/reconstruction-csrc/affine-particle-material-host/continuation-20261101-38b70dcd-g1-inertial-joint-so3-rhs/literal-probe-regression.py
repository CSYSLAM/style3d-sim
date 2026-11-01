"""Check exact literal-bit recording and rejection cases before any GPU launch."""
import hashlib
import json
from pathlib import Path
import re
import sys

sys.path.insert(0, str(Path.cwd()))
from reconstruction.csrc.ptx_atomic_literal_probe import instrument256

BASE = Path(__file__).resolve().parent
cases = []
for literal in ('0f00000000', '0f80000000', '0f7fC01234'):
    text = ('.version 8.4\n.target sm_52\n.address_size 64\n'
            '.visible .entry fixture(.param .u64 fixture_param_0)\n{\n'
            '.reg .b64 %rd1;\n.reg .f32 %f1;\n'
            'ld.param.u64 %rd1, [fixture_param_0];\n'
            'mov.f32 %f1, 0f3f800000;\n'
            'red.global.add.f32 [%rd1], %f1;\n'
            'red.global.add.f32 [%rd1+4], ' + literal + ';\nret;\n}')
    changed, sites = instrument256(text, 'fixture')
    assert sites == 2
    assert 'st.global.u32 [%audit_record+8], 0x' + literal[2:] + ';' in changed
    assert 'st.global.f32 [%audit_record+8], %f1;' in changed
    assert changed.count('mul.wide.u32 %audit_lane_offset, %audit_lane, 4096;') == 2
    cases.append({'literal': literal, 'bits': int(literal[2:], 16), 'passed': True})
for name, replacement in (
    ('predicated', '@%p0 red.global.add.f32 [%rd1+4], 0f00000000;'),
    ('unsupported_decimal', 'red.global.add.f32 [%rd1+4], 0.0;'),
    ('unsupported_other_register', 'red.global.add.f32 [%rd1+4], %r1;'),
):
    bad = re.sub(r'red\.global\.add\.f32 \[%rd1\+4\], [^;]+;', replacement, text)
    try:
        instrument256(bad, 'fixture')
    except AssertionError:
        cases.append({'rejected': name, 'passed': True})
    else:
        raise AssertionError(('Unsupported reduction accepted', name))
report = {'cases': cases, 'count': len(cases), 'GPU_context_created': False,
          'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
assert len(cases) == 6
output = BASE / 'literal-probe-regression.json'
assert not output.exists()
output.write_text(json.dumps(report, indent=2) + '\n')
print('Six literal operand positive/negative CPU checks passed', flush=True)
