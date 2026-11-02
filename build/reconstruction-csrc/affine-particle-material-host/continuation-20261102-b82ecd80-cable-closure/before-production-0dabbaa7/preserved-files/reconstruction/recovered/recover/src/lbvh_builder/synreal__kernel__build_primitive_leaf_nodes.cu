// 机械还原自 PTX：synreal::kernel::build_primitive_leaf_nodes(int*, int const*, unsigned int)
// PTX SHA256: 021ab266a70c7a02eb7ac47262b1513cb753cdcc107fed2cd61a60124d2cb60b
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__build_primitive_leaf_nodes(unsigned long long param0, unsigned long long param1, unsigned param2) {
  int p0, p1;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8;
  // PTX:18 ld.param.u64 %rd1, [_ZN7synreal6kernel26build_primitive_leaf_nodesEPiPKij_param_0]
  rd1 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:19 ld.param.u64 %rd2, [_ZN7synreal6kernel26build_primitive_leaf_nodesEPiPKij_param_1]
  rd2 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:20 ld.param.u32 %r2, [_ZN7synreal6kernel26build_primitive_leaf_nodesEPiPKij_param_2]
  r2 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param2 + (0))));
  // PTX:21 mov.u32 %r3, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(blockIdx.x));
  // PTX:22 mov.u32 %r4, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r4) : "r"(blockDim.x));
  // PTX:23 mov.u32 %r5, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r5) : "r"(threadIdx.x));
  // PTX:24 mad.lo.s32 %r1, %r3, %r4, %r5
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r1) : "r"(r3), "r"(r4), "r"(r5));
  // PTX:25 setp.ge.u32 %p1, %r1, %r2
  p1 = (((unsigned)(r1)) >= ((unsigned)(r2)));
  // PTX:26 @%p1 bra $L__BB3_2
  if (p1) { goto L_BB3_2; }
  // PTX:28 cvta.to.global.u64 %rd3, %rd2
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd2));
  // PTX:29 mul.wide.u32 %rd4, %r1, 4
  asm("mul.wide.u32 %0, %1, 4;" : "=l"(rd4) : "r"(r1));
  // PTX:30 add.s64 %rd5, %rd3, %rd4
  asm("add.s64 %0, %1, %2;" : "=l"(rd5) : "l"(rd3), "l"(rd4));
  // PTX:31 add.s32 %r6, %r1, %r2
  asm("add.s32 %0, %1, %2;" : "=r"(r6) : "r"(r1), "r"(r2));
  // PTX:32 add.s32 %r7, %r6, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r7) : "r"(r6));
  // PTX:33 ld.global.u32 %r8, [%rd5]
  r8 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (0)))));
  // PTX:34 cvta.to.global.u64 %rd6, %rd1
  rd6 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd1));
  // PTX:35 mul.wide.s32 %rd7, %r8, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd7) : "r"(r8));
  // PTX:36 add.s64 %rd8, %rd6, %rd7
  asm("add.s64 %0, %1, %2;" : "=l"(rd8) : "l"(rd6), "l"(rd7));
  // PTX:37 st.global.u32 [%rd8], %r7
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (0))))) = (unsigned)(r7);
  // PTX:39 $L__BB3_2:
L_BB3_2:;
  // PTX:40 ret
  return;
}
