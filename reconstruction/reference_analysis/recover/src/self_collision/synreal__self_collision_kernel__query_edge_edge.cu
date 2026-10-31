// 机械还原自 PTX：synreal::self_collision_kernel::query_edge_edge(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, int const*, synreal::Aabb const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, int const*, float, int*, int*, unsigned long, unsigned long, unsigned long, int)
// PTX SHA256: cb2b5d9ba736727874b9a7250cf6a891f76140eb5dc3f105829704856e4e4448
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__self_collision_kernel__query_edge_edge(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, float param7, unsigned long long param8, unsigned long long param9, unsigned long long param10, unsigned long long param11, unsigned long long param12, unsigned param13) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47;
  unsigned short rs0, rs1, rs2, rs3, rs4, rs5, rs6, rs7, rs8, rs9, rs10, rs11, rs12, rs13, rs14, rs15, rs16, rs17, rs18, rs19, rs20, rs21, rs22, rs23, rs24, rs25, rs26, rs27, rs28, rs29, rs30, rs31, rs32;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88;
  // PTX:31 ld.param.u64 %rd38, [_ZN7synreal21self_collision_kernel15query_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS_4AabbESB_PKNS2_ILi2EiLS3_0EEESB_fPiSI_mmmi_param_0]
  rd38 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:32 ld.param.u64 %rd39, [_ZN7synreal21self_collision_kernel15query_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS_4AabbESB_PKNS2_ILi2EiLS3_0EEESB_fPiSI_mmmi_param_1]
  rd39 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:33 ld.param.u64 %rd29, [_ZN7synreal21self_collision_kernel15query_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS_4AabbESB_PKNS2_ILi2EiLS3_0EEESB_fPiSI_mmmi_param_2]
  rd29 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:34 ld.param.u64 %rd30, [_ZN7synreal21self_collision_kernel15query_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS_4AabbESB_PKNS2_ILi2EiLS3_0EEESB_fPiSI_mmmi_param_3]
  rd30 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:35 ld.param.u64 %rd31, [_ZN7synreal21self_collision_kernel15query_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS_4AabbESB_PKNS2_ILi2EiLS3_0EEESB_fPiSI_mmmi_param_4]
  rd31 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:36 ld.param.u64 %rd32, [_ZN7synreal21self_collision_kernel15query_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS_4AabbESB_PKNS2_ILi2EiLS3_0EEESB_fPiSI_mmmi_param_5]
  rd32 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:37 ld.param.u64 %rd33, [_ZN7synreal21self_collision_kernel15query_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS_4AabbESB_PKNS2_ILi2EiLS3_0EEESB_fPiSI_mmmi_param_6]
  rd33 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:38 ld.param.f32 %f36, [_ZN7synreal21self_collision_kernel15query_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS_4AabbESB_PKNS2_ILi2EiLS3_0EEESB_fPiSI_mmmi_param_7]
  f36 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param7 + (0))));
  // PTX:39 ld.param.u64 %rd35, [_ZN7synreal21self_collision_kernel15query_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS_4AabbESB_PKNS2_ILi2EiLS3_0EEESB_fPiSI_mmmi_param_9]
  rd35 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:40 ld.param.u64 %rd40, [_ZN7synreal21self_collision_kernel15query_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS_4AabbESB_PKNS2_ILi2EiLS3_0EEESB_fPiSI_mmmi_param_10]
  rd40 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:41 ld.param.u64 %rd36, [_ZN7synreal21self_collision_kernel15query_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS_4AabbESB_PKNS2_ILi2EiLS3_0EEESB_fPiSI_mmmi_param_11]
  rd36 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:42 ld.param.u64 %rd37, [_ZN7synreal21self_collision_kernel15query_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS_4AabbESB_PKNS2_ILi2EiLS3_0EEESB_fPiSI_mmmi_param_12]
  rd37 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:43 ld.param.u32 %r23, [_ZN7synreal21self_collision_kernel15query_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS_4AabbESB_PKNS2_ILi2EiLS3_0EEESB_fPiSI_mmmi_param_13]
  r23 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param13 + (0))));
  // PTX:44 cvta.to.global.u64 %rd1, %rd29
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd29));
  // PTX:45 cvta.to.global.u64 %rd2, %rd38
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd38));
  // PTX:46 cvta.to.global.u64 %rd3, %rd39
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd39));
  // PTX:47 mov.u32 %r24, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r24) : "r"(blockIdx.x));
  // PTX:48 mov.u32 %r25, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r25) : "r"(blockDim.x));
  // PTX:49 mul.wide.u32 %rd41, %r24, %r25
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd41) : "r"(r24), "r"(r25));
  // PTX:50 mov.u32 %r26, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r26) : "r"(threadIdx.x));
  // PTX:51 cvt.u64.u32 %rd42, %r26
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd42) : "r"(r26));
  // PTX:52 add.s64 %rd4, %rd41, %rd42
  asm("add.s64 %0, %1, %2;" : "=l"(rd4) : "l"(rd41), "l"(rd42));
  // PTX:53 setp.ge.u64 %p1, %rd4, %rd40
  p1 = (((unsigned long long)(rd4)) >= ((unsigned long long)(rd40)));
  // PTX:54 @%p1 bra $L__BB6_48
  if (p1) { goto L_BB6_48; }
  // PTX:56 or.b64 %rd43, %rd4, %rd36
  asm("or.b64 %0, %1, %2;" : "=l"(rd43) : "l"(rd4), "l"(rd36));
  // PTX:57 and.b64 %rd44, %rd43, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd44) : "l"(rd43));
  // PTX:58 setp.eq.s64 %p2, %rd44, 0
  p2 = (((long long)(rd44)) == ((long long)(0)));
  // PTX:59 @%p2 bra $L__BB6_3
  if (p2) { goto L_BB6_3; }
  // PTX:61 div.u64 %rd87, %rd4, %rd36
  asm("div.u64 %0, %1, %2;" : "=l"(rd87) : "l"(rd4), "l"(rd36));
  // PTX:62 mul.lo.s64 %rd45, %rd87, %rd36
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd87), "l"(rd36));
  // PTX:63 sub.s64 %rd88, %rd4, %rd45
  asm("sub.s64 %0, %1, %2;" : "=l"(rd88) : "l"(rd4), "l"(rd45));
  // PTX:64 bra.uni $L__BB6_4
  goto L_BB6_4;
  // PTX:66 $L__BB6_3:
L_BB6_3:;
  // PTX:67 cvt.u32.u64 %r27, %rd36
  asm("cvt.u32.u64 %0, %1;" : "=r"(r27) : "l"(rd36));
  // PTX:68 cvt.u32.u64 %r28, %rd4
  asm("cvt.u32.u64 %0, %1;" : "=r"(r28) : "l"(rd4));
  // PTX:69 div.u32 %r29, %r28, %r27
  asm("div.u32 %0, %1, %2;" : "=r"(r29) : "r"(r28), "r"(r27));
  // PTX:70 mul.lo.s32 %r30, %r29, %r27
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r30) : "r"(r29), "r"(r27));
  // PTX:71 sub.s32 %r31, %r28, %r30
  asm("sub.s32 %0, %1, %2;" : "=r"(r31) : "r"(r28), "r"(r30));
  // PTX:72 cvt.u64.u32 %rd87, %r29
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd87) : "r"(r29));
  // PTX:73 cvt.u64.u32 %rd88, %r31
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd88) : "r"(r31));
  // PTX:75 $L__BB6_4:
L_BB6_4:;
  // PTX:76 shl.b64 %rd46, %rd88, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd46) : "l"(rd88));
  // PTX:77 add.s64 %rd47, %rd3, %rd46
  asm("add.s64 %0, %1, %2;" : "=l"(rd47) : "l"(rd3), "l"(rd46));
  // PTX:78 ld.global.u32 %r33, [%rd47+8]
  r33 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (8)))));
  // PTX:79 cvt.s64.s32 %rd11, %r33
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd11) : "r"(r33));
  // PTX:80 ld.global.u32 %r1, [%rd47+12]
  r1 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (12)))));
  // PTX:81 cvt.s64.s32 %rd12, %r1
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd12) : "r"(r1));
  // PTX:82 mul.lo.s64 %rd48, %rd87, %rd37
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd48) : "l"(rd87), "l"(rd37));
  // PTX:83 cvt.u32.u64 %r2, %rd48
  asm("cvt.u32.u64 %0, %1;" : "=r"(r2) : "l"(rd48));
  // PTX:84 add.s32 %r34, %r33, %r2
  asm("add.s32 %0, %1, %2;" : "=r"(r34) : "r"(r33), "r"(r2));
  // PTX:85 mul.wide.s32 %rd49, %r34, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd49) : "r"(r34));
  // PTX:86 add.s64 %rd50, %rd2, %rd49
  asm("add.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd2), "l"(rd49));
  // PTX:87 ld.global.f32 %f1, [%rd50]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (0)))));
  // PTX:88 ld.global.f32 %f2, [%rd50+4]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (4)))));
  // PTX:89 ld.global.f32 %f3, [%rd50+8]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (8)))));
  // PTX:90 cvt.u32.u64 %r35, %rd36
  asm("cvt.u32.u64 %0, %1;" : "=r"(r35) : "l"(rd36));
  // PTX:91 add.s32 %r3, %r35, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r3) : "r"(r35));
  // PTX:92 setp.lt.s32 %p3, %r23, 1
  p3 = (((int)(r23)) < ((int)(1)));
  // PTX:93 mov.u32 %r82, 0
  asm("mov.u32 %0, 0;" : "=r"(r82) : );
  // PTX:94 @%p3 bra $L__BB6_47
  if (p3) { goto L_BB6_47; }
  // PTX:96 add.s32 %r39, %r1, %r2
  asm("add.s32 %0, %1, %2;" : "=r"(r39) : "r"(r1), "r"(r2));
  // PTX:97 mul.wide.s32 %rd51, %r39, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd51) : "r"(r39));
  // PTX:98 add.s64 %rd52, %rd2, %rd51
  asm("add.s64 %0, %1, %2;" : "=l"(rd52) : "l"(rd2), "l"(rd51));
  // PTX:99 ld.global.f32 %f37, [%rd52]
  f37 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))));
  // PTX:100 ld.global.f32 %f38, [%rd52+4]
  f38 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (4)))));
  // PTX:101 ld.global.f32 %f39, [%rd52+8]
  f39 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (8)))));
  // PTX:102 shl.b64 %rd53, %rd11, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd53) : "l"(rd11));
  // PTX:103 add.s64 %rd13, %rd1, %rd53
  asm("add.s64 %0, %1, %2;" : "=l"(rd13) : "l"(rd1), "l"(rd53));
  // PTX:104 shl.b64 %rd54, %rd12, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd54) : "l"(rd12));
  // PTX:105 add.s64 %rd14, %rd1, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd14) : "l"(rd1), "l"(rd54));
  // PTX:106 sub.f32 %f4, %f37, %f1
  asm("sub.f32 %0, %1, %2;" : "=f"(f4) : "f"(f37), "f"(f1));
  // PTX:107 sub.f32 %f5, %f38, %f2
  asm("sub.f32 %0, %1, %2;" : "=f"(f5) : "f"(f38), "f"(f2));
  // PTX:108 mul.f32 %f40, %f5, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f40) : "f"(f5), "f"(f5));
  // PTX:109 sub.f32 %f6, %f39, %f3
  asm("sub.f32 %0, %1, %2;" : "=f"(f6) : "f"(f39), "f"(f3));
  // PTX:110 fma.rn.f32 %f41, %f4, %f4, %f40
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f41) : "f"(f4), "f"(f4), "f"(f40));
  // PTX:111 fma.rn.f32 %f7, %f6, %f6, %f41
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f7) : "f"(f6), "f"(f6), "f"(f41));
  // PTX:112 cvt.s64.s32 %rd55, %r23
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd55) : "r"(r23));
  // PTX:113 mul.lo.s64 %rd15, %rd4, %rd55
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd15) : "l"(rd4), "l"(rd55));
  // PTX:114 cvta.to.global.u64 %rd16, %rd31
  rd16 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd31));
  // PTX:115 cvta.to.global.u64 %rd17, %rd32
  rd17 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd32));
  // PTX:116 cvta.to.global.u64 %rd18, %rd30
  rd18 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd30));
  // PTX:117 cvta.to.global.u64 %rd19, %rd33
  rd19 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd33));
  // PTX:118 cvta.to.global.u64 %rd20, %rd35
  rd20 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd35));
  // PTX:119 mul.f32 %f42, %f36, 0f41100000
  asm("mul.f32 %0, %1, 0f41100000;" : "=f"(f42) : "f"(f36));
  // PTX:120 mul.f32 %f8, %f42, %f36
  asm("mul.f32 %0, %1, %2;" : "=f"(f8) : "f"(f42), "f"(f36));
  // PTX:121 shl.b64 %rd56, %rd36, 1
  asm("shl.b64 %0, %1, 1;" : "=l"(rd56) : "l"(rd36));
  // PTX:122 add.s64 %rd57, %rd56, -1
  asm("add.s64 %0, %1, -1;" : "=l"(rd57) : "l"(rd56));
  // PTX:123 mul.lo.s64 %rd21, %rd87, %rd57
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd21) : "l"(rd87), "l"(rd57));
  // PTX:124 max.f32 %f43, %f3, %f39
  asm("max.f32 %0, %1, %2;" : "=f"(f43) : "f"(f3), "f"(f39));
  // PTX:125 add.f32 %f9, %f43, %f36
  asm("add.f32 %0, %1, %2;" : "=f"(f9) : "f"(f43), "f"(f36));
  // PTX:126 max.f32 %f44, %f2, %f38
  asm("max.f32 %0, %1, %2;" : "=f"(f44) : "f"(f2), "f"(f38));
  // PTX:127 add.f32 %f10, %f44, %f36
  asm("add.f32 %0, %1, %2;" : "=f"(f10) : "f"(f44), "f"(f36));
  // PTX:128 max.f32 %f45, %f1, %f37
  asm("max.f32 %0, %1, %2;" : "=f"(f45) : "f"(f1), "f"(f37));
  // PTX:129 add.f32 %f11, %f45, %f36
  asm("add.f32 %0, %1, %2;" : "=f"(f11) : "f"(f45), "f"(f36));
  // PTX:130 min.f32 %f46, %f3, %f39
  asm("min.f32 %0, %1, %2;" : "=f"(f46) : "f"(f3), "f"(f39));
  // PTX:131 sub.f32 %f12, %f46, %f36
  asm("sub.f32 %0, %1, %2;" : "=f"(f12) : "f"(f46), "f"(f36));
  // PTX:132 min.f32 %f47, %f2, %f38
  asm("min.f32 %0, %1, %2;" : "=f"(f47) : "f"(f2), "f"(f38));
  // PTX:133 sub.f32 %f13, %f47, %f36
  asm("sub.f32 %0, %1, %2;" : "=f"(f13) : "f"(f47), "f"(f36));
  // PTX:134 min.f32 %f48, %f1, %f37
  asm("min.f32 %0, %1, %2;" : "=f"(f48) : "f"(f1), "f"(f37));
  // PTX:135 sub.f32 %f14, %f48, %f36
  asm("sub.f32 %0, %1, %2;" : "=f"(f14) : "f"(f48), "f"(f36));
  // PTX:136 mov.u32 %r83, 0
  asm("mov.u32 %0, 0;" : "=r"(r83) : );
  // PTX:137 mov.u32 %r78, -1
  asm("mov.u32 %0, -1;" : "=r"(r78) : );
  // PTX:138 mov.u32 %r82, %r83
  asm("mov.u32 %0, %1;" : "=r"(r82) : "r"(r83));
  // PTX:140 $L__BB6_6:
L_BB6_6:;
  // PTX:141 mov.u32 %r5, %r78
  asm("mov.u32 %0, %1;" : "=r"(r5) : "r"(r78));
  // PTX:142 mov.u32 %r78, %r83
  asm("mov.u32 %0, %1;" : "=r"(r78) : "r"(r83));
  // PTX:143 cvt.s64.s32 %rd22, %r78
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd22) : "r"(r78));
  // PTX:144 mul.wide.s32 %rd58, %r78, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd58) : "r"(r78));
  // PTX:145 add.s64 %rd59, %rd16, %rd58
  asm("add.s64 %0, %1, %2;" : "=l"(rd59) : "l"(rd16), "l"(rd58));
  // PTX:146 ld.global.u32 %r83, [%rd59]
  r83 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))));
  // PTX:147 setp.eq.s32 %p4, %r5, %r83
  p4 = (((int)(r5)) == ((int)(r83)));
  // PTX:148 mul.wide.s32 %rd60, %r78, 8
  asm("mul.wide.s32 %0, %1, 8;" : "=l"(rd60) : "r"(r78));
  // PTX:149 add.s64 %rd23, %rd17, %rd60
  asm("add.s64 %0, %1, %2;" : "=l"(rd23) : "l"(rd17), "l"(rd60));
  // PTX:150 @%p4 bra $L__BB6_10
  if (p4) { goto L_BB6_10; }
  // PTX:151 bra.uni $L__BB6_7
  goto L_BB6_7;
  // PTX:153 $L__BB6_10:
L_BB6_10:;
  // PTX:154 add.s64 %rd61, %rd21, %rd22
  asm("add.s64 %0, %1, %2;" : "=l"(rd61) : "l"(rd21), "l"(rd22));
  // PTX:155 mul.lo.s64 %rd62, %rd61, 24
  asm("mul.lo.s64 %0, %1, 24;" : "=l"(rd62) : "l"(rd61));
  // PTX:156 add.s64 %rd63, %rd18, %rd62
  asm("add.s64 %0, %1, %2;" : "=l"(rd63) : "l"(rd18), "l"(rd62));
  // PTX:157 add.s64 %rd24, %rd63, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd24) : "l"(rd63));
  // PTX:158 ld.global.f32 %f49, [%rd63+12]
  f49 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (12)))));
  // PTX:159 setp.gtu.f32 %p7, %f14, %f49
  p7 = ((isnan(((float)(f14))) || isnan(((float)(f49)))) || (((float)(f14)) > ((float)(f49))));
  // PTX:160 mov.u16 %rs28, 0
  asm("mov.u16 %0, 0;" : "=h"(rs28) : );
  // PTX:161 @%p7 bra $L__BB6_16
  if (p7) { goto L_BB6_16; }
  // PTX:163 ld.global.f32 %f50, [%rd24+-12]
  f50 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (-12)))));
  // PTX:164 setp.ltu.f32 %p8, %f11, %f50
  p8 = ((isnan(((float)(f11))) || isnan(((float)(f50)))) || (((float)(f11)) < ((float)(f50))));
  // PTX:165 @%p8 bra $L__BB6_16
  if (p8) { goto L_BB6_16; }
  // PTX:167 ld.global.f32 %f51, [%rd24+4]
  f51 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (4)))));
  // PTX:168 setp.gtu.f32 %p9, %f13, %f51
  p9 = ((isnan(((float)(f13))) || isnan(((float)(f51)))) || (((float)(f13)) > ((float)(f51))));
  // PTX:169 @%p9 bra $L__BB6_16
  if (p9) { goto L_BB6_16; }
  // PTX:171 ld.global.f32 %f52, [%rd24+-8]
  f52 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (-8)))));
  // PTX:172 setp.ltu.f32 %p10, %f10, %f52
  p10 = ((isnan(((float)(f10))) || isnan(((float)(f52)))) || (((float)(f10)) < ((float)(f52))));
  // PTX:173 @%p10 bra $L__BB6_16
  if (p10) { goto L_BB6_16; }
  // PTX:175 ld.global.f32 %f53, [%rd24+8]
  f53 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (8)))));
  // PTX:176 setp.gtu.f32 %p11, %f12, %f53
  p11 = ((isnan(((float)(f12))) || isnan(((float)(f53)))) || (((float)(f12)) > ((float)(f53))));
  // PTX:177 @%p11 bra $L__BB6_16
  if (p11) { goto L_BB6_16; }
  // PTX:179 ld.global.f32 %f54, [%rd24+-4]
  f54 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (-4)))));
  // PTX:180 setp.ge.f32 %p12, %f9, %f54
  p12 = (!(isnan(((float)(f9))) || isnan(((float)(f54)))) && (((float)(f9)) >= ((float)(f54))));
  // PTX:181 selp.u16 %rs28, 1, 0, %p12
  rs28 = p12 ? 1 : 0;
  // PTX:183 $L__BB6_16:
L_BB6_16:;
  // PTX:184 setp.eq.s16 %p13, %rs28, 0
  p13 = (((short)(rs28)) == ((short)(0)));
  // PTX:185 mov.u32 %r83, %r5
  asm("mov.u32 %0, %1;" : "=r"(r83) : "r"(r5));
  // PTX:186 @%p13 bra $L__BB6_46
  if (p13) { goto L_BB6_46; }
  // PTX:188 cvt.u32.u64 %r42, %rd22
  asm("cvt.u32.u64 %0, %1;" : "=r"(r42) : "l"(rd22));
  // PTX:189 setp.lt.s32 %p14, %r42, %r3
  p14 = (((int)(r42)) < ((int)(r3)));
  // PTX:190 @%p14 bra $L__BB6_45
  if (p14) { goto L_BB6_45; }
  // PTX:191 bra.uni $L__BB6_18
  goto L_BB6_18;
  // PTX:193 $L__BB6_45:
L_BB6_45:;
  // PTX:194 ld.global.u32 %r83, [%rd23]
  r83 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (0)))));
  // PTX:195 bra.uni $L__BB6_46
  goto L_BB6_46;
  // PTX:197 $L__BB6_7:
L_BB6_7:;
  // PTX:198 cvt.u32.u64 %r40, %rd22
  asm("cvt.u32.u64 %0, %1;" : "=r"(r40) : "l"(rd22));
  // PTX:199 setp.ge.s32 %p5, %r40, %r3
  p5 = (((int)(r40)) >= ((int)(r3)));
  // PTX:200 @%p5 bra $L__BB6_46
  if (p5) { goto L_BB6_46; }
  // PTX:202 ld.global.u32 %r41, [%rd23]
  r41 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (0)))));
  // PTX:203 setp.ne.s32 %p6, %r5, %r41
  p6 = (((int)(r5)) != ((int)(r41)));
  // PTX:204 @%p6 bra $L__BB6_46
  if (p6) { goto L_BB6_46; }
  // PTX:206 ld.global.u32 %r83, [%rd23+4]
  r83 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (4)))));
  // PTX:207 bra.uni $L__BB6_46
  goto L_BB6_46;
  // PTX:209 $L__BB6_18:
L_BB6_18:;
  // PTX:210 sub.s32 %r44, %r42, %r3
  asm("sub.s32 %0, %1, %2;" : "=r"(r44) : "r"(r42), "r"(r3));
  // PTX:211 mul.wide.s32 %rd64, %r44, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd64) : "r"(r44));
  // PTX:212 add.s64 %rd65, %rd19, %rd64
  asm("add.s64 %0, %1, %2;" : "=l"(rd65) : "l"(rd19), "l"(rd64));
  // PTX:213 ld.global.u32 %r9, [%rd65]
  r9 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (0)))));
  // PTX:214 cvt.s64.s32 %rd66, %r9
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd66) : "r"(r9));
  // PTX:215 mul.wide.s32 %rd67, %r9, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd67) : "r"(r9));
  // PTX:216 add.s64 %rd68, %rd3, %rd67
  asm("add.s64 %0, %1, %2;" : "=l"(rd68) : "l"(rd3), "l"(rd67));
  // PTX:217 ld.global.u32 %r45, [%rd68+8]
  r45 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (8)))));
  // PTX:218 cvt.s64.s32 %rd25, %r45
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd25) : "r"(r45));
  // PTX:219 ld.global.u32 %r46, [%rd68+12]
  r46 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (12)))));
  // PTX:220 cvt.s64.s32 %rd26, %r46
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd26) : "r"(r46));
  // PTX:221 setp.ge.u64 %p15, %rd88, %rd66
  p15 = (((unsigned long long)(rd88)) >= ((unsigned long long)(rd66)));
  // PTX:222 cvt.u32.u64 %r47, %rd11
  asm("cvt.u32.u64 %0, %1;" : "=r"(r47) : "l"(rd11));
  // PTX:223 setp.eq.s32 %p16, %r47, %r45
  p16 = (((int)(r47)) == ((int)(r45)));
  // PTX:224 or.pred %p17, %p15, %p16
  p17 = ((p15) || (p16));
  // PTX:225 setp.eq.s32 %p18, %r47, %r46
  p18 = (((int)(r47)) == ((int)(r46)));
  // PTX:226 or.pred %p19, %p17, %p18
  p19 = ((p17) || (p18));
  // PTX:227 cvt.u32.u64 %r48, %rd12
  asm("cvt.u32.u64 %0, %1;" : "=r"(r48) : "l"(rd12));
  // PTX:228 setp.eq.s32 %p20, %r48, %r45
  p20 = (((int)(r48)) == ((int)(r45)));
  // PTX:229 or.pred %p21, %p20, %p19
  p21 = ((p20) || (p19));
  // PTX:230 setp.eq.s32 %p22, %r48, %r46
  p22 = (((int)(r48)) == ((int)(r46)));
  // PTX:231 or.pred %p23, %p22, %p21
  p23 = ((p22) || (p21));
  // PTX:232 mov.u32 %r83, %r5
  asm("mov.u32 %0, %1;" : "=r"(r83) : "r"(r5));
  // PTX:233 @%p23 bra $L__BB6_46
  if (p23) { goto L_BB6_46; }
  // PTX:235 ld.param.u64 %rd86, [_ZN7synreal21self_collision_kernel15query_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS_4AabbESB_PKNS2_ILi2EiLS3_0EEESB_fPiSI_mmmi_param_2]
  rd86 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:236 setp.eq.s64 %p24, %rd86, 0
  p24 = (((long long)(rd86)) == ((long long)(0)));
  // PTX:237 shl.b64 %rd69, %rd25, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd69) : "l"(rd25));
  // PTX:238 add.s64 %rd27, %rd1, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd1), "l"(rd69));
  // PTX:239 mov.u16 %rs29, 1
  asm("mov.u16 %0, 1;" : "=h"(rs29) : );
  // PTX:240 @%p24 bra $L__BB6_21
  if (p24) { goto L_BB6_21; }
  // PTX:242 ld.global.u32 %r49, [%rd13]
  r49 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))));
  // PTX:243 ld.global.u32 %r50, [%rd27]
  r50 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))));
  // PTX:244 or.b32 %r51, %r50, %r49
  asm("or.b32 %0, %1, %2;" : "=r"(r51) : "r"(r50), "r"(r49));
  // PTX:245 setp.eq.s32 %p25, %r49, %r50
  p25 = (((int)(r49)) == ((int)(r50)));
  // PTX:246 selp.u16 %rs17, 1, 0, %p25
  rs17 = p25 ? 1 : 0;
  // PTX:247 shr.u32 %r52, %r51, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r52) : "r"(r51));
  // PTX:248 cvt.u16.u32 %rs18, %r52
  asm("cvt.u16.u32 %0, %1;" : "=h"(rs18) : "r"(r52));
  // PTX:249 or.b16 %rs29, %rs18, %rs17
  asm("or.b16 %0, %1, %2;" : "=h"(rs29) : "h"(rs18), "h"(rs17));
  // PTX:251 $L__BB6_21:
L_BB6_21:;
  // PTX:252 setp.eq.s16 %p26, %rs29, 0
  p26 = (((short)(rs29)) == ((short)(0)));
  // PTX:253 mov.u32 %r83, %r5
  asm("mov.u32 %0, %1;" : "=r"(r83) : "r"(r5));
  // PTX:254 @%p26 bra $L__BB6_46
  if (p26) { goto L_BB6_46; }
  // PTX:256 shl.b64 %rd70, %rd26, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd70) : "l"(rd26));
  // PTX:257 add.s64 %rd28, %rd1, %rd70
  asm("add.s64 %0, %1, %2;" : "=l"(rd28) : "l"(rd1), "l"(rd70));
  // PTX:258 mov.u16 %rs30, 1
  asm("mov.u16 %0, 1;" : "=h"(rs30) : );
  // PTX:259 @%p24 bra $L__BB6_24
  if (p24) { goto L_BB6_24; }
  // PTX:261 ld.global.u32 %r53, [%rd13]
  r53 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))));
  // PTX:262 ld.global.u32 %r54, [%rd28]
  r54 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (0)))));
  // PTX:263 or.b32 %r55, %r54, %r53
  asm("or.b32 %0, %1, %2;" : "=r"(r55) : "r"(r54), "r"(r53));
  // PTX:264 setp.eq.s32 %p28, %r53, %r54
  p28 = (((int)(r53)) == ((int)(r54)));
  // PTX:265 selp.u16 %rs20, 1, 0, %p28
  rs20 = p28 ? 1 : 0;
  // PTX:266 shr.u32 %r56, %r55, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r56) : "r"(r55));
  // PTX:267 cvt.u16.u32 %rs21, %r56
  asm("cvt.u16.u32 %0, %1;" : "=h"(rs21) : "r"(r56));
  // PTX:268 or.b16 %rs30, %rs21, %rs20
  asm("or.b16 %0, %1, %2;" : "=h"(rs30) : "h"(rs21), "h"(rs20));
  // PTX:270 $L__BB6_24:
L_BB6_24:;
  // PTX:271 setp.eq.s16 %p29, %rs30, 0
  p29 = (((short)(rs30)) == ((short)(0)));
  // PTX:272 mov.u32 %r83, %r5
  asm("mov.u32 %0, %1;" : "=r"(r83) : "r"(r5));
  // PTX:273 @%p29 bra $L__BB6_46
  if (p29) { goto L_BB6_46; }
  // PTX:275 mov.u16 %rs31, 1
  asm("mov.u16 %0, 1;" : "=h"(rs31) : );
  // PTX:276 @%p24 bra $L__BB6_27
  if (p24) { goto L_BB6_27; }
  // PTX:278 ld.global.u32 %r57, [%rd14]
  r57 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:279 ld.global.u32 %r58, [%rd27]
  r58 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))));
  // PTX:280 or.b32 %r59, %r58, %r57
  asm("or.b32 %0, %1, %2;" : "=r"(r59) : "r"(r58), "r"(r57));
  // PTX:281 setp.eq.s32 %p31, %r57, %r58
  p31 = (((int)(r57)) == ((int)(r58)));
  // PTX:282 selp.u16 %rs23, 1, 0, %p31
  rs23 = p31 ? 1 : 0;
  // PTX:283 shr.u32 %r60, %r59, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r60) : "r"(r59));
  // PTX:284 cvt.u16.u32 %rs24, %r60
  asm("cvt.u16.u32 %0, %1;" : "=h"(rs24) : "r"(r60));
  // PTX:285 or.b16 %rs31, %rs24, %rs23
  asm("or.b16 %0, %1, %2;" : "=h"(rs31) : "h"(rs24), "h"(rs23));
  // PTX:287 $L__BB6_27:
L_BB6_27:;
  // PTX:288 setp.eq.s16 %p32, %rs31, 0
  p32 = (((short)(rs31)) == ((short)(0)));
  // PTX:289 mov.u32 %r83, %r5
  asm("mov.u32 %0, %1;" : "=r"(r83) : "r"(r5));
  // PTX:290 @%p32 bra $L__BB6_46
  if (p32) { goto L_BB6_46; }
  // PTX:292 mov.u16 %rs32, 1
  asm("mov.u16 %0, 1;" : "=h"(rs32) : );
  // PTX:293 @%p24 bra $L__BB6_30
  if (p24) { goto L_BB6_30; }
  // PTX:295 ld.global.u32 %r61, [%rd14]
  r61 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:296 ld.global.u32 %r62, [%rd28]
  r62 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (0)))));
  // PTX:297 or.b32 %r63, %r62, %r61
  asm("or.b32 %0, %1, %2;" : "=r"(r63) : "r"(r62), "r"(r61));
  // PTX:298 setp.eq.s32 %p34, %r61, %r62
  p34 = (((int)(r61)) == ((int)(r62)));
  // PTX:299 selp.u16 %rs26, 1, 0, %p34
  rs26 = p34 ? 1 : 0;
  // PTX:300 shr.u32 %r64, %r63, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r64) : "r"(r63));
  // PTX:301 cvt.u16.u32 %rs27, %r64
  asm("cvt.u16.u32 %0, %1;" : "=h"(rs27) : "r"(r64));
  // PTX:302 or.b16 %rs32, %rs27, %rs26
  asm("or.b16 %0, %1, %2;" : "=h"(rs32) : "h"(rs27), "h"(rs26));
  // PTX:304 $L__BB6_30:
L_BB6_30:;
  // PTX:305 setp.eq.s16 %p35, %rs32, 0
  p35 = (((short)(rs32)) == ((short)(0)));
  // PTX:306 mov.u32 %r83, %r5
  asm("mov.u32 %0, %1;" : "=r"(r83) : "r"(r5));
  // PTX:307 @%p35 bra $L__BB6_46
  if (p35) { goto L_BB6_46; }
  // PTX:309 cvt.u32.u64 %r67, %rd26
  asm("cvt.u32.u64 %0, %1;" : "=r"(r67) : "l"(rd26));
  // PTX:310 cvt.u32.u64 %r68, %rd25
  asm("cvt.u32.u64 %0, %1;" : "=r"(r68) : "l"(rd25));
  // PTX:311 add.s32 %r69, %r68, %r2
  asm("add.s32 %0, %1, %2;" : "=r"(r69) : "r"(r68), "r"(r2));
  // PTX:312 mul.wide.s32 %rd71, %r69, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd71) : "r"(r69));
  // PTX:313 add.s64 %rd72, %rd2, %rd71
  asm("add.s64 %0, %1, %2;" : "=l"(rd72) : "l"(rd2), "l"(rd71));
  // PTX:314 add.s32 %r70, %r67, %r2
  asm("add.s32 %0, %1, %2;" : "=r"(r70) : "r"(r67), "r"(r2));
  // PTX:315 mul.wide.s32 %rd73, %r70, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd73) : "r"(r70));
  // PTX:316 add.s64 %rd74, %rd2, %rd73
  asm("add.s64 %0, %1, %2;" : "=l"(rd74) : "l"(rd2), "l"(rd73));
  // PTX:317 ld.global.f32 %f15, [%rd72]
  f15 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (0)))));
  // PTX:318 ld.global.f32 %f55, [%rd74]
  f55 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (0)))));
  // PTX:319 sub.f32 %f16, %f55, %f15
  asm("sub.f32 %0, %1, %2;" : "=f"(f16) : "f"(f55), "f"(f15));
  // PTX:320 ld.global.f32 %f17, [%rd72+4]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (4)))));
  // PTX:321 ld.global.f32 %f56, [%rd74+4]
  f56 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (4)))));
  // PTX:322 sub.f32 %f18, %f56, %f17
  asm("sub.f32 %0, %1, %2;" : "=f"(f18) : "f"(f56), "f"(f17));
  // PTX:323 ld.global.f32 %f19, [%rd72+8]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (8)))));
  // PTX:324 ld.global.f32 %f57, [%rd74+8]
  f57 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (8)))));
  // PTX:325 sub.f32 %f20, %f57, %f19
  asm("sub.f32 %0, %1, %2;" : "=f"(f20) : "f"(f57), "f"(f19));
  // PTX:326 sub.f32 %f21, %f1, %f15
  asm("sub.f32 %0, %1, %2;" : "=f"(f21) : "f"(f1), "f"(f15));
  // PTX:327 sub.f32 %f22, %f2, %f17
  asm("sub.f32 %0, %1, %2;" : "=f"(f22) : "f"(f2), "f"(f17));
  // PTX:328 sub.f32 %f23, %f3, %f19
  asm("sub.f32 %0, %1, %2;" : "=f"(f23) : "f"(f3), "f"(f19));
  // PTX:329 mul.f32 %f58, %f18, %f18
  asm("mul.f32 %0, %1, %2;" : "=f"(f58) : "f"(f18), "f"(f18));
  // PTX:330 fma.rn.f32 %f59, %f16, %f16, %f58
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f59) : "f"(f16), "f"(f16), "f"(f58));
  // PTX:331 fma.rn.f32 %f24, %f20, %f20, %f59
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f24) : "f"(f20), "f"(f20), "f"(f59));
  // PTX:332 mul.f32 %f60, %f18, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f60) : "f"(f18), "f"(f22));
  // PTX:333 fma.rn.f32 %f61, %f16, %f21, %f60
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f61) : "f"(f16), "f"(f21), "f"(f60));
  // PTX:334 fma.rn.f32 %f25, %f20, %f23, %f61
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f25) : "f"(f20), "f"(f23), "f"(f61));
  // PTX:335 setp.le.f32 %p36, %f24, 0f3727C5AC
  p36 = (!(isnan(((float)(f24))) || isnan(((float)(as_f32(0x3727C5ACu))))) && (((float)(f24)) <= ((float)(as_f32(0x3727C5ACu)))));
  // PTX:336 setp.le.f32 %p37, %f7, 0f3727C5AC
  p37 = (!(isnan(((float)(f7))) || isnan(((float)(as_f32(0x3727C5ACu))))) && (((float)(f7)) <= ((float)(as_f32(0x3727C5ACu)))));
  // PTX:337 and.pred %p38, %p37, %p36
  p38 = ((p37) && (p36));
  // PTX:338 mov.u32 %r80, 0
  asm("mov.u32 %0, 0;" : "=r"(r80) : );
  // PTX:339 mov.u32 %r81, %r80
  asm("mov.u32 %0, %1;" : "=r"(r81) : "r"(r80));
  // PTX:340 @%p38 bra $L__BB6_43
  if (p38) { goto L_BB6_43; }
  // PTX:342 setp.gtu.f32 %p39, %f7, 0f3727C5AC
  p39 = ((isnan(((float)(f7))) || isnan(((float)(as_f32(0x3727C5ACu))))) || (((float)(f7)) > ((float)(as_f32(0x3727C5ACu)))));
  // PTX:343 @%p39 bra $L__BB6_34
  if (p39) { goto L_BB6_34; }
  // PTX:344 bra.uni $L__BB6_33
  goto L_BB6_33;
  // PTX:346 $L__BB6_34:
L_BB6_34:;
  // PTX:347 sub.f32 %f107, %f3, %f19
  asm("sub.f32 %0, %1, %2;" : "=f"(f107) : "f"(f3), "f"(f19));
  // PTX:348 sub.f32 %f106, %f1, %f15
  asm("sub.f32 %0, %1, %2;" : "=f"(f106) : "f"(f1), "f"(f15));
  // PTX:349 sub.f32 %f105, %f2, %f17
  asm("sub.f32 %0, %1, %2;" : "=f"(f105) : "f"(f2), "f"(f17));
  // PTX:350 setp.gtu.f32 %p40, %f24, 0f3727C5AC
  p40 = ((isnan(((float)(f24))) || isnan(((float)(as_f32(0x3727C5ACu))))) || (((float)(f24)) > ((float)(as_f32(0x3727C5ACu)))));
  // PTX:351 mul.f32 %f64, %f5, %f105
  asm("mul.f32 %0, %1, %2;" : "=f"(f64) : "f"(f5), "f"(f105));
  // PTX:352 fma.rn.f32 %f65, %f4, %f106, %f64
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f65) : "f"(f4), "f"(f106), "f"(f64));
  // PTX:353 fma.rn.f32 %f26, %f6, %f107, %f65
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f26) : "f"(f6), "f"(f107), "f"(f65));
  // PTX:354 @%p40 bra $L__BB6_36
  if (p40) { goto L_BB6_36; }
  // PTX:355 bra.uni $L__BB6_35
  goto L_BB6_35;
  // PTX:357 $L__BB6_36:
L_BB6_36:;
  // PTX:358 mul.f32 %f70, %f5, %f18
  asm("mul.f32 %0, %1, %2;" : "=f"(f70) : "f"(f5), "f"(f18));
  // PTX:359 fma.rn.f32 %f71, %f4, %f16, %f70
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f71) : "f"(f4), "f"(f16), "f"(f70));
  // PTX:360 fma.rn.f32 %f27, %f6, %f20, %f71
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f27) : "f"(f6), "f"(f20), "f"(f71));
  // PTX:361 mul.f32 %f72, %f27, %f27
  asm("mul.f32 %0, %1, %2;" : "=f"(f72) : "f"(f27), "f"(f27));
  // PTX:362 neg.f32 %f73, %f72
  asm("neg.f32 %0, %1;" : "=f"(f73) : "f"(f72));
  // PTX:363 fma.rn.f32 %f74, %f7, %f24, %f73
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f74) : "f"(f7), "f"(f24), "f"(f73));
  // PTX:364 neg.f32 %f75, %f27
  asm("neg.f32 %0, %1;" : "=f"(f75) : "f"(f27));
  // PTX:365 fma.rn.f32 %f76, %f75, %f27, %f72
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f76) : "f"(f75), "f"(f27), "f"(f72));
  // PTX:366 add.f32 %f28, %f74, %f76
  asm("add.f32 %0, %1, %2;" : "=f"(f28) : "f"(f74), "f"(f76));
  // PTX:367 setp.leu.f32 %p41, %f28, 0f00000000
  p41 = ((isnan(((float)(f28))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f28)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:368 mov.f32 %f109, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f109) : );
  // PTX:369 @%p41 bra $L__BB6_38
  if (p41) { goto L_BB6_38; }
  // PTX:371 mul.f32 %f77, %f24, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f77) : "f"(f24), "f"(f26));
  // PTX:372 neg.f32 %f78, %f77
  asm("neg.f32 %0, %1;" : "=f"(f78) : "f"(f77));
  // PTX:373 fma.rn.f32 %f79, %f27, %f25, %f78
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f79) : "f"(f27), "f"(f25), "f"(f78));
  // PTX:374 neg.f32 %f80, %f26
  asm("neg.f32 %0, %1;" : "=f"(f80) : "f"(f26));
  // PTX:375 fma.rn.f32 %f81, %f80, %f24, %f77
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f81) : "f"(f80), "f"(f24), "f"(f77));
  // PTX:376 add.f32 %f82, %f79, %f81
  asm("add.f32 %0, %1, %2;" : "=f"(f82) : "f"(f79), "f"(f81));
  // PTX:377 div.rn.f32 %f83, %f82, %f28
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f83) : "f"(f82), "f"(f28));
  // PTX:378 cvt.sat.f32.f32 %f109, %f83
  asm("cvt.sat.f32.f32 %0, %1;" : "=f"(f109) : "f"(f83));
  // PTX:380 $L__BB6_38:
L_BB6_38:;
  // PTX:381 fma.rn.f32 %f84, %f27, %f109, %f25
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f84) : "f"(f27), "f"(f109), "f"(f25));
  // PTX:382 div.rn.f32 %f110, %f84, %f24
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f110) : "f"(f84), "f"(f24));
  // PTX:383 setp.lt.f32 %p42, %f110, 0f00000000
  p42 = (!(isnan(((float)(f110))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f110)) < ((float)(as_f32(0x00000000u)))));
  // PTX:384 @%p42 bra $L__BB6_41
  if (p42) { goto L_BB6_41; }
  // PTX:385 bra.uni $L__BB6_39
  goto L_BB6_39;
  // PTX:387 $L__BB6_41:
L_BB6_41:;
  // PTX:388 neg.f32 %f89, %f26
  asm("neg.f32 %0, %1;" : "=f"(f89) : "f"(f26));
  // PTX:389 div.rn.f32 %f90, %f89, %f7
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f90) : "f"(f89), "f"(f7));
  // PTX:390 mov.f32 %f110, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f110) : );
  // PTX:391 cvt.sat.f32.f32 %f109, %f90
  asm("cvt.sat.f32.f32 %0, %1;" : "=f"(f109) : "f"(f90));
  // PTX:392 bra.uni $L__BB6_42
  goto L_BB6_42;
  // PTX:394 $L__BB6_33:
L_BB6_33:;
  // PTX:395 mov.u32 %r80, 0
  asm("mov.u32 %0, 0;" : "=r"(r80) : );
  // PTX:396 div.rn.f32 %f62, %f25, %f24
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f62) : "f"(f25), "f"(f24));
  // PTX:397 cvt.sat.f32.f32 %f63, %f62
  asm("cvt.sat.f32.f32 %0, %1;" : "=f"(f63) : "f"(f62));
  // PTX:398 mov.b32 %r81, %f63
  asm("mov.b32 %0, %1;" : "=r"(r81) : "f"(f63));
  // PTX:399 bra.uni $L__BB6_43
  goto L_BB6_43;
  // PTX:401 $L__BB6_35:
L_BB6_35:;
  // PTX:402 mov.u32 %r81, 0
  asm("mov.u32 %0, 0;" : "=r"(r81) : );
  // PTX:403 neg.f32 %f66, %f26
  asm("neg.f32 %0, %1;" : "=f"(f66) : "f"(f26));
  // PTX:404 div.rn.f32 %f67, %f66, %f7
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f67) : "f"(f66), "f"(f7));
  // PTX:405 cvt.sat.f32.f32 %f68, %f67
  asm("cvt.sat.f32.f32 %0, %1;" : "=f"(f68) : "f"(f67));
  // PTX:406 mov.b32 %r80, %f68
  asm("mov.b32 %0, %1;" : "=r"(r80) : "f"(f68));
  // PTX:407 bra.uni $L__BB6_43
  goto L_BB6_43;
  // PTX:409 $L__BB6_39:
L_BB6_39:;
  // PTX:410 setp.leu.f32 %p43, %f110, 0f3F800000
  p43 = ((isnan(((float)(f110))) || isnan(((float)(as_f32(0x3F800000u))))) || (((float)(f110)) <= ((float)(as_f32(0x3F800000u)))));
  // PTX:411 @%p43 bra $L__BB6_42
  if (p43) { goto L_BB6_42; }
  // PTX:413 sub.f32 %f86, %f27, %f26
  asm("sub.f32 %0, %1, %2;" : "=f"(f86) : "f"(f27), "f"(f26));
  // PTX:414 div.rn.f32 %f87, %f86, %f7
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f87) : "f"(f86), "f"(f7));
  // PTX:415 cvt.sat.f32.f32 %f109, %f87
  asm("cvt.sat.f32.f32 %0, %1;" : "=f"(f109) : "f"(f87));
  // PTX:416 mov.f32 %f110, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f110) : );
  // PTX:418 $L__BB6_42:
L_BB6_42:;
  // PTX:419 mov.b32 %r81, %f110
  asm("mov.b32 %0, %1;" : "=r"(r81) : "f"(f110));
  // PTX:420 mov.b32 %r80, %f109
  asm("mov.b32 %0, %1;" : "=r"(r80) : "f"(f109));
  // PTX:422 $L__BB6_43:
L_BB6_43:;
  // PTX:423 mov.b32 %f91, %r80
  asm("mov.b32 %0, %1;" : "=f"(f91) : "r"(r80));
  // PTX:424 fma.rn.f32 %f92, %f4, %f91, %f1
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f92) : "f"(f4), "f"(f91), "f"(f1));
  // PTX:425 fma.rn.f32 %f93, %f5, %f91, %f2
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f93) : "f"(f5), "f"(f91), "f"(f2));
  // PTX:426 fma.rn.f32 %f94, %f6, %f91, %f3
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f94) : "f"(f6), "f"(f91), "f"(f3));
  // PTX:427 mov.b32 %f95, %r81
  asm("mov.b32 %0, %1;" : "=f"(f95) : "r"(r81));
  // PTX:428 fma.rn.f32 %f96, %f16, %f95, %f15
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f96) : "f"(f16), "f"(f95), "f"(f15));
  // PTX:429 fma.rn.f32 %f97, %f18, %f95, %f17
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f97) : "f"(f18), "f"(f95), "f"(f17));
  // PTX:430 fma.rn.f32 %f98, %f20, %f95, %f19
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f98) : "f"(f20), "f"(f95), "f"(f19));
  // PTX:431 sub.f32 %f99, %f92, %f96
  asm("sub.f32 %0, %1, %2;" : "=f"(f99) : "f"(f92), "f"(f96));
  // PTX:432 sub.f32 %f100, %f93, %f97
  asm("sub.f32 %0, %1, %2;" : "=f"(f100) : "f"(f93), "f"(f97));
  // PTX:433 sub.f32 %f101, %f94, %f98
  asm("sub.f32 %0, %1, %2;" : "=f"(f101) : "f"(f94), "f"(f98));
  // PTX:434 mul.f32 %f102, %f100, %f100
  asm("mul.f32 %0, %1, %2;" : "=f"(f102) : "f"(f100), "f"(f100));
  // PTX:435 fma.rn.f32 %f103, %f99, %f99, %f102
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f103) : "f"(f99), "f"(f99), "f"(f102));
  // PTX:436 fma.rn.f32 %f104, %f101, %f101, %f103
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f104) : "f"(f101), "f"(f101), "f"(f103));
  // PTX:437 setp.geu.f32 %p44, %f104, %f8
  p44 = ((isnan(((float)(f104))) || isnan(((float)(f8)))) || (((float)(f104)) >= ((float)(f8))));
  // PTX:438 mov.u32 %r83, %r5
  asm("mov.u32 %0, %1;" : "=r"(r83) : "r"(r5));
  // PTX:439 @%p44 bra $L__BB6_46
  if (p44) { goto L_BB6_46; }
  // PTX:441 cvt.s64.s32 %rd75, %r82
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd75) : "r"(r82));
  // PTX:442 add.s64 %rd76, %rd15, %rd75
  asm("add.s64 %0, %1, %2;" : "=l"(rd76) : "l"(rd15), "l"(rd75));
  // PTX:443 shl.b64 %rd77, %rd76, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd77) : "l"(rd76));
  // PTX:444 add.s64 %rd78, %rd20, %rd77
  asm("add.s64 %0, %1, %2;" : "=l"(rd78) : "l"(rd20), "l"(rd77));
  // PTX:445 st.global.u32 [%rd78], %r9
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd78) + (0))))) = (unsigned)(r9);
  // PTX:446 add.s32 %r82, %r82, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r82) : "r"(r82));
  // PTX:447 mov.u32 %r83, %r5
  asm("mov.u32 %0, %1;" : "=r"(r83) : "r"(r5));
  // PTX:449 $L__BB6_46:
L_BB6_46:;
  // PTX:450 ld.param.u32 %r73, [_ZN7synreal21self_collision_kernel15query_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS_4AabbESB_PKNS2_ILi2EiLS3_0EEESB_fPiSI_mmmi_param_13]
  r73 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param13 + (0))));
  // PTX:451 setp.lt.s32 %p45, %r82, %r73
  p45 = (((int)(r82)) < ((int)(r73)));
  // PTX:452 setp.gt.s32 %p46, %r83, -1
  p46 = (((int)(r83)) > ((int)(-1)));
  // PTX:453 and.pred %p47, %p45, %p46
  p47 = ((p45) && (p46));
  // PTX:454 @%p47 bra $L__BB6_6
  if (p47) { goto L_BB6_6; }
  // PTX:456 $L__BB6_47:
L_BB6_47:;
  // PTX:457 ld.param.u64 %rd85, [_ZN7synreal21self_collision_kernel15query_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS_4AabbESB_PKNS2_ILi2EiLS3_0EEESB_fPiSI_mmmi_param_8]
  rd85 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:458 mov.u32 %r76, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r76) : "r"(blockDim.x));
  // PTX:459 mov.u32 %r75, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r75) : "r"(blockIdx.x));
  // PTX:460 mov.u32 %r74, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r74) : "r"(threadIdx.x));
  // PTX:461 cvt.u64.u32 %rd84, %r74
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd84) : "r"(r74));
  // PTX:462 mul.wide.u32 %rd83, %r75, %r76
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd83) : "r"(r75), "r"(r76));
  // PTX:463 add.s64 %rd82, %rd83, %rd84
  asm("add.s64 %0, %1, %2;" : "=l"(rd82) : "l"(rd83), "l"(rd84));
  // PTX:464 cvta.to.global.u64 %rd79, %rd85
  rd79 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd85));
  // PTX:465 shl.b64 %rd80, %rd82, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd80) : "l"(rd82));
  // PTX:466 add.s64 %rd81, %rd79, %rd80
  asm("add.s64 %0, %1, %2;" : "=l"(rd81) : "l"(rd79), "l"(rd80));
  // PTX:467 st.global.u32 [%rd81], %r82
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (0))))) = (unsigned)(r82);
  // PTX:469 $L__BB6_48:
L_BB6_48:;
  // PTX:470 ret
  return;
}
