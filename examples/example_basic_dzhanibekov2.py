# SPDX-FileCopyrightText: Copyright (c) 2026 The Style3D Sim Developers
# SPDX-License-Identifier: Apache-2.0

###########################################################################
# Example Basic Dzhanibekov 2
#
# Demonstrates the Dzhanibekov effect on a free T-shaped assembly. The
# horizontal bar and vertical stem are separate affine bodies connected by
# three non-collinear point-point constraints.
#
# Command: uv run python examples/example_basic_dzhanibekov2.py
# Headless: uv run python examples/example_basic_dzhanibekov2.py --viewer null --test
#
###########################################################################

import numpy as np
import warp as wp

import newton
import newton.examples
import style3d_sim as s3d


_STEM_RADIUS = 0.10
_STEM_HALF_HEIGHT = 0.5
_STEM_DENSITY = 50.0

_BAR_RADIUS = 0.20
_BAR_HALF_HEIGHT = 1.0
_BAR_DENSITY = 100.0

_ASSEMBLY_HEIGHT = 2.0
_STEM_CENTER_Y = -0.68
_INITIAL_ANGULAR_VELOCITY = np.array((0.01, 20.0, 0.0), dtype=np.float32)
_JOINT_ATTACHMENT_DISTANCE = 0.1


def _world_point(pose: np.ndarray, local_point: np.ndarray) -> np.ndarray:
    rotation = np.array(
        wp.quat_to_matrix(wp.quat(*pose[3:7])), dtype=np.float32
    ).reshape(3, 3)
    return pose[:3] + rotation @ local_point


class Example:
    def __init__(self, viewer, args):
        self.fps = 60
        self.frame_dt = 1.0 / self.fps
        self.sim_time = 0.0
        self.sim_substeps = 8
        self.sim_dt = self.frame_dt / self.sim_substeps
        self.viewer = viewer
        self.min_stem_axis_y = 1.0

        builder = s3d.ModelBuilder(
            up_axis=newton.Axis.Z,
            gravity=0.0,
            affine_body_particle_radius=0.04,
        )

        shape_cfg = builder.default_shape_cfg.copy()
        shape_cfg.has_shape_collision = False
        shape_cfg.has_particle_collision = False

        self.bar = builder.add_link(
            xform=wp.transform(wp.vec3(0.0, 0.0, _ASSEMBLY_HEIGHT), wp.quat_identity()),
            label="dzhanibekov_bar",
        )
        bar_cfg = shape_cfg.copy()
        bar_cfg.density = _BAR_DENSITY
        q_bar = wp.quat_from_axis_angle(wp.vec3(0.0, 1.0, 0.0), -wp.pi / 2.0)
        builder.add_shape_cylinder(
            self.bar,
            xform=wp.transform(wp.vec3(0.0), q_bar),
            radius=_BAR_RADIUS,
            half_height=_BAR_HALF_HEIGHT,
            cfg=bar_cfg,
            color=wp.vec3(0.75, 0.18, 0.12),
        )

        self.stem = builder.add_link(
            xform=wp.transform(
                wp.vec3(0.0, _STEM_CENTER_Y, _ASSEMBLY_HEIGHT),
                wp.quat_identity(),
            ),
            label="dzhanibekov_stem",
        )
        stem_cfg = shape_cfg.copy()
        stem_cfg.density = _STEM_DENSITY
        q_stem = wp.quat_from_axis_angle(wp.vec3(1.0, 0.0, 0.0), wp.pi / 2.0)
        builder.add_shape_cylinder(
            self.stem,
            xform=wp.transform(wp.vec3(0.0), q_stem),
            radius=_STEM_RADIUS,
            half_height=_STEM_HALF_HEIGHT,
            cfg=stem_cfg,
            color=wp.vec3(0.15, 0.42, 0.78),
        )

        # SynReal expands this fixed joint into three non-collinear, zero-length
        # point-point constraints. Keep both links dynamic; the joint is not
        # collapsed into one Newton body.
        bar_anchor = np.array((0.0, -0.18, 0.0), dtype=np.float32)
        stem_anchor = np.array((0.0, 0.50, 0.0), dtype=np.float32)
        free_joint = builder.add_joint_free(child=self.bar, label="free_root")
        fixed_joint = builder.add_joint_fixed(
            parent=self.bar,
            child=self.stem,
            parent_xform=wp.transform(wp.vec3(*bar_anchor), wp.quat_identity()),
            child_xform=wp.transform(wp.vec3(*stem_anchor), wp.quat_identity()),
            label="three_pp_connection",
        )
        builder.add_articulation(
            [free_joint, fixed_joint], label="dzhanibekov_assembly"
        )

        pp_offsets = np.array(
            (
                (0.0, 0.0, 0.0),
                (_JOINT_ATTACHMENT_DISTANCE, 0.0, 0.0),
                (0.0, _JOINT_ATTACHMENT_DISTANCE, 0.0),
            ),
            dtype=np.float32,
        )
        self.pp_points = tuple(
            (bar_anchor + offset, stem_anchor + offset) for offset in pp_offsets
        )

        bodies = (self.bar, self.stem)
        masses = np.array([float(builder.body_mass[body]) for body in bodies])
        world_coms = np.array(
            [
                _world_point(
                    np.asarray(builder.body_q[body], dtype=np.float32),
                    np.asarray(builder.body_com[body], dtype=np.float32),
                )
                for body in bodies
            ]
        )
        assembly_com = np.average(world_coms, axis=0, weights=masses)
        initial_velocities = []
        for body, world_com in zip(bodies, world_coms, strict=True):
            linear_velocity = np.cross(
                _INITIAL_ANGULAR_VELOCITY, world_com - assembly_com
            )
            velocity = wp.spatial_vector(*linear_velocity, *_INITIAL_ANGULAR_VELOCITY)
            builder.body_qd[body] = velocity
            initial_velocities.append(np.asarray(velocity, dtype=np.float32))

        # The articulation has only the free root's six velocity coordinates.
        # Its fixed child has no independent qd entries.
        builder.joint_qd[:] = initial_velocities[0].tolist()

        builder.add_ground_plane()
        self.model = builder.finalize()
        self.solver = s3d.NewtonSolver(
            self.model,
            joint_attachment_distance=_JOINT_ATTACHMENT_DISTANCE,
        )
        self.solver.config.affine_body_rigidity_model = s3d.AffineBodyRigidityModel.SO3_AUGMENTED_LAGRANGIAN
        self.solver.config.joint_constraint_mode = s3d.JointConstraintMode.AUGMENTED_LAGRANGIAN
        self.solver.config.nonlinear_solver = s3d.NonlinearSolver.NEWTON
        self.solver.config.inertia_mode = s3d.InertiaMode.MIDPOINT_CAYLEY
        self.solver.config.joint_constraint_primal_iterations = 2
        self.solver.config.nonlinear_iterations = 20
        self.solver.config.linear_iterations = 10

        self.state_0 = self.model.state()
        self.state_1 = self.model.state()
        self.control = self.model.control()
        self.stream = wp.get_stream(self.model.device)

        poses = self.state_0.body_q.numpy()
        self.body_masses = self.model.body_mass.numpy()[[self.bar, self.stem]]
        self.body_local_coms = self.model.body_com.numpy()[[self.bar, self.stem]]
        initial_world_coms = np.array(
            [
                _world_point(poses[body], local_com)
                for body, local_com in zip(
                    (self.bar, self.stem), self.body_local_coms, strict=True
                )
            ]
        )
        self.initial_com = np.average(
            initial_world_coms, axis=0, weights=self.body_masses
        )

        self.viewer.set_model(self.model)
        self.viewer.set_camera(pos=wp.vec3(2.5, -4.0, 2.5), pitch=-5.0, yaw=120.0)
        self.capture()

    def capture(self):
        if self.model.device.is_cuda:
            with wp.ScopedCapture(stream=self.stream) as capture:
                self.simulate()
            self.graph = capture.graph
        else:
            self.graph = None

    def simulate(self):
        for _ in range(self.sim_substeps):
            self.state_0.clear_forces()
            self.viewer.apply_forces(self.state_0)
            self.solver.step(
                self.state_0, self.state_1, self.control, None, self.sim_dt
            )
            self.state_0, self.state_1 = self.state_1, self.state_0

    def step(self):
        if self.graph:
            wp.capture_launch(self.graph, stream=self.stream)
        else:
            self.simulate()

        self.sim_time += self.frame_dt
        pose = self.state_0.body_q.numpy()[self.stem]
        stem_axis_world = np.array(
            wp.quat_to_matrix(wp.quat(*pose[3:7])), dtype=np.float32
        ).reshape(3, 3)[:, 1]
        self.min_stem_axis_y = min(self.min_stem_axis_y, float(stem_axis_world[1]))

    def test_final(self):
        poses = self.state_0.body_q.numpy()
        velocities = self.state_0.body_qd.numpy()
        bodies = [self.bar, self.stem]
        if (
            not np.isfinite(poses[bodies]).all()
            or not np.isfinite(velocities[bodies]).all()
        ):
            raise ValueError("Dzhanibekov assembly state contains non-finite values")

        gaps = []
        for bar_point, stem_point in self.pp_points:
            point0 = _world_point(poses[self.bar], bar_point)
            point1 = _world_point(poses[self.stem], stem_point)
            gaps.append(np.linalg.norm(point1 - point0))
        maximum_gap = float(max(gaps))
        if maximum_gap >= 2.0e-3:
            raise ValueError(f"A PP constraint opened by {maximum_gap:.6f} m")

        final_world_coms = np.array(
            [
                _world_point(poses[body], local_com)
                for body, local_com in zip(bodies, self.body_local_coms, strict=True)
            ]
        )
        final_com = np.average(final_world_coms, axis=0, weights=self.body_masses)
        if np.linalg.norm(final_com - self.initial_com) >= 5.0e-3:
            raise ValueError("Free two-body assembly developed linear drift")
        if self.min_stem_axis_y >= 0.0:
            raise ValueError("Dzhanibekov flip did not occur")

    def render(self):
        self.viewer.begin_frame(self.sim_time)
        self.viewer.log_state(self.state_0)
        self.viewer.end_frame()


if __name__ == "__main__":
    parser = newton.examples.create_parser()
    viewer, args = newton.examples.init(parser)
    newton.examples.run(Example(viewer, args), args)
