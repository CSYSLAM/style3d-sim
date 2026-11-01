"""Offline investigation of historical constructor copy/fill traces; never count them as current-image tests."""
from pathlib import Path
import hashlib,json,sys
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.device_memory_sequence_audit import capture
from reconstruction.csrc.audit_cudahook import schemas
base=Path(__file__).resolve().parent
output=base/'historical-copy-clear-audits';output.mkdir(exist_ok=False)
(output/'driver.py').write_bytes(Path(__file__).read_bytes())
phases=['continuation-20261031-430b5b74-driven-cloth',
        'continuation-20261101-688f9633-driven-cloth-rigid-soft',
        'continuation-20261031-5bd9722e-plain-constraints']
folders=[]
for phase in phases:
 for folder in sorted((base.parent/phase).glob('**/*full-memory')):
  if 'constructor-before-5bd9722e' in str(folder) or 'official-g1-constructor3' in str(folder):continue
  if all((folder/side/'capture.runtime.json').exists() for side in ['original','source']):folders.append(folder)
assert len(folders)==26,len(folders)
schema=schemas()[0];summaries=[]
for index,folder in enumerate(folders):
 results=[capture(folder/side,schema) for side in ['original','source']]
 runtimes=[json.loads((folder/side/'capture.runtime.json').read_text()) for side in ['original','source']]
 assert runtimes[0]['extra']==runtimes[1]['extra'] and runtimes[0]['frames']==runtimes[1]['frames']
 left,right=[r['operations'] for r in results]
 differences=[{'operation':i,'original':a,'source':b} for i,(a,b) in enumerate(zip(left,right)) if a!=b]
 paths=[folder/side/name for side in ['original','source'] for name in ['capture.runtime.json','memory.jsonl','launches.txt','capture.pointers.json']]
 report={'capture':str(folder),'source_sha256':runtimes[1]['image_sha256'],
    'current_image_test':False,'reference_sha256':runtimes[0]['image_sha256'],
    'operation_counts_equal':len(left)==len(right),'all_captured_sequences_equal':left==right,
    'counts':[r['counts'] for r in results],'differences':differences,
    'unresolved_targets':[r['unresolved_targets'] for r in results],
    'input_sha256':{str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in paths},
    'all_copy_clear_semantics_proven':False,'whole_solver_complete':False}
 (output/f'{index:02d}.json').write_text(json.dumps(report,indent=2)+'\n')
 summaries.append({k:report[k] for k in ['capture','source_sha256','current_image_test','counts','all_captured_sequences_equal']})
 summaries[-1]['different_operations']=len(differences)
 print(index,folder.name,'differences',len(differences),flush=True)
(output/'report.json').write_text(json.dumps({'cases':summaries,'GPU_used':False,'current_image_test':False,
 'whole_solver_complete':False},indent=2)+'\n')
