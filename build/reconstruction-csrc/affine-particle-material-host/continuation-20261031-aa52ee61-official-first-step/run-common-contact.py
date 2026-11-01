from pathlib import Path
import hashlib,json,os,subprocess,sys,time
root=Path.cwd();phase=Path(__file__).resolve().parent
saved=(phase/'build.json').read_bytes();build=root/'build/reconstruction-csrc/host-particles/build.json'
input_folder=phase/'common-contact-input'
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
locked={str(p):sha(p) for p in (root/'reconstruction/csrc/official_cloth_balls_ab.py',root/'examples/example_cloth_balls.py',root/'reconstruction/csrc/official_cloth_contact_replay.py',phase/'observer/observer.so',input_folder/'native-input.npz',input_folder/'native-input.json')}
state={'jobs_fixed_before_run':['original-common0','source-common0'],'complete':False,'completed':[],'sha256':locked,'acceptance_cohort_changed':False}
path=phase/'common-contact-status.json';path.write_text(json.dumps(state,indent=2)+'\n')
env={k:v for k,v in os.environ.items() if not k.startswith(('CUDAHOOK_','DEMO_','RECON_ORACLE_')) and k not in ('STYLE3D_SIM_ACCOUNT','STYLE3D_SIM_PASSWORD','LD_PRELOAD')}
env['LD_PRELOAD']=str(phase/'observer/observer.so')
for tag in state['jobs_fixed_before_run']:
 assert build.read_bytes()==saved
 assert all(sha(Path(p))==h for p,h in locked.items())
 backend=tag.split('-')[0];out=phase/tag
 command=[sys.executable,'-m','reconstruction.csrc.official_cloth_contact_replay','--backend',backend,'--input',str(input_folder),'--output',str(out),'--observe']
 (phase/f'{tag}.command.json').write_text(json.dumps(command,indent=2)+'\n')
 state['running']=tag;path.write_text(json.dumps(state,indent=2)+'\n');start=time.time()
 with (phase/f'{tag}.log').open('w') as log:
  code=subprocess.run(command,env=env,stdout=log,stderr=subprocess.STDOUT,timeout=1800).returncode
 row={'tag':tag,'returncode':code,'seconds':time.time()-start};state['completed'].append(row);path.write_text(json.dumps(state,indent=2)+'\n')
 assert code==0,row
 print(tag,'complete',flush=True)
state.update(complete=True,running=None);path.write_text(json.dumps(state,indent=2)+'\n')
