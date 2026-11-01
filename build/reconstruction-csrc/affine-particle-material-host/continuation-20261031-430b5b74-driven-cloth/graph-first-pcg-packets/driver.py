"""Extract observed first graph divergences, preserving every byte and actual scalar parameter."""
from pathlib import Path
from contextlib import ExitStack
import hashlib,json,sys
import numpy as np
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.audit_cudahook import parameter_types
base=Path(__file__).resolve().parent;capture=base/'graph-first-step-diagnosis-v2'
assert json.loads((capture/'status.json').read_text())['complete']
output=base/'graph-first-pcg-packets';output.mkdir(exist_ok=False)
(output/'driver.py').write_bytes(Path(__file__).read_bytes());rows=[];inputs={}
for graph in (10,14,26,30):
 for tag in ('source0','source1','source2'):
  with ExitStack() as stack:
   paths={side:capture/owner/f'trace-g{graph:02d}-run00.npz' for side,owner in (('original','original0'),('source',tag))}
   arrays={side:stack.enter_context(np.load(path)) for side,path in paths.items()}
   for path in paths.values():inputs[str(path)]=hashlib.sha256(path.read_bytes()).hexdigest()
   assert arrays['original'].files==arrays['source'].files
   keys=sorted(arrays['original'].files,key=lambda key:(int(key.split('-')[0][1:]),arrays['original'].files.index(key)))
   differences=[key for key in keys if arrays['original'][key].tobytes()!=arrays['source'][key].tobytes()]
   if not differences:
    rows.append({'graph':graph,'source':tag,'all_observed_snapshots_equal':True});continue
   first=differences[0];node_id=int(first.split('-')[0][1:]);precondition='23precondition_and_reduce' in first
   token='23precondition_and_reduce' if precondition else '26multiply_matrix_and_reduce'
   assert token in first and first.endswith('-a6' if precondition else '-a9'),first
   name=f'g{graph:02d}-{tag}-n{node_id:03d}';pair=output/name;pair.mkdir()
   launch=f'{node_id:06d}.{token}'
   metadata={};payloads={};raws={}
   for side,owner in (('original','original0'),('source',tag)):
    trace_path=capture/owner/'trace.json';inputs[str(trace_path)]=hashlib.sha256(trace_path.read_bytes()).hexdigest()
    trace=json.loads(trace_path.read_text())['graphs'][graph]
    node=next(node for node in trace['owned_nodes'] if node['index']==node_id)
    assert token in node['name'];assert node['geometry'][1:3]==[1,1] and node['geometry'][4:]==[1,1,0]
    raw=[bytes.fromhex(value) for value in node['raw_hex']];raws[side]=raw
    scalar=lambda index:int.from_bytes(raw[index],'little')
    points=scalar(7 if precondition else 10);divisor=scalar(5 if precondition else 8)
    assert points==36 and divisor==12 and scalar(4 if precondition else 7)==0
    labels={}
    def snapshot(label,index,before):
     key=f'n{node_id:03d}-{token}-'+('pre-' if before else '')+f'a{index}'
     assert key in arrays[side].files,(name,side,key)
     labels[('before.' if before else 'after.')+label]=arrays[side][key].tobytes()
    if precondition:
     for label,index in (('inverse',0),('r',1),('numerator',6)):snapshot(label,index,True)
     if scalar(3):snapshot('z',2,True)
     labels['before.precomputed']=raw[3];labels['before.per_group']=raw[5]
     snapshot('z',2,False);snapshot('numerator',6,False)
    else:
     for label,index in (('blocks',3),('p',4),('denominator',9)):snapshot(label,index,True)
     if scalar(5):snapshot('extra',5,True)
     if scalar(2):
      snapshot('row_count',0,True);snapshot('entries',1,True)
     labels.update({'before.per_group':raw[8],'before.max_count':raw[2],'before.rows':raw[11]})
     snapshot('ap',6,False);snapshot('denominator',9,False)
    types=parameter_types(node['name'])
    metadata[side]={'name':node['name'],'grid':node['geometry'][0],'block':node['geometry'][3]}
    folder=pair/side/'native';folder.mkdir(parents=True)
    (folder/(launch+'.json')).write_text(json.dumps(metadata[side],indent=2)+'\n')
    (pair/(side+'-actual-node.json')).write_text(json.dumps(node,indent=2)+'\n')
    for label,data in labels.items():(folder/(launch+'.'+label+'.bin')).write_bytes(data)
    payloads[side]=labels
   assert metadata['original']==metadata['source']
   for index,kind in enumerate(types):
    if '*' in kind:assert bool(int.from_bytes(raws['original'][index],'little'))==bool(int.from_bytes(raws['source'][index],'little'))
    else:assert raws['original'][index]==raws['source'][index],(name,index)
   before={side:{key:value for key,value in data.items() if key.startswith('before.')} for side,data in payloads.items()}
   assert before['original']==before['source'],(name,'Actual first-divergence inputs differ')
   pointwise='z' if precondition else 'ap'
   assert payloads['original']['after.'+pointwise]==payloads['source']['after.'+pointwise]
   rows.append({'graph':graph,'source':tag,'first_snapshot':first,'packet':str(pair),'launch':launch,
                'actual_input_bytes_equal':True,'actual_pointwise_output_equal':True,
                'actual_scalar_parameters_and_pointer_nullness_equal':True,'precondition':precondition})
   print(name,'observed same-input first scalar difference',flush=True)
(output/'report.json').write_text(json.dumps({'cases':rows,'input_sha256':inputs,'gpu_samples_added':0,
 'production_changed':False,'frozen_candidate_replaced':False,'whole_solver_complete':False},indent=2)+'\n')
