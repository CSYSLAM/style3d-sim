// 机械还原自 PTX：synreal::granular_kernel::commit_bonds(synreal::Model, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, float const*, float*, int*, int)
// PTX SHA256: 5eb76e3fe5f24f17990feff2c25d8290a108621173e870b77bbac1fddb060e58
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__granular_kernel__commit_bonds(ByVal<1864, 8> param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned param6) {
  int p0, p1, p2, p3;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26;
  // PTX:23 mov.b64 %rd5, _ZN7synreal15granular_kernel12commit_bondsENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKNS3_ILi2EiLS4_0EEEPKfPfPii_param_0
  rd5 = (unsigned long long)(uintptr_t)&param0;
  // PTX:24 ld.param.u64 %rd6, [_ZN7synreal15granular_kernel12commit_bondsENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKNS3_ILi2EiLS4_0EEEPKfPfPii_param_1]
  rd6 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:25 ld.param.u64 %rd7, [_ZN7synreal15granular_kernel12commit_bondsENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKNS3_ILi2EiLS4_0EEEPKfPfPii_param_2]
  rd7 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:26 ld.param.u64 %rd8, [_ZN7synreal15granular_kernel12commit_bondsENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKNS3_ILi2EiLS4_0EEEPKfPfPii_param_3]
  rd8 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:27 ld.param.u64 %rd9, [_ZN7synreal15granular_kernel12commit_bondsENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKNS3_ILi2EiLS4_0EEEPKfPfPii_param_4]
  rd9 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:28 ld.param.u64 %rd10, [_ZN7synreal15granular_kernel12commit_bondsENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKNS3_ILi2EiLS4_0EEEPKfPfPii_param_5]
  rd10 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:29 ld.param.u32 %r2, [_ZN7synreal15granular_kernel12commit_bondsENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKNS3_ILi2EiLS4_0EEEPKfPfPii_param_6]
  r2 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param6 + (0))));
  // PTX:30 mov.u32 %r3, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(blockDim.x));
  // PTX:31 mov.u32 %r4, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r4) : "r"(blockIdx.x));
  // PTX:32 mov.u32 %r5, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r5) : "r"(threadIdx.x));
  // PTX:33 mad.lo.s32 %r1, %r4, %r3, %r5
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r1) : "r"(r4), "r"(r3), "r"(r5));
  // PTX:34 setp.ge.s32 %p1, %r1, %r2
  p1 = (((int)(r1)) >= ((int)(r2)));
  // PTX:35 @%p1 bra $L__BB5_5
  if (p1) { goto L_BB5_5; }
  // PTX:37 cvta.to.global.u64 %rd11, %rd10
  rd11 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd10));
  // PTX:38 cvt.s64.s32 %rd1, %r1
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd1) : "r"(r1));
  // PTX:39 mul.wide.s32 %rd12, %r1, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd12) : "r"(r1));
  // PTX:40 add.s64 %rd2, %rd11, %rd12
  asm("add.s64 %0, %1, %2;" : "=l"(rd2) : "l"(rd11), "l"(rd12));
  // PTX:41 ld.global.u32 %r6, [%rd2]
  r6 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (0)))));
  // PTX:42 setp.eq.s32 %p2, %r6, 0
  p2 = (((int)(r6)) == ((int)(0)));
  // PTX:43 @%p2 bra $L__BB5_5
  if (p2) { goto L_BB5_5; }
  // PTX:45 cvta.to.global.u64 %rd13, %rd6
  rd13 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd6));
  // PTX:46 cvta.to.global.u64 %rd14, %rd7
  rd14 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd7));
  // PTX:47 shl.b64 %rd15, %rd1, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd15) : "l"(rd1));
  // PTX:48 add.s64 %rd16, %rd14, %rd15
  asm("add.s64 %0, %1, %2;" : "=l"(rd16) : "l"(rd14), "l"(rd15));
  // PTX:49 ld.global.u32 %r7, [%rd16]
  r7 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:50 mul.wide.s32 %rd17, %r7, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd17) : "r"(r7));
  // PTX:51 add.s64 %rd18, %rd13, %rd17
  asm("add.s64 %0, %1, %2;" : "=l"(rd18) : "l"(rd13), "l"(rd17));
  // PTX:52 ld.global.u32 %r8, [%rd16+4]
  r8 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (4)))));
  // PTX:53 mul.wide.s32 %rd19, %r8, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd19) : "r"(r8));
  // PTX:54 add.s64 %rd20, %rd13, %rd19
  asm("add.s64 %0, %1, %2;" : "=l"(rd20) : "l"(rd13), "l"(rd19));
  // PTX:55 ld.global.f32 %f3, [%rd20]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))));
  // PTX:56 ld.global.f32 %f4, [%rd18]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (0)))));
  // PTX:57 sub.f32 %f5, %f4, %f3
  asm("sub.f32 %0, %1, %2;" : "=f"(f5) : "f"(f4), "f"(f3));
  // PTX:58 ld.global.f32 %f6, [%rd20+4]
  f6 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (4)))));
  // PTX:59 ld.global.f32 %f7, [%rd18+4]
  f7 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (4)))));
  // PTX:60 sub.f32 %f8, %f7, %f6
  asm("sub.f32 %0, %1, %2;" : "=f"(f8) : "f"(f7), "f"(f6));
  // PTX:61 ld.global.f32 %f9, [%rd20+8]
  f9 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (8)))));
  // PTX:62 ld.global.f32 %f10, [%rd18+8]
  f10 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (8)))));
  // PTX:63 sub.f32 %f11, %f10, %f9
  asm("sub.f32 %0, %1, %2;" : "=f"(f11) : "f"(f10), "f"(f9));
  // PTX:64 mul.f32 %f12, %f8, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f12) : "f"(f8), "f"(f8));
  // PTX:65 fma.rn.f32 %f13, %f5, %f5, %f12
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f13) : "f"(f5), "f"(f5), "f"(f12));
  // PTX:66 fma.rn.f32 %f14, %f11, %f11, %f13
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f14) : "f"(f11), "f"(f11), "f"(f13));
  // PTX:67 sqrt.rn.f32 %f1, %f14
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f1) : "f"(f14));
  // PTX:68 add.s64 %rd3, %rd5, 324
  asm("add.s64 %0, %1, 324;" : "=l"(rd3) : "l"(rd5));
  // PTX:69 ld.param.f32 %f15, [%rd5+324]
  f15 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd5) + (324))));
  // PTX:70 add.f32 %f16, %f15, 0f3F800000
  asm("add.f32 %0, %1, 0f3F800000;" : "=f"(f16) : "f"(f15));
  // PTX:71 cvta.to.global.u64 %rd22, %rd9
  rd22 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd9));
  // PTX:72 shl.b64 %rd23, %rd1, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd23) : "l"(rd1));
  // PTX:73 add.s64 %rd4, %rd22, %rd23
  asm("add.s64 %0, %1, %2;" : "=l"(rd4) : "l"(rd22), "l"(rd23));
  // PTX:74 ld.global.f32 %f2, [%rd4]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd4) + (0)))));
  // PTX:75 mul.f32 %f17, %f2, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f17) : "f"(f2), "f"(f16));
  // PTX:76 setp.gt.f32 %p3, %f1, %f17
  p3 = (!(isnan(((float)(f1))) || isnan(((float)(f17)))) && (((float)(f1)) > ((float)(f17))));
  // PTX:77 @%p3 bra $L__BB5_4
  if (p3) { goto L_BB5_4; }
  // PTX:78 bra.uni $L__BB5_3
  goto L_BB5_3;
  // PTX:80 $L__BB5_4:
L_BB5_4:;
  // PTX:81 mov.u32 %r9, 0
  asm("mov.u32 %0, 0;" : "=r"(r9) : );
  // PTX:82 st.global.u32 [%rd2], %r9
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (0))))) = (unsigned)(r9);
  // PTX:83 bra.uni $L__BB5_5
  goto L_BB5_5;
  // PTX:85 $L__BB5_3:
L_BB5_3:;
  // PTX:86 cvta.to.global.u64 %rd24, %rd8
  rd24 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd8));
  // PTX:87 add.s64 %rd26, %rd24, %rd23
  asm("add.s64 %0, %1, %2;" : "=l"(rd26) : "l"(rd24), "l"(rd23));
  // PTX:88 ld.param.f32 %f18, [%rd3+-4]
  f18 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd3) + (-4))));
  // PTX:89 mov.f32 %f19, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f19) : );
  // PTX:90 sub.f32 %f20, %f19, %f18
  asm("sub.f32 %0, %1, %2;" : "=f"(f20) : "f"(f19), "f"(f18));
  // PTX:91 ld.global.f32 %f21, [%rd26]
  f21 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (0)))));
  // PTX:92 mul.f32 %f22, %f21, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f22) : "f"(f21), "f"(f20));
  // PTX:93 ld.param.f32 %f23, [%rd3+-8]
  f23 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd3) + (-8))));
  // PTX:94 fma.rn.f32 %f24, %f21, %f23, %f1
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f24) : "f"(f21), "f"(f23), "f"(f1));
  // PTX:95 min.f32 %f25, %f2, %f24
  asm("min.f32 %0, %1, %2;" : "=f"(f25) : "f"(f2), "f"(f24));
  // PTX:96 max.f32 %f26, %f22, %f25
  asm("max.f32 %0, %1, %2;" : "=f"(f26) : "f"(f22), "f"(f25));
  // PTX:97 st.global.f32 [%rd4], %f26
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd4) + (0))))) = (float)(f26);
  // PTX:99 $L__BB5_5:
L_BB5_5:;
  // PTX:100 ret
  return;
}
