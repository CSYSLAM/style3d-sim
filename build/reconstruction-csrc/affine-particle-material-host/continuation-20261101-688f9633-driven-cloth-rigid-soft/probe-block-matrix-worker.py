"""Actual SDK native-API probe of the independent sparse block-matrix selection flag."""
from pathlib import Path
import argparse,hashlib,json,sys
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc import demo_source_ab,host_api_probe
parser=argparse.ArgumentParser();parser.add_argument('--case',required=True);parser.add_argument('--kind',choices=('surface','legacy'),required=True)
parser.add_argument('--rigidity',choices=('so3','six-springs'),required=True)
parser.add_argument('--channels',choices=('both','soft','rigid','none'),required=True)
parser.add_argument('--alpha',type=float,default=100.);parser.add_argument('--diagonal',action='store_true');parser.add_argument('--output',type=Path,required=True)
args=parser.parse_args();args.output.mkdir(exist_ok=False,parents=True)
base=Path(__file__).resolve().parent
reference=base.parent/'continuation-20261101-688f9633-driven-cloth-contact/original32'/f'{args.kind}-{args.rigidity}-w1-pd-b0'
runtime=json.loads((reference/'capture.runtime.json').read_text());factory=host_api_probe.load_reference
observations=[]
def selected():
 core=factory();step=core.Solver.step
 def inspect(solver,*values,**keywords):
  contact=next(value for value in values if isinstance(value,core.Contact))
  solver.config.constraint_alpha=args.alpha
  solver.config.enable_collision_hessian_non_diagonal=not args.diagonal
  before={'max_count':int(contact.max_count),'soft_max_count':int(contact.soft_max_count)}
  if args.channels not in ('both','rigid'):
   contact.max_count=0
   for name in dir(contact):
    value=getattr(contact,name)
    if not name.startswith('soft_') and hasattr(value,'ptr') and hasattr(value,'size'):setattr(contact,name,type(value)())
  if args.channels not in ('both','soft'):
   contact.soft_max_count=0
   for name in dir(contact):
    value=getattr(contact,name)
    if name.startswith('soft_') and hasattr(value,'ptr') and hasattr(value,'size'):setattr(contact,name,type(value)())
  observations.append({'before':before,'max_count':int(contact.max_count),'soft_max_count':int(contact.soft_max_count),
   'config_nonlinear_solver':str(solver.config.nonlinear_solver),'config_rigidity':str(solver.config.affine_body_rigidity_model),
   'constraint_alpha':float(solver.config.constraint_alpha),'collision_hessian':bool(solver.config.enable_collision_hessian_non_diagonal)})
  (args.output/'actual-inputs.json').write_text(json.dumps({'case':args.case,'observations':observations,
    'native_channels_explicitly_changed_for_probe':True,'production_changed':False,'acceptance_candidate_replaced':False,
    'fixture_sha256':runtime['example_sha256']},indent=2)+'\n')
  return step(solver,*values,**keywords)
 core.Solver.step=inspect
 return core
host_api_probe.load_reference=selected
demo_source_ab.worker(argparse.Namespace(worker='original',tag='capture',example=runtime['example'],frames=3,
    output=str(args.output),extra=runtime['extra']))
assert len(observations)==3
