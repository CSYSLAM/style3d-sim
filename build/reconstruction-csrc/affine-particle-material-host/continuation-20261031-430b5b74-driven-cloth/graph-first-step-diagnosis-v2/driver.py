"""Four real-graph first-step diagnostics, with unchanged full worker order and frozen C8 comparisons."""
from pathlib import Path
import json,hashlib,subprocess,sys
from contextlib import ExitStack
import numpy as np
root=Path.cwd();base=Path(__file__).resolve().parent
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes()
output=base/'graph-first-step-diagnosis-v2';output.mkdir(exist_ok=False)
(output/'build.json').write_bytes(saved);(output/'driver.py').write_bytes(Path(__file__).read_bytes())
cohort=base/'after-fixed-C8/graph60-fixed-C8'
plan=[('original','original0'),('source','source0'),('source','source1'),('source','source2')]
status={'complete':False,'planned':plan,'completed':[],'frozen_candidate_replaced':False,
        'full_worker_order_preserved':True,'whole_solver_complete':False}
for backend,tag in plan:
    assert build.read_bytes()==saved
    folder=output/tag
    command=[sys.executable,'-m','reconstruction.csrc.driven_cloth_graph_buffer_trace','--backend',backend,
             '--frames','60','--snapshot-runs','1','--output',str(folder)]
    (output/(tag+'.command.json')).write_text(json.dumps(command,indent=2)+'\n')
    status['running']=tag;(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
    with (output/(tag+'.log')).open('w') as log:
        code=subprocess.run(command,stdout=log,stderr=subprocess.STDOUT,timeout=3600).returncode
    row={'backend':backend,'tag':tag,'exit':code}
    if not code:
        row['frozen_first_steps']=[]
        for name in ('so3-w3-newton-b1','so3-w3-pd-b1','six-springs-w3-newton-b1','six-springs-w3-pd-b1'):
            path=folder/f'{backend}-{name}-1.npz'
            with np.load(path) as actual:
                for index in range(8 if backend=='original' else 3):
                    fixed=cohort/f'{backend}{index}/{backend}-{name}-1.npz'
                    with np.load(fixed) as reference:
                        checks={key:actual[key][0].tobytes()==reference[key][0].tobytes() for key in actual.files}
                    row['frozen_first_steps'].append({'case':name,'reference':f'{backend}{index}',
                         'all_first_step_fields_equal':all(checks.values()),'fields':checks,
                         'fixed_npz_sha256':hashlib.sha256(fixed.read_bytes()).hexdigest()})
        trace=json.loads((folder/'trace.json').read_text());assert len(trace['graphs'])==32
        assert trace['selected_graphs']==[10,14,26,30]
    status['completed'].append(row)
    (output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
    print(tag,code,flush=True);assert code==0
status['complete']=True;status['running']=None
(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
