"""Finish exact PCG diagnosis, fixed graph cohort and current-image regression, strictly serially."""
from pathlib import Path
import json,subprocess,sys,hashlib
root=Path.cwd();base=Path(__file__).resolve().parent
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes();metadata=json.loads(saved)
assert metadata['extension_sha256'].startswith('688f9633')
assert json.loads((base/'fixed-C8-688f9633/status.json').read_text())['complete']
output=base/'after-fixed-C8';output.mkdir(exist_ok=False)
(output/'build.json').write_bytes(saved);(output/'driver.py').write_bytes(Path(__file__).read_bytes())
capture=base/'pcg-input-traces-v2-688f9633/so3-w3-pd-b1'
validation=base/'validation-688f9633'
launch='000008.23precondition_and_reduceIN3glm'
tasks=[('capture-pcg-input-v2',[sys.executable,str(base/'capture-pcg-input-traces-v2.py')]),
       ('three-backends-b1',[sys.executable,'-m','reconstruction.csrc.pcg_same_buffer_probe',
           '--directory',str(capture/'original/native'),'--launch',launch,'--trials','32',
           '--output',str(output/'three-backends-b1')]),
       ('atomic-certificate-b1',[sys.executable,'-m','reconstruction.csrc.pcg_grouped_atomic_certificate',
           '--capture',str(capture),'--launch',launch,'--output',str(output/'atomic-certificate-b1')]),
       ('graph60-fixed-C8',[sys.executable,'-m','reconstruction.csrc.affine_graph_cohort','--suite','driven_cloth',
           '--baseline',str(validation/'graph60-matrix16'),'--output',str(output/'graph60-fixed-C8')]),
       ('regression74-C10',[sys.executable,str(base/'run-regression.py')]),
       ('source-frontends',[sys.executable,str(base/'run-frontends.py')])]
status={'source_sha256':metadata['extension_sha256'],'complete':False,'completed':[],
        'whole_solver_complete':False,'production_changed':False,'frozen_candidates_replaced':False}
for name,command in tasks:
    assert build.read_bytes()==saved
    assert all(hashlib.sha256((root/path).read_bytes()).hexdigest()==sha for path,sha in metadata['sources'].items())
    status['running']=name;(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
    (output/(name+'.command.json')).write_text(json.dumps(command,indent=2)+'\n')
    with (output/(name+'.log')).open('w') as log:
        code=subprocess.run(command,stdout=log,stderr=subprocess.STDOUT,timeout=18000).returncode
    status['completed'].append({'name':name,'exit':code})
    (output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
    print(name,code,flush=True)
    assert code in (0,1)
    if name!='graph60-fixed-C8':assert code==0
status['complete']=True;status['running']=None
(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
