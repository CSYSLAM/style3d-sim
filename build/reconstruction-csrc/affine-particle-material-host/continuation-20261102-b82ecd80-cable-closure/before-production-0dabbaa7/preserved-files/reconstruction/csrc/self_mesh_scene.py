"""Isolated real mesh self-collision host probes, without membrane or bending material forces."""
import newton
import newton.examples
import numpy as np
import style3d_sim as s3d
import warp as wp


class Example:
    @staticmethod
    def create_parser():
        parser = newton.examples.create_parser()
        parser.add_argument('--kind', choices=('particle-face', 'vertex-face', 'edge-edge', 'edge-face'),
                            default='particle-face')
        parser.add_argument('--worlds', type=int, default=1)
        parser.add_argument('--seed', type=int, default=1)
        parser.add_argument('--mode', choices=('newton', 'pd'), default='newton')
        parser.add_argument('--diagonal-only', action='store_true')
        return parser

    def __init__(self, viewer, args):
        triangles, edges = [], []
        if args.kind == 'particle-face':
            points = [[-.05, -.05, .5], [.05, -.05, .5], [0, .05, .5], [0, 0, .504]]
            triangles = [(0, 1, 2)]
        elif args.kind == 'vertex-face':
            points = [[-.05, -.05, .5], [.05, -.05, .5], [0, .05, .5],
                      [-.01, -.01, .504], [.01, -.01, .504], [0, .01, .504]]
            triangles = [(0, 1, 2), (3, 4, 5)]
        elif args.kind == 'edge-edge':
            points = [[-.05, 0, .5], [.05, 0, .5], [0, -.05, .504], [0, .05, .504]]
            edges = [(-1, -1, 0, 1), (-1, -1, 2, 3)]
        else:
            points = [[-.05, -.05, .5], [.05, -.05, .5], [0, .05, .5],
                      [.03, 0, .5], [.02, .01, .5], [0, 0, .48], [0, 0, .52]]
            triangles, edges = [(0, 1, 2)], [(3, 4, 5, 6)]
        rng = np.random.default_rng(args.seed)
        template = newton.ModelBuilder(gravity=(.125, -.25, -9.81))
        template.add_particles(pos=[wp.vec3(*point) for point in points],
                               vel=rng.uniform(-.005, .005, (len(points), 3)).astype('f4'),
                               mass=np.full(len(points), 1.5), radius=np.full(len(points), .006))
        for tri in triangles:
            template.add_triangle(*tri, tri_ke=0., tri_ka=0., tri_kd=0.)
        for edge in edges:
            template.add_edge(*edge, rest=0., edge_ke=0., edge_kd=0.)
        builder = newton.ModelBuilder(gravity=(.125, -.25, -9.81)) if args.worlds > 1 else template
        if args.worlds > 1:
            builder.replicate(template, args.worlds)
        self.model = builder.finalize(device='cuda:0')
        self.solver = s3d.NewtonSolver(self.model)
        config = self.solver.config
        config.enable_self_collision = True
        config.self_collision_radius = .003
        config.self_collision_vertex_face_stiffness = .5 if args.kind in ('particle-face', 'vertex-face') else 0.
        config.self_collision_edge_edge_stiffness = .1 if args.kind == 'edge-edge' else 0.
        config.self_collision_edge_face_stiffness = 1. if args.kind == 'edge-face' else 0.
        config.self_collision_particle_particle_stiffness = 0.
        config.enable_collision_hessian_non_diagonal = not args.diagonal_only
        config.nonlinear_solver = s3d.NonlinearSolver.PD_NEWTON if args.mode == 'pd' else s3d.NonlinearSolver.NEWTON
        config.nonlinear_iterations, config.linear_iterations = 3, 5
        self.state_0, self.state_1 = self.model.state(), self.model.state()
        self.control = self.model.control()

    def step(self):
        self.state_0.clear_forces()
        self.solver.step(self.state_0, self.state_1, self.control, None, 1/240)
        self.state_0, self.state_1 = self.state_1, self.state_0
