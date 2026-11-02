// 机械还原自 PTX：synreal::kernel::update_preconditioned_cg_direction(int, glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long)
// PTX SHA256: d53a8bc8c2efd766ec022aafd18c65f82d7123756341702e060bdfda79bf878a
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__update_preconditioned_cg_direction(unsigned param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4) {
  int p0, p1, p2, p3, p4, p5, p6;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15;
  // PTX:21 ld.param.u32 %r10, [_ZN7synreal6kernel34update_preconditioned_cg_directionEiPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKfPS4_m_param_0]
  r10 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param0 + (0))));
  // PTX:22 ld.param.u64 %rd3, [_ZN7synreal6kernel34update_preconditioned_cg_directionEiPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKfPS4_m_param_1]
  rd3 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:23 ld.param.u64 %rd4, [_ZN7synreal6kernel34update_preconditioned_cg_directionEiPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKfPS4_m_param_2]
  rd4 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:24 ld.param.u64 %rd5, [_ZN7synreal6kernel34update_preconditioned_cg_directionEiPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKfPS4_m_param_3]
  rd5 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:25 ld.param.u64 %rd6, [_ZN7synreal6kernel34update_preconditioned_cg_directionEiPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKfPS4_m_param_4]
  rd6 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:26 mov.u32 %r11, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r11) : "r"(blockIdx.x));
  // PTX:27 mov.u32 %r12, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r12) : "r"(blockDim.x));
  // PTX:28 mul.wide.u32 %rd7, %r11, %r12
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd7) : "r"(r11), "r"(r12));
  // PTX:29 mov.u32 %r13, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r13) : "r"(threadIdx.x));
  // PTX:30 cvt.u64.u32 %rd8, %r13
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd8) : "r"(r13));
  // PTX:31 add.s64 %rd1, %rd7, %rd8
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd7), "l"(rd8));
  // PTX:32 setp.ge.u64 %p1, %rd1, %rd6
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd6)));
  // PTX:33 @%p1 bra $L__BB0_7
  if (p1) { goto L_BB0_7; }
  // PTX:35 cvta.to.global.u64 %rd9, %rd3
  rd9 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd3));
  // PTX:36 mul.lo.s64 %rd10, %rd1, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd10) : "l"(rd1));
  // PTX:37 add.s64 %rd11, %rd9, %rd10
  asm("add.s64 %0, %1, %2;" : "=l"(rd11) : "l"(rd9), "l"(rd10));
  // PTX:38 ld.global.u32 %r14, [%rd11]
  r14 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (0)))));
  // PTX:39 ld.global.u32 %r15, [%rd11+4]
  r15 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (4)))));
  // PTX:40 ld.global.u32 %r16, [%rd11+8]
  r16 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (8)))));
  // PTX:41 cvta.to.global.u64 %rd12, %rd5
  rd12 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd5));
  // PTX:42 add.s64 %rd2, %rd12, %rd10
  asm("add.s64 %0, %1, %2;" : "=l"(rd2) : "l"(rd12), "l"(rd10));
  // PTX:43 setp.gt.s32 %p2, %r10, 0
  p2 = (((int)(r10)) > ((int)(0)));
  // PTX:44 mov.f32 %f19, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f19) : );
  // PTX:45 @%p2 bra $L__BB0_2
  if (p2) { goto L_BB0_2; }
  // PTX:46 bra.uni $L__BB0_6
  goto L_BB0_6;
  // PTX:48 $L__BB0_2:
L_BB0_2:;
  // PTX:49 cvta.to.global.u64 %rd13, %rd4
  rd13 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd4));
  // PTX:50 mul.wide.s32 %rd14, %r10, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd14) : "r"(r10));
  // PTX:51 add.s64 %rd15, %rd13, %rd14
  asm("add.s64 %0, %1, %2;" : "=l"(rd15) : "l"(rd13), "l"(rd14));
  // PTX:52 ld.global.f32 %f1, [%rd15]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))));
  // PTX:53 ld.global.f32 %f2, [%rd15+-4]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (-4)))));
  // PTX:54 abs.f32 %f6, %f2
  asm("abs.f32 %0, %1;" : "=f"(f6) : "f"(f2));
  // PTX:55 setp.leu.f32 %p3, %f6, 0f0DA24260
  p3 = ((isnan(((float)(f6))) || isnan(((float)(as_f32(0x0DA24260u))))) || (((float)(f6)) <= ((float)(as_f32(0x0DA24260u)))));
  // PTX:56 setp.gtu.f32 %p4, %f6, 0f7F800000
  p4 = ((isnan(((float)(f6))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f6)) > ((float)(as_f32(0x7F800000u)))));
  // PTX:57 or.pred %p5, %p3, %p4
  p5 = ((p3) || (p4));
  // PTX:58 @%p5 bra $L__BB0_5
  if (p5) { goto L_BB0_5; }
  // PTX:60 abs.f32 %f8, %f1
  asm("abs.f32 %0, %1;" : "=f"(f8) : "f"(f1));
  // PTX:61 setp.gtu.f32 %p6, %f8, 0f7F800000
  p6 = ((isnan(((float)(f8))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f8)) > ((float)(as_f32(0x7F800000u)))));
  // PTX:62 @%p6 bra $L__BB0_5
  if (p6) { goto L_BB0_5; }
  // PTX:64 div.rn.f32 %f19, %f1, %f2
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f19) : "f"(f1), "f"(f2));
  // PTX:66 $L__BB0_5:
L_BB0_5:;
  // PTX:67 ld.global.f32 %f9, [%rd2]
  f9 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (0)))));
  // PTX:68 ld.global.f32 %f10, [%rd2+4]
  f10 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (4)))));
  // PTX:69 ld.global.f32 %f11, [%rd2+8]
  f11 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (8)))));
  // PTX:70 mov.b32 %f12, %r14
  asm("mov.b32 %0, %1;" : "=f"(f12) : "r"(r14));
  // PTX:71 fma.rn.f32 %f13, %f19, %f9, %f12
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f13) : "f"(f19), "f"(f9), "f"(f12));
  // PTX:72 mov.b32 %r14, %f13
  asm("mov.b32 %0, %1;" : "=r"(r14) : "f"(f13));
  // PTX:73 mov.b32 %f14, %r15
  asm("mov.b32 %0, %1;" : "=f"(f14) : "r"(r15));
  // PTX:74 fma.rn.f32 %f15, %f19, %f10, %f14
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f15) : "f"(f19), "f"(f10), "f"(f14));
  // PTX:75 mov.b32 %r15, %f15
  asm("mov.b32 %0, %1;" : "=r"(r15) : "f"(f15));
  // PTX:76 mov.b32 %f16, %r16
  asm("mov.b32 %0, %1;" : "=f"(f16) : "r"(r16));
  // PTX:77 fma.rn.f32 %f17, %f19, %f11, %f16
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f17) : "f"(f19), "f"(f11), "f"(f16));
  // PTX:78 mov.b32 %r16, %f17
  asm("mov.b32 %0, %1;" : "=r"(r16) : "f"(f17));
  // PTX:80 $L__BB0_6:
L_BB0_6:;
  // PTX:81 st.global.u32 [%rd2], %r14
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (0))))) = (unsigned)(r14);
  // PTX:82 st.global.u32 [%rd2+4], %r15
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (4))))) = (unsigned)(r15);
  // PTX:83 st.global.u32 [%rd2+8], %r16
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (8))))) = (unsigned)(r16);
  // PTX:85 $L__BB0_7:
L_BB0_7:;
  // PTX:86 ret
  return;
}
