from pathlib import Path
import json,os,subprocess,sys,hashlib
root=Path.cwd();phase=Path(__file__).resolve().parent;folder=phase/'source-common-force-capture';folder.mkdir(exist_ok=False)
fields=json.loads((phase/'common-force-capture/fields.json').read_text());(folder/'fields.json').write_text(json.dumps(fields,indent=2)+'\n')
dump='30evaluate_surface_contact_force='+','.join(f'0+{offset}:{value[1]}' if int(offset) else f'0:{value[1]}' for offset,value in fields.items())+',1:20820'
hook=root/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
env={k:v for k,v in os.environ.items() if not k.startswith(('CUDAHOOK_','DEMO_','RECON_ORACLE_')) and k not in ('STYLE3D_SIM_ACCOUNT','STYLE3D_SIM_PASSWORD','LD_PRELOAD')}
env.update(LD_PRELOAD=str(hook),CUDAHOOK_DIR=str(folder),CUDAHOOK_DUMP=dump,CUDAHOOK_DUMP_LIMIT='1')
command=[sys.executable,'-m','reconstruction.csrc.official_cloth_contact_replay','--backend','source','--input',str(phase/'common-contact-input'),'--output',str(folder/'worker')]
(folder/'command.json').write_text(json.dumps(command,indent=2)+'\n')
with (folder/'run.log').open('w') as log:subprocess.run(command,env=env,stdout=log,stderr=subprocess.STDOUT,check=True,timeout=1800)
assert (root/'build/reconstruction-csrc/host-particles/build.json').read_bytes()==(phase/'build.json').read_bytes()
(folder/'capture.runtime.json').write_bytes((folder/'worker/runtime.json').read_bytes())
(folder/'runtime-adoption.json').write_text(json.dumps({'from':'worker/runtime.json','to':'capture.runtime.json','sha256':hashlib.sha256((folder/'worker/runtime.json').read_bytes()).hexdigest(),'harness':'official_cloth_balls_ab.py via official_cloth_contact_replay.py','acceptance_cohort_changed':False},indent=2)+'\n')
print('source actual common first force captured',flush=True)
command=[sys.executable,'-m','reconstruction.csrc.surface_sum_witness_completion','--replay',str(phase/'common-force-three-backends'),'--capture',str(phase/'common-force-capture'),'--source-capture',str(folder),'--resume',str(phase/'common-force-exact-sums.json'),'--output',str(phase/'common-force-both-paths-exact-sums.json')]
(phase/'both-force-witness.command.json').write_text(json.dumps(command,indent=2)+'\n')
subprocess.run(command,check=True,env={k:v for k,v in env.items() if k!='LD_PRELOAD' and not k.startswith('CUDAHOOK_')})
