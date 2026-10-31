// 机械还原自 PTX：synreal::kernel::initialize_body_distance_constraint_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 0aee01f1ae66cf665855ecce6a86c591b7604b88e5f57e9c10ae1d40ab19ef46
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__initialize_body_distance_constraint_state(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10, unsigned long long param11, unsigned long long param12) {
  int p0, p1, p2, p3, p4, p5, p6;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73;
  // PTX:29 ld.param.u64 %rd21, [_ZN7synreal6kernel41initialize_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_0]
  rd21 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:30 ld.param.u64 %rd22, [_ZN7synreal6kernel41initialize_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_1]
  rd22 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:31 ld.param.u64 %rd11, [_ZN7synreal6kernel41initialize_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_2]
  rd11 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:32 ld.param.u64 %rd12, [_ZN7synreal6kernel41initialize_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_3]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:33 ld.param.u64 %rd13, [_ZN7synreal6kernel41initialize_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_4]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:34 ld.param.u64 %rd14, [_ZN7synreal6kernel41initialize_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_5]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:35 ld.param.u64 %rd15, [_ZN7synreal6kernel41initialize_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_6]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:36 ld.param.u64 %rd16, [_ZN7synreal6kernel41initialize_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_7]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:37 ld.param.u64 %rd17, [_ZN7synreal6kernel41initialize_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_8]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:38 ld.param.u64 %rd18, [_ZN7synreal6kernel41initialize_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_9]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:39 ld.param.u64 %rd23, [_ZN7synreal6kernel41initialize_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_10]
  rd23 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:40 ld.param.u64 %rd19, [_ZN7synreal6kernel41initialize_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_11]
  rd19 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:41 ld.param.u64 %rd20, [_ZN7synreal6kernel41initialize_body_distance_constraint_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfPS4_SI_mmm_param_12]
  rd20 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:42 cvta.to.global.u64 %rd1, %rd21
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd21));
  // PTX:43 cvta.to.global.u64 %rd2, %rd22
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd22));
  // PTX:44 mov.u32 %r12, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r12) : "r"(blockIdx.x));
  // PTX:45 mov.u32 %r13, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r13) : "r"(blockDim.x));
  // PTX:46 mul.wide.u32 %rd24, %r12, %r13
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd24) : "r"(r12), "r"(r13));
  // PTX:47 mov.u32 %r14, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r14) : "r"(threadIdx.x));
  // PTX:48 cvt.u64.u32 %rd25, %r14
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd25) : "r"(r14));
  // PTX:49 add.s64 %rd3, %rd24, %rd25
  asm("add.s64 %0, %1, %2;" : "=l"(rd3) : "l"(rd24), "l"(rd25));
  // PTX:50 setp.ge.u64 %p1, %rd3, %rd23
  p1 = (((unsigned long long)(rd3)) >= ((unsigned long long)(rd23)));
  // PTX:51 @%p1 bra $L__BB25_13
  if (p1) { goto L_BB25_13; }
  // PTX:53 or.b64 %rd26, %rd3, %rd19
  asm("or.b64 %0, %1, %2;" : "=l"(rd26) : "l"(rd3), "l"(rd19));
  // PTX:54 and.b64 %rd27, %rd26, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd27) : "l"(rd26));
  // PTX:55 setp.eq.s64 %p2, %rd27, 0
  p2 = (((long long)(rd27)) == ((long long)(0)));
  // PTX:56 @%p2 bra $L__BB25_3
  if (p2) { goto L_BB25_3; }
  // PTX:58 div.u64 %rd72, %rd3, %rd19
  asm("div.u64 %0, %1, %2;" : "=l"(rd72) : "l"(rd3), "l"(rd19));
  // PTX:59 mul.lo.s64 %rd28, %rd72, %rd19
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd28) : "l"(rd72), "l"(rd19));
  // PTX:60 sub.s64 %rd73, %rd3, %rd28
  asm("sub.s64 %0, %1, %2;" : "=l"(rd73) : "l"(rd3), "l"(rd28));
  // PTX:61 bra.uni $L__BB25_4
  goto L_BB25_4;
  // PTX:63 $L__BB25_3:
L_BB25_3:;
  // PTX:64 cvt.u32.u64 %r15, %rd19
  asm("cvt.u32.u64 %0, %1;" : "=r"(r15) : "l"(rd19));
  // PTX:65 cvt.u32.u64 %r16, %rd3
  asm("cvt.u32.u64 %0, %1;" : "=r"(r16) : "l"(rd3));
  // PTX:66 div.u32 %r17, %r16, %r15
  asm("div.u32 %0, %1, %2;" : "=r"(r17) : "r"(r16), "r"(r15));
  // PTX:67 mul.lo.s32 %r18, %r17, %r15
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r18) : "r"(r17), "r"(r15));
  // PTX:68 sub.s32 %r19, %r16, %r18
  asm("sub.s32 %0, %1, %2;" : "=r"(r19) : "r"(r16), "r"(r18));
  // PTX:69 cvt.u64.u32 %rd72, %r17
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd72) : "r"(r17));
  // PTX:70 cvt.u64.u32 %rd73, %r19
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd73) : "r"(r19));
  // PTX:72 $L__BB25_4:
L_BB25_4:;
  // PTX:73 mul.lo.s64 %rd29, %rd72, %rd20
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd29) : "l"(rd72), "l"(rd20));
  // PTX:74 cvt.u32.u64 %r1, %rd29
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd29));
  // PTX:75 cvta.to.global.u64 %rd30, %rd11
  rd30 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd11));
  // PTX:76 shl.b64 %rd31, %rd73, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd31) : "l"(rd73));
  // PTX:77 add.s64 %rd32, %rd30, %rd31
  asm("add.s64 %0, %1, %2;" : "=l"(rd32) : "l"(rd30), "l"(rd31));
  // PTX:78 ld.global.u32 %r2, [%rd32]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (0)))));
  // PTX:79 ld.global.s32 %rd10, [%rd32+4]
  rd10 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (4)))));
  // PTX:80 cvta.to.global.u64 %rd33, %rd12
  rd33 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd12));
  // PTX:81 mul.lo.s64 %rd34, %rd73, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd34) : "l"(rd73));
  // PTX:82 add.s64 %rd35, %rd33, %rd34
  asm("add.s64 %0, %1, %2;" : "=l"(rd35) : "l"(rd33), "l"(rd34));
  // PTX:83 ld.global.f32 %f83, [%rd35]
  f83 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (0)))));
  // PTX:84 ld.global.f32 %f82, [%rd35+4]
  f82 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (4)))));
  // PTX:85 ld.global.f32 %f81, [%rd35+8]
  f81 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (8)))));
  // PTX:86 cvta.to.global.u64 %rd36, %rd13
  rd36 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd13));
  // PTX:87 add.s64 %rd37, %rd36, %rd34
  asm("add.s64 %0, %1, %2;" : "=l"(rd37) : "l"(rd36), "l"(rd34));
  // PTX:88 ld.global.f32 %f86, [%rd37]
  f86 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (0)))));
  // PTX:89 ld.global.f32 %f85, [%rd37+4]
  f85 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (4)))));
  // PTX:90 ld.global.f32 %f84, [%rd37+8]
  f84 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (8)))));
  // PTX:91 setp.lt.s32 %p3, %r2, 0
  p3 = (((int)(r2)) < ((int)(0)));
  // PTX:92 @%p3 bra $L__BB25_6
  if (p3) { goto L_BB25_6; }
  // PTX:94 mul.wide.s32 %rd38, %r2, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd38) : "r"(r2));
  // PTX:95 add.s64 %rd39, %rd2, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd39) : "l"(rd2), "l"(rd38));
  // PTX:96 ld.global.u32 %r20, [%rd39]
  r20 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (0)))));
  // PTX:97 add.s32 %r21, %r20, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r21) : "r"(r20), "r"(r1));
  // PTX:98 ld.global.u32 %r22, [%rd39+4]
  r22 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (4)))));
  // PTX:99 add.s32 %r23, %r22, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r23) : "r"(r22), "r"(r1));
  // PTX:100 ld.global.u32 %r24, [%rd39+8]
  r24 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (8)))));
  // PTX:101 add.s32 %r25, %r24, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r25) : "r"(r24), "r"(r1));
  // PTX:102 ld.global.u32 %r26, [%rd39+12]
  r26 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (12)))));
  // PTX:103 add.s32 %r27, %r26, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r27) : "r"(r26), "r"(r1));
  // PTX:104 cvta.to.global.u64 %rd40, %rd14
  rd40 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd14));
  // PTX:105 shl.b64 %rd41, %rd73, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd41) : "l"(rd73));
  // PTX:106 add.s64 %rd42, %rd40, %rd41
  asm("add.s64 %0, %1, %2;" : "=l"(rd42) : "l"(rd40), "l"(rd41));
  // PTX:107 mul.wide.s32 %rd43, %r21, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd43) : "r"(r21));
  // PTX:108 add.s64 %rd44, %rd1, %rd43
  asm("add.s64 %0, %1, %2;" : "=l"(rd44) : "l"(rd1), "l"(rd43));
  // PTX:109 ld.global.f32 %f24, [%rd44]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))));
  // PTX:110 ld.global.f32 %f25, [%rd42]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (0)))));
  // PTX:111 ld.global.f32 %f26, [%rd44+4]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (4)))));
  // PTX:112 ld.global.f32 %f27, [%rd44+8]
  f27 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (8)))));
  // PTX:113 mul.wide.s32 %rd45, %r23, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd45) : "r"(r23));
  // PTX:114 add.s64 %rd46, %rd1, %rd45
  asm("add.s64 %0, %1, %2;" : "=l"(rd46) : "l"(rd1), "l"(rd45));
  // PTX:115 ld.global.f32 %f28, [%rd46]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (0)))));
  // PTX:116 ld.global.f32 %f29, [%rd42+4]
  f29 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (4)))));
  // PTX:117 mul.f32 %f30, %f29, %f28
  asm("mul.f32 %0, %1, %2;" : "=f"(f30) : "f"(f29), "f"(f28));
  // PTX:118 ld.global.f32 %f31, [%rd46+4]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (4)))));
  // PTX:119 mul.f32 %f32, %f29, %f31
  asm("mul.f32 %0, %1, %2;" : "=f"(f32) : "f"(f29), "f"(f31));
  // PTX:120 ld.global.f32 %f33, [%rd46+8]
  f33 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (8)))));
  // PTX:121 mul.f32 %f34, %f29, %f33
  asm("mul.f32 %0, %1, %2;" : "=f"(f34) : "f"(f29), "f"(f33));
  // PTX:122 fma.rn.f32 %f35, %f25, %f24, %f30
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f35) : "f"(f25), "f"(f24), "f"(f30));
  // PTX:123 fma.rn.f32 %f36, %f25, %f26, %f32
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f36) : "f"(f25), "f"(f26), "f"(f32));
  // PTX:124 fma.rn.f32 %f37, %f25, %f27, %f34
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f37) : "f"(f25), "f"(f27), "f"(f34));
  // PTX:125 mul.wide.s32 %rd47, %r25, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd47) : "r"(r25));
  // PTX:126 add.s64 %rd48, %rd1, %rd47
  asm("add.s64 %0, %1, %2;" : "=l"(rd48) : "l"(rd1), "l"(rd47));
  // PTX:127 ld.global.f32 %f38, [%rd48]
  f38 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))));
  // PTX:128 ld.global.f32 %f39, [%rd42+8]
  f39 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (8)))));
  // PTX:129 ld.global.f32 %f40, [%rd48+4]
  f40 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (4)))));
  // PTX:130 ld.global.f32 %f41, [%rd48+8]
  f41 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (8)))));
  // PTX:131 fma.rn.f32 %f42, %f39, %f38, %f35
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f42) : "f"(f39), "f"(f38), "f"(f35));
  // PTX:132 fma.rn.f32 %f43, %f39, %f40, %f36
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f43) : "f"(f39), "f"(f40), "f"(f36));
  // PTX:133 fma.rn.f32 %f44, %f39, %f41, %f37
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f44) : "f"(f39), "f"(f41), "f"(f37));
  // PTX:134 mul.wide.s32 %rd49, %r27, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd49) : "r"(r27));
  // PTX:135 add.s64 %rd50, %rd1, %rd49
  asm("add.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd1), "l"(rd49));
  // PTX:136 ld.global.f32 %f45, [%rd50]
  f45 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (0)))));
  // PTX:137 ld.global.f32 %f46, [%rd42+12]
  f46 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (12)))));
  // PTX:138 ld.global.f32 %f47, [%rd50+4]
  f47 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (4)))));
  // PTX:139 ld.global.f32 %f48, [%rd50+8]
  f48 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (8)))));
  // PTX:140 fma.rn.f32 %f83, %f46, %f45, %f42
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f83) : "f"(f46), "f"(f45), "f"(f42));
  // PTX:141 fma.rn.f32 %f82, %f46, %f47, %f43
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f82) : "f"(f46), "f"(f47), "f"(f43));
  // PTX:142 fma.rn.f32 %f81, %f46, %f48, %f44
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f81) : "f"(f46), "f"(f48), "f"(f44));
  // PTX:144 $L__BB25_6:
L_BB25_6:;
  // PTX:145 cvt.u32.u64 %r28, %rd10
  asm("cvt.u32.u64 %0, %1;" : "=r"(r28) : "l"(rd10));
  // PTX:146 setp.lt.s32 %p4, %r28, 0
  p4 = (((int)(r28)) < ((int)(0)));
  // PTX:147 @%p4 bra $L__BB25_8
  if (p4) { goto L_BB25_8; }
  // PTX:149 shl.b64 %rd51, %rd10, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd51) : "l"(rd10));
  // PTX:150 add.s64 %rd52, %rd2, %rd51
  asm("add.s64 %0, %1, %2;" : "=l"(rd52) : "l"(rd2), "l"(rd51));
  // PTX:151 ld.global.u32 %r29, [%rd52]
  r29 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))));
  // PTX:152 add.s32 %r30, %r29, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r30) : "r"(r29), "r"(r1));
  // PTX:153 ld.global.u32 %r31, [%rd52+4]
  r31 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (4)))));
  // PTX:154 add.s32 %r32, %r31, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r32) : "r"(r31), "r"(r1));
  // PTX:155 ld.global.u32 %r33, [%rd52+8]
  r33 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (8)))));
  // PTX:156 add.s32 %r34, %r33, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r34) : "r"(r33), "r"(r1));
  // PTX:157 ld.global.u32 %r35, [%rd52+12]
  r35 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (12)))));
  // PTX:158 add.s32 %r36, %r35, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r36) : "r"(r35), "r"(r1));
  // PTX:159 cvta.to.global.u64 %rd53, %rd15
  rd53 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd15));
  // PTX:160 shl.b64 %rd54, %rd73, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd54) : "l"(rd73));
  // PTX:161 add.s64 %rd55, %rd53, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd55) : "l"(rd53), "l"(rd54));
  // PTX:162 mul.wide.s32 %rd56, %r30, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd56) : "r"(r30));
  // PTX:163 add.s64 %rd57, %rd1, %rd56
  asm("add.s64 %0, %1, %2;" : "=l"(rd57) : "l"(rd1), "l"(rd56));
  // PTX:164 ld.global.f32 %f49, [%rd57]
  f49 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))));
  // PTX:165 ld.global.f32 %f50, [%rd55]
  f50 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))));
  // PTX:166 ld.global.f32 %f51, [%rd57+4]
  f51 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (4)))));
  // PTX:167 ld.global.f32 %f52, [%rd57+8]
  f52 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (8)))));
  // PTX:168 mul.wide.s32 %rd58, %r32, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd58) : "r"(r32));
  // PTX:169 add.s64 %rd59, %rd1, %rd58
  asm("add.s64 %0, %1, %2;" : "=l"(rd59) : "l"(rd1), "l"(rd58));
  // PTX:170 ld.global.f32 %f53, [%rd59]
  f53 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))));
  // PTX:171 ld.global.f32 %f54, [%rd55+4]
  f54 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (4)))));
  // PTX:172 mul.f32 %f55, %f54, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f55) : "f"(f54), "f"(f53));
  // PTX:173 ld.global.f32 %f56, [%rd59+4]
  f56 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (4)))));
  // PTX:174 mul.f32 %f57, %f54, %f56
  asm("mul.f32 %0, %1, %2;" : "=f"(f57) : "f"(f54), "f"(f56));
  // PTX:175 ld.global.f32 %f58, [%rd59+8]
  f58 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (8)))));
  // PTX:176 mul.f32 %f59, %f54, %f58
  asm("mul.f32 %0, %1, %2;" : "=f"(f59) : "f"(f54), "f"(f58));
  // PTX:177 fma.rn.f32 %f60, %f50, %f49, %f55
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f60) : "f"(f50), "f"(f49), "f"(f55));
  // PTX:178 fma.rn.f32 %f61, %f50, %f51, %f57
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f61) : "f"(f50), "f"(f51), "f"(f57));
  // PTX:179 fma.rn.f32 %f62, %f50, %f52, %f59
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f62) : "f"(f50), "f"(f52), "f"(f59));
  // PTX:180 mul.wide.s32 %rd60, %r34, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd60) : "r"(r34));
  // PTX:181 add.s64 %rd61, %rd1, %rd60
  asm("add.s64 %0, %1, %2;" : "=l"(rd61) : "l"(rd1), "l"(rd60));
  // PTX:182 ld.global.f32 %f63, [%rd61]
  f63 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))));
  // PTX:183 ld.global.f32 %f64, [%rd55+8]
  f64 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (8)))));
  // PTX:184 ld.global.f32 %f65, [%rd61+4]
  f65 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (4)))));
  // PTX:185 ld.global.f32 %f66, [%rd61+8]
  f66 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (8)))));
  // PTX:186 fma.rn.f32 %f67, %f64, %f63, %f60
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f67) : "f"(f64), "f"(f63), "f"(f60));
  // PTX:187 fma.rn.f32 %f68, %f64, %f65, %f61
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f68) : "f"(f64), "f"(f65), "f"(f61));
  // PTX:188 fma.rn.f32 %f69, %f64, %f66, %f62
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f69) : "f"(f64), "f"(f66), "f"(f62));
  // PTX:189 mul.wide.s32 %rd62, %r36, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd62) : "r"(r36));
  // PTX:190 add.s64 %rd63, %rd1, %rd62
  asm("add.s64 %0, %1, %2;" : "=l"(rd63) : "l"(rd1), "l"(rd62));
  // PTX:191 ld.global.f32 %f70, [%rd63]
  f70 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (0)))));
  // PTX:192 ld.global.f32 %f71, [%rd55+12]
  f71 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (12)))));
  // PTX:193 ld.global.f32 %f72, [%rd63+4]
  f72 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (4)))));
  // PTX:194 ld.global.f32 %f73, [%rd63+8]
  f73 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (8)))));
  // PTX:195 fma.rn.f32 %f86, %f71, %f70, %f67
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f86) : "f"(f71), "f"(f70), "f"(f67));
  // PTX:196 fma.rn.f32 %f85, %f71, %f72, %f68
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f85) : "f"(f71), "f"(f72), "f"(f68));
  // PTX:197 fma.rn.f32 %f84, %f71, %f73, %f69
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f84) : "f"(f71), "f"(f73), "f"(f69));
  // PTX:199 $L__BB25_8:
L_BB25_8:;
  // PTX:200 sub.f32 %f19, %f86, %f83
  asm("sub.f32 %0, %1, %2;" : "=f"(f19) : "f"(f86), "f"(f83));
  // PTX:201 sub.f32 %f20, %f85, %f82
  asm("sub.f32 %0, %1, %2;" : "=f"(f20) : "f"(f85), "f"(f82));
  // PTX:202 sub.f32 %f21, %f84, %f81
  asm("sub.f32 %0, %1, %2;" : "=f"(f21) : "f"(f84), "f"(f81));
  // PTX:203 cvta.to.global.u64 %rd64, %rd16
  rd64 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd16));
  // PTX:204 shl.b64 %rd65, %rd73, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd65) : "l"(rd73));
  // PTX:205 add.s64 %rd66, %rd64, %rd65
  asm("add.s64 %0, %1, %2;" : "=l"(rd66) : "l"(rd64), "l"(rd65));
  // PTX:206 ld.global.f32 %f22, [%rd66]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (0)))));
  // PTX:207 setp.le.f32 %p5, %f22, 0f00000000
  p5 = (!(isnan(((float)(f22))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f22)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:208 mov.u32 %r39, 0
  asm("mov.u32 %0, 0;" : "=r"(r39) : );
  // PTX:209 mov.u32 %r41, %r39
  asm("mov.u32 %0, %1;" : "=r"(r41) : "r"(r39));
  // PTX:210 mov.u32 %r42, %r39
  asm("mov.u32 %0, %1;" : "=r"(r42) : "r"(r39));
  // PTX:211 mov.u32 %r43, %r39
  asm("mov.u32 %0, %1;" : "=r"(r43) : "r"(r39));
  // PTX:212 @%p5 bra $L__BB25_12
  if (p5) { goto L_BB25_12; }
  // PTX:214 mul.f32 %f74, %f19, %f19
  asm("mul.f32 %0, %1, %2;" : "=f"(f74) : "f"(f19), "f"(f19));
  // PTX:215 fma.rn.f32 %f75, %f20, %f20, %f74
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f75) : "f"(f20), "f"(f20), "f"(f74));
  // PTX:216 fma.rn.f32 %f76, %f21, %f21, %f75
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f76) : "f"(f21), "f"(f21), "f"(f75));
  // PTX:217 sqrt.rn.f32 %f23, %f76
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f23) : "f"(f76));
  // PTX:218 setp.gt.f32 %p6, %f23, 0f322BCC77
  p6 = (!(isnan(((float)(f23))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f23)) > ((float)(as_f32(0x322BCC77u)))));
  // PTX:219 @%p6 bra $L__BB25_11
  if (p6) { goto L_BB25_11; }
  // PTX:220 bra.uni $L__BB25_10
  goto L_BB25_10;
  // PTX:222 $L__BB25_11:
L_BB25_11:;
  // PTX:223 div.rn.f32 %f77, %f22, %f23
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f77) : "f"(f22), "f"(f23));
  // PTX:224 mul.f32 %f78, %f19, %f77
  asm("mul.f32 %0, %1, %2;" : "=f"(f78) : "f"(f19), "f"(f77));
  // PTX:225 mul.f32 %f79, %f20, %f77
  asm("mul.f32 %0, %1, %2;" : "=f"(f79) : "f"(f20), "f"(f77));
  // PTX:226 mul.f32 %f80, %f21, %f77
  asm("mul.f32 %0, %1, %2;" : "=f"(f80) : "f"(f21), "f"(f77));
  // PTX:227 mov.b32 %r43, %f80
  asm("mov.b32 %0, %1;" : "=r"(r43) : "f"(f80));
  // PTX:228 mov.b32 %r42, %f79
  asm("mov.b32 %0, %1;" : "=r"(r42) : "f"(f79));
  // PTX:229 mov.b32 %r41, %f78
  asm("mov.b32 %0, %1;" : "=r"(r41) : "f"(f78));
  // PTX:230 bra.uni $L__BB25_12
  goto L_BB25_12;
  // PTX:232 $L__BB25_10:
L_BB25_10:;
  // PTX:233 mov.b32 %r41, %f22
  asm("mov.b32 %0, %1;" : "=r"(r41) : "f"(f22));
  // PTX:234 mov.u32 %r42, %r39
  asm("mov.u32 %0, %1;" : "=r"(r42) : "r"(r39));
  // PTX:235 mov.u32 %r43, %r39
  asm("mov.u32 %0, %1;" : "=r"(r43) : "r"(r39));
  // PTX:237 $L__BB25_12:
L_BB25_12:;
  // PTX:238 cvta.to.global.u64 %rd67, %rd17
  rd67 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd17));
  // PTX:239 mul.lo.s64 %rd68, %rd3, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd68) : "l"(rd3));
  // PTX:240 add.s64 %rd69, %rd67, %rd68
  asm("add.s64 %0, %1, %2;" : "=l"(rd69) : "l"(rd67), "l"(rd68));
  // PTX:241 st.global.u32 [%rd69], %r41
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (0))))) = (unsigned)(r41);
  // PTX:242 st.global.u32 [%rd69+4], %r42
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (4))))) = (unsigned)(r42);
  // PTX:243 st.global.u32 [%rd69+8], %r43
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (8))))) = (unsigned)(r43);
  // PTX:244 cvta.to.global.u64 %rd70, %rd18
  rd70 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd18));
  // PTX:245 add.s64 %rd71, %rd70, %rd68
  asm("add.s64 %0, %1, %2;" : "=l"(rd71) : "l"(rd70), "l"(rd68));
  // PTX:246 st.global.u32 [%rd71], %r39
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0))))) = (unsigned)(r39);
  // PTX:247 st.global.u32 [%rd71+4], %r39
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (4))))) = (unsigned)(r39);
  // PTX:248 st.global.u32 [%rd71+8], %r39
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (8))))) = (unsigned)(r39);
  // PTX:250 $L__BB25_13:
L_BB25_13:;
  // PTX:251 ret
  return;
}
