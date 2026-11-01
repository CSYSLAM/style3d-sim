"""Audit complete owned launch parameters on the unchanged G1 example; keep the first A/B failure intact."""
from pathlib import Path
import hashlib,json,subprocess,sys
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.csrc.audit_cudahook import compare,schemas
base=Path(__file__).resolve().parent
out=base/'official-g1-shape-types3';out.mkdir(exist_ok=False)
(out/'driver.py').write_bytes(Path(__file__).read_bytes())
hook=root/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes()
(out/'build.json').write_bytes(saved)
for side in ('original','source'):
 assert build.read_bytes()==saved
 folder=out/side;folder.mkdir()
 command=[sys.executable,'-m','reconstruction.csrc.demo_source_ab','--worker',side,'--tag','capture',
          '--example','examples/example_robot_g1.py','--frames','3','--output',str(folder),
          '--','--solver','synreal','--world-count','1']
 (folder/'command.json').write_text(json.dumps(command,indent=2)+'\n')
 with (folder/'run.log').open('w') as log:
  code=subprocess.run(command,env={**clean_env(),'LD_PRELOAD':str(hook),'CUDAHOOK_DIR':str(folder),'DEMO_POINTERS':'1','CUDAHOOK_DUMP':'22evaluate_contact_force=12:420;24evaluate_contact_tangent=12:420;27evaluate_soft_contact_force=13:420;42multiply_soft_contact_hessian_off_diagonal=8:420'},
                      stdout=log,stderr=subprocess.STDOUT,timeout=1800).returncode
 assert code==0,(side,code)
 print(side,'completed',flush=True)
metadata=compare(out/'original/launches.txt',out/'source/launches.txt',schemas()[0])
coverage=sum(json.loads((out/'source/capture.launches.json').read_text()).values())==metadata['right_launches']
report={'complete_owned_metadata':metadata,'source_coverage_equal':coverage,'whole_solver_complete':False,
        'source_sha256':json.loads(saved)['extension_sha256'],'acceptance_candidates_replaced':False}
(out/'report.json').write_text(json.dumps(report,indent=2)+'\n')
print('G1 owned metadata',metadata['equal'],'coverage',coverage,flush=True)

payloads={}
for token,arg in [('22evaluate_contact_force', 12), ('24evaluate_contact_tangent', 12), ('27evaluate_soft_contact_force', 13), ('42multiply_soft_contact_hessian_off_diagonal', 8)]:
    name=f'dump_{token}_pre_arg{arg}.bin'
    left,right=[(out/side/name).read_bytes() for side in ('original','source')]
    assert len(left)==len(right)==420 and left==right
    payloads[token]={'argument':arg,'actual_bytes_equal':True,'bytes':len(left),
                     'sha256':hashlib.sha256(left).hexdigest()}
(out/'shape-types-pointee-proof.json').write_text(json.dumps(payloads,indent=2)+'\n')
print('Actual model.shape_types[105] bytes equal at all four kernel argument locations',flush=True)
