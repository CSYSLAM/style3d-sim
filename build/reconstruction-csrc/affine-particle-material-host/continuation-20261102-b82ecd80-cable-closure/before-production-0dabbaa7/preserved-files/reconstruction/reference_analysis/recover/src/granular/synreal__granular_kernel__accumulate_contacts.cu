// 机械还原自 PTX：synreal::granular_kernel::accumulate_contacts(synreal::granular_kernel::View, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, int*, int*, glm::vec<4, float, (glm::qualifier)0>*)
// PTX SHA256: f355dba99ec6a5213b66819085b1213fb04b2d56717b50c31de35b52176e12ff
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__granular_kernel__accumulate_contacts(ByVal<120, 8> param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27;
  unsigned short rs0, rs1, rs2, rs3, rs4, rs5, rs6, rs7, rs8, rs9, rs10, rs11, rs12, rs13, rs14, rs15, rs16, rs17, rs18;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121, r122, r123, r124, r125, r126, r127, r128, r129, r130, r131, r132, r133, r134, r135, r136, r137, r138, r139, r140, r141, r142, r143, r144, r145, r146, r147, r148, r149, r150, r151, r152, r153, r154, r155, r156, r157, r158, r159, r160, r161, r162, r163, r164, r165, r166, r167, r168, r169, r170, r171, r172, r173, r174, r175, r176, r177, r178, r179, r180, r181;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94;
  // PTX:23 ld.param.v2.u32 {%r71, %r72}, [_ZN7synreal15granular_kernel19accumulate_contactsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPNS2_3matILi3ELi3EfLS4_0EEEPiSA_PNS3_ILi4EfLS4_0EEE_param_0+88]
  r71 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param0 + (88)))); r72 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param0 + (92))));
  // PTX:24 ld.param.v2.f32 {%f98, %f99}, [_ZN7synreal15granular_kernel19accumulate_contactsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPNS2_3matILi3ELi3EfLS4_0EEEPiSA_PNS3_ILi4EfLS4_0EEE_param_0+96]
  f98 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (96)))); f99 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (100))));
  // PTX:25 ld.param.v2.f32 {%f100, %f101}, [_ZN7synreal15granular_kernel19accumulate_contactsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPNS2_3matILi3ELi3EfLS4_0EEEPiSA_PNS3_ILi4EfLS4_0EEE_param_0+104]
  f100 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (104)))); f101 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (108))));
  // PTX:26 ld.param.u64 %rd38, [_ZN7synreal15granular_kernel19accumulate_contactsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPNS2_3matILi3ELi3EfLS4_0EEEPiSA_PNS3_ILi4EfLS4_0EEE_param_4]
  rd38 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:27 ld.param.u64 %rd39, [_ZN7synreal15granular_kernel19accumulate_contactsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPNS2_3matILi3ELi3EfLS4_0EEEPiSA_PNS3_ILi4EfLS4_0EEE_param_5]
  rd39 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:28 ld.param.f32 %f97, [_ZN7synreal15granular_kernel19accumulate_contactsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPNS2_3matILi3ELi3EfLS4_0EEEPiSA_PNS3_ILi4EfLS4_0EEE_param_0+112]
  f97 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (112))));
  // PTX:29 ld.param.u64 %rd31, [_ZN7synreal15granular_kernel19accumulate_contactsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPNS2_3matILi3ELi3EfLS4_0EEEPiSA_PNS3_ILi4EfLS4_0EEE_param_0+56]
  rd31 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (56))));
  // PTX:30 ld.param.u64 %rd30, [_ZN7synreal15granular_kernel19accumulate_contactsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPNS2_3matILi3ELi3EfLS4_0EEEPiSA_PNS3_ILi4EfLS4_0EEE_param_0+48]
  rd30 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (48))));
  // PTX:31 ld.param.u64 %rd29, [_ZN7synreal15granular_kernel19accumulate_contactsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPNS2_3matILi3ELi3EfLS4_0EEEPiSA_PNS3_ILi4EfLS4_0EEE_param_0+40]
  rd29 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (40))));
  // PTX:32 ld.param.u64 %rd28, [_ZN7synreal15granular_kernel19accumulate_contactsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPNS2_3matILi3ELi3EfLS4_0EEEPiSA_PNS3_ILi4EfLS4_0EEE_param_0+32]
  rd28 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (32))));
  // PTX:33 ld.param.u64 %rd27, [_ZN7synreal15granular_kernel19accumulate_contactsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPNS2_3matILi3ELi3EfLS4_0EEEPiSA_PNS3_ILi4EfLS4_0EEE_param_0+24]
  rd27 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (24))));
  // PTX:34 ld.param.u64 %rd25, [_ZN7synreal15granular_kernel19accumulate_contactsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPNS2_3matILi3ELi3EfLS4_0EEEPiSA_PNS3_ILi4EfLS4_0EEE_param_0+8]
  rd25 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (8))));
  // PTX:35 ld.param.u64 %rd24, [_ZN7synreal15granular_kernel19accumulate_contactsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPNS2_3matILi3ELi3EfLS4_0EEEPiSA_PNS3_ILi4EfLS4_0EEE_param_0]
  rd24 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:36 cvta.to.global.u64 %rd1, %rd24
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd24));
  // PTX:37 cvta.to.global.u64 %rd2, %rd25
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd25));
  // PTX:38 cvta.to.global.u64 %rd3, %rd27
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd27));
  // PTX:39 cvta.to.global.u64 %rd4, %rd28
  rd4 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd28));
  // PTX:40 cvta.to.global.u64 %rd5, %rd29
  rd5 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd29));
  // PTX:41 cvta.to.global.u64 %rd6, %rd30
  rd6 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd30));
  // PTX:42 cvta.to.global.u64 %rd7, %rd31
  rd7 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd31));
  // PTX:43 mov.u32 %r73, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r73) : "r"(blockDim.x));
  // PTX:44 mov.u32 %r74, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r74) : "r"(blockIdx.x));
  // PTX:45 mov.u32 %r75, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r75) : "r"(threadIdx.x));
  // PTX:46 mad.lo.s32 %r1, %r74, %r73, %r75
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r1) : "r"(r74), "r"(r73), "r"(r75));
  // PTX:47 setp.ge.s32 %p1, %r1, %r71
  p1 = (((int)(r1)) >= ((int)(r71)));
  // PTX:48 @%p1 bra $L__BB1_40
  if (p1) { goto L_BB1_40; }
  // PTX:50 cvt.s64.s32 %rd8, %r1
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd8) : "r"(r1));
  // PTX:51 mul.wide.s32 %rd40, %r1, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd40) : "r"(r1));
  // PTX:52 add.s64 %rd41, %rd4, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd41) : "l"(rd4), "l"(rd40));
  // PTX:53 mul.wide.s32 %rd42, %r1, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd42) : "r"(r1));
  // PTX:54 add.s64 %rd43, %rd3, %rd42
  asm("add.s64 %0, %1, %2;" : "=l"(rd43) : "l"(rd3), "l"(rd42));
  // PTX:55 ld.global.u32 %r3, [%rd43]
  r3 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (0)))));
  // PTX:56 ld.global.u32 %r79, [%rd41]
  r79 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (0)))));
  // PTX:57 add.s32 %r4, %r79, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r4) : "r"(r79));
  // PTX:58 mov.u32 %r179, -1
  asm("mov.u32 %0, -1;" : "=r"(r179) : );
  // PTX:59 ld.global.u32 %r80, [%rd41+4]
  r80 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (4)))));
  // PTX:60 add.s32 %r5, %r80, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r5) : "r"(r80));
  // PTX:61 ld.global.u32 %r81, [%rd41+8]
  r81 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (8)))));
  // PTX:62 add.s32 %r6, %r81, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r6) : "r"(r81));
  // PTX:63 add.s32 %r7, %r72, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r7) : "r"(r72));
  // PTX:64 cvta.to.global.u64 %rd13, %rd38
  rd13 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd38));
  // PTX:65 cvta.to.global.u64 %rd14, %rd39
  rd14 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd39));
  // PTX:66 mov.u32 %r176, 0
  asm("mov.u32 %0, 0;" : "=r"(r176) : );
  // PTX:67 bra.uni $L__BB1_2
  goto L_BB1_2;
  // PTX:69 $L__BB1_11:
L_BB1_11:;
  // PTX:70 mul.wide.u32 %rd49, %r176, -1431655765
  asm("mul.wide.u32 %0, %1, -1431655765;" : "=l"(rd49) : "r"(r176));
  // PTX:71 shr.u64 %rd50, %rd49, 33
  asm("shr.u64 %0, %1, 33;" : "=l"(rd50) : "l"(rd49));
  // PTX:72 cvt.u32.u64 %r87, %rd50
  asm("cvt.u32.u64 %0, %1;" : "=r"(r87) : "l"(rd50));
  // PTX:73 mul.lo.s32 %r88, %r87, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r88) : "r"(r87));
  // PTX:74 sub.s32 %r89, %r176, %r88
  asm("sub.s32 %0, %1, %2;" : "=r"(r89) : "r"(r176), "r"(r88));
  // PTX:75 mul.wide.u32 %rd51, %r87, -1431655765
  asm("mul.wide.u32 %0, %1, -1431655765;" : "=l"(rd51) : "r"(r87));
  // PTX:76 shr.u64 %rd52, %rd51, 33
  asm("shr.u64 %0, %1, 33;" : "=l"(rd52) : "l"(rd51));
  // PTX:77 cvt.u32.u64 %r90, %rd52
  asm("cvt.u32.u64 %0, %1;" : "=r"(r90) : "l"(rd52));
  // PTX:78 mul.lo.s32 %r91, %r90, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r91) : "r"(r90));
  // PTX:79 sub.s32 %r92, %r87, %r91
  asm("sub.s32 %0, %1, %2;" : "=r"(r92) : "r"(r87), "r"(r91));
  // PTX:80 add.s32 %r172, %r4, %r89
  asm("add.s32 %0, %1, %2;" : "=r"(r172) : "r"(r4), "r"(r89));
  // PTX:81 add.s32 %r173, %r5, %r92
  asm("add.s32 %0, %1, %2;" : "=r"(r173) : "r"(r5), "r"(r92));
  // PTX:82 mul.wide.u32 %rd53, %r176, 954437177
  asm("mul.wide.u32 %0, %1, 954437177;" : "=l"(rd53) : "r"(r176));
  // PTX:83 shr.u64 %rd54, %rd53, 33
  asm("shr.u64 %0, %1, 33;" : "=l"(rd54) : "l"(rd53));
  // PTX:84 cvt.u32.u64 %r93, %rd54
  asm("cvt.u32.u64 %0, %1;" : "=r"(r93) : "l"(rd54));
  // PTX:85 add.s32 %r174, %r6, %r93
  asm("add.s32 %0, %1, %2;" : "=r"(r174) : "r"(r6), "r"(r93));
  // PTX:86 add.s32 %r176, %r176, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r176) : "r"(r176));
  // PTX:87 mul.lo.s32 %r94, %r172, 73856093
  asm("mul.lo.s32 %0, %1, 73856093;" : "=r"(r94) : "r"(r172));
  // PTX:88 mul.lo.s32 %r95, %r173, 19349663
  asm("mul.lo.s32 %0, %1, 19349663;" : "=r"(r95) : "r"(r173));
  // PTX:89 mul.lo.s32 %r96, %r174, 83492791
  asm("mul.lo.s32 %0, %1, 83492791;" : "=r"(r96) : "r"(r174));
  // PTX:90 xor.b32 %r97, %r96, %r94
  asm("xor.b32 %0, %1, %2;" : "=r"(r97) : "r"(r96), "r"(r94));
  // PTX:91 xor.b32 %r98, %r97, %r95
  asm("xor.b32 %0, %1, %2;" : "=r"(r98) : "r"(r97), "r"(r95));
  // PTX:92 and.b32 %r99, %r98, %r7
  asm("and.b32 %0, %1, %2;" : "=r"(r99) : "r"(r98), "r"(r7));
  // PTX:93 mul.wide.s32 %rd55, %r99, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd55) : "r"(r99));
  // PTX:94 add.s64 %rd56, %rd1, %rd55
  asm("add.s64 %0, %1, %2;" : "=l"(rd56) : "l"(rd1), "l"(rd55));
  // PTX:95 ld.global.u32 %r179, [%rd56]
  r179 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))));
  // PTX:97 $L__BB1_2:
L_BB1_2:;
  // PTX:98 setp.lt.s32 %p2, %r179, 0
  p2 = (((int)(r179)) < ((int)(0)));
  // PTX:99 @%p2 bra $L__BB1_10
  if (p2) { goto L_BB1_10; }
  // PTX:101 mov.u32 %r180, %r179
  asm("mov.u32 %0, %1;" : "=r"(r180) : "r"(r179));
  // PTX:103 $L__BB1_4:
L_BB1_4:;
  // PTX:104 cvt.s64.s32 %rd15, %r180
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd15) : "r"(r180));
  // PTX:105 mul.wide.s32 %rd44, %r180, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd44) : "r"(r180));
  // PTX:106 add.s64 %rd45, %rd2, %rd44
  asm("add.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd2), "l"(rd44));
  // PTX:107 ld.global.u32 %r179, [%rd45]
  r179 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))));
  // PTX:108 mul.wide.s32 %rd46, %r180, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd46) : "r"(r180));
  // PTX:109 add.s64 %rd16, %rd4, %rd46
  asm("add.s64 %0, %1, %2;" : "=l"(rd16) : "l"(rd4), "l"(rd46));
  // PTX:110 ld.global.u32 %r82, [%rd16]
  r82 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:111 setp.ne.s32 %p3, %r82, %r172
  p3 = (((int)(r82)) != ((int)(r172)));
  // PTX:112 mov.u16 %rs17, 0
  asm("mov.u16 %0, 0;" : "=h"(rs17) : );
  // PTX:113 @%p3 bra $L__BB1_7
  if (p3) { goto L_BB1_7; }
  // PTX:115 ld.global.u32 %r83, [%rd16+4]
  r83 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (4)))));
  // PTX:116 setp.ne.s32 %p4, %r83, %r173
  p4 = (((int)(r83)) != ((int)(r173)));
  // PTX:117 @%p4 bra $L__BB1_7
  if (p4) { goto L_BB1_7; }
  // PTX:119 ld.global.u32 %r84, [%rd16+8]
  r84 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (8)))));
  // PTX:120 setp.eq.s32 %p5, %r84, %r174
  p5 = (((int)(r84)) == ((int)(r174)));
  // PTX:121 selp.u16 %rs17, 1, 0, %p5
  rs17 = p5 ? 1 : 0;
  // PTX:123 $L__BB1_7:
L_BB1_7:;
  // PTX:124 setp.eq.s16 %p6, %rs17, 0
  p6 = (((short)(rs17)) == ((short)(0)));
  // PTX:125 @%p6 bra $L__BB1_9
  if (p6) { goto L_BB1_9; }
  // PTX:127 shl.b64 %rd47, %rd15, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd47) : "l"(rd15));
  // PTX:128 add.s64 %rd48, %rd3, %rd47
  asm("add.s64 %0, %1, %2;" : "=l"(rd48) : "l"(rd3), "l"(rd47));
  // PTX:129 ld.global.u32 %r85, [%rd48]
  r85 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))));
  // PTX:130 setp.eq.s32 %p7, %r85, %r3
  p7 = (((int)(r85)) == ((int)(r3)));
  // PTX:131 @%p7 bra $L__BB1_12
  if (p7) { goto L_BB1_12; }
  // PTX:133 $L__BB1_9:
L_BB1_9:;
  // PTX:134 setp.gt.s32 %p8, %r179, -1
  p8 = (((int)(r179)) > ((int)(-1)));
  // PTX:135 mov.u32 %r180, %r179
  asm("mov.u32 %0, %1;" : "=r"(r180) : "r"(r179));
  // PTX:136 @%p8 bra $L__BB1_4
  if (p8) { goto L_BB1_4; }
  // PTX:138 $L__BB1_10:
L_BB1_10:;
  // PTX:139 setp.eq.s32 %p9, %r176, 27
  p9 = (((int)(r176)) == ((int)(27)));
  // PTX:140 mov.u32 %r180, -1
  asm("mov.u32 %0, -1;" : "=r"(r180) : );
  // PTX:141 @%p9 bra $L__BB1_12
  if (p9) { goto L_BB1_12; }
  // PTX:142 bra.uni $L__BB1_11
  goto L_BB1_11;
  // PTX:144 $L__BB1_12:
L_BB1_12:;
  // PTX:145 setp.lt.s32 %p10, %r180, 0
  p10 = (((int)(r180)) < ((int)(0)));
  // PTX:146 mov.u32 %r171, 0
  asm("mov.u32 %0, 0;" : "=r"(r171) : );
  // PTX:147 mov.f32 %f239, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f239) : );
  // PTX:148 mov.f32 %f241, %f239
  asm("mov.f32 %0, %1;" : "=f"(f241) : "f"(f239));
  // PTX:149 mov.f32 %f243, %f239
  asm("mov.f32 %0, %1;" : "=f"(f243) : "f"(f239));
  // PTX:150 mov.f32 %f245, %f239
  asm("mov.f32 %0, %1;" : "=f"(f245) : "f"(f239));
  // PTX:151 mov.f32 %f247, %f239
  asm("mov.f32 %0, %1;" : "=f"(f247) : "f"(f239));
  // PTX:152 mov.f32 %f249, %f239
  asm("mov.f32 %0, %1;" : "=f"(f249) : "f"(f239));
  // PTX:153 mov.f32 %f251, %f239
  asm("mov.f32 %0, %1;" : "=f"(f251) : "f"(f239));
  // PTX:154 mov.f32 %f253, %f239
  asm("mov.f32 %0, %1;" : "=f"(f253) : "f"(f239));
  // PTX:155 mov.f32 %f255, %f239
  asm("mov.f32 %0, %1;" : "=f"(f255) : "f"(f239));
  // PTX:156 mov.f32 %f257, %f239
  asm("mov.f32 %0, %1;" : "=f"(f257) : "f"(f239));
  // PTX:157 mov.f32 %f258, %f239
  asm("mov.f32 %0, %1;" : "=f"(f258) : "f"(f239));
  // PTX:158 mov.f32 %f259, %f239
  asm("mov.f32 %0, %1;" : "=f"(f259) : "f"(f239));
  // PTX:159 @%p10 bra $L__BB1_39
  if (p10) { goto L_BB1_39; }
  // PTX:161 mul.lo.s64 %rd57, %rd8, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd57) : "l"(rd8));
  // PTX:162 add.s64 %rd17, %rd5, %rd57
  asm("add.s64 %0, %1, %2;" : "=l"(rd17) : "l"(rd5), "l"(rd57));
  // PTX:163 shl.b64 %rd58, %rd8, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd58) : "l"(rd8));
  // PTX:164 add.s64 %rd18, %rd7, %rd58
  asm("add.s64 %0, %1, %2;" : "=l"(rd18) : "l"(rd7), "l"(rd58));
  // PTX:165 add.s64 %rd19, %rd6, %rd57
  asm("add.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd6), "l"(rd57));
  // PTX:166 div.rn.f32 %f5, %f101, %f97
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f5) : "f"(f101), "f"(f97));
  // PTX:167 cvt.s64.s32 %rd20, %r71
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd20) : "r"(r71));
  // PTX:168 mov.f32 %f259, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f259) : );
  // PTX:169 mov.u32 %r171, 0
  asm("mov.u32 %0, 0;" : "=r"(r171) : );
  // PTX:170 mov.f32 %f258, %f259
  asm("mov.f32 %0, %1;" : "=f"(f258) : "f"(f259));
  // PTX:171 mov.f32 %f257, %f259
  asm("mov.f32 %0, %1;" : "=f"(f257) : "f"(f259));
  // PTX:172 mov.f32 %f255, %f259
  asm("mov.f32 %0, %1;" : "=f"(f255) : "f"(f259));
  // PTX:173 mov.f32 %f253, %f259
  asm("mov.f32 %0, %1;" : "=f"(f253) : "f"(f259));
  // PTX:174 mov.f32 %f251, %f259
  asm("mov.f32 %0, %1;" : "=f"(f251) : "f"(f259));
  // PTX:175 mov.f32 %f249, %f259
  asm("mov.f32 %0, %1;" : "=f"(f249) : "f"(f259));
  // PTX:176 mov.f32 %f247, %f259
  asm("mov.f32 %0, %1;" : "=f"(f247) : "f"(f259));
  // PTX:177 mov.f32 %f245, %f259
  asm("mov.f32 %0, %1;" : "=f"(f245) : "f"(f259));
  // PTX:178 mov.f32 %f243, %f259
  asm("mov.f32 %0, %1;" : "=f"(f243) : "f"(f259));
  // PTX:179 mov.f32 %f241, %f259
  asm("mov.f32 %0, %1;" : "=f"(f241) : "f"(f259));
  // PTX:180 mov.f32 %f239, %f259
  asm("mov.f32 %0, %1;" : "=f"(f239) : "f"(f259));
  // PTX:182 $L__BB1_14:
L_BB1_14:;
  // PTX:183 setp.eq.s32 %p11, %r1, %r180
  p11 = (((int)(r1)) == ((int)(r180)));
  // PTX:184 @%p11 bra $L__BB1_28
  if (p11) { goto L_BB1_28; }
  // PTX:186 cvt.s64.s32 %rd21, %r180
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd21) : "r"(r180));
  // PTX:187 mul.wide.s32 %rd59, %r180, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd59) : "r"(r180));
  // PTX:188 add.s64 %rd60, %rd5, %rd59
  asm("add.s64 %0, %1, %2;" : "=l"(rd60) : "l"(rd5), "l"(rd59));
  // PTX:189 ld.global.f32 %f135, [%rd60]
  f135 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))));
  // PTX:190 ld.global.f32 %f136, [%rd17]
  f136 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:191 sub.f32 %f27, %f136, %f135
  asm("sub.f32 %0, %1, %2;" : "=f"(f27) : "f"(f136), "f"(f135));
  // PTX:192 ld.global.f32 %f137, [%rd60+4]
  f137 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (4)))));
  // PTX:193 ld.global.f32 %f138, [%rd17+4]
  f138 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (4)))));
  // PTX:194 sub.f32 %f28, %f138, %f137
  asm("sub.f32 %0, %1, %2;" : "=f"(f28) : "f"(f138), "f"(f137));
  // PTX:195 ld.global.f32 %f139, [%rd60+8]
  f139 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (8)))));
  // PTX:196 ld.global.f32 %f140, [%rd17+8]
  f140 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (8)))));
  // PTX:197 sub.f32 %f29, %f140, %f139
  asm("sub.f32 %0, %1, %2;" : "=f"(f29) : "f"(f140), "f"(f139));
  // PTX:198 mul.wide.s32 %rd61, %r180, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd61) : "r"(r180));
  // PTX:199 add.s64 %rd62, %rd7, %rd61
  asm("add.s64 %0, %1, %2;" : "=l"(rd62) : "l"(rd7), "l"(rd61));
  // PTX:200 ld.global.f32 %f141, [%rd62]
  f141 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))));
  // PTX:201 ld.global.f32 %f142, [%rd18]
  f142 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (0)))));
  // PTX:202 add.f32 %f30, %f142, %f141
  asm("add.f32 %0, %1, %2;" : "=f"(f30) : "f"(f142), "f"(f141));
  // PTX:203 mul.f32 %f143, %f28, %f28
  asm("mul.f32 %0, %1, %2;" : "=f"(f143) : "f"(f28), "f"(f28));
  // PTX:204 fma.rn.f32 %f144, %f27, %f27, %f143
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f144) : "f"(f27), "f"(f27), "f"(f143));
  // PTX:205 fma.rn.f32 %f31, %f29, %f29, %f144
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f31) : "f"(f29), "f"(f29), "f"(f144));
  // PTX:206 mul.f32 %f145, %f30, %f30
  asm("mul.f32 %0, %1, %2;" : "=f"(f145) : "f"(f30), "f"(f30));
  // PTX:207 setp.ge.f32 %p12, %f31, %f145
  p12 = (!(isnan(((float)(f31))) || isnan(((float)(f145)))) && (((float)(f31)) >= ((float)(f145))));
  // PTX:208 @%p12 bra $L__BB1_28
  if (p12) { goto L_BB1_28; }
  // PTX:210 mul.lo.s64 %rd63, %rd21, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd63) : "l"(rd21));
  // PTX:211 add.s64 %rd64, %rd6, %rd63
  asm("add.s64 %0, %1, %2;" : "=l"(rd64) : "l"(rd6), "l"(rd63));
  // PTX:212 ld.global.f32 %f146, [%rd64]
  f146 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (0)))));
  // PTX:213 ld.global.f32 %f147, [%rd19]
  f147 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))));
  // PTX:214 sub.f32 %f32, %f147, %f146
  asm("sub.f32 %0, %1, %2;" : "=f"(f32) : "f"(f147), "f"(f146));
  // PTX:215 ld.global.f32 %f148, [%rd64+4]
  f148 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (4)))));
  // PTX:216 ld.global.f32 %f149, [%rd19+4]
  f149 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (4)))));
  // PTX:217 sub.f32 %f33, %f149, %f148
  asm("sub.f32 %0, %1, %2;" : "=f"(f33) : "f"(f149), "f"(f148));
  // PTX:218 ld.global.f32 %f150, [%rd64+8]
  f150 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (8)))));
  // PTX:219 ld.global.f32 %f151, [%rd19+8]
  f151 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (8)))));
  // PTX:220 sub.f32 %f34, %f151, %f150
  asm("sub.f32 %0, %1, %2;" : "=f"(f34) : "f"(f151), "f"(f150));
  // PTX:221 sqrt.rn.f32 %f35, %f31
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f35) : "f"(f31));
  // PTX:222 setp.gt.f32 %p13, %f35, 0f322BCC77
  p13 = (!(isnan(((float)(f35))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f35)) > ((float)(as_f32(0x322BCC77u)))));
  // PTX:223 @%p13 bra $L__BB1_24
  if (p13) { goto L_BB1_24; }
  // PTX:224 bra.uni $L__BB1_17
  goto L_BB1_17;
  // PTX:226 $L__BB1_24:
L_BB1_24:;
  // PTX:227 div.rn.f32 %f158, %f27, %f35
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f158) : "f"(f27), "f"(f35));
  // PTX:228 div.rn.f32 %f159, %f28, %f35
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f159) : "f"(f28), "f"(f35));
  // PTX:229 div.rn.f32 %f160, %f29, %f35
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f160) : "f"(f29), "f"(f35));
  // PTX:230 mov.b32 %r170, %f160
  asm("mov.b32 %0, %1;" : "=r"(r170) : "f"(f160));
  // PTX:231 mov.b32 %r169, %f159
  asm("mov.b32 %0, %1;" : "=r"(r169) : "f"(f159));
  // PTX:232 mov.b32 %r168, %f158
  asm("mov.b32 %0, %1;" : "=r"(r168) : "f"(f158));
  // PTX:233 bra.uni $L__BB1_25
  goto L_BB1_25;
  // PTX:235 $L__BB1_17:
L_BB1_17:;
  // PTX:236 mul.f32 %f152, %f33, %f33
  asm("mul.f32 %0, %1, %2;" : "=f"(f152) : "f"(f33), "f"(f33));
  // PTX:237 fma.rn.f32 %f153, %f32, %f32, %f152
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f153) : "f"(f32), "f"(f32), "f"(f152));
  // PTX:238 fma.rn.f32 %f36, %f34, %f34, %f153
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f36) : "f"(f34), "f"(f34), "f"(f153));
  // PTX:239 setp.gt.f32 %p14, %f36, 0f24E69595
  p14 = (!(isnan(((float)(f36))) || isnan(((float)(as_f32(0x24E69595u))))) && (((float)(f36)) > ((float)(as_f32(0x24E69595u)))));
  // PTX:240 @%p14 bra $L__BB1_23
  if (p14) { goto L_BB1_23; }
  // PTX:241 bra.uni $L__BB1_18
  goto L_BB1_18;
  // PTX:243 $L__BB1_23:
L_BB1_23:;
  // PTX:244 rsqrt.approx.f32 %f154, %f36
  asm("rsqrt.approx.f32 %0, %1;" : "=f"(f154) : "f"(f36));
  // PTX:245 mul.f32 %f155, %f32, %f154
  asm("mul.f32 %0, %1, %2;" : "=f"(f155) : "f"(f32), "f"(f154));
  // PTX:246 mul.f32 %f156, %f33, %f154
  asm("mul.f32 %0, %1, %2;" : "=f"(f156) : "f"(f33), "f"(f154));
  // PTX:247 mul.f32 %f157, %f34, %f154
  asm("mul.f32 %0, %1, %2;" : "=f"(f157) : "f"(f34), "f"(f154));
  // PTX:248 mov.b32 %r170, %f157
  asm("mov.b32 %0, %1;" : "=r"(r170) : "f"(f157));
  // PTX:249 mov.b32 %r169, %f156
  asm("mov.b32 %0, %1;" : "=r"(r169) : "f"(f156));
  // PTX:250 mov.b32 %r168, %f155
  asm("mov.b32 %0, %1;" : "=r"(r168) : "f"(f155));
  // PTX:251 bra.uni $L__BB1_25
  goto L_BB1_25;
  // PTX:253 $L__BB1_18:
L_BB1_18:;
  // PTX:254 setp.lt.s32 %p15, %r1, %r180
  p15 = (((int)(r1)) < ((int)(r180)));
  // PTX:255 selp.f32 %f37, 0f3F800000, 0fBF800000, %p15
  f37 = p15 ? as_f32(0x3F800000u) : as_f32(0xBF800000u);
  // PTX:256 min.s32 %r103, %r1, %r180
  asm("min.s32 %0, %1, %2;" : "=r"(r103) : "r"(r1), "r"(r180));
  // PTX:257 max.s32 %r104, %r1, %r180
  asm("max.s32 %0, %1, %2;" : "=r"(r104) : "r"(r1), "r"(r180));
  // PTX:258 add.s32 %r105, %r103, %r104
  asm("add.s32 %0, %1, %2;" : "=r"(r105) : "r"(r103), "r"(r104));
  // PTX:259 mul.hi.s32 %r106, %r105, 1431655766
  asm("mul.hi.s32 %0, %1, 1431655766;" : "=r"(r106) : "r"(r105));
  // PTX:260 shr.u32 %r107, %r106, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r107) : "r"(r106));
  // PTX:261 add.s32 %r108, %r106, %r107
  asm("add.s32 %0, %1, %2;" : "=r"(r108) : "r"(r106), "r"(r107));
  // PTX:262 mul.lo.s32 %r109, %r108, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r109) : "r"(r108));
  // PTX:263 sub.s32 %r102, %r105, %r109
  asm("sub.s32 %0, %1, %2;" : "=r"(r102) : "r"(r105), "r"(r109));
  // PTX:264 setp.eq.s32 %p16, %r102, 2
  p16 = (((int)(r102)) == ((int)(2)));
  // PTX:265 @%p16 bra $L__BB1_21
  if (p16) { goto L_BB1_21; }
  // PTX:267 setp.ne.s32 %p17, %r102, 1
  p17 = (((int)(r102)) != ((int)(1)));
  // PTX:268 @%p17 bra $L__BB1_22
  if (p17) { goto L_BB1_22; }
  // PTX:270 mov.b32 %r169, %f37
  asm("mov.b32 %0, %1;" : "=r"(r169) : "f"(f37));
  // PTX:271 mov.u32 %r168, 0
  asm("mov.u32 %0, 0;" : "=r"(r168) : );
  // PTX:272 mov.u32 %r170, %r168
  asm("mov.u32 %0, %1;" : "=r"(r170) : "r"(r168));
  // PTX:273 bra.uni $L__BB1_25
  goto L_BB1_25;
  // PTX:275 $L__BB1_21:
L_BB1_21:;
  // PTX:276 mov.b32 %r170, %f37
  asm("mov.b32 %0, %1;" : "=r"(r170) : "f"(f37));
  // PTX:277 mov.u32 %r168, 0
  asm("mov.u32 %0, 0;" : "=r"(r168) : );
  // PTX:278 mov.u32 %r169, %r168
  asm("mov.u32 %0, %1;" : "=r"(r169) : "r"(r168));
  // PTX:279 bra.uni $L__BB1_25
  goto L_BB1_25;
  // PTX:281 $L__BB1_22:
L_BB1_22:;
  // PTX:282 mov.b32 %r168, %f37
  asm("mov.b32 %0, %1;" : "=r"(r168) : "f"(f37));
  // PTX:283 mov.u32 %r169, 0
  asm("mov.u32 %0, 0;" : "=r"(r169) : );
  // PTX:284 mov.u32 %r170, %r169
  asm("mov.u32 %0, %1;" : "=r"(r170) : "r"(r169));
  // PTX:286 $L__BB1_25:
L_BB1_25:;
  // PTX:287 mov.b32 %f161, %r168
  asm("mov.b32 %0, %1;" : "=f"(f161) : "r"(r168));
  // PTX:288 sub.f32 %f162, %f27, %f32
  asm("sub.f32 %0, %1, %2;" : "=f"(f162) : "f"(f27), "f"(f32));
  // PTX:289 mov.b32 %f163, %r169
  asm("mov.b32 %0, %1;" : "=f"(f163) : "r"(r169));
  // PTX:290 sub.f32 %f164, %f28, %f33
  asm("sub.f32 %0, %1, %2;" : "=f"(f164) : "f"(f28), "f"(f33));
  // PTX:291 mul.f32 %f165, %f164, %f163
  asm("mul.f32 %0, %1, %2;" : "=f"(f165) : "f"(f164), "f"(f163));
  // PTX:292 mov.b32 %f166, %r170
  asm("mov.b32 %0, %1;" : "=f"(f166) : "r"(r170));
  // PTX:293 sub.f32 %f167, %f29, %f34
  asm("sub.f32 %0, %1, %2;" : "=f"(f167) : "f"(f29), "f"(f34));
  // PTX:294 fma.rn.f32 %f168, %f162, %f161, %f165
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f168) : "f"(f162), "f"(f161), "f"(f165));
  // PTX:295 fma.rn.f32 %f169, %f167, %f166, %f168
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f169) : "f"(f167), "f"(f166), "f"(f168));
  // PTX:296 mul.f32 %f170, %f169, %f161
  asm("mul.f32 %0, %1, %2;" : "=f"(f170) : "f"(f169), "f"(f161));
  // PTX:297 mul.f32 %f171, %f169, %f163
  asm("mul.f32 %0, %1, %2;" : "=f"(f171) : "f"(f169), "f"(f163));
  // PTX:298 mul.f32 %f172, %f169, %f166
  asm("mul.f32 %0, %1, %2;" : "=f"(f172) : "f"(f169), "f"(f166));
  // PTX:299 sub.f32 %f173, %f162, %f170
  asm("sub.f32 %0, %1, %2;" : "=f"(f173) : "f"(f162), "f"(f170));
  // PTX:300 sub.f32 %f174, %f164, %f171
  asm("sub.f32 %0, %1, %2;" : "=f"(f174) : "f"(f164), "f"(f171));
  // PTX:301 sub.f32 %f175, %f167, %f172
  asm("sub.f32 %0, %1, %2;" : "=f"(f175) : "f"(f167), "f"(f172));
  // PTX:302 sub.f32 %f176, %f30, %f35
  asm("sub.f32 %0, %1, %2;" : "=f"(f176) : "f"(f30), "f"(f35));
  // PTX:303 mul.f32 %f177, %f99, %f176
  asm("mul.f32 %0, %1, %2;" : "=f"(f177) : "f"(f99), "f"(f176));
  // PTX:304 mul.f32 %f178, %f100, %f177
  asm("mul.f32 %0, %1, %2;" : "=f"(f178) : "f"(f100), "f"(f177));
  // PTX:305 mul.f32 %f179, %f174, %f174
  asm("mul.f32 %0, %1, %2;" : "=f"(f179) : "f"(f174), "f"(f174));
  // PTX:306 fma.rn.f32 %f180, %f173, %f173, %f179
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f180) : "f"(f173), "f"(f173), "f"(f179));
  // PTX:307 fma.rn.f32 %f181, %f175, %f175, %f180
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f181) : "f"(f175), "f"(f175), "f"(f180));
  // PTX:308 sqrt.rn.f32 %f182, %f181
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f182) : "f"(f181));
  // PTX:309 mov.f32 %f183, 0f322BCC77
  asm("mov.f32 %0, 0f322BCC77;" : "=f"(f183) : );
  // PTX:310 max.f32 %f184, %f182, %f183
  asm("max.f32 %0, %1, %2;" : "=f"(f184) : "f"(f182), "f"(f183));
  // PTX:311 div.rn.f32 %f185, %f178, %f184
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f185) : "f"(f178), "f"(f184));
  // PTX:312 min.f32 %f38, %f5, %f185
  asm("min.f32 %0, %1, %2;" : "=f"(f38) : "f"(f5), "f"(f185));
  // PTX:313 mul.f32 %f186, %f177, %f161
  asm("mul.f32 %0, %1, %2;" : "=f"(f186) : "f"(f177), "f"(f161));
  // PTX:314 mul.f32 %f187, %f177, %f163
  asm("mul.f32 %0, %1, %2;" : "=f"(f187) : "f"(f177), "f"(f163));
  // PTX:315 mul.f32 %f188, %f177, %f166
  asm("mul.f32 %0, %1, %2;" : "=f"(f188) : "f"(f177), "f"(f166));
  // PTX:316 mul.f32 %f189, %f38, %f173
  asm("mul.f32 %0, %1, %2;" : "=f"(f189) : "f"(f38), "f"(f173));
  // PTX:317 mul.f32 %f190, %f38, %f174
  asm("mul.f32 %0, %1, %2;" : "=f"(f190) : "f"(f38), "f"(f174));
  // PTX:318 mul.f32 %f191, %f38, %f175
  asm("mul.f32 %0, %1, %2;" : "=f"(f191) : "f"(f38), "f"(f175));
  // PTX:319 sub.f32 %f39, %f186, %f189
  asm("sub.f32 %0, %1, %2;" : "=f"(f39) : "f"(f186), "f"(f189));
  // PTX:320 sub.f32 %f40, %f187, %f190
  asm("sub.f32 %0, %1, %2;" : "=f"(f40) : "f"(f187), "f"(f190));
  // PTX:321 sub.f32 %f41, %f188, %f191
  asm("sub.f32 %0, %1, %2;" : "=f"(f41) : "f"(f188), "f"(f191));
  // PTX:322 mul.f32 %f193, %f163, %f161
  asm("mul.f32 %0, %1, %2;" : "=f"(f193) : "f"(f163), "f"(f161));
  // PTX:323 mul.f32 %f194, %f166, %f161
  asm("mul.f32 %0, %1, %2;" : "=f"(f194) : "f"(f166), "f"(f161));
  // PTX:324 mul.f32 %f196, %f166, %f163
  asm("mul.f32 %0, %1, %2;" : "=f"(f196) : "f"(f166), "f"(f163));
  // PTX:325 sub.f32 %f198, %f99, %f38
  asm("sub.f32 %0, %1, %2;" : "=f"(f198) : "f"(f99), "f"(f38));
  // PTX:326 mul.f32 %f199, %f198, %f193
  asm("mul.f32 %0, %1, %2;" : "=f"(f199) : "f"(f198), "f"(f193));
  // PTX:327 mul.f32 %f200, %f198, %f194
  asm("mul.f32 %0, %1, %2;" : "=f"(f200) : "f"(f198), "f"(f194));
  // PTX:328 mul.f32 %f201, %f198, %f196
  asm("mul.f32 %0, %1, %2;" : "=f"(f201) : "f"(f198), "f"(f196));
  // PTX:329 fma.rn.f32 %f43, %f38, 0f00000000, %f199
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f43) : "f"(f38), "f"(f199));
  // PTX:330 fma.rn.f32 %f44, %f38, 0f00000000, %f200
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f44) : "f"(f38), "f"(f200));
  // PTX:331 fma.rn.f32 %f46, %f38, 0f00000000, %f201
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f46) : "f"(f38), "f"(f201));
  // PTX:332 setp.gt.s32 %p18, %r171, 31
  p18 = (((int)(r171)) > ((int)(31)));
  // PTX:333 @%p18 bra $L__BB1_27
  if (p18) { goto L_BB1_27; }
  // PTX:335 cvt.s64.s32 %rd65, %r171
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd65) : "r"(r171));
  // PTX:336 mul.lo.s64 %rd66, %rd65, %rd20
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd66) : "l"(rd65), "l"(rd20));
  // PTX:337 add.s64 %rd67, %rd66, %rd8
  asm("add.s64 %0, %1, %2;" : "=l"(rd67) : "l"(rd66), "l"(rd8));
  // PTX:338 shl.b64 %rd68, %rd67, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd68) : "l"(rd67));
  // PTX:339 add.s64 %rd69, %rd13, %rd68
  asm("add.s64 %0, %1, %2;" : "=l"(rd69) : "l"(rd13), "l"(rd68));
  // PTX:340 st.global.u32 [%rd69], %r180
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (0))))) = (unsigned)(r180);
  // PTX:341 shl.b64 %rd70, %rd67, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd70) : "l"(rd67));
  // PTX:342 add.s64 %rd71, %rd14, %rd70
  asm("add.s64 %0, %1, %2;" : "=l"(rd71) : "l"(rd14), "l"(rd70));
  // PTX:343 st.global.u32 [%rd71], %r168
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0))))) = (unsigned)(r168);
  // PTX:344 st.global.u32 [%rd71+4], %r169
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (4))))) = (unsigned)(r169);
  // PTX:345 st.global.u32 [%rd71+8], %r170
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (8))))) = (unsigned)(r170);
  // PTX:346 st.global.f32 [%rd71+12], %f38
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (12))))) = (float)(f38);
  // PTX:348 $L__BB1_27:
L_BB1_27:;
  // PTX:349 sub.f32 %f217, %f99, %f38
  asm("sub.f32 %0, %1, %2;" : "=f"(f217) : "f"(f99), "f"(f38));
  // PTX:350 mov.b32 %f216, %r170
  asm("mov.b32 %0, %1;" : "=f"(f216) : "r"(r170));
  // PTX:351 mul.f32 %f215, %f216, %f216
  asm("mul.f32 %0, %1, %2;" : "=f"(f215) : "f"(f216), "f"(f216));
  // PTX:352 fma.rn.f32 %f214, %f217, %f215, %f38
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f214) : "f"(f217), "f"(f215), "f"(f38));
  // PTX:353 mov.b32 %f213, %r169
  asm("mov.b32 %0, %1;" : "=f"(f213) : "r"(r169));
  // PTX:354 mul.f32 %f212, %f213, %f213
  asm("mul.f32 %0, %1, %2;" : "=f"(f212) : "f"(f213), "f"(f213));
  // PTX:355 fma.rn.f32 %f211, %f217, %f212, %f38
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f211) : "f"(f217), "f"(f212), "f"(f38));
  // PTX:356 mov.b32 %f210, %r168
  asm("mov.b32 %0, %1;" : "=f"(f210) : "r"(r168));
  // PTX:357 mul.f32 %f209, %f210, %f210
  asm("mul.f32 %0, %1, %2;" : "=f"(f209) : "f"(f210), "f"(f210));
  // PTX:358 fma.rn.f32 %f208, %f217, %f209, %f38
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f208) : "f"(f217), "f"(f209), "f"(f38));
  // PTX:359 add.f32 %f239, %f239, %f208
  asm("add.f32 %0, %1, %2;" : "=f"(f239) : "f"(f239), "f"(f208));
  // PTX:360 add.f32 %f241, %f241, %f43
  asm("add.f32 %0, %1, %2;" : "=f"(f241) : "f"(f241), "f"(f43));
  // PTX:361 add.f32 %f243, %f243, %f44
  asm("add.f32 %0, %1, %2;" : "=f"(f243) : "f"(f243), "f"(f44));
  // PTX:362 add.f32 %f245, %f245, %f43
  asm("add.f32 %0, %1, %2;" : "=f"(f245) : "f"(f245), "f"(f43));
  // PTX:363 add.f32 %f247, %f247, %f211
  asm("add.f32 %0, %1, %2;" : "=f"(f247) : "f"(f247), "f"(f211));
  // PTX:364 add.f32 %f249, %f249, %f46
  asm("add.f32 %0, %1, %2;" : "=f"(f249) : "f"(f249), "f"(f46));
  // PTX:365 add.f32 %f251, %f251, %f44
  asm("add.f32 %0, %1, %2;" : "=f"(f251) : "f"(f251), "f"(f44));
  // PTX:366 add.f32 %f253, %f253, %f46
  asm("add.f32 %0, %1, %2;" : "=f"(f253) : "f"(f253), "f"(f46));
  // PTX:367 add.f32 %f255, %f255, %f214
  asm("add.f32 %0, %1, %2;" : "=f"(f255) : "f"(f255), "f"(f214));
  // PTX:368 add.s32 %r171, %r171, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r171) : "r"(r171));
  // PTX:369 add.f32 %f259, %f259, %f41
  asm("add.f32 %0, %1, %2;" : "=f"(f259) : "f"(f259), "f"(f41));
  // PTX:370 add.f32 %f258, %f258, %f40
  asm("add.f32 %0, %1, %2;" : "=f"(f258) : "f"(f258), "f"(f40));
  // PTX:371 add.f32 %f257, %f257, %f39
  asm("add.f32 %0, %1, %2;" : "=f"(f257) : "f"(f257), "f"(f39));
  // PTX:372 bra.uni $L__BB1_28
  goto L_BB1_28;
  // PTX:374 $L__BB1_37:
L_BB1_37:;
  // PTX:375 mul.hi.s32 %r121, %r176, 1431655766
  asm("mul.hi.s32 %0, %1, 1431655766;" : "=r"(r121) : "r"(r176));
  // PTX:376 shr.u32 %r122, %r121, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r122) : "r"(r121));
  // PTX:377 add.s32 %r123, %r121, %r122
  asm("add.s32 %0, %1, %2;" : "=r"(r123) : "r"(r121), "r"(r122));
  // PTX:378 mul.lo.s32 %r124, %r123, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r124) : "r"(r123));
  // PTX:379 sub.s32 %r125, %r176, %r124
  asm("sub.s32 %0, %1, %2;" : "=r"(r125) : "r"(r176), "r"(r124));
  // PTX:380 mul.hi.s32 %r126, %r123, 1431655766
  asm("mul.hi.s32 %0, %1, 1431655766;" : "=r"(r126) : "r"(r123));
  // PTX:381 shr.u32 %r127, %r126, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r127) : "r"(r126));
  // PTX:382 add.s32 %r128, %r126, %r127
  asm("add.s32 %0, %1, %2;" : "=r"(r128) : "r"(r126), "r"(r127));
  // PTX:383 mul.lo.s32 %r129, %r128, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r129) : "r"(r128));
  // PTX:384 sub.s32 %r130, %r123, %r129
  asm("sub.s32 %0, %1, %2;" : "=r"(r130) : "r"(r123), "r"(r129));
  // PTX:385 add.s32 %r172, %r4, %r125
  asm("add.s32 %0, %1, %2;" : "=r"(r172) : "r"(r4), "r"(r125));
  // PTX:386 add.s32 %r173, %r5, %r130
  asm("add.s32 %0, %1, %2;" : "=r"(r173) : "r"(r5), "r"(r130));
  // PTX:387 mul.hi.s32 %r131, %r176, 954437177
  asm("mul.hi.s32 %0, %1, 954437177;" : "=r"(r131) : "r"(r176));
  // PTX:388 shr.u32 %r132, %r131, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r132) : "r"(r131));
  // PTX:389 shr.s32 %r133, %r131, 1
  asm("shr.s32 %0, %1, 1;" : "=r"(r133) : "r"(r131));
  // PTX:390 add.s32 %r134, %r133, %r132
  asm("add.s32 %0, %1, %2;" : "=r"(r134) : "r"(r133), "r"(r132));
  // PTX:391 add.s32 %r174, %r6, %r134
  asm("add.s32 %0, %1, %2;" : "=r"(r174) : "r"(r6), "r"(r134));
  // PTX:392 add.s32 %r176, %r176, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r176) : "r"(r176));
  // PTX:393 mul.lo.s32 %r135, %r172, 73856093
  asm("mul.lo.s32 %0, %1, 73856093;" : "=r"(r135) : "r"(r172));
  // PTX:394 mul.lo.s32 %r136, %r173, 19349663
  asm("mul.lo.s32 %0, %1, 19349663;" : "=r"(r136) : "r"(r173));
  // PTX:395 mul.lo.s32 %r137, %r174, 83492791
  asm("mul.lo.s32 %0, %1, 83492791;" : "=r"(r137) : "r"(r174));
  // PTX:396 xor.b32 %r138, %r137, %r135
  asm("xor.b32 %0, %1, %2;" : "=r"(r138) : "r"(r137), "r"(r135));
  // PTX:397 xor.b32 %r139, %r138, %r136
  asm("xor.b32 %0, %1, %2;" : "=r"(r139) : "r"(r138), "r"(r136));
  // PTX:398 and.b32 %r140, %r139, %r7
  asm("and.b32 %0, %1, %2;" : "=r"(r140) : "r"(r139), "r"(r7));
  // PTX:399 mul.wide.s32 %rd77, %r140, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd77) : "r"(r140));
  // PTX:400 add.s64 %rd78, %rd1, %rd77
  asm("add.s64 %0, %1, %2;" : "=l"(rd78) : "l"(rd1), "l"(rd77));
  // PTX:401 ld.global.u32 %r179, [%rd78]
  r179 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd78) + (0)))));
  // PTX:403 $L__BB1_28:
L_BB1_28:;
  // PTX:404 setp.lt.s32 %p19, %r179, 0
  p19 = (((int)(r179)) < ((int)(0)));
  // PTX:405 @%p19 bra $L__BB1_36
  if (p19) { goto L_BB1_36; }
  // PTX:407 mov.u32 %r180, %r179
  asm("mov.u32 %0, %1;" : "=r"(r180) : "r"(r179));
  // PTX:409 $L__BB1_30:
L_BB1_30:;
  // PTX:410 mul.wide.s32 %rd72, %r180, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd72) : "r"(r180));
  // PTX:411 add.s64 %rd73, %rd2, %rd72
  asm("add.s64 %0, %1, %2;" : "=l"(rd73) : "l"(rd2), "l"(rd72));
  // PTX:412 ld.global.u32 %r179, [%rd73]
  r179 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (0)))));
  // PTX:413 mul.wide.s32 %rd74, %r180, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd74) : "r"(r180));
  // PTX:414 add.s64 %rd23, %rd4, %rd74
  asm("add.s64 %0, %1, %2;" : "=l"(rd23) : "l"(rd4), "l"(rd74));
  // PTX:415 ld.global.u32 %r116, [%rd23]
  r116 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (0)))));
  // PTX:416 setp.ne.s32 %p20, %r116, %r172
  p20 = (((int)(r116)) != ((int)(r172)));
  // PTX:417 mov.u16 %rs18, 0
  asm("mov.u16 %0, 0;" : "=h"(rs18) : );
  // PTX:418 @%p20 bra $L__BB1_33
  if (p20) { goto L_BB1_33; }
  // PTX:420 ld.global.u32 %r117, [%rd23+4]
  r117 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (4)))));
  // PTX:421 setp.ne.s32 %p21, %r117, %r173
  p21 = (((int)(r117)) != ((int)(r173)));
  // PTX:422 @%p21 bra $L__BB1_33
  if (p21) { goto L_BB1_33; }
  // PTX:424 ld.global.u32 %r118, [%rd23+8]
  r118 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (8)))));
  // PTX:425 setp.eq.s32 %p22, %r118, %r174
  p22 = (((int)(r118)) == ((int)(r174)));
  // PTX:426 selp.u16 %rs18, 1, 0, %p22
  rs18 = p22 ? 1 : 0;
  // PTX:428 $L__BB1_33:
L_BB1_33:;
  // PTX:429 setp.eq.s16 %p23, %rs18, 0
  p23 = (((short)(rs18)) == ((short)(0)));
  // PTX:430 @%p23 bra $L__BB1_35
  if (p23) { goto L_BB1_35; }
  // PTX:432 cvt.s64.s32 %rd86, %r180
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd86) : "r"(r180));
  // PTX:433 shl.b64 %rd75, %rd86, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd75) : "l"(rd86));
  // PTX:434 add.s64 %rd76, %rd3, %rd75
  asm("add.s64 %0, %1, %2;" : "=l"(rd76) : "l"(rd3), "l"(rd75));
  // PTX:435 ld.global.u32 %r119, [%rd76]
  r119 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (0)))));
  // PTX:436 setp.eq.s32 %p24, %r119, %r3
  p24 = (((int)(r119)) == ((int)(r3)));
  // PTX:437 @%p24 bra $L__BB1_38
  if (p24) { goto L_BB1_38; }
  // PTX:439 $L__BB1_35:
L_BB1_35:;
  // PTX:440 setp.gt.s32 %p25, %r179, -1
  p25 = (((int)(r179)) > ((int)(-1)));
  // PTX:441 mov.u32 %r180, %r179
  asm("mov.u32 %0, %1;" : "=r"(r180) : "r"(r179));
  // PTX:442 @%p25 bra $L__BB1_30
  if (p25) { goto L_BB1_30; }
  // PTX:444 $L__BB1_36:
L_BB1_36:;
  // PTX:445 setp.eq.s32 %p26, %r176, 27
  p26 = (((int)(r176)) == ((int)(27)));
  // PTX:446 mov.u32 %r180, -1
  asm("mov.u32 %0, -1;" : "=r"(r180) : );
  // PTX:447 @%p26 bra $L__BB1_38
  if (p26) { goto L_BB1_38; }
  // PTX:448 bra.uni $L__BB1_37
  goto L_BB1_37;
  // PTX:450 $L__BB1_38:
L_BB1_38:;
  // PTX:451 setp.gt.s32 %p27, %r180, -1
  p27 = (((int)(r180)) > ((int)(-1)));
  // PTX:452 @%p27 bra $L__BB1_14
  if (p27) { goto L_BB1_14; }
  // PTX:454 $L__BB1_39:
L_BB1_39:;
  // PTX:455 ld.param.u64 %rd94, [_ZN7synreal15granular_kernel19accumulate_contactsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPNS2_3matILi3ELi3EfLS4_0EEEPiSA_PNS3_ILi4EfLS4_0EEE_param_2]
  rd94 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:456 cvta.to.global.u64 %rd93, %rd94
  rd93 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd94));
  // PTX:457 ld.param.u64 %rd92, [_ZN7synreal15granular_kernel19accumulate_contactsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPNS2_3matILi3ELi3EfLS4_0EEEPiSA_PNS3_ILi4EfLS4_0EEE_param_1]
  rd92 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:458 cvta.to.global.u64 %rd91, %rd92
  rd91 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd92));
  // PTX:459 ld.param.u64 %rd90, [_ZN7synreal15granular_kernel19accumulate_contactsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPNS2_3matILi3ELi3EfLS4_0EEEPiSA_PNS3_ILi4EfLS4_0EEE_param_0+16]
  rd90 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (16))));
  // PTX:460 cvta.to.global.u64 %rd89, %rd90
  rd89 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd90));
  // PTX:461 ld.param.u64 %rd88, [_ZN7synreal15granular_kernel19accumulate_contactsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPNS2_3matILi3ELi3EfLS4_0EEEPiSA_PNS3_ILi4EfLS4_0EEE_param_3]
  rd88 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:462 cvta.to.global.u64 %rd87, %rd88
  rd87 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd88));
  // PTX:463 shl.b64 %rd79, %rd8, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd79) : "l"(rd8));
  // PTX:464 add.s64 %rd80, %rd87, %rd79
  asm("add.s64 %0, %1, %2;" : "=l"(rd80) : "l"(rd87), "l"(rd79));
  // PTX:465 st.global.u32 [%rd80], %r171
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (0))))) = (unsigned)(r171);
  // PTX:466 add.s64 %rd81, %rd89, %rd79
  asm("add.s64 %0, %1, %2;" : "=l"(rd81) : "l"(rd89), "l"(rd79));
  // PTX:467 ld.global.u32 %r141, [%rd81]
  r141 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (0)))));
  // PTX:468 mul.wide.s32 %rd82, %r141, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd82) : "r"(r141));
  // PTX:469 add.s64 %rd83, %rd91, %rd82
  asm("add.s64 %0, %1, %2;" : "=l"(rd83) : "l"(rd91), "l"(rd82));
  // PTX:470 ld.global.f32 %f202, [%rd83]
  f202 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (0)))));
  // PTX:471 add.f32 %f203, %f257, %f202
  asm("add.f32 %0, %1, %2;" : "=f"(f203) : "f"(f257), "f"(f202));
  // PTX:472 st.global.f32 [%rd83], %f203
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (0))))) = (float)(f203);
  // PTX:473 ld.global.f32 %f204, [%rd83+4]
  f204 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (4)))));
  // PTX:474 add.f32 %f205, %f258, %f204
  asm("add.f32 %0, %1, %2;" : "=f"(f205) : "f"(f258), "f"(f204));
  // PTX:475 st.global.f32 [%rd83+4], %f205
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (4))))) = (float)(f205);
  // PTX:476 ld.global.f32 %f206, [%rd83+8]
  f206 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (8)))));
  // PTX:477 add.f32 %f207, %f259, %f206
  asm("add.f32 %0, %1, %2;" : "=f"(f207) : "f"(f259), "f"(f206));
  // PTX:478 st.global.f32 [%rd83+8], %f207
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (8))))) = (float)(f207);
  // PTX:479 ld.global.u32 %r142, [%rd81]
  r142 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (0)))));
  // PTX:480 mul.wide.s32 %rd84, %r142, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd84) : "r"(r142));
  // PTX:481 add.s64 %rd85, %rd93, %rd84
  asm("add.s64 %0, %1, %2;" : "=l"(rd85) : "l"(rd93), "l"(rd84));
  // PTX:482 st.global.f32 [%rd85], %f239
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (0))))) = (float)(f239);
  // PTX:483 st.global.f32 [%rd85+4], %f241
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (4))))) = (float)(f241);
  // PTX:484 st.global.f32 [%rd85+8], %f243
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (8))))) = (float)(f243);
  // PTX:485 st.global.f32 [%rd85+12], %f245
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (12))))) = (float)(f245);
  // PTX:486 st.global.f32 [%rd85+16], %f247
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (16))))) = (float)(f247);
  // PTX:487 st.global.f32 [%rd85+20], %f249
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (20))))) = (float)(f249);
  // PTX:488 st.global.f32 [%rd85+24], %f251
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (24))))) = (float)(f251);
  // PTX:489 st.global.f32 [%rd85+28], %f253
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (28))))) = (float)(f253);
  // PTX:490 st.global.f32 [%rd85+32], %f255
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (32))))) = (float)(f255);
  // PTX:492 $L__BB1_40:
L_BB1_40:;
  // PTX:493 ret
  return;
}
