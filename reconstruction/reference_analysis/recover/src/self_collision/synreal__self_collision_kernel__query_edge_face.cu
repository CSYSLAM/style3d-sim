// 机械还原自 PTX：synreal::self_collision_kernel::query_edge_face(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, int const*, synreal::Aabb const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, int const*, float, int*, int*, unsigned long, unsigned long, unsigned long, unsigned long, int)
// PTX SHA256: 6b96f3e7a74fbffbbf7ccac2fab7c7a4c3c9f1dc440820fb63bd776de806d314
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__self_collision_kernel__query_edge_face(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, float param8, unsigned long long param9, unsigned long long param10, unsigned long long param11, unsigned long long param12, unsigned long long param13, unsigned long long param14, unsigned param15) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57, p58, p59, p60, p61, p62, p63, p64, p65, p66;
  unsigned short rs0, rs1, rs2, rs3, rs4, rs5, rs6, rs7, rs8, rs9, rs10, rs11, rs12, rs13, rs14, rs15, rs16, rs17, rs18, rs19, rs20, rs21, rs22, rs23, rs24, rs25, rs26, rs27, rs28, rs29, rs30, rs31, rs32, rs33, rs34;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98;
  // PTX:33 ld.param.u64 %rd27, [_ZN7synreal21self_collision_kernel15query_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi3EiLS3_0EEEPKiPKNS_4AabbESE_PKNS2_ILi2EiLS3_0EEESE_fPiSL_mmmmi_param_0]
  rd27 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:34 ld.param.u64 %rd28, [_ZN7synreal21self_collision_kernel15query_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi3EiLS3_0EEEPKiPKNS_4AabbESE_PKNS2_ILi2EiLS3_0EEESE_fPiSL_mmmmi_param_1]
  rd28 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:35 ld.param.u64 %rd34, [_ZN7synreal21self_collision_kernel15query_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi3EiLS3_0EEEPKiPKNS_4AabbESE_PKNS2_ILi2EiLS3_0EEESE_fPiSL_mmmmi_param_2]
  rd34 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:36 ld.param.u64 %rd29, [_ZN7synreal21self_collision_kernel15query_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi3EiLS3_0EEEPKiPKNS_4AabbESE_PKNS2_ILi2EiLS3_0EEESE_fPiSL_mmmmi_param_3]
  rd29 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:37 ld.param.u64 %rd35, [_ZN7synreal21self_collision_kernel15query_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi3EiLS3_0EEEPKiPKNS_4AabbESE_PKNS2_ILi2EiLS3_0EEESE_fPiSL_mmmmi_param_4]
  rd35 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:38 ld.param.u64 %rd36, [_ZN7synreal21self_collision_kernel15query_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi3EiLS3_0EEEPKiPKNS_4AabbESE_PKNS2_ILi2EiLS3_0EEESE_fPiSL_mmmmi_param_5]
  rd36 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:39 ld.param.u64 %rd37, [_ZN7synreal21self_collision_kernel15query_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi3EiLS3_0EEEPKiPKNS_4AabbESE_PKNS2_ILi2EiLS3_0EEESE_fPiSL_mmmmi_param_6]
  rd37 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:40 ld.param.u64 %rd38, [_ZN7synreal21self_collision_kernel15query_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi3EiLS3_0EEEPKiPKNS_4AabbESE_PKNS2_ILi2EiLS3_0EEESE_fPiSL_mmmmi_param_7]
  rd38 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:41 ld.param.f32 %f7, [_ZN7synreal21self_collision_kernel15query_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi3EiLS3_0EEEPKiPKNS_4AabbESE_PKNS2_ILi2EiLS3_0EEESE_fPiSL_mmmmi_param_8]
  f7 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param8 + (0))));
  // PTX:42 ld.param.u64 %rd30, [_ZN7synreal21self_collision_kernel15query_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi3EiLS3_0EEEPKiPKNS_4AabbESE_PKNS2_ILi2EiLS3_0EEESE_fPiSL_mmmmi_param_9]
  rd30 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:43 ld.param.u64 %rd39, [_ZN7synreal21self_collision_kernel15query_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi3EiLS3_0EEEPKiPKNS_4AabbESE_PKNS2_ILi2EiLS3_0EEESE_fPiSL_mmmmi_param_10]
  rd39 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:44 ld.param.u64 %rd40, [_ZN7synreal21self_collision_kernel15query_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi3EiLS3_0EEEPKiPKNS_4AabbESE_PKNS2_ILi2EiLS3_0EEESE_fPiSL_mmmmi_param_11]
  rd40 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:45 ld.param.u64 %rd31, [_ZN7synreal21self_collision_kernel15query_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi3EiLS3_0EEEPKiPKNS_4AabbESE_PKNS2_ILi2EiLS3_0EEESE_fPiSL_mmmmi_param_12]
  rd31 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:46 ld.param.u64 %rd32, [_ZN7synreal21self_collision_kernel15query_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi3EiLS3_0EEEPKiPKNS_4AabbESE_PKNS2_ILi2EiLS3_0EEESE_fPiSL_mmmmi_param_13]
  rd32 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:47 ld.param.u64 %rd33, [_ZN7synreal21self_collision_kernel15query_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi3EiLS3_0EEEPKiPKNS_4AabbESE_PKNS2_ILi2EiLS3_0EEESE_fPiSL_mmmmi_param_14]
  rd33 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:48 ld.param.u32 %r31, [_ZN7synreal21self_collision_kernel15query_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi3EiLS3_0EEEPKiPKNS_4AabbESE_PKNS2_ILi2EiLS3_0EEESE_fPiSL_mmmmi_param_15]
  r31 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param15 + (0))));
  // PTX:49 cvta.to.global.u64 %rd1, %rd39
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd39));
  // PTX:50 cvta.to.global.u64 %rd2, %rd29
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd29));
  // PTX:51 cvta.to.global.u64 %rd3, %rd34
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd34));
  // PTX:52 cvta.to.global.u64 %rd4, %rd38
  rd4 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd38));
  // PTX:53 cvta.to.global.u64 %rd5, %rd35
  rd5 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd35));
  // PTX:54 cvta.to.global.u64 %rd6, %rd37
  rd6 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd37));
  // PTX:55 cvta.to.global.u64 %rd7, %rd36
  rd7 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd36));
  // PTX:56 mov.u32 %r32, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r32) : "r"(blockIdx.x));
  // PTX:57 mov.u32 %r33, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r33) : "r"(blockDim.x));
  // PTX:58 mul.wide.u32 %rd41, %r32, %r33
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd41) : "r"(r32), "r"(r33));
  // PTX:59 mov.u32 %r34, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r34) : "r"(threadIdx.x));
  // PTX:60 cvt.u64.u32 %rd42, %r34
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd42) : "r"(r34));
  // PTX:61 add.s64 %rd8, %rd41, %rd42
  asm("add.s64 %0, %1, %2;" : "=l"(rd8) : "l"(rd41), "l"(rd42));
  // PTX:62 setp.ge.u64 %p1, %rd8, %rd40
  p1 = (((unsigned long long)(rd8)) >= ((unsigned long long)(rd40)));
  // PTX:63 @%p1 bra $L__BB7_47
  if (p1) { goto L_BB7_47; }
  // PTX:65 or.b64 %rd43, %rd8, %rd31
  asm("or.b64 %0, %1, %2;" : "=l"(rd43) : "l"(rd8), "l"(rd31));
  // PTX:66 and.b64 %rd44, %rd43, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd44) : "l"(rd43));
  // PTX:67 setp.eq.s64 %p2, %rd44, 0
  p2 = (((long long)(rd44)) == ((long long)(0)));
  // PTX:68 @%p2 bra $L__BB7_3
  if (p2) { goto L_BB7_3; }
  // PTX:70 div.u64 %rd97, %rd8, %rd31
  asm("div.u64 %0, %1, %2;" : "=l"(rd97) : "l"(rd8), "l"(rd31));
  // PTX:71 mul.lo.s64 %rd45, %rd97, %rd31
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd97), "l"(rd31));
  // PTX:72 sub.s64 %rd98, %rd8, %rd45
  asm("sub.s64 %0, %1, %2;" : "=l"(rd98) : "l"(rd8), "l"(rd45));
  // PTX:73 bra.uni $L__BB7_4
  goto L_BB7_4;
  // PTX:75 $L__BB7_3:
L_BB7_3:;
  // PTX:76 cvt.u32.u64 %r35, %rd31
  asm("cvt.u32.u64 %0, %1;" : "=r"(r35) : "l"(rd31));
  // PTX:77 cvt.u32.u64 %r36, %rd8
  asm("cvt.u32.u64 %0, %1;" : "=r"(r36) : "l"(rd8));
  // PTX:78 div.u32 %r37, %r36, %r35
  asm("div.u32 %0, %1, %2;" : "=r"(r37) : "r"(r36), "r"(r35));
  // PTX:79 mul.lo.s32 %r38, %r37, %r35
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r38) : "r"(r37), "r"(r35));
  // PTX:80 sub.s32 %r39, %r36, %r38
  asm("sub.s32 %0, %1, %2;" : "=r"(r39) : "r"(r36), "r"(r38));
  // PTX:81 cvt.u64.u32 %rd97, %r37
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd97) : "r"(r37));
  // PTX:82 cvt.u64.u32 %rd98, %r39
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd98) : "r"(r39));
  // PTX:84 $L__BB7_4:
L_BB7_4:;
  // PTX:85 cvta.to.global.u64 %rd46, %rd27
  rd46 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd27));
  // PTX:86 cvta.to.global.u64 %rd47, %rd28
  rd47 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd28));
  // PTX:87 shl.b64 %rd48, %rd98, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd48) : "l"(rd98));
  // PTX:88 add.s64 %rd49, %rd47, %rd48
  asm("add.s64 %0, %1, %2;" : "=l"(rd49) : "l"(rd47), "l"(rd48));
  // PTX:89 ld.global.u32 %r41, [%rd49+8]
  r41 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (8)))));
  // PTX:90 cvt.s64.s32 %rd15, %r41
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd15) : "r"(r41));
  // PTX:91 ld.global.u32 %r42, [%rd49+12]
  r42 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (12)))));
  // PTX:92 cvt.s64.s32 %rd16, %r42
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd16) : "r"(r42));
  // PTX:93 mul.lo.s64 %rd50, %rd97, %rd33
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd97), "l"(rd33));
  // PTX:94 cvt.u32.u64 %r43, %rd50
  asm("cvt.u32.u64 %0, %1;" : "=r"(r43) : "l"(rd50));
  // PTX:95 add.s32 %r44, %r41, %r43
  asm("add.s32 %0, %1, %2;" : "=r"(r44) : "r"(r41), "r"(r43));
  // PTX:96 mul.wide.s32 %rd51, %r44, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd51) : "r"(r44));
  // PTX:97 add.s64 %rd52, %rd46, %rd51
  asm("add.s64 %0, %1, %2;" : "=l"(rd52) : "l"(rd46), "l"(rd51));
  // PTX:98 add.s32 %r45, %r42, %r43
  asm("add.s32 %0, %1, %2;" : "=r"(r45) : "r"(r42), "r"(r43));
  // PTX:99 mul.wide.s32 %rd53, %r45, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd53) : "r"(r45));
  // PTX:100 add.s64 %rd54, %rd46, %rd53
  asm("add.s64 %0, %1, %2;" : "=l"(rd54) : "l"(rd46), "l"(rd53));
  // PTX:101 ld.global.f32 %f8, [%rd54]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))));
  // PTX:102 ld.global.f32 %f9, [%rd52]
  f9 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))));
  // PTX:103 min.f32 %f10, %f9, %f8
  asm("min.f32 %0, %1, %2;" : "=f"(f10) : "f"(f9), "f"(f8));
  // PTX:104 ld.global.f32 %f11, [%rd54+4]
  f11 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (4)))));
  // PTX:105 ld.global.f32 %f12, [%rd52+4]
  f12 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (4)))));
  // PTX:106 min.f32 %f13, %f12, %f11
  asm("min.f32 %0, %1, %2;" : "=f"(f13) : "f"(f12), "f"(f11));
  // PTX:107 ld.global.f32 %f14, [%rd54+8]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (8)))));
  // PTX:108 ld.global.f32 %f15, [%rd52+8]
  f15 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (8)))));
  // PTX:109 min.f32 %f16, %f15, %f14
  asm("min.f32 %0, %1, %2;" : "=f"(f16) : "f"(f15), "f"(f14));
  // PTX:110 max.f32 %f17, %f9, %f8
  asm("max.f32 %0, %1, %2;" : "=f"(f17) : "f"(f9), "f"(f8));
  // PTX:111 max.f32 %f18, %f12, %f11
  asm("max.f32 %0, %1, %2;" : "=f"(f18) : "f"(f12), "f"(f11));
  // PTX:112 max.f32 %f19, %f15, %f14
  asm("max.f32 %0, %1, %2;" : "=f"(f19) : "f"(f15), "f"(f14));
  // PTX:113 add.f32 %f20, %f7, %f7
  asm("add.f32 %0, %1, %2;" : "=f"(f20) : "f"(f7), "f"(f7));
  // PTX:114 sub.f32 %f1, %f10, %f20
  asm("sub.f32 %0, %1, %2;" : "=f"(f1) : "f"(f10), "f"(f20));
  // PTX:115 sub.f32 %f2, %f13, %f20
  asm("sub.f32 %0, %1, %2;" : "=f"(f2) : "f"(f13), "f"(f20));
  // PTX:116 sub.f32 %f3, %f16, %f20
  asm("sub.f32 %0, %1, %2;" : "=f"(f3) : "f"(f16), "f"(f20));
  // PTX:117 add.f32 %f4, %f20, %f17
  asm("add.f32 %0, %1, %2;" : "=f"(f4) : "f"(f20), "f"(f17));
  // PTX:118 add.f32 %f5, %f20, %f18
  asm("add.f32 %0, %1, %2;" : "=f"(f5) : "f"(f20), "f"(f18));
  // PTX:119 add.f32 %f6, %f20, %f19
  asm("add.f32 %0, %1, %2;" : "=f"(f6) : "f"(f20), "f"(f19));
  // PTX:120 cvt.u32.u64 %r46, %rd32
  asm("cvt.u32.u64 %0, %1;" : "=r"(r46) : "l"(rd32));
  // PTX:121 add.s32 %r1, %r46, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r1) : "r"(r46));
  // PTX:122 shl.b64 %rd55, %rd32, 1
  asm("shl.b64 %0, %1, 1;" : "=l"(rd55) : "l"(rd32));
  // PTX:123 add.s64 %rd56, %rd55, -1
  asm("add.s64 %0, %1, -1;" : "=l"(rd56) : "l"(rd55));
  // PTX:124 mul.lo.s64 %rd17, %rd97, %rd56
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd17) : "l"(rd97), "l"(rd56));
  // PTX:125 setp.lt.s32 %p3, %r31, 1
  p3 = (((int)(r31)) < ((int)(1)));
  // PTX:126 mov.u32 %r85, 0
  asm("mov.u32 %0, 0;" : "=r"(r85) : );
  // PTX:127 @%p3 bra $L__BB7_46
  if (p3) { goto L_BB7_46; }
  // PTX:129 setp.eq.s64 %p4, %rd29, 0
  p4 = (((long long)(rd29)) == ((long long)(0)));
  // PTX:130 cvt.s64.s32 %rd57, %r31
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd57) : "r"(r31));
  // PTX:131 mul.lo.s64 %rd18, %rd8, %rd57
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd18) : "l"(rd8), "l"(rd57));
  // PTX:132 @%p4 bra $L__BB7_29
  if (p4) { goto L_BB7_29; }
  // PTX:134 shl.b64 %rd58, %rd16, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd58) : "l"(rd16));
  // PTX:135 add.s64 %rd19, %rd2, %rd58
  asm("add.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd2), "l"(rd58));
  // PTX:136 shl.b64 %rd59, %rd15, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd59) : "l"(rd15));
  // PTX:137 add.s64 %rd20, %rd2, %rd59
  asm("add.s64 %0, %1, %2;" : "=l"(rd20) : "l"(rd2), "l"(rd59));
  // PTX:138 mov.u32 %r86, 0
  asm("mov.u32 %0, 0;" : "=r"(r86) : );
  // PTX:139 mov.u32 %r83, -1
  asm("mov.u32 %0, -1;" : "=r"(r83) : );
  // PTX:140 mov.u32 %r85, %r86
  asm("mov.u32 %0, %1;" : "=r"(r85) : "r"(r86));
  // PTX:142 $L__BB7_7:
L_BB7_7:;
  // PTX:143 mov.u32 %r3, %r83
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(r83));
  // PTX:144 mov.u32 %r83, %r86
  asm("mov.u32 %0, %1;" : "=r"(r83) : "r"(r86));
  // PTX:145 cvt.s64.s32 %rd21, %r83
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd21) : "r"(r83));
  // PTX:146 mul.wide.s32 %rd60, %r83, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd60) : "r"(r83));
  // PTX:147 add.s64 %rd61, %rd7, %rd60
  asm("add.s64 %0, %1, %2;" : "=l"(rd61) : "l"(rd7), "l"(rd60));
  // PTX:148 ld.global.u32 %r86, [%rd61]
  r86 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))));
  // PTX:149 setp.eq.s32 %p5, %r3, %r86
  p5 = (((int)(r3)) == ((int)(r86)));
  // PTX:150 mul.wide.s32 %rd62, %r83, 8
  asm("mul.wide.s32 %0, %1, 8;" : "=l"(rd62) : "r"(r83));
  // PTX:151 add.s64 %rd22, %rd6, %rd62
  asm("add.s64 %0, %1, %2;" : "=l"(rd22) : "l"(rd6), "l"(rd62));
  // PTX:152 @%p5 bra $L__BB7_11
  if (p5) { goto L_BB7_11; }
  // PTX:153 bra.uni $L__BB7_8
  goto L_BB7_8;
  // PTX:155 $L__BB7_11:
L_BB7_11:;
  // PTX:156 add.s64 %rd63, %rd17, %rd21
  asm("add.s64 %0, %1, %2;" : "=l"(rd63) : "l"(rd17), "l"(rd21));
  // PTX:157 mul.lo.s64 %rd64, %rd63, 24
  asm("mul.lo.s64 %0, %1, 24;" : "=l"(rd64) : "l"(rd63));
  // PTX:158 add.s64 %rd65, %rd5, %rd64
  asm("add.s64 %0, %1, %2;" : "=l"(rd65) : "l"(rd5), "l"(rd64));
  // PTX:159 add.s64 %rd23, %rd65, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd23) : "l"(rd65));
  // PTX:160 ld.global.f32 %f21, [%rd65+12]
  f21 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (12)))));
  // PTX:161 setp.gtu.f32 %p8, %f1, %f21
  p8 = ((isnan(((float)(f1))) || isnan(((float)(f21)))) || (((float)(f1)) > ((float)(f21))));
  // PTX:162 mov.u16 %rs33, 0
  asm("mov.u16 %0, 0;" : "=h"(rs33) : );
  // PTX:163 @%p8 bra $L__BB7_17
  if (p8) { goto L_BB7_17; }
  // PTX:165 ld.global.f32 %f22, [%rd23+-12]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (-12)))));
  // PTX:166 setp.ltu.f32 %p9, %f4, %f22
  p9 = ((isnan(((float)(f4))) || isnan(((float)(f22)))) || (((float)(f4)) < ((float)(f22))));
  // PTX:167 @%p9 bra $L__BB7_17
  if (p9) { goto L_BB7_17; }
  // PTX:169 ld.global.f32 %f23, [%rd23+4]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (4)))));
  // PTX:170 setp.gtu.f32 %p10, %f2, %f23
  p10 = ((isnan(((float)(f2))) || isnan(((float)(f23)))) || (((float)(f2)) > ((float)(f23))));
  // PTX:171 @%p10 bra $L__BB7_17
  if (p10) { goto L_BB7_17; }
  // PTX:173 ld.global.f32 %f24, [%rd23+-8]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (-8)))));
  // PTX:174 setp.ltu.f32 %p11, %f5, %f24
  p11 = ((isnan(((float)(f5))) || isnan(((float)(f24)))) || (((float)(f5)) < ((float)(f24))));
  // PTX:175 @%p11 bra $L__BB7_17
  if (p11) { goto L_BB7_17; }
  // PTX:177 ld.global.f32 %f25, [%rd23+8]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (8)))));
  // PTX:178 setp.gtu.f32 %p12, %f3, %f25
  p12 = ((isnan(((float)(f3))) || isnan(((float)(f25)))) || (((float)(f3)) > ((float)(f25))));
  // PTX:179 @%p12 bra $L__BB7_17
  if (p12) { goto L_BB7_17; }
  // PTX:181 ld.global.f32 %f26, [%rd23+-4]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (-4)))));
  // PTX:182 setp.ge.f32 %p13, %f6, %f26
  p13 = (!(isnan(((float)(f6))) || isnan(((float)(f26)))) && (((float)(f6)) >= ((float)(f26))));
  // PTX:183 selp.u16 %rs33, 1, 0, %p13
  rs33 = p13 ? 1 : 0;
  // PTX:185 $L__BB7_17:
L_BB7_17:;
  // PTX:186 setp.eq.s16 %p14, %rs33, 0
  p14 = (((short)(rs33)) == ((short)(0)));
  // PTX:187 mov.u32 %r86, %r3
  asm("mov.u32 %0, %1;" : "=r"(r86) : "r"(r3));
  // PTX:188 @%p14 bra $L__BB7_28
  if (p14) { goto L_BB7_28; }
  // PTX:190 cvt.u32.u64 %r52, %rd21
  asm("cvt.u32.u64 %0, %1;" : "=r"(r52) : "l"(rd21));
  // PTX:191 setp.lt.s32 %p15, %r52, %r1
  p15 = (((int)(r52)) < ((int)(r1)));
  // PTX:192 @%p15 bra $L__BB7_27
  if (p15) { goto L_BB7_27; }
  // PTX:193 bra.uni $L__BB7_19
  goto L_BB7_19;
  // PTX:195 $L__BB7_27:
L_BB7_27:;
  // PTX:196 ld.global.u32 %r86, [%rd22]
  r86 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (0)))));
  // PTX:197 bra.uni $L__BB7_28
  goto L_BB7_28;
  // PTX:199 $L__BB7_8:
L_BB7_8:;
  // PTX:200 cvt.u32.u64 %r50, %rd21
  asm("cvt.u32.u64 %0, %1;" : "=r"(r50) : "l"(rd21));
  // PTX:201 setp.ge.s32 %p6, %r50, %r1
  p6 = (((int)(r50)) >= ((int)(r1)));
  // PTX:202 @%p6 bra $L__BB7_28
  if (p6) { goto L_BB7_28; }
  // PTX:204 ld.global.u32 %r51, [%rd22]
  r51 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (0)))));
  // PTX:205 setp.ne.s32 %p7, %r3, %r51
  p7 = (((int)(r3)) != ((int)(r51)));
  // PTX:206 @%p7 bra $L__BB7_28
  if (p7) { goto L_BB7_28; }
  // PTX:208 ld.global.u32 %r86, [%rd22+4]
  r86 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (4)))));
  // PTX:209 bra.uni $L__BB7_28
  goto L_BB7_28;
  // PTX:211 $L__BB7_19:
L_BB7_19:;
  // PTX:212 cvt.u32.u64 %r53, %rd16
  asm("cvt.u32.u64 %0, %1;" : "=r"(r53) : "l"(rd16));
  // PTX:213 sub.s32 %r55, %r52, %r1
  asm("sub.s32 %0, %1, %2;" : "=r"(r55) : "r"(r52), "r"(r1));
  // PTX:214 mul.wide.s32 %rd66, %r55, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd66) : "r"(r55));
  // PTX:215 add.s64 %rd67, %rd4, %rd66
  asm("add.s64 %0, %1, %2;" : "=l"(rd67) : "l"(rd4), "l"(rd66));
  // PTX:216 ld.global.u32 %r7, [%rd67]
  r7 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0)))));
  // PTX:217 mul.wide.s32 %rd68, %r7, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd68) : "r"(r7));
  // PTX:218 add.s64 %rd69, %rd3, %rd68
  asm("add.s64 %0, %1, %2;" : "=l"(rd69) : "l"(rd3), "l"(rd68));
  // PTX:219 ld.global.u32 %r8, [%rd69]
  r8 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (0)))));
  // PTX:220 ld.global.u32 %r9, [%rd69+4]
  r9 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (4)))));
  // PTX:221 ld.global.u32 %r10, [%rd69+8]
  r10 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (8)))));
  // PTX:222 cvt.u32.u64 %r56, %rd15
  asm("cvt.u32.u64 %0, %1;" : "=r"(r56) : "l"(rd15));
  // PTX:223 setp.eq.s32 %p16, %r8, %r56
  p16 = (((int)(r8)) == ((int)(r56)));
  // PTX:224 setp.eq.s32 %p17, %r8, %r53
  p17 = (((int)(r8)) == ((int)(r53)));
  // PTX:225 or.pred %p18, %p17, %p16
  p18 = ((p17) || (p16));
  // PTX:226 setp.eq.s32 %p19, %r9, %r56
  p19 = (((int)(r9)) == ((int)(r56)));
  // PTX:227 or.pred %p20, %p18, %p19
  p20 = ((p18) || (p19));
  // PTX:228 setp.eq.s32 %p21, %r9, %r53
  p21 = (((int)(r9)) == ((int)(r53)));
  // PTX:229 or.pred %p22, %p21, %p20
  p22 = ((p21) || (p20));
  // PTX:230 setp.eq.s32 %p23, %r10, %r56
  p23 = (((int)(r10)) == ((int)(r56)));
  // PTX:231 or.pred %p24, %p23, %p22
  p24 = ((p23) || (p22));
  // PTX:232 setp.eq.s32 %p25, %r10, %r53
  p25 = (((int)(r10)) == ((int)(r53)));
  // PTX:233 or.pred %p26, %p25, %p24
  p26 = ((p25) || (p24));
  // PTX:234 mov.u32 %r86, %r3
  asm("mov.u32 %0, %1;" : "=r"(r86) : "r"(r3));
  // PTX:235 @%p26 bra $L__BB7_28
  if (p26) { goto L_BB7_28; }
  // PTX:237 ld.global.u32 %r11, [%rd20]
  r11 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))));
  // PTX:238 mul.wide.s32 %rd70, %r8, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd70) : "r"(r8));
  // PTX:239 add.s64 %rd71, %rd2, %rd70
  asm("add.s64 %0, %1, %2;" : "=l"(rd71) : "l"(rd2), "l"(rd70));
  // PTX:240 ld.global.u32 %r12, [%rd71]
  r12 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))));
  // PTX:241 or.b32 %r57, %r12, %r11
  asm("or.b32 %0, %1, %2;" : "=r"(r57) : "r"(r12), "r"(r11));
  // PTX:242 setp.eq.s32 %p27, %r11, %r12
  p27 = (((int)(r11)) == ((int)(r12)));
  // PTX:243 selp.u16 %rs10, 1, 0, %p27
  rs10 = p27 ? 1 : 0;
  // PTX:244 shr.u32 %r58, %r57, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r58) : "r"(r57));
  // PTX:245 cvt.u16.u32 %rs11, %r58
  asm("cvt.u16.u32 %0, %1;" : "=h"(rs11) : "r"(r58));
  // PTX:246 or.b16 %rs12, %rs11, %rs10
  asm("or.b16 %0, %1, %2;" : "=h"(rs12) : "h"(rs11), "h"(rs10));
  // PTX:247 setp.eq.s16 %p28, %rs12, 0
  p28 = (((short)(rs12)) == ((short)(0)));
  // PTX:248 mov.u32 %r86, %r3
  asm("mov.u32 %0, %1;" : "=r"(r86) : "r"(r3));
  // PTX:249 @%p28 bra $L__BB7_28
  if (p28) { goto L_BB7_28; }
  // PTX:251 mul.wide.s32 %rd72, %r9, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd72) : "r"(r9));
  // PTX:252 add.s64 %rd73, %rd2, %rd72
  asm("add.s64 %0, %1, %2;" : "=l"(rd73) : "l"(rd2), "l"(rd72));
  // PTX:253 ld.global.u32 %r13, [%rd73]
  r13 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (0)))));
  // PTX:254 or.b32 %r59, %r13, %r11
  asm("or.b32 %0, %1, %2;" : "=r"(r59) : "r"(r13), "r"(r11));
  // PTX:255 setp.eq.s32 %p29, %r11, %r13
  p29 = (((int)(r11)) == ((int)(r13)));
  // PTX:256 selp.u16 %rs13, 1, 0, %p29
  rs13 = p29 ? 1 : 0;
  // PTX:257 shr.u32 %r60, %r59, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r60) : "r"(r59));
  // PTX:258 cvt.u16.u32 %rs14, %r60
  asm("cvt.u16.u32 %0, %1;" : "=h"(rs14) : "r"(r60));
  // PTX:259 or.b16 %rs15, %rs14, %rs13
  asm("or.b16 %0, %1, %2;" : "=h"(rs15) : "h"(rs14), "h"(rs13));
  // PTX:260 setp.eq.s16 %p30, %rs15, 0
  p30 = (((short)(rs15)) == ((short)(0)));
  // PTX:261 mov.u32 %r86, %r3
  asm("mov.u32 %0, %1;" : "=r"(r86) : "r"(r3));
  // PTX:262 @%p30 bra $L__BB7_28
  if (p30) { goto L_BB7_28; }
  // PTX:264 mul.wide.s32 %rd74, %r10, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd74) : "r"(r10));
  // PTX:265 add.s64 %rd75, %rd2, %rd74
  asm("add.s64 %0, %1, %2;" : "=l"(rd75) : "l"(rd2), "l"(rd74));
  // PTX:266 ld.global.u32 %r14, [%rd75]
  r14 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (0)))));
  // PTX:267 or.b32 %r61, %r14, %r11
  asm("or.b32 %0, %1, %2;" : "=r"(r61) : "r"(r14), "r"(r11));
  // PTX:268 setp.eq.s32 %p31, %r11, %r14
  p31 = (((int)(r11)) == ((int)(r14)));
  // PTX:269 selp.u16 %rs16, 1, 0, %p31
  rs16 = p31 ? 1 : 0;
  // PTX:270 shr.u32 %r62, %r61, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r62) : "r"(r61));
  // PTX:271 cvt.u16.u32 %rs17, %r62
  asm("cvt.u16.u32 %0, %1;" : "=h"(rs17) : "r"(r62));
  // PTX:272 or.b16 %rs18, %rs17, %rs16
  asm("or.b16 %0, %1, %2;" : "=h"(rs18) : "h"(rs17), "h"(rs16));
  // PTX:273 setp.eq.s16 %p32, %rs18, 0
  p32 = (((short)(rs18)) == ((short)(0)));
  // PTX:274 mov.u32 %r86, %r3
  asm("mov.u32 %0, %1;" : "=r"(r86) : "r"(r3));
  // PTX:275 @%p32 bra $L__BB7_28
  if (p32) { goto L_BB7_28; }
  // PTX:277 ld.global.u32 %r15, [%rd19]
  r15 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))));
  // PTX:278 or.b32 %r63, %r12, %r15
  asm("or.b32 %0, %1, %2;" : "=r"(r63) : "r"(r12), "r"(r15));
  // PTX:279 setp.eq.s32 %p33, %r15, %r12
  p33 = (((int)(r15)) == ((int)(r12)));
  // PTX:280 selp.u16 %rs19, 1, 0, %p33
  rs19 = p33 ? 1 : 0;
  // PTX:281 shr.u32 %r64, %r63, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r64) : "r"(r63));
  // PTX:282 cvt.u16.u32 %rs20, %r64
  asm("cvt.u16.u32 %0, %1;" : "=h"(rs20) : "r"(r64));
  // PTX:283 or.b16 %rs21, %rs20, %rs19
  asm("or.b16 %0, %1, %2;" : "=h"(rs21) : "h"(rs20), "h"(rs19));
  // PTX:284 setp.eq.s16 %p34, %rs21, 0
  p34 = (((short)(rs21)) == ((short)(0)));
  // PTX:285 mov.u32 %r86, %r3
  asm("mov.u32 %0, %1;" : "=r"(r86) : "r"(r3));
  // PTX:286 @%p34 bra $L__BB7_28
  if (p34) { goto L_BB7_28; }
  // PTX:288 or.b32 %r65, %r13, %r15
  asm("or.b32 %0, %1, %2;" : "=r"(r65) : "r"(r13), "r"(r15));
  // PTX:289 setp.eq.s32 %p35, %r15, %r13
  p35 = (((int)(r15)) == ((int)(r13)));
  // PTX:290 selp.u16 %rs22, 1, 0, %p35
  rs22 = p35 ? 1 : 0;
  // PTX:291 shr.u32 %r66, %r65, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r66) : "r"(r65));
  // PTX:292 cvt.u16.u32 %rs23, %r66
  asm("cvt.u16.u32 %0, %1;" : "=h"(rs23) : "r"(r66));
  // PTX:293 or.b16 %rs24, %rs23, %rs22
  asm("or.b16 %0, %1, %2;" : "=h"(rs24) : "h"(rs23), "h"(rs22));
  // PTX:294 setp.eq.s16 %p36, %rs24, 0
  p36 = (((short)(rs24)) == ((short)(0)));
  // PTX:295 mov.u32 %r86, %r3
  asm("mov.u32 %0, %1;" : "=r"(r86) : "r"(r3));
  // PTX:296 @%p36 bra $L__BB7_28
  if (p36) { goto L_BB7_28; }
  // PTX:298 or.b32 %r67, %r14, %r15
  asm("or.b32 %0, %1, %2;" : "=r"(r67) : "r"(r14), "r"(r15));
  // PTX:299 setp.eq.s32 %p37, %r15, %r14
  p37 = (((int)(r15)) == ((int)(r14)));
  // PTX:300 selp.u16 %rs25, 1, 0, %p37
  rs25 = p37 ? 1 : 0;
  // PTX:301 shr.u32 %r68, %r67, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r68) : "r"(r67));
  // PTX:302 cvt.u16.u32 %rs26, %r68
  asm("cvt.u16.u32 %0, %1;" : "=h"(rs26) : "r"(r68));
  // PTX:303 or.b16 %rs27, %rs26, %rs25
  asm("or.b16 %0, %1, %2;" : "=h"(rs27) : "h"(rs26), "h"(rs25));
  // PTX:304 setp.eq.s16 %p38, %rs27, 0
  p38 = (((short)(rs27)) == ((short)(0)));
  // PTX:305 mov.u32 %r86, %r3
  asm("mov.u32 %0, %1;" : "=r"(r86) : "r"(r3));
  // PTX:306 @%p38 bra $L__BB7_28
  if (p38) { goto L_BB7_28; }
  // PTX:308 cvt.s64.s32 %rd76, %r85
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd76) : "r"(r85));
  // PTX:309 add.s64 %rd77, %rd18, %rd76
  asm("add.s64 %0, %1, %2;" : "=l"(rd77) : "l"(rd18), "l"(rd76));
  // PTX:310 shl.b64 %rd78, %rd77, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd78) : "l"(rd77));
  // PTX:311 add.s64 %rd79, %rd1, %rd78
  asm("add.s64 %0, %1, %2;" : "=l"(rd79) : "l"(rd1), "l"(rd78));
  // PTX:312 st.global.u32 [%rd79], %r7
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (0))))) = (unsigned)(r7);
  // PTX:313 add.s32 %r85, %r85, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r85) : "r"(r85));
  // PTX:314 mov.u32 %r86, %r3
  asm("mov.u32 %0, %1;" : "=r"(r86) : "r"(r3));
  // PTX:316 $L__BB7_28:
L_BB7_28:;
  // PTX:317 setp.lt.s32 %p39, %r85, %r31
  p39 = (((int)(r85)) < ((int)(r31)));
  // PTX:318 setp.gt.s32 %p40, %r86, -1
  p40 = (((int)(r86)) > ((int)(-1)));
  // PTX:319 and.pred %p41, %p39, %p40
  p41 = ((p39) && (p40));
  // PTX:320 @%p41 bra $L__BB7_7
  if (p41) { goto L_BB7_7; }
  // PTX:321 bra.uni $L__BB7_46
  goto L_BB7_46;
  // PTX:323 $L__BB7_29:
L_BB7_29:;
  // PTX:324 mov.u32 %r91, 0
  asm("mov.u32 %0, 0;" : "=r"(r91) : );
  // PTX:325 mov.u32 %r88, -1
  asm("mov.u32 %0, -1;" : "=r"(r88) : );
  // PTX:326 mov.u32 %r85, %r91
  asm("mov.u32 %0, %1;" : "=r"(r85) : "r"(r91));
  // PTX:328 $L__BB7_30:
L_BB7_30:;
  // PTX:329 mov.u32 %r21, %r88
  asm("mov.u32 %0, %1;" : "=r"(r21) : "r"(r88));
  // PTX:330 mov.u32 %r88, %r91
  asm("mov.u32 %0, %1;" : "=r"(r88) : "r"(r91));
  // PTX:331 cvt.s64.s32 %rd24, %r88
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd24) : "r"(r88));
  // PTX:332 mul.wide.s32 %rd80, %r88, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd80) : "r"(r88));
  // PTX:333 add.s64 %rd81, %rd7, %rd80
  asm("add.s64 %0, %1, %2;" : "=l"(rd81) : "l"(rd7), "l"(rd80));
  // PTX:334 ld.global.u32 %r91, [%rd81]
  r91 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (0)))));
  // PTX:335 setp.eq.s32 %p42, %r21, %r91
  p42 = (((int)(r21)) == ((int)(r91)));
  // PTX:336 mul.wide.s32 %rd82, %r88, 8
  asm("mul.wide.s32 %0, %1, 8;" : "=l"(rd82) : "r"(r88));
  // PTX:337 add.s64 %rd25, %rd6, %rd82
  asm("add.s64 %0, %1, %2;" : "=l"(rd25) : "l"(rd6), "l"(rd82));
  // PTX:338 @%p42 bra $L__BB7_34
  if (p42) { goto L_BB7_34; }
  // PTX:339 bra.uni $L__BB7_31
  goto L_BB7_31;
  // PTX:341 $L__BB7_34:
L_BB7_34:;
  // PTX:342 add.s64 %rd83, %rd17, %rd24
  asm("add.s64 %0, %1, %2;" : "=l"(rd83) : "l"(rd17), "l"(rd24));
  // PTX:343 mul.lo.s64 %rd84, %rd83, 24
  asm("mul.lo.s64 %0, %1, 24;" : "=l"(rd84) : "l"(rd83));
  // PTX:344 add.s64 %rd85, %rd5, %rd84
  asm("add.s64 %0, %1, %2;" : "=l"(rd85) : "l"(rd5), "l"(rd84));
  // PTX:345 add.s64 %rd26, %rd85, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd26) : "l"(rd85));
  // PTX:346 ld.global.f32 %f27, [%rd85+12]
  f27 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (12)))));
  // PTX:347 setp.gtu.f32 %p45, %f1, %f27
  p45 = ((isnan(((float)(f1))) || isnan(((float)(f27)))) || (((float)(f1)) > ((float)(f27))));
  // PTX:348 mov.u16 %rs34, 0
  asm("mov.u16 %0, 0;" : "=h"(rs34) : );
  // PTX:349 @%p45 bra $L__BB7_40
  if (p45) { goto L_BB7_40; }
  // PTX:351 ld.global.f32 %f28, [%rd26+-12]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (-12)))));
  // PTX:352 setp.ltu.f32 %p46, %f4, %f28
  p46 = ((isnan(((float)(f4))) || isnan(((float)(f28)))) || (((float)(f4)) < ((float)(f28))));
  // PTX:353 @%p46 bra $L__BB7_40
  if (p46) { goto L_BB7_40; }
  // PTX:355 ld.global.f32 %f29, [%rd26+4]
  f29 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (4)))));
  // PTX:356 setp.gtu.f32 %p47, %f2, %f29
  p47 = ((isnan(((float)(f2))) || isnan(((float)(f29)))) || (((float)(f2)) > ((float)(f29))));
  // PTX:357 @%p47 bra $L__BB7_40
  if (p47) { goto L_BB7_40; }
  // PTX:359 ld.global.f32 %f30, [%rd26+-8]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (-8)))));
  // PTX:360 setp.ltu.f32 %p48, %f5, %f30
  p48 = ((isnan(((float)(f5))) || isnan(((float)(f30)))) || (((float)(f5)) < ((float)(f30))));
  // PTX:361 @%p48 bra $L__BB7_40
  if (p48) { goto L_BB7_40; }
  // PTX:363 ld.global.f32 %f31, [%rd26+8]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (8)))));
  // PTX:364 setp.gtu.f32 %p49, %f3, %f31
  p49 = ((isnan(((float)(f3))) || isnan(((float)(f31)))) || (((float)(f3)) > ((float)(f31))));
  // PTX:365 @%p49 bra $L__BB7_40
  if (p49) { goto L_BB7_40; }
  // PTX:367 ld.global.f32 %f32, [%rd26+-4]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (-4)))));
  // PTX:368 setp.ge.f32 %p50, %f6, %f32
  p50 = (!(isnan(((float)(f6))) || isnan(((float)(f32)))) && (((float)(f6)) >= ((float)(f32))));
  // PTX:369 selp.u16 %rs34, 1, 0, %p50
  rs34 = p50 ? 1 : 0;
  // PTX:371 $L__BB7_40:
L_BB7_40:;
  // PTX:372 setp.eq.s16 %p51, %rs34, 0
  p51 = (((short)(rs34)) == ((short)(0)));
  // PTX:373 mov.u32 %r91, %r21
  asm("mov.u32 %0, %1;" : "=r"(r91) : "r"(r21));
  // PTX:374 @%p51 bra $L__BB7_45
  if (p51) { goto L_BB7_45; }
  // PTX:376 cvt.u32.u64 %r74, %rd24
  asm("cvt.u32.u64 %0, %1;" : "=r"(r74) : "l"(rd24));
  // PTX:377 setp.lt.s32 %p52, %r74, %r1
  p52 = (((int)(r74)) < ((int)(r1)));
  // PTX:378 @%p52 bra $L__BB7_44
  if (p52) { goto L_BB7_44; }
  // PTX:379 bra.uni $L__BB7_42
  goto L_BB7_42;
  // PTX:381 $L__BB7_44:
L_BB7_44:;
  // PTX:382 ld.global.u32 %r91, [%rd25]
  r91 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (0)))));
  // PTX:383 bra.uni $L__BB7_45
  goto L_BB7_45;
  // PTX:385 $L__BB7_31:
L_BB7_31:;
  // PTX:386 cvt.u32.u64 %r72, %rd24
  asm("cvt.u32.u64 %0, %1;" : "=r"(r72) : "l"(rd24));
  // PTX:387 setp.ge.s32 %p43, %r72, %r1
  p43 = (((int)(r72)) >= ((int)(r1)));
  // PTX:388 @%p43 bra $L__BB7_45
  if (p43) { goto L_BB7_45; }
  // PTX:390 ld.global.u32 %r73, [%rd25]
  r73 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (0)))));
  // PTX:391 setp.ne.s32 %p44, %r21, %r73
  p44 = (((int)(r21)) != ((int)(r73)));
  // PTX:392 @%p44 bra $L__BB7_45
  if (p44) { goto L_BB7_45; }
  // PTX:394 ld.global.u32 %r91, [%rd25+4]
  r91 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (4)))));
  // PTX:395 bra.uni $L__BB7_45
  goto L_BB7_45;
  // PTX:397 $L__BB7_42:
L_BB7_42:;
  // PTX:398 cvt.u32.u64 %r75, %rd16
  asm("cvt.u32.u64 %0, %1;" : "=r"(r75) : "l"(rd16));
  // PTX:399 sub.s32 %r77, %r74, %r1
  asm("sub.s32 %0, %1, %2;" : "=r"(r77) : "r"(r74), "r"(r1));
  // PTX:400 mul.wide.s32 %rd86, %r77, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd86) : "r"(r77));
  // PTX:401 add.s64 %rd87, %rd4, %rd86
  asm("add.s64 %0, %1, %2;" : "=l"(rd87) : "l"(rd4), "l"(rd86));
  // PTX:402 ld.global.u32 %r25, [%rd87]
  r25 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (0)))));
  // PTX:403 mul.wide.s32 %rd88, %r25, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd88) : "r"(r25));
  // PTX:404 add.s64 %rd89, %rd3, %rd88
  asm("add.s64 %0, %1, %2;" : "=l"(rd89) : "l"(rd3), "l"(rd88));
  // PTX:405 ld.global.u32 %r78, [%rd89]
  r78 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (0)))));
  // PTX:406 cvt.u32.u64 %r79, %rd15
  asm("cvt.u32.u64 %0, %1;" : "=r"(r79) : "l"(rd15));
  // PTX:407 setp.eq.s32 %p53, %r78, %r79
  p53 = (((int)(r78)) == ((int)(r79)));
  // PTX:408 setp.eq.s32 %p54, %r78, %r75
  p54 = (((int)(r78)) == ((int)(r75)));
  // PTX:409 or.pred %p55, %p54, %p53
  p55 = ((p54) || (p53));
  // PTX:410 ld.global.u32 %r80, [%rd89+4]
  r80 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (4)))));
  // PTX:411 setp.eq.s32 %p56, %r80, %r79
  p56 = (((int)(r80)) == ((int)(r79)));
  // PTX:412 or.pred %p57, %p55, %p56
  p57 = ((p55) || (p56));
  // PTX:413 setp.eq.s32 %p58, %r80, %r75
  p58 = (((int)(r80)) == ((int)(r75)));
  // PTX:414 or.pred %p59, %p58, %p57
  p59 = ((p58) || (p57));
  // PTX:415 ld.global.u32 %r81, [%rd89+8]
  r81 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (8)))));
  // PTX:416 setp.eq.s32 %p60, %r81, %r79
  p60 = (((int)(r81)) == ((int)(r79)));
  // PTX:417 or.pred %p61, %p60, %p59
  p61 = ((p60) || (p59));
  // PTX:418 setp.eq.s32 %p62, %r81, %r75
  p62 = (((int)(r81)) == ((int)(r75)));
  // PTX:419 or.pred %p63, %p62, %p61
  p63 = ((p62) || (p61));
  // PTX:420 mov.u32 %r91, %r21
  asm("mov.u32 %0, %1;" : "=r"(r91) : "r"(r21));
  // PTX:421 @%p63 bra $L__BB7_45
  if (p63) { goto L_BB7_45; }
  // PTX:423 cvt.s64.s32 %rd90, %r85
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd90) : "r"(r85));
  // PTX:424 add.s64 %rd91, %rd18, %rd90
  asm("add.s64 %0, %1, %2;" : "=l"(rd91) : "l"(rd18), "l"(rd90));
  // PTX:425 shl.b64 %rd92, %rd91, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd92) : "l"(rd91));
  // PTX:426 add.s64 %rd93, %rd1, %rd92
  asm("add.s64 %0, %1, %2;" : "=l"(rd93) : "l"(rd1), "l"(rd92));
  // PTX:427 st.global.u32 [%rd93], %r25
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (0))))) = (unsigned)(r25);
  // PTX:428 add.s32 %r85, %r85, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r85) : "r"(r85));
  // PTX:429 mov.u32 %r91, %r21
  asm("mov.u32 %0, %1;" : "=r"(r91) : "r"(r21));
  // PTX:431 $L__BB7_45:
L_BB7_45:;
  // PTX:432 setp.lt.s32 %p64, %r85, %r31
  p64 = (((int)(r85)) < ((int)(r31)));
  // PTX:433 setp.gt.s32 %p65, %r91, -1
  p65 = (((int)(r91)) > ((int)(-1)));
  // PTX:434 and.pred %p66, %p64, %p65
  p66 = ((p64) && (p65));
  // PTX:435 @%p66 bra $L__BB7_30
  if (p66) { goto L_BB7_30; }
  // PTX:437 $L__BB7_46:
L_BB7_46:;
  // PTX:438 cvta.to.global.u64 %rd94, %rd30
  rd94 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd30));
  // PTX:439 shl.b64 %rd95, %rd8, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd95) : "l"(rd8));
  // PTX:440 add.s64 %rd96, %rd94, %rd95
  asm("add.s64 %0, %1, %2;" : "=l"(rd96) : "l"(rd94), "l"(rd95));
  // PTX:441 st.global.u32 [%rd96], %r85
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (0))))) = (unsigned)(r85);
  // PTX:443 $L__BB7_47:
L_BB7_47:;
  // PTX:444 ret
  return;
}
