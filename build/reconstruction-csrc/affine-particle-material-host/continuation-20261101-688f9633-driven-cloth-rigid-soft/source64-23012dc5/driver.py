"""Compare one immutable compiled source image with both frozen SDK32 contact matrices."""
from pathlib import Path
import hashlib,json,subprocess,sys
import numpy as np
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.csrc.audit_cudahook import schemas,compare as compare_launches
from reconstruction.demo_ab import compare
base=Path(__file__).resolve().parent
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes();metadata=json.loads(saved)
output=base/('source64-'+metadata['extension_sha256'][:8]);output.mkdir(exist_ok=False)
(output/'build.json').write_bytes(saved);(output/'driver.py').write_bytes(Path(__file__).read_bytes())
hook=root/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
indices={'53evaluate_joint_body_spring_augmented_lagrangian_force':10,'25evaluate_joint_drive_load':26,
 '22evaluate_stretch_force':5,'22evaluate_bending_force':7,'51evaluate_affine_body_so3_augmented_lagrangian_force':6,
 '33evaluate_affine_body_spring_force':4,'22evaluate_contact_force':32,'30evaluate_rolling_contact_force':1,
 '30evaluate_surface_contact_force':1,'27evaluate_soft_contact_force':36}
rows=[]
for group,parent in [('soft',base.parent/'continuation-20261101-688f9633-driven-cloth-contact'),('rigid-soft',base)]:
 reference=parent/'original32';proof=json.loads((reference/'report.json').read_text());assert proof['complete']
 for prior in proof['cases']:
  name=prior['case'];old=reference/name;folder=output/group/name;folder.mkdir(parents=True)
  runtime=json.loads((old/'capture.runtime.json').read_text());protocol=json.loads((old/'capture-protocol.json').read_text())
  assert hashlib.sha256(Path(runtime['example']).read_bytes()).hexdigest()==runtime['example_sha256']
  command=[sys.executable,'-m','reconstruction.csrc.demo_source_ab','--worker','source','--tag','capture',
           '--example',runtime['example'],'--frames',str(runtime['frames']),'--output',str(folder),'--',*runtime['extra']]
  (folder/'command.json').write_text(json.dumps(command,indent=2)+'\n')
  assert build.read_bytes()==saved
  with (folder/'run.log').open('w') as log:
   code=subprocess.run(command,env={**clean_env(),'LD_PRELOAD':str(hook),'CUDAHOOK_DIR':str(folder),
         'CUDAHOOK_DUMP':protocol['dump'],'CUDAHOOK_DUMP_LIMIT':str(protocol['limit'])},stdout=log,stderr=subprocess.STDOUT,timeout=1800).returncode
  row={'group':group,'case':name,'exit':code,'passed':False}
  if not code:
   with np.load(old/'capture.npz') as a,np.load(folder/'capture.npz') as b:
    row['states']=compare(a,b);row['finite']=all(np.isfinite(b[key]).all() for key in b.files)
   row['metadata']=compare_launches(old/'launches.txt',folder/'launches.txt',schemas()[0])
   counts=json.loads((folder/'capture.launches.json').read_text());row['coverage']=sum(counts.values())==row['metadata']['right_launches']
   buffers={}
   for token,proof_force in prior['forces'].items():
    index=indices[token];buffers[token]=all((old/f'dump_{token}_call{i:03d}_{at}_arg{index}.bin').read_bytes()==
          (folder/f'dump_{token}_call{i:03d}_{at}_arg{index}.bin').read_bytes()
          for i in proof_force['rhs_nonnull_ordinals'] for at in ('pre','post'))
   row['all_nine_force_buffers_equal']=buffers
   row['passed']=row['states']['bitwise'] and row['finite'] and row['metadata']['equal'] and row['coverage'] and all(buffers.values())
   actual=json.loads((folder/'capture.runtime.json').read_text())
   assert actual['image_sha256']==metadata['extension_sha256'] and actual['example_sha256']==runtime['example_sha256']
  rows.append(row);(output/'report.json').write_text(json.dumps({'source_sha256':metadata['extension_sha256'],'cases':rows,
       'complete':len(rows)==64,'whole_solver_complete':False},indent=2)+'\n')
  print(group,name,code,'passed',row['passed'],'metadata',row.get('metadata',{}).get('equal'),flush=True)
  assert code==0
raise SystemExit(int(not all(row['passed'] for row in rows)))
