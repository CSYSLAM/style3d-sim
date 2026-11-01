"""Actual SDK driven-cloth schedules before opening either constructor or non-SO3 guards."""
from pathlib import Path
import hashlib,json,subprocess,sys
import numpy as np
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.csrc.audit_cudahook import schemas
from reconstruction.csrc.host_api_probe import REFERENCE_SHA
base=Path(__file__).resolve().parent;out=base/'original16';out.mkdir(exist_ok=False)
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes();(out/'build.json').write_bytes(saved)
fixture=root/'reconstruction/csrc/driven_cloth_scene.py';hook=root/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
hashes={str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in (Path(__file__),fixture,hook,root/'reconstruction/csrc/demo_source_ab.py')}
specs={'joint':('53evaluate_joint_body_spring_augmented_lagrangian_force',10),'drive':('25evaluate_joint_drive_load',26),'stretch':('22evaluate_stretch_force',5),'bending':('22evaluate_bending_force',7)}
rows=[];schema,_=schemas()
for rigidity in ('so3','six-springs'):
 for worlds in (1,3):
  for mode in ('newton','pd'):
   for block in (False,True):
    name=f'{rigidity}-w{worlds}-{mode}-b{int(block)}';folder=out/name;folder.mkdir()
    selected={**specs,'rigidity':('51evaluate_affine_body_so3_augmented_lagrangian_force',6) if rigidity=='so3' else ('33evaluate_affine_body_spring_force',4)}
    assert all(schema[token][arg]=='pointer' for token,arg in selected.values())
    extra=['--rigidity',rigidity,'--worlds',str(worlds),'--seed',str(worlds),'--mode',mode]
    if block:extra.append('--body-block')
    command=[sys.executable,'-m','reconstruction.csrc.demo_source_ab','--worker','original','--tag','capture','--example',str(fixture),'--frames','3','--output',str(folder),'--',*extra]
    (folder/'command.json').write_text(json.dumps(command,indent=2)+'\n')
    assert build.read_bytes()==saved and all(hashlib.sha256(Path(p).read_bytes()).hexdigest()==h for p,h in hashes.items())
    dump=';'.join(f'{token}={arg}:{12*worlds*12}' for token,arg in selected.values())
    with (folder/'run.log').open('w') as log:
     code=subprocess.run(command,env={**clean_env(),'LD_PRELOAD':str(hook),'CUDAHOOK_DIR':str(folder),'CUDAHOOK_DUMP':dump,'CUDAHOOK_DUMP_LIMIT':'9'},stdout=log,stderr=subprocess.STDOUT,timeout=1800).returncode
    row={'case':name,'exit':code}
    if not code:
     runtime=json.loads((folder/'capture.runtime.json').read_text());assert runtime['image_sha256']==REFERENCE_SHA
     with np.load(folder/'capture.npz') as data:
      row['finite']=all(np.isfinite(data[k]).all() for k in data.files);row['body_moved']=not np.array_equal(data['body_q'][0],data['body_q'][-1])
     lines=(folder/'launches.txt').read_text().splitlines();checks={}
     for key,(token,arg) in selected.items():
      changed=[]
      for ordinal in range(9):
       prefix=f'dump_{token}_call{ordinal:03d}'
       before=folder/f'{prefix}_pre_arg{arg}.bin';after=folder/f'{prefix}_post_arg{arg}.bin'
       assert before.exists() and after.exists(),(name,key,ordinal)
       changed.append(before.read_bytes()!=after.read_bytes())
      checks[key]={'calls':sum(token in line.split()[1] for line in lines),'rhs_changed_calls':sum(changed),'all_nine_snapshots_present':True}
     row['force_checks']=checks;assert all(v['calls']==9 and v['rhs_changed_calls']>0 for v in checks.values()),row
    rows.append(row);(out/'report.json').write_text(json.dumps({'cases':rows,'reference_sha256':REFERENCE_SHA,'sha256':hashes,'production_guard_changed':False},indent=2)+'\n')
    print(row,flush=True);assert code==0 and row['finite'] and row['body_moved']
