from pathlib import Path
import hashlib,json,os,subprocess,sys,time
import numpy as np
root=Path.cwd();phase=Path(__file__).resolve().parent
saved=(phase/'build.json').read_bytes();build=root/'build/reconstruction-csrc/host-particles/build.json'
fixture=root/'reconstruction/csrc/official_cloth_balls_ab.py';example=root/'examples/example_cloth_balls.py'
frozen=root/'build/reconstruction-csrc/affine-particle-material-host/continuation-20261031-6a7061d7-penalty-joints/validation-aa52ee61/official-cloth-fixed-original8'
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
locked={str(p):sha(p) for p in (fixture,example,root/'reconstruction/csrc/official_cloth_failure_trace.py',phase/'observer/observer.so')}
state={'complete':False,'jobs_fixed_before_run':['original0','source0','source1','source2'],'acceptance_cohort_changed':False,'completed':[],'sha256':locked}
(phase/'status.json').write_text(json.dumps(state,indent=2)+'\n')
env={k:v for k,v in os.environ.items() if k not in ('STYLE3D_SIM_ACCOUNT','STYLE3D_SIM_PASSWORD','LD_PRELOAD','CUDAHOOK_DIR','CUDAHOOK_DUMP','CUDAHOOK_DUMP_LIMIT','DEMO_MEMORY_TRACE_DIR','DEMO_NATIVE_TRACE_DIR','DEMO_NATIVE_TRACE_SUBSTEPS')}
env['LD_PRELOAD']=str(phase/'observer/observer.so')
for tag in state['jobs_fixed_before_run']:
    assert build.read_bytes()==saved
    assert all(sha(Path(p))==h for p,h in locked.items())
    backend='original' if tag.startswith('original') else 'source'
    output=phase/tag
    command=[sys.executable,'-m','reconstruction.csrc.official_cloth_failure_trace','--backend',backend,'--output',str(output)]
    (phase/f'{tag}.command.json').write_text(json.dumps(command,indent=2)+'\n')
    state['running']=tag;(phase/'status.json').write_text(json.dumps(state,indent=2)+'\n')
    start=time.time()
    with (phase/f'{tag}.log').open('w') as log:
        code=subprocess.run(command,env=env,stdout=log,stderr=subprocess.STDOUT,timeout=1800).returncode
    row={'tag':tag,'returncode':code,'seconds':time.time()-start}
    state['completed'].append(row);(phase/'status.json').write_text(json.dumps(state,indent=2)+'\n')
    assert code==0,row
    counts=list((output/'native').glob('*evaluate_surface*before.count.bin'))
    assert counts and all(np.fromfile(p,'i4').tolist()==[1380] for p in counts)
    receipt=json.loads((output/'native/deferred-receipt.json').read_text())
    assert not receipt['per_snapshot_host_synchronization']
    with np.load(output/'states.npz') as data:
        rows=[]
        for candidate in ([f'eager-original{i}' for i in range(8)] if backend=='original' else [f'eager-source{i}' for i in range(3)]):
            path=frozen/candidate/'states.npz'
            with np.load(path) as original:
                checks={key:bool(np.array_equal(data[key][0].view('u1'),original[key][0].view('u1'))) for key in data.files}
                rows.append({'candidate':candidate,'first_substep_equal':checks,'all':all(checks.values()),'npz_sha256':sha(path)})
        (output/'frozen-first-substep-comparison.json').write_text(json.dumps({'diagnostic_sha256':sha(output/'states.npz'),'rows':rows,'surface_count_prefix_checked':1380,'receipt':receipt},indent=2)+'\n')
    print(tag,'receipt',receipt,'matches',[r['candidate'] for r in rows if r['all']],flush=True)
state['complete']=True;state['running']=None;(phase/'status.json').write_text(json.dumps(state,indent=2)+'\n')
