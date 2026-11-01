"""Capture actual plain-constraint/rigid/rolling combinations before opening any production guard."""
from pathlib import Path
import hashlib,json,subprocess,sys
import numpy as np
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.csrc.host_api_probe import REFERENCE_SHA
from reconstruction.csrc.audit_cudahook import schemas
base=Path(__file__).resolve().parent
out=base/'original-pilot6';out.mkdir(exist_ok=False)
(out/'driver.py').write_bytes(Path(__file__).read_bytes())
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes()
(out/'build.json').write_bytes(saved)
fixture=root/'reconstruction/csrc/plain_body_contact_scene.py';hook=root/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
locked={str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in (fixture,hook,root/'reconstruction/csrc/demo_source_ab.py')}
rows=[];schema=schemas()[0]
for kind in ('spring','point-line','distance'):
 for worlds,mode,block in [(1,'newton',False),(3,'pd',True)]:
  assert build.read_bytes()==saved
  assert all(hashlib.sha256(Path(name).read_bytes()).hexdigest()==digest for name,digest in locked.items())
  name=f'{kind}-w{worlds}-{mode}-b{int(block)}';folder=out/name;folder.mkdir()
  extra=['--constraint',kind,'--worlds',str(worlds),'--seed',str(worlds),'--mode',mode]
  if block:extra.append('--body-block')
  token,index={'spring':('26evaluate_body_spring_force',12),
    'point-line':('30evaluate_body_point_line_force',14),'distance':('39evaluate_body_distance_constraint_force',11)}[kind]
  fields=[(token,index),('22evaluate_contact_force',32),('30evaluate_rolling_contact_force',1)]
  assert all(schema[token][index]=='pointer' for token,index in fields)
  dump=';'.join(f'{token}={index}:{8*worlds*12}' for token,index in fields)
  protocol={'dump':dump,'limit':9};(folder/'capture-protocol.json').write_text(json.dumps(protocol,indent=2)+'\n')
  command=[sys.executable,'-m','reconstruction.csrc.demo_source_ab','--worker','original','--tag','capture',
    '--example',str(fixture),'--frames','3','--output',str(folder),'--',*extra]
  (folder/'command.json').write_text(json.dumps(command,indent=2)+'\n')
  with (folder/'run.log').open('w') as log:
   code=subprocess.run(command,env={**clean_env(),'LD_PRELOAD':str(hook),'CUDAHOOK_DIR':str(folder),
      'CUDAHOOK_DUMP':dump,'CUDAHOOK_DUMP_LIMIT':'9'},stdout=log,stderr=subprocess.STDOUT,timeout=1800).returncode
  assert code==0,(name,code)
  rt=json.loads((folder/'capture.runtime.json').read_text());assert rt['image_sha256']==REFERENCE_SHA
  with np.load(folder/'capture.npz') as data:finite=all(np.isfinite(data[key]).all() for key in data.files)
  forces={}
  for token,index in fields:
   changed=[]
   for ordinal in range(9):
    files=[folder/f'dump_{token}_call{ordinal:03d}_{phase}_arg{index}.bin' for phase in ('pre','post')]
    data=[f.read_bytes() for f in files];assert all(len(value)==8*worlds*12 for value in data)
    assert all(np.isfinite(np.frombuffer(value,dtype='f4')).all() for value in data)
    changed.append(data[0]!=data[1])
   forces[token]={'calls':9,'rhs_changed_calls':sum(changed),'changes':changed}
  row={'case':name,'exit':code,'finite':finite,'actual_force_changes':forces,
       'all_forces_effective':all(v['rhs_changed_calls']>0 for v in forces.values())}
  rows.append(row)
  (out/'report.json').write_text(json.dumps({'cases':rows,'locked_sha256':locked,'complete':len(rows)==6,
    'source_guard_opened':False,'whole_solver_complete':False},indent=2)+'\n')
  print(row,flush=True)
  assert finite and row['all_forces_effective'],name
