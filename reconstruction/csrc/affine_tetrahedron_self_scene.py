"""SO3 body sharing PCG worlds with an elastic tetrahedron and nonempty mesh/particle self contact."""
import newton
import newton.examples
import numpy as np
import style3d_sim as s3d
import warp as wp


class Example:
    @staticmethod
    def create_parser():
        parser = newton.examples.create_parser()
        parser.add_argument('--material', choices=('tet',), default='tet')
        parser.add_argument('--worlds', type=int, default=1)
        parser.add_argument('--seed', type=int, default=1)
        parser.add_argument('--mode', choices=('newton', 'pd'), default='newton')
        parser.add_argument('--diagonal-only', action='store_true')
        parser.add_argument('--body-block', action='store_true')
        return parser

    def __init__(self, viewer, args):
        points = [[-.05, -.05, .5], [.05, -.05, .5], [0, .05, .5],
                  [-.01, -.01, .504], [.01, -.01, .504], [0, .01, .504],
                  [.95, 0, .5], [1.05, 0, .5], [1, -.05, .504], [1, .05, .504],
                  [1.95, -.05, .5], [2.05, -.05, .5], [2, .05, .5],
                  [2.03, 0, .5], [2.02, .01, .5], [2, 0, .48], [2, 0, .52],
                  [3, 0, .5], [3.01, 0, .5], [0, 0, .504]]
        rng = np.random.default_rng(args.seed)
        template = newton.ModelBuilder(gravity=(.125, -.25, -9.81))
        newton.solvers.SolverStyle3D.register_custom_attributes(template)
        body = template.add_body(xform=wp.transform(wp.vec3(4.5, 0., 1.5), wp.quat_rpy(.25, -.15, .3)), mass=0.)
        template.add_shape_box(body, hx=.025, hy=.03, hz=.035,
                               cfg=newton.ModelBuilder.ShapeConfig(density=750., mu_rolling=0., mu_torsional=0.))
        template.body_qd[-1] = (.1, -.05, -.4, .2, .1, -.1)
        template.add_particles(pos=[wp.vec3(*p) for p in points],
                               vel=rng.uniform(-.005, .005, (len(points), 3)).astype('f4'),
                               mass=np.full(len(points), 1.5), radius=np.full(len(points), .006))
        for tri in ((0, 1, 2), (3, 4, 5), (10, 11, 12)):
            template.add_triangle(*tri, tri_ke=0., tri_ka=0., tri_kd=0.,
                                  tri_drag=0., tri_lift=0.)
        for edge in ((-1, -1, 6, 7), (-1, -1, 8, 9), (13, 14, 15, 16)):
            template.add_edge(*edge, rest=0., edge_ke=0., edge_kd=0.)
        volume = template.add_tetrahedron(10, 12, 11, 15, k_mu=113.75, k_lambda=257.125, k_damp=.625)
        assert volume > 0.
        template.particle_q[15] = wp.vec3(2.002, -.001, .477)
        builder = template
        if args.worlds > 1:
            builder = newton.ModelBuilder(gravity=(.125, -.25, -9.81))
            newton.solvers.SolverStyle3D.register_custom_attributes(builder)
            builder.replicate(template, args.worlds)
        self.model = builder.finalize(device='cuda:0')
        self.solver = s3d.NewtonSolver(self.model)
        config = self.solver.config
        config.enable_self_collision = True
        config.self_collision_radius = .003
        config.self_collision_vertex_face_stiffness = .5
        config.self_collision_edge_edge_stiffness = .1
        config.self_collision_edge_face_stiffness = 1.
        config.self_collision_particle_particle_stiffness = .25
        config.enable_collision_hessian_non_diagonal = not args.diagonal_only
        config.affine_body_block_preconditioner = args.body_block
        config.nonlinear_solver = s3d.NonlinearSolver.PD_NEWTON if args.mode == 'pd' else s3d.NonlinearSolver.NEWTON
        config.nonlinear_iterations, config.linear_iterations = 3, 5
        config.air_density = 0.
        self.state_0, self.state_1 = self.model.state(), self.model.state()
        self.control = self.model.control()

    def step(self):
        self.state_0.clear_forces()
        self.solver.step(self.state_0, self.state_1, self.control, None, 1/240)
        self.state_0, self.state_1 = self.state_1, self.state_0
