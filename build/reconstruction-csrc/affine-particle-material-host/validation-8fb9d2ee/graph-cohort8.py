import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import numpy as np
from reconstruction.demo_ab import spread_report,compare
from reconstruction.csrc.host_api_probe import REFERENCE_SHA
from reconstruction.csrc.affine_cloth_ab import cases
root=Path(__file__).resolve().parent;repo=root.parents[3]
baseline=root/'body-cloth-graph60';out=root/'body-cloth-graph-cohort8';out.mkdir()
manifest=repo/'build/reconstruction-csrc/host-particles/build.json';saved=manifest.read_bytes();(out/'build.json').write_bytes(saved)
old=json.loads((baseline/'original.runtime.json').read_text());new=json.loads((baseline/'source.runtime.json').read_text())
assert old['image_sha256']==REFERENCE_SHA and new['image_sha256']==json.loads(saved)['extension_sha256']
assert old['frames']==new['frames']==60 and old['sha256']==new['sha256']
assert all(hashlib.sha256(Path(p).read_bytes()).hexdigest()==h for p,h in old['sha256'].items())
expected={f'{case}-{mode}' for case,_,_,_ in cases() for mode in (0,1)}
adopted=[]
for backend,tag in [('original','original0'),('source','source0')]:
 directory=out/tag;directory.mkdir()
 files=list(baseline.glob(backend+'-*.npz'));assert {p.stem[len(backend)+1:] for p in files}==expected
 files+=[baseline/(backend+'.runtime.json'),baseline/(backend+'.log')]
 for p in files:
  shutil.copy2(p,directory/p.name);adopted.append({'path':str(p),'target':str(directory/p.name),'sha256':hashlib.sha256(p.read_bytes()).hexdigest()})
(out/'adopted-first-workers.json').write_text(json.dumps(adopted,indent=2)+'\n')
env={k:v for k,v in os.environ.items() if k not in ('STYLE3D_SIM_ACCOUNT','STYLE3D_SIM_PASSWORD','LD_PRELOAD',
 'CUDAHOOK_DIR','CUDAHOOK_DUMP','CUDAHOOK_DUMP_LIMIT','DEMO_MEMORY_TRACE_DIR','DEMO_NATIVE_TRACE_DIR','DEMO_NATIVE_TRACE_SUBSTEPS')}
status=[]
for backend,tag in [('source','source1'),('source','source2'),*[('original',f'original{i}') for i in range(1,8)]]:
 assert manifest.read_bytes()==saved
 assert all(hashlib.sha256(Path(p).read_bytes()).hexdigest()==h for p,h in old['sha256'].items())
 directory=out/tag;directory.mkdir()
 command=[sys.executable,'-m','reconstruction.csrc.affine_cloth_graph_ab','--worker',backend,'--frames','60','--output',str(directory)]
 (directory/'command.json').write_text(json.dumps(command,indent=2)+'\n')
 with (directory/'run.log').open('w') as log:
  code=subprocess.run(command,cwd=repo,env=env,stdout=log,stderr=subprocess.STDOUT,timeout=7200).returncode
 assert code==0,(tag,code)
 runtime=json.loads((directory/(backend+'.runtime.json')).read_text())
 assert runtime['image_sha256']==(old if backend=='original' else new)['image_sha256']
 assert runtime['sha256']==old['sha256'] and runtime['frames']==60
 assert {p.stem[len(backend)+1:] for p in directory.glob(backend+'-*.npz')}==expected
 status.append({'tag':tag,'exit':code});(out/'status.json').write_text(json.dumps(status,indent=2)+'\n')
 print(tag,code,flush=True)
report={}
for key in sorted(expected):
 with np.load(out/'original0'/('original-'+key+'.npz')) as a:
  originals=[]
  for i in range(8):
   with np.load(out/f'original{i}'/('original-'+key+'.npz')) as d:
    assert set(d.files)==set(a.files);assert all(np.isfinite(d[k]).all() for k in d.files)
    originals.append({k:d[k].copy() for k in d.files})
 # spread_report expects the NPZ .files protocol, so keep actual files open for this bounded comparison.
 original_files=[np.load(out/f'original{i}'/('original-'+key+'.npz')) for i in range(8)]
 sources=[]
 try:
  rows={}
  for i in range(3):
   with np.load(out/f'source{i}'/('source-'+key+'.npz')) as source:
    assert set(source.files)==set(original_files[0].files) and all(np.isfinite(source[k]).all() for k in source.files)
    stats=spread_report(original_files,[source],checkpoints=60)
    strict_matches=[j for j,original in enumerate(original_files) if compare(original,source)['bitwise']]
   rows[f'source{i}']={'statistics':stats,'all_steps_within':{k:v['substeps_within_spread']==v['substeps'] for k,v in stats.items()},
                      'exact_actual_original_trajectory_matches':strict_matches}
  report[key]={'sources':rows,'primary_c_passed':all(all(v['all_steps_within'].values()) for v in rows.values())}
 finally:
  for f in original_files:f.close()
passed=all(v['primary_c_passed'] for v in report.values())
(out/'report.json').write_text(json.dumps({'source_sha256':json.loads(saved)['extension_sha256'],'cases':report,
 'primary_c_passed':passed,'source0_replaced':False,'full_worker_context_preserved':True,'full_solver_complete':False},indent=2)+'\n')
print('all sixteen trajectories primary C',passed,flush=True)
raise SystemExit(int(not passed))
