"""Actual PD_NEWTON joint/drive path on the existing offset-COM revolute/prismatic fixture."""
import style3d_sim as s3d

from reconstruction.csrc.joint_body_scene import Example as JointExample


class Example(JointExample):
    def __init__(self, viewer, args):
        super().__init__(viewer, args)
        self.solver.config.nonlinear_solver = s3d.NonlinearSolver.PD_NEWTON
