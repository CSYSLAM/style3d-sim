"""Exercise unchanged real-graph example entrypoints on the source-only runner."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys
root=Path.cwd().resolve()
sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
base=Path(__file__).resolve().parent
validation=base/'validation-c189db81'
assert json.loads((validation/'regression-driver-status.json').read_text())['complete']
output=validation/'standalone-frontends'
output.mkdir(exist_ok=False)
(output/'driver.py').write_bytes(Path(__file__).read_bytes())
(output/'source_demo.py').write_bytes((root/'reconstruction/source_demo.py').read_bytes())
saved=(root/'build/reconstruction-csrc/host-particles/build.json').read_bytes()
status=[]
for name,example,frames in [('dzhanibekov-real-graph60','example_basic_dzhanibekov',60),
                            ('plastic-bag-real-graph3','example_plastic_bag',3)]:
    command=[sys.executable,'-m','reconstruction.source_demo','--report',str(output/(name+'.json')),
             'examples/'+example+'.py','--viewer','null','--num-frames',str(frames),'--test']
    (output/(name+'.command.json')).write_text(json.dumps(command,indent=2)+'\n')
    assert (root/'build/reconstruction-csrc/host-particles/build.json').read_bytes()==saved
    with (output/(name+'.log')).open('w') as log:
        code=subprocess.run(command,env=clean_env(),stdout=log,stderr=subprocess.STDOUT,timeout=1800).returncode
    record=json.loads((output/(name+'.json')).read_text())
    assert record['source_only'] and not record['reference_solver_mapped']
    assert record['source_sha256']==json.loads(saved)['extension_sha256']
    status.append({'name':name,'exit':code,'recorded_exit':record['exit']})
    (output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
    print(name,code,flush=True)
    assert code==record['exit'] and code==0
