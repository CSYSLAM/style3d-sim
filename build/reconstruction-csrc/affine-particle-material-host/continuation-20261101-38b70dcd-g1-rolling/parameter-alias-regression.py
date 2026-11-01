"""Exercise parameter aliases that dominate loads and reject aliases that may bypass initialization."""
import hashlib
import json
from pathlib import Path
import sys

root=Path.cwd()
sys.path.insert(0,str(root))
from reconstruction.csrc.ptx_store_origins_param import store_origins

base=Path(__file__).resolve().parent
header='''.visible .entry probe(.param .align 8 .b8 view[248], .param .u64 output) {
.reg .b64 %rd<10>;
.reg .f32 %f<2>;
.reg .pred %p<2>;
ld.param.u64 %rd1, [output];
'''
load='ld.param.u64 %rd2, [%rd0+16];\nld.global.s32 %rd3, [%rd2];\n'
tail='mul.lo.u64 %rd4, %rd3, 4;\nadd.u64 %rd5, %rd1, %rd4;\nred.global.add.f32 [%rd5], %f0;\nret;\n}'
specs=[
 ('entry-prefix', 'mov.b64 %rd0, view;\n@%p0 bra L;\nL:\n'+load, True),
 ('local-block', 'bra L;\nL:\nmov.b64 %rd0, view;\n'+load, True),
 ('bypassed-definition', '@%p0 bra L;\nmov.b64 %rd0, view;\nL:\n'+load, False),
 ('predicated-definition', '@%p0 mov.b64 %rd0, view;\n'+load, False),
 ('multiple-definitions', 'mov.b64 %rd0, view;\nmov.b64 %rd0, view;\n'+load, False),
 ('computed-alias', 'mov.b64 %rd6, view;\nadd.u64 %rd0, %rd6, 8;\n'+load, False),
 ('out-of-range', 'mov.b64 %rd0, view;\nld.param.u64 %rd2, [%rd0+248];\n'+load, False),
 ('vector-out-of-range', 'mov.b64 %rd0, view;\nld.param.v2.u64 {%rd2,%rd3}, [%rd0+240];\n'+load, False),
]
cases=[]
for label,body,expected in specs:
    text=header+body+tail
    try:
        result=store_origins(text,[(0,16),(1,0)])
        actual=True
        assert result['potential_written_pointer_fields']==[(1,0)]
        assert result['bounds_proven_by_this_analysis'] is False
    except AssertionError as error:
        actual=False
        reason=str(error)
    assert actual==expected,label
    cases.append({'case':label,'accepted':actual,'expected':expected,'PTX':text,
                  'reason':None if actual else reason})
report={'cases':cases,'case_count':len(cases),'all_expected':True,'GPU_context_created':False,
        'analysis_sha256':hashlib.sha256((root/'reconstruction/csrc/ptx_store_origins_param.py').read_bytes()).hexdigest(),
        'runner_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),'whole_solver_complete':False}
(base/'parameter-alias-regression.json').write_text(json.dumps(report,indent=2)+'\n')
print('Parameter alias safety cases passed:',len(cases),flush=True)
