"""Capture the fixed two rolling branches once per backend, preserving the original C8 cohort."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys

root=Path.cwd()
sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

base=Path(__file__).resolve().parent
plan=json.loads((base/'plan.json').read_text())
abi=base.parent/'continuation-20261101-38b70dcd-g1-graph-definition/abi.json'
fixed=base.parent/'continuation-20261101-38b70dcd-g1-public-core/graph60-fixed-original-C8/report.json'
fixed_bytes=fixed.read_bytes()
assert not (base/'status.json').exists()
status={'complete':False,'running':None,'completed':[],
        'fixed_C8_report_sha256':hashlib.sha256(fixed_bytes).hexdigest(),'whole_solver_complete':False}
for side in ('original','source'):
    for name,sha in plan['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest()==sha,name
    assert fixed.read_bytes()==fixed_bytes
    command=[sys.executable,'-m','reconstruction.csrc.g1_drive_state_capture','--backend',side,
             '--abi',str(abi),'--frames','60','--output',str(base/side)]
    (base/(side+'.command.json')).write_text(json.dumps(command,indent=2)+'\n')
    status['running']=side
    (base/'status.json').write_text(json.dumps(status,indent=2)+'\n')
    with (base/(side+'.log')).open('w') as log:
        code=subprocess.run(command,cwd=root,env=clean_env(),stdout=log,stderr=subprocess.STDOUT,
                            timeout=1800).returncode
    status['completed'].append({'backend':side,'exit':code})
    status['running']=None
    (base/'status.json').write_text(json.dumps(status,indent=2)+'\n')
    assert code==0,(side,code)
    assert fixed.read_bytes()==fixed_bytes
    assert json.loads((base/side/'provenance.json').read_text())['frames_read']==60
    print(side,'60 packets for each drive/soft/AL state stage captured',flush=True)
status['complete']=True
(base/'status.json').write_text(json.dumps(status,indent=2)+'\n')
