"""Audit the four full-order graph diagnostics without altering fixed candidates."""
from pathlib import Path
from contextlib import ExitStack
import json,hashlib
import numpy as np
base=Path(__file__).resolve().parent
capture=base/'graph-first-step-diagnosis';status=json.loads((capture/'status.json').read_text());assert status['complete']
cohort=base/'after-fixed-C8/graph60-fixed-C8';rows=[];inputs={}
for graph,case in ((10,'so3-w3-newton-b1'),(14,'so3-w3-pd-b1'),(26,'six-springs-w3-newton-b1'),(30,'six-springs-w3-pd-b1')):
 for tag in ('source0','source1','source2'):
  files=[capture/f'original0/trace-g{graph:02d}-run00.npz',capture/f'{tag}/trace-g{graph:02d}-run00.npz',
         capture/f'original0/original-{case}-1.npz',capture/f'{tag}/source-{case}-1.npz']
  for path in files:inputs[str(path)]=hashlib.sha256(path.read_bytes()).hexdigest()
  with ExitStack() as stack:
   original,source,old_state,new_state=[stack.enter_context(np.load(path)) for path in files]
   assert original.files==source.files
   keys=sorted(original.files,key=lambda key:(int(key.split('-')[0][1:]),original.files.index(key)))
   different=[key for key in keys if original[key].tobytes()!=source[key].tobytes()]
   first=None
   if different:
    key=different[0];a=original[key].view('u4');b=source[key].view('u4');index=np.flatnonzero(a!=b)
    first={'snapshot':key,'word_count':len(index),'first_word':int(index[0]),'bits':[int(a[index[0]]),int(b[index[0]])]}
   matches=[]
   for index in range(8):
    fixed=cohort/f'original{index}/original-{case}-1.npz';inputs[str(fixed)]=hashlib.sha256(fixed.read_bytes()).hexdigest()
    with np.load(fixed) as previous:
     if all(new_state[key][0].tobytes()==previous[key][0].tobytes() for key in new_state.files):matches.append(index)
   row={'graph':graph,'case':case,'source_diagnostic':tag,'snapshots':len(keys),'differing_snapshots':len(different),
        'first_difference':first,'public_first_step_equal_to_actual_sdk_diagnostic':all(old_state[key][0].tobytes()==new_state[key][0].tobytes() for key in old_state.files),
        'exact_fixed_sdk_first_steps_matched':matches,'whole_frozen_trajectory_reproduced_claimed':False}
   for label,data,state in (('original',original,old_state),('source',source,new_state)):
    q=[key for key in keys if '-20apply_nonlinear_step-a1' in key];v=[key for key in keys if '-15update_velocity-a3' in key]
    assert len(q)==3 and len(v)==1
    row[label+'_native_final_q_equals_public']=data[q[-1]].tobytes()==state['particle_q'][0].tobytes()
    row[label+'_native_final_v_equals_public']=data[v[-1]].tobytes()==state['particle_qd'][0].tobytes()
   rows.append(row)
output=base/'graph-first-step-trace-audit.json';assert not output.exists()
output.write_text(json.dumps({'cases':rows,'input_sha256':inputs,'new_gpu_samples':0,
 'production_changed':False,'fixed_candidates_replaced':False,'whole_solver_complete':False,
 'harness_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()},indent=2)+'\n')
for row in rows:print(row['graph'],row['source_diagnostic'],row['first_difference'],row['exact_fixed_sdk_first_steps_matched'])
