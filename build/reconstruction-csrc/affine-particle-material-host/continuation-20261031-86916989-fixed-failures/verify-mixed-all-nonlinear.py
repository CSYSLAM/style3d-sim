"""Actual SDK/PTX/source contribution and hardware atomic proofs for both frozen paths, nine NL groups each."""
import hashlib,json
from pathlib import Path
import subprocess,sys
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
base=Path(__file__).resolve().parent
output=base/'mixed-frozen-all9-atomic-proof';output.mkdir(exist_ok=False)
(output/'driver.py').write_bytes(Path(__file__).read_bytes())
helper=root/'reconstruction/csrc/mixed_atomic_runtime_audit.py'
saved=helper.read_bytes();metadata=(root/'build/reconstruction-csrc/host-particles/build.json').read_bytes()
side_dirs={'legacy':base/'frozen-reproduced-mixed-pair/legacy/native',
 'source':base/'frozen-reproduced-mixed-pair/source/native'}
rows=[]
for side,native in side_dirs.items():
 force_calls=sorted(native.glob('*.22evaluate_stretch_forceE.json'))
 assert len(force_calls)==9
 for index,force in enumerate(force_calls):
  offset=int(force.name.split('.')[0])-3
  folder=output/f'{side}-NL{index}'
  command=[sys.executable,'-m','reconstruction.csrc.mixed_atomic_runtime_audit',
   '--directory',str(base/'frozen-reproduced-mixed-pair'),'--sum-ptx',str(base/'gpu-three-fold/fold.ptx'),
   '--output',str(folder),'--side',side,'--offset',str(offset)]
  assert helper.read_bytes()==saved
  assert (root/'build/reconstruction-csrc/host-particles/build.json').read_bytes()==metadata
  (output/(f'{side}-NL{index}.command.json')).write_text(json.dumps(command,indent=2)+'\n')
  with (output/(f'{side}-NL{index}.log')).open('w') as log:
   code=subprocess.run(command,env=clean_env(),stdout=log,stderr=subprocess.STDOUT,timeout=900).returncode
  row={'side':side,'NL':index,'offset':offset,'exit':code}
  if not code:
   report=json.loads((folder/'report.json').read_text())
   row.update({'pointwise_three_backends_equal':report['all_three_backends_pointwise_equal'],
    'GPU_atomic_folds_equal':report['all_captured_atomic_folds_verified_on_gpu'],
    'isolated_scalars':sum(r['isolated_scalar_checks'] for r in report['stages']),
    'captured_scalars':sum(sum(r['captured_scalars_explained_by_exact_permutations'].values()) for r in report['stages'])})
  rows.append(row)
  (output/'status.json').write_text(json.dumps({'rows':rows,'complete':len(rows)==18,
   'runner_sha256':hashlib.sha256(saved).hexdigest(),'frozen_source0_replaced':False,'cohorts_expanded':False,
   'whole_solver_complete':False},indent=2)+'\n')
  print(side,index,code,row.get('isolated_scalars'),row.get('captured_scalars'),flush=True)
  assert code==0
