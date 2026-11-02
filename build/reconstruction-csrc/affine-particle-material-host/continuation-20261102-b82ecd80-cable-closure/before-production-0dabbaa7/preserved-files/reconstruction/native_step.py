"""Newton step with the legacy solver's exact kernel sequence (tetrahedra, Style3D cloth, particle soft contact).

The order below was taken from nsys traces of the legacy library (one Newton iteration):

    initialize_rhs -> evaluate_soft_contact_force (force into rhs, scalar into the diagonal copy)
    -> evaluate_stretch_force -> evaluate_bending_force -> evaluate_tetrahedron_force (all into rhs)
    -> initialize_block_diagonal -> [cloth: memcpy ELL template -> add_cloth_membrane_gauss_newton_hessian]
    -> memcpy A->B -> evaluate_soft_contact_force (3x3 correction into A and B)
    -> add_bending_damping_preconditioner / add_tetrahedron_preconditioner (B only) -> invert_block_preconditioner
    -> initialize_zero_solution_and_reduce -> cub sum
    -> linear_iterations x [update_cg_direction -> memset T -> multiply_bending_damping_tangent /
       multiply_tetrahedron_tangent (T)
       -> multiply_soft_contact_hessian_off_diagonal -> multiply_matrix_and_reduce (A, ELL, T) -> cub sum
       -> update_solution_residual_and_reduce -> cub sum]
    -> apply_nonlinear_step -> restore the diagonal copy

The cloth constant matrix (membrane isotropic part + bending) comes from precompute.py, as in the legacy host code.
Each kernel is bit-exact against the legacy PTX (reconstruction/kernel_ab.py). Accumulation into shared vertices
follows numerics.element_atomic_add; on the GPU that order varies run to run.
"""
import numpy as np

from . import affine as affinek, cloth, rigid_contact as rigidk, rolling_contact as rollingk, joints as jointk
from . import hard_contacts as hardk
from . import drag, fluid as fluidk, surface_contact as surfacek, pcg, selfcollision, springs as springk
from .contact import multiply_soft_contact_hessian_off_diagonal, soft_contact_kernel
from .numerics import (F, element_atomic_add, fma, tetrahedron_force_ptx, tetrahedron_preconditioner_ptx,
                       tetrahedron_tangent_ptx)


def newton_step(solver, x_hat, previous, external, contact_inputs, h, self_collision=None, fluid=None, granular=None,
                bodies=None):
    """Run nonlinear_iterations Newton iterations; return the final positions.

    `fluid` (see fluid.py) adds build_grid/evaluate_rows/accumulate_rows before the contact force, its block
    diagonal to the preconditioner, multiply_rows to every PCG product and the world step limiter before the
    update. `granular` (granular.GranularState) accumulates contacts and bonds at the same place, adds its block
    diagonal to the preconditioner and multiplies in PCG; its commit/form step runs after the substep (solver.py).
    """
    mass = solver.mass
    mask = solver.flags
    pd = getattr(solver.config, 'nonlinear_solver', 0) == 1
    inv_h2 = F(1)/(h*h)
    inv_dt = F(1)/h
    n = len(x_hat)
    tets = solver.tets
    triangles = solver.triangles
    edges = solver.native_edges
    constant = solver.cloth_constant
    # initialize_step: host diagonal + (m + zero coefficient arrays)/(h*h).
    base = constant[0] if constant is not None else np.zeros(n, F)
    springs = getattr(solver, 'joint_springs', None)
    lines = getattr(solver, 'point_lines', None)
    alpha = F(solver.config.constraint_alpha)
    numerator = np.asarray(mass, F)
    rigidity = int(getattr(solver.config, 'affine_body_rigidity_model', 3)) if bodies is not None else 3
    so3 = bodies is not None and rigidity == 3
    six_springs = bodies is not None and rigidity == 2
    constitutive = bodies is not None and rigidity in (0, 1)
    if bodies is not None and rigidity != 3 and solver.config.nonlinear_solver == 1:
        raise NotImplementedError('PD_NEWTON with affine-body rigidity other than SO(3) AL')
    if six_springs:
        # SIX_SPRINGS constant part from the inertial cache (weight c1 = constraint_alpha): D1 = 3 w on the columns
        # (refresh_inertial_cache_diagonals) and L2 = 0 - w between the columns of a body (..._nonzeros).
        six_diag = np.zeros(len(mass), F)
        six_off = {}
        for ids, w in zip(bodies.indices, bodies.weight):
            for i in ids[1:]:
                six_diag[i] = F(F(w)*F(3))
                for j in ids[1:]:
                    if i != j:
                        six_off[(int(i), int(j))] = F(F(0)-F(w))
        numerator = fma(six_diag, alpha, numerator).astype(F)
    joint_off = {}
    if springs is not None:
        # initialize_step: (m + sum_k c_k D_k)/(h*h); the joint-spring diagonal template has weight constraint_alpha.
        joint_off, joint_diag = springs.joint_templates(len(mass))
        numerator = fma(joint_diag, alpha, numerator).astype(F)
        springs.initialize_state()
    distances = getattr(solver, 'distance_constraints', None)
    dist_off = {}
    if distances is not None:
        # initialize_step chain: fma(D5, alpha, fma(D3, alpha, m)); D5 holds the distance-constraint template.
        dist_off, dist_diag = distances.templates(len(mass))
        numerator = fma(dist_diag, alpha, np.asarray(numerator, F)).astype(F)
    plain_springs = springs is not None and springs.first_joint > 0
    plain_lines = lines is not None and lines.first_joint > 0
    plain_off = {}
    if plain_springs or plain_lines:
        if solver.config.nonlinear_solver == 1:
            raise NotImplementedError('PD_NEWTON with plain body springs/point-lines')
        # Plain springs and point-lines are penalties: their constant part k s_i s_j sits in the host matrix
        # (diagonal and L0, after any cloth terms); the per-iteration Gauss-Newton correction is added below.
        plain_off, plain_diag = jointk.plain_templates(len(mass), springs, lines)
        base = (base+plain_diag).astype(F)
    base_diagonal = (base+numerator/(h*h)).astype(F)
    # Inactive particles (nonpositive mass or cleared ACTIVE flag) get a zero diagonal in initialize_step.
    base_diagonal[~solver.active] = 0
    if constant is not None:
        _, row_nnz, cols, values, max_nnz = constant
        ell_cols, ell_template = pcg.initialize_block_non_diagonal(row_nnz, cols, values, max_nnz)
    mass_ell = None
    if bodies is not None:
        # initialize_affine_body_so3_state on the prediction (the state buffer already holds x_hat).
        if so3:
            bodies.rotation, bodies.multiplier = affinek.initialize_so3_state(x_hat, bodies.indices)
        # combine_system_non_diagonal over the union pattern of the templates (columns ascending per row):
        # fma(fma(L_joint, alpha, L_mass), 1/h^2, L0) with L0 the host constant matrix (cloth/springs); the other
        # templates have zero weight here. Point-line couplings enter with zero values (their blocks are added
        # per iteration).
        mass_ell = bodies.mass_ell
        pattern = dict(joint_off)
        for key in list(plain_off)+list(dist_off):
            pattern.setdefault(key, F(0))
        if lines is not None:
            for a, b in lines.pairs:
                parts = [int(i) for i in bodies.indices[a]]+([int(i) for i in bodies.indices[b]] if b >= 0 else [])
                for i in parts:
                    for j in parts:
                        if i != j:
                            pattern.setdefault((i, j), F(0))
        row_nnz, cols, values, joint_values, max_nnz = affinek.union_ell(len(mass), mass_ell, pattern)
        host = np.zeros_like(values)
        if constant is not None:
            row_nnz, cols, (values, joint_values, host), max_nnz = affinek.merge_ell(
                (row_nnz, cols, (values, joint_values), max_nnz), constant[1:])
        for (i, j), v in plain_off.items():
            slot = int(np.flatnonzero(cols[:row_nnz[i], i] == j)[0])
            host[slot, i] = F(host[slot, i]+v)
        if six_springs:
            six_values = np.zeros_like(values)
            for (i, j), v in six_off.items():
                six_values[int(np.flatnonzero(cols[:row_nnz[i], i] == j)[0]), i] = v
            values = fma(six_values, alpha, values).astype(F)   # chain head: fma(L2, c1, L1)
        values = fma(joint_values, alpha, values).astype(F)
        if dist_off:
            # combine chain: fma(L6, c5, fma(L4, c3, L1)); L6 is the distance template, also weighted alpha.
            dist_values = np.zeros_like(values)
            for (i, j), v in dist_off.items():
                dist_values[int(np.flatnonzero(cols[:row_nnz[i], i] == j)[0]), i] = v
            values = fma(dist_values, alpha, values).astype(F)
        combined = fma(values, inv_h2, host).astype(F)
        ell_cols, ell_template = pcg.initialize_block_non_diagonal(row_nnz, cols, combined, max_nnz)
        constant = (constant[0] if constant is not None else None, row_nnz, cols, combined, max_nnz)
        so3_alpha = F(F(solver.config.constraint_alpha)*inv_h2)
        if lines is not None:
            lines.initialize_state(x_hat)   # initialize_joint_body_point_line_state on the prediction
    if distances is not None:
        distances.initialize_state(x_hat)   # initialize_body_distance_constraint_state, after initialize_step
    rigid = getattr(solver, 'rigid_contacts', None)
    hard = (solver.hard_contact_state(rigid[0] if rigid is not None else None)
            if getattr(solver.config, 'rigid_contact_hard', False) else None)
    if rigid is not None:
        rc, shapes, cbodies = rigid
    if rigid is not None and hard is not None:
        cfg = solver.config
        # initialize_hard_contacts (reset flag set by the host in every observed launch; history off by default).
        hardk.initialize(rc, shapes, cbodies, previous, previous, hard['penalty'], hard['dual'], hard['anchor'],
                         hard['prev_penalty'], hard['prev_dual'], hard['prev_normal'], int(hard['prev_count'][0]),
                         rc.get('match'), cfg.rigid_contact_alpha, cfg.rigid_contact_beta, cfg.rigid_contact_gamma,
                         cfg.rigid_contact_k_start, cfg.rigid_contact_history, True, n)
    x = x_hat.copy()
    drag_triangles = getattr(solver, 'drag_triangles', np.empty((0, 3), np.int32))
    if len(drag_triangles):
        # initialize_triangle_drag: normals and areas from the substep-start positions, once per substep.
        drag_normal, drag_area = drag.initialize(previous, drag_triangles)
    if fluid is not None:
        points = len(fluid['indices'])+len(fluid['boundary_positions'])
        fp = fluidk.Params(fluid['smoothing_radius'], fluid['bulk_modulus'], fluid['viscosity'], h,
                           len(fluid['indices']), points, len(fluid['indices']), fluidk.slot_count(points))
        # Fluid::limit_step: d_max = fluid_max_step_ratio * h_f in float32.
        max_step = F(solver.config.fluid_max_step_ratio)*fp.h
    for iteration in range(solver.config.nonlinear_iterations):
        rhs = pcg.initialize_rhs(inv_h2, x, x_hat, mass, external, mask, mass_ell)
        diagonal = base_diagonal.copy()
        if len(drag_triangles):
            drag_scalar = drag.evaluate(x, previous, drag_triangles, solver.drag_coefficients, drag_normal, drag_area,
                                        solver.config.air_density, solver.config.wind_velocity, inv_dt, rhs)
        rows = None
        if fluid is not None:
            # memset(head, -1), memset(D, 0), then the grid is rebuilt from the current iterate.
            grid = fluidk.build_grid(x, fluid['indices'], fluid['world'], mass, fluid['rest_density'],
                                     fluid['smoothing_radius'], fluid['boundary_positions'],
                                     fluid['boundary_volumes'], fp.slots)
            rows = fluidk.evaluate_rows(grid, fp)
            fluid_diagonal = np.zeros((n, 9), F)
            fluidk.accumulate_rows(grid, fp, *rows, previous, rhs, fluid_diagonal)
        granular_data = None
        if granular is not None:
            granular_diagonal, granular_data = granular.accumulate(x, previous, h, rhs)
        if rigid is not None and hard is not None:
            # evaluate_hard_contacts, force mode, in place of evaluate_contact_force.
            hardk.evaluate(rc, shapes, cbodies, x, previous, hard['penalty'], hard['dual'], hard['anchor'],
                           solver.config.rigid_contact_alpha, inv_dt, False, n, force=rhs, scalar=diagonal)
        elif rigid is not None:
            # evaluate_contact_force runs before the soft contacts: forces into rhs, scalars into the diagonal copy.
            rigidk.evaluate_contact_force(rc, shapes, cbodies, x, previous, None, inv_dt,
                                          solver.config.rigid_contact_friction_epsilon, rhs, diagonal)
        rolling = getattr(solver, 'rolling_contacts', None)
        if rolling is not None:
            inertia, rolling_eps = rolling
            rollingk.evaluate_rolling_contact_force(rc, shapes, cbodies, inertia, x, previous, inv_dt, rolling_eps, rhs)
        surface = getattr(solver, 'surface_contacts', None)
        if surface is not None:
            # evaluate_surface_contact_force (after the rolling contacts, before the particle soft contacts).
            surface.x = x
            surfacek.evaluate_surface_contact_force(surface, rhs)
        sc_mass = None
        if surface is not None and self_collision is not None:
            # The self-collision "mass" is copied from the scalar diagonal here, and add_surface_contact_stiffness_scale
            # adds w^2 (ke + kd/h) of every surface contact to it (launched only with self-collision).
            sc_mass = diagonal.copy()
            surfacek.add_surface_contact_stiffness_scale(surface, sc_mass)
        if contact_inputs is not None:
            contact_inputs.x = x
            # First launch: forces straight into rhs and isotropic scalars into the diagonal copy.
            soft_contact_kernel(contact_inputs, force=rhs, scalar=diagonal)
        if springs is not None:
            # evaluate_joint_body_spring_augmented_lagrangian_force (after the soft contacts, before SO(3)).
            if plain_springs:
                springs.plain_force(x, alpha, False, rhs)   # evaluate_body_spring_force (plain springs only)
        if distances is not None:
            # Between the plain spring and point-line forces in the trace; placed before the joint-spring AL force
            # (no trace yet with both kinds on shared bodies).
            distances.force(x, F(alpha*inv_h2), rhs)
        if springs is not None:
            springs.joint_force(x, F(alpha*inv_h2), rhs)
        if lines is not None:
            if plain_lines:
                lines.plain_force(x, alpha, False, rhs)     # evaluate_body_point_line_force (plain lines only)
            lines.joint_force(x, F(alpha*inv_h2), rhs)
        drives = getattr(solver, 'joint_drives', None)
        if drives is not None:
            ctrl = solver.drive_control
            jointk.evaluate_joint_drive_load(drives, x, previous, ctrl.drive_qd, solver.drive_angle,
                                             solver.drive_initialized, drives.ke, drives.kd, drives.effort,
                                             drives.modes, drives.damping, ctrl.joint_f, ctrl.target_q,
                                             ctrl.target_qd, inv_dt, rhs)
            if drives.armature is not None:
                jointk.evaluate_joint_armature(drives, drives.armature, x, previous, ctrl.drive_qd, inv_dt, force=rhs)
            if drives.limits is not None:
                jointk.evaluate_angular_limits(drives, x, previous, solver.drive_angle, solver.drive_initialized,
                                               *drives.limits, inv_dt, force=rhs)
        sc_diagonal, sc_records = None, None
        if self_collision is not None:
            # memcpy of the diagonal (inertia + constant stiffness + contact scalars) used as the self-collision
            # "mass", memset of the self-collision blocks and contact counter, then accumulate_* into rhs.
            sc_diagonal, sc_records = self_collision.accumulate(x, rhs, diagonal.copy() if sc_mass is None else sc_mass)
        if so3 and so3_alpha > 0:
            affinek.so3_force(x, bodies.indices, bodies.weight, bodies.rotation, bodies.multiplier, so3_alpha, rhs)
        elif constitutive:
            affinek.constitutive_force(x, bodies.indices, bodies.weight, so3_alpha, rigidity, rhs)
        elif six_springs:
            affinek.six_spring_force(x, bodies.indices, bodies.weight, so3_alpha, rhs)
        if len(solver.springs):
            springk.evaluate_spring_force(x, solver.springs, solver.spring_k, solver.spring_rest, rhs)
        if len(triangles):
            local = cloth.stretch_force_ptx(x, solver.tri_area, solver.tri_inverse, triangles, solver.tri_stiffness)
            element_atomic_add(rhs, triangles, local)
        if len(edges):
            local, valid = cloth.bending_force_ptx(x, previous, solver.native_edge_area, solver.native_edge_cots,
                                                   edges, solver.native_edge_properties, inv_dt)
            element_atomic_add(rhs, edges, local, valid)
        if len(tets):
            local = tetrahedron_force_ptx(x, previous, tets, solver.tet_inverse, solver.tet_volume,
                                          solver.tet_materials, solver.tet_activation, inv_dt)
            element_atomic_add(rhs, tets, local)
        system = pcg.initialize_block_diagonal(diagonal)
        ell = None
        if constant is not None and not pd:
            blocks = ell_template.copy()
            if len(triangles):
                gn = cloth.membrane_gn_blocks_ptx(x, triangles, solver.tri_inverse, solver.tri_area,
                                                  solver.tri_stiffness)
                cloth.scatter_membrane_gn(gn, triangles, system, row_nnz, (ell_cols, blocks), max_nnz, n)
            if len(solver.springs):
                springk.add_spring_hessian(x, solver.springs, solver.spring_k, solver.spring_rest, system,
                                           (row_nnz, ell_cols, blocks, max_nnz))
            if six_springs:
                # add_affine_body_spring_gauss_newton_hessian: first body Hessian after initialize_block_diagonal.
                affinek.six_spring_hessian(x, bodies.indices, bodies.weight, so3_alpha, system,
                                           (row_nnz, ell_cols, blocks, max_nnz))
            if plain_springs:
                springs.add_gauss_newton_hessian(x, system, (row_nnz, ell_cols, blocks, max_nnz))
            if plain_lines:
                lines.add_plain_hessian(x, alpha, False, system, (row_nnz, ell_cols, blocks, max_nnz))
            if lines is not None:
                # add_joint_body_point_line_gauss_newton_hessian after the ELL copy, before the diagonal copy.
                lines.add_hessian(F(alpha*inv_h2), system, (row_nnz, ell_cols, blocks, max_nnz))
            ell = (row_nnz, ell_cols, blocks, max_nnz)
        precond = system.copy()
        if rigid is not None and hard is not None:
            hardk.evaluate(rc, shapes, cbodies, x, previous, hard['penalty'], hard['dual'], hard['anchor'],
                           solver.config.rigid_contact_alpha, inv_dt, False, n, system=system, precond=precond)
        elif rigid is not None:
            # evaluate_contact_tangent, block mode: K - s_iso I into both the system and the preconditioner.
            rigidk.evaluate_contact_tangent(rc, shapes, cbodies, x, previous, None, inv_dt,
                                            solver.config.rigid_contact_friction_epsilon, system=system,
                                            precond=precond)
        if contact_inputs is not None:
            # Second launch: the 3x3 correction into both the system and the preconditioner diagonals.
            soft_contact_kernel(contact_inputs, block=system.reshape(-1, 3, 3))
            soft_contact_kernel(contact_inputs, block=precond.reshape(-1, 3, 3))
        if len(drag_triangles):
            drag.add_preconditioner(drag_triangles, drag_normal, drag_scalar, precond)
        if so3 and so3_alpha > 0:
            affinek.so3_preconditioner(bodies.indices, bodies.weight, bodies.rotation, so3_alpha, precond)
        elif constitutive:
            affinek.constitutive_preconditioner(x, bodies.indices, bodies.weight, so3_alpha, rigidity, precond)
        # Legacy order (traces with bodies): SO(3), bending damping, self-collision, surface, point-line AL (PD only),
        # drives, rolling; then fluid, granular, tetrahedra.
        if len(edges):
            local, valid = cloth.bending_damping_preconditioner_ptx(x, solver.native_edge_area, solver.native_edge_cots,
                                                                    edges, solver.native_edge_properties, inv_dt)
            element_atomic_add(precond, edges, local, valid)
        if sc_diagonal is not None:
            selfcollision.add_hessian_diagonal(sc_diagonal, precond)
        if surface is not None:
            surfacek.add_surface_contact_preconditioner(surface, precond)
        if pd and lines is not None:
            lines.add_preconditioner(F(alpha*inv_h2), precond)
        if drives is not None:
            jointk.add_joint_drive_preconditioner(drives, x, drives.kd, drives.damping, drives.modes, inv_dt, precond)
            if drives.armature is not None:
                jointk.evaluate_joint_armature(drives, drives.armature, x, previous, None, inv_dt, block=precond)
            if drives.limits is not None:
                jointk.evaluate_angular_limits(drives, x, previous, solver.drive_angle, solver.drive_initialized,
                                               *drives.limits, inv_dt, block=precond)
        if rolling is not None:
            rollingk.add_rolling_contact_preconditioner(rc, shapes, cbodies, inertia, x, previous, inv_dt, rolling_eps,
                                                        precond)
        if rows is not None:
            fluidk.add_diagonal(fluid_diagonal, precond)
        if granular_data is not None:
            fluidk.add_diagonal(granular_diagonal, precond)  # granular_kernel::add_diagonal is the same B += D
        if len(tets):
            blocks_t = tetrahedron_preconditioner_ptx(x, tets, solver.tet_inverse, solver.tet_materials,
                                                      solver.tet_volume, inv_dt)
            element_atomic_add(precond, tets, blocks_t.reshape(len(tets), 4, 9))
        inverse = pcg.invert_block_preconditioner(precond, mass, mask)
        iterations = solver.config.linear_iterations
        num = np.zeros(iterations+1, F)
        den = np.zeros(iterations, F)
        if pd:
            # PD_NEWTON: r = rhs (device copy), x = 0, and thrust transform-reductions over particles; the matrix keeps
            # the scalar ELL of combine_system_non_diagonal. Legacy PD cloth omits the membrane GN correction
            # from BOTH the block diagonal and the off-diagonal matrix; stretch/bending forces still run.
            if len(solver.springs):
                raise NotImplementedError('PD_NEWTON with cloth spring Hessians')
            residual, solution = rhs.astype(F).copy(), np.zeros_like(x)
            num[0] = pcg.cub_sum(pcg.dot(pcg.mat_vec(inverse, residual), residual))
            scalar_ell = None if constant is None else constant[1:]
        else:
            residual, solution, partials = pcg.initialize_zero_solution_and_reduce(rhs, inverse)
            num[0] = pcg.cub_sum(partials)
        direction = np.zeros_like(x)
        for k in range(iterations):
            direction = pcg.update_cg_direction(k, inverse, residual, num, direction)
            tangent = np.zeros_like(x)  # memset before every product
            if so3 and so3_alpha > 0:
                affinek.so3_tangent(direction, bodies.indices, bodies.weight, bodies.rotation, so3_alpha, tangent)
            elif constitutive:
                affinek.constitutive_tangent(x, direction, bodies.indices, bodies.weight, so3_alpha, rigidity, tangent)
            if len(edges):
                local, valid = cloth.bending_damping_tangent_ptx(x, direction, solver.native_edge_area,
                                                                 solver.native_edge_cots, edges,
                                                                 solver.native_edge_properties, inv_dt)
                element_atomic_add(tangent, edges, local, valid)
            if sc_records is not None:
                selfcollision.multiply_contact_tangents(sc_records, direction, tangent)
            if surface is not None:
                surfacek.multiply_surface_contact_tangent(surface, direction, tangent)
            if rigid is not None and hard is not None:
                hardk.evaluate(rc, shapes, cbodies, x, previous, hard['penalty'], hard['dual'], hard['anchor'],
                               solver.config.rigid_contact_alpha, inv_dt, False, n, direction=direction,
                               product=tangent)
            elif rigid is not None:
                rigidk.evaluate_contact_tangent(rc, shapes, cbodies, x, previous, None, inv_dt,
                                                solver.config.rigid_contact_friction_epsilon, direction=direction,
                                                product=tangent)
            if contact_inputs is not None and contact_inputs.body_ids is not None:
                # Particle <-> body coupling of the soft contacts (legacy order: after the rigid contact tangent).
                multiply_soft_contact_hessian_off_diagonal(contact_inputs, direction, tangent)
            if pd and lines is not None:
                lines.multiply_tangent(F(alpha*inv_h2), direction, tangent)  # matrix-free point-line AL term
            if drives is not None:
                jointk.multiply_joint_drive_tangent(drives, x, drives.kd, drives.damping, drives.modes, inv_dt,
                                                    direction, tangent)
                if drives.armature is not None:
                    jointk.evaluate_joint_armature(drives, drives.armature, x, previous, None, inv_dt,
                                                   direction=direction, force=tangent)
                if drives.limits is not None:
                    jointk.evaluate_angular_limits(drives, x, previous, solver.drive_angle, solver.drive_initialized,
                                                   *drives.limits, inv_dt, direction=direction, force=tangent)
            if rolling is not None:
                rollingk.multiply_rolling_contact_tangent(rc, shapes, cbodies, inertia, x, previous, inv_dt,
                                                          rolling_eps, direction, tangent)
            if rows is not None:
                grad, _, weight, count, cache_ids, cache = rows
                fluidk.multiply_rows(grid, fp, grad, weight, count, cache_ids, cache, direction, tangent)
            if granular_data is not None:
                granular.multiply(granular_data, direction, tangent)
            if len(drag_triangles):
                drag.multiply_tangent(direction, drag_triangles, drag_normal, drag_scalar, tangent)
            if len(tets):
                local = tetrahedron_tangent_ptx(x, direction, tets, solver.tet_inverse, solver.tet_materials,
                                                solver.tet_volume, inv_dt)
                element_atomic_add(tangent, tets, local)
            if pd:
                product = pcg.multiply_matrix(system, direction, tangent, scalar_ell)
                den[k] = pcg.cub_sum(pcg.dot(direction, product))
                solution, residual = pcg.update_solution_and_residual(k, num, den, direction, product, solution,
                                                                      residual)
                num[k+1] = pcg.cub_sum(pcg.dot(pcg.mat_vec(inverse, residual), residual))
                continue
            product, partials = pcg.multiply_matrix_and_reduce(system, direction, tangent, ell)
            den[k] = pcg.cub_sum(partials)
            solution, residual, partials = pcg.update_solution_residual_and_reduce(
                k, num, den, direction, product, inverse, solution, residual)
            num[k+1] = pcg.cub_sum(partials)
        if rows is not None:
            scale = fluidk.limit_step(grid, fp, solution, solver.config.fluid_relaxation, max_step)
            solution = fluidk.scale_step(solution, scale, fluid['world'])
        x = (x+solution).astype(F)
        if rigid is not None and hard is not None:
            # update_hard_contact_duals after every apply_nonlinear_step.
            hardk.update_duals(rc, shapes, cbodies, x, previous, hard['penalty'], hard['dual'], hard['anchor'],
                               solver.config.rigid_contact_alpha, solver.config.rigid_contact_beta, n)
        if distances is not None:
            distances.update_state(x)   # update_body_distance_constraint_state after every iteration, before SO(3)
        if so3 and so3_alpha > 0:
            # SolverNewton::step: after iteration c (from 1) the multiplier is updated only when
            # c == affine_body_rigidity_primal_iterations and c is not the last iteration.
            count = iteration+1
            flag = count < solver.config.nonlinear_iterations and \
                count == solver.config.affine_body_rigidity_primal_iterations
            affinek.update_so3_state(x, bodies.indices, bodies.rotation, bodies.multiplier, flag)
        # SolverNewton::step advances the joint multipliers only after iterations whose count (from 1) is a multiple of
        # joint_constraint_primal_iterations, and never after the last one. Springs skip the kernel entirely; the
        # point-line kernel still runs (it refreshes its projection) with the multiplier flag cleared.
        count = iteration+1
        joint_dual = count < solver.config.nonlinear_iterations and \
            count % solver.config.joint_constraint_primal_iterations == 0
        if springs is not None and joint_dual:
            springs.update_state(x)
        if lines is not None:
            lines.update_state(x, joint_dual)
    if hard is not None:
        # snapshot_hard_contacts after the last iteration (history for the next step).
        hardk.snapshot(rc['count'] if rigid is not None else 0, len(hard['penalty']), hard['penalty'], hard['dual'],
                       rc['normal'] if rigid is not None else np.zeros((0, 3), F), hard['prev_penalty'],
                       hard['prev_dual'], hard['prev_normal'], hard['prev_count'])
    return x
