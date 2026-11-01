"""Eight diagnostic traces planned before launch; preserve all fixed states and capture protocols."""
from pathlib import Path
import hashlib,json,subprocess,sys
import numpy as np
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.csrc.audit_cudahook import compare as compare_launches,schemas
from reconstruction.demo_ab import compare
base=Path(__file__).resolve().parent
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes()
image=json.loads(saved)['extension_sha256']
output=base/('pcg-input-traces-v2-'+image[:8]);output.mkdir(exist_ok=False)
(output/'build.json').write_bytes(saved);(output/'driver.py').write_bytes(Path(__file__).read_bytes())
observer=base/'observer-precomputed-input-v2/observer.so'
hook=root/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
proof=json.loads((base/('source16-'+image[:8])/'report.json').read_text())
failed=[row['case'] for row in proof['cases'] if not row['passed']]
assert len(failed)==4
failed = [case for case in failed if case == 'so3-w3-pd-b1']
assert len(failed) == 1
status={'source_sha256':image,'plan':[(case,backend) for case in failed for backend in ('original','source')],
        'completed':[],'complete':False,'frozen_candidate_replaced':False,'cohort_expanded':False,
        'observer_sha256':hashlib.sha256(observer.read_bytes()).hexdigest()}
for case,backend in status['plan']:
    assert build.read_bytes()==saved
    reference=base/'original16'/case
    frozen=reference if backend=='original' else base/('source16-'+image[:8])/case
    runtime=json.loads((reference/'capture.runtime.json').read_text())
    folder=output/case/backend;folder.mkdir(parents=True)
    worlds=int(runtime['extra'][runtime['extra'].index('--worlds')+1])
    rigidity=runtime['extra'][runtime['extra'].index('--rigidity')+1]
    fields=[('53evaluate_joint_body_spring_augmented_lagrangian_force',10),('25evaluate_joint_drive_load',26),
            ('22evaluate_stretch_force',5),('22evaluate_bending_force',7),
            ('51evaluate_affine_body_so3_augmented_lagrangian_force',6) if rigidity=='so3' else
            ('33evaluate_affine_body_spring_force',4)]
    dump=';'.join(f'{token}={index}:{12*worlds*12}' for token,index in fields)
    command=[sys.executable,'-m','reconstruction.csrc.demo_source_ab','--worker',backend,'--tag','capture',
             '--example',runtime['example'],'--frames',str(runtime['frames']),'--output',str(folder),'--',*runtime['extra']]
    (folder/'command.json').write_text(json.dumps(command,indent=2)+'\n')
    status['running']=[case,backend];(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
    with (folder/'run.log').open('w') as log:
        code=subprocess.run(command,env={**clean_env(),'LD_PRELOAD':str(observer)+':'+str(hook),
             'CUDAHOOK_DIR':str(folder),'CUDAHOOK_DUMP':dump,'CUDAHOOK_DUMP_LIMIT':'9',
             'DEMO_NATIVE_TRACE_DIR':str(folder/'native'),'DEMO_NATIVE_TRACE_SUBSTEPS':'1'},
             stdout=log,stderr=subprocess.STDOUT,timeout=1800).returncode
    row={'case':case,'backend':backend,'exit':code}
    if not code:
        with np.load(frozen/'capture.npz') as a,np.load(folder/'capture.npz') as b:
            row['frozen_state_comparison']=compare(a,b)
            row['first_step_reproduced']=all(a[key][0].tobytes()==b[key][0].tobytes() for key in a.files)
        row['frozen_npz_sha256']=hashlib.sha256((frozen/'capture.npz').read_bytes()).hexdigest()
        row['actual_npz_sha256']=hashlib.sha256((folder/'capture.npz').read_bytes()).hexdigest()
        row['metadata']=compare_launches(reference/'launches.txt',folder/'launches.txt',schemas()[0])
        row['receipt']=json.loads((folder/'native/deferred-receipt.json').read_text())
        assert row['metadata']['equal'] and not row['receipt']['per_snapshot_host_synchronization']
        # Check actual final buffers against the public output, not assumed stream completion.
        with np.load(folder/'capture.npz') as actual:
            applies=sorted((folder/'native').glob('*.20apply_nonlinear_stepE.after.q.bin'))
            velocities=sorted((folder/'native').glob('*.15update_velocityE.after.v.bin'))
            assert len(applies)==3 and len(velocities)==1
            assert applies[-1].read_bytes()==actual['particle_q'][0].tobytes()
            assert velocities[-1].read_bytes()==actual['particle_qd'][0].tobytes()
        row['captured_step_output_validated']=True
    status['completed'].append(row)
    (output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
    print(case,backend,code,'first step reproduced',row.get('first_step_reproduced'),flush=True)
    assert code==0
status['complete']=True;status['running']=None
(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
