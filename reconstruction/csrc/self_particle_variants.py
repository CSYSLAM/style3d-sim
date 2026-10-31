"""Independent PP host boundary fixture; the first captured self_particle_scene stays immutable."""
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
        parser.add_argument('--seed', type=int, default=1)
        parser.add_argument('--count', type=int, default=8)
        parser.add_argument('--mode', choices=('newton', 'pd'), default='newton')
        parser.add_argument('--diagonal-only', action='store_true')
        parser.add_argument('--subset', action='store_true')
        parser.add_argument('--vary', action='store_true')
        parser.add_argument('--scale', type=float, default=1.)
        parser.add_argument('--switch', choices=('none', 'hessian', 'enabled', 'stiffness'), default='none')
        return parser

    def __init__(self, viewer, args):
        assert args.count > 0 and args.worlds > 0
        rng = np.random.default_rng(args.seed)
        indices = np.arange(args.count)
        points = np.zeros((args.count, 3), dtype='f4')
        points[:, 0] = indices//2*.18 + indices % 2*.04
        points[:, 1:] = [.2, .5]
        velocities = rng.uniform(-.025, .025, points.shape).astype('f4')
        masses = rng.uniform(.7, 2.3, args.count).astype('f4') if args.vary else np.full(args.count, 1.5, dtype='f4')
        radii = rng.uniform(.024, .029, args.count).astype('f4') if args.vary else np.full(args.count, .025, dtype='f4')
        if args.subset:
            masses[::4] = 0.
        template = newton.ModelBuilder(gravity=(.125, -.25, -9.81))
        template.add_particles(pos=points, vel=velocities, mass=masses, radius=radii)
        builder = newton.ModelBuilder(gravity=(.125, -.25, -9.81)) if args.worlds > 1 else template
        if args.worlds > 1:
            builder.replicate(template, args.worlds)
        self.model = builder.finalize(device='cuda:0')
        self.solver = s3d.NewtonSolver(self.model)
        config = self.solver.config
        config.enable_self_collision = True
        config.self_collision_radius = .003
        config.self_collision_particle_particle_stiffness = args.scale
        config.enable_collision_hessian_non_diagonal = not args.diagonal_only
        config.nonlinear_solver = s3d.NonlinearSolver.PD_NEWTON if args.mode == 'pd' else s3d.NonlinearSolver.NEWTON
        config.nonlinear_iterations, config.linear_iterations = 3, 5
        self.state_0, self.state_1 = self.model.state(), self.model.state()
        self.control = self.model.control()
        self.args, self.steps = args, 0

    def configure(self):
        config = self.solver.config
        if self.args.switch == 'hessian':
            config.enable_collision_hessian_non_diagonal = self.steps % 2 == 0
        elif self.args.switch == 'enabled':
            config.enable_self_collision = self.steps % 2 == 0
        elif self.args.switch == 'stiffness':
            config.self_collision_particle_particle_stiffness = (1., 0., -1., float('nan'))[self.steps % 4]

    def step(self):
        self.configure()
        self.state_0.clear_forces()
        self.solver.step(self.state_0, self.state_1, self.control, None, 1/240)
        self.state_0, self.state_1 = self.state_1, self.state_0
        self.steps += 1
