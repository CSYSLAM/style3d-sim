from pathlib import Path
import hashlib,json
import numpy as np
base=Path(__file__).resolve().parent;replay=base/'common-force-three-backends'
r=json.loads((replay/'report.json').read_text());done=json.loads((base/'common-force-both-paths-exact-sums.json').read_text())
trace=json.loads((replay/'atomic-operands.json').read_text());assert trace['original']['thread_operands']==trace['source']['thread_operands']
with np.load(replay/'outputs.npz') as arrays:before=arrays['before'].copy()
terms=[[] for _ in before];owners=[[] for _ in before]
for thread,events in enumerate(trace['original']['thread_operands']):
 for ordinal,(scalar,bits) in enumerate(events):terms[scalar].append(bits);owners[scalar].append((thread,ordinal))
known={}
for name,rows in r['witnesses'].items():
 for row in rows:
  if row['exact_float32_witness']:known[row['scalar'],int(before[row['scalar']].view('u4')),row['target_bits']]=row['order']
for row in done['additional_certificates']:known[row['scalar'],row['initial_bits'],row['target_bits']]=row['order']
targets={name:np.asarray([row['target_bits'] for row in rows],dtype='u4') for name,rows in r['witnesses'].items()}
targets['source-captured']=np.fromfile(base/'source-common-force-capture/dump_30evaluate_surface_contact_force_post_arg1.bin','u4')
initials={name:before for name in targets};initials['source-captured']=np.fromfile(base/'source-common-force-capture/dump_30evaluate_surface_contact_force_pre_arg1.bin','f4')
rows={};failed=[]
for name,target in targets.items():
 row={'exact_scalar_sums':0,'subnormal_operands':0,'subnormal_intermediates':0,'emission_order_preserved':0,'emission_order_not_preserved':0}
 for scalar,bits in enumerate(target):
  initial=initials[name][scalar];key=(scalar,int(initial.view('u4')),int(bits));order=known[key]
  assert sorted(order)==list(range(len(terms[scalar])))
  values=np.asarray(terms[scalar],dtype='u4').view('f4')
  sequence=np.concatenate((np.asarray([initial],dtype='f4'),values[order]));sums=np.add.accumulate(sequence,dtype='f4')
  assert int(sums[-1].view('u4'))==int(bits)
  is_subnormal=lambda x: ((x.view('u4')&0x7f800000)==0)&((x.view('u4')&0x7fffff)!=0)
  row['exact_scalar_sums']+=1;row['subnormal_operands']+=int(np.count_nonzero(is_subnormal(sequence)));row['subnormal_intermediates']+=int(np.count_nonzero(is_subnormal(sums)))
  prior={};same=True
  for index in order:
   thread,ordinal=owners[scalar][index]
   if thread in prior and ordinal<prior[thread]:same=False
   prior[thread]=ordinal
  row['emission_order_preserved' if same else 'emission_order_not_preserved']+=1
 rows[name]=row
out={'targets':rows,'all_scalar_values_verified':True,'GPU_used':False,'original_cohort_changed':False,'per_scalar_arithmetic_witness_is_not_a_global_GPU_schedule_certificate':True,'captured_per_contact_runtime_outputs_and_operand_sequences_equal':True,'production_order_inferred':False,'whole_solver_complete':False,'input_sha256':{str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in (Path(__file__),replay/'report.json',replay/'outputs.npz',replay/'atomic-operands.json',base/'common-force-both-paths-exact-sums.json')}}
(base/'exact-witness-detail-audit.json').write_text(json.dumps(out,indent=2)+'\n');print(json.dumps(rows,indent=2))
