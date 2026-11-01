"""Build the matching public core, exercise real entrypoints and run this exact host image's full regression."""
from pathlib import Path
import hashlib,json,subprocess,sys
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
base=Path(__file__).resolve().parent
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes();meta=json.loads(saved)
validation=base/('validation-'+meta['extension_sha256'][:8])
assert json.loads((validation/'status.json').read_text())['complete']
output=validation/'broad-validation';output.mkdir(exist_ok=False)
(output/'build.json').write_bytes(saved);(output/'driver.py').write_bytes(Path(__file__).read_bytes())
status={'source_sha256':meta['extension_sha256'],'complete':False,'completed':[],'running':None,'whole_solver_complete':False}
def run(name,arguments,allowed=(0,)):
 assert build.read_bytes()==saved
 for path,digest in meta['sources'].items():assert hashlib.sha256((root/path).read_bytes()).hexdigest()==digest
 command=[sys.executable,*arguments]
 status['running']=name;(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
 (output/(name+'.command.json')).write_text(json.dumps(command,indent=2)+'\n')
 with (output/(name+'.log')).open('w') as log:
  code=subprocess.run(command,env=clean_env(),stdout=log,stderr=subprocess.STDOUT,timeout=14400).returncode
 status['completed'].append({'name':name,'exit':code});(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
 print(name,code,flush=True);assert code in allowed,(name,code)
 return code
run('build-core',['-m','reconstruction.csrc.build_core'])
core_path=Path((output/'build-core.log').read_text().splitlines()[-1]);core_build=core_path.parent/'build.json'
core=json.loads(core_build.read_text());assert core['source_host_sha256']==meta['extension_sha256']
(output/'core-build.json').write_bytes(core_build.read_bytes())
for name,example,frames,extra in [('core-dzhanibekov60','example_basic_dzhanibekov',60,[]),
 ('core-plastic-bag3','example_plastic_bag',3,[]),('core-g1-graph60','example_robot_g1',60,['--solver','synreal','--world-count','1'])]:
 run(name,['-m','reconstruction.core_demo','--core-build',str(core_build),'--report',str(output/(name+'.json')),
           'examples/'+example+'.py','--viewer','null','--num-frames',str(frames),'--test',*extra])
 report=json.loads((output/(name+'.json')).read_text())
 assert report['exit']==0 and report['source_only'] and report['public_core_abi'] and not report['reference_solver_mapped']
 assert report['source_sha256']==core['extension_sha256']
run('regression74',['-m','reconstruction.csrc.joint_continuation_regression','--output',str(validation/'regression74')],(0,1))
reg=json.loads((validation/'regression74/status.json').read_text());assert reg['complete'] and len(reg['completed'])==74
if any(row['exit'] for row in reg['completed']):
 run('regression-fixed-C10',['-m','reconstruction.csrc.regression_fixed_spread','--validation',str(validation),
     '--output',str(validation/'regression-fixed-C10')],(0,1))
 report=json.loads((validation/'regression-fixed-C10/report.json').read_text())
 assert len(report['cases'])==sum(bool(row['exit']) for row in reg['completed'])
 run('regression-fixed-C10-cpu',['-m','reconstruction.csrc.audit_regression_fixed_spread',
     '--cohort',str(validation/'regression-fixed-C10'),'--report','report.json',
     '--output',str(validation/'regression-fixed-C10/cpu-audit.json')])
status['complete'],status['running']=True,None
(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
