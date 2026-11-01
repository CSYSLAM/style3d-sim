"""Capture every enabled plain constraint in mixed scenes before lifting any source guards."""
import hashlib,json
from pathlib import Path
import subprocess,sys
import numpy as np
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.csrc.audit_cudahook import schemas
from reconstruction.csrc.host_api_probe import REFERENCE_SHA
base=Path(__file__).resolve().parent
output=base/'original32';output.mkdir(exist_ok=False)
fixture=root/'reconstruction/csrc/plain_body_mixed_scene.py'
hook=root/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes()
(output/'build.json').write_bytes(saved)
inputs=(Path(__file__),fixture,hook,root/'reconstruction/csrc/demo_source_ab.py')
hashes={str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in inputs}
schema,_=schemas()
sets={'spring-line':('spring','point-line'),'spring-distance':('spring','distance'),
 'line-distance':('point-line','distance'),'all':('spring','point-line','distance')}
specs={'spring':('26evaluate_body_spring_force',12),'point-line':('30evaluate_body_point_line_force',14),
 'distance':('39evaluate_body_distance_constraint_force',11)}
rows=[]
for kind,enabled in sets.items():
 for worlds in (1,3):
  for mode in ('newton','pd'):
   for block in (False,True):
    name=f'{kind}-w{worlds}-{mode}-b{int(block)}';folder=output/name;folder.mkdir()
    extra=['--constraints',kind,'--worlds',str(worlds),'--seed',str(worlds),'--mode',mode]
    if block:extra.append('--body-block')
    dump=[]
    for constraint in enabled:
     token,index=specs[constraint];assert schema[token][index]=='pointer'
     dump.append(f'{token}={index}:{8*worlds*12}')
    command=[sys.executable,'-m','reconstruction.csrc.demo_source_ab','--worker','original','--tag','capture',
     '--example',str(fixture),'--frames','3','--output',str(folder),'--',*extra]
    (folder/'command.json').write_text(json.dumps(command,indent=2)+'\n')
    assert build.read_bytes()==saved
    assert all(hashlib.sha256(Path(p).read_bytes()).hexdigest()==h for p,h in hashes.items())
    with (folder/'run.log').open('w') as log:
     code=subprocess.run(command,env={**clean_env(),'LD_PRELOAD':str(hook),'CUDAHOOK_DIR':str(folder),
      'CUDAHOOK_DUMP':';'.join(dump),'CUDAHOOK_DUMP_LIMIT':'1'},stdout=log,stderr=subprocess.STDOUT,timeout=900).returncode
    row={'case':name,'exit':code}
    if not code:
     runtime=json.loads((folder/'capture.runtime.json').read_text());assert runtime['image_sha256']==REFERENCE_SHA
     with np.load(folder/'capture.npz') as data:
      row['finite']=all(np.isfinite(data[k]).all() for k in data.files)
      row['body_moved']=not np.array_equal(data['body_q'][0],data['body_q'][-1])
     launches=(folder/'launches.txt').read_text().splitlines();row['owned_calls']=len(launches)
     checks={}
     for constraint in enabled:
      token,index=specs[constraint]
      checks[constraint]={'force_calls':sum(token in line.split()[1] for line in launches),
       'changes_rhs':(folder/f'dump_{token}_pre_arg{index}.bin').read_bytes()!=
                     (folder/f'dump_{token}_post_arg{index}.bin').read_bytes()}
     row['constraints']=checks
     assert all(v['force_calls']>0 and v['changes_rhs'] for v in checks.values())
    rows.append(row)
    (output/'report.json').write_text(json.dumps({'cases':rows,'sha256':hashes,'guard_changed':False,
     'reference_sha256':REFERENCE_SHA},indent=2)+'\n')
    print(name,code,row.get('constraints'),flush=True)
    assert code==0 and row['finite'] and row['body_moved']
