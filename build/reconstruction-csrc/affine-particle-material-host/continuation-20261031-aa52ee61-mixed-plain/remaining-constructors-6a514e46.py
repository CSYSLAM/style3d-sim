from pathlib import Path
import json,subprocess,sys
root=Path.cwd();base=Path(__file__).resolve().parent;output=base/'validation-6a514e46'
saved=(output/'build.json').read_bytes();fixture=root/'reconstruction/csrc/plain_body_mixed_scene.py';rows=[]
(output/'VALIDATION_STOP.json').write_text(json.dumps({'failed':'line-distance-newton-constructor','returncode':1,'original_status_preserved':True,'states32_passed':True,'graph_not_started':True,'fix_not_applied':True},indent=2)+'\n')
for kind,mode in (('line-distance','pd'),('all','newton'),('all','pd')):
 assert (root/'build/reconstruction-csrc/host-particles/build.json').read_bytes()==saved
 name=f'{kind}-{mode}-constructor'
 command=[sys.executable,'-m','reconstruction.csrc.affine_tetrahedron_contact_constructor_ab','--output',str(output/name),'--fixture',str(fixture),'--prefix',f'block-{kind}-{mode}-w3','--fixture-args','--constraints',kind,'--worlds','3','--seed','3','--mode',mode,'--body-block']
 (output/(name+'.command.json')).write_text(json.dumps(command,indent=2)+'\n')
 with (output/(name+'.log')).open('w') as log:code=subprocess.run(command,stdout=log,stderr=subprocess.STDOUT,timeout=1800).returncode
 assert code in (0,1)
 rows.append({'name':name,'exit':code});(output/'remaining-constructor-status.json').write_text(json.dumps({'complete':False,'finished':rows},indent=2)+'\n')
 print(name,code,flush=True)
(output/'remaining-constructor-status.json').write_text(json.dumps({'complete':True,'finished':rows},indent=2)+'\n')
