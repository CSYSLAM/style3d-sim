"""Replay all nine actual force packets from both backends without changing frozen acceptance data."""
from pathlib import Path
import hashlib,json,subprocess,sys
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
base=Path(__file__).resolve().parent
capture=base/'all-surface-calls-23012dc5'
output=base/'all-surface-replay-23012dc5';output.mkdir(exist_ok=False)
(output/'driver.py').write_bytes(Path(__file__).read_bytes())
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes()
(output/'build.json').write_bytes(saved)
status={'complete':False,'completed':[],'running':None,'production_changed':False,'whole_solver_complete':False}
for side in ('original','source'):
 for index in range(9):
  assert build.read_bytes()==saved
  for path,sha in json.loads(saved)['sources'].items():assert hashlib.sha256((root/path).read_bytes()).hexdigest()==sha
  name=f'{side}-{index:03d}'
  command=[sys.executable,'-m','reconstruction.csrc.surface_common_input_replay',
           '--capture',str(capture/side/f'packet{index:03d}'),'--output',str(output/name)]
  status['running']=name;(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
  (output/(name+'.command.json')).write_text(json.dumps(command,indent=2)+'\n')
  with (output/(name+'.log')).open('w') as log:
   code=subprocess.run(command,env=clean_env(),stdout=log,stderr=subprocess.STDOUT,timeout=900).returncode
  assert code==0,(name,code)
  report=json.loads((output/name/'report.json').read_text())
  assert report['all_isolated_contact_outputs_equal'] and report['all_per_contact_atomic_operand_sequences_identical']
  status['completed'].append({'name':name,'exit':code,'contacts':report['contacts'],
             'isolated_all_equal':report['all_isolated_contact_outputs_equal'],
             'real_atomic_operands_equal':report['all_per_contact_atomic_operand_sequences_identical'],
             'aggregate_matches_captured':report['aggregate_matches_captured']})
  print(name,'contact outputs and actual atomic operands same',flush=True)
status['complete'],status['running']=True,None
(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
