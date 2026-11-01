"""Freeze all 32 actual SDK driven-cloth contact cases, before opening the source scope."""
from pathlib import Path
import hashlib,json,subprocess,sys,shutil
import numpy as np
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.csrc.host_api_probe import REFERENCE_SHA
base=Path(__file__).resolve().parent;output=base/'original32';output.mkdir(exist_ok=False)
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes()
(output/'build.json').write_bytes(saved);(output/'driver.py').write_bytes(Path(__file__).read_bytes())
fixture=root/'reconstruction/csrc/driven_cloth_rigid_soft_scene.py';hook=root/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
locked={str(path):hashlib.sha256(path.read_bytes()).hexdigest() for path in (fixture,hook,Path(__file__))}
assert fixture.read_bytes()==(base/'fixture-v1-as-captured.py').read_bytes()
pilot=json.loads((base/'original2/report.json').read_text());assert len(pilot['cases'])==2
rows=[]
for kind in ('surface','legacy'):
 for rigidity in ('so3','six-springs'):
  for worlds in (1,3):
   for mode in ('newton','pd'):
    for block in (False,True):
     name=f'{kind}-{rigidity}-w{worlds}-{mode}-b{int(block)}';folder=output/name
     assert build.read_bytes()==saved and all(hashlib.sha256(Path(path).read_bytes()).hexdigest()==sha for path,sha in locked.items())
     token,index=('30evaluate_surface_contact_force',1) if kind=='surface' else ('27evaluate_soft_contact_force',36)
     selected=[('53evaluate_joint_body_spring_augmented_lagrangian_force',10),('25evaluate_joint_drive_load',26),
               ('22evaluate_stretch_force',5),('22evaluate_bending_force',7),
               ('51evaluate_affine_body_so3_augmented_lagrangian_force',6) if rigidity=='so3' else ('33evaluate_affine_body_spring_force',4),
               ('22evaluate_contact_force',32),('30evaluate_rolling_contact_force',1)]
     size=12*worlds*12;dump=';'.join((f'{key}=0:4,{arg}:{size}' if key=='22evaluate_contact_force' else f'{key}={arg}:{size}') for key,arg in selected)+f';{token}=0:4,{index}:{size}'
     limit=18 if kind=='legacy' else 9
     extra=['--rigidity',rigidity,'--worlds',str(worlds),'--seed',str(worlds),'--mode',mode,'--contact-kind',kind]
     if block:extra.append('--body-block')
     adopted=rigidity=='six-springs' and worlds==1 and mode=='newton' and not block
     if adopted:
      previous=base/'original2'/kind;runtime=json.loads((previous/'capture.runtime.json').read_text())
      assert runtime['extra']==extra
      assert runtime['example_sha256']==locked[str(fixture)] and runtime['launch_hook_sha256']==locked[str(hook)]
      assert json.loads((previous/'dump-protocol.json').read_text())['dump']==dump
      shutil.copytree(previous,folder)
      sha={path.name:hashlib.sha256(path.read_bytes()).hexdigest() for path in previous.iterdir() if path.is_file()}
      assert all(hashlib.sha256((folder/key).read_bytes()).hexdigest()==value for key,value in sha.items())
      (folder/'adopted-first-pilot.json').write_text(json.dumps({'source':str(previous),'files_sha256':sha,'actual_dump_limit':limit},indent=2)+'\n')
      code=0
     else:
      folder.mkdir()
      command=[sys.executable,'-m','reconstruction.csrc.demo_source_ab','--worker','original','--tag','capture',
               '--example',str(fixture),'--frames','3','--output',str(folder),'--',*extra]
      (folder/'command.json').write_text(json.dumps(command,indent=2)+'\n')
      with (folder/'run.log').open('w') as log:
       code=subprocess.run(command,env={**clean_env(),'LD_PRELOAD':str(hook),'CUDAHOOK_DIR':str(folder),
              'CUDAHOOK_DUMP':dump,'CUDAHOOK_DUMP_LIMIT':str(limit)},stdout=log,stderr=subprocess.STDOUT,timeout=1800).returncode
     (folder/'capture-protocol.json').write_text(json.dumps({'dump':dump,'limit':limit},indent=2)+'\n')
     row={'case':name,'exit':code,'adopted_exact_pilot':adopted}
     if not code:
      runtime=json.loads((folder/'capture.runtime.json').read_text());assert runtime['image_sha256']==REFERENCE_SHA
      with np.load(folder/'capture.npz') as data:row['finite']=all(np.isfinite(data[key]).all() for key in data.files)
      layout=json.loads(next(line.split(' ',1)[1] for line in (folder/'run.log').read_text().splitlines() if line.startswith('driven_cloth_contact_layout ')))
      lines=(folder/'launches.txt').read_text().splitlines();force_checks={}
      for key,arg in [*selected,(token,index)]:
       calls=[line for line in lines if key in line.split()[1]]
       ordinals=[i for i,line in enumerate(calls) if int(line.split()[5+arg][2:],16)!=0]
       assert len(ordinals)==9 and max(ordinals)<limit,(name,key,ordinals)
       changed=[]
       for i in ordinals:
        before=folder/f'dump_{key}_call{i:03d}_pre_arg{arg}.bin';after=folder/f'dump_{key}_call{i:03d}_post_arg{arg}.bin'
        assert before.stat().st_size==after.stat().st_size==size
        changed.append(before.read_bytes()!=after.read_bytes())
       force_checks[key]={'entry_calls':len(calls),'rhs_nonnull_ordinals':ordinals,'changed_calls':sum(changed)}
      row['forces']=force_checks;row['actual_contact_layout']=layout
      assert layout['rigid_count']>0
      before=np.fromfile(folder/f'dump_{token}_call000_pre_arg{index}.bin','u4').reshape(-1,3)
      after=np.fromfile(folder/f'dump_{token}_call000_post_arg{index}.bin','u4').reshape(-1,3)
      row['body_rhs_changed']=before[layout['proxy_indices']].tobytes()!=after[layout['proxy_indices']].tobytes()
      row['cloth_rhs_changed']=before[layout['free_indices']].tobytes()!=after[layout['free_indices']].tobytes()
     rows.append(row)
     (output/'report.json').write_text(json.dumps({'cases':rows,'reference_sha256':REFERENCE_SHA,'sha256':locked,
          'production_guard_opened':False,'whole_solver_complete':False,'complete':len(rows)==32},indent=2)+'\n')
     print(name,code,row.get('actual_contact_layout',{}).get('count'),row.get('body_rhs_changed'),row.get('cloth_rhs_changed'),flush=True)
     assert code==0 and row['finite'] and row['body_rhs_changed'] and row['cloth_rhs_changed']
     assert all(value['changed_calls']>0 for value in row['forces'].values())
