// 机械还原自 PTX：synreal::kernel::update_body_distance_constraint_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: cf27d9ecab5873b2e0c5dfc560bab34decb21abbe00f83fd5f0985d662e9ce4e
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__update_body_distance_constraint_state(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10, unsigned long long param11, unsigned long long param12) {
  int p0, p1, p2, p3, p4, p5, p6, p7;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73;
  // PTX:29 ld.param.u64 %rd23, [_ZN7synreal6kernel37update_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_0]
  rd23 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:30 ld.param.u64 %rd24, [_ZN7synreal6kernel37update_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_1]
  rd24 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:31 ld.param.u64 %rd13, [_ZN7synreal6kernel37update_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_2]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:32 ld.param.u64 %rd14, [_ZN7synreal6kernel37update_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_3]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:33 ld.param.u64 %rd15, [_ZN7synreal6kernel37update_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_4]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:34 ld.param.u64 %rd16, [_ZN7synreal6kernel37update_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_5]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:35 ld.param.u64 %rd17, [_ZN7synreal6kernel37update_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_6]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:36 ld.param.u64 %rd18, [_ZN7synreal6kernel37update_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_7]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:37 ld.param.u64 %rd19, [_ZN7synreal6kernel37update_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_8]
  rd19 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:38 ld.param.u64 %rd20, [_ZN7synreal6kernel37update_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_9]
  rd20 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:39 ld.param.u64 %rd25, [_ZN7synreal6kernel37update_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_10]
  rd25 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:40 ld.param.u64 %rd21, [_ZN7synreal6kernel37update_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_11]
  rd21 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:41 ld.param.u64 %rd22, [_ZN7synreal6kernel37update_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_12]
  rd22 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:42 cvta.to.global.u64 %rd1, %rd23
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd23));
  // PTX:43 cvta.to.global.u64 %rd2, %rd24
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd24));
  // PTX:44 mov.u32 %r15, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r15) : "r"(blockIdx.x));
  // PTX:45 mov.u32 %r16, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r16) : "r"(blockDim.x));
  // PTX:46 mul.wide.u32 %rd26, %r15, %r16
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd26) : "r"(r15), "r"(r16));
  // PTX:47 mov.u32 %r17, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r17) : "r"(threadIdx.x));
  // PTX:48 cvt.u64.u32 %rd27, %r17
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd27) : "r"(r17));
  // PTX:49 add.s64 %rd3, %rd26, %rd27
  asm("add.s64 %0, %1, %2;" : "=l"(rd3) : "l"(rd26), "l"(rd27));
  // PTX:50 setp.ge.u64 %p1, %rd3, %rd25
  p1 = (((unsigned long long)(rd3)) >= ((unsigned long long)(rd25)));
  // PTX:51 @%p1 bra $L__BB27_15
  if (p1) { goto L_BB27_15; }
  // PTX:53 or.b64 %rd28, %rd3, %rd21
  asm("or.b64 %0, %1, %2;" : "=l"(rd28) : "l"(rd3), "l"(rd21));
  // PTX:54 and.b64 %rd29, %rd28, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd29) : "l"(rd28));
  // PTX:55 setp.eq.s64 %p2, %rd29, 0
  p2 = (((long long)(rd29)) == ((long long)(0)));
  // PTX:56 @%p2 bra $L__BB27_3
  if (p2) { goto L_BB27_3; }
  // PTX:58 div.u64 %rd72, %rd3, %rd21
  asm("div.u64 %0, %1, %2;" : "=l"(rd72) : "l"(rd3), "l"(rd21));
  // PTX:59 mul.lo.s64 %rd30, %rd72, %rd21
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd30) : "l"(rd72), "l"(rd21));
  // PTX:60 sub.s64 %rd73, %rd3, %rd30
  asm("sub.s64 %0, %1, %2;" : "=l"(rd73) : "l"(rd3), "l"(rd30));
  // PTX:61 bra.uni $L__BB27_4
  goto L_BB27_4;
  // PTX:63 $L__BB27_3:
L_BB27_3:;
  // PTX:64 cvt.u32.u64 %r18, %rd21
  asm("cvt.u32.u64 %0, %1;" : "=r"(r18) : "l"(rd21));
  // PTX:65 cvt.u32.u64 %r19, %rd3
  asm("cvt.u32.u64 %0, %1;" : "=r"(r19) : "l"(rd3));
  // PTX:66 div.u32 %r20, %r19, %r18
  asm("div.u32 %0, %1, %2;" : "=r"(r20) : "r"(r19), "r"(r18));
  // PTX:67 mul.lo.s32 %r21, %r20, %r18
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r21) : "r"(r20), "r"(r18));
  // PTX:68 sub.s32 %r22, %r19, %r21
  asm("sub.s32 %0, %1, %2;" : "=r"(r22) : "r"(r19), "r"(r21));
  // PTX:69 cvt.u64.u32 %rd72, %r20
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd72) : "r"(r20));
  // PTX:70 cvt.u64.u32 %rd73, %r22
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd73) : "r"(r22));
  // PTX:72 $L__BB27_4:
L_BB27_4:;
  // PTX:73 mul.lo.s64 %rd31, %rd72, %rd22
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd72), "l"(rd22));
  // PTX:74 cvt.u32.u64 %r1, %rd31
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd31));
  // PTX:75 cvta.to.global.u64 %rd32, %rd13
  rd32 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd13));
  // PTX:76 shl.b64 %rd33, %rd73, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd33) : "l"(rd73));
  // PTX:77 add.s64 %rd34, %rd32, %rd33
  asm("add.s64 %0, %1, %2;" : "=l"(rd34) : "l"(rd32), "l"(rd33));
  // PTX:78 ld.global.u32 %r2, [%rd34]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (0)))));
  // PTX:79 ld.global.s32 %rd10, [%rd34+4]
  rd10 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (4)))));
  // PTX:80 cvta.to.global.u64 %rd35, %rd14
  rd35 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd14));
  // PTX:81 mul.lo.s64 %rd36, %rd73, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd36) : "l"(rd73));
  // PTX:82 add.s64 %rd37, %rd35, %rd36
  asm("add.s64 %0, %1, %2;" : "=l"(rd37) : "l"(rd35), "l"(rd36));
  // PTX:83 ld.global.f32 %f104, [%rd37]
  f104 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (0)))));
  // PTX:84 ld.global.f32 %f105, [%rd37+4]
  f105 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (4)))));
  // PTX:85 ld.global.f32 %f106, [%rd37+8]
  f106 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (8)))));
  // PTX:86 cvta.to.global.u64 %rd38, %rd15
  rd38 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd15));
  // PTX:87 add.s64 %rd39, %rd38, %rd36
  asm("add.s64 %0, %1, %2;" : "=l"(rd39) : "l"(rd38), "l"(rd36));
  // PTX:88 ld.global.f32 %f107, [%rd39]
  f107 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (0)))));
  // PTX:89 ld.global.f32 %f108, [%rd39+4]
  f108 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (4)))));
  // PTX:90 ld.global.f32 %f109, [%rd39+8]
  f109 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (8)))));
  // PTX:91 setp.lt.s32 %p3, %r2, 0
  p3 = (((int)(r2)) < ((int)(0)));
  // PTX:92 @%p3 bra $L__BB27_6
  if (p3) { goto L_BB27_6; }
  // PTX:94 mul.wide.s32 %rd40, %r2, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd40) : "r"(r2));
  // PTX:95 add.s64 %rd41, %rd2, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd41) : "l"(rd2), "l"(rd40));
  // PTX:96 ld.global.u32 %r23, [%rd41]
  r23 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (0)))));
  // PTX:97 add.s32 %r24, %r23, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r24) : "r"(r23), "r"(r1));
  // PTX:98 ld.global.u32 %r25, [%rd41+4]
  r25 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (4)))));
  // PTX:99 add.s32 %r26, %r25, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r26) : "r"(r25), "r"(r1));
  // PTX:100 ld.global.u32 %r27, [%rd41+8]
  r27 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (8)))));
  // PTX:101 add.s32 %r28, %r27, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r28) : "r"(r27), "r"(r1));
  // PTX:102 ld.global.u32 %r29, [%rd41+12]
  r29 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (12)))));
  // PTX:103 add.s32 %r30, %r29, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r30) : "r"(r29), "r"(r1));
  // PTX:104 cvta.to.global.u64 %rd42, %rd16
  rd42 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd16));
  // PTX:105 shl.b64 %rd43, %rd73, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd43) : "l"(rd73));
  // PTX:106 add.s64 %rd44, %rd42, %rd43
  asm("add.s64 %0, %1, %2;" : "=l"(rd44) : "l"(rd42), "l"(rd43));
  // PTX:107 mul.wide.s32 %rd45, %r24, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd45) : "r"(r24));
  // PTX:108 add.s64 %rd46, %rd1, %rd45
  asm("add.s64 %0, %1, %2;" : "=l"(rd46) : "l"(rd1), "l"(rd45));
  // PTX:109 ld.global.f32 %f28, [%rd46]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (0)))));
  // PTX:110 ld.global.f32 %f29, [%rd44]
  f29 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))));
  // PTX:111 ld.global.f32 %f30, [%rd46+4]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (4)))));
  // PTX:112 ld.global.f32 %f31, [%rd46+8]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (8)))));
  // PTX:113 mul.wide.s32 %rd47, %r26, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd47) : "r"(r26));
  // PTX:114 add.s64 %rd48, %rd1, %rd47
  asm("add.s64 %0, %1, %2;" : "=l"(rd48) : "l"(rd1), "l"(rd47));
  // PTX:115 ld.global.f32 %f32, [%rd48]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))));
  // PTX:116 ld.global.f32 %f33, [%rd44+4]
  f33 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (4)))));
  // PTX:117 mul.f32 %f34, %f33, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f34) : "f"(f33), "f"(f32));
  // PTX:118 ld.global.f32 %f35, [%rd48+4]
  f35 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (4)))));
  // PTX:119 mul.f32 %f36, %f33, %f35
  asm("mul.f32 %0, %1, %2;" : "=f"(f36) : "f"(f33), "f"(f35));
  // PTX:120 ld.global.f32 %f37, [%rd48+8]
  f37 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (8)))));
  // PTX:121 mul.f32 %f38, %f33, %f37
  asm("mul.f32 %0, %1, %2;" : "=f"(f38) : "f"(f33), "f"(f37));
  // PTX:122 fma.rn.f32 %f39, %f29, %f28, %f34
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f39) : "f"(f29), "f"(f28), "f"(f34));
  // PTX:123 fma.rn.f32 %f40, %f29, %f30, %f36
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f40) : "f"(f29), "f"(f30), "f"(f36));
  // PTX:124 fma.rn.f32 %f41, %f29, %f31, %f38
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f41) : "f"(f29), "f"(f31), "f"(f38));
  // PTX:125 mul.wide.s32 %rd49, %r28, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd49) : "r"(r28));
  // PTX:126 add.s64 %rd50, %rd1, %rd49
  asm("add.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd1), "l"(rd49));
  // PTX:127 ld.global.f32 %f42, [%rd50]
  f42 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (0)))));
  // PTX:128 ld.global.f32 %f43, [%rd44+8]
  f43 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (8)))));
  // PTX:129 ld.global.f32 %f44, [%rd50+4]
  f44 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (4)))));
  // PTX:130 ld.global.f32 %f45, [%rd50+8]
  f45 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (8)))));
  // PTX:131 fma.rn.f32 %f46, %f43, %f42, %f39
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f46) : "f"(f43), "f"(f42), "f"(f39));
  // PTX:132 fma.rn.f32 %f47, %f43, %f44, %f40
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f47) : "f"(f43), "f"(f44), "f"(f40));
  // PTX:133 fma.rn.f32 %f48, %f43, %f45, %f41
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f48) : "f"(f43), "f"(f45), "f"(f41));
  // PTX:134 mul.wide.s32 %rd51, %r30, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd51) : "r"(r30));
  // PTX:135 add.s64 %rd52, %rd1, %rd51
  asm("add.s64 %0, %1, %2;" : "=l"(rd52) : "l"(rd1), "l"(rd51));
  // PTX:136 ld.global.f32 %f49, [%rd52]
  f49 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))));
  // PTX:137 ld.global.f32 %f50, [%rd44+12]
  f50 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (12)))));
  // PTX:138 ld.global.f32 %f51, [%rd52+4]
  f51 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (4)))));
  // PTX:139 ld.global.f32 %f52, [%rd52+8]
  f52 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (8)))));
  // PTX:140 fma.rn.f32 %f104, %f50, %f49, %f46
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f104) : "f"(f50), "f"(f49), "f"(f46));
  // PTX:141 fma.rn.f32 %f105, %f50, %f51, %f47
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f105) : "f"(f50), "f"(f51), "f"(f47));
  // PTX:142 fma.rn.f32 %f106, %f50, %f52, %f48
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f106) : "f"(f50), "f"(f52), "f"(f48));
  // PTX:144 $L__BB27_6:
L_BB27_6:;
  // PTX:145 cvt.u32.u64 %r31, %rd10
  asm("cvt.u32.u64 %0, %1;" : "=r"(r31) : "l"(rd10));
  // PTX:146 setp.lt.s32 %p4, %r31, 0
  p4 = (((int)(r31)) < ((int)(0)));
  // PTX:147 @%p4 bra $L__BB27_8
  if (p4) { goto L_BB27_8; }
  // PTX:149 shl.b64 %rd53, %rd10, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd53) : "l"(rd10));
  // PTX:150 add.s64 %rd54, %rd2, %rd53
  asm("add.s64 %0, %1, %2;" : "=l"(rd54) : "l"(rd2), "l"(rd53));
  // PTX:151 ld.global.u32 %r32, [%rd54]
  r32 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))));
  // PTX:152 add.s32 %r33, %r32, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r33) : "r"(r32), "r"(r1));
  // PTX:153 ld.global.u32 %r34, [%rd54+4]
  r34 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (4)))));
  // PTX:154 add.s32 %r35, %r34, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r35) : "r"(r34), "r"(r1));
  // PTX:155 ld.global.u32 %r36, [%rd54+8]
  r36 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (8)))));
  // PTX:156 add.s32 %r37, %r36, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r37) : "r"(r36), "r"(r1));
  // PTX:157 ld.global.u32 %r38, [%rd54+12]
  r38 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (12)))));
  // PTX:158 add.s32 %r39, %r38, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r39) : "r"(r38), "r"(r1));
  // PTX:159 cvta.to.global.u64 %rd55, %rd17
  rd55 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd17));
  // PTX:160 shl.b64 %rd56, %rd73, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd56) : "l"(rd73));
  // PTX:161 add.s64 %rd57, %rd55, %rd56
  asm("add.s64 %0, %1, %2;" : "=l"(rd57) : "l"(rd55), "l"(rd56));
  // PTX:162 mul.wide.s32 %rd58, %r33, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd58) : "r"(r33));
  // PTX:163 add.s64 %rd59, %rd1, %rd58
  asm("add.s64 %0, %1, %2;" : "=l"(rd59) : "l"(rd1), "l"(rd58));
  // PTX:164 ld.global.f32 %f53, [%rd59]
  f53 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))));
  // PTX:165 ld.global.f32 %f54, [%rd57]
  f54 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))));
  // PTX:166 ld.global.f32 %f55, [%rd59+4]
  f55 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (4)))));
  // PTX:167 ld.global.f32 %f56, [%rd59+8]
  f56 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (8)))));
  // PTX:168 mul.wide.s32 %rd60, %r35, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd60) : "r"(r35));
  // PTX:169 add.s64 %rd61, %rd1, %rd60
  asm("add.s64 %0, %1, %2;" : "=l"(rd61) : "l"(rd1), "l"(rd60));
  // PTX:170 ld.global.f32 %f57, [%rd61]
  f57 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))));
  // PTX:171 ld.global.f32 %f58, [%rd57+4]
  f58 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (4)))));
  // PTX:172 mul.f32 %f59, %f58, %f57
  asm("mul.f32 %0, %1, %2;" : "=f"(f59) : "f"(f58), "f"(f57));
  // PTX:173 ld.global.f32 %f60, [%rd61+4]
  f60 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (4)))));
  // PTX:174 mul.f32 %f61, %f58, %f60
  asm("mul.f32 %0, %1, %2;" : "=f"(f61) : "f"(f58), "f"(f60));
  // PTX:175 ld.global.f32 %f62, [%rd61+8]
  f62 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (8)))));
  // PTX:176 mul.f32 %f63, %f58, %f62
  asm("mul.f32 %0, %1, %2;" : "=f"(f63) : "f"(f58), "f"(f62));
  // PTX:177 fma.rn.f32 %f64, %f54, %f53, %f59
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f64) : "f"(f54), "f"(f53), "f"(f59));
  // PTX:178 fma.rn.f32 %f65, %f54, %f55, %f61
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f65) : "f"(f54), "f"(f55), "f"(f61));
  // PTX:179 fma.rn.f32 %f66, %f54, %f56, %f63
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f66) : "f"(f54), "f"(f56), "f"(f63));
  // PTX:180 mul.wide.s32 %rd62, %r37, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd62) : "r"(r37));
  // PTX:181 add.s64 %rd63, %rd1, %rd62
  asm("add.s64 %0, %1, %2;" : "=l"(rd63) : "l"(rd1), "l"(rd62));
  // PTX:182 ld.global.f32 %f67, [%rd63]
  f67 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (0)))));
  // PTX:183 ld.global.f32 %f68, [%rd57+8]
  f68 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (8)))));
  // PTX:184 ld.global.f32 %f69, [%rd63+4]
  f69 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (4)))));
  // PTX:185 ld.global.f32 %f70, [%rd63+8]
  f70 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (8)))));
  // PTX:186 fma.rn.f32 %f71, %f68, %f67, %f64
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f71) : "f"(f68), "f"(f67), "f"(f64));
  // PTX:187 fma.rn.f32 %f72, %f68, %f69, %f65
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f72) : "f"(f68), "f"(f69), "f"(f65));
  // PTX:188 fma.rn.f32 %f73, %f68, %f70, %f66
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f73) : "f"(f68), "f"(f70), "f"(f66));
  // PTX:189 mul.wide.s32 %rd64, %r39, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd64) : "r"(r39));
  // PTX:190 add.s64 %rd65, %rd1, %rd64
  asm("add.s64 %0, %1, %2;" : "=l"(rd65) : "l"(rd1), "l"(rd64));
  // PTX:191 ld.global.f32 %f74, [%rd65]
  f74 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (0)))));
  // PTX:192 ld.global.f32 %f75, [%rd57+12]
  f75 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (12)))));
  // PTX:193 ld.global.f32 %f76, [%rd65+4]
  f76 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (4)))));
  // PTX:194 ld.global.f32 %f77, [%rd65+8]
  f77 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (8)))));
  // PTX:195 fma.rn.f32 %f107, %f75, %f74, %f71
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f107) : "f"(f75), "f"(f74), "f"(f71));
  // PTX:196 fma.rn.f32 %f108, %f75, %f76, %f72
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f108) : "f"(f75), "f"(f76), "f"(f72));
  // PTX:197 fma.rn.f32 %f109, %f75, %f77, %f73
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f109) : "f"(f75), "f"(f77), "f"(f73));
  // PTX:199 $L__BB27_8:
L_BB27_8:;
  // PTX:200 cvta.to.global.u64 %rd66, %rd20
  rd66 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd20));
  // PTX:201 mul.lo.s64 %rd67, %rd3, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd67) : "l"(rd3));
  // PTX:202 add.s64 %rd11, %rd66, %rd67
  asm("add.s64 %0, %1, %2;" : "=l"(rd11) : "l"(rd66), "l"(rd67));
  // PTX:203 ld.global.f32 %f78, [%rd11]
  f78 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (0)))));
  // PTX:204 sub.f32 %f79, %f107, %f104
  asm("sub.f32 %0, %1, %2;" : "=f"(f79) : "f"(f107), "f"(f104));
  // PTX:205 add.f32 %f19, %f79, %f78
  asm("add.f32 %0, %1, %2;" : "=f"(f19) : "f"(f79), "f"(f78));
  // PTX:206 ld.global.f32 %f80, [%rd11+4]
  f80 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (4)))));
  // PTX:207 sub.f32 %f81, %f108, %f105
  asm("sub.f32 %0, %1, %2;" : "=f"(f81) : "f"(f108), "f"(f105));
  // PTX:208 add.f32 %f20, %f81, %f80
  asm("add.f32 %0, %1, %2;" : "=f"(f20) : "f"(f81), "f"(f80));
  // PTX:209 ld.global.f32 %f82, [%rd11+8]
  f82 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (8)))));
  // PTX:210 sub.f32 %f83, %f109, %f106
  asm("sub.f32 %0, %1, %2;" : "=f"(f83) : "f"(f109), "f"(f106));
  // PTX:211 add.f32 %f21, %f83, %f82
  asm("add.f32 %0, %1, %2;" : "=f"(f21) : "f"(f83), "f"(f82));
  // PTX:212 cvta.to.global.u64 %rd68, %rd19
  rd68 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd19));
  // PTX:213 add.s64 %rd12, %rd68, %rd67
  asm("add.s64 %0, %1, %2;" : "=l"(rd12) : "l"(rd68), "l"(rd67));
  // PTX:214 ld.global.f32 %f22, [%rd12]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (0)))));
  // PTX:215 ld.global.f32 %f23, [%rd12+4]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (4)))));
  // PTX:216 ld.global.f32 %f24, [%rd12+8]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (8)))));
  // PTX:217 cvta.to.global.u64 %rd69, %rd18
  rd69 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd18));
  // PTX:218 shl.b64 %rd70, %rd73, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd70) : "l"(rd73));
  // PTX:219 add.s64 %rd71, %rd69, %rd70
  asm("add.s64 %0, %1, %2;" : "=l"(rd71) : "l"(rd69), "l"(rd70));
  // PTX:220 ld.global.f32 %f25, [%rd71]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))));
  // PTX:221 setp.le.f32 %p5, %f25, 0f00000000
  p5 = (!(isnan(((float)(f25))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f25)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:222 mov.u32 %r44, 0
  asm("mov.u32 %0, 0;" : "=r"(r44) : );
  // PTX:223 mov.u32 %r43, %r44
  asm("mov.u32 %0, %1;" : "=r"(r43) : "r"(r44));
  // PTX:224 mov.u32 %r45, %r44
  asm("mov.u32 %0, %1;" : "=r"(r45) : "r"(r44));
  // PTX:225 @%p5 bra $L__BB27_14
  if (p5) { goto L_BB27_14; }
  // PTX:227 mul.f32 %f84, %f20, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f84) : "f"(f20), "f"(f20));
  // PTX:228 fma.rn.f32 %f85, %f19, %f19, %f84
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f85) : "f"(f19), "f"(f19), "f"(f84));
  // PTX:229 fma.rn.f32 %f86, %f21, %f21, %f85
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f86) : "f"(f21), "f"(f21), "f"(f85));
  // PTX:230 sqrt.rn.f32 %f26, %f86
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f26) : "f"(f86));
  // PTX:231 setp.gt.f32 %p6, %f26, 0f322BCC77
  p6 = (!(isnan(((float)(f26))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f26)) > ((float)(as_f32(0x322BCC77u)))));
  // PTX:232 @%p6 bra $L__BB27_13
  if (p6) { goto L_BB27_13; }
  // PTX:233 bra.uni $L__BB27_10
  goto L_BB27_10;
  // PTX:235 $L__BB27_13:
L_BB27_13:;
  // PTX:236 div.rn.f32 %f94, %f25, %f26
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f94) : "f"(f25), "f"(f26));
  // PTX:237 mul.f32 %f95, %f19, %f94
  asm("mul.f32 %0, %1, %2;" : "=f"(f95) : "f"(f19), "f"(f94));
  // PTX:238 mul.f32 %f96, %f20, %f94
  asm("mul.f32 %0, %1, %2;" : "=f"(f96) : "f"(f20), "f"(f94));
  // PTX:239 mul.f32 %f97, %f21, %f94
  asm("mul.f32 %0, %1, %2;" : "=f"(f97) : "f"(f21), "f"(f94));
  // PTX:240 mov.b32 %r45, %f97
  asm("mov.b32 %0, %1;" : "=r"(r45) : "f"(f97));
  // PTX:241 mov.b32 %r44, %f96
  asm("mov.b32 %0, %1;" : "=r"(r44) : "f"(f96));
  // PTX:242 mov.b32 %r43, %f95
  asm("mov.b32 %0, %1;" : "=r"(r43) : "f"(f95));
  // PTX:243 bra.uni $L__BB27_14
  goto L_BB27_14;
  // PTX:245 $L__BB27_10:
L_BB27_10:;
  // PTX:246 mul.f32 %f87, %f23, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f87) : "f"(f23), "f"(f23));
  // PTX:247 fma.rn.f32 %f88, %f22, %f22, %f87
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f88) : "f"(f22), "f"(f22), "f"(f87));
  // PTX:248 fma.rn.f32 %f89, %f24, %f24, %f88
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f89) : "f"(f24), "f"(f24), "f"(f88));
  // PTX:249 sqrt.rn.f32 %f27, %f89
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f27) : "f"(f89));
  // PTX:250 setp.gt.f32 %p7, %f27, 0f322BCC77
  p7 = (!(isnan(((float)(f27))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f27)) > ((float)(as_f32(0x322BCC77u)))));
  // PTX:251 @%p7 bra $L__BB27_12
  if (p7) { goto L_BB27_12; }
  // PTX:252 bra.uni $L__BB27_11
  goto L_BB27_11;
  // PTX:254 $L__BB27_12:
L_BB27_12:;
  // PTX:255 div.rn.f32 %f90, %f25, %f27
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f90) : "f"(f25), "f"(f27));
  // PTX:256 mul.f32 %f91, %f22, %f90
  asm("mul.f32 %0, %1, %2;" : "=f"(f91) : "f"(f22), "f"(f90));
  // PTX:257 mul.f32 %f92, %f23, %f90
  asm("mul.f32 %0, %1, %2;" : "=f"(f92) : "f"(f23), "f"(f90));
  // PTX:258 mul.f32 %f93, %f24, %f90
  asm("mul.f32 %0, %1, %2;" : "=f"(f93) : "f"(f24), "f"(f90));
  // PTX:259 mov.b32 %r45, %f93
  asm("mov.b32 %0, %1;" : "=r"(r45) : "f"(f93));
  // PTX:260 mov.b32 %r44, %f92
  asm("mov.b32 %0, %1;" : "=r"(r44) : "f"(f92));
  // PTX:261 mov.b32 %r43, %f91
  asm("mov.b32 %0, %1;" : "=r"(r43) : "f"(f91));
  // PTX:262 bra.uni $L__BB27_14
  goto L_BB27_14;
  // PTX:264 $L__BB27_11:
L_BB27_11:;
  // PTX:265 mov.b32 %r43, %f25
  asm("mov.b32 %0, %1;" : "=r"(r43) : "f"(f25));
  // PTX:266 mov.u32 %r45, %r44
  asm("mov.u32 %0, %1;" : "=r"(r45) : "r"(r44));
  // PTX:268 $L__BB27_14:
L_BB27_14:;
  // PTX:269 mov.b32 %f98, %r43
  asm("mov.b32 %0, %1;" : "=f"(f98) : "r"(r43));
  // PTX:270 sub.f32 %f99, %f19, %f98
  asm("sub.f32 %0, %1, %2;" : "=f"(f99) : "f"(f19), "f"(f98));
  // PTX:271 mov.b32 %f100, %r44
  asm("mov.b32 %0, %1;" : "=f"(f100) : "r"(r44));
  // PTX:272 sub.f32 %f101, %f20, %f100
  asm("sub.f32 %0, %1, %2;" : "=f"(f101) : "f"(f20), "f"(f100));
  // PTX:273 mov.b32 %f102, %r45
  asm("mov.b32 %0, %1;" : "=f"(f102) : "r"(r45));
  // PTX:274 sub.f32 %f103, %f21, %f102
  asm("sub.f32 %0, %1, %2;" : "=f"(f103) : "f"(f21), "f"(f102));
  // PTX:275 st.global.f32 [%rd11], %f99
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (0))))) = (float)(f99);
  // PTX:276 st.global.f32 [%rd11+4], %f101
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (4))))) = (float)(f101);
  // PTX:277 st.global.f32 [%rd11+8], %f103
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (8))))) = (float)(f103);
  // PTX:278 st.global.u32 [%rd12], %r43
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (0))))) = (unsigned)(r43);
  // PTX:279 st.global.u32 [%rd12+4], %r44
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (4))))) = (unsigned)(r44);
  // PTX:280 st.global.u32 [%rd12+8], %r45
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (8))))) = (unsigned)(r45);
  // PTX:282 $L__BB27_15:
L_BB27_15:;
  // PTX:283 ret
  return;
}
