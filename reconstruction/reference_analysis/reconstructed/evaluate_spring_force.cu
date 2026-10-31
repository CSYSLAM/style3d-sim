// ============================================================================
// 从 _core.cpython-312-x86_64-linux-gnu.so 的 .nv_fatbin 中提取的 PTX 还原而来
// 来源: cuobjdump -ptx  ->  ptx 文件 3/6, arch=sm_52, PTX ISA 8.4
// 原始符号: _ZN7synreal6kernel21evaluate_spring_forceE
//           PKN3glm3vecILi3EfLNS1_9qualifierE0EEE
//           PKNS2_ILi2EiLS3_0EEEPKfSB_PS4_mmm
// 语义: synreal::kernel::evaluate_spring_force
//       (const Vec3*, const IVec2*, const float*, const float*,
//        Vec3*, size_t, size_t, size_t)
//
// 还原依据（逐条对应 PTX 指令，非猜测）:
//   PTX                                          -> C++
//   ---------------------------------------------------------------------
//   mad.lo.s32 / mul.wide.u32 + add.s64          -> i = blockIdx.x*blockDim.x+threadIdx.x
//   setp.ge.u64 %p1, %rd1, %rd17; bra            -> if (i >= n) return;
//   div.u64 %rd46, %rd1, %rd15                   -> batch = i / per_batch
//   sub.s64 %rd47, %rd1, batch*per_batch         -> slot  = i % per_batch
//   mul.lo.s64 %rd24, %rd46, %rd16               -> offset = batch * stride
//   ld.global.u32 [%rd27], [%rd27+4]             -> s = springs[slot]  (i32 x2)
//   add.s32 %r20,%r19,%r18 / %r22,%r21,%r18      -> a = s.x + offset; b = s.y + offset
//   ld.global.f32 ... sub.f32 (x3)               -> d = x[b] - x[a]
//   fma.rn x2 + sqrt.rn                          -> len = sqrt(dot(d, d))
//   setp.leu.f32 %p3, %f6, 0f00000000            -> 退化保护: len <= 0 时不归一化
//   div.rn.f32 x3                                -> unit = d / len
//   mul.f32 %f20, %f5, %f19                      -> rest_dir = rest_len * unit
//   sub.f32 (x3)                                 -> delta = d - rest_dir
//   mul.f32 %f28, %f4, %f25                      -> f = k * delta
//   red.global.add.f32 [a], f   /  [b], -f       -> atomicAdd(force[a], f); atomicAdd(force[b], -f)
//
// 结论: 这是一个标准 Hooke 弹簧力, 等价于 f = k * (|d| - rest) * (d/|d|),
//       PTX 里保留了全部中间量, 所以公式、符号约定、批处理布局都能逐条读出。
// ============================================================================

// 说明：原文件用 glm 类型，但本机无 glm 头文件；为可编译/可验证改用同布局的本地结构。
struct Vec3  { float x, y, z; };
struct IVec2 { int x, y; };

__global__ void evaluate_spring_force(
    const Vec3* x,          // param_0  粒子位置
    const IVec2* springs,   // param_1  每根弹簧的两个粒子下标
    const float* k,              // param_2  弹簧刚度 (逐弹簧)
    const float* rest,           // param_3  静止长度 (逐弹簧)
    Vec3* force,            // param_4  输出, 原子累加
    size_t total_springs,        // param_5  PTX: rd17, 上界
    size_t springs_per_batch,    // param_6  PTX: rd15, 用于 div/mod
    size_t particle_stride)      // param_7  PTX: rd16, 批偏移倍率
{
    const size_t i = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= total_springs) return;

    // PTX 显式做了 64 位 div + 余数（rd46 / rd47），说明一个 launch 覆盖多个 batch
    const size_t batch = i / springs_per_batch;
    const size_t slot  = i % springs_per_batch;
    const int    off   = (int)(batch * particle_stride);

    const IVec2 s = springs[slot];
    const int a = s.x + off;
    const int b = s.y + off;

    const Vec3 d{ x[b].x - x[a].x, x[b].y - x[a].y, x[b].z - x[a].z };

    const float kk   = k[slot];
    const float rest_len = rest[slot];

    const float len = sqrtf(d.x * d.x + d.y * d.y + d.z * d.z);

    // PTX: setp.leu f32 <= 0  -> 走 $L__BB13_6 分支时写入 0 向量
    Vec3 unit{0.0f, 0.0f, 0.0f};
    if (len > 0.0f) unit = Vec3{ d.x / len, d.y / len, d.z / len };

    const Vec3 f{ kk * (d.x - rest_len * unit.x),
                  kk * (d.y - rest_len * unit.y),
                  kk * (d.z - rest_len * unit.z) };

    atomicAdd(&force[a].x,  f.x);
    atomicAdd(&force[a].y,  f.y);
    atomicAdd(&force[a].z,  f.z);
    atomicAdd(&force[b].x, -f.x);
    atomicAdd(&force[b].y, -f.y);
    atomicAdd(&force[b].z, -f.z);
}
