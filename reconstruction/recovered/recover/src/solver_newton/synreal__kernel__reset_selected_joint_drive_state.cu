// 机械还原自 PTX：synreal::kernel::reset_selected_joint_drive_state(int const*, int*, unsigned long)
// PTX SHA256: be56a35201d5c822f16abeb6a6e6276f5b4b56d3df9c16382fe0051209ab30e5
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__reset_selected_joint_drive_state(unsigned long long param0, unsigned long long param1, unsigned long long param2) {
  int p0, p1, p2;
  unsigned r0, r1, r2, r3, r4, r5;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12;
  // PTX:18 ld.param.u64 %rd2, [_ZN7synreal6kernel32reset_selected_joint_drive_stateEPKiPim_param_0]
  rd2 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:19 ld.param.u64 %rd3, [_ZN7synreal6kernel32reset_selected_joint_drive_stateEPKiPim_param_1]
  rd3 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:20 ld.param.u64 %rd4, [_ZN7synreal6kernel32reset_selected_joint_drive_stateEPKiPim_param_2]
  rd4 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:21 mov.u32 %r1, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r1) : "r"(blockIdx.x));
  // PTX:22 mov.u32 %r2, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockDim.x));
  // PTX:23 mul.wide.u32 %rd5, %r1, %r2
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd5) : "r"(r1), "r"(r2));
  // PTX:24 mov.u32 %r3, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(threadIdx.x));
  // PTX:25 cvt.u64.u32 %rd6, %r3
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd6) : "r"(r3));
  // PTX:26 add.s64 %rd1, %rd5, %rd6
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd5), "l"(rd6));
  // PTX:27 setp.ge.u64 %p1, %rd1, %rd4
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd4)));
  // PTX:28 @%p1 bra $L__BB30_3
  if (p1) { goto L_BB30_3; }
  // PTX:30 cvta.to.global.u64 %rd7, %rd2
  rd7 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd2));
  // PTX:31 shl.b64 %rd8, %rd1, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd8) : "l"(rd1));
  // PTX:32 add.s64 %rd9, %rd7, %rd8
  asm("add.s64 %0, %1, %2;" : "=l"(rd9) : "l"(rd7), "l"(rd8));
  // PTX:33 ld.global.u32 %r4, [%rd9]
  r4 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (0)))));
  // PTX:34 setp.eq.s32 %p2, %r4, 0
  p2 = (((int)(r4)) == ((int)(0)));
  // PTX:35 @%p2 bra $L__BB30_3
  if (p2) { goto L_BB30_3; }
  // PTX:37 cvta.to.global.u64 %rd10, %rd3
  rd10 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd3));
  // PTX:38 add.s64 %rd12, %rd10, %rd8
  asm("add.s64 %0, %1, %2;" : "=l"(rd12) : "l"(rd10), "l"(rd8));
  // PTX:39 mov.u32 %r5, 0
  asm("mov.u32 %0, 0;" : "=r"(r5) : );
  // PTX:40 st.global.u32 [%rd12], %r5
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (0))))) = (unsigned)(r5);
  // PTX:42 $L__BB30_3:
L_BB30_3:;
  // PTX:43 ret
  return;
}
