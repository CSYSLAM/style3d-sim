"""Validate the recovered PD point-line host schedule on one immutable image."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys
root=Path.cwd().resolve()
sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
base=Path(__file__).resolve().parent
build=root/'build/reconstruction-csrc/host-particles/build.json'
saved=build.read_bytes()
metadata=json.loads(saved)
assert all(x['passed'] for x in json.loads((base/('source32-'+metadata['extension_sha256'][:8])/'report.json').read_text())['cases'])
output=base/('validation-'+metadata['extension_sha256'][:8])
output.mkdir(exist_ok=False)
(output/'build.json').write_bytes(saved)
(output/'driver.py').write_bytes(Path(__file__).read_bytes())
fixture=root/'reconstruction/csrc/plain_body_mixed_scene.py'
tasks=[]
for kind in ('spring-line','spring-distance','line-distance','all'):
    for mode in ('newton','pd'):
        name=f'{kind}-{mode}-constructor'
        tasks.append((name,[sys.executable,'-m','reconstruction.csrc.affine_tetrahedron_contact_constructor_ab',
            '--output',str(output/name),'--fixture',str(fixture),'--prefix',f'block-{kind}-{mode}-w3',
            '--original-capture',str(base/'validation-6a514e46'/name),
            '--fixture-args','--constraints',kind,'--worlds','3','--seed','3','--mode',mode,'--body-block']))
tasks.append(('graph60-matrix32',[sys.executable,'-m','reconstruction.csrc.plain_body_mixed_graph_ab',
              '--output',str(output/'graph60-matrix32')]))
sanitizer=root/'build/toolchains/diagnostics-13.2/compute-sanitizer/compute-sanitizer'
for backend in ('original','source'):
    name='initcheck3-'+backend
    tasks.append((name,[str(sanitizer),'--tool','initcheck','--error-exitcode','99',sys.executable,'-m',
        'reconstruction.csrc.plain_body_mixed_graph_ab','--worker',backend,'--frames','3','--output',str(output/name)]))
status={'source_sha256':metadata['extension_sha256'],'running':None,'finished':[],'complete':False,
        'regression74_collected':False,'whole_solver_complete':False}
for name,command in tasks:
    assert build.read_bytes()==saved
    for path,sha in metadata['sources'].items():
        assert hashlib.sha256((root/path).read_bytes()).hexdigest()==sha,path
    if name.startswith('initcheck'):
        (output/name).mkdir(exist_ok=False)
    status['running']=name
    (output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
    (output/(name+'.command.json')).write_text(json.dumps(command,indent=2)+'\n')
    with (output/(name+'.log')).open('w') as log:
        code=subprocess.run(command,env=clean_env(),stdout=log,stderr=subprocess.STDOUT,timeout=7200).returncode
    status['finished'].append({'name':name,'exit':code})
    print(name,code,flush=True)
    assert code in (0,1)
    if name.startswith('initcheck') or name.endswith('constructor'):
        assert code==0
status['complete'],status['running']=True,None
(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
