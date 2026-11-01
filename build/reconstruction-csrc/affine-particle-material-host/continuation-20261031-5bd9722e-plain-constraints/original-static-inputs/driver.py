"""Read actual SDK force inputs for CPU F32 template reconstruction, without changing a production image."""
import hashlib,json
from pathlib import Path
import subprocess,sys
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.csrc.audit_cudahook import schemas
from reconstruction.demo_ab import compare
import numpy as np
base=Path(__file__).resolve().parent
out=base/'original-static-inputs';out.mkdir(exist_ok=False)
(out/'driver.py').write_bytes(Path(__file__).read_bytes())
proof=json.loads((base/'original24-valid/report.json').read_text())
refs={r['case']:r for r in proof['cases']}
schema,_=schemas()
hook=root/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
specs={
 'spring':('26evaluate_body_spring_force',[(1,32),(2,8),(5,16),(6,16),(7,4)]),
 'point-line':('30evaluate_body_point_line_force',[(2,32),(3,8),(4,16),(5,16),(6,16),(9,4)]),
 'distance':('39evaluate_body_distance_constraint_force',[(1,32),(2,8),(5,16),(6,16),(7,4)])}
rows=[]
for kind,(token,args) in specs.items():
 assert all(schema[token][index]=='pointer' for index,_ in args)
 old=Path(refs[kind+'-w3-newton-b0']['capture_directory'])
 runtime=json.loads((old/'capture.runtime.json').read_text())
 folder=out/kind;folder.mkdir()
 cmd=[sys.executable,'-m','reconstruction.csrc.demo_source_ab','--worker','original','--tag','capture',
 '--example',runtime['example'],'--frames',str(runtime['frames']),'--output',str(folder),'--',*runtime['extra']]
 (folder/'command.json').write_text(json.dumps(cmd,indent=2)+'\n')
 dump=token+'='+','.join(f'{index}:{size}' for index,size in args)
 with (folder/'run.log').open('w') as log:
  subprocess.run(cmd,env={**clean_env(),'LD_PRELOAD':str(hook),'CUDAHOOK_DIR':str(folder),
   'CUDAHOOK_DUMP':dump,'CUDAHOOK_DUMP_LIMIT':'1'},stdout=log,stderr=subprocess.STDOUT,check=True,timeout=900)
 with np.load(old/'capture.npz') as a,np.load(folder/'capture.npz') as b:states=compare(a,b)
 rows.append({'kind':kind,'same_reference_states':states,'diagnostic_only':True,'spec':args})
 (out/'report.json').write_text(json.dumps(rows,indent=2)+'\n')
 print(kind,states['bitwise'],flush=True)
