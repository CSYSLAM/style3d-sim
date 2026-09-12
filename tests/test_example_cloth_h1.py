"""Exercise cloth solvers with the H1's prescribed IK motion and captured stepping."""

import numpy as np
import pytest

newton = pytest.importorskip("newton")
wp = pytest.importorskip("warp")
pytest.importorskip("pxr")

from newton.viewer import ViewerNull  # noqa: E402

from examples.example_cloth_h1 import Example  # noqa: E402


@pytest.mark.skipif(not wp.is_cuda_available(), reason="Cloth solvers require CUDA")
@pytest.mark.parametrize(("solver", "frames"), (("style3d", 32), ("synreal", 601)))
def test_cloth_follows_kinematic_h1_with_cuda_graph(solver, frames):
    with wp.ScopedDevice("cuda:0"):
        args = Example.create_parser().parse_args(["--solver", solver, "--viewer", "null", "--num-frames", str(frames)])
        example = Example(ViewerNull(), args)
        initial_cloth = example.state.particle_q.numpy().copy()
        initial_robot = example.state.body_q.numpy().copy()
        assert example.model.particle_count == len(example.garment_mesh_points)
        if solver == "synreal":
            from synreal_solver import NewtonSolver

            assert isinstance(example.cloth_solver, NewtonSolver)
            assert np.all(example.model.body_flags.numpy() == int(newton.BodyFlags.KINEMATIC))
        observed_contact = False
        observed_motion = False
        # Include arm lowering: inadequate garment contact can pass an initial waving smoke test.
        for _ in range(frames):
            example.step()
            observed_contact |= int(example.contacts.soft_contact_count.numpy()[0]) > 0
            observed_motion |= np.max(np.abs(example.state.body_qd.numpy())) > 1.0e-3
        assert example.graph is not None
        example.test_final()
        cloth = example.state.particle_q.numpy()
        assert np.isfinite(cloth).all()
        assert np.isfinite(example.state.particle_qd.numpy()).all()
        assert np.max(np.linalg.norm(cloth - initial_cloth, axis=1)) > 1.0e-3
        assert observed_contact
        # A dynamics solve must not displace IK links, and FK must consume the updated IK coordinates.
        expected = example.model.state()
        newton.eval_fk(example.model, example.joint_q_flat, example.model.joint_qd, expected)
        np.testing.assert_allclose(example.state.body_q.numpy(), expected.body_q.numpy(), atol=2.0e-6)
        assert np.max(np.abs(example.state.body_q.numpy()[:, :3] - initial_robot[:, :3])) > 1.0e-3
        assert observed_motion
