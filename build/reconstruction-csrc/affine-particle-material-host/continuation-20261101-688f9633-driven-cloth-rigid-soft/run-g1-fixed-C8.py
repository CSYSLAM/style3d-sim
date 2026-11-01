"""Fixed G1 original8/source3 cohort, adopting the initial three-frame candidates without rerunning them."""
from pathlib import Path
from contextlib import ExitStack
import hashlib,json,subprocess,sys
import numpy as np
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.demo_ab import spread_report,compare
base=Path(__file__).resolve().parent
first=base/'official-g1-first3'
output=base/'official-g1-fixed-C8';output.mkdir(exist_ok=False)
(output/'driver.py').write_bytes(Path(__file__).read_bytes())
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes();meta=json.loads(saved)
(output/'build.json').write_bytes(saved)
paths={'original0':first/'original0.npz','source0':first/'source.npz'}
runtimes={side:json.loads((first/(name+'.runtime.json')).read_text())
          for side,name in [('original','original0'),('source','source')]}
locked={str(path):hashlib.sha256(path.read_bytes()).hexdigest() for path in paths.values()}
for name in ['demo_source_ab.py','host_particles_ab.py','host_bodies_ab.py','host_api_probe.py']:
 path=root/'reconstruction/csrc'/name;locked[str(path)]=hashlib.sha256(path.read_bytes()).hexdigest()
example=root/'examples/example_robot_g1.py';locked[str(example)]=runtimes['original']['example_sha256']
assets=json.loads((base/'official-g1-asset-manifest.json').read_text())
for name,row in assets['files'].items():locked[str(Path(assets['cache_root'])/name)]=row['sha256']
status={'complete':False,'completed':[],'running':None,'source_sha256':meta['extension_sha256'],
        'first_candidates_replaced':False,'cohorts_resampled':False,'whole_solver_complete':False}
(output/'adopted-first-candidates.json').write_text(json.dumps({'paths':{k:str(v) for k,v in paths.items()},
                'sha256':{k:locked[str(v)] for k,v in paths.items()}},indent=2)+'\n')
for side,index in [('original',i) for i in range(1,8)]+[('source',i) for i in (1,2)]:
 assert build.read_bytes()==saved
 for path,digest in locked.items():assert hashlib.sha256(Path(path).read_bytes()).hexdigest()==digest,path
 for path,digest in meta['sources'].items():assert hashlib.sha256((root/path).read_bytes()).hexdigest()==digest,path
 name=f'{side}{index}';folder=output/name;folder.mkdir();paths[name]=folder/'capture.npz'
 command=[sys.executable,'-m','reconstruction.csrc.demo_source_ab','--worker',side,'--tag','capture',
          '--example','examples/example_robot_g1.py','--frames','3','--output',str(folder),
          '--','--solver','synreal','--world-count','1']
 status['running']=name;(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
 (folder/'command.json').write_text(json.dumps(command,indent=2)+'\n')
 with (folder/'run.log').open('w') as log:
  code=subprocess.run(command,env=clean_env(),stdout=log,stderr=subprocess.STDOUT,timeout=1800).returncode
 assert code==0,(name,code)
 runtime=json.loads((folder/'capture.runtime.json').read_text())
 assert runtime==runtimes[side],(name,runtime,runtimes[side])
 status['completed'].append({'name':name,'exit':code});print(name,'completed',flush=True)
with ExitStack() as stack:
 originals=[stack.enter_context(np.load(paths[f'original{i}'])) for i in range(8)]
 sources=[stack.enter_context(np.load(paths[f'source{i}'])) for i in range(3)]
 assert all(set(run.files)==set(originals[0].files) for run in originals+sources)
 assert all(run[key].shape==originals[0][key].shape and np.isfinite(run[key]).all()
            for run in originals+sources for key in run.files)
 stats={f'source{i}':spread_report(originals,[source]) for i,source in enumerate(sources)}
 within={tag:{key:row['substeps_within_spread']==row['substeps'] for key,row in fields.items()}
         for tag,fields in stats.items()}
 report={'source_sha256':meta['extension_sha256'],'source_statistics':stats,'all_steps_within':within,
         'primary_c_passed':all(all(r.values()) for r in within.values()),
         'original_self_strict':[compare(originals[0],run) for run in originals[1:]],
         'strict_sources':[compare(originals[0],run) for run in sources],
         'input_npz_paths':{k:str(v) for k,v in paths.items()},
         'input_npz_sha256':{k:hashlib.sha256(v.read_bytes()).hexdigest() for k,v in paths.items()},
         'locked_sha256':locked,'first_candidates_replaced':False,'cohorts_resampled':False,
         'original_runs':8,'source_runs':3,'whole_solver_complete':False}
 (output/'report.json').write_text(json.dumps(report,indent=2)+'\n')
status['complete'],status['running']=True,None
(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
print('G1 fixed C8',report['primary_c_passed'],within,flush=True)
raise SystemExit(int(not report['primary_c_passed']))
