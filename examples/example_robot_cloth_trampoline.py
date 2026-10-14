# SPDX-FileCopyrightText: Copyright (c) 2025 The Newton Developers
# SPDX-License-Identifier: Apache-2.0

###########################################################################
# Example Robot Cloth Trampoline
#
# Drops a Unitree G1 robot onto a deformable trampoline. The trampoline's
# outer ring is fixed while the remaining vertices are simulated as cloth.
#
# Command: python examples/python/example_robot_cloth_trampoline.py
#
###########################################################################

from pathlib import Path

import numpy as np
import warp as wp

import newton
import newton.examples
import newton.utils
import style3d_sim as s3d
from newton import JointTargetMode, ParticleFlags
from newton.solvers import style3d


def load_obj_triangles(path: Path) -> tuple[list[tuple[float, float, float]], list[int]]:
    """Load positions and triangulated faces from a Wavefront OBJ file."""
    vertices: list[tuple[float, float, float]] = []
    indices: list[int] = []

    with path.open(encoding="utf-8") as obj_file:
        for line_number, line in enumerate(obj_file, start=1):
            fields = line.split()
            if not fields or fields[0].startswith("#"):
                continue

            if fields[0] == "v":
                if len(fields) < 4:
                    raise ValueError(f"Invalid vertex at {path}:{line_number}")
                vertices.append((float(fields[1]), float(fields[2]), float(fields[3])))
            elif fields[0] == "f":
                if len(fields) < 4:
                    raise ValueError(f"Invalid face at {path}:{line_number}")

                face: list[int] = []
                for field in fields[1:]:
                    obj_index = int(field.split("/", maxsplit=1)[0])
                    vertex_index = obj_index - 1 if obj_index > 0 else len(vertices) + obj_index
                    if vertex_index < 0 or vertex_index >= len(vertices):
                        raise ValueError(f"Invalid vertex index at {path}:{line_number}")
                    face.append(vertex_index)

                for corner in range(1, len(face) - 1):
                    indices.extend((face[0], face[corner], face[corner + 1]))

    if not vertices or not indices:
        raise ValueError(f"OBJ contains no triangle mesh: {path}")

    return vertices, indices


def triangle_mesh_area(vertices: list[tuple[float, float, float]], indices: list[int]) -> float:
    positions = np.asarray(vertices, dtype=np.float64)
    triangles = positions[np.asarray(indices, dtype=np.int32).reshape(-1, 3)]
    double_areas = np.linalg.norm(
        np.cross(triangles[:, 1] - triangles[:, 0], triangles[:, 2] - triangles[:, 0]),
        axis=1,
    )
    return float(0.5 * np.sum(double_areas))


class Example:
    def __init__(self, viewer, args):
        self.fps = 60
        self.frame_dt = 1.0 / self.fps
        self.sim_substeps = 6
        self.sim_dt = self.frame_dt / self.sim_substeps
        self.sim_time = 0.0
        self.viewer = viewer

        builder = newton.ModelBuilder(up_axis=newton.Axis.Z)
        newton.solvers.SolverStyle3D.register_custom_attributes(builder)

        contact_stiffness = 1.0e5
        contact_damping = 1.0e3

        builder.default_joint_cfg = newton.ModelBuilder.JointDofConfig(
            limit_ke=1.0e3,
            limit_kd=1.0e1,
            friction=1.0e-5,
        )
        builder.default_shape_cfg.ke = contact_stiffness
        builder.default_shape_cfg.kd = contact_damping
        builder.default_shape_cfg.kf = 1.0e3
        builder.default_shape_cfg.mu = 0.75

        asset_path = newton.utils.download_asset("unitree_g1")
        builder.add_usd(
            str(asset_path / "usd_structured" / "g1_29dof_with_hand_rev_1_0.usda"),
            # The reference standing pose uses z=0.2. Adding 0.6 puts the
            # lowest robot geometry approximately 0.6 m above the ground.
            xform=wp.transform(wp.vec3(0.0, 0.0, 1.3)),
            collapse_fixed_joints=True,
            enable_self_collisions=False,
            hide_collision_shapes=True,
            skip_mesh_approximation=True,
        )

        for dof in range(6, builder.joint_dof_count):
            builder.joint_target_ke[dof] = 500.0
            builder.joint_target_kd[dof] = 10.0
            builder.joint_target_mode[dof] = int(JointTargetMode.POSITION)

        builder.approximate_meshes("bounding_box")

        # USD materials may override the builder defaults. Soft contacts use
        # the smaller of the particle and shape stiffness, so set every G1
        # collision shape explicitly to avoid silently limiting the response.
        for shape_index in range(len(builder.shape_body)):
            builder.shape_material_ke[shape_index] = contact_stiffness
            builder.shape_material_kd[shape_index] = contact_damping

        #obj_path = Path(__file__).resolve().parents[1] / "assets" / "trampoline_v93.obj"
        #obj_path = Path(__file__).resolve().parents[1] / "assets" / "trampoline_v176.obj"
        obj_path = Path(__file__).resolve().parents[1] / "assets" / "trampoline_v1051.obj"
        trampoline_vertices, trampoline_indices = load_obj_triangles(obj_path)
        trampoline_area = triangle_mesh_area(trampoline_vertices, trampoline_indices)
        trampoline_start = len(builder.particle_q)
        trampoline_mass = 5.0

        style3d.add_cloth_mesh(
            builder,
            pos=wp.vec3(0.0, 0.0, 1.0),
            rot=wp.quat_identity(),
            vel=wp.vec3(0.0),
            vertices=trampoline_vertices,
            indices=trampoline_indices,
            density=trampoline_mass / trampoline_area,
            tri_aniso_ke=wp.vec3(2.0e5, 2.0e5, 2e5),
            edge_aniso_ke=wp.vec3(2.0e-4, 2.0e-4, 2.0e-4),
            tri_kd=5.0,
            edge_kd=1.0,
            particle_radius=0.025,
            label="trampoline",
        )

        for vertex_index in range(64):
            particle_index = trampoline_start + vertex_index
            builder.particle_flags[particle_index] &= ~ParticleFlags.ACTIVE
            builder.particle_mass[particle_index] = 0.0

        builder.add_ground_plane()

        self.model = builder.finalize()
        self.model.set_gravity((0.0, 0.0, -9.81))
        self.model.soft_contact_ke = contact_stiffness
        self.model.soft_contact_kd = contact_damping
        self.model.soft_contact_mu = 0.6

        # Synreal builds affine proxies from model.body_q, so initialize the
        # authored articulation pose before constructing the solver.
        newton.eval_fk(self.model, self.model.joint_q, self.model.joint_qd, self.model)

        self.solver = s3d.NewtonSolver(self.model)
        self.solver.config.affine_body_rigidity_model = s3d.AffineBodyRigidityModel.SIX_SPRINGS
        self.solver.config.joint_constraint_mode = s3d.JointConstraintMode.AUGMENTED_LAGRANGIAN
        self.solver.config.nonlinear_solver = s3d.NonlinearSolver.NEWTON
        self.solver.config.inertia_mode = s3d.InertiaMode.MIDPOINT_CAYLEY
        self.solver.config.joint_constraint_primal_iterations = 2
        self.solver.config.nonlinear_iterations = 20
        self.solver.config.linear_iterations = 5

        self.state_0 = self.model.state()
        self.state_1 = self.model.state()
        self.control = self.model.control()
        self.contacts = self.model.contacts()

        newton.eval_fk(self.model, self.state_0.joint_q, self.state_0.joint_qd, self.state_0)

        self.viewer.set_model(self.model)
        self.capture()

    def capture(self):
        if wp.get_device().is_cuda:
            with wp.ScopedCapture() as capture:
                self.simulate()
            self.graph = capture.graph
        else:
            self.graph = None

    def simulate(self):
        for _ in range(self.sim_substeps):
            self.state_0.clear_forces()
            self.viewer.apply_forces(self.state_0)
            self.model.collide(self.state_0, self.contacts)
            self.solver.step(self.state_0, self.state_1, self.control, self.contacts, self.sim_dt)
            self.state_0, self.state_1 = self.state_1, self.state_0

    def step(self):
        if self.graph:
            wp.capture_launch(self.graph)
        else:
            self.simulate()
        self.sim_time += self.frame_dt

    def render(self):
        self.viewer.begin_frame(self.sim_time)
        self.viewer.log_state(self.state_0)
        self.viewer.log_contacts(self.contacts, self.state_0)
        self.viewer.end_frame()

    @staticmethod
    def create_parser():
        return newton.examples.create_parser()


if __name__ == "__main__":
    parser = Example.create_parser()
    viewer, args = newton.examples.init(parser)
    newton.examples.run(Example(viewer, args), args)
