// 从 PTX 形参类型 + mangled 名还原的精确原型（参数名不可恢复）
// 类型已归一化：glm::vec<3,float,(glm::qualifier)0> -> glm::vec3，unsigned long -> size_t
// 行尾 SASS 指令数用于判断体量；可按模块逐个与源码对签。

#include <glm/glm.hpp>
#include <cstddef>

// ===================== solver_newton.cu =====================
synreal::kernel::add_affine_body_constitutive_preconditioner(glm::vec3 const*, glm::ivec4 const*, float const*, float, synreal::AffineBodyRigidityModel, glm::mat3*, size_t, size_t, size_t);   // SASS 916
synreal::kernel::add_affine_body_so3_augmented_lagrangian_preconditioner(glm::ivec4 const*, float const*, glm::mat3 const*, float, glm::mat3*, size_t, size_t, size_t);   // SASS 404
synreal::kernel::add_affine_body_spring_gauss_newton_hessian(glm::vec3 const*, glm::ivec4 const*, float const*, float, glm::mat3*, int const*, synreal::BlockNonZeroEntry*, size_t, size_t, size_t, size_t, size_t);   // SASS 1256
synreal::kernel::add_bending_damping_preconditioner(glm::vec3 const*, float const*, glm::vec4 const*, glm::ivec4 const*, glm::vec2 const*, float, glm::mat3*, size_t, size_t, size_t);   // SASS 588
synreal::kernel::add_body_point_line_gauss_newton_hessian(glm::vec3 const*, glm::ivec4 const*, glm::ivec2 const*, glm::vec4 const*, glm::vec4 const*, glm::vec4 const*, glm::vec3 const*, glm::vec3 const*, float const*, float, size_t, bool, glm::mat3*, int const*, synreal::BlockNonZeroEntry*, size_t, size_t, size_t, size_t, size_t);   // SASS 1280
synreal::kernel::add_body_spring_gauss_newton_hessian(glm::vec3 const*, glm::ivec4 const*, glm::ivec2 const*, glm::vec3 const*, glm::vec3 const*, glm::vec4 const*, glm::vec4 const*, float const*, float const*, glm::mat3*, int const*, synreal::BlockNonZeroEntry*, size_t, size_t, size_t, size_t, size_t);   // SASS 1976
synreal::kernel::add_cloth_membrane_gauss_newton_hessian(glm::vec3 const*, glm::ivec3 const*, glm::mat2 const*, float const*, glm::vec3 const*, glm::mat3*, int const*, synreal::BlockNonZeroEntry*, size_t, size_t, size_t, size_t, size_t);   // SASS 1180
synreal::kernel::add_joint_body_point_line_augmented_lagrangian_preconditioner(glm::ivec4 const*, glm::ivec2 const*, glm::vec4 const*, glm::vec4 const*, glm::vec4 const*, float const*, float const*, glm::mat3 const*, float, glm::mat3*, size_t, size_t, size_t, size_t);   // SASS 452
synreal::kernel::add_joint_body_point_line_gauss_newton_hessian(glm::ivec4 const*, glm::ivec2 const*, glm::vec4 const*, glm::vec4 const*, glm::vec4 const*, float const*, float const*, glm::mat3 const*, float, glm::mat3*, int const*, synreal::BlockNonZeroEntry*, size_t, size_t, size_t, size_t, size_t, size_t);   // SASS 1804
synreal::kernel::add_joint_drive_preconditioner(glm::vec3 const*, glm::ivec4 const*, int const*, glm::ivec2 const*, glm::vec3 const*, glm::vec3 const*, glm::vec3 const*, glm::vec4 const*, glm::vec4 const*, glm::vec4 const*, glm::vec4 const*, glm::vec4 const*, int const*, int const*, float const*, float const*, float, glm::mat3*, size_t, size_t, size_t);   // SASS 1344
synreal::kernel::add_rolling_contact_preconditioner(synreal::kernel::RollingContactView, glm::mat3*);   // SASS 3272
synreal::kernel::add_spring_gauss_newton_hessian(glm::vec3 const*, glm::ivec2 const*, float const*, float const*, glm::mat3*, int const*, synreal::BlockNonZeroEntry*, size_t, size_t, size_t, size_t, size_t);   // SASS 580
synreal::kernel::add_surface_contact_preconditioner(synreal::kernel::SurfaceContactView, glm::mat3*);   // SASS 3156
synreal::kernel::add_surface_contact_stiffness_scale(synreal::kernel::SurfaceContactView, float*);   // SASS 2836
synreal::kernel::add_tetrahedron_preconditioner(glm::vec3 const*, glm::ivec4 const*, glm::mat3 const*, glm::vec3 const*, float const*, float, glm::mat3*, size_t, size_t, size_t);   // SASS 676
synreal::kernel::add_triangle_drag_preconditioner(glm::ivec3 const*, glm::vec3 const*, float const*, glm::mat3*, size_t, size_t, size_t);   // SASS 248
synreal::kernel::apply_affine_body_preconditioner(glm::ivec4 const*, float const*, int const*, glm::vec3 const*, glm::vec3*, size_t, size_t, size_t);   // SASS 500
synreal::kernel::apply_affine_body_torques(glm::vec3 const*, glm::ivec4 const*, glm::mat3 const*, glm::vec3 const*, glm::vec3*, size_t, size_t, size_t);   // SASS 428
synreal::kernel::apply_block_diagonal_preconditioner(glm::mat3 const*, glm::vec3 const*, glm::vec3*, size_t);   // SASS 48
synreal::kernel::apply_nonlinear_step(glm::vec3 const*, glm::vec3*, glm::vec3*, size_t);   // SASS 36
synreal::kernel::combine_system_non_diagonal(float, float, float, float, float, float, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry*, size_t);   // SASS 36
synreal::kernel::evaluate_affine_body_constitutive_force(glm::vec3 const*, glm::ivec4 const*, float const*, float, synreal::AffineBodyRigidityModel, glm::vec3*, size_t, size_t, size_t);   // SASS 772
synreal::kernel::evaluate_affine_body_so3_augmented_lagrangian_force(glm::vec3 const*, glm::ivec4 const*, float const*, glm::mat3 const*, glm::mat3 const*, float, glm::vec3*, size_t, size_t, size_t);   // SASS 332
synreal::kernel::evaluate_affine_body_spring_force(glm::vec3 const*, glm::ivec4 const*, float const*, float, glm::vec3*, size_t, size_t, size_t);   // SASS 648
synreal::kernel::evaluate_angular_limits(synreal::kernel::JointCoordinateView, synreal::kernel::AngularLimitView, glm::vec3 const*, glm::vec3 const*, float const*, int const*, float, glm::vec3 const*, glm::vec3*, glm::mat3*);   // SASS 1836
synreal::kernel::evaluate_bending_force(glm::vec3 const*, glm::vec3 const*, float const*, glm::vec4 const*, glm::ivec4 const*, glm::vec2 const*, float, glm::vec3*, size_t, size_t, size_t);   // SASS 512
synreal::kernel::evaluate_body_distance_constraint_force(glm::vec3 const*, glm::ivec4 const*, glm::ivec2 const*, glm::vec3 const*, glm::vec3 const*, glm::vec4 const*, glm::vec4 const*, float const*, glm::vec3 const*, glm::vec3 const*, float, glm::vec3*, size_t, size_t, size_t);   // SASS 440
synreal::kernel::evaluate_body_point_line_force(glm::vec3 const*, glm::vec3 const*, glm::ivec4 const*, glm::ivec2 const*, glm::vec4 const*, glm::vec4 const*, glm::vec4 const*, glm::vec3 const*, glm::vec3 const*, float const*, float const*, float, size_t, bool, glm::vec3*, size_t, size_t, size_t);   // SASS 564
synreal::kernel::evaluate_body_spring_force(glm::vec3 const*, glm::ivec4 const*, glm::ivec2 const*, glm::vec3 const*, glm::vec3 const*, glm::vec4 const*, glm::vec4 const*, float const*, float const*, float, size_t, bool, glm::vec3*, size_t, size_t, size_t);   // SASS 608
synreal::kernel::evaluate_cables(synreal::kernel::CableView, glm::vec3 const*, glm::vec3 const*, float, glm::vec3 const*, glm::vec3*, glm::mat3*);   // SASS 10628
synreal::kernel::evaluate_contact_force(int const*, size_t, int const*, int const*, glm::vec3 const*, glm::vec3 const*, glm::vec3 const*, glm::vec3 const*, glm::vec3 const*, float const*, float const*, int const*, int const*, synreal::Transform const*, glm::vec3 const*, float const*, float const*, float const*, float const*, float, size_t, size_t, size_t, int const*, glm::ivec4 const*, glm::vec3 const*, size_t, size_t, glm::vec3 const*, glm::vec3 const*, glm::vec3 const*, float, glm::vec3*, float*);   // SASS 2632
synreal::kernel::evaluate_contact_tangent(int const*, size_t, int const*, int const*, glm::vec3 const*, glm::vec3 const*, glm::vec3 const*, glm::vec3 const*, glm::vec3 const*, float const*, float const*, int const*, int const*, synreal::Transform const*, glm::vec3 const*, float const*, float const*, float const*, float const*, float, size_t, size_t, size_t, int const*, glm::ivec4 const*, glm::vec3 const*, size_t, glm::vec3 const*, glm::vec3 const*, glm::vec3 const*, glm::vec3*, float, size_t, glm::mat3*, glm::mat3*);   // SASS 4024
synreal::kernel::evaluate_hard_contacts(synreal::kernel::HardContactView, glm::vec3*, float*, glm::vec3 const*, glm::vec3*, glm::mat3*, glm::mat3*, float*);   // SASS 6064
synreal::kernel::evaluate_joint_armature(synreal::kernel::JointCoordinateView, float const*, glm::vec3 const*, glm::vec3 const*, float const*, float, glm::vec3 const*, glm::vec3*, glm::mat3*);   // SASS 2000
synreal::kernel::evaluate_joint_body_point_line_augmented_lagrangian_force(glm::vec3 const*, glm::ivec4 const*, glm::ivec2 const*, glm::vec4 const*, glm::vec4 const*, glm::vec4 const*, glm::vec3 const*, glm::vec3 const*, float const*, float const*, glm::vec3 const*, glm::mat3 const*, float, glm::vec3*, size_t, size_t, size_t, size_t);   // SASS 540
synreal::kernel::evaluate_joint_body_spring_augmented_lagrangian_force(glm::vec3 const*, glm::ivec4 const*, glm::ivec2 const*, glm::vec3 const*, glm::vec3 const*, glm::vec4 const*, glm::vec4 const*, float const*, glm::vec3 const*, float, glm::vec3*, size_t, size_t, size_t, size_t);   // SASS 436
synreal::kernel::evaluate_joint_drive_load(glm::vec3 const*, glm::vec3 const*, float const*, float*, int*, glm::ivec4 const*, int const*, glm::ivec2 const*, glm::vec3 const*, glm::vec3 const*, glm::vec3 const*, glm::vec4 const*, glm::vec4 const*, glm::vec4 const*, glm::vec4 const*, glm::vec4 const*, int const*, int const*, float const*, float const*, float const*, int const*, float const*, float const*, float const*, float const*, glm::vec3*, size_t, size_t, size_t, size_t, size_t, float);   // SASS 1808
synreal::kernel::evaluate_rolling_contact_force(synreal::kernel::RollingContactView, glm::vec3*);   // SASS 3332
synreal::kernel::evaluate_soft_contact_force(int const*, size_t, int const*, int const*, glm::vec3 const*, glm::vec3 const*, glm::vec3 const*, float const*, float const*, int const*, size_t, size_t, int const*, int const*, synreal::Transform const*, glm::vec3 const*, float const*, float const*, float const*, float const*, float const*, size_t, size_t, size_t, float, float, float, float, int const*, glm::ivec4 const*, glm::vec3 const*, size_t, glm::vec3 const*, glm::vec3 const*, glm::vec3 const*, float, glm::vec3*, float*, int const*, size_t, glm::mat3*, glm::mat3*);   // SASS 1836
synreal::kernel::evaluate_spring_force(glm::vec3 const*, glm::ivec2 const*, float const*, float const*, glm::vec3*, size_t, size_t, size_t);   // SASS 352
synreal::kernel::evaluate_stretch_force(glm::vec3 const*, float const*, glm::mat2 const*, glm::ivec3 const*, glm::vec3 const*, glm::vec3*, size_t, size_t, size_t);   // SASS 636
synreal::kernel::evaluate_surface_contact_force(synreal::kernel::SurfaceContactView, glm::vec3*);   // SASS 2984
synreal::kernel::evaluate_tetrahedron_force(glm::vec3 const*, glm::vec3 const*, glm::ivec4 const*, glm::mat3 const*, glm::vec3 const*, float const*, float const*, float, glm::vec3*, size_t, size_t, size_t);   // SASS 720
synreal::kernel::evaluate_triangle_drag(glm::vec3 const*, glm::vec3 const*, glm::ivec3 const*, float const*, glm::vec3 const*, float const*, float, glm::vec3, float, glm::vec3*, float*, size_t, size_t, size_t);   // SASS 400
synreal::kernel::initialize_affine_body_so3_state(glm::vec3 const*, glm::ivec4 const*, glm::mat3*, glm::mat3*, size_t, size_t, size_t);   // SASS 644
synreal::kernel::initialize_block_diagonal(float const*, glm::mat3*, glm::mat3*, size_t);   // SASS 44
synreal::kernel::initialize_block_non_diagonal(synreal::NonZeroEntry const*, int const*, size_t, size_t, synreal::BlockNonZeroEntry*, size_t);   // SASS 356
synreal::kernel::initialize_body_distance_constraint_state(glm::vec3 const*, glm::ivec4 const*, glm::ivec2 const*, glm::vec3 const*, glm::vec3 const*, glm::vec4 const*, glm::vec4 const*, float const*, glm::vec3*, glm::vec3*, size_t, size_t, size_t);   // SASS 440
synreal::kernel::initialize_hard_contacts(synreal::kernel::HardContactView);   // SASS 2072
synreal::kernel::initialize_joint_body_point_line_state(glm::vec3 const*, glm::ivec4 const*, glm::ivec2 const*, glm::vec4 const*, glm::vec4 const*, glm::vec4 const*, glm::vec3 const*, glm::vec3 const*, float*, glm::vec3*, glm::mat3*, size_t, size_t, size_t, size_t);   // SASS 560
synreal::kernel::initialize_joint_body_spring_state(glm::vec3*, size_t);   // SASS 28
synreal::kernel::initialize_joint_coordinate_velocities(synreal::kernel::JointCoordinateView, glm::vec3 const*, glm::vec3 const*, float*);   // SASS 1064
synreal::kernel::initialize_rhs(float, glm::vec3 const*, glm::vec3 const*, float const*, int const*, synreal::NonZeroEntry const*, size_t, glm::vec3 const*, int const*, glm::vec3*, size_t, size_t);   // SASS 420
synreal::kernel::initialize_step(float, glm::vec3 const*, size_t, int const*, glm::vec3 const*, glm::vec3*, float const*, float const*, float, float const*, float, float const*, float, float const*, float, float const*, float, float const*, int const*, int const*, glm::vec3*, glm::vec3*, float*, size_t, size_t);   // SASS 472
synreal::kernel::initialize_triangle_drag(glm::vec3 const*, glm::ivec3 const*, glm::vec3*, float*, size_t, size_t, size_t);   // SASS 356
synreal::kernel::invert_block_preconditioner(glm::mat3 const*, float const*, int const*, glm::mat3*, size_t, size_t);   // SASS 304
synreal::kernel::multiply_affine_body_constitutive_tangent(glm::vec3 const*, glm::vec3 const*, glm::ivec4 const*, float const*, float, synreal::AffineBodyRigidityModel, glm::vec3*, size_t, size_t, size_t);   // SASS 784
synreal::kernel::multiply_affine_body_so3_augmented_lagrangian_tangent(glm::vec3 const*, glm::ivec4 const*, float const*, glm::mat3 const*, float, glm::vec3*, size_t, size_t, size_t);   // SASS 300
synreal::kernel::multiply_bending_damping_tangent(glm::vec3 const*, glm::vec3 const*, float const*, glm::vec4 const*, glm::ivec4 const*, glm::vec2 const*, float, glm::vec3*, size_t, size_t, size_t);   // SASS 616
synreal::kernel::multiply_joint_body_point_line_augmented_lagrangian(glm::vec3 const*, glm::ivec4 const*, glm::ivec2 const*, glm::vec4 const*, glm::vec4 const*, glm::vec4 const*, float const*, float const*, glm::mat3 const*, float, glm::vec3*, size_t, size_t, size_t, size_t);   // SASS 448
synreal::kernel::multiply_joint_drive_tangent(glm::vec3 const*, glm::vec3 const*, glm::ivec4 const*, int const*, glm::ivec2 const*, glm::vec3 const*, glm::vec3 const*, glm::vec3 const*, glm::vec4 const*, glm::vec4 const*, glm::vec4 const*, glm::vec4 const*, glm::vec4 const*, int const*, int const*, float const*, float const*, float, glm::vec3*, size_t, size_t, size_t);   // SASS 1496
synreal::kernel::multiply_rolling_contact_tangent(synreal::kernel::RollingContactView, glm::vec3 const*, glm::vec3*);   // SASS 3484
synreal::kernel::multiply_soft_contact_hessian_off_diagonal(int const*, size_t, int const*, int const*, glm::vec3 const*, glm::vec3 const*, float const*, int const*, int const*, synreal::Transform const*, glm::vec3 const*, float const*, int const*, float const*, float const*, float const*, size_t, size_t, size_t, int const*, glm::ivec4 const*, glm::vec3 const*, size_t, glm::vec3 const*, glm::vec3 const*, glm::vec3*, float, size_t, float, float, size_t, int const*, size_t, float const*, float const*, float, float, glm::vec3 const*, glm::vec3 const*);   // SASS 1776
synreal::kernel::multiply_surface_contact_tangent(synreal::kernel::SurfaceContactView, glm::vec3 const*, glm::vec3*);   // SASS 3280
synreal::kernel::multiply_tetrahedron_tangent(glm::vec3 const*, glm::vec3 const*, glm::ivec4 const*, glm::mat3 const*, glm::vec3 const*, float const*, float, glm::vec3*, size_t, size_t, size_t);   // SASS 616
synreal::kernel::multiply_triangle_drag_tangent(glm::vec3 const*, glm::ivec3 const*, glm::vec3 const*, float const*, glm::vec3*, size_t, size_t, size_t);   // SASS 260
synreal::kernel::prepare_cable_penalties(glm::vec4 const*, glm::vec4*, int*, size_t, size_t, float, float, float, float, float, bool, bool, int const*);   // SASS 200
synreal::kernel::prepare_cable_tangents(synreal::kernel::CableView, glm::vec3 const*);   // SASS 5368
synreal::kernel::prepare_inverse_preconditioner(float const*, float const*, int const*, float*, size_t, size_t);   // SASS 212
synreal::kernel::refresh_inertial_cache_diagonals(float const*, size_t const*, int const*, float*, float*, size_t);   // SASS 236
synreal::kernel::refresh_inertial_cache_nonzeros(float const*, size_t const*, int const*, float const*, size_t const*, int const*, synreal::NonZeroEntry*, synreal::NonZeroEntry*, size_t);   // SASS 452
synreal::kernel::reset_selected_joint_drive_state(int const*, int*, size_t);   // SASS 24
synreal::kernel::snapshot_hard_contacts(synreal::kernel::HardContactView);   // SASS 192
synreal::kernel::update_affine_body_so3_augmented_lagrangian_state(glm::vec3 const*, glm::ivec4 const*, glm::mat3*, glm::mat3*, bool, size_t, size_t, size_t);   // SASS 720
synreal::kernel::update_body_distance_constraint_state(glm::vec3 const*, glm::ivec4 const*, glm::ivec2 const*, glm::vec3 const*, glm::vec3 const*, glm::vec4 const*, glm::vec4 const*, float const*, glm::vec3*, glm::vec3*, size_t, size_t, size_t);   // SASS 476
synreal::kernel::update_cable_penalties(synreal::kernel::CableView, glm::vec3 const*, float, float);   // SASS 3444
synreal::kernel::update_hard_contact_duals(synreal::kernel::HardContactView);   // SASS 2188
synreal::kernel::update_joint_body_point_line_augmented_lagrangian_state(glm::vec3 const*, glm::ivec4 const*, glm::ivec2 const*, glm::vec4 const*, glm::vec4 const*, glm::vec4 const*, glm::vec3 const*, glm::vec3 const*, float*, glm::vec3*, glm::mat3*, bool, size_t, size_t, size_t, size_t);   // SASS 676
synreal::kernel::update_joint_body_spring_augmented_lagrangian_state(glm::vec3 const*, glm::ivec4 const*, glm::ivec2 const*, glm::vec3 const*, glm::vec3 const*, glm::vec4 const*, glm::vec4 const*, glm::vec3*, size_t, size_t, size_t, size_t);   // SASS 332
synreal::kernel::update_joint_drive_angle_state(glm::vec3 const*, float*, int*, glm::ivec4 const*, int const*, glm::ivec2 const*, glm::vec3 const*, glm::vec3 const*, glm::vec3 const*, glm::vec4 const*, glm::vec4 const*, glm::vec4 const*, glm::vec4 const*, glm::vec4 const*, size_t, size_t, size_t);   // SASS 804
synreal::kernel::update_velocity(float, glm::vec3 const*, glm::vec3 const*, glm::vec3*, size_t);   // SASS 36
void synreal::kernel::build_affine_body_preconditioner<synreal::BlockNonZeroEntry>(glm::ivec4 const*, float const*, float const*, int const*, glm::mat3 const*, int const*, synreal::BlockNonZeroEntry const*, size_t, size_t, glm::mat3 const*, float, synreal::kernel::CableView, size_t const*, int const*, float, int const*, float const*, float*, int*, size_t, size_t, size_t);   // SASS 4120
void synreal::kernel::build_affine_body_preconditioner<synreal::NonZeroEntry>(glm::ivec4 const*, float const*, float const*, int const*, glm::mat3 const*, int const*, synreal::NonZeroEntry const*, size_t, size_t, glm::mat3 const*, float, synreal::kernel::CableView, size_t const*, int const*, float, int const*, float const*, float*, int*, size_t, size_t, size_t);   // SASS 4008
void thrust::THRUST_200302_520_NS::cuda_cub::core::_kernel_agent<thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::ParallelForAgent<thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<synreal::BlockNonZeroEntry>, synreal::BlockNonZeroEntry>, unsigned long>, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<synreal::BlockNonZeroEntry>, synreal::BlockNonZeroEntry>, unsigned long>(thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<synreal::BlockNonZeroEntry>, synreal::BlockNonZeroEntry>, size_t);   // SASS 76
void thrust::THRUST_200302_520_NS::cuda_cub::core::_kernel_agent<thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::ParallelForAgent<thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<synreal::NonZeroEntry>, synreal::NonZeroEntry>, unsigned long>, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<synreal::NonZeroEntry>, synreal::NonZeroEntry>, unsigned long>(thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<synreal::NonZeroEntry>, synreal::NonZeroEntry>, size_t);   // SASS 32

// ===================== fluid.cu =====================
synreal::fluid_kernel::accumulate_rows(synreal::fluid_kernel::View, glm::vec3 const*, float const*, float const*, glm::vec3 const*, glm::vec3*, glm::mat3*);   // SASS 620
synreal::fluid_kernel::add_diagonal(glm::mat3 const*, glm::mat3*, int);   // SASS 48
synreal::fluid_kernel::bound_scale(synreal::fluid_kernel::View, glm::vec3 const*, float, float, float*);   // SASS 160
synreal::fluid_kernel::build_grid(synreal::Model, glm::vec3 const*, glm::vec3*, float*, int*, int*, glm::ivec3*, int*, int*, int, int);   // SASS 232
synreal::fluid_kernel::evaluate_rows(synreal::fluid_kernel::View, glm::vec3*, float*, float*, int*, int*, glm::vec4*);   // SASS 440
synreal::fluid_kernel::initialize_scale(float*, float, int);   // SASS 16
synreal::fluid_kernel::multiply_rows(synreal::fluid_kernel::View, glm::vec3 const*, float const*, glm::vec3 const*, glm::vec3*);   // SASS 868
synreal::fluid_kernel::scale_step(synreal::Model, glm::vec3*, float const*, int);   // SASS 52

// ===================== granular.cu =====================
synreal::granular_kernel::accumulate_bonds(synreal::Model, glm::vec3 const*, glm::vec3 const*, float, glm::ivec2 const*, float const*, float const*, int const*, int, float, glm::vec3*, glm::mat3*, glm::mat3*);   // SASS 340
synreal::granular_kernel::accumulate_contacts(synreal::granular_kernel::View, glm::vec3*, glm::mat3*, int*, int*, glm::vec4*);   // SASS 496
synreal::granular_kernel::add_diagonal(glm::mat3 const*, glm::mat3*, int);   // SASS 48
synreal::granular_kernel::build_grid(synreal::Model, glm::vec3 const*, glm::vec3 const*, synreal::granular_kernel::View, glm::vec3*, glm::vec3*, float*, int*, int*, glm::ivec3*, int*, int*);   // SASS 212
synreal::granular_kernel::commit_bonds(synreal::Model, glm::vec3 const*, glm::ivec2 const*, float const*, float*, int*, int);   // SASS 80
synreal::granular_kernel::form_bonds(synreal::Model, synreal::granular_kernel::View, int const*, int const*, int*, glm::ivec2*, float*, float*, int*);   // SASS 660
synreal::granular_kernel::multiply_bonds(glm::ivec2 const*, int const*, glm::mat3 const*, int, glm::vec3 const*, glm::vec3*);   // SASS 80
synreal::granular_kernel::multiply_contacts(synreal::granular_kernel::View, glm::vec3 const*, glm::vec3*);   // SASS 652

// ===================== pcg_solver.cu =====================
synreal::kernel::update_preconditioned_cg_direction(int, glm::vec3 const*, float const*, glm::vec3*, size_t);   // SASS 116
synreal::kernel::update_solution_and_residual(int, float const*, float const*, glm::vec3 const*, glm::vec3 const*, glm::vec3*, glm::vec3*, size_t);   // SASS 124
void synreal::kernel::evaluate_residual<synreal::BlockNonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >(int const*, synreal::BlockNonZeroEntry const*, size_t, glm::mat3 const*, glm::vec3 const*, glm::vec3 const*, glm::vec3 const*, glm::vec3*, size_t, size_t);   // SASS 412
void synreal::kernel::evaluate_residual<synreal::NonZeroEntry, float>(int const*, synreal::NonZeroEntry const*, size_t, float const*, glm::vec3 const*, glm::vec3 const*, glm::vec3 const*, glm::vec3*, size_t, size_t);   // SASS 356
void synreal::kernel::evaluate_residual<synreal::NonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >(int const*, synreal::NonZeroEntry const*, size_t, glm::mat3 const*, glm::vec3 const*, glm::vec3 const*, glm::vec3 const*, glm::vec3*, size_t, size_t);   // SASS 376
void synreal::kernel::initialize_zero_solution_and_reduce<256u, glm::mat<3, 3, float, (glm::qualifier)0> >(glm::vec3 const*, glm::mat3 const*, glm::vec3*, glm::vec3*, float*, size_t);   // SASS 88
void synreal::kernel::multiply_matrix<synreal::NonZeroEntry, float>(int const*, synreal::NonZeroEntry const*, size_t, float const*, glm::vec3 const*, glm::vec3 const*, glm::vec3*, size_t, size_t);   // SASS 352
void synreal::kernel::multiply_matrix<synreal::NonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >(int const*, synreal::NonZeroEntry const*, size_t, glm::mat3 const*, glm::vec3 const*, glm::vec3 const*, glm::vec3*, size_t, size_t);   // SASS 368
void synreal::kernel::multiply_matrix_and_reduce<256u, synreal::BlockNonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >(int const*, synreal::BlockNonZeroEntry const*, size_t, glm::mat3 const*, glm::vec3 const*, glm::vec3 const*, glm::vec3*, float*, size_t, size_t);   // SASS 436
void synreal::kernel::update_cg_direction<float>(int, float const*, glm::vec3 const*, float const*, glm::vec3*, size_t);   // SASS 116
void synreal::kernel::update_cg_direction<glm::mat<3, 3, float, (glm::qualifier)0> >(int, glm::mat3 const*, glm::vec3 const*, float const*, glm::vec3*, size_t);   // SASS 136
void synreal::kernel::update_solution_residual_and_reduce<256u, glm::mat<3, 3, float, (glm::qualifier)0> >(int, float const*, float const*, glm::vec3 const*, glm::vec3 const*, glm::mat3 const*, glm::vec3*, glm::vec3*, float*, bool, size_t);   // SASS 188

// ===================== self_collision.cu =====================
synreal::self_collision_kernel::accumulate_edge_edge(glm::vec3 const*, glm::ivec4 const*, int const*, int const*, int const*, int const*, float const*, float, float, glm::vec3*, glm::mat3*, synreal::SelfCollisionContactTangent*, unsigned int*, size_t, size_t, size_t, int);   // SASS 868
synreal::self_collision_kernel::accumulate_edge_face(glm::vec3 const*, glm::ivec4 const*, int const*, int const*, glm::ivec3 const*, int const*, int const*, float const*, float, float, glm::vec3*, glm::mat3*, synreal::SelfCollisionContactTangent*, unsigned int*, size_t, size_t, size_t, int);   // SASS 1160
synreal::self_collision_kernel::accumulate_particle_pairs(glm::vec3 const*, int const*, float const*, int const*, int const*, float const*, float, glm::vec3*, glm::mat3*, synreal::SelfCollisionContactTangent*, unsigned int*, size_t, size_t, size_t, int);   // SASS 552
synreal::self_collision_kernel::accumulate_vertex_face(glm::vec3 const*, int const*, float const*, glm::ivec3 const*, int const*, int const*, float const*, float, float, bool, float, glm::vec3*, glm::mat3*, synreal::SelfCollisionContactTangent*, unsigned int*, size_t, size_t, size_t, int);   // SASS 788
synreal::self_collision_kernel::add_hessian_diagonal(glm::mat3 const*, glm::mat3*, size_t);   // SASS 48
synreal::self_collision_kernel::build_edge_aabbs(glm::vec3 const*, glm::ivec4 const*, synreal::Aabb*, float, size_t, size_t, size_t);   // SASS 216
synreal::self_collision_kernel::build_particle_aabbs(glm::vec3 const*, int const*, float const*, synreal::Aabb*, size_t, size_t, size_t);   // SASS 216
synreal::self_collision_kernel::build_triangle_aabbs(glm::vec3 const*, glm::ivec3 const*, synreal::Aabb*, float, size_t, size_t, size_t);   // SASS 236
synreal::self_collision_kernel::multiply_contact_tangents(synreal::SelfCollisionContactTangent const*, unsigned int const*, glm::vec3 const*, glm::vec3*);   // SASS 260
synreal::self_collision_kernel::multiply_hessian_diagonal(glm::mat3 const*, glm::vec3 const*, glm::vec3*, size_t);   // SASS 56
synreal::self_collision_kernel::query_edge_edge(glm::vec3 const*, glm::ivec4 const*, int const*, synreal::Aabb const*, int const*, glm::ivec2 const*, int const*, float, int*, int*, size_t, size_t, size_t, int);   // SASS 548
synreal::self_collision_kernel::query_edge_face(glm::vec3 const*, glm::ivec4 const*, glm::ivec3 const*, int const*, synreal::Aabb const*, int const*, glm::ivec2 const*, int const*, float, int*, int*, size_t, size_t, size_t, size_t, int);   // SASS 432
synreal::self_collision_kernel::query_particle_pairs(glm::vec3 const*, int const*, float const*, int const*, int const*, synreal::Aabb const*, int const*, glm::ivec2 const*, int const*, int const*, int const*, int*, int*, size_t, size_t, size_t, int);   // SASS 448
synreal::self_collision_kernel::query_vertex_face(glm::vec3 const*, int const*, float const*, glm::ivec3 const*, int const*, synreal::Aabb const*, int const*, glm::ivec2 const*, int const*, float, float, bool, int*, int*, size_t, size_t, size_t, size_t, int);   // SASS 684
synreal::self_collision_kernel::refit_bvh(synreal::Aabb const*, int const*, int const*, glm::ivec2 const*, unsigned int*, synreal::Aabb*, size_t, size_t);   // SASS 308
void thrust::THRUST_200302_520_NS::cuda_cub::core::_kernel_agent<thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::ParallelForAgent<thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<synreal::Aabb>, synreal::Aabb>, unsigned long>, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<synreal::Aabb>, synreal::Aabb>, unsigned long>(thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<synreal::Aabb>, synreal::Aabb>, size_t);   // SASS 60

// ===================== lbvh_builder.cu =====================
synreal::kernel::build_escape_nodes(int*, int const*, glm::ivec2 const*, unsigned int);   // SASS 24
synreal::kernel::build_primitive_leaf_nodes(int*, int const*, unsigned int);   // SASS 16
synreal::kernel::build_radix_tree(int*, glm::ivec2*, unsigned int const*, unsigned int);   // SASS 156
synreal::kernel::generate_morton_codes(unsigned int*, synreal::Aabb const*, synreal::Aabb, unsigned int);   // SASS 168
synreal::kernel::refit_aabbs(synreal::Aabb*, synreal::Aabb const*, int const*, int const*, glm::ivec2 const*, unsigned int*, unsigned int);   // SASS 92
