// 机械还原自 PTX：synreal::kernel::update_joint_body_spring_augmented_lagrangian_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 815cade83bc6c56d83e30223604cf3b965c65768d139341328e0ef447bd37d30
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__update_joint_body_spring_augmented_lagrangian_state(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10, unsigned long long param11) {
  int p0, p1, p2, p3, p4;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69;
  // PTX:28 ld.param.u64 %rd21, [_ZN7synreal6kernel51update_joint_body_spring_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PS4_mmmm_param_0]
  rd21 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:29 ld.param.u64 %rd22, [_ZN7synreal6kernel51update_joint_body_spring_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PS4_mmmm_param_1]
  rd22 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:30 ld.param.u64 %rd12, [_ZN7synreal6kernel51update_joint_body_spring_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PS4_mmmm_param_2]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:31 ld.param.u64 %rd13, [_ZN7synreal6kernel51update_joint_body_spring_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PS4_mmmm_param_3]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:32 ld.param.u64 %rd14, [_ZN7synreal6kernel51update_joint_body_spring_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PS4_mmmm_param_4]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:33 ld.param.u64 %rd15, [_ZN7synreal6kernel51update_joint_body_spring_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PS4_mmmm_param_5]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:34 ld.param.u64 %rd16, [_ZN7synreal6kernel51update_joint_body_spring_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PS4_mmmm_param_6]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:35 ld.param.u64 %rd17, [_ZN7synreal6kernel51update_joint_body_spring_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PS4_mmmm_param_7]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:36 ld.param.u64 %rd23, [_ZN7synreal6kernel51update_joint_body_spring_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PS4_mmmm_param_8]
  rd23 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:37 ld.param.u64 %rd18, [_ZN7synreal6kernel51update_joint_body_spring_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PS4_mmmm_param_9]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:38 ld.param.u64 %rd19, [_ZN7synreal6kernel51update_joint_body_spring_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PS4_mmmm_param_10]
  rd19 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:39 ld.param.u64 %rd20, [_ZN7synreal6kernel51update_joint_body_spring_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PS4_mmmm_param_11]
  rd20 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:40 cvta.to.global.u64 %rd1, %rd21
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd21));
  // PTX:41 cvta.to.global.u64 %rd2, %rd22
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd22));
  // PTX:42 mov.u32 %r3, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(blockIdx.x));
  // PTX:43 mov.u32 %r4, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r4) : "r"(blockDim.x));
  // PTX:44 mul.wide.u32 %rd24, %r3, %r4
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd24) : "r"(r3), "r"(r4));
  // PTX:45 mov.u32 %r5, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r5) : "r"(threadIdx.x));
  // PTX:46 cvt.u64.u32 %rd25, %r5
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd25) : "r"(r5));
  // PTX:47 add.s64 %rd3, %rd24, %rd25
  asm("add.s64 %0, %1, %2;" : "=l"(rd3) : "l"(rd24), "l"(rd25));
  // PTX:48 setp.ge.u64 %p1, %rd3, %rd23
  p1 = (((unsigned long long)(rd3)) >= ((unsigned long long)(rd23)));
  // PTX:49 @%p1 bra $L__BB24_9
  if (p1) { goto L_BB24_9; }
  // PTX:51 or.b64 %rd26, %rd3, %rd19
  asm("or.b64 %0, %1, %2;" : "=l"(rd26) : "l"(rd3), "l"(rd19));
  // PTX:52 and.b64 %rd27, %rd26, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd27) : "l"(rd26));
  // PTX:53 setp.eq.s64 %p2, %rd27, 0
  p2 = (((long long)(rd27)) == ((long long)(0)));
  // PTX:54 @%p2 bra $L__BB24_3
  if (p2) { goto L_BB24_3; }
  // PTX:56 div.u64 %rd68, %rd3, %rd19
  asm("div.u64 %0, %1, %2;" : "=l"(rd68) : "l"(rd3), "l"(rd19));
  // PTX:57 mul.lo.s64 %rd28, %rd68, %rd19
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd28) : "l"(rd68), "l"(rd19));
  // PTX:58 sub.s64 %rd69, %rd3, %rd28
  asm("sub.s64 %0, %1, %2;" : "=l"(rd69) : "l"(rd3), "l"(rd28));
  // PTX:59 bra.uni $L__BB24_4
  goto L_BB24_4;
  // PTX:61 $L__BB24_3:
L_BB24_3:;
  // PTX:62 cvt.u32.u64 %r6, %rd19
  asm("cvt.u32.u64 %0, %1;" : "=r"(r6) : "l"(rd19));
  // PTX:63 cvt.u32.u64 %r7, %rd3
  asm("cvt.u32.u64 %0, %1;" : "=r"(r7) : "l"(rd3));
  // PTX:64 div.u32 %r8, %r7, %r6
  asm("div.u32 %0, %1, %2;" : "=r"(r8) : "r"(r7), "r"(r6));
  // PTX:65 mul.lo.s32 %r9, %r8, %r6
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r9) : "r"(r8), "r"(r6));
  // PTX:66 sub.s32 %r10, %r7, %r9
  asm("sub.s32 %0, %1, %2;" : "=r"(r10) : "r"(r7), "r"(r9));
  // PTX:67 cvt.u64.u32 %rd68, %r8
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd68) : "r"(r8));
  // PTX:68 cvt.u64.u32 %rd69, %r10
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd69) : "r"(r10));
  // PTX:70 $L__BB24_4:
L_BB24_4:;
  // PTX:71 sub.s64 %rd29, %rd18, %rd19
  asm("sub.s64 %0, %1, %2;" : "=l"(rd29) : "l"(rd18), "l"(rd19));
  // PTX:72 add.s64 %rd10, %rd69, %rd29
  asm("add.s64 %0, %1, %2;" : "=l"(rd10) : "l"(rd69), "l"(rd29));
  // PTX:73 mul.lo.s64 %rd30, %rd68, %rd20
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd30) : "l"(rd68), "l"(rd20));
  // PTX:74 cvt.u32.u64 %r1, %rd30
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd30));
  // PTX:75 cvta.to.global.u64 %rd31, %rd12
  rd31 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd12));
  // PTX:76 shl.b64 %rd32, %rd10, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd32) : "l"(rd10));
  // PTX:77 add.s64 %rd33, %rd31, %rd32
  asm("add.s64 %0, %1, %2;" : "=l"(rd33) : "l"(rd31), "l"(rd32));
  // PTX:78 ld.global.u32 %r2, [%rd33]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (0)))));
  // PTX:79 ld.global.s32 %rd11, [%rd33+4]
  rd11 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (4)))));
  // PTX:80 cvta.to.global.u64 %rd34, %rd13
  rd34 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd13));
  // PTX:81 mul.lo.s64 %rd35, %rd10, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd35) : "l"(rd10));
  // PTX:82 add.s64 %rd36, %rd34, %rd35
  asm("add.s64 %0, %1, %2;" : "=l"(rd36) : "l"(rd34), "l"(rd35));
  // PTX:83 ld.global.f32 %f80, [%rd36]
  f80 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (0)))));
  // PTX:84 ld.global.f32 %f79, [%rd36+4]
  f79 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (4)))));
  // PTX:85 ld.global.f32 %f78, [%rd36+8]
  f78 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (8)))));
  // PTX:86 cvta.to.global.u64 %rd37, %rd14
  rd37 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd14));
  // PTX:87 add.s64 %rd38, %rd37, %rd35
  asm("add.s64 %0, %1, %2;" : "=l"(rd38) : "l"(rd37), "l"(rd35));
  // PTX:88 ld.global.f32 %f83, [%rd38]
  f83 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (0)))));
  // PTX:89 ld.global.f32 %f82, [%rd38+4]
  f82 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (4)))));
  // PTX:90 ld.global.f32 %f81, [%rd38+8]
  f81 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (8)))));
  // PTX:91 setp.lt.s32 %p3, %r2, 0
  p3 = (((int)(r2)) < ((int)(0)));
  // PTX:92 @%p3 bra $L__BB24_6
  if (p3) { goto L_BB24_6; }
  // PTX:94 mul.wide.s32 %rd39, %r2, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd39) : "r"(r2));
  // PTX:95 add.s64 %rd40, %rd2, %rd39
  asm("add.s64 %0, %1, %2;" : "=l"(rd40) : "l"(rd2), "l"(rd39));
  // PTX:96 ld.global.u32 %r11, [%rd40]
  r11 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (0)))));
  // PTX:97 add.s32 %r12, %r11, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r12) : "r"(r11), "r"(r1));
  // PTX:98 ld.global.u32 %r13, [%rd40+4]
  r13 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (4)))));
  // PTX:99 add.s32 %r14, %r13, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r14) : "r"(r13), "r"(r1));
  // PTX:100 ld.global.u32 %r15, [%rd40+8]
  r15 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (8)))));
  // PTX:101 add.s32 %r16, %r15, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r16) : "r"(r15), "r"(r1));
  // PTX:102 ld.global.u32 %r17, [%rd40+12]
  r17 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (12)))));
  // PTX:103 add.s32 %r18, %r17, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r18) : "r"(r17), "r"(r1));
  // PTX:104 cvta.to.global.u64 %rd41, %rd15
  rd41 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd15));
  // PTX:105 shl.b64 %rd42, %rd10, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd42) : "l"(rd10));
  // PTX:106 add.s64 %rd43, %rd41, %rd42
  asm("add.s64 %0, %1, %2;" : "=l"(rd43) : "l"(rd41), "l"(rd42));
  // PTX:107 mul.wide.s32 %rd44, %r12, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd44) : "r"(r12));
  // PTX:108 add.s64 %rd45, %rd1, %rd44
  asm("add.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd1), "l"(rd44));
  // PTX:109 ld.global.f32 %f19, [%rd45]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))));
  // PTX:110 ld.global.f32 %f20, [%rd43]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (0)))));
  // PTX:111 ld.global.f32 %f21, [%rd45+4]
  f21 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (4)))));
  // PTX:112 ld.global.f32 %f22, [%rd45+8]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (8)))));
  // PTX:113 mul.wide.s32 %rd46, %r14, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd46) : "r"(r14));
  // PTX:114 add.s64 %rd47, %rd1, %rd46
  asm("add.s64 %0, %1, %2;" : "=l"(rd47) : "l"(rd1), "l"(rd46));
  // PTX:115 ld.global.f32 %f23, [%rd47]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))));
  // PTX:116 ld.global.f32 %f24, [%rd43+4]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (4)))));
  // PTX:117 mul.f32 %f25, %f24, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f25) : "f"(f24), "f"(f23));
  // PTX:118 ld.global.f32 %f26, [%rd47+4]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (4)))));
  // PTX:119 mul.f32 %f27, %f24, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f27) : "f"(f24), "f"(f26));
  // PTX:120 ld.global.f32 %f28, [%rd47+8]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (8)))));
  // PTX:121 mul.f32 %f29, %f24, %f28
  asm("mul.f32 %0, %1, %2;" : "=f"(f29) : "f"(f24), "f"(f28));
  // PTX:122 fma.rn.f32 %f30, %f20, %f19, %f25
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f30) : "f"(f20), "f"(f19), "f"(f25));
  // PTX:123 fma.rn.f32 %f31, %f20, %f21, %f27
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f31) : "f"(f20), "f"(f21), "f"(f27));
  // PTX:124 fma.rn.f32 %f32, %f20, %f22, %f29
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f32) : "f"(f20), "f"(f22), "f"(f29));
  // PTX:125 mul.wide.s32 %rd48, %r16, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd48) : "r"(r16));
  // PTX:126 add.s64 %rd49, %rd1, %rd48
  asm("add.s64 %0, %1, %2;" : "=l"(rd49) : "l"(rd1), "l"(rd48));
  // PTX:127 ld.global.f32 %f33, [%rd49]
  f33 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))));
  // PTX:128 ld.global.f32 %f34, [%rd43+8]
  f34 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (8)))));
  // PTX:129 ld.global.f32 %f35, [%rd49+4]
  f35 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (4)))));
  // PTX:130 ld.global.f32 %f36, [%rd49+8]
  f36 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (8)))));
  // PTX:131 fma.rn.f32 %f37, %f34, %f33, %f30
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f37) : "f"(f34), "f"(f33), "f"(f30));
  // PTX:132 fma.rn.f32 %f38, %f34, %f35, %f31
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f38) : "f"(f34), "f"(f35), "f"(f31));
  // PTX:133 fma.rn.f32 %f39, %f34, %f36, %f32
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f39) : "f"(f34), "f"(f36), "f"(f32));
  // PTX:134 mul.wide.s32 %rd50, %r18, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd50) : "r"(r18));
  // PTX:135 add.s64 %rd51, %rd1, %rd50
  asm("add.s64 %0, %1, %2;" : "=l"(rd51) : "l"(rd1), "l"(rd50));
  // PTX:136 ld.global.f32 %f40, [%rd51]
  f40 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))));
  // PTX:137 ld.global.f32 %f41, [%rd43+12]
  f41 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (12)))));
  // PTX:138 ld.global.f32 %f42, [%rd51+4]
  f42 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (4)))));
  // PTX:139 ld.global.f32 %f43, [%rd51+8]
  f43 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (8)))));
  // PTX:140 fma.rn.f32 %f80, %f41, %f40, %f37
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f80) : "f"(f41), "f"(f40), "f"(f37));
  // PTX:141 fma.rn.f32 %f79, %f41, %f42, %f38
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f79) : "f"(f41), "f"(f42), "f"(f38));
  // PTX:142 fma.rn.f32 %f78, %f41, %f43, %f39
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f78) : "f"(f41), "f"(f43), "f"(f39));
  // PTX:144 $L__BB24_6:
L_BB24_6:;
  // PTX:145 cvt.u32.u64 %r19, %rd11
  asm("cvt.u32.u64 %0, %1;" : "=r"(r19) : "l"(rd11));
  // PTX:146 setp.lt.s32 %p4, %r19, 0
  p4 = (((int)(r19)) < ((int)(0)));
  // PTX:147 @%p4 bra $L__BB24_8
  if (p4) { goto L_BB24_8; }
  // PTX:149 shl.b64 %rd52, %rd11, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd52) : "l"(rd11));
  // PTX:150 add.s64 %rd53, %rd2, %rd52
  asm("add.s64 %0, %1, %2;" : "=l"(rd53) : "l"(rd2), "l"(rd52));
  // PTX:151 ld.global.u32 %r20, [%rd53]
  r20 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))));
  // PTX:152 add.s32 %r21, %r20, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r21) : "r"(r20), "r"(r1));
  // PTX:153 ld.global.u32 %r22, [%rd53+4]
  r22 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (4)))));
  // PTX:154 add.s32 %r23, %r22, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r23) : "r"(r22), "r"(r1));
  // PTX:155 ld.global.u32 %r24, [%rd53+8]
  r24 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (8)))));
  // PTX:156 add.s32 %r25, %r24, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r25) : "r"(r24), "r"(r1));
  // PTX:157 ld.global.u32 %r26, [%rd53+12]
  r26 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (12)))));
  // PTX:158 add.s32 %r27, %r26, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r27) : "r"(r26), "r"(r1));
  // PTX:159 cvta.to.global.u64 %rd54, %rd16
  rd54 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd16));
  // PTX:160 shl.b64 %rd55, %rd10, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd55) : "l"(rd10));
  // PTX:161 add.s64 %rd56, %rd54, %rd55
  asm("add.s64 %0, %1, %2;" : "=l"(rd56) : "l"(rd54), "l"(rd55));
  // PTX:162 mul.wide.s32 %rd57, %r21, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd57) : "r"(r21));
  // PTX:163 add.s64 %rd58, %rd1, %rd57
  asm("add.s64 %0, %1, %2;" : "=l"(rd58) : "l"(rd1), "l"(rd57));
  // PTX:164 ld.global.f32 %f44, [%rd58]
  f44 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (0)))));
  // PTX:165 ld.global.f32 %f45, [%rd56]
  f45 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))));
  // PTX:166 ld.global.f32 %f46, [%rd58+4]
  f46 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (4)))));
  // PTX:167 ld.global.f32 %f47, [%rd58+8]
  f47 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (8)))));
  // PTX:168 mul.wide.s32 %rd59, %r23, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd59) : "r"(r23));
  // PTX:169 add.s64 %rd60, %rd1, %rd59
  asm("add.s64 %0, %1, %2;" : "=l"(rd60) : "l"(rd1), "l"(rd59));
  // PTX:170 ld.global.f32 %f48, [%rd60]
  f48 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))));
  // PTX:171 ld.global.f32 %f49, [%rd56+4]
  f49 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (4)))));
  // PTX:172 mul.f32 %f50, %f49, %f48
  asm("mul.f32 %0, %1, %2;" : "=f"(f50) : "f"(f49), "f"(f48));
  // PTX:173 ld.global.f32 %f51, [%rd60+4]
  f51 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (4)))));
  // PTX:174 mul.f32 %f52, %f49, %f51
  asm("mul.f32 %0, %1, %2;" : "=f"(f52) : "f"(f49), "f"(f51));
  // PTX:175 ld.global.f32 %f53, [%rd60+8]
  f53 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (8)))));
  // PTX:176 mul.f32 %f54, %f49, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f54) : "f"(f49), "f"(f53));
  // PTX:177 fma.rn.f32 %f55, %f45, %f44, %f50
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f55) : "f"(f45), "f"(f44), "f"(f50));
  // PTX:178 fma.rn.f32 %f56, %f45, %f46, %f52
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f56) : "f"(f45), "f"(f46), "f"(f52));
  // PTX:179 fma.rn.f32 %f57, %f45, %f47, %f54
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f57) : "f"(f45), "f"(f47), "f"(f54));
  // PTX:180 mul.wide.s32 %rd61, %r25, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd61) : "r"(r25));
  // PTX:181 add.s64 %rd62, %rd1, %rd61
  asm("add.s64 %0, %1, %2;" : "=l"(rd62) : "l"(rd1), "l"(rd61));
  // PTX:182 ld.global.f32 %f58, [%rd62]
  f58 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))));
  // PTX:183 ld.global.f32 %f59, [%rd56+8]
  f59 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (8)))));
  // PTX:184 ld.global.f32 %f60, [%rd62+4]
  f60 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (4)))));
  // PTX:185 ld.global.f32 %f61, [%rd62+8]
  f61 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (8)))));
  // PTX:186 fma.rn.f32 %f62, %f59, %f58, %f55
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f62) : "f"(f59), "f"(f58), "f"(f55));
  // PTX:187 fma.rn.f32 %f63, %f59, %f60, %f56
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f63) : "f"(f59), "f"(f60), "f"(f56));
  // PTX:188 fma.rn.f32 %f64, %f59, %f61, %f57
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f64) : "f"(f59), "f"(f61), "f"(f57));
  // PTX:189 mul.wide.s32 %rd63, %r27, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd63) : "r"(r27));
  // PTX:190 add.s64 %rd64, %rd1, %rd63
  asm("add.s64 %0, %1, %2;" : "=l"(rd64) : "l"(rd1), "l"(rd63));
  // PTX:191 ld.global.f32 %f65, [%rd64]
  f65 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (0)))));
  // PTX:192 ld.global.f32 %f66, [%rd56+12]
  f66 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (12)))));
  // PTX:193 ld.global.f32 %f67, [%rd64+4]
  f67 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (4)))));
  // PTX:194 ld.global.f32 %f68, [%rd64+8]
  f68 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (8)))));
  // PTX:195 fma.rn.f32 %f83, %f66, %f65, %f62
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f83) : "f"(f66), "f"(f65), "f"(f62));
  // PTX:196 fma.rn.f32 %f82, %f66, %f67, %f63
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f82) : "f"(f66), "f"(f67), "f"(f63));
  // PTX:197 fma.rn.f32 %f81, %f66, %f68, %f64
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f81) : "f"(f66), "f"(f68), "f"(f64));
  // PTX:199 $L__BB24_8:
L_BB24_8:;
  // PTX:200 cvta.to.global.u64 %rd65, %rd17
  rd65 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd17));
  // PTX:201 mul.lo.s64 %rd66, %rd3, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd66) : "l"(rd3));
  // PTX:202 add.s64 %rd67, %rd65, %rd66
  asm("add.s64 %0, %1, %2;" : "=l"(rd67) : "l"(rd65), "l"(rd66));
  // PTX:203 ld.global.f32 %f69, [%rd67]
  f69 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0)))));
  // PTX:204 add.f32 %f70, %f83, %f69
  asm("add.f32 %0, %1, %2;" : "=f"(f70) : "f"(f83), "f"(f69));
  // PTX:205 ld.global.f32 %f71, [%rd67+4]
  f71 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (4)))));
  // PTX:206 add.f32 %f72, %f82, %f71
  asm("add.f32 %0, %1, %2;" : "=f"(f72) : "f"(f82), "f"(f71));
  // PTX:207 ld.global.f32 %f73, [%rd67+8]
  f73 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (8)))));
  // PTX:208 add.f32 %f74, %f81, %f73
  asm("add.f32 %0, %1, %2;" : "=f"(f74) : "f"(f81), "f"(f73));
  // PTX:209 sub.f32 %f75, %f70, %f80
  asm("sub.f32 %0, %1, %2;" : "=f"(f75) : "f"(f70), "f"(f80));
  // PTX:210 sub.f32 %f76, %f72, %f79
  asm("sub.f32 %0, %1, %2;" : "=f"(f76) : "f"(f72), "f"(f79));
  // PTX:211 sub.f32 %f77, %f74, %f78
  asm("sub.f32 %0, %1, %2;" : "=f"(f77) : "f"(f74), "f"(f78));
  // PTX:212 st.global.f32 [%rd67], %f75
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0))))) = (float)(f75);
  // PTX:213 st.global.f32 [%rd67+4], %f76
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (4))))) = (float)(f76);
  // PTX:214 st.global.f32 [%rd67+8], %f77
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (8))))) = (float)(f77);
  // PTX:216 $L__BB24_9:
L_BB24_9:;
  // PTX:217 ret
  return;
}
