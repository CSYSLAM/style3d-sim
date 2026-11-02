// 机械还原自 PTX：synreal::kernel::update_joint_drive_angle_state(glm::vec<3, float, (glm::qualifier)0> const*, float*, int*, glm::vec<4, int, (glm::qualifier)0> const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: a8b3c693c02b627a05d0b2103a3e7cd545005c18508704794ec8154bb1337494
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__update_joint_drive_angle_state(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10, unsigned long long param11, unsigned long long param12, unsigned long long param13, unsigned long long param14, unsigned long long param15, unsigned long long param16) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85;
  // PTX:33 ld.param.u64 %rd26, [_ZN7synreal6kernel30update_joint_drive_angle_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESJ_SJ_SJ_SJ_mmm_param_0]
  rd26 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:34 ld.param.u64 %rd12, [_ZN7synreal6kernel30update_joint_drive_angle_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESJ_SJ_SJ_SJ_mmm_param_1]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:35 ld.param.u64 %rd13, [_ZN7synreal6kernel30update_joint_drive_angle_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESJ_SJ_SJ_SJ_mmm_param_2]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:36 ld.param.u64 %rd27, [_ZN7synreal6kernel30update_joint_drive_angle_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESJ_SJ_SJ_SJ_mmm_param_3]
  rd27 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:37 ld.param.u64 %rd14, [_ZN7synreal6kernel30update_joint_drive_angle_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESJ_SJ_SJ_SJ_mmm_param_4]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:38 ld.param.u64 %rd15, [_ZN7synreal6kernel30update_joint_drive_angle_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESJ_SJ_SJ_SJ_mmm_param_5]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:39 ld.param.u64 %rd16, [_ZN7synreal6kernel30update_joint_drive_angle_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESJ_SJ_SJ_SJ_mmm_param_6]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:40 ld.param.u64 %rd17, [_ZN7synreal6kernel30update_joint_drive_angle_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESJ_SJ_SJ_SJ_mmm_param_7]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:41 ld.param.u64 %rd18, [_ZN7synreal6kernel30update_joint_drive_angle_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESJ_SJ_SJ_SJ_mmm_param_8]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:42 ld.param.u64 %rd19, [_ZN7synreal6kernel30update_joint_drive_angle_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESJ_SJ_SJ_SJ_mmm_param_9]
  rd19 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:43 ld.param.u64 %rd20, [_ZN7synreal6kernel30update_joint_drive_angle_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESJ_SJ_SJ_SJ_mmm_param_10]
  rd20 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:44 ld.param.u64 %rd21, [_ZN7synreal6kernel30update_joint_drive_angle_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESJ_SJ_SJ_SJ_mmm_param_11]
  rd21 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:45 ld.param.u64 %rd22, [_ZN7synreal6kernel30update_joint_drive_angle_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESJ_SJ_SJ_SJ_mmm_param_12]
  rd22 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:46 ld.param.u64 %rd23, [_ZN7synreal6kernel30update_joint_drive_angle_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESJ_SJ_SJ_SJ_mmm_param_13]
  rd23 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:47 ld.param.u64 %rd28, [_ZN7synreal6kernel30update_joint_drive_angle_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESJ_SJ_SJ_SJ_mmm_param_14]
  rd28 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:48 ld.param.u64 %rd24, [_ZN7synreal6kernel30update_joint_drive_angle_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESJ_SJ_SJ_SJ_mmm_param_15]
  rd24 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param15 + (0))));
  // PTX:49 ld.param.u64 %rd25, [_ZN7synreal6kernel30update_joint_drive_angle_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESJ_SJ_SJ_SJ_mmm_param_16]
  rd25 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param16 + (0))));
  // PTX:50 cvta.to.global.u64 %rd1, %rd26
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd26));
  // PTX:51 cvta.to.global.u64 %rd2, %rd27
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd27));
  // PTX:52 mov.u32 %r34, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r34) : "r"(blockIdx.x));
  // PTX:53 mov.u32 %r35, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r35) : "r"(blockDim.x));
  // PTX:54 mul.wide.u32 %rd29, %r34, %r35
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd29) : "r"(r34), "r"(r35));
  // PTX:55 mov.u32 %r36, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r36) : "r"(threadIdx.x));
  // PTX:56 cvt.u64.u32 %rd30, %r36
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd30) : "r"(r36));
  // PTX:57 add.s64 %rd3, %rd29, %rd30
  asm("add.s64 %0, %1, %2;" : "=l"(rd3) : "l"(rd29), "l"(rd30));
  // PTX:58 setp.ge.u64 %p1, %rd3, %rd28
  p1 = (((unsigned long long)(rd3)) >= ((unsigned long long)(rd28)));
  // PTX:59 @%p1 bra $L__BB31_25
  if (p1) { goto L_BB31_25; }
  // PTX:61 or.b64 %rd31, %rd3, %rd24
  asm("or.b64 %0, %1, %2;" : "=l"(rd31) : "l"(rd3), "l"(rd24));
  // PTX:62 and.b64 %rd32, %rd31, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd32) : "l"(rd31));
  // PTX:63 setp.eq.s64 %p2, %rd32, 0
  p2 = (((long long)(rd32)) == ((long long)(0)));
  // PTX:64 @%p2 bra $L__BB31_3
  if (p2) { goto L_BB31_3; }
  // PTX:66 rem.u64 %rd84, %rd3, %rd24
  asm("rem.u64 %0, %1, %2;" : "=l"(rd84) : "l"(rd3), "l"(rd24));
  // PTX:67 bra.uni $L__BB31_4
  goto L_BB31_4;
  // PTX:69 $L__BB31_3:
L_BB31_3:;
  // PTX:70 cvt.u32.u64 %r37, %rd24
  asm("cvt.u32.u64 %0, %1;" : "=r"(r37) : "l"(rd24));
  // PTX:71 cvt.u32.u64 %r38, %rd3
  asm("cvt.u32.u64 %0, %1;" : "=r"(r38) : "l"(rd3));
  // PTX:72 rem.u32 %r39, %r38, %r37
  asm("rem.u32 %0, %1, %2;" : "=r"(r39) : "r"(r38), "r"(r37));
  // PTX:73 cvt.u64.u32 %rd84, %r39
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd84) : "r"(r39));
  // PTX:75 $L__BB31_4:
L_BB31_4:;
  // PTX:76 cvta.to.global.u64 %rd33, %rd14
  rd33 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd14));
  // PTX:77 shl.b64 %rd34, %rd84, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd34) : "l"(rd84));
  // PTX:78 add.s64 %rd35, %rd33, %rd34
  asm("add.s64 %0, %1, %2;" : "=l"(rd35) : "l"(rd33), "l"(rd34));
  // PTX:79 ld.global.u32 %r40, [%rd35]
  r40 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (0)))));
  // PTX:80 setp.ne.s32 %p3, %r40, 1
  p3 = (((int)(r40)) != ((int)(1)));
  // PTX:81 @%p3 bra $L__BB31_25
  if (p3) { goto L_BB31_25; }
  // PTX:83 @%p2 bra $L__BB31_7
  if (p2) { goto L_BB31_7; }
  // PTX:85 div.u64 %rd85, %rd3, %rd24
  asm("div.u64 %0, %1, %2;" : "=l"(rd85) : "l"(rd3), "l"(rd24));
  // PTX:86 bra.uni $L__BB31_8
  goto L_BB31_8;
  // PTX:88 $L__BB31_7:
L_BB31_7:;
  // PTX:89 cvt.u32.u64 %r41, %rd24
  asm("cvt.u32.u64 %0, %1;" : "=r"(r41) : "l"(rd24));
  // PTX:90 cvt.u32.u64 %r42, %rd3
  asm("cvt.u32.u64 %0, %1;" : "=r"(r42) : "l"(rd3));
  // PTX:91 div.u32 %r43, %r42, %r41
  asm("div.u32 %0, %1, %2;" : "=r"(r43) : "r"(r42), "r"(r41));
  // PTX:92 cvt.u64.u32 %rd85, %r43
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd85) : "r"(r43));
  // PTX:94 $L__BB31_8:
L_BB31_8:;
  // PTX:95 mul.lo.s64 %rd38, %rd85, %rd25
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd38) : "l"(rd85), "l"(rd25));
  // PTX:96 cvt.u32.u64 %r1, %rd38
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd38));
  // PTX:97 cvta.to.global.u64 %rd39, %rd15
  rd39 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd15));
  // PTX:98 shl.b64 %rd40, %rd84, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd40) : "l"(rd84));
  // PTX:99 add.s64 %rd41, %rd39, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd41) : "l"(rd39), "l"(rd40));
  // PTX:100 ld.global.u32 %r2, [%rd41]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (0)))));
  // PTX:101 ld.global.u32 %r44, [%rd41+4]
  r44 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (4)))));
  // PTX:102 mul.wide.s32 %rd42, %r44, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd42) : "r"(r44));
  // PTX:103 add.s64 %rd43, %rd2, %rd42
  asm("add.s64 %0, %1, %2;" : "=l"(rd43) : "l"(rd2), "l"(rd42));
  // PTX:104 ld.global.u32 %r3, [%rd43]
  r3 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (0)))));
  // PTX:105 ld.global.u32 %r4, [%rd43+4]
  r4 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (4)))));
  // PTX:106 ld.global.u32 %r5, [%rd43+8]
  r5 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (8)))));
  // PTX:107 ld.global.u32 %r6, [%rd43+12]
  r6 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (12)))));
  // PTX:108 cvta.to.global.u64 %rd44, %rd16
  rd44 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd16));
  // PTX:109 mul.lo.s64 %rd45, %rd84, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd45) : "l"(rd84));
  // PTX:110 add.s64 %rd46, %rd44, %rd45
  asm("add.s64 %0, %1, %2;" : "=l"(rd46) : "l"(rd44), "l"(rd45));
  // PTX:111 ld.global.u32 %r80, [%rd46+8]
  r80 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (8)))));
  // PTX:112 ld.global.u32 %r79, [%rd46+4]
  r79 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (4)))));
  // PTX:113 ld.global.u32 %r78, [%rd46]
  r78 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (0)))));
  // PTX:114 cvta.to.global.u64 %rd47, %rd17
  rd47 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd17));
  // PTX:115 add.s64 %rd48, %rd47, %rd45
  asm("add.s64 %0, %1, %2;" : "=l"(rd48) : "l"(rd47), "l"(rd45));
  // PTX:116 ld.global.u32 %r83, [%rd48+8]
  r83 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (8)))));
  // PTX:117 ld.global.u32 %r82, [%rd48+4]
  r82 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (4)))));
  // PTX:118 ld.global.u32 %r81, [%rd48]
  r81 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))));
  // PTX:119 cvta.to.global.u64 %rd49, %rd18
  rd49 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd18));
  // PTX:120 add.s64 %rd50, %rd49, %rd45
  asm("add.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd49), "l"(rd45));
  // PTX:121 ld.global.u32 %r86, [%rd50+8]
  r86 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (8)))));
  // PTX:122 ld.global.u32 %r85, [%rd50+4]
  r85 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (4)))));
  // PTX:123 ld.global.u32 %r84, [%rd50]
  r84 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (0)))));
  // PTX:124 setp.lt.s32 %p5, %r2, 0
  p5 = (((int)(r2)) < ((int)(0)));
  // PTX:125 @%p5 bra $L__BB31_10
  if (p5) { goto L_BB31_10; }
  // PTX:127 mul.wide.s32 %rd51, %r2, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd51) : "r"(r2));
  // PTX:128 add.s64 %rd52, %rd2, %rd51
  asm("add.s64 %0, %1, %2;" : "=l"(rd52) : "l"(rd2), "l"(rd51));
  // PTX:129 ld.global.u32 %r45, [%rd52]
  r45 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))));
  // PTX:130 add.s32 %r46, %r45, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r46) : "r"(r45), "r"(r1));
  // PTX:131 ld.global.u32 %r47, [%rd52+4]
  r47 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (4)))));
  // PTX:132 add.s32 %r48, %r47, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r48) : "r"(r47), "r"(r1));
  // PTX:133 ld.global.u32 %r49, [%rd52+8]
  r49 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (8)))));
  // PTX:134 add.s32 %r50, %r49, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r50) : "r"(r49), "r"(r1));
  // PTX:135 ld.global.u32 %r51, [%rd52+12]
  r51 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (12)))));
  // PTX:136 add.s32 %r52, %r51, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r52) : "r"(r51), "r"(r1));
  // PTX:137 cvta.to.global.u64 %rd53, %rd19
  rd53 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd19));
  // PTX:138 shl.b64 %rd54, %rd84, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd54) : "l"(rd84));
  // PTX:139 add.s64 %rd55, %rd53, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd55) : "l"(rd53), "l"(rd54));
  // PTX:140 mul.wide.s32 %rd56, %r46, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd56) : "r"(r46));
  // PTX:141 add.s64 %rd57, %rd1, %rd56
  asm("add.s64 %0, %1, %2;" : "=l"(rd57) : "l"(rd1), "l"(rd56));
  // PTX:142 ld.global.f32 %f36, [%rd57]
  f36 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))));
  // PTX:143 ld.global.f32 %f37, [%rd55]
  f37 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))));
  // PTX:144 ld.global.f32 %f38, [%rd57+4]
  f38 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (4)))));
  // PTX:145 ld.global.f32 %f39, [%rd57+8]
  f39 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (8)))));
  // PTX:146 mul.wide.s32 %rd58, %r48, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd58) : "r"(r48));
  // PTX:147 add.s64 %rd59, %rd1, %rd58
  asm("add.s64 %0, %1, %2;" : "=l"(rd59) : "l"(rd1), "l"(rd58));
  // PTX:148 ld.global.f32 %f40, [%rd59]
  f40 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))));
  // PTX:149 ld.global.f32 %f41, [%rd55+4]
  f41 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (4)))));
  // PTX:150 mul.f32 %f42, %f41, %f40
  asm("mul.f32 %0, %1, %2;" : "=f"(f42) : "f"(f41), "f"(f40));
  // PTX:151 ld.global.f32 %f43, [%rd59+4]
  f43 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (4)))));
  // PTX:152 mul.f32 %f44, %f41, %f43
  asm("mul.f32 %0, %1, %2;" : "=f"(f44) : "f"(f41), "f"(f43));
  // PTX:153 ld.global.f32 %f45, [%rd59+8]
  f45 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (8)))));
  // PTX:154 mul.f32 %f46, %f41, %f45
  asm("mul.f32 %0, %1, %2;" : "=f"(f46) : "f"(f41), "f"(f45));
  // PTX:155 fma.rn.f32 %f47, %f37, %f36, %f42
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f47) : "f"(f37), "f"(f36), "f"(f42));
  // PTX:156 fma.rn.f32 %f48, %f37, %f38, %f44
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f48) : "f"(f37), "f"(f38), "f"(f44));
  // PTX:157 fma.rn.f32 %f49, %f37, %f39, %f46
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f49) : "f"(f37), "f"(f39), "f"(f46));
  // PTX:158 mul.wide.s32 %rd60, %r50, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd60) : "r"(r50));
  // PTX:159 add.s64 %rd61, %rd1, %rd60
  asm("add.s64 %0, %1, %2;" : "=l"(rd61) : "l"(rd1), "l"(rd60));
  // PTX:160 ld.global.f32 %f50, [%rd61]
  f50 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))));
  // PTX:161 ld.global.f32 %f51, [%rd55+8]
  f51 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (8)))));
  // PTX:162 ld.global.f32 %f52, [%rd61+4]
  f52 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (4)))));
  // PTX:163 ld.global.f32 %f53, [%rd61+8]
  f53 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (8)))));
  // PTX:164 fma.rn.f32 %f54, %f51, %f50, %f47
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f54) : "f"(f51), "f"(f50), "f"(f47));
  // PTX:165 fma.rn.f32 %f55, %f51, %f52, %f48
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f55) : "f"(f51), "f"(f52), "f"(f48));
  // PTX:166 fma.rn.f32 %f56, %f51, %f53, %f49
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f56) : "f"(f51), "f"(f53), "f"(f49));
  // PTX:167 mul.wide.s32 %rd62, %r52, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd62) : "r"(r52));
  // PTX:168 add.s64 %rd63, %rd1, %rd62
  asm("add.s64 %0, %1, %2;" : "=l"(rd63) : "l"(rd1), "l"(rd62));
  // PTX:169 ld.global.f32 %f57, [%rd63]
  f57 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (0)))));
  // PTX:170 ld.global.f32 %f58, [%rd55+12]
  f58 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (12)))));
  // PTX:171 ld.global.f32 %f59, [%rd63+4]
  f59 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (4)))));
  // PTX:172 ld.global.f32 %f60, [%rd63+8]
  f60 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (8)))));
  // PTX:173 fma.rn.f32 %f61, %f58, %f57, %f54
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f61) : "f"(f58), "f"(f57), "f"(f54));
  // PTX:174 fma.rn.f32 %f62, %f58, %f59, %f55
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f62) : "f"(f58), "f"(f59), "f"(f55));
  // PTX:175 fma.rn.f32 %f63, %f58, %f60, %f56
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f63) : "f"(f58), "f"(f60), "f"(f56));
  // PTX:176 mov.b32 %r80, %f63
  asm("mov.b32 %0, %1;" : "=r"(r80) : "f"(f63));
  // PTX:177 mov.b32 %r79, %f62
  asm("mov.b32 %0, %1;" : "=r"(r79) : "f"(f62));
  // PTX:178 mov.b32 %r78, %f61
  asm("mov.b32 %0, %1;" : "=r"(r78) : "f"(f61));
  // PTX:179 cvta.to.global.u64 %rd64, %rd21
  rd64 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd21));
  // PTX:180 add.s64 %rd65, %rd64, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd65) : "l"(rd64), "l"(rd54));
  // PTX:181 ld.global.f32 %f64, [%rd65]
  f64 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (0)))));
  // PTX:182 ld.global.f32 %f65, [%rd65+4]
  f65 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (4)))));
  // PTX:183 mul.f32 %f66, %f65, %f40
  asm("mul.f32 %0, %1, %2;" : "=f"(f66) : "f"(f65), "f"(f40));
  // PTX:184 mul.f32 %f67, %f65, %f43
  asm("mul.f32 %0, %1, %2;" : "=f"(f67) : "f"(f65), "f"(f43));
  // PTX:185 mul.f32 %f68, %f65, %f45
  asm("mul.f32 %0, %1, %2;" : "=f"(f68) : "f"(f65), "f"(f45));
  // PTX:186 fma.rn.f32 %f69, %f64, %f36, %f66
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f69) : "f"(f64), "f"(f36), "f"(f66));
  // PTX:187 fma.rn.f32 %f70, %f64, %f38, %f67
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f70) : "f"(f64), "f"(f38), "f"(f67));
  // PTX:188 fma.rn.f32 %f71, %f64, %f39, %f68
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f71) : "f"(f64), "f"(f39), "f"(f68));
  // PTX:189 ld.global.f32 %f72, [%rd65+8]
  f72 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (8)))));
  // PTX:190 fma.rn.f32 %f73, %f72, %f50, %f69
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f73) : "f"(f72), "f"(f50), "f"(f69));
  // PTX:191 fma.rn.f32 %f74, %f72, %f52, %f70
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f74) : "f"(f72), "f"(f52), "f"(f70));
  // PTX:192 fma.rn.f32 %f75, %f72, %f53, %f71
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f75) : "f"(f72), "f"(f53), "f"(f71));
  // PTX:193 ld.global.f32 %f76, [%rd65+12]
  f76 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (12)))));
  // PTX:194 fma.rn.f32 %f77, %f76, %f57, %f73
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f77) : "f"(f76), "f"(f57), "f"(f73));
  // PTX:195 fma.rn.f32 %f78, %f76, %f59, %f74
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f78) : "f"(f76), "f"(f59), "f"(f74));
  // PTX:196 fma.rn.f32 %f79, %f76, %f60, %f75
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f79) : "f"(f76), "f"(f60), "f"(f75));
  // PTX:197 mov.b32 %r83, %f79
  asm("mov.b32 %0, %1;" : "=r"(r83) : "f"(f79));
  // PTX:198 mov.b32 %r82, %f78
  asm("mov.b32 %0, %1;" : "=r"(r82) : "f"(f78));
  // PTX:199 mov.b32 %r81, %f77
  asm("mov.b32 %0, %1;" : "=r"(r81) : "f"(f77));
  // PTX:200 cvta.to.global.u64 %rd66, %rd22
  rd66 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd22));
  // PTX:201 add.s64 %rd67, %rd66, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd67) : "l"(rd66), "l"(rd54));
  // PTX:202 ld.global.f32 %f80, [%rd67]
  f80 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0)))));
  // PTX:203 ld.global.f32 %f81, [%rd67+4]
  f81 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (4)))));
  // PTX:204 mul.f32 %f82, %f81, %f40
  asm("mul.f32 %0, %1, %2;" : "=f"(f82) : "f"(f81), "f"(f40));
  // PTX:205 mul.f32 %f83, %f81, %f43
  asm("mul.f32 %0, %1, %2;" : "=f"(f83) : "f"(f81), "f"(f43));
  // PTX:206 mul.f32 %f84, %f81, %f45
  asm("mul.f32 %0, %1, %2;" : "=f"(f84) : "f"(f81), "f"(f45));
  // PTX:207 fma.rn.f32 %f85, %f80, %f36, %f82
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f85) : "f"(f80), "f"(f36), "f"(f82));
  // PTX:208 fma.rn.f32 %f86, %f80, %f38, %f83
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f86) : "f"(f80), "f"(f38), "f"(f83));
  // PTX:209 fma.rn.f32 %f87, %f80, %f39, %f84
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f87) : "f"(f80), "f"(f39), "f"(f84));
  // PTX:210 ld.global.f32 %f88, [%rd67+8]
  f88 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (8)))));
  // PTX:211 fma.rn.f32 %f89, %f88, %f50, %f85
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f89) : "f"(f88), "f"(f50), "f"(f85));
  // PTX:212 fma.rn.f32 %f90, %f88, %f52, %f86
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f90) : "f"(f88), "f"(f52), "f"(f86));
  // PTX:213 fma.rn.f32 %f91, %f88, %f53, %f87
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f91) : "f"(f88), "f"(f53), "f"(f87));
  // PTX:214 ld.global.f32 %f92, [%rd67+12]
  f92 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (12)))));
  // PTX:215 fma.rn.f32 %f93, %f92, %f57, %f89
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f93) : "f"(f92), "f"(f57), "f"(f89));
  // PTX:216 fma.rn.f32 %f94, %f92, %f59, %f90
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f94) : "f"(f92), "f"(f59), "f"(f90));
  // PTX:217 fma.rn.f32 %f95, %f92, %f60, %f91
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f95) : "f"(f92), "f"(f60), "f"(f91));
  // PTX:218 mov.b32 %r86, %f95
  asm("mov.b32 %0, %1;" : "=r"(r86) : "f"(f95));
  // PTX:219 mov.b32 %r85, %f94
  asm("mov.b32 %0, %1;" : "=r"(r85) : "f"(f94));
  // PTX:220 mov.b32 %r84, %f93
  asm("mov.b32 %0, %1;" : "=r"(r84) : "f"(f93));
  // PTX:222 $L__BB31_10:
L_BB31_10:;
  // PTX:223 cvta.to.global.u64 %rd68, %rd20
  rd68 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd20));
  // PTX:224 shl.b64 %rd69, %rd84, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd69) : "l"(rd84));
  // PTX:225 add.s64 %rd70, %rd68, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd70) : "l"(rd68), "l"(rd69));
  // PTX:226 add.s32 %r53, %r3, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r53) : "r"(r3), "r"(r1));
  // PTX:227 mul.wide.s32 %rd71, %r53, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd71) : "r"(r53));
  // PTX:228 add.s64 %rd72, %rd1, %rd71
  asm("add.s64 %0, %1, %2;" : "=l"(rd72) : "l"(rd1), "l"(rd71));
  // PTX:229 ld.global.f32 %f96, [%rd72]
  f96 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (0)))));
  // PTX:230 ld.global.f32 %f97, [%rd70]
  f97 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0)))));
  // PTX:231 ld.global.f32 %f98, [%rd72+4]
  f98 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (4)))));
  // PTX:232 ld.global.f32 %f99, [%rd72+8]
  f99 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (8)))));
  // PTX:233 add.s32 %r54, %r4, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r54) : "r"(r4), "r"(r1));
  // PTX:234 mul.wide.s32 %rd73, %r54, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd73) : "r"(r54));
  // PTX:235 add.s64 %rd74, %rd1, %rd73
  asm("add.s64 %0, %1, %2;" : "=l"(rd74) : "l"(rd1), "l"(rd73));
  // PTX:236 ld.global.f32 %f100, [%rd74]
  f100 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (0)))));
  // PTX:237 ld.global.f32 %f101, [%rd70+4]
  f101 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (4)))));
  // PTX:238 mul.f32 %f102, %f101, %f100
  asm("mul.f32 %0, %1, %2;" : "=f"(f102) : "f"(f101), "f"(f100));
  // PTX:239 ld.global.f32 %f103, [%rd74+4]
  f103 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (4)))));
  // PTX:240 mul.f32 %f104, %f101, %f103
  asm("mul.f32 %0, %1, %2;" : "=f"(f104) : "f"(f101), "f"(f103));
  // PTX:241 ld.global.f32 %f105, [%rd74+8]
  f105 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (8)))));
  // PTX:242 mul.f32 %f106, %f101, %f105
  asm("mul.f32 %0, %1, %2;" : "=f"(f106) : "f"(f101), "f"(f105));
  // PTX:243 fma.rn.f32 %f107, %f97, %f96, %f102
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f107) : "f"(f97), "f"(f96), "f"(f102));
  // PTX:244 fma.rn.f32 %f108, %f97, %f98, %f104
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f108) : "f"(f97), "f"(f98), "f"(f104));
  // PTX:245 fma.rn.f32 %f109, %f97, %f99, %f106
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f109) : "f"(f97), "f"(f99), "f"(f106));
  // PTX:246 add.s32 %r55, %r5, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r55) : "r"(r5), "r"(r1));
  // PTX:247 mul.wide.s32 %rd75, %r55, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd75) : "r"(r55));
  // PTX:248 add.s64 %rd76, %rd1, %rd75
  asm("add.s64 %0, %1, %2;" : "=l"(rd76) : "l"(rd1), "l"(rd75));
  // PTX:249 ld.global.f32 %f110, [%rd76]
  f110 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (0)))));
  // PTX:250 ld.global.f32 %f111, [%rd70+8]
  f111 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (8)))));
  // PTX:251 ld.global.f32 %f112, [%rd76+4]
  f112 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (4)))));
  // PTX:252 ld.global.f32 %f113, [%rd76+8]
  f113 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (8)))));
  // PTX:253 fma.rn.f32 %f114, %f111, %f110, %f107
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f114) : "f"(f111), "f"(f110), "f"(f107));
  // PTX:254 fma.rn.f32 %f115, %f111, %f112, %f108
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f115) : "f"(f111), "f"(f112), "f"(f108));
  // PTX:255 fma.rn.f32 %f116, %f111, %f113, %f109
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f116) : "f"(f111), "f"(f113), "f"(f109));
  // PTX:256 add.s32 %r56, %r6, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r56) : "r"(r6), "r"(r1));
  // PTX:257 mul.wide.s32 %rd77, %r56, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd77) : "r"(r56));
  // PTX:258 add.s64 %rd78, %rd1, %rd77
  asm("add.s64 %0, %1, %2;" : "=l"(rd78) : "l"(rd1), "l"(rd77));
  // PTX:259 ld.global.f32 %f117, [%rd78]
  f117 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd78) + (0)))));
  // PTX:260 ld.global.f32 %f118, [%rd70+12]
  f118 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (12)))));
  // PTX:261 ld.global.f32 %f119, [%rd78+4]
  f119 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd78) + (4)))));
  // PTX:262 ld.global.f32 %f120, [%rd78+8]
  f120 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd78) + (8)))));
  // PTX:263 fma.rn.f32 %f1, %f118, %f117, %f114
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1) : "f"(f118), "f"(f117), "f"(f114));
  // PTX:264 fma.rn.f32 %f2, %f118, %f119, %f115
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f2) : "f"(f118), "f"(f119), "f"(f115));
  // PTX:265 fma.rn.f32 %f3, %f118, %f120, %f116
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f3) : "f"(f118), "f"(f120), "f"(f116));
  // PTX:266 cvta.to.global.u64 %rd79, %rd23
  rd79 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd23));
  // PTX:267 add.s64 %rd80, %rd79, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd80) : "l"(rd79), "l"(rd69));
  // PTX:268 ld.global.f32 %f121, [%rd80]
  f121 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (0)))));
  // PTX:269 ld.global.f32 %f122, [%rd80+4]
  f122 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (4)))));
  // PTX:270 mul.f32 %f123, %f122, %f100
  asm("mul.f32 %0, %1, %2;" : "=f"(f123) : "f"(f122), "f"(f100));
  // PTX:271 mul.f32 %f124, %f122, %f103
  asm("mul.f32 %0, %1, %2;" : "=f"(f124) : "f"(f122), "f"(f103));
  // PTX:272 mul.f32 %f125, %f122, %f105
  asm("mul.f32 %0, %1, %2;" : "=f"(f125) : "f"(f122), "f"(f105));
  // PTX:273 fma.rn.f32 %f126, %f121, %f96, %f123
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f126) : "f"(f121), "f"(f96), "f"(f123));
  // PTX:274 fma.rn.f32 %f127, %f121, %f98, %f124
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f127) : "f"(f121), "f"(f98), "f"(f124));
  // PTX:275 fma.rn.f32 %f128, %f121, %f99, %f125
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f128) : "f"(f121), "f"(f99), "f"(f125));
  // PTX:276 ld.global.f32 %f129, [%rd80+8]
  f129 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (8)))));
  // PTX:277 fma.rn.f32 %f130, %f129, %f110, %f126
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f130) : "f"(f129), "f"(f110), "f"(f126));
  // PTX:278 fma.rn.f32 %f131, %f129, %f112, %f127
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f131) : "f"(f129), "f"(f112), "f"(f127));
  // PTX:279 fma.rn.f32 %f132, %f129, %f113, %f128
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f132) : "f"(f129), "f"(f113), "f"(f128));
  // PTX:280 ld.global.f32 %f133, [%rd80+12]
  f133 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (12)))));
  // PTX:281 fma.rn.f32 %f4, %f133, %f117, %f130
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f4) : "f"(f133), "f"(f117), "f"(f130));
  // PTX:282 fma.rn.f32 %f5, %f133, %f119, %f131
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f5) : "f"(f133), "f"(f119), "f"(f131));
  // PTX:283 fma.rn.f32 %f6, %f133, %f120, %f132
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f6) : "f"(f133), "f"(f120), "f"(f132));
  // PTX:284 mov.b32 %f134, %r81
  asm("mov.b32 %0, %1;" : "=f"(f134) : "r"(r81));
  // PTX:285 mov.b32 %f7, %r78
  asm("mov.b32 %0, %1;" : "=f"(f7) : "r"(r78));
  // PTX:286 sub.f32 %f8, %f134, %f7
  asm("sub.f32 %0, %1, %2;" : "=f"(f8) : "f"(f134), "f"(f7));
  // PTX:287 mov.b32 %f135, %r82
  asm("mov.b32 %0, %1;" : "=f"(f135) : "r"(r82));
  // PTX:288 mov.b32 %f9, %r79
  asm("mov.b32 %0, %1;" : "=f"(f9) : "r"(r79));
  // PTX:289 sub.f32 %f10, %f135, %f9
  asm("sub.f32 %0, %1, %2;" : "=f"(f10) : "f"(f135), "f"(f9));
  // PTX:290 mov.b32 %f136, %r83
  asm("mov.b32 %0, %1;" : "=f"(f136) : "r"(r83));
  // PTX:291 mov.b32 %f11, %r80
  asm("mov.b32 %0, %1;" : "=f"(f11) : "r"(r80));
  // PTX:292 sub.f32 %f12, %f136, %f11
  asm("sub.f32 %0, %1, %2;" : "=f"(f12) : "f"(f136), "f"(f11));
  // PTX:293 mul.f32 %f137, %f10, %f10
  asm("mul.f32 %0, %1, %2;" : "=f"(f137) : "f"(f10), "f"(f10));
  // PTX:294 fma.rn.f32 %f138, %f8, %f8, %f137
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f138) : "f"(f8), "f"(f8), "f"(f137));
  // PTX:295 fma.rn.f32 %f139, %f12, %f12, %f138
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f139) : "f"(f12), "f"(f12), "f"(f138));
  // PTX:296 sqrt.rn.f32 %f13, %f139
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f13) : "f"(f139));
  // PTX:297 setp.leu.f32 %p6, %f13, 0f322BCC77
  p6 = ((isnan(((float)(f13))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f13)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:298 @%p6 bra $L__BB31_25
  if (p6) { goto L_BB31_25; }
  // PTX:300 abs.f32 %f140, %f13
  asm("abs.f32 %0, %1;" : "=f"(f140) : "f"(f13));
  // PTX:301 setp.geu.f32 %p7, %f140, 0f7F800000
  p7 = ((isnan(((float)(f140))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f140)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:302 @%p7 bra $L__BB31_25
  if (p7) { goto L_BB31_25; }
  // PTX:304 div.rn.f32 %f14, %f8, %f13
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f14) : "f"(f8), "f"(f13));
  // PTX:305 mov.b32 %f141, %r84
  asm("mov.b32 %0, %1;" : "=f"(f141) : "r"(r84));
  // PTX:306 sub.f32 %f142, %f141, %f7
  asm("sub.f32 %0, %1, %2;" : "=f"(f142) : "f"(f141), "f"(f7));
  // PTX:307 mov.b32 %f143, %r85
  asm("mov.b32 %0, %1;" : "=f"(f143) : "r"(r85));
  // PTX:308 sub.f32 %f144, %f143, %f9
  asm("sub.f32 %0, %1, %2;" : "=f"(f144) : "f"(f143), "f"(f9));
  // PTX:309 mov.b32 %f145, %r86
  asm("mov.b32 %0, %1;" : "=f"(f145) : "r"(r86));
  // PTX:310 sub.f32 %f146, %f145, %f11
  asm("sub.f32 %0, %1, %2;" : "=f"(f146) : "f"(f145), "f"(f11));
  // PTX:311 div.rn.f32 %f15, %f10, %f13
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f15) : "f"(f10), "f"(f13));
  // PTX:312 mul.f32 %f147, %f144, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f147) : "f"(f144), "f"(f15));
  // PTX:313 div.rn.f32 %f16, %f12, %f13
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f16) : "f"(f12), "f"(f13));
  // PTX:314 fma.rn.f32 %f148, %f142, %f14, %f147
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f148) : "f"(f142), "f"(f14), "f"(f147));
  // PTX:315 fma.rn.f32 %f149, %f146, %f16, %f148
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f149) : "f"(f146), "f"(f16), "f"(f148));
  // PTX:316 mul.f32 %f150, %f14, %f149
  asm("mul.f32 %0, %1, %2;" : "=f"(f150) : "f"(f14), "f"(f149));
  // PTX:317 mul.f32 %f151, %f15, %f149
  asm("mul.f32 %0, %1, %2;" : "=f"(f151) : "f"(f15), "f"(f149));
  // PTX:318 mul.f32 %f152, %f16, %f149
  asm("mul.f32 %0, %1, %2;" : "=f"(f152) : "f"(f16), "f"(f149));
  // PTX:319 sub.f32 %f17, %f142, %f150
  asm("sub.f32 %0, %1, %2;" : "=f"(f17) : "f"(f142), "f"(f150));
  // PTX:320 sub.f32 %f18, %f144, %f151
  asm("sub.f32 %0, %1, %2;" : "=f"(f18) : "f"(f144), "f"(f151));
  // PTX:321 sub.f32 %f19, %f146, %f152
  asm("sub.f32 %0, %1, %2;" : "=f"(f19) : "f"(f146), "f"(f152));
  // PTX:322 sub.f32 %f153, %f4, %f1
  asm("sub.f32 %0, %1, %2;" : "=f"(f153) : "f"(f4), "f"(f1));
  // PTX:323 sub.f32 %f154, %f5, %f2
  asm("sub.f32 %0, %1, %2;" : "=f"(f154) : "f"(f5), "f"(f2));
  // PTX:324 mul.f32 %f155, %f154, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f155) : "f"(f154), "f"(f15));
  // PTX:325 sub.f32 %f156, %f6, %f3
  asm("sub.f32 %0, %1, %2;" : "=f"(f156) : "f"(f6), "f"(f3));
  // PTX:326 fma.rn.f32 %f157, %f153, %f14, %f155
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f157) : "f"(f153), "f"(f14), "f"(f155));
  // PTX:327 fma.rn.f32 %f158, %f16, %f156, %f157
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f158) : "f"(f16), "f"(f156), "f"(f157));
  // PTX:328 mul.f32 %f159, %f14, %f158
  asm("mul.f32 %0, %1, %2;" : "=f"(f159) : "f"(f14), "f"(f158));
  // PTX:329 mul.f32 %f160, %f15, %f158
  asm("mul.f32 %0, %1, %2;" : "=f"(f160) : "f"(f15), "f"(f158));
  // PTX:330 mul.f32 %f161, %f16, %f158
  asm("mul.f32 %0, %1, %2;" : "=f"(f161) : "f"(f16), "f"(f158));
  // PTX:331 sub.f32 %f20, %f153, %f159
  asm("sub.f32 %0, %1, %2;" : "=f"(f20) : "f"(f153), "f"(f159));
  // PTX:332 sub.f32 %f21, %f154, %f160
  asm("sub.f32 %0, %1, %2;" : "=f"(f21) : "f"(f154), "f"(f160));
  // PTX:333 sub.f32 %f22, %f156, %f161
  asm("sub.f32 %0, %1, %2;" : "=f"(f22) : "f"(f156), "f"(f161));
  // PTX:334 mul.f32 %f162, %f18, %f18
  asm("mul.f32 %0, %1, %2;" : "=f"(f162) : "f"(f18), "f"(f18));
  // PTX:335 fma.rn.f32 %f163, %f17, %f17, %f162
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f163) : "f"(f17), "f"(f17), "f"(f162));
  // PTX:336 fma.rn.f32 %f164, %f19, %f19, %f163
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f164) : "f"(f19), "f"(f19), "f"(f163));
  // PTX:337 sqrt.rn.f32 %f23, %f164
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f23) : "f"(f164));
  // PTX:338 mul.f32 %f165, %f21, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f165) : "f"(f21), "f"(f21));
  // PTX:339 fma.rn.f32 %f166, %f20, %f20, %f165
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f166) : "f"(f20), "f"(f20), "f"(f165));
  // PTX:340 fma.rn.f32 %f167, %f22, %f22, %f166
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f167) : "f"(f22), "f"(f22), "f"(f166));
  // PTX:341 sqrt.rn.f32 %f24, %f167
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f24) : "f"(f167));
  // PTX:342 setp.leu.f32 %p8, %f23, 0f322BCC77
  p8 = ((isnan(((float)(f23))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f23)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:343 setp.leu.f32 %p9, %f24, 0f322BCC77
  p9 = ((isnan(((float)(f24))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f24)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:344 or.pred %p10, %p8, %p9
  p10 = ((p8) || (p9));
  // PTX:345 @%p10 bra $L__BB31_25
  if (p10) { goto L_BB31_25; }
  // PTX:347 abs.f32 %f168, %f23
  asm("abs.f32 %0, %1;" : "=f"(f168) : "f"(f23));
  // PTX:348 setp.geu.f32 %p11, %f168, 0f7F800000
  p11 = ((isnan(((float)(f168))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f168)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:349 @%p11 bra $L__BB31_25
  if (p11) { goto L_BB31_25; }
  // PTX:351 abs.f32 %f169, %f24
  asm("abs.f32 %0, %1;" : "=f"(f169) : "f"(f24));
  // PTX:352 setp.geu.f32 %p12, %f169, 0f7F800000
  p12 = ((isnan(((float)(f169))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f169)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:353 @%p12 bra $L__BB31_25
  if (p12) { goto L_BB31_25; }
  // PTX:355 div.rn.f32 %f170, %f17, %f23
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f170) : "f"(f17), "f"(f23));
  // PTX:356 div.rn.f32 %f171, %f22, %f24
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f171) : "f"(f22), "f"(f24));
  // PTX:357 div.rn.f32 %f172, %f18, %f23
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f172) : "f"(f18), "f"(f23));
  // PTX:358 mul.f32 %f173, %f172, %f171
  asm("mul.f32 %0, %1, %2;" : "=f"(f173) : "f"(f172), "f"(f171));
  // PTX:359 div.rn.f32 %f174, %f21, %f24
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f174) : "f"(f21), "f"(f24));
  // PTX:360 div.rn.f32 %f175, %f19, %f23
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f175) : "f"(f19), "f"(f23));
  // PTX:361 mul.f32 %f176, %f175, %f174
  asm("mul.f32 %0, %1, %2;" : "=f"(f176) : "f"(f175), "f"(f174));
  // PTX:362 sub.f32 %f177, %f173, %f176
  asm("sub.f32 %0, %1, %2;" : "=f"(f177) : "f"(f173), "f"(f176));
  // PTX:363 div.rn.f32 %f178, %f20, %f24
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f178) : "f"(f20), "f"(f24));
  // PTX:364 mul.f32 %f179, %f175, %f178
  asm("mul.f32 %0, %1, %2;" : "=f"(f179) : "f"(f175), "f"(f178));
  // PTX:365 mul.f32 %f180, %f170, %f171
  asm("mul.f32 %0, %1, %2;" : "=f"(f180) : "f"(f170), "f"(f171));
  // PTX:366 sub.f32 %f181, %f179, %f180
  asm("sub.f32 %0, %1, %2;" : "=f"(f181) : "f"(f179), "f"(f180));
  // PTX:367 mul.f32 %f182, %f170, %f174
  asm("mul.f32 %0, %1, %2;" : "=f"(f182) : "f"(f170), "f"(f174));
  // PTX:368 mul.f32 %f183, %f172, %f178
  asm("mul.f32 %0, %1, %2;" : "=f"(f183) : "f"(f172), "f"(f178));
  // PTX:369 sub.f32 %f184, %f182, %f183
  asm("sub.f32 %0, %1, %2;" : "=f"(f184) : "f"(f182), "f"(f183));
  // PTX:370 mul.f32 %f185, %f15, %f181
  asm("mul.f32 %0, %1, %2;" : "=f"(f185) : "f"(f15), "f"(f181));
  // PTX:371 fma.rn.f32 %f186, %f14, %f177, %f185
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f186) : "f"(f14), "f"(f177), "f"(f185));
  // PTX:372 fma.rn.f32 %f25, %f16, %f184, %f186
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f25) : "f"(f16), "f"(f184), "f"(f186));
  // PTX:373 mul.f32 %f187, %f172, %f174
  asm("mul.f32 %0, %1, %2;" : "=f"(f187) : "f"(f172), "f"(f174));
  // PTX:374 fma.rn.f32 %f188, %f170, %f178, %f187
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f188) : "f"(f170), "f"(f178), "f"(f187));
  // PTX:375 fma.rn.f32 %f26, %f175, %f171, %f188
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f26) : "f"(f175), "f"(f171), "f"(f188));
  // PTX:376 mul.f32 %f189, %f25, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f189) : "f"(f25), "f"(f25));
  // PTX:377 fma.rn.f32 %f27, %f26, %f26, %f189
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f27) : "f"(f26), "f"(f26), "f"(f189));
  // PTX:378 setp.leu.f32 %p13, %f27, 0f2B8CBCCC
  p13 = ((isnan(((float)(f27))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) || (((float)(f27)) <= ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:379 @%p13 bra $L__BB31_25
  if (p13) { goto L_BB31_25; }
  // PTX:381 abs.f32 %f190, %f27
  asm("abs.f32 %0, %1;" : "=f"(f190) : "f"(f27));
  // PTX:382 setp.geu.f32 %p14, %f190, 0f7F800000
  p14 = ((isnan(((float)(f190))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f190)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:383 @%p14 bra $L__BB31_25
  if (p14) { goto L_BB31_25; }
  // PTX:385 abs.f32 %f28, %f26
  asm("abs.f32 %0, %1;" : "=f"(f28) : "f"(f26));
  // PTX:386 setp.eq.f32 %p15, %f28, 0f00000000
  p15 = (!(isnan(((float)(f28))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f28)) == ((float)(as_f32(0x00000000u)))));
  // PTX:387 abs.f32 %f29, %f25
  asm("abs.f32 %0, %1;" : "=f"(f29) : "f"(f25));
  // PTX:388 setp.eq.f32 %p16, %f29, 0f00000000
  p16 = (!(isnan(((float)(f29))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f29)) == ((float)(as_f32(0x00000000u)))));
  // PTX:389 and.pred %p17, %p15, %p16
  p17 = ((p15) && (p16));
  // PTX:390 @%p17 bra $L__BB31_21
  if (p17) { goto L_BB31_21; }
  // PTX:391 bra.uni $L__BB31_18
  goto L_BB31_18;
  // PTX:393 $L__BB31_21:
L_BB31_21:;
  // PTX:394 mov.b32 %r67, %f26
  asm("mov.b32 %0, %1;" : "=r"(r67) : "f"(f26));
  // PTX:395 shr.s32 %r68, %r67, 31
  asm("shr.s32 %0, %1, 31;" : "=r"(r68) : "r"(r67));
  // PTX:396 and.b32 %r69, %r68, 1078530011
  asm("and.b32 %0, %1, 1078530011;" : "=r"(r69) : "r"(r68));
  // PTX:397 mov.b32 %r70, %f25
  asm("mov.b32 %0, %1;" : "=r"(r70) : "f"(f25));
  // PTX:398 and.b32 %r71, %r70, -2147483648
  asm("and.b32 %0, %1, -2147483648;" : "=r"(r71) : "r"(r70));
  // PTX:399 or.b32 %r72, %r71, %r69
  asm("or.b32 %0, %1, %2;" : "=r"(r72) : "r"(r71), "r"(r69));
  // PTX:400 mov.b32 %f223, %r72
  asm("mov.b32 %0, %1;" : "=f"(f223) : "r"(r72));
  // PTX:401 bra.uni $L__BB31_22
  goto L_BB31_22;
  // PTX:403 $L__BB31_18:
L_BB31_18:;
  // PTX:404 setp.eq.f32 %p18, %f28, 0f7F800000
  p18 = (!(isnan(((float)(f28))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f28)) == ((float)(as_f32(0x7F800000u)))));
  // PTX:405 setp.eq.f32 %p19, %f29, 0f7F800000
  p19 = (!(isnan(((float)(f29))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f29)) == ((float)(as_f32(0x7F800000u)))));
  // PTX:406 and.pred %p20, %p18, %p19
  p20 = ((p18) && (p19));
  // PTX:407 @%p20 bra $L__BB31_20
  if (p20) { goto L_BB31_20; }
  // PTX:408 bra.uni $L__BB31_19
  goto L_BB31_19;
  // PTX:410 $L__BB31_20:
L_BB31_20:;
  // PTX:411 mov.b32 %r62, %f26
  asm("mov.b32 %0, %1;" : "=r"(r62) : "f"(f26));
  // PTX:412 setp.lt.s32 %p24, %r62, 0
  p24 = (((int)(r62)) < ((int)(0)));
  // PTX:413 selp.b32 %r63, 1075235812, 1061752795, %p24
  r63 = p24 ? 1075235812 : 1061752795;
  // PTX:414 mov.b32 %r64, %f25
  asm("mov.b32 %0, %1;" : "=r"(r64) : "f"(f25));
  // PTX:415 and.b32 %r65, %r64, -2147483648
  asm("and.b32 %0, %1, -2147483648;" : "=r"(r65) : "r"(r64));
  // PTX:416 or.b32 %r66, %r65, %r63
  asm("or.b32 %0, %1, %2;" : "=r"(r66) : "r"(r65), "r"(r63));
  // PTX:417 mov.b32 %f223, %r66
  asm("mov.b32 %0, %1;" : "=f"(f223) : "r"(r66));
  // PTX:418 bra.uni $L__BB31_22
  goto L_BB31_22;
  // PTX:420 $L__BB31_19:
L_BB31_19:;
  // PTX:421 max.f32 %f191, %f29, %f28
  asm("max.f32 %0, %1, %2;" : "=f"(f191) : "f"(f29), "f"(f28));
  // PTX:422 min.f32 %f192, %f29, %f28
  asm("min.f32 %0, %1, %2;" : "=f"(f192) : "f"(f29), "f"(f28));
  // PTX:423 div.rn.f32 %f193, %f192, %f191
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f193) : "f"(f192), "f"(f191));
  // PTX:424 mul.rn.f32 %f194, %f193, %f193
  asm("mul.rn.f32 %0, %1, %2;" : "=f"(f194) : "f"(f193), "f"(f193));
  // PTX:425 mov.f32 %f195, 0fC0B59883
  asm("mov.f32 %0, 0fC0B59883;" : "=f"(f195) : );
  // PTX:426 mov.f32 %f196, 0fBF52C7EA
  asm("mov.f32 %0, 0fBF52C7EA;" : "=f"(f196) : );
  // PTX:427 fma.rn.f32 %f197, %f194, %f196, %f195
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f197) : "f"(f194), "f"(f196), "f"(f195));
  // PTX:428 mov.f32 %f198, 0fC0D21907
  asm("mov.f32 %0, 0fC0D21907;" : "=f"(f198) : );
  // PTX:429 fma.rn.f32 %f199, %f197, %f194, %f198
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f199) : "f"(f197), "f"(f194), "f"(f198));
  // PTX:430 mul.f32 %f200, %f194, %f199
  asm("mul.f32 %0, %1, %2;" : "=f"(f200) : "f"(f194), "f"(f199));
  // PTX:431 mul.f32 %f201, %f193, %f200
  asm("mul.f32 %0, %1, %2;" : "=f"(f201) : "f"(f193), "f"(f200));
  // PTX:432 add.f32 %f202, %f194, 0f41355DC0
  asm("add.f32 %0, %1, 0f41355DC0;" : "=f"(f202) : "f"(f194));
  // PTX:433 mov.f32 %f203, 0f41E6BD60
  asm("mov.f32 %0, 0f41E6BD60;" : "=f"(f203) : );
  // PTX:434 fma.rn.f32 %f204, %f202, %f194, %f203
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f204) : "f"(f202), "f"(f194), "f"(f203));
  // PTX:435 mov.f32 %f205, 0f419D92C8
  asm("mov.f32 %0, 0f419D92C8;" : "=f"(f205) : );
  // PTX:436 fma.rn.f32 %f206, %f204, %f194, %f205
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f206) : "f"(f204), "f"(f194), "f"(f205));
  // PTX:437 rcp.rn.f32 %f207, %f206
  asm("rcp.rn.f32 %0, %1;" : "=f"(f207) : "f"(f206));
  // PTX:438 fma.rn.f32 %f208, %f201, %f207, %f193
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f208) : "f"(f201), "f"(f207), "f"(f193));
  // PTX:439 mov.f32 %f209, 0f3FC90FDB
  asm("mov.f32 %0, 0f3FC90FDB;" : "=f"(f209) : );
  // PTX:440 sub.f32 %f210, %f209, %f208
  asm("sub.f32 %0, %1, %2;" : "=f"(f210) : "f"(f209), "f"(f208));
  // PTX:441 setp.gt.f32 %p21, %f29, %f28
  p21 = (!(isnan(((float)(f29))) || isnan(((float)(f28)))) && (((float)(f29)) > ((float)(f28))));
  // PTX:442 selp.f32 %f211, %f210, %f208, %p21
  f211 = p21 ? f210 : f208;
  // PTX:443 mov.b32 %r57, %f26
  asm("mov.b32 %0, %1;" : "=r"(r57) : "f"(f26));
  // PTX:444 setp.lt.s32 %p22, %r57, 0
  p22 = (((int)(r57)) < ((int)(0)));
  // PTX:445 mov.f32 %f212, 0f40490FDB
  asm("mov.f32 %0, 0f40490FDB;" : "=f"(f212) : );
  // PTX:446 sub.f32 %f213, %f212, %f211
  asm("sub.f32 %0, %1, %2;" : "=f"(f213) : "f"(f212), "f"(f211));
  // PTX:447 selp.f32 %f214, %f213, %f211, %p22
  f214 = p22 ? f213 : f211;
  // PTX:448 mov.b32 %r58, %f214
  asm("mov.b32 %0, %1;" : "=r"(r58) : "f"(f214));
  // PTX:449 mov.b32 %r59, %f25
  asm("mov.b32 %0, %1;" : "=r"(r59) : "f"(f25));
  // PTX:450 and.b32 %r60, %r59, -2147483648
  asm("and.b32 %0, %1, -2147483648;" : "=r"(r60) : "r"(r59));
  // PTX:451 or.b32 %r61, %r60, %r58
  asm("or.b32 %0, %1, %2;" : "=r"(r61) : "r"(r60), "r"(r58));
  // PTX:452 mov.b32 %f215, %r61
  asm("mov.b32 %0, %1;" : "=f"(f215) : "r"(r61));
  // PTX:453 add.f32 %f216, %f28, %f29
  asm("add.f32 %0, %1, %2;" : "=f"(f216) : "f"(f28), "f"(f29));
  // PTX:454 setp.le.f32 %p23, %f216, 0f7F800000
  p23 = (!(isnan(((float)(f216))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f216)) <= ((float)(as_f32(0x7F800000u)))));
  // PTX:455 selp.f32 %f223, %f215, %f216, %p23
  f223 = p23 ? f215 : f216;
  // PTX:457 $L__BB31_22:
L_BB31_22:;
  // PTX:458 cvta.to.global.u64 %rd81, %rd13
  rd81 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd13));
  // PTX:459 shl.b64 %rd82, %rd3, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd82) : "l"(rd3));
  // PTX:460 add.s64 %rd10, %rd81, %rd82
  asm("add.s64 %0, %1, %2;" : "=l"(rd10) : "l"(rd81), "l"(rd82));
  // PTX:461 ld.global.u32 %r73, [%rd10]
  r73 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (0)))));
  // PTX:462 setp.eq.s32 %p25, %r73, 0
  p25 = (((int)(r73)) == ((int)(0)));
  // PTX:463 cvta.to.global.u64 %rd83, %rd12
  rd83 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd12));
  // PTX:464 add.s64 %rd11, %rd83, %rd82
  asm("add.s64 %0, %1, %2;" : "=l"(rd11) : "l"(rd83), "l"(rd82));
  // PTX:465 mov.f32 %f224, %f223
  asm("mov.f32 %0, %1;" : "=f"(f224) : "f"(f223));
  // PTX:466 @%p25 bra $L__BB31_24
  if (p25) { goto L_BB31_24; }
  // PTX:468 ld.global.f32 %f224, [%rd11]
  f224 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (0)))));
  // PTX:470 $L__BB31_24:
L_BB31_24:;
  // PTX:471 sub.f32 %f217, %f224, %f223
  asm("sub.f32 %0, %1, %2;" : "=f"(f217) : "f"(f224), "f"(f223));
  // PTX:472 div.rn.f32 %f218, %f217, 0f40C90FDB
  asm("div.rn.f32 %0, %1, 0f40C90FDB;" : "=f"(f218) : "f"(f217));
  // PTX:473 mov.b32 %r74, %f218
  asm("mov.b32 %0, %1;" : "=r"(r74) : "f"(f218));
  // PTX:474 and.b32 %r75, %r74, -2147483648
  asm("and.b32 %0, %1, -2147483648;" : "=r"(r75) : "r"(r74));
  // PTX:475 or.b32 %r76, %r75, 1056964608
  asm("or.b32 %0, %1, 1056964608;" : "=r"(r76) : "r"(r75));
  // PTX:476 mov.b32 %f219, %r76
  asm("mov.b32 %0, %1;" : "=f"(f219) : "r"(r76));
  // PTX:477 add.rz.f32 %f220, %f218, %f219
  asm("add.rz.f32 %0, %1, %2;" : "=f"(f220) : "f"(f218), "f"(f219));
  // PTX:478 cvt.rzi.f32.f32 %f221, %f220
  asm("cvt.rzi.f32.f32 %0, %1;" : "=f"(f221) : "f"(f220));
  // PTX:479 fma.rn.f32 %f222, %f221, 0f40C90FDB, %f223
  asm("fma.rn.f32 %0, %1, 0f40C90FDB, %2;" : "=f"(f222) : "f"(f221), "f"(f223));
  // PTX:480 st.global.f32 [%rd11], %f222
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (0))))) = (float)(f222);
  // PTX:481 mov.u32 %r77, 1
  asm("mov.u32 %0, 1;" : "=r"(r77) : );
  // PTX:482 st.global.u32 [%rd10], %r77
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (0))))) = (unsigned)(r77);
  // PTX:484 $L__BB31_25:
L_BB31_25:;
  // PTX:485 ret
  return;
}
