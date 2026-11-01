"""First two real SDK contact captures, before widening any production guard."""
from pathlib import Path
import json,hashlib,subprocess,sys
import numpy as np
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.csrc.host_api_probe import REFERENCE_SHA
base=Path(__file__).resolve().parent;output=base/'original2-v2';output.mkdir(exist_ok=False)
(output/'driver.py').write_bytes(Path(__file__).read_bytes())
fixture=root/'reconstruction/csrc/driven_cloth_contact_scene.py';hook=root/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes();(output/'build.json').write_bytes(saved)
locked={str(path):hashlib.sha256(path.read_bytes()).hexdigest() for path in (fixture,hook,Path(__file__))}
rows=[]
for kind in ('surface','legacy'):
    folder=output/kind;folder.mkdir()
    force,index=('30evaluate_surface_contact_force',1) if kind=='surface' else ('27evaluate_soft_contact_force',36)
    selected=[('53evaluate_joint_body_spring_augmented_lagrangian_force',10),('25evaluate_joint_drive_load',26),
              ('22evaluate_stretch_force',5),('22evaluate_bending_force',7),('33evaluate_affine_body_spring_force',4)]
    dump=';'.join(f'{token}={arg}:144' for token,arg in selected)+f';{force}=0:4,{index}:144'
    extra=['--rigidity','six-springs','--worlds','1','--seed','1','--mode','newton','--contact-kind',kind]
    command=[sys.executable,'-m','reconstruction.csrc.demo_source_ab','--worker','original','--tag','capture',
             '--example',str(fixture),'--frames','3','--output',str(folder),'--',*extra]
    assert build.read_bytes()==saved and all(hashlib.sha256(Path(path).read_bytes()).hexdigest()==sha for path,sha in locked.items())
    (folder/'command.json').write_text(json.dumps(command,indent=2)+'\n')
    (folder/'dump-protocol.json').write_text(json.dumps({'dump':dump,'limit':9},indent=2)+'\n')
    with (folder/'run.log').open('w') as log:
        code=subprocess.run(command,env={**clean_env(),'LD_PRELOAD':str(hook),'CUDAHOOK_DIR':str(folder),
             'CUDAHOOK_DUMP':dump,'CUDAHOOK_DUMP_LIMIT':'9'},stdout=log,stderr=subprocess.STDOUT,timeout=1800).returncode
    row={'kind':kind,'exit':code}
    if not code:
        runtime=json.loads((folder/'capture.runtime.json').read_text());assert runtime['image_sha256']==REFERENCE_SHA
        with np.load(folder/'capture.npz') as data:row['finite']=all(np.isfinite(data[key]).all() for key in data.files)
        line=next(line for line in (folder/'run.log').read_text().splitlines() if line.startswith('driven_cloth_contact_layout '))
        layout=json.loads(line.split(' ',1)[1]);row['actual_layout']=layout
        prefix=f'dump_{force}_call000'
        before=np.fromfile(folder/f'{prefix}_pre_arg{index}.bin','u4').reshape(-1,3)
        after=np.fromfile(folder/f'{prefix}_post_arg{index}.bin','u4').reshape(-1,3)
        row['first_force_contact_count']=int(np.fromfile(folder/f'{prefix}_pre_arg0.bin','i4')[0])
        row['body_rhs_changed']=before[layout['proxy_indices']].tobytes()!=after[layout['proxy_indices']].tobytes()
        row['cloth_rhs_changed']=before[layout['free_indices']].tobytes()!=after[layout['free_indices']].tobytes()
        row['forces']={token:{'calls':sum(token in line.split()[1] for line in (folder/'launches.txt').read_text().splitlines()),
            'rhs_changed_calls':sum((folder/f'dump_{token}_call{i:03d}_pre_arg{arg}.bin').read_bytes()!=
                (folder/f'dump_{token}_call{i:03d}_post_arg{arg}.bin').read_bytes() for i in range(9))}
            for token,arg in selected+[(force,index)]}
    rows.append(row);(output/'report.json').write_text(json.dumps({'cases':rows,'sha256':locked,
         'production_guard_changed':False,'whole_solver_complete':False},indent=2)+'\n')
    print(row,flush=True)
    assert code==0 and row['finite'] and row['body_rhs_changed'] and row['cloth_rhs_changed']
    assert all(check['calls']==9 and check['rhs_changed_calls']>0 for check in row['forces'].values())
