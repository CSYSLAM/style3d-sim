// 机械还原自 PTX：synreal::fluid_kernel::bound_scale(synreal::fluid_kernel::View, glm::vec<3, float, (glm::qualifier)0> const*, float, float, float*)
// PTX SHA256: 8147985dd5e2de6ba9c128ac62023ac645bbced6a35ac8fc622adf7bbfc1d46a
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__fluid_kernel__bound_scale(ByVal<112, 8> param0, unsigned long long param1, float param2, float param3, unsigned long long param4) {
  int p0, p1, p2, p3, p4;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25;
  // PTX:21 ld.param.v2.u32 {%r6, %r7}, [_ZN7synreal12fluid_kernel11bound_scaleENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEffPf_param_0+80]
  r6 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param0 + (80)))); r7 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param0 + (84))));
  // PTX:22 ld.param.v2.u32 {%r8, %r9}, [_ZN7synreal12fluid_kernel11bound_scaleENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEffPf_param_0+88]
  r8 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param0 + (88)))); r9 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param0 + (92))));
  // PTX:23 ld.param.u64 %rd12, [_ZN7synreal12fluid_kernel11bound_scaleENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEffPf_param_1]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:24 ld.param.f32 %f21, [_ZN7synreal12fluid_kernel11bound_scaleENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEffPf_param_2]
  f21 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param2 + (0))));
  // PTX:25 ld.param.f32 %f9, [_ZN7synreal12fluid_kernel11bound_scaleENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEffPf_param_3]
  f9 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param3 + (0))));
  // PTX:26 ld.param.u64 %rd13, [_ZN7synreal12fluid_kernel11bound_scaleENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEffPf_param_4]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:27 ld.param.u64 %rd5, [_ZN7synreal12fluid_kernel11bound_scaleENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEffPf_param_0+24]
  rd5 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (24))));
  // PTX:28 ld.param.u64 %rd4, [_ZN7synreal12fluid_kernel11bound_scaleENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEffPf_param_0+16]
  rd4 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (16))));
  // PTX:29 mov.u32 %r10, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r10) : "r"(blockDim.x));
  // PTX:30 mov.u32 %r11, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r11) : "r"(blockIdx.x));
  // PTX:31 mov.u32 %r12, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r12) : "r"(threadIdx.x));
  // PTX:32 mad.lo.s32 %r1, %r11, %r10, %r12
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r1) : "r"(r11), "r"(r10), "r"(r12));
  // PTX:33 setp.ge.s32 %p1, %r1, %r9
  p1 = (((int)(r1)) >= ((int)(r9)));
  // PTX:34 @%p1 bra $L__BB6_4
  if (p1) { goto L_BB6_4; }
  // PTX:36 cvta.to.global.u64 %rd14, %rd4
  rd14 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd4));
  // PTX:37 div.s32 %r13, %r1, %r8
  asm("div.s32 %0, %1, %2;" : "=r"(r13) : "r"(r1), "r"(r8));
  // PTX:38 mul.lo.s32 %r14, %r13, %r8
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r14) : "r"(r13), "r"(r8));
  // PTX:39 sub.s32 %r15, %r1, %r14
  asm("sub.s32 %0, %1, %2;" : "=r"(r15) : "r"(r1), "r"(r14));
  // PTX:40 mad.lo.s32 %r16, %r13, %r7, %r15
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r16) : "r"(r13), "r"(r7), "r"(r15));
  // PTX:41 cvt.s64.s32 %rd1, %r16
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd1) : "r"(r16));
  // PTX:42 mul.wide.s32 %rd15, %r16, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd15) : "r"(r16));
  // PTX:43 add.s64 %rd16, %rd14, %rd15
  asm("add.s64 %0, %1, %2;" : "=l"(rd16) : "l"(rd14), "l"(rd15));
  // PTX:44 ld.global.u32 %r17, [%rd16]
  r17 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:45 cvta.to.global.u64 %rd17, %rd12
  rd17 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd12));
  // PTX:46 mul.wide.s32 %rd18, %r17, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd18) : "r"(r17));
  // PTX:47 add.s64 %rd19, %rd17, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd17), "l"(rd18));
  // PTX:48 ld.global.f32 %f14, [%rd19]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))));
  // PTX:49 ld.global.f32 %f15, [%rd19+4]
  f15 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (4)))));
  // PTX:50 mul.f32 %f16, %f15, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f16) : "f"(f15), "f"(f15));
  // PTX:51 ld.global.f32 %f17, [%rd19+8]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (8)))));
  // PTX:52 fma.rn.f32 %f18, %f14, %f14, %f16
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f18) : "f"(f14), "f"(f14), "f"(f16));
  // PTX:53 fma.rn.f32 %f19, %f17, %f17, %f18
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f19) : "f"(f17), "f"(f17), "f"(f18));
  // PTX:54 sqrt.rn.f32 %f1, %f19
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f1) : "f"(f19));
  // PTX:55 setp.leu.f32 %p2, %f1, %f9
  p2 = ((isnan(((float)(f1))) || isnan(((float)(f9)))) || (((float)(f1)) <= ((float)(f9))));
  // PTX:56 setp.leu.f32 %p3, %f9, 0f00000000
  p3 = ((isnan(((float)(f9))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f9)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:57 or.pred %p4, %p3, %p2
  p4 = ((p3) || (p2));
  // PTX:58 @%p4 bra $L__BB6_3
  if (p4) { goto L_BB6_3; }
  // PTX:60 div.rn.f32 %f20, %f9, %f1
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f20) : "f"(f9), "f"(f1));
  // PTX:61 min.f32 %f21, %f21, %f20
  asm("min.f32 %0, %1, %2;" : "=f"(f21) : "f"(f21), "f"(f20));
  // PTX:63 $L__BB6_3:
L_BB6_3:;
  // PTX:64 cvta.to.global.u64 %rd20, %rd5
  rd20 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd5));
  // PTX:65 shl.b64 %rd21, %rd1, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd21) : "l"(rd1));
  // PTX:66 add.s64 %rd22, %rd20, %rd21
  asm("add.s64 %0, %1, %2;" : "=l"(rd22) : "l"(rd20), "l"(rd21));
  // PTX:67 ld.global.u32 %r18, [%rd22]
  r18 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (0)))));
  // PTX:68 cvta.to.global.u64 %rd23, %rd13
  rd23 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd13));
  // PTX:69 mul.wide.s32 %rd24, %r18, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd24) : "r"(r18));
  // PTX:70 add.s64 %rd25, %rd23, %rd24
  asm("add.s64 %0, %1, %2;" : "=l"(rd25) : "l"(rd23), "l"(rd24));
  // PTX:71 mov.b32 %r19, %f21
  asm("mov.b32 %0, %1;" : "=r"(r19) : "f"(f21));
  // PTX:72 red.global.min.s32 [%rd25], %r19
  atomicMin(reinterpret_cast<int*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (0)))), (int)(r19));
  // PTX:74 $L__BB6_4:
L_BB6_4:;
  // PTX:75 ret
  return;
}
