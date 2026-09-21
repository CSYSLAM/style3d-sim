"""Particle snowball motion and CUDA-graph-compatible viewer interaction."""

import numpy as np
import pytest

newton = pytest.importorskip("newton")
wp = pytest.importorskip("warp")
from examples import example_snow  # noqa: E402
from newton.viewer import ViewerNull  # noqa: E402

pytestmark = pytest.mark.skipif(not wp.is_cuda_available(), reason="Native granular materials require CUDA")


def make_example(*extra, viewer=None):
    args = example_snow.Example.create_parser().parse_args(
        ["--viewer", "null", "--device", "cuda:0", "--resolution", "8", *extra]
    )
    return example_snow.Example(ViewerNull() if viewer is None else viewer, args)


def test_graph_matches_uncaptured_rolling_particle_seed():
    with wp.ScopedDevice("cuda:0"):
        plain = make_example("--no-capture")
        captured = make_example()
        masses = captured.model.particle_mass.numpy().copy()
        radii = captured.model.particle_radius.numpy().copy()
        np.testing.assert_array_equal(captured.granular_positions.numpy(), plain.initial_positions)
        assert captured.model.body_count == 0
        assert captured.granular_count == captured.model.particle_count
        for _ in range(24):
            plain.step()
            captured.step()
        # Compare before chaotic differences in contact formation amplify over a long rollout.
        np.testing.assert_allclose(captured.granular_positions.numpy(), plain.granular_positions.numpy(), atol=2.0e-3)
        initial = captured.initial_positions[: captured.seed_count]
        current = captured.granular_positions.numpy()[: captured.seed_count]
        assert ((current.mean(axis=0) - initial.mean(axis=0)) @ captured.rotation)[0] > 0.08
        initial_offsets = initial - initial.mean(axis=0)
        current_offsets = current - current.mean(axis=0)
        u, _, vt = np.linalg.svd(initial_offsets.T @ current_offsets)
        rotation = u @ vt
        angle = np.arccos(np.clip(0.5 * (np.trace(rotation) - 1.0), -1.0, 1.0))
        assert np.linalg.det(rotation) > 0.99
        assert angle > 0.1
        # Growth must come from existing bed grains joining the ball, never enlarged proxy geometry.
        np.testing.assert_array_equal(captured.model.particle_mass.numpy(), masses)
        np.testing.assert_array_equal(captured.model.particle_radius.numpy(), radii)
        captured.test_final()
        plain.test_final()


@pytest.mark.parametrize("capture", [False, True])
def test_particle_snowball_drag_and_release(capture):
    with wp.ScopedDevice("cuda:0"):
        viewer = ViewerNull()
        example = make_example(*([] if capture else ["--no-capture"]), viewer=viewer)
        picking = example.picking
        assert viewer.picking is picking
        assert viewer.picking_enabled
        assert example.model.body_count == 0
        initial = example.initial_seed_center.copy()
        camera = wp.vec3(5.8, -8.2, 5.5)
        # Aim at an actual seed grain so low-resolution gaps cannot make the test ray miss the ball.
        point = wp.vec3(*example.initial_positions[example.seed_count // 2])
        picking.pick(example.state_0, camera, wp.normalize(point - camera))
        assert picking.is_picking()
        target = picking.pick_state.numpy()[0]["picking_target_world"].copy() + np.array([0.5, 0.65, 0.85])
        picking.update(camera, wp.normalize(wp.vec3(*target) - camera))
        for _ in range(20):
            example.step()
        actual = example.granular_positions.numpy()[: example.seed_count].mean(axis=0)
        assert actual[1] > initial[1] + 0.06
        assert actual[2] > initial[2] + 0.03
        assert np.isfinite(example.state_0.particle_q.numpy()).all()
        picking.release()
        example.step()
        assert not picking.is_picking()
        np.testing.assert_array_equal(example.state_0.particle_f.numpy(), 0.0)


def test_contact_adhesion_carries_existing_bed_grains_with_the_rolling_seed():
    def transported_grains(example):
        masses = example.model.particle_mass.numpy().copy()
        radii = example.model.particle_radius.numpy().copy()
        snapshots = []
        for frame in range(1, 181):
            example.step()
            if frame in (120, 150, 180):
                snapshots.append(example.granular_positions.numpy().copy())
        masks = []
        for positions in snapshots:
            center = positions[: example.seed_count].mean(axis=0)
            bed = positions[example.seed_count :]
            distances = np.linalg.norm(bed - center, axis=1)
            height = (bed @ example.rotation)[:, 2]
            masks.append(
                (distances < example_snow.SEED_RADIUS + 3.0 * example.spacing)
                & (height > example_snow.BED_HEIGHT + example.radius)
            )
        persistent = np.logical_and.reduce(masks)
        displacement = (snapshots[-1] - snapshots[0]) @ example.rotation
        transported = persistent & (displacement[example.seed_count :, 0] > 0.5)
        # Follow the same bed particle IDs over one second; a momentary collision plume is insufficient.
        np.testing.assert_array_equal(example.model.particle_mass.numpy(), masses)
        np.testing.assert_array_equal(example.model.particle_radius.numpy(), radii)
        assert snapshots[-1].shape == example.initial_positions.shape
        example.test_final()
        return int(transported.sum())

    with wp.ScopedDevice("cuda:0"):
        snow = make_example("--resolution", "16")
        nonadhesive = make_example("--resolution", "16", "--cohesion", "0")
        carried = transported_grains(snow)
        control = transported_grains(nonadhesive)
        assert carried >= 20
        assert carried >= control + 20
