from pathlib import Path
import hashlib,json
root=Path.cwd();base=Path(__file__).resolve().parent;p=root/'reconstruction/csrc/native/source_solver.cpp'
checkpoint=json.loads((root/'build/reconstruction-checkpoints/undriven-axis-before-3d1b1b88/checkpoint.json').read_text())
assert hashlib.sha256(p.read_bytes()).hexdigest()==checkpoint['files'][str(p.relative_to(root))]
s=p.read_text();changes=[]
def replace(old,new,label):
 global s
 assert s.count(old)==1,(label,s.count(old));s=s.replace(old,new);changes.append(label)
replace('''        const bool isolated_undriven_joint = joint_spring_total_ && !plain_spring_count_ && !point_line_total_ &&
            !distance_total_ && !drive_total_ && !cable_count_ && !fluid_rows_ && !granular_points_ && !self &&''',
'''        const bool isolated_undriven_joint = ((joint_spring_total_ > 0) != (joint_line_total_ > 0)) &&
            !plain_spring_count_ && !plain_line_count_ && !distance_total_ && !drive_total_ &&
            !cable_count_ && !fluid_rows_ && !granular_points_ && !self &&''',
'Allow captured pure joint-line AL PD/body-block cases; retain unobserved spring+line and other mixtures')
replace('''                (drive_total_ || (joint_spring_total_ && !joint_line_total_)) && !cable_count_ && !fluid_rows_ &&''',
'''                (drive_total_ || isolated_undriven_joint) && !cable_count_ && !fluid_rows_ &&''',
'Allow captured pure zero-drive joint-line penalty cases')
replace('''                                                     "undriven_joint_body_blocks_pd_newton",''',
'''                                                     "undriven_joint_body_blocks_pd_newton",
                                                     "undriven_joint_point_lines_newton",
                                                     "undriven_joint_point_lines_pd_newton",
                                                     "undriven_joint_point_lines_body_blocks",
                                                     "undriven_joint_point_lines_penalty",''',
'Expose the four captured joint-line scopes')
assert max(map(len,s.splitlines()))<=128;p.write_text(s)
(base/'axis-edit-receipt.json').write_text(json.dumps({'before_sha256':checkpoint['files'][str(p.relative_to(root))],'after_sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'changes':changes,'CUDA_changed':False,'CPU_template_math_changed':False,'kernel_dispatch_code_changed':False,'whole_solver_complete':False},indent=2)+'\n')
print('Applied only the SDK-captured pure zero-drive axis guards',flush=True)
