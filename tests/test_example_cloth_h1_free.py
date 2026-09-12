"""Check that the jacket and unanchored H1 advance together under SynReal dynamics."""

import numpy as np
import pytest

newton = pytest.importorskip("newton")
wp = pytest.importorskip("warp")
pytest.importorskip("pxr")

from newton.viewer import ViewerNull  # noqa: E402

from examples.example_cloth_h1_free import Example  # noqa: E402


@pytest.mark.skipif(not wp.is_cuda_available(), reason="SynReal requires CUDA")
def test_free_h1_posture_drives_and_coupled_cloth():
    with wp.ScopedDevice("cuda:0"):
        args = Example.create_parser().parse_args(["--viewer", "null"])
        example = Example(ViewerNull(), args)
        model = example.model
        types = model.joint_type.numpy()
        free = np.flatnonzero(types == int(newton.JointType.FREE))
        assert len(free) == 1
        assert np.all(model.body_flags.numpy() == int(newton.BodyFlags.DYNAMIC))
        assert np.all(model.joint_enabled.numpy())
        assert model.particle_count == example.cloth_particle_count + 4 * model.body_count
        root_dof = model.joint_qd_start.numpy()[free[0]]
        np.testing.assert_array_equal(model.joint_target_ke.numpy()[root_dof:root_dof + 6], 0.0)
        np.testing.assert_array_equal(model.joint_target_kd.numpy()[root_dof:root_dof + 6], 0.0)
        dofs = example.posture_dofs
        np.testing.assert_allclose(model.joint_target_ke.numpy()[dofs], args.joint_stiffness)
        np.testing.assert_allclose(model.joint_target_kd.numpy()[dofs], args.joint_damping)
        np.testing.assert_allclose(model.joint_effort_limit.numpy()[dofs], args.joint_effort_limit)
        hinges = np.flatnonzero(types == int(newton.JointType.REVOLUTE))
        targets = model.joint_target_q_start.numpy()[hinges]
        coordinates = model.joint_q_start.numpy()[hinges]
        np.testing.assert_allclose(example.control.joint_target_q.numpy()[targets], model.joint_q.numpy()[coordinates])
        initial_body = example.state.body_q.numpy().copy()
        initial_cloth = example.state.particle_q.numpy()[:example.cloth_particle_count].copy()
        parents = model.joint_parent.numpy()[hinges]
        children = model.joint_child.numpy()[hinges]
        parent_frames = model.joint_X_p.numpy()[hinges]
        child_frames = model.joint_X_c.numpy()[hinges]

        def anchors(poses, frames):
            xyz, scalar = poses[:, 3:6], poses[:, 6:7]
            points = frames[:, :3]
            return poses[:, :3] + points + 2.0 * np.cross(xyz, np.cross(xyz, points) + scalar * points)

        soft_contacts = rigid_contacts = False
        for frame in range(601):
            example.step()
            if frame % 60 == 0:
                example.test_final()
                bodies = example.state.body_q.numpy()
                gaps = np.linalg.norm(anchors(bodies[parents], parent_frames) - anchors(bodies[children], child_frames), axis=1)
                assert gaps.max() < 0.03
                soft_contacts |= int(example.contacts.soft_contact_count.numpy()[0]) > 0
                rigid_contacts |= int(example.contacts.rigid_contact_count.numpy()[0]) > 0
        assert example.graph is not None
        assert soft_contacts and rigid_contacts
        assert np.max(np.linalg.norm(example.state.body_q.numpy()[:, :3] - initial_body[:, :3], axis=1)) > 0.01
        cloth = example.state.particle_q.numpy()[:example.cloth_particle_count]
        assert np.max(np.linalg.norm(cloth - initial_cloth, axis=1)) > 0.01
