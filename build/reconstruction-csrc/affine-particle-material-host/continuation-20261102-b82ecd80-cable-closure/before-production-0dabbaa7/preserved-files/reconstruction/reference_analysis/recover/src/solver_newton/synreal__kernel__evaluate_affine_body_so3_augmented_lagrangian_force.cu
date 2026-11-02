// 机械还原自 PTX：synreal::kernel::evaluate_affine_body_so3_augmented_lagrangian_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 14bbc9aa9f50e9f63e8ea4f4955c2cf8f9e06e29886599ea9fc6618bab3d073e
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__evaluate_affine_body_so3_augmented_lagrangian_force(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, float param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9) {
  int p0, p1, p2;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56;
  // PTX:26 ld.param.u64 %rd8, [_ZN7synreal6kernel51evaluate_affine_body_so3_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEESF_fPS4_mmm_param_0]
  rd8 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:27 ld.param.u64 %rd9, [_ZN7synreal6kernel51evaluate_affine_body_so3_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEESF_fPS4_mmm_param_1]
  rd9 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:28 ld.param.u64 %rd10, [_ZN7synreal6kernel51evaluate_affine_body_so3_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEESF_fPS4_mmm_param_2]
  rd10 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:29 ld.param.u64 %rd11, [_ZN7synreal6kernel51evaluate_affine_body_so3_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEESF_fPS4_mmm_param_3]
  rd11 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:30 ld.param.u64 %rd12, [_ZN7synreal6kernel51evaluate_affine_body_so3_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEESF_fPS4_mmm_param_4]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:31 ld.param.f32 %f1, [_ZN7synreal6kernel51evaluate_affine_body_so3_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEESF_fPS4_mmm_param_5]
  f1 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param5 + (0))));
  // PTX:32 ld.param.u64 %rd13, [_ZN7synreal6kernel51evaluate_affine_body_so3_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEESF_fPS4_mmm_param_6]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:33 ld.param.u64 %rd16, [_ZN7synreal6kernel51evaluate_affine_body_so3_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEESF_fPS4_mmm_param_7]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:34 ld.param.u64 %rd14, [_ZN7synreal6kernel51evaluate_affine_body_so3_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEESF_fPS4_mmm_param_8]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:35 ld.param.u64 %rd15, [_ZN7synreal6kernel51evaluate_affine_body_so3_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEESF_fPS4_mmm_param_9]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:36 mov.u32 %r1, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r1) : "r"(blockIdx.x));
  // PTX:37 mov.u32 %r2, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockDim.x));
  // PTX:38 mul.wide.u32 %rd17, %r1, %r2
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd17) : "r"(r1), "r"(r2));
  // PTX:39 mov.u32 %r3, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(threadIdx.x));
  // PTX:40 cvt.u64.u32 %rd18, %r3
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd18) : "r"(r3));
  // PTX:41 add.s64 %rd1, %rd17, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd17), "l"(rd18));
  // PTX:42 setp.ge.u64 %p1, %rd1, %rd16
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd16)));
  // PTX:43 @%p1 bra $L__BB16_5
  if (p1) { goto L_BB16_5; }
  // PTX:45 or.b64 %rd19, %rd1, %rd14
  asm("or.b64 %0, %1, %2;" : "=l"(rd19) : "l"(rd1), "l"(rd14));
  // PTX:46 and.b64 %rd20, %rd19, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd20) : "l"(rd19));
  // PTX:47 setp.eq.s64 %p2, %rd20, 0
  p2 = (((long long)(rd20)) == ((long long)(0)));
  // PTX:48 @%p2 bra $L__BB16_3
  if (p2) { goto L_BB16_3; }
  // PTX:50 div.u64 %rd55, %rd1, %rd14
  asm("div.u64 %0, %1, %2;" : "=l"(rd55) : "l"(rd1), "l"(rd14));
  // PTX:51 mul.lo.s64 %rd21, %rd55, %rd14
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd21) : "l"(rd55), "l"(rd14));
  // PTX:52 sub.s64 %rd56, %rd1, %rd21
  asm("sub.s64 %0, %1, %2;" : "=l"(rd56) : "l"(rd1), "l"(rd21));
  // PTX:53 bra.uni $L__BB16_4
  goto L_BB16_4;
  // PTX:55 $L__BB16_3:
L_BB16_3:;
  // PTX:56 cvt.u32.u64 %r4, %rd14
  asm("cvt.u32.u64 %0, %1;" : "=r"(r4) : "l"(rd14));
  // PTX:57 cvt.u32.u64 %r5, %rd1
  asm("cvt.u32.u64 %0, %1;" : "=r"(r5) : "l"(rd1));
  // PTX:58 div.u32 %r6, %r5, %r4
  asm("div.u32 %0, %1, %2;" : "=r"(r6) : "r"(r5), "r"(r4));
  // PTX:59 mul.lo.s32 %r7, %r6, %r4
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r7) : "r"(r6), "r"(r4));
  // PTX:60 sub.s32 %r8, %r5, %r7
  asm("sub.s32 %0, %1, %2;" : "=r"(r8) : "r"(r5), "r"(r7));
  // PTX:61 cvt.u64.u32 %rd55, %r6
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd55) : "r"(r6));
  // PTX:62 cvt.u64.u32 %rd56, %r8
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd56) : "r"(r8));
  // PTX:64 $L__BB16_4:
L_BB16_4:;
  // PTX:65 cvta.to.global.u64 %rd22, %rd13
  rd22 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd13));
  // PTX:66 cvta.to.global.u64 %rd23, %rd8
  rd23 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd8));
  // PTX:67 mul.lo.s64 %rd24, %rd55, %rd15
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd24) : "l"(rd55), "l"(rd15));
  // PTX:68 cvt.u32.u64 %r9, %rd24
  asm("cvt.u32.u64 %0, %1;" : "=r"(r9) : "l"(rd24));
  // PTX:69 cvta.to.global.u64 %rd25, %rd9
  rd25 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd9));
  // PTX:70 shl.b64 %rd26, %rd56, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd26) : "l"(rd56));
  // PTX:71 add.s64 %rd27, %rd25, %rd26
  asm("add.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd25), "l"(rd26));
  // PTX:72 ld.global.u32 %r10, [%rd27]
  r10 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))));
  // PTX:73 add.s32 %r11, %r10, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r11) : "r"(r10), "r"(r9));
  // PTX:74 ld.global.u32 %r12, [%rd27+4]
  r12 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (4)))));
  // PTX:75 add.s32 %r13, %r12, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r13) : "r"(r12), "r"(r9));
  // PTX:76 ld.global.u32 %r14, [%rd27+8]
  r14 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (8)))));
  // PTX:77 add.s32 %r15, %r14, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r15) : "r"(r14), "r"(r9));
  // PTX:78 ld.global.u32 %r16, [%rd27+12]
  r16 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (12)))));
  // PTX:79 add.s32 %r17, %r16, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r17) : "r"(r16), "r"(r9));
  // PTX:80 mul.wide.s32 %rd28, %r13, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd28) : "r"(r13));
  // PTX:81 add.s64 %rd29, %rd23, %rd28
  asm("add.s64 %0, %1, %2;" : "=l"(rd29) : "l"(rd23), "l"(rd28));
  // PTX:82 mul.wide.s32 %rd30, %r15, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd30) : "r"(r15));
  // PTX:83 add.s64 %rd31, %rd23, %rd30
  asm("add.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd23), "l"(rd30));
  // PTX:84 mul.wide.s32 %rd32, %r17, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd32) : "r"(r17));
  // PTX:85 add.s64 %rd33, %rd23, %rd32
  asm("add.s64 %0, %1, %2;" : "=l"(rd33) : "l"(rd23), "l"(rd32));
  // PTX:86 cvta.to.global.u64 %rd34, %rd11
  rd34 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd11));
  // PTX:87 mul.lo.s64 %rd35, %rd1, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd35) : "l"(rd1));
  // PTX:88 add.s64 %rd36, %rd34, %rd35
  asm("add.s64 %0, %1, %2;" : "=l"(rd36) : "l"(rd34), "l"(rd35));
  // PTX:89 cvta.to.global.u64 %rd37, %rd12
  rd37 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd12));
  // PTX:90 add.s64 %rd38, %rd37, %rd35
  asm("add.s64 %0, %1, %2;" : "=l"(rd38) : "l"(rd37), "l"(rd35));
  // PTX:91 cvta.to.global.u64 %rd39, %rd10
  rd39 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd10));
  // PTX:92 shl.b64 %rd40, %rd56, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd40) : "l"(rd56));
  // PTX:93 add.s64 %rd41, %rd39, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd41) : "l"(rd39), "l"(rd40));
  // PTX:94 ld.global.f32 %f2, [%rd41]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (0)))));
  // PTX:95 mul.f32 %f3, %f2, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f3) : "f"(f2), "f"(f1));
  // PTX:96 ld.global.f32 %f4, [%rd36]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (0)))));
  // PTX:97 ld.global.f32 %f5, [%rd29]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (0)))));
  // PTX:98 sub.f32 %f6, %f5, %f4
  asm("sub.f32 %0, %1, %2;" : "=f"(f6) : "f"(f5), "f"(f4));
  // PTX:99 ld.global.f32 %f7, [%rd36+4]
  f7 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (4)))));
  // PTX:100 ld.global.f32 %f8, [%rd29+4]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (4)))));
  // PTX:101 sub.f32 %f9, %f8, %f7
  asm("sub.f32 %0, %1, %2;" : "=f"(f9) : "f"(f8), "f"(f7));
  // PTX:102 ld.global.f32 %f10, [%rd36+8]
  f10 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (8)))));
  // PTX:103 ld.global.f32 %f11, [%rd29+8]
  f11 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (8)))));
  // PTX:104 sub.f32 %f12, %f11, %f10
  asm("sub.f32 %0, %1, %2;" : "=f"(f12) : "f"(f11), "f"(f10));
  // PTX:105 ld.global.f32 %f13, [%rd38]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (0)))));
  // PTX:106 add.f32 %f14, %f6, %f13
  asm("add.f32 %0, %1, %2;" : "=f"(f14) : "f"(f6), "f"(f13));
  // PTX:107 ld.global.f32 %f15, [%rd38+4]
  f15 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (4)))));
  // PTX:108 add.f32 %f16, %f9, %f15
  asm("add.f32 %0, %1, %2;" : "=f"(f16) : "f"(f9), "f"(f15));
  // PTX:109 ld.global.f32 %f17, [%rd38+8]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (8)))));
  // PTX:110 add.f32 %f18, %f12, %f17
  asm("add.f32 %0, %1, %2;" : "=f"(f18) : "f"(f12), "f"(f17));
  // PTX:111 ld.global.f32 %f19, [%rd36+12]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (12)))));
  // PTX:112 ld.global.f32 %f20, [%rd31]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (0)))));
  // PTX:113 sub.f32 %f21, %f20, %f19
  asm("sub.f32 %0, %1, %2;" : "=f"(f21) : "f"(f20), "f"(f19));
  // PTX:114 ld.global.f32 %f22, [%rd36+16]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (16)))));
  // PTX:115 ld.global.f32 %f23, [%rd31+4]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (4)))));
  // PTX:116 sub.f32 %f24, %f23, %f22
  asm("sub.f32 %0, %1, %2;" : "=f"(f24) : "f"(f23), "f"(f22));
  // PTX:117 ld.global.f32 %f25, [%rd36+20]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (20)))));
  // PTX:118 ld.global.f32 %f26, [%rd31+8]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (8)))));
  // PTX:119 sub.f32 %f27, %f26, %f25
  asm("sub.f32 %0, %1, %2;" : "=f"(f27) : "f"(f26), "f"(f25));
  // PTX:120 ld.global.f32 %f28, [%rd38+12]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (12)))));
  // PTX:121 add.f32 %f29, %f21, %f28
  asm("add.f32 %0, %1, %2;" : "=f"(f29) : "f"(f21), "f"(f28));
  // PTX:122 ld.global.f32 %f30, [%rd38+16]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (16)))));
  // PTX:123 add.f32 %f31, %f24, %f30
  asm("add.f32 %0, %1, %2;" : "=f"(f31) : "f"(f24), "f"(f30));
  // PTX:124 ld.global.f32 %f32, [%rd38+20]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (20)))));
  // PTX:125 add.f32 %f33, %f27, %f32
  asm("add.f32 %0, %1, %2;" : "=f"(f33) : "f"(f27), "f"(f32));
  // PTX:126 ld.global.f32 %f34, [%rd36+24]
  f34 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (24)))));
  // PTX:127 ld.global.f32 %f35, [%rd33]
  f35 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (0)))));
  // PTX:128 sub.f32 %f36, %f35, %f34
  asm("sub.f32 %0, %1, %2;" : "=f"(f36) : "f"(f35), "f"(f34));
  // PTX:129 ld.global.f32 %f37, [%rd36+28]
  f37 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (28)))));
  // PTX:130 ld.global.f32 %f38, [%rd33+4]
  f38 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (4)))));
  // PTX:131 sub.f32 %f39, %f38, %f37
  asm("sub.f32 %0, %1, %2;" : "=f"(f39) : "f"(f38), "f"(f37));
  // PTX:132 ld.global.f32 %f40, [%rd36+32]
  f40 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (32)))));
  // PTX:133 ld.global.f32 %f41, [%rd33+8]
  f41 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (8)))));
  // PTX:134 sub.f32 %f42, %f41, %f40
  asm("sub.f32 %0, %1, %2;" : "=f"(f42) : "f"(f41), "f"(f40));
  // PTX:135 ld.global.f32 %f43, [%rd38+24]
  f43 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (24)))));
  // PTX:136 add.f32 %f44, %f36, %f43
  asm("add.f32 %0, %1, %2;" : "=f"(f44) : "f"(f36), "f"(f43));
  // PTX:137 ld.global.f32 %f45, [%rd38+28]
  f45 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (28)))));
  // PTX:138 add.f32 %f46, %f39, %f45
  asm("add.f32 %0, %1, %2;" : "=f"(f46) : "f"(f39), "f"(f45));
  // PTX:139 ld.global.f32 %f47, [%rd38+32]
  f47 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (32)))));
  // PTX:140 add.f32 %f48, %f42, %f47
  asm("add.f32 %0, %1, %2;" : "=f"(f48) : "f"(f42), "f"(f47));
  // PTX:141 mul.f32 %f49, %f16, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f49) : "f"(f16), "f"(f7));
  // PTX:142 mul.f32 %f50, %f16, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f50) : "f"(f16), "f"(f22));
  // PTX:143 mul.f32 %f51, %f16, %f37
  asm("mul.f32 %0, %1, %2;" : "=f"(f51) : "f"(f16), "f"(f37));
  // PTX:144 fma.rn.f32 %f52, %f14, %f4, %f49
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f52) : "f"(f14), "f"(f4), "f"(f49));
  // PTX:145 fma.rn.f32 %f53, %f14, %f19, %f50
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f53) : "f"(f14), "f"(f19), "f"(f50));
  // PTX:146 fma.rn.f32 %f54, %f14, %f34, %f51
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f54) : "f"(f14), "f"(f34), "f"(f51));
  // PTX:147 fma.rn.f32 %f55, %f18, %f10, %f52
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f55) : "f"(f18), "f"(f10), "f"(f52));
  // PTX:148 fma.rn.f32 %f56, %f18, %f25, %f53
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f56) : "f"(f18), "f"(f25), "f"(f53));
  // PTX:149 fma.rn.f32 %f57, %f18, %f40, %f54
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f57) : "f"(f18), "f"(f40), "f"(f54));
  // PTX:150 mul.f32 %f58, %f31, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f58) : "f"(f31), "f"(f7));
  // PTX:151 mul.f32 %f59, %f31, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f59) : "f"(f31), "f"(f22));
  // PTX:152 mul.f32 %f60, %f31, %f37
  asm("mul.f32 %0, %1, %2;" : "=f"(f60) : "f"(f31), "f"(f37));
  // PTX:153 fma.rn.f32 %f61, %f29, %f4, %f58
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f61) : "f"(f29), "f"(f4), "f"(f58));
  // PTX:154 fma.rn.f32 %f62, %f29, %f19, %f59
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f62) : "f"(f29), "f"(f19), "f"(f59));
  // PTX:155 fma.rn.f32 %f63, %f29, %f34, %f60
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f63) : "f"(f29), "f"(f34), "f"(f60));
  // PTX:156 fma.rn.f32 %f64, %f33, %f10, %f61
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f64) : "f"(f33), "f"(f10), "f"(f61));
  // PTX:157 fma.rn.f32 %f65, %f33, %f25, %f62
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f65) : "f"(f33), "f"(f25), "f"(f62));
  // PTX:158 fma.rn.f32 %f66, %f33, %f40, %f63
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f66) : "f"(f33), "f"(f40), "f"(f63));
  // PTX:159 mul.f32 %f67, %f46, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f67) : "f"(f46), "f"(f7));
  // PTX:160 mul.f32 %f68, %f46, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f68) : "f"(f46), "f"(f22));
  // PTX:161 mul.f32 %f69, %f46, %f37
  asm("mul.f32 %0, %1, %2;" : "=f"(f69) : "f"(f46), "f"(f37));
  // PTX:162 fma.rn.f32 %f70, %f44, %f4, %f67
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f70) : "f"(f44), "f"(f4), "f"(f67));
  // PTX:163 fma.rn.f32 %f71, %f44, %f19, %f68
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f71) : "f"(f44), "f"(f19), "f"(f68));
  // PTX:164 fma.rn.f32 %f72, %f44, %f34, %f69
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f72) : "f"(f44), "f"(f34), "f"(f69));
  // PTX:165 fma.rn.f32 %f73, %f48, %f10, %f70
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f73) : "f"(f48), "f"(f10), "f"(f70));
  // PTX:166 fma.rn.f32 %f74, %f48, %f25, %f71
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f74) : "f"(f48), "f"(f25), "f"(f71));
  // PTX:167 fma.rn.f32 %f75, %f48, %f40, %f72
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f75) : "f"(f48), "f"(f40), "f"(f72));
  // PTX:168 add.f32 %f76, %f55, %f55
  asm("add.f32 %0, %1, %2;" : "=f"(f76) : "f"(f55), "f"(f55));
  // PTX:169 add.f32 %f77, %f56, %f64
  asm("add.f32 %0, %1, %2;" : "=f"(f77) : "f"(f56), "f"(f64));
  // PTX:170 add.f32 %f78, %f57, %f73
  asm("add.f32 %0, %1, %2;" : "=f"(f78) : "f"(f57), "f"(f73));
  // PTX:171 add.f32 %f79, %f65, %f65
  asm("add.f32 %0, %1, %2;" : "=f"(f79) : "f"(f65), "f"(f65));
  // PTX:172 add.f32 %f80, %f66, %f74
  asm("add.f32 %0, %1, %2;" : "=f"(f80) : "f"(f66), "f"(f74));
  // PTX:173 add.f32 %f81, %f75, %f75
  asm("add.f32 %0, %1, %2;" : "=f"(f81) : "f"(f75), "f"(f75));
  // PTX:174 mul.f32 %f82, %f76, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f82) : "f"(f76));
  // PTX:175 mul.f32 %f83, %f77, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f83) : "f"(f77));
  // PTX:176 mul.f32 %f84, %f78, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f84) : "f"(f78));
  // PTX:177 mul.f32 %f85, %f79, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f85) : "f"(f79));
  // PTX:178 mul.f32 %f86, %f80, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f86) : "f"(f80));
  // PTX:179 mul.f32 %f87, %f81, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f87) : "f"(f81));
  // PTX:180 mul.f32 %f88, %f83, %f19
  asm("mul.f32 %0, %1, %2;" : "=f"(f88) : "f"(f83), "f"(f19));
  // PTX:181 mul.f32 %f89, %f83, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f89) : "f"(f83), "f"(f22));
  // PTX:182 mul.f32 %f90, %f83, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f90) : "f"(f83), "f"(f25));
  // PTX:183 fma.rn.f32 %f91, %f82, %f4, %f88
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f91) : "f"(f82), "f"(f4), "f"(f88));
  // PTX:184 fma.rn.f32 %f92, %f82, %f7, %f89
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f92) : "f"(f82), "f"(f7), "f"(f89));
  // PTX:185 fma.rn.f32 %f93, %f82, %f10, %f90
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f93) : "f"(f82), "f"(f10), "f"(f90));
  // PTX:186 fma.rn.f32 %f94, %f84, %f34, %f91
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f94) : "f"(f84), "f"(f34), "f"(f91));
  // PTX:187 fma.rn.f32 %f95, %f84, %f37, %f92
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f95) : "f"(f84), "f"(f37), "f"(f92));
  // PTX:188 fma.rn.f32 %f96, %f84, %f40, %f93
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f96) : "f"(f84), "f"(f40), "f"(f93));
  // PTX:189 mul.f32 %f97, %f85, %f19
  asm("mul.f32 %0, %1, %2;" : "=f"(f97) : "f"(f85), "f"(f19));
  // PTX:190 mul.f32 %f98, %f85, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f98) : "f"(f85), "f"(f22));
  // PTX:191 mul.f32 %f99, %f85, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f99) : "f"(f85), "f"(f25));
  // PTX:192 fma.rn.f32 %f100, %f83, %f4, %f97
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f100) : "f"(f83), "f"(f4), "f"(f97));
  // PTX:193 fma.rn.f32 %f101, %f83, %f7, %f98
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f101) : "f"(f83), "f"(f7), "f"(f98));
  // PTX:194 fma.rn.f32 %f102, %f83, %f10, %f99
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f102) : "f"(f83), "f"(f10), "f"(f99));
  // PTX:195 fma.rn.f32 %f103, %f86, %f34, %f100
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f103) : "f"(f86), "f"(f34), "f"(f100));
  // PTX:196 fma.rn.f32 %f104, %f86, %f37, %f101
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f104) : "f"(f86), "f"(f37), "f"(f101));
  // PTX:197 fma.rn.f32 %f105, %f86, %f40, %f102
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f105) : "f"(f86), "f"(f40), "f"(f102));
  // PTX:198 mul.f32 %f106, %f86, %f19
  asm("mul.f32 %0, %1, %2;" : "=f"(f106) : "f"(f86), "f"(f19));
  // PTX:199 mul.f32 %f107, %f86, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f107) : "f"(f86), "f"(f22));
  // PTX:200 mul.f32 %f108, %f86, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f108) : "f"(f86), "f"(f25));
  // PTX:201 fma.rn.f32 %f109, %f84, %f4, %f106
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f109) : "f"(f84), "f"(f4), "f"(f106));
  // PTX:202 fma.rn.f32 %f110, %f84, %f7, %f107
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f110) : "f"(f84), "f"(f7), "f"(f107));
  // PTX:203 fma.rn.f32 %f111, %f84, %f10, %f108
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f111) : "f"(f84), "f"(f10), "f"(f108));
  // PTX:204 fma.rn.f32 %f112, %f87, %f34, %f109
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f112) : "f"(f87), "f"(f34), "f"(f109));
  // PTX:205 fma.rn.f32 %f113, %f87, %f37, %f110
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f113) : "f"(f87), "f"(f37), "f"(f110));
  // PTX:206 fma.rn.f32 %f114, %f87, %f40, %f111
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f114) : "f"(f87), "f"(f40), "f"(f111));
  // PTX:207 neg.f32 %f115, %f3
  asm("neg.f32 %0, %1;" : "=f"(f115) : "f"(f3));
  // PTX:208 mul.f32 %f116, %f94, %f115
  asm("mul.f32 %0, %1, %2;" : "=f"(f116) : "f"(f94), "f"(f115));
  // PTX:209 mul.f32 %f117, %f95, %f115
  asm("mul.f32 %0, %1, %2;" : "=f"(f117) : "f"(f95), "f"(f115));
  // PTX:210 mul.f32 %f118, %f96, %f115
  asm("mul.f32 %0, %1, %2;" : "=f"(f118) : "f"(f96), "f"(f115));
  // PTX:211 mul.f32 %f119, %f103, %f115
  asm("mul.f32 %0, %1, %2;" : "=f"(f119) : "f"(f103), "f"(f115));
  // PTX:212 mul.f32 %f120, %f104, %f115
  asm("mul.f32 %0, %1, %2;" : "=f"(f120) : "f"(f104), "f"(f115));
  // PTX:213 mul.f32 %f121, %f105, %f115
  asm("mul.f32 %0, %1, %2;" : "=f"(f121) : "f"(f105), "f"(f115));
  // PTX:214 mul.f32 %f122, %f112, %f115
  asm("mul.f32 %0, %1, %2;" : "=f"(f122) : "f"(f112), "f"(f115));
  // PTX:215 mul.f32 %f123, %f113, %f115
  asm("mul.f32 %0, %1, %2;" : "=f"(f123) : "f"(f113), "f"(f115));
  // PTX:216 mul.f32 %f124, %f114, %f115
  asm("mul.f32 %0, %1, %2;" : "=f"(f124) : "f"(f114), "f"(f115));
  // PTX:217 mul.wide.s32 %rd42, %r11, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd42) : "r"(r11));
  // PTX:218 add.s64 %rd43, %rd22, %rd42
  asm("add.s64 %0, %1, %2;" : "=l"(rd43) : "l"(rd22), "l"(rd42));
  // PTX:219 red.global.add.f32 [%rd43], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:220 add.s64 %rd44, %rd43, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd44) : "l"(rd43));
  // PTX:221 red.global.add.f32 [%rd44], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:222 add.s64 %rd45, %rd43, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd45) : "l"(rd43));
  // PTX:223 red.global.add.f32 [%rd45], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:224 add.s64 %rd46, %rd22, %rd28
  asm("add.s64 %0, %1, %2;" : "=l"(rd46) : "l"(rd22), "l"(rd28));
  // PTX:225 red.global.add.f32 [%rd46], %f116
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (0)))), (float)(f116));
  // PTX:226 add.s64 %rd47, %rd46, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd47) : "l"(rd46));
  // PTX:227 red.global.add.f32 [%rd47], %f117
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))), (float)(f117));
  // PTX:228 add.s64 %rd48, %rd46, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd48) : "l"(rd46));
  // PTX:229 red.global.add.f32 [%rd48], %f118
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))), (float)(f118));
  // PTX:230 add.s64 %rd49, %rd22, %rd30
  asm("add.s64 %0, %1, %2;" : "=l"(rd49) : "l"(rd22), "l"(rd30));
  // PTX:231 red.global.add.f32 [%rd49], %f119
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))), (float)(f119));
  // PTX:232 add.s64 %rd50, %rd49, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd50) : "l"(rd49));
  // PTX:233 red.global.add.f32 [%rd50], %f120
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (0)))), (float)(f120));
  // PTX:234 add.s64 %rd51, %rd49, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd51) : "l"(rd49));
  // PTX:235 red.global.add.f32 [%rd51], %f121
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))), (float)(f121));
  // PTX:236 add.s64 %rd52, %rd22, %rd32
  asm("add.s64 %0, %1, %2;" : "=l"(rd52) : "l"(rd22), "l"(rd32));
  // PTX:237 red.global.add.f32 [%rd52], %f122
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))), (float)(f122));
  // PTX:238 add.s64 %rd53, %rd52, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd53) : "l"(rd52));
  // PTX:239 red.global.add.f32 [%rd53], %f123
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))), (float)(f123));
  // PTX:240 add.s64 %rd54, %rd52, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd54) : "l"(rd52));
  // PTX:241 red.global.add.f32 [%rd54], %f124
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))), (float)(f124));
  // PTX:243 $L__BB16_5:
L_BB16_5:;
  // PTX:244 ret
  return;
}
