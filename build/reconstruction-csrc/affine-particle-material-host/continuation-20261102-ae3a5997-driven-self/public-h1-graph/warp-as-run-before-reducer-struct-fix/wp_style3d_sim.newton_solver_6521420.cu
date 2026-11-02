#define WP_NO_BFLOAT16

#define WP_TILE_BLOCK_DIM 256
#define WP_NO_CRT
#include "builtin.h"
#include "deterministic.h"

// Map wp.breakpoint() to a device brkpt at the call site so cuda-gdb attributes the stop to the generated .cu line
#if defined(__CUDACC__) && !defined(_MSC_VER)
#define __debugbreak() __brkpt()
#endif

// avoid namespacing of float type for casting to float type, this is to avoid wp::float(x), which is not valid in C++
#define float(x) cast_float(x)
#define adj_float(x, adj_x, adj_ret) adj_cast_float(x, adj_x, adj_ret)

#define int(x) cast_int(x)
#define adj_int(x, adj_x, adj_ret) adj_cast_int(x, adj_x, adj_ret)

#define builtin_tid1d() wp::tid(_idx, dim)
#define builtin_tid2d(x, y) wp::tid(x, y, _idx, dim)
#define builtin_tid3d(x, y, z) wp::tid(x, y, z, _idx, dim)
#define builtin_tid4d(x, y, z, w) wp::tid(x, y, z, w, _idx, dim)

#define builtin_block_dim() wp::block_dim()

// CUDA Thread Block Cluster shape declaration. Expands to __cluster_dims__
// only on devices that support clusters (compute capability 9.0+); otherwise
// expands to nothing so the same source compiles cleanly for any target arch.
#if defined(__CUDA_ARCH__) && (__CUDA_ARCH__ >= 900)
#define WP_CLUSTER_DIMS(x, y, z) __cluster_dims__(x, y, z)
#else
#define WP_CLUSTER_DIMS(x, y, z)
#endif


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:58
static CUDA_CALLABLE wp::vec_t<3, wp::float32> _logarithmic_velocity_0(
    wp::mat_t<3, 3, wp::float32> var_relative_rotation,
    wp::float32 var_dt)
{
    //---------
    // primal vars
    wp::quat_t<wp::float32> var_0;
    const wp::int32 var_1 = 3;
    wp::float32 var_2;
    const wp::float32 var_3 = 0.0;
    bool var_4;
    const wp::int32 var_5 = 0;
    wp::float32 var_6;
    wp::float32 var_7;
    const wp::int32 var_8 = 1;
    wp::float32 var_9;
    wp::float32 var_10;
    const wp::int32 var_11 = 2;
    wp::float32 var_12;
    wp::float32 var_13;
    const wp::int32 var_14 = 3;
    wp::float32 var_15;
    wp::float32 var_16;
    wp::quat_t<wp::float32> var_17;
    wp::quat_t<wp::float32> var_18;
    wp::vec_t<3, wp::float32> var_19;
    wp::float32 var_20;
    wp::vec_t<3, wp::float32> var_21;
    wp::vec_t<3, wp::float32> var_22;
    //---------
    // forward
    // def _logarithmic_velocity(relative_rotation: wp.mat33, dt: float) -> wp.vec3:          <L 59>
    // rotation = wp.quat_from_matrix(relative_rotation)                                      <L 61>
    var_0 = wp::quat_from_matrix(var_relative_rotation);
    // if rotation[3] < 0.0:                                                                  <L 62>
    var_2 = wp::extract(var_0, var_1);
    var_4 = (var_2 < var_3);
    if (var_4) {
        // rotation = wp.quat(                                                                <L 63>
        // -rotation[0],                                                                      <L 64>
        var_6 = wp::extract(var_0, var_5);
        var_7 = wp::neg(var_6);
        // -rotation[1],                                                                      <L 65>
        var_9 = wp::extract(var_0, var_8);
        var_10 = wp::neg(var_9);
        // -rotation[2],                                                                      <L 66>
        var_12 = wp::extract(var_0, var_11);
        var_13 = wp::neg(var_12);
        // -rotation[3],                                                                      <L 67>
        var_15 = wp::extract(var_0, var_14);
        var_16 = wp::neg(var_15);
        var_17 = wp::quat_t<wp::float32>(var_7, var_10, var_13, var_16);
    }
    var_18 = wp::where(var_4, var_17, var_0);
    // axis, angle = wp.quat_to_axis_angle(rotation)                                          <L 69>
    wp::quat_to_axis_angle(var_18, var_19, var_20);
    // return axis * angle / dt                                                               <L 70>
    var_21 = wp::mul(var_19, var_20);
    var_22 = wp::div(var_21, var_dt);
    return var_22;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:247
static CUDA_CALLABLE wp::vec_t<3, wp::float32> recover_explicit_euler_end_velocity_0(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::mat_t<3, 3, wp::float32> var_relative_rotation,
    wp::float32 var_dt)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    wp::vec_t<3, wp::float32> var_1;
    wp::vec_t<3, wp::float32> var_2;
    wp::vec_t<3, wp::float32> var_3;
    wp::vec_t<3, wp::float32> var_4;
    wp::mat_t<3, 3, wp::float32> var_5;
    wp::vec_t<3, wp::float32> var_6;
    //---------
    // forward
    // def recover_explicit_euler_end_velocity(                                               <L 248>
    // initial_velocity = _logarithmic_velocity(relative_rotation, dt)                        <L 254>
    var_0 = _logarithmic_velocity_0(var_relative_rotation, var_dt);
    // initial_momentum = inertia * initial_velocity                                          <L 255>
    var_1 = wp::mul(var_inertia, var_0);
    // next_momentum = initial_momentum + dt * wp.cross(initial_momentum, initial_velocity)       <L 256>
    var_2 = wp::cross(var_1, var_0);
    var_3 = wp::mul(var_dt, var_2);
    var_4 = wp::add(var_1, var_3);
    // return wp.inverse(inertia) * next_momentum                                             <L 257>
    var_5 = wp::inverse(var_inertia);
    var_6 = wp::mul(var_5, var_4);
    return var_6;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:260
static CUDA_CALLABLE wp::vec_t<3, wp::float32> recover_implicit_euler_end_velocity_0(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::mat_t<3, 3, wp::float32> var_relative_rotation,
    wp::float32 var_dt)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    //---------
    // forward
    // def recover_implicit_euler_end_velocity(                                               <L 261>
    // return _logarithmic_velocity(relative_rotation, dt)                                    <L 267>
    var_0 = _logarithmic_velocity_0(var_relative_rotation, var_dt);
    return var_0;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:47
static CUDA_CALLABLE wp::mat_t<3, 3, wp::float32> _exponential_increment_0(
    wp::vec_t<3, wp::float32> var_angular_velocity,
    wp::float32 var_dt)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    wp::float32 var_1;
    const wp::float32 var_2 = 1e-08;
    bool var_3;
    wp::vec_t<3, wp::float32> var_4;
    wp::quat_t<wp::float32> var_5;
    wp::mat_t<3, 3, wp::float32> var_6;
    const wp::int32 var_7 = 3;
    wp::mat_t<3, 3, wp::float32> var_8;
    //---------
    // forward
    // def _exponential_increment(angular_velocity: wp.vec3, dt: float) -> wp.mat33:          <L 48>
    // rotation_vector = dt * angular_velocity                                                <L 50>
    var_0 = wp::mul(var_dt, var_angular_velocity);
    // angle = wp.length(rotation_vector)                                                     <L 51>
    var_1 = wp::length(var_0);
    // if angle > 1.0e-8:                                                                     <L 52>
    var_3 = (var_1 > var_2);
    if (var_3) {
        // rotation = wp.quat_from_axis_angle(rotation_vector / angle, angle)                 <L 53>
        var_4 = wp::div(var_0, var_1);
        var_5 = wp::quat_from_axis_angle(var_4, var_1);
        // return wp.quat_to_matrix(rotation)                                                 <L 54>
        var_6 = wp::quat_to_matrix(var_5);
        return var_6;
    }
    // return wp.identity(3, dtype=float)                                                     <L 55>
    var_8 = wp::identity<3, wp::float32>();
    return var_8;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:270
static CUDA_CALLABLE wp::vec_t<3, wp::float32> recover_lie_group_midpoint_end_velocity_0(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::mat_t<3, 3, wp::float32> var_relative_rotation,
    wp::float32 var_dt)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    const wp::float32 var_1 = 0.5;
    wp::float32 var_2;
    wp::mat_t<3, 3, wp::float32> var_3;
    wp::mat_t<3, 3, wp::float32> var_4;
    wp::mat_t<3, 3, wp::float32> var_5;
    wp::mat_t<3, 3, wp::float32> var_6;
    wp::vec_t<3, wp::float32> var_7;
    wp::mat_t<3, 3, wp::float32> var_8;
    wp::vec_t<3, wp::float32> var_9;
    wp::mat_t<3, 3, wp::float32> var_10;
    wp::vec_t<3, wp::float32> var_11;
    //---------
    // forward
    // def recover_lie_group_midpoint_end_velocity(                                           <L 271>
    // midpoint_velocity = _logarithmic_velocity(relative_rotation, dt)                       <L 277>
    var_0 = _logarithmic_velocity_0(var_relative_rotation, var_dt);
    // half_rotation = _exponential_increment(midpoint_velocity, 0.5 * dt)                    <L 278>
    var_2 = wp::mul(var_1, var_dt);
    var_3 = _exponential_increment_0(var_0, var_2);
    // initial_momentum = (                                                                   <L 279>
    // half_rotation * inertia * wp.transpose(half_rotation) * midpoint_velocity              <L 280>
    var_4 = wp::mul(var_3, var_inertia);
    var_5 = wp::transpose(var_3);
    var_6 = wp::mul(var_4, var_5);
    var_7 = wp::mul(var_6, var_0);
    // next_momentum = wp.transpose(relative_rotation) * initial_momentum                     <L 282>
    var_8 = wp::transpose(var_relative_rotation);
    var_9 = wp::mul(var_8, var_7);
    // return wp.inverse(inertia) * next_momentum                                             <L 283>
    var_10 = wp::inverse(var_inertia);
    var_11 = wp::mul(var_10, var_9);
    return var_11;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:286
static CUDA_CALLABLE wp::vec_t<3, wp::float32> recover_midpoint_cayley_end_velocity_0(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::mat_t<3, 3, wp::float32> var_relative_rotation,
    wp::float32 var_dt)
{
    //---------
    // primal vars
    const wp::int32 var_0 = 3;
    wp::mat_t<3, 3, wp::float32> var_1;
    const wp::float32 var_2 = 2.0;
    wp::mat_t<3, 3, wp::float32> var_3;
    wp::mat_t<3, 3, wp::float32> var_4;
    wp::mat_t<3, 3, wp::float32> var_5;
    wp::mat_t<3, 3, wp::float32> var_6;
    wp::mat_t<3, 3, wp::float32> var_7;
    const wp::float32 var_8 = 0.5;
    wp::mat_t<3, 3, wp::float32> var_9;
    wp::mat_t<3, 3, wp::float32> var_10;
    wp::mat_t<3, 3, wp::float32> var_11;
    const wp::int32 var_12 = 2;
    const wp::int32 var_13 = 1;
    wp::float32 var_14;
    const wp::int32 var_15 = 0;
    const wp::int32 var_16 = 2;
    wp::float32 var_17;
    const wp::int32 var_18 = 1;
    const wp::int32 var_19 = 0;
    wp::float32 var_20;
    wp::vec_t<3, wp::float32> var_21;
    wp::vec_t<3, wp::float32> var_22;
    wp::vec_t<3, wp::float32> var_23;
    const wp::float32 var_24 = 0.5;
    wp::float32 var_25;
    wp::vec_t<3, wp::float32> var_26;
    wp::vec_t<3, wp::float32> var_27;
    wp::vec_t<3, wp::float32> var_28;
    wp::mat_t<3, 3, wp::float32> var_29;
    wp::vec_t<3, wp::float32> var_30;
    //---------
    // forward
    // def recover_midpoint_cayley_end_velocity(                                              <L 287>
    // identity = wp.identity(3, dtype=float)                                                 <L 293>
    var_1 = wp::identity<3, wp::float32>();
    // generator = (                                                                          <L 294>
    // 2.0 * (relative_rotation - identity) * wp.inverse(relative_rotation + identity)        <L 295>
    var_3 = wp::sub(var_relative_rotation, var_1);
    var_4 = wp::mul(var_2, var_3);
    var_5 = wp::add(var_relative_rotation, var_1);
    var_6 = wp::inverse(var_5);
    var_7 = wp::mul(var_4, var_6);
    // generator = 0.5 * (generator - wp.transpose(generator))                                <L 297>
    var_9 = wp::transpose(var_7);
    var_10 = wp::sub(var_7, var_9);
    var_11 = wp::mul(var_8, var_10);
    // midpoint_velocity = (                                                                  <L 298>
    // wp.vec3(                                                                               <L 299>
    // generator[2, 1],                                                                       <L 300>
    var_14 = wp::extract(var_11, var_12, var_13);
    // generator[0, 2],                                                                       <L 301>
    var_17 = wp::extract(var_11, var_15, var_16);
    // generator[1, 0],                                                                       <L 302>
    var_20 = wp::extract(var_11, var_18, var_19);
    var_21 = wp::vec_t<3, wp::float32>(var_14, var_17, var_20);
    // / dt                                                                                   <L 304>
    var_22 = wp::div(var_21, var_dt);
    // midpoint_momentum = inertia * midpoint_velocity                                        <L 306>
    var_23 = wp::mul(var_inertia, var_22);
    // next_momentum = midpoint_momentum + 0.5 * dt * wp.cross(                               <L 307>
    var_25 = wp::mul(var_24, var_dt);
    // midpoint_momentum,                                                                     <L 308>
    // midpoint_velocity,                                                                     <L 309>
    var_26 = wp::cross(var_23, var_22);
    var_27 = wp::mul(var_25, var_26);
    var_28 = wp::add(var_23, var_27);
    // return wp.inverse(inertia) * next_momentum                                             <L 311>
    var_29 = wp::inverse(var_inertia);
    var_30 = wp::mul(var_29, var_28);
    return var_30;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:314
static CUDA_CALLABLE wp::vec_t<3, wp::float32> recover_vbd_semi_implicit_end_velocity_0(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::mat_t<3, 3, wp::float32> var_relative_rotation,
    wp::float32 var_dt)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    //---------
    // forward
    // def recover_vbd_semi_implicit_end_velocity(                                            <L 315>
    // return _logarithmic_velocity(relative_rotation, dt)                                    <L 321>
    var_0 = _logarithmic_velocity_0(var_relative_rotation, var_dt);
    return var_0;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:324
static CUDA_CALLABLE wp::vec_t<3, wp::float32> recover_rigid_body_end_velocity_0(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::mat_t<3, 3, wp::float32> var_relative_rotation,
    wp::float32 var_dt,
    wp::int32 var_integrator)
{
    //---------
    // primal vars
    const wp::int32 var_0 = 0;
    bool var_1;
    wp::vec_t<3, wp::float32> var_2;
    const wp::int32 var_3 = 1;
    bool var_4;
    wp::vec_t<3, wp::float32> var_5;
    const wp::int32 var_6 = 2;
    bool var_7;
    wp::vec_t<3, wp::float32> var_8;
    const wp::int32 var_9 = 3;
    bool var_10;
    wp::vec_t<3, wp::float32> var_11;
    const wp::int32 var_12 = 5;
    bool var_13;
    wp::vec_t<3, wp::float32> var_14;
    //---------
    // forward
    // def recover_rigid_body_end_velocity(                                                   <L 325>
    // if integrator == EXPLICIT_EULER:                                                       <L 332>
    var_1 = (var_integrator == var_0);
    if (var_1) {
        // return recover_explicit_euler_end_velocity(inertia, relative_rotation, dt)         <L 333>
        var_2 = recover_explicit_euler_end_velocity_0(var_inertia, var_relative_rotation, var_dt);
        return var_2;
    }
    if (!var_1) {
        // elif integrator == IMPLICIT_EULER:                                                 <L 334>
        var_4 = (var_integrator == var_3);
        if (var_4) {
            // return recover_implicit_euler_end_velocity(inertia, relative_rotation, dt)       <L 335>
            var_5 = recover_implicit_euler_end_velocity_0(var_inertia, var_relative_rotation, var_dt);
            return var_5;
        }
        if (!var_4) {
            // elif integrator == LIE_GROUP_MIDPOINT:                                         <L 336>
            var_7 = (var_integrator == var_6);
            if (var_7) {
                // return recover_lie_group_midpoint_end_velocity(inertia, relative_rotation, dt)       <L 337>
                var_8 = recover_lie_group_midpoint_end_velocity_0(var_inertia, var_relative_rotation, var_dt);
                return var_8;
            }
            if (!var_7) {
                // elif integrator == MIDPOINT_CAYLEY:                                        <L 338>
                var_10 = (var_integrator == var_9);
                if (var_10) {
                    // return recover_midpoint_cayley_end_velocity(inertia, relative_rotation, dt)       <L 339>
                    var_11 = recover_midpoint_cayley_end_velocity_0(var_inertia, var_relative_rotation, var_dt);
                    return var_11;
                }
                if (!var_10) {
                    // elif integrator == VBD_SEMI_IMPLICIT:                                  <L 340>
                    var_13 = (var_integrator == var_12);
                    if (var_13) {
                        // return recover_vbd_semi_implicit_end_velocity(inertia, relative_rotation, dt)       <L 341>
                        var_14 = recover_vbd_semi_implicit_end_velocity_0(var_inertia, var_relative_rotation, var_dt);
                        return var_14;
                    }
                }
            }
        }
    }
    return {};
}


// /home/oem/code/agent/style3d-sim/.venv/lib/python3.12/site-packages/newton/_src/core/reset.py:13
static CUDA_CALLABLE bool reset_world_selected_0(
    wp::int32 var_world,
    wp::array_t<bool> var_world_mask,
    wp::int32 var_world_count)
{
    //---------
    // primal vars
    bool var_0;
    const wp::int32 var_1 = 0;
    bool var_2;
    bool var_3;
    bool* var_4;
    bool var_5;
    bool var_6;
    bool var_7;
    const wp::int32 var_8 = -1;
    bool var_9;
    bool* var_10;
    bool var_11;
    //---------
    // forward
    // def reset_world_selected(world: int, world_mask: wp.array[wp.bool], world_count: int) -> bool:       <L 14>
    // if world >= 0 and world < world_count:                                                 <L 16>
    var_2 = (var_world >= var_1);
    var_0 = var_2;
    if (var_0) {
        var_3 = (var_world < var_world_count);
        var_0 = var_0 && var_3;
    }
    if (var_0) {
        // return world_mask[world]                                                           <L 17>
        var_4 = wp::address(var_world_mask, var_world);
        var_6 = wp::load(var_4);
        var_5 = wp::copy(var_6);
        return var_5;
    }
    // return world == -1 and world_mask[world_count]                                         <L 18>
    var_9 = (var_world == var_8);
    var_7 = var_9;
    if (var_7) {
        var_10 = wp::address(var_world_mask, var_world_count);
        var_11 = wp::load(var_10);
        var_7 = var_7 && var_11;
    }
    return var_7;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/newton_solver.py:291
static CUDA_CALLABLE bool _reset_selected_world_0(
    wp::int32 var_world,
    wp::array_t<bool> var_world_mask,
    wp::int32 var_world_count,
    bool var_reset_all)
{
    //---------
    // primal vars
    const bool var_0 = true;
    bool var_1;
    //---------
    // forward
    // def _reset_selected_world(world: int, world_mask: wp.array(dtype=wp.bool), world_count: int, reset_all: bool):       <L 292>
    // if reset_all:                                                                          <L 293>
    if (var_reset_all) {
        // return True                                                                        <L 294>
        return var_0;
    }
    // return reset_world_selected(world, world_mask, world_count)                            <L 295>
    var_1 = reset_world_selected_0(var_world, var_world_mask, var_world_count);
    return var_1;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/newton_solver.py:213
static CUDA_CALLABLE void _write_affine_body_state_0(
    wp::int32 var_affine_body,
    wp::array_t<wp::vec_t<4, wp::int32>> var_affine_body_indices,
    wp::array_t<wp::int32> var_affine_body_ids,
    wp::array_t<wp::vec_t<3, wp::float32>> var_body_com,
    wp::array_t<wp::transform_t<wp::float32>> var_body_q,
    wp::array_t<wp::vec_t<6, wp::float32>> var_body_qd,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_q,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_qd)
{
    //---------
    // primal vars
    wp::vec_t<4, wp::int32>* var_0;
    wp::vec_t<4, wp::int32> var_1;
    wp::vec_t<4, wp::int32> var_2;
    wp::int32* var_3;
    wp::int32 var_4;
    wp::int32 var_5;
    wp::transform_t<wp::float32>* var_6;
    wp::transform_t<wp::float32> var_7;
    wp::transform_t<wp::float32> var_8;
    wp::quat_t<wp::float32> var_9;
    wp::vec_t<3, wp::float32> var_10;
    wp::vec_t<3, wp::float32>* var_11;
    wp::vec_t<3, wp::float32> var_12;
    wp::vec_t<3, wp::float32> var_13;
    wp::vec_t<3, wp::float32> var_14;
    const wp::float32 var_15 = 1.0;
    const wp::float32 var_16 = 0.0;
    const wp::float32 var_17 = 0.0;
    wp::vec_t<3, wp::float32> var_18;
    wp::vec_t<3, wp::float32> var_19;
    const wp::float32 var_20 = 0.0;
    const wp::float32 var_21 = 1.0;
    const wp::float32 var_22 = 0.0;
    wp::vec_t<3, wp::float32> var_23;
    wp::vec_t<3, wp::float32> var_24;
    const wp::float32 var_25 = 0.0;
    const wp::float32 var_26 = 0.0;
    const wp::float32 var_27 = 1.0;
    wp::vec_t<3, wp::float32> var_28;
    wp::vec_t<3, wp::float32> var_29;
    const wp::int32 var_30 = 0;
    wp::int32 var_31;
    const wp::int32 var_32 = 1;
    wp::int32 var_33;
    const wp::int32 var_34 = 2;
    wp::int32 var_35;
    const wp::int32 var_36 = 3;
    wp::int32 var_37;
    wp::vec_t<6, wp::float32>* var_38;
    wp::vec_t<3, wp::float32> var_39;
    wp::vec_t<6, wp::float32> var_40;
    wp::vec_t<6, wp::float32>* var_41;
    wp::vec_t<3, wp::float32> var_42;
    wp::vec_t<6, wp::float32> var_43;
    const wp::int32 var_44 = 0;
    wp::int32 var_45;
    wp::vec_t<3, wp::float32> var_46;
    const wp::int32 var_47 = 1;
    wp::int32 var_48;
    wp::vec_t<3, wp::float32> var_49;
    const wp::int32 var_50 = 2;
    wp::int32 var_51;
    wp::vec_t<3, wp::float32> var_52;
    const wp::int32 var_53 = 3;
    wp::int32 var_54;
    //---------
    // forward
    // def _write_affine_body_state(                                                          <L 214>
    // indices = affine_body_indices[affine_body]                                             <L 224>
    var_0 = wp::address(var_affine_body_indices, var_affine_body);
    var_2 = wp::load(var_0);
    var_1 = wp::copy(var_2);
    // body = affine_body_ids[affine_body]                                                    <L 225>
    var_3 = wp::address(var_affine_body_ids, var_affine_body);
    var_5 = wp::load(var_3);
    var_4 = wp::copy(var_5);
    // pose = body_q[body]                                                                    <L 226>
    var_6 = wp::address(var_body_q, var_4);
    var_8 = wp::load(var_6);
    var_7 = wp::copy(var_8);
    // rotation = wp.transform_get_rotation(pose)                                             <L 227>
    var_9 = wp::transform_get_rotation(var_7);
    // world_com = wp.transform_get_translation(pose) + wp.quat_rotate(                       <L 228>
    var_10 = wp::transform_get_translation(var_7);
    // rotation, body_com[affine_body]                                                        <L 229>
    var_11 = wp::address(var_body_com, var_affine_body);
    var_13 = wp::load(var_11);
    var_12 = wp::quat_rotate(var_9, var_13);
    var_14 = wp::add(var_10, var_12);
    // x_axis = wp.quat_rotate(rotation, wp.vec3(1.0, 0.0, 0.0))                              <L 231>
    var_18 = wp::vec_t<3, wp::float32>(var_15, var_16, var_17);
    var_19 = wp::quat_rotate(var_9, var_18);
    // y_axis = wp.quat_rotate(rotation, wp.vec3(0.0, 1.0, 0.0))                              <L 232>
    var_23 = wp::vec_t<3, wp::float32>(var_20, var_21, var_22);
    var_24 = wp::quat_rotate(var_9, var_23);
    // z_axis = wp.quat_rotate(rotation, wp.vec3(0.0, 0.0, 1.0))                              <L 233>
    var_28 = wp::vec_t<3, wp::float32>(var_25, var_26, var_27);
    var_29 = wp::quat_rotate(var_9, var_28);
    // if particle_q:                                                                         <L 234>
    if (var_particle_q) {
        // particle_q[indices[0]] = world_com                                                 <L 235>
        var_31 = wp::extract(var_1, var_30);
        wp::array_store(var_particle_q, var_31, var_14);
        // particle_q[indices[1]] = x_axis                                                    <L 236>
        var_33 = wp::extract(var_1, var_32);
        wp::array_store(var_particle_q, var_33, var_19);
        // particle_q[indices[2]] = y_axis                                                    <L 237>
        var_35 = wp::extract(var_1, var_34);
        wp::array_store(var_particle_q, var_35, var_24);
        // particle_q[indices[3]] = z_axis                                                    <L 238>
        var_37 = wp::extract(var_1, var_36);
        wp::array_store(var_particle_q, var_37, var_29);
    }
    // if particle_qd:                                                                        <L 239>
    if (var_particle_qd) {
        // linear_velocity = wp.spatial_top(body_qd[body])                                    <L 240>
        var_38 = wp::address(var_body_qd, var_4);
        var_40 = wp::load(var_38);
        var_39 = wp::spatial_top(var_40);
        // angular_velocity = wp.spatial_bottom(body_qd[body])                                <L 241>
        var_41 = wp::address(var_body_qd, var_4);
        var_43 = wp::load(var_41);
        var_42 = wp::spatial_bottom(var_43);
        // particle_qd[indices[0]] = linear_velocity                                          <L 242>
        var_45 = wp::extract(var_1, var_44);
        wp::array_store(var_particle_qd, var_45, var_39);
        // particle_qd[indices[1]] = wp.cross(angular_velocity, x_axis)                       <L 243>
        var_46 = wp::cross(var_42, var_19);
        var_48 = wp::extract(var_1, var_47);
        wp::array_store(var_particle_qd, var_48, var_46);
        // particle_qd[indices[2]] = wp.cross(angular_velocity, y_axis)                       <L 244>
        var_49 = wp::cross(var_42, var_24);
        var_51 = wp::extract(var_1, var_50);
        wp::array_store(var_particle_qd, var_51, var_49);
        // particle_qd[indices[3]] = wp.cross(angular_velocity, z_axis)                       <L 245>
        var_52 = wp::cross(var_42, var_29);
        var_54 = wp::extract(var_1, var_53);
        wp::array_store(var_particle_qd, var_54, var_52);
    }
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:207
static CUDA_CALLABLE void integrate_vbd_semi_implicit_0(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::vec_t<3, wp::float32> var_angular_momentum,
    wp::vec_t<3, wp::float32> var_body_torque,
    wp::float32 var_dt,
    wp::vec_t<3, wp::float32> & ret_0,
    wp::mat_t<3, 3, wp::float32> & ret_1)
{
    //---------
    // primal vars
    wp::mat_t<3, 3, wp::float32> var_0;
    wp::vec_t<3, wp::float32> var_1;
    wp::mat_t<3, 3, wp::float32> var_2;
    wp::vec_t<3, wp::float32> var_3;
    wp::vec_t<3, wp::float32> var_4;
    wp::vec_t<3, wp::float32> var_5;
    wp::vec_t<3, wp::float32> var_6;
    wp::vec_t<3, wp::float32> var_7;
    const wp::float32 var_8 = 0.5;
    wp::float32 var_9;
    wp::vec_t<3, wp::float32> var_10;
    const wp::float32 var_11 = 1.0;
    wp::quat_t<wp::float32> var_12;
    wp::quat_t<wp::float32> var_13;
    wp::vec_t<3, wp::float32> var_14;
    wp::mat_t<3, 3, wp::float32> var_15;
    //---------
    // forward
    // def integrate_vbd_semi_implicit(                                                       <L 208>
    // inverse_inertia = wp.inverse(inertia)                                                  <L 215>
    var_0 = wp::inverse(var_inertia);
    // angular_velocity = inverse_inertia * angular_momentum                                  <L 216>
    var_1 = wp::mul(var_0, var_angular_momentum);
    // next_velocity = angular_velocity + dt * inverse_inertia * (                            <L 218>
    var_2 = wp::mul(var_dt, var_0);
    // body_torque - wp.cross(angular_velocity, inertia * angular_velocity)                   <L 219>
    var_3 = wp::mul(var_inertia, var_1);
    var_4 = wp::cross(var_1, var_3);
    var_5 = wp::sub(var_body_torque, var_4);
    var_6 = wp::mul(var_2, var_5);
    var_7 = wp::add(var_1, var_6);
    // increment = wp.normalize(wp.quat(0.5 * dt * next_velocity, 1.0))                       <L 221>
    var_9 = wp::mul(var_8, var_dt);
    var_10 = wp::mul(var_9, var_7);
    var_12 = wp::quat_t<wp::float32>(var_10, var_11);
    var_13 = wp::normalize(var_12);
    // return inertia * next_velocity, wp.quat_to_matrix(increment)                           <L 222>
    var_14 = wp::mul(var_inertia, var_7);
    var_15 = wp::quat_to_matrix(var_13);
    ret_0 = var_14;
    ret_1 = var_15;
    return;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:73
static CUDA_CALLABLE void integrate_explicit_euler_0(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::vec_t<3, wp::float32> var_angular_momentum,
    wp::float32 var_dt,
    wp::vec_t<3, wp::float32> & ret_0,
    wp::mat_t<3, 3, wp::float32> & ret_1)
{
    //---------
    // primal vars
    wp::mat_t<3, 3, wp::float32> var_0;
    wp::vec_t<3, wp::float32> var_1;
    wp::vec_t<3, wp::float32> var_2;
    wp::vec_t<3, wp::float32> var_3;
    wp::vec_t<3, wp::float32> var_4;
    wp::mat_t<3, 3, wp::float32> var_5;
    //---------
    // forward
    // def integrate_explicit_euler(                                                          <L 74>
    // angular_velocity = wp.inverse(inertia) * angular_momentum                              <L 80>
    var_0 = wp::inverse(var_inertia);
    var_1 = wp::mul(var_0, var_angular_momentum);
    // next_angular_momentum = angular_momentum + dt * wp.cross(                              <L 81>
    // angular_momentum,                                                                      <L 82>
    // angular_velocity,                                                                      <L 83>
    var_2 = wp::cross(var_angular_momentum, var_1);
    var_3 = wp::mul(var_dt, var_2);
    var_4 = wp::add(var_angular_momentum, var_3);
    // relative_rotation = _exponential_increment(angular_velocity, dt)                       <L 85>
    var_5 = _exponential_increment_0(var_1, var_dt);
    // return next_angular_momentum, relative_rotation                                        <L 86>
    ret_0 = var_4;
    ret_1 = var_5;
    return;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:89
static CUDA_CALLABLE void integrate_implicit_euler_0(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::vec_t<3, wp::float32> var_angular_momentum,
    wp::float32 var_dt,
    wp::vec_t<3, wp::float32> & ret_0,
    wp::mat_t<3, 3, wp::float32> & ret_1)
{
    //---------
    // primal vars
    wp::mat_t<3, 3, wp::float32> var_0;
    wp::vec_t<3, wp::float32> var_1;
    wp::vec_t<3, wp::float32> var_2;
    wp::vec_t<3, wp::float32> var_3;
    wp::vec_t<3, wp::float32> var_4;
    const wp::int32 var_5 = 0;
    wp::vec_t<3, wp::float32> var_6;
    wp::vec_t<3, wp::float32> var_7;
    wp::vec_t<3, wp::float32> var_8;
    wp::vec_t<3, wp::float32> var_9;
    wp::vec_t<3, wp::float32> var_10;
    const wp::int32 var_11 = 3;
    wp::mat_t<3, 3, wp::float32> var_12;
    wp::mat_t<3, 3, wp::float32> var_13;
    wp::mat_t<3, 3, wp::float32> var_14;
    wp::mat_t<3, 3, wp::float32> var_15;
    wp::mat_t<3, 3, wp::float32> var_16;
    wp::mat_t<3, 3, wp::float32> var_17;
    wp::mat_t<3, 3, wp::float32> var_18;
    wp::mat_t<3, 3, wp::float32> var_19;
    wp::mat_t<3, 3, wp::float32> var_20;
    wp::vec_t<3, wp::float32> var_21;
    wp::vec_t<3, wp::float32> var_22;
    const wp::int32 var_23 = 1;
    wp::vec_t<3, wp::float32> var_24;
    wp::vec_t<3, wp::float32> var_25;
    wp::vec_t<3, wp::float32> var_26;
    wp::vec_t<3, wp::float32> var_27;
    wp::vec_t<3, wp::float32> var_28;
    const wp::int32 var_29 = 3;
    wp::mat_t<3, 3, wp::float32> var_30;
    wp::mat_t<3, 3, wp::float32> var_31;
    wp::mat_t<3, 3, wp::float32> var_32;
    wp::mat_t<3, 3, wp::float32> var_33;
    wp::mat_t<3, 3, wp::float32> var_34;
    wp::mat_t<3, 3, wp::float32> var_35;
    wp::mat_t<3, 3, wp::float32> var_36;
    wp::mat_t<3, 3, wp::float32> var_37;
    wp::mat_t<3, 3, wp::float32> var_38;
    wp::vec_t<3, wp::float32> var_39;
    wp::vec_t<3, wp::float32> var_40;
    const wp::int32 var_41 = 2;
    wp::vec_t<3, wp::float32> var_42;
    wp::vec_t<3, wp::float32> var_43;
    wp::vec_t<3, wp::float32> var_44;
    wp::vec_t<3, wp::float32> var_45;
    wp::vec_t<3, wp::float32> var_46;
    const wp::int32 var_47 = 3;
    wp::mat_t<3, 3, wp::float32> var_48;
    wp::mat_t<3, 3, wp::float32> var_49;
    wp::mat_t<3, 3, wp::float32> var_50;
    wp::mat_t<3, 3, wp::float32> var_51;
    wp::mat_t<3, 3, wp::float32> var_52;
    wp::mat_t<3, 3, wp::float32> var_53;
    wp::mat_t<3, 3, wp::float32> var_54;
    wp::mat_t<3, 3, wp::float32> var_55;
    wp::mat_t<3, 3, wp::float32> var_56;
    wp::vec_t<3, wp::float32> var_57;
    wp::vec_t<3, wp::float32> var_58;
    const wp::int32 var_59 = 3;
    wp::vec_t<3, wp::float32> var_60;
    wp::vec_t<3, wp::float32> var_61;
    wp::vec_t<3, wp::float32> var_62;
    wp::vec_t<3, wp::float32> var_63;
    wp::vec_t<3, wp::float32> var_64;
    const wp::int32 var_65 = 3;
    wp::mat_t<3, 3, wp::float32> var_66;
    wp::mat_t<3, 3, wp::float32> var_67;
    wp::mat_t<3, 3, wp::float32> var_68;
    wp::mat_t<3, 3, wp::float32> var_69;
    wp::mat_t<3, 3, wp::float32> var_70;
    wp::mat_t<3, 3, wp::float32> var_71;
    wp::mat_t<3, 3, wp::float32> var_72;
    wp::mat_t<3, 3, wp::float32> var_73;
    wp::mat_t<3, 3, wp::float32> var_74;
    wp::vec_t<3, wp::float32> var_75;
    wp::vec_t<3, wp::float32> var_76;
    const wp::int32 var_77 = 4;
    wp::vec_t<3, wp::float32> var_78;
    wp::vec_t<3, wp::float32> var_79;
    wp::vec_t<3, wp::float32> var_80;
    wp::vec_t<3, wp::float32> var_81;
    wp::vec_t<3, wp::float32> var_82;
    const wp::int32 var_83 = 3;
    wp::mat_t<3, 3, wp::float32> var_84;
    wp::mat_t<3, 3, wp::float32> var_85;
    wp::mat_t<3, 3, wp::float32> var_86;
    wp::mat_t<3, 3, wp::float32> var_87;
    wp::mat_t<3, 3, wp::float32> var_88;
    wp::mat_t<3, 3, wp::float32> var_89;
    wp::mat_t<3, 3, wp::float32> var_90;
    wp::mat_t<3, 3, wp::float32> var_91;
    wp::mat_t<3, 3, wp::float32> var_92;
    wp::vec_t<3, wp::float32> var_93;
    wp::vec_t<3, wp::float32> var_94;
    const wp::int32 var_95 = 5;
    wp::vec_t<3, wp::float32> var_96;
    wp::vec_t<3, wp::float32> var_97;
    wp::vec_t<3, wp::float32> var_98;
    wp::vec_t<3, wp::float32> var_99;
    wp::vec_t<3, wp::float32> var_100;
    const wp::int32 var_101 = 3;
    wp::mat_t<3, 3, wp::float32> var_102;
    wp::mat_t<3, 3, wp::float32> var_103;
    wp::mat_t<3, 3, wp::float32> var_104;
    wp::mat_t<3, 3, wp::float32> var_105;
    wp::mat_t<3, 3, wp::float32> var_106;
    wp::mat_t<3, 3, wp::float32> var_107;
    wp::mat_t<3, 3, wp::float32> var_108;
    wp::mat_t<3, 3, wp::float32> var_109;
    wp::mat_t<3, 3, wp::float32> var_110;
    wp::vec_t<3, wp::float32> var_111;
    wp::vec_t<3, wp::float32> var_112;
    const wp::int32 var_113 = 6;
    wp::vec_t<3, wp::float32> var_114;
    wp::vec_t<3, wp::float32> var_115;
    wp::vec_t<3, wp::float32> var_116;
    wp::vec_t<3, wp::float32> var_117;
    wp::vec_t<3, wp::float32> var_118;
    const wp::int32 var_119 = 3;
    wp::mat_t<3, 3, wp::float32> var_120;
    wp::mat_t<3, 3, wp::float32> var_121;
    wp::mat_t<3, 3, wp::float32> var_122;
    wp::mat_t<3, 3, wp::float32> var_123;
    wp::mat_t<3, 3, wp::float32> var_124;
    wp::mat_t<3, 3, wp::float32> var_125;
    wp::mat_t<3, 3, wp::float32> var_126;
    wp::mat_t<3, 3, wp::float32> var_127;
    wp::mat_t<3, 3, wp::float32> var_128;
    wp::vec_t<3, wp::float32> var_129;
    wp::vec_t<3, wp::float32> var_130;
    const wp::int32 var_131 = 7;
    wp::vec_t<3, wp::float32> var_132;
    wp::vec_t<3, wp::float32> var_133;
    wp::vec_t<3, wp::float32> var_134;
    wp::vec_t<3, wp::float32> var_135;
    wp::vec_t<3, wp::float32> var_136;
    const wp::int32 var_137 = 3;
    wp::mat_t<3, 3, wp::float32> var_138;
    wp::mat_t<3, 3, wp::float32> var_139;
    wp::mat_t<3, 3, wp::float32> var_140;
    wp::mat_t<3, 3, wp::float32> var_141;
    wp::mat_t<3, 3, wp::float32> var_142;
    wp::mat_t<3, 3, wp::float32> var_143;
    wp::mat_t<3, 3, wp::float32> var_144;
    wp::mat_t<3, 3, wp::float32> var_145;
    wp::mat_t<3, 3, wp::float32> var_146;
    wp::vec_t<3, wp::float32> var_147;
    wp::vec_t<3, wp::float32> var_148;
    wp::vec_t<3, wp::float32> var_149;
    wp::mat_t<3, 3, wp::float32> var_150;
    //---------
    // forward
    // def integrate_implicit_euler(                                                          <L 90>
    // inverse_inertia = wp.inverse(inertia)                                                  <L 96>
    var_0 = wp::inverse(var_inertia);
    // next_angular_momentum = angular_momentum + dt * wp.cross(                              <L 97>
    // angular_momentum,                                                                      <L 98>
    // inverse_inertia * angular_momentum,                                                    <L 99>
    var_1 = wp::mul(var_0, var_angular_momentum);
    var_2 = wp::cross(var_angular_momentum, var_1);
    var_3 = wp::mul(var_dt, var_2);
    var_4 = wp::add(var_angular_momentum, var_3);
    // for _ in range(8):                                                                     <L 102>
    // next_angular_velocity = inverse_inertia * next_angular_momentum                        <L 103>
    var_6 = wp::mul(var_0, var_4);
    // residual = (                                                                           <L 104>
    // next_angular_momentum                                                                  <L 105>
    // - angular_momentum                                                                     <L 106>
    var_7 = wp::sub(var_4, var_angular_momentum);
    // - dt * wp.cross(next_angular_momentum, next_angular_velocity)                          <L 107>
    var_8 = wp::cross(var_4, var_6);
    var_9 = wp::mul(var_dt, var_8);
    var_10 = wp::sub(var_7, var_9);
    // jacobian = (                                                                           <L 109>
    // wp.identity(3, dtype=float)                                                            <L 110>
    var_12 = wp::identity<3, wp::float32>();
    // + dt * wp.skew(next_angular_velocity)                                                  <L 111>
    var_13 = wp::skew(var_6);
    var_14 = wp::mul(var_dt, var_13);
    var_15 = wp::add(var_12, var_14);
    // - dt * wp.skew(next_angular_momentum) * inverse_inertia                                <L 112>
    var_16 = wp::skew(var_4);
    var_17 = wp::mul(var_dt, var_16);
    var_18 = wp::mul(var_17, var_0);
    var_19 = wp::sub(var_15, var_18);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 114>
    var_20 = wp::inverse(var_19);
    var_21 = wp::mul(var_20, var_10);
    var_22 = wp::sub(var_4, var_21);
    // next_angular_velocity = inverse_inertia * next_angular_momentum                        <L 103>
    var_24 = wp::mul(var_0, var_22);
    // residual = (                                                                           <L 104>
    // next_angular_momentum                                                                  <L 105>
    // - angular_momentum                                                                     <L 106>
    var_25 = wp::sub(var_22, var_angular_momentum);
    // - dt * wp.cross(next_angular_momentum, next_angular_velocity)                          <L 107>
    var_26 = wp::cross(var_22, var_24);
    var_27 = wp::mul(var_dt, var_26);
    var_28 = wp::sub(var_25, var_27);
    // jacobian = (                                                                           <L 109>
    // wp.identity(3, dtype=float)                                                            <L 110>
    var_30 = wp::identity<3, wp::float32>();
    // + dt * wp.skew(next_angular_velocity)                                                  <L 111>
    var_31 = wp::skew(var_24);
    var_32 = wp::mul(var_dt, var_31);
    var_33 = wp::add(var_30, var_32);
    // - dt * wp.skew(next_angular_momentum) * inverse_inertia                                <L 112>
    var_34 = wp::skew(var_22);
    var_35 = wp::mul(var_dt, var_34);
    var_36 = wp::mul(var_35, var_0);
    var_37 = wp::sub(var_33, var_36);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 114>
    var_38 = wp::inverse(var_37);
    var_39 = wp::mul(var_38, var_28);
    var_40 = wp::sub(var_22, var_39);
    // next_angular_velocity = inverse_inertia * next_angular_momentum                        <L 103>
    var_42 = wp::mul(var_0, var_40);
    // residual = (                                                                           <L 104>
    // next_angular_momentum                                                                  <L 105>
    // - angular_momentum                                                                     <L 106>
    var_43 = wp::sub(var_40, var_angular_momentum);
    // - dt * wp.cross(next_angular_momentum, next_angular_velocity)                          <L 107>
    var_44 = wp::cross(var_40, var_42);
    var_45 = wp::mul(var_dt, var_44);
    var_46 = wp::sub(var_43, var_45);
    // jacobian = (                                                                           <L 109>
    // wp.identity(3, dtype=float)                                                            <L 110>
    var_48 = wp::identity<3, wp::float32>();
    // + dt * wp.skew(next_angular_velocity)                                                  <L 111>
    var_49 = wp::skew(var_42);
    var_50 = wp::mul(var_dt, var_49);
    var_51 = wp::add(var_48, var_50);
    // - dt * wp.skew(next_angular_momentum) * inverse_inertia                                <L 112>
    var_52 = wp::skew(var_40);
    var_53 = wp::mul(var_dt, var_52);
    var_54 = wp::mul(var_53, var_0);
    var_55 = wp::sub(var_51, var_54);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 114>
    var_56 = wp::inverse(var_55);
    var_57 = wp::mul(var_56, var_46);
    var_58 = wp::sub(var_40, var_57);
    // next_angular_velocity = inverse_inertia * next_angular_momentum                        <L 103>
    var_60 = wp::mul(var_0, var_58);
    // residual = (                                                                           <L 104>
    // next_angular_momentum                                                                  <L 105>
    // - angular_momentum                                                                     <L 106>
    var_61 = wp::sub(var_58, var_angular_momentum);
    // - dt * wp.cross(next_angular_momentum, next_angular_velocity)                          <L 107>
    var_62 = wp::cross(var_58, var_60);
    var_63 = wp::mul(var_dt, var_62);
    var_64 = wp::sub(var_61, var_63);
    // jacobian = (                                                                           <L 109>
    // wp.identity(3, dtype=float)                                                            <L 110>
    var_66 = wp::identity<3, wp::float32>();
    // + dt * wp.skew(next_angular_velocity)                                                  <L 111>
    var_67 = wp::skew(var_60);
    var_68 = wp::mul(var_dt, var_67);
    var_69 = wp::add(var_66, var_68);
    // - dt * wp.skew(next_angular_momentum) * inverse_inertia                                <L 112>
    var_70 = wp::skew(var_58);
    var_71 = wp::mul(var_dt, var_70);
    var_72 = wp::mul(var_71, var_0);
    var_73 = wp::sub(var_69, var_72);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 114>
    var_74 = wp::inverse(var_73);
    var_75 = wp::mul(var_74, var_64);
    var_76 = wp::sub(var_58, var_75);
    // next_angular_velocity = inverse_inertia * next_angular_momentum                        <L 103>
    var_78 = wp::mul(var_0, var_76);
    // residual = (                                                                           <L 104>
    // next_angular_momentum                                                                  <L 105>
    // - angular_momentum                                                                     <L 106>
    var_79 = wp::sub(var_76, var_angular_momentum);
    // - dt * wp.cross(next_angular_momentum, next_angular_velocity)                          <L 107>
    var_80 = wp::cross(var_76, var_78);
    var_81 = wp::mul(var_dt, var_80);
    var_82 = wp::sub(var_79, var_81);
    // jacobian = (                                                                           <L 109>
    // wp.identity(3, dtype=float)                                                            <L 110>
    var_84 = wp::identity<3, wp::float32>();
    // + dt * wp.skew(next_angular_velocity)                                                  <L 111>
    var_85 = wp::skew(var_78);
    var_86 = wp::mul(var_dt, var_85);
    var_87 = wp::add(var_84, var_86);
    // - dt * wp.skew(next_angular_momentum) * inverse_inertia                                <L 112>
    var_88 = wp::skew(var_76);
    var_89 = wp::mul(var_dt, var_88);
    var_90 = wp::mul(var_89, var_0);
    var_91 = wp::sub(var_87, var_90);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 114>
    var_92 = wp::inverse(var_91);
    var_93 = wp::mul(var_92, var_82);
    var_94 = wp::sub(var_76, var_93);
    // next_angular_velocity = inverse_inertia * next_angular_momentum                        <L 103>
    var_96 = wp::mul(var_0, var_94);
    // residual = (                                                                           <L 104>
    // next_angular_momentum                                                                  <L 105>
    // - angular_momentum                                                                     <L 106>
    var_97 = wp::sub(var_94, var_angular_momentum);
    // - dt * wp.cross(next_angular_momentum, next_angular_velocity)                          <L 107>
    var_98 = wp::cross(var_94, var_96);
    var_99 = wp::mul(var_dt, var_98);
    var_100 = wp::sub(var_97, var_99);
    // jacobian = (                                                                           <L 109>
    // wp.identity(3, dtype=float)                                                            <L 110>
    var_102 = wp::identity<3, wp::float32>();
    // + dt * wp.skew(next_angular_velocity)                                                  <L 111>
    var_103 = wp::skew(var_96);
    var_104 = wp::mul(var_dt, var_103);
    var_105 = wp::add(var_102, var_104);
    // - dt * wp.skew(next_angular_momentum) * inverse_inertia                                <L 112>
    var_106 = wp::skew(var_94);
    var_107 = wp::mul(var_dt, var_106);
    var_108 = wp::mul(var_107, var_0);
    var_109 = wp::sub(var_105, var_108);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 114>
    var_110 = wp::inverse(var_109);
    var_111 = wp::mul(var_110, var_100);
    var_112 = wp::sub(var_94, var_111);
    // next_angular_velocity = inverse_inertia * next_angular_momentum                        <L 103>
    var_114 = wp::mul(var_0, var_112);
    // residual = (                                                                           <L 104>
    // next_angular_momentum                                                                  <L 105>
    // - angular_momentum                                                                     <L 106>
    var_115 = wp::sub(var_112, var_angular_momentum);
    // - dt * wp.cross(next_angular_momentum, next_angular_velocity)                          <L 107>
    var_116 = wp::cross(var_112, var_114);
    var_117 = wp::mul(var_dt, var_116);
    var_118 = wp::sub(var_115, var_117);
    // jacobian = (                                                                           <L 109>
    // wp.identity(3, dtype=float)                                                            <L 110>
    var_120 = wp::identity<3, wp::float32>();
    // + dt * wp.skew(next_angular_velocity)                                                  <L 111>
    var_121 = wp::skew(var_114);
    var_122 = wp::mul(var_dt, var_121);
    var_123 = wp::add(var_120, var_122);
    // - dt * wp.skew(next_angular_momentum) * inverse_inertia                                <L 112>
    var_124 = wp::skew(var_112);
    var_125 = wp::mul(var_dt, var_124);
    var_126 = wp::mul(var_125, var_0);
    var_127 = wp::sub(var_123, var_126);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 114>
    var_128 = wp::inverse(var_127);
    var_129 = wp::mul(var_128, var_118);
    var_130 = wp::sub(var_112, var_129);
    // next_angular_velocity = inverse_inertia * next_angular_momentum                        <L 103>
    var_132 = wp::mul(var_0, var_130);
    // residual = (                                                                           <L 104>
    // next_angular_momentum                                                                  <L 105>
    // - angular_momentum                                                                     <L 106>
    var_133 = wp::sub(var_130, var_angular_momentum);
    // - dt * wp.cross(next_angular_momentum, next_angular_velocity)                          <L 107>
    var_134 = wp::cross(var_130, var_132);
    var_135 = wp::mul(var_dt, var_134);
    var_136 = wp::sub(var_133, var_135);
    // jacobian = (                                                                           <L 109>
    // wp.identity(3, dtype=float)                                                            <L 110>
    var_138 = wp::identity<3, wp::float32>();
    // + dt * wp.skew(next_angular_velocity)                                                  <L 111>
    var_139 = wp::skew(var_132);
    var_140 = wp::mul(var_dt, var_139);
    var_141 = wp::add(var_138, var_140);
    // - dt * wp.skew(next_angular_momentum) * inverse_inertia                                <L 112>
    var_142 = wp::skew(var_130);
    var_143 = wp::mul(var_dt, var_142);
    var_144 = wp::mul(var_143, var_0);
    var_145 = wp::sub(var_141, var_144);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 114>
    var_146 = wp::inverse(var_145);
    var_147 = wp::mul(var_146, var_136);
    var_148 = wp::sub(var_130, var_147);
    // next_angular_velocity = inverse_inertia * next_angular_momentum                        <L 116>
    var_149 = wp::mul(var_0, var_148);
    // relative_rotation = _exponential_increment(next_angular_velocity, dt)                  <L 117>
    var_150 = _exponential_increment_0(var_149, var_dt);
    // return next_angular_momentum, relative_rotation                                        <L 118>
    ret_0 = var_148;
    ret_1 = var_150;
    return;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:121
static CUDA_CALLABLE void integrate_lie_group_midpoint_0(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::vec_t<3, wp::float32> var_angular_momentum,
    wp::float32 var_dt,
    wp::vec_t<3, wp::float32> & ret_0,
    wp::mat_t<3, 3, wp::float32> & ret_1)
{
    //---------
    // primal vars
    wp::mat_t<3, 3, wp::float32> var_0;
    wp::vec_t<3, wp::float32> var_1;
    const wp::int32 var_2 = 0;
    const wp::float32 var_3 = 0.5;
    wp::float32 var_4;
    wp::mat_t<3, 3, wp::float32> var_5;
    wp::mat_t<3, 3, wp::float32> var_6;
    wp::mat_t<3, 3, wp::float32> var_7;
    wp::mat_t<3, 3, wp::float32> var_8;
    wp::vec_t<3, wp::float32> var_9;
    const wp::int32 var_10 = 1;
    const wp::float32 var_11 = 0.5;
    wp::float32 var_12;
    wp::mat_t<3, 3, wp::float32> var_13;
    wp::mat_t<3, 3, wp::float32> var_14;
    wp::mat_t<3, 3, wp::float32> var_15;
    wp::mat_t<3, 3, wp::float32> var_16;
    wp::vec_t<3, wp::float32> var_17;
    const wp::int32 var_18 = 2;
    const wp::float32 var_19 = 0.5;
    wp::float32 var_20;
    wp::mat_t<3, 3, wp::float32> var_21;
    wp::mat_t<3, 3, wp::float32> var_22;
    wp::mat_t<3, 3, wp::float32> var_23;
    wp::mat_t<3, 3, wp::float32> var_24;
    wp::vec_t<3, wp::float32> var_25;
    const wp::int32 var_26 = 3;
    const wp::float32 var_27 = 0.5;
    wp::float32 var_28;
    wp::mat_t<3, 3, wp::float32> var_29;
    wp::mat_t<3, 3, wp::float32> var_30;
    wp::mat_t<3, 3, wp::float32> var_31;
    wp::mat_t<3, 3, wp::float32> var_32;
    wp::vec_t<3, wp::float32> var_33;
    const wp::int32 var_34 = 4;
    const wp::float32 var_35 = 0.5;
    wp::float32 var_36;
    wp::mat_t<3, 3, wp::float32> var_37;
    wp::mat_t<3, 3, wp::float32> var_38;
    wp::mat_t<3, 3, wp::float32> var_39;
    wp::mat_t<3, 3, wp::float32> var_40;
    wp::vec_t<3, wp::float32> var_41;
    const wp::int32 var_42 = 5;
    const wp::float32 var_43 = 0.5;
    wp::float32 var_44;
    wp::mat_t<3, 3, wp::float32> var_45;
    wp::mat_t<3, 3, wp::float32> var_46;
    wp::mat_t<3, 3, wp::float32> var_47;
    wp::mat_t<3, 3, wp::float32> var_48;
    wp::vec_t<3, wp::float32> var_49;
    const wp::int32 var_50 = 6;
    const wp::float32 var_51 = 0.5;
    wp::float32 var_52;
    wp::mat_t<3, 3, wp::float32> var_53;
    wp::mat_t<3, 3, wp::float32> var_54;
    wp::mat_t<3, 3, wp::float32> var_55;
    wp::mat_t<3, 3, wp::float32> var_56;
    wp::vec_t<3, wp::float32> var_57;
    const wp::int32 var_58 = 7;
    const wp::float32 var_59 = 0.5;
    wp::float32 var_60;
    wp::mat_t<3, 3, wp::float32> var_61;
    wp::mat_t<3, 3, wp::float32> var_62;
    wp::mat_t<3, 3, wp::float32> var_63;
    wp::mat_t<3, 3, wp::float32> var_64;
    wp::vec_t<3, wp::float32> var_65;
    wp::mat_t<3, 3, wp::float32> var_66;
    wp::mat_t<3, 3, wp::float32> var_67;
    wp::vec_t<3, wp::float32> var_68;
    //---------
    // forward
    // def integrate_lie_group_midpoint(                                                      <L 122>
    // inverse_inertia = wp.inverse(inertia)                                                  <L 128>
    var_0 = wp::inverse(var_inertia);
    // midpoint_angular_velocity = inverse_inertia * angular_momentum                         <L 129>
    var_1 = wp::mul(var_0, var_angular_momentum);
    // for _ in range(8):                                                                     <L 131>
    // half_rotation = _exponential_increment(midpoint_angular_velocity, 0.5 * dt)            <L 132>
    var_4 = wp::mul(var_3, var_dt);
    var_5 = _exponential_increment_0(var_1, var_4);
    // midpoint_angular_velocity = (                                                          <L 133>
    // half_rotation                                                                          <L 134>
    // * inverse_inertia                                                                      <L 135>
    var_6 = wp::mul(var_5, var_0);
    // * wp.transpose(half_rotation)                                                          <L 136>
    var_7 = wp::transpose(var_5);
    var_8 = wp::mul(var_6, var_7);
    // * angular_momentum                                                                     <L 137>
    var_9 = wp::mul(var_8, var_angular_momentum);
    // half_rotation = _exponential_increment(midpoint_angular_velocity, 0.5 * dt)            <L 132>
    var_12 = wp::mul(var_11, var_dt);
    var_13 = _exponential_increment_0(var_9, var_12);
    // midpoint_angular_velocity = (                                                          <L 133>
    // half_rotation                                                                          <L 134>
    // * inverse_inertia                                                                      <L 135>
    var_14 = wp::mul(var_13, var_0);
    // * wp.transpose(half_rotation)                                                          <L 136>
    var_15 = wp::transpose(var_13);
    var_16 = wp::mul(var_14, var_15);
    // * angular_momentum                                                                     <L 137>
    var_17 = wp::mul(var_16, var_angular_momentum);
    // half_rotation = _exponential_increment(midpoint_angular_velocity, 0.5 * dt)            <L 132>
    var_20 = wp::mul(var_19, var_dt);
    var_21 = _exponential_increment_0(var_17, var_20);
    // midpoint_angular_velocity = (                                                          <L 133>
    // half_rotation                                                                          <L 134>
    // * inverse_inertia                                                                      <L 135>
    var_22 = wp::mul(var_21, var_0);
    // * wp.transpose(half_rotation)                                                          <L 136>
    var_23 = wp::transpose(var_21);
    var_24 = wp::mul(var_22, var_23);
    // * angular_momentum                                                                     <L 137>
    var_25 = wp::mul(var_24, var_angular_momentum);
    // half_rotation = _exponential_increment(midpoint_angular_velocity, 0.5 * dt)            <L 132>
    var_28 = wp::mul(var_27, var_dt);
    var_29 = _exponential_increment_0(var_25, var_28);
    // midpoint_angular_velocity = (                                                          <L 133>
    // half_rotation                                                                          <L 134>
    // * inverse_inertia                                                                      <L 135>
    var_30 = wp::mul(var_29, var_0);
    // * wp.transpose(half_rotation)                                                          <L 136>
    var_31 = wp::transpose(var_29);
    var_32 = wp::mul(var_30, var_31);
    // * angular_momentum                                                                     <L 137>
    var_33 = wp::mul(var_32, var_angular_momentum);
    // half_rotation = _exponential_increment(midpoint_angular_velocity, 0.5 * dt)            <L 132>
    var_36 = wp::mul(var_35, var_dt);
    var_37 = _exponential_increment_0(var_33, var_36);
    // midpoint_angular_velocity = (                                                          <L 133>
    // half_rotation                                                                          <L 134>
    // * inverse_inertia                                                                      <L 135>
    var_38 = wp::mul(var_37, var_0);
    // * wp.transpose(half_rotation)                                                          <L 136>
    var_39 = wp::transpose(var_37);
    var_40 = wp::mul(var_38, var_39);
    // * angular_momentum                                                                     <L 137>
    var_41 = wp::mul(var_40, var_angular_momentum);
    // half_rotation = _exponential_increment(midpoint_angular_velocity, 0.5 * dt)            <L 132>
    var_44 = wp::mul(var_43, var_dt);
    var_45 = _exponential_increment_0(var_41, var_44);
    // midpoint_angular_velocity = (                                                          <L 133>
    // half_rotation                                                                          <L 134>
    // * inverse_inertia                                                                      <L 135>
    var_46 = wp::mul(var_45, var_0);
    // * wp.transpose(half_rotation)                                                          <L 136>
    var_47 = wp::transpose(var_45);
    var_48 = wp::mul(var_46, var_47);
    // * angular_momentum                                                                     <L 137>
    var_49 = wp::mul(var_48, var_angular_momentum);
    // half_rotation = _exponential_increment(midpoint_angular_velocity, 0.5 * dt)            <L 132>
    var_52 = wp::mul(var_51, var_dt);
    var_53 = _exponential_increment_0(var_49, var_52);
    // midpoint_angular_velocity = (                                                          <L 133>
    // half_rotation                                                                          <L 134>
    // * inverse_inertia                                                                      <L 135>
    var_54 = wp::mul(var_53, var_0);
    // * wp.transpose(half_rotation)                                                          <L 136>
    var_55 = wp::transpose(var_53);
    var_56 = wp::mul(var_54, var_55);
    // * angular_momentum                                                                     <L 137>
    var_57 = wp::mul(var_56, var_angular_momentum);
    // half_rotation = _exponential_increment(midpoint_angular_velocity, 0.5 * dt)            <L 132>
    var_60 = wp::mul(var_59, var_dt);
    var_61 = _exponential_increment_0(var_57, var_60);
    // midpoint_angular_velocity = (                                                          <L 133>
    // half_rotation                                                                          <L 134>
    // * inverse_inertia                                                                      <L 135>
    var_62 = wp::mul(var_61, var_0);
    // * wp.transpose(half_rotation)                                                          <L 136>
    var_63 = wp::transpose(var_61);
    var_64 = wp::mul(var_62, var_63);
    // * angular_momentum                                                                     <L 137>
    var_65 = wp::mul(var_64, var_angular_momentum);
    // relative_rotation = _exponential_increment(midpoint_angular_velocity, dt)              <L 140>
    var_66 = _exponential_increment_0(var_65, var_dt);
    // next_angular_momentum = wp.transpose(relative_rotation) * angular_momentum             <L 141>
    var_67 = wp::transpose(var_66);
    var_68 = wp::mul(var_67, var_angular_momentum);
    // return next_angular_momentum, relative_rotation                                        <L 142>
    ret_0 = var_68;
    ret_1 = var_66;
    return;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:145
static CUDA_CALLABLE void solve_energy_momentum_midpoint_0(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::vec_t<3, wp::float32> var_angular_momentum,
    wp::float32 var_dt,
    wp::vec_t<3, wp::float32> & ret_0,
    wp::vec_t<3, wp::float32> & ret_1,
    wp::vec_t<3, wp::float32> & ret_2)
{
    //---------
    // primal vars
    wp::mat_t<3, 3, wp::float32> var_0;
    wp::vec_t<3, wp::float32> var_1;
    wp::vec_t<3, wp::float32> var_2;
    wp::vec_t<3, wp::float32> var_3;
    wp::vec_t<3, wp::float32> var_4;
    const wp::int32 var_5 = 0;
    const wp::float32 var_6 = 0.5;
    wp::vec_t<3, wp::float32> var_7;
    wp::vec_t<3, wp::float32> var_8;
    wp::vec_t<3, wp::float32> var_9;
    wp::vec_t<3, wp::float32> var_10;
    wp::vec_t<3, wp::float32> var_11;
    wp::vec_t<3, wp::float32> var_12;
    wp::vec_t<3, wp::float32> var_13;
    const wp::int32 var_14 = 3;
    wp::mat_t<3, 3, wp::float32> var_15;
    const wp::float32 var_16 = 0.5;
    wp::float32 var_17;
    wp::mat_t<3, 3, wp::float32> var_18;
    wp::mat_t<3, 3, wp::float32> var_19;
    wp::mat_t<3, 3, wp::float32> var_20;
    const wp::float32 var_21 = 0.5;
    wp::float32 var_22;
    wp::mat_t<3, 3, wp::float32> var_23;
    wp::mat_t<3, 3, wp::float32> var_24;
    wp::mat_t<3, 3, wp::float32> var_25;
    wp::mat_t<3, 3, wp::float32> var_26;
    wp::mat_t<3, 3, wp::float32> var_27;
    wp::vec_t<3, wp::float32> var_28;
    wp::vec_t<3, wp::float32> var_29;
    const wp::int32 var_30 = 1;
    const wp::float32 var_31 = 0.5;
    wp::vec_t<3, wp::float32> var_32;
    wp::vec_t<3, wp::float32> var_33;
    wp::vec_t<3, wp::float32> var_34;
    wp::vec_t<3, wp::float32> var_35;
    wp::vec_t<3, wp::float32> var_36;
    wp::vec_t<3, wp::float32> var_37;
    wp::vec_t<3, wp::float32> var_38;
    const wp::int32 var_39 = 3;
    wp::mat_t<3, 3, wp::float32> var_40;
    const wp::float32 var_41 = 0.5;
    wp::float32 var_42;
    wp::mat_t<3, 3, wp::float32> var_43;
    wp::mat_t<3, 3, wp::float32> var_44;
    wp::mat_t<3, 3, wp::float32> var_45;
    const wp::float32 var_46 = 0.5;
    wp::float32 var_47;
    wp::mat_t<3, 3, wp::float32> var_48;
    wp::mat_t<3, 3, wp::float32> var_49;
    wp::mat_t<3, 3, wp::float32> var_50;
    wp::mat_t<3, 3, wp::float32> var_51;
    wp::mat_t<3, 3, wp::float32> var_52;
    wp::vec_t<3, wp::float32> var_53;
    wp::vec_t<3, wp::float32> var_54;
    const wp::int32 var_55 = 2;
    const wp::float32 var_56 = 0.5;
    wp::vec_t<3, wp::float32> var_57;
    wp::vec_t<3, wp::float32> var_58;
    wp::vec_t<3, wp::float32> var_59;
    wp::vec_t<3, wp::float32> var_60;
    wp::vec_t<3, wp::float32> var_61;
    wp::vec_t<3, wp::float32> var_62;
    wp::vec_t<3, wp::float32> var_63;
    const wp::int32 var_64 = 3;
    wp::mat_t<3, 3, wp::float32> var_65;
    const wp::float32 var_66 = 0.5;
    wp::float32 var_67;
    wp::mat_t<3, 3, wp::float32> var_68;
    wp::mat_t<3, 3, wp::float32> var_69;
    wp::mat_t<3, 3, wp::float32> var_70;
    const wp::float32 var_71 = 0.5;
    wp::float32 var_72;
    wp::mat_t<3, 3, wp::float32> var_73;
    wp::mat_t<3, 3, wp::float32> var_74;
    wp::mat_t<3, 3, wp::float32> var_75;
    wp::mat_t<3, 3, wp::float32> var_76;
    wp::mat_t<3, 3, wp::float32> var_77;
    wp::vec_t<3, wp::float32> var_78;
    wp::vec_t<3, wp::float32> var_79;
    const wp::int32 var_80 = 3;
    const wp::float32 var_81 = 0.5;
    wp::vec_t<3, wp::float32> var_82;
    wp::vec_t<3, wp::float32> var_83;
    wp::vec_t<3, wp::float32> var_84;
    wp::vec_t<3, wp::float32> var_85;
    wp::vec_t<3, wp::float32> var_86;
    wp::vec_t<3, wp::float32> var_87;
    wp::vec_t<3, wp::float32> var_88;
    const wp::int32 var_89 = 3;
    wp::mat_t<3, 3, wp::float32> var_90;
    const wp::float32 var_91 = 0.5;
    wp::float32 var_92;
    wp::mat_t<3, 3, wp::float32> var_93;
    wp::mat_t<3, 3, wp::float32> var_94;
    wp::mat_t<3, 3, wp::float32> var_95;
    const wp::float32 var_96 = 0.5;
    wp::float32 var_97;
    wp::mat_t<3, 3, wp::float32> var_98;
    wp::mat_t<3, 3, wp::float32> var_99;
    wp::mat_t<3, 3, wp::float32> var_100;
    wp::mat_t<3, 3, wp::float32> var_101;
    wp::mat_t<3, 3, wp::float32> var_102;
    wp::vec_t<3, wp::float32> var_103;
    wp::vec_t<3, wp::float32> var_104;
    const wp::int32 var_105 = 4;
    const wp::float32 var_106 = 0.5;
    wp::vec_t<3, wp::float32> var_107;
    wp::vec_t<3, wp::float32> var_108;
    wp::vec_t<3, wp::float32> var_109;
    wp::vec_t<3, wp::float32> var_110;
    wp::vec_t<3, wp::float32> var_111;
    wp::vec_t<3, wp::float32> var_112;
    wp::vec_t<3, wp::float32> var_113;
    const wp::int32 var_114 = 3;
    wp::mat_t<3, 3, wp::float32> var_115;
    const wp::float32 var_116 = 0.5;
    wp::float32 var_117;
    wp::mat_t<3, 3, wp::float32> var_118;
    wp::mat_t<3, 3, wp::float32> var_119;
    wp::mat_t<3, 3, wp::float32> var_120;
    const wp::float32 var_121 = 0.5;
    wp::float32 var_122;
    wp::mat_t<3, 3, wp::float32> var_123;
    wp::mat_t<3, 3, wp::float32> var_124;
    wp::mat_t<3, 3, wp::float32> var_125;
    wp::mat_t<3, 3, wp::float32> var_126;
    wp::mat_t<3, 3, wp::float32> var_127;
    wp::vec_t<3, wp::float32> var_128;
    wp::vec_t<3, wp::float32> var_129;
    const wp::int32 var_130 = 5;
    const wp::float32 var_131 = 0.5;
    wp::vec_t<3, wp::float32> var_132;
    wp::vec_t<3, wp::float32> var_133;
    wp::vec_t<3, wp::float32> var_134;
    wp::vec_t<3, wp::float32> var_135;
    wp::vec_t<3, wp::float32> var_136;
    wp::vec_t<3, wp::float32> var_137;
    wp::vec_t<3, wp::float32> var_138;
    const wp::int32 var_139 = 3;
    wp::mat_t<3, 3, wp::float32> var_140;
    const wp::float32 var_141 = 0.5;
    wp::float32 var_142;
    wp::mat_t<3, 3, wp::float32> var_143;
    wp::mat_t<3, 3, wp::float32> var_144;
    wp::mat_t<3, 3, wp::float32> var_145;
    const wp::float32 var_146 = 0.5;
    wp::float32 var_147;
    wp::mat_t<3, 3, wp::float32> var_148;
    wp::mat_t<3, 3, wp::float32> var_149;
    wp::mat_t<3, 3, wp::float32> var_150;
    wp::mat_t<3, 3, wp::float32> var_151;
    wp::mat_t<3, 3, wp::float32> var_152;
    wp::vec_t<3, wp::float32> var_153;
    wp::vec_t<3, wp::float32> var_154;
    const wp::int32 var_155 = 6;
    const wp::float32 var_156 = 0.5;
    wp::vec_t<3, wp::float32> var_157;
    wp::vec_t<3, wp::float32> var_158;
    wp::vec_t<3, wp::float32> var_159;
    wp::vec_t<3, wp::float32> var_160;
    wp::vec_t<3, wp::float32> var_161;
    wp::vec_t<3, wp::float32> var_162;
    wp::vec_t<3, wp::float32> var_163;
    const wp::int32 var_164 = 3;
    wp::mat_t<3, 3, wp::float32> var_165;
    const wp::float32 var_166 = 0.5;
    wp::float32 var_167;
    wp::mat_t<3, 3, wp::float32> var_168;
    wp::mat_t<3, 3, wp::float32> var_169;
    wp::mat_t<3, 3, wp::float32> var_170;
    const wp::float32 var_171 = 0.5;
    wp::float32 var_172;
    wp::mat_t<3, 3, wp::float32> var_173;
    wp::mat_t<3, 3, wp::float32> var_174;
    wp::mat_t<3, 3, wp::float32> var_175;
    wp::mat_t<3, 3, wp::float32> var_176;
    wp::mat_t<3, 3, wp::float32> var_177;
    wp::vec_t<3, wp::float32> var_178;
    wp::vec_t<3, wp::float32> var_179;
    const wp::int32 var_180 = 7;
    const wp::float32 var_181 = 0.5;
    wp::vec_t<3, wp::float32> var_182;
    wp::vec_t<3, wp::float32> var_183;
    wp::vec_t<3, wp::float32> var_184;
    wp::vec_t<3, wp::float32> var_185;
    wp::vec_t<3, wp::float32> var_186;
    wp::vec_t<3, wp::float32> var_187;
    wp::vec_t<3, wp::float32> var_188;
    const wp::int32 var_189 = 3;
    wp::mat_t<3, 3, wp::float32> var_190;
    const wp::float32 var_191 = 0.5;
    wp::float32 var_192;
    wp::mat_t<3, 3, wp::float32> var_193;
    wp::mat_t<3, 3, wp::float32> var_194;
    wp::mat_t<3, 3, wp::float32> var_195;
    const wp::float32 var_196 = 0.5;
    wp::float32 var_197;
    wp::mat_t<3, 3, wp::float32> var_198;
    wp::mat_t<3, 3, wp::float32> var_199;
    wp::mat_t<3, 3, wp::float32> var_200;
    wp::mat_t<3, 3, wp::float32> var_201;
    wp::mat_t<3, 3, wp::float32> var_202;
    wp::vec_t<3, wp::float32> var_203;
    wp::vec_t<3, wp::float32> var_204;
    const wp::float32 var_205 = 0.5;
    wp::vec_t<3, wp::float32> var_206;
    wp::vec_t<3, wp::float32> var_207;
    wp::vec_t<3, wp::float32> var_208;
    //---------
    // forward
    // def solve_energy_momentum_midpoint(                                                    <L 146>
    // inverse_inertia = wp.inverse(inertia)                                                  <L 152>
    var_0 = wp::inverse(var_inertia);
    // next_angular_momentum = angular_momentum + dt * wp.cross(                              <L 153>
    // angular_momentum,                                                                      <L 154>
    // inverse_inertia * angular_momentum,                                                    <L 155>
    var_1 = wp::mul(var_0, var_angular_momentum);
    var_2 = wp::cross(var_angular_momentum, var_1);
    var_3 = wp::mul(var_dt, var_2);
    var_4 = wp::add(var_angular_momentum, var_3);
    // for _ in range(8):                                                                     <L 158>
    // midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)           <L 159>
    var_7 = wp::add(var_angular_momentum, var_4);
    var_8 = wp::mul(var_6, var_7);
    // midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum                <L 160>
    var_9 = wp::mul(var_0, var_8);
    // residual = (                                                                           <L 161>
    // next_angular_momentum                                                                  <L 162>
    // - angular_momentum                                                                     <L 163>
    var_10 = wp::sub(var_4, var_angular_momentum);
    // - dt * wp.cross(midpoint_angular_momentum, midpoint_angular_velocity)                  <L 164>
    var_11 = wp::cross(var_8, var_9);
    var_12 = wp::mul(var_dt, var_11);
    var_13 = wp::sub(var_10, var_12);
    // jacobian = (                                                                           <L 166>
    // wp.identity(3, dtype=float)                                                            <L 167>
    var_15 = wp::identity<3, wp::float32>();
    // + 0.5 * dt * wp.skew(midpoint_angular_velocity)                                        <L 168>
    var_17 = wp::mul(var_16, var_dt);
    var_18 = wp::skew(var_9);
    var_19 = wp::mul(var_17, var_18);
    var_20 = wp::add(var_15, var_19);
    // - 0.5 * dt * wp.skew(midpoint_angular_momentum) * inverse_inertia                      <L 169>
    var_22 = wp::mul(var_21, var_dt);
    var_23 = wp::skew(var_8);
    var_24 = wp::mul(var_22, var_23);
    var_25 = wp::mul(var_24, var_0);
    var_26 = wp::sub(var_20, var_25);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 171>
    var_27 = wp::inverse(var_26);
    var_28 = wp::mul(var_27, var_13);
    var_29 = wp::sub(var_4, var_28);
    // midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)           <L 159>
    var_32 = wp::add(var_angular_momentum, var_29);
    var_33 = wp::mul(var_31, var_32);
    // midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum                <L 160>
    var_34 = wp::mul(var_0, var_33);
    // residual = (                                                                           <L 161>
    // next_angular_momentum                                                                  <L 162>
    // - angular_momentum                                                                     <L 163>
    var_35 = wp::sub(var_29, var_angular_momentum);
    // - dt * wp.cross(midpoint_angular_momentum, midpoint_angular_velocity)                  <L 164>
    var_36 = wp::cross(var_33, var_34);
    var_37 = wp::mul(var_dt, var_36);
    var_38 = wp::sub(var_35, var_37);
    // jacobian = (                                                                           <L 166>
    // wp.identity(3, dtype=float)                                                            <L 167>
    var_40 = wp::identity<3, wp::float32>();
    // + 0.5 * dt * wp.skew(midpoint_angular_velocity)                                        <L 168>
    var_42 = wp::mul(var_41, var_dt);
    var_43 = wp::skew(var_34);
    var_44 = wp::mul(var_42, var_43);
    var_45 = wp::add(var_40, var_44);
    // - 0.5 * dt * wp.skew(midpoint_angular_momentum) * inverse_inertia                      <L 169>
    var_47 = wp::mul(var_46, var_dt);
    var_48 = wp::skew(var_33);
    var_49 = wp::mul(var_47, var_48);
    var_50 = wp::mul(var_49, var_0);
    var_51 = wp::sub(var_45, var_50);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 171>
    var_52 = wp::inverse(var_51);
    var_53 = wp::mul(var_52, var_38);
    var_54 = wp::sub(var_29, var_53);
    // midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)           <L 159>
    var_57 = wp::add(var_angular_momentum, var_54);
    var_58 = wp::mul(var_56, var_57);
    // midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum                <L 160>
    var_59 = wp::mul(var_0, var_58);
    // residual = (                                                                           <L 161>
    // next_angular_momentum                                                                  <L 162>
    // - angular_momentum                                                                     <L 163>
    var_60 = wp::sub(var_54, var_angular_momentum);
    // - dt * wp.cross(midpoint_angular_momentum, midpoint_angular_velocity)                  <L 164>
    var_61 = wp::cross(var_58, var_59);
    var_62 = wp::mul(var_dt, var_61);
    var_63 = wp::sub(var_60, var_62);
    // jacobian = (                                                                           <L 166>
    // wp.identity(3, dtype=float)                                                            <L 167>
    var_65 = wp::identity<3, wp::float32>();
    // + 0.5 * dt * wp.skew(midpoint_angular_velocity)                                        <L 168>
    var_67 = wp::mul(var_66, var_dt);
    var_68 = wp::skew(var_59);
    var_69 = wp::mul(var_67, var_68);
    var_70 = wp::add(var_65, var_69);
    // - 0.5 * dt * wp.skew(midpoint_angular_momentum) * inverse_inertia                      <L 169>
    var_72 = wp::mul(var_71, var_dt);
    var_73 = wp::skew(var_58);
    var_74 = wp::mul(var_72, var_73);
    var_75 = wp::mul(var_74, var_0);
    var_76 = wp::sub(var_70, var_75);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 171>
    var_77 = wp::inverse(var_76);
    var_78 = wp::mul(var_77, var_63);
    var_79 = wp::sub(var_54, var_78);
    // midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)           <L 159>
    var_82 = wp::add(var_angular_momentum, var_79);
    var_83 = wp::mul(var_81, var_82);
    // midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum                <L 160>
    var_84 = wp::mul(var_0, var_83);
    // residual = (                                                                           <L 161>
    // next_angular_momentum                                                                  <L 162>
    // - angular_momentum                                                                     <L 163>
    var_85 = wp::sub(var_79, var_angular_momentum);
    // - dt * wp.cross(midpoint_angular_momentum, midpoint_angular_velocity)                  <L 164>
    var_86 = wp::cross(var_83, var_84);
    var_87 = wp::mul(var_dt, var_86);
    var_88 = wp::sub(var_85, var_87);
    // jacobian = (                                                                           <L 166>
    // wp.identity(3, dtype=float)                                                            <L 167>
    var_90 = wp::identity<3, wp::float32>();
    // + 0.5 * dt * wp.skew(midpoint_angular_velocity)                                        <L 168>
    var_92 = wp::mul(var_91, var_dt);
    var_93 = wp::skew(var_84);
    var_94 = wp::mul(var_92, var_93);
    var_95 = wp::add(var_90, var_94);
    // - 0.5 * dt * wp.skew(midpoint_angular_momentum) * inverse_inertia                      <L 169>
    var_97 = wp::mul(var_96, var_dt);
    var_98 = wp::skew(var_83);
    var_99 = wp::mul(var_97, var_98);
    var_100 = wp::mul(var_99, var_0);
    var_101 = wp::sub(var_95, var_100);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 171>
    var_102 = wp::inverse(var_101);
    var_103 = wp::mul(var_102, var_88);
    var_104 = wp::sub(var_79, var_103);
    // midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)           <L 159>
    var_107 = wp::add(var_angular_momentum, var_104);
    var_108 = wp::mul(var_106, var_107);
    // midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum                <L 160>
    var_109 = wp::mul(var_0, var_108);
    // residual = (                                                                           <L 161>
    // next_angular_momentum                                                                  <L 162>
    // - angular_momentum                                                                     <L 163>
    var_110 = wp::sub(var_104, var_angular_momentum);
    // - dt * wp.cross(midpoint_angular_momentum, midpoint_angular_velocity)                  <L 164>
    var_111 = wp::cross(var_108, var_109);
    var_112 = wp::mul(var_dt, var_111);
    var_113 = wp::sub(var_110, var_112);
    // jacobian = (                                                                           <L 166>
    // wp.identity(3, dtype=float)                                                            <L 167>
    var_115 = wp::identity<3, wp::float32>();
    // + 0.5 * dt * wp.skew(midpoint_angular_velocity)                                        <L 168>
    var_117 = wp::mul(var_116, var_dt);
    var_118 = wp::skew(var_109);
    var_119 = wp::mul(var_117, var_118);
    var_120 = wp::add(var_115, var_119);
    // - 0.5 * dt * wp.skew(midpoint_angular_momentum) * inverse_inertia                      <L 169>
    var_122 = wp::mul(var_121, var_dt);
    var_123 = wp::skew(var_108);
    var_124 = wp::mul(var_122, var_123);
    var_125 = wp::mul(var_124, var_0);
    var_126 = wp::sub(var_120, var_125);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 171>
    var_127 = wp::inverse(var_126);
    var_128 = wp::mul(var_127, var_113);
    var_129 = wp::sub(var_104, var_128);
    // midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)           <L 159>
    var_132 = wp::add(var_angular_momentum, var_129);
    var_133 = wp::mul(var_131, var_132);
    // midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum                <L 160>
    var_134 = wp::mul(var_0, var_133);
    // residual = (                                                                           <L 161>
    // next_angular_momentum                                                                  <L 162>
    // - angular_momentum                                                                     <L 163>
    var_135 = wp::sub(var_129, var_angular_momentum);
    // - dt * wp.cross(midpoint_angular_momentum, midpoint_angular_velocity)                  <L 164>
    var_136 = wp::cross(var_133, var_134);
    var_137 = wp::mul(var_dt, var_136);
    var_138 = wp::sub(var_135, var_137);
    // jacobian = (                                                                           <L 166>
    // wp.identity(3, dtype=float)                                                            <L 167>
    var_140 = wp::identity<3, wp::float32>();
    // + 0.5 * dt * wp.skew(midpoint_angular_velocity)                                        <L 168>
    var_142 = wp::mul(var_141, var_dt);
    var_143 = wp::skew(var_134);
    var_144 = wp::mul(var_142, var_143);
    var_145 = wp::add(var_140, var_144);
    // - 0.5 * dt * wp.skew(midpoint_angular_momentum) * inverse_inertia                      <L 169>
    var_147 = wp::mul(var_146, var_dt);
    var_148 = wp::skew(var_133);
    var_149 = wp::mul(var_147, var_148);
    var_150 = wp::mul(var_149, var_0);
    var_151 = wp::sub(var_145, var_150);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 171>
    var_152 = wp::inverse(var_151);
    var_153 = wp::mul(var_152, var_138);
    var_154 = wp::sub(var_129, var_153);
    // midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)           <L 159>
    var_157 = wp::add(var_angular_momentum, var_154);
    var_158 = wp::mul(var_156, var_157);
    // midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum                <L 160>
    var_159 = wp::mul(var_0, var_158);
    // residual = (                                                                           <L 161>
    // next_angular_momentum                                                                  <L 162>
    // - angular_momentum                                                                     <L 163>
    var_160 = wp::sub(var_154, var_angular_momentum);
    // - dt * wp.cross(midpoint_angular_momentum, midpoint_angular_velocity)                  <L 164>
    var_161 = wp::cross(var_158, var_159);
    var_162 = wp::mul(var_dt, var_161);
    var_163 = wp::sub(var_160, var_162);
    // jacobian = (                                                                           <L 166>
    // wp.identity(3, dtype=float)                                                            <L 167>
    var_165 = wp::identity<3, wp::float32>();
    // + 0.5 * dt * wp.skew(midpoint_angular_velocity)                                        <L 168>
    var_167 = wp::mul(var_166, var_dt);
    var_168 = wp::skew(var_159);
    var_169 = wp::mul(var_167, var_168);
    var_170 = wp::add(var_165, var_169);
    // - 0.5 * dt * wp.skew(midpoint_angular_momentum) * inverse_inertia                      <L 169>
    var_172 = wp::mul(var_171, var_dt);
    var_173 = wp::skew(var_158);
    var_174 = wp::mul(var_172, var_173);
    var_175 = wp::mul(var_174, var_0);
    var_176 = wp::sub(var_170, var_175);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 171>
    var_177 = wp::inverse(var_176);
    var_178 = wp::mul(var_177, var_163);
    var_179 = wp::sub(var_154, var_178);
    // midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)           <L 159>
    var_182 = wp::add(var_angular_momentum, var_179);
    var_183 = wp::mul(var_181, var_182);
    // midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum                <L 160>
    var_184 = wp::mul(var_0, var_183);
    // residual = (                                                                           <L 161>
    // next_angular_momentum                                                                  <L 162>
    // - angular_momentum                                                                     <L 163>
    var_185 = wp::sub(var_179, var_angular_momentum);
    // - dt * wp.cross(midpoint_angular_momentum, midpoint_angular_velocity)                  <L 164>
    var_186 = wp::cross(var_183, var_184);
    var_187 = wp::mul(var_dt, var_186);
    var_188 = wp::sub(var_185, var_187);
    // jacobian = (                                                                           <L 166>
    // wp.identity(3, dtype=float)                                                            <L 167>
    var_190 = wp::identity<3, wp::float32>();
    // + 0.5 * dt * wp.skew(midpoint_angular_velocity)                                        <L 168>
    var_192 = wp::mul(var_191, var_dt);
    var_193 = wp::skew(var_184);
    var_194 = wp::mul(var_192, var_193);
    var_195 = wp::add(var_190, var_194);
    // - 0.5 * dt * wp.skew(midpoint_angular_momentum) * inverse_inertia                      <L 169>
    var_197 = wp::mul(var_196, var_dt);
    var_198 = wp::skew(var_183);
    var_199 = wp::mul(var_197, var_198);
    var_200 = wp::mul(var_199, var_0);
    var_201 = wp::sub(var_195, var_200);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 171>
    var_202 = wp::inverse(var_201);
    var_203 = wp::mul(var_202, var_188);
    var_204 = wp::sub(var_179, var_203);
    // midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)           <L 173>
    var_206 = wp::add(var_angular_momentum, var_204);
    var_207 = wp::mul(var_205, var_206);
    // midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum                <L 174>
    var_208 = wp::mul(var_0, var_207);
    // return (                                                                               <L 175>
    // next_angular_momentum,                                                                 <L 176>
    // midpoint_angular_momentum,                                                             <L 177>
    // midpoint_angular_velocity,                                                             <L 178>
    ret_0 = var_204;
    ret_1 = var_207;
    ret_2 = var_208;
    return;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:182
static CUDA_CALLABLE wp::mat_t<3, 3, wp::float32> cayley_increment_from_midpoint_0(
    wp::vec_t<3, wp::float32> var_midpoint_angular_velocity,
    wp::float32 var_dt)
{
    //---------
    // primal vars
    const wp::int32 var_0 = 3;
    wp::mat_t<3, 3, wp::float32> var_1;
    wp::mat_t<3, 3, wp::float32> var_2;
    wp::mat_t<3, 3, wp::float32> var_3;
    const wp::float32 var_4 = 0.5;
    wp::mat_t<3, 3, wp::float32> var_5;
    wp::mat_t<3, 3, wp::float32> var_6;
    wp::mat_t<3, 3, wp::float32> var_7;
    const wp::float32 var_8 = 0.5;
    wp::mat_t<3, 3, wp::float32> var_9;
    wp::mat_t<3, 3, wp::float32> var_10;
    wp::mat_t<3, 3, wp::float32> var_11;
    //---------
    // forward
    // def cayley_increment_from_midpoint(                                                    <L 183>
    // identity = wp.identity(3, dtype=float)                                                 <L 188>
    var_1 = wp::identity<3, wp::float32>();
    // generator = dt * wp.skew(midpoint_angular_velocity)                                    <L 189>
    var_2 = wp::skew(var_midpoint_angular_velocity);
    var_3 = wp::mul(var_dt, var_2);
    // return wp.inverse(identity - 0.5 * generator) * (identity + 0.5 * generator)           <L 190>
    var_5 = wp::mul(var_4, var_3);
    var_6 = wp::sub(var_1, var_5);
    var_7 = wp::inverse(var_6);
    var_9 = wp::mul(var_8, var_3);
    var_10 = wp::add(var_1, var_9);
    var_11 = wp::mul(var_7, var_10);
    return var_11;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:193
static CUDA_CALLABLE void integrate_midpoint_cayley_0(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::vec_t<3, wp::float32> var_angular_momentum,
    wp::float32 var_dt,
    wp::vec_t<3, wp::float32> & ret_0,
    wp::mat_t<3, 3, wp::float32> & ret_1)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    wp::vec_t<3, wp::float32> var_1;
    wp::vec_t<3, wp::float32> var_2;
    wp::mat_t<3, 3, wp::float32> var_3;
    //---------
    // forward
    // def integrate_midpoint_cayley(                                                         <L 194>
    // next_angular_momentum, _midpoint_momentum, midpoint_velocity = (                       <L 200>
    // solve_energy_momentum_midpoint(inertia, angular_momentum, dt)                          <L 201>
    solve_energy_momentum_midpoint_0(var_inertia, var_angular_momentum, var_dt, var_0, var_1, var_2);
    // relative_rotation = cayley_increment_from_midpoint(midpoint_velocity, dt)              <L 203>
    var_3 = cayley_increment_from_midpoint_0(var_2, var_dt);
    // return next_angular_momentum, relative_rotation                                        <L 204>
    ret_0 = var_0;
    ret_1 = var_3;
    return;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:225
static CUDA_CALLABLE void integrate_rigid_body_1(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::vec_t<3, wp::float32> var_angular_momentum,
    wp::float32 var_dt,
    wp::int32 var_integrator,
    wp::vec_t<3, wp::float32> & ret_0,
    wp::mat_t<3, 3, wp::float32> & ret_1)
{
    //---------
    // primal vars
    const wp::int32 var_0 = 0;
    bool var_1;
    wp::vec_t<3, wp::float32> var_2;
    wp::mat_t<3, 3, wp::float32> var_3;
    const wp::int32 var_4 = 1;
    bool var_5;
    wp::vec_t<3, wp::float32> var_6;
    wp::mat_t<3, 3, wp::float32> var_7;
    const wp::int32 var_8 = 2;
    bool var_9;
    wp::vec_t<3, wp::float32> var_10;
    wp::mat_t<3, 3, wp::float32> var_11;
    const wp::int32 var_12 = 3;
    bool var_13;
    wp::vec_t<3, wp::float32> var_14;
    wp::mat_t<3, 3, wp::float32> var_15;
    const wp::int32 var_16 = 5;
    bool var_17;
    const wp::float32 var_18 = 0.0;
    wp::vec_t<3, wp::float32> var_19;
    wp::vec_t<3, wp::float32> var_20;
    wp::mat_t<3, 3, wp::float32> var_21;
    //---------
    // forward
    // def integrate_rigid_body(                                                              <L 226>
    // if integrator == EXPLICIT_EULER:                                                       <L 233>
    var_1 = (var_integrator == var_0);
    if (var_1) {
        // return integrate_explicit_euler(inertia, angular_momentum, dt)                     <L 234>
        integrate_explicit_euler_0(var_inertia, var_angular_momentum, var_dt, var_2, var_3);
        ret_0 = var_2;
        ret_1 = var_3;
        return;
    }
    if (!var_1) {
        // elif integrator == IMPLICIT_EULER:                                                 <L 235>
        var_5 = (var_integrator == var_4);
        if (var_5) {
            // return integrate_implicit_euler(inertia, angular_momentum, dt)                 <L 236>
            integrate_implicit_euler_0(var_inertia, var_angular_momentum, var_dt, var_6, var_7);
            ret_0 = var_6;
            ret_1 = var_7;
            return;
        }
        if (!var_5) {
            // elif integrator == LIE_GROUP_MIDPOINT:                                         <L 237>
            var_9 = (var_integrator == var_8);
            if (var_9) {
                // return integrate_lie_group_midpoint(inertia, angular_momentum, dt)         <L 238>
                integrate_lie_group_midpoint_0(var_inertia, var_angular_momentum, var_dt, var_10, var_11);
                ret_0 = var_10;
                ret_1 = var_11;
                return;
            }
            if (!var_9) {
                // elif integrator == MIDPOINT_CAYLEY:                                        <L 239>
                var_13 = (var_integrator == var_12);
                if (var_13) {
                    // return integrate_midpoint_cayley(inertia, angular_momentum, dt)        <L 240>
                    integrate_midpoint_cayley_0(var_inertia, var_angular_momentum, var_dt, var_14, var_15);
                    ret_0 = var_14;
                    ret_1 = var_15;
                    return;
                }
                if (!var_13) {
                    // elif integrator == VBD_SEMI_IMPLICIT:                                  <L 241>
                    var_17 = (var_integrator == var_16);
                    if (var_17) {
                        // return integrate_vbd_semi_implicit(inertia, angular_momentum, wp.vec3(0.0), dt)       <L 244>
                        var_19 = wp::vec_t<3, wp::float32>(var_18);
                        integrate_vbd_semi_implicit_0(var_inertia, var_angular_momentum, var_19, var_dt, var_20, var_21);
                        ret_0 = var_20;
                        ret_1 = var_21;
                        return;
                    }
                }
            }
        }
    }
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:58
static CUDA_CALLABLE void adj__logarithmic_velocity_0(
    wp::mat_t<3, 3, wp::float32> var_relative_rotation,
    wp::float32 var_dt,
    wp::mat_t<3, 3, wp::float32> & adj_relative_rotation,
    wp::float32 & adj_dt,
    wp::vec_t<3, wp::float32> & adj_ret)
{
    //---------
    // primal vars
    wp::quat_t<wp::float32> var_0;
    const wp::int32 var_1 = 3;
    wp::float32 var_2;
    const wp::float32 var_3 = 0.0;
    bool var_4;
    const wp::int32 var_5 = 0;
    wp::float32 var_6;
    wp::float32 var_7;
    const wp::int32 var_8 = 1;
    wp::float32 var_9;
    wp::float32 var_10;
    const wp::int32 var_11 = 2;
    wp::float32 var_12;
    wp::float32 var_13;
    const wp::int32 var_14 = 3;
    wp::float32 var_15;
    wp::float32 var_16;
    wp::quat_t<wp::float32> var_17;
    wp::quat_t<wp::float32> var_18;
    wp::vec_t<3, wp::float32> var_19;
    wp::float32 var_20;
    wp::vec_t<3, wp::float32> var_21;
    wp::vec_t<3, wp::float32> var_22;
    //---------
    // dual vars
    wp::quat_t<wp::float32> adj_0 = {};
    wp::int32 adj_1 = {};
    wp::float32 adj_2 = {};
    wp::float32 adj_3 = {};
    bool adj_4 = {};
    wp::int32 adj_5 = {};
    wp::float32 adj_6 = {};
    wp::float32 adj_7 = {};
    wp::int32 adj_8 = {};
    wp::float32 adj_9 = {};
    wp::float32 adj_10 = {};
    wp::int32 adj_11 = {};
    wp::float32 adj_12 = {};
    wp::float32 adj_13 = {};
    wp::int32 adj_14 = {};
    wp::float32 adj_15 = {};
    wp::float32 adj_16 = {};
    wp::quat_t<wp::float32> adj_17 = {};
    wp::quat_t<wp::float32> adj_18 = {};
    wp::vec_t<3, wp::float32> adj_19 = {};
    wp::float32 adj_20 = {};
    wp::vec_t<3, wp::float32> adj_21 = {};
    wp::vec_t<3, wp::float32> adj_22 = {};
    //---------
    // forward
    // def _logarithmic_velocity(relative_rotation: wp.mat33, dt: float) -> wp.vec3:          <L 59>
    // rotation = wp.quat_from_matrix(relative_rotation)                                      <L 61>
    var_0 = wp::quat_from_matrix(var_relative_rotation);
    // if rotation[3] < 0.0:                                                                  <L 62>
    var_2 = wp::extract(var_0, var_1);
    var_4 = (var_2 < var_3);
    if (var_4) {
        // rotation = wp.quat(                                                                <L 63>
        // -rotation[0],                                                                      <L 64>
        var_6 = wp::extract(var_0, var_5);
        var_7 = wp::neg(var_6);
        // -rotation[1],                                                                      <L 65>
        var_9 = wp::extract(var_0, var_8);
        var_10 = wp::neg(var_9);
        // -rotation[2],                                                                      <L 66>
        var_12 = wp::extract(var_0, var_11);
        var_13 = wp::neg(var_12);
        // -rotation[3],                                                                      <L 67>
        var_15 = wp::extract(var_0, var_14);
        var_16 = wp::neg(var_15);
        var_17 = wp::quat_t<wp::float32>(var_7, var_10, var_13, var_16);
    }
    var_18 = wp::where(var_4, var_17, var_0);
    // axis, angle = wp.quat_to_axis_angle(rotation)                                          <L 69>
    wp::quat_to_axis_angle(var_18, var_19, var_20);
    // return axis * angle / dt                                                               <L 70>
    var_21 = wp::mul(var_19, var_20);
    var_22 = wp::div(var_21, var_dt);
    goto label0;
    //---------
    // reverse
    label0:;
    adj_22 += adj_ret;
    wp::adj_div(var_21, var_dt, adj_21, adj_dt, adj_22);
    wp::adj_mul(var_19, var_20, adj_19, adj_20, adj_21);
    // adj: return axis * angle / dt                                                          <L 70>
    wp::adj_quat_to_axis_angle(var_18, var_19, var_20, adj_18, adj_19, adj_20);
    // adj: axis, angle = wp.quat_to_axis_angle(rotation)                                     <L 69>
    wp::adj_where(var_4, var_17, var_0, adj_4, adj_17, adj_0, adj_18);
    if (var_4) {
        wp::adj_quat_t(var_7, var_10, var_13, var_16, adj_7, adj_10, adj_13, adj_16, adj_17);
        wp::adj_neg(var_15, adj_15, adj_16);
        wp::adj_extract(var_0, var_14, adj_0, adj_14, adj_15);
        // adj: -rotation[3],                                                                 <L 67>
        wp::adj_neg(var_12, adj_12, adj_13);
        wp::adj_extract(var_0, var_11, adj_0, adj_11, adj_12);
        // adj: -rotation[2],                                                                 <L 66>
        wp::adj_neg(var_9, adj_9, adj_10);
        wp::adj_extract(var_0, var_8, adj_0, adj_8, adj_9);
        // adj: -rotation[1],                                                                 <L 65>
        wp::adj_neg(var_6, adj_6, adj_7);
        wp::adj_extract(var_0, var_5, adj_0, adj_5, adj_6);
        // adj: -rotation[0],                                                                 <L 64>
        // adj: rotation = wp.quat(                                                           <L 63>
    }
    wp::adj_extract(var_0, var_1, adj_0, adj_1, adj_2);
    // adj: if rotation[3] < 0.0:                                                             <L 62>
    wp::adj_quat_from_matrix(var_relative_rotation, adj_relative_rotation, adj_0);
    // adj: rotation = wp.quat_from_matrix(relative_rotation)                                 <L 61>
    // adj: def _logarithmic_velocity(relative_rotation: wp.mat33, dt: float) -> wp.vec3:     <L 59>
    return;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:247
static CUDA_CALLABLE void adj_recover_explicit_euler_end_velocity_0(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::mat_t<3, 3, wp::float32> var_relative_rotation,
    wp::float32 var_dt,
    wp::mat_t<3, 3, wp::float32> & adj_inertia,
    wp::mat_t<3, 3, wp::float32> & adj_relative_rotation,
    wp::float32 & adj_dt,
    wp::vec_t<3, wp::float32> & adj_ret)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    wp::vec_t<3, wp::float32> var_1;
    wp::vec_t<3, wp::float32> var_2;
    wp::vec_t<3, wp::float32> var_3;
    wp::vec_t<3, wp::float32> var_4;
    wp::mat_t<3, 3, wp::float32> var_5;
    wp::vec_t<3, wp::float32> var_6;
    //---------
    // dual vars
    wp::vec_t<3, wp::float32> adj_0 = {};
    wp::vec_t<3, wp::float32> adj_1 = {};
    wp::vec_t<3, wp::float32> adj_2 = {};
    wp::vec_t<3, wp::float32> adj_3 = {};
    wp::vec_t<3, wp::float32> adj_4 = {};
    wp::mat_t<3, 3, wp::float32> adj_5 = {};
    wp::vec_t<3, wp::float32> adj_6 = {};
    //---------
    // forward
    // def recover_explicit_euler_end_velocity(                                               <L 248>
    // initial_velocity = _logarithmic_velocity(relative_rotation, dt)                        <L 254>
    var_0 = _logarithmic_velocity_0(var_relative_rotation, var_dt);
    // initial_momentum = inertia * initial_velocity                                          <L 255>
    var_1 = wp::mul(var_inertia, var_0);
    // next_momentum = initial_momentum + dt * wp.cross(initial_momentum, initial_velocity)       <L 256>
    var_2 = wp::cross(var_1, var_0);
    var_3 = wp::mul(var_dt, var_2);
    var_4 = wp::add(var_1, var_3);
    // return wp.inverse(inertia) * next_momentum                                             <L 257>
    var_5 = wp::inverse(var_inertia);
    var_6 = wp::mul(var_5, var_4);
    goto label0;
    //---------
    // reverse
    label0:;
    adj_6 += adj_ret;
    wp::adj_mul(var_5, var_4, adj_5, adj_4, adj_6);
    wp::adj_inverse(var_inertia, var_5, adj_inertia, adj_5);
    // adj: return wp.inverse(inertia) * next_momentum                                        <L 257>
    wp::adj_add(var_1, var_3, adj_1, adj_3, adj_4);
    wp::adj_mul(var_dt, var_2, adj_dt, adj_2, adj_3);
    wp::adj_cross(var_1, var_0, adj_1, adj_0, adj_2);
    // adj: next_momentum = initial_momentum + dt * wp.cross(initial_momentum, initial_velocity)  <L 256>
    wp::adj_mul(var_inertia, var_0, adj_inertia, adj_0, adj_1);
    // adj: initial_momentum = inertia * initial_velocity                                     <L 255>
    adj__logarithmic_velocity_0(var_relative_rotation, var_dt, adj_relative_rotation, adj_dt, adj_0);
    // adj: initial_velocity = _logarithmic_velocity(relative_rotation, dt)                   <L 254>
    // adj: def recover_explicit_euler_end_velocity(                                          <L 248>
    return;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:260
static CUDA_CALLABLE void adj_recover_implicit_euler_end_velocity_0(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::mat_t<3, 3, wp::float32> var_relative_rotation,
    wp::float32 var_dt,
    wp::mat_t<3, 3, wp::float32> & adj_inertia,
    wp::mat_t<3, 3, wp::float32> & adj_relative_rotation,
    wp::float32 & adj_dt,
    wp::vec_t<3, wp::float32> & adj_ret)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    //---------
    // dual vars
    wp::vec_t<3, wp::float32> adj_0 = {};
    //---------
    // forward
    // def recover_implicit_euler_end_velocity(                                               <L 261>
    // return _logarithmic_velocity(relative_rotation, dt)                                    <L 267>
    var_0 = _logarithmic_velocity_0(var_relative_rotation, var_dt);
    goto label0;
    //---------
    // reverse
    label0:;
    adj_0 += adj_ret;
    adj__logarithmic_velocity_0(var_relative_rotation, var_dt, adj_relative_rotation, adj_dt, adj_0);
    // adj: return _logarithmic_velocity(relative_rotation, dt)                               <L 267>
    // adj: def recover_implicit_euler_end_velocity(                                          <L 261>
    return;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:47
static CUDA_CALLABLE void adj__exponential_increment_0(
    wp::vec_t<3, wp::float32> var_angular_velocity,
    wp::float32 var_dt,
    wp::vec_t<3, wp::float32> & adj_angular_velocity,
    wp::float32 & adj_dt,
    wp::mat_t<3, 3, wp::float32> & adj_ret)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    wp::float32 var_1;
    const wp::float32 var_2 = 1e-08;
    bool var_3;
    wp::vec_t<3, wp::float32> var_4;
    wp::quat_t<wp::float32> var_5;
    wp::mat_t<3, 3, wp::float32> var_6;
    const wp::int32 var_7 = 3;
    wp::mat_t<3, 3, wp::float32> var_8;
    //---------
    // dual vars
    wp::vec_t<3, wp::float32> adj_0 = {};
    wp::float32 adj_1 = {};
    wp::float32 adj_2 = {};
    bool adj_3 = {};
    wp::vec_t<3, wp::float32> adj_4 = {};
    wp::quat_t<wp::float32> adj_5 = {};
    wp::mat_t<3, 3, wp::float32> adj_6 = {};
    wp::int32 adj_7 = {};
    wp::mat_t<3, 3, wp::float32> adj_8 = {};
    //---------
    // forward
    // def _exponential_increment(angular_velocity: wp.vec3, dt: float) -> wp.mat33:          <L 48>
    // rotation_vector = dt * angular_velocity                                                <L 50>
    var_0 = wp::mul(var_dt, var_angular_velocity);
    // angle = wp.length(rotation_vector)                                                     <L 51>
    var_1 = wp::length(var_0);
    // if angle > 1.0e-8:                                                                     <L 52>
    var_3 = (var_1 > var_2);
    if (var_3) {
        // rotation = wp.quat_from_axis_angle(rotation_vector / angle, angle)                 <L 53>
        var_4 = wp::div(var_0, var_1);
        var_5 = wp::quat_from_axis_angle(var_4, var_1);
        // return wp.quat_to_matrix(rotation)                                                 <L 54>
        var_6 = wp::quat_to_matrix(var_5);
        goto label0;
    }
    // return wp.identity(3, dtype=float)                                                     <L 55>
    var_8 = wp::identity<3, wp::float32>();
    goto label1;
    //---------
    // reverse
    label1:;
    adj_8 += adj_ret;
    // adj: return wp.identity(3, dtype=float)                                                <L 55>
    if (var_3) {
        label0:;
        adj_6 += adj_ret;
        wp::adj_quat_to_matrix(var_5, adj_5, adj_6);
        // adj: return wp.quat_to_matrix(rotation)                                            <L 54>
        wp::adj_quat_from_axis_angle(var_4, var_1, adj_4, adj_1, adj_5);
        wp::adj_div(var_0, var_1, adj_0, adj_1, adj_4);
        // adj: rotation = wp.quat_from_axis_angle(rotation_vector / angle, angle)            <L 53>
    }
    // adj: if angle > 1.0e-8:                                                                <L 52>
    wp::adj_length(var_0, var_1, adj_0, adj_1);
    // adj: angle = wp.length(rotation_vector)                                                <L 51>
    wp::adj_mul(var_dt, var_angular_velocity, adj_dt, adj_angular_velocity, adj_0);
    // adj: rotation_vector = dt * angular_velocity                                           <L 50>
    // adj: def _exponential_increment(angular_velocity: wp.vec3, dt: float) -> wp.mat33:     <L 48>
    return;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:270
static CUDA_CALLABLE void adj_recover_lie_group_midpoint_end_velocity_0(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::mat_t<3, 3, wp::float32> var_relative_rotation,
    wp::float32 var_dt,
    wp::mat_t<3, 3, wp::float32> & adj_inertia,
    wp::mat_t<3, 3, wp::float32> & adj_relative_rotation,
    wp::float32 & adj_dt,
    wp::vec_t<3, wp::float32> & adj_ret)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    const wp::float32 var_1 = 0.5;
    wp::float32 var_2;
    wp::mat_t<3, 3, wp::float32> var_3;
    wp::mat_t<3, 3, wp::float32> var_4;
    wp::mat_t<3, 3, wp::float32> var_5;
    wp::mat_t<3, 3, wp::float32> var_6;
    wp::vec_t<3, wp::float32> var_7;
    wp::mat_t<3, 3, wp::float32> var_8;
    wp::vec_t<3, wp::float32> var_9;
    wp::mat_t<3, 3, wp::float32> var_10;
    wp::vec_t<3, wp::float32> var_11;
    //---------
    // dual vars
    wp::vec_t<3, wp::float32> adj_0 = {};
    wp::float32 adj_1 = {};
    wp::float32 adj_2 = {};
    wp::mat_t<3, 3, wp::float32> adj_3 = {};
    wp::mat_t<3, 3, wp::float32> adj_4 = {};
    wp::mat_t<3, 3, wp::float32> adj_5 = {};
    wp::mat_t<3, 3, wp::float32> adj_6 = {};
    wp::vec_t<3, wp::float32> adj_7 = {};
    wp::mat_t<3, 3, wp::float32> adj_8 = {};
    wp::vec_t<3, wp::float32> adj_9 = {};
    wp::mat_t<3, 3, wp::float32> adj_10 = {};
    wp::vec_t<3, wp::float32> adj_11 = {};
    //---------
    // forward
    // def recover_lie_group_midpoint_end_velocity(                                           <L 271>
    // midpoint_velocity = _logarithmic_velocity(relative_rotation, dt)                       <L 277>
    var_0 = _logarithmic_velocity_0(var_relative_rotation, var_dt);
    // half_rotation = _exponential_increment(midpoint_velocity, 0.5 * dt)                    <L 278>
    var_2 = wp::mul(var_1, var_dt);
    var_3 = _exponential_increment_0(var_0, var_2);
    // initial_momentum = (                                                                   <L 279>
    // half_rotation * inertia * wp.transpose(half_rotation) * midpoint_velocity              <L 280>
    var_4 = wp::mul(var_3, var_inertia);
    var_5 = wp::transpose(var_3);
    var_6 = wp::mul(var_4, var_5);
    var_7 = wp::mul(var_6, var_0);
    // next_momentum = wp.transpose(relative_rotation) * initial_momentum                     <L 282>
    var_8 = wp::transpose(var_relative_rotation);
    var_9 = wp::mul(var_8, var_7);
    // return wp.inverse(inertia) * next_momentum                                             <L 283>
    var_10 = wp::inverse(var_inertia);
    var_11 = wp::mul(var_10, var_9);
    goto label0;
    //---------
    // reverse
    label0:;
    adj_11 += adj_ret;
    wp::adj_mul(var_10, var_9, adj_10, adj_9, adj_11);
    wp::adj_inverse(var_inertia, var_10, adj_inertia, adj_10);
    // adj: return wp.inverse(inertia) * next_momentum                                        <L 283>
    wp::adj_mul(var_8, var_7, adj_8, adj_7, adj_9);
    wp::adj_transpose(var_relative_rotation, adj_relative_rotation, adj_8);
    // adj: next_momentum = wp.transpose(relative_rotation) * initial_momentum                <L 282>
    wp::adj_mul(var_6, var_0, adj_6, adj_0, adj_7);
    wp::adj_mul(var_4, var_5, adj_4, adj_5, adj_6);
    wp::adj_transpose(var_3, adj_3, adj_5);
    wp::adj_mul(var_3, var_inertia, adj_3, adj_inertia, adj_4);
    // adj: half_rotation * inertia * wp.transpose(half_rotation) * midpoint_velocity         <L 280>
    // adj: initial_momentum = (                                                              <L 279>
    adj__exponential_increment_0(var_0, var_2, adj_0, adj_2, adj_3);
    wp::adj_mul(var_1, var_dt, adj_1, adj_dt, adj_2);
    // adj: half_rotation = _exponential_increment(midpoint_velocity, 0.5 * dt)               <L 278>
    adj__logarithmic_velocity_0(var_relative_rotation, var_dt, adj_relative_rotation, adj_dt, adj_0);
    // adj: midpoint_velocity = _logarithmic_velocity(relative_rotation, dt)                  <L 277>
    // adj: def recover_lie_group_midpoint_end_velocity(                                      <L 271>
    return;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:286
static CUDA_CALLABLE void adj_recover_midpoint_cayley_end_velocity_0(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::mat_t<3, 3, wp::float32> var_relative_rotation,
    wp::float32 var_dt,
    wp::mat_t<3, 3, wp::float32> & adj_inertia,
    wp::mat_t<3, 3, wp::float32> & adj_relative_rotation,
    wp::float32 & adj_dt,
    wp::vec_t<3, wp::float32> & adj_ret)
{
    //---------
    // primal vars
    const wp::int32 var_0 = 3;
    wp::mat_t<3, 3, wp::float32> var_1;
    const wp::float32 var_2 = 2.0;
    wp::mat_t<3, 3, wp::float32> var_3;
    wp::mat_t<3, 3, wp::float32> var_4;
    wp::mat_t<3, 3, wp::float32> var_5;
    wp::mat_t<3, 3, wp::float32> var_6;
    wp::mat_t<3, 3, wp::float32> var_7;
    const wp::float32 var_8 = 0.5;
    wp::mat_t<3, 3, wp::float32> var_9;
    wp::mat_t<3, 3, wp::float32> var_10;
    wp::mat_t<3, 3, wp::float32> var_11;
    const wp::int32 var_12 = 2;
    const wp::int32 var_13 = 1;
    wp::float32 var_14;
    const wp::int32 var_15 = 0;
    const wp::int32 var_16 = 2;
    wp::float32 var_17;
    const wp::int32 var_18 = 1;
    const wp::int32 var_19 = 0;
    wp::float32 var_20;
    wp::vec_t<3, wp::float32> var_21;
    wp::vec_t<3, wp::float32> var_22;
    wp::vec_t<3, wp::float32> var_23;
    const wp::float32 var_24 = 0.5;
    wp::float32 var_25;
    wp::vec_t<3, wp::float32> var_26;
    wp::vec_t<3, wp::float32> var_27;
    wp::vec_t<3, wp::float32> var_28;
    wp::mat_t<3, 3, wp::float32> var_29;
    wp::vec_t<3, wp::float32> var_30;
    //---------
    // dual vars
    wp::int32 adj_0 = {};
    wp::mat_t<3, 3, wp::float32> adj_1 = {};
    wp::float32 adj_2 = {};
    wp::mat_t<3, 3, wp::float32> adj_3 = {};
    wp::mat_t<3, 3, wp::float32> adj_4 = {};
    wp::mat_t<3, 3, wp::float32> adj_5 = {};
    wp::mat_t<3, 3, wp::float32> adj_6 = {};
    wp::mat_t<3, 3, wp::float32> adj_7 = {};
    wp::float32 adj_8 = {};
    wp::mat_t<3, 3, wp::float32> adj_9 = {};
    wp::mat_t<3, 3, wp::float32> adj_10 = {};
    wp::mat_t<3, 3, wp::float32> adj_11 = {};
    wp::int32 adj_12 = {};
    wp::int32 adj_13 = {};
    wp::float32 adj_14 = {};
    wp::int32 adj_15 = {};
    wp::int32 adj_16 = {};
    wp::float32 adj_17 = {};
    wp::int32 adj_18 = {};
    wp::int32 adj_19 = {};
    wp::float32 adj_20 = {};
    wp::vec_t<3, wp::float32> adj_21 = {};
    wp::vec_t<3, wp::float32> adj_22 = {};
    wp::vec_t<3, wp::float32> adj_23 = {};
    wp::float32 adj_24 = {};
    wp::float32 adj_25 = {};
    wp::vec_t<3, wp::float32> adj_26 = {};
    wp::vec_t<3, wp::float32> adj_27 = {};
    wp::vec_t<3, wp::float32> adj_28 = {};
    wp::mat_t<3, 3, wp::float32> adj_29 = {};
    wp::vec_t<3, wp::float32> adj_30 = {};
    //---------
    // forward
    // def recover_midpoint_cayley_end_velocity(                                              <L 287>
    // identity = wp.identity(3, dtype=float)                                                 <L 293>
    var_1 = wp::identity<3, wp::float32>();
    // generator = (                                                                          <L 294>
    // 2.0 * (relative_rotation - identity) * wp.inverse(relative_rotation + identity)        <L 295>
    var_3 = wp::sub(var_relative_rotation, var_1);
    var_4 = wp::mul(var_2, var_3);
    var_5 = wp::add(var_relative_rotation, var_1);
    var_6 = wp::inverse(var_5);
    var_7 = wp::mul(var_4, var_6);
    // generator = 0.5 * (generator - wp.transpose(generator))                                <L 297>
    var_9 = wp::transpose(var_7);
    var_10 = wp::sub(var_7, var_9);
    var_11 = wp::mul(var_8, var_10);
    // midpoint_velocity = (                                                                  <L 298>
    // wp.vec3(                                                                               <L 299>
    // generator[2, 1],                                                                       <L 300>
    var_14 = wp::extract(var_11, var_12, var_13);
    // generator[0, 2],                                                                       <L 301>
    var_17 = wp::extract(var_11, var_15, var_16);
    // generator[1, 0],                                                                       <L 302>
    var_20 = wp::extract(var_11, var_18, var_19);
    var_21 = wp::vec_t<3, wp::float32>(var_14, var_17, var_20);
    // / dt                                                                                   <L 304>
    var_22 = wp::div(var_21, var_dt);
    // midpoint_momentum = inertia * midpoint_velocity                                        <L 306>
    var_23 = wp::mul(var_inertia, var_22);
    // next_momentum = midpoint_momentum + 0.5 * dt * wp.cross(                               <L 307>
    var_25 = wp::mul(var_24, var_dt);
    // midpoint_momentum,                                                                     <L 308>
    // midpoint_velocity,                                                                     <L 309>
    var_26 = wp::cross(var_23, var_22);
    var_27 = wp::mul(var_25, var_26);
    var_28 = wp::add(var_23, var_27);
    // return wp.inverse(inertia) * next_momentum                                             <L 311>
    var_29 = wp::inverse(var_inertia);
    var_30 = wp::mul(var_29, var_28);
    goto label0;
    //---------
    // reverse
    label0:;
    adj_30 += adj_ret;
    wp::adj_mul(var_29, var_28, adj_29, adj_28, adj_30);
    wp::adj_inverse(var_inertia, var_29, adj_inertia, adj_29);
    // adj: return wp.inverse(inertia) * next_momentum                                        <L 311>
    wp::adj_add(var_23, var_27, adj_23, adj_27, adj_28);
    wp::adj_mul(var_25, var_26, adj_25, adj_26, adj_27);
    wp::adj_cross(var_23, var_22, adj_23, adj_22, adj_26);
    // adj: midpoint_velocity,                                                                <L 309>
    // adj: midpoint_momentum,                                                                <L 308>
    wp::adj_mul(var_24, var_dt, adj_24, adj_dt, adj_25);
    // adj: next_momentum = midpoint_momentum + 0.5 * dt * wp.cross(                          <L 307>
    wp::adj_mul(var_inertia, var_22, adj_inertia, adj_22, adj_23);
    // adj: midpoint_momentum = inertia * midpoint_velocity                                   <L 306>
    wp::adj_div(var_21, var_dt, adj_21, adj_dt, adj_22);
    // adj: / dt                                                                              <L 304>
    wp::adj_vec_t(var_14, var_17, var_20, adj_14, adj_17, adj_20, adj_21);
    wp::adj_extract(var_11, var_18, var_19, adj_11, adj_18, adj_19, adj_20);
    // adj: generator[1, 0],                                                                  <L 302>
    wp::adj_extract(var_11, var_15, var_16, adj_11, adj_15, adj_16, adj_17);
    // adj: generator[0, 2],                                                                  <L 301>
    wp::adj_extract(var_11, var_12, var_13, adj_11, adj_12, adj_13, adj_14);
    // adj: generator[2, 1],                                                                  <L 300>
    // adj: wp.vec3(                                                                          <L 299>
    // adj: midpoint_velocity = (                                                             <L 298>
    wp::adj_mul(var_8, var_10, adj_8, adj_10, adj_11);
    wp::adj_sub(var_7, var_9, adj_7, adj_9, adj_10);
    wp::adj_transpose(var_7, adj_7, adj_9);
    // adj: generator = 0.5 * (generator - wp.transpose(generator))                           <L 297>
    wp::adj_mul(var_4, var_6, adj_4, adj_6, adj_7);
    wp::adj_inverse(var_5, var_6, adj_5, adj_6);
    wp::adj_add(var_relative_rotation, var_1, adj_relative_rotation, adj_1, adj_5);
    wp::adj_mul(var_2, var_3, adj_2, adj_3, adj_4);
    wp::adj_sub(var_relative_rotation, var_1, adj_relative_rotation, adj_1, adj_3);
    // adj: 2.0 * (relative_rotation - identity) * wp.inverse(relative_rotation + identity)   <L 295>
    // adj: generator = (                                                                     <L 294>
    // adj: identity = wp.identity(3, dtype=float)                                            <L 293>
    // adj: def recover_midpoint_cayley_end_velocity(                                         <L 287>
    return;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:314
static CUDA_CALLABLE void adj_recover_vbd_semi_implicit_end_velocity_0(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::mat_t<3, 3, wp::float32> var_relative_rotation,
    wp::float32 var_dt,
    wp::mat_t<3, 3, wp::float32> & adj_inertia,
    wp::mat_t<3, 3, wp::float32> & adj_relative_rotation,
    wp::float32 & adj_dt,
    wp::vec_t<3, wp::float32> & adj_ret)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    //---------
    // dual vars
    wp::vec_t<3, wp::float32> adj_0 = {};
    //---------
    // forward
    // def recover_vbd_semi_implicit_end_velocity(                                            <L 315>
    // return _logarithmic_velocity(relative_rotation, dt)                                    <L 321>
    var_0 = _logarithmic_velocity_0(var_relative_rotation, var_dt);
    goto label0;
    //---------
    // reverse
    label0:;
    adj_0 += adj_ret;
    adj__logarithmic_velocity_0(var_relative_rotation, var_dt, adj_relative_rotation, adj_dt, adj_0);
    // adj: return _logarithmic_velocity(relative_rotation, dt)                               <L 321>
    // adj: def recover_vbd_semi_implicit_end_velocity(                                       <L 315>
    return;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:324
static CUDA_CALLABLE void adj_recover_rigid_body_end_velocity_0(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::mat_t<3, 3, wp::float32> var_relative_rotation,
    wp::float32 var_dt,
    wp::int32 var_integrator,
    wp::mat_t<3, 3, wp::float32> & adj_inertia,
    wp::mat_t<3, 3, wp::float32> & adj_relative_rotation,
    wp::float32 & adj_dt,
    wp::int32 & adj_integrator,
    wp::vec_t<3, wp::float32> & adj_ret)
{
    //---------
    // primal vars
    const wp::int32 var_0 = 0;
    bool var_1;
    wp::vec_t<3, wp::float32> var_2;
    const wp::int32 var_3 = 1;
    bool var_4;
    wp::vec_t<3, wp::float32> var_5;
    const wp::int32 var_6 = 2;
    bool var_7;
    wp::vec_t<3, wp::float32> var_8;
    const wp::int32 var_9 = 3;
    bool var_10;
    wp::vec_t<3, wp::float32> var_11;
    const wp::int32 var_12 = 5;
    bool var_13;
    wp::vec_t<3, wp::float32> var_14;
    //---------
    // dual vars
    wp::int32 adj_0 = {};
    bool adj_1 = {};
    wp::vec_t<3, wp::float32> adj_2 = {};
    wp::int32 adj_3 = {};
    bool adj_4 = {};
    wp::vec_t<3, wp::float32> adj_5 = {};
    wp::int32 adj_6 = {};
    bool adj_7 = {};
    wp::vec_t<3, wp::float32> adj_8 = {};
    wp::int32 adj_9 = {};
    bool adj_10 = {};
    wp::vec_t<3, wp::float32> adj_11 = {};
    wp::int32 adj_12 = {};
    bool adj_13 = {};
    wp::vec_t<3, wp::float32> adj_14 = {};
    //---------
    // forward
    // def recover_rigid_body_end_velocity(                                                   <L 325>
    // if integrator == EXPLICIT_EULER:                                                       <L 332>
    var_1 = (var_integrator == var_0);
    if (var_1) {
        // return recover_explicit_euler_end_velocity(inertia, relative_rotation, dt)         <L 333>
        var_2 = recover_explicit_euler_end_velocity_0(var_inertia, var_relative_rotation, var_dt);
        goto label0;
    }
    if (!var_1) {
        // elif integrator == IMPLICIT_EULER:                                                 <L 334>
        var_4 = (var_integrator == var_3);
        if (var_4) {
            // return recover_implicit_euler_end_velocity(inertia, relative_rotation, dt)       <L 335>
            var_5 = recover_implicit_euler_end_velocity_0(var_inertia, var_relative_rotation, var_dt);
            goto label1;
        }
        if (!var_4) {
            // elif integrator == LIE_GROUP_MIDPOINT:                                         <L 336>
            var_7 = (var_integrator == var_6);
            if (var_7) {
                // return recover_lie_group_midpoint_end_velocity(inertia, relative_rotation, dt)       <L 337>
                var_8 = recover_lie_group_midpoint_end_velocity_0(var_inertia, var_relative_rotation, var_dt);
                goto label2;
            }
            if (!var_7) {
                // elif integrator == MIDPOINT_CAYLEY:                                        <L 338>
                var_10 = (var_integrator == var_9);
                if (var_10) {
                    // return recover_midpoint_cayley_end_velocity(inertia, relative_rotation, dt)       <L 339>
                    var_11 = recover_midpoint_cayley_end_velocity_0(var_inertia, var_relative_rotation, var_dt);
                    goto label3;
                }
                if (!var_10) {
                    // elif integrator == VBD_SEMI_IMPLICIT:                                  <L 340>
                    var_13 = (var_integrator == var_12);
                    if (var_13) {
                        // return recover_vbd_semi_implicit_end_velocity(inertia, relative_rotation, dt)       <L 341>
                        var_14 = recover_vbd_semi_implicit_end_velocity_0(var_inertia, var_relative_rotation, var_dt);
                        goto label4;
                    }
                }
            }
        }
    }
    //---------
    // reverse
    if (!var_1) {
        if (!var_4) {
            if (!var_7) {
                if (!var_10) {
                    if (var_13) {
                        label4:;
                        adj_14 += adj_ret;
                        adj_recover_vbd_semi_implicit_end_velocity_0(var_inertia, var_relative_rotation, var_dt, adj_inertia, adj_relative_rotation, adj_dt, adj_14);
                        // adj: return recover_vbd_semi_implicit_end_velocity(inertia, relative_rotation, dt)  <L 341>
                    }
                    // adj: elif integrator == VBD_SEMI_IMPLICIT:                             <L 340>
                }
                if (var_10) {
                    label3:;
                    adj_11 += adj_ret;
                    adj_recover_midpoint_cayley_end_velocity_0(var_inertia, var_relative_rotation, var_dt, adj_inertia, adj_relative_rotation, adj_dt, adj_11);
                    // adj: return recover_midpoint_cayley_end_velocity(inertia, relative_rotation, dt)  <L 339>
                }
                // adj: elif integrator == MIDPOINT_CAYLEY:                                   <L 338>
            }
            if (var_7) {
                label2:;
                adj_8 += adj_ret;
                adj_recover_lie_group_midpoint_end_velocity_0(var_inertia, var_relative_rotation, var_dt, adj_inertia, adj_relative_rotation, adj_dt, adj_8);
                // adj: return recover_lie_group_midpoint_end_velocity(inertia, relative_rotation, dt)  <L 337>
            }
            // adj: elif integrator == LIE_GROUP_MIDPOINT:                                    <L 336>
        }
        if (var_4) {
            label1:;
            adj_5 += adj_ret;
            adj_recover_implicit_euler_end_velocity_0(var_inertia, var_relative_rotation, var_dt, adj_inertia, adj_relative_rotation, adj_dt, adj_5);
            // adj: return recover_implicit_euler_end_velocity(inertia, relative_rotation, dt)  <L 335>
        }
        // adj: elif integrator == IMPLICIT_EULER:                                            <L 334>
    }
    if (var_1) {
        label0:;
        adj_2 += adj_ret;
        adj_recover_explicit_euler_end_velocity_0(var_inertia, var_relative_rotation, var_dt, adj_inertia, adj_relative_rotation, adj_dt, adj_2);
        // adj: return recover_explicit_euler_end_velocity(inertia, relative_rotation, dt)    <L 333>
    }
    // adj: if integrator == EXPLICIT_EULER:                                                  <L 332>
    // adj: def recover_rigid_body_end_velocity(                                              <L 325>
    return;
}


// /home/oem/code/agent/style3d-sim/.venv/lib/python3.12/site-packages/newton/_src/core/reset.py:13
static CUDA_CALLABLE void adj_reset_world_selected_0(
    wp::int32 var_world,
    wp::array_t<bool> var_world_mask,
    wp::int32 var_world_count,
    wp::int32 & adj_world,
    wp::array_t<bool> & adj_world_mask,
    wp::int32 & adj_world_count,
    bool & adj_ret)
{
    //---------
    // primal vars
    bool var_0;
    const wp::int32 var_1 = 0;
    bool var_2;
    bool var_3;
    bool* var_4;
    bool var_5;
    bool var_6;
    bool var_7;
    const wp::int32 var_8 = -1;
    bool var_9;
    bool* var_10;
    bool var_11;
    //---------
    // dual vars
    bool adj_0 = {};
    wp::int32 adj_1 = {};
    bool adj_2 = {};
    bool adj_3 = {};
    bool adj_4 = {};
    bool adj_5 = {};
    bool adj_6 = {};
    bool adj_7 = {};
    wp::int32 adj_8 = {};
    bool adj_9 = {};
    bool adj_10 = {};
    bool adj_11 = {};
    //---------
    // forward
    // def reset_world_selected(world: int, world_mask: wp.array[wp.bool], world_count: int) -> bool:       <L 14>
    // if world >= 0 and world < world_count:                                                 <L 16>
    var_2 = (var_world >= var_1);
    var_0 = var_2;
    if (var_0) {
        var_3 = (var_world < var_world_count);
        var_0 = var_0 && var_3;
    }
    if (var_0) {
        // return world_mask[world]                                                           <L 17>
        var_4 = wp::address(var_world_mask, var_world);
        var_6 = wp::load(var_4);
        var_5 = wp::copy(var_6);
        goto label0;
    }
    // return world == -1 and world_mask[world_count]                                         <L 18>
    var_9 = (var_world == var_8);
    var_7 = var_9;
    if (var_7) {
        var_10 = wp::address(var_world_mask, var_world_count);
        var_11 = wp::load(var_10);
        var_7 = var_7 && var_11;
    }
    goto label1;
    //---------
    // reverse
    label1:;
    adj_7 += adj_ret;
    if (var_7) {
        wp::adj_address(var_world_mask, var_world_count, adj_world_mask, adj_world_count, adj_10);
    }
    // adj: return world == -1 and world_mask[world_count]                                    <L 18>
    if (var_0) {
        label0:;
        adj_5 += adj_ret;
        wp::adj_copy(var_6, adj_4, adj_5);
        wp::adj_address(var_world_mask, var_world, adj_world_mask, adj_world, adj_4);
        // adj: return world_mask[world]                                                      <L 17>
    }
    if (var_0) {
    }
    // adj: if world >= 0 and world < world_count:                                            <L 16>
    // adj: def reset_world_selected(world: int, world_mask: wp.array[wp.bool], world_count: int) -> bool:  <L 14>
    return;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/newton_solver.py:291
static CUDA_CALLABLE void adj__reset_selected_world_0(
    wp::int32 var_world,
    wp::array_t<bool> var_world_mask,
    wp::int32 var_world_count,
    bool var_reset_all,
    wp::int32 & adj_world,
    wp::array_t<bool> & adj_world_mask,
    wp::int32 & adj_world_count,
    bool & adj_reset_all,
    bool & adj_ret)
{
    //---------
    // primal vars
    const bool var_0 = true;
    bool var_1;
    //---------
    // dual vars
    bool adj_0 = {};
    bool adj_1 = {};
    //---------
    // forward
    // def _reset_selected_world(world: int, world_mask: wp.array(dtype=wp.bool), world_count: int, reset_all: bool):       <L 292>
    // if reset_all:                                                                          <L 293>
    if (var_reset_all) {
        // return True                                                                        <L 294>
        goto label0;
    }
    // return reset_world_selected(world, world_mask, world_count)                            <L 295>
    var_1 = reset_world_selected_0(var_world, var_world_mask, var_world_count);
    goto label1;
    //---------
    // reverse
    label1:;
    adj_1 += adj_ret;
    adj_reset_world_selected_0(var_world, var_world_mask, var_world_count, adj_world, adj_world_mask, adj_world_count, adj_1);
    // adj: return reset_world_selected(world, world_mask, world_count)                       <L 295>
    if (var_reset_all) {
        label0:;
        adj_0 += adj_ret;
        // adj: return True                                                                   <L 294>
    }
    // adj: if reset_all:                                                                     <L 293>
    // adj: def _reset_selected_world(world: int, world_mask: wp.array(dtype=wp.bool), world_count: int, reset_all: bool):  <L 292>
    return;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/newton_solver.py:213
static CUDA_CALLABLE void adj__write_affine_body_state_0(
    wp::int32 var_affine_body,
    wp::array_t<wp::vec_t<4, wp::int32>> var_affine_body_indices,
    wp::array_t<wp::int32> var_affine_body_ids,
    wp::array_t<wp::vec_t<3, wp::float32>> var_body_com,
    wp::array_t<wp::transform_t<wp::float32>> var_body_q,
    wp::array_t<wp::vec_t<6, wp::float32>> var_body_qd,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_q,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_qd,
    wp::int32 & adj_affine_body,
    wp::array_t<wp::vec_t<4, wp::int32>> & adj_affine_body_indices,
    wp::array_t<wp::int32> & adj_affine_body_ids,
    wp::array_t<wp::vec_t<3, wp::float32>> & adj_body_com,
    wp::array_t<wp::transform_t<wp::float32>> & adj_body_q,
    wp::array_t<wp::vec_t<6, wp::float32>> & adj_body_qd,
    wp::array_t<wp::vec_t<3, wp::float32>> & adj_particle_q,
    wp::array_t<wp::vec_t<3, wp::float32>> & adj_particle_qd)
{
    //---------
    // primal vars
    wp::vec_t<4, wp::int32>* var_0;
    wp::vec_t<4, wp::int32> var_1;
    wp::vec_t<4, wp::int32> var_2;
    wp::int32* var_3;
    wp::int32 var_4;
    wp::int32 var_5;
    wp::transform_t<wp::float32>* var_6;
    wp::transform_t<wp::float32> var_7;
    wp::transform_t<wp::float32> var_8;
    wp::quat_t<wp::float32> var_9;
    wp::vec_t<3, wp::float32> var_10;
    wp::vec_t<3, wp::float32>* var_11;
    wp::vec_t<3, wp::float32> var_12;
    wp::vec_t<3, wp::float32> var_13;
    wp::vec_t<3, wp::float32> var_14;
    const wp::float32 var_15 = 1.0;
    const wp::float32 var_16 = 0.0;
    const wp::float32 var_17 = 0.0;
    wp::vec_t<3, wp::float32> var_18;
    wp::vec_t<3, wp::float32> var_19;
    const wp::float32 var_20 = 0.0;
    const wp::float32 var_21 = 1.0;
    const wp::float32 var_22 = 0.0;
    wp::vec_t<3, wp::float32> var_23;
    wp::vec_t<3, wp::float32> var_24;
    const wp::float32 var_25 = 0.0;
    const wp::float32 var_26 = 0.0;
    const wp::float32 var_27 = 1.0;
    wp::vec_t<3, wp::float32> var_28;
    wp::vec_t<3, wp::float32> var_29;
    const wp::int32 var_30 = 0;
    wp::int32 var_31;
    const wp::int32 var_32 = 1;
    wp::int32 var_33;
    const wp::int32 var_34 = 2;
    wp::int32 var_35;
    const wp::int32 var_36 = 3;
    wp::int32 var_37;
    wp::vec_t<6, wp::float32>* var_38;
    wp::vec_t<3, wp::float32> var_39;
    wp::vec_t<6, wp::float32> var_40;
    wp::vec_t<6, wp::float32>* var_41;
    wp::vec_t<3, wp::float32> var_42;
    wp::vec_t<6, wp::float32> var_43;
    const wp::int32 var_44 = 0;
    wp::int32 var_45;
    wp::vec_t<3, wp::float32> var_46;
    const wp::int32 var_47 = 1;
    wp::int32 var_48;
    wp::vec_t<3, wp::float32> var_49;
    const wp::int32 var_50 = 2;
    wp::int32 var_51;
    wp::vec_t<3, wp::float32> var_52;
    const wp::int32 var_53 = 3;
    wp::int32 var_54;
    //---------
    // dual vars
    wp::vec_t<4, wp::int32> adj_0 = {};
    wp::vec_t<4, wp::int32> adj_1 = {};
    wp::vec_t<4, wp::int32> adj_2 = {};
    wp::int32 adj_3 = {};
    wp::int32 adj_4 = {};
    wp::int32 adj_5 = {};
    wp::transform_t<wp::float32> adj_6 = {};
    wp::transform_t<wp::float32> adj_7 = {};
    wp::transform_t<wp::float32> adj_8 = {};
    wp::quat_t<wp::float32> adj_9 = {};
    wp::vec_t<3, wp::float32> adj_10 = {};
    wp::vec_t<3, wp::float32> adj_11 = {};
    wp::vec_t<3, wp::float32> adj_12 = {};
    wp::vec_t<3, wp::float32> adj_13 = {};
    wp::vec_t<3, wp::float32> adj_14 = {};
    wp::float32 adj_15 = {};
    wp::float32 adj_16 = {};
    wp::float32 adj_17 = {};
    wp::vec_t<3, wp::float32> adj_18 = {};
    wp::vec_t<3, wp::float32> adj_19 = {};
    wp::float32 adj_20 = {};
    wp::float32 adj_21 = {};
    wp::float32 adj_22 = {};
    wp::vec_t<3, wp::float32> adj_23 = {};
    wp::vec_t<3, wp::float32> adj_24 = {};
    wp::float32 adj_25 = {};
    wp::float32 adj_26 = {};
    wp::float32 adj_27 = {};
    wp::vec_t<3, wp::float32> adj_28 = {};
    wp::vec_t<3, wp::float32> adj_29 = {};
    wp::int32 adj_30 = {};
    wp::int32 adj_31 = {};
    wp::int32 adj_32 = {};
    wp::int32 adj_33 = {};
    wp::int32 adj_34 = {};
    wp::int32 adj_35 = {};
    wp::int32 adj_36 = {};
    wp::int32 adj_37 = {};
    wp::vec_t<6, wp::float32> adj_38 = {};
    wp::vec_t<3, wp::float32> adj_39 = {};
    wp::vec_t<6, wp::float32> adj_40 = {};
    wp::vec_t<6, wp::float32> adj_41 = {};
    wp::vec_t<3, wp::float32> adj_42 = {};
    wp::vec_t<6, wp::float32> adj_43 = {};
    wp::int32 adj_44 = {};
    wp::int32 adj_45 = {};
    wp::vec_t<3, wp::float32> adj_46 = {};
    wp::int32 adj_47 = {};
    wp::int32 adj_48 = {};
    wp::vec_t<3, wp::float32> adj_49 = {};
    wp::int32 adj_50 = {};
    wp::int32 adj_51 = {};
    wp::vec_t<3, wp::float32> adj_52 = {};
    wp::int32 adj_53 = {};
    wp::int32 adj_54 = {};
    //---------
    // forward
    // def _write_affine_body_state(                                                          <L 214>
    // indices = affine_body_indices[affine_body]                                             <L 224>
    var_0 = wp::address(var_affine_body_indices, var_affine_body);
    var_2 = wp::load(var_0);
    var_1 = wp::copy(var_2);
    // body = affine_body_ids[affine_body]                                                    <L 225>
    var_3 = wp::address(var_affine_body_ids, var_affine_body);
    var_5 = wp::load(var_3);
    var_4 = wp::copy(var_5);
    // pose = body_q[body]                                                                    <L 226>
    var_6 = wp::address(var_body_q, var_4);
    var_8 = wp::load(var_6);
    var_7 = wp::copy(var_8);
    // rotation = wp.transform_get_rotation(pose)                                             <L 227>
    var_9 = wp::transform_get_rotation(var_7);
    // world_com = wp.transform_get_translation(pose) + wp.quat_rotate(                       <L 228>
    var_10 = wp::transform_get_translation(var_7);
    // rotation, body_com[affine_body]                                                        <L 229>
    var_11 = wp::address(var_body_com, var_affine_body);
    var_13 = wp::load(var_11);
    var_12 = wp::quat_rotate(var_9, var_13);
    var_14 = wp::add(var_10, var_12);
    // x_axis = wp.quat_rotate(rotation, wp.vec3(1.0, 0.0, 0.0))                              <L 231>
    var_18 = wp::vec_t<3, wp::float32>(var_15, var_16, var_17);
    var_19 = wp::quat_rotate(var_9, var_18);
    // y_axis = wp.quat_rotate(rotation, wp.vec3(0.0, 1.0, 0.0))                              <L 232>
    var_23 = wp::vec_t<3, wp::float32>(var_20, var_21, var_22);
    var_24 = wp::quat_rotate(var_9, var_23);
    // z_axis = wp.quat_rotate(rotation, wp.vec3(0.0, 0.0, 1.0))                              <L 233>
    var_28 = wp::vec_t<3, wp::float32>(var_25, var_26, var_27);
    var_29 = wp::quat_rotate(var_9, var_28);
    // if particle_q:                                                                         <L 234>
    if (var_particle_q) {
        // particle_q[indices[0]] = world_com                                                 <L 235>
        var_31 = wp::extract(var_1, var_30);
        // wp::array_store(var_particle_q, var_31, var_14);
        // particle_q[indices[1]] = x_axis                                                    <L 236>
        var_33 = wp::extract(var_1, var_32);
        // wp::array_store(var_particle_q, var_33, var_19);
        // particle_q[indices[2]] = y_axis                                                    <L 237>
        var_35 = wp::extract(var_1, var_34);
        // wp::array_store(var_particle_q, var_35, var_24);
        // particle_q[indices[3]] = z_axis                                                    <L 238>
        var_37 = wp::extract(var_1, var_36);
        // wp::array_store(var_particle_q, var_37, var_29);
    }
    // if particle_qd:                                                                        <L 239>
    if (var_particle_qd) {
        // linear_velocity = wp.spatial_top(body_qd[body])                                    <L 240>
        var_38 = wp::address(var_body_qd, var_4);
        var_40 = wp::load(var_38);
        var_39 = wp::spatial_top(var_40);
        // angular_velocity = wp.spatial_bottom(body_qd[body])                                <L 241>
        var_41 = wp::address(var_body_qd, var_4);
        var_43 = wp::load(var_41);
        var_42 = wp::spatial_bottom(var_43);
        // particle_qd[indices[0]] = linear_velocity                                          <L 242>
        var_45 = wp::extract(var_1, var_44);
        // wp::array_store(var_particle_qd, var_45, var_39);
        // particle_qd[indices[1]] = wp.cross(angular_velocity, x_axis)                       <L 243>
        var_46 = wp::cross(var_42, var_19);
        var_48 = wp::extract(var_1, var_47);
        // wp::array_store(var_particle_qd, var_48, var_46);
        // particle_qd[indices[2]] = wp.cross(angular_velocity, y_axis)                       <L 244>
        var_49 = wp::cross(var_42, var_24);
        var_51 = wp::extract(var_1, var_50);
        // wp::array_store(var_particle_qd, var_51, var_49);
        // particle_qd[indices[3]] = wp.cross(angular_velocity, z_axis)                       <L 245>
        var_52 = wp::cross(var_42, var_29);
        var_54 = wp::extract(var_1, var_53);
        // wp::array_store(var_particle_qd, var_54, var_52);
    }
    //---------
    // reverse
    if (var_particle_qd) {
        wp::adj_array_store(var_particle_qd, var_54, var_52, adj_particle_qd, adj_54, adj_52);
        wp::adj_extract(var_1, var_53, adj_1, adj_53, adj_54);
        wp::adj_cross(var_42, var_29, adj_42, adj_29, adj_52);
        // adj: particle_qd[indices[3]] = wp.cross(angular_velocity, z_axis)                  <L 245>
        wp::adj_array_store(var_particle_qd, var_51, var_49, adj_particle_qd, adj_51, adj_49);
        wp::adj_extract(var_1, var_50, adj_1, adj_50, adj_51);
        wp::adj_cross(var_42, var_24, adj_42, adj_24, adj_49);
        // adj: particle_qd[indices[2]] = wp.cross(angular_velocity, y_axis)                  <L 244>
        wp::adj_array_store(var_particle_qd, var_48, var_46, adj_particle_qd, adj_48, adj_46);
        wp::adj_extract(var_1, var_47, adj_1, adj_47, adj_48);
        wp::adj_cross(var_42, var_19, adj_42, adj_19, adj_46);
        // adj: particle_qd[indices[1]] = wp.cross(angular_velocity, x_axis)                  <L 243>
        wp::adj_array_store(var_particle_qd, var_45, var_39, adj_particle_qd, adj_45, adj_39);
        wp::adj_extract(var_1, var_44, adj_1, adj_44, adj_45);
        // adj: particle_qd[indices[0]] = linear_velocity                                     <L 242>
        wp::adj_spatial_bottom(var_43, adj_41, adj_42);
        wp::adj_address(var_body_qd, var_4, adj_body_qd, adj_4, adj_41);
        // adj: angular_velocity = wp.spatial_bottom(body_qd[body])                           <L 241>
        wp::adj_spatial_top(var_40, adj_38, adj_39);
        wp::adj_address(var_body_qd, var_4, adj_body_qd, adj_4, adj_38);
        // adj: linear_velocity = wp.spatial_top(body_qd[body])                               <L 240>
    }
    // adj: if particle_qd:                                                                   <L 239>
    if (var_particle_q) {
        wp::adj_array_store(var_particle_q, var_37, var_29, adj_particle_q, adj_37, adj_29);
        wp::adj_extract(var_1, var_36, adj_1, adj_36, adj_37);
        // adj: particle_q[indices[3]] = z_axis                                               <L 238>
        wp::adj_array_store(var_particle_q, var_35, var_24, adj_particle_q, adj_35, adj_24);
        wp::adj_extract(var_1, var_34, adj_1, adj_34, adj_35);
        // adj: particle_q[indices[2]] = y_axis                                               <L 237>
        wp::adj_array_store(var_particle_q, var_33, var_19, adj_particle_q, adj_33, adj_19);
        wp::adj_extract(var_1, var_32, adj_1, adj_32, adj_33);
        // adj: particle_q[indices[1]] = x_axis                                               <L 236>
        wp::adj_array_store(var_particle_q, var_31, var_14, adj_particle_q, adj_31, adj_14);
        wp::adj_extract(var_1, var_30, adj_1, adj_30, adj_31);
        // adj: particle_q[indices[0]] = world_com                                            <L 235>
    }
    // adj: if particle_q:                                                                    <L 234>
    wp::adj_quat_rotate(var_9, var_28, adj_9, adj_28, adj_29);
    wp::adj_vec_t(var_25, var_26, var_27, adj_25, adj_26, adj_27, adj_28);
    // adj: z_axis = wp.quat_rotate(rotation, wp.vec3(0.0, 0.0, 1.0))                         <L 233>
    wp::adj_quat_rotate(var_9, var_23, adj_9, adj_23, adj_24);
    wp::adj_vec_t(var_20, var_21, var_22, adj_20, adj_21, adj_22, adj_23);
    // adj: y_axis = wp.quat_rotate(rotation, wp.vec3(0.0, 1.0, 0.0))                         <L 232>
    wp::adj_quat_rotate(var_9, var_18, adj_9, adj_18, adj_19);
    wp::adj_vec_t(var_15, var_16, var_17, adj_15, adj_16, adj_17, adj_18);
    // adj: x_axis = wp.quat_rotate(rotation, wp.vec3(1.0, 0.0, 0.0))                         <L 231>
    wp::adj_add(var_10, var_12, adj_10, adj_12, adj_14);
    wp::adj_quat_rotate(var_9, var_13, adj_9, adj_11, adj_12);
    wp::adj_address(var_body_com, var_affine_body, adj_body_com, adj_affine_body, adj_11);
    // adj: rotation, body_com[affine_body]                                                   <L 229>
    wp::adj_transform_get_translation(var_7, adj_7, adj_10);
    // adj: world_com = wp.transform_get_translation(pose) + wp.quat_rotate(                  <L 228>
    wp::adj_transform_get_rotation(var_7, adj_7, adj_9);
    // adj: rotation = wp.transform_get_rotation(pose)                                        <L 227>
    wp::adj_copy(var_8, adj_6, adj_7);
    wp::adj_address(var_body_q, var_4, adj_body_q, adj_4, adj_6);
    // adj: pose = body_q[body]                                                               <L 226>
    wp::adj_copy(var_5, adj_3, adj_4);
    wp::adj_address(var_affine_body_ids, var_affine_body, adj_affine_body_ids, adj_affine_body, adj_3);
    // adj: body = affine_body_ids[affine_body]                                               <L 225>
    wp::adj_copy(var_2, adj_0, adj_1);
    wp::adj_address(var_affine_body_indices, var_affine_body, adj_affine_body_indices, adj_affine_body, adj_0);
    // adj: indices = affine_body_indices[affine_body]                                        <L 224>
    // adj: def _write_affine_body_state(                                                     <L 214>
    return;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:207
static CUDA_CALLABLE void adj_integrate_vbd_semi_implicit_0(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::vec_t<3, wp::float32> var_angular_momentum,
    wp::vec_t<3, wp::float32> var_body_torque,
    wp::float32 var_dt,
    wp::vec_t<3, wp::float32> & ret_0,
    wp::mat_t<3, 3, wp::float32> & ret_1,
    wp::mat_t<3, 3, wp::float32> & adj_inertia,
    wp::vec_t<3, wp::float32> & adj_angular_momentum,
    wp::vec_t<3, wp::float32> & adj_body_torque,
    wp::float32 & adj_dt,
    wp::vec_t<3, wp::float32> & adj_ret_0,
    wp::mat_t<3, 3, wp::float32> & adj_ret_1)
{
    //---------
    // primal vars
    wp::mat_t<3, 3, wp::float32> var_0;
    wp::vec_t<3, wp::float32> var_1;
    wp::mat_t<3, 3, wp::float32> var_2;
    wp::vec_t<3, wp::float32> var_3;
    wp::vec_t<3, wp::float32> var_4;
    wp::vec_t<3, wp::float32> var_5;
    wp::vec_t<3, wp::float32> var_6;
    wp::vec_t<3, wp::float32> var_7;
    const wp::float32 var_8 = 0.5;
    wp::float32 var_9;
    wp::vec_t<3, wp::float32> var_10;
    const wp::float32 var_11 = 1.0;
    wp::quat_t<wp::float32> var_12;
    wp::quat_t<wp::float32> var_13;
    wp::vec_t<3, wp::float32> var_14;
    wp::mat_t<3, 3, wp::float32> var_15;
    //---------
    // dual vars
    wp::mat_t<3, 3, wp::float32> adj_0 = {};
    wp::vec_t<3, wp::float32> adj_1 = {};
    wp::mat_t<3, 3, wp::float32> adj_2 = {};
    wp::vec_t<3, wp::float32> adj_3 = {};
    wp::vec_t<3, wp::float32> adj_4 = {};
    wp::vec_t<3, wp::float32> adj_5 = {};
    wp::vec_t<3, wp::float32> adj_6 = {};
    wp::vec_t<3, wp::float32> adj_7 = {};
    wp::float32 adj_8 = {};
    wp::float32 adj_9 = {};
    wp::vec_t<3, wp::float32> adj_10 = {};
    wp::float32 adj_11 = {};
    wp::quat_t<wp::float32> adj_12 = {};
    wp::quat_t<wp::float32> adj_13 = {};
    wp::vec_t<3, wp::float32> adj_14 = {};
    wp::mat_t<3, 3, wp::float32> adj_15 = {};
    //---------
    // forward
    // def integrate_vbd_semi_implicit(                                                       <L 208>
    // inverse_inertia = wp.inverse(inertia)                                                  <L 215>
    var_0 = wp::inverse(var_inertia);
    // angular_velocity = inverse_inertia * angular_momentum                                  <L 216>
    var_1 = wp::mul(var_0, var_angular_momentum);
    // next_velocity = angular_velocity + dt * inverse_inertia * (                            <L 218>
    var_2 = wp::mul(var_dt, var_0);
    // body_torque - wp.cross(angular_velocity, inertia * angular_velocity)                   <L 219>
    var_3 = wp::mul(var_inertia, var_1);
    var_4 = wp::cross(var_1, var_3);
    var_5 = wp::sub(var_body_torque, var_4);
    var_6 = wp::mul(var_2, var_5);
    var_7 = wp::add(var_1, var_6);
    // increment = wp.normalize(wp.quat(0.5 * dt * next_velocity, 1.0))                       <L 221>
    var_9 = wp::mul(var_8, var_dt);
    var_10 = wp::mul(var_9, var_7);
    var_12 = wp::quat_t<wp::float32>(var_10, var_11);
    var_13 = wp::normalize(var_12);
    // return inertia * next_velocity, wp.quat_to_matrix(increment)                           <L 222>
    var_14 = wp::mul(var_inertia, var_7);
    var_15 = wp::quat_to_matrix(var_13);
    ret_0 = var_14;
    ret_1 = var_15;
    goto label0;
    //---------
    // reverse
    label0:;
    adj_15 += adj_ret_1;
    adj_14 += adj_ret_0;
    wp::adj_quat_to_matrix(var_13, adj_13, adj_15);
    wp::adj_mul(var_inertia, var_7, adj_inertia, adj_7, adj_14);
    // adj: return inertia * next_velocity, wp.quat_to_matrix(increment)                      <L 222>
    wp::adj_normalize(var_12, adj_12, adj_13);
    wp::adj_quat_t(var_10, var_11, adj_10, adj_11, adj_12);
    wp::adj_mul(var_9, var_7, adj_9, adj_7, adj_10);
    wp::adj_mul(var_8, var_dt, adj_8, adj_dt, adj_9);
    // adj: increment = wp.normalize(wp.quat(0.5 * dt * next_velocity, 1.0))                  <L 221>
    wp::adj_add(var_1, var_6, adj_1, adj_6, adj_7);
    wp::adj_mul(var_2, var_5, adj_2, adj_5, adj_6);
    wp::adj_sub(var_body_torque, var_4, adj_body_torque, adj_4, adj_5);
    wp::adj_cross(var_1, var_3, adj_1, adj_3, adj_4);
    wp::adj_mul(var_inertia, var_1, adj_inertia, adj_1, adj_3);
    // adj: body_torque - wp.cross(angular_velocity, inertia * angular_velocity)              <L 219>
    wp::adj_mul(var_dt, var_0, adj_dt, adj_0, adj_2);
    // adj: next_velocity = angular_velocity + dt * inverse_inertia * (                       <L 218>
    wp::adj_mul(var_0, var_angular_momentum, adj_0, adj_angular_momentum, adj_1);
    // adj: angular_velocity = inverse_inertia * angular_momentum                             <L 216>
    wp::adj_inverse(var_inertia, var_0, adj_inertia, adj_0);
    // adj: inverse_inertia = wp.inverse(inertia)                                             <L 215>
    // adj: def integrate_vbd_semi_implicit(                                                  <L 208>
    return;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:73
static CUDA_CALLABLE void adj_integrate_explicit_euler_0(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::vec_t<3, wp::float32> var_angular_momentum,
    wp::float32 var_dt,
    wp::vec_t<3, wp::float32> & ret_0,
    wp::mat_t<3, 3, wp::float32> & ret_1,
    wp::mat_t<3, 3, wp::float32> & adj_inertia,
    wp::vec_t<3, wp::float32> & adj_angular_momentum,
    wp::float32 & adj_dt,
    wp::vec_t<3, wp::float32> & adj_ret_0,
    wp::mat_t<3, 3, wp::float32> & adj_ret_1)
{
    //---------
    // primal vars
    wp::mat_t<3, 3, wp::float32> var_0;
    wp::vec_t<3, wp::float32> var_1;
    wp::vec_t<3, wp::float32> var_2;
    wp::vec_t<3, wp::float32> var_3;
    wp::vec_t<3, wp::float32> var_4;
    wp::mat_t<3, 3, wp::float32> var_5;
    //---------
    // dual vars
    wp::mat_t<3, 3, wp::float32> adj_0 = {};
    wp::vec_t<3, wp::float32> adj_1 = {};
    wp::vec_t<3, wp::float32> adj_2 = {};
    wp::vec_t<3, wp::float32> adj_3 = {};
    wp::vec_t<3, wp::float32> adj_4 = {};
    wp::mat_t<3, 3, wp::float32> adj_5 = {};
    //---------
    // forward
    // def integrate_explicit_euler(                                                          <L 74>
    // angular_velocity = wp.inverse(inertia) * angular_momentum                              <L 80>
    var_0 = wp::inverse(var_inertia);
    var_1 = wp::mul(var_0, var_angular_momentum);
    // next_angular_momentum = angular_momentum + dt * wp.cross(                              <L 81>
    // angular_momentum,                                                                      <L 82>
    // angular_velocity,                                                                      <L 83>
    var_2 = wp::cross(var_angular_momentum, var_1);
    var_3 = wp::mul(var_dt, var_2);
    var_4 = wp::add(var_angular_momentum, var_3);
    // relative_rotation = _exponential_increment(angular_velocity, dt)                       <L 85>
    var_5 = _exponential_increment_0(var_1, var_dt);
    // return next_angular_momentum, relative_rotation                                        <L 86>
    ret_0 = var_4;
    ret_1 = var_5;
    goto label0;
    //---------
    // reverse
    label0:;
    adj_5 += adj_ret_1;
    adj_4 += adj_ret_0;
    // adj: return next_angular_momentum, relative_rotation                                   <L 86>
    adj__exponential_increment_0(var_1, var_dt, adj_1, adj_dt, adj_5);
    // adj: relative_rotation = _exponential_increment(angular_velocity, dt)                  <L 85>
    wp::adj_add(var_angular_momentum, var_3, adj_angular_momentum, adj_3, adj_4);
    wp::adj_mul(var_dt, var_2, adj_dt, adj_2, adj_3);
    wp::adj_cross(var_angular_momentum, var_1, adj_angular_momentum, adj_1, adj_2);
    // adj: angular_velocity,                                                                 <L 83>
    // adj: angular_momentum,                                                                 <L 82>
    // adj: next_angular_momentum = angular_momentum + dt * wp.cross(                         <L 81>
    wp::adj_mul(var_0, var_angular_momentum, adj_0, adj_angular_momentum, adj_1);
    wp::adj_inverse(var_inertia, var_0, adj_inertia, adj_0);
    // adj: angular_velocity = wp.inverse(inertia) * angular_momentum                         <L 80>
    // adj: def integrate_explicit_euler(                                                     <L 74>
    return;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:89
static CUDA_CALLABLE void adj_integrate_implicit_euler_0(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::vec_t<3, wp::float32> var_angular_momentum,
    wp::float32 var_dt,
    wp::vec_t<3, wp::float32> & ret_0,
    wp::mat_t<3, 3, wp::float32> & ret_1,
    wp::mat_t<3, 3, wp::float32> & adj_inertia,
    wp::vec_t<3, wp::float32> & adj_angular_momentum,
    wp::float32 & adj_dt,
    wp::vec_t<3, wp::float32> & adj_ret_0,
    wp::mat_t<3, 3, wp::float32> & adj_ret_1)
{
    //---------
    // primal vars
    wp::mat_t<3, 3, wp::float32> var_0;
    wp::vec_t<3, wp::float32> var_1;
    wp::vec_t<3, wp::float32> var_2;
    wp::vec_t<3, wp::float32> var_3;
    wp::vec_t<3, wp::float32> var_4;
    const wp::int32 var_5 = 0;
    wp::vec_t<3, wp::float32> var_6;
    wp::vec_t<3, wp::float32> var_7;
    wp::vec_t<3, wp::float32> var_8;
    wp::vec_t<3, wp::float32> var_9;
    wp::vec_t<3, wp::float32> var_10;
    const wp::int32 var_11 = 3;
    wp::mat_t<3, 3, wp::float32> var_12;
    wp::mat_t<3, 3, wp::float32> var_13;
    wp::mat_t<3, 3, wp::float32> var_14;
    wp::mat_t<3, 3, wp::float32> var_15;
    wp::mat_t<3, 3, wp::float32> var_16;
    wp::mat_t<3, 3, wp::float32> var_17;
    wp::mat_t<3, 3, wp::float32> var_18;
    wp::mat_t<3, 3, wp::float32> var_19;
    wp::mat_t<3, 3, wp::float32> var_20;
    wp::vec_t<3, wp::float32> var_21;
    wp::vec_t<3, wp::float32> var_22;
    const wp::int32 var_23 = 1;
    wp::vec_t<3, wp::float32> var_24;
    wp::vec_t<3, wp::float32> var_25;
    wp::vec_t<3, wp::float32> var_26;
    wp::vec_t<3, wp::float32> var_27;
    wp::vec_t<3, wp::float32> var_28;
    const wp::int32 var_29 = 3;
    wp::mat_t<3, 3, wp::float32> var_30;
    wp::mat_t<3, 3, wp::float32> var_31;
    wp::mat_t<3, 3, wp::float32> var_32;
    wp::mat_t<3, 3, wp::float32> var_33;
    wp::mat_t<3, 3, wp::float32> var_34;
    wp::mat_t<3, 3, wp::float32> var_35;
    wp::mat_t<3, 3, wp::float32> var_36;
    wp::mat_t<3, 3, wp::float32> var_37;
    wp::mat_t<3, 3, wp::float32> var_38;
    wp::vec_t<3, wp::float32> var_39;
    wp::vec_t<3, wp::float32> var_40;
    const wp::int32 var_41 = 2;
    wp::vec_t<3, wp::float32> var_42;
    wp::vec_t<3, wp::float32> var_43;
    wp::vec_t<3, wp::float32> var_44;
    wp::vec_t<3, wp::float32> var_45;
    wp::vec_t<3, wp::float32> var_46;
    const wp::int32 var_47 = 3;
    wp::mat_t<3, 3, wp::float32> var_48;
    wp::mat_t<3, 3, wp::float32> var_49;
    wp::mat_t<3, 3, wp::float32> var_50;
    wp::mat_t<3, 3, wp::float32> var_51;
    wp::mat_t<3, 3, wp::float32> var_52;
    wp::mat_t<3, 3, wp::float32> var_53;
    wp::mat_t<3, 3, wp::float32> var_54;
    wp::mat_t<3, 3, wp::float32> var_55;
    wp::mat_t<3, 3, wp::float32> var_56;
    wp::vec_t<3, wp::float32> var_57;
    wp::vec_t<3, wp::float32> var_58;
    const wp::int32 var_59 = 3;
    wp::vec_t<3, wp::float32> var_60;
    wp::vec_t<3, wp::float32> var_61;
    wp::vec_t<3, wp::float32> var_62;
    wp::vec_t<3, wp::float32> var_63;
    wp::vec_t<3, wp::float32> var_64;
    const wp::int32 var_65 = 3;
    wp::mat_t<3, 3, wp::float32> var_66;
    wp::mat_t<3, 3, wp::float32> var_67;
    wp::mat_t<3, 3, wp::float32> var_68;
    wp::mat_t<3, 3, wp::float32> var_69;
    wp::mat_t<3, 3, wp::float32> var_70;
    wp::mat_t<3, 3, wp::float32> var_71;
    wp::mat_t<3, 3, wp::float32> var_72;
    wp::mat_t<3, 3, wp::float32> var_73;
    wp::mat_t<3, 3, wp::float32> var_74;
    wp::vec_t<3, wp::float32> var_75;
    wp::vec_t<3, wp::float32> var_76;
    const wp::int32 var_77 = 4;
    wp::vec_t<3, wp::float32> var_78;
    wp::vec_t<3, wp::float32> var_79;
    wp::vec_t<3, wp::float32> var_80;
    wp::vec_t<3, wp::float32> var_81;
    wp::vec_t<3, wp::float32> var_82;
    const wp::int32 var_83 = 3;
    wp::mat_t<3, 3, wp::float32> var_84;
    wp::mat_t<3, 3, wp::float32> var_85;
    wp::mat_t<3, 3, wp::float32> var_86;
    wp::mat_t<3, 3, wp::float32> var_87;
    wp::mat_t<3, 3, wp::float32> var_88;
    wp::mat_t<3, 3, wp::float32> var_89;
    wp::mat_t<3, 3, wp::float32> var_90;
    wp::mat_t<3, 3, wp::float32> var_91;
    wp::mat_t<3, 3, wp::float32> var_92;
    wp::vec_t<3, wp::float32> var_93;
    wp::vec_t<3, wp::float32> var_94;
    const wp::int32 var_95 = 5;
    wp::vec_t<3, wp::float32> var_96;
    wp::vec_t<3, wp::float32> var_97;
    wp::vec_t<3, wp::float32> var_98;
    wp::vec_t<3, wp::float32> var_99;
    wp::vec_t<3, wp::float32> var_100;
    const wp::int32 var_101 = 3;
    wp::mat_t<3, 3, wp::float32> var_102;
    wp::mat_t<3, 3, wp::float32> var_103;
    wp::mat_t<3, 3, wp::float32> var_104;
    wp::mat_t<3, 3, wp::float32> var_105;
    wp::mat_t<3, 3, wp::float32> var_106;
    wp::mat_t<3, 3, wp::float32> var_107;
    wp::mat_t<3, 3, wp::float32> var_108;
    wp::mat_t<3, 3, wp::float32> var_109;
    wp::mat_t<3, 3, wp::float32> var_110;
    wp::vec_t<3, wp::float32> var_111;
    wp::vec_t<3, wp::float32> var_112;
    const wp::int32 var_113 = 6;
    wp::vec_t<3, wp::float32> var_114;
    wp::vec_t<3, wp::float32> var_115;
    wp::vec_t<3, wp::float32> var_116;
    wp::vec_t<3, wp::float32> var_117;
    wp::vec_t<3, wp::float32> var_118;
    const wp::int32 var_119 = 3;
    wp::mat_t<3, 3, wp::float32> var_120;
    wp::mat_t<3, 3, wp::float32> var_121;
    wp::mat_t<3, 3, wp::float32> var_122;
    wp::mat_t<3, 3, wp::float32> var_123;
    wp::mat_t<3, 3, wp::float32> var_124;
    wp::mat_t<3, 3, wp::float32> var_125;
    wp::mat_t<3, 3, wp::float32> var_126;
    wp::mat_t<3, 3, wp::float32> var_127;
    wp::mat_t<3, 3, wp::float32> var_128;
    wp::vec_t<3, wp::float32> var_129;
    wp::vec_t<3, wp::float32> var_130;
    const wp::int32 var_131 = 7;
    wp::vec_t<3, wp::float32> var_132;
    wp::vec_t<3, wp::float32> var_133;
    wp::vec_t<3, wp::float32> var_134;
    wp::vec_t<3, wp::float32> var_135;
    wp::vec_t<3, wp::float32> var_136;
    const wp::int32 var_137 = 3;
    wp::mat_t<3, 3, wp::float32> var_138;
    wp::mat_t<3, 3, wp::float32> var_139;
    wp::mat_t<3, 3, wp::float32> var_140;
    wp::mat_t<3, 3, wp::float32> var_141;
    wp::mat_t<3, 3, wp::float32> var_142;
    wp::mat_t<3, 3, wp::float32> var_143;
    wp::mat_t<3, 3, wp::float32> var_144;
    wp::mat_t<3, 3, wp::float32> var_145;
    wp::mat_t<3, 3, wp::float32> var_146;
    wp::vec_t<3, wp::float32> var_147;
    wp::vec_t<3, wp::float32> var_148;
    wp::vec_t<3, wp::float32> var_149;
    wp::mat_t<3, 3, wp::float32> var_150;
    //---------
    // dual vars
    wp::mat_t<3, 3, wp::float32> adj_0 = {};
    wp::vec_t<3, wp::float32> adj_1 = {};
    wp::vec_t<3, wp::float32> adj_2 = {};
    wp::vec_t<3, wp::float32> adj_3 = {};
    wp::vec_t<3, wp::float32> adj_4 = {};
    wp::int32 adj_5 = {};
    wp::vec_t<3, wp::float32> adj_6 = {};
    wp::vec_t<3, wp::float32> adj_7 = {};
    wp::vec_t<3, wp::float32> adj_8 = {};
    wp::vec_t<3, wp::float32> adj_9 = {};
    wp::vec_t<3, wp::float32> adj_10 = {};
    wp::int32 adj_11 = {};
    wp::mat_t<3, 3, wp::float32> adj_12 = {};
    wp::mat_t<3, 3, wp::float32> adj_13 = {};
    wp::mat_t<3, 3, wp::float32> adj_14 = {};
    wp::mat_t<3, 3, wp::float32> adj_15 = {};
    wp::mat_t<3, 3, wp::float32> adj_16 = {};
    wp::mat_t<3, 3, wp::float32> adj_17 = {};
    wp::mat_t<3, 3, wp::float32> adj_18 = {};
    wp::mat_t<3, 3, wp::float32> adj_19 = {};
    wp::mat_t<3, 3, wp::float32> adj_20 = {};
    wp::vec_t<3, wp::float32> adj_21 = {};
    wp::vec_t<3, wp::float32> adj_22 = {};
    wp::int32 adj_23 = {};
    wp::vec_t<3, wp::float32> adj_24 = {};
    wp::vec_t<3, wp::float32> adj_25 = {};
    wp::vec_t<3, wp::float32> adj_26 = {};
    wp::vec_t<3, wp::float32> adj_27 = {};
    wp::vec_t<3, wp::float32> adj_28 = {};
    wp::int32 adj_29 = {};
    wp::mat_t<3, 3, wp::float32> adj_30 = {};
    wp::mat_t<3, 3, wp::float32> adj_31 = {};
    wp::mat_t<3, 3, wp::float32> adj_32 = {};
    wp::mat_t<3, 3, wp::float32> adj_33 = {};
    wp::mat_t<3, 3, wp::float32> adj_34 = {};
    wp::mat_t<3, 3, wp::float32> adj_35 = {};
    wp::mat_t<3, 3, wp::float32> adj_36 = {};
    wp::mat_t<3, 3, wp::float32> adj_37 = {};
    wp::mat_t<3, 3, wp::float32> adj_38 = {};
    wp::vec_t<3, wp::float32> adj_39 = {};
    wp::vec_t<3, wp::float32> adj_40 = {};
    wp::int32 adj_41 = {};
    wp::vec_t<3, wp::float32> adj_42 = {};
    wp::vec_t<3, wp::float32> adj_43 = {};
    wp::vec_t<3, wp::float32> adj_44 = {};
    wp::vec_t<3, wp::float32> adj_45 = {};
    wp::vec_t<3, wp::float32> adj_46 = {};
    wp::int32 adj_47 = {};
    wp::mat_t<3, 3, wp::float32> adj_48 = {};
    wp::mat_t<3, 3, wp::float32> adj_49 = {};
    wp::mat_t<3, 3, wp::float32> adj_50 = {};
    wp::mat_t<3, 3, wp::float32> adj_51 = {};
    wp::mat_t<3, 3, wp::float32> adj_52 = {};
    wp::mat_t<3, 3, wp::float32> adj_53 = {};
    wp::mat_t<3, 3, wp::float32> adj_54 = {};
    wp::mat_t<3, 3, wp::float32> adj_55 = {};
    wp::mat_t<3, 3, wp::float32> adj_56 = {};
    wp::vec_t<3, wp::float32> adj_57 = {};
    wp::vec_t<3, wp::float32> adj_58 = {};
    wp::int32 adj_59 = {};
    wp::vec_t<3, wp::float32> adj_60 = {};
    wp::vec_t<3, wp::float32> adj_61 = {};
    wp::vec_t<3, wp::float32> adj_62 = {};
    wp::vec_t<3, wp::float32> adj_63 = {};
    wp::vec_t<3, wp::float32> adj_64 = {};
    wp::int32 adj_65 = {};
    wp::mat_t<3, 3, wp::float32> adj_66 = {};
    wp::mat_t<3, 3, wp::float32> adj_67 = {};
    wp::mat_t<3, 3, wp::float32> adj_68 = {};
    wp::mat_t<3, 3, wp::float32> adj_69 = {};
    wp::mat_t<3, 3, wp::float32> adj_70 = {};
    wp::mat_t<3, 3, wp::float32> adj_71 = {};
    wp::mat_t<3, 3, wp::float32> adj_72 = {};
    wp::mat_t<3, 3, wp::float32> adj_73 = {};
    wp::mat_t<3, 3, wp::float32> adj_74 = {};
    wp::vec_t<3, wp::float32> adj_75 = {};
    wp::vec_t<3, wp::float32> adj_76 = {};
    wp::int32 adj_77 = {};
    wp::vec_t<3, wp::float32> adj_78 = {};
    wp::vec_t<3, wp::float32> adj_79 = {};
    wp::vec_t<3, wp::float32> adj_80 = {};
    wp::vec_t<3, wp::float32> adj_81 = {};
    wp::vec_t<3, wp::float32> adj_82 = {};
    wp::int32 adj_83 = {};
    wp::mat_t<3, 3, wp::float32> adj_84 = {};
    wp::mat_t<3, 3, wp::float32> adj_85 = {};
    wp::mat_t<3, 3, wp::float32> adj_86 = {};
    wp::mat_t<3, 3, wp::float32> adj_87 = {};
    wp::mat_t<3, 3, wp::float32> adj_88 = {};
    wp::mat_t<3, 3, wp::float32> adj_89 = {};
    wp::mat_t<3, 3, wp::float32> adj_90 = {};
    wp::mat_t<3, 3, wp::float32> adj_91 = {};
    wp::mat_t<3, 3, wp::float32> adj_92 = {};
    wp::vec_t<3, wp::float32> adj_93 = {};
    wp::vec_t<3, wp::float32> adj_94 = {};
    wp::int32 adj_95 = {};
    wp::vec_t<3, wp::float32> adj_96 = {};
    wp::vec_t<3, wp::float32> adj_97 = {};
    wp::vec_t<3, wp::float32> adj_98 = {};
    wp::vec_t<3, wp::float32> adj_99 = {};
    wp::vec_t<3, wp::float32> adj_100 = {};
    wp::int32 adj_101 = {};
    wp::mat_t<3, 3, wp::float32> adj_102 = {};
    wp::mat_t<3, 3, wp::float32> adj_103 = {};
    wp::mat_t<3, 3, wp::float32> adj_104 = {};
    wp::mat_t<3, 3, wp::float32> adj_105 = {};
    wp::mat_t<3, 3, wp::float32> adj_106 = {};
    wp::mat_t<3, 3, wp::float32> adj_107 = {};
    wp::mat_t<3, 3, wp::float32> adj_108 = {};
    wp::mat_t<3, 3, wp::float32> adj_109 = {};
    wp::mat_t<3, 3, wp::float32> adj_110 = {};
    wp::vec_t<3, wp::float32> adj_111 = {};
    wp::vec_t<3, wp::float32> adj_112 = {};
    wp::int32 adj_113 = {};
    wp::vec_t<3, wp::float32> adj_114 = {};
    wp::vec_t<3, wp::float32> adj_115 = {};
    wp::vec_t<3, wp::float32> adj_116 = {};
    wp::vec_t<3, wp::float32> adj_117 = {};
    wp::vec_t<3, wp::float32> adj_118 = {};
    wp::int32 adj_119 = {};
    wp::mat_t<3, 3, wp::float32> adj_120 = {};
    wp::mat_t<3, 3, wp::float32> adj_121 = {};
    wp::mat_t<3, 3, wp::float32> adj_122 = {};
    wp::mat_t<3, 3, wp::float32> adj_123 = {};
    wp::mat_t<3, 3, wp::float32> adj_124 = {};
    wp::mat_t<3, 3, wp::float32> adj_125 = {};
    wp::mat_t<3, 3, wp::float32> adj_126 = {};
    wp::mat_t<3, 3, wp::float32> adj_127 = {};
    wp::mat_t<3, 3, wp::float32> adj_128 = {};
    wp::vec_t<3, wp::float32> adj_129 = {};
    wp::vec_t<3, wp::float32> adj_130 = {};
    wp::int32 adj_131 = {};
    wp::vec_t<3, wp::float32> adj_132 = {};
    wp::vec_t<3, wp::float32> adj_133 = {};
    wp::vec_t<3, wp::float32> adj_134 = {};
    wp::vec_t<3, wp::float32> adj_135 = {};
    wp::vec_t<3, wp::float32> adj_136 = {};
    wp::int32 adj_137 = {};
    wp::mat_t<3, 3, wp::float32> adj_138 = {};
    wp::mat_t<3, 3, wp::float32> adj_139 = {};
    wp::mat_t<3, 3, wp::float32> adj_140 = {};
    wp::mat_t<3, 3, wp::float32> adj_141 = {};
    wp::mat_t<3, 3, wp::float32> adj_142 = {};
    wp::mat_t<3, 3, wp::float32> adj_143 = {};
    wp::mat_t<3, 3, wp::float32> adj_144 = {};
    wp::mat_t<3, 3, wp::float32> adj_145 = {};
    wp::mat_t<3, 3, wp::float32> adj_146 = {};
    wp::vec_t<3, wp::float32> adj_147 = {};
    wp::vec_t<3, wp::float32> adj_148 = {};
    wp::vec_t<3, wp::float32> adj_149 = {};
    wp::mat_t<3, 3, wp::float32> adj_150 = {};
    //---------
    // forward
    // def integrate_implicit_euler(                                                          <L 90>
    // inverse_inertia = wp.inverse(inertia)                                                  <L 96>
    var_0 = wp::inverse(var_inertia);
    // next_angular_momentum = angular_momentum + dt * wp.cross(                              <L 97>
    // angular_momentum,                                                                      <L 98>
    // inverse_inertia * angular_momentum,                                                    <L 99>
    var_1 = wp::mul(var_0, var_angular_momentum);
    var_2 = wp::cross(var_angular_momentum, var_1);
    var_3 = wp::mul(var_dt, var_2);
    var_4 = wp::add(var_angular_momentum, var_3);
    // for _ in range(8):                                                                     <L 102>
    // next_angular_velocity = inverse_inertia * next_angular_momentum                        <L 103>
    var_6 = wp::mul(var_0, var_4);
    // residual = (                                                                           <L 104>
    // next_angular_momentum                                                                  <L 105>
    // - angular_momentum                                                                     <L 106>
    var_7 = wp::sub(var_4, var_angular_momentum);
    // - dt * wp.cross(next_angular_momentum, next_angular_velocity)                          <L 107>
    var_8 = wp::cross(var_4, var_6);
    var_9 = wp::mul(var_dt, var_8);
    var_10 = wp::sub(var_7, var_9);
    // jacobian = (                                                                           <L 109>
    // wp.identity(3, dtype=float)                                                            <L 110>
    var_12 = wp::identity<3, wp::float32>();
    // + dt * wp.skew(next_angular_velocity)                                                  <L 111>
    var_13 = wp::skew(var_6);
    var_14 = wp::mul(var_dt, var_13);
    var_15 = wp::add(var_12, var_14);
    // - dt * wp.skew(next_angular_momentum) * inverse_inertia                                <L 112>
    var_16 = wp::skew(var_4);
    var_17 = wp::mul(var_dt, var_16);
    var_18 = wp::mul(var_17, var_0);
    var_19 = wp::sub(var_15, var_18);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 114>
    var_20 = wp::inverse(var_19);
    var_21 = wp::mul(var_20, var_10);
    var_22 = wp::sub(var_4, var_21);
    // next_angular_velocity = inverse_inertia * next_angular_momentum                        <L 103>
    var_24 = wp::mul(var_0, var_22);
    // residual = (                                                                           <L 104>
    // next_angular_momentum                                                                  <L 105>
    // - angular_momentum                                                                     <L 106>
    var_25 = wp::sub(var_22, var_angular_momentum);
    // - dt * wp.cross(next_angular_momentum, next_angular_velocity)                          <L 107>
    var_26 = wp::cross(var_22, var_24);
    var_27 = wp::mul(var_dt, var_26);
    var_28 = wp::sub(var_25, var_27);
    // jacobian = (                                                                           <L 109>
    // wp.identity(3, dtype=float)                                                            <L 110>
    var_30 = wp::identity<3, wp::float32>();
    // + dt * wp.skew(next_angular_velocity)                                                  <L 111>
    var_31 = wp::skew(var_24);
    var_32 = wp::mul(var_dt, var_31);
    var_33 = wp::add(var_30, var_32);
    // - dt * wp.skew(next_angular_momentum) * inverse_inertia                                <L 112>
    var_34 = wp::skew(var_22);
    var_35 = wp::mul(var_dt, var_34);
    var_36 = wp::mul(var_35, var_0);
    var_37 = wp::sub(var_33, var_36);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 114>
    var_38 = wp::inverse(var_37);
    var_39 = wp::mul(var_38, var_28);
    var_40 = wp::sub(var_22, var_39);
    // next_angular_velocity = inverse_inertia * next_angular_momentum                        <L 103>
    var_42 = wp::mul(var_0, var_40);
    // residual = (                                                                           <L 104>
    // next_angular_momentum                                                                  <L 105>
    // - angular_momentum                                                                     <L 106>
    var_43 = wp::sub(var_40, var_angular_momentum);
    // - dt * wp.cross(next_angular_momentum, next_angular_velocity)                          <L 107>
    var_44 = wp::cross(var_40, var_42);
    var_45 = wp::mul(var_dt, var_44);
    var_46 = wp::sub(var_43, var_45);
    // jacobian = (                                                                           <L 109>
    // wp.identity(3, dtype=float)                                                            <L 110>
    var_48 = wp::identity<3, wp::float32>();
    // + dt * wp.skew(next_angular_velocity)                                                  <L 111>
    var_49 = wp::skew(var_42);
    var_50 = wp::mul(var_dt, var_49);
    var_51 = wp::add(var_48, var_50);
    // - dt * wp.skew(next_angular_momentum) * inverse_inertia                                <L 112>
    var_52 = wp::skew(var_40);
    var_53 = wp::mul(var_dt, var_52);
    var_54 = wp::mul(var_53, var_0);
    var_55 = wp::sub(var_51, var_54);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 114>
    var_56 = wp::inverse(var_55);
    var_57 = wp::mul(var_56, var_46);
    var_58 = wp::sub(var_40, var_57);
    // next_angular_velocity = inverse_inertia * next_angular_momentum                        <L 103>
    var_60 = wp::mul(var_0, var_58);
    // residual = (                                                                           <L 104>
    // next_angular_momentum                                                                  <L 105>
    // - angular_momentum                                                                     <L 106>
    var_61 = wp::sub(var_58, var_angular_momentum);
    // - dt * wp.cross(next_angular_momentum, next_angular_velocity)                          <L 107>
    var_62 = wp::cross(var_58, var_60);
    var_63 = wp::mul(var_dt, var_62);
    var_64 = wp::sub(var_61, var_63);
    // jacobian = (                                                                           <L 109>
    // wp.identity(3, dtype=float)                                                            <L 110>
    var_66 = wp::identity<3, wp::float32>();
    // + dt * wp.skew(next_angular_velocity)                                                  <L 111>
    var_67 = wp::skew(var_60);
    var_68 = wp::mul(var_dt, var_67);
    var_69 = wp::add(var_66, var_68);
    // - dt * wp.skew(next_angular_momentum) * inverse_inertia                                <L 112>
    var_70 = wp::skew(var_58);
    var_71 = wp::mul(var_dt, var_70);
    var_72 = wp::mul(var_71, var_0);
    var_73 = wp::sub(var_69, var_72);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 114>
    var_74 = wp::inverse(var_73);
    var_75 = wp::mul(var_74, var_64);
    var_76 = wp::sub(var_58, var_75);
    // next_angular_velocity = inverse_inertia * next_angular_momentum                        <L 103>
    var_78 = wp::mul(var_0, var_76);
    // residual = (                                                                           <L 104>
    // next_angular_momentum                                                                  <L 105>
    // - angular_momentum                                                                     <L 106>
    var_79 = wp::sub(var_76, var_angular_momentum);
    // - dt * wp.cross(next_angular_momentum, next_angular_velocity)                          <L 107>
    var_80 = wp::cross(var_76, var_78);
    var_81 = wp::mul(var_dt, var_80);
    var_82 = wp::sub(var_79, var_81);
    // jacobian = (                                                                           <L 109>
    // wp.identity(3, dtype=float)                                                            <L 110>
    var_84 = wp::identity<3, wp::float32>();
    // + dt * wp.skew(next_angular_velocity)                                                  <L 111>
    var_85 = wp::skew(var_78);
    var_86 = wp::mul(var_dt, var_85);
    var_87 = wp::add(var_84, var_86);
    // - dt * wp.skew(next_angular_momentum) * inverse_inertia                                <L 112>
    var_88 = wp::skew(var_76);
    var_89 = wp::mul(var_dt, var_88);
    var_90 = wp::mul(var_89, var_0);
    var_91 = wp::sub(var_87, var_90);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 114>
    var_92 = wp::inverse(var_91);
    var_93 = wp::mul(var_92, var_82);
    var_94 = wp::sub(var_76, var_93);
    // next_angular_velocity = inverse_inertia * next_angular_momentum                        <L 103>
    var_96 = wp::mul(var_0, var_94);
    // residual = (                                                                           <L 104>
    // next_angular_momentum                                                                  <L 105>
    // - angular_momentum                                                                     <L 106>
    var_97 = wp::sub(var_94, var_angular_momentum);
    // - dt * wp.cross(next_angular_momentum, next_angular_velocity)                          <L 107>
    var_98 = wp::cross(var_94, var_96);
    var_99 = wp::mul(var_dt, var_98);
    var_100 = wp::sub(var_97, var_99);
    // jacobian = (                                                                           <L 109>
    // wp.identity(3, dtype=float)                                                            <L 110>
    var_102 = wp::identity<3, wp::float32>();
    // + dt * wp.skew(next_angular_velocity)                                                  <L 111>
    var_103 = wp::skew(var_96);
    var_104 = wp::mul(var_dt, var_103);
    var_105 = wp::add(var_102, var_104);
    // - dt * wp.skew(next_angular_momentum) * inverse_inertia                                <L 112>
    var_106 = wp::skew(var_94);
    var_107 = wp::mul(var_dt, var_106);
    var_108 = wp::mul(var_107, var_0);
    var_109 = wp::sub(var_105, var_108);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 114>
    var_110 = wp::inverse(var_109);
    var_111 = wp::mul(var_110, var_100);
    var_112 = wp::sub(var_94, var_111);
    // next_angular_velocity = inverse_inertia * next_angular_momentum                        <L 103>
    var_114 = wp::mul(var_0, var_112);
    // residual = (                                                                           <L 104>
    // next_angular_momentum                                                                  <L 105>
    // - angular_momentum                                                                     <L 106>
    var_115 = wp::sub(var_112, var_angular_momentum);
    // - dt * wp.cross(next_angular_momentum, next_angular_velocity)                          <L 107>
    var_116 = wp::cross(var_112, var_114);
    var_117 = wp::mul(var_dt, var_116);
    var_118 = wp::sub(var_115, var_117);
    // jacobian = (                                                                           <L 109>
    // wp.identity(3, dtype=float)                                                            <L 110>
    var_120 = wp::identity<3, wp::float32>();
    // + dt * wp.skew(next_angular_velocity)                                                  <L 111>
    var_121 = wp::skew(var_114);
    var_122 = wp::mul(var_dt, var_121);
    var_123 = wp::add(var_120, var_122);
    // - dt * wp.skew(next_angular_momentum) * inverse_inertia                                <L 112>
    var_124 = wp::skew(var_112);
    var_125 = wp::mul(var_dt, var_124);
    var_126 = wp::mul(var_125, var_0);
    var_127 = wp::sub(var_123, var_126);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 114>
    var_128 = wp::inverse(var_127);
    var_129 = wp::mul(var_128, var_118);
    var_130 = wp::sub(var_112, var_129);
    // next_angular_velocity = inverse_inertia * next_angular_momentum                        <L 103>
    var_132 = wp::mul(var_0, var_130);
    // residual = (                                                                           <L 104>
    // next_angular_momentum                                                                  <L 105>
    // - angular_momentum                                                                     <L 106>
    var_133 = wp::sub(var_130, var_angular_momentum);
    // - dt * wp.cross(next_angular_momentum, next_angular_velocity)                          <L 107>
    var_134 = wp::cross(var_130, var_132);
    var_135 = wp::mul(var_dt, var_134);
    var_136 = wp::sub(var_133, var_135);
    // jacobian = (                                                                           <L 109>
    // wp.identity(3, dtype=float)                                                            <L 110>
    var_138 = wp::identity<3, wp::float32>();
    // + dt * wp.skew(next_angular_velocity)                                                  <L 111>
    var_139 = wp::skew(var_132);
    var_140 = wp::mul(var_dt, var_139);
    var_141 = wp::add(var_138, var_140);
    // - dt * wp.skew(next_angular_momentum) * inverse_inertia                                <L 112>
    var_142 = wp::skew(var_130);
    var_143 = wp::mul(var_dt, var_142);
    var_144 = wp::mul(var_143, var_0);
    var_145 = wp::sub(var_141, var_144);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 114>
    var_146 = wp::inverse(var_145);
    var_147 = wp::mul(var_146, var_136);
    var_148 = wp::sub(var_130, var_147);
    // next_angular_velocity = inverse_inertia * next_angular_momentum                        <L 116>
    var_149 = wp::mul(var_0, var_148);
    // relative_rotation = _exponential_increment(next_angular_velocity, dt)                  <L 117>
    var_150 = _exponential_increment_0(var_149, var_dt);
    // return next_angular_momentum, relative_rotation                                        <L 118>
    ret_0 = var_148;
    ret_1 = var_150;
    goto label0;
    //---------
    // reverse
    label0:;
    adj_150 += adj_ret_1;
    adj_148 += adj_ret_0;
    // adj: return next_angular_momentum, relative_rotation                                   <L 118>
    adj__exponential_increment_0(var_149, var_dt, adj_149, adj_dt, adj_150);
    // adj: relative_rotation = _exponential_increment(next_angular_velocity, dt)             <L 117>
    wp::adj_mul(var_0, var_148, adj_0, adj_148, adj_149);
    // adj: next_angular_velocity = inverse_inertia * next_angular_momentum                   <L 116>
    wp::adj_sub(var_130, var_147, adj_130, adj_147, adj_148);
    wp::adj_mul(var_146, var_136, adj_146, adj_136, adj_147);
    wp::adj_inverse(var_145, var_146, adj_145, adj_146);
    // adj: next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual   <L 114>
    wp::adj_sub(var_141, var_144, adj_141, adj_144, adj_145);
    wp::adj_mul(var_143, var_0, adj_143, adj_0, adj_144);
    wp::adj_mul(var_dt, var_142, adj_dt, adj_142, adj_143);
    wp::adj_skew(var_130, adj_130, adj_142);
    // adj: - dt * wp.skew(next_angular_momentum) * inverse_inertia                           <L 112>
    wp::adj_add(var_138, var_140, adj_138, adj_140, adj_141);
    wp::adj_mul(var_dt, var_139, adj_dt, adj_139, adj_140);
    wp::adj_skew(var_132, adj_132, adj_139);
    // adj: + dt * wp.skew(next_angular_velocity)                                             <L 111>
    // adj: wp.identity(3, dtype=float)                                                       <L 110>
    // adj: jacobian = (                                                                      <L 109>
    wp::adj_sub(var_133, var_135, adj_133, adj_135, adj_136);
    wp::adj_mul(var_dt, var_134, adj_dt, adj_134, adj_135);
    wp::adj_cross(var_130, var_132, adj_130, adj_132, adj_134);
    // adj: - dt * wp.cross(next_angular_momentum, next_angular_velocity)                     <L 107>
    wp::adj_sub(var_130, var_angular_momentum, adj_130, adj_angular_momentum, adj_133);
    // adj: - angular_momentum                                                                <L 106>
    // adj: next_angular_momentum                                                             <L 105>
    // adj: residual = (                                                                      <L 104>
    wp::adj_mul(var_0, var_130, adj_0, adj_130, adj_132);
    // adj: next_angular_velocity = inverse_inertia * next_angular_momentum                   <L 103>
    wp::adj_sub(var_112, var_129, adj_112, adj_129, adj_130);
    wp::adj_mul(var_128, var_118, adj_128, adj_118, adj_129);
    wp::adj_inverse(var_127, var_128, adj_127, adj_128);
    // adj: next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual   <L 114>
    wp::adj_sub(var_123, var_126, adj_123, adj_126, adj_127);
    wp::adj_mul(var_125, var_0, adj_125, adj_0, adj_126);
    wp::adj_mul(var_dt, var_124, adj_dt, adj_124, adj_125);
    wp::adj_skew(var_112, adj_112, adj_124);
    // adj: - dt * wp.skew(next_angular_momentum) * inverse_inertia                           <L 112>
    wp::adj_add(var_120, var_122, adj_120, adj_122, adj_123);
    wp::adj_mul(var_dt, var_121, adj_dt, adj_121, adj_122);
    wp::adj_skew(var_114, adj_114, adj_121);
    // adj: + dt * wp.skew(next_angular_velocity)                                             <L 111>
    // adj: wp.identity(3, dtype=float)                                                       <L 110>
    // adj: jacobian = (                                                                      <L 109>
    wp::adj_sub(var_115, var_117, adj_115, adj_117, adj_118);
    wp::adj_mul(var_dt, var_116, adj_dt, adj_116, adj_117);
    wp::adj_cross(var_112, var_114, adj_112, adj_114, adj_116);
    // adj: - dt * wp.cross(next_angular_momentum, next_angular_velocity)                     <L 107>
    wp::adj_sub(var_112, var_angular_momentum, adj_112, adj_angular_momentum, adj_115);
    // adj: - angular_momentum                                                                <L 106>
    // adj: next_angular_momentum                                                             <L 105>
    // adj: residual = (                                                                      <L 104>
    wp::adj_mul(var_0, var_112, adj_0, adj_112, adj_114);
    // adj: next_angular_velocity = inverse_inertia * next_angular_momentum                   <L 103>
    wp::adj_sub(var_94, var_111, adj_94, adj_111, adj_112);
    wp::adj_mul(var_110, var_100, adj_110, adj_100, adj_111);
    wp::adj_inverse(var_109, var_110, adj_109, adj_110);
    // adj: next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual   <L 114>
    wp::adj_sub(var_105, var_108, adj_105, adj_108, adj_109);
    wp::adj_mul(var_107, var_0, adj_107, adj_0, adj_108);
    wp::adj_mul(var_dt, var_106, adj_dt, adj_106, adj_107);
    wp::adj_skew(var_94, adj_94, adj_106);
    // adj: - dt * wp.skew(next_angular_momentum) * inverse_inertia                           <L 112>
    wp::adj_add(var_102, var_104, adj_102, adj_104, adj_105);
    wp::adj_mul(var_dt, var_103, adj_dt, adj_103, adj_104);
    wp::adj_skew(var_96, adj_96, adj_103);
    // adj: + dt * wp.skew(next_angular_velocity)                                             <L 111>
    // adj: wp.identity(3, dtype=float)                                                       <L 110>
    // adj: jacobian = (                                                                      <L 109>
    wp::adj_sub(var_97, var_99, adj_97, adj_99, adj_100);
    wp::adj_mul(var_dt, var_98, adj_dt, adj_98, adj_99);
    wp::adj_cross(var_94, var_96, adj_94, adj_96, adj_98);
    // adj: - dt * wp.cross(next_angular_momentum, next_angular_velocity)                     <L 107>
    wp::adj_sub(var_94, var_angular_momentum, adj_94, adj_angular_momentum, adj_97);
    // adj: - angular_momentum                                                                <L 106>
    // adj: next_angular_momentum                                                             <L 105>
    // adj: residual = (                                                                      <L 104>
    wp::adj_mul(var_0, var_94, adj_0, adj_94, adj_96);
    // adj: next_angular_velocity = inverse_inertia * next_angular_momentum                   <L 103>
    wp::adj_sub(var_76, var_93, adj_76, adj_93, adj_94);
    wp::adj_mul(var_92, var_82, adj_92, adj_82, adj_93);
    wp::adj_inverse(var_91, var_92, adj_91, adj_92);
    // adj: next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual   <L 114>
    wp::adj_sub(var_87, var_90, adj_87, adj_90, adj_91);
    wp::adj_mul(var_89, var_0, adj_89, adj_0, adj_90);
    wp::adj_mul(var_dt, var_88, adj_dt, adj_88, adj_89);
    wp::adj_skew(var_76, adj_76, adj_88);
    // adj: - dt * wp.skew(next_angular_momentum) * inverse_inertia                           <L 112>
    wp::adj_add(var_84, var_86, adj_84, adj_86, adj_87);
    wp::adj_mul(var_dt, var_85, adj_dt, adj_85, adj_86);
    wp::adj_skew(var_78, adj_78, adj_85);
    // adj: + dt * wp.skew(next_angular_velocity)                                             <L 111>
    // adj: wp.identity(3, dtype=float)                                                       <L 110>
    // adj: jacobian = (                                                                      <L 109>
    wp::adj_sub(var_79, var_81, adj_79, adj_81, adj_82);
    wp::adj_mul(var_dt, var_80, adj_dt, adj_80, adj_81);
    wp::adj_cross(var_76, var_78, adj_76, adj_78, adj_80);
    // adj: - dt * wp.cross(next_angular_momentum, next_angular_velocity)                     <L 107>
    wp::adj_sub(var_76, var_angular_momentum, adj_76, adj_angular_momentum, adj_79);
    // adj: - angular_momentum                                                                <L 106>
    // adj: next_angular_momentum                                                             <L 105>
    // adj: residual = (                                                                      <L 104>
    wp::adj_mul(var_0, var_76, adj_0, adj_76, adj_78);
    // adj: next_angular_velocity = inverse_inertia * next_angular_momentum                   <L 103>
    wp::adj_sub(var_58, var_75, adj_58, adj_75, adj_76);
    wp::adj_mul(var_74, var_64, adj_74, adj_64, adj_75);
    wp::adj_inverse(var_73, var_74, adj_73, adj_74);
    // adj: next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual   <L 114>
    wp::adj_sub(var_69, var_72, adj_69, adj_72, adj_73);
    wp::adj_mul(var_71, var_0, adj_71, adj_0, adj_72);
    wp::adj_mul(var_dt, var_70, adj_dt, adj_70, adj_71);
    wp::adj_skew(var_58, adj_58, adj_70);
    // adj: - dt * wp.skew(next_angular_momentum) * inverse_inertia                           <L 112>
    wp::adj_add(var_66, var_68, adj_66, adj_68, adj_69);
    wp::adj_mul(var_dt, var_67, adj_dt, adj_67, adj_68);
    wp::adj_skew(var_60, adj_60, adj_67);
    // adj: + dt * wp.skew(next_angular_velocity)                                             <L 111>
    // adj: wp.identity(3, dtype=float)                                                       <L 110>
    // adj: jacobian = (                                                                      <L 109>
    wp::adj_sub(var_61, var_63, adj_61, adj_63, adj_64);
    wp::adj_mul(var_dt, var_62, adj_dt, adj_62, adj_63);
    wp::adj_cross(var_58, var_60, adj_58, adj_60, adj_62);
    // adj: - dt * wp.cross(next_angular_momentum, next_angular_velocity)                     <L 107>
    wp::adj_sub(var_58, var_angular_momentum, adj_58, adj_angular_momentum, adj_61);
    // adj: - angular_momentum                                                                <L 106>
    // adj: next_angular_momentum                                                             <L 105>
    // adj: residual = (                                                                      <L 104>
    wp::adj_mul(var_0, var_58, adj_0, adj_58, adj_60);
    // adj: next_angular_velocity = inverse_inertia * next_angular_momentum                   <L 103>
    wp::adj_sub(var_40, var_57, adj_40, adj_57, adj_58);
    wp::adj_mul(var_56, var_46, adj_56, adj_46, adj_57);
    wp::adj_inverse(var_55, var_56, adj_55, adj_56);
    // adj: next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual   <L 114>
    wp::adj_sub(var_51, var_54, adj_51, adj_54, adj_55);
    wp::adj_mul(var_53, var_0, adj_53, adj_0, adj_54);
    wp::adj_mul(var_dt, var_52, adj_dt, adj_52, adj_53);
    wp::adj_skew(var_40, adj_40, adj_52);
    // adj: - dt * wp.skew(next_angular_momentum) * inverse_inertia                           <L 112>
    wp::adj_add(var_48, var_50, adj_48, adj_50, adj_51);
    wp::adj_mul(var_dt, var_49, adj_dt, adj_49, adj_50);
    wp::adj_skew(var_42, adj_42, adj_49);
    // adj: + dt * wp.skew(next_angular_velocity)                                             <L 111>
    // adj: wp.identity(3, dtype=float)                                                       <L 110>
    // adj: jacobian = (                                                                      <L 109>
    wp::adj_sub(var_43, var_45, adj_43, adj_45, adj_46);
    wp::adj_mul(var_dt, var_44, adj_dt, adj_44, adj_45);
    wp::adj_cross(var_40, var_42, adj_40, adj_42, adj_44);
    // adj: - dt * wp.cross(next_angular_momentum, next_angular_velocity)                     <L 107>
    wp::adj_sub(var_40, var_angular_momentum, adj_40, adj_angular_momentum, adj_43);
    // adj: - angular_momentum                                                                <L 106>
    // adj: next_angular_momentum                                                             <L 105>
    // adj: residual = (                                                                      <L 104>
    wp::adj_mul(var_0, var_40, adj_0, adj_40, adj_42);
    // adj: next_angular_velocity = inverse_inertia * next_angular_momentum                   <L 103>
    wp::adj_sub(var_22, var_39, adj_22, adj_39, adj_40);
    wp::adj_mul(var_38, var_28, adj_38, adj_28, adj_39);
    wp::adj_inverse(var_37, var_38, adj_37, adj_38);
    // adj: next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual   <L 114>
    wp::adj_sub(var_33, var_36, adj_33, adj_36, adj_37);
    wp::adj_mul(var_35, var_0, adj_35, adj_0, adj_36);
    wp::adj_mul(var_dt, var_34, adj_dt, adj_34, adj_35);
    wp::adj_skew(var_22, adj_22, adj_34);
    // adj: - dt * wp.skew(next_angular_momentum) * inverse_inertia                           <L 112>
    wp::adj_add(var_30, var_32, adj_30, adj_32, adj_33);
    wp::adj_mul(var_dt, var_31, adj_dt, adj_31, adj_32);
    wp::adj_skew(var_24, adj_24, adj_31);
    // adj: + dt * wp.skew(next_angular_velocity)                                             <L 111>
    // adj: wp.identity(3, dtype=float)                                                       <L 110>
    // adj: jacobian = (                                                                      <L 109>
    wp::adj_sub(var_25, var_27, adj_25, adj_27, adj_28);
    wp::adj_mul(var_dt, var_26, adj_dt, adj_26, adj_27);
    wp::adj_cross(var_22, var_24, adj_22, adj_24, adj_26);
    // adj: - dt * wp.cross(next_angular_momentum, next_angular_velocity)                     <L 107>
    wp::adj_sub(var_22, var_angular_momentum, adj_22, adj_angular_momentum, adj_25);
    // adj: - angular_momentum                                                                <L 106>
    // adj: next_angular_momentum                                                             <L 105>
    // adj: residual = (                                                                      <L 104>
    wp::adj_mul(var_0, var_22, adj_0, adj_22, adj_24);
    // adj: next_angular_velocity = inverse_inertia * next_angular_momentum                   <L 103>
    wp::adj_sub(var_4, var_21, adj_4, adj_21, adj_22);
    wp::adj_mul(var_20, var_10, adj_20, adj_10, adj_21);
    wp::adj_inverse(var_19, var_20, adj_19, adj_20);
    // adj: next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual   <L 114>
    wp::adj_sub(var_15, var_18, adj_15, adj_18, adj_19);
    wp::adj_mul(var_17, var_0, adj_17, adj_0, adj_18);
    wp::adj_mul(var_dt, var_16, adj_dt, adj_16, adj_17);
    wp::adj_skew(var_4, adj_4, adj_16);
    // adj: - dt * wp.skew(next_angular_momentum) * inverse_inertia                           <L 112>
    wp::adj_add(var_12, var_14, adj_12, adj_14, adj_15);
    wp::adj_mul(var_dt, var_13, adj_dt, adj_13, adj_14);
    wp::adj_skew(var_6, adj_6, adj_13);
    // adj: + dt * wp.skew(next_angular_velocity)                                             <L 111>
    // adj: wp.identity(3, dtype=float)                                                       <L 110>
    // adj: jacobian = (                                                                      <L 109>
    wp::adj_sub(var_7, var_9, adj_7, adj_9, adj_10);
    wp::adj_mul(var_dt, var_8, adj_dt, adj_8, adj_9);
    wp::adj_cross(var_4, var_6, adj_4, adj_6, adj_8);
    // adj: - dt * wp.cross(next_angular_momentum, next_angular_velocity)                     <L 107>
    wp::adj_sub(var_4, var_angular_momentum, adj_4, adj_angular_momentum, adj_7);
    // adj: - angular_momentum                                                                <L 106>
    // adj: next_angular_momentum                                                             <L 105>
    // adj: residual = (                                                                      <L 104>
    wp::adj_mul(var_0, var_4, adj_0, adj_4, adj_6);
    // adj: next_angular_velocity = inverse_inertia * next_angular_momentum                   <L 103>
    // adj: for _ in range(8):                                                                <L 102>
    wp::adj_add(var_angular_momentum, var_3, adj_angular_momentum, adj_3, adj_4);
    wp::adj_mul(var_dt, var_2, adj_dt, adj_2, adj_3);
    wp::adj_cross(var_angular_momentum, var_1, adj_angular_momentum, adj_1, adj_2);
    wp::adj_mul(var_0, var_angular_momentum, adj_0, adj_angular_momentum, adj_1);
    // adj: inverse_inertia * angular_momentum,                                               <L 99>
    // adj: angular_momentum,                                                                 <L 98>
    // adj: next_angular_momentum = angular_momentum + dt * wp.cross(                         <L 97>
    wp::adj_inverse(var_inertia, var_0, adj_inertia, adj_0);
    // adj: inverse_inertia = wp.inverse(inertia)                                             <L 96>
    // adj: def integrate_implicit_euler(                                                     <L 90>
    return;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:121
static CUDA_CALLABLE void adj_integrate_lie_group_midpoint_0(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::vec_t<3, wp::float32> var_angular_momentum,
    wp::float32 var_dt,
    wp::vec_t<3, wp::float32> & ret_0,
    wp::mat_t<3, 3, wp::float32> & ret_1,
    wp::mat_t<3, 3, wp::float32> & adj_inertia,
    wp::vec_t<3, wp::float32> & adj_angular_momentum,
    wp::float32 & adj_dt,
    wp::vec_t<3, wp::float32> & adj_ret_0,
    wp::mat_t<3, 3, wp::float32> & adj_ret_1)
{
    //---------
    // primal vars
    wp::mat_t<3, 3, wp::float32> var_0;
    wp::vec_t<3, wp::float32> var_1;
    const wp::int32 var_2 = 0;
    const wp::float32 var_3 = 0.5;
    wp::float32 var_4;
    wp::mat_t<3, 3, wp::float32> var_5;
    wp::mat_t<3, 3, wp::float32> var_6;
    wp::mat_t<3, 3, wp::float32> var_7;
    wp::mat_t<3, 3, wp::float32> var_8;
    wp::vec_t<3, wp::float32> var_9;
    const wp::int32 var_10 = 1;
    const wp::float32 var_11 = 0.5;
    wp::float32 var_12;
    wp::mat_t<3, 3, wp::float32> var_13;
    wp::mat_t<3, 3, wp::float32> var_14;
    wp::mat_t<3, 3, wp::float32> var_15;
    wp::mat_t<3, 3, wp::float32> var_16;
    wp::vec_t<3, wp::float32> var_17;
    const wp::int32 var_18 = 2;
    const wp::float32 var_19 = 0.5;
    wp::float32 var_20;
    wp::mat_t<3, 3, wp::float32> var_21;
    wp::mat_t<3, 3, wp::float32> var_22;
    wp::mat_t<3, 3, wp::float32> var_23;
    wp::mat_t<3, 3, wp::float32> var_24;
    wp::vec_t<3, wp::float32> var_25;
    const wp::int32 var_26 = 3;
    const wp::float32 var_27 = 0.5;
    wp::float32 var_28;
    wp::mat_t<3, 3, wp::float32> var_29;
    wp::mat_t<3, 3, wp::float32> var_30;
    wp::mat_t<3, 3, wp::float32> var_31;
    wp::mat_t<3, 3, wp::float32> var_32;
    wp::vec_t<3, wp::float32> var_33;
    const wp::int32 var_34 = 4;
    const wp::float32 var_35 = 0.5;
    wp::float32 var_36;
    wp::mat_t<3, 3, wp::float32> var_37;
    wp::mat_t<3, 3, wp::float32> var_38;
    wp::mat_t<3, 3, wp::float32> var_39;
    wp::mat_t<3, 3, wp::float32> var_40;
    wp::vec_t<3, wp::float32> var_41;
    const wp::int32 var_42 = 5;
    const wp::float32 var_43 = 0.5;
    wp::float32 var_44;
    wp::mat_t<3, 3, wp::float32> var_45;
    wp::mat_t<3, 3, wp::float32> var_46;
    wp::mat_t<3, 3, wp::float32> var_47;
    wp::mat_t<3, 3, wp::float32> var_48;
    wp::vec_t<3, wp::float32> var_49;
    const wp::int32 var_50 = 6;
    const wp::float32 var_51 = 0.5;
    wp::float32 var_52;
    wp::mat_t<3, 3, wp::float32> var_53;
    wp::mat_t<3, 3, wp::float32> var_54;
    wp::mat_t<3, 3, wp::float32> var_55;
    wp::mat_t<3, 3, wp::float32> var_56;
    wp::vec_t<3, wp::float32> var_57;
    const wp::int32 var_58 = 7;
    const wp::float32 var_59 = 0.5;
    wp::float32 var_60;
    wp::mat_t<3, 3, wp::float32> var_61;
    wp::mat_t<3, 3, wp::float32> var_62;
    wp::mat_t<3, 3, wp::float32> var_63;
    wp::mat_t<3, 3, wp::float32> var_64;
    wp::vec_t<3, wp::float32> var_65;
    wp::mat_t<3, 3, wp::float32> var_66;
    wp::mat_t<3, 3, wp::float32> var_67;
    wp::vec_t<3, wp::float32> var_68;
    //---------
    // dual vars
    wp::mat_t<3, 3, wp::float32> adj_0 = {};
    wp::vec_t<3, wp::float32> adj_1 = {};
    wp::int32 adj_2 = {};
    wp::float32 adj_3 = {};
    wp::float32 adj_4 = {};
    wp::mat_t<3, 3, wp::float32> adj_5 = {};
    wp::mat_t<3, 3, wp::float32> adj_6 = {};
    wp::mat_t<3, 3, wp::float32> adj_7 = {};
    wp::mat_t<3, 3, wp::float32> adj_8 = {};
    wp::vec_t<3, wp::float32> adj_9 = {};
    wp::int32 adj_10 = {};
    wp::float32 adj_11 = {};
    wp::float32 adj_12 = {};
    wp::mat_t<3, 3, wp::float32> adj_13 = {};
    wp::mat_t<3, 3, wp::float32> adj_14 = {};
    wp::mat_t<3, 3, wp::float32> adj_15 = {};
    wp::mat_t<3, 3, wp::float32> adj_16 = {};
    wp::vec_t<3, wp::float32> adj_17 = {};
    wp::int32 adj_18 = {};
    wp::float32 adj_19 = {};
    wp::float32 adj_20 = {};
    wp::mat_t<3, 3, wp::float32> adj_21 = {};
    wp::mat_t<3, 3, wp::float32> adj_22 = {};
    wp::mat_t<3, 3, wp::float32> adj_23 = {};
    wp::mat_t<3, 3, wp::float32> adj_24 = {};
    wp::vec_t<3, wp::float32> adj_25 = {};
    wp::int32 adj_26 = {};
    wp::float32 adj_27 = {};
    wp::float32 adj_28 = {};
    wp::mat_t<3, 3, wp::float32> adj_29 = {};
    wp::mat_t<3, 3, wp::float32> adj_30 = {};
    wp::mat_t<3, 3, wp::float32> adj_31 = {};
    wp::mat_t<3, 3, wp::float32> adj_32 = {};
    wp::vec_t<3, wp::float32> adj_33 = {};
    wp::int32 adj_34 = {};
    wp::float32 adj_35 = {};
    wp::float32 adj_36 = {};
    wp::mat_t<3, 3, wp::float32> adj_37 = {};
    wp::mat_t<3, 3, wp::float32> adj_38 = {};
    wp::mat_t<3, 3, wp::float32> adj_39 = {};
    wp::mat_t<3, 3, wp::float32> adj_40 = {};
    wp::vec_t<3, wp::float32> adj_41 = {};
    wp::int32 adj_42 = {};
    wp::float32 adj_43 = {};
    wp::float32 adj_44 = {};
    wp::mat_t<3, 3, wp::float32> adj_45 = {};
    wp::mat_t<3, 3, wp::float32> adj_46 = {};
    wp::mat_t<3, 3, wp::float32> adj_47 = {};
    wp::mat_t<3, 3, wp::float32> adj_48 = {};
    wp::vec_t<3, wp::float32> adj_49 = {};
    wp::int32 adj_50 = {};
    wp::float32 adj_51 = {};
    wp::float32 adj_52 = {};
    wp::mat_t<3, 3, wp::float32> adj_53 = {};
    wp::mat_t<3, 3, wp::float32> adj_54 = {};
    wp::mat_t<3, 3, wp::float32> adj_55 = {};
    wp::mat_t<3, 3, wp::float32> adj_56 = {};
    wp::vec_t<3, wp::float32> adj_57 = {};
    wp::int32 adj_58 = {};
    wp::float32 adj_59 = {};
    wp::float32 adj_60 = {};
    wp::mat_t<3, 3, wp::float32> adj_61 = {};
    wp::mat_t<3, 3, wp::float32> adj_62 = {};
    wp::mat_t<3, 3, wp::float32> adj_63 = {};
    wp::mat_t<3, 3, wp::float32> adj_64 = {};
    wp::vec_t<3, wp::float32> adj_65 = {};
    wp::mat_t<3, 3, wp::float32> adj_66 = {};
    wp::mat_t<3, 3, wp::float32> adj_67 = {};
    wp::vec_t<3, wp::float32> adj_68 = {};
    //---------
    // forward
    // def integrate_lie_group_midpoint(                                                      <L 122>
    // inverse_inertia = wp.inverse(inertia)                                                  <L 128>
    var_0 = wp::inverse(var_inertia);
    // midpoint_angular_velocity = inverse_inertia * angular_momentum                         <L 129>
    var_1 = wp::mul(var_0, var_angular_momentum);
    // for _ in range(8):                                                                     <L 131>
    // half_rotation = _exponential_increment(midpoint_angular_velocity, 0.5 * dt)            <L 132>
    var_4 = wp::mul(var_3, var_dt);
    var_5 = _exponential_increment_0(var_1, var_4);
    // midpoint_angular_velocity = (                                                          <L 133>
    // half_rotation                                                                          <L 134>
    // * inverse_inertia                                                                      <L 135>
    var_6 = wp::mul(var_5, var_0);
    // * wp.transpose(half_rotation)                                                          <L 136>
    var_7 = wp::transpose(var_5);
    var_8 = wp::mul(var_6, var_7);
    // * angular_momentum                                                                     <L 137>
    var_9 = wp::mul(var_8, var_angular_momentum);
    // half_rotation = _exponential_increment(midpoint_angular_velocity, 0.5 * dt)            <L 132>
    var_12 = wp::mul(var_11, var_dt);
    var_13 = _exponential_increment_0(var_9, var_12);
    // midpoint_angular_velocity = (                                                          <L 133>
    // half_rotation                                                                          <L 134>
    // * inverse_inertia                                                                      <L 135>
    var_14 = wp::mul(var_13, var_0);
    // * wp.transpose(half_rotation)                                                          <L 136>
    var_15 = wp::transpose(var_13);
    var_16 = wp::mul(var_14, var_15);
    // * angular_momentum                                                                     <L 137>
    var_17 = wp::mul(var_16, var_angular_momentum);
    // half_rotation = _exponential_increment(midpoint_angular_velocity, 0.5 * dt)            <L 132>
    var_20 = wp::mul(var_19, var_dt);
    var_21 = _exponential_increment_0(var_17, var_20);
    // midpoint_angular_velocity = (                                                          <L 133>
    // half_rotation                                                                          <L 134>
    // * inverse_inertia                                                                      <L 135>
    var_22 = wp::mul(var_21, var_0);
    // * wp.transpose(half_rotation)                                                          <L 136>
    var_23 = wp::transpose(var_21);
    var_24 = wp::mul(var_22, var_23);
    // * angular_momentum                                                                     <L 137>
    var_25 = wp::mul(var_24, var_angular_momentum);
    // half_rotation = _exponential_increment(midpoint_angular_velocity, 0.5 * dt)            <L 132>
    var_28 = wp::mul(var_27, var_dt);
    var_29 = _exponential_increment_0(var_25, var_28);
    // midpoint_angular_velocity = (                                                          <L 133>
    // half_rotation                                                                          <L 134>
    // * inverse_inertia                                                                      <L 135>
    var_30 = wp::mul(var_29, var_0);
    // * wp.transpose(half_rotation)                                                          <L 136>
    var_31 = wp::transpose(var_29);
    var_32 = wp::mul(var_30, var_31);
    // * angular_momentum                                                                     <L 137>
    var_33 = wp::mul(var_32, var_angular_momentum);
    // half_rotation = _exponential_increment(midpoint_angular_velocity, 0.5 * dt)            <L 132>
    var_36 = wp::mul(var_35, var_dt);
    var_37 = _exponential_increment_0(var_33, var_36);
    // midpoint_angular_velocity = (                                                          <L 133>
    // half_rotation                                                                          <L 134>
    // * inverse_inertia                                                                      <L 135>
    var_38 = wp::mul(var_37, var_0);
    // * wp.transpose(half_rotation)                                                          <L 136>
    var_39 = wp::transpose(var_37);
    var_40 = wp::mul(var_38, var_39);
    // * angular_momentum                                                                     <L 137>
    var_41 = wp::mul(var_40, var_angular_momentum);
    // half_rotation = _exponential_increment(midpoint_angular_velocity, 0.5 * dt)            <L 132>
    var_44 = wp::mul(var_43, var_dt);
    var_45 = _exponential_increment_0(var_41, var_44);
    // midpoint_angular_velocity = (                                                          <L 133>
    // half_rotation                                                                          <L 134>
    // * inverse_inertia                                                                      <L 135>
    var_46 = wp::mul(var_45, var_0);
    // * wp.transpose(half_rotation)                                                          <L 136>
    var_47 = wp::transpose(var_45);
    var_48 = wp::mul(var_46, var_47);
    // * angular_momentum                                                                     <L 137>
    var_49 = wp::mul(var_48, var_angular_momentum);
    // half_rotation = _exponential_increment(midpoint_angular_velocity, 0.5 * dt)            <L 132>
    var_52 = wp::mul(var_51, var_dt);
    var_53 = _exponential_increment_0(var_49, var_52);
    // midpoint_angular_velocity = (                                                          <L 133>
    // half_rotation                                                                          <L 134>
    // * inverse_inertia                                                                      <L 135>
    var_54 = wp::mul(var_53, var_0);
    // * wp.transpose(half_rotation)                                                          <L 136>
    var_55 = wp::transpose(var_53);
    var_56 = wp::mul(var_54, var_55);
    // * angular_momentum                                                                     <L 137>
    var_57 = wp::mul(var_56, var_angular_momentum);
    // half_rotation = _exponential_increment(midpoint_angular_velocity, 0.5 * dt)            <L 132>
    var_60 = wp::mul(var_59, var_dt);
    var_61 = _exponential_increment_0(var_57, var_60);
    // midpoint_angular_velocity = (                                                          <L 133>
    // half_rotation                                                                          <L 134>
    // * inverse_inertia                                                                      <L 135>
    var_62 = wp::mul(var_61, var_0);
    // * wp.transpose(half_rotation)                                                          <L 136>
    var_63 = wp::transpose(var_61);
    var_64 = wp::mul(var_62, var_63);
    // * angular_momentum                                                                     <L 137>
    var_65 = wp::mul(var_64, var_angular_momentum);
    // relative_rotation = _exponential_increment(midpoint_angular_velocity, dt)              <L 140>
    var_66 = _exponential_increment_0(var_65, var_dt);
    // next_angular_momentum = wp.transpose(relative_rotation) * angular_momentum             <L 141>
    var_67 = wp::transpose(var_66);
    var_68 = wp::mul(var_67, var_angular_momentum);
    // return next_angular_momentum, relative_rotation                                        <L 142>
    ret_0 = var_68;
    ret_1 = var_66;
    goto label0;
    //---------
    // reverse
    label0:;
    adj_66 += adj_ret_1;
    adj_68 += adj_ret_0;
    // adj: return next_angular_momentum, relative_rotation                                   <L 142>
    wp::adj_mul(var_67, var_angular_momentum, adj_67, adj_angular_momentum, adj_68);
    wp::adj_transpose(var_66, adj_66, adj_67);
    // adj: next_angular_momentum = wp.transpose(relative_rotation) * angular_momentum        <L 141>
    adj__exponential_increment_0(var_65, var_dt, adj_65, adj_dt, adj_66);
    // adj: relative_rotation = _exponential_increment(midpoint_angular_velocity, dt)         <L 140>
    wp::adj_mul(var_64, var_angular_momentum, adj_64, adj_angular_momentum, adj_65);
    // adj: * angular_momentum                                                                <L 137>
    wp::adj_mul(var_62, var_63, adj_62, adj_63, adj_64);
    wp::adj_transpose(var_61, adj_61, adj_63);
    // adj: * wp.transpose(half_rotation)                                                     <L 136>
    wp::adj_mul(var_61, var_0, adj_61, adj_0, adj_62);
    // adj: * inverse_inertia                                                                 <L 135>
    // adj: half_rotation                                                                     <L 134>
    // adj: midpoint_angular_velocity = (                                                     <L 133>
    adj__exponential_increment_0(var_57, var_60, adj_57, adj_60, adj_61);
    wp::adj_mul(var_59, var_dt, adj_59, adj_dt, adj_60);
    // adj: half_rotation = _exponential_increment(midpoint_angular_velocity, 0.5 * dt)       <L 132>
    wp::adj_mul(var_56, var_angular_momentum, adj_56, adj_angular_momentum, adj_57);
    // adj: * angular_momentum                                                                <L 137>
    wp::adj_mul(var_54, var_55, adj_54, adj_55, adj_56);
    wp::adj_transpose(var_53, adj_53, adj_55);
    // adj: * wp.transpose(half_rotation)                                                     <L 136>
    wp::adj_mul(var_53, var_0, adj_53, adj_0, adj_54);
    // adj: * inverse_inertia                                                                 <L 135>
    // adj: half_rotation                                                                     <L 134>
    // adj: midpoint_angular_velocity = (                                                     <L 133>
    adj__exponential_increment_0(var_49, var_52, adj_49, adj_52, adj_53);
    wp::adj_mul(var_51, var_dt, adj_51, adj_dt, adj_52);
    // adj: half_rotation = _exponential_increment(midpoint_angular_velocity, 0.5 * dt)       <L 132>
    wp::adj_mul(var_48, var_angular_momentum, adj_48, adj_angular_momentum, adj_49);
    // adj: * angular_momentum                                                                <L 137>
    wp::adj_mul(var_46, var_47, adj_46, adj_47, adj_48);
    wp::adj_transpose(var_45, adj_45, adj_47);
    // adj: * wp.transpose(half_rotation)                                                     <L 136>
    wp::adj_mul(var_45, var_0, adj_45, adj_0, adj_46);
    // adj: * inverse_inertia                                                                 <L 135>
    // adj: half_rotation                                                                     <L 134>
    // adj: midpoint_angular_velocity = (                                                     <L 133>
    adj__exponential_increment_0(var_41, var_44, adj_41, adj_44, adj_45);
    wp::adj_mul(var_43, var_dt, adj_43, adj_dt, adj_44);
    // adj: half_rotation = _exponential_increment(midpoint_angular_velocity, 0.5 * dt)       <L 132>
    wp::adj_mul(var_40, var_angular_momentum, adj_40, adj_angular_momentum, adj_41);
    // adj: * angular_momentum                                                                <L 137>
    wp::adj_mul(var_38, var_39, adj_38, adj_39, adj_40);
    wp::adj_transpose(var_37, adj_37, adj_39);
    // adj: * wp.transpose(half_rotation)                                                     <L 136>
    wp::adj_mul(var_37, var_0, adj_37, adj_0, adj_38);
    // adj: * inverse_inertia                                                                 <L 135>
    // adj: half_rotation                                                                     <L 134>
    // adj: midpoint_angular_velocity = (                                                     <L 133>
    adj__exponential_increment_0(var_33, var_36, adj_33, adj_36, adj_37);
    wp::adj_mul(var_35, var_dt, adj_35, adj_dt, adj_36);
    // adj: half_rotation = _exponential_increment(midpoint_angular_velocity, 0.5 * dt)       <L 132>
    wp::adj_mul(var_32, var_angular_momentum, adj_32, adj_angular_momentum, adj_33);
    // adj: * angular_momentum                                                                <L 137>
    wp::adj_mul(var_30, var_31, adj_30, adj_31, adj_32);
    wp::adj_transpose(var_29, adj_29, adj_31);
    // adj: * wp.transpose(half_rotation)                                                     <L 136>
    wp::adj_mul(var_29, var_0, adj_29, adj_0, adj_30);
    // adj: * inverse_inertia                                                                 <L 135>
    // adj: half_rotation                                                                     <L 134>
    // adj: midpoint_angular_velocity = (                                                     <L 133>
    adj__exponential_increment_0(var_25, var_28, adj_25, adj_28, adj_29);
    wp::adj_mul(var_27, var_dt, adj_27, adj_dt, adj_28);
    // adj: half_rotation = _exponential_increment(midpoint_angular_velocity, 0.5 * dt)       <L 132>
    wp::adj_mul(var_24, var_angular_momentum, adj_24, adj_angular_momentum, adj_25);
    // adj: * angular_momentum                                                                <L 137>
    wp::adj_mul(var_22, var_23, adj_22, adj_23, adj_24);
    wp::adj_transpose(var_21, adj_21, adj_23);
    // adj: * wp.transpose(half_rotation)                                                     <L 136>
    wp::adj_mul(var_21, var_0, adj_21, adj_0, adj_22);
    // adj: * inverse_inertia                                                                 <L 135>
    // adj: half_rotation                                                                     <L 134>
    // adj: midpoint_angular_velocity = (                                                     <L 133>
    adj__exponential_increment_0(var_17, var_20, adj_17, adj_20, adj_21);
    wp::adj_mul(var_19, var_dt, adj_19, adj_dt, adj_20);
    // adj: half_rotation = _exponential_increment(midpoint_angular_velocity, 0.5 * dt)       <L 132>
    wp::adj_mul(var_16, var_angular_momentum, adj_16, adj_angular_momentum, adj_17);
    // adj: * angular_momentum                                                                <L 137>
    wp::adj_mul(var_14, var_15, adj_14, adj_15, adj_16);
    wp::adj_transpose(var_13, adj_13, adj_15);
    // adj: * wp.transpose(half_rotation)                                                     <L 136>
    wp::adj_mul(var_13, var_0, adj_13, adj_0, adj_14);
    // adj: * inverse_inertia                                                                 <L 135>
    // adj: half_rotation                                                                     <L 134>
    // adj: midpoint_angular_velocity = (                                                     <L 133>
    adj__exponential_increment_0(var_9, var_12, adj_9, adj_12, adj_13);
    wp::adj_mul(var_11, var_dt, adj_11, adj_dt, adj_12);
    // adj: half_rotation = _exponential_increment(midpoint_angular_velocity, 0.5 * dt)       <L 132>
    wp::adj_mul(var_8, var_angular_momentum, adj_8, adj_angular_momentum, adj_9);
    // adj: * angular_momentum                                                                <L 137>
    wp::adj_mul(var_6, var_7, adj_6, adj_7, adj_8);
    wp::adj_transpose(var_5, adj_5, adj_7);
    // adj: * wp.transpose(half_rotation)                                                     <L 136>
    wp::adj_mul(var_5, var_0, adj_5, adj_0, adj_6);
    // adj: * inverse_inertia                                                                 <L 135>
    // adj: half_rotation                                                                     <L 134>
    // adj: midpoint_angular_velocity = (                                                     <L 133>
    adj__exponential_increment_0(var_1, var_4, adj_1, adj_4, adj_5);
    wp::adj_mul(var_3, var_dt, adj_3, adj_dt, adj_4);
    // adj: half_rotation = _exponential_increment(midpoint_angular_velocity, 0.5 * dt)       <L 132>
    // adj: for _ in range(8):                                                                <L 131>
    wp::adj_mul(var_0, var_angular_momentum, adj_0, adj_angular_momentum, adj_1);
    // adj: midpoint_angular_velocity = inverse_inertia * angular_momentum                    <L 129>
    wp::adj_inverse(var_inertia, var_0, adj_inertia, adj_0);
    // adj: inverse_inertia = wp.inverse(inertia)                                             <L 128>
    // adj: def integrate_lie_group_midpoint(                                                 <L 122>
    return;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:145
static CUDA_CALLABLE void adj_solve_energy_momentum_midpoint_0(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::vec_t<3, wp::float32> var_angular_momentum,
    wp::float32 var_dt,
    wp::vec_t<3, wp::float32> & ret_0,
    wp::vec_t<3, wp::float32> & ret_1,
    wp::vec_t<3, wp::float32> & ret_2,
    wp::mat_t<3, 3, wp::float32> & adj_inertia,
    wp::vec_t<3, wp::float32> & adj_angular_momentum,
    wp::float32 & adj_dt,
    wp::vec_t<3, wp::float32> & adj_ret_0,
    wp::vec_t<3, wp::float32> & adj_ret_1,
    wp::vec_t<3, wp::float32> & adj_ret_2)
{
    //---------
    // primal vars
    wp::mat_t<3, 3, wp::float32> var_0;
    wp::vec_t<3, wp::float32> var_1;
    wp::vec_t<3, wp::float32> var_2;
    wp::vec_t<3, wp::float32> var_3;
    wp::vec_t<3, wp::float32> var_4;
    const wp::int32 var_5 = 0;
    const wp::float32 var_6 = 0.5;
    wp::vec_t<3, wp::float32> var_7;
    wp::vec_t<3, wp::float32> var_8;
    wp::vec_t<3, wp::float32> var_9;
    wp::vec_t<3, wp::float32> var_10;
    wp::vec_t<3, wp::float32> var_11;
    wp::vec_t<3, wp::float32> var_12;
    wp::vec_t<3, wp::float32> var_13;
    const wp::int32 var_14 = 3;
    wp::mat_t<3, 3, wp::float32> var_15;
    const wp::float32 var_16 = 0.5;
    wp::float32 var_17;
    wp::mat_t<3, 3, wp::float32> var_18;
    wp::mat_t<3, 3, wp::float32> var_19;
    wp::mat_t<3, 3, wp::float32> var_20;
    const wp::float32 var_21 = 0.5;
    wp::float32 var_22;
    wp::mat_t<3, 3, wp::float32> var_23;
    wp::mat_t<3, 3, wp::float32> var_24;
    wp::mat_t<3, 3, wp::float32> var_25;
    wp::mat_t<3, 3, wp::float32> var_26;
    wp::mat_t<3, 3, wp::float32> var_27;
    wp::vec_t<3, wp::float32> var_28;
    wp::vec_t<3, wp::float32> var_29;
    const wp::int32 var_30 = 1;
    const wp::float32 var_31 = 0.5;
    wp::vec_t<3, wp::float32> var_32;
    wp::vec_t<3, wp::float32> var_33;
    wp::vec_t<3, wp::float32> var_34;
    wp::vec_t<3, wp::float32> var_35;
    wp::vec_t<3, wp::float32> var_36;
    wp::vec_t<3, wp::float32> var_37;
    wp::vec_t<3, wp::float32> var_38;
    const wp::int32 var_39 = 3;
    wp::mat_t<3, 3, wp::float32> var_40;
    const wp::float32 var_41 = 0.5;
    wp::float32 var_42;
    wp::mat_t<3, 3, wp::float32> var_43;
    wp::mat_t<3, 3, wp::float32> var_44;
    wp::mat_t<3, 3, wp::float32> var_45;
    const wp::float32 var_46 = 0.5;
    wp::float32 var_47;
    wp::mat_t<3, 3, wp::float32> var_48;
    wp::mat_t<3, 3, wp::float32> var_49;
    wp::mat_t<3, 3, wp::float32> var_50;
    wp::mat_t<3, 3, wp::float32> var_51;
    wp::mat_t<3, 3, wp::float32> var_52;
    wp::vec_t<3, wp::float32> var_53;
    wp::vec_t<3, wp::float32> var_54;
    const wp::int32 var_55 = 2;
    const wp::float32 var_56 = 0.5;
    wp::vec_t<3, wp::float32> var_57;
    wp::vec_t<3, wp::float32> var_58;
    wp::vec_t<3, wp::float32> var_59;
    wp::vec_t<3, wp::float32> var_60;
    wp::vec_t<3, wp::float32> var_61;
    wp::vec_t<3, wp::float32> var_62;
    wp::vec_t<3, wp::float32> var_63;
    const wp::int32 var_64 = 3;
    wp::mat_t<3, 3, wp::float32> var_65;
    const wp::float32 var_66 = 0.5;
    wp::float32 var_67;
    wp::mat_t<3, 3, wp::float32> var_68;
    wp::mat_t<3, 3, wp::float32> var_69;
    wp::mat_t<3, 3, wp::float32> var_70;
    const wp::float32 var_71 = 0.5;
    wp::float32 var_72;
    wp::mat_t<3, 3, wp::float32> var_73;
    wp::mat_t<3, 3, wp::float32> var_74;
    wp::mat_t<3, 3, wp::float32> var_75;
    wp::mat_t<3, 3, wp::float32> var_76;
    wp::mat_t<3, 3, wp::float32> var_77;
    wp::vec_t<3, wp::float32> var_78;
    wp::vec_t<3, wp::float32> var_79;
    const wp::int32 var_80 = 3;
    const wp::float32 var_81 = 0.5;
    wp::vec_t<3, wp::float32> var_82;
    wp::vec_t<3, wp::float32> var_83;
    wp::vec_t<3, wp::float32> var_84;
    wp::vec_t<3, wp::float32> var_85;
    wp::vec_t<3, wp::float32> var_86;
    wp::vec_t<3, wp::float32> var_87;
    wp::vec_t<3, wp::float32> var_88;
    const wp::int32 var_89 = 3;
    wp::mat_t<3, 3, wp::float32> var_90;
    const wp::float32 var_91 = 0.5;
    wp::float32 var_92;
    wp::mat_t<3, 3, wp::float32> var_93;
    wp::mat_t<3, 3, wp::float32> var_94;
    wp::mat_t<3, 3, wp::float32> var_95;
    const wp::float32 var_96 = 0.5;
    wp::float32 var_97;
    wp::mat_t<3, 3, wp::float32> var_98;
    wp::mat_t<3, 3, wp::float32> var_99;
    wp::mat_t<3, 3, wp::float32> var_100;
    wp::mat_t<3, 3, wp::float32> var_101;
    wp::mat_t<3, 3, wp::float32> var_102;
    wp::vec_t<3, wp::float32> var_103;
    wp::vec_t<3, wp::float32> var_104;
    const wp::int32 var_105 = 4;
    const wp::float32 var_106 = 0.5;
    wp::vec_t<3, wp::float32> var_107;
    wp::vec_t<3, wp::float32> var_108;
    wp::vec_t<3, wp::float32> var_109;
    wp::vec_t<3, wp::float32> var_110;
    wp::vec_t<3, wp::float32> var_111;
    wp::vec_t<3, wp::float32> var_112;
    wp::vec_t<3, wp::float32> var_113;
    const wp::int32 var_114 = 3;
    wp::mat_t<3, 3, wp::float32> var_115;
    const wp::float32 var_116 = 0.5;
    wp::float32 var_117;
    wp::mat_t<3, 3, wp::float32> var_118;
    wp::mat_t<3, 3, wp::float32> var_119;
    wp::mat_t<3, 3, wp::float32> var_120;
    const wp::float32 var_121 = 0.5;
    wp::float32 var_122;
    wp::mat_t<3, 3, wp::float32> var_123;
    wp::mat_t<3, 3, wp::float32> var_124;
    wp::mat_t<3, 3, wp::float32> var_125;
    wp::mat_t<3, 3, wp::float32> var_126;
    wp::mat_t<3, 3, wp::float32> var_127;
    wp::vec_t<3, wp::float32> var_128;
    wp::vec_t<3, wp::float32> var_129;
    const wp::int32 var_130 = 5;
    const wp::float32 var_131 = 0.5;
    wp::vec_t<3, wp::float32> var_132;
    wp::vec_t<3, wp::float32> var_133;
    wp::vec_t<3, wp::float32> var_134;
    wp::vec_t<3, wp::float32> var_135;
    wp::vec_t<3, wp::float32> var_136;
    wp::vec_t<3, wp::float32> var_137;
    wp::vec_t<3, wp::float32> var_138;
    const wp::int32 var_139 = 3;
    wp::mat_t<3, 3, wp::float32> var_140;
    const wp::float32 var_141 = 0.5;
    wp::float32 var_142;
    wp::mat_t<3, 3, wp::float32> var_143;
    wp::mat_t<3, 3, wp::float32> var_144;
    wp::mat_t<3, 3, wp::float32> var_145;
    const wp::float32 var_146 = 0.5;
    wp::float32 var_147;
    wp::mat_t<3, 3, wp::float32> var_148;
    wp::mat_t<3, 3, wp::float32> var_149;
    wp::mat_t<3, 3, wp::float32> var_150;
    wp::mat_t<3, 3, wp::float32> var_151;
    wp::mat_t<3, 3, wp::float32> var_152;
    wp::vec_t<3, wp::float32> var_153;
    wp::vec_t<3, wp::float32> var_154;
    const wp::int32 var_155 = 6;
    const wp::float32 var_156 = 0.5;
    wp::vec_t<3, wp::float32> var_157;
    wp::vec_t<3, wp::float32> var_158;
    wp::vec_t<3, wp::float32> var_159;
    wp::vec_t<3, wp::float32> var_160;
    wp::vec_t<3, wp::float32> var_161;
    wp::vec_t<3, wp::float32> var_162;
    wp::vec_t<3, wp::float32> var_163;
    const wp::int32 var_164 = 3;
    wp::mat_t<3, 3, wp::float32> var_165;
    const wp::float32 var_166 = 0.5;
    wp::float32 var_167;
    wp::mat_t<3, 3, wp::float32> var_168;
    wp::mat_t<3, 3, wp::float32> var_169;
    wp::mat_t<3, 3, wp::float32> var_170;
    const wp::float32 var_171 = 0.5;
    wp::float32 var_172;
    wp::mat_t<3, 3, wp::float32> var_173;
    wp::mat_t<3, 3, wp::float32> var_174;
    wp::mat_t<3, 3, wp::float32> var_175;
    wp::mat_t<3, 3, wp::float32> var_176;
    wp::mat_t<3, 3, wp::float32> var_177;
    wp::vec_t<3, wp::float32> var_178;
    wp::vec_t<3, wp::float32> var_179;
    const wp::int32 var_180 = 7;
    const wp::float32 var_181 = 0.5;
    wp::vec_t<3, wp::float32> var_182;
    wp::vec_t<3, wp::float32> var_183;
    wp::vec_t<3, wp::float32> var_184;
    wp::vec_t<3, wp::float32> var_185;
    wp::vec_t<3, wp::float32> var_186;
    wp::vec_t<3, wp::float32> var_187;
    wp::vec_t<3, wp::float32> var_188;
    const wp::int32 var_189 = 3;
    wp::mat_t<3, 3, wp::float32> var_190;
    const wp::float32 var_191 = 0.5;
    wp::float32 var_192;
    wp::mat_t<3, 3, wp::float32> var_193;
    wp::mat_t<3, 3, wp::float32> var_194;
    wp::mat_t<3, 3, wp::float32> var_195;
    const wp::float32 var_196 = 0.5;
    wp::float32 var_197;
    wp::mat_t<3, 3, wp::float32> var_198;
    wp::mat_t<3, 3, wp::float32> var_199;
    wp::mat_t<3, 3, wp::float32> var_200;
    wp::mat_t<3, 3, wp::float32> var_201;
    wp::mat_t<3, 3, wp::float32> var_202;
    wp::vec_t<3, wp::float32> var_203;
    wp::vec_t<3, wp::float32> var_204;
    const wp::float32 var_205 = 0.5;
    wp::vec_t<3, wp::float32> var_206;
    wp::vec_t<3, wp::float32> var_207;
    wp::vec_t<3, wp::float32> var_208;
    //---------
    // dual vars
    wp::mat_t<3, 3, wp::float32> adj_0 = {};
    wp::vec_t<3, wp::float32> adj_1 = {};
    wp::vec_t<3, wp::float32> adj_2 = {};
    wp::vec_t<3, wp::float32> adj_3 = {};
    wp::vec_t<3, wp::float32> adj_4 = {};
    wp::int32 adj_5 = {};
    wp::float32 adj_6 = {};
    wp::vec_t<3, wp::float32> adj_7 = {};
    wp::vec_t<3, wp::float32> adj_8 = {};
    wp::vec_t<3, wp::float32> adj_9 = {};
    wp::vec_t<3, wp::float32> adj_10 = {};
    wp::vec_t<3, wp::float32> adj_11 = {};
    wp::vec_t<3, wp::float32> adj_12 = {};
    wp::vec_t<3, wp::float32> adj_13 = {};
    wp::int32 adj_14 = {};
    wp::mat_t<3, 3, wp::float32> adj_15 = {};
    wp::float32 adj_16 = {};
    wp::float32 adj_17 = {};
    wp::mat_t<3, 3, wp::float32> adj_18 = {};
    wp::mat_t<3, 3, wp::float32> adj_19 = {};
    wp::mat_t<3, 3, wp::float32> adj_20 = {};
    wp::float32 adj_21 = {};
    wp::float32 adj_22 = {};
    wp::mat_t<3, 3, wp::float32> adj_23 = {};
    wp::mat_t<3, 3, wp::float32> adj_24 = {};
    wp::mat_t<3, 3, wp::float32> adj_25 = {};
    wp::mat_t<3, 3, wp::float32> adj_26 = {};
    wp::mat_t<3, 3, wp::float32> adj_27 = {};
    wp::vec_t<3, wp::float32> adj_28 = {};
    wp::vec_t<3, wp::float32> adj_29 = {};
    wp::int32 adj_30 = {};
    wp::float32 adj_31 = {};
    wp::vec_t<3, wp::float32> adj_32 = {};
    wp::vec_t<3, wp::float32> adj_33 = {};
    wp::vec_t<3, wp::float32> adj_34 = {};
    wp::vec_t<3, wp::float32> adj_35 = {};
    wp::vec_t<3, wp::float32> adj_36 = {};
    wp::vec_t<3, wp::float32> adj_37 = {};
    wp::vec_t<3, wp::float32> adj_38 = {};
    wp::int32 adj_39 = {};
    wp::mat_t<3, 3, wp::float32> adj_40 = {};
    wp::float32 adj_41 = {};
    wp::float32 adj_42 = {};
    wp::mat_t<3, 3, wp::float32> adj_43 = {};
    wp::mat_t<3, 3, wp::float32> adj_44 = {};
    wp::mat_t<3, 3, wp::float32> adj_45 = {};
    wp::float32 adj_46 = {};
    wp::float32 adj_47 = {};
    wp::mat_t<3, 3, wp::float32> adj_48 = {};
    wp::mat_t<3, 3, wp::float32> adj_49 = {};
    wp::mat_t<3, 3, wp::float32> adj_50 = {};
    wp::mat_t<3, 3, wp::float32> adj_51 = {};
    wp::mat_t<3, 3, wp::float32> adj_52 = {};
    wp::vec_t<3, wp::float32> adj_53 = {};
    wp::vec_t<3, wp::float32> adj_54 = {};
    wp::int32 adj_55 = {};
    wp::float32 adj_56 = {};
    wp::vec_t<3, wp::float32> adj_57 = {};
    wp::vec_t<3, wp::float32> adj_58 = {};
    wp::vec_t<3, wp::float32> adj_59 = {};
    wp::vec_t<3, wp::float32> adj_60 = {};
    wp::vec_t<3, wp::float32> adj_61 = {};
    wp::vec_t<3, wp::float32> adj_62 = {};
    wp::vec_t<3, wp::float32> adj_63 = {};
    wp::int32 adj_64 = {};
    wp::mat_t<3, 3, wp::float32> adj_65 = {};
    wp::float32 adj_66 = {};
    wp::float32 adj_67 = {};
    wp::mat_t<3, 3, wp::float32> adj_68 = {};
    wp::mat_t<3, 3, wp::float32> adj_69 = {};
    wp::mat_t<3, 3, wp::float32> adj_70 = {};
    wp::float32 adj_71 = {};
    wp::float32 adj_72 = {};
    wp::mat_t<3, 3, wp::float32> adj_73 = {};
    wp::mat_t<3, 3, wp::float32> adj_74 = {};
    wp::mat_t<3, 3, wp::float32> adj_75 = {};
    wp::mat_t<3, 3, wp::float32> adj_76 = {};
    wp::mat_t<3, 3, wp::float32> adj_77 = {};
    wp::vec_t<3, wp::float32> adj_78 = {};
    wp::vec_t<3, wp::float32> adj_79 = {};
    wp::int32 adj_80 = {};
    wp::float32 adj_81 = {};
    wp::vec_t<3, wp::float32> adj_82 = {};
    wp::vec_t<3, wp::float32> adj_83 = {};
    wp::vec_t<3, wp::float32> adj_84 = {};
    wp::vec_t<3, wp::float32> adj_85 = {};
    wp::vec_t<3, wp::float32> adj_86 = {};
    wp::vec_t<3, wp::float32> adj_87 = {};
    wp::vec_t<3, wp::float32> adj_88 = {};
    wp::int32 adj_89 = {};
    wp::mat_t<3, 3, wp::float32> adj_90 = {};
    wp::float32 adj_91 = {};
    wp::float32 adj_92 = {};
    wp::mat_t<3, 3, wp::float32> adj_93 = {};
    wp::mat_t<3, 3, wp::float32> adj_94 = {};
    wp::mat_t<3, 3, wp::float32> adj_95 = {};
    wp::float32 adj_96 = {};
    wp::float32 adj_97 = {};
    wp::mat_t<3, 3, wp::float32> adj_98 = {};
    wp::mat_t<3, 3, wp::float32> adj_99 = {};
    wp::mat_t<3, 3, wp::float32> adj_100 = {};
    wp::mat_t<3, 3, wp::float32> adj_101 = {};
    wp::mat_t<3, 3, wp::float32> adj_102 = {};
    wp::vec_t<3, wp::float32> adj_103 = {};
    wp::vec_t<3, wp::float32> adj_104 = {};
    wp::int32 adj_105 = {};
    wp::float32 adj_106 = {};
    wp::vec_t<3, wp::float32> adj_107 = {};
    wp::vec_t<3, wp::float32> adj_108 = {};
    wp::vec_t<3, wp::float32> adj_109 = {};
    wp::vec_t<3, wp::float32> adj_110 = {};
    wp::vec_t<3, wp::float32> adj_111 = {};
    wp::vec_t<3, wp::float32> adj_112 = {};
    wp::vec_t<3, wp::float32> adj_113 = {};
    wp::int32 adj_114 = {};
    wp::mat_t<3, 3, wp::float32> adj_115 = {};
    wp::float32 adj_116 = {};
    wp::float32 adj_117 = {};
    wp::mat_t<3, 3, wp::float32> adj_118 = {};
    wp::mat_t<3, 3, wp::float32> adj_119 = {};
    wp::mat_t<3, 3, wp::float32> adj_120 = {};
    wp::float32 adj_121 = {};
    wp::float32 adj_122 = {};
    wp::mat_t<3, 3, wp::float32> adj_123 = {};
    wp::mat_t<3, 3, wp::float32> adj_124 = {};
    wp::mat_t<3, 3, wp::float32> adj_125 = {};
    wp::mat_t<3, 3, wp::float32> adj_126 = {};
    wp::mat_t<3, 3, wp::float32> adj_127 = {};
    wp::vec_t<3, wp::float32> adj_128 = {};
    wp::vec_t<3, wp::float32> adj_129 = {};
    wp::int32 adj_130 = {};
    wp::float32 adj_131 = {};
    wp::vec_t<3, wp::float32> adj_132 = {};
    wp::vec_t<3, wp::float32> adj_133 = {};
    wp::vec_t<3, wp::float32> adj_134 = {};
    wp::vec_t<3, wp::float32> adj_135 = {};
    wp::vec_t<3, wp::float32> adj_136 = {};
    wp::vec_t<3, wp::float32> adj_137 = {};
    wp::vec_t<3, wp::float32> adj_138 = {};
    wp::int32 adj_139 = {};
    wp::mat_t<3, 3, wp::float32> adj_140 = {};
    wp::float32 adj_141 = {};
    wp::float32 adj_142 = {};
    wp::mat_t<3, 3, wp::float32> adj_143 = {};
    wp::mat_t<3, 3, wp::float32> adj_144 = {};
    wp::mat_t<3, 3, wp::float32> adj_145 = {};
    wp::float32 adj_146 = {};
    wp::float32 adj_147 = {};
    wp::mat_t<3, 3, wp::float32> adj_148 = {};
    wp::mat_t<3, 3, wp::float32> adj_149 = {};
    wp::mat_t<3, 3, wp::float32> adj_150 = {};
    wp::mat_t<3, 3, wp::float32> adj_151 = {};
    wp::mat_t<3, 3, wp::float32> adj_152 = {};
    wp::vec_t<3, wp::float32> adj_153 = {};
    wp::vec_t<3, wp::float32> adj_154 = {};
    wp::int32 adj_155 = {};
    wp::float32 adj_156 = {};
    wp::vec_t<3, wp::float32> adj_157 = {};
    wp::vec_t<3, wp::float32> adj_158 = {};
    wp::vec_t<3, wp::float32> adj_159 = {};
    wp::vec_t<3, wp::float32> adj_160 = {};
    wp::vec_t<3, wp::float32> adj_161 = {};
    wp::vec_t<3, wp::float32> adj_162 = {};
    wp::vec_t<3, wp::float32> adj_163 = {};
    wp::int32 adj_164 = {};
    wp::mat_t<3, 3, wp::float32> adj_165 = {};
    wp::float32 adj_166 = {};
    wp::float32 adj_167 = {};
    wp::mat_t<3, 3, wp::float32> adj_168 = {};
    wp::mat_t<3, 3, wp::float32> adj_169 = {};
    wp::mat_t<3, 3, wp::float32> adj_170 = {};
    wp::float32 adj_171 = {};
    wp::float32 adj_172 = {};
    wp::mat_t<3, 3, wp::float32> adj_173 = {};
    wp::mat_t<3, 3, wp::float32> adj_174 = {};
    wp::mat_t<3, 3, wp::float32> adj_175 = {};
    wp::mat_t<3, 3, wp::float32> adj_176 = {};
    wp::mat_t<3, 3, wp::float32> adj_177 = {};
    wp::vec_t<3, wp::float32> adj_178 = {};
    wp::vec_t<3, wp::float32> adj_179 = {};
    wp::int32 adj_180 = {};
    wp::float32 adj_181 = {};
    wp::vec_t<3, wp::float32> adj_182 = {};
    wp::vec_t<3, wp::float32> adj_183 = {};
    wp::vec_t<3, wp::float32> adj_184 = {};
    wp::vec_t<3, wp::float32> adj_185 = {};
    wp::vec_t<3, wp::float32> adj_186 = {};
    wp::vec_t<3, wp::float32> adj_187 = {};
    wp::vec_t<3, wp::float32> adj_188 = {};
    wp::int32 adj_189 = {};
    wp::mat_t<3, 3, wp::float32> adj_190 = {};
    wp::float32 adj_191 = {};
    wp::float32 adj_192 = {};
    wp::mat_t<3, 3, wp::float32> adj_193 = {};
    wp::mat_t<3, 3, wp::float32> adj_194 = {};
    wp::mat_t<3, 3, wp::float32> adj_195 = {};
    wp::float32 adj_196 = {};
    wp::float32 adj_197 = {};
    wp::mat_t<3, 3, wp::float32> adj_198 = {};
    wp::mat_t<3, 3, wp::float32> adj_199 = {};
    wp::mat_t<3, 3, wp::float32> adj_200 = {};
    wp::mat_t<3, 3, wp::float32> adj_201 = {};
    wp::mat_t<3, 3, wp::float32> adj_202 = {};
    wp::vec_t<3, wp::float32> adj_203 = {};
    wp::vec_t<3, wp::float32> adj_204 = {};
    wp::float32 adj_205 = {};
    wp::vec_t<3, wp::float32> adj_206 = {};
    wp::vec_t<3, wp::float32> adj_207 = {};
    wp::vec_t<3, wp::float32> adj_208 = {};
    //---------
    // forward
    // def solve_energy_momentum_midpoint(                                                    <L 146>
    // inverse_inertia = wp.inverse(inertia)                                                  <L 152>
    var_0 = wp::inverse(var_inertia);
    // next_angular_momentum = angular_momentum + dt * wp.cross(                              <L 153>
    // angular_momentum,                                                                      <L 154>
    // inverse_inertia * angular_momentum,                                                    <L 155>
    var_1 = wp::mul(var_0, var_angular_momentum);
    var_2 = wp::cross(var_angular_momentum, var_1);
    var_3 = wp::mul(var_dt, var_2);
    var_4 = wp::add(var_angular_momentum, var_3);
    // for _ in range(8):                                                                     <L 158>
    // midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)           <L 159>
    var_7 = wp::add(var_angular_momentum, var_4);
    var_8 = wp::mul(var_6, var_7);
    // midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum                <L 160>
    var_9 = wp::mul(var_0, var_8);
    // residual = (                                                                           <L 161>
    // next_angular_momentum                                                                  <L 162>
    // - angular_momentum                                                                     <L 163>
    var_10 = wp::sub(var_4, var_angular_momentum);
    // - dt * wp.cross(midpoint_angular_momentum, midpoint_angular_velocity)                  <L 164>
    var_11 = wp::cross(var_8, var_9);
    var_12 = wp::mul(var_dt, var_11);
    var_13 = wp::sub(var_10, var_12);
    // jacobian = (                                                                           <L 166>
    // wp.identity(3, dtype=float)                                                            <L 167>
    var_15 = wp::identity<3, wp::float32>();
    // + 0.5 * dt * wp.skew(midpoint_angular_velocity)                                        <L 168>
    var_17 = wp::mul(var_16, var_dt);
    var_18 = wp::skew(var_9);
    var_19 = wp::mul(var_17, var_18);
    var_20 = wp::add(var_15, var_19);
    // - 0.5 * dt * wp.skew(midpoint_angular_momentum) * inverse_inertia                      <L 169>
    var_22 = wp::mul(var_21, var_dt);
    var_23 = wp::skew(var_8);
    var_24 = wp::mul(var_22, var_23);
    var_25 = wp::mul(var_24, var_0);
    var_26 = wp::sub(var_20, var_25);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 171>
    var_27 = wp::inverse(var_26);
    var_28 = wp::mul(var_27, var_13);
    var_29 = wp::sub(var_4, var_28);
    // midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)           <L 159>
    var_32 = wp::add(var_angular_momentum, var_29);
    var_33 = wp::mul(var_31, var_32);
    // midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum                <L 160>
    var_34 = wp::mul(var_0, var_33);
    // residual = (                                                                           <L 161>
    // next_angular_momentum                                                                  <L 162>
    // - angular_momentum                                                                     <L 163>
    var_35 = wp::sub(var_29, var_angular_momentum);
    // - dt * wp.cross(midpoint_angular_momentum, midpoint_angular_velocity)                  <L 164>
    var_36 = wp::cross(var_33, var_34);
    var_37 = wp::mul(var_dt, var_36);
    var_38 = wp::sub(var_35, var_37);
    // jacobian = (                                                                           <L 166>
    // wp.identity(3, dtype=float)                                                            <L 167>
    var_40 = wp::identity<3, wp::float32>();
    // + 0.5 * dt * wp.skew(midpoint_angular_velocity)                                        <L 168>
    var_42 = wp::mul(var_41, var_dt);
    var_43 = wp::skew(var_34);
    var_44 = wp::mul(var_42, var_43);
    var_45 = wp::add(var_40, var_44);
    // - 0.5 * dt * wp.skew(midpoint_angular_momentum) * inverse_inertia                      <L 169>
    var_47 = wp::mul(var_46, var_dt);
    var_48 = wp::skew(var_33);
    var_49 = wp::mul(var_47, var_48);
    var_50 = wp::mul(var_49, var_0);
    var_51 = wp::sub(var_45, var_50);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 171>
    var_52 = wp::inverse(var_51);
    var_53 = wp::mul(var_52, var_38);
    var_54 = wp::sub(var_29, var_53);
    // midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)           <L 159>
    var_57 = wp::add(var_angular_momentum, var_54);
    var_58 = wp::mul(var_56, var_57);
    // midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum                <L 160>
    var_59 = wp::mul(var_0, var_58);
    // residual = (                                                                           <L 161>
    // next_angular_momentum                                                                  <L 162>
    // - angular_momentum                                                                     <L 163>
    var_60 = wp::sub(var_54, var_angular_momentum);
    // - dt * wp.cross(midpoint_angular_momentum, midpoint_angular_velocity)                  <L 164>
    var_61 = wp::cross(var_58, var_59);
    var_62 = wp::mul(var_dt, var_61);
    var_63 = wp::sub(var_60, var_62);
    // jacobian = (                                                                           <L 166>
    // wp.identity(3, dtype=float)                                                            <L 167>
    var_65 = wp::identity<3, wp::float32>();
    // + 0.5 * dt * wp.skew(midpoint_angular_velocity)                                        <L 168>
    var_67 = wp::mul(var_66, var_dt);
    var_68 = wp::skew(var_59);
    var_69 = wp::mul(var_67, var_68);
    var_70 = wp::add(var_65, var_69);
    // - 0.5 * dt * wp.skew(midpoint_angular_momentum) * inverse_inertia                      <L 169>
    var_72 = wp::mul(var_71, var_dt);
    var_73 = wp::skew(var_58);
    var_74 = wp::mul(var_72, var_73);
    var_75 = wp::mul(var_74, var_0);
    var_76 = wp::sub(var_70, var_75);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 171>
    var_77 = wp::inverse(var_76);
    var_78 = wp::mul(var_77, var_63);
    var_79 = wp::sub(var_54, var_78);
    // midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)           <L 159>
    var_82 = wp::add(var_angular_momentum, var_79);
    var_83 = wp::mul(var_81, var_82);
    // midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum                <L 160>
    var_84 = wp::mul(var_0, var_83);
    // residual = (                                                                           <L 161>
    // next_angular_momentum                                                                  <L 162>
    // - angular_momentum                                                                     <L 163>
    var_85 = wp::sub(var_79, var_angular_momentum);
    // - dt * wp.cross(midpoint_angular_momentum, midpoint_angular_velocity)                  <L 164>
    var_86 = wp::cross(var_83, var_84);
    var_87 = wp::mul(var_dt, var_86);
    var_88 = wp::sub(var_85, var_87);
    // jacobian = (                                                                           <L 166>
    // wp.identity(3, dtype=float)                                                            <L 167>
    var_90 = wp::identity<3, wp::float32>();
    // + 0.5 * dt * wp.skew(midpoint_angular_velocity)                                        <L 168>
    var_92 = wp::mul(var_91, var_dt);
    var_93 = wp::skew(var_84);
    var_94 = wp::mul(var_92, var_93);
    var_95 = wp::add(var_90, var_94);
    // - 0.5 * dt * wp.skew(midpoint_angular_momentum) * inverse_inertia                      <L 169>
    var_97 = wp::mul(var_96, var_dt);
    var_98 = wp::skew(var_83);
    var_99 = wp::mul(var_97, var_98);
    var_100 = wp::mul(var_99, var_0);
    var_101 = wp::sub(var_95, var_100);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 171>
    var_102 = wp::inverse(var_101);
    var_103 = wp::mul(var_102, var_88);
    var_104 = wp::sub(var_79, var_103);
    // midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)           <L 159>
    var_107 = wp::add(var_angular_momentum, var_104);
    var_108 = wp::mul(var_106, var_107);
    // midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum                <L 160>
    var_109 = wp::mul(var_0, var_108);
    // residual = (                                                                           <L 161>
    // next_angular_momentum                                                                  <L 162>
    // - angular_momentum                                                                     <L 163>
    var_110 = wp::sub(var_104, var_angular_momentum);
    // - dt * wp.cross(midpoint_angular_momentum, midpoint_angular_velocity)                  <L 164>
    var_111 = wp::cross(var_108, var_109);
    var_112 = wp::mul(var_dt, var_111);
    var_113 = wp::sub(var_110, var_112);
    // jacobian = (                                                                           <L 166>
    // wp.identity(3, dtype=float)                                                            <L 167>
    var_115 = wp::identity<3, wp::float32>();
    // + 0.5 * dt * wp.skew(midpoint_angular_velocity)                                        <L 168>
    var_117 = wp::mul(var_116, var_dt);
    var_118 = wp::skew(var_109);
    var_119 = wp::mul(var_117, var_118);
    var_120 = wp::add(var_115, var_119);
    // - 0.5 * dt * wp.skew(midpoint_angular_momentum) * inverse_inertia                      <L 169>
    var_122 = wp::mul(var_121, var_dt);
    var_123 = wp::skew(var_108);
    var_124 = wp::mul(var_122, var_123);
    var_125 = wp::mul(var_124, var_0);
    var_126 = wp::sub(var_120, var_125);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 171>
    var_127 = wp::inverse(var_126);
    var_128 = wp::mul(var_127, var_113);
    var_129 = wp::sub(var_104, var_128);
    // midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)           <L 159>
    var_132 = wp::add(var_angular_momentum, var_129);
    var_133 = wp::mul(var_131, var_132);
    // midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum                <L 160>
    var_134 = wp::mul(var_0, var_133);
    // residual = (                                                                           <L 161>
    // next_angular_momentum                                                                  <L 162>
    // - angular_momentum                                                                     <L 163>
    var_135 = wp::sub(var_129, var_angular_momentum);
    // - dt * wp.cross(midpoint_angular_momentum, midpoint_angular_velocity)                  <L 164>
    var_136 = wp::cross(var_133, var_134);
    var_137 = wp::mul(var_dt, var_136);
    var_138 = wp::sub(var_135, var_137);
    // jacobian = (                                                                           <L 166>
    // wp.identity(3, dtype=float)                                                            <L 167>
    var_140 = wp::identity<3, wp::float32>();
    // + 0.5 * dt * wp.skew(midpoint_angular_velocity)                                        <L 168>
    var_142 = wp::mul(var_141, var_dt);
    var_143 = wp::skew(var_134);
    var_144 = wp::mul(var_142, var_143);
    var_145 = wp::add(var_140, var_144);
    // - 0.5 * dt * wp.skew(midpoint_angular_momentum) * inverse_inertia                      <L 169>
    var_147 = wp::mul(var_146, var_dt);
    var_148 = wp::skew(var_133);
    var_149 = wp::mul(var_147, var_148);
    var_150 = wp::mul(var_149, var_0);
    var_151 = wp::sub(var_145, var_150);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 171>
    var_152 = wp::inverse(var_151);
    var_153 = wp::mul(var_152, var_138);
    var_154 = wp::sub(var_129, var_153);
    // midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)           <L 159>
    var_157 = wp::add(var_angular_momentum, var_154);
    var_158 = wp::mul(var_156, var_157);
    // midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum                <L 160>
    var_159 = wp::mul(var_0, var_158);
    // residual = (                                                                           <L 161>
    // next_angular_momentum                                                                  <L 162>
    // - angular_momentum                                                                     <L 163>
    var_160 = wp::sub(var_154, var_angular_momentum);
    // - dt * wp.cross(midpoint_angular_momentum, midpoint_angular_velocity)                  <L 164>
    var_161 = wp::cross(var_158, var_159);
    var_162 = wp::mul(var_dt, var_161);
    var_163 = wp::sub(var_160, var_162);
    // jacobian = (                                                                           <L 166>
    // wp.identity(3, dtype=float)                                                            <L 167>
    var_165 = wp::identity<3, wp::float32>();
    // + 0.5 * dt * wp.skew(midpoint_angular_velocity)                                        <L 168>
    var_167 = wp::mul(var_166, var_dt);
    var_168 = wp::skew(var_159);
    var_169 = wp::mul(var_167, var_168);
    var_170 = wp::add(var_165, var_169);
    // - 0.5 * dt * wp.skew(midpoint_angular_momentum) * inverse_inertia                      <L 169>
    var_172 = wp::mul(var_171, var_dt);
    var_173 = wp::skew(var_158);
    var_174 = wp::mul(var_172, var_173);
    var_175 = wp::mul(var_174, var_0);
    var_176 = wp::sub(var_170, var_175);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 171>
    var_177 = wp::inverse(var_176);
    var_178 = wp::mul(var_177, var_163);
    var_179 = wp::sub(var_154, var_178);
    // midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)           <L 159>
    var_182 = wp::add(var_angular_momentum, var_179);
    var_183 = wp::mul(var_181, var_182);
    // midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum                <L 160>
    var_184 = wp::mul(var_0, var_183);
    // residual = (                                                                           <L 161>
    // next_angular_momentum                                                                  <L 162>
    // - angular_momentum                                                                     <L 163>
    var_185 = wp::sub(var_179, var_angular_momentum);
    // - dt * wp.cross(midpoint_angular_momentum, midpoint_angular_velocity)                  <L 164>
    var_186 = wp::cross(var_183, var_184);
    var_187 = wp::mul(var_dt, var_186);
    var_188 = wp::sub(var_185, var_187);
    // jacobian = (                                                                           <L 166>
    // wp.identity(3, dtype=float)                                                            <L 167>
    var_190 = wp::identity<3, wp::float32>();
    // + 0.5 * dt * wp.skew(midpoint_angular_velocity)                                        <L 168>
    var_192 = wp::mul(var_191, var_dt);
    var_193 = wp::skew(var_184);
    var_194 = wp::mul(var_192, var_193);
    var_195 = wp::add(var_190, var_194);
    // - 0.5 * dt * wp.skew(midpoint_angular_momentum) * inverse_inertia                      <L 169>
    var_197 = wp::mul(var_196, var_dt);
    var_198 = wp::skew(var_183);
    var_199 = wp::mul(var_197, var_198);
    var_200 = wp::mul(var_199, var_0);
    var_201 = wp::sub(var_195, var_200);
    // next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual        <L 171>
    var_202 = wp::inverse(var_201);
    var_203 = wp::mul(var_202, var_188);
    var_204 = wp::sub(var_179, var_203);
    // midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)           <L 173>
    var_206 = wp::add(var_angular_momentum, var_204);
    var_207 = wp::mul(var_205, var_206);
    // midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum                <L 174>
    var_208 = wp::mul(var_0, var_207);
    // return (                                                                               <L 175>
    // next_angular_momentum,                                                                 <L 176>
    // midpoint_angular_momentum,                                                             <L 177>
    // midpoint_angular_velocity,                                                             <L 178>
    ret_0 = var_204;
    ret_1 = var_207;
    ret_2 = var_208;
    goto label0;
    //---------
    // reverse
    label0:;
    adj_208 += adj_ret_2;
    adj_207 += adj_ret_1;
    adj_204 += adj_ret_0;
    // adj: midpoint_angular_velocity,                                                        <L 178>
    // adj: midpoint_angular_momentum,                                                        <L 177>
    // adj: next_angular_momentum,                                                            <L 176>
    // adj: return (                                                                          <L 175>
    wp::adj_mul(var_0, var_207, adj_0, adj_207, adj_208);
    // adj: midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum           <L 174>
    wp::adj_mul(var_205, var_206, adj_205, adj_206, adj_207);
    wp::adj_add(var_angular_momentum, var_204, adj_angular_momentum, adj_204, adj_206);
    // adj: midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)      <L 173>
    wp::adj_sub(var_179, var_203, adj_179, adj_203, adj_204);
    wp::adj_mul(var_202, var_188, adj_202, adj_188, adj_203);
    wp::adj_inverse(var_201, var_202, adj_201, adj_202);
    // adj: next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual   <L 171>
    wp::adj_sub(var_195, var_200, adj_195, adj_200, adj_201);
    wp::adj_mul(var_199, var_0, adj_199, adj_0, adj_200);
    wp::adj_mul(var_197, var_198, adj_197, adj_198, adj_199);
    wp::adj_skew(var_183, adj_183, adj_198);
    wp::adj_mul(var_196, var_dt, adj_196, adj_dt, adj_197);
    // adj: - 0.5 * dt * wp.skew(midpoint_angular_momentum) * inverse_inertia                 <L 169>
    wp::adj_add(var_190, var_194, adj_190, adj_194, adj_195);
    wp::adj_mul(var_192, var_193, adj_192, adj_193, adj_194);
    wp::adj_skew(var_184, adj_184, adj_193);
    wp::adj_mul(var_191, var_dt, adj_191, adj_dt, adj_192);
    // adj: + 0.5 * dt * wp.skew(midpoint_angular_velocity)                                   <L 168>
    // adj: wp.identity(3, dtype=float)                                                       <L 167>
    // adj: jacobian = (                                                                      <L 166>
    wp::adj_sub(var_185, var_187, adj_185, adj_187, adj_188);
    wp::adj_mul(var_dt, var_186, adj_dt, adj_186, adj_187);
    wp::adj_cross(var_183, var_184, adj_183, adj_184, adj_186);
    // adj: - dt * wp.cross(midpoint_angular_momentum, midpoint_angular_velocity)             <L 164>
    wp::adj_sub(var_179, var_angular_momentum, adj_179, adj_angular_momentum, adj_185);
    // adj: - angular_momentum                                                                <L 163>
    // adj: next_angular_momentum                                                             <L 162>
    // adj: residual = (                                                                      <L 161>
    wp::adj_mul(var_0, var_183, adj_0, adj_183, adj_184);
    // adj: midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum           <L 160>
    wp::adj_mul(var_181, var_182, adj_181, adj_182, adj_183);
    wp::adj_add(var_angular_momentum, var_179, adj_angular_momentum, adj_179, adj_182);
    // adj: midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)      <L 159>
    wp::adj_sub(var_154, var_178, adj_154, adj_178, adj_179);
    wp::adj_mul(var_177, var_163, adj_177, adj_163, adj_178);
    wp::adj_inverse(var_176, var_177, adj_176, adj_177);
    // adj: next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual   <L 171>
    wp::adj_sub(var_170, var_175, adj_170, adj_175, adj_176);
    wp::adj_mul(var_174, var_0, adj_174, adj_0, adj_175);
    wp::adj_mul(var_172, var_173, adj_172, adj_173, adj_174);
    wp::adj_skew(var_158, adj_158, adj_173);
    wp::adj_mul(var_171, var_dt, adj_171, adj_dt, adj_172);
    // adj: - 0.5 * dt * wp.skew(midpoint_angular_momentum) * inverse_inertia                 <L 169>
    wp::adj_add(var_165, var_169, adj_165, adj_169, adj_170);
    wp::adj_mul(var_167, var_168, adj_167, adj_168, adj_169);
    wp::adj_skew(var_159, adj_159, adj_168);
    wp::adj_mul(var_166, var_dt, adj_166, adj_dt, adj_167);
    // adj: + 0.5 * dt * wp.skew(midpoint_angular_velocity)                                   <L 168>
    // adj: wp.identity(3, dtype=float)                                                       <L 167>
    // adj: jacobian = (                                                                      <L 166>
    wp::adj_sub(var_160, var_162, adj_160, adj_162, adj_163);
    wp::adj_mul(var_dt, var_161, adj_dt, adj_161, adj_162);
    wp::adj_cross(var_158, var_159, adj_158, adj_159, adj_161);
    // adj: - dt * wp.cross(midpoint_angular_momentum, midpoint_angular_velocity)             <L 164>
    wp::adj_sub(var_154, var_angular_momentum, adj_154, adj_angular_momentum, adj_160);
    // adj: - angular_momentum                                                                <L 163>
    // adj: next_angular_momentum                                                             <L 162>
    // adj: residual = (                                                                      <L 161>
    wp::adj_mul(var_0, var_158, adj_0, adj_158, adj_159);
    // adj: midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum           <L 160>
    wp::adj_mul(var_156, var_157, adj_156, adj_157, adj_158);
    wp::adj_add(var_angular_momentum, var_154, adj_angular_momentum, adj_154, adj_157);
    // adj: midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)      <L 159>
    wp::adj_sub(var_129, var_153, adj_129, adj_153, adj_154);
    wp::adj_mul(var_152, var_138, adj_152, adj_138, adj_153);
    wp::adj_inverse(var_151, var_152, adj_151, adj_152);
    // adj: next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual   <L 171>
    wp::adj_sub(var_145, var_150, adj_145, adj_150, adj_151);
    wp::adj_mul(var_149, var_0, adj_149, adj_0, adj_150);
    wp::adj_mul(var_147, var_148, adj_147, adj_148, adj_149);
    wp::adj_skew(var_133, adj_133, adj_148);
    wp::adj_mul(var_146, var_dt, adj_146, adj_dt, adj_147);
    // adj: - 0.5 * dt * wp.skew(midpoint_angular_momentum) * inverse_inertia                 <L 169>
    wp::adj_add(var_140, var_144, adj_140, adj_144, adj_145);
    wp::adj_mul(var_142, var_143, adj_142, adj_143, adj_144);
    wp::adj_skew(var_134, adj_134, adj_143);
    wp::adj_mul(var_141, var_dt, adj_141, adj_dt, adj_142);
    // adj: + 0.5 * dt * wp.skew(midpoint_angular_velocity)                                   <L 168>
    // adj: wp.identity(3, dtype=float)                                                       <L 167>
    // adj: jacobian = (                                                                      <L 166>
    wp::adj_sub(var_135, var_137, adj_135, adj_137, adj_138);
    wp::adj_mul(var_dt, var_136, adj_dt, adj_136, adj_137);
    wp::adj_cross(var_133, var_134, adj_133, adj_134, adj_136);
    // adj: - dt * wp.cross(midpoint_angular_momentum, midpoint_angular_velocity)             <L 164>
    wp::adj_sub(var_129, var_angular_momentum, adj_129, adj_angular_momentum, adj_135);
    // adj: - angular_momentum                                                                <L 163>
    // adj: next_angular_momentum                                                             <L 162>
    // adj: residual = (                                                                      <L 161>
    wp::adj_mul(var_0, var_133, adj_0, adj_133, adj_134);
    // adj: midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum           <L 160>
    wp::adj_mul(var_131, var_132, adj_131, adj_132, adj_133);
    wp::adj_add(var_angular_momentum, var_129, adj_angular_momentum, adj_129, adj_132);
    // adj: midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)      <L 159>
    wp::adj_sub(var_104, var_128, adj_104, adj_128, adj_129);
    wp::adj_mul(var_127, var_113, adj_127, adj_113, adj_128);
    wp::adj_inverse(var_126, var_127, adj_126, adj_127);
    // adj: next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual   <L 171>
    wp::adj_sub(var_120, var_125, adj_120, adj_125, adj_126);
    wp::adj_mul(var_124, var_0, adj_124, adj_0, adj_125);
    wp::adj_mul(var_122, var_123, adj_122, adj_123, adj_124);
    wp::adj_skew(var_108, adj_108, adj_123);
    wp::adj_mul(var_121, var_dt, adj_121, adj_dt, adj_122);
    // adj: - 0.5 * dt * wp.skew(midpoint_angular_momentum) * inverse_inertia                 <L 169>
    wp::adj_add(var_115, var_119, adj_115, adj_119, adj_120);
    wp::adj_mul(var_117, var_118, adj_117, adj_118, adj_119);
    wp::adj_skew(var_109, adj_109, adj_118);
    wp::adj_mul(var_116, var_dt, adj_116, adj_dt, adj_117);
    // adj: + 0.5 * dt * wp.skew(midpoint_angular_velocity)                                   <L 168>
    // adj: wp.identity(3, dtype=float)                                                       <L 167>
    // adj: jacobian = (                                                                      <L 166>
    wp::adj_sub(var_110, var_112, adj_110, adj_112, adj_113);
    wp::adj_mul(var_dt, var_111, adj_dt, adj_111, adj_112);
    wp::adj_cross(var_108, var_109, adj_108, adj_109, adj_111);
    // adj: - dt * wp.cross(midpoint_angular_momentum, midpoint_angular_velocity)             <L 164>
    wp::adj_sub(var_104, var_angular_momentum, adj_104, adj_angular_momentum, adj_110);
    // adj: - angular_momentum                                                                <L 163>
    // adj: next_angular_momentum                                                             <L 162>
    // adj: residual = (                                                                      <L 161>
    wp::adj_mul(var_0, var_108, adj_0, adj_108, adj_109);
    // adj: midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum           <L 160>
    wp::adj_mul(var_106, var_107, adj_106, adj_107, adj_108);
    wp::adj_add(var_angular_momentum, var_104, adj_angular_momentum, adj_104, adj_107);
    // adj: midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)      <L 159>
    wp::adj_sub(var_79, var_103, adj_79, adj_103, adj_104);
    wp::adj_mul(var_102, var_88, adj_102, adj_88, adj_103);
    wp::adj_inverse(var_101, var_102, adj_101, adj_102);
    // adj: next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual   <L 171>
    wp::adj_sub(var_95, var_100, adj_95, adj_100, adj_101);
    wp::adj_mul(var_99, var_0, adj_99, adj_0, adj_100);
    wp::adj_mul(var_97, var_98, adj_97, adj_98, adj_99);
    wp::adj_skew(var_83, adj_83, adj_98);
    wp::adj_mul(var_96, var_dt, adj_96, adj_dt, adj_97);
    // adj: - 0.5 * dt * wp.skew(midpoint_angular_momentum) * inverse_inertia                 <L 169>
    wp::adj_add(var_90, var_94, adj_90, adj_94, adj_95);
    wp::adj_mul(var_92, var_93, adj_92, adj_93, adj_94);
    wp::adj_skew(var_84, adj_84, adj_93);
    wp::adj_mul(var_91, var_dt, adj_91, adj_dt, adj_92);
    // adj: + 0.5 * dt * wp.skew(midpoint_angular_velocity)                                   <L 168>
    // adj: wp.identity(3, dtype=float)                                                       <L 167>
    // adj: jacobian = (                                                                      <L 166>
    wp::adj_sub(var_85, var_87, adj_85, adj_87, adj_88);
    wp::adj_mul(var_dt, var_86, adj_dt, adj_86, adj_87);
    wp::adj_cross(var_83, var_84, adj_83, adj_84, adj_86);
    // adj: - dt * wp.cross(midpoint_angular_momentum, midpoint_angular_velocity)             <L 164>
    wp::adj_sub(var_79, var_angular_momentum, adj_79, adj_angular_momentum, adj_85);
    // adj: - angular_momentum                                                                <L 163>
    // adj: next_angular_momentum                                                             <L 162>
    // adj: residual = (                                                                      <L 161>
    wp::adj_mul(var_0, var_83, adj_0, adj_83, adj_84);
    // adj: midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum           <L 160>
    wp::adj_mul(var_81, var_82, adj_81, adj_82, adj_83);
    wp::adj_add(var_angular_momentum, var_79, adj_angular_momentum, adj_79, adj_82);
    // adj: midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)      <L 159>
    wp::adj_sub(var_54, var_78, adj_54, adj_78, adj_79);
    wp::adj_mul(var_77, var_63, adj_77, adj_63, adj_78);
    wp::adj_inverse(var_76, var_77, adj_76, adj_77);
    // adj: next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual   <L 171>
    wp::adj_sub(var_70, var_75, adj_70, adj_75, adj_76);
    wp::adj_mul(var_74, var_0, adj_74, adj_0, adj_75);
    wp::adj_mul(var_72, var_73, adj_72, adj_73, adj_74);
    wp::adj_skew(var_58, adj_58, adj_73);
    wp::adj_mul(var_71, var_dt, adj_71, adj_dt, adj_72);
    // adj: - 0.5 * dt * wp.skew(midpoint_angular_momentum) * inverse_inertia                 <L 169>
    wp::adj_add(var_65, var_69, adj_65, adj_69, adj_70);
    wp::adj_mul(var_67, var_68, adj_67, adj_68, adj_69);
    wp::adj_skew(var_59, adj_59, adj_68);
    wp::adj_mul(var_66, var_dt, adj_66, adj_dt, adj_67);
    // adj: + 0.5 * dt * wp.skew(midpoint_angular_velocity)                                   <L 168>
    // adj: wp.identity(3, dtype=float)                                                       <L 167>
    // adj: jacobian = (                                                                      <L 166>
    wp::adj_sub(var_60, var_62, adj_60, adj_62, adj_63);
    wp::adj_mul(var_dt, var_61, adj_dt, adj_61, adj_62);
    wp::adj_cross(var_58, var_59, adj_58, adj_59, adj_61);
    // adj: - dt * wp.cross(midpoint_angular_momentum, midpoint_angular_velocity)             <L 164>
    wp::adj_sub(var_54, var_angular_momentum, adj_54, adj_angular_momentum, adj_60);
    // adj: - angular_momentum                                                                <L 163>
    // adj: next_angular_momentum                                                             <L 162>
    // adj: residual = (                                                                      <L 161>
    wp::adj_mul(var_0, var_58, adj_0, adj_58, adj_59);
    // adj: midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum           <L 160>
    wp::adj_mul(var_56, var_57, adj_56, adj_57, adj_58);
    wp::adj_add(var_angular_momentum, var_54, adj_angular_momentum, adj_54, adj_57);
    // adj: midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)      <L 159>
    wp::adj_sub(var_29, var_53, adj_29, adj_53, adj_54);
    wp::adj_mul(var_52, var_38, adj_52, adj_38, adj_53);
    wp::adj_inverse(var_51, var_52, adj_51, adj_52);
    // adj: next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual   <L 171>
    wp::adj_sub(var_45, var_50, adj_45, adj_50, adj_51);
    wp::adj_mul(var_49, var_0, adj_49, adj_0, adj_50);
    wp::adj_mul(var_47, var_48, adj_47, adj_48, adj_49);
    wp::adj_skew(var_33, adj_33, adj_48);
    wp::adj_mul(var_46, var_dt, adj_46, adj_dt, adj_47);
    // adj: - 0.5 * dt * wp.skew(midpoint_angular_momentum) * inverse_inertia                 <L 169>
    wp::adj_add(var_40, var_44, adj_40, adj_44, adj_45);
    wp::adj_mul(var_42, var_43, adj_42, adj_43, adj_44);
    wp::adj_skew(var_34, adj_34, adj_43);
    wp::adj_mul(var_41, var_dt, adj_41, adj_dt, adj_42);
    // adj: + 0.5 * dt * wp.skew(midpoint_angular_velocity)                                   <L 168>
    // adj: wp.identity(3, dtype=float)                                                       <L 167>
    // adj: jacobian = (                                                                      <L 166>
    wp::adj_sub(var_35, var_37, adj_35, adj_37, adj_38);
    wp::adj_mul(var_dt, var_36, adj_dt, adj_36, adj_37);
    wp::adj_cross(var_33, var_34, adj_33, adj_34, adj_36);
    // adj: - dt * wp.cross(midpoint_angular_momentum, midpoint_angular_velocity)             <L 164>
    wp::adj_sub(var_29, var_angular_momentum, adj_29, adj_angular_momentum, adj_35);
    // adj: - angular_momentum                                                                <L 163>
    // adj: next_angular_momentum                                                             <L 162>
    // adj: residual = (                                                                      <L 161>
    wp::adj_mul(var_0, var_33, adj_0, adj_33, adj_34);
    // adj: midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum           <L 160>
    wp::adj_mul(var_31, var_32, adj_31, adj_32, adj_33);
    wp::adj_add(var_angular_momentum, var_29, adj_angular_momentum, adj_29, adj_32);
    // adj: midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)      <L 159>
    wp::adj_sub(var_4, var_28, adj_4, adj_28, adj_29);
    wp::adj_mul(var_27, var_13, adj_27, adj_13, adj_28);
    wp::adj_inverse(var_26, var_27, adj_26, adj_27);
    // adj: next_angular_momentum = next_angular_momentum - wp.inverse(jacobian) * residual   <L 171>
    wp::adj_sub(var_20, var_25, adj_20, adj_25, adj_26);
    wp::adj_mul(var_24, var_0, adj_24, adj_0, adj_25);
    wp::adj_mul(var_22, var_23, adj_22, adj_23, adj_24);
    wp::adj_skew(var_8, adj_8, adj_23);
    wp::adj_mul(var_21, var_dt, adj_21, adj_dt, adj_22);
    // adj: - 0.5 * dt * wp.skew(midpoint_angular_momentum) * inverse_inertia                 <L 169>
    wp::adj_add(var_15, var_19, adj_15, adj_19, adj_20);
    wp::adj_mul(var_17, var_18, adj_17, adj_18, adj_19);
    wp::adj_skew(var_9, adj_9, adj_18);
    wp::adj_mul(var_16, var_dt, adj_16, adj_dt, adj_17);
    // adj: + 0.5 * dt * wp.skew(midpoint_angular_velocity)                                   <L 168>
    // adj: wp.identity(3, dtype=float)                                                       <L 167>
    // adj: jacobian = (                                                                      <L 166>
    wp::adj_sub(var_10, var_12, adj_10, adj_12, adj_13);
    wp::adj_mul(var_dt, var_11, adj_dt, adj_11, adj_12);
    wp::adj_cross(var_8, var_9, adj_8, adj_9, adj_11);
    // adj: - dt * wp.cross(midpoint_angular_momentum, midpoint_angular_velocity)             <L 164>
    wp::adj_sub(var_4, var_angular_momentum, adj_4, adj_angular_momentum, adj_10);
    // adj: - angular_momentum                                                                <L 163>
    // adj: next_angular_momentum                                                             <L 162>
    // adj: residual = (                                                                      <L 161>
    wp::adj_mul(var_0, var_8, adj_0, adj_8, adj_9);
    // adj: midpoint_angular_velocity = inverse_inertia * midpoint_angular_momentum           <L 160>
    wp::adj_mul(var_6, var_7, adj_6, adj_7, adj_8);
    wp::adj_add(var_angular_momentum, var_4, adj_angular_momentum, adj_4, adj_7);
    // adj: midpoint_angular_momentum = 0.5 * (angular_momentum + next_angular_momentum)      <L 159>
    // adj: for _ in range(8):                                                                <L 158>
    wp::adj_add(var_angular_momentum, var_3, adj_angular_momentum, adj_3, adj_4);
    wp::adj_mul(var_dt, var_2, adj_dt, adj_2, adj_3);
    wp::adj_cross(var_angular_momentum, var_1, adj_angular_momentum, adj_1, adj_2);
    wp::adj_mul(var_0, var_angular_momentum, adj_0, adj_angular_momentum, adj_1);
    // adj: inverse_inertia * angular_momentum,                                               <L 155>
    // adj: angular_momentum,                                                                 <L 154>
    // adj: next_angular_momentum = angular_momentum + dt * wp.cross(                         <L 153>
    wp::adj_inverse(var_inertia, var_0, adj_inertia, adj_0);
    // adj: inverse_inertia = wp.inverse(inertia)                                             <L 152>
    // adj: def solve_energy_momentum_midpoint(                                               <L 146>
    return;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:182
static CUDA_CALLABLE void adj_cayley_increment_from_midpoint_0(
    wp::vec_t<3, wp::float32> var_midpoint_angular_velocity,
    wp::float32 var_dt,
    wp::vec_t<3, wp::float32> & adj_midpoint_angular_velocity,
    wp::float32 & adj_dt,
    wp::mat_t<3, 3, wp::float32> & adj_ret)
{
    //---------
    // primal vars
    const wp::int32 var_0 = 3;
    wp::mat_t<3, 3, wp::float32> var_1;
    wp::mat_t<3, 3, wp::float32> var_2;
    wp::mat_t<3, 3, wp::float32> var_3;
    const wp::float32 var_4 = 0.5;
    wp::mat_t<3, 3, wp::float32> var_5;
    wp::mat_t<3, 3, wp::float32> var_6;
    wp::mat_t<3, 3, wp::float32> var_7;
    const wp::float32 var_8 = 0.5;
    wp::mat_t<3, 3, wp::float32> var_9;
    wp::mat_t<3, 3, wp::float32> var_10;
    wp::mat_t<3, 3, wp::float32> var_11;
    //---------
    // dual vars
    wp::int32 adj_0 = {};
    wp::mat_t<3, 3, wp::float32> adj_1 = {};
    wp::mat_t<3, 3, wp::float32> adj_2 = {};
    wp::mat_t<3, 3, wp::float32> adj_3 = {};
    wp::float32 adj_4 = {};
    wp::mat_t<3, 3, wp::float32> adj_5 = {};
    wp::mat_t<3, 3, wp::float32> adj_6 = {};
    wp::mat_t<3, 3, wp::float32> adj_7 = {};
    wp::float32 adj_8 = {};
    wp::mat_t<3, 3, wp::float32> adj_9 = {};
    wp::mat_t<3, 3, wp::float32> adj_10 = {};
    wp::mat_t<3, 3, wp::float32> adj_11 = {};
    //---------
    // forward
    // def cayley_increment_from_midpoint(                                                    <L 183>
    // identity = wp.identity(3, dtype=float)                                                 <L 188>
    var_1 = wp::identity<3, wp::float32>();
    // generator = dt * wp.skew(midpoint_angular_velocity)                                    <L 189>
    var_2 = wp::skew(var_midpoint_angular_velocity);
    var_3 = wp::mul(var_dt, var_2);
    // return wp.inverse(identity - 0.5 * generator) * (identity + 0.5 * generator)           <L 190>
    var_5 = wp::mul(var_4, var_3);
    var_6 = wp::sub(var_1, var_5);
    var_7 = wp::inverse(var_6);
    var_9 = wp::mul(var_8, var_3);
    var_10 = wp::add(var_1, var_9);
    var_11 = wp::mul(var_7, var_10);
    goto label0;
    //---------
    // reverse
    label0:;
    adj_11 += adj_ret;
    wp::adj_mul(var_7, var_10, adj_7, adj_10, adj_11);
    wp::adj_add(var_1, var_9, adj_1, adj_9, adj_10);
    wp::adj_mul(var_8, var_3, adj_8, adj_3, adj_9);
    wp::adj_inverse(var_6, var_7, adj_6, adj_7);
    wp::adj_sub(var_1, var_5, adj_1, adj_5, adj_6);
    wp::adj_mul(var_4, var_3, adj_4, adj_3, adj_5);
    // adj: return wp.inverse(identity - 0.5 * generator) * (identity + 0.5 * generator)      <L 190>
    wp::adj_mul(var_dt, var_2, adj_dt, adj_2, adj_3);
    wp::adj_skew(var_midpoint_angular_velocity, adj_midpoint_angular_velocity, adj_2);
    // adj: generator = dt * wp.skew(midpoint_angular_velocity)                               <L 189>
    // adj: identity = wp.identity(3, dtype=float)                                            <L 188>
    // adj: def cayley_increment_from_midpoint(                                               <L 183>
    return;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:193
static CUDA_CALLABLE void adj_integrate_midpoint_cayley_0(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::vec_t<3, wp::float32> var_angular_momentum,
    wp::float32 var_dt,
    wp::vec_t<3, wp::float32> & ret_0,
    wp::mat_t<3, 3, wp::float32> & ret_1,
    wp::mat_t<3, 3, wp::float32> & adj_inertia,
    wp::vec_t<3, wp::float32> & adj_angular_momentum,
    wp::float32 & adj_dt,
    wp::vec_t<3, wp::float32> & adj_ret_0,
    wp::mat_t<3, 3, wp::float32> & adj_ret_1)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    wp::vec_t<3, wp::float32> var_1;
    wp::vec_t<3, wp::float32> var_2;
    wp::mat_t<3, 3, wp::float32> var_3;
    //---------
    // dual vars
    wp::vec_t<3, wp::float32> adj_0 = {};
    wp::vec_t<3, wp::float32> adj_1 = {};
    wp::vec_t<3, wp::float32> adj_2 = {};
    wp::mat_t<3, 3, wp::float32> adj_3 = {};
    //---------
    // forward
    // def integrate_midpoint_cayley(                                                         <L 194>
    // next_angular_momentum, _midpoint_momentum, midpoint_velocity = (                       <L 200>
    // solve_energy_momentum_midpoint(inertia, angular_momentum, dt)                          <L 201>
    solve_energy_momentum_midpoint_0(var_inertia, var_angular_momentum, var_dt, var_0, var_1, var_2);
    // relative_rotation = cayley_increment_from_midpoint(midpoint_velocity, dt)              <L 203>
    var_3 = cayley_increment_from_midpoint_0(var_2, var_dt);
    // return next_angular_momentum, relative_rotation                                        <L 204>
    ret_0 = var_0;
    ret_1 = var_3;
    goto label0;
    //---------
    // reverse
    label0:;
    adj_3 += adj_ret_1;
    adj_0 += adj_ret_0;
    // adj: return next_angular_momentum, relative_rotation                                   <L 204>
    adj_cayley_increment_from_midpoint_0(var_2, var_dt, adj_2, adj_dt, adj_3);
    // adj: relative_rotation = cayley_increment_from_midpoint(midpoint_velocity, dt)         <L 203>
    adj_solve_energy_momentum_midpoint_0(var_inertia, var_angular_momentum, var_dt, var_0, var_1, var_2, adj_inertia, adj_angular_momentum, adj_dt, adj_0, adj_1, adj_2);
    // adj: solve_energy_momentum_midpoint(inertia, angular_momentum, dt)                     <L 201>
    // adj: next_angular_momentum, _midpoint_momentum, midpoint_velocity = (                  <L 200>
    // adj: def integrate_midpoint_cayley(                                                    <L 194>
    return;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/rigid_body_dynamics.py:225
static CUDA_CALLABLE void adj_integrate_rigid_body_1(
    wp::mat_t<3, 3, wp::float32> var_inertia,
    wp::vec_t<3, wp::float32> var_angular_momentum,
    wp::float32 var_dt,
    wp::int32 var_integrator,
    wp::vec_t<3, wp::float32> & ret_0,
    wp::mat_t<3, 3, wp::float32> & ret_1,
    wp::mat_t<3, 3, wp::float32> & adj_inertia,
    wp::vec_t<3, wp::float32> & adj_angular_momentum,
    wp::float32 & adj_dt,
    wp::int32 & adj_integrator,
    wp::vec_t<3, wp::float32> & adj_ret_0,
    wp::mat_t<3, 3, wp::float32> & adj_ret_1)
{
    //---------
    // primal vars
    const wp::int32 var_0 = 0;
    bool var_1;
    wp::vec_t<3, wp::float32> var_2;
    wp::mat_t<3, 3, wp::float32> var_3;
    const wp::int32 var_4 = 1;
    bool var_5;
    wp::vec_t<3, wp::float32> var_6;
    wp::mat_t<3, 3, wp::float32> var_7;
    const wp::int32 var_8 = 2;
    bool var_9;
    wp::vec_t<3, wp::float32> var_10;
    wp::mat_t<3, 3, wp::float32> var_11;
    const wp::int32 var_12 = 3;
    bool var_13;
    wp::vec_t<3, wp::float32> var_14;
    wp::mat_t<3, 3, wp::float32> var_15;
    const wp::int32 var_16 = 5;
    bool var_17;
    const wp::float32 var_18 = 0.0;
    wp::vec_t<3, wp::float32> var_19;
    wp::vec_t<3, wp::float32> var_20;
    wp::mat_t<3, 3, wp::float32> var_21;
    //---------
    // dual vars
    wp::int32 adj_0 = {};
    bool adj_1 = {};
    wp::vec_t<3, wp::float32> adj_2 = {};
    wp::mat_t<3, 3, wp::float32> adj_3 = {};
    wp::int32 adj_4 = {};
    bool adj_5 = {};
    wp::vec_t<3, wp::float32> adj_6 = {};
    wp::mat_t<3, 3, wp::float32> adj_7 = {};
    wp::int32 adj_8 = {};
    bool adj_9 = {};
    wp::vec_t<3, wp::float32> adj_10 = {};
    wp::mat_t<3, 3, wp::float32> adj_11 = {};
    wp::int32 adj_12 = {};
    bool adj_13 = {};
    wp::vec_t<3, wp::float32> adj_14 = {};
    wp::mat_t<3, 3, wp::float32> adj_15 = {};
    wp::int32 adj_16 = {};
    bool adj_17 = {};
    wp::float32 adj_18 = {};
    wp::vec_t<3, wp::float32> adj_19 = {};
    wp::vec_t<3, wp::float32> adj_20 = {};
    wp::mat_t<3, 3, wp::float32> adj_21 = {};
    //---------
    // forward
    // def integrate_rigid_body(                                                              <L 226>
    // if integrator == EXPLICIT_EULER:                                                       <L 233>
    var_1 = (var_integrator == var_0);
    if (var_1) {
        // return integrate_explicit_euler(inertia, angular_momentum, dt)                     <L 234>
        integrate_explicit_euler_0(var_inertia, var_angular_momentum, var_dt, var_2, var_3);
        ret_0 = var_2;
        ret_1 = var_3;
        goto label0;
    }
    if (!var_1) {
        // elif integrator == IMPLICIT_EULER:                                                 <L 235>
        var_5 = (var_integrator == var_4);
        if (var_5) {
            // return integrate_implicit_euler(inertia, angular_momentum, dt)                 <L 236>
            integrate_implicit_euler_0(var_inertia, var_angular_momentum, var_dt, var_6, var_7);
            ret_0 = var_6;
            ret_1 = var_7;
            goto label1;
        }
        if (!var_5) {
            // elif integrator == LIE_GROUP_MIDPOINT:                                         <L 237>
            var_9 = (var_integrator == var_8);
            if (var_9) {
                // return integrate_lie_group_midpoint(inertia, angular_momentum, dt)         <L 238>
                integrate_lie_group_midpoint_0(var_inertia, var_angular_momentum, var_dt, var_10, var_11);
                ret_0 = var_10;
                ret_1 = var_11;
                goto label2;
            }
            if (!var_9) {
                // elif integrator == MIDPOINT_CAYLEY:                                        <L 239>
                var_13 = (var_integrator == var_12);
                if (var_13) {
                    // return integrate_midpoint_cayley(inertia, angular_momentum, dt)        <L 240>
                    integrate_midpoint_cayley_0(var_inertia, var_angular_momentum, var_dt, var_14, var_15);
                    ret_0 = var_14;
                    ret_1 = var_15;
                    goto label3;
                }
                if (!var_13) {
                    // elif integrator == VBD_SEMI_IMPLICIT:                                  <L 241>
                    var_17 = (var_integrator == var_16);
                    if (var_17) {
                        // return integrate_vbd_semi_implicit(inertia, angular_momentum, wp.vec3(0.0), dt)       <L 244>
                        var_19 = wp::vec_t<3, wp::float32>(var_18);
                        integrate_vbd_semi_implicit_0(var_inertia, var_angular_momentum, var_19, var_dt, var_20, var_21);
                        ret_0 = var_20;
                        ret_1 = var_21;
                        goto label4;
                    }
                }
            }
        }
    }
    //---------
    // reverse
    if (!var_1) {
        if (!var_5) {
            if (!var_9) {
                if (!var_13) {
                    if (var_17) {
                        label4:;
                        adj_21 += adj_ret_1;
                        adj_20 += adj_ret_0;
                        adj_integrate_vbd_semi_implicit_0(var_inertia, var_angular_momentum, var_19, var_dt, var_20, var_21, adj_inertia, adj_angular_momentum, adj_19, adj_dt, adj_20, adj_21);
                        wp::adj_vec_t(var_18, adj_18, adj_19);
                        // adj: return integrate_vbd_semi_implicit(inertia, angular_momentum, wp.vec3(0.0), dt)  <L 244>
                    }
                    // adj: elif integrator == VBD_SEMI_IMPLICIT:                             <L 241>
                }
                if (var_13) {
                    label3:;
                    adj_15 += adj_ret_1;
                    adj_14 += adj_ret_0;
                    adj_integrate_midpoint_cayley_0(var_inertia, var_angular_momentum, var_dt, var_14, var_15, adj_inertia, adj_angular_momentum, adj_dt, adj_14, adj_15);
                    // adj: return integrate_midpoint_cayley(inertia, angular_momentum, dt)   <L 240>
                }
                // adj: elif integrator == MIDPOINT_CAYLEY:                                   <L 239>
            }
            if (var_9) {
                label2:;
                adj_11 += adj_ret_1;
                adj_10 += adj_ret_0;
                adj_integrate_lie_group_midpoint_0(var_inertia, var_angular_momentum, var_dt, var_10, var_11, adj_inertia, adj_angular_momentum, adj_dt, adj_10, adj_11);
                // adj: return integrate_lie_group_midpoint(inertia, angular_momentum, dt)    <L 238>
            }
            // adj: elif integrator == LIE_GROUP_MIDPOINT:                                    <L 237>
        }
        if (var_5) {
            label1:;
            adj_7 += adj_ret_1;
            adj_6 += adj_ret_0;
            adj_integrate_implicit_euler_0(var_inertia, var_angular_momentum, var_dt, var_6, var_7, adj_inertia, adj_angular_momentum, adj_dt, adj_6, adj_7);
            // adj: return integrate_implicit_euler(inertia, angular_momentum, dt)            <L 236>
        }
        // adj: elif integrator == IMPLICIT_EULER:                                            <L 235>
    }
    if (var_1) {
        label0:;
        adj_3 += adj_ret_1;
        adj_2 += adj_ret_0;
        adj_integrate_explicit_euler_0(var_inertia, var_angular_momentum, var_dt, var_2, var_3, adj_inertia, adj_angular_momentum, adj_dt, adj_2, adj_3);
        // adj: return integrate_explicit_euler(inertia, angular_momentum, dt)                <L 234>
    }
    // adj: if integrator == EXPLICIT_EULER:                                                  <L 233>
    // adj: def integrate_rigid_body(                                                         <L 226>
    return;
}



extern "C" __global__ void _gather_cable_parameters_58bf955b_cuda_kernel_forward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::int32> var_cable_joints,
    wp::array_t<bool> var_joint_enabled,
    wp::array_t<wp::vec_t<3, wp::float32>> var_joint_kb_rest,
    wp::array_t<wp::float32> var_joint_twist_rest,
    wp::array_t<wp::vec_t<3, wp::float32>> var_joint_sigma_start,
    wp::array_t<wp::vec_t<3, wp::float32>> var_joint_C_fric,
    wp::array_t<wp::int32> var_cable_enabled,
    wp::array_t<wp::vec_t<3, wp::float32>> var_cable_rest,
    wp::array_t<wp::vec_t<3, wp::float32>> var_cable_bias,
    wp::array_t<wp::vec_t<3, wp::float32>> var_cable_hessian)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        wp::int32 var_0;
        wp::int32* var_1;
        wp::int32 var_2;
        wp::int32 var_3;
        wp::vec_t<3, wp::float32>* var_4;
        wp::vec_t<3, wp::float32> var_5;
        wp::vec_t<3, wp::float32> var_6;
        bool* var_7;
        wp::int32 var_8;
        bool var_9;
        const wp::int32 var_10 = 0;
        wp::float32 var_11;
        const wp::int32 var_12 = 1;
        wp::float32 var_13;
        wp::float32* var_14;
        wp::vec_t<3, wp::float32> var_15;
        wp::float32 var_16;
        wp::vec_t<3, wp::float32>* var_17;
        wp::vec_t<3, wp::float32> var_18;
        wp::vec_t<3, wp::float32>* var_19;
        wp::vec_t<3, wp::float32> var_20;
        //---------
        // forward
        // def _gather_cable_parameters(                                                          <L 365>
        // cable = wp.tid()                                                                       <L 377>
        var_0 = builtin_tid1d();
        // joint = cable_joints[cable]                                                            <L 378>
        var_1 = wp::address(var_cable_joints, var_0);
        var_3 = wp::load(var_1);
        var_2 = wp::copy(var_3);
        // kb = joint_kb_rest[joint]                                                              <L 379>
        var_4 = wp::address(var_joint_kb_rest, var_2);
        var_6 = wp::load(var_4);
        var_5 = wp::copy(var_6);
        // cable_enabled[cable] = wp.int32(joint_enabled[joint])                                  <L 380>
        var_7 = wp::address(var_joint_enabled, var_2);
        var_9 = wp::load(var_7);
        var_8 = wp::int32(var_9);
        wp::array_store(var_cable_enabled, var_0, var_8);
        // cable_rest[cable] = wp.vec3(kb[0], kb[1], joint_twist_rest[joint])                     <L 381>
        var_11 = wp::extract(var_5, var_10);
        var_13 = wp::extract(var_5, var_12);
        var_14 = wp::address(var_joint_twist_rest, var_2);
        var_16 = wp::load(var_14);
        var_15 = wp::vec_t<3, wp::float32>(var_11, var_13, var_16);
        wp::array_store(var_cable_rest, var_0, var_15);
        // cable_bias[cable] = joint_sigma_start[joint]                                           <L 382>
        var_17 = wp::address(var_joint_sigma_start, var_2);
        var_18 = wp::load(var_17);
        wp::array_store(var_cable_bias, var_0, var_18);
        // cable_hessian[cable] = joint_C_fric[joint]                                             <L 383>
        var_19 = wp::address(var_joint_C_fric, var_2);
        var_20 = wp::load(var_19);
        wp::array_store(var_cable_hessian, var_0, var_20);
    }
}



extern "C" __global__ void _gather_cable_parameters_58bf955b_cuda_kernel_backward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::int32> var_cable_joints,
    wp::array_t<bool> var_joint_enabled,
    wp::array_t<wp::vec_t<3, wp::float32>> var_joint_kb_rest,
    wp::array_t<wp::float32> var_joint_twist_rest,
    wp::array_t<wp::vec_t<3, wp::float32>> var_joint_sigma_start,
    wp::array_t<wp::vec_t<3, wp::float32>> var_joint_C_fric,
    wp::array_t<wp::int32> var_cable_enabled,
    wp::array_t<wp::vec_t<3, wp::float32>> var_cable_rest,
    wp::array_t<wp::vec_t<3, wp::float32>> var_cable_bias,
    wp::array_t<wp::vec_t<3, wp::float32>> var_cable_hessian,
    wp::array_t<wp::int32> adj_cable_joints,
    wp::array_t<bool> adj_joint_enabled,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_joint_kb_rest,
    wp::array_t<wp::float32> adj_joint_twist_rest,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_joint_sigma_start,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_joint_C_fric,
    wp::array_t<wp::int32> adj_cable_enabled,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_cable_rest,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_cable_bias,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_cable_hessian)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        wp::int32 var_0;
        wp::int32* var_1;
        wp::int32 var_2;
        wp::int32 var_3;
        wp::vec_t<3, wp::float32>* var_4;
        wp::vec_t<3, wp::float32> var_5;
        wp::vec_t<3, wp::float32> var_6;
        bool* var_7;
        wp::int32 var_8;
        bool var_9;
        const wp::int32 var_10 = 0;
        wp::float32 var_11;
        const wp::int32 var_12 = 1;
        wp::float32 var_13;
        wp::float32* var_14;
        wp::vec_t<3, wp::float32> var_15;
        wp::float32 var_16;
        wp::vec_t<3, wp::float32>* var_17;
        wp::vec_t<3, wp::float32> var_18;
        wp::vec_t<3, wp::float32>* var_19;
        wp::vec_t<3, wp::float32> var_20;
        //---------
        // dual vars
        wp::int32 adj_0 = {};
        wp::int32 adj_1 = {};
        wp::int32 adj_2 = {};
        wp::int32 adj_3 = {};
        wp::vec_t<3, wp::float32> adj_4 = {};
        wp::vec_t<3, wp::float32> adj_5 = {};
        wp::vec_t<3, wp::float32> adj_6 = {};
        bool adj_7 = {};
        wp::int32 adj_8 = {};
        bool adj_9 = {};
        wp::int32 adj_10 = {};
        wp::float32 adj_11 = {};
        wp::int32 adj_12 = {};
        wp::float32 adj_13 = {};
        wp::float32 adj_14 = {};
        wp::vec_t<3, wp::float32> adj_15 = {};
        wp::float32 adj_16 = {};
        wp::vec_t<3, wp::float32> adj_17 = {};
        wp::vec_t<3, wp::float32> adj_18 = {};
        wp::vec_t<3, wp::float32> adj_19 = {};
        wp::vec_t<3, wp::float32> adj_20 = {};
        //---------
        // forward
        // def _gather_cable_parameters(                                                          <L 365>
        // cable = wp.tid()                                                                       <L 377>
        var_0 = builtin_tid1d();
        // joint = cable_joints[cable]                                                            <L 378>
        var_1 = wp::address(var_cable_joints, var_0);
        var_3 = wp::load(var_1);
        var_2 = wp::copy(var_3);
        // kb = joint_kb_rest[joint]                                                              <L 379>
        var_4 = wp::address(var_joint_kb_rest, var_2);
        var_6 = wp::load(var_4);
        var_5 = wp::copy(var_6);
        // cable_enabled[cable] = wp.int32(joint_enabled[joint])                                  <L 380>
        var_7 = wp::address(var_joint_enabled, var_2);
        var_9 = wp::load(var_7);
        var_8 = wp::int32(var_9);
        // wp::array_store(var_cable_enabled, var_0, var_8);
        // cable_rest[cable] = wp.vec3(kb[0], kb[1], joint_twist_rest[joint])                     <L 381>
        var_11 = wp::extract(var_5, var_10);
        var_13 = wp::extract(var_5, var_12);
        var_14 = wp::address(var_joint_twist_rest, var_2);
        var_16 = wp::load(var_14);
        var_15 = wp::vec_t<3, wp::float32>(var_11, var_13, var_16);
        // wp::array_store(var_cable_rest, var_0, var_15);
        // cable_bias[cable] = joint_sigma_start[joint]                                           <L 382>
        var_17 = wp::address(var_joint_sigma_start, var_2);
        var_18 = wp::load(var_17);
        // wp::array_store(var_cable_bias, var_0, var_18);
        // cable_hessian[cable] = joint_C_fric[joint]                                             <L 383>
        var_19 = wp::address(var_joint_C_fric, var_2);
        var_20 = wp::load(var_19);
        // wp::array_store(var_cable_hessian, var_0, var_20);
        //---------
        // reverse
        wp::adj_array_store(var_cable_hessian, var_0, var_20, adj_cable_hessian, adj_0, adj_19);
        wp::adj_address(var_joint_C_fric, var_2, adj_joint_C_fric, adj_2, adj_19);
        // adj: cable_hessian[cable] = joint_C_fric[joint]                                        <L 383>
        wp::adj_array_store(var_cable_bias, var_0, var_18, adj_cable_bias, adj_0, adj_17);
        wp::adj_address(var_joint_sigma_start, var_2, adj_joint_sigma_start, adj_2, adj_17);
        // adj: cable_bias[cable] = joint_sigma_start[joint]                                      <L 382>
        wp::adj_array_store(var_cable_rest, var_0, var_15, adj_cable_rest, adj_0, adj_15);
        wp::adj_vec_t(var_11, var_13, var_16, adj_11, adj_13, adj_14, adj_15);
        wp::adj_address(var_joint_twist_rest, var_2, adj_joint_twist_rest, adj_2, adj_14);
        wp::adj_extract(var_5, var_12, adj_5, adj_12, adj_13);
        wp::adj_extract(var_5, var_10, adj_5, adj_10, adj_11);
        // adj: cable_rest[cable] = wp.vec3(kb[0], kb[1], joint_twist_rest[joint])                <L 381>
        wp::adj_array_store(var_cable_enabled, var_0, var_8, adj_cable_enabled, adj_0, adj_8);
        wp::adj_address(var_joint_enabled, var_2, adj_joint_enabled, adj_2, adj_7);
        // adj: cable_enabled[cable] = wp.int32(joint_enabled[joint])                             <L 380>
        wp::adj_copy(var_6, adj_4, adj_5);
        wp::adj_address(var_joint_kb_rest, var_2, adj_joint_kb_rest, adj_2, adj_4);
        // adj: kb = joint_kb_rest[joint]                                                         <L 379>
        wp::adj_copy(var_3, adj_1, adj_2);
        wp::adj_address(var_cable_joints, var_0, adj_cable_joints, adj_0, adj_1);
        // adj: joint = cable_joints[cable]                                                       <L 378>
        // adj: cable = wp.tid()                                                                  <L 377>
        // adj: def _gather_cable_parameters(                                                     <L 365>
        continue;
    }
}



extern "C" __global__ void _update_affine_body_poses_cda05b4e_cuda_kernel_forward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_q,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_qd,
    wp::array_t<wp::vec_t<4, wp::int32>> var_affine_body_indices,
    wp::array_t<wp::int32> var_affine_body_ids,
    wp::array_t<wp::int32> var_fixed_affine_body_flags,
    wp::array_t<wp::vec_t<3, wp::float32>> var_body_com,
    wp::array_t<wp::mat_t<3, 3, wp::float32>> var_affine_body_inertia,
    wp::int32 var_inertia_mode,
    wp::float32 var_dt,
    wp::array_t<wp::transform_t<wp::float32>> var_body_q,
    wp::array_t<wp::vec_t<6, wp::float32>> var_body_qd)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        wp::int32 var_0;
        wp::int32* var_1;
        const wp::int32 var_2 = 0;
        bool var_3;
        wp::int32 var_4;
        wp::vec_t<4, wp::int32>* var_5;
        wp::vec_t<4, wp::int32> var_6;
        wp::vec_t<4, wp::int32> var_7;
        wp::int32* var_8;
        wp::int32 var_9;
        wp::int32 var_10;
        const wp::int32 var_11 = 0;
        wp::int32 var_12;
        wp::vec_t<3, wp::float32>* var_13;
        wp::vec_t<3, wp::float32> var_14;
        wp::vec_t<3, wp::float32> var_15;
        const wp::int32 var_16 = 1;
        wp::int32 var_17;
        wp::vec_t<3, wp::float32>* var_18;
        const wp::int32 var_19 = 2;
        wp::int32 var_20;
        wp::vec_t<3, wp::float32>* var_21;
        const wp::int32 var_22 = 3;
        wp::int32 var_23;
        wp::vec_t<3, wp::float32>* var_24;
        wp::mat_t<3, 3, wp::float32> var_25;
        wp::vec_t<3, wp::float32> var_26;
        wp::vec_t<3, wp::float32> var_27;
        wp::vec_t<3, wp::float32> var_28;
        wp::mat_t<3, 3, wp::float32>* var_29;
        wp::mat_t<3, 3, wp::float32> var_30;
        wp::mat_t<3, 3, wp::float32> var_31;
        const wp::float32 var_32 = 0.5;
        wp::float32 var_33;
        wp::float32 var_34;
        const wp::int32 var_35 = 3;
        wp::mat_t<3, 3, wp::float32> var_36;
        wp::mat_t<3, 3, wp::float32> var_37;
        wp::mat_t<3, 3, wp::float32> var_38;
        wp::mat_t<3, 3, wp::float64> var_39;
        wp::float64 var_40;
        wp::float64 var_41;
        wp::float64 var_42;
        const wp::int32 var_43 = 3;
        wp::mat_t<3, 3, wp::float64> var_44;
        wp::mat_t<3, 3, wp::float64> var_45;
        wp::mat_t<3, 3, wp::float64> var_46;
        wp::mat_t<3, 3, wp::float64> var_47;
        wp::mat_t<3, 3, wp::float64> var_48;
        wp::float64 var_49;
        const wp::int32 var_50 = 0;
        const wp::int32 var_51 = 0;
        wp::float64 var_52;
        wp::float64 var_53;
        wp::float64 var_54;
        const wp::int32 var_55 = 1;
        wp::float64 var_56;
        wp::float64 var_57;
        wp::float64 var_58;
        const wp::int32 var_59 = 2;
        wp::float64 var_60;
        wp::float64 var_61;
        wp::float64 var_62;
        const wp::int32 var_63 = 1;
        const wp::int32 var_64 = 0;
        wp::float64 var_65;
        wp::float64 var_66;
        wp::float64 var_67;
        const wp::int32 var_68 = 1;
        wp::float64 var_69;
        wp::float64 var_70;
        wp::float64 var_71;
        const wp::int32 var_72 = 2;
        wp::float64 var_73;
        wp::float64 var_74;
        wp::float64 var_75;
        const wp::int32 var_76 = 2;
        const wp::int32 var_77 = 0;
        wp::float64 var_78;
        wp::float64 var_79;
        wp::float64 var_80;
        const wp::int32 var_81 = 1;
        wp::float64 var_82;
        wp::float64 var_83;
        wp::float64 var_84;
        const wp::int32 var_85 = 2;
        wp::float64 var_86;
        wp::float64 var_87;
        wp::float64 var_88;
        wp::float64 var_89;
        bool var_90;
        wp::mat_t<3, 3, wp::float64> var_91;
        wp::mat_t<3, 3, wp::float64> var_92;
        wp::vec_t<3, wp::float64> var_93;
        wp::mat_t<3, 3, wp::float64> var_94;
        const wp::int32 var_95 = 2;
        wp::float64 var_96;
        wp::float64 var_97;
        wp::float64 var_98;
        const wp::int32 var_99 = 0;
        wp::float64 var_100;
        wp::float64 var_101;
        wp::float64 var_102;
        bool var_103;
        wp::mat_t<3, 3, wp::float64> var_104;
        wp::mat_t<3, 3, wp::float64> var_105;
        wp::float64 var_106;
        wp::float64 var_107;
        bool var_108;
        const wp::int32 var_109 = 0;
        const wp::int32 var_110 = 0;
        wp::float64 var_111;
        const wp::int32 var_112 = 1;
        const wp::int32 var_113 = 0;
        wp::float64 var_114;
        const wp::int32 var_115 = 2;
        const wp::int32 var_116 = 0;
        wp::float64 var_117;
        wp::vec_t<3, wp::float64> var_118;
        const wp::int32 var_119 = 0;
        const wp::int32 var_120 = 1;
        wp::float64 var_121;
        const wp::int32 var_122 = 1;
        const wp::int32 var_123 = 1;
        wp::float64 var_124;
        const wp::int32 var_125 = 2;
        const wp::int32 var_126 = 1;
        wp::float64 var_127;
        wp::vec_t<3, wp::float64> var_128;
        const wp::int32 var_129 = 0;
        const wp::int32 var_130 = 2;
        wp::float64 var_131;
        const wp::int32 var_132 = 1;
        const wp::int32 var_133 = 2;
        wp::float64 var_134;
        const wp::int32 var_135 = 2;
        const wp::int32 var_136 = 2;
        wp::float64 var_137;
        wp::vec_t<3, wp::float64> var_138;
        wp::vec_t<3, wp::float64> var_139;
        wp::mat_t<3, 3, wp::float64> var_140;
        wp::mat_t<3, 3, wp::float64> var_141;
        wp::mat_t<3, 3, wp::float64> var_142;
        wp::mat_t<3, 3, wp::float64> var_143;
        wp::mat_t<3, 3, wp::float64> var_144;
        wp::quat_t<wp::float64> var_145;
        wp::quat_t<wp::float32> var_146;
        wp::mat_t<3, 3, wp::float32> var_147;
        wp::transform_t<wp::float32>* var_148;
        wp::quat_t<wp::float32> var_149;
        wp::transform_t<wp::float32> var_150;
        const wp::int32 var_151 = 0;
        wp::float32 var_152;
        const wp::int32 var_153 = 0;
        wp::float32 var_154;
        wp::float32 var_155;
        const wp::int32 var_156 = 1;
        wp::float32 var_157;
        const wp::int32 var_158 = 1;
        wp::float32 var_159;
        wp::float32 var_160;
        wp::float32 var_161;
        const wp::int32 var_162 = 2;
        wp::float32 var_163;
        const wp::int32 var_164 = 2;
        wp::float32 var_165;
        wp::float32 var_166;
        wp::float32 var_167;
        const wp::int32 var_168 = 3;
        wp::float32 var_169;
        const wp::int32 var_170 = 3;
        wp::float32 var_171;
        wp::float32 var_172;
        wp::float32 var_173;
        const wp::float32 var_174 = 0.0;
        bool var_175;
        const wp::int32 var_176 = 0;
        wp::float32 var_177;
        wp::float32 var_178;
        const wp::int32 var_179 = 1;
        wp::float32 var_180;
        wp::float32 var_181;
        const wp::int32 var_182 = 2;
        wp::float32 var_183;
        wp::float32 var_184;
        const wp::int32 var_185 = 3;
        wp::float32 var_186;
        wp::float32 var_187;
        wp::quat_t<wp::float32> var_188;
        wp::quat_t<wp::float32> var_189;
        const wp::int32 var_190 = 0;
        wp::int32 var_191;
        wp::vec_t<3, wp::float32>* var_192;
        wp::vec_t<3, wp::float32> var_193;
        wp::vec_t<3, wp::float32> var_194;
        const wp::float32 var_195 = 0.0;
        wp::vec_t<3, wp::float32> var_196;
        const wp::int32 var_197 = 4;
        bool var_198;
        wp::quat_t<wp::float32> var_199;
        wp::quat_t<wp::float32> var_200;
        const wp::int32 var_201 = 3;
        wp::float32 var_202;
        const wp::float32 var_203 = 0.0;
        bool var_204;
        const wp::int32 var_205 = 0;
        wp::float32 var_206;
        wp::float32 var_207;
        const wp::int32 var_208 = 1;
        wp::float32 var_209;
        wp::float32 var_210;
        const wp::int32 var_211 = 2;
        wp::float32 var_212;
        wp::float32 var_213;
        const wp::int32 var_214 = 3;
        wp::float32 var_215;
        wp::float32 var_216;
        wp::quat_t<wp::float32> var_217;
        wp::quat_t<wp::float32> var_218;
        wp::mat_t<3, 3, wp::float32> var_219;
        wp::vec_t<3, wp::float32> var_220;
        wp::vec_t<3, wp::float32> var_221;
        const wp::int32 var_222 = 1;
        wp::int32 var_223;
        wp::vec_t<3, wp::float32>* var_224;
        const wp::int32 var_225 = 2;
        wp::int32 var_226;
        wp::vec_t<3, wp::float32>* var_227;
        const wp::int32 var_228 = 3;
        wp::int32 var_229;
        wp::vec_t<3, wp::float32>* var_230;
        wp::mat_t<3, 3, wp::float32> var_231;
        wp::vec_t<3, wp::float32> var_232;
        wp::vec_t<3, wp::float32> var_233;
        wp::vec_t<3, wp::float32> var_234;
        wp::mat_t<3, 3, wp::float32> var_235;
        wp::mat_t<3, 3, wp::float32> var_236;
        wp::mat_t<3, 3, wp::float32> var_237;
        const wp::int32 var_238 = 2;
        const wp::int32 var_239 = 1;
        wp::float32 var_240;
        const wp::int32 var_241 = 1;
        const wp::int32 var_242 = 2;
        wp::float32 var_243;
        wp::float32 var_244;
        const wp::int32 var_245 = 0;
        const wp::int32 var_246 = 2;
        wp::float32 var_247;
        const wp::int32 var_248 = 2;
        const wp::int32 var_249 = 0;
        wp::float32 var_250;
        wp::float32 var_251;
        const wp::int32 var_252 = 1;
        const wp::int32 var_253 = 0;
        wp::float32 var_254;
        const wp::int32 var_255 = 0;
        const wp::int32 var_256 = 1;
        wp::float32 var_257;
        wp::float32 var_258;
        wp::vec_t<3, wp::float32> var_259;
        wp::mat_t<3, 3, wp::float32> var_260;
        wp::mat_t<3, 3, wp::float32> var_261;
        wp::mat_t<3, 3, wp::float32> var_262;
        wp::mat_t<3, 3, wp::float32> var_263;
        wp::vec_t<3, wp::float32> var_264;
        const wp::float32 var_265 = 1.0;
        const wp::float32 var_266 = 0.0;
        const wp::float32 var_267 = 0.0;
        wp::vec_t<3, wp::float32> var_268;
        wp::vec_t<3, wp::float32> var_269;
        const wp::float32 var_270 = 0.0;
        const wp::float32 var_271 = 1.0;
        const wp::float32 var_272 = 0.0;
        wp::vec_t<3, wp::float32> var_273;
        wp::vec_t<3, wp::float32> var_274;
        const wp::float32 var_275 = 0.0;
        const wp::float32 var_276 = 0.0;
        const wp::float32 var_277 = 1.0;
        wp::vec_t<3, wp::float32> var_278;
        wp::vec_t<3, wp::float32> var_279;
        const wp::int32 var_280 = 0;
        wp::int32 var_281;
        wp::vec_t<3, wp::float32> var_282;
        const wp::int32 var_283 = 1;
        wp::int32 var_284;
        wp::vec_t<3, wp::float32> var_285;
        const wp::int32 var_286 = 2;
        wp::int32 var_287;
        wp::vec_t<3, wp::float32> var_288;
        const wp::int32 var_289 = 3;
        wp::int32 var_290;
        wp::vec_t<3, wp::float32> var_291;
        wp::vec_t<3, wp::float32>* var_292;
        wp::vec_t<3, wp::float32> var_293;
        wp::vec_t<3, wp::float32> var_294;
        wp::vec_t<3, wp::float32> var_295;
        wp::transform_t<wp::float32> var_296;
        wp::vec_t<6, wp::float32> var_297;
        //---------
        // forward
        // def _update_affine_body_poses(                                                         <L 446>
        // affine_body = wp.tid()                                                                 <L 460>
        var_0 = builtin_tid1d();
        // if fixed_affine_body_flags[affine_body] != 0:                                          <L 461>
        var_1 = wp::address(var_fixed_affine_body_flags, var_0);
        var_4 = wp::load(var_1);
        var_3 = (var_4 != var_2);
        if (var_3) {
            // return                                                                             <L 462>
            continue;
        }
        // particle_indices = affine_body_indices[affine_body]                                    <L 463>
        var_5 = wp::address(var_affine_body_indices, var_0);
        var_7 = wp::load(var_5);
        var_6 = wp::copy(var_7);
        // body = affine_body_ids[affine_body]                                                    <L 464>
        var_8 = wp::address(var_affine_body_ids, var_0);
        var_10 = wp::load(var_8);
        var_9 = wp::copy(var_10);
        // origin = particle_q[particle_indices[0]]                                               <L 465>
        var_12 = wp::extract(var_6, var_11);
        var_13 = wp::address(var_particle_q, var_12);
        var_15 = wp::load(var_13);
        var_14 = wp::copy(var_15);
        // affine_matrix = wp.matrix_from_cols(                                                   <L 467>
        // particle_q[particle_indices[1]],                                                       <L 468>
        var_17 = wp::extract(var_6, var_16);
        var_18 = wp::address(var_particle_q, var_17);
        // particle_q[particle_indices[2]],                                                       <L 469>
        var_20 = wp::extract(var_6, var_19);
        var_21 = wp::address(var_particle_q, var_20);
        // particle_q[particle_indices[3]],                                                       <L 470>
        var_23 = wp::extract(var_6, var_22);
        var_24 = wp::address(var_particle_q, var_23);
        var_26 = wp::load(var_18);
        var_27 = wp::load(var_21);
        var_28 = wp::load(var_24);
        var_25 = wp::matrix_from_cols<wp::float32>(var_26, var_27, var_28);
        // inertia = affine_body_inertia[affine_body]                                             <L 475>
        var_29 = wp::address(var_affine_body_inertia, var_0);
        var_31 = wp::load(var_29);
        var_30 = wp::copy(var_31);
        // second_moment = 0.5 * wp.trace(inertia) * wp.identity(3, dtype=float) - inertia        <L 476>
        var_33 = wp::trace(var_30);
        var_34 = wp::mul(var_32, var_33);
        var_36 = wp::identity<3, wp::float32>();
        var_37 = wp::mul(var_34, var_36);
        var_38 = wp::sub(var_37, var_30);
        // inertia64 = wp.mat33d(inertia)                                                         <L 480>
        var_39 = wp::mat_t<3, 3, wp::float64>(var_30);
        // second_moment64 = wp.float64(0.5) * wp.trace(inertia64) * wp.identity(3, dtype=wp.float64) - inertia64       <L 481>
        var_40 = 0.5;
        var_41 = wp::trace(var_39);
        var_42 = wp::mul(var_40, var_41);
        var_44 = wp::identity<3, wp::float64>();
        var_45 = wp::mul(var_42, var_44);
        var_46 = wp::sub(var_45, var_39);
        // weighted_affine_matrix = wp.mat33d(affine_matrix) * second_moment64                    <L 482>
        var_47 = wp::mat_t<3, 3, wp::float64>(var_25);
        var_48 = wp::mul(var_47, var_46);
        // matrix_scale = wp.float64(0.0)                                                         <L 486>
        var_49 = 0.0;
        // for row in range(3):                                                                   <L 487>
        // for column in range(3):                                                                <L 488>
        // matrix_scale = wp.max(matrix_scale, wp.abs(weighted_affine_matrix[row, column]))       <L 489>
        var_52 = wp::extract(var_48, var_50, var_51);
        var_53 = wp::abs(var_52);
        var_54 = wp::max(var_49, var_53);
        var_56 = wp::extract(var_48, var_50, var_55);
        var_57 = wp::abs(var_56);
        var_58 = wp::max(var_54, var_57);
        var_60 = wp::extract(var_48, var_50, var_59);
        var_61 = wp::abs(var_60);
        var_62 = wp::max(var_58, var_61);
        // for column in range(3):                                                                <L 488>
        // matrix_scale = wp.max(matrix_scale, wp.abs(weighted_affine_matrix[row, column]))       <L 489>
        var_65 = wp::extract(var_48, var_63, var_64);
        var_66 = wp::abs(var_65);
        var_67 = wp::max(var_62, var_66);
        var_69 = wp::extract(var_48, var_63, var_68);
        var_70 = wp::abs(var_69);
        var_71 = wp::max(var_67, var_70);
        var_73 = wp::extract(var_48, var_63, var_72);
        var_74 = wp::abs(var_73);
        var_75 = wp::max(var_71, var_74);
        // for column in range(3):                                                                <L 488>
        // matrix_scale = wp.max(matrix_scale, wp.abs(weighted_affine_matrix[row, column]))       <L 489>
        var_78 = wp::extract(var_48, var_76, var_77);
        var_79 = wp::abs(var_78);
        var_80 = wp::max(var_75, var_79);
        var_82 = wp::extract(var_48, var_76, var_81);
        var_83 = wp::abs(var_82);
        var_84 = wp::max(var_80, var_83);
        var_86 = wp::extract(var_48, var_76, var_85);
        var_87 = wp::abs(var_86);
        var_88 = wp::max(var_84, var_87);
        // if matrix_scale <= wp.float64(0.0):                                                    <L 490>
        var_89 = 0.0;
        var_90 = (var_88 <= var_89);
        if (var_90) {
            // return                                                                             <L 491>
            continue;
        }
        // left_basis, singular_values, right_basis = wp.svd3(weighted_affine_matrix / matrix_scale)       <L 492>
        var_91 = wp::div(var_48, var_88);
        wp::svd3(var_91, var_92, var_93, var_94);
        // if wp.abs(singular_values[2]) <= wp.float64(1.0e-8) * wp.abs(singular_values[0]):       <L 493>
        var_96 = wp::extract(var_93, var_95);
        var_97 = wp::abs(var_96);
        var_98 = 1e-08;
        var_100 = wp::extract(var_93, var_99);
        var_101 = wp::abs(var_100);
        var_102 = wp::mul(var_98, var_101);
        var_103 = (var_97 <= var_102);
        if (var_103) {
            // return                                                                             <L 494>
            continue;
        }
        // polar_rotation = left_basis * wp.transpose(right_basis)                                <L 496>
        var_104 = wp::transpose(var_94);
        var_105 = wp::mul(var_92, var_104);
        // if wp.determinant(polar_rotation) < wp.float64(0.0):                                   <L 497>
        var_106 = wp::determinant(var_105);
        var_107 = 0.0;
        var_108 = (var_106 < var_107);
        if (var_108) {
            // left_basis = wp.matrix_from_cols(                                                  <L 498>
            // wp.vec3d(left_basis[0, 0], left_basis[1, 0], left_basis[2, 0]),                    <L 499>
            var_111 = wp::extract(var_92, var_109, var_110);
            var_114 = wp::extract(var_92, var_112, var_113);
            var_117 = wp::extract(var_92, var_115, var_116);
            var_118 = wp::vec_t<3, wp::float64>(var_111, var_114, var_117);
            // wp.vec3d(left_basis[0, 1], left_basis[1, 1], left_basis[2, 1]),                    <L 500>
            var_121 = wp::extract(var_92, var_119, var_120);
            var_124 = wp::extract(var_92, var_122, var_123);
            var_127 = wp::extract(var_92, var_125, var_126);
            var_128 = wp::vec_t<3, wp::float64>(var_121, var_124, var_127);
            // -wp.vec3d(left_basis[0, 2], left_basis[1, 2], left_basis[2, 2]),                   <L 501>
            var_131 = wp::extract(var_92, var_129, var_130);
            var_134 = wp::extract(var_92, var_132, var_133);
            var_137 = wp::extract(var_92, var_135, var_136);
            var_138 = wp::vec_t<3, wp::float64>(var_131, var_134, var_137);
            var_139 = wp::neg(var_138);
            var_140 = wp::matrix_from_cols<wp::float64>(var_118, var_128, var_139);
            // polar_rotation = left_basis * wp.transpose(right_basis)                            <L 503>
            var_141 = wp::transpose(var_94);
            var_142 = wp::mul(var_140, var_141);
        }
        var_143 = wp::where(var_108, var_140, var_92);
        var_144 = wp::where(var_108, var_142, var_105);
        // rotation = wp.quat(wp.quat_from_matrix(polar_rotation))                                <L 505>
        var_145 = wp::quat_from_matrix(var_144);
        var_146 = wp::quat_t<wp::float32>(var_145);
        // polar_rotation32 = wp.mat33(polar_rotation)                                            <L 506>
        var_147 = wp::mat_t<3, 3, wp::float32>(var_144);
        // previous_rotation = wp.transform_get_rotation(body_q[body])                            <L 507>
        var_148 = wp::address(var_body_q, var_9);
        var_150 = wp::load(var_148);
        var_149 = wp::transform_get_rotation(var_150);
        // quaternion_dot = (                                                                     <L 508>
        // rotation[0] * previous_rotation[0]                                                     <L 509>
        var_152 = wp::extract(var_146, var_151);
        var_154 = wp::extract(var_149, var_153);
        var_155 = wp::mul(var_152, var_154);
        // + rotation[1] * previous_rotation[1]                                                   <L 510>
        var_157 = wp::extract(var_146, var_156);
        var_159 = wp::extract(var_149, var_158);
        var_160 = wp::mul(var_157, var_159);
        var_161 = wp::add(var_155, var_160);
        // + rotation[2] * previous_rotation[2]                                                   <L 511>
        var_163 = wp::extract(var_146, var_162);
        var_165 = wp::extract(var_149, var_164);
        var_166 = wp::mul(var_163, var_165);
        var_167 = wp::add(var_161, var_166);
        // + rotation[3] * previous_rotation[3]                                                   <L 512>
        var_169 = wp::extract(var_146, var_168);
        var_171 = wp::extract(var_149, var_170);
        var_172 = wp::mul(var_169, var_171);
        var_173 = wp::add(var_167, var_172);
        // if quaternion_dot < 0.0:                                                               <L 517>
        var_175 = (var_173 < var_174);
        if (var_175) {
            // rotation = wp.quat(-rotation[0], -rotation[1], -rotation[2], -rotation[3])         <L 518>
            var_177 = wp::extract(var_146, var_176);
            var_178 = wp::neg(var_177);
            var_180 = wp::extract(var_146, var_179);
            var_181 = wp::neg(var_180);
            var_183 = wp::extract(var_146, var_182);
            var_184 = wp::neg(var_183);
            var_186 = wp::extract(var_146, var_185);
            var_187 = wp::neg(var_186);
            var_188 = wp::quat_t<wp::float32>(var_178, var_181, var_184, var_187);
        }
        var_189 = wp::where(var_175, var_188, var_146);
        // center_velocity = particle_qd[particle_indices[0]]                                     <L 519>
        var_191 = wp::extract(var_6, var_190);
        var_192 = wp::address(var_particle_qd, var_191);
        var_194 = wp::load(var_192);
        var_193 = wp::copy(var_194);
        // angular_velocity = wp.vec3(0.0)                                                        <L 520>
        var_196 = wp::vec_t<3, wp::float32>(var_195);
        // if inertia_mode != NONE:                                                               <L 521>
        var_198 = (var_inertia_mode != var_197);
        if (var_198) {
            // relative_rotation = wp.quat_inverse(previous_rotation) * rotation                  <L 524>
            var_199 = wp::quat_inverse(var_149);
            var_200 = wp::mul(var_199, var_189);
            // if relative_rotation[3] < 0.0:                                                     <L 525>
            var_202 = wp::extract(var_200, var_201);
            var_204 = (var_202 < var_203);
            if (var_204) {
                // relative_rotation = wp.quat(                                                   <L 526>
                // -relative_rotation[0],                                                         <L 527>
                var_206 = wp::extract(var_200, var_205);
                var_207 = wp::neg(var_206);
                // -relative_rotation[1],                                                         <L 528>
                var_209 = wp::extract(var_200, var_208);
                var_210 = wp::neg(var_209);
                // -relative_rotation[2],                                                         <L 529>
                var_212 = wp::extract(var_200, var_211);
                var_213 = wp::neg(var_212);
                // -relative_rotation[3],                                                         <L 530>
                var_215 = wp::extract(var_200, var_214);
                var_216 = wp::neg(var_215);
                var_217 = wp::quat_t<wp::float32>(var_207, var_210, var_213, var_216);
            }
            var_218 = wp::where(var_204, var_217, var_200);
            // next_body_angular_velocity = recover_rigid_body_end_velocity(                      <L 532>
            // inertia,                                                                           <L 533>
            // wp.quat_to_matrix(relative_rotation),                                              <L 534>
            var_219 = wp::quat_to_matrix(var_218);
            // dt,                                                                                <L 535>
            // inertia_mode,                                                                      <L 536>
            var_220 = recover_rigid_body_end_velocity_0(var_30, var_219, var_dt, var_inertia_mode);
            // angular_velocity = wp.quat_rotate(rotation, next_body_angular_velocity)            <L 538>
            var_221 = wp::quat_rotate(var_189, var_220);
        }
        if (!var_198) {
            // velocity_gradient = wp.matrix_from_cols(                                           <L 543>
            // particle_qd[particle_indices[1]],                                                  <L 544>
            var_223 = wp::extract(var_6, var_222);
            var_224 = wp::address(var_particle_qd, var_223);
            // particle_qd[particle_indices[2]],                                                  <L 545>
            var_226 = wp::extract(var_6, var_225);
            var_227 = wp::address(var_particle_qd, var_226);
            // particle_qd[particle_indices[3]],                                                  <L 546>
            var_229 = wp::extract(var_6, var_228);
            var_230 = wp::address(var_particle_qd, var_229);
            var_232 = wp::load(var_224);
            var_233 = wp::load(var_227);
            var_234 = wp::load(var_230);
            var_231 = wp::matrix_from_cols<wp::float32>(var_232, var_233, var_234);
            // coupling = velocity_gradient * second_moment * wp.transpose(polar_rotation32)       <L 548>
            var_235 = wp::mul(var_231, var_38);
            var_236 = wp::transpose(var_147);
            var_237 = wp::mul(var_235, var_236);
            // angular_momentum = wp.vec3(                                                        <L 549>
            // coupling[2, 1] - coupling[1, 2],                                                   <L 550>
            var_240 = wp::extract(var_237, var_238, var_239);
            var_243 = wp::extract(var_237, var_241, var_242);
            var_244 = wp::sub(var_240, var_243);
            // coupling[0, 2] - coupling[2, 0],                                                   <L 551>
            var_247 = wp::extract(var_237, var_245, var_246);
            var_250 = wp::extract(var_237, var_248, var_249);
            var_251 = wp::sub(var_247, var_250);
            // coupling[1, 0] - coupling[0, 1],                                                   <L 552>
            var_254 = wp::extract(var_237, var_252, var_253);
            var_257 = wp::extract(var_237, var_255, var_256);
            var_258 = wp::sub(var_254, var_257);
            var_259 = wp::vec_t<3, wp::float32>(var_244, var_251, var_258);
            // world_inertia = polar_rotation32 * inertia * wp.transpose(polar_rotation32)        <L 554>
            var_260 = wp::mul(var_147, var_30);
            var_261 = wp::transpose(var_147);
            var_262 = wp::mul(var_260, var_261);
            // angular_velocity = wp.inverse(world_inertia) * angular_momentum                    <L 555>
            var_263 = wp::inverse(var_262);
            var_264 = wp::mul(var_263, var_259);
            // x_axis = wp.quat_rotate(rotation, wp.vec3(1.0, 0.0, 0.0))                          <L 561>
            var_268 = wp::vec_t<3, wp::float32>(var_265, var_266, var_267);
            var_269 = wp::quat_rotate(var_189, var_268);
            // y_axis = wp.quat_rotate(rotation, wp.vec3(0.0, 1.0, 0.0))                          <L 562>
            var_273 = wp::vec_t<3, wp::float32>(var_270, var_271, var_272);
            var_274 = wp::quat_rotate(var_189, var_273);
            // z_axis = wp.quat_rotate(rotation, wp.vec3(0.0, 0.0, 1.0))                          <L 563>
            var_278 = wp::vec_t<3, wp::float32>(var_275, var_276, var_277);
            var_279 = wp::quat_rotate(var_189, var_278);
            // particle_qd[particle_indices[0]] = center_velocity                                 <L 564>
            var_281 = wp::extract(var_6, var_280);
            wp::array_store(var_particle_qd, var_281, var_193);
            // particle_qd[particle_indices[1]] = wp.cross(angular_velocity, x_axis)              <L 565>
            var_282 = wp::cross(var_264, var_269);
            var_284 = wp::extract(var_6, var_283);
            wp::array_store(var_particle_qd, var_284, var_282);
            // particle_qd[particle_indices[2]] = wp.cross(angular_velocity, y_axis)              <L 566>
            var_285 = wp::cross(var_264, var_274);
            var_287 = wp::extract(var_6, var_286);
            wp::array_store(var_particle_qd, var_287, var_285);
            // particle_qd[particle_indices[3]] = wp.cross(angular_velocity, z_axis)              <L 567>
            var_288 = wp::cross(var_264, var_279);
            var_290 = wp::extract(var_6, var_289);
            wp::array_store(var_particle_qd, var_290, var_288);
        }
        var_291 = wp::where(var_198, var_221, var_264);
        // body_q[body] = wp.transform(                                                           <L 568>
        // origin - wp.quat_rotate(rotation, body_com[body]), rotation                            <L 569>
        var_292 = wp::address(var_body_com, var_9);
        var_294 = wp::load(var_292);
        var_293 = wp::quat_rotate(var_189, var_294);
        var_295 = wp::sub(var_14, var_293);
        var_296 = wp::transform_t<wp::float32>(var_295, var_189);
        // body_q[body] = wp.transform(                                                           <L 568>
        wp::array_store(var_body_q, var_9, var_296);
        // body_qd[body] = wp.spatial_vector(center_velocity, angular_velocity)                   <L 571>
        var_297 = wp::vec_t<6, wp::float32>(var_193, var_291);
        wp::array_store(var_body_qd, var_9, var_297);
    }
}



extern "C" __global__ void _update_affine_body_poses_cda05b4e_cuda_kernel_backward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_q,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_qd,
    wp::array_t<wp::vec_t<4, wp::int32>> var_affine_body_indices,
    wp::array_t<wp::int32> var_affine_body_ids,
    wp::array_t<wp::int32> var_fixed_affine_body_flags,
    wp::array_t<wp::vec_t<3, wp::float32>> var_body_com,
    wp::array_t<wp::mat_t<3, 3, wp::float32>> var_affine_body_inertia,
    wp::int32 var_inertia_mode,
    wp::float32 var_dt,
    wp::array_t<wp::transform_t<wp::float32>> var_body_q,
    wp::array_t<wp::vec_t<6, wp::float32>> var_body_qd,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_particle_q,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_particle_qd,
    wp::array_t<wp::vec_t<4, wp::int32>> adj_affine_body_indices,
    wp::array_t<wp::int32> adj_affine_body_ids,
    wp::array_t<wp::int32> adj_fixed_affine_body_flags,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_body_com,
    wp::array_t<wp::mat_t<3, 3, wp::float32>> adj_affine_body_inertia,
    wp::int32 adj_inertia_mode,
    wp::float32 adj_dt,
    wp::array_t<wp::transform_t<wp::float32>> adj_body_q,
    wp::array_t<wp::vec_t<6, wp::float32>> adj_body_qd)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        wp::int32 var_0;
        wp::int32* var_1;
        const wp::int32 var_2 = 0;
        bool var_3;
        wp::int32 var_4;
        wp::vec_t<4, wp::int32>* var_5;
        wp::vec_t<4, wp::int32> var_6;
        wp::vec_t<4, wp::int32> var_7;
        wp::int32* var_8;
        wp::int32 var_9;
        wp::int32 var_10;
        const wp::int32 var_11 = 0;
        wp::int32 var_12;
        wp::vec_t<3, wp::float32>* var_13;
        wp::vec_t<3, wp::float32> var_14;
        wp::vec_t<3, wp::float32> var_15;
        const wp::int32 var_16 = 1;
        wp::int32 var_17;
        wp::vec_t<3, wp::float32>* var_18;
        const wp::int32 var_19 = 2;
        wp::int32 var_20;
        wp::vec_t<3, wp::float32>* var_21;
        const wp::int32 var_22 = 3;
        wp::int32 var_23;
        wp::vec_t<3, wp::float32>* var_24;
        wp::mat_t<3, 3, wp::float32> var_25;
        wp::vec_t<3, wp::float32> var_26;
        wp::vec_t<3, wp::float32> var_27;
        wp::vec_t<3, wp::float32> var_28;
        wp::mat_t<3, 3, wp::float32>* var_29;
        wp::mat_t<3, 3, wp::float32> var_30;
        wp::mat_t<3, 3, wp::float32> var_31;
        const wp::float32 var_32 = 0.5;
        wp::float32 var_33;
        wp::float32 var_34;
        const wp::int32 var_35 = 3;
        wp::mat_t<3, 3, wp::float32> var_36;
        wp::mat_t<3, 3, wp::float32> var_37;
        wp::mat_t<3, 3, wp::float32> var_38;
        wp::mat_t<3, 3, wp::float64> var_39;
        wp::float64 var_40;
        wp::float64 var_41;
        wp::float64 var_42;
        const wp::int32 var_43 = 3;
        wp::mat_t<3, 3, wp::float64> var_44;
        wp::mat_t<3, 3, wp::float64> var_45;
        wp::mat_t<3, 3, wp::float64> var_46;
        wp::mat_t<3, 3, wp::float64> var_47;
        wp::mat_t<3, 3, wp::float64> var_48;
        wp::float64 var_49;
        const wp::int32 var_50 = 0;
        const wp::int32 var_51 = 0;
        wp::float64 var_52;
        wp::float64 var_53;
        wp::float64 var_54;
        const wp::int32 var_55 = 1;
        wp::float64 var_56;
        wp::float64 var_57;
        wp::float64 var_58;
        const wp::int32 var_59 = 2;
        wp::float64 var_60;
        wp::float64 var_61;
        wp::float64 var_62;
        const wp::int32 var_63 = 1;
        const wp::int32 var_64 = 0;
        wp::float64 var_65;
        wp::float64 var_66;
        wp::float64 var_67;
        const wp::int32 var_68 = 1;
        wp::float64 var_69;
        wp::float64 var_70;
        wp::float64 var_71;
        const wp::int32 var_72 = 2;
        wp::float64 var_73;
        wp::float64 var_74;
        wp::float64 var_75;
        const wp::int32 var_76 = 2;
        const wp::int32 var_77 = 0;
        wp::float64 var_78;
        wp::float64 var_79;
        wp::float64 var_80;
        const wp::int32 var_81 = 1;
        wp::float64 var_82;
        wp::float64 var_83;
        wp::float64 var_84;
        const wp::int32 var_85 = 2;
        wp::float64 var_86;
        wp::float64 var_87;
        wp::float64 var_88;
        wp::float64 var_89;
        bool var_90;
        wp::mat_t<3, 3, wp::float64> var_91;
        wp::mat_t<3, 3, wp::float64> var_92;
        wp::vec_t<3, wp::float64> var_93;
        wp::mat_t<3, 3, wp::float64> var_94;
        const wp::int32 var_95 = 2;
        wp::float64 var_96;
        wp::float64 var_97;
        wp::float64 var_98;
        const wp::int32 var_99 = 0;
        wp::float64 var_100;
        wp::float64 var_101;
        wp::float64 var_102;
        bool var_103;
        wp::mat_t<3, 3, wp::float64> var_104;
        wp::mat_t<3, 3, wp::float64> var_105;
        wp::float64 var_106;
        wp::float64 var_107;
        bool var_108;
        const wp::int32 var_109 = 0;
        const wp::int32 var_110 = 0;
        wp::float64 var_111;
        const wp::int32 var_112 = 1;
        const wp::int32 var_113 = 0;
        wp::float64 var_114;
        const wp::int32 var_115 = 2;
        const wp::int32 var_116 = 0;
        wp::float64 var_117;
        wp::vec_t<3, wp::float64> var_118;
        const wp::int32 var_119 = 0;
        const wp::int32 var_120 = 1;
        wp::float64 var_121;
        const wp::int32 var_122 = 1;
        const wp::int32 var_123 = 1;
        wp::float64 var_124;
        const wp::int32 var_125 = 2;
        const wp::int32 var_126 = 1;
        wp::float64 var_127;
        wp::vec_t<3, wp::float64> var_128;
        const wp::int32 var_129 = 0;
        const wp::int32 var_130 = 2;
        wp::float64 var_131;
        const wp::int32 var_132 = 1;
        const wp::int32 var_133 = 2;
        wp::float64 var_134;
        const wp::int32 var_135 = 2;
        const wp::int32 var_136 = 2;
        wp::float64 var_137;
        wp::vec_t<3, wp::float64> var_138;
        wp::vec_t<3, wp::float64> var_139;
        wp::mat_t<3, 3, wp::float64> var_140;
        wp::mat_t<3, 3, wp::float64> var_141;
        wp::mat_t<3, 3, wp::float64> var_142;
        wp::mat_t<3, 3, wp::float64> var_143;
        wp::mat_t<3, 3, wp::float64> var_144;
        wp::quat_t<wp::float64> var_145;
        wp::quat_t<wp::float32> var_146;
        wp::mat_t<3, 3, wp::float32> var_147;
        wp::transform_t<wp::float32>* var_148;
        wp::quat_t<wp::float32> var_149;
        wp::transform_t<wp::float32> var_150;
        const wp::int32 var_151 = 0;
        wp::float32 var_152;
        const wp::int32 var_153 = 0;
        wp::float32 var_154;
        wp::float32 var_155;
        const wp::int32 var_156 = 1;
        wp::float32 var_157;
        const wp::int32 var_158 = 1;
        wp::float32 var_159;
        wp::float32 var_160;
        wp::float32 var_161;
        const wp::int32 var_162 = 2;
        wp::float32 var_163;
        const wp::int32 var_164 = 2;
        wp::float32 var_165;
        wp::float32 var_166;
        wp::float32 var_167;
        const wp::int32 var_168 = 3;
        wp::float32 var_169;
        const wp::int32 var_170 = 3;
        wp::float32 var_171;
        wp::float32 var_172;
        wp::float32 var_173;
        const wp::float32 var_174 = 0.0;
        bool var_175;
        const wp::int32 var_176 = 0;
        wp::float32 var_177;
        wp::float32 var_178;
        const wp::int32 var_179 = 1;
        wp::float32 var_180;
        wp::float32 var_181;
        const wp::int32 var_182 = 2;
        wp::float32 var_183;
        wp::float32 var_184;
        const wp::int32 var_185 = 3;
        wp::float32 var_186;
        wp::float32 var_187;
        wp::quat_t<wp::float32> var_188;
        wp::quat_t<wp::float32> var_189;
        const wp::int32 var_190 = 0;
        wp::int32 var_191;
        wp::vec_t<3, wp::float32>* var_192;
        wp::vec_t<3, wp::float32> var_193;
        wp::vec_t<3, wp::float32> var_194;
        const wp::float32 var_195 = 0.0;
        wp::vec_t<3, wp::float32> var_196;
        const wp::int32 var_197 = 4;
        bool var_198;
        wp::quat_t<wp::float32> var_199;
        wp::quat_t<wp::float32> var_200;
        const wp::int32 var_201 = 3;
        wp::float32 var_202;
        const wp::float32 var_203 = 0.0;
        bool var_204;
        const wp::int32 var_205 = 0;
        wp::float32 var_206;
        wp::float32 var_207;
        const wp::int32 var_208 = 1;
        wp::float32 var_209;
        wp::float32 var_210;
        const wp::int32 var_211 = 2;
        wp::float32 var_212;
        wp::float32 var_213;
        const wp::int32 var_214 = 3;
        wp::float32 var_215;
        wp::float32 var_216;
        wp::quat_t<wp::float32> var_217;
        wp::quat_t<wp::float32> var_218;
        wp::mat_t<3, 3, wp::float32> var_219;
        wp::vec_t<3, wp::float32> var_220;
        wp::vec_t<3, wp::float32> var_221;
        const wp::int32 var_222 = 1;
        wp::int32 var_223;
        wp::vec_t<3, wp::float32>* var_224;
        const wp::int32 var_225 = 2;
        wp::int32 var_226;
        wp::vec_t<3, wp::float32>* var_227;
        const wp::int32 var_228 = 3;
        wp::int32 var_229;
        wp::vec_t<3, wp::float32>* var_230;
        wp::mat_t<3, 3, wp::float32> var_231;
        wp::vec_t<3, wp::float32> var_232;
        wp::vec_t<3, wp::float32> var_233;
        wp::vec_t<3, wp::float32> var_234;
        wp::mat_t<3, 3, wp::float32> var_235;
        wp::mat_t<3, 3, wp::float32> var_236;
        wp::mat_t<3, 3, wp::float32> var_237;
        const wp::int32 var_238 = 2;
        const wp::int32 var_239 = 1;
        wp::float32 var_240;
        const wp::int32 var_241 = 1;
        const wp::int32 var_242 = 2;
        wp::float32 var_243;
        wp::float32 var_244;
        const wp::int32 var_245 = 0;
        const wp::int32 var_246 = 2;
        wp::float32 var_247;
        const wp::int32 var_248 = 2;
        const wp::int32 var_249 = 0;
        wp::float32 var_250;
        wp::float32 var_251;
        const wp::int32 var_252 = 1;
        const wp::int32 var_253 = 0;
        wp::float32 var_254;
        const wp::int32 var_255 = 0;
        const wp::int32 var_256 = 1;
        wp::float32 var_257;
        wp::float32 var_258;
        wp::vec_t<3, wp::float32> var_259;
        wp::mat_t<3, 3, wp::float32> var_260;
        wp::mat_t<3, 3, wp::float32> var_261;
        wp::mat_t<3, 3, wp::float32> var_262;
        wp::mat_t<3, 3, wp::float32> var_263;
        wp::vec_t<3, wp::float32> var_264;
        const wp::float32 var_265 = 1.0;
        const wp::float32 var_266 = 0.0;
        const wp::float32 var_267 = 0.0;
        wp::vec_t<3, wp::float32> var_268;
        wp::vec_t<3, wp::float32> var_269;
        const wp::float32 var_270 = 0.0;
        const wp::float32 var_271 = 1.0;
        const wp::float32 var_272 = 0.0;
        wp::vec_t<3, wp::float32> var_273;
        wp::vec_t<3, wp::float32> var_274;
        const wp::float32 var_275 = 0.0;
        const wp::float32 var_276 = 0.0;
        const wp::float32 var_277 = 1.0;
        wp::vec_t<3, wp::float32> var_278;
        wp::vec_t<3, wp::float32> var_279;
        const wp::int32 var_280 = 0;
        wp::int32 var_281;
        wp::vec_t<3, wp::float32> var_282;
        const wp::int32 var_283 = 1;
        wp::int32 var_284;
        wp::vec_t<3, wp::float32> var_285;
        const wp::int32 var_286 = 2;
        wp::int32 var_287;
        wp::vec_t<3, wp::float32> var_288;
        const wp::int32 var_289 = 3;
        wp::int32 var_290;
        wp::vec_t<3, wp::float32> var_291;
        wp::vec_t<3, wp::float32>* var_292;
        wp::vec_t<3, wp::float32> var_293;
        wp::vec_t<3, wp::float32> var_294;
        wp::vec_t<3, wp::float32> var_295;
        wp::transform_t<wp::float32> var_296;
        wp::vec_t<6, wp::float32> var_297;
        //---------
        // dual vars
        wp::int32 adj_0 = {};
        wp::int32 adj_1 = {};
        wp::int32 adj_2 = {};
        bool adj_3 = {};
        wp::int32 adj_4 = {};
        wp::vec_t<4, wp::int32> adj_5 = {};
        wp::vec_t<4, wp::int32> adj_6 = {};
        wp::vec_t<4, wp::int32> adj_7 = {};
        wp::int32 adj_8 = {};
        wp::int32 adj_9 = {};
        wp::int32 adj_10 = {};
        wp::int32 adj_11 = {};
        wp::int32 adj_12 = {};
        wp::vec_t<3, wp::float32> adj_13 = {};
        wp::vec_t<3, wp::float32> adj_14 = {};
        wp::vec_t<3, wp::float32> adj_15 = {};
        wp::int32 adj_16 = {};
        wp::int32 adj_17 = {};
        wp::vec_t<3, wp::float32> adj_18 = {};
        wp::int32 adj_19 = {};
        wp::int32 adj_20 = {};
        wp::vec_t<3, wp::float32> adj_21 = {};
        wp::int32 adj_22 = {};
        wp::int32 adj_23 = {};
        wp::vec_t<3, wp::float32> adj_24 = {};
        wp::mat_t<3, 3, wp::float32> adj_25 = {};
        wp::vec_t<3, wp::float32> adj_26 = {};
        wp::vec_t<3, wp::float32> adj_27 = {};
        wp::vec_t<3, wp::float32> adj_28 = {};
        wp::mat_t<3, 3, wp::float32> adj_29 = {};
        wp::mat_t<3, 3, wp::float32> adj_30 = {};
        wp::mat_t<3, 3, wp::float32> adj_31 = {};
        wp::float32 adj_32 = {};
        wp::float32 adj_33 = {};
        wp::float32 adj_34 = {};
        wp::int32 adj_35 = {};
        wp::mat_t<3, 3, wp::float32> adj_36 = {};
        wp::mat_t<3, 3, wp::float32> adj_37 = {};
        wp::mat_t<3, 3, wp::float32> adj_38 = {};
        wp::mat_t<3, 3, wp::float64> adj_39 = {};
        wp::float64 adj_40 = {};
        wp::float64 adj_41 = {};
        wp::float64 adj_42 = {};
        wp::int32 adj_43 = {};
        wp::mat_t<3, 3, wp::float64> adj_44 = {};
        wp::mat_t<3, 3, wp::float64> adj_45 = {};
        wp::mat_t<3, 3, wp::float64> adj_46 = {};
        wp::mat_t<3, 3, wp::float64> adj_47 = {};
        wp::mat_t<3, 3, wp::float64> adj_48 = {};
        wp::float64 adj_49 = {};
        wp::int32 adj_50 = {};
        wp::int32 adj_51 = {};
        wp::float64 adj_52 = {};
        wp::float64 adj_53 = {};
        wp::float64 adj_54 = {};
        wp::int32 adj_55 = {};
        wp::float64 adj_56 = {};
        wp::float64 adj_57 = {};
        wp::float64 adj_58 = {};
        wp::int32 adj_59 = {};
        wp::float64 adj_60 = {};
        wp::float64 adj_61 = {};
        wp::float64 adj_62 = {};
        wp::int32 adj_63 = {};
        wp::int32 adj_64 = {};
        wp::float64 adj_65 = {};
        wp::float64 adj_66 = {};
        wp::float64 adj_67 = {};
        wp::int32 adj_68 = {};
        wp::float64 adj_69 = {};
        wp::float64 adj_70 = {};
        wp::float64 adj_71 = {};
        wp::int32 adj_72 = {};
        wp::float64 adj_73 = {};
        wp::float64 adj_74 = {};
        wp::float64 adj_75 = {};
        wp::int32 adj_76 = {};
        wp::int32 adj_77 = {};
        wp::float64 adj_78 = {};
        wp::float64 adj_79 = {};
        wp::float64 adj_80 = {};
        wp::int32 adj_81 = {};
        wp::float64 adj_82 = {};
        wp::float64 adj_83 = {};
        wp::float64 adj_84 = {};
        wp::int32 adj_85 = {};
        wp::float64 adj_86 = {};
        wp::float64 adj_87 = {};
        wp::float64 adj_88 = {};
        wp::float64 adj_89 = {};
        bool adj_90 = {};
        wp::mat_t<3, 3, wp::float64> adj_91 = {};
        wp::mat_t<3, 3, wp::float64> adj_92 = {};
        wp::vec_t<3, wp::float64> adj_93 = {};
        wp::mat_t<3, 3, wp::float64> adj_94 = {};
        wp::int32 adj_95 = {};
        wp::float64 adj_96 = {};
        wp::float64 adj_97 = {};
        wp::float64 adj_98 = {};
        wp::int32 adj_99 = {};
        wp::float64 adj_100 = {};
        wp::float64 adj_101 = {};
        wp::float64 adj_102 = {};
        bool adj_103 = {};
        wp::mat_t<3, 3, wp::float64> adj_104 = {};
        wp::mat_t<3, 3, wp::float64> adj_105 = {};
        wp::float64 adj_106 = {};
        wp::float64 adj_107 = {};
        bool adj_108 = {};
        wp::int32 adj_109 = {};
        wp::int32 adj_110 = {};
        wp::float64 adj_111 = {};
        wp::int32 adj_112 = {};
        wp::int32 adj_113 = {};
        wp::float64 adj_114 = {};
        wp::int32 adj_115 = {};
        wp::int32 adj_116 = {};
        wp::float64 adj_117 = {};
        wp::vec_t<3, wp::float64> adj_118 = {};
        wp::int32 adj_119 = {};
        wp::int32 adj_120 = {};
        wp::float64 adj_121 = {};
        wp::int32 adj_122 = {};
        wp::int32 adj_123 = {};
        wp::float64 adj_124 = {};
        wp::int32 adj_125 = {};
        wp::int32 adj_126 = {};
        wp::float64 adj_127 = {};
        wp::vec_t<3, wp::float64> adj_128 = {};
        wp::int32 adj_129 = {};
        wp::int32 adj_130 = {};
        wp::float64 adj_131 = {};
        wp::int32 adj_132 = {};
        wp::int32 adj_133 = {};
        wp::float64 adj_134 = {};
        wp::int32 adj_135 = {};
        wp::int32 adj_136 = {};
        wp::float64 adj_137 = {};
        wp::vec_t<3, wp::float64> adj_138 = {};
        wp::vec_t<3, wp::float64> adj_139 = {};
        wp::mat_t<3, 3, wp::float64> adj_140 = {};
        wp::mat_t<3, 3, wp::float64> adj_141 = {};
        wp::mat_t<3, 3, wp::float64> adj_142 = {};
        wp::mat_t<3, 3, wp::float64> adj_143 = {};
        wp::mat_t<3, 3, wp::float64> adj_144 = {};
        wp::quat_t<wp::float64> adj_145 = {};
        wp::quat_t<wp::float32> adj_146 = {};
        wp::mat_t<3, 3, wp::float32> adj_147 = {};
        wp::transform_t<wp::float32> adj_148 = {};
        wp::quat_t<wp::float32> adj_149 = {};
        wp::transform_t<wp::float32> adj_150 = {};
        wp::int32 adj_151 = {};
        wp::float32 adj_152 = {};
        wp::int32 adj_153 = {};
        wp::float32 adj_154 = {};
        wp::float32 adj_155 = {};
        wp::int32 adj_156 = {};
        wp::float32 adj_157 = {};
        wp::int32 adj_158 = {};
        wp::float32 adj_159 = {};
        wp::float32 adj_160 = {};
        wp::float32 adj_161 = {};
        wp::int32 adj_162 = {};
        wp::float32 adj_163 = {};
        wp::int32 adj_164 = {};
        wp::float32 adj_165 = {};
        wp::float32 adj_166 = {};
        wp::float32 adj_167 = {};
        wp::int32 adj_168 = {};
        wp::float32 adj_169 = {};
        wp::int32 adj_170 = {};
        wp::float32 adj_171 = {};
        wp::float32 adj_172 = {};
        wp::float32 adj_173 = {};
        wp::float32 adj_174 = {};
        bool adj_175 = {};
        wp::int32 adj_176 = {};
        wp::float32 adj_177 = {};
        wp::float32 adj_178 = {};
        wp::int32 adj_179 = {};
        wp::float32 adj_180 = {};
        wp::float32 adj_181 = {};
        wp::int32 adj_182 = {};
        wp::float32 adj_183 = {};
        wp::float32 adj_184 = {};
        wp::int32 adj_185 = {};
        wp::float32 adj_186 = {};
        wp::float32 adj_187 = {};
        wp::quat_t<wp::float32> adj_188 = {};
        wp::quat_t<wp::float32> adj_189 = {};
        wp::int32 adj_190 = {};
        wp::int32 adj_191 = {};
        wp::vec_t<3, wp::float32> adj_192 = {};
        wp::vec_t<3, wp::float32> adj_193 = {};
        wp::vec_t<3, wp::float32> adj_194 = {};
        wp::float32 adj_195 = {};
        wp::vec_t<3, wp::float32> adj_196 = {};
        wp::int32 adj_197 = {};
        bool adj_198 = {};
        wp::quat_t<wp::float32> adj_199 = {};
        wp::quat_t<wp::float32> adj_200 = {};
        wp::int32 adj_201 = {};
        wp::float32 adj_202 = {};
        wp::float32 adj_203 = {};
        bool adj_204 = {};
        wp::int32 adj_205 = {};
        wp::float32 adj_206 = {};
        wp::float32 adj_207 = {};
        wp::int32 adj_208 = {};
        wp::float32 adj_209 = {};
        wp::float32 adj_210 = {};
        wp::int32 adj_211 = {};
        wp::float32 adj_212 = {};
        wp::float32 adj_213 = {};
        wp::int32 adj_214 = {};
        wp::float32 adj_215 = {};
        wp::float32 adj_216 = {};
        wp::quat_t<wp::float32> adj_217 = {};
        wp::quat_t<wp::float32> adj_218 = {};
        wp::mat_t<3, 3, wp::float32> adj_219 = {};
        wp::vec_t<3, wp::float32> adj_220 = {};
        wp::vec_t<3, wp::float32> adj_221 = {};
        wp::int32 adj_222 = {};
        wp::int32 adj_223 = {};
        wp::vec_t<3, wp::float32> adj_224 = {};
        wp::int32 adj_225 = {};
        wp::int32 adj_226 = {};
        wp::vec_t<3, wp::float32> adj_227 = {};
        wp::int32 adj_228 = {};
        wp::int32 adj_229 = {};
        wp::vec_t<3, wp::float32> adj_230 = {};
        wp::mat_t<3, 3, wp::float32> adj_231 = {};
        wp::vec_t<3, wp::float32> adj_232 = {};
        wp::vec_t<3, wp::float32> adj_233 = {};
        wp::vec_t<3, wp::float32> adj_234 = {};
        wp::mat_t<3, 3, wp::float32> adj_235 = {};
        wp::mat_t<3, 3, wp::float32> adj_236 = {};
        wp::mat_t<3, 3, wp::float32> adj_237 = {};
        wp::int32 adj_238 = {};
        wp::int32 adj_239 = {};
        wp::float32 adj_240 = {};
        wp::int32 adj_241 = {};
        wp::int32 adj_242 = {};
        wp::float32 adj_243 = {};
        wp::float32 adj_244 = {};
        wp::int32 adj_245 = {};
        wp::int32 adj_246 = {};
        wp::float32 adj_247 = {};
        wp::int32 adj_248 = {};
        wp::int32 adj_249 = {};
        wp::float32 adj_250 = {};
        wp::float32 adj_251 = {};
        wp::int32 adj_252 = {};
        wp::int32 adj_253 = {};
        wp::float32 adj_254 = {};
        wp::int32 adj_255 = {};
        wp::int32 adj_256 = {};
        wp::float32 adj_257 = {};
        wp::float32 adj_258 = {};
        wp::vec_t<3, wp::float32> adj_259 = {};
        wp::mat_t<3, 3, wp::float32> adj_260 = {};
        wp::mat_t<3, 3, wp::float32> adj_261 = {};
        wp::mat_t<3, 3, wp::float32> adj_262 = {};
        wp::mat_t<3, 3, wp::float32> adj_263 = {};
        wp::vec_t<3, wp::float32> adj_264 = {};
        wp::float32 adj_265 = {};
        wp::float32 adj_266 = {};
        wp::float32 adj_267 = {};
        wp::vec_t<3, wp::float32> adj_268 = {};
        wp::vec_t<3, wp::float32> adj_269 = {};
        wp::float32 adj_270 = {};
        wp::float32 adj_271 = {};
        wp::float32 adj_272 = {};
        wp::vec_t<3, wp::float32> adj_273 = {};
        wp::vec_t<3, wp::float32> adj_274 = {};
        wp::float32 adj_275 = {};
        wp::float32 adj_276 = {};
        wp::float32 adj_277 = {};
        wp::vec_t<3, wp::float32> adj_278 = {};
        wp::vec_t<3, wp::float32> adj_279 = {};
        wp::int32 adj_280 = {};
        wp::int32 adj_281 = {};
        wp::vec_t<3, wp::float32> adj_282 = {};
        wp::int32 adj_283 = {};
        wp::int32 adj_284 = {};
        wp::vec_t<3, wp::float32> adj_285 = {};
        wp::int32 adj_286 = {};
        wp::int32 adj_287 = {};
        wp::vec_t<3, wp::float32> adj_288 = {};
        wp::int32 adj_289 = {};
        wp::int32 adj_290 = {};
        wp::vec_t<3, wp::float32> adj_291 = {};
        wp::vec_t<3, wp::float32> adj_292 = {};
        wp::vec_t<3, wp::float32> adj_293 = {};
        wp::vec_t<3, wp::float32> adj_294 = {};
        wp::vec_t<3, wp::float32> adj_295 = {};
        wp::transform_t<wp::float32> adj_296 = {};
        wp::vec_t<6, wp::float32> adj_297 = {};
        //---------
        // forward
        // def _update_affine_body_poses(                                                         <L 446>
        // affine_body = wp.tid()                                                                 <L 460>
        var_0 = builtin_tid1d();
        // if fixed_affine_body_flags[affine_body] != 0:                                          <L 461>
        var_1 = wp::address(var_fixed_affine_body_flags, var_0);
        var_4 = wp::load(var_1);
        var_3 = (var_4 != var_2);
        if (var_3) {
            // return                                                                             <L 462>
            goto label0;
        }
        // particle_indices = affine_body_indices[affine_body]                                    <L 463>
        var_5 = wp::address(var_affine_body_indices, var_0);
        var_7 = wp::load(var_5);
        var_6 = wp::copy(var_7);
        // body = affine_body_ids[affine_body]                                                    <L 464>
        var_8 = wp::address(var_affine_body_ids, var_0);
        var_10 = wp::load(var_8);
        var_9 = wp::copy(var_10);
        // origin = particle_q[particle_indices[0]]                                               <L 465>
        var_12 = wp::extract(var_6, var_11);
        var_13 = wp::address(var_particle_q, var_12);
        var_15 = wp::load(var_13);
        var_14 = wp::copy(var_15);
        // affine_matrix = wp.matrix_from_cols(                                                   <L 467>
        // particle_q[particle_indices[1]],                                                       <L 468>
        var_17 = wp::extract(var_6, var_16);
        var_18 = wp::address(var_particle_q, var_17);
        // particle_q[particle_indices[2]],                                                       <L 469>
        var_20 = wp::extract(var_6, var_19);
        var_21 = wp::address(var_particle_q, var_20);
        // particle_q[particle_indices[3]],                                                       <L 470>
        var_23 = wp::extract(var_6, var_22);
        var_24 = wp::address(var_particle_q, var_23);
        var_26 = wp::load(var_18);
        var_27 = wp::load(var_21);
        var_28 = wp::load(var_24);
        var_25 = wp::matrix_from_cols<wp::float32>(var_26, var_27, var_28);
        // inertia = affine_body_inertia[affine_body]                                             <L 475>
        var_29 = wp::address(var_affine_body_inertia, var_0);
        var_31 = wp::load(var_29);
        var_30 = wp::copy(var_31);
        // second_moment = 0.5 * wp.trace(inertia) * wp.identity(3, dtype=float) - inertia        <L 476>
        var_33 = wp::trace(var_30);
        var_34 = wp::mul(var_32, var_33);
        var_36 = wp::identity<3, wp::float32>();
        var_37 = wp::mul(var_34, var_36);
        var_38 = wp::sub(var_37, var_30);
        // inertia64 = wp.mat33d(inertia)                                                         <L 480>
        var_39 = wp::mat_t<3, 3, wp::float64>(var_30);
        // second_moment64 = wp.float64(0.5) * wp.trace(inertia64) * wp.identity(3, dtype=wp.float64) - inertia64       <L 481>
        var_40 = 0.5;
        var_41 = wp::trace(var_39);
        var_42 = wp::mul(var_40, var_41);
        var_44 = wp::identity<3, wp::float64>();
        var_45 = wp::mul(var_42, var_44);
        var_46 = wp::sub(var_45, var_39);
        // weighted_affine_matrix = wp.mat33d(affine_matrix) * second_moment64                    <L 482>
        var_47 = wp::mat_t<3, 3, wp::float64>(var_25);
        var_48 = wp::mul(var_47, var_46);
        // matrix_scale = wp.float64(0.0)                                                         <L 486>
        var_49 = 0.0;
        // for row in range(3):                                                                   <L 487>
        // for column in range(3):                                                                <L 488>
        // matrix_scale = wp.max(matrix_scale, wp.abs(weighted_affine_matrix[row, column]))       <L 489>
        var_52 = wp::extract(var_48, var_50, var_51);
        var_53 = wp::abs(var_52);
        var_54 = wp::max(var_49, var_53);
        var_56 = wp::extract(var_48, var_50, var_55);
        var_57 = wp::abs(var_56);
        var_58 = wp::max(var_54, var_57);
        var_60 = wp::extract(var_48, var_50, var_59);
        var_61 = wp::abs(var_60);
        var_62 = wp::max(var_58, var_61);
        // for column in range(3):                                                                <L 488>
        // matrix_scale = wp.max(matrix_scale, wp.abs(weighted_affine_matrix[row, column]))       <L 489>
        var_65 = wp::extract(var_48, var_63, var_64);
        var_66 = wp::abs(var_65);
        var_67 = wp::max(var_62, var_66);
        var_69 = wp::extract(var_48, var_63, var_68);
        var_70 = wp::abs(var_69);
        var_71 = wp::max(var_67, var_70);
        var_73 = wp::extract(var_48, var_63, var_72);
        var_74 = wp::abs(var_73);
        var_75 = wp::max(var_71, var_74);
        // for column in range(3):                                                                <L 488>
        // matrix_scale = wp.max(matrix_scale, wp.abs(weighted_affine_matrix[row, column]))       <L 489>
        var_78 = wp::extract(var_48, var_76, var_77);
        var_79 = wp::abs(var_78);
        var_80 = wp::max(var_75, var_79);
        var_82 = wp::extract(var_48, var_76, var_81);
        var_83 = wp::abs(var_82);
        var_84 = wp::max(var_80, var_83);
        var_86 = wp::extract(var_48, var_76, var_85);
        var_87 = wp::abs(var_86);
        var_88 = wp::max(var_84, var_87);
        // if matrix_scale <= wp.float64(0.0):                                                    <L 490>
        var_89 = 0.0;
        var_90 = (var_88 <= var_89);
        if (var_90) {
            // return                                                                             <L 491>
            goto label1;
        }
        // left_basis, singular_values, right_basis = wp.svd3(weighted_affine_matrix / matrix_scale)       <L 492>
        var_91 = wp::div(var_48, var_88);
        wp::svd3(var_91, var_92, var_93, var_94);
        // if wp.abs(singular_values[2]) <= wp.float64(1.0e-8) * wp.abs(singular_values[0]):       <L 493>
        var_96 = wp::extract(var_93, var_95);
        var_97 = wp::abs(var_96);
        var_98 = 1e-08;
        var_100 = wp::extract(var_93, var_99);
        var_101 = wp::abs(var_100);
        var_102 = wp::mul(var_98, var_101);
        var_103 = (var_97 <= var_102);
        if (var_103) {
            // return                                                                             <L 494>
            goto label2;
        }
        // polar_rotation = left_basis * wp.transpose(right_basis)                                <L 496>
        var_104 = wp::transpose(var_94);
        var_105 = wp::mul(var_92, var_104);
        // if wp.determinant(polar_rotation) < wp.float64(0.0):                                   <L 497>
        var_106 = wp::determinant(var_105);
        var_107 = 0.0;
        var_108 = (var_106 < var_107);
        if (var_108) {
            // left_basis = wp.matrix_from_cols(                                                  <L 498>
            // wp.vec3d(left_basis[0, 0], left_basis[1, 0], left_basis[2, 0]),                    <L 499>
            var_111 = wp::extract(var_92, var_109, var_110);
            var_114 = wp::extract(var_92, var_112, var_113);
            var_117 = wp::extract(var_92, var_115, var_116);
            var_118 = wp::vec_t<3, wp::float64>(var_111, var_114, var_117);
            // wp.vec3d(left_basis[0, 1], left_basis[1, 1], left_basis[2, 1]),                    <L 500>
            var_121 = wp::extract(var_92, var_119, var_120);
            var_124 = wp::extract(var_92, var_122, var_123);
            var_127 = wp::extract(var_92, var_125, var_126);
            var_128 = wp::vec_t<3, wp::float64>(var_121, var_124, var_127);
            // -wp.vec3d(left_basis[0, 2], left_basis[1, 2], left_basis[2, 2]),                   <L 501>
            var_131 = wp::extract(var_92, var_129, var_130);
            var_134 = wp::extract(var_92, var_132, var_133);
            var_137 = wp::extract(var_92, var_135, var_136);
            var_138 = wp::vec_t<3, wp::float64>(var_131, var_134, var_137);
            var_139 = wp::neg(var_138);
            var_140 = wp::matrix_from_cols<wp::float64>(var_118, var_128, var_139);
            // polar_rotation = left_basis * wp.transpose(right_basis)                            <L 503>
            var_141 = wp::transpose(var_94);
            var_142 = wp::mul(var_140, var_141);
        }
        var_143 = wp::where(var_108, var_140, var_92);
        var_144 = wp::where(var_108, var_142, var_105);
        // rotation = wp.quat(wp.quat_from_matrix(polar_rotation))                                <L 505>
        var_145 = wp::quat_from_matrix(var_144);
        var_146 = wp::quat_t<wp::float32>(var_145);
        // polar_rotation32 = wp.mat33(polar_rotation)                                            <L 506>
        var_147 = wp::mat_t<3, 3, wp::float32>(var_144);
        // previous_rotation = wp.transform_get_rotation(body_q[body])                            <L 507>
        var_148 = wp::address(var_body_q, var_9);
        var_150 = wp::load(var_148);
        var_149 = wp::transform_get_rotation(var_150);
        // quaternion_dot = (                                                                     <L 508>
        // rotation[0] * previous_rotation[0]                                                     <L 509>
        var_152 = wp::extract(var_146, var_151);
        var_154 = wp::extract(var_149, var_153);
        var_155 = wp::mul(var_152, var_154);
        // + rotation[1] * previous_rotation[1]                                                   <L 510>
        var_157 = wp::extract(var_146, var_156);
        var_159 = wp::extract(var_149, var_158);
        var_160 = wp::mul(var_157, var_159);
        var_161 = wp::add(var_155, var_160);
        // + rotation[2] * previous_rotation[2]                                                   <L 511>
        var_163 = wp::extract(var_146, var_162);
        var_165 = wp::extract(var_149, var_164);
        var_166 = wp::mul(var_163, var_165);
        var_167 = wp::add(var_161, var_166);
        // + rotation[3] * previous_rotation[3]                                                   <L 512>
        var_169 = wp::extract(var_146, var_168);
        var_171 = wp::extract(var_149, var_170);
        var_172 = wp::mul(var_169, var_171);
        var_173 = wp::add(var_167, var_172);
        // if quaternion_dot < 0.0:                                                               <L 517>
        var_175 = (var_173 < var_174);
        if (var_175) {
            // rotation = wp.quat(-rotation[0], -rotation[1], -rotation[2], -rotation[3])         <L 518>
            var_177 = wp::extract(var_146, var_176);
            var_178 = wp::neg(var_177);
            var_180 = wp::extract(var_146, var_179);
            var_181 = wp::neg(var_180);
            var_183 = wp::extract(var_146, var_182);
            var_184 = wp::neg(var_183);
            var_186 = wp::extract(var_146, var_185);
            var_187 = wp::neg(var_186);
            var_188 = wp::quat_t<wp::float32>(var_178, var_181, var_184, var_187);
        }
        var_189 = wp::where(var_175, var_188, var_146);
        // center_velocity = particle_qd[particle_indices[0]]                                     <L 519>
        var_191 = wp::extract(var_6, var_190);
        var_192 = wp::address(var_particle_qd, var_191);
        var_194 = wp::load(var_192);
        var_193 = wp::copy(var_194);
        // angular_velocity = wp.vec3(0.0)                                                        <L 520>
        var_196 = wp::vec_t<3, wp::float32>(var_195);
        // if inertia_mode != NONE:                                                               <L 521>
        var_198 = (var_inertia_mode != var_197);
        if (var_198) {
            // relative_rotation = wp.quat_inverse(previous_rotation) * rotation                  <L 524>
            var_199 = wp::quat_inverse(var_149);
            var_200 = wp::mul(var_199, var_189);
            // if relative_rotation[3] < 0.0:                                                     <L 525>
            var_202 = wp::extract(var_200, var_201);
            var_204 = (var_202 < var_203);
            if (var_204) {
                // relative_rotation = wp.quat(                                                   <L 526>
                // -relative_rotation[0],                                                         <L 527>
                var_206 = wp::extract(var_200, var_205);
                var_207 = wp::neg(var_206);
                // -relative_rotation[1],                                                         <L 528>
                var_209 = wp::extract(var_200, var_208);
                var_210 = wp::neg(var_209);
                // -relative_rotation[2],                                                         <L 529>
                var_212 = wp::extract(var_200, var_211);
                var_213 = wp::neg(var_212);
                // -relative_rotation[3],                                                         <L 530>
                var_215 = wp::extract(var_200, var_214);
                var_216 = wp::neg(var_215);
                var_217 = wp::quat_t<wp::float32>(var_207, var_210, var_213, var_216);
            }
            var_218 = wp::where(var_204, var_217, var_200);
            // next_body_angular_velocity = recover_rigid_body_end_velocity(                      <L 532>
            // inertia,                                                                           <L 533>
            // wp.quat_to_matrix(relative_rotation),                                              <L 534>
            var_219 = wp::quat_to_matrix(var_218);
            // dt,                                                                                <L 535>
            // inertia_mode,                                                                      <L 536>
            var_220 = recover_rigid_body_end_velocity_0(var_30, var_219, var_dt, var_inertia_mode);
            // angular_velocity = wp.quat_rotate(rotation, next_body_angular_velocity)            <L 538>
            var_221 = wp::quat_rotate(var_189, var_220);
        }
        if (!var_198) {
            // velocity_gradient = wp.matrix_from_cols(                                           <L 543>
            // particle_qd[particle_indices[1]],                                                  <L 544>
            var_223 = wp::extract(var_6, var_222);
            var_224 = wp::address(var_particle_qd, var_223);
            // particle_qd[particle_indices[2]],                                                  <L 545>
            var_226 = wp::extract(var_6, var_225);
            var_227 = wp::address(var_particle_qd, var_226);
            // particle_qd[particle_indices[3]],                                                  <L 546>
            var_229 = wp::extract(var_6, var_228);
            var_230 = wp::address(var_particle_qd, var_229);
            var_232 = wp::load(var_224);
            var_233 = wp::load(var_227);
            var_234 = wp::load(var_230);
            var_231 = wp::matrix_from_cols<wp::float32>(var_232, var_233, var_234);
            // coupling = velocity_gradient * second_moment * wp.transpose(polar_rotation32)       <L 548>
            var_235 = wp::mul(var_231, var_38);
            var_236 = wp::transpose(var_147);
            var_237 = wp::mul(var_235, var_236);
            // angular_momentum = wp.vec3(                                                        <L 549>
            // coupling[2, 1] - coupling[1, 2],                                                   <L 550>
            var_240 = wp::extract(var_237, var_238, var_239);
            var_243 = wp::extract(var_237, var_241, var_242);
            var_244 = wp::sub(var_240, var_243);
            // coupling[0, 2] - coupling[2, 0],                                                   <L 551>
            var_247 = wp::extract(var_237, var_245, var_246);
            var_250 = wp::extract(var_237, var_248, var_249);
            var_251 = wp::sub(var_247, var_250);
            // coupling[1, 0] - coupling[0, 1],                                                   <L 552>
            var_254 = wp::extract(var_237, var_252, var_253);
            var_257 = wp::extract(var_237, var_255, var_256);
            var_258 = wp::sub(var_254, var_257);
            var_259 = wp::vec_t<3, wp::float32>(var_244, var_251, var_258);
            // world_inertia = polar_rotation32 * inertia * wp.transpose(polar_rotation32)        <L 554>
            var_260 = wp::mul(var_147, var_30);
            var_261 = wp::transpose(var_147);
            var_262 = wp::mul(var_260, var_261);
            // angular_velocity = wp.inverse(world_inertia) * angular_momentum                    <L 555>
            var_263 = wp::inverse(var_262);
            var_264 = wp::mul(var_263, var_259);
            // x_axis = wp.quat_rotate(rotation, wp.vec3(1.0, 0.0, 0.0))                          <L 561>
            var_268 = wp::vec_t<3, wp::float32>(var_265, var_266, var_267);
            var_269 = wp::quat_rotate(var_189, var_268);
            // y_axis = wp.quat_rotate(rotation, wp.vec3(0.0, 1.0, 0.0))                          <L 562>
            var_273 = wp::vec_t<3, wp::float32>(var_270, var_271, var_272);
            var_274 = wp::quat_rotate(var_189, var_273);
            // z_axis = wp.quat_rotate(rotation, wp.vec3(0.0, 0.0, 1.0))                          <L 563>
            var_278 = wp::vec_t<3, wp::float32>(var_275, var_276, var_277);
            var_279 = wp::quat_rotate(var_189, var_278);
            // particle_qd[particle_indices[0]] = center_velocity                                 <L 564>
            var_281 = wp::extract(var_6, var_280);
            // wp::array_store(var_particle_qd, var_281, var_193);
            // particle_qd[particle_indices[1]] = wp.cross(angular_velocity, x_axis)              <L 565>
            var_282 = wp::cross(var_264, var_269);
            var_284 = wp::extract(var_6, var_283);
            // wp::array_store(var_particle_qd, var_284, var_282);
            // particle_qd[particle_indices[2]] = wp.cross(angular_velocity, y_axis)              <L 566>
            var_285 = wp::cross(var_264, var_274);
            var_287 = wp::extract(var_6, var_286);
            // wp::array_store(var_particle_qd, var_287, var_285);
            // particle_qd[particle_indices[3]] = wp.cross(angular_velocity, z_axis)              <L 567>
            var_288 = wp::cross(var_264, var_279);
            var_290 = wp::extract(var_6, var_289);
            // wp::array_store(var_particle_qd, var_290, var_288);
        }
        var_291 = wp::where(var_198, var_221, var_264);
        // body_q[body] = wp.transform(                                                           <L 568>
        // origin - wp.quat_rotate(rotation, body_com[body]), rotation                            <L 569>
        var_292 = wp::address(var_body_com, var_9);
        var_294 = wp::load(var_292);
        var_293 = wp::quat_rotate(var_189, var_294);
        var_295 = wp::sub(var_14, var_293);
        var_296 = wp::transform_t<wp::float32>(var_295, var_189);
        // body_q[body] = wp.transform(                                                           <L 568>
        // wp::array_store(var_body_q, var_9, var_296);
        // body_qd[body] = wp.spatial_vector(center_velocity, angular_velocity)                   <L 571>
        var_297 = wp::vec_t<6, wp::float32>(var_193, var_291);
        // wp::array_store(var_body_qd, var_9, var_297);
        //---------
        // reverse
        wp::adj_array_store(var_body_qd, var_9, var_297, adj_body_qd, adj_9, adj_297);
        wp::adj_vec_t(var_193, var_291, adj_193, adj_291, adj_297);
        // adj: body_qd[body] = wp.spatial_vector(center_velocity, angular_velocity)              <L 571>
        wp::adj_array_store(var_body_q, var_9, var_296, adj_body_q, adj_9, adj_296);
        // adj: body_q[body] = wp.transform(                                                      <L 568>
        wp::adj_transform_t(var_295, var_189, adj_295, adj_189, adj_296);
        wp::adj_sub(var_14, var_293, adj_14, adj_293, adj_295);
        wp::adj_quat_rotate(var_189, var_294, adj_189, adj_292, adj_293);
        wp::adj_address(var_body_com, var_9, adj_body_com, adj_9, adj_292);
        // adj: origin - wp.quat_rotate(rotation, body_com[body]), rotation                       <L 569>
        // adj: body_q[body] = wp.transform(                                                      <L 568>
        wp::adj_where(var_198, var_221, var_264, adj_198, adj_221, adj_264, adj_291);
        if (!var_198) {
            wp::adj_array_store(var_particle_qd, var_290, var_288, adj_particle_qd, adj_290, adj_288);
            wp::adj_extract(var_6, var_289, adj_6, adj_289, adj_290);
            wp::adj_cross(var_264, var_279, adj_264, adj_279, adj_288);
            // adj: particle_qd[particle_indices[3]] = wp.cross(angular_velocity, z_axis)         <L 567>
            wp::adj_array_store(var_particle_qd, var_287, var_285, adj_particle_qd, adj_287, adj_285);
            wp::adj_extract(var_6, var_286, adj_6, adj_286, adj_287);
            wp::adj_cross(var_264, var_274, adj_264, adj_274, adj_285);
            // adj: particle_qd[particle_indices[2]] = wp.cross(angular_velocity, y_axis)         <L 566>
            wp::adj_array_store(var_particle_qd, var_284, var_282, adj_particle_qd, adj_284, adj_282);
            wp::adj_extract(var_6, var_283, adj_6, adj_283, adj_284);
            wp::adj_cross(var_264, var_269, adj_264, adj_269, adj_282);
            // adj: particle_qd[particle_indices[1]] = wp.cross(angular_velocity, x_axis)         <L 565>
            wp::adj_array_store(var_particle_qd, var_281, var_193, adj_particle_qd, adj_281, adj_193);
            wp::adj_extract(var_6, var_280, adj_6, adj_280, adj_281);
            // adj: particle_qd[particle_indices[0]] = center_velocity                            <L 564>
            wp::adj_quat_rotate(var_189, var_278, adj_189, adj_278, adj_279);
            wp::adj_vec_t(var_275, var_276, var_277, adj_275, adj_276, adj_277, adj_278);
            // adj: z_axis = wp.quat_rotate(rotation, wp.vec3(0.0, 0.0, 1.0))                     <L 563>
            wp::adj_quat_rotate(var_189, var_273, adj_189, adj_273, adj_274);
            wp::adj_vec_t(var_270, var_271, var_272, adj_270, adj_271, adj_272, adj_273);
            // adj: y_axis = wp.quat_rotate(rotation, wp.vec3(0.0, 1.0, 0.0))                     <L 562>
            wp::adj_quat_rotate(var_189, var_268, adj_189, adj_268, adj_269);
            wp::adj_vec_t(var_265, var_266, var_267, adj_265, adj_266, adj_267, adj_268);
            // adj: x_axis = wp.quat_rotate(rotation, wp.vec3(1.0, 0.0, 0.0))                     <L 561>
            wp::adj_mul(var_263, var_259, adj_263, adj_259, adj_264);
            wp::adj_inverse(var_262, var_263, adj_262, adj_263);
            // adj: angular_velocity = wp.inverse(world_inertia) * angular_momentum               <L 555>
            wp::adj_mul(var_260, var_261, adj_260, adj_261, adj_262);
            wp::adj_transpose(var_147, adj_147, adj_261);
            wp::adj_mul(var_147, var_30, adj_147, adj_30, adj_260);
            // adj: world_inertia = polar_rotation32 * inertia * wp.transpose(polar_rotation32)   <L 554>
            wp::adj_vec_t(var_244, var_251, var_258, adj_244, adj_251, adj_258, adj_259);
            wp::adj_sub(var_254, var_257, adj_254, adj_257, adj_258);
            wp::adj_extract(var_237, var_255, var_256, adj_237, adj_255, adj_256, adj_257);
            wp::adj_extract(var_237, var_252, var_253, adj_237, adj_252, adj_253, adj_254);
            // adj: coupling[1, 0] - coupling[0, 1],                                              <L 552>
            wp::adj_sub(var_247, var_250, adj_247, adj_250, adj_251);
            wp::adj_extract(var_237, var_248, var_249, adj_237, adj_248, adj_249, adj_250);
            wp::adj_extract(var_237, var_245, var_246, adj_237, adj_245, adj_246, adj_247);
            // adj: coupling[0, 2] - coupling[2, 0],                                              <L 551>
            wp::adj_sub(var_240, var_243, adj_240, adj_243, adj_244);
            wp::adj_extract(var_237, var_241, var_242, adj_237, adj_241, adj_242, adj_243);
            wp::adj_extract(var_237, var_238, var_239, adj_237, adj_238, adj_239, adj_240);
            // adj: coupling[2, 1] - coupling[1, 2],                                              <L 550>
            // adj: angular_momentum = wp.vec3(                                                   <L 549>
            wp::adj_mul(var_235, var_236, adj_235, adj_236, adj_237);
            wp::adj_transpose(var_147, adj_147, adj_236);
            wp::adj_mul(var_231, var_38, adj_231, adj_38, adj_235);
            // adj: coupling = velocity_gradient * second_moment * wp.transpose(polar_rotation32)  <L 548>
            wp::adj_matrix_from_cols(var_232, var_233, var_234, adj_224, adj_227, adj_230, adj_231);
            wp::adj_address(var_particle_qd, var_229, adj_particle_qd, adj_229, adj_230);
            wp::adj_extract(var_6, var_228, adj_6, adj_228, adj_229);
            // adj: particle_qd[particle_indices[3]],                                             <L 546>
            wp::adj_address(var_particle_qd, var_226, adj_particle_qd, adj_226, adj_227);
            wp::adj_extract(var_6, var_225, adj_6, adj_225, adj_226);
            // adj: particle_qd[particle_indices[2]],                                             <L 545>
            wp::adj_address(var_particle_qd, var_223, adj_particle_qd, adj_223, adj_224);
            wp::adj_extract(var_6, var_222, adj_6, adj_222, adj_223);
            // adj: particle_qd[particle_indices[1]],                                             <L 544>
            // adj: velocity_gradient = wp.matrix_from_cols(                                      <L 543>
        }
        if (var_198) {
            wp::adj_quat_rotate(var_189, var_220, adj_189, adj_220, adj_221);
            // adj: angular_velocity = wp.quat_rotate(rotation, next_body_angular_velocity)       <L 538>
            adj_recover_rigid_body_end_velocity_0(var_30, var_219, var_dt, var_inertia_mode, adj_30, adj_219, adj_dt, adj_inertia_mode, adj_220);
            // adj: inertia_mode,                                                                 <L 536>
            // adj: dt,                                                                           <L 535>
            wp::adj_quat_to_matrix(var_218, adj_218, adj_219);
            // adj: wp.quat_to_matrix(relative_rotation),                                         <L 534>
            // adj: inertia,                                                                      <L 533>
            // adj: next_body_angular_velocity = recover_rigid_body_end_velocity(                 <L 532>
            wp::adj_where(var_204, var_217, var_200, adj_204, adj_217, adj_200, adj_218);
            if (var_204) {
                wp::adj_quat_t(var_207, var_210, var_213, var_216, adj_207, adj_210, adj_213, adj_216, adj_217);
                wp::adj_neg(var_215, adj_215, adj_216);
                wp::adj_extract(var_200, var_214, adj_200, adj_214, adj_215);
                // adj: -relative_rotation[3],                                                    <L 530>
                wp::adj_neg(var_212, adj_212, adj_213);
                wp::adj_extract(var_200, var_211, adj_200, adj_211, adj_212);
                // adj: -relative_rotation[2],                                                    <L 529>
                wp::adj_neg(var_209, adj_209, adj_210);
                wp::adj_extract(var_200, var_208, adj_200, adj_208, adj_209);
                // adj: -relative_rotation[1],                                                    <L 528>
                wp::adj_neg(var_206, adj_206, adj_207);
                wp::adj_extract(var_200, var_205, adj_200, adj_205, adj_206);
                // adj: -relative_rotation[0],                                                    <L 527>
                // adj: relative_rotation = wp.quat(                                              <L 526>
            }
            wp::adj_extract(var_200, var_201, adj_200, adj_201, adj_202);
            // adj: if relative_rotation[3] < 0.0:                                                <L 525>
            wp::adj_mul(var_199, var_189, adj_199, adj_189, adj_200);
            wp::adj_quat_inverse(var_149, adj_149, adj_199);
            // adj: relative_rotation = wp.quat_inverse(previous_rotation) * rotation             <L 524>
        }
        // adj: if inertia_mode != NONE:                                                          <L 521>
        wp::adj_vec_t(var_195, adj_195, adj_196);
        // adj: angular_velocity = wp.vec3(0.0)                                                   <L 520>
        wp::adj_copy(var_194, adj_192, adj_193);
        wp::adj_address(var_particle_qd, var_191, adj_particle_qd, adj_191, adj_192);
        wp::adj_extract(var_6, var_190, adj_6, adj_190, adj_191);
        // adj: center_velocity = particle_qd[particle_indices[0]]                                <L 519>
        wp::adj_where(var_175, var_188, var_146, adj_175, adj_188, adj_146, adj_189);
        if (var_175) {
            wp::adj_quat_t(var_178, var_181, var_184, var_187, adj_178, adj_181, adj_184, adj_187, adj_188);
            wp::adj_neg(var_186, adj_186, adj_187);
            wp::adj_extract(var_146, var_185, adj_146, adj_185, adj_186);
            wp::adj_neg(var_183, adj_183, adj_184);
            wp::adj_extract(var_146, var_182, adj_146, adj_182, adj_183);
            wp::adj_neg(var_180, adj_180, adj_181);
            wp::adj_extract(var_146, var_179, adj_146, adj_179, adj_180);
            wp::adj_neg(var_177, adj_177, adj_178);
            wp::adj_extract(var_146, var_176, adj_146, adj_176, adj_177);
            // adj: rotation = wp.quat(-rotation[0], -rotation[1], -rotation[2], -rotation[3])    <L 518>
        }
        // adj: if quaternion_dot < 0.0:                                                          <L 517>
        wp::adj_add(var_167, var_172, adj_167, adj_172, adj_173);
        wp::adj_mul(var_169, var_171, adj_169, adj_171, adj_172);
        wp::adj_extract(var_149, var_170, adj_149, adj_170, adj_171);
        wp::adj_extract(var_146, var_168, adj_146, adj_168, adj_169);
        // adj: + rotation[3] * previous_rotation[3]                                              <L 512>
        wp::adj_add(var_161, var_166, adj_161, adj_166, adj_167);
        wp::adj_mul(var_163, var_165, adj_163, adj_165, adj_166);
        wp::adj_extract(var_149, var_164, adj_149, adj_164, adj_165);
        wp::adj_extract(var_146, var_162, adj_146, adj_162, adj_163);
        // adj: + rotation[2] * previous_rotation[2]                                              <L 511>
        wp::adj_add(var_155, var_160, adj_155, adj_160, adj_161);
        wp::adj_mul(var_157, var_159, adj_157, adj_159, adj_160);
        wp::adj_extract(var_149, var_158, adj_149, adj_158, adj_159);
        wp::adj_extract(var_146, var_156, adj_146, adj_156, adj_157);
        // adj: + rotation[1] * previous_rotation[1]                                              <L 510>
        wp::adj_mul(var_152, var_154, adj_152, adj_154, adj_155);
        wp::adj_extract(var_149, var_153, adj_149, adj_153, adj_154);
        wp::adj_extract(var_146, var_151, adj_146, adj_151, adj_152);
        // adj: rotation[0] * previous_rotation[0]                                                <L 509>
        // adj: quaternion_dot = (                                                                <L 508>
        wp::adj_transform_get_rotation(var_150, adj_148, adj_149);
        wp::adj_address(var_body_q, var_9, adj_body_q, adj_9, adj_148);
        // adj: previous_rotation = wp.transform_get_rotation(body_q[body])                       <L 507>
        wp::adj_mat_t(var_144, adj_144, adj_147);
        // adj: polar_rotation32 = wp.mat33(polar_rotation)                                       <L 506>
        wp::adj_quat_t(var_145, adj_145, adj_146);
        wp::adj_quat_from_matrix(var_144, adj_144, adj_145);
        // adj: rotation = wp.quat(wp.quat_from_matrix(polar_rotation))                           <L 505>
        wp::adj_where(var_108, var_142, var_105, adj_108, adj_142, adj_105, adj_144);
        wp::adj_where(var_108, var_140, var_92, adj_108, adj_140, adj_92, adj_143);
        if (var_108) {
            wp::adj_mul(var_140, var_141, adj_140, adj_141, adj_142);
            wp::adj_transpose(var_94, adj_94, adj_141);
            // adj: polar_rotation = left_basis * wp.transpose(right_basis)                       <L 503>
            wp::adj_matrix_from_cols(var_118, var_128, var_139, adj_118, adj_128, adj_139, adj_140);
            wp::adj_neg(var_138, adj_138, adj_139);
            wp::adj_vec_t(var_131, var_134, var_137, adj_131, adj_134, adj_137, adj_138);
            wp::adj_extract(var_92, var_135, var_136, adj_92, adj_135, adj_136, adj_137);
            wp::adj_extract(var_92, var_132, var_133, adj_92, adj_132, adj_133, adj_134);
            wp::adj_extract(var_92, var_129, var_130, adj_92, adj_129, adj_130, adj_131);
            // adj: -wp.vec3d(left_basis[0, 2], left_basis[1, 2], left_basis[2, 2]),              <L 501>
            wp::adj_vec_t(var_121, var_124, var_127, adj_121, adj_124, adj_127, adj_128);
            wp::adj_extract(var_92, var_125, var_126, adj_92, adj_125, adj_126, adj_127);
            wp::adj_extract(var_92, var_122, var_123, adj_92, adj_122, adj_123, adj_124);
            wp::adj_extract(var_92, var_119, var_120, adj_92, adj_119, adj_120, adj_121);
            // adj: wp.vec3d(left_basis[0, 1], left_basis[1, 1], left_basis[2, 1]),               <L 500>
            wp::adj_vec_t(var_111, var_114, var_117, adj_111, adj_114, adj_117, adj_118);
            wp::adj_extract(var_92, var_115, var_116, adj_92, adj_115, adj_116, adj_117);
            wp::adj_extract(var_92, var_112, var_113, adj_92, adj_112, adj_113, adj_114);
            wp::adj_extract(var_92, var_109, var_110, adj_92, adj_109, adj_110, adj_111);
            // adj: wp.vec3d(left_basis[0, 0], left_basis[1, 0], left_basis[2, 0]),               <L 499>
            // adj: left_basis = wp.matrix_from_cols(                                             <L 498>
        }
        wp::adj_determinant(var_105, adj_105, adj_106);
        // adj: if wp.determinant(polar_rotation) < wp.float64(0.0):                              <L 497>
        wp::adj_mul(var_92, var_104, adj_92, adj_104, adj_105);
        wp::adj_transpose(var_94, adj_94, adj_104);
        // adj: polar_rotation = left_basis * wp.transpose(right_basis)                           <L 496>
        if (var_103) {
            label2:;
            // adj: return                                                                        <L 494>
        }
        wp::adj_mul(var_98, var_101, adj_98, adj_101, adj_102);
        wp::adj_abs(var_100, adj_100, adj_101);
        wp::adj_extract(var_93, var_99, adj_93, adj_99, adj_100);
        wp::adj_abs(var_96, adj_96, adj_97);
        wp::adj_extract(var_93, var_95, adj_93, adj_95, adj_96);
        // adj: if wp.abs(singular_values[2]) <= wp.float64(1.0e-8) * wp.abs(singular_values[0]):  <L 493>
        wp::adj_svd3(var_91, var_92, var_93, var_94, adj_91, adj_92, adj_93, adj_94);
        wp::adj_div(var_48, var_88, adj_48, adj_88, adj_91);
        // adj: left_basis, singular_values, right_basis = wp.svd3(weighted_affine_matrix / matrix_scale)  <L 492>
        if (var_90) {
            label1:;
            // adj: return                                                                        <L 491>
        }
        // adj: if matrix_scale <= wp.float64(0.0):                                               <L 490>
        wp::adj_max(var_84, var_87, adj_84, adj_87, adj_88);
        wp::adj_abs(var_86, adj_86, adj_87);
        wp::adj_extract(var_48, var_76, var_85, adj_48, adj_76, adj_85, adj_86);
        wp::adj_max(var_80, var_83, adj_80, adj_83, adj_84);
        wp::adj_abs(var_82, adj_82, adj_83);
        wp::adj_extract(var_48, var_76, var_81, adj_48, adj_76, adj_81, adj_82);
        wp::adj_max(var_75, var_79, adj_75, adj_79, adj_80);
        wp::adj_abs(var_78, adj_78, adj_79);
        wp::adj_extract(var_48, var_76, var_77, adj_48, adj_76, adj_77, adj_78);
        // adj: matrix_scale = wp.max(matrix_scale, wp.abs(weighted_affine_matrix[row, column]))  <L 489>
        // adj: for column in range(3):                                                           <L 488>
        wp::adj_max(var_71, var_74, adj_71, adj_74, adj_75);
        wp::adj_abs(var_73, adj_73, adj_74);
        wp::adj_extract(var_48, var_63, var_72, adj_48, adj_63, adj_72, adj_73);
        wp::adj_max(var_67, var_70, adj_67, adj_70, adj_71);
        wp::adj_abs(var_69, adj_69, adj_70);
        wp::adj_extract(var_48, var_63, var_68, adj_48, adj_63, adj_68, adj_69);
        wp::adj_max(var_62, var_66, adj_62, adj_66, adj_67);
        wp::adj_abs(var_65, adj_65, adj_66);
        wp::adj_extract(var_48, var_63, var_64, adj_48, adj_63, adj_64, adj_65);
        // adj: matrix_scale = wp.max(matrix_scale, wp.abs(weighted_affine_matrix[row, column]))  <L 489>
        // adj: for column in range(3):                                                           <L 488>
        wp::adj_max(var_58, var_61, adj_58, adj_61, adj_62);
        wp::adj_abs(var_60, adj_60, adj_61);
        wp::adj_extract(var_48, var_50, var_59, adj_48, adj_50, adj_59, adj_60);
        wp::adj_max(var_54, var_57, adj_54, adj_57, adj_58);
        wp::adj_abs(var_56, adj_56, adj_57);
        wp::adj_extract(var_48, var_50, var_55, adj_48, adj_50, adj_55, adj_56);
        wp::adj_max(var_49, var_53, adj_49, adj_53, adj_54);
        wp::adj_abs(var_52, adj_52, adj_53);
        wp::adj_extract(var_48, var_50, var_51, adj_48, adj_50, adj_51, adj_52);
        // adj: matrix_scale = wp.max(matrix_scale, wp.abs(weighted_affine_matrix[row, column]))  <L 489>
        // adj: for column in range(3):                                                           <L 488>
        // adj: for row in range(3):                                                              <L 487>
        // adj: matrix_scale = wp.float64(0.0)                                                    <L 486>
        wp::adj_mul(var_47, var_46, adj_47, adj_46, adj_48);
        wp::adj_mat_t(var_25, adj_25, adj_47);
        // adj: weighted_affine_matrix = wp.mat33d(affine_matrix) * second_moment64               <L 482>
        wp::adj_sub(var_45, var_39, adj_45, adj_39, adj_46);
        wp::adj_mul(var_42, var_44, adj_42, adj_44, adj_45);
        wp::adj_mul(var_40, var_41, adj_40, adj_41, adj_42);
        wp::adj_trace(var_39, adj_39, adj_41);
        // adj: second_moment64 = wp.float64(0.5) * wp.trace(inertia64) * wp.identity(3, dtype=wp.float64) - inertia64  <L 481>
        wp::adj_mat_t(var_30, adj_30, adj_39);
        // adj: inertia64 = wp.mat33d(inertia)                                                    <L 480>
        wp::adj_sub(var_37, var_30, adj_37, adj_30, adj_38);
        wp::adj_mul(var_34, var_36, adj_34, adj_36, adj_37);
        wp::adj_mul(var_32, var_33, adj_32, adj_33, adj_34);
        wp::adj_trace(var_30, adj_30, adj_33);
        // adj: second_moment = 0.5 * wp.trace(inertia) * wp.identity(3, dtype=float) - inertia   <L 476>
        wp::adj_copy(var_31, adj_29, adj_30);
        wp::adj_address(var_affine_body_inertia, var_0, adj_affine_body_inertia, adj_0, adj_29);
        // adj: inertia = affine_body_inertia[affine_body]                                        <L 475>
        wp::adj_matrix_from_cols(var_26, var_27, var_28, adj_18, adj_21, adj_24, adj_25);
        wp::adj_address(var_particle_q, var_23, adj_particle_q, adj_23, adj_24);
        wp::adj_extract(var_6, var_22, adj_6, adj_22, adj_23);
        // adj: particle_q[particle_indices[3]],                                                  <L 470>
        wp::adj_address(var_particle_q, var_20, adj_particle_q, adj_20, adj_21);
        wp::adj_extract(var_6, var_19, adj_6, adj_19, adj_20);
        // adj: particle_q[particle_indices[2]],                                                  <L 469>
        wp::adj_address(var_particle_q, var_17, adj_particle_q, adj_17, adj_18);
        wp::adj_extract(var_6, var_16, adj_6, adj_16, adj_17);
        // adj: particle_q[particle_indices[1]],                                                  <L 468>
        // adj: affine_matrix = wp.matrix_from_cols(                                              <L 467>
        wp::adj_copy(var_15, adj_13, adj_14);
        wp::adj_address(var_particle_q, var_12, adj_particle_q, adj_12, adj_13);
        wp::adj_extract(var_6, var_11, adj_6, adj_11, adj_12);
        // adj: origin = particle_q[particle_indices[0]]                                          <L 465>
        wp::adj_copy(var_10, adj_8, adj_9);
        wp::adj_address(var_affine_body_ids, var_0, adj_affine_body_ids, adj_0, adj_8);
        // adj: body = affine_body_ids[affine_body]                                               <L 464>
        wp::adj_copy(var_7, adj_5, adj_6);
        wp::adj_address(var_affine_body_indices, var_0, adj_affine_body_indices, adj_0, adj_5);
        // adj: particle_indices = affine_body_indices[affine_body]                               <L 463>
        if (var_3) {
            label0:;
            // adj: return                                                                        <L 462>
        }
        wp::adj_address(var_fixed_affine_body_flags, var_0, adj_fixed_affine_body_flags, adj_0, adj_1);
        // adj: if fixed_affine_body_flags[affine_body] != 0:                                     <L 461>
        // adj: affine_body = wp.tid()                                                            <L 460>
        // adj: def _update_affine_body_poses(                                                    <L 446>
        continue;
    }
}



extern "C" __global__ void _scatter_affine_body_forces_e3a0f0a5_cuda_kernel_forward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::vec_t<6, wp::float32>> var_body_f,
    wp::array_t<wp::vec_t<4, wp::int32>> var_affine_body_indices,
    wp::array_t<wp::int32> var_affine_body_ids,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_q,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_f)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        wp::int32 var_0;
        wp::vec_t<4, wp::int32>* var_1;
        wp::vec_t<4, wp::int32> var_2;
        wp::vec_t<4, wp::int32> var_3;
        wp::int32* var_4;
        wp::int32 var_5;
        wp::int32 var_6;
        wp::vec_t<6, wp::float32>* var_7;
        wp::vec_t<6, wp::float32> var_8;
        wp::vec_t<6, wp::float32> var_9;
        wp::vec_t<3, wp::float32> var_10;
        wp::vec_t<3, wp::float32> var_11;
        const wp::int32 var_12 = 1;
        wp::int32 var_13;
        wp::vec_t<3, wp::float32>* var_14;
        wp::vec_t<3, wp::float32> var_15;
        wp::vec_t<3, wp::float32> var_16;
        const wp::int32 var_17 = 2;
        wp::int32 var_18;
        wp::vec_t<3, wp::float32>* var_19;
        wp::vec_t<3, wp::float32> var_20;
        wp::vec_t<3, wp::float32> var_21;
        const wp::int32 var_22 = 3;
        wp::int32 var_23;
        wp::vec_t<3, wp::float32>* var_24;
        wp::vec_t<3, wp::float32> var_25;
        wp::vec_t<3, wp::float32> var_26;
        const wp::float32 var_27 = 0.5;
        wp::vec_t<3, wp::float32> var_28;
        wp::vec_t<3, wp::float32> var_29;
        const wp::float32 var_30 = 0.5;
        wp::vec_t<3, wp::float32> var_31;
        wp::vec_t<3, wp::float32> var_32;
        const wp::float32 var_33 = 0.5;
        wp::vec_t<3, wp::float32> var_34;
        wp::vec_t<3, wp::float32> var_35;
        const wp::int32 var_36 = 0;
        wp::int32 var_37;
        wp::vec_t<3, wp::float32> var_38;
        const wp::int32 var_39 = 1;
        wp::int32 var_40;
        wp::vec_t<3, wp::float32> var_41;
        const wp::int32 var_42 = 2;
        wp::int32 var_43;
        wp::vec_t<3, wp::float32> var_44;
        const wp::int32 var_45 = 3;
        wp::int32 var_46;
        wp::vec_t<3, wp::float32> var_47;
        //---------
        // forward
        // def _scatter_affine_body_forces(                                                       <L 575>
        // affine_body = wp.tid()                                                                 <L 583>
        var_0 = builtin_tid1d();
        // particle_indices = affine_body_indices[affine_body]                                    <L 584>
        var_1 = wp::address(var_affine_body_indices, var_0);
        var_3 = wp::load(var_1);
        var_2 = wp::copy(var_3);
        // body = affine_body_ids[affine_body]                                                    <L 585>
        var_4 = wp::address(var_affine_body_ids, var_0);
        var_6 = wp::load(var_4);
        var_5 = wp::copy(var_6);
        // wrench = body_f[body]                                                                  <L 586>
        var_7 = wp::address(var_body_f, var_5);
        var_9 = wp::load(var_7);
        var_8 = wp::copy(var_9);
        // force = wp.spatial_top(wrench)                                                         <L 587>
        var_10 = wp::spatial_top(var_8);
        // torque = wp.spatial_bottom(wrench)                                                     <L 588>
        var_11 = wp::spatial_bottom(var_8);
        // x_axis = particle_q[particle_indices[1]]                                               <L 589>
        var_13 = wp::extract(var_2, var_12);
        var_14 = wp::address(var_particle_q, var_13);
        var_16 = wp::load(var_14);
        var_15 = wp::copy(var_16);
        // y_axis = particle_q[particle_indices[2]]                                               <L 590>
        var_18 = wp::extract(var_2, var_17);
        var_19 = wp::address(var_particle_q, var_18);
        var_21 = wp::load(var_19);
        var_20 = wp::copy(var_21);
        // z_axis = particle_q[particle_indices[3]]                                               <L 591>
        var_23 = wp::extract(var_2, var_22);
        var_24 = wp::address(var_particle_q, var_23);
        var_26 = wp::load(var_24);
        var_25 = wp::copy(var_26);
        // force_x = 0.5 * wp.cross(torque, x_axis)                                               <L 592>
        var_28 = wp::cross(var_11, var_15);
        var_29 = wp::mul(var_27, var_28);
        // force_y = 0.5 * wp.cross(torque, y_axis)                                               <L 593>
        var_31 = wp::cross(var_11, var_20);
        var_32 = wp::mul(var_30, var_31);
        // force_z = 0.5 * wp.cross(torque, z_axis)                                               <L 594>
        var_34 = wp::cross(var_11, var_25);
        var_35 = wp::mul(var_33, var_34);
        // wp.atomic_add(particle_f, particle_indices[0], force)                                  <L 595>
        var_37 = wp::extract(var_2, var_36);
        var_38 = wp::atomic_add(var_particle_f, var_37, var_10);
        // wp.atomic_add(particle_f, particle_indices[1], force_x)                                <L 596>
        var_40 = wp::extract(var_2, var_39);
        var_41 = wp::atomic_add(var_particle_f, var_40, var_29);
        // wp.atomic_add(particle_f, particle_indices[2], force_y)                                <L 597>
        var_43 = wp::extract(var_2, var_42);
        var_44 = wp::atomic_add(var_particle_f, var_43, var_32);
        // wp.atomic_add(particle_f, particle_indices[3], force_z)                                <L 598>
        var_46 = wp::extract(var_2, var_45);
        var_47 = wp::atomic_add(var_particle_f, var_46, var_35);
    }
}



extern "C" __global__ void _scatter_affine_body_forces_e3a0f0a5_cuda_kernel_backward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::vec_t<6, wp::float32>> var_body_f,
    wp::array_t<wp::vec_t<4, wp::int32>> var_affine_body_indices,
    wp::array_t<wp::int32> var_affine_body_ids,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_q,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_f,
    wp::array_t<wp::vec_t<6, wp::float32>> adj_body_f,
    wp::array_t<wp::vec_t<4, wp::int32>> adj_affine_body_indices,
    wp::array_t<wp::int32> adj_affine_body_ids,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_particle_q,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_particle_f)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        wp::int32 var_0;
        wp::vec_t<4, wp::int32>* var_1;
        wp::vec_t<4, wp::int32> var_2;
        wp::vec_t<4, wp::int32> var_3;
        wp::int32* var_4;
        wp::int32 var_5;
        wp::int32 var_6;
        wp::vec_t<6, wp::float32>* var_7;
        wp::vec_t<6, wp::float32> var_8;
        wp::vec_t<6, wp::float32> var_9;
        wp::vec_t<3, wp::float32> var_10;
        wp::vec_t<3, wp::float32> var_11;
        const wp::int32 var_12 = 1;
        wp::int32 var_13;
        wp::vec_t<3, wp::float32>* var_14;
        wp::vec_t<3, wp::float32> var_15;
        wp::vec_t<3, wp::float32> var_16;
        const wp::int32 var_17 = 2;
        wp::int32 var_18;
        wp::vec_t<3, wp::float32>* var_19;
        wp::vec_t<3, wp::float32> var_20;
        wp::vec_t<3, wp::float32> var_21;
        const wp::int32 var_22 = 3;
        wp::int32 var_23;
        wp::vec_t<3, wp::float32>* var_24;
        wp::vec_t<3, wp::float32> var_25;
        wp::vec_t<3, wp::float32> var_26;
        const wp::float32 var_27 = 0.5;
        wp::vec_t<3, wp::float32> var_28;
        wp::vec_t<3, wp::float32> var_29;
        const wp::float32 var_30 = 0.5;
        wp::vec_t<3, wp::float32> var_31;
        wp::vec_t<3, wp::float32> var_32;
        const wp::float32 var_33 = 0.5;
        wp::vec_t<3, wp::float32> var_34;
        wp::vec_t<3, wp::float32> var_35;
        const wp::int32 var_36 = 0;
        wp::int32 var_37;
        wp::vec_t<3, wp::float32> var_38;
        const wp::int32 var_39 = 1;
        wp::int32 var_40;
        wp::vec_t<3, wp::float32> var_41;
        const wp::int32 var_42 = 2;
        wp::int32 var_43;
        wp::vec_t<3, wp::float32> var_44;
        const wp::int32 var_45 = 3;
        wp::int32 var_46;
        wp::vec_t<3, wp::float32> var_47;
        //---------
        // dual vars
        wp::int32 adj_0 = {};
        wp::vec_t<4, wp::int32> adj_1 = {};
        wp::vec_t<4, wp::int32> adj_2 = {};
        wp::vec_t<4, wp::int32> adj_3 = {};
        wp::int32 adj_4 = {};
        wp::int32 adj_5 = {};
        wp::int32 adj_6 = {};
        wp::vec_t<6, wp::float32> adj_7 = {};
        wp::vec_t<6, wp::float32> adj_8 = {};
        wp::vec_t<6, wp::float32> adj_9 = {};
        wp::vec_t<3, wp::float32> adj_10 = {};
        wp::vec_t<3, wp::float32> adj_11 = {};
        wp::int32 adj_12 = {};
        wp::int32 adj_13 = {};
        wp::vec_t<3, wp::float32> adj_14 = {};
        wp::vec_t<3, wp::float32> adj_15 = {};
        wp::vec_t<3, wp::float32> adj_16 = {};
        wp::int32 adj_17 = {};
        wp::int32 adj_18 = {};
        wp::vec_t<3, wp::float32> adj_19 = {};
        wp::vec_t<3, wp::float32> adj_20 = {};
        wp::vec_t<3, wp::float32> adj_21 = {};
        wp::int32 adj_22 = {};
        wp::int32 adj_23 = {};
        wp::vec_t<3, wp::float32> adj_24 = {};
        wp::vec_t<3, wp::float32> adj_25 = {};
        wp::vec_t<3, wp::float32> adj_26 = {};
        wp::float32 adj_27 = {};
        wp::vec_t<3, wp::float32> adj_28 = {};
        wp::vec_t<3, wp::float32> adj_29 = {};
        wp::float32 adj_30 = {};
        wp::vec_t<3, wp::float32> adj_31 = {};
        wp::vec_t<3, wp::float32> adj_32 = {};
        wp::float32 adj_33 = {};
        wp::vec_t<3, wp::float32> adj_34 = {};
        wp::vec_t<3, wp::float32> adj_35 = {};
        wp::int32 adj_36 = {};
        wp::int32 adj_37 = {};
        wp::vec_t<3, wp::float32> adj_38 = {};
        wp::int32 adj_39 = {};
        wp::int32 adj_40 = {};
        wp::vec_t<3, wp::float32> adj_41 = {};
        wp::int32 adj_42 = {};
        wp::int32 adj_43 = {};
        wp::vec_t<3, wp::float32> adj_44 = {};
        wp::int32 adj_45 = {};
        wp::int32 adj_46 = {};
        wp::vec_t<3, wp::float32> adj_47 = {};
        //---------
        // forward
        // def _scatter_affine_body_forces(                                                       <L 575>
        // affine_body = wp.tid()                                                                 <L 583>
        var_0 = builtin_tid1d();
        // particle_indices = affine_body_indices[affine_body]                                    <L 584>
        var_1 = wp::address(var_affine_body_indices, var_0);
        var_3 = wp::load(var_1);
        var_2 = wp::copy(var_3);
        // body = affine_body_ids[affine_body]                                                    <L 585>
        var_4 = wp::address(var_affine_body_ids, var_0);
        var_6 = wp::load(var_4);
        var_5 = wp::copy(var_6);
        // wrench = body_f[body]                                                                  <L 586>
        var_7 = wp::address(var_body_f, var_5);
        var_9 = wp::load(var_7);
        var_8 = wp::copy(var_9);
        // force = wp.spatial_top(wrench)                                                         <L 587>
        var_10 = wp::spatial_top(var_8);
        // torque = wp.spatial_bottom(wrench)                                                     <L 588>
        var_11 = wp::spatial_bottom(var_8);
        // x_axis = particle_q[particle_indices[1]]                                               <L 589>
        var_13 = wp::extract(var_2, var_12);
        var_14 = wp::address(var_particle_q, var_13);
        var_16 = wp::load(var_14);
        var_15 = wp::copy(var_16);
        // y_axis = particle_q[particle_indices[2]]                                               <L 590>
        var_18 = wp::extract(var_2, var_17);
        var_19 = wp::address(var_particle_q, var_18);
        var_21 = wp::load(var_19);
        var_20 = wp::copy(var_21);
        // z_axis = particle_q[particle_indices[3]]                                               <L 591>
        var_23 = wp::extract(var_2, var_22);
        var_24 = wp::address(var_particle_q, var_23);
        var_26 = wp::load(var_24);
        var_25 = wp::copy(var_26);
        // force_x = 0.5 * wp.cross(torque, x_axis)                                               <L 592>
        var_28 = wp::cross(var_11, var_15);
        var_29 = wp::mul(var_27, var_28);
        // force_y = 0.5 * wp.cross(torque, y_axis)                                               <L 593>
        var_31 = wp::cross(var_11, var_20);
        var_32 = wp::mul(var_30, var_31);
        // force_z = 0.5 * wp.cross(torque, z_axis)                                               <L 594>
        var_34 = wp::cross(var_11, var_25);
        var_35 = wp::mul(var_33, var_34);
        // wp.atomic_add(particle_f, particle_indices[0], force)                                  <L 595>
        var_37 = wp::extract(var_2, var_36);
        // var_38 = wp::atomic_add(var_particle_f, var_37, var_10);
        // wp.atomic_add(particle_f, particle_indices[1], force_x)                                <L 596>
        var_40 = wp::extract(var_2, var_39);
        // var_41 = wp::atomic_add(var_particle_f, var_40, var_29);
        // wp.atomic_add(particle_f, particle_indices[2], force_y)                                <L 597>
        var_43 = wp::extract(var_2, var_42);
        // var_44 = wp::atomic_add(var_particle_f, var_43, var_32);
        // wp.atomic_add(particle_f, particle_indices[3], force_z)                                <L 598>
        var_46 = wp::extract(var_2, var_45);
        // var_47 = wp::atomic_add(var_particle_f, var_46, var_35);
        //---------
        // reverse
        wp::adj_atomic_add(var_particle_f, var_46, var_35, adj_particle_f, adj_46, adj_35, adj_47);
        wp::adj_extract(var_2, var_45, adj_2, adj_45, adj_46);
        // adj: wp.atomic_add(particle_f, particle_indices[3], force_z)                           <L 598>
        wp::adj_atomic_add(var_particle_f, var_43, var_32, adj_particle_f, adj_43, adj_32, adj_44);
        wp::adj_extract(var_2, var_42, adj_2, adj_42, adj_43);
        // adj: wp.atomic_add(particle_f, particle_indices[2], force_y)                           <L 597>
        wp::adj_atomic_add(var_particle_f, var_40, var_29, adj_particle_f, adj_40, adj_29, adj_41);
        wp::adj_extract(var_2, var_39, adj_2, adj_39, adj_40);
        // adj: wp.atomic_add(particle_f, particle_indices[1], force_x)                           <L 596>
        wp::adj_atomic_add(var_particle_f, var_37, var_10, adj_particle_f, adj_37, adj_10, adj_38);
        wp::adj_extract(var_2, var_36, adj_2, adj_36, adj_37);
        // adj: wp.atomic_add(particle_f, particle_indices[0], force)                             <L 595>
        wp::adj_mul(var_33, var_34, adj_33, adj_34, adj_35);
        wp::adj_cross(var_11, var_25, adj_11, adj_25, adj_34);
        // adj: force_z = 0.5 * wp.cross(torque, z_axis)                                          <L 594>
        wp::adj_mul(var_30, var_31, adj_30, adj_31, adj_32);
        wp::adj_cross(var_11, var_20, adj_11, adj_20, adj_31);
        // adj: force_y = 0.5 * wp.cross(torque, y_axis)                                          <L 593>
        wp::adj_mul(var_27, var_28, adj_27, adj_28, adj_29);
        wp::adj_cross(var_11, var_15, adj_11, adj_15, adj_28);
        // adj: force_x = 0.5 * wp.cross(torque, x_axis)                                          <L 592>
        wp::adj_copy(var_26, adj_24, adj_25);
        wp::adj_address(var_particle_q, var_23, adj_particle_q, adj_23, adj_24);
        wp::adj_extract(var_2, var_22, adj_2, adj_22, adj_23);
        // adj: z_axis = particle_q[particle_indices[3]]                                          <L 591>
        wp::adj_copy(var_21, adj_19, adj_20);
        wp::adj_address(var_particle_q, var_18, adj_particle_q, adj_18, adj_19);
        wp::adj_extract(var_2, var_17, adj_2, adj_17, adj_18);
        // adj: y_axis = particle_q[particle_indices[2]]                                          <L 590>
        wp::adj_copy(var_16, adj_14, adj_15);
        wp::adj_address(var_particle_q, var_13, adj_particle_q, adj_13, adj_14);
        wp::adj_extract(var_2, var_12, adj_2, adj_12, adj_13);
        // adj: x_axis = particle_q[particle_indices[1]]                                          <L 589>
        wp::adj_spatial_bottom(var_8, adj_8, adj_11);
        // adj: torque = wp.spatial_bottom(wrench)                                                <L 588>
        wp::adj_spatial_top(var_8, adj_8, adj_10);
        // adj: force = wp.spatial_top(wrench)                                                    <L 587>
        wp::adj_copy(var_9, adj_7, adj_8);
        wp::adj_address(var_body_f, var_5, adj_body_f, adj_5, adj_7);
        // adj: wrench = body_f[body]                                                             <L 586>
        wp::adj_copy(var_6, adj_4, adj_5);
        wp::adj_address(var_affine_body_ids, var_0, adj_affine_body_ids, adj_0, adj_4);
        // adj: body = affine_body_ids[affine_body]                                               <L 585>
        wp::adj_copy(var_3, adj_1, adj_2);
        wp::adj_address(var_affine_body_indices, var_0, adj_affine_body_indices, adj_0, adj_1);
        // adj: particle_indices = affine_body_indices[affine_body]                               <L 584>
        // adj: affine_body = wp.tid()                                                            <L 583>
        // adj: def _scatter_affine_body_forces(                                                  <L 575>
        continue;
    }
}



extern "C" __global__ void _reset_newton_state_92df2a19_cuda_kernel_forward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<bool> var_world_mask,
    bool var_reset_all,
    wp::int32 var_world_count,
    wp::array_t<wp::int32> var_body_world,
    wp::array_t<wp::int32> var_particle_world,
    wp::array_t<wp::transform_t<wp::float32>> var_model_body_q,
    wp::array_t<wp::vec_t<6, wp::float32>> var_model_body_qd,
    wp::array_t<wp::vec_t<3, wp::float32>> var_model_particle_q,
    wp::array_t<wp::vec_t<3, wp::float32>> var_model_particle_qd,
    wp::array_t<wp::transform_t<wp::float32>> var_body_q,
    wp::array_t<wp::vec_t<6, wp::float32>> var_body_qd,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_q,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_qd)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        wp::int32 var_0;
        bool var_1;
        bool var_2;
        wp::shape_t* var_3;
        const wp::int32 var_4 = 0;
        wp::int32 var_5;
        wp::shape_t var_6;
        bool var_7;
        wp::int32* var_8;
        bool var_9;
        wp::int32 var_10;
        wp::transform_t<wp::float32>* var_11;
        wp::transform_t<wp::float32> var_12;
        wp::vec_t<6, wp::float32>* var_13;
        wp::vec_t<6, wp::float32> var_14;
        bool var_15;
        bool var_16;
        wp::shape_t* var_17;
        const wp::int32 var_18 = 0;
        wp::int32 var_19;
        wp::shape_t var_20;
        bool var_21;
        wp::int32* var_22;
        bool var_23;
        wp::int32 var_24;
        wp::vec_t<3, wp::float32>* var_25;
        wp::vec_t<3, wp::float32> var_26;
        wp::vec_t<3, wp::float32>* var_27;
        wp::vec_t<3, wp::float32> var_28;
        //---------
        // forward
        // def _reset_newton_state(                                                               <L 299>
        // index = wp.tid()                                                                       <L 314>
        var_0 = builtin_tid1d();
        // if (body_q or body_qd) and index < body_world.shape[0]:                                <L 315>
        var_2 = var_body_q;
        if (!var_2) {
            var_2 = var_2 || var_body_qd;
        }
        var_1 = var_2;
        if (var_1) {
            var_3 = &(var_body_world.shape);
            var_6 = wp::load(var_3);
            var_5 = wp::extract(var_6, var_4);
            var_7 = (var_0 < var_5);
            var_1 = var_1 && var_7;
        }
        if (var_1) {
            // if _reset_selected_world(body_world[index], world_mask, world_count, reset_all):       <L 316>
            var_8 = wp::address(var_body_world, var_0);
            var_10 = wp::load(var_8);
            var_9 = _reset_selected_world_0(var_10, var_world_mask, var_world_count, var_reset_all);
            if (var_9) {
                // if body_q:                                                                     <L 317>
                if (var_body_q) {
                    // body_q[index] = model_body_q[index]                                        <L 318>
                    var_11 = wp::address(var_model_body_q, var_0);
                    var_12 = wp::load(var_11);
                    wp::array_store(var_body_q, var_0, var_12);
                }
                // if body_qd:                                                                    <L 319>
                if (var_body_qd) {
                    // body_qd[index] = model_body_qd[index]                                      <L 320>
                    var_13 = wp::address(var_model_body_qd, var_0);
                    var_14 = wp::load(var_13);
                    wp::array_store(var_body_qd, var_0, var_14);
                }
            }
        }
        // if (particle_q or particle_qd) and index < particle_world.shape[0]:                    <L 321>
        var_16 = var_particle_q;
        if (!var_16) {
            var_16 = var_16 || var_particle_qd;
        }
        var_15 = var_16;
        if (var_15) {
            var_17 = &(var_particle_world.shape);
            var_20 = wp::load(var_17);
            var_19 = wp::extract(var_20, var_18);
            var_21 = (var_0 < var_19);
            var_15 = var_15 && var_21;
        }
        if (var_15) {
            // if _reset_selected_world(particle_world[index], world_mask, world_count, reset_all):       <L 322>
            var_22 = wp::address(var_particle_world, var_0);
            var_24 = wp::load(var_22);
            var_23 = _reset_selected_world_0(var_24, var_world_mask, var_world_count, var_reset_all);
            if (var_23) {
                // if particle_q:                                                                 <L 323>
                if (var_particle_q) {
                    // particle_q[index] = model_particle_q[index]                                <L 324>
                    var_25 = wp::address(var_model_particle_q, var_0);
                    var_26 = wp::load(var_25);
                    wp::array_store(var_particle_q, var_0, var_26);
                }
                // if particle_qd:                                                                <L 325>
                if (var_particle_qd) {
                    // particle_qd[index] = model_particle_qd[index]                              <L 326>
                    var_27 = wp::address(var_model_particle_qd, var_0);
                    var_28 = wp::load(var_27);
                    wp::array_store(var_particle_qd, var_0, var_28);
                }
            }
        }
    }
}



extern "C" __global__ void _reset_newton_state_92df2a19_cuda_kernel_backward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<bool> var_world_mask,
    bool var_reset_all,
    wp::int32 var_world_count,
    wp::array_t<wp::int32> var_body_world,
    wp::array_t<wp::int32> var_particle_world,
    wp::array_t<wp::transform_t<wp::float32>> var_model_body_q,
    wp::array_t<wp::vec_t<6, wp::float32>> var_model_body_qd,
    wp::array_t<wp::vec_t<3, wp::float32>> var_model_particle_q,
    wp::array_t<wp::vec_t<3, wp::float32>> var_model_particle_qd,
    wp::array_t<wp::transform_t<wp::float32>> var_body_q,
    wp::array_t<wp::vec_t<6, wp::float32>> var_body_qd,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_q,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_qd,
    wp::array_t<bool> adj_world_mask,
    bool adj_reset_all,
    wp::int32 adj_world_count,
    wp::array_t<wp::int32> adj_body_world,
    wp::array_t<wp::int32> adj_particle_world,
    wp::array_t<wp::transform_t<wp::float32>> adj_model_body_q,
    wp::array_t<wp::vec_t<6, wp::float32>> adj_model_body_qd,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_model_particle_q,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_model_particle_qd,
    wp::array_t<wp::transform_t<wp::float32>> adj_body_q,
    wp::array_t<wp::vec_t<6, wp::float32>> adj_body_qd,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_particle_q,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_particle_qd)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        wp::int32 var_0;
        bool var_1;
        bool var_2;
        wp::shape_t* var_3;
        const wp::int32 var_4 = 0;
        wp::int32 var_5;
        wp::shape_t var_6;
        bool var_7;
        wp::int32* var_8;
        bool var_9;
        wp::int32 var_10;
        wp::transform_t<wp::float32>* var_11;
        wp::transform_t<wp::float32> var_12;
        wp::vec_t<6, wp::float32>* var_13;
        wp::vec_t<6, wp::float32> var_14;
        bool var_15;
        bool var_16;
        wp::shape_t* var_17;
        const wp::int32 var_18 = 0;
        wp::int32 var_19;
        wp::shape_t var_20;
        bool var_21;
        wp::int32* var_22;
        bool var_23;
        wp::int32 var_24;
        wp::vec_t<3, wp::float32>* var_25;
        wp::vec_t<3, wp::float32> var_26;
        wp::vec_t<3, wp::float32>* var_27;
        wp::vec_t<3, wp::float32> var_28;
        //---------
        // dual vars
        wp::int32 adj_0 = {};
        bool adj_1 = {};
        bool adj_2 = {};
        wp::shape_t adj_3 = {};
        wp::int32 adj_4 = {};
        wp::int32 adj_5 = {};
        wp::shape_t adj_6 = {};
        bool adj_7 = {};
        wp::int32 adj_8 = {};
        bool adj_9 = {};
        wp::int32 adj_10 = {};
        wp::transform_t<wp::float32> adj_11 = {};
        wp::transform_t<wp::float32> adj_12 = {};
        wp::vec_t<6, wp::float32> adj_13 = {};
        wp::vec_t<6, wp::float32> adj_14 = {};
        bool adj_15 = {};
        bool adj_16 = {};
        wp::shape_t adj_17 = {};
        wp::int32 adj_18 = {};
        wp::int32 adj_19 = {};
        wp::shape_t adj_20 = {};
        bool adj_21 = {};
        wp::int32 adj_22 = {};
        bool adj_23 = {};
        wp::int32 adj_24 = {};
        wp::vec_t<3, wp::float32> adj_25 = {};
        wp::vec_t<3, wp::float32> adj_26 = {};
        wp::vec_t<3, wp::float32> adj_27 = {};
        wp::vec_t<3, wp::float32> adj_28 = {};
        //---------
        // forward
        // def _reset_newton_state(                                                               <L 299>
        // index = wp.tid()                                                                       <L 314>
        var_0 = builtin_tid1d();
        // if (body_q or body_qd) and index < body_world.shape[0]:                                <L 315>
        var_2 = var_body_q;
        if (!var_2) {
            var_2 = var_2 || var_body_qd;
        }
        var_1 = var_2;
        if (var_1) {
            var_3 = &(var_body_world.shape);
            var_6 = wp::load(var_3);
            var_5 = wp::extract(var_6, var_4);
            var_7 = (var_0 < var_5);
            var_1 = var_1 && var_7;
        }
        if (var_1) {
            // if _reset_selected_world(body_world[index], world_mask, world_count, reset_all):       <L 316>
            var_8 = wp::address(var_body_world, var_0);
            var_10 = wp::load(var_8);
            var_9 = _reset_selected_world_0(var_10, var_world_mask, var_world_count, var_reset_all);
            if (var_9) {
                // if body_q:                                                                     <L 317>
                if (var_body_q) {
                    // body_q[index] = model_body_q[index]                                        <L 318>
                    var_11 = wp::address(var_model_body_q, var_0);
                    var_12 = wp::load(var_11);
                    // wp::array_store(var_body_q, var_0, var_12);
                }
                // if body_qd:                                                                    <L 319>
                if (var_body_qd) {
                    // body_qd[index] = model_body_qd[index]                                      <L 320>
                    var_13 = wp::address(var_model_body_qd, var_0);
                    var_14 = wp::load(var_13);
                    // wp::array_store(var_body_qd, var_0, var_14);
                }
            }
        }
        // if (particle_q or particle_qd) and index < particle_world.shape[0]:                    <L 321>
        var_16 = var_particle_q;
        if (!var_16) {
            var_16 = var_16 || var_particle_qd;
        }
        var_15 = var_16;
        if (var_15) {
            var_17 = &(var_particle_world.shape);
            var_20 = wp::load(var_17);
            var_19 = wp::extract(var_20, var_18);
            var_21 = (var_0 < var_19);
            var_15 = var_15 && var_21;
        }
        if (var_15) {
            // if _reset_selected_world(particle_world[index], world_mask, world_count, reset_all):       <L 322>
            var_22 = wp::address(var_particle_world, var_0);
            var_24 = wp::load(var_22);
            var_23 = _reset_selected_world_0(var_24, var_world_mask, var_world_count, var_reset_all);
            if (var_23) {
                // if particle_q:                                                                 <L 323>
                if (var_particle_q) {
                    // particle_q[index] = model_particle_q[index]                                <L 324>
                    var_25 = wp::address(var_model_particle_q, var_0);
                    var_26 = wp::load(var_25);
                    // wp::array_store(var_particle_q, var_0, var_26);
                }
                // if particle_qd:                                                                <L 325>
                if (var_particle_qd) {
                    // particle_qd[index] = model_particle_qd[index]                              <L 326>
                    var_27 = wp::address(var_model_particle_qd, var_0);
                    var_28 = wp::load(var_27);
                    // wp::array_store(var_particle_qd, var_0, var_28);
                }
            }
        }
        //---------
        // reverse
        if (var_15) {
            if (var_23) {
                if (var_particle_qd) {
                    wp::adj_array_store(var_particle_qd, var_0, var_28, adj_particle_qd, adj_0, adj_27);
                    wp::adj_address(var_model_particle_qd, var_0, adj_model_particle_qd, adj_0, adj_27);
                    // adj: particle_qd[index] = model_particle_qd[index]                         <L 326>
                }
                // adj: if particle_qd:                                                           <L 325>
                if (var_particle_q) {
                    wp::adj_array_store(var_particle_q, var_0, var_26, adj_particle_q, adj_0, adj_25);
                    wp::adj_address(var_model_particle_q, var_0, adj_model_particle_q, adj_0, adj_25);
                    // adj: particle_q[index] = model_particle_q[index]                           <L 324>
                }
                // adj: if particle_q:                                                            <L 323>
            }
            adj__reset_selected_world_0(var_24, var_world_mask, var_world_count, var_reset_all, adj_22, adj_world_mask, adj_world_count, adj_reset_all, adj_23);
            wp::adj_address(var_particle_world, var_0, adj_particle_world, adj_0, adj_22);
            // adj: if _reset_selected_world(particle_world[index], world_mask, world_count, reset_all):  <L 322>
        }
        if (var_15) {
            adj_particle_world.shape = adj_17;
        }
        if (!var_16) {
        }
        // adj: if (particle_q or particle_qd) and index < particle_world.shape[0]:               <L 321>
        if (var_1) {
            if (var_9) {
                if (var_body_qd) {
                    wp::adj_array_store(var_body_qd, var_0, var_14, adj_body_qd, adj_0, adj_13);
                    wp::adj_address(var_model_body_qd, var_0, adj_model_body_qd, adj_0, adj_13);
                    // adj: body_qd[index] = model_body_qd[index]                                 <L 320>
                }
                // adj: if body_qd:                                                               <L 319>
                if (var_body_q) {
                    wp::adj_array_store(var_body_q, var_0, var_12, adj_body_q, adj_0, adj_11);
                    wp::adj_address(var_model_body_q, var_0, adj_model_body_q, adj_0, adj_11);
                    // adj: body_q[index] = model_body_q[index]                                   <L 318>
                }
                // adj: if body_q:                                                                <L 317>
            }
            adj__reset_selected_world_0(var_10, var_world_mask, var_world_count, var_reset_all, adj_8, adj_world_mask, adj_world_count, adj_reset_all, adj_9);
            wp::adj_address(var_body_world, var_0, adj_body_world, adj_0, adj_8);
            // adj: if _reset_selected_world(body_world[index], world_mask, world_count, reset_all):  <L 316>
        }
        if (var_1) {
            adj_body_world.shape = adj_3;
        }
        if (!var_2) {
        }
        // adj: if (body_q or body_qd) and index < body_world.shape[0]:                           <L 315>
        // adj: index = wp.tid()                                                                  <L 314>
        // adj: def _reset_newton_state(                                                          <L 299>
        continue;
    }
}



extern "C" __global__ void _sync_affine_body_state_7d471b6c_cuda_kernel_forward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::vec_t<3, wp::float32>> var_reference_particle_q,
    wp::array_t<wp::vec_t<4, wp::int32>> var_affine_body_indices,
    wp::array_t<wp::int32> var_affine_body_ids,
    wp::array_t<wp::vec_t<3, wp::float32>> var_body_com,
    wp::array_t<wp::transform_t<wp::float32>> var_body_q,
    wp::array_t<wp::vec_t<6, wp::float32>> var_body_qd,
    wp::array_t<wp::int32> var_body_mask,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_q,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_qd)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        bool var_0;
        wp::int32 var_1;
        wp::int32* var_2;
        wp::int32* var_3;
        wp::int32 var_4;
        const wp::int32 var_5 = 0;
        bool var_6;
        wp::int32 var_7;
        wp::int32 var_8;
        //---------
        // forward
        // def _sync_affine_body_state(                                                           <L 249>
        // if body_mask and body_mask[affine_body_ids[wp.tid()]] == 0:                            <L 261>
        var_0 = var_body_mask;
        if (var_0) {
            var_1 = builtin_tid1d();
            var_2 = wp::address(var_affine_body_ids, var_1);
            var_4 = wp::load(var_2);
            var_3 = wp::address(var_body_mask, var_4);
            var_7 = wp::load(var_3);
            var_6 = (var_7 == var_5);
            var_0 = var_0 && var_6;
        }
        if (var_0) {
            // return                                                                             <L 262>
            continue;
        }
        // _write_affine_body_state(                                                              <L 263>
        // wp.tid(), affine_body_indices, affine_body_ids, body_com, body_q, body_qd, particle_q, particle_qd       <L 264>
        var_8 = builtin_tid1d();
        _write_affine_body_state_0(var_8, var_affine_body_indices, var_affine_body_ids, var_body_com, var_body_q, var_body_qd, var_particle_q, var_particle_qd);
    }
}



extern "C" __global__ void _sync_affine_body_state_7d471b6c_cuda_kernel_backward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::vec_t<3, wp::float32>> var_reference_particle_q,
    wp::array_t<wp::vec_t<4, wp::int32>> var_affine_body_indices,
    wp::array_t<wp::int32> var_affine_body_ids,
    wp::array_t<wp::vec_t<3, wp::float32>> var_body_com,
    wp::array_t<wp::transform_t<wp::float32>> var_body_q,
    wp::array_t<wp::vec_t<6, wp::float32>> var_body_qd,
    wp::array_t<wp::int32> var_body_mask,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_q,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_qd,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_reference_particle_q,
    wp::array_t<wp::vec_t<4, wp::int32>> adj_affine_body_indices,
    wp::array_t<wp::int32> adj_affine_body_ids,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_body_com,
    wp::array_t<wp::transform_t<wp::float32>> adj_body_q,
    wp::array_t<wp::vec_t<6, wp::float32>> adj_body_qd,
    wp::array_t<wp::int32> adj_body_mask,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_particle_q,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_particle_qd)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        bool var_0;
        wp::int32 var_1;
        wp::int32* var_2;
        wp::int32* var_3;
        wp::int32 var_4;
        const wp::int32 var_5 = 0;
        bool var_6;
        wp::int32 var_7;
        wp::int32 var_8;
        //---------
        // dual vars
        bool adj_0 = {};
        wp::int32 adj_1 = {};
        wp::int32 adj_2 = {};
        wp::int32 adj_3 = {};
        wp::int32 adj_4 = {};
        wp::int32 adj_5 = {};
        bool adj_6 = {};
        wp::int32 adj_7 = {};
        wp::int32 adj_8 = {};
        //---------
        // forward
        // def _sync_affine_body_state(                                                           <L 249>
        // if body_mask and body_mask[affine_body_ids[wp.tid()]] == 0:                            <L 261>
        var_0 = var_body_mask;
        if (var_0) {
            var_1 = builtin_tid1d();
            var_2 = wp::address(var_affine_body_ids, var_1);
            var_4 = wp::load(var_2);
            var_3 = wp::address(var_body_mask, var_4);
            var_7 = wp::load(var_3);
            var_6 = (var_7 == var_5);
            var_0 = var_0 && var_6;
        }
        if (var_0) {
            // return                                                                             <L 262>
            goto label0;
        }
        // _write_affine_body_state(                                                              <L 263>
        // wp.tid(), affine_body_indices, affine_body_ids, body_com, body_q, body_qd, particle_q, particle_qd       <L 264>
        var_8 = builtin_tid1d();
        _write_affine_body_state_0(var_8, var_affine_body_indices, var_affine_body_ids, var_body_com, var_body_q, var_body_qd, var_particle_q, var_particle_qd);
        //---------
        // reverse
        adj__write_affine_body_state_0(var_8, var_affine_body_indices, var_affine_body_ids, var_body_com, var_body_q, var_body_qd, var_particle_q, var_particle_qd, adj_8, adj_affine_body_indices, adj_affine_body_ids, adj_body_com, adj_body_q, adj_body_qd, adj_particle_q, adj_particle_qd);
        // adj: wp.tid(), affine_body_indices, affine_body_ids, body_com, body_q, body_qd, particle_q, particle_qd  <L 264>
        // adj: _write_affine_body_state(                                                         <L 263>
        if (var_0) {
            label0:;
            // adj: return                                                                        <L 262>
        }
        if (var_0) {
            wp::adj_address(var_body_mask, var_4, adj_body_mask, adj_2, adj_3);
            wp::adj_address(var_affine_body_ids, var_1, adj_affine_body_ids, adj_1, adj_2);
        }
        // adj: if body_mask and body_mask[affine_body_ids[wp.tid()]] == 0:                       <L 261>
        // adj: def _sync_affine_body_state(                                                      <L 249>
        continue;
    }
}



extern "C" __global__ void _sync_fixed_affine_body_state_5bc35acd_cuda_kernel_forward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::vec_t<4, wp::int32>> var_affine_body_indices,
    wp::array_t<wp::int32> var_affine_body_ids,
    wp::array_t<wp::int32> var_fixed_affine_body_flags,
    wp::array_t<wp::int32> var_rotation_locked_affine_body_flags,
    wp::array_t<wp::vec_t<3, wp::float32>> var_body_com,
    wp::array_t<wp::transform_t<wp::float32>> var_body_q,
    wp::float32 var_dt,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_q,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_qd)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        wp::int32 var_0;
        wp::int32* var_1;
        const wp::int32 var_2 = 0;
        bool var_3;
        wp::int32 var_4;
        bool var_5;
        bool var_6;
        wp::int32* var_7;
        const wp::int32 var_8 = 0;
        bool var_9;
        wp::int32 var_10;
        wp::int32* var_11;
        wp::int32 var_12;
        wp::int32 var_13;
        wp::vec_t<4, wp::int32>* var_14;
        wp::vec_t<4, wp::int32> var_15;
        wp::vec_t<4, wp::int32> var_16;
        wp::transform_t<wp::float32>* var_17;
        wp::transform_t<wp::float32> var_18;
        wp::transform_t<wp::float32> var_19;
        wp::quat_t<wp::float32> var_20;
        wp::vec_t<3, wp::float32>* var_21;
        wp::vec_t<3, wp::float32> var_22;
        wp::vec_t<3, wp::float32> var_23;
        const wp::float32 var_24 = 1.0;
        const wp::float32 var_25 = 0.0;
        const wp::float32 var_26 = 0.0;
        wp::vec_t<3, wp::float32> var_27;
        wp::vec_t<3, wp::float32> var_28;
        const wp::float32 var_29 = 0.0;
        const wp::float32 var_30 = 1.0;
        const wp::float32 var_31 = 0.0;
        wp::vec_t<3, wp::float32> var_32;
        wp::vec_t<3, wp::float32> var_33;
        const wp::float32 var_34 = 0.0;
        const wp::float32 var_35 = 0.0;
        const wp::float32 var_36 = 1.0;
        wp::vec_t<3, wp::float32> var_37;
        wp::vec_t<3, wp::float32> var_38;
        const wp::int32 var_39 = 4;
        wp::range_t var_40;
        wp::int32 var_41;
        bool var_42;
        const wp::int32 var_43 = 0;
        bool var_44;
        bool var_45;
        wp::int32 var_46;
        wp::vec_t<3, wp::float32> var_47;
        const wp::int32 var_48 = 1;
        bool var_49;
        wp::vec_t<3, wp::float32> var_50;
        const wp::int32 var_51 = 2;
        bool var_52;
        wp::vec_t<3, wp::float32> var_53;
        const wp::int32 var_54 = 3;
        bool var_55;
        wp::vec_t<3, wp::float32> var_56;
        wp::vec_t<3, wp::float32> var_57;
        wp::vec_t<3, wp::float32> var_58;
        wp::vec_t<3, wp::float32> var_59;
        wp::vec_t<3, wp::float32>* var_60;
        wp::vec_t<3, wp::float32> var_61;
        wp::vec_t<3, wp::float32> var_62;
        wp::vec_t<3, wp::float32> var_63;
        //---------
        // forward
        // def _sync_fixed_affine_body_state(                                                     <L 387>
        // affine = wp.tid()                                                                      <L 398>
        var_0 = builtin_tid1d();
        // fixed = fixed_affine_body_flags[affine] != 0                                           <L 399>
        var_1 = wp::address(var_fixed_affine_body_flags, var_0);
        var_4 = wp::load(var_1);
        var_3 = (var_4 != var_2);
        // if not fixed and rotation_locked_affine_body_flags[affine] == 0:                       <L 400>
        var_6 = wp::unot(var_3);
        var_5 = var_6;
        if (var_5) {
            var_7 = wp::address(var_rotation_locked_affine_body_flags, var_0);
            var_10 = wp::load(var_7);
            var_9 = (var_10 == var_8);
            var_5 = var_5 && var_9;
        }
        if (var_5) {
            // return                                                                             <L 401>
            continue;
        }
        // body = affine_body_ids[affine]                                                         <L 402>
        var_11 = wp::address(var_affine_body_ids, var_0);
        var_13 = wp::load(var_11);
        var_12 = wp::copy(var_13);
        // indices = affine_body_indices[affine]                                                  <L 403>
        var_14 = wp::address(var_affine_body_indices, var_0);
        var_16 = wp::load(var_14);
        var_15 = wp::copy(var_16);
        // pose = body_q[body]                                                                    <L 404>
        var_17 = wp::address(var_body_q, var_12);
        var_19 = wp::load(var_17);
        var_18 = wp::copy(var_19);
        // rotation = wp.transform_get_rotation(pose)                                             <L 405>
        var_20 = wp::transform_get_rotation(var_18);
        // origin = wp.transform_point(pose, body_com[affine])                                    <L 406>
        var_21 = wp::address(var_body_com, var_0);
        var_23 = wp::load(var_21);
        var_22 = wp::transform_point(var_18, var_23);
        // axis_x = wp.quat_rotate(rotation, wp.vec3(1.0, 0.0, 0.0))                              <L 407>
        var_27 = wp::vec_t<3, wp::float32>(var_24, var_25, var_26);
        var_28 = wp::quat_rotate(var_20, var_27);
        // axis_y = wp.quat_rotate(rotation, wp.vec3(0.0, 1.0, 0.0))                              <L 408>
        var_32 = wp::vec_t<3, wp::float32>(var_29, var_30, var_31);
        var_33 = wp::quat_rotate(var_20, var_32);
        // axis_z = wp.quat_rotate(rotation, wp.vec3(0.0, 0.0, 1.0))                              <L 409>
        var_37 = wp::vec_t<3, wp::float32>(var_34, var_35, var_36);
        var_38 = wp::quat_rotate(var_20, var_37);
        // for corner in range(4):                                                                <L 410>
        var_40 = wp::range(var_39);
        start_for_1:;
            if (iter_cmp(var_40) == 0) goto end_for_1;
            var_41 = wp::iter_next(var_40);
            // if corner == 0 and not fixed:                                                      <L 411>
            var_44 = (var_41 == var_43);
            var_42 = var_44;
            if (var_42) {
                var_45 = wp::unot(var_3);
                var_42 = var_42 && var_45;
            }
            if (var_42) {
                // continue                                                                       <L 412>
                goto start_for_1;
            }
            // particle = indices[corner]                                                         <L 413>
            var_46 = wp::extract(var_15, var_41);
            // current = origin                                                                   <L 414>
            var_47 = wp::copy(var_22);
            // if corner == 1:                                                                    <L 415>
            var_49 = (var_41 == var_48);
            if (var_49) {
                // current = axis_x                                                               <L 416>
                var_50 = wp::copy(var_28);
            }
            if (!var_49) {
                // elif corner == 2:                                                              <L 417>
                var_52 = (var_41 == var_51);
                if (var_52) {
                    // current = axis_y                                                           <L 418>
                    var_53 = wp::copy(var_33);
                }
                if (!var_52) {
                    // elif corner == 3:                                                          <L 419>
                    var_55 = (var_41 == var_54);
                    if (var_55) {
                        // current = axis_z                                                       <L 420>
                        var_56 = wp::copy(var_38);
                    }
                    var_57 = wp::where(var_55, var_56, var_47);
                }
                var_58 = wp::where(var_52, var_53, var_57);
            }
            var_59 = wp::where(var_49, var_50, var_58);
            // particle_qd[particle] = (current - particle_q[particle]) / dt                      <L 423>
            var_60 = wp::address(var_particle_q, var_46);
            var_62 = wp::load(var_60);
            var_61 = wp::sub(var_59, var_62);
            var_63 = wp::div(var_61, var_dt);
            wp::array_store(var_particle_qd, var_46, var_63);
            // particle_q[particle] = current                                                     <L 424>
            wp::array_store(var_particle_q, var_46, var_59);
            goto start_for_1;
        end_for_1:;
    }
}



extern "C" __global__ void _sync_fixed_affine_body_state_5bc35acd_cuda_kernel_backward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::vec_t<4, wp::int32>> var_affine_body_indices,
    wp::array_t<wp::int32> var_affine_body_ids,
    wp::array_t<wp::int32> var_fixed_affine_body_flags,
    wp::array_t<wp::int32> var_rotation_locked_affine_body_flags,
    wp::array_t<wp::vec_t<3, wp::float32>> var_body_com,
    wp::array_t<wp::transform_t<wp::float32>> var_body_q,
    wp::float32 var_dt,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_q,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_qd,
    wp::array_t<wp::vec_t<4, wp::int32>> adj_affine_body_indices,
    wp::array_t<wp::int32> adj_affine_body_ids,
    wp::array_t<wp::int32> adj_fixed_affine_body_flags,
    wp::array_t<wp::int32> adj_rotation_locked_affine_body_flags,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_body_com,
    wp::array_t<wp::transform_t<wp::float32>> adj_body_q,
    wp::float32 adj_dt,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_particle_q,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_particle_qd)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        wp::int32 var_0;
        wp::int32* var_1;
        const wp::int32 var_2 = 0;
        bool var_3;
        wp::int32 var_4;
        bool var_5;
        bool var_6;
        wp::int32* var_7;
        const wp::int32 var_8 = 0;
        bool var_9;
        wp::int32 var_10;
        wp::int32* var_11;
        wp::int32 var_12;
        wp::int32 var_13;
        wp::vec_t<4, wp::int32>* var_14;
        wp::vec_t<4, wp::int32> var_15;
        wp::vec_t<4, wp::int32> var_16;
        wp::transform_t<wp::float32>* var_17;
        wp::transform_t<wp::float32> var_18;
        wp::transform_t<wp::float32> var_19;
        wp::quat_t<wp::float32> var_20;
        wp::vec_t<3, wp::float32>* var_21;
        wp::vec_t<3, wp::float32> var_22;
        wp::vec_t<3, wp::float32> var_23;
        const wp::float32 var_24 = 1.0;
        const wp::float32 var_25 = 0.0;
        const wp::float32 var_26 = 0.0;
        wp::vec_t<3, wp::float32> var_27;
        wp::vec_t<3, wp::float32> var_28;
        const wp::float32 var_29 = 0.0;
        const wp::float32 var_30 = 1.0;
        const wp::float32 var_31 = 0.0;
        wp::vec_t<3, wp::float32> var_32;
        wp::vec_t<3, wp::float32> var_33;
        const wp::float32 var_34 = 0.0;
        const wp::float32 var_35 = 0.0;
        const wp::float32 var_36 = 1.0;
        wp::vec_t<3, wp::float32> var_37;
        wp::vec_t<3, wp::float32> var_38;
        const wp::int32 var_39 = 4;
        wp::range_t var_40;
        wp::int32 var_41;
        bool var_42;
        const wp::int32 var_43 = 0;
        bool var_44;
        bool var_45;
        wp::int32 var_46;
        wp::vec_t<3, wp::float32> var_47;
        const wp::int32 var_48 = 1;
        bool var_49;
        wp::vec_t<3, wp::float32> var_50;
        const wp::int32 var_51 = 2;
        bool var_52;
        wp::vec_t<3, wp::float32> var_53;
        const wp::int32 var_54 = 3;
        bool var_55;
        wp::vec_t<3, wp::float32> var_56;
        wp::vec_t<3, wp::float32> var_57;
        wp::vec_t<3, wp::float32> var_58;
        wp::vec_t<3, wp::float32> var_59;
        wp::vec_t<3, wp::float32>* var_60;
        wp::vec_t<3, wp::float32> var_61;
        wp::vec_t<3, wp::float32> var_62;
        wp::vec_t<3, wp::float32> var_63;
        //---------
        // dual vars
        wp::int32 adj_0 = {};
        wp::int32 adj_1 = {};
        wp::int32 adj_2 = {};
        bool adj_3 = {};
        wp::int32 adj_4 = {};
        bool adj_5 = {};
        bool adj_6 = {};
        wp::int32 adj_7 = {};
        wp::int32 adj_8 = {};
        bool adj_9 = {};
        wp::int32 adj_10 = {};
        wp::int32 adj_11 = {};
        wp::int32 adj_12 = {};
        wp::int32 adj_13 = {};
        wp::vec_t<4, wp::int32> adj_14 = {};
        wp::vec_t<4, wp::int32> adj_15 = {};
        wp::vec_t<4, wp::int32> adj_16 = {};
        wp::transform_t<wp::float32> adj_17 = {};
        wp::transform_t<wp::float32> adj_18 = {};
        wp::transform_t<wp::float32> adj_19 = {};
        wp::quat_t<wp::float32> adj_20 = {};
        wp::vec_t<3, wp::float32> adj_21 = {};
        wp::vec_t<3, wp::float32> adj_22 = {};
        wp::vec_t<3, wp::float32> adj_23 = {};
        wp::float32 adj_24 = {};
        wp::float32 adj_25 = {};
        wp::float32 adj_26 = {};
        wp::vec_t<3, wp::float32> adj_27 = {};
        wp::vec_t<3, wp::float32> adj_28 = {};
        wp::float32 adj_29 = {};
        wp::float32 adj_30 = {};
        wp::float32 adj_31 = {};
        wp::vec_t<3, wp::float32> adj_32 = {};
        wp::vec_t<3, wp::float32> adj_33 = {};
        wp::float32 adj_34 = {};
        wp::float32 adj_35 = {};
        wp::float32 adj_36 = {};
        wp::vec_t<3, wp::float32> adj_37 = {};
        wp::vec_t<3, wp::float32> adj_38 = {};
        wp::int32 adj_39 = {};
        wp::range_t adj_40 = {};
        wp::int32 adj_41 = {};
        bool adj_42 = {};
        wp::int32 adj_43 = {};
        bool adj_44 = {};
        bool adj_45 = {};
        wp::int32 adj_46 = {};
        wp::vec_t<3, wp::float32> adj_47 = {};
        wp::int32 adj_48 = {};
        bool adj_49 = {};
        wp::vec_t<3, wp::float32> adj_50 = {};
        wp::int32 adj_51 = {};
        bool adj_52 = {};
        wp::vec_t<3, wp::float32> adj_53 = {};
        wp::int32 adj_54 = {};
        bool adj_55 = {};
        wp::vec_t<3, wp::float32> adj_56 = {};
        wp::vec_t<3, wp::float32> adj_57 = {};
        wp::vec_t<3, wp::float32> adj_58 = {};
        wp::vec_t<3, wp::float32> adj_59 = {};
        wp::vec_t<3, wp::float32> adj_60 = {};
        wp::vec_t<3, wp::float32> adj_61 = {};
        wp::vec_t<3, wp::float32> adj_62 = {};
        wp::vec_t<3, wp::float32> adj_63 = {};
        //---------
        // forward
        // def _sync_fixed_affine_body_state(                                                     <L 387>
        // affine = wp.tid()                                                                      <L 398>
        var_0 = builtin_tid1d();
        // fixed = fixed_affine_body_flags[affine] != 0                                           <L 399>
        var_1 = wp::address(var_fixed_affine_body_flags, var_0);
        var_4 = wp::load(var_1);
        var_3 = (var_4 != var_2);
        // if not fixed and rotation_locked_affine_body_flags[affine] == 0:                       <L 400>
        var_6 = wp::unot(var_3);
        var_5 = var_6;
        if (var_5) {
            var_7 = wp::address(var_rotation_locked_affine_body_flags, var_0);
            var_10 = wp::load(var_7);
            var_9 = (var_10 == var_8);
            var_5 = var_5 && var_9;
        }
        if (var_5) {
            // return                                                                             <L 401>
            goto label0;
        }
        // body = affine_body_ids[affine]                                                         <L 402>
        var_11 = wp::address(var_affine_body_ids, var_0);
        var_13 = wp::load(var_11);
        var_12 = wp::copy(var_13);
        // indices = affine_body_indices[affine]                                                  <L 403>
        var_14 = wp::address(var_affine_body_indices, var_0);
        var_16 = wp::load(var_14);
        var_15 = wp::copy(var_16);
        // pose = body_q[body]                                                                    <L 404>
        var_17 = wp::address(var_body_q, var_12);
        var_19 = wp::load(var_17);
        var_18 = wp::copy(var_19);
        // rotation = wp.transform_get_rotation(pose)                                             <L 405>
        var_20 = wp::transform_get_rotation(var_18);
        // origin = wp.transform_point(pose, body_com[affine])                                    <L 406>
        var_21 = wp::address(var_body_com, var_0);
        var_23 = wp::load(var_21);
        var_22 = wp::transform_point(var_18, var_23);
        // axis_x = wp.quat_rotate(rotation, wp.vec3(1.0, 0.0, 0.0))                              <L 407>
        var_27 = wp::vec_t<3, wp::float32>(var_24, var_25, var_26);
        var_28 = wp::quat_rotate(var_20, var_27);
        // axis_y = wp.quat_rotate(rotation, wp.vec3(0.0, 1.0, 0.0))                              <L 408>
        var_32 = wp::vec_t<3, wp::float32>(var_29, var_30, var_31);
        var_33 = wp::quat_rotate(var_20, var_32);
        // axis_z = wp.quat_rotate(rotation, wp.vec3(0.0, 0.0, 1.0))                              <L 409>
        var_37 = wp::vec_t<3, wp::float32>(var_34, var_35, var_36);
        var_38 = wp::quat_rotate(var_20, var_37);
        // for corner in range(4):                                                                <L 410>
        var_40 = wp::range(var_39);
        //---------
        // reverse
        var_40 = wp::iter_reverse(var_40);
        start_for_1:;
            if (iter_cmp(var_40) == 0) goto end_for_1;
            var_41 = wp::iter_next(var_40);
        	adj_42 = {};
        	adj_43 = {};
        	adj_44 = {};
        	adj_45 = {};
        	adj_46 = {};
        	adj_47 = {};
        	adj_48 = {};
        	adj_49 = {};
        	adj_50 = {};
        	adj_51 = {};
        	adj_52 = {};
        	adj_53 = {};
        	adj_54 = {};
        	adj_55 = {};
        	adj_56 = {};
        	adj_57 = {};
        	adj_58 = {};
        	adj_59 = {};
        	adj_60 = {};
        	adj_61 = {};
        	adj_62 = {};
        	adj_63 = {};
            // if corner == 0 and not fixed:                                                      <L 411>
            var_44 = (var_41 == var_43);
            var_42 = var_44;
            if (var_42) {
                var_45 = wp::unot(var_3);
                var_42 = var_42 && var_45;
            }
            if (var_42) {
                // continue                                                                       <L 412>
                goto start_for_1;
            }
            // particle = indices[corner]                                                         <L 413>
            var_46 = wp::extract(var_15, var_41);
            // current = origin                                                                   <L 414>
            var_47 = wp::copy(var_22);
            // if corner == 1:                                                                    <L 415>
            var_49 = (var_41 == var_48);
            if (var_49) {
                // current = axis_x                                                               <L 416>
                var_50 = wp::copy(var_28);
            }
            if (!var_49) {
                // elif corner == 2:                                                              <L 417>
                var_52 = (var_41 == var_51);
                if (var_52) {
                    // current = axis_y                                                           <L 418>
                    var_53 = wp::copy(var_33);
                }
                if (!var_52) {
                    // elif corner == 3:                                                          <L 419>
                    var_55 = (var_41 == var_54);
                    if (var_55) {
                        // current = axis_z                                                       <L 420>
                        var_56 = wp::copy(var_38);
                    }
                    var_57 = wp::where(var_55, var_56, var_47);
                }
                var_58 = wp::where(var_52, var_53, var_57);
            }
            var_59 = wp::where(var_49, var_50, var_58);
            // particle_qd[particle] = (current - particle_q[particle]) / dt                      <L 423>
            var_60 = wp::address(var_particle_q, var_46);
            var_62 = wp::load(var_60);
            var_61 = wp::sub(var_59, var_62);
            var_63 = wp::div(var_61, var_dt);
            // wp::array_store(var_particle_qd, var_46, var_63);
            // particle_q[particle] = current                                                     <L 424>
            // wp::array_store(var_particle_q, var_46, var_59);
            wp::adj_array_store(var_particle_q, var_46, var_59, adj_particle_q, adj_46, adj_59);
            // adj: particle_q[particle] = current                                                <L 424>
            wp::adj_array_store(var_particle_qd, var_46, var_63, adj_particle_qd, adj_46, adj_63);
            wp::adj_div(var_61, var_dt, adj_61, adj_dt, adj_63);
            wp::adj_sub(var_59, var_62, adj_59, adj_60, adj_61);
            wp::adj_address(var_particle_q, var_46, adj_particle_q, adj_46, adj_60);
            // adj: particle_qd[particle] = (current - particle_q[particle]) / dt                 <L 423>
            wp::adj_where(var_49, var_50, var_58, adj_49, adj_50, adj_58, adj_59);
            if (!var_49) {
                wp::adj_where(var_52, var_53, var_57, adj_52, adj_53, adj_57, adj_58);
                if (!var_52) {
                    wp::adj_where(var_55, var_56, var_47, adj_55, adj_56, adj_47, adj_57);
                    if (var_55) {
                        wp::adj_copy(var_38, adj_38, adj_56);
                        // adj: current = axis_z                                                  <L 420>
                    }
                    // adj: elif corner == 3:                                                     <L 419>
                }
                if (var_52) {
                    wp::adj_copy(var_33, adj_33, adj_53);
                    // adj: current = axis_y                                                      <L 418>
                }
                // adj: elif corner == 2:                                                         <L 417>
            }
            if (var_49) {
                wp::adj_copy(var_28, adj_28, adj_50);
                // adj: current = axis_x                                                          <L 416>
            }
            // adj: if corner == 1:                                                               <L 415>
            wp::adj_copy(var_22, adj_22, adj_47);
            // adj: current = origin                                                              <L 414>
            wp::adj_extract(var_15, var_41, adj_15, adj_41, adj_46);
            // adj: particle = indices[corner]                                                    <L 413>
            if (var_42) {
                // adj: continue                                                                  <L 412>
            }
            if (var_42) {
            }
            // adj: if corner == 0 and not fixed:                                                 <L 411>
        	goto start_for_1;
        end_for_1:;
        // adj: for corner in range(4):                                                           <L 410>
        wp::adj_quat_rotate(var_20, var_37, adj_20, adj_37, adj_38);
        wp::adj_vec_t(var_34, var_35, var_36, adj_34, adj_35, adj_36, adj_37);
        // adj: axis_z = wp.quat_rotate(rotation, wp.vec3(0.0, 0.0, 1.0))                         <L 409>
        wp::adj_quat_rotate(var_20, var_32, adj_20, adj_32, adj_33);
        wp::adj_vec_t(var_29, var_30, var_31, adj_29, adj_30, adj_31, adj_32);
        // adj: axis_y = wp.quat_rotate(rotation, wp.vec3(0.0, 1.0, 0.0))                         <L 408>
        wp::adj_quat_rotate(var_20, var_27, adj_20, adj_27, adj_28);
        wp::adj_vec_t(var_24, var_25, var_26, adj_24, adj_25, adj_26, adj_27);
        // adj: axis_x = wp.quat_rotate(rotation, wp.vec3(1.0, 0.0, 0.0))                         <L 407>
        wp::adj_transform_point(var_18, var_23, adj_18, adj_21, adj_22);
        wp::adj_address(var_body_com, var_0, adj_body_com, adj_0, adj_21);
        // adj: origin = wp.transform_point(pose, body_com[affine])                               <L 406>
        wp::adj_transform_get_rotation(var_18, adj_18, adj_20);
        // adj: rotation = wp.transform_get_rotation(pose)                                        <L 405>
        wp::adj_copy(var_19, adj_17, adj_18);
        wp::adj_address(var_body_q, var_12, adj_body_q, adj_12, adj_17);
        // adj: pose = body_q[body]                                                               <L 404>
        wp::adj_copy(var_16, adj_14, adj_15);
        wp::adj_address(var_affine_body_indices, var_0, adj_affine_body_indices, adj_0, adj_14);
        // adj: indices = affine_body_indices[affine]                                             <L 403>
        wp::adj_copy(var_13, adj_11, adj_12);
        wp::adj_address(var_affine_body_ids, var_0, adj_affine_body_ids, adj_0, adj_11);
        // adj: body = affine_body_ids[affine]                                                    <L 402>
        if (var_5) {
            label0:;
            // adj: return                                                                        <L 401>
        }
        if (var_5) {
            wp::adj_address(var_rotation_locked_affine_body_flags, var_0, adj_rotation_locked_affine_body_flags, adj_0, adj_7);
        }
        // adj: if not fixed and rotation_locked_affine_body_flags[affine] == 0:                  <L 400>
        wp::adj_address(var_fixed_affine_body_flags, var_0, adj_fixed_affine_body_flags, adj_0, adj_1);
        // adj: fixed = fixed_affine_body_flags[affine] != 0                                      <L 399>
        // adj: affine = wp.tid()                                                                 <L 398>
        // adj: def _sync_fixed_affine_body_state(                                                <L 387>
        continue;
    }
}



extern "C" __global__ void _sync_selected_affine_body_state_ac69f891_cuda_kernel_forward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::vec_t<4, wp::int32>> var_affine_body_indices,
    wp::array_t<wp::int32> var_affine_body_ids,
    wp::array_t<wp::vec_t<3, wp::float32>> var_body_com,
    wp::array_t<wp::transform_t<wp::float32>> var_body_q,
    wp::array_t<wp::vec_t<6, wp::float32>> var_body_qd,
    wp::array_t<wp::int32> var_body_world,
    wp::array_t<bool> var_world_mask,
    wp::int32 var_world_count,
    bool var_reset_all,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_q,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_qd)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        wp::int32 var_0;
        bool var_1;
        wp::int32* var_2;
        wp::int32* var_3;
        wp::int32 var_4;
        bool var_5;
        wp::int32 var_6;
        bool var_7;
        //---------
        // forward
        // def _sync_selected_affine_body_state(                                                  <L 269>
        // affine_body = wp.tid()                                                                 <L 282>
        var_0 = builtin_tid1d();
        // if not reset_all:                                                                      <L 283>
        var_1 = wp::unot(var_reset_all);
        if (var_1) {
            // if not reset_world_selected(body_world[affine_body_ids[affine_body]], world_mask, world_count):       <L 284>
            var_2 = wp::address(var_affine_body_ids, var_0);
            var_4 = wp::load(var_2);
            var_3 = wp::address(var_body_world, var_4);
            var_6 = wp::load(var_3);
            var_5 = reset_world_selected_0(var_6, var_world_mask, var_world_count);
            var_7 = wp::unot(var_5);
            if (var_7) {
                // return                                                                         <L 285>
                continue;
            }
        }
        // _write_affine_body_state(                                                              <L 286>
        // affine_body, affine_body_indices, affine_body_ids, body_com, body_q, body_qd, particle_q, particle_qd       <L 287>
        _write_affine_body_state_0(var_0, var_affine_body_indices, var_affine_body_ids, var_body_com, var_body_q, var_body_qd, var_particle_q, var_particle_qd);
    }
}



extern "C" __global__ void _sync_selected_affine_body_state_ac69f891_cuda_kernel_backward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::vec_t<4, wp::int32>> var_affine_body_indices,
    wp::array_t<wp::int32> var_affine_body_ids,
    wp::array_t<wp::vec_t<3, wp::float32>> var_body_com,
    wp::array_t<wp::transform_t<wp::float32>> var_body_q,
    wp::array_t<wp::vec_t<6, wp::float32>> var_body_qd,
    wp::array_t<wp::int32> var_body_world,
    wp::array_t<bool> var_world_mask,
    wp::int32 var_world_count,
    bool var_reset_all,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_q,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_qd,
    wp::array_t<wp::vec_t<4, wp::int32>> adj_affine_body_indices,
    wp::array_t<wp::int32> adj_affine_body_ids,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_body_com,
    wp::array_t<wp::transform_t<wp::float32>> adj_body_q,
    wp::array_t<wp::vec_t<6, wp::float32>> adj_body_qd,
    wp::array_t<wp::int32> adj_body_world,
    wp::array_t<bool> adj_world_mask,
    wp::int32 adj_world_count,
    bool adj_reset_all,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_particle_q,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_particle_qd)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        wp::int32 var_0;
        bool var_1;
        wp::int32* var_2;
        wp::int32* var_3;
        wp::int32 var_4;
        bool var_5;
        wp::int32 var_6;
        bool var_7;
        //---------
        // dual vars
        wp::int32 adj_0 = {};
        bool adj_1 = {};
        wp::int32 adj_2 = {};
        wp::int32 adj_3 = {};
        wp::int32 adj_4 = {};
        bool adj_5 = {};
        wp::int32 adj_6 = {};
        bool adj_7 = {};
        //---------
        // forward
        // def _sync_selected_affine_body_state(                                                  <L 269>
        // affine_body = wp.tid()                                                                 <L 282>
        var_0 = builtin_tid1d();
        // if not reset_all:                                                                      <L 283>
        var_1 = wp::unot(var_reset_all);
        if (var_1) {
            // if not reset_world_selected(body_world[affine_body_ids[affine_body]], world_mask, world_count):       <L 284>
            var_2 = wp::address(var_affine_body_ids, var_0);
            var_4 = wp::load(var_2);
            var_3 = wp::address(var_body_world, var_4);
            var_6 = wp::load(var_3);
            var_5 = reset_world_selected_0(var_6, var_world_mask, var_world_count);
            var_7 = wp::unot(var_5);
            if (var_7) {
                // return                                                                         <L 285>
                goto label0;
            }
        }
        // _write_affine_body_state(                                                              <L 286>
        // affine_body, affine_body_indices, affine_body_ids, body_com, body_q, body_qd, particle_q, particle_qd       <L 287>
        _write_affine_body_state_0(var_0, var_affine_body_indices, var_affine_body_ids, var_body_com, var_body_q, var_body_qd, var_particle_q, var_particle_qd);
        //---------
        // reverse
        adj__write_affine_body_state_0(var_0, var_affine_body_indices, var_affine_body_ids, var_body_com, var_body_q, var_body_qd, var_particle_q, var_particle_qd, adj_0, adj_affine_body_indices, adj_affine_body_ids, adj_body_com, adj_body_q, adj_body_qd, adj_particle_q, adj_particle_qd);
        // adj: affine_body, affine_body_indices, affine_body_ids, body_com, body_q, body_qd, particle_q, particle_qd  <L 287>
        // adj: _write_affine_body_state(                                                         <L 286>
        if (var_1) {
            if (var_7) {
                label0:;
                // adj: return                                                                    <L 285>
            }
            adj_reset_world_selected_0(var_6, var_world_mask, var_world_count, adj_3, adj_world_mask, adj_world_count, adj_5);
            wp::adj_address(var_body_world, var_4, adj_body_world, adj_2, adj_3);
            wp::adj_address(var_affine_body_ids, var_0, adj_affine_body_ids, adj_0, adj_2);
            // adj: if not reset_world_selected(body_world[affine_body_ids[affine_body]], world_mask, world_count):  <L 284>
        }
        // adj: if not reset_all:                                                                 <L 283>
        // adj: affine_body = wp.tid()                                                            <L 282>
        // adj: def _sync_selected_affine_body_state(                                             <L 269>
        continue;
    }
}



extern "C" __global__ void _predict_affine_body_inertia_092ca3c1_cuda_kernel_forward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::transform_t<wp::float32>> var_body_q,
    wp::array_t<wp::vec_t<6, wp::float32>> var_body_qd,
    wp::array_t<wp::vec_t<6, wp::float32>> var_body_f,
    wp::array_t<wp::int32> var_affine_body_ids,
    wp::array_t<wp::vec_t<3, wp::float32>> var_body_com,
    wp::array_t<wp::float32> var_body_mass,
    wp::array_t<wp::mat_t<3, 3, wp::float32>> var_affine_body_inertia,
    wp::array_t<wp::int32> var_fixed_affine_body_flags,
    wp::int32 var_inertia_mode,
    wp::float32 var_dt,
    wp::array_t<wp::transform_t<wp::float32>> var_predicted_body_q,
    wp::array_t<wp::vec_t<6, wp::float32>> var_predicted_body_qd)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        wp::int32 var_0;
        wp::int32* var_1;
        wp::int32 var_2;
        wp::int32 var_3;
        wp::transform_t<wp::float32>* var_4;
        wp::transform_t<wp::float32> var_5;
        wp::transform_t<wp::float32> var_6;
        wp::int32* var_7;
        const wp::int32 var_8 = 0;
        bool var_9;
        wp::int32 var_10;
        const wp::float32 var_11 = 0.0;
        wp::vec_t<3, wp::float32> var_12;
        const wp::float32 var_13 = 0.0;
        wp::vec_t<3, wp::float32> var_14;
        wp::vec_t<6, wp::float32> var_15;
        wp::quat_t<wp::float32> var_16;
        wp::vec_t<6, wp::float32>* var_17;
        wp::vec_t<6, wp::float32> var_18;
        wp::vec_t<6, wp::float32> var_19;
        wp::vec_t<6, wp::float32>* var_20;
        wp::vec_t<6, wp::float32> var_21;
        wp::vec_t<6, wp::float32> var_22;
        wp::float32* var_23;
        wp::float32 var_24;
        wp::float32 var_25;
        wp::vec_t<3, wp::float32> var_26;
        wp::vec_t<3, wp::float32> var_27;
        wp::vec_t<3, wp::float32> var_28;
        wp::vec_t<3, wp::float32> var_29;
        wp::vec_t<3, wp::float32> var_30;
        wp::vec_t<3, wp::float32> var_31;
        wp::vec_t<3, wp::float32> var_32;
        wp::mat_t<3, 3, wp::float32>* var_33;
        wp::mat_t<3, 3, wp::float32> var_34;
        wp::mat_t<3, 3, wp::float32> var_35;
        wp::mat_t<3, 3, wp::float32> var_36;
        wp::vec_t<3, wp::float32> var_37;
        wp::vec_t<3, wp::float32> var_38;
        wp::vec_t<3, wp::float32> var_39;
        wp::vec_t<3, wp::float32> var_40;
        wp::vec_t<3, wp::float32> var_41;
        wp::vec_t<3, wp::float32> var_42;
        wp::vec_t<3, wp::float32>* var_43;
        wp::vec_t<3, wp::float32> var_44;
        wp::vec_t<3, wp::float32> var_45;
        wp::vec_t<3, wp::float32> var_46;
        wp::vec_t<3, wp::float32> var_47;
        wp::vec_t<3, wp::float32> var_48;
        const wp::int32 var_49 = 5;
        bool var_50;
        wp::vec_t<3, wp::float32> var_51;
        wp::vec_t<3, wp::float32> var_52;
        wp::vec_t<3, wp::float32> var_53;
        wp::vec_t<3, wp::float32> var_54;
        wp::mat_t<3, 3, wp::float32> var_55;
        wp::vec_t<3, wp::float32> var_56;
        wp::mat_t<3, 3, wp::float32> var_57;
        wp::vec_t<3, wp::float32> var_58;
        wp::mat_t<3, 3, wp::float32> var_59;
        wp::quat_t<wp::float32> var_60;
        wp::quat_t<wp::float32> var_61;
        wp::vec_t<3, wp::float32> var_62;
        wp::vec_t<3, wp::float32> var_63;
        bool var_64;
        wp::vec_t<3, wp::float32> var_65;
        wp::vec_t<3, wp::float32> var_66;
        wp::vec_t<3, wp::float32> var_67;
        wp::vec_t<3, wp::float32>* var_68;
        wp::vec_t<3, wp::float32> var_69;
        wp::vec_t<3, wp::float32> var_70;
        wp::vec_t<3, wp::float32> var_71;
        wp::transform_t<wp::float32> var_72;
        wp::vec_t<6, wp::float32> var_73;
        //---------
        // forward
        // def _predict_affine_body_inertia(                                                      <L 110>
        // affine_body = wp.tid()                                                                 <L 125>
        var_0 = builtin_tid1d();
        // body = affine_body_ids[affine_body]                                                    <L 126>
        var_1 = wp::address(var_affine_body_ids, var_0);
        var_3 = wp::load(var_1);
        var_2 = wp::copy(var_3);
        // pose = body_q[body]                                                                    <L 127>
        var_4 = wp::address(var_body_q, var_2);
        var_6 = wp::load(var_4);
        var_5 = wp::copy(var_6);
        // if fixed_affine_body_flags[affine_body] != 0:                                          <L 128>
        var_7 = wp::address(var_fixed_affine_body_flags, var_0);
        var_10 = wp::load(var_7);
        var_9 = (var_10 != var_8);
        if (var_9) {
            // predicted_body_q[body] = pose                                                      <L 129>
            wp::array_store(var_predicted_body_q, var_2, var_5);
            // predicted_body_qd[body] = wp.spatial_vector(wp.vec3(0.0), wp.vec3(0.0))            <L 130>
            var_12 = wp::vec_t<3, wp::float32>(var_11);
            var_14 = wp::vec_t<3, wp::float32>(var_13);
            var_15 = wp::vec_t<6, wp::float32>(var_12, var_14);
            wp::array_store(var_predicted_body_qd, var_2, var_15);
            // return                                                                             <L 131>
            continue;
        }
        // rotation = wp.transform_get_rotation(pose)                                             <L 132>
        var_16 = wp::transform_get_rotation(var_5);
        // velocity = body_qd[body]                                                               <L 133>
        var_17 = wp::address(var_body_qd, var_2);
        var_19 = wp::load(var_17);
        var_18 = wp::copy(var_19);
        // wrench = body_f[body]                                                                  <L 134>
        var_20 = wp::address(var_body_f, var_2);
        var_22 = wp::load(var_20);
        var_21 = wp::copy(var_22);
        // mass = body_mass[body]                                                                 <L 135>
        var_23 = wp::address(var_body_mass, var_2);
        var_25 = wp::load(var_23);
        var_24 = wp::copy(var_25);
        // linear_velocity = wp.spatial_top(velocity) + dt * wp.spatial_top(wrench) / mass        <L 136>
        var_26 = wp::spatial_top(var_18);
        var_27 = wp::spatial_top(var_21);
        var_28 = wp::mul(var_dt, var_27);
        var_29 = wp::div(var_28, var_24);
        var_30 = wp::add(var_26, var_29);
        // angular_velocity = wp.spatial_bottom(velocity)                                         <L 137>
        var_31 = wp::spatial_bottom(var_18);
        // body_angular_velocity = wp.quat_rotate_inv(rotation, angular_velocity)                 <L 138>
        var_32 = wp::quat_rotate_inv(var_16, var_31);
        // inertia = affine_body_inertia[affine_body]                                             <L 139>
        var_33 = wp::address(var_affine_body_inertia, var_0);
        var_35 = wp::load(var_33);
        var_34 = wp::copy(var_35);
        // inverse_inertia = wp.inverse(inertia)                                                  <L 140>
        var_36 = wp::inverse(var_34);
        // initial_angular_momentum = inertia * body_angular_velocity + dt * wp.quat_rotate_inv(       <L 141>
        var_37 = wp::mul(var_34, var_32);
        // rotation, wp.spatial_bottom(wrench)                                                    <L 142>
        var_38 = wp::spatial_bottom(var_21);
        var_39 = wp::quat_rotate_inv(var_16, var_38);
        var_40 = wp::mul(var_dt, var_39);
        var_41 = wp::add(var_37, var_40);
        // center = wp.transform_get_translation(pose) + wp.quat_rotate(                          <L 144>
        var_42 = wp::transform_get_translation(var_5);
        // rotation, body_com[body]                                                               <L 145>
        var_43 = wp::address(var_body_com, var_2);
        var_45 = wp::load(var_43);
        var_44 = wp::quat_rotate(var_16, var_45);
        var_46 = wp::add(var_42, var_44);
        // predicted_center = center + dt * linear_velocity                                       <L 147>
        var_47 = wp::mul(var_dt, var_30);
        var_48 = wp::add(var_46, var_47);
        // if inertia_mode == VBD_SEMI_IMPLICIT:                                                  <L 149>
        var_50 = (var_inertia_mode == var_49);
        if (var_50) {
            // next_angular_momentum, relative_rotation_matrix = integrate_vbd_semi_implicit(       <L 152>
            // inertia,                                                                           <L 153>
            // inertia * body_angular_velocity,                                                   <L 154>
            var_51 = wp::mul(var_34, var_32);
            // wp.quat_rotate_inv(rotation, wp.spatial_bottom(wrench)),                           <L 155>
            var_52 = wp::spatial_bottom(var_21);
            var_53 = wp::quat_rotate_inv(var_16, var_52);
            // dt,                                                                                <L 156>
            integrate_vbd_semi_implicit_0(var_34, var_51, var_53, var_dt, var_54, var_55);
        }
        if (!var_50) {
            // next_angular_momentum, relative_rotation_matrix = integrate_rigid_body(            <L 159>
            // inertia,                                                                           <L 160>
            // initial_angular_momentum,                                                          <L 161>
            // dt,                                                                                <L 162>
            // inertia_mode,                                                                      <L 163>
            integrate_rigid_body_1(var_34, var_41, var_dt, var_inertia_mode, var_56, var_57);
        }
        var_58 = wp::where(var_50, var_54, var_56);
        var_59 = wp::where(var_50, var_55, var_57);
        // relative_rotation = wp.quat_from_matrix(relative_rotation_matrix)                      <L 165>
        var_60 = wp::quat_from_matrix(var_59);
        // predicted_rotation = rotation * relative_rotation                                      <L 166>
        var_61 = wp::mul(var_16, var_60);
        // next_angular_velocity = wp.quat_rotate(                                                <L 167>
        // predicted_rotation, inverse_inertia * next_angular_momentum                            <L 168>
        var_62 = wp::mul(var_36, var_58);
        var_63 = wp::quat_rotate(var_61, var_62);
        // if inertia_mode == VBD_SEMI_IMPLICIT:                                                  <L 170>
        var_64 = (var_inertia_mode == var_49);
        if (var_64) {
            // next_angular_velocity = wp.quat_rotate(rotation, inverse_inertia * next_angular_momentum)       <L 171>
            var_65 = wp::mul(var_36, var_58);
            var_66 = wp::quat_rotate(var_16, var_65);
        }
        var_67 = wp::where(var_64, var_66, var_63);
        // predicted_body_q[body] = wp.transform(                                                 <L 172>
        // predicted_center - wp.quat_rotate(predicted_rotation, body_com[body]),                 <L 173>
        var_68 = wp::address(var_body_com, var_2);
        var_70 = wp::load(var_68);
        var_69 = wp::quat_rotate(var_61, var_70);
        var_71 = wp::sub(var_48, var_69);
        // predicted_rotation,                                                                    <L 174>
        var_72 = wp::transform_t<wp::float32>(var_71, var_61);
        // predicted_body_q[body] = wp.transform(                                                 <L 172>
        wp::array_store(var_predicted_body_q, var_2, var_72);
        // predicted_body_qd[body] = wp.spatial_vector(linear_velocity, next_angular_velocity)       <L 176>
        var_73 = wp::vec_t<6, wp::float32>(var_30, var_67);
        wp::array_store(var_predicted_body_qd, var_2, var_73);
    }
}



extern "C" __global__ void _predict_affine_body_inertia_092ca3c1_cuda_kernel_backward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::transform_t<wp::float32>> var_body_q,
    wp::array_t<wp::vec_t<6, wp::float32>> var_body_qd,
    wp::array_t<wp::vec_t<6, wp::float32>> var_body_f,
    wp::array_t<wp::int32> var_affine_body_ids,
    wp::array_t<wp::vec_t<3, wp::float32>> var_body_com,
    wp::array_t<wp::float32> var_body_mass,
    wp::array_t<wp::mat_t<3, 3, wp::float32>> var_affine_body_inertia,
    wp::array_t<wp::int32> var_fixed_affine_body_flags,
    wp::int32 var_inertia_mode,
    wp::float32 var_dt,
    wp::array_t<wp::transform_t<wp::float32>> var_predicted_body_q,
    wp::array_t<wp::vec_t<6, wp::float32>> var_predicted_body_qd,
    wp::array_t<wp::transform_t<wp::float32>> adj_body_q,
    wp::array_t<wp::vec_t<6, wp::float32>> adj_body_qd,
    wp::array_t<wp::vec_t<6, wp::float32>> adj_body_f,
    wp::array_t<wp::int32> adj_affine_body_ids,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_body_com,
    wp::array_t<wp::float32> adj_body_mass,
    wp::array_t<wp::mat_t<3, 3, wp::float32>> adj_affine_body_inertia,
    wp::array_t<wp::int32> adj_fixed_affine_body_flags,
    wp::int32 adj_inertia_mode,
    wp::float32 adj_dt,
    wp::array_t<wp::transform_t<wp::float32>> adj_predicted_body_q,
    wp::array_t<wp::vec_t<6, wp::float32>> adj_predicted_body_qd)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        wp::int32 var_0;
        wp::int32* var_1;
        wp::int32 var_2;
        wp::int32 var_3;
        wp::transform_t<wp::float32>* var_4;
        wp::transform_t<wp::float32> var_5;
        wp::transform_t<wp::float32> var_6;
        wp::int32* var_7;
        const wp::int32 var_8 = 0;
        bool var_9;
        wp::int32 var_10;
        const wp::float32 var_11 = 0.0;
        wp::vec_t<3, wp::float32> var_12;
        const wp::float32 var_13 = 0.0;
        wp::vec_t<3, wp::float32> var_14;
        wp::vec_t<6, wp::float32> var_15;
        wp::quat_t<wp::float32> var_16;
        wp::vec_t<6, wp::float32>* var_17;
        wp::vec_t<6, wp::float32> var_18;
        wp::vec_t<6, wp::float32> var_19;
        wp::vec_t<6, wp::float32>* var_20;
        wp::vec_t<6, wp::float32> var_21;
        wp::vec_t<6, wp::float32> var_22;
        wp::float32* var_23;
        wp::float32 var_24;
        wp::float32 var_25;
        wp::vec_t<3, wp::float32> var_26;
        wp::vec_t<3, wp::float32> var_27;
        wp::vec_t<3, wp::float32> var_28;
        wp::vec_t<3, wp::float32> var_29;
        wp::vec_t<3, wp::float32> var_30;
        wp::vec_t<3, wp::float32> var_31;
        wp::vec_t<3, wp::float32> var_32;
        wp::mat_t<3, 3, wp::float32>* var_33;
        wp::mat_t<3, 3, wp::float32> var_34;
        wp::mat_t<3, 3, wp::float32> var_35;
        wp::mat_t<3, 3, wp::float32> var_36;
        wp::vec_t<3, wp::float32> var_37;
        wp::vec_t<3, wp::float32> var_38;
        wp::vec_t<3, wp::float32> var_39;
        wp::vec_t<3, wp::float32> var_40;
        wp::vec_t<3, wp::float32> var_41;
        wp::vec_t<3, wp::float32> var_42;
        wp::vec_t<3, wp::float32>* var_43;
        wp::vec_t<3, wp::float32> var_44;
        wp::vec_t<3, wp::float32> var_45;
        wp::vec_t<3, wp::float32> var_46;
        wp::vec_t<3, wp::float32> var_47;
        wp::vec_t<3, wp::float32> var_48;
        const wp::int32 var_49 = 5;
        bool var_50;
        wp::vec_t<3, wp::float32> var_51;
        wp::vec_t<3, wp::float32> var_52;
        wp::vec_t<3, wp::float32> var_53;
        wp::vec_t<3, wp::float32> var_54;
        wp::mat_t<3, 3, wp::float32> var_55;
        wp::vec_t<3, wp::float32> var_56;
        wp::mat_t<3, 3, wp::float32> var_57;
        wp::vec_t<3, wp::float32> var_58;
        wp::mat_t<3, 3, wp::float32> var_59;
        wp::quat_t<wp::float32> var_60;
        wp::quat_t<wp::float32> var_61;
        wp::vec_t<3, wp::float32> var_62;
        wp::vec_t<3, wp::float32> var_63;
        bool var_64;
        wp::vec_t<3, wp::float32> var_65;
        wp::vec_t<3, wp::float32> var_66;
        wp::vec_t<3, wp::float32> var_67;
        wp::vec_t<3, wp::float32>* var_68;
        wp::vec_t<3, wp::float32> var_69;
        wp::vec_t<3, wp::float32> var_70;
        wp::vec_t<3, wp::float32> var_71;
        wp::transform_t<wp::float32> var_72;
        wp::vec_t<6, wp::float32> var_73;
        //---------
        // dual vars
        wp::int32 adj_0 = {};
        wp::int32 adj_1 = {};
        wp::int32 adj_2 = {};
        wp::int32 adj_3 = {};
        wp::transform_t<wp::float32> adj_4 = {};
        wp::transform_t<wp::float32> adj_5 = {};
        wp::transform_t<wp::float32> adj_6 = {};
        wp::int32 adj_7 = {};
        wp::int32 adj_8 = {};
        bool adj_9 = {};
        wp::int32 adj_10 = {};
        wp::float32 adj_11 = {};
        wp::vec_t<3, wp::float32> adj_12 = {};
        wp::float32 adj_13 = {};
        wp::vec_t<3, wp::float32> adj_14 = {};
        wp::vec_t<6, wp::float32> adj_15 = {};
        wp::quat_t<wp::float32> adj_16 = {};
        wp::vec_t<6, wp::float32> adj_17 = {};
        wp::vec_t<6, wp::float32> adj_18 = {};
        wp::vec_t<6, wp::float32> adj_19 = {};
        wp::vec_t<6, wp::float32> adj_20 = {};
        wp::vec_t<6, wp::float32> adj_21 = {};
        wp::vec_t<6, wp::float32> adj_22 = {};
        wp::float32 adj_23 = {};
        wp::float32 adj_24 = {};
        wp::float32 adj_25 = {};
        wp::vec_t<3, wp::float32> adj_26 = {};
        wp::vec_t<3, wp::float32> adj_27 = {};
        wp::vec_t<3, wp::float32> adj_28 = {};
        wp::vec_t<3, wp::float32> adj_29 = {};
        wp::vec_t<3, wp::float32> adj_30 = {};
        wp::vec_t<3, wp::float32> adj_31 = {};
        wp::vec_t<3, wp::float32> adj_32 = {};
        wp::mat_t<3, 3, wp::float32> adj_33 = {};
        wp::mat_t<3, 3, wp::float32> adj_34 = {};
        wp::mat_t<3, 3, wp::float32> adj_35 = {};
        wp::mat_t<3, 3, wp::float32> adj_36 = {};
        wp::vec_t<3, wp::float32> adj_37 = {};
        wp::vec_t<3, wp::float32> adj_38 = {};
        wp::vec_t<3, wp::float32> adj_39 = {};
        wp::vec_t<3, wp::float32> adj_40 = {};
        wp::vec_t<3, wp::float32> adj_41 = {};
        wp::vec_t<3, wp::float32> adj_42 = {};
        wp::vec_t<3, wp::float32> adj_43 = {};
        wp::vec_t<3, wp::float32> adj_44 = {};
        wp::vec_t<3, wp::float32> adj_45 = {};
        wp::vec_t<3, wp::float32> adj_46 = {};
        wp::vec_t<3, wp::float32> adj_47 = {};
        wp::vec_t<3, wp::float32> adj_48 = {};
        wp::int32 adj_49 = {};
        bool adj_50 = {};
        wp::vec_t<3, wp::float32> adj_51 = {};
        wp::vec_t<3, wp::float32> adj_52 = {};
        wp::vec_t<3, wp::float32> adj_53 = {};
        wp::vec_t<3, wp::float32> adj_54 = {};
        wp::mat_t<3, 3, wp::float32> adj_55 = {};
        wp::vec_t<3, wp::float32> adj_56 = {};
        wp::mat_t<3, 3, wp::float32> adj_57 = {};
        wp::vec_t<3, wp::float32> adj_58 = {};
        wp::mat_t<3, 3, wp::float32> adj_59 = {};
        wp::quat_t<wp::float32> adj_60 = {};
        wp::quat_t<wp::float32> adj_61 = {};
        wp::vec_t<3, wp::float32> adj_62 = {};
        wp::vec_t<3, wp::float32> adj_63 = {};
        bool adj_64 = {};
        wp::vec_t<3, wp::float32> adj_65 = {};
        wp::vec_t<3, wp::float32> adj_66 = {};
        wp::vec_t<3, wp::float32> adj_67 = {};
        wp::vec_t<3, wp::float32> adj_68 = {};
        wp::vec_t<3, wp::float32> adj_69 = {};
        wp::vec_t<3, wp::float32> adj_70 = {};
        wp::vec_t<3, wp::float32> adj_71 = {};
        wp::transform_t<wp::float32> adj_72 = {};
        wp::vec_t<6, wp::float32> adj_73 = {};
        //---------
        // forward
        // def _predict_affine_body_inertia(                                                      <L 110>
        // affine_body = wp.tid()                                                                 <L 125>
        var_0 = builtin_tid1d();
        // body = affine_body_ids[affine_body]                                                    <L 126>
        var_1 = wp::address(var_affine_body_ids, var_0);
        var_3 = wp::load(var_1);
        var_2 = wp::copy(var_3);
        // pose = body_q[body]                                                                    <L 127>
        var_4 = wp::address(var_body_q, var_2);
        var_6 = wp::load(var_4);
        var_5 = wp::copy(var_6);
        // if fixed_affine_body_flags[affine_body] != 0:                                          <L 128>
        var_7 = wp::address(var_fixed_affine_body_flags, var_0);
        var_10 = wp::load(var_7);
        var_9 = (var_10 != var_8);
        if (var_9) {
            // predicted_body_q[body] = pose                                                      <L 129>
            // wp::array_store(var_predicted_body_q, var_2, var_5);
            // predicted_body_qd[body] = wp.spatial_vector(wp.vec3(0.0), wp.vec3(0.0))            <L 130>
            var_12 = wp::vec_t<3, wp::float32>(var_11);
            var_14 = wp::vec_t<3, wp::float32>(var_13);
            var_15 = wp::vec_t<6, wp::float32>(var_12, var_14);
            // wp::array_store(var_predicted_body_qd, var_2, var_15);
            // return                                                                             <L 131>
            goto label0;
        }
        // rotation = wp.transform_get_rotation(pose)                                             <L 132>
        var_16 = wp::transform_get_rotation(var_5);
        // velocity = body_qd[body]                                                               <L 133>
        var_17 = wp::address(var_body_qd, var_2);
        var_19 = wp::load(var_17);
        var_18 = wp::copy(var_19);
        // wrench = body_f[body]                                                                  <L 134>
        var_20 = wp::address(var_body_f, var_2);
        var_22 = wp::load(var_20);
        var_21 = wp::copy(var_22);
        // mass = body_mass[body]                                                                 <L 135>
        var_23 = wp::address(var_body_mass, var_2);
        var_25 = wp::load(var_23);
        var_24 = wp::copy(var_25);
        // linear_velocity = wp.spatial_top(velocity) + dt * wp.spatial_top(wrench) / mass        <L 136>
        var_26 = wp::spatial_top(var_18);
        var_27 = wp::spatial_top(var_21);
        var_28 = wp::mul(var_dt, var_27);
        var_29 = wp::div(var_28, var_24);
        var_30 = wp::add(var_26, var_29);
        // angular_velocity = wp.spatial_bottom(velocity)                                         <L 137>
        var_31 = wp::spatial_bottom(var_18);
        // body_angular_velocity = wp.quat_rotate_inv(rotation, angular_velocity)                 <L 138>
        var_32 = wp::quat_rotate_inv(var_16, var_31);
        // inertia = affine_body_inertia[affine_body]                                             <L 139>
        var_33 = wp::address(var_affine_body_inertia, var_0);
        var_35 = wp::load(var_33);
        var_34 = wp::copy(var_35);
        // inverse_inertia = wp.inverse(inertia)                                                  <L 140>
        var_36 = wp::inverse(var_34);
        // initial_angular_momentum = inertia * body_angular_velocity + dt * wp.quat_rotate_inv(       <L 141>
        var_37 = wp::mul(var_34, var_32);
        // rotation, wp.spatial_bottom(wrench)                                                    <L 142>
        var_38 = wp::spatial_bottom(var_21);
        var_39 = wp::quat_rotate_inv(var_16, var_38);
        var_40 = wp::mul(var_dt, var_39);
        var_41 = wp::add(var_37, var_40);
        // center = wp.transform_get_translation(pose) + wp.quat_rotate(                          <L 144>
        var_42 = wp::transform_get_translation(var_5);
        // rotation, body_com[body]                                                               <L 145>
        var_43 = wp::address(var_body_com, var_2);
        var_45 = wp::load(var_43);
        var_44 = wp::quat_rotate(var_16, var_45);
        var_46 = wp::add(var_42, var_44);
        // predicted_center = center + dt * linear_velocity                                       <L 147>
        var_47 = wp::mul(var_dt, var_30);
        var_48 = wp::add(var_46, var_47);
        // if inertia_mode == VBD_SEMI_IMPLICIT:                                                  <L 149>
        var_50 = (var_inertia_mode == var_49);
        if (var_50) {
            // next_angular_momentum, relative_rotation_matrix = integrate_vbd_semi_implicit(       <L 152>
            // inertia,                                                                           <L 153>
            // inertia * body_angular_velocity,                                                   <L 154>
            var_51 = wp::mul(var_34, var_32);
            // wp.quat_rotate_inv(rotation, wp.spatial_bottom(wrench)),                           <L 155>
            var_52 = wp::spatial_bottom(var_21);
            var_53 = wp::quat_rotate_inv(var_16, var_52);
            // dt,                                                                                <L 156>
            integrate_vbd_semi_implicit_0(var_34, var_51, var_53, var_dt, var_54, var_55);
        }
        if (!var_50) {
            // next_angular_momentum, relative_rotation_matrix = integrate_rigid_body(            <L 159>
            // inertia,                                                                           <L 160>
            // initial_angular_momentum,                                                          <L 161>
            // dt,                                                                                <L 162>
            // inertia_mode,                                                                      <L 163>
            integrate_rigid_body_1(var_34, var_41, var_dt, var_inertia_mode, var_56, var_57);
        }
        var_58 = wp::where(var_50, var_54, var_56);
        var_59 = wp::where(var_50, var_55, var_57);
        // relative_rotation = wp.quat_from_matrix(relative_rotation_matrix)                      <L 165>
        var_60 = wp::quat_from_matrix(var_59);
        // predicted_rotation = rotation * relative_rotation                                      <L 166>
        var_61 = wp::mul(var_16, var_60);
        // next_angular_velocity = wp.quat_rotate(                                                <L 167>
        // predicted_rotation, inverse_inertia * next_angular_momentum                            <L 168>
        var_62 = wp::mul(var_36, var_58);
        var_63 = wp::quat_rotate(var_61, var_62);
        // if inertia_mode == VBD_SEMI_IMPLICIT:                                                  <L 170>
        var_64 = (var_inertia_mode == var_49);
        if (var_64) {
            // next_angular_velocity = wp.quat_rotate(rotation, inverse_inertia * next_angular_momentum)       <L 171>
            var_65 = wp::mul(var_36, var_58);
            var_66 = wp::quat_rotate(var_16, var_65);
        }
        var_67 = wp::where(var_64, var_66, var_63);
        // predicted_body_q[body] = wp.transform(                                                 <L 172>
        // predicted_center - wp.quat_rotate(predicted_rotation, body_com[body]),                 <L 173>
        var_68 = wp::address(var_body_com, var_2);
        var_70 = wp::load(var_68);
        var_69 = wp::quat_rotate(var_61, var_70);
        var_71 = wp::sub(var_48, var_69);
        // predicted_rotation,                                                                    <L 174>
        var_72 = wp::transform_t<wp::float32>(var_71, var_61);
        // predicted_body_q[body] = wp.transform(                                                 <L 172>
        // wp::array_store(var_predicted_body_q, var_2, var_72);
        // predicted_body_qd[body] = wp.spatial_vector(linear_velocity, next_angular_velocity)       <L 176>
        var_73 = wp::vec_t<6, wp::float32>(var_30, var_67);
        // wp::array_store(var_predicted_body_qd, var_2, var_73);
        //---------
        // reverse
        wp::adj_array_store(var_predicted_body_qd, var_2, var_73, adj_predicted_body_qd, adj_2, adj_73);
        wp::adj_vec_t(var_30, var_67, adj_30, adj_67, adj_73);
        // adj: predicted_body_qd[body] = wp.spatial_vector(linear_velocity, next_angular_velocity)  <L 176>
        wp::adj_array_store(var_predicted_body_q, var_2, var_72, adj_predicted_body_q, adj_2, adj_72);
        // adj: predicted_body_q[body] = wp.transform(                                            <L 172>
        wp::adj_transform_t(var_71, var_61, adj_71, adj_61, adj_72);
        // adj: predicted_rotation,                                                               <L 174>
        wp::adj_sub(var_48, var_69, adj_48, adj_69, adj_71);
        wp::adj_quat_rotate(var_61, var_70, adj_61, adj_68, adj_69);
        wp::adj_address(var_body_com, var_2, adj_body_com, adj_2, adj_68);
        // adj: predicted_center - wp.quat_rotate(predicted_rotation, body_com[body]),            <L 173>
        // adj: predicted_body_q[body] = wp.transform(                                            <L 172>
        wp::adj_where(var_64, var_66, var_63, adj_64, adj_66, adj_63, adj_67);
        if (var_64) {
            wp::adj_quat_rotate(var_16, var_65, adj_16, adj_65, adj_66);
            wp::adj_mul(var_36, var_58, adj_36, adj_58, adj_65);
            // adj: next_angular_velocity = wp.quat_rotate(rotation, inverse_inertia * next_angular_momentum)  <L 171>
        }
        // adj: if inertia_mode == VBD_SEMI_IMPLICIT:                                             <L 170>
        wp::adj_quat_rotate(var_61, var_62, adj_61, adj_62, adj_63);
        wp::adj_mul(var_36, var_58, adj_36, adj_58, adj_62);
        // adj: predicted_rotation, inverse_inertia * next_angular_momentum                       <L 168>
        // adj: next_angular_velocity = wp.quat_rotate(                                           <L 167>
        wp::adj_mul(var_16, var_60, adj_16, adj_60, adj_61);
        // adj: predicted_rotation = rotation * relative_rotation                                 <L 166>
        wp::adj_quat_from_matrix(var_59, adj_59, adj_60);
        // adj: relative_rotation = wp.quat_from_matrix(relative_rotation_matrix)                 <L 165>
        wp::adj_where(var_50, var_55, var_57, adj_50, adj_55, adj_57, adj_59);
        wp::adj_where(var_50, var_54, var_56, adj_50, adj_54, adj_56, adj_58);
        if (!var_50) {
            adj_integrate_rigid_body_1(var_34, var_41, var_dt, var_inertia_mode, var_56, var_57, adj_34, adj_41, adj_dt, adj_inertia_mode, adj_56, adj_57);
            // adj: inertia_mode,                                                                 <L 163>
            // adj: dt,                                                                           <L 162>
            // adj: initial_angular_momentum,                                                     <L 161>
            // adj: inertia,                                                                      <L 160>
            // adj: next_angular_momentum, relative_rotation_matrix = integrate_rigid_body(       <L 159>
        }
        if (var_50) {
            adj_integrate_vbd_semi_implicit_0(var_34, var_51, var_53, var_dt, var_54, var_55, adj_34, adj_51, adj_53, adj_dt, adj_54, adj_55);
            // adj: dt,                                                                           <L 156>
            wp::adj_quat_rotate_inv(var_16, var_52, adj_16, adj_52, adj_53);
            wp::adj_spatial_bottom(var_21, adj_21, adj_52);
            // adj: wp.quat_rotate_inv(rotation, wp.spatial_bottom(wrench)),                      <L 155>
            wp::adj_mul(var_34, var_32, adj_34, adj_32, adj_51);
            // adj: inertia * body_angular_velocity,                                              <L 154>
            // adj: inertia,                                                                      <L 153>
            // adj: next_angular_momentum, relative_rotation_matrix = integrate_vbd_semi_implicit(  <L 152>
        }
        // adj: if inertia_mode == VBD_SEMI_IMPLICIT:                                             <L 149>
        wp::adj_add(var_46, var_47, adj_46, adj_47, adj_48);
        wp::adj_mul(var_dt, var_30, adj_dt, adj_30, adj_47);
        // adj: predicted_center = center + dt * linear_velocity                                  <L 147>
        wp::adj_add(var_42, var_44, adj_42, adj_44, adj_46);
        wp::adj_quat_rotate(var_16, var_45, adj_16, adj_43, adj_44);
        wp::adj_address(var_body_com, var_2, adj_body_com, adj_2, adj_43);
        // adj: rotation, body_com[body]                                                          <L 145>
        wp::adj_transform_get_translation(var_5, adj_5, adj_42);
        // adj: center = wp.transform_get_translation(pose) + wp.quat_rotate(                     <L 144>
        wp::adj_add(var_37, var_40, adj_37, adj_40, adj_41);
        wp::adj_mul(var_dt, var_39, adj_dt, adj_39, adj_40);
        wp::adj_quat_rotate_inv(var_16, var_38, adj_16, adj_38, adj_39);
        wp::adj_spatial_bottom(var_21, adj_21, adj_38);
        // adj: rotation, wp.spatial_bottom(wrench)                                               <L 142>
        wp::adj_mul(var_34, var_32, adj_34, adj_32, adj_37);
        // adj: initial_angular_momentum = inertia * body_angular_velocity + dt * wp.quat_rotate_inv(  <L 141>
        wp::adj_inverse(var_34, var_36, adj_34, adj_36);
        // adj: inverse_inertia = wp.inverse(inertia)                                             <L 140>
        wp::adj_copy(var_35, adj_33, adj_34);
        wp::adj_address(var_affine_body_inertia, var_0, adj_affine_body_inertia, adj_0, adj_33);
        // adj: inertia = affine_body_inertia[affine_body]                                        <L 139>
        wp::adj_quat_rotate_inv(var_16, var_31, adj_16, adj_31, adj_32);
        // adj: body_angular_velocity = wp.quat_rotate_inv(rotation, angular_velocity)            <L 138>
        wp::adj_spatial_bottom(var_18, adj_18, adj_31);
        // adj: angular_velocity = wp.spatial_bottom(velocity)                                    <L 137>
        wp::adj_add(var_26, var_29, adj_26, adj_29, adj_30);
        wp::adj_div(var_28, var_24, adj_28, adj_24, adj_29);
        wp::adj_mul(var_dt, var_27, adj_dt, adj_27, adj_28);
        wp::adj_spatial_top(var_21, adj_21, adj_27);
        wp::adj_spatial_top(var_18, adj_18, adj_26);
        // adj: linear_velocity = wp.spatial_top(velocity) + dt * wp.spatial_top(wrench) / mass   <L 136>
        wp::adj_copy(var_25, adj_23, adj_24);
        wp::adj_address(var_body_mass, var_2, adj_body_mass, adj_2, adj_23);
        // adj: mass = body_mass[body]                                                            <L 135>
        wp::adj_copy(var_22, adj_20, adj_21);
        wp::adj_address(var_body_f, var_2, adj_body_f, adj_2, adj_20);
        // adj: wrench = body_f[body]                                                             <L 134>
        wp::adj_copy(var_19, adj_17, adj_18);
        wp::adj_address(var_body_qd, var_2, adj_body_qd, adj_2, adj_17);
        // adj: velocity = body_qd[body]                                                          <L 133>
        wp::adj_transform_get_rotation(var_5, adj_5, adj_16);
        // adj: rotation = wp.transform_get_rotation(pose)                                        <L 132>
        if (var_9) {
            label0:;
            // adj: return                                                                        <L 131>
            wp::adj_array_store(var_predicted_body_qd, var_2, var_15, adj_predicted_body_qd, adj_2, adj_15);
            wp::adj_vec_t(var_12, var_14, adj_12, adj_14, adj_15);
            wp::adj_vec_t(var_13, adj_13, adj_14);
            wp::adj_vec_t(var_11, adj_11, adj_12);
            // adj: predicted_body_qd[body] = wp.spatial_vector(wp.vec3(0.0), wp.vec3(0.0))       <L 130>
            wp::adj_array_store(var_predicted_body_q, var_2, var_5, adj_predicted_body_q, adj_2, adj_5);
            // adj: predicted_body_q[body] = pose                                                 <L 129>
        }
        wp::adj_address(var_fixed_affine_body_flags, var_0, adj_fixed_affine_body_flags, adj_0, adj_7);
        // adj: if fixed_affine_body_flags[affine_body] != 0:                                     <L 128>
        wp::adj_copy(var_6, adj_4, adj_5);
        wp::adj_address(var_body_q, var_2, adj_body_q, adj_2, adj_4);
        // adj: pose = body_q[body]                                                               <L 127>
        wp::adj_copy(var_3, adj_1, adj_2);
        wp::adj_address(var_affine_body_ids, var_0, adj_affine_body_ids, adj_0, adj_1);
        // adj: body = affine_body_ids[affine_body]                                               <L 126>
        // adj: affine_body = wp.tid()                                                            <L 125>
        // adj: def _predict_affine_body_inertia(                                                 <L 110>
        continue;
    }
}



extern "C" __global__ void _clear_fixed_affine_body_velocities_674a9e16_cuda_kernel_forward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_qd,
    wp::array_t<wp::vec_t<4, wp::int32>> var_affine_body_indices,
    wp::array_t<wp::int32> var_fixed_affine_bodies)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        wp::int32 var_0;
        wp::int32* var_1;
        wp::vec_t<4, wp::int32>* var_2;
        wp::int32 var_3;
        wp::vec_t<4, wp::int32> var_4;
        wp::vec_t<4, wp::int32> var_5;
        const wp::float32 var_6 = 0.0;
        wp::vec_t<3, wp::float32> var_7;
        const wp::int32 var_8 = 0;
        wp::int32 var_9;
        const wp::float32 var_10 = 0.0;
        wp::vec_t<3, wp::float32> var_11;
        const wp::int32 var_12 = 1;
        wp::int32 var_13;
        const wp::float32 var_14 = 0.0;
        wp::vec_t<3, wp::float32> var_15;
        const wp::int32 var_16 = 2;
        wp::int32 var_17;
        const wp::float32 var_18 = 0.0;
        wp::vec_t<3, wp::float32> var_19;
        const wp::int32 var_20 = 3;
        wp::int32 var_21;
        //---------
        // forward
        // def _clear_fixed_affine_body_velocities(                                               <L 602>
        // fixed_body = wp.tid()                                                                  <L 608>
        var_0 = builtin_tid1d();
        // particle_indices = affine_body_indices[fixed_affine_bodies[fixed_body]]                <L 609>
        var_1 = wp::address(var_fixed_affine_bodies, var_0);
        var_3 = wp::load(var_1);
        var_2 = wp::address(var_affine_body_indices, var_3);
        var_5 = wp::load(var_2);
        var_4 = wp::copy(var_5);
        // particle_qd[particle_indices[0]] = wp.vec3(0.0)                                        <L 610>
        var_7 = wp::vec_t<3, wp::float32>(var_6);
        var_9 = wp::extract(var_4, var_8);
        wp::array_store(var_particle_qd, var_9, var_7);
        // particle_qd[particle_indices[1]] = wp.vec3(0.0)                                        <L 611>
        var_11 = wp::vec_t<3, wp::float32>(var_10);
        var_13 = wp::extract(var_4, var_12);
        wp::array_store(var_particle_qd, var_13, var_11);
        // particle_qd[particle_indices[2]] = wp.vec3(0.0)                                        <L 612>
        var_15 = wp::vec_t<3, wp::float32>(var_14);
        var_17 = wp::extract(var_4, var_16);
        wp::array_store(var_particle_qd, var_17, var_15);
        // particle_qd[particle_indices[3]] = wp.vec3(0.0)                                        <L 613>
        var_19 = wp::vec_t<3, wp::float32>(var_18);
        var_21 = wp::extract(var_4, var_20);
        wp::array_store(var_particle_qd, var_21, var_19);
    }
}



extern "C" __global__ void _clear_fixed_affine_body_velocities_674a9e16_cuda_kernel_backward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_qd,
    wp::array_t<wp::vec_t<4, wp::int32>> var_affine_body_indices,
    wp::array_t<wp::int32> var_fixed_affine_bodies,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_particle_qd,
    wp::array_t<wp::vec_t<4, wp::int32>> adj_affine_body_indices,
    wp::array_t<wp::int32> adj_fixed_affine_bodies)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        wp::int32 var_0;
        wp::int32* var_1;
        wp::vec_t<4, wp::int32>* var_2;
        wp::int32 var_3;
        wp::vec_t<4, wp::int32> var_4;
        wp::vec_t<4, wp::int32> var_5;
        const wp::float32 var_6 = 0.0;
        wp::vec_t<3, wp::float32> var_7;
        const wp::int32 var_8 = 0;
        wp::int32 var_9;
        const wp::float32 var_10 = 0.0;
        wp::vec_t<3, wp::float32> var_11;
        const wp::int32 var_12 = 1;
        wp::int32 var_13;
        const wp::float32 var_14 = 0.0;
        wp::vec_t<3, wp::float32> var_15;
        const wp::int32 var_16 = 2;
        wp::int32 var_17;
        const wp::float32 var_18 = 0.0;
        wp::vec_t<3, wp::float32> var_19;
        const wp::int32 var_20 = 3;
        wp::int32 var_21;
        //---------
        // dual vars
        wp::int32 adj_0 = {};
        wp::int32 adj_1 = {};
        wp::vec_t<4, wp::int32> adj_2 = {};
        wp::int32 adj_3 = {};
        wp::vec_t<4, wp::int32> adj_4 = {};
        wp::vec_t<4, wp::int32> adj_5 = {};
        wp::float32 adj_6 = {};
        wp::vec_t<3, wp::float32> adj_7 = {};
        wp::int32 adj_8 = {};
        wp::int32 adj_9 = {};
        wp::float32 adj_10 = {};
        wp::vec_t<3, wp::float32> adj_11 = {};
        wp::int32 adj_12 = {};
        wp::int32 adj_13 = {};
        wp::float32 adj_14 = {};
        wp::vec_t<3, wp::float32> adj_15 = {};
        wp::int32 adj_16 = {};
        wp::int32 adj_17 = {};
        wp::float32 adj_18 = {};
        wp::vec_t<3, wp::float32> adj_19 = {};
        wp::int32 adj_20 = {};
        wp::int32 adj_21 = {};
        //---------
        // forward
        // def _clear_fixed_affine_body_velocities(                                               <L 602>
        // fixed_body = wp.tid()                                                                  <L 608>
        var_0 = builtin_tid1d();
        // particle_indices = affine_body_indices[fixed_affine_bodies[fixed_body]]                <L 609>
        var_1 = wp::address(var_fixed_affine_bodies, var_0);
        var_3 = wp::load(var_1);
        var_2 = wp::address(var_affine_body_indices, var_3);
        var_5 = wp::load(var_2);
        var_4 = wp::copy(var_5);
        // particle_qd[particle_indices[0]] = wp.vec3(0.0)                                        <L 610>
        var_7 = wp::vec_t<3, wp::float32>(var_6);
        var_9 = wp::extract(var_4, var_8);
        // wp::array_store(var_particle_qd, var_9, var_7);
        // particle_qd[particle_indices[1]] = wp.vec3(0.0)                                        <L 611>
        var_11 = wp::vec_t<3, wp::float32>(var_10);
        var_13 = wp::extract(var_4, var_12);
        // wp::array_store(var_particle_qd, var_13, var_11);
        // particle_qd[particle_indices[2]] = wp.vec3(0.0)                                        <L 612>
        var_15 = wp::vec_t<3, wp::float32>(var_14);
        var_17 = wp::extract(var_4, var_16);
        // wp::array_store(var_particle_qd, var_17, var_15);
        // particle_qd[particle_indices[3]] = wp.vec3(0.0)                                        <L 613>
        var_19 = wp::vec_t<3, wp::float32>(var_18);
        var_21 = wp::extract(var_4, var_20);
        // wp::array_store(var_particle_qd, var_21, var_19);
        //---------
        // reverse
        wp::adj_array_store(var_particle_qd, var_21, var_19, adj_particle_qd, adj_21, adj_19);
        wp::adj_extract(var_4, var_20, adj_4, adj_20, adj_21);
        wp::adj_vec_t(var_18, adj_18, adj_19);
        // adj: particle_qd[particle_indices[3]] = wp.vec3(0.0)                                   <L 613>
        wp::adj_array_store(var_particle_qd, var_17, var_15, adj_particle_qd, adj_17, adj_15);
        wp::adj_extract(var_4, var_16, adj_4, adj_16, adj_17);
        wp::adj_vec_t(var_14, adj_14, adj_15);
        // adj: particle_qd[particle_indices[2]] = wp.vec3(0.0)                                   <L 612>
        wp::adj_array_store(var_particle_qd, var_13, var_11, adj_particle_qd, adj_13, adj_11);
        wp::adj_extract(var_4, var_12, adj_4, adj_12, adj_13);
        wp::adj_vec_t(var_10, adj_10, adj_11);
        // adj: particle_qd[particle_indices[1]] = wp.vec3(0.0)                                   <L 611>
        wp::adj_array_store(var_particle_qd, var_9, var_7, adj_particle_qd, adj_9, adj_7);
        wp::adj_extract(var_4, var_8, adj_4, adj_8, adj_9);
        wp::adj_vec_t(var_6, adj_6, adj_7);
        // adj: particle_qd[particle_indices[0]] = wp.vec3(0.0)                                   <L 610>
        wp::adj_copy(var_5, adj_2, adj_4);
        wp::adj_address(var_affine_body_indices, var_3, adj_affine_body_indices, adj_1, adj_2);
        wp::adj_address(var_fixed_affine_bodies, var_0, adj_fixed_affine_bodies, adj_0, adj_1);
        // adj: particle_indices = affine_body_indices[fixed_affine_bodies[fixed_body]]           <L 609>
        // adj: fixed_body = wp.tid()                                                             <L 608>
        // adj: def _clear_fixed_affine_body_velocities(                                          <L 602>
        continue;
    }
}



extern "C" __global__ void _predict_affine_body_velocities_81ec5689_cuda_kernel_forward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::transform_t<wp::float32>> var_body_q,
    wp::array_t<wp::transform_t<wp::float32>> var_predicted_body_q,
    wp::array_t<wp::vec_t<4, wp::int32>> var_affine_body_indices,
    wp::array_t<wp::int32> var_affine_body_ids,
    wp::array_t<wp::vec_t<3, wp::float32>> var_body_com,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_q,
    wp::float32 var_dt,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_qd)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        wp::int32 var_0;
        wp::vec_t<4, wp::int32>* var_1;
        wp::vec_t<4, wp::int32> var_2;
        wp::vec_t<4, wp::int32> var_3;
        wp::int32* var_4;
        wp::int32 var_5;
        wp::int32 var_6;
        wp::transform_t<wp::float32>* var_7;
        wp::transform_t<wp::float32> var_8;
        wp::transform_t<wp::float32> var_9;
        wp::transform_t<wp::float32>* var_10;
        wp::transform_t<wp::float32> var_11;
        wp::transform_t<wp::float32> var_12;
        wp::quat_t<wp::float32> var_13;
        wp::quat_t<wp::float32> var_14;
        wp::vec_t<3, wp::float32> var_15;
        wp::vec_t<3, wp::float32>* var_16;
        wp::vec_t<3, wp::float32> var_17;
        wp::vec_t<3, wp::float32> var_18;
        wp::vec_t<3, wp::float32> var_19;
        const wp::int32 var_20 = 0;
        wp::int32 var_21;
        wp::vec_t<3, wp::float32>* var_22;
        wp::vec_t<3, wp::float32> var_23;
        wp::vec_t<3, wp::float32> var_24;
        wp::vec_t<3, wp::float32> var_25;
        const wp::int32 var_26 = 1;
        wp::int32 var_27;
        wp::vec_t<3, wp::float32>* var_28;
        wp::vec_t<3, wp::float32> var_29;
        wp::vec_t<3, wp::float32> var_30;
        wp::vec_t<3, wp::float32> var_31;
        wp::vec_t<3, wp::float32> var_32;
        wp::vec_t<3, wp::float32> var_33;
        wp::vec_t<3, wp::float32> var_34;
        const wp::int32 var_35 = 2;
        wp::int32 var_36;
        wp::vec_t<3, wp::float32>* var_37;
        wp::vec_t<3, wp::float32> var_38;
        wp::vec_t<3, wp::float32> var_39;
        wp::vec_t<3, wp::float32> var_40;
        wp::vec_t<3, wp::float32> var_41;
        wp::vec_t<3, wp::float32> var_42;
        wp::vec_t<3, wp::float32> var_43;
        const wp::int32 var_44 = 3;
        wp::int32 var_45;
        wp::vec_t<3, wp::float32>* var_46;
        wp::vec_t<3, wp::float32> var_47;
        wp::vec_t<3, wp::float32> var_48;
        wp::vec_t<3, wp::float32> var_49;
        wp::vec_t<3, wp::float32> var_50;
        wp::vec_t<3, wp::float32> var_51;
        wp::vec_t<3, wp::float32> var_52;
        //---------
        // forward
        // def _predict_affine_body_velocities(                                                   <L 180>
        // affine_body = wp.tid()                                                                 <L 191>
        var_0 = builtin_tid1d();
        // particle_indices = affine_body_indices[affine_body]                                    <L 192>
        var_1 = wp::address(var_affine_body_indices, var_0);
        var_3 = wp::load(var_1);
        var_2 = wp::copy(var_3);
        // body = affine_body_ids[affine_body]                                                    <L 193>
        var_4 = wp::address(var_affine_body_ids, var_0);
        var_6 = wp::load(var_4);
        var_5 = wp::copy(var_6);
        // pose = body_q[body]                                                                    <L 194>
        var_7 = wp::address(var_body_q, var_5);
        var_9 = wp::load(var_7);
        var_8 = wp::copy(var_9);
        // predicted_pose = predicted_body_q[body]                                                <L 195>
        var_10 = wp::address(var_predicted_body_q, var_5);
        var_12 = wp::load(var_10);
        var_11 = wp::copy(var_12);
        // rotation = wp.transform_get_rotation(pose)                                             <L 197>
        var_13 = wp::transform_get_rotation(var_8);
        // predicted_rotation = wp.transform_get_rotation(predicted_pose)                         <L 198>
        var_14 = wp::transform_get_rotation(var_11);
        // predicted_center = wp.transform_get_translation(predicted_pose) + wp.quat_rotate(       <L 199>
        var_15 = wp::transform_get_translation(var_11);
        // predicted_rotation, body_com[body]                                                     <L 200>
        var_16 = wp::address(var_body_com, var_5);
        var_18 = wp::load(var_16);
        var_17 = wp::quat_rotate(var_14, var_18);
        var_19 = wp::add(var_15, var_17);
        // center_particle = particle_indices[0]                                                  <L 203>
        var_21 = wp::extract(var_2, var_20);
        // particle_qd[center_particle] = (predicted_center - particle_q[center_particle]) / dt       <L 204>
        var_22 = wp::address(var_particle_q, var_21);
        var_24 = wp::load(var_22);
        var_23 = wp::sub(var_19, var_24);
        var_25 = wp::div(var_23, var_dt);
        wp::array_store(var_particle_qd, var_21, var_25);
        // for local_axis in range(1, 4):                                                         <L 205>
        // particle = particle_indices[local_axis]                                                <L 206>
        var_27 = wp::extract(var_2, var_26);
        // current_axis = particle_q[particle]                                                    <L 207>
        var_28 = wp::address(var_particle_q, var_27);
        var_30 = wp::load(var_28);
        var_29 = wp::copy(var_30);
        // local_axis_vector = wp.quat_rotate_inv(rotation, current_axis)                         <L 208>
        var_31 = wp::quat_rotate_inv(var_13, var_29);
        // predicted_axis = wp.quat_rotate(predicted_rotation, local_axis_vector)                 <L 209>
        var_32 = wp::quat_rotate(var_14, var_31);
        // particle_qd[particle] = (predicted_axis - current_axis) / dt                           <L 210>
        var_33 = wp::sub(var_32, var_29);
        var_34 = wp::div(var_33, var_dt);
        wp::array_store(var_particle_qd, var_27, var_34);
        // particle = particle_indices[local_axis]                                                <L 206>
        var_36 = wp::extract(var_2, var_35);
        // current_axis = particle_q[particle]                                                    <L 207>
        var_37 = wp::address(var_particle_q, var_36);
        var_39 = wp::load(var_37);
        var_38 = wp::copy(var_39);
        // local_axis_vector = wp.quat_rotate_inv(rotation, current_axis)                         <L 208>
        var_40 = wp::quat_rotate_inv(var_13, var_38);
        // predicted_axis = wp.quat_rotate(predicted_rotation, local_axis_vector)                 <L 209>
        var_41 = wp::quat_rotate(var_14, var_40);
        // particle_qd[particle] = (predicted_axis - current_axis) / dt                           <L 210>
        var_42 = wp::sub(var_41, var_38);
        var_43 = wp::div(var_42, var_dt);
        wp::array_store(var_particle_qd, var_36, var_43);
        // particle = particle_indices[local_axis]                                                <L 206>
        var_45 = wp::extract(var_2, var_44);
        // current_axis = particle_q[particle]                                                    <L 207>
        var_46 = wp::address(var_particle_q, var_45);
        var_48 = wp::load(var_46);
        var_47 = wp::copy(var_48);
        // local_axis_vector = wp.quat_rotate_inv(rotation, current_axis)                         <L 208>
        var_49 = wp::quat_rotate_inv(var_13, var_47);
        // predicted_axis = wp.quat_rotate(predicted_rotation, local_axis_vector)                 <L 209>
        var_50 = wp::quat_rotate(var_14, var_49);
        // particle_qd[particle] = (predicted_axis - current_axis) / dt                           <L 210>
        var_51 = wp::sub(var_50, var_47);
        var_52 = wp::div(var_51, var_dt);
        wp::array_store(var_particle_qd, var_45, var_52);
    }
}



extern "C" __global__ void _predict_affine_body_velocities_81ec5689_cuda_kernel_backward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::transform_t<wp::float32>> var_body_q,
    wp::array_t<wp::transform_t<wp::float32>> var_predicted_body_q,
    wp::array_t<wp::vec_t<4, wp::int32>> var_affine_body_indices,
    wp::array_t<wp::int32> var_affine_body_ids,
    wp::array_t<wp::vec_t<3, wp::float32>> var_body_com,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_q,
    wp::float32 var_dt,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_qd,
    wp::array_t<wp::transform_t<wp::float32>> adj_body_q,
    wp::array_t<wp::transform_t<wp::float32>> adj_predicted_body_q,
    wp::array_t<wp::vec_t<4, wp::int32>> adj_affine_body_indices,
    wp::array_t<wp::int32> adj_affine_body_ids,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_body_com,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_particle_q,
    wp::float32 adj_dt,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_particle_qd)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        wp::int32 var_0;
        wp::vec_t<4, wp::int32>* var_1;
        wp::vec_t<4, wp::int32> var_2;
        wp::vec_t<4, wp::int32> var_3;
        wp::int32* var_4;
        wp::int32 var_5;
        wp::int32 var_6;
        wp::transform_t<wp::float32>* var_7;
        wp::transform_t<wp::float32> var_8;
        wp::transform_t<wp::float32> var_9;
        wp::transform_t<wp::float32>* var_10;
        wp::transform_t<wp::float32> var_11;
        wp::transform_t<wp::float32> var_12;
        wp::quat_t<wp::float32> var_13;
        wp::quat_t<wp::float32> var_14;
        wp::vec_t<3, wp::float32> var_15;
        wp::vec_t<3, wp::float32>* var_16;
        wp::vec_t<3, wp::float32> var_17;
        wp::vec_t<3, wp::float32> var_18;
        wp::vec_t<3, wp::float32> var_19;
        const wp::int32 var_20 = 0;
        wp::int32 var_21;
        wp::vec_t<3, wp::float32>* var_22;
        wp::vec_t<3, wp::float32> var_23;
        wp::vec_t<3, wp::float32> var_24;
        wp::vec_t<3, wp::float32> var_25;
        const wp::int32 var_26 = 1;
        wp::int32 var_27;
        wp::vec_t<3, wp::float32>* var_28;
        wp::vec_t<3, wp::float32> var_29;
        wp::vec_t<3, wp::float32> var_30;
        wp::vec_t<3, wp::float32> var_31;
        wp::vec_t<3, wp::float32> var_32;
        wp::vec_t<3, wp::float32> var_33;
        wp::vec_t<3, wp::float32> var_34;
        const wp::int32 var_35 = 2;
        wp::int32 var_36;
        wp::vec_t<3, wp::float32>* var_37;
        wp::vec_t<3, wp::float32> var_38;
        wp::vec_t<3, wp::float32> var_39;
        wp::vec_t<3, wp::float32> var_40;
        wp::vec_t<3, wp::float32> var_41;
        wp::vec_t<3, wp::float32> var_42;
        wp::vec_t<3, wp::float32> var_43;
        const wp::int32 var_44 = 3;
        wp::int32 var_45;
        wp::vec_t<3, wp::float32>* var_46;
        wp::vec_t<3, wp::float32> var_47;
        wp::vec_t<3, wp::float32> var_48;
        wp::vec_t<3, wp::float32> var_49;
        wp::vec_t<3, wp::float32> var_50;
        wp::vec_t<3, wp::float32> var_51;
        wp::vec_t<3, wp::float32> var_52;
        //---------
        // dual vars
        wp::int32 adj_0 = {};
        wp::vec_t<4, wp::int32> adj_1 = {};
        wp::vec_t<4, wp::int32> adj_2 = {};
        wp::vec_t<4, wp::int32> adj_3 = {};
        wp::int32 adj_4 = {};
        wp::int32 adj_5 = {};
        wp::int32 adj_6 = {};
        wp::transform_t<wp::float32> adj_7 = {};
        wp::transform_t<wp::float32> adj_8 = {};
        wp::transform_t<wp::float32> adj_9 = {};
        wp::transform_t<wp::float32> adj_10 = {};
        wp::transform_t<wp::float32> adj_11 = {};
        wp::transform_t<wp::float32> adj_12 = {};
        wp::quat_t<wp::float32> adj_13 = {};
        wp::quat_t<wp::float32> adj_14 = {};
        wp::vec_t<3, wp::float32> adj_15 = {};
        wp::vec_t<3, wp::float32> adj_16 = {};
        wp::vec_t<3, wp::float32> adj_17 = {};
        wp::vec_t<3, wp::float32> adj_18 = {};
        wp::vec_t<3, wp::float32> adj_19 = {};
        wp::int32 adj_20 = {};
        wp::int32 adj_21 = {};
        wp::vec_t<3, wp::float32> adj_22 = {};
        wp::vec_t<3, wp::float32> adj_23 = {};
        wp::vec_t<3, wp::float32> adj_24 = {};
        wp::vec_t<3, wp::float32> adj_25 = {};
        wp::int32 adj_26 = {};
        wp::int32 adj_27 = {};
        wp::vec_t<3, wp::float32> adj_28 = {};
        wp::vec_t<3, wp::float32> adj_29 = {};
        wp::vec_t<3, wp::float32> adj_30 = {};
        wp::vec_t<3, wp::float32> adj_31 = {};
        wp::vec_t<3, wp::float32> adj_32 = {};
        wp::vec_t<3, wp::float32> adj_33 = {};
        wp::vec_t<3, wp::float32> adj_34 = {};
        wp::int32 adj_35 = {};
        wp::int32 adj_36 = {};
        wp::vec_t<3, wp::float32> adj_37 = {};
        wp::vec_t<3, wp::float32> adj_38 = {};
        wp::vec_t<3, wp::float32> adj_39 = {};
        wp::vec_t<3, wp::float32> adj_40 = {};
        wp::vec_t<3, wp::float32> adj_41 = {};
        wp::vec_t<3, wp::float32> adj_42 = {};
        wp::vec_t<3, wp::float32> adj_43 = {};
        wp::int32 adj_44 = {};
        wp::int32 adj_45 = {};
        wp::vec_t<3, wp::float32> adj_46 = {};
        wp::vec_t<3, wp::float32> adj_47 = {};
        wp::vec_t<3, wp::float32> adj_48 = {};
        wp::vec_t<3, wp::float32> adj_49 = {};
        wp::vec_t<3, wp::float32> adj_50 = {};
        wp::vec_t<3, wp::float32> adj_51 = {};
        wp::vec_t<3, wp::float32> adj_52 = {};
        //---------
        // forward
        // def _predict_affine_body_velocities(                                                   <L 180>
        // affine_body = wp.tid()                                                                 <L 191>
        var_0 = builtin_tid1d();
        // particle_indices = affine_body_indices[affine_body]                                    <L 192>
        var_1 = wp::address(var_affine_body_indices, var_0);
        var_3 = wp::load(var_1);
        var_2 = wp::copy(var_3);
        // body = affine_body_ids[affine_body]                                                    <L 193>
        var_4 = wp::address(var_affine_body_ids, var_0);
        var_6 = wp::load(var_4);
        var_5 = wp::copy(var_6);
        // pose = body_q[body]                                                                    <L 194>
        var_7 = wp::address(var_body_q, var_5);
        var_9 = wp::load(var_7);
        var_8 = wp::copy(var_9);
        // predicted_pose = predicted_body_q[body]                                                <L 195>
        var_10 = wp::address(var_predicted_body_q, var_5);
        var_12 = wp::load(var_10);
        var_11 = wp::copy(var_12);
        // rotation = wp.transform_get_rotation(pose)                                             <L 197>
        var_13 = wp::transform_get_rotation(var_8);
        // predicted_rotation = wp.transform_get_rotation(predicted_pose)                         <L 198>
        var_14 = wp::transform_get_rotation(var_11);
        // predicted_center = wp.transform_get_translation(predicted_pose) + wp.quat_rotate(       <L 199>
        var_15 = wp::transform_get_translation(var_11);
        // predicted_rotation, body_com[body]                                                     <L 200>
        var_16 = wp::address(var_body_com, var_5);
        var_18 = wp::load(var_16);
        var_17 = wp::quat_rotate(var_14, var_18);
        var_19 = wp::add(var_15, var_17);
        // center_particle = particle_indices[0]                                                  <L 203>
        var_21 = wp::extract(var_2, var_20);
        // particle_qd[center_particle] = (predicted_center - particle_q[center_particle]) / dt       <L 204>
        var_22 = wp::address(var_particle_q, var_21);
        var_24 = wp::load(var_22);
        var_23 = wp::sub(var_19, var_24);
        var_25 = wp::div(var_23, var_dt);
        // wp::array_store(var_particle_qd, var_21, var_25);
        // for local_axis in range(1, 4):                                                         <L 205>
        // particle = particle_indices[local_axis]                                                <L 206>
        var_27 = wp::extract(var_2, var_26);
        // current_axis = particle_q[particle]                                                    <L 207>
        var_28 = wp::address(var_particle_q, var_27);
        var_30 = wp::load(var_28);
        var_29 = wp::copy(var_30);
        // local_axis_vector = wp.quat_rotate_inv(rotation, current_axis)                         <L 208>
        var_31 = wp::quat_rotate_inv(var_13, var_29);
        // predicted_axis = wp.quat_rotate(predicted_rotation, local_axis_vector)                 <L 209>
        var_32 = wp::quat_rotate(var_14, var_31);
        // particle_qd[particle] = (predicted_axis - current_axis) / dt                           <L 210>
        var_33 = wp::sub(var_32, var_29);
        var_34 = wp::div(var_33, var_dt);
        // wp::array_store(var_particle_qd, var_27, var_34);
        // particle = particle_indices[local_axis]                                                <L 206>
        var_36 = wp::extract(var_2, var_35);
        // current_axis = particle_q[particle]                                                    <L 207>
        var_37 = wp::address(var_particle_q, var_36);
        var_39 = wp::load(var_37);
        var_38 = wp::copy(var_39);
        // local_axis_vector = wp.quat_rotate_inv(rotation, current_axis)                         <L 208>
        var_40 = wp::quat_rotate_inv(var_13, var_38);
        // predicted_axis = wp.quat_rotate(predicted_rotation, local_axis_vector)                 <L 209>
        var_41 = wp::quat_rotate(var_14, var_40);
        // particle_qd[particle] = (predicted_axis - current_axis) / dt                           <L 210>
        var_42 = wp::sub(var_41, var_38);
        var_43 = wp::div(var_42, var_dt);
        // wp::array_store(var_particle_qd, var_36, var_43);
        // particle = particle_indices[local_axis]                                                <L 206>
        var_45 = wp::extract(var_2, var_44);
        // current_axis = particle_q[particle]                                                    <L 207>
        var_46 = wp::address(var_particle_q, var_45);
        var_48 = wp::load(var_46);
        var_47 = wp::copy(var_48);
        // local_axis_vector = wp.quat_rotate_inv(rotation, current_axis)                         <L 208>
        var_49 = wp::quat_rotate_inv(var_13, var_47);
        // predicted_axis = wp.quat_rotate(predicted_rotation, local_axis_vector)                 <L 209>
        var_50 = wp::quat_rotate(var_14, var_49);
        // particle_qd[particle] = (predicted_axis - current_axis) / dt                           <L 210>
        var_51 = wp::sub(var_50, var_47);
        var_52 = wp::div(var_51, var_dt);
        // wp::array_store(var_particle_qd, var_45, var_52);
        //---------
        // reverse
        wp::adj_array_store(var_particle_qd, var_45, var_52, adj_particle_qd, adj_45, adj_52);
        wp::adj_div(var_51, var_dt, adj_51, adj_dt, adj_52);
        wp::adj_sub(var_50, var_47, adj_50, adj_47, adj_51);
        // adj: particle_qd[particle] = (predicted_axis - current_axis) / dt                      <L 210>
        wp::adj_quat_rotate(var_14, var_49, adj_14, adj_49, adj_50);
        // adj: predicted_axis = wp.quat_rotate(predicted_rotation, local_axis_vector)            <L 209>
        wp::adj_quat_rotate_inv(var_13, var_47, adj_13, adj_47, adj_49);
        // adj: local_axis_vector = wp.quat_rotate_inv(rotation, current_axis)                    <L 208>
        wp::adj_copy(var_48, adj_46, adj_47);
        wp::adj_address(var_particle_q, var_45, adj_particle_q, adj_45, adj_46);
        // adj: current_axis = particle_q[particle]                                               <L 207>
        wp::adj_extract(var_2, var_44, adj_2, adj_44, adj_45);
        // adj: particle = particle_indices[local_axis]                                           <L 206>
        wp::adj_array_store(var_particle_qd, var_36, var_43, adj_particle_qd, adj_36, adj_43);
        wp::adj_div(var_42, var_dt, adj_42, adj_dt, adj_43);
        wp::adj_sub(var_41, var_38, adj_41, adj_38, adj_42);
        // adj: particle_qd[particle] = (predicted_axis - current_axis) / dt                      <L 210>
        wp::adj_quat_rotate(var_14, var_40, adj_14, adj_40, adj_41);
        // adj: predicted_axis = wp.quat_rotate(predicted_rotation, local_axis_vector)            <L 209>
        wp::adj_quat_rotate_inv(var_13, var_38, adj_13, adj_38, adj_40);
        // adj: local_axis_vector = wp.quat_rotate_inv(rotation, current_axis)                    <L 208>
        wp::adj_copy(var_39, adj_37, adj_38);
        wp::adj_address(var_particle_q, var_36, adj_particle_q, adj_36, adj_37);
        // adj: current_axis = particle_q[particle]                                               <L 207>
        wp::adj_extract(var_2, var_35, adj_2, adj_35, adj_36);
        // adj: particle = particle_indices[local_axis]                                           <L 206>
        wp::adj_array_store(var_particle_qd, var_27, var_34, adj_particle_qd, adj_27, adj_34);
        wp::adj_div(var_33, var_dt, adj_33, adj_dt, adj_34);
        wp::adj_sub(var_32, var_29, adj_32, adj_29, adj_33);
        // adj: particle_qd[particle] = (predicted_axis - current_axis) / dt                      <L 210>
        wp::adj_quat_rotate(var_14, var_31, adj_14, adj_31, adj_32);
        // adj: predicted_axis = wp.quat_rotate(predicted_rotation, local_axis_vector)            <L 209>
        wp::adj_quat_rotate_inv(var_13, var_29, adj_13, adj_29, adj_31);
        // adj: local_axis_vector = wp.quat_rotate_inv(rotation, current_axis)                    <L 208>
        wp::adj_copy(var_30, adj_28, adj_29);
        wp::adj_address(var_particle_q, var_27, adj_particle_q, adj_27, adj_28);
        // adj: current_axis = particle_q[particle]                                               <L 207>
        wp::adj_extract(var_2, var_26, adj_2, adj_26, adj_27);
        // adj: particle = particle_indices[local_axis]                                           <L 206>
        // adj: for local_axis in range(1, 4):                                                    <L 205>
        wp::adj_array_store(var_particle_qd, var_21, var_25, adj_particle_qd, adj_21, adj_25);
        wp::adj_div(var_23, var_dt, adj_23, adj_dt, adj_25);
        wp::adj_sub(var_19, var_24, adj_19, adj_22, adj_23);
        wp::adj_address(var_particle_q, var_21, adj_particle_q, adj_21, adj_22);
        // adj: particle_qd[center_particle] = (predicted_center - particle_q[center_particle]) / dt  <L 204>
        wp::adj_extract(var_2, var_20, adj_2, adj_20, adj_21);
        // adj: center_particle = particle_indices[0]                                             <L 203>
        wp::adj_add(var_15, var_17, adj_15, adj_17, adj_19);
        wp::adj_quat_rotate(var_14, var_18, adj_14, adj_16, adj_17);
        wp::adj_address(var_body_com, var_5, adj_body_com, adj_5, adj_16);
        // adj: predicted_rotation, body_com[body]                                                <L 200>
        wp::adj_transform_get_translation(var_11, adj_11, adj_15);
        // adj: predicted_center = wp.transform_get_translation(predicted_pose) + wp.quat_rotate(  <L 199>
        wp::adj_transform_get_rotation(var_11, adj_11, adj_14);
        // adj: predicted_rotation = wp.transform_get_rotation(predicted_pose)                    <L 198>
        wp::adj_transform_get_rotation(var_8, adj_8, adj_13);
        // adj: rotation = wp.transform_get_rotation(pose)                                        <L 197>
        wp::adj_copy(var_12, adj_10, adj_11);
        wp::adj_address(var_predicted_body_q, var_5, adj_predicted_body_q, adj_5, adj_10);
        // adj: predicted_pose = predicted_body_q[body]                                           <L 195>
        wp::adj_copy(var_9, adj_7, adj_8);
        wp::adj_address(var_body_q, var_5, adj_body_q, adj_5, adj_7);
        // adj: pose = body_q[body]                                                               <L 194>
        wp::adj_copy(var_6, adj_4, adj_5);
        wp::adj_address(var_affine_body_ids, var_0, adj_affine_body_ids, adj_0, adj_4);
        // adj: body = affine_body_ids[affine_body]                                               <L 193>
        wp::adj_copy(var_3, adj_1, adj_2);
        wp::adj_address(var_affine_body_indices, var_0, adj_affine_body_indices, adj_0, adj_1);
        // adj: particle_indices = affine_body_indices[affine_body]                               <L 192>
        // adj: affine_body = wp.tid()                                                            <L 191>
        // adj: def _predict_affine_body_velocities(                                              <L 180>
        continue;
    }
}



extern "C" __global__ void _mask_joint_drive_reset_8cba3bd9_cuda_kernel_forward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::int32> var_body_mask,
    wp::array_t<wp::int32> var_affine_body_ids,
    wp::array_t<wp::vec_t<2, wp::int32>> var_drive_bodies,
    wp::array_t<wp::int32> var_angle_initialized,
    wp::array_t<wp::int32> var_drive_mask)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        wp::int32 var_0;
        wp::vec_t<2, wp::int32>* var_1;
        wp::vec_t<2, wp::int32> var_2;
        wp::vec_t<2, wp::int32> var_3;
        const wp::int32 var_4 = 1;
        wp::int32 var_5;
        wp::int32* var_6;
        wp::int32* var_7;
        wp::int32 var_8;
        const wp::int32 var_9 = 0;
        bool var_10;
        wp::int32 var_11;
        const wp::int32 var_12 = 0;
        wp::int32 var_13;
        const wp::int32 var_14 = 0;
        bool var_15;
        bool var_16;
        const wp::int32 var_17 = 0;
        wp::int32 var_18;
        wp::int32* var_19;
        wp::int32* var_20;
        wp::int32 var_21;
        const wp::int32 var_22 = 0;
        bool var_23;
        wp::int32 var_24;
        bool var_25;
        wp::int32 var_26;
        const wp::int32 var_27 = 0;
        //---------
        // forward
        // def _mask_joint_drive_reset(                                                           <L 428>
        // drive = wp.tid()                                                                       <L 435>
        var_0 = builtin_tid1d();
        // bodies = drive_bodies[drive]                                                           <L 436>
        var_1 = wp::address(var_drive_bodies, var_0);
        var_3 = wp::load(var_1);
        var_2 = wp::copy(var_3);
        // selected = body_mask[affine_body_ids[bodies[1]]] != 0                                  <L 437>
        var_5 = wp::extract(var_2, var_4);
        var_6 = wp::address(var_affine_body_ids, var_5);
        var_8 = wp::load(var_6);
        var_7 = wp::address(var_body_mask, var_8);
        var_11 = wp::load(var_7);
        var_10 = (var_11 != var_9);
        // if bodies[0] >= 0:                                                                     <L 438>
        var_13 = wp::extract(var_2, var_12);
        var_15 = (var_13 >= var_14);
        if (var_15) {
            // selected = selected or body_mask[affine_body_ids[bodies[0]]] != 0                  <L 439>
            var_16 = var_10;
            if (!var_16) {
                var_18 = wp::extract(var_2, var_17);
                var_19 = wp::address(var_affine_body_ids, var_18);
                var_21 = wp::load(var_19);
                var_20 = wp::address(var_body_mask, var_21);
                var_24 = wp::load(var_20);
                var_23 = (var_24 != var_22);
                var_16 = var_16 || var_23;
            }
        }
        var_25 = wp::where(var_15, var_16, var_10);
        // drive_mask[drive] = int(selected)                                                      <L 440>
        var_26 = wp::int(var_25);
        wp::array_store(var_drive_mask, var_0, var_26);
        // if selected:                                                                           <L 441>
        if (var_25) {
            // angle_initialized[drive] = 0                                                       <L 442>
            wp::array_store(var_angle_initialized, var_0, var_27);
        }
    }
}



extern "C" __global__ void _mask_joint_drive_reset_8cba3bd9_cuda_kernel_backward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::int32> var_body_mask,
    wp::array_t<wp::int32> var_affine_body_ids,
    wp::array_t<wp::vec_t<2, wp::int32>> var_drive_bodies,
    wp::array_t<wp::int32> var_angle_initialized,
    wp::array_t<wp::int32> var_drive_mask,
    wp::array_t<wp::int32> adj_body_mask,
    wp::array_t<wp::int32> adj_affine_body_ids,
    wp::array_t<wp::vec_t<2, wp::int32>> adj_drive_bodies,
    wp::array_t<wp::int32> adj_angle_initialized,
    wp::array_t<wp::int32> adj_drive_mask)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        wp::int32 var_0;
        wp::vec_t<2, wp::int32>* var_1;
        wp::vec_t<2, wp::int32> var_2;
        wp::vec_t<2, wp::int32> var_3;
        const wp::int32 var_4 = 1;
        wp::int32 var_5;
        wp::int32* var_6;
        wp::int32* var_7;
        wp::int32 var_8;
        const wp::int32 var_9 = 0;
        bool var_10;
        wp::int32 var_11;
        const wp::int32 var_12 = 0;
        wp::int32 var_13;
        const wp::int32 var_14 = 0;
        bool var_15;
        bool var_16;
        const wp::int32 var_17 = 0;
        wp::int32 var_18;
        wp::int32* var_19;
        wp::int32* var_20;
        wp::int32 var_21;
        const wp::int32 var_22 = 0;
        bool var_23;
        wp::int32 var_24;
        bool var_25;
        wp::int32 var_26;
        const wp::int32 var_27 = 0;
        //---------
        // dual vars
        wp::int32 adj_0 = {};
        wp::vec_t<2, wp::int32> adj_1 = {};
        wp::vec_t<2, wp::int32> adj_2 = {};
        wp::vec_t<2, wp::int32> adj_3 = {};
        wp::int32 adj_4 = {};
        wp::int32 adj_5 = {};
        wp::int32 adj_6 = {};
        wp::int32 adj_7 = {};
        wp::int32 adj_8 = {};
        wp::int32 adj_9 = {};
        bool adj_10 = {};
        wp::int32 adj_11 = {};
        wp::int32 adj_12 = {};
        wp::int32 adj_13 = {};
        wp::int32 adj_14 = {};
        bool adj_15 = {};
        bool adj_16 = {};
        wp::int32 adj_17 = {};
        wp::int32 adj_18 = {};
        wp::int32 adj_19 = {};
        wp::int32 adj_20 = {};
        wp::int32 adj_21 = {};
        wp::int32 adj_22 = {};
        bool adj_23 = {};
        wp::int32 adj_24 = {};
        bool adj_25 = {};
        wp::int32 adj_26 = {};
        wp::int32 adj_27 = {};
        //---------
        // forward
        // def _mask_joint_drive_reset(                                                           <L 428>
        // drive = wp.tid()                                                                       <L 435>
        var_0 = builtin_tid1d();
        // bodies = drive_bodies[drive]                                                           <L 436>
        var_1 = wp::address(var_drive_bodies, var_0);
        var_3 = wp::load(var_1);
        var_2 = wp::copy(var_3);
        // selected = body_mask[affine_body_ids[bodies[1]]] != 0                                  <L 437>
        var_5 = wp::extract(var_2, var_4);
        var_6 = wp::address(var_affine_body_ids, var_5);
        var_8 = wp::load(var_6);
        var_7 = wp::address(var_body_mask, var_8);
        var_11 = wp::load(var_7);
        var_10 = (var_11 != var_9);
        // if bodies[0] >= 0:                                                                     <L 438>
        var_13 = wp::extract(var_2, var_12);
        var_15 = (var_13 >= var_14);
        if (var_15) {
            // selected = selected or body_mask[affine_body_ids[bodies[0]]] != 0                  <L 439>
            var_16 = var_10;
            if (!var_16) {
                var_18 = wp::extract(var_2, var_17);
                var_19 = wp::address(var_affine_body_ids, var_18);
                var_21 = wp::load(var_19);
                var_20 = wp::address(var_body_mask, var_21);
                var_24 = wp::load(var_20);
                var_23 = (var_24 != var_22);
                var_16 = var_16 || var_23;
            }
        }
        var_25 = wp::where(var_15, var_16, var_10);
        // drive_mask[drive] = int(selected)                                                      <L 440>
        var_26 = wp::int(var_25);
        // wp::array_store(var_drive_mask, var_0, var_26);
        // if selected:                                                                           <L 441>
        if (var_25) {
            // angle_initialized[drive] = 0                                                       <L 442>
            // wp::array_store(var_angle_initialized, var_0, var_27);
        }
        //---------
        // reverse
        if (var_25) {
            wp::adj_array_store(var_angle_initialized, var_0, var_27, adj_angle_initialized, adj_0, adj_27);
            // adj: angle_initialized[drive] = 0                                                  <L 442>
        }
        // adj: if selected:                                                                      <L 441>
        wp::adj_array_store(var_drive_mask, var_0, var_26, adj_drive_mask, adj_0, adj_26);
        // adj: drive_mask[drive] = int(selected)                                                 <L 440>
        wp::adj_where(var_15, var_16, var_10, adj_15, adj_16, adj_10, adj_25);
        if (var_15) {
            if (!var_16) {
                wp::adj_address(var_body_mask, var_21, adj_body_mask, adj_19, adj_20);
                wp::adj_address(var_affine_body_ids, var_18, adj_affine_body_ids, adj_18, adj_19);
                wp::adj_extract(var_2, var_17, adj_2, adj_17, adj_18);
            }
            // adj: selected = selected or body_mask[affine_body_ids[bodies[0]]] != 0             <L 439>
        }
        wp::adj_extract(var_2, var_12, adj_2, adj_12, adj_13);
        // adj: if bodies[0] >= 0:                                                                <L 438>
        wp::adj_address(var_body_mask, var_8, adj_body_mask, adj_6, adj_7);
        wp::adj_address(var_affine_body_ids, var_5, adj_affine_body_ids, adj_5, adj_6);
        wp::adj_extract(var_2, var_4, adj_2, adj_4, adj_5);
        // adj: selected = body_mask[affine_body_ids[bodies[1]]] != 0                             <L 437>
        wp::adj_copy(var_3, adj_1, adj_2);
        wp::adj_address(var_drive_bodies, var_0, adj_drive_bodies, adj_0, adj_1);
        // adj: bodies = drive_bodies[drive]                                                      <L 436>
        // adj: drive = wp.tid()                                                                  <L 435>
        // adj: def _mask_joint_drive_reset(                                                      <L 428>
        continue;
    }
}



extern "C" __global__ void _refresh_affine_body_mass_kernel_8894776f_cuda_kernel_forward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::float32> var_body_mass,
    wp::array_t<wp::mat_t<3, 3, wp::float32>> var_body_inertia,
    wp::array_t<wp::vec_t<3, wp::float32>> var_body_com,
    wp::array_t<wp::int32> var_affine_body_ids,
    wp::array_t<wp::vec_t<4, wp::int32>> var_affine_body_indices,
    wp::array_t<wp::int32> var_rotation_locked,
    wp::array_t<wp::mat_t<3, 3, wp::float32>> var_inertia_offsets,
    wp::array_t<wp::vec_t<3, wp::int32>> var_mass_pair_slots,
    wp::array_t<wp::float32> var_mass_diagonal,
    wp::array_t<wp::float32> var_mass_non_diagonal,
    wp::array_t<wp::float32> var_affine_body_mass,
    wp::array_t<wp::mat_t<3, 3, wp::float32>> var_affine_body_inertia,
    wp::array_t<wp::vec_t<3, wp::float32>> var_affine_body_com)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        wp::int32 var_0;
        wp::int32* var_1;
        wp::int32 var_2;
        wp::int32 var_3;
        wp::float32* var_4;
        wp::float32 var_5;
        wp::float32 var_6;
        wp::mat_t<3, 3, wp::float32>* var_7;
        wp::mat_t<3, 3, wp::float32> var_8;
        wp::mat_t<3, 3, wp::float32> var_9;
        bool var_10;
        const wp::float32 var_11 = 0.0;
        bool var_12;
        wp::int32* var_13;
        const wp::int32 var_14 = 0;
        bool var_15;
        wp::int32 var_16;
        const wp::int32 var_17 = 3;
        wp::mat_t<3, 3, wp::float32> var_18;
        const wp::float32 var_19 = 0.5;
        wp::mat_t<3, 3, wp::float32> var_20;
        wp::mat_t<3, 3, wp::float32> var_21;
        wp::mat_t<3, 3, wp::float32> var_22;
        wp::mat_t<3, 3, wp::float32>* var_23;
        wp::mat_t<3, 3, wp::float32> var_24;
        wp::mat_t<3, 3, wp::float32> var_25;
        wp::mat_t<3, 3, wp::float32> var_26;
        const wp::float32 var_27 = 0.0;
        bool var_28;
        const wp::float32 var_29 = 1.0;
        wp::float32 var_30;
        const wp::float32 var_31 = 0.5;
        wp::float32 var_32;
        wp::float32 var_33;
        const wp::int32 var_34 = 3;
        wp::mat_t<3, 3, wp::float32> var_35;
        wp::mat_t<3, 3, wp::float32> var_36;
        wp::mat_t<3, 3, wp::float32> var_37;
        wp::vec_t<4, wp::int32>* var_38;
        wp::vec_t<4, wp::int32> var_39;
        wp::vec_t<4, wp::int32> var_40;
        const wp::int32 var_41 = 0;
        wp::int32 var_42;
        const wp::int32 var_43 = 0;
        wp::float32 var_44;
        const wp::int32 var_45 = 1;
        wp::int32 var_46;
        wp::int32 var_47;
        const wp::int32 var_48 = 1;
        wp::float32 var_49;
        const wp::int32 var_50 = 1;
        wp::int32 var_51;
        wp::int32 var_52;
        const wp::int32 var_53 = 2;
        wp::float32 var_54;
        const wp::int32 var_55 = 1;
        wp::int32 var_56;
        wp::int32 var_57;
        wp::vec_t<3, wp::int32>* var_58;
        wp::vec_t<3, wp::int32> var_59;
        wp::vec_t<3, wp::int32> var_60;
        const wp::int32 var_61 = 0;
        const wp::int32 var_62 = 1;
        wp::float32 var_63;
        const wp::int32 var_64 = 0;
        wp::int32 var_65;
        const wp::int32 var_66 = 0;
        const wp::int32 var_67 = 2;
        wp::float32 var_68;
        const wp::int32 var_69 = 1;
        wp::int32 var_70;
        const wp::int32 var_71 = 1;
        const wp::int32 var_72 = 2;
        wp::float32 var_73;
        const wp::int32 var_74 = 2;
        wp::int32 var_75;
        wp::vec_t<3, wp::float32>* var_76;
        wp::vec_t<3, wp::float32> var_77;
        //---------
        // forward
        // def _refresh_affine_body_mass_kernel(                                                  <L 69>
        // affine = wp.tid()                                                                      <L 84>
        var_0 = builtin_tid1d();
        // body = affine_body_ids[affine]                                                         <L 85>
        var_1 = wp::address(var_affine_body_ids, var_0);
        var_3 = wp::load(var_1);
        var_2 = wp::copy(var_3);
        // mass = body_mass[body]                                                                 <L 86>
        var_4 = wp::address(var_body_mass, var_2);
        var_6 = wp::load(var_4);
        var_5 = wp::copy(var_6);
        // inertia = body_inertia[body]                                                           <L 87>
        var_7 = wp::address(var_body_inertia, var_2);
        var_9 = wp::load(var_7);
        var_8 = wp::copy(var_9);
        // if mass <= 0.0 or rotation_locked[affine] != 0:                                        <L 90>
        var_12 = (var_5 <= var_11);
        var_10 = var_12;
        if (!var_10) {
            var_13 = wp::address(var_rotation_locked, var_0);
            var_16 = wp::load(var_13);
            var_15 = (var_16 != var_14);
            var_10 = var_10 || var_15;
        }
        if (var_10) {
            // inertia = wp.identity(3, dtype=float)                                              <L 91>
            var_18 = wp::identity<3, wp::float32>();
        }
        if (!var_10) {
            // inertia = 0.5 * (inertia + wp.transpose(inertia)) + inertia_offsets[affine]        <L 93>
            var_20 = wp::transpose(var_8);
            var_21 = wp::add(var_8, var_20);
            var_22 = wp::mul(var_19, var_21);
            var_23 = wp::address(var_inertia_offsets, var_0);
            var_25 = wp::load(var_23);
            var_24 = wp::add(var_22, var_25);
        }
        var_26 = wp::where(var_10, var_18, var_24);
        // proxy_mass = wp.where(mass > 0.0, mass, 1.0)                                           <L 94>
        var_28 = (var_5 > var_27);
        var_30 = wp::where(var_28, var_5, var_29);
        // second_moment = 0.5 * wp.trace(inertia) * wp.identity(3, dtype=float) - inertia        <L 95>
        var_32 = wp::trace(var_26);
        var_33 = wp::mul(var_31, var_32);
        var_35 = wp::identity<3, wp::float32>();
        var_36 = wp::mul(var_33, var_35);
        var_37 = wp::sub(var_36, var_26);
        // particles = affine_body_indices[affine]                                                <L 96>
        var_38 = wp::address(var_affine_body_indices, var_0);
        var_40 = wp::load(var_38);
        var_39 = wp::copy(var_40);
        // mass_diagonal[particles[0]] = proxy_mass                                               <L 97>
        var_42 = wp::extract(var_39, var_41);
        wp::array_store(var_mass_diagonal, var_42, var_30);
        // for axis in range(3):                                                                  <L 98>
        // mass_diagonal[particles[axis + 1]] = second_moment[axis, axis]                         <L 99>
        var_44 = wp::extract(var_37, var_43, var_43);
        var_46 = wp::add(var_43, var_45);
        var_47 = wp::extract(var_39, var_46);
        wp::array_store(var_mass_diagonal, var_47, var_44);
        var_49 = wp::extract(var_37, var_48, var_48);
        var_51 = wp::add(var_48, var_50);
        var_52 = wp::extract(var_39, var_51);
        wp::array_store(var_mass_diagonal, var_52, var_49);
        var_54 = wp::extract(var_37, var_53, var_53);
        var_56 = wp::add(var_53, var_55);
        var_57 = wp::extract(var_39, var_56);
        wp::array_store(var_mass_diagonal, var_57, var_54);
        // slots = mass_pair_slots[affine]                                                        <L 100>
        var_58 = wp::address(var_mass_pair_slots, var_0);
        var_60 = wp::load(var_58);
        var_59 = wp::copy(var_60);
        // mass_non_diagonal[slots[0]] = second_moment[0, 1]                                      <L 101>
        var_63 = wp::extract(var_37, var_61, var_62);
        var_65 = wp::extract(var_59, var_64);
        wp::array_store(var_mass_non_diagonal, var_65, var_63);
        // mass_non_diagonal[slots[1]] = second_moment[0, 2]                                      <L 102>
        var_68 = wp::extract(var_37, var_66, var_67);
        var_70 = wp::extract(var_59, var_69);
        wp::array_store(var_mass_non_diagonal, var_70, var_68);
        // mass_non_diagonal[slots[2]] = second_moment[1, 2]                                      <L 103>
        var_73 = wp::extract(var_37, var_71, var_72);
        var_75 = wp::extract(var_59, var_74);
        wp::array_store(var_mass_non_diagonal, var_75, var_73);
        // affine_body_mass[affine] = proxy_mass                                                  <L 104>
        wp::array_store(var_affine_body_mass, var_0, var_30);
        // affine_body_inertia[affine] = inertia                                                  <L 105>
        wp::array_store(var_affine_body_inertia, var_0, var_26);
        // affine_body_com[affine] = body_com[body]                                               <L 106>
        var_76 = wp::address(var_body_com, var_2);
        var_77 = wp::load(var_76);
        wp::array_store(var_affine_body_com, var_0, var_77);
    }
}



extern "C" __global__ void _refresh_affine_body_mass_kernel_8894776f_cuda_kernel_backward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::float32> var_body_mass,
    wp::array_t<wp::mat_t<3, 3, wp::float32>> var_body_inertia,
    wp::array_t<wp::vec_t<3, wp::float32>> var_body_com,
    wp::array_t<wp::int32> var_affine_body_ids,
    wp::array_t<wp::vec_t<4, wp::int32>> var_affine_body_indices,
    wp::array_t<wp::int32> var_rotation_locked,
    wp::array_t<wp::mat_t<3, 3, wp::float32>> var_inertia_offsets,
    wp::array_t<wp::vec_t<3, wp::int32>> var_mass_pair_slots,
    wp::array_t<wp::float32> var_mass_diagonal,
    wp::array_t<wp::float32> var_mass_non_diagonal,
    wp::array_t<wp::float32> var_affine_body_mass,
    wp::array_t<wp::mat_t<3, 3, wp::float32>> var_affine_body_inertia,
    wp::array_t<wp::vec_t<3, wp::float32>> var_affine_body_com,
    wp::array_t<wp::float32> adj_body_mass,
    wp::array_t<wp::mat_t<3, 3, wp::float32>> adj_body_inertia,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_body_com,
    wp::array_t<wp::int32> adj_affine_body_ids,
    wp::array_t<wp::vec_t<4, wp::int32>> adj_affine_body_indices,
    wp::array_t<wp::int32> adj_rotation_locked,
    wp::array_t<wp::mat_t<3, 3, wp::float32>> adj_inertia_offsets,
    wp::array_t<wp::vec_t<3, wp::int32>> adj_mass_pair_slots,
    wp::array_t<wp::float32> adj_mass_diagonal,
    wp::array_t<wp::float32> adj_mass_non_diagonal,
    wp::array_t<wp::float32> adj_affine_body_mass,
    wp::array_t<wp::mat_t<3, 3, wp::float32>> adj_affine_body_inertia,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_affine_body_com)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        wp::int32 var_0;
        wp::int32* var_1;
        wp::int32 var_2;
        wp::int32 var_3;
        wp::float32* var_4;
        wp::float32 var_5;
        wp::float32 var_6;
        wp::mat_t<3, 3, wp::float32>* var_7;
        wp::mat_t<3, 3, wp::float32> var_8;
        wp::mat_t<3, 3, wp::float32> var_9;
        bool var_10;
        const wp::float32 var_11 = 0.0;
        bool var_12;
        wp::int32* var_13;
        const wp::int32 var_14 = 0;
        bool var_15;
        wp::int32 var_16;
        const wp::int32 var_17 = 3;
        wp::mat_t<3, 3, wp::float32> var_18;
        const wp::float32 var_19 = 0.5;
        wp::mat_t<3, 3, wp::float32> var_20;
        wp::mat_t<3, 3, wp::float32> var_21;
        wp::mat_t<3, 3, wp::float32> var_22;
        wp::mat_t<3, 3, wp::float32>* var_23;
        wp::mat_t<3, 3, wp::float32> var_24;
        wp::mat_t<3, 3, wp::float32> var_25;
        wp::mat_t<3, 3, wp::float32> var_26;
        const wp::float32 var_27 = 0.0;
        bool var_28;
        const wp::float32 var_29 = 1.0;
        wp::float32 var_30;
        const wp::float32 var_31 = 0.5;
        wp::float32 var_32;
        wp::float32 var_33;
        const wp::int32 var_34 = 3;
        wp::mat_t<3, 3, wp::float32> var_35;
        wp::mat_t<3, 3, wp::float32> var_36;
        wp::mat_t<3, 3, wp::float32> var_37;
        wp::vec_t<4, wp::int32>* var_38;
        wp::vec_t<4, wp::int32> var_39;
        wp::vec_t<4, wp::int32> var_40;
        const wp::int32 var_41 = 0;
        wp::int32 var_42;
        const wp::int32 var_43 = 0;
        wp::float32 var_44;
        const wp::int32 var_45 = 1;
        wp::int32 var_46;
        wp::int32 var_47;
        const wp::int32 var_48 = 1;
        wp::float32 var_49;
        const wp::int32 var_50 = 1;
        wp::int32 var_51;
        wp::int32 var_52;
        const wp::int32 var_53 = 2;
        wp::float32 var_54;
        const wp::int32 var_55 = 1;
        wp::int32 var_56;
        wp::int32 var_57;
        wp::vec_t<3, wp::int32>* var_58;
        wp::vec_t<3, wp::int32> var_59;
        wp::vec_t<3, wp::int32> var_60;
        const wp::int32 var_61 = 0;
        const wp::int32 var_62 = 1;
        wp::float32 var_63;
        const wp::int32 var_64 = 0;
        wp::int32 var_65;
        const wp::int32 var_66 = 0;
        const wp::int32 var_67 = 2;
        wp::float32 var_68;
        const wp::int32 var_69 = 1;
        wp::int32 var_70;
        const wp::int32 var_71 = 1;
        const wp::int32 var_72 = 2;
        wp::float32 var_73;
        const wp::int32 var_74 = 2;
        wp::int32 var_75;
        wp::vec_t<3, wp::float32>* var_76;
        wp::vec_t<3, wp::float32> var_77;
        //---------
        // dual vars
        wp::int32 adj_0 = {};
        wp::int32 adj_1 = {};
        wp::int32 adj_2 = {};
        wp::int32 adj_3 = {};
        wp::float32 adj_4 = {};
        wp::float32 adj_5 = {};
        wp::float32 adj_6 = {};
        wp::mat_t<3, 3, wp::float32> adj_7 = {};
        wp::mat_t<3, 3, wp::float32> adj_8 = {};
        wp::mat_t<3, 3, wp::float32> adj_9 = {};
        bool adj_10 = {};
        wp::float32 adj_11 = {};
        bool adj_12 = {};
        wp::int32 adj_13 = {};
        wp::int32 adj_14 = {};
        bool adj_15 = {};
        wp::int32 adj_16 = {};
        wp::int32 adj_17 = {};
        wp::mat_t<3, 3, wp::float32> adj_18 = {};
        wp::float32 adj_19 = {};
        wp::mat_t<3, 3, wp::float32> adj_20 = {};
        wp::mat_t<3, 3, wp::float32> adj_21 = {};
        wp::mat_t<3, 3, wp::float32> adj_22 = {};
        wp::mat_t<3, 3, wp::float32> adj_23 = {};
        wp::mat_t<3, 3, wp::float32> adj_24 = {};
        wp::mat_t<3, 3, wp::float32> adj_25 = {};
        wp::mat_t<3, 3, wp::float32> adj_26 = {};
        wp::float32 adj_27 = {};
        bool adj_28 = {};
        wp::float32 adj_29 = {};
        wp::float32 adj_30 = {};
        wp::float32 adj_31 = {};
        wp::float32 adj_32 = {};
        wp::float32 adj_33 = {};
        wp::int32 adj_34 = {};
        wp::mat_t<3, 3, wp::float32> adj_35 = {};
        wp::mat_t<3, 3, wp::float32> adj_36 = {};
        wp::mat_t<3, 3, wp::float32> adj_37 = {};
        wp::vec_t<4, wp::int32> adj_38 = {};
        wp::vec_t<4, wp::int32> adj_39 = {};
        wp::vec_t<4, wp::int32> adj_40 = {};
        wp::int32 adj_41 = {};
        wp::int32 adj_42 = {};
        wp::int32 adj_43 = {};
        wp::float32 adj_44 = {};
        wp::int32 adj_45 = {};
        wp::int32 adj_46 = {};
        wp::int32 adj_47 = {};
        wp::int32 adj_48 = {};
        wp::float32 adj_49 = {};
        wp::int32 adj_50 = {};
        wp::int32 adj_51 = {};
        wp::int32 adj_52 = {};
        wp::int32 adj_53 = {};
        wp::float32 adj_54 = {};
        wp::int32 adj_55 = {};
        wp::int32 adj_56 = {};
        wp::int32 adj_57 = {};
        wp::vec_t<3, wp::int32> adj_58 = {};
        wp::vec_t<3, wp::int32> adj_59 = {};
        wp::vec_t<3, wp::int32> adj_60 = {};
        wp::int32 adj_61 = {};
        wp::int32 adj_62 = {};
        wp::float32 adj_63 = {};
        wp::int32 adj_64 = {};
        wp::int32 adj_65 = {};
        wp::int32 adj_66 = {};
        wp::int32 adj_67 = {};
        wp::float32 adj_68 = {};
        wp::int32 adj_69 = {};
        wp::int32 adj_70 = {};
        wp::int32 adj_71 = {};
        wp::int32 adj_72 = {};
        wp::float32 adj_73 = {};
        wp::int32 adj_74 = {};
        wp::int32 adj_75 = {};
        wp::vec_t<3, wp::float32> adj_76 = {};
        wp::vec_t<3, wp::float32> adj_77 = {};
        //---------
        // forward
        // def _refresh_affine_body_mass_kernel(                                                  <L 69>
        // affine = wp.tid()                                                                      <L 84>
        var_0 = builtin_tid1d();
        // body = affine_body_ids[affine]                                                         <L 85>
        var_1 = wp::address(var_affine_body_ids, var_0);
        var_3 = wp::load(var_1);
        var_2 = wp::copy(var_3);
        // mass = body_mass[body]                                                                 <L 86>
        var_4 = wp::address(var_body_mass, var_2);
        var_6 = wp::load(var_4);
        var_5 = wp::copy(var_6);
        // inertia = body_inertia[body]                                                           <L 87>
        var_7 = wp::address(var_body_inertia, var_2);
        var_9 = wp::load(var_7);
        var_8 = wp::copy(var_9);
        // if mass <= 0.0 or rotation_locked[affine] != 0:                                        <L 90>
        var_12 = (var_5 <= var_11);
        var_10 = var_12;
        if (!var_10) {
            var_13 = wp::address(var_rotation_locked, var_0);
            var_16 = wp::load(var_13);
            var_15 = (var_16 != var_14);
            var_10 = var_10 || var_15;
        }
        if (var_10) {
            // inertia = wp.identity(3, dtype=float)                                              <L 91>
            var_18 = wp::identity<3, wp::float32>();
        }
        if (!var_10) {
            // inertia = 0.5 * (inertia + wp.transpose(inertia)) + inertia_offsets[affine]        <L 93>
            var_20 = wp::transpose(var_8);
            var_21 = wp::add(var_8, var_20);
            var_22 = wp::mul(var_19, var_21);
            var_23 = wp::address(var_inertia_offsets, var_0);
            var_25 = wp::load(var_23);
            var_24 = wp::add(var_22, var_25);
        }
        var_26 = wp::where(var_10, var_18, var_24);
        // proxy_mass = wp.where(mass > 0.0, mass, 1.0)                                           <L 94>
        var_28 = (var_5 > var_27);
        var_30 = wp::where(var_28, var_5, var_29);
        // second_moment = 0.5 * wp.trace(inertia) * wp.identity(3, dtype=float) - inertia        <L 95>
        var_32 = wp::trace(var_26);
        var_33 = wp::mul(var_31, var_32);
        var_35 = wp::identity<3, wp::float32>();
        var_36 = wp::mul(var_33, var_35);
        var_37 = wp::sub(var_36, var_26);
        // particles = affine_body_indices[affine]                                                <L 96>
        var_38 = wp::address(var_affine_body_indices, var_0);
        var_40 = wp::load(var_38);
        var_39 = wp::copy(var_40);
        // mass_diagonal[particles[0]] = proxy_mass                                               <L 97>
        var_42 = wp::extract(var_39, var_41);
        // wp::array_store(var_mass_diagonal, var_42, var_30);
        // for axis in range(3):                                                                  <L 98>
        // mass_diagonal[particles[axis + 1]] = second_moment[axis, axis]                         <L 99>
        var_44 = wp::extract(var_37, var_43, var_43);
        var_46 = wp::add(var_43, var_45);
        var_47 = wp::extract(var_39, var_46);
        // wp::array_store(var_mass_diagonal, var_47, var_44);
        var_49 = wp::extract(var_37, var_48, var_48);
        var_51 = wp::add(var_48, var_50);
        var_52 = wp::extract(var_39, var_51);
        // wp::array_store(var_mass_diagonal, var_52, var_49);
        var_54 = wp::extract(var_37, var_53, var_53);
        var_56 = wp::add(var_53, var_55);
        var_57 = wp::extract(var_39, var_56);
        // wp::array_store(var_mass_diagonal, var_57, var_54);
        // slots = mass_pair_slots[affine]                                                        <L 100>
        var_58 = wp::address(var_mass_pair_slots, var_0);
        var_60 = wp::load(var_58);
        var_59 = wp::copy(var_60);
        // mass_non_diagonal[slots[0]] = second_moment[0, 1]                                      <L 101>
        var_63 = wp::extract(var_37, var_61, var_62);
        var_65 = wp::extract(var_59, var_64);
        // wp::array_store(var_mass_non_diagonal, var_65, var_63);
        // mass_non_diagonal[slots[1]] = second_moment[0, 2]                                      <L 102>
        var_68 = wp::extract(var_37, var_66, var_67);
        var_70 = wp::extract(var_59, var_69);
        // wp::array_store(var_mass_non_diagonal, var_70, var_68);
        // mass_non_diagonal[slots[2]] = second_moment[1, 2]                                      <L 103>
        var_73 = wp::extract(var_37, var_71, var_72);
        var_75 = wp::extract(var_59, var_74);
        // wp::array_store(var_mass_non_diagonal, var_75, var_73);
        // affine_body_mass[affine] = proxy_mass                                                  <L 104>
        // wp::array_store(var_affine_body_mass, var_0, var_30);
        // affine_body_inertia[affine] = inertia                                                  <L 105>
        // wp::array_store(var_affine_body_inertia, var_0, var_26);
        // affine_body_com[affine] = body_com[body]                                               <L 106>
        var_76 = wp::address(var_body_com, var_2);
        var_77 = wp::load(var_76);
        // wp::array_store(var_affine_body_com, var_0, var_77);
        //---------
        // reverse
        wp::adj_array_store(var_affine_body_com, var_0, var_77, adj_affine_body_com, adj_0, adj_76);
        wp::adj_address(var_body_com, var_2, adj_body_com, adj_2, adj_76);
        // adj: affine_body_com[affine] = body_com[body]                                          <L 106>
        wp::adj_array_store(var_affine_body_inertia, var_0, var_26, adj_affine_body_inertia, adj_0, adj_26);
        // adj: affine_body_inertia[affine] = inertia                                             <L 105>
        wp::adj_array_store(var_affine_body_mass, var_0, var_30, adj_affine_body_mass, adj_0, adj_30);
        // adj: affine_body_mass[affine] = proxy_mass                                             <L 104>
        wp::adj_array_store(var_mass_non_diagonal, var_75, var_73, adj_mass_non_diagonal, adj_75, adj_73);
        wp::adj_extract(var_59, var_74, adj_59, adj_74, adj_75);
        wp::adj_extract(var_37, var_71, var_72, adj_37, adj_71, adj_72, adj_73);
        // adj: mass_non_diagonal[slots[2]] = second_moment[1, 2]                                 <L 103>
        wp::adj_array_store(var_mass_non_diagonal, var_70, var_68, adj_mass_non_diagonal, adj_70, adj_68);
        wp::adj_extract(var_59, var_69, adj_59, adj_69, adj_70);
        wp::adj_extract(var_37, var_66, var_67, adj_37, adj_66, adj_67, adj_68);
        // adj: mass_non_diagonal[slots[1]] = second_moment[0, 2]                                 <L 102>
        wp::adj_array_store(var_mass_non_diagonal, var_65, var_63, adj_mass_non_diagonal, adj_65, adj_63);
        wp::adj_extract(var_59, var_64, adj_59, adj_64, adj_65);
        wp::adj_extract(var_37, var_61, var_62, adj_37, adj_61, adj_62, adj_63);
        // adj: mass_non_diagonal[slots[0]] = second_moment[0, 1]                                 <L 101>
        wp::adj_copy(var_60, adj_58, adj_59);
        wp::adj_address(var_mass_pair_slots, var_0, adj_mass_pair_slots, adj_0, adj_58);
        // adj: slots = mass_pair_slots[affine]                                                   <L 100>
        wp::adj_array_store(var_mass_diagonal, var_57, var_54, adj_mass_diagonal, adj_57, adj_54);
        wp::adj_extract(var_39, var_56, adj_39, adj_56, adj_57);
        wp::adj_add(var_53, var_55, adj_53, adj_55, adj_56);
        wp::adj_extract(var_37, var_53, var_53, adj_37, adj_53, adj_53, adj_54);
        wp::adj_array_store(var_mass_diagonal, var_52, var_49, adj_mass_diagonal, adj_52, adj_49);
        wp::adj_extract(var_39, var_51, adj_39, adj_51, adj_52);
        wp::adj_add(var_48, var_50, adj_48, adj_50, adj_51);
        wp::adj_extract(var_37, var_48, var_48, adj_37, adj_48, adj_48, adj_49);
        wp::adj_array_store(var_mass_diagonal, var_47, var_44, adj_mass_diagonal, adj_47, adj_44);
        wp::adj_extract(var_39, var_46, adj_39, adj_46, adj_47);
        wp::adj_add(var_43, var_45, adj_43, adj_45, adj_46);
        wp::adj_extract(var_37, var_43, var_43, adj_37, adj_43, adj_43, adj_44);
        // adj: mass_diagonal[particles[axis + 1]] = second_moment[axis, axis]                    <L 99>
        // adj: for axis in range(3):                                                             <L 98>
        wp::adj_array_store(var_mass_diagonal, var_42, var_30, adj_mass_diagonal, adj_42, adj_30);
        wp::adj_extract(var_39, var_41, adj_39, adj_41, adj_42);
        // adj: mass_diagonal[particles[0]] = proxy_mass                                          <L 97>
        wp::adj_copy(var_40, adj_38, adj_39);
        wp::adj_address(var_affine_body_indices, var_0, adj_affine_body_indices, adj_0, adj_38);
        // adj: particles = affine_body_indices[affine]                                           <L 96>
        wp::adj_sub(var_36, var_26, adj_36, adj_26, adj_37);
        wp::adj_mul(var_33, var_35, adj_33, adj_35, adj_36);
        wp::adj_mul(var_31, var_32, adj_31, adj_32, adj_33);
        wp::adj_trace(var_26, adj_26, adj_32);
        // adj: second_moment = 0.5 * wp.trace(inertia) * wp.identity(3, dtype=float) - inertia   <L 95>
        wp::adj_where(var_28, var_5, var_29, adj_28, adj_5, adj_29, adj_30);
        // adj: proxy_mass = wp.where(mass > 0.0, mass, 1.0)                                      <L 94>
        wp::adj_where(var_10, var_18, var_24, adj_10, adj_18, adj_24, adj_26);
        if (!var_10) {
            wp::adj_add(var_22, var_25, adj_22, adj_23, adj_24);
            wp::adj_address(var_inertia_offsets, var_0, adj_inertia_offsets, adj_0, adj_23);
            wp::adj_mul(var_19, var_21, adj_19, adj_21, adj_22);
            wp::adj_add(var_8, var_20, adj_8, adj_20, adj_21);
            wp::adj_transpose(var_8, adj_8, adj_20);
            // adj: inertia = 0.5 * (inertia + wp.transpose(inertia)) + inertia_offsets[affine]   <L 93>
        }
        if (var_10) {
            // adj: inertia = wp.identity(3, dtype=float)                                         <L 91>
        }
        if (!var_10) {
            wp::adj_address(var_rotation_locked, var_0, adj_rotation_locked, adj_0, adj_13);
        }
        // adj: if mass <= 0.0 or rotation_locked[affine] != 0:                                   <L 90>
        wp::adj_copy(var_9, adj_7, adj_8);
        wp::adj_address(var_body_inertia, var_2, adj_body_inertia, adj_2, adj_7);
        // adj: inertia = body_inertia[body]                                                      <L 87>
        wp::adj_copy(var_6, adj_4, adj_5);
        wp::adj_address(var_body_mass, var_2, adj_body_mass, adj_2, adj_4);
        // adj: mass = body_mass[body]                                                            <L 86>
        wp::adj_copy(var_3, adj_1, adj_2);
        wp::adj_address(var_affine_body_ids, var_0, adj_affine_body_ids, adj_0, adj_1);
        // adj: body = affine_body_ids[affine]                                                    <L 85>
        // adj: affine = wp.tid()                                                                 <L 84>
        // adj: def _refresh_affine_body_mass_kernel(                                             <L 69>
        continue;
    }
}



extern "C" __global__ void _reset_cable_history_5042ded3_cuda_kernel_forward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<bool> var_world_mask,
    bool var_reset_all,
    wp::int32 var_world_count,
    wp::array_t<wp::int32> var_cable_joints,
    wp::array_t<wp::int32> var_joint_world,
    wp::array_t<bool> var_rebaseline_mask,
    wp::array_t<wp::vec_t<3, wp::float32>> var_sigma_prev,
    wp::array_t<wp::vec_t<3, wp::float32>> var_kappa_prev,
    wp::array_t<wp::vec_t<3, wp::float32>> var_dkappa_prev,
    wp::array_t<wp::vec_t<3, wp::float32>> var_sigma_start,
    wp::array_t<wp::vec_t<3, wp::float32>> var_friction_hessian,
    wp::array_t<wp::int32> var_penalty_reset_mask)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        wp::int32 var_0;
        const wp::int32 var_1 = 1;
        wp::int32 var_2;
        bool var_3;
        wp::int32 var_4;
        bool var_5;
        const wp::int32 var_6 = -1;
        wp::int32 var_7;
        bool var_8;
        const bool var_9 = true;
        wp::shape_t* var_10;
        const wp::int32 var_11 = 0;
        wp::int32 var_12;
        wp::shape_t var_13;
        bool var_14;
        wp::int32* var_15;
        wp::int32 var_16;
        wp::int32 var_17;
        wp::int32* var_18;
        bool var_19;
        wp::int32 var_20;
        wp::int32 var_21;
        const wp::float32 var_22 = 0.0;
        wp::vec_t<3, wp::float32> var_23;
        const wp::float32 var_24 = 0.0;
        wp::vec_t<3, wp::float32> var_25;
        const wp::float32 var_26 = 0.0;
        wp::vec_t<3, wp::float32> var_27;
        const wp::float32 var_28 = 0.0;
        wp::vec_t<3, wp::float32> var_29;
        const wp::float32 var_30 = 0.0;
        wp::vec_t<3, wp::float32> var_31;
        //---------
        // forward
        // def _reset_cable_history(                                                              <L 330>
        // index = wp.tid()                                                                       <L 344>
        var_0 = builtin_tid1d();
        // if index < world_count + 1:                                                            <L 345>
        var_2 = wp::add(var_world_count, var_1);
        var_3 = (var_0 < var_2);
        if (var_3) {
            // world = index                                                                      <L 346>
            var_4 = wp::copy(var_0);
            // if index == world_count:                                                           <L 347>
            var_5 = (var_0 == var_world_count);
            if (var_5) {
                // world = -1                                                                     <L 348>
            }
            var_7 = wp::where(var_5, var_6, var_4);
            // if _reset_selected_world(world, world_mask, world_count, reset_all):               <L 349>
            var_8 = _reset_selected_world_0(var_7, var_world_mask, var_world_count, var_reset_all);
            if (var_8) {
                // rebaseline_mask[index] = True                                                  <L 350>
                wp::array_store(var_rebaseline_mask, var_0, var_9);
            }
        }
        // if index < cable_joints.shape[0]:                                                      <L 351>
        var_10 = &(var_cable_joints.shape);
        var_13 = wp::load(var_10);
        var_12 = wp::extract(var_13, var_11);
        var_14 = (var_0 < var_12);
        if (var_14) {
            // joint = cable_joints[index]                                                        <L 352>
            var_15 = wp::address(var_cable_joints, var_0);
            var_17 = wp::load(var_15);
            var_16 = wp::copy(var_17);
            // selected = _reset_selected_world(joint_world[joint], world_mask, world_count, reset_all)       <L 353>
            var_18 = wp::address(var_joint_world, var_16);
            var_20 = wp::load(var_18);
            var_19 = _reset_selected_world_0(var_20, var_world_mask, var_world_count, var_reset_all);
            // penalty_reset_mask[index] = wp.int32(selected)                                     <L 354>
            var_21 = wp::int32(var_19);
            wp::array_store(var_penalty_reset_mask, var_0, var_21);
            // if selected:                                                                       <L 355>
            if (var_19) {
                // sigma_prev[joint] = wp.vec3(0.0)                                               <L 357>
                var_23 = wp::vec_t<3, wp::float32>(var_22);
                wp::array_store(var_sigma_prev, var_16, var_23);
                // kappa_prev[joint] = wp.vec3(0.0)                                               <L 358>
                var_25 = wp::vec_t<3, wp::float32>(var_24);
                wp::array_store(var_kappa_prev, var_16, var_25);
                // dkappa_prev[joint] = wp.vec3(0.0)                                              <L 359>
                var_27 = wp::vec_t<3, wp::float32>(var_26);
                wp::array_store(var_dkappa_prev, var_16, var_27);
                // sigma_start[joint] = wp.vec3(0.0)                                              <L 360>
                var_29 = wp::vec_t<3, wp::float32>(var_28);
                wp::array_store(var_sigma_start, var_16, var_29);
                // friction_hessian[joint] = wp.vec3(0.0)                                         <L 361>
                var_31 = wp::vec_t<3, wp::float32>(var_30);
                wp::array_store(var_friction_hessian, var_16, var_31);
            }
        }
    }
}



extern "C" __global__ void _reset_cable_history_5042ded3_cuda_kernel_backward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<bool> var_world_mask,
    bool var_reset_all,
    wp::int32 var_world_count,
    wp::array_t<wp::int32> var_cable_joints,
    wp::array_t<wp::int32> var_joint_world,
    wp::array_t<bool> var_rebaseline_mask,
    wp::array_t<wp::vec_t<3, wp::float32>> var_sigma_prev,
    wp::array_t<wp::vec_t<3, wp::float32>> var_kappa_prev,
    wp::array_t<wp::vec_t<3, wp::float32>> var_dkappa_prev,
    wp::array_t<wp::vec_t<3, wp::float32>> var_sigma_start,
    wp::array_t<wp::vec_t<3, wp::float32>> var_friction_hessian,
    wp::array_t<wp::int32> var_penalty_reset_mask,
    wp::array_t<bool> adj_world_mask,
    bool adj_reset_all,
    wp::int32 adj_world_count,
    wp::array_t<wp::int32> adj_cable_joints,
    wp::array_t<wp::int32> adj_joint_world,
    wp::array_t<bool> adj_rebaseline_mask,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_sigma_prev,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_kappa_prev,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_dkappa_prev,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_sigma_start,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_friction_hessian,
    wp::array_t<wp::int32> adj_penalty_reset_mask)
{
    wp::tile_shared_storage_t tile_mem;

    for (size_t _idx = static_cast<size_t>(blockDim.x) * static_cast<size_t>(blockIdx.x) + static_cast<size_t>(threadIdx.x);
         _idx < dim.size;
         _idx += static_cast<size_t>(blockDim.x) * static_cast<size_t>(gridDim.x))
    {
            // reset shared memory allocator
        wp::tile_shared_storage_t::init();

        //---------
        // primal vars
        wp::int32 var_0;
        const wp::int32 var_1 = 1;
        wp::int32 var_2;
        bool var_3;
        wp::int32 var_4;
        bool var_5;
        const wp::int32 var_6 = -1;
        wp::int32 var_7;
        bool var_8;
        const bool var_9 = true;
        wp::shape_t* var_10;
        const wp::int32 var_11 = 0;
        wp::int32 var_12;
        wp::shape_t var_13;
        bool var_14;
        wp::int32* var_15;
        wp::int32 var_16;
        wp::int32 var_17;
        wp::int32* var_18;
        bool var_19;
        wp::int32 var_20;
        wp::int32 var_21;
        const wp::float32 var_22 = 0.0;
        wp::vec_t<3, wp::float32> var_23;
        const wp::float32 var_24 = 0.0;
        wp::vec_t<3, wp::float32> var_25;
        const wp::float32 var_26 = 0.0;
        wp::vec_t<3, wp::float32> var_27;
        const wp::float32 var_28 = 0.0;
        wp::vec_t<3, wp::float32> var_29;
        const wp::float32 var_30 = 0.0;
        wp::vec_t<3, wp::float32> var_31;
        //---------
        // dual vars
        wp::int32 adj_0 = {};
        wp::int32 adj_1 = {};
        wp::int32 adj_2 = {};
        bool adj_3 = {};
        wp::int32 adj_4 = {};
        bool adj_5 = {};
        wp::int32 adj_6 = {};
        wp::int32 adj_7 = {};
        bool adj_8 = {};
        bool adj_9 = {};
        wp::shape_t adj_10 = {};
        wp::int32 adj_11 = {};
        wp::int32 adj_12 = {};
        wp::shape_t adj_13 = {};
        bool adj_14 = {};
        wp::int32 adj_15 = {};
        wp::int32 adj_16 = {};
        wp::int32 adj_17 = {};
        wp::int32 adj_18 = {};
        bool adj_19 = {};
        wp::int32 adj_20 = {};
        wp::int32 adj_21 = {};
        wp::float32 adj_22 = {};
        wp::vec_t<3, wp::float32> adj_23 = {};
        wp::float32 adj_24 = {};
        wp::vec_t<3, wp::float32> adj_25 = {};
        wp::float32 adj_26 = {};
        wp::vec_t<3, wp::float32> adj_27 = {};
        wp::float32 adj_28 = {};
        wp::vec_t<3, wp::float32> adj_29 = {};
        wp::float32 adj_30 = {};
        wp::vec_t<3, wp::float32> adj_31 = {};
        //---------
        // forward
        // def _reset_cable_history(                                                              <L 330>
        // index = wp.tid()                                                                       <L 344>
        var_0 = builtin_tid1d();
        // if index < world_count + 1:                                                            <L 345>
        var_2 = wp::add(var_world_count, var_1);
        var_3 = (var_0 < var_2);
        if (var_3) {
            // world = index                                                                      <L 346>
            var_4 = wp::copy(var_0);
            // if index == world_count:                                                           <L 347>
            var_5 = (var_0 == var_world_count);
            if (var_5) {
                // world = -1                                                                     <L 348>
            }
            var_7 = wp::where(var_5, var_6, var_4);
            // if _reset_selected_world(world, world_mask, world_count, reset_all):               <L 349>
            var_8 = _reset_selected_world_0(var_7, var_world_mask, var_world_count, var_reset_all);
            if (var_8) {
                // rebaseline_mask[index] = True                                                  <L 350>
                // wp::array_store(var_rebaseline_mask, var_0, var_9);
            }
        }
        // if index < cable_joints.shape[0]:                                                      <L 351>
        var_10 = &(var_cable_joints.shape);
        var_13 = wp::load(var_10);
        var_12 = wp::extract(var_13, var_11);
        var_14 = (var_0 < var_12);
        if (var_14) {
            // joint = cable_joints[index]                                                        <L 352>
            var_15 = wp::address(var_cable_joints, var_0);
            var_17 = wp::load(var_15);
            var_16 = wp::copy(var_17);
            // selected = _reset_selected_world(joint_world[joint], world_mask, world_count, reset_all)       <L 353>
            var_18 = wp::address(var_joint_world, var_16);
            var_20 = wp::load(var_18);
            var_19 = _reset_selected_world_0(var_20, var_world_mask, var_world_count, var_reset_all);
            // penalty_reset_mask[index] = wp.int32(selected)                                     <L 354>
            var_21 = wp::int32(var_19);
            // wp::array_store(var_penalty_reset_mask, var_0, var_21);
            // if selected:                                                                       <L 355>
            if (var_19) {
                // sigma_prev[joint] = wp.vec3(0.0)                                               <L 357>
                var_23 = wp::vec_t<3, wp::float32>(var_22);
                // wp::array_store(var_sigma_prev, var_16, var_23);
                // kappa_prev[joint] = wp.vec3(0.0)                                               <L 358>
                var_25 = wp::vec_t<3, wp::float32>(var_24);
                // wp::array_store(var_kappa_prev, var_16, var_25);
                // dkappa_prev[joint] = wp.vec3(0.0)                                              <L 359>
                var_27 = wp::vec_t<3, wp::float32>(var_26);
                // wp::array_store(var_dkappa_prev, var_16, var_27);
                // sigma_start[joint] = wp.vec3(0.0)                                              <L 360>
                var_29 = wp::vec_t<3, wp::float32>(var_28);
                // wp::array_store(var_sigma_start, var_16, var_29);
                // friction_hessian[joint] = wp.vec3(0.0)                                         <L 361>
                var_31 = wp::vec_t<3, wp::float32>(var_30);
                // wp::array_store(var_friction_hessian, var_16, var_31);
            }
        }
        //---------
        // reverse
        if (var_14) {
            if (var_19) {
                wp::adj_array_store(var_friction_hessian, var_16, var_31, adj_friction_hessian, adj_16, adj_31);
                wp::adj_vec_t(var_30, adj_30, adj_31);
                // adj: friction_hessian[joint] = wp.vec3(0.0)                                    <L 361>
                wp::adj_array_store(var_sigma_start, var_16, var_29, adj_sigma_start, adj_16, adj_29);
                wp::adj_vec_t(var_28, adj_28, adj_29);
                // adj: sigma_start[joint] = wp.vec3(0.0)                                         <L 360>
                wp::adj_array_store(var_dkappa_prev, var_16, var_27, adj_dkappa_prev, adj_16, adj_27);
                wp::adj_vec_t(var_26, adj_26, adj_27);
                // adj: dkappa_prev[joint] = wp.vec3(0.0)                                         <L 359>
                wp::adj_array_store(var_kappa_prev, var_16, var_25, adj_kappa_prev, adj_16, adj_25);
                wp::adj_vec_t(var_24, adj_24, adj_25);
                // adj: kappa_prev[joint] = wp.vec3(0.0)                                          <L 358>
                wp::adj_array_store(var_sigma_prev, var_16, var_23, adj_sigma_prev, adj_16, adj_23);
                wp::adj_vec_t(var_22, adj_22, adj_23);
                // adj: sigma_prev[joint] = wp.vec3(0.0)                                          <L 357>
            }
            // adj: if selected:                                                                  <L 355>
            wp::adj_array_store(var_penalty_reset_mask, var_0, var_21, adj_penalty_reset_mask, adj_0, adj_21);
            // adj: penalty_reset_mask[index] = wp.int32(selected)                                <L 354>
            adj__reset_selected_world_0(var_20, var_world_mask, var_world_count, var_reset_all, adj_18, adj_world_mask, adj_world_count, adj_reset_all, adj_19);
            wp::adj_address(var_joint_world, var_16, adj_joint_world, adj_16, adj_18);
            // adj: selected = _reset_selected_world(joint_world[joint], world_mask, world_count, reset_all)  <L 353>
            wp::adj_copy(var_17, adj_15, adj_16);
            wp::adj_address(var_cable_joints, var_0, adj_cable_joints, adj_0, adj_15);
            // adj: joint = cable_joints[index]                                                   <L 352>
        }
        adj_cable_joints.shape = adj_10;
        // adj: if index < cable_joints.shape[0]:                                                 <L 351>
        if (var_3) {
            if (var_8) {
                wp::adj_array_store(var_rebaseline_mask, var_0, var_9, adj_rebaseline_mask, adj_0, adj_9);
                // adj: rebaseline_mask[index] = True                                             <L 350>
            }
            adj__reset_selected_world_0(var_7, var_world_mask, var_world_count, var_reset_all, adj_7, adj_world_mask, adj_world_count, adj_reset_all, adj_8);
            // adj: if _reset_selected_world(world, world_mask, world_count, reset_all):          <L 349>
            wp::adj_where(var_5, var_6, var_4, adj_5, adj_6, adj_4, adj_7);
            if (var_5) {
                // adj: world = -1                                                                <L 348>
            }
            // adj: if index == world_count:                                                      <L 347>
            wp::adj_copy(var_0, adj_0, adj_4);
            // adj: world = index                                                                 <L 346>
        }
        wp::adj_add(var_world_count, var_1, adj_world_count, adj_1, adj_2);
        // adj: if index < world_count + 1:                                                       <L 345>
        // adj: index = wp.tid()                                                                  <L 344>
        // adj: def _reset_cable_history(                                                         <L 330>
        continue;
    }
}

