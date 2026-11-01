"""Current penalty image broad regression, standalone graph tests and fixed official cloth reference check."""
import json
from pathlib import Path
import subprocess,sys
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
base=Path(__file__).resolve().parent
build=json.loads((root/'build/reconstruction-csrc/host-particles/build.json').read_text())
validation=base/('validation-'+build['extension_sha256'][:8])
status=json.loads((validation/'status.json').read_text())
assert status['complete'] and all(r['exit']==0 for r in status['finished'])
rows=[]
commands=[('regression',[sys.executable,'-u',str(base/'run-regression.py')]),
 ('frontends',[sys.executable,'-u',str(base/'run-frontends.py')]),
 ('official-cloth-recheck',[sys.executable,'-m','reconstruction.csrc.official_cloth_balls_recheck',
  '--baseline','build/reconstruction-csrc/affine-particle-material-host/validation-cc09a3c0/official-cloth-balls60',
  '--output',str(validation/'official-cloth-fixed-original8')])]
for name,command in commands:
 (base/(name+'.command.json')).write_text(json.dumps(command,indent=2)+'\n')
 with (base/(name+'-driver.log')).open('w') as log:
  code=subprocess.run(command,env=clean_env(),stdout=log,stderr=subprocess.STDOUT,timeout=14400).returncode
 rows.append({'name':name,'exit':code})
 (base/'after-local-status.json').write_text(json.dumps(rows,indent=2)+'\n')
 print(name,code,flush=True)
 assert code in (0,1)
