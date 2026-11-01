"""Check F32 template operand order against normal and reversed-proxy actual SDK initialization bytes."""
import hashlib,json
from pathlib import Path
import numpy as np
base=Path(__file__).resolve().parent
specs={
 'spring':('26evaluate_body_spring_force',(1,2,5,6,7)),
 'point-line':('30evaluate_body_point_line_force',(2,3,4,5,6,9)),
 'distance':('39evaluate_body_distance_constraint_force',(1,2,5,6,7))}
results={};inputs={}
def read(p):
 data=p.read_bytes();inputs[str(p)]=hashlib.sha256(data).hexdigest();return data
for kind,(token,args) in specs.items():
 folder=base/'original-static-inputs'/kind
 arrays=[np.frombuffer(read(folder/f'dump_{token}_pre_arg{i}.bin'),dtype='i4' if j<2 else 'f4')
         for j,i in enumerate(args)]
 ids=arrays[0].reshape(2,4);pair=arrays[1];weights=arrays[2:-1];stiff=arrays[-1][0]
 original=base/'constructor-before-5bd9722e'/kind/(kind+'-newton-w3-payload')/'original'
 reversed_dir=base/'original-reversed-proxy-initialize'/kind
 with np.load(reversed_dir/'explicit-model-change.npz') as z:reverse=z['affine_body_indices'].copy()
 results[kind]={}
 for tag,particles,expected in [('normal',ids,original),('reversed_proxy',reverse,reversed_dir)]:
  checks={}
  if kind=='point-line':
   point,edge0,edge1=weights
   first=[(int(i),np.float32(-v)) for i,v in zip(particles[pair[0]],point)]
   mid=np.float32(np.float32(edge0+edge1)*np.float32(.5))
   second=[(int(i),v) for i,v in zip(particles[pair[1]],mid)]
  else:
   first=[(int(i),v) for i,v in zip(particles[pair[0]],weights[0])]
   second=[(int(i),np.float32(-v)) for i,v in zip(particles[pair[1]],weights[1])]
  for mode in ('attachment-first','attachment-second','global-index-sorted'):
   ends=first+second if mode=='attachment-first' else second+first if mode=='attachment-second' else sorted(first+second)
   diagonal=np.zeros(8,dtype='f4');rows=[{} for _ in range(8)]
   for a,(i,wi) in enumerate(ends):
    for b,(j,wj) in enumerate(ends[a:],a):
     v=np.float32(np.float32(stiff*wi)*wj)
     if i==j:
      diagonal[i]=np.float32(diagonal[i]+v)
      if a!=b:diagonal[i]=np.float32(diagonal[i]+v)
     else:
      rows[i][j]=np.float32(rows[i].get(j,np.float32(0))+v)
      rows[j][i]=np.float32(rows[j].get(i,np.float32(0))+v)
   out=np.zeros((7,8),dtype=[('column','<i4'),('value','<f4')]);out['column']=-1
   for i,row in enumerate(rows):
    for slot,item in enumerate(sorted(row.items())):out[slot,i]=item
   di,li=(7,22) if kind=='distance' else (2,10)
   copies=[json.loads(line)['file'] for line in read(expected/'memory.jsonl').decode().splitlines()
           if 'file' in json.loads(line)]
   checks[mode]={'diagonal_bitwise':diagonal.tobytes()==read(expected/copies[di]),
                 'off_diagonal_bitwise':out.tobytes()==read(expected/copies[li])}
  results[kind][tag]=checks
 matches=[mode for mode in checks if all(all(c[mode].values()) for c in results[kind].values())]
 results[kind]['orders_matching_both']=matches
 print(kind,matches,flush=True)
 assert matches==['global-index-sorted']
report={'results':results,'input_sha256':inputs,'production_modified':False,'frozen_candidate_replaced':False,
 'whole_solver_complete':False,'runner_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
out=base/'template-order-resolved.json';assert not out.exists();out.write_text(json.dumps(report,indent=2)+'\n')
