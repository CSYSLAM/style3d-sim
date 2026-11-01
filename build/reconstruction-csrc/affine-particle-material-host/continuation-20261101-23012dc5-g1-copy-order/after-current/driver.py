"""Run current regression C10, an uncaptured-host reference pilot and resource diagnostics strictly in sequence."""
from pathlib import Path
import hashlib,json,subprocess,sys
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
base=Path(__file__).resolve().parent
validation=base/'validation'
assert json.loads((validation/'status.json').read_text())['complete']
regression=json.loads((validation/'regression74/status.json').read_text());assert regression['complete']
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes();meta=json.loads(saved)
assert meta['extension_sha256']==regression['source_sha256']
out=base/'after-current';out.mkdir(exist_ok=False)
(out/'driver.py').write_bytes(Path(__file__).read_bytes());(out/'build.json').write_bytes(saved)
status={'complete':False,'completed':[],'running':None,'source_sha256':meta['extension_sha256'],'whole_solver_complete':False}
jobs=[]
if any(row['exit'] for row in regression['completed']):
 jobs += [ ('regression-fixed-C10',['-m','reconstruction.csrc.regression_fixed_spread','--validation',str(validation),
             '--output',str(validation/'regression-fixed-C10')]),
           ('regression-fixed-C10-cpu',['-m','reconstruction.csrc.audit_regression_fixed_spread',
            '--cohort',str(validation/'regression-fixed-C10'),'--report','report.json',
            '--output',str(validation/'regression-fixed-C10/cpu-audit.json')])]
pilot=base.parent/'continuation-20261101-141c18f6-plain-contact/capture-original-pilot6.py'
jobs += [('plain-contact-original-pilot6',[str(pilot)]),
         ('kernel-resources',['-m','reconstruction.csrc.kernel_resource_audit','--output',str(out/'kernel-resources')])]
for name,args in jobs:
 assert build.read_bytes()==saved
 for path,digest in meta['sources'].items():assert hashlib.sha256((root/path).read_bytes()).hexdigest()==digest
 status['running']=name;(out/'status.json').write_text(json.dumps(status,indent=2)+'\n')
 command=[sys.executable,*args];(out/(name+'.command.json')).write_text(json.dumps(command,indent=2)+'\n')
 with (out/(name+'.log')).open('w') as log:
  code=subprocess.run(command,env=clean_env(),stdout=log,stderr=subprocess.STDOUT,timeout=14400).returncode
 if name=='regression-fixed-C10':
  assert code in (0,1)
  results=json.loads((validation/'regression-fixed-C10/report.json').read_text())
  assert len(results['cases'])==sum(bool(row['exit']) for row in regression['completed'])
  assert code==int(any(not row['every_array_and_step_within'] for row in results['cases']))
 else:assert code==0,(name,code)
 status['completed'].append({'name':name,'exit':code});print(name,code,flush=True)
status['complete'],status['running']=True,None
(out/'status.json').write_text(json.dumps(status,indent=2)+'\n')
