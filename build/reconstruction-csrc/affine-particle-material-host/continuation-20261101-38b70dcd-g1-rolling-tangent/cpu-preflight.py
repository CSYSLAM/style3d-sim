"""Freeze the actual late rolling-tangent ABI, source templates and an independent raw-data auditor."""
import ast
import hashlib
import json
from pathlib import Path
import sys

root=Path.cwd()
sys.path.insert(0,str(root))
from reconstruction.csrc.g1_contact_rhs_replay import instrument256,kernel_texts
from reconstruction.csrc.g1_rolling_tangent_capture import rendered_source as capture_source
from reconstruction.csrc.g1_rolling_tangent_replay import rendered_source as replay_source
from reconstruction.csrc.graph_definition_compare import linear_order
from reconstruction.csrc.library_entries import entries
from reconstruction.csrc.ptx_compare import normalise
from reconstruction.csrc.ptx_store_origins_param import store_origins

base=Path(__file__).resolve().parent
old=base.parent/'continuation-20261101-38b70dcd-g1-rolling'
build_path=root/'build/reconstruction-csrc/host-particles/build.json'
build=json.loads(build_path.read_text())
assert build['extension_sha256']=='38b70dcd9f3ca5053184eca9c6ec64cc33c137248a3e70efa729bd7ff0d92a49'
old_layout=json.loads((old/'CPU-layout-preflight.json').read_text())
assert old_layout['native_CXX_size']==248
templates={'capture':capture_source(),'replay':replay_source()}
for name,text in templates.items():
    ast.parse(text)
    assert all(len(line)<=128 for line in text.splitlines()),name
    (base/(name+'-template.py')).write_text(text)
namespace={'__name__':'reconstruction.csrc.tangent_capture_preflight','__package__':'reconstruction.csrc',
           '__file__':str(base/'capture-template.py')}
exec(compile(templates['capture'],str(base/'capture-template.py'),'exec'),namespace)
records={}
kernel=None
for side in ('original','source'):
    nodes=linear_order(json.loads((old/side/'definition-before/graph.json').read_text()))[0]
    stages=namespace['select_stages'](nodes,44,49)
    assert len(stages)==1 and stages[0]['key']=='tangent'
    stage=stages[0]
    assert kernel is None or kernel==stage['node']['name']
    kernel=stage['node']['name']
    assert sum(stage['sizes'].values())+stage['sizes'][2]==96276
    assert len(stage['sizes'])+len(stage['outputs'])==27
    records[side]={'stage':stage,'snapshot_bytes':96276,'snapshot_nodes':27,
                   'expected_graph_nodes':17494,'expected_graph_edges':17495}
proofs={}
texts,original=kernel_texts(build,kernel)
fields=[(0,offset) for offset in namespace['POINTER_OFFSETS']]+[(1,0),(2,0)]
for side,text in texts.items():
    entry=entries(text)[kernel]
    proof=store_origins(entry,fields)
    assert proof['parameter_count']==3 and proof['potential_written_pointer_fields']==[(2,0)]
    changed,sites=instrument256(text,kernel)
    (base/('tangent-'+side+'-entry.ptx')).write_text(entry)
    (base/('tangent-'+side+'-instrumented-preflight.ptx')).write_text(changed)
    proofs[side]={'stores':proof,'static_atomic_sites':sites,
                  'normalized_entry_sha256':hashlib.sha256(normalise(entry).encode()).hexdigest()}
proofs['normalized_PTX_equal']=proofs['original']['normalized_entry_sha256']==proofs['source']['normalized_entry_sha256']

# Retain the earlier independently structured auditor, specializing only the ABI and this selected graph node.
audit_path=old/'independent-cpu-audit.py'
assert hashlib.sha256(audit_path.read_bytes()).hexdigest()=='f1bf4bc2e44798a3d9c5b348fcdb53dff92c0319ffc10d12ef4f82074ea33357'
text=audit_path.read_text()
replacements=[]


def replace(old_text,new_text,count=1):
    global text
    assert text.count(old_text)==count,(old_text,text.count(old_text))
    text=text.replace(old_text,new_text)
    replacements.append({'old':old_text,'new':new_text,'occurrences':count})


replace("return {1:(1,0,2112 if key=='force' else 6336),",
        'return {1:(1,0,2112),2:(2,0,2112),')
for a,b,n in [
    ("len(replay['packets'])==240","len(replay['packets'])==120",1),
    ('len(new_order)==17519','len(new_order)==17494',1),
    ("len(new['edges'])==17522","len(new['edges'])==17495",1),
    ("len(layout['snapshots'])==52","len(layout['snapshots'])==27",1),
    ("len(layout['stages'])==2","len(layout['stages'])==1",1),
    ("(14577 if key=='force' else 14592)",'17455',1),
    ('[248,8]','[248,8,8]',3),
    ("stage['outputs']==[1]","stage['outputs']==[2]",1),
    ("('after',1)","('after',2)",1),
    ('==196776','==96276',1),
    ('range(2)','range(3)',2),
    ("packet['after-binding-1']","packet['after-binding-2']",1),
    ('bindings[1]','bindings[2]',1),
    ("{'1':changed}","{'2':changed}",1),
    ('actual_pointers[1]','actual_pointers[2]',5),
    ("{'1':actual_pointers[2]}","{'2':actual_pointers[2]}",1),
    ("backend+'-output-1'","backend+'-output-2'",1),
    ("{'1':equal}","{'2':equal}",1),
    ('if i==1:','if i==2:',1),
    ("(18 if key=='force' else 54)",'18',1),
    ('target=(1,','target=(2,',1),
    ("('force','matrix')","('tangent',)",1),
]:
    replace(a,b,n)
replace("        for check in row['checks']:",
        "        assert len(row['checks'])==5\n"
        "        assert {c['backend'] for c in row['checks']}=={\n"
        "            'original-runtime','original-ptx','source-ptx','original-probe','source-probe'}\n"
        "        for check in row['checks']:")
replace("        counts[key]['preserved_view_scalar_bytes']+=int(scalar.sum())",
        "        counts[key]['preserved_view_scalar_bytes']+=int(scalar.sum())\n"
        "        counts[key]['ABI_pointer_fields_rechecked']+=len(expected)\n"
        "        counts[key]['actual_ABI_bytes_rechecked']+=sum(map(len,relocated))")
ast.parse(text)
assert all(len(line)<=128 for line in text.splitlines())
(base/'independent-cpu-audit.py').write_text(text)
(base/'audit-generation.json').write_text(json.dumps({'base_sha256':hashlib.sha256(audit_path.read_bytes()).hexdigest(),
 'replacements':replacements,'generated_sha256':hashlib.sha256(text.encode()).hexdigest()},indent=2)+'\n')
control=(old/'control-form-audit.py').read_text()
assert control.count('assert len(rows)==4')==1
control=control.replace('assert len(rows)==4','assert len(rows)==2').replace('All4 actual','All2 actual')
control=control.replace('all240 packets','all120 packets')
(base/'control-form-audit.py').write_text(control)
for name,old_module,new_module in [('run-captures.py','g1_rolling_capture','g1_rolling_tangent_capture'),
                                 ('run-replay.py','g1_rolling_replay','g1_rolling_tangent_replay')]:
    script=(old/name).read_text()
    assert script.count(old_module)==1
    script=script.replace(old_module,new_module)
    script=script.replace('60 rolling-force and60 rolling-preconditioner packets','60 late rolling-tangent packets')
    (base/name).write_text(script)
hashes=dict(json.loads((old/'plan.json').read_text())['input_sha256'])
paths=[Path(__file__),root/'reconstruction/csrc/g1_rolling_tangent_capture.py',
       root/'reconstruction/csrc/g1_rolling_tangent_replay.py',original,old/'CPU-layout-preflight.json']
paths += [base/name for name in ['capture-template.py','replay-template.py','independent-cpu-audit.py',
                                'control-form-audit.py','run-captures.py','run-replay.py']]
for path in paths:
    hashes[str(path.resolve())]=hashlib.sha256(path.read_bytes()).hexdigest()
for path,sha in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest()==sha,path
plan={'previous_goal_turn':'progress: published rolling force/preconditioner strict proof in abdb9dc6',
      'frames':60,'backends':['original','source'],'stages':['tangent'],'kernels':{'tangent':kernel},
      'input_sha256':hashes,'actual_pre_call_output_initial_required':True,
      'extra_isolation_only_if_complete_strict_gate_does_not_pass':True,
      'frozen_cohort_extended':False,'production_changed':False,'whole_solver_complete':False}
(base/'plan.json').write_text(json.dumps(plan,indent=2)+'\n')
(base/'CPU-layout-preflight.json').write_text(json.dumps({'records':records,'PTX_proofs':{'tangent':proofs},
 'native_CXX_size':248,'native_CXX_field_offsets':old_layout['native_CXX_field_offsets'],
 'GPU_context_created':False,'whole_solver_complete':False},indent=2)+'\n')
print('Late rolling-tangent preflight passed:248/8/8 ABI,26 bindings,27 snapshots,96276 bytes.',flush=True)
print('Atomic sites:',{side:proofs[side]['static_atomic_sites'] for side in ('original','source')},flush=True)
