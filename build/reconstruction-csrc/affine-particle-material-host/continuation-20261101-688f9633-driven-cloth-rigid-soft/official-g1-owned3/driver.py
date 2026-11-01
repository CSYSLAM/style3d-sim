"""Audit complete owned launch parameters on the unchanged G1 example; keep the first A/B failure intact."""
from pathlib import Path
import hashlib,json,subprocess,sys
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.csrc.audit_cudahook import compare,schemas
base=Path(__file__).resolve().parent
out=base/'official-g1-owned3';out.mkdir(exist_ok=False)
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
  code=subprocess.run(command,env={**clean_env(),'LD_PRELOAD':str(hook),'CUDAHOOK_DIR':str(folder)},
                      stdout=log,stderr=subprocess.STDOUT,timeout=1800).returncode
 assert code==0,(side,code)
 print(side,'completed',flush=True)
metadata=compare(out/'original/launches.txt',out/'source/launches.txt',schemas()[0])
coverage=sum(json.loads((out/'source/capture.launches.json').read_text()).values())==metadata['right_launches']
report={'complete_owned_metadata':metadata,'source_coverage_equal':coverage,'whole_solver_complete':False,
        'source_sha256':json.loads(saved)['extension_sha256'],'acceptance_candidates_replaced':False}
(out/'report.json').write_text(json.dumps(report,indent=2)+'\n')
print('G1 owned metadata',metadata['equal'],'coverage',coverage,flush=True)
