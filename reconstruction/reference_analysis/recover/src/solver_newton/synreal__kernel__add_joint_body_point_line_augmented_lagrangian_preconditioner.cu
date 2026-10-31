// 机械还原自 PTX：synreal::kernel::add_joint_body_point_line_augmented_lagrangian_preconditioner(glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long)
// PTX SHA256: bf117b779154a74ac8580beb889c818d994aac2af19c400d0e86e8a9502c6890
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__add_joint_body_point_line_augmented_lagrangian_preconditioner(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, float param8, unsigned long long param9, unsigned long long param10, unsigned long long param11, unsigned long long param12, unsigned long long param13) {
  int p0, p1, p2, p3;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135;
  // PTX:30 ld.param.u64 %rd21, [_ZN7synreal6kernel61add_joint_body_point_line_augmented_lagrangian_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_mmmm_param_0]
  rd21 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:31 ld.param.u64 %rd11, [_ZN7synreal6kernel61add_joint_body_point_line_augmented_lagrangian_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_mmmm_param_1]
  rd11 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:32 ld.param.u64 %rd12, [_ZN7synreal6kernel61add_joint_body_point_line_augmented_lagrangian_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_mmmm_param_2]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:33 ld.param.u64 %rd13, [_ZN7synreal6kernel61add_joint_body_point_line_augmented_lagrangian_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_mmmm_param_3]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:34 ld.param.u64 %rd14, [_ZN7synreal6kernel61add_joint_body_point_line_augmented_lagrangian_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_mmmm_param_4]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:35 ld.param.u64 %rd15, [_ZN7synreal6kernel61add_joint_body_point_line_augmented_lagrangian_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_mmmm_param_5]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:36 ld.param.u64 %rd16, [_ZN7synreal6kernel61add_joint_body_point_line_augmented_lagrangian_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_mmmm_param_6]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:37 ld.param.u64 %rd17, [_ZN7synreal6kernel61add_joint_body_point_line_augmented_lagrangian_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_mmmm_param_7]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:38 ld.param.f32 %f6, [_ZN7synreal6kernel61add_joint_body_point_line_augmented_lagrangian_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_mmmm_param_8]
  f6 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param8 + (0))));
  // PTX:39 ld.param.u64 %rd22, [_ZN7synreal6kernel61add_joint_body_point_line_augmented_lagrangian_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_mmmm_param_9]
  rd22 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:40 ld.param.u64 %rd23, [_ZN7synreal6kernel61add_joint_body_point_line_augmented_lagrangian_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_mmmm_param_10]
  rd23 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:41 ld.param.u64 %rd18, [_ZN7synreal6kernel61add_joint_body_point_line_augmented_lagrangian_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_mmmm_param_11]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:42 ld.param.u64 %rd19, [_ZN7synreal6kernel61add_joint_body_point_line_augmented_lagrangian_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_mmmm_param_12]
  rd19 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:43 ld.param.u64 %rd20, [_ZN7synreal6kernel61add_joint_body_point_line_augmented_lagrangian_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_mmmm_param_13]
  rd20 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:44 cvta.to.global.u64 %rd1, %rd22
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd22));
  // PTX:45 cvta.to.global.u64 %rd2, %rd21
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd21));
  // PTX:46 mov.u32 %r3, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(blockIdx.x));
  // PTX:47 mov.u32 %r4, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r4) : "r"(blockDim.x));
  // PTX:48 mul.wide.u32 %rd24, %r3, %r4
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd24) : "r"(r3), "r"(r4));
  // PTX:49 mov.u32 %r5, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r5) : "r"(threadIdx.x));
  // PTX:50 cvt.u64.u32 %rd25, %r5
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd25) : "r"(r5));
  // PTX:51 add.s64 %rd3, %rd24, %rd25
  asm("add.s64 %0, %1, %2;" : "=l"(rd3) : "l"(rd24), "l"(rd25));
  // PTX:52 setp.ge.u64 %p1, %rd3, %rd23
  p1 = (((unsigned long long)(rd3)) >= ((unsigned long long)(rd23)));
  // PTX:53 @%p1 bra $L__BB38_6
  if (p1) { goto L_BB38_6; }
  // PTX:55 or.b64 %rd26, %rd3, %rd19
  asm("or.b64 %0, %1, %2;" : "=l"(rd26) : "l"(rd3), "l"(rd19));
  // PTX:56 and.b64 %rd27, %rd26, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd27) : "l"(rd26));
  // PTX:57 setp.eq.s64 %p2, %rd27, 0
  p2 = (((long long)(rd27)) == ((long long)(0)));
  // PTX:58 @%p2 bra $L__BB38_3
  if (p2) { goto L_BB38_3; }
  // PTX:60 div.u64 %rd134, %rd3, %rd19
  asm("div.u64 %0, %1, %2;" : "=l"(rd134) : "l"(rd3), "l"(rd19));
  // PTX:61 mul.lo.s64 %rd28, %rd134, %rd19
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd28) : "l"(rd134), "l"(rd19));
  // PTX:62 sub.s64 %rd135, %rd3, %rd28
  asm("sub.s64 %0, %1, %2;" : "=l"(rd135) : "l"(rd3), "l"(rd28));
  // PTX:63 bra.uni $L__BB38_4
  goto L_BB38_4;
  // PTX:65 $L__BB38_3:
L_BB38_3:;
  // PTX:66 cvt.u32.u64 %r6, %rd19
  asm("cvt.u32.u64 %0, %1;" : "=r"(r6) : "l"(rd19));
  // PTX:67 cvt.u32.u64 %r7, %rd3
  asm("cvt.u32.u64 %0, %1;" : "=r"(r7) : "l"(rd3));
  // PTX:68 div.u32 %r8, %r7, %r6
  asm("div.u32 %0, %1, %2;" : "=r"(r8) : "r"(r7), "r"(r6));
  // PTX:69 mul.lo.s32 %r9, %r8, %r6
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r9) : "r"(r8), "r"(r6));
  // PTX:70 sub.s32 %r10, %r7, %r9
  asm("sub.s32 %0, %1, %2;" : "=r"(r10) : "r"(r7), "r"(r9));
  // PTX:71 cvt.u64.u32 %rd134, %r8
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd134) : "r"(r8));
  // PTX:72 cvt.u64.u32 %rd135, %r10
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd135) : "r"(r10));
  // PTX:74 $L__BB38_4:
L_BB38_4:;
  // PTX:75 sub.s64 %rd29, %rd18, %rd19
  asm("sub.s64 %0, %1, %2;" : "=l"(rd29) : "l"(rd18), "l"(rd19));
  // PTX:76 add.s64 %rd30, %rd135, %rd29
  asm("add.s64 %0, %1, %2;" : "=l"(rd30) : "l"(rd135), "l"(rd29));
  // PTX:77 mul.lo.s64 %rd31, %rd134, %rd20
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd134), "l"(rd20));
  // PTX:78 cvt.u32.u64 %r1, %rd31
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd31));
  // PTX:79 cvta.to.global.u64 %rd32, %rd11
  rd32 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd11));
  // PTX:80 shl.b64 %rd33, %rd30, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd33) : "l"(rd30));
  // PTX:81 add.s64 %rd34, %rd32, %rd33
  asm("add.s64 %0, %1, %2;" : "=l"(rd34) : "l"(rd32), "l"(rd33));
  // PTX:82 ld.global.u32 %r2, [%rd34+4]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (4)))));
  // PTX:83 ld.global.u32 %r11, [%rd34]
  r11 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (0)))));
  // PTX:84 mul.wide.s32 %rd35, %r11, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd35) : "r"(r11));
  // PTX:85 add.s64 %rd36, %rd2, %rd35
  asm("add.s64 %0, %1, %2;" : "=l"(rd36) : "l"(rd2), "l"(rd35));
  // PTX:86 ld.global.u32 %r12, [%rd36+4]
  r12 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (4)))));
  // PTX:87 ld.global.u32 %r13, [%rd36+8]
  r13 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (8)))));
  // PTX:88 ld.global.u32 %r14, [%rd36+12]
  r14 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (12)))));
  // PTX:89 cvta.to.global.u64 %rd37, %rd13
  rd37 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd13));
  // PTX:90 shl.b64 %rd38, %rd30, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd38) : "l"(rd30));
  // PTX:91 add.s64 %rd39, %rd37, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd39) : "l"(rd37), "l"(rd38));
  // PTX:92 cvta.to.global.u64 %rd40, %rd14
  rd40 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd14));
  // PTX:93 add.s64 %rd41, %rd40, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd41) : "l"(rd40), "l"(rd38));
  // PTX:94 ld.global.f32 %f7, [%rd41]
  f7 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (0)))));
  // PTX:95 ld.global.f32 %f8, [%rd39]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (0)))));
  // PTX:96 add.f32 %f9, %f8, %f7
  asm("add.f32 %0, %1, %2;" : "=f"(f9) : "f"(f8), "f"(f7));
  // PTX:97 ld.global.f32 %f10, [%rd41+4]
  f10 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (4)))));
  // PTX:98 ld.global.f32 %f11, [%rd39+4]
  f11 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (4)))));
  // PTX:99 add.f32 %f12, %f11, %f10
  asm("add.f32 %0, %1, %2;" : "=f"(f12) : "f"(f11), "f"(f10));
  // PTX:100 ld.global.f32 %f13, [%rd41+8]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (8)))));
  // PTX:101 ld.global.f32 %f14, [%rd39+8]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (8)))));
  // PTX:102 add.f32 %f15, %f14, %f13
  asm("add.f32 %0, %1, %2;" : "=f"(f15) : "f"(f14), "f"(f13));
  // PTX:103 ld.global.f32 %f16, [%rd41+12]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (12)))));
  // PTX:104 ld.global.f32 %f17, [%rd39+12]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (12)))));
  // PTX:105 add.f32 %f18, %f17, %f16
  asm("add.f32 %0, %1, %2;" : "=f"(f18) : "f"(f17), "f"(f16));
  // PTX:106 sub.f32 %f19, %f7, %f8
  asm("sub.f32 %0, %1, %2;" : "=f"(f19) : "f"(f7), "f"(f8));
  // PTX:107 sub.f32 %f20, %f10, %f11
  asm("sub.f32 %0, %1, %2;" : "=f"(f20) : "f"(f10), "f"(f11));
  // PTX:108 sub.f32 %f21, %f13, %f14
  asm("sub.f32 %0, %1, %2;" : "=f"(f21) : "f"(f13), "f"(f14));
  // PTX:109 sub.f32 %f22, %f16, %f17
  asm("sub.f32 %0, %1, %2;" : "=f"(f22) : "f"(f16), "f"(f17));
  // PTX:110 cvta.to.global.u64 %rd42, %rd16
  rd42 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd16));
  // PTX:111 shl.b64 %rd43, %rd3, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd43) : "l"(rd3));
  // PTX:112 add.s64 %rd44, %rd42, %rd43
  asm("add.s64 %0, %1, %2;" : "=l"(rd44) : "l"(rd42), "l"(rd43));
  // PTX:113 ld.global.f32 %f23, [%rd44]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))));
  // PTX:114 mul.f32 %f24, %f23, %f19
  asm("mul.f32 %0, %1, %2;" : "=f"(f24) : "f"(f23), "f"(f19));
  // PTX:115 mul.f32 %f25, %f23, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f25) : "f"(f23), "f"(f20));
  // PTX:116 mul.f32 %f26, %f23, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f26) : "f"(f23), "f"(f21));
  // PTX:117 mul.f32 %f27, %f23, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f27) : "f"(f23), "f"(f22));
  // PTX:118 cvta.to.global.u64 %rd45, %rd15
  rd45 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd15));
  // PTX:119 shl.b64 %rd46, %rd30, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd46) : "l"(rd30));
  // PTX:120 add.s64 %rd47, %rd45, %rd46
  asm("add.s64 %0, %1, %2;" : "=l"(rd47) : "l"(rd45), "l"(rd46));
  // PTX:121 ld.global.f32 %f28, [%rd47]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))));
  // PTX:122 mul.f32 %f1, %f28, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f1) : "f"(f28), "f"(f6));
  // PTX:123 cvta.to.global.u64 %rd48, %rd12
  rd48 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd12));
  // PTX:124 add.s64 %rd49, %rd48, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd49) : "l"(rd48), "l"(rd38));
  // PTX:125 cvta.to.global.u64 %rd50, %rd17
  rd50 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd17));
  // PTX:126 mul.lo.s64 %rd51, %rd3, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd51) : "l"(rd3));
  // PTX:127 add.s64 %rd10, %rd50, %rd51
  asm("add.s64 %0, %1, %2;" : "=l"(rd10) : "l"(rd50), "l"(rd51));
  // PTX:128 ld.global.f32 %f29, [%rd49]
  f29 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))));
  // PTX:129 mul.f32 %f30, %f1, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f30) : "f"(f1), "f"(f29));
  // PTX:130 mul.f32 %f31, %f29, %f30
  asm("mul.f32 %0, %1, %2;" : "=f"(f31) : "f"(f29), "f"(f30));
  // PTX:131 ld.global.u32 %r15, [%rd36]
  r15 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (0)))));
  // PTX:132 add.s32 %r16, %r15, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r16) : "r"(r15), "r"(r1));
  // PTX:133 ld.global.f32 %f32, [%rd10]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (0)))));
  // PTX:134 mul.f32 %f33, %f31, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f33) : "f"(f31), "f"(f32));
  // PTX:135 ld.global.f32 %f34, [%rd10+4]
  f34 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (4)))));
  // PTX:136 mul.f32 %f35, %f31, %f34
  asm("mul.f32 %0, %1, %2;" : "=f"(f35) : "f"(f31), "f"(f34));
  // PTX:137 ld.global.f32 %f36, [%rd10+8]
  f36 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (8)))));
  // PTX:138 mul.f32 %f37, %f31, %f36
  asm("mul.f32 %0, %1, %2;" : "=f"(f37) : "f"(f31), "f"(f36));
  // PTX:139 ld.global.f32 %f38, [%rd10+12]
  f38 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (12)))));
  // PTX:140 mul.f32 %f39, %f31, %f38
  asm("mul.f32 %0, %1, %2;" : "=f"(f39) : "f"(f31), "f"(f38));
  // PTX:141 ld.global.f32 %f40, [%rd10+16]
  f40 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (16)))));
  // PTX:142 mul.f32 %f41, %f31, %f40
  asm("mul.f32 %0, %1, %2;" : "=f"(f41) : "f"(f31), "f"(f40));
  // PTX:143 ld.global.f32 %f42, [%rd10+20]
  f42 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (20)))));
  // PTX:144 mul.f32 %f43, %f31, %f42
  asm("mul.f32 %0, %1, %2;" : "=f"(f43) : "f"(f31), "f"(f42));
  // PTX:145 ld.global.f32 %f44, [%rd10+24]
  f44 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (24)))));
  // PTX:146 mul.f32 %f45, %f31, %f44
  asm("mul.f32 %0, %1, %2;" : "=f"(f45) : "f"(f31), "f"(f44));
  // PTX:147 ld.global.f32 %f46, [%rd10+28]
  f46 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (28)))));
  // PTX:148 mul.f32 %f47, %f31, %f46
  asm("mul.f32 %0, %1, %2;" : "=f"(f47) : "f"(f31), "f"(f46));
  // PTX:149 ld.global.f32 %f48, [%rd10+32]
  f48 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (32)))));
  // PTX:150 mul.f32 %f49, %f31, %f48
  asm("mul.f32 %0, %1, %2;" : "=f"(f49) : "f"(f31), "f"(f48));
  // PTX:151 mul.wide.s32 %rd52, %r16, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd52) : "r"(r16));
  // PTX:152 add.s64 %rd53, %rd1, %rd52
  asm("add.s64 %0, %1, %2;" : "=l"(rd53) : "l"(rd1), "l"(rd52));
  // PTX:153 red.global.add.f32 [%rd53], %f33
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))), (float)(f33));
  // PTX:154 add.s64 %rd54, %rd53, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd54) : "l"(rd53));
  // PTX:155 red.global.add.f32 [%rd54], %f35
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))), (float)(f35));
  // PTX:156 add.s64 %rd55, %rd53, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd55) : "l"(rd53));
  // PTX:157 red.global.add.f32 [%rd55], %f37
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))), (float)(f37));
  // PTX:158 add.s64 %rd56, %rd53, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd56) : "l"(rd53));
  // PTX:159 red.global.add.f32 [%rd56], %f39
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))), (float)(f39));
  // PTX:160 add.s64 %rd57, %rd53, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd57) : "l"(rd53));
  // PTX:161 red.global.add.f32 [%rd57], %f41
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))), (float)(f41));
  // PTX:162 add.s64 %rd58, %rd53, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd58) : "l"(rd53));
  // PTX:163 red.global.add.f32 [%rd58], %f43
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (0)))), (float)(f43));
  // PTX:164 add.s64 %rd59, %rd53, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd59) : "l"(rd53));
  // PTX:165 red.global.add.f32 [%rd59], %f45
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))), (float)(f45));
  // PTX:166 add.s64 %rd60, %rd53, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd60) : "l"(rd53));
  // PTX:167 red.global.add.f32 [%rd60], %f47
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))), (float)(f47));
  // PTX:168 add.s64 %rd61, %rd53, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd61) : "l"(rd53));
  // PTX:169 red.global.add.f32 [%rd61], %f49
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))), (float)(f49));
  // PTX:170 ld.global.f32 %f59, [%rd49+4]
  f59 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (4)))));
  // PTX:171 mul.f32 %f60, %f1, %f59
  asm("mul.f32 %0, %1, %2;" : "=f"(f60) : "f"(f1), "f"(f59));
  // PTX:172 mul.f32 %f61, %f59, %f60
  asm("mul.f32 %0, %1, %2;" : "=f"(f61) : "f"(f59), "f"(f60));
  // PTX:173 add.s32 %r17, %r12, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r17) : "r"(r12), "r"(r1));
  // PTX:174 ld.global.f32 %f62, [%rd10]
  f62 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (0)))));
  // PTX:175 mul.f32 %f63, %f61, %f62
  asm("mul.f32 %0, %1, %2;" : "=f"(f63) : "f"(f61), "f"(f62));
  // PTX:176 ld.global.f32 %f64, [%rd10+4]
  f64 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (4)))));
  // PTX:177 mul.f32 %f65, %f61, %f64
  asm("mul.f32 %0, %1, %2;" : "=f"(f65) : "f"(f61), "f"(f64));
  // PTX:178 ld.global.f32 %f66, [%rd10+8]
  f66 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (8)))));
  // PTX:179 mul.f32 %f67, %f61, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f67) : "f"(f61), "f"(f66));
  // PTX:180 ld.global.f32 %f68, [%rd10+12]
  f68 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (12)))));
  // PTX:181 mul.f32 %f69, %f61, %f68
  asm("mul.f32 %0, %1, %2;" : "=f"(f69) : "f"(f61), "f"(f68));
  // PTX:182 ld.global.f32 %f70, [%rd10+16]
  f70 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (16)))));
  // PTX:183 mul.f32 %f71, %f61, %f70
  asm("mul.f32 %0, %1, %2;" : "=f"(f71) : "f"(f61), "f"(f70));
  // PTX:184 ld.global.f32 %f72, [%rd10+20]
  f72 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (20)))));
  // PTX:185 mul.f32 %f73, %f61, %f72
  asm("mul.f32 %0, %1, %2;" : "=f"(f73) : "f"(f61), "f"(f72));
  // PTX:186 ld.global.f32 %f74, [%rd10+24]
  f74 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (24)))));
  // PTX:187 mul.f32 %f75, %f61, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f75) : "f"(f61), "f"(f74));
  // PTX:188 ld.global.f32 %f76, [%rd10+28]
  f76 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (28)))));
  // PTX:189 mul.f32 %f77, %f61, %f76
  asm("mul.f32 %0, %1, %2;" : "=f"(f77) : "f"(f61), "f"(f76));
  // PTX:190 ld.global.f32 %f78, [%rd10+32]
  f78 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (32)))));
  // PTX:191 mul.f32 %f79, %f61, %f78
  asm("mul.f32 %0, %1, %2;" : "=f"(f79) : "f"(f61), "f"(f78));
  // PTX:192 mul.wide.s32 %rd62, %r17, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd62) : "r"(r17));
  // PTX:193 add.s64 %rd63, %rd1, %rd62
  asm("add.s64 %0, %1, %2;" : "=l"(rd63) : "l"(rd1), "l"(rd62));
  // PTX:194 red.global.add.f32 [%rd63], %f63
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (0)))), (float)(f63));
  // PTX:195 add.s64 %rd64, %rd63, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd64) : "l"(rd63));
  // PTX:196 red.global.add.f32 [%rd64], %f65
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (0)))), (float)(f65));
  // PTX:197 add.s64 %rd65, %rd63, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd65) : "l"(rd63));
  // PTX:198 red.global.add.f32 [%rd65], %f67
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (0)))), (float)(f67));
  // PTX:199 add.s64 %rd66, %rd63, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd66) : "l"(rd63));
  // PTX:200 red.global.add.f32 [%rd66], %f69
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (0)))), (float)(f69));
  // PTX:201 add.s64 %rd67, %rd63, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd67) : "l"(rd63));
  // PTX:202 red.global.add.f32 [%rd67], %f71
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0)))), (float)(f71));
  // PTX:203 add.s64 %rd68, %rd63, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd68) : "l"(rd63));
  // PTX:204 red.global.add.f32 [%rd68], %f73
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (0)))), (float)(f73));
  // PTX:205 add.s64 %rd69, %rd63, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd69) : "l"(rd63));
  // PTX:206 red.global.add.f32 [%rd69], %f75
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (0)))), (float)(f75));
  // PTX:207 add.s64 %rd70, %rd63, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd70) : "l"(rd63));
  // PTX:208 red.global.add.f32 [%rd70], %f77
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0)))), (float)(f77));
  // PTX:209 add.s64 %rd71, %rd63, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd71) : "l"(rd63));
  // PTX:210 red.global.add.f32 [%rd71], %f79
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))), (float)(f79));
  // PTX:211 ld.global.f32 %f89, [%rd49+8]
  f89 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (8)))));
  // PTX:212 mul.f32 %f90, %f1, %f89
  asm("mul.f32 %0, %1, %2;" : "=f"(f90) : "f"(f1), "f"(f89));
  // PTX:213 mul.f32 %f91, %f89, %f90
  asm("mul.f32 %0, %1, %2;" : "=f"(f91) : "f"(f89), "f"(f90));
  // PTX:214 add.s32 %r18, %r13, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r18) : "r"(r13), "r"(r1));
  // PTX:215 ld.global.f32 %f92, [%rd10]
  f92 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (0)))));
  // PTX:216 mul.f32 %f93, %f91, %f92
  asm("mul.f32 %0, %1, %2;" : "=f"(f93) : "f"(f91), "f"(f92));
  // PTX:217 ld.global.f32 %f94, [%rd10+4]
  f94 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (4)))));
  // PTX:218 mul.f32 %f95, %f91, %f94
  asm("mul.f32 %0, %1, %2;" : "=f"(f95) : "f"(f91), "f"(f94));
  // PTX:219 ld.global.f32 %f96, [%rd10+8]
  f96 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (8)))));
  // PTX:220 mul.f32 %f97, %f91, %f96
  asm("mul.f32 %0, %1, %2;" : "=f"(f97) : "f"(f91), "f"(f96));
  // PTX:221 ld.global.f32 %f98, [%rd10+12]
  f98 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (12)))));
  // PTX:222 mul.f32 %f99, %f91, %f98
  asm("mul.f32 %0, %1, %2;" : "=f"(f99) : "f"(f91), "f"(f98));
  // PTX:223 ld.global.f32 %f100, [%rd10+16]
  f100 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (16)))));
  // PTX:224 mul.f32 %f101, %f91, %f100
  asm("mul.f32 %0, %1, %2;" : "=f"(f101) : "f"(f91), "f"(f100));
  // PTX:225 ld.global.f32 %f102, [%rd10+20]
  f102 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (20)))));
  // PTX:226 mul.f32 %f103, %f91, %f102
  asm("mul.f32 %0, %1, %2;" : "=f"(f103) : "f"(f91), "f"(f102));
  // PTX:227 ld.global.f32 %f104, [%rd10+24]
  f104 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (24)))));
  // PTX:228 mul.f32 %f105, %f91, %f104
  asm("mul.f32 %0, %1, %2;" : "=f"(f105) : "f"(f91), "f"(f104));
  // PTX:229 ld.global.f32 %f106, [%rd10+28]
  f106 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (28)))));
  // PTX:230 mul.f32 %f107, %f91, %f106
  asm("mul.f32 %0, %1, %2;" : "=f"(f107) : "f"(f91), "f"(f106));
  // PTX:231 ld.global.f32 %f108, [%rd10+32]
  f108 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (32)))));
  // PTX:232 mul.f32 %f109, %f91, %f108
  asm("mul.f32 %0, %1, %2;" : "=f"(f109) : "f"(f91), "f"(f108));
  // PTX:233 mul.wide.s32 %rd72, %r18, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd72) : "r"(r18));
  // PTX:234 add.s64 %rd73, %rd1, %rd72
  asm("add.s64 %0, %1, %2;" : "=l"(rd73) : "l"(rd1), "l"(rd72));
  // PTX:235 red.global.add.f32 [%rd73], %f93
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (0)))), (float)(f93));
  // PTX:236 add.s64 %rd74, %rd73, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd74) : "l"(rd73));
  // PTX:237 red.global.add.f32 [%rd74], %f95
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (0)))), (float)(f95));
  // PTX:238 add.s64 %rd75, %rd73, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd75) : "l"(rd73));
  // PTX:239 red.global.add.f32 [%rd75], %f97
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (0)))), (float)(f97));
  // PTX:240 add.s64 %rd76, %rd73, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd76) : "l"(rd73));
  // PTX:241 red.global.add.f32 [%rd76], %f99
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (0)))), (float)(f99));
  // PTX:242 add.s64 %rd77, %rd73, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd77) : "l"(rd73));
  // PTX:243 red.global.add.f32 [%rd77], %f101
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (0)))), (float)(f101));
  // PTX:244 add.s64 %rd78, %rd73, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd78) : "l"(rd73));
  // PTX:245 red.global.add.f32 [%rd78], %f103
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd78) + (0)))), (float)(f103));
  // PTX:246 add.s64 %rd79, %rd73, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd79) : "l"(rd73));
  // PTX:247 red.global.add.f32 [%rd79], %f105
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (0)))), (float)(f105));
  // PTX:248 add.s64 %rd80, %rd73, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd80) : "l"(rd73));
  // PTX:249 red.global.add.f32 [%rd80], %f107
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (0)))), (float)(f107));
  // PTX:250 add.s64 %rd81, %rd73, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd81) : "l"(rd73));
  // PTX:251 red.global.add.f32 [%rd81], %f109
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (0)))), (float)(f109));
  // PTX:252 ld.global.f32 %f119, [%rd49+12]
  f119 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (12)))));
  // PTX:253 mul.f32 %f120, %f1, %f119
  asm("mul.f32 %0, %1, %2;" : "=f"(f120) : "f"(f1), "f"(f119));
  // PTX:254 mul.f32 %f121, %f119, %f120
  asm("mul.f32 %0, %1, %2;" : "=f"(f121) : "f"(f119), "f"(f120));
  // PTX:255 add.s32 %r19, %r14, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r19) : "r"(r14), "r"(r1));
  // PTX:256 ld.global.f32 %f122, [%rd10]
  f122 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (0)))));
  // PTX:257 mul.f32 %f123, %f121, %f122
  asm("mul.f32 %0, %1, %2;" : "=f"(f123) : "f"(f121), "f"(f122));
  // PTX:258 ld.global.f32 %f124, [%rd10+4]
  f124 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (4)))));
  // PTX:259 mul.f32 %f125, %f121, %f124
  asm("mul.f32 %0, %1, %2;" : "=f"(f125) : "f"(f121), "f"(f124));
  // PTX:260 ld.global.f32 %f126, [%rd10+8]
  f126 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (8)))));
  // PTX:261 mul.f32 %f127, %f121, %f126
  asm("mul.f32 %0, %1, %2;" : "=f"(f127) : "f"(f121), "f"(f126));
  // PTX:262 ld.global.f32 %f128, [%rd10+12]
  f128 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (12)))));
  // PTX:263 mul.f32 %f129, %f121, %f128
  asm("mul.f32 %0, %1, %2;" : "=f"(f129) : "f"(f121), "f"(f128));
  // PTX:264 ld.global.f32 %f130, [%rd10+16]
  f130 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (16)))));
  // PTX:265 mul.f32 %f131, %f121, %f130
  asm("mul.f32 %0, %1, %2;" : "=f"(f131) : "f"(f121), "f"(f130));
  // PTX:266 ld.global.f32 %f132, [%rd10+20]
  f132 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (20)))));
  // PTX:267 mul.f32 %f133, %f121, %f132
  asm("mul.f32 %0, %1, %2;" : "=f"(f133) : "f"(f121), "f"(f132));
  // PTX:268 ld.global.f32 %f134, [%rd10+24]
  f134 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (24)))));
  // PTX:269 mul.f32 %f135, %f121, %f134
  asm("mul.f32 %0, %1, %2;" : "=f"(f135) : "f"(f121), "f"(f134));
  // PTX:270 ld.global.f32 %f136, [%rd10+28]
  f136 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (28)))));
  // PTX:271 mul.f32 %f137, %f121, %f136
  asm("mul.f32 %0, %1, %2;" : "=f"(f137) : "f"(f121), "f"(f136));
  // PTX:272 ld.global.f32 %f138, [%rd10+32]
  f138 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (32)))));
  // PTX:273 mul.f32 %f139, %f121, %f138
  asm("mul.f32 %0, %1, %2;" : "=f"(f139) : "f"(f121), "f"(f138));
  // PTX:274 mul.wide.s32 %rd82, %r19, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd82) : "r"(r19));
  // PTX:275 add.s64 %rd83, %rd1, %rd82
  asm("add.s64 %0, %1, %2;" : "=l"(rd83) : "l"(rd1), "l"(rd82));
  // PTX:276 red.global.add.f32 [%rd83], %f123
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (0)))), (float)(f123));
  // PTX:277 add.s64 %rd84, %rd83, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd84) : "l"(rd83));
  // PTX:278 red.global.add.f32 [%rd84], %f125
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (0)))), (float)(f125));
  // PTX:279 add.s64 %rd85, %rd83, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd85) : "l"(rd83));
  // PTX:280 red.global.add.f32 [%rd85], %f127
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (0)))), (float)(f127));
  // PTX:281 add.s64 %rd86, %rd83, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd86) : "l"(rd83));
  // PTX:282 red.global.add.f32 [%rd86], %f129
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd86) + (0)))), (float)(f129));
  // PTX:283 add.s64 %rd87, %rd83, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd87) : "l"(rd83));
  // PTX:284 red.global.add.f32 [%rd87], %f131
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (0)))), (float)(f131));
  // PTX:285 add.s64 %rd88, %rd83, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd88) : "l"(rd83));
  // PTX:286 red.global.add.f32 [%rd88], %f133
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (0)))), (float)(f133));
  // PTX:287 add.s64 %rd89, %rd83, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd89) : "l"(rd83));
  // PTX:288 red.global.add.f32 [%rd89], %f135
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (0)))), (float)(f135));
  // PTX:289 add.s64 %rd90, %rd83, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd90) : "l"(rd83));
  // PTX:290 red.global.add.f32 [%rd90], %f137
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (0)))), (float)(f137));
  // PTX:291 add.s64 %rd91, %rd83, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd91) : "l"(rd83));
  // PTX:292 red.global.add.f32 [%rd91], %f139
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (0)))), (float)(f139));
  // PTX:293 fma.rn.f32 %f2, %f9, 0f3F000000, %f24
  asm("fma.rn.f32 %0, %1, 0f3F000000, %2;" : "=f"(f2) : "f"(f9), "f"(f24));
  // PTX:294 fma.rn.f32 %f3, %f12, 0f3F000000, %f25
  asm("fma.rn.f32 %0, %1, 0f3F000000, %2;" : "=f"(f3) : "f"(f12), "f"(f25));
  // PTX:295 fma.rn.f32 %f4, %f15, 0f3F000000, %f26
  asm("fma.rn.f32 %0, %1, 0f3F000000, %2;" : "=f"(f4) : "f"(f15), "f"(f26));
  // PTX:296 fma.rn.f32 %f5, %f18, 0f3F000000, %f27
  asm("fma.rn.f32 %0, %1, 0f3F000000, %2;" : "=f"(f5) : "f"(f18), "f"(f27));
  // PTX:297 setp.lt.s32 %p3, %r2, 0
  p3 = (((int)(r2)) < ((int)(0)));
  // PTX:298 @%p3 bra $L__BB38_6
  if (p3) { goto L_BB38_6; }
  // PTX:300 mul.wide.s32 %rd92, %r2, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd92) : "r"(r2));
  // PTX:301 add.s64 %rd93, %rd2, %rd92
  asm("add.s64 %0, %1, %2;" : "=l"(rd93) : "l"(rd2), "l"(rd92));
  // PTX:302 ld.global.u32 %r20, [%rd93+4]
  r20 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (4)))));
  // PTX:303 ld.global.u32 %r21, [%rd93+8]
  r21 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (8)))));
  // PTX:304 ld.global.u32 %r22, [%rd93+12]
  r22 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (12)))));
  // PTX:305 mul.f32 %f149, %f1, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f149) : "f"(f1), "f"(f2));
  // PTX:306 mul.f32 %f150, %f2, %f149
  asm("mul.f32 %0, %1, %2;" : "=f"(f150) : "f"(f2), "f"(f149));
  // PTX:307 ld.global.u32 %r23, [%rd93]
  r23 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (0)))));
  // PTX:308 add.s32 %r24, %r23, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r24) : "r"(r23), "r"(r1));
  // PTX:309 ld.global.f32 %f151, [%rd10]
  f151 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (0)))));
  // PTX:310 mul.f32 %f152, %f150, %f151
  asm("mul.f32 %0, %1, %2;" : "=f"(f152) : "f"(f150), "f"(f151));
  // PTX:311 ld.global.f32 %f153, [%rd10+4]
  f153 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (4)))));
  // PTX:312 mul.f32 %f154, %f150, %f153
  asm("mul.f32 %0, %1, %2;" : "=f"(f154) : "f"(f150), "f"(f153));
  // PTX:313 ld.global.f32 %f155, [%rd10+8]
  f155 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (8)))));
  // PTX:314 mul.f32 %f156, %f150, %f155
  asm("mul.f32 %0, %1, %2;" : "=f"(f156) : "f"(f150), "f"(f155));
  // PTX:315 ld.global.f32 %f157, [%rd10+12]
  f157 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (12)))));
  // PTX:316 mul.f32 %f158, %f150, %f157
  asm("mul.f32 %0, %1, %2;" : "=f"(f158) : "f"(f150), "f"(f157));
  // PTX:317 ld.global.f32 %f159, [%rd10+16]
  f159 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (16)))));
  // PTX:318 mul.f32 %f160, %f150, %f159
  asm("mul.f32 %0, %1, %2;" : "=f"(f160) : "f"(f150), "f"(f159));
  // PTX:319 ld.global.f32 %f161, [%rd10+20]
  f161 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (20)))));
  // PTX:320 mul.f32 %f162, %f150, %f161
  asm("mul.f32 %0, %1, %2;" : "=f"(f162) : "f"(f150), "f"(f161));
  // PTX:321 ld.global.f32 %f163, [%rd10+24]
  f163 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (24)))));
  // PTX:322 mul.f32 %f164, %f150, %f163
  asm("mul.f32 %0, %1, %2;" : "=f"(f164) : "f"(f150), "f"(f163));
  // PTX:323 ld.global.f32 %f165, [%rd10+28]
  f165 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (28)))));
  // PTX:324 mul.f32 %f166, %f150, %f165
  asm("mul.f32 %0, %1, %2;" : "=f"(f166) : "f"(f150), "f"(f165));
  // PTX:325 ld.global.f32 %f167, [%rd10+32]
  f167 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (32)))));
  // PTX:326 mul.f32 %f168, %f150, %f167
  asm("mul.f32 %0, %1, %2;" : "=f"(f168) : "f"(f150), "f"(f167));
  // PTX:327 mul.wide.s32 %rd94, %r24, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd94) : "r"(r24));
  // PTX:328 add.s64 %rd95, %rd1, %rd94
  asm("add.s64 %0, %1, %2;" : "=l"(rd95) : "l"(rd1), "l"(rd94));
  // PTX:329 red.global.add.f32 [%rd95], %f152
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd95) + (0)))), (float)(f152));
  // PTX:330 add.s64 %rd96, %rd95, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd96) : "l"(rd95));
  // PTX:331 red.global.add.f32 [%rd96], %f154
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (0)))), (float)(f154));
  // PTX:332 add.s64 %rd97, %rd95, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd97) : "l"(rd95));
  // PTX:333 red.global.add.f32 [%rd97], %f156
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd97) + (0)))), (float)(f156));
  // PTX:334 add.s64 %rd98, %rd95, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd98) : "l"(rd95));
  // PTX:335 red.global.add.f32 [%rd98], %f158
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (0)))), (float)(f158));
  // PTX:336 add.s64 %rd99, %rd95, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd99) : "l"(rd95));
  // PTX:337 red.global.add.f32 [%rd99], %f160
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (0)))), (float)(f160));
  // PTX:338 add.s64 %rd100, %rd95, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd100) : "l"(rd95));
  // PTX:339 red.global.add.f32 [%rd100], %f162
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (0)))), (float)(f162));
  // PTX:340 add.s64 %rd101, %rd95, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd101) : "l"(rd95));
  // PTX:341 red.global.add.f32 [%rd101], %f164
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd101) + (0)))), (float)(f164));
  // PTX:342 add.s64 %rd102, %rd95, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd102) : "l"(rd95));
  // PTX:343 red.global.add.f32 [%rd102], %f166
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd102) + (0)))), (float)(f166));
  // PTX:344 add.s64 %rd103, %rd95, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd103) : "l"(rd95));
  // PTX:345 red.global.add.f32 [%rd103], %f168
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd103) + (0)))), (float)(f168));
  // PTX:346 mul.f32 %f178, %f1, %f3
  asm("mul.f32 %0, %1, %2;" : "=f"(f178) : "f"(f1), "f"(f3));
  // PTX:347 mul.f32 %f179, %f3, %f178
  asm("mul.f32 %0, %1, %2;" : "=f"(f179) : "f"(f3), "f"(f178));
  // PTX:348 add.s32 %r25, %r20, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r25) : "r"(r20), "r"(r1));
  // PTX:349 ld.global.f32 %f180, [%rd10]
  f180 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (0)))));
  // PTX:350 mul.f32 %f181, %f179, %f180
  asm("mul.f32 %0, %1, %2;" : "=f"(f181) : "f"(f179), "f"(f180));
  // PTX:351 ld.global.f32 %f182, [%rd10+4]
  f182 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (4)))));
  // PTX:352 mul.f32 %f183, %f179, %f182
  asm("mul.f32 %0, %1, %2;" : "=f"(f183) : "f"(f179), "f"(f182));
  // PTX:353 ld.global.f32 %f184, [%rd10+8]
  f184 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (8)))));
  // PTX:354 mul.f32 %f185, %f179, %f184
  asm("mul.f32 %0, %1, %2;" : "=f"(f185) : "f"(f179), "f"(f184));
  // PTX:355 ld.global.f32 %f186, [%rd10+12]
  f186 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (12)))));
  // PTX:356 mul.f32 %f187, %f179, %f186
  asm("mul.f32 %0, %1, %2;" : "=f"(f187) : "f"(f179), "f"(f186));
  // PTX:357 ld.global.f32 %f188, [%rd10+16]
  f188 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (16)))));
  // PTX:358 mul.f32 %f189, %f179, %f188
  asm("mul.f32 %0, %1, %2;" : "=f"(f189) : "f"(f179), "f"(f188));
  // PTX:359 ld.global.f32 %f190, [%rd10+20]
  f190 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (20)))));
  // PTX:360 mul.f32 %f191, %f179, %f190
  asm("mul.f32 %0, %1, %2;" : "=f"(f191) : "f"(f179), "f"(f190));
  // PTX:361 ld.global.f32 %f192, [%rd10+24]
  f192 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (24)))));
  // PTX:362 mul.f32 %f193, %f179, %f192
  asm("mul.f32 %0, %1, %2;" : "=f"(f193) : "f"(f179), "f"(f192));
  // PTX:363 ld.global.f32 %f194, [%rd10+28]
  f194 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (28)))));
  // PTX:364 mul.f32 %f195, %f179, %f194
  asm("mul.f32 %0, %1, %2;" : "=f"(f195) : "f"(f179), "f"(f194));
  // PTX:365 ld.global.f32 %f196, [%rd10+32]
  f196 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (32)))));
  // PTX:366 mul.f32 %f197, %f179, %f196
  asm("mul.f32 %0, %1, %2;" : "=f"(f197) : "f"(f179), "f"(f196));
  // PTX:367 mul.wide.s32 %rd104, %r25, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd104) : "r"(r25));
  // PTX:368 add.s64 %rd105, %rd1, %rd104
  asm("add.s64 %0, %1, %2;" : "=l"(rd105) : "l"(rd1), "l"(rd104));
  // PTX:369 red.global.add.f32 [%rd105], %f181
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (0)))), (float)(f181));
  // PTX:370 add.s64 %rd106, %rd105, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd106) : "l"(rd105));
  // PTX:371 red.global.add.f32 [%rd106], %f183
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (0)))), (float)(f183));
  // PTX:372 add.s64 %rd107, %rd105, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd107) : "l"(rd105));
  // PTX:373 red.global.add.f32 [%rd107], %f185
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd107) + (0)))), (float)(f185));
  // PTX:374 add.s64 %rd108, %rd105, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd108) : "l"(rd105));
  // PTX:375 red.global.add.f32 [%rd108], %f187
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd108) + (0)))), (float)(f187));
  // PTX:376 add.s64 %rd109, %rd105, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd109) : "l"(rd105));
  // PTX:377 red.global.add.f32 [%rd109], %f189
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd109) + (0)))), (float)(f189));
  // PTX:378 add.s64 %rd110, %rd105, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd110) : "l"(rd105));
  // PTX:379 red.global.add.f32 [%rd110], %f191
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd110) + (0)))), (float)(f191));
  // PTX:380 add.s64 %rd111, %rd105, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd111) : "l"(rd105));
  // PTX:381 red.global.add.f32 [%rd111], %f193
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd111) + (0)))), (float)(f193));
  // PTX:382 add.s64 %rd112, %rd105, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd112) : "l"(rd105));
  // PTX:383 red.global.add.f32 [%rd112], %f195
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd112) + (0)))), (float)(f195));
  // PTX:384 add.s64 %rd113, %rd105, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd113) : "l"(rd105));
  // PTX:385 red.global.add.f32 [%rd113], %f197
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd113) + (0)))), (float)(f197));
  // PTX:386 mul.f32 %f207, %f1, %f4
  asm("mul.f32 %0, %1, %2;" : "=f"(f207) : "f"(f1), "f"(f4));
  // PTX:387 mul.f32 %f208, %f4, %f207
  asm("mul.f32 %0, %1, %2;" : "=f"(f208) : "f"(f4), "f"(f207));
  // PTX:388 add.s32 %r26, %r21, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r26) : "r"(r21), "r"(r1));
  // PTX:389 ld.global.f32 %f209, [%rd10]
  f209 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (0)))));
  // PTX:390 mul.f32 %f210, %f208, %f209
  asm("mul.f32 %0, %1, %2;" : "=f"(f210) : "f"(f208), "f"(f209));
  // PTX:391 ld.global.f32 %f211, [%rd10+4]
  f211 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (4)))));
  // PTX:392 mul.f32 %f212, %f208, %f211
  asm("mul.f32 %0, %1, %2;" : "=f"(f212) : "f"(f208), "f"(f211));
  // PTX:393 ld.global.f32 %f213, [%rd10+8]
  f213 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (8)))));
  // PTX:394 mul.f32 %f214, %f208, %f213
  asm("mul.f32 %0, %1, %2;" : "=f"(f214) : "f"(f208), "f"(f213));
  // PTX:395 ld.global.f32 %f215, [%rd10+12]
  f215 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (12)))));
  // PTX:396 mul.f32 %f216, %f208, %f215
  asm("mul.f32 %0, %1, %2;" : "=f"(f216) : "f"(f208), "f"(f215));
  // PTX:397 ld.global.f32 %f217, [%rd10+16]
  f217 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (16)))));
  // PTX:398 mul.f32 %f218, %f208, %f217
  asm("mul.f32 %0, %1, %2;" : "=f"(f218) : "f"(f208), "f"(f217));
  // PTX:399 ld.global.f32 %f219, [%rd10+20]
  f219 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (20)))));
  // PTX:400 mul.f32 %f220, %f208, %f219
  asm("mul.f32 %0, %1, %2;" : "=f"(f220) : "f"(f208), "f"(f219));
  // PTX:401 ld.global.f32 %f221, [%rd10+24]
  f221 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (24)))));
  // PTX:402 mul.f32 %f222, %f208, %f221
  asm("mul.f32 %0, %1, %2;" : "=f"(f222) : "f"(f208), "f"(f221));
  // PTX:403 ld.global.f32 %f223, [%rd10+28]
  f223 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (28)))));
  // PTX:404 mul.f32 %f224, %f208, %f223
  asm("mul.f32 %0, %1, %2;" : "=f"(f224) : "f"(f208), "f"(f223));
  // PTX:405 ld.global.f32 %f225, [%rd10+32]
  f225 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (32)))));
  // PTX:406 mul.f32 %f226, %f208, %f225
  asm("mul.f32 %0, %1, %2;" : "=f"(f226) : "f"(f208), "f"(f225));
  // PTX:407 mul.wide.s32 %rd114, %r26, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd114) : "r"(r26));
  // PTX:408 add.s64 %rd115, %rd1, %rd114
  asm("add.s64 %0, %1, %2;" : "=l"(rd115) : "l"(rd1), "l"(rd114));
  // PTX:409 red.global.add.f32 [%rd115], %f210
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd115) + (0)))), (float)(f210));
  // PTX:410 add.s64 %rd116, %rd115, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd116) : "l"(rd115));
  // PTX:411 red.global.add.f32 [%rd116], %f212
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd116) + (0)))), (float)(f212));
  // PTX:412 add.s64 %rd117, %rd115, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd117) : "l"(rd115));
  // PTX:413 red.global.add.f32 [%rd117], %f214
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd117) + (0)))), (float)(f214));
  // PTX:414 add.s64 %rd118, %rd115, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd118) : "l"(rd115));
  // PTX:415 red.global.add.f32 [%rd118], %f216
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd118) + (0)))), (float)(f216));
  // PTX:416 add.s64 %rd119, %rd115, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd119) : "l"(rd115));
  // PTX:417 red.global.add.f32 [%rd119], %f218
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd119) + (0)))), (float)(f218));
  // PTX:418 add.s64 %rd120, %rd115, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd120) : "l"(rd115));
  // PTX:419 red.global.add.f32 [%rd120], %f220
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd120) + (0)))), (float)(f220));
  // PTX:420 add.s64 %rd121, %rd115, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd121) : "l"(rd115));
  // PTX:421 red.global.add.f32 [%rd121], %f222
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd121) + (0)))), (float)(f222));
  // PTX:422 add.s64 %rd122, %rd115, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd122) : "l"(rd115));
  // PTX:423 red.global.add.f32 [%rd122], %f224
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd122) + (0)))), (float)(f224));
  // PTX:424 add.s64 %rd123, %rd115, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd123) : "l"(rd115));
  // PTX:425 red.global.add.f32 [%rd123], %f226
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd123) + (0)))), (float)(f226));
  // PTX:426 mul.f32 %f236, %f1, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f236) : "f"(f1), "f"(f5));
  // PTX:427 mul.f32 %f237, %f5, %f236
  asm("mul.f32 %0, %1, %2;" : "=f"(f237) : "f"(f5), "f"(f236));
  // PTX:428 add.s32 %r27, %r22, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r27) : "r"(r22), "r"(r1));
  // PTX:429 ld.global.f32 %f238, [%rd10]
  f238 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (0)))));
  // PTX:430 mul.f32 %f239, %f237, %f238
  asm("mul.f32 %0, %1, %2;" : "=f"(f239) : "f"(f237), "f"(f238));
  // PTX:431 ld.global.f32 %f240, [%rd10+4]
  f240 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (4)))));
  // PTX:432 mul.f32 %f241, %f237, %f240
  asm("mul.f32 %0, %1, %2;" : "=f"(f241) : "f"(f237), "f"(f240));
  // PTX:433 ld.global.f32 %f242, [%rd10+8]
  f242 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (8)))));
  // PTX:434 mul.f32 %f243, %f237, %f242
  asm("mul.f32 %0, %1, %2;" : "=f"(f243) : "f"(f237), "f"(f242));
  // PTX:435 ld.global.f32 %f244, [%rd10+12]
  f244 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (12)))));
  // PTX:436 mul.f32 %f245, %f237, %f244
  asm("mul.f32 %0, %1, %2;" : "=f"(f245) : "f"(f237), "f"(f244));
  // PTX:437 ld.global.f32 %f246, [%rd10+16]
  f246 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (16)))));
  // PTX:438 mul.f32 %f247, %f237, %f246
  asm("mul.f32 %0, %1, %2;" : "=f"(f247) : "f"(f237), "f"(f246));
  // PTX:439 ld.global.f32 %f248, [%rd10+20]
  f248 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (20)))));
  // PTX:440 mul.f32 %f249, %f237, %f248
  asm("mul.f32 %0, %1, %2;" : "=f"(f249) : "f"(f237), "f"(f248));
  // PTX:441 ld.global.f32 %f250, [%rd10+24]
  f250 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (24)))));
  // PTX:442 mul.f32 %f251, %f237, %f250
  asm("mul.f32 %0, %1, %2;" : "=f"(f251) : "f"(f237), "f"(f250));
  // PTX:443 ld.global.f32 %f252, [%rd10+28]
  f252 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (28)))));
  // PTX:444 mul.f32 %f253, %f237, %f252
  asm("mul.f32 %0, %1, %2;" : "=f"(f253) : "f"(f237), "f"(f252));
  // PTX:445 ld.global.f32 %f254, [%rd10+32]
  f254 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (32)))));
  // PTX:446 mul.f32 %f255, %f237, %f254
  asm("mul.f32 %0, %1, %2;" : "=f"(f255) : "f"(f237), "f"(f254));
  // PTX:447 mul.wide.s32 %rd124, %r27, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd124) : "r"(r27));
  // PTX:448 add.s64 %rd125, %rd1, %rd124
  asm("add.s64 %0, %1, %2;" : "=l"(rd125) : "l"(rd1), "l"(rd124));
  // PTX:449 red.global.add.f32 [%rd125], %f239
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd125) + (0)))), (float)(f239));
  // PTX:450 add.s64 %rd126, %rd125, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd126) : "l"(rd125));
  // PTX:451 red.global.add.f32 [%rd126], %f241
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd126) + (0)))), (float)(f241));
  // PTX:452 add.s64 %rd127, %rd125, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd127) : "l"(rd125));
  // PTX:453 red.global.add.f32 [%rd127], %f243
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd127) + (0)))), (float)(f243));
  // PTX:454 add.s64 %rd128, %rd125, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd128) : "l"(rd125));
  // PTX:455 red.global.add.f32 [%rd128], %f245
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd128) + (0)))), (float)(f245));
  // PTX:456 add.s64 %rd129, %rd125, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd129) : "l"(rd125));
  // PTX:457 red.global.add.f32 [%rd129], %f247
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd129) + (0)))), (float)(f247));
  // PTX:458 add.s64 %rd130, %rd125, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd130) : "l"(rd125));
  // PTX:459 red.global.add.f32 [%rd130], %f249
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd130) + (0)))), (float)(f249));
  // PTX:460 add.s64 %rd131, %rd125, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd131) : "l"(rd125));
  // PTX:461 red.global.add.f32 [%rd131], %f251
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd131) + (0)))), (float)(f251));
  // PTX:462 add.s64 %rd132, %rd125, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd132) : "l"(rd125));
  // PTX:463 red.global.add.f32 [%rd132], %f253
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd132) + (0)))), (float)(f253));
  // PTX:464 add.s64 %rd133, %rd125, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd133) : "l"(rd125));
  // PTX:465 red.global.add.f32 [%rd133], %f255
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd133) + (0)))), (float)(f255));
  // PTX:467 $L__BB38_6:
L_BB38_6:;
  // PTX:468 ret
  return;
}
