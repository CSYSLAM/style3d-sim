"""Open only captured AL driven-cloth soft/rigid-soft branches; preserve all numerical code."""
from pathlib import Path
import hashlib,json
root=Path.cwd();base=Path(__file__).resolve().parent
checkpoint=root/'build/reconstruction-checkpoints/driven-cloth-mixed-contact-before-688f9633/checkpoint.json'
proof=json.loads(checkpoint.read_text());source=root/'reconstruction/csrc/native/source_solver.cpp'
old=source.read_bytes();assert hashlib.sha256(old).hexdigest()==proof['files']['reconstruction/csrc/native/source_solver.cpp']
for folder in (base,base.parent/'continuation-20261101-688f9633-driven-cloth-contact'):
 report=json.loads((folder/'original32/report.json').read_text());assert report['complete'] and len(report['cases'])==32
 assert all(row['exit']==0 and row['finite'] and row['body_rhs_changed'] and row['cloth_rhs_changed'] for row in report['cases'])
s=old.decode()
changes=[
 ('// Active drag, contacts, self-collision and other joint/material combinations remain outside this capture.',
  '// Active drag, hard contacts, self-collision and other joint/material combinations remain outside this capture.'),
 ('!tetrahedron_count_ && !spring_count_ && !contact.max_count && !contact.soft_max_count;\n        if (bodies && (triangle_count_ || edge_count_)',
  '!tetrahedron_count_ && !spring_count_ &&\n            ((!contact.max_count && !contact.soft_max_count) ||\n             (contact.soft_max_count && !config.rigid_contact_hard));\n        if (bodies && (triangle_count_ || edge_count_)'),
 ('if (bodies && surface && (!so3 || body_spring_total_',
  'if (bodies && surface && !driven_cloth && (!so3 || body_spring_total_'),
 ('if (body_block && !isolated_plain && !isolated_undriven_joint &&',
  'if (body_block && !driven_cloth && !isolated_plain && !isolated_undriven_joint &&'),
 ('"driven_cloth_body_blocks",',
  '"driven_cloth_body_blocks",\n                                                     "driven_cloth_soft_contacts_newton",\n                                                     "driven_cloth_soft_contacts_pd_newton",\n                                                     "driven_cloth_rigid_soft_contacts_newton",\n                                                     "driven_cloth_rigid_soft_contacts_pd_newton",\n                                                     "driven_cloth_rolling_contacts_body_blocks",')]
for a,b in changes:
 assert s.count(a)==1,a;s=s.replace(a,b)
assert max(map(len,s.splitlines()))<=128
source.write_text(s)
(base/'guard-edit-receipt.json').write_text(json.dumps({'before_sha256':hashlib.sha256(old).hexdigest(),
 'after_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),'checkpoint':str(checkpoint),
 'changes':changes,'mathematics_changed':False,'kernel_schedule_changed':False,'CUDA_changed':False,
 'hard_self_other_material_combinations_still_guarded':True},indent=2)+'\n')
