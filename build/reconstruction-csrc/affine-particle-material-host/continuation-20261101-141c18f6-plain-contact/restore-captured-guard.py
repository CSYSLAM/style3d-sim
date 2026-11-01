"""Preserve the current host and frozen SDK24 before admitting the captured single-constraint contact scope."""
from pathlib import Path
import hashlib,json,subprocess,sys
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
base=Path(__file__).resolve().parent;reference=base/'original24'
report=json.loads((reference/'report.json').read_text());assert report['complete'] and len(report['cases'])==24
assert all(row['finite'] and row['all_forces_effective'] for row in report['cases'])
output=base/'source141-guard-baseline';assert output.is_dir()
first=output/'spring-w1-newton-b0'
assert 'not been captured' in (first/'run.log').read_text()
# Adopt the existing refused baseline; do not execute it again after correcting the message grammar check.
for name in ['distance-w3-pd-b1']:
 folder=output/name;folder.mkdir(exist_ok=False);rt=json.loads((reference/name/'capture.runtime.json').read_text())
 command=[sys.executable,'-m','reconstruction.csrc.demo_source_ab','--worker','source','--tag','capture',
  '--example',rt['example'],'--frames','3','--output',str(folder),'--',*rt['extra']]
 (folder/'command.json').write_text(json.dumps(command,indent=2)+'\n')
 with (folder/'run.log').open('w') as log:
  code=subprocess.run(command,env=clean_env(),stdout=log,stderr=subprocess.STDOUT).returncode
 assert code!=0 and 'not been captured' in (folder/'run.log').read_text(),(name,code)
 print(name,'old source refused',flush=True)
meta_path=root/'build/reconstruction-csrc/host-particles/build.json';meta=json.loads(meta_path.read_text())
assert meta['extension_sha256'].startswith('141c18f6')
checkpoint=root/'build/reconstruction-checkpoints/plain-contact-before-141c18f6';checkpoint.mkdir(exist_ok=False)
files=[*meta['sources'],str(meta_path.relative_to(root)),
       'build/reconstruction-csrc/host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so']
records=[]
for name in files:
 src=root/name;data=src.read_bytes();sha=hashlib.sha256(data).hexdigest()
 if name in meta['sources']:assert sha==meta['sources'][name]
 target=checkpoint/'preserved-files'/name;target.parent.mkdir(parents=True,exist_ok=True);target.write_bytes(data)
 records.append({'path':name,'sha256':sha,'bytes':len(data)})
refs={str(p.relative_to(root)):hashlib.sha256(p.read_bytes()).hexdigest() for p in reference.rglob('*') if p.is_file()}
(checkpoint/'checkpoint.json').write_text(json.dumps({'source_sha256':meta['extension_sha256'],'preserved_files':records,
 'fixed_original24_sha256':refs,'note':'Narrow captured SO3 single-plain-constraint penalty rigid/rolling contact guards.',
 'whole_solver_complete':False},indent=2)+'\n')
preview=base/'source-guard-preview.cpp';source=root/'reconstruction/csrc/native/source_solver.cpp'
source.write_bytes(preview.read_bytes());print('Preserved',len(records),'source/build files;',len(refs),'reference SHA',flush=True)
with (base/'compile.log').open('w') as log:
 subprocess.run(meta['build_command'],stdout=log,stderr=subprocess.STDOUT,check=True)
meta['sources'][str(source.relative_to(root))]=hashlib.sha256(source.read_bytes()).hexdigest()
meta['extension_sha256']=hashlib.sha256((meta_path.parent/'_source_solver.cpython-312-x86_64-linux-gnu.so').read_bytes()).hexdigest()
for name,sha in meta['sources'].items():assert hashlib.sha256((root/name).read_bytes()).hexdigest()==sha
meta_path.write_text(json.dumps(meta,indent=2)+'\n');(base/'build-after-guard.json').write_bytes(meta_path.read_bytes())
print('Current host',meta['extension_sha256'],flush=True)
