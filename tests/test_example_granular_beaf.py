"""Rigid knife contact, irreversible granular fracture, and interactive dragging."""

import numpy as np
import pytest

newton = pytest.importorskip("newton")
wp = pytest.importorskip("warp")
from examples import example_granular_beaf  # noqa: E402
from newton._src.viewer.picking import Picking  # noqa: E402
from newton.viewer import ViewerNull  # noqa: E402

pytestmark = pytest.mark.skipif(not wp.is_cuda_available(), reason="Native granular materials require CUDA")


@wp.kernel
def pull_material_half(selected: wp.array(dtype=int), masses: wp.array(dtype=float), forces: wp.array(dtype=wp.vec3)):
    particle = wp.tid()
    if selected[particle] != 0:
        forces[particle] = wp.vec3(-5.0 * masses[particle], 0.0, 0.0)


def make_example(*extra, viewer=None):
    args = example_granular_beaf.Example.create_parser().parse_args(["--viewer", "null", "--device", "cuda:0", *extra])
    return example_granular_beaf.Example(ViewerNull() if viewer is None else viewer, args)


class PickingViewer(ViewerNull):
    """Exercise the standard viewer's picking forces without requiring an OpenGL window."""

    def set_model(self, model):
        super().set_model(model)
        self.picking = Picking(model)

    def apply_forces(self, state):
        self.picking._apply_picking_force(state)


def test_graph_matches_uncaptured_rigid_knife_and_granular_material():
    with wp.ScopedDevice("cuda:0"):
        plain = make_example("--resolution", "12", "--seed", "23", "--no-capture")
        captured = make_example("--resolution", "12", "--seed", "23")
        masses = captured.model.particle_mass.numpy().copy()
        radii = captured.model.particle_radius.numpy().copy()
        np.testing.assert_array_equal(captured.granular_positions.numpy(), plain.initial_positions)
        np.testing.assert_array_equal(captured.clock.numpy(), 0.0)
        assert captured.model.body_count == 1
        assert int(captured.model.body_flags.numpy()[0]) & int(newton.BodyFlags.DYNAMIC)
        orientations = []
        for frame in range(75):
            plain.step()
            captured.step()
            if frame >= 30 and frame % 15 == 14:
                orientations.append(captured.state_0.body_q.numpy()[captured.knife_body, 3:].copy())
        # Compare before fracture and contact ordering can amplify small floating-point differences.
        np.testing.assert_allclose(captured.granular_positions.numpy(), plain.granular_positions.numpy(), atol=2.0e-3)
        np.testing.assert_allclose(captured.state_0.body_q.numpy(), plain.state_0.body_q.numpy(), atol=2.0e-3)
        np.testing.assert_allclose(captured.clock.numpy(), [75.0 / 60.0], atol=2.0e-5)
        orientations = np.asarray(orientations)
        angles = np.rad2deg(2.0 * np.arcsin(np.clip(np.linalg.norm(orientations[:, :3], axis=1), 0.0, 1.0)))
        assert angles.max() > 0.05
        assert angles.max() < 3.0
        # The same random seed reproduces a slowly changing orientation in both execution paths.
        assert np.linalg.norm(orientations[-1, :3] - orientations[0, :3]) > 1.0e-4
        np.testing.assert_array_equal(captured.model.particle_mass.numpy(), masses)
        np.testing.assert_array_equal(captured.model.particle_radius.numpy(), radii)
        captured.test_final()
        plain.test_final()


def test_knife_cuts_two_persistent_pieces_while_uncut_control_stays_connected():
    with wp.ScopedDevice("cuda:0"):
        control = make_example("--no-cut")
        assert control.granular_count == 12720
        thickness = np.ptp(control.initial_positions[:, 2]) + 2.0 * control.radius
        assert 0.05 < thickness <= 0.06
        board = control.board_shape
        np.testing.assert_allclose(control.model.shape_transform.numpy()[board, :3], [0.0, 0.0, -0.045])
        np.testing.assert_allclose(control.model.shape_scale.numpy()[board], [0.68, 0.45, 0.045])
        initial_cross = control.cut_stats()["cross_remaining"]
        assert initial_cross > 0
        for _ in range(300):
            control.step()
        stats = control.cut_stats()
        np.testing.assert_array_equal(stats["pieces"], [control.granular_count])
        assert stats["broken"] == 0
        assert stats["cross_remaining"] == initial_cross
        control.test_final()

        cut = make_example()
        masses = cut.model.particle_mass.numpy().copy()
        radii = cut.model.particle_radius.numpy().copy()
        for _ in range(168):
            cut.step()
        # The bottom bonds must already be severed before the blade starts nudging the right piece.
        assert cut.cut_stats()["cross_remaining"] == 0
        before_nudge = cut.granular_positions.numpy().copy()
        left = cut.initial_positions[:, 0] < 0.0
        for _ in range(132):
            cut.step()
        nudge_displacement = cut.granular_positions.numpy() - before_nudge
        assert nudge_displacement[~left, 0].mean() > 0.07
        assert np.linalg.norm(nudge_displacement[left].mean(axis=0)) < 0.005
        stats = cut.cut_stats()
        assert stats["cross_remaining"] == 0
        assert stats["pieces"][1] >= 0.4 * cut.granular_count
        assert cut.state_0.body_q.numpy()[cut.knife_body, 2] > 0.4
        broken_after_cut = cut.broken.numpy().copy()
        # Continue after the blade retracts to distinguish lasting fracture from a temporary blade-shaped gap.
        for _ in range(60):
            cut.step()
        final = cut.cut_stats()
        assert final["cross_remaining"] == 0
        assert final["pieces"][1] >= 0.4 * cut.granular_count
        assert final["gap"] > 0.08
        assert np.all(cut.broken.numpy() >= broken_after_cut)
        np.testing.assert_array_equal(cut.model.particle_mass.numpy(), masses)
        np.testing.assert_array_equal(cut.model.particle_radius.numpy(), radii)
        cut.test_final()
        selected = wp.array(left.astype(np.int32), dtype=int, device=cut.model.device)

        def apply_pull(state):
            wp.launch(
                pull_material_half,
                dim=cut.granular_count,
                inputs=[selected, cut.model.particle_mass, state.particle_f],
                device=cut.model.device,
            )

        # Test native mechanical separation independently of the example's fracture diagnostics.
        cut.graph = None
        cut.viewer.apply_forces = apply_pull
        before_pull = cut.granular_positions.numpy().copy()
        for _ in range(12):
            cut.step()
        displacement = cut.granular_positions.numpy() - before_pull
        assert displacement[left, 0].mean() < -0.005
        assert np.linalg.norm(displacement[~left].mean(axis=0)) < 0.002
        cut.test_final()


@pytest.mark.parametrize("capture", [False, True])
def test_rigid_knife_drag_overrides_translation_drive_and_releases(capture):
    with wp.ScopedDevice("cuda:0"):
        viewer = PickingViewer()
        example = make_example("--resolution", "12", "--no-cut", *([] if capture else ["--no-capture"]), viewer=viewer)
        picking = viewer.picking
        assert viewer.picking_enabled
        camera = wp.vec3(2.0, 0.0, 0.62)
        point = wp.vec3(0.0, 0.0, 0.62)
        picking.pick(example.state_0, camera, wp.normalize(point - camera))
        assert picking.is_picking()
        assert picking.pick_body.numpy()[0] == example.knife_body
        initial = example.state_0.body_q.numpy()[example.knife_body, :3].copy()
        target = picking.pick_state.numpy()[0]["picking_target_world"].copy() + np.array([0.0, 0.4, 0.2])
        picking.update(camera, wp.normalize(wp.vec3(*target) - camera))
        for _ in range(30):
            example.step()
        current = example.state_0.body_q.numpy()[example.knife_body, :3]
        assert current[1] > initial[1] + 0.02
        assert current[2] > initial[2] + 0.01
        assert np.isfinite(example.state_0.particle_q.numpy()).all()
        picking.release()
        assert not picking.is_picking()
        example.state_0.clear_forces()
        viewer.apply_forces(example.state_0)
        np.testing.assert_array_equal(example.state_0.body_f.numpy(), 0.0)
        example.step()
        example.test_final()
