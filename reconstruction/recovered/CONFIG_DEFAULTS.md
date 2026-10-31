# 运行时导出的默认配置与枚举值

> 直接 import `_core` 读取，非推测。

## Config 默认值
affine_body_block_preconditioner = False
affine_body_contact_block_preconditioner = True
affine_body_rigidity_model = <AffineBodyRigidityModel.SO3_AUGMENTED_LAGRANGIAN: 3>
affine_body_rigidity_primal_iterations = 1
air_density = 1.225000023841858
cable_angular_beta = 0.0
cable_angular_k_start = 10.0
cable_linear_beta = 0.0
cable_linear_k_start = 100.0
cable_penalty_gamma = 0.9990000128746033
constraint_alpha = 100.0
enable_collision_hessian_non_diagonal = True
enable_self_collision = False
fluid_max_step_ratio = 0.25
fluid_relaxation = 0.5
inertia_mode = <InertiaMode.MIDPOINT_CAYLEY: 3>
joint_constraint_mode = <JointConstraintMode.AUGMENTED_LAGRANGIAN: 1>
joint_constraint_primal_iterations = 1
linear_iterations = 50
nonlinear_iterations = 5
nonlinear_solver = <NonlinearSolver.NEWTON: 0>
rigid_contact_alpha = 0.949999988079071
rigid_contact_beta = 0.0
rigid_contact_friction_epsilon = 0.0
rigid_contact_gamma = 0.9990000128746033
rigid_contact_hard = False
rigid_contact_history = False
rigid_contact_k_start = 100.0
rigid_contact_sliding_tangent = False
rolling_friction_velocity_epsilon = 0.10000000149011612
self_collision_edge_edge_stiffness = 0.10000000149011612
self_collision_edge_face_stiffness = 1.0
self_collision_particle_particle_stiffness = 1.0
self_collision_radius = 0.003000000026077032
self_collision_vertex_face_stiffness = 0.5
wind_velocity = (0.0, 0.0, 0.0)

## InertiaMode
EXPLICIT_EULER=0, IMPLICIT_EULER=1, LIE_GROUP_MIDPOINT=2, MIDPOINT_CAYLEY=3, NONE=4, VBD_SEMI_IMPLICIT=5

## JointConstraintMode
AUGMENTED_LAGRANGIAN=1, PENALTY=0

## NonlinearSolver
NEWTON=0, PD_NEWTON=1

## AffineBodyRigidityModel
ABD_ORTHOGONALITY=1, CO_ROTATED=0, SIX_SPRINGS=2, SO3_AUGMENTED_LAGRANGIAN=3

## LogLevel
DEBUG=2, ERROR=1, INFO=0, WARNING=4
