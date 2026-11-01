"""Restore the actual SDK penalty host route; reject ambiguous edits before changing production."""
from pathlib import Path

path = Path('reconstruction/csrc/native/source_solver.cpp')
whole = path.read_text()
start = whole.index('    void step(const State&')
end = whole.index('    // Clears the persistent angle-branch flags:', start)
body = whole[start:end]

def replace(label, old, new, count=1):
    global body
    actual = body.count(old)
    assert actual == count, (label, actual, count)
    body = body.replace(old, new)

replace('mode selector',
        '        const bool pd = config.nonlinear_solver == NonlinearSolver::PD_NEWTON;',
        '        const bool pd = config.nonlinear_solver == NonlinearSolver::PD_NEWTON;\n'
        '        const bool joint_al = config.joint_constraint_mode == JointConstraintMode::AUGMENTED_LAGRANGIAN;')
replace('captured penalty guard',
'''        if ((joint_spring_total_ || joint_line_total_) &&
            config.joint_constraint_mode != JointConstraintMode::AUGMENTED_LAGRANGIAN)
            throw std::runtime_error("Only augmented-Lagrangian joint constraints have been captured");''',
'''        if ((joint_spring_total_ || joint_line_total_) && !joint_al) {
            const bool isolated_penalty = config.joint_constraint_mode == JointConstraintMode::PENALTY && so3 &&
                !plain_spring_count_ && !plain_line_count_ && !distance_total_ &&
                (drive_total_ || (joint_spring_total_ && !joint_line_total_)) && !cable_count_ && !fluid_rows_ &&
                !granular_points_ && !self && !drag_count_ && !tetrahedron_count_ && !spring_count_ &&
                !triangle_count_ && !edge_count_ && !contact.max_count && !contact.soft_max_count;
            if (!isolated_penalty)
                throw std::runtime_error("This mixed or undriven-line joint penalty scope has not been captured");
        }''')
replace('line weight',
        '        const float body_so3_alpha = so3 ? so3_alpha : zero;',
        '        const float body_so3_alpha = so3 ? so3_alpha : zero;\n'
        '        const float line_matrix_alpha = joint_al ? zero : alpha;')
replace('initial line channel',
'''                   in.particle_q.ptr, host_diagonal_, body_d1_, spring_alpha, body_d2_, zero, joint_d3_, alpha, joint_d4_, zero,
                   distance_d5_, alpha, mass, flags, body_kind_, previous_, target_, diagonal_, count_, per_world_);''',
'''                   in.particle_q.ptr, host_diagonal_, body_d1_, spring_alpha, body_d2_, zero, joint_d3_, alpha,
                   joint_d4_, line_matrix_alpha, distance_d5_, alpha, mass, flags, body_kind_, previous_, target_,
                   diagonal_, count_, per_world_);''')
replace('combined line channel',
        'launch("combine", entries, stream, inverse_dt2, spring_alpha, zero, alpha, zero, alpha,',
        'launch("combine", entries, stream, inverse_dt2, spring_alpha, zero, alpha, line_matrix_alpha, alpha,')
replace('AL spring dispatch', 'if (joint_spring_total_)', 'if (joint_al && joint_spring_total_)', 3)
replace('AL line dispatch', 'if (joint_line_total_)', 'if (joint_al && joint_line_total_)', 3)
replace('AL line Newton Hessian', 'if (!pd && joint_line_total_)', 'if (!pd && joint_al && joint_line_total_)')
replace('AL line PD operators', 'if (pd && joint_line_total_)', 'if (pd && joint_al && joint_line_total_)', 2)
replace('spring force includes joints',
        'static_cast<std::size_t>(model_.joint_body_spring_count), false, rhs_',
        'static_cast<std::size_t>(model_.joint_body_spring_count), !joint_al, rhs_')
replace('line force includes joints',
        'static_cast<std::size_t>(model_.joint_body_point_line_count), false, rhs_',
        'static_cast<std::size_t>(model_.joint_body_point_line_count), !joint_al, rhs_')
replace('line Newton dispatch', 'if (!pd && plain_line_count_)',
        'if (!pd && (plain_line_count_ || (!joint_al && joint_line_total_)))')
replace('line Hessian includes joints',
        'static_cast<std::size_t>(model_.joint_body_point_line_count), !joint_line_total_,',
        'static_cast<std::size_t>(model_.joint_body_point_line_count), !joint_al || !joint_line_total_,')
whole = whole[:start] + body + whole[end:]
anchor = '                                                     "undriven_joint_body_blocks_pd_newton",'
assert whole.count(anchor) == 1
whole = whole.replace(anchor, anchor + '''
                                                     "joint_penalty_constraints_newton",
                                                     "joint_penalty_constraints_pd_newton",
                                                     "joint_penalty_constraints_body_blocks",''')
whole = whole.replace('mixed and undriven joint routes remain guarded.', 'mixed and undriven-line routes remain guarded.')
long = [(i + 1, len(line)) for i, line in enumerate(whole.splitlines()) if len(line) > 128]
assert not long, long
path.write_text(whole)
print('Wrote SDK-observed penalty route; all edits uniquely matched and all lines <=128', flush=True)

