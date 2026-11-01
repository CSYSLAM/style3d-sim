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
report=read(base/'sdk-heldout3/report.json')
fixed=read(base/'graph60-fixed-original-C8/report.json')
originals=[Path(fixed['input_npz_paths'][f'original{i}']) for i in range(8)]
controls=[base/f'sdk-heldout3/SDK-control{i}/states.npz' for i in range(3)]
assert all(hashlib.sha256(p.read_bytes()).hexdigest()==report['control_npz_sha256'][str(p)] for p in controls)
statistics={f'source{i}':report['statistics'][f'SDK-control{i}'] for i in range(3)}
audit('SDK-heldout3',originals,controls,statistics)
assert checks[0]['primary_c_passed']==report['all_SDK_controls_pass_fixed_rule']
output=base/'sdk-heldout3/cpu-audit.json'
assert not output.exists()
output.write_text(json.dumps({'all_statistics_reproduced':True,'checks':checks,'input_sha256':paths,
 'fixed_source_C8_report_unchanged':hashlib.sha256((base/'graph60-fixed-original-C8/report.json').read_bytes()).hexdigest()==report['fixed_source_C8_report_sha256'],
 'new_controls_added_to_baseline':False,'source_C8_failure_reclassified':False,'GPU_used':False,
 'whole_solver_complete':False,'runner_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()},indent=2)+'\n')
print('Independent SDK-heldout CPU statistics identical; all controls pass:',checks[0]['primary_c_passed'])
