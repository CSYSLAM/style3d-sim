// 机械还原自 PTX：synreal::kernel::update_affine_body_so3_augmented_lagrangian_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, bool, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 6bf50d5e2ca89060b5f1b76a0a5d541a9922ae0ff2b1cc22e2982e57bc0026f6
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__update_affine_body_so3_augmented_lagrangian_state(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned char param4, unsigned long long param5, unsigned long long param6, unsigned long long param7) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18;
  unsigned short rs0, rs1;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121, r122, r123, r124, r125, r126, r127, r128, r129, r130, r131, r132, r133, r134, r135, r136, r137, r138, r139, r140, r141, r142, r143, r144, r145, r146, r147, r148, r149, r150, r151, r152, r153, r154;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38;
  // PTX:25 ld.param.s8 %rs1, [_ZN7synreal6kernel49update_affine_body_so3_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPNS1_3matILi3ELi3EfLS3_0EEESC_bmmm_param_4]
  rs1 = (*reinterpret_cast<volatile signed char*>(((uintptr_t)&param4 + (0))));
  // PTX:26 ld.param.u64 %rd9, [_ZN7synreal6kernel49update_affine_body_so3_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPNS1_3matILi3ELi3EfLS3_0EEESC_bmmm_param_0]
  rd9 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:27 ld.param.u64 %rd10, [_ZN7synreal6kernel49update_affine_body_so3_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPNS1_3matILi3ELi3EfLS3_0EEESC_bmmm_param_1]
  rd10 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:28 ld.param.u64 %rd11, [_ZN7synreal6kernel49update_affine_body_so3_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPNS1_3matILi3ELi3EfLS3_0EEESC_bmmm_param_2]
  rd11 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:29 ld.param.u64 %rd12, [_ZN7synreal6kernel49update_affine_body_so3_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPNS1_3matILi3ELi3EfLS3_0EEESC_bmmm_param_3]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:30 ld.param.u64 %rd15, [_ZN7synreal6kernel49update_affine_body_so3_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPNS1_3matILi3ELi3EfLS3_0EEESC_bmmm_param_5]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:31 ld.param.u64 %rd13, [_ZN7synreal6kernel49update_affine_body_so3_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPNS1_3matILi3ELi3EfLS3_0EEESC_bmmm_param_6]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:32 ld.param.u64 %rd14, [_ZN7synreal6kernel49update_affine_body_so3_augmented_lagrangian_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPNS1_3matILi3ELi3EfLS3_0EEESC_bmmm_param_7]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:33 mov.u32 %r69, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r69) : "r"(blockIdx.x));
  // PTX:34 mov.u32 %r70, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r70) : "r"(blockDim.x));
  // PTX:35 mul.wide.u32 %rd16, %r69, %r70
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd16) : "r"(r69), "r"(r70));
  // PTX:36 mov.u32 %r71, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r71) : "r"(threadIdx.x));
  // PTX:37 cvt.u64.u32 %rd17, %r71
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd17) : "r"(r71));
  // PTX:38 add.s64 %rd1, %rd16, %rd17
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd16), "l"(rd17));
  // PTX:39 setp.ge.u64 %p1, %rd1, %rd15
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd15)));
  // PTX:40 @%p1 bra $L__BB18_23
  if (p1) { goto L_BB18_23; }
  // PTX:42 or.b64 %rd18, %rd1, %rd13
  asm("or.b64 %0, %1, %2;" : "=l"(rd18) : "l"(rd1), "l"(rd13));
  // PTX:43 and.b64 %rd19, %rd18, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd19) : "l"(rd18));
  // PTX:44 setp.eq.s64 %p2, %rd19, 0
  p2 = (((long long)(rd19)) == ((long long)(0)));
  // PTX:45 @%p2 bra $L__BB18_3
  if (p2) { goto L_BB18_3; }
  // PTX:47 div.u64 %rd37, %rd1, %rd13
  asm("div.u64 %0, %1, %2;" : "=l"(rd37) : "l"(rd1), "l"(rd13));
  // PTX:48 mul.lo.s64 %rd20, %rd37, %rd13
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd20) : "l"(rd37), "l"(rd13));
  // PTX:49 sub.s64 %rd38, %rd1, %rd20
  asm("sub.s64 %0, %1, %2;" : "=l"(rd38) : "l"(rd1), "l"(rd20));
  // PTX:50 bra.uni $L__BB18_4
  goto L_BB18_4;
  // PTX:52 $L__BB18_3:
L_BB18_3:;
  // PTX:53 cvt.u32.u64 %r72, %rd13
  asm("cvt.u32.u64 %0, %1;" : "=r"(r72) : "l"(rd13));
  // PTX:54 cvt.u32.u64 %r73, %rd1
  asm("cvt.u32.u64 %0, %1;" : "=r"(r73) : "l"(rd1));
  // PTX:55 div.u32 %r74, %r73, %r72
  asm("div.u32 %0, %1, %2;" : "=r"(r74) : "r"(r73), "r"(r72));
  // PTX:56 mul.lo.s32 %r75, %r74, %r72
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r75) : "r"(r74), "r"(r72));
  // PTX:57 sub.s32 %r76, %r73, %r75
  asm("sub.s32 %0, %1, %2;" : "=r"(r76) : "r"(r73), "r"(r75));
  // PTX:58 cvt.u64.u32 %rd37, %r74
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd37) : "r"(r74));
  // PTX:59 cvt.u64.u32 %rd38, %r76
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd38) : "r"(r76));
  // PTX:61 $L__BB18_4:
L_BB18_4:;
  // PTX:62 cvta.to.global.u64 %rd21, %rd9
  rd21 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd9));
  // PTX:63 mul.lo.s64 %rd22, %rd37, %rd14
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd22) : "l"(rd37), "l"(rd14));
  // PTX:64 cvt.u32.u64 %r86, %rd22
  asm("cvt.u32.u64 %0, %1;" : "=r"(r86) : "l"(rd22));
  // PTX:65 cvta.to.global.u64 %rd23, %rd10
  rd23 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd10));
  // PTX:66 shl.b64 %rd24, %rd38, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd24) : "l"(rd38));
  // PTX:67 add.s64 %rd25, %rd23, %rd24
  asm("add.s64 %0, %1, %2;" : "=l"(rd25) : "l"(rd23), "l"(rd24));
  // PTX:68 ld.global.u32 %r87, [%rd25+4]
  r87 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (4)))));
  // PTX:69 add.s32 %r88, %r87, %r86
  asm("add.s32 %0, %1, %2;" : "=r"(r88) : "r"(r87), "r"(r86));
  // PTX:70 ld.global.u32 %r89, [%rd25+8]
  r89 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (8)))));
  // PTX:71 add.s32 %r90, %r89, %r86
  asm("add.s32 %0, %1, %2;" : "=r"(r90) : "r"(r89), "r"(r86));
  // PTX:72 ld.global.u32 %r91, [%rd25+12]
  r91 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (12)))));
  // PTX:73 add.s32 %r92, %r91, %r86
  asm("add.s32 %0, %1, %2;" : "=r"(r92) : "r"(r91), "r"(r86));
  // PTX:74 mul.wide.s32 %rd26, %r88, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd26) : "r"(r88));
  // PTX:75 add.s64 %rd27, %rd21, %rd26
  asm("add.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd21), "l"(rd26));
  // PTX:76 mul.wide.s32 %rd28, %r90, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd28) : "r"(r90));
  // PTX:77 add.s64 %rd29, %rd21, %rd28
  asm("add.s64 %0, %1, %2;" : "=l"(rd29) : "l"(rd21), "l"(rd28));
  // PTX:78 mul.wide.s32 %rd30, %r92, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd30) : "r"(r92));
  // PTX:79 add.s64 %rd31, %rd21, %rd30
  asm("add.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd21), "l"(rd30));
  // PTX:80 cvta.to.global.u64 %rd32, %rd12
  rd32 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd12));
  // PTX:81 mul.lo.s64 %rd33, %rd1, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd33) : "l"(rd1));
  // PTX:82 add.s64 %rd8, %rd32, %rd33
  asm("add.s64 %0, %1, %2;" : "=l"(rd8) : "l"(rd32), "l"(rd33));
  // PTX:83 ld.global.f32 %f82, [%rd8]
  f82 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (0)))));
  // PTX:84 ld.global.f32 %f83, [%rd27]
  f83 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))));
  // PTX:85 add.f32 %f1, %f83, %f82
  asm("add.f32 %0, %1, %2;" : "=f"(f1) : "f"(f83), "f"(f82));
  // PTX:86 ld.global.f32 %f84, [%rd8+4]
  f84 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (4)))));
  // PTX:87 ld.global.f32 %f85, [%rd27+4]
  f85 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (4)))));
  // PTX:88 add.f32 %f2, %f85, %f84
  asm("add.f32 %0, %1, %2;" : "=f"(f2) : "f"(f85), "f"(f84));
  // PTX:89 ld.global.f32 %f86, [%rd8+8]
  f86 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (8)))));
  // PTX:90 ld.global.f32 %f87, [%rd27+8]
  f87 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (8)))));
  // PTX:91 add.f32 %f3, %f87, %f86
  asm("add.f32 %0, %1, %2;" : "=f"(f3) : "f"(f87), "f"(f86));
  // PTX:92 ld.global.f32 %f88, [%rd8+12]
  f88 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (12)))));
  // PTX:93 ld.global.f32 %f89, [%rd29]
  f89 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (0)))));
  // PTX:94 add.f32 %f4, %f89, %f88
  asm("add.f32 %0, %1, %2;" : "=f"(f4) : "f"(f89), "f"(f88));
  // PTX:95 ld.global.f32 %f90, [%rd8+16]
  f90 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (16)))));
  // PTX:96 ld.global.f32 %f91, [%rd29+4]
  f91 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (4)))));
  // PTX:97 add.f32 %f5, %f91, %f90
  asm("add.f32 %0, %1, %2;" : "=f"(f5) : "f"(f91), "f"(f90));
  // PTX:98 ld.global.f32 %f92, [%rd8+20]
  f92 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (20)))));
  // PTX:99 ld.global.f32 %f93, [%rd29+8]
  f93 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (8)))));
  // PTX:100 add.f32 %f6, %f93, %f92
  asm("add.f32 %0, %1, %2;" : "=f"(f6) : "f"(f93), "f"(f92));
  // PTX:101 ld.global.f32 %f94, [%rd8+24]
  f94 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (24)))));
  // PTX:102 ld.global.f32 %f95, [%rd31]
  f95 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (0)))));
  // PTX:103 add.f32 %f7, %f95, %f94
  asm("add.f32 %0, %1, %2;" : "=f"(f7) : "f"(f95), "f"(f94));
  // PTX:104 ld.global.f32 %f96, [%rd8+28]
  f96 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (28)))));
  // PTX:105 ld.global.f32 %f97, [%rd31+4]
  f97 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (4)))));
  // PTX:106 add.f32 %f8, %f97, %f96
  asm("add.f32 %0, %1, %2;" : "=f"(f8) : "f"(f97), "f"(f96));
  // PTX:107 ld.global.f32 %f98, [%rd8+32]
  f98 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (32)))));
  // PTX:108 ld.global.f32 %f99, [%rd31+8]
  f99 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (8)))));
  // PTX:109 add.f32 %f9, %f99, %f98
  asm("add.f32 %0, %1, %2;" : "=f"(f9) : "f"(f99), "f"(f98));
  // PTX:110 mul.f32 %f100, %f2, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f100) : "f"(f2), "f"(f2));
  // PTX:111 fma.rn.f32 %f101, %f1, %f1, %f100
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f101) : "f"(f1), "f"(f1), "f"(f100));
  // PTX:112 fma.rn.f32 %f102, %f3, %f3, %f101
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f102) : "f"(f3), "f"(f3), "f"(f101));
  // PTX:113 mul.f32 %f103, %f5, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f103) : "f"(f5), "f"(f5));
  // PTX:114 fma.rn.f32 %f104, %f4, %f4, %f103
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f104) : "f"(f4), "f"(f4), "f"(f103));
  // PTX:115 fma.rn.f32 %f105, %f6, %f6, %f104
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f105) : "f"(f6), "f"(f6), "f"(f104));
  // PTX:116 add.f32 %f106, %f102, %f105
  asm("add.f32 %0, %1, %2;" : "=f"(f106) : "f"(f102), "f"(f105));
  // PTX:117 mul.f32 %f107, %f8, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f107) : "f"(f8), "f"(f8));
  // PTX:118 fma.rn.f32 %f108, %f7, %f7, %f107
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f108) : "f"(f7), "f"(f7), "f"(f107));
  // PTX:119 fma.rn.f32 %f109, %f9, %f9, %f108
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f109) : "f"(f9), "f"(f9), "f"(f108));
  // PTX:120 add.f32 %f110, %f106, %f109
  asm("add.f32 %0, %1, %2;" : "=f"(f110) : "f"(f106), "f"(f109));
  // PTX:121 div.rn.f32 %f111, %f110, 0f40400000
  asm("div.rn.f32 %0, %1, 0f40400000;" : "=f"(f111) : "f"(f110));
  // PTX:122 sqrt.rn.f32 %f10, %f111
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f10) : "f"(f111));
  // PTX:123 setp.leu.f32 %p3, %f10, 0f322BCC77
  p3 = ((isnan(((float)(f10))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f10)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:124 mov.u32 %r146, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r146) : );
  // PTX:125 mov.u32 %r147, 0
  asm("mov.u32 %0, 0;" : "=r"(r147) : );
  // PTX:126 mov.u32 %r148, %r147
  asm("mov.u32 %0, %1;" : "=r"(r148) : "r"(r147));
  // PTX:127 mov.u32 %r149, %r147
  asm("mov.u32 %0, %1;" : "=r"(r149) : "r"(r147));
  // PTX:128 mov.u32 %r150, %r146
  asm("mov.u32 %0, %1;" : "=r"(r150) : "r"(r146));
  // PTX:129 mov.u32 %r151, %r147
  asm("mov.u32 %0, %1;" : "=r"(r151) : "r"(r147));
  // PTX:130 mov.u32 %r152, %r147
  asm("mov.u32 %0, %1;" : "=r"(r152) : "r"(r147));
  // PTX:131 mov.u32 %r153, %r147
  asm("mov.u32 %0, %1;" : "=r"(r153) : "r"(r147));
  // PTX:132 mov.u32 %r154, %r146
  asm("mov.u32 %0, %1;" : "=r"(r154) : "r"(r146));
  // PTX:133 @%p3 bra $L__BB18_21
  if (p3) { goto L_BB18_21; }
  // PTX:135 abs.f32 %f112, %f10
  asm("abs.f32 %0, %1;" : "=f"(f112) : "f"(f10));
  // PTX:136 setp.geu.f32 %p4, %f112, 0f7F800000
  p4 = ((isnan(((float)(f112))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f112)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:137 @%p4 bra $L__BB18_21
  if (p4) { goto L_BB18_21; }
  // PTX:139 rcp.rn.f32 %f113, %f10
  asm("rcp.rn.f32 %0, %1;" : "=f"(f113) : "f"(f10));
  // PTX:140 mul.f32 %f328, %f1, %f113
  asm("mul.f32 %0, %1, %2;" : "=f"(f328) : "f"(f1), "f"(f113));
  // PTX:141 mul.f32 %f329, %f2, %f113
  asm("mul.f32 %0, %1, %2;" : "=f"(f329) : "f"(f2), "f"(f113));
  // PTX:142 mul.f32 %f330, %f3, %f113
  asm("mul.f32 %0, %1, %2;" : "=f"(f330) : "f"(f3), "f"(f113));
  // PTX:143 mul.f32 %f331, %f4, %f113
  asm("mul.f32 %0, %1, %2;" : "=f"(f331) : "f"(f4), "f"(f113));
  // PTX:144 mul.f32 %f332, %f5, %f113
  asm("mul.f32 %0, %1, %2;" : "=f"(f332) : "f"(f5), "f"(f113));
  // PTX:145 mul.f32 %f333, %f6, %f113
  asm("mul.f32 %0, %1, %2;" : "=f"(f333) : "f"(f6), "f"(f113));
  // PTX:146 mul.f32 %f334, %f7, %f113
  asm("mul.f32 %0, %1, %2;" : "=f"(f334) : "f"(f7), "f"(f113));
  // PTX:147 mul.f32 %f335, %f8, %f113
  asm("mul.f32 %0, %1, %2;" : "=f"(f335) : "f"(f8), "f"(f113));
  // PTX:148 mul.f32 %f336, %f9, %f113
  asm("mul.f32 %0, %1, %2;" : "=f"(f336) : "f"(f9), "f"(f113));
  // PTX:149 mov.u32 %r130, 0
  asm("mov.u32 %0, 0;" : "=r"(r130) : );
  // PTX:151 $L__BB18_7:
L_BB18_7:;
  // PTX:152 mul.f32 %f114, %f333, %f335
  asm("mul.f32 %0, %1, %2;" : "=f"(f114) : "f"(f333), "f"(f335));
  // PTX:153 mul.f32 %f115, %f332, %f336
  asm("mul.f32 %0, %1, %2;" : "=f"(f115) : "f"(f332), "f"(f336));
  // PTX:154 sub.f32 %f29, %f115, %f114
  asm("sub.f32 %0, %1, %2;" : "=f"(f29) : "f"(f115), "f"(f114));
  // PTX:155 mul.f32 %f116, %f331, %f336
  asm("mul.f32 %0, %1, %2;" : "=f"(f116) : "f"(f331), "f"(f336));
  // PTX:156 mul.f32 %f117, %f333, %f334
  asm("mul.f32 %0, %1, %2;" : "=f"(f117) : "f"(f333), "f"(f334));
  // PTX:157 sub.f32 %f30, %f117, %f116
  asm("sub.f32 %0, %1, %2;" : "=f"(f30) : "f"(f117), "f"(f116));
  // PTX:158 mul.f32 %f118, %f332, %f334
  asm("mul.f32 %0, %1, %2;" : "=f"(f118) : "f"(f332), "f"(f334));
  // PTX:159 mul.f32 %f119, %f331, %f335
  asm("mul.f32 %0, %1, %2;" : "=f"(f119) : "f"(f331), "f"(f335));
  // PTX:160 sub.f32 %f31, %f119, %f118
  asm("sub.f32 %0, %1, %2;" : "=f"(f31) : "f"(f119), "f"(f118));
  // PTX:161 mul.f32 %f120, %f329, %f30
  asm("mul.f32 %0, %1, %2;" : "=f"(f120) : "f"(f329), "f"(f30));
  // PTX:162 fma.rn.f32 %f121, %f328, %f29, %f120
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f121) : "f"(f328), "f"(f29), "f"(f120));
  // PTX:163 fma.rn.f32 %f32, %f330, %f31, %f121
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f32) : "f"(f330), "f"(f31), "f"(f121));
  // PTX:164 abs.f32 %f122, %f32
  asm("abs.f32 %0, %1;" : "=f"(f122) : "f"(f32));
  // PTX:165 setp.le.f32 %p5, %f122, 0f2EDBE6FF
  p5 = (!(isnan(((float)(f122))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f122)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:166 setp.geu.f32 %p6, %f122, 0f7F800000
  p6 = ((isnan(((float)(f122))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f122)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:167 or.pred %p7, %p5, %p6
  p7 = ((p5) || (p6));
  // PTX:168 @%p7 bra $L__BB18_10
  if (p7) { goto L_BB18_10; }
  // PTX:170 rcp.rn.f32 %f123, %f32
  asm("rcp.rn.f32 %0, %1;" : "=f"(f123) : "f"(f32));
  // PTX:171 mul.f32 %f124, %f329, %f336
  asm("mul.f32 %0, %1, %2;" : "=f"(f124) : "f"(f329), "f"(f336));
  // PTX:172 mul.f32 %f125, %f330, %f335
  asm("mul.f32 %0, %1, %2;" : "=f"(f125) : "f"(f330), "f"(f335));
  // PTX:173 sub.f32 %f126, %f125, %f124
  asm("sub.f32 %0, %1, %2;" : "=f"(f126) : "f"(f125), "f"(f124));
  // PTX:174 mul.f32 %f127, %f330, %f334
  asm("mul.f32 %0, %1, %2;" : "=f"(f127) : "f"(f330), "f"(f334));
  // PTX:175 mul.f32 %f128, %f328, %f336
  asm("mul.f32 %0, %1, %2;" : "=f"(f128) : "f"(f328), "f"(f336));
  // PTX:176 sub.f32 %f129, %f128, %f127
  asm("sub.f32 %0, %1, %2;" : "=f"(f129) : "f"(f128), "f"(f127));
  // PTX:177 mul.f32 %f130, %f328, %f335
  asm("mul.f32 %0, %1, %2;" : "=f"(f130) : "f"(f328), "f"(f335));
  // PTX:178 mul.f32 %f131, %f329, %f334
  asm("mul.f32 %0, %1, %2;" : "=f"(f131) : "f"(f329), "f"(f334));
  // PTX:179 sub.f32 %f132, %f131, %f130
  asm("sub.f32 %0, %1, %2;" : "=f"(f132) : "f"(f131), "f"(f130));
  // PTX:180 mul.f32 %f133, %f330, %f332
  asm("mul.f32 %0, %1, %2;" : "=f"(f133) : "f"(f330), "f"(f332));
  // PTX:181 mul.f32 %f134, %f329, %f333
  asm("mul.f32 %0, %1, %2;" : "=f"(f134) : "f"(f329), "f"(f333));
  // PTX:182 sub.f32 %f135, %f134, %f133
  asm("sub.f32 %0, %1, %2;" : "=f"(f135) : "f"(f134), "f"(f133));
  // PTX:183 mul.f32 %f136, %f328, %f333
  asm("mul.f32 %0, %1, %2;" : "=f"(f136) : "f"(f328), "f"(f333));
  // PTX:184 mul.f32 %f137, %f330, %f331
  asm("mul.f32 %0, %1, %2;" : "=f"(f137) : "f"(f330), "f"(f331));
  // PTX:185 sub.f32 %f138, %f137, %f136
  asm("sub.f32 %0, %1, %2;" : "=f"(f138) : "f"(f137), "f"(f136));
  // PTX:186 mul.f32 %f139, %f329, %f331
  asm("mul.f32 %0, %1, %2;" : "=f"(f139) : "f"(f329), "f"(f331));
  // PTX:187 mul.f32 %f140, %f328, %f332
  asm("mul.f32 %0, %1, %2;" : "=f"(f140) : "f"(f328), "f"(f332));
  // PTX:188 sub.f32 %f141, %f140, %f139
  asm("sub.f32 %0, %1, %2;" : "=f"(f141) : "f"(f140), "f"(f139));
  // PTX:189 fma.rn.f32 %f142, %f29, %f123, %f328
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f142) : "f"(f29), "f"(f123), "f"(f328));
  // PTX:190 fma.rn.f32 %f143, %f30, %f123, %f329
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f143) : "f"(f30), "f"(f123), "f"(f329));
  // PTX:191 fma.rn.f32 %f144, %f31, %f123, %f330
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f144) : "f"(f31), "f"(f123), "f"(f330));
  // PTX:192 fma.rn.f32 %f145, %f126, %f123, %f331
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f145) : "f"(f126), "f"(f123), "f"(f331));
  // PTX:193 fma.rn.f32 %f146, %f129, %f123, %f332
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f146) : "f"(f129), "f"(f123), "f"(f332));
  // PTX:194 fma.rn.f32 %f147, %f132, %f123, %f333
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f147) : "f"(f132), "f"(f123), "f"(f333));
  // PTX:195 fma.rn.f32 %f148, %f135, %f123, %f334
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f148) : "f"(f135), "f"(f123), "f"(f334));
  // PTX:196 fma.rn.f32 %f149, %f138, %f123, %f335
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f149) : "f"(f138), "f"(f123), "f"(f335));
  // PTX:197 fma.rn.f32 %f150, %f141, %f123, %f336
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f150) : "f"(f141), "f"(f123), "f"(f336));
  // PTX:198 mul.f32 %f328, %f142, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f328) : "f"(f142));
  // PTX:199 mul.f32 %f329, %f143, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f329) : "f"(f143));
  // PTX:200 mul.f32 %f330, %f144, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f330) : "f"(f144));
  // PTX:201 mul.f32 %f331, %f145, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f331) : "f"(f145));
  // PTX:202 mul.f32 %f332, %f146, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f332) : "f"(f146));
  // PTX:203 mul.f32 %f333, %f147, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f333) : "f"(f147));
  // PTX:204 mul.f32 %f334, %f148, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f334) : "f"(f148));
  // PTX:205 mul.f32 %f335, %f149, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f335) : "f"(f149));
  // PTX:206 mul.f32 %f336, %f150, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f336) : "f"(f150));
  // PTX:207 mul.f32 %f151, %f332, %f336
  asm("mul.f32 %0, %1, %2;" : "=f"(f151) : "f"(f332), "f"(f336));
  // PTX:208 mul.f32 %f152, %f333, %f335
  asm("mul.f32 %0, %1, %2;" : "=f"(f152) : "f"(f333), "f"(f335));
  // PTX:209 sub.f32 %f42, %f151, %f152
  asm("sub.f32 %0, %1, %2;" : "=f"(f42) : "f"(f151), "f"(f152));
  // PTX:210 mul.f32 %f153, %f333, %f334
  asm("mul.f32 %0, %1, %2;" : "=f"(f153) : "f"(f333), "f"(f334));
  // PTX:211 mul.f32 %f154, %f331, %f336
  asm("mul.f32 %0, %1, %2;" : "=f"(f154) : "f"(f331), "f"(f336));
  // PTX:212 sub.f32 %f43, %f153, %f154
  asm("sub.f32 %0, %1, %2;" : "=f"(f43) : "f"(f153), "f"(f154));
  // PTX:213 mul.f32 %f155, %f331, %f335
  asm("mul.f32 %0, %1, %2;" : "=f"(f155) : "f"(f331), "f"(f335));
  // PTX:214 mul.f32 %f156, %f332, %f334
  asm("mul.f32 %0, %1, %2;" : "=f"(f156) : "f"(f332), "f"(f334));
  // PTX:215 sub.f32 %f44, %f155, %f156
  asm("sub.f32 %0, %1, %2;" : "=f"(f44) : "f"(f155), "f"(f156));
  // PTX:216 mul.f32 %f157, %f329, %f43
  asm("mul.f32 %0, %1, %2;" : "=f"(f157) : "f"(f329), "f"(f43));
  // PTX:217 fma.rn.f32 %f158, %f328, %f42, %f157
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f158) : "f"(f328), "f"(f42), "f"(f157));
  // PTX:218 fma.rn.f32 %f45, %f330, %f44, %f158
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f45) : "f"(f330), "f"(f44), "f"(f158));
  // PTX:219 abs.f32 %f159, %f45
  asm("abs.f32 %0, %1;" : "=f"(f159) : "f"(f45));
  // PTX:220 setp.le.f32 %p8, %f159, 0f2EDBE6FF
  p8 = (!(isnan(((float)(f159))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f159)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:221 setp.geu.f32 %p9, %f159, 0f7F800000
  p9 = ((isnan(((float)(f159))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f159)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:222 or.pred %p10, %p8, %p9
  p10 = ((p8) || (p9));
  // PTX:223 @%p10 bra $L__BB18_10
  if (p10) { goto L_BB18_10; }
  // PTX:225 rcp.rn.f32 %f160, %f45
  asm("rcp.rn.f32 %0, %1;" : "=f"(f160) : "f"(f45));
  // PTX:226 mul.f32 %f161, %f329, %f336
  asm("mul.f32 %0, %1, %2;" : "=f"(f161) : "f"(f329), "f"(f336));
  // PTX:227 mul.f32 %f162, %f330, %f335
  asm("mul.f32 %0, %1, %2;" : "=f"(f162) : "f"(f330), "f"(f335));
  // PTX:228 sub.f32 %f163, %f162, %f161
  asm("sub.f32 %0, %1, %2;" : "=f"(f163) : "f"(f162), "f"(f161));
  // PTX:229 mul.f32 %f164, %f330, %f334
  asm("mul.f32 %0, %1, %2;" : "=f"(f164) : "f"(f330), "f"(f334));
  // PTX:230 mul.f32 %f165, %f328, %f336
  asm("mul.f32 %0, %1, %2;" : "=f"(f165) : "f"(f328), "f"(f336));
  // PTX:231 sub.f32 %f166, %f165, %f164
  asm("sub.f32 %0, %1, %2;" : "=f"(f166) : "f"(f165), "f"(f164));
  // PTX:232 mul.f32 %f167, %f328, %f335
  asm("mul.f32 %0, %1, %2;" : "=f"(f167) : "f"(f328), "f"(f335));
  // PTX:233 mul.f32 %f168, %f329, %f334
  asm("mul.f32 %0, %1, %2;" : "=f"(f168) : "f"(f329), "f"(f334));
  // PTX:234 sub.f32 %f169, %f168, %f167
  asm("sub.f32 %0, %1, %2;" : "=f"(f169) : "f"(f168), "f"(f167));
  // PTX:235 mul.f32 %f170, %f330, %f332
  asm("mul.f32 %0, %1, %2;" : "=f"(f170) : "f"(f330), "f"(f332));
  // PTX:236 mul.f32 %f171, %f329, %f333
  asm("mul.f32 %0, %1, %2;" : "=f"(f171) : "f"(f329), "f"(f333));
  // PTX:237 sub.f32 %f172, %f171, %f170
  asm("sub.f32 %0, %1, %2;" : "=f"(f172) : "f"(f171), "f"(f170));
  // PTX:238 mul.f32 %f173, %f328, %f333
  asm("mul.f32 %0, %1, %2;" : "=f"(f173) : "f"(f328), "f"(f333));
  // PTX:239 mul.f32 %f174, %f330, %f331
  asm("mul.f32 %0, %1, %2;" : "=f"(f174) : "f"(f330), "f"(f331));
  // PTX:240 sub.f32 %f175, %f174, %f173
  asm("sub.f32 %0, %1, %2;" : "=f"(f175) : "f"(f174), "f"(f173));
  // PTX:241 mul.f32 %f176, %f329, %f331
  asm("mul.f32 %0, %1, %2;" : "=f"(f176) : "f"(f329), "f"(f331));
  // PTX:242 mul.f32 %f177, %f328, %f332
  asm("mul.f32 %0, %1, %2;" : "=f"(f177) : "f"(f328), "f"(f332));
  // PTX:243 sub.f32 %f178, %f177, %f176
  asm("sub.f32 %0, %1, %2;" : "=f"(f178) : "f"(f177), "f"(f176));
  // PTX:244 fma.rn.f32 %f179, %f42, %f160, %f328
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f179) : "f"(f42), "f"(f160), "f"(f328));
  // PTX:245 fma.rn.f32 %f180, %f43, %f160, %f329
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f180) : "f"(f43), "f"(f160), "f"(f329));
  // PTX:246 fma.rn.f32 %f181, %f44, %f160, %f330
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f181) : "f"(f44), "f"(f160), "f"(f330));
  // PTX:247 fma.rn.f32 %f182, %f163, %f160, %f331
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f182) : "f"(f163), "f"(f160), "f"(f331));
  // PTX:248 fma.rn.f32 %f183, %f166, %f160, %f332
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f183) : "f"(f166), "f"(f160), "f"(f332));
  // PTX:249 fma.rn.f32 %f184, %f169, %f160, %f333
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f184) : "f"(f169), "f"(f160), "f"(f333));
  // PTX:250 fma.rn.f32 %f185, %f172, %f160, %f334
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f185) : "f"(f172), "f"(f160), "f"(f334));
  // PTX:251 fma.rn.f32 %f186, %f175, %f160, %f335
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f186) : "f"(f175), "f"(f160), "f"(f335));
  // PTX:252 fma.rn.f32 %f187, %f178, %f160, %f336
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f187) : "f"(f178), "f"(f160), "f"(f336));
  // PTX:253 mul.f32 %f328, %f179, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f328) : "f"(f179));
  // PTX:254 mul.f32 %f329, %f180, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f329) : "f"(f180));
  // PTX:255 mul.f32 %f330, %f181, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f330) : "f"(f181));
  // PTX:256 mul.f32 %f331, %f182, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f331) : "f"(f182));
  // PTX:257 mul.f32 %f332, %f183, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f332) : "f"(f183));
  // PTX:258 mul.f32 %f333, %f184, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f333) : "f"(f184));
  // PTX:259 mul.f32 %f334, %f185, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f334) : "f"(f185));
  // PTX:260 mul.f32 %f335, %f186, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f335) : "f"(f186));
  // PTX:261 mul.f32 %f336, %f187, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f336) : "f"(f187));
  // PTX:262 add.s32 %r130, %r130, 2
  asm("add.s32 %0, %1, 2;" : "=r"(r130) : "r"(r130));
  // PTX:263 setp.lt.u32 %p11, %r130, 8
  p11 = (((unsigned)(r130)) < ((unsigned)(8)));
  // PTX:264 @%p11 bra $L__BB18_7
  if (p11) { goto L_BB18_7; }
  // PTX:266 $L__BB18_10:
L_BB18_10:;
  // PTX:267 mul.f32 %f188, %f329, %f329
  asm("mul.f32 %0, %1, %2;" : "=f"(f188) : "f"(f329), "f"(f329));
  // PTX:268 fma.rn.f32 %f189, %f328, %f328, %f188
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f189) : "f"(f328), "f"(f328), "f"(f188));
  // PTX:269 fma.rn.f32 %f190, %f330, %f330, %f189
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f190) : "f"(f330), "f"(f330), "f"(f189));
  // PTX:270 sqrt.rn.f32 %f64, %f190
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f64) : "f"(f190));
  // PTX:271 setp.leu.f32 %p12, %f64, 0f00000000
  p12 = ((isnan(((float)(f64))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f64)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:272 mov.u32 %r143, 0
  asm("mov.u32 %0, 0;" : "=r"(r143) : );
  // PTX:273 mov.u32 %r131, %r143
  asm("mov.u32 %0, %1;" : "=r"(r131) : "r"(r143));
  // PTX:274 mov.u32 %r132, %r143
  asm("mov.u32 %0, %1;" : "=r"(r132) : "r"(r143));
  // PTX:275 mov.u32 %r133, %r143
  asm("mov.u32 %0, %1;" : "=r"(r133) : "r"(r143));
  // PTX:276 @%p12 bra $L__BB18_12
  if (p12) { goto L_BB18_12; }
  // PTX:278 div.rn.f32 %f191, %f328, %f64
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f191) : "f"(f328), "f"(f64));
  // PTX:279 div.rn.f32 %f192, %f329, %f64
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f192) : "f"(f329), "f"(f64));
  // PTX:280 div.rn.f32 %f193, %f330, %f64
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f193) : "f"(f330), "f"(f64));
  // PTX:281 mov.b32 %r133, %f193
  asm("mov.b32 %0, %1;" : "=r"(r133) : "f"(f193));
  // PTX:282 mov.b32 %r132, %f192
  asm("mov.b32 %0, %1;" : "=r"(r132) : "f"(f192));
  // PTX:283 mov.b32 %r131, %f191
  asm("mov.b32 %0, %1;" : "=r"(r131) : "f"(f191));
  // PTX:285 $L__BB18_12:
L_BB18_12:;
  // PTX:286 mov.b32 %f65, %r131
  asm("mov.b32 %0, %1;" : "=f"(f65) : "r"(r131));
  // PTX:287 mov.b32 %f66, %r132
  asm("mov.b32 %0, %1;" : "=f"(f66) : "r"(r132));
  // PTX:288 mul.f32 %f194, %f332, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f194) : "f"(f332), "f"(f66));
  // PTX:289 mov.b32 %f67, %r133
  asm("mov.b32 %0, %1;" : "=f"(f67) : "r"(r133));
  // PTX:290 fma.rn.f32 %f195, %f331, %f65, %f194
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f195) : "f"(f331), "f"(f65), "f"(f194));
  // PTX:291 fma.rn.f32 %f196, %f333, %f67, %f195
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f196) : "f"(f333), "f"(f67), "f"(f195));
  // PTX:292 mul.f32 %f197, %f196, %f65
  asm("mul.f32 %0, %1, %2;" : "=f"(f197) : "f"(f196), "f"(f65));
  // PTX:293 mul.f32 %f198, %f196, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f198) : "f"(f196), "f"(f66));
  // PTX:294 mul.f32 %f199, %f196, %f67
  asm("mul.f32 %0, %1, %2;" : "=f"(f199) : "f"(f196), "f"(f67));
  // PTX:295 sub.f32 %f68, %f331, %f197
  asm("sub.f32 %0, %1, %2;" : "=f"(f68) : "f"(f331), "f"(f197));
  // PTX:296 sub.f32 %f69, %f332, %f198
  asm("sub.f32 %0, %1, %2;" : "=f"(f69) : "f"(f332), "f"(f198));
  // PTX:297 sub.f32 %f70, %f333, %f199
  asm("sub.f32 %0, %1, %2;" : "=f"(f70) : "f"(f333), "f"(f199));
  // PTX:298 mul.f32 %f200, %f69, %f69
  asm("mul.f32 %0, %1, %2;" : "=f"(f200) : "f"(f69), "f"(f69));
  // PTX:299 fma.rn.f32 %f201, %f68, %f68, %f200
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f201) : "f"(f68), "f"(f68), "f"(f200));
  // PTX:300 fma.rn.f32 %f202, %f70, %f70, %f201
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f202) : "f"(f70), "f"(f70), "f"(f201));
  // PTX:301 sqrt.rn.f32 %f71, %f202
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f71) : "f"(f202));
  // PTX:302 setp.leu.f32 %p13, %f71, 0f00000000
  p13 = ((isnan(((float)(f71))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f71)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:303 mov.u32 %r144, %r143
  asm("mov.u32 %0, %1;" : "=r"(r144) : "r"(r143));
  // PTX:304 mov.u32 %r145, %r143
  asm("mov.u32 %0, %1;" : "=r"(r145) : "r"(r143));
  // PTX:305 @%p13 bra $L__BB18_14
  if (p13) { goto L_BB18_14; }
  // PTX:307 div.rn.f32 %f203, %f68, %f71
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f203) : "f"(f68), "f"(f71));
  // PTX:308 div.rn.f32 %f204, %f69, %f71
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f204) : "f"(f69), "f"(f71));
  // PTX:309 div.rn.f32 %f205, %f70, %f71
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f205) : "f"(f70), "f"(f71));
  // PTX:310 mov.b32 %r145, %f205
  asm("mov.b32 %0, %1;" : "=r"(r145) : "f"(f205));
  // PTX:311 mov.b32 %r144, %f204
  asm("mov.b32 %0, %1;" : "=r"(r144) : "f"(f204));
  // PTX:312 mov.b32 %r143, %f203
  asm("mov.b32 %0, %1;" : "=r"(r143) : "f"(f203));
  // PTX:314 $L__BB18_14:
L_BB18_14:;
  // PTX:315 mul.f32 %f206, %f66, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f206) : "f"(f66), "f"(f66));
  // PTX:316 fma.rn.f32 %f207, %f65, %f65, %f206
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f207) : "f"(f65), "f"(f65), "f"(f206));
  // PTX:317 fma.rn.f32 %f208, %f67, %f67, %f207
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f208) : "f"(f67), "f"(f67), "f"(f207));
  // PTX:318 sqrt.rn.f32 %f209, %f208
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f209) : "f"(f208));
  // PTX:319 setp.le.f32 %p14, %f209, 0f322BCC77
  p14 = (!(isnan(((float)(f209))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f209)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:320 mov.u32 %r147, 0
  asm("mov.u32 %0, 0;" : "=r"(r147) : );
  // PTX:321 mov.u32 %r148, %r147
  asm("mov.u32 %0, %1;" : "=r"(r148) : "r"(r147));
  // PTX:322 mov.u32 %r149, %r147
  asm("mov.u32 %0, %1;" : "=r"(r149) : "r"(r147));
  // PTX:323 mov.u32 %r150, %r146
  asm("mov.u32 %0, %1;" : "=r"(r150) : "r"(r146));
  // PTX:324 mov.u32 %r151, %r147
  asm("mov.u32 %0, %1;" : "=r"(r151) : "r"(r147));
  // PTX:325 mov.u32 %r152, %r147
  asm("mov.u32 %0, %1;" : "=r"(r152) : "r"(r147));
  // PTX:326 mov.u32 %r153, %r147
  asm("mov.u32 %0, %1;" : "=r"(r153) : "r"(r147));
  // PTX:327 mov.u32 %r154, %r146
  asm("mov.u32 %0, %1;" : "=r"(r154) : "r"(r146));
  // PTX:328 @%p14 bra $L__BB18_21
  if (p14) { goto L_BB18_21; }
  // PTX:330 mov.b32 %f72, %r143
  asm("mov.b32 %0, %1;" : "=f"(f72) : "r"(r143));
  // PTX:331 mov.b32 %f73, %r144
  asm("mov.b32 %0, %1;" : "=f"(f73) : "r"(r144));
  // PTX:332 mul.f32 %f210, %f73, %f73
  asm("mul.f32 %0, %1, %2;" : "=f"(f210) : "f"(f73), "f"(f73));
  // PTX:333 mov.b32 %f74, %r145
  asm("mov.b32 %0, %1;" : "=f"(f74) : "r"(r145));
  // PTX:334 fma.rn.f32 %f211, %f72, %f72, %f210
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f211) : "f"(f72), "f"(f72), "f"(f210));
  // PTX:335 fma.rn.f32 %f212, %f74, %f74, %f211
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f212) : "f"(f74), "f"(f74), "f"(f211));
  // PTX:336 sqrt.rn.f32 %f213, %f212
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f213) : "f"(f212));
  // PTX:337 setp.le.f32 %p15, %f213, 0f322BCC77
  p15 = (!(isnan(((float)(f213))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f213)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:338 mov.u32 %r150, %r146
  asm("mov.u32 %0, %1;" : "=r"(r150) : "r"(r146));
  // PTX:339 mov.u32 %r154, %r146
  asm("mov.u32 %0, %1;" : "=r"(r154) : "r"(r146));
  // PTX:340 @%p15 bra $L__BB18_21
  if (p15) { goto L_BB18_21; }
  // PTX:342 mul.f32 %f214, %f66, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f214) : "f"(f66), "f"(f74));
  // PTX:343 mul.f32 %f215, %f67, %f73
  asm("mul.f32 %0, %1, %2;" : "=f"(f215) : "f"(f67), "f"(f73));
  // PTX:344 sub.f32 %f75, %f214, %f215
  asm("sub.f32 %0, %1, %2;" : "=f"(f75) : "f"(f214), "f"(f215));
  // PTX:345 mul.f32 %f216, %f65, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f216) : "f"(f65), "f"(f74));
  // PTX:346 mul.f32 %f217, %f67, %f72
  asm("mul.f32 %0, %1, %2;" : "=f"(f217) : "f"(f67), "f"(f72));
  // PTX:347 sub.f32 %f76, %f217, %f216
  asm("sub.f32 %0, %1, %2;" : "=f"(f76) : "f"(f217), "f"(f216));
  // PTX:348 mul.f32 %f218, %f66, %f72
  asm("mul.f32 %0, %1, %2;" : "=f"(f218) : "f"(f66), "f"(f72));
  // PTX:349 mul.f32 %f219, %f65, %f73
  asm("mul.f32 %0, %1, %2;" : "=f"(f219) : "f"(f65), "f"(f73));
  // PTX:350 sub.f32 %f77, %f219, %f218
  asm("sub.f32 %0, %1, %2;" : "=f"(f77) : "f"(f219), "f"(f218));
  // PTX:351 mul.f32 %f220, %f76, %f76
  asm("mul.f32 %0, %1, %2;" : "=f"(f220) : "f"(f76), "f"(f76));
  // PTX:352 fma.rn.f32 %f221, %f75, %f75, %f220
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f221) : "f"(f75), "f"(f75), "f"(f220));
  // PTX:353 fma.rn.f32 %f222, %f77, %f77, %f221
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f222) : "f"(f77), "f"(f77), "f"(f221));
  // PTX:354 sqrt.rn.f32 %f78, %f222
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f78) : "f"(f222));
  // PTX:355 setp.leu.f32 %p16, %f78, 0f00000000
  p16 = ((isnan(((float)(f78))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f78)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:356 mov.u32 %r152, 0
  asm("mov.u32 %0, 0;" : "=r"(r152) : );
  // PTX:357 mov.u32 %r153, %r152
  asm("mov.u32 %0, %1;" : "=r"(r153) : "r"(r152));
  // PTX:358 mov.u32 %r154, %r152
  asm("mov.u32 %0, %1;" : "=r"(r154) : "r"(r152));
  // PTX:359 @%p16 bra $L__BB18_18
  if (p16) { goto L_BB18_18; }
  // PTX:361 div.rn.f32 %f223, %f75, %f78
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f223) : "f"(f75), "f"(f78));
  // PTX:362 div.rn.f32 %f224, %f76, %f78
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f224) : "f"(f76), "f"(f78));
  // PTX:363 div.rn.f32 %f225, %f77, %f78
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f225) : "f"(f77), "f"(f78));
  // PTX:364 mov.b32 %r154, %f225
  asm("mov.b32 %0, %1;" : "=r"(r154) : "f"(f225));
  // PTX:365 mov.b32 %r153, %f224
  asm("mov.b32 %0, %1;" : "=r"(r153) : "f"(f224));
  // PTX:366 mov.b32 %r152, %f223
  asm("mov.b32 %0, %1;" : "=r"(r152) : "f"(f223));
  // PTX:368 $L__BB18_18:
L_BB18_18:;
  // PTX:369 mov.b32 %f79, %r152
  asm("mov.b32 %0, %1;" : "=f"(f79) : "r"(r152));
  // PTX:370 mov.b32 %f80, %r153
  asm("mov.b32 %0, %1;" : "=f"(f80) : "r"(r153));
  // PTX:371 mul.f32 %f226, %f335, %f80
  asm("mul.f32 %0, %1, %2;" : "=f"(f226) : "f"(f335), "f"(f80));
  // PTX:372 mov.b32 %f81, %r154
  asm("mov.b32 %0, %1;" : "=f"(f81) : "r"(r154));
  // PTX:373 fma.rn.f32 %f227, %f334, %f79, %f226
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f227) : "f"(f334), "f"(f79), "f"(f226));
  // PTX:374 fma.rn.f32 %f228, %f336, %f81, %f227
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f228) : "f"(f336), "f"(f81), "f"(f227));
  // PTX:375 setp.geu.f32 %p17, %f228, 0f00000000
  p17 = ((isnan(((float)(f228))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f228)) >= ((float)(as_f32(0x00000000u)))));
  // PTX:376 @%p17 bra $L__BB18_20
  if (p17) { goto L_BB18_20; }
  // PTX:378 neg.f32 %f229, %f72
  asm("neg.f32 %0, %1;" : "=f"(f229) : "f"(f72));
  // PTX:379 mov.b32 %r143, %f229
  asm("mov.b32 %0, %1;" : "=r"(r143) : "f"(f229));
  // PTX:380 neg.f32 %f230, %f73
  asm("neg.f32 %0, %1;" : "=f"(f230) : "f"(f73));
  // PTX:381 mov.b32 %r144, %f230
  asm("mov.b32 %0, %1;" : "=r"(r144) : "f"(f230));
  // PTX:382 neg.f32 %f231, %f74
  asm("neg.f32 %0, %1;" : "=f"(f231) : "f"(f74));
  // PTX:383 mov.b32 %r145, %f231
  asm("mov.b32 %0, %1;" : "=r"(r145) : "f"(f231));
  // PTX:384 neg.f32 %f232, %f79
  asm("neg.f32 %0, %1;" : "=f"(f232) : "f"(f79));
  // PTX:385 mov.b32 %r152, %f232
  asm("mov.b32 %0, %1;" : "=r"(r152) : "f"(f232));
  // PTX:386 neg.f32 %f233, %f80
  asm("neg.f32 %0, %1;" : "=f"(f233) : "f"(f80));
  // PTX:387 mov.b32 %r153, %f233
  asm("mov.b32 %0, %1;" : "=r"(r153) : "f"(f233));
  // PTX:388 neg.f32 %f234, %f81
  asm("neg.f32 %0, %1;" : "=f"(f234) : "f"(f81));
  // PTX:389 mov.b32 %r154, %f234
  asm("mov.b32 %0, %1;" : "=r"(r154) : "f"(f234));
  // PTX:391 $L__BB18_20:
L_BB18_20:;
  // PTX:392 mov.u32 %r146, %r131
  asm("mov.u32 %0, %1;" : "=r"(r146) : "r"(r131));
  // PTX:393 mov.u32 %r147, %r132
  asm("mov.u32 %0, %1;" : "=r"(r147) : "r"(r132));
  // PTX:394 mov.u32 %r148, %r133
  asm("mov.u32 %0, %1;" : "=r"(r148) : "r"(r133));
  // PTX:395 mov.u32 %r149, %r143
  asm("mov.u32 %0, %1;" : "=r"(r149) : "r"(r143));
  // PTX:396 mov.u32 %r150, %r144
  asm("mov.u32 %0, %1;" : "=r"(r150) : "r"(r144));
  // PTX:397 mov.u32 %r151, %r145
  asm("mov.u32 %0, %1;" : "=r"(r151) : "r"(r145));
  // PTX:399 $L__BB18_21:
L_BB18_21:;
  // PTX:400 cvta.to.global.u64 %rd34, %rd11
  rd34 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd11));
  // PTX:401 add.s64 %rd36, %rd34, %rd33
  asm("add.s64 %0, %1, %2;" : "=l"(rd36) : "l"(rd34), "l"(rd33));
  // PTX:402 st.global.u32 [%rd36], %r146
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (0))))) = (unsigned)(r146);
  // PTX:403 st.global.u32 [%rd36+4], %r147
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (4))))) = (unsigned)(r147);
  // PTX:404 st.global.u32 [%rd36+8], %r148
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (8))))) = (unsigned)(r148);
  // PTX:405 st.global.u32 [%rd36+12], %r149
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (12))))) = (unsigned)(r149);
  // PTX:406 st.global.u32 [%rd36+16], %r150
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (16))))) = (unsigned)(r150);
  // PTX:407 st.global.u32 [%rd36+20], %r151
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (20))))) = (unsigned)(r151);
  // PTX:408 st.global.u32 [%rd36+24], %r152
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (24))))) = (unsigned)(r152);
  // PTX:409 st.global.u32 [%rd36+28], %r153
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (28))))) = (unsigned)(r153);
  // PTX:410 st.global.u32 [%rd36+32], %r154
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (32))))) = (unsigned)(r154);
  // PTX:411 setp.eq.s16 %p18, %rs1, 0
  p18 = (((short)(rs1)) == ((short)(0)));
  // PTX:412 @%p18 bra $L__BB18_23
  if (p18) { goto L_BB18_23; }
  // PTX:414 mov.b32 %f235, %r146
  asm("mov.b32 %0, %1;" : "=f"(f235) : "r"(r146));
  // PTX:415 sub.f32 %f236, %f1, %f235
  asm("sub.f32 %0, %1, %2;" : "=f"(f236) : "f"(f1), "f"(f235));
  // PTX:416 mov.b32 %f237, %r147
  asm("mov.b32 %0, %1;" : "=f"(f237) : "r"(r147));
  // PTX:417 sub.f32 %f238, %f2, %f237
  asm("sub.f32 %0, %1, %2;" : "=f"(f238) : "f"(f2), "f"(f237));
  // PTX:418 mov.b32 %f239, %r148
  asm("mov.b32 %0, %1;" : "=f"(f239) : "r"(r148));
  // PTX:419 sub.f32 %f240, %f3, %f239
  asm("sub.f32 %0, %1, %2;" : "=f"(f240) : "f"(f3), "f"(f239));
  // PTX:420 mov.b32 %f241, %r149
  asm("mov.b32 %0, %1;" : "=f"(f241) : "r"(r149));
  // PTX:421 sub.f32 %f242, %f4, %f241
  asm("sub.f32 %0, %1, %2;" : "=f"(f242) : "f"(f4), "f"(f241));
  // PTX:422 mov.b32 %f243, %r150
  asm("mov.b32 %0, %1;" : "=f"(f243) : "r"(r150));
  // PTX:423 sub.f32 %f244, %f5, %f243
  asm("sub.f32 %0, %1, %2;" : "=f"(f244) : "f"(f5), "f"(f243));
  // PTX:424 mov.b32 %f245, %r151
  asm("mov.b32 %0, %1;" : "=f"(f245) : "r"(r151));
  // PTX:425 sub.f32 %f246, %f6, %f245
  asm("sub.f32 %0, %1, %2;" : "=f"(f246) : "f"(f6), "f"(f245));
  // PTX:426 mov.b32 %f247, %r152
  asm("mov.b32 %0, %1;" : "=f"(f247) : "r"(r152));
  // PTX:427 sub.f32 %f248, %f7, %f247
  asm("sub.f32 %0, %1, %2;" : "=f"(f248) : "f"(f7), "f"(f247));
  // PTX:428 mov.b32 %f249, %r153
  asm("mov.b32 %0, %1;" : "=f"(f249) : "r"(r153));
  // PTX:429 sub.f32 %f250, %f8, %f249
  asm("sub.f32 %0, %1, %2;" : "=f"(f250) : "f"(f8), "f"(f249));
  // PTX:430 mov.b32 %f251, %r154
  asm("mov.b32 %0, %1;" : "=f"(f251) : "r"(r154));
  // PTX:431 sub.f32 %f252, %f9, %f251
  asm("sub.f32 %0, %1, %2;" : "=f"(f252) : "f"(f9), "f"(f251));
  // PTX:432 mul.f32 %f253, %f238, %f237
  asm("mul.f32 %0, %1, %2;" : "=f"(f253) : "f"(f238), "f"(f237));
  // PTX:433 mul.f32 %f254, %f238, %f243
  asm("mul.f32 %0, %1, %2;" : "=f"(f254) : "f"(f238), "f"(f243));
  // PTX:434 mul.f32 %f255, %f238, %f249
  asm("mul.f32 %0, %1, %2;" : "=f"(f255) : "f"(f238), "f"(f249));
  // PTX:435 fma.rn.f32 %f256, %f236, %f235, %f253
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f256) : "f"(f236), "f"(f235), "f"(f253));
  // PTX:436 fma.rn.f32 %f257, %f236, %f241, %f254
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f257) : "f"(f236), "f"(f241), "f"(f254));
  // PTX:437 fma.rn.f32 %f258, %f236, %f247, %f255
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f258) : "f"(f236), "f"(f247), "f"(f255));
  // PTX:438 fma.rn.f32 %f259, %f240, %f239, %f256
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f259) : "f"(f240), "f"(f239), "f"(f256));
  // PTX:439 fma.rn.f32 %f260, %f240, %f245, %f257
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f260) : "f"(f240), "f"(f245), "f"(f257));
  // PTX:440 fma.rn.f32 %f261, %f240, %f251, %f258
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f261) : "f"(f240), "f"(f251), "f"(f258));
  // PTX:441 mul.f32 %f262, %f244, %f237
  asm("mul.f32 %0, %1, %2;" : "=f"(f262) : "f"(f244), "f"(f237));
  // PTX:442 mul.f32 %f263, %f244, %f243
  asm("mul.f32 %0, %1, %2;" : "=f"(f263) : "f"(f244), "f"(f243));
  // PTX:443 mul.f32 %f264, %f244, %f249
  asm("mul.f32 %0, %1, %2;" : "=f"(f264) : "f"(f244), "f"(f249));
  // PTX:444 fma.rn.f32 %f265, %f242, %f235, %f262
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f265) : "f"(f242), "f"(f235), "f"(f262));
  // PTX:445 fma.rn.f32 %f266, %f242, %f241, %f263
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f266) : "f"(f242), "f"(f241), "f"(f263));
  // PTX:446 fma.rn.f32 %f267, %f242, %f247, %f264
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f267) : "f"(f242), "f"(f247), "f"(f264));
  // PTX:447 fma.rn.f32 %f268, %f246, %f239, %f265
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f268) : "f"(f246), "f"(f239), "f"(f265));
  // PTX:448 fma.rn.f32 %f269, %f246, %f245, %f266
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f269) : "f"(f246), "f"(f245), "f"(f266));
  // PTX:449 fma.rn.f32 %f270, %f246, %f251, %f267
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f270) : "f"(f246), "f"(f251), "f"(f267));
  // PTX:450 mul.f32 %f271, %f250, %f237
  asm("mul.f32 %0, %1, %2;" : "=f"(f271) : "f"(f250), "f"(f237));
  // PTX:451 mul.f32 %f272, %f250, %f243
  asm("mul.f32 %0, %1, %2;" : "=f"(f272) : "f"(f250), "f"(f243));
  // PTX:452 mul.f32 %f273, %f250, %f249
  asm("mul.f32 %0, %1, %2;" : "=f"(f273) : "f"(f250), "f"(f249));
  // PTX:453 fma.rn.f32 %f274, %f248, %f235, %f271
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f274) : "f"(f248), "f"(f235), "f"(f271));
  // PTX:454 fma.rn.f32 %f275, %f248, %f241, %f272
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f275) : "f"(f248), "f"(f241), "f"(f272));
  // PTX:455 fma.rn.f32 %f276, %f248, %f247, %f273
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f276) : "f"(f248), "f"(f247), "f"(f273));
  // PTX:456 fma.rn.f32 %f277, %f252, %f239, %f274
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f277) : "f"(f252), "f"(f239), "f"(f274));
  // PTX:457 fma.rn.f32 %f278, %f252, %f245, %f275
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f278) : "f"(f252), "f"(f245), "f"(f275));
  // PTX:458 fma.rn.f32 %f279, %f252, %f251, %f276
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f279) : "f"(f252), "f"(f251), "f"(f276));
  // PTX:459 add.f32 %f280, %f259, %f259
  asm("add.f32 %0, %1, %2;" : "=f"(f280) : "f"(f259), "f"(f259));
  // PTX:460 add.f32 %f281, %f260, %f268
  asm("add.f32 %0, %1, %2;" : "=f"(f281) : "f"(f260), "f"(f268));
  // PTX:461 add.f32 %f282, %f261, %f277
  asm("add.f32 %0, %1, %2;" : "=f"(f282) : "f"(f261), "f"(f277));
  // PTX:462 add.f32 %f283, %f269, %f269
  asm("add.f32 %0, %1, %2;" : "=f"(f283) : "f"(f269), "f"(f269));
  // PTX:463 add.f32 %f284, %f270, %f278
  asm("add.f32 %0, %1, %2;" : "=f"(f284) : "f"(f270), "f"(f278));
  // PTX:464 add.f32 %f285, %f279, %f279
  asm("add.f32 %0, %1, %2;" : "=f"(f285) : "f"(f279), "f"(f279));
  // PTX:465 mul.f32 %f286, %f280, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f286) : "f"(f280));
  // PTX:466 mul.f32 %f287, %f281, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f287) : "f"(f281));
  // PTX:467 mul.f32 %f288, %f282, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f288) : "f"(f282));
  // PTX:468 mul.f32 %f289, %f283, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f289) : "f"(f283));
  // PTX:469 mul.f32 %f290, %f284, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f290) : "f"(f284));
  // PTX:470 mul.f32 %f291, %f285, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f291) : "f"(f285));
  // PTX:471 mul.f32 %f292, %f287, %f241
  asm("mul.f32 %0, %1, %2;" : "=f"(f292) : "f"(f287), "f"(f241));
  // PTX:472 mul.f32 %f293, %f287, %f243
  asm("mul.f32 %0, %1, %2;" : "=f"(f293) : "f"(f287), "f"(f243));
  // PTX:473 mul.f32 %f294, %f287, %f245
  asm("mul.f32 %0, %1, %2;" : "=f"(f294) : "f"(f287), "f"(f245));
  // PTX:474 fma.rn.f32 %f295, %f286, %f235, %f292
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f295) : "f"(f286), "f"(f235), "f"(f292));
  // PTX:475 fma.rn.f32 %f296, %f286, %f237, %f293
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f296) : "f"(f286), "f"(f237), "f"(f293));
  // PTX:476 fma.rn.f32 %f297, %f286, %f239, %f294
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f297) : "f"(f286), "f"(f239), "f"(f294));
  // PTX:477 fma.rn.f32 %f298, %f288, %f247, %f295
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f298) : "f"(f288), "f"(f247), "f"(f295));
  // PTX:478 fma.rn.f32 %f299, %f288, %f249, %f296
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f299) : "f"(f288), "f"(f249), "f"(f296));
  // PTX:479 fma.rn.f32 %f300, %f288, %f251, %f297
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f300) : "f"(f288), "f"(f251), "f"(f297));
  // PTX:480 mul.f32 %f301, %f289, %f241
  asm("mul.f32 %0, %1, %2;" : "=f"(f301) : "f"(f289), "f"(f241));
  // PTX:481 mul.f32 %f302, %f289, %f243
  asm("mul.f32 %0, %1, %2;" : "=f"(f302) : "f"(f289), "f"(f243));
  // PTX:482 mul.f32 %f303, %f289, %f245
  asm("mul.f32 %0, %1, %2;" : "=f"(f303) : "f"(f289), "f"(f245));
  // PTX:483 fma.rn.f32 %f304, %f287, %f235, %f301
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f304) : "f"(f287), "f"(f235), "f"(f301));
  // PTX:484 fma.rn.f32 %f305, %f287, %f237, %f302
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f305) : "f"(f287), "f"(f237), "f"(f302));
  // PTX:485 fma.rn.f32 %f306, %f287, %f239, %f303
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f306) : "f"(f287), "f"(f239), "f"(f303));
  // PTX:486 fma.rn.f32 %f307, %f290, %f247, %f304
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f307) : "f"(f290), "f"(f247), "f"(f304));
  // PTX:487 fma.rn.f32 %f308, %f290, %f249, %f305
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f308) : "f"(f290), "f"(f249), "f"(f305));
  // PTX:488 fma.rn.f32 %f309, %f290, %f251, %f306
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f309) : "f"(f290), "f"(f251), "f"(f306));
  // PTX:489 mul.f32 %f310, %f290, %f241
  asm("mul.f32 %0, %1, %2;" : "=f"(f310) : "f"(f290), "f"(f241));
  // PTX:490 mul.f32 %f311, %f290, %f243
  asm("mul.f32 %0, %1, %2;" : "=f"(f311) : "f"(f290), "f"(f243));
  // PTX:491 mul.f32 %f312, %f290, %f245
  asm("mul.f32 %0, %1, %2;" : "=f"(f312) : "f"(f290), "f"(f245));
  // PTX:492 fma.rn.f32 %f313, %f288, %f235, %f310
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f313) : "f"(f288), "f"(f235), "f"(f310));
  // PTX:493 fma.rn.f32 %f314, %f288, %f237, %f311
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f314) : "f"(f288), "f"(f237), "f"(f311));
  // PTX:494 fma.rn.f32 %f315, %f288, %f239, %f312
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f315) : "f"(f288), "f"(f239), "f"(f312));
  // PTX:495 fma.rn.f32 %f316, %f291, %f247, %f313
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f316) : "f"(f291), "f"(f247), "f"(f313));
  // PTX:496 fma.rn.f32 %f317, %f291, %f249, %f314
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f317) : "f"(f291), "f"(f249), "f"(f314));
  // PTX:497 fma.rn.f32 %f318, %f291, %f251, %f315
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f318) : "f"(f291), "f"(f251), "f"(f315));
  // PTX:498 st.global.f32 [%rd8], %f298
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (0))))) = (float)(f298);
  // PTX:499 st.global.f32 [%rd8+4], %f299
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (4))))) = (float)(f299);
  // PTX:500 st.global.f32 [%rd8+8], %f300
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (8))))) = (float)(f300);
  // PTX:501 st.global.f32 [%rd8+12], %f307
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (12))))) = (float)(f307);
  // PTX:502 st.global.f32 [%rd8+16], %f308
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (16))))) = (float)(f308);
  // PTX:503 st.global.f32 [%rd8+20], %f309
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (20))))) = (float)(f309);
  // PTX:504 st.global.f32 [%rd8+24], %f316
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (24))))) = (float)(f316);
  // PTX:505 st.global.f32 [%rd8+28], %f317
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (28))))) = (float)(f317);
  // PTX:506 st.global.f32 [%rd8+32], %f318
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (32))))) = (float)(f318);
  // PTX:508 $L__BB18_23:
L_BB18_23:;
  // PTX:509 ret
  return;
}
