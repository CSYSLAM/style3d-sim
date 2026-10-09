# SPDX-FileCopyrightText: Copyright (c) 2026 The Synreal Solver Developers
# SPDX-License-Identifier: Apache-2.0

"""Cut a cohesive granular beef block with a manually dragged rigid knife.

Run: uv run python examples/example_granular_beaf.py
Surface: uv run python examples/example_granular_beaf.py --build-surface
Headless: uv run python examples/example_granular_beaf.py --viewer null --num-frames 360 --test
Control: right-drag the knife to cut; release to return it above the beef.

The blade separates particles through ordinary rigid contacts; tensile strain
irreversibly breaks native granular bonds. This is a coarse cohesive material
demonstration, without an anatomical muscle or sharp-crack continuum model.
"""

import copy
import math

import newton
import newton.examples
import numpy as np
import warp as wp

import synreal_solver

if __package__:
    from .beef_knife import KNIFE_MASS, add_knife, advance_clock, drive_knife
    from .beef_material import color_beef_particles
    from .beef_surface import BeefSurface, connected_components
else:
    from beef_knife import KNIFE_MASS, add_knife, advance_clock, drive_knife
    from beef_material import color_beef_particles
    from beef_surface import BeefSurface, connected_components

FRAME_DT = 1.0 / 60.0
INITIAL_KNIFE_HEIGHT = 0.45
BEEF_DENSITY = 1050.0


@wp.kernel
def observe_fracture(
    positions: wp.array(dtype=wp.vec3),
    pairs: wp.array(dtype=wp.vec2i),
    rest: wp.array(dtype=float),
    break_strain: float,
    broken: wp.array(dtype=int),
):
    # Read-only diagnostics mirror accepted-step fracture with plastic compaction disabled.
    i = wp.tid()
    pair = pairs[i]
    if wp.length(positions[pair[0]] - positions[pair[1]]) > rest[i] * (1.0 + break_strain):
        broken[i] = 1


def particle_layout(resolution):
    """Use even x columns so the blade starts between grains, with all bonds intact."""
    if resolution < 12 or resolution % 2:
        raise ValueError("resolution must be an even integer of at least 12")
    spacing = 0.72 / resolution
    nx, ny, nz = resolution, round(0.3 / spacing), round(0.06 / spacing)
    axes = [(np.arange(n) + 0.5 - 0.5 * n) * spacing for n in (nx, ny)]
    z = np.arange(nz) * spacing + 0.43 * spacing + 0.002
    points = np.stack(np.meshgrid(*axes, z, indexing="ij"), axis=-1).reshape(-1, 3)
    # An asymmetric oval reads as a whole steak while preserving the isotropic bond lattice.
    x, y = points[:, 0], points[:, 1]
    center_y = 0.006 * np.sin(9.0 * x + 0.4)
    half_width = 0.138 * (1.0 + 0.07 * np.sin(11.0 * x + 0.6))
    footprint = (x / 0.36) ** 2 + ((y - center_y) / half_width) ** 2
    return points[footprint < 1.0].astype(np.float32), spacing


def configure_knife_picking(viewer, model, body):
    picking = getattr(viewer, "picking", None)
    if picking is None:
        return wp.array([-1], dtype=int, device=model.device)
    selected = np.flatnonzero(model.shape_body.numpy() == body)
    pick_model = copy.copy(model)
    pick_model.shape_count = len(selected)
    # Restrict raycasts to the knife so the board cannot intercept its drag gesture.
    for name in ("shape_body", "shape_transform", "shape_type", "shape_scale", "shape_source_ptr", "shape_world"):
        source = getattr(model, name)
        setattr(pick_model, name, wp.array(source.numpy()[selected], dtype=source.dtype, device=model.device))
    picking.model = pick_model
    viewer.picking_enabled = True
    return picking.pick_body


class Example:
    def __init__(self, viewer, args):
        if args.build_surface and args.viewer == "rtx":
            raise ValueError("--build-surface requires a viewer with dynamic mesh topology, such as gl or usd")
        if min(args.substeps, args.iterations, args.linear_iterations) < 1:
            raise ValueError("substeps and solver iterations must be positive")
        for name in ("cohesion", "break_strain"):
            if not math.isfinite(getattr(args, name)) or getattr(args, name) <= 0.0:
                raise ValueError(f"{name} must be finite and positive")
        if not math.isfinite(args.knife_tilt) or not 0.0 <= args.knife_tilt <= 3.0:
            raise ValueError("knife_tilt must be finite and between 0 and 3 degrees")
        points, self.spacing = particle_layout(args.resolution)
        device = wp.get_device(args.device)
        if not device.is_cuda:
            raise RuntimeError("The native granular beef example requires a CUDA device (--device cuda:0).")
        self.viewer, self.sim_time = viewer, 0.0
        self.frame_dt, self.sim_substeps = FRAME_DT, args.substeps
        self.sim_dt, self.radius = FRAME_DT / args.substeps, 0.43 * self.spacing
        self.granular_count, self.initial_positions = len(points), points.copy()
        self.break_strain, self.auto_cut = args.break_strain, not args.no_cut
        self.knife_tilt, self.knife_seed = args.knife_tilt, args.seed
        builder = newton.ModelBuilder(up_axis=newton.Axis.Z)
        builder.add_particles(
            pos=points,
            vel=np.zeros_like(points),
            mass=np.full(len(points), BEEF_DENSITY * self.spacing**3),
            radius=np.full(len(points), self.radius),
        )
        cfg = builder.default_shape_cfg.copy()
        cfg.ke, cfg.kd, cfg.kf, cfg.mu = 2.0e5, 50.0, 80.0, 0.45
        self.board_shape = builder.add_shape_box(
            -1,
            xform=wp.transform(wp.vec3(0.0, 0.0, -0.045), wp.quat_identity()),
            hx=0.68,
            hy=0.45,
            hz=0.045,
            cfg=cfg,
            color=(0.42, 0.235, 0.105),
            label="cutting_board",
        )
        builder.add_shape_box(
            -1,
            xform=wp.transform(wp.vec3(0.0, 0.0, -0.14), wp.quat_identity()),
            hx=0.95,
            hy=0.75,
            hz=0.04,
            cfg=cfg,
            color=(0.13, 0.17, 0.20),
        )
        self.knife_body = add_knife(builder, self.spacing)
        self.model = builder.finalize(device=device)
        self.model.soft_contact_ke, self.model.soft_contact_kd = cfg.ke, cfg.kd
        self.model.soft_contact_kf, self.model.soft_contact_mu = 15.0, 0.15
        synreal_solver.configure_granular(
            self.model,
            np.arange(len(points), dtype=np.int32),
            contact_stiffness=20000.0,
            friction=0.3,
            friction_damping=20.0,
            cohesion=args.cohesion,
            bond_damping=args.bond_damping,
            max_compaction=0.0,
            break_strain=args.break_strain,
            bond_radius=1.5 * self.spacing,
            adhesion=0.0,
        )
        self.solver = synreal_solver.NewtonSolver(self.model)
        self.solver.config.nonlinear_solver = synreal_solver.NonlinearSolver.NEWTON
        self.solver.config.nonlinear_iterations = args.iterations
        self.solver.config.linear_iterations = args.linear_iterations
        self.solver.config.enable_collision_hessian_non_diagonal = True
        self.state_0, self.state_1 = self.model.state(), self.model.state()
        # Affine rigid coordinates appended by the adapter are not visible beef particles.
        self.granular_positions = self.state_0.particle_q[: self.granular_count]
        self.granular_velocities = self.state_0.particle_qd[: self.granular_count]
        rest_positions = wp.array(points, dtype=wp.vec3, device=device)
        self.colors = wp.empty(len(points), dtype=wp.vec3, device=device)
        wp.launch(color_beef_particles, dim=len(points), inputs=[rest_positions], outputs=[self.colors], device=device)
        self.clock = wp.zeros(1, dtype=float, device=device)
        self.drive_enabled = wp.array([int(self.auto_cut)], dtype=int, device=device)
        self.bonds = self.model.synreal_granular_bond_indices
        self.broken = wp.zeros(len(self.bonds), dtype=int, device=device)
        self.surface = (
            BeefSurface(self.spacing, rest_positions, self.bonds, self.broken)
            if args.build_surface
            else None
        )
        self.collision_pipeline = newton.CollisionPipeline(self.model, soft_contact_max=6 * self.granular_count)
        self.contacts = self.collision_pipeline.contacts()
        viewer.set_model(self.model)
        self.pick_body = configure_knife_picking(viewer, self.model, self.knife_body)
        viewer.show_particles, viewer.show_ground = False, False
        viewer.set_camera(pos=wp.vec3(1.7, -2.2, 1.5), pitch=-26.0, yaw=126.0)
        self.stream, self.graph = wp.get_stream(device), None
        if not args.no_capture:
            with wp.ScopedCapture(stream=self.stream) as capture:
                self.simulate()
            self.graph = capture.graph
        print(
            f"Granular beef: {self.granular_count:,} particles, {len(self.bonds):,} bonds, "
            f"rigid knife, auto cut={self.auto_cut}, substeps={self.sim_substeps}",
            flush=True,
        )

    def simulate(self):
        for _ in range(self.sim_substeps):
            self.state_0.clear_forces()
            self.viewer.apply_forces(self.state_0)
            wp.launch(
                drive_knife,
                dim=1,
                inputs=[
                    self.state_0.body_q,
                    self.state_0.body_qd,
                    self.state_0.body_f,
                    self.clock,
                    self.sim_dt,
                    self.knife_body,
                    KNIFE_MASS,
                    INITIAL_KNIFE_HEIGHT,
                    0.02 * self.spacing,
                    self.drive_enabled,
                    self.pick_body,
                    self.knife_tilt,
                    self.knife_seed,
                ],
                device=self.model.device,
            )
            self.collision_pipeline.collide(self.state_0, self.contacts)
            self.solver.step(self.state_0, self.state_1, None, self.contacts, self.sim_dt)
            wp.copy(self.state_0.particle_q, self.state_1.particle_q)
            wp.copy(self.state_0.particle_qd, self.state_1.particle_qd)
            wp.copy(self.state_0.body_q, self.state_1.body_q)
            wp.copy(self.state_0.body_qd, self.state_1.body_qd)
            wp.launch(
                observe_fracture,
                dim=len(self.bonds),
                inputs=[
                    self.granular_positions,
                    self.bonds,
                    self.model.synreal_granular_bond_rest_lengths,
                    self.break_strain,
                    self.broken,
                ],
                device=self.model.device,
            )
            wp.launch(advance_clock, dim=1, inputs=[self.clock, self.sim_dt], device=self.model.device)

    def step(self):
        if self.graph is not None:
            wp.capture_launch(self.graph, stream=self.stream)
        else:
            self.simulate()
        self.sim_time += self.frame_dt

    def render(self):
        mesh = self.surface.rebuild(self.granular_positions) if self.surface is not None else None
        self.viewer.begin_frame(self.sim_time)
        self.viewer.log_state(self.state_0)
        if mesh is not None:
            self.surface.log_mesh(self.viewer, *mesh)
        else:
            self.viewer.log_points("beef", self.granular_positions, self.radius, self.colors)
        self.viewer.end_frame()

    def cut_stats(self):
        """Count connected material pieces from observed, irreversible bond fractures."""
        bonds, broken = self.bonds.numpy(), self.broken.numpy().astype(bool)
        labels = connected_components(self.granular_count, bonds[~broken])
        sizes = np.sort(np.unique(labels, return_counts=True)[1])[::-1]
        cross = self.initial_positions[bonds[:, 0], 0] * self.initial_positions[bonds[:, 1], 0] < 0.0
        points = self.granular_positions.numpy()
        left = self.initial_positions[:, 0] < 0.0
        gap = float(points[~left, 0].min() - points[left, 0].max() - 2.0 * self.radius)
        return dict(broken=int(broken.sum()), cross_remaining=int((cross & ~broken).sum()), pieces=sizes, gap=gap)

    def test_final(self):
        points, velocities = self.granular_positions.numpy(), self.granular_velocities.numpy()
        if not np.isfinite(points).all() or not np.isfinite(velocities).all():
            raise ValueError("Beef produced a non-finite state")
        if points[:, 2].min() < -0.15 or np.abs(points).max() > 2.0 or np.linalg.norm(velocities, axis=1).max() > 10.0:
            raise ValueError("Beef particles escaped or became unstable")
        stats = self.cut_stats()
        if self.sim_time >= 5.0 and self.auto_cut:
            if stats["cross_remaining"] or len(stats["pieces"]) < 2 or stats["pieces"][1] < 0.4 * self.granular_count:
                raise ValueError(f"The knife did not produce two connected beef pieces: {stats}")
        print(f"Beef checks passed: {stats}", flush=True)

    @staticmethod
    def create_parser():
        parser = newton.examples.create_parser()
        parser.description = __doc__
        # Skip the automatic cutting trajectory while retaining mouse forces and the release-to-home controller.
        parser.set_defaults(num_frames=360, no_cut=True)
        parser.add_argument("--resolution", type=int, default=64, help="Even particle count across 0.72 m; at least 12.")
        parser.add_argument("--substeps", type=int, default=4)
        parser.add_argument("--iterations", type=int, default=5)
        parser.add_argument("--linear-iterations", type=int, default=40)
        parser.add_argument("--cohesion", type=float, default=2000.0, help="Initial bond stiffness in N/m.")
        parser.add_argument("--bond-damping", type=float, default=5.0, help="Internal viscous bond damping in N*s/m.")
        parser.add_argument("--break-strain", type=float, default=0.15, help="Irreversible tensile fracture threshold.")
        parser.add_argument("--knife-tilt", type=float, default=2.0, help="Smooth random knife lean in degrees, from 0 to 3.")
        parser.add_argument("--seed", type=int, default=17, help="Random seed for the knife's smooth orientation changes.")
        parser.add_argument("--no-cut", action="store_true", help="Skip automatic cutting (default); drag the knife manually.")
        parser.add_argument("--build-surface", action="store_true", help="Render a closed, reconstructed beef surface mesh.")
        parser.add_argument("--no-capture", action="store_true")
        return parser


if __name__ == "__main__":
    viewer, args = newton.examples.init(Example.create_parser())
    try:
        newton.examples.run(Example(viewer, args), args)
    except Exception:
        # The runner closes the viewer on success; USD viewers cannot be closed twice.
        viewer.close()
        raise
