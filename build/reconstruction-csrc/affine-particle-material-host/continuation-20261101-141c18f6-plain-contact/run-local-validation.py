"""Validate the captured plain/contact host in constructors, real graphs and initcheck, serially."""
from pathlib import Path
import hashlib,json,subprocess,sys
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
base=Path(__file__).resolve().parent
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes();meta=json.loads(saved)
proof=json.loads((base/('source24-'+meta['extension_sha256'][:8])/'report.json').read_text())
assert proof['complete'] and len(proof['cases'])==24
assert all(row['exit']==0 and row['metadata']['equal'] and row['source_coverage_equal'] and row['finite'] for row in proof['cases'])
output=base/('validation-'+meta['extension_sha256'][:8]);output.mkdir(exist_ok=False)
(output/'build.json').write_bytes(saved);(output/'driver.py').write_bytes(Path(__file__).read_bytes())
tasks=[]
for kind in ('spring','point-line','distance'):
 for mode in ('newton','pd'):
  name=f'{kind}-{mode}-constructor'
  tasks.append((name,[sys.executable,'-m','reconstruction.csrc.affine_tetrahedron_contact_constructor_ab',
   '--fixture',str(root/'reconstruction/csrc/plain_body_contact_scene.py'),'--prefix',f'plain-contact-{kind}-{mode}-w3',
   '--output',str(output/name),'--fixture-args','--constraint',kind,'--worlds','3','--seed','3','--mode',mode,'--body-block']))
tasks.append(('graph60',[sys.executable,'-m','reconstruction.csrc.plain_body_contact_graph_ab','--output',str(output/'graph60')]))
sanitizer=root/'build/toolchains/diagnostics-13.2/compute-sanitizer/compute-sanitizer'
for backend in ('original','source'):
 name='initcheck3-'+backend
 tasks.append((name,[str(sanitizer),'--tool','initcheck','--error-exitcode','99',sys.executable,'-m',
  'reconstruction.csrc.plain_body_contact_graph_ab','--worker',backend,'--frames','3','--output',str(output/name)]))
status={'source_sha256':meta['extension_sha256'],'complete':False,'completed':[],'running':None,'whole_solver_complete':False}
for name,command in tasks:
 assert build.read_bytes()==saved
 for path,digest in meta['sources'].items():assert hashlib.sha256((root/path).read_bytes()).hexdigest()==digest
 if name.startswith('initcheck3-'):(output/name).mkdir(exist_ok=False)
 (output/(name+'.command.json')).write_text(json.dumps(command,indent=2)+'\n')
 status['running']=name;(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
 with (output/(name+'.log')).open('w') as log:
  code=subprocess.run(command,env=clean_env(),stdout=log,stderr=subprocess.STDOUT,timeout=7200).returncode
 status['completed'].append({'name':name,'exit':code});(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
 print(name,code,flush=True)
 if name=='graph60':assert code in (0,1) and (output/name/'report.json').exists()
 else:assert code==0,(name,code)
status['complete'],status['running']=True,None
(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
