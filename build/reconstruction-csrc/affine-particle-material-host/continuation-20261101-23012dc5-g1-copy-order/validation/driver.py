"""Serial current-image regression and direct public-core graph tests, with immutable source hashes."""
from pathlib import Path
import hashlib,json,subprocess,sys
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
base=Path(__file__).resolve().parent
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes();meta=json.loads(saved)
assert meta['extension_sha256'].startswith('141c18f6')
core_path=Path((base/'build-core.log').read_text().splitlines()[-1])
core_build=core_path.parent/'build.json';core=json.loads(core_build.read_text())
assert core['source_host_sha256']==meta['extension_sha256']
output=base/'validation';output.mkdir(exist_ok=False)
(output/'build.json').write_bytes(saved);(output/'core-build.json').write_bytes(core_build.read_bytes())
(output/'driver.py').write_bytes(Path(__file__).read_bytes())
status={'complete':False,'completed':[],'running':None,'source_sha256':meta['extension_sha256'],'whole_solver_complete':False}
jobs=[]
for name,example,frames,extra in [('core-dzhanibekov60','example_basic_dzhanibekov',60,[]),
 ('core-plastic-bag3','example_plastic_bag',3,[]),('core-g1-graph60','example_robot_g1',60,['--solver','synreal','--world-count','1'])]:
 jobs.append((name,['-m','reconstruction.core_demo','--core-build',str(core_build),'--report',str(output/(name+'.json')),
                   'examples/'+example+'.py','--viewer','null','--num-frames',str(frames),'--test',*extra]))
jobs.append(('regression74',['-m','reconstruction.csrc.joint_continuation_regression','--output',str(output/'regression74')]))
for name,args in jobs:
 assert build.read_bytes()==saved
 for path,digest in meta['sources'].items():assert hashlib.sha256((root/path).read_bytes()).hexdigest()==digest
 status['running']=name;(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
 command=[sys.executable,*args];(output/(name+'.command.json')).write_text(json.dumps(command,indent=2)+'\n')
 with (output/(name+'.log')).open('w') as log:
  code=subprocess.run(command,env=clean_env(),stdout=log,stderr=subprocess.STDOUT,timeout=14400).returncode
 if name=='regression74':assert code in (0,1) and json.loads((output/'regression74/status.json').read_text())['complete']
 else:
  result=json.loads((output/(name+'.json')).read_text());assert code==result['exit']==0
  assert result['source_only'] and result['public_core_abi'] and not result['reference_solver_mapped']
  assert result['source_sha256']==core['extension_sha256']
 status['completed'].append({'name':name,'exit':code});print(name,code,flush=True)
status['complete'],status['running']=True,None
(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
