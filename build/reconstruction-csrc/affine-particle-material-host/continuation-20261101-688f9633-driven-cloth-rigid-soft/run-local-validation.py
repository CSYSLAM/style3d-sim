"""Validate current contact-host constructors, real graphs and both initcheck backends serially."""
from pathlib import Path
import hashlib,json,subprocess,sys
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
base=Path(__file__).resolve().parent
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes();metadata=json.loads(saved)
proof=json.loads((base/('source64-'+metadata['extension_sha256'][:8])/'report.json').read_text())
assert proof['complete'] and len(proof['cases'])==64
assert all(row['exit']==0 and row['metadata']['equal'] and row['coverage'] and row['finite'] for row in proof['cases'])
output=base/('validation-'+metadata['extension_sha256'][:8]);output.mkdir(exist_ok=False)
(output/'build.json').write_bytes(saved);(output/'driver.py').write_bytes(Path(__file__).read_bytes())
tasks=[]
for group,fixture in [('soft','driven_cloth_contact_scene.py'),('rigid-soft','driven_cloth_rigid_soft_scene.py')]:
 for kind in ('surface','legacy'):
  for rigidity in ('so3','six-springs'):
   for mode in ('newton','pd'):
    name=f'{group}-{kind}-{rigidity}-{mode}-constructor'
    prefix=f'{group}-{kind}-{rigidity}-{mode}-w3'
    tasks.append((name,[sys.executable,'-m','reconstruction.csrc.affine_tetrahedron_contact_constructor_ab',
      '--output',str(output/name),'--fixture',str(root/'reconstruction/csrc'/fixture),'--prefix',prefix,
      '--fixture-args','--rigidity',rigidity,'--worlds','3','--seed','3','--mode',mode,'--contact-kind',kind,'--body-block']))
for group in ('soft','rigid-soft'):
 name=group+'-graph60'
 tasks.append((name,[sys.executable,'-m','reconstruction.csrc.driven_cloth_contact_graph_ab',
              '--contact-group',group,'--output',str(output/name)]))
sanitizer=root/'build/toolchains/diagnostics-13.2/compute-sanitizer/compute-sanitizer'
for group in ('soft','rigid-soft'):
 for backend in ('original','source'):
  name=f'{group}-initcheck3-{backend}'
  tasks.append((name,[str(sanitizer),'--tool','initcheck','--error-exitcode','99',sys.executable,'-m',
    'reconstruction.csrc.driven_cloth_contact_graph_ab','--contact-group',group,'--worker',backend,
    '--frames','3','--output',str(output/name)]))
status={'source_sha256':metadata['extension_sha256'],'complete':False,'completed':[],
        'source64_strict_passed':sum(row['passed'] for row in proof['cases']),'source64_total':64,
        'source64_metadata_equal':64,'whole_solver_complete':False,'regression74_collected':False}
for name,command in tasks:
 assert build.read_bytes()==saved
 assert all(hashlib.sha256((root/path).read_bytes()).hexdigest()==sha for path,sha in metadata['sources'].items())
 if '-initcheck3-' in name:(output/name).mkdir(exist_ok=False)
 (output/(name+'.command.json')).write_text(json.dumps(command,indent=2)+'\n')
 status['running']=name;(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
 with (output/(name+'.log')).open('w') as log:
  code=subprocess.run(command,env=clean_env(),stdout=log,stderr=subprocess.STDOUT,timeout=7200).returncode
 status['completed'].append({'name':name,'exit':code});(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
 print(name,code,flush=True)
 assert code in (0,1)
 if name.endswith('-graph60'):assert (output/name/'report.json').exists()
 else:assert code==0
status['complete']=True;status['running']=None
(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
