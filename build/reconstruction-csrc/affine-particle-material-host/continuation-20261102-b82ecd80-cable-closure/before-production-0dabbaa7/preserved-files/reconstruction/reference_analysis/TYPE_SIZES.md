# 按值传递的自定义类型尺寸（从 PTX `.param .b8 name[N]` 反出）

> 判据：kernel 形参若是 `.param .b8 ..._[N]` 而非 `.param .u64`，说明该类型按值传递，N 就是 `sizeof(T)`。
> 这张表可以直接和你的 `struct` 定义对——差 1 字节就说明字段/对齐对不上。
> 带 `&` 的（如 `synreal::Model&`）在 kernel 侧是按值拷贝进 1864 字节参数区，核对时注意源码签名与 ABI 的差异。

| 类型 | sizeof | 出现在 |
|---|---|---|
| `glm::vec3` | 12 | solver_newton.cu |
| `thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<synreal::NonZeroEntry>, synreal::NonZeroEntry>` | 16 | solver_newton.cu |
| `synreal::Aabb` | 24 | lbvh_builder.cu |
| `synreal::kernel::AngularLimitView` | 32 | solver_newton.cu |
| `thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<synreal::Aabb>, synreal::Aabb>` | 32 | self_collision.cu |
| `thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<synreal::BlockNonZeroEntry>, synreal::BlockNonZeroEntry>` | 48 | solver_newton.cu |
| `synreal::fluid_kernel::View` | 112 | fluid.cu |
| `synreal::kernel::JointCoordinateView` | 120 | solver_newton.cu |
| `synreal::granular_kernel::View` | 120 | granular.cu |
| `synreal::kernel::CableView` | 160 | solver_newton.cu |
| `synreal::kernel::RollingContactView` | 248 | solver_newton.cu |
| `synreal::kernel::SurfaceContactView` | 296 | solver_newton.cu |
| `synreal::kernel::HardContactView` | 312 | solver_newton.cu |
| `synreal::Model` | 1864 | fluid.cu, granular.cu |

## 由 stride 反推的元素尺寸（比 functor 尺寸更直接）

`thrust` 的 fill functor 尺寸 = `device_ptr`(8) + 值类型，所以：

| 类型 | sizeof | 证据 |
|---|---|---|
| `synreal::NonZeroEntry` | **8** | `multiply_matrix` 里 `shl.b64 %rd54, %rd75, 3`（步长 8）；functor 16 − 8 = 8 |
| `synreal::BlockNonZeroEntry` | **40** | `multiply_matrix_and_reduce` 里 `mul.lo.s64 %rd46, %rd45, 40`；functor 48 − 8 = 40 |

字段推断：`NonZeroEntry { int col; float val; }`（4+4）；
`BlockNonZeroEntry { int col; float m[9]; }`（4+36）——块版本是"一个列索引 + 一个 3×3 块"。
