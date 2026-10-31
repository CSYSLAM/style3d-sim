// 机械还原自 PTX：synreal::fluid_kernel::scale_step(synreal::Model, glm::vec<3, float, (glm::qualifier)0>*, float const*, int)
// PTX SHA256: 9ce71b71ab845d01785be6efa360f93e2892dc0d6d0a15a7ced7b1efb882dbd7
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__fluid_kernel__scale_step(ByVal<1864, 8> param0, unsigned long long param1, unsigned long long param2, unsigned param3) {
  int p0, p1, p2, p3;
  float f0, f1, f2, f3, f4, f5, f6, f7;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16;
  // PTX:20 mov.b64 %rd2, _ZN7synreal12fluid_kernel10scale_stepENS_5ModelEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfi_param_0
  rd2 = (unsigned long long)(uintptr_t)&param0;
  // PTX:21 ld.param.u64 %rd3, [_ZN7synreal12fluid_kernel10scale_stepENS_5ModelEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfi_param_1]
  rd3 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:22 ld.param.u64 %rd4, [_ZN7synreal12fluid_kernel10scale_stepENS_5ModelEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfi_param_2]
  rd4 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:23 ld.param.u32 %r5, [_ZN7synreal12fluid_kernel10scale_stepENS_5ModelEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfi_param_3]
  r5 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param3 + (0))));
  // PTX:24 mov.u32 %r6, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r6) : "r"(blockDim.x));
  // PTX:25 mov.u32 %r7, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r7) : "r"(blockIdx.x));
  // PTX:26 mov.u32 %r8, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r8) : "r"(threadIdx.x));
  // PTX:27 mad.lo.s32 %r1, %r7, %r6, %r8
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r1) : "r"(r7), "r"(r6), "r"(r8));
  // PTX:28 setp.ge.s32 %p1, %r1, %r5
  p1 = (((int)(r1)) >= ((int)(r5)));
  // PTX:29 @%p1 bra $L__BB7_6
  if (p1) { goto L_BB7_6; }
  // PTX:31 add.s64 %rd1, %rd2, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd1) : "l"(rd2));
  // PTX:32 ld.param.v2.u32 {%r9, %r10}, [%rd2+24]
  r9 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)(rd2) + (24)))); r10 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)(rd2) + (28))));
  // PTX:33 setp.gt.u32 %p2, %r10, %r9
  p2 = (((unsigned)(r10)) > ((unsigned)(r9)));
  // PTX:34 @%p2 bra $L__BB7_4
  if (p2) { goto L_BB7_4; }
  // PTX:35 bra.uni $L__BB7_2
  goto L_BB7_2;
  // PTX:37 $L__BB7_4:
L_BB7_4:;
  // PTX:38 ld.param.u32 %r15, [%rd1]
  r15 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)(rd1) + (0))));
  // PTX:39 div.u32 %r16, %r1, %r15
  asm("div.u32 %0, %1, %2;" : "=r"(r16) : "r"(r1), "r"(r15));
  // PTX:40 bra.uni $L__BB7_5
  goto L_BB7_5;
  // PTX:42 $L__BB7_2:
L_BB7_2:;
  // PTX:43 ld.param.u64 %rd6, [%rd1+104]
  rd6 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd1) + (104))));
  // PTX:44 setp.eq.s64 %p3, %rd6, 0
  p3 = (((long long)(rd6)) == ((long long)(0)));
  // PTX:45 mov.u32 %r16, 0
  asm("mov.u32 %0, 0;" : "=r"(r16) : );
  // PTX:46 @%p3 bra $L__BB7_5
  if (p3) { goto L_BB7_5; }
  // PTX:48 ld.param.u64 %rd7, [%rd1+96]
  rd7 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd1) + (96))));
  // PTX:49 cvta.to.global.u64 %rd8, %rd7
  rd8 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd7));
  // PTX:50 mul.wide.s32 %rd9, %r1, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd9) : "r"(r1));
  // PTX:51 add.s64 %rd10, %rd8, %rd9
  asm("add.s64 %0, %1, %2;" : "=l"(rd10) : "l"(rd8), "l"(rd9));
  // PTX:52 ld.global.u32 %r14, [%rd10]
  r14 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (0)))));
  // PTX:53 max.s32 %r16, %r14, 0
  asm("max.s32 %0, %1, 0;" : "=r"(r16) : "r"(r14));
  // PTX:55 $L__BB7_5:
L_BB7_5:;
  // PTX:56 cvta.to.global.u64 %rd11, %rd3
  rd11 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd3));
  // PTX:57 mul.wide.s32 %rd12, %r1, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd12) : "r"(r1));
  // PTX:58 add.s64 %rd13, %rd11, %rd12
  asm("add.s64 %0, %1, %2;" : "=l"(rd13) : "l"(rd11), "l"(rd12));
  // PTX:59 cvta.to.global.u64 %rd14, %rd4
  rd14 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd4));
  // PTX:60 mul.wide.s32 %rd15, %r16, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd15) : "r"(r16));
  // PTX:61 add.s64 %rd16, %rd14, %rd15
  asm("add.s64 %0, %1, %2;" : "=l"(rd16) : "l"(rd14), "l"(rd15));
  // PTX:62 ld.global.f32 %f1, [%rd13]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))));
  // PTX:63 ld.global.f32 %f2, [%rd16]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:64 mul.f32 %f3, %f2, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f3) : "f"(f2), "f"(f1));
  // PTX:65 st.global.f32 [%rd13], %f3
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0))))) = (float)(f3);
  // PTX:66 ld.global.f32 %f4, [%rd13+4]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4)))));
  // PTX:67 mul.f32 %f5, %f2, %f4
  asm("mul.f32 %0, %1, %2;" : "=f"(f5) : "f"(f2), "f"(f4));
  // PTX:68 st.global.f32 [%rd13+4], %f5
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4))))) = (float)(f5);
  // PTX:69 ld.global.f32 %f6, [%rd13+8]
  f6 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8)))));
  // PTX:70 mul.f32 %f7, %f2, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f7) : "f"(f2), "f"(f6));
  // PTX:71 st.global.f32 [%rd13+8], %f7
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8))))) = (float)(f7);
  // PTX:73 $L__BB7_6:
L_BB7_6:;
  // PTX:74 ret
  return;
}
