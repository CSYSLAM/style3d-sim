"""Record current source refusal against four valid frozen SDK contact scenes."""
from pathlib import Path
import json,subprocess,sys,hashlib
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
base=Path(__file__).resolve().parent
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes()
image=json.loads(saved)['extension_sha256'];assert image.startswith('688f9633')
proof=json.loads((base/'original32/report.json').read_text());assert proof['complete'] and len(proof['cases'])==32
output=base/'baseline4-688f9633';output.mkdir(exist_ok=False)
(output/'build.json').write_bytes(saved);(output/'driver.py').write_bytes(Path(__file__).read_bytes())
hook=root/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so';rows=[]
for kind in ('surface','legacy'):
 for rigidity in ('so3','six-springs'):
    case=f'{kind}-{rigidity}-w1-newton-b0';reference=base/'original32'/case
    runtime=json.loads((reference/'capture.runtime.json').read_text())
    protocol=json.loads((reference/'capture-protocol.json').read_text())
    folder=output/case;folder.mkdir()
    command=[sys.executable,'-m','reconstruction.csrc.demo_source_ab','--worker','source','--tag','capture',
         '--example',runtime['example'],'--frames',str(runtime['frames']),'--output',str(folder),'--',*runtime['extra']]
    assert build.read_bytes()==saved
    (folder/'command.json').write_text(json.dumps(command,indent=2)+'\n')
    with (folder/'run.log').open('w') as log:
        code=subprocess.run(command,env={**clean_env(),'LD_PRELOAD':str(hook),'CUDAHOOK_DIR':str(folder),
            'CUDAHOOK_DUMP':protocol['dump'],'CUDAHOOK_DUMP_LIMIT':str(protocol['limit'])},
            stdout=log,stderr=subprocess.STDOUT,timeout=1800).returncode
    row={'case':case,'exit':code,'numerical_comparison_performed':False,
         'log_tail':(folder/'run.log').read_text().splitlines()[-8:]}
    rows.append(row);(output/'report.json').write_text(json.dumps({'source_sha256':image,'cases':rows,
          'whole_solver_complete':False},indent=2)+'\n')
    print(case,code,row['log_tail'][-1],flush=True)
    assert code==1
