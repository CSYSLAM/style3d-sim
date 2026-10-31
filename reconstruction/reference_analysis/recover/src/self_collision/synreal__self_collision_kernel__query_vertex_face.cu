// 机械还原自 PTX：synreal::self_collision_kernel::query_vertex_face(glm::vec<3, float, (glm::qualifier)0> const*, int const*, float const*, glm::vec<3, int, (glm::qualifier)0> const*, int const*, synreal::Aabb const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, int const*, float, float, bool, int*, int*, unsigned long, unsigned long, unsigned long, unsigned long, int)
// PTX SHA256: 1ed2e9601b3be669774113de6881031636d0fd21c4cd1b216dc6823b834589f5
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__self_collision_kernel__query_vertex_face(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, float param9, float param10, unsigned char param11, unsigned long long param12, unsigned long long param13, unsigned long long param14, unsigned long long param15, unsigned long long param16, unsigned long long param17, unsigned param18) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57, p58, p59, p60, p61, p62;
  unsigned short rs0, rs1, rs2, rs3, rs4, rs5, rs6, rs7, rs8, rs9, rs10, rs11, rs12, rs13, rs14, rs15, rs16, rs17, rs18, rs19, rs20, rs21, rs22, rs23, rs24, rs25, rs26, rs27, rs28;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95;
  // PTX:36 ld.param.u64 %rd40, [_ZN7synreal21self_collision_kernel17query_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_ffbPiSK_mmmmi_param_0]
  rd40 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:37 ld.param.u64 %rd27, [_ZN7synreal21self_collision_kernel17query_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_ffbPiSK_mmmmi_param_1]
  rd27 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:38 ld.param.u64 %rd28, [_ZN7synreal21self_collision_kernel17query_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_ffbPiSK_mmmmi_param_2]
  rd28 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:39 ld.param.u64 %rd29, [_ZN7synreal21self_collision_kernel17query_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_ffbPiSK_mmmmi_param_3]
  rd29 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:40 ld.param.u64 %rd30, [_ZN7synreal21self_collision_kernel17query_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_ffbPiSK_mmmmi_param_4]
  rd30 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:41 ld.param.u64 %rd31, [_ZN7synreal21self_collision_kernel17query_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_ffbPiSK_mmmmi_param_5]
  rd31 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:42 ld.param.u64 %rd32, [_ZN7synreal21self_collision_kernel17query_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_ffbPiSK_mmmmi_param_6]
  rd32 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:43 ld.param.u64 %rd33, [_ZN7synreal21self_collision_kernel17query_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_ffbPiSK_mmmmi_param_7]
  rd33 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:44 ld.param.u64 %rd34, [_ZN7synreal21self_collision_kernel17query_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_ffbPiSK_mmmmi_param_8]
  rd34 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:45 ld.param.f32 %f243, [_ZN7synreal21self_collision_kernel17query_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_ffbPiSK_mmmmi_param_9]
  f243 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param9 + (0))));
  // PTX:46 ld.param.f32 %f75, [_ZN7synreal21self_collision_kernel17query_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_ffbPiSK_mmmmi_param_10]
  f75 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param10 + (0))));
  // PTX:47 ld.param.u64 %rd36, [_ZN7synreal21self_collision_kernel17query_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_ffbPiSK_mmmmi_param_13]
  rd36 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:48 ld.param.u64 %rd41, [_ZN7synreal21self_collision_kernel17query_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_ffbPiSK_mmmmi_param_14]
  rd41 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:49 ld.param.u64 %rd37, [_ZN7synreal21self_collision_kernel17query_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_ffbPiSK_mmmmi_param_15]
  rd37 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param15 + (0))));
  // PTX:50 ld.param.u64 %rd38, [_ZN7synreal21self_collision_kernel17query_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_ffbPiSK_mmmmi_param_16]
  rd38 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param16 + (0))));
  // PTX:51 ld.param.u64 %rd39, [_ZN7synreal21self_collision_kernel17query_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_ffbPiSK_mmmmi_param_17]
  rd39 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param17 + (0))));
  // PTX:52 ld.param.u32 %r14, [_ZN7synreal21self_collision_kernel17query_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_ffbPiSK_mmmmi_param_18]
  r14 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param18 + (0))));
  // PTX:53 cvta.to.global.u64 %rd1, %rd30
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd30));
  // PTX:54 cvta.to.global.u64 %rd2, %rd40
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd40));
  // PTX:55 mov.u32 %r15, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r15) : "r"(blockIdx.x));
  // PTX:56 mov.u32 %r16, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r16) : "r"(blockDim.x));
  // PTX:57 mul.wide.u32 %rd42, %r15, %r16
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd42) : "r"(r15), "r"(r16));
  // PTX:58 mov.u32 %r17, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r17) : "r"(threadIdx.x));
  // PTX:59 cvt.u64.u32 %rd43, %r17
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd43) : "r"(r17));
  // PTX:60 add.s64 %rd3, %rd42, %rd43
  asm("add.s64 %0, %1, %2;" : "=l"(rd3) : "l"(rd42), "l"(rd43));
  // PTX:61 setp.ge.u64 %p1, %rd3, %rd41
  p1 = (((unsigned long long)(rd3)) >= ((unsigned long long)(rd41)));
  // PTX:62 @%p1 bra $L__BB4_57
  if (p1) { goto L_BB4_57; }
  // PTX:64 or.b64 %rd44, %rd3, %rd37
  asm("or.b64 %0, %1, %2;" : "=l"(rd44) : "l"(rd3), "l"(rd37));
  // PTX:65 and.b64 %rd45, %rd44, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd45) : "l"(rd44));
  // PTX:66 setp.eq.s64 %p2, %rd45, 0
  p2 = (((long long)(rd45)) == ((long long)(0)));
  // PTX:67 @%p2 bra $L__BB4_3
  if (p2) { goto L_BB4_3; }
  // PTX:69 div.u64 %rd94, %rd3, %rd37
  asm("div.u64 %0, %1, %2;" : "=l"(rd94) : "l"(rd3), "l"(rd37));
  // PTX:70 mul.lo.s64 %rd46, %rd94, %rd37
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd46) : "l"(rd94), "l"(rd37));
  // PTX:71 sub.s64 %rd95, %rd3, %rd46
  asm("sub.s64 %0, %1, %2;" : "=l"(rd95) : "l"(rd3), "l"(rd46));
  // PTX:72 bra.uni $L__BB4_4
  goto L_BB4_4;
  // PTX:74 $L__BB4_3:
L_BB4_3:;
  // PTX:75 cvt.u32.u64 %r18, %rd37
  asm("cvt.u32.u64 %0, %1;" : "=r"(r18) : "l"(rd37));
  // PTX:76 cvt.u32.u64 %r19, %rd3
  asm("cvt.u32.u64 %0, %1;" : "=r"(r19) : "l"(rd3));
  // PTX:77 div.u32 %r20, %r19, %r18
  asm("div.u32 %0, %1, %2;" : "=r"(r20) : "r"(r19), "r"(r18));
  // PTX:78 mul.lo.s32 %r21, %r20, %r18
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r21) : "r"(r20), "r"(r18));
  // PTX:79 sub.s32 %r22, %r19, %r21
  asm("sub.s32 %0, %1, %2;" : "=r"(r22) : "r"(r19), "r"(r21));
  // PTX:80 cvt.u64.u32 %rd94, %r20
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd94) : "r"(r20));
  // PTX:81 cvt.u64.u32 %rd95, %r22
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd95) : "r"(r22));
  // PTX:83 $L__BB4_4:
L_BB4_4:;
  // PTX:84 cvta.to.global.u64 %rd47, %rd27
  rd47 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd27));
  // PTX:85 shl.b64 %rd48, %rd95, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd48) : "l"(rd95));
  // PTX:86 add.s64 %rd49, %rd47, %rd48
  asm("add.s64 %0, %1, %2;" : "=l"(rd49) : "l"(rd47), "l"(rd48));
  // PTX:87 ld.global.s32 %rd10, [%rd49]
  rd10 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))));
  // PTX:88 mul.lo.s64 %rd11, %rd94, %rd39
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd11) : "l"(rd94), "l"(rd39));
  // PTX:89 add.s64 %rd50, %rd11, %rd10
  asm("add.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd11), "l"(rd10));
  // PTX:90 mul.lo.s64 %rd51, %rd50, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd51) : "l"(rd50));
  // PTX:91 add.s64 %rd52, %rd2, %rd51
  asm("add.s64 %0, %1, %2;" : "=l"(rd52) : "l"(rd2), "l"(rd51));
  // PTX:92 ld.global.f32 %f1, [%rd52]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))));
  // PTX:93 ld.global.f32 %f2, [%rd52+4]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (4)))));
  // PTX:94 ld.global.f32 %f3, [%rd52+8]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (8)))));
  // PTX:95 setp.eq.s64 %p3, %rd28, 0
  p3 = (((long long)(rd28)) == ((long long)(0)));
  // PTX:96 @%p3 bra $L__BB4_6
  if (p3) { goto L_BB4_6; }
  // PTX:98 cvta.to.global.u64 %rd53, %rd28
  rd53 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd28));
  // PTX:99 shl.b64 %rd54, %rd10, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd54) : "l"(rd10));
  // PTX:100 add.s64 %rd55, %rd53, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd55) : "l"(rd53), "l"(rd54));
  // PTX:101 ld.global.f32 %f243, [%rd55]
  f243 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))));
  // PTX:103 $L__BB4_6:
L_BB4_6:;
  // PTX:104 cvt.u32.u64 %r24, %rd38
  asm("cvt.u32.u64 %0, %1;" : "=r"(r24) : "l"(rd38));
  // PTX:105 add.s32 %r1, %r24, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r1) : "r"(r24));
  // PTX:106 setp.lt.s32 %p4, %r14, 1
  p4 = (((int)(r14)) < ((int)(1)));
  // PTX:107 mov.u32 %r62, 0
  asm("mov.u32 %0, 0;" : "=r"(r62) : );
  // PTX:108 @%p4 bra $L__BB4_56
  if (p4) { goto L_BB4_56; }
  // PTX:110 add.f32 %f76, %f243, %f75
  asm("add.f32 %0, %1, %2;" : "=f"(f76) : "f"(f243), "f"(f75));
  // PTX:111 mul.f32 %f77, %f76, 0f3FC00000
  asm("mul.f32 %0, %1, 0f3FC00000;" : "=f"(f77) : "f"(f76));
  // PTX:112 shl.b64 %rd56, %rd10, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd56) : "l"(rd10));
  // PTX:113 add.s64 %rd12, %rd1, %rd56
  asm("add.s64 %0, %1, %2;" : "=l"(rd12) : "l"(rd1), "l"(rd56));
  // PTX:114 cvt.u32.u64 %r2, %rd11
  asm("cvt.u32.u64 %0, %1;" : "=r"(r2) : "l"(rd11));
  // PTX:115 cvt.s64.s32 %rd57, %r14
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd57) : "r"(r14));
  // PTX:116 mul.lo.s64 %rd13, %rd3, %rd57
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd13) : "l"(rd3), "l"(rd57));
  // PTX:117 cvta.to.global.u64 %rd14, %rd36
  rd14 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd36));
  // PTX:118 cvta.to.global.u64 %rd15, %rd29
  rd15 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd29));
  // PTX:119 cvta.to.global.u64 %rd16, %rd34
  rd16 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd34));
  // PTX:120 cvta.to.global.u64 %rd17, %rd31
  rd17 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd31));
  // PTX:121 cvta.to.global.u64 %rd18, %rd33
  rd18 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd33));
  // PTX:122 cvta.to.global.u64 %rd19, %rd32
  rd19 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd32));
  // PTX:123 mul.f32 %f6, %f77, %f77
  asm("mul.f32 %0, %1, %2;" : "=f"(f6) : "f"(f77), "f"(f77));
  // PTX:124 shl.b64 %rd58, %rd38, 1
  asm("shl.b64 %0, %1, 1;" : "=l"(rd58) : "l"(rd38));
  // PTX:125 add.s64 %rd59, %rd58, -1
  asm("add.s64 %0, %1, -1;" : "=l"(rd59) : "l"(rd58));
  // PTX:126 mul.lo.s64 %rd20, %rd94, %rd59
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd20) : "l"(rd94), "l"(rd59));
  // PTX:127 add.f32 %f7, %f3, %f243
  asm("add.f32 %0, %1, %2;" : "=f"(f7) : "f"(f3), "f"(f243));
  // PTX:128 add.f32 %f8, %f2, %f243
  asm("add.f32 %0, %1, %2;" : "=f"(f8) : "f"(f2), "f"(f243));
  // PTX:129 add.f32 %f9, %f1, %f243
  asm("add.f32 %0, %1, %2;" : "=f"(f9) : "f"(f1), "f"(f243));
  // PTX:130 sub.f32 %f10, %f3, %f243
  asm("sub.f32 %0, %1, %2;" : "=f"(f10) : "f"(f3), "f"(f243));
  // PTX:131 sub.f32 %f11, %f2, %f243
  asm("sub.f32 %0, %1, %2;" : "=f"(f11) : "f"(f2), "f"(f243));
  // PTX:132 sub.f32 %f12, %f1, %f243
  asm("sub.f32 %0, %1, %2;" : "=f"(f12) : "f"(f1), "f"(f243));
  // PTX:133 mov.u32 %r63, 0
  asm("mov.u32 %0, 0;" : "=r"(r63) : );
  // PTX:134 mov.u32 %r60, -1
  asm("mov.u32 %0, -1;" : "=r"(r60) : );
  // PTX:135 mov.u32 %r62, %r63
  asm("mov.u32 %0, %1;" : "=r"(r62) : "r"(r63));
  // PTX:137 $L__BB4_8:
L_BB4_8:;
  // PTX:138 mov.u32 %r4, %r60
  asm("mov.u32 %0, %1;" : "=r"(r4) : "r"(r60));
  // PTX:139 mov.u32 %r60, %r63
  asm("mov.u32 %0, %1;" : "=r"(r60) : "r"(r63));
  // PTX:140 cvt.s64.s32 %rd21, %r60
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd21) : "r"(r60));
  // PTX:141 mul.wide.s32 %rd60, %r60, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd60) : "r"(r60));
  // PTX:142 add.s64 %rd61, %rd19, %rd60
  asm("add.s64 %0, %1, %2;" : "=l"(rd61) : "l"(rd19), "l"(rd60));
  // PTX:143 ld.global.u32 %r63, [%rd61]
  r63 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))));
  // PTX:144 setp.eq.s32 %p5, %r4, %r63
  p5 = (((int)(r4)) == ((int)(r63)));
  // PTX:145 mul.wide.s32 %rd62, %r60, 8
  asm("mul.wide.s32 %0, %1, 8;" : "=l"(rd62) : "r"(r60));
  // PTX:146 add.s64 %rd22, %rd18, %rd62
  asm("add.s64 %0, %1, %2;" : "=l"(rd22) : "l"(rd18), "l"(rd62));
  // PTX:147 @%p5 bra $L__BB4_12
  if (p5) { goto L_BB4_12; }
  // PTX:148 bra.uni $L__BB4_9
  goto L_BB4_9;
  // PTX:150 $L__BB4_12:
L_BB4_12:;
  // PTX:151 add.s64 %rd63, %rd20, %rd21
  asm("add.s64 %0, %1, %2;" : "=l"(rd63) : "l"(rd20), "l"(rd21));
  // PTX:152 mul.lo.s64 %rd64, %rd63, 24
  asm("mul.lo.s64 %0, %1, 24;" : "=l"(rd64) : "l"(rd63));
  // PTX:153 add.s64 %rd65, %rd17, %rd64
  asm("add.s64 %0, %1, %2;" : "=l"(rd65) : "l"(rd17), "l"(rd64));
  // PTX:154 add.s64 %rd23, %rd65, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd23) : "l"(rd65));
  // PTX:155 ld.global.f32 %f78, [%rd65+12]
  f78 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (12)))));
  // PTX:156 setp.gtu.f32 %p8, %f12, %f78
  p8 = ((isnan(((float)(f12))) || isnan(((float)(f78)))) || (((float)(f12)) > ((float)(f78))));
  // PTX:157 mov.u16 %rs25, 0
  asm("mov.u16 %0, 0;" : "=h"(rs25) : );
  // PTX:158 @%p8 bra $L__BB4_18
  if (p8) { goto L_BB4_18; }
  // PTX:160 ld.global.f32 %f79, [%rd23+-12]
  f79 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (-12)))));
  // PTX:161 setp.ltu.f32 %p9, %f9, %f79
  p9 = ((isnan(((float)(f9))) || isnan(((float)(f79)))) || (((float)(f9)) < ((float)(f79))));
  // PTX:162 @%p9 bra $L__BB4_18
  if (p9) { goto L_BB4_18; }
  // PTX:164 ld.global.f32 %f80, [%rd23+4]
  f80 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (4)))));
  // PTX:165 setp.gtu.f32 %p10, %f11, %f80
  p10 = ((isnan(((float)(f11))) || isnan(((float)(f80)))) || (((float)(f11)) > ((float)(f80))));
  // PTX:166 @%p10 bra $L__BB4_18
  if (p10) { goto L_BB4_18; }
  // PTX:168 ld.global.f32 %f81, [%rd23+-8]
  f81 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (-8)))));
  // PTX:169 setp.ltu.f32 %p11, %f8, %f81
  p11 = ((isnan(((float)(f8))) || isnan(((float)(f81)))) || (((float)(f8)) < ((float)(f81))));
  // PTX:170 @%p11 bra $L__BB4_18
  if (p11) { goto L_BB4_18; }
  // PTX:172 ld.global.f32 %f82, [%rd23+8]
  f82 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (8)))));
  // PTX:173 setp.gtu.f32 %p12, %f10, %f82
  p12 = ((isnan(((float)(f10))) || isnan(((float)(f82)))) || (((float)(f10)) > ((float)(f82))));
  // PTX:174 @%p12 bra $L__BB4_18
  if (p12) { goto L_BB4_18; }
  // PTX:176 ld.global.f32 %f83, [%rd23+-4]
  f83 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (-4)))));
  // PTX:177 setp.ge.f32 %p13, %f7, %f83
  p13 = (!(isnan(((float)(f7))) || isnan(((float)(f83)))) && (((float)(f7)) >= ((float)(f83))));
  // PTX:178 selp.u16 %rs25, 1, 0, %p13
  rs25 = p13 ? 1 : 0;
  // PTX:180 $L__BB4_18:
L_BB4_18:;
  // PTX:181 setp.eq.s16 %p14, %rs25, 0
  p14 = (((short)(rs25)) == ((short)(0)));
  // PTX:182 mov.u32 %r63, %r4
  asm("mov.u32 %0, %1;" : "=r"(r63) : "r"(r4));
  // PTX:183 @%p14 bra $L__BB4_55
  if (p14) { goto L_BB4_55; }
  // PTX:185 cvt.u32.u64 %r30, %rd21
  asm("cvt.u32.u64 %0, %1;" : "=r"(r30) : "l"(rd21));
  // PTX:186 setp.lt.s32 %p15, %r30, %r1
  p15 = (((int)(r30)) < ((int)(r1)));
  // PTX:187 @%p15 bra $L__BB4_54
  if (p15) { goto L_BB4_54; }
  // PTX:188 bra.uni $L__BB4_20
  goto L_BB4_20;
  // PTX:190 $L__BB4_54:
L_BB4_54:;
  // PTX:191 ld.global.u32 %r63, [%rd22]
  r63 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (0)))));
  // PTX:192 bra.uni $L__BB4_55
  goto L_BB4_55;
  // PTX:194 $L__BB4_9:
L_BB4_9:;
  // PTX:195 cvt.u32.u64 %r28, %rd21
  asm("cvt.u32.u64 %0, %1;" : "=r"(r28) : "l"(rd21));
  // PTX:196 setp.ge.s32 %p6, %r28, %r1
  p6 = (((int)(r28)) >= ((int)(r1)));
  // PTX:197 @%p6 bra $L__BB4_55
  if (p6) { goto L_BB4_55; }
  // PTX:199 ld.global.u32 %r29, [%rd22]
  r29 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (0)))));
  // PTX:200 setp.ne.s32 %p7, %r4, %r29
  p7 = (((int)(r4)) != ((int)(r29)));
  // PTX:201 @%p7 bra $L__BB4_55
  if (p7) { goto L_BB4_55; }
  // PTX:203 ld.global.u32 %r63, [%rd22+4]
  r63 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (4)))));
  // PTX:204 bra.uni $L__BB4_55
  goto L_BB4_55;
  // PTX:206 $L__BB4_20:
L_BB4_20:;
  // PTX:207 ld.param.s8 %rs24, [_ZN7synreal21self_collision_kernel17query_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_ffbPiSK_mmmmi_param_11]
  rs24 = (*reinterpret_cast<volatile signed char*>(((uintptr_t)&param11 + (0))));
  // PTX:208 sub.s32 %r32, %r30, %r1
  asm("sub.s32 %0, %1, %2;" : "=r"(r32) : "r"(r30), "r"(r1));
  // PTX:209 mul.wide.s32 %rd66, %r32, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd66) : "r"(r32));
  // PTX:210 add.s64 %rd67, %rd16, %rd66
  asm("add.s64 %0, %1, %2;" : "=l"(rd67) : "l"(rd16), "l"(rd66));
  // PTX:211 ld.global.u32 %r8, [%rd67]
  r8 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0)))));
  // PTX:212 mul.wide.s32 %rd68, %r8, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd68) : "r"(r8));
  // PTX:213 add.s64 %rd69, %rd15, %rd68
  asm("add.s64 %0, %1, %2;" : "=l"(rd69) : "l"(rd15), "l"(rd68));
  // PTX:214 ld.global.s32 %rd24, [%rd69]
  rd24 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (0)))));
  // PTX:215 ld.global.s32 %rd25, [%rd69+4]
  rd25 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (4)))));
  // PTX:216 ld.global.s32 %rd26, [%rd69+8]
  rd26 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (8)))));
  // PTX:217 setp.eq.s16 %p16, %rs24, 0
  p16 = (((short)(rs24)) == ((short)(0)));
  // PTX:218 @%p16 bra $L__BB4_22
  if (p16) { goto L_BB4_22; }
  // PTX:220 cvt.u32.u64 %r33, %rd10
  asm("cvt.u32.u64 %0, %1;" : "=r"(r33) : "l"(rd10));
  // PTX:221 cvt.u32.u64 %r34, %rd24
  asm("cvt.u32.u64 %0, %1;" : "=r"(r34) : "l"(rd24));
  // PTX:222 setp.eq.s32 %p17, %r33, %r34
  p17 = (((int)(r33)) == ((int)(r34)));
  // PTX:223 cvt.u32.u64 %r35, %rd25
  asm("cvt.u32.u64 %0, %1;" : "=r"(r35) : "l"(rd25));
  // PTX:224 setp.eq.s32 %p18, %r33, %r35
  p18 = (((int)(r33)) == ((int)(r35)));
  // PTX:225 or.pred %p19, %p17, %p18
  p19 = ((p17) || (p18));
  // PTX:226 cvt.u32.u64 %r36, %rd26
  asm("cvt.u32.u64 %0, %1;" : "=r"(r36) : "l"(rd26));
  // PTX:227 setp.eq.s32 %p20, %r33, %r36
  p20 = (((int)(r33)) == ((int)(r36)));
  // PTX:228 or.pred %p21, %p19, %p20
  p21 = ((p19) || (p20));
  // PTX:229 mov.u32 %r63, %r4
  asm("mov.u32 %0, %1;" : "=r"(r63) : "r"(r4));
  // PTX:230 @%p21 bra $L__BB4_55
  if (p21) { goto L_BB4_55; }
  // PTX:232 $L__BB4_22:
L_BB4_22:;
  // PTX:233 ld.param.u64 %rd93, [_ZN7synreal21self_collision_kernel17query_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_ffbPiSK_mmmmi_param_4]
  rd93 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:234 setp.eq.s64 %p22, %rd93, 0
  p22 = (((long long)(rd93)) == ((long long)(0)));
  // PTX:235 mov.u16 %rs26, 1
  asm("mov.u16 %0, 1;" : "=h"(rs26) : );
  // PTX:236 @%p22 bra $L__BB4_24
  if (p22) { goto L_BB4_24; }
  // PTX:238 ld.global.u32 %r37, [%rd12]
  r37 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (0)))));
  // PTX:239 shl.b64 %rd70, %rd24, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd70) : "l"(rd24));
  // PTX:240 add.s64 %rd71, %rd1, %rd70
  asm("add.s64 %0, %1, %2;" : "=l"(rd71) : "l"(rd1), "l"(rd70));
  // PTX:241 ld.global.u32 %r38, [%rd71]
  r38 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))));
  // PTX:242 or.b32 %r39, %r38, %r37
  asm("or.b32 %0, %1, %2;" : "=r"(r39) : "r"(r38), "r"(r37));
  // PTX:243 setp.eq.s32 %p23, %r37, %r38
  p23 = (((int)(r37)) == ((int)(r38)));
  // PTX:244 selp.u16 %rs16, 1, 0, %p23
  rs16 = p23 ? 1 : 0;
  // PTX:245 shr.u32 %r40, %r39, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r40) : "r"(r39));
  // PTX:246 cvt.u16.u32 %rs17, %r40
  asm("cvt.u16.u32 %0, %1;" : "=h"(rs17) : "r"(r40));
  // PTX:247 or.b16 %rs26, %rs17, %rs16
  asm("or.b16 %0, %1, %2;" : "=h"(rs26) : "h"(rs17), "h"(rs16));
  // PTX:249 $L__BB4_24:
L_BB4_24:;
  // PTX:250 setp.eq.s16 %p24, %rs26, 0
  p24 = (((short)(rs26)) == ((short)(0)));
  // PTX:251 mov.u32 %r63, %r4
  asm("mov.u32 %0, %1;" : "=r"(r63) : "r"(r4));
  // PTX:252 @%p24 bra $L__BB4_55
  if (p24) { goto L_BB4_55; }
  // PTX:254 mov.u16 %rs27, 1
  asm("mov.u16 %0, 1;" : "=h"(rs27) : );
  // PTX:255 @%p22 bra $L__BB4_27
  if (p22) { goto L_BB4_27; }
  // PTX:257 ld.global.u32 %r41, [%rd12]
  r41 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (0)))));
  // PTX:258 shl.b64 %rd72, %rd25, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd72) : "l"(rd25));
  // PTX:259 add.s64 %rd73, %rd1, %rd72
  asm("add.s64 %0, %1, %2;" : "=l"(rd73) : "l"(rd1), "l"(rd72));
  // PTX:260 ld.global.u32 %r42, [%rd73]
  r42 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (0)))));
  // PTX:261 or.b32 %r43, %r42, %r41
  asm("or.b32 %0, %1, %2;" : "=r"(r43) : "r"(r42), "r"(r41));
  // PTX:262 setp.eq.s32 %p26, %r41, %r42
  p26 = (((int)(r41)) == ((int)(r42)));
  // PTX:263 selp.u16 %rs19, 1, 0, %p26
  rs19 = p26 ? 1 : 0;
  // PTX:264 shr.u32 %r44, %r43, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r44) : "r"(r43));
  // PTX:265 cvt.u16.u32 %rs20, %r44
  asm("cvt.u16.u32 %0, %1;" : "=h"(rs20) : "r"(r44));
  // PTX:266 or.b16 %rs27, %rs20, %rs19
  asm("or.b16 %0, %1, %2;" : "=h"(rs27) : "h"(rs20), "h"(rs19));
  // PTX:268 $L__BB4_27:
L_BB4_27:;
  // PTX:269 setp.eq.s16 %p27, %rs27, 0
  p27 = (((short)(rs27)) == ((short)(0)));
  // PTX:270 mov.u32 %r63, %r4
  asm("mov.u32 %0, %1;" : "=r"(r63) : "r"(r4));
  // PTX:271 @%p27 bra $L__BB4_55
  if (p27) { goto L_BB4_55; }
  // PTX:273 mov.u16 %rs28, 1
  asm("mov.u16 %0, 1;" : "=h"(rs28) : );
  // PTX:274 @%p22 bra $L__BB4_30
  if (p22) { goto L_BB4_30; }
  // PTX:276 ld.global.u32 %r45, [%rd12]
  r45 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (0)))));
  // PTX:277 shl.b64 %rd74, %rd26, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd74) : "l"(rd26));
  // PTX:278 add.s64 %rd75, %rd1, %rd74
  asm("add.s64 %0, %1, %2;" : "=l"(rd75) : "l"(rd1), "l"(rd74));
  // PTX:279 ld.global.u32 %r46, [%rd75]
  r46 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (0)))));
  // PTX:280 or.b32 %r47, %r46, %r45
  asm("or.b32 %0, %1, %2;" : "=r"(r47) : "r"(r46), "r"(r45));
  // PTX:281 setp.eq.s32 %p29, %r45, %r46
  p29 = (((int)(r45)) == ((int)(r46)));
  // PTX:282 selp.u16 %rs22, 1, 0, %p29
  rs22 = p29 ? 1 : 0;
  // PTX:283 shr.u32 %r48, %r47, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r48) : "r"(r47));
  // PTX:284 cvt.u16.u32 %rs23, %r48
  asm("cvt.u16.u32 %0, %1;" : "=h"(rs23) : "r"(r48));
  // PTX:285 or.b16 %rs28, %rs23, %rs22
  asm("or.b16 %0, %1, %2;" : "=h"(rs28) : "h"(rs23), "h"(rs22));
  // PTX:287 $L__BB4_30:
L_BB4_30:;
  // PTX:288 setp.eq.s16 %p30, %rs28, 0
  p30 = (((short)(rs28)) == ((short)(0)));
  // PTX:289 mov.u32 %r63, %r4
  asm("mov.u32 %0, %1;" : "=r"(r63) : "r"(r4));
  // PTX:290 @%p30 bra $L__BB4_55
  if (p30) { goto L_BB4_55; }
  // PTX:292 cvt.u32.u64 %r49, %rd26
  asm("cvt.u32.u64 %0, %1;" : "=r"(r49) : "l"(rd26));
  // PTX:293 cvt.u32.u64 %r50, %rd24
  asm("cvt.u32.u64 %0, %1;" : "=r"(r50) : "l"(rd24));
  // PTX:294 add.s32 %r51, %r50, %r2
  asm("add.s32 %0, %1, %2;" : "=r"(r51) : "r"(r50), "r"(r2));
  // PTX:295 mul.wide.s32 %rd76, %r51, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd76) : "r"(r51));
  // PTX:296 add.s64 %rd77, %rd2, %rd76
  asm("add.s64 %0, %1, %2;" : "=l"(rd77) : "l"(rd2), "l"(rd76));
  // PTX:297 cvt.u32.u64 %r52, %rd25
  asm("cvt.u32.u64 %0, %1;" : "=r"(r52) : "l"(rd25));
  // PTX:298 add.s32 %r53, %r52, %r2
  asm("add.s32 %0, %1, %2;" : "=r"(r53) : "r"(r52), "r"(r2));
  // PTX:299 mul.wide.s32 %rd78, %r53, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd78) : "r"(r53));
  // PTX:300 add.s64 %rd79, %rd2, %rd78
  asm("add.s64 %0, %1, %2;" : "=l"(rd79) : "l"(rd2), "l"(rd78));
  // PTX:301 add.s32 %r54, %r49, %r2
  asm("add.s32 %0, %1, %2;" : "=r"(r54) : "r"(r49), "r"(r2));
  // PTX:302 mul.wide.s32 %rd80, %r54, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd80) : "r"(r54));
  // PTX:303 add.s64 %rd81, %rd2, %rd80
  asm("add.s64 %0, %1, %2;" : "=l"(rd81) : "l"(rd2), "l"(rd80));
  // PTX:304 ld.global.f32 %f13, [%rd77]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (0)))));
  // PTX:305 ld.global.f32 %f14, [%rd79]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (0)))));
  // PTX:306 sub.f32 %f15, %f14, %f13
  asm("sub.f32 %0, %1, %2;" : "=f"(f15) : "f"(f14), "f"(f13));
  // PTX:307 ld.global.f32 %f16, [%rd77+4]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (4)))));
  // PTX:308 ld.global.f32 %f17, [%rd79+4]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (4)))));
  // PTX:309 sub.f32 %f18, %f17, %f16
  asm("sub.f32 %0, %1, %2;" : "=f"(f18) : "f"(f17), "f"(f16));
  // PTX:310 ld.global.f32 %f19, [%rd77+8]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (8)))));
  // PTX:311 ld.global.f32 %f20, [%rd79+8]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (8)))));
  // PTX:312 sub.f32 %f21, %f20, %f19
  asm("sub.f32 %0, %1, %2;" : "=f"(f21) : "f"(f20), "f"(f19));
  // PTX:313 ld.global.f32 %f22, [%rd81]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (0)))));
  // PTX:314 sub.f32 %f23, %f22, %f13
  asm("sub.f32 %0, %1, %2;" : "=f"(f23) : "f"(f22), "f"(f13));
  // PTX:315 ld.global.f32 %f24, [%rd81+4]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (4)))));
  // PTX:316 sub.f32 %f25, %f24, %f16
  asm("sub.f32 %0, %1, %2;" : "=f"(f25) : "f"(f24), "f"(f16));
  // PTX:317 ld.global.f32 %f26, [%rd81+8]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (8)))));
  // PTX:318 sub.f32 %f27, %f26, %f19
  asm("sub.f32 %0, %1, %2;" : "=f"(f27) : "f"(f26), "f"(f19));
  // PTX:319 mul.f32 %f84, %f18, %f27
  asm("mul.f32 %0, %1, %2;" : "=f"(f84) : "f"(f18), "f"(f27));
  // PTX:320 mul.f32 %f85, %f21, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f85) : "f"(f21), "f"(f25));
  // PTX:321 sub.f32 %f86, %f84, %f85
  asm("sub.f32 %0, %1, %2;" : "=f"(f86) : "f"(f84), "f"(f85));
  // PTX:322 mul.f32 %f87, %f21, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f87) : "f"(f21), "f"(f23));
  // PTX:323 mul.f32 %f88, %f15, %f27
  asm("mul.f32 %0, %1, %2;" : "=f"(f88) : "f"(f15), "f"(f27));
  // PTX:324 sub.f32 %f89, %f87, %f88
  asm("sub.f32 %0, %1, %2;" : "=f"(f89) : "f"(f87), "f"(f88));
  // PTX:325 mul.f32 %f90, %f15, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f90) : "f"(f15), "f"(f25));
  // PTX:326 mul.f32 %f91, %f18, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f91) : "f"(f18), "f"(f23));
  // PTX:327 sub.f32 %f92, %f90, %f91
  asm("sub.f32 %0, %1, %2;" : "=f"(f92) : "f"(f90), "f"(f91));
  // PTX:328 mul.f32 %f93, %f89, %f89
  asm("mul.f32 %0, %1, %2;" : "=f"(f93) : "f"(f89), "f"(f89));
  // PTX:329 fma.rn.f32 %f94, %f86, %f86, %f93
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f94) : "f"(f86), "f"(f86), "f"(f93));
  // PTX:330 fma.rn.f32 %f95, %f92, %f92, %f94
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f95) : "f"(f92), "f"(f92), "f"(f94));
  // PTX:331 setp.lt.f32 %p31, %f95, 0f1E3CE508
  p31 = (!(isnan(((float)(f95))) || isnan(((float)(as_f32(0x1E3CE508u))))) && (((float)(f95)) < ((float)(as_f32(0x1E3CE508u)))));
  // PTX:332 @%p31 bra $L__BB4_45
  if (p31) { goto L_BB4_45; }
  // PTX:333 bra.uni $L__BB4_32
  goto L_BB4_32;
  // PTX:335 $L__BB4_45:
L_BB4_45:;
  // PTX:336 mul.f32 %f170, %f18, %f18
  asm("mul.f32 %0, %1, %2;" : "=f"(f170) : "f"(f18), "f"(f18));
  // PTX:337 fma.rn.f32 %f171, %f15, %f15, %f170
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f171) : "f"(f15), "f"(f15), "f"(f170));
  // PTX:338 fma.rn.f32 %f55, %f21, %f21, %f171
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f55) : "f"(f21), "f"(f21), "f"(f171));
  // PTX:339 setp.leu.f32 %p56, %f55, 0f00000000
  p56 = ((isnan(((float)(f55))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f55)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:340 mov.f32 %f245, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f245) : );
  // PTX:341 mov.f32 %f244, %f245
  asm("mov.f32 %0, %1;" : "=f"(f244) : "f"(f245));
  // PTX:342 @%p56 bra $L__BB4_47
  if (p56) { goto L_BB4_47; }
  // PTX:344 sub.f32 %f172, %f1, %f13
  asm("sub.f32 %0, %1, %2;" : "=f"(f172) : "f"(f1), "f"(f13));
  // PTX:345 sub.f32 %f173, %f2, %f16
  asm("sub.f32 %0, %1, %2;" : "=f"(f173) : "f"(f2), "f"(f16));
  // PTX:346 mul.f32 %f174, %f18, %f173
  asm("mul.f32 %0, %1, %2;" : "=f"(f174) : "f"(f18), "f"(f173));
  // PTX:347 sub.f32 %f175, %f3, %f19
  asm("sub.f32 %0, %1, %2;" : "=f"(f175) : "f"(f3), "f"(f19));
  // PTX:348 fma.rn.f32 %f176, %f15, %f172, %f174
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f176) : "f"(f15), "f"(f172), "f"(f174));
  // PTX:349 fma.rn.f32 %f177, %f21, %f175, %f176
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f177) : "f"(f21), "f"(f175), "f"(f176));
  // PTX:350 div.rn.f32 %f178, %f177, %f55
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f178) : "f"(f177), "f"(f55));
  // PTX:351 cvt.sat.f32.f32 %f244, %f178
  asm("cvt.sat.f32.f32 %0, %1;" : "=f"(f244) : "f"(f178));
  // PTX:353 $L__BB4_47:
L_BB4_47:;
  // PTX:354 fma.rn.f32 %f180, %f15, %f244, %f13
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f180) : "f"(f15), "f"(f244), "f"(f13));
  // PTX:355 fma.rn.f32 %f181, %f18, %f244, %f16
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f181) : "f"(f18), "f"(f244), "f"(f16));
  // PTX:356 fma.rn.f32 %f182, %f21, %f244, %f19
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f182) : "f"(f21), "f"(f244), "f"(f19));
  // PTX:357 sub.f32 %f183, %f1, %f180
  asm("sub.f32 %0, %1, %2;" : "=f"(f183) : "f"(f1), "f"(f180));
  // PTX:358 sub.f32 %f184, %f2, %f181
  asm("sub.f32 %0, %1, %2;" : "=f"(f184) : "f"(f2), "f"(f181));
  // PTX:359 sub.f32 %f185, %f3, %f182
  asm("sub.f32 %0, %1, %2;" : "=f"(f185) : "f"(f3), "f"(f182));
  // PTX:360 mul.f32 %f186, %f184, %f184
  asm("mul.f32 %0, %1, %2;" : "=f"(f186) : "f"(f184), "f"(f184));
  // PTX:361 fma.rn.f32 %f187, %f183, %f183, %f186
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f187) : "f"(f183), "f"(f183), "f"(f186));
  // PTX:362 fma.rn.f32 %f58, %f185, %f185, %f187
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f58) : "f"(f185), "f"(f185), "f"(f187));
  // PTX:363 sub.f32 %f59, %f22, %f14
  asm("sub.f32 %0, %1, %2;" : "=f"(f59) : "f"(f22), "f"(f14));
  // PTX:364 sub.f32 %f60, %f24, %f17
  asm("sub.f32 %0, %1, %2;" : "=f"(f60) : "f"(f24), "f"(f17));
  // PTX:365 mul.f32 %f188, %f60, %f60
  asm("mul.f32 %0, %1, %2;" : "=f"(f188) : "f"(f60), "f"(f60));
  // PTX:366 sub.f32 %f61, %f26, %f20
  asm("sub.f32 %0, %1, %2;" : "=f"(f61) : "f"(f26), "f"(f20));
  // PTX:367 fma.rn.f32 %f189, %f59, %f59, %f188
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f189) : "f"(f59), "f"(f59), "f"(f188));
  // PTX:368 fma.rn.f32 %f62, %f61, %f61, %f189
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f62) : "f"(f61), "f"(f61), "f"(f189));
  // PTX:369 setp.leu.f32 %p57, %f62, 0f00000000
  p57 = ((isnan(((float)(f62))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f62)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:370 @%p57 bra $L__BB4_49
  if (p57) { goto L_BB4_49; }
  // PTX:372 sub.f32 %f190, %f1, %f14
  asm("sub.f32 %0, %1, %2;" : "=f"(f190) : "f"(f1), "f"(f14));
  // PTX:373 sub.f32 %f191, %f2, %f17
  asm("sub.f32 %0, %1, %2;" : "=f"(f191) : "f"(f2), "f"(f17));
  // PTX:374 mul.f32 %f192, %f60, %f191
  asm("mul.f32 %0, %1, %2;" : "=f"(f192) : "f"(f60), "f"(f191));
  // PTX:375 sub.f32 %f193, %f3, %f20
  asm("sub.f32 %0, %1, %2;" : "=f"(f193) : "f"(f3), "f"(f20));
  // PTX:376 fma.rn.f32 %f194, %f59, %f190, %f192
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f194) : "f"(f59), "f"(f190), "f"(f192));
  // PTX:377 fma.rn.f32 %f195, %f61, %f193, %f194
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f195) : "f"(f61), "f"(f193), "f"(f194));
  // PTX:378 div.rn.f32 %f196, %f195, %f62
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f196) : "f"(f195), "f"(f62));
  // PTX:379 cvt.sat.f32.f32 %f245, %f196
  asm("cvt.sat.f32.f32 %0, %1;" : "=f"(f245) : "f"(f196));
  // PTX:381 $L__BB4_49:
L_BB4_49:;
  // PTX:382 fma.rn.f32 %f198, %f59, %f245, %f14
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f198) : "f"(f59), "f"(f245), "f"(f14));
  // PTX:383 fma.rn.f32 %f199, %f60, %f245, %f17
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f199) : "f"(f60), "f"(f245), "f"(f17));
  // PTX:384 fma.rn.f32 %f200, %f61, %f245, %f20
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f200) : "f"(f61), "f"(f245), "f"(f20));
  // PTX:385 sub.f32 %f201, %f1, %f198
  asm("sub.f32 %0, %1, %2;" : "=f"(f201) : "f"(f1), "f"(f198));
  // PTX:386 sub.f32 %f202, %f2, %f199
  asm("sub.f32 %0, %1, %2;" : "=f"(f202) : "f"(f2), "f"(f199));
  // PTX:387 sub.f32 %f203, %f3, %f200
  asm("sub.f32 %0, %1, %2;" : "=f"(f203) : "f"(f3), "f"(f200));
  // PTX:388 mul.f32 %f204, %f202, %f202
  asm("mul.f32 %0, %1, %2;" : "=f"(f204) : "f"(f202), "f"(f202));
  // PTX:389 fma.rn.f32 %f205, %f201, %f201, %f204
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f205) : "f"(f201), "f"(f201), "f"(f204));
  // PTX:390 fma.rn.f32 %f65, %f203, %f203, %f205
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f65) : "f"(f203), "f"(f203), "f"(f205));
  // PTX:391 sub.f32 %f66, %f13, %f22
  asm("sub.f32 %0, %1, %2;" : "=f"(f66) : "f"(f13), "f"(f22));
  // PTX:392 sub.f32 %f67, %f16, %f24
  asm("sub.f32 %0, %1, %2;" : "=f"(f67) : "f"(f16), "f"(f24));
  // PTX:393 mul.f32 %f206, %f67, %f67
  asm("mul.f32 %0, %1, %2;" : "=f"(f206) : "f"(f67), "f"(f67));
  // PTX:394 sub.f32 %f68, %f19, %f26
  asm("sub.f32 %0, %1, %2;" : "=f"(f68) : "f"(f19), "f"(f26));
  // PTX:395 fma.rn.f32 %f207, %f66, %f66, %f206
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f207) : "f"(f66), "f"(f66), "f"(f206));
  // PTX:396 fma.rn.f32 %f69, %f68, %f68, %f207
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f69) : "f"(f68), "f"(f68), "f"(f207));
  // PTX:397 setp.leu.f32 %p58, %f69, 0f00000000
  p58 = ((isnan(((float)(f69))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f69)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:398 mov.f32 %f246, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f246) : );
  // PTX:399 @%p58 bra $L__BB4_51
  if (p58) { goto L_BB4_51; }
  // PTX:401 sub.f32 %f208, %f1, %f22
  asm("sub.f32 %0, %1, %2;" : "=f"(f208) : "f"(f1), "f"(f22));
  // PTX:402 sub.f32 %f209, %f2, %f24
  asm("sub.f32 %0, %1, %2;" : "=f"(f209) : "f"(f2), "f"(f24));
  // PTX:403 mul.f32 %f210, %f67, %f209
  asm("mul.f32 %0, %1, %2;" : "=f"(f210) : "f"(f67), "f"(f209));
  // PTX:404 sub.f32 %f211, %f3, %f26
  asm("sub.f32 %0, %1, %2;" : "=f"(f211) : "f"(f3), "f"(f26));
  // PTX:405 fma.rn.f32 %f212, %f66, %f208, %f210
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f212) : "f"(f66), "f"(f208), "f"(f210));
  // PTX:406 fma.rn.f32 %f213, %f68, %f211, %f212
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f213) : "f"(f68), "f"(f211), "f"(f212));
  // PTX:407 div.rn.f32 %f214, %f213, %f69
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f214) : "f"(f213), "f"(f69));
  // PTX:408 cvt.sat.f32.f32 %f246, %f214
  asm("cvt.sat.f32.f32 %0, %1;" : "=f"(f246) : "f"(f214));
  // PTX:410 $L__BB4_51:
L_BB4_51:;
  // PTX:411 fma.rn.f32 %f215, %f66, %f246, %f22
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f215) : "f"(f66), "f"(f246), "f"(f22));
  // PTX:412 fma.rn.f32 %f216, %f67, %f246, %f24
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f216) : "f"(f67), "f"(f246), "f"(f24));
  // PTX:413 fma.rn.f32 %f217, %f68, %f246, %f26
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f217) : "f"(f68), "f"(f246), "f"(f26));
  // PTX:414 sub.f32 %f218, %f1, %f215
  asm("sub.f32 %0, %1, %2;" : "=f"(f218) : "f"(f1), "f"(f215));
  // PTX:415 sub.f32 %f219, %f2, %f216
  asm("sub.f32 %0, %1, %2;" : "=f"(f219) : "f"(f2), "f"(f216));
  // PTX:416 sub.f32 %f220, %f3, %f217
  asm("sub.f32 %0, %1, %2;" : "=f"(f220) : "f"(f3), "f"(f217));
  // PTX:417 mul.f32 %f221, %f219, %f219
  asm("mul.f32 %0, %1, %2;" : "=f"(f221) : "f"(f219), "f"(f219));
  // PTX:418 fma.rn.f32 %f222, %f218, %f218, %f221
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f222) : "f"(f218), "f"(f218), "f"(f221));
  // PTX:419 fma.rn.f32 %f223, %f220, %f220, %f222
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f223) : "f"(f220), "f"(f220), "f"(f222));
  // PTX:420 min.f32 %f224, %f65, %f223
  asm("min.f32 %0, %1, %2;" : "=f"(f224) : "f"(f65), "f"(f223));
  // PTX:421 min.f32 %f247, %f58, %f224
  asm("min.f32 %0, %1, %2;" : "=f"(f247) : "f"(f58), "f"(f224));
  // PTX:422 bra.uni $L__BB4_52
  goto L_BB4_52;
  // PTX:424 $L__BB4_32:
L_BB4_32:;
  // PTX:425 sub.f32 %f233, %f26, %f19
  asm("sub.f32 %0, %1, %2;" : "=f"(f233) : "f"(f26), "f"(f19));
  // PTX:426 sub.f32 %f232, %f22, %f13
  asm("sub.f32 %0, %1, %2;" : "=f"(f232) : "f"(f22), "f"(f13));
  // PTX:427 sub.f32 %f231, %f24, %f16
  asm("sub.f32 %0, %1, %2;" : "=f"(f231) : "f"(f24), "f"(f16));
  // PTX:428 sub.f32 %f28, %f1, %f13
  asm("sub.f32 %0, %1, %2;" : "=f"(f28) : "f"(f1), "f"(f13));
  // PTX:429 sub.f32 %f29, %f2, %f16
  asm("sub.f32 %0, %1, %2;" : "=f"(f29) : "f"(f2), "f"(f16));
  // PTX:430 mul.f32 %f96, %f18, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f96) : "f"(f18), "f"(f29));
  // PTX:431 sub.f32 %f30, %f3, %f19
  asm("sub.f32 %0, %1, %2;" : "=f"(f30) : "f"(f3), "f"(f19));
  // PTX:432 fma.rn.f32 %f97, %f15, %f28, %f96
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f97) : "f"(f15), "f"(f28), "f"(f96));
  // PTX:433 fma.rn.f32 %f31, %f21, %f30, %f97
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f31) : "f"(f21), "f"(f30), "f"(f97));
  // PTX:434 mul.f32 %f98, %f231, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f98) : "f"(f231), "f"(f29));
  // PTX:435 fma.rn.f32 %f99, %f232, %f28, %f98
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f99) : "f"(f232), "f"(f28), "f"(f98));
  // PTX:436 fma.rn.f32 %f32, %f233, %f30, %f99
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f32) : "f"(f233), "f"(f30), "f"(f99));
  // PTX:437 setp.le.f32 %p32, %f31, 0f00000000
  p32 = (!(isnan(((float)(f31))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f31)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:438 setp.le.f32 %p33, %f32, 0f00000000
  p33 = (!(isnan(((float)(f32))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f32)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:439 and.pred %p34, %p32, %p33
  p34 = ((p32) && (p33));
  // PTX:440 @%p34 bra $L__BB4_44
  if (p34) { goto L_BB4_44; }
  // PTX:441 bra.uni $L__BB4_33
  goto L_BB4_33;
  // PTX:443 $L__BB4_44:
L_BB4_44:;
  // PTX:444 mul.f32 %f167, %f29, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f167) : "f"(f29), "f"(f29));
  // PTX:445 fma.rn.f32 %f168, %f28, %f28, %f167
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f168) : "f"(f28), "f"(f28), "f"(f167));
  // PTX:446 fma.rn.f32 %f247, %f30, %f30, %f168
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f247) : "f"(f30), "f"(f30), "f"(f168));
  // PTX:447 bra.uni $L__BB4_52
  goto L_BB4_52;
  // PTX:449 $L__BB4_33:
L_BB4_33:;
  // PTX:450 sub.f32 %f236, %f26, %f19
  asm("sub.f32 %0, %1, %2;" : "=f"(f236) : "f"(f26), "f"(f19));
  // PTX:451 sub.f32 %f235, %f22, %f13
  asm("sub.f32 %0, %1, %2;" : "=f"(f235) : "f"(f22), "f"(f13));
  // PTX:452 sub.f32 %f234, %f24, %f16
  asm("sub.f32 %0, %1, %2;" : "=f"(f234) : "f"(f24), "f"(f16));
  // PTX:453 sub.f32 %f33, %f1, %f14
  asm("sub.f32 %0, %1, %2;" : "=f"(f33) : "f"(f1), "f"(f14));
  // PTX:454 sub.f32 %f34, %f2, %f17
  asm("sub.f32 %0, %1, %2;" : "=f"(f34) : "f"(f2), "f"(f17));
  // PTX:455 mul.f32 %f100, %f18, %f34
  asm("mul.f32 %0, %1, %2;" : "=f"(f100) : "f"(f18), "f"(f34));
  // PTX:456 sub.f32 %f35, %f3, %f20
  asm("sub.f32 %0, %1, %2;" : "=f"(f35) : "f"(f3), "f"(f20));
  // PTX:457 fma.rn.f32 %f101, %f15, %f33, %f100
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f101) : "f"(f15), "f"(f33), "f"(f100));
  // PTX:458 fma.rn.f32 %f36, %f21, %f35, %f101
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f36) : "f"(f21), "f"(f35), "f"(f101));
  // PTX:459 mul.f32 %f102, %f234, %f34
  asm("mul.f32 %0, %1, %2;" : "=f"(f102) : "f"(f234), "f"(f34));
  // PTX:460 fma.rn.f32 %f103, %f235, %f33, %f102
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f103) : "f"(f235), "f"(f33), "f"(f102));
  // PTX:461 fma.rn.f32 %f37, %f236, %f35, %f103
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f37) : "f"(f236), "f"(f35), "f"(f103));
  // PTX:462 setp.ge.f32 %p35, %f36, 0f00000000
  p35 = (!(isnan(((float)(f36))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f36)) >= ((float)(as_f32(0x00000000u)))));
  // PTX:463 setp.le.f32 %p36, %f37, %f36
  p36 = (!(isnan(((float)(f37))) || isnan(((float)(f36)))) && (((float)(f37)) <= ((float)(f36))));
  // PTX:464 and.pred %p37, %p35, %p36
  p37 = ((p35) && (p36));
  // PTX:465 @%p37 bra $L__BB4_43
  if (p37) { goto L_BB4_43; }
  // PTX:466 bra.uni $L__BB4_34
  goto L_BB4_34;
  // PTX:468 $L__BB4_43:
L_BB4_43:;
  // PTX:469 mul.f32 %f165, %f34, %f34
  asm("mul.f32 %0, %1, %2;" : "=f"(f165) : "f"(f34), "f"(f34));
  // PTX:470 fma.rn.f32 %f166, %f33, %f33, %f165
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f166) : "f"(f33), "f"(f33), "f"(f165));
  // PTX:471 fma.rn.f32 %f247, %f35, %f35, %f166
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f247) : "f"(f35), "f"(f35), "f"(f166));
  // PTX:472 bra.uni $L__BB4_52
  goto L_BB4_52;
  // PTX:474 $L__BB4_34:
L_BB4_34:;
  // PTX:475 mul.f32 %f104, %f31, %f37
  asm("mul.f32 %0, %1, %2;" : "=f"(f104) : "f"(f31), "f"(f37));
  // PTX:476 mul.f32 %f105, %f32, %f36
  asm("mul.f32 %0, %1, %2;" : "=f"(f105) : "f"(f32), "f"(f36));
  // PTX:477 sub.f32 %f38, %f104, %f105
  asm("sub.f32 %0, %1, %2;" : "=f"(f38) : "f"(f104), "f"(f105));
  // PTX:478 setp.le.f32 %p38, %f38, 0f00000000
  p38 = (!(isnan(((float)(f38))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f38)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:479 setp.ge.f32 %p39, %f31, 0f00000000
  p39 = (!(isnan(((float)(f31))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f31)) >= ((float)(as_f32(0x00000000u)))));
  // PTX:480 and.pred %p40, %p39, %p38
  p40 = ((p39) && (p38));
  // PTX:481 setp.le.f32 %p41, %f36, 0f00000000
  p41 = (!(isnan(((float)(f36))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f36)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:482 and.pred %p42, %p41, %p40
  p42 = ((p41) && (p40));
  // PTX:483 @%p42 bra $L__BB4_42
  if (p42) { goto L_BB4_42; }
  // PTX:484 bra.uni $L__BB4_35
  goto L_BB4_35;
  // PTX:486 $L__BB4_42:
L_BB4_42:;
  // PTX:487 sub.f32 %f155, %f31, %f36
  asm("sub.f32 %0, %1, %2;" : "=f"(f155) : "f"(f31), "f"(f36));
  // PTX:488 div.rn.f32 %f156, %f31, %f155
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f156) : "f"(f31), "f"(f155));
  // PTX:489 fma.rn.f32 %f157, %f15, %f156, %f13
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f157) : "f"(f15), "f"(f156), "f"(f13));
  // PTX:490 fma.rn.f32 %f158, %f18, %f156, %f16
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f158) : "f"(f18), "f"(f156), "f"(f16));
  // PTX:491 fma.rn.f32 %f159, %f21, %f156, %f19
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f159) : "f"(f21), "f"(f156), "f"(f19));
  // PTX:492 sub.f32 %f160, %f1, %f157
  asm("sub.f32 %0, %1, %2;" : "=f"(f160) : "f"(f1), "f"(f157));
  // PTX:493 sub.f32 %f161, %f2, %f158
  asm("sub.f32 %0, %1, %2;" : "=f"(f161) : "f"(f2), "f"(f158));
  // PTX:494 sub.f32 %f162, %f3, %f159
  asm("sub.f32 %0, %1, %2;" : "=f"(f162) : "f"(f3), "f"(f159));
  // PTX:495 mul.f32 %f163, %f161, %f161
  asm("mul.f32 %0, %1, %2;" : "=f"(f163) : "f"(f161), "f"(f161));
  // PTX:496 fma.rn.f32 %f164, %f160, %f160, %f163
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f164) : "f"(f160), "f"(f160), "f"(f163));
  // PTX:497 fma.rn.f32 %f247, %f162, %f162, %f164
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f247) : "f"(f162), "f"(f162), "f"(f164));
  // PTX:498 bra.uni $L__BB4_52
  goto L_BB4_52;
  // PTX:500 $L__BB4_35:
L_BB4_35:;
  // PTX:501 sub.f32 %f239, %f26, %f19
  asm("sub.f32 %0, %1, %2;" : "=f"(f239) : "f"(f26), "f"(f19));
  // PTX:502 sub.f32 %f238, %f22, %f13
  asm("sub.f32 %0, %1, %2;" : "=f"(f238) : "f"(f22), "f"(f13));
  // PTX:503 sub.f32 %f237, %f24, %f16
  asm("sub.f32 %0, %1, %2;" : "=f"(f237) : "f"(f24), "f"(f16));
  // PTX:504 sub.f32 %f39, %f1, %f22
  asm("sub.f32 %0, %1, %2;" : "=f"(f39) : "f"(f1), "f"(f22));
  // PTX:505 sub.f32 %f40, %f2, %f24
  asm("sub.f32 %0, %1, %2;" : "=f"(f40) : "f"(f2), "f"(f24));
  // PTX:506 mul.f32 %f106, %f18, %f40
  asm("mul.f32 %0, %1, %2;" : "=f"(f106) : "f"(f18), "f"(f40));
  // PTX:507 sub.f32 %f41, %f3, %f26
  asm("sub.f32 %0, %1, %2;" : "=f"(f41) : "f"(f3), "f"(f26));
  // PTX:508 fma.rn.f32 %f107, %f15, %f39, %f106
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f107) : "f"(f15), "f"(f39), "f"(f106));
  // PTX:509 fma.rn.f32 %f42, %f21, %f41, %f107
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f42) : "f"(f21), "f"(f41), "f"(f107));
  // PTX:510 mul.f32 %f108, %f237, %f40
  asm("mul.f32 %0, %1, %2;" : "=f"(f108) : "f"(f237), "f"(f40));
  // PTX:511 fma.rn.f32 %f109, %f238, %f39, %f108
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f109) : "f"(f238), "f"(f39), "f"(f108));
  // PTX:512 fma.rn.f32 %f43, %f239, %f41, %f109
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f43) : "f"(f239), "f"(f41), "f"(f109));
  // PTX:513 setp.ge.f32 %p43, %f43, 0f00000000
  p43 = (!(isnan(((float)(f43))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f43)) >= ((float)(as_f32(0x00000000u)))));
  // PTX:514 setp.le.f32 %p44, %f42, %f43
  p44 = (!(isnan(((float)(f42))) || isnan(((float)(f43)))) && (((float)(f42)) <= ((float)(f43))));
  // PTX:515 and.pred %p45, %p43, %p44
  p45 = ((p43) && (p44));
  // PTX:516 @%p45 bra $L__BB4_41
  if (p45) { goto L_BB4_41; }
  // PTX:517 bra.uni $L__BB4_36
  goto L_BB4_36;
  // PTX:519 $L__BB4_41:
L_BB4_41:;
  // PTX:520 mul.f32 %f153, %f40, %f40
  asm("mul.f32 %0, %1, %2;" : "=f"(f153) : "f"(f40), "f"(f40));
  // PTX:521 fma.rn.f32 %f154, %f39, %f39, %f153
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f154) : "f"(f39), "f"(f39), "f"(f153));
  // PTX:522 fma.rn.f32 %f247, %f41, %f41, %f154
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f247) : "f"(f41), "f"(f41), "f"(f154));
  // PTX:523 bra.uni $L__BB4_52
  goto L_BB4_52;
  // PTX:525 $L__BB4_36:
L_BB4_36:;
  // PTX:526 mul.f32 %f110, %f32, %f42
  asm("mul.f32 %0, %1, %2;" : "=f"(f110) : "f"(f32), "f"(f42));
  // PTX:527 mul.f32 %f111, %f31, %f43
  asm("mul.f32 %0, %1, %2;" : "=f"(f111) : "f"(f31), "f"(f43));
  // PTX:528 sub.f32 %f44, %f110, %f111
  asm("sub.f32 %0, %1, %2;" : "=f"(f44) : "f"(f110), "f"(f111));
  // PTX:529 setp.le.f32 %p46, %f44, 0f00000000
  p46 = (!(isnan(((float)(f44))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f44)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:530 setp.ge.f32 %p47, %f32, 0f00000000
  p47 = (!(isnan(((float)(f32))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f32)) >= ((float)(as_f32(0x00000000u)))));
  // PTX:531 and.pred %p48, %p47, %p46
  p48 = ((p47) && (p46));
  // PTX:532 setp.le.f32 %p49, %f43, 0f00000000
  p49 = (!(isnan(((float)(f43))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f43)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:533 and.pred %p50, %p49, %p48
  p50 = ((p49) && (p48));
  // PTX:534 @%p50 bra $L__BB4_40
  if (p50) { goto L_BB4_40; }
  // PTX:535 bra.uni $L__BB4_37
  goto L_BB4_37;
  // PTX:537 $L__BB4_40:
L_BB4_40:;
  // PTX:538 sub.f32 %f242, %f26, %f19
  asm("sub.f32 %0, %1, %2;" : "=f"(f242) : "f"(f26), "f"(f19));
  // PTX:539 sub.f32 %f241, %f22, %f13
  asm("sub.f32 %0, %1, %2;" : "=f"(f241) : "f"(f22), "f"(f13));
  // PTX:540 sub.f32 %f240, %f24, %f16
  asm("sub.f32 %0, %1, %2;" : "=f"(f240) : "f"(f24), "f"(f16));
  // PTX:541 sub.f32 %f143, %f32, %f43
  asm("sub.f32 %0, %1, %2;" : "=f"(f143) : "f"(f32), "f"(f43));
  // PTX:542 div.rn.f32 %f144, %f32, %f143
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f144) : "f"(f32), "f"(f143));
  // PTX:543 fma.rn.f32 %f145, %f241, %f144, %f13
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f145) : "f"(f241), "f"(f144), "f"(f13));
  // PTX:544 fma.rn.f32 %f146, %f240, %f144, %f16
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f146) : "f"(f240), "f"(f144), "f"(f16));
  // PTX:545 fma.rn.f32 %f147, %f242, %f144, %f19
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f147) : "f"(f242), "f"(f144), "f"(f19));
  // PTX:546 sub.f32 %f148, %f1, %f145
  asm("sub.f32 %0, %1, %2;" : "=f"(f148) : "f"(f1), "f"(f145));
  // PTX:547 sub.f32 %f149, %f2, %f146
  asm("sub.f32 %0, %1, %2;" : "=f"(f149) : "f"(f2), "f"(f146));
  // PTX:548 sub.f32 %f150, %f3, %f147
  asm("sub.f32 %0, %1, %2;" : "=f"(f150) : "f"(f3), "f"(f147));
  // PTX:549 mul.f32 %f151, %f149, %f149
  asm("mul.f32 %0, %1, %2;" : "=f"(f151) : "f"(f149), "f"(f149));
  // PTX:550 fma.rn.f32 %f152, %f148, %f148, %f151
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f152) : "f"(f148), "f"(f148), "f"(f151));
  // PTX:551 fma.rn.f32 %f247, %f150, %f150, %f152
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f247) : "f"(f150), "f"(f150), "f"(f152));
  // PTX:552 bra.uni $L__BB4_52
  goto L_BB4_52;
  // PTX:554 $L__BB4_37:
L_BB4_37:;
  // PTX:555 mul.f32 %f112, %f36, %f43
  asm("mul.f32 %0, %1, %2;" : "=f"(f112) : "f"(f36), "f"(f43));
  // PTX:556 mul.f32 %f113, %f37, %f42
  asm("mul.f32 %0, %1, %2;" : "=f"(f113) : "f"(f37), "f"(f42));
  // PTX:557 sub.f32 %f45, %f112, %f113
  asm("sub.f32 %0, %1, %2;" : "=f"(f45) : "f"(f112), "f"(f113));
  // PTX:558 setp.le.f32 %p51, %f45, 0f00000000
  p51 = (!(isnan(((float)(f45))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f45)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:559 sub.f32 %f46, %f37, %f36
  asm("sub.f32 %0, %1, %2;" : "=f"(f46) : "f"(f37), "f"(f36));
  // PTX:560 setp.ge.f32 %p52, %f46, 0f00000000
  p52 = (!(isnan(((float)(f46))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f46)) >= ((float)(as_f32(0x00000000u)))));
  // PTX:561 and.pred %p53, %p52, %p51
  p53 = ((p52) && (p51));
  // PTX:562 sub.f32 %f47, %f42, %f43
  asm("sub.f32 %0, %1, %2;" : "=f"(f47) : "f"(f42), "f"(f43));
  // PTX:563 setp.ge.f32 %p54, %f47, 0f00000000
  p54 = (!(isnan(((float)(f47))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f47)) >= ((float)(as_f32(0x00000000u)))));
  // PTX:564 and.pred %p55, %p54, %p53
  p55 = ((p54) && (p53));
  // PTX:565 @%p55 bra $L__BB4_39
  if (p55) { goto L_BB4_39; }
  // PTX:566 bra.uni $L__BB4_38
  goto L_BB4_38;
  // PTX:568 $L__BB4_39:
L_BB4_39:;
  // PTX:569 add.f32 %f130, %f46, %f47
  asm("add.f32 %0, %1, %2;" : "=f"(f130) : "f"(f46), "f"(f47));
  // PTX:570 div.rn.f32 %f131, %f46, %f130
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f131) : "f"(f46), "f"(f130));
  // PTX:571 sub.f32 %f132, %f22, %f14
  asm("sub.f32 %0, %1, %2;" : "=f"(f132) : "f"(f22), "f"(f14));
  // PTX:572 sub.f32 %f133, %f24, %f17
  asm("sub.f32 %0, %1, %2;" : "=f"(f133) : "f"(f24), "f"(f17));
  // PTX:573 sub.f32 %f134, %f26, %f20
  asm("sub.f32 %0, %1, %2;" : "=f"(f134) : "f"(f26), "f"(f20));
  // PTX:574 fma.rn.f32 %f135, %f131, %f132, %f14
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f135) : "f"(f131), "f"(f132), "f"(f14));
  // PTX:575 fma.rn.f32 %f136, %f131, %f133, %f17
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f136) : "f"(f131), "f"(f133), "f"(f17));
  // PTX:576 fma.rn.f32 %f137, %f131, %f134, %f20
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f137) : "f"(f131), "f"(f134), "f"(f20));
  // PTX:577 sub.f32 %f138, %f1, %f135
  asm("sub.f32 %0, %1, %2;" : "=f"(f138) : "f"(f1), "f"(f135));
  // PTX:578 sub.f32 %f139, %f2, %f136
  asm("sub.f32 %0, %1, %2;" : "=f"(f139) : "f"(f2), "f"(f136));
  // PTX:579 sub.f32 %f140, %f3, %f137
  asm("sub.f32 %0, %1, %2;" : "=f"(f140) : "f"(f3), "f"(f137));
  // PTX:580 mul.f32 %f141, %f139, %f139
  asm("mul.f32 %0, %1, %2;" : "=f"(f141) : "f"(f139), "f"(f139));
  // PTX:581 fma.rn.f32 %f142, %f138, %f138, %f141
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f142) : "f"(f138), "f"(f138), "f"(f141));
  // PTX:582 fma.rn.f32 %f247, %f140, %f140, %f142
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f247) : "f"(f140), "f"(f140), "f"(f142));
  // PTX:583 bra.uni $L__BB4_52
  goto L_BB4_52;
  // PTX:585 $L__BB4_38:
L_BB4_38:;
  // PTX:586 mul.f32 %f230, %f32, %f36
  asm("mul.f32 %0, %1, %2;" : "=f"(f230) : "f"(f32), "f"(f36));
  // PTX:587 mul.f32 %f229, %f31, %f37
  asm("mul.f32 %0, %1, %2;" : "=f"(f229) : "f"(f31), "f"(f37));
  // PTX:588 sub.f32 %f228, %f229, %f230
  asm("sub.f32 %0, %1, %2;" : "=f"(f228) : "f"(f229), "f"(f230));
  // PTX:589 sub.f32 %f227, %f26, %f19
  asm("sub.f32 %0, %1, %2;" : "=f"(f227) : "f"(f26), "f"(f19));
  // PTX:590 sub.f32 %f226, %f22, %f13
  asm("sub.f32 %0, %1, %2;" : "=f"(f226) : "f"(f22), "f"(f13));
  // PTX:591 sub.f32 %f225, %f24, %f16
  asm("sub.f32 %0, %1, %2;" : "=f"(f225) : "f"(f24), "f"(f16));
  // PTX:592 add.f32 %f114, %f45, %f44
  asm("add.f32 %0, %1, %2;" : "=f"(f114) : "f"(f45), "f"(f44));
  // PTX:593 add.f32 %f115, %f228, %f114
  asm("add.f32 %0, %1, %2;" : "=f"(f115) : "f"(f228), "f"(f114));
  // PTX:594 rcp.rn.f32 %f116, %f115
  asm("rcp.rn.f32 %0, %1;" : "=f"(f116) : "f"(f115));
  // PTX:595 mul.f32 %f117, %f44, %f116
  asm("mul.f32 %0, %1, %2;" : "=f"(f117) : "f"(f44), "f"(f116));
  // PTX:596 mul.f32 %f118, %f228, %f116
  asm("mul.f32 %0, %1, %2;" : "=f"(f118) : "f"(f228), "f"(f116));
  // PTX:597 fma.rn.f32 %f119, %f15, %f117, %f13
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f119) : "f"(f15), "f"(f117), "f"(f13));
  // PTX:598 fma.rn.f32 %f120, %f18, %f117, %f16
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f120) : "f"(f18), "f"(f117), "f"(f16));
  // PTX:599 fma.rn.f32 %f121, %f21, %f117, %f19
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f121) : "f"(f21), "f"(f117), "f"(f19));
  // PTX:600 fma.rn.f32 %f122, %f226, %f118, %f119
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f122) : "f"(f226), "f"(f118), "f"(f119));
  // PTX:601 fma.rn.f32 %f123, %f225, %f118, %f120
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f123) : "f"(f225), "f"(f118), "f"(f120));
  // PTX:602 fma.rn.f32 %f124, %f227, %f118, %f121
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f124) : "f"(f227), "f"(f118), "f"(f121));
  // PTX:603 sub.f32 %f125, %f1, %f122
  asm("sub.f32 %0, %1, %2;" : "=f"(f125) : "f"(f1), "f"(f122));
  // PTX:604 sub.f32 %f126, %f2, %f123
  asm("sub.f32 %0, %1, %2;" : "=f"(f126) : "f"(f2), "f"(f123));
  // PTX:605 sub.f32 %f127, %f3, %f124
  asm("sub.f32 %0, %1, %2;" : "=f"(f127) : "f"(f3), "f"(f124));
  // PTX:606 mul.f32 %f128, %f126, %f126
  asm("mul.f32 %0, %1, %2;" : "=f"(f128) : "f"(f126), "f"(f126));
  // PTX:607 fma.rn.f32 %f129, %f125, %f125, %f128
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f129) : "f"(f125), "f"(f125), "f"(f128));
  // PTX:608 fma.rn.f32 %f247, %f127, %f127, %f129
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f247) : "f"(f127), "f"(f127), "f"(f129));
  // PTX:610 $L__BB4_52:
L_BB4_52:;
  // PTX:611 setp.geu.f32 %p59, %f247, %f6
  p59 = ((isnan(((float)(f247))) || isnan(((float)(f6)))) || (((float)(f247)) >= ((float)(f6))));
  // PTX:612 mov.u32 %r63, %r4
  asm("mov.u32 %0, %1;" : "=r"(r63) : "r"(r4));
  // PTX:613 @%p59 bra $L__BB4_55
  if (p59) { goto L_BB4_55; }
  // PTX:615 cvt.s64.s32 %rd82, %r62
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd82) : "r"(r62));
  // PTX:616 add.s64 %rd83, %rd13, %rd82
  asm("add.s64 %0, %1, %2;" : "=l"(rd83) : "l"(rd13), "l"(rd82));
  // PTX:617 shl.b64 %rd84, %rd83, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd84) : "l"(rd83));
  // PTX:618 add.s64 %rd85, %rd14, %rd84
  asm("add.s64 %0, %1, %2;" : "=l"(rd85) : "l"(rd14), "l"(rd84));
  // PTX:619 st.global.u32 [%rd85], %r8
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (0))))) = (unsigned)(r8);
  // PTX:620 add.s32 %r62, %r62, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r62) : "r"(r62));
  // PTX:621 mov.u32 %r63, %r4
  asm("mov.u32 %0, %1;" : "=r"(r63) : "r"(r4));
  // PTX:623 $L__BB4_55:
L_BB4_55:;
  // PTX:624 ld.param.u32 %r55, [_ZN7synreal21self_collision_kernel17query_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_ffbPiSK_mmmmi_param_18]
  r55 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param18 + (0))));
  // PTX:625 setp.lt.s32 %p60, %r62, %r55
  p60 = (((int)(r62)) < ((int)(r55)));
  // PTX:626 setp.gt.s32 %p61, %r63, -1
  p61 = (((int)(r63)) > ((int)(-1)));
  // PTX:627 and.pred %p62, %p60, %p61
  p62 = ((p60) && (p61));
  // PTX:628 @%p62 bra $L__BB4_8
  if (p62) { goto L_BB4_8; }
  // PTX:630 $L__BB4_56:
L_BB4_56:;
  // PTX:631 ld.param.u64 %rd92, [_ZN7synreal21self_collision_kernel17query_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_ffbPiSK_mmmmi_param_12]
  rd92 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:632 mov.u32 %r58, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r58) : "r"(blockDim.x));
  // PTX:633 mov.u32 %r57, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r57) : "r"(blockIdx.x));
  // PTX:634 mov.u32 %r56, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r56) : "r"(threadIdx.x));
  // PTX:635 cvt.u64.u32 %rd91, %r56
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd91) : "r"(r56));
  // PTX:636 mul.wide.u32 %rd90, %r57, %r58
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd90) : "r"(r57), "r"(r58));
  // PTX:637 add.s64 %rd89, %rd90, %rd91
  asm("add.s64 %0, %1, %2;" : "=l"(rd89) : "l"(rd90), "l"(rd91));
  // PTX:638 cvta.to.global.u64 %rd86, %rd92
  rd86 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd92));
  // PTX:639 shl.b64 %rd87, %rd89, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd87) : "l"(rd89));
  // PTX:640 add.s64 %rd88, %rd86, %rd87
  asm("add.s64 %0, %1, %2;" : "=l"(rd88) : "l"(rd86), "l"(rd87));
  // PTX:641 st.global.u32 [%rd88], %r62
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (0))))) = (unsigned)(r62);
  // PTX:643 $L__BB4_57:
L_BB4_57:;
  // PTX:644 ret
  return;
}
