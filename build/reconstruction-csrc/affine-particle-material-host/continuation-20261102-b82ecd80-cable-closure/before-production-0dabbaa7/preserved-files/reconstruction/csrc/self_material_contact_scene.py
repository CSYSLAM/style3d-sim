"""All material/self channels plus actual ground contacts, with nonzero membrane and hinge coefficients."""
import newton
import newton.examples
import numpy as np
import style3d_sim as s3d
import warp as wp


class Example:
    @staticmethod
    def create_parser():
        parser = newton.examples.create_parser()
        parser.add_argument('--material', choices=('spring', 'tet', 'drag', 'all'), required=True)
        parser.add_argument('--worlds', type=int, default=1)
        parser.add_argument('--seed', type=int, default=1)
        parser.add_argument('--mode', choices=('newton', 'pd'), default='newton')
        parser.add_argument('--diagonal-only', action='store_true')
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
        template.add_particles(pos=[wp.vec3(*p) for p in points],
                               vel=rng.uniform(-.005, .005, (len(points), 3)).astype('f4'),
                               mass=np.full(len(points), 1.5), radius=np.full(len(points), .006))
        aerodynamic = args.material in ('drag', 'all')
        for tri in ((0, 1, 2), (3, 4, 5), (10, 11, 12)):
            template.add_triangle(*tri, tri_ke=37.5, tri_ka=11.25, tri_kd=0.,
                                  tri_drag=.875 if aerodynamic else 0., tri_lift=0.)
        for edge in ((-1, -1, 6, 7), (-1, -1, 8, 9), (13, 14, 15, 16)):
            template.add_edge(*edge, rest=0., edge_ke=2.5, edge_kd=.03)
        if args.material in ('spring', 'all'):
            template.add_spring(0, 1, ke=43.125, kd=0., control=0.)
            template.spring_rest_length[-1] *= .8
        if args.material in ('tet', 'all'):
            volume = template.add_tetrahedron(10, 12, 11, 15, k_mu=113.75, k_lambda=257.125, k_damp=.625)
            assert volume > 0.
        template.add_ground_plane(height=.5)
        builder = template
        if args.worlds > 1:
            builder = newton.ModelBuilder(gravity=(.125, -.25, -9.81))
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
        config.nonlinear_solver = s3d.NonlinearSolver.PD_NEWTON if args.mode == 'pd' else s3d.NonlinearSolver.NEWTON
        config.nonlinear_iterations, config.linear_iterations = 3, 5
        config.air_density = 1.225 if aerodynamic else 0.
        config.wind_velocity = (.35, -.25, 1.5)
        self.state_0, self.state_1 = self.model.state(), self.model.state()
        self.control = self.model.control()
        self.pipeline = newton.CollisionPipeline(self.model)
        self.contacts = self.pipeline.contacts()

    def step(self):
        self.state_0.clear_forces()
        self.pipeline.collide(self.state_0, self.contacts)
        self.solver.step(self.state_0, self.state_1, self.control, self.contacts, 1/240)
        self.state_0, self.state_1 = self.state_1, self.state_0
