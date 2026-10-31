"""Supplementary A/B scene: driven revolute/prismatic joint between moving bodies with offset COMs.

Use demo_source_ab with this file as --example. This supplements the official demos; it is not an official demo.
"""
import newton
import newton.examples
import numpy as np
import warp as wp

import style3d_sim as s3d


class Example:
    @staticmethod
    def create_parser():
        parser = newton.examples.create_parser()
        parser.add_argument('--joint-kind', choices=('revolute', 'prismatic'), default='revolute')
        parser.add_argument('--worlds', type=int, default=1)
        parser.add_argument('--seed', type=int, default=1)
        parser.add_argument('--armature', type=float, default=0.0)
        parser.add_argument('--derive-velocity', action='store_true')
        return parser

    def __init__(self, viewer, args):
        rng = np.random.default_rng(args.seed)
        template = s3d.ModelBuilder(gravity=(.15, -.23, -9.81), affine_body_particle_radius=0.0)
        cfg = template.default_shape_cfg.copy()
        cfg.density = 350.0
        cfg.has_shape_collision = cfg.has_particle_collision = False
        parent = template.add_link(xform=wp.transform(wp.vec3(.2, -.1, 1.5), wp.quat_rpy(.2, -.1, .3)))
        child = template.add_link()
        for body in (parent, child):
            center = rng.uniform(-.08, .08, 3)
            template.add_shape_box(body, hx=.17, hy=.09, hz=.13, cfg=cfg,
                                   xform=wp.transform(wp.vec3(*center), wp.quat_identity()))
        free = template.add_joint_free(child=parent)
        axis = wp.normalize(wp.vec3(*rng.uniform(.2, 1.0, 3)))
        add_joint = template.add_joint_revolute if args.joint_kind == 'revolute' else template.add_joint_prismatic
        joint = add_joint(parent=parent, child=child, axis=axis,
                          parent_xform=wp.transform(wp.vec3(.12, -.06, .1), wp.quat_rpy(.1, .2, -.15)),
                          child_xform=wp.transform(wp.vec3(-.11, .04, -.08), wp.quat_rpy(-.2, .1, .05)),
                          target_pos=.08, target_vel=-.12, target_ke=35.0, target_kd=1.7, damping=.23,
                          limit_lower=-.15, limit_upper=.14, limit_ke=80.0, limit_kd=.7,
                          effort_limit=2.5, armature=args.armature)
        template.add_articulation([free, joint])
        template.joint_q[-1] = .32
        template.joint_qd[-1] = .47
        if args.worlds > 1:
            builder = s3d.ModelBuilder(gravity=(.15, -.23, -9.81), affine_body_particle_radius=0.0)
            builder.replicate(template, args.worlds)
        else:
            builder = template
        self.model = builder.finalize(device='cuda:0')
        self.solver = s3d.NewtonSolver(self.model)
        self.solver.config.nonlinear_iterations = 5
        self.solver.config.linear_iterations = 12
        self.solver.config.joint_constraint_primal_iterations = 2
        if args.derive_velocity:
            convert = self.solver._as_synreal_control

            def omit_optional_velocity(control):
                native = convert(control)
                native.joint_drive_velocities = type(native.joint_drive_velocities)()
                return native

            self.solver._as_synreal_control = omit_optional_velocity
        self.state_0, self.state_1 = self.model.state(), self.model.state()
        newton.eval_fk(self.model, self.model.joint_q, self.model.joint_qd, self.state_0)
        self.control = self.model.control()
        feed = np.sin(np.arange(self.control.joint_f.shape[0]) + args.seed).astype('f4') * np.float32(.07)
        self.control.joint_f.assign(feed)
        self.sim_dt = 1.0 / 240.0

    def step(self):
        self.state_0.clear_forces()
        self.solver.step(self.state_0, self.state_1, self.control, None, self.sim_dt)
        self.state_0, self.state_1 = self.state_1, self.state_0
