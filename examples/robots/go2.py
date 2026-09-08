"""Unitree Go2 robot specification."""

from .base import AssetSpec, ContactDefaults, ImportOptions, RobotSpec


JOINT_NAMES = tuple(
    f"{leg}_{joint}_joint"
    for leg in ("FR", "FL", "RR", "RL")
    for joint in ("hip", "thigh", "calf")
)

SPEC = RobotSpec(
    name="go2",
    asset=AssetSpec(
        newton_package="unitree_go2",
        relative_path="usd/go2.usda",
        importer="usd",
    ),
    joint_names=JOINT_NAMES,
    root_body_name="base",
    foot_names=("FR", "FL", "RR", "RL"),
    foot_body_names=("FR_calf", "FL_calf", "RR_calf", "RL_calf"),
    initial_base_position=(0.0, 0.0, 0.42),
    initial_base_quaternion_xyzw=(0.0, 0.0, 0.0, 1.0),
    default_joint_positions=(
        -0.1,
        0.8,
        -1.5,
        0.1,
        0.8,
        -1.5,
        -0.1,
        1.0,
        -1.5,
        0.1,
        1.0,
        -1.5,
    ),
    stiffness=(50.0,) * 12,
    damping=(1.0,) * 12,
    armature=(0.1,) * 12,
    effort_limits=(23.5,) * 12,
    contact=ContactDefaults(stiffness=5.0e4, damping=5.0e2),
    import_options=ImportOptions(hide_collision_shapes=True),
)
