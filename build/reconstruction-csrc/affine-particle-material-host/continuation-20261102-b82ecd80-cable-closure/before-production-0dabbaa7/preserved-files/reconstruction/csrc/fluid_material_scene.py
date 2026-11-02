"""Disjoint fluid/tetrahedron/cloth particles to exercise host force and preconditioner ordering."""
import itertools

import newton
import newton.examples
import numpy as np
import warp as wp

import style3d_sim as s3d


class Example:
    @staticmethod
    def create_parser():
        parser = newton.examples.create_parser()
        parser.add_argument('--mode', choices=('newton', 'pd'), default='newton')
        parser.add_argument('--material', choices=('tet', 'bending', 'all'), default='all')
        parser.add_argument('--worlds', type=int, default=1)
        parser.add_argument('--seed', type=int, default=1)
        return parser

    def __init__(self, viewer, args):
        rng = np.random.default_rng(args.seed)
        positions = np.asarray(list(itertools.product((.2, .245), repeat=3)), dtype='f4')
        positions = np.concatenate((positions, positions + np.asarray([.09, 0., 0.], dtype='f4')))
        velocities = rng.uniform(-.04, .04, positions.shape).astype('f4')
        template = newton.ModelBuilder(gravity=(.125, -.25, -9.81))
        if args.material in ('bending', 'all'):
            newton.solvers.SolverStyle3D.register_custom_attributes(template)
        template.add_particles(pos=[wp.vec3(*value) for value in positions],
                               vel=[wp.vec3(*value) for value in velocities],
                               mass=np.full(16, .45), radius=np.full(16, .015))
        if args.material in ('tet', 'all'):
            template.add_tetrahedron(8, 12, 10, 9, k_mu=800., k_lambda=1200., k_damp=.02)
        if args.material in ('bending', 'all'):
            from newton.solvers import style3d
            style3d.add_cloth_mesh(template, pos=wp.vec3(0), rot=wp.quat_identity(), vel=wp.vec3(0),
                                  vertices=positions[[8, 12, 10, 14]].tolist(), indices=[0, 1, 2, 3, 2, 1],
                                  density=225., tri_aniso_ke=wp.vec3(300., 400., 150.),
                                  edge_aniso_ke=wp.vec3(.2, .1, .3), edge_kd=.01,
                                  tri_drag=0., tri_lift=0., particle_radius=.015)
        template.add_shape_plane(xform=wp.transform(wp.vec3(0., 0., .18), wp.quat_identity()),
                                 cfg=newton.ModelBuilder.ShapeConfig(ke=1500., kd=5.))
        if args.worlds > 1:
            builder = newton.ModelBuilder(gravity=(.125, -.25, -9.81))
            builder.replicate(template, args.worlds)
        else:
            builder = template
        self.model = builder.finalize(device='cuda:0')
        boundaries = np.asarray([[x, y, .17] for x, y in itertools.product((.19, .24), repeat=2)], dtype='f4')
        local_particles = len(template.particle_q)
        indices = np.concatenate([np.arange(8, dtype='i4') + world*local_particles for world in range(args.worlds)])
        s3d.configure_fluid(self.model, indices, smoothing_radius=.13,
                            bulk_modulus=1200., viscosity=.02, boundary_positions=boundaries,
                            boundary_volumes=np.full(4, .0003))
        self.solver = s3d.NewtonSolver(self.model)
        self.solver.config.nonlinear_solver = (s3d.NonlinearSolver.PD_NEWTON if args.mode == 'pd'
                                                else s3d.NonlinearSolver.NEWTON)
        self.solver.config.nonlinear_iterations = 3
        self.solver.config.linear_iterations = 5
        self.pipeline = newton.CollisionPipeline(self.model)
        self.contacts = self.model.contacts(self.pipeline)
        self.state_0, self.state_1 = self.model.state(), self.model.state()
        self.control = self.model.control()

    def step(self):
        self.state_0.clear_forces()
        self.pipeline.collide(self.state_0, self.contacts)
        self.solver.step(self.state_0, self.state_1, self.control, self.contacts, 1/240)
        self.state_0, self.state_1 = self.state_1, self.state_0
