"""Unitree A1 robot specification."""

from .base import AssetSpec, ContactDefaults, ImportOptions, RobotSpec


RL_SAR_ZOO_COMMIT = "7dd30bdc7806898950b354260655d5a7f0ce844e"
RL_SAR_ZOO_URL = "https://github.com/fan-ziqi/rl_sar_zoo.git"

JOINT_NAMES = tuple(
    f"{leg}_{joint}_joint"
    for leg in ("FR", "FL", "RR", "RL")
    for joint in ("hip", "thigh", "calf")
)

SPEC = RobotSpec(
    name="a1",
    asset=AssetSpec(
        relative_path="urdf/a1_description.urdf",
        importer="urdf",
        git_url=RL_SAR_ZOO_URL,
        git_folder="a1_description",
        git_ref=RL_SAR_ZOO_COMMIT,
    ),
    joint_names=JOINT_NAMES,
    root_body_name="base",
    foot_names=("FR", "FL", "RR", "RL"),
    foot_body_names=("FR_calf", "FL_calf", "RR_calf", "RL_calf"),
    initial_base_position=(0.0, 0.0, 0.43),
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
    stiffness=(20.0,) * 12,
    damping=(0.5,) * 12,
    effort_limits=(33.5,) * 12,
    contact=ContactDefaults(stiffness=2.0e3, damping=1.0e2),
    import_options=ImportOptions(preserve_inertias=True),
)
