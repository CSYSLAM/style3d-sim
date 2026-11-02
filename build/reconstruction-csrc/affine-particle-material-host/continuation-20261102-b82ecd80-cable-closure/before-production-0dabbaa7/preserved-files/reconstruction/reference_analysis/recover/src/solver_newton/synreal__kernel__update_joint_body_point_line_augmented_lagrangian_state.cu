// 机械还原自 PTX：synreal::kernel::update_joint_body_point_line_augmented_lagrangian_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, bool, unsigned long, unsigned long, unsigned long, unsigned long)
// PTX SHA256: d2ed07b86377cf90e7723e9af40074b6ffb98bde1ec6114b391bbf87d82d147a
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__update_joint_body_point_line_augmented_lagrangian_state(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10, unsigned char param11, unsigned long long param12, unsigned long long param13, unsigned long long param14, unsigned long long param15) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14;
  unsigned short rs0, rs1;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88;
  // PTX:33 ld.param.s8 %rs1, [_ZN7synreal6kernel55update_joint_body_point_line_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEbmmmm_param_11]
  rs1 = (*reinterpret_cast<volatile signed char*>(((uintptr_t)&param11 + (0))));
  // PTX:34 ld.param.u64 %rd27, [_ZN7synreal6kernel55update_joint_body_point_line_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEbmmmm_param_0]
  rd27 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:35 ld.param.u64 %rd28, [_ZN7synreal6kernel55update_joint_body_point_line_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEbmmmm_param_1]
  rd28 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:36 ld.param.u64 %rd15, [_ZN7synreal6kernel55update_joint_body_point_line_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEbmmmm_param_2]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:37 ld.param.u64 %rd16, [_ZN7synreal6kernel55update_joint_body_point_line_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEbmmmm_param_3]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:38 ld.param.u64 %rd17, [_ZN7synreal6kernel55update_joint_body_point_line_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEbmmmm_param_4]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:39 ld.param.u64 %rd18, [_ZN7synreal6kernel55update_joint_body_point_line_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEbmmmm_param_5]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:40 ld.param.u64 %rd19, [_ZN7synreal6kernel55update_joint_body_point_line_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEbmmmm_param_6]
  rd19 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:41 ld.param.u64 %rd20, [_ZN7synreal6kernel55update_joint_body_point_line_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEbmmmm_param_7]
  rd20 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:42 ld.param.u64 %rd21, [_ZN7synreal6kernel55update_joint_body_point_line_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEbmmmm_param_8]
  rd21 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:43 ld.param.u64 %rd22, [_ZN7synreal6kernel55update_joint_body_point_line_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEbmmmm_param_9]
  rd22 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:44 ld.param.u64 %rd23, [_ZN7synreal6kernel55update_joint_body_point_line_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEbmmmm_param_10]
  rd23 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:45 ld.param.u64 %rd29, [_ZN7synreal6kernel55update_joint_body_point_line_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEbmmmm_param_12]
  rd29 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:46 ld.param.u64 %rd24, [_ZN7synreal6kernel55update_joint_body_point_line_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEbmmmm_param_13]
  rd24 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:47 ld.param.u64 %rd25, [_ZN7synreal6kernel55update_joint_body_point_line_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEbmmmm_param_14]
  rd25 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:48 ld.param.u64 %rd26, [_ZN7synreal6kernel55update_joint_body_point_line_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PfPS4_PNS1_3matILi3ELi3EfLS3_0EEEbmmmm_param_15]
  rd26 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param15 + (0))));
  // PTX:49 cvta.to.global.u64 %rd1, %rd27
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd27));
  // PTX:50 cvta.to.global.u64 %rd2, %rd28
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd28));
  // PTX:51 mov.u32 %r25, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r25) : "r"(blockIdx.x));
  // PTX:52 mov.u32 %r26, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r26) : "r"(blockDim.x));
  // PTX:53 mul.wide.u32 %rd30, %r25, %r26
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd30) : "r"(r25), "r"(r26));
  // PTX:54 mov.u32 %r27, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r27) : "r"(threadIdx.x));
  // PTX:55 cvt.u64.u32 %rd31, %r27
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd31) : "r"(r27));
  // PTX:56 add.s64 %rd3, %rd30, %rd31
  asm("add.s64 %0, %1, %2;" : "=l"(rd3) : "l"(rd30), "l"(rd31));
  // PTX:57 setp.ge.u64 %p1, %rd3, %rd29
  p1 = (((unsigned long long)(rd3)) >= ((unsigned long long)(rd29)));
  // PTX:58 @%p1 bra $L__BB36_20
  if (p1) { goto L_BB36_20; }
  // PTX:60 or.b64 %rd32, %rd3, %rd25
  asm("or.b64 %0, %1, %2;" : "=l"(rd32) : "l"(rd3), "l"(rd25));
  // PTX:61 and.b64 %rd33, %rd32, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd33) : "l"(rd32));
  // PTX:62 setp.eq.s64 %p2, %rd33, 0
  p2 = (((long long)(rd33)) == ((long long)(0)));
  // PTX:63 @%p2 bra $L__BB36_3
  if (p2) { goto L_BB36_3; }
  // PTX:65 div.u64 %rd87, %rd3, %rd25
  asm("div.u64 %0, %1, %2;" : "=l"(rd87) : "l"(rd3), "l"(rd25));
  // PTX:66 mul.lo.s64 %rd34, %rd87, %rd25
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd34) : "l"(rd87), "l"(rd25));
  // PTX:67 sub.s64 %rd88, %rd3, %rd34
  asm("sub.s64 %0, %1, %2;" : "=l"(rd88) : "l"(rd3), "l"(rd34));
  // PTX:68 bra.uni $L__BB36_4
  goto L_BB36_4;
  // PTX:70 $L__BB36_3:
L_BB36_3:;
  // PTX:71 cvt.u32.u64 %r28, %rd25
  asm("cvt.u32.u64 %0, %1;" : "=r"(r28) : "l"(rd25));
  // PTX:72 cvt.u32.u64 %r29, %rd3
  asm("cvt.u32.u64 %0, %1;" : "=r"(r29) : "l"(rd3));
  // PTX:73 div.u32 %r30, %r29, %r28
  asm("div.u32 %0, %1, %2;" : "=r"(r30) : "r"(r29), "r"(r28));
  // PTX:74 mul.lo.s32 %r31, %r30, %r28
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r31) : "r"(r30), "r"(r28));
  // PTX:75 sub.s32 %r32, %r29, %r31
  asm("sub.s32 %0, %1, %2;" : "=r"(r32) : "r"(r29), "r"(r31));
  // PTX:76 cvt.u64.u32 %rd87, %r30
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd87) : "r"(r30));
  // PTX:77 cvt.u64.u32 %rd88, %r32
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd88) : "r"(r32));
  // PTX:79 $L__BB36_4:
L_BB36_4:;
  // PTX:80 sub.s64 %rd35, %rd24, %rd25
  asm("sub.s64 %0, %1, %2;" : "=l"(rd35) : "l"(rd24), "l"(rd25));
  // PTX:81 add.s64 %rd10, %rd88, %rd35
  asm("add.s64 %0, %1, %2;" : "=l"(rd10) : "l"(rd88), "l"(rd35));
  // PTX:82 mul.lo.s64 %rd36, %rd87, %rd26
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd36) : "l"(rd87), "l"(rd26));
  // PTX:83 cvt.u32.u64 %r1, %rd36
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd36));
  // PTX:84 cvta.to.global.u64 %rd37, %rd15
  rd37 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd15));
  // PTX:85 shl.b64 %rd38, %rd10, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd38) : "l"(rd10));
  // PTX:86 add.s64 %rd39, %rd37, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd39) : "l"(rd37), "l"(rd38));
  // PTX:87 ld.global.s32 %rd11, [%rd39+4]
  rd11 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (4)))));
  // PTX:88 ld.global.u32 %r37, [%rd39]
  r37 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (0)))));
  // PTX:89 mul.wide.s32 %rd40, %r37, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd40) : "r"(r37));
  // PTX:90 add.s64 %rd41, %rd2, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd41) : "l"(rd2), "l"(rd40));
  // PTX:91 ld.global.u32 %r38, [%rd41]
  r38 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (0)))));
  // PTX:92 add.s32 %r39, %r38, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r39) : "r"(r38), "r"(r1));
  // PTX:93 ld.global.u32 %r40, [%rd41+4]
  r40 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (4)))));
  // PTX:94 add.s32 %r41, %r40, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r41) : "r"(r40), "r"(r1));
  // PTX:95 ld.global.u32 %r42, [%rd41+8]
  r42 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (8)))));
  // PTX:96 add.s32 %r43, %r42, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r43) : "r"(r42), "r"(r1));
  // PTX:97 ld.global.u32 %r44, [%rd41+12]
  r44 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (12)))));
  // PTX:98 add.s32 %r45, %r44, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r45) : "r"(r44), "r"(r1));
  // PTX:99 cvta.to.global.u64 %rd42, %rd16
  rd42 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd16));
  // PTX:100 shl.b64 %rd43, %rd10, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd43) : "l"(rd10));
  // PTX:101 add.s64 %rd44, %rd42, %rd43
  asm("add.s64 %0, %1, %2;" : "=l"(rd44) : "l"(rd42), "l"(rd43));
  // PTX:102 mul.wide.s32 %rd45, %r39, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd45) : "r"(r39));
  // PTX:103 add.s64 %rd46, %rd1, %rd45
  asm("add.s64 %0, %1, %2;" : "=l"(rd46) : "l"(rd1), "l"(rd45));
  // PTX:104 ld.global.f32 %f39, [%rd46]
  f39 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (0)))));
  // PTX:105 ld.global.f32 %f40, [%rd44]
  f40 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))));
  // PTX:106 ld.global.f32 %f41, [%rd46+4]
  f41 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (4)))));
  // PTX:107 ld.global.f32 %f42, [%rd46+8]
  f42 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (8)))));
  // PTX:108 mul.wide.s32 %rd47, %r41, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd47) : "r"(r41));
  // PTX:109 add.s64 %rd48, %rd1, %rd47
  asm("add.s64 %0, %1, %2;" : "=l"(rd48) : "l"(rd1), "l"(rd47));
  // PTX:110 ld.global.f32 %f43, [%rd48]
  f43 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))));
  // PTX:111 ld.global.f32 %f44, [%rd44+4]
  f44 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (4)))));
  // PTX:112 mul.f32 %f45, %f44, %f43
  asm("mul.f32 %0, %1, %2;" : "=f"(f45) : "f"(f44), "f"(f43));
  // PTX:113 ld.global.f32 %f46, [%rd48+4]
  f46 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (4)))));
  // PTX:114 mul.f32 %f47, %f44, %f46
  asm("mul.f32 %0, %1, %2;" : "=f"(f47) : "f"(f44), "f"(f46));
  // PTX:115 ld.global.f32 %f48, [%rd48+8]
  f48 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (8)))));
  // PTX:116 mul.f32 %f49, %f44, %f48
  asm("mul.f32 %0, %1, %2;" : "=f"(f49) : "f"(f44), "f"(f48));
  // PTX:117 fma.rn.f32 %f50, %f40, %f39, %f45
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f50) : "f"(f40), "f"(f39), "f"(f45));
  // PTX:118 fma.rn.f32 %f51, %f40, %f41, %f47
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f51) : "f"(f40), "f"(f41), "f"(f47));
  // PTX:119 fma.rn.f32 %f52, %f40, %f42, %f49
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f52) : "f"(f40), "f"(f42), "f"(f49));
  // PTX:120 mul.wide.s32 %rd49, %r43, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd49) : "r"(r43));
  // PTX:121 add.s64 %rd50, %rd1, %rd49
  asm("add.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd1), "l"(rd49));
  // PTX:122 ld.global.f32 %f53, [%rd50]
  f53 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (0)))));
  // PTX:123 ld.global.f32 %f54, [%rd44+8]
  f54 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (8)))));
  // PTX:124 ld.global.f32 %f55, [%rd50+4]
  f55 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (4)))));
  // PTX:125 ld.global.f32 %f56, [%rd50+8]
  f56 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (8)))));
  // PTX:126 fma.rn.f32 %f57, %f54, %f53, %f50
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f57) : "f"(f54), "f"(f53), "f"(f50));
  // PTX:127 fma.rn.f32 %f58, %f54, %f55, %f51
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f58) : "f"(f54), "f"(f55), "f"(f51));
  // PTX:128 fma.rn.f32 %f59, %f54, %f56, %f52
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f59) : "f"(f54), "f"(f56), "f"(f52));
  // PTX:129 mul.wide.s32 %rd51, %r45, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd51) : "r"(r45));
  // PTX:130 add.s64 %rd52, %rd1, %rd51
  asm("add.s64 %0, %1, %2;" : "=l"(rd52) : "l"(rd1), "l"(rd51));
  // PTX:131 ld.global.f32 %f60, [%rd52]
  f60 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))));
  // PTX:132 ld.global.f32 %f61, [%rd44+12]
  f61 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (12)))));
  // PTX:133 ld.global.f32 %f62, [%rd52+4]
  f62 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (4)))));
  // PTX:134 ld.global.f32 %f63, [%rd52+8]
  f63 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (8)))));
  // PTX:135 fma.rn.f32 %f1, %f61, %f60, %f57
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1) : "f"(f61), "f"(f60), "f"(f57));
  // PTX:136 fma.rn.f32 %f2, %f61, %f62, %f58
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f2) : "f"(f61), "f"(f62), "f"(f58));
  // PTX:137 fma.rn.f32 %f3, %f61, %f63, %f59
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f3) : "f"(f61), "f"(f63), "f"(f59));
  // PTX:138 setp.lt.s64 %p3, %rd11, 0
  p3 = (((long long)(rd11)) < ((long long)(0)));
  // PTX:139 mov.u32 %r54, 0
  asm("mov.u32 %0, 0;" : "=r"(r54) : );
  // PTX:140 mov.u32 %r55, %r54
  asm("mov.u32 %0, %1;" : "=r"(r55) : "r"(r54));
  // PTX:141 mov.u32 %r56, %r54
  asm("mov.u32 %0, %1;" : "=r"(r56) : "r"(r54));
  // PTX:142 mov.u32 %r57, %r54
  asm("mov.u32 %0, %1;" : "=r"(r57) : "r"(r54));
  // PTX:143 @%p3 bra $L__BB36_6
  if (p3) { goto L_BB36_6; }
  // PTX:145 shl.b64 %rd53, %rd11, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd53) : "l"(rd11));
  // PTX:146 add.s64 %rd54, %rd2, %rd53
  asm("add.s64 %0, %1, %2;" : "=l"(rd54) : "l"(rd2), "l"(rd53));
  // PTX:147 ld.global.u32 %r46, [%rd54]
  r46 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))));
  // PTX:148 ld.global.u32 %r47, [%rd54+4]
  r47 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (4)))));
  // PTX:149 ld.global.u32 %r48, [%rd54+8]
  r48 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (8)))));
  // PTX:150 ld.global.u32 %r49, [%rd54+12]
  r49 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (12)))));
  // PTX:151 add.s32 %r57, %r49, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r57) : "r"(r49), "r"(r1));
  // PTX:152 add.s32 %r56, %r48, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r56) : "r"(r48), "r"(r1));
  // PTX:153 add.s32 %r55, %r47, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r55) : "r"(r47), "r"(r1));
  // PTX:154 add.s32 %r54, %r46, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r54) : "r"(r46), "r"(r1));
  // PTX:156 $L__BB36_6:
L_BB36_6:;
  // PTX:157 cvta.to.global.u64 %rd55, %rd19
  rd55 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd19));
  // PTX:158 mul.lo.s64 %rd56, %rd10, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd56) : "l"(rd10));
  // PTX:159 add.s64 %rd57, %rd55, %rd56
  asm("add.s64 %0, %1, %2;" : "=l"(rd57) : "l"(rd55), "l"(rd56));
  // PTX:160 ld.global.u32 %r10, [%rd57]
  r10 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))));
  // PTX:161 ld.global.u32 %r11, [%rd57+4]
  r11 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (4)))));
  // PTX:162 ld.global.u32 %r12, [%rd57+8]
  r12 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (8)))));
  // PTX:163 cvta.to.global.u64 %rd58, %rd20
  rd58 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd20));
  // PTX:164 add.s64 %rd59, %rd58, %rd56
  asm("add.s64 %0, %1, %2;" : "=l"(rd59) : "l"(rd58), "l"(rd56));
  // PTX:165 ld.global.u32 %r13, [%rd59]
  r13 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))));
  // PTX:166 ld.global.u32 %r14, [%rd59+4]
  r14 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (4)))));
  // PTX:167 ld.global.u32 %r15, [%rd59+8]
  r15 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (8)))));
  // PTX:168 cvta.to.global.u64 %rd60, %rd17
  rd60 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd17));
  // PTX:169 add.s64 %rd62, %rd60, %rd43
  asm("add.s64 %0, %1, %2;" : "=l"(rd62) : "l"(rd60), "l"(rd43));
  // PTX:170 ld.global.u32 %r16, [%rd62]
  r16 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))));
  // PTX:171 ld.global.u32 %r17, [%rd62+4]
  r17 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (4)))));
  // PTX:172 ld.global.u32 %r18, [%rd62+8]
  r18 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (8)))));
  // PTX:173 ld.global.u32 %r19, [%rd62+12]
  r19 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (12)))));
  // PTX:174 cvta.to.global.u64 %rd63, %rd18
  rd63 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd18));
  // PTX:175 add.s64 %rd64, %rd63, %rd43
  asm("add.s64 %0, %1, %2;" : "=l"(rd64) : "l"(rd63), "l"(rd43));
  // PTX:176 ld.global.u32 %r20, [%rd64]
  r20 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (0)))));
  // PTX:177 ld.global.u32 %r21, [%rd64+4]
  r21 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (4)))));
  // PTX:178 ld.global.u32 %r22, [%rd64+8]
  r22 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (8)))));
  // PTX:179 ld.global.u32 %r23, [%rd64+12]
  r23 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (12)))));
  // PTX:180 cvt.u32.u64 %r24, %rd11
  asm("cvt.u32.u64 %0, %1;" : "=r"(r24) : "l"(rd11));
  // PTX:181 setp.lt.s32 %p4, %r24, 0
  p4 = (((int)(r24)) < ((int)(0)));
  // PTX:182 @%p4 bra $L__BB36_8
  if (p4) { goto L_BB36_8; }
  // PTX:184 mov.b32 %f64, %r16
  asm("mov.b32 %0, %1;" : "=f"(f64) : "r"(r16));
  // PTX:185 mov.b32 %f65, %r20
  asm("mov.b32 %0, %1;" : "=f"(f65) : "r"(r20));
  // PTX:186 add.f32 %f66, %f64, %f65
  asm("add.f32 %0, %1, %2;" : "=f"(f66) : "f"(f64), "f"(f65));
  // PTX:187 mov.b32 %f67, %r21
  asm("mov.b32 %0, %1;" : "=f"(f67) : "r"(r21));
  // PTX:188 mov.b32 %f68, %r17
  asm("mov.b32 %0, %1;" : "=f"(f68) : "r"(r17));
  // PTX:189 add.f32 %f69, %f68, %f67
  asm("add.f32 %0, %1, %2;" : "=f"(f69) : "f"(f68), "f"(f67));
  // PTX:190 mov.b32 %f70, %r22
  asm("mov.b32 %0, %1;" : "=f"(f70) : "r"(r22));
  // PTX:191 mov.b32 %f71, %r18
  asm("mov.b32 %0, %1;" : "=f"(f71) : "r"(r18));
  // PTX:192 add.f32 %f72, %f71, %f70
  asm("add.f32 %0, %1, %2;" : "=f"(f72) : "f"(f71), "f"(f70));
  // PTX:193 mov.b32 %f73, %r23
  asm("mov.b32 %0, %1;" : "=f"(f73) : "r"(r23));
  // PTX:194 mov.b32 %f74, %r19
  asm("mov.b32 %0, %1;" : "=f"(f74) : "r"(r19));
  // PTX:195 add.f32 %f75, %f74, %f73
  asm("add.f32 %0, %1, %2;" : "=f"(f75) : "f"(f74), "f"(f73));
  // PTX:196 mul.f32 %f76, %f66, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f76) : "f"(f66));
  // PTX:197 mul.f32 %f77, %f69, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f77) : "f"(f69));
  // PTX:198 mul.f32 %f78, %f72, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f78) : "f"(f72));
  // PTX:199 mul.f32 %f79, %f75, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f79) : "f"(f75));
  // PTX:200 mul.wide.s32 %rd65, %r54, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd65) : "r"(r54));
  // PTX:201 add.s64 %rd66, %rd1, %rd65
  asm("add.s64 %0, %1, %2;" : "=l"(rd66) : "l"(rd1), "l"(rd65));
  // PTX:202 ld.global.f32 %f80, [%rd66]
  f80 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (0)))));
  // PTX:203 ld.global.f32 %f81, [%rd66+4]
  f81 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (4)))));
  // PTX:204 ld.global.f32 %f82, [%rd66+8]
  f82 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (8)))));
  // PTX:205 mul.wide.s32 %rd67, %r55, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd67) : "r"(r55));
  // PTX:206 add.s64 %rd68, %rd1, %rd67
  asm("add.s64 %0, %1, %2;" : "=l"(rd68) : "l"(rd1), "l"(rd67));
  // PTX:207 ld.global.f32 %f83, [%rd68]
  f83 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (0)))));
  // PTX:208 mul.f32 %f84, %f77, %f83
  asm("mul.f32 %0, %1, %2;" : "=f"(f84) : "f"(f77), "f"(f83));
  // PTX:209 ld.global.f32 %f85, [%rd68+4]
  f85 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (4)))));
  // PTX:210 mul.f32 %f86, %f77, %f85
  asm("mul.f32 %0, %1, %2;" : "=f"(f86) : "f"(f77), "f"(f85));
  // PTX:211 ld.global.f32 %f87, [%rd68+8]
  f87 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (8)))));
  // PTX:212 mul.f32 %f88, %f77, %f87
  asm("mul.f32 %0, %1, %2;" : "=f"(f88) : "f"(f77), "f"(f87));
  // PTX:213 fma.rn.f32 %f89, %f76, %f80, %f84
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f89) : "f"(f76), "f"(f80), "f"(f84));
  // PTX:214 fma.rn.f32 %f90, %f76, %f81, %f86
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f90) : "f"(f76), "f"(f81), "f"(f86));
  // PTX:215 fma.rn.f32 %f91, %f76, %f82, %f88
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f91) : "f"(f76), "f"(f82), "f"(f88));
  // PTX:216 mul.wide.s32 %rd69, %r56, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd69) : "r"(r56));
  // PTX:217 add.s64 %rd70, %rd1, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd70) : "l"(rd1), "l"(rd69));
  // PTX:218 ld.global.f32 %f92, [%rd70]
  f92 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0)))));
  // PTX:219 ld.global.f32 %f93, [%rd70+4]
  f93 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (4)))));
  // PTX:220 ld.global.f32 %f94, [%rd70+8]
  f94 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (8)))));
  // PTX:221 fma.rn.f32 %f95, %f78, %f92, %f89
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f95) : "f"(f78), "f"(f92), "f"(f89));
  // PTX:222 fma.rn.f32 %f96, %f78, %f93, %f90
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f96) : "f"(f78), "f"(f93), "f"(f90));
  // PTX:223 fma.rn.f32 %f97, %f78, %f94, %f91
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f97) : "f"(f78), "f"(f94), "f"(f91));
  // PTX:224 mul.wide.s32 %rd71, %r57, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd71) : "r"(r57));
  // PTX:225 add.s64 %rd72, %rd1, %rd71
  asm("add.s64 %0, %1, %2;" : "=l"(rd72) : "l"(rd1), "l"(rd71));
  // PTX:226 ld.global.f32 %f98, [%rd72]
  f98 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (0)))));
  // PTX:227 ld.global.f32 %f99, [%rd72+4]
  f99 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (4)))));
  // PTX:228 ld.global.f32 %f100, [%rd72+8]
  f100 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (8)))));
  // PTX:229 fma.rn.f32 %f235, %f79, %f98, %f95
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f235) : "f"(f79), "f"(f98), "f"(f95));
  // PTX:230 fma.rn.f32 %f234, %f79, %f99, %f96
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f234) : "f"(f79), "f"(f99), "f"(f96));
  // PTX:231 fma.rn.f32 %f233, %f79, %f100, %f97
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f233) : "f"(f79), "f"(f100), "f"(f97));
  // PTX:232 bra.uni $L__BB36_9
  goto L_BB36_9;
  // PTX:234 $L__BB36_8:
L_BB36_8:;
  // PTX:235 mov.b32 %f101, %r10
  asm("mov.b32 %0, %1;" : "=f"(f101) : "r"(r10));
  // PTX:236 mov.b32 %f102, %r13
  asm("mov.b32 %0, %1;" : "=f"(f102) : "r"(r13));
  // PTX:237 add.f32 %f103, %f101, %f102
  asm("add.f32 %0, %1, %2;" : "=f"(f103) : "f"(f101), "f"(f102));
  // PTX:238 mov.b32 %f104, %r14
  asm("mov.b32 %0, %1;" : "=f"(f104) : "r"(r14));
  // PTX:239 mov.b32 %f105, %r11
  asm("mov.b32 %0, %1;" : "=f"(f105) : "r"(r11));
  // PTX:240 add.f32 %f106, %f105, %f104
  asm("add.f32 %0, %1, %2;" : "=f"(f106) : "f"(f105), "f"(f104));
  // PTX:241 mov.b32 %f107, %r15
  asm("mov.b32 %0, %1;" : "=f"(f107) : "r"(r15));
  // PTX:242 mov.b32 %f108, %r12
  asm("mov.b32 %0, %1;" : "=f"(f108) : "r"(r12));
  // PTX:243 add.f32 %f109, %f108, %f107
  asm("add.f32 %0, %1, %2;" : "=f"(f109) : "f"(f108), "f"(f107));
  // PTX:244 mul.f32 %f235, %f103, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f235) : "f"(f103));
  // PTX:245 mul.f32 %f234, %f106, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f234) : "f"(f106));
  // PTX:246 mul.f32 %f233, %f109, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f233) : "f"(f109));
  // PTX:248 $L__BB36_9:
L_BB36_9:;
  // PTX:249 @%p4 bra $L__BB36_11
  if (p4) { goto L_BB36_11; }
  // PTX:251 mov.b32 %f110, %r20
  asm("mov.b32 %0, %1;" : "=f"(f110) : "r"(r20));
  // PTX:252 mov.b32 %f111, %r16
  asm("mov.b32 %0, %1;" : "=f"(f111) : "r"(r16));
  // PTX:253 sub.f32 %f112, %f110, %f111
  asm("sub.f32 %0, %1, %2;" : "=f"(f112) : "f"(f110), "f"(f111));
  // PTX:254 mov.b32 %f113, %r17
  asm("mov.b32 %0, %1;" : "=f"(f113) : "r"(r17));
  // PTX:255 mov.b32 %f114, %r21
  asm("mov.b32 %0, %1;" : "=f"(f114) : "r"(r21));
  // PTX:256 sub.f32 %f115, %f114, %f113
  asm("sub.f32 %0, %1, %2;" : "=f"(f115) : "f"(f114), "f"(f113));
  // PTX:257 mov.b32 %f116, %r18
  asm("mov.b32 %0, %1;" : "=f"(f116) : "r"(r18));
  // PTX:258 mov.b32 %f117, %r22
  asm("mov.b32 %0, %1;" : "=f"(f117) : "r"(r22));
  // PTX:259 sub.f32 %f118, %f117, %f116
  asm("sub.f32 %0, %1, %2;" : "=f"(f118) : "f"(f117), "f"(f116));
  // PTX:260 mov.b32 %f119, %r19
  asm("mov.b32 %0, %1;" : "=f"(f119) : "r"(r19));
  // PTX:261 mov.b32 %f120, %r23
  asm("mov.b32 %0, %1;" : "=f"(f120) : "r"(r23));
  // PTX:262 sub.f32 %f121, %f120, %f119
  asm("sub.f32 %0, %1, %2;" : "=f"(f121) : "f"(f120), "f"(f119));
  // PTX:263 mul.wide.s32 %rd73, %r54, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd73) : "r"(r54));
  // PTX:264 add.s64 %rd74, %rd1, %rd73
  asm("add.s64 %0, %1, %2;" : "=l"(rd74) : "l"(rd1), "l"(rd73));
  // PTX:265 ld.global.f32 %f122, [%rd74]
  f122 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (0)))));
  // PTX:266 ld.global.f32 %f123, [%rd74+4]
  f123 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (4)))));
  // PTX:267 ld.global.f32 %f124, [%rd74+8]
  f124 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (8)))));
  // PTX:268 mul.wide.s32 %rd75, %r55, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd75) : "r"(r55));
  // PTX:269 add.s64 %rd76, %rd1, %rd75
  asm("add.s64 %0, %1, %2;" : "=l"(rd76) : "l"(rd1), "l"(rd75));
  // PTX:270 ld.global.f32 %f125, [%rd76]
  f125 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (0)))));
  // PTX:271 mul.f32 %f126, %f115, %f125
  asm("mul.f32 %0, %1, %2;" : "=f"(f126) : "f"(f115), "f"(f125));
  // PTX:272 ld.global.f32 %f127, [%rd76+4]
  f127 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (4)))));
  // PTX:273 mul.f32 %f128, %f115, %f127
  asm("mul.f32 %0, %1, %2;" : "=f"(f128) : "f"(f115), "f"(f127));
  // PTX:274 ld.global.f32 %f129, [%rd76+8]
  f129 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (8)))));
  // PTX:275 mul.f32 %f130, %f115, %f129
  asm("mul.f32 %0, %1, %2;" : "=f"(f130) : "f"(f115), "f"(f129));
  // PTX:276 fma.rn.f32 %f131, %f112, %f122, %f126
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f131) : "f"(f112), "f"(f122), "f"(f126));
  // PTX:277 fma.rn.f32 %f132, %f112, %f123, %f128
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f132) : "f"(f112), "f"(f123), "f"(f128));
  // PTX:278 fma.rn.f32 %f133, %f112, %f124, %f130
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f133) : "f"(f112), "f"(f124), "f"(f130));
  // PTX:279 mul.wide.s32 %rd77, %r56, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd77) : "r"(r56));
  // PTX:280 add.s64 %rd78, %rd1, %rd77
  asm("add.s64 %0, %1, %2;" : "=l"(rd78) : "l"(rd1), "l"(rd77));
  // PTX:281 ld.global.f32 %f134, [%rd78]
  f134 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd78) + (0)))));
  // PTX:282 ld.global.f32 %f135, [%rd78+4]
  f135 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd78) + (4)))));
  // PTX:283 ld.global.f32 %f136, [%rd78+8]
  f136 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd78) + (8)))));
  // PTX:284 fma.rn.f32 %f137, %f118, %f134, %f131
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f137) : "f"(f118), "f"(f134), "f"(f131));
  // PTX:285 fma.rn.f32 %f138, %f118, %f135, %f132
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f138) : "f"(f118), "f"(f135), "f"(f132));
  // PTX:286 fma.rn.f32 %f139, %f118, %f136, %f133
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f139) : "f"(f118), "f"(f136), "f"(f133));
  // PTX:287 mul.wide.s32 %rd79, %r57, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd79) : "r"(r57));
  // PTX:288 add.s64 %rd80, %rd1, %rd79
  asm("add.s64 %0, %1, %2;" : "=l"(rd80) : "l"(rd1), "l"(rd79));
  // PTX:289 ld.global.f32 %f140, [%rd80]
  f140 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (0)))));
  // PTX:290 ld.global.f32 %f141, [%rd80+4]
  f141 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (4)))));
  // PTX:291 ld.global.f32 %f142, [%rd80+8]
  f142 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (8)))));
  // PTX:292 fma.rn.f32 %f238, %f121, %f140, %f137
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f238) : "f"(f121), "f"(f140), "f"(f137));
  // PTX:293 fma.rn.f32 %f237, %f121, %f141, %f138
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f237) : "f"(f121), "f"(f141), "f"(f138));
  // PTX:294 fma.rn.f32 %f236, %f121, %f142, %f139
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f236) : "f"(f121), "f"(f142), "f"(f139));
  // PTX:295 bra.uni $L__BB36_12
  goto L_BB36_12;
  // PTX:297 $L__BB36_11:
L_BB36_11:;
  // PTX:298 mov.b32 %f143, %r13
  asm("mov.b32 %0, %1;" : "=f"(f143) : "r"(r13));
  // PTX:299 mov.b32 %f144, %r10
  asm("mov.b32 %0, %1;" : "=f"(f144) : "r"(r10));
  // PTX:300 sub.f32 %f238, %f143, %f144
  asm("sub.f32 %0, %1, %2;" : "=f"(f238) : "f"(f143), "f"(f144));
  // PTX:301 mov.b32 %f145, %r11
  asm("mov.b32 %0, %1;" : "=f"(f145) : "r"(r11));
  // PTX:302 mov.b32 %f146, %r14
  asm("mov.b32 %0, %1;" : "=f"(f146) : "r"(r14));
  // PTX:303 sub.f32 %f237, %f146, %f145
  asm("sub.f32 %0, %1, %2;" : "=f"(f237) : "f"(f146), "f"(f145));
  // PTX:304 mov.b32 %f147, %r12
  asm("mov.b32 %0, %1;" : "=f"(f147) : "r"(r12));
  // PTX:305 mov.b32 %f148, %r15
  asm("mov.b32 %0, %1;" : "=f"(f148) : "r"(r15));
  // PTX:306 sub.f32 %f236, %f148, %f147
  asm("sub.f32 %0, %1, %2;" : "=f"(f236) : "f"(f148), "f"(f147));
  // PTX:308 $L__BB36_12:
L_BB36_12:;
  // PTX:309 cvta.to.global.u64 %rd81, %rd22
  rd81 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd22));
  // PTX:310 mul.lo.s64 %rd82, %rd3, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd82) : "l"(rd3));
  // PTX:311 add.s64 %rd12, %rd81, %rd82
  asm("add.s64 %0, %1, %2;" : "=l"(rd12) : "l"(rd81), "l"(rd82));
  // PTX:312 ld.global.f32 %f22, [%rd12]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (0)))));
  // PTX:313 ld.global.f32 %f23, [%rd12+4]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (4)))));
  // PTX:314 ld.global.f32 %f24, [%rd12+8]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (8)))));
  // PTX:315 mul.f32 %f25, %f237, %f237
  asm("mul.f32 %0, %1, %2;" : "=f"(f25) : "f"(f237), "f"(f237));
  // PTX:316 mul.f32 %f26, %f238, %f238
  asm("mul.f32 %0, %1, %2;" : "=f"(f26) : "f"(f238), "f"(f238));
  // PTX:317 add.f32 %f150, %f25, %f26
  asm("add.f32 %0, %1, %2;" : "=f"(f150) : "f"(f25), "f"(f26));
  // PTX:318 mul.f32 %f27, %f236, %f236
  asm("mul.f32 %0, %1, %2;" : "=f"(f27) : "f"(f236), "f"(f236));
  // PTX:319 add.f32 %f28, %f27, %f150
  asm("add.f32 %0, %1, %2;" : "=f"(f28) : "f"(f27), "f"(f150));
  // PTX:320 cvta.to.global.u64 %rd83, %rd23
  rd83 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd23));
  // PTX:321 mul.lo.s64 %rd84, %rd3, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd84) : "l"(rd3));
  // PTX:322 add.s64 %rd13, %rd83, %rd84
  asm("add.s64 %0, %1, %2;" : "=l"(rd13) : "l"(rd83), "l"(rd84));
  // PTX:323 mov.u32 %r50, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r50) : );
  // PTX:324 st.global.u32 [%rd13], %r50
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0))))) = (unsigned)(r50);
  // PTX:325 mov.u32 %r51, 0
  asm("mov.u32 %0, 0;" : "=r"(r51) : );
  // PTX:326 st.global.u32 [%rd13+4], %r51
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4))))) = (unsigned)(r51);
  // PTX:327 st.global.u32 [%rd13+8], %r51
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8))))) = (unsigned)(r51);
  // PTX:328 st.global.u32 [%rd13+12], %r51
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (12))))) = (unsigned)(r51);
  // PTX:329 st.global.u32 [%rd13+16], %r50
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (16))))) = (unsigned)(r50);
  // PTX:330 st.global.u32 [%rd13+20], %r51
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (20))))) = (unsigned)(r51);
  // PTX:331 st.global.u32 [%rd13+24], %r51
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (24))))) = (unsigned)(r51);
  // PTX:332 st.global.u32 [%rd13+28], %r51
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (28))))) = (unsigned)(r51);
  // PTX:333 st.global.u32 [%rd13+32], %r50
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (32))))) = (unsigned)(r50);
  // PTX:334 setp.le.f32 %p6, %f28, 0f2B8CBCCC
  p6 = (!(isnan(((float)(f28))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) && (((float)(f28)) <= ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:335 mov.f32 %f239, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f239) : );
  // PTX:336 @%p6 bra $L__BB36_15
  if (p6) { goto L_BB36_15; }
  // PTX:338 sub.f32 %f151, %f1, %f22
  asm("sub.f32 %0, %1, %2;" : "=f"(f151) : "f"(f1), "f"(f22));
  // PTX:339 sub.f32 %f152, %f151, %f235
  asm("sub.f32 %0, %1, %2;" : "=f"(f152) : "f"(f151), "f"(f235));
  // PTX:340 sub.f32 %f153, %f2, %f23
  asm("sub.f32 %0, %1, %2;" : "=f"(f153) : "f"(f2), "f"(f23));
  // PTX:341 sub.f32 %f154, %f153, %f234
  asm("sub.f32 %0, %1, %2;" : "=f"(f154) : "f"(f153), "f"(f234));
  // PTX:342 mul.f32 %f155, %f237, %f154
  asm("mul.f32 %0, %1, %2;" : "=f"(f155) : "f"(f237), "f"(f154));
  // PTX:343 sub.f32 %f156, %f3, %f24
  asm("sub.f32 %0, %1, %2;" : "=f"(f156) : "f"(f3), "f"(f24));
  // PTX:344 sub.f32 %f157, %f156, %f233
  asm("sub.f32 %0, %1, %2;" : "=f"(f157) : "f"(f156), "f"(f233));
  // PTX:345 fma.rn.f32 %f158, %f238, %f152, %f155
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f158) : "f"(f238), "f"(f152), "f"(f155));
  // PTX:346 fma.rn.f32 %f159, %f236, %f157, %f158
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f159) : "f"(f236), "f"(f157), "f"(f158));
  // PTX:347 div.rn.f32 %f160, %f159, %f28
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f160) : "f"(f159), "f"(f28));
  // PTX:348 mov.f32 %f161, 0fBF000000
  asm("mov.f32 %0, 0fBF000000;" : "=f"(f161) : );
  // PTX:349 max.f32 %f162, %f161, %f160
  asm("max.f32 %0, %1, %2;" : "=f"(f162) : "f"(f161), "f"(f160));
  // PTX:350 mov.f32 %f163, 0f3F000000
  asm("mov.f32 %0, 0f3F000000;" : "=f"(f163) : );
  // PTX:351 min.f32 %f239, %f163, %f162
  asm("min.f32 %0, %1, %2;" : "=f"(f239) : "f"(f163), "f"(f162));
  // PTX:352 setp.leu.f32 %p7, %f160, 0fBF000000
  p7 = ((isnan(((float)(f160))) || isnan(((float)(as_f32(0xBF000000u))))) || (((float)(f160)) <= ((float)(as_f32(0xBF000000u)))));
  // PTX:353 setp.geu.f32 %p8, %f160, 0f3F000000
  p8 = ((isnan(((float)(f160))) || isnan(((float)(as_f32(0x3F000000u))))) || (((float)(f160)) >= ((float)(as_f32(0x3F000000u)))));
  // PTX:354 or.pred %p9, %p7, %p8
  p9 = ((p7) || (p8));
  // PTX:355 @%p9 bra $L__BB36_15
  if (p9) { goto L_BB36_15; }
  // PTX:357 mul.f32 %f164, %f237, %f238
  asm("mul.f32 %0, %1, %2;" : "=f"(f164) : "f"(f237), "f"(f238));
  // PTX:358 div.rn.f32 %f165, %f164, %f28
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f165) : "f"(f164), "f"(f28));
  // PTX:359 mul.f32 %f166, %f236, %f238
  asm("mul.f32 %0, %1, %2;" : "=f"(f166) : "f"(f236), "f"(f238));
  // PTX:360 div.rn.f32 %f167, %f166, %f28
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f167) : "f"(f166), "f"(f28));
  // PTX:361 mul.f32 %f168, %f236, %f237
  asm("mul.f32 %0, %1, %2;" : "=f"(f168) : "f"(f236), "f"(f237));
  // PTX:362 div.rn.f32 %f169, %f168, %f28
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f169) : "f"(f168), "f"(f28));
  // PTX:363 div.rn.f32 %f170, %f26, %f28
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f170) : "f"(f26), "f"(f28));
  // PTX:364 mov.f32 %f171, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f171) : );
  // PTX:365 sub.f32 %f172, %f171, %f170
  asm("sub.f32 %0, %1, %2;" : "=f"(f172) : "f"(f171), "f"(f170));
  // PTX:366 st.global.f32 [%rd13], %f172
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0))))) = (float)(f172);
  // PTX:367 mov.f32 %f173, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f173) : );
  // PTX:368 sub.f32 %f174, %f173, %f165
  asm("sub.f32 %0, %1, %2;" : "=f"(f174) : "f"(f173), "f"(f165));
  // PTX:369 st.global.f32 [%rd13+4], %f174
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4))))) = (float)(f174);
  // PTX:370 sub.f32 %f175, %f173, %f167
  asm("sub.f32 %0, %1, %2;" : "=f"(f175) : "f"(f173), "f"(f167));
  // PTX:371 st.global.f32 [%rd13+8], %f175
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8))))) = (float)(f175);
  // PTX:372 st.global.f32 [%rd13+12], %f174
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (12))))) = (float)(f174);
  // PTX:373 div.rn.f32 %f176, %f25, %f28
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f176) : "f"(f25), "f"(f28));
  // PTX:374 sub.f32 %f177, %f171, %f176
  asm("sub.f32 %0, %1, %2;" : "=f"(f177) : "f"(f171), "f"(f176));
  // PTX:375 st.global.f32 [%rd13+16], %f177
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (16))))) = (float)(f177);
  // PTX:376 sub.f32 %f178, %f173, %f169
  asm("sub.f32 %0, %1, %2;" : "=f"(f178) : "f"(f173), "f"(f169));
  // PTX:377 st.global.f32 [%rd13+20], %f178
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (20))))) = (float)(f178);
  // PTX:378 st.global.f32 [%rd13+24], %f175
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (24))))) = (float)(f175);
  // PTX:379 st.global.f32 [%rd13+28], %f178
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (28))))) = (float)(f178);
  // PTX:380 div.rn.f32 %f179, %f27, %f28
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f179) : "f"(f27), "f"(f28));
  // PTX:381 sub.f32 %f180, %f171, %f179
  asm("sub.f32 %0, %1, %2;" : "=f"(f180) : "f"(f171), "f"(f179));
  // PTX:382 st.global.f32 [%rd13+32], %f180
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (32))))) = (float)(f180);
  // PTX:384 $L__BB36_15:
L_BB36_15:;
  // PTX:385 fma.rn.f32 %f31, %f238, %f239, %f235
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f31) : "f"(f238), "f"(f239), "f"(f235));
  // PTX:386 fma.rn.f32 %f32, %f237, %f239, %f234
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f32) : "f"(f237), "f"(f239), "f"(f234));
  // PTX:387 fma.rn.f32 %f33, %f236, %f239, %f233
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f33) : "f"(f236), "f"(f239), "f"(f233));
  // PTX:388 cvta.to.global.u64 %rd85, %rd21
  rd85 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd21));
  // PTX:389 shl.b64 %rd86, %rd3, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd86) : "l"(rd3));
  // PTX:390 add.s64 %rd14, %rd85, %rd86
  asm("add.s64 %0, %1, %2;" : "=l"(rd14) : "l"(rd85), "l"(rd86));
  // PTX:391 st.global.f32 [%rd14], %f239
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0))))) = (float)(f239);
  // PTX:392 setp.eq.s16 %p10, %rs1, 0
  p10 = (((short)(rs1)) == ((short)(0)));
  // PTX:393 @%p10 bra $L__BB36_20
  if (p10) { goto L_BB36_20; }
  // PTX:395 add.f32 %f182, %f22, %f31
  asm("add.f32 %0, %1, %2;" : "=f"(f182) : "f"(f22), "f"(f31));
  // PTX:396 sub.f32 %f183, %f182, %f1
  asm("sub.f32 %0, %1, %2;" : "=f"(f183) : "f"(f182), "f"(f1));
  // PTX:397 add.f32 %f184, %f23, %f32
  asm("add.f32 %0, %1, %2;" : "=f"(f184) : "f"(f23), "f"(f32));
  // PTX:398 sub.f32 %f185, %f184, %f2
  asm("sub.f32 %0, %1, %2;" : "=f"(f185) : "f"(f184), "f"(f2));
  // PTX:399 add.f32 %f186, %f24, %f33
  asm("add.f32 %0, %1, %2;" : "=f"(f186) : "f"(f24), "f"(f33));
  // PTX:400 sub.f32 %f187, %f186, %f3
  asm("sub.f32 %0, %1, %2;" : "=f"(f187) : "f"(f186), "f"(f3));
  // PTX:401 ld.global.f32 %f188, [%rd13]
  f188 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))));
  // PTX:402 ld.global.f32 %f189, [%rd13+12]
  f189 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (12)))));
  // PTX:403 mul.f32 %f190, %f185, %f189
  asm("mul.f32 %0, %1, %2;" : "=f"(f190) : "f"(f185), "f"(f189));
  // PTX:404 fma.rn.f32 %f191, %f183, %f188, %f190
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f191) : "f"(f183), "f"(f188), "f"(f190));
  // PTX:405 ld.global.f32 %f192, [%rd13+24]
  f192 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (24)))));
  // PTX:406 fma.rn.f32 %f193, %f187, %f192, %f191
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f193) : "f"(f187), "f"(f192), "f"(f191));
  // PTX:407 ld.global.f32 %f194, [%rd13+4]
  f194 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4)))));
  // PTX:408 ld.global.f32 %f195, [%rd13+16]
  f195 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (16)))));
  // PTX:409 mul.f32 %f196, %f185, %f195
  asm("mul.f32 %0, %1, %2;" : "=f"(f196) : "f"(f185), "f"(f195));
  // PTX:410 fma.rn.f32 %f197, %f183, %f194, %f196
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f197) : "f"(f183), "f"(f194), "f"(f196));
  // PTX:411 ld.global.f32 %f198, [%rd13+28]
  f198 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (28)))));
  // PTX:412 fma.rn.f32 %f199, %f187, %f198, %f197
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f199) : "f"(f187), "f"(f198), "f"(f197));
  // PTX:413 ld.global.f32 %f200, [%rd13+8]
  f200 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8)))));
  // PTX:414 ld.global.f32 %f201, [%rd13+20]
  f201 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (20)))));
  // PTX:415 mul.f32 %f202, %f185, %f201
  asm("mul.f32 %0, %1, %2;" : "=f"(f202) : "f"(f185), "f"(f201));
  // PTX:416 fma.rn.f32 %f203, %f183, %f200, %f202
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f203) : "f"(f183), "f"(f200), "f"(f202));
  // PTX:417 ld.global.f32 %f204, [%rd13+32]
  f204 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (32)))));
  // PTX:418 fma.rn.f32 %f205, %f187, %f204, %f203
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f205) : "f"(f187), "f"(f204), "f"(f203));
  // PTX:419 st.global.f32 [%rd12], %f193
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (0))))) = (float)(f193);
  // PTX:420 st.global.f32 [%rd12+4], %f199
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (4))))) = (float)(f199);
  // PTX:421 st.global.f32 [%rd12+8], %f205
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (8))))) = (float)(f205);
  // PTX:422 sub.f32 %f34, %f1, %f193
  asm("sub.f32 %0, %1, %2;" : "=f"(f34) : "f"(f1), "f"(f193));
  // PTX:423 sub.f32 %f35, %f2, %f199
  asm("sub.f32 %0, %1, %2;" : "=f"(f35) : "f"(f2), "f"(f199));
  // PTX:424 sub.f32 %f36, %f3, %f205
  asm("sub.f32 %0, %1, %2;" : "=f"(f36) : "f"(f3), "f"(f205));
  // PTX:425 mov.u32 %r52, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r52) : );
  // PTX:426 st.global.u32 [%rd13], %r52
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0))))) = (unsigned)(r52);
  // PTX:427 mov.u32 %r53, 0
  asm("mov.u32 %0, 0;" : "=r"(r53) : );
  // PTX:428 st.global.u32 [%rd13+4], %r53
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4))))) = (unsigned)(r53);
  // PTX:429 st.global.u32 [%rd13+8], %r53
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8))))) = (unsigned)(r53);
  // PTX:430 st.global.u32 [%rd13+12], %r53
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (12))))) = (unsigned)(r53);
  // PTX:431 st.global.u32 [%rd13+16], %r52
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (16))))) = (unsigned)(r52);
  // PTX:432 st.global.u32 [%rd13+20], %r53
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (20))))) = (unsigned)(r53);
  // PTX:433 st.global.u32 [%rd13+24], %r53
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (24))))) = (unsigned)(r53);
  // PTX:434 st.global.u32 [%rd13+28], %r53
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (28))))) = (unsigned)(r53);
  // PTX:435 st.global.u32 [%rd13+32], %r52
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (32))))) = (unsigned)(r52);
  // PTX:436 mov.f32 %f240, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f240) : );
  // PTX:437 @%p6 bra $L__BB36_19
  if (p6) { goto L_BB36_19; }
  // PTX:439 sub.f32 %f206, %f34, %f235
  asm("sub.f32 %0, %1, %2;" : "=f"(f206) : "f"(f34), "f"(f235));
  // PTX:440 sub.f32 %f207, %f35, %f234
  asm("sub.f32 %0, %1, %2;" : "=f"(f207) : "f"(f35), "f"(f234));
  // PTX:441 mul.f32 %f208, %f237, %f207
  asm("mul.f32 %0, %1, %2;" : "=f"(f208) : "f"(f237), "f"(f207));
  // PTX:442 sub.f32 %f209, %f36, %f233
  asm("sub.f32 %0, %1, %2;" : "=f"(f209) : "f"(f36), "f"(f233));
  // PTX:443 fma.rn.f32 %f210, %f238, %f206, %f208
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f210) : "f"(f238), "f"(f206), "f"(f208));
  // PTX:444 fma.rn.f32 %f211, %f236, %f209, %f210
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f211) : "f"(f236), "f"(f209), "f"(f210));
  // PTX:445 div.rn.f32 %f212, %f211, %f28
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f212) : "f"(f211), "f"(f28));
  // PTX:446 mov.f32 %f213, 0fBF000000
  asm("mov.f32 %0, 0fBF000000;" : "=f"(f213) : );
  // PTX:447 max.f32 %f214, %f213, %f212
  asm("max.f32 %0, %1, %2;" : "=f"(f214) : "f"(f213), "f"(f212));
  // PTX:448 mov.f32 %f215, 0f3F000000
  asm("mov.f32 %0, 0f3F000000;" : "=f"(f215) : );
  // PTX:449 min.f32 %f240, %f215, %f214
  asm("min.f32 %0, %1, %2;" : "=f"(f240) : "f"(f215), "f"(f214));
  // PTX:450 setp.leu.f32 %p12, %f212, 0fBF000000
  p12 = ((isnan(((float)(f212))) || isnan(((float)(as_f32(0xBF000000u))))) || (((float)(f212)) <= ((float)(as_f32(0xBF000000u)))));
  // PTX:451 setp.geu.f32 %p13, %f212, 0f3F000000
  p13 = ((isnan(((float)(f212))) || isnan(((float)(as_f32(0x3F000000u))))) || (((float)(f212)) >= ((float)(as_f32(0x3F000000u)))));
  // PTX:452 or.pred %p14, %p12, %p13
  p14 = ((p12) || (p13));
  // PTX:453 @%p14 bra $L__BB36_19
  if (p14) { goto L_BB36_19; }
  // PTX:455 mul.f32 %f216, %f237, %f238
  asm("mul.f32 %0, %1, %2;" : "=f"(f216) : "f"(f237), "f"(f238));
  // PTX:456 div.rn.f32 %f217, %f216, %f28
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f217) : "f"(f216), "f"(f28));
  // PTX:457 mul.f32 %f218, %f236, %f238
  asm("mul.f32 %0, %1, %2;" : "=f"(f218) : "f"(f236), "f"(f238));
  // PTX:458 div.rn.f32 %f219, %f218, %f28
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f219) : "f"(f218), "f"(f28));
  // PTX:459 mul.f32 %f220, %f236, %f237
  asm("mul.f32 %0, %1, %2;" : "=f"(f220) : "f"(f236), "f"(f237));
  // PTX:460 div.rn.f32 %f221, %f220, %f28
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f221) : "f"(f220), "f"(f28));
  // PTX:461 div.rn.f32 %f222, %f26, %f28
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f222) : "f"(f26), "f"(f28));
  // PTX:462 mov.f32 %f223, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f223) : );
  // PTX:463 sub.f32 %f224, %f223, %f222
  asm("sub.f32 %0, %1, %2;" : "=f"(f224) : "f"(f223), "f"(f222));
  // PTX:464 st.global.f32 [%rd13], %f224
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0))))) = (float)(f224);
  // PTX:465 mov.f32 %f225, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f225) : );
  // PTX:466 sub.f32 %f226, %f225, %f217
  asm("sub.f32 %0, %1, %2;" : "=f"(f226) : "f"(f225), "f"(f217));
  // PTX:467 st.global.f32 [%rd13+4], %f226
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4))))) = (float)(f226);
  // PTX:468 sub.f32 %f227, %f225, %f219
  asm("sub.f32 %0, %1, %2;" : "=f"(f227) : "f"(f225), "f"(f219));
  // PTX:469 st.global.f32 [%rd13+8], %f227
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8))))) = (float)(f227);
  // PTX:470 st.global.f32 [%rd13+12], %f226
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (12))))) = (float)(f226);
  // PTX:471 div.rn.f32 %f228, %f25, %f28
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f228) : "f"(f25), "f"(f28));
  // PTX:472 sub.f32 %f229, %f223, %f228
  asm("sub.f32 %0, %1, %2;" : "=f"(f229) : "f"(f223), "f"(f228));
  // PTX:473 st.global.f32 [%rd13+16], %f229
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (16))))) = (float)(f229);
  // PTX:474 sub.f32 %f230, %f225, %f221
  asm("sub.f32 %0, %1, %2;" : "=f"(f230) : "f"(f225), "f"(f221));
  // PTX:475 st.global.f32 [%rd13+20], %f230
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (20))))) = (float)(f230);
  // PTX:476 st.global.f32 [%rd13+24], %f227
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (24))))) = (float)(f227);
  // PTX:477 st.global.f32 [%rd13+28], %f230
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (28))))) = (float)(f230);
  // PTX:478 div.rn.f32 %f231, %f27, %f28
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f231) : "f"(f27), "f"(f28));
  // PTX:479 sub.f32 %f232, %f223, %f231
  asm("sub.f32 %0, %1, %2;" : "=f"(f232) : "f"(f223), "f"(f231));
  // PTX:480 st.global.f32 [%rd13+32], %f232
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (32))))) = (float)(f232);
  // PTX:482 $L__BB36_19:
L_BB36_19:;
  // PTX:483 st.global.f32 [%rd14], %f240
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0))))) = (float)(f240);
  // PTX:485 $L__BB36_20:
L_BB36_20:;
  // PTX:486 ret
  return;
}
