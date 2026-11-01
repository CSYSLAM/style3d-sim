"""Verify both captured scalar84 targets with real GPU atomics and per-lane order-preserving merges."""
from pathlib import Path
import ctypes as ct
import hashlib
import json
import sys
import numpy as np
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction import kernel_ab as k
from reconstruction.csrc.particle_reduction_certificates import SERIAL_PTX
base=Path(__file__).resolve().parent
capture=base/'first-surface-diagnosis-23012dc5'
output=base/'first-surface-ordered-atomic-certificates'
output.mkdir(exist_ok=False)
(output/'driver.py').write_bytes(Path(__file__).read_bytes())
assert all(json.loads((capture/'input-equality.json').read_text()).values())
operands=json.loads((capture/'original-replay/atomic-operands.json').read_text())
assert operands['original']['thread_operands']==operands['source']['thread_operands']
scalar=84
records=[(lane,ordinal,bits) for lane,row in enumerate(operands['original']['thread_operands'])
         for ordinal,(dest,bits) in enumerate(row) if dest==scalar]
values=np.asarray([r[2] for r in records],dtype='u4').view('f4')
assert np.isfinite(values).all() and not np.any((abs(values)>0)&(abs(values)<np.finfo('f4').tiny))
lanes=sorted(set(r[0] for r in records))
sequences=[[i for i,r in enumerate(records) if r[0]==lane] for lane in lanes]
initial=np.fromfile(capture/'original/first-packet/dump_30evaluate_surface_contact_force_pre_arg1.bin',dtype='f4')[scalar]
assert initial.view('u4')==np.fromfile(capture/'source/first-packet/dump_30evaluate_surface_contact_force_pre_arg1.bin',dtype='u4')[scalar]
rng=np.random.default_rng(20261101)
certificates=[];arrays={'values':values,'records':np.asarray(records,dtype='u8')}
driver=k.Driver();stream=ct.c_void_p()
driver.check(driver.cu.cuStreamCreate(ct.byref(stream),ct.c_uint(1)))
try:
 function=driver.function(SERIAL_PTX,'audit_serial_atomic')
 for side in ('original','source'):
  target=int(np.fromfile(capture/side/'first-packet/dump_30evaluate_surface_contact_force_post_arg1.bin',dtype='u4')[scalar])
  order=None
  for trial in range(10000):
   heads=[0]*len(sequences);proposed=[]
   while len(proposed)<len(values):
    live=[j for j,row in enumerate(sequences) if heads[j]<len(row)]
    j=int(rng.choice(live));proposed.append(sequences[j][heads[j]]);heads[j]+=1
   total=initial;history=[]
   for i in proposed:history.append(total);total=np.float32(total+values[i])
   if int(total.view('u4'))==target:order=np.asarray(proposed,dtype='u4');break
  assert order is not None,(side,target)
  for sequence in sequences:
   assert [int(i) for i in order if int(i) in sequence]==sequence
  result0=np.asarray([initial],dtype='f4');history0=np.zeros(len(values),dtype='f4')
  pointers=[driver.upload(a) for a in (values,order,result0,history0)]
  params=[*pointers,ct.c_uint(len(values))]
  raw=(ct.c_void_p*len(params))(*[ct.cast(ct.byref(v),ct.c_void_p) for v in params])
  driver.check(driver.cu.cuLaunchKernel(function,1,1,1,1,1,1,0,stream,raw,None))
  driver.check(driver.cu.cuStreamSynchronize(stream))
  actual=driver.download(pointers[2],result0);actual_history=driver.download(pointers[3],history0)
  assert int(actual.view('u4')[0])==target
  assert actual_history.tobytes()==np.asarray(history,dtype='f4').tobytes()
  arrays[side+'-order']=order;arrays[side+'-hardware-history']=actual_history
  certificates.append({'side':side,'target_bits':target,'passed':True,'search_trials':trial+1,
                       'same_destination_lane_order_preserved':True,'hardware_atomic_verified':True})
 report={'scalar':scalar,'real_operand_count':len(values),'contributing_lanes':len(lanes),
         'initial_bits':int(initial.view('u4')),'certificates':certificates,'all_passed':True,
         'actual_production_order_inferred':False,'full_cross_destination_schedule_proven':False,
         'acceptance_cohort_changed':False,'whole_solver_complete':False,
         'input_sha256':{str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in
                         [Path(__file__),capture/'original-replay/atomic-operands.json',capture/'input-equality.json']}}
 (output/'report.json').write_text(json.dumps(report,indent=2)+'\n')
 (output/'serial-atomic.ptx').write_text(SERIAL_PTX)
 np.savez_compressed(output/'certificates.npz',**arrays)
 print(report)
finally:
 driver.free();driver.check(driver.cu.cuStreamDestroy_v2(stream))
