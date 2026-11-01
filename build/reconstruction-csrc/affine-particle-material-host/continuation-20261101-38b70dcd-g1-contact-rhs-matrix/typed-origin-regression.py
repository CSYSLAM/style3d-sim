"""Ensure the load-width correction handles real scalar extension without accepting indirect pointer stores."""
import hashlib
import json
from pathlib import Path
import sys

root = Path.cwd()
sys.path.insert(0, str(root))
from reconstruction.csrc.ptx_store_origins import store_origins as old_origins
from reconstruction.csrc.ptx_store_origins_typed import store_origins

base = Path(__file__).resolve().parent
header = '''.visible .entry probe(.param .u64 output, .param .u64 indices) {
.reg .b64 %rd<8>;
.reg .b32 %r<8>;
.reg .f32 %f<2>;
ld.param.u64 %rd0, [output];
ld.param.u64 %rd1, [indices];
'''
cases = []


def run(label, body, accepted, original_accepted=None):
    text = header + body + '\nret;\n}'
    answer = None
    try:
        answer = store_origins(text, [(0, 0), (1, 0)])
        actual = True
    except AssertionError as error:
        actual, reason = False, str(error)
    assert actual == accepted, label
    if answer:
        assert answer['potential_written_pointer_fields'] == [(0, 0)]
        assert answer['bounds_proven_by_this_analysis'] is False
    if original_accepted is not None:
        try:
            old_origins(text, [(0, 0), (1, 0)])
            previous = True
        except AssertionError:
            previous = False
        assert previous == original_accepted, label
    cases.append({'case': label, 'accepted': actual, 'expected': accepted,
                  'rejection': reason if not actual else None, 'PTX': text})


for kind in ('s32', 'u32', 's16', 'u16', 'u8', 'b32'):
    run('extended-scalar-' + kind,
        'ld.global.' + kind + ' %rd2, [%rd1];\n'
        'mul.lo.u64 %rd3, %rd2, 4;\nadd.u64 %rd4, %rd0, %rd3;\nred.global.add.f32 [%rd4], %f0;',
        True, False)
for kind in ('u64', 'b64', 's64'):
    run('indirect-loaded-pointer-' + kind,
        'ld.global.' + kind + ' %rd2, [%rd1];\nred.global.add.f32 [%rd2], %f0;', False, False)
run('indirect-pointer-added-to-base',
    'ld.global.u64 %rd2, [%rd1];\nadd.u64 %rd4, %rd0, %rd2;\nred.global.add.f32 [%rd4], %f0;', False, False)
run('narrow-load-as-entire-address', 'ld.global.u32 %rd2, [%rd1];\nred.global.add.f32 [%rd2], %f0;', False, False)
run('indirect-local-pointer', 'ld.local.u64 %rd2, [%rd1];\nred.global.add.f32 [%rd2], %f0;', False, False)
run('unknown-generic-store', 'st.f32 [%rd0], %f0;', False, False)
run('noninlined-call', 'call helper, ();\nred.global.add.f32 [%rd0], %f0;', False, False)
run('unchanged-direct-base', 'add.u64 %rd4, %rd0, 8;\nred.global.add.f32 [%rd4], %f0;', True, True)
result = {'cases': cases, 'case_count': len(cases), 'all_expected': True, 'GPU_context_created': False,
          'bounds_claimed': False, 'production_changed': False, 'whole_solver_complete': False,
          'typed_analyzer_sha256': hashlib.sha256(
              (root / 'reconstruction/csrc/ptx_store_origins_typed.py').read_bytes()).hexdigest(),
          'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(base / 'typed-origin-regression.json').write_text(json.dumps(result, indent=2) + '\n')
print('Typed PTX store-origin safety regressions passed:', len(cases), 'cases; noGPU context.')
