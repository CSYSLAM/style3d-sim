"""Disambiguate F32 L5 operand order with two actual SDK initializations, including reversed proxy ownership."""
import hashlib
import json
from pathlib import Path
import numpy as np
base=Path(__file__).resolve().parent
folder=base/'original-prismatic-static-inputs'
token='dump_61add_joint_body_point_line_augmented_lagrangian_preconditioner_pre_arg'
read=lambda i,dtype,shape:np.frombuffer((folder/f'{token}{i}.bin').read_bytes(),dtype=dtype).reshape(shape)
ids=read(0,'i4',(2,4));pairs=read(1,'i4',(4,2));wp,e0,e1=[read(i,'f4',(4,4)) for i in (2,3,4)]
stiff=read(5,'f4',(4,))
normal=base/'validation-d8457a42/prismatic-constructor/pd-prismatic-w3-payload/original'
reversed_folder=base/'original-reversed-proxy-initialize-v2'
with np.load(reversed_folder/'explicit-model-change.npz') as z:reversed_ids=z['affine_body_indices'].copy()
for i,value in ((25,wp),(26,e0),(27,e1)):
    assert (reversed_folder/f'copy-{i}.bin').read_bytes()==value.tobytes()
results={}
for tag,particles,expected in (('normal',ids,normal),('reversed_proxy',reversed_ids,reversed_folder)):
    checks={}
    for mode in ('point-first','line-first','global-index-sorted'):
        diagonal=np.zeros(8,dtype='f4');rows=[{} for _ in range(8)]
        for line,pair in enumerate(pairs):
            mid=np.float32(np.float32(e0[line]+e1[line])*np.float32(.5))
            point=[(int(i),np.float32(-v)) for i,v in zip(particles[pair[0]],wp[line])]
            edge=[(int(i),v) for i,v in zip(particles[pair[1]],mid)]
            ends=point+edge if mode=='point-first' else edge+point if mode=='line-first' else sorted(point+edge)
            for a,(i,wi) in enumerate(ends):
                for b,(j,wj) in enumerate(ends[a:],a):
                    value=np.float32(np.float32(stiff[line]*wi)*wj)
                    if i==j:
                        diagonal[i]=np.float32(diagonal[i]+value)
                        if a!=b:diagonal[i]=np.float32(diagonal[i]+value)
                    else:
                        rows[i][j]=np.float32(rows[i].get(j,np.float32(0))+value)
                        rows[j][i]=np.float32(rows[j].get(i,np.float32(0))+value)
        out=np.zeros((7,8),dtype=[('column','<i4'),('value','<f4')]);out['column']=-1
        for i,row in enumerate(rows):
            for slot,item in enumerate(sorted(row.items())):out[slot,i]=item
        checks[mode]={'D4_bitwise':diagonal.tobytes()==(expected/'copy-8.bin').read_bytes(),
                      'L5_bitwise':out.tobytes()==(expected/'copy-23.bin').read_bytes()}
    results[tag]=checks
matches=[mode for mode in results['normal'] if all(all(checks[mode].values()) for checks in results.values())]
report={'comparisons':results,'orders_matching_both_SDK_captures':matches,'production_modified':False,
        'frozen_candidate_replaced':False,'whole_solver_complete':False,
        'runner_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
output=base/'static-line-template-order-resolved.json';assert not output.exists()
output.write_text(json.dumps(report,indent=2)+'\n');print(report,flush=True)
assert len(matches)==1
