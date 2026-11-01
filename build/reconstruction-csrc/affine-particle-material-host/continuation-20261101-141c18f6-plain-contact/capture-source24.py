"""Compare the new source host with all frozen original plain-contact cases, retaining every first failure."""
from pathlib import Path
import hashlib,json,subprocess,sys
from contextlib import ExitStack
import numpy as np
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.csrc.audit_cudahook import compare as compare_launches,schemas
from reconstruction.demo_ab import compare
from reconstruction.csrc.host_api_probe import REFERENCE_SHA
base=Path(__file__).resolve().parent
reference=base/'original24';prior=json.loads((reference/'report.json').read_text())
assert prior['complete'] and len(prior['cases'])==24
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes();meta=json.loads(saved)
output=base/('source24-'+meta['extension_sha256'][:8]);output.mkdir(exist_ok=False)
(output/'driver.py').write_bytes(Path(__file__).read_bytes());(output/'build.json').write_bytes(saved)
hook=root/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
rows=[];schema=schemas()[0]
for previous in prior['cases']:
 name=previous['case'];ref=reference/name;folder=output/name;folder.mkdir()
 runtime=json.loads((ref/'capture.runtime.json').read_text());assert runtime['image_sha256']==REFERENCE_SHA
 for path,digest in prior['locked_sha256'].items():assert hashlib.sha256(Path(path).read_bytes()).hexdigest()==digest
 assert build.read_bytes()==saved
 for path,digest in meta['sources'].items():assert hashlib.sha256((root/path).read_bytes()).hexdigest()==digest
 protocol=json.loads((ref/'capture-protocol.json').read_text())
 (folder/'capture-protocol.json').write_text(json.dumps(protocol,indent=2)+'\n')
 command=[sys.executable,'-m','reconstruction.csrc.demo_source_ab','--worker','source','--tag','capture',
  '--example',runtime['example'],'--frames','3','--output',str(folder),'--',*runtime['extra']]
 (folder/'command.json').write_text(json.dumps(command,indent=2)+'\n')
 with (folder/'run.log').open('w') as log:
  code=subprocess.run(command,env={**clean_env(),'LD_PRELOAD':str(hook),'CUDAHOOK_DIR':str(folder),
   'CUDAHOOK_DUMP':protocol['dump'],'CUDAHOOK_DUMP_LIMIT':str(protocol['limit'])},
   stdout=log,stderr=subprocess.STDOUT,timeout=1800).returncode
 row={'case':name,'exit':code,'passed':False}
 if code==0:
  actual=json.loads((folder/'capture.runtime.json').read_text())
  assert actual['image_sha256']==meta['extension_sha256']
  assert all(actual[key]==runtime[key] for key in ['example_sha256','extra','frames','launch_hook_sha256'])
  metadata=compare_launches(ref/'launches.txt',folder/'launches.txt',schema)
  coverage=sum(json.loads((folder/'capture.launches.json').read_text()).values())==metadata['right_launches']
  with np.load(ref/'capture.npz') as old,np.load(folder/'capture.npz') as source:
   assert set(old.files)==set(source.files)
   finite=all(np.isfinite(source[key]).all() for key in source.files)
   state=compare(old,source)
  buffers={f.name:f.read_bytes()==(folder/f.name).read_bytes() for f in ref.glob('dump_*.bin')}
  row.update(metadata=metadata,source_coverage_equal=coverage,finite=finite,state=state,
             nine_force_buffers_equal=all(buffers.values()),different_force_buffers=[k for k,v in buffers.items() if not v],
             passed=metadata['equal'] and coverage and finite and state['bitwise'] and all(buffers.values()))
 rows.append(row)
 (output/'report.json').write_text(json.dumps({'source_sha256':meta['extension_sha256'],'cases':rows,
    'complete':len(rows)==24,'whole_solver_complete':False},indent=2)+'\n')
 print(name,code,'passed',row['passed'],'metadata',row.get('metadata',{}).get('equal'),flush=True)
 assert code==0,(name,code)
