"""Capture the actual PD joint route before changing any source host guard."""
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
output=base/'original4'
output.mkdir(exist_ok=False)
build=root/'build/reconstruction-csrc/host-particles/build.json'
saved=build.read_bytes()
(output/'build.json').write_bytes(saved)
fixture=root/'reconstruction/csrc/joint_pd_scene.py'
hook=root/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
inputs=(fixture,root/'reconstruction/csrc/joint_body_scene.py',root/'reconstruction/csrc/demo_source_ab.py',hook)
hashes={str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in inputs}
rows=[]
for kind in ('revolute','prismatic'):
    for worlds in (1,3):
        name=f'{kind}-w{worlds}'
        folder=output/name
        folder.mkdir()
        extra=['--joint-kind',kind,'--worlds',str(worlds),'--seed',str(worlds),'--armature','.007',
               '--derive-velocity']
        command=[sys.executable,'-m','reconstruction.csrc.demo_source_ab','--worker','original','--tag','capture',
                 '--example',str(fixture),'--frames','3','--output',str(folder),'--',*extra]
        (folder/'command.json').write_text(json.dumps(command,indent=2)+'\n')
        assert build.read_bytes()==saved
        assert all(hashlib.sha256(Path(p).read_bytes()).hexdigest()==h for p,h in hashes.items())
        with (folder/'run.log').open('w') as log:
            code=subprocess.run(command,env={**clean_env(),'LD_PRELOAD':str(hook),'CUDAHOOK_DIR':str(folder)},
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
        rows.append(row)
        (output/'report.json').write_text(json.dumps({'cases':rows,'sha256':hashes,
            'source_guard_opened':False,'reference_sha256':REFERENCE_SHA},indent=2)+'\n')
        print(row,flush=True)
        assert code==0 and row['finite'] and row['body_moved']
