"""Verify archived mixed replay on the new active image, then capture actual penalty joint paths."""
import json
from pathlib import Path
import subprocess,sys
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
base=Path(__file__).resolve().parent
fixed=base.parent/'continuation-20261031-86916989-fixed-failures/frozen-reproduced-mixed-pair'
command=[sys.executable,'-m','reconstruction.csrc.mixed_pointwise_packet_replay',
 '--complete',str(fixed),'--frozen',str(fixed),'--trials','1',
 '--source-checkpoint','build/reconstruction-checkpoints/undriven-before-86916989',
 '--output',str(base/'historical-869-checkpoint-replay')]
(base/'historical-replay.command.json').write_text(json.dumps(command,indent=2)+'\n')
with (base/'historical-replay.log').open('w') as log:
 subprocess.run(command,env=clean_env(),stdout=log,stderr=subprocess.STDOUT,check=True,timeout=1800)
print('historical869 replay completed with active6a untouched',flush=True)
with (base/'capture-original.log').open('w') as log:
 subprocess.run([sys.executable,'-u',str(base/'capture-original.py')],env=clean_env(),stdout=log,
  stderr=subprocess.STDOUT,check=True,timeout=7200)
print('penalty original32 complete',flush=True)
