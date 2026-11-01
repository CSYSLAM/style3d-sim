"""Check one pinned source image against the preserved SDK joint/body-block captures."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import numpy as np
root=Path.cwd().resolve()
sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.csrc.audit_cudahook import compare as compare_launches,schemas
from reconstruction.demo_ab import compare
base=Path(__file__).resolve().parent
reference=base/'original16'
proof=json.loads((reference/'report.json').read_text())
build=root/'build/reconstruction-csrc/host-particles/build.json'
saved=build.read_bytes()
metadata=json.loads(saved)
output=base/('source16-'+metadata['extension_sha256'][:8])
output.mkdir(exist_ok=False)
(output/'build.json').write_bytes(saved)
(output/'driver.py').write_bytes(Path(__file__).read_bytes())
assert all(hashlib.sha256(Path(p).read_bytes()).hexdigest()==h for p,h in proof['sha256'].items())
hook=root/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
rows=[]
for old_row in proof['cases']:
    name=old_row['case']
    old=reference/name
    runtime=json.loads((old/'capture.runtime.json').read_text())
    folder=output/name
    folder.mkdir()
    command=[sys.executable,'-m','reconstruction.csrc.demo_source_ab','--worker','source','--tag','capture',
             '--example',runtime['example'],'--frames',str(runtime['frames']),'--output',str(folder),'--',
             *runtime['extra']]
    (folder/'command.json').write_text(json.dumps(command,indent=2)+'\n')
    assert build.read_bytes()==saved
    worlds=int(runtime['extra'][runtime['extra'].index('--worlds')+1])
    token,index='53evaluate_joint_body_spring_augmented_lagrangian_force',10
    assert schemas()[0][token][index]=='pointer'
    with (folder/'run.log').open('w') as log:
        code=subprocess.run(command,env={**clean_env(),'LD_PRELOAD':str(hook),'CUDAHOOK_DIR':str(folder),
            'CUDAHOOK_DUMP':f'{token}={index}:{8*worlds*12}','CUDAHOOK_DUMP_LIMIT':'1'},
                            stdout=log,stderr=subprocess.STDOUT,timeout=900).returncode
    row={'case':name,'exit':code,'passed':False}
    if not code:
        with np.load(old/'capture.npz') as a,np.load(folder/'capture.npz') as b:
            row['states']=compare(a,b)
            row['finite']=all(np.isfinite(b[k]).all() for k in b.files)
        row['metadata']=compare_launches(old/'launches.txt',folder/'launches.txt',schemas()[0])
        counts=json.loads((folder/'capture.launches.json').read_text())
        row['coverage']=sum(counts.values())==row['metadata']['right_launches']
        row['first_force_buffers_equal']=all(
            (old/f'dump_{token}_{phase}_arg{index}.bin').read_bytes()==
            (folder/f'dump_{token}_{phase}_arg{index}.bin').read_bytes() for phase in ('pre','post'))
        current=json.loads((folder/'capture.runtime.json').read_text())
        assert current['image_sha256']==metadata['extension_sha256']
        assert current['example_sha256']==runtime['example_sha256']
        row['passed']=row['states']['bitwise'] and row['finite'] and row['metadata']['equal'] and row['coverage'] and row['first_force_buffers_equal']
    rows.append(row)
    (output/'report.json').write_text(json.dumps({'source_sha256':metadata['extension_sha256'],'cases':rows,
        'whole_solver_complete':False,'runner_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()},
        indent=2)+'\n')
    print(name,'exit',code,'passed',row['passed'],'metadata',row.get('metadata',{}).get('equal'),flush=True)
    assert code==0
