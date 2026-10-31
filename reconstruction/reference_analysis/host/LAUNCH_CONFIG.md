# kernel launch 配置（最终版）

> 两级来源：**direct** = push 点附近直接读到 dim3 常量；**func** = 该函数只用过一个 block 尺寸，按函数级回填；**unknown** = 函数内出现多个尺寸，无法归属。

## `synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synrea` —— 76 次 launch

block 分布：(256, 1) × 76
置信度：direct 75，func 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0xfbdc6 | `?` | (256, 1) | direct |
| 0xfbe4c | `?` | (256, 1) | direct |
| 0xfc016 | `?` | (256, 1) | direct |
| 0xfc2ee | `?` | (256, 1) | direct |
| 0xfc429 | `?` | (256, 1) | direct |
| 0xfc552 | `?` | (256, 1) | direct |
| 0xfc687 | `?` | (256, 1) | direct |
| 0xfc709 | `?` | (256, 1) | direct |
| 0xfc89a | `?` | (256, 1) | direct |
| 0xfc920 | `?` | (256, 1) | direct |
| 0xfcb41 | `?` | (256, 1) | direct |
| 0xfcc09 | `?` | (256, 1) | direct |
| 0xfccae | `?` | (256, 1) | direct |
| 0xfcd7a | `?` | (256, 1) | direct |
| 0xfce14 | `?` | (256, 1) | direct |
| 0xfcea9 | `?` | (256, 1) | direct |
| 0xfcf80 | `?` | (256, 1) | direct |
| 0xfd0a3 | `?` | (256, 1) | direct |
| 0xfd1e3 | `?` | (256, 1) | direct |
| 0xfd32e | `?` | (256, 1) | direct |
| 0xfd56c | `?` | (256, 1) | direct |
| 0xfd7ce | `?` | (256, 1) | direct |
| 0xfd870 | `?` | (256, 1) | direct |
| 0xfd947 | `?` | (256, 1) | direct |
| 0xfd9e6 | `?` | (256, 1) | direct |
| 0xfdefd | `?` | (256, 1) | direct |
| 0xfdf6e | `?` | (256, 1) | direct |
| 0xfe07f | `?` | (256, 1) | direct |
| 0xfe29f | `?` | (256, 1) | direct |
| 0xfe6d7 | `?` | (256, 1) | direct |
| 0xfe78c | `?` | (256, 1) | direct |
| 0xfe890 | `?` | (256, 1) | direct |
| 0xfe931 | `?` | (256, 1) | direct |
| 0xfea49 | `?` | (256, 1) | direct |
| 0xfeb21 | `?` | (256, 1) | direct |
| 0xfec25 | `?` | (256, 1) | direct |
| 0xfecf5 | `?` | (256, 1) | direct |
| 0xfeeba | `?` | (256, 1) | direct |
| 0xfefac | `?` | (256, 1) | direct |
| 0xff0c6 | `?` | (256, 1) | direct |
| 0xff19a | `?` | (256, 1) | direct |
| 0xff642 | `?` | (256, 1) | func |
| 0xff6be | `?` | (256, 1) | direct |
| 0xff835 | `?` | (256, 1) | direct |
| 0xff8e5 | `?` | (256, 1) | direct |
| 0xff9a1 | `?` | (256, 1) | direct |
| 0xffa98 | `?` | (256, 1) | direct |
| 0xffbf8 | `?` | (256, 1) | direct |
| 0xffcd8 | `?` | (256, 1) | direct |
| 0xffdb8 | `?` | (256, 1) | direct |
| 0xffe81 | `?` | (256, 1) | direct |
| 0xfff9e | `?` | (256, 1) | direct |
| 0x100360 | `?` | (256, 1) | direct |
| 0x100500 | `?` | (256, 1) | direct |
| 0x100603 | `?` | (256, 1) | direct |
| 0x100825 | `?` | (256, 1) | direct |
| 0x10090e | `?` | (256, 1) | direct |
| 0x100c1a | `?` | (256, 1) | direct |
| 0x100f41 | `?` | (256, 1) | direct |
| 0x100fc1 | `?` | (256, 1) | direct |
| 0x101041 | `?` | (256, 1) | direct |
| 0x1010c1 | `?` | (256, 1) | direct |
| 0x1011a3 | `?` | (256, 1) | direct |
| 0x101249 | `?` | (256, 1) | direct |
| 0x1012cb | `?` | (256, 1) | direct |
| 0x101607 | `?` | (256, 1) | direct |
| 0x1016b0 | `?` | (256, 1) | direct |
| 0x10174d | `?` | (256, 1) | direct |
| 0x1017da | `?` | (256, 1) | direct |
| 0x101862 | `?` | (256, 1) | direct |
| 0x1018f2 | `?` | (256, 1) | direct |
| 0x101972 | `?` | (256, 1) | direct |
| 0x101a48 | `?` | (256, 1) | direct |
| 0x1024c3 | `?` | (256, 1) | direct |
| 0x10276b | `?` | (256, 1) | direct |
| 0x1027f2 | `?` | (256, 1) | direct |

## `synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synrea` —— 15 次 launch

block 分布：(256, 1) × 15
置信度：direct 14，func 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x102c83 | `?` | (256, 1) | direct |
| 0x102d08 | `?` | (256, 1) | direct |
| 0x102db0 | `?` | (256, 1) | direct |
| 0x102f75 | `?` | (256, 1) | direct |
| 0x102ffa | `?` | (256, 1) | direct |
| 0x10308e | `?` | (256, 1) | direct |
| 0x10310a | `?` | (256, 1) | direct |
| 0x103183 | `?` | (256, 1) | direct |
| 0x103202 | `?` | (256, 1) | direct |
| 0x1032f2 | `?` | (256, 1) | direct |
| 0x103372 | `?` | (256, 1) | direct |
| 0x1033f2 | `?` | (256, 1) | direct |
| 0x103472 | `?` | (256, 1) | direct |
| 0x103506 | `?` | (256, 1) | direct |
| 0x103ad0 | `?` | (256, 1) | func |

## `synreal::SelfCollision::begin_frame(glm::vec<3, float, (glm::qualifier)0> const*` —— 11 次 launch

block 分布：(256, 1) × 11
置信度：direct 11

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x13b9bb | `?` | (256, 1) | direct |
| 0x13ba37 | `?` | (256, 1) | direct |
| 0x13bac3 | `?` | (256, 1) | direct |
| 0x13bb36 | `?` | (256, 1) | direct |
| 0x13bbbf | `?` | (256, 1) | direct |
| 0x13bc2f | `?` | (256, 1) | direct |
| 0x13bcdf | `?` | (256, 1) | direct |
| 0x13bdd7 | `?` | (256, 1) | direct |
| 0x13bedc | `?` | (256, 1) | direct |
| 0x13bf5e | `?` | (256, 1) | direct |
| 0x13c13c | `?` | (256, 1) | direct |

## `void (anonymous namespace)::solve_impl<synreal::SparseMatrixELL, float>(synreal:` —— 9 次 launch

block 分布：(256, 1) × 9
置信度：direct 5，func 4

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x130bf5 | `?` | (256, 1) | direct |
| 0x130cce | `?` | (256, 1) | direct |
| 0x130f02 | `?` | (256, 1) | direct |
| 0x130fdd | `void synreal::kernel::multiply_matrix<synreal::NonZeroEntr` | (256, 1) | direct |
| 0x1312c4 | `void synreal::kernel::update_cg_direction<float>` | (256, 1) | direct |
| 0x131959 | `?` | (256, 1) | func |
| 0x131b2d | `?` | (256, 1) | func |
| 0x131c15 | `?` | (256, 1) | func |
| 0x1324c0 | `?` | (256, 1) | func |

## `void (anonymous namespace)::solve_impl<synreal::SparseBlockMatrixELL, glm::mat<3` —— 7 次 launch

block 分布：(256, 1) × 7
置信度：direct 6，func 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x136ff2 | `?` | (256, 1) | direct |
| 0x1370bd | `?` | (256, 1) | direct |
| 0x1371f8 | `?` | (256, 1) | direct |
| 0x1372d2 | `void synreal::kernel::multiply_matrix_and_reduce<256u, syn` | (256, 1) | func |
| 0x137517 | `void synreal::kernel::update_cg_direction<glm::mat<3, 3, f` | (256, 1) | direct |
| 0x1375d5 | `void synreal::kernel::update_cg_direction<glm::mat<3, 3, f` | (256, 1) | direct |
| 0x137779 | `void synreal::kernel::update_solution_residual_and_reduce<` | (256, 1) | direct |

## `void (anonymous namespace)::solve_impl<synreal::SparseMatrixELL, glm::mat<3, 3, ` —— 5 次 launch

block 分布：(256, 1) × 5
置信度：direct 4，func 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x132c82 | `?` | (256, 1) | direct |
| 0x132d5e | `?` | (256, 1) | direct |
| 0x132e9d | `?` | (256, 1) | direct |
| 0x132f70 | `void synreal::kernel::multiply_matrix<synreal::NonZeroEntr` | (256, 1) | direct |
| 0x133238 | `void synreal::kernel::update_cg_direction<glm::mat<3, 3, f` | (256, 1) | func |

## `synreal::SelfCollision::accumulate(glm::vec<3, float, (glm::qualifier)0> const*,` —— 5 次 launch

block 分布：(256, 1) × 5
置信度：direct 5

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x13b198 | `?` | (256, 1) | direct |
| 0x13b277 | `?` | (256, 1) | direct |
| 0x13b384 | `?` | (256, 1) | direct |
| 0x13b3f4 | `?` | (256, 1) | direct |
| 0x13b464 | `?` | (256, 1) | direct |

## `cudaError cub::CUB_200302_520_NS::DeviceRadixSort::SortPairs<unsigned int, int, ` —— 5 次 launch

block 分布：None × 5
置信度：unknown 5

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x1499c0 | `?` | ? | unknown |
| 0x149b65 | `?` | ? | unknown |
| 0x14a255 | `?` | ? | unknown |
| 0x14a453 | `?` | ? | unknown |
| 0x14a590 | `?` | ? | unknown |

## `synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm:` —— 4 次 launch

block 分布：(128, 1) × 4
置信度：direct 2，func 2

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x12665d | `?` | (128, 1) | direct |
| 0x1266b6 | `?` | (128, 1) | direct |
| 0x126906 | `?` | (128, 1) | func |
| 0x1269d6 | `?` | (128, 1) | func |

## `synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec` —— 4 次 launch

block 分布：(128, 1) × 4
置信度：direct 4

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x126ce8 | `?` | (128, 1) | direct |
| 0x126d73 | `?` | (128, 1) | direct |
| 0x126dbf | `?` | (128, 1) | direct |
| 0x126ffe | `?` | (128, 1) | direct |

## `cudaError cub::CUB_200302_520_NS::DeviceReduce::Sum<thrust::THRUST_200302_520_NS` —— 4 次 launch

block 分布：None × 4
置信度：unknown 4

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x12e72b | `?` | ? | unknown |
| 0x12e7fd | `?` | ? | unknown |
| 0x12e950 | `?` | ? | unknown |
| 0x12f124 | `?` | ? | unknown |

## `cudaError cub::CUB_200302_520_NS::DeviceReduce::Sum<thrust::THRUST_200302_520_NS` —— 4 次 launch

block 分布：None × 4
置信度：unknown 4

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x12f6fb | `?` | ? | unknown |
| 0x12f7cd | `?` | ? | unknown |
| 0x12f920 | `?` | ? | unknown |
| 0x1300f4 | `?` | ? | unknown |

## `cudaError cub::CUB_200302_520_NS::DeviceReduce::Sum<float const*, float*, unsign` —— 4 次 launch

block 分布：None × 4
置信度：unknown 4

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x135e51 | `?` | ? | unknown |
| 0x135f13 | `?` | ? | unknown |
| 0x136058 | `?` | ? | unknown |
| 0x136577 | `?` | ? | unknown |

## `cudaError cub::CUB_200302_520_NS::DeviceReduce::Reduce<thrust::THRUST_200302_520` —— 4 次 launch

block 分布：None × 4
置信度：unknown 4

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x14317a | `void cub::CUB_200302_520_NS::DeviceReduceSingleTileKernel<` | ? | unknown |
| 0x14333d | `?` | ? | unknown |
| 0x143411 | `?` | ? | unknown |
| 0x143b2a | `?` | ? | unknown |

## `cudaError cub::CUB_200302_520_NS::DeviceReduce::Reduce<thrust::THRUST_200302_520` —— 4 次 launch

block 分布：None × 4
置信度：unknown 4

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x144124 | `void cub::CUB_200302_520_NS::DeviceReduceSingleTileKernel<` | ? | unknown |
| 0x1442e5 | `?` | ? | unknown |
| 0x1443bf | `?` | ? | unknown |
| 0x144ade | `?` | ? | unknown |

## `synreal::Fluid::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::ve` —— 3 次 launch

block 分布：(128, 1) × 3
置信度：direct 3

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x12089f | `?` | (128, 1) | direct |
| 0x120904 | `?` | (128, 1) | direct |
| 0x120950 | `?` | (128, 1) | direct |

## `synreal::Fluid::limit_step(glm::vec<3, float, (glm::qualifier)0>*, float, float,` —— 3 次 launch

block 分布：(128, 1) × 3
置信度：direct 3

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x120d31 | `?` | (128, 1) | direct |
| 0x120d8a | `?` | (128, 1) | direct |
| 0x120de3 | `?` | (128, 1) | direct |

## `synreal::Granular::multiply(glm::vec<3, float, (glm::qualifier)0> const*, glm::v` —— 3 次 launch

block 分布：(128, 1) × 3
置信度：direct 3

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x127319 | `?` | (128, 1) | direct |
| 0x127518 | `?` | (128, 1) | direct |
| 0x1275a6 | `?` | (128, 1) | direct |

## `synreal::SelfCollision::build_bvhs(glm::vec<3, float, (glm::qualifier)0> const*)` —— 3 次 launch

block 分布：(256, 1) × 3
置信度：direct 3

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x13ccbd | `?` | (256, 1) | direct |
| 0x13cee0 | `?` | (256, 1) | direct |
| 0x13d103 | `?` | (256, 1) | direct |

## `synreal::SolverNewton::reset_cable_penalty_state(CUstream_st*, synreal::Span<int` —— 2 次 launch

block 分布：(256, 1) × 2
置信度：direct 2

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0xfadbe | `?` | (256, 1) | direct |
| 0xfae49 | `?` | (256, 1) | direct |

## `std::_Function_handler<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0>` —— 2 次 launch

block 分布：(256, 1) × 2
置信度：direct 2

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0xfb06a | `?` | (256, 1) | direct |
| 0xfb0d8 | `?` | (256, 1) | direct |

## `synreal::SelfCollision::multiply(glm::vec<3, float, (glm::qualifier)0> const*, g` —— 2 次 launch

block 分布：(256, 1) × 2
置信度：direct 2

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x13b7ff | `?` | (256, 1) | direct |
| 0x13b88b | `?` | (256, 1) | direct |

## `synreal::BvhBuilder::build_traversal_links(synreal::Span<int>, synreal::Span<int` —— 2 次 launch

block 分布：(256, 1) × 2
置信度：direct 2

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x145429 | `?` | (256, 1) | direct |
| 0x14548b | `?` | (256, 1) | direct |

## `synreal::BvhBuilder::build_hierarchy(synreal::Span<int>, synreal::Span<glm::vec<` —— 2 次 launch

block 分布：(256, 1) × 2
置信度：direct 2

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x145e4a | `?` | (256, 1) | direct |
| 0x14602f | `?` | (256, 1) | direct |

## `synreal::SolverNewton::reset_joint_drive_state(CUstream_st*, synreal::Span<int c` —— 1 次 launch

block 分布：(256, 1) × 1
置信度：direct 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0xfac74 | `?` | (256, 1) | direct |

## `synreal::SolverNewton::copy_cable_penalties(synreal::Span<glm::vec<4, float, (gl` —— 1 次 launch

block 分布：(256, 1) × 1
置信度：direct 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0xfaf47 | `?` | (256, 1) | direct |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<t` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x118961 | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<t` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x118c41 | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<t` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x118f23 | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<t` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x11922e | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<t` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x119521 | `void thrust::THRUST_200302_520_NS::cuda_cub::core::_kernel` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<t` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x119e2f | `void thrust::THRUST_200302_520_NS::cuda_cub::core::_kernel` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<t` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x11a9be | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<t` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x11b1af | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<t` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x11bd01 | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<t` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x11ceee | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<t` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x11d853 | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<t` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x11df83 | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<t` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x11ea7e | `?` | ? | unknown |

## `synreal::Fluid::multiply(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x12101f | `?` | ? | unknown |

## `synreal::Fluid::add_preconditioner(glm::mat<3, 3, float, (glm::qualifier)0>*, CU` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x1211e6 | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<t` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x12374e | `?` | ? | unknown |

## `synreal::Granular::add_preconditioner(glm::mat<3, 3, float, (glm::qualifier)0>*,` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x127636 | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<t` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x12bfe1 | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<t` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x12c2df | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<t` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x12c5d1 | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<t` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x12c8cf | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<t` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x12d941 | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::launcher::triple_chevron::doit` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x12e0cf | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::launcher::triple_chevron::doit` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x12e14f | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::launcher::triple_chevron::doit` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x12e1cf | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::launcher::triple_chevron::doit` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x12e22f | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<t` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x1382e1 | `?` | ? | unknown |

## `synreal::SelfCollision::add_preconditioner(glm::mat<3, 3, float, (glm::qualifier` —— 1 次 launch

block 分布：(256, 1) × 1
置信度：direct 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x13b73b | `?` | (256, 1) | direct |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<t` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x141061 | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<t` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x141aaf | `void thrust::THRUST_200302_520_NS::cuda_cub::core::_kernel` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::launcher::triple_chevron::doit` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x142b4f | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::launcher::triple_chevron::doit` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x142bcf | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::launcher::triple_chevron::doit` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x142c3f | `?` | ? | unknown |

## `synreal::BvhBuilder::update_aabbs(synreal::Span<synreal::Aabb>, synreal::Span<sy` —— 1 次 launch

block 分布：(256, 1) × 1
置信度：direct 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x1455b6 | `?` | (256, 1) | direct |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::launcher::triple_chevron::doit` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x148208 | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::launcher::triple_chevron::doit` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x1482a5 | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::launcher::triple_chevron::doit` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x148311 | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::launcher::triple_chevron::doit` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x1483e5 | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::launcher::triple_chevron::doit` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x14848a | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::launcher::triple_chevron::doit` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x148507 | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<t` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x148741 | `?` | ? | unknown |

## `cudaError thrust::THRUST_200302_520_NS::cuda_cub::launcher::triple_chevron::doit` —— 1 次 launch

block 分布：None × 1
置信度：unknown 1

| 点 | kernel | block | 置信度 |
|---|---|---|---|
| 0x148928 | `?` | ? | unknown |

