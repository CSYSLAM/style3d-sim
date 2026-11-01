"""Capture native zero-drive axis joint AL/PENALTY paths before changing source guards."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import numpy as np
root=Path.cwd().resolve()
sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.csrc.host_api_probe import REFERENCE_SHA
from reconstruction.csrc.audit_cudahook import schemas, parameter_types
base=Path(__file__).resolve().parent
output=base/'original32-v2'
output.mkdir(exist_ok=False)
build=root/'build/reconstruction-csrc/host-particles/build.json'
saved=build.read_bytes()
(output/'build.json').write_bytes(saved)
fixture=root/'reconstruction/csrc/undriven_axis_joint_scene.py'
hook=root/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
inputs=(Path(__file__),fixture,root/'reconstruction/csrc/joint_body_scene.py',root/'reconstruction/csrc/demo_source_ab.py',hook)
hashes={str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in inputs}
rows=[]
schema,_=schemas()
cases=[(c,k,w,m,b) for c in ('al','penalty') for k in ('revolute','prismatic') for w in (1,3)
       for m in ('newton','pd') for b in (False,True)]
for constraint_mode,kind,worlds,mode,block in cases:
        name=f'{constraint_mode}-{kind}-w{worlds}-{mode}-b{int(block)}'
        folder=output/name
        folder.mkdir()
        extra=['--constraint-mode',constraint_mode,'--joint-kind',kind,'--worlds',str(worlds),'--seed',str(worlds),'--mode',mode]
        if block:extra.append('--body-block')
        n=8*worlds
        if constraint_mode=='al':
            token,index=('57evaluate_joint_body_point_line_augmented_lagrangian_force',13) if kind=='prismatic' else \
                ('53evaluate_joint_body_spring_augmented_lagrangian_force',10)
        else:
            token,index=('30evaluate_body_point_line_force',14) if kind=='prismatic' else \
                ('26evaluate_body_spring_force',12)
        assert schema[token][index]=='pointer', (token,index,schema[token][index])
        dump=f'{token}={index}:{n*12}'
        command=[sys.executable,'-m','reconstruction.csrc.demo_source_ab','--worker','original','--tag','capture',
                 '--example',str(fixture),'--frames','3','--output',str(folder),'--',*extra]
        (folder/'command.json').write_text(json.dumps(command,indent=2)+'\n')
        assert build.read_bytes()==saved
        assert all(hashlib.sha256(Path(p).read_bytes()).hexdigest()==h for p,h in hashes.items())
        with (folder/'run.log').open('w') as log:
            code=subprocess.run(command,env={**clean_env(),'LD_PRELOAD':str(hook),'CUDAHOOK_DIR':str(folder),
                    'CUDAHOOK_DUMP':dump,'CUDAHOOK_DUMP_LIMIT':'1'},
                                stdout=log,stderr=subprocess.STDOUT,timeout=900).returncode
        row={'case':name,'exit':code}
        if not code:
            runtime=json.loads((folder/'capture.runtime.json').read_text())
            assert runtime['image_sha256']==REFERENCE_SHA
            with np.load(folder/'capture.npz') as data:
                row['finite']=all(np.isfinite(data[k]).all() for k in data.files)
                row['body_moved']=not np.array_equal(data['body_q'][0],data['body_q'][-1])
                row['shapes']={k:list(data[k].shape) for k in data.files}
            row['owned_calls']=len((folder/'launches.txt').read_text().splitlines())
            row['actual_drive_load_calls']=sum('25evaluate_joint_drive_load' in x for x in (folder/'launches.txt').read_text().splitlines())
            assert row['actual_drive_load_calls']==0
            row['actual_force_calls']=sum(token in x.split()[1] for x in (folder/'launches.txt').read_text().splitlines())
            before=(folder/f'dump_{token}_pre_arg{index}.bin').read_bytes()
            after=(folder/f'dump_{token}_post_arg{index}.bin').read_bytes()
            row['constraint_changes_rhs']=before!=after
            assert row['actual_force_calls']>0 and row['constraint_changes_rhs']
        rows.append(row)
        (output/'report.json').write_text(json.dumps({'cases':rows,'sha256':hashes,
            'source_guard_opened':False,'reference_sha256':REFERENCE_SHA},indent=2)+'\n')
        print(row,flush=True)
        assert code==0 and row['finite'] and row['body_moved']
