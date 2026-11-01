"""Serial exact-input PCG diagnosis; no frozen candidate or production change."""
from pathlib import Path
import json,subprocess,sys
root=Path.cwd();base=Path(__file__).resolve().parent
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes()
assert json.loads(saved)['extension_sha256'].startswith('688f9633')
output=base/'pcg-diagnosis-688f9633';output.mkdir(exist_ok=False)
(output/'build.json').write_bytes(saved);(output/'driver.py').write_bytes(Path(__file__).read_bytes())
tasks=[('capture-input4',[sys.executable,str(base/'capture-pcg-input-traces.py')])]
launch='000008.23precondition_and_reduceIN3glm'
for block in (0,1):
    case=f'so3-w3-pd-b{block}'
    capture=base/('first-step-traces-688f9633' if not block else 'pcg-input-traces-688f9633')/case
    tasks.append((f'three-backends-b{block}',[sys.executable,'-m','reconstruction.csrc.pcg_same_buffer_probe',
                  '--directory',str(capture/'original/native'),'--launch',launch,'--trials','32',
                  '--output',str(output/f'three-backends-b{block}')]))
    tasks.append((f'atomic-certificate-b{block}',[sys.executable,'-m','reconstruction.csrc.pcg_grouped_atomic_certificate',
                  '--capture',str(capture),'--launch',launch,'--output',str(output/f'atomic-certificate-b{block}')]))
status={'source_sha256':json.loads(saved)['extension_sha256'],'complete':False,'completed':[],
        'frozen_candidate_replaced':False,'cohort_expanded':False,'whole_solver_complete':False}
for name,command in tasks:
    assert build.read_bytes()==saved
    status['running']=name;(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
    (output/(name+'.command.json')).write_text(json.dumps(command,indent=2)+'\n')
    with (output/(name+'.log')).open('w') as log:
        code=subprocess.run(command,stdout=log,stderr=subprocess.STDOUT,timeout=1800).returncode
    status['completed'].append({'name':name,'exit':code})
    (output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
    print(name,code,flush=True)
    assert code==0
status['complete']=True;status['running']=None
(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
