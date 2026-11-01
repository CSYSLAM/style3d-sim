"""One fixed C8 observation per first failing driven-cloth candidate; do not replace source0 or original0."""
from pathlib import Path
import hashlib,json,subprocess,sys
from contextlib import ExitStack
import numpy as np
root=Path.cwd();sys.path.insert(0,str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.csrc.audit_cudahook import compare as compare_launches,schemas
from reconstruction.csrc.host_api_probe import REFERENCE_SHA
from reconstruction.demo_ab import compare,spread_report
base=Path(__file__).resolve().parent
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes()
image=json.loads(saved)['extension_sha256']
output=base/('fixed-C8-'+image[:8]);output.mkdir(exist_ok=False)
(output/'build.json').write_bytes(saved);(output/'driver.py').write_bytes(Path(__file__).read_bytes())
first=json.loads((base/('source64-'+image[:8])/'report.json').read_text())
assert first['complete'] and len(first['cases'])==64
assert all(row['metadata']['equal'] and row['finite'] and row['coverage'] for row in first['cases'])
failed=[row['group']+'__'+row['case'] for row in first['cases'] if not row['passed']]
assert failed
hook=root/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
locked={str(root/path):sha for path,sha in json.loads(saved)['sources'].items()}
for path in (hook,root/'reconstruction/csrc/driven_cloth_contact_scene.py',
             root/'reconstruction/csrc/driven_cloth_rigid_soft_scene.py',
             root/'reconstruction/csrc/demo_source_ab.py',root/'reconstruction/csrc/host_bodies_ab.py',
             root/'reconstruction/csrc/host_particles_ab.py',
             root/'build/reconstruction-csrc/host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so'):
    locked[str(path)]=hashlib.sha256(path.read_bytes()).hexdigest()
status={'source_sha256':image,'complete':False,'completed':[],'planned_cases':failed,
        'original_runs':8,'source_runs':3,'first_candidates_replaced':False,'cohorts_resampled':False,
        'dump_limits':'Adopted actual protocol: legacy18/surface9','primary_c':'All four fields, all three steps, all three fixed source candidates within original leave-one-out spread.',
        'locked_sha256':locked,'whole_solver_complete':False}
for case in failed:
    group,native_case=case.split('__',1)
    reference_parent=base if group=='rigid-soft' else base.parent/'continuation-20261101-688f9633-driven-cloth-contact'
    reference=reference_parent/'original32'/native_case
    source0=base/('source64-'+image[:8])/group/native_case
    runtime=json.loads((reference/'capture.runtime.json').read_text())
    folder=output/case;folder.mkdir()
    paths={'original0':reference,'source0':source0}
    adopted={tag:{'path':str(path),'sha256':{name:hashlib.sha256((path/name).read_bytes()).hexdigest()
             for name in ('capture.npz','capture.runtime.json','run.log','launches.txt')}} for tag,path in paths.items()}
    (folder/'adopted-fixed.json').write_text(json.dumps(adopted,indent=2)+'\n')
    protocol=json.loads((reference/'capture-protocol.json').read_text())
    dump,dump_limit=protocol['dump'],protocol['limit']
    indices={'53evaluate_joint_body_spring_augmented_lagrangian_force': 10, '25evaluate_joint_drive_load': 26, '22evaluate_stretch_force': 5, '22evaluate_bending_force': 7, '51evaluate_affine_body_so3_augmented_lagrangian_force': 6, '33evaluate_affine_body_spring_force': 4, '22evaluate_contact_force': 32, '30evaluate_rolling_contact_force': 1, '30evaluate_surface_contact_force': 1, '27evaluate_soft_contact_force': 36}
    prior=next(row for row in first['cases'] if row['group']==group and row['case']==native_case)
    fields=[(token,indices[token]) for token in prior['all_nine_force_buffers_equal']]
    (folder/'capture-protocol.json').write_text(json.dumps(protocol,indent=2)+'\n')
    audits=[]
    for backend,tag in [('original',f'original{i}') for i in range(1,8)]+[('source',f'source{i}') for i in (1,2)]:
        assert build.read_bytes()==saved
        assert all(hashlib.sha256(Path(path).read_bytes()).hexdigest()==sha for path,sha in locked.items())
        for old in adopted.values():
            assert all(hashlib.sha256((Path(old['path'])/name).read_bytes()).hexdigest()==sha for name,sha in old['sha256'].items())
        target=folder/tag;target.mkdir();paths[tag]=target
        command=[sys.executable,'-m','reconstruction.csrc.demo_source_ab','--worker',backend,'--tag','capture',
                 '--example',runtime['example'],'--frames',str(runtime['frames']),'--output',str(target),'--',*runtime['extra']]
        (target/'command.json').write_text(json.dumps(command,indent=2)+'\n')
        status['running']=[case,tag];(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
        with (target/'run.log').open('w') as log:
            code=subprocess.run(command,env={**clean_env(),'LD_PRELOAD':str(hook),'CUDAHOOK_DIR':str(target),
                    'CUDAHOOK_DUMP':dump,'CUDAHOOK_DUMP_LIMIT':str(dump_limit)},stdout=log,stderr=subprocess.STDOUT,timeout=1800).returncode
        assert code==0,(case,tag,code)
        actual=json.loads((target/'capture.runtime.json').read_text())
        assert actual['image_sha256']==(REFERENCE_SHA if backend=='original' else image)
        assert all(actual[key]==runtime[key] for key in ('example_sha256','frames','extra','launch_hook_sha256'))
        metadata=compare_launches(reference/'launches.txt',target/'launches.txt',schemas()[0])
        assert metadata['equal'],(case,tag)
        buffers={f'{token}/{phase}':(reference/f'dump_{token}_call000_{phase}_arg{index}.bin').read_bytes()==
                     (target/f'dump_{token}_call000_{phase}_arg{index}.bin').read_bytes()
                 for token,index in fields for phase in ('pre','post')}
        coverage=True
        if backend=='source':
            coverage=sum(json.loads((target/'capture.launches.json').read_text()).values())==metadata['right_launches']
        audits.append({'tag':tag,'metadata':metadata,'coverage':coverage,'first_force_buffers':buffers})
        print(case,tag,'metadata',metadata['equal'],'force0',all(buffers.values()),flush=True)
    with ExitStack() as stack:
        data={tag:stack.enter_context(np.load(path/'capture.npz')) for tag,path in paths.items()}
        originals=[data[f'original{i}'] for i in range(8)]
        sources=[data[f'source{i}'] for i in range(3)]
        assert all(set(run.files)==set(originals[0].files) for run in originals+sources)
        assert all(run[key].shape==originals[0][key].shape and np.isfinite(run[key]).all()
                   for run in originals+sources for key in run.files)
        stats={f'source{i}':spread_report(originals,[run]) for i,run in enumerate(sources)}
        checks={tag:{key:row['substeps_within_spread']==row['substeps'] for key,row in fields.items()}
                for tag,fields in stats.items()}
        report={'case':case,'source_sha256':image,'originals':8,'sources':3,'source_statistics':stats,
                'all_steps_within':checks,'primary_c_passed':all(all(fields.values()) for fields in checks.values()),
                'strict_original_repeats':[compare(originals[0],run) for run in originals[1:]],
                'strict_sources':[compare(originals[0],run) for run in sources],
                'complete_owned_metadata':audits,'adopted':adopted,'whole_solver_complete':False}
        (folder/'report.json').write_text(json.dumps(report,indent=2)+'\n')
    status['completed'].append({'case':case,'primary_c_passed':report['primary_c_passed'],'all_steps_within':checks})
    (output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
    print(case,'fixed C8',report['primary_c_passed'],flush=True)
status['complete']=True;status['running']=None
status['all_primary_c_passed']=all(row['primary_c_passed'] for row in status['completed'])
(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
raise SystemExit(int(not status['all_primary_c_passed']))
