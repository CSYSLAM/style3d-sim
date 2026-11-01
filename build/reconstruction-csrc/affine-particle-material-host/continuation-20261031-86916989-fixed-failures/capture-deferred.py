"""One SDK and three source diagnostics using deferred snapshots; retain every result, no cohort changes."""
import hashlib,json
from pathlib import Path
import subprocess,sys
import numpy as np
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
base=Path(__file__).resolve().parent
observer=base/'deferred-observer/deferred-observer.so'
helper=root/'reconstruction/csrc/regression_failure_trace.py'
output=base/'deferred-trace4';output.mkdir(exist_ok=False)
(output/'driver.py').write_bytes(Path(__file__).read_bytes())
(output/'plan.json').write_text(json.dumps({'runs':['legacy','source','source','source'],
 'deferred_capture':True,'production_modified':False,'cohorts_expanded':False,'frozen_candidate_replaced':False},indent=2)+'\n')
validation=base.parent/'continuation-20261031-5bd9722e-plain-constraints/validation-86916989'
frozen=validation/'regression-fixed-C10/mixed_cloth-seed3/source0.npz'
rows=[]
for index,backend in enumerate(('legacy','source','source','source')):
 folder=output/str(index)
 command=[sys.executable,'-m','reconstruction.csrc.regression_failure_trace','--backend',backend,
 '--output',str(folder),'--scenario','mixed_cloth','--seed','3','--case','mixed_w129_duplicates']
 (output/(str(index)+'.command.json')).write_text(json.dumps(command,indent=2)+'\n')
 with (output/(str(index)+'.log')).open('w') as log:
  code=subprocess.run(command,env={**clean_env(),'LD_PRELOAD':str(observer)},stdout=log,
   stderr=subprocess.STDOUT,timeout=1800).returncode
 row={'run':index,'backend':backend,'exit':code,'target':'mixed_w129_duplicates','diagnostic_only':True}
 if not code:
  native=folder/'native';receipt=json.loads((native/'deferred-receipt.json').read_text())
  row['receipt']=receipt
  arrays=folder/f'{backend}-seed3.npz'
  with np.load(frozen) as a,np.load(arrays) as b:
   keys=[k for k in a.files if k.startswith('mixed_w129_duplicates/')]
   world85=[]
   for key in keys:world85.append(a[key][255:258].tobytes()==b[key][255:258].tobytes())
   row['world85_arrays_equal']=sum(world85);row['world85_all_steps_match']=all(world85)
   row['whole_target_bitwise']=all(a[k].tobytes()==b[k].tobytes() for k in keys)
   # Each last apply/velocity snapshot must equal the actual public state after that step.
   applies=sorted(native.glob('*.20apply_nonlinear_stepE.after.q.bin'))
   velocities=sorted(native.glob('*.15update_velocityE.after.v.bin'))
   assert len(applies)==9 and len(velocities)==3
   for step in range(3):
    assert applies[step*3+2].read_bytes()==b[f'mixed_w129_duplicates/{step}/out.particle_q'].tobytes()
    assert velocities[step].read_bytes()==b[f'mixed_w129_duplicates/{step}/out.particle_qd'].tobytes()
   row['deferred_step_outputs_validated']=True
  row['actual_npz_sha256']=hashlib.sha256(arrays.read_bytes()).hexdigest()
 rows.append(row)
 (output/'report.json').write_text(json.dumps({'rows':rows,'complete':len(rows)==4,
 'frozen_source_npz_sha256':hashlib.sha256(frozen.read_bytes()).hexdigest(),
 'observer_sha256':hashlib.sha256(observer.read_bytes()).hexdigest(),'whole_solver_complete':False},indent=2)+'\n')
 print(index,backend,code,row.get('world85_arrays_equal'),row.get('world85_all_steps_match'),flush=True)
 assert code==0
