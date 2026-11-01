from pathlib import Path
import hashlib,json,os,subprocess,sys
root=Path.cwd();phase=Path(__file__).resolve().parent;folder=phase/'common-force-capture';folder.mkdir(exist_ok=False)
fields=json.loads((root/'build/reconstruction-csrc/affine-particle-material-host/validation-ff34e6a1/official-inputs-original/fields.json').read_text())
(folder/'fields.json').write_text(json.dumps(fields,indent=2)+'\n')
dump='30evaluate_surface_contact_force='+','.join(f'0+{offset}:{value[1]}' if int(offset) else f'0:{value[1]}' for offset,value in fields.items())+',1:20820'
hook=root/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
env={k:v for k,v in os.environ.items() if not k.startswith(('CUDAHOOK_','DEMO_','RECON_ORACLE_')) and k not in ('STYLE3D_SIM_ACCOUNT','STYLE3D_SIM_PASSWORD','LD_PRELOAD')}
env.update(LD_PRELOAD=str(hook),CUDAHOOK_DIR=str(folder),CUDAHOOK_DUMP=dump,CUDAHOOK_DUMP_LIMIT='1')
command=[sys.executable,'-m','reconstruction.csrc.official_cloth_contact_replay','--backend','original','--input',str(phase/'common-contact-input'),'--output',str(folder/'worker')]
(folder/'command.json').write_text(json.dumps(command,indent=2)+'\n')
with (folder/'run.log').open('w') as log:subprocess.run(command,env=env,stdout=log,stderr=subprocess.STDOUT,check=True,timeout=1800)
assert (root/'build/reconstruction-csrc/host-particles/build.json').read_bytes()==(phase/'build.json').read_bytes()
print('actual common first force captured',flush=True)
command=[sys.executable,'-m','reconstruction.csrc.surface_common_input_replay','--capture',str(folder),'--output',str(phase/'common-force-three-backends')]
(phase/'common-force-replay.command.json').write_text(json.dumps(command,indent=2)+'\n')
with (phase/'common-force-replay.log').open('w') as log:
 code=subprocess.run(command,env={k:v for k,v in env.items() if k!='LD_PRELOAD' and not k.startswith('CUDAHOOK_')},stdout=log,stderr=subprocess.STDOUT,timeout=1800).returncode
(phase/'common-force-replay-status.json').write_text(json.dumps({'returncode':code,'acceptance_cohort_changed':False,'production_changed':False})+'\n')
assert code==0
print('actual common first force three backend replay complete',flush=True)
