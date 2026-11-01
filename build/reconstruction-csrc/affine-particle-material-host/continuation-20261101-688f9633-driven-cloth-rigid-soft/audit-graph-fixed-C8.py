"""CPU-only independent recomputation of fixed driven-cloth C, preserving every trajectory."""
from pathlib import Path
from contextlib import ExitStack
import argparse,hashlib,json
import numpy as np
base=Path(__file__).resolve().parent

paths={};checks=[]
def read(path):
    paths[str(path)]=hashlib.sha256(path.read_bytes()).hexdigest()
    return json.loads(path.read_text())
def audit(name,originals,sources,statistics):
    with ExitStack() as stack:
        arrays=[]
        for path in originals+sources:
            paths[str(path)]=hashlib.sha256(path.read_bytes()).hexdigest()
            arrays.append(stack.enter_context(np.load(path)))
        assert len(originals)==8 and len(sources)==3
        assert all(set(run.files)==set(arrays[0].files) for run in arrays)
        actual={}
        for key in arrays[0].files:
            original=np.asarray([run[key] for run in arrays[:8]],dtype='f8')
            assert np.isfinite(original).all()
            shape=original.shape
            per_step=original.reshape(8,shape[1],-1)
            total=per_step.sum(axis=0)
            envelope=np.max(np.asarray([np.max(np.abs(per_step[i]-(total-per_step[i])/7),axis=1)
                                       for i in range(8)]),axis=0)
            for index,run in enumerate(arrays[8:]):
                source=run[key].astype('f8').reshape(shape[1],-1)
                assert np.isfinite(source).all() and source.shape==per_step[0].shape
                errors=np.max(np.abs(source-total/8),axis=1)
                with np.errstate(divide='ignore',invalid='ignore'):
                    ratios=np.where(envelope>0,errors/envelope,np.where(errors>0,np.inf,0.))
                recomputed={'substeps_within_spread':int(np.count_nonzero(errors<=envelope)),
                            'legacy_spread_max':float(envelope.max()),'reconstruction_error_max':float(errors.max()),
                            'ratio_median':float(np.median(ratios)),'ratio_max':float(ratios.max())}
                previous=statistics[f'source{index}'][key]
                assert all(previous[field]==value for field,value in recomputed.items()),(name,key,index,recomputed,previous)
                actual[f'source{index}/{key}']=bool(np.all(errors<=envelope))
        checks.append({'case':name,'all_statistics_reproduced':True,'primary_c_passed':all(actual.values()),
                       'all_steps_within':actual})
for group in ('soft','rigid-soft'):
    cohort=base/'after-regression-23012dc5'/(group+'-graph60-fixed-C8')
    report=read(cohort/'report.json')
    for case,row in report['cases'].items():
        originals=[cohort/f'original{i}/original-{case}.npz' for i in range(8)]
        sources=[cohort/f'source{i}/source-{case}.npz' for i in range(3)]
        audit(group+'/'+case,originals,sources,{tag:value['statistics'] for tag,value in row['sources'].items()})
        assert checks[-1]['primary_c_passed']==row['primary_c_passed']
    assert all(r['primary_c_passed'] for r in checks if r['case'].startswith(group+'/'))==report['primary_c_passed']
output=base/'graph-fixed-C8-23012dc5-cpu-audit.json'
assert not output.exists()
output.write_text(json.dumps({'all_statistics_reproduced':True,'checks':checks,'input_sha256':paths,
     'harness_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),'gpu_runs':0,
     'production_changed':False,'frozen_candidate_replaced':False,'whole_solver_complete':False},indent=2)+'\n')
print('CPU graph statistics identical',len(checks),'cases; primary C',sum(row['primary_c_passed'] for row in checks))
