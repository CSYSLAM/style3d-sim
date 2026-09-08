"""Unitree H1 robot specification."""

from .base import AssetSpec, ContactDefaults, ImportOptions, RobotSpec


JOINT_NAMES = (
    "left_hip_yaw_joint",
    "left_hip_roll_joint",
    "left_hip_pitch_joint",
    "left_knee_joint",
    "left_ankle_joint",
    "right_hip_yaw_joint",
    "right_hip_roll_joint",
    "right_hip_pitch_joint",
    "right_knee_joint",
    "right_ankle_joint",
    "torso_joint",
    "left_shoulder_pitch_joint",
    "left_shoulder_roll_joint",
    "left_shoulder_yaw_joint",
    "left_elbow_joint",
    "right_shoulder_pitch_joint",
    "right_shoulder_roll_joint",
    "right_shoulder_yaw_joint",
    "right_elbow_joint",
)

SPEC = RobotSpec(
    name="h1",
    asset=AssetSpec(
        newton_package="unitree_h1",
        relative_path="mjcf/h1.xml",
        importer="mjcf",
    ),
    joint_names=JOINT_NAMES,
    root_body_name="pelvis",
    foot_names=("left", "right"),
    foot_body_names=("left_ankle_link", "right_ankle_link"),
    initial_base_position=(0.0, 0.0, 1.1),
    initial_base_quaternion_xyzw=(0.0, 0.0, 0.0, 1.0),
    default_joint_positions=(0.0,) * len(JOINT_NAMES),
    stiffness=(150.0,) * len(JOINT_NAMES),
    damping=(5.0,) * len(JOINT_NAMES),
    contact=ContactDefaults(stiffness=2.0e3, damping=1.0e2),
    import_options=ImportOptions(
        hide_collision_shapes=False,
        mesh_approximation="bounding_box",
    ),
)
