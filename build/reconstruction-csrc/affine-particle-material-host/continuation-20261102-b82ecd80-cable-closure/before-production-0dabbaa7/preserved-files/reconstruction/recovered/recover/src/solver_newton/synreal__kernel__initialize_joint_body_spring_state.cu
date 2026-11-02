// 机械还原自 PTX：synreal::kernel::initialize_joint_body_spring_state(glm::vec<3, float, (glm::qualifier)0>*, unsigned long)
// PTX SHA256: bdc61634933a2cfe2248358642f834b3a4196f907b6675a6316b930d3ab9ab3f
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__initialize_joint_body_spring_state(unsigned long long param0, unsigned long long param1) {
  int p0, p1;
  unsigned r0, r1, r2, r3, r4;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8;
  // PTX:17 ld.param.u64 %rd2, [_ZN7synreal6kernel34initialize_joint_body_spring_stateEPN3glm3vecILi3EfLNS1_9qualifierE0EEEm_param_0]
  rd2 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:18 ld.param.u64 %rd3, [_ZN7synreal6kernel34initialize_joint_body_spring_stateEPN3glm3vecILi3EfLNS1_9qualifierE0EEEm_param_1]
  rd3 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:19 mov.u32 %r1, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r1) : "r"(blockIdx.x));
  // PTX:20 mov.u32 %r2, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockDim.x));
  // PTX:21 mul.wide.u32 %rd4, %r1, %r2
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd4) : "r"(r1), "r"(r2));
  // PTX:22 mov.u32 %r3, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(threadIdx.x));
  // PTX:23 cvt.u64.u32 %rd5, %r3
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd5) : "r"(r3));
  // PTX:24 add.s64 %rd1, %rd4, %rd5
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd4), "l"(rd5));
  // PTX:25 setp.ge.u64 %p1, %rd1, %rd3
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd3)));
  // PTX:26 @%p1 bra $L__BB22_2
  if (p1) { goto L_BB22_2; }
  // PTX:28 cvta.to.global.u64 %rd6, %rd2
  rd6 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd2));
  // PTX:29 mul.lo.s64 %rd7, %rd1, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd7) : "l"(rd1));
  // PTX:30 add.s64 %rd8, %rd6, %rd7
  asm("add.s64 %0, %1, %2;" : "=l"(rd8) : "l"(rd6), "l"(rd7));
  // PTX:31 mov.u32 %r4, 0
  asm("mov.u32 %0, 0;" : "=r"(r4) : );
  // PTX:32 st.global.u32 [%rd8], %r4
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (0))))) = (unsigned)(r4);
  // PTX:33 st.global.u32 [%rd8+4], %r4
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (4))))) = (unsigned)(r4);
  // PTX:34 st.global.u32 [%rd8+8], %r4
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (8))))) = (unsigned)(r4);
  // PTX:36 $L__BB22_2:
L_BB22_2:;
  // PTX:37 ret
  return;
}
