// 机械还原自 PTX：synreal::kernel::evaluate_body_distance_constraint_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: f1f4f49cf5d618766a393f4b461b7be433f2216bdbffe22d9fce2003d6d4208e
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__evaluate_body_distance_constraint_force(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, float param10, unsigned long long param11, unsigned long long param12, unsigned long long param13, unsigned long long param14) {
  int p0, p1, p2, p3, p4, p5, p6;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108;
  // PTX:31 ld.param.u64 %rd25, [_ZN7synreal6kernel39evaluate_body_distance_constraint_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_S6_fPS4_mmm_param_0]
  rd25 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:32 ld.param.u64 %rd26, [_ZN7synreal6kernel39evaluate_body_distance_constraint_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_S6_fPS4_mmm_param_1]
  rd26 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:33 ld.param.u64 %rd15, [_ZN7synreal6kernel39evaluate_body_distance_constraint_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_S6_fPS4_mmm_param_2]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:34 ld.param.u64 %rd16, [_ZN7synreal6kernel39evaluate_body_distance_constraint_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_S6_fPS4_mmm_param_3]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:35 ld.param.u64 %rd17, [_ZN7synreal6kernel39evaluate_body_distance_constraint_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_S6_fPS4_mmm_param_4]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:36 ld.param.u64 %rd18, [_ZN7synreal6kernel39evaluate_body_distance_constraint_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_S6_fPS4_mmm_param_5]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:37 ld.param.u64 %rd19, [_ZN7synreal6kernel39evaluate_body_distance_constraint_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_S6_fPS4_mmm_param_6]
  rd19 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:38 ld.param.u64 %rd20, [_ZN7synreal6kernel39evaluate_body_distance_constraint_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_S6_fPS4_mmm_param_7]
  rd20 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:39 ld.param.u64 %rd21, [_ZN7synreal6kernel39evaluate_body_distance_constraint_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_S6_fPS4_mmm_param_8]
  rd21 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:40 ld.param.u64 %rd22, [_ZN7synreal6kernel39evaluate_body_distance_constraint_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_S6_fPS4_mmm_param_9]
  rd22 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:41 ld.param.f32 %f22, [_ZN7synreal6kernel39evaluate_body_distance_constraint_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_S6_fPS4_mmm_param_10]
  f22 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param10 + (0))));
  // PTX:42 ld.param.u64 %rd27, [_ZN7synreal6kernel39evaluate_body_distance_constraint_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_S6_fPS4_mmm_param_11]
  rd27 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:43 ld.param.u64 %rd28, [_ZN7synreal6kernel39evaluate_body_distance_constraint_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_S6_fPS4_mmm_param_12]
  rd28 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:44 ld.param.u64 %rd23, [_ZN7synreal6kernel39evaluate_body_distance_constraint_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_S6_fPS4_mmm_param_13]
  rd23 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:45 ld.param.u64 %rd24, [_ZN7synreal6kernel39evaluate_body_distance_constraint_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_S6_fPS4_mmm_param_14]
  rd24 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:46 cvta.to.global.u64 %rd1, %rd27
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd27));
  // PTX:47 cvta.to.global.u64 %rd2, %rd25
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd25));
  // PTX:48 cvta.to.global.u64 %rd3, %rd26
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd26));
  // PTX:49 mov.u32 %r18, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r18) : "r"(blockIdx.x));
  // PTX:50 mov.u32 %r19, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r19) : "r"(blockDim.x));
  // PTX:51 mul.wide.u32 %rd29, %r18, %r19
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd29) : "r"(r18), "r"(r19));
  // PTX:52 mov.u32 %r20, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r20) : "r"(threadIdx.x));
  // PTX:53 cvt.u64.u32 %rd30, %r20
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd30) : "r"(r20));
  // PTX:54 add.s64 %rd4, %rd29, %rd30
  asm("add.s64 %0, %1, %2;" : "=l"(rd4) : "l"(rd29), "l"(rd30));
  // PTX:55 setp.ge.u64 %p1, %rd4, %rd28
  p1 = (((unsigned long long)(rd4)) >= ((unsigned long long)(rd28)));
  // PTX:56 @%p1 bra $L__BB26_12
  if (p1) { goto L_BB26_12; }
  // PTX:58 or.b64 %rd31, %rd4, %rd23
  asm("or.b64 %0, %1, %2;" : "=l"(rd31) : "l"(rd4), "l"(rd23));
  // PTX:59 and.b64 %rd32, %rd31, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd32) : "l"(rd31));
  // PTX:60 setp.eq.s64 %p2, %rd32, 0
  p2 = (((long long)(rd32)) == ((long long)(0)));
  // PTX:61 @%p2 bra $L__BB26_3
  if (p2) { goto L_BB26_3; }
  // PTX:63 div.u64 %rd107, %rd4, %rd23
  asm("div.u64 %0, %1, %2;" : "=l"(rd107) : "l"(rd4), "l"(rd23));
  // PTX:64 mul.lo.s64 %rd33, %rd107, %rd23
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd33) : "l"(rd107), "l"(rd23));
  // PTX:65 sub.s64 %rd108, %rd4, %rd33
  asm("sub.s64 %0, %1, %2;" : "=l"(rd108) : "l"(rd4), "l"(rd33));
  // PTX:66 bra.uni $L__BB26_4
  goto L_BB26_4;
  // PTX:68 $L__BB26_3:
L_BB26_3:;
  // PTX:69 cvt.u32.u64 %r21, %rd23
  asm("cvt.u32.u64 %0, %1;" : "=r"(r21) : "l"(rd23));
  // PTX:70 cvt.u32.u64 %r22, %rd4
  asm("cvt.u32.u64 %0, %1;" : "=r"(r22) : "l"(rd4));
  // PTX:71 div.u32 %r23, %r22, %r21
  asm("div.u32 %0, %1, %2;" : "=r"(r23) : "r"(r22), "r"(r21));
  // PTX:72 mul.lo.s32 %r24, %r23, %r21
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r24) : "r"(r23), "r"(r21));
  // PTX:73 sub.s32 %r25, %r22, %r24
  asm("sub.s32 %0, %1, %2;" : "=r"(r25) : "r"(r22), "r"(r24));
  // PTX:74 cvt.u64.u32 %rd107, %r23
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd107) : "r"(r23));
  // PTX:75 cvt.u64.u32 %rd108, %r25
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd108) : "r"(r25));
  // PTX:77 $L__BB26_4:
L_BB26_4:;
  // PTX:78 mul.lo.s64 %rd34, %rd107, %rd24
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd34) : "l"(rd107), "l"(rd24));
  // PTX:79 cvt.u32.u64 %r1, %rd34
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd34));
  // PTX:80 cvta.to.global.u64 %rd35, %rd15
  rd35 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd15));
  // PTX:81 shl.b64 %rd36, %rd108, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd36) : "l"(rd108));
  // PTX:82 add.s64 %rd37, %rd35, %rd36
  asm("add.s64 %0, %1, %2;" : "=l"(rd37) : "l"(rd35), "l"(rd36));
  // PTX:83 ld.global.s32 %rd11, [%rd37]
  rd11 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (0)))));
  // PTX:84 ld.global.s32 %rd12, [%rd37+4]
  rd12 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (4)))));
  // PTX:85 cvta.to.global.u64 %rd38, %rd16
  rd38 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd16));
  // PTX:86 mul.lo.s64 %rd39, %rd108, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd39) : "l"(rd108));
  // PTX:87 add.s64 %rd40, %rd38, %rd39
  asm("add.s64 %0, %1, %2;" : "=l"(rd40) : "l"(rd38), "l"(rd39));
  // PTX:88 ld.global.f32 %f149, [%rd40]
  f149 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (0)))));
  // PTX:89 ld.global.f32 %f150, [%rd40+4]
  f150 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (4)))));
  // PTX:90 ld.global.f32 %f151, [%rd40+8]
  f151 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (8)))));
  // PTX:91 cvta.to.global.u64 %rd41, %rd17
  rd41 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd17));
  // PTX:92 add.s64 %rd42, %rd41, %rd39
  asm("add.s64 %0, %1, %2;" : "=l"(rd42) : "l"(rd41), "l"(rd39));
  // PTX:93 ld.global.f32 %f152, [%rd42]
  f152 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (0)))));
  // PTX:94 ld.global.f32 %f153, [%rd42+4]
  f153 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (4)))));
  // PTX:95 ld.global.f32 %f154, [%rd42+8]
  f154 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (8)))));
  // PTX:96 setp.lt.s64 %p3, %rd11, 0
  p3 = (((long long)(rd11)) < ((long long)(0)));
  // PTX:97 cvta.to.global.u64 %rd43, %rd18
  rd43 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd18));
  // PTX:98 shl.b64 %rd44, %rd108, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd44) : "l"(rd108));
  // PTX:99 add.s64 %rd13, %rd43, %rd44
  asm("add.s64 %0, %1, %2;" : "=l"(rd13) : "l"(rd43), "l"(rd44));
  // PTX:100 mov.u32 %r49, 0
  asm("mov.u32 %0, 0;" : "=r"(r49) : );
  // PTX:101 mov.u32 %r45, %r49
  asm("mov.u32 %0, %1;" : "=r"(r45) : "r"(r49));
  // PTX:102 mov.u32 %r46, %r49
  asm("mov.u32 %0, %1;" : "=r"(r46) : "r"(r49));
  // PTX:103 mov.u32 %r47, %r49
  asm("mov.u32 %0, %1;" : "=r"(r47) : "r"(r49));
  // PTX:104 mov.u32 %r48, %r49
  asm("mov.u32 %0, %1;" : "=r"(r48) : "r"(r49));
  // PTX:105 @%p3 bra $L__BB26_6
  if (p3) { goto L_BB26_6; }
  // PTX:107 shl.b64 %rd45, %rd11, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd45) : "l"(rd11));
  // PTX:108 add.s64 %rd46, %rd3, %rd45
  asm("add.s64 %0, %1, %2;" : "=l"(rd46) : "l"(rd3), "l"(rd45));
  // PTX:109 ld.global.u32 %r30, [%rd46]
  r30 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (0)))));
  // PTX:110 ld.global.u32 %r31, [%rd46+4]
  r31 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (4)))));
  // PTX:111 ld.global.u32 %r32, [%rd46+8]
  r32 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (8)))));
  // PTX:112 ld.global.u32 %r33, [%rd46+12]
  r33 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (12)))));
  // PTX:113 add.s32 %r48, %r33, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r48) : "r"(r33), "r"(r1));
  // PTX:114 add.s32 %r47, %r32, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r47) : "r"(r32), "r"(r1));
  // PTX:115 add.s32 %r46, %r31, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r46) : "r"(r31), "r"(r1));
  // PTX:116 add.s32 %r45, %r30, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r45) : "r"(r30), "r"(r1));
  // PTX:117 mul.wide.s32 %rd47, %r45, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd47) : "r"(r45));
  // PTX:118 add.s64 %rd48, %rd2, %rd47
  asm("add.s64 %0, %1, %2;" : "=l"(rd48) : "l"(rd2), "l"(rd47));
  // PTX:119 ld.global.f32 %f23, [%rd48]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))));
  // PTX:120 ld.global.f32 %f24, [%rd13]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))));
  // PTX:121 ld.global.f32 %f25, [%rd48+4]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (4)))));
  // PTX:122 ld.global.f32 %f26, [%rd48+8]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (8)))));
  // PTX:123 mul.wide.s32 %rd49, %r46, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd49) : "r"(r46));
  // PTX:124 add.s64 %rd50, %rd2, %rd49
  asm("add.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd2), "l"(rd49));
  // PTX:125 ld.global.f32 %f27, [%rd50]
  f27 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (0)))));
  // PTX:126 ld.global.f32 %f28, [%rd13+4]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4)))));
  // PTX:127 mul.f32 %f29, %f28, %f27
  asm("mul.f32 %0, %1, %2;" : "=f"(f29) : "f"(f28), "f"(f27));
  // PTX:128 ld.global.f32 %f30, [%rd50+4]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (4)))));
  // PTX:129 mul.f32 %f31, %f28, %f30
  asm("mul.f32 %0, %1, %2;" : "=f"(f31) : "f"(f28), "f"(f30));
  // PTX:130 ld.global.f32 %f32, [%rd50+8]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (8)))));
  // PTX:131 mul.f32 %f33, %f28, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f33) : "f"(f28), "f"(f32));
  // PTX:132 fma.rn.f32 %f34, %f24, %f23, %f29
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f34) : "f"(f24), "f"(f23), "f"(f29));
  // PTX:133 fma.rn.f32 %f35, %f24, %f25, %f31
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f35) : "f"(f24), "f"(f25), "f"(f31));
  // PTX:134 fma.rn.f32 %f36, %f24, %f26, %f33
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f36) : "f"(f24), "f"(f26), "f"(f33));
  // PTX:135 mul.wide.s32 %rd51, %r47, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd51) : "r"(r47));
  // PTX:136 add.s64 %rd52, %rd2, %rd51
  asm("add.s64 %0, %1, %2;" : "=l"(rd52) : "l"(rd2), "l"(rd51));
  // PTX:137 ld.global.f32 %f37, [%rd52]
  f37 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))));
  // PTX:138 ld.global.f32 %f38, [%rd13+8]
  f38 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8)))));
  // PTX:139 ld.global.f32 %f39, [%rd52+4]
  f39 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (4)))));
  // PTX:140 ld.global.f32 %f40, [%rd52+8]
  f40 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (8)))));
  // PTX:141 fma.rn.f32 %f41, %f38, %f37, %f34
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f41) : "f"(f38), "f"(f37), "f"(f34));
  // PTX:142 fma.rn.f32 %f42, %f38, %f39, %f35
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f42) : "f"(f38), "f"(f39), "f"(f35));
  // PTX:143 fma.rn.f32 %f43, %f38, %f40, %f36
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f43) : "f"(f38), "f"(f40), "f"(f36));
  // PTX:144 mul.wide.s32 %rd53, %r48, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd53) : "r"(r48));
  // PTX:145 add.s64 %rd54, %rd2, %rd53
  asm("add.s64 %0, %1, %2;" : "=l"(rd54) : "l"(rd2), "l"(rd53));
  // PTX:146 ld.global.f32 %f44, [%rd54]
  f44 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))));
  // PTX:147 ld.global.f32 %f45, [%rd13+12]
  f45 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (12)))));
  // PTX:148 ld.global.f32 %f46, [%rd54+4]
  f46 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (4)))));
  // PTX:149 ld.global.f32 %f47, [%rd54+8]
  f47 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (8)))));
  // PTX:150 fma.rn.f32 %f149, %f45, %f44, %f41
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f149) : "f"(f45), "f"(f44), "f"(f41));
  // PTX:151 fma.rn.f32 %f150, %f45, %f46, %f42
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f150) : "f"(f45), "f"(f46), "f"(f42));
  // PTX:152 fma.rn.f32 %f151, %f45, %f47, %f43
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f151) : "f"(f45), "f"(f47), "f"(f43));
  // PTX:154 $L__BB26_6:
L_BB26_6:;
  // PTX:155 cvt.u32.u64 %r38, %rd12
  asm("cvt.u32.u64 %0, %1;" : "=r"(r38) : "l"(rd12));
  // PTX:156 setp.lt.s32 %p4, %r38, 0
  p4 = (((int)(r38)) < ((int)(0)));
  // PTX:157 cvta.to.global.u64 %rd55, %rd19
  rd55 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd19));
  // PTX:158 add.s64 %rd14, %rd55, %rd44
  asm("add.s64 %0, %1, %2;" : "=l"(rd14) : "l"(rd55), "l"(rd44));
  // PTX:159 mov.u32 %r50, %r49
  asm("mov.u32 %0, %1;" : "=r"(r50) : "r"(r49));
  // PTX:160 mov.u32 %r51, %r49
  asm("mov.u32 %0, %1;" : "=r"(r51) : "r"(r49));
  // PTX:161 mov.u32 %r52, %r49
  asm("mov.u32 %0, %1;" : "=r"(r52) : "r"(r49));
  // PTX:162 @%p4 bra $L__BB26_8
  if (p4) { goto L_BB26_8; }
  // PTX:164 shl.b64 %rd57, %rd12, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd57) : "l"(rd12));
  // PTX:165 add.s64 %rd58, %rd3, %rd57
  asm("add.s64 %0, %1, %2;" : "=l"(rd58) : "l"(rd3), "l"(rd57));
  // PTX:166 ld.global.u32 %r39, [%rd58]
  r39 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (0)))));
  // PTX:167 ld.global.u32 %r40, [%rd58+4]
  r40 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (4)))));
  // PTX:168 ld.global.u32 %r41, [%rd58+8]
  r41 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (8)))));
  // PTX:169 ld.global.u32 %r42, [%rd58+12]
  r42 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (12)))));
  // PTX:170 add.s32 %r52, %r42, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r52) : "r"(r42), "r"(r1));
  // PTX:171 add.s32 %r51, %r41, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r51) : "r"(r41), "r"(r1));
  // PTX:172 add.s32 %r50, %r40, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r50) : "r"(r40), "r"(r1));
  // PTX:173 add.s32 %r49, %r39, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r49) : "r"(r39), "r"(r1));
  // PTX:174 mul.wide.s32 %rd59, %r49, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd59) : "r"(r49));
  // PTX:175 add.s64 %rd60, %rd2, %rd59
  asm("add.s64 %0, %1, %2;" : "=l"(rd60) : "l"(rd2), "l"(rd59));
  // PTX:176 ld.global.f32 %f48, [%rd60]
  f48 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))));
  // PTX:177 ld.global.f32 %f49, [%rd14]
  f49 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:178 ld.global.f32 %f50, [%rd60+4]
  f50 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (4)))));
  // PTX:179 ld.global.f32 %f51, [%rd60+8]
  f51 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (8)))));
  // PTX:180 mul.wide.s32 %rd61, %r50, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd61) : "r"(r50));
  // PTX:181 add.s64 %rd62, %rd2, %rd61
  asm("add.s64 %0, %1, %2;" : "=l"(rd62) : "l"(rd2), "l"(rd61));
  // PTX:182 ld.global.f32 %f52, [%rd62]
  f52 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))));
  // PTX:183 ld.global.f32 %f53, [%rd14+4]
  f53 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (4)))));
  // PTX:184 mul.f32 %f54, %f53, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f54) : "f"(f53), "f"(f52));
  // PTX:185 ld.global.f32 %f55, [%rd62+4]
  f55 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (4)))));
  // PTX:186 mul.f32 %f56, %f53, %f55
  asm("mul.f32 %0, %1, %2;" : "=f"(f56) : "f"(f53), "f"(f55));
  // PTX:187 ld.global.f32 %f57, [%rd62+8]
  f57 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (8)))));
  // PTX:188 mul.f32 %f58, %f53, %f57
  asm("mul.f32 %0, %1, %2;" : "=f"(f58) : "f"(f53), "f"(f57));
  // PTX:189 fma.rn.f32 %f59, %f49, %f48, %f54
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f59) : "f"(f49), "f"(f48), "f"(f54));
  // PTX:190 fma.rn.f32 %f60, %f49, %f50, %f56
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f60) : "f"(f49), "f"(f50), "f"(f56));
  // PTX:191 fma.rn.f32 %f61, %f49, %f51, %f58
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f61) : "f"(f49), "f"(f51), "f"(f58));
  // PTX:192 mul.wide.s32 %rd63, %r51, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd63) : "r"(r51));
  // PTX:193 add.s64 %rd64, %rd2, %rd63
  asm("add.s64 %0, %1, %2;" : "=l"(rd64) : "l"(rd2), "l"(rd63));
  // PTX:194 ld.global.f32 %f62, [%rd64]
  f62 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (0)))));
  // PTX:195 ld.global.f32 %f63, [%rd14+8]
  f63 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (8)))));
  // PTX:196 ld.global.f32 %f64, [%rd64+4]
  f64 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (4)))));
  // PTX:197 ld.global.f32 %f65, [%rd64+8]
  f65 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (8)))));
  // PTX:198 fma.rn.f32 %f66, %f63, %f62, %f59
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f66) : "f"(f63), "f"(f62), "f"(f59));
  // PTX:199 fma.rn.f32 %f67, %f63, %f64, %f60
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f67) : "f"(f63), "f"(f64), "f"(f60));
  // PTX:200 fma.rn.f32 %f68, %f63, %f65, %f61
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f68) : "f"(f63), "f"(f65), "f"(f61));
  // PTX:201 mul.wide.s32 %rd65, %r52, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd65) : "r"(r52));
  // PTX:202 add.s64 %rd66, %rd2, %rd65
  asm("add.s64 %0, %1, %2;" : "=l"(rd66) : "l"(rd2), "l"(rd65));
  // PTX:203 ld.global.f32 %f69, [%rd66]
  f69 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (0)))));
  // PTX:204 ld.global.f32 %f70, [%rd14+12]
  f70 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (12)))));
  // PTX:205 ld.global.f32 %f71, [%rd66+4]
  f71 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (4)))));
  // PTX:206 ld.global.f32 %f72, [%rd66+8]
  f72 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (8)))));
  // PTX:207 fma.rn.f32 %f152, %f70, %f69, %f66
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f152) : "f"(f70), "f"(f69), "f"(f66));
  // PTX:208 fma.rn.f32 %f153, %f70, %f71, %f67
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f153) : "f"(f70), "f"(f71), "f"(f67));
  // PTX:209 fma.rn.f32 %f154, %f70, %f72, %f68
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f154) : "f"(f70), "f"(f72), "f"(f68));
  // PTX:211 $L__BB26_8:
L_BB26_8:;
  // PTX:212 cvt.u32.u64 %r43, %rd11
  asm("cvt.u32.u64 %0, %1;" : "=r"(r43) : "l"(rd11));
  // PTX:213 setp.lt.s32 %p5, %r43, 0
  p5 = (((int)(r43)) < ((int)(0)));
  // PTX:214 cvta.to.global.u64 %rd67, %rd21
  rd67 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd21));
  // PTX:215 mul.lo.s64 %rd68, %rd4, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd68) : "l"(rd4));
  // PTX:216 add.s64 %rd69, %rd67, %rd68
  asm("add.s64 %0, %1, %2;" : "=l"(rd69) : "l"(rd67), "l"(rd68));
  // PTX:217 ld.global.f32 %f73, [%rd69]
  f73 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (0)))));
  // PTX:218 sub.f32 %f74, %f152, %f149
  asm("sub.f32 %0, %1, %2;" : "=f"(f74) : "f"(f152), "f"(f149));
  // PTX:219 sub.f32 %f75, %f74, %f73
  asm("sub.f32 %0, %1, %2;" : "=f"(f75) : "f"(f74), "f"(f73));
  // PTX:220 ld.global.f32 %f76, [%rd69+4]
  f76 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (4)))));
  // PTX:221 sub.f32 %f77, %f153, %f150
  asm("sub.f32 %0, %1, %2;" : "=f"(f77) : "f"(f153), "f"(f150));
  // PTX:222 sub.f32 %f78, %f77, %f76
  asm("sub.f32 %0, %1, %2;" : "=f"(f78) : "f"(f77), "f"(f76));
  // PTX:223 ld.global.f32 %f79, [%rd69+8]
  f79 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (8)))));
  // PTX:224 sub.f32 %f80, %f154, %f151
  asm("sub.f32 %0, %1, %2;" : "=f"(f80) : "f"(f154), "f"(f151));
  // PTX:225 sub.f32 %f81, %f80, %f79
  asm("sub.f32 %0, %1, %2;" : "=f"(f81) : "f"(f80), "f"(f79));
  // PTX:226 cvta.to.global.u64 %rd70, %rd22
  rd70 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd22));
  // PTX:227 add.s64 %rd71, %rd70, %rd68
  asm("add.s64 %0, %1, %2;" : "=l"(rd71) : "l"(rd70), "l"(rd68));
  // PTX:228 ld.global.f32 %f82, [%rd71]
  f82 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))));
  // PTX:229 add.f32 %f83, %f75, %f82
  asm("add.f32 %0, %1, %2;" : "=f"(f83) : "f"(f75), "f"(f82));
  // PTX:230 ld.global.f32 %f84, [%rd71+4]
  f84 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (4)))));
  // PTX:231 add.f32 %f85, %f78, %f84
  asm("add.f32 %0, %1, %2;" : "=f"(f85) : "f"(f78), "f"(f84));
  // PTX:232 ld.global.f32 %f86, [%rd71+8]
  f86 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (8)))));
  // PTX:233 add.f32 %f87, %f81, %f86
  asm("add.f32 %0, %1, %2;" : "=f"(f87) : "f"(f81), "f"(f86));
  // PTX:234 cvta.to.global.u64 %rd72, %rd20
  rd72 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd20));
  // PTX:235 shl.b64 %rd73, %rd108, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd73) : "l"(rd108));
  // PTX:236 add.s64 %rd74, %rd72, %rd73
  asm("add.s64 %0, %1, %2;" : "=l"(rd74) : "l"(rd72), "l"(rd73));
  // PTX:237 ld.global.f32 %f88, [%rd74]
  f88 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (0)))));
  // PTX:238 mul.f32 %f89, %f88, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f89) : "f"(f88), "f"(f22));
  // PTX:239 mul.f32 %f19, %f83, %f89
  asm("mul.f32 %0, %1, %2;" : "=f"(f19) : "f"(f83), "f"(f89));
  // PTX:240 mul.f32 %f20, %f85, %f89
  asm("mul.f32 %0, %1, %2;" : "=f"(f20) : "f"(f85), "f"(f89));
  // PTX:241 mul.f32 %f21, %f87, %f89
  asm("mul.f32 %0, %1, %2;" : "=f"(f21) : "f"(f87), "f"(f89));
  // PTX:242 @%p5 bra $L__BB26_10
  if (p5) { goto L_BB26_10; }
  // PTX:244 ld.global.f32 %f90, [%rd13]
  f90 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))));
  // PTX:245 mul.f32 %f91, %f19, %f90
  asm("mul.f32 %0, %1, %2;" : "=f"(f91) : "f"(f19), "f"(f90));
  // PTX:246 mul.f32 %f92, %f20, %f90
  asm("mul.f32 %0, %1, %2;" : "=f"(f92) : "f"(f20), "f"(f90));
  // PTX:247 mul.f32 %f93, %f21, %f90
  asm("mul.f32 %0, %1, %2;" : "=f"(f93) : "f"(f21), "f"(f90));
  // PTX:248 ld.global.f32 %f94, [%rd13+4]
  f94 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4)))));
  // PTX:249 mul.f32 %f95, %f19, %f94
  asm("mul.f32 %0, %1, %2;" : "=f"(f95) : "f"(f19), "f"(f94));
  // PTX:250 mul.f32 %f96, %f20, %f94
  asm("mul.f32 %0, %1, %2;" : "=f"(f96) : "f"(f20), "f"(f94));
  // PTX:251 mul.f32 %f97, %f21, %f94
  asm("mul.f32 %0, %1, %2;" : "=f"(f97) : "f"(f21), "f"(f94));
  // PTX:252 ld.global.f32 %f98, [%rd13+8]
  f98 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8)))));
  // PTX:253 mul.f32 %f99, %f19, %f98
  asm("mul.f32 %0, %1, %2;" : "=f"(f99) : "f"(f19), "f"(f98));
  // PTX:254 mul.f32 %f100, %f20, %f98
  asm("mul.f32 %0, %1, %2;" : "=f"(f100) : "f"(f20), "f"(f98));
  // PTX:255 mul.f32 %f101, %f21, %f98
  asm("mul.f32 %0, %1, %2;" : "=f"(f101) : "f"(f21), "f"(f98));
  // PTX:256 ld.global.f32 %f102, [%rd13+12]
  f102 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (12)))));
  // PTX:257 mul.f32 %f103, %f19, %f102
  asm("mul.f32 %0, %1, %2;" : "=f"(f103) : "f"(f19), "f"(f102));
  // PTX:258 mul.f32 %f104, %f20, %f102
  asm("mul.f32 %0, %1, %2;" : "=f"(f104) : "f"(f20), "f"(f102));
  // PTX:259 mul.f32 %f105, %f21, %f102
  asm("mul.f32 %0, %1, %2;" : "=f"(f105) : "f"(f21), "f"(f102));
  // PTX:260 mul.wide.s32 %rd75, %r45, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd75) : "r"(r45));
  // PTX:261 add.s64 %rd76, %rd1, %rd75
  asm("add.s64 %0, %1, %2;" : "=l"(rd76) : "l"(rd1), "l"(rd75));
  // PTX:262 red.global.add.f32 [%rd76], %f91
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (0)))), (float)(f91));
  // PTX:263 add.s64 %rd77, %rd76, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd77) : "l"(rd76));
  // PTX:264 red.global.add.f32 [%rd77], %f92
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (0)))), (float)(f92));
  // PTX:265 add.s64 %rd78, %rd76, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd78) : "l"(rd76));
  // PTX:266 red.global.add.f32 [%rd78], %f93
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd78) + (0)))), (float)(f93));
  // PTX:267 mul.wide.s32 %rd79, %r46, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd79) : "r"(r46));
  // PTX:268 add.s64 %rd80, %rd1, %rd79
  asm("add.s64 %0, %1, %2;" : "=l"(rd80) : "l"(rd1), "l"(rd79));
  // PTX:269 red.global.add.f32 [%rd80], %f95
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (0)))), (float)(f95));
  // PTX:270 add.s64 %rd81, %rd80, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd81) : "l"(rd80));
  // PTX:271 red.global.add.f32 [%rd81], %f96
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (0)))), (float)(f96));
  // PTX:272 add.s64 %rd82, %rd80, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd82) : "l"(rd80));
  // PTX:273 red.global.add.f32 [%rd82], %f97
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (0)))), (float)(f97));
  // PTX:274 mul.wide.s32 %rd83, %r47, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd83) : "r"(r47));
  // PTX:275 add.s64 %rd84, %rd1, %rd83
  asm("add.s64 %0, %1, %2;" : "=l"(rd84) : "l"(rd1), "l"(rd83));
  // PTX:276 red.global.add.f32 [%rd84], %f99
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (0)))), (float)(f99));
  // PTX:277 add.s64 %rd85, %rd84, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd85) : "l"(rd84));
  // PTX:278 red.global.add.f32 [%rd85], %f100
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (0)))), (float)(f100));
  // PTX:279 add.s64 %rd86, %rd84, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd86) : "l"(rd84));
  // PTX:280 red.global.add.f32 [%rd86], %f101
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd86) + (0)))), (float)(f101));
  // PTX:281 mul.wide.s32 %rd87, %r48, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd87) : "r"(r48));
  // PTX:282 add.s64 %rd88, %rd1, %rd87
  asm("add.s64 %0, %1, %2;" : "=l"(rd88) : "l"(rd1), "l"(rd87));
  // PTX:283 red.global.add.f32 [%rd88], %f103
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (0)))), (float)(f103));
  // PTX:284 add.s64 %rd89, %rd88, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd89) : "l"(rd88));
  // PTX:285 red.global.add.f32 [%rd89], %f104
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (0)))), (float)(f104));
  // PTX:286 add.s64 %rd90, %rd88, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd90) : "l"(rd88));
  // PTX:287 red.global.add.f32 [%rd90], %f105
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (0)))), (float)(f105));
  // PTX:289 $L__BB26_10:
L_BB26_10:;
  // PTX:290 @%p4 bra $L__BB26_12
  if (p4) { goto L_BB26_12; }
  // PTX:292 ld.global.f32 %f118, [%rd14]
  f118 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:293 neg.f32 %f119, %f19
  asm("neg.f32 %0, %1;" : "=f"(f119) : "f"(f19));
  // PTX:294 mul.f32 %f120, %f118, %f119
  asm("mul.f32 %0, %1, %2;" : "=f"(f120) : "f"(f118), "f"(f119));
  // PTX:295 neg.f32 %f121, %f20
  asm("neg.f32 %0, %1;" : "=f"(f121) : "f"(f20));
  // PTX:296 mul.f32 %f122, %f118, %f121
  asm("mul.f32 %0, %1, %2;" : "=f"(f122) : "f"(f118), "f"(f121));
  // PTX:297 neg.f32 %f123, %f21
  asm("neg.f32 %0, %1;" : "=f"(f123) : "f"(f21));
  // PTX:298 mul.f32 %f124, %f118, %f123
  asm("mul.f32 %0, %1, %2;" : "=f"(f124) : "f"(f118), "f"(f123));
  // PTX:299 ld.global.f32 %f125, [%rd14+4]
  f125 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (4)))));
  // PTX:300 mul.f32 %f126, %f125, %f119
  asm("mul.f32 %0, %1, %2;" : "=f"(f126) : "f"(f125), "f"(f119));
  // PTX:301 mul.f32 %f127, %f125, %f121
  asm("mul.f32 %0, %1, %2;" : "=f"(f127) : "f"(f125), "f"(f121));
  // PTX:302 mul.f32 %f128, %f125, %f123
  asm("mul.f32 %0, %1, %2;" : "=f"(f128) : "f"(f125), "f"(f123));
  // PTX:303 ld.global.f32 %f129, [%rd14+8]
  f129 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (8)))));
  // PTX:304 mul.f32 %f130, %f129, %f119
  asm("mul.f32 %0, %1, %2;" : "=f"(f130) : "f"(f129), "f"(f119));
  // PTX:305 mul.f32 %f131, %f129, %f121
  asm("mul.f32 %0, %1, %2;" : "=f"(f131) : "f"(f129), "f"(f121));
  // PTX:306 mul.f32 %f132, %f129, %f123
  asm("mul.f32 %0, %1, %2;" : "=f"(f132) : "f"(f129), "f"(f123));
  // PTX:307 ld.global.f32 %f133, [%rd14+12]
  f133 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (12)))));
  // PTX:308 mul.f32 %f134, %f133, %f119
  asm("mul.f32 %0, %1, %2;" : "=f"(f134) : "f"(f133), "f"(f119));
  // PTX:309 mul.f32 %f135, %f133, %f121
  asm("mul.f32 %0, %1, %2;" : "=f"(f135) : "f"(f133), "f"(f121));
  // PTX:310 mul.f32 %f136, %f133, %f123
  asm("mul.f32 %0, %1, %2;" : "=f"(f136) : "f"(f133), "f"(f123));
  // PTX:311 mul.wide.s32 %rd91, %r49, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd91) : "r"(r49));
  // PTX:312 add.s64 %rd92, %rd1, %rd91
  asm("add.s64 %0, %1, %2;" : "=l"(rd92) : "l"(rd1), "l"(rd91));
  // PTX:313 red.global.add.f32 [%rd92], %f120
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (0)))), (float)(f120));
  // PTX:314 add.s64 %rd93, %rd92, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd93) : "l"(rd92));
  // PTX:315 red.global.add.f32 [%rd93], %f122
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (0)))), (float)(f122));
  // PTX:316 add.s64 %rd94, %rd92, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd94) : "l"(rd92));
  // PTX:317 red.global.add.f32 [%rd94], %f124
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd94) + (0)))), (float)(f124));
  // PTX:318 mul.wide.s32 %rd95, %r50, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd95) : "r"(r50));
  // PTX:319 add.s64 %rd96, %rd1, %rd95
  asm("add.s64 %0, %1, %2;" : "=l"(rd96) : "l"(rd1), "l"(rd95));
  // PTX:320 red.global.add.f32 [%rd96], %f126
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (0)))), (float)(f126));
  // PTX:321 add.s64 %rd97, %rd96, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd97) : "l"(rd96));
  // PTX:322 red.global.add.f32 [%rd97], %f127
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd97) + (0)))), (float)(f127));
  // PTX:323 add.s64 %rd98, %rd96, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd98) : "l"(rd96));
  // PTX:324 red.global.add.f32 [%rd98], %f128
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (0)))), (float)(f128));
  // PTX:325 mul.wide.s32 %rd99, %r51, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd99) : "r"(r51));
  // PTX:326 add.s64 %rd100, %rd1, %rd99
  asm("add.s64 %0, %1, %2;" : "=l"(rd100) : "l"(rd1), "l"(rd99));
  // PTX:327 red.global.add.f32 [%rd100], %f130
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (0)))), (float)(f130));
  // PTX:328 add.s64 %rd101, %rd100, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd101) : "l"(rd100));
  // PTX:329 red.global.add.f32 [%rd101], %f131
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd101) + (0)))), (float)(f131));
  // PTX:330 add.s64 %rd102, %rd100, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd102) : "l"(rd100));
  // PTX:331 red.global.add.f32 [%rd102], %f132
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd102) + (0)))), (float)(f132));
  // PTX:332 mul.wide.s32 %rd103, %r52, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd103) : "r"(r52));
  // PTX:333 add.s64 %rd104, %rd1, %rd103
  asm("add.s64 %0, %1, %2;" : "=l"(rd104) : "l"(rd1), "l"(rd103));
  // PTX:334 red.global.add.f32 [%rd104], %f134
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd104) + (0)))), (float)(f134));
  // PTX:335 add.s64 %rd105, %rd104, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd105) : "l"(rd104));
  // PTX:336 red.global.add.f32 [%rd105], %f135
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (0)))), (float)(f135));
  // PTX:337 add.s64 %rd106, %rd104, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd106) : "l"(rd104));
  // PTX:338 red.global.add.f32 [%rd106], %f136
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (0)))), (float)(f136));
  // PTX:340 $L__BB26_12:
L_BB26_12:;
  // PTX:341 ret
  return;
}
