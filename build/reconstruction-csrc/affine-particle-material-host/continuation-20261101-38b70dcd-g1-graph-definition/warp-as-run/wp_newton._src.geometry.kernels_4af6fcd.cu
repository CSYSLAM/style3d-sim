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


struct HeightfieldData_f2b8d59a
{
    wp::int32 data_offset;
    wp::int32 nrow;
    wp::int32 ncol;
    wp::float32 hx;
    wp::float32 hy;
    wp::float32 min_z;
    wp::float32 max_z;


    HeightfieldData_f2b8d59a() = default;
    CUDA_CALLABLE HeightfieldData_f2b8d59a(wp::int32 const& data_offset,
    wp::int32 const& nrow = {},
    wp::int32 const& ncol = {},
    wp::float32 const& hx = {},
    wp::float32 const& hy = {},
    wp::float32 const& min_z = {},
    wp::float32 const& max_z = {})
        : data_offset{data_offset}
        , nrow{nrow}
        , ncol{ncol}
        , hx{hx}
        , hy{hy}
        , min_z{min_z}
        , max_z{max_z}

    {
    }

    CUDA_CALLABLE HeightfieldData_f2b8d59a& operator += (const HeightfieldData_f2b8d59a& rhs)
    {    data_offset += rhs.data_offset;
    nrow += rhs.nrow;
    ncol += rhs.ncol;
    hx += rhs.hx;
    hy += rhs.hy;
    min_z += rhs.min_z;
    max_z += rhs.max_z;

        return *this;}

};

static CUDA_CALLABLE void adj_HeightfieldData_f2b8d59a(wp::int32 const&,
    wp::int32 const&,
    wp::int32 const&,
    wp::float32 const&,
    wp::float32 const&,
    wp::float32 const&,
    wp::float32 const&,
    wp::int32 & adj_data_offset,
    wp::int32 & adj_nrow,
    wp::int32 & adj_ncol,
    wp::float32 & adj_hx,
    wp::float32 & adj_hy,
    wp::float32 & adj_min_z,
    wp::float32 & adj_max_z,
    HeightfieldData_f2b8d59a & adj_ret)
{
    adj_data_offset += adj_ret.data_offset;
    adj_nrow += adj_ret.nrow;
    adj_ncol += adj_ret.ncol;
    adj_hx += adj_ret.hx;
    adj_hy += adj_ret.hy;
    adj_min_z += adj_ret.min_z;
    adj_max_z += adj_ret.max_z;
}

// Required when compiling adjoints.
CUDA_CALLABLE HeightfieldData_f2b8d59a add(const HeightfieldData_f2b8d59a& a, const HeightfieldData_f2b8d59a& b)
{
    return HeightfieldData_f2b8d59a();
}

CUDA_CALLABLE void adj_atomic_add(HeightfieldData_f2b8d59a* p, HeightfieldData_f2b8d59a t)
{
    wp::adj_atomic_add(&p->data_offset, t.data_offset);
    wp::adj_atomic_add(&p->nrow, t.nrow);
    wp::adj_atomic_add(&p->ncol, t.ncol);
    wp::adj_atomic_add(&p->hx, t.hx);
    wp::adj_atomic_add(&p->hy, t.hy);
    wp::adj_atomic_add(&p->min_z, t.min_z);
    wp::adj_atomic_add(&p->max_z, t.max_z);
}




// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:1206
static CUDA_CALLABLE void compute_tri_aabb_0(
    wp::vec_t<3, wp::float32> var_v1,
    wp::vec_t<3, wp::float32> var_v2,
    wp::vec_t<3, wp::float32> var_v3,
    wp::vec_t<3, wp::float32> & ret_0,
    wp::vec_t<3, wp::float32> & ret_1)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    wp::vec_t<3, wp::float32> var_1;
    wp::vec_t<3, wp::float32> var_2;
    wp::vec_t<3, wp::float32> var_3;
    //---------
    // forward
    // def compute_tri_aabb(                                                                  <L 1207>
    // lower = wp.min(wp.min(v1, v2), v3)                                                     <L 1212>
    var_0 = wp::min(var_v1, var_v2);
    var_1 = wp::min(var_0, var_v3);
    // upper = wp.max(wp.max(v1, v2), v3)                                                     <L 1213>
    var_2 = wp::max(var_v1, var_v2);
    var_3 = wp::max(var_2, var_v3);
    // return lower, upper                                                                    <L 1215>
    ret_0 = var_1;
    ret_1 = var_3;
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:1305
static CUDA_CALLABLE bool vertex_adjacent_to_triangle_0(
    wp::int32 var_v,
    wp::int32 var_a,
    wp::int32 var_b,
    wp::int32 var_c)
{
    //---------
    // primal vars
    bool var_0;
    bool var_1;
    bool var_2;
    bool var_3;
    //---------
    // forward
    // def vertex_adjacent_to_triangle(v: wp.int32, a: wp.int32, b: wp.int32, c: wp.int32):       <L 1306>
    // return v == a or v == b or v == c                                                      <L 1307>
    var_1 = (var_v == var_a);
    var_0 = var_1;
    if (!var_0) {
        var_2 = (var_v == var_b);
        var_0 = var_0 || var_2;
    }
    if (!var_0) {
        var_3 = (var_v == var_c);
        var_0 = var_0 || var_3;
    }
    return var_0;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:180
static CUDA_CALLABLE wp::float32 sdf_sphere_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::float32 var_radius)
{
    //---------
    // primal vars
    wp::float32 var_0;
    wp::float32 var_1;
    //---------
    // forward
    // def sdf_sphere(point: wp.vec3, radius: float):                                         <L 181>
    // return wp.length(point) - radius                                                       <L 191>
    var_0 = wp::length(var_point);
    var_1 = wp::sub(var_0, var_radius);
    return var_1;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:194
static CUDA_CALLABLE wp::vec_t<3, wp::float32> sdf_sphere_grad_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::float32 var_radius)
{
    //---------
    // primal vars
    wp::float32 var_0;
    const wp::float32 var_1 = 1e-08;
    wp::float32 var_2;
    bool var_3;
    wp::vec_t<3, wp::float32> var_4;
    const wp::float32 var_5 = 0.0;
    const wp::float32 var_6 = 0.0;
    const wp::float32 var_7 = 1.0;
    wp::vec_t<3, wp::float32> var_8;
    //---------
    // forward
    // def sdf_sphere_grad(point: wp.vec3, radius: float):                                    <L 195>
    // _ = radius                                                                             <L 205>
    var_0 = wp::copy(var_radius);
    // eps = 1.0e-8                                                                           <L 206>
    // p_len = wp.length(point)                                                               <L 207>
    var_2 = wp::length(var_point);
    // if p_len > eps:                                                                        <L 208>
    var_3 = (var_2 > var_1);
    if (var_3) {
        // return point / p_len                                                               <L 209>
        var_4 = wp::div(var_point, var_2);
        return var_4;
    }
    // return wp.vec3(0.0, 0.0, 1.0)                                                          <L 210>
    var_8 = wp::vec_t<3, wp::float32>(var_5, var_6, var_7);
    return var_8;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:213
static CUDA_CALLABLE wp::float32 sdf_box_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::float32 var_hx,
    wp::float32 var_hy,
    wp::float32 var_hz)
{
    //---------
    // primal vars
    const wp::int32 var_0 = 0;
    wp::float32 var_1;
    wp::float32 var_2;
    wp::float32 var_3;
    const wp::int32 var_4 = 1;
    wp::float32 var_5;
    wp::float32 var_6;
    wp::float32 var_7;
    const wp::int32 var_8 = 2;
    wp::float32 var_9;
    wp::float32 var_10;
    wp::float32 var_11;
    const wp::float32 var_12 = 0.0;
    wp::float32 var_13;
    const wp::float32 var_14 = 0.0;
    wp::float32 var_15;
    const wp::float32 var_16 = 0.0;
    wp::float32 var_17;
    wp::vec_t<3, wp::float32> var_18;
    wp::float32 var_19;
    wp::float32 var_20;
    wp::float32 var_21;
    const wp::float32 var_22 = 0.0;
    wp::float32 var_23;
    wp::float32 var_24;
    //---------
    // forward
    // def sdf_box(point: wp.vec3, hx: float, hy: float, hz: float):                          <L 214>
    // qx = abs(point[0]) - hx                                                                <L 227>
    var_1 = wp::extract(var_point, var_0);
    var_2 = wp::abs(var_1);
    var_3 = wp::sub(var_2, var_hx);
    // qy = abs(point[1]) - hy                                                                <L 228>
    var_5 = wp::extract(var_point, var_4);
    var_6 = wp::abs(var_5);
    var_7 = wp::sub(var_6, var_hy);
    // qz = abs(point[2]) - hz                                                                <L 229>
    var_9 = wp::extract(var_point, var_8);
    var_10 = wp::abs(var_9);
    var_11 = wp::sub(var_10, var_hz);
    // e = wp.vec3(wp.max(qx, 0.0), wp.max(qy, 0.0), wp.max(qz, 0.0))                         <L 231>
    var_13 = wp::max(var_3, var_12);
    var_15 = wp::max(var_7, var_14);
    var_17 = wp::max(var_11, var_16);
    var_18 = wp::vec_t<3, wp::float32>(var_13, var_15, var_17);
    // return wp.length(e) + wp.min(wp.max(qx, wp.max(qy, qz)), 0.0)                          <L 233>
    var_19 = wp::length(var_18);
    var_20 = wp::max(var_7, var_11);
    var_21 = wp::max(var_3, var_20);
    var_23 = wp::min(var_21, var_22);
    var_24 = wp::add(var_19, var_23);
    return var_24;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:236
static CUDA_CALLABLE wp::vec_t<3, wp::float32> sdf_box_grad_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::float32 var_hx,
    wp::float32 var_hy,
    wp::float32 var_hz)
{
    //---------
    // primal vars
    const wp::int32 var_0 = 0;
    wp::float32 var_1;
    wp::float32 var_2;
    wp::float32 var_3;
    const wp::int32 var_4 = 1;
    wp::float32 var_5;
    wp::float32 var_6;
    wp::float32 var_7;
    const wp::int32 var_8 = 2;
    wp::float32 var_9;
    wp::float32 var_10;
    wp::float32 var_11;
    bool var_12;
    const wp::float32 var_13 = 0.0;
    bool var_14;
    const wp::float32 var_15 = 0.0;
    bool var_16;
    const wp::float32 var_17 = 0.0;
    bool var_18;
    const wp::int32 var_19 = 0;
    wp::float32 var_20;
    wp::float32 var_21;
    wp::float32 var_22;
    const wp::int32 var_23 = 1;
    wp::float32 var_24;
    wp::float32 var_25;
    wp::float32 var_26;
    const wp::int32 var_27 = 2;
    wp::float32 var_28;
    wp::float32 var_29;
    wp::float32 var_30;
    wp::vec_t<3, wp::float32> var_31;
    wp::vec_t<3, wp::float32> var_32;
    wp::vec_t<3, wp::float32> var_33;
    const wp::int32 var_34 = 0;
    wp::float32 var_35;
    wp::float32 var_36;
    const wp::int32 var_37 = 1;
    wp::float32 var_38;
    wp::float32 var_39;
    const wp::int32 var_40 = 2;
    wp::float32 var_41;
    wp::float32 var_42;
    bool var_43;
    bool var_44;
    bool var_45;
    bool var_46;
    bool var_47;
    const wp::float32 var_48 = 0.0;
    bool var_49;
    const wp::float32 var_50 = 0.0;
    bool var_51;
    const wp::float32 var_52 = 0.0;
    const wp::float32 var_53 = 0.0;
    wp::vec_t<3, wp::float32> var_54;
    bool var_55;
    bool var_56;
    bool var_57;
    bool var_58;
    bool var_59;
    const wp::float32 var_60 = 0.0;
    bool var_61;
    const wp::float32 var_62 = 0.0;
    bool var_63;
    const wp::float32 var_64 = 0.0;
    const wp::float32 var_65 = 0.0;
    wp::vec_t<3, wp::float32> var_66;
    const wp::float32 var_67 = 0.0;
    const wp::float32 var_68 = 0.0;
    wp::vec_t<3, wp::float32> var_69;
    //---------
    // forward
    // def sdf_box_grad(point: wp.vec3, hx: float, hy: float, hz: float):                     <L 237>
    // qx = abs(point[0]) - hx                                                                <L 249>
    var_1 = wp::extract(var_point, var_0);
    var_2 = wp::abs(var_1);
    var_3 = wp::sub(var_2, var_hx);
    // qy = abs(point[1]) - hy                                                                <L 250>
    var_5 = wp::extract(var_point, var_4);
    var_6 = wp::abs(var_5);
    var_7 = wp::sub(var_6, var_hy);
    // qz = abs(point[2]) - hz                                                                <L 251>
    var_9 = wp::extract(var_point, var_8);
    var_10 = wp::abs(var_9);
    var_11 = wp::sub(var_10, var_hz);
    // if qx > 0.0 or qy > 0.0 or qz > 0.0:                                                   <L 254>
    var_14 = (var_3 > var_13);
    var_12 = var_14;
    if (!var_12) {
        var_16 = (var_7 > var_15);
        var_12 = var_12 || var_16;
    }
    if (!var_12) {
        var_18 = (var_11 > var_17);
        var_12 = var_12 || var_18;
    }
    if (var_12) {
        // x = wp.clamp(point[0], -hx, hx)                                                    <L 255>
        var_20 = wp::extract(var_point, var_19);
        var_21 = wp::neg(var_hx);
        var_22 = wp::clamp(var_20, var_21, var_hx);
        // y = wp.clamp(point[1], -hy, hy)                                                    <L 256>
        var_24 = wp::extract(var_point, var_23);
        var_25 = wp::neg(var_hy);
        var_26 = wp::clamp(var_24, var_25, var_hy);
        // z = wp.clamp(point[2], -hz, hz)                                                    <L 257>
        var_28 = wp::extract(var_point, var_27);
        var_29 = wp::neg(var_hz);
        var_30 = wp::clamp(var_28, var_29, var_hz);
        // return wp.normalize(point - wp.vec3(x, y, z))                                      <L 259>
        var_31 = wp::vec_t<3, wp::float32>(var_22, var_26, var_30);
        var_32 = wp::sub(var_point, var_31);
        var_33 = wp::normalize(var_32);
        return var_33;
    }
    // sx = wp.sign(point[0])                                                                 <L 261>
    var_35 = wp::extract(var_point, var_34);
    var_36 = wp::sign(var_35);
    // sy = wp.sign(point[1])                                                                 <L 262>
    var_38 = wp::extract(var_point, var_37);
    var_39 = wp::sign(var_38);
    // sz = wp.sign(point[2])                                                                 <L 263>
    var_41 = wp::extract(var_point, var_40);
    var_42 = wp::sign(var_41);
    // if (qx > qy and qx > qz) or (qy == 0.0 and qz == 0.0):                                 <L 266>
    var_45 = (var_3 > var_7);
    var_44 = var_45;
    if (var_44) {
        var_46 = (var_3 > var_11);
        var_44 = var_44 && var_46;
    }
    var_43 = var_44;
    if (!var_43) {
        var_49 = (var_7 == var_48);
        var_47 = var_49;
        if (var_47) {
            var_51 = (var_11 == var_50);
            var_47 = var_47 && var_51;
        }
        var_43 = var_43 || var_47;
    }
    if (var_43) {
        // return wp.vec3(sx, 0.0, 0.0)                                                       <L 267>
        var_54 = wp::vec_t<3, wp::float32>(var_36, var_52, var_53);
        return var_54;
    }
    // if (qy > qx and qy > qz) or (qx == 0.0 and qz == 0.0):                                 <L 270>
    var_57 = (var_7 > var_3);
    var_56 = var_57;
    if (var_56) {
        var_58 = (var_7 > var_11);
        var_56 = var_56 && var_58;
    }
    var_55 = var_56;
    if (!var_55) {
        var_61 = (var_3 == var_60);
        var_59 = var_61;
        if (var_59) {
            var_63 = (var_11 == var_62);
            var_59 = var_59 && var_63;
        }
        var_55 = var_55 || var_59;
    }
    if (var_55) {
        // return wp.vec3(0.0, sy, 0.0)                                                       <L 271>
        var_66 = wp::vec_t<3, wp::float32>(var_64, var_39, var_65);
        return var_66;
    }
    // return wp.vec3(0.0, 0.0, sz)                                                           <L 274>
    var_69 = wp::vec_t<3, wp::float32>(var_67, var_68, var_42);
    return var_69;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:147
static CUDA_CALLABLE wp::vec_t<3, wp::float32> _sdf_point_to_z_up_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::int32 var_up_axis)
{
    //---------
    // primal vars
    const wp::int32 var_0 = 0;
    const wp::int32 var_1 = 0;
    wp::int32 var_2;
    bool var_3;
    const wp::int32 var_4 = 1;
    wp::float32 var_5;
    const wp::int32 var_6 = 2;
    wp::float32 var_7;
    const wp::int32 var_8 = 0;
    wp::float32 var_9;
    wp::vec_t<3, wp::float32> var_10;
    const wp::int32 var_11 = 1;
    const wp::int32 var_12 = 1;
    wp::int32 var_13;
    bool var_14;
    const wp::int32 var_15 = 0;
    wp::float32 var_16;
    const wp::int32 var_17 = 2;
    wp::float32 var_18;
    const wp::int32 var_19 = 1;
    wp::float32 var_20;
    wp::vec_t<3, wp::float32> var_21;
    //---------
    // forward
    // def _sdf_point_to_z_up(point: wp.vec3, up_axis: int):                                  <L 148>
    // if up_axis == int(Axis.X):                                                             <L 149>
    var_2 = wp::int(var_1);
    var_3 = (var_up_axis == var_2);
    if (var_3) {
        // return wp.vec3(point[1], point[2], point[0])                                       <L 150>
        var_5 = wp::extract(var_point, var_4);
        var_7 = wp::extract(var_point, var_6);
        var_9 = wp::extract(var_point, var_8);
        var_10 = wp::vec_t<3, wp::float32>(var_5, var_7, var_9);
        return var_10;
    }
    // if up_axis == int(Axis.Y):                                                             <L 151>
    var_13 = wp::int(var_12);
    var_14 = (var_up_axis == var_13);
    if (var_14) {
        // return wp.vec3(point[0], point[2], point[1])                                       <L 152>
        var_16 = wp::extract(var_point, var_15);
        var_18 = wp::extract(var_point, var_17);
        var_20 = wp::extract(var_point, var_19);
        var_21 = wp::vec_t<3, wp::float32>(var_16, var_18, var_20);
        return var_21;
    }
    // return point                                                                           <L 153>
    return var_point;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:277
static CUDA_CALLABLE wp::float32 sdf_capsule_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::float32 var_radius,
    wp::float32 var_half_height,
    wp::int32 var_up_axis)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    const wp::int32 var_1 = 2;
    wp::float32 var_2;
    bool var_3;
    const wp::int32 var_4 = 0;
    wp::float32 var_5;
    const wp::int32 var_6 = 1;
    wp::float32 var_7;
    const wp::int32 var_8 = 2;
    wp::float32 var_9;
    wp::float32 var_10;
    wp::vec_t<3, wp::float32> var_11;
    wp::float32 var_12;
    wp::float32 var_13;
    const wp::int32 var_14 = 2;
    wp::float32 var_15;
    wp::float32 var_16;
    bool var_17;
    const wp::int32 var_18 = 0;
    wp::float32 var_19;
    const wp::int32 var_20 = 1;
    wp::float32 var_21;
    const wp::int32 var_22 = 2;
    wp::float32 var_23;
    wp::float32 var_24;
    wp::vec_t<3, wp::float32> var_25;
    wp::float32 var_26;
    wp::float32 var_27;
    const wp::int32 var_28 = 0;
    wp::float32 var_29;
    const wp::int32 var_30 = 1;
    wp::float32 var_31;
    const wp::float32 var_32 = 0.0;
    wp::vec_t<3, wp::float32> var_33;
    wp::float32 var_34;
    wp::float32 var_35;
    //---------
    // forward
    // def sdf_capsule(point: wp.vec3, radius: float, half_height: float, up_axis: int = int(Axis.Y)):       <L 278>
    // point_z_up = _sdf_point_to_z_up(point, up_axis)                                        <L 290>
    var_0 = _sdf_point_to_z_up_0(var_point, var_up_axis);
    // if point_z_up[2] > half_height:                                                        <L 291>
    var_2 = wp::extract(var_0, var_1);
    var_3 = (var_2 > var_half_height);
    if (var_3) {
        // return wp.length(wp.vec3(point_z_up[0], point_z_up[1], point_z_up[2] - half_height)) - radius       <L 292>
        var_5 = wp::extract(var_0, var_4);
        var_7 = wp::extract(var_0, var_6);
        var_9 = wp::extract(var_0, var_8);
        var_10 = wp::sub(var_9, var_half_height);
        var_11 = wp::vec_t<3, wp::float32>(var_5, var_7, var_10);
        var_12 = wp::length(var_11);
        var_13 = wp::sub(var_12, var_radius);
        return var_13;
    }
    // if point_z_up[2] < -half_height:                                                       <L 294>
    var_15 = wp::extract(var_0, var_14);
    var_16 = wp::neg(var_half_height);
    var_17 = (var_15 < var_16);
    if (var_17) {
        // return wp.length(wp.vec3(point_z_up[0], point_z_up[1], point_z_up[2] + half_height)) - radius       <L 295>
        var_19 = wp::extract(var_0, var_18);
        var_21 = wp::extract(var_0, var_20);
        var_23 = wp::extract(var_0, var_22);
        var_24 = wp::add(var_23, var_half_height);
        var_25 = wp::vec_t<3, wp::float32>(var_19, var_21, var_24);
        var_26 = wp::length(var_25);
        var_27 = wp::sub(var_26, var_radius);
        return var_27;
    }
    // return wp.length(wp.vec3(point_z_up[0], point_z_up[1], 0.0)) - radius                  <L 297>
    var_29 = wp::extract(var_0, var_28);
    var_31 = wp::extract(var_0, var_30);
    var_33 = wp::vec_t<3, wp::float32>(var_29, var_31, var_32);
    var_34 = wp::length(var_33);
    var_35 = wp::sub(var_34, var_radius);
    return var_35;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:300
static CUDA_CALLABLE wp::vec_t<3, wp::float32> _sdf_vector_from_z_up_0(
    wp::vec_t<3, wp::float32> var_v,
    wp::int32 var_up_axis)
{
    //---------
    // primal vars
    const wp::int32 var_0 = 0;
    const wp::int32 var_1 = 0;
    wp::int32 var_2;
    bool var_3;
    const wp::int32 var_4 = 2;
    wp::float32 var_5;
    const wp::int32 var_6 = 0;
    wp::float32 var_7;
    const wp::int32 var_8 = 1;
    wp::float32 var_9;
    wp::vec_t<3, wp::float32> var_10;
    const wp::int32 var_11 = 1;
    const wp::int32 var_12 = 1;
    wp::int32 var_13;
    bool var_14;
    const wp::int32 var_15 = 0;
    wp::float32 var_16;
    const wp::int32 var_17 = 2;
    wp::float32 var_18;
    const wp::int32 var_19 = 1;
    wp::float32 var_20;
    wp::vec_t<3, wp::float32> var_21;
    //---------
    // forward
    // def _sdf_vector_from_z_up(v: wp.vec3, up_axis: int):                                   <L 301>
    // if up_axis == int(Axis.X):                                                             <L 302>
    var_2 = wp::int(var_1);
    var_3 = (var_up_axis == var_2);
    if (var_3) {
        // return wp.vec3(v[2], v[0], v[1])                                                   <L 303>
        var_5 = wp::extract(var_v, var_4);
        var_7 = wp::extract(var_v, var_6);
        var_9 = wp::extract(var_v, var_8);
        var_10 = wp::vec_t<3, wp::float32>(var_5, var_7, var_9);
        return var_10;
    }
    // if up_axis == int(Axis.Y):                                                             <L 304>
    var_13 = wp::int(var_12);
    var_14 = (var_up_axis == var_13);
    if (var_14) {
        // return wp.vec3(v[0], v[2], v[1])                                                   <L 305>
        var_16 = wp::extract(var_v, var_15);
        var_18 = wp::extract(var_v, var_17);
        var_20 = wp::extract(var_v, var_19);
        var_21 = wp::vec_t<3, wp::float32>(var_16, var_18, var_20);
        return var_21;
    }
    // return v                                                                               <L 306>
    return var_v;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:309
static CUDA_CALLABLE wp::vec_t<3, wp::float32> sdf_capsule_grad_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::float32 var_radius,
    wp::float32 var_half_height,
    wp::int32 var_up_axis)
{
    //---------
    // primal vars
    wp::float32 var_0;
    const wp::float32 var_1 = 1e-08;
    wp::vec_t<3, wp::float32> var_2;
    wp::vec_t<3, wp::float32> var_3;
    const wp::int32 var_4 = 2;
    wp::float32 var_5;
    bool var_6;
    const wp::int32 var_7 = 0;
    wp::float32 var_8;
    const wp::int32 var_9 = 1;
    wp::float32 var_10;
    const wp::int32 var_11 = 2;
    wp::float32 var_12;
    wp::float32 var_13;
    wp::vec_t<3, wp::float32> var_14;
    wp::float32 var_15;
    const wp::float32 var_16 = 0.0;
    const wp::float32 var_17 = 0.0;
    const wp::float32 var_18 = 1.0;
    wp::vec_t<3, wp::float32> var_19;
    bool var_20;
    wp::vec_t<3, wp::float32> var_21;
    wp::vec_t<3, wp::float32> var_22;
    const wp::int32 var_23 = 2;
    wp::float32 var_24;
    wp::float32 var_25;
    bool var_26;
    const wp::int32 var_27 = 0;
    wp::float32 var_28;
    const wp::int32 var_29 = 1;
    wp::float32 var_30;
    const wp::int32 var_31 = 2;
    wp::float32 var_32;
    wp::float32 var_33;
    wp::vec_t<3, wp::float32> var_34;
    wp::float32 var_35;
    const wp::float32 var_36 = 0.0;
    const wp::float32 var_37 = 0.0;
    const wp::float32 var_38 = -1.0;
    wp::vec_t<3, wp::float32> var_39;
    bool var_40;
    wp::vec_t<3, wp::float32> var_41;
    wp::vec_t<3, wp::float32> var_42;
    const wp::int32 var_43 = 0;
    wp::float32 var_44;
    const wp::int32 var_45 = 1;
    wp::float32 var_46;
    const wp::float32 var_47 = 0.0;
    wp::vec_t<3, wp::float32> var_48;
    wp::float32 var_49;
    const wp::float32 var_50 = 0.0;
    const wp::float32 var_51 = 0.0;
    const wp::float32 var_52 = 1.0;
    wp::vec_t<3, wp::float32> var_53;
    bool var_54;
    wp::vec_t<3, wp::float32> var_55;
    wp::vec_t<3, wp::float32> var_56;
    wp::vec_t<3, wp::float32> var_57;
    wp::vec_t<3, wp::float32> var_58;
    wp::float32 var_59;
    wp::vec_t<3, wp::float32> var_60;
    wp::vec_t<3, wp::float32> var_61;
    wp::float32 var_62;
    wp::vec_t<3, wp::float32> var_63;
    //---------
    // forward
    // def sdf_capsule_grad(point: wp.vec3, radius: float, half_height: float, up_axis: int = int(Axis.Y)):       <L 310>
    // _ = radius                                                                             <L 322>
    var_0 = wp::copy(var_radius);
    // eps = 1.0e-8                                                                           <L 323>
    // point_z_up = _sdf_point_to_z_up(point, up_axis)                                        <L 324>
    var_2 = _sdf_point_to_z_up_0(var_point, var_up_axis);
    // grad_z_up = wp.vec3()                                                                  <L 325>
    var_3 = wp::vec_t<3, wp::float32>();
    // if point_z_up[2] > half_height:                                                        <L 326>
    var_5 = wp::extract(var_2, var_4);
    var_6 = (var_5 > var_half_height);
    if (var_6) {
        // v = wp.vec3(point_z_up[0], point_z_up[1], point_z_up[2] - half_height)             <L 327>
        var_8 = wp::extract(var_2, var_7);
        var_10 = wp::extract(var_2, var_9);
        var_12 = wp::extract(var_2, var_11);
        var_13 = wp::sub(var_12, var_half_height);
        var_14 = wp::vec_t<3, wp::float32>(var_8, var_10, var_13);
        // v_len = wp.length(v)                                                               <L 328>
        var_15 = wp::length(var_14);
        // grad_z_up = wp.vec3(0.0, 0.0, 1.0)                                                 <L 329>
        var_19 = wp::vec_t<3, wp::float32>(var_16, var_17, var_18);
        // if v_len > eps:                                                                    <L 330>
        var_20 = (var_15 > var_1);
        if (var_20) {
            // grad_z_up = v / v_len                                                          <L 331>
            var_21 = wp::div(var_14, var_15);
        }
        var_22 = wp::where(var_20, var_21, var_19);
    }
    if (!var_6) {
        // elif point_z_up[2] < -half_height:                                                 <L 332>
        var_24 = wp::extract(var_2, var_23);
        var_25 = wp::neg(var_half_height);
        var_26 = (var_24 < var_25);
        if (var_26) {
            // v = wp.vec3(point_z_up[0], point_z_up[1], point_z_up[2] + half_height)         <L 333>
            var_28 = wp::extract(var_2, var_27);
            var_30 = wp::extract(var_2, var_29);
            var_32 = wp::extract(var_2, var_31);
            var_33 = wp::add(var_32, var_half_height);
            var_34 = wp::vec_t<3, wp::float32>(var_28, var_30, var_33);
            // v_len = wp.length(v)                                                           <L 334>
            var_35 = wp::length(var_34);
            // grad_z_up = wp.vec3(0.0, 0.0, -1.0)                                            <L 335>
            var_39 = wp::vec_t<3, wp::float32>(var_36, var_37, var_38);
            // if v_len > eps:                                                                <L 336>
            var_40 = (var_35 > var_1);
            if (var_40) {
                // grad_z_up = v / v_len                                                      <L 337>
                var_41 = wp::div(var_34, var_35);
            }
            var_42 = wp::where(var_40, var_41, var_39);
        }
        if (!var_26) {
            // v = wp.vec3(point_z_up[0], point_z_up[1], 0.0)                                 <L 339>
            var_44 = wp::extract(var_2, var_43);
            var_46 = wp::extract(var_2, var_45);
            var_48 = wp::vec_t<3, wp::float32>(var_44, var_46, var_47);
            // v_len = wp.length(v)                                                           <L 340>
            var_49 = wp::length(var_48);
            // grad_z_up = wp.vec3(0.0, 0.0, 1.0)                                             <L 341>
            var_53 = wp::vec_t<3, wp::float32>(var_50, var_51, var_52);
            // if v_len > eps:                                                                <L 342>
            var_54 = (var_49 > var_1);
            if (var_54) {
                // grad_z_up = v / v_len                                                      <L 343>
                var_55 = wp::div(var_48, var_49);
            }
            var_56 = wp::where(var_54, var_55, var_53);
        }
        var_57 = wp::where(var_26, var_42, var_56);
        var_58 = wp::where(var_26, var_34, var_48);
        var_59 = wp::where(var_26, var_35, var_49);
    }
    var_60 = wp::where(var_6, var_22, var_57);
    var_61 = wp::where(var_6, var_14, var_58);
    var_62 = wp::where(var_6, var_15, var_59);
    // return _sdf_vector_from_z_up(grad_z_up, up_axis)                                       <L 344>
    var_63 = _sdf_vector_from_z_up_0(var_60, var_up_axis);
    return var_63;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:156
static CUDA_CALLABLE wp::float32 _sdf_capped_cone_z_0(
    wp::float32 var_bottom_radius,
    wp::float32 var_top_radius,
    wp::float32 var_half_height,
    wp::vec_t<3, wp::float32> var_point_z_up)
{
    //---------
    // primal vars
    const wp::int32 var_0 = 0;
    wp::float32 var_1;
    const wp::int32 var_2 = 1;
    wp::float32 var_3;
    wp::vec_t<2, wp::float32> var_4;
    wp::float32 var_5;
    const wp::int32 var_6 = 2;
    wp::float32 var_7;
    wp::vec_t<2, wp::float32> var_8;
    wp::vec_t<2, wp::float32> var_9;
    wp::float32 var_10;
    const wp::float32 var_11 = 2.0;
    wp::float32 var_12;
    wp::vec_t<2, wp::float32> var_13;
    const wp::int32 var_14 = 1;
    wp::float32 var_15;
    const wp::float32 var_16 = 0.0;
    bool var_17;
    const wp::int32 var_18 = 0;
    wp::float32 var_19;
    const wp::int32 var_20 = 0;
    wp::float32 var_21;
    wp::float32 var_22;
    wp::float32 var_23;
    const wp::int32 var_24 = 1;
    wp::float32 var_25;
    wp::float32 var_26;
    wp::float32 var_27;
    wp::vec_t<2, wp::float32> var_28;
    const wp::int32 var_29 = 0;
    wp::float32 var_30;
    const wp::int32 var_31 = 0;
    wp::float32 var_32;
    wp::float32 var_33;
    wp::float32 var_34;
    const wp::int32 var_35 = 1;
    wp::float32 var_36;
    wp::float32 var_37;
    wp::float32 var_38;
    wp::vec_t<2, wp::float32> var_39;
    wp::vec_t<2, wp::float32> var_40;
    wp::float32 var_41;
    const wp::float32 var_42 = 0.0;
    const wp::float32 var_43 = 0.0;
    bool var_44;
    wp::vec_t<2, wp::float32> var_45;
    wp::float32 var_46;
    wp::float32 var_47;
    const wp::float32 var_48 = 0.0;
    const wp::float32 var_49 = 1.0;
    wp::float32 var_50;
    wp::float32 var_51;
    wp::vec_t<2, wp::float32> var_52;
    wp::vec_t<2, wp::float32> var_53;
    wp::vec_t<2, wp::float32> var_54;
    const wp::float32 var_55 = 1.0;
    bool var_56;
    const wp::int32 var_57 = 0;
    wp::float32 var_58;
    const wp::float32 var_59 = 0.0;
    bool var_60;
    const wp::int32 var_61 = 1;
    wp::float32 var_62;
    const wp::float32 var_63 = 0.0;
    bool var_64;
    const wp::float32 var_65 = -1.0;
    wp::float32 var_66;
    wp::float32 var_67;
    wp::float32 var_68;
    wp::float32 var_69;
    wp::float32 var_70;
    wp::float32 var_71;
    //---------
    // forward
    // def _sdf_capped_cone_z(bottom_radius: float, top_radius: float, half_height: float, point_z_up: wp.vec3):       <L 157>
    // q = wp.vec2(wp.length(wp.vec2(point_z_up[0], point_z_up[1])), point_z_up[2])           <L 158>
    var_1 = wp::extract(var_point_z_up, var_0);
    var_3 = wp::extract(var_point_z_up, var_2);
    var_4 = wp::vec_t<2, wp::float32>(var_1, var_3);
    var_5 = wp::length(var_4);
    var_7 = wp::extract(var_point_z_up, var_6);
    var_8 = wp::vec_t<2, wp::float32>(var_5, var_7);
    // k1 = wp.vec2(top_radius, half_height)                                                  <L 159>
    var_9 = wp::vec_t<2, wp::float32>(var_top_radius, var_half_height);
    // k2 = wp.vec2(top_radius - bottom_radius, 2.0 * half_height)                            <L 160>
    var_10 = wp::sub(var_top_radius, var_bottom_radius);
    var_12 = wp::mul(var_11, var_half_height);
    var_13 = wp::vec_t<2, wp::float32>(var_10, var_12);
    // if q[1] < 0.0:                                                                         <L 162>
    var_15 = wp::extract(var_8, var_14);
    var_17 = (var_15 < var_16);
    if (var_17) {
        // ca = wp.vec2(q[0] - wp.min(q[0], bottom_radius), wp.abs(q[1]) - half_height)       <L 163>
        var_19 = wp::extract(var_8, var_18);
        var_21 = wp::extract(var_8, var_20);
        var_22 = wp::min(var_21, var_bottom_radius);
        var_23 = wp::sub(var_19, var_22);
        var_25 = wp::extract(var_8, var_24);
        var_26 = wp::abs(var_25);
        var_27 = wp::sub(var_26, var_half_height);
        var_28 = wp::vec_t<2, wp::float32>(var_23, var_27);
    }
    if (!var_17) {
        // ca = wp.vec2(q[0] - wp.min(q[0], top_radius), wp.abs(q[1]) - half_height)          <L 165>
        var_30 = wp::extract(var_8, var_29);
        var_32 = wp::extract(var_8, var_31);
        var_33 = wp::min(var_32, var_top_radius);
        var_34 = wp::sub(var_30, var_33);
        var_36 = wp::extract(var_8, var_35);
        var_37 = wp::abs(var_36);
        var_38 = wp::sub(var_37, var_half_height);
        var_39 = wp::vec_t<2, wp::float32>(var_34, var_38);
    }
    var_40 = wp::where(var_17, var_28, var_39);
    // denom = wp.dot(k2, k2)                                                                 <L 167>
    var_41 = wp::dot(var_13, var_13);
    // t = 0.0                                                                                <L 168>
    // if denom > 0.0:                                                                        <L 169>
    var_44 = (var_41 > var_43);
    if (var_44) {
        // t = wp.clamp(wp.dot(k1 - q, k2) / denom, 0.0, 1.0)                                 <L 170>
        var_45 = wp::sub(var_9, var_8);
        var_46 = wp::dot(var_45, var_13);
        var_47 = wp::div(var_46, var_41);
        var_50 = wp::clamp(var_47, var_48, var_49);
    }
    var_51 = wp::where(var_44, var_50, var_42);
    // cb = q - k1 + k2 * t                                                                   <L 171>
    var_52 = wp::sub(var_8, var_9);
    var_53 = wp::mul(var_13, var_51);
    var_54 = wp::add(var_52, var_53);
    // sign = 1.0                                                                             <L 173>
    // if cb[0] < 0.0 and ca[1] < 0.0:                                                        <L 174>
    var_58 = wp::extract(var_54, var_57);
    var_60 = (var_58 < var_59);
    var_56 = var_60;
    if (var_56) {
        var_62 = wp::extract(var_40, var_61);
        var_64 = (var_62 < var_63);
        var_56 = var_56 && var_64;
    }
    if (var_56) {
        // sign = -1.0                                                                        <L 175>
    }
    var_66 = wp::where(var_56, var_65, var_55);
    // return sign * wp.sqrt(wp.min(wp.dot(ca, ca), wp.dot(cb, cb)))                          <L 177>
    var_67 = wp::dot(var_40, var_40);
    var_68 = wp::dot(var_54, var_54);
    var_69 = wp::min(var_67, var_68);
    var_70 = wp::sqrt(var_69);
    var_71 = wp::mul(var_66, var_70);
    return var_71;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:347
static CUDA_CALLABLE wp::float32 sdf_cylinder_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::float32 var_radius,
    wp::float32 var_half_height,
    wp::int32 var_up_axis,
    wp::float32 var_top_radius)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    bool var_1;
    const wp::float32 var_2 = 0.0;
    bool var_3;
    wp::float32 var_4;
    wp::float32 var_5;
    const wp::float32 var_6 = 1e-06;
    bool var_7;
    const wp::int32 var_8 = 0;
    wp::float32 var_9;
    const wp::int32 var_10 = 1;
    wp::float32 var_11;
    const wp::float32 var_12 = 0.0;
    wp::vec_t<3, wp::float32> var_13;
    wp::float32 var_14;
    wp::float32 var_15;
    const wp::int32 var_16 = 2;
    wp::float32 var_17;
    wp::float32 var_18;
    wp::float32 var_19;
    wp::float32 var_20;
    const wp::float32 var_21 = 0.0;
    wp::float32 var_22;
    const wp::float32 var_23 = 0.0;
    wp::float32 var_24;
    const wp::float32 var_25 = 0.0;
    wp::float32 var_26;
    wp::vec_t<2, wp::float32> var_27;
    wp::float32 var_28;
    wp::float32 var_29;
    wp::float32 var_30;
    //---------
    // forward
    // def sdf_cylinder(                                                                      <L 348>
    // point_z_up = _sdf_point_to_z_up(point, up_axis)                                        <L 367>
    var_0 = _sdf_point_to_z_up_0(var_point, var_up_axis);
    // if top_radius < 0.0 or wp.abs(top_radius - radius) <= 1.0e-6:                          <L 368>
    var_3 = (var_top_radius < var_2);
    var_1 = var_3;
    if (!var_1) {
        var_4 = wp::sub(var_top_radius, var_radius);
        var_5 = wp::abs(var_4);
        var_7 = (var_5 <= var_6);
        var_1 = var_1 || var_7;
    }
    if (var_1) {
        // dx = wp.length(wp.vec3(point_z_up[0], point_z_up[1], 0.0)) - radius                <L 369>
        var_9 = wp::extract(var_0, var_8);
        var_11 = wp::extract(var_0, var_10);
        var_13 = wp::vec_t<3, wp::float32>(var_9, var_11, var_12);
        var_14 = wp::length(var_13);
        var_15 = wp::sub(var_14, var_radius);
        // dy = wp.abs(point_z_up[2]) - half_height                                           <L 370>
        var_17 = wp::extract(var_0, var_16);
        var_18 = wp::abs(var_17);
        var_19 = wp::sub(var_18, var_half_height);
        // return wp.min(wp.max(dx, dy), 0.0) + wp.length(wp.vec2(wp.max(dx, 0.0), wp.max(dy, 0.0)))       <L 371>
        var_20 = wp::max(var_15, var_19);
        var_22 = wp::min(var_20, var_21);
        var_24 = wp::max(var_15, var_23);
        var_26 = wp::max(var_19, var_25);
        var_27 = wp::vec_t<2, wp::float32>(var_24, var_26);
        var_28 = wp::length(var_27);
        var_29 = wp::add(var_22, var_28);
        return var_29;
    }
    // return _sdf_capped_cone_z(radius, top_radius, half_height, point_z_up)                 <L 372>
    var_30 = _sdf_capped_cone_z_0(var_radius, var_top_radius, var_half_height, var_0);
    return var_30;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:375
static CUDA_CALLABLE wp::vec_t<3, wp::float32> sdf_cylinder_grad_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::float32 var_radius,
    wp::float32 var_half_height,
    wp::int32 var_up_axis,
    wp::float32 var_top_radius)
{
    //---------
    // primal vars
    const wp::float32 var_0 = 1e-08;
    wp::vec_t<3, wp::float32> var_1;
    bool var_2;
    const wp::float32 var_3 = 0.0;
    bool var_4;
    wp::float32 var_5;
    wp::float32 var_6;
    const wp::float32 var_7 = 1e-06;
    bool var_8;
    const wp::float32 var_9 = 0.0001;
    const wp::float32 var_10 = 0.0;
    const wp::float32 var_11 = 0.0;
    wp::vec_t<3, wp::float32> var_12;
    wp::vec_t<3, wp::float32> var_13;
    wp::float32 var_14;
    const wp::float32 var_15 = 0.0;
    const wp::float32 var_16 = 0.0;
    wp::vec_t<3, wp::float32> var_17;
    wp::vec_t<3, wp::float32> var_18;
    wp::float32 var_19;
    wp::float32 var_20;
    const wp::float32 var_21 = 0.0;
    const wp::float32 var_22 = 0.0;
    wp::vec_t<3, wp::float32> var_23;
    wp::vec_t<3, wp::float32> var_24;
    wp::float32 var_25;
    const wp::float32 var_26 = 0.0;
    const wp::float32 var_27 = 0.0;
    wp::vec_t<3, wp::float32> var_28;
    wp::vec_t<3, wp::float32> var_29;
    wp::float32 var_30;
    wp::float32 var_31;
    const wp::float32 var_32 = 0.0;
    const wp::float32 var_33 = 0.0;
    wp::vec_t<3, wp::float32> var_34;
    wp::vec_t<3, wp::float32> var_35;
    wp::float32 var_36;
    const wp::float32 var_37 = 0.0;
    const wp::float32 var_38 = 0.0;
    wp::vec_t<3, wp::float32> var_39;
    wp::vec_t<3, wp::float32> var_40;
    wp::float32 var_41;
    wp::float32 var_42;
    wp::vec_t<3, wp::float32> var_43;
    wp::float32 var_44;
    bool var_45;
    wp::vec_t<3, wp::float32> var_46;
    const wp::float32 var_47 = 0.0;
    const wp::float32 var_48 = 0.0;
    const wp::float32 var_49 = 1.0;
    wp::vec_t<3, wp::float32> var_50;
    wp::vec_t<3, wp::float32> var_51;
    wp::vec_t<3, wp::float32> var_52;
    const wp::int32 var_53 = 0;
    wp::float32 var_54;
    const wp::int32 var_55 = 1;
    wp::float32 var_56;
    const wp::float32 var_57 = 0.0;
    wp::vec_t<3, wp::float32> var_58;
    wp::float32 var_59;
    const wp::float32 var_60 = 0.0;
    const wp::float32 var_61 = 0.0;
    const wp::float32 var_62 = 1.0;
    wp::vec_t<3, wp::float32> var_63;
    bool var_64;
    wp::vec_t<3, wp::float32> var_65;
    wp::vec_t<3, wp::float32> var_66;
    const wp::float32 var_67 = 0.0;
    const wp::float32 var_68 = 0.0;
    const wp::int32 var_69 = 2;
    wp::float32 var_70;
    wp::float32 var_71;
    wp::vec_t<3, wp::float32> var_72;
    wp::float32 var_73;
    const wp::int32 var_74 = 2;
    wp::float32 var_75;
    wp::float32 var_76;
    wp::float32 var_77;
    wp::vec_t<3, wp::float32> var_78;
    bool var_79;
    const wp::float32 var_80 = 0.0;
    bool var_81;
    const wp::float32 var_82 = 0.0;
    bool var_83;
    wp::vec_t<3, wp::float32> var_84;
    wp::vec_t<3, wp::float32> var_85;
    wp::vec_t<3, wp::float32> var_86;
    wp::float32 var_87;
    bool var_88;
    wp::vec_t<3, wp::float32> var_89;
    wp::vec_t<3, wp::float32> var_90;
    wp::vec_t<3, wp::float32> var_91;
    bool var_92;
    wp::vec_t<3, wp::float32> var_93;
    wp::vec_t<3, wp::float32> var_94;
    wp::vec_t<3, wp::float32> var_95;
    wp::vec_t<3, wp::float32> var_96;
    wp::vec_t<3, wp::float32> var_97;
    //---------
    // forward
    // def sdf_cylinder_grad(                                                                 <L 376>
    // eps = 1.0e-8                                                                           <L 395>
    // point_z_up = _sdf_point_to_z_up(point, up_axis)                                        <L 396>
    var_1 = _sdf_point_to_z_up_0(var_point, var_up_axis);
    // if top_radius >= 0.0 and wp.abs(top_radius - radius) > 1.0e-6:                         <L 397>
    var_4 = (var_top_radius >= var_3);
    var_2 = var_4;
    if (var_2) {
        var_5 = wp::sub(var_top_radius, var_radius);
        var_6 = wp::abs(var_5);
        var_8 = (var_6 > var_7);
        var_2 = var_2 && var_8;
    }
    if (var_2) {
        // fd_eps = 1.0e-4                                                                    <L 399>
        // dx = _sdf_capped_cone_z(                                                           <L 400>
        // radius,                                                                            <L 401>
        // top_radius,                                                                        <L 402>
        // half_height,                                                                       <L 403>
        // point_z_up + wp.vec3(fd_eps, 0.0, 0.0),                                            <L 404>
        var_12 = wp::vec_t<3, wp::float32>(var_9, var_10, var_11);
        var_13 = wp::add(var_1, var_12);
        var_14 = _sdf_capped_cone_z_0(var_radius, var_top_radius, var_half_height, var_13);
        // ) - _sdf_capped_cone_z(                                                            <L 405>
        // radius,                                                                            <L 406>
        // top_radius,                                                                        <L 407>
        // half_height,                                                                       <L 408>
        // point_z_up - wp.vec3(fd_eps, 0.0, 0.0),                                            <L 409>
        var_17 = wp::vec_t<3, wp::float32>(var_9, var_15, var_16);
        var_18 = wp::sub(var_1, var_17);
        var_19 = _sdf_capped_cone_z_0(var_radius, var_top_radius, var_half_height, var_18);
        var_20 = wp::sub(var_14, var_19);
        // dy = _sdf_capped_cone_z(                                                           <L 411>
        // radius,                                                                            <L 412>
        // top_radius,                                                                        <L 413>
        // half_height,                                                                       <L 414>
        // point_z_up + wp.vec3(0.0, fd_eps, 0.0),                                            <L 415>
        var_23 = wp::vec_t<3, wp::float32>(var_21, var_9, var_22);
        var_24 = wp::add(var_1, var_23);
        var_25 = _sdf_capped_cone_z_0(var_radius, var_top_radius, var_half_height, var_24);
        // ) - _sdf_capped_cone_z(                                                            <L 416>
        // radius,                                                                            <L 417>
        // top_radius,                                                                        <L 418>
        // half_height,                                                                       <L 419>
        // point_z_up - wp.vec3(0.0, fd_eps, 0.0),                                            <L 420>
        var_28 = wp::vec_t<3, wp::float32>(var_26, var_9, var_27);
        var_29 = wp::sub(var_1, var_28);
        var_30 = _sdf_capped_cone_z_0(var_radius, var_top_radius, var_half_height, var_29);
        var_31 = wp::sub(var_25, var_30);
        // dz = _sdf_capped_cone_z(                                                           <L 422>
        // radius,                                                                            <L 423>
        // top_radius,                                                                        <L 424>
        // half_height,                                                                       <L 425>
        // point_z_up + wp.vec3(0.0, 0.0, fd_eps),                                            <L 426>
        var_34 = wp::vec_t<3, wp::float32>(var_32, var_33, var_9);
        var_35 = wp::add(var_1, var_34);
        var_36 = _sdf_capped_cone_z_0(var_radius, var_top_radius, var_half_height, var_35);
        // ) - _sdf_capped_cone_z(                                                            <L 427>
        // radius,                                                                            <L 428>
        // top_radius,                                                                        <L 429>
        // half_height,                                                                       <L 430>
        // point_z_up - wp.vec3(0.0, 0.0, fd_eps),                                            <L 431>
        var_39 = wp::vec_t<3, wp::float32>(var_37, var_38, var_9);
        var_40 = wp::sub(var_1, var_39);
        var_41 = _sdf_capped_cone_z_0(var_radius, var_top_radius, var_half_height, var_40);
        var_42 = wp::sub(var_36, var_41);
        // grad_z_up = wp.vec3(dx, dy, dz)                                                    <L 433>
        var_43 = wp::vec_t<3, wp::float32>(var_20, var_31, var_42);
        // grad_len = wp.length(grad_z_up)                                                    <L 434>
        var_44 = wp::length(var_43);
        // if grad_len > eps:                                                                 <L 435>
        var_45 = (var_44 > var_0);
        if (var_45) {
            // grad_z_up = grad_z_up / grad_len                                               <L 436>
            var_46 = wp::div(var_43, var_44);
        }
        if (!var_45) {
            // grad_z_up = wp.vec3(0.0, 0.0, 1.0)                                             <L 438>
            var_50 = wp::vec_t<3, wp::float32>(var_47, var_48, var_49);
        }
        var_51 = wp::where(var_45, var_46, var_50);
        // return _sdf_vector_from_z_up(grad_z_up, up_axis)                                   <L 439>
        var_52 = _sdf_vector_from_z_up_0(var_51, var_up_axis);
        return var_52;
    }
    // v = wp.vec3(point_z_up[0], point_z_up[1], 0.0)                                         <L 441>
    var_54 = wp::extract(var_1, var_53);
    var_56 = wp::extract(var_1, var_55);
    var_58 = wp::vec_t<3, wp::float32>(var_54, var_56, var_57);
    // v_len = wp.length(v)                                                                   <L 442>
    var_59 = wp::length(var_58);
    // radial = wp.vec3(0.0, 0.0, 1.0)                                                        <L 443>
    var_63 = wp::vec_t<3, wp::float32>(var_60, var_61, var_62);
    // if v_len > eps:                                                                        <L 444>
    var_64 = (var_59 > var_0);
    if (var_64) {
        // radial = v / v_len                                                                 <L 445>
        var_65 = wp::div(var_58, var_59);
    }
    var_66 = wp::where(var_64, var_65, var_63);
    // axial = wp.vec3(0.0, 0.0, wp.sign(point_z_up[2]))                                      <L 446>
    var_70 = wp::extract(var_1, var_69);
    var_71 = wp::sign(var_70);
    var_72 = wp::vec_t<3, wp::float32>(var_67, var_68, var_71);
    // dx = v_len - radius                                                                    <L 447>
    var_73 = wp::sub(var_59, var_radius);
    // dy = wp.abs(point_z_up[2]) - half_height                                               <L 448>
    var_75 = wp::extract(var_1, var_74);
    var_76 = wp::abs(var_75);
    var_77 = wp::sub(var_76, var_half_height);
    // grad_z_up = wp.vec3()                                                                  <L 449>
    var_78 = wp::vec_t<3, wp::float32>();
    // if dx > 0.0 and dy > 0.0:                                                              <L 450>
    var_81 = (var_73 > var_80);
    var_79 = var_81;
    if (var_79) {
        var_83 = (var_77 > var_82);
        var_79 = var_79 && var_83;
    }
    if (var_79) {
        // g = radial * dx + axial * dy                                                       <L 451>
        var_84 = wp::mul(var_66, var_73);
        var_85 = wp::mul(var_72, var_77);
        var_86 = wp::add(var_84, var_85);
        // g_len = wp.length(g)                                                               <L 452>
        var_87 = wp::length(var_86);
        // if g_len > eps:                                                                    <L 453>
        var_88 = (var_87 > var_0);
        if (var_88) {
            // grad_z_up = g / g_len                                                          <L 454>
            var_89 = wp::div(var_86, var_87);
        }
        if (!var_88) {
            // grad_z_up = radial                                                             <L 456>
            var_90 = wp::copy(var_66);
        }
        var_91 = wp::where(var_88, var_89, var_90);
    }
    if (!var_79) {
        // elif dx > dy:                                                                      <L 457>
        var_92 = (var_73 > var_77);
        if (var_92) {
            // grad_z_up = radial                                                             <L 458>
            var_93 = wp::copy(var_66);
        }
        if (!var_92) {
            // grad_z_up = axial                                                              <L 460>
            var_94 = wp::copy(var_72);
        }
        var_95 = wp::where(var_92, var_93, var_94);
    }
    var_96 = wp::where(var_79, var_91, var_95);
    // return _sdf_vector_from_z_up(grad_z_up, up_axis)                                       <L 461>
    var_97 = _sdf_vector_from_z_up_0(var_96, var_up_axis);
    return var_97;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:530
static CUDA_CALLABLE wp::float32 sdf_cone_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::float32 var_radius,
    wp::float32 var_half_height,
    wp::int32 var_up_axis)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    const wp::float32 var_1 = 0.0;
    wp::float32 var_2;
    //---------
    // forward
    // def sdf_cone(point: wp.vec3, radius: float, half_height: float, up_axis: int = int(Axis.Y)):       <L 531>
    // point_z_up = _sdf_point_to_z_up(point, up_axis)                                        <L 543>
    var_0 = _sdf_point_to_z_up_0(var_point, var_up_axis);
    // return _sdf_capped_cone_z(radius, 0.0, half_height, point_z_up)                        <L 544>
    var_2 = _sdf_capped_cone_z_0(var_radius, var_1, var_half_height, var_0);
    return var_2;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:547
static CUDA_CALLABLE wp::vec_t<3, wp::float32> sdf_cone_grad_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::float32 var_radius,
    wp::float32 var_half_height,
    wp::int32 var_up_axis)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    const wp::float32 var_1 = 0.0;
    bool var_2;
    const wp::float32 var_3 = 0.0;
    const wp::float32 var_4 = 0.0;
    const wp::int32 var_5 = 2;
    wp::float32 var_6;
    wp::float32 var_7;
    wp::vec_t<3, wp::float32> var_8;
    wp::vec_t<3, wp::float32> var_9;
    const wp::int32 var_10 = 0;
    wp::float32 var_11;
    const wp::int32 var_12 = 1;
    wp::float32 var_13;
    const wp::float32 var_14 = 0.0;
    wp::vec_t<3, wp::float32> var_15;
    wp::float32 var_16;
    const wp::int32 var_17 = 2;
    wp::float32 var_18;
    wp::float32 var_19;
    wp::float32 var_20;
    const wp::float32 var_21 = 2.0;
    wp::float32 var_22;
    wp::float32 var_23;
    wp::float32 var_24;
    const wp::int32 var_25 = 2;
    wp::float32 var_26;
    wp::float32 var_27;
    wp::float32 var_28;
    wp::vec_t<3, wp::float32> var_29;
    bool var_30;
    const wp::float32 var_31 = 0.0;
    bool var_32;
    const wp::int32 var_33 = 0;
    wp::float32 var_34;
    const wp::int32 var_35 = 1;
    wp::float32 var_36;
    const wp::float32 var_37 = 0.0;
    wp::vec_t<3, wp::float32> var_38;
    wp::vec_t<3, wp::float32> var_39;
    const wp::float32 var_40 = 0.0;
    const wp::float32 var_41 = 0.0;
    const wp::float32 var_42 = 2.0;
    wp::float32 var_43;
    wp::float32 var_44;
    wp::vec_t<3, wp::float32> var_45;
    wp::vec_t<3, wp::float32> var_46;
    wp::vec_t<3, wp::float32> var_47;
    const wp::float32 var_48 = 0.0;
    const wp::float32 var_49 = 0.0;
    const wp::float32 var_50 = 1.0;
    wp::vec_t<3, wp::float32> var_51;
    wp::vec_t<3, wp::float32> var_52;
    const wp::float32 var_53 = 0.0;
    const wp::float32 var_54 = 0.0;
    const wp::int32 var_55 = 2;
    wp::float32 var_56;
    wp::float32 var_57;
    wp::vec_t<3, wp::float32> var_58;
    wp::vec_t<3, wp::float32> var_59;
    wp::vec_t<3, wp::float32> var_60;
    //---------
    // forward
    // def sdf_cone_grad(point: wp.vec3, radius: float, half_height: float, up_axis: int = int(Axis.Y)):       <L 548>
    // point_z_up = _sdf_point_to_z_up(point, up_axis)                                        <L 560>
    var_0 = _sdf_point_to_z_up_0(var_point, var_up_axis);
    // if half_height <= 0.0:                                                                 <L 561>
    var_2 = (var_half_height <= var_1);
    if (var_2) {
        // return _sdf_vector_from_z_up(wp.vec3(0.0, 0.0, wp.sign(point_z_up[2])), up_axis)       <L 562>
        var_6 = wp::extract(var_0, var_5);
        var_7 = wp::sign(var_6);
        var_8 = wp::vec_t<3, wp::float32>(var_3, var_4, var_7);
        var_9 = _sdf_vector_from_z_up_0(var_8, var_up_axis);
        return var_9;
    }
    // r = wp.length(wp.vec3(point_z_up[0], point_z_up[1], 0.0))                              <L 565>
    var_11 = wp::extract(var_0, var_10);
    var_13 = wp::extract(var_0, var_12);
    var_15 = wp::vec_t<3, wp::float32>(var_11, var_13, var_14);
    var_16 = wp::length(var_15);
    // dx = r - radius * (half_height - point_z_up[2]) / (2.0 * half_height)                  <L 566>
    var_18 = wp::extract(var_0, var_17);
    var_19 = wp::sub(var_half_height, var_18);
    var_20 = wp::mul(var_radius, var_19);
    var_22 = wp::mul(var_21, var_half_height);
    var_23 = wp::div(var_20, var_22);
    var_24 = wp::sub(var_16, var_23);
    // dy = wp.abs(point_z_up[2]) - half_height                                               <L 567>
    var_26 = wp::extract(var_0, var_25);
    var_27 = wp::abs(var_26);
    var_28 = wp::sub(var_27, var_half_height);
    // grad_z_up = wp.vec3()                                                                  <L 568>
    var_29 = wp::vec_t<3, wp::float32>();
    // if dx > dy:                                                                            <L 569>
    var_30 = (var_24 > var_28);
    if (var_30) {
        // if r > 0.0:                                                                        <L 571>
        var_32 = (var_16 > var_31);
        if (var_32) {
            // radial_dir = wp.vec3(point_z_up[0], point_z_up[1], 0.0) / r                    <L 572>
            var_34 = wp::extract(var_0, var_33);
            var_36 = wp::extract(var_0, var_35);
            var_38 = wp::vec_t<3, wp::float32>(var_34, var_36, var_37);
            var_39 = wp::div(var_38, var_16);
            // grad_z_up = wp.normalize(radial_dir + wp.vec3(0.0, 0.0, radius / (2.0 * half_height)))       <L 574>
            var_43 = wp::mul(var_42, var_half_height);
            var_44 = wp::div(var_radius, var_43);
            var_45 = wp::vec_t<3, wp::float32>(var_40, var_41, var_44);
            var_46 = wp::add(var_39, var_45);
            var_47 = wp::normalize(var_46);
        }
        if (!var_32) {
            // grad_z_up = wp.vec3(0.0, 0.0, 1.0)                                             <L 576>
            var_51 = wp::vec_t<3, wp::float32>(var_48, var_49, var_50);
        }
        var_52 = wp::where(var_32, var_47, var_51);
    }
    if (!var_30) {
        // grad_z_up = wp.vec3(0.0, 0.0, wp.sign(point_z_up[2]))                              <L 579>
        var_56 = wp::extract(var_0, var_55);
        var_57 = wp::sign(var_56);
        var_58 = wp::vec_t<3, wp::float32>(var_53, var_54, var_57);
    }
    var_59 = wp::where(var_30, var_52, var_58);
    // return _sdf_vector_from_z_up(grad_z_up, up_axis)                                       <L 580>
    var_60 = _sdf_vector_from_z_up_0(var_59, var_up_axis);
    return var_60;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:464
static CUDA_CALLABLE wp::float32 sdf_ellipsoid_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::vec_t<3, wp::float32> var_radii)
{
    //---------
    // primal vars
    const wp::float32 var_0 = 1e-08;
    const wp::int32 var_1 = 0;
    wp::float32 var_2;
    wp::float32 var_3;
    wp::float32 var_4;
    const wp::int32 var_5 = 1;
    wp::float32 var_6;
    wp::float32 var_7;
    wp::float32 var_8;
    const wp::int32 var_9 = 2;
    wp::float32 var_10;
    wp::float32 var_11;
    wp::float32 var_12;
    wp::vec_t<3, wp::float32> var_13;
    const wp::float32 var_14 = 1.0;
    const wp::float32 var_15 = 1.0;
    const wp::float32 var_16 = 1.0;
    wp::vec_t<3, wp::float32> var_17;
    wp::vec_t<3, wp::float32> var_18;
    wp::vec_t<3, wp::float32> var_19;
    wp::vec_t<3, wp::float32> var_20;
    wp::vec_t<3, wp::float32> var_21;
    wp::float32 var_22;
    wp::float32 var_23;
    bool var_24;
    const wp::float32 var_25 = 1.0;
    wp::float32 var_26;
    wp::float32 var_27;
    wp::float32 var_28;
    const wp::int32 var_29 = 0;
    wp::float32 var_30;
    const wp::int32 var_31 = 1;
    wp::float32 var_32;
    wp::float32 var_33;
    const wp::int32 var_34 = 2;
    wp::float32 var_35;
    wp::float32 var_36;
    wp::float32 var_37;
    //---------
    // forward
    // def sdf_ellipsoid(point: wp.vec3, radii: wp.vec3):                                     <L 465>
    // eps = 1.0e-8                                                                           <L 477>
    // r = wp.vec3(                                                                           <L 478>
    // wp.max(wp.abs(radii[0]), eps),                                                         <L 479>
    var_2 = wp::extract(var_radii, var_1);
    var_3 = wp::abs(var_2);
    var_4 = wp::max(var_3, var_0);
    // wp.max(wp.abs(radii[1]), eps),                                                         <L 480>
    var_6 = wp::extract(var_radii, var_5);
    var_7 = wp::abs(var_6);
    var_8 = wp::max(var_7, var_0);
    // wp.max(wp.abs(radii[2]), eps),                                                         <L 481>
    var_10 = wp::extract(var_radii, var_9);
    var_11 = wp::abs(var_10);
    var_12 = wp::max(var_11, var_0);
    var_13 = wp::vec_t<3, wp::float32>(var_4, var_8, var_12);
    // inv_r = wp.cw_div(wp.vec3(1.0, 1.0, 1.0), r)                                           <L 483>
    var_17 = wp::vec_t<3, wp::float32>(var_14, var_15, var_16);
    var_18 = wp::cw_div(var_17, var_13);
    // inv_r2 = wp.cw_mul(inv_r, inv_r)                                                       <L 484>
    var_19 = wp::cw_mul(var_18, var_18);
    // q0 = wp.cw_mul(point, inv_r)  # p / r                                                  <L 485>
    var_20 = wp::cw_mul(var_point, var_18);
    // q1 = wp.cw_mul(point, inv_r2)  # p / r^2                                               <L 486>
    var_21 = wp::cw_mul(var_point, var_19);
    // k0 = wp.length(q0)                                                                     <L 487>
    var_22 = wp::length(var_20);
    // k1 = wp.length(q1)                                                                     <L 488>
    var_23 = wp::length(var_21);
    // if k1 > eps:                                                                           <L 489>
    var_24 = (var_23 > var_0);
    if (var_24) {
        // return k0 * (k0 - 1.0) / k1                                                        <L 490>
        var_26 = wp::sub(var_22, var_25);
        var_27 = wp::mul(var_22, var_26);
        var_28 = wp::div(var_27, var_23);
        return var_28;
    }
    // return -wp.min(wp.min(r[0], r[1]), r[2])                                               <L 492>
    var_30 = wp::extract(var_13, var_29);
    var_32 = wp::extract(var_13, var_31);
    var_33 = wp::min(var_30, var_32);
    var_35 = wp::extract(var_13, var_34);
    var_36 = wp::min(var_33, var_35);
    var_37 = wp::neg(var_36);
    return var_37;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:495
static CUDA_CALLABLE wp::vec_t<3, wp::float32> sdf_ellipsoid_grad_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::vec_t<3, wp::float32> var_radii)
{
    //---------
    // primal vars
    const wp::float32 var_0 = 1e-08;
    const wp::int32 var_1 = 0;
    wp::float32 var_2;
    wp::float32 var_3;
    wp::float32 var_4;
    const wp::int32 var_5 = 1;
    wp::float32 var_6;
    wp::float32 var_7;
    wp::float32 var_8;
    const wp::int32 var_9 = 2;
    wp::float32 var_10;
    wp::float32 var_11;
    wp::float32 var_12;
    wp::vec_t<3, wp::float32> var_13;
    const wp::float32 var_14 = 1.0;
    const wp::float32 var_15 = 1.0;
    const wp::float32 var_16 = 1.0;
    wp::vec_t<3, wp::float32> var_17;
    wp::vec_t<3, wp::float32> var_18;
    wp::vec_t<3, wp::float32> var_19;
    wp::vec_t<3, wp::float32> var_20;
    wp::vec_t<3, wp::float32> var_21;
    wp::float32 var_22;
    wp::float32 var_23;
    bool var_24;
    const wp::float32 var_25 = 0.0;
    const wp::float32 var_26 = 0.0;
    const wp::float32 var_27 = 1.0;
    wp::vec_t<3, wp::float32> var_28;
    wp::float32 var_29;
    wp::vec_t<3, wp::float32> var_30;
    wp::float32 var_31;
    bool var_32;
    wp::vec_t<3, wp::float32> var_33;
    const wp::float32 var_34 = 0.0;
    const wp::float32 var_35 = 0.0;
    const wp::float32 var_36 = 1.0;
    wp::vec_t<3, wp::float32> var_37;
    //---------
    // forward
    // def sdf_ellipsoid_grad(point: wp.vec3, radii: wp.vec3):                                <L 496>
    // eps = 1.0e-8                                                                           <L 508>
    // r = wp.vec3(                                                                           <L 509>
    // wp.max(wp.abs(radii[0]), eps),                                                         <L 510>
    var_2 = wp::extract(var_radii, var_1);
    var_3 = wp::abs(var_2);
    var_4 = wp::max(var_3, var_0);
    // wp.max(wp.abs(radii[1]), eps),                                                         <L 511>
    var_6 = wp::extract(var_radii, var_5);
    var_7 = wp::abs(var_6);
    var_8 = wp::max(var_7, var_0);
    // wp.max(wp.abs(radii[2]), eps),                                                         <L 512>
    var_10 = wp::extract(var_radii, var_9);
    var_11 = wp::abs(var_10);
    var_12 = wp::max(var_11, var_0);
    var_13 = wp::vec_t<3, wp::float32>(var_4, var_8, var_12);
    // inv_r = wp.cw_div(wp.vec3(1.0, 1.0, 1.0), r)                                           <L 514>
    var_17 = wp::vec_t<3, wp::float32>(var_14, var_15, var_16);
    var_18 = wp::cw_div(var_17, var_13);
    // inv_r2 = wp.cw_mul(inv_r, inv_r)                                                       <L 515>
    var_19 = wp::cw_mul(var_18, var_18);
    // q0 = wp.cw_mul(point, inv_r)  # p / r                                                  <L 516>
    var_20 = wp::cw_mul(var_point, var_18);
    // q1 = wp.cw_mul(point, inv_r2)  # p / r^2                                               <L 517>
    var_21 = wp::cw_mul(var_point, var_19);
    // k0 = wp.length(q0)                                                                     <L 518>
    var_22 = wp::length(var_20);
    // k1 = wp.length(q1)                                                                     <L 519>
    var_23 = wp::length(var_21);
    // if k1 < eps:                                                                           <L 520>
    var_24 = (var_23 < var_0);
    if (var_24) {
        // return wp.vec3(0.0, 0.0, 1.0)                                                      <L 521>
        var_28 = wp::vec_t<3, wp::float32>(var_25, var_26, var_27);
        return var_28;
    }
    // grad = q1 * (k0 / k1)                                                                  <L 523>
    var_29 = wp::div(var_22, var_23);
    var_30 = wp::mul(var_21, var_29);
    // grad_len = wp.length(grad)                                                             <L 524>
    var_31 = wp::length(var_30);
    // if grad_len > eps:                                                                     <L 525>
    var_32 = (var_31 > var_0);
    if (var_32) {
        // return grad / grad_len                                                             <L 526>
        var_33 = wp::div(var_30, var_31);
        return var_33;
    }
    // return wp.vec3(0.0, 0.0, 1.0)                                                          <L 527>
    var_37 = wp::vec_t<3, wp::float32>(var_34, var_35, var_36);
    return var_37;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:15
static CUDA_CALLABLE wp::int32 resolve_mesh_sign_method_0(
    wp::int32 var_mesh_properties)
{
    //---------
    // primal vars
    const wp::int32 var_0 = 1;
    wp::int32 var_1;
    const wp::int32 var_2 = 1;
    const wp::int32 var_3 = 1;
    wp::int32 var_4;
    const wp::int32 var_5 = 0;
    const wp::int32 var_6 = 0;
    wp::int32 var_7;
    //---------
    // forward
    // def resolve_mesh_sign_method(mesh_properties: int):                                    <L 16>
    // if mesh_properties & MeshProperties.WATERTIGHT:                                        <L 26>
    var_1 = wp::bit_and(var_mesh_properties, var_0);
    if (var_1) {
        // return int(MeshSignMethod.PARITY)                                                  <L 27>
        var_4 = wp::int(var_3);
        return var_4;
    }
    // return int(MeshSignMethod.NORMAL)                                                      <L 28>
    var_7 = wp::int(var_6);
    return var_7;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:884
static CUDA_CALLABLE wp::mesh_query_point_t mesh_query_point_sign_0(
    wp::uint64 var_mesh,
    wp::vec_t<3, wp::float32> var_point,
    wp::float32 var_max_dist,
    wp::int32 var_sign_method)
{
    //---------
    // primal vars
    const wp::int32 var_0 = 1;
    bool var_1;
    wp::mesh_query_point_t var_2;
    const wp::int32 var_3 = 1;
    const wp::float32 var_4 = 0.1;
    wp::mesh_query_point_t var_5;
    const wp::float32 var_6 = 0.001;
    //---------
    // forward
    // def mesh_query_point_sign(mesh: wp.uint64, point: wp.vec3, max_dist: float, sign_method: int):       <L 885>
    // if sign_method == MeshSignMethod.PARITY:                                               <L 887>
    var_1 = (var_sign_method == var_0);
    if (var_1) {
        // return wp.mesh_query_point_sign_parity(mesh, point, max_dist)                      <L 888>
        var_2 = wp::mesh_query_point_sign_parity(var_mesh, var_point, var_max_dist, var_3, var_4);
        return var_2;
    }
    // return wp.mesh_query_point_sign_normal(mesh, point, max_dist)                          <L 889>
    var_5 = wp::mesh_query_point_sign_normal(var_mesh, var_point, var_max_dist, var_6);
    return var_5;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:583
static CUDA_CALLABLE wp::float32 sdf_plane_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::float32 var_width,
    wp::float32 var_length)
{
    //---------
    // primal vars
    bool var_0;
    const wp::float32 var_1 = 0.0;
    bool var_2;
    const wp::float32 var_3 = 0.0;
    bool var_4;
    const wp::int32 var_5 = 0;
    wp::float32 var_6;
    wp::float32 var_7;
    wp::float32 var_8;
    const wp::int32 var_9 = 1;
    wp::float32 var_10;
    wp::float32 var_11;
    wp::float32 var_12;
    wp::float32 var_13;
    const wp::int32 var_14 = 2;
    wp::float32 var_15;
    wp::float32 var_16;
    wp::float32 var_17;
    const wp::int32 var_18 = 2;
    wp::float32 var_19;
    //---------
    // forward
    // def sdf_plane(point: wp.vec3, width: float, length: float):                            <L 584>
    // if width > 0.0 and length > 0.0:                                                       <L 601>
    var_2 = (var_width > var_1);
    var_0 = var_2;
    if (var_0) {
        var_4 = (var_length > var_3);
        var_0 = var_0 && var_4;
    }
    if (var_0) {
        // d = wp.max(wp.abs(point[0]) - width, wp.abs(point[1]) - length)                    <L 602>
        var_6 = wp::extract(var_point, var_5);
        var_7 = wp::abs(var_6);
        var_8 = wp::sub(var_7, var_width);
        var_10 = wp::extract(var_point, var_9);
        var_11 = wp::abs(var_10);
        var_12 = wp::sub(var_11, var_length);
        var_13 = wp::max(var_8, var_12);
        // return wp.max(d, wp.abs(point[2]))                                                 <L 603>
        var_15 = wp::extract(var_point, var_14);
        var_16 = wp::abs(var_15);
        var_17 = wp::max(var_13, var_16);
        return var_17;
    }
    // return point[2]                                                                        <L 604>
    var_19 = wp::extract(var_point, var_18);
    return var_19;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/utils/heightfield.py:171
static CUDA_CALLABLE void _heightfield_surface_query_0(
    HeightfieldData_f2b8d59a var_hfd,
    wp::array_t<wp::float32> var_elevation_data,
    wp::vec_t<3, wp::float32> var_pos,
    wp::float32 & ret_0,
    wp::vec_t<3, wp::float32> & ret_1,
    wp::float32 & ret_2)
{
    //---------
    // primal vars
    bool var_0;
    wp::int32* var_1;
    const wp::int32 var_2 = 1;
    bool var_3;
    wp::int32 var_4;
    wp::int32* var_5;
    const wp::int32 var_6 = 1;
    bool var_7;
    wp::int32 var_8;
    const wp::float32 var_9 = 10000000000.0;
    const wp::float32 var_10 = 0.0;
    const wp::float32 var_11 = 0.0;
    const wp::float32 var_12 = 1.0;
    wp::vec_t<3, wp::float32> var_13;
    const wp::float32 var_14 = 0.0;
    const wp::float32 var_15 = 2.0;
    wp::float32* var_16;
    wp::float32 var_17;
    wp::float32 var_18;
    wp::int32* var_19;
    const wp::int32 var_20 = 1;
    wp::int32 var_21;
    wp::int32 var_22;
    wp::float32 var_23;
    wp::float32 var_24;
    const wp::float32 var_25 = 2.0;
    wp::float32* var_26;
    wp::float32 var_27;
    wp::float32 var_28;
    wp::int32* var_29;
    const wp::int32 var_30 = 1;
    wp::int32 var_31;
    wp::int32 var_32;
    wp::float32 var_33;
    wp::float32 var_34;
    wp::float32* var_35;
    wp::float32* var_36;
    wp::float32 var_37;
    wp::float32 var_38;
    wp::float32 var_39;
    const wp::int32 var_40 = 0;
    wp::float32 var_41;
    wp::float32* var_42;
    wp::float32 var_43;
    wp::float32 var_44;
    wp::float32* var_45;
    wp::float32 var_46;
    wp::float32 var_47;
    const wp::int32 var_48 = 1;
    wp::float32 var_49;
    wp::float32* var_50;
    wp::float32 var_51;
    wp::float32 var_52;
    wp::float32* var_53;
    wp::float32 var_54;
    wp::float32 var_55;
    const wp::int32 var_56 = 0;
    wp::float32 var_57;
    wp::float32 var_58;
    const wp::int32 var_59 = 1;
    wp::float32 var_60;
    wp::float32 var_61;
    wp::float32 var_62;
    wp::float32 var_63;
    wp::float32 var_64;
    wp::float32* var_65;
    wp::float32 var_66;
    wp::float32 var_67;
    wp::float32 var_68;
    wp::float32* var_69;
    wp::float32 var_70;
    wp::float32 var_71;
    wp::float32 var_72;
    const wp::float32 var_73 = 0.0;
    wp::int32* var_74;
    const wp::int32 var_75 = 1;
    wp::int32 var_76;
    wp::int32 var_77;
    wp::float32 var_78;
    wp::float32 var_79;
    const wp::float32 var_80 = 0.0;
    wp::int32* var_81;
    const wp::int32 var_82 = 1;
    wp::int32 var_83;
    wp::int32 var_84;
    wp::float32 var_85;
    wp::float32 var_86;
    wp::int32 var_87;
    wp::int32* var_88;
    const wp::int32 var_89 = 2;
    wp::int32 var_90;
    wp::int32 var_91;
    wp::int32 var_92;
    wp::int32 var_93;
    wp::int32* var_94;
    const wp::int32 var_95 = 2;
    wp::int32 var_96;
    wp::int32 var_97;
    wp::int32 var_98;
    wp::float32 var_99;
    wp::float32 var_100;
    wp::float32 var_101;
    wp::float32 var_102;
    wp::int32* var_103;
    wp::int32 var_104;
    wp::int32 var_105;
    wp::float32* var_106;
    wp::int32* var_107;
    wp::int32 var_108;
    wp::int32 var_109;
    wp::int32 var_110;
    wp::int32 var_111;
    wp::float32* var_112;
    wp::float32 var_113;
    wp::float32 var_114;
    wp::float32 var_115;
    wp::float32 var_116;
    wp::float32* var_117;
    wp::int32* var_118;
    wp::int32 var_119;
    wp::int32 var_120;
    wp::int32 var_121;
    wp::int32 var_122;
    const wp::int32 var_123 = 1;
    wp::int32 var_124;
    wp::float32* var_125;
    wp::float32 var_126;
    wp::float32 var_127;
    wp::float32 var_128;
    wp::float32 var_129;
    wp::float32* var_130;
    const wp::int32 var_131 = 1;
    wp::int32 var_132;
    wp::int32* var_133;
    wp::int32 var_134;
    wp::int32 var_135;
    wp::int32 var_136;
    wp::int32 var_137;
    wp::float32* var_138;
    wp::float32 var_139;
    wp::float32 var_140;
    wp::float32 var_141;
    wp::float32 var_142;
    wp::float32* var_143;
    const wp::int32 var_144 = 1;
    wp::int32 var_145;
    wp::int32* var_146;
    wp::int32 var_147;
    wp::int32 var_148;
    wp::int32 var_149;
    wp::int32 var_150;
    const wp::int32 var_151 = 1;
    wp::int32 var_152;
    wp::float32* var_153;
    wp::float32 var_154;
    wp::float32 var_155;
    wp::float32 var_156;
    wp::float32 var_157;
    wp::float32* var_158;
    wp::float32 var_159;
    wp::float32 var_160;
    wp::float32 var_161;
    wp::float32 var_162;
    wp::float32 var_163;
    wp::float32* var_164;
    wp::float32 var_165;
    wp::float32 var_166;
    wp::float32 var_167;
    wp::float32 var_168;
    wp::float32 var_169;
    bool var_170;
    wp::vec_t<3, wp::float32> var_171;
    const wp::float32 var_172 = 0.0;
    wp::float32 var_173;
    wp::vec_t<3, wp::float32> var_174;
    wp::float32 var_175;
    wp::vec_t<3, wp::float32> var_176;
    wp::vec_t<3, wp::float32> var_177;
    wp::float32 var_178;
    wp::vec_t<3, wp::float32> var_179;
    const wp::float32 var_180 = 0.0;
    wp::float32 var_181;
    wp::vec_t<3, wp::float32> var_182;
    wp::vec_t<3, wp::float32> var_183;
    wp::vec_t<3, wp::float32> var_184;
    wp::vec_t<3, wp::float32> var_185;
    wp::vec_t<3, wp::float32> var_186;
    wp::vec_t<3, wp::float32> var_187;
    wp::vec_t<3, wp::float32> var_188;
    wp::float32 var_189;
    //---------
    // forward
    // def _heightfield_surface_query(                                                        <L 172>
    // if hfd.nrow <= 1 or hfd.ncol <= 1:                                                     <L 183>
    var_1 = &((var_hfd).nrow);
    var_4 = wp::load(var_1);
    var_3 = (var_4 <= var_2);
    var_0 = var_3;
    if (!var_0) {
        var_5 = &((var_hfd).ncol);
        var_8 = wp::load(var_5);
        var_7 = (var_8 <= var_6);
        var_0 = var_0 || var_7;
    }
    if (var_0) {
        // return 1.0e10, wp.vec3(0.0, 0.0, 1.0), 0.0                                         <L 184>
        var_13 = wp::vec_t<3, wp::float32>(var_10, var_11, var_12);
        ret_0 = var_9;
        ret_1 = var_13;
        ret_2 = var_14;
        return;
    }
    // dx = 2.0 * hfd.hx / wp.float32(hfd.ncol - 1)                                           <L 186>
    var_16 = &((var_hfd).hx);
    var_18 = wp::load(var_16);
    var_17 = wp::mul(var_15, var_18);
    var_19 = &((var_hfd).ncol);
    var_22 = wp::load(var_19);
    var_21 = wp::sub(var_22, var_20);
    var_23 = wp::float32(var_21);
    var_24 = wp::div(var_17, var_23);
    // dy = 2.0 * hfd.hy / wp.float32(hfd.nrow - 1)                                           <L 187>
    var_26 = &((var_hfd).hy);
    var_28 = wp::load(var_26);
    var_27 = wp::mul(var_25, var_28);
    var_29 = &((var_hfd).nrow);
    var_32 = wp::load(var_29);
    var_31 = wp::sub(var_32, var_30);
    var_33 = wp::float32(var_31);
    var_34 = wp::div(var_27, var_33);
    // z_range = hfd.max_z - hfd.min_z                                                        <L 188>
    var_35 = &((var_hfd).max_z);
    var_36 = &((var_hfd).min_z);
    var_38 = wp::load(var_35);
    var_39 = wp::load(var_36);
    var_37 = wp::sub(var_38, var_39);
    // cx = wp.clamp(pos[0], -hfd.hx, hfd.hx)                                                 <L 191>
    var_41 = wp::extract(var_pos, var_40);
    var_42 = &((var_hfd).hx);
    var_44 = wp::load(var_42);
    var_43 = wp::neg(var_44);
    var_45 = &((var_hfd).hx);
    var_47 = wp::load(var_45);
    var_46 = wp::clamp(var_41, var_43, var_47);
    // cy = wp.clamp(pos[1], -hfd.hy, hfd.hy)                                                 <L 192>
    var_49 = wp::extract(var_pos, var_48);
    var_50 = &((var_hfd).hy);
    var_52 = wp::load(var_50);
    var_51 = wp::neg(var_52);
    var_53 = &((var_hfd).hy);
    var_55 = wp::load(var_53);
    var_54 = wp::clamp(var_49, var_51, var_55);
    // out_x = pos[0] - cx                                                                    <L 193>
    var_57 = wp::extract(var_pos, var_56);
    var_58 = wp::sub(var_57, var_46);
    // out_y = pos[1] - cy                                                                    <L 194>
    var_60 = wp::extract(var_pos, var_59);
    var_61 = wp::sub(var_60, var_54);
    // lateral_dist_sq = out_x * out_x + out_y * out_y                                        <L 195>
    var_62 = wp::mul(var_58, var_58);
    var_63 = wp::mul(var_61, var_61);
    var_64 = wp::add(var_62, var_63);
    // col_f = (cx + hfd.hx) / dx                                                             <L 197>
    var_65 = &((var_hfd).hx);
    var_67 = wp::load(var_65);
    var_66 = wp::add(var_46, var_67);
    var_68 = wp::div(var_66, var_24);
    // row_f = (cy + hfd.hy) / dy                                                             <L 198>
    var_69 = &((var_hfd).hy);
    var_71 = wp::load(var_69);
    var_70 = wp::add(var_54, var_71);
    var_72 = wp::div(var_70, var_34);
    // col_f = wp.clamp(col_f, 0.0, wp.float32(hfd.ncol - 1))                                 <L 199>
    var_74 = &((var_hfd).ncol);
    var_77 = wp::load(var_74);
    var_76 = wp::sub(var_77, var_75);
    var_78 = wp::float32(var_76);
    var_79 = wp::clamp(var_68, var_73, var_78);
    // row_f = wp.clamp(row_f, 0.0, wp.float32(hfd.nrow - 1))                                 <L 200>
    var_81 = &((var_hfd).nrow);
    var_84 = wp::load(var_81);
    var_83 = wp::sub(var_84, var_82);
    var_85 = wp::float32(var_83);
    var_86 = wp::clamp(var_72, var_80, var_85);
    // col = wp.min(wp.int32(col_f), hfd.ncol - 2)                                            <L 202>
    var_87 = wp::int32(var_79);
    var_88 = &((var_hfd).ncol);
    var_91 = wp::load(var_88);
    var_90 = wp::sub(var_91, var_89);
    var_92 = wp::min(var_87, var_90);
    // row = wp.min(wp.int32(row_f), hfd.nrow - 2)                                            <L 203>
    var_93 = wp::int32(var_86);
    var_94 = &((var_hfd).nrow);
    var_97 = wp::load(var_94);
    var_96 = wp::sub(var_97, var_95);
    var_98 = wp::min(var_93, var_96);
    // fx = col_f - wp.float32(col)                                                           <L 204>
    var_99 = wp::float32(var_92);
    var_100 = wp::sub(var_79, var_99);
    // fy = row_f - wp.float32(row)                                                           <L 205>
    var_101 = wp::float32(var_98);
    var_102 = wp::sub(var_86, var_101);
    // base = hfd.data_offset                                                                 <L 207>
    var_103 = &((var_hfd).data_offset);
    var_105 = wp::load(var_103);
    var_104 = wp::copy(var_105);
    // h00 = hfd.min_z + elevation_data[base + row * hfd.ncol + col] * z_range                <L 208>
    var_106 = &((var_hfd).min_z);
    var_107 = &((var_hfd).ncol);
    var_109 = wp::load(var_107);
    var_108 = wp::mul(var_98, var_109);
    var_110 = wp::add(var_104, var_108);
    var_111 = wp::add(var_110, var_92);
    var_112 = wp::address(var_elevation_data, var_111);
    var_114 = wp::load(var_112);
    var_113 = wp::mul(var_114, var_37);
    var_116 = wp::load(var_106);
    var_115 = wp::add(var_116, var_113);
    // h10 = hfd.min_z + elevation_data[base + row * hfd.ncol + col + 1] * z_range            <L 209>
    var_117 = &((var_hfd).min_z);
    var_118 = &((var_hfd).ncol);
    var_120 = wp::load(var_118);
    var_119 = wp::mul(var_98, var_120);
    var_121 = wp::add(var_104, var_119);
    var_122 = wp::add(var_121, var_92);
    var_124 = wp::add(var_122, var_123);
    var_125 = wp::address(var_elevation_data, var_124);
    var_127 = wp::load(var_125);
    var_126 = wp::mul(var_127, var_37);
    var_129 = wp::load(var_117);
    var_128 = wp::add(var_129, var_126);
    // h01 = hfd.min_z + elevation_data[base + (row + 1) * hfd.ncol + col] * z_range          <L 210>
    var_130 = &((var_hfd).min_z);
    var_132 = wp::add(var_98, var_131);
    var_133 = &((var_hfd).ncol);
    var_135 = wp::load(var_133);
    var_134 = wp::mul(var_132, var_135);
    var_136 = wp::add(var_104, var_134);
    var_137 = wp::add(var_136, var_92);
    var_138 = wp::address(var_elevation_data, var_137);
    var_140 = wp::load(var_138);
    var_139 = wp::mul(var_140, var_37);
    var_142 = wp::load(var_130);
    var_141 = wp::add(var_142, var_139);
    // h11 = hfd.min_z + elevation_data[base + (row + 1) * hfd.ncol + col + 1] * z_range       <L 211>
    var_143 = &((var_hfd).min_z);
    var_145 = wp::add(var_98, var_144);
    var_146 = &((var_hfd).ncol);
    var_148 = wp::load(var_146);
    var_147 = wp::mul(var_145, var_148);
    var_149 = wp::add(var_104, var_147);
    var_150 = wp::add(var_149, var_92);
    var_152 = wp::add(var_150, var_151);
    var_153 = wp::address(var_elevation_data, var_152);
    var_155 = wp::load(var_153);
    var_154 = wp::mul(var_155, var_37);
    var_157 = wp::load(var_143);
    var_156 = wp::add(var_157, var_154);
    // x0 = -hfd.hx + wp.float32(col) * dx                                                    <L 213>
    var_158 = &((var_hfd).hx);
    var_160 = wp::load(var_158);
    var_159 = wp::neg(var_160);
    var_161 = wp::float32(var_92);
    var_162 = wp::mul(var_161, var_24);
    var_163 = wp::add(var_159, var_162);
    // y0 = -hfd.hy + wp.float32(row) * dy                                                    <L 214>
    var_164 = &((var_hfd).hy);
    var_166 = wp::load(var_164);
    var_165 = wp::neg(var_166);
    var_167 = wp::float32(var_98);
    var_168 = wp::mul(var_167, var_34);
    var_169 = wp::add(var_165, var_168);
    // if fx >= fy:                                                                           <L 216>
    var_170 = (var_100 >= var_102);
    if (var_170) {
        // v0 = wp.vec3(x0, y0, h00)                                                          <L 217>
        var_171 = wp::vec_t<3, wp::float32>(var_163, var_169, var_115);
        // e1 = wp.vec3(dx, 0.0, h10 - h00)                                                   <L 218>
        var_173 = wp::sub(var_128, var_115);
        var_174 = wp::vec_t<3, wp::float32>(var_24, var_172, var_173);
        // e2 = wp.vec3(dx, dy, h11 - h00)                                                    <L 219>
        var_175 = wp::sub(var_156, var_115);
        var_176 = wp::vec_t<3, wp::float32>(var_24, var_34, var_175);
    }
    if (!var_170) {
        // v0 = wp.vec3(x0, y0, h00)                                                          <L 221>
        var_177 = wp::vec_t<3, wp::float32>(var_163, var_169, var_115);
        // e1 = wp.vec3(dx, dy, h11 - h00)                                                    <L 222>
        var_178 = wp::sub(var_156, var_115);
        var_179 = wp::vec_t<3, wp::float32>(var_24, var_34, var_178);
        // e2 = wp.vec3(0.0, dy, h01 - h00)                                                   <L 223>
        var_181 = wp::sub(var_141, var_115);
        var_182 = wp::vec_t<3, wp::float32>(var_180, var_34, var_181);
    }
    var_183 = wp::where(var_170, var_171, var_177);
    var_184 = wp::where(var_170, var_174, var_179);
    var_185 = wp::where(var_170, var_176, var_182);
    // normal = wp.normalize(wp.cross(e1, e2))                                                <L 225>
    var_186 = wp::cross(var_184, var_185);
    var_187 = wp::normalize(var_186);
    // d_plane = wp.dot(pos - v0, normal)                                                     <L 226>
    var_188 = wp::sub(var_pos, var_183);
    var_189 = wp::dot(var_188, var_187);
    // return d_plane, normal, lateral_dist_sq                                                <L 227>
    ret_0 = var_189;
    ret_1 = var_187;
    ret_2 = var_64;
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/utils/heightfield.py:254
static CUDA_CALLABLE void sample_sdf_grad_heightfield_0(
    HeightfieldData_f2b8d59a var_hfd,
    wp::array_t<wp::float32> var_elevation_data,
    wp::vec_t<3, wp::float32> var_pos,
    wp::float32 & ret_0,
    wp::vec_t<3, wp::float32> & ret_1)
{
    //---------
    // primal vars
    wp::float32 var_0;
    wp::vec_t<3, wp::float32> var_1;
    wp::float32 var_2;
    const wp::float32 var_3 = 0.0;
    bool var_4;
    wp::float32 var_5;
    wp::float32 var_6;
    wp::float32 var_7;
    const wp::int32 var_8 = 0;
    wp::float32 var_9;
    wp::float32* var_10;
    wp::float32 var_11;
    wp::float32 var_12;
    wp::float32* var_13;
    wp::float32 var_14;
    wp::float32 var_15;
    const wp::int32 var_16 = 1;
    wp::float32 var_17;
    wp::float32* var_18;
    wp::float32 var_19;
    wp::float32 var_20;
    wp::float32* var_21;
    wp::float32 var_22;
    wp::float32 var_23;
    const wp::int32 var_24 = 0;
    wp::float32 var_25;
    wp::float32 var_26;
    const wp::int32 var_27 = 1;
    wp::float32 var_28;
    wp::float32 var_29;
    const wp::float32 var_30 = 0.0;
    wp::vec_t<3, wp::float32> var_31;
    wp::vec_t<3, wp::float32> var_32;
    wp::vec_t<3, wp::float32> var_33;
    wp::float32 var_34;
    const wp::float32 var_35 = 1e-20;
    bool var_36;
    wp::vec_t<3, wp::float32> var_37;
    const wp::float32 var_38 = 0.0;
    const wp::float32 var_39 = 0.0;
    const wp::float32 var_40 = 1.0;
    wp::vec_t<3, wp::float32> var_41;
    wp::vec_t<3, wp::float32> var_42;
    //---------
    // forward
    // def sample_sdf_grad_heightfield(                                                       <L 255>
    // d_plane, normal, lateral_dist_sq = _heightfield_surface_query(hfd, elevation_data, pos)       <L 265>
    _heightfield_surface_query_0(var_hfd, var_elevation_data, var_pos, var_0, var_1, var_2);
    // if lateral_dist_sq > 0.0:                                                              <L 266>
    var_4 = (var_2 > var_3);
    if (var_4) {
        // dist = wp.sqrt(lateral_dist_sq + d_plane * d_plane)                                <L 267>
        var_5 = wp::mul(var_0, var_0);
        var_6 = wp::add(var_2, var_5);
        var_7 = wp::sqrt(var_6);
        // cx = wp.clamp(pos[0], -hfd.hx, hfd.hx)                                             <L 268>
        var_9 = wp::extract(var_pos, var_8);
        var_10 = &((var_hfd).hx);
        var_12 = wp::load(var_10);
        var_11 = wp::neg(var_12);
        var_13 = &((var_hfd).hx);
        var_15 = wp::load(var_13);
        var_14 = wp::clamp(var_9, var_11, var_15);
        // cy = wp.clamp(pos[1], -hfd.hy, hfd.hy)                                             <L 269>
        var_17 = wp::extract(var_pos, var_16);
        var_18 = &((var_hfd).hy);
        var_20 = wp::load(var_18);
        var_19 = wp::neg(var_20);
        var_21 = &((var_hfd).hy);
        var_23 = wp::load(var_21);
        var_22 = wp::clamp(var_17, var_19, var_23);
        // lateral = wp.vec3(pos[0] - cx, pos[1] - cy, 0.0)                                   <L 270>
        var_25 = wp::extract(var_pos, var_24);
        var_26 = wp::sub(var_25, var_14);
        var_28 = wp::extract(var_pos, var_27);
        var_29 = wp::sub(var_28, var_22);
        var_31 = wp::vec_t<3, wp::float32>(var_26, var_29, var_30);
        // raw_grad = lateral + d_plane * normal                                              <L 271>
        var_32 = wp::mul(var_0, var_1);
        var_33 = wp::add(var_31, var_32);
        // if wp.length_sq(raw_grad) > 1.0e-20:                                               <L 272>
        var_34 = wp::length_sq(var_33);
        var_36 = (var_34 > var_35);
        if (var_36) {
            // grad = wp.normalize(raw_grad)                                                  <L 273>
            var_37 = wp::normalize(var_33);
        }
        if (!var_36) {
            // grad = wp.vec3(0.0, 0.0, 1.0)                                                  <L 275>
            var_41 = wp::vec_t<3, wp::float32>(var_38, var_39, var_40);
        }
        var_42 = wp::where(var_36, var_37, var_41);
        // return dist, grad                                                                  <L 276>
        ret_0 = var_7;
        ret_1 = var_42;
        return;
    }
    // return d_plane, normal                                                                 <L 277>
    ret_0 = var_0;
    ret_1 = var_1;
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:985
static CUDA_CALLABLE wp::int32 counter_increment_0(
    wp::array_t<wp::int32> var_counter,
    wp::int32 var_counter_index,
    wp::array_t<wp::int32> var_tids,
    wp::int32 var_tid,
    wp::int32 var_index_limit)
{
    //---------
    // primal vars
    const wp::int32 var_0 = 1;
    wp::int32 var_1;
    bool var_2;
    bool var_3;
    const wp::int32 var_4 = 0;
    bool var_5;
    wp::shape_t* var_6;
    const wp::int32 var_7 = 0;
    wp::int32 var_8;
    wp::shape_t var_9;
    bool var_10;
    wp::shape_t* var_11;
    const wp::int32 var_12 = 0;
    wp::int32 var_13;
    wp::shape_t var_14;
    bool var_15;
    const wp::int32 var_16 = -1;
    const wp::int32 var_17 = -1;
    //---------
    // forward
    // def counter_increment(counter: wp.array[int], counter_index: int, tids: wp.array[int], tid: int, index_limit: int = -1):       <L 986>
    // count = wp.atomic_add(counter, counter_index, 1)                                       <L 1001>
    var_1 = wp::atomic_add(var_counter, var_counter_index, var_0);
    // if count < index_limit or index_limit < 0:                                             <L 1002>
    var_3 = (var_1 < var_index_limit);
    var_2 = var_3;
    if (!var_2) {
        var_5 = (var_index_limit < var_4);
        var_2 = var_2 || var_5;
    }
    if (var_2) {
        // if tid < tids.shape[0]:                                                            <L 1003>
        var_6 = &(var_tids.shape);
        var_9 = wp::load(var_6);
        var_8 = wp::extract(var_9, var_7);
        var_10 = (var_tid < var_8);
        if (var_10) {
            // tids[tid] = count                                                              <L 1004>
            wp::array_store(var_tids, var_tid, var_1);
        }
        // return count                                                                       <L 1005>
        return var_1;
    }
    // if tid < tids.shape[0]:                                                                <L 1006>
    var_11 = &(var_tids.shape);
    var_14 = wp::load(var_11);
    var_13 = wp::extract(var_14, var_12);
    var_15 = (var_tid < var_13);
    if (var_15) {
        // tids[tid] = -1                                                                     <L 1007>
        wp::array_store(var_tids, var_tid, var_16);
    }
    // return -1                                                                              <L 1008>
    return var_17;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/broad_phase_common.py:0
static CUDA_CALLABLE wp::int32 binary_search_0(
    wp::array_t<wp::int32> var_values,
    wp::int32 var_value,
    wp::int32 var_lower,
    wp::int32 var_upper)
{
    //---------
    // primal vars
    bool var_0;
    wp::int32 var_1;
    const wp::int32 var_2 = 1;
    wp::int32 var_3;
    wp::int32* var_4;
    bool var_5;
    wp::int32 var_6;
    wp::int32 var_7;
    const wp::int32 var_8 = 1;
    wp::int32 var_9;
    wp::int32 var_10;
    wp::int32 var_11;
    //---------
    // forward
    // def binary_search(values: wp.array[Any], value: Any, lower: int, upper: int) -> int:       <L 1>
    // while lower < upper:                                                                   <L 2>
    start_while_0:;
    var_0 = (var_lower < var_upper);
    if ((var_0) == false) goto end_while_0;
        // mid = (lower + upper) >> 1                                                         <L 3>
        var_1 = wp::add(var_lower, var_upper);
        var_3 = wp::rshift(var_1, var_2);
        // if values[mid] > value:                                                            <L 4>
        var_4 = wp::address(var_values, var_3);
        var_6 = wp::load(var_4);
        var_5 = (var_6 > var_value);
        if (var_5) {
            // upper = mid                                                                    <L 5>
            var_7 = wp::copy(var_3);
        }
        if (!var_5) {
            // lower = mid + 1                                                                <L 7>
            var_9 = wp::add(var_3, var_8);
        }
        var_10 = wp::where(var_5, var_lower, var_9);
        var_11 = wp::where(var_5, var_7, var_upper);
        wp::assign(var_lower, var_10);
        wp::assign(var_upper, var_11);
    goto start_while_0;
    end_while_0:;
    // return upper                                                                           <L 9>
    return var_upper;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:79
static CUDA_CALLABLE void triangle_closest_point_0(
    wp::vec_t<3, wp::float32> var_a,
    wp::vec_t<3, wp::float32> var_b,
    wp::vec_t<3, wp::float32> var_c,
    wp::vec_t<3, wp::float32> var_p,
    wp::vec_t<3, wp::float32> & ret_0,
    wp::vec_t<3, wp::float32> & ret_1,
    wp::int32 & ret_2)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    wp::vec_t<3, wp::float32> var_1;
    wp::vec_t<3, wp::float32> var_2;
    wp::float32 var_3;
    wp::float32 var_4;
    bool var_5;
    const wp::float32 var_6 = 0.0;
    bool var_7;
    const wp::float32 var_8 = 0.0;
    bool var_9;
    const wp::int32 var_10 = 0;
    wp::int32 var_11;
    const wp::float32 var_12 = 1.0;
    const wp::float32 var_13 = 0.0;
    const wp::float32 var_14 = 0.0;
    wp::vec_t<3, wp::float32> var_15;
    wp::vec_t<3, wp::float32> var_16;
    wp::float32 var_17;
    wp::float32 var_18;
    bool var_19;
    const wp::float32 var_20 = 0.0;
    bool var_21;
    bool var_22;
    const wp::int32 var_23 = 1;
    wp::int32 var_24;
    const wp::float32 var_25 = 0.0;
    const wp::float32 var_26 = 1.0;
    const wp::float32 var_27 = 0.0;
    wp::vec_t<3, wp::float32> var_28;
    wp::int32 var_29;
    wp::vec_t<3, wp::float32> var_30;
    wp::vec_t<3, wp::float32> var_31;
    wp::float32 var_32;
    wp::float32 var_33;
    bool var_34;
    const wp::float32 var_35 = 0.0;
    bool var_36;
    bool var_37;
    const wp::int32 var_38 = 2;
    wp::int32 var_39;
    const wp::float32 var_40 = 0.0;
    const wp::float32 var_41 = 0.0;
    const wp::float32 var_42 = 1.0;
    wp::vec_t<3, wp::float32> var_43;
    wp::int32 var_44;
    wp::vec_t<3, wp::float32> var_45;
    wp::float32 var_46;
    wp::float32 var_47;
    wp::float32 var_48;
    bool var_49;
    const wp::float32 var_50 = 0.0;
    bool var_51;
    const wp::float32 var_52 = 0.0;
    bool var_53;
    const wp::float32 var_54 = 0.0;
    bool var_55;
    wp::float32 var_56;
    wp::float32 var_57;
    const wp::int32 var_58 = 3;
    wp::int32 var_59;
    const wp::float32 var_60 = 1.0;
    wp::float32 var_61;
    const wp::float32 var_62 = 0.0;
    wp::vec_t<3, wp::float32> var_63;
    wp::vec_t<3, wp::float32> var_64;
    wp::vec_t<3, wp::float32> var_65;
    wp::int32 var_66;
    wp::vec_t<3, wp::float32> var_67;
    wp::float32 var_68;
    wp::float32 var_69;
    wp::float32 var_70;
    bool var_71;
    const wp::float32 var_72 = 0.0;
    bool var_73;
    const wp::float32 var_74 = 0.0;
    bool var_75;
    const wp::float32 var_76 = 0.0;
    bool var_77;
    wp::float32 var_78;
    wp::float32 var_79;
    const wp::int32 var_80 = 4;
    wp::int32 var_81;
    const wp::float32 var_82 = 1.0;
    wp::float32 var_83;
    const wp::float32 var_84 = 0.0;
    wp::vec_t<3, wp::float32> var_85;
    wp::vec_t<3, wp::float32> var_86;
    wp::vec_t<3, wp::float32> var_87;
    wp::int32 var_88;
    wp::vec_t<3, wp::float32> var_89;
    wp::float32 var_90;
    wp::float32 var_91;
    wp::float32 var_92;
    wp::float32 var_93;
    bool var_94;
    const wp::float32 var_95 = 0.0;
    bool var_96;
    wp::float32 var_97;
    const wp::float32 var_98 = 0.0;
    bool var_99;
    wp::float32 var_100;
    const wp::float32 var_101 = 0.0;
    bool var_102;
    wp::float32 var_103;
    wp::float32 var_104;
    wp::float32 var_105;
    wp::float32 var_106;
    wp::float32 var_107;
    const wp::int32 var_108 = 5;
    wp::int32 var_109;
    const wp::float32 var_110 = 0.0;
    const wp::float32 var_111 = 1.0;
    wp::float32 var_112;
    wp::vec_t<3, wp::float32> var_113;
    wp::vec_t<3, wp::float32> var_114;
    wp::vec_t<3, wp::float32> var_115;
    wp::vec_t<3, wp::float32> var_116;
    wp::int32 var_117;
    wp::vec_t<3, wp::float32> var_118;
    wp::float32 var_119;
    const wp::float32 var_120 = 1.0;
    wp::float32 var_121;
    wp::float32 var_122;
    wp::float32 var_123;
    wp::float32 var_124;
    wp::float32 var_125;
    const wp::int32 var_126 = 6;
    wp::int32 var_127;
    const wp::float32 var_128 = 1.0;
    wp::float32 var_129;
    wp::float32 var_130;
    wp::vec_t<3, wp::float32> var_131;
    wp::vec_t<3, wp::float32> var_132;
    wp::vec_t<3, wp::float32> var_133;
    wp::vec_t<3, wp::float32> var_134;
    wp::vec_t<3, wp::float32> var_135;
    //---------
    // forward
    // def triangle_closest_point(a: wp.vec3, b: wp.vec3, c: wp.vec3, p: wp.vec3):            <L 80>
    // ab = b - a                                                                             <L 91>
    var_0 = wp::sub(var_b, var_a);
    // ac = c - a                                                                             <L 92>
    var_1 = wp::sub(var_c, var_a);
    // ap = p - a                                                                             <L 93>
    var_2 = wp::sub(var_p, var_a);
    // d1 = wp.dot(ab, ap)                                                                    <L 95>
    var_3 = wp::dot(var_0, var_2);
    // d2 = wp.dot(ac, ap)                                                                    <L 96>
    var_4 = wp::dot(var_1, var_2);
    // if d1 <= 0.0 and d2 <= 0.0:                                                            <L 97>
    var_7 = (var_3 <= var_6);
    var_5 = var_7;
    if (var_5) {
        var_9 = (var_4 <= var_8);
        var_5 = var_5 && var_9;
    }
    if (var_5) {
        // feature_type = TRI_CONTACT_FEATURE_VERTEX_A                                        <L 98>
        var_11 = wp::copy(var_10);
        // bary = wp.vec3(1.0, 0.0, 0.0)                                                      <L 99>
        var_15 = wp::vec_t<3, wp::float32>(var_12, var_13, var_14);
        // return a, bary, feature_type                                                       <L 100>
        ret_0 = var_a;
        ret_1 = var_15;
        ret_2 = var_11;
        return;
    }
    // bp = p - b                                                                             <L 102>
    var_16 = wp::sub(var_p, var_b);
    // d3 = wp.dot(ab, bp)                                                                    <L 103>
    var_17 = wp::dot(var_0, var_16);
    // d4 = wp.dot(ac, bp)                                                                    <L 104>
    var_18 = wp::dot(var_1, var_16);
    // if d3 >= 0.0 and d4 <= d3:                                                             <L 105>
    var_21 = (var_17 >= var_20);
    var_19 = var_21;
    if (var_19) {
        var_22 = (var_18 <= var_17);
        var_19 = var_19 && var_22;
    }
    if (var_19) {
        // feature_type = TRI_CONTACT_FEATURE_VERTEX_B                                        <L 106>
        var_24 = wp::copy(var_23);
        // bary = wp.vec3(0.0, 1.0, 0.0)                                                      <L 107>
        var_28 = wp::vec_t<3, wp::float32>(var_25, var_26, var_27);
        // return b, bary, feature_type                                                       <L 108>
        ret_0 = var_b;
        ret_1 = var_28;
        ret_2 = var_24;
        return;
    }
    var_29 = wp::where(var_19, var_24, var_11);
    var_30 = wp::where(var_19, var_28, var_15);
    // cp = p - c                                                                             <L 110>
    var_31 = wp::sub(var_p, var_c);
    // d5 = wp.dot(ab, cp)                                                                    <L 111>
    var_32 = wp::dot(var_0, var_31);
    // d6 = wp.dot(ac, cp)                                                                    <L 112>
    var_33 = wp::dot(var_1, var_31);
    // if d6 >= 0.0 and d5 <= d6:                                                             <L 113>
    var_36 = (var_33 >= var_35);
    var_34 = var_36;
    if (var_34) {
        var_37 = (var_32 <= var_33);
        var_34 = var_34 && var_37;
    }
    if (var_34) {
        // feature_type = TRI_CONTACT_FEATURE_VERTEX_C                                        <L 114>
        var_39 = wp::copy(var_38);
        // bary = wp.vec3(0.0, 0.0, 1.0)                                                      <L 115>
        var_43 = wp::vec_t<3, wp::float32>(var_40, var_41, var_42);
        // return c, bary, feature_type                                                       <L 116>
        ret_0 = var_c;
        ret_1 = var_43;
        ret_2 = var_39;
        return;
    }
    var_44 = wp::where(var_34, var_39, var_29);
    var_45 = wp::where(var_34, var_43, var_30);
    // vc = d1 * d4 - d3 * d2                                                                 <L 118>
    var_46 = wp::mul(var_3, var_18);
    var_47 = wp::mul(var_17, var_4);
    var_48 = wp::sub(var_46, var_47);
    // if vc <= 0.0 and d1 >= 0.0 and d3 <= 0.0:                                              <L 119>
    var_51 = (var_48 <= var_50);
    var_49 = var_51;
    if (var_49) {
        var_53 = (var_3 >= var_52);
        var_49 = var_49 && var_53;
    }
    if (var_49) {
        var_55 = (var_17 <= var_54);
        var_49 = var_49 && var_55;
    }
    if (var_49) {
        // v = d1 / (d1 - d3)                                                                 <L 120>
        var_56 = wp::sub(var_3, var_17);
        var_57 = wp::div(var_3, var_56);
        // feature_type = TRI_CONTACT_FEATURE_EDGE_AB                                         <L 121>
        var_59 = wp::copy(var_58);
        // bary = wp.vec3(1.0 - v, v, 0.0)                                                    <L 122>
        var_61 = wp::sub(var_60, var_57);
        var_63 = wp::vec_t<3, wp::float32>(var_61, var_57, var_62);
        // return a + v * ab, bary, feature_type                                              <L 123>
        var_64 = wp::mul(var_57, var_0);
        var_65 = wp::add(var_a, var_64);
        ret_0 = var_65;
        ret_1 = var_63;
        ret_2 = var_59;
        return;
    }
    var_66 = wp::where(var_49, var_59, var_44);
    var_67 = wp::where(var_49, var_63, var_45);
    // vb = d5 * d2 - d1 * d6                                                                 <L 125>
    var_68 = wp::mul(var_32, var_4);
    var_69 = wp::mul(var_3, var_33);
    var_70 = wp::sub(var_68, var_69);
    // if vb <= 0.0 and d2 >= 0.0 and d6 <= 0.0:                                              <L 126>
    var_73 = (var_70 <= var_72);
    var_71 = var_73;
    if (var_71) {
        var_75 = (var_4 >= var_74);
        var_71 = var_71 && var_75;
    }
    if (var_71) {
        var_77 = (var_33 <= var_76);
        var_71 = var_71 && var_77;
    }
    if (var_71) {
        // v = d2 / (d2 - d6)                                                                 <L 127>
        var_78 = wp::sub(var_4, var_33);
        var_79 = wp::div(var_4, var_78);
        // feature_type = TRI_CONTACT_FEATURE_EDGE_AC                                         <L 128>
        var_81 = wp::copy(var_80);
        // bary = wp.vec3(1.0 - v, 0.0, v)                                                    <L 129>
        var_83 = wp::sub(var_82, var_79);
        var_85 = wp::vec_t<3, wp::float32>(var_83, var_84, var_79);
        // return a + v * ac, bary, feature_type                                              <L 130>
        var_86 = wp::mul(var_79, var_1);
        var_87 = wp::add(var_a, var_86);
        ret_0 = var_87;
        ret_1 = var_85;
        ret_2 = var_81;
        return;
    }
    var_88 = wp::where(var_71, var_81, var_66);
    var_89 = wp::where(var_71, var_85, var_67);
    var_90 = wp::where(var_71, var_79, var_57);
    // va = d3 * d6 - d5 * d4                                                                 <L 132>
    var_91 = wp::mul(var_17, var_33);
    var_92 = wp::mul(var_32, var_18);
    var_93 = wp::sub(var_91, var_92);
    // if va <= 0.0 and (d4 - d3) >= 0.0 and (d5 - d6) >= 0.0:                                <L 133>
    var_96 = (var_93 <= var_95);
    var_94 = var_96;
    if (var_94) {
        var_97 = wp::sub(var_18, var_17);
        var_99 = (var_97 >= var_98);
        var_94 = var_94 && var_99;
    }
    if (var_94) {
        var_100 = wp::sub(var_32, var_33);
        var_102 = (var_100 >= var_101);
        var_94 = var_94 && var_102;
    }
    if (var_94) {
        // v = (d4 - d3) / ((d4 - d3) + (d5 - d6))                                            <L 134>
        var_103 = wp::sub(var_18, var_17);
        var_104 = wp::sub(var_18, var_17);
        var_105 = wp::sub(var_32, var_33);
        var_106 = wp::add(var_104, var_105);
        var_107 = wp::div(var_103, var_106);
        // feature_type = TRI_CONTACT_FEATURE_EDGE_BC                                         <L 135>
        var_109 = wp::copy(var_108);
        // bary = wp.vec3(0.0, 1.0 - v, v)                                                    <L 136>
        var_112 = wp::sub(var_111, var_107);
        var_113 = wp::vec_t<3, wp::float32>(var_110, var_112, var_107);
        // return b + v * (c - b), bary, feature_type                                         <L 137>
        var_114 = wp::sub(var_c, var_b);
        var_115 = wp::mul(var_107, var_114);
        var_116 = wp::add(var_b, var_115);
        ret_0 = var_116;
        ret_1 = var_113;
        ret_2 = var_109;
        return;
    }
    var_117 = wp::where(var_94, var_109, var_88);
    var_118 = wp::where(var_94, var_113, var_89);
    var_119 = wp::where(var_94, var_107, var_90);
    // denom = 1.0 / (va + vb + vc)                                                           <L 139>
    var_121 = wp::add(var_93, var_70);
    var_122 = wp::add(var_121, var_48);
    var_123 = wp::div(var_120, var_122);
    // v = vb * denom                                                                         <L 140>
    var_124 = wp::mul(var_70, var_123);
    // w = vc * denom                                                                         <L 141>
    var_125 = wp::mul(var_48, var_123);
    // feature_type = TRI_CONTACT_FEATURE_FACE_INTERIOR                                       <L 142>
    var_127 = wp::copy(var_126);
    // bary = wp.vec3(1.0 - v - w, v, w)                                                      <L 143>
    var_129 = wp::sub(var_128, var_124);
    var_130 = wp::sub(var_129, var_125);
    var_131 = wp::vec_t<3, wp::float32>(var_130, var_124, var_125);
    // return a + v * ab + w * ac, bary, feature_type                                         <L 144>
    var_132 = wp::mul(var_124, var_0);
    var_133 = wp::add(var_a, var_132);
    var_134 = wp::mul(var_125, var_1);
    var_135 = wp::add(var_133, var_134);
    ret_0 = var_135;
    ret_1 = var_131;
    ret_2 = var_127;
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:1011
static CUDA_CALLABLE wp::int32 replay_counter_increment_0(
    wp::array_t<wp::int32> var_counter,
    wp::int32 var_counter_index,
    wp::array_t<wp::int32> var_tids,
    wp::int32 var_tid,
    wp::int32 var_index_limit)
{
    //---------
    // primal vars
    wp::shape_t* var_0;
    const wp::int32 var_1 = 0;
    wp::int32 var_2;
    wp::shape_t var_3;
    bool var_4;
    wp::int32* var_5;
    wp::int32 var_6;
    wp::int32 var_7;
    const wp::int32 var_8 = -1;
    //---------
    // forward
    // def counter_increment_replay(                                                          <L 1012>
    // if tid < tids.shape[0]:                                                                <L 1015>
    var_0 = &(var_tids.shape);
    var_3 = wp::load(var_0);
    var_2 = wp::extract(var_3, var_1);
    var_4 = (var_tid < var_2);
    if (var_4) {
        // return tids[tid]                                                                   <L 1016>
        var_5 = wp::address(var_tids, var_tid);
        var_7 = wp::load(var_5);
        var_6 = wp::copy(var_7);
        return var_6;
    }
    // return -1                                                                              <L 1017>
    return var_8;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:1206
static CUDA_CALLABLE void adj_compute_tri_aabb_0(
    wp::vec_t<3, wp::float32> var_v1,
    wp::vec_t<3, wp::float32> var_v2,
    wp::vec_t<3, wp::float32> var_v3,
    wp::vec_t<3, wp::float32> & ret_0,
    wp::vec_t<3, wp::float32> & ret_1,
    wp::vec_t<3, wp::float32> & adj_v1,
    wp::vec_t<3, wp::float32> & adj_v2,
    wp::vec_t<3, wp::float32> & adj_v3,
    wp::vec_t<3, wp::float32> & adj_ret_0,
    wp::vec_t<3, wp::float32> & adj_ret_1)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    wp::vec_t<3, wp::float32> var_1;
    wp::vec_t<3, wp::float32> var_2;
    wp::vec_t<3, wp::float32> var_3;
    //---------
    // dual vars
    wp::vec_t<3, wp::float32> adj_0 = {};
    wp::vec_t<3, wp::float32> adj_1 = {};
    wp::vec_t<3, wp::float32> adj_2 = {};
    wp::vec_t<3, wp::float32> adj_3 = {};
    //---------
    // forward
    // def compute_tri_aabb(                                                                  <L 1207>
    // lower = wp.min(wp.min(v1, v2), v3)                                                     <L 1212>
    var_0 = wp::min(var_v1, var_v2);
    var_1 = wp::min(var_0, var_v3);
    // upper = wp.max(wp.max(v1, v2), v3)                                                     <L 1213>
    var_2 = wp::max(var_v1, var_v2);
    var_3 = wp::max(var_2, var_v3);
    // return lower, upper                                                                    <L 1215>
    ret_0 = var_1;
    ret_1 = var_3;
    goto label0;
    //---------
    // reverse
    label0:;
    adj_3 += adj_ret_1;
    adj_1 += adj_ret_0;
    // adj: return lower, upper                                                               <L 1215>
    wp::adj_max(var_2, var_v3, adj_2, adj_v3, adj_3);
    wp::adj_max(var_v1, var_v2, adj_v1, adj_v2, adj_2);
    // adj: upper = wp.max(wp.max(v1, v2), v3)                                                <L 1213>
    wp::adj_min(var_0, var_v3, adj_0, adj_v3, adj_1);
    wp::adj_min(var_v1, var_v2, adj_v1, adj_v2, adj_0);
    // adj: lower = wp.min(wp.min(v1, v2), v3)                                                <L 1212>
    // adj: def compute_tri_aabb(                                                             <L 1207>
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:1305
static CUDA_CALLABLE void adj_vertex_adjacent_to_triangle_0(
    wp::int32 var_v,
    wp::int32 var_a,
    wp::int32 var_b,
    wp::int32 var_c,
    wp::int32 & adj_v,
    wp::int32 & adj_a,
    wp::int32 & adj_b,
    wp::int32 & adj_c,
    bool & adj_ret)
{
    //---------
    // primal vars
    bool var_0;
    bool var_1;
    bool var_2;
    bool var_3;
    //---------
    // dual vars
    bool adj_0 = {};
    bool adj_1 = {};
    bool adj_2 = {};
    bool adj_3 = {};
    //---------
    // forward
    // def vertex_adjacent_to_triangle(v: wp.int32, a: wp.int32, b: wp.int32, c: wp.int32):       <L 1306>
    // return v == a or v == b or v == c                                                      <L 1307>
    var_1 = (var_v == var_a);
    var_0 = var_1;
    if (!var_0) {
        var_2 = (var_v == var_b);
        var_0 = var_0 || var_2;
    }
    if (!var_0) {
        var_3 = (var_v == var_c);
        var_0 = var_0 || var_3;
    }
    goto label0;
    //---------
    // reverse
    label0:;
    adj_0 += adj_ret;
    if (!var_0) {
    }
    if (!var_0) {
    }
    // adj: return v == a or v == b or v == c                                                 <L 1307>
    // adj: def vertex_adjacent_to_triangle(v: wp.int32, a: wp.int32, b: wp.int32, c: wp.int32):  <L 1306>
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:180
static CUDA_CALLABLE void adj_sdf_sphere_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::float32 var_radius,
    wp::vec_t<3, wp::float32> & adj_point,
    wp::float32 & adj_radius,
    wp::float32 & adj_ret)
{
    //---------
    // primal vars
    wp::float32 var_0;
    wp::float32 var_1;
    //---------
    // dual vars
    wp::float32 adj_0 = {};
    wp::float32 adj_1 = {};
    //---------
    // forward
    // def sdf_sphere(point: wp.vec3, radius: float):                                         <L 181>
    // return wp.length(point) - radius                                                       <L 191>
    var_0 = wp::length(var_point);
    var_1 = wp::sub(var_0, var_radius);
    goto label0;
    //---------
    // reverse
    label0:;
    adj_1 += adj_ret;
    wp::adj_sub(var_0, var_radius, adj_0, adj_radius, adj_1);
    wp::adj_length(var_point, var_0, adj_point, adj_0);
    // adj: return wp.length(point) - radius                                                  <L 191>
    // adj: def sdf_sphere(point: wp.vec3, radius: float):                                    <L 181>
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:194
static CUDA_CALLABLE void adj_sdf_sphere_grad_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::float32 var_radius,
    wp::vec_t<3, wp::float32> & adj_point,
    wp::float32 & adj_radius,
    wp::vec_t<3, wp::float32> & adj_ret)
{
    //---------
    // primal vars
    wp::float32 var_0;
    const wp::float32 var_1 = 1e-08;
    wp::float32 var_2;
    bool var_3;
    wp::vec_t<3, wp::float32> var_4;
    const wp::float32 var_5 = 0.0;
    const wp::float32 var_6 = 0.0;
    const wp::float32 var_7 = 1.0;
    wp::vec_t<3, wp::float32> var_8;
    //---------
    // dual vars
    wp::float32 adj_0 = {};
    wp::float32 adj_1 = {};
    wp::float32 adj_2 = {};
    bool adj_3 = {};
    wp::vec_t<3, wp::float32> adj_4 = {};
    wp::float32 adj_5 = {};
    wp::float32 adj_6 = {};
    wp::float32 adj_7 = {};
    wp::vec_t<3, wp::float32> adj_8 = {};
    //---------
    // forward
    // def sdf_sphere_grad(point: wp.vec3, radius: float):                                    <L 195>
    // _ = radius                                                                             <L 205>
    var_0 = wp::copy(var_radius);
    // eps = 1.0e-8                                                                           <L 206>
    // p_len = wp.length(point)                                                               <L 207>
    var_2 = wp::length(var_point);
    // if p_len > eps:                                                                        <L 208>
    var_3 = (var_2 > var_1);
    if (var_3) {
        // return point / p_len                                                               <L 209>
        var_4 = wp::div(var_point, var_2);
        goto label0;
    }
    // return wp.vec3(0.0, 0.0, 1.0)                                                          <L 210>
    var_8 = wp::vec_t<3, wp::float32>(var_5, var_6, var_7);
    goto label1;
    //---------
    // reverse
    label1:;
    adj_8 += adj_ret;
    wp::adj_vec_t(var_5, var_6, var_7, adj_5, adj_6, adj_7, adj_8);
    // adj: return wp.vec3(0.0, 0.0, 1.0)                                                     <L 210>
    if (var_3) {
        label0:;
        adj_4 += adj_ret;
        wp::adj_div(var_point, var_2, adj_point, adj_2, adj_4);
        // adj: return point / p_len                                                          <L 209>
    }
    // adj: if p_len > eps:                                                                   <L 208>
    wp::adj_length(var_point, var_2, adj_point, adj_2);
    // adj: p_len = wp.length(point)                                                          <L 207>
    // adj: eps = 1.0e-8                                                                      <L 206>
    wp::adj_copy(var_radius, adj_radius, adj_0);
    // adj: _ = radius                                                                        <L 205>
    // adj: def sdf_sphere_grad(point: wp.vec3, radius: float):                               <L 195>
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:213
static CUDA_CALLABLE void adj_sdf_box_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::float32 var_hx,
    wp::float32 var_hy,
    wp::float32 var_hz,
    wp::vec_t<3, wp::float32> & adj_point,
    wp::float32 & adj_hx,
    wp::float32 & adj_hy,
    wp::float32 & adj_hz,
    wp::float32 & adj_ret)
{
    //---------
    // primal vars
    const wp::int32 var_0 = 0;
    wp::float32 var_1;
    wp::float32 var_2;
    wp::float32 var_3;
    const wp::int32 var_4 = 1;
    wp::float32 var_5;
    wp::float32 var_6;
    wp::float32 var_7;
    const wp::int32 var_8 = 2;
    wp::float32 var_9;
    wp::float32 var_10;
    wp::float32 var_11;
    const wp::float32 var_12 = 0.0;
    wp::float32 var_13;
    const wp::float32 var_14 = 0.0;
    wp::float32 var_15;
    const wp::float32 var_16 = 0.0;
    wp::float32 var_17;
    wp::vec_t<3, wp::float32> var_18;
    wp::float32 var_19;
    wp::float32 var_20;
    wp::float32 var_21;
    const wp::float32 var_22 = 0.0;
    wp::float32 var_23;
    wp::float32 var_24;
    //---------
    // dual vars
    wp::int32 adj_0 = {};
    wp::float32 adj_1 = {};
    wp::float32 adj_2 = {};
    wp::float32 adj_3 = {};
    wp::int32 adj_4 = {};
    wp::float32 adj_5 = {};
    wp::float32 adj_6 = {};
    wp::float32 adj_7 = {};
    wp::int32 adj_8 = {};
    wp::float32 adj_9 = {};
    wp::float32 adj_10 = {};
    wp::float32 adj_11 = {};
    wp::float32 adj_12 = {};
    wp::float32 adj_13 = {};
    wp::float32 adj_14 = {};
    wp::float32 adj_15 = {};
    wp::float32 adj_16 = {};
    wp::float32 adj_17 = {};
    wp::vec_t<3, wp::float32> adj_18 = {};
    wp::float32 adj_19 = {};
    wp::float32 adj_20 = {};
    wp::float32 adj_21 = {};
    wp::float32 adj_22 = {};
    wp::float32 adj_23 = {};
    wp::float32 adj_24 = {};
    //---------
    // forward
    // def sdf_box(point: wp.vec3, hx: float, hy: float, hz: float):                          <L 214>
    // qx = abs(point[0]) - hx                                                                <L 227>
    var_1 = wp::extract(var_point, var_0);
    var_2 = wp::abs(var_1);
    var_3 = wp::sub(var_2, var_hx);
    // qy = abs(point[1]) - hy                                                                <L 228>
    var_5 = wp::extract(var_point, var_4);
    var_6 = wp::abs(var_5);
    var_7 = wp::sub(var_6, var_hy);
    // qz = abs(point[2]) - hz                                                                <L 229>
    var_9 = wp::extract(var_point, var_8);
    var_10 = wp::abs(var_9);
    var_11 = wp::sub(var_10, var_hz);
    // e = wp.vec3(wp.max(qx, 0.0), wp.max(qy, 0.0), wp.max(qz, 0.0))                         <L 231>
    var_13 = wp::max(var_3, var_12);
    var_15 = wp::max(var_7, var_14);
    var_17 = wp::max(var_11, var_16);
    var_18 = wp::vec_t<3, wp::float32>(var_13, var_15, var_17);
    // return wp.length(e) + wp.min(wp.max(qx, wp.max(qy, qz)), 0.0)                          <L 233>
    var_19 = wp::length(var_18);
    var_20 = wp::max(var_7, var_11);
    var_21 = wp::max(var_3, var_20);
    var_23 = wp::min(var_21, var_22);
    var_24 = wp::add(var_19, var_23);
    goto label0;
    //---------
    // reverse
    label0:;
    adj_24 += adj_ret;
    wp::adj_add(var_19, var_23, adj_19, adj_23, adj_24);
    wp::adj_min(var_21, var_22, adj_21, adj_22, adj_23);
    wp::adj_max(var_3, var_20, adj_3, adj_20, adj_21);
    wp::adj_max(var_7, var_11, adj_7, adj_11, adj_20);
    wp::adj_length(var_18, var_19, adj_18, adj_19);
    // adj: return wp.length(e) + wp.min(wp.max(qx, wp.max(qy, qz)), 0.0)                     <L 233>
    wp::adj_vec_t(var_13, var_15, var_17, adj_13, adj_15, adj_17, adj_18);
    wp::adj_max(var_11, var_16, adj_11, adj_16, adj_17);
    wp::adj_max(var_7, var_14, adj_7, adj_14, adj_15);
    wp::adj_max(var_3, var_12, adj_3, adj_12, adj_13);
    // adj: e = wp.vec3(wp.max(qx, 0.0), wp.max(qy, 0.0), wp.max(qz, 0.0))                    <L 231>
    wp::adj_sub(var_10, var_hz, adj_10, adj_hz, adj_11);
    wp::adj_abs(var_9, adj_9, adj_10);
    wp::adj_extract(var_point, var_8, adj_point, adj_8, adj_9);
    // adj: qz = abs(point[2]) - hz                                                           <L 229>
    wp::adj_sub(var_6, var_hy, adj_6, adj_hy, adj_7);
    wp::adj_abs(var_5, adj_5, adj_6);
    wp::adj_extract(var_point, var_4, adj_point, adj_4, adj_5);
    // adj: qy = abs(point[1]) - hy                                                           <L 228>
    wp::adj_sub(var_2, var_hx, adj_2, adj_hx, adj_3);
    wp::adj_abs(var_1, adj_1, adj_2);
    wp::adj_extract(var_point, var_0, adj_point, adj_0, adj_1);
    // adj: qx = abs(point[0]) - hx                                                           <L 227>
    // adj: def sdf_box(point: wp.vec3, hx: float, hy: float, hz: float):                     <L 214>
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:236
static CUDA_CALLABLE void adj_sdf_box_grad_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::float32 var_hx,
    wp::float32 var_hy,
    wp::float32 var_hz,
    wp::vec_t<3, wp::float32> & adj_point,
    wp::float32 & adj_hx,
    wp::float32 & adj_hy,
    wp::float32 & adj_hz,
    wp::vec_t<3, wp::float32> & adj_ret)
{
    //---------
    // primal vars
    const wp::int32 var_0 = 0;
    wp::float32 var_1;
    wp::float32 var_2;
    wp::float32 var_3;
    const wp::int32 var_4 = 1;
    wp::float32 var_5;
    wp::float32 var_6;
    wp::float32 var_7;
    const wp::int32 var_8 = 2;
    wp::float32 var_9;
    wp::float32 var_10;
    wp::float32 var_11;
    bool var_12;
    const wp::float32 var_13 = 0.0;
    bool var_14;
    const wp::float32 var_15 = 0.0;
    bool var_16;
    const wp::float32 var_17 = 0.0;
    bool var_18;
    const wp::int32 var_19 = 0;
    wp::float32 var_20;
    wp::float32 var_21;
    wp::float32 var_22;
    const wp::int32 var_23 = 1;
    wp::float32 var_24;
    wp::float32 var_25;
    wp::float32 var_26;
    const wp::int32 var_27 = 2;
    wp::float32 var_28;
    wp::float32 var_29;
    wp::float32 var_30;
    wp::vec_t<3, wp::float32> var_31;
    wp::vec_t<3, wp::float32> var_32;
    wp::vec_t<3, wp::float32> var_33;
    const wp::int32 var_34 = 0;
    wp::float32 var_35;
    wp::float32 var_36;
    const wp::int32 var_37 = 1;
    wp::float32 var_38;
    wp::float32 var_39;
    const wp::int32 var_40 = 2;
    wp::float32 var_41;
    wp::float32 var_42;
    bool var_43;
    bool var_44;
    bool var_45;
    bool var_46;
    bool var_47;
    const wp::float32 var_48 = 0.0;
    bool var_49;
    const wp::float32 var_50 = 0.0;
    bool var_51;
    const wp::float32 var_52 = 0.0;
    const wp::float32 var_53 = 0.0;
    wp::vec_t<3, wp::float32> var_54;
    bool var_55;
    bool var_56;
    bool var_57;
    bool var_58;
    bool var_59;
    const wp::float32 var_60 = 0.0;
    bool var_61;
    const wp::float32 var_62 = 0.0;
    bool var_63;
    const wp::float32 var_64 = 0.0;
    const wp::float32 var_65 = 0.0;
    wp::vec_t<3, wp::float32> var_66;
    const wp::float32 var_67 = 0.0;
    const wp::float32 var_68 = 0.0;
    wp::vec_t<3, wp::float32> var_69;
    //---------
    // dual vars
    wp::int32 adj_0 = {};
    wp::float32 adj_1 = {};
    wp::float32 adj_2 = {};
    wp::float32 adj_3 = {};
    wp::int32 adj_4 = {};
    wp::float32 adj_5 = {};
    wp::float32 adj_6 = {};
    wp::float32 adj_7 = {};
    wp::int32 adj_8 = {};
    wp::float32 adj_9 = {};
    wp::float32 adj_10 = {};
    wp::float32 adj_11 = {};
    bool adj_12 = {};
    wp::float32 adj_13 = {};
    bool adj_14 = {};
    wp::float32 adj_15 = {};
    bool adj_16 = {};
    wp::float32 adj_17 = {};
    bool adj_18 = {};
    wp::int32 adj_19 = {};
    wp::float32 adj_20 = {};
    wp::float32 adj_21 = {};
    wp::float32 adj_22 = {};
    wp::int32 adj_23 = {};
    wp::float32 adj_24 = {};
    wp::float32 adj_25 = {};
    wp::float32 adj_26 = {};
    wp::int32 adj_27 = {};
    wp::float32 adj_28 = {};
    wp::float32 adj_29 = {};
    wp::float32 adj_30 = {};
    wp::vec_t<3, wp::float32> adj_31 = {};
    wp::vec_t<3, wp::float32> adj_32 = {};
    wp::vec_t<3, wp::float32> adj_33 = {};
    wp::int32 adj_34 = {};
    wp::float32 adj_35 = {};
    wp::float32 adj_36 = {};
    wp::int32 adj_37 = {};
    wp::float32 adj_38 = {};
    wp::float32 adj_39 = {};
    wp::int32 adj_40 = {};
    wp::float32 adj_41 = {};
    wp::float32 adj_42 = {};
    bool adj_43 = {};
    bool adj_44 = {};
    bool adj_45 = {};
    bool adj_46 = {};
    bool adj_47 = {};
    wp::float32 adj_48 = {};
    bool adj_49 = {};
    wp::float32 adj_50 = {};
    bool adj_51 = {};
    wp::float32 adj_52 = {};
    wp::float32 adj_53 = {};
    wp::vec_t<3, wp::float32> adj_54 = {};
    bool adj_55 = {};
    bool adj_56 = {};
    bool adj_57 = {};
    bool adj_58 = {};
    bool adj_59 = {};
    wp::float32 adj_60 = {};
    bool adj_61 = {};
    wp::float32 adj_62 = {};
    bool adj_63 = {};
    wp::float32 adj_64 = {};
    wp::float32 adj_65 = {};
    wp::vec_t<3, wp::float32> adj_66 = {};
    wp::float32 adj_67 = {};
    wp::float32 adj_68 = {};
    wp::vec_t<3, wp::float32> adj_69 = {};
    //---------
    // forward
    // def sdf_box_grad(point: wp.vec3, hx: float, hy: float, hz: float):                     <L 237>
    // qx = abs(point[0]) - hx                                                                <L 249>
    var_1 = wp::extract(var_point, var_0);
    var_2 = wp::abs(var_1);
    var_3 = wp::sub(var_2, var_hx);
    // qy = abs(point[1]) - hy                                                                <L 250>
    var_5 = wp::extract(var_point, var_4);
    var_6 = wp::abs(var_5);
    var_7 = wp::sub(var_6, var_hy);
    // qz = abs(point[2]) - hz                                                                <L 251>
    var_9 = wp::extract(var_point, var_8);
    var_10 = wp::abs(var_9);
    var_11 = wp::sub(var_10, var_hz);
    // if qx > 0.0 or qy > 0.0 or qz > 0.0:                                                   <L 254>
    var_14 = (var_3 > var_13);
    var_12 = var_14;
    if (!var_12) {
        var_16 = (var_7 > var_15);
        var_12 = var_12 || var_16;
    }
    if (!var_12) {
        var_18 = (var_11 > var_17);
        var_12 = var_12 || var_18;
    }
    if (var_12) {
        // x = wp.clamp(point[0], -hx, hx)                                                    <L 255>
        var_20 = wp::extract(var_point, var_19);
        var_21 = wp::neg(var_hx);
        var_22 = wp::clamp(var_20, var_21, var_hx);
        // y = wp.clamp(point[1], -hy, hy)                                                    <L 256>
        var_24 = wp::extract(var_point, var_23);
        var_25 = wp::neg(var_hy);
        var_26 = wp::clamp(var_24, var_25, var_hy);
        // z = wp.clamp(point[2], -hz, hz)                                                    <L 257>
        var_28 = wp::extract(var_point, var_27);
        var_29 = wp::neg(var_hz);
        var_30 = wp::clamp(var_28, var_29, var_hz);
        // return wp.normalize(point - wp.vec3(x, y, z))                                      <L 259>
        var_31 = wp::vec_t<3, wp::float32>(var_22, var_26, var_30);
        var_32 = wp::sub(var_point, var_31);
        var_33 = wp::normalize(var_32);
        goto label0;
    }
    // sx = wp.sign(point[0])                                                                 <L 261>
    var_35 = wp::extract(var_point, var_34);
    var_36 = wp::sign(var_35);
    // sy = wp.sign(point[1])                                                                 <L 262>
    var_38 = wp::extract(var_point, var_37);
    var_39 = wp::sign(var_38);
    // sz = wp.sign(point[2])                                                                 <L 263>
    var_41 = wp::extract(var_point, var_40);
    var_42 = wp::sign(var_41);
    // if (qx > qy and qx > qz) or (qy == 0.0 and qz == 0.0):                                 <L 266>
    var_45 = (var_3 > var_7);
    var_44 = var_45;
    if (var_44) {
        var_46 = (var_3 > var_11);
        var_44 = var_44 && var_46;
    }
    var_43 = var_44;
    if (!var_43) {
        var_49 = (var_7 == var_48);
        var_47 = var_49;
        if (var_47) {
            var_51 = (var_11 == var_50);
            var_47 = var_47 && var_51;
        }
        var_43 = var_43 || var_47;
    }
    if (var_43) {
        // return wp.vec3(sx, 0.0, 0.0)                                                       <L 267>
        var_54 = wp::vec_t<3, wp::float32>(var_36, var_52, var_53);
        goto label1;
    }
    // if (qy > qx and qy > qz) or (qx == 0.0 and qz == 0.0):                                 <L 270>
    var_57 = (var_7 > var_3);
    var_56 = var_57;
    if (var_56) {
        var_58 = (var_7 > var_11);
        var_56 = var_56 && var_58;
    }
    var_55 = var_56;
    if (!var_55) {
        var_61 = (var_3 == var_60);
        var_59 = var_61;
        if (var_59) {
            var_63 = (var_11 == var_62);
            var_59 = var_59 && var_63;
        }
        var_55 = var_55 || var_59;
    }
    if (var_55) {
        // return wp.vec3(0.0, sy, 0.0)                                                       <L 271>
        var_66 = wp::vec_t<3, wp::float32>(var_64, var_39, var_65);
        goto label2;
    }
    // return wp.vec3(0.0, 0.0, sz)                                                           <L 274>
    var_69 = wp::vec_t<3, wp::float32>(var_67, var_68, var_42);
    goto label3;
    //---------
    // reverse
    label3:;
    adj_69 += adj_ret;
    wp::adj_vec_t(var_67, var_68, var_42, adj_67, adj_68, adj_42, adj_69);
    // adj: return wp.vec3(0.0, 0.0, sz)                                                      <L 274>
    if (var_55) {
        label2:;
        adj_66 += adj_ret;
        wp::adj_vec_t(var_64, var_39, var_65, adj_64, adj_39, adj_65, adj_66);
        // adj: return wp.vec3(0.0, sy, 0.0)                                                  <L 271>
    }
    if (!var_55) {
        if (var_59) {
        }
    }
    if (var_56) {
    }
    // adj: if (qy > qx and qy > qz) or (qx == 0.0 and qz == 0.0):                            <L 270>
    if (var_43) {
        label1:;
        adj_54 += adj_ret;
        wp::adj_vec_t(var_36, var_52, var_53, adj_36, adj_52, adj_53, adj_54);
        // adj: return wp.vec3(sx, 0.0, 0.0)                                                  <L 267>
    }
    if (!var_43) {
        if (var_47) {
        }
    }
    if (var_44) {
    }
    // adj: if (qx > qy and qx > qz) or (qy == 0.0 and qz == 0.0):                            <L 266>
    wp::adj_extract(var_point, var_40, adj_point, adj_40, adj_41);
    // adj: sz = wp.sign(point[2])                                                            <L 263>
    wp::adj_extract(var_point, var_37, adj_point, adj_37, adj_38);
    // adj: sy = wp.sign(point[1])                                                            <L 262>
    wp::adj_extract(var_point, var_34, adj_point, adj_34, adj_35);
    // adj: sx = wp.sign(point[0])                                                            <L 261>
    if (var_12) {
        label0:;
        adj_33 += adj_ret;
        wp::adj_normalize(var_32, var_33, adj_32, adj_33);
        wp::adj_sub(var_point, var_31, adj_point, adj_31, adj_32);
        wp::adj_vec_t(var_22, var_26, var_30, adj_22, adj_26, adj_30, adj_31);
        // adj: return wp.normalize(point - wp.vec3(x, y, z))                                 <L 259>
        wp::adj_clamp(var_28, var_29, var_hz, adj_28, adj_29, adj_hz, adj_30);
        wp::adj_neg(var_hz, adj_hz, adj_29);
        wp::adj_extract(var_point, var_27, adj_point, adj_27, adj_28);
        // adj: z = wp.clamp(point[2], -hz, hz)                                               <L 257>
        wp::adj_clamp(var_24, var_25, var_hy, adj_24, adj_25, adj_hy, adj_26);
        wp::adj_neg(var_hy, adj_hy, adj_25);
        wp::adj_extract(var_point, var_23, adj_point, adj_23, adj_24);
        // adj: y = wp.clamp(point[1], -hy, hy)                                               <L 256>
        wp::adj_clamp(var_20, var_21, var_hx, adj_20, adj_21, adj_hx, adj_22);
        wp::adj_neg(var_hx, adj_hx, adj_21);
        wp::adj_extract(var_point, var_19, adj_point, adj_19, adj_20);
        // adj: x = wp.clamp(point[0], -hx, hx)                                               <L 255>
    }
    if (!var_12) {
    }
    if (!var_12) {
    }
    // adj: if qx > 0.0 or qy > 0.0 or qz > 0.0:                                              <L 254>
    wp::adj_sub(var_10, var_hz, adj_10, adj_hz, adj_11);
    wp::adj_abs(var_9, adj_9, adj_10);
    wp::adj_extract(var_point, var_8, adj_point, adj_8, adj_9);
    // adj: qz = abs(point[2]) - hz                                                           <L 251>
    wp::adj_sub(var_6, var_hy, adj_6, adj_hy, adj_7);
    wp::adj_abs(var_5, adj_5, adj_6);
    wp::adj_extract(var_point, var_4, adj_point, adj_4, adj_5);
    // adj: qy = abs(point[1]) - hy                                                           <L 250>
    wp::adj_sub(var_2, var_hx, adj_2, adj_hx, adj_3);
    wp::adj_abs(var_1, adj_1, adj_2);
    wp::adj_extract(var_point, var_0, adj_point, adj_0, adj_1);
    // adj: qx = abs(point[0]) - hx                                                           <L 249>
    // adj: def sdf_box_grad(point: wp.vec3, hx: float, hy: float, hz: float):                <L 237>
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:147
static CUDA_CALLABLE void adj__sdf_point_to_z_up_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::int32 var_up_axis,
    wp::vec_t<3, wp::float32> & adj_point,
    wp::int32 & adj_up_axis,
    wp::vec_t<3, wp::float32> & adj_ret)
{
    //---------
    // primal vars
    const wp::int32 var_0 = 0;
    const wp::int32 var_1 = 0;
    wp::int32 var_2;
    bool var_3;
    const wp::int32 var_4 = 1;
    wp::float32 var_5;
    const wp::int32 var_6 = 2;
    wp::float32 var_7;
    const wp::int32 var_8 = 0;
    wp::float32 var_9;
    wp::vec_t<3, wp::float32> var_10;
    const wp::int32 var_11 = 1;
    const wp::int32 var_12 = 1;
    wp::int32 var_13;
    bool var_14;
    const wp::int32 var_15 = 0;
    wp::float32 var_16;
    const wp::int32 var_17 = 2;
    wp::float32 var_18;
    const wp::int32 var_19 = 1;
    wp::float32 var_20;
    wp::vec_t<3, wp::float32> var_21;
    //---------
    // dual vars
    wp::int32 adj_0 = {};
    wp::int32 adj_1 = {};
    wp::int32 adj_2 = {};
    bool adj_3 = {};
    wp::int32 adj_4 = {};
    wp::float32 adj_5 = {};
    wp::int32 adj_6 = {};
    wp::float32 adj_7 = {};
    wp::int32 adj_8 = {};
    wp::float32 adj_9 = {};
    wp::vec_t<3, wp::float32> adj_10 = {};
    wp::int32 adj_11 = {};
    wp::int32 adj_12 = {};
    wp::int32 adj_13 = {};
    bool adj_14 = {};
    wp::int32 adj_15 = {};
    wp::float32 adj_16 = {};
    wp::int32 adj_17 = {};
    wp::float32 adj_18 = {};
    wp::int32 adj_19 = {};
    wp::float32 adj_20 = {};
    wp::vec_t<3, wp::float32> adj_21 = {};
    //---------
    // forward
    // def _sdf_point_to_z_up(point: wp.vec3, up_axis: int):                                  <L 148>
    // if up_axis == int(Axis.X):                                                             <L 149>
    var_2 = wp::int(var_1);
    var_3 = (var_up_axis == var_2);
    if (var_3) {
        // return wp.vec3(point[1], point[2], point[0])                                       <L 150>
        var_5 = wp::extract(var_point, var_4);
        var_7 = wp::extract(var_point, var_6);
        var_9 = wp::extract(var_point, var_8);
        var_10 = wp::vec_t<3, wp::float32>(var_5, var_7, var_9);
        goto label0;
    }
    // if up_axis == int(Axis.Y):                                                             <L 151>
    var_13 = wp::int(var_12);
    var_14 = (var_up_axis == var_13);
    if (var_14) {
        // return wp.vec3(point[0], point[2], point[1])                                       <L 152>
        var_16 = wp::extract(var_point, var_15);
        var_18 = wp::extract(var_point, var_17);
        var_20 = wp::extract(var_point, var_19);
        var_21 = wp::vec_t<3, wp::float32>(var_16, var_18, var_20);
        goto label1;
    }
    // return point                                                                           <L 153>
    goto label2;
    //---------
    // reverse
    label2:;
    adj_point += adj_ret;
    // adj: return point                                                                      <L 153>
    if (var_14) {
        label1:;
        adj_21 += adj_ret;
        wp::adj_vec_t(var_16, var_18, var_20, adj_16, adj_18, adj_20, adj_21);
        wp::adj_extract(var_point, var_19, adj_point, adj_19, adj_20);
        wp::adj_extract(var_point, var_17, adj_point, adj_17, adj_18);
        wp::adj_extract(var_point, var_15, adj_point, adj_15, adj_16);
        // adj: return wp.vec3(point[0], point[2], point[1])                                  <L 152>
    }
    // adj: if up_axis == int(Axis.Y):                                                        <L 151>
    if (var_3) {
        label0:;
        adj_10 += adj_ret;
        wp::adj_vec_t(var_5, var_7, var_9, adj_5, adj_7, adj_9, adj_10);
        wp::adj_extract(var_point, var_8, adj_point, adj_8, adj_9);
        wp::adj_extract(var_point, var_6, adj_point, adj_6, adj_7);
        wp::adj_extract(var_point, var_4, adj_point, adj_4, adj_5);
        // adj: return wp.vec3(point[1], point[2], point[0])                                  <L 150>
    }
    // adj: if up_axis == int(Axis.X):                                                        <L 149>
    // adj: def _sdf_point_to_z_up(point: wp.vec3, up_axis: int):                             <L 148>
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:277
static CUDA_CALLABLE void adj_sdf_capsule_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::float32 var_radius,
    wp::float32 var_half_height,
    wp::int32 var_up_axis,
    wp::vec_t<3, wp::float32> & adj_point,
    wp::float32 & adj_radius,
    wp::float32 & adj_half_height,
    wp::int32 & adj_up_axis,
    wp::float32 & adj_ret)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    const wp::int32 var_1 = 2;
    wp::float32 var_2;
    bool var_3;
    const wp::int32 var_4 = 0;
    wp::float32 var_5;
    const wp::int32 var_6 = 1;
    wp::float32 var_7;
    const wp::int32 var_8 = 2;
    wp::float32 var_9;
    wp::float32 var_10;
    wp::vec_t<3, wp::float32> var_11;
    wp::float32 var_12;
    wp::float32 var_13;
    const wp::int32 var_14 = 2;
    wp::float32 var_15;
    wp::float32 var_16;
    bool var_17;
    const wp::int32 var_18 = 0;
    wp::float32 var_19;
    const wp::int32 var_20 = 1;
    wp::float32 var_21;
    const wp::int32 var_22 = 2;
    wp::float32 var_23;
    wp::float32 var_24;
    wp::vec_t<3, wp::float32> var_25;
    wp::float32 var_26;
    wp::float32 var_27;
    const wp::int32 var_28 = 0;
    wp::float32 var_29;
    const wp::int32 var_30 = 1;
    wp::float32 var_31;
    const wp::float32 var_32 = 0.0;
    wp::vec_t<3, wp::float32> var_33;
    wp::float32 var_34;
    wp::float32 var_35;
    //---------
    // dual vars
    wp::vec_t<3, wp::float32> adj_0 = {};
    wp::int32 adj_1 = {};
    wp::float32 adj_2 = {};
    bool adj_3 = {};
    wp::int32 adj_4 = {};
    wp::float32 adj_5 = {};
    wp::int32 adj_6 = {};
    wp::float32 adj_7 = {};
    wp::int32 adj_8 = {};
    wp::float32 adj_9 = {};
    wp::float32 adj_10 = {};
    wp::vec_t<3, wp::float32> adj_11 = {};
    wp::float32 adj_12 = {};
    wp::float32 adj_13 = {};
    wp::int32 adj_14 = {};
    wp::float32 adj_15 = {};
    wp::float32 adj_16 = {};
    bool adj_17 = {};
    wp::int32 adj_18 = {};
    wp::float32 adj_19 = {};
    wp::int32 adj_20 = {};
    wp::float32 adj_21 = {};
    wp::int32 adj_22 = {};
    wp::float32 adj_23 = {};
    wp::float32 adj_24 = {};
    wp::vec_t<3, wp::float32> adj_25 = {};
    wp::float32 adj_26 = {};
    wp::float32 adj_27 = {};
    wp::int32 adj_28 = {};
    wp::float32 adj_29 = {};
    wp::int32 adj_30 = {};
    wp::float32 adj_31 = {};
    wp::float32 adj_32 = {};
    wp::vec_t<3, wp::float32> adj_33 = {};
    wp::float32 adj_34 = {};
    wp::float32 adj_35 = {};
    //---------
    // forward
    // def sdf_capsule(point: wp.vec3, radius: float, half_height: float, up_axis: int = int(Axis.Y)):       <L 278>
    // point_z_up = _sdf_point_to_z_up(point, up_axis)                                        <L 290>
    var_0 = _sdf_point_to_z_up_0(var_point, var_up_axis);
    // if point_z_up[2] > half_height:                                                        <L 291>
    var_2 = wp::extract(var_0, var_1);
    var_3 = (var_2 > var_half_height);
    if (var_3) {
        // return wp.length(wp.vec3(point_z_up[0], point_z_up[1], point_z_up[2] - half_height)) - radius       <L 292>
        var_5 = wp::extract(var_0, var_4);
        var_7 = wp::extract(var_0, var_6);
        var_9 = wp::extract(var_0, var_8);
        var_10 = wp::sub(var_9, var_half_height);
        var_11 = wp::vec_t<3, wp::float32>(var_5, var_7, var_10);
        var_12 = wp::length(var_11);
        var_13 = wp::sub(var_12, var_radius);
        goto label0;
    }
    // if point_z_up[2] < -half_height:                                                       <L 294>
    var_15 = wp::extract(var_0, var_14);
    var_16 = wp::neg(var_half_height);
    var_17 = (var_15 < var_16);
    if (var_17) {
        // return wp.length(wp.vec3(point_z_up[0], point_z_up[1], point_z_up[2] + half_height)) - radius       <L 295>
        var_19 = wp::extract(var_0, var_18);
        var_21 = wp::extract(var_0, var_20);
        var_23 = wp::extract(var_0, var_22);
        var_24 = wp::add(var_23, var_half_height);
        var_25 = wp::vec_t<3, wp::float32>(var_19, var_21, var_24);
        var_26 = wp::length(var_25);
        var_27 = wp::sub(var_26, var_radius);
        goto label1;
    }
    // return wp.length(wp.vec3(point_z_up[0], point_z_up[1], 0.0)) - radius                  <L 297>
    var_29 = wp::extract(var_0, var_28);
    var_31 = wp::extract(var_0, var_30);
    var_33 = wp::vec_t<3, wp::float32>(var_29, var_31, var_32);
    var_34 = wp::length(var_33);
    var_35 = wp::sub(var_34, var_radius);
    goto label2;
    //---------
    // reverse
    label2:;
    adj_35 += adj_ret;
    wp::adj_sub(var_34, var_radius, adj_34, adj_radius, adj_35);
    wp::adj_length(var_33, var_34, adj_33, adj_34);
    wp::adj_vec_t(var_29, var_31, var_32, adj_29, adj_31, adj_32, adj_33);
    wp::adj_extract(var_0, var_30, adj_0, adj_30, adj_31);
    wp::adj_extract(var_0, var_28, adj_0, adj_28, adj_29);
    // adj: return wp.length(wp.vec3(point_z_up[0], point_z_up[1], 0.0)) - radius             <L 297>
    if (var_17) {
        label1:;
        adj_27 += adj_ret;
        wp::adj_sub(var_26, var_radius, adj_26, adj_radius, adj_27);
        wp::adj_length(var_25, var_26, adj_25, adj_26);
        wp::adj_vec_t(var_19, var_21, var_24, adj_19, adj_21, adj_24, adj_25);
        wp::adj_add(var_23, var_half_height, adj_23, adj_half_height, adj_24);
        wp::adj_extract(var_0, var_22, adj_0, adj_22, adj_23);
        wp::adj_extract(var_0, var_20, adj_0, adj_20, adj_21);
        wp::adj_extract(var_0, var_18, adj_0, adj_18, adj_19);
        // adj: return wp.length(wp.vec3(point_z_up[0], point_z_up[1], point_z_up[2] + half_height)) - radius  <L 295>
    }
    wp::adj_neg(var_half_height, adj_half_height, adj_16);
    wp::adj_extract(var_0, var_14, adj_0, adj_14, adj_15);
    // adj: if point_z_up[2] < -half_height:                                                  <L 294>
    if (var_3) {
        label0:;
        adj_13 += adj_ret;
        wp::adj_sub(var_12, var_radius, adj_12, adj_radius, adj_13);
        wp::adj_length(var_11, var_12, adj_11, adj_12);
        wp::adj_vec_t(var_5, var_7, var_10, adj_5, adj_7, adj_10, adj_11);
        wp::adj_sub(var_9, var_half_height, adj_9, adj_half_height, adj_10);
        wp::adj_extract(var_0, var_8, adj_0, adj_8, adj_9);
        wp::adj_extract(var_0, var_6, adj_0, adj_6, adj_7);
        wp::adj_extract(var_0, var_4, adj_0, adj_4, adj_5);
        // adj: return wp.length(wp.vec3(point_z_up[0], point_z_up[1], point_z_up[2] - half_height)) - radius  <L 292>
    }
    wp::adj_extract(var_0, var_1, adj_0, adj_1, adj_2);
    // adj: if point_z_up[2] > half_height:                                                   <L 291>
    adj__sdf_point_to_z_up_0(var_point, var_up_axis, adj_point, adj_up_axis, adj_0);
    // adj: point_z_up = _sdf_point_to_z_up(point, up_axis)                                   <L 290>
    // adj: def sdf_capsule(point: wp.vec3, radius: float, half_height: float, up_axis: int = int(Axis.Y)):  <L 278>
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:300
static CUDA_CALLABLE void adj__sdf_vector_from_z_up_0(
    wp::vec_t<3, wp::float32> var_v,
    wp::int32 var_up_axis,
    wp::vec_t<3, wp::float32> & adj_v,
    wp::int32 & adj_up_axis,
    wp::vec_t<3, wp::float32> & adj_ret)
{
    //---------
    // primal vars
    const wp::int32 var_0 = 0;
    const wp::int32 var_1 = 0;
    wp::int32 var_2;
    bool var_3;
    const wp::int32 var_4 = 2;
    wp::float32 var_5;
    const wp::int32 var_6 = 0;
    wp::float32 var_7;
    const wp::int32 var_8 = 1;
    wp::float32 var_9;
    wp::vec_t<3, wp::float32> var_10;
    const wp::int32 var_11 = 1;
    const wp::int32 var_12 = 1;
    wp::int32 var_13;
    bool var_14;
    const wp::int32 var_15 = 0;
    wp::float32 var_16;
    const wp::int32 var_17 = 2;
    wp::float32 var_18;
    const wp::int32 var_19 = 1;
    wp::float32 var_20;
    wp::vec_t<3, wp::float32> var_21;
    //---------
    // dual vars
    wp::int32 adj_0 = {};
    wp::int32 adj_1 = {};
    wp::int32 adj_2 = {};
    bool adj_3 = {};
    wp::int32 adj_4 = {};
    wp::float32 adj_5 = {};
    wp::int32 adj_6 = {};
    wp::float32 adj_7 = {};
    wp::int32 adj_8 = {};
    wp::float32 adj_9 = {};
    wp::vec_t<3, wp::float32> adj_10 = {};
    wp::int32 adj_11 = {};
    wp::int32 adj_12 = {};
    wp::int32 adj_13 = {};
    bool adj_14 = {};
    wp::int32 adj_15 = {};
    wp::float32 adj_16 = {};
    wp::int32 adj_17 = {};
    wp::float32 adj_18 = {};
    wp::int32 adj_19 = {};
    wp::float32 adj_20 = {};
    wp::vec_t<3, wp::float32> adj_21 = {};
    //---------
    // forward
    // def _sdf_vector_from_z_up(v: wp.vec3, up_axis: int):                                   <L 301>
    // if up_axis == int(Axis.X):                                                             <L 302>
    var_2 = wp::int(var_1);
    var_3 = (var_up_axis == var_2);
    if (var_3) {
        // return wp.vec3(v[2], v[0], v[1])                                                   <L 303>
        var_5 = wp::extract(var_v, var_4);
        var_7 = wp::extract(var_v, var_6);
        var_9 = wp::extract(var_v, var_8);
        var_10 = wp::vec_t<3, wp::float32>(var_5, var_7, var_9);
        goto label0;
    }
    // if up_axis == int(Axis.Y):                                                             <L 304>
    var_13 = wp::int(var_12);
    var_14 = (var_up_axis == var_13);
    if (var_14) {
        // return wp.vec3(v[0], v[2], v[1])                                                   <L 305>
        var_16 = wp::extract(var_v, var_15);
        var_18 = wp::extract(var_v, var_17);
        var_20 = wp::extract(var_v, var_19);
        var_21 = wp::vec_t<3, wp::float32>(var_16, var_18, var_20);
        goto label1;
    }
    // return v                                                                               <L 306>
    goto label2;
    //---------
    // reverse
    label2:;
    adj_v += adj_ret;
    // adj: return v                                                                          <L 306>
    if (var_14) {
        label1:;
        adj_21 += adj_ret;
        wp::adj_vec_t(var_16, var_18, var_20, adj_16, adj_18, adj_20, adj_21);
        wp::adj_extract(var_v, var_19, adj_v, adj_19, adj_20);
        wp::adj_extract(var_v, var_17, adj_v, adj_17, adj_18);
        wp::adj_extract(var_v, var_15, adj_v, adj_15, adj_16);
        // adj: return wp.vec3(v[0], v[2], v[1])                                              <L 305>
    }
    // adj: if up_axis == int(Axis.Y):                                                        <L 304>
    if (var_3) {
        label0:;
        adj_10 += adj_ret;
        wp::adj_vec_t(var_5, var_7, var_9, adj_5, adj_7, adj_9, adj_10);
        wp::adj_extract(var_v, var_8, adj_v, adj_8, adj_9);
        wp::adj_extract(var_v, var_6, adj_v, adj_6, adj_7);
        wp::adj_extract(var_v, var_4, adj_v, adj_4, adj_5);
        // adj: return wp.vec3(v[2], v[0], v[1])                                              <L 303>
    }
    // adj: if up_axis == int(Axis.X):                                                        <L 302>
    // adj: def _sdf_vector_from_z_up(v: wp.vec3, up_axis: int):                              <L 301>
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:309
static CUDA_CALLABLE void adj_sdf_capsule_grad_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::float32 var_radius,
    wp::float32 var_half_height,
    wp::int32 var_up_axis,
    wp::vec_t<3, wp::float32> & adj_point,
    wp::float32 & adj_radius,
    wp::float32 & adj_half_height,
    wp::int32 & adj_up_axis,
    wp::vec_t<3, wp::float32> & adj_ret)
{
    //---------
    // primal vars
    wp::float32 var_0;
    const wp::float32 var_1 = 1e-08;
    wp::vec_t<3, wp::float32> var_2;
    wp::vec_t<3, wp::float32> var_3;
    const wp::int32 var_4 = 2;
    wp::float32 var_5;
    bool var_6;
    const wp::int32 var_7 = 0;
    wp::float32 var_8;
    const wp::int32 var_9 = 1;
    wp::float32 var_10;
    const wp::int32 var_11 = 2;
    wp::float32 var_12;
    wp::float32 var_13;
    wp::vec_t<3, wp::float32> var_14;
    wp::float32 var_15;
    const wp::float32 var_16 = 0.0;
    const wp::float32 var_17 = 0.0;
    const wp::float32 var_18 = 1.0;
    wp::vec_t<3, wp::float32> var_19;
    bool var_20;
    wp::vec_t<3, wp::float32> var_21;
    wp::vec_t<3, wp::float32> var_22;
    const wp::int32 var_23 = 2;
    wp::float32 var_24;
    wp::float32 var_25;
    bool var_26;
    const wp::int32 var_27 = 0;
    wp::float32 var_28;
    const wp::int32 var_29 = 1;
    wp::float32 var_30;
    const wp::int32 var_31 = 2;
    wp::float32 var_32;
    wp::float32 var_33;
    wp::vec_t<3, wp::float32> var_34;
    wp::float32 var_35;
    const wp::float32 var_36 = 0.0;
    const wp::float32 var_37 = 0.0;
    const wp::float32 var_38 = -1.0;
    wp::vec_t<3, wp::float32> var_39;
    bool var_40;
    wp::vec_t<3, wp::float32> var_41;
    wp::vec_t<3, wp::float32> var_42;
    const wp::int32 var_43 = 0;
    wp::float32 var_44;
    const wp::int32 var_45 = 1;
    wp::float32 var_46;
    const wp::float32 var_47 = 0.0;
    wp::vec_t<3, wp::float32> var_48;
    wp::float32 var_49;
    const wp::float32 var_50 = 0.0;
    const wp::float32 var_51 = 0.0;
    const wp::float32 var_52 = 1.0;
    wp::vec_t<3, wp::float32> var_53;
    bool var_54;
    wp::vec_t<3, wp::float32> var_55;
    wp::vec_t<3, wp::float32> var_56;
    wp::vec_t<3, wp::float32> var_57;
    wp::vec_t<3, wp::float32> var_58;
    wp::float32 var_59;
    wp::vec_t<3, wp::float32> var_60;
    wp::vec_t<3, wp::float32> var_61;
    wp::float32 var_62;
    wp::vec_t<3, wp::float32> var_63;
    //---------
    // dual vars
    wp::float32 adj_0 = {};
    wp::float32 adj_1 = {};
    wp::vec_t<3, wp::float32> adj_2 = {};
    wp::vec_t<3, wp::float32> adj_3 = {};
    wp::int32 adj_4 = {};
    wp::float32 adj_5 = {};
    bool adj_6 = {};
    wp::int32 adj_7 = {};
    wp::float32 adj_8 = {};
    wp::int32 adj_9 = {};
    wp::float32 adj_10 = {};
    wp::int32 adj_11 = {};
    wp::float32 adj_12 = {};
    wp::float32 adj_13 = {};
    wp::vec_t<3, wp::float32> adj_14 = {};
    wp::float32 adj_15 = {};
    wp::float32 adj_16 = {};
    wp::float32 adj_17 = {};
    wp::float32 adj_18 = {};
    wp::vec_t<3, wp::float32> adj_19 = {};
    bool adj_20 = {};
    wp::vec_t<3, wp::float32> adj_21 = {};
    wp::vec_t<3, wp::float32> adj_22 = {};
    wp::int32 adj_23 = {};
    wp::float32 adj_24 = {};
    wp::float32 adj_25 = {};
    bool adj_26 = {};
    wp::int32 adj_27 = {};
    wp::float32 adj_28 = {};
    wp::int32 adj_29 = {};
    wp::float32 adj_30 = {};
    wp::int32 adj_31 = {};
    wp::float32 adj_32 = {};
    wp::float32 adj_33 = {};
    wp::vec_t<3, wp::float32> adj_34 = {};
    wp::float32 adj_35 = {};
    wp::float32 adj_36 = {};
    wp::float32 adj_37 = {};
    wp::float32 adj_38 = {};
    wp::vec_t<3, wp::float32> adj_39 = {};
    bool adj_40 = {};
    wp::vec_t<3, wp::float32> adj_41 = {};
    wp::vec_t<3, wp::float32> adj_42 = {};
    wp::int32 adj_43 = {};
    wp::float32 adj_44 = {};
    wp::int32 adj_45 = {};
    wp::float32 adj_46 = {};
    wp::float32 adj_47 = {};
    wp::vec_t<3, wp::float32> adj_48 = {};
    wp::float32 adj_49 = {};
    wp::float32 adj_50 = {};
    wp::float32 adj_51 = {};
    wp::float32 adj_52 = {};
    wp::vec_t<3, wp::float32> adj_53 = {};
    bool adj_54 = {};
    wp::vec_t<3, wp::float32> adj_55 = {};
    wp::vec_t<3, wp::float32> adj_56 = {};
    wp::vec_t<3, wp::float32> adj_57 = {};
    wp::vec_t<3, wp::float32> adj_58 = {};
    wp::float32 adj_59 = {};
    wp::vec_t<3, wp::float32> adj_60 = {};
    wp::vec_t<3, wp::float32> adj_61 = {};
    wp::float32 adj_62 = {};
    wp::vec_t<3, wp::float32> adj_63 = {};
    //---------
    // forward
    // def sdf_capsule_grad(point: wp.vec3, radius: float, half_height: float, up_axis: int = int(Axis.Y)):       <L 310>
    // _ = radius                                                                             <L 322>
    var_0 = wp::copy(var_radius);
    // eps = 1.0e-8                                                                           <L 323>
    // point_z_up = _sdf_point_to_z_up(point, up_axis)                                        <L 324>
    var_2 = _sdf_point_to_z_up_0(var_point, var_up_axis);
    // grad_z_up = wp.vec3()                                                                  <L 325>
    var_3 = wp::vec_t<3, wp::float32>();
    // if point_z_up[2] > half_height:                                                        <L 326>
    var_5 = wp::extract(var_2, var_4);
    var_6 = (var_5 > var_half_height);
    if (var_6) {
        // v = wp.vec3(point_z_up[0], point_z_up[1], point_z_up[2] - half_height)             <L 327>
        var_8 = wp::extract(var_2, var_7);
        var_10 = wp::extract(var_2, var_9);
        var_12 = wp::extract(var_2, var_11);
        var_13 = wp::sub(var_12, var_half_height);
        var_14 = wp::vec_t<3, wp::float32>(var_8, var_10, var_13);
        // v_len = wp.length(v)                                                               <L 328>
        var_15 = wp::length(var_14);
        // grad_z_up = wp.vec3(0.0, 0.0, 1.0)                                                 <L 329>
        var_19 = wp::vec_t<3, wp::float32>(var_16, var_17, var_18);
        // if v_len > eps:                                                                    <L 330>
        var_20 = (var_15 > var_1);
        if (var_20) {
            // grad_z_up = v / v_len                                                          <L 331>
            var_21 = wp::div(var_14, var_15);
        }
        var_22 = wp::where(var_20, var_21, var_19);
    }
    if (!var_6) {
        // elif point_z_up[2] < -half_height:                                                 <L 332>
        var_24 = wp::extract(var_2, var_23);
        var_25 = wp::neg(var_half_height);
        var_26 = (var_24 < var_25);
        if (var_26) {
            // v = wp.vec3(point_z_up[0], point_z_up[1], point_z_up[2] + half_height)         <L 333>
            var_28 = wp::extract(var_2, var_27);
            var_30 = wp::extract(var_2, var_29);
            var_32 = wp::extract(var_2, var_31);
            var_33 = wp::add(var_32, var_half_height);
            var_34 = wp::vec_t<3, wp::float32>(var_28, var_30, var_33);
            // v_len = wp.length(v)                                                           <L 334>
            var_35 = wp::length(var_34);
            // grad_z_up = wp.vec3(0.0, 0.0, -1.0)                                            <L 335>
            var_39 = wp::vec_t<3, wp::float32>(var_36, var_37, var_38);
            // if v_len > eps:                                                                <L 336>
            var_40 = (var_35 > var_1);
            if (var_40) {
                // grad_z_up = v / v_len                                                      <L 337>
                var_41 = wp::div(var_34, var_35);
            }
            var_42 = wp::where(var_40, var_41, var_39);
        }
        if (!var_26) {
            // v = wp.vec3(point_z_up[0], point_z_up[1], 0.0)                                 <L 339>
            var_44 = wp::extract(var_2, var_43);
            var_46 = wp::extract(var_2, var_45);
            var_48 = wp::vec_t<3, wp::float32>(var_44, var_46, var_47);
            // v_len = wp.length(v)                                                           <L 340>
            var_49 = wp::length(var_48);
            // grad_z_up = wp.vec3(0.0, 0.0, 1.0)                                             <L 341>
            var_53 = wp::vec_t<3, wp::float32>(var_50, var_51, var_52);
            // if v_len > eps:                                                                <L 342>
            var_54 = (var_49 > var_1);
            if (var_54) {
                // grad_z_up = v / v_len                                                      <L 343>
                var_55 = wp::div(var_48, var_49);
            }
            var_56 = wp::where(var_54, var_55, var_53);
        }
        var_57 = wp::where(var_26, var_42, var_56);
        var_58 = wp::where(var_26, var_34, var_48);
        var_59 = wp::where(var_26, var_35, var_49);
    }
    var_60 = wp::where(var_6, var_22, var_57);
    var_61 = wp::where(var_6, var_14, var_58);
    var_62 = wp::where(var_6, var_15, var_59);
    // return _sdf_vector_from_z_up(grad_z_up, up_axis)                                       <L 344>
    var_63 = _sdf_vector_from_z_up_0(var_60, var_up_axis);
    goto label0;
    //---------
    // reverse
    label0:;
    adj_63 += adj_ret;
    adj__sdf_vector_from_z_up_0(var_60, var_up_axis, adj_60, adj_up_axis, adj_63);
    // adj: return _sdf_vector_from_z_up(grad_z_up, up_axis)                                  <L 344>
    wp::adj_where(var_6, var_15, var_59, adj_6, adj_15, adj_59, adj_62);
    wp::adj_where(var_6, var_14, var_58, adj_6, adj_14, adj_58, adj_61);
    wp::adj_where(var_6, var_22, var_57, adj_6, adj_22, adj_57, adj_60);
    if (!var_6) {
        wp::adj_where(var_26, var_35, var_49, adj_26, adj_35, adj_49, adj_59);
        wp::adj_where(var_26, var_34, var_48, adj_26, adj_34, adj_48, adj_58);
        wp::adj_where(var_26, var_42, var_56, adj_26, adj_42, adj_56, adj_57);
        if (!var_26) {
            wp::adj_where(var_54, var_55, var_53, adj_54, adj_55, adj_53, adj_56);
            if (var_54) {
                wp::adj_div(var_48, var_49, adj_48, adj_49, adj_55);
                // adj: grad_z_up = v / v_len                                                 <L 343>
            }
            // adj: if v_len > eps:                                                           <L 342>
            wp::adj_vec_t(var_50, var_51, var_52, adj_50, adj_51, adj_52, adj_53);
            // adj: grad_z_up = wp.vec3(0.0, 0.0, 1.0)                                        <L 341>
            wp::adj_length(var_48, var_49, adj_48, adj_49);
            // adj: v_len = wp.length(v)                                                      <L 340>
            wp::adj_vec_t(var_44, var_46, var_47, adj_44, adj_46, adj_47, adj_48);
            wp::adj_extract(var_2, var_45, adj_2, adj_45, adj_46);
            wp::adj_extract(var_2, var_43, adj_2, adj_43, adj_44);
            // adj: v = wp.vec3(point_z_up[0], point_z_up[1], 0.0)                            <L 339>
        }
        if (var_26) {
            wp::adj_where(var_40, var_41, var_39, adj_40, adj_41, adj_39, adj_42);
            if (var_40) {
                wp::adj_div(var_34, var_35, adj_34, adj_35, adj_41);
                // adj: grad_z_up = v / v_len                                                 <L 337>
            }
            // adj: if v_len > eps:                                                           <L 336>
            wp::adj_vec_t(var_36, var_37, var_38, adj_36, adj_37, adj_38, adj_39);
            // adj: grad_z_up = wp.vec3(0.0, 0.0, -1.0)                                       <L 335>
            wp::adj_length(var_34, var_35, adj_34, adj_35);
            // adj: v_len = wp.length(v)                                                      <L 334>
            wp::adj_vec_t(var_28, var_30, var_33, adj_28, adj_30, adj_33, adj_34);
            wp::adj_add(var_32, var_half_height, adj_32, adj_half_height, adj_33);
            wp::adj_extract(var_2, var_31, adj_2, adj_31, adj_32);
            wp::adj_extract(var_2, var_29, adj_2, adj_29, adj_30);
            wp::adj_extract(var_2, var_27, adj_2, adj_27, adj_28);
            // adj: v = wp.vec3(point_z_up[0], point_z_up[1], point_z_up[2] + half_height)    <L 333>
        }
        wp::adj_neg(var_half_height, adj_half_height, adj_25);
        wp::adj_extract(var_2, var_23, adj_2, adj_23, adj_24);
        // adj: elif point_z_up[2] < -half_height:                                            <L 332>
    }
    if (var_6) {
        wp::adj_where(var_20, var_21, var_19, adj_20, adj_21, adj_19, adj_22);
        if (var_20) {
            wp::adj_div(var_14, var_15, adj_14, adj_15, adj_21);
            // adj: grad_z_up = v / v_len                                                     <L 331>
        }
        // adj: if v_len > eps:                                                               <L 330>
        wp::adj_vec_t(var_16, var_17, var_18, adj_16, adj_17, adj_18, adj_19);
        // adj: grad_z_up = wp.vec3(0.0, 0.0, 1.0)                                            <L 329>
        wp::adj_length(var_14, var_15, adj_14, adj_15);
        // adj: v_len = wp.length(v)                                                          <L 328>
        wp::adj_vec_t(var_8, var_10, var_13, adj_8, adj_10, adj_13, adj_14);
        wp::adj_sub(var_12, var_half_height, adj_12, adj_half_height, adj_13);
        wp::adj_extract(var_2, var_11, adj_2, adj_11, adj_12);
        wp::adj_extract(var_2, var_9, adj_2, adj_9, adj_10);
        wp::adj_extract(var_2, var_7, adj_2, adj_7, adj_8);
        // adj: v = wp.vec3(point_z_up[0], point_z_up[1], point_z_up[2] - half_height)        <L 327>
    }
    wp::adj_extract(var_2, var_4, adj_2, adj_4, adj_5);
    // adj: if point_z_up[2] > half_height:                                                   <L 326>
    // adj: grad_z_up = wp.vec3()                                                             <L 325>
    adj__sdf_point_to_z_up_0(var_point, var_up_axis, adj_point, adj_up_axis, adj_2);
    // adj: point_z_up = _sdf_point_to_z_up(point, up_axis)                                   <L 324>
    // adj: eps = 1.0e-8                                                                      <L 323>
    wp::adj_copy(var_radius, adj_radius, adj_0);
    // adj: _ = radius                                                                        <L 322>
    // adj: def sdf_capsule_grad(point: wp.vec3, radius: float, half_height: float, up_axis: int = int(Axis.Y)):  <L 310>
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:156
static CUDA_CALLABLE void adj__sdf_capped_cone_z_0(
    wp::float32 var_bottom_radius,
    wp::float32 var_top_radius,
    wp::float32 var_half_height,
    wp::vec_t<3, wp::float32> var_point_z_up,
    wp::float32 & adj_bottom_radius,
    wp::float32 & adj_top_radius,
    wp::float32 & adj_half_height,
    wp::vec_t<3, wp::float32> & adj_point_z_up,
    wp::float32 & adj_ret)
{
    //---------
    // primal vars
    const wp::int32 var_0 = 0;
    wp::float32 var_1;
    const wp::int32 var_2 = 1;
    wp::float32 var_3;
    wp::vec_t<2, wp::float32> var_4;
    wp::float32 var_5;
    const wp::int32 var_6 = 2;
    wp::float32 var_7;
    wp::vec_t<2, wp::float32> var_8;
    wp::vec_t<2, wp::float32> var_9;
    wp::float32 var_10;
    const wp::float32 var_11 = 2.0;
    wp::float32 var_12;
    wp::vec_t<2, wp::float32> var_13;
    const wp::int32 var_14 = 1;
    wp::float32 var_15;
    const wp::float32 var_16 = 0.0;
    bool var_17;
    const wp::int32 var_18 = 0;
    wp::float32 var_19;
    const wp::int32 var_20 = 0;
    wp::float32 var_21;
    wp::float32 var_22;
    wp::float32 var_23;
    const wp::int32 var_24 = 1;
    wp::float32 var_25;
    wp::float32 var_26;
    wp::float32 var_27;
    wp::vec_t<2, wp::float32> var_28;
    const wp::int32 var_29 = 0;
    wp::float32 var_30;
    const wp::int32 var_31 = 0;
    wp::float32 var_32;
    wp::float32 var_33;
    wp::float32 var_34;
    const wp::int32 var_35 = 1;
    wp::float32 var_36;
    wp::float32 var_37;
    wp::float32 var_38;
    wp::vec_t<2, wp::float32> var_39;
    wp::vec_t<2, wp::float32> var_40;
    wp::float32 var_41;
    const wp::float32 var_42 = 0.0;
    const wp::float32 var_43 = 0.0;
    bool var_44;
    wp::vec_t<2, wp::float32> var_45;
    wp::float32 var_46;
    wp::float32 var_47;
    const wp::float32 var_48 = 0.0;
    const wp::float32 var_49 = 1.0;
    wp::float32 var_50;
    wp::float32 var_51;
    wp::vec_t<2, wp::float32> var_52;
    wp::vec_t<2, wp::float32> var_53;
    wp::vec_t<2, wp::float32> var_54;
    const wp::float32 var_55 = 1.0;
    bool var_56;
    const wp::int32 var_57 = 0;
    wp::float32 var_58;
    const wp::float32 var_59 = 0.0;
    bool var_60;
    const wp::int32 var_61 = 1;
    wp::float32 var_62;
    const wp::float32 var_63 = 0.0;
    bool var_64;
    const wp::float32 var_65 = -1.0;
    wp::float32 var_66;
    wp::float32 var_67;
    wp::float32 var_68;
    wp::float32 var_69;
    wp::float32 var_70;
    wp::float32 var_71;
    //---------
    // dual vars
    wp::int32 adj_0 = {};
    wp::float32 adj_1 = {};
    wp::int32 adj_2 = {};
    wp::float32 adj_3 = {};
    wp::vec_t<2, wp::float32> adj_4 = {};
    wp::float32 adj_5 = {};
    wp::int32 adj_6 = {};
    wp::float32 adj_7 = {};
    wp::vec_t<2, wp::float32> adj_8 = {};
    wp::vec_t<2, wp::float32> adj_9 = {};
    wp::float32 adj_10 = {};
    wp::float32 adj_11 = {};
    wp::float32 adj_12 = {};
    wp::vec_t<2, wp::float32> adj_13 = {};
    wp::int32 adj_14 = {};
    wp::float32 adj_15 = {};
    wp::float32 adj_16 = {};
    bool adj_17 = {};
    wp::int32 adj_18 = {};
    wp::float32 adj_19 = {};
    wp::int32 adj_20 = {};
    wp::float32 adj_21 = {};
    wp::float32 adj_22 = {};
    wp::float32 adj_23 = {};
    wp::int32 adj_24 = {};
    wp::float32 adj_25 = {};
    wp::float32 adj_26 = {};
    wp::float32 adj_27 = {};
    wp::vec_t<2, wp::float32> adj_28 = {};
    wp::int32 adj_29 = {};
    wp::float32 adj_30 = {};
    wp::int32 adj_31 = {};
    wp::float32 adj_32 = {};
    wp::float32 adj_33 = {};
    wp::float32 adj_34 = {};
    wp::int32 adj_35 = {};
    wp::float32 adj_36 = {};
    wp::float32 adj_37 = {};
    wp::float32 adj_38 = {};
    wp::vec_t<2, wp::float32> adj_39 = {};
    wp::vec_t<2, wp::float32> adj_40 = {};
    wp::float32 adj_41 = {};
    wp::float32 adj_42 = {};
    wp::float32 adj_43 = {};
    bool adj_44 = {};
    wp::vec_t<2, wp::float32> adj_45 = {};
    wp::float32 adj_46 = {};
    wp::float32 adj_47 = {};
    wp::float32 adj_48 = {};
    wp::float32 adj_49 = {};
    wp::float32 adj_50 = {};
    wp::float32 adj_51 = {};
    wp::vec_t<2, wp::float32> adj_52 = {};
    wp::vec_t<2, wp::float32> adj_53 = {};
    wp::vec_t<2, wp::float32> adj_54 = {};
    wp::float32 adj_55 = {};
    bool adj_56 = {};
    wp::int32 adj_57 = {};
    wp::float32 adj_58 = {};
    wp::float32 adj_59 = {};
    bool adj_60 = {};
    wp::int32 adj_61 = {};
    wp::float32 adj_62 = {};
    wp::float32 adj_63 = {};
    bool adj_64 = {};
    wp::float32 adj_65 = {};
    wp::float32 adj_66 = {};
    wp::float32 adj_67 = {};
    wp::float32 adj_68 = {};
    wp::float32 adj_69 = {};
    wp::float32 adj_70 = {};
    wp::float32 adj_71 = {};
    //---------
    // forward
    // def _sdf_capped_cone_z(bottom_radius: float, top_radius: float, half_height: float, point_z_up: wp.vec3):       <L 157>
    // q = wp.vec2(wp.length(wp.vec2(point_z_up[0], point_z_up[1])), point_z_up[2])           <L 158>
    var_1 = wp::extract(var_point_z_up, var_0);
    var_3 = wp::extract(var_point_z_up, var_2);
    var_4 = wp::vec_t<2, wp::float32>(var_1, var_3);
    var_5 = wp::length(var_4);
    var_7 = wp::extract(var_point_z_up, var_6);
    var_8 = wp::vec_t<2, wp::float32>(var_5, var_7);
    // k1 = wp.vec2(top_radius, half_height)                                                  <L 159>
    var_9 = wp::vec_t<2, wp::float32>(var_top_radius, var_half_height);
    // k2 = wp.vec2(top_radius - bottom_radius, 2.0 * half_height)                            <L 160>
    var_10 = wp::sub(var_top_radius, var_bottom_radius);
    var_12 = wp::mul(var_11, var_half_height);
    var_13 = wp::vec_t<2, wp::float32>(var_10, var_12);
    // if q[1] < 0.0:                                                                         <L 162>
    var_15 = wp::extract(var_8, var_14);
    var_17 = (var_15 < var_16);
    if (var_17) {
        // ca = wp.vec2(q[0] - wp.min(q[0], bottom_radius), wp.abs(q[1]) - half_height)       <L 163>
        var_19 = wp::extract(var_8, var_18);
        var_21 = wp::extract(var_8, var_20);
        var_22 = wp::min(var_21, var_bottom_radius);
        var_23 = wp::sub(var_19, var_22);
        var_25 = wp::extract(var_8, var_24);
        var_26 = wp::abs(var_25);
        var_27 = wp::sub(var_26, var_half_height);
        var_28 = wp::vec_t<2, wp::float32>(var_23, var_27);
    }
    if (!var_17) {
        // ca = wp.vec2(q[0] - wp.min(q[0], top_radius), wp.abs(q[1]) - half_height)          <L 165>
        var_30 = wp::extract(var_8, var_29);
        var_32 = wp::extract(var_8, var_31);
        var_33 = wp::min(var_32, var_top_radius);
        var_34 = wp::sub(var_30, var_33);
        var_36 = wp::extract(var_8, var_35);
        var_37 = wp::abs(var_36);
        var_38 = wp::sub(var_37, var_half_height);
        var_39 = wp::vec_t<2, wp::float32>(var_34, var_38);
    }
    var_40 = wp::where(var_17, var_28, var_39);
    // denom = wp.dot(k2, k2)                                                                 <L 167>
    var_41 = wp::dot(var_13, var_13);
    // t = 0.0                                                                                <L 168>
    // if denom > 0.0:                                                                        <L 169>
    var_44 = (var_41 > var_43);
    if (var_44) {
        // t = wp.clamp(wp.dot(k1 - q, k2) / denom, 0.0, 1.0)                                 <L 170>
        var_45 = wp::sub(var_9, var_8);
        var_46 = wp::dot(var_45, var_13);
        var_47 = wp::div(var_46, var_41);
        var_50 = wp::clamp(var_47, var_48, var_49);
    }
    var_51 = wp::where(var_44, var_50, var_42);
    // cb = q - k1 + k2 * t                                                                   <L 171>
    var_52 = wp::sub(var_8, var_9);
    var_53 = wp::mul(var_13, var_51);
    var_54 = wp::add(var_52, var_53);
    // sign = 1.0                                                                             <L 173>
    // if cb[0] < 0.0 and ca[1] < 0.0:                                                        <L 174>
    var_58 = wp::extract(var_54, var_57);
    var_60 = (var_58 < var_59);
    var_56 = var_60;
    if (var_56) {
        var_62 = wp::extract(var_40, var_61);
        var_64 = (var_62 < var_63);
        var_56 = var_56 && var_64;
    }
    if (var_56) {
        // sign = -1.0                                                                        <L 175>
    }
    var_66 = wp::where(var_56, var_65, var_55);
    // return sign * wp.sqrt(wp.min(wp.dot(ca, ca), wp.dot(cb, cb)))                          <L 177>
    var_67 = wp::dot(var_40, var_40);
    var_68 = wp::dot(var_54, var_54);
    var_69 = wp::min(var_67, var_68);
    var_70 = wp::sqrt(var_69);
    var_71 = wp::mul(var_66, var_70);
    goto label0;
    //---------
    // reverse
    label0:;
    adj_71 += adj_ret;
    wp::adj_mul(var_66, var_70, adj_66, adj_70, adj_71);
    wp::adj_sqrt(var_69, var_70, adj_69, adj_70);
    wp::adj_min(var_67, var_68, adj_67, adj_68, adj_69);
    wp::adj_dot(var_54, var_54, adj_54, adj_54, adj_68);
    wp::adj_dot(var_40, var_40, adj_40, adj_40, adj_67);
    // adj: return sign * wp.sqrt(wp.min(wp.dot(ca, ca), wp.dot(cb, cb)))                     <L 177>
    wp::adj_where(var_56, var_65, var_55, adj_56, adj_65, adj_55, adj_66);
    if (var_56) {
        // adj: sign = -1.0                                                                   <L 175>
    }
    if (var_56) {
        wp::adj_extract(var_40, var_61, adj_40, adj_61, adj_62);
    }
    wp::adj_extract(var_54, var_57, adj_54, adj_57, adj_58);
    // adj: if cb[0] < 0.0 and ca[1] < 0.0:                                                   <L 174>
    // adj: sign = 1.0                                                                        <L 173>
    wp::adj_add(var_52, var_53, adj_52, adj_53, adj_54);
    wp::adj_mul(var_13, var_51, adj_13, adj_51, adj_53);
    wp::adj_sub(var_8, var_9, adj_8, adj_9, adj_52);
    // adj: cb = q - k1 + k2 * t                                                              <L 171>
    wp::adj_where(var_44, var_50, var_42, adj_44, adj_50, adj_42, adj_51);
    if (var_44) {
        wp::adj_clamp(var_47, var_48, var_49, adj_47, adj_48, adj_49, adj_50);
        wp::adj_div(var_46, var_41, var_47, adj_46, adj_41, adj_47);
        wp::adj_dot(var_45, var_13, adj_45, adj_13, adj_46);
        wp::adj_sub(var_9, var_8, adj_9, adj_8, adj_45);
        // adj: t = wp.clamp(wp.dot(k1 - q, k2) / denom, 0.0, 1.0)                            <L 170>
    }
    // adj: if denom > 0.0:                                                                   <L 169>
    // adj: t = 0.0                                                                           <L 168>
    wp::adj_dot(var_13, var_13, adj_13, adj_13, adj_41);
    // adj: denom = wp.dot(k2, k2)                                                            <L 167>
    wp::adj_where(var_17, var_28, var_39, adj_17, adj_28, adj_39, adj_40);
    if (!var_17) {
        wp::adj_vec_t(var_34, var_38, adj_34, adj_38, adj_39);
        wp::adj_sub(var_37, var_half_height, adj_37, adj_half_height, adj_38);
        wp::adj_abs(var_36, adj_36, adj_37);
        wp::adj_extract(var_8, var_35, adj_8, adj_35, adj_36);
        wp::adj_sub(var_30, var_33, adj_30, adj_33, adj_34);
        wp::adj_min(var_32, var_top_radius, adj_32, adj_top_radius, adj_33);
        wp::adj_extract(var_8, var_31, adj_8, adj_31, adj_32);
        wp::adj_extract(var_8, var_29, adj_8, adj_29, adj_30);
        // adj: ca = wp.vec2(q[0] - wp.min(q[0], top_radius), wp.abs(q[1]) - half_height)     <L 165>
    }
    if (var_17) {
        wp::adj_vec_t(var_23, var_27, adj_23, adj_27, adj_28);
        wp::adj_sub(var_26, var_half_height, adj_26, adj_half_height, adj_27);
        wp::adj_abs(var_25, adj_25, adj_26);
        wp::adj_extract(var_8, var_24, adj_8, adj_24, adj_25);
        wp::adj_sub(var_19, var_22, adj_19, adj_22, adj_23);
        wp::adj_min(var_21, var_bottom_radius, adj_21, adj_bottom_radius, adj_22);
        wp::adj_extract(var_8, var_20, adj_8, adj_20, adj_21);
        wp::adj_extract(var_8, var_18, adj_8, adj_18, adj_19);
        // adj: ca = wp.vec2(q[0] - wp.min(q[0], bottom_radius), wp.abs(q[1]) - half_height)  <L 163>
    }
    wp::adj_extract(var_8, var_14, adj_8, adj_14, adj_15);
    // adj: if q[1] < 0.0:                                                                    <L 162>
    wp::adj_vec_t(var_10, var_12, adj_10, adj_12, adj_13);
    wp::adj_mul(var_11, var_half_height, adj_11, adj_half_height, adj_12);
    wp::adj_sub(var_top_radius, var_bottom_radius, adj_top_radius, adj_bottom_radius, adj_10);
    // adj: k2 = wp.vec2(top_radius - bottom_radius, 2.0 * half_height)                       <L 160>
    wp::adj_vec_t(var_top_radius, var_half_height, adj_top_radius, adj_half_height, adj_9);
    // adj: k1 = wp.vec2(top_radius, half_height)                                             <L 159>
    wp::adj_vec_t(var_5, var_7, adj_5, adj_7, adj_8);
    wp::adj_extract(var_point_z_up, var_6, adj_point_z_up, adj_6, adj_7);
    wp::adj_length(var_4, var_5, adj_4, adj_5);
    wp::adj_vec_t(var_1, var_3, adj_1, adj_3, adj_4);
    wp::adj_extract(var_point_z_up, var_2, adj_point_z_up, adj_2, adj_3);
    wp::adj_extract(var_point_z_up, var_0, adj_point_z_up, adj_0, adj_1);
    // adj: q = wp.vec2(wp.length(wp.vec2(point_z_up[0], point_z_up[1])), point_z_up[2])      <L 158>
    // adj: def _sdf_capped_cone_z(bottom_radius: float, top_radius: float, half_height: float, point_z_up: wp.vec3):  <L 157>
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:347
static CUDA_CALLABLE void adj_sdf_cylinder_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::float32 var_radius,
    wp::float32 var_half_height,
    wp::int32 var_up_axis,
    wp::float32 var_top_radius,
    wp::vec_t<3, wp::float32> & adj_point,
    wp::float32 & adj_radius,
    wp::float32 & adj_half_height,
    wp::int32 & adj_up_axis,
    wp::float32 & adj_top_radius,
    wp::float32 & adj_ret)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    bool var_1;
    const wp::float32 var_2 = 0.0;
    bool var_3;
    wp::float32 var_4;
    wp::float32 var_5;
    const wp::float32 var_6 = 1e-06;
    bool var_7;
    const wp::int32 var_8 = 0;
    wp::float32 var_9;
    const wp::int32 var_10 = 1;
    wp::float32 var_11;
    const wp::float32 var_12 = 0.0;
    wp::vec_t<3, wp::float32> var_13;
    wp::float32 var_14;
    wp::float32 var_15;
    const wp::int32 var_16 = 2;
    wp::float32 var_17;
    wp::float32 var_18;
    wp::float32 var_19;
    wp::float32 var_20;
    const wp::float32 var_21 = 0.0;
    wp::float32 var_22;
    const wp::float32 var_23 = 0.0;
    wp::float32 var_24;
    const wp::float32 var_25 = 0.0;
    wp::float32 var_26;
    wp::vec_t<2, wp::float32> var_27;
    wp::float32 var_28;
    wp::float32 var_29;
    wp::float32 var_30;
    //---------
    // dual vars
    wp::vec_t<3, wp::float32> adj_0 = {};
    bool adj_1 = {};
    wp::float32 adj_2 = {};
    bool adj_3 = {};
    wp::float32 adj_4 = {};
    wp::float32 adj_5 = {};
    wp::float32 adj_6 = {};
    bool adj_7 = {};
    wp::int32 adj_8 = {};
    wp::float32 adj_9 = {};
    wp::int32 adj_10 = {};
    wp::float32 adj_11 = {};
    wp::float32 adj_12 = {};
    wp::vec_t<3, wp::float32> adj_13 = {};
    wp::float32 adj_14 = {};
    wp::float32 adj_15 = {};
    wp::int32 adj_16 = {};
    wp::float32 adj_17 = {};
    wp::float32 adj_18 = {};
    wp::float32 adj_19 = {};
    wp::float32 adj_20 = {};
    wp::float32 adj_21 = {};
    wp::float32 adj_22 = {};
    wp::float32 adj_23 = {};
    wp::float32 adj_24 = {};
    wp::float32 adj_25 = {};
    wp::float32 adj_26 = {};
    wp::vec_t<2, wp::float32> adj_27 = {};
    wp::float32 adj_28 = {};
    wp::float32 adj_29 = {};
    wp::float32 adj_30 = {};
    //---------
    // forward
    // def sdf_cylinder(                                                                      <L 348>
    // point_z_up = _sdf_point_to_z_up(point, up_axis)                                        <L 367>
    var_0 = _sdf_point_to_z_up_0(var_point, var_up_axis);
    // if top_radius < 0.0 or wp.abs(top_radius - radius) <= 1.0e-6:                          <L 368>
    var_3 = (var_top_radius < var_2);
    var_1 = var_3;
    if (!var_1) {
        var_4 = wp::sub(var_top_radius, var_radius);
        var_5 = wp::abs(var_4);
        var_7 = (var_5 <= var_6);
        var_1 = var_1 || var_7;
    }
    if (var_1) {
        // dx = wp.length(wp.vec3(point_z_up[0], point_z_up[1], 0.0)) - radius                <L 369>
        var_9 = wp::extract(var_0, var_8);
        var_11 = wp::extract(var_0, var_10);
        var_13 = wp::vec_t<3, wp::float32>(var_9, var_11, var_12);
        var_14 = wp::length(var_13);
        var_15 = wp::sub(var_14, var_radius);
        // dy = wp.abs(point_z_up[2]) - half_height                                           <L 370>
        var_17 = wp::extract(var_0, var_16);
        var_18 = wp::abs(var_17);
        var_19 = wp::sub(var_18, var_half_height);
        // return wp.min(wp.max(dx, dy), 0.0) + wp.length(wp.vec2(wp.max(dx, 0.0), wp.max(dy, 0.0)))       <L 371>
        var_20 = wp::max(var_15, var_19);
        var_22 = wp::min(var_20, var_21);
        var_24 = wp::max(var_15, var_23);
        var_26 = wp::max(var_19, var_25);
        var_27 = wp::vec_t<2, wp::float32>(var_24, var_26);
        var_28 = wp::length(var_27);
        var_29 = wp::add(var_22, var_28);
        goto label0;
    }
    // return _sdf_capped_cone_z(radius, top_radius, half_height, point_z_up)                 <L 372>
    var_30 = _sdf_capped_cone_z_0(var_radius, var_top_radius, var_half_height, var_0);
    goto label1;
    //---------
    // reverse
    label1:;
    adj_30 += adj_ret;
    adj__sdf_capped_cone_z_0(var_radius, var_top_radius, var_half_height, var_0, adj_radius, adj_top_radius, adj_half_height, adj_0, adj_30);
    // adj: return _sdf_capped_cone_z(radius, top_radius, half_height, point_z_up)            <L 372>
    if (var_1) {
        label0:;
        adj_29 += adj_ret;
        wp::adj_add(var_22, var_28, adj_22, adj_28, adj_29);
        wp::adj_length(var_27, var_28, adj_27, adj_28);
        wp::adj_vec_t(var_24, var_26, adj_24, adj_26, adj_27);
        wp::adj_max(var_19, var_25, adj_19, adj_25, adj_26);
        wp::adj_max(var_15, var_23, adj_15, adj_23, adj_24);
        wp::adj_min(var_20, var_21, adj_20, adj_21, adj_22);
        wp::adj_max(var_15, var_19, adj_15, adj_19, adj_20);
        // adj: return wp.min(wp.max(dx, dy), 0.0) + wp.length(wp.vec2(wp.max(dx, 0.0), wp.max(dy, 0.0)))  <L 371>
        wp::adj_sub(var_18, var_half_height, adj_18, adj_half_height, adj_19);
        wp::adj_abs(var_17, adj_17, adj_18);
        wp::adj_extract(var_0, var_16, adj_0, adj_16, adj_17);
        // adj: dy = wp.abs(point_z_up[2]) - half_height                                      <L 370>
        wp::adj_sub(var_14, var_radius, adj_14, adj_radius, adj_15);
        wp::adj_length(var_13, var_14, adj_13, adj_14);
        wp::adj_vec_t(var_9, var_11, var_12, adj_9, adj_11, adj_12, adj_13);
        wp::adj_extract(var_0, var_10, adj_0, adj_10, adj_11);
        wp::adj_extract(var_0, var_8, adj_0, adj_8, adj_9);
        // adj: dx = wp.length(wp.vec3(point_z_up[0], point_z_up[1], 0.0)) - radius           <L 369>
    }
    if (!var_1) {
        wp::adj_abs(var_4, adj_4, adj_5);
        wp::adj_sub(var_top_radius, var_radius, adj_top_radius, adj_radius, adj_4);
    }
    // adj: if top_radius < 0.0 or wp.abs(top_radius - radius) <= 1.0e-6:                     <L 368>
    adj__sdf_point_to_z_up_0(var_point, var_up_axis, adj_point, adj_up_axis, adj_0);
    // adj: point_z_up = _sdf_point_to_z_up(point, up_axis)                                   <L 367>
    // adj: def sdf_cylinder(                                                                 <L 348>
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:375
static CUDA_CALLABLE void adj_sdf_cylinder_grad_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::float32 var_radius,
    wp::float32 var_half_height,
    wp::int32 var_up_axis,
    wp::float32 var_top_radius,
    wp::vec_t<3, wp::float32> & adj_point,
    wp::float32 & adj_radius,
    wp::float32 & adj_half_height,
    wp::int32 & adj_up_axis,
    wp::float32 & adj_top_radius,
    wp::vec_t<3, wp::float32> & adj_ret)
{
    //---------
    // primal vars
    const wp::float32 var_0 = 1e-08;
    wp::vec_t<3, wp::float32> var_1;
    bool var_2;
    const wp::float32 var_3 = 0.0;
    bool var_4;
    wp::float32 var_5;
    wp::float32 var_6;
    const wp::float32 var_7 = 1e-06;
    bool var_8;
    const wp::float32 var_9 = 0.0001;
    const wp::float32 var_10 = 0.0;
    const wp::float32 var_11 = 0.0;
    wp::vec_t<3, wp::float32> var_12;
    wp::vec_t<3, wp::float32> var_13;
    wp::float32 var_14;
    const wp::float32 var_15 = 0.0;
    const wp::float32 var_16 = 0.0;
    wp::vec_t<3, wp::float32> var_17;
    wp::vec_t<3, wp::float32> var_18;
    wp::float32 var_19;
    wp::float32 var_20;
    const wp::float32 var_21 = 0.0;
    const wp::float32 var_22 = 0.0;
    wp::vec_t<3, wp::float32> var_23;
    wp::vec_t<3, wp::float32> var_24;
    wp::float32 var_25;
    const wp::float32 var_26 = 0.0;
    const wp::float32 var_27 = 0.0;
    wp::vec_t<3, wp::float32> var_28;
    wp::vec_t<3, wp::float32> var_29;
    wp::float32 var_30;
    wp::float32 var_31;
    const wp::float32 var_32 = 0.0;
    const wp::float32 var_33 = 0.0;
    wp::vec_t<3, wp::float32> var_34;
    wp::vec_t<3, wp::float32> var_35;
    wp::float32 var_36;
    const wp::float32 var_37 = 0.0;
    const wp::float32 var_38 = 0.0;
    wp::vec_t<3, wp::float32> var_39;
    wp::vec_t<3, wp::float32> var_40;
    wp::float32 var_41;
    wp::float32 var_42;
    wp::vec_t<3, wp::float32> var_43;
    wp::float32 var_44;
    bool var_45;
    wp::vec_t<3, wp::float32> var_46;
    const wp::float32 var_47 = 0.0;
    const wp::float32 var_48 = 0.0;
    const wp::float32 var_49 = 1.0;
    wp::vec_t<3, wp::float32> var_50;
    wp::vec_t<3, wp::float32> var_51;
    wp::vec_t<3, wp::float32> var_52;
    const wp::int32 var_53 = 0;
    wp::float32 var_54;
    const wp::int32 var_55 = 1;
    wp::float32 var_56;
    const wp::float32 var_57 = 0.0;
    wp::vec_t<3, wp::float32> var_58;
    wp::float32 var_59;
    const wp::float32 var_60 = 0.0;
    const wp::float32 var_61 = 0.0;
    const wp::float32 var_62 = 1.0;
    wp::vec_t<3, wp::float32> var_63;
    bool var_64;
    wp::vec_t<3, wp::float32> var_65;
    wp::vec_t<3, wp::float32> var_66;
    const wp::float32 var_67 = 0.0;
    const wp::float32 var_68 = 0.0;
    const wp::int32 var_69 = 2;
    wp::float32 var_70;
    wp::float32 var_71;
    wp::vec_t<3, wp::float32> var_72;
    wp::float32 var_73;
    const wp::int32 var_74 = 2;
    wp::float32 var_75;
    wp::float32 var_76;
    wp::float32 var_77;
    wp::vec_t<3, wp::float32> var_78;
    bool var_79;
    const wp::float32 var_80 = 0.0;
    bool var_81;
    const wp::float32 var_82 = 0.0;
    bool var_83;
    wp::vec_t<3, wp::float32> var_84;
    wp::vec_t<3, wp::float32> var_85;
    wp::vec_t<3, wp::float32> var_86;
    wp::float32 var_87;
    bool var_88;
    wp::vec_t<3, wp::float32> var_89;
    wp::vec_t<3, wp::float32> var_90;
    wp::vec_t<3, wp::float32> var_91;
    bool var_92;
    wp::vec_t<3, wp::float32> var_93;
    wp::vec_t<3, wp::float32> var_94;
    wp::vec_t<3, wp::float32> var_95;
    wp::vec_t<3, wp::float32> var_96;
    wp::vec_t<3, wp::float32> var_97;
    //---------
    // dual vars
    wp::float32 adj_0 = {};
    wp::vec_t<3, wp::float32> adj_1 = {};
    bool adj_2 = {};
    wp::float32 adj_3 = {};
    bool adj_4 = {};
    wp::float32 adj_5 = {};
    wp::float32 adj_6 = {};
    wp::float32 adj_7 = {};
    bool adj_8 = {};
    wp::float32 adj_9 = {};
    wp::float32 adj_10 = {};
    wp::float32 adj_11 = {};
    wp::vec_t<3, wp::float32> adj_12 = {};
    wp::vec_t<3, wp::float32> adj_13 = {};
    wp::float32 adj_14 = {};
    wp::float32 adj_15 = {};
    wp::float32 adj_16 = {};
    wp::vec_t<3, wp::float32> adj_17 = {};
    wp::vec_t<3, wp::float32> adj_18 = {};
    wp::float32 adj_19 = {};
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
    wp::float32 adj_30 = {};
    wp::float32 adj_31 = {};
    wp::float32 adj_32 = {};
    wp::float32 adj_33 = {};
    wp::vec_t<3, wp::float32> adj_34 = {};
    wp::vec_t<3, wp::float32> adj_35 = {};
    wp::float32 adj_36 = {};
    wp::float32 adj_37 = {};
    wp::float32 adj_38 = {};
    wp::vec_t<3, wp::float32> adj_39 = {};
    wp::vec_t<3, wp::float32> adj_40 = {};
    wp::float32 adj_41 = {};
    wp::float32 adj_42 = {};
    wp::vec_t<3, wp::float32> adj_43 = {};
    wp::float32 adj_44 = {};
    bool adj_45 = {};
    wp::vec_t<3, wp::float32> adj_46 = {};
    wp::float32 adj_47 = {};
    wp::float32 adj_48 = {};
    wp::float32 adj_49 = {};
    wp::vec_t<3, wp::float32> adj_50 = {};
    wp::vec_t<3, wp::float32> adj_51 = {};
    wp::vec_t<3, wp::float32> adj_52 = {};
    wp::int32 adj_53 = {};
    wp::float32 adj_54 = {};
    wp::int32 adj_55 = {};
    wp::float32 adj_56 = {};
    wp::float32 adj_57 = {};
    wp::vec_t<3, wp::float32> adj_58 = {};
    wp::float32 adj_59 = {};
    wp::float32 adj_60 = {};
    wp::float32 adj_61 = {};
    wp::float32 adj_62 = {};
    wp::vec_t<3, wp::float32> adj_63 = {};
    bool adj_64 = {};
    wp::vec_t<3, wp::float32> adj_65 = {};
    wp::vec_t<3, wp::float32> adj_66 = {};
    wp::float32 adj_67 = {};
    wp::float32 adj_68 = {};
    wp::int32 adj_69 = {};
    wp::float32 adj_70 = {};
    wp::float32 adj_71 = {};
    wp::vec_t<3, wp::float32> adj_72 = {};
    wp::float32 adj_73 = {};
    wp::int32 adj_74 = {};
    wp::float32 adj_75 = {};
    wp::float32 adj_76 = {};
    wp::float32 adj_77 = {};
    wp::vec_t<3, wp::float32> adj_78 = {};
    bool adj_79 = {};
    wp::float32 adj_80 = {};
    bool adj_81 = {};
    wp::float32 adj_82 = {};
    bool adj_83 = {};
    wp::vec_t<3, wp::float32> adj_84 = {};
    wp::vec_t<3, wp::float32> adj_85 = {};
    wp::vec_t<3, wp::float32> adj_86 = {};
    wp::float32 adj_87 = {};
    bool adj_88 = {};
    wp::vec_t<3, wp::float32> adj_89 = {};
    wp::vec_t<3, wp::float32> adj_90 = {};
    wp::vec_t<3, wp::float32> adj_91 = {};
    bool adj_92 = {};
    wp::vec_t<3, wp::float32> adj_93 = {};
    wp::vec_t<3, wp::float32> adj_94 = {};
    wp::vec_t<3, wp::float32> adj_95 = {};
    wp::vec_t<3, wp::float32> adj_96 = {};
    wp::vec_t<3, wp::float32> adj_97 = {};
    //---------
    // forward
    // def sdf_cylinder_grad(                                                                 <L 376>
    // eps = 1.0e-8                                                                           <L 395>
    // point_z_up = _sdf_point_to_z_up(point, up_axis)                                        <L 396>
    var_1 = _sdf_point_to_z_up_0(var_point, var_up_axis);
    // if top_radius >= 0.0 and wp.abs(top_radius - radius) > 1.0e-6:                         <L 397>
    var_4 = (var_top_radius >= var_3);
    var_2 = var_4;
    if (var_2) {
        var_5 = wp::sub(var_top_radius, var_radius);
        var_6 = wp::abs(var_5);
        var_8 = (var_6 > var_7);
        var_2 = var_2 && var_8;
    }
    if (var_2) {
        // fd_eps = 1.0e-4                                                                    <L 399>
        // dx = _sdf_capped_cone_z(                                                           <L 400>
        // radius,                                                                            <L 401>
        // top_radius,                                                                        <L 402>
        // half_height,                                                                       <L 403>
        // point_z_up + wp.vec3(fd_eps, 0.0, 0.0),                                            <L 404>
        var_12 = wp::vec_t<3, wp::float32>(var_9, var_10, var_11);
        var_13 = wp::add(var_1, var_12);
        var_14 = _sdf_capped_cone_z_0(var_radius, var_top_radius, var_half_height, var_13);
        // ) - _sdf_capped_cone_z(                                                            <L 405>
        // radius,                                                                            <L 406>
        // top_radius,                                                                        <L 407>
        // half_height,                                                                       <L 408>
        // point_z_up - wp.vec3(fd_eps, 0.0, 0.0),                                            <L 409>
        var_17 = wp::vec_t<3, wp::float32>(var_9, var_15, var_16);
        var_18 = wp::sub(var_1, var_17);
        var_19 = _sdf_capped_cone_z_0(var_radius, var_top_radius, var_half_height, var_18);
        var_20 = wp::sub(var_14, var_19);
        // dy = _sdf_capped_cone_z(                                                           <L 411>
        // radius,                                                                            <L 412>
        // top_radius,                                                                        <L 413>
        // half_height,                                                                       <L 414>
        // point_z_up + wp.vec3(0.0, fd_eps, 0.0),                                            <L 415>
        var_23 = wp::vec_t<3, wp::float32>(var_21, var_9, var_22);
        var_24 = wp::add(var_1, var_23);
        var_25 = _sdf_capped_cone_z_0(var_radius, var_top_radius, var_half_height, var_24);
        // ) - _sdf_capped_cone_z(                                                            <L 416>
        // radius,                                                                            <L 417>
        // top_radius,                                                                        <L 418>
        // half_height,                                                                       <L 419>
        // point_z_up - wp.vec3(0.0, fd_eps, 0.0),                                            <L 420>
        var_28 = wp::vec_t<3, wp::float32>(var_26, var_9, var_27);
        var_29 = wp::sub(var_1, var_28);
        var_30 = _sdf_capped_cone_z_0(var_radius, var_top_radius, var_half_height, var_29);
        var_31 = wp::sub(var_25, var_30);
        // dz = _sdf_capped_cone_z(                                                           <L 422>
        // radius,                                                                            <L 423>
        // top_radius,                                                                        <L 424>
        // half_height,                                                                       <L 425>
        // point_z_up + wp.vec3(0.0, 0.0, fd_eps),                                            <L 426>
        var_34 = wp::vec_t<3, wp::float32>(var_32, var_33, var_9);
        var_35 = wp::add(var_1, var_34);
        var_36 = _sdf_capped_cone_z_0(var_radius, var_top_radius, var_half_height, var_35);
        // ) - _sdf_capped_cone_z(                                                            <L 427>
        // radius,                                                                            <L 428>
        // top_radius,                                                                        <L 429>
        // half_height,                                                                       <L 430>
        // point_z_up - wp.vec3(0.0, 0.0, fd_eps),                                            <L 431>
        var_39 = wp::vec_t<3, wp::float32>(var_37, var_38, var_9);
        var_40 = wp::sub(var_1, var_39);
        var_41 = _sdf_capped_cone_z_0(var_radius, var_top_radius, var_half_height, var_40);
        var_42 = wp::sub(var_36, var_41);
        // grad_z_up = wp.vec3(dx, dy, dz)                                                    <L 433>
        var_43 = wp::vec_t<3, wp::float32>(var_20, var_31, var_42);
        // grad_len = wp.length(grad_z_up)                                                    <L 434>
        var_44 = wp::length(var_43);
        // if grad_len > eps:                                                                 <L 435>
        var_45 = (var_44 > var_0);
        if (var_45) {
            // grad_z_up = grad_z_up / grad_len                                               <L 436>
            var_46 = wp::div(var_43, var_44);
        }
        if (!var_45) {
            // grad_z_up = wp.vec3(0.0, 0.0, 1.0)                                             <L 438>
            var_50 = wp::vec_t<3, wp::float32>(var_47, var_48, var_49);
        }
        var_51 = wp::where(var_45, var_46, var_50);
        // return _sdf_vector_from_z_up(grad_z_up, up_axis)                                   <L 439>
        var_52 = _sdf_vector_from_z_up_0(var_51, var_up_axis);
        goto label0;
    }
    // v = wp.vec3(point_z_up[0], point_z_up[1], 0.0)                                         <L 441>
    var_54 = wp::extract(var_1, var_53);
    var_56 = wp::extract(var_1, var_55);
    var_58 = wp::vec_t<3, wp::float32>(var_54, var_56, var_57);
    // v_len = wp.length(v)                                                                   <L 442>
    var_59 = wp::length(var_58);
    // radial = wp.vec3(0.0, 0.0, 1.0)                                                        <L 443>
    var_63 = wp::vec_t<3, wp::float32>(var_60, var_61, var_62);
    // if v_len > eps:                                                                        <L 444>
    var_64 = (var_59 > var_0);
    if (var_64) {
        // radial = v / v_len                                                                 <L 445>
        var_65 = wp::div(var_58, var_59);
    }
    var_66 = wp::where(var_64, var_65, var_63);
    // axial = wp.vec3(0.0, 0.0, wp.sign(point_z_up[2]))                                      <L 446>
    var_70 = wp::extract(var_1, var_69);
    var_71 = wp::sign(var_70);
    var_72 = wp::vec_t<3, wp::float32>(var_67, var_68, var_71);
    // dx = v_len - radius                                                                    <L 447>
    var_73 = wp::sub(var_59, var_radius);
    // dy = wp.abs(point_z_up[2]) - half_height                                               <L 448>
    var_75 = wp::extract(var_1, var_74);
    var_76 = wp::abs(var_75);
    var_77 = wp::sub(var_76, var_half_height);
    // grad_z_up = wp.vec3()                                                                  <L 449>
    var_78 = wp::vec_t<3, wp::float32>();
    // if dx > 0.0 and dy > 0.0:                                                              <L 450>
    var_81 = (var_73 > var_80);
    var_79 = var_81;
    if (var_79) {
        var_83 = (var_77 > var_82);
        var_79 = var_79 && var_83;
    }
    if (var_79) {
        // g = radial * dx + axial * dy                                                       <L 451>
        var_84 = wp::mul(var_66, var_73);
        var_85 = wp::mul(var_72, var_77);
        var_86 = wp::add(var_84, var_85);
        // g_len = wp.length(g)                                                               <L 452>
        var_87 = wp::length(var_86);
        // if g_len > eps:                                                                    <L 453>
        var_88 = (var_87 > var_0);
        if (var_88) {
            // grad_z_up = g / g_len                                                          <L 454>
            var_89 = wp::div(var_86, var_87);
        }
        if (!var_88) {
            // grad_z_up = radial                                                             <L 456>
            var_90 = wp::copy(var_66);
        }
        var_91 = wp::where(var_88, var_89, var_90);
    }
    if (!var_79) {
        // elif dx > dy:                                                                      <L 457>
        var_92 = (var_73 > var_77);
        if (var_92) {
            // grad_z_up = radial                                                             <L 458>
            var_93 = wp::copy(var_66);
        }
        if (!var_92) {
            // grad_z_up = axial                                                              <L 460>
            var_94 = wp::copy(var_72);
        }
        var_95 = wp::where(var_92, var_93, var_94);
    }
    var_96 = wp::where(var_79, var_91, var_95);
    // return _sdf_vector_from_z_up(grad_z_up, up_axis)                                       <L 461>
    var_97 = _sdf_vector_from_z_up_0(var_96, var_up_axis);
    goto label1;
    //---------
    // reverse
    label1:;
    adj_97 += adj_ret;
    adj__sdf_vector_from_z_up_0(var_96, var_up_axis, adj_96, adj_up_axis, adj_97);
    // adj: return _sdf_vector_from_z_up(grad_z_up, up_axis)                                  <L 461>
    wp::adj_where(var_79, var_91, var_95, adj_79, adj_91, adj_95, adj_96);
    if (!var_79) {
        wp::adj_where(var_92, var_93, var_94, adj_92, adj_93, adj_94, adj_95);
        if (!var_92) {
            wp::adj_copy(var_72, adj_72, adj_94);
            // adj: grad_z_up = axial                                                         <L 460>
        }
        if (var_92) {
            wp::adj_copy(var_66, adj_66, adj_93);
            // adj: grad_z_up = radial                                                        <L 458>
        }
        // adj: elif dx > dy:                                                                 <L 457>
    }
    if (var_79) {
        wp::adj_where(var_88, var_89, var_90, adj_88, adj_89, adj_90, adj_91);
        if (!var_88) {
            wp::adj_copy(var_66, adj_66, adj_90);
            // adj: grad_z_up = radial                                                        <L 456>
        }
        if (var_88) {
            wp::adj_div(var_86, var_87, adj_86, adj_87, adj_89);
            // adj: grad_z_up = g / g_len                                                     <L 454>
        }
        // adj: if g_len > eps:                                                               <L 453>
        wp::adj_length(var_86, var_87, adj_86, adj_87);
        // adj: g_len = wp.length(g)                                                          <L 452>
        wp::adj_add(var_84, var_85, adj_84, adj_85, adj_86);
        wp::adj_mul(var_72, var_77, adj_72, adj_77, adj_85);
        wp::adj_mul(var_66, var_73, adj_66, adj_73, adj_84);
        // adj: g = radial * dx + axial * dy                                                  <L 451>
    }
    if (var_79) {
    }
    // adj: if dx > 0.0 and dy > 0.0:                                                         <L 450>
    // adj: grad_z_up = wp.vec3()                                                             <L 449>
    wp::adj_sub(var_76, var_half_height, adj_76, adj_half_height, adj_77);
    wp::adj_abs(var_75, adj_75, adj_76);
    wp::adj_extract(var_1, var_74, adj_1, adj_74, adj_75);
    // adj: dy = wp.abs(point_z_up[2]) - half_height                                          <L 448>
    wp::adj_sub(var_59, var_radius, adj_59, adj_radius, adj_73);
    // adj: dx = v_len - radius                                                               <L 447>
    wp::adj_vec_t(var_67, var_68, var_71, adj_67, adj_68, adj_71, adj_72);
    wp::adj_extract(var_1, var_69, adj_1, adj_69, adj_70);
    // adj: axial = wp.vec3(0.0, 0.0, wp.sign(point_z_up[2]))                                 <L 446>
    wp::adj_where(var_64, var_65, var_63, adj_64, adj_65, adj_63, adj_66);
    if (var_64) {
        wp::adj_div(var_58, var_59, adj_58, adj_59, adj_65);
        // adj: radial = v / v_len                                                            <L 445>
    }
    // adj: if v_len > eps:                                                                   <L 444>
    wp::adj_vec_t(var_60, var_61, var_62, adj_60, adj_61, adj_62, adj_63);
    // adj: radial = wp.vec3(0.0, 0.0, 1.0)                                                   <L 443>
    wp::adj_length(var_58, var_59, adj_58, adj_59);
    // adj: v_len = wp.length(v)                                                              <L 442>
    wp::adj_vec_t(var_54, var_56, var_57, adj_54, adj_56, adj_57, adj_58);
    wp::adj_extract(var_1, var_55, adj_1, adj_55, adj_56);
    wp::adj_extract(var_1, var_53, adj_1, adj_53, adj_54);
    // adj: v = wp.vec3(point_z_up[0], point_z_up[1], 0.0)                                    <L 441>
    if (var_2) {
        label0:;
        adj_52 += adj_ret;
        adj__sdf_vector_from_z_up_0(var_51, var_up_axis, adj_51, adj_up_axis, adj_52);
        // adj: return _sdf_vector_from_z_up(grad_z_up, up_axis)                              <L 439>
        wp::adj_where(var_45, var_46, var_50, adj_45, adj_46, adj_50, adj_51);
        if (!var_45) {
            wp::adj_vec_t(var_47, var_48, var_49, adj_47, adj_48, adj_49, adj_50);
            // adj: grad_z_up = wp.vec3(0.0, 0.0, 1.0)                                        <L 438>
        }
        if (var_45) {
            wp::adj_div(var_43, var_44, adj_43, adj_44, adj_46);
            // adj: grad_z_up = grad_z_up / grad_len                                          <L 436>
        }
        // adj: if grad_len > eps:                                                            <L 435>
        wp::adj_length(var_43, var_44, adj_43, adj_44);
        // adj: grad_len = wp.length(grad_z_up)                                               <L 434>
        wp::adj_vec_t(var_20, var_31, var_42, adj_20, adj_31, adj_42, adj_43);
        // adj: grad_z_up = wp.vec3(dx, dy, dz)                                               <L 433>
        wp::adj_sub(var_36, var_41, adj_36, adj_41, adj_42);
        adj__sdf_capped_cone_z_0(var_radius, var_top_radius, var_half_height, var_40, adj_radius, adj_top_radius, adj_half_height, adj_40, adj_41);
        wp::adj_sub(var_1, var_39, adj_1, adj_39, adj_40);
        wp::adj_vec_t(var_37, var_38, var_9, adj_37, adj_38, adj_9, adj_39);
        // adj: point_z_up - wp.vec3(0.0, 0.0, fd_eps),                                       <L 431>
        // adj: half_height,                                                                  <L 430>
        // adj: top_radius,                                                                   <L 429>
        // adj: radius,                                                                       <L 428>
        // adj: ) - _sdf_capped_cone_z(                                                       <L 427>
        adj__sdf_capped_cone_z_0(var_radius, var_top_radius, var_half_height, var_35, adj_radius, adj_top_radius, adj_half_height, adj_35, adj_36);
        wp::adj_add(var_1, var_34, adj_1, adj_34, adj_35);
        wp::adj_vec_t(var_32, var_33, var_9, adj_32, adj_33, adj_9, adj_34);
        // adj: point_z_up + wp.vec3(0.0, 0.0, fd_eps),                                       <L 426>
        // adj: half_height,                                                                  <L 425>
        // adj: top_radius,                                                                   <L 424>
        // adj: radius,                                                                       <L 423>
        // adj: dz = _sdf_capped_cone_z(                                                      <L 422>
        wp::adj_sub(var_25, var_30, adj_25, adj_30, adj_31);
        adj__sdf_capped_cone_z_0(var_radius, var_top_radius, var_half_height, var_29, adj_radius, adj_top_radius, adj_half_height, adj_29, adj_30);
        wp::adj_sub(var_1, var_28, adj_1, adj_28, adj_29);
        wp::adj_vec_t(var_26, var_9, var_27, adj_26, adj_9, adj_27, adj_28);
        // adj: point_z_up - wp.vec3(0.0, fd_eps, 0.0),                                       <L 420>
        // adj: half_height,                                                                  <L 419>
        // adj: top_radius,                                                                   <L 418>
        // adj: radius,                                                                       <L 417>
        // adj: ) - _sdf_capped_cone_z(                                                       <L 416>
        adj__sdf_capped_cone_z_0(var_radius, var_top_radius, var_half_height, var_24, adj_radius, adj_top_radius, adj_half_height, adj_24, adj_25);
        wp::adj_add(var_1, var_23, adj_1, adj_23, adj_24);
        wp::adj_vec_t(var_21, var_9, var_22, adj_21, adj_9, adj_22, adj_23);
        // adj: point_z_up + wp.vec3(0.0, fd_eps, 0.0),                                       <L 415>
        // adj: half_height,                                                                  <L 414>
        // adj: top_radius,                                                                   <L 413>
        // adj: radius,                                                                       <L 412>
        // adj: dy = _sdf_capped_cone_z(                                                      <L 411>
        wp::adj_sub(var_14, var_19, adj_14, adj_19, adj_20);
        adj__sdf_capped_cone_z_0(var_radius, var_top_radius, var_half_height, var_18, adj_radius, adj_top_radius, adj_half_height, adj_18, adj_19);
        wp::adj_sub(var_1, var_17, adj_1, adj_17, adj_18);
        wp::adj_vec_t(var_9, var_15, var_16, adj_9, adj_15, adj_16, adj_17);
        // adj: point_z_up - wp.vec3(fd_eps, 0.0, 0.0),                                       <L 409>
        // adj: half_height,                                                                  <L 408>
        // adj: top_radius,                                                                   <L 407>
        // adj: radius,                                                                       <L 406>
        // adj: ) - _sdf_capped_cone_z(                                                       <L 405>
        adj__sdf_capped_cone_z_0(var_radius, var_top_radius, var_half_height, var_13, adj_radius, adj_top_radius, adj_half_height, adj_13, adj_14);
        wp::adj_add(var_1, var_12, adj_1, adj_12, adj_13);
        wp::adj_vec_t(var_9, var_10, var_11, adj_9, adj_10, adj_11, adj_12);
        // adj: point_z_up + wp.vec3(fd_eps, 0.0, 0.0),                                       <L 404>
        // adj: half_height,                                                                  <L 403>
        // adj: top_radius,                                                                   <L 402>
        // adj: radius,                                                                       <L 401>
        // adj: dx = _sdf_capped_cone_z(                                                      <L 400>
        // adj: fd_eps = 1.0e-4                                                               <L 399>
    }
    if (var_2) {
        wp::adj_abs(var_5, adj_5, adj_6);
        wp::adj_sub(var_top_radius, var_radius, adj_top_radius, adj_radius, adj_5);
    }
    // adj: if top_radius >= 0.0 and wp.abs(top_radius - radius) > 1.0e-6:                    <L 397>
    adj__sdf_point_to_z_up_0(var_point, var_up_axis, adj_point, adj_up_axis, adj_1);
    // adj: point_z_up = _sdf_point_to_z_up(point, up_axis)                                   <L 396>
    // adj: eps = 1.0e-8                                                                      <L 395>
    // adj: def sdf_cylinder_grad(                                                            <L 376>
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:530
static CUDA_CALLABLE void adj_sdf_cone_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::float32 var_radius,
    wp::float32 var_half_height,
    wp::int32 var_up_axis,
    wp::vec_t<3, wp::float32> & adj_point,
    wp::float32 & adj_radius,
    wp::float32 & adj_half_height,
    wp::int32 & adj_up_axis,
    wp::float32 & adj_ret)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    const wp::float32 var_1 = 0.0;
    wp::float32 var_2;
    //---------
    // dual vars
    wp::vec_t<3, wp::float32> adj_0 = {};
    wp::float32 adj_1 = {};
    wp::float32 adj_2 = {};
    //---------
    // forward
    // def sdf_cone(point: wp.vec3, radius: float, half_height: float, up_axis: int = int(Axis.Y)):       <L 531>
    // point_z_up = _sdf_point_to_z_up(point, up_axis)                                        <L 543>
    var_0 = _sdf_point_to_z_up_0(var_point, var_up_axis);
    // return _sdf_capped_cone_z(radius, 0.0, half_height, point_z_up)                        <L 544>
    var_2 = _sdf_capped_cone_z_0(var_radius, var_1, var_half_height, var_0);
    goto label0;
    //---------
    // reverse
    label0:;
    adj_2 += adj_ret;
    adj__sdf_capped_cone_z_0(var_radius, var_1, var_half_height, var_0, adj_radius, adj_1, adj_half_height, adj_0, adj_2);
    // adj: return _sdf_capped_cone_z(radius, 0.0, half_height, point_z_up)                   <L 544>
    adj__sdf_point_to_z_up_0(var_point, var_up_axis, adj_point, adj_up_axis, adj_0);
    // adj: point_z_up = _sdf_point_to_z_up(point, up_axis)                                   <L 543>
    // adj: def sdf_cone(point: wp.vec3, radius: float, half_height: float, up_axis: int = int(Axis.Y)):  <L 531>
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:547
static CUDA_CALLABLE void adj_sdf_cone_grad_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::float32 var_radius,
    wp::float32 var_half_height,
    wp::int32 var_up_axis,
    wp::vec_t<3, wp::float32> & adj_point,
    wp::float32 & adj_radius,
    wp::float32 & adj_half_height,
    wp::int32 & adj_up_axis,
    wp::vec_t<3, wp::float32> & adj_ret)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    const wp::float32 var_1 = 0.0;
    bool var_2;
    const wp::float32 var_3 = 0.0;
    const wp::float32 var_4 = 0.0;
    const wp::int32 var_5 = 2;
    wp::float32 var_6;
    wp::float32 var_7;
    wp::vec_t<3, wp::float32> var_8;
    wp::vec_t<3, wp::float32> var_9;
    const wp::int32 var_10 = 0;
    wp::float32 var_11;
    const wp::int32 var_12 = 1;
    wp::float32 var_13;
    const wp::float32 var_14 = 0.0;
    wp::vec_t<3, wp::float32> var_15;
    wp::float32 var_16;
    const wp::int32 var_17 = 2;
    wp::float32 var_18;
    wp::float32 var_19;
    wp::float32 var_20;
    const wp::float32 var_21 = 2.0;
    wp::float32 var_22;
    wp::float32 var_23;
    wp::float32 var_24;
    const wp::int32 var_25 = 2;
    wp::float32 var_26;
    wp::float32 var_27;
    wp::float32 var_28;
    wp::vec_t<3, wp::float32> var_29;
    bool var_30;
    const wp::float32 var_31 = 0.0;
    bool var_32;
    const wp::int32 var_33 = 0;
    wp::float32 var_34;
    const wp::int32 var_35 = 1;
    wp::float32 var_36;
    const wp::float32 var_37 = 0.0;
    wp::vec_t<3, wp::float32> var_38;
    wp::vec_t<3, wp::float32> var_39;
    const wp::float32 var_40 = 0.0;
    const wp::float32 var_41 = 0.0;
    const wp::float32 var_42 = 2.0;
    wp::float32 var_43;
    wp::float32 var_44;
    wp::vec_t<3, wp::float32> var_45;
    wp::vec_t<3, wp::float32> var_46;
    wp::vec_t<3, wp::float32> var_47;
    const wp::float32 var_48 = 0.0;
    const wp::float32 var_49 = 0.0;
    const wp::float32 var_50 = 1.0;
    wp::vec_t<3, wp::float32> var_51;
    wp::vec_t<3, wp::float32> var_52;
    const wp::float32 var_53 = 0.0;
    const wp::float32 var_54 = 0.0;
    const wp::int32 var_55 = 2;
    wp::float32 var_56;
    wp::float32 var_57;
    wp::vec_t<3, wp::float32> var_58;
    wp::vec_t<3, wp::float32> var_59;
    wp::vec_t<3, wp::float32> var_60;
    //---------
    // dual vars
    wp::vec_t<3, wp::float32> adj_0 = {};
    wp::float32 adj_1 = {};
    bool adj_2 = {};
    wp::float32 adj_3 = {};
    wp::float32 adj_4 = {};
    wp::int32 adj_5 = {};
    wp::float32 adj_6 = {};
    wp::float32 adj_7 = {};
    wp::vec_t<3, wp::float32> adj_8 = {};
    wp::vec_t<3, wp::float32> adj_9 = {};
    wp::int32 adj_10 = {};
    wp::float32 adj_11 = {};
    wp::int32 adj_12 = {};
    wp::float32 adj_13 = {};
    wp::float32 adj_14 = {};
    wp::vec_t<3, wp::float32> adj_15 = {};
    wp::float32 adj_16 = {};
    wp::int32 adj_17 = {};
    wp::float32 adj_18 = {};
    wp::float32 adj_19 = {};
    wp::float32 adj_20 = {};
    wp::float32 adj_21 = {};
    wp::float32 adj_22 = {};
    wp::float32 adj_23 = {};
    wp::float32 adj_24 = {};
    wp::int32 adj_25 = {};
    wp::float32 adj_26 = {};
    wp::float32 adj_27 = {};
    wp::float32 adj_28 = {};
    wp::vec_t<3, wp::float32> adj_29 = {};
    bool adj_30 = {};
    wp::float32 adj_31 = {};
    bool adj_32 = {};
    wp::int32 adj_33 = {};
    wp::float32 adj_34 = {};
    wp::int32 adj_35 = {};
    wp::float32 adj_36 = {};
    wp::float32 adj_37 = {};
    wp::vec_t<3, wp::float32> adj_38 = {};
    wp::vec_t<3, wp::float32> adj_39 = {};
    wp::float32 adj_40 = {};
    wp::float32 adj_41 = {};
    wp::float32 adj_42 = {};
    wp::float32 adj_43 = {};
    wp::float32 adj_44 = {};
    wp::vec_t<3, wp::float32> adj_45 = {};
    wp::vec_t<3, wp::float32> adj_46 = {};
    wp::vec_t<3, wp::float32> adj_47 = {};
    wp::float32 adj_48 = {};
    wp::float32 adj_49 = {};
    wp::float32 adj_50 = {};
    wp::vec_t<3, wp::float32> adj_51 = {};
    wp::vec_t<3, wp::float32> adj_52 = {};
    wp::float32 adj_53 = {};
    wp::float32 adj_54 = {};
    wp::int32 adj_55 = {};
    wp::float32 adj_56 = {};
    wp::float32 adj_57 = {};
    wp::vec_t<3, wp::float32> adj_58 = {};
    wp::vec_t<3, wp::float32> adj_59 = {};
    wp::vec_t<3, wp::float32> adj_60 = {};
    //---------
    // forward
    // def sdf_cone_grad(point: wp.vec3, radius: float, half_height: float, up_axis: int = int(Axis.Y)):       <L 548>
    // point_z_up = _sdf_point_to_z_up(point, up_axis)                                        <L 560>
    var_0 = _sdf_point_to_z_up_0(var_point, var_up_axis);
    // if half_height <= 0.0:                                                                 <L 561>
    var_2 = (var_half_height <= var_1);
    if (var_2) {
        // return _sdf_vector_from_z_up(wp.vec3(0.0, 0.0, wp.sign(point_z_up[2])), up_axis)       <L 562>
        var_6 = wp::extract(var_0, var_5);
        var_7 = wp::sign(var_6);
        var_8 = wp::vec_t<3, wp::float32>(var_3, var_4, var_7);
        var_9 = _sdf_vector_from_z_up_0(var_8, var_up_axis);
        goto label0;
    }
    // r = wp.length(wp.vec3(point_z_up[0], point_z_up[1], 0.0))                              <L 565>
    var_11 = wp::extract(var_0, var_10);
    var_13 = wp::extract(var_0, var_12);
    var_15 = wp::vec_t<3, wp::float32>(var_11, var_13, var_14);
    var_16 = wp::length(var_15);
    // dx = r - radius * (half_height - point_z_up[2]) / (2.0 * half_height)                  <L 566>
    var_18 = wp::extract(var_0, var_17);
    var_19 = wp::sub(var_half_height, var_18);
    var_20 = wp::mul(var_radius, var_19);
    var_22 = wp::mul(var_21, var_half_height);
    var_23 = wp::div(var_20, var_22);
    var_24 = wp::sub(var_16, var_23);
    // dy = wp.abs(point_z_up[2]) - half_height                                               <L 567>
    var_26 = wp::extract(var_0, var_25);
    var_27 = wp::abs(var_26);
    var_28 = wp::sub(var_27, var_half_height);
    // grad_z_up = wp.vec3()                                                                  <L 568>
    var_29 = wp::vec_t<3, wp::float32>();
    // if dx > dy:                                                                            <L 569>
    var_30 = (var_24 > var_28);
    if (var_30) {
        // if r > 0.0:                                                                        <L 571>
        var_32 = (var_16 > var_31);
        if (var_32) {
            // radial_dir = wp.vec3(point_z_up[0], point_z_up[1], 0.0) / r                    <L 572>
            var_34 = wp::extract(var_0, var_33);
            var_36 = wp::extract(var_0, var_35);
            var_38 = wp::vec_t<3, wp::float32>(var_34, var_36, var_37);
            var_39 = wp::div(var_38, var_16);
            // grad_z_up = wp.normalize(radial_dir + wp.vec3(0.0, 0.0, radius / (2.0 * half_height)))       <L 574>
            var_43 = wp::mul(var_42, var_half_height);
            var_44 = wp::div(var_radius, var_43);
            var_45 = wp::vec_t<3, wp::float32>(var_40, var_41, var_44);
            var_46 = wp::add(var_39, var_45);
            var_47 = wp::normalize(var_46);
        }
        if (!var_32) {
            // grad_z_up = wp.vec3(0.0, 0.0, 1.0)                                             <L 576>
            var_51 = wp::vec_t<3, wp::float32>(var_48, var_49, var_50);
        }
        var_52 = wp::where(var_32, var_47, var_51);
    }
    if (!var_30) {
        // grad_z_up = wp.vec3(0.0, 0.0, wp.sign(point_z_up[2]))                              <L 579>
        var_56 = wp::extract(var_0, var_55);
        var_57 = wp::sign(var_56);
        var_58 = wp::vec_t<3, wp::float32>(var_53, var_54, var_57);
    }
    var_59 = wp::where(var_30, var_52, var_58);
    // return _sdf_vector_from_z_up(grad_z_up, up_axis)                                       <L 580>
    var_60 = _sdf_vector_from_z_up_0(var_59, var_up_axis);
    goto label1;
    //---------
    // reverse
    label1:;
    adj_60 += adj_ret;
    adj__sdf_vector_from_z_up_0(var_59, var_up_axis, adj_59, adj_up_axis, adj_60);
    // adj: return _sdf_vector_from_z_up(grad_z_up, up_axis)                                  <L 580>
    wp::adj_where(var_30, var_52, var_58, adj_30, adj_52, adj_58, adj_59);
    if (!var_30) {
        wp::adj_vec_t(var_53, var_54, var_57, adj_53, adj_54, adj_57, adj_58);
        wp::adj_extract(var_0, var_55, adj_0, adj_55, adj_56);
        // adj: grad_z_up = wp.vec3(0.0, 0.0, wp.sign(point_z_up[2]))                         <L 579>
    }
    if (var_30) {
        wp::adj_where(var_32, var_47, var_51, adj_32, adj_47, adj_51, adj_52);
        if (!var_32) {
            wp::adj_vec_t(var_48, var_49, var_50, adj_48, adj_49, adj_50, adj_51);
            // adj: grad_z_up = wp.vec3(0.0, 0.0, 1.0)                                        <L 576>
        }
        if (var_32) {
            wp::adj_normalize(var_46, var_47, adj_46, adj_47);
            wp::adj_add(var_39, var_45, adj_39, adj_45, adj_46);
            wp::adj_vec_t(var_40, var_41, var_44, adj_40, adj_41, adj_44, adj_45);
            wp::adj_div(var_radius, var_43, var_44, adj_radius, adj_43, adj_44);
            wp::adj_mul(var_42, var_half_height, adj_42, adj_half_height, adj_43);
            // adj: grad_z_up = wp.normalize(radial_dir + wp.vec3(0.0, 0.0, radius / (2.0 * half_height)))  <L 574>
            wp::adj_div(var_38, var_16, adj_38, adj_16, adj_39);
            wp::adj_vec_t(var_34, var_36, var_37, adj_34, adj_36, adj_37, adj_38);
            wp::adj_extract(var_0, var_35, adj_0, adj_35, adj_36);
            wp::adj_extract(var_0, var_33, adj_0, adj_33, adj_34);
            // adj: radial_dir = wp.vec3(point_z_up[0], point_z_up[1], 0.0) / r               <L 572>
        }
        // adj: if r > 0.0:                                                                   <L 571>
    }
    // adj: if dx > dy:                                                                       <L 569>
    // adj: grad_z_up = wp.vec3()                                                             <L 568>
    wp::adj_sub(var_27, var_half_height, adj_27, adj_half_height, adj_28);
    wp::adj_abs(var_26, adj_26, adj_27);
    wp::adj_extract(var_0, var_25, adj_0, adj_25, adj_26);
    // adj: dy = wp.abs(point_z_up[2]) - half_height                                          <L 567>
    wp::adj_sub(var_16, var_23, adj_16, adj_23, adj_24);
    wp::adj_div(var_20, var_22, var_23, adj_20, adj_22, adj_23);
    wp::adj_mul(var_21, var_half_height, adj_21, adj_half_height, adj_22);
    wp::adj_mul(var_radius, var_19, adj_radius, adj_19, adj_20);
    wp::adj_sub(var_half_height, var_18, adj_half_height, adj_18, adj_19);
    wp::adj_extract(var_0, var_17, adj_0, adj_17, adj_18);
    // adj: dx = r - radius * (half_height - point_z_up[2]) / (2.0 * half_height)             <L 566>
    wp::adj_length(var_15, var_16, adj_15, adj_16);
    wp::adj_vec_t(var_11, var_13, var_14, adj_11, adj_13, adj_14, adj_15);
    wp::adj_extract(var_0, var_12, adj_0, adj_12, adj_13);
    wp::adj_extract(var_0, var_10, adj_0, adj_10, adj_11);
    // adj: r = wp.length(wp.vec3(point_z_up[0], point_z_up[1], 0.0))                         <L 565>
    if (var_2) {
        label0:;
        adj_9 += adj_ret;
        adj__sdf_vector_from_z_up_0(var_8, var_up_axis, adj_8, adj_up_axis, adj_9);
        wp::adj_vec_t(var_3, var_4, var_7, adj_3, adj_4, adj_7, adj_8);
        wp::adj_extract(var_0, var_5, adj_0, adj_5, adj_6);
        // adj: return _sdf_vector_from_z_up(wp.vec3(0.0, 0.0, wp.sign(point_z_up[2])), up_axis)  <L 562>
    }
    // adj: if half_height <= 0.0:                                                            <L 561>
    adj__sdf_point_to_z_up_0(var_point, var_up_axis, adj_point, adj_up_axis, adj_0);
    // adj: point_z_up = _sdf_point_to_z_up(point, up_axis)                                   <L 560>
    // adj: def sdf_cone_grad(point: wp.vec3, radius: float, half_height: float, up_axis: int = int(Axis.Y)):  <L 548>
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:464
static CUDA_CALLABLE void adj_sdf_ellipsoid_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::vec_t<3, wp::float32> var_radii,
    wp::vec_t<3, wp::float32> & adj_point,
    wp::vec_t<3, wp::float32> & adj_radii,
    wp::float32 & adj_ret)
{
    //---------
    // primal vars
    const wp::float32 var_0 = 1e-08;
    const wp::int32 var_1 = 0;
    wp::float32 var_2;
    wp::float32 var_3;
    wp::float32 var_4;
    const wp::int32 var_5 = 1;
    wp::float32 var_6;
    wp::float32 var_7;
    wp::float32 var_8;
    const wp::int32 var_9 = 2;
    wp::float32 var_10;
    wp::float32 var_11;
    wp::float32 var_12;
    wp::vec_t<3, wp::float32> var_13;
    const wp::float32 var_14 = 1.0;
    const wp::float32 var_15 = 1.0;
    const wp::float32 var_16 = 1.0;
    wp::vec_t<3, wp::float32> var_17;
    wp::vec_t<3, wp::float32> var_18;
    wp::vec_t<3, wp::float32> var_19;
    wp::vec_t<3, wp::float32> var_20;
    wp::vec_t<3, wp::float32> var_21;
    wp::float32 var_22;
    wp::float32 var_23;
    bool var_24;
    const wp::float32 var_25 = 1.0;
    wp::float32 var_26;
    wp::float32 var_27;
    wp::float32 var_28;
    const wp::int32 var_29 = 0;
    wp::float32 var_30;
    const wp::int32 var_31 = 1;
    wp::float32 var_32;
    wp::float32 var_33;
    const wp::int32 var_34 = 2;
    wp::float32 var_35;
    wp::float32 var_36;
    wp::float32 var_37;
    //---------
    // dual vars
    wp::float32 adj_0 = {};
    wp::int32 adj_1 = {};
    wp::float32 adj_2 = {};
    wp::float32 adj_3 = {};
    wp::float32 adj_4 = {};
    wp::int32 adj_5 = {};
    wp::float32 adj_6 = {};
    wp::float32 adj_7 = {};
    wp::float32 adj_8 = {};
    wp::int32 adj_9 = {};
    wp::float32 adj_10 = {};
    wp::float32 adj_11 = {};
    wp::float32 adj_12 = {};
    wp::vec_t<3, wp::float32> adj_13 = {};
    wp::float32 adj_14 = {};
    wp::float32 adj_15 = {};
    wp::float32 adj_16 = {};
    wp::vec_t<3, wp::float32> adj_17 = {};
    wp::vec_t<3, wp::float32> adj_18 = {};
    wp::vec_t<3, wp::float32> adj_19 = {};
    wp::vec_t<3, wp::float32> adj_20 = {};
    wp::vec_t<3, wp::float32> adj_21 = {};
    wp::float32 adj_22 = {};
    wp::float32 adj_23 = {};
    bool adj_24 = {};
    wp::float32 adj_25 = {};
    wp::float32 adj_26 = {};
    wp::float32 adj_27 = {};
    wp::float32 adj_28 = {};
    wp::int32 adj_29 = {};
    wp::float32 adj_30 = {};
    wp::int32 adj_31 = {};
    wp::float32 adj_32 = {};
    wp::float32 adj_33 = {};
    wp::int32 adj_34 = {};
    wp::float32 adj_35 = {};
    wp::float32 adj_36 = {};
    wp::float32 adj_37 = {};
    //---------
    // forward
    // def sdf_ellipsoid(point: wp.vec3, radii: wp.vec3):                                     <L 465>
    // eps = 1.0e-8                                                                           <L 477>
    // r = wp.vec3(                                                                           <L 478>
    // wp.max(wp.abs(radii[0]), eps),                                                         <L 479>
    var_2 = wp::extract(var_radii, var_1);
    var_3 = wp::abs(var_2);
    var_4 = wp::max(var_3, var_0);
    // wp.max(wp.abs(radii[1]), eps),                                                         <L 480>
    var_6 = wp::extract(var_radii, var_5);
    var_7 = wp::abs(var_6);
    var_8 = wp::max(var_7, var_0);
    // wp.max(wp.abs(radii[2]), eps),                                                         <L 481>
    var_10 = wp::extract(var_radii, var_9);
    var_11 = wp::abs(var_10);
    var_12 = wp::max(var_11, var_0);
    var_13 = wp::vec_t<3, wp::float32>(var_4, var_8, var_12);
    // inv_r = wp.cw_div(wp.vec3(1.0, 1.0, 1.0), r)                                           <L 483>
    var_17 = wp::vec_t<3, wp::float32>(var_14, var_15, var_16);
    var_18 = wp::cw_div(var_17, var_13);
    // inv_r2 = wp.cw_mul(inv_r, inv_r)                                                       <L 484>
    var_19 = wp::cw_mul(var_18, var_18);
    // q0 = wp.cw_mul(point, inv_r)  # p / r                                                  <L 485>
    var_20 = wp::cw_mul(var_point, var_18);
    // q1 = wp.cw_mul(point, inv_r2)  # p / r^2                                               <L 486>
    var_21 = wp::cw_mul(var_point, var_19);
    // k0 = wp.length(q0)                                                                     <L 487>
    var_22 = wp::length(var_20);
    // k1 = wp.length(q1)                                                                     <L 488>
    var_23 = wp::length(var_21);
    // if k1 > eps:                                                                           <L 489>
    var_24 = (var_23 > var_0);
    if (var_24) {
        // return k0 * (k0 - 1.0) / k1                                                        <L 490>
        var_26 = wp::sub(var_22, var_25);
        var_27 = wp::mul(var_22, var_26);
        var_28 = wp::div(var_27, var_23);
        goto label0;
    }
    // return -wp.min(wp.min(r[0], r[1]), r[2])                                               <L 492>
    var_30 = wp::extract(var_13, var_29);
    var_32 = wp::extract(var_13, var_31);
    var_33 = wp::min(var_30, var_32);
    var_35 = wp::extract(var_13, var_34);
    var_36 = wp::min(var_33, var_35);
    var_37 = wp::neg(var_36);
    goto label1;
    //---------
    // reverse
    label1:;
    adj_37 += adj_ret;
    wp::adj_neg(var_36, adj_36, adj_37);
    wp::adj_min(var_33, var_35, adj_33, adj_35, adj_36);
    wp::adj_extract(var_13, var_34, adj_13, adj_34, adj_35);
    wp::adj_min(var_30, var_32, adj_30, adj_32, adj_33);
    wp::adj_extract(var_13, var_31, adj_13, adj_31, adj_32);
    wp::adj_extract(var_13, var_29, adj_13, adj_29, adj_30);
    // adj: return -wp.min(wp.min(r[0], r[1]), r[2])                                          <L 492>
    if (var_24) {
        label0:;
        adj_28 += adj_ret;
        wp::adj_div(var_27, var_23, var_28, adj_27, adj_23, adj_28);
        wp::adj_mul(var_22, var_26, adj_22, adj_26, adj_27);
        wp::adj_sub(var_22, var_25, adj_22, adj_25, adj_26);
        // adj: return k0 * (k0 - 1.0) / k1                                                   <L 490>
    }
    // adj: if k1 > eps:                                                                      <L 489>
    wp::adj_length(var_21, var_23, adj_21, adj_23);
    // adj: k1 = wp.length(q1)                                                                <L 488>
    wp::adj_length(var_20, var_22, adj_20, adj_22);
    // adj: k0 = wp.length(q0)                                                                <L 487>
    wp::adj_cw_mul(var_point, var_19, adj_point, adj_19, adj_21);
    // adj: q1 = wp.cw_mul(point, inv_r2)  # p / r^2                                          <L 486>
    wp::adj_cw_mul(var_point, var_18, adj_point, adj_18, adj_20);
    // adj: q0 = wp.cw_mul(point, inv_r)  # p / r                                             <L 485>
    wp::adj_cw_mul(var_18, var_18, adj_18, adj_18, adj_19);
    // adj: inv_r2 = wp.cw_mul(inv_r, inv_r)                                                  <L 484>
    wp::adj_cw_div(var_17, var_13, var_18, adj_17, adj_13, adj_18);
    wp::adj_vec_t(var_14, var_15, var_16, adj_14, adj_15, adj_16, adj_17);
    // adj: inv_r = wp.cw_div(wp.vec3(1.0, 1.0, 1.0), r)                                      <L 483>
    wp::adj_vec_t(var_4, var_8, var_12, adj_4, adj_8, adj_12, adj_13);
    wp::adj_max(var_11, var_0, adj_11, adj_0, adj_12);
    wp::adj_abs(var_10, adj_10, adj_11);
    wp::adj_extract(var_radii, var_9, adj_radii, adj_9, adj_10);
    // adj: wp.max(wp.abs(radii[2]), eps),                                                    <L 481>
    wp::adj_max(var_7, var_0, adj_7, adj_0, adj_8);
    wp::adj_abs(var_6, adj_6, adj_7);
    wp::adj_extract(var_radii, var_5, adj_radii, adj_5, adj_6);
    // adj: wp.max(wp.abs(radii[1]), eps),                                                    <L 480>
    wp::adj_max(var_3, var_0, adj_3, adj_0, adj_4);
    wp::adj_abs(var_2, adj_2, adj_3);
    wp::adj_extract(var_radii, var_1, adj_radii, adj_1, adj_2);
    // adj: wp.max(wp.abs(radii[0]), eps),                                                    <L 479>
    // adj: r = wp.vec3(                                                                      <L 478>
    // adj: eps = 1.0e-8                                                                      <L 477>
    // adj: def sdf_ellipsoid(point: wp.vec3, radii: wp.vec3):                                <L 465>
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:495
static CUDA_CALLABLE void adj_sdf_ellipsoid_grad_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::vec_t<3, wp::float32> var_radii,
    wp::vec_t<3, wp::float32> & adj_point,
    wp::vec_t<3, wp::float32> & adj_radii,
    wp::vec_t<3, wp::float32> & adj_ret)
{
    //---------
    // primal vars
    const wp::float32 var_0 = 1e-08;
    const wp::int32 var_1 = 0;
    wp::float32 var_2;
    wp::float32 var_3;
    wp::float32 var_4;
    const wp::int32 var_5 = 1;
    wp::float32 var_6;
    wp::float32 var_7;
    wp::float32 var_8;
    const wp::int32 var_9 = 2;
    wp::float32 var_10;
    wp::float32 var_11;
    wp::float32 var_12;
    wp::vec_t<3, wp::float32> var_13;
    const wp::float32 var_14 = 1.0;
    const wp::float32 var_15 = 1.0;
    const wp::float32 var_16 = 1.0;
    wp::vec_t<3, wp::float32> var_17;
    wp::vec_t<3, wp::float32> var_18;
    wp::vec_t<3, wp::float32> var_19;
    wp::vec_t<3, wp::float32> var_20;
    wp::vec_t<3, wp::float32> var_21;
    wp::float32 var_22;
    wp::float32 var_23;
    bool var_24;
    const wp::float32 var_25 = 0.0;
    const wp::float32 var_26 = 0.0;
    const wp::float32 var_27 = 1.0;
    wp::vec_t<3, wp::float32> var_28;
    wp::float32 var_29;
    wp::vec_t<3, wp::float32> var_30;
    wp::float32 var_31;
    bool var_32;
    wp::vec_t<3, wp::float32> var_33;
    const wp::float32 var_34 = 0.0;
    const wp::float32 var_35 = 0.0;
    const wp::float32 var_36 = 1.0;
    wp::vec_t<3, wp::float32> var_37;
    //---------
    // dual vars
    wp::float32 adj_0 = {};
    wp::int32 adj_1 = {};
    wp::float32 adj_2 = {};
    wp::float32 adj_3 = {};
    wp::float32 adj_4 = {};
    wp::int32 adj_5 = {};
    wp::float32 adj_6 = {};
    wp::float32 adj_7 = {};
    wp::float32 adj_8 = {};
    wp::int32 adj_9 = {};
    wp::float32 adj_10 = {};
    wp::float32 adj_11 = {};
    wp::float32 adj_12 = {};
    wp::vec_t<3, wp::float32> adj_13 = {};
    wp::float32 adj_14 = {};
    wp::float32 adj_15 = {};
    wp::float32 adj_16 = {};
    wp::vec_t<3, wp::float32> adj_17 = {};
    wp::vec_t<3, wp::float32> adj_18 = {};
    wp::vec_t<3, wp::float32> adj_19 = {};
    wp::vec_t<3, wp::float32> adj_20 = {};
    wp::vec_t<3, wp::float32> adj_21 = {};
    wp::float32 adj_22 = {};
    wp::float32 adj_23 = {};
    bool adj_24 = {};
    wp::float32 adj_25 = {};
    wp::float32 adj_26 = {};
    wp::float32 adj_27 = {};
    wp::vec_t<3, wp::float32> adj_28 = {};
    wp::float32 adj_29 = {};
    wp::vec_t<3, wp::float32> adj_30 = {};
    wp::float32 adj_31 = {};
    bool adj_32 = {};
    wp::vec_t<3, wp::float32> adj_33 = {};
    wp::float32 adj_34 = {};
    wp::float32 adj_35 = {};
    wp::float32 adj_36 = {};
    wp::vec_t<3, wp::float32> adj_37 = {};
    //---------
    // forward
    // def sdf_ellipsoid_grad(point: wp.vec3, radii: wp.vec3):                                <L 496>
    // eps = 1.0e-8                                                                           <L 508>
    // r = wp.vec3(                                                                           <L 509>
    // wp.max(wp.abs(radii[0]), eps),                                                         <L 510>
    var_2 = wp::extract(var_radii, var_1);
    var_3 = wp::abs(var_2);
    var_4 = wp::max(var_3, var_0);
    // wp.max(wp.abs(radii[1]), eps),                                                         <L 511>
    var_6 = wp::extract(var_radii, var_5);
    var_7 = wp::abs(var_6);
    var_8 = wp::max(var_7, var_0);
    // wp.max(wp.abs(radii[2]), eps),                                                         <L 512>
    var_10 = wp::extract(var_radii, var_9);
    var_11 = wp::abs(var_10);
    var_12 = wp::max(var_11, var_0);
    var_13 = wp::vec_t<3, wp::float32>(var_4, var_8, var_12);
    // inv_r = wp.cw_div(wp.vec3(1.0, 1.0, 1.0), r)                                           <L 514>
    var_17 = wp::vec_t<3, wp::float32>(var_14, var_15, var_16);
    var_18 = wp::cw_div(var_17, var_13);
    // inv_r2 = wp.cw_mul(inv_r, inv_r)                                                       <L 515>
    var_19 = wp::cw_mul(var_18, var_18);
    // q0 = wp.cw_mul(point, inv_r)  # p / r                                                  <L 516>
    var_20 = wp::cw_mul(var_point, var_18);
    // q1 = wp.cw_mul(point, inv_r2)  # p / r^2                                               <L 517>
    var_21 = wp::cw_mul(var_point, var_19);
    // k0 = wp.length(q0)                                                                     <L 518>
    var_22 = wp::length(var_20);
    // k1 = wp.length(q1)                                                                     <L 519>
    var_23 = wp::length(var_21);
    // if k1 < eps:                                                                           <L 520>
    var_24 = (var_23 < var_0);
    if (var_24) {
        // return wp.vec3(0.0, 0.0, 1.0)                                                      <L 521>
        var_28 = wp::vec_t<3, wp::float32>(var_25, var_26, var_27);
        goto label0;
    }
    // grad = q1 * (k0 / k1)                                                                  <L 523>
    var_29 = wp::div(var_22, var_23);
    var_30 = wp::mul(var_21, var_29);
    // grad_len = wp.length(grad)                                                             <L 524>
    var_31 = wp::length(var_30);
    // if grad_len > eps:                                                                     <L 525>
    var_32 = (var_31 > var_0);
    if (var_32) {
        // return grad / grad_len                                                             <L 526>
        var_33 = wp::div(var_30, var_31);
        goto label1;
    }
    // return wp.vec3(0.0, 0.0, 1.0)                                                          <L 527>
    var_37 = wp::vec_t<3, wp::float32>(var_34, var_35, var_36);
    goto label2;
    //---------
    // reverse
    label2:;
    adj_37 += adj_ret;
    wp::adj_vec_t(var_34, var_35, var_36, adj_34, adj_35, adj_36, adj_37);
    // adj: return wp.vec3(0.0, 0.0, 1.0)                                                     <L 527>
    if (var_32) {
        label1:;
        adj_33 += adj_ret;
        wp::adj_div(var_30, var_31, adj_30, adj_31, adj_33);
        // adj: return grad / grad_len                                                        <L 526>
    }
    // adj: if grad_len > eps:                                                                <L 525>
    wp::adj_length(var_30, var_31, adj_30, adj_31);
    // adj: grad_len = wp.length(grad)                                                        <L 524>
    wp::adj_mul(var_21, var_29, adj_21, adj_29, adj_30);
    wp::adj_div(var_22, var_23, var_29, adj_22, adj_23, adj_29);
    // adj: grad = q1 * (k0 / k1)                                                             <L 523>
    if (var_24) {
        label0:;
        adj_28 += adj_ret;
        wp::adj_vec_t(var_25, var_26, var_27, adj_25, adj_26, adj_27, adj_28);
        // adj: return wp.vec3(0.0, 0.0, 1.0)                                                 <L 521>
    }
    // adj: if k1 < eps:                                                                      <L 520>
    wp::adj_length(var_21, var_23, adj_21, adj_23);
    // adj: k1 = wp.length(q1)                                                                <L 519>
    wp::adj_length(var_20, var_22, adj_20, adj_22);
    // adj: k0 = wp.length(q0)                                                                <L 518>
    wp::adj_cw_mul(var_point, var_19, adj_point, adj_19, adj_21);
    // adj: q1 = wp.cw_mul(point, inv_r2)  # p / r^2                                          <L 517>
    wp::adj_cw_mul(var_point, var_18, adj_point, adj_18, adj_20);
    // adj: q0 = wp.cw_mul(point, inv_r)  # p / r                                             <L 516>
    wp::adj_cw_mul(var_18, var_18, adj_18, adj_18, adj_19);
    // adj: inv_r2 = wp.cw_mul(inv_r, inv_r)                                                  <L 515>
    wp::adj_cw_div(var_17, var_13, var_18, adj_17, adj_13, adj_18);
    wp::adj_vec_t(var_14, var_15, var_16, adj_14, adj_15, adj_16, adj_17);
    // adj: inv_r = wp.cw_div(wp.vec3(1.0, 1.0, 1.0), r)                                      <L 514>
    wp::adj_vec_t(var_4, var_8, var_12, adj_4, adj_8, adj_12, adj_13);
    wp::adj_max(var_11, var_0, adj_11, adj_0, adj_12);
    wp::adj_abs(var_10, adj_10, adj_11);
    wp::adj_extract(var_radii, var_9, adj_radii, adj_9, adj_10);
    // adj: wp.max(wp.abs(radii[2]), eps),                                                    <L 512>
    wp::adj_max(var_7, var_0, adj_7, adj_0, adj_8);
    wp::adj_abs(var_6, adj_6, adj_7);
    wp::adj_extract(var_radii, var_5, adj_radii, adj_5, adj_6);
    // adj: wp.max(wp.abs(radii[1]), eps),                                                    <L 511>
    wp::adj_max(var_3, var_0, adj_3, adj_0, adj_4);
    wp::adj_abs(var_2, adj_2, adj_3);
    wp::adj_extract(var_radii, var_1, adj_radii, adj_1, adj_2);
    // adj: wp.max(wp.abs(radii[0]), eps),                                                    <L 510>
    // adj: r = wp.vec3(                                                                      <L 509>
    // adj: eps = 1.0e-8                                                                      <L 508>
    // adj: def sdf_ellipsoid_grad(point: wp.vec3, radii: wp.vec3):                           <L 496>
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:15
static CUDA_CALLABLE void adj_resolve_mesh_sign_method_0(
    wp::int32 var_mesh_properties,
    wp::int32 & adj_mesh_properties,
    wp::int32 & adj_ret)
{
    //---------
    // primal vars
    const wp::int32 var_0 = 1;
    wp::int32 var_1;
    const wp::int32 var_2 = 1;
    const wp::int32 var_3 = 1;
    wp::int32 var_4;
    const wp::int32 var_5 = 0;
    const wp::int32 var_6 = 0;
    wp::int32 var_7;
    //---------
    // dual vars
    wp::int32 adj_0 = {};
    wp::int32 adj_1 = {};
    wp::int32 adj_2 = {};
    wp::int32 adj_3 = {};
    wp::int32 adj_4 = {};
    wp::int32 adj_5 = {};
    wp::int32 adj_6 = {};
    wp::int32 adj_7 = {};
    //---------
    // forward
    // def resolve_mesh_sign_method(mesh_properties: int):                                    <L 16>
    // if mesh_properties & MeshProperties.WATERTIGHT:                                        <L 26>
    var_1 = wp::bit_and(var_mesh_properties, var_0);
    if (var_1) {
        // return int(MeshSignMethod.PARITY)                                                  <L 27>
        var_4 = wp::int(var_3);
        goto label0;
    }
    // return int(MeshSignMethod.NORMAL)                                                      <L 28>
    var_7 = wp::int(var_6);
    goto label1;
    //---------
    // reverse
    label1:;
    adj_7 += adj_ret;
    // adj: return int(MeshSignMethod.NORMAL)                                                 <L 28>
    if (var_1) {
        label0:;
        adj_4 += adj_ret;
        // adj: return int(MeshSignMethod.PARITY)                                             <L 27>
    }
    // adj: if mesh_properties & MeshProperties.WATERTIGHT:                                   <L 26>
    // adj: def resolve_mesh_sign_method(mesh_properties: int):                               <L 16>
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:884
static CUDA_CALLABLE void adj_mesh_query_point_sign_0(
    wp::uint64 var_mesh,
    wp::vec_t<3, wp::float32> var_point,
    wp::float32 var_max_dist,
    wp::int32 var_sign_method,
    wp::uint64 & adj_mesh,
    wp::vec_t<3, wp::float32> & adj_point,
    wp::float32 & adj_max_dist,
    wp::int32 & adj_sign_method,
    wp::mesh_query_point_t & adj_ret)
{
    //---------
    // primal vars
    const wp::int32 var_0 = 1;
    bool var_1;
    wp::mesh_query_point_t var_2;
    const wp::int32 var_3 = 1;
    const wp::float32 var_4 = 0.1;
    wp::mesh_query_point_t var_5;
    const wp::float32 var_6 = 0.001;
    //---------
    // dual vars
    wp::int32 adj_0 = {};
    bool adj_1 = {};
    wp::mesh_query_point_t adj_2 = {};
    wp::int32 adj_3 = {};
    wp::float32 adj_4 = {};
    wp::mesh_query_point_t adj_5 = {};
    wp::float32 adj_6 = {};
    //---------
    // forward
    // def mesh_query_point_sign(mesh: wp.uint64, point: wp.vec3, max_dist: float, sign_method: int):       <L 885>
    // if sign_method == MeshSignMethod.PARITY:                                               <L 887>
    var_1 = (var_sign_method == var_0);
    if (var_1) {
        // return wp.mesh_query_point_sign_parity(mesh, point, max_dist)                      <L 888>
        var_2 = wp::mesh_query_point_sign_parity(var_mesh, var_point, var_max_dist, var_3, var_4);
        goto label0;
    }
    // return wp.mesh_query_point_sign_normal(mesh, point, max_dist)                          <L 889>
    var_5 = wp::mesh_query_point_sign_normal(var_mesh, var_point, var_max_dist, var_6);
    goto label1;
    //---------
    // reverse
    label1:;
    adj_5 += adj_ret;
    wp::adj_mesh_query_point_sign_normal(var_mesh, var_point, var_max_dist, var_6, var_5, adj_mesh, adj_point, adj_max_dist, adj_6, adj_5);
    // adj: return wp.mesh_query_point_sign_normal(mesh, point, max_dist)                     <L 889>
    if (var_1) {
        label0:;
        adj_2 += adj_ret;
        wp::adj_mesh_query_point_sign_parity(var_mesh, var_point, var_max_dist, var_3, var_4, var_2, adj_mesh, adj_point, adj_max_dist, adj_3, adj_4, adj_2);
        // adj: return wp.mesh_query_point_sign_parity(mesh, point, max_dist)                 <L 888>
    }
    // adj: if sign_method == MeshSignMethod.PARITY:                                          <L 887>
    // adj: def mesh_query_point_sign(mesh: wp.uint64, point: wp.vec3, max_dist: float, sign_method: int):  <L 885>
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:583
static CUDA_CALLABLE void adj_sdf_plane_0(
    wp::vec_t<3, wp::float32> var_point,
    wp::float32 var_width,
    wp::float32 var_length,
    wp::vec_t<3, wp::float32> & adj_point,
    wp::float32 & adj_width,
    wp::float32 & adj_length,
    wp::float32 & adj_ret)
{
    //---------
    // primal vars
    bool var_0;
    const wp::float32 var_1 = 0.0;
    bool var_2;
    const wp::float32 var_3 = 0.0;
    bool var_4;
    const wp::int32 var_5 = 0;
    wp::float32 var_6;
    wp::float32 var_7;
    wp::float32 var_8;
    const wp::int32 var_9 = 1;
    wp::float32 var_10;
    wp::float32 var_11;
    wp::float32 var_12;
    wp::float32 var_13;
    const wp::int32 var_14 = 2;
    wp::float32 var_15;
    wp::float32 var_16;
    wp::float32 var_17;
    const wp::int32 var_18 = 2;
    wp::float32 var_19;
    //---------
    // dual vars
    bool adj_0 = {};
    wp::float32 adj_1 = {};
    bool adj_2 = {};
    wp::float32 adj_3 = {};
    bool adj_4 = {};
    wp::int32 adj_5 = {};
    wp::float32 adj_6 = {};
    wp::float32 adj_7 = {};
    wp::float32 adj_8 = {};
    wp::int32 adj_9 = {};
    wp::float32 adj_10 = {};
    wp::float32 adj_11 = {};
    wp::float32 adj_12 = {};
    wp::float32 adj_13 = {};
    wp::int32 adj_14 = {};
    wp::float32 adj_15 = {};
    wp::float32 adj_16 = {};
    wp::float32 adj_17 = {};
    wp::int32 adj_18 = {};
    wp::float32 adj_19 = {};
    //---------
    // forward
    // def sdf_plane(point: wp.vec3, width: float, length: float):                            <L 584>
    // if width > 0.0 and length > 0.0:                                                       <L 601>
    var_2 = (var_width > var_1);
    var_0 = var_2;
    if (var_0) {
        var_4 = (var_length > var_3);
        var_0 = var_0 && var_4;
    }
    if (var_0) {
        // d = wp.max(wp.abs(point[0]) - width, wp.abs(point[1]) - length)                    <L 602>
        var_6 = wp::extract(var_point, var_5);
        var_7 = wp::abs(var_6);
        var_8 = wp::sub(var_7, var_width);
        var_10 = wp::extract(var_point, var_9);
        var_11 = wp::abs(var_10);
        var_12 = wp::sub(var_11, var_length);
        var_13 = wp::max(var_8, var_12);
        // return wp.max(d, wp.abs(point[2]))                                                 <L 603>
        var_15 = wp::extract(var_point, var_14);
        var_16 = wp::abs(var_15);
        var_17 = wp::max(var_13, var_16);
        goto label0;
    }
    // return point[2]                                                                        <L 604>
    var_19 = wp::extract(var_point, var_18);
    goto label1;
    //---------
    // reverse
    label1:;
    adj_19 += adj_ret;
    wp::adj_extract(var_point, var_18, adj_point, adj_18, adj_19);
    // adj: return point[2]                                                                   <L 604>
    if (var_0) {
        label0:;
        adj_17 += adj_ret;
        wp::adj_max(var_13, var_16, adj_13, adj_16, adj_17);
        wp::adj_abs(var_15, adj_15, adj_16);
        wp::adj_extract(var_point, var_14, adj_point, adj_14, adj_15);
        // adj: return wp.max(d, wp.abs(point[2]))                                            <L 603>
        wp::adj_max(var_8, var_12, adj_8, adj_12, adj_13);
        wp::adj_sub(var_11, var_length, adj_11, adj_length, adj_12);
        wp::adj_abs(var_10, adj_10, adj_11);
        wp::adj_extract(var_point, var_9, adj_point, adj_9, adj_10);
        wp::adj_sub(var_7, var_width, adj_7, adj_width, adj_8);
        wp::adj_abs(var_6, adj_6, adj_7);
        wp::adj_extract(var_point, var_5, adj_point, adj_5, adj_6);
        // adj: d = wp.max(wp.abs(point[0]) - width, wp.abs(point[1]) - length)               <L 602>
    }
    if (var_0) {
    }
    // adj: if width > 0.0 and length > 0.0:                                                  <L 601>
    // adj: def sdf_plane(point: wp.vec3, width: float, length: float):                       <L 584>
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/utils/heightfield.py:171
static CUDA_CALLABLE void adj__heightfield_surface_query_0(
    HeightfieldData_f2b8d59a var_hfd,
    wp::array_t<wp::float32> var_elevation_data,
    wp::vec_t<3, wp::float32> var_pos,
    wp::float32 & ret_0,
    wp::vec_t<3, wp::float32> & ret_1,
    wp::float32 & ret_2,
    HeightfieldData_f2b8d59a & adj_hfd,
    wp::array_t<wp::float32> & adj_elevation_data,
    wp::vec_t<3, wp::float32> & adj_pos,
    wp::float32 & adj_ret_0,
    wp::vec_t<3, wp::float32> & adj_ret_1,
    wp::float32 & adj_ret_2)
{
    //---------
    // primal vars
    bool var_0;
    wp::int32* var_1;
    const wp::int32 var_2 = 1;
    bool var_3;
    wp::int32 var_4;
    wp::int32* var_5;
    const wp::int32 var_6 = 1;
    bool var_7;
    wp::int32 var_8;
    const wp::float32 var_9 = 10000000000.0;
    const wp::float32 var_10 = 0.0;
    const wp::float32 var_11 = 0.0;
    const wp::float32 var_12 = 1.0;
    wp::vec_t<3, wp::float32> var_13;
    const wp::float32 var_14 = 0.0;
    const wp::float32 var_15 = 2.0;
    wp::float32* var_16;
    wp::float32 var_17;
    wp::float32 var_18;
    wp::int32* var_19;
    const wp::int32 var_20 = 1;
    wp::int32 var_21;
    wp::int32 var_22;
    wp::float32 var_23;
    wp::float32 var_24;
    const wp::float32 var_25 = 2.0;
    wp::float32* var_26;
    wp::float32 var_27;
    wp::float32 var_28;
    wp::int32* var_29;
    const wp::int32 var_30 = 1;
    wp::int32 var_31;
    wp::int32 var_32;
    wp::float32 var_33;
    wp::float32 var_34;
    wp::float32* var_35;
    wp::float32* var_36;
    wp::float32 var_37;
    wp::float32 var_38;
    wp::float32 var_39;
    const wp::int32 var_40 = 0;
    wp::float32 var_41;
    wp::float32* var_42;
    wp::float32 var_43;
    wp::float32 var_44;
    wp::float32* var_45;
    wp::float32 var_46;
    wp::float32 var_47;
    const wp::int32 var_48 = 1;
    wp::float32 var_49;
    wp::float32* var_50;
    wp::float32 var_51;
    wp::float32 var_52;
    wp::float32* var_53;
    wp::float32 var_54;
    wp::float32 var_55;
    const wp::int32 var_56 = 0;
    wp::float32 var_57;
    wp::float32 var_58;
    const wp::int32 var_59 = 1;
    wp::float32 var_60;
    wp::float32 var_61;
    wp::float32 var_62;
    wp::float32 var_63;
    wp::float32 var_64;
    wp::float32* var_65;
    wp::float32 var_66;
    wp::float32 var_67;
    wp::float32 var_68;
    wp::float32* var_69;
    wp::float32 var_70;
    wp::float32 var_71;
    wp::float32 var_72;
    const wp::float32 var_73 = 0.0;
    wp::int32* var_74;
    const wp::int32 var_75 = 1;
    wp::int32 var_76;
    wp::int32 var_77;
    wp::float32 var_78;
    wp::float32 var_79;
    const wp::float32 var_80 = 0.0;
    wp::int32* var_81;
    const wp::int32 var_82 = 1;
    wp::int32 var_83;
    wp::int32 var_84;
    wp::float32 var_85;
    wp::float32 var_86;
    wp::int32 var_87;
    wp::int32* var_88;
    const wp::int32 var_89 = 2;
    wp::int32 var_90;
    wp::int32 var_91;
    wp::int32 var_92;
    wp::int32 var_93;
    wp::int32* var_94;
    const wp::int32 var_95 = 2;
    wp::int32 var_96;
    wp::int32 var_97;
    wp::int32 var_98;
    wp::float32 var_99;
    wp::float32 var_100;
    wp::float32 var_101;
    wp::float32 var_102;
    wp::int32* var_103;
    wp::int32 var_104;
    wp::int32 var_105;
    wp::float32* var_106;
    wp::int32* var_107;
    wp::int32 var_108;
    wp::int32 var_109;
    wp::int32 var_110;
    wp::int32 var_111;
    wp::float32* var_112;
    wp::float32 var_113;
    wp::float32 var_114;
    wp::float32 var_115;
    wp::float32 var_116;
    wp::float32* var_117;
    wp::int32* var_118;
    wp::int32 var_119;
    wp::int32 var_120;
    wp::int32 var_121;
    wp::int32 var_122;
    const wp::int32 var_123 = 1;
    wp::int32 var_124;
    wp::float32* var_125;
    wp::float32 var_126;
    wp::float32 var_127;
    wp::float32 var_128;
    wp::float32 var_129;
    wp::float32* var_130;
    const wp::int32 var_131 = 1;
    wp::int32 var_132;
    wp::int32* var_133;
    wp::int32 var_134;
    wp::int32 var_135;
    wp::int32 var_136;
    wp::int32 var_137;
    wp::float32* var_138;
    wp::float32 var_139;
    wp::float32 var_140;
    wp::float32 var_141;
    wp::float32 var_142;
    wp::float32* var_143;
    const wp::int32 var_144 = 1;
    wp::int32 var_145;
    wp::int32* var_146;
    wp::int32 var_147;
    wp::int32 var_148;
    wp::int32 var_149;
    wp::int32 var_150;
    const wp::int32 var_151 = 1;
    wp::int32 var_152;
    wp::float32* var_153;
    wp::float32 var_154;
    wp::float32 var_155;
    wp::float32 var_156;
    wp::float32 var_157;
    wp::float32* var_158;
    wp::float32 var_159;
    wp::float32 var_160;
    wp::float32 var_161;
    wp::float32 var_162;
    wp::float32 var_163;
    wp::float32* var_164;
    wp::float32 var_165;
    wp::float32 var_166;
    wp::float32 var_167;
    wp::float32 var_168;
    wp::float32 var_169;
    bool var_170;
    wp::vec_t<3, wp::float32> var_171;
    const wp::float32 var_172 = 0.0;
    wp::float32 var_173;
    wp::vec_t<3, wp::float32> var_174;
    wp::float32 var_175;
    wp::vec_t<3, wp::float32> var_176;
    wp::vec_t<3, wp::float32> var_177;
    wp::float32 var_178;
    wp::vec_t<3, wp::float32> var_179;
    const wp::float32 var_180 = 0.0;
    wp::float32 var_181;
    wp::vec_t<3, wp::float32> var_182;
    wp::vec_t<3, wp::float32> var_183;
    wp::vec_t<3, wp::float32> var_184;
    wp::vec_t<3, wp::float32> var_185;
    wp::vec_t<3, wp::float32> var_186;
    wp::vec_t<3, wp::float32> var_187;
    wp::vec_t<3, wp::float32> var_188;
    wp::float32 var_189;
    //---------
    // dual vars
    bool adj_0 = {};
    wp::int32 adj_1 = {};
    wp::int32 adj_2 = {};
    bool adj_3 = {};
    wp::int32 adj_4 = {};
    wp::int32 adj_5 = {};
    wp::int32 adj_6 = {};
    bool adj_7 = {};
    wp::int32 adj_8 = {};
    wp::float32 adj_9 = {};
    wp::float32 adj_10 = {};
    wp::float32 adj_11 = {};
    wp::float32 adj_12 = {};
    wp::vec_t<3, wp::float32> adj_13 = {};
    wp::float32 adj_14 = {};
    wp::float32 adj_15 = {};
    wp::float32 adj_16 = {};
    wp::float32 adj_17 = {};
    wp::float32 adj_18 = {};
    wp::int32 adj_19 = {};
    wp::int32 adj_20 = {};
    wp::int32 adj_21 = {};
    wp::int32 adj_22 = {};
    wp::float32 adj_23 = {};
    wp::float32 adj_24 = {};
    wp::float32 adj_25 = {};
    wp::float32 adj_26 = {};
    wp::float32 adj_27 = {};
    wp::float32 adj_28 = {};
    wp::int32 adj_29 = {};
    wp::int32 adj_30 = {};
    wp::int32 adj_31 = {};
    wp::int32 adj_32 = {};
    wp::float32 adj_33 = {};
    wp::float32 adj_34 = {};
    wp::float32 adj_35 = {};
    wp::float32 adj_36 = {};
    wp::float32 adj_37 = {};
    wp::float32 adj_38 = {};
    wp::float32 adj_39 = {};
    wp::int32 adj_40 = {};
    wp::float32 adj_41 = {};
    wp::float32 adj_42 = {};
    wp::float32 adj_43 = {};
    wp::float32 adj_44 = {};
    wp::float32 adj_45 = {};
    wp::float32 adj_46 = {};
    wp::float32 adj_47 = {};
    wp::int32 adj_48 = {};
    wp::float32 adj_49 = {};
    wp::float32 adj_50 = {};
    wp::float32 adj_51 = {};
    wp::float32 adj_52 = {};
    wp::float32 adj_53 = {};
    wp::float32 adj_54 = {};
    wp::float32 adj_55 = {};
    wp::int32 adj_56 = {};
    wp::float32 adj_57 = {};
    wp::float32 adj_58 = {};
    wp::int32 adj_59 = {};
    wp::float32 adj_60 = {};
    wp::float32 adj_61 = {};
    wp::float32 adj_62 = {};
    wp::float32 adj_63 = {};
    wp::float32 adj_64 = {};
    wp::float32 adj_65 = {};
    wp::float32 adj_66 = {};
    wp::float32 adj_67 = {};
    wp::float32 adj_68 = {};
    wp::float32 adj_69 = {};
    wp::float32 adj_70 = {};
    wp::float32 adj_71 = {};
    wp::float32 adj_72 = {};
    wp::float32 adj_73 = {};
    wp::int32 adj_74 = {};
    wp::int32 adj_75 = {};
    wp::int32 adj_76 = {};
    wp::int32 adj_77 = {};
    wp::float32 adj_78 = {};
    wp::float32 adj_79 = {};
    wp::float32 adj_80 = {};
    wp::int32 adj_81 = {};
    wp::int32 adj_82 = {};
    wp::int32 adj_83 = {};
    wp::int32 adj_84 = {};
    wp::float32 adj_85 = {};
    wp::float32 adj_86 = {};
    wp::int32 adj_87 = {};
    wp::int32 adj_88 = {};
    wp::int32 adj_89 = {};
    wp::int32 adj_90 = {};
    wp::int32 adj_91 = {};
    wp::int32 adj_92 = {};
    wp::int32 adj_93 = {};
    wp::int32 adj_94 = {};
    wp::int32 adj_95 = {};
    wp::int32 adj_96 = {};
    wp::int32 adj_97 = {};
    wp::int32 adj_98 = {};
    wp::float32 adj_99 = {};
    wp::float32 adj_100 = {};
    wp::float32 adj_101 = {};
    wp::float32 adj_102 = {};
    wp::int32 adj_103 = {};
    wp::int32 adj_104 = {};
    wp::int32 adj_105 = {};
    wp::float32 adj_106 = {};
    wp::int32 adj_107 = {};
    wp::int32 adj_108 = {};
    wp::int32 adj_109 = {};
    wp::int32 adj_110 = {};
    wp::int32 adj_111 = {};
    wp::float32 adj_112 = {};
    wp::float32 adj_113 = {};
    wp::float32 adj_114 = {};
    wp::float32 adj_115 = {};
    wp::float32 adj_116 = {};
    wp::float32 adj_117 = {};
    wp::int32 adj_118 = {};
    wp::int32 adj_119 = {};
    wp::int32 adj_120 = {};
    wp::int32 adj_121 = {};
    wp::int32 adj_122 = {};
    wp::int32 adj_123 = {};
    wp::int32 adj_124 = {};
    wp::float32 adj_125 = {};
    wp::float32 adj_126 = {};
    wp::float32 adj_127 = {};
    wp::float32 adj_128 = {};
    wp::float32 adj_129 = {};
    wp::float32 adj_130 = {};
    wp::int32 adj_131 = {};
    wp::int32 adj_132 = {};
    wp::int32 adj_133 = {};
    wp::int32 adj_134 = {};
    wp::int32 adj_135 = {};
    wp::int32 adj_136 = {};
    wp::int32 adj_137 = {};
    wp::float32 adj_138 = {};
    wp::float32 adj_139 = {};
    wp::float32 adj_140 = {};
    wp::float32 adj_141 = {};
    wp::float32 adj_142 = {};
    wp::float32 adj_143 = {};
    wp::int32 adj_144 = {};
    wp::int32 adj_145 = {};
    wp::int32 adj_146 = {};
    wp::int32 adj_147 = {};
    wp::int32 adj_148 = {};
    wp::int32 adj_149 = {};
    wp::int32 adj_150 = {};
    wp::int32 adj_151 = {};
    wp::int32 adj_152 = {};
    wp::float32 adj_153 = {};
    wp::float32 adj_154 = {};
    wp::float32 adj_155 = {};
    wp::float32 adj_156 = {};
    wp::float32 adj_157 = {};
    wp::float32 adj_158 = {};
    wp::float32 adj_159 = {};
    wp::float32 adj_160 = {};
    wp::float32 adj_161 = {};
    wp::float32 adj_162 = {};
    wp::float32 adj_163 = {};
    wp::float32 adj_164 = {};
    wp::float32 adj_165 = {};
    wp::float32 adj_166 = {};
    wp::float32 adj_167 = {};
    wp::float32 adj_168 = {};
    wp::float32 adj_169 = {};
    bool adj_170 = {};
    wp::vec_t<3, wp::float32> adj_171 = {};
    wp::float32 adj_172 = {};
    wp::float32 adj_173 = {};
    wp::vec_t<3, wp::float32> adj_174 = {};
    wp::float32 adj_175 = {};
    wp::vec_t<3, wp::float32> adj_176 = {};
    wp::vec_t<3, wp::float32> adj_177 = {};
    wp::float32 adj_178 = {};
    wp::vec_t<3, wp::float32> adj_179 = {};
    wp::float32 adj_180 = {};
    wp::float32 adj_181 = {};
    wp::vec_t<3, wp::float32> adj_182 = {};
    wp::vec_t<3, wp::float32> adj_183 = {};
    wp::vec_t<3, wp::float32> adj_184 = {};
    wp::vec_t<3, wp::float32> adj_185 = {};
    wp::vec_t<3, wp::float32> adj_186 = {};
    wp::vec_t<3, wp::float32> adj_187 = {};
    wp::vec_t<3, wp::float32> adj_188 = {};
    wp::float32 adj_189 = {};
    //---------
    // forward
    // def _heightfield_surface_query(                                                        <L 172>
    // if hfd.nrow <= 1 or hfd.ncol <= 1:                                                     <L 183>
    var_1 = &((var_hfd).nrow);
    var_4 = wp::load(var_1);
    var_3 = (var_4 <= var_2);
    var_0 = var_3;
    if (!var_0) {
        var_5 = &((var_hfd).ncol);
        var_8 = wp::load(var_5);
        var_7 = (var_8 <= var_6);
        var_0 = var_0 || var_7;
    }
    if (var_0) {
        // return 1.0e10, wp.vec3(0.0, 0.0, 1.0), 0.0                                         <L 184>
        var_13 = wp::vec_t<3, wp::float32>(var_10, var_11, var_12);
        ret_0 = var_9;
        ret_1 = var_13;
        ret_2 = var_14;
        goto label0;
    }
    // dx = 2.0 * hfd.hx / wp.float32(hfd.ncol - 1)                                           <L 186>
    var_16 = &((var_hfd).hx);
    var_18 = wp::load(var_16);
    var_17 = wp::mul(var_15, var_18);
    var_19 = &((var_hfd).ncol);
    var_22 = wp::load(var_19);
    var_21 = wp::sub(var_22, var_20);
    var_23 = wp::float32(var_21);
    var_24 = wp::div(var_17, var_23);
    // dy = 2.0 * hfd.hy / wp.float32(hfd.nrow - 1)                                           <L 187>
    var_26 = &((var_hfd).hy);
    var_28 = wp::load(var_26);
    var_27 = wp::mul(var_25, var_28);
    var_29 = &((var_hfd).nrow);
    var_32 = wp::load(var_29);
    var_31 = wp::sub(var_32, var_30);
    var_33 = wp::float32(var_31);
    var_34 = wp::div(var_27, var_33);
    // z_range = hfd.max_z - hfd.min_z                                                        <L 188>
    var_35 = &((var_hfd).max_z);
    var_36 = &((var_hfd).min_z);
    var_38 = wp::load(var_35);
    var_39 = wp::load(var_36);
    var_37 = wp::sub(var_38, var_39);
    // cx = wp.clamp(pos[0], -hfd.hx, hfd.hx)                                                 <L 191>
    var_41 = wp::extract(var_pos, var_40);
    var_42 = &((var_hfd).hx);
    var_44 = wp::load(var_42);
    var_43 = wp::neg(var_44);
    var_45 = &((var_hfd).hx);
    var_47 = wp::load(var_45);
    var_46 = wp::clamp(var_41, var_43, var_47);
    // cy = wp.clamp(pos[1], -hfd.hy, hfd.hy)                                                 <L 192>
    var_49 = wp::extract(var_pos, var_48);
    var_50 = &((var_hfd).hy);
    var_52 = wp::load(var_50);
    var_51 = wp::neg(var_52);
    var_53 = &((var_hfd).hy);
    var_55 = wp::load(var_53);
    var_54 = wp::clamp(var_49, var_51, var_55);
    // out_x = pos[0] - cx                                                                    <L 193>
    var_57 = wp::extract(var_pos, var_56);
    var_58 = wp::sub(var_57, var_46);
    // out_y = pos[1] - cy                                                                    <L 194>
    var_60 = wp::extract(var_pos, var_59);
    var_61 = wp::sub(var_60, var_54);
    // lateral_dist_sq = out_x * out_x + out_y * out_y                                        <L 195>
    var_62 = wp::mul(var_58, var_58);
    var_63 = wp::mul(var_61, var_61);
    var_64 = wp::add(var_62, var_63);
    // col_f = (cx + hfd.hx) / dx                                                             <L 197>
    var_65 = &((var_hfd).hx);
    var_67 = wp::load(var_65);
    var_66 = wp::add(var_46, var_67);
    var_68 = wp::div(var_66, var_24);
    // row_f = (cy + hfd.hy) / dy                                                             <L 198>
    var_69 = &((var_hfd).hy);
    var_71 = wp::load(var_69);
    var_70 = wp::add(var_54, var_71);
    var_72 = wp::div(var_70, var_34);
    // col_f = wp.clamp(col_f, 0.0, wp.float32(hfd.ncol - 1))                                 <L 199>
    var_74 = &((var_hfd).ncol);
    var_77 = wp::load(var_74);
    var_76 = wp::sub(var_77, var_75);
    var_78 = wp::float32(var_76);
    var_79 = wp::clamp(var_68, var_73, var_78);
    // row_f = wp.clamp(row_f, 0.0, wp.float32(hfd.nrow - 1))                                 <L 200>
    var_81 = &((var_hfd).nrow);
    var_84 = wp::load(var_81);
    var_83 = wp::sub(var_84, var_82);
    var_85 = wp::float32(var_83);
    var_86 = wp::clamp(var_72, var_80, var_85);
    // col = wp.min(wp.int32(col_f), hfd.ncol - 2)                                            <L 202>
    var_87 = wp::int32(var_79);
    var_88 = &((var_hfd).ncol);
    var_91 = wp::load(var_88);
    var_90 = wp::sub(var_91, var_89);
    var_92 = wp::min(var_87, var_90);
    // row = wp.min(wp.int32(row_f), hfd.nrow - 2)                                            <L 203>
    var_93 = wp::int32(var_86);
    var_94 = &((var_hfd).nrow);
    var_97 = wp::load(var_94);
    var_96 = wp::sub(var_97, var_95);
    var_98 = wp::min(var_93, var_96);
    // fx = col_f - wp.float32(col)                                                           <L 204>
    var_99 = wp::float32(var_92);
    var_100 = wp::sub(var_79, var_99);
    // fy = row_f - wp.float32(row)                                                           <L 205>
    var_101 = wp::float32(var_98);
    var_102 = wp::sub(var_86, var_101);
    // base = hfd.data_offset                                                                 <L 207>
    var_103 = &((var_hfd).data_offset);
    var_105 = wp::load(var_103);
    var_104 = wp::copy(var_105);
    // h00 = hfd.min_z + elevation_data[base + row * hfd.ncol + col] * z_range                <L 208>
    var_106 = &((var_hfd).min_z);
    var_107 = &((var_hfd).ncol);
    var_109 = wp::load(var_107);
    var_108 = wp::mul(var_98, var_109);
    var_110 = wp::add(var_104, var_108);
    var_111 = wp::add(var_110, var_92);
    var_112 = wp::address(var_elevation_data, var_111);
    var_114 = wp::load(var_112);
    var_113 = wp::mul(var_114, var_37);
    var_116 = wp::load(var_106);
    var_115 = wp::add(var_116, var_113);
    // h10 = hfd.min_z + elevation_data[base + row * hfd.ncol + col + 1] * z_range            <L 209>
    var_117 = &((var_hfd).min_z);
    var_118 = &((var_hfd).ncol);
    var_120 = wp::load(var_118);
    var_119 = wp::mul(var_98, var_120);
    var_121 = wp::add(var_104, var_119);
    var_122 = wp::add(var_121, var_92);
    var_124 = wp::add(var_122, var_123);
    var_125 = wp::address(var_elevation_data, var_124);
    var_127 = wp::load(var_125);
    var_126 = wp::mul(var_127, var_37);
    var_129 = wp::load(var_117);
    var_128 = wp::add(var_129, var_126);
    // h01 = hfd.min_z + elevation_data[base + (row + 1) * hfd.ncol + col] * z_range          <L 210>
    var_130 = &((var_hfd).min_z);
    var_132 = wp::add(var_98, var_131);
    var_133 = &((var_hfd).ncol);
    var_135 = wp::load(var_133);
    var_134 = wp::mul(var_132, var_135);
    var_136 = wp::add(var_104, var_134);
    var_137 = wp::add(var_136, var_92);
    var_138 = wp::address(var_elevation_data, var_137);
    var_140 = wp::load(var_138);
    var_139 = wp::mul(var_140, var_37);
    var_142 = wp::load(var_130);
    var_141 = wp::add(var_142, var_139);
    // h11 = hfd.min_z + elevation_data[base + (row + 1) * hfd.ncol + col + 1] * z_range       <L 211>
    var_143 = &((var_hfd).min_z);
    var_145 = wp::add(var_98, var_144);
    var_146 = &((var_hfd).ncol);
    var_148 = wp::load(var_146);
    var_147 = wp::mul(var_145, var_148);
    var_149 = wp::add(var_104, var_147);
    var_150 = wp::add(var_149, var_92);
    var_152 = wp::add(var_150, var_151);
    var_153 = wp::address(var_elevation_data, var_152);
    var_155 = wp::load(var_153);
    var_154 = wp::mul(var_155, var_37);
    var_157 = wp::load(var_143);
    var_156 = wp::add(var_157, var_154);
    // x0 = -hfd.hx + wp.float32(col) * dx                                                    <L 213>
    var_158 = &((var_hfd).hx);
    var_160 = wp::load(var_158);
    var_159 = wp::neg(var_160);
    var_161 = wp::float32(var_92);
    var_162 = wp::mul(var_161, var_24);
    var_163 = wp::add(var_159, var_162);
    // y0 = -hfd.hy + wp.float32(row) * dy                                                    <L 214>
    var_164 = &((var_hfd).hy);
    var_166 = wp::load(var_164);
    var_165 = wp::neg(var_166);
    var_167 = wp::float32(var_98);
    var_168 = wp::mul(var_167, var_34);
    var_169 = wp::add(var_165, var_168);
    // if fx >= fy:                                                                           <L 216>
    var_170 = (var_100 >= var_102);
    if (var_170) {
        // v0 = wp.vec3(x0, y0, h00)                                                          <L 217>
        var_171 = wp::vec_t<3, wp::float32>(var_163, var_169, var_115);
        // e1 = wp.vec3(dx, 0.0, h10 - h00)                                                   <L 218>
        var_173 = wp::sub(var_128, var_115);
        var_174 = wp::vec_t<3, wp::float32>(var_24, var_172, var_173);
        // e2 = wp.vec3(dx, dy, h11 - h00)                                                    <L 219>
        var_175 = wp::sub(var_156, var_115);
        var_176 = wp::vec_t<3, wp::float32>(var_24, var_34, var_175);
    }
    if (!var_170) {
        // v0 = wp.vec3(x0, y0, h00)                                                          <L 221>
        var_177 = wp::vec_t<3, wp::float32>(var_163, var_169, var_115);
        // e1 = wp.vec3(dx, dy, h11 - h00)                                                    <L 222>
        var_178 = wp::sub(var_156, var_115);
        var_179 = wp::vec_t<3, wp::float32>(var_24, var_34, var_178);
        // e2 = wp.vec3(0.0, dy, h01 - h00)                                                   <L 223>
        var_181 = wp::sub(var_141, var_115);
        var_182 = wp::vec_t<3, wp::float32>(var_180, var_34, var_181);
    }
    var_183 = wp::where(var_170, var_171, var_177);
    var_184 = wp::where(var_170, var_174, var_179);
    var_185 = wp::where(var_170, var_176, var_182);
    // normal = wp.normalize(wp.cross(e1, e2))                                                <L 225>
    var_186 = wp::cross(var_184, var_185);
    var_187 = wp::normalize(var_186);
    // d_plane = wp.dot(pos - v0, normal)                                                     <L 226>
    var_188 = wp::sub(var_pos, var_183);
    var_189 = wp::dot(var_188, var_187);
    // return d_plane, normal, lateral_dist_sq                                                <L 227>
    ret_0 = var_189;
    ret_1 = var_187;
    ret_2 = var_64;
    goto label1;
    //---------
    // reverse
    label1:;
    adj_64 += adj_ret_2;
    adj_187 += adj_ret_1;
    adj_189 += adj_ret_0;
    // adj: return d_plane, normal, lateral_dist_sq                                           <L 227>
    wp::adj_dot(var_188, var_187, adj_188, adj_187, adj_189);
    wp::adj_sub(var_pos, var_183, adj_pos, adj_183, adj_188);
    // adj: d_plane = wp.dot(pos - v0, normal)                                                <L 226>
    wp::adj_normalize(var_186, var_187, adj_186, adj_187);
    wp::adj_cross(var_184, var_185, adj_184, adj_185, adj_186);
    // adj: normal = wp.normalize(wp.cross(e1, e2))                                           <L 225>
    wp::adj_where(var_170, var_176, var_182, adj_170, adj_176, adj_182, adj_185);
    wp::adj_where(var_170, var_174, var_179, adj_170, adj_174, adj_179, adj_184);
    wp::adj_where(var_170, var_171, var_177, adj_170, adj_171, adj_177, adj_183);
    if (!var_170) {
        wp::adj_vec_t(var_180, var_34, var_181, adj_180, adj_34, adj_181, adj_182);
        wp::adj_sub(var_141, var_115, adj_141, adj_115, adj_181);
        // adj: e2 = wp.vec3(0.0, dy, h01 - h00)                                              <L 223>
        wp::adj_vec_t(var_24, var_34, var_178, adj_24, adj_34, adj_178, adj_179);
        wp::adj_sub(var_156, var_115, adj_156, adj_115, adj_178);
        // adj: e1 = wp.vec3(dx, dy, h11 - h00)                                               <L 222>
        wp::adj_vec_t(var_163, var_169, var_115, adj_163, adj_169, adj_115, adj_177);
        // adj: v0 = wp.vec3(x0, y0, h00)                                                     <L 221>
    }
    if (var_170) {
        wp::adj_vec_t(var_24, var_34, var_175, adj_24, adj_34, adj_175, adj_176);
        wp::adj_sub(var_156, var_115, adj_156, adj_115, adj_175);
        // adj: e2 = wp.vec3(dx, dy, h11 - h00)                                               <L 219>
        wp::adj_vec_t(var_24, var_172, var_173, adj_24, adj_172, adj_173, adj_174);
        wp::adj_sub(var_128, var_115, adj_128, adj_115, adj_173);
        // adj: e1 = wp.vec3(dx, 0.0, h10 - h00)                                              <L 218>
        wp::adj_vec_t(var_163, var_169, var_115, adj_163, adj_169, adj_115, adj_171);
        // adj: v0 = wp.vec3(x0, y0, h00)                                                     <L 217>
    }
    // adj: if fx >= fy:                                                                      <L 216>
    wp::adj_add(var_165, var_168, adj_165, adj_168, adj_169);
    wp::adj_mul(var_167, var_34, adj_167, adj_34, adj_168);
    wp::adj_float32(var_98, adj_98, adj_167);
    wp::adj_neg(var_166, adj_164, adj_165);
    adj_hfd.hy += adj_164;
    // adj: y0 = -hfd.hy + wp.float32(row) * dy                                               <L 214>
    wp::adj_add(var_159, var_162, adj_159, adj_162, adj_163);
    wp::adj_mul(var_161, var_24, adj_161, adj_24, adj_162);
    wp::adj_float32(var_92, adj_92, adj_161);
    wp::adj_neg(var_160, adj_158, adj_159);
    adj_hfd.hx += adj_158;
    // adj: x0 = -hfd.hx + wp.float32(col) * dx                                               <L 213>
    wp::adj_add(var_157, var_154, adj_143, adj_154, adj_156);
    wp::adj_mul(var_155, var_37, adj_153, adj_37, adj_154);
    wp::adj_address(var_elevation_data, var_152, adj_elevation_data, adj_152, adj_153);
    wp::adj_add(var_150, var_151, adj_150, adj_151, adj_152);
    wp::adj_add(var_149, var_92, adj_149, adj_92, adj_150);
    wp::adj_add(var_104, var_147, adj_104, adj_147, adj_149);
    wp::adj_mul(var_145, var_148, adj_145, adj_146, adj_147);
    adj_hfd.ncol = adj_146;
    wp::adj_add(var_98, var_144, adj_98, adj_144, adj_145);
    adj_hfd.min_z += adj_143;
    // adj: h11 = hfd.min_z + elevation_data[base + (row + 1) * hfd.ncol + col + 1] * z_range  <L 211>
    wp::adj_add(var_142, var_139, adj_130, adj_139, adj_141);
    wp::adj_mul(var_140, var_37, adj_138, adj_37, adj_139);
    wp::adj_address(var_elevation_data, var_137, adj_elevation_data, adj_137, adj_138);
    wp::adj_add(var_136, var_92, adj_136, adj_92, adj_137);
    wp::adj_add(var_104, var_134, adj_104, adj_134, adj_136);
    wp::adj_mul(var_132, var_135, adj_132, adj_133, adj_134);
    adj_hfd.ncol = adj_133;
    wp::adj_add(var_98, var_131, adj_98, adj_131, adj_132);
    adj_hfd.min_z += adj_130;
    // adj: h01 = hfd.min_z + elevation_data[base + (row + 1) * hfd.ncol + col] * z_range     <L 210>
    wp::adj_add(var_129, var_126, adj_117, adj_126, adj_128);
    wp::adj_mul(var_127, var_37, adj_125, adj_37, adj_126);
    wp::adj_address(var_elevation_data, var_124, adj_elevation_data, adj_124, adj_125);
    wp::adj_add(var_122, var_123, adj_122, adj_123, adj_124);
    wp::adj_add(var_121, var_92, adj_121, adj_92, adj_122);
    wp::adj_add(var_104, var_119, adj_104, adj_119, adj_121);
    wp::adj_mul(var_98, var_120, adj_98, adj_118, adj_119);
    adj_hfd.ncol = adj_118;
    adj_hfd.min_z += adj_117;
    // adj: h10 = hfd.min_z + elevation_data[base + row * hfd.ncol + col + 1] * z_range       <L 209>
    wp::adj_add(var_116, var_113, adj_106, adj_113, adj_115);
    wp::adj_mul(var_114, var_37, adj_112, adj_37, adj_113);
    wp::adj_address(var_elevation_data, var_111, adj_elevation_data, adj_111, adj_112);
    wp::adj_add(var_110, var_92, adj_110, adj_92, adj_111);
    wp::adj_add(var_104, var_108, adj_104, adj_108, adj_110);
    wp::adj_mul(var_98, var_109, adj_98, adj_107, adj_108);
    adj_hfd.ncol = adj_107;
    adj_hfd.min_z += adj_106;
    // adj: h00 = hfd.min_z + elevation_data[base + row * hfd.ncol + col] * z_range           <L 208>
    wp::adj_copy(var_105, adj_103, adj_104);
    adj_hfd.data_offset = adj_103;
    // adj: base = hfd.data_offset                                                            <L 207>
    wp::adj_sub(var_86, var_101, adj_86, adj_101, adj_102);
    wp::adj_float32(var_98, adj_98, adj_101);
    // adj: fy = row_f - wp.float32(row)                                                      <L 205>
    wp::adj_sub(var_79, var_99, adj_79, adj_99, adj_100);
    wp::adj_float32(var_92, adj_92, adj_99);
    // adj: fx = col_f - wp.float32(col)                                                      <L 204>
    wp::adj_min(var_93, var_96, adj_93, adj_96, adj_98);
    wp::adj_sub(var_97, var_95, adj_94, adj_95, adj_96);
    adj_hfd.nrow = adj_94;
    // adj: row = wp.min(wp.int32(row_f), hfd.nrow - 2)                                       <L 203>
    wp::adj_min(var_87, var_90, adj_87, adj_90, adj_92);
    wp::adj_sub(var_91, var_89, adj_88, adj_89, adj_90);
    adj_hfd.ncol = adj_88;
    // adj: col = wp.min(wp.int32(col_f), hfd.ncol - 2)                                       <L 202>
    wp::adj_clamp(var_72, var_80, var_85, adj_72, adj_80, adj_85, adj_86);
    wp::adj_float32(var_83, adj_83, adj_85);
    wp::adj_sub(var_84, var_82, adj_81, adj_82, adj_83);
    adj_hfd.nrow = adj_81;
    // adj: row_f = wp.clamp(row_f, 0.0, wp.float32(hfd.nrow - 1))                            <L 200>
    wp::adj_clamp(var_68, var_73, var_78, adj_68, adj_73, adj_78, adj_79);
    wp::adj_float32(var_76, adj_76, adj_78);
    wp::adj_sub(var_77, var_75, adj_74, adj_75, adj_76);
    adj_hfd.ncol = adj_74;
    // adj: col_f = wp.clamp(col_f, 0.0, wp.float32(hfd.ncol - 1))                            <L 199>
    wp::adj_div(var_70, var_34, var_72, adj_70, adj_34, adj_72);
    wp::adj_add(var_54, var_71, adj_54, adj_69, adj_70);
    adj_hfd.hy += adj_69;
    // adj: row_f = (cy + hfd.hy) / dy                                                        <L 198>
    wp::adj_div(var_66, var_24, var_68, adj_66, adj_24, adj_68);
    wp::adj_add(var_46, var_67, adj_46, adj_65, adj_66);
    adj_hfd.hx += adj_65;
    // adj: col_f = (cx + hfd.hx) / dx                                                        <L 197>
    wp::adj_add(var_62, var_63, adj_62, adj_63, adj_64);
    wp::adj_mul(var_61, var_61, adj_61, adj_61, adj_63);
    wp::adj_mul(var_58, var_58, adj_58, adj_58, adj_62);
    // adj: lateral_dist_sq = out_x * out_x + out_y * out_y                                   <L 195>
    wp::adj_sub(var_60, var_54, adj_60, adj_54, adj_61);
    wp::adj_extract(var_pos, var_59, adj_pos, adj_59, adj_60);
    // adj: out_y = pos[1] - cy                                                               <L 194>
    wp::adj_sub(var_57, var_46, adj_57, adj_46, adj_58);
    wp::adj_extract(var_pos, var_56, adj_pos, adj_56, adj_57);
    // adj: out_x = pos[0] - cx                                                               <L 193>
    wp::adj_clamp(var_49, var_51, var_55, adj_49, adj_51, adj_53, adj_54);
    adj_hfd.hy += adj_53;
    wp::adj_neg(var_52, adj_50, adj_51);
    adj_hfd.hy += adj_50;
    wp::adj_extract(var_pos, var_48, adj_pos, adj_48, adj_49);
    // adj: cy = wp.clamp(pos[1], -hfd.hy, hfd.hy)                                            <L 192>
    wp::adj_clamp(var_41, var_43, var_47, adj_41, adj_43, adj_45, adj_46);
    adj_hfd.hx += adj_45;
    wp::adj_neg(var_44, adj_42, adj_43);
    adj_hfd.hx += adj_42;
    wp::adj_extract(var_pos, var_40, adj_pos, adj_40, adj_41);
    // adj: cx = wp.clamp(pos[0], -hfd.hx, hfd.hx)                                            <L 191>
    wp::adj_sub(var_38, var_39, adj_35, adj_36, adj_37);
    adj_hfd.min_z += adj_36;
    adj_hfd.max_z += adj_35;
    // adj: z_range = hfd.max_z - hfd.min_z                                                   <L 188>
    wp::adj_div(var_27, var_33, var_34, adj_27, adj_33, adj_34);
    wp::adj_float32(var_31, adj_31, adj_33);
    wp::adj_sub(var_32, var_30, adj_29, adj_30, adj_31);
    adj_hfd.nrow = adj_29;
    wp::adj_mul(var_25, var_28, adj_25, adj_26, adj_27);
    adj_hfd.hy += adj_26;
    // adj: dy = 2.0 * hfd.hy / wp.float32(hfd.nrow - 1)                                      <L 187>
    wp::adj_div(var_17, var_23, var_24, adj_17, adj_23, adj_24);
    wp::adj_float32(var_21, adj_21, adj_23);
    wp::adj_sub(var_22, var_20, adj_19, adj_20, adj_21);
    adj_hfd.ncol = adj_19;
    wp::adj_mul(var_15, var_18, adj_15, adj_16, adj_17);
    adj_hfd.hx += adj_16;
    // adj: dx = 2.0 * hfd.hx / wp.float32(hfd.ncol - 1)                                      <L 186>
    if (var_0) {
        label0:;
        adj_14 += adj_ret_2;
        adj_13 += adj_ret_1;
        adj_9 += adj_ret_0;
        wp::adj_vec_t(var_10, var_11, var_12, adj_10, adj_11, adj_12, adj_13);
        // adj: return 1.0e10, wp.vec3(0.0, 0.0, 1.0), 0.0                                    <L 184>
    }
    if (!var_0) {
        adj_hfd.ncol = adj_5;
    }
    adj_hfd.nrow = adj_1;
    // adj: if hfd.nrow <= 1 or hfd.ncol <= 1:                                                <L 183>
    // adj: def _heightfield_surface_query(                                                   <L 172>
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/utils/heightfield.py:254
static CUDA_CALLABLE void adj_sample_sdf_grad_heightfield_0(
    HeightfieldData_f2b8d59a var_hfd,
    wp::array_t<wp::float32> var_elevation_data,
    wp::vec_t<3, wp::float32> var_pos,
    wp::float32 & ret_0,
    wp::vec_t<3, wp::float32> & ret_1,
    HeightfieldData_f2b8d59a & adj_hfd,
    wp::array_t<wp::float32> & adj_elevation_data,
    wp::vec_t<3, wp::float32> & adj_pos,
    wp::float32 & adj_ret_0,
    wp::vec_t<3, wp::float32> & adj_ret_1)
{
    //---------
    // primal vars
    wp::float32 var_0;
    wp::vec_t<3, wp::float32> var_1;
    wp::float32 var_2;
    const wp::float32 var_3 = 0.0;
    bool var_4;
    wp::float32 var_5;
    wp::float32 var_6;
    wp::float32 var_7;
    const wp::int32 var_8 = 0;
    wp::float32 var_9;
    wp::float32* var_10;
    wp::float32 var_11;
    wp::float32 var_12;
    wp::float32* var_13;
    wp::float32 var_14;
    wp::float32 var_15;
    const wp::int32 var_16 = 1;
    wp::float32 var_17;
    wp::float32* var_18;
    wp::float32 var_19;
    wp::float32 var_20;
    wp::float32* var_21;
    wp::float32 var_22;
    wp::float32 var_23;
    const wp::int32 var_24 = 0;
    wp::float32 var_25;
    wp::float32 var_26;
    const wp::int32 var_27 = 1;
    wp::float32 var_28;
    wp::float32 var_29;
    const wp::float32 var_30 = 0.0;
    wp::vec_t<3, wp::float32> var_31;
    wp::vec_t<3, wp::float32> var_32;
    wp::vec_t<3, wp::float32> var_33;
    wp::float32 var_34;
    const wp::float32 var_35 = 1e-20;
    bool var_36;
    wp::vec_t<3, wp::float32> var_37;
    const wp::float32 var_38 = 0.0;
    const wp::float32 var_39 = 0.0;
    const wp::float32 var_40 = 1.0;
    wp::vec_t<3, wp::float32> var_41;
    wp::vec_t<3, wp::float32> var_42;
    //---------
    // dual vars
    wp::float32 adj_0 = {};
    wp::vec_t<3, wp::float32> adj_1 = {};
    wp::float32 adj_2 = {};
    wp::float32 adj_3 = {};
    bool adj_4 = {};
    wp::float32 adj_5 = {};
    wp::float32 adj_6 = {};
    wp::float32 adj_7 = {};
    wp::int32 adj_8 = {};
    wp::float32 adj_9 = {};
    wp::float32 adj_10 = {};
    wp::float32 adj_11 = {};
    wp::float32 adj_12 = {};
    wp::float32 adj_13 = {};
    wp::float32 adj_14 = {};
    wp::float32 adj_15 = {};
    wp::int32 adj_16 = {};
    wp::float32 adj_17 = {};
    wp::float32 adj_18 = {};
    wp::float32 adj_19 = {};
    wp::float32 adj_20 = {};
    wp::float32 adj_21 = {};
    wp::float32 adj_22 = {};
    wp::float32 adj_23 = {};
    wp::int32 adj_24 = {};
    wp::float32 adj_25 = {};
    wp::float32 adj_26 = {};
    wp::int32 adj_27 = {};
    wp::float32 adj_28 = {};
    wp::float32 adj_29 = {};
    wp::float32 adj_30 = {};
    wp::vec_t<3, wp::float32> adj_31 = {};
    wp::vec_t<3, wp::float32> adj_32 = {};
    wp::vec_t<3, wp::float32> adj_33 = {};
    wp::float32 adj_34 = {};
    wp::float32 adj_35 = {};
    bool adj_36 = {};
    wp::vec_t<3, wp::float32> adj_37 = {};
    wp::float32 adj_38 = {};
    wp::float32 adj_39 = {};
    wp::float32 adj_40 = {};
    wp::vec_t<3, wp::float32> adj_41 = {};
    wp::vec_t<3, wp::float32> adj_42 = {};
    //---------
    // forward
    // def sample_sdf_grad_heightfield(                                                       <L 255>
    // d_plane, normal, lateral_dist_sq = _heightfield_surface_query(hfd, elevation_data, pos)       <L 265>
    _heightfield_surface_query_0(var_hfd, var_elevation_data, var_pos, var_0, var_1, var_2);
    // if lateral_dist_sq > 0.0:                                                              <L 266>
    var_4 = (var_2 > var_3);
    if (var_4) {
        // dist = wp.sqrt(lateral_dist_sq + d_plane * d_plane)                                <L 267>
        var_5 = wp::mul(var_0, var_0);
        var_6 = wp::add(var_2, var_5);
        var_7 = wp::sqrt(var_6);
        // cx = wp.clamp(pos[0], -hfd.hx, hfd.hx)                                             <L 268>
        var_9 = wp::extract(var_pos, var_8);
        var_10 = &((var_hfd).hx);
        var_12 = wp::load(var_10);
        var_11 = wp::neg(var_12);
        var_13 = &((var_hfd).hx);
        var_15 = wp::load(var_13);
        var_14 = wp::clamp(var_9, var_11, var_15);
        // cy = wp.clamp(pos[1], -hfd.hy, hfd.hy)                                             <L 269>
        var_17 = wp::extract(var_pos, var_16);
        var_18 = &((var_hfd).hy);
        var_20 = wp::load(var_18);
        var_19 = wp::neg(var_20);
        var_21 = &((var_hfd).hy);
        var_23 = wp::load(var_21);
        var_22 = wp::clamp(var_17, var_19, var_23);
        // lateral = wp.vec3(pos[0] - cx, pos[1] - cy, 0.0)                                   <L 270>
        var_25 = wp::extract(var_pos, var_24);
        var_26 = wp::sub(var_25, var_14);
        var_28 = wp::extract(var_pos, var_27);
        var_29 = wp::sub(var_28, var_22);
        var_31 = wp::vec_t<3, wp::float32>(var_26, var_29, var_30);
        // raw_grad = lateral + d_plane * normal                                              <L 271>
        var_32 = wp::mul(var_0, var_1);
        var_33 = wp::add(var_31, var_32);
        // if wp.length_sq(raw_grad) > 1.0e-20:                                               <L 272>
        var_34 = wp::length_sq(var_33);
        var_36 = (var_34 > var_35);
        if (var_36) {
            // grad = wp.normalize(raw_grad)                                                  <L 273>
            var_37 = wp::normalize(var_33);
        }
        if (!var_36) {
            // grad = wp.vec3(0.0, 0.0, 1.0)                                                  <L 275>
            var_41 = wp::vec_t<3, wp::float32>(var_38, var_39, var_40);
        }
        var_42 = wp::where(var_36, var_37, var_41);
        // return dist, grad                                                                  <L 276>
        ret_0 = var_7;
        ret_1 = var_42;
        goto label0;
    }
    // return d_plane, normal                                                                 <L 277>
    ret_0 = var_0;
    ret_1 = var_1;
    goto label1;
    //---------
    // reverse
    label1:;
    adj_1 += adj_ret_1;
    adj_0 += adj_ret_0;
    // adj: return d_plane, normal                                                            <L 277>
    if (var_4) {
        label0:;
        adj_42 += adj_ret_1;
        adj_7 += adj_ret_0;
        // adj: return dist, grad                                                             <L 276>
        wp::adj_where(var_36, var_37, var_41, adj_36, adj_37, adj_41, adj_42);
        if (!var_36) {
            wp::adj_vec_t(var_38, var_39, var_40, adj_38, adj_39, adj_40, adj_41);
            // adj: grad = wp.vec3(0.0, 0.0, 1.0)                                             <L 275>
        }
        if (var_36) {
            wp::adj_normalize(var_33, var_37, adj_33, adj_37);
            // adj: grad = wp.normalize(raw_grad)                                             <L 273>
        }
        wp::adj_length_sq(var_33, adj_33, adj_34);
        // adj: if wp.length_sq(raw_grad) > 1.0e-20:                                          <L 272>
        wp::adj_add(var_31, var_32, adj_31, adj_32, adj_33);
        wp::adj_mul(var_0, var_1, adj_0, adj_1, adj_32);
        // adj: raw_grad = lateral + d_plane * normal                                         <L 271>
        wp::adj_vec_t(var_26, var_29, var_30, adj_26, adj_29, adj_30, adj_31);
        wp::adj_sub(var_28, var_22, adj_28, adj_22, adj_29);
        wp::adj_extract(var_pos, var_27, adj_pos, adj_27, adj_28);
        wp::adj_sub(var_25, var_14, adj_25, adj_14, adj_26);
        wp::adj_extract(var_pos, var_24, adj_pos, adj_24, adj_25);
        // adj: lateral = wp.vec3(pos[0] - cx, pos[1] - cy, 0.0)                              <L 270>
        wp::adj_clamp(var_17, var_19, var_23, adj_17, adj_19, adj_21, adj_22);
        adj_hfd.hy += adj_21;
        wp::adj_neg(var_20, adj_18, adj_19);
        adj_hfd.hy += adj_18;
        wp::adj_extract(var_pos, var_16, adj_pos, adj_16, adj_17);
        // adj: cy = wp.clamp(pos[1], -hfd.hy, hfd.hy)                                        <L 269>
        wp::adj_clamp(var_9, var_11, var_15, adj_9, adj_11, adj_13, adj_14);
        adj_hfd.hx += adj_13;
        wp::adj_neg(var_12, adj_10, adj_11);
        adj_hfd.hx += adj_10;
        wp::adj_extract(var_pos, var_8, adj_pos, adj_8, adj_9);
        // adj: cx = wp.clamp(pos[0], -hfd.hx, hfd.hx)                                        <L 268>
        wp::adj_sqrt(var_6, var_7, adj_6, adj_7);
        wp::adj_add(var_2, var_5, adj_2, adj_5, adj_6);
        wp::adj_mul(var_0, var_0, adj_0, adj_0, adj_5);
        // adj: dist = wp.sqrt(lateral_dist_sq + d_plane * d_plane)                           <L 267>
    }
    // adj: if lateral_dist_sq > 0.0:                                                         <L 266>
    adj__heightfield_surface_query_0(var_hfd, var_elevation_data, var_pos, var_0, var_1, var_2, adj_hfd, adj_elevation_data, adj_pos, adj_0, adj_1, adj_2);
    // adj: d_plane, normal, lateral_dist_sq = _heightfield_surface_query(hfd, elevation_data, pos)  <L 265>
    // adj: def sample_sdf_grad_heightfield(                                                  <L 255>
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:985
static CUDA_CALLABLE void adj_counter_increment_0(
    wp::array_t<wp::int32> var_counter,
    wp::int32 var_counter_index,
    wp::array_t<wp::int32> var_tids,
    wp::int32 var_tid,
    wp::int32 var_index_limit,
    wp::array_t<wp::int32> & adj_counter,
    wp::int32 & adj_counter_index,
    wp::array_t<wp::int32> & adj_tids,
    wp::int32 & adj_tid,
    wp::int32 & adj_index_limit,
    wp::int32 & adj_ret)
{
    //---------
    // primal vars
    const wp::int32 var_0 = 1;
    wp::int32 var_1;
    bool var_2;
    bool var_3;
    const wp::int32 var_4 = 0;
    bool var_5;
    wp::shape_t* var_6;
    const wp::int32 var_7 = 0;
    wp::int32 var_8;
    wp::shape_t var_9;
    bool var_10;
    wp::shape_t* var_11;
    const wp::int32 var_12 = 0;
    wp::int32 var_13;
    wp::shape_t var_14;
    bool var_15;
    const wp::int32 var_16 = -1;
    const wp::int32 var_17 = -1;
    //---------
    // dual vars
    wp::int32 adj_0 = {};
    wp::int32 adj_1 = {};
    bool adj_2 = {};
    bool adj_3 = {};
    wp::int32 adj_4 = {};
    bool adj_5 = {};
    wp::shape_t adj_6 = {};
    wp::int32 adj_7 = {};
    wp::int32 adj_8 = {};
    wp::shape_t adj_9 = {};
    bool adj_10 = {};
    wp::shape_t adj_11 = {};
    wp::int32 adj_12 = {};
    wp::int32 adj_13 = {};
    wp::shape_t adj_14 = {};
    bool adj_15 = {};
    wp::int32 adj_16 = {};
    wp::int32 adj_17 = {};
    //---------
    // forward
    // def counter_increment(counter: wp.array[int], counter_index: int, tids: wp.array[int], tid: int, index_limit: int = -1):       <L 986>
    // count = wp.atomic_add(counter, counter_index, 1)                                       <L 1001>
    // var_1 = wp::atomic_add(var_counter, var_counter_index, var_0);
    // if count < index_limit or index_limit < 0:                                             <L 1002>
    var_3 = (var_1 < var_index_limit);
    var_2 = var_3;
    if (!var_2) {
        var_5 = (var_index_limit < var_4);
        var_2 = var_2 || var_5;
    }
    if (var_2) {
        // if tid < tids.shape[0]:                                                            <L 1003>
        var_6 = &(var_tids.shape);
        var_9 = wp::load(var_6);
        var_8 = wp::extract(var_9, var_7);
        var_10 = (var_tid < var_8);
        if (var_10) {
            // tids[tid] = count                                                              <L 1004>
            // wp::array_store(var_tids, var_tid, var_1);
        }
        // return count                                                                       <L 1005>
        goto label0;
    }
    // if tid < tids.shape[0]:                                                                <L 1006>
    var_11 = &(var_tids.shape);
    var_14 = wp::load(var_11);
    var_13 = wp::extract(var_14, var_12);
    var_15 = (var_tid < var_13);
    if (var_15) {
        // tids[tid] = -1                                                                     <L 1007>
        // wp::array_store(var_tids, var_tid, var_16);
    }
    // return -1                                                                              <L 1008>
    goto label1;
    //---------
    // reverse
    label1:;
    adj_17 += adj_ret;
    // adj: return -1                                                                         <L 1008>
    if (var_15) {
        wp::adj_array_store(var_tids, var_tid, var_16, adj_tids, adj_tid, adj_16);
        // adj: tids[tid] = -1                                                                <L 1007>
    }
    adj_tids.shape = adj_11;
    // adj: if tid < tids.shape[0]:                                                           <L 1006>
    if (var_2) {
        label0:;
        adj_1 += adj_ret;
        // adj: return count                                                                  <L 1005>
        if (var_10) {
            wp::adj_array_store(var_tids, var_tid, var_1, adj_tids, adj_tid, adj_1);
            // adj: tids[tid] = count                                                         <L 1004>
        }
        adj_tids.shape = adj_6;
        // adj: if tid < tids.shape[0]:                                                       <L 1003>
    }
    if (!var_2) {
    }
    // adj: if count < index_limit or index_limit < 0:                                        <L 1002>
    wp::adj_atomic_add(var_counter, var_counter_index, var_0, adj_counter, adj_counter_index, adj_0, adj_1);
    // adj: count = wp.atomic_add(counter, counter_index, 1)                                  <L 1001>
    // adj: def counter_increment(counter: wp.array[int], counter_index: int, tids: wp.array[int], tid: int, index_limit: int = -1):  <L 986>
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/broad_phase_common.py:0
static CUDA_CALLABLE void adj_binary_search_0(
    wp::array_t<wp::int32> var_values,
    wp::int32 var_value,
    wp::int32 var_lower,
    wp::int32 var_upper,
    wp::array_t<wp::int32> & adj_values,
    wp::int32 & adj_value,
    wp::int32 & adj_lower,
    wp::int32 & adj_upper,
    wp::int32 & adj_ret)
{
    //---------
    // primal vars
    bool var_0;
    wp::int32 var_1;
    const wp::int32 var_2 = 1;
    wp::int32 var_3;
    wp::int32* var_4;
    bool var_5;
    wp::int32 var_6;
    wp::int32 var_7;
    const wp::int32 var_8 = 1;
    wp::int32 var_9;
    wp::int32 var_10;
    wp::int32 var_11;
    //---------
    // dual vars
    bool adj_0 = {};
    wp::int32 adj_1 = {};
    wp::int32 adj_2 = {};
    wp::int32 adj_3 = {};
    wp::int32 adj_4 = {};
    bool adj_5 = {};
    wp::int32 adj_6 = {};
    wp::int32 adj_7 = {};
    wp::int32 adj_8 = {};
    wp::int32 adj_9 = {};
    wp::int32 adj_10 = {};
    wp::int32 adj_11 = {};
    //---------
    // forward
    // def binary_search(values: wp.array[Any], value: Any, lower: int, upper: int) -> int:       <L 1>
    // while lower < upper:                                                                   <L 2>
    // return upper                                                                           <L 9>
    goto label2;
    //---------
    // reverse
    label2:;
    adj_upper += adj_ret;
    // adj: return upper                                                                      <L 9>
    start_while_0:;
    var_0 = (var_lower < var_upper);
    if ((var_0) == false) goto end_while_0;
    adj_1 = {};
    adj_2 = {};
    adj_3 = {};
    adj_4 = {};
    adj_5 = {};
    adj_6 = {};
    adj_7 = {};
    adj_8 = {};
    adj_9 = {};
    adj_10 = {};
    adj_11 = {};
        // mid = (lower + upper) >> 1                                                         <L 3>
        var_1 = wp::add(var_lower, var_upper);
        var_3 = wp::rshift(var_1, var_2);
        // if values[mid] > value:                                                            <L 4>
        var_4 = wp::address(var_values, var_3);
        var_6 = wp::load(var_4);
        var_5 = (var_6 > var_value);
        if (var_5) {
            // upper = mid                                                                    <L 5>
            var_7 = wp::copy(var_3);
        }
        if (!var_5) {
            // lower = mid + 1                                                                <L 7>
            var_9 = wp::add(var_3, var_8);
        }
        var_10 = wp::where(var_5, var_lower, var_9);
        var_11 = wp::where(var_5, var_7, var_upper);
        wp::assign(var_lower, var_10);
        wp::assign(var_upper, var_11);
        wp::adj_assign(var_upper, var_11, adj_upper, adj_11);
        wp::adj_assign(var_lower, var_10, adj_lower, adj_10);
        wp::adj_where(var_5, var_7, var_upper, adj_5, adj_7, adj_upper, adj_11);
        wp::adj_where(var_5, var_lower, var_9, adj_5, adj_lower, adj_9, adj_10);
        if (!var_5) {
            wp::adj_add(var_3, var_8, adj_3, adj_8, adj_9);
            // adj: lower = mid + 1                                                           <L 7>
        }
        if (var_5) {
            wp::adj_copy(var_3, adj_3, adj_7);
            // adj: upper = mid                                                               <L 5>
        }
        wp::adj_address(var_values, var_3, adj_values, adj_3, adj_4);
        // adj: if values[mid] > value:                                                       <L 4>
        wp::adj_add(var_lower, var_upper, adj_lower, adj_upper, adj_1);
        // adj: mid = (lower + upper) >> 1                                                    <L 3>
    goto start_while_0;
    end_while_0:;
    // adj: while lower < upper:                                                              <L 2>
    // adj: def binary_search(values: wp.array[Any], value: Any, lower: int, upper: int) -> int:  <L 1>
    return;
}


// /home/oem/miniconda3/envs/dexsim/lib/python3.11/site-packages/newton/_src/geometry/kernels.py:79
static CUDA_CALLABLE void adj_triangle_closest_point_0(
    wp::vec_t<3, wp::float32> var_a,
    wp::vec_t<3, wp::float32> var_b,
    wp::vec_t<3, wp::float32> var_c,
    wp::vec_t<3, wp::float32> var_p,
    wp::vec_t<3, wp::float32> & ret_0,
    wp::vec_t<3, wp::float32> & ret_1,
    wp::int32 & ret_2,
    wp::vec_t<3, wp::float32> & adj_a,
    wp::vec_t<3, wp::float32> & adj_b,
    wp::vec_t<3, wp::float32> & adj_c,
    wp::vec_t<3, wp::float32> & adj_p,
    wp::vec_t<3, wp::float32> & adj_ret_0,
    wp::vec_t<3, wp::float32> & adj_ret_1,
    wp::int32 & adj_ret_2)
{
    //---------
    // primal vars
    wp::vec_t<3, wp::float32> var_0;
    wp::vec_t<3, wp::float32> var_1;
    wp::vec_t<3, wp::float32> var_2;
    wp::float32 var_3;
    wp::float32 var_4;
    bool var_5;
    const wp::float32 var_6 = 0.0;
    bool var_7;
    const wp::float32 var_8 = 0.0;
    bool var_9;
    const wp::int32 var_10 = 0;
    wp::int32 var_11;
    const wp::float32 var_12 = 1.0;
    const wp::float32 var_13 = 0.0;
    const wp::float32 var_14 = 0.0;
    wp::vec_t<3, wp::float32> var_15;
    wp::vec_t<3, wp::float32> var_16;
    wp::float32 var_17;
    wp::float32 var_18;
    bool var_19;
    const wp::float32 var_20 = 0.0;
    bool var_21;
    bool var_22;
    const wp::int32 var_23 = 1;
    wp::int32 var_24;
    const wp::float32 var_25 = 0.0;
    const wp::float32 var_26 = 1.0;
    const wp::float32 var_27 = 0.0;
    wp::vec_t<3, wp::float32> var_28;
    wp::int32 var_29;
    wp::vec_t<3, wp::float32> var_30;
    wp::vec_t<3, wp::float32> var_31;
    wp::float32 var_32;
    wp::float32 var_33;
    bool var_34;
    const wp::float32 var_35 = 0.0;
    bool var_36;
    bool var_37;
    const wp::int32 var_38 = 2;
    wp::int32 var_39;
    const wp::float32 var_40 = 0.0;
    const wp::float32 var_41 = 0.0;
    const wp::float32 var_42 = 1.0;
    wp::vec_t<3, wp::float32> var_43;
    wp::int32 var_44;
    wp::vec_t<3, wp::float32> var_45;
    wp::float32 var_46;
    wp::float32 var_47;
    wp::float32 var_48;
    bool var_49;
    const wp::float32 var_50 = 0.0;
    bool var_51;
    const wp::float32 var_52 = 0.0;
    bool var_53;
    const wp::float32 var_54 = 0.0;
    bool var_55;
    wp::float32 var_56;
    wp::float32 var_57;
    const wp::int32 var_58 = 3;
    wp::int32 var_59;
    const wp::float32 var_60 = 1.0;
    wp::float32 var_61;
    const wp::float32 var_62 = 0.0;
    wp::vec_t<3, wp::float32> var_63;
    wp::vec_t<3, wp::float32> var_64;
    wp::vec_t<3, wp::float32> var_65;
    wp::int32 var_66;
    wp::vec_t<3, wp::float32> var_67;
    wp::float32 var_68;
    wp::float32 var_69;
    wp::float32 var_70;
    bool var_71;
    const wp::float32 var_72 = 0.0;
    bool var_73;
    const wp::float32 var_74 = 0.0;
    bool var_75;
    const wp::float32 var_76 = 0.0;
    bool var_77;
    wp::float32 var_78;
    wp::float32 var_79;
    const wp::int32 var_80 = 4;
    wp::int32 var_81;
    const wp::float32 var_82 = 1.0;
    wp::float32 var_83;
    const wp::float32 var_84 = 0.0;
    wp::vec_t<3, wp::float32> var_85;
    wp::vec_t<3, wp::float32> var_86;
    wp::vec_t<3, wp::float32> var_87;
    wp::int32 var_88;
    wp::vec_t<3, wp::float32> var_89;
    wp::float32 var_90;
    wp::float32 var_91;
    wp::float32 var_92;
    wp::float32 var_93;
    bool var_94;
    const wp::float32 var_95 = 0.0;
    bool var_96;
    wp::float32 var_97;
    const wp::float32 var_98 = 0.0;
    bool var_99;
    wp::float32 var_100;
    const wp::float32 var_101 = 0.0;
    bool var_102;
    wp::float32 var_103;
    wp::float32 var_104;
    wp::float32 var_105;
    wp::float32 var_106;
    wp::float32 var_107;
    const wp::int32 var_108 = 5;
    wp::int32 var_109;
    const wp::float32 var_110 = 0.0;
    const wp::float32 var_111 = 1.0;
    wp::float32 var_112;
    wp::vec_t<3, wp::float32> var_113;
    wp::vec_t<3, wp::float32> var_114;
    wp::vec_t<3, wp::float32> var_115;
    wp::vec_t<3, wp::float32> var_116;
    wp::int32 var_117;
    wp::vec_t<3, wp::float32> var_118;
    wp::float32 var_119;
    const wp::float32 var_120 = 1.0;
    wp::float32 var_121;
    wp::float32 var_122;
    wp::float32 var_123;
    wp::float32 var_124;
    wp::float32 var_125;
    const wp::int32 var_126 = 6;
    wp::int32 var_127;
    const wp::float32 var_128 = 1.0;
    wp::float32 var_129;
    wp::float32 var_130;
    wp::vec_t<3, wp::float32> var_131;
    wp::vec_t<3, wp::float32> var_132;
    wp::vec_t<3, wp::float32> var_133;
    wp::vec_t<3, wp::float32> var_134;
    wp::vec_t<3, wp::float32> var_135;
    //---------
    // dual vars
    wp::vec_t<3, wp::float32> adj_0 = {};
    wp::vec_t<3, wp::float32> adj_1 = {};
    wp::vec_t<3, wp::float32> adj_2 = {};
    wp::float32 adj_3 = {};
    wp::float32 adj_4 = {};
    bool adj_5 = {};
    wp::float32 adj_6 = {};
    bool adj_7 = {};
    wp::float32 adj_8 = {};
    bool adj_9 = {};
    wp::int32 adj_10 = {};
    wp::int32 adj_11 = {};
    wp::float32 adj_12 = {};
    wp::float32 adj_13 = {};
    wp::float32 adj_14 = {};
    wp::vec_t<3, wp::float32> adj_15 = {};
    wp::vec_t<3, wp::float32> adj_16 = {};
    wp::float32 adj_17 = {};
    wp::float32 adj_18 = {};
    bool adj_19 = {};
    wp::float32 adj_20 = {};
    bool adj_21 = {};
    bool adj_22 = {};
    wp::int32 adj_23 = {};
    wp::int32 adj_24 = {};
    wp::float32 adj_25 = {};
    wp::float32 adj_26 = {};
    wp::float32 adj_27 = {};
    wp::vec_t<3, wp::float32> adj_28 = {};
    wp::int32 adj_29 = {};
    wp::vec_t<3, wp::float32> adj_30 = {};
    wp::vec_t<3, wp::float32> adj_31 = {};
    wp::float32 adj_32 = {};
    wp::float32 adj_33 = {};
    bool adj_34 = {};
    wp::float32 adj_35 = {};
    bool adj_36 = {};
    bool adj_37 = {};
    wp::int32 adj_38 = {};
    wp::int32 adj_39 = {};
    wp::float32 adj_40 = {};
    wp::float32 adj_41 = {};
    wp::float32 adj_42 = {};
    wp::vec_t<3, wp::float32> adj_43 = {};
    wp::int32 adj_44 = {};
    wp::vec_t<3, wp::float32> adj_45 = {};
    wp::float32 adj_46 = {};
    wp::float32 adj_47 = {};
    wp::float32 adj_48 = {};
    bool adj_49 = {};
    wp::float32 adj_50 = {};
    bool adj_51 = {};
    wp::float32 adj_52 = {};
    bool adj_53 = {};
    wp::float32 adj_54 = {};
    bool adj_55 = {};
    wp::float32 adj_56 = {};
    wp::float32 adj_57 = {};
    wp::int32 adj_58 = {};
    wp::int32 adj_59 = {};
    wp::float32 adj_60 = {};
    wp::float32 adj_61 = {};
    wp::float32 adj_62 = {};
    wp::vec_t<3, wp::float32> adj_63 = {};
    wp::vec_t<3, wp::float32> adj_64 = {};
    wp::vec_t<3, wp::float32> adj_65 = {};
    wp::int32 adj_66 = {};
    wp::vec_t<3, wp::float32> adj_67 = {};
    wp::float32 adj_68 = {};
    wp::float32 adj_69 = {};
    wp::float32 adj_70 = {};
    bool adj_71 = {};
    wp::float32 adj_72 = {};
    bool adj_73 = {};
    wp::float32 adj_74 = {};
    bool adj_75 = {};
    wp::float32 adj_76 = {};
    bool adj_77 = {};
    wp::float32 adj_78 = {};
    wp::float32 adj_79 = {};
    wp::int32 adj_80 = {};
    wp::int32 adj_81 = {};
    wp::float32 adj_82 = {};
    wp::float32 adj_83 = {};
    wp::float32 adj_84 = {};
    wp::vec_t<3, wp::float32> adj_85 = {};
    wp::vec_t<3, wp::float32> adj_86 = {};
    wp::vec_t<3, wp::float32> adj_87 = {};
    wp::int32 adj_88 = {};
    wp::vec_t<3, wp::float32> adj_89 = {};
    wp::float32 adj_90 = {};
    wp::float32 adj_91 = {};
    wp::float32 adj_92 = {};
    wp::float32 adj_93 = {};
    bool adj_94 = {};
    wp::float32 adj_95 = {};
    bool adj_96 = {};
    wp::float32 adj_97 = {};
    wp::float32 adj_98 = {};
    bool adj_99 = {};
    wp::float32 adj_100 = {};
    wp::float32 adj_101 = {};
    bool adj_102 = {};
    wp::float32 adj_103 = {};
    wp::float32 adj_104 = {};
    wp::float32 adj_105 = {};
    wp::float32 adj_106 = {};
    wp::float32 adj_107 = {};
    wp::int32 adj_108 = {};
    wp::int32 adj_109 = {};
    wp::float32 adj_110 = {};
    wp::float32 adj_111 = {};
    wp::float32 adj_112 = {};
    wp::vec_t<3, wp::float32> adj_113 = {};
    wp::vec_t<3, wp::float32> adj_114 = {};
    wp::vec_t<3, wp::float32> adj_115 = {};
    wp::vec_t<3, wp::float32> adj_116 = {};
    wp::int32 adj_117 = {};
    wp::vec_t<3, wp::float32> adj_118 = {};
    wp::float32 adj_119 = {};
    wp::float32 adj_120 = {};
    wp::float32 adj_121 = {};
    wp::float32 adj_122 = {};
    wp::float32 adj_123 = {};
    wp::float32 adj_124 = {};
    wp::float32 adj_125 = {};
    wp::int32 adj_126 = {};
    wp::int32 adj_127 = {};
    wp::float32 adj_128 = {};
    wp::float32 adj_129 = {};
    wp::float32 adj_130 = {};
    wp::vec_t<3, wp::float32> adj_131 = {};
    wp::vec_t<3, wp::float32> adj_132 = {};
    wp::vec_t<3, wp::float32> adj_133 = {};
    wp::vec_t<3, wp::float32> adj_134 = {};
    wp::vec_t<3, wp::float32> adj_135 = {};
    //---------
    // forward
    // def triangle_closest_point(a: wp.vec3, b: wp.vec3, c: wp.vec3, p: wp.vec3):            <L 80>
    // ab = b - a                                                                             <L 91>
    var_0 = wp::sub(var_b, var_a);
    // ac = c - a                                                                             <L 92>
    var_1 = wp::sub(var_c, var_a);
    // ap = p - a                                                                             <L 93>
    var_2 = wp::sub(var_p, var_a);
    // d1 = wp.dot(ab, ap)                                                                    <L 95>
    var_3 = wp::dot(var_0, var_2);
    // d2 = wp.dot(ac, ap)                                                                    <L 96>
    var_4 = wp::dot(var_1, var_2);
    // if d1 <= 0.0 and d2 <= 0.0:                                                            <L 97>
    var_7 = (var_3 <= var_6);
    var_5 = var_7;
    if (var_5) {
        var_9 = (var_4 <= var_8);
        var_5 = var_5 && var_9;
    }
    if (var_5) {
        // feature_type = TRI_CONTACT_FEATURE_VERTEX_A                                        <L 98>
        var_11 = wp::copy(var_10);
        // bary = wp.vec3(1.0, 0.0, 0.0)                                                      <L 99>
        var_15 = wp::vec_t<3, wp::float32>(var_12, var_13, var_14);
        // return a, bary, feature_type                                                       <L 100>
        ret_0 = var_a;
        ret_1 = var_15;
        ret_2 = var_11;
        goto label0;
    }
    // bp = p - b                                                                             <L 102>
    var_16 = wp::sub(var_p, var_b);
    // d3 = wp.dot(ab, bp)                                                                    <L 103>
    var_17 = wp::dot(var_0, var_16);
    // d4 = wp.dot(ac, bp)                                                                    <L 104>
    var_18 = wp::dot(var_1, var_16);
    // if d3 >= 0.0 and d4 <= d3:                                                             <L 105>
    var_21 = (var_17 >= var_20);
    var_19 = var_21;
    if (var_19) {
        var_22 = (var_18 <= var_17);
        var_19 = var_19 && var_22;
    }
    if (var_19) {
        // feature_type = TRI_CONTACT_FEATURE_VERTEX_B                                        <L 106>
        var_24 = wp::copy(var_23);
        // bary = wp.vec3(0.0, 1.0, 0.0)                                                      <L 107>
        var_28 = wp::vec_t<3, wp::float32>(var_25, var_26, var_27);
        // return b, bary, feature_type                                                       <L 108>
        ret_0 = var_b;
        ret_1 = var_28;
        ret_2 = var_24;
        goto label1;
    }
    var_29 = wp::where(var_19, var_24, var_11);
    var_30 = wp::where(var_19, var_28, var_15);
    // cp = p - c                                                                             <L 110>
    var_31 = wp::sub(var_p, var_c);
    // d5 = wp.dot(ab, cp)                                                                    <L 111>
    var_32 = wp::dot(var_0, var_31);
    // d6 = wp.dot(ac, cp)                                                                    <L 112>
    var_33 = wp::dot(var_1, var_31);
    // if d6 >= 0.0 and d5 <= d6:                                                             <L 113>
    var_36 = (var_33 >= var_35);
    var_34 = var_36;
    if (var_34) {
        var_37 = (var_32 <= var_33);
        var_34 = var_34 && var_37;
    }
    if (var_34) {
        // feature_type = TRI_CONTACT_FEATURE_VERTEX_C                                        <L 114>
        var_39 = wp::copy(var_38);
        // bary = wp.vec3(0.0, 0.0, 1.0)                                                      <L 115>
        var_43 = wp::vec_t<3, wp::float32>(var_40, var_41, var_42);
        // return c, bary, feature_type                                                       <L 116>
        ret_0 = var_c;
        ret_1 = var_43;
        ret_2 = var_39;
        goto label2;
    }
    var_44 = wp::where(var_34, var_39, var_29);
    var_45 = wp::where(var_34, var_43, var_30);
    // vc = d1 * d4 - d3 * d2                                                                 <L 118>
    var_46 = wp::mul(var_3, var_18);
    var_47 = wp::mul(var_17, var_4);
    var_48 = wp::sub(var_46, var_47);
    // if vc <= 0.0 and d1 >= 0.0 and d3 <= 0.0:                                              <L 119>
    var_51 = (var_48 <= var_50);
    var_49 = var_51;
    if (var_49) {
        var_53 = (var_3 >= var_52);
        var_49 = var_49 && var_53;
    }
    if (var_49) {
        var_55 = (var_17 <= var_54);
        var_49 = var_49 && var_55;
    }
    if (var_49) {
        // v = d1 / (d1 - d3)                                                                 <L 120>
        var_56 = wp::sub(var_3, var_17);
        var_57 = wp::div(var_3, var_56);
        // feature_type = TRI_CONTACT_FEATURE_EDGE_AB                                         <L 121>
        var_59 = wp::copy(var_58);
        // bary = wp.vec3(1.0 - v, v, 0.0)                                                    <L 122>
        var_61 = wp::sub(var_60, var_57);
        var_63 = wp::vec_t<3, wp::float32>(var_61, var_57, var_62);
        // return a + v * ab, bary, feature_type                                              <L 123>
        var_64 = wp::mul(var_57, var_0);
        var_65 = wp::add(var_a, var_64);
        ret_0 = var_65;
        ret_1 = var_63;
        ret_2 = var_59;
        goto label3;
    }
    var_66 = wp::where(var_49, var_59, var_44);
    var_67 = wp::where(var_49, var_63, var_45);
    // vb = d5 * d2 - d1 * d6                                                                 <L 125>
    var_68 = wp::mul(var_32, var_4);
    var_69 = wp::mul(var_3, var_33);
    var_70 = wp::sub(var_68, var_69);
    // if vb <= 0.0 and d2 >= 0.0 and d6 <= 0.0:                                              <L 126>
    var_73 = (var_70 <= var_72);
    var_71 = var_73;
    if (var_71) {
        var_75 = (var_4 >= var_74);
        var_71 = var_71 && var_75;
    }
    if (var_71) {
        var_77 = (var_33 <= var_76);
        var_71 = var_71 && var_77;
    }
    if (var_71) {
        // v = d2 / (d2 - d6)                                                                 <L 127>
        var_78 = wp::sub(var_4, var_33);
        var_79 = wp::div(var_4, var_78);
        // feature_type = TRI_CONTACT_FEATURE_EDGE_AC                                         <L 128>
        var_81 = wp::copy(var_80);
        // bary = wp.vec3(1.0 - v, 0.0, v)                                                    <L 129>
        var_83 = wp::sub(var_82, var_79);
        var_85 = wp::vec_t<3, wp::float32>(var_83, var_84, var_79);
        // return a + v * ac, bary, feature_type                                              <L 130>
        var_86 = wp::mul(var_79, var_1);
        var_87 = wp::add(var_a, var_86);
        ret_0 = var_87;
        ret_1 = var_85;
        ret_2 = var_81;
        goto label4;
    }
    var_88 = wp::where(var_71, var_81, var_66);
    var_89 = wp::where(var_71, var_85, var_67);
    var_90 = wp::where(var_71, var_79, var_57);
    // va = d3 * d6 - d5 * d4                                                                 <L 132>
    var_91 = wp::mul(var_17, var_33);
    var_92 = wp::mul(var_32, var_18);
    var_93 = wp::sub(var_91, var_92);
    // if va <= 0.0 and (d4 - d3) >= 0.0 and (d5 - d6) >= 0.0:                                <L 133>
    var_96 = (var_93 <= var_95);
    var_94 = var_96;
    if (var_94) {
        var_97 = wp::sub(var_18, var_17);
        var_99 = (var_97 >= var_98);
        var_94 = var_94 && var_99;
    }
    if (var_94) {
        var_100 = wp::sub(var_32, var_33);
        var_102 = (var_100 >= var_101);
        var_94 = var_94 && var_102;
    }
    if (var_94) {
        // v = (d4 - d3) / ((d4 - d3) + (d5 - d6))                                            <L 134>
        var_103 = wp::sub(var_18, var_17);
        var_104 = wp::sub(var_18, var_17);
        var_105 = wp::sub(var_32, var_33);
        var_106 = wp::add(var_104, var_105);
        var_107 = wp::div(var_103, var_106);
        // feature_type = TRI_CONTACT_FEATURE_EDGE_BC                                         <L 135>
        var_109 = wp::copy(var_108);
        // bary = wp.vec3(0.0, 1.0 - v, v)                                                    <L 136>
        var_112 = wp::sub(var_111, var_107);
        var_113 = wp::vec_t<3, wp::float32>(var_110, var_112, var_107);
        // return b + v * (c - b), bary, feature_type                                         <L 137>
        var_114 = wp::sub(var_c, var_b);
        var_115 = wp::mul(var_107, var_114);
        var_116 = wp::add(var_b, var_115);
        ret_0 = var_116;
        ret_1 = var_113;
        ret_2 = var_109;
        goto label5;
    }
    var_117 = wp::where(var_94, var_109, var_88);
    var_118 = wp::where(var_94, var_113, var_89);
    var_119 = wp::where(var_94, var_107, var_90);
    // denom = 1.0 / (va + vb + vc)                                                           <L 139>
    var_121 = wp::add(var_93, var_70);
    var_122 = wp::add(var_121, var_48);
    var_123 = wp::div(var_120, var_122);
    // v = vb * denom                                                                         <L 140>
    var_124 = wp::mul(var_70, var_123);
    // w = vc * denom                                                                         <L 141>
    var_125 = wp::mul(var_48, var_123);
    // feature_type = TRI_CONTACT_FEATURE_FACE_INTERIOR                                       <L 142>
    var_127 = wp::copy(var_126);
    // bary = wp.vec3(1.0 - v - w, v, w)                                                      <L 143>
    var_129 = wp::sub(var_128, var_124);
    var_130 = wp::sub(var_129, var_125);
    var_131 = wp::vec_t<3, wp::float32>(var_130, var_124, var_125);
    // return a + v * ab + w * ac, bary, feature_type                                         <L 144>
    var_132 = wp::mul(var_124, var_0);
    var_133 = wp::add(var_a, var_132);
    var_134 = wp::mul(var_125, var_1);
    var_135 = wp::add(var_133, var_134);
    ret_0 = var_135;
    ret_1 = var_131;
    ret_2 = var_127;
    goto label6;
    //---------
    // reverse
    label6:;
    adj_127 += adj_ret_2;
    adj_131 += adj_ret_1;
    adj_135 += adj_ret_0;
    wp::adj_add(var_133, var_134, adj_133, adj_134, adj_135);
    wp::adj_mul(var_125, var_1, adj_125, adj_1, adj_134);
    wp::adj_add(var_a, var_132, adj_a, adj_132, adj_133);
    wp::adj_mul(var_124, var_0, adj_124, adj_0, adj_132);
    // adj: return a + v * ab + w * ac, bary, feature_type                                    <L 144>
    wp::adj_vec_t(var_130, var_124, var_125, adj_130, adj_124, adj_125, adj_131);
    wp::adj_sub(var_129, var_125, adj_129, adj_125, adj_130);
    wp::adj_sub(var_128, var_124, adj_128, adj_124, adj_129);
    // adj: bary = wp.vec3(1.0 - v - w, v, w)                                                 <L 143>
    wp::adj_copy(var_126, adj_126, adj_127);
    // adj: feature_type = TRI_CONTACT_FEATURE_FACE_INTERIOR                                  <L 142>
    wp::adj_mul(var_48, var_123, adj_48, adj_123, adj_125);
    // adj: w = vc * denom                                                                    <L 141>
    wp::adj_mul(var_70, var_123, adj_70, adj_123, adj_124);
    // adj: v = vb * denom                                                                    <L 140>
    wp::adj_div(var_120, var_122, var_123, adj_120, adj_122, adj_123);
    wp::adj_add(var_121, var_48, adj_121, adj_48, adj_122);
    wp::adj_add(var_93, var_70, adj_93, adj_70, adj_121);
    // adj: denom = 1.0 / (va + vb + vc)                                                      <L 139>
    wp::adj_where(var_94, var_107, var_90, adj_94, adj_107, adj_90, adj_119);
    wp::adj_where(var_94, var_113, var_89, adj_94, adj_113, adj_89, adj_118);
    wp::adj_where(var_94, var_109, var_88, adj_94, adj_109, adj_88, adj_117);
    if (var_94) {
        label5:;
        adj_109 += adj_ret_2;
        adj_113 += adj_ret_1;
        adj_116 += adj_ret_0;
        wp::adj_add(var_b, var_115, adj_b, adj_115, adj_116);
        wp::adj_mul(var_107, var_114, adj_107, adj_114, adj_115);
        wp::adj_sub(var_c, var_b, adj_c, adj_b, adj_114);
        // adj: return b + v * (c - b), bary, feature_type                                    <L 137>
        wp::adj_vec_t(var_110, var_112, var_107, adj_110, adj_112, adj_107, adj_113);
        wp::adj_sub(var_111, var_107, adj_111, adj_107, adj_112);
        // adj: bary = wp.vec3(0.0, 1.0 - v, v)                                               <L 136>
        wp::adj_copy(var_108, adj_108, adj_109);
        // adj: feature_type = TRI_CONTACT_FEATURE_EDGE_BC                                    <L 135>
        wp::adj_div(var_103, var_106, var_107, adj_103, adj_106, adj_107);
        wp::adj_add(var_104, var_105, adj_104, adj_105, adj_106);
        wp::adj_sub(var_32, var_33, adj_32, adj_33, adj_105);
        wp::adj_sub(var_18, var_17, adj_18, adj_17, adj_104);
        wp::adj_sub(var_18, var_17, adj_18, adj_17, adj_103);
        // adj: v = (d4 - d3) / ((d4 - d3) + (d5 - d6))                                       <L 134>
    }
    if (var_94) {
        wp::adj_sub(var_32, var_33, adj_32, adj_33, adj_100);
    }
    if (var_94) {
        wp::adj_sub(var_18, var_17, adj_18, adj_17, adj_97);
    }
    // adj: if va <= 0.0 and (d4 - d3) >= 0.0 and (d5 - d6) >= 0.0:                           <L 133>
    wp::adj_sub(var_91, var_92, adj_91, adj_92, adj_93);
    wp::adj_mul(var_32, var_18, adj_32, adj_18, adj_92);
    wp::adj_mul(var_17, var_33, adj_17, adj_33, adj_91);
    // adj: va = d3 * d6 - d5 * d4                                                            <L 132>
    wp::adj_where(var_71, var_79, var_57, adj_71, adj_79, adj_57, adj_90);
    wp::adj_where(var_71, var_85, var_67, adj_71, adj_85, adj_67, adj_89);
    wp::adj_where(var_71, var_81, var_66, adj_71, adj_81, adj_66, adj_88);
    if (var_71) {
        label4:;
        adj_81 += adj_ret_2;
        adj_85 += adj_ret_1;
        adj_87 += adj_ret_0;
        wp::adj_add(var_a, var_86, adj_a, adj_86, adj_87);
        wp::adj_mul(var_79, var_1, adj_79, adj_1, adj_86);
        // adj: return a + v * ac, bary, feature_type                                         <L 130>
        wp::adj_vec_t(var_83, var_84, var_79, adj_83, adj_84, adj_79, adj_85);
        wp::adj_sub(var_82, var_79, adj_82, adj_79, adj_83);
        // adj: bary = wp.vec3(1.0 - v, 0.0, v)                                               <L 129>
        wp::adj_copy(var_80, adj_80, adj_81);
        // adj: feature_type = TRI_CONTACT_FEATURE_EDGE_AC                                    <L 128>
        wp::adj_div(var_4, var_78, var_79, adj_4, adj_78, adj_79);
        wp::adj_sub(var_4, var_33, adj_4, adj_33, adj_78);
        // adj: v = d2 / (d2 - d6)                                                            <L 127>
    }
    if (var_71) {
    }
    if (var_71) {
    }
    // adj: if vb <= 0.0 and d2 >= 0.0 and d6 <= 0.0:                                         <L 126>
    wp::adj_sub(var_68, var_69, adj_68, adj_69, adj_70);
    wp::adj_mul(var_3, var_33, adj_3, adj_33, adj_69);
    wp::adj_mul(var_32, var_4, adj_32, adj_4, adj_68);
    // adj: vb = d5 * d2 - d1 * d6                                                            <L 125>
    wp::adj_where(var_49, var_63, var_45, adj_49, adj_63, adj_45, adj_67);
    wp::adj_where(var_49, var_59, var_44, adj_49, adj_59, adj_44, adj_66);
    if (var_49) {
        label3:;
        adj_59 += adj_ret_2;
        adj_63 += adj_ret_1;
        adj_65 += adj_ret_0;
        wp::adj_add(var_a, var_64, adj_a, adj_64, adj_65);
        wp::adj_mul(var_57, var_0, adj_57, adj_0, adj_64);
        // adj: return a + v * ab, bary, feature_type                                         <L 123>
        wp::adj_vec_t(var_61, var_57, var_62, adj_61, adj_57, adj_62, adj_63);
        wp::adj_sub(var_60, var_57, adj_60, adj_57, adj_61);
        // adj: bary = wp.vec3(1.0 - v, v, 0.0)                                               <L 122>
        wp::adj_copy(var_58, adj_58, adj_59);
        // adj: feature_type = TRI_CONTACT_FEATURE_EDGE_AB                                    <L 121>
        wp::adj_div(var_3, var_56, var_57, adj_3, adj_56, adj_57);
        wp::adj_sub(var_3, var_17, adj_3, adj_17, adj_56);
        // adj: v = d1 / (d1 - d3)                                                            <L 120>
    }
    if (var_49) {
    }
    if (var_49) {
    }
    // adj: if vc <= 0.0 and d1 >= 0.0 and d3 <= 0.0:                                         <L 119>
    wp::adj_sub(var_46, var_47, adj_46, adj_47, adj_48);
    wp::adj_mul(var_17, var_4, adj_17, adj_4, adj_47);
    wp::adj_mul(var_3, var_18, adj_3, adj_18, adj_46);
    // adj: vc = d1 * d4 - d3 * d2                                                            <L 118>
    wp::adj_where(var_34, var_43, var_30, adj_34, adj_43, adj_30, adj_45);
    wp::adj_where(var_34, var_39, var_29, adj_34, adj_39, adj_29, adj_44);
    if (var_34) {
        label2:;
        adj_39 += adj_ret_2;
        adj_43 += adj_ret_1;
        adj_c += adj_ret_0;
        // adj: return c, bary, feature_type                                                  <L 116>
        wp::adj_vec_t(var_40, var_41, var_42, adj_40, adj_41, adj_42, adj_43);
        // adj: bary = wp.vec3(0.0, 0.0, 1.0)                                                 <L 115>
        wp::adj_copy(var_38, adj_38, adj_39);
        // adj: feature_type = TRI_CONTACT_FEATURE_VERTEX_C                                   <L 114>
    }
    if (var_34) {
    }
    // adj: if d6 >= 0.0 and d5 <= d6:                                                        <L 113>
    wp::adj_dot(var_1, var_31, adj_1, adj_31, adj_33);
    // adj: d6 = wp.dot(ac, cp)                                                               <L 112>
    wp::adj_dot(var_0, var_31, adj_0, adj_31, adj_32);
    // adj: d5 = wp.dot(ab, cp)                                                               <L 111>
    wp::adj_sub(var_p, var_c, adj_p, adj_c, adj_31);
    // adj: cp = p - c                                                                        <L 110>
    wp::adj_where(var_19, var_28, var_15, adj_19, adj_28, adj_15, adj_30);
    wp::adj_where(var_19, var_24, var_11, adj_19, adj_24, adj_11, adj_29);
    if (var_19) {
        label1:;
        adj_24 += adj_ret_2;
        adj_28 += adj_ret_1;
        adj_b += adj_ret_0;
        // adj: return b, bary, feature_type                                                  <L 108>
        wp::adj_vec_t(var_25, var_26, var_27, adj_25, adj_26, adj_27, adj_28);
        // adj: bary = wp.vec3(0.0, 1.0, 0.0)                                                 <L 107>
        wp::adj_copy(var_23, adj_23, adj_24);
        // adj: feature_type = TRI_CONTACT_FEATURE_VERTEX_B                                   <L 106>
    }
    if (var_19) {
    }
    // adj: if d3 >= 0.0 and d4 <= d3:                                                        <L 105>
    wp::adj_dot(var_1, var_16, adj_1, adj_16, adj_18);
    // adj: d4 = wp.dot(ac, bp)                                                               <L 104>
    wp::adj_dot(var_0, var_16, adj_0, adj_16, adj_17);
    // adj: d3 = wp.dot(ab, bp)                                                               <L 103>
    wp::adj_sub(var_p, var_b, adj_p, adj_b, adj_16);
    // adj: bp = p - b                                                                        <L 102>
    if (var_5) {
        label0:;
        adj_11 += adj_ret_2;
        adj_15 += adj_ret_1;
        adj_a += adj_ret_0;
        // adj: return a, bary, feature_type                                                  <L 100>
        wp::adj_vec_t(var_12, var_13, var_14, adj_12, adj_13, adj_14, adj_15);
        // adj: bary = wp.vec3(1.0, 0.0, 0.0)                                                 <L 99>
        wp::adj_copy(var_10, adj_10, adj_11);
        // adj: feature_type = TRI_CONTACT_FEATURE_VERTEX_A                                   <L 98>
    }
    if (var_5) {
    }
    // adj: if d1 <= 0.0 and d2 <= 0.0:                                                       <L 97>
    wp::adj_dot(var_1, var_2, adj_1, adj_2, adj_4);
    // adj: d2 = wp.dot(ac, ap)                                                               <L 96>
    wp::adj_dot(var_0, var_2, adj_0, adj_2, adj_3);
    // adj: d1 = wp.dot(ab, ap)                                                               <L 95>
    wp::adj_sub(var_p, var_a, adj_p, adj_a, adj_2);
    // adj: ap = p - a                                                                        <L 93>
    wp::adj_sub(var_c, var_a, adj_c, adj_a, adj_1);
    // adj: ac = c - a                                                                        <L 92>
    wp::adj_sub(var_b, var_a, adj_b, adj_a, adj_0);
    // adj: ab = b - a                                                                        <L 91>
    // adj: def triangle_closest_point(a: wp.vec3, b: wp.vec3, c: wp.vec3, p: wp.vec3):       <L 80>
    return;
}



extern "C" __global__ void init_triangle_collision_data_kernel_00997c3e_cuda_kernel_forward(
    wp::launch_bounds_t<1> dim,
    wp::float32 var_query_radius,
    wp::array_t<wp::int32> var_triangle_colliding_vertices_count,
    wp::array_t<wp::float32> var_triangle_colliding_vertices_min_dist,
    wp::array_t<wp::int32> var_resize_flags)
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
        const wp::int32 var_1 = 0;
        const wp::int32 var_2 = 0;
        bool var_3;
        const wp::int32 var_4 = 0;
        const wp::int32 var_5 = 0;
        const wp::int32 var_6 = 1;
        const wp::int32 var_7 = 0;
        const wp::int32 var_8 = 2;
        const wp::int32 var_9 = 0;
        const wp::int32 var_10 = 3;
        const wp::int32 var_11 = 0;
        //---------
        // forward
        // def init_triangle_collision_data_kernel(                                               <L 1311>
        // tri_index = wp.tid()                                                                   <L 1318>
        var_0 = builtin_tid1d();
        // triangle_colliding_vertices_count[tri_index] = 0                                       <L 1320>
        wp::array_store(var_triangle_colliding_vertices_count, var_0, var_1);
        // triangle_colliding_vertices_min_dist[tri_index] = query_radius                         <L 1321>
        wp::array_store(var_triangle_colliding_vertices_min_dist, var_0, var_query_radius);
        // if tri_index == 0:                                                                     <L 1323>
        var_3 = (var_0 == var_2);
        if (var_3) {
            // for i in range(4):                                                                 <L 1324>
            // resize_flags[i] = 0                                                                <L 1325>
            wp::array_store(var_resize_flags, var_4, var_5);
            wp::array_store(var_resize_flags, var_6, var_7);
            wp::array_store(var_resize_flags, var_8, var_9);
            wp::array_store(var_resize_flags, var_10, var_11);
        }
    }
}



extern "C" __global__ void init_triangle_collision_data_kernel_00997c3e_cuda_kernel_backward(
    wp::launch_bounds_t<1> dim,
    wp::float32 var_query_radius,
    wp::array_t<wp::int32> var_triangle_colliding_vertices_count,
    wp::array_t<wp::float32> var_triangle_colliding_vertices_min_dist,
    wp::array_t<wp::int32> var_resize_flags,
    wp::float32 adj_query_radius,
    wp::array_t<wp::int32> adj_triangle_colliding_vertices_count,
    wp::array_t<wp::float32> adj_triangle_colliding_vertices_min_dist,
    wp::array_t<wp::int32> adj_resize_flags)
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
        const wp::int32 var_1 = 0;
        const wp::int32 var_2 = 0;
        bool var_3;
        const wp::int32 var_4 = 0;
        const wp::int32 var_5 = 0;
        const wp::int32 var_6 = 1;
        const wp::int32 var_7 = 0;
        const wp::int32 var_8 = 2;
        const wp::int32 var_9 = 0;
        const wp::int32 var_10 = 3;
        const wp::int32 var_11 = 0;
        //---------
        // dual vars
        wp::int32 adj_0 = {};
        wp::int32 adj_1 = {};
        wp::int32 adj_2 = {};
        bool adj_3 = {};
        wp::int32 adj_4 = {};
        wp::int32 adj_5 = {};
        wp::int32 adj_6 = {};
        wp::int32 adj_7 = {};
        wp::int32 adj_8 = {};
        wp::int32 adj_9 = {};
        wp::int32 adj_10 = {};
        wp::int32 adj_11 = {};
        //---------
        // forward
        // def init_triangle_collision_data_kernel(                                               <L 1311>
        // tri_index = wp.tid()                                                                   <L 1318>
        var_0 = builtin_tid1d();
        // triangle_colliding_vertices_count[tri_index] = 0                                       <L 1320>
        // wp::array_store(var_triangle_colliding_vertices_count, var_0, var_1);
        // triangle_colliding_vertices_min_dist[tri_index] = query_radius                         <L 1321>
        // wp::array_store(var_triangle_colliding_vertices_min_dist, var_0, var_query_radius);
        // if tri_index == 0:                                                                     <L 1323>
        var_3 = (var_0 == var_2);
        if (var_3) {
            // for i in range(4):                                                                 <L 1324>
            // resize_flags[i] = 0                                                                <L 1325>
            // wp::array_store(var_resize_flags, var_4, var_5);
            // wp::array_store(var_resize_flags, var_6, var_7);
            // wp::array_store(var_resize_flags, var_8, var_9);
            // wp::array_store(var_resize_flags, var_10, var_11);
        }
        //---------
        // reverse
        if (var_3) {
            wp::adj_array_store(var_resize_flags, var_10, var_11, adj_resize_flags, adj_10, adj_11);
            wp::adj_array_store(var_resize_flags, var_8, var_9, adj_resize_flags, adj_8, adj_9);
            wp::adj_array_store(var_resize_flags, var_6, var_7, adj_resize_flags, adj_6, adj_7);
            wp::adj_array_store(var_resize_flags, var_4, var_5, adj_resize_flags, adj_4, adj_5);
            // adj: resize_flags[i] = 0                                                           <L 1325>
            // adj: for i in range(4):                                                            <L 1324>
        }
        // adj: if tri_index == 0:                                                                <L 1323>
        wp::adj_array_store(var_triangle_colliding_vertices_min_dist, var_0, var_query_radius, adj_triangle_colliding_vertices_min_dist, adj_0, adj_query_radius);
        // adj: triangle_colliding_vertices_min_dist[tri_index] = query_radius                    <L 1321>
        wp::adj_array_store(var_triangle_colliding_vertices_count, var_0, var_1, adj_triangle_colliding_vertices_count, adj_0, adj_1);
        // adj: triangle_colliding_vertices_count[tri_index] = 0                                  <L 1320>
        // adj: tri_index = wp.tid()                                                              <L 1318>
        // adj: def init_triangle_collision_data_kernel(                                          <L 1311>
        continue;
    }
}



extern "C" __global__ void triangle_triangle_collision_detection_kernel_cdc841ad_cuda_kernel_forward(
    wp::launch_bounds_t<1> dim,
    wp::uint64 var_bvh_id,
    wp::array_t<wp::vec_t<3, wp::float32>> var_pos,
    wp::array_t<wp::int32> var_tri_indices,
    wp::array_t<wp::int32> var_triangle_intersecting_triangles_offsets,
    wp::array_t<wp::int32> var_triangle_intersecting_triangles,
    wp::array_t<wp::int32> var_triangle_intersecting_triangles_count,
    wp::array_t<wp::int32> var_resize_flags)
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
        const wp::int32 var_1 = 0;
        wp::int32* var_2;
        wp::int32 var_3;
        wp::int32 var_4;
        const wp::int32 var_5 = 1;
        wp::int32* var_6;
        wp::int32 var_7;
        wp::int32 var_8;
        const wp::int32 var_9 = 2;
        wp::int32* var_10;
        wp::int32 var_11;
        wp::int32 var_12;
        wp::vec_t<3, wp::float32>* var_13;
        wp::vec_t<3, wp::float32> var_14;
        wp::vec_t<3, wp::float32> var_15;
        wp::vec_t<3, wp::float32>* var_16;
        wp::vec_t<3, wp::float32> var_17;
        wp::vec_t<3, wp::float32> var_18;
        wp::vec_t<3, wp::float32>* var_19;
        wp::vec_t<3, wp::float32> var_20;
        wp::vec_t<3, wp::float32> var_21;
        wp::vec_t<3, wp::float32> var_22;
        wp::vec_t<3, wp::float32> var_23;
        wp::int32* var_24;
        wp::int32 var_25;
        wp::int32 var_26;
        const wp::int32 var_27 = 1;
        wp::int32 var_28;
        wp::int32* var_29;
        wp::int32 var_30;
        wp::int32 var_31;
        wp::bvh_query_t var_32;
        const wp::int32 var_33 = -1;
        const wp::int32 var_34 = 0;
        wp::int32 var_35;
        const wp::int32 var_36 = 0;
        wp::int32 var_37;
        bool var_38;
        const wp::float32 var_39 = INFINITY;
        const wp::int32 var_40 = 0;
        wp::int32* var_41;
        wp::int32 var_42;
        wp::int32 var_43;
        const wp::int32 var_44 = 1;
        wp::int32* var_45;
        wp::int32 var_46;
        wp::int32 var_47;
        const wp::int32 var_48 = 2;
        wp::int32* var_49;
        wp::int32 var_50;
        wp::int32 var_51;
        bool var_52;
        bool var_53;
        bool var_54;
        bool var_55;
        wp::vec_t<3, wp::float32>* var_56;
        wp::vec_t<3, wp::float32> var_57;
        wp::vec_t<3, wp::float32> var_58;
        wp::vec_t<3, wp::float32>* var_59;
        wp::vec_t<3, wp::float32> var_60;
        wp::vec_t<3, wp::float32> var_61;
        wp::vec_t<3, wp::float32>* var_62;
        wp::vec_t<3, wp::float32> var_63;
        wp::vec_t<3, wp::float32> var_64;
        wp::int32 var_65;
        bool var_66;
        wp::int32 var_67;
        const wp::int32 var_68 = 1;
        const wp::int32 var_69 = 3;
        const wp::int32 var_70 = 1;
        wp::int32 var_71;
        wp::int32 var_72;
        //---------
        // forward
        // def triangle_triangle_collision_detection_kernel(                                      <L 1643>
        // tri_index = wp.tid()                                                                   <L 1653>
        var_0 = builtin_tid1d();
        // t1_v1 = tri_indices[tri_index, 0]                                                      <L 1654>
        var_2 = wp::address(var_tri_indices, var_0, var_1);
        var_4 = wp::load(var_2);
        var_3 = wp::copy(var_4);
        // t1_v2 = tri_indices[tri_index, 1]                                                      <L 1655>
        var_6 = wp::address(var_tri_indices, var_0, var_5);
        var_8 = wp::load(var_6);
        var_7 = wp::copy(var_8);
        // t1_v3 = tri_indices[tri_index, 2]                                                      <L 1656>
        var_10 = wp::address(var_tri_indices, var_0, var_9);
        var_12 = wp::load(var_10);
        var_11 = wp::copy(var_12);
        // v1 = pos[t1_v1]                                                                        <L 1658>
        var_13 = wp::address(var_pos, var_3);
        var_15 = wp::load(var_13);
        var_14 = wp::copy(var_15);
        // v2 = pos[t1_v2]                                                                        <L 1659>
        var_16 = wp::address(var_pos, var_7);
        var_18 = wp::load(var_16);
        var_17 = wp::copy(var_18);
        // v3 = pos[t1_v3]                                                                        <L 1660>
        var_19 = wp::address(var_pos, var_11);
        var_21 = wp::load(var_19);
        var_20 = wp::copy(var_21);
        // lower, upper = compute_tri_aabb(v1, v2, v3)                                            <L 1662>
        compute_tri_aabb_0(var_14, var_17, var_20, var_22, var_23);
        // buffer_offset = triangle_intersecting_triangles_offsets[tri_index]                     <L 1664>
        var_24 = wp::address(var_triangle_intersecting_triangles_offsets, var_0);
        var_26 = wp::load(var_24);
        var_25 = wp::copy(var_26);
        // buffer_size = triangle_intersecting_triangles_offsets[tri_index + 1] - buffer_offset       <L 1665>
        var_28 = wp::add(var_0, var_27);
        var_29 = wp::address(var_triangle_intersecting_triangles_offsets, var_28);
        var_31 = wp::load(var_29);
        var_30 = wp::sub(var_31, var_25);
        // query = wp.bvh_query_aabb(bvh_id, lower, upper)                                        <L 1667>
        var_32 = wp::bvh_query_aabb(var_bvh_id, var_22, var_23, var_33);
        // tri_index_2 = wp.int32(0)                                                              <L 1668>
        var_35 = wp::int32(var_34);
        // intersection_count = wp.int32(0)                                                       <L 1669>
        var_37 = wp::int32(var_36);
        // while wp.bvh_query_next(query, tri_index_2):                                           <L 1670>
        start_while_0:;
        var_38 = wp::bvh_query_next(var_32, var_35, var_39);
        if ((var_38) == false) goto end_while_0;
            // t2_v1 = tri_indices[tri_index_2, 0]                                                <L 1671>
            var_41 = wp::address(var_tri_indices, var_35, var_40);
            var_43 = wp::load(var_41);
            var_42 = wp::copy(var_43);
            // t2_v2 = tri_indices[tri_index_2, 1]                                                <L 1672>
            var_45 = wp::address(var_tri_indices, var_35, var_44);
            var_47 = wp::load(var_45);
            var_46 = wp::copy(var_47);
            // t2_v3 = tri_indices[tri_index_2, 2]                                                <L 1673>
            var_49 = wp::address(var_tri_indices, var_35, var_48);
            var_51 = wp::load(var_49);
            var_50 = wp::copy(var_51);
            // if (                                                                               <L 1676>
            // vertex_adjacent_to_triangle(t1_v1, t2_v1, t2_v2, t2_v3)                            <L 1677>
            var_53 = vertex_adjacent_to_triangle_0(var_3, var_42, var_46, var_50);
            var_52 = var_53;
            if (!var_52) {
                // or vertex_adjacent_to_triangle(t1_v2, t2_v1, t2_v2, t2_v3)                     <L 1678>
                var_54 = vertex_adjacent_to_triangle_0(var_7, var_42, var_46, var_50);
                var_52 = var_52 || var_54;
            }
            if (!var_52) {
                // or vertex_adjacent_to_triangle(t1_v3, t2_v1, t2_v2, t2_v3)                     <L 1679>
                var_55 = vertex_adjacent_to_triangle_0(var_11, var_42, var_46, var_50);
                var_52 = var_52 || var_55;
            }
            if (var_52) {
                // continue                                                                       <L 1681>
                goto start_while_0;
            }
            // u1 = pos[t2_v1]                                                                    <L 1683>
            var_56 = wp::address(var_pos, var_42);
            var_58 = wp::load(var_56);
            var_57 = wp::copy(var_58);
            // u2 = pos[t2_v2]                                                                    <L 1684>
            var_59 = wp::address(var_pos, var_46);
            var_61 = wp::load(var_59);
            var_60 = wp::copy(var_61);
            // u3 = pos[t2_v3]                                                                    <L 1685>
            var_62 = wp::address(var_pos, var_50);
            var_64 = wp::load(var_62);
            var_63 = wp::copy(var_64);
            // if wp.intersect_tri_tri(v1, v2, v3, u1, u2, u3):                                   <L 1687>
            var_65 = wp::intersect_tri_tri(var_14, var_17, var_20, var_57, var_60, var_63);
            if (var_65) {
                // if intersection_count < buffer_size:                                           <L 1688>
                var_66 = (var_37 < var_30);
                if (var_66) {
                    // triangle_intersecting_triangles[buffer_offset + intersection_count] = tri_index_2       <L 1689>
                    var_67 = wp::add(var_25, var_37);
                    wp::array_store(var_triangle_intersecting_triangles, var_67, var_35);
                }
                if (!var_66) {
                    // resize_flags[TRI_TRI_COLLISION_BUFFER_OVERFLOW_INDEX] = 1                  <L 1691>
                    wp::array_store(var_resize_flags, var_69, var_68);
                }
                // intersection_count = intersection_count + 1                                    <L 1692>
                var_71 = wp::add(var_37, var_70);
            }
            var_72 = wp::where(var_65, var_71, var_37);
            wp::assign(var_37, var_72);
        goto start_while_0;
        end_while_0:;
        // triangle_intersecting_triangles_count[tri_index] = intersection_count                  <L 1694>
        wp::array_store(var_triangle_intersecting_triangles_count, var_0, var_37);
    }
}



extern "C" __global__ void triangle_triangle_collision_detection_kernel_cdc841ad_cuda_kernel_backward(
    wp::launch_bounds_t<1> dim,
    wp::uint64 var_bvh_id,
    wp::array_t<wp::vec_t<3, wp::float32>> var_pos,
    wp::array_t<wp::int32> var_tri_indices,
    wp::array_t<wp::int32> var_triangle_intersecting_triangles_offsets,
    wp::array_t<wp::int32> var_triangle_intersecting_triangles,
    wp::array_t<wp::int32> var_triangle_intersecting_triangles_count,
    wp::array_t<wp::int32> var_resize_flags,
    wp::uint64 adj_bvh_id,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_pos,
    wp::array_t<wp::int32> adj_tri_indices,
    wp::array_t<wp::int32> adj_triangle_intersecting_triangles_offsets,
    wp::array_t<wp::int32> adj_triangle_intersecting_triangles,
    wp::array_t<wp::int32> adj_triangle_intersecting_triangles_count,
    wp::array_t<wp::int32> adj_resize_flags)
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
        const wp::int32 var_1 = 0;
        wp::int32* var_2;
        wp::int32 var_3;
        wp::int32 var_4;
        const wp::int32 var_5 = 1;
        wp::int32* var_6;
        wp::int32 var_7;
        wp::int32 var_8;
        const wp::int32 var_9 = 2;
        wp::int32* var_10;
        wp::int32 var_11;
        wp::int32 var_12;
        wp::vec_t<3, wp::float32>* var_13;
        wp::vec_t<3, wp::float32> var_14;
        wp::vec_t<3, wp::float32> var_15;
        wp::vec_t<3, wp::float32>* var_16;
        wp::vec_t<3, wp::float32> var_17;
        wp::vec_t<3, wp::float32> var_18;
        wp::vec_t<3, wp::float32>* var_19;
        wp::vec_t<3, wp::float32> var_20;
        wp::vec_t<3, wp::float32> var_21;
        wp::vec_t<3, wp::float32> var_22;
        wp::vec_t<3, wp::float32> var_23;
        wp::int32* var_24;
        wp::int32 var_25;
        wp::int32 var_26;
        const wp::int32 var_27 = 1;
        wp::int32 var_28;
        wp::int32* var_29;
        wp::int32 var_30;
        wp::int32 var_31;
        wp::bvh_query_t var_32;
        const wp::int32 var_33 = -1;
        const wp::int32 var_34 = 0;
        wp::int32 var_35;
        const wp::int32 var_36 = 0;
        wp::int32 var_37;
        bool var_38;
        const wp::float32 var_39 = INFINITY;
        const wp::int32 var_40 = 0;
        wp::int32* var_41;
        wp::int32 var_42;
        wp::int32 var_43;
        const wp::int32 var_44 = 1;
        wp::int32* var_45;
        wp::int32 var_46;
        wp::int32 var_47;
        const wp::int32 var_48 = 2;
        wp::int32* var_49;
        wp::int32 var_50;
        wp::int32 var_51;
        bool var_52;
        bool var_53;
        bool var_54;
        bool var_55;
        wp::vec_t<3, wp::float32>* var_56;
        wp::vec_t<3, wp::float32> var_57;
        wp::vec_t<3, wp::float32> var_58;
        wp::vec_t<3, wp::float32>* var_59;
        wp::vec_t<3, wp::float32> var_60;
        wp::vec_t<3, wp::float32> var_61;
        wp::vec_t<3, wp::float32>* var_62;
        wp::vec_t<3, wp::float32> var_63;
        wp::vec_t<3, wp::float32> var_64;
        wp::int32 var_65;
        bool var_66;
        wp::int32 var_67;
        const wp::int32 var_68 = 1;
        const wp::int32 var_69 = 3;
        const wp::int32 var_70 = 1;
        wp::int32 var_71;
        wp::int32 var_72;
        //---------
        // dual vars
        wp::int32 adj_0 = {};
        wp::int32 adj_1 = {};
        wp::int32 adj_2 = {};
        wp::int32 adj_3 = {};
        wp::int32 adj_4 = {};
        wp::int32 adj_5 = {};
        wp::int32 adj_6 = {};
        wp::int32 adj_7 = {};
        wp::int32 adj_8 = {};
        wp::int32 adj_9 = {};
        wp::int32 adj_10 = {};
        wp::int32 adj_11 = {};
        wp::int32 adj_12 = {};
        wp::vec_t<3, wp::float32> adj_13 = {};
        wp::vec_t<3, wp::float32> adj_14 = {};
        wp::vec_t<3, wp::float32> adj_15 = {};
        wp::vec_t<3, wp::float32> adj_16 = {};
        wp::vec_t<3, wp::float32> adj_17 = {};
        wp::vec_t<3, wp::float32> adj_18 = {};
        wp::vec_t<3, wp::float32> adj_19 = {};
        wp::vec_t<3, wp::float32> adj_20 = {};
        wp::vec_t<3, wp::float32> adj_21 = {};
        wp::vec_t<3, wp::float32> adj_22 = {};
        wp::vec_t<3, wp::float32> adj_23 = {};
        wp::int32 adj_24 = {};
        wp::int32 adj_25 = {};
        wp::int32 adj_26 = {};
        wp::int32 adj_27 = {};
        wp::int32 adj_28 = {};
        wp::int32 adj_29 = {};
        wp::int32 adj_30 = {};
        wp::int32 adj_31 = {};
        wp::bvh_query_t adj_32 = {};
        wp::int32 adj_33 = {};
        wp::int32 adj_34 = {};
        wp::int32 adj_35 = {};
        wp::int32 adj_36 = {};
        wp::int32 adj_37 = {};
        bool adj_38 = {};
        wp::float32 adj_39 = {};
        wp::int32 adj_40 = {};
        wp::int32 adj_41 = {};
        wp::int32 adj_42 = {};
        wp::int32 adj_43 = {};
        wp::int32 adj_44 = {};
        wp::int32 adj_45 = {};
        wp::int32 adj_46 = {};
        wp::int32 adj_47 = {};
        wp::int32 adj_48 = {};
        wp::int32 adj_49 = {};
        wp::int32 adj_50 = {};
        wp::int32 adj_51 = {};
        bool adj_52 = {};
        bool adj_53 = {};
        bool adj_54 = {};
        bool adj_55 = {};
        wp::vec_t<3, wp::float32> adj_56 = {};
        wp::vec_t<3, wp::float32> adj_57 = {};
        wp::vec_t<3, wp::float32> adj_58 = {};
        wp::vec_t<3, wp::float32> adj_59 = {};
        wp::vec_t<3, wp::float32> adj_60 = {};
        wp::vec_t<3, wp::float32> adj_61 = {};
        wp::vec_t<3, wp::float32> adj_62 = {};
        wp::vec_t<3, wp::float32> adj_63 = {};
        wp::vec_t<3, wp::float32> adj_64 = {};
        wp::int32 adj_65 = {};
        bool adj_66 = {};
        wp::int32 adj_67 = {};
        wp::int32 adj_68 = {};
        wp::int32 adj_69 = {};
        wp::int32 adj_70 = {};
        wp::int32 adj_71 = {};
        wp::int32 adj_72 = {};
        //---------
        // forward
        // def triangle_triangle_collision_detection_kernel(                                      <L 1643>
        // tri_index = wp.tid()                                                                   <L 1653>
        var_0 = builtin_tid1d();
        // t1_v1 = tri_indices[tri_index, 0]                                                      <L 1654>
        var_2 = wp::address(var_tri_indices, var_0, var_1);
        var_4 = wp::load(var_2);
        var_3 = wp::copy(var_4);
        // t1_v2 = tri_indices[tri_index, 1]                                                      <L 1655>
        var_6 = wp::address(var_tri_indices, var_0, var_5);
        var_8 = wp::load(var_6);
        var_7 = wp::copy(var_8);
        // t1_v3 = tri_indices[tri_index, 2]                                                      <L 1656>
        var_10 = wp::address(var_tri_indices, var_0, var_9);
        var_12 = wp::load(var_10);
        var_11 = wp::copy(var_12);
        // v1 = pos[t1_v1]                                                                        <L 1658>
        var_13 = wp::address(var_pos, var_3);
        var_15 = wp::load(var_13);
        var_14 = wp::copy(var_15);
        // v2 = pos[t1_v2]                                                                        <L 1659>
        var_16 = wp::address(var_pos, var_7);
        var_18 = wp::load(var_16);
        var_17 = wp::copy(var_18);
        // v3 = pos[t1_v3]                                                                        <L 1660>
        var_19 = wp::address(var_pos, var_11);
        var_21 = wp::load(var_19);
        var_20 = wp::copy(var_21);
        // lower, upper = compute_tri_aabb(v1, v2, v3)                                            <L 1662>
        compute_tri_aabb_0(var_14, var_17, var_20, var_22, var_23);
        // buffer_offset = triangle_intersecting_triangles_offsets[tri_index]                     <L 1664>
        var_24 = wp::address(var_triangle_intersecting_triangles_offsets, var_0);
        var_26 = wp::load(var_24);
        var_25 = wp::copy(var_26);
        // buffer_size = triangle_intersecting_triangles_offsets[tri_index + 1] - buffer_offset       <L 1665>
        var_28 = wp::add(var_0, var_27);
        var_29 = wp::address(var_triangle_intersecting_triangles_offsets, var_28);
        var_31 = wp::load(var_29);
        var_30 = wp::sub(var_31, var_25);
        // query = wp.bvh_query_aabb(bvh_id, lower, upper)                                        <L 1667>
        var_32 = wp::bvh_query_aabb(var_bvh_id, var_22, var_23, var_33);
        // tri_index_2 = wp.int32(0)                                                              <L 1668>
        var_35 = wp::int32(var_34);
        // intersection_count = wp.int32(0)                                                       <L 1669>
        var_37 = wp::int32(var_36);
        // while wp.bvh_query_next(query, tri_index_2):                                           <L 1670>
        // triangle_intersecting_triangles_count[tri_index] = intersection_count                  <L 1694>
        // wp::array_store(var_triangle_intersecting_triangles_count, var_0, var_37);
        //---------
        // reverse
        wp::adj_array_store(var_triangle_intersecting_triangles_count, var_0, var_37, adj_triangle_intersecting_triangles_count, adj_0, adj_37);
        // adj: triangle_intersecting_triangles_count[tri_index] = intersection_count             <L 1694>
        start_while_0:;
        var_38 = wp::bvh_query_next(var_32, var_35, var_39);
        if ((var_38) == false) goto end_while_0;
        adj_40 = {};
        adj_41 = {};
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
        adj_64 = {};
        adj_65 = {};
        adj_66 = {};
        adj_67 = {};
        adj_68 = {};
        adj_69 = {};
        adj_70 = {};
        adj_71 = {};
        adj_72 = {};
            // t2_v1 = tri_indices[tri_index_2, 0]                                                <L 1671>
            var_41 = wp::address(var_tri_indices, var_35, var_40);
            var_43 = wp::load(var_41);
            var_42 = wp::copy(var_43);
            // t2_v2 = tri_indices[tri_index_2, 1]                                                <L 1672>
            var_45 = wp::address(var_tri_indices, var_35, var_44);
            var_47 = wp::load(var_45);
            var_46 = wp::copy(var_47);
            // t2_v3 = tri_indices[tri_index_2, 2]                                                <L 1673>
            var_49 = wp::address(var_tri_indices, var_35, var_48);
            var_51 = wp::load(var_49);
            var_50 = wp::copy(var_51);
            // if (                                                                               <L 1676>
            // vertex_adjacent_to_triangle(t1_v1, t2_v1, t2_v2, t2_v3)                            <L 1677>
            var_53 = vertex_adjacent_to_triangle_0(var_3, var_42, var_46, var_50);
            var_52 = var_53;
            if (!var_52) {
                // or vertex_adjacent_to_triangle(t1_v2, t2_v1, t2_v2, t2_v3)                     <L 1678>
                var_54 = vertex_adjacent_to_triangle_0(var_7, var_42, var_46, var_50);
                var_52 = var_52 || var_54;
            }
            if (!var_52) {
                // or vertex_adjacent_to_triangle(t1_v3, t2_v1, t2_v2, t2_v3)                     <L 1679>
                var_55 = vertex_adjacent_to_triangle_0(var_11, var_42, var_46, var_50);
                var_52 = var_52 || var_55;
            }
            if (var_52) {
                // continue                                                                       <L 1681>
                goto start_while_0;
            }
            // u1 = pos[t2_v1]                                                                    <L 1683>
            var_56 = wp::address(var_pos, var_42);
            var_58 = wp::load(var_56);
            var_57 = wp::copy(var_58);
            // u2 = pos[t2_v2]                                                                    <L 1684>
            var_59 = wp::address(var_pos, var_46);
            var_61 = wp::load(var_59);
            var_60 = wp::copy(var_61);
            // u3 = pos[t2_v3]                                                                    <L 1685>
            var_62 = wp::address(var_pos, var_50);
            var_64 = wp::load(var_62);
            var_63 = wp::copy(var_64);
            // if wp.intersect_tri_tri(v1, v2, v3, u1, u2, u3):                                   <L 1687>
            var_65 = wp::intersect_tri_tri(var_14, var_17, var_20, var_57, var_60, var_63);
            if (var_65) {
                // if intersection_count < buffer_size:                                           <L 1688>
                var_66 = (var_37 < var_30);
                if (var_66) {
                    // triangle_intersecting_triangles[buffer_offset + intersection_count] = tri_index_2       <L 1689>
                    var_67 = wp::add(var_25, var_37);
                    // wp::array_store(var_triangle_intersecting_triangles, var_67, var_35);
                }
                if (!var_66) {
                    // resize_flags[TRI_TRI_COLLISION_BUFFER_OVERFLOW_INDEX] = 1                  <L 1691>
                    // wp::array_store(var_resize_flags, var_69, var_68);
                }
                // intersection_count = intersection_count + 1                                    <L 1692>
                var_71 = wp::add(var_37, var_70);
            }
            var_72 = wp::where(var_65, var_71, var_37);
            wp::assign(var_37, var_72);
            wp::adj_assign(var_37, var_72, adj_37, adj_72);
            wp::adj_where(var_65, var_71, var_37, adj_65, adj_71, adj_37, adj_72);
            if (var_65) {
                wp::adj_add(var_37, var_70, adj_37, adj_70, adj_71);
                // adj: intersection_count = intersection_count + 1                               <L 1692>
                if (!var_66) {
                    wp::adj_array_store(var_resize_flags, var_69, var_68, adj_resize_flags, adj_69, adj_68);
                    // adj: resize_flags[TRI_TRI_COLLISION_BUFFER_OVERFLOW_INDEX] = 1             <L 1691>
                }
                if (var_66) {
                    wp::adj_array_store(var_triangle_intersecting_triangles, var_67, var_35, adj_triangle_intersecting_triangles, adj_67, adj_35);
                    wp::adj_add(var_25, var_37, adj_25, adj_37, adj_67);
                    // adj: triangle_intersecting_triangles[buffer_offset + intersection_count] = tri_index_2  <L 1689>
                }
                // adj: if intersection_count < buffer_size:                                      <L 1688>
            }
            // adj: if wp.intersect_tri_tri(v1, v2, v3, u1, u2, u3):                              <L 1687>
            wp::adj_copy(var_64, adj_62, adj_63);
            wp::adj_address(var_pos, var_50, adj_pos, adj_50, adj_62);
            // adj: u3 = pos[t2_v3]                                                               <L 1685>
            wp::adj_copy(var_61, adj_59, adj_60);
            wp::adj_address(var_pos, var_46, adj_pos, adj_46, adj_59);
            // adj: u2 = pos[t2_v2]                                                               <L 1684>
            wp::adj_copy(var_58, adj_56, adj_57);
            wp::adj_address(var_pos, var_42, adj_pos, adj_42, adj_56);
            // adj: u1 = pos[t2_v1]                                                               <L 1683>
            if (var_52) {
                // adj: continue                                                                  <L 1681>
            }
            if (!var_52) {
                adj_vertex_adjacent_to_triangle_0(var_11, var_42, var_46, var_50, adj_11, adj_42, adj_46, adj_50, adj_55);
                // adj: or vertex_adjacent_to_triangle(t1_v3, t2_v1, t2_v2, t2_v3)                <L 1679>
            }
            if (!var_52) {
                adj_vertex_adjacent_to_triangle_0(var_7, var_42, var_46, var_50, adj_7, adj_42, adj_46, adj_50, adj_54);
                // adj: or vertex_adjacent_to_triangle(t1_v2, t2_v1, t2_v2, t2_v3)                <L 1678>
            }
            adj_vertex_adjacent_to_triangle_0(var_3, var_42, var_46, var_50, adj_3, adj_42, adj_46, adj_50, adj_53);
            // adj: vertex_adjacent_to_triangle(t1_v1, t2_v1, t2_v2, t2_v3)                       <L 1677>
            // adj: if (                                                                          <L 1676>
            wp::adj_copy(var_51, adj_49, adj_50);
            wp::adj_address(var_tri_indices, var_35, var_48, adj_tri_indices, adj_35, adj_48, adj_49);
            // adj: t2_v3 = tri_indices[tri_index_2, 2]                                           <L 1673>
            wp::adj_copy(var_47, adj_45, adj_46);
            wp::adj_address(var_tri_indices, var_35, var_44, adj_tri_indices, adj_35, adj_44, adj_45);
            // adj: t2_v2 = tri_indices[tri_index_2, 1]                                           <L 1672>
            wp::adj_copy(var_43, adj_41, adj_42);
            wp::adj_address(var_tri_indices, var_35, var_40, adj_tri_indices, adj_35, adj_40, adj_41);
            // adj: t2_v1 = tri_indices[tri_index_2, 0]                                           <L 1671>
        goto start_while_0;
        end_while_0:;
        // adj: while wp.bvh_query_next(query, tri_index_2):                                      <L 1670>
        // adj: intersection_count = wp.int32(0)                                                  <L 1669>
        // adj: tri_index_2 = wp.int32(0)                                                         <L 1668>
        // adj: query = wp.bvh_query_aabb(bvh_id, lower, upper)                                   <L 1667>
        wp::adj_sub(var_31, var_25, adj_29, adj_25, adj_30);
        wp::adj_address(var_triangle_intersecting_triangles_offsets, var_28, adj_triangle_intersecting_triangles_offsets, adj_28, adj_29);
        wp::adj_add(var_0, var_27, adj_0, adj_27, adj_28);
        // adj: buffer_size = triangle_intersecting_triangles_offsets[tri_index + 1] - buffer_offset  <L 1665>
        wp::adj_copy(var_26, adj_24, adj_25);
        wp::adj_address(var_triangle_intersecting_triangles_offsets, var_0, adj_triangle_intersecting_triangles_offsets, adj_0, adj_24);
        // adj: buffer_offset = triangle_intersecting_triangles_offsets[tri_index]                <L 1664>
        adj_compute_tri_aabb_0(var_14, var_17, var_20, var_22, var_23, adj_14, adj_17, adj_20, adj_22, adj_23);
        // adj: lower, upper = compute_tri_aabb(v1, v2, v3)                                       <L 1662>
        wp::adj_copy(var_21, adj_19, adj_20);
        wp::adj_address(var_pos, var_11, adj_pos, adj_11, adj_19);
        // adj: v3 = pos[t1_v3]                                                                   <L 1660>
        wp::adj_copy(var_18, adj_16, adj_17);
        wp::adj_address(var_pos, var_7, adj_pos, adj_7, adj_16);
        // adj: v2 = pos[t1_v2]                                                                   <L 1659>
        wp::adj_copy(var_15, adj_13, adj_14);
        wp::adj_address(var_pos, var_3, adj_pos, adj_3, adj_13);
        // adj: v1 = pos[t1_v1]                                                                   <L 1658>
        wp::adj_copy(var_12, adj_10, adj_11);
        wp::adj_address(var_tri_indices, var_0, var_9, adj_tri_indices, adj_0, adj_9, adj_10);
        // adj: t1_v3 = tri_indices[tri_index, 2]                                                 <L 1656>
        wp::adj_copy(var_8, adj_6, adj_7);
        wp::adj_address(var_tri_indices, var_0, var_5, adj_tri_indices, adj_0, adj_5, adj_6);
        // adj: t1_v2 = tri_indices[tri_index, 1]                                                 <L 1655>
        wp::adj_copy(var_4, adj_2, adj_3);
        wp::adj_address(var_tri_indices, var_0, var_1, adj_tri_indices, adj_0, adj_1, adj_2);
        // adj: t1_v1 = tri_indices[tri_index, 0]                                                 <L 1654>
        // adj: tri_index = wp.tid()                                                              <L 1653>
        // adj: def triangle_triangle_collision_detection_kernel(                                 <L 1643>
        continue;
    }
}



extern "C" __global__ void compute_tri_groups_fe9dd4fd_cuda_kernel_forward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::int32> var_tri_indices,
    wp::array_t<wp::int32> var_particle_world,
    wp::int32 var_world_count,
    wp::array_t<wp::int32> var_groups)
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
        const wp::int32 var_1 = 0;
        wp::int32* var_2;
        wp::int32* var_3;
        wp::int32 var_4;
        wp::int32 var_5;
        wp::int32 var_6;
        const wp::int32 var_7 = 0;
        bool var_8;
        wp::int32 var_9;
        wp::int32 var_10;
        //---------
        // forward
        // def compute_tri_groups(                                                                <L 1254>
        // t_id = wp.tid()                                                                        <L 1264>
        var_0 = builtin_tid1d();
        // world_index = particle_world[tri_indices[t_id, 0]]                                     <L 1266>
        var_2 = wp::address(var_tri_indices, var_0, var_1);
        var_4 = wp::load(var_2);
        var_3 = wp::address(var_particle_world, var_4);
        var_6 = wp::load(var_3);
        var_5 = wp::copy(var_6);
        // if world_index < 0:                                                                    <L 1267>
        var_8 = (var_5 < var_7);
        if (var_8) {
            // world_index = world_count                                                          <L 1268>
            var_9 = wp::copy(var_world_count);
        }
        var_10 = wp::where(var_8, var_9, var_5);
        // groups[t_id] = world_index                                                             <L 1269>
        wp::array_store(var_groups, var_0, var_10);
    }
}



extern "C" __global__ void compute_tri_groups_fe9dd4fd_cuda_kernel_backward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::int32> var_tri_indices,
    wp::array_t<wp::int32> var_particle_world,
    wp::int32 var_world_count,
    wp::array_t<wp::int32> var_groups,
    wp::array_t<wp::int32> adj_tri_indices,
    wp::array_t<wp::int32> adj_particle_world,
    wp::int32 adj_world_count,
    wp::array_t<wp::int32> adj_groups)
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
        const wp::int32 var_1 = 0;
        wp::int32* var_2;
        wp::int32* var_3;
        wp::int32 var_4;
        wp::int32 var_5;
        wp::int32 var_6;
        const wp::int32 var_7 = 0;
        bool var_8;
        wp::int32 var_9;
        wp::int32 var_10;
        //---------
        // dual vars
        wp::int32 adj_0 = {};
        wp::int32 adj_1 = {};
        wp::int32 adj_2 = {};
        wp::int32 adj_3 = {};
        wp::int32 adj_4 = {};
        wp::int32 adj_5 = {};
        wp::int32 adj_6 = {};
        wp::int32 adj_7 = {};
        bool adj_8 = {};
        wp::int32 adj_9 = {};
        wp::int32 adj_10 = {};
        //---------
        // forward
        // def compute_tri_groups(                                                                <L 1254>
        // t_id = wp.tid()                                                                        <L 1264>
        var_0 = builtin_tid1d();
        // world_index = particle_world[tri_indices[t_id, 0]]                                     <L 1266>
        var_2 = wp::address(var_tri_indices, var_0, var_1);
        var_4 = wp::load(var_2);
        var_3 = wp::address(var_particle_world, var_4);
        var_6 = wp::load(var_3);
        var_5 = wp::copy(var_6);
        // if world_index < 0:                                                                    <L 1267>
        var_8 = (var_5 < var_7);
        if (var_8) {
            // world_index = world_count                                                          <L 1268>
            var_9 = wp::copy(var_world_count);
        }
        var_10 = wp::where(var_8, var_9, var_5);
        // groups[t_id] = world_index                                                             <L 1269>
        // wp::array_store(var_groups, var_0, var_10);
        //---------
        // reverse
        wp::adj_array_store(var_groups, var_0, var_10, adj_groups, adj_0, adj_10);
        // adj: groups[t_id] = world_index                                                        <L 1269>
        wp::adj_where(var_8, var_9, var_5, adj_8, adj_9, adj_5, adj_10);
        if (var_8) {
            wp::adj_copy(var_world_count, adj_world_count, adj_9);
            // adj: world_index = world_count                                                     <L 1268>
        }
        // adj: if world_index < 0:                                                               <L 1267>
        wp::adj_copy(var_6, adj_3, adj_5);
        wp::adj_address(var_particle_world, var_4, adj_particle_world, adj_2, adj_3);
        wp::adj_address(var_tri_indices, var_0, var_1, adj_tri_indices, adj_0, adj_1, adj_2);
        // adj: world_index = particle_world[tri_indices[t_id, 0]]                                <L 1266>
        // adj: t_id = wp.tid()                                                                   <L 1264>
        // adj: def compute_tri_groups(                                                           <L 1254>
        continue;
    }
}



extern "C" __global__ void compute_edge_aabbs_ff9d2753_cuda_kernel_forward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::vec_t<3, wp::float32>> var_pos,
    wp::array_t<wp::int32> var_edge_indices,
    wp::array_t<wp::vec_t<3, wp::float32>> var_lower_bounds,
    wp::array_t<wp::vec_t<3, wp::float32>> var_upper_bounds)
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
        const wp::int32 var_1 = 2;
        wp::int32* var_2;
        wp::vec_t<3, wp::float32>* var_3;
        wp::int32 var_4;
        wp::vec_t<3, wp::float32> var_5;
        wp::vec_t<3, wp::float32> var_6;
        const wp::int32 var_7 = 3;
        wp::int32* var_8;
        wp::vec_t<3, wp::float32>* var_9;
        wp::int32 var_10;
        wp::vec_t<3, wp::float32> var_11;
        wp::vec_t<3, wp::float32> var_12;
        wp::vec_t<3, wp::float32> var_13;
        wp::vec_t<3, wp::float32> var_14;
        //---------
        // forward
        // def compute_edge_aabbs(                                                                <L 1238>
        // e_id = wp.tid()                                                                        <L 1244>
        var_0 = builtin_tid1d();
        // v1 = pos[edge_indices[e_id, 2]]                                                        <L 1246>
        var_2 = wp::address(var_edge_indices, var_0, var_1);
        var_4 = wp::load(var_2);
        var_3 = wp::address(var_pos, var_4);
        var_6 = wp::load(var_3);
        var_5 = wp::copy(var_6);
        // v2 = pos[edge_indices[e_id, 3]]                                                        <L 1247>
        var_8 = wp::address(var_edge_indices, var_0, var_7);
        var_10 = wp::load(var_8);
        var_9 = wp::address(var_pos, var_10);
        var_12 = wp::load(var_9);
        var_11 = wp::copy(var_12);
        // lower_bounds[e_id] = wp.min(v1, v2)                                                    <L 1249>
        var_13 = wp::min(var_5, var_11);
        wp::array_store(var_lower_bounds, var_0, var_13);
        // upper_bounds[e_id] = wp.max(v1, v2)                                                    <L 1250>
        var_14 = wp::max(var_5, var_11);
        wp::array_store(var_upper_bounds, var_0, var_14);
    }
}



extern "C" __global__ void compute_edge_aabbs_ff9d2753_cuda_kernel_backward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::vec_t<3, wp::float32>> var_pos,
    wp::array_t<wp::int32> var_edge_indices,
    wp::array_t<wp::vec_t<3, wp::float32>> var_lower_bounds,
    wp::array_t<wp::vec_t<3, wp::float32>> var_upper_bounds,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_pos,
    wp::array_t<wp::int32> adj_edge_indices,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_lower_bounds,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_upper_bounds)
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
        const wp::int32 var_1 = 2;
        wp::int32* var_2;
        wp::vec_t<3, wp::float32>* var_3;
        wp::int32 var_4;
        wp::vec_t<3, wp::float32> var_5;
        wp::vec_t<3, wp::float32> var_6;
        const wp::int32 var_7 = 3;
        wp::int32* var_8;
        wp::vec_t<3, wp::float32>* var_9;
        wp::int32 var_10;
        wp::vec_t<3, wp::float32> var_11;
        wp::vec_t<3, wp::float32> var_12;
        wp::vec_t<3, wp::float32> var_13;
        wp::vec_t<3, wp::float32> var_14;
        //---------
        // dual vars
        wp::int32 adj_0 = {};
        wp::int32 adj_1 = {};
        wp::int32 adj_2 = {};
        wp::vec_t<3, wp::float32> adj_3 = {};
        wp::int32 adj_4 = {};
        wp::vec_t<3, wp::float32> adj_5 = {};
        wp::vec_t<3, wp::float32> adj_6 = {};
        wp::int32 adj_7 = {};
        wp::int32 adj_8 = {};
        wp::vec_t<3, wp::float32> adj_9 = {};
        wp::int32 adj_10 = {};
        wp::vec_t<3, wp::float32> adj_11 = {};
        wp::vec_t<3, wp::float32> adj_12 = {};
        wp::vec_t<3, wp::float32> adj_13 = {};
        wp::vec_t<3, wp::float32> adj_14 = {};
        //---------
        // forward
        // def compute_edge_aabbs(                                                                <L 1238>
        // e_id = wp.tid()                                                                        <L 1244>
        var_0 = builtin_tid1d();
        // v1 = pos[edge_indices[e_id, 2]]                                                        <L 1246>
        var_2 = wp::address(var_edge_indices, var_0, var_1);
        var_4 = wp::load(var_2);
        var_3 = wp::address(var_pos, var_4);
        var_6 = wp::load(var_3);
        var_5 = wp::copy(var_6);
        // v2 = pos[edge_indices[e_id, 3]]                                                        <L 1247>
        var_8 = wp::address(var_edge_indices, var_0, var_7);
        var_10 = wp::load(var_8);
        var_9 = wp::address(var_pos, var_10);
        var_12 = wp::load(var_9);
        var_11 = wp::copy(var_12);
        // lower_bounds[e_id] = wp.min(v1, v2)                                                    <L 1249>
        var_13 = wp::min(var_5, var_11);
        // wp::array_store(var_lower_bounds, var_0, var_13);
        // upper_bounds[e_id] = wp.max(v1, v2)                                                    <L 1250>
        var_14 = wp::max(var_5, var_11);
        // wp::array_store(var_upper_bounds, var_0, var_14);
        //---------
        // reverse
        wp::adj_array_store(var_upper_bounds, var_0, var_14, adj_upper_bounds, adj_0, adj_14);
        wp::adj_max(var_5, var_11, adj_5, adj_11, adj_14);
        // adj: upper_bounds[e_id] = wp.max(v1, v2)                                               <L 1250>
        wp::adj_array_store(var_lower_bounds, var_0, var_13, adj_lower_bounds, adj_0, adj_13);
        wp::adj_min(var_5, var_11, adj_5, adj_11, adj_13);
        // adj: lower_bounds[e_id] = wp.min(v1, v2)                                               <L 1249>
        wp::adj_copy(var_12, adj_9, adj_11);
        wp::adj_address(var_pos, var_10, adj_pos, adj_8, adj_9);
        wp::adj_address(var_edge_indices, var_0, var_7, adj_edge_indices, adj_0, adj_7, adj_8);
        // adj: v2 = pos[edge_indices[e_id, 3]]                                                   <L 1247>
        wp::adj_copy(var_6, adj_3, adj_5);
        wp::adj_address(var_pos, var_4, adj_pos, adj_2, adj_3);
        wp::adj_address(var_edge_indices, var_0, var_1, adj_edge_indices, adj_0, adj_1, adj_2);
        // adj: v1 = pos[edge_indices[e_id, 2]]                                                   <L 1246>
        // adj: e_id = wp.tid()                                                                   <L 1244>
        // adj: def compute_edge_aabbs(                                                           <L 1238>
        continue;
    }
}



extern "C" __global__ void create_soft_contacts_b26277c8_cuda_kernel_forward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::vec_t<2, wp::int32>> var_soft_rigid_contact_pairs,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_q,
    wp::array_t<wp::float32> var_particle_radius,
    wp::array_t<wp::int32> var_particle_flags,
    wp::array_t<wp::int32> var_particle_world,
    wp::array_t<wp::transform_t<wp::float32>> var_body_q,
    wp::array_t<wp::transform_t<wp::float32>> var_shape_transform,
    wp::array_t<wp::int32> var_shape_body,
    wp::array_t<wp::int32> var_shape_type,
    wp::array_t<wp::vec_t<3, wp::float32>> var_shape_scale,
    wp::array_t<wp::uint64> var_shape_source_ptr,
    wp::array_t<wp::int32> var_shape_mesh_properties,
    wp::array_t<wp::int32> var_shape_world,
    wp::float32 var_margin,
    wp::array_t<wp::float32> var_shape_margin,
    wp::int32 var_soft_contact_max,
    wp::array_t<wp::int32> var_shape_flags,
    wp::array_t<wp::int32> var_shape_heightfield_index,
    wp::array_t<HeightfieldData_f2b8d59a> var_heightfield_data,
    wp::array_t<wp::float32> var_heightfield_elevations,
    wp::array_t<wp::int32> var_soft_contact_count,
    wp::array_t<wp::int32> var_soft_contact_particle,
    wp::array_t<wp::vec_t<3, wp::int32>> var_soft_contact_indices,
    wp::array_t<wp::vec_t<3, wp::float32>> var_soft_contact_barycentric,
    wp::array_t<wp::int32> var_soft_contact_shape,
    wp::array_t<wp::vec_t<3, wp::float32>> var_soft_contact_body_pos,
    wp::array_t<wp::vec_t<3, wp::float32>> var_soft_contact_body_vel,
    wp::array_t<wp::vec_t<3, wp::float32>> var_soft_contact_normal,
    wp::array_t<wp::int32> var_soft_contact_tids)
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
        const wp::int32 var_4 = 0;
        wp::int32 var_5;
        const wp::int32 var_6 = 1;
        wp::int32 var_7;
        wp::int32* var_8;
        const wp::int32 var_9 = 1;
        wp::int32 var_10;
        wp::int32 var_11;
        const wp::int32 var_12 = 0;
        bool var_13;
        wp::int32* var_14;
        const wp::int32 var_15 = 4;
        wp::int32 var_16;
        wp::int32 var_17;
        const wp::int32 var_18 = 0;
        bool var_19;
        wp::int32* var_20;
        wp::int32 var_21;
        wp::int32 var_22;
        wp::int32* var_23;
        wp::int32 var_24;
        wp::int32 var_25;
        bool var_26;
        const wp::int32 var_27 = -1;
        bool var_28;
        const wp::int32 var_29 = -1;
        bool var_30;
        bool var_31;
        wp::int32* var_32;
        wp::int32 var_33;
        wp::int32 var_34;
        wp::vec_t<3, wp::float32>* var_35;
        wp::vec_t<3, wp::float32> var_36;
        wp::vec_t<3, wp::float32> var_37;
        wp::float32* var_38;
        wp::float32 var_39;
        wp::float32 var_40;
        wp::transform_t<wp::float32> var_41;
        const wp::int32 var_42 = 0;
        bool var_43;
        wp::transform_t<wp::float32>* var_44;
        wp::transform_t<wp::float32> var_45;
        wp::transform_t<wp::float32> var_46;
        wp::transform_t<wp::float32> var_47;
        wp::transform_t<wp::float32>* var_48;
        wp::transform_t<wp::float32> var_49;
        wp::transform_t<wp::float32> var_50;
        wp::transform_t<wp::float32> var_51;
        wp::transform_t<wp::float32> var_52;
        wp::vec_t<3, wp::float32> var_53;
        wp::int32* var_54;
        wp::int32 var_55;
        wp::int32 var_56;
        wp::vec_t<3, wp::float32>* var_57;
        wp::vec_t<3, wp::float32> var_58;
        wp::vec_t<3, wp::float32> var_59;
        wp::shape_t* var_60;
        const wp::int32 var_61 = 0;
        wp::int32 var_62;
        wp::shape_t var_63;
        const wp::int32 var_64 = 0;
        bool var_65;
        wp::float32* var_66;
        wp::float32 var_67;
        const wp::float32 var_68 = 0.0;
        wp::float32 var_69;
        const wp::float32 var_70 = 1000000.0;
        wp::vec_t<3, wp::float32> var_71;
        wp::vec_t<3, wp::float32> var_72;
        const wp::int32 var_73 = 3;
        bool var_74;
        const wp::int32 var_75 = 0;
        wp::float32 var_76;
        wp::float32 var_77;
        const wp::int32 var_78 = 0;
        wp::float32 var_79;
        wp::vec_t<3, wp::float32> var_80;
        wp::float32 var_81;
        wp::vec_t<3, wp::float32> var_82;
        const wp::int32 var_83 = 7;
        bool var_84;
        const wp::int32 var_85 = 0;
        wp::float32 var_86;
        const wp::int32 var_87 = 1;
        wp::float32 var_88;
        const wp::int32 var_89 = 2;
        wp::float32 var_90;
        wp::float32 var_91;
        const wp::int32 var_92 = 0;
        wp::float32 var_93;
        const wp::int32 var_94 = 1;
        wp::float32 var_95;
        const wp::int32 var_96 = 2;
        wp::float32 var_97;
        wp::vec_t<3, wp::float32> var_98;
        wp::float32 var_99;
        wp::vec_t<3, wp::float32> var_100;
        const wp::int32 var_101 = 4;
        bool var_102;
        const wp::int32 var_103 = 0;
        wp::float32 var_104;
        const wp::int32 var_105 = 1;
        wp::float32 var_106;
        const wp::int32 var_107 = 2;
        const wp::int32 var_108 = 2;
        wp::int32 var_109;
        wp::float32 var_110;
        const wp::int32 var_111 = 0;
        wp::float32 var_112;
        const wp::int32 var_113 = 1;
        wp::float32 var_114;
        const wp::int32 var_115 = 2;
        const wp::int32 var_116 = 2;
        wp::int32 var_117;
        wp::vec_t<3, wp::float32> var_118;
        wp::float32 var_119;
        wp::vec_t<3, wp::float32> var_120;
        const wp::int32 var_121 = 6;
        bool var_122;
        const wp::int32 var_123 = 0;
        wp::float32 var_124;
        const wp::int32 var_125 = 1;
        wp::float32 var_126;
        const wp::int32 var_127 = 2;
        const wp::int32 var_128 = 2;
        wp::int32 var_129;
        wp::float32 var_130;
        const wp::float32 var_131 = -1.0;
        const wp::int32 var_132 = 0;
        wp::float32 var_133;
        const wp::int32 var_134 = 1;
        wp::float32 var_135;
        const wp::int32 var_136 = 2;
        const wp::int32 var_137 = 2;
        wp::int32 var_138;
        wp::vec_t<3, wp::float32> var_139;
        const wp::float32 var_140 = -1.0;
        wp::float32 var_141;
        wp::vec_t<3, wp::float32> var_142;
        const wp::int32 var_143 = 9;
        bool var_144;
        const wp::int32 var_145 = 0;
        wp::float32 var_146;
        const wp::int32 var_147 = 1;
        wp::float32 var_148;
        const wp::int32 var_149 = 2;
        const wp::int32 var_150 = 2;
        wp::int32 var_151;
        wp::float32 var_152;
        const wp::int32 var_153 = 0;
        wp::float32 var_154;
        const wp::int32 var_155 = 1;
        wp::float32 var_156;
        const wp::int32 var_157 = 2;
        const wp::int32 var_158 = 2;
        wp::int32 var_159;
        wp::vec_t<3, wp::float32> var_160;
        wp::float32 var_161;
        wp::vec_t<3, wp::float32> var_162;
        const wp::int32 var_163 = 5;
        bool var_164;
        wp::float32 var_165;
        wp::vec_t<3, wp::float32> var_166;
        wp::float32 var_167;
        wp::vec_t<3, wp::float32> var_168;
        bool var_169;
        const wp::int32 var_170 = 8;
        bool var_171;
        const wp::int32 var_172 = 10;
        bool var_173;
        wp::uint64* var_174;
        wp::uint64 var_175;
        wp::uint64 var_176;
        const wp::int32 var_177 = 0;
        wp::int32 var_178;
        const wp::float32 var_179 = 0.0;
        wp::float32 var_180;
        const wp::float32 var_181 = 0.0;
        wp::float32 var_182;
        const wp::float32 var_183 = 0.0;
        wp::float32 var_184;
        const wp::int32 var_185 = 0;
        wp::float32 var_186;
        wp::float32 var_187;
        const wp::int32 var_188 = 1;
        wp::float32 var_189;
        wp::float32 var_190;
        wp::float32 var_191;
        const wp::int32 var_192 = 2;
        wp::float32 var_193;
        wp::float32 var_194;
        wp::float32 var_195;
        wp::vec_t<3, wp::float32> var_196;
        wp::float32 var_197;
        wp::float32 var_198;
        wp::float32 var_199;
        wp::float32 var_200;
        wp::int32* var_201;
        wp::int32 var_202;
        wp::int32 var_203;
        wp::mesh_query_point_t var_204;
        bool* var_205;
        bool var_206;
        wp::float32* var_207;
        wp::float32 var_208;
        wp::float32 var_209;
        wp::int32* var_210;
        wp::int32 var_211;
        wp::int32 var_212;
        wp::float32* var_213;
        wp::float32 var_214;
        wp::float32 var_215;
        wp::float32* var_216;
        wp::float32 var_217;
        wp::float32 var_218;
        wp::vec_t<3, wp::float32> var_219;
        wp::vec_t<3, wp::float32> var_220;
        wp::vec_t<3, wp::float32> var_221;
        wp::vec_t<3, wp::float32> var_222;
        wp::vec_t<3, wp::float32> var_223;
        wp::float32 var_224;
        wp::float32 var_225;
        wp::vec_t<3, wp::float32> var_226;
        wp::vec_t<3, wp::float32> var_227;
        wp::vec_t<3, wp::float32> var_228;
        bool var_229;
        wp::float32 var_230;
        bool var_231;
        wp::vec_t<3, wp::float32> var_232;
        bool var_233;
        wp::vec_t<3, wp::float32> var_234;
        bool var_235;
        wp::int32 var_236;
        bool var_237;
        wp::float32 var_238;
        bool var_239;
        wp::float32 var_240;
        bool var_241;
        wp::float32 var_242;
        bool var_243;
        wp::float32 var_244;
        wp::vec_t<3, wp::float32> var_245;
        wp::vec_t<3, wp::float32> var_246;
        const wp::int32 var_247 = 1;
        bool var_248;
        const wp::int32 var_249 = 0;
        wp::float32 var_250;
        const wp::float32 var_251 = 0.5;
        wp::float32 var_252;
        const wp::int32 var_253 = 1;
        wp::float32 var_254;
        const wp::float32 var_255 = 0.5;
        wp::float32 var_256;
        wp::float32 var_257;
        const wp::float32 var_258 = 0.0;
        const wp::float32 var_259 = 0.0;
        const wp::float32 var_260 = 1.0;
        wp::vec_t<3, wp::float32> var_261;
        wp::float32 var_262;
        wp::vec_t<3, wp::float32> var_263;
        const wp::int32 var_264 = 2;
        bool var_265;
        wp::int32* var_266;
        HeightfieldData_f2b8d59a* var_267;
        wp::int32 var_268;
        HeightfieldData_f2b8d59a var_269;
        HeightfieldData_f2b8d59a var_270;
        wp::float32 var_271;
        wp::vec_t<3, wp::float32> var_272;
        wp::float32 var_273;
        wp::vec_t<3, wp::float32> var_274;
        wp::float32 var_275;
        wp::float32 var_276;
        bool var_277;
        const wp::int32 var_278 = 0;
        wp::int32 var_279;
        const wp::int32 var_280 = -1;
        bool var_281;
        wp::vec_t<3, wp::float32> var_282;
        wp::vec_t<3, wp::float32> var_283;
        wp::vec_t<3, wp::float32> var_284;
        wp::vec_t<3, wp::float32> var_285;
        wp::vec_t<3, wp::float32> var_286;
        const wp::int32 var_287 = -1;
        const wp::int32 var_288 = -1;
        wp::vec_t<3, wp::int32> var_289;
        const wp::float32 var_290 = 1.0;
        const wp::float32 var_291 = 0.0;
        const wp::float32 var_292 = 0.0;
        wp::vec_t<3, wp::float32> var_293;
        //---------
        // forward
        // def create_soft_contacts(                                                              <L 1021>
        // tid = wp.tid()                                                                         <L 1053>
        var_0 = builtin_tid1d();
        // pair = soft_rigid_contact_pairs[tid]                                                   <L 1054>
        var_1 = wp::address(var_soft_rigid_contact_pairs, var_0);
        var_3 = wp::load(var_1);
        var_2 = wp::copy(var_3);
        // particle_index = pair[0]                                                               <L 1055>
        var_5 = wp::extract(var_2, var_4);
        // shape_index = pair[1]                                                                  <L 1056>
        var_7 = wp::extract(var_2, var_6);
        // if (particle_flags[particle_index] & ParticleFlags.ACTIVE) == 0:                       <L 1057>
        var_8 = wp::address(var_particle_flags, var_5);
        var_11 = wp::load(var_8);
        var_10 = wp::bit_and(var_11, var_9);
        var_13 = (var_10 == var_12);
        if (var_13) {
            // return                                                                             <L 1058>
            continue;
        }
        // if (shape_flags[shape_index] & ShapeFlags.COLLIDE_PARTICLES) == 0:                     <L 1059>
        var_14 = wp::address(var_shape_flags, var_7);
        var_17 = wp::load(var_14);
        var_16 = wp::bit_and(var_17, var_15);
        var_19 = (var_16 == var_18);
        if (var_19) {
            // return                                                                             <L 1060>
            continue;
        }
        // particle_world_id = particle_world[particle_index]                                     <L 1063>
        var_20 = wp::address(var_particle_world, var_5);
        var_22 = wp::load(var_20);
        var_21 = wp::copy(var_22);
        // shape_world_id = shape_world[shape_index]                                              <L 1064>
        var_23 = wp::address(var_shape_world, var_7);
        var_25 = wp::load(var_23);
        var_24 = wp::copy(var_25);
        // if particle_world_id != -1 and shape_world_id != -1 and particle_world_id != shape_world_id:       <L 1067>
        var_28 = (var_21 != var_27);
        var_26 = var_28;
        if (var_26) {
            var_30 = (var_24 != var_29);
            var_26 = var_26 && var_30;
        }
        if (var_26) {
            var_31 = (var_21 != var_24);
            var_26 = var_26 && var_31;
        }
        if (var_26) {
            // return                                                                             <L 1068>
            continue;
        }
        // rigid_index = shape_body[shape_index]                                                  <L 1070>
        var_32 = wp::address(var_shape_body, var_7);
        var_34 = wp::load(var_32);
        var_33 = wp::copy(var_34);
        // px = particle_q[particle_index]                                                        <L 1072>
        var_35 = wp::address(var_particle_q, var_5);
        var_37 = wp::load(var_35);
        var_36 = wp::copy(var_37);
        // radius = particle_radius[particle_index]                                               <L 1073>
        var_38 = wp::address(var_particle_radius, var_5);
        var_40 = wp::load(var_38);
        var_39 = wp::copy(var_40);
        // X_wb = wp.transform_identity()                                                         <L 1075>
        var_41 = wp::transform_identity<wp::float32>();
        // if rigid_index >= 0:                                                                   <L 1076>
        var_43 = (var_33 >= var_42);
        if (var_43) {
            // X_wb = body_q[rigid_index]                                                         <L 1077>
            var_44 = wp::address(var_body_q, var_33);
            var_46 = wp::load(var_44);
            var_45 = wp::copy(var_46);
        }
        var_47 = wp::where(var_43, var_45, var_41);
        // X_bs = shape_transform[shape_index]                                                    <L 1079>
        var_48 = wp::address(var_shape_transform, var_7);
        var_50 = wp::load(var_48);
        var_49 = wp::copy(var_50);
        // X_ws = wp.transform_multiply(X_wb, X_bs)                                               <L 1081>
        var_51 = wp::transform_multiply(var_47, var_49);
        // X_sw = wp.transform_inverse(X_ws)                                                      <L 1082>
        var_52 = wp::transform_inverse(var_51);
        // x_local = wp.transform_point(X_sw, px)                                                 <L 1085>
        var_53 = wp::transform_point(var_52, var_36);
        // geo_type = shape_type[shape_index]                                                     <L 1088>
        var_54 = wp::address(var_shape_type, var_7);
        var_56 = wp::load(var_54);
        var_55 = wp::copy(var_56);
        // geo_scale = shape_scale[shape_index]                                                   <L 1089>
        var_57 = wp::address(var_shape_scale, var_7);
        var_59 = wp::load(var_57);
        var_58 = wp::copy(var_59);
        // s_margin = shape_margin[shape_index] if shape_margin.shape[0] > 0 else 0.0             <L 1090>
        var_60 = &(var_shape_margin.shape);
        var_63 = wp::load(var_60);
        var_62 = wp::extract(var_63, var_61);
        var_65 = (var_62 > var_64);
        if (var_65) {
            var_66 = wp::address(var_shape_margin, var_7);
            var_67 = wp::load(var_66);
        }
        if (!var_65) {
        }
        var_69 = wp::where(var_65, var_67, var_68);
        // d = 1.0e6                                                                              <L 1093>
        // n = wp.vec3()                                                                          <L 1094>
        var_71 = wp::vec_t<3, wp::float32>();
        // v = wp.vec3()                                                                          <L 1095>
        var_72 = wp::vec_t<3, wp::float32>();
        // if geo_type == GeoType.SPHERE:                                                         <L 1097>
        var_74 = (var_55 == var_73);
        if (var_74) {
            // d = sdf_sphere(x_local, geo_scale[0])                                              <L 1098>
            var_76 = wp::extract(var_58, var_75);
            var_77 = sdf_sphere_0(var_53, var_76);
            // n = sdf_sphere_grad(x_local, geo_scale[0])                                         <L 1099>
            var_79 = wp::extract(var_58, var_78);
            var_80 = sdf_sphere_grad_0(var_53, var_79);
        }
        var_81 = wp::where(var_74, var_77, var_70);
        var_82 = wp::where(var_74, var_80, var_71);
        // if geo_type == GeoType.BOX:                                                            <L 1101>
        var_84 = (var_55 == var_83);
        if (var_84) {
            // d = sdf_box(x_local, geo_scale[0], geo_scale[1], geo_scale[2])                     <L 1102>
            var_86 = wp::extract(var_58, var_85);
            var_88 = wp::extract(var_58, var_87);
            var_90 = wp::extract(var_58, var_89);
            var_91 = sdf_box_0(var_53, var_86, var_88, var_90);
            // n = sdf_box_grad(x_local, geo_scale[0], geo_scale[1], geo_scale[2])                <L 1103>
            var_93 = wp::extract(var_58, var_92);
            var_95 = wp::extract(var_58, var_94);
            var_97 = wp::extract(var_58, var_96);
            var_98 = sdf_box_grad_0(var_53, var_93, var_95, var_97);
        }
        var_99 = wp::where(var_84, var_91, var_81);
        var_100 = wp::where(var_84, var_98, var_82);
        // if geo_type == GeoType.CAPSULE:                                                        <L 1105>
        var_102 = (var_55 == var_101);
        if (var_102) {
            // d = sdf_capsule(x_local, geo_scale[0], geo_scale[1], int(Axis.Z))                  <L 1106>
            var_104 = wp::extract(var_58, var_103);
            var_106 = wp::extract(var_58, var_105);
            var_109 = wp::int(var_108);
            var_110 = sdf_capsule_0(var_53, var_104, var_106, var_109);
            // n = sdf_capsule_grad(x_local, geo_scale[0], geo_scale[1], int(Axis.Z))             <L 1107>
            var_112 = wp::extract(var_58, var_111);
            var_114 = wp::extract(var_58, var_113);
            var_117 = wp::int(var_116);
            var_118 = sdf_capsule_grad_0(var_53, var_112, var_114, var_117);
        }
        var_119 = wp::where(var_102, var_110, var_99);
        var_120 = wp::where(var_102, var_118, var_100);
        // if geo_type == GeoType.CYLINDER:                                                       <L 1109>
        var_122 = (var_55 == var_121);
        if (var_122) {
            // d = sdf_cylinder(x_local, geo_scale[0], geo_scale[1], int(Axis.Z))                 <L 1110>
            var_124 = wp::extract(var_58, var_123);
            var_126 = wp::extract(var_58, var_125);
            var_129 = wp::int(var_128);
            var_130 = sdf_cylinder_0(var_53, var_124, var_126, var_129, var_131);
            // n = sdf_cylinder_grad(x_local, geo_scale[0], geo_scale[1], int(Axis.Z))            <L 1111>
            var_133 = wp::extract(var_58, var_132);
            var_135 = wp::extract(var_58, var_134);
            var_138 = wp::int(var_137);
            var_139 = sdf_cylinder_grad_0(var_53, var_133, var_135, var_138, var_140);
        }
        var_141 = wp::where(var_122, var_130, var_119);
        var_142 = wp::where(var_122, var_139, var_120);
        // if geo_type == GeoType.CONE:                                                           <L 1113>
        var_144 = (var_55 == var_143);
        if (var_144) {
            // d = sdf_cone(x_local, geo_scale[0], geo_scale[1], int(Axis.Z))                     <L 1114>
            var_146 = wp::extract(var_58, var_145);
            var_148 = wp::extract(var_58, var_147);
            var_151 = wp::int(var_150);
            var_152 = sdf_cone_0(var_53, var_146, var_148, var_151);
            // n = sdf_cone_grad(x_local, geo_scale[0], geo_scale[1], int(Axis.Z))                <L 1115>
            var_154 = wp::extract(var_58, var_153);
            var_156 = wp::extract(var_58, var_155);
            var_159 = wp::int(var_158);
            var_160 = sdf_cone_grad_0(var_53, var_154, var_156, var_159);
        }
        var_161 = wp::where(var_144, var_152, var_141);
        var_162 = wp::where(var_144, var_160, var_142);
        // if geo_type == GeoType.ELLIPSOID:                                                      <L 1117>
        var_164 = (var_55 == var_163);
        if (var_164) {
            // d = sdf_ellipsoid(x_local, geo_scale)                                              <L 1118>
            var_165 = sdf_ellipsoid_0(var_53, var_58);
            // n = sdf_ellipsoid_grad(x_local, geo_scale)                                         <L 1119>
            var_166 = sdf_ellipsoid_grad_0(var_53, var_58);
        }
        var_167 = wp::where(var_164, var_165, var_161);
        var_168 = wp::where(var_164, var_166, var_162);
        // if geo_type == GeoType.MESH or geo_type == GeoType.CONVEX_MESH:                        <L 1121>
        var_171 = (var_55 == var_170);
        var_169 = var_171;
        if (!var_169) {
            var_173 = (var_55 == var_172);
            var_169 = var_169 || var_173;
        }
        if (var_169) {
            // mesh = shape_source_ptr[shape_index]                                               <L 1122>
            var_174 = wp::address(var_shape_source_ptr, var_7);
            var_176 = wp::load(var_174);
            var_175 = wp::copy(var_176);
            // face_index = int(0)                                                                <L 1124>
            var_178 = wp::int(var_177);
            // face_u = float(0.0)                                                                <L 1125>
            var_180 = wp::float(var_179);
            // face_v = float(0.0)                                                                <L 1126>
            var_182 = wp::float(var_181);
            // sign = float(0.0)                                                                  <L 1127>
            var_184 = wp::float(var_183);
            // min_scale = wp.min(wp.min(wp.abs(geo_scale[0]), wp.abs(geo_scale[1])), wp.abs(geo_scale[2]))       <L 1131>
            var_186 = wp::extract(var_58, var_185);
            var_187 = wp::abs(var_186);
            var_189 = wp::extract(var_58, var_188);
            var_190 = wp::abs(var_189);
            var_191 = wp::min(var_187, var_190);
            var_193 = wp::extract(var_58, var_192);
            var_194 = wp::abs(var_193);
            var_195 = wp::min(var_191, var_194);
            // query = mesh_query_point_sign(                                                     <L 1132>
            // mesh,                                                                              <L 1133>
            // wp.cw_div(x_local, geo_scale),                                                     <L 1134>
            var_196 = wp::cw_div(var_53, var_58);
            // margin + s_margin / min_scale + radius / min_scale,                                <L 1135>
            var_197 = wp::div(var_69, var_195);
            var_198 = wp::add(var_margin, var_197);
            var_199 = wp::div(var_39, var_195);
            var_200 = wp::add(var_198, var_199);
            // resolve_mesh_sign_method(shape_mesh_properties[shape_index]),                      <L 1136>
            var_201 = wp::address(var_shape_mesh_properties, var_7);
            var_203 = wp::load(var_201);
            var_202 = resolve_mesh_sign_method_0(var_203);
            var_204 = mesh_query_point_sign_0(var_175, var_196, var_200, var_202);
            // if query.result:                                                                   <L 1138>
            var_205 = &((var_204).result);
            var_206 = wp::load(var_205);
            if (var_206) {
                // sign = query.sign                                                              <L 1139>
                var_207 = &((var_204).sign);
                var_209 = wp::load(var_207);
                var_208 = wp::copy(var_209);
                // face_index = query.face                                                        <L 1140>
                var_210 = &((var_204).face);
                var_212 = wp::load(var_210);
                var_211 = wp::copy(var_212);
                // face_u = query.u                                                               <L 1141>
                var_213 = &((var_204).u);
                var_215 = wp::load(var_213);
                var_214 = wp::copy(var_215);
                // face_v = query.v                                                               <L 1142>
                var_216 = &((var_204).v);
                var_218 = wp::load(var_216);
                var_217 = wp::copy(var_218);
                // shape_p = wp.mesh_eval_position(mesh, face_index, face_u, face_v)              <L 1144>
                var_219 = wp::mesh_eval_position(var_175, var_211, var_214, var_217);
                // shape_v = wp.mesh_eval_velocity(mesh, face_index, face_u, face_v)              <L 1145>
                var_220 = wp::mesh_eval_velocity(var_175, var_211, var_214, var_217);
                // shape_p = wp.cw_mul(shape_p, geo_scale)                                        <L 1147>
                var_221 = wp::cw_mul(var_219, var_58);
                // shape_v = wp.cw_mul(shape_v, geo_scale)                                        <L 1148>
                var_222 = wp::cw_mul(var_220, var_58);
                // delta = x_local - shape_p                                                      <L 1150>
                var_223 = wp::sub(var_53, var_221);
                // d = wp.length(delta) * sign                                                    <L 1152>
                var_224 = wp::length(var_223);
                var_225 = wp::mul(var_224, var_208);
                // n = wp.normalize(delta) * sign                                                 <L 1153>
                var_226 = wp::normalize(var_223);
                var_227 = wp::mul(var_226, var_208);
                // v = shape_v                                                                    <L 1154>
                var_228 = wp::copy(var_222);
            }
            var_229 = wp::load(var_205);
            var_231 = wp::load(var_205);
            var_230 = wp::where(var_231, var_225, var_167);
            var_233 = wp::load(var_205);
            var_232 = wp::where(var_233, var_227, var_168);
            var_235 = wp::load(var_205);
            var_234 = wp::where(var_235, var_228, var_72);
            var_237 = wp::load(var_205);
            var_236 = wp::where(var_237, var_211, var_178);
            var_239 = wp::load(var_205);
            var_238 = wp::where(var_239, var_214, var_180);
            var_241 = wp::load(var_205);
            var_240 = wp::where(var_241, var_217, var_182);
            var_243 = wp::load(var_205);
            var_242 = wp::where(var_243, var_208, var_184);
        }
        var_244 = wp::where(var_169, var_230, var_167);
        var_245 = wp::where(var_169, var_232, var_168);
        var_246 = wp::where(var_169, var_234, var_72);
        // if geo_type == GeoType.PLANE:                                                          <L 1156>
        var_248 = (var_55 == var_247);
        if (var_248) {
            // d = sdf_plane(x_local, geo_scale[0] * 0.5, geo_scale[1] * 0.5)                     <L 1157>
            var_250 = wp::extract(var_58, var_249);
            var_252 = wp::mul(var_250, var_251);
            var_254 = wp::extract(var_58, var_253);
            var_256 = wp::mul(var_254, var_255);
            var_257 = sdf_plane_0(var_53, var_252, var_256);
            // n = wp.vec3(0.0, 0.0, 1.0)                                                         <L 1158>
            var_261 = wp::vec_t<3, wp::float32>(var_258, var_259, var_260);
        }
        var_262 = wp::where(var_248, var_257, var_244);
        var_263 = wp::where(var_248, var_261, var_245);
        // if geo_type == GeoType.HFIELD:                                                         <L 1160>
        var_265 = (var_55 == var_264);
        if (var_265) {
            // hfd = heightfield_data[shape_heightfield_index[shape_index]]                       <L 1161>
            var_266 = wp::address(var_shape_heightfield_index, var_7);
            var_268 = wp::load(var_266);
            var_267 = wp::address(var_heightfield_data, var_268);
            var_270 = wp::load(var_267);
            var_269 = wp::copy(var_270);
            // d, n = sample_sdf_grad_heightfield(hfd, heightfield_elevations, x_local)           <L 1162>
            sample_sdf_grad_heightfield_0(var_269, var_heightfield_elevations, var_53, var_271, var_272);
        }
        var_273 = wp::where(var_265, var_271, var_262);
        var_274 = wp::where(var_265, var_272, var_263);
        // if d < margin + s_margin + radius:                                                     <L 1164>
        var_275 = wp::add(var_margin, var_69);
        var_276 = wp::add(var_275, var_39);
        var_277 = (var_273 < var_276);
        if (var_277) {
            // index = counter_increment(soft_contact_count, 0, soft_contact_tids, tid)           <L 1165>
            var_279 = counter_increment_0(var_soft_contact_count, var_278, var_soft_contact_tids, var_0, var_280);
            // if index < soft_contact_max:                                                       <L 1167>
            var_281 = (var_279 < var_soft_contact_max);
            if (var_281) {
                // body_pos = wp.transform_point(X_bs, x_local - n * d)                           <L 1171>
                var_282 = wp::mul(var_274, var_273);
                var_283 = wp::sub(var_53, var_282);
                var_284 = wp::transform_point(var_49, var_283);
                // body_vel = wp.transform_vector(X_bs, v)                                        <L 1172>
                var_285 = wp::transform_vector(var_49, var_246);
                // world_normal = wp.transform_vector(X_ws, n)                                    <L 1174>
                var_286 = wp::transform_vector(var_51, var_274);
                // soft_contact_shape[index] = shape_index                                        <L 1176>
                wp::array_store(var_soft_contact_shape, var_279, var_7);
                // soft_contact_body_pos[index] = body_pos                                        <L 1177>
                wp::array_store(var_soft_contact_body_pos, var_279, var_284);
                // soft_contact_body_vel[index] = body_vel                                        <L 1178>
                wp::array_store(var_soft_contact_body_vel, var_279, var_285);
                // soft_contact_particle[index] = particle_index                                  <L 1181>
                wp::array_store(var_soft_contact_particle, var_279, var_5);
                // soft_contact_indices[index] = wp.vec3i(particle_index, -1, -1)                 <L 1182>
                var_289 = wp::vec_t<3, wp::int32>(var_5, var_287, var_288);
                wp::array_store(var_soft_contact_indices, var_279, var_289);
                // soft_contact_barycentric[index] = wp.vec3(1.0, 0.0, 0.0)                       <L 1183>
                var_293 = wp::vec_t<3, wp::float32>(var_290, var_291, var_292);
                wp::array_store(var_soft_contact_barycentric, var_279, var_293);
                // soft_contact_normal[index] = world_normal                                      <L 1184>
                wp::array_store(var_soft_contact_normal, var_279, var_286);
            }
        }
    }
}



extern "C" __global__ void create_soft_contacts_b26277c8_cuda_kernel_backward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::vec_t<2, wp::int32>> var_soft_rigid_contact_pairs,
    wp::array_t<wp::vec_t<3, wp::float32>> var_particle_q,
    wp::array_t<wp::float32> var_particle_radius,
    wp::array_t<wp::int32> var_particle_flags,
    wp::array_t<wp::int32> var_particle_world,
    wp::array_t<wp::transform_t<wp::float32>> var_body_q,
    wp::array_t<wp::transform_t<wp::float32>> var_shape_transform,
    wp::array_t<wp::int32> var_shape_body,
    wp::array_t<wp::int32> var_shape_type,
    wp::array_t<wp::vec_t<3, wp::float32>> var_shape_scale,
    wp::array_t<wp::uint64> var_shape_source_ptr,
    wp::array_t<wp::int32> var_shape_mesh_properties,
    wp::array_t<wp::int32> var_shape_world,
    wp::float32 var_margin,
    wp::array_t<wp::float32> var_shape_margin,
    wp::int32 var_soft_contact_max,
    wp::array_t<wp::int32> var_shape_flags,
    wp::array_t<wp::int32> var_shape_heightfield_index,
    wp::array_t<HeightfieldData_f2b8d59a> var_heightfield_data,
    wp::array_t<wp::float32> var_heightfield_elevations,
    wp::array_t<wp::int32> var_soft_contact_count,
    wp::array_t<wp::int32> var_soft_contact_particle,
    wp::array_t<wp::vec_t<3, wp::int32>> var_soft_contact_indices,
    wp::array_t<wp::vec_t<3, wp::float32>> var_soft_contact_barycentric,
    wp::array_t<wp::int32> var_soft_contact_shape,
    wp::array_t<wp::vec_t<3, wp::float32>> var_soft_contact_body_pos,
    wp::array_t<wp::vec_t<3, wp::float32>> var_soft_contact_body_vel,
    wp::array_t<wp::vec_t<3, wp::float32>> var_soft_contact_normal,
    wp::array_t<wp::int32> var_soft_contact_tids,
    wp::array_t<wp::vec_t<2, wp::int32>> adj_soft_rigid_contact_pairs,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_particle_q,
    wp::array_t<wp::float32> adj_particle_radius,
    wp::array_t<wp::int32> adj_particle_flags,
    wp::array_t<wp::int32> adj_particle_world,
    wp::array_t<wp::transform_t<wp::float32>> adj_body_q,
    wp::array_t<wp::transform_t<wp::float32>> adj_shape_transform,
    wp::array_t<wp::int32> adj_shape_body,
    wp::array_t<wp::int32> adj_shape_type,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_shape_scale,
    wp::array_t<wp::uint64> adj_shape_source_ptr,
    wp::array_t<wp::int32> adj_shape_mesh_properties,
    wp::array_t<wp::int32> adj_shape_world,
    wp::float32 adj_margin,
    wp::array_t<wp::float32> adj_shape_margin,
    wp::int32 adj_soft_contact_max,
    wp::array_t<wp::int32> adj_shape_flags,
    wp::array_t<wp::int32> adj_shape_heightfield_index,
    wp::array_t<HeightfieldData_f2b8d59a> adj_heightfield_data,
    wp::array_t<wp::float32> adj_heightfield_elevations,
    wp::array_t<wp::int32> adj_soft_contact_count,
    wp::array_t<wp::int32> adj_soft_contact_particle,
    wp::array_t<wp::vec_t<3, wp::int32>> adj_soft_contact_indices,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_soft_contact_barycentric,
    wp::array_t<wp::int32> adj_soft_contact_shape,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_soft_contact_body_pos,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_soft_contact_body_vel,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_soft_contact_normal,
    wp::array_t<wp::int32> adj_soft_contact_tids)
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
        const wp::int32 var_4 = 0;
        wp::int32 var_5;
        const wp::int32 var_6 = 1;
        wp::int32 var_7;
        wp::int32* var_8;
        const wp::int32 var_9 = 1;
        wp::int32 var_10;
        wp::int32 var_11;
        const wp::int32 var_12 = 0;
        bool var_13;
        wp::int32* var_14;
        const wp::int32 var_15 = 4;
        wp::int32 var_16;
        wp::int32 var_17;
        const wp::int32 var_18 = 0;
        bool var_19;
        wp::int32* var_20;
        wp::int32 var_21;
        wp::int32 var_22;
        wp::int32* var_23;
        wp::int32 var_24;
        wp::int32 var_25;
        bool var_26;
        const wp::int32 var_27 = -1;
        bool var_28;
        const wp::int32 var_29 = -1;
        bool var_30;
        bool var_31;
        wp::int32* var_32;
        wp::int32 var_33;
        wp::int32 var_34;
        wp::vec_t<3, wp::float32>* var_35;
        wp::vec_t<3, wp::float32> var_36;
        wp::vec_t<3, wp::float32> var_37;
        wp::float32* var_38;
        wp::float32 var_39;
        wp::float32 var_40;
        wp::transform_t<wp::float32> var_41;
        const wp::int32 var_42 = 0;
        bool var_43;
        wp::transform_t<wp::float32>* var_44;
        wp::transform_t<wp::float32> var_45;
        wp::transform_t<wp::float32> var_46;
        wp::transform_t<wp::float32> var_47;
        wp::transform_t<wp::float32>* var_48;
        wp::transform_t<wp::float32> var_49;
        wp::transform_t<wp::float32> var_50;
        wp::transform_t<wp::float32> var_51;
        wp::transform_t<wp::float32> var_52;
        wp::vec_t<3, wp::float32> var_53;
        wp::int32* var_54;
        wp::int32 var_55;
        wp::int32 var_56;
        wp::vec_t<3, wp::float32>* var_57;
        wp::vec_t<3, wp::float32> var_58;
        wp::vec_t<3, wp::float32> var_59;
        wp::shape_t* var_60;
        const wp::int32 var_61 = 0;
        wp::int32 var_62;
        wp::shape_t var_63;
        const wp::int32 var_64 = 0;
        bool var_65;
        wp::float32* var_66;
        wp::float32 var_67;
        const wp::float32 var_68 = 0.0;
        wp::float32 var_69;
        const wp::float32 var_70 = 1000000.0;
        wp::vec_t<3, wp::float32> var_71;
        wp::vec_t<3, wp::float32> var_72;
        const wp::int32 var_73 = 3;
        bool var_74;
        const wp::int32 var_75 = 0;
        wp::float32 var_76;
        wp::float32 var_77;
        const wp::int32 var_78 = 0;
        wp::float32 var_79;
        wp::vec_t<3, wp::float32> var_80;
        wp::float32 var_81;
        wp::vec_t<3, wp::float32> var_82;
        const wp::int32 var_83 = 7;
        bool var_84;
        const wp::int32 var_85 = 0;
        wp::float32 var_86;
        const wp::int32 var_87 = 1;
        wp::float32 var_88;
        const wp::int32 var_89 = 2;
        wp::float32 var_90;
        wp::float32 var_91;
        const wp::int32 var_92 = 0;
        wp::float32 var_93;
        const wp::int32 var_94 = 1;
        wp::float32 var_95;
        const wp::int32 var_96 = 2;
        wp::float32 var_97;
        wp::vec_t<3, wp::float32> var_98;
        wp::float32 var_99;
        wp::vec_t<3, wp::float32> var_100;
        const wp::int32 var_101 = 4;
        bool var_102;
        const wp::int32 var_103 = 0;
        wp::float32 var_104;
        const wp::int32 var_105 = 1;
        wp::float32 var_106;
        const wp::int32 var_107 = 2;
        const wp::int32 var_108 = 2;
        wp::int32 var_109;
        wp::float32 var_110;
        const wp::int32 var_111 = 0;
        wp::float32 var_112;
        const wp::int32 var_113 = 1;
        wp::float32 var_114;
        const wp::int32 var_115 = 2;
        const wp::int32 var_116 = 2;
        wp::int32 var_117;
        wp::vec_t<3, wp::float32> var_118;
        wp::float32 var_119;
        wp::vec_t<3, wp::float32> var_120;
        const wp::int32 var_121 = 6;
        bool var_122;
        const wp::int32 var_123 = 0;
        wp::float32 var_124;
        const wp::int32 var_125 = 1;
        wp::float32 var_126;
        const wp::int32 var_127 = 2;
        const wp::int32 var_128 = 2;
        wp::int32 var_129;
        wp::float32 var_130;
        const wp::float32 var_131 = -1.0;
        const wp::int32 var_132 = 0;
        wp::float32 var_133;
        const wp::int32 var_134 = 1;
        wp::float32 var_135;
        const wp::int32 var_136 = 2;
        const wp::int32 var_137 = 2;
        wp::int32 var_138;
        wp::vec_t<3, wp::float32> var_139;
        const wp::float32 var_140 = -1.0;
        wp::float32 var_141;
        wp::vec_t<3, wp::float32> var_142;
        const wp::int32 var_143 = 9;
        bool var_144;
        const wp::int32 var_145 = 0;
        wp::float32 var_146;
        const wp::int32 var_147 = 1;
        wp::float32 var_148;
        const wp::int32 var_149 = 2;
        const wp::int32 var_150 = 2;
        wp::int32 var_151;
        wp::float32 var_152;
        const wp::int32 var_153 = 0;
        wp::float32 var_154;
        const wp::int32 var_155 = 1;
        wp::float32 var_156;
        const wp::int32 var_157 = 2;
        const wp::int32 var_158 = 2;
        wp::int32 var_159;
        wp::vec_t<3, wp::float32> var_160;
        wp::float32 var_161;
        wp::vec_t<3, wp::float32> var_162;
        const wp::int32 var_163 = 5;
        bool var_164;
        wp::float32 var_165;
        wp::vec_t<3, wp::float32> var_166;
        wp::float32 var_167;
        wp::vec_t<3, wp::float32> var_168;
        bool var_169;
        const wp::int32 var_170 = 8;
        bool var_171;
        const wp::int32 var_172 = 10;
        bool var_173;
        wp::uint64* var_174;
        wp::uint64 var_175;
        wp::uint64 var_176;
        const wp::int32 var_177 = 0;
        wp::int32 var_178;
        const wp::float32 var_179 = 0.0;
        wp::float32 var_180;
        const wp::float32 var_181 = 0.0;
        wp::float32 var_182;
        const wp::float32 var_183 = 0.0;
        wp::float32 var_184;
        const wp::int32 var_185 = 0;
        wp::float32 var_186;
        wp::float32 var_187;
        const wp::int32 var_188 = 1;
        wp::float32 var_189;
        wp::float32 var_190;
        wp::float32 var_191;
        const wp::int32 var_192 = 2;
        wp::float32 var_193;
        wp::float32 var_194;
        wp::float32 var_195;
        wp::vec_t<3, wp::float32> var_196;
        wp::float32 var_197;
        wp::float32 var_198;
        wp::float32 var_199;
        wp::float32 var_200;
        wp::int32* var_201;
        wp::int32 var_202;
        wp::int32 var_203;
        wp::mesh_query_point_t var_204;
        bool* var_205;
        bool var_206;
        wp::float32* var_207;
        wp::float32 var_208;
        wp::float32 var_209;
        wp::int32* var_210;
        wp::int32 var_211;
        wp::int32 var_212;
        wp::float32* var_213;
        wp::float32 var_214;
        wp::float32 var_215;
        wp::float32* var_216;
        wp::float32 var_217;
        wp::float32 var_218;
        wp::vec_t<3, wp::float32> var_219;
        wp::vec_t<3, wp::float32> var_220;
        wp::vec_t<3, wp::float32> var_221;
        wp::vec_t<3, wp::float32> var_222;
        wp::vec_t<3, wp::float32> var_223;
        wp::float32 var_224;
        wp::float32 var_225;
        wp::vec_t<3, wp::float32> var_226;
        wp::vec_t<3, wp::float32> var_227;
        wp::vec_t<3, wp::float32> var_228;
        bool var_229;
        wp::float32 var_230;
        bool var_231;
        wp::vec_t<3, wp::float32> var_232;
        bool var_233;
        wp::vec_t<3, wp::float32> var_234;
        bool var_235;
        wp::int32 var_236;
        bool var_237;
        wp::float32 var_238;
        bool var_239;
        wp::float32 var_240;
        bool var_241;
        wp::float32 var_242;
        bool var_243;
        wp::float32 var_244;
        wp::vec_t<3, wp::float32> var_245;
        wp::vec_t<3, wp::float32> var_246;
        const wp::int32 var_247 = 1;
        bool var_248;
        const wp::int32 var_249 = 0;
        wp::float32 var_250;
        const wp::float32 var_251 = 0.5;
        wp::float32 var_252;
        const wp::int32 var_253 = 1;
        wp::float32 var_254;
        const wp::float32 var_255 = 0.5;
        wp::float32 var_256;
        wp::float32 var_257;
        const wp::float32 var_258 = 0.0;
        const wp::float32 var_259 = 0.0;
        const wp::float32 var_260 = 1.0;
        wp::vec_t<3, wp::float32> var_261;
        wp::float32 var_262;
        wp::vec_t<3, wp::float32> var_263;
        const wp::int32 var_264 = 2;
        bool var_265;
        wp::int32* var_266;
        HeightfieldData_f2b8d59a* var_267;
        wp::int32 var_268;
        HeightfieldData_f2b8d59a var_269;
        HeightfieldData_f2b8d59a var_270;
        wp::float32 var_271;
        wp::vec_t<3, wp::float32> var_272;
        wp::float32 var_273;
        wp::vec_t<3, wp::float32> var_274;
        wp::float32 var_275;
        wp::float32 var_276;
        bool var_277;
        const wp::int32 var_278 = 0;
        wp::int32 var_279;
        const wp::int32 var_280 = -1;
        bool var_281;
        wp::vec_t<3, wp::float32> var_282;
        wp::vec_t<3, wp::float32> var_283;
        wp::vec_t<3, wp::float32> var_284;
        wp::vec_t<3, wp::float32> var_285;
        wp::vec_t<3, wp::float32> var_286;
        const wp::int32 var_287 = -1;
        const wp::int32 var_288 = -1;
        wp::vec_t<3, wp::int32> var_289;
        const wp::float32 var_290 = 1.0;
        const wp::float32 var_291 = 0.0;
        const wp::float32 var_292 = 0.0;
        wp::vec_t<3, wp::float32> var_293;
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
        wp::int32 adj_10 = {};
        wp::int32 adj_11 = {};
        wp::int32 adj_12 = {};
        bool adj_13 = {};
        wp::int32 adj_14 = {};
        wp::int32 adj_15 = {};
        wp::int32 adj_16 = {};
        wp::int32 adj_17 = {};
        wp::int32 adj_18 = {};
        bool adj_19 = {};
        wp::int32 adj_20 = {};
        wp::int32 adj_21 = {};
        wp::int32 adj_22 = {};
        wp::int32 adj_23 = {};
        wp::int32 adj_24 = {};
        wp::int32 adj_25 = {};
        bool adj_26 = {};
        wp::int32 adj_27 = {};
        bool adj_28 = {};
        wp::int32 adj_29 = {};
        bool adj_30 = {};
        bool adj_31 = {};
        wp::int32 adj_32 = {};
        wp::int32 adj_33 = {};
        wp::int32 adj_34 = {};
        wp::vec_t<3, wp::float32> adj_35 = {};
        wp::vec_t<3, wp::float32> adj_36 = {};
        wp::vec_t<3, wp::float32> adj_37 = {};
        wp::float32 adj_38 = {};
        wp::float32 adj_39 = {};
        wp::float32 adj_40 = {};
        wp::transform_t<wp::float32> adj_41 = {};
        wp::int32 adj_42 = {};
        bool adj_43 = {};
        wp::transform_t<wp::float32> adj_44 = {};
        wp::transform_t<wp::float32> adj_45 = {};
        wp::transform_t<wp::float32> adj_46 = {};
        wp::transform_t<wp::float32> adj_47 = {};
        wp::transform_t<wp::float32> adj_48 = {};
        wp::transform_t<wp::float32> adj_49 = {};
        wp::transform_t<wp::float32> adj_50 = {};
        wp::transform_t<wp::float32> adj_51 = {};
        wp::transform_t<wp::float32> adj_52 = {};
        wp::vec_t<3, wp::float32> adj_53 = {};
        wp::int32 adj_54 = {};
        wp::int32 adj_55 = {};
        wp::int32 adj_56 = {};
        wp::vec_t<3, wp::float32> adj_57 = {};
        wp::vec_t<3, wp::float32> adj_58 = {};
        wp::vec_t<3, wp::float32> adj_59 = {};
        wp::shape_t adj_60 = {};
        wp::int32 adj_61 = {};
        wp::int32 adj_62 = {};
        wp::shape_t adj_63 = {};
        wp::int32 adj_64 = {};
        bool adj_65 = {};
        wp::float32 adj_66 = {};
        wp::float32 adj_67 = {};
        wp::float32 adj_68 = {};
        wp::float32 adj_69 = {};
        wp::float32 adj_70 = {};
        wp::vec_t<3, wp::float32> adj_71 = {};
        wp::vec_t<3, wp::float32> adj_72 = {};
        wp::int32 adj_73 = {};
        bool adj_74 = {};
        wp::int32 adj_75 = {};
        wp::float32 adj_76 = {};
        wp::float32 adj_77 = {};
        wp::int32 adj_78 = {};
        wp::float32 adj_79 = {};
        wp::vec_t<3, wp::float32> adj_80 = {};
        wp::float32 adj_81 = {};
        wp::vec_t<3, wp::float32> adj_82 = {};
        wp::int32 adj_83 = {};
        bool adj_84 = {};
        wp::int32 adj_85 = {};
        wp::float32 adj_86 = {};
        wp::int32 adj_87 = {};
        wp::float32 adj_88 = {};
        wp::int32 adj_89 = {};
        wp::float32 adj_90 = {};
        wp::float32 adj_91 = {};
        wp::int32 adj_92 = {};
        wp::float32 adj_93 = {};
        wp::int32 adj_94 = {};
        wp::float32 adj_95 = {};
        wp::int32 adj_96 = {};
        wp::float32 adj_97 = {};
        wp::vec_t<3, wp::float32> adj_98 = {};
        wp::float32 adj_99 = {};
        wp::vec_t<3, wp::float32> adj_100 = {};
        wp::int32 adj_101 = {};
        bool adj_102 = {};
        wp::int32 adj_103 = {};
        wp::float32 adj_104 = {};
        wp::int32 adj_105 = {};
        wp::float32 adj_106 = {};
        wp::int32 adj_107 = {};
        wp::int32 adj_108 = {};
        wp::int32 adj_109 = {};
        wp::float32 adj_110 = {};
        wp::int32 adj_111 = {};
        wp::float32 adj_112 = {};
        wp::int32 adj_113 = {};
        wp::float32 adj_114 = {};
        wp::int32 adj_115 = {};
        wp::int32 adj_116 = {};
        wp::int32 adj_117 = {};
        wp::vec_t<3, wp::float32> adj_118 = {};
        wp::float32 adj_119 = {};
        wp::vec_t<3, wp::float32> adj_120 = {};
        wp::int32 adj_121 = {};
        bool adj_122 = {};
        wp::int32 adj_123 = {};
        wp::float32 adj_124 = {};
        wp::int32 adj_125 = {};
        wp::float32 adj_126 = {};
        wp::int32 adj_127 = {};
        wp::int32 adj_128 = {};
        wp::int32 adj_129 = {};
        wp::float32 adj_130 = {};
        wp::float32 adj_131 = {};
        wp::int32 adj_132 = {};
        wp::float32 adj_133 = {};
        wp::int32 adj_134 = {};
        wp::float32 adj_135 = {};
        wp::int32 adj_136 = {};
        wp::int32 adj_137 = {};
        wp::int32 adj_138 = {};
        wp::vec_t<3, wp::float32> adj_139 = {};
        wp::float32 adj_140 = {};
        wp::float32 adj_141 = {};
        wp::vec_t<3, wp::float32> adj_142 = {};
        wp::int32 adj_143 = {};
        bool adj_144 = {};
        wp::int32 adj_145 = {};
        wp::float32 adj_146 = {};
        wp::int32 adj_147 = {};
        wp::float32 adj_148 = {};
        wp::int32 adj_149 = {};
        wp::int32 adj_150 = {};
        wp::int32 adj_151 = {};
        wp::float32 adj_152 = {};
        wp::int32 adj_153 = {};
        wp::float32 adj_154 = {};
        wp::int32 adj_155 = {};
        wp::float32 adj_156 = {};
        wp::int32 adj_157 = {};
        wp::int32 adj_158 = {};
        wp::int32 adj_159 = {};
        wp::vec_t<3, wp::float32> adj_160 = {};
        wp::float32 adj_161 = {};
        wp::vec_t<3, wp::float32> adj_162 = {};
        wp::int32 adj_163 = {};
        bool adj_164 = {};
        wp::float32 adj_165 = {};
        wp::vec_t<3, wp::float32> adj_166 = {};
        wp::float32 adj_167 = {};
        wp::vec_t<3, wp::float32> adj_168 = {};
        bool adj_169 = {};
        wp::int32 adj_170 = {};
        bool adj_171 = {};
        wp::int32 adj_172 = {};
        bool adj_173 = {};
        wp::uint64 adj_174 = {};
        wp::uint64 adj_175 = {};
        wp::uint64 adj_176 = {};
        wp::int32 adj_177 = {};
        wp::int32 adj_178 = {};
        wp::float32 adj_179 = {};
        wp::float32 adj_180 = {};
        wp::float32 adj_181 = {};
        wp::float32 adj_182 = {};
        wp::float32 adj_183 = {};
        wp::float32 adj_184 = {};
        wp::int32 adj_185 = {};
        wp::float32 adj_186 = {};
        wp::float32 adj_187 = {};
        wp::int32 adj_188 = {};
        wp::float32 adj_189 = {};
        wp::float32 adj_190 = {};
        wp::float32 adj_191 = {};
        wp::int32 adj_192 = {};
        wp::float32 adj_193 = {};
        wp::float32 adj_194 = {};
        wp::float32 adj_195 = {};
        wp::vec_t<3, wp::float32> adj_196 = {};
        wp::float32 adj_197 = {};
        wp::float32 adj_198 = {};
        wp::float32 adj_199 = {};
        wp::float32 adj_200 = {};
        wp::int32 adj_201 = {};
        wp::int32 adj_202 = {};
        wp::int32 adj_203 = {};
        wp::mesh_query_point_t adj_204 = {};
        bool adj_205 = {};
        bool adj_206 = {};
        wp::float32 adj_207 = {};
        wp::float32 adj_208 = {};
        wp::float32 adj_209 = {};
        wp::int32 adj_210 = {};
        wp::int32 adj_211 = {};
        wp::int32 adj_212 = {};
        wp::float32 adj_213 = {};
        wp::float32 adj_214 = {};
        wp::float32 adj_215 = {};
        wp::float32 adj_216 = {};
        wp::float32 adj_217 = {};
        wp::float32 adj_218 = {};
        wp::vec_t<3, wp::float32> adj_219 = {};
        wp::vec_t<3, wp::float32> adj_220 = {};
        wp::vec_t<3, wp::float32> adj_221 = {};
        wp::vec_t<3, wp::float32> adj_222 = {};
        wp::vec_t<3, wp::float32> adj_223 = {};
        wp::float32 adj_224 = {};
        wp::float32 adj_225 = {};
        wp::vec_t<3, wp::float32> adj_226 = {};
        wp::vec_t<3, wp::float32> adj_227 = {};
        wp::vec_t<3, wp::float32> adj_228 = {};
        bool adj_229 = {};
        wp::float32 adj_230 = {};
        bool adj_231 = {};
        wp::vec_t<3, wp::float32> adj_232 = {};
        bool adj_233 = {};
        wp::vec_t<3, wp::float32> adj_234 = {};
        bool adj_235 = {};
        wp::int32 adj_236 = {};
        bool adj_237 = {};
        wp::float32 adj_238 = {};
        bool adj_239 = {};
        wp::float32 adj_240 = {};
        bool adj_241 = {};
        wp::float32 adj_242 = {};
        bool adj_243 = {};
        wp::float32 adj_244 = {};
        wp::vec_t<3, wp::float32> adj_245 = {};
        wp::vec_t<3, wp::float32> adj_246 = {};
        wp::int32 adj_247 = {};
        bool adj_248 = {};
        wp::int32 adj_249 = {};
        wp::float32 adj_250 = {};
        wp::float32 adj_251 = {};
        wp::float32 adj_252 = {};
        wp::int32 adj_253 = {};
        wp::float32 adj_254 = {};
        wp::float32 adj_255 = {};
        wp::float32 adj_256 = {};
        wp::float32 adj_257 = {};
        wp::float32 adj_258 = {};
        wp::float32 adj_259 = {};
        wp::float32 adj_260 = {};
        wp::vec_t<3, wp::float32> adj_261 = {};
        wp::float32 adj_262 = {};
        wp::vec_t<3, wp::float32> adj_263 = {};
        wp::int32 adj_264 = {};
        bool adj_265 = {};
        wp::int32 adj_266 = {};
        HeightfieldData_f2b8d59a adj_267 = {};
        wp::int32 adj_268 = {};
        HeightfieldData_f2b8d59a adj_269 = {};
        HeightfieldData_f2b8d59a adj_270 = {};
        wp::float32 adj_271 = {};
        wp::vec_t<3, wp::float32> adj_272 = {};
        wp::float32 adj_273 = {};
        wp::vec_t<3, wp::float32> adj_274 = {};
        wp::float32 adj_275 = {};
        wp::float32 adj_276 = {};
        bool adj_277 = {};
        wp::int32 adj_278 = {};
        wp::int32 adj_279 = {};
        wp::int32 adj_280 = {};
        bool adj_281 = {};
        wp::vec_t<3, wp::float32> adj_282 = {};
        wp::vec_t<3, wp::float32> adj_283 = {};
        wp::vec_t<3, wp::float32> adj_284 = {};
        wp::vec_t<3, wp::float32> adj_285 = {};
        wp::vec_t<3, wp::float32> adj_286 = {};
        wp::int32 adj_287 = {};
        wp::int32 adj_288 = {};
        wp::vec_t<3, wp::int32> adj_289 = {};
        wp::float32 adj_290 = {};
        wp::float32 adj_291 = {};
        wp::float32 adj_292 = {};
        wp::vec_t<3, wp::float32> adj_293 = {};
        //---------
        // forward
        // def create_soft_contacts(                                                              <L 1021>
        // tid = wp.tid()                                                                         <L 1053>
        var_0 = builtin_tid1d();
        // pair = soft_rigid_contact_pairs[tid]                                                   <L 1054>
        var_1 = wp::address(var_soft_rigid_contact_pairs, var_0);
        var_3 = wp::load(var_1);
        var_2 = wp::copy(var_3);
        // particle_index = pair[0]                                                               <L 1055>
        var_5 = wp::extract(var_2, var_4);
        // shape_index = pair[1]                                                                  <L 1056>
        var_7 = wp::extract(var_2, var_6);
        // if (particle_flags[particle_index] & ParticleFlags.ACTIVE) == 0:                       <L 1057>
        var_8 = wp::address(var_particle_flags, var_5);
        var_11 = wp::load(var_8);
        var_10 = wp::bit_and(var_11, var_9);
        var_13 = (var_10 == var_12);
        if (var_13) {
            // return                                                                             <L 1058>
            goto label0;
        }
        // if (shape_flags[shape_index] & ShapeFlags.COLLIDE_PARTICLES) == 0:                     <L 1059>
        var_14 = wp::address(var_shape_flags, var_7);
        var_17 = wp::load(var_14);
        var_16 = wp::bit_and(var_17, var_15);
        var_19 = (var_16 == var_18);
        if (var_19) {
            // return                                                                             <L 1060>
            goto label1;
        }
        // particle_world_id = particle_world[particle_index]                                     <L 1063>
        var_20 = wp::address(var_particle_world, var_5);
        var_22 = wp::load(var_20);
        var_21 = wp::copy(var_22);
        // shape_world_id = shape_world[shape_index]                                              <L 1064>
        var_23 = wp::address(var_shape_world, var_7);
        var_25 = wp::load(var_23);
        var_24 = wp::copy(var_25);
        // if particle_world_id != -1 and shape_world_id != -1 and particle_world_id != shape_world_id:       <L 1067>
        var_28 = (var_21 != var_27);
        var_26 = var_28;
        if (var_26) {
            var_30 = (var_24 != var_29);
            var_26 = var_26 && var_30;
        }
        if (var_26) {
            var_31 = (var_21 != var_24);
            var_26 = var_26 && var_31;
        }
        if (var_26) {
            // return                                                                             <L 1068>
            goto label2;
        }
        // rigid_index = shape_body[shape_index]                                                  <L 1070>
        var_32 = wp::address(var_shape_body, var_7);
        var_34 = wp::load(var_32);
        var_33 = wp::copy(var_34);
        // px = particle_q[particle_index]                                                        <L 1072>
        var_35 = wp::address(var_particle_q, var_5);
        var_37 = wp::load(var_35);
        var_36 = wp::copy(var_37);
        // radius = particle_radius[particle_index]                                               <L 1073>
        var_38 = wp::address(var_particle_radius, var_5);
        var_40 = wp::load(var_38);
        var_39 = wp::copy(var_40);
        // X_wb = wp.transform_identity()                                                         <L 1075>
        var_41 = wp::transform_identity<wp::float32>();
        // if rigid_index >= 0:                                                                   <L 1076>
        var_43 = (var_33 >= var_42);
        if (var_43) {
            // X_wb = body_q[rigid_index]                                                         <L 1077>
            var_44 = wp::address(var_body_q, var_33);
            var_46 = wp::load(var_44);
            var_45 = wp::copy(var_46);
        }
        var_47 = wp::where(var_43, var_45, var_41);
        // X_bs = shape_transform[shape_index]                                                    <L 1079>
        var_48 = wp::address(var_shape_transform, var_7);
        var_50 = wp::load(var_48);
        var_49 = wp::copy(var_50);
        // X_ws = wp.transform_multiply(X_wb, X_bs)                                               <L 1081>
        var_51 = wp::transform_multiply(var_47, var_49);
        // X_sw = wp.transform_inverse(X_ws)                                                      <L 1082>
        var_52 = wp::transform_inverse(var_51);
        // x_local = wp.transform_point(X_sw, px)                                                 <L 1085>
        var_53 = wp::transform_point(var_52, var_36);
        // geo_type = shape_type[shape_index]                                                     <L 1088>
        var_54 = wp::address(var_shape_type, var_7);
        var_56 = wp::load(var_54);
        var_55 = wp::copy(var_56);
        // geo_scale = shape_scale[shape_index]                                                   <L 1089>
        var_57 = wp::address(var_shape_scale, var_7);
        var_59 = wp::load(var_57);
        var_58 = wp::copy(var_59);
        // s_margin = shape_margin[shape_index] if shape_margin.shape[0] > 0 else 0.0             <L 1090>
        var_60 = &(var_shape_margin.shape);
        var_63 = wp::load(var_60);
        var_62 = wp::extract(var_63, var_61);
        var_65 = (var_62 > var_64);
        if (var_65) {
            var_66 = wp::address(var_shape_margin, var_7);
            var_67 = wp::load(var_66);
        }
        if (!var_65) {
        }
        var_69 = wp::where(var_65, var_67, var_68);
        // d = 1.0e6                                                                              <L 1093>
        // n = wp.vec3()                                                                          <L 1094>
        var_71 = wp::vec_t<3, wp::float32>();
        // v = wp.vec3()                                                                          <L 1095>
        var_72 = wp::vec_t<3, wp::float32>();
        // if geo_type == GeoType.SPHERE:                                                         <L 1097>
        var_74 = (var_55 == var_73);
        if (var_74) {
            // d = sdf_sphere(x_local, geo_scale[0])                                              <L 1098>
            var_76 = wp::extract(var_58, var_75);
            var_77 = sdf_sphere_0(var_53, var_76);
            // n = sdf_sphere_grad(x_local, geo_scale[0])                                         <L 1099>
            var_79 = wp::extract(var_58, var_78);
            var_80 = sdf_sphere_grad_0(var_53, var_79);
        }
        var_81 = wp::where(var_74, var_77, var_70);
        var_82 = wp::where(var_74, var_80, var_71);
        // if geo_type == GeoType.BOX:                                                            <L 1101>
        var_84 = (var_55 == var_83);
        if (var_84) {
            // d = sdf_box(x_local, geo_scale[0], geo_scale[1], geo_scale[2])                     <L 1102>
            var_86 = wp::extract(var_58, var_85);
            var_88 = wp::extract(var_58, var_87);
            var_90 = wp::extract(var_58, var_89);
            var_91 = sdf_box_0(var_53, var_86, var_88, var_90);
            // n = sdf_box_grad(x_local, geo_scale[0], geo_scale[1], geo_scale[2])                <L 1103>
            var_93 = wp::extract(var_58, var_92);
            var_95 = wp::extract(var_58, var_94);
            var_97 = wp::extract(var_58, var_96);
            var_98 = sdf_box_grad_0(var_53, var_93, var_95, var_97);
        }
        var_99 = wp::where(var_84, var_91, var_81);
        var_100 = wp::where(var_84, var_98, var_82);
        // if geo_type == GeoType.CAPSULE:                                                        <L 1105>
        var_102 = (var_55 == var_101);
        if (var_102) {
            // d = sdf_capsule(x_local, geo_scale[0], geo_scale[1], int(Axis.Z))                  <L 1106>
            var_104 = wp::extract(var_58, var_103);
            var_106 = wp::extract(var_58, var_105);
            var_109 = wp::int(var_108);
            var_110 = sdf_capsule_0(var_53, var_104, var_106, var_109);
            // n = sdf_capsule_grad(x_local, geo_scale[0], geo_scale[1], int(Axis.Z))             <L 1107>
            var_112 = wp::extract(var_58, var_111);
            var_114 = wp::extract(var_58, var_113);
            var_117 = wp::int(var_116);
            var_118 = sdf_capsule_grad_0(var_53, var_112, var_114, var_117);
        }
        var_119 = wp::where(var_102, var_110, var_99);
        var_120 = wp::where(var_102, var_118, var_100);
        // if geo_type == GeoType.CYLINDER:                                                       <L 1109>
        var_122 = (var_55 == var_121);
        if (var_122) {
            // d = sdf_cylinder(x_local, geo_scale[0], geo_scale[1], int(Axis.Z))                 <L 1110>
            var_124 = wp::extract(var_58, var_123);
            var_126 = wp::extract(var_58, var_125);
            var_129 = wp::int(var_128);
            var_130 = sdf_cylinder_0(var_53, var_124, var_126, var_129, var_131);
            // n = sdf_cylinder_grad(x_local, geo_scale[0], geo_scale[1], int(Axis.Z))            <L 1111>
            var_133 = wp::extract(var_58, var_132);
            var_135 = wp::extract(var_58, var_134);
            var_138 = wp::int(var_137);
            var_139 = sdf_cylinder_grad_0(var_53, var_133, var_135, var_138, var_140);
        }
        var_141 = wp::where(var_122, var_130, var_119);
        var_142 = wp::where(var_122, var_139, var_120);
        // if geo_type == GeoType.CONE:                                                           <L 1113>
        var_144 = (var_55 == var_143);
        if (var_144) {
            // d = sdf_cone(x_local, geo_scale[0], geo_scale[1], int(Axis.Z))                     <L 1114>
            var_146 = wp::extract(var_58, var_145);
            var_148 = wp::extract(var_58, var_147);
            var_151 = wp::int(var_150);
            var_152 = sdf_cone_0(var_53, var_146, var_148, var_151);
            // n = sdf_cone_grad(x_local, geo_scale[0], geo_scale[1], int(Axis.Z))                <L 1115>
            var_154 = wp::extract(var_58, var_153);
            var_156 = wp::extract(var_58, var_155);
            var_159 = wp::int(var_158);
            var_160 = sdf_cone_grad_0(var_53, var_154, var_156, var_159);
        }
        var_161 = wp::where(var_144, var_152, var_141);
        var_162 = wp::where(var_144, var_160, var_142);
        // if geo_type == GeoType.ELLIPSOID:                                                      <L 1117>
        var_164 = (var_55 == var_163);
        if (var_164) {
            // d = sdf_ellipsoid(x_local, geo_scale)                                              <L 1118>
            var_165 = sdf_ellipsoid_0(var_53, var_58);
            // n = sdf_ellipsoid_grad(x_local, geo_scale)                                         <L 1119>
            var_166 = sdf_ellipsoid_grad_0(var_53, var_58);
        }
        var_167 = wp::where(var_164, var_165, var_161);
        var_168 = wp::where(var_164, var_166, var_162);
        // if geo_type == GeoType.MESH or geo_type == GeoType.CONVEX_MESH:                        <L 1121>
        var_171 = (var_55 == var_170);
        var_169 = var_171;
        if (!var_169) {
            var_173 = (var_55 == var_172);
            var_169 = var_169 || var_173;
        }
        if (var_169) {
            // mesh = shape_source_ptr[shape_index]                                               <L 1122>
            var_174 = wp::address(var_shape_source_ptr, var_7);
            var_176 = wp::load(var_174);
            var_175 = wp::copy(var_176);
            // face_index = int(0)                                                                <L 1124>
            var_178 = wp::int(var_177);
            // face_u = float(0.0)                                                                <L 1125>
            var_180 = wp::float(var_179);
            // face_v = float(0.0)                                                                <L 1126>
            var_182 = wp::float(var_181);
            // sign = float(0.0)                                                                  <L 1127>
            var_184 = wp::float(var_183);
            // min_scale = wp.min(wp.min(wp.abs(geo_scale[0]), wp.abs(geo_scale[1])), wp.abs(geo_scale[2]))       <L 1131>
            var_186 = wp::extract(var_58, var_185);
            var_187 = wp::abs(var_186);
            var_189 = wp::extract(var_58, var_188);
            var_190 = wp::abs(var_189);
            var_191 = wp::min(var_187, var_190);
            var_193 = wp::extract(var_58, var_192);
            var_194 = wp::abs(var_193);
            var_195 = wp::min(var_191, var_194);
            // query = mesh_query_point_sign(                                                     <L 1132>
            // mesh,                                                                              <L 1133>
            // wp.cw_div(x_local, geo_scale),                                                     <L 1134>
            var_196 = wp::cw_div(var_53, var_58);
            // margin + s_margin / min_scale + radius / min_scale,                                <L 1135>
            var_197 = wp::div(var_69, var_195);
            var_198 = wp::add(var_margin, var_197);
            var_199 = wp::div(var_39, var_195);
            var_200 = wp::add(var_198, var_199);
            // resolve_mesh_sign_method(shape_mesh_properties[shape_index]),                      <L 1136>
            var_201 = wp::address(var_shape_mesh_properties, var_7);
            var_203 = wp::load(var_201);
            var_202 = resolve_mesh_sign_method_0(var_203);
            var_204 = mesh_query_point_sign_0(var_175, var_196, var_200, var_202);
            // if query.result:                                                                   <L 1138>
            var_205 = &((var_204).result);
            var_206 = wp::load(var_205);
            if (var_206) {
                // sign = query.sign                                                              <L 1139>
                var_207 = &((var_204).sign);
                var_209 = wp::load(var_207);
                var_208 = wp::copy(var_209);
                // face_index = query.face                                                        <L 1140>
                var_210 = &((var_204).face);
                var_212 = wp::load(var_210);
                var_211 = wp::copy(var_212);
                // face_u = query.u                                                               <L 1141>
                var_213 = &((var_204).u);
                var_215 = wp::load(var_213);
                var_214 = wp::copy(var_215);
                // face_v = query.v                                                               <L 1142>
                var_216 = &((var_204).v);
                var_218 = wp::load(var_216);
                var_217 = wp::copy(var_218);
                // shape_p = wp.mesh_eval_position(mesh, face_index, face_u, face_v)              <L 1144>
                var_219 = wp::mesh_eval_position(var_175, var_211, var_214, var_217);
                // shape_v = wp.mesh_eval_velocity(mesh, face_index, face_u, face_v)              <L 1145>
                var_220 = wp::mesh_eval_velocity(var_175, var_211, var_214, var_217);
                // shape_p = wp.cw_mul(shape_p, geo_scale)                                        <L 1147>
                var_221 = wp::cw_mul(var_219, var_58);
                // shape_v = wp.cw_mul(shape_v, geo_scale)                                        <L 1148>
                var_222 = wp::cw_mul(var_220, var_58);
                // delta = x_local - shape_p                                                      <L 1150>
                var_223 = wp::sub(var_53, var_221);
                // d = wp.length(delta) * sign                                                    <L 1152>
                var_224 = wp::length(var_223);
                var_225 = wp::mul(var_224, var_208);
                // n = wp.normalize(delta) * sign                                                 <L 1153>
                var_226 = wp::normalize(var_223);
                var_227 = wp::mul(var_226, var_208);
                // v = shape_v                                                                    <L 1154>
                var_228 = wp::copy(var_222);
            }
            var_229 = wp::load(var_205);
            var_231 = wp::load(var_205);
            var_230 = wp::where(var_231, var_225, var_167);
            var_233 = wp::load(var_205);
            var_232 = wp::where(var_233, var_227, var_168);
            var_235 = wp::load(var_205);
            var_234 = wp::where(var_235, var_228, var_72);
            var_237 = wp::load(var_205);
            var_236 = wp::where(var_237, var_211, var_178);
            var_239 = wp::load(var_205);
            var_238 = wp::where(var_239, var_214, var_180);
            var_241 = wp::load(var_205);
            var_240 = wp::where(var_241, var_217, var_182);
            var_243 = wp::load(var_205);
            var_242 = wp::where(var_243, var_208, var_184);
        }
        var_244 = wp::where(var_169, var_230, var_167);
        var_245 = wp::where(var_169, var_232, var_168);
        var_246 = wp::where(var_169, var_234, var_72);
        // if geo_type == GeoType.PLANE:                                                          <L 1156>
        var_248 = (var_55 == var_247);
        if (var_248) {
            // d = sdf_plane(x_local, geo_scale[0] * 0.5, geo_scale[1] * 0.5)                     <L 1157>
            var_250 = wp::extract(var_58, var_249);
            var_252 = wp::mul(var_250, var_251);
            var_254 = wp::extract(var_58, var_253);
            var_256 = wp::mul(var_254, var_255);
            var_257 = sdf_plane_0(var_53, var_252, var_256);
            // n = wp.vec3(0.0, 0.0, 1.0)                                                         <L 1158>
            var_261 = wp::vec_t<3, wp::float32>(var_258, var_259, var_260);
        }
        var_262 = wp::where(var_248, var_257, var_244);
        var_263 = wp::where(var_248, var_261, var_245);
        // if geo_type == GeoType.HFIELD:                                                         <L 1160>
        var_265 = (var_55 == var_264);
        if (var_265) {
            // hfd = heightfield_data[shape_heightfield_index[shape_index]]                       <L 1161>
            var_266 = wp::address(var_shape_heightfield_index, var_7);
            var_268 = wp::load(var_266);
            var_267 = wp::address(var_heightfield_data, var_268);
            var_270 = wp::load(var_267);
            var_269 = wp::copy(var_270);
            // d, n = sample_sdf_grad_heightfield(hfd, heightfield_elevations, x_local)           <L 1162>
            sample_sdf_grad_heightfield_0(var_269, var_heightfield_elevations, var_53, var_271, var_272);
        }
        var_273 = wp::where(var_265, var_271, var_262);
        var_274 = wp::where(var_265, var_272, var_263);
        // if d < margin + s_margin + radius:                                                     <L 1164>
        var_275 = wp::add(var_margin, var_69);
        var_276 = wp::add(var_275, var_39);
        var_277 = (var_273 < var_276);
        if (var_277) {
            // index = counter_increment(soft_contact_count, 0, soft_contact_tids, tid)           <L 1165>
            var_279 = replay_counter_increment_0(var_soft_contact_count, var_278, var_soft_contact_tids, var_0, var_280);
            // if index < soft_contact_max:                                                       <L 1167>
            var_281 = (var_279 < var_soft_contact_max);
            if (var_281) {
                // body_pos = wp.transform_point(X_bs, x_local - n * d)                           <L 1171>
                var_282 = wp::mul(var_274, var_273);
                var_283 = wp::sub(var_53, var_282);
                var_284 = wp::transform_point(var_49, var_283);
                // body_vel = wp.transform_vector(X_bs, v)                                        <L 1172>
                var_285 = wp::transform_vector(var_49, var_246);
                // world_normal = wp.transform_vector(X_ws, n)                                    <L 1174>
                var_286 = wp::transform_vector(var_51, var_274);
                // soft_contact_shape[index] = shape_index                                        <L 1176>
                // wp::array_store(var_soft_contact_shape, var_279, var_7);
                // soft_contact_body_pos[index] = body_pos                                        <L 1177>
                // wp::array_store(var_soft_contact_body_pos, var_279, var_284);
                // soft_contact_body_vel[index] = body_vel                                        <L 1178>
                // wp::array_store(var_soft_contact_body_vel, var_279, var_285);
                // soft_contact_particle[index] = particle_index                                  <L 1181>
                // wp::array_store(var_soft_contact_particle, var_279, var_5);
                // soft_contact_indices[index] = wp.vec3i(particle_index, -1, -1)                 <L 1182>
                var_289 = wp::vec_t<3, wp::int32>(var_5, var_287, var_288);
                // wp::array_store(var_soft_contact_indices, var_279, var_289);
                // soft_contact_barycentric[index] = wp.vec3(1.0, 0.0, 0.0)                       <L 1183>
                var_293 = wp::vec_t<3, wp::float32>(var_290, var_291, var_292);
                // wp::array_store(var_soft_contact_barycentric, var_279, var_293);
                // soft_contact_normal[index] = world_normal                                      <L 1184>
                // wp::array_store(var_soft_contact_normal, var_279, var_286);
            }
        }
        //---------
        // reverse
        if (var_277) {
            if (var_281) {
                wp::adj_array_store(var_soft_contact_normal, var_279, var_286, adj_soft_contact_normal, adj_279, adj_286);
                // adj: soft_contact_normal[index] = world_normal                                 <L 1184>
                wp::adj_array_store(var_soft_contact_barycentric, var_279, var_293, adj_soft_contact_barycentric, adj_279, adj_293);
                wp::adj_vec_t(var_290, var_291, var_292, adj_290, adj_291, adj_292, adj_293);
                // adj: soft_contact_barycentric[index] = wp.vec3(1.0, 0.0, 0.0)                  <L 1183>
                wp::adj_array_store(var_soft_contact_indices, var_279, var_289, adj_soft_contact_indices, adj_279, adj_289);
                wp::adj_vec_t(var_5, var_287, var_288, adj_5, adj_287, adj_288, adj_289);
                // adj: soft_contact_indices[index] = wp.vec3i(particle_index, -1, -1)            <L 1182>
                wp::adj_array_store(var_soft_contact_particle, var_279, var_5, adj_soft_contact_particle, adj_279, adj_5);
                // adj: soft_contact_particle[index] = particle_index                             <L 1181>
                wp::adj_array_store(var_soft_contact_body_vel, var_279, var_285, adj_soft_contact_body_vel, adj_279, adj_285);
                // adj: soft_contact_body_vel[index] = body_vel                                   <L 1178>
                wp::adj_array_store(var_soft_contact_body_pos, var_279, var_284, adj_soft_contact_body_pos, adj_279, adj_284);
                // adj: soft_contact_body_pos[index] = body_pos                                   <L 1177>
                wp::adj_array_store(var_soft_contact_shape, var_279, var_7, adj_soft_contact_shape, adj_279, adj_7);
                // adj: soft_contact_shape[index] = shape_index                                   <L 1176>
                wp::adj_transform_vector(var_51, var_274, adj_51, adj_274, adj_286);
                // adj: world_normal = wp.transform_vector(X_ws, n)                               <L 1174>
                wp::adj_transform_vector(var_49, var_246, adj_49, adj_246, adj_285);
                // adj: body_vel = wp.transform_vector(X_bs, v)                                   <L 1172>
                wp::adj_transform_point(var_49, var_283, adj_49, adj_283, adj_284);
                wp::adj_sub(var_53, var_282, adj_53, adj_282, adj_283);
                wp::adj_mul(var_274, var_273, adj_274, adj_273, adj_282);
                // adj: body_pos = wp.transform_point(X_bs, x_local - n * d)                      <L 1171>
            }
            // adj: if index < soft_contact_max:                                                  <L 1167>
            adj_counter_increment_0(var_soft_contact_count, var_278, var_soft_contact_tids, var_0, var_280, adj_soft_contact_count, adj_278, adj_soft_contact_tids, adj_0, adj_280, adj_279);
            // adj: index = counter_increment(soft_contact_count, 0, soft_contact_tids, tid)      <L 1165>
        }
        wp::adj_add(var_275, var_39, adj_275, adj_39, adj_276);
        wp::adj_add(var_margin, var_69, adj_margin, adj_69, adj_275);
        // adj: if d < margin + s_margin + radius:                                                <L 1164>
        wp::adj_where(var_265, var_272, var_263, adj_265, adj_272, adj_263, adj_274);
        wp::adj_where(var_265, var_271, var_262, adj_265, adj_271, adj_262, adj_273);
        if (var_265) {
            adj_sample_sdf_grad_heightfield_0(var_269, var_heightfield_elevations, var_53, var_271, var_272, adj_269, adj_heightfield_elevations, adj_53, adj_271, adj_272);
            // adj: d, n = sample_sdf_grad_heightfield(hfd, heightfield_elevations, x_local)      <L 1162>
            wp::adj_copy(var_270, adj_267, adj_269);
            wp::adj_address(var_heightfield_data, var_268, adj_heightfield_data, adj_266, adj_267);
            wp::adj_address(var_shape_heightfield_index, var_7, adj_shape_heightfield_index, adj_7, adj_266);
            // adj: hfd = heightfield_data[shape_heightfield_index[shape_index]]                  <L 1161>
        }
        // adj: if geo_type == GeoType.HFIELD:                                                    <L 1160>
        wp::adj_where(var_248, var_261, var_245, adj_248, adj_261, adj_245, adj_263);
        wp::adj_where(var_248, var_257, var_244, adj_248, adj_257, adj_244, adj_262);
        if (var_248) {
            wp::adj_vec_t(var_258, var_259, var_260, adj_258, adj_259, adj_260, adj_261);
            // adj: n = wp.vec3(0.0, 0.0, 1.0)                                                    <L 1158>
            adj_sdf_plane_0(var_53, var_252, var_256, adj_53, adj_252, adj_256, adj_257);
            wp::adj_mul(var_254, var_255, adj_254, adj_255, adj_256);
            wp::adj_extract(var_58, var_253, adj_58, adj_253, adj_254);
            wp::adj_mul(var_250, var_251, adj_250, adj_251, adj_252);
            wp::adj_extract(var_58, var_249, adj_58, adj_249, adj_250);
            // adj: d = sdf_plane(x_local, geo_scale[0] * 0.5, geo_scale[1] * 0.5)                <L 1157>
        }
        // adj: if geo_type == GeoType.PLANE:                                                     <L 1156>
        wp::adj_where(var_169, var_234, var_72, adj_169, adj_234, adj_72, adj_246);
        wp::adj_where(var_169, var_232, var_168, adj_169, adj_232, adj_168, adj_245);
        wp::adj_where(var_169, var_230, var_167, adj_169, adj_230, adj_167, adj_244);
        if (var_169) {
            wp::adj_where(var_243, var_208, var_184, adj_205, adj_208, adj_184, adj_242);
            wp::adj_where(var_241, var_217, var_182, adj_205, adj_217, adj_182, adj_240);
            wp::adj_where(var_239, var_214, var_180, adj_205, adj_214, adj_180, adj_238);
            wp::adj_where(var_237, var_211, var_178, adj_205, adj_211, adj_178, adj_236);
            wp::adj_where(var_235, var_228, var_72, adj_205, adj_228, adj_72, adj_234);
            wp::adj_where(var_233, var_227, var_168, adj_205, adj_227, adj_168, adj_232);
            wp::adj_where(var_231, var_225, var_167, adj_205, adj_225, adj_167, adj_230);
            if (var_229) {
                wp::adj_copy(var_222, adj_222, adj_228);
                // adj: v = shape_v                                                               <L 1154>
                wp::adj_mul(var_226, var_208, adj_226, adj_208, adj_227);
                wp::adj_normalize(var_223, var_226, adj_223, adj_226);
                // adj: n = wp.normalize(delta) * sign                                            <L 1153>
                wp::adj_mul(var_224, var_208, adj_224, adj_208, adj_225);
                wp::adj_length(var_223, var_224, adj_223, adj_224);
                // adj: d = wp.length(delta) * sign                                               <L 1152>
                wp::adj_sub(var_53, var_221, adj_53, adj_221, adj_223);
                // adj: delta = x_local - shape_p                                                 <L 1150>
                wp::adj_cw_mul(var_220, var_58, adj_220, adj_58, adj_222);
                // adj: shape_v = wp.cw_mul(shape_v, geo_scale)                                   <L 1148>
                wp::adj_cw_mul(var_219, var_58, adj_219, adj_58, adj_221);
                // adj: shape_p = wp.cw_mul(shape_p, geo_scale)                                   <L 1147>
                wp::adj_mesh_eval_velocity(var_175, var_211, var_214, var_217, adj_175, adj_211, adj_214, adj_217, adj_220);
                // adj: shape_v = wp.mesh_eval_velocity(mesh, face_index, face_u, face_v)         <L 1145>
                wp::adj_mesh_eval_position(var_175, var_211, var_214, var_217, adj_175, adj_211, adj_214, adj_217, adj_219);
                // adj: shape_p = wp.mesh_eval_position(mesh, face_index, face_u, face_v)         <L 1144>
                wp::adj_copy(var_218, adj_216, adj_217);
                adj_204.v += adj_216;
                // adj: face_v = query.v                                                          <L 1142>
                wp::adj_copy(var_215, adj_213, adj_214);
                adj_204.u += adj_213;
                // adj: face_u = query.u                                                          <L 1141>
                wp::adj_copy(var_212, adj_210, adj_211);
                adj_204.face = adj_210;
                // adj: face_index = query.face                                                   <L 1140>
                wp::adj_copy(var_209, adj_207, adj_208);
                adj_204.sign += adj_207;
                // adj: sign = query.sign                                                         <L 1139>
            }
            adj_204.result = adj_205;
            // adj: if query.result:                                                              <L 1138>
            adj_mesh_query_point_sign_0(var_175, var_196, var_200, var_202, adj_175, adj_196, adj_200, adj_202, adj_204);
            adj_resolve_mesh_sign_method_0(var_203, adj_201, adj_202);
            wp::adj_address(var_shape_mesh_properties, var_7, adj_shape_mesh_properties, adj_7, adj_201);
            // adj: resolve_mesh_sign_method(shape_mesh_properties[shape_index]),                 <L 1136>
            wp::adj_add(var_198, var_199, adj_198, adj_199, adj_200);
            wp::adj_div(var_39, var_195, var_199, adj_39, adj_195, adj_199);
            wp::adj_add(var_margin, var_197, adj_margin, adj_197, adj_198);
            wp::adj_div(var_69, var_195, var_197, adj_69, adj_195, adj_197);
            // adj: margin + s_margin / min_scale + radius / min_scale,                           <L 1135>
            wp::adj_cw_div(var_53, var_58, var_196, adj_53, adj_58, adj_196);
            // adj: wp.cw_div(x_local, geo_scale),                                                <L 1134>
            // adj: mesh,                                                                         <L 1133>
            // adj: query = mesh_query_point_sign(                                                <L 1132>
            wp::adj_min(var_191, var_194, adj_191, adj_194, adj_195);
            wp::adj_abs(var_193, adj_193, adj_194);
            wp::adj_extract(var_58, var_192, adj_58, adj_192, adj_193);
            wp::adj_min(var_187, var_190, adj_187, adj_190, adj_191);
            wp::adj_abs(var_189, adj_189, adj_190);
            wp::adj_extract(var_58, var_188, adj_58, adj_188, adj_189);
            wp::adj_abs(var_186, adj_186, adj_187);
            wp::adj_extract(var_58, var_185, adj_58, adj_185, adj_186);
            // adj: min_scale = wp.min(wp.min(wp.abs(geo_scale[0]), wp.abs(geo_scale[1])), wp.abs(geo_scale[2]))  <L 1131>
            wp::adj_float(var_183, adj_183, adj_184);
            // adj: sign = float(0.0)                                                             <L 1127>
            wp::adj_float(var_181, adj_181, adj_182);
            // adj: face_v = float(0.0)                                                           <L 1126>
            wp::adj_float(var_179, adj_179, adj_180);
            // adj: face_u = float(0.0)                                                           <L 1125>
            // adj: face_index = int(0)                                                           <L 1124>
            wp::adj_copy(var_176, adj_174, adj_175);
            wp::adj_address(var_shape_source_ptr, var_7, adj_shape_source_ptr, adj_7, adj_174);
            // adj: mesh = shape_source_ptr[shape_index]                                          <L 1122>
        }
        if (!var_169) {
        }
        // adj: if geo_type == GeoType.MESH or geo_type == GeoType.CONVEX_MESH:                   <L 1121>
        wp::adj_where(var_164, var_166, var_162, adj_164, adj_166, adj_162, adj_168);
        wp::adj_where(var_164, var_165, var_161, adj_164, adj_165, adj_161, adj_167);
        if (var_164) {
            adj_sdf_ellipsoid_grad_0(var_53, var_58, adj_53, adj_58, adj_166);
            // adj: n = sdf_ellipsoid_grad(x_local, geo_scale)                                    <L 1119>
            adj_sdf_ellipsoid_0(var_53, var_58, adj_53, adj_58, adj_165);
            // adj: d = sdf_ellipsoid(x_local, geo_scale)                                         <L 1118>
        }
        // adj: if geo_type == GeoType.ELLIPSOID:                                                 <L 1117>
        wp::adj_where(var_144, var_160, var_142, adj_144, adj_160, adj_142, adj_162);
        wp::adj_where(var_144, var_152, var_141, adj_144, adj_152, adj_141, adj_161);
        if (var_144) {
            adj_sdf_cone_grad_0(var_53, var_154, var_156, var_159, adj_53, adj_154, adj_156, adj_159, adj_160);
            wp::adj_extract(var_58, var_155, adj_58, adj_155, adj_156);
            wp::adj_extract(var_58, var_153, adj_58, adj_153, adj_154);
            // adj: n = sdf_cone_grad(x_local, geo_scale[0], geo_scale[1], int(Axis.Z))           <L 1115>
            adj_sdf_cone_0(var_53, var_146, var_148, var_151, adj_53, adj_146, adj_148, adj_151, adj_152);
            wp::adj_extract(var_58, var_147, adj_58, adj_147, adj_148);
            wp::adj_extract(var_58, var_145, adj_58, adj_145, adj_146);
            // adj: d = sdf_cone(x_local, geo_scale[0], geo_scale[1], int(Axis.Z))                <L 1114>
        }
        // adj: if geo_type == GeoType.CONE:                                                      <L 1113>
        wp::adj_where(var_122, var_139, var_120, adj_122, adj_139, adj_120, adj_142);
        wp::adj_where(var_122, var_130, var_119, adj_122, adj_130, adj_119, adj_141);
        if (var_122) {
            adj_sdf_cylinder_grad_0(var_53, var_133, var_135, var_138, var_140, adj_53, adj_133, adj_135, adj_138, adj_140, adj_139);
            wp::adj_extract(var_58, var_134, adj_58, adj_134, adj_135);
            wp::adj_extract(var_58, var_132, adj_58, adj_132, adj_133);
            // adj: n = sdf_cylinder_grad(x_local, geo_scale[0], geo_scale[1], int(Axis.Z))       <L 1111>
            adj_sdf_cylinder_0(var_53, var_124, var_126, var_129, var_131, adj_53, adj_124, adj_126, adj_129, adj_131, adj_130);
            wp::adj_extract(var_58, var_125, adj_58, adj_125, adj_126);
            wp::adj_extract(var_58, var_123, adj_58, adj_123, adj_124);
            // adj: d = sdf_cylinder(x_local, geo_scale[0], geo_scale[1], int(Axis.Z))            <L 1110>
        }
        // adj: if geo_type == GeoType.CYLINDER:                                                  <L 1109>
        wp::adj_where(var_102, var_118, var_100, adj_102, adj_118, adj_100, adj_120);
        wp::adj_where(var_102, var_110, var_99, adj_102, adj_110, adj_99, adj_119);
        if (var_102) {
            adj_sdf_capsule_grad_0(var_53, var_112, var_114, var_117, adj_53, adj_112, adj_114, adj_117, adj_118);
            wp::adj_extract(var_58, var_113, adj_58, adj_113, adj_114);
            wp::adj_extract(var_58, var_111, adj_58, adj_111, adj_112);
            // adj: n = sdf_capsule_grad(x_local, geo_scale[0], geo_scale[1], int(Axis.Z))        <L 1107>
            adj_sdf_capsule_0(var_53, var_104, var_106, var_109, adj_53, adj_104, adj_106, adj_109, adj_110);
            wp::adj_extract(var_58, var_105, adj_58, adj_105, adj_106);
            wp::adj_extract(var_58, var_103, adj_58, adj_103, adj_104);
            // adj: d = sdf_capsule(x_local, geo_scale[0], geo_scale[1], int(Axis.Z))             <L 1106>
        }
        // adj: if geo_type == GeoType.CAPSULE:                                                   <L 1105>
        wp::adj_where(var_84, var_98, var_82, adj_84, adj_98, adj_82, adj_100);
        wp::adj_where(var_84, var_91, var_81, adj_84, adj_91, adj_81, adj_99);
        if (var_84) {
            adj_sdf_box_grad_0(var_53, var_93, var_95, var_97, adj_53, adj_93, adj_95, adj_97, adj_98);
            wp::adj_extract(var_58, var_96, adj_58, adj_96, adj_97);
            wp::adj_extract(var_58, var_94, adj_58, adj_94, adj_95);
            wp::adj_extract(var_58, var_92, adj_58, adj_92, adj_93);
            // adj: n = sdf_box_grad(x_local, geo_scale[0], geo_scale[1], geo_scale[2])           <L 1103>
            adj_sdf_box_0(var_53, var_86, var_88, var_90, adj_53, adj_86, adj_88, adj_90, adj_91);
            wp::adj_extract(var_58, var_89, adj_58, adj_89, adj_90);
            wp::adj_extract(var_58, var_87, adj_58, adj_87, adj_88);
            wp::adj_extract(var_58, var_85, adj_58, adj_85, adj_86);
            // adj: d = sdf_box(x_local, geo_scale[0], geo_scale[1], geo_scale[2])                <L 1102>
        }
        // adj: if geo_type == GeoType.BOX:                                                       <L 1101>
        wp::adj_where(var_74, var_80, var_71, adj_74, adj_80, adj_71, adj_82);
        wp::adj_where(var_74, var_77, var_70, adj_74, adj_77, adj_70, adj_81);
        if (var_74) {
            adj_sdf_sphere_grad_0(var_53, var_79, adj_53, adj_79, adj_80);
            wp::adj_extract(var_58, var_78, adj_58, adj_78, adj_79);
            // adj: n = sdf_sphere_grad(x_local, geo_scale[0])                                    <L 1099>
            adj_sdf_sphere_0(var_53, var_76, adj_53, adj_76, adj_77);
            wp::adj_extract(var_58, var_75, adj_58, adj_75, adj_76);
            // adj: d = sdf_sphere(x_local, geo_scale[0])                                         <L 1098>
        }
        // adj: if geo_type == GeoType.SPHERE:                                                    <L 1097>
        // adj: v = wp.vec3()                                                                     <L 1095>
        // adj: n = wp.vec3()                                                                     <L 1094>
        // adj: d = 1.0e6                                                                         <L 1093>
        wp::adj_where(var_65, var_67, var_68, adj_65, adj_67, adj_68, adj_69);
        if (!var_65) {
        }
        if (var_65) {
            wp::adj_address(var_shape_margin, var_7, adj_shape_margin, adj_7, adj_66);
        }
        adj_shape_margin.shape = adj_60;
        // adj: s_margin = shape_margin[shape_index] if shape_margin.shape[0] > 0 else 0.0        <L 1090>
        wp::adj_copy(var_59, adj_57, adj_58);
        wp::adj_address(var_shape_scale, var_7, adj_shape_scale, adj_7, adj_57);
        // adj: geo_scale = shape_scale[shape_index]                                              <L 1089>
        wp::adj_copy(var_56, adj_54, adj_55);
        wp::adj_address(var_shape_type, var_7, adj_shape_type, adj_7, adj_54);
        // adj: geo_type = shape_type[shape_index]                                                <L 1088>
        wp::adj_transform_point(var_52, var_36, adj_52, adj_36, adj_53);
        // adj: x_local = wp.transform_point(X_sw, px)                                            <L 1085>
        wp::adj_transform_inverse(var_51, adj_51, adj_52);
        // adj: X_sw = wp.transform_inverse(X_ws)                                                 <L 1082>
        wp::adj_transform_multiply(var_47, var_49, adj_47, adj_49, adj_51);
        // adj: X_ws = wp.transform_multiply(X_wb, X_bs)                                          <L 1081>
        wp::adj_copy(var_50, adj_48, adj_49);
        wp::adj_address(var_shape_transform, var_7, adj_shape_transform, adj_7, adj_48);
        // adj: X_bs = shape_transform[shape_index]                                               <L 1079>
        wp::adj_where(var_43, var_45, var_41, adj_43, adj_45, adj_41, adj_47);
        if (var_43) {
            wp::adj_copy(var_46, adj_44, adj_45);
            wp::adj_address(var_body_q, var_33, adj_body_q, adj_33, adj_44);
            // adj: X_wb = body_q[rigid_index]                                                    <L 1077>
        }
        // adj: if rigid_index >= 0:                                                              <L 1076>
        // adj: X_wb = wp.transform_identity()                                                    <L 1075>
        wp::adj_copy(var_40, adj_38, adj_39);
        wp::adj_address(var_particle_radius, var_5, adj_particle_radius, adj_5, adj_38);
        // adj: radius = particle_radius[particle_index]                                          <L 1073>
        wp::adj_copy(var_37, adj_35, adj_36);
        wp::adj_address(var_particle_q, var_5, adj_particle_q, adj_5, adj_35);
        // adj: px = particle_q[particle_index]                                                   <L 1072>
        wp::adj_copy(var_34, adj_32, adj_33);
        wp::adj_address(var_shape_body, var_7, adj_shape_body, adj_7, adj_32);
        // adj: rigid_index = shape_body[shape_index]                                             <L 1070>
        if (var_26) {
            label2:;
            // adj: return                                                                        <L 1068>
        }
        if (var_26) {
        }
        if (var_26) {
        }
        // adj: if particle_world_id != -1 and shape_world_id != -1 and particle_world_id != shape_world_id:  <L 1067>
        wp::adj_copy(var_25, adj_23, adj_24);
        wp::adj_address(var_shape_world, var_7, adj_shape_world, adj_7, adj_23);
        // adj: shape_world_id = shape_world[shape_index]                                         <L 1064>
        wp::adj_copy(var_22, adj_20, adj_21);
        wp::adj_address(var_particle_world, var_5, adj_particle_world, adj_5, adj_20);
        // adj: particle_world_id = particle_world[particle_index]                                <L 1063>
        if (var_19) {
            label1:;
            // adj: return                                                                        <L 1060>
        }
        wp::adj_address(var_shape_flags, var_7, adj_shape_flags, adj_7, adj_14);
        // adj: if (shape_flags[shape_index] & ShapeFlags.COLLIDE_PARTICLES) == 0:                <L 1059>
        if (var_13) {
            label0:;
            // adj: return                                                                        <L 1058>
        }
        wp::adj_address(var_particle_flags, var_5, adj_particle_flags, adj_5, adj_8);
        // adj: if (particle_flags[particle_index] & ParticleFlags.ACTIVE) == 0:                  <L 1057>
        wp::adj_extract(var_2, var_6, adj_2, adj_6, adj_7);
        // adj: shape_index = pair[1]                                                             <L 1056>
        wp::adj_extract(var_2, var_4, adj_2, adj_4, adj_5);
        // adj: particle_index = pair[0]                                                          <L 1055>
        wp::adj_copy(var_3, adj_1, adj_2);
        wp::adj_address(var_soft_rigid_contact_pairs, var_0, adj_soft_rigid_contact_pairs, adj_0, adj_1);
        // adj: pair = soft_rigid_contact_pairs[tid]                                              <L 1054>
        // adj: tid = wp.tid()                                                                    <L 1053>
        // adj: def create_soft_contacts(                                                         <L 1021>
        continue;
    }
}



extern "C" __global__ void compute_tri_aabbs_e943cdb7_cuda_kernel_forward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::vec_t<3, wp::float32>> var_pos,
    wp::array_t<wp::int32> var_tri_indices,
    wp::array_t<wp::vec_t<3, wp::float32>> var_lower_bounds,
    wp::array_t<wp::vec_t<3, wp::float32>> var_upper_bounds)
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
        const wp::int32 var_1 = 0;
        wp::int32* var_2;
        wp::vec_t<3, wp::float32>* var_3;
        wp::int32 var_4;
        wp::vec_t<3, wp::float32> var_5;
        wp::vec_t<3, wp::float32> var_6;
        const wp::int32 var_7 = 1;
        wp::int32* var_8;
        wp::vec_t<3, wp::float32>* var_9;
        wp::int32 var_10;
        wp::vec_t<3, wp::float32> var_11;
        wp::vec_t<3, wp::float32> var_12;
        const wp::int32 var_13 = 2;
        wp::int32* var_14;
        wp::vec_t<3, wp::float32>* var_15;
        wp::int32 var_16;
        wp::vec_t<3, wp::float32> var_17;
        wp::vec_t<3, wp::float32> var_18;
        wp::vec_t<3, wp::float32> var_19;
        wp::vec_t<3, wp::float32> var_20;
        //---------
        // forward
        // def compute_tri_aabbs(                                                                 <L 1219>
        // t_id = wp.tid()                                                                        <L 1225>
        var_0 = builtin_tid1d();
        // v1 = pos[tri_indices[t_id, 0]]                                                         <L 1227>
        var_2 = wp::address(var_tri_indices, var_0, var_1);
        var_4 = wp::load(var_2);
        var_3 = wp::address(var_pos, var_4);
        var_6 = wp::load(var_3);
        var_5 = wp::copy(var_6);
        // v2 = pos[tri_indices[t_id, 1]]                                                         <L 1228>
        var_8 = wp::address(var_tri_indices, var_0, var_7);
        var_10 = wp::load(var_8);
        var_9 = wp::address(var_pos, var_10);
        var_12 = wp::load(var_9);
        var_11 = wp::copy(var_12);
        // v3 = pos[tri_indices[t_id, 2]]                                                         <L 1229>
        var_14 = wp::address(var_tri_indices, var_0, var_13);
        var_16 = wp::load(var_14);
        var_15 = wp::address(var_pos, var_16);
        var_18 = wp::load(var_15);
        var_17 = wp::copy(var_18);
        // lower, upper = compute_tri_aabb(v1, v2, v3)                                            <L 1231>
        compute_tri_aabb_0(var_5, var_11, var_17, var_19, var_20);
        // lower_bounds[t_id] = lower                                                             <L 1233>
        wp::array_store(var_lower_bounds, var_0, var_19);
        // upper_bounds[t_id] = upper                                                             <L 1234>
        wp::array_store(var_upper_bounds, var_0, var_20);
    }
}



extern "C" __global__ void compute_tri_aabbs_e943cdb7_cuda_kernel_backward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::vec_t<3, wp::float32>> var_pos,
    wp::array_t<wp::int32> var_tri_indices,
    wp::array_t<wp::vec_t<3, wp::float32>> var_lower_bounds,
    wp::array_t<wp::vec_t<3, wp::float32>> var_upper_bounds,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_pos,
    wp::array_t<wp::int32> adj_tri_indices,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_lower_bounds,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_upper_bounds)
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
        const wp::int32 var_1 = 0;
        wp::int32* var_2;
        wp::vec_t<3, wp::float32>* var_3;
        wp::int32 var_4;
        wp::vec_t<3, wp::float32> var_5;
        wp::vec_t<3, wp::float32> var_6;
        const wp::int32 var_7 = 1;
        wp::int32* var_8;
        wp::vec_t<3, wp::float32>* var_9;
        wp::int32 var_10;
        wp::vec_t<3, wp::float32> var_11;
        wp::vec_t<3, wp::float32> var_12;
        const wp::int32 var_13 = 2;
        wp::int32* var_14;
        wp::vec_t<3, wp::float32>* var_15;
        wp::int32 var_16;
        wp::vec_t<3, wp::float32> var_17;
        wp::vec_t<3, wp::float32> var_18;
        wp::vec_t<3, wp::float32> var_19;
        wp::vec_t<3, wp::float32> var_20;
        //---------
        // dual vars
        wp::int32 adj_0 = {};
        wp::int32 adj_1 = {};
        wp::int32 adj_2 = {};
        wp::vec_t<3, wp::float32> adj_3 = {};
        wp::int32 adj_4 = {};
        wp::vec_t<3, wp::float32> adj_5 = {};
        wp::vec_t<3, wp::float32> adj_6 = {};
        wp::int32 adj_7 = {};
        wp::int32 adj_8 = {};
        wp::vec_t<3, wp::float32> adj_9 = {};
        wp::int32 adj_10 = {};
        wp::vec_t<3, wp::float32> adj_11 = {};
        wp::vec_t<3, wp::float32> adj_12 = {};
        wp::int32 adj_13 = {};
        wp::int32 adj_14 = {};
        wp::vec_t<3, wp::float32> adj_15 = {};
        wp::int32 adj_16 = {};
        wp::vec_t<3, wp::float32> adj_17 = {};
        wp::vec_t<3, wp::float32> adj_18 = {};
        wp::vec_t<3, wp::float32> adj_19 = {};
        wp::vec_t<3, wp::float32> adj_20 = {};
        //---------
        // forward
        // def compute_tri_aabbs(                                                                 <L 1219>
        // t_id = wp.tid()                                                                        <L 1225>
        var_0 = builtin_tid1d();
        // v1 = pos[tri_indices[t_id, 0]]                                                         <L 1227>
        var_2 = wp::address(var_tri_indices, var_0, var_1);
        var_4 = wp::load(var_2);
        var_3 = wp::address(var_pos, var_4);
        var_6 = wp::load(var_3);
        var_5 = wp::copy(var_6);
        // v2 = pos[tri_indices[t_id, 1]]                                                         <L 1228>
        var_8 = wp::address(var_tri_indices, var_0, var_7);
        var_10 = wp::load(var_8);
        var_9 = wp::address(var_pos, var_10);
        var_12 = wp::load(var_9);
        var_11 = wp::copy(var_12);
        // v3 = pos[tri_indices[t_id, 2]]                                                         <L 1229>
        var_14 = wp::address(var_tri_indices, var_0, var_13);
        var_16 = wp::load(var_14);
        var_15 = wp::address(var_pos, var_16);
        var_18 = wp::load(var_15);
        var_17 = wp::copy(var_18);
        // lower, upper = compute_tri_aabb(v1, v2, v3)                                            <L 1231>
        compute_tri_aabb_0(var_5, var_11, var_17, var_19, var_20);
        // lower_bounds[t_id] = lower                                                             <L 1233>
        // wp::array_store(var_lower_bounds, var_0, var_19);
        // upper_bounds[t_id] = upper                                                             <L 1234>
        // wp::array_store(var_upper_bounds, var_0, var_20);
        //---------
        // reverse
        wp::adj_array_store(var_upper_bounds, var_0, var_20, adj_upper_bounds, adj_0, adj_20);
        // adj: upper_bounds[t_id] = upper                                                        <L 1234>
        wp::adj_array_store(var_lower_bounds, var_0, var_19, adj_lower_bounds, adj_0, adj_19);
        // adj: lower_bounds[t_id] = lower                                                        <L 1233>
        adj_compute_tri_aabb_0(var_5, var_11, var_17, var_19, var_20, adj_5, adj_11, adj_17, adj_19, adj_20);
        // adj: lower, upper = compute_tri_aabb(v1, v2, v3)                                       <L 1231>
        wp::adj_copy(var_18, adj_15, adj_17);
        wp::adj_address(var_pos, var_16, adj_pos, adj_14, adj_15);
        wp::adj_address(var_tri_indices, var_0, var_13, adj_tri_indices, adj_0, adj_13, adj_14);
        // adj: v3 = pos[tri_indices[t_id, 2]]                                                    <L 1229>
        wp::adj_copy(var_12, adj_9, adj_11);
        wp::adj_address(var_pos, var_10, adj_pos, adj_8, adj_9);
        wp::adj_address(var_tri_indices, var_0, var_7, adj_tri_indices, adj_0, adj_7, adj_8);
        // adj: v2 = pos[tri_indices[t_id, 1]]                                                    <L 1228>
        wp::adj_copy(var_6, adj_3, adj_5);
        wp::adj_address(var_pos, var_4, adj_pos, adj_2, adj_3);
        wp::adj_address(var_tri_indices, var_0, var_1, adj_tri_indices, adj_0, adj_1, adj_2);
        // adj: v1 = pos[tri_indices[t_id, 0]]                                                    <L 1227>
        // adj: t_id = wp.tid()                                                                   <L 1225>
        // adj: def compute_tri_aabbs(                                                            <L 1219>
        continue;
    }
}



extern "C" __global__ void vertex_triangle_collision_detection_kernel_723f98e4_cuda_kernel_forward(
    wp::launch_bounds_t<1> dim,
    wp::float32 var_max_query_radius,
    wp::float32 var_min_query_radius,
    wp::uint64 var_bvh_id,
    wp::array_t<wp::int32> var_bvh_group_roots,
    wp::array_t<wp::vec_t<3, wp::float32>> var_pos,
    wp::array_t<wp::int32> var_tri_indices,
    wp::array_t<wp::int32> var_particle_world,
    wp::int32 var_world_count,
    wp::array_t<wp::int32> var_vertex_colliding_triangles_offsets,
    wp::array_t<wp::int32> var_vertex_colliding_triangles_buffer_sizes,
    wp::array_t<wp::int32> var_triangle_colliding_vertices_offsets,
    wp::array_t<wp::int32> var_triangle_colliding_vertices_buffer_sizes,
    wp::array_t<wp::int32> var_vertex_triangle_filtering_list,
    wp::array_t<wp::int32> var_vertex_triangle_filtering_list_offsets,
    wp::array_t<wp::vec_t<3, wp::float32>> var_min_distance_filtering_ref_pos,
    wp::array_t<wp::int32> var_vertex_colliding_triangles,
    wp::array_t<wp::int32> var_vertex_colliding_triangles_count,
    wp::array_t<wp::float32> var_vertex_colliding_triangles_min_dist,
    wp::array_t<wp::int32> var_triangle_colliding_vertices,
    wp::array_t<wp::int32> var_triangle_colliding_vertices_count,
    wp::array_t<wp::float32> var_triangle_colliding_vertices_min_dist,
    wp::array_t<wp::int32> var_resize_flags)
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
        wp::vec_t<3, wp::float32>* var_1;
        wp::vec_t<3, wp::float32> var_2;
        wp::vec_t<3, wp::float32> var_3;
        wp::int32* var_4;
        wp::int32 var_5;
        wp::int32 var_6;
        const wp::int32 var_7 = 1;
        wp::int32 var_8;
        wp::int32* var_9;
        wp::int32 var_10;
        wp::int32 var_11;
        const wp::int32 var_12 = 0;
        wp::float32 var_13;
        wp::float32 var_14;
        const wp::int32 var_15 = 1;
        wp::float32 var_16;
        wp::float32 var_17;
        const wp::int32 var_18 = 2;
        wp::float32 var_19;
        wp::float32 var_20;
        wp::vec_t<3, wp::float32> var_21;
        const wp::int32 var_22 = 0;
        wp::float32 var_23;
        wp::float32 var_24;
        const wp::int32 var_25 = 1;
        wp::float32 var_26;
        wp::float32 var_27;
        const wp::int32 var_28 = 2;
        wp::float32 var_29;
        wp::float32 var_30;
        wp::vec_t<3, wp::float32> var_31;
        const wp::int32 var_32 = 0;
        wp::int32 var_33;
        const wp::int32 var_34 = 0;
        wp::int32 var_35;
        wp::float32 var_36;
        wp::int32* var_37;
        wp::int32 var_38;
        wp::int32 var_39;
        const wp::int32 var_40 = 0;
        const bool var_41 = false;
        bool var_42;
        const bool var_43 = false;
        bool var_44;
        const wp::int32 var_45 = -1;
        wp::int32 var_46;
        const wp::int32 var_47 = 0;
        bool var_48;
        const wp::int32 var_49 = 0;
        bool var_50;
        const bool var_51 = true;
        const bool var_52 = true;
        bool var_53;
        bool var_54;
        const wp::int32 var_55 = 0;
        bool var_56;
        wp::int32* var_57;
        wp::int32 var_58;
        wp::int32 var_59;
        wp::int32* var_60;
        wp::int32 var_61;
        wp::int32 var_62;
        wp::int32 var_63;
        const wp::int32 var_64 = 0;
        bool var_65;
        bool var_66;
        bool var_67;
        wp::int32 var_68;
        wp::bvh_query_t var_69;
        const wp::int32 var_70 = -1;
        wp::bvh_query_t var_71;
        wp::bvh_query_t var_72;
        const wp::int32 var_73 = 0;
        wp::int32 var_74;
        bool var_75;
        const wp::float32 var_76 = INFINITY;
        const wp::int32 var_77 = 0;
        wp::int32* var_78;
        wp::int32 var_79;
        wp::int32 var_80;
        const wp::int32 var_81 = 1;
        wp::int32* var_82;
        wp::int32 var_83;
        wp::int32 var_84;
        const wp::int32 var_85 = 2;
        wp::int32* var_86;
        wp::int32 var_87;
        wp::int32 var_88;
        bool var_89;
        wp::int32* var_90;
        wp::int32 var_91;
        wp::int32 var_92;
        const wp::int32 var_93 = 1;
        wp::int32 var_94;
        wp::int32* var_95;
        wp::int32 var_96;
        wp::int32 var_97;
        bool var_98;
        wp::int32* var_99;
        wp::int32 var_100;
        wp::int32 var_101;
        const wp::int32 var_102 = 1;
        wp::int32 var_103;
        wp::int32* var_104;
        wp::int32 var_105;
        wp::int32 var_106;
        bool var_107;
        bool var_108;
        bool var_109;
        wp::int32 var_110;
        bool var_111;
        bool var_112;
        const wp::int32 var_113 = 1;
        wp::int32 var_114;
        wp::int32* var_115;
        bool var_116;
        wp::int32 var_117;
        wp::vec_t<3, wp::float32>* var_118;
        wp::vec_t<3, wp::float32> var_119;
        wp::vec_t<3, wp::float32> var_120;
        wp::vec_t<3, wp::float32>* var_121;
        wp::vec_t<3, wp::float32> var_122;
        wp::vec_t<3, wp::float32> var_123;
        wp::vec_t<3, wp::float32>* var_124;
        wp::vec_t<3, wp::float32> var_125;
        wp::vec_t<3, wp::float32> var_126;
        wp::vec_t<3, wp::float32> var_127;
        wp::vec_t<3, wp::float32> var_128;
        wp::int32 var_129;
        wp::vec_t<3, wp::float32> var_130;
        wp::float32 var_131;
        bool var_132;
        const wp::float32 var_133 = 0.0;
        bool var_134;
        wp::vec_t<3, wp::float32>* var_135;
        wp::vec_t<3, wp::float32>* var_136;
        wp::vec_t<3, wp::float32>* var_137;
        wp::vec_t<3, wp::float32>* var_138;
        wp::vec_t<3, wp::float32> var_139;
        wp::vec_t<3, wp::float32> var_140;
        wp::int32 var_141;
        wp::vec_t<3, wp::float32> var_142;
        wp::vec_t<3, wp::float32> var_143;
        wp::vec_t<3, wp::float32> var_144;
        wp::vec_t<3, wp::float32> var_145;
        wp::vec_t<3, wp::float32>* var_146;
        wp::vec_t<3, wp::float32> var_147;
        wp::vec_t<3, wp::float32> var_148;
        wp::float32 var_149;
        bool var_150;
        bool var_151;
        wp::float32 var_152;
        bool var_153;
        const wp::int32 var_154 = 2;
        wp::int32 var_155;
        wp::int32 var_156;
        const wp::int32 var_157 = 2;
        wp::int32 var_158;
        wp::int32 var_159;
        const wp::int32 var_160 = 1;
        wp::int32 var_161;
        const wp::int32 var_162 = 1;
        const wp::int32 var_163 = 0;
        const wp::int32 var_164 = 1;
        wp::int32 var_165;
        wp::float32 var_166;
        wp::int32* var_167;
        wp::int32 var_168;
        wp::int32 var_169;
        const wp::int32 var_170 = 1;
        wp::int32 var_171;
        bool var_172;
        wp::int32* var_173;
        wp::int32 var_174;
        wp::int32 var_175;
        wp::int32 var_176;
        const wp::int32 var_177 = 1;
        const wp::int32 var_178 = 1;
        wp::int32 var_179;
        wp::float32 var_180;
        wp::int32 var_181;
        const wp::int32 var_182 = 1;
        const bool var_183 = false;
        bool var_184;
        const bool var_185 = false;
        bool var_186;
        const wp::int32 var_187 = -1;
        wp::int32 var_188;
        const wp::int32 var_189 = 0;
        bool var_190;
        const wp::int32 var_191 = 0;
        bool var_192;
        const bool var_193 = true;
        const bool var_194 = true;
        bool var_195;
        bool var_196;
        const wp::int32 var_197 = 0;
        bool var_198;
        wp::int32* var_199;
        wp::int32 var_200;
        wp::int32 var_201;
        wp::int32* var_202;
        wp::int32 var_203;
        wp::int32 var_204;
        wp::int32 var_205;
        const wp::int32 var_206 = 0;
        bool var_207;
        bool var_208;
        bool var_209;
        wp::int32 var_210;
        wp::bvh_query_t var_211;
        const wp::int32 var_212 = -1;
        wp::bvh_query_t var_213;
        wp::bvh_query_t var_214;
        const wp::int32 var_215 = 0;
        wp::int32 var_216;
        bool var_217;
        const wp::float32 var_218 = INFINITY;
        const wp::int32 var_219 = 0;
        wp::int32* var_220;
        wp::int32 var_221;
        wp::int32 var_222;
        const wp::int32 var_223 = 1;
        wp::int32* var_224;
        wp::int32 var_225;
        wp::int32 var_226;
        const wp::int32 var_227 = 2;
        wp::int32* var_228;
        wp::int32 var_229;
        wp::int32 var_230;
        bool var_231;
        wp::int32 var_232;
        wp::int32 var_233;
        wp::int32 var_234;
        wp::int32* var_235;
        wp::int32 var_236;
        wp::int32 var_237;
        const wp::int32 var_238 = 1;
        wp::int32 var_239;
        wp::int32* var_240;
        wp::int32 var_241;
        wp::int32 var_242;
        bool var_243;
        wp::int32* var_244;
        wp::int32 var_245;
        wp::int32 var_246;
        const wp::int32 var_247 = 1;
        wp::int32 var_248;
        wp::int32* var_249;
        wp::int32 var_250;
        wp::int32 var_251;
        bool var_252;
        bool var_253;
        bool var_254;
        wp::int32 var_255;
        bool var_256;
        bool var_257;
        const wp::int32 var_258 = 1;
        wp::int32 var_259;
        wp::int32* var_260;
        bool var_261;
        wp::int32 var_262;
        wp::int32 var_263;
        wp::int32 var_264;
        wp::int32 var_265;
        wp::int32 var_266;
        wp::int32 var_267;
        wp::int32 var_268;
        wp::int32 var_269;
        wp::int32 var_270;
        wp::int32 var_271;
        wp::int32 var_272;
        wp::int32 var_273;
        wp::int32 var_274;
        wp::int32 var_275;
        wp::int32 var_276;
        wp::int32 var_277;
        wp::int32 var_278;
        wp::int32 var_279;
        wp::int32 var_280;
        wp::int32 var_281;
        wp::int32 var_282;
        wp::int32 var_283;
        wp::int32 var_284;
        wp::int32 var_285;
        wp::int32 var_286;
        wp::int32 var_287;
        wp::int32 var_288;
        wp::int32 var_289;
        wp::int32 var_290;
        wp::int32 var_291;
        wp::int32 var_292;
        wp::int32 var_293;
        wp::int32 var_294;
        wp::vec_t<3, wp::float32>* var_295;
        wp::vec_t<3, wp::float32> var_296;
        wp::vec_t<3, wp::float32> var_297;
        wp::vec_t<3, wp::float32>* var_298;
        wp::vec_t<3, wp::float32> var_299;
        wp::vec_t<3, wp::float32> var_300;
        wp::vec_t<3, wp::float32>* var_301;
        wp::vec_t<3, wp::float32> var_302;
        wp::vec_t<3, wp::float32> var_303;
        wp::vec_t<3, wp::float32> var_304;
        wp::vec_t<3, wp::float32> var_305;
        wp::int32 var_306;
        wp::vec_t<3, wp::float32> var_307;
        wp::float32 var_308;
        bool var_309;
        const wp::float32 var_310 = 0.0;
        bool var_311;
        wp::vec_t<3, wp::float32>* var_312;
        wp::vec_t<3, wp::float32>* var_313;
        wp::vec_t<3, wp::float32>* var_314;
        wp::vec_t<3, wp::float32>* var_315;
        wp::vec_t<3, wp::float32> var_316;
        wp::vec_t<3, wp::float32> var_317;
        wp::int32 var_318;
        wp::vec_t<3, wp::float32> var_319;
        wp::vec_t<3, wp::float32> var_320;
        wp::vec_t<3, wp::float32> var_321;
        wp::vec_t<3, wp::float32> var_322;
        wp::vec_t<3, wp::float32>* var_323;
        wp::vec_t<3, wp::float32> var_324;
        wp::vec_t<3, wp::float32> var_325;
        wp::float32 var_326;
        bool var_327;
        wp::int32 var_328;
        wp::int32 var_329;
        wp::int32 var_330;
        wp::int32 var_331;
        wp::int32 var_332;
        wp::int32 var_333;
        wp::int32 var_334;
        wp::int32 var_335;
        wp::vec_t<3, wp::float32> var_336;
        wp::vec_t<3, wp::float32> var_337;
        wp::vec_t<3, wp::float32> var_338;
        wp::vec_t<3, wp::float32> var_339;
        wp::vec_t<3, wp::float32> var_340;
        wp::int32 var_341;
        wp::float32 var_342;
        wp::vec_t<3, wp::float32> var_343;
        wp::vec_t<3, wp::float32> var_344;
        wp::int32 var_345;
        wp::float32 var_346;
        wp::int32 var_347;
        wp::int32 var_348;
        wp::int32 var_349;
        wp::int32 var_350;
        wp::int32 var_351;
        wp::int32 var_352;
        wp::int32 var_353;
        wp::int32 var_354;
        wp::vec_t<3, wp::float32> var_355;
        wp::vec_t<3, wp::float32> var_356;
        wp::vec_t<3, wp::float32> var_357;
        wp::vec_t<3, wp::float32> var_358;
        wp::vec_t<3, wp::float32> var_359;
        wp::int32 var_360;
        wp::float32 var_361;
        wp::vec_t<3, wp::float32> var_362;
        wp::vec_t<3, wp::float32> var_363;
        wp::int32 var_364;
        wp::float32 var_365;
        bool var_366;
        wp::float32 var_367;
        bool var_368;
        const wp::int32 var_369 = 2;
        wp::int32 var_370;
        wp::int32 var_371;
        const wp::int32 var_372 = 2;
        wp::int32 var_373;
        wp::int32 var_374;
        const wp::int32 var_375 = 1;
        wp::int32 var_376;
        const wp::int32 var_377 = 1;
        const wp::int32 var_378 = 1;
        wp::int32 var_379;
        wp::float32 var_380;
        wp::int32* var_381;
        wp::int32 var_382;
        wp::int32 var_383;
        const wp::int32 var_384 = 1;
        wp::int32 var_385;
        bool var_386;
        wp::int32* var_387;
        wp::int32 var_388;
        wp::int32 var_389;
        wp::int32 var_390;
        const wp::int32 var_391 = 1;
        wp::int32 var_392;
        wp::int32 var_393;
        wp::int32 var_394;
        wp::int32 var_395;
        wp::int32 var_396;
        wp::float32 var_397;
        wp::int32 var_398;
        wp::int32 var_399;
        wp::int32 var_400;
        wp::int32 var_401;
        wp::bvh_query_t var_402;
        //---------
        // forward
        // def vertex_triangle_collision_detection_kernel(                                        <L 1329>
        // v_index = wp.tid()                                                                     <L 1388>
        var_0 = builtin_tid1d();
        // v = pos[v_index]                                                                       <L 1389>
        var_1 = wp::address(var_pos, var_0);
        var_3 = wp::load(var_1);
        var_2 = wp::copy(var_3);
        // vertex_buffer_offset = vertex_colliding_triangles_offsets[v_index]                     <L 1390>
        var_4 = wp::address(var_vertex_colliding_triangles_offsets, var_0);
        var_6 = wp::load(var_4);
        var_5 = wp::copy(var_6);
        // vertex_buffer_size = vertex_colliding_triangles_offsets[v_index + 1] - vertex_buffer_offset       <L 1391>
        var_8 = wp::add(var_0, var_7);
        var_9 = wp::address(var_vertex_colliding_triangles_offsets, var_8);
        var_11 = wp::load(var_9);
        var_10 = wp::sub(var_11, var_5);
        // lower = wp.vec3(v[0] - max_query_radius, v[1] - max_query_radius, v[2] - max_query_radius)       <L 1393>
        var_13 = wp::extract(var_2, var_12);
        var_14 = wp::sub(var_13, var_max_query_radius);
        var_16 = wp::extract(var_2, var_15);
        var_17 = wp::sub(var_16, var_max_query_radius);
        var_19 = wp::extract(var_2, var_18);
        var_20 = wp::sub(var_19, var_max_query_radius);
        var_21 = wp::vec_t<3, wp::float32>(var_14, var_17, var_20);
        // upper = wp.vec3(v[0] + max_query_radius, v[1] + max_query_radius, v[2] + max_query_radius)       <L 1394>
        var_23 = wp::extract(var_2, var_22);
        var_24 = wp::add(var_23, var_max_query_radius);
        var_26 = wp::extract(var_2, var_25);
        var_27 = wp::add(var_26, var_max_query_radius);
        var_29 = wp::extract(var_2, var_28);
        var_30 = wp::add(var_29, var_max_query_radius);
        var_31 = wp::vec_t<3, wp::float32>(var_24, var_27, var_30);
        // tri_index = wp.int32(0)                                                                <L 1396>
        var_33 = wp::int32(var_32);
        // vertex_num_collisions = wp.int32(0)                                                    <L 1397>
        var_35 = wp::int32(var_34);
        // min_dis_to_tris = max_query_radius                                                     <L 1398>
        var_36 = wp::copy(var_max_query_radius);
        // vertex_world = particle_world[v_index]                                                 <L 1399>
        var_37 = wp::address(var_particle_world, var_0);
        var_39 = wp::load(var_37);
        var_38 = wp::copy(var_39);
        // for query_pass in range(2):                                                            <L 1405>
        // run_query = bool(False)                                                                <L 1406>
        var_42 = bool(var_41);
        // query_all = bool(False)                                                                <L 1407>
        var_44 = bool(var_43);
        // group_root = wp.int32(-1)                                                              <L 1408>
        var_46 = wp::int32(var_45);
        // if vertex_world < 0:                                                                   <L 1410>
        var_48 = (var_38 < var_47);
        if (var_48) {
            // if query_pass == 0:                                                                <L 1411>
            var_50 = (var_40 == var_49);
            if (var_50) {
                // run_query = True                                                               <L 1412>
                // query_all = True                                                               <L 1413>
            }
            var_53 = wp::where(var_50, var_51, var_42);
            var_54 = wp::where(var_50, var_52, var_44);
        }
        if (!var_48) {
            // if query_pass == 0:                                                                <L 1415>
            var_56 = (var_40 == var_55);
            if (var_56) {
                // group_root = bvh_group_roots[vertex_world]                                     <L 1416>
                var_57 = wp::address(var_bvh_group_roots, var_38);
                var_59 = wp::load(var_57);
                var_58 = wp::copy(var_59);
            }
            if (!var_56) {
                // group_root = bvh_group_roots[world_count]                                      <L 1418>
                var_60 = wp::address(var_bvh_group_roots, var_world_count);
                var_62 = wp::load(var_60);
                var_61 = wp::copy(var_62);
            }
            var_63 = wp::where(var_56, var_58, var_61);
            // run_query = group_root >= 0                                                        <L 1419>
            var_65 = (var_63 >= var_64);
        }
        var_66 = wp::where(var_48, var_53, var_65);
        var_67 = wp::where(var_48, var_54, var_44);
        var_68 = wp::where(var_48, var_46, var_63);
        // if run_query:                                                                          <L 1421>
        if (var_66) {
            // if query_all:                                                                      <L 1422>
            if (var_67) {
                // query = wp.bvh_query_aabb(bvh_id, lower, upper)                                <L 1423>
                var_69 = wp::bvh_query_aabb(var_bvh_id, var_21, var_31, var_70);
            }
            if (!var_67) {
                // query = wp.bvh_query_aabb(bvh_id, lower, upper, group_root)                    <L 1425>
                var_71 = wp::bvh_query_aabb(var_bvh_id, var_21, var_31, var_68);
            }
            var_72 = wp::where(var_67, var_69, var_71);
            // tri_index = wp.int32(0)                                                            <L 1427>
            var_74 = wp::int32(var_73);
            // while wp.bvh_query_next(query, tri_index):                                         <L 1428>
        start_while_0:;
            var_75 = wp::bvh_query_next(var_72, var_74, var_76);
        if ((var_75) == false) goto end_while_0;
                // t1 = tri_indices[tri_index, 0]                                                 <L 1429>
                var_78 = wp::address(var_tri_indices, var_74, var_77);
                var_80 = wp::load(var_78);
                var_79 = wp::copy(var_80);
                // t2 = tri_indices[tri_index, 1]                                                 <L 1430>
                var_82 = wp::address(var_tri_indices, var_74, var_81);
                var_84 = wp::load(var_82);
                var_83 = wp::copy(var_84);
                // t3 = tri_indices[tri_index, 2]                                                 <L 1431>
                var_86 = wp::address(var_tri_indices, var_74, var_85);
                var_88 = wp::load(var_86);
                var_87 = wp::copy(var_88);
                // if vertex_adjacent_to_triangle(v_index, t1, t2, t3):                           <L 1433>
                var_89 = vertex_adjacent_to_triangle_0(var_0, var_79, var_83, var_87);
                if (var_89) {
                    // continue                                                                   <L 1434>
                    goto start_while_0;
                }
                // if vertex_triangle_filtering_list:                                             <L 1436>
                if (var_vertex_triangle_filtering_list) {
                    // fl_start = vertex_triangle_filtering_list_offsets[v_index]                 <L 1437>
                    var_90 = wp::address(var_vertex_triangle_filtering_list_offsets, var_0);
                    var_92 = wp::load(var_90);
                    var_91 = wp::copy(var_92);
                    // fl_end = vertex_triangle_filtering_list_offsets[                           <L 1438>
                    // v_index + 1                                                                <L 1439>
                    var_94 = wp::add(var_0, var_93);
                    var_95 = wp::address(var_vertex_triangle_filtering_list_offsets, var_94);
                    var_97 = wp::load(var_95);
                    var_96 = wp::copy(var_97);
                    // if fl_end > fl_start:                                                      <L 1442>
                    var_98 = (var_96 > var_91);
                    if (var_98) {
                        // first_val = vertex_triangle_filtering_list[fl_start]                   <L 1444>
                        var_99 = wp::address(var_vertex_triangle_filtering_list, var_91);
                        var_101 = wp::load(var_99);
                        var_100 = wp::copy(var_101);
                        // last_val = vertex_triangle_filtering_list[fl_end - 1]                  <L 1445>
                        var_103 = wp::sub(var_96, var_102);
                        var_104 = wp::address(var_vertex_triangle_filtering_list, var_103);
                        var_106 = wp::load(var_104);
                        var_105 = wp::copy(var_106);
                        // if (tri_index >= first_val) and (tri_index <= last_val):               <L 1446>
                        var_108 = (var_74 >= var_100);
                        var_107 = var_108;
                        if (var_107) {
                            var_109 = (var_74 <= var_105);
                            var_107 = var_107 && var_109;
                        }
                        if (var_107) {
                            // idx = binary_search(vertex_triangle_filtering_list, tri_index, fl_start, fl_end)       <L 1447>
                            var_110 = binary_search_0(var_vertex_triangle_filtering_list, var_74, var_91, var_96);
                            // if idx > fl_start and vertex_triangle_filtering_list[idx - 1] == tri_index:       <L 1449>
                            var_112 = (var_110 > var_91);
                            var_111 = var_112;
                            if (var_111) {
                                var_114 = wp::sub(var_110, var_113);
                                var_115 = wp::address(var_vertex_triangle_filtering_list, var_114);
                                var_117 = wp::load(var_115);
                                var_116 = (var_117 == var_74);
                                var_111 = var_111 && var_116;
                            }
                            if (var_111) {
                                // continue                                                       <L 1450>
                                goto start_while_0;
                            }
                        }
                    }
                }
                // u1 = pos[t1]                                                                   <L 1452>
                var_118 = wp::address(var_pos, var_79);
                var_120 = wp::load(var_118);
                var_119 = wp::copy(var_120);
                // u2 = pos[t2]                                                                   <L 1453>
                var_121 = wp::address(var_pos, var_83);
                var_123 = wp::load(var_121);
                var_122 = wp::copy(var_123);
                // u3 = pos[t3]                                                                   <L 1454>
                var_124 = wp::address(var_pos, var_87);
                var_126 = wp::load(var_124);
                var_125 = wp::copy(var_126);
                // closest_p, _bary, _feature_type = triangle_closest_point(u1, u2, u3, v)        <L 1456>
                triangle_closest_point_0(var_119, var_122, var_125, var_2, var_127, var_128, var_129);
                // dist = wp.length(closest_p - v)                                                <L 1458>
                var_130 = wp::sub(var_127, var_2);
                var_131 = wp::length(var_130);
                // if min_distance_filtering_ref_pos and min_query_radius > 0.0:                  <L 1460>
                var_132 = var_min_distance_filtering_ref_pos;
                if (var_132) {
                    var_134 = (var_min_query_radius > var_133);
                    var_132 = var_132 && var_134;
                }
                if (var_132) {
                    // closest_p_ref, _, __ = triangle_closest_point(                             <L 1461>
                    // min_distance_filtering_ref_pos[t1],                                        <L 1462>
                    var_135 = wp::address(var_min_distance_filtering_ref_pos, var_79);
                    // min_distance_filtering_ref_pos[t2],                                        <L 1463>
                    var_136 = wp::address(var_min_distance_filtering_ref_pos, var_83);
                    // min_distance_filtering_ref_pos[t3],                                        <L 1464>
                    var_137 = wp::address(var_min_distance_filtering_ref_pos, var_87);
                    // min_distance_filtering_ref_pos[v_index],                                   <L 1465>
                    var_138 = wp::address(var_min_distance_filtering_ref_pos, var_0);
                    var_142 = wp::load(var_135);
                    var_143 = wp::load(var_136);
                    var_144 = wp::load(var_137);
                    var_145 = wp::load(var_138);
                    triangle_closest_point_0(var_142, var_143, var_144, var_145, var_139, var_140, var_141);
                    // dist_ref = wp.length(closest_p_ref - min_distance_filtering_ref_pos[v_index])       <L 1467>
                    var_146 = wp::address(var_min_distance_filtering_ref_pos, var_0);
                    var_148 = wp::load(var_146);
                    var_147 = wp::sub(var_139, var_148);
                    var_149 = wp::length(var_147);
                    // if dist_ref < min_query_radius:                                            <L 1469>
                    var_150 = (var_149 < var_min_query_radius);
                    if (var_150) {
                        // continue                                                               <L 1470>
                        goto start_while_0;
                    }
                }
                // if dist < max_query_radius:                                                    <L 1472>
                var_151 = (var_131 < var_max_query_radius);
                if (var_151) {
                    // min_dis_to_tris = wp.min(min_dis_to_tris, dist)                            <L 1474>
                    var_152 = wp::min(var_36, var_131);
                    // if vertex_num_collisions < vertex_buffer_size:                             <L 1475>
                    var_153 = (var_35 < var_10);
                    if (var_153) {
                        // vertex_colliding_triangles[2 * (vertex_buffer_offset + vertex_num_collisions)] = v_index       <L 1476>
                        var_155 = wp::add(var_5, var_35);
                        var_156 = wp::mul(var_154, var_155);
                        wp::array_store(var_vertex_colliding_triangles, var_156, var_0);
                        // vertex_colliding_triangles[2 * (vertex_buffer_offset + vertex_num_collisions) + 1] = tri_index       <L 1477>
                        var_158 = wp::add(var_5, var_35);
                        var_159 = wp::mul(var_157, var_158);
                        var_161 = wp::add(var_159, var_160);
                        wp::array_store(var_vertex_colliding_triangles, var_161, var_74);
                    }
                    if (!var_153) {
                        // resize_flags[VERTEX_COLLISION_BUFFER_OVERFLOW_INDEX] = 1               <L 1479>
                        wp::array_store(var_resize_flags, var_163, var_162);
                    }
                    // vertex_num_collisions = vertex_num_collisions + 1                          <L 1481>
                    var_165 = wp::add(var_35, var_164);
                    // if triangle_colliding_vertices:                                            <L 1483>
                    if (var_triangle_colliding_vertices) {
                        // wp.atomic_min(triangle_colliding_vertices_min_dist, tri_index, dist)       <L 1484>
                        var_166 = wp::atomic_min(var_triangle_colliding_vertices_min_dist, var_74, var_131);
                        // tri_buffer_size = triangle_colliding_vertices_buffer_sizes[tri_index]       <L 1485>
                        var_167 = wp::address(var_triangle_colliding_vertices_buffer_sizes, var_74);
                        var_169 = wp::load(var_167);
                        var_168 = wp::copy(var_169);
                        // tri_num_collisions = wp.atomic_add(triangle_colliding_vertices_count, tri_index, 1)       <L 1486>
                        var_171 = wp::atomic_add(var_triangle_colliding_vertices_count, var_74, var_170);
                        // if tri_num_collisions < tri_buffer_size:                               <L 1488>
                        var_172 = (var_171 < var_168);
                        if (var_172) {
                            // tri_buffer_offset = triangle_colliding_vertices_offsets[tri_index]       <L 1489>
                            var_173 = wp::address(var_triangle_colliding_vertices_offsets, var_74);
                            var_175 = wp::load(var_173);
                            var_174 = wp::copy(var_175);
                            // triangle_colliding_vertices[tri_buffer_offset + tri_num_collisions] = v_index       <L 1491>
                            var_176 = wp::add(var_174, var_171);
                            wp::array_store(var_triangle_colliding_vertices, var_176, var_0);
                        }
                        if (!var_172) {
                            // resize_flags[TRI_COLLISION_BUFFER_OVERFLOW_INDEX] = 1              <L 1493>
                            wp::array_store(var_resize_flags, var_178, var_177);
                        }
                    }
                }
                var_179 = wp::where(var_151, var_165, var_35);
                var_180 = wp::where(var_151, var_152, var_36);
                wp::assign(var_35, var_179);
                wp::assign(var_36, var_180);
        goto start_while_0;
        end_while_0:;
        }
        var_181 = wp::where(var_66, var_74, var_33);
        // run_query = bool(False)                                                                <L 1406>
        var_184 = bool(var_183);
        // query_all = bool(False)                                                                <L 1407>
        var_186 = bool(var_185);
        // group_root = wp.int32(-1)                                                              <L 1408>
        var_188 = wp::int32(var_187);
        // if vertex_world < 0:                                                                   <L 1410>
        var_190 = (var_38 < var_189);
        if (var_190) {
            // if query_pass == 0:                                                                <L 1411>
            var_192 = (var_182 == var_191);
            if (var_192) {
                // run_query = True                                                               <L 1412>
                // query_all = True                                                               <L 1413>
            }
            var_195 = wp::where(var_192, var_193, var_184);
            var_196 = wp::where(var_192, var_194, var_186);
        }
        if (!var_190) {
            // if query_pass == 0:                                                                <L 1415>
            var_198 = (var_182 == var_197);
            if (var_198) {
                // group_root = bvh_group_roots[vertex_world]                                     <L 1416>
                var_199 = wp::address(var_bvh_group_roots, var_38);
                var_201 = wp::load(var_199);
                var_200 = wp::copy(var_201);
            }
            if (!var_198) {
                // group_root = bvh_group_roots[world_count]                                      <L 1418>
                var_202 = wp::address(var_bvh_group_roots, var_world_count);
                var_204 = wp::load(var_202);
                var_203 = wp::copy(var_204);
            }
            var_205 = wp::where(var_198, var_200, var_203);
            // run_query = group_root >= 0                                                        <L 1419>
            var_207 = (var_205 >= var_206);
        }
        var_208 = wp::where(var_190, var_195, var_207);
        var_209 = wp::where(var_190, var_196, var_186);
        var_210 = wp::where(var_190, var_188, var_205);
        // if run_query:                                                                          <L 1421>
        if (var_208) {
            // if query_all:                                                                      <L 1422>
            if (var_209) {
                // query = wp.bvh_query_aabb(bvh_id, lower, upper)                                <L 1423>
                var_211 = wp::bvh_query_aabb(var_bvh_id, var_21, var_31, var_212);
            }
            if (!var_209) {
                // query = wp.bvh_query_aabb(bvh_id, lower, upper, group_root)                    <L 1425>
                var_213 = wp::bvh_query_aabb(var_bvh_id, var_21, var_31, var_210);
            }
            var_214 = wp::where(var_209, var_211, var_213);
            // tri_index = wp.int32(0)                                                            <L 1427>
            var_216 = wp::int32(var_215);
            // while wp.bvh_query_next(query, tri_index):                                         <L 1428>
        start_while_2:;
            var_217 = wp::bvh_query_next(var_214, var_216, var_218);
        if ((var_217) == false) goto end_while_2;
                // t1 = tri_indices[tri_index, 0]                                                 <L 1429>
                var_220 = wp::address(var_tri_indices, var_216, var_219);
                var_222 = wp::load(var_220);
                var_221 = wp::copy(var_222);
                // t2 = tri_indices[tri_index, 1]                                                 <L 1430>
                var_224 = wp::address(var_tri_indices, var_216, var_223);
                var_226 = wp::load(var_224);
                var_225 = wp::copy(var_226);
                // t3 = tri_indices[tri_index, 2]                                                 <L 1431>
                var_228 = wp::address(var_tri_indices, var_216, var_227);
                var_230 = wp::load(var_228);
                var_229 = wp::copy(var_230);
                // if vertex_adjacent_to_triangle(v_index, t1, t2, t3):                           <L 1433>
                var_231 = vertex_adjacent_to_triangle_0(var_0, var_221, var_225, var_229);
                if (var_231) {
                    // continue                                                                   <L 1434>
                    wp::assign(var_79, var_221);
                    wp::assign(var_83, var_225);
                    wp::assign(var_87, var_229);
                    goto start_while_2;
                }
                var_232 = wp::where(var_231, var_79, var_221);
                var_233 = wp::where(var_231, var_83, var_225);
                var_234 = wp::where(var_231, var_87, var_229);
                // if vertex_triangle_filtering_list:                                             <L 1436>
                if (var_vertex_triangle_filtering_list) {
                    // fl_start = vertex_triangle_filtering_list_offsets[v_index]                 <L 1437>
                    var_235 = wp::address(var_vertex_triangle_filtering_list_offsets, var_0);
                    var_237 = wp::load(var_235);
                    var_236 = wp::copy(var_237);
                    // fl_end = vertex_triangle_filtering_list_offsets[                           <L 1438>
                    // v_index + 1                                                                <L 1439>
                    var_239 = wp::add(var_0, var_238);
                    var_240 = wp::address(var_vertex_triangle_filtering_list_offsets, var_239);
                    var_242 = wp::load(var_240);
                    var_241 = wp::copy(var_242);
                    // if fl_end > fl_start:                                                      <L 1442>
                    var_243 = (var_241 > var_236);
                    if (var_243) {
                        // first_val = vertex_triangle_filtering_list[fl_start]                   <L 1444>
                        var_244 = wp::address(var_vertex_triangle_filtering_list, var_236);
                        var_246 = wp::load(var_244);
                        var_245 = wp::copy(var_246);
                        // last_val = vertex_triangle_filtering_list[fl_end - 1]                  <L 1445>
                        var_248 = wp::sub(var_241, var_247);
                        var_249 = wp::address(var_vertex_triangle_filtering_list, var_248);
                        var_251 = wp::load(var_249);
                        var_250 = wp::copy(var_251);
                        // if (tri_index >= first_val) and (tri_index <= last_val):               <L 1446>
                        var_253 = (var_216 >= var_245);
                        var_252 = var_253;
                        if (var_252) {
                            var_254 = (var_216 <= var_250);
                            var_252 = var_252 && var_254;
                        }
                        if (var_252) {
                            // idx = binary_search(vertex_triangle_filtering_list, tri_index, fl_start, fl_end)       <L 1447>
                            var_255 = binary_search_0(var_vertex_triangle_filtering_list, var_216, var_236, var_241);
                            // if idx > fl_start and vertex_triangle_filtering_list[idx - 1] == tri_index:       <L 1449>
                            var_257 = (var_255 > var_236);
                            var_256 = var_257;
                            if (var_256) {
                                var_259 = wp::sub(var_255, var_258);
                                var_260 = wp::address(var_vertex_triangle_filtering_list, var_259);
                                var_262 = wp::load(var_260);
                                var_261 = (var_262 == var_216);
                                var_256 = var_256 && var_261;
                            }
                            if (var_256) {
                                // continue                                                       <L 1450>
                                wp::assign(var_79, var_232);
                                wp::assign(var_83, var_233);
                                wp::assign(var_87, var_234);
                                wp::assign(var_91, var_236);
                                wp::assign(var_96, var_241);
                                wp::assign(var_100, var_245);
                                wp::assign(var_105, var_250);
                                wp::assign(var_110, var_255);
                                goto start_while_2;
                            }
                            var_263 = wp::where(var_256, var_79, var_232);
                            var_264 = wp::where(var_256, var_83, var_233);
                            var_265 = wp::where(var_256, var_87, var_234);
                            var_266 = wp::where(var_256, var_91, var_236);
                            var_267 = wp::where(var_256, var_96, var_241);
                            var_268 = wp::where(var_256, var_100, var_245);
                            var_269 = wp::where(var_256, var_105, var_250);
                            var_270 = wp::where(var_256, var_110, var_255);
                        }
                        var_271 = wp::where(var_252, var_263, var_232);
                        var_272 = wp::where(var_252, var_264, var_233);
                        var_273 = wp::where(var_252, var_265, var_234);
                        var_274 = wp::where(var_252, var_266, var_236);
                        var_275 = wp::where(var_252, var_267, var_241);
                        var_276 = wp::where(var_252, var_268, var_245);
                        var_277 = wp::where(var_252, var_269, var_250);
                        var_278 = wp::where(var_252, var_270, var_110);
                    }
                    var_279 = wp::where(var_243, var_271, var_232);
                    var_280 = wp::where(var_243, var_272, var_233);
                    var_281 = wp::where(var_243, var_273, var_234);
                    var_282 = wp::where(var_243, var_274, var_236);
                    var_283 = wp::where(var_243, var_275, var_241);
                    var_284 = wp::where(var_243, var_276, var_100);
                    var_285 = wp::where(var_243, var_277, var_105);
                    var_286 = wp::where(var_243, var_278, var_110);
                }
                var_287 = wp::where(var_vertex_triangle_filtering_list, var_279, var_232);
                var_288 = wp::where(var_vertex_triangle_filtering_list, var_280, var_233);
                var_289 = wp::where(var_vertex_triangle_filtering_list, var_281, var_234);
                var_290 = wp::where(var_vertex_triangle_filtering_list, var_282, var_91);
                var_291 = wp::where(var_vertex_triangle_filtering_list, var_283, var_96);
                var_292 = wp::where(var_vertex_triangle_filtering_list, var_284, var_100);
                var_293 = wp::where(var_vertex_triangle_filtering_list, var_285, var_105);
                var_294 = wp::where(var_vertex_triangle_filtering_list, var_286, var_110);
                // u1 = pos[t1]                                                                   <L 1452>
                var_295 = wp::address(var_pos, var_287);
                var_297 = wp::load(var_295);
                var_296 = wp::copy(var_297);
                // u2 = pos[t2]                                                                   <L 1453>
                var_298 = wp::address(var_pos, var_288);
                var_300 = wp::load(var_298);
                var_299 = wp::copy(var_300);
                // u3 = pos[t3]                                                                   <L 1454>
                var_301 = wp::address(var_pos, var_289);
                var_303 = wp::load(var_301);
                var_302 = wp::copy(var_303);
                // closest_p, _bary, _feature_type = triangle_closest_point(u1, u2, u3, v)        <L 1456>
                triangle_closest_point_0(var_296, var_299, var_302, var_2, var_304, var_305, var_306);
                // dist = wp.length(closest_p - v)                                                <L 1458>
                var_307 = wp::sub(var_304, var_2);
                var_308 = wp::length(var_307);
                // if min_distance_filtering_ref_pos and min_query_radius > 0.0:                  <L 1460>
                var_309 = var_min_distance_filtering_ref_pos;
                if (var_309) {
                    var_311 = (var_min_query_radius > var_310);
                    var_309 = var_309 && var_311;
                }
                if (var_309) {
                    // closest_p_ref, _, __ = triangle_closest_point(                             <L 1461>
                    // min_distance_filtering_ref_pos[t1],                                        <L 1462>
                    var_312 = wp::address(var_min_distance_filtering_ref_pos, var_287);
                    // min_distance_filtering_ref_pos[t2],                                        <L 1463>
                    var_313 = wp::address(var_min_distance_filtering_ref_pos, var_288);
                    // min_distance_filtering_ref_pos[t3],                                        <L 1464>
                    var_314 = wp::address(var_min_distance_filtering_ref_pos, var_289);
                    // min_distance_filtering_ref_pos[v_index],                                   <L 1465>
                    var_315 = wp::address(var_min_distance_filtering_ref_pos, var_0);
                    var_319 = wp::load(var_312);
                    var_320 = wp::load(var_313);
                    var_321 = wp::load(var_314);
                    var_322 = wp::load(var_315);
                    triangle_closest_point_0(var_319, var_320, var_321, var_322, var_316, var_317, var_318);
                    // dist_ref = wp.length(closest_p_ref - min_distance_filtering_ref_pos[v_index])       <L 1467>
                    var_323 = wp::address(var_min_distance_filtering_ref_pos, var_0);
                    var_325 = wp::load(var_323);
                    var_324 = wp::sub(var_316, var_325);
                    var_326 = wp::length(var_324);
                    // if dist_ref < min_query_radius:                                            <L 1469>
                    var_327 = (var_326 < var_min_query_radius);
                    if (var_327) {
                        // continue                                                               <L 1470>
                        wp::assign(var_79, var_287);
                        wp::assign(var_83, var_288);
                        wp::assign(var_87, var_289);
                        wp::assign(var_91, var_290);
                        wp::assign(var_96, var_291);
                        wp::assign(var_100, var_292);
                        wp::assign(var_105, var_293);
                        wp::assign(var_110, var_294);
                        wp::assign(var_119, var_296);
                        wp::assign(var_122, var_299);
                        wp::assign(var_125, var_302);
                        wp::assign(var_127, var_304);
                        wp::assign(var_128, var_305);
                        wp::assign(var_129, var_306);
                        wp::assign(var_131, var_308);
                        wp::assign(var_139, var_316);
                        wp::assign(var_140, var_317);
                        wp::assign(var_141, var_318);
                        wp::assign(var_149, var_326);
                        goto start_while_2;
                    }
                    var_328 = wp::where(var_327, var_79, var_287);
                    var_329 = wp::where(var_327, var_83, var_288);
                    var_330 = wp::where(var_327, var_87, var_289);
                    var_331 = wp::where(var_327, var_91, var_290);
                    var_332 = wp::where(var_327, var_96, var_291);
                    var_333 = wp::where(var_327, var_100, var_292);
                    var_334 = wp::where(var_327, var_105, var_293);
                    var_335 = wp::where(var_327, var_110, var_294);
                    var_336 = wp::where(var_327, var_119, var_296);
                    var_337 = wp::where(var_327, var_122, var_299);
                    var_338 = wp::where(var_327, var_125, var_302);
                    var_339 = wp::where(var_327, var_127, var_304);
                    var_340 = wp::where(var_327, var_128, var_305);
                    var_341 = wp::where(var_327, var_129, var_306);
                    var_342 = wp::where(var_327, var_131, var_308);
                    var_343 = wp::where(var_327, var_139, var_316);
                    var_344 = wp::where(var_327, var_140, var_317);
                    var_345 = wp::where(var_327, var_141, var_318);
                    var_346 = wp::where(var_327, var_149, var_326);
                }
                var_347 = wp::where(var_309, var_328, var_287);
                var_348 = wp::where(var_309, var_329, var_288);
                var_349 = wp::where(var_309, var_330, var_289);
                var_350 = wp::where(var_309, var_331, var_290);
                var_351 = wp::where(var_309, var_332, var_291);
                var_352 = wp::where(var_309, var_333, var_292);
                var_353 = wp::where(var_309, var_334, var_293);
                var_354 = wp::where(var_309, var_335, var_294);
                var_355 = wp::where(var_309, var_336, var_296);
                var_356 = wp::where(var_309, var_337, var_299);
                var_357 = wp::where(var_309, var_338, var_302);
                var_358 = wp::where(var_309, var_339, var_304);
                var_359 = wp::where(var_309, var_340, var_305);
                var_360 = wp::where(var_309, var_341, var_306);
                var_361 = wp::where(var_309, var_342, var_308);
                var_362 = wp::where(var_309, var_343, var_139);
                var_363 = wp::where(var_309, var_344, var_140);
                var_364 = wp::where(var_309, var_345, var_141);
                var_365 = wp::where(var_309, var_346, var_149);
                // if dist < max_query_radius:                                                    <L 1472>
                var_366 = (var_361 < var_max_query_radius);
                if (var_366) {
                    // min_dis_to_tris = wp.min(min_dis_to_tris, dist)                            <L 1474>
                    var_367 = wp::min(var_36, var_361);
                    // if vertex_num_collisions < vertex_buffer_size:                             <L 1475>
                    var_368 = (var_35 < var_10);
                    if (var_368) {
                        // vertex_colliding_triangles[2 * (vertex_buffer_offset + vertex_num_collisions)] = v_index       <L 1476>
                        var_370 = wp::add(var_5, var_35);
                        var_371 = wp::mul(var_369, var_370);
                        wp::array_store(var_vertex_colliding_triangles, var_371, var_0);
                        // vertex_colliding_triangles[2 * (vertex_buffer_offset + vertex_num_collisions) + 1] = tri_index       <L 1477>
                        var_373 = wp::add(var_5, var_35);
                        var_374 = wp::mul(var_372, var_373);
                        var_376 = wp::add(var_374, var_375);
                        wp::array_store(var_vertex_colliding_triangles, var_376, var_216);
                    }
                    if (!var_368) {
                        // resize_flags[VERTEX_COLLISION_BUFFER_OVERFLOW_INDEX] = 1               <L 1479>
                        wp::array_store(var_resize_flags, var_163, var_377);
                    }
                    // vertex_num_collisions = vertex_num_collisions + 1                          <L 1481>
                    var_379 = wp::add(var_35, var_378);
                    // if triangle_colliding_vertices:                                            <L 1483>
                    if (var_triangle_colliding_vertices) {
                        // wp.atomic_min(triangle_colliding_vertices_min_dist, tri_index, dist)       <L 1484>
                        var_380 = wp::atomic_min(var_triangle_colliding_vertices_min_dist, var_216, var_361);
                        // tri_buffer_size = triangle_colliding_vertices_buffer_sizes[tri_index]       <L 1485>
                        var_381 = wp::address(var_triangle_colliding_vertices_buffer_sizes, var_216);
                        var_383 = wp::load(var_381);
                        var_382 = wp::copy(var_383);
                        // tri_num_collisions = wp.atomic_add(triangle_colliding_vertices_count, tri_index, 1)       <L 1486>
                        var_385 = wp::atomic_add(var_triangle_colliding_vertices_count, var_216, var_384);
                        // if tri_num_collisions < tri_buffer_size:                               <L 1488>
                        var_386 = (var_385 < var_382);
                        if (var_386) {
                            // tri_buffer_offset = triangle_colliding_vertices_offsets[tri_index]       <L 1489>
                            var_387 = wp::address(var_triangle_colliding_vertices_offsets, var_216);
                            var_389 = wp::load(var_387);
                            var_388 = wp::copy(var_389);
                            // triangle_colliding_vertices[tri_buffer_offset + tri_num_collisions] = v_index       <L 1491>
                            var_390 = wp::add(var_388, var_385);
                            wp::array_store(var_triangle_colliding_vertices, var_390, var_0);
                        }
                        if (!var_386) {
                            // resize_flags[TRI_COLLISION_BUFFER_OVERFLOW_INDEX] = 1              <L 1493>
                            wp::array_store(var_resize_flags, var_178, var_391);
                        }
                        var_392 = wp::where(var_386, var_388, var_174);
                    }
                    var_393 = wp::where(var_triangle_colliding_vertices, var_382, var_168);
                    var_394 = wp::where(var_triangle_colliding_vertices, var_385, var_171);
                    var_395 = wp::where(var_triangle_colliding_vertices, var_392, var_174);
                }
                var_396 = wp::where(var_366, var_379, var_35);
                var_397 = wp::where(var_366, var_367, var_36);
                var_398 = wp::where(var_366, var_393, var_168);
                var_399 = wp::where(var_366, var_394, var_171);
                var_400 = wp::where(var_366, var_395, var_174);
                wp::assign(var_35, var_396);
                wp::assign(var_36, var_397);
                wp::assign(var_79, var_347);
                wp::assign(var_83, var_348);
                wp::assign(var_87, var_349);
                wp::assign(var_91, var_350);
                wp::assign(var_96, var_351);
                wp::assign(var_100, var_352);
                wp::assign(var_105, var_353);
                wp::assign(var_110, var_354);
                wp::assign(var_119, var_355);
                wp::assign(var_122, var_356);
                wp::assign(var_125, var_357);
                wp::assign(var_127, var_358);
                wp::assign(var_128, var_359);
                wp::assign(var_129, var_360);
                wp::assign(var_131, var_361);
                wp::assign(var_139, var_362);
                wp::assign(var_140, var_363);
                wp::assign(var_141, var_364);
                wp::assign(var_149, var_365);
                wp::assign(var_168, var_398);
                wp::assign(var_171, var_399);
                wp::assign(var_174, var_400);
        goto start_while_2;
        end_while_2:;
        }
        var_401 = wp::where(var_208, var_216, var_181);
        var_402 = wp::where(var_208, var_214, var_72);
        // vertex_colliding_triangles_count[v_index] = vertex_num_collisions                      <L 1495>
        wp::array_store(var_vertex_colliding_triangles_count, var_0, var_35);
        // vertex_colliding_triangles_min_dist[v_index] = min_dis_to_tris                         <L 1496>
        wp::array_store(var_vertex_colliding_triangles_min_dist, var_0, var_36);
    }
}



extern "C" __global__ void vertex_triangle_collision_detection_kernel_723f98e4_cuda_kernel_backward(
    wp::launch_bounds_t<1> dim,
    wp::float32 var_max_query_radius,
    wp::float32 var_min_query_radius,
    wp::uint64 var_bvh_id,
    wp::array_t<wp::int32> var_bvh_group_roots,
    wp::array_t<wp::vec_t<3, wp::float32>> var_pos,
    wp::array_t<wp::int32> var_tri_indices,
    wp::array_t<wp::int32> var_particle_world,
    wp::int32 var_world_count,
    wp::array_t<wp::int32> var_vertex_colliding_triangles_offsets,
    wp::array_t<wp::int32> var_vertex_colliding_triangles_buffer_sizes,
    wp::array_t<wp::int32> var_triangle_colliding_vertices_offsets,
    wp::array_t<wp::int32> var_triangle_colliding_vertices_buffer_sizes,
    wp::array_t<wp::int32> var_vertex_triangle_filtering_list,
    wp::array_t<wp::int32> var_vertex_triangle_filtering_list_offsets,
    wp::array_t<wp::vec_t<3, wp::float32>> var_min_distance_filtering_ref_pos,
    wp::array_t<wp::int32> var_vertex_colliding_triangles,
    wp::array_t<wp::int32> var_vertex_colliding_triangles_count,
    wp::array_t<wp::float32> var_vertex_colliding_triangles_min_dist,
    wp::array_t<wp::int32> var_triangle_colliding_vertices,
    wp::array_t<wp::int32> var_triangle_colliding_vertices_count,
    wp::array_t<wp::float32> var_triangle_colliding_vertices_min_dist,
    wp::array_t<wp::int32> var_resize_flags,
    wp::float32 adj_max_query_radius,
    wp::float32 adj_min_query_radius,
    wp::uint64 adj_bvh_id,
    wp::array_t<wp::int32> adj_bvh_group_roots,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_pos,
    wp::array_t<wp::int32> adj_tri_indices,
    wp::array_t<wp::int32> adj_particle_world,
    wp::int32 adj_world_count,
    wp::array_t<wp::int32> adj_vertex_colliding_triangles_offsets,
    wp::array_t<wp::int32> adj_vertex_colliding_triangles_buffer_sizes,
    wp::array_t<wp::int32> adj_triangle_colliding_vertices_offsets,
    wp::array_t<wp::int32> adj_triangle_colliding_vertices_buffer_sizes,
    wp::array_t<wp::int32> adj_vertex_triangle_filtering_list,
    wp::array_t<wp::int32> adj_vertex_triangle_filtering_list_offsets,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_min_distance_filtering_ref_pos,
    wp::array_t<wp::int32> adj_vertex_colliding_triangles,
    wp::array_t<wp::int32> adj_vertex_colliding_triangles_count,
    wp::array_t<wp::float32> adj_vertex_colliding_triangles_min_dist,
    wp::array_t<wp::int32> adj_triangle_colliding_vertices,
    wp::array_t<wp::int32> adj_triangle_colliding_vertices_count,
    wp::array_t<wp::float32> adj_triangle_colliding_vertices_min_dist,
    wp::array_t<wp::int32> adj_resize_flags)
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
        wp::vec_t<3, wp::float32>* var_1;
        wp::vec_t<3, wp::float32> var_2;
        wp::vec_t<3, wp::float32> var_3;
        wp::int32* var_4;
        wp::int32 var_5;
        wp::int32 var_6;
        const wp::int32 var_7 = 1;
        wp::int32 var_8;
        wp::int32* var_9;
        wp::int32 var_10;
        wp::int32 var_11;
        const wp::int32 var_12 = 0;
        wp::float32 var_13;
        wp::float32 var_14;
        const wp::int32 var_15 = 1;
        wp::float32 var_16;
        wp::float32 var_17;
        const wp::int32 var_18 = 2;
        wp::float32 var_19;
        wp::float32 var_20;
        wp::vec_t<3, wp::float32> var_21;
        const wp::int32 var_22 = 0;
        wp::float32 var_23;
        wp::float32 var_24;
        const wp::int32 var_25 = 1;
        wp::float32 var_26;
        wp::float32 var_27;
        const wp::int32 var_28 = 2;
        wp::float32 var_29;
        wp::float32 var_30;
        wp::vec_t<3, wp::float32> var_31;
        const wp::int32 var_32 = 0;
        wp::int32 var_33;
        const wp::int32 var_34 = 0;
        wp::int32 var_35;
        wp::float32 var_36;
        wp::int32* var_37;
        wp::int32 var_38;
        wp::int32 var_39;
        const wp::int32 var_40 = 0;
        const bool var_41 = false;
        bool var_42;
        const bool var_43 = false;
        bool var_44;
        const wp::int32 var_45 = -1;
        wp::int32 var_46;
        const wp::int32 var_47 = 0;
        bool var_48;
        const wp::int32 var_49 = 0;
        bool var_50;
        const bool var_51 = true;
        const bool var_52 = true;
        bool var_53;
        bool var_54;
        const wp::int32 var_55 = 0;
        bool var_56;
        wp::int32* var_57;
        wp::int32 var_58;
        wp::int32 var_59;
        wp::int32* var_60;
        wp::int32 var_61;
        wp::int32 var_62;
        wp::int32 var_63;
        const wp::int32 var_64 = 0;
        bool var_65;
        bool var_66;
        bool var_67;
        wp::int32 var_68;
        wp::bvh_query_t var_69;
        const wp::int32 var_70 = -1;
        wp::bvh_query_t var_71;
        wp::bvh_query_t var_72;
        const wp::int32 var_73 = 0;
        wp::int32 var_74;
        bool var_75;
        const wp::float32 var_76 = INFINITY;
        const wp::int32 var_77 = 0;
        wp::int32* var_78;
        wp::int32 var_79;
        wp::int32 var_80;
        const wp::int32 var_81 = 1;
        wp::int32* var_82;
        wp::int32 var_83;
        wp::int32 var_84;
        const wp::int32 var_85 = 2;
        wp::int32* var_86;
        wp::int32 var_87;
        wp::int32 var_88;
        bool var_89;
        wp::int32* var_90;
        wp::int32 var_91;
        wp::int32 var_92;
        const wp::int32 var_93 = 1;
        wp::int32 var_94;
        wp::int32* var_95;
        wp::int32 var_96;
        wp::int32 var_97;
        bool var_98;
        wp::int32* var_99;
        wp::int32 var_100;
        wp::int32 var_101;
        const wp::int32 var_102 = 1;
        wp::int32 var_103;
        wp::int32* var_104;
        wp::int32 var_105;
        wp::int32 var_106;
        bool var_107;
        bool var_108;
        bool var_109;
        wp::int32 var_110;
        bool var_111;
        bool var_112;
        const wp::int32 var_113 = 1;
        wp::int32 var_114;
        wp::int32* var_115;
        bool var_116;
        wp::int32 var_117;
        wp::vec_t<3, wp::float32>* var_118;
        wp::vec_t<3, wp::float32> var_119;
        wp::vec_t<3, wp::float32> var_120;
        wp::vec_t<3, wp::float32>* var_121;
        wp::vec_t<3, wp::float32> var_122;
        wp::vec_t<3, wp::float32> var_123;
        wp::vec_t<3, wp::float32>* var_124;
        wp::vec_t<3, wp::float32> var_125;
        wp::vec_t<3, wp::float32> var_126;
        wp::vec_t<3, wp::float32> var_127;
        wp::vec_t<3, wp::float32> var_128;
        wp::int32 var_129;
        wp::vec_t<3, wp::float32> var_130;
        wp::float32 var_131;
        bool var_132;
        const wp::float32 var_133 = 0.0;
        bool var_134;
        wp::vec_t<3, wp::float32>* var_135;
        wp::vec_t<3, wp::float32>* var_136;
        wp::vec_t<3, wp::float32>* var_137;
        wp::vec_t<3, wp::float32>* var_138;
        wp::vec_t<3, wp::float32> var_139;
        wp::vec_t<3, wp::float32> var_140;
        wp::int32 var_141;
        wp::vec_t<3, wp::float32> var_142;
        wp::vec_t<3, wp::float32> var_143;
        wp::vec_t<3, wp::float32> var_144;
        wp::vec_t<3, wp::float32> var_145;
        wp::vec_t<3, wp::float32>* var_146;
        wp::vec_t<3, wp::float32> var_147;
        wp::vec_t<3, wp::float32> var_148;
        wp::float32 var_149;
        bool var_150;
        bool var_151;
        wp::float32 var_152;
        bool var_153;
        const wp::int32 var_154 = 2;
        wp::int32 var_155;
        wp::int32 var_156;
        const wp::int32 var_157 = 2;
        wp::int32 var_158;
        wp::int32 var_159;
        const wp::int32 var_160 = 1;
        wp::int32 var_161;
        const wp::int32 var_162 = 1;
        const wp::int32 var_163 = 0;
        const wp::int32 var_164 = 1;
        wp::int32 var_165;
        wp::float32 var_166;
        wp::int32* var_167;
        wp::int32 var_168;
        wp::int32 var_169;
        const wp::int32 var_170 = 1;
        wp::int32 var_171;
        bool var_172;
        wp::int32* var_173;
        wp::int32 var_174;
        wp::int32 var_175;
        wp::int32 var_176;
        const wp::int32 var_177 = 1;
        const wp::int32 var_178 = 1;
        wp::int32 var_179;
        wp::float32 var_180;
        wp::int32 var_181;
        const wp::int32 var_182 = 1;
        const bool var_183 = false;
        bool var_184;
        const bool var_185 = false;
        bool var_186;
        const wp::int32 var_187 = -1;
        wp::int32 var_188;
        const wp::int32 var_189 = 0;
        bool var_190;
        const wp::int32 var_191 = 0;
        bool var_192;
        const bool var_193 = true;
        const bool var_194 = true;
        bool var_195;
        bool var_196;
        const wp::int32 var_197 = 0;
        bool var_198;
        wp::int32* var_199;
        wp::int32 var_200;
        wp::int32 var_201;
        wp::int32* var_202;
        wp::int32 var_203;
        wp::int32 var_204;
        wp::int32 var_205;
        const wp::int32 var_206 = 0;
        bool var_207;
        bool var_208;
        bool var_209;
        wp::int32 var_210;
        wp::bvh_query_t var_211;
        const wp::int32 var_212 = -1;
        wp::bvh_query_t var_213;
        wp::bvh_query_t var_214;
        const wp::int32 var_215 = 0;
        wp::int32 var_216;
        bool var_217;
        const wp::float32 var_218 = INFINITY;
        const wp::int32 var_219 = 0;
        wp::int32* var_220;
        wp::int32 var_221;
        wp::int32 var_222;
        const wp::int32 var_223 = 1;
        wp::int32* var_224;
        wp::int32 var_225;
        wp::int32 var_226;
        const wp::int32 var_227 = 2;
        wp::int32* var_228;
        wp::int32 var_229;
        wp::int32 var_230;
        bool var_231;
        wp::int32 var_232;
        wp::int32 var_233;
        wp::int32 var_234;
        wp::int32* var_235;
        wp::int32 var_236;
        wp::int32 var_237;
        const wp::int32 var_238 = 1;
        wp::int32 var_239;
        wp::int32* var_240;
        wp::int32 var_241;
        wp::int32 var_242;
        bool var_243;
        wp::int32* var_244;
        wp::int32 var_245;
        wp::int32 var_246;
        const wp::int32 var_247 = 1;
        wp::int32 var_248;
        wp::int32* var_249;
        wp::int32 var_250;
        wp::int32 var_251;
        bool var_252;
        bool var_253;
        bool var_254;
        wp::int32 var_255;
        bool var_256;
        bool var_257;
        const wp::int32 var_258 = 1;
        wp::int32 var_259;
        wp::int32* var_260;
        bool var_261;
        wp::int32 var_262;
        wp::int32 var_263;
        wp::int32 var_264;
        wp::int32 var_265;
        wp::int32 var_266;
        wp::int32 var_267;
        wp::int32 var_268;
        wp::int32 var_269;
        wp::int32 var_270;
        wp::int32 var_271;
        wp::int32 var_272;
        wp::int32 var_273;
        wp::int32 var_274;
        wp::int32 var_275;
        wp::int32 var_276;
        wp::int32 var_277;
        wp::int32 var_278;
        wp::int32 var_279;
        wp::int32 var_280;
        wp::int32 var_281;
        wp::int32 var_282;
        wp::int32 var_283;
        wp::int32 var_284;
        wp::int32 var_285;
        wp::int32 var_286;
        wp::int32 var_287;
        wp::int32 var_288;
        wp::int32 var_289;
        wp::int32 var_290;
        wp::int32 var_291;
        wp::int32 var_292;
        wp::int32 var_293;
        wp::int32 var_294;
        wp::vec_t<3, wp::float32>* var_295;
        wp::vec_t<3, wp::float32> var_296;
        wp::vec_t<3, wp::float32> var_297;
        wp::vec_t<3, wp::float32>* var_298;
        wp::vec_t<3, wp::float32> var_299;
        wp::vec_t<3, wp::float32> var_300;
        wp::vec_t<3, wp::float32>* var_301;
        wp::vec_t<3, wp::float32> var_302;
        wp::vec_t<3, wp::float32> var_303;
        wp::vec_t<3, wp::float32> var_304;
        wp::vec_t<3, wp::float32> var_305;
        wp::int32 var_306;
        wp::vec_t<3, wp::float32> var_307;
        wp::float32 var_308;
        bool var_309;
        const wp::float32 var_310 = 0.0;
        bool var_311;
        wp::vec_t<3, wp::float32>* var_312;
        wp::vec_t<3, wp::float32>* var_313;
        wp::vec_t<3, wp::float32>* var_314;
        wp::vec_t<3, wp::float32>* var_315;
        wp::vec_t<3, wp::float32> var_316;
        wp::vec_t<3, wp::float32> var_317;
        wp::int32 var_318;
        wp::vec_t<3, wp::float32> var_319;
        wp::vec_t<3, wp::float32> var_320;
        wp::vec_t<3, wp::float32> var_321;
        wp::vec_t<3, wp::float32> var_322;
        wp::vec_t<3, wp::float32>* var_323;
        wp::vec_t<3, wp::float32> var_324;
        wp::vec_t<3, wp::float32> var_325;
        wp::float32 var_326;
        bool var_327;
        wp::int32 var_328;
        wp::int32 var_329;
        wp::int32 var_330;
        wp::int32 var_331;
        wp::int32 var_332;
        wp::int32 var_333;
        wp::int32 var_334;
        wp::int32 var_335;
        wp::vec_t<3, wp::float32> var_336;
        wp::vec_t<3, wp::float32> var_337;
        wp::vec_t<3, wp::float32> var_338;
        wp::vec_t<3, wp::float32> var_339;
        wp::vec_t<3, wp::float32> var_340;
        wp::int32 var_341;
        wp::float32 var_342;
        wp::vec_t<3, wp::float32> var_343;
        wp::vec_t<3, wp::float32> var_344;
        wp::int32 var_345;
        wp::float32 var_346;
        wp::int32 var_347;
        wp::int32 var_348;
        wp::int32 var_349;
        wp::int32 var_350;
        wp::int32 var_351;
        wp::int32 var_352;
        wp::int32 var_353;
        wp::int32 var_354;
        wp::vec_t<3, wp::float32> var_355;
        wp::vec_t<3, wp::float32> var_356;
        wp::vec_t<3, wp::float32> var_357;
        wp::vec_t<3, wp::float32> var_358;
        wp::vec_t<3, wp::float32> var_359;
        wp::int32 var_360;
        wp::float32 var_361;
        wp::vec_t<3, wp::float32> var_362;
        wp::vec_t<3, wp::float32> var_363;
        wp::int32 var_364;
        wp::float32 var_365;
        bool var_366;
        wp::float32 var_367;
        bool var_368;
        const wp::int32 var_369 = 2;
        wp::int32 var_370;
        wp::int32 var_371;
        const wp::int32 var_372 = 2;
        wp::int32 var_373;
        wp::int32 var_374;
        const wp::int32 var_375 = 1;
        wp::int32 var_376;
        const wp::int32 var_377 = 1;
        const wp::int32 var_378 = 1;
        wp::int32 var_379;
        wp::float32 var_380;
        wp::int32* var_381;
        wp::int32 var_382;
        wp::int32 var_383;
        const wp::int32 var_384 = 1;
        wp::int32 var_385;
        bool var_386;
        wp::int32* var_387;
        wp::int32 var_388;
        wp::int32 var_389;
        wp::int32 var_390;
        const wp::int32 var_391 = 1;
        wp::int32 var_392;
        wp::int32 var_393;
        wp::int32 var_394;
        wp::int32 var_395;
        wp::int32 var_396;
        wp::float32 var_397;
        wp::int32 var_398;
        wp::int32 var_399;
        wp::int32 var_400;
        wp::int32 var_401;
        wp::bvh_query_t var_402;
        //---------
        // dual vars
        wp::int32 adj_0 = {};
        wp::vec_t<3, wp::float32> adj_1 = {};
        wp::vec_t<3, wp::float32> adj_2 = {};
        wp::vec_t<3, wp::float32> adj_3 = {};
        wp::int32 adj_4 = {};
        wp::int32 adj_5 = {};
        wp::int32 adj_6 = {};
        wp::int32 adj_7 = {};
        wp::int32 adj_8 = {};
        wp::int32 adj_9 = {};
        wp::int32 adj_10 = {};
        wp::int32 adj_11 = {};
        wp::int32 adj_12 = {};
        wp::float32 adj_13 = {};
        wp::float32 adj_14 = {};
        wp::int32 adj_15 = {};
        wp::float32 adj_16 = {};
        wp::float32 adj_17 = {};
        wp::int32 adj_18 = {};
        wp::float32 adj_19 = {};
        wp::float32 adj_20 = {};
        wp::vec_t<3, wp::float32> adj_21 = {};
        wp::int32 adj_22 = {};
        wp::float32 adj_23 = {};
        wp::float32 adj_24 = {};
        wp::int32 adj_25 = {};
        wp::float32 adj_26 = {};
        wp::float32 adj_27 = {};
        wp::int32 adj_28 = {};
        wp::float32 adj_29 = {};
        wp::float32 adj_30 = {};
        wp::vec_t<3, wp::float32> adj_31 = {};
        wp::int32 adj_32 = {};
        wp::int32 adj_33 = {};
        wp::int32 adj_34 = {};
        wp::int32 adj_35 = {};
        wp::float32 adj_36 = {};
        wp::int32 adj_37 = {};
        wp::int32 adj_38 = {};
        wp::int32 adj_39 = {};
        wp::int32 adj_40 = {};
        bool adj_41 = {};
        bool adj_42 = {};
        bool adj_43 = {};
        bool adj_44 = {};
        wp::int32 adj_45 = {};
        wp::int32 adj_46 = {};
        wp::int32 adj_47 = {};
        bool adj_48 = {};
        wp::int32 adj_49 = {};
        bool adj_50 = {};
        bool adj_51 = {};
        bool adj_52 = {};
        bool adj_53 = {};
        bool adj_54 = {};
        wp::int32 adj_55 = {};
        bool adj_56 = {};
        wp::int32 adj_57 = {};
        wp::int32 adj_58 = {};
        wp::int32 adj_59 = {};
        wp::int32 adj_60 = {};
        wp::int32 adj_61 = {};
        wp::int32 adj_62 = {};
        wp::int32 adj_63 = {};
        wp::int32 adj_64 = {};
        bool adj_65 = {};
        bool adj_66 = {};
        bool adj_67 = {};
        wp::int32 adj_68 = {};
        wp::bvh_query_t adj_69 = {};
        wp::int32 adj_70 = {};
        wp::bvh_query_t adj_71 = {};
        wp::bvh_query_t adj_72 = {};
        wp::int32 adj_73 = {};
        wp::int32 adj_74 = {};
        bool adj_75 = {};
        wp::float32 adj_76 = {};
        wp::int32 adj_77 = {};
        wp::int32 adj_78 = {};
        wp::int32 adj_79 = {};
        wp::int32 adj_80 = {};
        wp::int32 adj_81 = {};
        wp::int32 adj_82 = {};
        wp::int32 adj_83 = {};
        wp::int32 adj_84 = {};
        wp::int32 adj_85 = {};
        wp::int32 adj_86 = {};
        wp::int32 adj_87 = {};
        wp::int32 adj_88 = {};
        bool adj_89 = {};
        wp::int32 adj_90 = {};
        wp::int32 adj_91 = {};
        wp::int32 adj_92 = {};
        wp::int32 adj_93 = {};
        wp::int32 adj_94 = {};
        wp::int32 adj_95 = {};
        wp::int32 adj_96 = {};
        wp::int32 adj_97 = {};
        bool adj_98 = {};
        wp::int32 adj_99 = {};
        wp::int32 adj_100 = {};
        wp::int32 adj_101 = {};
        wp::int32 adj_102 = {};
        wp::int32 adj_103 = {};
        wp::int32 adj_104 = {};
        wp::int32 adj_105 = {};
        wp::int32 adj_106 = {};
        bool adj_107 = {};
        bool adj_108 = {};
        bool adj_109 = {};
        wp::int32 adj_110 = {};
        bool adj_111 = {};
        bool adj_112 = {};
        wp::int32 adj_113 = {};
        wp::int32 adj_114 = {};
        wp::int32 adj_115 = {};
        bool adj_116 = {};
        wp::int32 adj_117 = {};
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
        wp::int32 adj_129 = {};
        wp::vec_t<3, wp::float32> adj_130 = {};
        wp::float32 adj_131 = {};
        bool adj_132 = {};
        wp::float32 adj_133 = {};
        bool adj_134 = {};
        wp::vec_t<3, wp::float32> adj_135 = {};
        wp::vec_t<3, wp::float32> adj_136 = {};
        wp::vec_t<3, wp::float32> adj_137 = {};
        wp::vec_t<3, wp::float32> adj_138 = {};
        wp::vec_t<3, wp::float32> adj_139 = {};
        wp::vec_t<3, wp::float32> adj_140 = {};
        wp::int32 adj_141 = {};
        wp::vec_t<3, wp::float32> adj_142 = {};
        wp::vec_t<3, wp::float32> adj_143 = {};
        wp::vec_t<3, wp::float32> adj_144 = {};
        wp::vec_t<3, wp::float32> adj_145 = {};
        wp::vec_t<3, wp::float32> adj_146 = {};
        wp::vec_t<3, wp::float32> adj_147 = {};
        wp::vec_t<3, wp::float32> adj_148 = {};
        wp::float32 adj_149 = {};
        bool adj_150 = {};
        bool adj_151 = {};
        wp::float32 adj_152 = {};
        bool adj_153 = {};
        wp::int32 adj_154 = {};
        wp::int32 adj_155 = {};
        wp::int32 adj_156 = {};
        wp::int32 adj_157 = {};
        wp::int32 adj_158 = {};
        wp::int32 adj_159 = {};
        wp::int32 adj_160 = {};
        wp::int32 adj_161 = {};
        wp::int32 adj_162 = {};
        wp::int32 adj_163 = {};
        wp::int32 adj_164 = {};
        wp::int32 adj_165 = {};
        wp::float32 adj_166 = {};
        wp::int32 adj_167 = {};
        wp::int32 adj_168 = {};
        wp::int32 adj_169 = {};
        wp::int32 adj_170 = {};
        wp::int32 adj_171 = {};
        bool adj_172 = {};
        wp::int32 adj_173 = {};
        wp::int32 adj_174 = {};
        wp::int32 adj_175 = {};
        wp::int32 adj_176 = {};
        wp::int32 adj_177 = {};
        wp::int32 adj_178 = {};
        wp::int32 adj_179 = {};
        wp::float32 adj_180 = {};
        wp::int32 adj_181 = {};
        wp::int32 adj_182 = {};
        bool adj_183 = {};
        bool adj_184 = {};
        bool adj_185 = {};
        bool adj_186 = {};
        wp::int32 adj_187 = {};
        wp::int32 adj_188 = {};
        wp::int32 adj_189 = {};
        bool adj_190 = {};
        wp::int32 adj_191 = {};
        bool adj_192 = {};
        bool adj_193 = {};
        bool adj_194 = {};
        bool adj_195 = {};
        bool adj_196 = {};
        wp::int32 adj_197 = {};
        bool adj_198 = {};
        wp::int32 adj_199 = {};
        wp::int32 adj_200 = {};
        wp::int32 adj_201 = {};
        wp::int32 adj_202 = {};
        wp::int32 adj_203 = {};
        wp::int32 adj_204 = {};
        wp::int32 adj_205 = {};
        wp::int32 adj_206 = {};
        bool adj_207 = {};
        bool adj_208 = {};
        bool adj_209 = {};
        wp::int32 adj_210 = {};
        wp::bvh_query_t adj_211 = {};
        wp::int32 adj_212 = {};
        wp::bvh_query_t adj_213 = {};
        wp::bvh_query_t adj_214 = {};
        wp::int32 adj_215 = {};
        wp::int32 adj_216 = {};
        bool adj_217 = {};
        wp::float32 adj_218 = {};
        wp::int32 adj_219 = {};
        wp::int32 adj_220 = {};
        wp::int32 adj_221 = {};
        wp::int32 adj_222 = {};
        wp::int32 adj_223 = {};
        wp::int32 adj_224 = {};
        wp::int32 adj_225 = {};
        wp::int32 adj_226 = {};
        wp::int32 adj_227 = {};
        wp::int32 adj_228 = {};
        wp::int32 adj_229 = {};
        wp::int32 adj_230 = {};
        bool adj_231 = {};
        wp::int32 adj_232 = {};
        wp::int32 adj_233 = {};
        wp::int32 adj_234 = {};
        wp::int32 adj_235 = {};
        wp::int32 adj_236 = {};
        wp::int32 adj_237 = {};
        wp::int32 adj_238 = {};
        wp::int32 adj_239 = {};
        wp::int32 adj_240 = {};
        wp::int32 adj_241 = {};
        wp::int32 adj_242 = {};
        bool adj_243 = {};
        wp::int32 adj_244 = {};
        wp::int32 adj_245 = {};
        wp::int32 adj_246 = {};
        wp::int32 adj_247 = {};
        wp::int32 adj_248 = {};
        wp::int32 adj_249 = {};
        wp::int32 adj_250 = {};
        wp::int32 adj_251 = {};
        bool adj_252 = {};
        bool adj_253 = {};
        bool adj_254 = {};
        wp::int32 adj_255 = {};
        bool adj_256 = {};
        bool adj_257 = {};
        wp::int32 adj_258 = {};
        wp::int32 adj_259 = {};
        wp::int32 adj_260 = {};
        bool adj_261 = {};
        wp::int32 adj_262 = {};
        wp::int32 adj_263 = {};
        wp::int32 adj_264 = {};
        wp::int32 adj_265 = {};
        wp::int32 adj_266 = {};
        wp::int32 adj_267 = {};
        wp::int32 adj_268 = {};
        wp::int32 adj_269 = {};
        wp::int32 adj_270 = {};
        wp::int32 adj_271 = {};
        wp::int32 adj_272 = {};
        wp::int32 adj_273 = {};
        wp::int32 adj_274 = {};
        wp::int32 adj_275 = {};
        wp::int32 adj_276 = {};
        wp::int32 adj_277 = {};
        wp::int32 adj_278 = {};
        wp::int32 adj_279 = {};
        wp::int32 adj_280 = {};
        wp::int32 adj_281 = {};
        wp::int32 adj_282 = {};
        wp::int32 adj_283 = {};
        wp::int32 adj_284 = {};
        wp::int32 adj_285 = {};
        wp::int32 adj_286 = {};
        wp::int32 adj_287 = {};
        wp::int32 adj_288 = {};
        wp::int32 adj_289 = {};
        wp::int32 adj_290 = {};
        wp::int32 adj_291 = {};
        wp::int32 adj_292 = {};
        wp::int32 adj_293 = {};
        wp::int32 adj_294 = {};
        wp::vec_t<3, wp::float32> adj_295 = {};
        wp::vec_t<3, wp::float32> adj_296 = {};
        wp::vec_t<3, wp::float32> adj_297 = {};
        wp::vec_t<3, wp::float32> adj_298 = {};
        wp::vec_t<3, wp::float32> adj_299 = {};
        wp::vec_t<3, wp::float32> adj_300 = {};
        wp::vec_t<3, wp::float32> adj_301 = {};
        wp::vec_t<3, wp::float32> adj_302 = {};
        wp::vec_t<3, wp::float32> adj_303 = {};
        wp::vec_t<3, wp::float32> adj_304 = {};
        wp::vec_t<3, wp::float32> adj_305 = {};
        wp::int32 adj_306 = {};
        wp::vec_t<3, wp::float32> adj_307 = {};
        wp::float32 adj_308 = {};
        bool adj_309 = {};
        wp::float32 adj_310 = {};
        bool adj_311 = {};
        wp::vec_t<3, wp::float32> adj_312 = {};
        wp::vec_t<3, wp::float32> adj_313 = {};
        wp::vec_t<3, wp::float32> adj_314 = {};
        wp::vec_t<3, wp::float32> adj_315 = {};
        wp::vec_t<3, wp::float32> adj_316 = {};
        wp::vec_t<3, wp::float32> adj_317 = {};
        wp::int32 adj_318 = {};
        wp::vec_t<3, wp::float32> adj_319 = {};
        wp::vec_t<3, wp::float32> adj_320 = {};
        wp::vec_t<3, wp::float32> adj_321 = {};
        wp::vec_t<3, wp::float32> adj_322 = {};
        wp::vec_t<3, wp::float32> adj_323 = {};
        wp::vec_t<3, wp::float32> adj_324 = {};
        wp::vec_t<3, wp::float32> adj_325 = {};
        wp::float32 adj_326 = {};
        bool adj_327 = {};
        wp::int32 adj_328 = {};
        wp::int32 adj_329 = {};
        wp::int32 adj_330 = {};
        wp::int32 adj_331 = {};
        wp::int32 adj_332 = {};
        wp::int32 adj_333 = {};
        wp::int32 adj_334 = {};
        wp::int32 adj_335 = {};
        wp::vec_t<3, wp::float32> adj_336 = {};
        wp::vec_t<3, wp::float32> adj_337 = {};
        wp::vec_t<3, wp::float32> adj_338 = {};
        wp::vec_t<3, wp::float32> adj_339 = {};
        wp::vec_t<3, wp::float32> adj_340 = {};
        wp::int32 adj_341 = {};
        wp::float32 adj_342 = {};
        wp::vec_t<3, wp::float32> adj_343 = {};
        wp::vec_t<3, wp::float32> adj_344 = {};
        wp::int32 adj_345 = {};
        wp::float32 adj_346 = {};
        wp::int32 adj_347 = {};
        wp::int32 adj_348 = {};
        wp::int32 adj_349 = {};
        wp::int32 adj_350 = {};
        wp::int32 adj_351 = {};
        wp::int32 adj_352 = {};
        wp::int32 adj_353 = {};
        wp::int32 adj_354 = {};
        wp::vec_t<3, wp::float32> adj_355 = {};
        wp::vec_t<3, wp::float32> adj_356 = {};
        wp::vec_t<3, wp::float32> adj_357 = {};
        wp::vec_t<3, wp::float32> adj_358 = {};
        wp::vec_t<3, wp::float32> adj_359 = {};
        wp::int32 adj_360 = {};
        wp::float32 adj_361 = {};
        wp::vec_t<3, wp::float32> adj_362 = {};
        wp::vec_t<3, wp::float32> adj_363 = {};
        wp::int32 adj_364 = {};
        wp::float32 adj_365 = {};
        bool adj_366 = {};
        wp::float32 adj_367 = {};
        bool adj_368 = {};
        wp::int32 adj_369 = {};
        wp::int32 adj_370 = {};
        wp::int32 adj_371 = {};
        wp::int32 adj_372 = {};
        wp::int32 adj_373 = {};
        wp::int32 adj_374 = {};
        wp::int32 adj_375 = {};
        wp::int32 adj_376 = {};
        wp::int32 adj_377 = {};
        wp::int32 adj_378 = {};
        wp::int32 adj_379 = {};
        wp::float32 adj_380 = {};
        wp::int32 adj_381 = {};
        wp::int32 adj_382 = {};
        wp::int32 adj_383 = {};
        wp::int32 adj_384 = {};
        wp::int32 adj_385 = {};
        bool adj_386 = {};
        wp::int32 adj_387 = {};
        wp::int32 adj_388 = {};
        wp::int32 adj_389 = {};
        wp::int32 adj_390 = {};
        wp::int32 adj_391 = {};
        wp::int32 adj_392 = {};
        wp::int32 adj_393 = {};
        wp::int32 adj_394 = {};
        wp::int32 adj_395 = {};
        wp::int32 adj_396 = {};
        wp::float32 adj_397 = {};
        wp::int32 adj_398 = {};
        wp::int32 adj_399 = {};
        wp::int32 adj_400 = {};
        wp::int32 adj_401 = {};
        wp::bvh_query_t adj_402 = {};
        //---------
        // forward
        // def vertex_triangle_collision_detection_kernel(                                        <L 1329>
        // v_index = wp.tid()                                                                     <L 1388>
        var_0 = builtin_tid1d();
        // v = pos[v_index]                                                                       <L 1389>
        var_1 = wp::address(var_pos, var_0);
        var_3 = wp::load(var_1);
        var_2 = wp::copy(var_3);
        // vertex_buffer_offset = vertex_colliding_triangles_offsets[v_index]                     <L 1390>
        var_4 = wp::address(var_vertex_colliding_triangles_offsets, var_0);
        var_6 = wp::load(var_4);
        var_5 = wp::copy(var_6);
        // vertex_buffer_size = vertex_colliding_triangles_offsets[v_index + 1] - vertex_buffer_offset       <L 1391>
        var_8 = wp::add(var_0, var_7);
        var_9 = wp::address(var_vertex_colliding_triangles_offsets, var_8);
        var_11 = wp::load(var_9);
        var_10 = wp::sub(var_11, var_5);
        // lower = wp.vec3(v[0] - max_query_radius, v[1] - max_query_radius, v[2] - max_query_radius)       <L 1393>
        var_13 = wp::extract(var_2, var_12);
        var_14 = wp::sub(var_13, var_max_query_radius);
        var_16 = wp::extract(var_2, var_15);
        var_17 = wp::sub(var_16, var_max_query_radius);
        var_19 = wp::extract(var_2, var_18);
        var_20 = wp::sub(var_19, var_max_query_radius);
        var_21 = wp::vec_t<3, wp::float32>(var_14, var_17, var_20);
        // upper = wp.vec3(v[0] + max_query_radius, v[1] + max_query_radius, v[2] + max_query_radius)       <L 1394>
        var_23 = wp::extract(var_2, var_22);
        var_24 = wp::add(var_23, var_max_query_radius);
        var_26 = wp::extract(var_2, var_25);
        var_27 = wp::add(var_26, var_max_query_radius);
        var_29 = wp::extract(var_2, var_28);
        var_30 = wp::add(var_29, var_max_query_radius);
        var_31 = wp::vec_t<3, wp::float32>(var_24, var_27, var_30);
        // tri_index = wp.int32(0)                                                                <L 1396>
        var_33 = wp::int32(var_32);
        // vertex_num_collisions = wp.int32(0)                                                    <L 1397>
        var_35 = wp::int32(var_34);
        // min_dis_to_tris = max_query_radius                                                     <L 1398>
        var_36 = wp::copy(var_max_query_radius);
        // vertex_world = particle_world[v_index]                                                 <L 1399>
        var_37 = wp::address(var_particle_world, var_0);
        var_39 = wp::load(var_37);
        var_38 = wp::copy(var_39);
        // for query_pass in range(2):                                                            <L 1405>
        // run_query = bool(False)                                                                <L 1406>
        var_42 = bool(var_41);
        // query_all = bool(False)                                                                <L 1407>
        var_44 = bool(var_43);
        // group_root = wp.int32(-1)                                                              <L 1408>
        var_46 = wp::int32(var_45);
        // if vertex_world < 0:                                                                   <L 1410>
        var_48 = (var_38 < var_47);
        if (var_48) {
            // if query_pass == 0:                                                                <L 1411>
            var_50 = (var_40 == var_49);
            if (var_50) {
                // run_query = True                                                               <L 1412>
                // query_all = True                                                               <L 1413>
            }
            var_53 = wp::where(var_50, var_51, var_42);
            var_54 = wp::where(var_50, var_52, var_44);
        }
        if (!var_48) {
            // if query_pass == 0:                                                                <L 1415>
            var_56 = (var_40 == var_55);
            if (var_56) {
                // group_root = bvh_group_roots[vertex_world]                                     <L 1416>
                var_57 = wp::address(var_bvh_group_roots, var_38);
                var_59 = wp::load(var_57);
                var_58 = wp::copy(var_59);
            }
            if (!var_56) {
                // group_root = bvh_group_roots[world_count]                                      <L 1418>
                var_60 = wp::address(var_bvh_group_roots, var_world_count);
                var_62 = wp::load(var_60);
                var_61 = wp::copy(var_62);
            }
            var_63 = wp::where(var_56, var_58, var_61);
            // run_query = group_root >= 0                                                        <L 1419>
            var_65 = (var_63 >= var_64);
        }
        var_66 = wp::where(var_48, var_53, var_65);
        var_67 = wp::where(var_48, var_54, var_44);
        var_68 = wp::where(var_48, var_46, var_63);
        // if run_query:                                                                          <L 1421>
        if (var_66) {
            // if query_all:                                                                      <L 1422>
            if (var_67) {
                // query = wp.bvh_query_aabb(bvh_id, lower, upper)                                <L 1423>
                var_69 = wp::bvh_query_aabb(var_bvh_id, var_21, var_31, var_70);
            }
            if (!var_67) {
                // query = wp.bvh_query_aabb(bvh_id, lower, upper, group_root)                    <L 1425>
                var_71 = wp::bvh_query_aabb(var_bvh_id, var_21, var_31, var_68);
            }
            var_72 = wp::where(var_67, var_69, var_71);
            // tri_index = wp.int32(0)                                                            <L 1427>
            var_74 = wp::int32(var_73);
            // while wp.bvh_query_next(query, tri_index):                                         <L 1428>
        }
        var_181 = wp::where(var_66, var_74, var_33);
        // run_query = bool(False)                                                                <L 1406>
        var_184 = bool(var_183);
        // query_all = bool(False)                                                                <L 1407>
        var_186 = bool(var_185);
        // group_root = wp.int32(-1)                                                              <L 1408>
        var_188 = wp::int32(var_187);
        // if vertex_world < 0:                                                                   <L 1410>
        var_190 = (var_38 < var_189);
        if (var_190) {
            // if query_pass == 0:                                                                <L 1411>
            var_192 = (var_182 == var_191);
            if (var_192) {
                // run_query = True                                                               <L 1412>
                // query_all = True                                                               <L 1413>
            }
            var_195 = wp::where(var_192, var_193, var_184);
            var_196 = wp::where(var_192, var_194, var_186);
        }
        if (!var_190) {
            // if query_pass == 0:                                                                <L 1415>
            var_198 = (var_182 == var_197);
            if (var_198) {
                // group_root = bvh_group_roots[vertex_world]                                     <L 1416>
                var_199 = wp::address(var_bvh_group_roots, var_38);
                var_201 = wp::load(var_199);
                var_200 = wp::copy(var_201);
            }
            if (!var_198) {
                // group_root = bvh_group_roots[world_count]                                      <L 1418>
                var_202 = wp::address(var_bvh_group_roots, var_world_count);
                var_204 = wp::load(var_202);
                var_203 = wp::copy(var_204);
            }
            var_205 = wp::where(var_198, var_200, var_203);
            // run_query = group_root >= 0                                                        <L 1419>
            var_207 = (var_205 >= var_206);
        }
        var_208 = wp::where(var_190, var_195, var_207);
        var_209 = wp::where(var_190, var_196, var_186);
        var_210 = wp::where(var_190, var_188, var_205);
        // if run_query:                                                                          <L 1421>
        if (var_208) {
            // if query_all:                                                                      <L 1422>
            if (var_209) {
                // query = wp.bvh_query_aabb(bvh_id, lower, upper)                                <L 1423>
                var_211 = wp::bvh_query_aabb(var_bvh_id, var_21, var_31, var_212);
            }
            if (!var_209) {
                // query = wp.bvh_query_aabb(bvh_id, lower, upper, group_root)                    <L 1425>
                var_213 = wp::bvh_query_aabb(var_bvh_id, var_21, var_31, var_210);
            }
            var_214 = wp::where(var_209, var_211, var_213);
            // tri_index = wp.int32(0)                                                            <L 1427>
            var_216 = wp::int32(var_215);
            // while wp.bvh_query_next(query, tri_index):                                         <L 1428>
        }
        var_401 = wp::where(var_208, var_216, var_181);
        var_402 = wp::where(var_208, var_214, var_72);
        // vertex_colliding_triangles_count[v_index] = vertex_num_collisions                      <L 1495>
        // wp::array_store(var_vertex_colliding_triangles_count, var_0, var_35);
        // vertex_colliding_triangles_min_dist[v_index] = min_dis_to_tris                         <L 1496>
        // wp::array_store(var_vertex_colliding_triangles_min_dist, var_0, var_36);
        //---------
        // reverse
        wp::adj_array_store(var_vertex_colliding_triangles_min_dist, var_0, var_36, adj_vertex_colliding_triangles_min_dist, adj_0, adj_36);
        // adj: vertex_colliding_triangles_min_dist[v_index] = min_dis_to_tris                    <L 1496>
        wp::adj_array_store(var_vertex_colliding_triangles_count, var_0, var_35, adj_vertex_colliding_triangles_count, adj_0, adj_35);
        // adj: vertex_colliding_triangles_count[v_index] = vertex_num_collisions                 <L 1495>
        wp::adj_where(var_208, var_214, var_72, adj_208, adj_214, adj_72, adj_402);
        wp::adj_where(var_208, var_216, var_181, adj_208, adj_216, adj_181, adj_401);
        if (var_208) {
        start_while_2:;
            var_217 = wp::bvh_query_next(var_214, var_216, var_218);
        if ((var_217) == false) goto end_while_2;
        adj_219 = {};
        adj_220 = {};
        adj_221 = {};
        adj_222 = {};
        adj_223 = {};
        adj_224 = {};
        adj_225 = {};
        adj_226 = {};
        adj_227 = {};
        adj_228 = {};
        adj_229 = {};
        adj_230 = {};
        adj_231 = {};
        adj_232 = {};
        adj_233 = {};
        adj_234 = {};
        adj_235 = {};
        adj_236 = {};
        adj_237 = {};
        adj_238 = {};
        adj_239 = {};
        adj_240 = {};
        adj_241 = {};
        adj_242 = {};
        adj_243 = {};
        adj_244 = {};
        adj_245 = {};
        adj_246 = {};
        adj_247 = {};
        adj_248 = {};
        adj_249 = {};
        adj_250 = {};
        adj_251 = {};
        adj_252 = {};
        adj_253 = {};
        adj_254 = {};
        adj_255 = {};
        adj_256 = {};
        adj_257 = {};
        adj_258 = {};
        adj_259 = {};
        adj_260 = {};
        adj_261 = {};
        adj_262 = {};
        adj_263 = {};
        adj_264 = {};
        adj_265 = {};
        adj_266 = {};
        adj_267 = {};
        adj_268 = {};
        adj_269 = {};
        adj_270 = {};
        adj_271 = {};
        adj_272 = {};
        adj_273 = {};
        adj_274 = {};
        adj_275 = {};
        adj_276 = {};
        adj_277 = {};
        adj_278 = {};
        adj_279 = {};
        adj_280 = {};
        adj_281 = {};
        adj_282 = {};
        adj_283 = {};
        adj_284 = {};
        adj_285 = {};
        adj_286 = {};
        adj_287 = {};
        adj_288 = {};
        adj_289 = {};
        adj_290 = {};
        adj_291 = {};
        adj_292 = {};
        adj_293 = {};
        adj_294 = {};
        adj_295 = {};
        adj_296 = {};
        adj_297 = {};
        adj_298 = {};
        adj_299 = {};
        adj_300 = {};
        adj_301 = {};
        adj_302 = {};
        adj_303 = {};
        adj_304 = {};
        adj_305 = {};
        adj_306 = {};
        adj_307 = {};
        adj_308 = {};
        adj_309 = {};
        adj_310 = {};
        adj_311 = {};
        adj_312 = {};
        adj_313 = {};
        adj_314 = {};
        adj_315 = {};
        adj_316 = {};
        adj_317 = {};
        adj_318 = {};
        adj_319 = {};
        adj_320 = {};
        adj_321 = {};
        adj_322 = {};
        adj_323 = {};
        adj_324 = {};
        adj_325 = {};
        adj_326 = {};
        adj_327 = {};
        adj_328 = {};
        adj_329 = {};
        adj_330 = {};
        adj_331 = {};
        adj_332 = {};
        adj_333 = {};
        adj_334 = {};
        adj_335 = {};
        adj_336 = {};
        adj_337 = {};
        adj_338 = {};
        adj_339 = {};
        adj_340 = {};
        adj_341 = {};
        adj_342 = {};
        adj_343 = {};
        adj_344 = {};
        adj_345 = {};
        adj_346 = {};
        adj_347 = {};
        adj_348 = {};
        adj_349 = {};
        adj_350 = {};
        adj_351 = {};
        adj_352 = {};
        adj_353 = {};
        adj_354 = {};
        adj_355 = {};
        adj_356 = {};
        adj_357 = {};
        adj_358 = {};
        adj_359 = {};
        adj_360 = {};
        adj_361 = {};
        adj_362 = {};
        adj_363 = {};
        adj_364 = {};
        adj_365 = {};
        adj_366 = {};
        adj_367 = {};
        adj_368 = {};
        adj_369 = {};
        adj_370 = {};
        adj_371 = {};
        adj_372 = {};
        adj_373 = {};
        adj_374 = {};
        adj_375 = {};
        adj_376 = {};
        adj_377 = {};
        adj_378 = {};
        adj_379 = {};
        adj_380 = {};
        adj_381 = {};
        adj_382 = {};
        adj_383 = {};
        adj_384 = {};
        adj_385 = {};
        adj_386 = {};
        adj_387 = {};
        adj_388 = {};
        adj_389 = {};
        adj_390 = {};
        adj_391 = {};
        adj_392 = {};
        adj_393 = {};
        adj_394 = {};
        adj_395 = {};
        adj_396 = {};
        adj_397 = {};
        adj_398 = {};
        adj_399 = {};
        adj_400 = {};
                // t1 = tri_indices[tri_index, 0]                                                 <L 1429>
                var_220 = wp::address(var_tri_indices, var_216, var_219);
                var_222 = wp::load(var_220);
                var_221 = wp::copy(var_222);
                // t2 = tri_indices[tri_index, 1]                                                 <L 1430>
                var_224 = wp::address(var_tri_indices, var_216, var_223);
                var_226 = wp::load(var_224);
                var_225 = wp::copy(var_226);
                // t3 = tri_indices[tri_index, 2]                                                 <L 1431>
                var_228 = wp::address(var_tri_indices, var_216, var_227);
                var_230 = wp::load(var_228);
                var_229 = wp::copy(var_230);
                // if vertex_adjacent_to_triangle(v_index, t1, t2, t3):                           <L 1433>
                var_231 = vertex_adjacent_to_triangle_0(var_0, var_221, var_225, var_229);
                if (var_231) {
                    // continue                                                                   <L 1434>
                    wp::assign(var_79, var_221);
                    wp::assign(var_83, var_225);
                    wp::assign(var_87, var_229);
                    goto start_while_2;
                }
                var_232 = wp::where(var_231, var_79, var_221);
                var_233 = wp::where(var_231, var_83, var_225);
                var_234 = wp::where(var_231, var_87, var_229);
                // if vertex_triangle_filtering_list:                                             <L 1436>
                if (var_vertex_triangle_filtering_list) {
                    // fl_start = vertex_triangle_filtering_list_offsets[v_index]                 <L 1437>
                    var_235 = wp::address(var_vertex_triangle_filtering_list_offsets, var_0);
                    var_237 = wp::load(var_235);
                    var_236 = wp::copy(var_237);
                    // fl_end = vertex_triangle_filtering_list_offsets[                           <L 1438>
                    // v_index + 1                                                                <L 1439>
                    var_239 = wp::add(var_0, var_238);
                    var_240 = wp::address(var_vertex_triangle_filtering_list_offsets, var_239);
                    var_242 = wp::load(var_240);
                    var_241 = wp::copy(var_242);
                    // if fl_end > fl_start:                                                      <L 1442>
                    var_243 = (var_241 > var_236);
                    if (var_243) {
                        // first_val = vertex_triangle_filtering_list[fl_start]                   <L 1444>
                        var_244 = wp::address(var_vertex_triangle_filtering_list, var_236);
                        var_246 = wp::load(var_244);
                        var_245 = wp::copy(var_246);
                        // last_val = vertex_triangle_filtering_list[fl_end - 1]                  <L 1445>
                        var_248 = wp::sub(var_241, var_247);
                        var_249 = wp::address(var_vertex_triangle_filtering_list, var_248);
                        var_251 = wp::load(var_249);
                        var_250 = wp::copy(var_251);
                        // if (tri_index >= first_val) and (tri_index <= last_val):               <L 1446>
                        var_253 = (var_216 >= var_245);
                        var_252 = var_253;
                        if (var_252) {
                            var_254 = (var_216 <= var_250);
                            var_252 = var_252 && var_254;
                        }
                        if (var_252) {
                            // idx = binary_search(vertex_triangle_filtering_list, tri_index, fl_start, fl_end)       <L 1447>
                            var_255 = binary_search_0(var_vertex_triangle_filtering_list, var_216, var_236, var_241);
                            // if idx > fl_start and vertex_triangle_filtering_list[idx - 1] == tri_index:       <L 1449>
                            var_257 = (var_255 > var_236);
                            var_256 = var_257;
                            if (var_256) {
                                var_259 = wp::sub(var_255, var_258);
                                var_260 = wp::address(var_vertex_triangle_filtering_list, var_259);
                                var_262 = wp::load(var_260);
                                var_261 = (var_262 == var_216);
                                var_256 = var_256 && var_261;
                            }
                            if (var_256) {
                                // continue                                                       <L 1450>
                                wp::assign(var_79, var_232);
                                wp::assign(var_83, var_233);
                                wp::assign(var_87, var_234);
                                wp::assign(var_91, var_236);
                                wp::assign(var_96, var_241);
                                wp::assign(var_100, var_245);
                                wp::assign(var_105, var_250);
                                wp::assign(var_110, var_255);
                                goto start_while_2;
                            }
                            var_263 = wp::where(var_256, var_79, var_232);
                            var_264 = wp::where(var_256, var_83, var_233);
                            var_265 = wp::where(var_256, var_87, var_234);
                            var_266 = wp::where(var_256, var_91, var_236);
                            var_267 = wp::where(var_256, var_96, var_241);
                            var_268 = wp::where(var_256, var_100, var_245);
                            var_269 = wp::where(var_256, var_105, var_250);
                            var_270 = wp::where(var_256, var_110, var_255);
                        }
                        var_271 = wp::where(var_252, var_263, var_232);
                        var_272 = wp::where(var_252, var_264, var_233);
                        var_273 = wp::where(var_252, var_265, var_234);
                        var_274 = wp::where(var_252, var_266, var_236);
                        var_275 = wp::where(var_252, var_267, var_241);
                        var_276 = wp::where(var_252, var_268, var_245);
                        var_277 = wp::where(var_252, var_269, var_250);
                        var_278 = wp::where(var_252, var_270, var_110);
                    }
                    var_279 = wp::where(var_243, var_271, var_232);
                    var_280 = wp::where(var_243, var_272, var_233);
                    var_281 = wp::where(var_243, var_273, var_234);
                    var_282 = wp::where(var_243, var_274, var_236);
                    var_283 = wp::where(var_243, var_275, var_241);
                    var_284 = wp::where(var_243, var_276, var_100);
                    var_285 = wp::where(var_243, var_277, var_105);
                    var_286 = wp::where(var_243, var_278, var_110);
                }
                var_287 = wp::where(var_vertex_triangle_filtering_list, var_279, var_232);
                var_288 = wp::where(var_vertex_triangle_filtering_list, var_280, var_233);
                var_289 = wp::where(var_vertex_triangle_filtering_list, var_281, var_234);
                var_290 = wp::where(var_vertex_triangle_filtering_list, var_282, var_91);
                var_291 = wp::where(var_vertex_triangle_filtering_list, var_283, var_96);
                var_292 = wp::where(var_vertex_triangle_filtering_list, var_284, var_100);
                var_293 = wp::where(var_vertex_triangle_filtering_list, var_285, var_105);
                var_294 = wp::where(var_vertex_triangle_filtering_list, var_286, var_110);
                // u1 = pos[t1]                                                                   <L 1452>
                var_295 = wp::address(var_pos, var_287);
                var_297 = wp::load(var_295);
                var_296 = wp::copy(var_297);
                // u2 = pos[t2]                                                                   <L 1453>
                var_298 = wp::address(var_pos, var_288);
                var_300 = wp::load(var_298);
                var_299 = wp::copy(var_300);
                // u3 = pos[t3]                                                                   <L 1454>
                var_301 = wp::address(var_pos, var_289);
                var_303 = wp::load(var_301);
                var_302 = wp::copy(var_303);
                // closest_p, _bary, _feature_type = triangle_closest_point(u1, u2, u3, v)        <L 1456>
                triangle_closest_point_0(var_296, var_299, var_302, var_2, var_304, var_305, var_306);
                // dist = wp.length(closest_p - v)                                                <L 1458>
                var_307 = wp::sub(var_304, var_2);
                var_308 = wp::length(var_307);
                // if min_distance_filtering_ref_pos and min_query_radius > 0.0:                  <L 1460>
                var_309 = var_min_distance_filtering_ref_pos;
                if (var_309) {
                    var_311 = (var_min_query_radius > var_310);
                    var_309 = var_309 && var_311;
                }
                if (var_309) {
                    // closest_p_ref, _, __ = triangle_closest_point(                             <L 1461>
                    // min_distance_filtering_ref_pos[t1],                                        <L 1462>
                    var_312 = wp::address(var_min_distance_filtering_ref_pos, var_287);
                    // min_distance_filtering_ref_pos[t2],                                        <L 1463>
                    var_313 = wp::address(var_min_distance_filtering_ref_pos, var_288);
                    // min_distance_filtering_ref_pos[t3],                                        <L 1464>
                    var_314 = wp::address(var_min_distance_filtering_ref_pos, var_289);
                    // min_distance_filtering_ref_pos[v_index],                                   <L 1465>
                    var_315 = wp::address(var_min_distance_filtering_ref_pos, var_0);
                    var_319 = wp::load(var_312);
                    var_320 = wp::load(var_313);
                    var_321 = wp::load(var_314);
                    var_322 = wp::load(var_315);
                    triangle_closest_point_0(var_319, var_320, var_321, var_322, var_316, var_317, var_318);
                    // dist_ref = wp.length(closest_p_ref - min_distance_filtering_ref_pos[v_index])       <L 1467>
                    var_323 = wp::address(var_min_distance_filtering_ref_pos, var_0);
                    var_325 = wp::load(var_323);
                    var_324 = wp::sub(var_316, var_325);
                    var_326 = wp::length(var_324);
                    // if dist_ref < min_query_radius:                                            <L 1469>
                    var_327 = (var_326 < var_min_query_radius);
                    if (var_327) {
                        // continue                                                               <L 1470>
                        wp::assign(var_79, var_287);
                        wp::assign(var_83, var_288);
                        wp::assign(var_87, var_289);
                        wp::assign(var_91, var_290);
                        wp::assign(var_96, var_291);
                        wp::assign(var_100, var_292);
                        wp::assign(var_105, var_293);
                        wp::assign(var_110, var_294);
                        wp::assign(var_119, var_296);
                        wp::assign(var_122, var_299);
                        wp::assign(var_125, var_302);
                        wp::assign(var_127, var_304);
                        wp::assign(var_128, var_305);
                        wp::assign(var_129, var_306);
                        wp::assign(var_131, var_308);
                        wp::assign(var_139, var_316);
                        wp::assign(var_140, var_317);
                        wp::assign(var_141, var_318);
                        wp::assign(var_149, var_326);
                        goto start_while_2;
                    }
                    var_328 = wp::where(var_327, var_79, var_287);
                    var_329 = wp::where(var_327, var_83, var_288);
                    var_330 = wp::where(var_327, var_87, var_289);
                    var_331 = wp::where(var_327, var_91, var_290);
                    var_332 = wp::where(var_327, var_96, var_291);
                    var_333 = wp::where(var_327, var_100, var_292);
                    var_334 = wp::where(var_327, var_105, var_293);
                    var_335 = wp::where(var_327, var_110, var_294);
                    var_336 = wp::where(var_327, var_119, var_296);
                    var_337 = wp::where(var_327, var_122, var_299);
                    var_338 = wp::where(var_327, var_125, var_302);
                    var_339 = wp::where(var_327, var_127, var_304);
                    var_340 = wp::where(var_327, var_128, var_305);
                    var_341 = wp::where(var_327, var_129, var_306);
                    var_342 = wp::where(var_327, var_131, var_308);
                    var_343 = wp::where(var_327, var_139, var_316);
                    var_344 = wp::where(var_327, var_140, var_317);
                    var_345 = wp::where(var_327, var_141, var_318);
                    var_346 = wp::where(var_327, var_149, var_326);
                }
                var_347 = wp::where(var_309, var_328, var_287);
                var_348 = wp::where(var_309, var_329, var_288);
                var_349 = wp::where(var_309, var_330, var_289);
                var_350 = wp::where(var_309, var_331, var_290);
                var_351 = wp::where(var_309, var_332, var_291);
                var_352 = wp::where(var_309, var_333, var_292);
                var_353 = wp::where(var_309, var_334, var_293);
                var_354 = wp::where(var_309, var_335, var_294);
                var_355 = wp::where(var_309, var_336, var_296);
                var_356 = wp::where(var_309, var_337, var_299);
                var_357 = wp::where(var_309, var_338, var_302);
                var_358 = wp::where(var_309, var_339, var_304);
                var_359 = wp::where(var_309, var_340, var_305);
                var_360 = wp::where(var_309, var_341, var_306);
                var_361 = wp::where(var_309, var_342, var_308);
                var_362 = wp::where(var_309, var_343, var_139);
                var_363 = wp::where(var_309, var_344, var_140);
                var_364 = wp::where(var_309, var_345, var_141);
                var_365 = wp::where(var_309, var_346, var_149);
                // if dist < max_query_radius:                                                    <L 1472>
                var_366 = (var_361 < var_max_query_radius);
                if (var_366) {
                    // min_dis_to_tris = wp.min(min_dis_to_tris, dist)                            <L 1474>
                    var_367 = wp::min(var_36, var_361);
                    // if vertex_num_collisions < vertex_buffer_size:                             <L 1475>
                    var_368 = (var_35 < var_10);
                    if (var_368) {
                        // vertex_colliding_triangles[2 * (vertex_buffer_offset + vertex_num_collisions)] = v_index       <L 1476>
                        var_370 = wp::add(var_5, var_35);
                        var_371 = wp::mul(var_369, var_370);
                        // wp::array_store(var_vertex_colliding_triangles, var_371, var_0);
                        // vertex_colliding_triangles[2 * (vertex_buffer_offset + vertex_num_collisions) + 1] = tri_index       <L 1477>
                        var_373 = wp::add(var_5, var_35);
                        var_374 = wp::mul(var_372, var_373);
                        var_376 = wp::add(var_374, var_375);
                        // wp::array_store(var_vertex_colliding_triangles, var_376, var_216);
                    }
                    if (!var_368) {
                        // resize_flags[VERTEX_COLLISION_BUFFER_OVERFLOW_INDEX] = 1               <L 1479>
                        // wp::array_store(var_resize_flags, var_163, var_377);
                    }
                    // vertex_num_collisions = vertex_num_collisions + 1                          <L 1481>
                    var_379 = wp::add(var_35, var_378);
                    // if triangle_colliding_vertices:                                            <L 1483>
                    if (var_triangle_colliding_vertices) {
                        // wp.atomic_min(triangle_colliding_vertices_min_dist, tri_index, dist)       <L 1484>
                        // var_380 = wp::atomic_min(var_triangle_colliding_vertices_min_dist, var_216, var_361);
                        // tri_buffer_size = triangle_colliding_vertices_buffer_sizes[tri_index]       <L 1485>
                        var_381 = wp::address(var_triangle_colliding_vertices_buffer_sizes, var_216);
                        var_383 = wp::load(var_381);
                        var_382 = wp::copy(var_383);
                        // tri_num_collisions = wp.atomic_add(triangle_colliding_vertices_count, tri_index, 1)       <L 1486>
                        // var_385 = wp::atomic_add(var_triangle_colliding_vertices_count, var_216, var_384);
                        // if tri_num_collisions < tri_buffer_size:                               <L 1488>
                        var_386 = (var_385 < var_382);
                        if (var_386) {
                            // tri_buffer_offset = triangle_colliding_vertices_offsets[tri_index]       <L 1489>
                            var_387 = wp::address(var_triangle_colliding_vertices_offsets, var_216);
                            var_389 = wp::load(var_387);
                            var_388 = wp::copy(var_389);
                            // triangle_colliding_vertices[tri_buffer_offset + tri_num_collisions] = v_index       <L 1491>
                            var_390 = wp::add(var_388, var_385);
                            // wp::array_store(var_triangle_colliding_vertices, var_390, var_0);
                        }
                        if (!var_386) {
                            // resize_flags[TRI_COLLISION_BUFFER_OVERFLOW_INDEX] = 1              <L 1493>
                            // wp::array_store(var_resize_flags, var_178, var_391);
                        }
                        var_392 = wp::where(var_386, var_388, var_174);
                    }
                    var_393 = wp::where(var_triangle_colliding_vertices, var_382, var_168);
                    var_394 = wp::where(var_triangle_colliding_vertices, var_385, var_171);
                    var_395 = wp::where(var_triangle_colliding_vertices, var_392, var_174);
                }
                var_396 = wp::where(var_366, var_379, var_35);
                var_397 = wp::where(var_366, var_367, var_36);
                var_398 = wp::where(var_366, var_393, var_168);
                var_399 = wp::where(var_366, var_394, var_171);
                var_400 = wp::where(var_366, var_395, var_174);
                wp::assign(var_35, var_396);
                wp::assign(var_36, var_397);
                wp::assign(var_79, var_347);
                wp::assign(var_83, var_348);
                wp::assign(var_87, var_349);
                wp::assign(var_91, var_350);
                wp::assign(var_96, var_351);
                wp::assign(var_100, var_352);
                wp::assign(var_105, var_353);
                wp::assign(var_110, var_354);
                wp::assign(var_119, var_355);
                wp::assign(var_122, var_356);
                wp::assign(var_125, var_357);
                wp::assign(var_127, var_358);
                wp::assign(var_128, var_359);
                wp::assign(var_129, var_360);
                wp::assign(var_131, var_361);
                wp::assign(var_139, var_362);
                wp::assign(var_140, var_363);
                wp::assign(var_141, var_364);
                wp::assign(var_149, var_365);
                wp::assign(var_168, var_398);
                wp::assign(var_171, var_399);
                wp::assign(var_174, var_400);
                wp::adj_assign(var_174, var_400, adj_174, adj_400);
                wp::adj_assign(var_171, var_399, adj_171, adj_399);
                wp::adj_assign(var_168, var_398, adj_168, adj_398);
                wp::adj_assign(var_149, var_365, adj_149, adj_365);
                wp::adj_assign(var_141, var_364, adj_141, adj_364);
                wp::adj_assign(var_140, var_363, adj_140, adj_363);
                wp::adj_assign(var_139, var_362, adj_139, adj_362);
                wp::adj_assign(var_131, var_361, adj_131, adj_361);
                wp::adj_assign(var_129, var_360, adj_129, adj_360);
                wp::adj_assign(var_128, var_359, adj_128, adj_359);
                wp::adj_assign(var_127, var_358, adj_127, adj_358);
                wp::adj_assign(var_125, var_357, adj_125, adj_357);
                wp::adj_assign(var_122, var_356, adj_122, adj_356);
                wp::adj_assign(var_119, var_355, adj_119, adj_355);
                wp::adj_assign(var_110, var_354, adj_110, adj_354);
                wp::adj_assign(var_105, var_353, adj_105, adj_353);
                wp::adj_assign(var_100, var_352, adj_100, adj_352);
                wp::adj_assign(var_96, var_351, adj_96, adj_351);
                wp::adj_assign(var_91, var_350, adj_91, adj_350);
                wp::adj_assign(var_87, var_349, adj_87, adj_349);
                wp::adj_assign(var_83, var_348, adj_83, adj_348);
                wp::adj_assign(var_79, var_347, adj_79, adj_347);
                wp::adj_assign(var_36, var_397, adj_36, adj_397);
                wp::adj_assign(var_35, var_396, adj_35, adj_396);
                wp::adj_where(var_366, var_395, var_174, adj_366, adj_395, adj_174, adj_400);
                wp::adj_where(var_366, var_394, var_171, adj_366, adj_394, adj_171, adj_399);
                wp::adj_where(var_366, var_393, var_168, adj_366, adj_393, adj_168, adj_398);
                wp::adj_where(var_366, var_367, var_36, adj_366, adj_367, adj_36, adj_397);
                wp::adj_where(var_366, var_379, var_35, adj_366, adj_379, adj_35, adj_396);
                if (var_366) {
                    wp::adj_where(var_triangle_colliding_vertices, var_392, var_174, adj_triangle_colliding_vertices, adj_392, adj_174, adj_395);
                    wp::adj_where(var_triangle_colliding_vertices, var_385, var_171, adj_triangle_colliding_vertices, adj_385, adj_171, adj_394);
                    wp::adj_where(var_triangle_colliding_vertices, var_382, var_168, adj_triangle_colliding_vertices, adj_382, adj_168, adj_393);
                    if (var_triangle_colliding_vertices) {
                        wp::adj_where(var_386, var_388, var_174, adj_386, adj_388, adj_174, adj_392);
                        if (!var_386) {
                            wp::adj_array_store(var_resize_flags, var_178, var_391, adj_resize_flags, adj_178, adj_391);
                            // adj: resize_flags[TRI_COLLISION_BUFFER_OVERFLOW_INDEX] = 1         <L 1493>
                        }
                        if (var_386) {
                            wp::adj_array_store(var_triangle_colliding_vertices, var_390, var_0, adj_triangle_colliding_vertices, adj_390, adj_0);
                            wp::adj_add(var_388, var_385, adj_388, adj_385, adj_390);
                            // adj: triangle_colliding_vertices[tri_buffer_offset + tri_num_collisions] = v_index  <L 1491>
                            wp::adj_copy(var_389, adj_387, adj_388);
                            wp::adj_address(var_triangle_colliding_vertices_offsets, var_216, adj_triangle_colliding_vertices_offsets, adj_216, adj_387);
                            // adj: tri_buffer_offset = triangle_colliding_vertices_offsets[tri_index]  <L 1489>
                        }
                        // adj: if tri_num_collisions < tri_buffer_size:                          <L 1488>
                        wp::adj_atomic_add(var_triangle_colliding_vertices_count, var_216, var_384, adj_triangle_colliding_vertices_count, adj_216, adj_384, adj_385);
                        // adj: tri_num_collisions = wp.atomic_add(triangle_colliding_vertices_count, tri_index, 1)  <L 1486>
                        wp::adj_copy(var_383, adj_381, adj_382);
                        wp::adj_address(var_triangle_colliding_vertices_buffer_sizes, var_216, adj_triangle_colliding_vertices_buffer_sizes, adj_216, adj_381);
                        // adj: tri_buffer_size = triangle_colliding_vertices_buffer_sizes[tri_index]  <L 1485>
                        wp::adj_atomic_min(var_triangle_colliding_vertices_min_dist, var_216, var_361, adj_triangle_colliding_vertices_min_dist, adj_216, adj_361, adj_380);
                        // adj: wp.atomic_min(triangle_colliding_vertices_min_dist, tri_index, dist)  <L 1484>
                    }
                    // adj: if triangle_colliding_vertices:                                       <L 1483>
                    wp::adj_add(var_35, var_378, adj_35, adj_378, adj_379);
                    // adj: vertex_num_collisions = vertex_num_collisions + 1                     <L 1481>
                    if (!var_368) {
                        wp::adj_array_store(var_resize_flags, var_163, var_377, adj_resize_flags, adj_163, adj_377);
                        // adj: resize_flags[VERTEX_COLLISION_BUFFER_OVERFLOW_INDEX] = 1          <L 1479>
                    }
                    if (var_368) {
                        wp::adj_array_store(var_vertex_colliding_triangles, var_376, var_216, adj_vertex_colliding_triangles, adj_376, adj_216);
                        wp::adj_add(var_374, var_375, adj_374, adj_375, adj_376);
                        wp::adj_mul(var_372, var_373, adj_372, adj_373, adj_374);
                        wp::adj_add(var_5, var_35, adj_5, adj_35, adj_373);
                        // adj: vertex_colliding_triangles[2 * (vertex_buffer_offset + vertex_num_collisions) + 1] = tri_index  <L 1477>
                        wp::adj_array_store(var_vertex_colliding_triangles, var_371, var_0, adj_vertex_colliding_triangles, adj_371, adj_0);
                        wp::adj_mul(var_369, var_370, adj_369, adj_370, adj_371);
                        wp::adj_add(var_5, var_35, adj_5, adj_35, adj_370);
                        // adj: vertex_colliding_triangles[2 * (vertex_buffer_offset + vertex_num_collisions)] = v_index  <L 1476>
                    }
                    // adj: if vertex_num_collisions < vertex_buffer_size:                        <L 1475>
                    wp::adj_min(var_36, var_361, adj_36, adj_361, adj_367);
                    // adj: min_dis_to_tris = wp.min(min_dis_to_tris, dist)                       <L 1474>
                }
                // adj: if dist < max_query_radius:                                               <L 1472>
                wp::adj_where(var_309, var_346, var_149, adj_309, adj_346, adj_149, adj_365);
                wp::adj_where(var_309, var_345, var_141, adj_309, adj_345, adj_141, adj_364);
                wp::adj_where(var_309, var_344, var_140, adj_309, adj_344, adj_140, adj_363);
                wp::adj_where(var_309, var_343, var_139, adj_309, adj_343, adj_139, adj_362);
                wp::adj_where(var_309, var_342, var_308, adj_309, adj_342, adj_308, adj_361);
                wp::adj_where(var_309, var_341, var_306, adj_309, adj_341, adj_306, adj_360);
                wp::adj_where(var_309, var_340, var_305, adj_309, adj_340, adj_305, adj_359);
                wp::adj_where(var_309, var_339, var_304, adj_309, adj_339, adj_304, adj_358);
                wp::adj_where(var_309, var_338, var_302, adj_309, adj_338, adj_302, adj_357);
                wp::adj_where(var_309, var_337, var_299, adj_309, adj_337, adj_299, adj_356);
                wp::adj_where(var_309, var_336, var_296, adj_309, adj_336, adj_296, adj_355);
                wp::adj_where(var_309, var_335, var_294, adj_309, adj_335, adj_294, adj_354);
                wp::adj_where(var_309, var_334, var_293, adj_309, adj_334, adj_293, adj_353);
                wp::adj_where(var_309, var_333, var_292, adj_309, adj_333, adj_292, adj_352);
                wp::adj_where(var_309, var_332, var_291, adj_309, adj_332, adj_291, adj_351);
                wp::adj_where(var_309, var_331, var_290, adj_309, adj_331, adj_290, adj_350);
                wp::adj_where(var_309, var_330, var_289, adj_309, adj_330, adj_289, adj_349);
                wp::adj_where(var_309, var_329, var_288, adj_309, adj_329, adj_288, adj_348);
                wp::adj_where(var_309, var_328, var_287, adj_309, adj_328, adj_287, adj_347);
                if (var_309) {
                    wp::adj_where(var_327, var_149, var_326, adj_327, adj_149, adj_326, adj_346);
                    wp::adj_where(var_327, var_141, var_318, adj_327, adj_141, adj_318, adj_345);
                    wp::adj_where(var_327, var_140, var_317, adj_327, adj_140, adj_317, adj_344);
                    wp::adj_where(var_327, var_139, var_316, adj_327, adj_139, adj_316, adj_343);
                    wp::adj_where(var_327, var_131, var_308, adj_327, adj_131, adj_308, adj_342);
                    wp::adj_where(var_327, var_129, var_306, adj_327, adj_129, adj_306, adj_341);
                    wp::adj_where(var_327, var_128, var_305, adj_327, adj_128, adj_305, adj_340);
                    wp::adj_where(var_327, var_127, var_304, adj_327, adj_127, adj_304, adj_339);
                    wp::adj_where(var_327, var_125, var_302, adj_327, adj_125, adj_302, adj_338);
                    wp::adj_where(var_327, var_122, var_299, adj_327, adj_122, adj_299, adj_337);
                    wp::adj_where(var_327, var_119, var_296, adj_327, adj_119, adj_296, adj_336);
                    wp::adj_where(var_327, var_110, var_294, adj_327, adj_110, adj_294, adj_335);
                    wp::adj_where(var_327, var_105, var_293, adj_327, adj_105, adj_293, adj_334);
                    wp::adj_where(var_327, var_100, var_292, adj_327, adj_100, adj_292, adj_333);
                    wp::adj_where(var_327, var_96, var_291, adj_327, adj_96, adj_291, adj_332);
                    wp::adj_where(var_327, var_91, var_290, adj_327, adj_91, adj_290, adj_331);
                    wp::adj_where(var_327, var_87, var_289, adj_327, adj_87, adj_289, adj_330);
                    wp::adj_where(var_327, var_83, var_288, adj_327, adj_83, adj_288, adj_329);
                    wp::adj_where(var_327, var_79, var_287, adj_327, adj_79, adj_287, adj_328);
                    if (var_327) {
                        wp::adj_assign(var_149, var_326, adj_149, adj_326);
                        wp::adj_assign(var_141, var_318, adj_141, adj_318);
                        wp::adj_assign(var_140, var_317, adj_140, adj_317);
                        wp::adj_assign(var_139, var_316, adj_139, adj_316);
                        wp::adj_assign(var_131, var_308, adj_131, adj_308);
                        wp::adj_assign(var_129, var_306, adj_129, adj_306);
                        wp::adj_assign(var_128, var_305, adj_128, adj_305);
                        wp::adj_assign(var_127, var_304, adj_127, adj_304);
                        wp::adj_assign(var_125, var_302, adj_125, adj_302);
                        wp::adj_assign(var_122, var_299, adj_122, adj_299);
                        wp::adj_assign(var_119, var_296, adj_119, adj_296);
                        wp::adj_assign(var_110, var_294, adj_110, adj_294);
                        wp::adj_assign(var_105, var_293, adj_105, adj_293);
                        wp::adj_assign(var_100, var_292, adj_100, adj_292);
                        wp::adj_assign(var_96, var_291, adj_96, adj_291);
                        wp::adj_assign(var_91, var_290, adj_91, adj_290);
                        wp::adj_assign(var_87, var_289, adj_87, adj_289);
                        wp::adj_assign(var_83, var_288, adj_83, adj_288);
                        wp::adj_assign(var_79, var_287, adj_79, adj_287);
                        // adj: continue                                                          <L 1470>
                    }
                    // adj: if dist_ref < min_query_radius:                                       <L 1469>
                    wp::adj_length(var_324, var_326, adj_324, adj_326);
                    wp::adj_sub(var_316, var_325, adj_316, adj_323, adj_324);
                    wp::adj_address(var_min_distance_filtering_ref_pos, var_0, adj_min_distance_filtering_ref_pos, adj_0, adj_323);
                    // adj: dist_ref = wp.length(closest_p_ref - min_distance_filtering_ref_pos[v_index])  <L 1467>
                    adj_triangle_closest_point_0(var_319, var_320, var_321, var_322, var_316, var_317, var_318, adj_312, adj_313, adj_314, adj_315, adj_316, adj_317, adj_318);
                    wp::adj_address(var_min_distance_filtering_ref_pos, var_0, adj_min_distance_filtering_ref_pos, adj_0, adj_315);
                    // adj: min_distance_filtering_ref_pos[v_index],                              <L 1465>
                    wp::adj_address(var_min_distance_filtering_ref_pos, var_289, adj_min_distance_filtering_ref_pos, adj_289, adj_314);
                    // adj: min_distance_filtering_ref_pos[t3],                                   <L 1464>
                    wp::adj_address(var_min_distance_filtering_ref_pos, var_288, adj_min_distance_filtering_ref_pos, adj_288, adj_313);
                    // adj: min_distance_filtering_ref_pos[t2],                                   <L 1463>
                    wp::adj_address(var_min_distance_filtering_ref_pos, var_287, adj_min_distance_filtering_ref_pos, adj_287, adj_312);
                    // adj: min_distance_filtering_ref_pos[t1],                                   <L 1462>
                    // adj: closest_p_ref, _, __ = triangle_closest_point(                        <L 1461>
                }
                if (var_309) {
                }
                // adj: if min_distance_filtering_ref_pos and min_query_radius > 0.0:             <L 1460>
                wp::adj_length(var_307, var_308, adj_307, adj_308);
                wp::adj_sub(var_304, var_2, adj_304, adj_2, adj_307);
                // adj: dist = wp.length(closest_p - v)                                           <L 1458>
                adj_triangle_closest_point_0(var_296, var_299, var_302, var_2, var_304, var_305, var_306, adj_296, adj_299, adj_302, adj_2, adj_304, adj_305, adj_306);
                // adj: closest_p, _bary, _feature_type = triangle_closest_point(u1, u2, u3, v)   <L 1456>
                wp::adj_copy(var_303, adj_301, adj_302);
                wp::adj_address(var_pos, var_289, adj_pos, adj_289, adj_301);
                // adj: u3 = pos[t3]                                                              <L 1454>
                wp::adj_copy(var_300, adj_298, adj_299);
                wp::adj_address(var_pos, var_288, adj_pos, adj_288, adj_298);
                // adj: u2 = pos[t2]                                                              <L 1453>
                wp::adj_copy(var_297, adj_295, adj_296);
                wp::adj_address(var_pos, var_287, adj_pos, adj_287, adj_295);
                // adj: u1 = pos[t1]                                                              <L 1452>
                wp::adj_where(var_vertex_triangle_filtering_list, var_286, var_110, adj_vertex_triangle_filtering_list, adj_286, adj_110, adj_294);
                wp::adj_where(var_vertex_triangle_filtering_list, var_285, var_105, adj_vertex_triangle_filtering_list, adj_285, adj_105, adj_293);
                wp::adj_where(var_vertex_triangle_filtering_list, var_284, var_100, adj_vertex_triangle_filtering_list, adj_284, adj_100, adj_292);
                wp::adj_where(var_vertex_triangle_filtering_list, var_283, var_96, adj_vertex_triangle_filtering_list, adj_283, adj_96, adj_291);
                wp::adj_where(var_vertex_triangle_filtering_list, var_282, var_91, adj_vertex_triangle_filtering_list, adj_282, adj_91, adj_290);
                wp::adj_where(var_vertex_triangle_filtering_list, var_281, var_234, adj_vertex_triangle_filtering_list, adj_281, adj_234, adj_289);
                wp::adj_where(var_vertex_triangle_filtering_list, var_280, var_233, adj_vertex_triangle_filtering_list, adj_280, adj_233, adj_288);
                wp::adj_where(var_vertex_triangle_filtering_list, var_279, var_232, adj_vertex_triangle_filtering_list, adj_279, adj_232, adj_287);
                if (var_vertex_triangle_filtering_list) {
                    wp::adj_where(var_243, var_278, var_110, adj_243, adj_278, adj_110, adj_286);
                    wp::adj_where(var_243, var_277, var_105, adj_243, adj_277, adj_105, adj_285);
                    wp::adj_where(var_243, var_276, var_100, adj_243, adj_276, adj_100, adj_284);
                    wp::adj_where(var_243, var_275, var_241, adj_243, adj_275, adj_241, adj_283);
                    wp::adj_where(var_243, var_274, var_236, adj_243, adj_274, adj_236, adj_282);
                    wp::adj_where(var_243, var_273, var_234, adj_243, adj_273, adj_234, adj_281);
                    wp::adj_where(var_243, var_272, var_233, adj_243, adj_272, adj_233, adj_280);
                    wp::adj_where(var_243, var_271, var_232, adj_243, adj_271, adj_232, adj_279);
                    if (var_243) {
                        wp::adj_where(var_252, var_270, var_110, adj_252, adj_270, adj_110, adj_278);
                        wp::adj_where(var_252, var_269, var_250, adj_252, adj_269, adj_250, adj_277);
                        wp::adj_where(var_252, var_268, var_245, adj_252, adj_268, adj_245, adj_276);
                        wp::adj_where(var_252, var_267, var_241, adj_252, adj_267, adj_241, adj_275);
                        wp::adj_where(var_252, var_266, var_236, adj_252, adj_266, adj_236, adj_274);
                        wp::adj_where(var_252, var_265, var_234, adj_252, adj_265, adj_234, adj_273);
                        wp::adj_where(var_252, var_264, var_233, adj_252, adj_264, adj_233, adj_272);
                        wp::adj_where(var_252, var_263, var_232, adj_252, adj_263, adj_232, adj_271);
                        if (var_252) {
                            wp::adj_where(var_256, var_110, var_255, adj_256, adj_110, adj_255, adj_270);
                            wp::adj_where(var_256, var_105, var_250, adj_256, adj_105, adj_250, adj_269);
                            wp::adj_where(var_256, var_100, var_245, adj_256, adj_100, adj_245, adj_268);
                            wp::adj_where(var_256, var_96, var_241, adj_256, adj_96, adj_241, adj_267);
                            wp::adj_where(var_256, var_91, var_236, adj_256, adj_91, adj_236, adj_266);
                            wp::adj_where(var_256, var_87, var_234, adj_256, adj_87, adj_234, adj_265);
                            wp::adj_where(var_256, var_83, var_233, adj_256, adj_83, adj_233, adj_264);
                            wp::adj_where(var_256, var_79, var_232, adj_256, adj_79, adj_232, adj_263);
                            if (var_256) {
                                wp::adj_assign(var_110, var_255, adj_110, adj_255);
                                wp::adj_assign(var_105, var_250, adj_105, adj_250);
                                wp::adj_assign(var_100, var_245, adj_100, adj_245);
                                wp::adj_assign(var_96, var_241, adj_96, adj_241);
                                wp::adj_assign(var_91, var_236, adj_91, adj_236);
                                wp::adj_assign(var_87, var_234, adj_87, adj_234);
                                wp::adj_assign(var_83, var_233, adj_83, adj_233);
                                wp::adj_assign(var_79, var_232, adj_79, adj_232);
                                // adj: continue                                                  <L 1450>
                            }
                            if (var_256) {
                                wp::adj_address(var_vertex_triangle_filtering_list, var_259, adj_vertex_triangle_filtering_list, adj_259, adj_260);
                                wp::adj_sub(var_255, var_258, adj_255, adj_258, adj_259);
                            }
                            // adj: if idx > fl_start and vertex_triangle_filtering_list[idx - 1] == tri_index:  <L 1449>
                            adj_binary_search_0(var_vertex_triangle_filtering_list, var_216, var_236, var_241, adj_vertex_triangle_filtering_list, adj_216, adj_236, adj_241, adj_255);
                            // adj: idx = binary_search(vertex_triangle_filtering_list, tri_index, fl_start, fl_end)  <L 1447>
                        }
                        if (var_252) {
                        }
                        // adj: if (tri_index >= first_val) and (tri_index <= last_val):          <L 1446>
                        wp::adj_copy(var_251, adj_249, adj_250);
                        wp::adj_address(var_vertex_triangle_filtering_list, var_248, adj_vertex_triangle_filtering_list, adj_248, adj_249);
                        wp::adj_sub(var_241, var_247, adj_241, adj_247, adj_248);
                        // adj: last_val = vertex_triangle_filtering_list[fl_end - 1]             <L 1445>
                        wp::adj_copy(var_246, adj_244, adj_245);
                        wp::adj_address(var_vertex_triangle_filtering_list, var_236, adj_vertex_triangle_filtering_list, adj_236, adj_244);
                        // adj: first_val = vertex_triangle_filtering_list[fl_start]              <L 1444>
                    }
                    // adj: if fl_end > fl_start:                                                 <L 1442>
                    wp::adj_copy(var_242, adj_240, adj_241);
                    wp::adj_address(var_vertex_triangle_filtering_list_offsets, var_239, adj_vertex_triangle_filtering_list_offsets, adj_239, adj_240);
                    wp::adj_add(var_0, var_238, adj_0, adj_238, adj_239);
                    // adj: v_index + 1                                                           <L 1439>
                    // adj: fl_end = vertex_triangle_filtering_list_offsets[                      <L 1438>
                    wp::adj_copy(var_237, adj_235, adj_236);
                    wp::adj_address(var_vertex_triangle_filtering_list_offsets, var_0, adj_vertex_triangle_filtering_list_offsets, adj_0, adj_235);
                    // adj: fl_start = vertex_triangle_filtering_list_offsets[v_index]            <L 1437>
                }
                // adj: if vertex_triangle_filtering_list:                                        <L 1436>
                wp::adj_where(var_231, var_87, var_229, adj_231, adj_87, adj_229, adj_234);
                wp::adj_where(var_231, var_83, var_225, adj_231, adj_83, adj_225, adj_233);
                wp::adj_where(var_231, var_79, var_221, adj_231, adj_79, adj_221, adj_232);
                if (var_231) {
                    wp::adj_assign(var_87, var_229, adj_87, adj_229);
                    wp::adj_assign(var_83, var_225, adj_83, adj_225);
                    wp::adj_assign(var_79, var_221, adj_79, adj_221);
                    // adj: continue                                                              <L 1434>
                }
                adj_vertex_adjacent_to_triangle_0(var_0, var_221, var_225, var_229, adj_0, adj_221, adj_225, adj_229, adj_231);
                // adj: if vertex_adjacent_to_triangle(v_index, t1, t2, t3):                      <L 1433>
                wp::adj_copy(var_230, adj_228, adj_229);
                wp::adj_address(var_tri_indices, var_216, var_227, adj_tri_indices, adj_216, adj_227, adj_228);
                // adj: t3 = tri_indices[tri_index, 2]                                            <L 1431>
                wp::adj_copy(var_226, adj_224, adj_225);
                wp::adj_address(var_tri_indices, var_216, var_223, adj_tri_indices, adj_216, adj_223, adj_224);
                // adj: t2 = tri_indices[tri_index, 1]                                            <L 1430>
                wp::adj_copy(var_222, adj_220, adj_221);
                wp::adj_address(var_tri_indices, var_216, var_219, adj_tri_indices, adj_216, adj_219, adj_220);
                // adj: t1 = tri_indices[tri_index, 0]                                            <L 1429>
        goto start_while_2;
        end_while_2:;
            // adj: while wp.bvh_query_next(query, tri_index):                                    <L 1428>
            // adj: tri_index = wp.int32(0)                                                       <L 1427>
            wp::adj_where(var_209, var_211, var_213, adj_209, adj_211, adj_213, adj_214);
            if (!var_209) {
                // adj: query = wp.bvh_query_aabb(bvh_id, lower, upper, group_root)               <L 1425>
            }
            if (var_209) {
                // adj: query = wp.bvh_query_aabb(bvh_id, lower, upper)                           <L 1423>
            }
            // adj: if query_all:                                                                 <L 1422>
        }
        // adj: if run_query:                                                                     <L 1421>
        wp::adj_where(var_190, var_188, var_205, adj_190, adj_188, adj_205, adj_210);
        wp::adj_where(var_190, var_196, var_186, adj_190, adj_196, adj_186, adj_209);
        wp::adj_where(var_190, var_195, var_207, adj_190, adj_195, adj_207, adj_208);
        if (!var_190) {
            // adj: run_query = group_root >= 0                                                   <L 1419>
            wp::adj_where(var_198, var_200, var_203, adj_198, adj_200, adj_203, adj_205);
            if (!var_198) {
                wp::adj_copy(var_204, adj_202, adj_203);
                wp::adj_address(var_bvh_group_roots, var_world_count, adj_bvh_group_roots, adj_world_count, adj_202);
                // adj: group_root = bvh_group_roots[world_count]                                 <L 1418>
            }
            if (var_198) {
                wp::adj_copy(var_201, adj_199, adj_200);
                wp::adj_address(var_bvh_group_roots, var_38, adj_bvh_group_roots, adj_38, adj_199);
                // adj: group_root = bvh_group_roots[vertex_world]                                <L 1416>
            }
            // adj: if query_pass == 0:                                                           <L 1415>
        }
        if (var_190) {
            wp::adj_where(var_192, var_194, var_186, adj_192, adj_194, adj_186, adj_196);
            wp::adj_where(var_192, var_193, var_184, adj_192, adj_193, adj_184, adj_195);
            if (var_192) {
                // adj: query_all = True                                                          <L 1413>
                // adj: run_query = True                                                          <L 1412>
            }
            // adj: if query_pass == 0:                                                           <L 1411>
        }
        // adj: if vertex_world < 0:                                                              <L 1410>
        // adj: group_root = wp.int32(-1)                                                         <L 1408>
        // adj: query_all = bool(False)                                                           <L 1407>
        // adj: run_query = bool(False)                                                           <L 1406>
        wp::adj_where(var_66, var_74, var_33, adj_66, adj_74, adj_33, adj_181);
        if (var_66) {
        start_while_0:;
            var_75 = wp::bvh_query_next(var_72, var_74, var_76);
        if ((var_75) == false) goto end_while_0;
        adj_77 = {};
        adj_78 = {};
        adj_79 = {};
        adj_80 = {};
        adj_81 = {};
        adj_82 = {};
        adj_83 = {};
        adj_84 = {};
        adj_85 = {};
        adj_86 = {};
        adj_87 = {};
        adj_88 = {};
        adj_89 = {};
        adj_90 = {};
        adj_91 = {};
        adj_92 = {};
        adj_93 = {};
        adj_94 = {};
        adj_95 = {};
        adj_96 = {};
        adj_97 = {};
        adj_98 = {};
        adj_99 = {};
        adj_100 = {};
        adj_101 = {};
        adj_102 = {};
        adj_103 = {};
        adj_104 = {};
        adj_105 = {};
        adj_106 = {};
        adj_107 = {};
        adj_108 = {};
        adj_109 = {};
        adj_110 = {};
        adj_111 = {};
        adj_112 = {};
        adj_113 = {};
        adj_114 = {};
        adj_115 = {};
        adj_116 = {};
        adj_117 = {};
        adj_118 = {};
        adj_119 = {};
        adj_120 = {};
        adj_121 = {};
        adj_122 = {};
        adj_123 = {};
        adj_124 = {};
        adj_125 = {};
        adj_126 = {};
        adj_127 = {};
        adj_128 = {};
        adj_129 = {};
        adj_130 = {};
        adj_131 = {};
        adj_132 = {};
        adj_133 = {};
        adj_134 = {};
        adj_135 = {};
        adj_136 = {};
        adj_137 = {};
        adj_138 = {};
        adj_139 = {};
        adj_140 = {};
        adj_141 = {};
        adj_142 = {};
        adj_143 = {};
        adj_144 = {};
        adj_145 = {};
        adj_146 = {};
        adj_147 = {};
        adj_148 = {};
        adj_149 = {};
        adj_150 = {};
        adj_151 = {};
        adj_152 = {};
        adj_153 = {};
        adj_154 = {};
        adj_155 = {};
        adj_156 = {};
        adj_157 = {};
        adj_158 = {};
        adj_159 = {};
        adj_160 = {};
        adj_161 = {};
        adj_162 = {};
        adj_163 = {};
        adj_164 = {};
        adj_165 = {};
        adj_166 = {};
        adj_167 = {};
        adj_168 = {};
        adj_169 = {};
        adj_170 = {};
        adj_171 = {};
        adj_172 = {};
        adj_173 = {};
        adj_174 = {};
        adj_175 = {};
        adj_176 = {};
        adj_177 = {};
        adj_178 = {};
        adj_179 = {};
        adj_180 = {};
                // t1 = tri_indices[tri_index, 0]                                                 <L 1429>
                var_78 = wp::address(var_tri_indices, var_74, var_77);
                var_80 = wp::load(var_78);
                var_79 = wp::copy(var_80);
                // t2 = tri_indices[tri_index, 1]                                                 <L 1430>
                var_82 = wp::address(var_tri_indices, var_74, var_81);
                var_84 = wp::load(var_82);
                var_83 = wp::copy(var_84);
                // t3 = tri_indices[tri_index, 2]                                                 <L 1431>
                var_86 = wp::address(var_tri_indices, var_74, var_85);
                var_88 = wp::load(var_86);
                var_87 = wp::copy(var_88);
                // if vertex_adjacent_to_triangle(v_index, t1, t2, t3):                           <L 1433>
                var_89 = vertex_adjacent_to_triangle_0(var_0, var_79, var_83, var_87);
                if (var_89) {
                    // continue                                                                   <L 1434>
                    goto start_while_0;
                }
                // if vertex_triangle_filtering_list:                                             <L 1436>
                if (var_vertex_triangle_filtering_list) {
                    // fl_start = vertex_triangle_filtering_list_offsets[v_index]                 <L 1437>
                    var_90 = wp::address(var_vertex_triangle_filtering_list_offsets, var_0);
                    var_92 = wp::load(var_90);
                    var_91 = wp::copy(var_92);
                    // fl_end = vertex_triangle_filtering_list_offsets[                           <L 1438>
                    // v_index + 1                                                                <L 1439>
                    var_94 = wp::add(var_0, var_93);
                    var_95 = wp::address(var_vertex_triangle_filtering_list_offsets, var_94);
                    var_97 = wp::load(var_95);
                    var_96 = wp::copy(var_97);
                    // if fl_end > fl_start:                                                      <L 1442>
                    var_98 = (var_96 > var_91);
                    if (var_98) {
                        // first_val = vertex_triangle_filtering_list[fl_start]                   <L 1444>
                        var_99 = wp::address(var_vertex_triangle_filtering_list, var_91);
                        var_101 = wp::load(var_99);
                        var_100 = wp::copy(var_101);
                        // last_val = vertex_triangle_filtering_list[fl_end - 1]                  <L 1445>
                        var_103 = wp::sub(var_96, var_102);
                        var_104 = wp::address(var_vertex_triangle_filtering_list, var_103);
                        var_106 = wp::load(var_104);
                        var_105 = wp::copy(var_106);
                        // if (tri_index >= first_val) and (tri_index <= last_val):               <L 1446>
                        var_108 = (var_74 >= var_100);
                        var_107 = var_108;
                        if (var_107) {
                            var_109 = (var_74 <= var_105);
                            var_107 = var_107 && var_109;
                        }
                        if (var_107) {
                            // idx = binary_search(vertex_triangle_filtering_list, tri_index, fl_start, fl_end)       <L 1447>
                            var_110 = binary_search_0(var_vertex_triangle_filtering_list, var_74, var_91, var_96);
                            // if idx > fl_start and vertex_triangle_filtering_list[idx - 1] == tri_index:       <L 1449>
                            var_112 = (var_110 > var_91);
                            var_111 = var_112;
                            if (var_111) {
                                var_114 = wp::sub(var_110, var_113);
                                var_115 = wp::address(var_vertex_triangle_filtering_list, var_114);
                                var_117 = wp::load(var_115);
                                var_116 = (var_117 == var_74);
                                var_111 = var_111 && var_116;
                            }
                            if (var_111) {
                                // continue                                                       <L 1450>
                                goto start_while_0;
                            }
                        }
                    }
                }
                // u1 = pos[t1]                                                                   <L 1452>
                var_118 = wp::address(var_pos, var_79);
                var_120 = wp::load(var_118);
                var_119 = wp::copy(var_120);
                // u2 = pos[t2]                                                                   <L 1453>
                var_121 = wp::address(var_pos, var_83);
                var_123 = wp::load(var_121);
                var_122 = wp::copy(var_123);
                // u3 = pos[t3]                                                                   <L 1454>
                var_124 = wp::address(var_pos, var_87);
                var_126 = wp::load(var_124);
                var_125 = wp::copy(var_126);
                // closest_p, _bary, _feature_type = triangle_closest_point(u1, u2, u3, v)        <L 1456>
                triangle_closest_point_0(var_119, var_122, var_125, var_2, var_127, var_128, var_129);
                // dist = wp.length(closest_p - v)                                                <L 1458>
                var_130 = wp::sub(var_127, var_2);
                var_131 = wp::length(var_130);
                // if min_distance_filtering_ref_pos and min_query_radius > 0.0:                  <L 1460>
                var_132 = var_min_distance_filtering_ref_pos;
                if (var_132) {
                    var_134 = (var_min_query_radius > var_133);
                    var_132 = var_132 && var_134;
                }
                if (var_132) {
                    // closest_p_ref, _, __ = triangle_closest_point(                             <L 1461>
                    // min_distance_filtering_ref_pos[t1],                                        <L 1462>
                    var_135 = wp::address(var_min_distance_filtering_ref_pos, var_79);
                    // min_distance_filtering_ref_pos[t2],                                        <L 1463>
                    var_136 = wp::address(var_min_distance_filtering_ref_pos, var_83);
                    // min_distance_filtering_ref_pos[t3],                                        <L 1464>
                    var_137 = wp::address(var_min_distance_filtering_ref_pos, var_87);
                    // min_distance_filtering_ref_pos[v_index],                                   <L 1465>
                    var_138 = wp::address(var_min_distance_filtering_ref_pos, var_0);
                    var_142 = wp::load(var_135);
                    var_143 = wp::load(var_136);
                    var_144 = wp::load(var_137);
                    var_145 = wp::load(var_138);
                    triangle_closest_point_0(var_142, var_143, var_144, var_145, var_139, var_140, var_141);
                    // dist_ref = wp.length(closest_p_ref - min_distance_filtering_ref_pos[v_index])       <L 1467>
                    var_146 = wp::address(var_min_distance_filtering_ref_pos, var_0);
                    var_148 = wp::load(var_146);
                    var_147 = wp::sub(var_139, var_148);
                    var_149 = wp::length(var_147);
                    // if dist_ref < min_query_radius:                                            <L 1469>
                    var_150 = (var_149 < var_min_query_radius);
                    if (var_150) {
                        // continue                                                               <L 1470>
                        goto start_while_0;
                    }
                }
                // if dist < max_query_radius:                                                    <L 1472>
                var_151 = (var_131 < var_max_query_radius);
                if (var_151) {
                    // min_dis_to_tris = wp.min(min_dis_to_tris, dist)                            <L 1474>
                    var_152 = wp::min(var_36, var_131);
                    // if vertex_num_collisions < vertex_buffer_size:                             <L 1475>
                    var_153 = (var_35 < var_10);
                    if (var_153) {
                        // vertex_colliding_triangles[2 * (vertex_buffer_offset + vertex_num_collisions)] = v_index       <L 1476>
                        var_155 = wp::add(var_5, var_35);
                        var_156 = wp::mul(var_154, var_155);
                        // wp::array_store(var_vertex_colliding_triangles, var_156, var_0);
                        // vertex_colliding_triangles[2 * (vertex_buffer_offset + vertex_num_collisions) + 1] = tri_index       <L 1477>
                        var_158 = wp::add(var_5, var_35);
                        var_159 = wp::mul(var_157, var_158);
                        var_161 = wp::add(var_159, var_160);
                        // wp::array_store(var_vertex_colliding_triangles, var_161, var_74);
                    }
                    if (!var_153) {
                        // resize_flags[VERTEX_COLLISION_BUFFER_OVERFLOW_INDEX] = 1               <L 1479>
                        // wp::array_store(var_resize_flags, var_163, var_162);
                    }
                    // vertex_num_collisions = vertex_num_collisions + 1                          <L 1481>
                    var_165 = wp::add(var_35, var_164);
                    // if triangle_colliding_vertices:                                            <L 1483>
                    if (var_triangle_colliding_vertices) {
                        // wp.atomic_min(triangle_colliding_vertices_min_dist, tri_index, dist)       <L 1484>
                        // var_166 = wp::atomic_min(var_triangle_colliding_vertices_min_dist, var_74, var_131);
                        // tri_buffer_size = triangle_colliding_vertices_buffer_sizes[tri_index]       <L 1485>
                        var_167 = wp::address(var_triangle_colliding_vertices_buffer_sizes, var_74);
                        var_169 = wp::load(var_167);
                        var_168 = wp::copy(var_169);
                        // tri_num_collisions = wp.atomic_add(triangle_colliding_vertices_count, tri_index, 1)       <L 1486>
                        // var_171 = wp::atomic_add(var_triangle_colliding_vertices_count, var_74, var_170);
                        // if tri_num_collisions < tri_buffer_size:                               <L 1488>
                        var_172 = (var_171 < var_168);
                        if (var_172) {
                            // tri_buffer_offset = triangle_colliding_vertices_offsets[tri_index]       <L 1489>
                            var_173 = wp::address(var_triangle_colliding_vertices_offsets, var_74);
                            var_175 = wp::load(var_173);
                            var_174 = wp::copy(var_175);
                            // triangle_colliding_vertices[tri_buffer_offset + tri_num_collisions] = v_index       <L 1491>
                            var_176 = wp::add(var_174, var_171);
                            // wp::array_store(var_triangle_colliding_vertices, var_176, var_0);
                        }
                        if (!var_172) {
                            // resize_flags[TRI_COLLISION_BUFFER_OVERFLOW_INDEX] = 1              <L 1493>
                            // wp::array_store(var_resize_flags, var_178, var_177);
                        }
                    }
                }
                var_179 = wp::where(var_151, var_165, var_35);
                var_180 = wp::where(var_151, var_152, var_36);
                wp::assign(var_35, var_179);
                wp::assign(var_36, var_180);
                wp::adj_assign(var_36, var_180, adj_36, adj_180);
                wp::adj_assign(var_35, var_179, adj_35, adj_179);
                wp::adj_where(var_151, var_152, var_36, adj_151, adj_152, adj_36, adj_180);
                wp::adj_where(var_151, var_165, var_35, adj_151, adj_165, adj_35, adj_179);
                if (var_151) {
                    if (var_triangle_colliding_vertices) {
                        if (!var_172) {
                            wp::adj_array_store(var_resize_flags, var_178, var_177, adj_resize_flags, adj_178, adj_177);
                            // adj: resize_flags[TRI_COLLISION_BUFFER_OVERFLOW_INDEX] = 1         <L 1493>
                        }
                        if (var_172) {
                            wp::adj_array_store(var_triangle_colliding_vertices, var_176, var_0, adj_triangle_colliding_vertices, adj_176, adj_0);
                            wp::adj_add(var_174, var_171, adj_174, adj_171, adj_176);
                            // adj: triangle_colliding_vertices[tri_buffer_offset + tri_num_collisions] = v_index  <L 1491>
                            wp::adj_copy(var_175, adj_173, adj_174);
                            wp::adj_address(var_triangle_colliding_vertices_offsets, var_74, adj_triangle_colliding_vertices_offsets, adj_74, adj_173);
                            // adj: tri_buffer_offset = triangle_colliding_vertices_offsets[tri_index]  <L 1489>
                        }
                        // adj: if tri_num_collisions < tri_buffer_size:                          <L 1488>
                        wp::adj_atomic_add(var_triangle_colliding_vertices_count, var_74, var_170, adj_triangle_colliding_vertices_count, adj_74, adj_170, adj_171);
                        // adj: tri_num_collisions = wp.atomic_add(triangle_colliding_vertices_count, tri_index, 1)  <L 1486>
                        wp::adj_copy(var_169, adj_167, adj_168);
                        wp::adj_address(var_triangle_colliding_vertices_buffer_sizes, var_74, adj_triangle_colliding_vertices_buffer_sizes, adj_74, adj_167);
                        // adj: tri_buffer_size = triangle_colliding_vertices_buffer_sizes[tri_index]  <L 1485>
                        wp::adj_atomic_min(var_triangle_colliding_vertices_min_dist, var_74, var_131, adj_triangle_colliding_vertices_min_dist, adj_74, adj_131, adj_166);
                        // adj: wp.atomic_min(triangle_colliding_vertices_min_dist, tri_index, dist)  <L 1484>
                    }
                    // adj: if triangle_colliding_vertices:                                       <L 1483>
                    wp::adj_add(var_35, var_164, adj_35, adj_164, adj_165);
                    // adj: vertex_num_collisions = vertex_num_collisions + 1                     <L 1481>
                    if (!var_153) {
                        wp::adj_array_store(var_resize_flags, var_163, var_162, adj_resize_flags, adj_163, adj_162);
                        // adj: resize_flags[VERTEX_COLLISION_BUFFER_OVERFLOW_INDEX] = 1          <L 1479>
                    }
                    if (var_153) {
                        wp::adj_array_store(var_vertex_colliding_triangles, var_161, var_74, adj_vertex_colliding_triangles, adj_161, adj_74);
                        wp::adj_add(var_159, var_160, adj_159, adj_160, adj_161);
                        wp::adj_mul(var_157, var_158, adj_157, adj_158, adj_159);
                        wp::adj_add(var_5, var_35, adj_5, adj_35, adj_158);
                        // adj: vertex_colliding_triangles[2 * (vertex_buffer_offset + vertex_num_collisions) + 1] = tri_index  <L 1477>
                        wp::adj_array_store(var_vertex_colliding_triangles, var_156, var_0, adj_vertex_colliding_triangles, adj_156, adj_0);
                        wp::adj_mul(var_154, var_155, adj_154, adj_155, adj_156);
                        wp::adj_add(var_5, var_35, adj_5, adj_35, adj_155);
                        // adj: vertex_colliding_triangles[2 * (vertex_buffer_offset + vertex_num_collisions)] = v_index  <L 1476>
                    }
                    // adj: if vertex_num_collisions < vertex_buffer_size:                        <L 1475>
                    wp::adj_min(var_36, var_131, adj_36, adj_131, adj_152);
                    // adj: min_dis_to_tris = wp.min(min_dis_to_tris, dist)                       <L 1474>
                }
                // adj: if dist < max_query_radius:                                               <L 1472>
                if (var_132) {
                    if (var_150) {
                        // adj: continue                                                          <L 1470>
                    }
                    // adj: if dist_ref < min_query_radius:                                       <L 1469>
                    wp::adj_length(var_147, var_149, adj_147, adj_149);
                    wp::adj_sub(var_139, var_148, adj_139, adj_146, adj_147);
                    wp::adj_address(var_min_distance_filtering_ref_pos, var_0, adj_min_distance_filtering_ref_pos, adj_0, adj_146);
                    // adj: dist_ref = wp.length(closest_p_ref - min_distance_filtering_ref_pos[v_index])  <L 1467>
                    adj_triangle_closest_point_0(var_142, var_143, var_144, var_145, var_139, var_140, var_141, adj_135, adj_136, adj_137, adj_138, adj_139, adj_140, adj_141);
                    wp::adj_address(var_min_distance_filtering_ref_pos, var_0, adj_min_distance_filtering_ref_pos, adj_0, adj_138);
                    // adj: min_distance_filtering_ref_pos[v_index],                              <L 1465>
                    wp::adj_address(var_min_distance_filtering_ref_pos, var_87, adj_min_distance_filtering_ref_pos, adj_87, adj_137);
                    // adj: min_distance_filtering_ref_pos[t3],                                   <L 1464>
                    wp::adj_address(var_min_distance_filtering_ref_pos, var_83, adj_min_distance_filtering_ref_pos, adj_83, adj_136);
                    // adj: min_distance_filtering_ref_pos[t2],                                   <L 1463>
                    wp::adj_address(var_min_distance_filtering_ref_pos, var_79, adj_min_distance_filtering_ref_pos, adj_79, adj_135);
                    // adj: min_distance_filtering_ref_pos[t1],                                   <L 1462>
                    // adj: closest_p_ref, _, __ = triangle_closest_point(                        <L 1461>
                }
                if (var_132) {
                }
                // adj: if min_distance_filtering_ref_pos and min_query_radius > 0.0:             <L 1460>
                wp::adj_length(var_130, var_131, adj_130, adj_131);
                wp::adj_sub(var_127, var_2, adj_127, adj_2, adj_130);
                // adj: dist = wp.length(closest_p - v)                                           <L 1458>
                adj_triangle_closest_point_0(var_119, var_122, var_125, var_2, var_127, var_128, var_129, adj_119, adj_122, adj_125, adj_2, adj_127, adj_128, adj_129);
                // adj: closest_p, _bary, _feature_type = triangle_closest_point(u1, u2, u3, v)   <L 1456>
                wp::adj_copy(var_126, adj_124, adj_125);
                wp::adj_address(var_pos, var_87, adj_pos, adj_87, adj_124);
                // adj: u3 = pos[t3]                                                              <L 1454>
                wp::adj_copy(var_123, adj_121, adj_122);
                wp::adj_address(var_pos, var_83, adj_pos, adj_83, adj_121);
                // adj: u2 = pos[t2]                                                              <L 1453>
                wp::adj_copy(var_120, adj_118, adj_119);
                wp::adj_address(var_pos, var_79, adj_pos, adj_79, adj_118);
                // adj: u1 = pos[t1]                                                              <L 1452>
                if (var_vertex_triangle_filtering_list) {
                    if (var_98) {
                        if (var_107) {
                            if (var_111) {
                                // adj: continue                                                  <L 1450>
                            }
                            if (var_111) {
                                wp::adj_address(var_vertex_triangle_filtering_list, var_114, adj_vertex_triangle_filtering_list, adj_114, adj_115);
                                wp::adj_sub(var_110, var_113, adj_110, adj_113, adj_114);
                            }
                            // adj: if idx > fl_start and vertex_triangle_filtering_list[idx - 1] == tri_index:  <L 1449>
                            adj_binary_search_0(var_vertex_triangle_filtering_list, var_74, var_91, var_96, adj_vertex_triangle_filtering_list, adj_74, adj_91, adj_96, adj_110);
                            // adj: idx = binary_search(vertex_triangle_filtering_list, tri_index, fl_start, fl_end)  <L 1447>
                        }
                        if (var_107) {
                        }
                        // adj: if (tri_index >= first_val) and (tri_index <= last_val):          <L 1446>
                        wp::adj_copy(var_106, adj_104, adj_105);
                        wp::adj_address(var_vertex_triangle_filtering_list, var_103, adj_vertex_triangle_filtering_list, adj_103, adj_104);
                        wp::adj_sub(var_96, var_102, adj_96, adj_102, adj_103);
                        // adj: last_val = vertex_triangle_filtering_list[fl_end - 1]             <L 1445>
                        wp::adj_copy(var_101, adj_99, adj_100);
                        wp::adj_address(var_vertex_triangle_filtering_list, var_91, adj_vertex_triangle_filtering_list, adj_91, adj_99);
                        // adj: first_val = vertex_triangle_filtering_list[fl_start]              <L 1444>
                    }
                    // adj: if fl_end > fl_start:                                                 <L 1442>
                    wp::adj_copy(var_97, adj_95, adj_96);
                    wp::adj_address(var_vertex_triangle_filtering_list_offsets, var_94, adj_vertex_triangle_filtering_list_offsets, adj_94, adj_95);
                    wp::adj_add(var_0, var_93, adj_0, adj_93, adj_94);
                    // adj: v_index + 1                                                           <L 1439>
                    // adj: fl_end = vertex_triangle_filtering_list_offsets[                      <L 1438>
                    wp::adj_copy(var_92, adj_90, adj_91);
                    wp::adj_address(var_vertex_triangle_filtering_list_offsets, var_0, adj_vertex_triangle_filtering_list_offsets, adj_0, adj_90);
                    // adj: fl_start = vertex_triangle_filtering_list_offsets[v_index]            <L 1437>
                }
                // adj: if vertex_triangle_filtering_list:                                        <L 1436>
                if (var_89) {
                    // adj: continue                                                              <L 1434>
                }
                adj_vertex_adjacent_to_triangle_0(var_0, var_79, var_83, var_87, adj_0, adj_79, adj_83, adj_87, adj_89);
                // adj: if vertex_adjacent_to_triangle(v_index, t1, t2, t3):                      <L 1433>
                wp::adj_copy(var_88, adj_86, adj_87);
                wp::adj_address(var_tri_indices, var_74, var_85, adj_tri_indices, adj_74, adj_85, adj_86);
                // adj: t3 = tri_indices[tri_index, 2]                                            <L 1431>
                wp::adj_copy(var_84, adj_82, adj_83);
                wp::adj_address(var_tri_indices, var_74, var_81, adj_tri_indices, adj_74, adj_81, adj_82);
                // adj: t2 = tri_indices[tri_index, 1]                                            <L 1430>
                wp::adj_copy(var_80, adj_78, adj_79);
                wp::adj_address(var_tri_indices, var_74, var_77, adj_tri_indices, adj_74, adj_77, adj_78);
                // adj: t1 = tri_indices[tri_index, 0]                                            <L 1429>
        goto start_while_0;
        end_while_0:;
            // adj: while wp.bvh_query_next(query, tri_index):                                    <L 1428>
            // adj: tri_index = wp.int32(0)                                                       <L 1427>
            wp::adj_where(var_67, var_69, var_71, adj_67, adj_69, adj_71, adj_72);
            if (!var_67) {
                // adj: query = wp.bvh_query_aabb(bvh_id, lower, upper, group_root)               <L 1425>
            }
            if (var_67) {
                // adj: query = wp.bvh_query_aabb(bvh_id, lower, upper)                           <L 1423>
            }
            // adj: if query_all:                                                                 <L 1422>
        }
        // adj: if run_query:                                                                     <L 1421>
        wp::adj_where(var_48, var_46, var_63, adj_48, adj_46, adj_63, adj_68);
        wp::adj_where(var_48, var_54, var_44, adj_48, adj_54, adj_44, adj_67);
        wp::adj_where(var_48, var_53, var_65, adj_48, adj_53, adj_65, adj_66);
        if (!var_48) {
            // adj: run_query = group_root >= 0                                                   <L 1419>
            wp::adj_where(var_56, var_58, var_61, adj_56, adj_58, adj_61, adj_63);
            if (!var_56) {
                wp::adj_copy(var_62, adj_60, adj_61);
                wp::adj_address(var_bvh_group_roots, var_world_count, adj_bvh_group_roots, adj_world_count, adj_60);
                // adj: group_root = bvh_group_roots[world_count]                                 <L 1418>
            }
            if (var_56) {
                wp::adj_copy(var_59, adj_57, adj_58);
                wp::adj_address(var_bvh_group_roots, var_38, adj_bvh_group_roots, adj_38, adj_57);
                // adj: group_root = bvh_group_roots[vertex_world]                                <L 1416>
            }
            // adj: if query_pass == 0:                                                           <L 1415>
        }
        if (var_48) {
            wp::adj_where(var_50, var_52, var_44, adj_50, adj_52, adj_44, adj_54);
            wp::adj_where(var_50, var_51, var_42, adj_50, adj_51, adj_42, adj_53);
            if (var_50) {
                // adj: query_all = True                                                          <L 1413>
                // adj: run_query = True                                                          <L 1412>
            }
            // adj: if query_pass == 0:                                                           <L 1411>
        }
        // adj: if vertex_world < 0:                                                              <L 1410>
        // adj: group_root = wp.int32(-1)                                                         <L 1408>
        // adj: query_all = bool(False)                                                           <L 1407>
        // adj: run_query = bool(False)                                                           <L 1406>
        // adj: for query_pass in range(2):                                                       <L 1405>
        wp::adj_copy(var_39, adj_37, adj_38);
        wp::adj_address(var_particle_world, var_0, adj_particle_world, adj_0, adj_37);
        // adj: vertex_world = particle_world[v_index]                                            <L 1399>
        wp::adj_copy(var_max_query_radius, adj_max_query_radius, adj_36);
        // adj: min_dis_to_tris = max_query_radius                                                <L 1398>
        // adj: vertex_num_collisions = wp.int32(0)                                               <L 1397>
        // adj: tri_index = wp.int32(0)                                                           <L 1396>
        wp::adj_vec_t(var_24, var_27, var_30, adj_24, adj_27, adj_30, adj_31);
        wp::adj_add(var_29, var_max_query_radius, adj_29, adj_max_query_radius, adj_30);
        wp::adj_extract(var_2, var_28, adj_2, adj_28, adj_29);
        wp::adj_add(var_26, var_max_query_radius, adj_26, adj_max_query_radius, adj_27);
        wp::adj_extract(var_2, var_25, adj_2, adj_25, adj_26);
        wp::adj_add(var_23, var_max_query_radius, adj_23, adj_max_query_radius, adj_24);
        wp::adj_extract(var_2, var_22, adj_2, adj_22, adj_23);
        // adj: upper = wp.vec3(v[0] + max_query_radius, v[1] + max_query_radius, v[2] + max_query_radius)  <L 1394>
        wp::adj_vec_t(var_14, var_17, var_20, adj_14, adj_17, adj_20, adj_21);
        wp::adj_sub(var_19, var_max_query_radius, adj_19, adj_max_query_radius, adj_20);
        wp::adj_extract(var_2, var_18, adj_2, adj_18, adj_19);
        wp::adj_sub(var_16, var_max_query_radius, adj_16, adj_max_query_radius, adj_17);
        wp::adj_extract(var_2, var_15, adj_2, adj_15, adj_16);
        wp::adj_sub(var_13, var_max_query_radius, adj_13, adj_max_query_radius, adj_14);
        wp::adj_extract(var_2, var_12, adj_2, adj_12, adj_13);
        // adj: lower = wp.vec3(v[0] - max_query_radius, v[1] - max_query_radius, v[2] - max_query_radius)  <L 1393>
        wp::adj_sub(var_11, var_5, adj_9, adj_5, adj_10);
        wp::adj_address(var_vertex_colliding_triangles_offsets, var_8, adj_vertex_colliding_triangles_offsets, adj_8, adj_9);
        wp::adj_add(var_0, var_7, adj_0, adj_7, adj_8);
        // adj: vertex_buffer_size = vertex_colliding_triangles_offsets[v_index + 1] - vertex_buffer_offset  <L 1391>
        wp::adj_copy(var_6, adj_4, adj_5);
        wp::adj_address(var_vertex_colliding_triangles_offsets, var_0, adj_vertex_colliding_triangles_offsets, adj_0, adj_4);
        // adj: vertex_buffer_offset = vertex_colliding_triangles_offsets[v_index]                <L 1390>
        wp::adj_copy(var_3, adj_1, adj_2);
        wp::adj_address(var_pos, var_0, adj_pos, adj_0, adj_1);
        // adj: v = pos[v_index]                                                                  <L 1389>
        // adj: v_index = wp.tid()                                                                <L 1388>
        // adj: def vertex_triangle_collision_detection_kernel(                                   <L 1329>
        continue;
    }
}



extern "C" __global__ void edge_colliding_edges_detection_kernel_8b309277_cuda_kernel_forward(
    wp::launch_bounds_t<1> dim,
    wp::float32 var_max_query_radius,
    wp::float32 var_min_query_radius,
    wp::uint64 var_bvh_id,
    wp::array_t<wp::int32> var_bvh_group_roots,
    wp::array_t<wp::vec_t<3, wp::float32>> var_pos,
    wp::array_t<wp::int32> var_edge_indices,
    wp::array_t<wp::int32> var_particle_world,
    wp::int32 var_world_count,
    wp::array_t<wp::int32> var_edge_colliding_edges_offsets,
    wp::array_t<wp::int32> var_edge_colliding_edges_buffer_sizes,
    wp::float32 var_edge_edge_parallel_epsilon,
    wp::array_t<wp::int32> var_edge_filtering_list,
    wp::array_t<wp::int32> var_edge_filtering_list_offsets,
    wp::array_t<wp::vec_t<3, wp::float32>> var_min_distance_filtering_ref_pos,
    wp::array_t<wp::int32> var_edge_colliding_edges,
    wp::array_t<wp::int32> var_edge_colliding_edges_count,
    wp::array_t<wp::float32> var_edge_colliding_edges_min_dist,
    wp::array_t<wp::int32> var_resize_flags)
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
        const wp::int32 var_1 = 2;
        wp::int32* var_2;
        wp::int32 var_3;
        wp::int32 var_4;
        const wp::int32 var_5 = 3;
        wp::int32* var_6;
        wp::int32 var_7;
        wp::int32 var_8;
        wp::vec_t<3, wp::float32>* var_9;
        wp::vec_t<3, wp::float32> var_10;
        wp::vec_t<3, wp::float32> var_11;
        wp::vec_t<3, wp::float32>* var_12;
        wp::vec_t<3, wp::float32> var_13;
        wp::vec_t<3, wp::float32> var_14;
        wp::vec_t<3, wp::float32> var_15;
        wp::vec_t<3, wp::float32> var_16;
        const wp::int32 var_17 = 0;
        wp::float32 var_18;
        wp::float32 var_19;
        const wp::int32 var_20 = 1;
        wp::float32 var_21;
        wp::float32 var_22;
        const wp::int32 var_23 = 2;
        wp::float32 var_24;
        wp::float32 var_25;
        wp::vec_t<3, wp::float32> var_26;
        const wp::int32 var_27 = 0;
        wp::float32 var_28;
        wp::float32 var_29;
        const wp::int32 var_30 = 1;
        wp::float32 var_31;
        wp::float32 var_32;
        const wp::int32 var_33 = 2;
        wp::float32 var_34;
        wp::float32 var_35;
        wp::vec_t<3, wp::float32> var_36;
        const wp::int32 var_37 = 0;
        wp::int32 var_38;
        const wp::int32 var_39 = 0;
        wp::int32 var_40;
        wp::float32 var_41;
        wp::int32* var_42;
        wp::int32 var_43;
        wp::int32 var_44;
        const wp::int32 var_45 = 0;
        const bool var_46 = false;
        bool var_47;
        const bool var_48 = false;
        bool var_49;
        const wp::int32 var_50 = -1;
        wp::int32 var_51;
        const wp::int32 var_52 = 0;
        bool var_53;
        const wp::int32 var_54 = 0;
        bool var_55;
        const bool var_56 = true;
        const bool var_57 = true;
        bool var_58;
        bool var_59;
        const wp::int32 var_60 = 0;
        bool var_61;
        wp::int32* var_62;
        wp::int32 var_63;
        wp::int32 var_64;
        wp::int32* var_65;
        wp::int32 var_66;
        wp::int32 var_67;
        wp::int32 var_68;
        const wp::int32 var_69 = 0;
        bool var_70;
        bool var_71;
        bool var_72;
        wp::int32 var_73;
        wp::bvh_query_t var_74;
        const wp::int32 var_75 = -1;
        wp::bvh_query_t var_76;
        wp::bvh_query_t var_77;
        const wp::int32 var_78 = 0;
        wp::int32 var_79;
        bool var_80;
        const wp::float32 var_81 = INFINITY;
        const wp::int32 var_82 = 2;
        wp::int32* var_83;
        wp::int32 var_84;
        wp::int32 var_85;
        const wp::int32 var_86 = 3;
        wp::int32* var_87;
        wp::int32 var_88;
        wp::int32 var_89;
        bool var_90;
        bool var_91;
        bool var_92;
        bool var_93;
        bool var_94;
        wp::int32* var_95;
        wp::int32 var_96;
        wp::int32 var_97;
        const wp::int32 var_98 = 1;
        wp::int32 var_99;
        wp::int32* var_100;
        wp::int32 var_101;
        wp::int32 var_102;
        bool var_103;
        wp::int32* var_104;
        wp::int32 var_105;
        wp::int32 var_106;
        const wp::int32 var_107 = 1;
        wp::int32 var_108;
        wp::int32* var_109;
        wp::int32 var_110;
        wp::int32 var_111;
        bool var_112;
        bool var_113;
        bool var_114;
        wp::int32 var_115;
        bool var_116;
        bool var_117;
        const wp::int32 var_118 = 1;
        wp::int32 var_119;
        wp::int32* var_120;
        bool var_121;
        wp::int32 var_122;
        wp::vec_t<3, wp::float32>* var_123;
        wp::vec_t<3, wp::float32> var_124;
        wp::vec_t<3, wp::float32> var_125;
        wp::vec_t<3, wp::float32>* var_126;
        wp::vec_t<3, wp::float32> var_127;
        wp::vec_t<3, wp::float32> var_128;
        wp::vec_t<3, wp::float32> var_129;
        const wp::int32 var_130 = 2;
        wp::float32 var_131;
        bool var_132;
        const wp::float32 var_133 = 0.0;
        bool var_134;
        wp::vec_t<3, wp::float32>* var_135;
        wp::vec_t<3, wp::float32> var_136;
        wp::vec_t<3, wp::float32> var_137;
        wp::vec_t<3, wp::float32>* var_138;
        wp::vec_t<3, wp::float32> var_139;
        wp::vec_t<3, wp::float32> var_140;
        wp::vec_t<3, wp::float32>* var_141;
        wp::vec_t<3, wp::float32> var_142;
        wp::vec_t<3, wp::float32> var_143;
        wp::vec_t<3, wp::float32>* var_144;
        wp::vec_t<3, wp::float32> var_145;
        wp::vec_t<3, wp::float32> var_146;
        wp::vec_t<3, wp::float32> var_147;
        const wp::int32 var_148 = 2;
        wp::float32 var_149;
        bool var_150;
        bool var_151;
        wp::int32* var_152;
        wp::int32 var_153;
        wp::int32 var_154;
        const wp::int32 var_155 = 1;
        wp::int32 var_156;
        wp::int32* var_157;
        wp::int32 var_158;
        wp::int32 var_159;
        wp::float32 var_160;
        bool var_161;
        const wp::int32 var_162 = 2;
        wp::int32 var_163;
        wp::int32 var_164;
        const wp::int32 var_165 = 2;
        wp::int32 var_166;
        wp::int32 var_167;
        const wp::int32 var_168 = 1;
        wp::int32 var_169;
        const wp::int32 var_170 = 1;
        const wp::int32 var_171 = 2;
        const wp::int32 var_172 = 1;
        wp::int32 var_173;
        wp::int32 var_174;
        wp::float32 var_175;
        wp::int32 var_176;
        const wp::int32 var_177 = 1;
        const bool var_178 = false;
        bool var_179;
        const bool var_180 = false;
        bool var_181;
        const wp::int32 var_182 = -1;
        wp::int32 var_183;
        const wp::int32 var_184 = 0;
        bool var_185;
        const wp::int32 var_186 = 0;
        bool var_187;
        const bool var_188 = true;
        const bool var_189 = true;
        bool var_190;
        bool var_191;
        const wp::int32 var_192 = 0;
        bool var_193;
        wp::int32* var_194;
        wp::int32 var_195;
        wp::int32 var_196;
        wp::int32* var_197;
        wp::int32 var_198;
        wp::int32 var_199;
        wp::int32 var_200;
        const wp::int32 var_201 = 0;
        bool var_202;
        bool var_203;
        bool var_204;
        wp::int32 var_205;
        wp::bvh_query_t var_206;
        const wp::int32 var_207 = -1;
        wp::bvh_query_t var_208;
        wp::bvh_query_t var_209;
        const wp::int32 var_210 = 0;
        wp::int32 var_211;
        bool var_212;
        const wp::float32 var_213 = INFINITY;
        const wp::int32 var_214 = 2;
        wp::int32* var_215;
        wp::int32 var_216;
        wp::int32 var_217;
        const wp::int32 var_218 = 3;
        wp::int32* var_219;
        wp::int32 var_220;
        wp::int32 var_221;
        bool var_222;
        bool var_223;
        bool var_224;
        bool var_225;
        bool var_226;
        wp::int32 var_227;
        wp::int32 var_228;
        wp::int32* var_229;
        wp::int32 var_230;
        wp::int32 var_231;
        const wp::int32 var_232 = 1;
        wp::int32 var_233;
        wp::int32* var_234;
        wp::int32 var_235;
        wp::int32 var_236;
        bool var_237;
        wp::int32* var_238;
        wp::int32 var_239;
        wp::int32 var_240;
        const wp::int32 var_241 = 1;
        wp::int32 var_242;
        wp::int32* var_243;
        wp::int32 var_244;
        wp::int32 var_245;
        bool var_246;
        bool var_247;
        bool var_248;
        wp::int32 var_249;
        bool var_250;
        bool var_251;
        const wp::int32 var_252 = 1;
        wp::int32 var_253;
        wp::int32* var_254;
        bool var_255;
        wp::int32 var_256;
        wp::int32 var_257;
        wp::int32 var_258;
        wp::int32 var_259;
        wp::int32 var_260;
        wp::int32 var_261;
        wp::int32 var_262;
        wp::int32 var_263;
        wp::int32 var_264;
        wp::int32 var_265;
        wp::int32 var_266;
        wp::int32 var_267;
        wp::int32 var_268;
        wp::int32 var_269;
        wp::int32 var_270;
        wp::int32 var_271;
        wp::int32 var_272;
        wp::int32 var_273;
        wp::int32 var_274;
        wp::int32 var_275;
        wp::int32 var_276;
        wp::int32 var_277;
        wp::int32 var_278;
        wp::int32 var_279;
        wp::int32 var_280;
        wp::int32 var_281;
        wp::int32 var_282;
        wp::int32 var_283;
        wp::int32 var_284;
        wp::vec_t<3, wp::float32>* var_285;
        wp::vec_t<3, wp::float32> var_286;
        wp::vec_t<3, wp::float32> var_287;
        wp::vec_t<3, wp::float32>* var_288;
        wp::vec_t<3, wp::float32> var_289;
        wp::vec_t<3, wp::float32> var_290;
        wp::vec_t<3, wp::float32> var_291;
        const wp::int32 var_292 = 2;
        wp::float32 var_293;
        bool var_294;
        const wp::float32 var_295 = 0.0;
        bool var_296;
        wp::vec_t<3, wp::float32>* var_297;
        wp::vec_t<3, wp::float32> var_298;
        wp::vec_t<3, wp::float32> var_299;
        wp::vec_t<3, wp::float32>* var_300;
        wp::vec_t<3, wp::float32> var_301;
        wp::vec_t<3, wp::float32> var_302;
        wp::vec_t<3, wp::float32>* var_303;
        wp::vec_t<3, wp::float32> var_304;
        wp::vec_t<3, wp::float32> var_305;
        wp::vec_t<3, wp::float32>* var_306;
        wp::vec_t<3, wp::float32> var_307;
        wp::vec_t<3, wp::float32> var_308;
        wp::vec_t<3, wp::float32> var_309;
        const wp::int32 var_310 = 2;
        wp::float32 var_311;
        bool var_312;
        wp::int32 var_313;
        wp::int32 var_314;
        wp::int32 var_315;
        wp::int32 var_316;
        wp::int32 var_317;
        wp::int32 var_318;
        wp::int32 var_319;
        wp::vec_t<3, wp::float32> var_320;
        wp::vec_t<3, wp::float32> var_321;
        wp::vec_t<3, wp::float32> var_322;
        wp::float32 var_323;
        wp::vec_t<3, wp::float32> var_324;
        wp::vec_t<3, wp::float32> var_325;
        wp::vec_t<3, wp::float32> var_326;
        wp::vec_t<3, wp::float32> var_327;
        wp::vec_t<3, wp::float32> var_328;
        wp::float32 var_329;
        wp::int32 var_330;
        wp::int32 var_331;
        wp::int32 var_332;
        wp::int32 var_333;
        wp::int32 var_334;
        wp::int32 var_335;
        wp::int32 var_336;
        wp::vec_t<3, wp::float32> var_337;
        wp::vec_t<3, wp::float32> var_338;
        wp::vec_t<3, wp::float32> var_339;
        wp::float32 var_340;
        wp::vec_t<3, wp::float32> var_341;
        wp::vec_t<3, wp::float32> var_342;
        wp::vec_t<3, wp::float32> var_343;
        wp::vec_t<3, wp::float32> var_344;
        wp::vec_t<3, wp::float32> var_345;
        wp::float32 var_346;
        bool var_347;
        wp::int32* var_348;
        wp::int32 var_349;
        wp::int32 var_350;
        const wp::int32 var_351 = 1;
        wp::int32 var_352;
        wp::int32* var_353;
        wp::int32 var_354;
        wp::int32 var_355;
        wp::float32 var_356;
        bool var_357;
        const wp::int32 var_358 = 2;
        wp::int32 var_359;
        wp::int32 var_360;
        const wp::int32 var_361 = 2;
        wp::int32 var_362;
        wp::int32 var_363;
        const wp::int32 var_364 = 1;
        wp::int32 var_365;
        const wp::int32 var_366 = 1;
        const wp::int32 var_367 = 1;
        wp::int32 var_368;
        wp::int32 var_369;
        wp::float32 var_370;
        wp::int32 var_371;
        wp::int32 var_372;
        wp::int32 var_373;
        wp::bvh_query_t var_374;
        //---------
        // forward
        // def edge_colliding_edges_detection_kernel(                                             <L 1500>
        // e_index = wp.tid()                                                                     <L 1538>
        var_0 = builtin_tid1d();
        // e0_v0 = edge_indices[e_index, 2]                                                       <L 1540>
        var_2 = wp::address(var_edge_indices, var_0, var_1);
        var_4 = wp::load(var_2);
        var_3 = wp::copy(var_4);
        // e0_v1 = edge_indices[e_index, 3]                                                       <L 1541>
        var_6 = wp::address(var_edge_indices, var_0, var_5);
        var_8 = wp::load(var_6);
        var_7 = wp::copy(var_8);
        // e0_v0_pos = pos[e0_v0]                                                                 <L 1543>
        var_9 = wp::address(var_pos, var_3);
        var_11 = wp::load(var_9);
        var_10 = wp::copy(var_11);
        // e0_v1_pos = pos[e0_v1]                                                                 <L 1544>
        var_12 = wp::address(var_pos, var_7);
        var_14 = wp::load(var_12);
        var_13 = wp::copy(var_14);
        // lower = wp.min(e0_v0_pos, e0_v1_pos)                                                   <L 1546>
        var_15 = wp::min(var_10, var_13);
        // upper = wp.max(e0_v0_pos, e0_v1_pos)                                                   <L 1547>
        var_16 = wp::max(var_10, var_13);
        // lower = wp.vec3(lower[0] - max_query_radius, lower[1] - max_query_radius, lower[2] - max_query_radius)       <L 1549>
        var_18 = wp::extract(var_15, var_17);
        var_19 = wp::sub(var_18, var_max_query_radius);
        var_21 = wp::extract(var_15, var_20);
        var_22 = wp::sub(var_21, var_max_query_radius);
        var_24 = wp::extract(var_15, var_23);
        var_25 = wp::sub(var_24, var_max_query_radius);
        var_26 = wp::vec_t<3, wp::float32>(var_19, var_22, var_25);
        // upper = wp.vec3(upper[0] + max_query_radius, upper[1] + max_query_radius, upper[2] + max_query_radius)       <L 1550>
        var_28 = wp::extract(var_16, var_27);
        var_29 = wp::add(var_28, var_max_query_radius);
        var_31 = wp::extract(var_16, var_30);
        var_32 = wp::add(var_31, var_max_query_radius);
        var_34 = wp::extract(var_16, var_33);
        var_35 = wp::add(var_34, var_max_query_radius);
        var_36 = wp::vec_t<3, wp::float32>(var_29, var_32, var_35);
        // colliding_edge_index = wp.int32(0)                                                     <L 1552>
        var_38 = wp::int32(var_37);
        // edge_num_collisions = wp.int32(0)                                                      <L 1553>
        var_40 = wp::int32(var_39);
        // min_dis_to_edges = max_query_radius                                                    <L 1554>
        var_41 = wp::copy(var_max_query_radius);
        // edge_world = particle_world[e0_v0]                                                     <L 1555>
        var_42 = wp::address(var_particle_world, var_3);
        var_44 = wp::load(var_42);
        var_43 = wp::copy(var_44);
        // for query_pass in range(2):                                                            <L 1561>
        // run_query = bool(False)                                                                <L 1562>
        var_47 = bool(var_46);
        // query_all = bool(False)                                                                <L 1563>
        var_49 = bool(var_48);
        // group_root = wp.int32(-1)                                                              <L 1564>
        var_51 = wp::int32(var_50);
        // if edge_world < 0:                                                                     <L 1566>
        var_53 = (var_43 < var_52);
        if (var_53) {
            // if query_pass == 0:                                                                <L 1567>
            var_55 = (var_45 == var_54);
            if (var_55) {
                // run_query = True                                                               <L 1568>
                // query_all = True                                                               <L 1569>
            }
            var_58 = wp::where(var_55, var_56, var_47);
            var_59 = wp::where(var_55, var_57, var_49);
        }
        if (!var_53) {
            // if query_pass == 0:                                                                <L 1571>
            var_61 = (var_45 == var_60);
            if (var_61) {
                // group_root = bvh_group_roots[edge_world]                                       <L 1572>
                var_62 = wp::address(var_bvh_group_roots, var_43);
                var_64 = wp::load(var_62);
                var_63 = wp::copy(var_64);
            }
            if (!var_61) {
                // group_root = bvh_group_roots[world_count]                                      <L 1574>
                var_65 = wp::address(var_bvh_group_roots, var_world_count);
                var_67 = wp::load(var_65);
                var_66 = wp::copy(var_67);
            }
            var_68 = wp::where(var_61, var_63, var_66);
            // run_query = group_root >= 0                                                        <L 1575>
            var_70 = (var_68 >= var_69);
        }
        var_71 = wp::where(var_53, var_58, var_70);
        var_72 = wp::where(var_53, var_59, var_49);
        var_73 = wp::where(var_53, var_51, var_68);
        // if run_query:                                                                          <L 1577>
        if (var_71) {
            // if query_all:                                                                      <L 1578>
            if (var_72) {
                // query = wp.bvh_query_aabb(bvh_id, lower, upper)                                <L 1579>
                var_74 = wp::bvh_query_aabb(var_bvh_id, var_26, var_36, var_75);
            }
            if (!var_72) {
                // query = wp.bvh_query_aabb(bvh_id, lower, upper, group_root)                    <L 1581>
                var_76 = wp::bvh_query_aabb(var_bvh_id, var_26, var_36, var_73);
            }
            var_77 = wp::where(var_72, var_74, var_76);
            // colliding_edge_index = wp.int32(0)                                                 <L 1583>
            var_79 = wp::int32(var_78);
            // while wp.bvh_query_next(query, colliding_edge_index):                              <L 1584>
        start_while_0:;
            var_80 = wp::bvh_query_next(var_77, var_79, var_81);
        if ((var_80) == false) goto end_while_0;
                // e1_v0 = edge_indices[colliding_edge_index, 2]                                  <L 1585>
                var_83 = wp::address(var_edge_indices, var_79, var_82);
                var_85 = wp::load(var_83);
                var_84 = wp::copy(var_85);
                // e1_v1 = edge_indices[colliding_edge_index, 3]                                  <L 1586>
                var_87 = wp::address(var_edge_indices, var_79, var_86);
                var_89 = wp::load(var_87);
                var_88 = wp::copy(var_89);
                // if e0_v0 == e1_v0 or e0_v0 == e1_v1 or e0_v1 == e1_v0 or e0_v1 == e1_v1:       <L 1588>
                var_91 = (var_3 == var_84);
                var_90 = var_91;
                if (!var_90) {
                    var_92 = (var_3 == var_88);
                    var_90 = var_90 || var_92;
                }
                if (!var_90) {
                    var_93 = (var_7 == var_84);
                    var_90 = var_90 || var_93;
                }
                if (!var_90) {
                    var_94 = (var_7 == var_88);
                    var_90 = var_90 || var_94;
                }
                if (var_90) {
                    // continue                                                                   <L 1589>
                    goto start_while_0;
                }
                // if edge_filtering_list:                                                        <L 1591>
                if (var_edge_filtering_list) {
                    // fl_start = edge_filtering_list_offsets[e_index]                            <L 1592>
                    var_95 = wp::address(var_edge_filtering_list_offsets, var_0);
                    var_97 = wp::load(var_95);
                    var_96 = wp::copy(var_97);
                    // fl_end = edge_filtering_list_offsets[e_index + 1]  # start of next vertex slice (end exclusive)       <L 1593>
                    var_99 = wp::add(var_0, var_98);
                    var_100 = wp::address(var_edge_filtering_list_offsets, var_99);
                    var_102 = wp::load(var_100);
                    var_101 = wp::copy(var_102);
                    // if fl_end > fl_start:                                                      <L 1595>
                    var_103 = (var_101 > var_96);
                    if (var_103) {
                        // first_val = edge_filtering_list[fl_start]                              <L 1597>
                        var_104 = wp::address(var_edge_filtering_list, var_96);
                        var_106 = wp::load(var_104);
                        var_105 = wp::copy(var_106);
                        // last_val = edge_filtering_list[fl_end - 1]                             <L 1598>
                        var_108 = wp::sub(var_101, var_107);
                        var_109 = wp::address(var_edge_filtering_list, var_108);
                        var_111 = wp::load(var_109);
                        var_110 = wp::copy(var_111);
                        // if (colliding_edge_index >= first_val) and (colliding_edge_index <= last_val):       <L 1599>
                        var_113 = (var_79 >= var_105);
                        var_112 = var_113;
                        if (var_112) {
                            var_114 = (var_79 <= var_110);
                            var_112 = var_112 && var_114;
                        }
                        if (var_112) {
                            // idx = binary_search(edge_filtering_list, colliding_edge_index, fl_start, fl_end)       <L 1600>
                            var_115 = binary_search_0(var_edge_filtering_list, var_79, var_96, var_101);
                            // if idx > fl_start and edge_filtering_list[idx - 1] == colliding_edge_index:       <L 1601>
                            var_117 = (var_115 > var_96);
                            var_116 = var_117;
                            if (var_116) {
                                var_119 = wp::sub(var_115, var_118);
                                var_120 = wp::address(var_edge_filtering_list, var_119);
                                var_122 = wp::load(var_120);
                                var_121 = (var_122 == var_79);
                                var_116 = var_116 && var_121;
                            }
                            if (var_116) {
                                // continue                                                       <L 1602>
                                goto start_while_0;
                            }
                        }
                    }
                }
                // e1_v0_pos = pos[e1_v0]                                                         <L 1605>
                var_123 = wp::address(var_pos, var_84);
                var_125 = wp::load(var_123);
                var_124 = wp::copy(var_125);
                // e1_v1_pos = pos[e1_v1]                                                         <L 1606>
                var_126 = wp::address(var_pos, var_88);
                var_128 = wp::load(var_126);
                var_127 = wp::copy(var_128);
                // std = wp.closest_point_edge_edge(e0_v0_pos, e0_v1_pos, e1_v0_pos, e1_v1_pos, edge_edge_parallel_epsilon)       <L 1608>
                var_129 = wp::closest_point_edge_edge(var_10, var_13, var_124, var_127, var_edge_edge_parallel_epsilon);
                // dist = std[2]                                                                  <L 1609>
                var_131 = wp::extract(var_129, var_130);
                // if min_distance_filtering_ref_pos and min_query_radius > 0.0:                  <L 1611>
                var_132 = var_min_distance_filtering_ref_pos;
                if (var_132) {
                    var_134 = (var_min_query_radius > var_133);
                    var_132 = var_132 && var_134;
                }
                if (var_132) {
                    // e0_v0_pos_ref = min_distance_filtering_ref_pos[e0_v0]                      <L 1612>
                    var_135 = wp::address(var_min_distance_filtering_ref_pos, var_3);
                    var_137 = wp::load(var_135);
                    var_136 = wp::copy(var_137);
                    // e0_v1_pos_ref = min_distance_filtering_ref_pos[e0_v1]                      <L 1613>
                    var_138 = wp::address(var_min_distance_filtering_ref_pos, var_7);
                    var_140 = wp::load(var_138);
                    var_139 = wp::copy(var_140);
                    // e1_v0_pos_ref = min_distance_filtering_ref_pos[e1_v0]                      <L 1614>
                    var_141 = wp::address(var_min_distance_filtering_ref_pos, var_84);
                    var_143 = wp::load(var_141);
                    var_142 = wp::copy(var_143);
                    // e1_v1_pos_ref = min_distance_filtering_ref_pos[e1_v1]                      <L 1615>
                    var_144 = wp::address(var_min_distance_filtering_ref_pos, var_88);
                    var_146 = wp::load(var_144);
                    var_145 = wp::copy(var_146);
                    // std_ref = wp.closest_point_edge_edge(                                      <L 1616>
                    // e0_v0_pos_ref, e0_v1_pos_ref, e1_v0_pos_ref, e1_v1_pos_ref, edge_edge_parallel_epsilon       <L 1617>
                    var_147 = wp::closest_point_edge_edge(var_136, var_139, var_142, var_145, var_edge_edge_parallel_epsilon);
                    // dist_ref = std_ref[2]                                                      <L 1620>
                    var_149 = wp::extract(var_147, var_148);
                    // if dist_ref < min_query_radius:                                            <L 1621>
                    var_150 = (var_149 < var_min_query_radius);
                    if (var_150) {
                        // continue                                                               <L 1622>
                        goto start_while_0;
                    }
                }
                // if dist < max_query_radius:                                                    <L 1624>
                var_151 = (var_131 < var_max_query_radius);
                if (var_151) {
                    // edge_buffer_offset = edge_colliding_edges_offsets[e_index]                 <L 1625>
                    var_152 = wp::address(var_edge_colliding_edges_offsets, var_0);
                    var_154 = wp::load(var_152);
                    var_153 = wp::copy(var_154);
                    // edge_buffer_size = edge_colliding_edges_offsets[e_index + 1] - edge_buffer_offset       <L 1626>
                    var_156 = wp::add(var_0, var_155);
                    var_157 = wp::address(var_edge_colliding_edges_offsets, var_156);
                    var_159 = wp::load(var_157);
                    var_158 = wp::sub(var_159, var_153);
                    // min_dis_to_edges = wp.min(min_dis_to_edges, dist)                          <L 1629>
                    var_160 = wp::min(var_41, var_131);
                    // if edge_num_collisions < edge_buffer_size:                                 <L 1630>
                    var_161 = (var_40 < var_158);
                    if (var_161) {
                        // edge_colliding_edges[2 * (edge_buffer_offset + edge_num_collisions)] = e_index       <L 1631>
                        var_163 = wp::add(var_153, var_40);
                        var_164 = wp::mul(var_162, var_163);
                        wp::array_store(var_edge_colliding_edges, var_164, var_0);
                        // edge_colliding_edges[2 * (edge_buffer_offset + edge_num_collisions) + 1] = colliding_edge_index       <L 1632>
                        var_166 = wp::add(var_153, var_40);
                        var_167 = wp::mul(var_165, var_166);
                        var_169 = wp::add(var_167, var_168);
                        wp::array_store(var_edge_colliding_edges, var_169, var_79);
                    }
                    if (!var_161) {
                        // resize_flags[EDGE_COLLISION_BUFFER_OVERFLOW_INDEX] = 1                 <L 1634>
                        wp::array_store(var_resize_flags, var_171, var_170);
                    }
                    // edge_num_collisions = edge_num_collisions + 1                              <L 1636>
                    var_173 = wp::add(var_40, var_172);
                }
                var_174 = wp::where(var_151, var_173, var_40);
                var_175 = wp::where(var_151, var_160, var_41);
                wp::assign(var_40, var_174);
                wp::assign(var_41, var_175);
        goto start_while_0;
        end_while_0:;
        }
        var_176 = wp::where(var_71, var_79, var_38);
        // run_query = bool(False)                                                                <L 1562>
        var_179 = bool(var_178);
        // query_all = bool(False)                                                                <L 1563>
        var_181 = bool(var_180);
        // group_root = wp.int32(-1)                                                              <L 1564>
        var_183 = wp::int32(var_182);
        // if edge_world < 0:                                                                     <L 1566>
        var_185 = (var_43 < var_184);
        if (var_185) {
            // if query_pass == 0:                                                                <L 1567>
            var_187 = (var_177 == var_186);
            if (var_187) {
                // run_query = True                                                               <L 1568>
                // query_all = True                                                               <L 1569>
            }
            var_190 = wp::where(var_187, var_188, var_179);
            var_191 = wp::where(var_187, var_189, var_181);
        }
        if (!var_185) {
            // if query_pass == 0:                                                                <L 1571>
            var_193 = (var_177 == var_192);
            if (var_193) {
                // group_root = bvh_group_roots[edge_world]                                       <L 1572>
                var_194 = wp::address(var_bvh_group_roots, var_43);
                var_196 = wp::load(var_194);
                var_195 = wp::copy(var_196);
            }
            if (!var_193) {
                // group_root = bvh_group_roots[world_count]                                      <L 1574>
                var_197 = wp::address(var_bvh_group_roots, var_world_count);
                var_199 = wp::load(var_197);
                var_198 = wp::copy(var_199);
            }
            var_200 = wp::where(var_193, var_195, var_198);
            // run_query = group_root >= 0                                                        <L 1575>
            var_202 = (var_200 >= var_201);
        }
        var_203 = wp::where(var_185, var_190, var_202);
        var_204 = wp::where(var_185, var_191, var_181);
        var_205 = wp::where(var_185, var_183, var_200);
        // if run_query:                                                                          <L 1577>
        if (var_203) {
            // if query_all:                                                                      <L 1578>
            if (var_204) {
                // query = wp.bvh_query_aabb(bvh_id, lower, upper)                                <L 1579>
                var_206 = wp::bvh_query_aabb(var_bvh_id, var_26, var_36, var_207);
            }
            if (!var_204) {
                // query = wp.bvh_query_aabb(bvh_id, lower, upper, group_root)                    <L 1581>
                var_208 = wp::bvh_query_aabb(var_bvh_id, var_26, var_36, var_205);
            }
            var_209 = wp::where(var_204, var_206, var_208);
            // colliding_edge_index = wp.int32(0)                                                 <L 1583>
            var_211 = wp::int32(var_210);
            // while wp.bvh_query_next(query, colliding_edge_index):                              <L 1584>
        start_while_2:;
            var_212 = wp::bvh_query_next(var_209, var_211, var_213);
        if ((var_212) == false) goto end_while_2;
                // e1_v0 = edge_indices[colliding_edge_index, 2]                                  <L 1585>
                var_215 = wp::address(var_edge_indices, var_211, var_214);
                var_217 = wp::load(var_215);
                var_216 = wp::copy(var_217);
                // e1_v1 = edge_indices[colliding_edge_index, 3]                                  <L 1586>
                var_219 = wp::address(var_edge_indices, var_211, var_218);
                var_221 = wp::load(var_219);
                var_220 = wp::copy(var_221);
                // if e0_v0 == e1_v0 or e0_v0 == e1_v1 or e0_v1 == e1_v0 or e0_v1 == e1_v1:       <L 1588>
                var_223 = (var_3 == var_216);
                var_222 = var_223;
                if (!var_222) {
                    var_224 = (var_3 == var_220);
                    var_222 = var_222 || var_224;
                }
                if (!var_222) {
                    var_225 = (var_7 == var_216);
                    var_222 = var_222 || var_225;
                }
                if (!var_222) {
                    var_226 = (var_7 == var_220);
                    var_222 = var_222 || var_226;
                }
                if (var_222) {
                    // continue                                                                   <L 1589>
                    wp::assign(var_84, var_216);
                    wp::assign(var_88, var_220);
                    goto start_while_2;
                }
                var_227 = wp::where(var_222, var_84, var_216);
                var_228 = wp::where(var_222, var_88, var_220);
                // if edge_filtering_list:                                                        <L 1591>
                if (var_edge_filtering_list) {
                    // fl_start = edge_filtering_list_offsets[e_index]                            <L 1592>
                    var_229 = wp::address(var_edge_filtering_list_offsets, var_0);
                    var_231 = wp::load(var_229);
                    var_230 = wp::copy(var_231);
                    // fl_end = edge_filtering_list_offsets[e_index + 1]  # start of next vertex slice (end exclusive)       <L 1593>
                    var_233 = wp::add(var_0, var_232);
                    var_234 = wp::address(var_edge_filtering_list_offsets, var_233);
                    var_236 = wp::load(var_234);
                    var_235 = wp::copy(var_236);
                    // if fl_end > fl_start:                                                      <L 1595>
                    var_237 = (var_235 > var_230);
                    if (var_237) {
                        // first_val = edge_filtering_list[fl_start]                              <L 1597>
                        var_238 = wp::address(var_edge_filtering_list, var_230);
                        var_240 = wp::load(var_238);
                        var_239 = wp::copy(var_240);
                        // last_val = edge_filtering_list[fl_end - 1]                             <L 1598>
                        var_242 = wp::sub(var_235, var_241);
                        var_243 = wp::address(var_edge_filtering_list, var_242);
                        var_245 = wp::load(var_243);
                        var_244 = wp::copy(var_245);
                        // if (colliding_edge_index >= first_val) and (colliding_edge_index <= last_val):       <L 1599>
                        var_247 = (var_211 >= var_239);
                        var_246 = var_247;
                        if (var_246) {
                            var_248 = (var_211 <= var_244);
                            var_246 = var_246 && var_248;
                        }
                        if (var_246) {
                            // idx = binary_search(edge_filtering_list, colliding_edge_index, fl_start, fl_end)       <L 1600>
                            var_249 = binary_search_0(var_edge_filtering_list, var_211, var_230, var_235);
                            // if idx > fl_start and edge_filtering_list[idx - 1] == colliding_edge_index:       <L 1601>
                            var_251 = (var_249 > var_230);
                            var_250 = var_251;
                            if (var_250) {
                                var_253 = wp::sub(var_249, var_252);
                                var_254 = wp::address(var_edge_filtering_list, var_253);
                                var_256 = wp::load(var_254);
                                var_255 = (var_256 == var_211);
                                var_250 = var_250 && var_255;
                            }
                            if (var_250) {
                                // continue                                                       <L 1602>
                                wp::assign(var_84, var_227);
                                wp::assign(var_88, var_228);
                                wp::assign(var_96, var_230);
                                wp::assign(var_101, var_235);
                                wp::assign(var_105, var_239);
                                wp::assign(var_110, var_244);
                                wp::assign(var_115, var_249);
                                goto start_while_2;
                            }
                            var_257 = wp::where(var_250, var_84, var_227);
                            var_258 = wp::where(var_250, var_88, var_228);
                            var_259 = wp::where(var_250, var_96, var_230);
                            var_260 = wp::where(var_250, var_101, var_235);
                            var_261 = wp::where(var_250, var_105, var_239);
                            var_262 = wp::where(var_250, var_110, var_244);
                            var_263 = wp::where(var_250, var_115, var_249);
                        }
                        var_264 = wp::where(var_246, var_257, var_227);
                        var_265 = wp::where(var_246, var_258, var_228);
                        var_266 = wp::where(var_246, var_259, var_230);
                        var_267 = wp::where(var_246, var_260, var_235);
                        var_268 = wp::where(var_246, var_261, var_239);
                        var_269 = wp::where(var_246, var_262, var_244);
                        var_270 = wp::where(var_246, var_263, var_115);
                    }
                    var_271 = wp::where(var_237, var_264, var_227);
                    var_272 = wp::where(var_237, var_265, var_228);
                    var_273 = wp::where(var_237, var_266, var_230);
                    var_274 = wp::where(var_237, var_267, var_235);
                    var_275 = wp::where(var_237, var_268, var_105);
                    var_276 = wp::where(var_237, var_269, var_110);
                    var_277 = wp::where(var_237, var_270, var_115);
                }
                var_278 = wp::where(var_edge_filtering_list, var_271, var_227);
                var_279 = wp::where(var_edge_filtering_list, var_272, var_228);
                var_280 = wp::where(var_edge_filtering_list, var_273, var_96);
                var_281 = wp::where(var_edge_filtering_list, var_274, var_101);
                var_282 = wp::where(var_edge_filtering_list, var_275, var_105);
                var_283 = wp::where(var_edge_filtering_list, var_276, var_110);
                var_284 = wp::where(var_edge_filtering_list, var_277, var_115);
                // e1_v0_pos = pos[e1_v0]                                                         <L 1605>
                var_285 = wp::address(var_pos, var_278);
                var_287 = wp::load(var_285);
                var_286 = wp::copy(var_287);
                // e1_v1_pos = pos[e1_v1]                                                         <L 1606>
                var_288 = wp::address(var_pos, var_279);
                var_290 = wp::load(var_288);
                var_289 = wp::copy(var_290);
                // std = wp.closest_point_edge_edge(e0_v0_pos, e0_v1_pos, e1_v0_pos, e1_v1_pos, edge_edge_parallel_epsilon)       <L 1608>
                var_291 = wp::closest_point_edge_edge(var_10, var_13, var_286, var_289, var_edge_edge_parallel_epsilon);
                // dist = std[2]                                                                  <L 1609>
                var_293 = wp::extract(var_291, var_292);
                // if min_distance_filtering_ref_pos and min_query_radius > 0.0:                  <L 1611>
                var_294 = var_min_distance_filtering_ref_pos;
                if (var_294) {
                    var_296 = (var_min_query_radius > var_295);
                    var_294 = var_294 && var_296;
                }
                if (var_294) {
                    // e0_v0_pos_ref = min_distance_filtering_ref_pos[e0_v0]                      <L 1612>
                    var_297 = wp::address(var_min_distance_filtering_ref_pos, var_3);
                    var_299 = wp::load(var_297);
                    var_298 = wp::copy(var_299);
                    // e0_v1_pos_ref = min_distance_filtering_ref_pos[e0_v1]                      <L 1613>
                    var_300 = wp::address(var_min_distance_filtering_ref_pos, var_7);
                    var_302 = wp::load(var_300);
                    var_301 = wp::copy(var_302);
                    // e1_v0_pos_ref = min_distance_filtering_ref_pos[e1_v0]                      <L 1614>
                    var_303 = wp::address(var_min_distance_filtering_ref_pos, var_278);
                    var_305 = wp::load(var_303);
                    var_304 = wp::copy(var_305);
                    // e1_v1_pos_ref = min_distance_filtering_ref_pos[e1_v1]                      <L 1615>
                    var_306 = wp::address(var_min_distance_filtering_ref_pos, var_279);
                    var_308 = wp::load(var_306);
                    var_307 = wp::copy(var_308);
                    // std_ref = wp.closest_point_edge_edge(                                      <L 1616>
                    // e0_v0_pos_ref, e0_v1_pos_ref, e1_v0_pos_ref, e1_v1_pos_ref, edge_edge_parallel_epsilon       <L 1617>
                    var_309 = wp::closest_point_edge_edge(var_298, var_301, var_304, var_307, var_edge_edge_parallel_epsilon);
                    // dist_ref = std_ref[2]                                                      <L 1620>
                    var_311 = wp::extract(var_309, var_310);
                    // if dist_ref < min_query_radius:                                            <L 1621>
                    var_312 = (var_311 < var_min_query_radius);
                    if (var_312) {
                        // continue                                                               <L 1622>
                        wp::assign(var_84, var_278);
                        wp::assign(var_88, var_279);
                        wp::assign(var_96, var_280);
                        wp::assign(var_101, var_281);
                        wp::assign(var_105, var_282);
                        wp::assign(var_110, var_283);
                        wp::assign(var_115, var_284);
                        wp::assign(var_124, var_286);
                        wp::assign(var_127, var_289);
                        wp::assign(var_129, var_291);
                        wp::assign(var_131, var_293);
                        wp::assign(var_136, var_298);
                        wp::assign(var_139, var_301);
                        wp::assign(var_142, var_304);
                        wp::assign(var_145, var_307);
                        wp::assign(var_147, var_309);
                        wp::assign(var_149, var_311);
                        goto start_while_2;
                    }
                    var_313 = wp::where(var_312, var_84, var_278);
                    var_314 = wp::where(var_312, var_88, var_279);
                    var_315 = wp::where(var_312, var_96, var_280);
                    var_316 = wp::where(var_312, var_101, var_281);
                    var_317 = wp::where(var_312, var_105, var_282);
                    var_318 = wp::where(var_312, var_110, var_283);
                    var_319 = wp::where(var_312, var_115, var_284);
                    var_320 = wp::where(var_312, var_124, var_286);
                    var_321 = wp::where(var_312, var_127, var_289);
                    var_322 = wp::where(var_312, var_129, var_291);
                    var_323 = wp::where(var_312, var_131, var_293);
                    var_324 = wp::where(var_312, var_136, var_298);
                    var_325 = wp::where(var_312, var_139, var_301);
                    var_326 = wp::where(var_312, var_142, var_304);
                    var_327 = wp::where(var_312, var_145, var_307);
                    var_328 = wp::where(var_312, var_147, var_309);
                    var_329 = wp::where(var_312, var_149, var_311);
                }
                var_330 = wp::where(var_294, var_313, var_278);
                var_331 = wp::where(var_294, var_314, var_279);
                var_332 = wp::where(var_294, var_315, var_280);
                var_333 = wp::where(var_294, var_316, var_281);
                var_334 = wp::where(var_294, var_317, var_282);
                var_335 = wp::where(var_294, var_318, var_283);
                var_336 = wp::where(var_294, var_319, var_284);
                var_337 = wp::where(var_294, var_320, var_286);
                var_338 = wp::where(var_294, var_321, var_289);
                var_339 = wp::where(var_294, var_322, var_291);
                var_340 = wp::where(var_294, var_323, var_293);
                var_341 = wp::where(var_294, var_324, var_136);
                var_342 = wp::where(var_294, var_325, var_139);
                var_343 = wp::where(var_294, var_326, var_142);
                var_344 = wp::where(var_294, var_327, var_145);
                var_345 = wp::where(var_294, var_328, var_147);
                var_346 = wp::where(var_294, var_329, var_149);
                // if dist < max_query_radius:                                                    <L 1624>
                var_347 = (var_340 < var_max_query_radius);
                if (var_347) {
                    // edge_buffer_offset = edge_colliding_edges_offsets[e_index]                 <L 1625>
                    var_348 = wp::address(var_edge_colliding_edges_offsets, var_0);
                    var_350 = wp::load(var_348);
                    var_349 = wp::copy(var_350);
                    // edge_buffer_size = edge_colliding_edges_offsets[e_index + 1] - edge_buffer_offset       <L 1626>
                    var_352 = wp::add(var_0, var_351);
                    var_353 = wp::address(var_edge_colliding_edges_offsets, var_352);
                    var_355 = wp::load(var_353);
                    var_354 = wp::sub(var_355, var_349);
                    // min_dis_to_edges = wp.min(min_dis_to_edges, dist)                          <L 1629>
                    var_356 = wp::min(var_41, var_340);
                    // if edge_num_collisions < edge_buffer_size:                                 <L 1630>
                    var_357 = (var_40 < var_354);
                    if (var_357) {
                        // edge_colliding_edges[2 * (edge_buffer_offset + edge_num_collisions)] = e_index       <L 1631>
                        var_359 = wp::add(var_349, var_40);
                        var_360 = wp::mul(var_358, var_359);
                        wp::array_store(var_edge_colliding_edges, var_360, var_0);
                        // edge_colliding_edges[2 * (edge_buffer_offset + edge_num_collisions) + 1] = colliding_edge_index       <L 1632>
                        var_362 = wp::add(var_349, var_40);
                        var_363 = wp::mul(var_361, var_362);
                        var_365 = wp::add(var_363, var_364);
                        wp::array_store(var_edge_colliding_edges, var_365, var_211);
                    }
                    if (!var_357) {
                        // resize_flags[EDGE_COLLISION_BUFFER_OVERFLOW_INDEX] = 1                 <L 1634>
                        wp::array_store(var_resize_flags, var_171, var_366);
                    }
                    // edge_num_collisions = edge_num_collisions + 1                              <L 1636>
                    var_368 = wp::add(var_40, var_367);
                }
                var_369 = wp::where(var_347, var_368, var_40);
                var_370 = wp::where(var_347, var_356, var_41);
                var_371 = wp::where(var_347, var_349, var_153);
                var_372 = wp::where(var_347, var_354, var_158);
                wp::assign(var_40, var_369);
                wp::assign(var_41, var_370);
                wp::assign(var_84, var_330);
                wp::assign(var_88, var_331);
                wp::assign(var_96, var_332);
                wp::assign(var_101, var_333);
                wp::assign(var_105, var_334);
                wp::assign(var_110, var_335);
                wp::assign(var_115, var_336);
                wp::assign(var_124, var_337);
                wp::assign(var_127, var_338);
                wp::assign(var_129, var_339);
                wp::assign(var_131, var_340);
                wp::assign(var_136, var_341);
                wp::assign(var_139, var_342);
                wp::assign(var_142, var_343);
                wp::assign(var_145, var_344);
                wp::assign(var_147, var_345);
                wp::assign(var_149, var_346);
                wp::assign(var_153, var_371);
                wp::assign(var_158, var_372);
        goto start_while_2;
        end_while_2:;
        }
        var_373 = wp::where(var_203, var_211, var_176);
        var_374 = wp::where(var_203, var_209, var_77);
        // edge_colliding_edges_count[e_index] = edge_num_collisions                              <L 1638>
        wp::array_store(var_edge_colliding_edges_count, var_0, var_40);
        // edge_colliding_edges_min_dist[e_index] = min_dis_to_edges                              <L 1639>
        wp::array_store(var_edge_colliding_edges_min_dist, var_0, var_41);
    }
}



extern "C" __global__ void edge_colliding_edges_detection_kernel_8b309277_cuda_kernel_backward(
    wp::launch_bounds_t<1> dim,
    wp::float32 var_max_query_radius,
    wp::float32 var_min_query_radius,
    wp::uint64 var_bvh_id,
    wp::array_t<wp::int32> var_bvh_group_roots,
    wp::array_t<wp::vec_t<3, wp::float32>> var_pos,
    wp::array_t<wp::int32> var_edge_indices,
    wp::array_t<wp::int32> var_particle_world,
    wp::int32 var_world_count,
    wp::array_t<wp::int32> var_edge_colliding_edges_offsets,
    wp::array_t<wp::int32> var_edge_colliding_edges_buffer_sizes,
    wp::float32 var_edge_edge_parallel_epsilon,
    wp::array_t<wp::int32> var_edge_filtering_list,
    wp::array_t<wp::int32> var_edge_filtering_list_offsets,
    wp::array_t<wp::vec_t<3, wp::float32>> var_min_distance_filtering_ref_pos,
    wp::array_t<wp::int32> var_edge_colliding_edges,
    wp::array_t<wp::int32> var_edge_colliding_edges_count,
    wp::array_t<wp::float32> var_edge_colliding_edges_min_dist,
    wp::array_t<wp::int32> var_resize_flags,
    wp::float32 adj_max_query_radius,
    wp::float32 adj_min_query_radius,
    wp::uint64 adj_bvh_id,
    wp::array_t<wp::int32> adj_bvh_group_roots,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_pos,
    wp::array_t<wp::int32> adj_edge_indices,
    wp::array_t<wp::int32> adj_particle_world,
    wp::int32 adj_world_count,
    wp::array_t<wp::int32> adj_edge_colliding_edges_offsets,
    wp::array_t<wp::int32> adj_edge_colliding_edges_buffer_sizes,
    wp::float32 adj_edge_edge_parallel_epsilon,
    wp::array_t<wp::int32> adj_edge_filtering_list,
    wp::array_t<wp::int32> adj_edge_filtering_list_offsets,
    wp::array_t<wp::vec_t<3, wp::float32>> adj_min_distance_filtering_ref_pos,
    wp::array_t<wp::int32> adj_edge_colliding_edges,
    wp::array_t<wp::int32> adj_edge_colliding_edges_count,
    wp::array_t<wp::float32> adj_edge_colliding_edges_min_dist,
    wp::array_t<wp::int32> adj_resize_flags)
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
        const wp::int32 var_1 = 2;
        wp::int32* var_2;
        wp::int32 var_3;
        wp::int32 var_4;
        const wp::int32 var_5 = 3;
        wp::int32* var_6;
        wp::int32 var_7;
        wp::int32 var_8;
        wp::vec_t<3, wp::float32>* var_9;
        wp::vec_t<3, wp::float32> var_10;
        wp::vec_t<3, wp::float32> var_11;
        wp::vec_t<3, wp::float32>* var_12;
        wp::vec_t<3, wp::float32> var_13;
        wp::vec_t<3, wp::float32> var_14;
        wp::vec_t<3, wp::float32> var_15;
        wp::vec_t<3, wp::float32> var_16;
        const wp::int32 var_17 = 0;
        wp::float32 var_18;
        wp::float32 var_19;
        const wp::int32 var_20 = 1;
        wp::float32 var_21;
        wp::float32 var_22;
        const wp::int32 var_23 = 2;
        wp::float32 var_24;
        wp::float32 var_25;
        wp::vec_t<3, wp::float32> var_26;
        const wp::int32 var_27 = 0;
        wp::float32 var_28;
        wp::float32 var_29;
        const wp::int32 var_30 = 1;
        wp::float32 var_31;
        wp::float32 var_32;
        const wp::int32 var_33 = 2;
        wp::float32 var_34;
        wp::float32 var_35;
        wp::vec_t<3, wp::float32> var_36;
        const wp::int32 var_37 = 0;
        wp::int32 var_38;
        const wp::int32 var_39 = 0;
        wp::int32 var_40;
        wp::float32 var_41;
        wp::int32* var_42;
        wp::int32 var_43;
        wp::int32 var_44;
        const wp::int32 var_45 = 0;
        const bool var_46 = false;
        bool var_47;
        const bool var_48 = false;
        bool var_49;
        const wp::int32 var_50 = -1;
        wp::int32 var_51;
        const wp::int32 var_52 = 0;
        bool var_53;
        const wp::int32 var_54 = 0;
        bool var_55;
        const bool var_56 = true;
        const bool var_57 = true;
        bool var_58;
        bool var_59;
        const wp::int32 var_60 = 0;
        bool var_61;
        wp::int32* var_62;
        wp::int32 var_63;
        wp::int32 var_64;
        wp::int32* var_65;
        wp::int32 var_66;
        wp::int32 var_67;
        wp::int32 var_68;
        const wp::int32 var_69 = 0;
        bool var_70;
        bool var_71;
        bool var_72;
        wp::int32 var_73;
        wp::bvh_query_t var_74;
        const wp::int32 var_75 = -1;
        wp::bvh_query_t var_76;
        wp::bvh_query_t var_77;
        const wp::int32 var_78 = 0;
        wp::int32 var_79;
        bool var_80;
        const wp::float32 var_81 = INFINITY;
        const wp::int32 var_82 = 2;
        wp::int32* var_83;
        wp::int32 var_84;
        wp::int32 var_85;
        const wp::int32 var_86 = 3;
        wp::int32* var_87;
        wp::int32 var_88;
        wp::int32 var_89;
        bool var_90;
        bool var_91;
        bool var_92;
        bool var_93;
        bool var_94;
        wp::int32* var_95;
        wp::int32 var_96;
        wp::int32 var_97;
        const wp::int32 var_98 = 1;
        wp::int32 var_99;
        wp::int32* var_100;
        wp::int32 var_101;
        wp::int32 var_102;
        bool var_103;
        wp::int32* var_104;
        wp::int32 var_105;
        wp::int32 var_106;
        const wp::int32 var_107 = 1;
        wp::int32 var_108;
        wp::int32* var_109;
        wp::int32 var_110;
        wp::int32 var_111;
        bool var_112;
        bool var_113;
        bool var_114;
        wp::int32 var_115;
        bool var_116;
        bool var_117;
        const wp::int32 var_118 = 1;
        wp::int32 var_119;
        wp::int32* var_120;
        bool var_121;
        wp::int32 var_122;
        wp::vec_t<3, wp::float32>* var_123;
        wp::vec_t<3, wp::float32> var_124;
        wp::vec_t<3, wp::float32> var_125;
        wp::vec_t<3, wp::float32>* var_126;
        wp::vec_t<3, wp::float32> var_127;
        wp::vec_t<3, wp::float32> var_128;
        wp::vec_t<3, wp::float32> var_129;
        const wp::int32 var_130 = 2;
        wp::float32 var_131;
        bool var_132;
        const wp::float32 var_133 = 0.0;
        bool var_134;
        wp::vec_t<3, wp::float32>* var_135;
        wp::vec_t<3, wp::float32> var_136;
        wp::vec_t<3, wp::float32> var_137;
        wp::vec_t<3, wp::float32>* var_138;
        wp::vec_t<3, wp::float32> var_139;
        wp::vec_t<3, wp::float32> var_140;
        wp::vec_t<3, wp::float32>* var_141;
        wp::vec_t<3, wp::float32> var_142;
        wp::vec_t<3, wp::float32> var_143;
        wp::vec_t<3, wp::float32>* var_144;
        wp::vec_t<3, wp::float32> var_145;
        wp::vec_t<3, wp::float32> var_146;
        wp::vec_t<3, wp::float32> var_147;
        const wp::int32 var_148 = 2;
        wp::float32 var_149;
        bool var_150;
        bool var_151;
        wp::int32* var_152;
        wp::int32 var_153;
        wp::int32 var_154;
        const wp::int32 var_155 = 1;
        wp::int32 var_156;
        wp::int32* var_157;
        wp::int32 var_158;
        wp::int32 var_159;
        wp::float32 var_160;
        bool var_161;
        const wp::int32 var_162 = 2;
        wp::int32 var_163;
        wp::int32 var_164;
        const wp::int32 var_165 = 2;
        wp::int32 var_166;
        wp::int32 var_167;
        const wp::int32 var_168 = 1;
        wp::int32 var_169;
        const wp::int32 var_170 = 1;
        const wp::int32 var_171 = 2;
        const wp::int32 var_172 = 1;
        wp::int32 var_173;
        wp::int32 var_174;
        wp::float32 var_175;
        wp::int32 var_176;
        const wp::int32 var_177 = 1;
        const bool var_178 = false;
        bool var_179;
        const bool var_180 = false;
        bool var_181;
        const wp::int32 var_182 = -1;
        wp::int32 var_183;
        const wp::int32 var_184 = 0;
        bool var_185;
        const wp::int32 var_186 = 0;
        bool var_187;
        const bool var_188 = true;
        const bool var_189 = true;
        bool var_190;
        bool var_191;
        const wp::int32 var_192 = 0;
        bool var_193;
        wp::int32* var_194;
        wp::int32 var_195;
        wp::int32 var_196;
        wp::int32* var_197;
        wp::int32 var_198;
        wp::int32 var_199;
        wp::int32 var_200;
        const wp::int32 var_201 = 0;
        bool var_202;
        bool var_203;
        bool var_204;
        wp::int32 var_205;
        wp::bvh_query_t var_206;
        const wp::int32 var_207 = -1;
        wp::bvh_query_t var_208;
        wp::bvh_query_t var_209;
        const wp::int32 var_210 = 0;
        wp::int32 var_211;
        bool var_212;
        const wp::float32 var_213 = INFINITY;
        const wp::int32 var_214 = 2;
        wp::int32* var_215;
        wp::int32 var_216;
        wp::int32 var_217;
        const wp::int32 var_218 = 3;
        wp::int32* var_219;
        wp::int32 var_220;
        wp::int32 var_221;
        bool var_222;
        bool var_223;
        bool var_224;
        bool var_225;
        bool var_226;
        wp::int32 var_227;
        wp::int32 var_228;
        wp::int32* var_229;
        wp::int32 var_230;
        wp::int32 var_231;
        const wp::int32 var_232 = 1;
        wp::int32 var_233;
        wp::int32* var_234;
        wp::int32 var_235;
        wp::int32 var_236;
        bool var_237;
        wp::int32* var_238;
        wp::int32 var_239;
        wp::int32 var_240;
        const wp::int32 var_241 = 1;
        wp::int32 var_242;
        wp::int32* var_243;
        wp::int32 var_244;
        wp::int32 var_245;
        bool var_246;
        bool var_247;
        bool var_248;
        wp::int32 var_249;
        bool var_250;
        bool var_251;
        const wp::int32 var_252 = 1;
        wp::int32 var_253;
        wp::int32* var_254;
        bool var_255;
        wp::int32 var_256;
        wp::int32 var_257;
        wp::int32 var_258;
        wp::int32 var_259;
        wp::int32 var_260;
        wp::int32 var_261;
        wp::int32 var_262;
        wp::int32 var_263;
        wp::int32 var_264;
        wp::int32 var_265;
        wp::int32 var_266;
        wp::int32 var_267;
        wp::int32 var_268;
        wp::int32 var_269;
        wp::int32 var_270;
        wp::int32 var_271;
        wp::int32 var_272;
        wp::int32 var_273;
        wp::int32 var_274;
        wp::int32 var_275;
        wp::int32 var_276;
        wp::int32 var_277;
        wp::int32 var_278;
        wp::int32 var_279;
        wp::int32 var_280;
        wp::int32 var_281;
        wp::int32 var_282;
        wp::int32 var_283;
        wp::int32 var_284;
        wp::vec_t<3, wp::float32>* var_285;
        wp::vec_t<3, wp::float32> var_286;
        wp::vec_t<3, wp::float32> var_287;
        wp::vec_t<3, wp::float32>* var_288;
        wp::vec_t<3, wp::float32> var_289;
        wp::vec_t<3, wp::float32> var_290;
        wp::vec_t<3, wp::float32> var_291;
        const wp::int32 var_292 = 2;
        wp::float32 var_293;
        bool var_294;
        const wp::float32 var_295 = 0.0;
        bool var_296;
        wp::vec_t<3, wp::float32>* var_297;
        wp::vec_t<3, wp::float32> var_298;
        wp::vec_t<3, wp::float32> var_299;
        wp::vec_t<3, wp::float32>* var_300;
        wp::vec_t<3, wp::float32> var_301;
        wp::vec_t<3, wp::float32> var_302;
        wp::vec_t<3, wp::float32>* var_303;
        wp::vec_t<3, wp::float32> var_304;
        wp::vec_t<3, wp::float32> var_305;
        wp::vec_t<3, wp::float32>* var_306;
        wp::vec_t<3, wp::float32> var_307;
        wp::vec_t<3, wp::float32> var_308;
        wp::vec_t<3, wp::float32> var_309;
        const wp::int32 var_310 = 2;
        wp::float32 var_311;
        bool var_312;
        wp::int32 var_313;
        wp::int32 var_314;
        wp::int32 var_315;
        wp::int32 var_316;
        wp::int32 var_317;
        wp::int32 var_318;
        wp::int32 var_319;
        wp::vec_t<3, wp::float32> var_320;
        wp::vec_t<3, wp::float32> var_321;
        wp::vec_t<3, wp::float32> var_322;
        wp::float32 var_323;
        wp::vec_t<3, wp::float32> var_324;
        wp::vec_t<3, wp::float32> var_325;
        wp::vec_t<3, wp::float32> var_326;
        wp::vec_t<3, wp::float32> var_327;
        wp::vec_t<3, wp::float32> var_328;
        wp::float32 var_329;
        wp::int32 var_330;
        wp::int32 var_331;
        wp::int32 var_332;
        wp::int32 var_333;
        wp::int32 var_334;
        wp::int32 var_335;
        wp::int32 var_336;
        wp::vec_t<3, wp::float32> var_337;
        wp::vec_t<3, wp::float32> var_338;
        wp::vec_t<3, wp::float32> var_339;
        wp::float32 var_340;
        wp::vec_t<3, wp::float32> var_341;
        wp::vec_t<3, wp::float32> var_342;
        wp::vec_t<3, wp::float32> var_343;
        wp::vec_t<3, wp::float32> var_344;
        wp::vec_t<3, wp::float32> var_345;
        wp::float32 var_346;
        bool var_347;
        wp::int32* var_348;
        wp::int32 var_349;
        wp::int32 var_350;
        const wp::int32 var_351 = 1;
        wp::int32 var_352;
        wp::int32* var_353;
        wp::int32 var_354;
        wp::int32 var_355;
        wp::float32 var_356;
        bool var_357;
        const wp::int32 var_358 = 2;
        wp::int32 var_359;
        wp::int32 var_360;
        const wp::int32 var_361 = 2;
        wp::int32 var_362;
        wp::int32 var_363;
        const wp::int32 var_364 = 1;
        wp::int32 var_365;
        const wp::int32 var_366 = 1;
        const wp::int32 var_367 = 1;
        wp::int32 var_368;
        wp::int32 var_369;
        wp::float32 var_370;
        wp::int32 var_371;
        wp::int32 var_372;
        wp::int32 var_373;
        wp::bvh_query_t var_374;
        //---------
        // dual vars
        wp::int32 adj_0 = {};
        wp::int32 adj_1 = {};
        wp::int32 adj_2 = {};
        wp::int32 adj_3 = {};
        wp::int32 adj_4 = {};
        wp::int32 adj_5 = {};
        wp::int32 adj_6 = {};
        wp::int32 adj_7 = {};
        wp::int32 adj_8 = {};
        wp::vec_t<3, wp::float32> adj_9 = {};
        wp::vec_t<3, wp::float32> adj_10 = {};
        wp::vec_t<3, wp::float32> adj_11 = {};
        wp::vec_t<3, wp::float32> adj_12 = {};
        wp::vec_t<3, wp::float32> adj_13 = {};
        wp::vec_t<3, wp::float32> adj_14 = {};
        wp::vec_t<3, wp::float32> adj_15 = {};
        wp::vec_t<3, wp::float32> adj_16 = {};
        wp::int32 adj_17 = {};
        wp::float32 adj_18 = {};
        wp::float32 adj_19 = {};
        wp::int32 adj_20 = {};
        wp::float32 adj_21 = {};
        wp::float32 adj_22 = {};
        wp::int32 adj_23 = {};
        wp::float32 adj_24 = {};
        wp::float32 adj_25 = {};
        wp::vec_t<3, wp::float32> adj_26 = {};
        wp::int32 adj_27 = {};
        wp::float32 adj_28 = {};
        wp::float32 adj_29 = {};
        wp::int32 adj_30 = {};
        wp::float32 adj_31 = {};
        wp::float32 adj_32 = {};
        wp::int32 adj_33 = {};
        wp::float32 adj_34 = {};
        wp::float32 adj_35 = {};
        wp::vec_t<3, wp::float32> adj_36 = {};
        wp::int32 adj_37 = {};
        wp::int32 adj_38 = {};
        wp::int32 adj_39 = {};
        wp::int32 adj_40 = {};
        wp::float32 adj_41 = {};
        wp::int32 adj_42 = {};
        wp::int32 adj_43 = {};
        wp::int32 adj_44 = {};
        wp::int32 adj_45 = {};
        bool adj_46 = {};
        bool adj_47 = {};
        bool adj_48 = {};
        bool adj_49 = {};
        wp::int32 adj_50 = {};
        wp::int32 adj_51 = {};
        wp::int32 adj_52 = {};
        bool adj_53 = {};
        wp::int32 adj_54 = {};
        bool adj_55 = {};
        bool adj_56 = {};
        bool adj_57 = {};
        bool adj_58 = {};
        bool adj_59 = {};
        wp::int32 adj_60 = {};
        bool adj_61 = {};
        wp::int32 adj_62 = {};
        wp::int32 adj_63 = {};
        wp::int32 adj_64 = {};
        wp::int32 adj_65 = {};
        wp::int32 adj_66 = {};
        wp::int32 adj_67 = {};
        wp::int32 adj_68 = {};
        wp::int32 adj_69 = {};
        bool adj_70 = {};
        bool adj_71 = {};
        bool adj_72 = {};
        wp::int32 adj_73 = {};
        wp::bvh_query_t adj_74 = {};
        wp::int32 adj_75 = {};
        wp::bvh_query_t adj_76 = {};
        wp::bvh_query_t adj_77 = {};
        wp::int32 adj_78 = {};
        wp::int32 adj_79 = {};
        bool adj_80 = {};
        wp::float32 adj_81 = {};
        wp::int32 adj_82 = {};
        wp::int32 adj_83 = {};
        wp::int32 adj_84 = {};
        wp::int32 adj_85 = {};
        wp::int32 adj_86 = {};
        wp::int32 adj_87 = {};
        wp::int32 adj_88 = {};
        wp::int32 adj_89 = {};
        bool adj_90 = {};
        bool adj_91 = {};
        bool adj_92 = {};
        bool adj_93 = {};
        bool adj_94 = {};
        wp::int32 adj_95 = {};
        wp::int32 adj_96 = {};
        wp::int32 adj_97 = {};
        wp::int32 adj_98 = {};
        wp::int32 adj_99 = {};
        wp::int32 adj_100 = {};
        wp::int32 adj_101 = {};
        wp::int32 adj_102 = {};
        bool adj_103 = {};
        wp::int32 adj_104 = {};
        wp::int32 adj_105 = {};
        wp::int32 adj_106 = {};
        wp::int32 adj_107 = {};
        wp::int32 adj_108 = {};
        wp::int32 adj_109 = {};
        wp::int32 adj_110 = {};
        wp::int32 adj_111 = {};
        bool adj_112 = {};
        bool adj_113 = {};
        bool adj_114 = {};
        wp::int32 adj_115 = {};
        bool adj_116 = {};
        bool adj_117 = {};
        wp::int32 adj_118 = {};
        wp::int32 adj_119 = {};
        wp::int32 adj_120 = {};
        bool adj_121 = {};
        wp::int32 adj_122 = {};
        wp::vec_t<3, wp::float32> adj_123 = {};
        wp::vec_t<3, wp::float32> adj_124 = {};
        wp::vec_t<3, wp::float32> adj_125 = {};
        wp::vec_t<3, wp::float32> adj_126 = {};
        wp::vec_t<3, wp::float32> adj_127 = {};
        wp::vec_t<3, wp::float32> adj_128 = {};
        wp::vec_t<3, wp::float32> adj_129 = {};
        wp::int32 adj_130 = {};
        wp::float32 adj_131 = {};
        bool adj_132 = {};
        wp::float32 adj_133 = {};
        bool adj_134 = {};
        wp::vec_t<3, wp::float32> adj_135 = {};
        wp::vec_t<3, wp::float32> adj_136 = {};
        wp::vec_t<3, wp::float32> adj_137 = {};
        wp::vec_t<3, wp::float32> adj_138 = {};
        wp::vec_t<3, wp::float32> adj_139 = {};
        wp::vec_t<3, wp::float32> adj_140 = {};
        wp::vec_t<3, wp::float32> adj_141 = {};
        wp::vec_t<3, wp::float32> adj_142 = {};
        wp::vec_t<3, wp::float32> adj_143 = {};
        wp::vec_t<3, wp::float32> adj_144 = {};
        wp::vec_t<3, wp::float32> adj_145 = {};
        wp::vec_t<3, wp::float32> adj_146 = {};
        wp::vec_t<3, wp::float32> adj_147 = {};
        wp::int32 adj_148 = {};
        wp::float32 adj_149 = {};
        bool adj_150 = {};
        bool adj_151 = {};
        wp::int32 adj_152 = {};
        wp::int32 adj_153 = {};
        wp::int32 adj_154 = {};
        wp::int32 adj_155 = {};
        wp::int32 adj_156 = {};
        wp::int32 adj_157 = {};
        wp::int32 adj_158 = {};
        wp::int32 adj_159 = {};
        wp::float32 adj_160 = {};
        bool adj_161 = {};
        wp::int32 adj_162 = {};
        wp::int32 adj_163 = {};
        wp::int32 adj_164 = {};
        wp::int32 adj_165 = {};
        wp::int32 adj_166 = {};
        wp::int32 adj_167 = {};
        wp::int32 adj_168 = {};
        wp::int32 adj_169 = {};
        wp::int32 adj_170 = {};
        wp::int32 adj_171 = {};
        wp::int32 adj_172 = {};
        wp::int32 adj_173 = {};
        wp::int32 adj_174 = {};
        wp::float32 adj_175 = {};
        wp::int32 adj_176 = {};
        wp::int32 adj_177 = {};
        bool adj_178 = {};
        bool adj_179 = {};
        bool adj_180 = {};
        bool adj_181 = {};
        wp::int32 adj_182 = {};
        wp::int32 adj_183 = {};
        wp::int32 adj_184 = {};
        bool adj_185 = {};
        wp::int32 adj_186 = {};
        bool adj_187 = {};
        bool adj_188 = {};
        bool adj_189 = {};
        bool adj_190 = {};
        bool adj_191 = {};
        wp::int32 adj_192 = {};
        bool adj_193 = {};
        wp::int32 adj_194 = {};
        wp::int32 adj_195 = {};
        wp::int32 adj_196 = {};
        wp::int32 adj_197 = {};
        wp::int32 adj_198 = {};
        wp::int32 adj_199 = {};
        wp::int32 adj_200 = {};
        wp::int32 adj_201 = {};
        bool adj_202 = {};
        bool adj_203 = {};
        bool adj_204 = {};
        wp::int32 adj_205 = {};
        wp::bvh_query_t adj_206 = {};
        wp::int32 adj_207 = {};
        wp::bvh_query_t adj_208 = {};
        wp::bvh_query_t adj_209 = {};
        wp::int32 adj_210 = {};
        wp::int32 adj_211 = {};
        bool adj_212 = {};
        wp::float32 adj_213 = {};
        wp::int32 adj_214 = {};
        wp::int32 adj_215 = {};
        wp::int32 adj_216 = {};
        wp::int32 adj_217 = {};
        wp::int32 adj_218 = {};
        wp::int32 adj_219 = {};
        wp::int32 adj_220 = {};
        wp::int32 adj_221 = {};
        bool adj_222 = {};
        bool adj_223 = {};
        bool adj_224 = {};
        bool adj_225 = {};
        bool adj_226 = {};
        wp::int32 adj_227 = {};
        wp::int32 adj_228 = {};
        wp::int32 adj_229 = {};
        wp::int32 adj_230 = {};
        wp::int32 adj_231 = {};
        wp::int32 adj_232 = {};
        wp::int32 adj_233 = {};
        wp::int32 adj_234 = {};
        wp::int32 adj_235 = {};
        wp::int32 adj_236 = {};
        bool adj_237 = {};
        wp::int32 adj_238 = {};
        wp::int32 adj_239 = {};
        wp::int32 adj_240 = {};
        wp::int32 adj_241 = {};
        wp::int32 adj_242 = {};
        wp::int32 adj_243 = {};
        wp::int32 adj_244 = {};
        wp::int32 adj_245 = {};
        bool adj_246 = {};
        bool adj_247 = {};
        bool adj_248 = {};
        wp::int32 adj_249 = {};
        bool adj_250 = {};
        bool adj_251 = {};
        wp::int32 adj_252 = {};
        wp::int32 adj_253 = {};
        wp::int32 adj_254 = {};
        bool adj_255 = {};
        wp::int32 adj_256 = {};
        wp::int32 adj_257 = {};
        wp::int32 adj_258 = {};
        wp::int32 adj_259 = {};
        wp::int32 adj_260 = {};
        wp::int32 adj_261 = {};
        wp::int32 adj_262 = {};
        wp::int32 adj_263 = {};
        wp::int32 adj_264 = {};
        wp::int32 adj_265 = {};
        wp::int32 adj_266 = {};
        wp::int32 adj_267 = {};
        wp::int32 adj_268 = {};
        wp::int32 adj_269 = {};
        wp::int32 adj_270 = {};
        wp::int32 adj_271 = {};
        wp::int32 adj_272 = {};
        wp::int32 adj_273 = {};
        wp::int32 adj_274 = {};
        wp::int32 adj_275 = {};
        wp::int32 adj_276 = {};
        wp::int32 adj_277 = {};
        wp::int32 adj_278 = {};
        wp::int32 adj_279 = {};
        wp::int32 adj_280 = {};
        wp::int32 adj_281 = {};
        wp::int32 adj_282 = {};
        wp::int32 adj_283 = {};
        wp::int32 adj_284 = {};
        wp::vec_t<3, wp::float32> adj_285 = {};
        wp::vec_t<3, wp::float32> adj_286 = {};
        wp::vec_t<3, wp::float32> adj_287 = {};
        wp::vec_t<3, wp::float32> adj_288 = {};
        wp::vec_t<3, wp::float32> adj_289 = {};
        wp::vec_t<3, wp::float32> adj_290 = {};
        wp::vec_t<3, wp::float32> adj_291 = {};
        wp::int32 adj_292 = {};
        wp::float32 adj_293 = {};
        bool adj_294 = {};
        wp::float32 adj_295 = {};
        bool adj_296 = {};
        wp::vec_t<3, wp::float32> adj_297 = {};
        wp::vec_t<3, wp::float32> adj_298 = {};
        wp::vec_t<3, wp::float32> adj_299 = {};
        wp::vec_t<3, wp::float32> adj_300 = {};
        wp::vec_t<3, wp::float32> adj_301 = {};
        wp::vec_t<3, wp::float32> adj_302 = {};
        wp::vec_t<3, wp::float32> adj_303 = {};
        wp::vec_t<3, wp::float32> adj_304 = {};
        wp::vec_t<3, wp::float32> adj_305 = {};
        wp::vec_t<3, wp::float32> adj_306 = {};
        wp::vec_t<3, wp::float32> adj_307 = {};
        wp::vec_t<3, wp::float32> adj_308 = {};
        wp::vec_t<3, wp::float32> adj_309 = {};
        wp::int32 adj_310 = {};
        wp::float32 adj_311 = {};
        bool adj_312 = {};
        wp::int32 adj_313 = {};
        wp::int32 adj_314 = {};
        wp::int32 adj_315 = {};
        wp::int32 adj_316 = {};
        wp::int32 adj_317 = {};
        wp::int32 adj_318 = {};
        wp::int32 adj_319 = {};
        wp::vec_t<3, wp::float32> adj_320 = {};
        wp::vec_t<3, wp::float32> adj_321 = {};
        wp::vec_t<3, wp::float32> adj_322 = {};
        wp::float32 adj_323 = {};
        wp::vec_t<3, wp::float32> adj_324 = {};
        wp::vec_t<3, wp::float32> adj_325 = {};
        wp::vec_t<3, wp::float32> adj_326 = {};
        wp::vec_t<3, wp::float32> adj_327 = {};
        wp::vec_t<3, wp::float32> adj_328 = {};
        wp::float32 adj_329 = {};
        wp::int32 adj_330 = {};
        wp::int32 adj_331 = {};
        wp::int32 adj_332 = {};
        wp::int32 adj_333 = {};
        wp::int32 adj_334 = {};
        wp::int32 adj_335 = {};
        wp::int32 adj_336 = {};
        wp::vec_t<3, wp::float32> adj_337 = {};
        wp::vec_t<3, wp::float32> adj_338 = {};
        wp::vec_t<3, wp::float32> adj_339 = {};
        wp::float32 adj_340 = {};
        wp::vec_t<3, wp::float32> adj_341 = {};
        wp::vec_t<3, wp::float32> adj_342 = {};
        wp::vec_t<3, wp::float32> adj_343 = {};
        wp::vec_t<3, wp::float32> adj_344 = {};
        wp::vec_t<3, wp::float32> adj_345 = {};
        wp::float32 adj_346 = {};
        bool adj_347 = {};
        wp::int32 adj_348 = {};
        wp::int32 adj_349 = {};
        wp::int32 adj_350 = {};
        wp::int32 adj_351 = {};
        wp::int32 adj_352 = {};
        wp::int32 adj_353 = {};
        wp::int32 adj_354 = {};
        wp::int32 adj_355 = {};
        wp::float32 adj_356 = {};
        bool adj_357 = {};
        wp::int32 adj_358 = {};
        wp::int32 adj_359 = {};
        wp::int32 adj_360 = {};
        wp::int32 adj_361 = {};
        wp::int32 adj_362 = {};
        wp::int32 adj_363 = {};
        wp::int32 adj_364 = {};
        wp::int32 adj_365 = {};
        wp::int32 adj_366 = {};
        wp::int32 adj_367 = {};
        wp::int32 adj_368 = {};
        wp::int32 adj_369 = {};
        wp::float32 adj_370 = {};
        wp::int32 adj_371 = {};
        wp::int32 adj_372 = {};
        wp::int32 adj_373 = {};
        wp::bvh_query_t adj_374 = {};
        //---------
        // forward
        // def edge_colliding_edges_detection_kernel(                                             <L 1500>
        // e_index = wp.tid()                                                                     <L 1538>
        var_0 = builtin_tid1d();
        // e0_v0 = edge_indices[e_index, 2]                                                       <L 1540>
        var_2 = wp::address(var_edge_indices, var_0, var_1);
        var_4 = wp::load(var_2);
        var_3 = wp::copy(var_4);
        // e0_v1 = edge_indices[e_index, 3]                                                       <L 1541>
        var_6 = wp::address(var_edge_indices, var_0, var_5);
        var_8 = wp::load(var_6);
        var_7 = wp::copy(var_8);
        // e0_v0_pos = pos[e0_v0]                                                                 <L 1543>
        var_9 = wp::address(var_pos, var_3);
        var_11 = wp::load(var_9);
        var_10 = wp::copy(var_11);
        // e0_v1_pos = pos[e0_v1]                                                                 <L 1544>
        var_12 = wp::address(var_pos, var_7);
        var_14 = wp::load(var_12);
        var_13 = wp::copy(var_14);
        // lower = wp.min(e0_v0_pos, e0_v1_pos)                                                   <L 1546>
        var_15 = wp::min(var_10, var_13);
        // upper = wp.max(e0_v0_pos, e0_v1_pos)                                                   <L 1547>
        var_16 = wp::max(var_10, var_13);
        // lower = wp.vec3(lower[0] - max_query_radius, lower[1] - max_query_radius, lower[2] - max_query_radius)       <L 1549>
        var_18 = wp::extract(var_15, var_17);
        var_19 = wp::sub(var_18, var_max_query_radius);
        var_21 = wp::extract(var_15, var_20);
        var_22 = wp::sub(var_21, var_max_query_radius);
        var_24 = wp::extract(var_15, var_23);
        var_25 = wp::sub(var_24, var_max_query_radius);
        var_26 = wp::vec_t<3, wp::float32>(var_19, var_22, var_25);
        // upper = wp.vec3(upper[0] + max_query_radius, upper[1] + max_query_radius, upper[2] + max_query_radius)       <L 1550>
        var_28 = wp::extract(var_16, var_27);
        var_29 = wp::add(var_28, var_max_query_radius);
        var_31 = wp::extract(var_16, var_30);
        var_32 = wp::add(var_31, var_max_query_radius);
        var_34 = wp::extract(var_16, var_33);
        var_35 = wp::add(var_34, var_max_query_radius);
        var_36 = wp::vec_t<3, wp::float32>(var_29, var_32, var_35);
        // colliding_edge_index = wp.int32(0)                                                     <L 1552>
        var_38 = wp::int32(var_37);
        // edge_num_collisions = wp.int32(0)                                                      <L 1553>
        var_40 = wp::int32(var_39);
        // min_dis_to_edges = max_query_radius                                                    <L 1554>
        var_41 = wp::copy(var_max_query_radius);
        // edge_world = particle_world[e0_v0]                                                     <L 1555>
        var_42 = wp::address(var_particle_world, var_3);
        var_44 = wp::load(var_42);
        var_43 = wp::copy(var_44);
        // for query_pass in range(2):                                                            <L 1561>
        // run_query = bool(False)                                                                <L 1562>
        var_47 = bool(var_46);
        // query_all = bool(False)                                                                <L 1563>
        var_49 = bool(var_48);
        // group_root = wp.int32(-1)                                                              <L 1564>
        var_51 = wp::int32(var_50);
        // if edge_world < 0:                                                                     <L 1566>
        var_53 = (var_43 < var_52);
        if (var_53) {
            // if query_pass == 0:                                                                <L 1567>
            var_55 = (var_45 == var_54);
            if (var_55) {
                // run_query = True                                                               <L 1568>
                // query_all = True                                                               <L 1569>
            }
            var_58 = wp::where(var_55, var_56, var_47);
            var_59 = wp::where(var_55, var_57, var_49);
        }
        if (!var_53) {
            // if query_pass == 0:                                                                <L 1571>
            var_61 = (var_45 == var_60);
            if (var_61) {
                // group_root = bvh_group_roots[edge_world]                                       <L 1572>
                var_62 = wp::address(var_bvh_group_roots, var_43);
                var_64 = wp::load(var_62);
                var_63 = wp::copy(var_64);
            }
            if (!var_61) {
                // group_root = bvh_group_roots[world_count]                                      <L 1574>
                var_65 = wp::address(var_bvh_group_roots, var_world_count);
                var_67 = wp::load(var_65);
                var_66 = wp::copy(var_67);
            }
            var_68 = wp::where(var_61, var_63, var_66);
            // run_query = group_root >= 0                                                        <L 1575>
            var_70 = (var_68 >= var_69);
        }
        var_71 = wp::where(var_53, var_58, var_70);
        var_72 = wp::where(var_53, var_59, var_49);
        var_73 = wp::where(var_53, var_51, var_68);
        // if run_query:                                                                          <L 1577>
        if (var_71) {
            // if query_all:                                                                      <L 1578>
            if (var_72) {
                // query = wp.bvh_query_aabb(bvh_id, lower, upper)                                <L 1579>
                var_74 = wp::bvh_query_aabb(var_bvh_id, var_26, var_36, var_75);
            }
            if (!var_72) {
                // query = wp.bvh_query_aabb(bvh_id, lower, upper, group_root)                    <L 1581>
                var_76 = wp::bvh_query_aabb(var_bvh_id, var_26, var_36, var_73);
            }
            var_77 = wp::where(var_72, var_74, var_76);
            // colliding_edge_index = wp.int32(0)                                                 <L 1583>
            var_79 = wp::int32(var_78);
            // while wp.bvh_query_next(query, colliding_edge_index):                              <L 1584>
        }
        var_176 = wp::where(var_71, var_79, var_38);
        // run_query = bool(False)                                                                <L 1562>
        var_179 = bool(var_178);
        // query_all = bool(False)                                                                <L 1563>
        var_181 = bool(var_180);
        // group_root = wp.int32(-1)                                                              <L 1564>
        var_183 = wp::int32(var_182);
        // if edge_world < 0:                                                                     <L 1566>
        var_185 = (var_43 < var_184);
        if (var_185) {
            // if query_pass == 0:                                                                <L 1567>
            var_187 = (var_177 == var_186);
            if (var_187) {
                // run_query = True                                                               <L 1568>
                // query_all = True                                                               <L 1569>
            }
            var_190 = wp::where(var_187, var_188, var_179);
            var_191 = wp::where(var_187, var_189, var_181);
        }
        if (!var_185) {
            // if query_pass == 0:                                                                <L 1571>
            var_193 = (var_177 == var_192);
            if (var_193) {
                // group_root = bvh_group_roots[edge_world]                                       <L 1572>
                var_194 = wp::address(var_bvh_group_roots, var_43);
                var_196 = wp::load(var_194);
                var_195 = wp::copy(var_196);
            }
            if (!var_193) {
                // group_root = bvh_group_roots[world_count]                                      <L 1574>
                var_197 = wp::address(var_bvh_group_roots, var_world_count);
                var_199 = wp::load(var_197);
                var_198 = wp::copy(var_199);
            }
            var_200 = wp::where(var_193, var_195, var_198);
            // run_query = group_root >= 0                                                        <L 1575>
            var_202 = (var_200 >= var_201);
        }
        var_203 = wp::where(var_185, var_190, var_202);
        var_204 = wp::where(var_185, var_191, var_181);
        var_205 = wp::where(var_185, var_183, var_200);
        // if run_query:                                                                          <L 1577>
        if (var_203) {
            // if query_all:                                                                      <L 1578>
            if (var_204) {
                // query = wp.bvh_query_aabb(bvh_id, lower, upper)                                <L 1579>
                var_206 = wp::bvh_query_aabb(var_bvh_id, var_26, var_36, var_207);
            }
            if (!var_204) {
                // query = wp.bvh_query_aabb(bvh_id, lower, upper, group_root)                    <L 1581>
                var_208 = wp::bvh_query_aabb(var_bvh_id, var_26, var_36, var_205);
            }
            var_209 = wp::where(var_204, var_206, var_208);
            // colliding_edge_index = wp.int32(0)                                                 <L 1583>
            var_211 = wp::int32(var_210);
            // while wp.bvh_query_next(query, colliding_edge_index):                              <L 1584>
        }
        var_373 = wp::where(var_203, var_211, var_176);
        var_374 = wp::where(var_203, var_209, var_77);
        // edge_colliding_edges_count[e_index] = edge_num_collisions                              <L 1638>
        // wp::array_store(var_edge_colliding_edges_count, var_0, var_40);
        // edge_colliding_edges_min_dist[e_index] = min_dis_to_edges                              <L 1639>
        // wp::array_store(var_edge_colliding_edges_min_dist, var_0, var_41);
        //---------
        // reverse
        wp::adj_array_store(var_edge_colliding_edges_min_dist, var_0, var_41, adj_edge_colliding_edges_min_dist, adj_0, adj_41);
        // adj: edge_colliding_edges_min_dist[e_index] = min_dis_to_edges                         <L 1639>
        wp::adj_array_store(var_edge_colliding_edges_count, var_0, var_40, adj_edge_colliding_edges_count, adj_0, adj_40);
        // adj: edge_colliding_edges_count[e_index] = edge_num_collisions                         <L 1638>
        wp::adj_where(var_203, var_209, var_77, adj_203, adj_209, adj_77, adj_374);
        wp::adj_where(var_203, var_211, var_176, adj_203, adj_211, adj_176, adj_373);
        if (var_203) {
        start_while_2:;
            var_212 = wp::bvh_query_next(var_209, var_211, var_213);
        if ((var_212) == false) goto end_while_2;
        adj_214 = {};
        adj_215 = {};
        adj_216 = {};
        adj_217 = {};
        adj_218 = {};
        adj_219 = {};
        adj_220 = {};
        adj_221 = {};
        adj_222 = {};
        adj_223 = {};
        adj_224 = {};
        adj_225 = {};
        adj_226 = {};
        adj_227 = {};
        adj_228 = {};
        adj_229 = {};
        adj_230 = {};
        adj_231 = {};
        adj_232 = {};
        adj_233 = {};
        adj_234 = {};
        adj_235 = {};
        adj_236 = {};
        adj_237 = {};
        adj_238 = {};
        adj_239 = {};
        adj_240 = {};
        adj_241 = {};
        adj_242 = {};
        adj_243 = {};
        adj_244 = {};
        adj_245 = {};
        adj_246 = {};
        adj_247 = {};
        adj_248 = {};
        adj_249 = {};
        adj_250 = {};
        adj_251 = {};
        adj_252 = {};
        adj_253 = {};
        adj_254 = {};
        adj_255 = {};
        adj_256 = {};
        adj_257 = {};
        adj_258 = {};
        adj_259 = {};
        adj_260 = {};
        adj_261 = {};
        adj_262 = {};
        adj_263 = {};
        adj_264 = {};
        adj_265 = {};
        adj_266 = {};
        adj_267 = {};
        adj_268 = {};
        adj_269 = {};
        adj_270 = {};
        adj_271 = {};
        adj_272 = {};
        adj_273 = {};
        adj_274 = {};
        adj_275 = {};
        adj_276 = {};
        adj_277 = {};
        adj_278 = {};
        adj_279 = {};
        adj_280 = {};
        adj_281 = {};
        adj_282 = {};
        adj_283 = {};
        adj_284 = {};
        adj_285 = {};
        adj_286 = {};
        adj_287 = {};
        adj_288 = {};
        adj_289 = {};
        adj_290 = {};
        adj_291 = {};
        adj_292 = {};
        adj_293 = {};
        adj_294 = {};
        adj_295 = {};
        adj_296 = {};
        adj_297 = {};
        adj_298 = {};
        adj_299 = {};
        adj_300 = {};
        adj_301 = {};
        adj_302 = {};
        adj_303 = {};
        adj_304 = {};
        adj_305 = {};
        adj_306 = {};
        adj_307 = {};
        adj_308 = {};
        adj_309 = {};
        adj_310 = {};
        adj_311 = {};
        adj_312 = {};
        adj_313 = {};
        adj_314 = {};
        adj_315 = {};
        adj_316 = {};
        adj_317 = {};
        adj_318 = {};
        adj_319 = {};
        adj_320 = {};
        adj_321 = {};
        adj_322 = {};
        adj_323 = {};
        adj_324 = {};
        adj_325 = {};
        adj_326 = {};
        adj_327 = {};
        adj_328 = {};
        adj_329 = {};
        adj_330 = {};
        adj_331 = {};
        adj_332 = {};
        adj_333 = {};
        adj_334 = {};
        adj_335 = {};
        adj_336 = {};
        adj_337 = {};
        adj_338 = {};
        adj_339 = {};
        adj_340 = {};
        adj_341 = {};
        adj_342 = {};
        adj_343 = {};
        adj_344 = {};
        adj_345 = {};
        adj_346 = {};
        adj_347 = {};
        adj_348 = {};
        adj_349 = {};
        adj_350 = {};
        adj_351 = {};
        adj_352 = {};
        adj_353 = {};
        adj_354 = {};
        adj_355 = {};
        adj_356 = {};
        adj_357 = {};
        adj_358 = {};
        adj_359 = {};
        adj_360 = {};
        adj_361 = {};
        adj_362 = {};
        adj_363 = {};
        adj_364 = {};
        adj_365 = {};
        adj_366 = {};
        adj_367 = {};
        adj_368 = {};
        adj_369 = {};
        adj_370 = {};
        adj_371 = {};
        adj_372 = {};
                // e1_v0 = edge_indices[colliding_edge_index, 2]                                  <L 1585>
                var_215 = wp::address(var_edge_indices, var_211, var_214);
                var_217 = wp::load(var_215);
                var_216 = wp::copy(var_217);
                // e1_v1 = edge_indices[colliding_edge_index, 3]                                  <L 1586>
                var_219 = wp::address(var_edge_indices, var_211, var_218);
                var_221 = wp::load(var_219);
                var_220 = wp::copy(var_221);
                // if e0_v0 == e1_v0 or e0_v0 == e1_v1 or e0_v1 == e1_v0 or e0_v1 == e1_v1:       <L 1588>
                var_223 = (var_3 == var_216);
                var_222 = var_223;
                if (!var_222) {
                    var_224 = (var_3 == var_220);
                    var_222 = var_222 || var_224;
                }
                if (!var_222) {
                    var_225 = (var_7 == var_216);
                    var_222 = var_222 || var_225;
                }
                if (!var_222) {
                    var_226 = (var_7 == var_220);
                    var_222 = var_222 || var_226;
                }
                if (var_222) {
                    // continue                                                                   <L 1589>
                    wp::assign(var_84, var_216);
                    wp::assign(var_88, var_220);
                    goto start_while_2;
                }
                var_227 = wp::where(var_222, var_84, var_216);
                var_228 = wp::where(var_222, var_88, var_220);
                // if edge_filtering_list:                                                        <L 1591>
                if (var_edge_filtering_list) {
                    // fl_start = edge_filtering_list_offsets[e_index]                            <L 1592>
                    var_229 = wp::address(var_edge_filtering_list_offsets, var_0);
                    var_231 = wp::load(var_229);
                    var_230 = wp::copy(var_231);
                    // fl_end = edge_filtering_list_offsets[e_index + 1]  # start of next vertex slice (end exclusive)       <L 1593>
                    var_233 = wp::add(var_0, var_232);
                    var_234 = wp::address(var_edge_filtering_list_offsets, var_233);
                    var_236 = wp::load(var_234);
                    var_235 = wp::copy(var_236);
                    // if fl_end > fl_start:                                                      <L 1595>
                    var_237 = (var_235 > var_230);
                    if (var_237) {
                        // first_val = edge_filtering_list[fl_start]                              <L 1597>
                        var_238 = wp::address(var_edge_filtering_list, var_230);
                        var_240 = wp::load(var_238);
                        var_239 = wp::copy(var_240);
                        // last_val = edge_filtering_list[fl_end - 1]                             <L 1598>
                        var_242 = wp::sub(var_235, var_241);
                        var_243 = wp::address(var_edge_filtering_list, var_242);
                        var_245 = wp::load(var_243);
                        var_244 = wp::copy(var_245);
                        // if (colliding_edge_index >= first_val) and (colliding_edge_index <= last_val):       <L 1599>
                        var_247 = (var_211 >= var_239);
                        var_246 = var_247;
                        if (var_246) {
                            var_248 = (var_211 <= var_244);
                            var_246 = var_246 && var_248;
                        }
                        if (var_246) {
                            // idx = binary_search(edge_filtering_list, colliding_edge_index, fl_start, fl_end)       <L 1600>
                            var_249 = binary_search_0(var_edge_filtering_list, var_211, var_230, var_235);
                            // if idx > fl_start and edge_filtering_list[idx - 1] == colliding_edge_index:       <L 1601>
                            var_251 = (var_249 > var_230);
                            var_250 = var_251;
                            if (var_250) {
                                var_253 = wp::sub(var_249, var_252);
                                var_254 = wp::address(var_edge_filtering_list, var_253);
                                var_256 = wp::load(var_254);
                                var_255 = (var_256 == var_211);
                                var_250 = var_250 && var_255;
                            }
                            if (var_250) {
                                // continue                                                       <L 1602>
                                wp::assign(var_84, var_227);
                                wp::assign(var_88, var_228);
                                wp::assign(var_96, var_230);
                                wp::assign(var_101, var_235);
                                wp::assign(var_105, var_239);
                                wp::assign(var_110, var_244);
                                wp::assign(var_115, var_249);
                                goto start_while_2;
                            }
                            var_257 = wp::where(var_250, var_84, var_227);
                            var_258 = wp::where(var_250, var_88, var_228);
                            var_259 = wp::where(var_250, var_96, var_230);
                            var_260 = wp::where(var_250, var_101, var_235);
                            var_261 = wp::where(var_250, var_105, var_239);
                            var_262 = wp::where(var_250, var_110, var_244);
                            var_263 = wp::where(var_250, var_115, var_249);
                        }
                        var_264 = wp::where(var_246, var_257, var_227);
                        var_265 = wp::where(var_246, var_258, var_228);
                        var_266 = wp::where(var_246, var_259, var_230);
                        var_267 = wp::where(var_246, var_260, var_235);
                        var_268 = wp::where(var_246, var_261, var_239);
                        var_269 = wp::where(var_246, var_262, var_244);
                        var_270 = wp::where(var_246, var_263, var_115);
                    }
                    var_271 = wp::where(var_237, var_264, var_227);
                    var_272 = wp::where(var_237, var_265, var_228);
                    var_273 = wp::where(var_237, var_266, var_230);
                    var_274 = wp::where(var_237, var_267, var_235);
                    var_275 = wp::where(var_237, var_268, var_105);
                    var_276 = wp::where(var_237, var_269, var_110);
                    var_277 = wp::where(var_237, var_270, var_115);
                }
                var_278 = wp::where(var_edge_filtering_list, var_271, var_227);
                var_279 = wp::where(var_edge_filtering_list, var_272, var_228);
                var_280 = wp::where(var_edge_filtering_list, var_273, var_96);
                var_281 = wp::where(var_edge_filtering_list, var_274, var_101);
                var_282 = wp::where(var_edge_filtering_list, var_275, var_105);
                var_283 = wp::where(var_edge_filtering_list, var_276, var_110);
                var_284 = wp::where(var_edge_filtering_list, var_277, var_115);
                // e1_v0_pos = pos[e1_v0]                                                         <L 1605>
                var_285 = wp::address(var_pos, var_278);
                var_287 = wp::load(var_285);
                var_286 = wp::copy(var_287);
                // e1_v1_pos = pos[e1_v1]                                                         <L 1606>
                var_288 = wp::address(var_pos, var_279);
                var_290 = wp::load(var_288);
                var_289 = wp::copy(var_290);
                // std = wp.closest_point_edge_edge(e0_v0_pos, e0_v1_pos, e1_v0_pos, e1_v1_pos, edge_edge_parallel_epsilon)       <L 1608>
                var_291 = wp::closest_point_edge_edge(var_10, var_13, var_286, var_289, var_edge_edge_parallel_epsilon);
                // dist = std[2]                                                                  <L 1609>
                var_293 = wp::extract(var_291, var_292);
                // if min_distance_filtering_ref_pos and min_query_radius > 0.0:                  <L 1611>
                var_294 = var_min_distance_filtering_ref_pos;
                if (var_294) {
                    var_296 = (var_min_query_radius > var_295);
                    var_294 = var_294 && var_296;
                }
                if (var_294) {
                    // e0_v0_pos_ref = min_distance_filtering_ref_pos[e0_v0]                      <L 1612>
                    var_297 = wp::address(var_min_distance_filtering_ref_pos, var_3);
                    var_299 = wp::load(var_297);
                    var_298 = wp::copy(var_299);
                    // e0_v1_pos_ref = min_distance_filtering_ref_pos[e0_v1]                      <L 1613>
                    var_300 = wp::address(var_min_distance_filtering_ref_pos, var_7);
                    var_302 = wp::load(var_300);
                    var_301 = wp::copy(var_302);
                    // e1_v0_pos_ref = min_distance_filtering_ref_pos[e1_v0]                      <L 1614>
                    var_303 = wp::address(var_min_distance_filtering_ref_pos, var_278);
                    var_305 = wp::load(var_303);
                    var_304 = wp::copy(var_305);
                    // e1_v1_pos_ref = min_distance_filtering_ref_pos[e1_v1]                      <L 1615>
                    var_306 = wp::address(var_min_distance_filtering_ref_pos, var_279);
                    var_308 = wp::load(var_306);
                    var_307 = wp::copy(var_308);
                    // std_ref = wp.closest_point_edge_edge(                                      <L 1616>
                    // e0_v0_pos_ref, e0_v1_pos_ref, e1_v0_pos_ref, e1_v1_pos_ref, edge_edge_parallel_epsilon       <L 1617>
                    var_309 = wp::closest_point_edge_edge(var_298, var_301, var_304, var_307, var_edge_edge_parallel_epsilon);
                    // dist_ref = std_ref[2]                                                      <L 1620>
                    var_311 = wp::extract(var_309, var_310);
                    // if dist_ref < min_query_radius:                                            <L 1621>
                    var_312 = (var_311 < var_min_query_radius);
                    if (var_312) {
                        // continue                                                               <L 1622>
                        wp::assign(var_84, var_278);
                        wp::assign(var_88, var_279);
                        wp::assign(var_96, var_280);
                        wp::assign(var_101, var_281);
                        wp::assign(var_105, var_282);
                        wp::assign(var_110, var_283);
                        wp::assign(var_115, var_284);
                        wp::assign(var_124, var_286);
                        wp::assign(var_127, var_289);
                        wp::assign(var_129, var_291);
                        wp::assign(var_131, var_293);
                        wp::assign(var_136, var_298);
                        wp::assign(var_139, var_301);
                        wp::assign(var_142, var_304);
                        wp::assign(var_145, var_307);
                        wp::assign(var_147, var_309);
                        wp::assign(var_149, var_311);
                        goto start_while_2;
                    }
                    var_313 = wp::where(var_312, var_84, var_278);
                    var_314 = wp::where(var_312, var_88, var_279);
                    var_315 = wp::where(var_312, var_96, var_280);
                    var_316 = wp::where(var_312, var_101, var_281);
                    var_317 = wp::where(var_312, var_105, var_282);
                    var_318 = wp::where(var_312, var_110, var_283);
                    var_319 = wp::where(var_312, var_115, var_284);
                    var_320 = wp::where(var_312, var_124, var_286);
                    var_321 = wp::where(var_312, var_127, var_289);
                    var_322 = wp::where(var_312, var_129, var_291);
                    var_323 = wp::where(var_312, var_131, var_293);
                    var_324 = wp::where(var_312, var_136, var_298);
                    var_325 = wp::where(var_312, var_139, var_301);
                    var_326 = wp::where(var_312, var_142, var_304);
                    var_327 = wp::where(var_312, var_145, var_307);
                    var_328 = wp::where(var_312, var_147, var_309);
                    var_329 = wp::where(var_312, var_149, var_311);
                }
                var_330 = wp::where(var_294, var_313, var_278);
                var_331 = wp::where(var_294, var_314, var_279);
                var_332 = wp::where(var_294, var_315, var_280);
                var_333 = wp::where(var_294, var_316, var_281);
                var_334 = wp::where(var_294, var_317, var_282);
                var_335 = wp::where(var_294, var_318, var_283);
                var_336 = wp::where(var_294, var_319, var_284);
                var_337 = wp::where(var_294, var_320, var_286);
                var_338 = wp::where(var_294, var_321, var_289);
                var_339 = wp::where(var_294, var_322, var_291);
                var_340 = wp::where(var_294, var_323, var_293);
                var_341 = wp::where(var_294, var_324, var_136);
                var_342 = wp::where(var_294, var_325, var_139);
                var_343 = wp::where(var_294, var_326, var_142);
                var_344 = wp::where(var_294, var_327, var_145);
                var_345 = wp::where(var_294, var_328, var_147);
                var_346 = wp::where(var_294, var_329, var_149);
                // if dist < max_query_radius:                                                    <L 1624>
                var_347 = (var_340 < var_max_query_radius);
                if (var_347) {
                    // edge_buffer_offset = edge_colliding_edges_offsets[e_index]                 <L 1625>
                    var_348 = wp::address(var_edge_colliding_edges_offsets, var_0);
                    var_350 = wp::load(var_348);
                    var_349 = wp::copy(var_350);
                    // edge_buffer_size = edge_colliding_edges_offsets[e_index + 1] - edge_buffer_offset       <L 1626>
                    var_352 = wp::add(var_0, var_351);
                    var_353 = wp::address(var_edge_colliding_edges_offsets, var_352);
                    var_355 = wp::load(var_353);
                    var_354 = wp::sub(var_355, var_349);
                    // min_dis_to_edges = wp.min(min_dis_to_edges, dist)                          <L 1629>
                    var_356 = wp::min(var_41, var_340);
                    // if edge_num_collisions < edge_buffer_size:                                 <L 1630>
                    var_357 = (var_40 < var_354);
                    if (var_357) {
                        // edge_colliding_edges[2 * (edge_buffer_offset + edge_num_collisions)] = e_index       <L 1631>
                        var_359 = wp::add(var_349, var_40);
                        var_360 = wp::mul(var_358, var_359);
                        // wp::array_store(var_edge_colliding_edges, var_360, var_0);
                        // edge_colliding_edges[2 * (edge_buffer_offset + edge_num_collisions) + 1] = colliding_edge_index       <L 1632>
                        var_362 = wp::add(var_349, var_40);
                        var_363 = wp::mul(var_361, var_362);
                        var_365 = wp::add(var_363, var_364);
                        // wp::array_store(var_edge_colliding_edges, var_365, var_211);
                    }
                    if (!var_357) {
                        // resize_flags[EDGE_COLLISION_BUFFER_OVERFLOW_INDEX] = 1                 <L 1634>
                        // wp::array_store(var_resize_flags, var_171, var_366);
                    }
                    // edge_num_collisions = edge_num_collisions + 1                              <L 1636>
                    var_368 = wp::add(var_40, var_367);
                }
                var_369 = wp::where(var_347, var_368, var_40);
                var_370 = wp::where(var_347, var_356, var_41);
                var_371 = wp::where(var_347, var_349, var_153);
                var_372 = wp::where(var_347, var_354, var_158);
                wp::assign(var_40, var_369);
                wp::assign(var_41, var_370);
                wp::assign(var_84, var_330);
                wp::assign(var_88, var_331);
                wp::assign(var_96, var_332);
                wp::assign(var_101, var_333);
                wp::assign(var_105, var_334);
                wp::assign(var_110, var_335);
                wp::assign(var_115, var_336);
                wp::assign(var_124, var_337);
                wp::assign(var_127, var_338);
                wp::assign(var_129, var_339);
                wp::assign(var_131, var_340);
                wp::assign(var_136, var_341);
                wp::assign(var_139, var_342);
                wp::assign(var_142, var_343);
                wp::assign(var_145, var_344);
                wp::assign(var_147, var_345);
                wp::assign(var_149, var_346);
                wp::assign(var_153, var_371);
                wp::assign(var_158, var_372);
                wp::adj_assign(var_158, var_372, adj_158, adj_372);
                wp::adj_assign(var_153, var_371, adj_153, adj_371);
                wp::adj_assign(var_149, var_346, adj_149, adj_346);
                wp::adj_assign(var_147, var_345, adj_147, adj_345);
                wp::adj_assign(var_145, var_344, adj_145, adj_344);
                wp::adj_assign(var_142, var_343, adj_142, adj_343);
                wp::adj_assign(var_139, var_342, adj_139, adj_342);
                wp::adj_assign(var_136, var_341, adj_136, adj_341);
                wp::adj_assign(var_131, var_340, adj_131, adj_340);
                wp::adj_assign(var_129, var_339, adj_129, adj_339);
                wp::adj_assign(var_127, var_338, adj_127, adj_338);
                wp::adj_assign(var_124, var_337, adj_124, adj_337);
                wp::adj_assign(var_115, var_336, adj_115, adj_336);
                wp::adj_assign(var_110, var_335, adj_110, adj_335);
                wp::adj_assign(var_105, var_334, adj_105, adj_334);
                wp::adj_assign(var_101, var_333, adj_101, adj_333);
                wp::adj_assign(var_96, var_332, adj_96, adj_332);
                wp::adj_assign(var_88, var_331, adj_88, adj_331);
                wp::adj_assign(var_84, var_330, adj_84, adj_330);
                wp::adj_assign(var_41, var_370, adj_41, adj_370);
                wp::adj_assign(var_40, var_369, adj_40, adj_369);
                wp::adj_where(var_347, var_354, var_158, adj_347, adj_354, adj_158, adj_372);
                wp::adj_where(var_347, var_349, var_153, adj_347, adj_349, adj_153, adj_371);
                wp::adj_where(var_347, var_356, var_41, adj_347, adj_356, adj_41, adj_370);
                wp::adj_where(var_347, var_368, var_40, adj_347, adj_368, adj_40, adj_369);
                if (var_347) {
                    wp::adj_add(var_40, var_367, adj_40, adj_367, adj_368);
                    // adj: edge_num_collisions = edge_num_collisions + 1                         <L 1636>
                    if (!var_357) {
                        wp::adj_array_store(var_resize_flags, var_171, var_366, adj_resize_flags, adj_171, adj_366);
                        // adj: resize_flags[EDGE_COLLISION_BUFFER_OVERFLOW_INDEX] = 1            <L 1634>
                    }
                    if (var_357) {
                        wp::adj_array_store(var_edge_colliding_edges, var_365, var_211, adj_edge_colliding_edges, adj_365, adj_211);
                        wp::adj_add(var_363, var_364, adj_363, adj_364, adj_365);
                        wp::adj_mul(var_361, var_362, adj_361, adj_362, adj_363);
                        wp::adj_add(var_349, var_40, adj_349, adj_40, adj_362);
                        // adj: edge_colliding_edges[2 * (edge_buffer_offset + edge_num_collisions) + 1] = colliding_edge_index  <L 1632>
                        wp::adj_array_store(var_edge_colliding_edges, var_360, var_0, adj_edge_colliding_edges, adj_360, adj_0);
                        wp::adj_mul(var_358, var_359, adj_358, adj_359, adj_360);
                        wp::adj_add(var_349, var_40, adj_349, adj_40, adj_359);
                        // adj: edge_colliding_edges[2 * (edge_buffer_offset + edge_num_collisions)] = e_index  <L 1631>
                    }
                    // adj: if edge_num_collisions < edge_buffer_size:                            <L 1630>
                    wp::adj_min(var_41, var_340, adj_41, adj_340, adj_356);
                    // adj: min_dis_to_edges = wp.min(min_dis_to_edges, dist)                     <L 1629>
                    wp::adj_sub(var_355, var_349, adj_353, adj_349, adj_354);
                    wp::adj_address(var_edge_colliding_edges_offsets, var_352, adj_edge_colliding_edges_offsets, adj_352, adj_353);
                    wp::adj_add(var_0, var_351, adj_0, adj_351, adj_352);
                    // adj: edge_buffer_size = edge_colliding_edges_offsets[e_index + 1] - edge_buffer_offset  <L 1626>
                    wp::adj_copy(var_350, adj_348, adj_349);
                    wp::adj_address(var_edge_colliding_edges_offsets, var_0, adj_edge_colliding_edges_offsets, adj_0, adj_348);
                    // adj: edge_buffer_offset = edge_colliding_edges_offsets[e_index]            <L 1625>
                }
                // adj: if dist < max_query_radius:                                               <L 1624>
                wp::adj_where(var_294, var_329, var_149, adj_294, adj_329, adj_149, adj_346);
                wp::adj_where(var_294, var_328, var_147, adj_294, adj_328, adj_147, adj_345);
                wp::adj_where(var_294, var_327, var_145, adj_294, adj_327, adj_145, adj_344);
                wp::adj_where(var_294, var_326, var_142, adj_294, adj_326, adj_142, adj_343);
                wp::adj_where(var_294, var_325, var_139, adj_294, adj_325, adj_139, adj_342);
                wp::adj_where(var_294, var_324, var_136, adj_294, adj_324, adj_136, adj_341);
                wp::adj_where(var_294, var_323, var_293, adj_294, adj_323, adj_293, adj_340);
                wp::adj_where(var_294, var_322, var_291, adj_294, adj_322, adj_291, adj_339);
                wp::adj_where(var_294, var_321, var_289, adj_294, adj_321, adj_289, adj_338);
                wp::adj_where(var_294, var_320, var_286, adj_294, adj_320, adj_286, adj_337);
                wp::adj_where(var_294, var_319, var_284, adj_294, adj_319, adj_284, adj_336);
                wp::adj_where(var_294, var_318, var_283, adj_294, adj_318, adj_283, adj_335);
                wp::adj_where(var_294, var_317, var_282, adj_294, adj_317, adj_282, adj_334);
                wp::adj_where(var_294, var_316, var_281, adj_294, adj_316, adj_281, adj_333);
                wp::adj_where(var_294, var_315, var_280, adj_294, adj_315, adj_280, adj_332);
                wp::adj_where(var_294, var_314, var_279, adj_294, adj_314, adj_279, adj_331);
                wp::adj_where(var_294, var_313, var_278, adj_294, adj_313, adj_278, adj_330);
                if (var_294) {
                    wp::adj_where(var_312, var_149, var_311, adj_312, adj_149, adj_311, adj_329);
                    wp::adj_where(var_312, var_147, var_309, adj_312, adj_147, adj_309, adj_328);
                    wp::adj_where(var_312, var_145, var_307, adj_312, adj_145, adj_307, adj_327);
                    wp::adj_where(var_312, var_142, var_304, adj_312, adj_142, adj_304, adj_326);
                    wp::adj_where(var_312, var_139, var_301, adj_312, adj_139, adj_301, adj_325);
                    wp::adj_where(var_312, var_136, var_298, adj_312, adj_136, adj_298, adj_324);
                    wp::adj_where(var_312, var_131, var_293, adj_312, adj_131, adj_293, adj_323);
                    wp::adj_where(var_312, var_129, var_291, adj_312, adj_129, adj_291, adj_322);
                    wp::adj_where(var_312, var_127, var_289, adj_312, adj_127, adj_289, adj_321);
                    wp::adj_where(var_312, var_124, var_286, adj_312, adj_124, adj_286, adj_320);
                    wp::adj_where(var_312, var_115, var_284, adj_312, adj_115, adj_284, adj_319);
                    wp::adj_where(var_312, var_110, var_283, adj_312, adj_110, adj_283, adj_318);
                    wp::adj_where(var_312, var_105, var_282, adj_312, adj_105, adj_282, adj_317);
                    wp::adj_where(var_312, var_101, var_281, adj_312, adj_101, adj_281, adj_316);
                    wp::adj_where(var_312, var_96, var_280, adj_312, adj_96, adj_280, adj_315);
                    wp::adj_where(var_312, var_88, var_279, adj_312, adj_88, adj_279, adj_314);
                    wp::adj_where(var_312, var_84, var_278, adj_312, adj_84, adj_278, adj_313);
                    if (var_312) {
                        wp::adj_assign(var_149, var_311, adj_149, adj_311);
                        wp::adj_assign(var_147, var_309, adj_147, adj_309);
                        wp::adj_assign(var_145, var_307, adj_145, adj_307);
                        wp::adj_assign(var_142, var_304, adj_142, adj_304);
                        wp::adj_assign(var_139, var_301, adj_139, adj_301);
                        wp::adj_assign(var_136, var_298, adj_136, adj_298);
                        wp::adj_assign(var_131, var_293, adj_131, adj_293);
                        wp::adj_assign(var_129, var_291, adj_129, adj_291);
                        wp::adj_assign(var_127, var_289, adj_127, adj_289);
                        wp::adj_assign(var_124, var_286, adj_124, adj_286);
                        wp::adj_assign(var_115, var_284, adj_115, adj_284);
                        wp::adj_assign(var_110, var_283, adj_110, adj_283);
                        wp::adj_assign(var_105, var_282, adj_105, adj_282);
                        wp::adj_assign(var_101, var_281, adj_101, adj_281);
                        wp::adj_assign(var_96, var_280, adj_96, adj_280);
                        wp::adj_assign(var_88, var_279, adj_88, adj_279);
                        wp::adj_assign(var_84, var_278, adj_84, adj_278);
                        // adj: continue                                                          <L 1622>
                    }
                    // adj: if dist_ref < min_query_radius:                                       <L 1621>
                    wp::adj_extract(var_309, var_310, adj_309, adj_310, adj_311);
                    // adj: dist_ref = std_ref[2]                                                 <L 1620>
                    wp::adj_closest_point_edge_edge(var_298, var_301, var_304, var_307, var_edge_edge_parallel_epsilon, adj_298, adj_301, adj_304, adj_307, adj_edge_edge_parallel_epsilon, adj_309);
                    // adj: e0_v0_pos_ref, e0_v1_pos_ref, e1_v0_pos_ref, e1_v1_pos_ref, edge_edge_parallel_epsilon  <L 1617>
                    // adj: std_ref = wp.closest_point_edge_edge(                                 <L 1616>
                    wp::adj_copy(var_308, adj_306, adj_307);
                    wp::adj_address(var_min_distance_filtering_ref_pos, var_279, adj_min_distance_filtering_ref_pos, adj_279, adj_306);
                    // adj: e1_v1_pos_ref = min_distance_filtering_ref_pos[e1_v1]                 <L 1615>
                    wp::adj_copy(var_305, adj_303, adj_304);
                    wp::adj_address(var_min_distance_filtering_ref_pos, var_278, adj_min_distance_filtering_ref_pos, adj_278, adj_303);
                    // adj: e1_v0_pos_ref = min_distance_filtering_ref_pos[e1_v0]                 <L 1614>
                    wp::adj_copy(var_302, adj_300, adj_301);
                    wp::adj_address(var_min_distance_filtering_ref_pos, var_7, adj_min_distance_filtering_ref_pos, adj_7, adj_300);
                    // adj: e0_v1_pos_ref = min_distance_filtering_ref_pos[e0_v1]                 <L 1613>
                    wp::adj_copy(var_299, adj_297, adj_298);
                    wp::adj_address(var_min_distance_filtering_ref_pos, var_3, adj_min_distance_filtering_ref_pos, adj_3, adj_297);
                    // adj: e0_v0_pos_ref = min_distance_filtering_ref_pos[e0_v0]                 <L 1612>
                }
                if (var_294) {
                }
                // adj: if min_distance_filtering_ref_pos and min_query_radius > 0.0:             <L 1611>
                wp::adj_extract(var_291, var_292, adj_291, adj_292, adj_293);
                // adj: dist = std[2]                                                             <L 1609>
                wp::adj_closest_point_edge_edge(var_10, var_13, var_286, var_289, var_edge_edge_parallel_epsilon, adj_10, adj_13, adj_286, adj_289, adj_edge_edge_parallel_epsilon, adj_291);
                // adj: std = wp.closest_point_edge_edge(e0_v0_pos, e0_v1_pos, e1_v0_pos, e1_v1_pos, edge_edge_parallel_epsilon)  <L 1608>
                wp::adj_copy(var_290, adj_288, adj_289);
                wp::adj_address(var_pos, var_279, adj_pos, adj_279, adj_288);
                // adj: e1_v1_pos = pos[e1_v1]                                                    <L 1606>
                wp::adj_copy(var_287, adj_285, adj_286);
                wp::adj_address(var_pos, var_278, adj_pos, adj_278, adj_285);
                // adj: e1_v0_pos = pos[e1_v0]                                                    <L 1605>
                wp::adj_where(var_edge_filtering_list, var_277, var_115, adj_edge_filtering_list, adj_277, adj_115, adj_284);
                wp::adj_where(var_edge_filtering_list, var_276, var_110, adj_edge_filtering_list, adj_276, adj_110, adj_283);
                wp::adj_where(var_edge_filtering_list, var_275, var_105, adj_edge_filtering_list, adj_275, adj_105, adj_282);
                wp::adj_where(var_edge_filtering_list, var_274, var_101, adj_edge_filtering_list, adj_274, adj_101, adj_281);
                wp::adj_where(var_edge_filtering_list, var_273, var_96, adj_edge_filtering_list, adj_273, adj_96, adj_280);
                wp::adj_where(var_edge_filtering_list, var_272, var_228, adj_edge_filtering_list, adj_272, adj_228, adj_279);
                wp::adj_where(var_edge_filtering_list, var_271, var_227, adj_edge_filtering_list, adj_271, adj_227, adj_278);
                if (var_edge_filtering_list) {
                    wp::adj_where(var_237, var_270, var_115, adj_237, adj_270, adj_115, adj_277);
                    wp::adj_where(var_237, var_269, var_110, adj_237, adj_269, adj_110, adj_276);
                    wp::adj_where(var_237, var_268, var_105, adj_237, adj_268, adj_105, adj_275);
                    wp::adj_where(var_237, var_267, var_235, adj_237, adj_267, adj_235, adj_274);
                    wp::adj_where(var_237, var_266, var_230, adj_237, adj_266, adj_230, adj_273);
                    wp::adj_where(var_237, var_265, var_228, adj_237, adj_265, adj_228, adj_272);
                    wp::adj_where(var_237, var_264, var_227, adj_237, adj_264, adj_227, adj_271);
                    if (var_237) {
                        wp::adj_where(var_246, var_263, var_115, adj_246, adj_263, adj_115, adj_270);
                        wp::adj_where(var_246, var_262, var_244, adj_246, adj_262, adj_244, adj_269);
                        wp::adj_where(var_246, var_261, var_239, adj_246, adj_261, adj_239, adj_268);
                        wp::adj_where(var_246, var_260, var_235, adj_246, adj_260, adj_235, adj_267);
                        wp::adj_where(var_246, var_259, var_230, adj_246, adj_259, adj_230, adj_266);
                        wp::adj_where(var_246, var_258, var_228, adj_246, adj_258, adj_228, adj_265);
                        wp::adj_where(var_246, var_257, var_227, adj_246, adj_257, adj_227, adj_264);
                        if (var_246) {
                            wp::adj_where(var_250, var_115, var_249, adj_250, adj_115, adj_249, adj_263);
                            wp::adj_where(var_250, var_110, var_244, adj_250, adj_110, adj_244, adj_262);
                            wp::adj_where(var_250, var_105, var_239, adj_250, adj_105, adj_239, adj_261);
                            wp::adj_where(var_250, var_101, var_235, adj_250, adj_101, adj_235, adj_260);
                            wp::adj_where(var_250, var_96, var_230, adj_250, adj_96, adj_230, adj_259);
                            wp::adj_where(var_250, var_88, var_228, adj_250, adj_88, adj_228, adj_258);
                            wp::adj_where(var_250, var_84, var_227, adj_250, adj_84, adj_227, adj_257);
                            if (var_250) {
                                wp::adj_assign(var_115, var_249, adj_115, adj_249);
                                wp::adj_assign(var_110, var_244, adj_110, adj_244);
                                wp::adj_assign(var_105, var_239, adj_105, adj_239);
                                wp::adj_assign(var_101, var_235, adj_101, adj_235);
                                wp::adj_assign(var_96, var_230, adj_96, adj_230);
                                wp::adj_assign(var_88, var_228, adj_88, adj_228);
                                wp::adj_assign(var_84, var_227, adj_84, adj_227);
                                // adj: continue                                                  <L 1602>
                            }
                            if (var_250) {
                                wp::adj_address(var_edge_filtering_list, var_253, adj_edge_filtering_list, adj_253, adj_254);
                                wp::adj_sub(var_249, var_252, adj_249, adj_252, adj_253);
                            }
                            // adj: if idx > fl_start and edge_filtering_list[idx - 1] == colliding_edge_index:  <L 1601>
                            adj_binary_search_0(var_edge_filtering_list, var_211, var_230, var_235, adj_edge_filtering_list, adj_211, adj_230, adj_235, adj_249);
                            // adj: idx = binary_search(edge_filtering_list, colliding_edge_index, fl_start, fl_end)  <L 1600>
                        }
                        if (var_246) {
                        }
                        // adj: if (colliding_edge_index >= first_val) and (colliding_edge_index <= last_val):  <L 1599>
                        wp::adj_copy(var_245, adj_243, adj_244);
                        wp::adj_address(var_edge_filtering_list, var_242, adj_edge_filtering_list, adj_242, adj_243);
                        wp::adj_sub(var_235, var_241, adj_235, adj_241, adj_242);
                        // adj: last_val = edge_filtering_list[fl_end - 1]                        <L 1598>
                        wp::adj_copy(var_240, adj_238, adj_239);
                        wp::adj_address(var_edge_filtering_list, var_230, adj_edge_filtering_list, adj_230, adj_238);
                        // adj: first_val = edge_filtering_list[fl_start]                         <L 1597>
                    }
                    // adj: if fl_end > fl_start:                                                 <L 1595>
                    wp::adj_copy(var_236, adj_234, adj_235);
                    wp::adj_address(var_edge_filtering_list_offsets, var_233, adj_edge_filtering_list_offsets, adj_233, adj_234);
                    wp::adj_add(var_0, var_232, adj_0, adj_232, adj_233);
                    // adj: fl_end = edge_filtering_list_offsets[e_index + 1]  # start of next vertex slice (end exclusive)  <L 1593>
                    wp::adj_copy(var_231, adj_229, adj_230);
                    wp::adj_address(var_edge_filtering_list_offsets, var_0, adj_edge_filtering_list_offsets, adj_0, adj_229);
                    // adj: fl_start = edge_filtering_list_offsets[e_index]                       <L 1592>
                }
                // adj: if edge_filtering_list:                                                   <L 1591>
                wp::adj_where(var_222, var_88, var_220, adj_222, adj_88, adj_220, adj_228);
                wp::adj_where(var_222, var_84, var_216, adj_222, adj_84, adj_216, adj_227);
                if (var_222) {
                    wp::adj_assign(var_88, var_220, adj_88, adj_220);
                    wp::adj_assign(var_84, var_216, adj_84, adj_216);
                    // adj: continue                                                              <L 1589>
                }
                if (!var_222) {
                }
                if (!var_222) {
                }
                if (!var_222) {
                }
                // adj: if e0_v0 == e1_v0 or e0_v0 == e1_v1 or e0_v1 == e1_v0 or e0_v1 == e1_v1:  <L 1588>
                wp::adj_copy(var_221, adj_219, adj_220);
                wp::adj_address(var_edge_indices, var_211, var_218, adj_edge_indices, adj_211, adj_218, adj_219);
                // adj: e1_v1 = edge_indices[colliding_edge_index, 3]                             <L 1586>
                wp::adj_copy(var_217, adj_215, adj_216);
                wp::adj_address(var_edge_indices, var_211, var_214, adj_edge_indices, adj_211, adj_214, adj_215);
                // adj: e1_v0 = edge_indices[colliding_edge_index, 2]                             <L 1585>
        goto start_while_2;
        end_while_2:;
            // adj: while wp.bvh_query_next(query, colliding_edge_index):                         <L 1584>
            // adj: colliding_edge_index = wp.int32(0)                                            <L 1583>
            wp::adj_where(var_204, var_206, var_208, adj_204, adj_206, adj_208, adj_209);
            if (!var_204) {
                // adj: query = wp.bvh_query_aabb(bvh_id, lower, upper, group_root)               <L 1581>
            }
            if (var_204) {
                // adj: query = wp.bvh_query_aabb(bvh_id, lower, upper)                           <L 1579>
            }
            // adj: if query_all:                                                                 <L 1578>
        }
        // adj: if run_query:                                                                     <L 1577>
        wp::adj_where(var_185, var_183, var_200, adj_185, adj_183, adj_200, adj_205);
        wp::adj_where(var_185, var_191, var_181, adj_185, adj_191, adj_181, adj_204);
        wp::adj_where(var_185, var_190, var_202, adj_185, adj_190, adj_202, adj_203);
        if (!var_185) {
            // adj: run_query = group_root >= 0                                                   <L 1575>
            wp::adj_where(var_193, var_195, var_198, adj_193, adj_195, adj_198, adj_200);
            if (!var_193) {
                wp::adj_copy(var_199, adj_197, adj_198);
                wp::adj_address(var_bvh_group_roots, var_world_count, adj_bvh_group_roots, adj_world_count, adj_197);
                // adj: group_root = bvh_group_roots[world_count]                                 <L 1574>
            }
            if (var_193) {
                wp::adj_copy(var_196, adj_194, adj_195);
                wp::adj_address(var_bvh_group_roots, var_43, adj_bvh_group_roots, adj_43, adj_194);
                // adj: group_root = bvh_group_roots[edge_world]                                  <L 1572>
            }
            // adj: if query_pass == 0:                                                           <L 1571>
        }
        if (var_185) {
            wp::adj_where(var_187, var_189, var_181, adj_187, adj_189, adj_181, adj_191);
            wp::adj_where(var_187, var_188, var_179, adj_187, adj_188, adj_179, adj_190);
            if (var_187) {
                // adj: query_all = True                                                          <L 1569>
                // adj: run_query = True                                                          <L 1568>
            }
            // adj: if query_pass == 0:                                                           <L 1567>
        }
        // adj: if edge_world < 0:                                                                <L 1566>
        // adj: group_root = wp.int32(-1)                                                         <L 1564>
        // adj: query_all = bool(False)                                                           <L 1563>
        // adj: run_query = bool(False)                                                           <L 1562>
        wp::adj_where(var_71, var_79, var_38, adj_71, adj_79, adj_38, adj_176);
        if (var_71) {
        start_while_0:;
            var_80 = wp::bvh_query_next(var_77, var_79, var_81);
        if ((var_80) == false) goto end_while_0;
        adj_82 = {};
        adj_83 = {};
        adj_84 = {};
        adj_85 = {};
        adj_86 = {};
        adj_87 = {};
        adj_88 = {};
        adj_89 = {};
        adj_90 = {};
        adj_91 = {};
        adj_92 = {};
        adj_93 = {};
        adj_94 = {};
        adj_95 = {};
        adj_96 = {};
        adj_97 = {};
        adj_98 = {};
        adj_99 = {};
        adj_100 = {};
        adj_101 = {};
        adj_102 = {};
        adj_103 = {};
        adj_104 = {};
        adj_105 = {};
        adj_106 = {};
        adj_107 = {};
        adj_108 = {};
        adj_109 = {};
        adj_110 = {};
        adj_111 = {};
        adj_112 = {};
        adj_113 = {};
        adj_114 = {};
        adj_115 = {};
        adj_116 = {};
        adj_117 = {};
        adj_118 = {};
        adj_119 = {};
        adj_120 = {};
        adj_121 = {};
        adj_122 = {};
        adj_123 = {};
        adj_124 = {};
        adj_125 = {};
        adj_126 = {};
        adj_127 = {};
        adj_128 = {};
        adj_129 = {};
        adj_130 = {};
        adj_131 = {};
        adj_132 = {};
        adj_133 = {};
        adj_134 = {};
        adj_135 = {};
        adj_136 = {};
        adj_137 = {};
        adj_138 = {};
        adj_139 = {};
        adj_140 = {};
        adj_141 = {};
        adj_142 = {};
        adj_143 = {};
        adj_144 = {};
        adj_145 = {};
        adj_146 = {};
        adj_147 = {};
        adj_148 = {};
        adj_149 = {};
        adj_150 = {};
        adj_151 = {};
        adj_152 = {};
        adj_153 = {};
        adj_154 = {};
        adj_155 = {};
        adj_156 = {};
        adj_157 = {};
        adj_158 = {};
        adj_159 = {};
        adj_160 = {};
        adj_161 = {};
        adj_162 = {};
        adj_163 = {};
        adj_164 = {};
        adj_165 = {};
        adj_166 = {};
        adj_167 = {};
        adj_168 = {};
        adj_169 = {};
        adj_170 = {};
        adj_171 = {};
        adj_172 = {};
        adj_173 = {};
        adj_174 = {};
        adj_175 = {};
                // e1_v0 = edge_indices[colliding_edge_index, 2]                                  <L 1585>
                var_83 = wp::address(var_edge_indices, var_79, var_82);
                var_85 = wp::load(var_83);
                var_84 = wp::copy(var_85);
                // e1_v1 = edge_indices[colliding_edge_index, 3]                                  <L 1586>
                var_87 = wp::address(var_edge_indices, var_79, var_86);
                var_89 = wp::load(var_87);
                var_88 = wp::copy(var_89);
                // if e0_v0 == e1_v0 or e0_v0 == e1_v1 or e0_v1 == e1_v0 or e0_v1 == e1_v1:       <L 1588>
                var_91 = (var_3 == var_84);
                var_90 = var_91;
                if (!var_90) {
                    var_92 = (var_3 == var_88);
                    var_90 = var_90 || var_92;
                }
                if (!var_90) {
                    var_93 = (var_7 == var_84);
                    var_90 = var_90 || var_93;
                }
                if (!var_90) {
                    var_94 = (var_7 == var_88);
                    var_90 = var_90 || var_94;
                }
                if (var_90) {
                    // continue                                                                   <L 1589>
                    goto start_while_0;
                }
                // if edge_filtering_list:                                                        <L 1591>
                if (var_edge_filtering_list) {
                    // fl_start = edge_filtering_list_offsets[e_index]                            <L 1592>
                    var_95 = wp::address(var_edge_filtering_list_offsets, var_0);
                    var_97 = wp::load(var_95);
                    var_96 = wp::copy(var_97);
                    // fl_end = edge_filtering_list_offsets[e_index + 1]  # start of next vertex slice (end exclusive)       <L 1593>
                    var_99 = wp::add(var_0, var_98);
                    var_100 = wp::address(var_edge_filtering_list_offsets, var_99);
                    var_102 = wp::load(var_100);
                    var_101 = wp::copy(var_102);
                    // if fl_end > fl_start:                                                      <L 1595>
                    var_103 = (var_101 > var_96);
                    if (var_103) {
                        // first_val = edge_filtering_list[fl_start]                              <L 1597>
                        var_104 = wp::address(var_edge_filtering_list, var_96);
                        var_106 = wp::load(var_104);
                        var_105 = wp::copy(var_106);
                        // last_val = edge_filtering_list[fl_end - 1]                             <L 1598>
                        var_108 = wp::sub(var_101, var_107);
                        var_109 = wp::address(var_edge_filtering_list, var_108);
                        var_111 = wp::load(var_109);
                        var_110 = wp::copy(var_111);
                        // if (colliding_edge_index >= first_val) and (colliding_edge_index <= last_val):       <L 1599>
                        var_113 = (var_79 >= var_105);
                        var_112 = var_113;
                        if (var_112) {
                            var_114 = (var_79 <= var_110);
                            var_112 = var_112 && var_114;
                        }
                        if (var_112) {
                            // idx = binary_search(edge_filtering_list, colliding_edge_index, fl_start, fl_end)       <L 1600>
                            var_115 = binary_search_0(var_edge_filtering_list, var_79, var_96, var_101);
                            // if idx > fl_start and edge_filtering_list[idx - 1] == colliding_edge_index:       <L 1601>
                            var_117 = (var_115 > var_96);
                            var_116 = var_117;
                            if (var_116) {
                                var_119 = wp::sub(var_115, var_118);
                                var_120 = wp::address(var_edge_filtering_list, var_119);
                                var_122 = wp::load(var_120);
                                var_121 = (var_122 == var_79);
                                var_116 = var_116 && var_121;
                            }
                            if (var_116) {
                                // continue                                                       <L 1602>
                                goto start_while_0;
                            }
                        }
                    }
                }
                // e1_v0_pos = pos[e1_v0]                                                         <L 1605>
                var_123 = wp::address(var_pos, var_84);
                var_125 = wp::load(var_123);
                var_124 = wp::copy(var_125);
                // e1_v1_pos = pos[e1_v1]                                                         <L 1606>
                var_126 = wp::address(var_pos, var_88);
                var_128 = wp::load(var_126);
                var_127 = wp::copy(var_128);
                // std = wp.closest_point_edge_edge(e0_v0_pos, e0_v1_pos, e1_v0_pos, e1_v1_pos, edge_edge_parallel_epsilon)       <L 1608>
                var_129 = wp::closest_point_edge_edge(var_10, var_13, var_124, var_127, var_edge_edge_parallel_epsilon);
                // dist = std[2]                                                                  <L 1609>
                var_131 = wp::extract(var_129, var_130);
                // if min_distance_filtering_ref_pos and min_query_radius > 0.0:                  <L 1611>
                var_132 = var_min_distance_filtering_ref_pos;
                if (var_132) {
                    var_134 = (var_min_query_radius > var_133);
                    var_132 = var_132 && var_134;
                }
                if (var_132) {
                    // e0_v0_pos_ref = min_distance_filtering_ref_pos[e0_v0]                      <L 1612>
                    var_135 = wp::address(var_min_distance_filtering_ref_pos, var_3);
                    var_137 = wp::load(var_135);
                    var_136 = wp::copy(var_137);
                    // e0_v1_pos_ref = min_distance_filtering_ref_pos[e0_v1]                      <L 1613>
                    var_138 = wp::address(var_min_distance_filtering_ref_pos, var_7);
                    var_140 = wp::load(var_138);
                    var_139 = wp::copy(var_140);
                    // e1_v0_pos_ref = min_distance_filtering_ref_pos[e1_v0]                      <L 1614>
                    var_141 = wp::address(var_min_distance_filtering_ref_pos, var_84);
                    var_143 = wp::load(var_141);
                    var_142 = wp::copy(var_143);
                    // e1_v1_pos_ref = min_distance_filtering_ref_pos[e1_v1]                      <L 1615>
                    var_144 = wp::address(var_min_distance_filtering_ref_pos, var_88);
                    var_146 = wp::load(var_144);
                    var_145 = wp::copy(var_146);
                    // std_ref = wp.closest_point_edge_edge(                                      <L 1616>
                    // e0_v0_pos_ref, e0_v1_pos_ref, e1_v0_pos_ref, e1_v1_pos_ref, edge_edge_parallel_epsilon       <L 1617>
                    var_147 = wp::closest_point_edge_edge(var_136, var_139, var_142, var_145, var_edge_edge_parallel_epsilon);
                    // dist_ref = std_ref[2]                                                      <L 1620>
                    var_149 = wp::extract(var_147, var_148);
                    // if dist_ref < min_query_radius:                                            <L 1621>
                    var_150 = (var_149 < var_min_query_radius);
                    if (var_150) {
                        // continue                                                               <L 1622>
                        goto start_while_0;
                    }
                }
                // if dist < max_query_radius:                                                    <L 1624>
                var_151 = (var_131 < var_max_query_radius);
                if (var_151) {
                    // edge_buffer_offset = edge_colliding_edges_offsets[e_index]                 <L 1625>
                    var_152 = wp::address(var_edge_colliding_edges_offsets, var_0);
                    var_154 = wp::load(var_152);
                    var_153 = wp::copy(var_154);
                    // edge_buffer_size = edge_colliding_edges_offsets[e_index + 1] - edge_buffer_offset       <L 1626>
                    var_156 = wp::add(var_0, var_155);
                    var_157 = wp::address(var_edge_colliding_edges_offsets, var_156);
                    var_159 = wp::load(var_157);
                    var_158 = wp::sub(var_159, var_153);
                    // min_dis_to_edges = wp.min(min_dis_to_edges, dist)                          <L 1629>
                    var_160 = wp::min(var_41, var_131);
                    // if edge_num_collisions < edge_buffer_size:                                 <L 1630>
                    var_161 = (var_40 < var_158);
                    if (var_161) {
                        // edge_colliding_edges[2 * (edge_buffer_offset + edge_num_collisions)] = e_index       <L 1631>
                        var_163 = wp::add(var_153, var_40);
                        var_164 = wp::mul(var_162, var_163);
                        // wp::array_store(var_edge_colliding_edges, var_164, var_0);
                        // edge_colliding_edges[2 * (edge_buffer_offset + edge_num_collisions) + 1] = colliding_edge_index       <L 1632>
                        var_166 = wp::add(var_153, var_40);
                        var_167 = wp::mul(var_165, var_166);
                        var_169 = wp::add(var_167, var_168);
                        // wp::array_store(var_edge_colliding_edges, var_169, var_79);
                    }
                    if (!var_161) {
                        // resize_flags[EDGE_COLLISION_BUFFER_OVERFLOW_INDEX] = 1                 <L 1634>
                        // wp::array_store(var_resize_flags, var_171, var_170);
                    }
                    // edge_num_collisions = edge_num_collisions + 1                              <L 1636>
                    var_173 = wp::add(var_40, var_172);
                }
                var_174 = wp::where(var_151, var_173, var_40);
                var_175 = wp::where(var_151, var_160, var_41);
                wp::assign(var_40, var_174);
                wp::assign(var_41, var_175);
                wp::adj_assign(var_41, var_175, adj_41, adj_175);
                wp::adj_assign(var_40, var_174, adj_40, adj_174);
                wp::adj_where(var_151, var_160, var_41, adj_151, adj_160, adj_41, adj_175);
                wp::adj_where(var_151, var_173, var_40, adj_151, adj_173, adj_40, adj_174);
                if (var_151) {
                    wp::adj_add(var_40, var_172, adj_40, adj_172, adj_173);
                    // adj: edge_num_collisions = edge_num_collisions + 1                         <L 1636>
                    if (!var_161) {
                        wp::adj_array_store(var_resize_flags, var_171, var_170, adj_resize_flags, adj_171, adj_170);
                        // adj: resize_flags[EDGE_COLLISION_BUFFER_OVERFLOW_INDEX] = 1            <L 1634>
                    }
                    if (var_161) {
                        wp::adj_array_store(var_edge_colliding_edges, var_169, var_79, adj_edge_colliding_edges, adj_169, adj_79);
                        wp::adj_add(var_167, var_168, adj_167, adj_168, adj_169);
                        wp::adj_mul(var_165, var_166, adj_165, adj_166, adj_167);
                        wp::adj_add(var_153, var_40, adj_153, adj_40, adj_166);
                        // adj: edge_colliding_edges[2 * (edge_buffer_offset + edge_num_collisions) + 1] = colliding_edge_index  <L 1632>
                        wp::adj_array_store(var_edge_colliding_edges, var_164, var_0, adj_edge_colliding_edges, adj_164, adj_0);
                        wp::adj_mul(var_162, var_163, adj_162, adj_163, adj_164);
                        wp::adj_add(var_153, var_40, adj_153, adj_40, adj_163);
                        // adj: edge_colliding_edges[2 * (edge_buffer_offset + edge_num_collisions)] = e_index  <L 1631>
                    }
                    // adj: if edge_num_collisions < edge_buffer_size:                            <L 1630>
                    wp::adj_min(var_41, var_131, adj_41, adj_131, adj_160);
                    // adj: min_dis_to_edges = wp.min(min_dis_to_edges, dist)                     <L 1629>
                    wp::adj_sub(var_159, var_153, adj_157, adj_153, adj_158);
                    wp::adj_address(var_edge_colliding_edges_offsets, var_156, adj_edge_colliding_edges_offsets, adj_156, adj_157);
                    wp::adj_add(var_0, var_155, adj_0, adj_155, adj_156);
                    // adj: edge_buffer_size = edge_colliding_edges_offsets[e_index + 1] - edge_buffer_offset  <L 1626>
                    wp::adj_copy(var_154, adj_152, adj_153);
                    wp::adj_address(var_edge_colliding_edges_offsets, var_0, adj_edge_colliding_edges_offsets, adj_0, adj_152);
                    // adj: edge_buffer_offset = edge_colliding_edges_offsets[e_index]            <L 1625>
                }
                // adj: if dist < max_query_radius:                                               <L 1624>
                if (var_132) {
                    if (var_150) {
                        // adj: continue                                                          <L 1622>
                    }
                    // adj: if dist_ref < min_query_radius:                                       <L 1621>
                    wp::adj_extract(var_147, var_148, adj_147, adj_148, adj_149);
                    // adj: dist_ref = std_ref[2]                                                 <L 1620>
                    wp::adj_closest_point_edge_edge(var_136, var_139, var_142, var_145, var_edge_edge_parallel_epsilon, adj_136, adj_139, adj_142, adj_145, adj_edge_edge_parallel_epsilon, adj_147);
                    // adj: e0_v0_pos_ref, e0_v1_pos_ref, e1_v0_pos_ref, e1_v1_pos_ref, edge_edge_parallel_epsilon  <L 1617>
                    // adj: std_ref = wp.closest_point_edge_edge(                                 <L 1616>
                    wp::adj_copy(var_146, adj_144, adj_145);
                    wp::adj_address(var_min_distance_filtering_ref_pos, var_88, adj_min_distance_filtering_ref_pos, adj_88, adj_144);
                    // adj: e1_v1_pos_ref = min_distance_filtering_ref_pos[e1_v1]                 <L 1615>
                    wp::adj_copy(var_143, adj_141, adj_142);
                    wp::adj_address(var_min_distance_filtering_ref_pos, var_84, adj_min_distance_filtering_ref_pos, adj_84, adj_141);
                    // adj: e1_v0_pos_ref = min_distance_filtering_ref_pos[e1_v0]                 <L 1614>
                    wp::adj_copy(var_140, adj_138, adj_139);
                    wp::adj_address(var_min_distance_filtering_ref_pos, var_7, adj_min_distance_filtering_ref_pos, adj_7, adj_138);
                    // adj: e0_v1_pos_ref = min_distance_filtering_ref_pos[e0_v1]                 <L 1613>
                    wp::adj_copy(var_137, adj_135, adj_136);
                    wp::adj_address(var_min_distance_filtering_ref_pos, var_3, adj_min_distance_filtering_ref_pos, adj_3, adj_135);
                    // adj: e0_v0_pos_ref = min_distance_filtering_ref_pos[e0_v0]                 <L 1612>
                }
                if (var_132) {
                }
                // adj: if min_distance_filtering_ref_pos and min_query_radius > 0.0:             <L 1611>
                wp::adj_extract(var_129, var_130, adj_129, adj_130, adj_131);
                // adj: dist = std[2]                                                             <L 1609>
                wp::adj_closest_point_edge_edge(var_10, var_13, var_124, var_127, var_edge_edge_parallel_epsilon, adj_10, adj_13, adj_124, adj_127, adj_edge_edge_parallel_epsilon, adj_129);
                // adj: std = wp.closest_point_edge_edge(e0_v0_pos, e0_v1_pos, e1_v0_pos, e1_v1_pos, edge_edge_parallel_epsilon)  <L 1608>
                wp::adj_copy(var_128, adj_126, adj_127);
                wp::adj_address(var_pos, var_88, adj_pos, adj_88, adj_126);
                // adj: e1_v1_pos = pos[e1_v1]                                                    <L 1606>
                wp::adj_copy(var_125, adj_123, adj_124);
                wp::adj_address(var_pos, var_84, adj_pos, adj_84, adj_123);
                // adj: e1_v0_pos = pos[e1_v0]                                                    <L 1605>
                if (var_edge_filtering_list) {
                    if (var_103) {
                        if (var_112) {
                            if (var_116) {
                                // adj: continue                                                  <L 1602>
                            }
                            if (var_116) {
                                wp::adj_address(var_edge_filtering_list, var_119, adj_edge_filtering_list, adj_119, adj_120);
                                wp::adj_sub(var_115, var_118, adj_115, adj_118, adj_119);
                            }
                            // adj: if idx > fl_start and edge_filtering_list[idx - 1] == colliding_edge_index:  <L 1601>
                            adj_binary_search_0(var_edge_filtering_list, var_79, var_96, var_101, adj_edge_filtering_list, adj_79, adj_96, adj_101, adj_115);
                            // adj: idx = binary_search(edge_filtering_list, colliding_edge_index, fl_start, fl_end)  <L 1600>
                        }
                        if (var_112) {
                        }
                        // adj: if (colliding_edge_index >= first_val) and (colliding_edge_index <= last_val):  <L 1599>
                        wp::adj_copy(var_111, adj_109, adj_110);
                        wp::adj_address(var_edge_filtering_list, var_108, adj_edge_filtering_list, adj_108, adj_109);
                        wp::adj_sub(var_101, var_107, adj_101, adj_107, adj_108);
                        // adj: last_val = edge_filtering_list[fl_end - 1]                        <L 1598>
                        wp::adj_copy(var_106, adj_104, adj_105);
                        wp::adj_address(var_edge_filtering_list, var_96, adj_edge_filtering_list, adj_96, adj_104);
                        // adj: first_val = edge_filtering_list[fl_start]                         <L 1597>
                    }
                    // adj: if fl_end > fl_start:                                                 <L 1595>
                    wp::adj_copy(var_102, adj_100, adj_101);
                    wp::adj_address(var_edge_filtering_list_offsets, var_99, adj_edge_filtering_list_offsets, adj_99, adj_100);
                    wp::adj_add(var_0, var_98, adj_0, adj_98, adj_99);
                    // adj: fl_end = edge_filtering_list_offsets[e_index + 1]  # start of next vertex slice (end exclusive)  <L 1593>
                    wp::adj_copy(var_97, adj_95, adj_96);
                    wp::adj_address(var_edge_filtering_list_offsets, var_0, adj_edge_filtering_list_offsets, adj_0, adj_95);
                    // adj: fl_start = edge_filtering_list_offsets[e_index]                       <L 1592>
                }
                // adj: if edge_filtering_list:                                                   <L 1591>
                if (var_90) {
                    // adj: continue                                                              <L 1589>
                }
                if (!var_90) {
                }
                if (!var_90) {
                }
                if (!var_90) {
                }
                // adj: if e0_v0 == e1_v0 or e0_v0 == e1_v1 or e0_v1 == e1_v0 or e0_v1 == e1_v1:  <L 1588>
                wp::adj_copy(var_89, adj_87, adj_88);
                wp::adj_address(var_edge_indices, var_79, var_86, adj_edge_indices, adj_79, adj_86, adj_87);
                // adj: e1_v1 = edge_indices[colliding_edge_index, 3]                             <L 1586>
                wp::adj_copy(var_85, adj_83, adj_84);
                wp::adj_address(var_edge_indices, var_79, var_82, adj_edge_indices, adj_79, adj_82, adj_83);
                // adj: e1_v0 = edge_indices[colliding_edge_index, 2]                             <L 1585>
        goto start_while_0;
        end_while_0:;
            // adj: while wp.bvh_query_next(query, colliding_edge_index):                         <L 1584>
            // adj: colliding_edge_index = wp.int32(0)                                            <L 1583>
            wp::adj_where(var_72, var_74, var_76, adj_72, adj_74, adj_76, adj_77);
            if (!var_72) {
                // adj: query = wp.bvh_query_aabb(bvh_id, lower, upper, group_root)               <L 1581>
            }
            if (var_72) {
                // adj: query = wp.bvh_query_aabb(bvh_id, lower, upper)                           <L 1579>
            }
            // adj: if query_all:                                                                 <L 1578>
        }
        // adj: if run_query:                                                                     <L 1577>
        wp::adj_where(var_53, var_51, var_68, adj_53, adj_51, adj_68, adj_73);
        wp::adj_where(var_53, var_59, var_49, adj_53, adj_59, adj_49, adj_72);
        wp::adj_where(var_53, var_58, var_70, adj_53, adj_58, adj_70, adj_71);
        if (!var_53) {
            // adj: run_query = group_root >= 0                                                   <L 1575>
            wp::adj_where(var_61, var_63, var_66, adj_61, adj_63, adj_66, adj_68);
            if (!var_61) {
                wp::adj_copy(var_67, adj_65, adj_66);
                wp::adj_address(var_bvh_group_roots, var_world_count, adj_bvh_group_roots, adj_world_count, adj_65);
                // adj: group_root = bvh_group_roots[world_count]                                 <L 1574>
            }
            if (var_61) {
                wp::adj_copy(var_64, adj_62, adj_63);
                wp::adj_address(var_bvh_group_roots, var_43, adj_bvh_group_roots, adj_43, adj_62);
                // adj: group_root = bvh_group_roots[edge_world]                                  <L 1572>
            }
            // adj: if query_pass == 0:                                                           <L 1571>
        }
        if (var_53) {
            wp::adj_where(var_55, var_57, var_49, adj_55, adj_57, adj_49, adj_59);
            wp::adj_where(var_55, var_56, var_47, adj_55, adj_56, adj_47, adj_58);
            if (var_55) {
                // adj: query_all = True                                                          <L 1569>
                // adj: run_query = True                                                          <L 1568>
            }
            // adj: if query_pass == 0:                                                           <L 1567>
        }
        // adj: if edge_world < 0:                                                                <L 1566>
        // adj: group_root = wp.int32(-1)                                                         <L 1564>
        // adj: query_all = bool(False)                                                           <L 1563>
        // adj: run_query = bool(False)                                                           <L 1562>
        // adj: for query_pass in range(2):                                                       <L 1561>
        wp::adj_copy(var_44, adj_42, adj_43);
        wp::adj_address(var_particle_world, var_3, adj_particle_world, adj_3, adj_42);
        // adj: edge_world = particle_world[e0_v0]                                                <L 1555>
        wp::adj_copy(var_max_query_radius, adj_max_query_radius, adj_41);
        // adj: min_dis_to_edges = max_query_radius                                               <L 1554>
        // adj: edge_num_collisions = wp.int32(0)                                                 <L 1553>
        // adj: colliding_edge_index = wp.int32(0)                                                <L 1552>
        wp::adj_vec_t(var_29, var_32, var_35, adj_29, adj_32, adj_35, adj_36);
        wp::adj_add(var_34, var_max_query_radius, adj_34, adj_max_query_radius, adj_35);
        wp::adj_extract(var_16, var_33, adj_16, adj_33, adj_34);
        wp::adj_add(var_31, var_max_query_radius, adj_31, adj_max_query_radius, adj_32);
        wp::adj_extract(var_16, var_30, adj_16, adj_30, adj_31);
        wp::adj_add(var_28, var_max_query_radius, adj_28, adj_max_query_radius, adj_29);
        wp::adj_extract(var_16, var_27, adj_16, adj_27, adj_28);
        // adj: upper = wp.vec3(upper[0] + max_query_radius, upper[1] + max_query_radius, upper[2] + max_query_radius)  <L 1550>
        wp::adj_vec_t(var_19, var_22, var_25, adj_19, adj_22, adj_25, adj_26);
        wp::adj_sub(var_24, var_max_query_radius, adj_24, adj_max_query_radius, adj_25);
        wp::adj_extract(var_15, var_23, adj_15, adj_23, adj_24);
        wp::adj_sub(var_21, var_max_query_radius, adj_21, adj_max_query_radius, adj_22);
        wp::adj_extract(var_15, var_20, adj_15, adj_20, adj_21);
        wp::adj_sub(var_18, var_max_query_radius, adj_18, adj_max_query_radius, adj_19);
        wp::adj_extract(var_15, var_17, adj_15, adj_17, adj_18);
        // adj: lower = wp.vec3(lower[0] - max_query_radius, lower[1] - max_query_radius, lower[2] - max_query_radius)  <L 1549>
        wp::adj_max(var_10, var_13, adj_10, adj_13, adj_16);
        // adj: upper = wp.max(e0_v0_pos, e0_v1_pos)                                              <L 1547>
        wp::adj_min(var_10, var_13, adj_10, adj_13, adj_15);
        // adj: lower = wp.min(e0_v0_pos, e0_v1_pos)                                              <L 1546>
        wp::adj_copy(var_14, adj_12, adj_13);
        wp::adj_address(var_pos, var_7, adj_pos, adj_7, adj_12);
        // adj: e0_v1_pos = pos[e0_v1]                                                            <L 1544>
        wp::adj_copy(var_11, adj_9, adj_10);
        wp::adj_address(var_pos, var_3, adj_pos, adj_3, adj_9);
        // adj: e0_v0_pos = pos[e0_v0]                                                            <L 1543>
        wp::adj_copy(var_8, adj_6, adj_7);
        wp::adj_address(var_edge_indices, var_0, var_5, adj_edge_indices, adj_0, adj_5, adj_6);
        // adj: e0_v1 = edge_indices[e_index, 3]                                                  <L 1541>
        wp::adj_copy(var_4, adj_2, adj_3);
        wp::adj_address(var_edge_indices, var_0, var_1, adj_edge_indices, adj_0, adj_1, adj_2);
        // adj: e0_v0 = edge_indices[e_index, 2]                                                  <L 1540>
        // adj: e_index = wp.tid()                                                                <L 1538>
        // adj: def edge_colliding_edges_detection_kernel(                                        <L 1500>
        continue;
    }
}



extern "C" __global__ void compute_edge_groups_4dfa4eb5_cuda_kernel_forward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::int32> var_edge_indices,
    wp::array_t<wp::int32> var_particle_world,
    wp::int32 var_world_count,
    wp::array_t<wp::int32> var_groups)
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
        const wp::int32 var_1 = 2;
        wp::int32* var_2;
        wp::int32* var_3;
        wp::int32 var_4;
        wp::int32 var_5;
        wp::int32 var_6;
        const wp::int32 var_7 = 0;
        bool var_8;
        wp::int32 var_9;
        wp::int32 var_10;
        //---------
        // forward
        // def compute_edge_groups(                                                               <L 1273>
        // e_id = wp.tid()                                                                        <L 1280>
        var_0 = builtin_tid1d();
        // world_index = particle_world[edge_indices[e_id, 2]]                                    <L 1282>
        var_2 = wp::address(var_edge_indices, var_0, var_1);
        var_4 = wp::load(var_2);
        var_3 = wp::address(var_particle_world, var_4);
        var_6 = wp::load(var_3);
        var_5 = wp::copy(var_6);
        // if world_index < 0:                                                                    <L 1283>
        var_8 = (var_5 < var_7);
        if (var_8) {
            // world_index = world_count                                                          <L 1284>
            var_9 = wp::copy(var_world_count);
        }
        var_10 = wp::where(var_8, var_9, var_5);
        // groups[e_id] = world_index                                                             <L 1285>
        wp::array_store(var_groups, var_0, var_10);
    }
}



extern "C" __global__ void compute_edge_groups_4dfa4eb5_cuda_kernel_backward(
    wp::launch_bounds_t<1> dim,
    wp::array_t<wp::int32> var_edge_indices,
    wp::array_t<wp::int32> var_particle_world,
    wp::int32 var_world_count,
    wp::array_t<wp::int32> var_groups,
    wp::array_t<wp::int32> adj_edge_indices,
    wp::array_t<wp::int32> adj_particle_world,
    wp::int32 adj_world_count,
    wp::array_t<wp::int32> adj_groups)
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
        const wp::int32 var_1 = 2;
        wp::int32* var_2;
        wp::int32* var_3;
        wp::int32 var_4;
        wp::int32 var_5;
        wp::int32 var_6;
        const wp::int32 var_7 = 0;
        bool var_8;
        wp::int32 var_9;
        wp::int32 var_10;
        //---------
        // dual vars
        wp::int32 adj_0 = {};
        wp::int32 adj_1 = {};
        wp::int32 adj_2 = {};
        wp::int32 adj_3 = {};
        wp::int32 adj_4 = {};
        wp::int32 adj_5 = {};
        wp::int32 adj_6 = {};
        wp::int32 adj_7 = {};
        bool adj_8 = {};
        wp::int32 adj_9 = {};
        wp::int32 adj_10 = {};
        //---------
        // forward
        // def compute_edge_groups(                                                               <L 1273>
        // e_id = wp.tid()                                                                        <L 1280>
        var_0 = builtin_tid1d();
        // world_index = particle_world[edge_indices[e_id, 2]]                                    <L 1282>
        var_2 = wp::address(var_edge_indices, var_0, var_1);
        var_4 = wp::load(var_2);
        var_3 = wp::address(var_particle_world, var_4);
        var_6 = wp::load(var_3);
        var_5 = wp::copy(var_6);
        // if world_index < 0:                                                                    <L 1283>
        var_8 = (var_5 < var_7);
        if (var_8) {
            // world_index = world_count                                                          <L 1284>
            var_9 = wp::copy(var_world_count);
        }
        var_10 = wp::where(var_8, var_9, var_5);
        // groups[e_id] = world_index                                                             <L 1285>
        // wp::array_store(var_groups, var_0, var_10);
        //---------
        // reverse
        wp::adj_array_store(var_groups, var_0, var_10, adj_groups, adj_0, adj_10);
        // adj: groups[e_id] = world_index                                                        <L 1285>
        wp::adj_where(var_8, var_9, var_5, adj_8, adj_9, adj_5, adj_10);
        if (var_8) {
            wp::adj_copy(var_world_count, adj_world_count, adj_9);
            // adj: world_index = world_count                                                     <L 1284>
        }
        // adj: if world_index < 0:                                                               <L 1283>
        wp::adj_copy(var_6, adj_3, adj_5);
        wp::adj_address(var_particle_world, var_4, adj_particle_world, adj_2, adj_3);
        wp::adj_address(var_edge_indices, var_0, var_1, adj_edge_indices, adj_0, adj_1, adj_2);
        // adj: world_index = particle_world[edge_indices[e_id, 2]]                               <L 1282>
        // adj: e_id = wp.tid()                                                                   <L 1280>
        // adj: def compute_edge_groups(                                                          <L 1273>
        continue;
    }
}

