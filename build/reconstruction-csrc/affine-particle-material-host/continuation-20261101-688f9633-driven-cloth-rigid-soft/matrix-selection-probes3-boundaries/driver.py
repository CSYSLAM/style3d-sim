"""Nine predeclared SDK branch probes; no new acceptance samples or source mathematics changes."""
from pathlib import Path
import hashlib,json,subprocess,sys,collections
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
base=Path(__file__).resolve().parent;output=base/'matrix-selection-probes3-boundaries';output.mkdir(exist_ok=False)
(output/'driver.py').write_bytes(Path(__file__).read_bytes())
plan=[('six-both-diagonal','legacy','six-springs','both',100.,True),
      ('six-rigid-alpha0','legacy','six-springs','rigid',0.,False),
      ('six-surface-diagonal','surface','six-springs','soft',100.,True)]
(output/'plan.json').write_text(json.dumps(plan,indent=2)+'\n')
hook=root/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so';rows=[]
for name,kind,rigidity,channels,alpha,diagonal in plan:
 folder=output/name
 command=[sys.executable,str(base/'probe-block-matrix-worker.py'),'--case',name,'--kind',kind,'--rigidity',rigidity,
          '--channels',channels,'--alpha',str(alpha),'--output',str(folder)]
 if diagonal:command.append('--diagonal')
 (output/(name+'.command.json')).write_text(json.dumps(command,indent=2)+'\n')
 with (output/(name+'.log')).open('w') as log:
  code=subprocess.run(command,env={**clean_env(),'LD_PRELOAD':str(hook),'CUDAHOOK_DIR':str(folder)},
                       stdout=log,stderr=subprocess.STDOUT,timeout=1800).returncode
 row={'case':name,'exit':code}
 if not code:
  lines=(folder/'launches.txt').read_text().splitlines()
  row['counts']=dict(collections.Counter(line.split()[1] for line in lines))
  row['block_template_calls']=row['counts'].get('29initialize_block_non_diagonal',0)
  row['rigidity_gn_calls']=row['counts'].get('43add_affine_body_spring_gauss_newton_hessian',0)
  row['membrane_gn_calls']=row['counts'].get('add_cloth_membrane_gauss_newton_hessian',0)
  row['first_matrix']=next(line for line in lines if '26multiply_matrix_and_reduce' in line.split()[1])
 rows.append(row);(output/'report.json').write_text(json.dumps({'cases':rows,'complete':len(rows)==3,
    'production_changed':False,'whole_solver_complete':False},indent=2)+'\n')
 print(name,code,row.get('block_template_calls'),row.get('rigidity_gn_calls'),row.get('membrane_gn_calls'),flush=True)
 assert code==0
