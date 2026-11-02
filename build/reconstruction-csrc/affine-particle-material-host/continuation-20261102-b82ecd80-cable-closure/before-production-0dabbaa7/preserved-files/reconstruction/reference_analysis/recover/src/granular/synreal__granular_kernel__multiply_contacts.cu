// 机械还原自 PTX：synreal::granular_kernel::multiply_contacts(synreal::granular_kernel::View, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*)
// PTX SHA256: 6fe43ad34602fb56507501b532ac9782e30e06e23d512cb9390eda796737e3c2
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__granular_kernel__multiply_contacts(ByVal<120, 8> param0, unsigned long long param1, unsigned long long param2) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32;
  unsigned short rs0, rs1, rs2, rs3, rs4, rs5, rs6, rs7, rs8, rs9, rs10, rs11, rs12, rs13, rs14, rs15, rs16, rs17, rs18;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121, r122, r123, r124, r125, r126, r127, r128, r129, r130, r131, r132, r133, r134, r135, r136, r137, r138, r139, r140, r141, r142, r143, r144, r145, r146, r147, r148, r149, r150, r151, r152, r153, r154, r155, r156, r157, r158, r159, r160, r161, r162, r163, r164, r165, r166, r167, r168, r169, r170, r171, r172, r173, r174, r175, r176, r177, r178, r179, r180, r181, r182, r183, r184, r185, r186, r187, r188, r189, r190, r191, r192, r193, r194, r195, r196;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128;
  // PTX:20 ld.param.v2.u32 {%r75, %r76}, [_ZN7synreal15granular_kernel17multiply_contactsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5__param_0+88]
  r75 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param0 + (88)))); r76 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param0 + (92))));
  // PTX:21 ld.param.v2.f32 {%f55, %f56}, [_ZN7synreal15granular_kernel17multiply_contactsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5__param_0+96]
  f55 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (96)))); f56 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (100))));
  // PTX:22 ld.param.v2.f32 {%f57, %f58}, [_ZN7synreal15granular_kernel17multiply_contactsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5__param_0+104]
  f57 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (104)))); f58 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (108))));
  // PTX:23 ld.param.u64 %rd46, [_ZN7synreal15granular_kernel17multiply_contactsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5__param_1]
  rd46 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:24 ld.param.f32 %f54, [_ZN7synreal15granular_kernel17multiply_contactsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5__param_0+112]
  f54 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (112))));
  // PTX:25 ld.param.u64 %rd44, [_ZN7synreal15granular_kernel17multiply_contactsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5__param_0+80]
  rd44 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (80))));
  // PTX:26 ld.param.u64 %rd43, [_ZN7synreal15granular_kernel17multiply_contactsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5__param_0+72]
  rd43 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (72))));
  // PTX:27 ld.param.u64 %rd42, [_ZN7synreal15granular_kernel17multiply_contactsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5__param_0+64]
  rd42 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (64))));
  // PTX:28 ld.param.u64 %rd41, [_ZN7synreal15granular_kernel17multiply_contactsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5__param_0+56]
  rd41 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (56))));
  // PTX:29 ld.param.u64 %rd40, [_ZN7synreal15granular_kernel17multiply_contactsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5__param_0+48]
  rd40 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (48))));
  // PTX:30 ld.param.u64 %rd39, [_ZN7synreal15granular_kernel17multiply_contactsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5__param_0+40]
  rd39 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (40))));
  // PTX:31 ld.param.u64 %rd38, [_ZN7synreal15granular_kernel17multiply_contactsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5__param_0+32]
  rd38 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (32))));
  // PTX:32 ld.param.u64 %rd37, [_ZN7synreal15granular_kernel17multiply_contactsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5__param_0+24]
  rd37 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (24))));
  // PTX:33 ld.param.u64 %rd36, [_ZN7synreal15granular_kernel17multiply_contactsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5__param_0+16]
  rd36 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (16))));
  // PTX:34 ld.param.u64 %rd35, [_ZN7synreal15granular_kernel17multiply_contactsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5__param_0+8]
  rd35 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (8))));
  // PTX:35 ld.param.u64 %rd34, [_ZN7synreal15granular_kernel17multiply_contactsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5__param_0]
  rd34 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:36 cvta.to.global.u64 %rd1, %rd46
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd46));
  // PTX:37 cvta.to.global.u64 %rd2, %rd34
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd34));
  // PTX:38 cvta.to.global.u64 %rd3, %rd35
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd35));
  // PTX:39 cvta.to.global.u64 %rd4, %rd36
  rd4 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd36));
  // PTX:40 cvta.to.global.u64 %rd5, %rd37
  rd5 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd37));
  // PTX:41 cvta.to.global.u64 %rd6, %rd38
  rd6 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd38));
  // PTX:42 cvta.to.global.u64 %rd7, %rd39
  rd7 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd39));
  // PTX:43 cvta.to.global.u64 %rd8, %rd40
  rd8 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd40));
  // PTX:44 cvta.to.global.u64 %rd9, %rd41
  rd9 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd41));
  // PTX:45 cvta.to.global.u64 %rd10, %rd43
  rd10 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd43));
  // PTX:46 cvta.to.global.u64 %rd11, %rd44
  rd11 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd44));
  // PTX:47 mov.u32 %r77, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r77) : "r"(blockDim.x));
  // PTX:48 mov.u32 %r78, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r78) : "r"(blockIdx.x));
  // PTX:49 mov.u32 %r79, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r79) : "r"(threadIdx.x));
  // PTX:50 mad.lo.s32 %r1, %r78, %r77, %r79
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r1) : "r"(r78), "r"(r77), "r"(r79));
  // PTX:51 setp.ge.s32 %p1, %r1, %r75
  p1 = (((int)(r1)) >= ((int)(r75)));
  // PTX:52 @%p1 bra $L__BB2_46
  if (p1) { goto L_BB2_46; }
  // PTX:54 cvta.to.global.u64 %rd47, %rd42
  rd47 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd42));
  // PTX:55 cvt.s64.s32 %rd12, %r1
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd12) : "r"(r1));
  // PTX:56 mul.wide.s32 %rd48, %r1, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd48) : "r"(r1));
  // PTX:57 add.s64 %rd49, %rd4, %rd48
  asm("add.s64 %0, %1, %2;" : "=l"(rd49) : "l"(rd4), "l"(rd48));
  // PTX:58 ld.global.u32 %r3, [%rd49]
  r3 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))));
  // PTX:59 add.s64 %rd50, %rd47, %rd48
  asm("add.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd47), "l"(rd48));
  // PTX:60 ld.global.u32 %r4, [%rd50]
  r4 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (0)))));
  // PTX:61 setp.lt.s32 %p2, %r4, 33
  p2 = (((int)(r4)) < ((int)(33)));
  // PTX:62 mul.wide.s32 %rd51, %r3, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd51) : "r"(r3));
  // PTX:63 add.s64 %rd13, %rd1, %rd51
  asm("add.s64 %0, %1, %2;" : "=l"(rd13) : "l"(rd1), "l"(rd51));
  // PTX:64 mov.f32 %f288, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f288) : );
  // PTX:65 mov.f32 %f289, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f289) : );
  // PTX:66 mov.f32 %f290, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f290) : );
  // PTX:67 @%p2 bra $L__BB2_38
  if (p2) { goto L_BB2_38; }
  // PTX:68 bra.uni $L__BB2_2
  goto L_BB2_2;
  // PTX:70 $L__BB2_38:
L_BB2_38:;
  // PTX:71 setp.lt.s32 %p28, %r4, 1
  p28 = (((int)(r4)) < ((int)(1)));
  // PTX:72 @%p28 bra $L__BB2_45
  if (p28) { goto L_BB2_45; }
  // PTX:74 cvt.s64.s32 %rd22, %r75
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd22) : "r"(r75));
  // PTX:75 ld.global.f32 %f26, [%rd13]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))));
  // PTX:76 ld.global.f32 %f27, [%rd13+4]
  f27 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4)))));
  // PTX:77 ld.global.f32 %f28, [%rd13+8]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8)))));
  // PTX:78 and.b32 %r196, %r4, 3
  asm("and.b32 %0, %1, 3;" : "=r"(r196) : "r"(r4));
  // PTX:79 add.s32 %r145, %r4, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r145) : "r"(r4));
  // PTX:80 setp.lt.u32 %p29, %r145, 3
  p29 = (((unsigned)(r145)) < ((unsigned)(3)));
  // PTX:81 mov.f32 %f290, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f290) : );
  // PTX:82 mov.u32 %r195, 0
  asm("mov.u32 %0, 0;" : "=r"(r195) : );
  // PTX:83 mov.f32 %f289, %f290
  asm("mov.f32 %0, %1;" : "=f"(f289) : "f"(f290));
  // PTX:84 mov.f32 %f288, %f290
  asm("mov.f32 %0, %1;" : "=f"(f288) : "f"(f290));
  // PTX:85 @%p29 bra $L__BB2_42
  if (p29) { goto L_BB2_42; }
  // PTX:87 sub.s32 %r194, %r4, %r196
  asm("sub.s32 %0, %1, %2;" : "=r"(r194) : "r"(r4), "r"(r196));
  // PTX:88 shl.b64 %rd88, %rd12, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd88) : "l"(rd12));
  // PTX:89 add.s64 %rd126, %rd10, %rd88
  asm("add.s64 %0, %1, %2;" : "=l"(rd126) : "l"(rd10), "l"(rd88));
  // PTX:90 shl.b64 %rd24, %rd22, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd24) : "l"(rd22));
  // PTX:91 shl.b64 %rd89, %rd12, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd89) : "l"(rd12));
  // PTX:92 add.s64 %rd127, %rd11, %rd89
  asm("add.s64 %0, %1, %2;" : "=l"(rd127) : "l"(rd11), "l"(rd89));
  // PTX:93 shl.b64 %rd26, %rd22, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd26) : "l"(rd22));
  // PTX:94 mov.f32 %f290, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f290) : );
  // PTX:95 mov.u32 %r195, 0
  asm("mov.u32 %0, 0;" : "=r"(r195) : );
  // PTX:97 $L__BB2_41:
L_BB2_41:;
  // PTX:98 ld.global.u32 %r147, [%rd126]
  r147 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd126) + (0)))));
  // PTX:99 mul.wide.s32 %rd90, %r147, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd90) : "r"(r147));
  // PTX:100 add.s64 %rd91, %rd4, %rd90
  asm("add.s64 %0, %1, %2;" : "=l"(rd91) : "l"(rd4), "l"(rd90));
  // PTX:101 ld.global.u32 %r148, [%rd91]
  r148 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (0)))));
  // PTX:102 mul.wide.s32 %rd92, %r148, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd92) : "r"(r148));
  // PTX:103 add.s64 %rd93, %rd1, %rd92
  asm("add.s64 %0, %1, %2;" : "=l"(rd93) : "l"(rd1), "l"(rd92));
  // PTX:104 ld.global.f32 %f147, [%rd93]
  f147 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (0)))));
  // PTX:105 sub.f32 %f148, %f26, %f147
  asm("sub.f32 %0, %1, %2;" : "=f"(f148) : "f"(f26), "f"(f147));
  // PTX:106 ld.global.f32 %f149, [%rd93+4]
  f149 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (4)))));
  // PTX:107 sub.f32 %f150, %f27, %f149
  asm("sub.f32 %0, %1, %2;" : "=f"(f150) : "f"(f27), "f"(f149));
  // PTX:108 ld.global.f32 %f151, [%rd93+8]
  f151 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (8)))));
  // PTX:109 sub.f32 %f152, %f28, %f151
  asm("sub.f32 %0, %1, %2;" : "=f"(f152) : "f"(f28), "f"(f151));
  // PTX:110 ld.global.f32 %f153, [%rd127+12]
  f153 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd127) + (12)))));
  // PTX:111 sub.f32 %f154, %f56, %f153
  asm("sub.f32 %0, %1, %2;" : "=f"(f154) : "f"(f56), "f"(f153));
  // PTX:112 ld.global.f32 %f155, [%rd127]
  f155 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd127) + (0)))));
  // PTX:113 ld.global.f32 %f156, [%rd127+4]
  f156 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd127) + (4)))));
  // PTX:114 mul.f32 %f157, %f156, %f150
  asm("mul.f32 %0, %1, %2;" : "=f"(f157) : "f"(f156), "f"(f150));
  // PTX:115 ld.global.f32 %f158, [%rd127+8]
  f158 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd127) + (8)))));
  // PTX:116 fma.rn.f32 %f159, %f155, %f148, %f157
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f159) : "f"(f155), "f"(f148), "f"(f157));
  // PTX:117 fma.rn.f32 %f160, %f158, %f152, %f159
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f160) : "f"(f158), "f"(f152), "f"(f159));
  // PTX:118 mul.f32 %f161, %f154, %f160
  asm("mul.f32 %0, %1, %2;" : "=f"(f161) : "f"(f154), "f"(f160));
  // PTX:119 mul.f32 %f162, %f155, %f161
  asm("mul.f32 %0, %1, %2;" : "=f"(f162) : "f"(f155), "f"(f161));
  // PTX:120 mul.f32 %f163, %f156, %f161
  asm("mul.f32 %0, %1, %2;" : "=f"(f163) : "f"(f156), "f"(f161));
  // PTX:121 mul.f32 %f164, %f158, %f161
  asm("mul.f32 %0, %1, %2;" : "=f"(f164) : "f"(f158), "f"(f161));
  // PTX:122 fma.rn.f32 %f165, %f153, %f148, %f162
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f165) : "f"(f153), "f"(f148), "f"(f162));
  // PTX:123 fma.rn.f32 %f166, %f153, %f150, %f163
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f166) : "f"(f153), "f"(f150), "f"(f163));
  // PTX:124 fma.rn.f32 %f167, %f153, %f152, %f164
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f167) : "f"(f153), "f"(f152), "f"(f164));
  // PTX:125 add.f32 %f168, %f288, %f165
  asm("add.f32 %0, %1, %2;" : "=f"(f168) : "f"(f288), "f"(f165));
  // PTX:126 add.f32 %f169, %f289, %f166
  asm("add.f32 %0, %1, %2;" : "=f"(f169) : "f"(f289), "f"(f166));
  // PTX:127 add.f32 %f170, %f290, %f167
  asm("add.f32 %0, %1, %2;" : "=f"(f170) : "f"(f290), "f"(f167));
  // PTX:128 add.s64 %rd94, %rd126, %rd24
  asm("add.s64 %0, %1, %2;" : "=l"(rd94) : "l"(rd126), "l"(rd24));
  // PTX:129 ld.global.u32 %r149, [%rd94]
  r149 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd94) + (0)))));
  // PTX:130 mul.wide.s32 %rd95, %r149, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd95) : "r"(r149));
  // PTX:131 add.s64 %rd96, %rd4, %rd95
  asm("add.s64 %0, %1, %2;" : "=l"(rd96) : "l"(rd4), "l"(rd95));
  // PTX:132 add.s64 %rd97, %rd127, %rd26
  asm("add.s64 %0, %1, %2;" : "=l"(rd97) : "l"(rd127), "l"(rd26));
  // PTX:133 ld.global.u32 %r150, [%rd96]
  r150 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (0)))));
  // PTX:134 mul.wide.s32 %rd98, %r150, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd98) : "r"(r150));
  // PTX:135 add.s64 %rd99, %rd1, %rd98
  asm("add.s64 %0, %1, %2;" : "=l"(rd99) : "l"(rd1), "l"(rd98));
  // PTX:136 ld.global.f32 %f171, [%rd99]
  f171 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (0)))));
  // PTX:137 sub.f32 %f172, %f26, %f171
  asm("sub.f32 %0, %1, %2;" : "=f"(f172) : "f"(f26), "f"(f171));
  // PTX:138 ld.global.f32 %f173, [%rd99+4]
  f173 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (4)))));
  // PTX:139 sub.f32 %f174, %f27, %f173
  asm("sub.f32 %0, %1, %2;" : "=f"(f174) : "f"(f27), "f"(f173));
  // PTX:140 ld.global.f32 %f175, [%rd99+8]
  f175 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (8)))));
  // PTX:141 sub.f32 %f176, %f28, %f175
  asm("sub.f32 %0, %1, %2;" : "=f"(f176) : "f"(f28), "f"(f175));
  // PTX:142 ld.global.f32 %f177, [%rd97+12]
  f177 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd97) + (12)))));
  // PTX:143 sub.f32 %f178, %f56, %f177
  asm("sub.f32 %0, %1, %2;" : "=f"(f178) : "f"(f56), "f"(f177));
  // PTX:144 ld.global.f32 %f179, [%rd97]
  f179 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd97) + (0)))));
  // PTX:145 ld.global.f32 %f180, [%rd97+4]
  f180 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd97) + (4)))));
  // PTX:146 mul.f32 %f181, %f180, %f174
  asm("mul.f32 %0, %1, %2;" : "=f"(f181) : "f"(f180), "f"(f174));
  // PTX:147 ld.global.f32 %f182, [%rd97+8]
  f182 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd97) + (8)))));
  // PTX:148 fma.rn.f32 %f183, %f179, %f172, %f181
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f183) : "f"(f179), "f"(f172), "f"(f181));
  // PTX:149 fma.rn.f32 %f184, %f182, %f176, %f183
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f184) : "f"(f182), "f"(f176), "f"(f183));
  // PTX:150 mul.f32 %f185, %f178, %f184
  asm("mul.f32 %0, %1, %2;" : "=f"(f185) : "f"(f178), "f"(f184));
  // PTX:151 mul.f32 %f186, %f179, %f185
  asm("mul.f32 %0, %1, %2;" : "=f"(f186) : "f"(f179), "f"(f185));
  // PTX:152 mul.f32 %f187, %f180, %f185
  asm("mul.f32 %0, %1, %2;" : "=f"(f187) : "f"(f180), "f"(f185));
  // PTX:153 mul.f32 %f188, %f182, %f185
  asm("mul.f32 %0, %1, %2;" : "=f"(f188) : "f"(f182), "f"(f185));
  // PTX:154 fma.rn.f32 %f189, %f177, %f172, %f186
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f189) : "f"(f177), "f"(f172), "f"(f186));
  // PTX:155 fma.rn.f32 %f190, %f177, %f174, %f187
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f190) : "f"(f177), "f"(f174), "f"(f187));
  // PTX:156 fma.rn.f32 %f191, %f177, %f176, %f188
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f191) : "f"(f177), "f"(f176), "f"(f188));
  // PTX:157 add.f32 %f192, %f168, %f189
  asm("add.f32 %0, %1, %2;" : "=f"(f192) : "f"(f168), "f"(f189));
  // PTX:158 add.f32 %f193, %f169, %f190
  asm("add.f32 %0, %1, %2;" : "=f"(f193) : "f"(f169), "f"(f190));
  // PTX:159 add.f32 %f194, %f170, %f191
  asm("add.f32 %0, %1, %2;" : "=f"(f194) : "f"(f170), "f"(f191));
  // PTX:160 add.s64 %rd100, %rd94, %rd24
  asm("add.s64 %0, %1, %2;" : "=l"(rd100) : "l"(rd94), "l"(rd24));
  // PTX:161 ld.global.u32 %r151, [%rd100]
  r151 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (0)))));
  // PTX:162 mul.wide.s32 %rd101, %r151, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd101) : "r"(r151));
  // PTX:163 add.s64 %rd102, %rd4, %rd101
  asm("add.s64 %0, %1, %2;" : "=l"(rd102) : "l"(rd4), "l"(rd101));
  // PTX:164 add.s64 %rd103, %rd97, %rd26
  asm("add.s64 %0, %1, %2;" : "=l"(rd103) : "l"(rd97), "l"(rd26));
  // PTX:165 ld.global.u32 %r152, [%rd102]
  r152 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd102) + (0)))));
  // PTX:166 mul.wide.s32 %rd104, %r152, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd104) : "r"(r152));
  // PTX:167 add.s64 %rd105, %rd1, %rd104
  asm("add.s64 %0, %1, %2;" : "=l"(rd105) : "l"(rd1), "l"(rd104));
  // PTX:168 ld.global.f32 %f195, [%rd105]
  f195 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (0)))));
  // PTX:169 sub.f32 %f196, %f26, %f195
  asm("sub.f32 %0, %1, %2;" : "=f"(f196) : "f"(f26), "f"(f195));
  // PTX:170 ld.global.f32 %f197, [%rd105+4]
  f197 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (4)))));
  // PTX:171 sub.f32 %f198, %f27, %f197
  asm("sub.f32 %0, %1, %2;" : "=f"(f198) : "f"(f27), "f"(f197));
  // PTX:172 ld.global.f32 %f199, [%rd105+8]
  f199 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (8)))));
  // PTX:173 sub.f32 %f200, %f28, %f199
  asm("sub.f32 %0, %1, %2;" : "=f"(f200) : "f"(f28), "f"(f199));
  // PTX:174 ld.global.f32 %f201, [%rd103+12]
  f201 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd103) + (12)))));
  // PTX:175 sub.f32 %f202, %f56, %f201
  asm("sub.f32 %0, %1, %2;" : "=f"(f202) : "f"(f56), "f"(f201));
  // PTX:176 ld.global.f32 %f203, [%rd103]
  f203 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd103) + (0)))));
  // PTX:177 ld.global.f32 %f204, [%rd103+4]
  f204 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd103) + (4)))));
  // PTX:178 mul.f32 %f205, %f204, %f198
  asm("mul.f32 %0, %1, %2;" : "=f"(f205) : "f"(f204), "f"(f198));
  // PTX:179 ld.global.f32 %f206, [%rd103+8]
  f206 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd103) + (8)))));
  // PTX:180 fma.rn.f32 %f207, %f203, %f196, %f205
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f207) : "f"(f203), "f"(f196), "f"(f205));
  // PTX:181 fma.rn.f32 %f208, %f206, %f200, %f207
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f208) : "f"(f206), "f"(f200), "f"(f207));
  // PTX:182 mul.f32 %f209, %f202, %f208
  asm("mul.f32 %0, %1, %2;" : "=f"(f209) : "f"(f202), "f"(f208));
  // PTX:183 mul.f32 %f210, %f203, %f209
  asm("mul.f32 %0, %1, %2;" : "=f"(f210) : "f"(f203), "f"(f209));
  // PTX:184 mul.f32 %f211, %f204, %f209
  asm("mul.f32 %0, %1, %2;" : "=f"(f211) : "f"(f204), "f"(f209));
  // PTX:185 mul.f32 %f212, %f206, %f209
  asm("mul.f32 %0, %1, %2;" : "=f"(f212) : "f"(f206), "f"(f209));
  // PTX:186 fma.rn.f32 %f213, %f201, %f196, %f210
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f213) : "f"(f201), "f"(f196), "f"(f210));
  // PTX:187 fma.rn.f32 %f214, %f201, %f198, %f211
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f214) : "f"(f201), "f"(f198), "f"(f211));
  // PTX:188 fma.rn.f32 %f215, %f201, %f200, %f212
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f215) : "f"(f201), "f"(f200), "f"(f212));
  // PTX:189 add.f32 %f216, %f192, %f213
  asm("add.f32 %0, %1, %2;" : "=f"(f216) : "f"(f192), "f"(f213));
  // PTX:190 add.f32 %f217, %f193, %f214
  asm("add.f32 %0, %1, %2;" : "=f"(f217) : "f"(f193), "f"(f214));
  // PTX:191 add.f32 %f218, %f194, %f215
  asm("add.f32 %0, %1, %2;" : "=f"(f218) : "f"(f194), "f"(f215));
  // PTX:192 add.s64 %rd106, %rd100, %rd24
  asm("add.s64 %0, %1, %2;" : "=l"(rd106) : "l"(rd100), "l"(rd24));
  // PTX:193 add.s64 %rd126, %rd106, %rd24
  asm("add.s64 %0, %1, %2;" : "=l"(rd126) : "l"(rd106), "l"(rd24));
  // PTX:194 ld.global.u32 %r153, [%rd106]
  r153 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (0)))));
  // PTX:195 mul.wide.s32 %rd107, %r153, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd107) : "r"(r153));
  // PTX:196 add.s64 %rd108, %rd4, %rd107
  asm("add.s64 %0, %1, %2;" : "=l"(rd108) : "l"(rd4), "l"(rd107));
  // PTX:197 add.s64 %rd109, %rd103, %rd26
  asm("add.s64 %0, %1, %2;" : "=l"(rd109) : "l"(rd103), "l"(rd26));
  // PTX:198 add.s64 %rd127, %rd109, %rd26
  asm("add.s64 %0, %1, %2;" : "=l"(rd127) : "l"(rd109), "l"(rd26));
  // PTX:199 ld.global.u32 %r154, [%rd108]
  r154 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd108) + (0)))));
  // PTX:200 mul.wide.s32 %rd110, %r154, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd110) : "r"(r154));
  // PTX:201 add.s64 %rd111, %rd1, %rd110
  asm("add.s64 %0, %1, %2;" : "=l"(rd111) : "l"(rd1), "l"(rd110));
  // PTX:202 ld.global.f32 %f219, [%rd111]
  f219 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd111) + (0)))));
  // PTX:203 sub.f32 %f220, %f26, %f219
  asm("sub.f32 %0, %1, %2;" : "=f"(f220) : "f"(f26), "f"(f219));
  // PTX:204 ld.global.f32 %f221, [%rd111+4]
  f221 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd111) + (4)))));
  // PTX:205 sub.f32 %f222, %f27, %f221
  asm("sub.f32 %0, %1, %2;" : "=f"(f222) : "f"(f27), "f"(f221));
  // PTX:206 ld.global.f32 %f223, [%rd111+8]
  f223 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd111) + (8)))));
  // PTX:207 sub.f32 %f224, %f28, %f223
  asm("sub.f32 %0, %1, %2;" : "=f"(f224) : "f"(f28), "f"(f223));
  // PTX:208 ld.global.f32 %f225, [%rd109+12]
  f225 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd109) + (12)))));
  // PTX:209 sub.f32 %f226, %f56, %f225
  asm("sub.f32 %0, %1, %2;" : "=f"(f226) : "f"(f56), "f"(f225));
  // PTX:210 ld.global.f32 %f227, [%rd109]
  f227 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd109) + (0)))));
  // PTX:211 ld.global.f32 %f228, [%rd109+4]
  f228 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd109) + (4)))));
  // PTX:212 mul.f32 %f229, %f228, %f222
  asm("mul.f32 %0, %1, %2;" : "=f"(f229) : "f"(f228), "f"(f222));
  // PTX:213 ld.global.f32 %f230, [%rd109+8]
  f230 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd109) + (8)))));
  // PTX:214 fma.rn.f32 %f231, %f227, %f220, %f229
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f231) : "f"(f227), "f"(f220), "f"(f229));
  // PTX:215 fma.rn.f32 %f232, %f230, %f224, %f231
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f232) : "f"(f230), "f"(f224), "f"(f231));
  // PTX:216 mul.f32 %f233, %f226, %f232
  asm("mul.f32 %0, %1, %2;" : "=f"(f233) : "f"(f226), "f"(f232));
  // PTX:217 mul.f32 %f234, %f227, %f233
  asm("mul.f32 %0, %1, %2;" : "=f"(f234) : "f"(f227), "f"(f233));
  // PTX:218 mul.f32 %f235, %f228, %f233
  asm("mul.f32 %0, %1, %2;" : "=f"(f235) : "f"(f228), "f"(f233));
  // PTX:219 mul.f32 %f236, %f230, %f233
  asm("mul.f32 %0, %1, %2;" : "=f"(f236) : "f"(f230), "f"(f233));
  // PTX:220 fma.rn.f32 %f237, %f225, %f220, %f234
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f237) : "f"(f225), "f"(f220), "f"(f234));
  // PTX:221 fma.rn.f32 %f238, %f225, %f222, %f235
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f238) : "f"(f225), "f"(f222), "f"(f235));
  // PTX:222 fma.rn.f32 %f239, %f225, %f224, %f236
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f239) : "f"(f225), "f"(f224), "f"(f236));
  // PTX:223 add.f32 %f288, %f216, %f237
  asm("add.f32 %0, %1, %2;" : "=f"(f288) : "f"(f216), "f"(f237));
  // PTX:224 add.f32 %f289, %f217, %f238
  asm("add.f32 %0, %1, %2;" : "=f"(f289) : "f"(f217), "f"(f238));
  // PTX:225 add.f32 %f290, %f218, %f239
  asm("add.f32 %0, %1, %2;" : "=f"(f290) : "f"(f218), "f"(f239));
  // PTX:226 add.s32 %r195, %r195, 4
  asm("add.s32 %0, %1, 4;" : "=r"(r195) : "r"(r195));
  // PTX:227 add.s32 %r194, %r194, -4
  asm("add.s32 %0, %1, -4;" : "=r"(r194) : "r"(r194));
  // PTX:228 setp.ne.s32 %p30, %r194, 0
  p30 = (((int)(r194)) != ((int)(0)));
  // PTX:229 @%p30 bra $L__BB2_41
  if (p30) { goto L_BB2_41; }
  // PTX:231 $L__BB2_42:
L_BB2_42:;
  // PTX:232 setp.eq.s32 %p31, %r196, 0
  p31 = (((int)(r196)) == ((int)(0)));
  // PTX:233 @%p31 bra $L__BB2_45
  if (p31) { goto L_BB2_45; }
  // PTX:235 cvt.s64.s32 %rd128, %r195
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd128) : "r"(r195));
  // PTX:237 $L__BB2_44:
L_BB2_44:;
  // PTX:239 mul.lo.s64 %rd112, %rd128, %rd22
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd112) : "l"(rd128), "l"(rd22));
  // PTX:240 add.s64 %rd113, %rd112, %rd12
  asm("add.s64 %0, %1, %2;" : "=l"(rd113) : "l"(rd112), "l"(rd12));
  // PTX:241 shl.b64 %rd114, %rd113, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd114) : "l"(rd113));
  // PTX:242 add.s64 %rd115, %rd10, %rd114
  asm("add.s64 %0, %1, %2;" : "=l"(rd115) : "l"(rd10), "l"(rd114));
  // PTX:243 ld.global.u32 %r155, [%rd115]
  r155 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd115) + (0)))));
  // PTX:244 mul.wide.s32 %rd116, %r155, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd116) : "r"(r155));
  // PTX:245 add.s64 %rd117, %rd4, %rd116
  asm("add.s64 %0, %1, %2;" : "=l"(rd117) : "l"(rd4), "l"(rd116));
  // PTX:246 shl.b64 %rd118, %rd113, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd118) : "l"(rd113));
  // PTX:247 add.s64 %rd119, %rd11, %rd118
  asm("add.s64 %0, %1, %2;" : "=l"(rd119) : "l"(rd11), "l"(rd118));
  // PTX:248 ld.global.u32 %r156, [%rd117]
  r156 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd117) + (0)))));
  // PTX:249 mul.wide.s32 %rd120, %r156, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd120) : "r"(r156));
  // PTX:250 add.s64 %rd121, %rd1, %rd120
  asm("add.s64 %0, %1, %2;" : "=l"(rd121) : "l"(rd1), "l"(rd120));
  // PTX:251 ld.global.f32 %f240, [%rd121]
  f240 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd121) + (0)))));
  // PTX:252 sub.f32 %f241, %f26, %f240
  asm("sub.f32 %0, %1, %2;" : "=f"(f241) : "f"(f26), "f"(f240));
  // PTX:253 ld.global.f32 %f242, [%rd121+4]
  f242 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd121) + (4)))));
  // PTX:254 sub.f32 %f243, %f27, %f242
  asm("sub.f32 %0, %1, %2;" : "=f"(f243) : "f"(f27), "f"(f242));
  // PTX:255 ld.global.f32 %f244, [%rd121+8]
  f244 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd121) + (8)))));
  // PTX:256 sub.f32 %f245, %f28, %f244
  asm("sub.f32 %0, %1, %2;" : "=f"(f245) : "f"(f28), "f"(f244));
  // PTX:257 ld.global.f32 %f246, [%rd119+12]
  f246 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd119) + (12)))));
  // PTX:258 sub.f32 %f247, %f56, %f246
  asm("sub.f32 %0, %1, %2;" : "=f"(f247) : "f"(f56), "f"(f246));
  // PTX:259 ld.global.f32 %f248, [%rd119]
  f248 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd119) + (0)))));
  // PTX:260 ld.global.f32 %f249, [%rd119+4]
  f249 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd119) + (4)))));
  // PTX:261 mul.f32 %f250, %f249, %f243
  asm("mul.f32 %0, %1, %2;" : "=f"(f250) : "f"(f249), "f"(f243));
  // PTX:262 ld.global.f32 %f251, [%rd119+8]
  f251 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd119) + (8)))));
  // PTX:263 fma.rn.f32 %f252, %f248, %f241, %f250
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f252) : "f"(f248), "f"(f241), "f"(f250));
  // PTX:264 fma.rn.f32 %f253, %f251, %f245, %f252
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f253) : "f"(f251), "f"(f245), "f"(f252));
  // PTX:265 mul.f32 %f254, %f247, %f253
  asm("mul.f32 %0, %1, %2;" : "=f"(f254) : "f"(f247), "f"(f253));
  // PTX:266 mul.f32 %f255, %f248, %f254
  asm("mul.f32 %0, %1, %2;" : "=f"(f255) : "f"(f248), "f"(f254));
  // PTX:267 mul.f32 %f256, %f249, %f254
  asm("mul.f32 %0, %1, %2;" : "=f"(f256) : "f"(f249), "f"(f254));
  // PTX:268 mul.f32 %f257, %f251, %f254
  asm("mul.f32 %0, %1, %2;" : "=f"(f257) : "f"(f251), "f"(f254));
  // PTX:269 fma.rn.f32 %f258, %f246, %f241, %f255
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f258) : "f"(f246), "f"(f241), "f"(f255));
  // PTX:270 fma.rn.f32 %f259, %f246, %f243, %f256
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f259) : "f"(f246), "f"(f243), "f"(f256));
  // PTX:271 fma.rn.f32 %f260, %f246, %f245, %f257
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f260) : "f"(f246), "f"(f245), "f"(f257));
  // PTX:272 add.f32 %f288, %f288, %f258
  asm("add.f32 %0, %1, %2;" : "=f"(f288) : "f"(f288), "f"(f258));
  // PTX:273 add.f32 %f289, %f289, %f259
  asm("add.f32 %0, %1, %2;" : "=f"(f289) : "f"(f289), "f"(f259));
  // PTX:274 add.f32 %f290, %f290, %f260
  asm("add.f32 %0, %1, %2;" : "=f"(f290) : "f"(f290), "f"(f260));
  // PTX:275 add.s64 %rd128, %rd128, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd128) : "l"(rd128));
  // PTX:276 add.s32 %r196, %r196, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r196) : "r"(r196));
  // PTX:277 setp.ne.s32 %p32, %r196, 0
  p32 = (((int)(r196)) != ((int)(0)));
  // PTX:278 @%p32 bra $L__BB2_44
  if (p32) { goto L_BB2_44; }
  // PTX:279 bra.uni $L__BB2_45
  goto L_BB2_45;
  // PTX:281 $L__BB2_2:
L_BB2_2:;
  // PTX:282 mul.lo.s64 %rd52, %rd12, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd52) : "l"(rd12));
  // PTX:283 add.s64 %rd53, %rd6, %rd52
  asm("add.s64 %0, %1, %2;" : "=l"(rd53) : "l"(rd6), "l"(rd52));
  // PTX:284 shl.b64 %rd54, %rd12, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd54) : "l"(rd12));
  // PTX:285 add.s64 %rd55, %rd5, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd55) : "l"(rd5), "l"(rd54));
  // PTX:286 ld.global.u32 %r5, [%rd55]
  r5 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))));
  // PTX:287 ld.global.u32 %r83, [%rd53]
  r83 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))));
  // PTX:288 add.s32 %r6, %r83, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r6) : "r"(r83));
  // PTX:289 mov.u32 %r191, -1
  asm("mov.u32 %0, -1;" : "=r"(r191) : );
  // PTX:290 ld.global.u32 %r84, [%rd53+4]
  r84 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (4)))));
  // PTX:291 add.s32 %r7, %r84, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r7) : "r"(r84));
  // PTX:292 ld.global.u32 %r85, [%rd53+8]
  r85 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (8)))));
  // PTX:293 add.s32 %r8, %r85, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r8) : "r"(r85));
  // PTX:294 add.s32 %r9, %r76, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r9) : "r"(r76));
  // PTX:295 mov.u32 %r188, 0
  asm("mov.u32 %0, 0;" : "=r"(r188) : );
  // PTX:296 bra.uni $L__BB2_3
  goto L_BB2_3;
  // PTX:298 $L__BB2_12:
L_BB2_12:;
  // PTX:299 mul.wide.u32 %rd61, %r188, -1431655765
  asm("mul.wide.u32 %0, %1, -1431655765;" : "=l"(rd61) : "r"(r188));
  // PTX:300 shr.u64 %rd62, %rd61, 33
  asm("shr.u64 %0, %1, 33;" : "=l"(rd62) : "l"(rd61));
  // PTX:301 cvt.u32.u64 %r91, %rd62
  asm("cvt.u32.u64 %0, %1;" : "=r"(r91) : "l"(rd62));
  // PTX:302 mul.lo.s32 %r92, %r91, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r92) : "r"(r91));
  // PTX:303 sub.s32 %r93, %r188, %r92
  asm("sub.s32 %0, %1, %2;" : "=r"(r93) : "r"(r188), "r"(r92));
  // PTX:304 mul.wide.u32 %rd63, %r91, -1431655765
  asm("mul.wide.u32 %0, %1, -1431655765;" : "=l"(rd63) : "r"(r91));
  // PTX:305 shr.u64 %rd64, %rd63, 33
  asm("shr.u64 %0, %1, 33;" : "=l"(rd64) : "l"(rd63));
  // PTX:306 cvt.u32.u64 %r94, %rd64
  asm("cvt.u32.u64 %0, %1;" : "=r"(r94) : "l"(rd64));
  // PTX:307 mul.lo.s32 %r95, %r94, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r95) : "r"(r94));
  // PTX:308 sub.s32 %r96, %r91, %r95
  asm("sub.s32 %0, %1, %2;" : "=r"(r96) : "r"(r91), "r"(r95));
  // PTX:309 add.s32 %r184, %r6, %r93
  asm("add.s32 %0, %1, %2;" : "=r"(r184) : "r"(r6), "r"(r93));
  // PTX:310 add.s32 %r185, %r7, %r96
  asm("add.s32 %0, %1, %2;" : "=r"(r185) : "r"(r7), "r"(r96));
  // PTX:311 mul.wide.u32 %rd65, %r188, 954437177
  asm("mul.wide.u32 %0, %1, 954437177;" : "=l"(rd65) : "r"(r188));
  // PTX:312 shr.u64 %rd66, %rd65, 33
  asm("shr.u64 %0, %1, 33;" : "=l"(rd66) : "l"(rd65));
  // PTX:313 cvt.u32.u64 %r97, %rd66
  asm("cvt.u32.u64 %0, %1;" : "=r"(r97) : "l"(rd66));
  // PTX:314 add.s32 %r186, %r8, %r97
  asm("add.s32 %0, %1, %2;" : "=r"(r186) : "r"(r8), "r"(r97));
  // PTX:315 add.s32 %r188, %r188, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r188) : "r"(r188));
  // PTX:316 mul.lo.s32 %r98, %r184, 73856093
  asm("mul.lo.s32 %0, %1, 73856093;" : "=r"(r98) : "r"(r184));
  // PTX:317 mul.lo.s32 %r99, %r185, 19349663
  asm("mul.lo.s32 %0, %1, 19349663;" : "=r"(r99) : "r"(r185));
  // PTX:318 mul.lo.s32 %r100, %r186, 83492791
  asm("mul.lo.s32 %0, %1, 83492791;" : "=r"(r100) : "r"(r186));
  // PTX:319 xor.b32 %r101, %r100, %r98
  asm("xor.b32 %0, %1, %2;" : "=r"(r101) : "r"(r100), "r"(r98));
  // PTX:320 xor.b32 %r102, %r101, %r99
  asm("xor.b32 %0, %1, %2;" : "=r"(r102) : "r"(r101), "r"(r99));
  // PTX:321 and.b32 %r103, %r102, %r9
  asm("and.b32 %0, %1, %2;" : "=r"(r103) : "r"(r102), "r"(r9));
  // PTX:322 mul.wide.s32 %rd67, %r103, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd67) : "r"(r103));
  // PTX:323 add.s64 %rd68, %rd2, %rd67
  asm("add.s64 %0, %1, %2;" : "=l"(rd68) : "l"(rd2), "l"(rd67));
  // PTX:324 ld.global.u32 %r191, [%rd68]
  r191 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (0)))));
  // PTX:326 $L__BB2_3:
L_BB2_3:;
  // PTX:327 setp.lt.s32 %p3, %r191, 0
  p3 = (((int)(r191)) < ((int)(0)));
  // PTX:328 @%p3 bra $L__BB2_11
  if (p3) { goto L_BB2_11; }
  // PTX:330 mov.u32 %r192, %r191
  asm("mov.u32 %0, %1;" : "=r"(r192) : "r"(r191));
  // PTX:332 $L__BB2_5:
L_BB2_5:;
  // PTX:333 cvt.s64.s32 %rd14, %r192
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd14) : "r"(r192));
  // PTX:334 mul.wide.s32 %rd56, %r192, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd56) : "r"(r192));
  // PTX:335 add.s64 %rd57, %rd3, %rd56
  asm("add.s64 %0, %1, %2;" : "=l"(rd57) : "l"(rd3), "l"(rd56));
  // PTX:336 ld.global.u32 %r191, [%rd57]
  r191 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))));
  // PTX:337 mul.wide.s32 %rd58, %r192, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd58) : "r"(r192));
  // PTX:338 add.s64 %rd15, %rd6, %rd58
  asm("add.s64 %0, %1, %2;" : "=l"(rd15) : "l"(rd6), "l"(rd58));
  // PTX:339 ld.global.u32 %r86, [%rd15]
  r86 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))));
  // PTX:340 setp.ne.s32 %p4, %r86, %r184
  p4 = (((int)(r86)) != ((int)(r184)));
  // PTX:341 mov.u16 %rs17, 0
  asm("mov.u16 %0, 0;" : "=h"(rs17) : );
  // PTX:342 @%p4 bra $L__BB2_8
  if (p4) { goto L_BB2_8; }
  // PTX:344 ld.global.u32 %r87, [%rd15+4]
  r87 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (4)))));
  // PTX:345 setp.ne.s32 %p5, %r87, %r185
  p5 = (((int)(r87)) != ((int)(r185)));
  // PTX:346 @%p5 bra $L__BB2_8
  if (p5) { goto L_BB2_8; }
  // PTX:348 ld.global.u32 %r88, [%rd15+8]
  r88 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (8)))));
  // PTX:349 setp.eq.s32 %p6, %r88, %r186
  p6 = (((int)(r88)) == ((int)(r186)));
  // PTX:350 selp.u16 %rs17, 1, 0, %p6
  rs17 = p6 ? 1 : 0;
  // PTX:352 $L__BB2_8:
L_BB2_8:;
  // PTX:353 setp.eq.s16 %p7, %rs17, 0
  p7 = (((short)(rs17)) == ((short)(0)));
  // PTX:354 @%p7 bra $L__BB2_10
  if (p7) { goto L_BB2_10; }
  // PTX:356 shl.b64 %rd59, %rd14, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd59) : "l"(rd14));
  // PTX:357 add.s64 %rd60, %rd5, %rd59
  asm("add.s64 %0, %1, %2;" : "=l"(rd60) : "l"(rd5), "l"(rd59));
  // PTX:358 ld.global.u32 %r89, [%rd60]
  r89 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))));
  // PTX:359 setp.eq.s32 %p8, %r89, %r5
  p8 = (((int)(r89)) == ((int)(r5)));
  // PTX:360 @%p8 bra $L__BB2_13
  if (p8) { goto L_BB2_13; }
  // PTX:362 $L__BB2_10:
L_BB2_10:;
  // PTX:363 setp.gt.s32 %p9, %r191, -1
  p9 = (((int)(r191)) > ((int)(-1)));
  // PTX:364 mov.u32 %r192, %r191
  asm("mov.u32 %0, %1;" : "=r"(r192) : "r"(r191));
  // PTX:365 @%p9 bra $L__BB2_5
  if (p9) { goto L_BB2_5; }
  // PTX:367 $L__BB2_11:
L_BB2_11:;
  // PTX:368 setp.eq.s32 %p10, %r188, 27
  p10 = (((int)(r188)) == ((int)(27)));
  // PTX:369 mov.u32 %r192, -1
  asm("mov.u32 %0, -1;" : "=r"(r192) : );
  // PTX:370 @%p10 bra $L__BB2_13
  if (p10) { goto L_BB2_13; }
  // PTX:371 bra.uni $L__BB2_12
  goto L_BB2_12;
  // PTX:373 $L__BB2_13:
L_BB2_13:;
  // PTX:374 setp.lt.s32 %p11, %r192, 0
  p11 = (((int)(r192)) < ((int)(0)));
  // PTX:375 @%p11 bra $L__BB2_45
  if (p11) { goto L_BB2_45; }
  // PTX:377 add.s64 %rd16, %rd7, %rd52
  asm("add.s64 %0, %1, %2;" : "=l"(rd16) : "l"(rd7), "l"(rd52));
  // PTX:378 add.s64 %rd17, %rd9, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd17) : "l"(rd9), "l"(rd54));
  // PTX:379 add.s64 %rd18, %rd8, %rd52
  asm("add.s64 %0, %1, %2;" : "=l"(rd18) : "l"(rd8), "l"(rd52));
  // PTX:380 div.rn.f32 %f5, %f58, %f54
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f5) : "f"(f58), "f"(f54));
  // PTX:381 mov.f32 %f290, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f290) : );
  // PTX:382 mov.f32 %f289, %f290
  asm("mov.f32 %0, %1;" : "=f"(f289) : "f"(f290));
  // PTX:383 mov.f32 %f288, %f290
  asm("mov.f32 %0, %1;" : "=f"(f288) : "f"(f290));
  // PTX:385 $L__BB2_15:
L_BB2_15:;
  // PTX:386 setp.eq.s32 %p12, %r1, %r192
  p12 = (((int)(r1)) == ((int)(r192)));
  // PTX:387 @%p12 bra $L__BB2_27
  if (p12) { goto L_BB2_27; }
  // PTX:389 cvt.s64.s32 %rd19, %r192
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd19) : "r"(r192));
  // PTX:390 mul.wide.s32 %rd71, %r192, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd71) : "r"(r192));
  // PTX:391 add.s64 %rd72, %rd7, %rd71
  asm("add.s64 %0, %1, %2;" : "=l"(rd72) : "l"(rd7), "l"(rd71));
  // PTX:392 ld.global.f32 %f65, [%rd72]
  f65 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (0)))));
  // PTX:393 ld.global.f32 %f66, [%rd16]
  f66 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:394 sub.f32 %f9, %f66, %f65
  asm("sub.f32 %0, %1, %2;" : "=f"(f9) : "f"(f66), "f"(f65));
  // PTX:395 ld.global.f32 %f67, [%rd72+4]
  f67 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (4)))));
  // PTX:396 ld.global.f32 %f68, [%rd16+4]
  f68 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (4)))));
  // PTX:397 sub.f32 %f10, %f68, %f67
  asm("sub.f32 %0, %1, %2;" : "=f"(f10) : "f"(f68), "f"(f67));
  // PTX:398 ld.global.f32 %f69, [%rd72+8]
  f69 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (8)))));
  // PTX:399 ld.global.f32 %f70, [%rd16+8]
  f70 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (8)))));
  // PTX:400 sub.f32 %f11, %f70, %f69
  asm("sub.f32 %0, %1, %2;" : "=f"(f11) : "f"(f70), "f"(f69));
  // PTX:401 mul.wide.s32 %rd73, %r192, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd73) : "r"(r192));
  // PTX:402 add.s64 %rd74, %rd9, %rd73
  asm("add.s64 %0, %1, %2;" : "=l"(rd74) : "l"(rd9), "l"(rd73));
  // PTX:403 ld.global.f32 %f71, [%rd74]
  f71 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (0)))));
  // PTX:404 ld.global.f32 %f72, [%rd17]
  f72 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:405 add.f32 %f12, %f72, %f71
  asm("add.f32 %0, %1, %2;" : "=f"(f12) : "f"(f72), "f"(f71));
  // PTX:406 mul.f32 %f73, %f10, %f10
  asm("mul.f32 %0, %1, %2;" : "=f"(f73) : "f"(f10), "f"(f10));
  // PTX:407 fma.rn.f32 %f74, %f9, %f9, %f73
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f74) : "f"(f9), "f"(f9), "f"(f73));
  // PTX:408 fma.rn.f32 %f13, %f11, %f11, %f74
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f13) : "f"(f11), "f"(f11), "f"(f74));
  // PTX:409 mul.f32 %f75, %f12, %f12
  asm("mul.f32 %0, %1, %2;" : "=f"(f75) : "f"(f12), "f"(f12));
  // PTX:410 setp.ge.f32 %p13, %f13, %f75
  p13 = (!(isnan(((float)(f13))) || isnan(((float)(f75)))) && (((float)(f13)) >= ((float)(f75))));
  // PTX:411 @%p13 bra $L__BB2_27
  if (p13) { goto L_BB2_27; }
  // PTX:413 mul.lo.s64 %rd75, %rd19, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd75) : "l"(rd19));
  // PTX:414 add.s64 %rd76, %rd8, %rd75
  asm("add.s64 %0, %1, %2;" : "=l"(rd76) : "l"(rd8), "l"(rd75));
  // PTX:415 ld.global.f32 %f76, [%rd76]
  f76 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (0)))));
  // PTX:416 ld.global.f32 %f77, [%rd18]
  f77 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (0)))));
  // PTX:417 sub.f32 %f14, %f77, %f76
  asm("sub.f32 %0, %1, %2;" : "=f"(f14) : "f"(f77), "f"(f76));
  // PTX:418 ld.global.f32 %f78, [%rd76+4]
  f78 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (4)))));
  // PTX:419 ld.global.f32 %f79, [%rd18+4]
  f79 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (4)))));
  // PTX:420 sub.f32 %f15, %f79, %f78
  asm("sub.f32 %0, %1, %2;" : "=f"(f15) : "f"(f79), "f"(f78));
  // PTX:421 ld.global.f32 %f80, [%rd76+8]
  f80 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (8)))));
  // PTX:422 ld.global.f32 %f81, [%rd18+8]
  f81 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (8)))));
  // PTX:423 sub.f32 %f16, %f81, %f80
  asm("sub.f32 %0, %1, %2;" : "=f"(f16) : "f"(f81), "f"(f80));
  // PTX:424 sqrt.rn.f32 %f17, %f13
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f17) : "f"(f13));
  // PTX:425 setp.gt.f32 %p14, %f17, 0f322BCC77
  p14 = (!(isnan(((float)(f17))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f17)) > ((float)(as_f32(0x322BCC77u)))));
  // PTX:426 @%p14 bra $L__BB2_25
  if (p14) { goto L_BB2_25; }
  // PTX:427 bra.uni $L__BB2_18
  goto L_BB2_18;
  // PTX:429 $L__BB2_25:
L_BB2_25:;
  // PTX:430 div.rn.f32 %f88, %f9, %f17
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f88) : "f"(f9), "f"(f17));
  // PTX:431 div.rn.f32 %f89, %f10, %f17
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f89) : "f"(f10), "f"(f17));
  // PTX:432 div.rn.f32 %f90, %f11, %f17
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f90) : "f"(f11), "f"(f17));
  // PTX:433 mov.b32 %r183, %f90
  asm("mov.b32 %0, %1;" : "=r"(r183) : "f"(f90));
  // PTX:434 mov.b32 %r182, %f89
  asm("mov.b32 %0, %1;" : "=r"(r182) : "f"(f89));
  // PTX:435 mov.b32 %r181, %f88
  asm("mov.b32 %0, %1;" : "=r"(r181) : "f"(f88));
  // PTX:436 bra.uni $L__BB2_26
  goto L_BB2_26;
  // PTX:438 $L__BB2_18:
L_BB2_18:;
  // PTX:439 mul.f32 %f82, %f15, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f82) : "f"(f15), "f"(f15));
  // PTX:440 fma.rn.f32 %f83, %f14, %f14, %f82
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f83) : "f"(f14), "f"(f14), "f"(f82));
  // PTX:441 fma.rn.f32 %f18, %f16, %f16, %f83
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f18) : "f"(f16), "f"(f16), "f"(f83));
  // PTX:442 setp.gt.f32 %p15, %f18, 0f24E69595
  p15 = (!(isnan(((float)(f18))) || isnan(((float)(as_f32(0x24E69595u))))) && (((float)(f18)) > ((float)(as_f32(0x24E69595u)))));
  // PTX:443 @%p15 bra $L__BB2_24
  if (p15) { goto L_BB2_24; }
  // PTX:444 bra.uni $L__BB2_19
  goto L_BB2_19;
  // PTX:446 $L__BB2_24:
L_BB2_24:;
  // PTX:447 rsqrt.approx.f32 %f84, %f18
  asm("rsqrt.approx.f32 %0, %1;" : "=f"(f84) : "f"(f18));
  // PTX:448 mul.f32 %f85, %f14, %f84
  asm("mul.f32 %0, %1, %2;" : "=f"(f85) : "f"(f14), "f"(f84));
  // PTX:449 mul.f32 %f86, %f15, %f84
  asm("mul.f32 %0, %1, %2;" : "=f"(f86) : "f"(f15), "f"(f84));
  // PTX:450 mul.f32 %f87, %f16, %f84
  asm("mul.f32 %0, %1, %2;" : "=f"(f87) : "f"(f16), "f"(f84));
  // PTX:451 mov.b32 %r183, %f87
  asm("mov.b32 %0, %1;" : "=r"(r183) : "f"(f87));
  // PTX:452 mov.b32 %r182, %f86
  asm("mov.b32 %0, %1;" : "=r"(r182) : "f"(f86));
  // PTX:453 mov.b32 %r181, %f85
  asm("mov.b32 %0, %1;" : "=r"(r181) : "f"(f85));
  // PTX:454 bra.uni $L__BB2_26
  goto L_BB2_26;
  // PTX:456 $L__BB2_19:
L_BB2_19:;
  // PTX:457 setp.lt.s32 %p16, %r1, %r192
  p16 = (((int)(r1)) < ((int)(r192)));
  // PTX:458 selp.f32 %f19, 0f3F800000, 0fBF800000, %p16
  f19 = p16 ? as_f32(0x3F800000u) : as_f32(0xBF800000u);
  // PTX:459 min.s32 %r105, %r1, %r192
  asm("min.s32 %0, %1, %2;" : "=r"(r105) : "r"(r1), "r"(r192));
  // PTX:460 max.s32 %r106, %r1, %r192
  asm("max.s32 %0, %1, %2;" : "=r"(r106) : "r"(r1), "r"(r192));
  // PTX:461 add.s32 %r107, %r105, %r106
  asm("add.s32 %0, %1, %2;" : "=r"(r107) : "r"(r105), "r"(r106));
  // PTX:462 mul.hi.s32 %r108, %r107, 1431655766
  asm("mul.hi.s32 %0, %1, 1431655766;" : "=r"(r108) : "r"(r107));
  // PTX:463 shr.u32 %r109, %r108, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r109) : "r"(r108));
  // PTX:464 add.s32 %r110, %r108, %r109
  asm("add.s32 %0, %1, %2;" : "=r"(r110) : "r"(r108), "r"(r109));
  // PTX:465 mul.lo.s32 %r111, %r110, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r111) : "r"(r110));
  // PTX:466 sub.s32 %r104, %r107, %r111
  asm("sub.s32 %0, %1, %2;" : "=r"(r104) : "r"(r107), "r"(r111));
  // PTX:467 setp.eq.s32 %p17, %r104, 2
  p17 = (((int)(r104)) == ((int)(2)));
  // PTX:468 @%p17 bra $L__BB2_22
  if (p17) { goto L_BB2_22; }
  // PTX:470 setp.ne.s32 %p18, %r104, 1
  p18 = (((int)(r104)) != ((int)(1)));
  // PTX:471 @%p18 bra $L__BB2_23
  if (p18) { goto L_BB2_23; }
  // PTX:473 mov.b32 %r182, %f19
  asm("mov.b32 %0, %1;" : "=r"(r182) : "f"(f19));
  // PTX:474 mov.u32 %r181, 0
  asm("mov.u32 %0, 0;" : "=r"(r181) : );
  // PTX:475 mov.u32 %r183, %r181
  asm("mov.u32 %0, %1;" : "=r"(r183) : "r"(r181));
  // PTX:476 bra.uni $L__BB2_26
  goto L_BB2_26;
  // PTX:478 $L__BB2_22:
L_BB2_22:;
  // PTX:479 mov.b32 %r183, %f19
  asm("mov.b32 %0, %1;" : "=r"(r183) : "f"(f19));
  // PTX:480 mov.u32 %r181, 0
  asm("mov.u32 %0, 0;" : "=r"(r181) : );
  // PTX:481 mov.u32 %r182, %r181
  asm("mov.u32 %0, %1;" : "=r"(r182) : "r"(r181));
  // PTX:482 bra.uni $L__BB2_26
  goto L_BB2_26;
  // PTX:484 $L__BB2_23:
L_BB2_23:;
  // PTX:485 mov.b32 %r181, %f19
  asm("mov.b32 %0, %1;" : "=r"(r181) : "f"(f19));
  // PTX:486 mov.u32 %r182, 0
  asm("mov.u32 %0, 0;" : "=r"(r182) : );
  // PTX:487 mov.u32 %r183, %r182
  asm("mov.u32 %0, %1;" : "=r"(r183) : "r"(r182));
  // PTX:489 $L__BB2_26:
L_BB2_26:;
  // PTX:490 mov.b32 %f91, %r181
  asm("mov.b32 %0, %1;" : "=f"(f91) : "r"(r181));
  // PTX:491 sub.f32 %f92, %f9, %f14
  asm("sub.f32 %0, %1, %2;" : "=f"(f92) : "f"(f9), "f"(f14));
  // PTX:492 mov.b32 %f93, %r182
  asm("mov.b32 %0, %1;" : "=f"(f93) : "r"(r182));
  // PTX:493 sub.f32 %f94, %f10, %f15
  asm("sub.f32 %0, %1, %2;" : "=f"(f94) : "f"(f10), "f"(f15));
  // PTX:494 mul.f32 %f95, %f94, %f93
  asm("mul.f32 %0, %1, %2;" : "=f"(f95) : "f"(f94), "f"(f93));
  // PTX:495 mov.b32 %f96, %r183
  asm("mov.b32 %0, %1;" : "=f"(f96) : "r"(r183));
  // PTX:496 sub.f32 %f97, %f11, %f16
  asm("sub.f32 %0, %1, %2;" : "=f"(f97) : "f"(f11), "f"(f16));
  // PTX:497 fma.rn.f32 %f98, %f92, %f91, %f95
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f98) : "f"(f92), "f"(f91), "f"(f95));
  // PTX:498 fma.rn.f32 %f99, %f97, %f96, %f98
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f99) : "f"(f97), "f"(f96), "f"(f98));
  // PTX:499 mul.f32 %f100, %f99, %f91
  asm("mul.f32 %0, %1, %2;" : "=f"(f100) : "f"(f99), "f"(f91));
  // PTX:500 mul.f32 %f101, %f99, %f93
  asm("mul.f32 %0, %1, %2;" : "=f"(f101) : "f"(f99), "f"(f93));
  // PTX:501 mul.f32 %f102, %f99, %f96
  asm("mul.f32 %0, %1, %2;" : "=f"(f102) : "f"(f99), "f"(f96));
  // PTX:502 sub.f32 %f103, %f92, %f100
  asm("sub.f32 %0, %1, %2;" : "=f"(f103) : "f"(f92), "f"(f100));
  // PTX:503 sub.f32 %f104, %f94, %f101
  asm("sub.f32 %0, %1, %2;" : "=f"(f104) : "f"(f94), "f"(f101));
  // PTX:504 sub.f32 %f105, %f97, %f102
  asm("sub.f32 %0, %1, %2;" : "=f"(f105) : "f"(f97), "f"(f102));
  // PTX:505 sub.f32 %f106, %f12, %f17
  asm("sub.f32 %0, %1, %2;" : "=f"(f106) : "f"(f12), "f"(f17));
  // PTX:506 mul.f32 %f107, %f56, %f106
  asm("mul.f32 %0, %1, %2;" : "=f"(f107) : "f"(f56), "f"(f106));
  // PTX:507 mul.f32 %f108, %f57, %f107
  asm("mul.f32 %0, %1, %2;" : "=f"(f108) : "f"(f57), "f"(f107));
  // PTX:508 mul.f32 %f109, %f104, %f104
  asm("mul.f32 %0, %1, %2;" : "=f"(f109) : "f"(f104), "f"(f104));
  // PTX:509 fma.rn.f32 %f110, %f103, %f103, %f109
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f110) : "f"(f103), "f"(f103), "f"(f109));
  // PTX:510 fma.rn.f32 %f111, %f105, %f105, %f110
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f111) : "f"(f105), "f"(f105), "f"(f110));
  // PTX:511 sqrt.rn.f32 %f112, %f111
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f112) : "f"(f111));
  // PTX:512 mov.f32 %f113, 0f322BCC77
  asm("mov.f32 %0, 0f322BCC77;" : "=f"(f113) : );
  // PTX:513 max.f32 %f114, %f112, %f113
  asm("max.f32 %0, %1, %2;" : "=f"(f114) : "f"(f112), "f"(f113));
  // PTX:514 div.rn.f32 %f115, %f108, %f114
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f115) : "f"(f108), "f"(f114));
  // PTX:515 min.f32 %f116, %f5, %f115
  asm("min.f32 %0, %1, %2;" : "=f"(f116) : "f"(f5), "f"(f115));
  // PTX:516 shl.b64 %rd77, %rd19, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd77) : "l"(rd19));
  // PTX:517 add.s64 %rd78, %rd4, %rd77
  asm("add.s64 %0, %1, %2;" : "=l"(rd78) : "l"(rd4), "l"(rd77));
  // PTX:518 ld.global.u32 %r118, [%rd78]
  r118 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd78) + (0)))));
  // PTX:519 mul.wide.s32 %rd79, %r118, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd79) : "r"(r118));
  // PTX:520 add.s64 %rd80, %rd1, %rd79
  asm("add.s64 %0, %1, %2;" : "=l"(rd80) : "l"(rd1), "l"(rd79));
  // PTX:521 ld.global.f32 %f117, [%rd80]
  f117 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (0)))));
  // PTX:522 ld.global.f32 %f118, [%rd13]
  f118 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))));
  // PTX:523 sub.f32 %f119, %f118, %f117
  asm("sub.f32 %0, %1, %2;" : "=f"(f119) : "f"(f118), "f"(f117));
  // PTX:524 ld.global.f32 %f120, [%rd80+4]
  f120 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (4)))));
  // PTX:525 ld.global.f32 %f121, [%rd13+4]
  f121 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4)))));
  // PTX:526 sub.f32 %f122, %f121, %f120
  asm("sub.f32 %0, %1, %2;" : "=f"(f122) : "f"(f121), "f"(f120));
  // PTX:527 ld.global.f32 %f123, [%rd80+8]
  f123 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (8)))));
  // PTX:528 ld.global.f32 %f124, [%rd13+8]
  f124 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8)))));
  // PTX:529 sub.f32 %f125, %f124, %f123
  asm("sub.f32 %0, %1, %2;" : "=f"(f125) : "f"(f124), "f"(f123));
  // PTX:530 sub.f32 %f126, %f56, %f116
  asm("sub.f32 %0, %1, %2;" : "=f"(f126) : "f"(f56), "f"(f116));
  // PTX:531 mul.f32 %f127, %f122, %f93
  asm("mul.f32 %0, %1, %2;" : "=f"(f127) : "f"(f122), "f"(f93));
  // PTX:532 fma.rn.f32 %f128, %f119, %f91, %f127
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f128) : "f"(f119), "f"(f91), "f"(f127));
  // PTX:533 fma.rn.f32 %f129, %f125, %f96, %f128
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f129) : "f"(f125), "f"(f96), "f"(f128));
  // PTX:534 mul.f32 %f130, %f126, %f129
  asm("mul.f32 %0, %1, %2;" : "=f"(f130) : "f"(f126), "f"(f129));
  // PTX:535 mul.f32 %f131, %f130, %f91
  asm("mul.f32 %0, %1, %2;" : "=f"(f131) : "f"(f130), "f"(f91));
  // PTX:536 mul.f32 %f132, %f130, %f93
  asm("mul.f32 %0, %1, %2;" : "=f"(f132) : "f"(f130), "f"(f93));
  // PTX:537 mul.f32 %f133, %f130, %f96
  asm("mul.f32 %0, %1, %2;" : "=f"(f133) : "f"(f130), "f"(f96));
  // PTX:538 fma.rn.f32 %f134, %f116, %f119, %f131
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f134) : "f"(f116), "f"(f119), "f"(f131));
  // PTX:539 fma.rn.f32 %f135, %f116, %f122, %f132
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f135) : "f"(f116), "f"(f122), "f"(f132));
  // PTX:540 fma.rn.f32 %f136, %f116, %f125, %f133
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f136) : "f"(f116), "f"(f125), "f"(f133));
  // PTX:541 add.f32 %f288, %f288, %f134
  asm("add.f32 %0, %1, %2;" : "=f"(f288) : "f"(f288), "f"(f134));
  // PTX:542 add.f32 %f289, %f289, %f135
  asm("add.f32 %0, %1, %2;" : "=f"(f289) : "f"(f289), "f"(f135));
  // PTX:543 add.f32 %f290, %f290, %f136
  asm("add.f32 %0, %1, %2;" : "=f"(f290) : "f"(f290), "f"(f136));
  // PTX:544 bra.uni $L__BB2_27
  goto L_BB2_27;
  // PTX:546 $L__BB2_36:
L_BB2_36:;
  // PTX:547 mul.hi.s32 %r124, %r188, 1431655766
  asm("mul.hi.s32 %0, %1, 1431655766;" : "=r"(r124) : "r"(r188));
  // PTX:548 shr.u32 %r125, %r124, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r125) : "r"(r124));
  // PTX:549 add.s32 %r126, %r124, %r125
  asm("add.s32 %0, %1, %2;" : "=r"(r126) : "r"(r124), "r"(r125));
  // PTX:550 mul.lo.s32 %r127, %r126, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r127) : "r"(r126));
  // PTX:551 sub.s32 %r128, %r188, %r127
  asm("sub.s32 %0, %1, %2;" : "=r"(r128) : "r"(r188), "r"(r127));
  // PTX:552 mul.hi.s32 %r129, %r126, 1431655766
  asm("mul.hi.s32 %0, %1, 1431655766;" : "=r"(r129) : "r"(r126));
  // PTX:553 shr.u32 %r130, %r129, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r130) : "r"(r129));
  // PTX:554 add.s32 %r131, %r129, %r130
  asm("add.s32 %0, %1, %2;" : "=r"(r131) : "r"(r129), "r"(r130));
  // PTX:555 mul.lo.s32 %r132, %r131, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r132) : "r"(r131));
  // PTX:556 sub.s32 %r133, %r126, %r132
  asm("sub.s32 %0, %1, %2;" : "=r"(r133) : "r"(r126), "r"(r132));
  // PTX:557 add.s32 %r184, %r6, %r128
  asm("add.s32 %0, %1, %2;" : "=r"(r184) : "r"(r6), "r"(r128));
  // PTX:558 add.s32 %r185, %r7, %r133
  asm("add.s32 %0, %1, %2;" : "=r"(r185) : "r"(r7), "r"(r133));
  // PTX:559 mul.hi.s32 %r134, %r188, 954437177
  asm("mul.hi.s32 %0, %1, 954437177;" : "=r"(r134) : "r"(r188));
  // PTX:560 shr.u32 %r135, %r134, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r135) : "r"(r134));
  // PTX:561 shr.s32 %r136, %r134, 1
  asm("shr.s32 %0, %1, 1;" : "=r"(r136) : "r"(r134));
  // PTX:562 add.s32 %r137, %r136, %r135
  asm("add.s32 %0, %1, %2;" : "=r"(r137) : "r"(r136), "r"(r135));
  // PTX:563 add.s32 %r186, %r8, %r137
  asm("add.s32 %0, %1, %2;" : "=r"(r186) : "r"(r8), "r"(r137));
  // PTX:564 add.s32 %r188, %r188, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r188) : "r"(r188));
  // PTX:565 mul.lo.s32 %r138, %r184, 73856093
  asm("mul.lo.s32 %0, %1, 73856093;" : "=r"(r138) : "r"(r184));
  // PTX:566 mul.lo.s32 %r139, %r185, 19349663
  asm("mul.lo.s32 %0, %1, 19349663;" : "=r"(r139) : "r"(r185));
  // PTX:567 mul.lo.s32 %r140, %r186, 83492791
  asm("mul.lo.s32 %0, %1, 83492791;" : "=r"(r140) : "r"(r186));
  // PTX:568 xor.b32 %r141, %r140, %r138
  asm("xor.b32 %0, %1, %2;" : "=r"(r141) : "r"(r140), "r"(r138));
  // PTX:569 xor.b32 %r142, %r141, %r139
  asm("xor.b32 %0, %1, %2;" : "=r"(r142) : "r"(r141), "r"(r139));
  // PTX:570 and.b32 %r143, %r142, %r9
  asm("and.b32 %0, %1, %2;" : "=r"(r143) : "r"(r142), "r"(r9));
  // PTX:571 mul.wide.s32 %rd86, %r143, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd86) : "r"(r143));
  // PTX:572 add.s64 %rd87, %rd2, %rd86
  asm("add.s64 %0, %1, %2;" : "=l"(rd87) : "l"(rd2), "l"(rd86));
  // PTX:573 ld.global.u32 %r191, [%rd87]
  r191 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (0)))));
  // PTX:575 $L__BB2_27:
L_BB2_27:;
  // PTX:576 setp.lt.s32 %p19, %r191, 0
  p19 = (((int)(r191)) < ((int)(0)));
  // PTX:577 @%p19 bra $L__BB2_35
  if (p19) { goto L_BB2_35; }
  // PTX:579 mov.u32 %r192, %r191
  asm("mov.u32 %0, %1;" : "=r"(r192) : "r"(r191));
  // PTX:581 $L__BB2_29:
L_BB2_29:;
  // PTX:582 cvt.s64.s32 %rd20, %r192
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd20) : "r"(r192));
  // PTX:583 mul.wide.s32 %rd81, %r192, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd81) : "r"(r192));
  // PTX:584 add.s64 %rd82, %rd3, %rd81
  asm("add.s64 %0, %1, %2;" : "=l"(rd82) : "l"(rd3), "l"(rd81));
  // PTX:585 ld.global.u32 %r191, [%rd82]
  r191 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (0)))));
  // PTX:586 mul.wide.s32 %rd83, %r192, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd83) : "r"(r192));
  // PTX:587 add.s64 %rd21, %rd6, %rd83
  asm("add.s64 %0, %1, %2;" : "=l"(rd21) : "l"(rd6), "l"(rd83));
  // PTX:588 ld.global.u32 %r119, [%rd21]
  r119 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (0)))));
  // PTX:589 setp.ne.s32 %p20, %r119, %r184
  p20 = (((int)(r119)) != ((int)(r184)));
  // PTX:590 mov.u16 %rs18, 0
  asm("mov.u16 %0, 0;" : "=h"(rs18) : );
  // PTX:591 @%p20 bra $L__BB2_32
  if (p20) { goto L_BB2_32; }
  // PTX:593 ld.global.u32 %r120, [%rd21+4]
  r120 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (4)))));
  // PTX:594 setp.ne.s32 %p21, %r120, %r185
  p21 = (((int)(r120)) != ((int)(r185)));
  // PTX:595 @%p21 bra $L__BB2_32
  if (p21) { goto L_BB2_32; }
  // PTX:597 ld.global.u32 %r121, [%rd21+8]
  r121 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (8)))));
  // PTX:598 setp.eq.s32 %p22, %r121, %r186
  p22 = (((int)(r121)) == ((int)(r186)));
  // PTX:599 selp.u16 %rs18, 1, 0, %p22
  rs18 = p22 ? 1 : 0;
  // PTX:601 $L__BB2_32:
L_BB2_32:;
  // PTX:602 setp.eq.s16 %p23, %rs18, 0
  p23 = (((short)(rs18)) == ((short)(0)));
  // PTX:603 @%p23 bra $L__BB2_34
  if (p23) { goto L_BB2_34; }
  // PTX:605 shl.b64 %rd84, %rd20, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd84) : "l"(rd20));
  // PTX:606 add.s64 %rd85, %rd5, %rd84
  asm("add.s64 %0, %1, %2;" : "=l"(rd85) : "l"(rd5), "l"(rd84));
  // PTX:607 ld.global.u32 %r122, [%rd85]
  r122 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (0)))));
  // PTX:608 setp.eq.s32 %p24, %r122, %r5
  p24 = (((int)(r122)) == ((int)(r5)));
  // PTX:609 @%p24 bra $L__BB2_37
  if (p24) { goto L_BB2_37; }
  // PTX:611 $L__BB2_34:
L_BB2_34:;
  // PTX:612 setp.gt.s32 %p25, %r191, -1
  p25 = (((int)(r191)) > ((int)(-1)));
  // PTX:613 mov.u32 %r192, %r191
  asm("mov.u32 %0, %1;" : "=r"(r192) : "r"(r191));
  // PTX:614 @%p25 bra $L__BB2_29
  if (p25) { goto L_BB2_29; }
  // PTX:616 $L__BB2_35:
L_BB2_35:;
  // PTX:617 setp.eq.s32 %p26, %r188, 27
  p26 = (((int)(r188)) == ((int)(27)));
  // PTX:618 mov.u32 %r192, -1
  asm("mov.u32 %0, -1;" : "=r"(r192) : );
  // PTX:619 @%p26 bra $L__BB2_37
  if (p26) { goto L_BB2_37; }
  // PTX:620 bra.uni $L__BB2_36
  goto L_BB2_36;
  // PTX:622 $L__BB2_37:
L_BB2_37:;
  // PTX:623 setp.gt.s32 %p27, %r192, -1
  p27 = (((int)(r192)) > ((int)(-1)));
  // PTX:624 @%p27 bra $L__BB2_15
  if (p27) { goto L_BB2_15; }
  // PTX:626 $L__BB2_45:
L_BB2_45:;
  // PTX:627 ld.param.u64 %rd125, [_ZN7synreal15granular_kernel17multiply_contactsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5__param_2]
  rd125 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:628 cvta.to.global.u64 %rd122, %rd125
  rd122 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd125));
  // PTX:629 add.s64 %rd124, %rd122, %rd51
  asm("add.s64 %0, %1, %2;" : "=l"(rd124) : "l"(rd122), "l"(rd51));
  // PTX:630 ld.global.f32 %f261, [%rd124]
  f261 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd124) + (0)))));
  // PTX:631 add.f32 %f262, %f288, %f261
  asm("add.f32 %0, %1, %2;" : "=f"(f262) : "f"(f288), "f"(f261));
  // PTX:632 st.global.f32 [%rd124], %f262
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd124) + (0))))) = (float)(f262);
  // PTX:633 ld.global.f32 %f263, [%rd124+4]
  f263 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd124) + (4)))));
  // PTX:634 add.f32 %f264, %f289, %f263
  asm("add.f32 %0, %1, %2;" : "=f"(f264) : "f"(f289), "f"(f263));
  // PTX:635 st.global.f32 [%rd124+4], %f264
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd124) + (4))))) = (float)(f264);
  // PTX:636 ld.global.f32 %f265, [%rd124+8]
  f265 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd124) + (8)))));
  // PTX:637 add.f32 %f266, %f290, %f265
  asm("add.f32 %0, %1, %2;" : "=f"(f266) : "f"(f290), "f"(f265));
  // PTX:638 st.global.f32 [%rd124+8], %f266
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd124) + (8))))) = (float)(f266);
  // PTX:640 $L__BB2_46:
L_BB2_46:;
  // PTX:641 ret
  return;
}
