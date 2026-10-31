"""Small Style3D material/self-collision combinations, using the official cloth builder without assets."""
import newton
import newton.examples
import numpy as np
from newton.solvers import style3d
import style3d_sim as s3d
import warp as wp


class Example:
    @staticmethod
    def create_parser():
        parser = newton.examples.create_parser()
        parser.add_argument('--worlds', type=int, default=1)
        parser.add_argument('--seed', type=int, default=1)
        parser.add_argument('--mode', choices=('newton', 'pd'), default='newton')
        parser.add_argument('--hinges', action='store_true')
        parser.add_argument('--contacts', action='store_true')
        parser.add_argument('--pinned', action='store_true')
        parser.add_argument('--free', action='store_true')
        parser.add_argument('--diagonal-only', action='store_true')
        return parser

    def __init__(self, viewer, args):
        if args.hinges:
            points = [[-.05, -.05, .5], [.05, -.05, .5], [.05, .05, .5], [-.05, .05, .5],
                      [-.018, -.022, .504], [.022, -.022, .504], [.022, .018, .504], [-.018, .018, .504]]
            triangles = [[0, 1, 2], [0, 2, 3], [4, 5, 6], [4, 6, 7]]
        else:
            points = [[-.05, -.05, .5], [.05, -.05, .5], [0, .05, .5],
                      [-.01, -.01, .504], [.01, -.01, .504], [0, .01, .504]]
            triangles = [[0, 1, 2], [3, 4, 5]]
        if args.contacts:
            for point in points:
                point[2] -= .498
        template = newton.ModelBuilder(gravity=(.125, -.25, -9.81), up_axis=newton.Axis.Z)
        newton.solvers.SolverStyle3D.register_custom_attributes(template)
        style3d.add_cloth_mesh(template, pos=wp.vec3(0.), rot=wp.quat_identity(), vel=wp.vec3(0.),
                              vertices=points, indices=np.asarray(triangles).ravel().tolist(), density=80.,
                              particle_radius=.003, tri_aniso_ke=wp.vec3(37.5, 53.75, 11.25), tri_ka=0., tri_kd=0.,
                              edge_aniso_ke=wp.vec3(3.25 if args.hinges else 0.), edge_kd=.03 if args.hinges else 0.)
        if args.free:
            template.add_particles(pos=[wp.vec3(.3, 0., .5), wp.vec3(.31, 0., .5)],
                                   vel=[wp.vec3(0.), wp.vec3(0.)], mass=[1.5, 1.5], radius=[.006, .006])
        rng = np.random.default_rng(args.seed)
        template.particle_qd = [wp.vec3(*v) for v in rng.uniform(-.005, .005, (len(template.particle_q), 3))]
        if args.pinned:
            template.particle_flags[0] &= ~int(newton.ParticleFlags.ACTIVE)
        if args.contacts:
            template.add_ground_plane()
        builder = template
        if args.worlds > 1:
            builder = newton.ModelBuilder(gravity=(.125, -.25, -9.81), up_axis=newton.Axis.Z)
            newton.solvers.SolverStyle3D.register_custom_attributes(builder)
            builder.replicate(template, args.worlds)
        self.model = builder.finalize(device='cuda:0')
        self.solver = s3d.NewtonSolver(self.model)
        config = self.solver.config
        config.enable_self_collision = True
        config.self_collision_radius = .003
        config.enable_collision_hessian_non_diagonal = not args.diagonal_only
        config.nonlinear_solver = s3d.NonlinearSolver.PD_NEWTON if args.mode == 'pd' else s3d.NonlinearSolver.NEWTON
        config.nonlinear_iterations, config.linear_iterations = 3, 5
        self.state_0, self.state_1 = self.model.state(), self.model.state()
        self.control = self.model.control()
        self.pipeline = newton.CollisionPipeline(self.model) if args.contacts else None
        self.contacts = self.pipeline.contacts() if self.pipeline else None

    def step(self):
        self.state_0.clear_forces()
        if self.pipeline:
            self.pipeline.collide(self.state_0, self.contacts)
        self.solver.step(self.state_0, self.state_1, self.control, self.contacts, 1/240)
        self.state_0, self.state_1 = self.state_1, self.state_0
