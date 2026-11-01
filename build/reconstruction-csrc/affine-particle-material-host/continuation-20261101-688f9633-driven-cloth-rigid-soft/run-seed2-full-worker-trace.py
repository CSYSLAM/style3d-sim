"""Observe seed2/it5 in its full particle worker order; never replace the frozen C10 candidates."""
from pathlib import Path
import hashlib,json,subprocess,sys
import numpy as np
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
base=Path(__file__).resolve().parent
output=base/'particles-seed2-it5-full-worker-trace'
output.mkdir(exist_ok=False)
(output/'driver.py').write_bytes(Path(__file__).read_bytes())
observer_parent=root/'build/reconstruction-csrc/affine-particle-material-host/continuation-20261031-8f4127f0-pcg/all-entry-packets'
observer=observer_parent/'host_trace_packets.so'
provenance=json.loads((observer_parent/'provenance.json').read_text())
assert hashlib.sha256(observer.read_bytes()).hexdigest()==provenance['sha256'][str(observer)]
(output/'observer-provenance.json').write_bytes((observer_parent/'provenance.json').read_bytes())
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes()
(output/'build.json').write_bytes(saved)
reports=[]
for backend in ('legacy','source'):
 assert build.read_bytes()==saved
 folder=output/backend
 command=[sys.executable,'-m','reconstruction.csrc.regression_failure_trace',
          '--backend',backend,'--output',str(folder),'--scenario','particles','--seed','2',
          '--case','n257_w1_it5_f0','--adapter']
 (output/(backend+'.command.json')).write_text(json.dumps(command,indent=2)+'\n')
 with (output/(backend+'.log')).open('w') as log:
  code=subprocess.run(command,env={**clean_env(),'LD_PRELOAD':str(observer)},stdout=log,
                      stderr=subprocess.STDOUT,timeout=1800).returncode
 assert code==0,(backend,code)
 frozen=base/'validation-23012dc5/regression-fixed-C10/particles-seed2'/('source0.npz' if backend=='source' else 'original0.npz')
 with np.load(folder/(backend+'-seed2.npz')) as actual,np.load(frozen) as old:
  assert set(actual.files)==set(old.files)
  checks={key:actual[key].tobytes()==old[key].tobytes() for key in actual.files if key.startswith('n257_w1_it5_f0/')}
 report={'backend':backend,'target_array_checks':checks,'target_all_equal':all(checks.values()),
         'observer_sha256':hashlib.sha256(observer.read_bytes()).hexdigest(),
         'frozen_npz_sha256':hashlib.sha256(frozen.read_bytes()).hexdigest(),
         'source0_replaced':False,'cohort_expanded':False,'whole_solver_complete':False}
 (folder/'frozen-target-comparison.json').write_text(json.dumps(report,indent=2)+'\n')
 reports.append(report);print(backend,sum(checks.values()),'/',len(checks),'frozen target arrays match',flush=True)
(output/'report.json').write_text(json.dumps({'cases':reports,'complete':True,'whole_solver_complete':False},indent=2)+'\n')
