from pathlib import Path
import hashlib,json
root=Path.cwd();base=Path(__file__).resolve().parent;p=root/'reconstruction/csrc/native/source_solver.cpp'
checkpoint=json.loads((root/'build/reconstruction-checkpoints/driven-cloth-before-430b5b74/checkpoint.json').read_text())
assert hashlib.sha256(p.read_bytes()).hexdigest()==checkpoint['files'][str(p.relative_to(root))]
s=p.read_text();changes=[]
def replace(old,new,label):
 global s
 assert s.count(old)==1,(label,s.count(old));s=s.replace(old,new);changes.append(label)
old='''        if (bodies && particle_materials && (model.body_spring_count || model.body_distance_constraint_count ||
                model.body_point_line_count || model.joint_drive_count || model.joint_body_spring_count ||
                model.joint_body_point_line_count || model.cable_count || model.fluid_particle_count))'''
new='''        const bool driven_cloth = model.triangle_count && model.joint_drive_count && model.joint_body_spring_count &&
            model.body_spring_count == model.joint_body_spring_count && !model.body_point_line_count &&
            !model.joint_body_point_line_count && !model.body_distance_constraint_count && !model.spring_count &&
            !model.tetrahedron_count && !model.cable_count && !model.fluid_particle_count && !model.granular_particle_count;
        if (bodies && particle_materials && !driven_cloth &&
            (model.body_spring_count || model.body_distance_constraint_count || model.body_point_line_count ||
             model.joint_drive_count || model.joint_body_spring_count || model.joint_body_point_line_count ||
             model.cable_count || model.fluid_particle_count))'''
replace(old,new,'Allow only the SDK-captured joint-spring/drive/triangle/bending constructor topology')
old='''        const bool constitutive = bodies && !so3 && !six_springs;'''
new=old+'''
        // Active drag, contacts, self-collision and other joint/material combinations remain outside this capture.
        const bool driven_cloth = bodies && (so3 || six_springs) && joint_al && triangle_count_ && drive_total_ &&
            joint_spring_total_ && body_spring_total_ == joint_spring_total_ && !point_line_total_ &&
            !distance_total_ && !cable_count_ && !fluid_rows_ && !granular_points_ && !self && !drag_count_ &&
            !tetrahedron_count_ && !spring_count_ && !contact.max_count && !contact.soft_max_count;
        if (bodies && (triangle_count_ || edge_count_) &&
            (body_spring_total_ || distance_total_ || point_line_total_ || drive_total_) && !driven_cloth)
            throw std::runtime_error("This constrained cloth/body combination has not been captured");'''
replace(old,new,'Validate the captured AL SO3/SIX driven-cloth scope at step time')
replace('''        if (bodies && !so3 && (spring_count_''',
'''        if (bodies && !so3 && !driven_cloth &&
            (spring_count_''','Allow the captured SIX_SPRINGS composite through the non-SO3 guard')
replace('''                                                     "driven_joint_body_blocks_pd_newton",''',
'''                                                     "driven_joint_body_blocks_pd_newton",
                                                     "driven_cloth_so3_newton",
                                                     "driven_cloth_so3_pd_newton",
                                                     "driven_cloth_six_springs_newton",
                                                     "driven_cloth_six_springs_pd_newton",
                                                     "driven_cloth_body_blocks",''','Expose captured driven-cloth scopes')
assert max(map(len,s.splitlines()))<=128;p.write_text(s)
(base/'driven-cloth-edit-receipt.json').write_text(json.dumps({'changes':changes,'before_sha256':checkpoint['files'][str(p.relative_to(root))],'after_sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'CUDA_changed':False,'CPU_template_math_changed':False,'kernel_dispatch_code_changed':False,'whole_solver_complete':False},indent=2)+'\n')
print('Opened only the captured no-contact AL driven-cloth constructor and SO3/SIX step scopes',flush=True)
