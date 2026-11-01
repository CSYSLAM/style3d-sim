"""Attribute constructor allocations and payloads to real flat owned uses; no size-based identities."""
import hashlib,json
from collections import Counter,defaultdict
from pathlib import Path
import sys
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.audit_cudahook import schemas
from reconstruction.csrc.memory_pointer_audit import capture
base=Path(__file__).resolve().parent
schema,_=schemas()
results={}
for kind in ('spring','point-line','distance'):
 folder=base/'constructor-before-5bd9722e'/kind
 report={};flat=[];payloads=[]
 for side in ('original','source'):
  directory=folder/(kind+'-newton-w3-full-memory')/side
  owned=capture(directory,schema);roles=defaultdict(set)
  for row in owned:
   for index,scope,*address in row['pointers']:
    if scope=='owned':roles[address[0]].add((row['name'].split('kernel')[-1].split('E')[0],index,address[1]))
  allocations=[]
  for line in (directory/'memory.jsonl').read_text().splitlines():
   row=json.loads(line)
   if row.get('api') in ('cudaMalloc','cuMemAlloc_v2'):
    identity=len(allocations)
    allocations.append({'id':identity,'bytes':row['bytes'],'uses':sorted(roles[identity])})
  flat.append(allocations)
  directory=folder/(kind+'-newton-w3-payload')/side
  uses=defaultdict(set)
  for line in (directory/'launches.txt').read_text().splitlines():
   head,symbol=line.split(' symbol:');name=symbol.split()[0];values=head.split()[5:]
   for i,(value,typ) in enumerate(zip(values,schema[name])):
    if typ=='pointer':uses[int(value[2:],16)].add((head.split()[1],i))
  uploads=[]
  for line in (directory/'memory.jsonl').read_text().splitlines():
   row=json.loads(line)
   if 'file' not in row:continue
   p=directory/row['file'];data=p.read_bytes()
   uploads.append({'file':str(p),'bytes':len(data),'sha256':hashlib.sha256(data).hexdigest(),
                   'uses':sorted(uses[int(row['dst'],16)])})
  payloads.append(uploads)
 report['allocations']=dict(zip(('original','source'),flat))
 report['uploads']=dict(zip(('original','source'),payloads))
 old,new=[Counter((v['bytes'],v['sha256']) for v in rows) for rows in payloads]
 report['upload_multiset_equal']=old==new
 report['original_payloads_without_source_bytes']=[v for v in payloads[0] if (v['bytes'],v['sha256']) not in new]
 report['source_payloads_without_original_bytes']=[v for v in payloads[1] if (v['bytes'],v['sha256']) not in old]
 output=folder/'role-and-upload-diagnostic.json';assert not output.exists()
 output.write_text(json.dumps(report,indent=2)+'\n')
 results[kind]={'upload_multiset_equal':old==new,'old_unmatched':[v['file'] for v in report['original_payloads_without_source_bytes']],
  'new_unmatched':[v['file'] for v in report['source_payloads_without_original_bytes']]}
 print(kind,results[kind],flush=True)
(base/'constructor-role-summary.json').write_text(json.dumps(results,indent=2)+'\n')
