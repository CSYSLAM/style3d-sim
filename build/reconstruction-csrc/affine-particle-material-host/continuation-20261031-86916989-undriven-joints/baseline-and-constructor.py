import hashlib
import json
from pathlib import Path
import subprocess
import sys
base=Path(__file__).resolve().parent
build=Path('build/reconstruction-csrc/host-particles/build.json')
saved=build.read_bytes()
output=base/'constructor-before-86916989'
output.mkdir(exist_ok=False)
(output/'driver.py').write_bytes(Path(__file__).read_bytes())
(output/'build.json').write_bytes(saved)
status=[]
tasks=[('source4',[sys.executable,str(base/'compare-source-baseline.py')])]
for kind in ('fixed','ball'):
 tasks.append((kind,[sys.executable,'-m','reconstruction.csrc.affine_tetrahedron_contact_constructor_ab',
 '--output',str(output/kind),'--fixture','reconstruction/csrc/undriven_joint_scene.py',
 '--prefix',kind+'-newton-w3','--fixture-args','--joint-kind',kind,'--worlds','3','--seed','3',
 '--mode','newton']))
for name,command in tasks:
 assert build.read_bytes()==saved
 (output/(name+'.command.json')).write_text(json.dumps(command,indent=2)+'\n')
 with (output/(name+'.log')).open('w') as log:
  result=subprocess.run(command,stdout=log,stderr=subprocess.STDOUT,timeout=2400)
 status.append({'task':name,'exit':result.returncode})
 (output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
 print(name,result.returncode,flush=True)
