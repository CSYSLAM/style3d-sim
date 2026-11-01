"""Trace current C10 failures in original full worker order; never adopt these diagnostics into cohorts."""
import hashlib,json
from pathlib import Path
import subprocess,sys
import numpy as np
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
base=Path(__file__).resolve().parent
validation=base.parent/'continuation-20261031-5bd9722e-plain-constraints/validation-86916989'
cohort=validation/'regression-fixed-C10'
proof=json.loads((cohort/'report.json').read_text())
failed=[r for r in proof['cases'] if not r['every_array_and_step_within']]
assert len(failed)==3
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes()
observer=base.parent/'continuation-20261031-8f4127f0-pcg/all-entry-packets/host_trace_packets.so'
helper=root/'reconstruction/csrc/regression_failure_trace.py'
paths=(helper,observer,root/'reconstruction/csrc/host_particles_ab.py')
hashes={str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in paths}
output=base/'first-trace-pairs';output.mkdir(exist_ok=False)
(output/'build.json').write_bytes(saved)
(output/'driver.py').write_bytes(Path(__file__).read_bytes())
rows=[]
for failure in failed:
 name=failure['case'];seed=int(name.rsplit('seed',1)[1])
 comparison=json.loads((validation/'regression74'/name/f'comparison-seed{seed}.json').read_text())
 bad=failure['outside'][0].split('/')[0]
 for backend,tag in [('legacy','original0'),('source','source0')]:
  folder=output/name/backend;folder.parent.mkdir(exist_ok=True)
  command=[sys.executable,'-m','reconstruction.csrc.regression_failure_trace','--backend',backend,
   '--output',str(folder),'--scenario',comparison['scenario'],'--seed',str(seed),'--case',bad]
  if comparison['adapter_demo']:command.append('--adapter')
  assert build.read_bytes()==saved
  assert all(hashlib.sha256(Path(p).read_bytes()).hexdigest()==h for p,h in hashes.items())
  (folder.parent/(backend+'.command.json')).write_text(json.dumps(command,indent=2)+'\n')
  with (folder.parent/(backend+'.log')).open('w') as log:
   code=subprocess.run(command,env={**clean_env(),'LD_PRELOAD':str(observer)},stdout=log,
    stderr=subprocess.STDOUT,timeout=1800).returncode
  row={'case':name,'backend':backend,'exit':code,'target':bad,'diagnostic_only':True}
  if code==0:
   frozen=cohort/name/(tag+'.npz');actual=folder/f'{backend}-seed{seed}.npz'
   with np.load(frozen) as a,np.load(actual) as b:
    keys=[k for k in a.files if k.startswith(bad+'/')]
    assert keys and all(k in b.files for k in keys)
    same={k:a[k].tobytes()==b[k].tobytes() for k in keys}
    row.update({'target_arrays':len(keys),'target_arrays_bitwise':sum(same.values()),
     'frozen_target_reproduced':all(same.values()),'per_array':same,
     'frozen_npz_sha256':hashlib.sha256(frozen.read_bytes()).hexdigest(),
     'trace_npz_sha256':hashlib.sha256(actual.read_bytes()).hexdigest(),
     'native_packets':len(list((folder/'native').glob('*.json')))})
  rows.append(row)
  (output/'report.json').write_text(json.dumps({'cases':rows,'input_sha256':hashes,
   'source_sha256':json.loads(saved)['extension_sha256'],'frozen_candidate_replaced':False,
   'original_cohorts_expanded':False,'whole_solver_complete':False},indent=2)+'\n')
  print(name,backend,code,row.get('target_arrays_bitwise'),row.get('target_arrays'),flush=True)
  assert code==0
