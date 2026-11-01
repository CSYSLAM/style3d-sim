"""Predeclared eight independent SDK diagnostics per failure, outside every frozen acceptance cohort."""
import hashlib,json
from pathlib import Path
import subprocess,sys
import numpy as np
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.csrc.host_api_probe import REFERENCE,REFERENCE_SHA
base=Path(__file__).resolve().parent
validation=base.parent/'continuation-20261031-5bd9722e-plain-constraints/validation-86916989'
cohort=validation/'regression-fixed-C10'
proof=json.loads((cohort/'report.json').read_text())
failed=[r for r in proof['cases'] if not r['every_array_and_step_within']]
assert len(failed)==3
output=base/'sdk-diagnostics8';output.mkdir(exist_ok=False)
(output/'driver.py').write_bytes(Path(__file__).read_bytes())
plan={'runs_per_failure':8,'purpose':'Exact SDK witness search for immutable source0, not acceptance resampling',
 'cohorts_expanded':False,'source0_replaced':False,'whole_solver_complete':False,
 'targets':[{k:r[k] for k in ('case','fixed_source_npz_sha256','outside')} for r in failed]}
(output/'plan.json').write_text(json.dumps(plan,indent=2)+'\n')
rows=[]
for failure in failed:
 name=failure['case'];seed=int(name.rsplit('seed',1)[1]);case=failure['outside'][0].split('/')[0]
 comparison=json.loads((validation/'regression74'/name/f'comparison-seed{seed}.json').read_text())
 frozen=cohort/name/'source0.npz';source_hash=hashlib.sha256(frozen.read_bytes()).hexdigest()
 assert source_hash==failure['fixed_source_npz_sha256']
 for index in range(8):
  assert hashlib.sha256(REFERENCE.read_bytes()).hexdigest()==REFERENCE_SHA
  assert hashlib.sha256(frozen.read_bytes()).hexdigest()==source_hash
  folder=output/name/str(index);folder.parent.mkdir(exist_ok=True)
  command=[sys.executable,'-m','reconstruction.csrc.host_particles_ab','--worker','legacy',
   '--scenario',comparison['scenario'],'--seed',str(seed),'--output',str(folder)]
  if comparison['adapter_demo']:command.append('--adapter')
  (folder.parent/(str(index)+'.command.json')).write_text(json.dumps(command,indent=2)+'\n')
  with (folder.parent/(str(index)+'.log')).open('w') as log:
   code=subprocess.run(command,env=clean_env(),stdout=log,stderr=subprocess.STDOUT,timeout=1800).returncode
  row={'case':name,'diagnostic':index,'exit':code,'target':case,'frozen_source_sha256':source_hash}
  if not code:
   actual=folder/f'legacy-seed{seed}.npz'
   with np.load(frozen) as a,np.load(actual) as b:
    keys=[k for k in a.files if k.startswith(case+'/')]
    same={k:a[k].tobytes()==b[k].tobytes() for k in keys}
    row.update({'target_arrays':len(keys),'bitwise_arrays':sum(same.values()),'same_target_all_arrays':all(same.values()),
     'per_array':same,'original_npz_sha256':hashlib.sha256(actual.read_bytes()).hexdigest()})
  rows.append(row)
  (output/'report.json').write_text(json.dumps({'plan':plan,'reference_sha256':REFERENCE_SHA,'runs':rows,
   'complete':len(rows)==24},indent=2)+'\n')
  print(name,index,code,row.get('bitwise_arrays'),row.get('target_arrays'),flush=True)
  assert code==0
