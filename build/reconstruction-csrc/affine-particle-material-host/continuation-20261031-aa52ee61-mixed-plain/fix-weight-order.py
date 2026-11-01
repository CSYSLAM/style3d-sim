from pathlib import Path
import hashlib,json
root=Path.cwd();base=Path(__file__).resolve().parent;p=root/'reconstruction/csrc/native/source_solver.cpp'
checkpoint=json.loads((root/'build/reconstruction-checkpoints/mixed-weight-before-6a514e46/checkpoint.json').read_text())
assert hashlib.sha256(p.read_bytes()).hexdigest()==checkpoint['files'][str(p.relative_to(root))]
s=p.read_text();old='''        auto upload_weight = [&](std::uint64_t& target, const auto& values, int order) {
            // Actual body-constraint constructors upload weights after scalar ELL initialization.
            const auto begin = reinterpret_cast<const char*>(values.data());'''
new='''        const bool plain_distance_before_line = model_.body_distance_constraint_count &&
            model_.body_point_line_count && !model_.joint_body_spring_count && !model_.joint_body_point_line_count &&
            !model_.joint_drive_count && !model_.cable_count && !model_.fluid_particle_count;
        auto upload_weight = [&](std::uint64_t& target, const auto& values, int order) {
            // Actual plain-mixture allocation identities put distance weights before point-line weights.
            if (plain_distance_before_line) {
                if (order >= 2 && order <= 4) order += 2;
                else if (order == 10 || order == 11) order -= 8;
            }
            // Actual body-constraint constructors upload weights after scalar ELL initialization.
            const auto begin = reinterpret_cast<const char*>(values.data());'''
assert s.count(old)==1;s=s.replace(old,new);assert max(map(len,s.splitlines()))<=128;p.write_text(s)
(base/'weight-order-edit-receipt.json').write_text(json.dumps({'before_sha256':checkpoint['files'][str(p.relative_to(root))],'after_sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'evidence':'actual-weight-allocation-order-resolved.json','scope':'plain distance plus point-line, without joint/drive/cable/fluid','math_changed':False,'CUDA_changed':False,'whole_solver_complete':False},indent=2)+'\n')
p=base/'run-validation.py';s=p.read_text();(base/'run-validation-before-adoption.py').write_text(s)
old="            '--fixture-args','--constraints',kind,'--worlds','3','--seed','3','--mode',mode,'--body-block']))"
new="            '--original-capture',str(base/'validation-6a514e46'/name),\n"+old
assert s.count(old)==1;s=s.replace(old,new);p.write_text(s)
print('Applied SDK-proven weight allocation order; fixed originals will be adopted byte for byte',flush=True)
