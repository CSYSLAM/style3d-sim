// 机械还原自 PTX：synreal::kernel::initialize_joint_body_point_line_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 3e12b1eef535b8f090cf7958af713cc07426ec1dc420adb10c07229d4297eba4
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__initialize_joint_body_point_line_state(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10, unsigned long long param11, unsigned long long param12, unsigned long long param13, unsigned long long param14) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88;
  // PTX:31 ld.param.u64 %rd25, [_ZN7synreal6kernel38initialize_joint_body_point_line_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEmmmm_param_0]
  rd25 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:32 ld.param.u64 %rd26, [_ZN7synreal6kernel38initialize_joint_body_point_line_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEmmmm_param_1]
  rd26 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:33 ld.param.u64 %rd13, [_ZN7synreal6kernel38initialize_joint_body_point_line_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEmmmm_param_2]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:34 ld.param.u64 %rd14, [_ZN7synreal6kernel38initialize_joint_body_point_line_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEmmmm_param_3]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:35 ld.param.u64 %rd15, [_ZN7synreal6kernel38initialize_joint_body_point_line_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEmmmm_param_4]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:36 ld.param.u64 %rd16, [_ZN7synreal6kernel38initialize_joint_body_point_line_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEmmmm_param_5]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:37 ld.param.u64 %rd17, [_ZN7synreal6kernel38initialize_joint_body_point_line_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEmmmm_param_6]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:38 ld.param.u64 %rd18, [_ZN7synreal6kernel38initialize_joint_body_point_line_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEmmmm_param_7]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:39 ld.param.u64 %rd19, [_ZN7synreal6kernel38initialize_joint_body_point_line_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEmmmm_param_8]
  rd19 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:40 ld.param.u64 %rd20, [_ZN7synreal6kernel38initialize_joint_body_point_line_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEmmmm_param_9]
  rd20 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:41 ld.param.u64 %rd21, [_ZN7synreal6kernel38initialize_joint_body_point_line_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEmmmm_param_10]
  rd21 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:42 ld.param.u64 %rd27, [_ZN7synreal6kernel38initialize_joint_body_point_line_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEmmmm_param_11]
  rd27 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:43 ld.param.u64 %rd22, [_ZN7synreal6kernel38initialize_joint_body_point_line_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEmmmm_param_12]
  rd22 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:44 ld.param.u64 %rd23, [_ZN7synreal6kernel38initialize_joint_body_point_line_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEmmmm_param_13]
  rd23 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:45 ld.param.u64 %rd24, [_ZN7synreal6kernel38initialize_joint_body_point_line_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEmmmm_param_14]
  rd24 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:46 cvta.to.global.u64 %rd1, %rd25
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd25));
  // PTX:47 cvta.to.global.u64 %rd2, %rd26
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd26));
  // PTX:48 mov.u32 %r25, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r25) : "r"(blockIdx.x));
  // PTX:49 mov.u32 %r26, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r26) : "r"(blockDim.x));
  // PTX:50 mul.wide.u32 %rd28, %r25, %r26
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd28) : "r"(r25), "r"(r26));
  // PTX:51 mov.u32 %r27, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r27) : "r"(threadIdx.x));
  // PTX:52 cvt.u64.u32 %rd29, %r27
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd29) : "r"(r27));
  // PTX:53 add.s64 %rd3, %rd28, %rd29
  asm("add.s64 %0, %1, %2;" : "=l"(rd3) : "l"(rd28), "l"(rd29));
  // PTX:54 setp.ge.u64 %p1, %rd3, %rd27
  p1 = (((unsigned long long)(rd3)) >= ((unsigned long long)(rd27)));
  // PTX:55 @%p1 bra $L__BB34_16
  if (p1) { goto L_BB34_16; }
  // PTX:57 or.b64 %rd30, %rd3, %rd23
  asm("or.b64 %0, %1, %2;" : "=l"(rd30) : "l"(rd3), "l"(rd23));
  // PTX:58 and.b64 %rd31, %rd30, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd31) : "l"(rd30));
  // PTX:59 setp.eq.s64 %p2, %rd31, 0
  p2 = (((long long)(rd31)) == ((long long)(0)));
  // PTX:60 @%p2 bra $L__BB34_3
  if (p2) { goto L_BB34_3; }
  // PTX:62 div.u64 %rd87, %rd3, %rd23
  asm("div.u64 %0, %1, %2;" : "=l"(rd87) : "l"(rd3), "l"(rd23));
  // PTX:63 mul.lo.s64 %rd32, %rd87, %rd23
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd32) : "l"(rd87), "l"(rd23));
  // PTX:64 sub.s64 %rd88, %rd3, %rd32
  asm("sub.s64 %0, %1, %2;" : "=l"(rd88) : "l"(rd3), "l"(rd32));
  // PTX:65 bra.uni $L__BB34_4
  goto L_BB34_4;
  // PTX:67 $L__BB34_3:
L_BB34_3:;
  // PTX:68 cvt.u32.u64 %r28, %rd23
  asm("cvt.u32.u64 %0, %1;" : "=r"(r28) : "l"(rd23));
  // PTX:69 cvt.u32.u64 %r29, %rd3
  asm("cvt.u32.u64 %0, %1;" : "=r"(r29) : "l"(rd3));
  // PTX:70 div.u32 %r30, %r29, %r28
  asm("div.u32 %0, %1, %2;" : "=r"(r30) : "r"(r29), "r"(r28));
  // PTX:71 mul.lo.s32 %r31, %r30, %r28
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r31) : "r"(r30), "r"(r28));
  // PTX:72 sub.s32 %r32, %r29, %r31
  asm("sub.s32 %0, %1, %2;" : "=r"(r32) : "r"(r29), "r"(r31));
  // PTX:73 cvt.u64.u32 %rd87, %r30
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd87) : "r"(r30));
  // PTX:74 cvt.u64.u32 %rd88, %r32
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd88) : "r"(r32));
  // PTX:76 $L__BB34_4:
L_BB34_4:;
  // PTX:77 sub.s64 %rd33, %rd22, %rd23
  asm("sub.s64 %0, %1, %2;" : "=l"(rd33) : "l"(rd22), "l"(rd23));
  // PTX:78 add.s64 %rd10, %rd88, %rd33
  asm("add.s64 %0, %1, %2;" : "=l"(rd10) : "l"(rd88), "l"(rd33));
  // PTX:79 mul.lo.s64 %rd34, %rd87, %rd24
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd34) : "l"(rd87), "l"(rd24));
  // PTX:80 cvt.u32.u64 %r1, %rd34
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd34));
  // PTX:81 cvta.to.global.u64 %rd35, %rd13
  rd35 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd13));
  // PTX:82 shl.b64 %rd36, %rd10, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd36) : "l"(rd10));
  // PTX:83 add.s64 %rd37, %rd35, %rd36
  asm("add.s64 %0, %1, %2;" : "=l"(rd37) : "l"(rd35), "l"(rd36));
  // PTX:84 ld.global.s32 %rd11, [%rd37+4]
  rd11 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (4)))));
  // PTX:85 ld.global.u32 %r37, [%rd37]
  r37 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (0)))));
  // PTX:86 mul.wide.s32 %rd38, %r37, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd38) : "r"(r37));
  // PTX:87 add.s64 %rd39, %rd2, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd39) : "l"(rd2), "l"(rd38));
  // PTX:88 ld.global.u32 %r38, [%rd39]
  r38 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (0)))));
  // PTX:89 add.s32 %r39, %r38, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r39) : "r"(r38), "r"(r1));
  // PTX:90 ld.global.u32 %r40, [%rd39+4]
  r40 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (4)))));
  // PTX:91 add.s32 %r41, %r40, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r41) : "r"(r40), "r"(r1));
  // PTX:92 ld.global.u32 %r42, [%rd39+8]
  r42 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (8)))));
  // PTX:93 add.s32 %r43, %r42, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r43) : "r"(r42), "r"(r1));
  // PTX:94 ld.global.u32 %r44, [%rd39+12]
  r44 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (12)))));
  // PTX:95 add.s32 %r45, %r44, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r45) : "r"(r44), "r"(r1));
  // PTX:96 cvta.to.global.u64 %rd40, %rd14
  rd40 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd14));
  // PTX:97 shl.b64 %rd41, %rd10, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd41) : "l"(rd10));
  // PTX:98 add.s64 %rd42, %rd40, %rd41
  asm("add.s64 %0, %1, %2;" : "=l"(rd42) : "l"(rd40), "l"(rd41));
  // PTX:99 mul.wide.s32 %rd43, %r39, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd43) : "r"(r39));
  // PTX:100 add.s64 %rd44, %rd1, %rd43
  asm("add.s64 %0, %1, %2;" : "=l"(rd44) : "l"(rd1), "l"(rd43));
  // PTX:101 ld.global.f32 %f28, [%rd44]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))));
  // PTX:102 ld.global.f32 %f29, [%rd42]
  f29 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (0)))));
  // PTX:103 ld.global.f32 %f30, [%rd44+4]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (4)))));
  // PTX:104 ld.global.f32 %f31, [%rd44+8]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (8)))));
  // PTX:105 mul.wide.s32 %rd45, %r41, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd45) : "r"(r41));
  // PTX:106 add.s64 %rd46, %rd1, %rd45
  asm("add.s64 %0, %1, %2;" : "=l"(rd46) : "l"(rd1), "l"(rd45));
  // PTX:107 ld.global.f32 %f32, [%rd46]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (0)))));
  // PTX:108 ld.global.f32 %f33, [%rd42+4]
  f33 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (4)))));
  // PTX:109 mul.f32 %f34, %f33, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f34) : "f"(f33), "f"(f32));
  // PTX:110 ld.global.f32 %f35, [%rd46+4]
  f35 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (4)))));
  // PTX:111 mul.f32 %f36, %f33, %f35
  asm("mul.f32 %0, %1, %2;" : "=f"(f36) : "f"(f33), "f"(f35));
  // PTX:112 ld.global.f32 %f37, [%rd46+8]
  f37 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (8)))));
  // PTX:113 mul.f32 %f38, %f33, %f37
  asm("mul.f32 %0, %1, %2;" : "=f"(f38) : "f"(f33), "f"(f37));
  // PTX:114 fma.rn.f32 %f39, %f29, %f28, %f34
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f39) : "f"(f29), "f"(f28), "f"(f34));
  // PTX:115 fma.rn.f32 %f40, %f29, %f30, %f36
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f40) : "f"(f29), "f"(f30), "f"(f36));
  // PTX:116 fma.rn.f32 %f41, %f29, %f31, %f38
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f41) : "f"(f29), "f"(f31), "f"(f38));
  // PTX:117 mul.wide.s32 %rd47, %r43, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd47) : "r"(r43));
  // PTX:118 add.s64 %rd48, %rd1, %rd47
  asm("add.s64 %0, %1, %2;" : "=l"(rd48) : "l"(rd1), "l"(rd47));
  // PTX:119 ld.global.f32 %f42, [%rd48]
  f42 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))));
  // PTX:120 ld.global.f32 %f43, [%rd42+8]
  f43 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (8)))));
  // PTX:121 ld.global.f32 %f44, [%rd48+4]
  f44 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (4)))));
  // PTX:122 ld.global.f32 %f45, [%rd48+8]
  f45 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (8)))));
  // PTX:123 fma.rn.f32 %f46, %f43, %f42, %f39
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f46) : "f"(f43), "f"(f42), "f"(f39));
  // PTX:124 fma.rn.f32 %f47, %f43, %f44, %f40
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f47) : "f"(f43), "f"(f44), "f"(f40));
  // PTX:125 fma.rn.f32 %f48, %f43, %f45, %f41
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f48) : "f"(f43), "f"(f45), "f"(f41));
  // PTX:126 mul.wide.s32 %rd49, %r45, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd49) : "r"(r45));
  // PTX:127 add.s64 %rd50, %rd1, %rd49
  asm("add.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd1), "l"(rd49));
  // PTX:128 ld.global.f32 %f49, [%rd50]
  f49 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (0)))));
  // PTX:129 ld.global.f32 %f50, [%rd42+12]
  f50 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (12)))));
  // PTX:130 ld.global.f32 %f51, [%rd50+4]
  f51 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (4)))));
  // PTX:131 ld.global.f32 %f52, [%rd50+8]
  f52 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (8)))));
  // PTX:132 fma.rn.f32 %f1, %f50, %f49, %f46
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1) : "f"(f50), "f"(f49), "f"(f46));
  // PTX:133 fma.rn.f32 %f2, %f50, %f51, %f47
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f2) : "f"(f50), "f"(f51), "f"(f47));
  // PTX:134 fma.rn.f32 %f3, %f50, %f52, %f48
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f3) : "f"(f50), "f"(f52), "f"(f48));
  // PTX:135 setp.lt.s64 %p3, %rd11, 0
  p3 = (((long long)(rd11)) < ((long long)(0)));
  // PTX:136 mov.u32 %r53, 0
  asm("mov.u32 %0, 0;" : "=r"(r53) : );
  // PTX:137 mov.u32 %r54, %r53
  asm("mov.u32 %0, %1;" : "=r"(r54) : "r"(r53));
  // PTX:138 mov.u32 %r55, %r53
  asm("mov.u32 %0, %1;" : "=r"(r55) : "r"(r53));
  // PTX:139 mov.u32 %r56, %r53
  asm("mov.u32 %0, %1;" : "=r"(r56) : "r"(r53));
  // PTX:140 @%p3 bra $L__BB34_6
  if (p3) { goto L_BB34_6; }
  // PTX:142 shl.b64 %rd51, %rd11, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd51) : "l"(rd11));
  // PTX:143 add.s64 %rd52, %rd2, %rd51
  asm("add.s64 %0, %1, %2;" : "=l"(rd52) : "l"(rd2), "l"(rd51));
  // PTX:144 ld.global.u32 %r46, [%rd52]
  r46 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))));
  // PTX:145 ld.global.u32 %r47, [%rd52+4]
  r47 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (4)))));
  // PTX:146 ld.global.u32 %r48, [%rd52+8]
  r48 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (8)))));
  // PTX:147 ld.global.u32 %r49, [%rd52+12]
  r49 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (12)))));
  // PTX:148 add.s32 %r56, %r49, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r56) : "r"(r49), "r"(r1));
  // PTX:149 add.s32 %r55, %r48, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r55) : "r"(r48), "r"(r1));
  // PTX:150 add.s32 %r54, %r47, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r54) : "r"(r47), "r"(r1));
  // PTX:151 add.s32 %r53, %r46, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r53) : "r"(r46), "r"(r1));
  // PTX:153 $L__BB34_6:
L_BB34_6:;
  // PTX:154 cvta.to.global.u64 %rd53, %rd17
  rd53 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd17));
  // PTX:155 mul.lo.s64 %rd54, %rd10, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd54) : "l"(rd10));
  // PTX:156 add.s64 %rd55, %rd53, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd55) : "l"(rd53), "l"(rd54));
  // PTX:157 ld.global.u32 %r10, [%rd55]
  r10 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))));
  // PTX:158 ld.global.u32 %r11, [%rd55+4]
  r11 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (4)))));
  // PTX:159 ld.global.u32 %r12, [%rd55+8]
  r12 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (8)))));
  // PTX:160 cvta.to.global.u64 %rd56, %rd18
  rd56 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd18));
  // PTX:161 add.s64 %rd57, %rd56, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd57) : "l"(rd56), "l"(rd54));
  // PTX:162 ld.global.u32 %r13, [%rd57]
  r13 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))));
  // PTX:163 ld.global.u32 %r14, [%rd57+4]
  r14 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (4)))));
  // PTX:164 ld.global.u32 %r15, [%rd57+8]
  r15 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (8)))));
  // PTX:165 cvta.to.global.u64 %rd58, %rd15
  rd58 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd15));
  // PTX:166 add.s64 %rd60, %rd58, %rd41
  asm("add.s64 %0, %1, %2;" : "=l"(rd60) : "l"(rd58), "l"(rd41));
  // PTX:167 ld.global.u32 %r16, [%rd60]
  r16 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))));
  // PTX:168 ld.global.u32 %r17, [%rd60+4]
  r17 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (4)))));
  // PTX:169 ld.global.u32 %r18, [%rd60+8]
  r18 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (8)))));
  // PTX:170 ld.global.u32 %r19, [%rd60+12]
  r19 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (12)))));
  // PTX:171 cvta.to.global.u64 %rd61, %rd16
  rd61 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd16));
  // PTX:172 add.s64 %rd62, %rd61, %rd41
  asm("add.s64 %0, %1, %2;" : "=l"(rd62) : "l"(rd61), "l"(rd41));
  // PTX:173 ld.global.u32 %r20, [%rd62]
  r20 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))));
  // PTX:174 ld.global.u32 %r21, [%rd62+4]
  r21 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (4)))));
  // PTX:175 ld.global.u32 %r22, [%rd62+8]
  r22 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (8)))));
  // PTX:176 ld.global.u32 %r23, [%rd62+12]
  r23 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (12)))));
  // PTX:177 cvt.u32.u64 %r24, %rd11
  asm("cvt.u32.u64 %0, %1;" : "=r"(r24) : "l"(rd11));
  // PTX:178 setp.lt.s32 %p4, %r24, 0
  p4 = (((int)(r24)) < ((int)(0)));
  // PTX:179 @%p4 bra $L__BB34_8
  if (p4) { goto L_BB34_8; }
  // PTX:181 mov.b32 %f53, %r16
  asm("mov.b32 %0, %1;" : "=f"(f53) : "r"(r16));
  // PTX:182 mov.b32 %f54, %r20
  asm("mov.b32 %0, %1;" : "=f"(f54) : "r"(r20));
  // PTX:183 add.f32 %f55, %f53, %f54
  asm("add.f32 %0, %1, %2;" : "=f"(f55) : "f"(f53), "f"(f54));
  // PTX:184 mov.b32 %f56, %r21
  asm("mov.b32 %0, %1;" : "=f"(f56) : "r"(r21));
  // PTX:185 mov.b32 %f57, %r17
  asm("mov.b32 %0, %1;" : "=f"(f57) : "r"(r17));
  // PTX:186 add.f32 %f58, %f57, %f56
  asm("add.f32 %0, %1, %2;" : "=f"(f58) : "f"(f57), "f"(f56));
  // PTX:187 mov.b32 %f59, %r22
  asm("mov.b32 %0, %1;" : "=f"(f59) : "r"(r22));
  // PTX:188 mov.b32 %f60, %r18
  asm("mov.b32 %0, %1;" : "=f"(f60) : "r"(r18));
  // PTX:189 add.f32 %f61, %f60, %f59
  asm("add.f32 %0, %1, %2;" : "=f"(f61) : "f"(f60), "f"(f59));
  // PTX:190 mov.b32 %f62, %r23
  asm("mov.b32 %0, %1;" : "=f"(f62) : "r"(r23));
  // PTX:191 mov.b32 %f63, %r19
  asm("mov.b32 %0, %1;" : "=f"(f63) : "r"(r19));
  // PTX:192 add.f32 %f64, %f63, %f62
  asm("add.f32 %0, %1, %2;" : "=f"(f64) : "f"(f63), "f"(f62));
  // PTX:193 mul.f32 %f65, %f55, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f65) : "f"(f55));
  // PTX:194 mul.f32 %f66, %f58, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f66) : "f"(f58));
  // PTX:195 mul.f32 %f67, %f61, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f67) : "f"(f61));
  // PTX:196 mul.f32 %f68, %f64, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f68) : "f"(f64));
  // PTX:197 mul.wide.s32 %rd63, %r53, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd63) : "r"(r53));
  // PTX:198 add.s64 %rd64, %rd1, %rd63
  asm("add.s64 %0, %1, %2;" : "=l"(rd64) : "l"(rd1), "l"(rd63));
  // PTX:199 ld.global.f32 %f69, [%rd64]
  f69 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (0)))));
  // PTX:200 ld.global.f32 %f70, [%rd64+4]
  f70 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (4)))));
  // PTX:201 ld.global.f32 %f71, [%rd64+8]
  f71 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (8)))));
  // PTX:202 mul.wide.s32 %rd65, %r54, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd65) : "r"(r54));
  // PTX:203 add.s64 %rd66, %rd1, %rd65
  asm("add.s64 %0, %1, %2;" : "=l"(rd66) : "l"(rd1), "l"(rd65));
  // PTX:204 ld.global.f32 %f72, [%rd66]
  f72 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (0)))));
  // PTX:205 mul.f32 %f73, %f66, %f72
  asm("mul.f32 %0, %1, %2;" : "=f"(f73) : "f"(f66), "f"(f72));
  // PTX:206 ld.global.f32 %f74, [%rd66+4]
  f74 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (4)))));
  // PTX:207 mul.f32 %f75, %f66, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f75) : "f"(f66), "f"(f74));
  // PTX:208 ld.global.f32 %f76, [%rd66+8]
  f76 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (8)))));
  // PTX:209 mul.f32 %f77, %f66, %f76
  asm("mul.f32 %0, %1, %2;" : "=f"(f77) : "f"(f66), "f"(f76));
  // PTX:210 fma.rn.f32 %f78, %f65, %f69, %f73
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f78) : "f"(f65), "f"(f69), "f"(f73));
  // PTX:211 fma.rn.f32 %f79, %f65, %f70, %f75
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f79) : "f"(f65), "f"(f70), "f"(f75));
  // PTX:212 fma.rn.f32 %f80, %f65, %f71, %f77
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f80) : "f"(f65), "f"(f71), "f"(f77));
  // PTX:213 mul.wide.s32 %rd67, %r55, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd67) : "r"(r55));
  // PTX:214 add.s64 %rd68, %rd1, %rd67
  asm("add.s64 %0, %1, %2;" : "=l"(rd68) : "l"(rd1), "l"(rd67));
  // PTX:215 ld.global.f32 %f81, [%rd68]
  f81 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (0)))));
  // PTX:216 ld.global.f32 %f82, [%rd68+4]
  f82 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (4)))));
  // PTX:217 ld.global.f32 %f83, [%rd68+8]
  f83 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (8)))));
  // PTX:218 fma.rn.f32 %f84, %f67, %f81, %f78
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f84) : "f"(f67), "f"(f81), "f"(f78));
  // PTX:219 fma.rn.f32 %f85, %f67, %f82, %f79
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f85) : "f"(f67), "f"(f82), "f"(f79));
  // PTX:220 fma.rn.f32 %f86, %f67, %f83, %f80
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f86) : "f"(f67), "f"(f83), "f"(f80));
  // PTX:221 mul.wide.s32 %rd69, %r56, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd69) : "r"(r56));
  // PTX:222 add.s64 %rd70, %rd1, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd70) : "l"(rd1), "l"(rd69));
  // PTX:223 ld.global.f32 %f87, [%rd70]
  f87 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0)))));
  // PTX:224 ld.global.f32 %f88, [%rd70+4]
  f88 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (4)))));
  // PTX:225 ld.global.f32 %f89, [%rd70+8]
  f89 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (8)))));
  // PTX:226 fma.rn.f32 %f169, %f68, %f87, %f84
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f169) : "f"(f68), "f"(f87), "f"(f84));
  // PTX:227 fma.rn.f32 %f168, %f68, %f88, %f85
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f168) : "f"(f68), "f"(f88), "f"(f85));
  // PTX:228 fma.rn.f32 %f167, %f68, %f89, %f86
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f167) : "f"(f68), "f"(f89), "f"(f86));
  // PTX:229 bra.uni $L__BB34_9
  goto L_BB34_9;
  // PTX:231 $L__BB34_8:
L_BB34_8:;
  // PTX:232 mov.b32 %f90, %r10
  asm("mov.b32 %0, %1;" : "=f"(f90) : "r"(r10));
  // PTX:233 mov.b32 %f91, %r13
  asm("mov.b32 %0, %1;" : "=f"(f91) : "r"(r13));
  // PTX:234 add.f32 %f92, %f90, %f91
  asm("add.f32 %0, %1, %2;" : "=f"(f92) : "f"(f90), "f"(f91));
  // PTX:235 mov.b32 %f93, %r14
  asm("mov.b32 %0, %1;" : "=f"(f93) : "r"(r14));
  // PTX:236 mov.b32 %f94, %r11
  asm("mov.b32 %0, %1;" : "=f"(f94) : "r"(r11));
  // PTX:237 add.f32 %f95, %f94, %f93
  asm("add.f32 %0, %1, %2;" : "=f"(f95) : "f"(f94), "f"(f93));
  // PTX:238 mov.b32 %f96, %r15
  asm("mov.b32 %0, %1;" : "=f"(f96) : "r"(r15));
  // PTX:239 mov.b32 %f97, %r12
  asm("mov.b32 %0, %1;" : "=f"(f97) : "r"(r12));
  // PTX:240 add.f32 %f98, %f97, %f96
  asm("add.f32 %0, %1, %2;" : "=f"(f98) : "f"(f97), "f"(f96));
  // PTX:241 mul.f32 %f169, %f92, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f169) : "f"(f92));
  // PTX:242 mul.f32 %f168, %f95, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f168) : "f"(f95));
  // PTX:243 mul.f32 %f167, %f98, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f167) : "f"(f98));
  // PTX:245 $L__BB34_9:
L_BB34_9:;
  // PTX:246 @%p4 bra $L__BB34_11
  if (p4) { goto L_BB34_11; }
  // PTX:248 mov.b32 %f99, %r20
  asm("mov.b32 %0, %1;" : "=f"(f99) : "r"(r20));
  // PTX:249 mov.b32 %f100, %r16
  asm("mov.b32 %0, %1;" : "=f"(f100) : "r"(r16));
  // PTX:250 sub.f32 %f101, %f99, %f100
  asm("sub.f32 %0, %1, %2;" : "=f"(f101) : "f"(f99), "f"(f100));
  // PTX:251 mov.b32 %f102, %r17
  asm("mov.b32 %0, %1;" : "=f"(f102) : "r"(r17));
  // PTX:252 mov.b32 %f103, %r21
  asm("mov.b32 %0, %1;" : "=f"(f103) : "r"(r21));
  // PTX:253 sub.f32 %f104, %f103, %f102
  asm("sub.f32 %0, %1, %2;" : "=f"(f104) : "f"(f103), "f"(f102));
  // PTX:254 mov.b32 %f105, %r18
  asm("mov.b32 %0, %1;" : "=f"(f105) : "r"(r18));
  // PTX:255 mov.b32 %f106, %r22
  asm("mov.b32 %0, %1;" : "=f"(f106) : "r"(r22));
  // PTX:256 sub.f32 %f107, %f106, %f105
  asm("sub.f32 %0, %1, %2;" : "=f"(f107) : "f"(f106), "f"(f105));
  // PTX:257 mov.b32 %f108, %r19
  asm("mov.b32 %0, %1;" : "=f"(f108) : "r"(r19));
  // PTX:258 mov.b32 %f109, %r23
  asm("mov.b32 %0, %1;" : "=f"(f109) : "r"(r23));
  // PTX:259 sub.f32 %f110, %f109, %f108
  asm("sub.f32 %0, %1, %2;" : "=f"(f110) : "f"(f109), "f"(f108));
  // PTX:260 mul.wide.s32 %rd71, %r53, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd71) : "r"(r53));
  // PTX:261 add.s64 %rd72, %rd1, %rd71
  asm("add.s64 %0, %1, %2;" : "=l"(rd72) : "l"(rd1), "l"(rd71));
  // PTX:262 ld.global.f32 %f111, [%rd72]
  f111 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (0)))));
  // PTX:263 ld.global.f32 %f112, [%rd72+4]
  f112 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (4)))));
  // PTX:264 ld.global.f32 %f113, [%rd72+8]
  f113 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (8)))));
  // PTX:265 mul.wide.s32 %rd73, %r54, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd73) : "r"(r54));
  // PTX:266 add.s64 %rd74, %rd1, %rd73
  asm("add.s64 %0, %1, %2;" : "=l"(rd74) : "l"(rd1), "l"(rd73));
  // PTX:267 ld.global.f32 %f114, [%rd74]
  f114 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (0)))));
  // PTX:268 mul.f32 %f115, %f104, %f114
  asm("mul.f32 %0, %1, %2;" : "=f"(f115) : "f"(f104), "f"(f114));
  // PTX:269 ld.global.f32 %f116, [%rd74+4]
  f116 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (4)))));
  // PTX:270 mul.f32 %f117, %f104, %f116
  asm("mul.f32 %0, %1, %2;" : "=f"(f117) : "f"(f104), "f"(f116));
  // PTX:271 ld.global.f32 %f118, [%rd74+8]
  f118 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (8)))));
  // PTX:272 mul.f32 %f119, %f104, %f118
  asm("mul.f32 %0, %1, %2;" : "=f"(f119) : "f"(f104), "f"(f118));
  // PTX:273 fma.rn.f32 %f120, %f101, %f111, %f115
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f120) : "f"(f101), "f"(f111), "f"(f115));
  // PTX:274 fma.rn.f32 %f121, %f101, %f112, %f117
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f121) : "f"(f101), "f"(f112), "f"(f117));
  // PTX:275 fma.rn.f32 %f122, %f101, %f113, %f119
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f122) : "f"(f101), "f"(f113), "f"(f119));
  // PTX:276 mul.wide.s32 %rd75, %r55, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd75) : "r"(r55));
  // PTX:277 add.s64 %rd76, %rd1, %rd75
  asm("add.s64 %0, %1, %2;" : "=l"(rd76) : "l"(rd1), "l"(rd75));
  // PTX:278 ld.global.f32 %f123, [%rd76]
  f123 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (0)))));
  // PTX:279 ld.global.f32 %f124, [%rd76+4]
  f124 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (4)))));
  // PTX:280 ld.global.f32 %f125, [%rd76+8]
  f125 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (8)))));
  // PTX:281 fma.rn.f32 %f126, %f107, %f123, %f120
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f126) : "f"(f107), "f"(f123), "f"(f120));
  // PTX:282 fma.rn.f32 %f127, %f107, %f124, %f121
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f127) : "f"(f107), "f"(f124), "f"(f121));
  // PTX:283 fma.rn.f32 %f128, %f107, %f125, %f122
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f128) : "f"(f107), "f"(f125), "f"(f122));
  // PTX:284 mul.wide.s32 %rd77, %r56, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd77) : "r"(r56));
  // PTX:285 add.s64 %rd78, %rd1, %rd77
  asm("add.s64 %0, %1, %2;" : "=l"(rd78) : "l"(rd1), "l"(rd77));
  // PTX:286 ld.global.f32 %f129, [%rd78]
  f129 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd78) + (0)))));
  // PTX:287 ld.global.f32 %f130, [%rd78+4]
  f130 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd78) + (4)))));
  // PTX:288 ld.global.f32 %f131, [%rd78+8]
  f131 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd78) + (8)))));
  // PTX:289 fma.rn.f32 %f172, %f110, %f129, %f126
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f172) : "f"(f110), "f"(f129), "f"(f126));
  // PTX:290 fma.rn.f32 %f171, %f110, %f130, %f127
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f171) : "f"(f110), "f"(f130), "f"(f127));
  // PTX:291 fma.rn.f32 %f170, %f110, %f131, %f128
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f170) : "f"(f110), "f"(f131), "f"(f128));
  // PTX:292 bra.uni $L__BB34_12
  goto L_BB34_12;
  // PTX:294 $L__BB34_11:
L_BB34_11:;
  // PTX:295 mov.b32 %f132, %r13
  asm("mov.b32 %0, %1;" : "=f"(f132) : "r"(r13));
  // PTX:296 mov.b32 %f133, %r10
  asm("mov.b32 %0, %1;" : "=f"(f133) : "r"(r10));
  // PTX:297 sub.f32 %f172, %f132, %f133
  asm("sub.f32 %0, %1, %2;" : "=f"(f172) : "f"(f132), "f"(f133));
  // PTX:298 mov.b32 %f134, %r11
  asm("mov.b32 %0, %1;" : "=f"(f134) : "r"(r11));
  // PTX:299 mov.b32 %f135, %r14
  asm("mov.b32 %0, %1;" : "=f"(f135) : "r"(r14));
  // PTX:300 sub.f32 %f171, %f135, %f134
  asm("sub.f32 %0, %1, %2;" : "=f"(f171) : "f"(f135), "f"(f134));
  // PTX:301 mov.b32 %f136, %r12
  asm("mov.b32 %0, %1;" : "=f"(f136) : "r"(r12));
  // PTX:302 mov.b32 %f137, %r15
  asm("mov.b32 %0, %1;" : "=f"(f137) : "r"(r15));
  // PTX:303 sub.f32 %f170, %f137, %f136
  asm("sub.f32 %0, %1, %2;" : "=f"(f170) : "f"(f137), "f"(f136));
  // PTX:305 $L__BB34_12:
L_BB34_12:;
  // PTX:306 mul.f32 %f22, %f171, %f171
  asm("mul.f32 %0, %1, %2;" : "=f"(f22) : "f"(f171), "f"(f171));
  // PTX:307 mul.f32 %f23, %f172, %f172
  asm("mul.f32 %0, %1, %2;" : "=f"(f23) : "f"(f172), "f"(f172));
  // PTX:308 add.f32 %f139, %f22, %f23
  asm("add.f32 %0, %1, %2;" : "=f"(f139) : "f"(f22), "f"(f23));
  // PTX:309 mul.f32 %f24, %f170, %f170
  asm("mul.f32 %0, %1, %2;" : "=f"(f24) : "f"(f170), "f"(f170));
  // PTX:310 add.f32 %f25, %f24, %f139
  asm("add.f32 %0, %1, %2;" : "=f"(f25) : "f"(f24), "f"(f139));
  // PTX:311 cvta.to.global.u64 %rd79, %rd21
  rd79 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd21));
  // PTX:312 mul.lo.s64 %rd80, %rd3, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd80) : "l"(rd3));
  // PTX:313 add.s64 %rd12, %rd79, %rd80
  asm("add.s64 %0, %1, %2;" : "=l"(rd12) : "l"(rd79), "l"(rd80));
  // PTX:314 mov.u32 %r50, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r50) : );
  // PTX:315 st.global.u32 [%rd12], %r50
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (0))))) = (unsigned)(r50);
  // PTX:316 mov.u32 %r51, 0
  asm("mov.u32 %0, 0;" : "=r"(r51) : );
  // PTX:317 st.global.u32 [%rd12+4], %r51
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (4))))) = (unsigned)(r51);
  // PTX:318 st.global.u32 [%rd12+8], %r51
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (8))))) = (unsigned)(r51);
  // PTX:319 st.global.u32 [%rd12+12], %r51
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (12))))) = (unsigned)(r51);
  // PTX:320 st.global.u32 [%rd12+16], %r50
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (16))))) = (unsigned)(r50);
  // PTX:321 st.global.u32 [%rd12+20], %r51
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (20))))) = (unsigned)(r51);
  // PTX:322 st.global.u32 [%rd12+24], %r51
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (24))))) = (unsigned)(r51);
  // PTX:323 st.global.u32 [%rd12+28], %r51
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (28))))) = (unsigned)(r51);
  // PTX:324 st.global.u32 [%rd12+32], %r50
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (32))))) = (unsigned)(r50);
  // PTX:325 setp.le.f32 %p6, %f25, 0f2B8CBCCC
  p6 = (!(isnan(((float)(f25))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) && (((float)(f25)) <= ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:326 mov.f32 %f173, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f173) : );
  // PTX:327 @%p6 bra $L__BB34_15
  if (p6) { goto L_BB34_15; }
  // PTX:329 sub.f32 %f140, %f1, %f169
  asm("sub.f32 %0, %1, %2;" : "=f"(f140) : "f"(f1), "f"(f169));
  // PTX:330 mul.f32 %f141, %f140, %f172
  asm("mul.f32 %0, %1, %2;" : "=f"(f141) : "f"(f140), "f"(f172));
  // PTX:331 sub.f32 %f142, %f2, %f168
  asm("sub.f32 %0, %1, %2;" : "=f"(f142) : "f"(f2), "f"(f168));
  // PTX:332 sub.f32 %f143, %f3, %f167
  asm("sub.f32 %0, %1, %2;" : "=f"(f143) : "f"(f3), "f"(f167));
  // PTX:333 fma.rn.f32 %f144, %f142, %f171, %f141
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f144) : "f"(f142), "f"(f171), "f"(f141));
  // PTX:334 fma.rn.f32 %f145, %f143, %f170, %f144
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f145) : "f"(f143), "f"(f170), "f"(f144));
  // PTX:335 div.rn.f32 %f146, %f145, %f25
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f146) : "f"(f145), "f"(f25));
  // PTX:336 mov.f32 %f147, 0fBF000000
  asm("mov.f32 %0, 0fBF000000;" : "=f"(f147) : );
  // PTX:337 max.f32 %f148, %f147, %f146
  asm("max.f32 %0, %1, %2;" : "=f"(f148) : "f"(f147), "f"(f146));
  // PTX:338 mov.f32 %f149, 0f3F000000
  asm("mov.f32 %0, 0f3F000000;" : "=f"(f149) : );
  // PTX:339 min.f32 %f173, %f149, %f148
  asm("min.f32 %0, %1, %2;" : "=f"(f173) : "f"(f149), "f"(f148));
  // PTX:340 setp.leu.f32 %p7, %f146, 0fBF000000
  p7 = ((isnan(((float)(f146))) || isnan(((float)(as_f32(0xBF000000u))))) || (((float)(f146)) <= ((float)(as_f32(0xBF000000u)))));
  // PTX:341 setp.geu.f32 %p8, %f146, 0f3F000000
  p8 = ((isnan(((float)(f146))) || isnan(((float)(as_f32(0x3F000000u))))) || (((float)(f146)) >= ((float)(as_f32(0x3F000000u)))));
  // PTX:342 or.pred %p9, %p7, %p8
  p9 = ((p7) || (p8));
  // PTX:343 @%p9 bra $L__BB34_15
  if (p9) { goto L_BB34_15; }
  // PTX:345 mul.f32 %f150, %f171, %f172
  asm("mul.f32 %0, %1, %2;" : "=f"(f150) : "f"(f171), "f"(f172));
  // PTX:346 div.rn.f32 %f151, %f150, %f25
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f151) : "f"(f150), "f"(f25));
  // PTX:347 mul.f32 %f152, %f170, %f172
  asm("mul.f32 %0, %1, %2;" : "=f"(f152) : "f"(f170), "f"(f172));
  // PTX:348 div.rn.f32 %f153, %f152, %f25
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f153) : "f"(f152), "f"(f25));
  // PTX:349 mul.f32 %f154, %f170, %f171
  asm("mul.f32 %0, %1, %2;" : "=f"(f154) : "f"(f170), "f"(f171));
  // PTX:350 div.rn.f32 %f155, %f154, %f25
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f155) : "f"(f154), "f"(f25));
  // PTX:351 div.rn.f32 %f156, %f23, %f25
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f156) : "f"(f23), "f"(f25));
  // PTX:352 mov.f32 %f157, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f157) : );
  // PTX:353 sub.f32 %f158, %f157, %f156
  asm("sub.f32 %0, %1, %2;" : "=f"(f158) : "f"(f157), "f"(f156));
  // PTX:354 st.global.f32 [%rd12], %f158
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (0))))) = (float)(f158);
  // PTX:355 mov.f32 %f159, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f159) : );
  // PTX:356 sub.f32 %f160, %f159, %f151
  asm("sub.f32 %0, %1, %2;" : "=f"(f160) : "f"(f159), "f"(f151));
  // PTX:357 st.global.f32 [%rd12+4], %f160
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (4))))) = (float)(f160);
  // PTX:358 sub.f32 %f161, %f159, %f153
  asm("sub.f32 %0, %1, %2;" : "=f"(f161) : "f"(f159), "f"(f153));
  // PTX:359 st.global.f32 [%rd12+8], %f161
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (8))))) = (float)(f161);
  // PTX:360 st.global.f32 [%rd12+12], %f160
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (12))))) = (float)(f160);
  // PTX:361 div.rn.f32 %f162, %f22, %f25
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f162) : "f"(f22), "f"(f25));
  // PTX:362 sub.f32 %f163, %f157, %f162
  asm("sub.f32 %0, %1, %2;" : "=f"(f163) : "f"(f157), "f"(f162));
  // PTX:363 st.global.f32 [%rd12+16], %f163
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (16))))) = (float)(f163);
  // PTX:364 sub.f32 %f164, %f159, %f155
  asm("sub.f32 %0, %1, %2;" : "=f"(f164) : "f"(f159), "f"(f155));
  // PTX:365 st.global.f32 [%rd12+20], %f164
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (20))))) = (float)(f164);
  // PTX:366 st.global.f32 [%rd12+24], %f161
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (24))))) = (float)(f161);
  // PTX:367 st.global.f32 [%rd12+28], %f164
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (28))))) = (float)(f164);
  // PTX:368 div.rn.f32 %f165, %f24, %f25
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f165) : "f"(f24), "f"(f25));
  // PTX:369 sub.f32 %f166, %f157, %f165
  asm("sub.f32 %0, %1, %2;" : "=f"(f166) : "f"(f157), "f"(f165));
  // PTX:370 st.global.f32 [%rd12+32], %f166
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (32))))) = (float)(f166);
  // PTX:372 $L__BB34_15:
L_BB34_15:;
  // PTX:373 cvta.to.global.u64 %rd81, %rd19
  rd81 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd19));
  // PTX:374 shl.b64 %rd82, %rd3, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd82) : "l"(rd3));
  // PTX:375 add.s64 %rd83, %rd81, %rd82
  asm("add.s64 %0, %1, %2;" : "=l"(rd83) : "l"(rd81), "l"(rd82));
  // PTX:376 st.global.f32 [%rd83], %f173
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (0))))) = (float)(f173);
  // PTX:377 cvta.to.global.u64 %rd84, %rd20
  rd84 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd20));
  // PTX:378 mul.lo.s64 %rd85, %rd3, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd85) : "l"(rd3));
  // PTX:379 add.s64 %rd86, %rd84, %rd85
  asm("add.s64 %0, %1, %2;" : "=l"(rd86) : "l"(rd84), "l"(rd85));
  // PTX:380 st.global.u32 [%rd86], %r51
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd86) + (0))))) = (unsigned)(r51);
  // PTX:381 st.global.u32 [%rd86+4], %r51
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd86) + (4))))) = (unsigned)(r51);
  // PTX:382 st.global.u32 [%rd86+8], %r51
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd86) + (8))))) = (unsigned)(r51);
  // PTX:384 $L__BB34_16:
L_BB34_16:;
  // PTX:385 ret
  return;
}
