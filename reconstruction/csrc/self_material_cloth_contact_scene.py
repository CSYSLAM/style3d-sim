"""Official Style3D cloth plus spring, tetrahedral, drag, PP self contacts and actual ground contacts."""
import newton
import newton.examples
import numpy as np
from newton.solvers import style3d
import style3d_sim as s3d
import warp as wp

from reconstruction.csrc.self_material_scene import Example as ParserExample


class Example:
    create_parser = staticmethod(ParserExample.create_parser)

    def __init__(self, viewer, args):
        points = [[-.05, -.05, .5], [.05, -.05, .5], [.05, .05, .5], [-.05, .05, .5],
                  [-.018, -.022, .504], [.022, -.022, .504], [.022, .018, .504], [-.018, .018, .504]]
        triangles = [[0, 1, 2], [0, 2, 3], [4, 5, 6], [4, 6, 7]]
        template = newton.ModelBuilder(gravity=(.125, -.25, -9.81), up_axis=newton.Axis.Z)
        newton.solvers.SolverStyle3D.register_custom_attributes(template)
        aerodynamic = args.material in ('drag', 'all')
        style3d.add_cloth_mesh(template, pos=wp.vec3(0.), rot=wp.quat_identity(), vel=wp.vec3(0.),
                              vertices=points, indices=np.asarray(triangles).ravel().tolist(), density=80.,
                              particle_radius=.006, tri_aniso_ke=wp.vec3(37.5, 53.75, 11.25), tri_ka=0., tri_kd=0.,
                              edge_aniso_ke=wp.vec3(2.5), edge_kd=.03, tri_drag=.875 if aerodynamic else 0., tri_lift=0.)
        template.add_particles(pos=[wp.vec3(3., 0., .5), wp.vec3(3.01, 0., .5)],
                               vel=[wp.vec3(0.), wp.vec3(0.)], mass=[1.5, 1.5], radius=[.006, .006])
        if args.material in ('spring', 'all'):
            template.add_spring(0, 1, ke=43.125, kd=0., control=0.)
            template.spring_rest_length[-1] *= .8
        if args.material in ('tet', 'all'):
            volume = template.add_tetrahedron(0, 1, 2, 4, k_mu=113.75, k_lambda=257.125, k_damp=.625)
            assert volume > 0.
        rng = np.random.default_rng(args.seed)
        template.particle_qd = [wp.vec3(*value) for value in rng.uniform(-.005, .005, (10, 3))]
        template.add_ground_plane(height=.5)
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
