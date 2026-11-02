"""A damped, deformed tetrahedron exchanging full-surface contact forces with a moving SO3 box."""
import newton
import newton.examples
import numpy as np
import style3d_sim as s3d
import warp as wp


class Example:
    @staticmethod
    def create_parser():
        parser = newton.examples.create_parser()
        parser.add_argument('--worlds', type=int, default=1)
        parser.add_argument('--mode', choices=('newton', 'pd'), default='newton')
        parser.add_argument('--body-block', action='store_true')
        parser.add_argument('--diagonal-only', action='store_true')
        return parser

    def __init__(self, viewer, args):
        template = newton.ModelBuilder(gravity=(.125, -.25, -9.81), up_axis=newton.Axis.Z)
        newton.solvers.SolverStyle3D.register_custom_attributes(template)
        body = template.add_body(xform=wp.transform(wp.vec3(.025, .225, .679), wp.quat_identity()), mass=0.)
        template.add_shape_box(body, hx=.025, hy=.025, hz=.025,
                               cfg=newton.ModelBuilder.ShapeConfig(density=750., mu_rolling=0., mu_torsional=0.))
        template.body_qd[-1] = (.1, -.05, -.4, .2, .1, -.1)
        template.add_soft_mesh(pos=wp.vec3(0., .2, .7), rot=wp.quat_identity(), scale=1., vel=wp.vec3(0.),
                               vertices=[[0., 0., 0.], [.12, 0., 0.], [0., .1, 0.], [0., 0., .09]],
                               indices=[0, 1, 2, 3], density=90., k_mu=157.25, k_lambda=83.75, k_damp=.06,
                               particle_radius=.004, validate_mesh=True)
        template.particle_q[3] = wp.vec3(.013, .194, .812)
        template.particle_qd = [wp.vec3(*v) for v in np.random.default_rng(23).uniform(-.02, .02, (4, 3))]
        builder = template
        if args.worlds > 1:
            builder = newton.ModelBuilder(gravity=(.125, -.25, -9.81), up_axis=newton.Axis.Z)
            newton.solvers.SolverStyle3D.register_custom_attributes(builder)
            builder.replicate(template, args.worlds)
        self.model = builder.finalize(device='cuda:0')
        self.solver = s3d.NewtonSolver(self.model)
        config = self.solver.config
        config.enable_self_collision = False
        config.affine_body_block_preconditioner = args.body_block
        config.enable_collision_hessian_non_diagonal = not args.diagonal_only
        config.nonlinear_solver = s3d.NonlinearSolver.PD_NEWTON if args.mode == 'pd' else s3d.NonlinearSolver.NEWTON
        config.nonlinear_iterations, config.linear_iterations = 3, 5
        self.state_0, self.state_1 = self.model.state(), self.model.state()
        self.control = self.model.control()
        self.pipeline = newton.CollisionPipeline(self.model, enable_rigid_soft_full_surface_contact=True)
        self.contacts = self.pipeline.contacts()

    def step(self):
        self.state_0.clear_forces()
        self.pipeline.collide(self.state_0, self.contacts)
        self.solver.step(self.state_0, self.state_1, self.control, self.contacts, 1 / 240)
        self.state_0, self.state_1 = self.state_1, self.state_0
