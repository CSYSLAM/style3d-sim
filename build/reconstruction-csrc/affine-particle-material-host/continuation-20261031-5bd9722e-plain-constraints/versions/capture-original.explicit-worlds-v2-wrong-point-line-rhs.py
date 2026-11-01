"""Capture plain spring/point-line/distance modes and body blocks before changing source guards."""
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
base=Path(__file__).resolve().parent
output=base/'original24-explicit-worlds'
output.mkdir(exist_ok=False)
build=root/'build/reconstruction-csrc/host-particles/build.json'
saved=build.read_bytes()
(output/'build.json').write_bytes(saved)
fixture=root/'reconstruction/csrc/plain_body_constraint_scene.py'
hook=root/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
inputs=(fixture,root/'reconstruction/csrc/demo_source_ab.py',hook)
hashes={str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in inputs}
rows=[]
cases=[(k,w,m,b) for k in ('spring','point-line','distance') for w in (1,3)
       for m in ('newton','pd') for b in (False,True)]
for kind,worlds,mode,block in cases:
        name=f'{kind}-w{worlds}-{mode}-b{int(block)}'
        folder=output/name
        folder.mkdir()
        extra=['--constraint',kind,'--worlds',str(worlds),'--seed',str(worlds),'--mode',mode]
        if block:extra.append('--body-block')
        n=8*worlds
        token,index = {'spring':('26evaluate_body_spring_force',12),
                       'point-line':('30evaluate_body_point_line_force',13),
                       'distance':('39evaluate_body_distance_constraint_force',11)}[kind]
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
