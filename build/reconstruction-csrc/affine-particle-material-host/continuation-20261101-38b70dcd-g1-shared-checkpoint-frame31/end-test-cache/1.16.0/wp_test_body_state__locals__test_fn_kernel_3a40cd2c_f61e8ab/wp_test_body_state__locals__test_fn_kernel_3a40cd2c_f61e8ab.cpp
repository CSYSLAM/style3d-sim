#define WP_NO_BFLOAT16

#define WP_TILE_BLOCK_DIM 1
#define WP_NO_CRT
#include "builtin.h"
#include "deterministic.h"

// avoid namespacing of float type for casting to float type, this is to avoid wp::float(x), which is not valid in C++
#define float(x) cast_float(x)
#define adj_float(x, adj_x, adj_ret) adj_cast_float(x, adj_x, adj_ret)

#define int(x) cast_int(x)
#define adj_int(x, adj_x, adj_ret) adj_cast_int(x, adj_x, adj_ret)

#define builtin_tid1d() wp::tid(task_index, dim)
#define builtin_tid2d(x, y) wp::tid(x, y, task_index, dim)
#define builtin_tid3d(x, y, z) wp::tid(x, y, z, task_index, dim)
#define builtin_tid4d(x, y, z, w) wp::tid(x, y, z, w, task_index, dim)

#define builtin_block_dim() wp::block_dim()


// /home/oem/code/agent/style3d-sim/examples/example_robot_g1.py:0
static wp::float32 func_30996d06_1(
    wp::transform_t<wp::float32> var_q,
    wp::vec_t<6, wp::float32> var_qd)
{
    //---------
    // primal vars
    wp::vec_t<6, wp::float32> var_0;
    wp::float32 var_1;
    //---------
    // forward
    // def func_30996d06(q, qd):                                                              <L 0>
    // return max(abs(qd))                                                                    <L 1>
    var_0 = wp::abs(var_qd);
    var_1 = wp::max(var_0);
    return var_1;
}


// /home/oem/code/agent/style3d-sim/examples/example_robot_g1.py:0
static void adj_func_30996d06_1(
    wp::transform_t<wp::float32> var_q,
    wp::vec_t<6, wp::float32> var_qd,
    wp::transform_t<wp::float32> & adj_q,
    wp::vec_t<6, wp::float32> & adj_qd,
    wp::float32 & adj_ret)
{
	// reverse mode disabled (module option "enable_backward" is False or no dependent kernel found with "enable_backward")
}

struct wp_args_test_body_state__locals__test_fn_kernel_f43afbf1 {
    wp::array_t<wp::transform_t<wp::float32>> body_q;
    wp::array_t<wp::vec_t<6, wp::float32>> body_qd;
    wp::array_t<wp::int32> indices;
    wp::array_t<bool> failures;
};


void test_body_state__locals__test_fn_kernel_f43afbf1_cpu_kernel_forward(
    wp::launch_bounds_t<1> dim,
    size_t task_index,
    wp_args_test_body_state__locals__test_fn_kernel_f43afbf1 *_wp_args)
{
    //---------
    // argument vars
    wp::array_t<wp::transform_t<wp::float32>> var_body_q = _wp_args->body_q;
    wp::array_t<wp::vec_t<6, wp::float32>> var_body_qd = _wp_args->body_qd;
    wp::array_t<wp::int32> var_indices = _wp_args->indices;
    wp::array_t<bool> var_failures = _wp_args->failures;
    //---------
    // primal vars
    wp::int32 var_0;
    wp::int32* var_1;
    wp::int32 var_2;
    wp::int32 var_3;
    wp::transform_t<wp::float32>* var_4;
    wp::vec_t<6, wp::float32>* var_5;
    wp::float32 var_6;
    wp::transform_t<wp::float32> var_7;
    wp::vec_t<6, wp::float32> var_8;
    bool var_9;
    bool var_10;
    //---------
    // forward
    // def test_fn_kernel(                                                                    <L 100>
    // world_id = wp.tid()                                                                    <L 107>
    var_0 = builtin_tid1d();
    // index = indices[world_id]                                                              <L 108>
    var_1 = wp::address(var_indices, var_0);
    var_3 = wp::load(var_1);
    var_2 = wp::copy(var_3);
    // result = warp_test_fn(body_q[index], body_qd[index])                                   <L 109>
    var_4 = wp::address(var_body_q, var_2);
    var_5 = wp::address(var_body_qd, var_2);
    var_7 = wp::load(var_4);
    var_8 = wp::load(var_5);
    var_6 = func_30996d06_1(var_7, var_8);
    // failures[world_id] = not wp.bool(result)                                               <L 110>
    var_9 = bool(var_6);
    var_10 = wp::unot(var_9);
    wp::array_store(var_failures, var_0, var_10);
}



extern "C" {

// Python CPU entry points
WP_API void test_body_state__locals__test_fn_kernel_f43afbf1_cpu_forward(
    wp::launch_bounds_t<1> *dim,
    wp_args_test_body_state__locals__test_fn_kernel_f43afbf1 *_wp_args)
{
    wp::tile_shared_storage_t tile_mem;
#if defined(WP_ENABLE_TILES_IN_STACK_MEMORY)
    wp::shared_tile_storage = &tile_mem;
#endif

    for (size_t task_index = 0; task_index < dim->size; ++task_index)
    {
        test_body_state__locals__test_fn_kernel_f43afbf1_cpu_kernel_forward(*dim, task_index, _wp_args);
    }
}

} // extern C

