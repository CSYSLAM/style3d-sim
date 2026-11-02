"""Supplementary driven articulation plus strained cloth, including the SIX_SPRINGS branch used by trampoline."""
import newton
import newton.examples
from newton.solvers import style3d
import numpy as np
import style3d_sim as s3d
import warp as wp


class Example:
    @staticmethod
    def create_parser():
        parser = newton.examples.create_parser()
        parser.add_argument('--rigidity', choices=('so3', 'six-springs'), required=True)
        parser.add_argument('--worlds', type=int, default=1)
        parser.add_argument('--seed', type=int, default=1)
        parser.add_argument('--mode', choices=('newton', 'pd'), default='newton')
        parser.add_argument('--body-block', action='store_true')
        return parser

    def __init__(self, viewer, args):
        rng = np.random.default_rng(args.seed)
        template = newton.ModelBuilder(gravity=(.15, -.23, -9.81), up_axis=newton.Axis.Z)
        newton.solvers.SolverStyle3D.register_custom_attributes(template)
        cfg = template.default_shape_cfg.copy()
        cfg.density = 350.
        cfg.has_shape_collision = cfg.has_particle_collision = False
        parent = template.add_link(xform=wp.transform(wp.vec3(.2, -.1, 1.5), wp.quat_rpy(.2, -.1, .3)))
        child = template.add_link()
        for body in (parent, child):
            template.add_shape_box(body, hx=.17, hy=.09, hz=.13, cfg=cfg,
                                   xform=wp.transform(wp.vec3(*rng.uniform(-.08, .08, 3)), wp.quat_identity()))
        free = template.add_joint_free(child=parent)
        axis = wp.normalize(wp.vec3(*rng.uniform(.2, 1., 3)))
        joint = template.add_joint_revolute(
            parent=parent, child=child, axis=axis,
            parent_xform=wp.transform(wp.vec3(.12, -.06, .1), wp.quat_rpy(.1, .2, -.15)),
            child_xform=wp.transform(wp.vec3(-.11, .04, -.08), wp.quat_rpy(-.2, .1, .05)),
            target_pos=.08, target_vel=-.12, target_ke=35., target_kd=1.7, damping=.23,
            limit_lower=-.15, limit_upper=.14, limit_ke=80., limit_kd=.7, effort_limit=2.5, armature=0.)
        template.add_articulation([free, joint])
        template.joint_q[-1], template.joint_qd[-1] = .32, .47
        template.joint_qd[:6] = [.1, -.05, -.4, .2, .1, -.1]
        points = np.asarray([[-.05, -.05, .8], [.05, -.05, .8], [.05, .05, .805], [-.05, .05, .8]], dtype='f4')
        style3d.add_cloth_mesh(
            template, pos=wp.vec3(0.), rot=wp.quat_identity(), vel=wp.vec3(0.), vertices=points,
            indices=[0, 1, 2, 0, 2, 3], density=80., particle_radius=.006,
            tri_aniso_ke=wp.vec3(37.5, 53.75, 11.25), tri_ka=0., tri_kd=0.,
            edge_aniso_ke=wp.vec3(2.5), edge_kd=.03, tri_drag=0., tri_lift=0.)
        template.particle_flags[0] &= ~newton.ParticleFlags.ACTIVE
        template.particle_mass[0] = 0.
        template.particle_qd = [wp.vec3(*v) for v in rng.uniform(-.005, .005, (4, 3))]
        builder = template
        if args.worlds > 1:
            builder = newton.ModelBuilder(gravity=(.15, -.23, -9.81), up_axis=newton.Axis.Z)
            newton.solvers.SolverStyle3D.register_custom_attributes(builder)
            builder.replicate(template, args.worlds)
        self.model = builder.finalize(device='cuda:0')
        self.solver = s3d.NewtonSolver(self.model)
        native = self.solver._synreal_model
        assert native.particle_state_count == 12 * args.worlds
        copies = native.particle_state_count // native.particle_count
        assert native.triangle_count * copies == 2 * args.worlds
        assert native.joint_drive_count * copies == args.worlds and native.joint_body_spring_count > 0
        self.solver.config.affine_body_rigidity_model = (
            s3d.AffineBodyRigidityModel.SIX_SPRINGS if args.rigidity == 'six-springs' else
            s3d.AffineBodyRigidityModel.SO3_AUGMENTED_LAGRANGIAN)
        self.solver.config.nonlinear_solver = (
            s3d.NonlinearSolver.PD_NEWTON if args.mode == 'pd' else s3d.NonlinearSolver.NEWTON)
        self.solver.config.affine_body_block_preconditioner = args.body_block
        self.solver.config.nonlinear_iterations, self.solver.config.linear_iterations = 3, 5
        self.solver.config.joint_constraint_primal_iterations = 2
        self.state_0, self.state_1 = self.model.state(), self.model.state()
        self.control = self.model.control()
        newton.eval_fk(self.model, self.model.joint_q, self.model.joint_qd, self.state_0)
        # Prestrain only the public free-cloth vertices; model rest geometry and affine proxies stay intact.
        proxies = set(self.solver._affine_body_indices.numpy().ravel().tolist())
        free_particles = [i for i in range(self.model.particle_count) if i not in proxies]
        assert len(free_particles) == 4 * args.worlds
        positions = self.state_0.particle_q.numpy()
        for vertex in free_particles[2::4]:
            positions[vertex] += np.asarray([.013, -.007, .009], dtype='f4')
        self.state_0.particle_q.assign(positions)

    def step(self):
        self.state_0.clear_forces()
        self.solver.step(self.state_0, self.state_1, self.control, None, 1 / 240)
        self.state_0, self.state_1 = self.state_1, self.state_0
