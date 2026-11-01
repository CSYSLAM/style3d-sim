"""Execute all same-input rolling replays once and retain exact commands, logs and terminal status."""
import json
from pathlib import Path
import subprocess
import sys

root=Path.cwd()
sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

base=Path(__file__).resolve().parent
assert not (base/'replay.command.json').exists()
command=[sys.executable,'-m','reconstruction.csrc.g1_drive_state_replay',
         '--capture',str(base),'--output',str(base/'replay')]
(base/'replay.command.json').write_text(json.dumps(command,indent=2)+'\n')
with (base/'replay.log').open('w') as log:
    code=subprocess.run(command,cwd=root,env=clean_env(),stdout=log,stderr=subprocess.STDOUT,
                        timeout=1800).returncode
(base/'replay.status.json').write_text(json.dumps(
    {'exit':code,'complete':code==0,'whole_solver_complete':False},indent=2)+'\n')
assert code==0,code
print('Rolling replay finished0',flush=True)
