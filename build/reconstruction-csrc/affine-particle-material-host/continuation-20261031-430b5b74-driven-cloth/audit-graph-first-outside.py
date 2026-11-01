"""Locate the exact first outside-C components without extending any fixed graph cohort."""
from pathlib import Path
import json,hashlib
from contextlib import ExitStack
import numpy as np
base=Path(__file__).resolve().parent
cohort=base/'after-fixed-C8/graph60-fixed-C8'
report=json.loads((cohort/'report.json').read_text());rows=[];inputs={}
for case,result in report['cases'].items():
    if result['primary_c_passed']:continue
    with ExitStack() as stack:
        arrays={}
        for backend,count in (('original',8),('source',3)):
            for index in range(count):
                path=cohort/f'{backend}{index}/{backend}-{case}.npz'
                inputs[str(path)]=hashlib.sha256(path.read_bytes()).hexdigest()
                arrays[f'{backend}{index}']=stack.enter_context(np.load(path))
        for tag,source_report in result['sources'].items():
            for key,inside in source_report['all_steps_within'].items():
                if inside:continue
                original=np.asarray([arrays[f'original{i}'][key] for i in range(8)],dtype='f8')
                source=arrays[tag][key].astype('f8')
                total=original.sum(axis=0)
                axes=tuple(range(1,source.ndim))
                envelope=np.max([np.max(np.abs(original[i]-(total-original[i])/7),axis=axes) for i in range(8)],axis=0)
                errors=np.max(np.abs(source-total/8),axis=axes)
                step=int(np.flatnonzero(errors>envelope)[0])
                component=np.unravel_index(np.argmax(np.abs(source[step]-total[step]/8)),source[step].shape)
                coord=(step,*component)
                bits=int(arrays[tag][key].view('u4')[coord])
                rows.append({'case':case,'candidate':tag,'field':key,'first_outside_step':step,
                    'component':list(map(int,component)),'source_bits':bits,'source_value':float(source[coord]),
                    'original_values_at_same_component':[float(arrays[f'original{i}'][key][coord]) for i in range(8)],
                    'original_bits_at_same_component':[int(arrays[f'original{i}'][key].view('u4')[coord]) for i in range(8)],
                    'envelope':float(envelope[step]),'max_source_error':float(errors[step]),
                    'original0_source_bitwise_at_step':arrays['original0'][key][step].tobytes()==arrays[tag][key][step].tobytes()})
output=base/'graph-fixed-first-outside.json';assert not output.exists()
output.write_text(json.dumps({'failed_cases':sum(not value['primary_c_passed'] for value in report['cases'].values()),
 'outside_fields':rows,'input_sha256':inputs,'new_gpu_samples':0,'candidate_replaced':False,'whole_solver_complete':False,
 'harness_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()},indent=2)+'\n')
print('first-outside fields',len(rows),'cases',len(set(row['case'] for row in rows)))
for case in sorted(set(row['case'] for row in rows)):
    selected=[row for row in rows if row['case']==case]
    first=min(row['first_outside_step'] for row in selected)
    row=next(row for row in selected if row['first_outside_step']==first)
    print(case,first,row['candidate'],row['field'],row['component'],row['envelope'],row['max_source_error'])
