"""Test the new source image against the unchanged eight original G1 trajectories; never resample originals."""
from pathlib import Path
from contextlib import ExitStack
import hashlib,json,subprocess,sys
import numpy as np
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.demo_ab import compare,spread_report
base=Path(__file__).resolve().parent
original=base.parent/'continuation-20261101-688f9633-driven-cloth-rigid-soft/official-g1-fixed-C8/report.json'
fixed=json.loads(original.read_text());build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes()
metadata=json.loads(saved);assert metadata['extension_sha256'].startswith('141c18f6')
output=base/'official-g1-fixed-original8-source3';output.mkdir(exist_ok=False)
(output/'driver.py').write_bytes(Path(__file__).read_bytes());(output/'build.json').write_bytes(saved)
originals={f'original{i}':Path(fixed['input_npz_paths'][f'original{i}']) for i in range(8)}
for tag,path in originals.items():assert hashlib.sha256(path.read_bytes()).hexdigest()==fixed['input_npz_sha256'][tag]
(output/'adopted-original8.json').write_text(json.dumps({'paths':{k:str(v) for k,v in originals.items()},
    'sha256':{k:fixed['input_npz_sha256'][k] for k in originals}},indent=2)+'\n')
paths=dict(originals);status={'complete':False,'completed':[],'source_sha256':metadata['extension_sha256'],
    'original_candidates_replaced':False,'originals_resampled':False,'whole_solver_complete':False}
for i in range(3):
 assert build.read_bytes()==saved
 for name,digest in metadata['sources'].items():assert hashlib.sha256((root/name).read_bytes()).hexdigest()==digest
 for name,digest in fixed['locked_sha256'].items():
  if '/.cache/newton/' in name or name.endswith('example_robot_g1.py'):
   assert hashlib.sha256(Path(name).read_bytes()).hexdigest()==digest
 folder=output/f'source{i}';folder.mkdir();paths[f'source{i}']=folder/'capture.npz'
 command=[sys.executable,'-m','reconstruction.csrc.demo_source_ab','--worker','source','--tag','capture',
  '--example','examples/example_robot_g1.py','--frames','3','--output',str(folder),
  '--','--solver','synreal','--world-count','1']
 (folder/'command.json').write_text(json.dumps(command,indent=2)+'\n')
 with (folder/'run.log').open('w') as log:
  code=subprocess.run(command,env=clean_env(),stdout=log,stderr=subprocess.STDOUT,timeout=1800).returncode
 assert code==0,(i,code)
 rt=json.loads((folder/'capture.runtime.json').read_text());assert rt['image_sha256']==metadata['extension_sha256']
 status['completed'].append(i);(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
 print('new source',i,'complete',flush=True)
with ExitStack() as stack:
 old=[stack.enter_context(np.load(originals[f'original{i}'])) for i in range(8)]
 sources=[stack.enter_context(np.load(paths[f'source{i}'])) for i in range(3)]
 assert all(set(a.files)==set(old[0].files) for a in old+sources)
 assert all(a[key].shape==old[0][key].shape and np.isfinite(a[key]).all() for a in old+sources for key in a.files)
 stats={f'source{i}':spread_report(old,[a]) for i,a in enumerate(sources)}
 checks={tag:{key:v['substeps_within_spread']==v['substeps'] for key,v in fields.items()} for tag,fields in stats.items()}
 report={'source_sha256':metadata['extension_sha256'],'source_statistics':stats,'all_steps_within':checks,
 'primary_c_passed':all(all(r.values()) for r in checks.values()),'input_npz_paths':{k:str(v) for k,v in paths.items()},
 'input_npz_sha256':{k:hashlib.sha256(v.read_bytes()).hexdigest() for k,v in paths.items()},
 'strict_sources':[compare(old[0],a) for a in sources],'original_runs':8,'source_runs':3,
 'originals_resampled':False,'whole_solver_complete':False}
 (output/'report.json').write_text(json.dumps(report,indent=2)+'\n')
status['complete']=True;(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
print('Current source fixed original8 C',report['primary_c_passed'],checks,flush=True)
raise SystemExit(int(not report['primary_c_passed']))
