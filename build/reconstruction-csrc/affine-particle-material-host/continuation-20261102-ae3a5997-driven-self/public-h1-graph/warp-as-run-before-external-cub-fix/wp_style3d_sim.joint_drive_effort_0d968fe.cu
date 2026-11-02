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


// /home/oem/code/agent/style3d-sim/src/style3d_sim/joint_drive_effort.py:9
static CUDA_CALLABLE wp::vec_t<3, wp::float32> _point_velocity_0(
    wp::transform_t<wp::float32> var_pose,
    wp::vec_t<6, wp::float32> var_twist,
    wp::vec_t<3, wp::float32> var_center,
    wp::vec_t<3, wp::float32> var_point)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    wp::vec_t<3, wp::float32> var_1;
    wp::vec_t<3, wp::float32> var_2;
    wp::vec_t<3, wp::float32> var_3;
    wp::vec_t<3, wp::float32> var_4;
    wp::vec_t<3, wp::float32> var_5;
    //---------
    // forward
    // def _point_velocity(pose: wp.transform, twist: wp.spatial_vector, center: wp.vec3, point: wp.vec3):       <L 10>
    // world_center = wp.transform_point(pose, center)                                        <L 11>
    var_0 = wp::transform_point(var_pose, var_center);
    // return wp.spatial_top(twist) + wp.cross(wp.spatial_bottom(twist), point - world_center)       <L 12>
    var_1 = wp::spatial_top(var_twist);
    var_2 = wp::spatial_bottom(var_twist);
    var_3 = wp::sub(var_point, var_0);
    var_4 = wp::cross(var_2, var_3);
    var_5 = wp::add(var_1, var_4);
    return var_5;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/joint_drive_effort.py:15
static CUDA_CALLABLE wp::float32 _unwrap_near_0(
    wp::float32 var_value,
    wp::float32 var_reference)
{
    //---------
    // primal vars
    wp::float32 var_0;
    const wp::float32 var_1 = 2.0;
    const wp::float32 var_2 = 3.141592653589793;
    wp::float32 var_3;
    wp::float32 var_4;
    wp::float32 var_5;
    wp::float32 var_6;
    const wp::float32 var_7 = 0.5;
    wp::float32 var_8;
    wp::float32 var_9;
    wp::float32 var_10;
    const wp::float32 var_11 = 2.0;
    const wp::float32 var_12 = 3.141592653589793;
    wp::float32 var_13;
    wp::float32 var_14;
    wp::float32 var_15;
    //---------
    // forward
    // def _unwrap_near(value: float, reference: float):                                      <L 16>
    // turns = (reference - value) / (2.0 * wp.pi)                                            <L 18>
    var_0 = wp::sub(var_reference, var_value);
    var_3 = wp::mul(var_1, var_2);
    var_4 = wp::div(var_0, var_3);
    // nearest_turn = wp.sign(turns) * wp.floor(wp.abs(turns) + 0.5)                          <L 19>
    var_5 = wp::sign(var_4);
    var_6 = wp::abs(var_4);
    var_8 = wp::add(var_6, var_7);
    var_9 = wp::floor(var_8);
    var_10 = wp::mul(var_5, var_9);
    // return value + (2.0 * wp.pi) * nearest_turn                                            <L 20>
    var_13 = wp::mul(var_11, var_12);
    var_14 = wp::mul(var_13, var_10);
    var_15 = wp::add(var_value, var_14);
    return var_15;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/joint_drive_effort.py:9
static CUDA_CALLABLE void adj__point_velocity_0(
    wp::transform_t<wp::float32> var_pose,
    wp::vec_t<6, wp::float32> var_twist,
    wp::vec_t<3, wp::float32> var_center,
    wp::vec_t<3, wp::float32> var_point,
    wp::transform_t<wp::float32> & adj_pose,
    wp::vec_t<6, wp::float32> & adj_twist,
    wp::vec_t<3, wp::float32> & adj_center,
    wp::vec_t<3, wp::float32> & adj_point,
    wp::vec_t<3, wp::float32> & adj_ret)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    wp::vec_t<3, wp::float32> var_1;
    wp::vec_t<3, wp::float32> var_2;
    wp::vec_t<3, wp::float32> var_3;
    wp::vec_t<3, wp::float32> var_4;
    wp::vec_t<3, wp::float32> var_5;
    //---------
    // dual vars
    wp::vec_t<3, wp::float32> adj_0 = {};
    wp::vec_t<3, wp::float32> adj_1 = {};
    wp::vec_t<3, wp::float32> adj_2 = {};
    wp::vec_t<3, wp::float32> adj_3 = {};
    wp::vec_t<3, wp::float32> adj_4 = {};
    wp::vec_t<3, wp::float32> adj_5 = {};
    //---------
    // forward
    // def _point_velocity(pose: wp.transform, twist: wp.spatial_vector, center: wp.vec3, point: wp.vec3):       <L 10>
    // world_center = wp.transform_point(pose, center)                                        <L 11>
    var_0 = wp::transform_point(var_pose, var_center);
    // return wp.spatial_top(twist) + wp.cross(wp.spatial_bottom(twist), point - world_center)       <L 12>
    var_1 = wp::spatial_top(var_twist);
    var_2 = wp::spatial_bottom(var_twist);
    var_3 = wp::sub(var_point, var_0);
    var_4 = wp::cross(var_2, var_3);
    var_5 = wp::add(var_1, var_4);
    goto label0;
    //---------
    // reverse
    label0:;
    adj_5 += adj_ret;
    wp::adj_add(var_1, var_4, adj_1, adj_4, adj_5);
    wp::adj_cross(var_2, var_3, adj_2, adj_3, adj_4);
    wp::adj_sub(var_point, var_0, adj_point, adj_0, adj_3);
    wp::adj_spatial_bottom(var_twist, adj_twist, adj_2);
    wp::adj_spatial_top(var_twist, adj_twist, adj_1);
    // adj: return wp.spatial_top(twist) + wp.cross(wp.spatial_bottom(twist), point - world_center)  <L 12>
    wp::adj_transform_point(var_pose, var_center, adj_pose, adj_center, adj_0);
    // adj: world_center = wp.transform_point(pose, center)                                   <L 11>
    // adj: def _point_velocity(pose: wp.transform, twist: wp.spatial_vector, center: wp.vec3, point: wp.vec3):  <L 10>
    return;
}


// /home/oem/code/agent/style3d-sim/src/style3d_sim/joint_drive_effort.py:15
static CUDA_CALLABLE void adj__unwrap_near_0(
    wp::float32 var_value,
    wp::float32 var_reference,
    wp::float32 & adj_value,
    wp::float32 & adj_reference,
    wp::float32 & adj_ret)
{
    //---------
    // primal vars
    wp::float32 var_0;
    const wp::float32 var_1 = 2.0;
    const wp::float32 var_2 = 3.141592653589793;
    wp::float32 var_3;
    wp::float32 var_4;
    wp::float32 var_5;
    wp::float32 var_6;
    const wp::float32 var_7 = 0.5;
    wp::float32 var_8;
    wp::float32 var_9;
    wp::float32 var_10;
    const wp::float32 var_11 = 2.0;
    const wp::float32 var_12 = 3.141592653589793;
    wp::float32 var_13;
    wp::float32 var_14;
    wp::float32 var_15;
    //---------
    // dual vars
    wp::float32 adj_0 = {};
    wp::float32 adj_1 = {};
    wp::float32 adj_2 = {};
    wp::float32 adj_3 = {};
    wp::float32 adj_4 = {};
    wp::float32 adj_5 = {};
    wp::float32 adj_6 = {};
    wp::float32 adj_7 = {};
    wp::float32 adj_8 = {};
    wp::float32 adj_9 = {};
    wp::float32 adj_10 = {};
    wp::float32 adj_11 = {};
    wp::float32 adj_12 = {};
    wp::float32 adj_13 = {};
    wp::float32 adj_14 = {};
    wp::float32 adj_15 = {};
    //---------
    // forward
    // def _unwrap_near(value: float, reference: float):                                      <L 16>
    // turns = (reference - value) / (2.0 * wp.pi)                                            <L 18>
    var_0 = wp::sub(var_reference, var_value);
    var_3 = wp::mul(var_1, var_2);
    var_4 = wp::div(var_0, var_3);
    // nearest_turn = wp.sign(turns) * wp.floor(wp.abs(turns) + 0.5)                          <L 19>
    var_5 = wp::sign(var_4);
    var_6 = wp::abs(var_4);
    var_8 = wp::add(var_6, var_7);
    var_9 = wp::floor(var_8);
    var_10 = wp::mul(var_5, var_9);
    // return value + (2.0 * wp.pi) * nearest_turn                                            <L 20>
    var_13 = wp::mul(var_11, var_12);
    var_14 = wp::mul(var_13, var_10);
    var_15 = wp::add(var_value, var_14);
    goto label0;
    //---------
    // reverse
    label0:;
    adj_15 += adj_ret;
    wp::adj_add(var_value, var_14, adj_value, adj_14, adj_15);
    wp::adj_mul(var_13, var_10, adj_13, adj_10, adj_14);
    wp::adj_mul(var_11, var_12, adj_11, adj_12, adj_13);
    // adj: return value + (2.0 * wp.pi) * nearest_turn                                       <L 20>
    wp::adj_mul(var_5, var_9, adj_5, adj_9, adj_10);
    wp::adj_add(var_6, var_7, adj_6, adj_7, adj_8);
    wp::adj_abs(var_4, adj_4, adj_6);
    // adj: nearest_turn = wp.sign(turns) * wp.floor(wp.abs(turns) + 0.5)                     <L 19>
    wp::adj_div(var_0, var_3, var_4, adj_0, adj_3, adj_4);
    wp::adj_mul(var_1, var_2, adj_1, adj_2, adj_3);
    wp::adj_sub(var_reference, var_value, adj_reference, adj_value, adj_0);
    // adj: turns = (reference - value) / (2.0 * wp.pi)                                       <L 18>
    // adj: def _unwrap_near(value: float, reference: float):                                 <L 16>
    return;
}



extern "C" __global__ void evaluate_joint_drive_effort_affc34ce_cuda_kernel_forward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::transform_t<wp::float32>> var_body_q,
    wp::array_t<wp::transform_t<wp::float32>> var_previous_body_q,
    wp::array_t<wp::float32> var_previous_angles,
    wp::array_t<wp::int32> var_angle_initialized,
    wp::array_t<wp::vec_t<6, wp::float32>> var_body_qd,
    wp::array_t<wp::vec_t<3, wp::float32>> var_body_com,
    wp::array_t<wp::int32> var_affine_body_ids,
    wp::array_t<wp::int32> var_drive_types,
    wp::array_t<wp::vec_t<2, wp::int32>> var_drive_bodies,
    wp::array_t<wp::vec_t<3, wp::float32>> var_parent_origins,
    wp::array_t<wp::vec_t<3, wp::float32>> var_child_origins,
    wp::array_t<wp::vec_t<3, wp::float32>> var_parent_axis_points,
    wp::array_t<wp::vec_t<3, wp::float32>> var_parent_references,
    wp::array_t<wp::vec_t<3, wp::float32>> var_child_references,
    wp::array_t<wp::int32> var_dof_indices,
    wp::array_t<wp::int32> var_target_indices,
    wp::array_t<wp::float32> var_stiffness,
    wp::array_t<wp::float32> var_damping,
    wp::array_t<wp::int32> var_target_modes,
    wp::array_t<wp::float32> var_effort_limits,
    wp::array_t<wp::float32> var_feedforward,
    wp::array_t<wp::float32> var_target_q,
    wp::array_t<wp::float32> var_target_qd,
    wp::int32 var_use_previous_pose,
    wp::int32 var_advance_angle_state,
    wp::array_t<wp::float32> var_effort,
    wp::array_t<wp::float32> var_coordinate_velocity)
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
        wp::int32 var_7;
        wp::int32 var_8;
        wp::transform_t<wp::float32>* var_9;
        wp::transform_t<wp::float32> var_10;
        wp::transform_t<wp::float32> var_11;
        wp::vec_t<6, wp::float32>* var_12;
        wp::vec_t<6, wp::float32> var_13;
        wp::vec_t<6, wp::float32> var_14;
        wp::vec_t<3, wp::float32>* var_15;
        wp::vec_t<3, wp::float32> var_16;
        wp::vec_t<3, wp::float32> var_17;
        wp::vec_t<3, wp::float32>* var_18;
        wp::vec_t<3, wp::float32> var_19;
        wp::vec_t<3, wp::float32> var_20;
        wp::vec_t<3, wp::float32>* var_21;
        wp::vec_t<3, wp::float32> var_22;
        wp::vec_t<3, wp::float32> var_23;
        wp::vec_t<3, wp::float32>* var_24;
        wp::vec_t<3, wp::float32> var_25;
        wp::vec_t<3, wp::float32> var_26;
        wp::vec_t<3, wp::float32>* var_27;
        wp::vec_t<3, wp::float32> var_28;
        wp::vec_t<3, wp::float32> var_29;
        wp::vec_t<3, wp::float32>* var_30;
        wp::vec_t<3, wp::float32> var_31;
        wp::vec_t<3, wp::float32> var_32;
        const wp::float32 var_33 = 0.0;
        wp::vec_t<3, wp::float32> var_34;
        const wp::float32 var_35 = 0.0;
        wp::vec_t<3, wp::float32> var_36;
        const wp::int32 var_37 = 0;
        wp::int32 var_38;
        const wp::int32 var_39 = 0;
        bool var_40;
        const wp::int32 var_41 = 0;
        wp::int32 var_42;
        wp::int32* var_43;
        wp::int32 var_44;
        wp::int32 var_45;
        wp::transform_t<wp::float32>* var_46;
        wp::transform_t<wp::float32> var_47;
        wp::transform_t<wp::float32> var_48;
        wp::vec_t<6, wp::float32>* var_49;
        wp::vec_t<6, wp::float32> var_50;
        wp::vec_t<6, wp::float32> var_51;
        wp::vec_t<3, wp::float32> var_52;
        wp::vec_t<3, wp::float32> var_53;
        wp::vec_t<3, wp::float32> var_54;
        wp::vec_t<3, wp::float32>* var_55;
        wp::vec_t<3, wp::float32> var_56;
        wp::vec_t<3, wp::float32> var_57;
        wp::vec_t<3, wp::float32> var_58;
        wp::vec_t<3, wp::float32> var_59;
        wp::vec_t<3, wp::float32> var_60;
        wp::vec_t<3, wp::float32> var_61;
        wp::vec_t<3, wp::float32> var_62;
        wp::vec_t<3, wp::float32> var_63;
        wp::vec_t<3, wp::float32> var_64;
        wp::float32 var_65;
        const wp::float32 var_66 = 1e-08;
        bool var_67;
        wp::vec_t<3, wp::float32> var_68;
        wp::vec_t<3, wp::float32> var_69;
        wp::float32 var_70;
        wp::vec_t<3, wp::float32> var_71;
        wp::float32 var_72;
        wp::vec_t<3, wp::float32> var_73;
        wp::float32 var_74;
        wp::float32 var_75;
        wp::int32* var_76;
        wp::int32 var_77;
        wp::int32 var_78;
        wp::int32* var_79;
        const wp::int32 var_80 = 1;
        bool var_81;
        wp::int32 var_82;
        wp::vec_t<3, wp::float32> var_83;
        wp::vec_t<3, wp::float32> var_84;
        wp::float32 var_85;
        wp::vec_t<3, wp::float32> var_86;
        wp::vec_t<3, wp::float32> var_87;
        wp::float32 var_88;
        wp::vec_t<3, wp::float32> var_89;
        wp::vec_t<3, wp::float32> var_90;
        bool var_91;
        wp::float32 var_92;
        const wp::float32 var_93 = 1e-08;
        bool var_94;
        wp::float32 var_95;
        const wp::float32 var_96 = 1e-08;
        bool var_97;
        wp::vec_t<3, wp::float32> var_98;
        wp::float32 var_99;
        wp::float32 var_100;
        wp::float32 var_101;
        wp::int32* var_102;
        const wp::int32 var_103 = 0;
        bool var_104;
        wp::int32 var_105;
        wp::float32* var_106;
        wp::float32 var_107;
        wp::float32 var_108;
        const wp::int32 var_109 = 0;
        bool var_110;
        wp::transform_t<wp::float32>* var_111;
        wp::transform_t<wp::float32> var_112;
        wp::transform_t<wp::float32> var_113;
        wp::vec_t<3, wp::float32>* var_114;
        wp::vec_t<3, wp::float32>* var_115;
        wp::vec_t<3, wp::float32> var_116;
        wp::vec_t<3, wp::float32> var_117;
        wp::vec_t<3, wp::float32> var_118;
        wp::vec_t<3, wp::float32> var_119;
        wp::vec_t<3, wp::float32>* var_120;
        wp::vec_t<3, wp::float32>* var_121;
        wp::vec_t<3, wp::float32> var_122;
        wp::vec_t<3, wp::float32> var_123;
        wp::vec_t<3, wp::float32> var_124;
        wp::vec_t<3, wp::float32>* var_125;
        wp::vec_t<3, wp::float32>* var_126;
        wp::vec_t<3, wp::float32> var_127;
        wp::vec_t<3, wp::float32> var_128;
        wp::vec_t<3, wp::float32> var_129;
        const wp::int32 var_130 = 0;
        wp::int32 var_131;
        const wp::int32 var_132 = 0;
        bool var_133;
        const wp::int32 var_134 = 0;
        wp::int32 var_135;
        wp::int32* var_136;
        wp::transform_t<wp::float32>* var_137;
        wp::int32 var_138;
        wp::transform_t<wp::float32> var_139;
        wp::transform_t<wp::float32> var_140;
        wp::vec_t<3, wp::float32> var_141;
        wp::vec_t<3, wp::float32> var_142;
        wp::vec_t<3, wp::float32> var_143;
        wp::vec_t<3, wp::float32> var_144;
        wp::vec_t<3, wp::float32> var_145;
        wp::float32 var_146;
        wp::vec_t<3, wp::float32> var_147;
        wp::vec_t<3, wp::float32> var_148;
        wp::float32 var_149;
        wp::vec_t<3, wp::float32> var_150;
        wp::vec_t<3, wp::float32> var_151;
        wp::vec_t<3, wp::float32> var_152;
        wp::float32 var_153;
        wp::float32 var_154;
        wp::float32 var_155;
        wp::float32 var_156;
        wp::float32 var_157;
        wp::float32 var_158;
        const wp::int32 var_159 = 0;
        bool var_160;
        const wp::int32 var_161 = 1;
        wp::vec_t<3, wp::float32> var_162;
        wp::vec_t<3, wp::float32> var_163;
        wp::float32 var_164;
        wp::float32 var_165;
        wp::float32 var_166;
        wp::int32* var_167;
        wp::int32 var_168;
        wp::int32 var_169;
        const wp::float32 var_170 = 0.0;
        wp::float32 var_171;
        bool var_172;
        const wp::int32 var_173 = 1;
        bool var_174;
        const wp::int32 var_175 = 3;
        bool var_176;
        wp::float32* var_177;
        wp::int32* var_178;
        wp::float32* var_179;
        wp::int32 var_180;
        wp::float32 var_181;
        wp::float32 var_182;
        wp::float32 var_183;
        wp::float32 var_184;
        wp::float32 var_185;
        const wp::int32 var_186 = 1;
        bool var_187;
        wp::float32* var_188;
        wp::float32 var_189;
        wp::float32 var_190;
        wp::float32 var_191;
        bool var_192;
        const wp::int32 var_193 = 2;
        bool var_194;
        const wp::int32 var_195 = 3;
        bool var_196;
        wp::float32* var_197;
        wp::float32* var_198;
        wp::float32 var_199;
        wp::float32 var_200;
        wp::float32 var_201;
        wp::float32 var_202;
        wp::float32 var_203;
        wp::float32 var_204;
        wp::float32 var_205;
        wp::float32* var_206;
        wp::float32 var_207;
        wp::float32 var_208;
        wp::float32 var_209;
        wp::float32 var_210;
        wp::float32* var_211;
        wp::float32 var_212;
        wp::float32 var_213;
        wp::float32 var_214;
        //---------
        // forward
        // def evaluate_joint_drive_effort(                                                       <L 24>
        // drive = wp.tid()                                                                       <L 53>
        var_0 = builtin_tid1d();
        // bodies = drive_bodies[drive]                                                           <L 54>
        var_1 = wp::address(var_drive_bodies, var_0);
        var_3 = wp::load(var_1);
        var_2 = wp::copy(var_3);
        // child = affine_body_ids[bodies[1]]                                                     <L 55>
        var_5 = wp::extract(var_2, var_4);
        var_6 = wp::address(var_affine_body_ids, var_5);
        var_8 = wp::load(var_6);
        var_7 = wp::copy(var_8);
        // child_pose = body_q[child]                                                             <L 56>
        var_9 = wp::address(var_body_q, var_7);
        var_11 = wp::load(var_9);
        var_10 = wp::copy(var_11);
        // child_twist = body_qd[child]                                                           <L 57>
        var_12 = wp::address(var_body_qd, var_7);
        var_14 = wp::load(var_12);
        var_13 = wp::copy(var_14);
        // child_origin = wp.transform_point(child_pose, child_origins[drive])                    <L 58>
        var_15 = wp::address(var_child_origins, var_0);
        var_17 = wp::load(var_15);
        var_16 = wp::transform_point(var_10, var_17);
        // child_reference = wp.transform_point(child_pose, child_references[drive])              <L 59>
        var_18 = wp::address(var_child_references, var_0);
        var_20 = wp::load(var_18);
        var_19 = wp::transform_point(var_10, var_20);
        // child_velocity = _point_velocity(child_pose, child_twist, body_com[child], child_origin)       <L 60>
        var_21 = wp::address(var_body_com, var_7);
        var_23 = wp::load(var_21);
        var_22 = _point_velocity_0(var_10, var_13, var_23, var_16);
        // parent_origin = parent_origins[drive]                                                  <L 62>
        var_24 = wp::address(var_parent_origins, var_0);
        var_26 = wp::load(var_24);
        var_25 = wp::copy(var_26);
        // parent_axis_point = parent_axis_points[drive]                                          <L 63>
        var_27 = wp::address(var_parent_axis_points, var_0);
        var_29 = wp::load(var_27);
        var_28 = wp::copy(var_29);
        // parent_reference = parent_references[drive]                                            <L 64>
        var_30 = wp::address(var_parent_references, var_0);
        var_32 = wp::load(var_30);
        var_31 = wp::copy(var_32);
        // parent_velocity = wp.vec3(0.0)                                                         <L 65>
        var_34 = wp::vec_t<3, wp::float32>(var_33);
        // parent_omega = wp.vec3(0.0)                                                            <L 66>
        var_36 = wp::vec_t<3, wp::float32>(var_35);
        // if bodies[0] >= 0:                                                                     <L 67>
        var_38 = wp::extract(var_2, var_37);
        var_40 = (var_38 >= var_39);
        if (var_40) {
            // parent = affine_body_ids[bodies[0]]                                                <L 68>
            var_42 = wp::extract(var_2, var_41);
            var_43 = wp::address(var_affine_body_ids, var_42);
            var_45 = wp::load(var_43);
            var_44 = wp::copy(var_45);
            // parent_pose = body_q[parent]                                                       <L 69>
            var_46 = wp::address(var_body_q, var_44);
            var_48 = wp::load(var_46);
            var_47 = wp::copy(var_48);
            // parent_twist = body_qd[parent]                                                     <L 70>
            var_49 = wp::address(var_body_qd, var_44);
            var_51 = wp::load(var_49);
            var_50 = wp::copy(var_51);
            // parent_origin = wp.transform_point(parent_pose, parent_origin)                     <L 71>
            var_52 = wp::transform_point(var_47, var_25);
            // parent_axis_point = wp.transform_point(parent_pose, parent_axis_point)             <L 72>
            var_53 = wp::transform_point(var_47, var_28);
            // parent_reference = wp.transform_point(parent_pose, parent_reference)               <L 73>
            var_54 = wp::transform_point(var_47, var_31);
            // parent_velocity = _point_velocity(parent_pose, parent_twist, body_com[parent], parent_origin)       <L 74>
            var_55 = wp::address(var_body_com, var_44);
            var_57 = wp::load(var_55);
            var_56 = _point_velocity_0(var_47, var_50, var_57, var_52);
            // parent_omega = wp.spatial_bottom(parent_twist)                                     <L 75>
            var_58 = wp::spatial_bottom(var_50);
        }
        var_59 = wp::where(var_40, var_52, var_25);
        var_60 = wp::where(var_40, var_53, var_28);
        var_61 = wp::where(var_40, var_54, var_31);
        var_62 = wp::where(var_40, var_56, var_34);
        var_63 = wp::where(var_40, var_58, var_36);
        // axis_vector = parent_axis_point - parent_origin                                        <L 77>
        var_64 = wp::sub(var_60, var_59);
        // axis_length = wp.length(axis_vector)                                                   <L 78>
        var_65 = wp::length(var_64);
        // if axis_length <= 1.0e-8:                                                              <L 79>
        var_67 = (var_65 <= var_66);
        if (var_67) {
            // return                                                                             <L 80>
            continue;
        }
        // axis = axis_vector / axis_length                                                       <L 81>
        var_68 = wp::div(var_64, var_65);
        // displacement = child_origin - parent_origin                                            <L 82>
        var_69 = wp::sub(var_16, var_59);
        // q = wp.dot(displacement, axis)                                                         <L 83>
        var_70 = wp::dot(var_69, var_68);
        // qd = wp.dot(child_velocity - parent_velocity, axis) + wp.dot(displacement, wp.cross(parent_omega, axis))       <L 84>
        var_71 = wp::sub(var_22, var_62);
        var_72 = wp::dot(var_71, var_68);
        var_73 = wp::cross(var_63, var_68);
        var_74 = wp::dot(var_69, var_73);
        var_75 = wp::add(var_72, var_74);
        // dof = dof_indices[drive]                                                               <L 85>
        var_76 = wp::address(var_dof_indices, var_0);
        var_78 = wp::load(var_76);
        var_77 = wp::copy(var_78);
        // if drive_types[drive] == 1:                                                            <L 86>
        var_79 = wp::address(var_drive_types, var_0);
        var_82 = wp::load(var_79);
        var_81 = (var_82 == var_80);
        if (var_81) {
            // parent_arm = parent_reference - parent_origin                                      <L 87>
            var_83 = wp::sub(var_61, var_59);
            // child_arm = child_reference - child_origin                                         <L 88>
            var_84 = wp::sub(var_19, var_16);
            // parent_arm = parent_arm - wp.dot(parent_arm, axis) * axis                          <L 89>
            var_85 = wp::dot(var_83, var_68);
            var_86 = wp::mul(var_85, var_68);
            var_87 = wp::sub(var_83, var_86);
            // child_arm = child_arm - wp.dot(child_arm, axis) * axis                             <L 90>
            var_88 = wp::dot(var_84, var_68);
            var_89 = wp::mul(var_88, var_68);
            var_90 = wp::sub(var_84, var_89);
            // if wp.length(parent_arm) <= 1.0e-8 or wp.length(child_arm) <= 1.0e-8:              <L 91>
            var_92 = wp::length(var_87);
            var_94 = (var_92 <= var_93);
            var_91 = var_94;
            if (!var_91) {
                var_95 = wp::length(var_90);
                var_97 = (var_95 <= var_96);
                var_91 = var_91 || var_97;
            }
            if (var_91) {
                // return                                                                         <L 92>
                continue;
            }
            // q = wp.atan2(wp.dot(axis, wp.cross(parent_arm, child_arm)), wp.dot(parent_arm, child_arm))       <L 93>
            var_98 = wp::cross(var_87, var_90);
            var_99 = wp::dot(var_68, var_98);
            var_100 = wp::dot(var_87, var_90);
            var_101 = wp::atan2(var_99, var_100);
            // if angle_initialized[drive] != 0:                                                  <L 95>
            var_102 = wp::address(var_angle_initialized, var_0);
            var_105 = wp::load(var_102);
            var_104 = (var_105 != var_103);
            if (var_104) {
                // q = _unwrap_near(q, previous_angles[drive])                                    <L 96>
                var_106 = wp::address(var_previous_angles, var_0);
                var_108 = wp::load(var_106);
                var_107 = _unwrap_near_0(var_101, var_108);
            }
            if (!var_104) {
                // elif use_previous_pose != 0:                                                   <L 97>
                var_110 = (var_use_previous_pose != var_109);
                if (var_110) {
                    // previous_child_pose = previous_body_q[child]                               <L 100>
                    var_111 = wp::address(var_previous_body_q, var_7);
                    var_113 = wp::load(var_111);
                    var_112 = wp::copy(var_113);
                    // previous_child_arm = wp.transform_vector(                                  <L 101>
                    // previous_child_pose, child_references[drive] - child_origins[drive]        <L 102>
                    var_114 = wp::address(var_child_references, var_0);
                    var_115 = wp::address(var_child_origins, var_0);
                    var_117 = wp::load(var_114);
                    var_118 = wp::load(var_115);
                    var_116 = wp::sub(var_117, var_118);
                    var_119 = wp::transform_vector(var_112, var_116);
                    // previous_parent_arm = parent_references[drive] - parent_origins[drive]       <L 104>
                    var_120 = wp::address(var_parent_references, var_0);
                    var_121 = wp::address(var_parent_origins, var_0);
                    var_123 = wp::load(var_120);
                    var_124 = wp::load(var_121);
                    var_122 = wp::sub(var_123, var_124);
                    // previous_axis = parent_axis_points[drive] - parent_origins[drive]          <L 105>
                    var_125 = wp::address(var_parent_axis_points, var_0);
                    var_126 = wp::address(var_parent_origins, var_0);
                    var_128 = wp::load(var_125);
                    var_129 = wp::load(var_126);
                    var_127 = wp::sub(var_128, var_129);
                    // if bodies[0] >= 0:                                                         <L 106>
                    var_131 = wp::extract(var_2, var_130);
                    var_133 = (var_131 >= var_132);
                    if (var_133) {
                        // previous_parent_pose = previous_body_q[affine_body_ids[bodies[0]]]       <L 107>
                        var_135 = wp::extract(var_2, var_134);
                        var_136 = wp::address(var_affine_body_ids, var_135);
                        var_138 = wp::load(var_136);
                        var_137 = wp::address(var_previous_body_q, var_138);
                        var_140 = wp::load(var_137);
                        var_139 = wp::copy(var_140);
                        // previous_parent_arm = wp.transform_vector(previous_parent_pose, previous_parent_arm)       <L 108>
                        var_141 = wp::transform_vector(var_139, var_122);
                        // previous_axis = wp.transform_vector(previous_parent_pose, previous_axis)       <L 109>
                        var_142 = wp::transform_vector(var_139, var_127);
                    }
                    var_143 = wp::where(var_133, var_141, var_122);
                    var_144 = wp::where(var_133, var_142, var_127);
                    // previous_axis = wp.normalize(previous_axis)                                <L 110>
                    var_145 = wp::normalize(var_144);
                    // previous_parent_arm -= wp.dot(previous_parent_arm, previous_axis) * previous_axis       <L 111>
                    var_146 = wp::dot(var_143, var_145);
                    var_147 = wp::mul(var_146, var_145);
                    var_148 = wp::sub(var_143, var_147);
                    // previous_child_arm -= wp.dot(previous_child_arm, previous_axis) * previous_axis       <L 112>
                    var_149 = wp::dot(var_119, var_145);
                    var_150 = wp::mul(var_149, var_145);
                    var_151 = wp::sub(var_119, var_150);
                    // previous_q = wp.atan2(                                                     <L 113>
                    // wp.dot(previous_axis, wp.cross(previous_parent_arm, previous_child_arm)),       <L 114>
                    var_152 = wp::cross(var_148, var_151);
                    var_153 = wp::dot(var_145, var_152);
                    // wp.dot(previous_parent_arm, previous_child_arm),                           <L 115>
                    var_154 = wp::dot(var_148, var_151);
                    var_155 = wp::atan2(var_153, var_154);
                    // q = _unwrap_near(q, previous_q)                                            <L 117>
                    var_156 = _unwrap_near_0(var_101, var_155);
                }
                var_157 = wp::where(var_110, var_156, var_101);
            }
            var_158 = wp::where(var_104, var_107, var_157);
            // if advance_angle_state != 0:                                                       <L 118>
            var_160 = (var_advance_angle_state != var_159);
            if (var_160) {
                // previous_angles[drive] = q                                                     <L 119>
                wp::array_store(var_previous_angles, var_0, var_158);
                // angle_initialized[drive] = 1                                                   <L 120>
                wp::array_store(var_angle_initialized, var_0, var_161);
            }
            // qd = wp.dot(wp.spatial_bottom(child_twist) - parent_omega, axis)                   <L 121>
            var_162 = wp::spatial_bottom(var_13);
            var_163 = wp::sub(var_162, var_63);
            var_164 = wp::dot(var_163, var_68);
        }
        var_165 = wp::where(var_81, var_158, var_70);
        var_166 = wp::where(var_81, var_164, var_75);
        // mode = target_modes[dof]                                                               <L 123>
        var_167 = wp::address(var_target_modes, var_77);
        var_169 = wp::load(var_167);
        var_168 = wp::copy(var_169);
        // actuator = wp.float32(0.0)                                                             <L 124>
        var_171 = wp::float32(var_170);
        // if mode == 1 or mode == 3:                                                             <L 125>
        var_174 = (var_168 == var_173);
        var_172 = var_174;
        if (!var_172) {
            var_176 = (var_168 == var_175);
            var_172 = var_172 || var_176;
        }
        if (var_172) {
            // actuator = stiffness[dof] * (target_q[target_indices[drive]] - q)                  <L 126>
            var_177 = wp::address(var_stiffness, var_77);
            var_178 = wp::address(var_target_indices, var_0);
            var_180 = wp::load(var_178);
            var_179 = wp::address(var_target_q, var_180);
            var_182 = wp::load(var_179);
            var_181 = wp::sub(var_182, var_165);
            var_184 = wp::load(var_177);
            var_183 = wp::mul(var_184, var_181);
        }
        var_185 = wp::where(var_172, var_183, var_171);
        // if mode == 1:                                                                          <L 127>
        var_187 = (var_168 == var_186);
        if (var_187) {
            // actuator -= damping[dof] * qd                                                      <L 128>
            var_188 = wp::address(var_damping, var_77);
            var_190 = wp::load(var_188);
            var_189 = wp::mul(var_190, var_166);
            var_191 = wp::sub(var_185, var_189);
        }
        if (!var_187) {
            // elif mode == 2 or mode == 3:                                                       <L 129>
            var_194 = (var_168 == var_193);
            var_192 = var_194;
            if (!var_192) {
                var_196 = (var_168 == var_195);
                var_192 = var_192 || var_196;
            }
            if (var_192) {
                // actuator += damping[dof] * (target_qd[dof] - qd)                               <L 130>
                var_197 = wp::address(var_damping, var_77);
                var_198 = wp::address(var_target_qd, var_77);
                var_200 = wp::load(var_198);
                var_199 = wp::sub(var_200, var_166);
                var_202 = wp::load(var_197);
                var_201 = wp::mul(var_202, var_199);
                var_203 = wp::add(var_185, var_201);
            }
            var_204 = wp::where(var_192, var_203, var_185);
        }
        var_205 = wp::where(var_187, var_191, var_204);
        // limit = effort_limits[dof]                                                             <L 133>
        var_206 = wp::address(var_effort_limits, var_77);
        var_208 = wp::load(var_206);
        var_207 = wp::copy(var_208);
        // actuator = wp.clamp(actuator, -limit, limit)                                           <L 134>
        var_209 = wp::neg(var_207);
        var_210 = wp::clamp(var_205, var_209, var_207);
        // wp.atomic_add(effort, dof, feedforward[dof] + actuator)                                <L 135>
        var_211 = wp::address(var_feedforward, var_77);
        var_213 = wp::load(var_211);
        var_212 = wp::add(var_213, var_210);
        var_214 = wp::atomic_add(var_effort, var_77, var_212);
        // coordinate_velocity[drive] = qd                                                        <L 136>
        wp::array_store(var_coordinate_velocity, var_0, var_166);
    }
}



extern "C" __global__ void evaluate_joint_drive_effort_affc34ce_cuda_kernel_backward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::transform_t<wp::float32>> var_body_q,
    wp::array_t<wp::transform_t<wp::float32>> var_previous_body_q,
    wp::array_t<wp::float32> var_previous_angles,
    wp::array_t<wp::int32> var_angle_initialized,
    wp::array_t<wp::vec_t<6, wp::float32>> var_body_qd,
    wp::array_t<wp::vec_t<3, wp::float32>> var_body_com,
    wp::array_t<wp::int32> var_affine_body_ids,
    wp::array_t<wp::int32> var_drive_types,
    wp::array_t<wp::vec_t<2, wp::int32>> var_drive_bodies,
    wp::array_t<wp::vec_t<3, wp::float32>> var_parent_origins,
    wp::array_t<wp::vec_t<3, wp::float32>> var_child_origins,
    wp::array_t<wp::vec_t<3, wp::float32>> var_parent_axis_points,
    wp::array_t<wp::vec_t<3, wp::float32>> var_parent_references,
    wp::array_t<wp::vec_t<3, wp::float32>> var_child_references,
    wp::array_t<wp::int32> var_dof_indices,
    wp::array_t<wp::int32> var_target_indices,
    wp::array_t<wp::float32> var_stiffness,
    wp::array_t<wp::float32> var_damping,
    wp::array_t<wp::int32> var_target_modes,
    wp::array_t<wp::float32> var_effort_limits,
    wp::array_t<wp::float32> var_feedforward,
    wp::array_t<wp::float32> var_target_q,
    wp::array_t<wp::float32> var_target_qd,
    wp::int32 var_use_previous_pose,
    wp::int32 var_advance_angle_state,
    wp::array_t<wp::float32> var_effort,
    wp::array_t<wp::float32> var_coordinate_velocity,
    wp::array_t<wp::transform_t<wp::float32>> adj_body_q,
    wp::array_t<wp::transform_t<wp::float32>> adj_previous_body_q,
    wp::array_t<wp::float32> adj_previous_angles,
    wp::array_t<wp::int32> adj_angle_initialized,
    wp::array_t<wp::vec_t<6, wp::float32>> adj_body_qd,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_body_com,
    wp::array_t<wp::int32> adj_affine_body_ids,
    wp::array_t<wp::int32> adj_drive_types,
    wp::array_t<wp::vec_t<2, wp::int32>> adj_drive_bodies,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_parent_origins,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_child_origins,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_parent_axis_points,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_parent_references,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_child_references,
    wp::array_t<wp::int32> adj_dof_indices,
    wp::array_t<wp::int32> adj_target_indices,
    wp::array_t<wp::float32> adj_stiffness,
    wp::array_t<wp::float32> adj_damping,
    wp::array_t<wp::int32> adj_target_modes,
    wp::array_t<wp::float32> adj_effort_limits,
    wp::array_t<wp::float32> adj_feedforward,
    wp::array_t<wp::float32> adj_target_q,
    wp::array_t<wp::float32> adj_target_qd,
    wp::int32 adj_use_previous_pose,
    wp::int32 adj_advance_angle_state,
    wp::array_t<wp::float32> adj_effort,
    wp::array_t<wp::float32> adj_coordinate_velocity)
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
        wp::int32 var_7;
        wp::int32 var_8;
        wp::transform_t<wp::float32>* var_9;
        wp::transform_t<wp::float32> var_10;
        wp::transform_t<wp::float32> var_11;
        wp::vec_t<6, wp::float32>* var_12;
        wp::vec_t<6, wp::float32> var_13;
        wp::vec_t<6, wp::float32> var_14;
        wp::vec_t<3, wp::float32>* var_15;
        wp::vec_t<3, wp::float32> var_16;
        wp::vec_t<3, wp::float32> var_17;
        wp::vec_t<3, wp::float32>* var_18;
        wp::vec_t<3, wp::float32> var_19;
        wp::vec_t<3, wp::float32> var_20;
        wp::vec_t<3, wp::float32>* var_21;
        wp::vec_t<3, wp::float32> var_22;
        wp::vec_t<3, wp::float32> var_23;
        wp::vec_t<3, wp::float32>* var_24;
        wp::vec_t<3, wp::float32> var_25;
        wp::vec_t<3, wp::float32> var_26;
        wp::vec_t<3, wp::float32>* var_27;
        wp::vec_t<3, wp::float32> var_28;
        wp::vec_t<3, wp::float32> var_29;
        wp::vec_t<3, wp::float32>* var_30;
        wp::vec_t<3, wp::float32> var_31;
        wp::vec_t<3, wp::float32> var_32;
        const wp::float32 var_33 = 0.0;
        wp::vec_t<3, wp::float32> var_34;
        const wp::float32 var_35 = 0.0;
        wp::vec_t<3, wp::float32> var_36;
        const wp::int32 var_37 = 0;
        wp::int32 var_38;
        const wp::int32 var_39 = 0;
        bool var_40;
        const wp::int32 var_41 = 0;
        wp::int32 var_42;
        wp::int32* var_43;
        wp::int32 var_44;
        wp::int32 var_45;
        wp::transform_t<wp::float32>* var_46;
        wp::transform_t<wp::float32> var_47;
        wp::transform_t<wp::float32> var_48;
        wp::vec_t<6, wp::float32>* var_49;
        wp::vec_t<6, wp::float32> var_50;
        wp::vec_t<6, wp::float32> var_51;
        wp::vec_t<3, wp::float32> var_52;
        wp::vec_t<3, wp::float32> var_53;
        wp::vec_t<3, wp::float32> var_54;
        wp::vec_t<3, wp::float32>* var_55;
        wp::vec_t<3, wp::float32> var_56;
        wp::vec_t<3, wp::float32> var_57;
        wp::vec_t<3, wp::float32> var_58;
        wp::vec_t<3, wp::float32> var_59;
        wp::vec_t<3, wp::float32> var_60;
        wp::vec_t<3, wp::float32> var_61;
        wp::vec_t<3, wp::float32> var_62;
        wp::vec_t<3, wp::float32> var_63;
        wp::vec_t<3, wp::float32> var_64;
        wp::float32 var_65;
        const wp::float32 var_66 = 1e-08;
        bool var_67;
        wp::vec_t<3, wp::float32> var_68;
        wp::vec_t<3, wp::float32> var_69;
        wp::float32 var_70;
        wp::vec_t<3, wp::float32> var_71;
        wp::float32 var_72;
        wp::vec_t<3, wp::float32> var_73;
        wp::float32 var_74;
        wp::float32 var_75;
        wp::int32* var_76;
        wp::int32 var_77;
        wp::int32 var_78;
        wp::int32* var_79;
        const wp::int32 var_80 = 1;
        bool var_81;
        wp::int32 var_82;
        wp::vec_t<3, wp::float32> var_83;
        wp::vec_t<3, wp::float32> var_84;
        wp::float32 var_85;
        wp::vec_t<3, wp::float32> var_86;
        wp::vec_t<3, wp::float32> var_87;
        wp::float32 var_88;
        wp::vec_t<3, wp::float32> var_89;
        wp::vec_t<3, wp::float32> var_90;
        bool var_91;
        wp::float32 var_92;
        const wp::float32 var_93 = 1e-08;
        bool var_94;
        wp::float32 var_95;
        const wp::float32 var_96 = 1e-08;
        bool var_97;
        wp::vec_t<3, wp::float32> var_98;
        wp::float32 var_99;
        wp::float32 var_100;
        wp::float32 var_101;
        wp::int32* var_102;
        const wp::int32 var_103 = 0;
        bool var_104;
        wp::int32 var_105;
        wp::float32* var_106;
        wp::float32 var_107;
        wp::float32 var_108;
        const wp::int32 var_109 = 0;
        bool var_110;
        wp::transform_t<wp::float32>* var_111;
        wp::transform_t<wp::float32> var_112;
        wp::transform_t<wp::float32> var_113;
        wp::vec_t<3, wp::float32>* var_114;
        wp::vec_t<3, wp::float32>* var_115;
        wp::vec_t<3, wp::float32> var_116;
        wp::vec_t<3, wp::float32> var_117;
        wp::vec_t<3, wp::float32> var_118;
        wp::vec_t<3, wp::float32> var_119;
        wp::vec_t<3, wp::float32>* var_120;
        wp::vec_t<3, wp::float32>* var_121;
        wp::vec_t<3, wp::float32> var_122;
        wp::vec_t<3, wp::float32> var_123;
        wp::vec_t<3, wp::float32> var_124;
        wp::vec_t<3, wp::float32>* var_125;
        wp::vec_t<3, wp::float32>* var_126;
        wp::vec_t<3, wp::float32> var_127;
        wp::vec_t<3, wp::float32> var_128;
        wp::vec_t<3, wp::float32> var_129;
        const wp::int32 var_130 = 0;
        wp::int32 var_131;
        const wp::int32 var_132 = 0;
        bool var_133;
        const wp::int32 var_134 = 0;
        wp::int32 var_135;
        wp::int32* var_136;
        wp::transform_t<wp::float32>* var_137;
        wp::int32 var_138;
        wp::transform_t<wp::float32> var_139;
        wp::transform_t<wp::float32> var_140;
        wp::vec_t<3, wp::float32> var_141;
        wp::vec_t<3, wp::float32> var_142;
        wp::vec_t<3, wp::float32> var_143;
        wp::vec_t<3, wp::float32> var_144;
        wp::vec_t<3, wp::float32> var_145;
        wp::float32 var_146;
        wp::vec_t<3, wp::float32> var_147;
        wp::vec_t<3, wp::float32> var_148;
        wp::float32 var_149;
        wp::vec_t<3, wp::float32> var_150;
        wp::vec_t<3, wp::float32> var_151;
        wp::vec_t<3, wp::float32> var_152;
        wp::float32 var_153;
        wp::float32 var_154;
        wp::float32 var_155;
        wp::float32 var_156;
        wp::float32 var_157;
        wp::float32 var_158;
        const wp::int32 var_159 = 0;
        bool var_160;
        const wp::int32 var_161 = 1;
        wp::vec_t<3, wp::float32> var_162;
        wp::vec_t<3, wp::float32> var_163;
        wp::float32 var_164;
        wp::float32 var_165;
        wp::float32 var_166;
        wp::int32* var_167;
        wp::int32 var_168;
        wp::int32 var_169;
        const wp::float32 var_170 = 0.0;
        wp::float32 var_171;
        bool var_172;
        const wp::int32 var_173 = 1;
        bool var_174;
        const wp::int32 var_175 = 3;
        bool var_176;
        wp::float32* var_177;
        wp::int32* var_178;
        wp::float32* var_179;
        wp::int32 var_180;
        wp::float32 var_181;
        wp::float32 var_182;
        wp::float32 var_183;
        wp::float32 var_184;
        wp::float32 var_185;
        const wp::int32 var_186 = 1;
        bool var_187;
        wp::float32* var_188;
        wp::float32 var_189;
        wp::float32 var_190;
        wp::float32 var_191;
        bool var_192;
        const wp::int32 var_193 = 2;
        bool var_194;
        const wp::int32 var_195 = 3;
        bool var_196;
        wp::float32* var_197;
        wp::float32* var_198;
        wp::float32 var_199;
        wp::float32 var_200;
        wp::float32 var_201;
        wp::float32 var_202;
        wp::float32 var_203;
        wp::float32 var_204;
        wp::float32 var_205;
        wp::float32* var_206;
        wp::float32 var_207;
        wp::float32 var_208;
        wp::float32 var_209;
        wp::float32 var_210;
        wp::float32* var_211;
        wp::float32 var_212;
        wp::float32 var_213;
        wp::float32 var_214;
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
        wp::transform_t<wp::float32> adj_9 = {};
        wp::transform_t<wp::float32> adj_10 = {};
        wp::transform_t<wp::float32> adj_11 = {};
        wp::vec_t<6, wp::float32> adj_12 = {};
        wp::vec_t<6, wp::float32> adj_13 = {};
        wp::vec_t<6, wp::float32> adj_14 = {};
        wp::vec_t<3, wp::float32> adj_15 = {};
        wp::vec_t<3, wp::float32> adj_16 = {};
        wp::vec_t<3, wp::float32> adj_17 = {};
        wp::vec_t<3, wp::float32> adj_18 = {};
        wp::vec_t<3, wp::float32> adj_19 = {};
        wp::vec_t<3, wp::float32> adj_20 = {};
        wp::vec_t<3, wp::float32> adj_21 = {};
        wp::vec_t<3, wp::float32> adj_22 = {};
        wp::vec_t<3, wp::float32> adj_23 = {};
        wp::vec_t<3, wp::float32> adj_24 = {};
        wp::vec_t<3, wp::float32> adj_25 = {};
        wp::vec_t<3, wp::float32> adj_26 = {};
        wp::vec_t<3, wp::float32> adj_27 = {};
        wp::vec_t<3, wp::float32> adj_28 = {};
        wp::vec_t<3, wp::float32> adj_29 = {};
        wp::vec_t<3, wp::float32> adj_30 = {};
        wp::vec_t<3, wp::float32> adj_31 = {};
        wp::vec_t<3, wp::float32> adj_32 = {};
        wp::float32 adj_33 = {};
        wp::vec_t<3, wp::float32> adj_34 = {};
        wp::float32 adj_35 = {};
        wp::vec_t<3, wp::float32> adj_36 = {};
        wp::int32 adj_37 = {};
        wp::int32 adj_38 = {};
        wp::int32 adj_39 = {};
        bool adj_40 = {};
        wp::int32 adj_41 = {};
        wp::int32 adj_42 = {};
        wp::int32 adj_43 = {};
        wp::int32 adj_44 = {};
        wp::int32 adj_45 = {};
        wp::transform_t<wp::float32> adj_46 = {};
        wp::transform_t<wp::float32> adj_47 = {};
        wp::transform_t<wp::float32> adj_48 = {};
        wp::vec_t<6, wp::float32> adj_49 = {};
        wp::vec_t<6, wp::float32> adj_50 = {};
        wp::vec_t<6, wp::float32> adj_51 = {};
        wp::vec_t<3, wp::float32> adj_52 = {};
        wp::vec_t<3, wp::float32> adj_53 = {};
        wp::vec_t<3, wp::float32> adj_54 = {};
        wp::vec_t<3, wp::float32> adj_55 = {};
        wp::vec_t<3, wp::float32> adj_56 = {};
        wp::vec_t<3, wp::float32> adj_57 = {};
        wp::vec_t<3, wp::float32> adj_58 = {};
        wp::vec_t<3, wp::float32> adj_59 = {};
        wp::vec_t<3, wp::float32> adj_60 = {};
        wp::vec_t<3, wp::float32> adj_61 = {};
        wp::vec_t<3, wp::float32> adj_62 = {};
        wp::vec_t<3, wp::float32> adj_63 = {};
        wp::vec_t<3, wp::float32> adj_64 = {};
        wp::float32 adj_65 = {};
        wp::float32 adj_66 = {};
        bool adj_67 = {};
        wp::vec_t<3, wp::float32> adj_68 = {};
        wp::vec_t<3, wp::float32> adj_69 = {};
        wp::float32 adj_70 = {};
        wp::vec_t<3, wp::float32> adj_71 = {};
        wp::float32 adj_72 = {};
        wp::vec_t<3, wp::float32> adj_73 = {};
        wp::float32 adj_74 = {};
        wp::float32 adj_75 = {};
        wp::int32 adj_76 = {};
        wp::int32 adj_77 = {};
        wp::int32 adj_78 = {};
        wp::int32 adj_79 = {};
        wp::int32 adj_80 = {};
        bool adj_81 = {};
        wp::int32 adj_82 = {};
        wp::vec_t<3, wp::float32> adj_83 = {};
        wp::vec_t<3, wp::float32> adj_84 = {};
        wp::float32 adj_85 = {};
        wp::vec_t<3, wp::float32> adj_86 = {};
        wp::vec_t<3, wp::float32> adj_87 = {};
        wp::float32 adj_88 = {};
        wp::vec_t<3, wp::float32> adj_89 = {};
        wp::vec_t<3, wp::float32> adj_90 = {};
        bool adj_91 = {};
        wp::float32 adj_92 = {};
        wp::float32 adj_93 = {};
        bool adj_94 = {};
        wp::float32 adj_95 = {};
        wp::float32 adj_96 = {};
        bool adj_97 = {};
        wp::vec_t<3, wp::float32> adj_98 = {};
        wp::float32 adj_99 = {};
        wp::float32 adj_100 = {};
        wp::float32 adj_101 = {};
        wp::int32 adj_102 = {};
        wp::int32 adj_103 = {};
        bool adj_104 = {};
        wp::int32 adj_105 = {};
        wp::float32 adj_106 = {};
        wp::float32 adj_107 = {};
        wp::float32 adj_108 = {};
        wp::int32 adj_109 = {};
        bool adj_110 = {};
        wp::transform_t<wp::float32> adj_111 = {};
        wp::transform_t<wp::float32> adj_112 = {};
        wp::transform_t<wp::float32> adj_113 = {};
        wp::vec_t<3, wp::float32> adj_114 = {};
        wp::vec_t<3, wp::float32> adj_115 = {};
        wp::vec_t<3, wp::float32> adj_116 = {};
        wp::vec_t<3, wp::float32> adj_117 = {};
        wp::vec_t<3, wp::float32> adj_118 = {};
        wp::vec_t<3, wp::float32> adj_119 = {};
        wp::vec_t<3, wp::float32> adj_120 = {};
        wp::vec_t<3, wp::float32> adj_121 = {};
        wp::vec_t<3, wp::float32> adj_122 = {};
        wp::vec_t<3, wp::float32> adj_123 = {};
        wp::vec_t<3, wp::float32> adj_124 = {};
        wp::vec_t<3, wp::float32> adj_125 = {};
        wp::vec_t<3, wp::float32> adj_126 = {};
        wp::vec_t<3, wp::float32> adj_127 = {};
        wp::vec_t<3, wp::float32> adj_128 = {};
        wp::vec_t<3, wp::float32> adj_129 = {};
        wp::int32 adj_130 = {};
        wp::int32 adj_131 = {};
        wp::int32 adj_132 = {};
        bool adj_133 = {};
        wp::int32 adj_134 = {};
        wp::int32 adj_135 = {};
        wp::int32 adj_136 = {};
        wp::transform_t<wp::float32> adj_137 = {};
        wp::int32 adj_138 = {};
        wp::transform_t<wp::float32> adj_139 = {};
        wp::transform_t<wp::float32> adj_140 = {};
        wp::vec_t<3, wp::float32> adj_141 = {};
        wp::vec_t<3, wp::float32> adj_142 = {};
        wp::vec_t<3, wp::float32> adj_143 = {};
        wp::vec_t<3, wp::float32> adj_144 = {};
        wp::vec_t<3, wp::float32> adj_145 = {};
        wp::float32 adj_146 = {};
        wp::vec_t<3, wp::float32> adj_147 = {};
        wp::vec_t<3, wp::float32> adj_148 = {};
        wp::float32 adj_149 = {};
        wp::vec_t<3, wp::float32> adj_150 = {};
        wp::vec_t<3, wp::float32> adj_151 = {};
        wp::vec_t<3, wp::float32> adj_152 = {};
        wp::float32 adj_153 = {};
        wp::float32 adj_154 = {};
        wp::float32 adj_155 = {};
        wp::float32 adj_156 = {};
        wp::float32 adj_157 = {};
        wp::float32 adj_158 = {};
        wp::int32 adj_159 = {};
        bool adj_160 = {};
        wp::int32 adj_161 = {};
        wp::vec_t<3, wp::float32> adj_162 = {};
        wp::vec_t<3, wp::float32> adj_163 = {};
        wp::float32 adj_164 = {};
        wp::float32 adj_165 = {};
        wp::float32 adj_166 = {};
        wp::int32 adj_167 = {};
        wp::int32 adj_168 = {};
        wp::int32 adj_169 = {};
        wp::float32 adj_170 = {};
        wp::float32 adj_171 = {};
        bool adj_172 = {};
        wp::int32 adj_173 = {};
        bool adj_174 = {};
        wp::int32 adj_175 = {};
        bool adj_176 = {};
        wp::float32 adj_177 = {};
        wp::int32 adj_178 = {};
        wp::float32 adj_179 = {};
        wp::int32 adj_180 = {};
        wp::float32 adj_181 = {};
        wp::float32 adj_182 = {};
        wp::float32 adj_183 = {};
        wp::float32 adj_184 = {};
        wp::float32 adj_185 = {};
        wp::int32 adj_186 = {};
        bool adj_187 = {};
        wp::float32 adj_188 = {};
        wp::float32 adj_189 = {};
        wp::float32 adj_190 = {};
        wp::float32 adj_191 = {};
        bool adj_192 = {};
        wp::int32 adj_193 = {};
        bool adj_194 = {};
        wp::int32 adj_195 = {};
        bool adj_196 = {};
        wp::float32 adj_197 = {};
        wp::float32 adj_198 = {};
        wp::float32 adj_199 = {};
        wp::float32 adj_200 = {};
        wp::float32 adj_201 = {};
        wp::float32 adj_202 = {};
        wp::float32 adj_203 = {};
        wp::float32 adj_204 = {};
        wp::float32 adj_205 = {};
        wp::float32 adj_206 = {};
        wp::float32 adj_207 = {};
        wp::float32 adj_208 = {};
        wp::float32 adj_209 = {};
        wp::float32 adj_210 = {};
        wp::float32 adj_211 = {};
        wp::float32 adj_212 = {};
        wp::float32 adj_213 = {};
        wp::float32 adj_214 = {};
        //---------
        // forward
        // def evaluate_joint_drive_effort(                                                       <L 24>
        // drive = wp.tid()                                                                       <L 53>
        var_0 = builtin_tid1d();
        // bodies = drive_bodies[drive]                                                           <L 54>
        var_1 = wp::address(var_drive_bodies, var_0);
        var_3 = wp::load(var_1);
        var_2 = wp::copy(var_3);
        // child = affine_body_ids[bodies[1]]                                                     <L 55>
        var_5 = wp::extract(var_2, var_4);
        var_6 = wp::address(var_affine_body_ids, var_5);
        var_8 = wp::load(var_6);
        var_7 = wp::copy(var_8);
        // child_pose = body_q[child]                                                             <L 56>
        var_9 = wp::address(var_body_q, var_7);
        var_11 = wp::load(var_9);
        var_10 = wp::copy(var_11);
        // child_twist = body_qd[child]                                                           <L 57>
        var_12 = wp::address(var_body_qd, var_7);
        var_14 = wp::load(var_12);
        var_13 = wp::copy(var_14);
        // child_origin = wp.transform_point(child_pose, child_origins[drive])                    <L 58>
        var_15 = wp::address(var_child_origins, var_0);
        var_17 = wp::load(var_15);
        var_16 = wp::transform_point(var_10, var_17);
        // child_reference = wp.transform_point(child_pose, child_references[drive])              <L 59>
        var_18 = wp::address(var_child_references, var_0);
        var_20 = wp::load(var_18);
        var_19 = wp::transform_point(var_10, var_20);
        // child_velocity = _point_velocity(child_pose, child_twist, body_com[child], child_origin)       <L 60>
        var_21 = wp::address(var_body_com, var_7);
        var_23 = wp::load(var_21);
        var_22 = _point_velocity_0(var_10, var_13, var_23, var_16);
        // parent_origin = parent_origins[drive]                                                  <L 62>
        var_24 = wp::address(var_parent_origins, var_0);
        var_26 = wp::load(var_24);
        var_25 = wp::copy(var_26);
        // parent_axis_point = parent_axis_points[drive]                                          <L 63>
        var_27 = wp::address(var_parent_axis_points, var_0);
        var_29 = wp::load(var_27);
        var_28 = wp::copy(var_29);
        // parent_reference = parent_references[drive]                                            <L 64>
        var_30 = wp::address(var_parent_references, var_0);
        var_32 = wp::load(var_30);
        var_31 = wp::copy(var_32);
        // parent_velocity = wp.vec3(0.0)                                                         <L 65>
        var_34 = wp::vec_t<3, wp::float32>(var_33);
        // parent_omega = wp.vec3(0.0)                                                            <L 66>
        var_36 = wp::vec_t<3, wp::float32>(var_35);
        // if bodies[0] >= 0:                                                                     <L 67>
        var_38 = wp::extract(var_2, var_37);
        var_40 = (var_38 >= var_39);
        if (var_40) {
            // parent = affine_body_ids[bodies[0]]                                                <L 68>
            var_42 = wp::extract(var_2, var_41);
            var_43 = wp::address(var_affine_body_ids, var_42);
            var_45 = wp::load(var_43);
            var_44 = wp::copy(var_45);
            // parent_pose = body_q[parent]                                                       <L 69>
            var_46 = wp::address(var_body_q, var_44);
            var_48 = wp::load(var_46);
            var_47 = wp::copy(var_48);
            // parent_twist = body_qd[parent]                                                     <L 70>
            var_49 = wp::address(var_body_qd, var_44);
            var_51 = wp::load(var_49);
            var_50 = wp::copy(var_51);
            // parent_origin = wp.transform_point(parent_pose, parent_origin)                     <L 71>
            var_52 = wp::transform_point(var_47, var_25);
            // parent_axis_point = wp.transform_point(parent_pose, parent_axis_point)             <L 72>
            var_53 = wp::transform_point(var_47, var_28);
            // parent_reference = wp.transform_point(parent_pose, parent_reference)               <L 73>
            var_54 = wp::transform_point(var_47, var_31);
            // parent_velocity = _point_velocity(parent_pose, parent_twist, body_com[parent], parent_origin)       <L 74>
            var_55 = wp::address(var_body_com, var_44);
            var_57 = wp::load(var_55);
            var_56 = _point_velocity_0(var_47, var_50, var_57, var_52);
            // parent_omega = wp.spatial_bottom(parent_twist)                                     <L 75>
            var_58 = wp::spatial_bottom(var_50);
        }
        var_59 = wp::where(var_40, var_52, var_25);
        var_60 = wp::where(var_40, var_53, var_28);
        var_61 = wp::where(var_40, var_54, var_31);
        var_62 = wp::where(var_40, var_56, var_34);
        var_63 = wp::where(var_40, var_58, var_36);
        // axis_vector = parent_axis_point - parent_origin                                        <L 77>
        var_64 = wp::sub(var_60, var_59);
        // axis_length = wp.length(axis_vector)                                                   <L 78>
        var_65 = wp::length(var_64);
        // if axis_length <= 1.0e-8:                                                              <L 79>
        var_67 = (var_65 <= var_66);
        if (var_67) {
            // return                                                                             <L 80>
            goto label0;
        }
        // axis = axis_vector / axis_length                                                       <L 81>
        var_68 = wp::div(var_64, var_65);
        // displacement = child_origin - parent_origin                                            <L 82>
        var_69 = wp::sub(var_16, var_59);
        // q = wp.dot(displacement, axis)                                                         <L 83>
        var_70 = wp::dot(var_69, var_68);
        // qd = wp.dot(child_velocity - parent_velocity, axis) + wp.dot(displacement, wp.cross(parent_omega, axis))       <L 84>
        var_71 = wp::sub(var_22, var_62);
        var_72 = wp::dot(var_71, var_68);
        var_73 = wp::cross(var_63, var_68);
        var_74 = wp::dot(var_69, var_73);
        var_75 = wp::add(var_72, var_74);
        // dof = dof_indices[drive]                                                               <L 85>
        var_76 = wp::address(var_dof_indices, var_0);
        var_78 = wp::load(var_76);
        var_77 = wp::copy(var_78);
        // if drive_types[drive] == 1:                                                            <L 86>
        var_79 = wp::address(var_drive_types, var_0);
        var_82 = wp::load(var_79);
        var_81 = (var_82 == var_80);
        if (var_81) {
            // parent_arm = parent_reference - parent_origin                                      <L 87>
            var_83 = wp::sub(var_61, var_59);
            // child_arm = child_reference - child_origin                                         <L 88>
            var_84 = wp::sub(var_19, var_16);
            // parent_arm = parent_arm - wp.dot(parent_arm, axis) * axis                          <L 89>
            var_85 = wp::dot(var_83, var_68);
            var_86 = wp::mul(var_85, var_68);
            var_87 = wp::sub(var_83, var_86);
            // child_arm = child_arm - wp.dot(child_arm, axis) * axis                             <L 90>
            var_88 = wp::dot(var_84, var_68);
            var_89 = wp::mul(var_88, var_68);
            var_90 = wp::sub(var_84, var_89);
            // if wp.length(parent_arm) <= 1.0e-8 or wp.length(child_arm) <= 1.0e-8:              <L 91>
            var_92 = wp::length(var_87);
            var_94 = (var_92 <= var_93);
            var_91 = var_94;
            if (!var_91) {
                var_95 = wp::length(var_90);
                var_97 = (var_95 <= var_96);
                var_91 = var_91 || var_97;
            }
            if (var_91) {
                // return                                                                         <L 92>
                goto label1;
            }
            // q = wp.atan2(wp.dot(axis, wp.cross(parent_arm, child_arm)), wp.dot(parent_arm, child_arm))       <L 93>
            var_98 = wp::cross(var_87, var_90);
            var_99 = wp::dot(var_68, var_98);
            var_100 = wp::dot(var_87, var_90);
            var_101 = wp::atan2(var_99, var_100);
            // if angle_initialized[drive] != 0:                                                  <L 95>
            var_102 = wp::address(var_angle_initialized, var_0);
            var_105 = wp::load(var_102);
            var_104 = (var_105 != var_103);
            if (var_104) {
                // q = _unwrap_near(q, previous_angles[drive])                                    <L 96>
                var_106 = wp::address(var_previous_angles, var_0);
                var_108 = wp::load(var_106);
                var_107 = _unwrap_near_0(var_101, var_108);
            }
            if (!var_104) {
                // elif use_previous_pose != 0:                                                   <L 97>
                var_110 = (var_use_previous_pose != var_109);
                if (var_110) {
                    // previous_child_pose = previous_body_q[child]                               <L 100>
                    var_111 = wp::address(var_previous_body_q, var_7);
                    var_113 = wp::load(var_111);
                    var_112 = wp::copy(var_113);
                    // previous_child_arm = wp.transform_vector(                                  <L 101>
                    // previous_child_pose, child_references[drive] - child_origins[drive]        <L 102>
                    var_114 = wp::address(var_child_references, var_0);
                    var_115 = wp::address(var_child_origins, var_0);
                    var_117 = wp::load(var_114);
                    var_118 = wp::load(var_115);
                    var_116 = wp::sub(var_117, var_118);
                    var_119 = wp::transform_vector(var_112, var_116);
                    // previous_parent_arm = parent_references[drive] - parent_origins[drive]       <L 104>
                    var_120 = wp::address(var_parent_references, var_0);
                    var_121 = wp::address(var_parent_origins, var_0);
                    var_123 = wp::load(var_120);
                    var_124 = wp::load(var_121);
                    var_122 = wp::sub(var_123, var_124);
                    // previous_axis = parent_axis_points[drive] - parent_origins[drive]          <L 105>
                    var_125 = wp::address(var_parent_axis_points, var_0);
                    var_126 = wp::address(var_parent_origins, var_0);
                    var_128 = wp::load(var_125);
                    var_129 = wp::load(var_126);
                    var_127 = wp::sub(var_128, var_129);
                    // if bodies[0] >= 0:                                                         <L 106>
                    var_131 = wp::extract(var_2, var_130);
                    var_133 = (var_131 >= var_132);
                    if (var_133) {
                        // previous_parent_pose = previous_body_q[affine_body_ids[bodies[0]]]       <L 107>
                        var_135 = wp::extract(var_2, var_134);
                        var_136 = wp::address(var_affine_body_ids, var_135);
                        var_138 = wp::load(var_136);
                        var_137 = wp::address(var_previous_body_q, var_138);
                        var_140 = wp::load(var_137);
                        var_139 = wp::copy(var_140);
                        // previous_parent_arm = wp.transform_vector(previous_parent_pose, previous_parent_arm)       <L 108>
                        var_141 = wp::transform_vector(var_139, var_122);
                        // previous_axis = wp.transform_vector(previous_parent_pose, previous_axis)       <L 109>
                        var_142 = wp::transform_vector(var_139, var_127);
                    }
                    var_143 = wp::where(var_133, var_141, var_122);
                    var_144 = wp::where(var_133, var_142, var_127);
                    // previous_axis = wp.normalize(previous_axis)                                <L 110>
                    var_145 = wp::normalize(var_144);
                    // previous_parent_arm -= wp.dot(previous_parent_arm, previous_axis) * previous_axis       <L 111>
                    var_146 = wp::dot(var_143, var_145);
                    var_147 = wp::mul(var_146, var_145);
                    var_148 = wp::sub(var_143, var_147);
                    // previous_child_arm -= wp.dot(previous_child_arm, previous_axis) * previous_axis       <L 112>
                    var_149 = wp::dot(var_119, var_145);
                    var_150 = wp::mul(var_149, var_145);
                    var_151 = wp::sub(var_119, var_150);
                    // previous_q = wp.atan2(                                                     <L 113>
                    // wp.dot(previous_axis, wp.cross(previous_parent_arm, previous_child_arm)),       <L 114>
                    var_152 = wp::cross(var_148, var_151);
                    var_153 = wp::dot(var_145, var_152);
                    // wp.dot(previous_parent_arm, previous_child_arm),                           <L 115>
                    var_154 = wp::dot(var_148, var_151);
                    var_155 = wp::atan2(var_153, var_154);
                    // q = _unwrap_near(q, previous_q)                                            <L 117>
                    var_156 = _unwrap_near_0(var_101, var_155);
                }
                var_157 = wp::where(var_110, var_156, var_101);
            }
            var_158 = wp::where(var_104, var_107, var_157);
            // if advance_angle_state != 0:                                                       <L 118>
            var_160 = (var_advance_angle_state != var_159);
            if (var_160) {
                // previous_angles[drive] = q                                                     <L 119>
                // wp::array_store(var_previous_angles, var_0, var_158);
                // angle_initialized[drive] = 1                                                   <L 120>
                // wp::array_store(var_angle_initialized, var_0, var_161);
            }
            // qd = wp.dot(wp.spatial_bottom(child_twist) - parent_omega, axis)                   <L 121>
            var_162 = wp::spatial_bottom(var_13);
            var_163 = wp::sub(var_162, var_63);
            var_164 = wp::dot(var_163, var_68);
        }
        var_165 = wp::where(var_81, var_158, var_70);
        var_166 = wp::where(var_81, var_164, var_75);
        // mode = target_modes[dof]                                                               <L 123>
        var_167 = wp::address(var_target_modes, var_77);
        var_169 = wp::load(var_167);
        var_168 = wp::copy(var_169);
        // actuator = wp.float32(0.0)                                                             <L 124>
        var_171 = wp::float32(var_170);
        // if mode == 1 or mode == 3:                                                             <L 125>
        var_174 = (var_168 == var_173);
        var_172 = var_174;
        if (!var_172) {
            var_176 = (var_168 == var_175);
            var_172 = var_172 || var_176;
        }
        if (var_172) {
            // actuator = stiffness[dof] * (target_q[target_indices[drive]] - q)                  <L 126>
            var_177 = wp::address(var_stiffness, var_77);
            var_178 = wp::address(var_target_indices, var_0);
            var_180 = wp::load(var_178);
            var_179 = wp::address(var_target_q, var_180);
            var_182 = wp::load(var_179);
            var_181 = wp::sub(var_182, var_165);
            var_184 = wp::load(var_177);
            var_183 = wp::mul(var_184, var_181);
        }
        var_185 = wp::where(var_172, var_183, var_171);
        // if mode == 1:                                                                          <L 127>
        var_187 = (var_168 == var_186);
        if (var_187) {
            // actuator -= damping[dof] * qd                                                      <L 128>
            var_188 = wp::address(var_damping, var_77);
            var_190 = wp::load(var_188);
            var_189 = wp::mul(var_190, var_166);
            var_191 = wp::sub(var_185, var_189);
        }
        if (!var_187) {
            // elif mode == 2 or mode == 3:                                                       <L 129>
            var_194 = (var_168 == var_193);
            var_192 = var_194;
            if (!var_192) {
                var_196 = (var_168 == var_195);
                var_192 = var_192 || var_196;
            }
            if (var_192) {
                // actuator += damping[dof] * (target_qd[dof] - qd)                               <L 130>
                var_197 = wp::address(var_damping, var_77);
                var_198 = wp::address(var_target_qd, var_77);
                var_200 = wp::load(var_198);
                var_199 = wp::sub(var_200, var_166);
                var_202 = wp::load(var_197);
                var_201 = wp::mul(var_202, var_199);
                var_203 = wp::add(var_185, var_201);
            }
            var_204 = wp::where(var_192, var_203, var_185);
        }
        var_205 = wp::where(var_187, var_191, var_204);
        // limit = effort_limits[dof]                                                             <L 133>
        var_206 = wp::address(var_effort_limits, var_77);
        var_208 = wp::load(var_206);
        var_207 = wp::copy(var_208);
        // actuator = wp.clamp(actuator, -limit, limit)                                           <L 134>
        var_209 = wp::neg(var_207);
        var_210 = wp::clamp(var_205, var_209, var_207);
        // wp.atomic_add(effort, dof, feedforward[dof] + actuator)                                <L 135>
        var_211 = wp::address(var_feedforward, var_77);
        var_213 = wp::load(var_211);
        var_212 = wp::add(var_213, var_210);
        // var_214 = wp::atomic_add(var_effort, var_77, var_212);
        // coordinate_velocity[drive] = qd                                                        <L 136>
        // wp::array_store(var_coordinate_velocity, var_0, var_166);
        //---------
        // reverse
        wp::adj_array_store(var_coordinate_velocity, var_0, var_166, adj_coordinate_velocity, adj_0, adj_166);
        // adj: coordinate_velocity[drive] = qd                                                   <L 136>
        wp::adj_atomic_add(var_effort, var_77, var_212, adj_effort, adj_77, adj_212, adj_214);
        wp::adj_add(var_213, var_210, adj_211, adj_210, adj_212);
        wp::adj_address(var_feedforward, var_77, adj_feedforward, adj_77, adj_211);
        // adj: wp.atomic_add(effort, dof, feedforward[dof] + actuator)                           <L 135>
        wp::adj_clamp(var_205, var_209, var_207, adj_205, adj_209, adj_207, adj_210);
        wp::adj_neg(var_207, adj_207, adj_209);
        // adj: actuator = wp.clamp(actuator, -limit, limit)                                      <L 134>
        wp::adj_copy(var_208, adj_206, adj_207);
        wp::adj_address(var_effort_limits, var_77, adj_effort_limits, adj_77, adj_206);
        // adj: limit = effort_limits[dof]                                                        <L 133>
        wp::adj_where(var_187, var_191, var_204, adj_187, adj_191, adj_204, adj_205);
        if (!var_187) {
            wp::adj_where(var_192, var_203, var_185, adj_192, adj_203, adj_185, adj_204);
            if (var_192) {
                wp::adj_add(var_185, var_201, adj_185, adj_201, adj_203);
                wp::adj_mul(var_202, var_199, adj_197, adj_199, adj_201);
                wp::adj_sub(var_200, var_166, adj_198, adj_166, adj_199);
                wp::adj_address(var_target_qd, var_77, adj_target_qd, adj_77, adj_198);
                wp::adj_address(var_damping, var_77, adj_damping, adj_77, adj_197);
                // adj: actuator += damping[dof] * (target_qd[dof] - qd)                          <L 130>
            }
            if (!var_192) {
            }
            // adj: elif mode == 2 or mode == 3:                                                  <L 129>
        }
        if (var_187) {
            wp::adj_sub(var_185, var_189, adj_185, adj_189, adj_191);
            wp::adj_mul(var_190, var_166, adj_188, adj_166, adj_189);
            wp::adj_address(var_damping, var_77, adj_damping, adj_77, adj_188);
            // adj: actuator -= damping[dof] * qd                                                 <L 128>
        }
        // adj: if mode == 1:                                                                     <L 127>
        wp::adj_where(var_172, var_183, var_171, adj_172, adj_183, adj_171, adj_185);
        if (var_172) {
            wp::adj_mul(var_184, var_181, adj_177, adj_181, adj_183);
            wp::adj_sub(var_182, var_165, adj_179, adj_165, adj_181);
            wp::adj_address(var_target_q, var_180, adj_target_q, adj_178, adj_179);
            wp::adj_address(var_target_indices, var_0, adj_target_indices, adj_0, adj_178);
            wp::adj_address(var_stiffness, var_77, adj_stiffness, adj_77, adj_177);
            // adj: actuator = stiffness[dof] * (target_q[target_indices[drive]] - q)             <L 126>
        }
        if (!var_172) {
        }
        // adj: if mode == 1 or mode == 3:                                                        <L 125>
        wp::adj_float32(var_170, adj_170, adj_171);
        // adj: actuator = wp.float32(0.0)                                                        <L 124>
        wp::adj_copy(var_169, adj_167, adj_168);
        wp::adj_address(var_target_modes, var_77, adj_target_modes, adj_77, adj_167);
        // adj: mode = target_modes[dof]                                                          <L 123>
        wp::adj_where(var_81, var_164, var_75, adj_81, adj_164, adj_75, adj_166);
        wp::adj_where(var_81, var_158, var_70, adj_81, adj_158, adj_70, adj_165);
        if (var_81) {
            wp::adj_dot(var_163, var_68, adj_163, adj_68, adj_164);
            wp::adj_sub(var_162, var_63, adj_162, adj_63, adj_163);
            wp::adj_spatial_bottom(var_13, adj_13, adj_162);
            // adj: qd = wp.dot(wp.spatial_bottom(child_twist) - parent_omega, axis)              <L 121>
            if (var_160) {
                wp::adj_array_store(var_angle_initialized, var_0, var_161, adj_angle_initialized, adj_0, adj_161);
                // adj: angle_initialized[drive] = 1                                              <L 120>
                wp::adj_array_store(var_previous_angles, var_0, var_158, adj_previous_angles, adj_0, adj_158);
                // adj: previous_angles[drive] = q                                                <L 119>
            }
            // adj: if advance_angle_state != 0:                                                  <L 118>
            wp::adj_where(var_104, var_107, var_157, adj_104, adj_107, adj_157, adj_158);
            if (!var_104) {
                wp::adj_where(var_110, var_156, var_101, adj_110, adj_156, adj_101, adj_157);
                if (var_110) {
                    adj__unwrap_near_0(var_101, var_155, adj_101, adj_155, adj_156);
                    // adj: q = _unwrap_near(q, previous_q)                                       <L 117>
                    wp::adj_atan2(var_153, var_154, adj_153, adj_154, adj_155);
                    wp::adj_dot(var_148, var_151, adj_148, adj_151, adj_154);
                    // adj: wp.dot(previous_parent_arm, previous_child_arm),                      <L 115>
                    wp::adj_dot(var_145, var_152, adj_145, adj_152, adj_153);
                    wp::adj_cross(var_148, var_151, adj_148, adj_151, adj_152);
                    // adj: wp.dot(previous_axis, wp.cross(previous_parent_arm, previous_child_arm)),  <L 114>
                    // adj: previous_q = wp.atan2(                                                <L 113>
                    wp::adj_sub(var_119, var_150, adj_119, adj_150, adj_151);
                    wp::adj_mul(var_149, var_145, adj_149, adj_145, adj_150);
                    wp::adj_dot(var_119, var_145, adj_119, adj_145, adj_149);
                    // adj: previous_child_arm -= wp.dot(previous_child_arm, previous_axis) * previous_axis  <L 112>
                    wp::adj_sub(var_143, var_147, adj_143, adj_147, adj_148);
                    wp::adj_mul(var_146, var_145, adj_146, adj_145, adj_147);
                    wp::adj_dot(var_143, var_145, adj_143, adj_145, adj_146);
                    // adj: previous_parent_arm -= wp.dot(previous_parent_arm, previous_axis) * previous_axis  <L 111>
                    wp::adj_normalize(var_144, var_145, adj_144, adj_145);
                    // adj: previous_axis = wp.normalize(previous_axis)                           <L 110>
                    wp::adj_where(var_133, var_142, var_127, adj_133, adj_142, adj_127, adj_144);
                    wp::adj_where(var_133, var_141, var_122, adj_133, adj_141, adj_122, adj_143);
                    if (var_133) {
                        wp::adj_transform_vector(var_139, var_127, adj_139, adj_127, adj_142);
                        // adj: previous_axis = wp.transform_vector(previous_parent_pose, previous_axis)  <L 109>
                        wp::adj_transform_vector(var_139, var_122, adj_139, adj_122, adj_141);
                        // adj: previous_parent_arm = wp.transform_vector(previous_parent_pose, previous_parent_arm)  <L 108>
                        wp::adj_copy(var_140, adj_137, adj_139);
                        wp::adj_address(var_previous_body_q, var_138, adj_previous_body_q, adj_136, adj_137);
                        wp::adj_address(var_affine_body_ids, var_135, adj_affine_body_ids, adj_135, adj_136);
                        wp::adj_extract(var_2, var_134, adj_2, adj_134, adj_135);
                        // adj: previous_parent_pose = previous_body_q[affine_body_ids[bodies[0]]]  <L 107>
                    }
                    wp::adj_extract(var_2, var_130, adj_2, adj_130, adj_131);
                    // adj: if bodies[0] >= 0:                                                    <L 106>
                    wp::adj_sub(var_128, var_129, adj_125, adj_126, adj_127);
                    wp::adj_address(var_parent_origins, var_0, adj_parent_origins, adj_0, adj_126);
                    wp::adj_address(var_parent_axis_points, var_0, adj_parent_axis_points, adj_0, adj_125);
                    // adj: previous_axis = parent_axis_points[drive] - parent_origins[drive]     <L 105>
                    wp::adj_sub(var_123, var_124, adj_120, adj_121, adj_122);
                    wp::adj_address(var_parent_origins, var_0, adj_parent_origins, adj_0, adj_121);
                    wp::adj_address(var_parent_references, var_0, adj_parent_references, adj_0, adj_120);
                    // adj: previous_parent_arm = parent_references[drive] - parent_origins[drive]  <L 104>
                    wp::adj_transform_vector(var_112, var_116, adj_112, adj_116, adj_119);
                    wp::adj_sub(var_117, var_118, adj_114, adj_115, adj_116);
                    wp::adj_address(var_child_origins, var_0, adj_child_origins, adj_0, adj_115);
                    wp::adj_address(var_child_references, var_0, adj_child_references, adj_0, adj_114);
                    // adj: previous_child_pose, child_references[drive] - child_origins[drive]   <L 102>
                    // adj: previous_child_arm = wp.transform_vector(                             <L 101>
                    wp::adj_copy(var_113, adj_111, adj_112);
                    wp::adj_address(var_previous_body_q, var_7, adj_previous_body_q, adj_7, adj_111);
                    // adj: previous_child_pose = previous_body_q[child]                          <L 100>
                }
                // adj: elif use_previous_pose != 0:                                              <L 97>
            }
            if (var_104) {
                adj__unwrap_near_0(var_101, var_108, adj_101, adj_106, adj_107);
                wp::adj_address(var_previous_angles, var_0, adj_previous_angles, adj_0, adj_106);
                // adj: q = _unwrap_near(q, previous_angles[drive])                               <L 96>
            }
            wp::adj_address(var_angle_initialized, var_0, adj_angle_initialized, adj_0, adj_102);
            // adj: if angle_initialized[drive] != 0:                                             <L 95>
            wp::adj_atan2(var_99, var_100, adj_99, adj_100, adj_101);
            wp::adj_dot(var_87, var_90, adj_87, adj_90, adj_100);
            wp::adj_dot(var_68, var_98, adj_68, adj_98, adj_99);
            wp::adj_cross(var_87, var_90, adj_87, adj_90, adj_98);
            // adj: q = wp.atan2(wp.dot(axis, wp.cross(parent_arm, child_arm)), wp.dot(parent_arm, child_arm))  <L 93>
            if (var_91) {
                label1:;
                // adj: return                                                                    <L 92>
            }
            if (!var_91) {
                wp::adj_length(var_90, var_95, adj_90, adj_95);
            }
            wp::adj_length(var_87, var_92, adj_87, adj_92);
            // adj: if wp.length(parent_arm) <= 1.0e-8 or wp.length(child_arm) <= 1.0e-8:         <L 91>
            wp::adj_sub(var_84, var_89, adj_84, adj_89, adj_90);
            wp::adj_mul(var_88, var_68, adj_88, adj_68, adj_89);
            wp::adj_dot(var_84, var_68, adj_84, adj_68, adj_88);
            // adj: child_arm = child_arm - wp.dot(child_arm, axis) * axis                        <L 90>
            wp::adj_sub(var_83, var_86, adj_83, adj_86, adj_87);
            wp::adj_mul(var_85, var_68, adj_85, adj_68, adj_86);
            wp::adj_dot(var_83, var_68, adj_83, adj_68, adj_85);
            // adj: parent_arm = parent_arm - wp.dot(parent_arm, axis) * axis                     <L 89>
            wp::adj_sub(var_19, var_16, adj_19, adj_16, adj_84);
            // adj: child_arm = child_reference - child_origin                                    <L 88>
            wp::adj_sub(var_61, var_59, adj_61, adj_59, adj_83);
            // adj: parent_arm = parent_reference - parent_origin                                 <L 87>
        }
        wp::adj_address(var_drive_types, var_0, adj_drive_types, adj_0, adj_79);
        // adj: if drive_types[drive] == 1:                                                       <L 86>
        wp::adj_copy(var_78, adj_76, adj_77);
        wp::adj_address(var_dof_indices, var_0, adj_dof_indices, adj_0, adj_76);
        // adj: dof = dof_indices[drive]                                                          <L 85>
        wp::adj_add(var_72, var_74, adj_72, adj_74, adj_75);
        wp::adj_dot(var_69, var_73, adj_69, adj_73, adj_74);
        wp::adj_cross(var_63, var_68, adj_63, adj_68, adj_73);
        wp::adj_dot(var_71, var_68, adj_71, adj_68, adj_72);
        wp::adj_sub(var_22, var_62, adj_22, adj_62, adj_71);
        // adj: qd = wp.dot(child_velocity - parent_velocity, axis) + wp.dot(displacement, wp.cross(parent_omega, axis))  <L 84>
        wp::adj_dot(var_69, var_68, adj_69, adj_68, adj_70);
        // adj: q = wp.dot(displacement, axis)                                                    <L 83>
        wp::adj_sub(var_16, var_59, adj_16, adj_59, adj_69);
        // adj: displacement = child_origin - parent_origin                                       <L 82>
        wp::adj_div(var_64, var_65, adj_64, adj_65, adj_68);
        // adj: axis = axis_vector / axis_length                                                  <L 81>
        if (var_67) {
            label0:;
            // adj: return                                                                        <L 80>
        }
        // adj: if axis_length <= 1.0e-8:                                                         <L 79>
        wp::adj_length(var_64, var_65, adj_64, adj_65);
        // adj: axis_length = wp.length(axis_vector)                                              <L 78>
        wp::adj_sub(var_60, var_59, adj_60, adj_59, adj_64);
        // adj: axis_vector = parent_axis_point - parent_origin                                   <L 77>
        wp::adj_where(var_40, var_58, var_36, adj_40, adj_58, adj_36, adj_63);
        wp::adj_where(var_40, var_56, var_34, adj_40, adj_56, adj_34, adj_62);
        wp::adj_where(var_40, var_54, var_31, adj_40, adj_54, adj_31, adj_61);
        wp::adj_where(var_40, var_53, var_28, adj_40, adj_53, adj_28, adj_60);
        wp::adj_where(var_40, var_52, var_25, adj_40, adj_52, adj_25, adj_59);
        if (var_40) {
            wp::adj_spatial_bottom(var_50, adj_50, adj_58);
            // adj: parent_omega = wp.spatial_bottom(parent_twist)                                <L 75>
            adj__point_velocity_0(var_47, var_50, var_57, var_52, adj_47, adj_50, adj_55, adj_52, adj_56);
            wp::adj_address(var_body_com, var_44, adj_body_com, adj_44, adj_55);
            // adj: parent_velocity = _point_velocity(parent_pose, parent_twist, body_com[parent], parent_origin)  <L 74>
            wp::adj_transform_point(var_47, var_31, adj_47, adj_31, adj_54);
            // adj: parent_reference = wp.transform_point(parent_pose, parent_reference)          <L 73>
            wp::adj_transform_point(var_47, var_28, adj_47, adj_28, adj_53);
            // adj: parent_axis_point = wp.transform_point(parent_pose, parent_axis_point)        <L 72>
            wp::adj_transform_point(var_47, var_25, adj_47, adj_25, adj_52);
            // adj: parent_origin = wp.transform_point(parent_pose, parent_origin)                <L 71>
            wp::adj_copy(var_51, adj_49, adj_50);
            wp::adj_address(var_body_qd, var_44, adj_body_qd, adj_44, adj_49);
            // adj: parent_twist = body_qd[parent]                                                <L 70>
            wp::adj_copy(var_48, adj_46, adj_47);
            wp::adj_address(var_body_q, var_44, adj_body_q, adj_44, adj_46);
            // adj: parent_pose = body_q[parent]                                                  <L 69>
            wp::adj_copy(var_45, adj_43, adj_44);
            wp::adj_address(var_affine_body_ids, var_42, adj_affine_body_ids, adj_42, adj_43);
            wp::adj_extract(var_2, var_41, adj_2, adj_41, adj_42);
            // adj: parent = affine_body_ids[bodies[0]]                                           <L 68>
        }
        wp::adj_extract(var_2, var_37, adj_2, adj_37, adj_38);
        // adj: if bodies[0] >= 0:                                                                <L 67>
        wp::adj_vec_t(var_35, adj_35, adj_36);
        // adj: parent_omega = wp.vec3(0.0)                                                       <L 66>
        wp::adj_vec_t(var_33, adj_33, adj_34);
        // adj: parent_velocity = wp.vec3(0.0)                                                    <L 65>
        wp::adj_copy(var_32, adj_30, adj_31);
        wp::adj_address(var_parent_references, var_0, adj_parent_references, adj_0, adj_30);
        // adj: parent_reference = parent_references[drive]                                       <L 64>
        wp::adj_copy(var_29, adj_27, adj_28);
        wp::adj_address(var_parent_axis_points, var_0, adj_parent_axis_points, adj_0, adj_27);
        // adj: parent_axis_point = parent_axis_points[drive]                                     <L 63>
        wp::adj_copy(var_26, adj_24, adj_25);
        wp::adj_address(var_parent_origins, var_0, adj_parent_origins, adj_0, adj_24);
        // adj: parent_origin = parent_origins[drive]                                             <L 62>
        adj__point_velocity_0(var_10, var_13, var_23, var_16, adj_10, adj_13, adj_21, adj_16, adj_22);
        wp::adj_address(var_body_com, var_7, adj_body_com, adj_7, adj_21);
        // adj: child_velocity = _point_velocity(child_pose, child_twist, body_com[child], child_origin)  <L 60>
        wp::adj_transform_point(var_10, var_20, adj_10, adj_18, adj_19);
        wp::adj_address(var_child_references, var_0, adj_child_references, adj_0, adj_18);
        // adj: child_reference = wp.transform_point(child_pose, child_references[drive])         <L 59>
        wp::adj_transform_point(var_10, var_17, adj_10, adj_15, adj_16);
        wp::adj_address(var_child_origins, var_0, adj_child_origins, adj_0, adj_15);
        // adj: child_origin = wp.transform_point(child_pose, child_origins[drive])               <L 58>
        wp::adj_copy(var_14, adj_12, adj_13);
        wp::adj_address(var_body_qd, var_7, adj_body_qd, adj_7, adj_12);
        // adj: child_twist = body_qd[child]                                                      <L 57>
        wp::adj_copy(var_11, adj_9, adj_10);
        wp::adj_address(var_body_q, var_7, adj_body_q, adj_7, adj_9);
        // adj: child_pose = body_q[child]                                                        <L 56>
        wp::adj_copy(var_8, adj_6, adj_7);
        wp::adj_address(var_affine_body_ids, var_5, adj_affine_body_ids, adj_5, adj_6);
        wp::adj_extract(var_2, var_4, adj_2, adj_4, adj_5);
        // adj: child = affine_body_ids[bodies[1]]                                                <L 55>
        wp::adj_copy(var_3, adj_1, adj_2);
        wp::adj_address(var_drive_bodies, var_0, adj_drive_bodies, adj_0, adj_1);
        // adj: bodies = drive_bodies[drive]                                                      <L 54>
        // adj: drive = wp.tid()                                                                  <L 53>
        // adj: def evaluate_joint_drive_effort(                                                  <L 24>
        continue;
    }
}

