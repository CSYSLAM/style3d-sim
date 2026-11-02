"""SO3 box and cloth layers in actual barycentric full-surface contact, including body reaction."""
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
        parser.add_argument('--worlds', type=int, default=1)
        parser.add_argument('--mode', choices=('newton', 'pd'), default='newton')
        parser.add_argument('--body-block', action='store_true')
        parser.add_argument('--diagonal-only', action='store_true')
        parser.add_argument('--self', action='store_true')
        parser.add_argument('--contacts', action='store_true')
        parser.add_argument('--springs', action='store_true')
        return parser

    def __init__(self, viewer, args):
        template = newton.ModelBuilder(gravity=(.125, -.25, -9.81), up_axis=newton.Axis.Z)
        newton.solvers.SolverStyle3D.register_custom_attributes(template)
        position = (0., 0., .479) if args.contacts else (1.5, 0., 1.5)
        rotation = wp.quat_identity() if args.contacts else wp.quat_rpy(.25, -.15, .3)
        body = template.add_body(xform=wp.transform(wp.vec3(*position), rotation), mass=0.)
        template.add_shape_box(body, hx=.025, hy=.025, hz=.025,
                               cfg=newton.ModelBuilder.ShapeConfig(density=750, mu_rolling=0., mu_torsional=0.))
        template.body_qd[-1] = (.1, -.05, -.4, .2, .1, -.1)
        points = [[-.05, -.05, .5], [.05, -.05, .5], [.05, .05, .5], [-.05, .05, .5],
                  [-.018, -.022, .504], [.022, -.022, .504], [.022, .018, .504], [-.018, .018, .504]]
        triangles = [[0, 1, 2], [0, 2, 3], [4, 5, 6], [4, 6, 7]]
        style3d.add_cloth_mesh(template, pos=wp.vec3(0.), rot=wp.quat_identity(), vel=wp.vec3(0.),
                              vertices=points, indices=np.asarray(triangles).ravel().tolist(), density=80.,
                              particle_radius=.006, tri_aniso_ke=wp.vec3(37.5, 53.75, 11.25), tri_ka=0., tri_kd=0.,
                              edge_aniso_ke=wp.vec3(2.5), edge_kd=.03, tri_drag=0., tri_lift=0.)
        template.particle_qd = [wp.vec3(*v) for v in np.random.default_rng(17).uniform(-.005, .005, (8, 3))]
        if args.springs:
            template.add_spring(0, 1, ke=43.125, kd=0., control=0.)
            template.spring_rest_length[-1] *= .8
        builder = template
        if args.worlds > 1:
            builder = newton.ModelBuilder(gravity=(.125, -.25, -9.81), up_axis=newton.Axis.Z)
            newton.solvers.SolverStyle3D.register_custom_attributes(builder)
            builder.replicate(template, args.worlds)
        self.model = builder.finalize(device='cuda:0')
        self.solver = s3d.NewtonSolver(self.model)
        config = self.solver.config
        config.enable_self_collision = args.self
        config.self_collision_radius = .003
        config.self_collision_vertex_face_stiffness = .5
        config.self_collision_edge_edge_stiffness = .1
        config.self_collision_edge_face_stiffness = 1.
        config.self_collision_particle_particle_stiffness = .25
        config.enable_collision_hessian_non_diagonal = not args.diagonal_only
        config.affine_body_block_preconditioner = args.body_block
        config.nonlinear_solver = s3d.NonlinearSolver.PD_NEWTON if args.mode == 'pd' else s3d.NonlinearSolver.NEWTON
        config.nonlinear_iterations, config.linear_iterations = 3, 5
        self.state_0, self.state_1 = self.model.state(), self.model.state()
        self.control = self.model.control()
        self.pipeline = newton.CollisionPipeline(self.model, enable_rigid_soft_full_surface_contact=True) if args.contacts else None
        self.contacts = self.pipeline.contacts() if self.pipeline else None

    def step(self):
        self.state_0.clear_forces()
        if self.pipeline:
            self.pipeline.collide(self.state_0, self.contacts)
        self.solver.step(self.state_0, self.state_1, self.control, self.contacts, 1/240)
        self.state_0, self.state_1 = self.state_1, self.state_0
