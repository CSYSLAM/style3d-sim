from pathlib import Path
import hashlib,json
root=Path.cwd();base=Path(__file__).resolve().parent
checkpoint=json.loads((root/'build/reconstruction-checkpoints/mixed-plain-before-aa52ee61/checkpoint.json').read_text())
path=root/'reconstruction/csrc/native/source_solver.cpp'
assert hashlib.sha256(path.read_bytes()).hexdigest()==checkpoint['files'][str(path.relative_to(root))]
s=path.read_text();edits=[]
def replace(old,new,label):
 global s
 assert s.count(old)==1,(label,s.count(old));s=s.replace(old,new);edits.append(label)
replace('''            if (plain_spring_count_ && plain_line_count_)
                throw std::runtime_error("Mixed plain body springs and point-lines have not been captured");''',
'''            if (plain_spring_count_ && plain_line_count_ && (model_.joint_body_spring_count ||
                    model_.joint_body_point_line_count || model_.joint_drive_count || model_.cable_count ||
                    model_.fluid_particle_count))
                throw std::runtime_error("Mixed plain constraints with joints/cables/fluid have not been captured");''',
'Allow the captured plain spring/point-line constructor, retaining unobserved joint/cable/fluid combinations')
replace('''            ((plain_spring_count_ > 0) + (plain_line_count_ > 0) + (distance_total_ > 0) == 1) &&''',
'''            (plain_spring_count_ || plain_line_count_ || distance_total_) &&''',
'Allow captured isolated plain mixtures through PD and body-block guards')
replace('''        // Captured PD routes omit plain Gauss-Newton blocks; mixed and undriven-line routes remain guarded.''',
'''        // Captured isolated plain PD routes omit Gauss-Newton blocks; undriven-line joint routes remain guarded.''',
'Describe the captured guard scope')
replace('''                                                     "isolated_plain_constraints_body_blocks",''',
'''                                                     "isolated_plain_constraints_body_blocks",
                                                     "isolated_mixed_plain_constraints_newton",
                                                     "isolated_mixed_plain_constraints_pd_newton",
                                                     "isolated_mixed_plain_constraints_body_blocks",''',
'Advertise the three captured mixed-plain scopes')
assert max(map(len,s.splitlines()))<=128
path.write_text(s)
(base/'edit-receipt.json').write_text(json.dumps({'edits':edits,'before_sha256':checkpoint['files'][str(path.relative_to(root))],'after_sha256':hashlib.sha256(path.read_bytes()).hexdigest(),'CUDA_changed':False,'CPU_template_math_changed':False,'host_schedule_changed':False,'whole_solver_complete':False},indent=2)+'\n')
print('Source guard changes applied with exact-match assertions',flush=True)
