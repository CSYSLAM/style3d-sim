// 机械还原自 PTX：synreal::kernel::multiply_affine_body_so3_augmented_lagrangian_tangent(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 9ec9e0430db767c70e6aa39c1b2a2074e8d453c53745a38b9844e9fb0f518242
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__multiply_affine_body_so3_augmented_lagrangian_tangent(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, float param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8) {
  int p0, p1, p2;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49;
  // PTX:25 ld.param.u64 %rd8, [_ZN7synreal6kernel53multiply_affine_body_so3_augmented_lagrangian_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmm_param_0]
  rd8 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:26 ld.param.u64 %rd9, [_ZN7synreal6kernel53multiply_affine_body_so3_augmented_lagrangian_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmm_param_1]
  rd9 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:27 ld.param.u64 %rd10, [_ZN7synreal6kernel53multiply_affine_body_so3_augmented_lagrangian_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmm_param_2]
  rd10 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:28 ld.param.u64 %rd11, [_ZN7synreal6kernel53multiply_affine_body_so3_augmented_lagrangian_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmm_param_3]
  rd11 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:29 ld.param.f32 %f1, [_ZN7synreal6kernel53multiply_affine_body_so3_augmented_lagrangian_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmm_param_4]
  f1 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param4 + (0))));
  // PTX:30 ld.param.u64 %rd12, [_ZN7synreal6kernel53multiply_affine_body_so3_augmented_lagrangian_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmm_param_5]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:31 ld.param.u64 %rd15, [_ZN7synreal6kernel53multiply_affine_body_so3_augmented_lagrangian_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmm_param_6]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:32 ld.param.u64 %rd13, [_ZN7synreal6kernel53multiply_affine_body_so3_augmented_lagrangian_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmm_param_7]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:33 ld.param.u64 %rd14, [_ZN7synreal6kernel53multiply_affine_body_so3_augmented_lagrangian_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmm_param_8]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:34 mov.u32 %r1, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r1) : "r"(blockIdx.x));
  // PTX:35 mov.u32 %r2, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockDim.x));
  // PTX:36 mul.wide.u32 %rd16, %r1, %r2
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd16) : "r"(r1), "r"(r2));
  // PTX:37 mov.u32 %r3, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(threadIdx.x));
  // PTX:38 cvt.u64.u32 %rd17, %r3
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd17) : "r"(r3));
  // PTX:39 add.s64 %rd1, %rd16, %rd17
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd16), "l"(rd17));
  // PTX:40 setp.ge.u64 %p1, %rd1, %rd15
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd15)));
  // PTX:41 @%p1 bra $L__BB17_5
  if (p1) { goto L_BB17_5; }
  // PTX:43 or.b64 %rd18, %rd1, %rd13
  asm("or.b64 %0, %1, %2;" : "=l"(rd18) : "l"(rd1), "l"(rd13));
  // PTX:44 and.b64 %rd19, %rd18, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd19) : "l"(rd18));
  // PTX:45 setp.eq.s64 %p2, %rd19, 0
  p2 = (((long long)(rd19)) == ((long long)(0)));
  // PTX:46 @%p2 bra $L__BB17_3
  if (p2) { goto L_BB17_3; }
  // PTX:48 div.u64 %rd48, %rd1, %rd13
  asm("div.u64 %0, %1, %2;" : "=l"(rd48) : "l"(rd1), "l"(rd13));
  // PTX:49 mul.lo.s64 %rd20, %rd48, %rd13
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd20) : "l"(rd48), "l"(rd13));
  // PTX:50 sub.s64 %rd49, %rd1, %rd20
  asm("sub.s64 %0, %1, %2;" : "=l"(rd49) : "l"(rd1), "l"(rd20));
  // PTX:51 bra.uni $L__BB17_4
  goto L_BB17_4;
  // PTX:53 $L__BB17_3:
L_BB17_3:;
  // PTX:54 cvt.u32.u64 %r4, %rd13
  asm("cvt.u32.u64 %0, %1;" : "=r"(r4) : "l"(rd13));
  // PTX:55 cvt.u32.u64 %r5, %rd1
  asm("cvt.u32.u64 %0, %1;" : "=r"(r5) : "l"(rd1));
  // PTX:56 div.u32 %r6, %r5, %r4
  asm("div.u32 %0, %1, %2;" : "=r"(r6) : "r"(r5), "r"(r4));
  // PTX:57 mul.lo.s32 %r7, %r6, %r4
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r7) : "r"(r6), "r"(r4));
  // PTX:58 sub.s32 %r8, %r5, %r7
  asm("sub.s32 %0, %1, %2;" : "=r"(r8) : "r"(r5), "r"(r7));
  // PTX:59 cvt.u64.u32 %rd48, %r6
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd48) : "r"(r6));
  // PTX:60 cvt.u64.u32 %rd49, %r8
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd49) : "r"(r8));
  // PTX:62 $L__BB17_4:
L_BB17_4:;
  // PTX:63 cvta.to.global.u64 %rd21, %rd12
  rd21 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd12));
  // PTX:64 cvta.to.global.u64 %rd22, %rd8
  rd22 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd8));
  // PTX:65 mul.lo.s64 %rd23, %rd48, %rd14
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd23) : "l"(rd48), "l"(rd14));
  // PTX:66 cvt.u32.u64 %r9, %rd23
  asm("cvt.u32.u64 %0, %1;" : "=r"(r9) : "l"(rd23));
  // PTX:67 cvta.to.global.u64 %rd24, %rd9
  rd24 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd9));
  // PTX:68 shl.b64 %rd25, %rd49, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd25) : "l"(rd49));
  // PTX:69 add.s64 %rd26, %rd24, %rd25
  asm("add.s64 %0, %1, %2;" : "=l"(rd26) : "l"(rd24), "l"(rd25));
  // PTX:70 ld.global.u32 %r10, [%rd26+4]
  r10 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (4)))));
  // PTX:71 add.s32 %r11, %r10, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r11) : "r"(r10), "r"(r9));
  // PTX:72 ld.global.u32 %r12, [%rd26+8]
  r12 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (8)))));
  // PTX:73 add.s32 %r13, %r12, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r13) : "r"(r12), "r"(r9));
  // PTX:74 ld.global.u32 %r14, [%rd26+12]
  r14 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (12)))));
  // PTX:75 add.s32 %r15, %r14, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r15) : "r"(r14), "r"(r9));
  // PTX:76 mul.wide.s32 %rd27, %r11, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd27) : "r"(r11));
  // PTX:77 add.s64 %rd28, %rd22, %rd27
  asm("add.s64 %0, %1, %2;" : "=l"(rd28) : "l"(rd22), "l"(rd27));
  // PTX:78 mul.wide.s32 %rd29, %r13, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd29) : "r"(r13));
  // PTX:79 add.s64 %rd30, %rd22, %rd29
  asm("add.s64 %0, %1, %2;" : "=l"(rd30) : "l"(rd22), "l"(rd29));
  // PTX:80 mul.wide.s32 %rd31, %r15, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd31) : "r"(r15));
  // PTX:81 add.s64 %rd32, %rd22, %rd31
  asm("add.s64 %0, %1, %2;" : "=l"(rd32) : "l"(rd22), "l"(rd31));
  // PTX:82 cvta.to.global.u64 %rd33, %rd11
  rd33 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd11));
  // PTX:83 mul.lo.s64 %rd34, %rd1, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd34) : "l"(rd1));
  // PTX:84 add.s64 %rd35, %rd33, %rd34
  asm("add.s64 %0, %1, %2;" : "=l"(rd35) : "l"(rd33), "l"(rd34));
  // PTX:85 ld.global.f32 %f2, [%rd35]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (0)))));
  // PTX:86 ld.global.f32 %f3, [%rd28]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (0)))));
  // PTX:87 ld.global.f32 %f4, [%rd35+12]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (12)))));
  // PTX:88 ld.global.f32 %f5, [%rd35+24]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (24)))));
  // PTX:89 ld.global.f32 %f6, [%rd35+4]
  f6 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (4)))));
  // PTX:90 ld.global.f32 %f7, [%rd28+4]
  f7 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (4)))));
  // PTX:91 mul.f32 %f8, %f7, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f8) : "f"(f7), "f"(f6));
  // PTX:92 ld.global.f32 %f9, [%rd35+16]
  f9 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (16)))));
  // PTX:93 mul.f32 %f10, %f7, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f10) : "f"(f7), "f"(f9));
  // PTX:94 ld.global.f32 %f11, [%rd35+28]
  f11 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (28)))));
  // PTX:95 mul.f32 %f12, %f7, %f11
  asm("mul.f32 %0, %1, %2;" : "=f"(f12) : "f"(f7), "f"(f11));
  // PTX:96 fma.rn.f32 %f13, %f3, %f2, %f8
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f13) : "f"(f3), "f"(f2), "f"(f8));
  // PTX:97 fma.rn.f32 %f14, %f3, %f4, %f10
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f14) : "f"(f3), "f"(f4), "f"(f10));
  // PTX:98 fma.rn.f32 %f15, %f3, %f5, %f12
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f15) : "f"(f3), "f"(f5), "f"(f12));
  // PTX:99 ld.global.f32 %f16, [%rd35+8]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (8)))));
  // PTX:100 ld.global.f32 %f17, [%rd28+8]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (8)))));
  // PTX:101 ld.global.f32 %f18, [%rd35+20]
  f18 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (20)))));
  // PTX:102 ld.global.f32 %f19, [%rd35+32]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (32)))));
  // PTX:103 fma.rn.f32 %f20, %f17, %f16, %f13
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f20) : "f"(f17), "f"(f16), "f"(f13));
  // PTX:104 fma.rn.f32 %f21, %f17, %f18, %f14
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f21) : "f"(f17), "f"(f18), "f"(f14));
  // PTX:105 fma.rn.f32 %f22, %f17, %f19, %f15
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f22) : "f"(f17), "f"(f19), "f"(f15));
  // PTX:106 ld.global.f32 %f23, [%rd30]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0)))));
  // PTX:107 ld.global.f32 %f24, [%rd30+4]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (4)))));
  // PTX:108 mul.f32 %f25, %f24, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f25) : "f"(f24), "f"(f6));
  // PTX:109 mul.f32 %f26, %f24, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f26) : "f"(f24), "f"(f9));
  // PTX:110 mul.f32 %f27, %f24, %f11
  asm("mul.f32 %0, %1, %2;" : "=f"(f27) : "f"(f24), "f"(f11));
  // PTX:111 fma.rn.f32 %f28, %f23, %f2, %f25
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f28) : "f"(f23), "f"(f2), "f"(f25));
  // PTX:112 fma.rn.f32 %f29, %f23, %f4, %f26
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f29) : "f"(f23), "f"(f4), "f"(f26));
  // PTX:113 fma.rn.f32 %f30, %f23, %f5, %f27
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f30) : "f"(f23), "f"(f5), "f"(f27));
  // PTX:114 ld.global.f32 %f31, [%rd30+8]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (8)))));
  // PTX:115 fma.rn.f32 %f32, %f31, %f16, %f28
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f32) : "f"(f31), "f"(f16), "f"(f28));
  // PTX:116 fma.rn.f32 %f33, %f31, %f18, %f29
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f33) : "f"(f31), "f"(f18), "f"(f29));
  // PTX:117 fma.rn.f32 %f34, %f31, %f19, %f30
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f34) : "f"(f31), "f"(f19), "f"(f30));
  // PTX:118 ld.global.f32 %f35, [%rd32]
  f35 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (0)))));
  // PTX:119 ld.global.f32 %f36, [%rd32+4]
  f36 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (4)))));
  // PTX:120 mul.f32 %f37, %f36, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f37) : "f"(f36), "f"(f6));
  // PTX:121 mul.f32 %f38, %f36, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f38) : "f"(f36), "f"(f9));
  // PTX:122 mul.f32 %f39, %f36, %f11
  asm("mul.f32 %0, %1, %2;" : "=f"(f39) : "f"(f36), "f"(f11));
  // PTX:123 fma.rn.f32 %f40, %f35, %f2, %f37
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f40) : "f"(f35), "f"(f2), "f"(f37));
  // PTX:124 fma.rn.f32 %f41, %f35, %f4, %f38
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f41) : "f"(f35), "f"(f4), "f"(f38));
  // PTX:125 fma.rn.f32 %f42, %f35, %f5, %f39
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f42) : "f"(f35), "f"(f5), "f"(f39));
  // PTX:126 ld.global.f32 %f43, [%rd32+8]
  f43 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (8)))));
  // PTX:127 fma.rn.f32 %f44, %f43, %f16, %f40
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f44) : "f"(f43), "f"(f16), "f"(f40));
  // PTX:128 fma.rn.f32 %f45, %f43, %f18, %f41
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f45) : "f"(f43), "f"(f18), "f"(f41));
  // PTX:129 fma.rn.f32 %f46, %f43, %f19, %f42
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f46) : "f"(f43), "f"(f19), "f"(f42));
  // PTX:130 add.f32 %f47, %f20, %f20
  asm("add.f32 %0, %1, %2;" : "=f"(f47) : "f"(f20), "f"(f20));
  // PTX:131 add.f32 %f48, %f32, %f21
  asm("add.f32 %0, %1, %2;" : "=f"(f48) : "f"(f32), "f"(f21));
  // PTX:132 add.f32 %f49, %f44, %f22
  asm("add.f32 %0, %1, %2;" : "=f"(f49) : "f"(f44), "f"(f22));
  // PTX:133 add.f32 %f50, %f33, %f33
  asm("add.f32 %0, %1, %2;" : "=f"(f50) : "f"(f33), "f"(f33));
  // PTX:134 add.f32 %f51, %f45, %f34
  asm("add.f32 %0, %1, %2;" : "=f"(f51) : "f"(f45), "f"(f34));
  // PTX:135 add.f32 %f52, %f46, %f46
  asm("add.f32 %0, %1, %2;" : "=f"(f52) : "f"(f46), "f"(f46));
  // PTX:136 mul.f32 %f53, %f47, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f53) : "f"(f47));
  // PTX:137 mul.f32 %f54, %f48, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f54) : "f"(f48));
  // PTX:138 mul.f32 %f55, %f49, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f55) : "f"(f49));
  // PTX:139 mul.f32 %f56, %f50, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f56) : "f"(f50));
  // PTX:140 mul.f32 %f57, %f51, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f57) : "f"(f51));
  // PTX:141 mul.f32 %f58, %f52, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f58) : "f"(f52));
  // PTX:142 mul.f32 %f59, %f4, %f54
  asm("mul.f32 %0, %1, %2;" : "=f"(f59) : "f"(f4), "f"(f54));
  // PTX:143 mul.f32 %f60, %f9, %f54
  asm("mul.f32 %0, %1, %2;" : "=f"(f60) : "f"(f9), "f"(f54));
  // PTX:144 mul.f32 %f61, %f18, %f54
  asm("mul.f32 %0, %1, %2;" : "=f"(f61) : "f"(f18), "f"(f54));
  // PTX:145 fma.rn.f32 %f62, %f2, %f53, %f59
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f62) : "f"(f2), "f"(f53), "f"(f59));
  // PTX:146 fma.rn.f32 %f63, %f6, %f53, %f60
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f63) : "f"(f6), "f"(f53), "f"(f60));
  // PTX:147 fma.rn.f32 %f64, %f16, %f53, %f61
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f64) : "f"(f16), "f"(f53), "f"(f61));
  // PTX:148 fma.rn.f32 %f65, %f5, %f55, %f62
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f65) : "f"(f5), "f"(f55), "f"(f62));
  // PTX:149 fma.rn.f32 %f66, %f11, %f55, %f63
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f66) : "f"(f11), "f"(f55), "f"(f63));
  // PTX:150 fma.rn.f32 %f67, %f19, %f55, %f64
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f67) : "f"(f19), "f"(f55), "f"(f64));
  // PTX:151 mul.f32 %f68, %f4, %f56
  asm("mul.f32 %0, %1, %2;" : "=f"(f68) : "f"(f4), "f"(f56));
  // PTX:152 mul.f32 %f69, %f9, %f56
  asm("mul.f32 %0, %1, %2;" : "=f"(f69) : "f"(f9), "f"(f56));
  // PTX:153 mul.f32 %f70, %f18, %f56
  asm("mul.f32 %0, %1, %2;" : "=f"(f70) : "f"(f18), "f"(f56));
  // PTX:154 fma.rn.f32 %f71, %f2, %f54, %f68
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f71) : "f"(f2), "f"(f54), "f"(f68));
  // PTX:155 fma.rn.f32 %f72, %f6, %f54, %f69
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f72) : "f"(f6), "f"(f54), "f"(f69));
  // PTX:156 fma.rn.f32 %f73, %f16, %f54, %f70
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f73) : "f"(f16), "f"(f54), "f"(f70));
  // PTX:157 fma.rn.f32 %f74, %f5, %f57, %f71
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f74) : "f"(f5), "f"(f57), "f"(f71));
  // PTX:158 fma.rn.f32 %f75, %f11, %f57, %f72
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f75) : "f"(f11), "f"(f57), "f"(f72));
  // PTX:159 fma.rn.f32 %f76, %f19, %f57, %f73
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f76) : "f"(f19), "f"(f57), "f"(f73));
  // PTX:160 mul.f32 %f77, %f4, %f57
  asm("mul.f32 %0, %1, %2;" : "=f"(f77) : "f"(f4), "f"(f57));
  // PTX:161 mul.f32 %f78, %f9, %f57
  asm("mul.f32 %0, %1, %2;" : "=f"(f78) : "f"(f9), "f"(f57));
  // PTX:162 mul.f32 %f79, %f18, %f57
  asm("mul.f32 %0, %1, %2;" : "=f"(f79) : "f"(f18), "f"(f57));
  // PTX:163 fma.rn.f32 %f80, %f2, %f55, %f77
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f80) : "f"(f2), "f"(f55), "f"(f77));
  // PTX:164 fma.rn.f32 %f81, %f6, %f55, %f78
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f81) : "f"(f6), "f"(f55), "f"(f78));
  // PTX:165 fma.rn.f32 %f82, %f16, %f55, %f79
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f82) : "f"(f16), "f"(f55), "f"(f79));
  // PTX:166 fma.rn.f32 %f83, %f5, %f58, %f80
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f83) : "f"(f5), "f"(f58), "f"(f80));
  // PTX:167 fma.rn.f32 %f84, %f11, %f58, %f81
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f84) : "f"(f11), "f"(f58), "f"(f81));
  // PTX:168 fma.rn.f32 %f85, %f19, %f58, %f82
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f85) : "f"(f19), "f"(f58), "f"(f82));
  // PTX:169 cvta.to.global.u64 %rd36, %rd10
  rd36 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd10));
  // PTX:170 shl.b64 %rd37, %rd49, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd37) : "l"(rd49));
  // PTX:171 add.s64 %rd38, %rd36, %rd37
  asm("add.s64 %0, %1, %2;" : "=l"(rd38) : "l"(rd36), "l"(rd37));
  // PTX:172 ld.global.f32 %f86, [%rd38]
  f86 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (0)))));
  // PTX:173 mul.f32 %f87, %f86, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f87) : "f"(f86), "f"(f1));
  // PTX:174 mul.f32 %f88, %f87, %f65
  asm("mul.f32 %0, %1, %2;" : "=f"(f88) : "f"(f87), "f"(f65));
  // PTX:175 mul.f32 %f89, %f87, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f89) : "f"(f87), "f"(f66));
  // PTX:176 mul.f32 %f90, %f87, %f67
  asm("mul.f32 %0, %1, %2;" : "=f"(f90) : "f"(f87), "f"(f67));
  // PTX:177 add.s64 %rd39, %rd21, %rd27
  asm("add.s64 %0, %1, %2;" : "=l"(rd39) : "l"(rd21), "l"(rd27));
  // PTX:178 red.global.add.f32 [%rd39], %f88
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (0)))), (float)(f88));
  // PTX:179 add.s64 %rd40, %rd39, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd40) : "l"(rd39));
  // PTX:180 red.global.add.f32 [%rd40], %f89
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (0)))), (float)(f89));
  // PTX:181 add.s64 %rd41, %rd39, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd41) : "l"(rd39));
  // PTX:182 red.global.add.f32 [%rd41], %f90
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (0)))), (float)(f90));
  // PTX:183 mul.f32 %f94, %f87, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f94) : "f"(f87), "f"(f74));
  // PTX:184 mul.f32 %f95, %f87, %f75
  asm("mul.f32 %0, %1, %2;" : "=f"(f95) : "f"(f87), "f"(f75));
  // PTX:185 mul.f32 %f96, %f87, %f76
  asm("mul.f32 %0, %1, %2;" : "=f"(f96) : "f"(f87), "f"(f76));
  // PTX:186 add.s64 %rd42, %rd21, %rd29
  asm("add.s64 %0, %1, %2;" : "=l"(rd42) : "l"(rd21), "l"(rd29));
  // PTX:187 red.global.add.f32 [%rd42], %f94
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (0)))), (float)(f94));
  // PTX:188 add.s64 %rd43, %rd42, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd43) : "l"(rd42));
  // PTX:189 red.global.add.f32 [%rd43], %f95
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (0)))), (float)(f95));
  // PTX:190 add.s64 %rd44, %rd42, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd44) : "l"(rd42));
  // PTX:191 red.global.add.f32 [%rd44], %f96
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))), (float)(f96));
  // PTX:192 mul.f32 %f100, %f87, %f83
  asm("mul.f32 %0, %1, %2;" : "=f"(f100) : "f"(f87), "f"(f83));
  // PTX:193 mul.f32 %f101, %f87, %f84
  asm("mul.f32 %0, %1, %2;" : "=f"(f101) : "f"(f87), "f"(f84));
  // PTX:194 mul.f32 %f102, %f87, %f85
  asm("mul.f32 %0, %1, %2;" : "=f"(f102) : "f"(f87), "f"(f85));
  // PTX:195 add.s64 %rd45, %rd21, %rd31
  asm("add.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd21), "l"(rd31));
  // PTX:196 red.global.add.f32 [%rd45], %f100
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))), (float)(f100));
  // PTX:197 add.s64 %rd46, %rd45, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd46) : "l"(rd45));
  // PTX:198 red.global.add.f32 [%rd46], %f101
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (0)))), (float)(f101));
  // PTX:199 add.s64 %rd47, %rd45, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd47) : "l"(rd45));
  // PTX:200 red.global.add.f32 [%rd47], %f102
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))), (float)(f102));
  // PTX:202 $L__BB17_5:
L_BB17_5:;
  // PTX:203 ret
  return;
}
