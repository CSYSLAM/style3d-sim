"""Small real particle-pair self-collision scenes; no mesh topology or external assets."""
import newton
import newton.examples
import numpy as np
import warp as wp

import style3d_sim as s3d


class Example:
    @staticmethod
    def create_parser():
        parser = newton.examples.create_parser()
        parser.add_argument('--worlds', type=int, default=1)
        parser.add_argument('--seed', type=int, default=1)
        parser.add_argument('--count', type=int, default=8)
        parser.add_argument('--mode', choices=('newton', 'pd'), default='newton')
        parser.add_argument('--far', action='store_true')
        parser.add_argument('--empty', action='store_true')
        parser.add_argument('--diagonal-only', action='store_true')
        return parser

    def __init__(self, viewer, args):
        assert args.count > 0 and args.worlds > 0
        rng = np.random.default_rng(args.seed)
        points = np.zeros((args.count, 3), dtype='f4')
        points[:, 0] = np.arange(args.count)//2*.18 + (np.arange(args.count) % 2)*(.08 if args.far else .04)
        points[:, 1:] = [.2, .5]
        velocities = rng.uniform(-.025, .025, points.shape).astype('f4')
        template = newton.ModelBuilder(gravity=(.125, -.25, -9.81))
        template.add_particles(pos=points, vel=velocities,
                               mass=np.full(args.count, 0. if args.empty else 1.5),
                               radius=np.full(args.count, .025))
        builder = newton.ModelBuilder(gravity=(.125, -.25, -9.81)) if args.worlds > 1 else template
        if args.worlds > 1:
            builder.replicate(template, args.worlds)
        self.model = builder.finalize(device='cuda:0')
        self.solver = s3d.NewtonSolver(self.model)
        config = self.solver.config
        config.enable_self_collision = True
        config.self_collision_radius = .003
        config.self_collision_particle_particle_stiffness = 1.
        config.enable_collision_hessian_non_diagonal = not args.diagonal_only
        config.nonlinear_solver = s3d.NonlinearSolver.PD_NEWTON if args.mode == 'pd' else s3d.NonlinearSolver.NEWTON
        config.nonlinear_iterations, config.linear_iterations = 3, 5
        self.state_0, self.state_1 = self.model.state(), self.model.state()
        self.control = self.model.control()

    def step(self):
        self.state_0.clear_forces()
        self.solver.step(self.state_0, self.state_1, self.control, None, 1/240)
        self.state_0, self.state_1 = self.state_1, self.state_0
