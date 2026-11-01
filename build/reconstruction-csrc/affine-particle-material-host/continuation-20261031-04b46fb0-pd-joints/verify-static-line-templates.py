"""Verify recovered D4/L5 from actual SDK model buffers before changing production matrix assembly."""
import hashlib
import json
from pathlib import Path
import numpy as np
base=Path(__file__).resolve().parent
folder=base/'original-prismatic-static-inputs'
prefix='dump_61add_joint_body_point_line_augmented_lagrangian_preconditioner_pre_arg'
def data(i,dtype,shape):
    return np.frombuffer((folder/(prefix+str(i)+'.bin')).read_bytes(),dtype=dtype).reshape(shape)
particles=data(0,'i4',(2,4));bodies=data(1,'i4',(4,2))
wp,e0,e1=[data(i,'f4',(4,4)) for i in (2,3,4)]
stiffness=data(5,'f4',(4,))
diagonal=np.zeros(8,dtype='f4');rows=[{} for _ in range(8)]
for line,pair in enumerate(bodies):
    middle=np.float32(np.float32(e0[line]+e1[line])*np.float32(.5))
    ends=[]
    for side,weights,sign in ((0,wp[line],-1),(1,middle,1)):
        if pair[side]<0:continue
        ends.extend((int(index),np.float32(value*np.float32(sign)))
                    for index,value in zip(particles[pair[side]],weights))
    for a,(i,wi) in enumerate(ends):
        for b,(j,wj) in enumerate(ends[a:],a):
            value=np.float32(np.float32(stiffness[line]*wi)*wj)
            if i==j:
                diagonal[i]=np.float32(diagonal[i]+value)
                if a!=b:diagonal[i]=np.float32(diagonal[i]+value)
            else:
                rows[i][j]=np.float32(rows[i].get(j,np.float32(0))+value)
                rows[j][i]=np.float32(rows[j].get(i,np.float32(0))+value)
maximum=max(map(len,rows));entries=np.zeros((maximum,8),dtype=[('column','<i4'),('value','<f4')])
entries['column']=-1
for i,row in enumerate(rows):
    for slot,(column,value) in enumerate(sorted(row.items())):
        entries[slot,i]=(column,value)
raw=base/'validation-d8457a42/prismatic-constructor/pd-prismatic-w3-payload/original'
original_d4=(raw/'copy-8.bin').read_bytes();original_l5=(raw/'copy-23.bin').read_bytes()
report={'D4_bitwise':diagonal.tobytes()==original_d4,'L5_bitwise':entries.tobytes()==original_l5,
        'stiffness':stiffness.tolist(),'matrix_entries':int(entries.size),'GPU_used_for_this_calculation':False,
        'production_modified':False,'whole_solver_complete':False,
        'input_sha256':{str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in
                        [*folder.glob(prefix+'*.bin'),raw/'copy-8.bin',raw/'copy-23.bin']},
        'runner_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
output=base/'static-line-template-cpu-proof.json'
assert not output.exists()
output.write_text(json.dumps(report,indent=2)+'\n')
np.savez_compressed(base/'static-line-template-cpu-proof.npz',D4=diagonal,L5=entries)
print({k:v for k,v in report.items() if k!='input_sha256'},flush=True)
assert report['D4_bitwise'] and report['L5_bitwise']
