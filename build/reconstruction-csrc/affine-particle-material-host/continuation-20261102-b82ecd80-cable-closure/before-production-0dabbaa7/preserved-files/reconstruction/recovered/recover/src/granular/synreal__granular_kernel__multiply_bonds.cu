// 机械还原自 PTX：synreal::granular_kernel::multiply_bonds(glm::vec<2, int, (glm::qualifier)0> const*, int const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, int, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*)
// PTX SHA256: 263096c7f513a69e1c36321ed4e5c7ead4defc1fcb93e05dc510e45cf95aa7f8
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__granular_kernel__multiply_bonds(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned param3, unsigned long long param4, unsigned long long param5) {
  int p0, p1, p2;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27;
  // PTX:22 ld.param.u64 %rd2, [_ZN7synreal15granular_kernel14multiply_bondsEPKN3glm3vecILi2EiLNS1_9qualifierE0EEEPKiPKNS1_3matILi3ELi3EfLS3_0EEEiPKNS2_ILi3EfLS3_0EEEPSD__param_0]
  rd2 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:23 ld.param.u64 %rd3, [_ZN7synreal15granular_kernel14multiply_bondsEPKN3glm3vecILi2EiLNS1_9qualifierE0EEEPKiPKNS1_3matILi3ELi3EfLS3_0EEEiPKNS2_ILi3EfLS3_0EEEPSD__param_1]
  rd3 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:24 ld.param.u64 %rd4, [_ZN7synreal15granular_kernel14multiply_bondsEPKN3glm3vecILi2EiLNS1_9qualifierE0EEEPKiPKNS1_3matILi3ELi3EfLS3_0EEEiPKNS2_ILi3EfLS3_0EEEPSD__param_2]
  rd4 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:25 ld.param.u32 %r2, [_ZN7synreal15granular_kernel14multiply_bondsEPKN3glm3vecILi2EiLNS1_9qualifierE0EEEPKiPKNS1_3matILi3ELi3EfLS3_0EEEiPKNS2_ILi3EfLS3_0EEEPSD__param_3]
  r2 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param3 + (0))));
  // PTX:26 ld.param.u64 %rd5, [_ZN7synreal15granular_kernel14multiply_bondsEPKN3glm3vecILi2EiLNS1_9qualifierE0EEEPKiPKNS1_3matILi3ELi3EfLS3_0EEEiPKNS2_ILi3EfLS3_0EEEPSD__param_4]
  rd5 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:27 ld.param.u64 %rd6, [_ZN7synreal15granular_kernel14multiply_bondsEPKN3glm3vecILi2EiLNS1_9qualifierE0EEEPKiPKNS1_3matILi3ELi3EfLS3_0EEEiPKNS2_ILi3EfLS3_0EEEPSD__param_5]
  rd6 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:28 mov.u32 %r3, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(blockDim.x));
  // PTX:29 mov.u32 %r4, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r4) : "r"(blockIdx.x));
  // PTX:30 mov.u32 %r5, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r5) : "r"(threadIdx.x));
  // PTX:31 mad.lo.s32 %r1, %r4, %r3, %r5
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r1) : "r"(r4), "r"(r3), "r"(r5));
  // PTX:32 setp.ge.s32 %p1, %r1, %r2
  p1 = (((int)(r1)) >= ((int)(r2)));
  // PTX:33 @%p1 bra $L__BB4_3
  if (p1) { goto L_BB4_3; }
  // PTX:35 cvta.to.global.u64 %rd7, %rd3
  rd7 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd3));
  // PTX:36 cvt.s64.s32 %rd1, %r1
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd1) : "r"(r1));
  // PTX:37 mul.wide.s32 %rd8, %r1, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd8) : "r"(r1));
  // PTX:38 add.s64 %rd9, %rd7, %rd8
  asm("add.s64 %0, %1, %2;" : "=l"(rd9) : "l"(rd7), "l"(rd8));
  // PTX:39 ld.global.u32 %r6, [%rd9]
  r6 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (0)))));
  // PTX:40 setp.eq.s32 %p2, %r6, 0
  p2 = (((int)(r6)) == ((int)(0)));
  // PTX:41 @%p2 bra $L__BB4_3
  if (p2) { goto L_BB4_3; }
  // PTX:43 cvta.to.global.u64 %rd10, %rd6
  rd10 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd6));
  // PTX:44 cvta.to.global.u64 %rd11, %rd5
  rd11 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd5));
  // PTX:45 cvta.to.global.u64 %rd12, %rd2
  rd12 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd2));
  // PTX:46 shl.b64 %rd13, %rd1, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd13) : "l"(rd1));
  // PTX:47 add.s64 %rd14, %rd12, %rd13
  asm("add.s64 %0, %1, %2;" : "=l"(rd14) : "l"(rd12), "l"(rd13));
  // PTX:48 ld.global.u32 %r7, [%rd14]
  r7 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:49 mul.wide.s32 %rd15, %r7, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd15) : "r"(r7));
  // PTX:50 add.s64 %rd16, %rd11, %rd15
  asm("add.s64 %0, %1, %2;" : "=l"(rd16) : "l"(rd11), "l"(rd15));
  // PTX:51 ld.global.u32 %r8, [%rd14+4]
  r8 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (4)))));
  // PTX:52 mul.wide.s32 %rd17, %r8, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd17) : "r"(r8));
  // PTX:53 add.s64 %rd18, %rd11, %rd17
  asm("add.s64 %0, %1, %2;" : "=l"(rd18) : "l"(rd11), "l"(rd17));
  // PTX:54 ld.global.f32 %f1, [%rd18]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (0)))));
  // PTX:55 ld.global.f32 %f2, [%rd16]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:56 sub.f32 %f3, %f2, %f1
  asm("sub.f32 %0, %1, %2;" : "=f"(f3) : "f"(f2), "f"(f1));
  // PTX:57 ld.global.f32 %f4, [%rd18+4]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (4)))));
  // PTX:58 ld.global.f32 %f5, [%rd16+4]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (4)))));
  // PTX:59 sub.f32 %f6, %f5, %f4
  asm("sub.f32 %0, %1, %2;" : "=f"(f6) : "f"(f5), "f"(f4));
  // PTX:60 ld.global.f32 %f7, [%rd18+8]
  f7 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (8)))));
  // PTX:61 ld.global.f32 %f8, [%rd16+8]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (8)))));
  // PTX:62 sub.f32 %f9, %f8, %f7
  asm("sub.f32 %0, %1, %2;" : "=f"(f9) : "f"(f8), "f"(f7));
  // PTX:63 cvta.to.global.u64 %rd19, %rd4
  rd19 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd4));
  // PTX:64 mul.lo.s64 %rd20, %rd1, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd20) : "l"(rd1));
  // PTX:65 add.s64 %rd21, %rd19, %rd20
  asm("add.s64 %0, %1, %2;" : "=l"(rd21) : "l"(rd19), "l"(rd20));
  // PTX:66 ld.global.f32 %f10, [%rd21]
  f10 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (0)))));
  // PTX:67 ld.global.f32 %f11, [%rd21+12]
  f11 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (12)))));
  // PTX:68 mul.f32 %f12, %f6, %f11
  asm("mul.f32 %0, %1, %2;" : "=f"(f12) : "f"(f6), "f"(f11));
  // PTX:69 fma.rn.f32 %f13, %f3, %f10, %f12
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f13) : "f"(f3), "f"(f10), "f"(f12));
  // PTX:70 ld.global.f32 %f14, [%rd21+24]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (24)))));
  // PTX:71 fma.rn.f32 %f15, %f9, %f14, %f13
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f15) : "f"(f9), "f"(f14), "f"(f13));
  // PTX:72 ld.global.f32 %f16, [%rd21+4]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (4)))));
  // PTX:73 ld.global.f32 %f17, [%rd21+16]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (16)))));
  // PTX:74 mul.f32 %f18, %f6, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f18) : "f"(f6), "f"(f17));
  // PTX:75 fma.rn.f32 %f19, %f3, %f16, %f18
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f19) : "f"(f3), "f"(f16), "f"(f18));
  // PTX:76 ld.global.f32 %f20, [%rd21+28]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (28)))));
  // PTX:77 fma.rn.f32 %f21, %f9, %f20, %f19
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f21) : "f"(f9), "f"(f20), "f"(f19));
  // PTX:78 ld.global.f32 %f22, [%rd21+8]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (8)))));
  // PTX:79 ld.global.f32 %f23, [%rd21+20]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (20)))));
  // PTX:80 mul.f32 %f24, %f6, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f24) : "f"(f6), "f"(f23));
  // PTX:81 fma.rn.f32 %f25, %f3, %f22, %f24
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f25) : "f"(f3), "f"(f22), "f"(f24));
  // PTX:82 ld.global.f32 %f26, [%rd21+32]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (32)))));
  // PTX:83 fma.rn.f32 %f27, %f9, %f26, %f25
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f27) : "f"(f9), "f"(f26), "f"(f25));
  // PTX:84 add.s64 %rd22, %rd10, %rd15
  asm("add.s64 %0, %1, %2;" : "=l"(rd22) : "l"(rd10), "l"(rd15));
  // PTX:85 red.global.add.f32 [%rd22], %f15
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (0)))), (float)(f15));
  // PTX:86 add.s64 %rd23, %rd22, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd23) : "l"(rd22));
  // PTX:87 red.global.add.f32 [%rd23], %f21
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (0)))), (float)(f21));
  // PTX:88 add.s64 %rd24, %rd22, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd24) : "l"(rd22));
  // PTX:89 red.global.add.f32 [%rd24], %f27
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (0)))), (float)(f27));
  // PTX:90 add.s64 %rd25, %rd10, %rd17
  asm("add.s64 %0, %1, %2;" : "=l"(rd25) : "l"(rd10), "l"(rd17));
  // PTX:91 neg.f32 %f31, %f15
  asm("neg.f32 %0, %1;" : "=f"(f31) : "f"(f15));
  // PTX:92 neg.f32 %f32, %f21
  asm("neg.f32 %0, %1;" : "=f"(f32) : "f"(f21));
  // PTX:93 neg.f32 %f33, %f27
  asm("neg.f32 %0, %1;" : "=f"(f33) : "f"(f27));
  // PTX:94 red.global.add.f32 [%rd25], %f31
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (0)))), (float)(f31));
  // PTX:95 add.s64 %rd26, %rd25, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd26) : "l"(rd25));
  // PTX:96 red.global.add.f32 [%rd26], %f32
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (0)))), (float)(f32));
  // PTX:97 add.s64 %rd27, %rd25, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd27) : "l"(rd25));
  // PTX:98 red.global.add.f32 [%rd27], %f33
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))), (float)(f33));
  // PTX:100 $L__BB4_3:
L_BB4_3:;
  // PTX:101 ret
  return;
}
