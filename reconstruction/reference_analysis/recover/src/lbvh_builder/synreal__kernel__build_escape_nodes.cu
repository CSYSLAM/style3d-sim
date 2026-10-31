// 机械还原自 PTX：synreal::kernel::build_escape_nodes(int*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, unsigned int)
// PTX SHA256: 431ebbf3256100f05629344b0597eb53f057a90719ac32536e835dc69501092a
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__build_escape_nodes(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned param3) {
  int p0, p1, p2, p3, p4;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13;
  // PTX:19 ld.param.u64 %rd5, [_ZN7synreal6kernel18build_escape_nodesEPiPKiPKN3glm3vecILi2EiLNS4_9qualifierE0EEEj_param_0]
  rd5 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:20 ld.param.u64 %rd6, [_ZN7synreal6kernel18build_escape_nodesEPiPKiPKN3glm3vecILi2EiLNS4_9qualifierE0EEEj_param_1]
  rd6 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:21 ld.param.u64 %rd7, [_ZN7synreal6kernel18build_escape_nodesEPiPKiPKN3glm3vecILi2EiLNS4_9qualifierE0EEEj_param_2]
  rd7 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:22 ld.param.u32 %r6, [_ZN7synreal6kernel18build_escape_nodesEPiPKiPKN3glm3vecILi2EiLNS4_9qualifierE0EEEj_param_3]
  r6 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param3 + (0))));
  // PTX:23 mov.u32 %r7, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r7) : "r"(blockDim.x));
  // PTX:24 mov.u32 %r8, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r8) : "r"(blockIdx.x));
  // PTX:25 mov.u32 %r9, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r9) : "r"(threadIdx.x));
  // PTX:26 mad.lo.s32 %r1, %r8, %r7, %r9
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r1) : "r"(r8), "r"(r7), "r"(r9));
  // PTX:27 setp.ge.u32 %p1, %r1, %r6
  p1 = (((unsigned)(r1)) >= ((unsigned)(r6)));
  // PTX:28 @%p1 bra $L__BB2_7
  if (p1) { goto L_BB2_7; }
  // PTX:30 cvta.to.global.u64 %rd1, %rd6
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd6));
  // PTX:31 cvta.to.global.u64 %rd2, %rd7
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd7));
  // PTX:32 cvta.to.global.u64 %rd3, %rd5
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd5));
  // PTX:33 mov.u32 %r12, %r1
  asm("mov.u32 %0, %1;" : "=r"(r12) : "r"(r1));
  // PTX:35 $L__BB2_2:
L_BB2_2:;
  // PTX:36 mul.wide.s32 %rd8, %r12, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd8) : "r"(r12));
  // PTX:37 add.s64 %rd9, %rd1, %rd8
  asm("add.s64 %0, %1, %2;" : "=l"(rd9) : "l"(rd1), "l"(rd8));
  // PTX:38 ld.global.u32 %r3, [%rd9]
  r3 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (0)))));
  // PTX:39 setp.lt.s32 %p2, %r3, 0
  p2 = (((int)(r3)) < ((int)(0)));
  // PTX:40 mul.wide.s32 %rd10, %r3, 8
  asm("mul.wide.s32 %0, %1, 8;" : "=l"(rd10) : "r"(r3));
  // PTX:41 add.s64 %rd11, %rd2, %rd10
  asm("add.s64 %0, %1, %2;" : "=l"(rd11) : "l"(rd2), "l"(rd10));
  // PTX:42 add.s64 %rd4, %rd11, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd4) : "l"(rd11));
  // PTX:43 @%p2 bra $L__BB2_4
  if (p2) { goto L_BB2_4; }
  // PTX:45 ld.global.u32 %r10, [%rd4]
  r10 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd4) + (0)))));
  // PTX:46 setp.eq.s32 %p3, %r10, %r12
  p3 = (((int)(r10)) == ((int)(r12)));
  // PTX:47 mov.u32 %r12, %r3
  asm("mov.u32 %0, %1;" : "=r"(r12) : "r"(r3));
  // PTX:48 @%p3 bra $L__BB2_2
  if (p3) { goto L_BB2_2; }
  // PTX:50 $L__BB2_4:
L_BB2_4:;
  // PTX:51 mov.u32 %r13, -1
  asm("mov.u32 %0, -1;" : "=r"(r13) : );
  // PTX:52 @%p2 bra $L__BB2_6
  if (p2) { goto L_BB2_6; }
  // PTX:54 ld.global.u32 %r13, [%rd4]
  r13 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd4) + (0)))));
  // PTX:56 $L__BB2_6:
L_BB2_6:;
  // PTX:57 mul.wide.u32 %rd12, %r1, 4
  asm("mul.wide.u32 %0, %1, 4;" : "=l"(rd12) : "r"(r1));
  // PTX:58 add.s64 %rd13, %rd3, %rd12
  asm("add.s64 %0, %1, %2;" : "=l"(rd13) : "l"(rd3), "l"(rd12));
  // PTX:59 st.global.u32 [%rd13], %r13
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0))))) = (unsigned)(r13);
  // PTX:61 $L__BB2_7:
L_BB2_7:;
  // PTX:62 ret
  return;
}
