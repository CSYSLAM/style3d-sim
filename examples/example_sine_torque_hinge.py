#!/usr/bin/env python3
# SPDX-FileCopyrightText: Copyright (c) 2026 The Synreal Solver Developers
# SPDX-License-Identifier: Apache-2.0

"""Display and verify a two-rod hinge driven by a sinusoidal torque.

Both rods are dynamic and free from the world. They rotate about their shared
center. Gravity and collisions are disabled. The revolute joint receives

    tau(t) = amplitude * sin(2*pi*frequency*t)

through ``control.joint_f``. The viewer side panel reports total linear
momentum and the resultant-force residual estimated from its time derivative.

Run from the repository root:

    .venv/Scripts/python.exe examples/example_sine_torque_hinge.py

Run the same scene as an automated check without a window:

    .venv/Scripts/python.exe examples/example_sine_torque_hinge.py \
        --viewer null --test --num-frames 240
"""

from __future__ import annotations

import math

import newton
import newton.examples
import numpy as np
import warp as wp

import synreal_solver


def _box_inertia(mass: float, length: float, width: float) -> wp.mat33:
    ixx = mass * (width * width + width * width) / 12.0
    iyy = mass * (length * length + width * width) / 12.0
    izz = mass * (length * length + width * width) / 12.0
    return wp.mat33(ixx, 0.0, 0.0, 0.0, iyy, 0.0, 0.0, 0.0, izz)


class Example:
    def __init__(self, viewer, args):
        if args.frequency <= 0.0:
            raise ValueError("frequency must be positive")
        if args.force_tolerance <= 0.0:
            raise ValueError("force-tolerance must be positive")

        self.viewer = viewer
        self.frame_dt = 1.0 / 60.0
        self.sim_substeps = args.substeps
        self.sim_dt = self.frame_dt / self.sim_substeps
        self.sim_time = 0.0
        self.amplitude = args.amplitude
        self.frequency = args.frequency
        self.force_tolerance = args.force_tolerance
        self.constraint_alpha = args.constraint_alpha

        builder = synreal_solver.ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
        length = 1.0
        width = 0.12
        mass = 2.0
        height = 1.5
        inertia = _box_inertia(mass, length, width)

        self.parent = builder.add_link(
            xform=wp.transform(
                wp.vec3(0.0, 0.0, height), wp.quat_identity()
            ),
            mass=mass,
            inertia=inertia,
            lock_inertia=True,
            label="left_rod",
        )
        self.child = builder.add_link(
            xform=wp.transform(
                wp.vec3(0.0, 0.0, height), wp.quat_identity()
            ),
            mass=mass,
            inertia=inertia,
            lock_inertia=True,
            label="right_rod",
        )
        visual = builder.default_shape_cfg.copy()
        visual.density = 0.0
        visual.has_shape_collision = False
        visual.has_particle_collision = False
        builder.add_shape_box(
            self.parent,
            hx=0.5 * length,
            hy=0.5 * width,
            hz=0.5 * width,
            cfg=visual,
            color=wp.vec3(0.12, 0.42, 0.78),
        )
        builder.add_shape_box(
            self.child,
            hx=0.5 * length,
            hy=0.5 * width,
            hz=0.5 * width,
            cfg=visual,
            color=wp.vec3(0.90, 0.32, 0.10),
        )

        hinge = builder.add_joint_revolute(
            parent=self.parent,
            child=self.child,
            axis=(0.0, 0.0, 1.0),
            parent_xform=wp.transform(
                wp.vec3(0.0, 0.0, 0.0), wp.quat_identity()
            ),
            child_xform=wp.transform(
                wp.vec3(0.0, 0.0, 0.0), wp.quat_identity()
            ),
            target_ke=0.0,
            target_kd=0.0,
            damping=0.0,
            label="center_hinge",
        )
        builder.add_articulation([hinge], label="free_two_rod_hinge")

        self.model = builder.finalize()
        self.solver = synreal_solver.NewtonSolver(
            self.model,
            joint_damping=0.0,
            joint_drive_armature=0.0,
        )
        self.solver.config.nonlinear_iterations = 10
        self.solver.config.linear_iterations = 50
        self.solver.config.constraint_alpha = self.constraint_alpha
        self.solver.config.joint_constraint_mode = {
            "penalty": synreal_solver.JointConstraintMode.PENALTY,
            "augmented-lagrangian": (
                synreal_solver.JointConstraintMode.AUGMENTED_LAGRANGIAN
            ),
        }[args.joint_mode]
        self.solver.config.affine_body_rigidity_model = {
            "six-springs": synreal_solver.AffineBodyRigidityModel.SIX_SPRINGS,
            "abd-orthogonality": (
                synreal_solver.AffineBodyRigidityModel.ABD_ORTHOGONALITY
            ),
            "co-rotated": synreal_solver.AffineBodyRigidityModel.CO_ROTATED,
        }[args.rigidity_model]

        self.state_0, self.state_1 = self.model.state(), self.model.state()
        newton.eval_fk(
            self.model,
            self.model.joint_q,
            self.model.joint_qd,
            self.state_0,
        )
        newton.eval_fk(
            self.model,
            self.model.joint_q,
            self.model.joint_qd,
            self.state_1,
        )
        self.solver.sync_affine_body_state(self.state_0)
        self.solver.sync_affine_body_state(self.state_1)

        self.control = self.model.control()
        self.control.joint_f.zero_()
        wp.copy(self.control.joint_target_q, self.model.joint_target_q)
        wp.copy(self.control.joint_target_qd, self.model.joint_target_qd)
        self.joint_q = wp.empty(
            self.model.joint_coord_count,
            dtype=wp.float32,
            device=self.model.device,
        )
        self.joint_qd = wp.empty(
            self.model.joint_dof_count,
            dtype=wp.float32,
            device=self.model.device,
        )
        self.bodies = [self.parent, self.child]
        body_inv_masses = self.model.body_inv_mass.numpy()[self.bodies]
        if np.any(body_inv_masses <= 0.0):
            raise RuntimeError(
                "Both rods must be dynamic; fixed bodies invalidate this test."
            )
        affine_body_ids = self.solver._affine_body_ids.numpy()
        affine_body_indices = self.solver._affine_body_indices.numpy()
        self.proxy_indices = np.array(
            [
                affine_body_indices[int(np.flatnonzero(affine_body_ids == body)[0])]
                for body in self.bodies
            ]
        )
        self.body_masses = self.model.body_mass.numpy()[self.bodies].astype(
            np.float64
        )
        self.body_inertias = self.model.body_inertia.numpy()[self.bodies].astype(
            np.float64
        )

        wp.synchronize_device(self.model.device)
        self.initial_com = self._center_of_mass()
        self.previous_momentum = self._linear_momentum()
        self.angular_momentum_norm = float(np.linalg.norm(self._angular_momentum()))
        self.affine_angular_momentum_norm = float(
            np.linalg.norm(self._affine_angular_momentum())
        )
        self.current_torque = 0.0
        self.momentum_norm = float(np.linalg.norm(self.previous_momentum))
        self.force_residual = 0.0
        self.com_drift = 0.0
        self.joint_angle = 0.0
        self.joint_speed = 0.0
        self.axis_tilt = 0.0
        self.axis_misalignment = 0.0
        self.proxy_axis_tilt = 0.0
        self.rod_out_of_plane = 0.0
        self.proxy_rod_out_of_plane = 0.0
        self.hinge_separation = 0.0
        self.proxy_hinge_separation = 0.0
        self.max_momentum = self.momentum_norm
        self.max_angular_momentum = self.angular_momentum_norm
        self.max_affine_angular_momentum = self.affine_angular_momentum_norm
        self.max_force_residual = 0.0
        self.max_com_drift = 0.0
        self.peak_joint_angle = 0.0
        self.peak_joint_speed = 0.0
        self.max_axis_tilt = 0.0
        self.max_axis_misalignment = 0.0
        self.max_proxy_axis_tilt = 0.0
        self.max_rod_out_of_plane = 0.0
        self.max_proxy_rod_out_of_plane = 0.0
        self.max_hinge_separation = 0.0
        self.max_proxy_hinge_separation = 0.0
        self.next_report_time = 1.0

        self.hinge_axis_start = wp.array(
            (wp.vec3(0.0, 0.0, height - 0.35),),
            dtype=wp.vec3,
            device=self.model.device,
        )
        self.hinge_axis_end = wp.array(
            (wp.vec3(0.0, 0.0, height + 0.35),),
            dtype=wp.vec3,
            device=self.model.device,
        )

        self.viewer.set_model(self.model)
        self.viewer.set_camera(
            pos=wp.vec3(0.0, -4.0, 2.6), pitch=-12.0, yaw=90.0
        )
        if hasattr(self.viewer, "renderer"):
            self.viewer.register_ui_callback(self.render_ui, position="side")

    def _linear_momentum(self) -> np.ndarray:
        velocities = self.state_0.body_qd.numpy()[self.bodies, :3].astype(
            np.float64
        )
        return np.sum(self.body_masses[:, None] * velocities, axis=0)

    def _center_of_mass(self) -> np.ndarray:
        positions = self.state_0.body_q.numpy()[self.bodies, :3].astype(np.float64)
        return np.average(positions, axis=0, weights=self.body_masses)

    def _angular_momentum(self) -> np.ndarray:
        poses = self.state_0.body_q.numpy()[self.bodies]
        velocities = self.state_0.body_qd.numpy()[self.bodies].astype(np.float64)
        center = self._center_of_mass()
        momentum = np.zeros(3, dtype=np.float64)
        for pose, velocity, mass, inertia in zip(
            poses, velocities, self.body_masses, self.body_inertias
        ):
            rotation = np.asarray(
                wp.quat_to_matrix(wp.quat(*(float(value) for value in pose[3:7]))),
                dtype=np.float64,
            ).reshape(3, 3)
            spin = rotation @ inertia @ rotation.T @ velocity[3:]
            orbital = np.cross(pose[:3] - center, mass * velocity[:3])
            momentum += spin + orbital
        return momentum

    def _affine_angular_momentum(self) -> np.ndarray:
        positions = self.state_0.particle_q.numpy().astype(np.float64)
        velocities = self.state_0.particle_qd.numpy().astype(np.float64)
        center = self._center_of_mass()
        momentum = np.zeros(3, dtype=np.float64)
        for indices, mass, inertia in zip(
            self.proxy_indices,
            self.body_masses,
            self.body_inertias,
        ):
            origin = positions[indices[0]]
            origin_velocity = velocities[indices[0]]
            affine = positions[indices[1:]].T
            affine_velocity = velocities[indices[1:]].T
            second_moment = 0.5 * np.trace(inertia) * np.eye(3) - inertia
            coupling = affine_velocity @ second_moment @ affine.T
            spin = np.array(
                (
                    coupling[2, 1] - coupling[1, 2],
                    coupling[0, 2] - coupling[2, 0],
                    coupling[1, 0] - coupling[0, 1],
                )
            )
            momentum += spin + np.cross(
                origin - center, mass * origin_velocity
            )
        return momentum

    @staticmethod
    def _world_z_axis(pose: np.ndarray) -> np.ndarray:
        orientation = wp.quat(*(float(value) for value in pose[3:7]))
        return np.asarray(
            wp.quat_rotate(orientation, wp.vec3(0.0, 0.0, 1.0)),
            dtype=np.float64,
        )

    @staticmethod
    def _angle_between(first: np.ndarray, second: np.ndarray) -> float:
        first = np.asarray(first, dtype=np.float64)
        second = np.asarray(second, dtype=np.float64)
        first /= np.linalg.norm(first)
        second /= np.linalg.norm(second)
        return math.atan2(
            float(np.linalg.norm(np.cross(first, second))),
            float(np.dot(first, second)),
        )

    def _update_axis_errors(self):
        poses = self.state_0.body_q.numpy()[self.bodies]
        parent_axis = self._world_z_axis(poses[0])
        child_axis = self._world_z_axis(poses[1])
        parent_rod = np.asarray(
            wp.quat_rotate(
                wp.quat(*(float(value) for value in poses[0, 3:7])),
                wp.vec3(1.0, 0.0, 0.0),
            ),
            dtype=np.float64,
        )
        child_rod = np.asarray(
            wp.quat_rotate(
                wp.quat(*(float(value) for value in poses[1, 3:7])),
                wp.vec3(1.0, 0.0, 0.0),
            ),
            dtype=np.float64,
        )
        proxy_positions = self.state_0.particle_q.numpy()
        proxy_axes = []
        proxy_rods = []
        for indices in self.proxy_indices:
            proxy_rods.append(
                proxy_positions[indices[1]]
                / np.linalg.norm(proxy_positions[indices[1]])
            )
            proxy_axes.append(
                proxy_positions[indices[3]]
                / np.linalg.norm(proxy_positions[indices[3]])
            )
        world_z = np.array((0.0, 0.0, 1.0))
        self.axis_tilt = max(
            self._angle_between(parent_axis, world_z),
            self._angle_between(child_axis, world_z),
        )
        self.axis_misalignment = self._angle_between(parent_axis, child_axis)
        self.proxy_axis_tilt = max(
            self._angle_between(axis, world_z)
            for axis in proxy_axes
        )
        self.rod_out_of_plane = max(
            math.asin(float(np.clip(abs(np.dot(axis, world_z)), 0.0, 1.0)))
            for axis in (parent_rod, child_rod)
        )
        self.proxy_rod_out_of_plane = max(
            math.asin(float(np.clip(abs(np.dot(axis, world_z)), 0.0, 1.0)))
            for axis in proxy_rods
        )
        self.hinge_separation = float(np.linalg.norm(poses[0, :3] - poses[1, :3]))
        self.proxy_hinge_separation = float(
            np.linalg.norm(
                proxy_positions[self.proxy_indices[0, 0]]
                - proxy_positions[self.proxy_indices[1, 0]]
            )
        )

    def simulate(self):
        for substep in range(self.sim_substeps):
            time = self.sim_time + substep * self.sim_dt
            self.current_torque = self.amplitude * math.sin(
                2.0 * math.pi * self.frequency * time
            )
            self.control.joint_f.fill_(self.current_torque)
            self.state_0.clear_forces()
            self.solver.step(
                self.state_0, self.state_1, self.control, None, self.sim_dt
            )
            self.state_0, self.state_1 = self.state_1, self.state_0

    def update_diagnostics(self):
        wp.synchronize_device(self.model.device)
        momentum = self._linear_momentum()
        self.momentum_norm = float(np.linalg.norm(momentum))
        self.angular_momentum_norm = float(np.linalg.norm(self._angular_momentum()))
        self.affine_angular_momentum_norm = float(
            np.linalg.norm(self._affine_angular_momentum())
        )
        self.force_residual = float(
            np.linalg.norm(momentum - self.previous_momentum) / self.frame_dt
        )
        self.previous_momentum = momentum
        self.com_drift = float(np.linalg.norm(self._center_of_mass() - self.initial_com))

        newton.eval_ik(self.model, self.state_0, self.joint_q, self.joint_qd)
        wp.synchronize_device(self.model.device)
        self.joint_angle = float(self.joint_q.numpy()[0])
        self.joint_speed = float(self.joint_qd.numpy()[0])
        self._update_axis_errors()

        self.max_momentum = max(self.max_momentum, self.momentum_norm)
        self.max_angular_momentum = max(
            self.max_angular_momentum, self.angular_momentum_norm
        )
        self.max_affine_angular_momentum = max(
            self.max_affine_angular_momentum, self.affine_angular_momentum_norm
        )
        self.max_force_residual = max(
            self.max_force_residual, self.force_residual
        )
        self.max_com_drift = max(self.max_com_drift, self.com_drift)
        self.peak_joint_angle = max(self.peak_joint_angle, abs(self.joint_angle))
        self.peak_joint_speed = max(self.peak_joint_speed, abs(self.joint_speed))
        self.max_axis_tilt = max(self.max_axis_tilt, self.axis_tilt)
        self.max_axis_misalignment = max(
            self.max_axis_misalignment, self.axis_misalignment
        )
        self.max_proxy_axis_tilt = max(
            self.max_proxy_axis_tilt, self.proxy_axis_tilt
        )
        self.max_rod_out_of_plane = max(
            self.max_rod_out_of_plane, self.rod_out_of_plane
        )
        self.max_proxy_rod_out_of_plane = max(
            self.max_proxy_rod_out_of_plane, self.proxy_rod_out_of_plane
        )
        self.max_hinge_separation = max(
            self.max_hinge_separation, self.hinge_separation
        )
        self.max_proxy_hinge_separation = max(
            self.max_proxy_hinge_separation, self.proxy_hinge_separation
        )

    def step(self):
        self.simulate()
        self.sim_time += self.frame_dt
        self.update_diagnostics()
        if self.sim_time + 1.0e-8 >= self.next_report_time:
            print(
                f"t={self.sim_time:6.2f} s  tau={self.current_torque:+.4f} N m  "
                f"|P|={self.momentum_norm:.3e} kg m/s  "
                f"|F_residual|={self.force_residual:.3e} N"
            )
            self.next_report_time += 1.0

    def render_ui(self, imgui):
        status = "PASS" if self.max_force_residual <= self.force_tolerance else "FAIL"
        imgui.text("mode: two free bodies")
        imgui.text(f"tau(t): {self.current_torque:+.5f} N m")
        imgui.text(f"joint angle: {self.joint_angle:+.5f} rad")
        imgui.text(f"joint speed: {self.joint_speed:+.5f} rad/s")
        imgui.text(f"axis tilt: {math.degrees(self.axis_tilt):.5f} deg")
        imgui.text(
            f"axis mismatch: {math.degrees(self.axis_misalignment):.5f} deg"
        )
        imgui.text(f"proxy axis tilt: {math.degrees(self.proxy_axis_tilt):.5f} deg")
        imgui.text(f"rod out of plane: {math.degrees(self.rod_out_of_plane):.5f} deg")
        imgui.text(f"hinge separation: {self.hinge_separation:.3e} m")
        imgui.separator()
        imgui.text(f"total momentum: {self.momentum_norm:.3e} kg m/s")
        imgui.text(
            f"angular momentum: {self.angular_momentum_norm:.3e} kg m^2/s"
        )
        imgui.text(
            "ABD angular momentum: "
            f"{self.affine_angular_momentum_norm:.3e} kg m^2/s"
        )
        imgui.text(f"force residual: {self.force_residual:.3e} N")
        imgui.text(f"maximum residual: {self.max_force_residual:.3e} N")
        imgui.text(f"COM drift: {self.com_drift:.3e} m")
        imgui.separator()
        imgui.text(f"resultant-force check: {status}")

    def render(self):
        self.viewer.begin_frame(self.sim_time)
        self.viewer.log_state(self.state_0)
        self.viewer.log_lines(
            "/hinge/axis",
            self.hinge_axis_start,
            self.hinge_axis_end,
            (0.95, 0.74, 0.12),
        )
        self.viewer.end_frame()

    def test_final(self):
        print(
            "Sine-torque hinge diagnostics:\n"
            f"  max |total momentum| : {self.max_momentum:.6e} kg m/s\n"
            "  max |angular momentum|: "
            f"{self.max_angular_momentum:.6e} kg m^2/s\n"
            "  max |ABD angular mom.|: "
            f"{self.max_affine_angular_momentum:.6e} kg m^2/s\n"
            f"  max |force residual| : {self.max_force_residual:.6e} N\n"
            f"  max COM drift        : {self.max_com_drift:.6e} m\n"
            f"  peak |joint angle|   : {self.peak_joint_angle:.6e} rad\n"
            f"  peak |joint speed|   : {self.peak_joint_speed:.6e} rad/s\n"
            f"  max axis tilt        : {math.degrees(self.max_axis_tilt):.6e} deg\n"
            "  max axis mismatch    : "
            f"{math.degrees(self.max_axis_misalignment):.6e} deg\n"
            f"  max proxy axis tilt  : {math.degrees(self.max_proxy_axis_tilt):.6e} deg\n"
            "  max rod out of plane : "
            f"{math.degrees(self.max_rod_out_of_plane):.6e} deg\n"
            "  max proxy rod error  : "
            f"{math.degrees(self.max_proxy_rod_out_of_plane):.6e} deg\n"
            f"  max hinge separation: {self.max_hinge_separation:.6e} m\n"
            "  max proxy hinge gap : "
            f"{self.max_proxy_hinge_separation:.6e} m"
        )
        if self.max_force_residual > self.force_tolerance:
            raise ValueError(
                "resultant-force check failed: "
                f"{self.max_force_residual:.6e} N > "
                f"{self.force_tolerance:.6e} N"
            )


if __name__ == "__main__":
    parser = newton.examples.create_parser()
    parser.add_argument(
        "--amplitude",
        type=float,
        default=2.0,
        help="Sinusoidal torque amplitude in N m.",
    )
    parser.add_argument(
        "--frequency",
        type=float,
        default=1.0,
        help="Sinusoidal torque frequency in Hz.",
    )
    parser.add_argument(
        "--force-tolerance",
        type=float,
        default=1.0e-3,
        help="Maximum accepted numerical resultant-force residual in N.",
    )
    parser.add_argument(
        "--constraint-alpha",
        type=float,
        default=20.0,
        help="Shared mass-normalized affine-body and hinge constraint strength.",
    )
    parser.add_argument(
        "--substeps",
        type=int,
        default=4,
        help="Physics substeps per 60 Hz viewer frame.",
    )
    parser.add_argument(
        "--joint-mode",
        choices=("penalty", "augmented-lagrangian"),
        default="penalty",
        help="Generated hinge-constraint enforcement mode.",
    )
    parser.add_argument(
        "--rigidity-model",
        choices=("six-springs", "abd-orthogonality", "co-rotated"),
        default="co-rotated",
        help="Affine-body rigidity model.",
    )
    viewer, args = newton.examples.init(parser)
    newton.examples.run(Example(viewer, args), args)
