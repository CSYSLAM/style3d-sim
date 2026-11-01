"""Supplementary A/B scene: undriven fixed/ball joint between moving offset-COM bodies.

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
        parser.add_argument('--joint-kind', choices=('fixed', 'ball'), default='fixed')
        parser.add_argument('--worlds', type=int, default=1)
        parser.add_argument('--seed', type=int, default=1)
        parser.add_argument('--mode', choices=('newton', 'pd'), default='newton')
        parser.add_argument('--body-block', action='store_true')
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
        add_joint = template.add_joint_fixed if args.joint_kind == 'fixed' else template.add_joint_ball
        joint = add_joint(parent=parent, child=child,
                          parent_xform=wp.transform(wp.vec3(.12, -.06, .1), wp.quat_rpy(.1, .2, -.15)),
                          child_xform=wp.transform(wp.vec3(-.11, .04, -.08), wp.quat_rpy(-.2, .1, .05)))
        template.add_articulation([free, joint])
        template.joint_qd[:6] = [.1, -.05, -.4, .2, .1, -.1]
        if args.joint_kind == 'ball':
            template.joint_qd[-3:] = [.17, -.13, .23]
        if args.worlds > 1:
            builder = s3d.ModelBuilder(gravity=(.15, -.23, -9.81), affine_body_particle_radius=0.0)
            builder.replicate(template, args.worlds)
        else:
            builder = template
        self.model = builder.finalize(device='cuda:0')
        self.solver = s3d.NewtonSolver(self.model)
        self.solver.config.nonlinear_iterations = 3
        self.solver.config.linear_iterations = 5
        self.solver.config.joint_constraint_primal_iterations = 2
        self.solver.config.nonlinear_solver = (
            s3d.NonlinearSolver.PD_NEWTON if args.mode == 'pd' else s3d.NonlinearSolver.NEWTON)
        self.solver.config.affine_body_block_preconditioner = args.body_block
        native = self.solver._synreal_model
        assert native.joint_drive_count == 0
        assert native.joint_body_spring_count > 0
        assert native.particle_state_count == 8 * args.worlds
        self.state_0, self.state_1 = self.model.state(), self.model.state()
        newton.eval_fk(self.model, self.model.joint_q, self.model.joint_qd, self.state_0)
        self.control = self.model.control()
        self.sim_dt = 1.0 / 240.0

    def step(self):
        self.state_0.clear_forces()
        self.solver.step(self.state_0, self.state_1, self.control, None, self.sim_dt)
        self.state_0, self.state_1 = self.state_1, self.state_0
