"""Read actual native Contact capacities and active counts before the first SDK step; diagnostic only."""
from pathlib import Path
import argparse,ctypes as ct,hashlib,json,sys
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc import demo_source_ab,host_api_probe
parser=argparse.ArgumentParser();parser.add_argument('--case',required=True);parser.add_argument('--output',type=Path,required=True);args=parser.parse_args()
args.output.mkdir(exist_ok=False,parents=True)
base=Path(__file__).resolve().parent
runtime=json.loads((base/'original32'/args.case/'capture.runtime.json').read_text())
factory=host_api_probe.load_reference
observed=False
cuda=ct.CDLL('libcuda.so.1');cuda.cuMemcpyDtoH_v2.argtypes=[ct.c_void_p,ct.c_uint64,ct.c_size_t]
def selected():
 core=factory();step=core.Solver.step
 def inspect(solver,*values,**keywords):
  global observed
  if not observed:
   observed=True;contact=next(value for value in values if isinstance(value,core.Contact))
   assert cuda.cuCtxSynchronize()==0
   spans={name:{'size':int(getattr(contact,name).size),'is_null':not bool(getattr(contact,name).ptr)}
          for name in dir(contact) if hasattr(getattr(contact,name),'ptr') and hasattr(getattr(contact,name),'size')}
   counts={}
   for name in ('count','soft_count'):
    span=getattr(contact,name)
    if span.ptr and span.size:
     value=ct.c_int();assert cuda.cuMemcpyDtoH_v2(ct.byref(value),span.ptr,4)==0
     counts[name]=value.value
   (args.output/'actual-contact-input.json').write_text(json.dumps({'case':args.case,'max_count':int(contact.max_count),
       'soft_max_count':int(contact.soft_max_count),'counts':counts,'spans':spans,
       'diagnostic_synchronization_added':True,'fixed_candidate_replaced':False,
       'source_fixture_sha256':runtime['example_sha256'],'image_sha256':hashlib.sha256(Path(core.__file__).read_bytes()).hexdigest()},indent=2)+'\n')
  return step(solver,*values,**keywords)
 core.Solver.step=inspect
 return core
host_api_probe.load_reference=selected
demo_source_ab.worker(argparse.Namespace(worker='original',tag='capture',example=runtime['example'],
      frames=runtime['frames'],output=str(args.output),extra=runtime['extra']))
assert observed
