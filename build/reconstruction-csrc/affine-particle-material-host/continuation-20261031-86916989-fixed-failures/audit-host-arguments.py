"""CPU-only repeat of the frozen mixed common-kernel scalar, geometry and pointer-equality audit."""
import argparse,hashlib,json,sys
from pathlib import Path
sys.path.insert(0,str(Path.cwd()))
from reconstruction.csrc.audit_cudahook import schemas
p=argparse.ArgumentParser();p.add_argument('--output',type=Path,required=True);args=p.parse_args()
assert not args.output.exists()
base=Path(__file__).resolve().parent
replay=json.loads((base/'mixed-frozen-pointwise-replay/report.json').read_text())
assert replay['all_pointwise_equal'] and len(replay['packets'])==732
root=base/'frozen-reproduced-mixed-pair';schema,_=schemas();rows=[];ids=[{},{}];files={}
for packet in replay['packets'][:366]:
 name=packet['packet'];metadata=[];arguments=[]
 for side in ('legacy','source'):
  directory=root/side/'native';path=directory/name
  files[str(path)]=hashlib.sha256(path.read_bytes()).hexdigest()
  meta=json.loads(path.read_text());metadata.append(meta)
  prefix=path.name[:-4];values=[]
  for index,kind in enumerate(schema[meta['name']]):
   path=directory/(prefix+f'before.param_{index}.bin');data=path.read_bytes()
   files[str(path)]=hashlib.sha256(data).hexdigest()
   if kind=='pointer':
    value=int.from_bytes(data,'little');mapping=ids[len(arguments)]
    value='NULL' if value==0 else mapping.setdefault(value,len(mapping))
   else:value=data.hex()
   values.append(value)
  arguments.append(values)
 rows.append({'packet':name,'metadata_equal':metadata[0]==metadata[1],
  'flat_scalar_and_pointer_equality_pattern_equal':arguments[0]==arguments[1]})
report={'rows':rows,'packets':len(rows),'all_equal':all(r['metadata_equal'] and
 r['flat_scalar_and_pointer_equality_pattern_equal'] for r in rows),'pointer_allocation_ownership_claimed':False,
 'pointer_equality_patterns_compared':True,'whole_solver_complete':False,'input_sha256':files}
args.output.write_text(json.dumps(report,indent=2)+'\n')
print('common host packets',len(rows),'all equal',report['all_equal'])
raise SystemExit(0 if report['all_equal'] else 1)
