// 机械还原自 PTX：synreal::kernel::multiply_affine_body_constitutive_tangent(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, float, synreal::AffineBodyRigidityModel, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 389f7aecded46d9aab79500a458d1d92c70fedd734d82d3ee70e5110f2c5f7ed
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__multiply_affine_body_constitutive_tangent(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, float param4, unsigned param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440, f441, f442, f443, f444, f445, f446, f447, f448, f449, f450, f451, f452, f453, f454, f455, f456, f457, f458, f459, f460, f461, f462, f463, f464, f465, f466, f467, f468, f469, f470, f471, f472, f473, f474, f475, f476, f477, f478, f479, f480, f481, f482, f483, f484, f485, f486, f487;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121, r122, r123, r124, r125, r126, r127, r128, r129, r130, r131, r132, r133, r134, r135, r136, r137, r138, r139, r140, r141, r142, r143, r144, r145, r146, r147, r148, r149, r150, r151, r152, r153, r154, r155, r156, r157, r158, r159, r160, r161, r162, r163, r164, r165, r166, r167, r168, r169, r170, r171, r172, r173, r174, r175, r176, r177, r178, r179, r180, r181, r182, r183, r184, r185, r186, r187, r188, r189, r190, r191, r192, r193, r194, r195, r196, r197, r198, r199, r200, r201, r202, r203, r204, r205, r206, r207, r208, r209, r210, r211, r212, r213, r214;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66;
  // PTX:26 ld.param.u64 %rd11, [_ZN7synreal6kernel41multiply_affine_body_constitutive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPS4_mmm_param_0]
  rd11 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:27 ld.param.u64 %rd13, [_ZN7synreal6kernel41multiply_affine_body_constitutive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPS4_mmm_param_2]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:28 ld.param.u32 %r108, [_ZN7synreal6kernel41multiply_affine_body_constitutive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPS4_mmm_param_5]
  r108 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param5 + (0))));
  // PTX:29 ld.param.u64 %rd18, [_ZN7synreal6kernel41multiply_affine_body_constitutive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPS4_mmm_param_7]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:30 ld.param.u64 %rd16, [_ZN7synreal6kernel41multiply_affine_body_constitutive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPS4_mmm_param_8]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:31 ld.param.u64 %rd17, [_ZN7synreal6kernel41multiply_affine_body_constitutive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPS4_mmm_param_9]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:32 mov.u32 %r109, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r109) : "r"(blockIdx.x));
  // PTX:33 mov.u32 %r110, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r110) : "r"(blockDim.x));
  // PTX:34 mul.wide.u32 %rd19, %r109, %r110
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd19) : "r"(r109), "r"(r110));
  // PTX:35 mov.u32 %r111, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r111) : "r"(threadIdx.x));
  // PTX:36 cvt.u64.u32 %rd20, %r111
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd20) : "r"(r111));
  // PTX:37 add.s64 %rd1, %rd19, %rd20
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd19), "l"(rd20));
  // PTX:38 setp.ge.u64 %p1, %rd1, %rd18
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd18)));
  // PTX:39 @%p1 bra $L__BB20_27
  if (p1) { goto L_BB20_27; }
  // PTX:41 or.b64 %rd21, %rd1, %rd16
  asm("or.b64 %0, %1, %2;" : "=l"(rd21) : "l"(rd1), "l"(rd16));
  // PTX:42 and.b64 %rd22, %rd21, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd22) : "l"(rd21));
  // PTX:43 setp.eq.s64 %p2, %rd22, 0
  p2 = (((long long)(rd22)) == ((long long)(0)));
  // PTX:44 @%p2 bra $L__BB20_3
  if (p2) { goto L_BB20_3; }
  // PTX:46 div.u64 %rd65, %rd1, %rd16
  asm("div.u64 %0, %1, %2;" : "=l"(rd65) : "l"(rd1), "l"(rd16));
  // PTX:47 mul.lo.s64 %rd23, %rd65, %rd16
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd23) : "l"(rd65), "l"(rd16));
  // PTX:48 sub.s64 %rd66, %rd1, %rd23
  asm("sub.s64 %0, %1, %2;" : "=l"(rd66) : "l"(rd1), "l"(rd23));
  // PTX:49 bra.uni $L__BB20_4
  goto L_BB20_4;
  // PTX:51 $L__BB20_3:
L_BB20_3:;
  // PTX:52 cvt.u32.u64 %r112, %rd16
  asm("cvt.u32.u64 %0, %1;" : "=r"(r112) : "l"(rd16));
  // PTX:53 cvt.u32.u64 %r113, %rd1
  asm("cvt.u32.u64 %0, %1;" : "=r"(r113) : "l"(rd1));
  // PTX:54 div.u32 %r114, %r113, %r112
  asm("div.u32 %0, %1, %2;" : "=r"(r114) : "r"(r113), "r"(r112));
  // PTX:55 mul.lo.s32 %r115, %r114, %r112
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r115) : "r"(r114), "r"(r112));
  // PTX:56 sub.s32 %r116, %r113, %r115
  asm("sub.s32 %0, %1, %2;" : "=r"(r116) : "r"(r113), "r"(r115));
  // PTX:57 cvt.u64.u32 %rd65, %r114
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd65) : "r"(r114));
  // PTX:58 cvt.u64.u32 %rd66, %r116
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd66) : "r"(r116));
  // PTX:60 $L__BB20_4:
L_BB20_4:;
  // PTX:61 cvta.to.global.u64 %rd24, %rd11
  rd24 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd11));
  // PTX:62 mul.lo.s64 %rd25, %rd65, %rd17
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd25) : "l"(rd65), "l"(rd17));
  // PTX:63 cvt.u32.u64 %r1, %rd25
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd25));
  // PTX:64 cvta.to.global.u64 %rd26, %rd13
  rd26 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd13));
  // PTX:65 shl.b64 %rd27, %rd66, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd27) : "l"(rd66));
  // PTX:66 add.s64 %rd28, %rd26, %rd27
  asm("add.s64 %0, %1, %2;" : "=l"(rd28) : "l"(rd26), "l"(rd27));
  // PTX:67 ld.global.u32 %r2, [%rd28]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (0)))));
  // PTX:68 ld.global.u32 %r117, [%rd28+4]
  r117 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (4)))));
  // PTX:69 add.s32 %r118, %r117, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r118) : "r"(r117), "r"(r1));
  // PTX:70 ld.global.u32 %r119, [%rd28+8]
  r119 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (8)))));
  // PTX:71 add.s32 %r120, %r119, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r120) : "r"(r119), "r"(r1));
  // PTX:72 ld.global.u32 %r121, [%rd28+12]
  r121 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (12)))));
  // PTX:73 add.s32 %r122, %r121, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r122) : "r"(r121), "r"(r1));
  // PTX:74 cvt.s64.s32 %rd8, %r118
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd8) : "r"(r118));
  // PTX:75 mul.wide.s32 %rd29, %r118, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd29) : "r"(r118));
  // PTX:76 add.s64 %rd30, %rd24, %rd29
  asm("add.s64 %0, %1, %2;" : "=l"(rd30) : "l"(rd24), "l"(rd29));
  // PTX:77 ld.global.u32 %r3, [%rd30]
  r3 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0)))));
  // PTX:78 ld.global.u32 %r4, [%rd30+4]
  r4 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (4)))));
  // PTX:79 ld.global.u32 %r5, [%rd30+8]
  r5 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (8)))));
  // PTX:80 cvt.s64.s32 %rd9, %r120
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd9) : "r"(r120));
  // PTX:81 mul.wide.s32 %rd31, %r120, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd31) : "r"(r120));
  // PTX:82 add.s64 %rd32, %rd24, %rd31
  asm("add.s64 %0, %1, %2;" : "=l"(rd32) : "l"(rd24), "l"(rd31));
  // PTX:83 ld.global.u32 %r6, [%rd32]
  r6 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (0)))));
  // PTX:84 ld.global.u32 %r7, [%rd32+4]
  r7 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (4)))));
  // PTX:85 ld.global.u32 %r8, [%rd32+8]
  r8 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (8)))));
  // PTX:86 cvt.s64.s32 %rd10, %r122
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd10) : "r"(r122));
  // PTX:87 mul.wide.s32 %rd33, %r122, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd33) : "r"(r122));
  // PTX:88 add.s64 %rd34, %rd24, %rd33
  asm("add.s64 %0, %1, %2;" : "=l"(rd34) : "l"(rd24), "l"(rd33));
  // PTX:89 ld.global.u32 %r9, [%rd34]
  r9 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (0)))));
  // PTX:90 ld.global.u32 %r10, [%rd34+4]
  r10 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (4)))));
  // PTX:91 ld.global.u32 %r11, [%rd34+8]
  r11 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (8)))));
  // PTX:92 setp.ne.s32 %p3, %r108, 0
  p3 = (((int)(r108)) != ((int)(0)));
  // PTX:93 mov.f32 %f470, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f470) : );
  // PTX:94 mov.f32 %f471, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f471) : );
  // PTX:95 mov.f32 %f472, %f471
  asm("mov.f32 %0, %1;" : "=f"(f472) : "f"(f471));
  // PTX:96 mov.f32 %f473, %f471
  asm("mov.f32 %0, %1;" : "=f"(f473) : "f"(f471));
  // PTX:97 mov.f32 %f474, %f470
  asm("mov.f32 %0, %1;" : "=f"(f474) : "f"(f470));
  // PTX:98 mov.f32 %f475, %f471
  asm("mov.f32 %0, %1;" : "=f"(f475) : "f"(f471));
  // PTX:99 mov.f32 %f476, %f471
  asm("mov.f32 %0, %1;" : "=f"(f476) : "f"(f471));
  // PTX:100 mov.f32 %f477, %f471
  asm("mov.f32 %0, %1;" : "=f"(f477) : "f"(f471));
  // PTX:101 mov.f32 %f478, %f470
  asm("mov.f32 %0, %1;" : "=f"(f478) : "f"(f470));
  // PTX:102 @%p3 bra $L__BB20_23
  if (p3) { goto L_BB20_23; }
  // PTX:104 mov.b32 %f1, %r3
  asm("mov.b32 %0, %1;" : "=f"(f1) : "r"(r3));
  // PTX:105 mov.b32 %f2, %r4
  asm("mov.b32 %0, %1;" : "=f"(f2) : "r"(r4));
  // PTX:106 mul.f32 %f110, %f2, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f110) : "f"(f2), "f"(f2));
  // PTX:107 mov.b32 %f3, %r5
  asm("mov.b32 %0, %1;" : "=f"(f3) : "r"(r5));
  // PTX:108 fma.rn.f32 %f111, %f1, %f1, %f110
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f111) : "f"(f1), "f"(f1), "f"(f110));
  // PTX:109 fma.rn.f32 %f112, %f3, %f3, %f111
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f112) : "f"(f3), "f"(f3), "f"(f111));
  // PTX:110 mov.b32 %f4, %r6
  asm("mov.b32 %0, %1;" : "=f"(f4) : "r"(r6));
  // PTX:111 mov.b32 %f5, %r7
  asm("mov.b32 %0, %1;" : "=f"(f5) : "r"(r7));
  // PTX:112 mul.f32 %f113, %f5, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f113) : "f"(f5), "f"(f5));
  // PTX:113 mov.b32 %f6, %r8
  asm("mov.b32 %0, %1;" : "=f"(f6) : "r"(r8));
  // PTX:114 fma.rn.f32 %f114, %f4, %f4, %f113
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f114) : "f"(f4), "f"(f4), "f"(f113));
  // PTX:115 fma.rn.f32 %f115, %f6, %f6, %f114
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f115) : "f"(f6), "f"(f6), "f"(f114));
  // PTX:116 add.f32 %f116, %f112, %f115
  asm("add.f32 %0, %1, %2;" : "=f"(f116) : "f"(f112), "f"(f115));
  // PTX:117 mov.b32 %f7, %r9
  asm("mov.b32 %0, %1;" : "=f"(f7) : "r"(r9));
  // PTX:118 mov.b32 %f8, %r10
  asm("mov.b32 %0, %1;" : "=f"(f8) : "r"(r10));
  // PTX:119 mul.f32 %f117, %f8, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f117) : "f"(f8), "f"(f8));
  // PTX:120 mov.b32 %f9, %r11
  asm("mov.b32 %0, %1;" : "=f"(f9) : "r"(r11));
  // PTX:121 fma.rn.f32 %f118, %f7, %f7, %f117
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f118) : "f"(f7), "f"(f7), "f"(f117));
  // PTX:122 fma.rn.f32 %f119, %f9, %f9, %f118
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f119) : "f"(f9), "f"(f9), "f"(f118));
  // PTX:123 add.f32 %f120, %f116, %f119
  asm("add.f32 %0, %1, %2;" : "=f"(f120) : "f"(f116), "f"(f119));
  // PTX:124 div.rn.f32 %f121, %f120, 0f40400000
  asm("div.rn.f32 %0, %1, 0f40400000;" : "=f"(f121) : "f"(f120));
  // PTX:125 sqrt.rn.f32 %f10, %f121
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f10) : "f"(f121));
  // PTX:126 setp.leu.f32 %p4, %f10, 0f322BCC77
  p4 = ((isnan(((float)(f10))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f10)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:127 mov.u32 %r188, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r188) : );
  // PTX:128 mov.u32 %r189, 0
  asm("mov.u32 %0, 0;" : "=r"(r189) : );
  // PTX:129 mov.u32 %r190, %r189
  asm("mov.u32 %0, %1;" : "=r"(r190) : "r"(r189));
  // PTX:130 mov.u32 %r191, %r189
  asm("mov.u32 %0, %1;" : "=r"(r191) : "r"(r189));
  // PTX:131 mov.u32 %r192, %r188
  asm("mov.u32 %0, %1;" : "=r"(r192) : "r"(r188));
  // PTX:132 mov.u32 %r193, %r189
  asm("mov.u32 %0, %1;" : "=r"(r193) : "r"(r189));
  // PTX:133 mov.u32 %r194, %r189
  asm("mov.u32 %0, %1;" : "=r"(r194) : "r"(r189));
  // PTX:134 mov.u32 %r195, %r189
  asm("mov.u32 %0, %1;" : "=r"(r195) : "r"(r189));
  // PTX:135 mov.u32 %r196, %r188
  asm("mov.u32 %0, %1;" : "=r"(r196) : "r"(r188));
  // PTX:136 @%p4 bra $L__BB20_22
  if (p4) { goto L_BB20_22; }
  // PTX:138 abs.f32 %f122, %f10
  asm("abs.f32 %0, %1;" : "=f"(f122) : "f"(f10));
  // PTX:139 setp.geu.f32 %p5, %f122, 0f7F800000
  p5 = ((isnan(((float)(f122))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f122)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:140 @%p5 bra $L__BB20_22
  if (p5) { goto L_BB20_22; }
  // PTX:142 rcp.rn.f32 %f123, %f10
  asm("rcp.rn.f32 %0, %1;" : "=f"(f123) : "f"(f10));
  // PTX:143 mul.f32 %f461, %f123, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f461) : "f"(f123), "f"(f1));
  // PTX:144 mul.f32 %f462, %f123, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f462) : "f"(f123), "f"(f2));
  // PTX:145 mul.f32 %f463, %f123, %f3
  asm("mul.f32 %0, %1, %2;" : "=f"(f463) : "f"(f123), "f"(f3));
  // PTX:146 mul.f32 %f464, %f123, %f4
  asm("mul.f32 %0, %1, %2;" : "=f"(f464) : "f"(f123), "f"(f4));
  // PTX:147 mul.f32 %f465, %f123, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f465) : "f"(f123), "f"(f5));
  // PTX:148 mul.f32 %f466, %f123, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f466) : "f"(f123), "f"(f6));
  // PTX:149 mul.f32 %f467, %f123, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f467) : "f"(f123), "f"(f7));
  // PTX:150 mul.f32 %f468, %f123, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f468) : "f"(f123), "f"(f8));
  // PTX:151 mul.f32 %f469, %f123, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f469) : "f"(f123), "f"(f9));
  // PTX:152 mov.u32 %r172, 0
  asm("mov.u32 %0, 0;" : "=r"(r172) : );
  // PTX:154 $L__BB20_8:
L_BB20_8:;
  // PTX:155 mul.f32 %f124, %f466, %f468
  asm("mul.f32 %0, %1, %2;" : "=f"(f124) : "f"(f466), "f"(f468));
  // PTX:156 mul.f32 %f125, %f465, %f469
  asm("mul.f32 %0, %1, %2;" : "=f"(f125) : "f"(f465), "f"(f469));
  // PTX:157 sub.f32 %f29, %f125, %f124
  asm("sub.f32 %0, %1, %2;" : "=f"(f29) : "f"(f125), "f"(f124));
  // PTX:158 mul.f32 %f126, %f464, %f469
  asm("mul.f32 %0, %1, %2;" : "=f"(f126) : "f"(f464), "f"(f469));
  // PTX:159 mul.f32 %f127, %f466, %f467
  asm("mul.f32 %0, %1, %2;" : "=f"(f127) : "f"(f466), "f"(f467));
  // PTX:160 sub.f32 %f30, %f127, %f126
  asm("sub.f32 %0, %1, %2;" : "=f"(f30) : "f"(f127), "f"(f126));
  // PTX:161 mul.f32 %f128, %f465, %f467
  asm("mul.f32 %0, %1, %2;" : "=f"(f128) : "f"(f465), "f"(f467));
  // PTX:162 mul.f32 %f129, %f464, %f468
  asm("mul.f32 %0, %1, %2;" : "=f"(f129) : "f"(f464), "f"(f468));
  // PTX:163 sub.f32 %f31, %f129, %f128
  asm("sub.f32 %0, %1, %2;" : "=f"(f31) : "f"(f129), "f"(f128));
  // PTX:164 mul.f32 %f130, %f462, %f30
  asm("mul.f32 %0, %1, %2;" : "=f"(f130) : "f"(f462), "f"(f30));
  // PTX:165 fma.rn.f32 %f131, %f461, %f29, %f130
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f131) : "f"(f461), "f"(f29), "f"(f130));
  // PTX:166 fma.rn.f32 %f32, %f463, %f31, %f131
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f32) : "f"(f463), "f"(f31), "f"(f131));
  // PTX:167 abs.f32 %f132, %f32
  asm("abs.f32 %0, %1;" : "=f"(f132) : "f"(f32));
  // PTX:168 setp.le.f32 %p6, %f132, 0f2EDBE6FF
  p6 = (!(isnan(((float)(f132))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f132)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:169 setp.geu.f32 %p7, %f132, 0f7F800000
  p7 = ((isnan(((float)(f132))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f132)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:170 or.pred %p8, %p6, %p7
  p8 = ((p6) || (p7));
  // PTX:171 @%p8 bra $L__BB20_11
  if (p8) { goto L_BB20_11; }
  // PTX:173 rcp.rn.f32 %f133, %f32
  asm("rcp.rn.f32 %0, %1;" : "=f"(f133) : "f"(f32));
  // PTX:174 mul.f32 %f134, %f462, %f469
  asm("mul.f32 %0, %1, %2;" : "=f"(f134) : "f"(f462), "f"(f469));
  // PTX:175 mul.f32 %f135, %f463, %f468
  asm("mul.f32 %0, %1, %2;" : "=f"(f135) : "f"(f463), "f"(f468));
  // PTX:176 sub.f32 %f136, %f135, %f134
  asm("sub.f32 %0, %1, %2;" : "=f"(f136) : "f"(f135), "f"(f134));
  // PTX:177 mul.f32 %f137, %f463, %f467
  asm("mul.f32 %0, %1, %2;" : "=f"(f137) : "f"(f463), "f"(f467));
  // PTX:178 mul.f32 %f138, %f461, %f469
  asm("mul.f32 %0, %1, %2;" : "=f"(f138) : "f"(f461), "f"(f469));
  // PTX:179 sub.f32 %f139, %f138, %f137
  asm("sub.f32 %0, %1, %2;" : "=f"(f139) : "f"(f138), "f"(f137));
  // PTX:180 mul.f32 %f140, %f461, %f468
  asm("mul.f32 %0, %1, %2;" : "=f"(f140) : "f"(f461), "f"(f468));
  // PTX:181 mul.f32 %f141, %f462, %f467
  asm("mul.f32 %0, %1, %2;" : "=f"(f141) : "f"(f462), "f"(f467));
  // PTX:182 sub.f32 %f142, %f141, %f140
  asm("sub.f32 %0, %1, %2;" : "=f"(f142) : "f"(f141), "f"(f140));
  // PTX:183 mul.f32 %f143, %f463, %f465
  asm("mul.f32 %0, %1, %2;" : "=f"(f143) : "f"(f463), "f"(f465));
  // PTX:184 mul.f32 %f144, %f462, %f466
  asm("mul.f32 %0, %1, %2;" : "=f"(f144) : "f"(f462), "f"(f466));
  // PTX:185 sub.f32 %f145, %f144, %f143
  asm("sub.f32 %0, %1, %2;" : "=f"(f145) : "f"(f144), "f"(f143));
  // PTX:186 mul.f32 %f146, %f461, %f466
  asm("mul.f32 %0, %1, %2;" : "=f"(f146) : "f"(f461), "f"(f466));
  // PTX:187 mul.f32 %f147, %f463, %f464
  asm("mul.f32 %0, %1, %2;" : "=f"(f147) : "f"(f463), "f"(f464));
  // PTX:188 sub.f32 %f148, %f147, %f146
  asm("sub.f32 %0, %1, %2;" : "=f"(f148) : "f"(f147), "f"(f146));
  // PTX:189 mul.f32 %f149, %f462, %f464
  asm("mul.f32 %0, %1, %2;" : "=f"(f149) : "f"(f462), "f"(f464));
  // PTX:190 mul.f32 %f150, %f461, %f465
  asm("mul.f32 %0, %1, %2;" : "=f"(f150) : "f"(f461), "f"(f465));
  // PTX:191 sub.f32 %f151, %f150, %f149
  asm("sub.f32 %0, %1, %2;" : "=f"(f151) : "f"(f150), "f"(f149));
  // PTX:192 fma.rn.f32 %f152, %f29, %f133, %f461
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f152) : "f"(f29), "f"(f133), "f"(f461));
  // PTX:193 fma.rn.f32 %f153, %f30, %f133, %f462
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f153) : "f"(f30), "f"(f133), "f"(f462));
  // PTX:194 fma.rn.f32 %f154, %f31, %f133, %f463
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f154) : "f"(f31), "f"(f133), "f"(f463));
  // PTX:195 fma.rn.f32 %f155, %f136, %f133, %f464
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f155) : "f"(f136), "f"(f133), "f"(f464));
  // PTX:196 fma.rn.f32 %f156, %f139, %f133, %f465
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f156) : "f"(f139), "f"(f133), "f"(f465));
  // PTX:197 fma.rn.f32 %f157, %f142, %f133, %f466
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f157) : "f"(f142), "f"(f133), "f"(f466));
  // PTX:198 fma.rn.f32 %f158, %f145, %f133, %f467
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f158) : "f"(f145), "f"(f133), "f"(f467));
  // PTX:199 fma.rn.f32 %f159, %f148, %f133, %f468
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f159) : "f"(f148), "f"(f133), "f"(f468));
  // PTX:200 fma.rn.f32 %f160, %f151, %f133, %f469
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f160) : "f"(f151), "f"(f133), "f"(f469));
  // PTX:201 mul.f32 %f461, %f152, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f461) : "f"(f152));
  // PTX:202 mul.f32 %f462, %f153, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f462) : "f"(f153));
  // PTX:203 mul.f32 %f463, %f154, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f463) : "f"(f154));
  // PTX:204 mul.f32 %f464, %f155, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f464) : "f"(f155));
  // PTX:205 mul.f32 %f465, %f156, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f465) : "f"(f156));
  // PTX:206 mul.f32 %f466, %f157, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f466) : "f"(f157));
  // PTX:207 mul.f32 %f467, %f158, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f467) : "f"(f158));
  // PTX:208 mul.f32 %f468, %f159, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f468) : "f"(f159));
  // PTX:209 mul.f32 %f469, %f160, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f469) : "f"(f160));
  // PTX:210 mul.f32 %f161, %f465, %f469
  asm("mul.f32 %0, %1, %2;" : "=f"(f161) : "f"(f465), "f"(f469));
  // PTX:211 mul.f32 %f162, %f466, %f468
  asm("mul.f32 %0, %1, %2;" : "=f"(f162) : "f"(f466), "f"(f468));
  // PTX:212 sub.f32 %f42, %f161, %f162
  asm("sub.f32 %0, %1, %2;" : "=f"(f42) : "f"(f161), "f"(f162));
  // PTX:213 mul.f32 %f163, %f466, %f467
  asm("mul.f32 %0, %1, %2;" : "=f"(f163) : "f"(f466), "f"(f467));
  // PTX:214 mul.f32 %f164, %f464, %f469
  asm("mul.f32 %0, %1, %2;" : "=f"(f164) : "f"(f464), "f"(f469));
  // PTX:215 sub.f32 %f43, %f163, %f164
  asm("sub.f32 %0, %1, %2;" : "=f"(f43) : "f"(f163), "f"(f164));
  // PTX:216 mul.f32 %f165, %f464, %f468
  asm("mul.f32 %0, %1, %2;" : "=f"(f165) : "f"(f464), "f"(f468));
  // PTX:217 mul.f32 %f166, %f465, %f467
  asm("mul.f32 %0, %1, %2;" : "=f"(f166) : "f"(f465), "f"(f467));
  // PTX:218 sub.f32 %f44, %f165, %f166
  asm("sub.f32 %0, %1, %2;" : "=f"(f44) : "f"(f165), "f"(f166));
  // PTX:219 mul.f32 %f167, %f462, %f43
  asm("mul.f32 %0, %1, %2;" : "=f"(f167) : "f"(f462), "f"(f43));
  // PTX:220 fma.rn.f32 %f168, %f461, %f42, %f167
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f168) : "f"(f461), "f"(f42), "f"(f167));
  // PTX:221 fma.rn.f32 %f45, %f463, %f44, %f168
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f45) : "f"(f463), "f"(f44), "f"(f168));
  // PTX:222 abs.f32 %f169, %f45
  asm("abs.f32 %0, %1;" : "=f"(f169) : "f"(f45));
  // PTX:223 setp.le.f32 %p9, %f169, 0f2EDBE6FF
  p9 = (!(isnan(((float)(f169))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f169)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:224 setp.geu.f32 %p10, %f169, 0f7F800000
  p10 = ((isnan(((float)(f169))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f169)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:225 or.pred %p11, %p9, %p10
  p11 = ((p9) || (p10));
  // PTX:226 @%p11 bra $L__BB20_11
  if (p11) { goto L_BB20_11; }
  // PTX:228 rcp.rn.f32 %f170, %f45
  asm("rcp.rn.f32 %0, %1;" : "=f"(f170) : "f"(f45));
  // PTX:229 mul.f32 %f171, %f462, %f469
  asm("mul.f32 %0, %1, %2;" : "=f"(f171) : "f"(f462), "f"(f469));
  // PTX:230 mul.f32 %f172, %f463, %f468
  asm("mul.f32 %0, %1, %2;" : "=f"(f172) : "f"(f463), "f"(f468));
  // PTX:231 sub.f32 %f173, %f172, %f171
  asm("sub.f32 %0, %1, %2;" : "=f"(f173) : "f"(f172), "f"(f171));
  // PTX:232 mul.f32 %f174, %f463, %f467
  asm("mul.f32 %0, %1, %2;" : "=f"(f174) : "f"(f463), "f"(f467));
  // PTX:233 mul.f32 %f175, %f461, %f469
  asm("mul.f32 %0, %1, %2;" : "=f"(f175) : "f"(f461), "f"(f469));
  // PTX:234 sub.f32 %f176, %f175, %f174
  asm("sub.f32 %0, %1, %2;" : "=f"(f176) : "f"(f175), "f"(f174));
  // PTX:235 mul.f32 %f177, %f461, %f468
  asm("mul.f32 %0, %1, %2;" : "=f"(f177) : "f"(f461), "f"(f468));
  // PTX:236 mul.f32 %f178, %f462, %f467
  asm("mul.f32 %0, %1, %2;" : "=f"(f178) : "f"(f462), "f"(f467));
  // PTX:237 sub.f32 %f179, %f178, %f177
  asm("sub.f32 %0, %1, %2;" : "=f"(f179) : "f"(f178), "f"(f177));
  // PTX:238 mul.f32 %f180, %f463, %f465
  asm("mul.f32 %0, %1, %2;" : "=f"(f180) : "f"(f463), "f"(f465));
  // PTX:239 mul.f32 %f181, %f462, %f466
  asm("mul.f32 %0, %1, %2;" : "=f"(f181) : "f"(f462), "f"(f466));
  // PTX:240 sub.f32 %f182, %f181, %f180
  asm("sub.f32 %0, %1, %2;" : "=f"(f182) : "f"(f181), "f"(f180));
  // PTX:241 mul.f32 %f183, %f461, %f466
  asm("mul.f32 %0, %1, %2;" : "=f"(f183) : "f"(f461), "f"(f466));
  // PTX:242 mul.f32 %f184, %f463, %f464
  asm("mul.f32 %0, %1, %2;" : "=f"(f184) : "f"(f463), "f"(f464));
  // PTX:243 sub.f32 %f185, %f184, %f183
  asm("sub.f32 %0, %1, %2;" : "=f"(f185) : "f"(f184), "f"(f183));
  // PTX:244 mul.f32 %f186, %f462, %f464
  asm("mul.f32 %0, %1, %2;" : "=f"(f186) : "f"(f462), "f"(f464));
  // PTX:245 mul.f32 %f187, %f461, %f465
  asm("mul.f32 %0, %1, %2;" : "=f"(f187) : "f"(f461), "f"(f465));
  // PTX:246 sub.f32 %f188, %f187, %f186
  asm("sub.f32 %0, %1, %2;" : "=f"(f188) : "f"(f187), "f"(f186));
  // PTX:247 fma.rn.f32 %f189, %f42, %f170, %f461
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f189) : "f"(f42), "f"(f170), "f"(f461));
  // PTX:248 fma.rn.f32 %f190, %f43, %f170, %f462
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f190) : "f"(f43), "f"(f170), "f"(f462));
  // PTX:249 fma.rn.f32 %f191, %f44, %f170, %f463
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f191) : "f"(f44), "f"(f170), "f"(f463));
  // PTX:250 fma.rn.f32 %f192, %f173, %f170, %f464
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f192) : "f"(f173), "f"(f170), "f"(f464));
  // PTX:251 fma.rn.f32 %f193, %f176, %f170, %f465
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f193) : "f"(f176), "f"(f170), "f"(f465));
  // PTX:252 fma.rn.f32 %f194, %f179, %f170, %f466
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f194) : "f"(f179), "f"(f170), "f"(f466));
  // PTX:253 fma.rn.f32 %f195, %f182, %f170, %f467
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f195) : "f"(f182), "f"(f170), "f"(f467));
  // PTX:254 fma.rn.f32 %f196, %f185, %f170, %f468
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f196) : "f"(f185), "f"(f170), "f"(f468));
  // PTX:255 fma.rn.f32 %f197, %f188, %f170, %f469
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f197) : "f"(f188), "f"(f170), "f"(f469));
  // PTX:256 mul.f32 %f461, %f189, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f461) : "f"(f189));
  // PTX:257 mul.f32 %f462, %f190, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f462) : "f"(f190));
  // PTX:258 mul.f32 %f463, %f191, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f463) : "f"(f191));
  // PTX:259 mul.f32 %f464, %f192, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f464) : "f"(f192));
  // PTX:260 mul.f32 %f465, %f193, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f465) : "f"(f193));
  // PTX:261 mul.f32 %f466, %f194, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f466) : "f"(f194));
  // PTX:262 mul.f32 %f467, %f195, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f467) : "f"(f195));
  // PTX:263 mul.f32 %f468, %f196, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f468) : "f"(f196));
  // PTX:264 mul.f32 %f469, %f197, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f469) : "f"(f197));
  // PTX:265 add.s32 %r172, %r172, 2
  asm("add.s32 %0, %1, 2;" : "=r"(r172) : "r"(r172));
  // PTX:266 setp.lt.u32 %p12, %r172, 8
  p12 = (((unsigned)(r172)) < ((unsigned)(8)));
  // PTX:267 @%p12 bra $L__BB20_8
  if (p12) { goto L_BB20_8; }
  // PTX:269 $L__BB20_11:
L_BB20_11:;
  // PTX:270 mul.f32 %f198, %f462, %f462
  asm("mul.f32 %0, %1, %2;" : "=f"(f198) : "f"(f462), "f"(f462));
  // PTX:271 fma.rn.f32 %f199, %f461, %f461, %f198
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f199) : "f"(f461), "f"(f461), "f"(f198));
  // PTX:272 fma.rn.f32 %f200, %f463, %f463, %f199
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f200) : "f"(f463), "f"(f463), "f"(f199));
  // PTX:273 sqrt.rn.f32 %f64, %f200
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f64) : "f"(f200));
  // PTX:274 setp.leu.f32 %p13, %f64, 0f00000000
  p13 = ((isnan(((float)(f64))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f64)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:275 mov.u32 %r185, 0
  asm("mov.u32 %0, 0;" : "=r"(r185) : );
  // PTX:276 mov.u32 %r173, %r185
  asm("mov.u32 %0, %1;" : "=r"(r173) : "r"(r185));
  // PTX:277 mov.u32 %r174, %r185
  asm("mov.u32 %0, %1;" : "=r"(r174) : "r"(r185));
  // PTX:278 mov.u32 %r175, %r185
  asm("mov.u32 %0, %1;" : "=r"(r175) : "r"(r185));
  // PTX:279 @%p13 bra $L__BB20_13
  if (p13) { goto L_BB20_13; }
  // PTX:281 div.rn.f32 %f201, %f461, %f64
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f201) : "f"(f461), "f"(f64));
  // PTX:282 div.rn.f32 %f202, %f462, %f64
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f202) : "f"(f462), "f"(f64));
  // PTX:283 div.rn.f32 %f203, %f463, %f64
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f203) : "f"(f463), "f"(f64));
  // PTX:284 mov.b32 %r175, %f203
  asm("mov.b32 %0, %1;" : "=r"(r175) : "f"(f203));
  // PTX:285 mov.b32 %r174, %f202
  asm("mov.b32 %0, %1;" : "=r"(r174) : "f"(f202));
  // PTX:286 mov.b32 %r173, %f201
  asm("mov.b32 %0, %1;" : "=r"(r173) : "f"(f201));
  // PTX:288 $L__BB20_13:
L_BB20_13:;
  // PTX:289 mov.b32 %f65, %r173
  asm("mov.b32 %0, %1;" : "=f"(f65) : "r"(r173));
  // PTX:290 mov.b32 %f66, %r174
  asm("mov.b32 %0, %1;" : "=f"(f66) : "r"(r174));
  // PTX:291 mul.f32 %f204, %f465, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f204) : "f"(f465), "f"(f66));
  // PTX:292 mov.b32 %f67, %r175
  asm("mov.b32 %0, %1;" : "=f"(f67) : "r"(r175));
  // PTX:293 fma.rn.f32 %f205, %f464, %f65, %f204
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f205) : "f"(f464), "f"(f65), "f"(f204));
  // PTX:294 fma.rn.f32 %f206, %f466, %f67, %f205
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f206) : "f"(f466), "f"(f67), "f"(f205));
  // PTX:295 mul.f32 %f207, %f206, %f65
  asm("mul.f32 %0, %1, %2;" : "=f"(f207) : "f"(f206), "f"(f65));
  // PTX:296 mul.f32 %f208, %f206, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f208) : "f"(f206), "f"(f66));
  // PTX:297 mul.f32 %f209, %f206, %f67
  asm("mul.f32 %0, %1, %2;" : "=f"(f209) : "f"(f206), "f"(f67));
  // PTX:298 sub.f32 %f68, %f464, %f207
  asm("sub.f32 %0, %1, %2;" : "=f"(f68) : "f"(f464), "f"(f207));
  // PTX:299 sub.f32 %f69, %f465, %f208
  asm("sub.f32 %0, %1, %2;" : "=f"(f69) : "f"(f465), "f"(f208));
  // PTX:300 sub.f32 %f70, %f466, %f209
  asm("sub.f32 %0, %1, %2;" : "=f"(f70) : "f"(f466), "f"(f209));
  // PTX:301 mul.f32 %f210, %f69, %f69
  asm("mul.f32 %0, %1, %2;" : "=f"(f210) : "f"(f69), "f"(f69));
  // PTX:302 fma.rn.f32 %f211, %f68, %f68, %f210
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f211) : "f"(f68), "f"(f68), "f"(f210));
  // PTX:303 fma.rn.f32 %f212, %f70, %f70, %f211
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f212) : "f"(f70), "f"(f70), "f"(f211));
  // PTX:304 sqrt.rn.f32 %f71, %f212
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f71) : "f"(f212));
  // PTX:305 setp.leu.f32 %p14, %f71, 0f00000000
  p14 = ((isnan(((float)(f71))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f71)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:306 mov.u32 %r186, %r185
  asm("mov.u32 %0, %1;" : "=r"(r186) : "r"(r185));
  // PTX:307 mov.u32 %r187, %r185
  asm("mov.u32 %0, %1;" : "=r"(r187) : "r"(r185));
  // PTX:308 @%p14 bra $L__BB20_15
  if (p14) { goto L_BB20_15; }
  // PTX:310 div.rn.f32 %f213, %f68, %f71
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f213) : "f"(f68), "f"(f71));
  // PTX:311 div.rn.f32 %f214, %f69, %f71
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f214) : "f"(f69), "f"(f71));
  // PTX:312 div.rn.f32 %f215, %f70, %f71
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f215) : "f"(f70), "f"(f71));
  // PTX:313 mov.b32 %r187, %f215
  asm("mov.b32 %0, %1;" : "=r"(r187) : "f"(f215));
  // PTX:314 mov.b32 %r186, %f214
  asm("mov.b32 %0, %1;" : "=r"(r186) : "f"(f214));
  // PTX:315 mov.b32 %r185, %f213
  asm("mov.b32 %0, %1;" : "=r"(r185) : "f"(f213));
  // PTX:317 $L__BB20_15:
L_BB20_15:;
  // PTX:318 mov.u32 %r188, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r188) : );
  // PTX:319 mul.f32 %f216, %f66, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f216) : "f"(f66), "f"(f66));
  // PTX:320 fma.rn.f32 %f217, %f65, %f65, %f216
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f217) : "f"(f65), "f"(f65), "f"(f216));
  // PTX:321 fma.rn.f32 %f218, %f67, %f67, %f217
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f218) : "f"(f67), "f"(f67), "f"(f217));
  // PTX:322 sqrt.rn.f32 %f219, %f218
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f219) : "f"(f218));
  // PTX:323 setp.le.f32 %p15, %f219, 0f322BCC77
  p15 = (!(isnan(((float)(f219))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f219)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:324 mov.u32 %r189, 0
  asm("mov.u32 %0, 0;" : "=r"(r189) : );
  // PTX:325 mov.u32 %r190, %r189
  asm("mov.u32 %0, %1;" : "=r"(r190) : "r"(r189));
  // PTX:326 mov.u32 %r191, %r189
  asm("mov.u32 %0, %1;" : "=r"(r191) : "r"(r189));
  // PTX:327 mov.u32 %r192, %r188
  asm("mov.u32 %0, %1;" : "=r"(r192) : "r"(r188));
  // PTX:328 mov.u32 %r193, %r189
  asm("mov.u32 %0, %1;" : "=r"(r193) : "r"(r189));
  // PTX:329 mov.u32 %r194, %r189
  asm("mov.u32 %0, %1;" : "=r"(r194) : "r"(r189));
  // PTX:330 mov.u32 %r195, %r189
  asm("mov.u32 %0, %1;" : "=r"(r195) : "r"(r189));
  // PTX:331 mov.u32 %r196, %r188
  asm("mov.u32 %0, %1;" : "=r"(r196) : "r"(r188));
  // PTX:332 @%p15 bra $L__BB20_22
  if (p15) { goto L_BB20_22; }
  // PTX:334 mov.u32 %r188, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r188) : );
  // PTX:335 mov.b32 %f72, %r185
  asm("mov.b32 %0, %1;" : "=f"(f72) : "r"(r185));
  // PTX:336 mov.b32 %f73, %r186
  asm("mov.b32 %0, %1;" : "=f"(f73) : "r"(r186));
  // PTX:337 mul.f32 %f220, %f73, %f73
  asm("mul.f32 %0, %1, %2;" : "=f"(f220) : "f"(f73), "f"(f73));
  // PTX:338 mov.b32 %f74, %r187
  asm("mov.b32 %0, %1;" : "=f"(f74) : "r"(r187));
  // PTX:339 fma.rn.f32 %f221, %f72, %f72, %f220
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f221) : "f"(f72), "f"(f72), "f"(f220));
  // PTX:340 fma.rn.f32 %f222, %f74, %f74, %f221
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f222) : "f"(f74), "f"(f74), "f"(f221));
  // PTX:341 sqrt.rn.f32 %f223, %f222
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f223) : "f"(f222));
  // PTX:342 setp.le.f32 %p16, %f223, 0f322BCC77
  p16 = (!(isnan(((float)(f223))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f223)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:343 @%p16 bra $L__BB20_22
  if (p16) { goto L_BB20_22; }
  // PTX:345 mul.f32 %f224, %f66, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f224) : "f"(f66), "f"(f74));
  // PTX:346 mul.f32 %f225, %f67, %f73
  asm("mul.f32 %0, %1, %2;" : "=f"(f225) : "f"(f67), "f"(f73));
  // PTX:347 sub.f32 %f75, %f224, %f225
  asm("sub.f32 %0, %1, %2;" : "=f"(f75) : "f"(f224), "f"(f225));
  // PTX:348 mul.f32 %f226, %f65, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f226) : "f"(f65), "f"(f74));
  // PTX:349 mul.f32 %f227, %f67, %f72
  asm("mul.f32 %0, %1, %2;" : "=f"(f227) : "f"(f67), "f"(f72));
  // PTX:350 sub.f32 %f76, %f227, %f226
  asm("sub.f32 %0, %1, %2;" : "=f"(f76) : "f"(f227), "f"(f226));
  // PTX:351 mul.f32 %f228, %f66, %f72
  asm("mul.f32 %0, %1, %2;" : "=f"(f228) : "f"(f66), "f"(f72));
  // PTX:352 mul.f32 %f229, %f65, %f73
  asm("mul.f32 %0, %1, %2;" : "=f"(f229) : "f"(f65), "f"(f73));
  // PTX:353 sub.f32 %f77, %f229, %f228
  asm("sub.f32 %0, %1, %2;" : "=f"(f77) : "f"(f229), "f"(f228));
  // PTX:354 mul.f32 %f230, %f76, %f76
  asm("mul.f32 %0, %1, %2;" : "=f"(f230) : "f"(f76), "f"(f76));
  // PTX:355 fma.rn.f32 %f231, %f75, %f75, %f230
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f231) : "f"(f75), "f"(f75), "f"(f230));
  // PTX:356 fma.rn.f32 %f232, %f77, %f77, %f231
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f232) : "f"(f77), "f"(f77), "f"(f231));
  // PTX:357 sqrt.rn.f32 %f78, %f232
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f78) : "f"(f232));
  // PTX:358 setp.leu.f32 %p17, %f78, 0f00000000
  p17 = ((isnan(((float)(f78))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f78)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:359 mov.u32 %r194, 0
  asm("mov.u32 %0, 0;" : "=r"(r194) : );
  // PTX:360 mov.u32 %r195, %r194
  asm("mov.u32 %0, %1;" : "=r"(r195) : "r"(r194));
  // PTX:361 mov.u32 %r196, %r194
  asm("mov.u32 %0, %1;" : "=r"(r196) : "r"(r194));
  // PTX:362 @%p17 bra $L__BB20_19
  if (p17) { goto L_BB20_19; }
  // PTX:364 div.rn.f32 %f233, %f75, %f78
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f233) : "f"(f75), "f"(f78));
  // PTX:365 div.rn.f32 %f234, %f76, %f78
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f234) : "f"(f76), "f"(f78));
  // PTX:366 div.rn.f32 %f235, %f77, %f78
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f235) : "f"(f77), "f"(f78));
  // PTX:367 mov.b32 %r196, %f235
  asm("mov.b32 %0, %1;" : "=r"(r196) : "f"(f235));
  // PTX:368 mov.b32 %r195, %f234
  asm("mov.b32 %0, %1;" : "=r"(r195) : "f"(f234));
  // PTX:369 mov.b32 %r194, %f233
  asm("mov.b32 %0, %1;" : "=r"(r194) : "f"(f233));
  // PTX:371 $L__BB20_19:
L_BB20_19:;
  // PTX:372 mov.b32 %f79, %r194
  asm("mov.b32 %0, %1;" : "=f"(f79) : "r"(r194));
  // PTX:373 mov.b32 %f80, %r195
  asm("mov.b32 %0, %1;" : "=f"(f80) : "r"(r195));
  // PTX:374 mul.f32 %f236, %f468, %f80
  asm("mul.f32 %0, %1, %2;" : "=f"(f236) : "f"(f468), "f"(f80));
  // PTX:375 mov.b32 %f81, %r196
  asm("mov.b32 %0, %1;" : "=f"(f81) : "r"(r196));
  // PTX:376 fma.rn.f32 %f237, %f467, %f79, %f236
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f237) : "f"(f467), "f"(f79), "f"(f236));
  // PTX:377 fma.rn.f32 %f238, %f469, %f81, %f237
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f238) : "f"(f469), "f"(f81), "f"(f237));
  // PTX:378 setp.geu.f32 %p18, %f238, 0f00000000
  p18 = ((isnan(((float)(f238))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f238)) >= ((float)(as_f32(0x00000000u)))));
  // PTX:379 @%p18 bra $L__BB20_21
  if (p18) { goto L_BB20_21; }
  // PTX:381 neg.f32 %f239, %f72
  asm("neg.f32 %0, %1;" : "=f"(f239) : "f"(f72));
  // PTX:382 mov.b32 %r185, %f239
  asm("mov.b32 %0, %1;" : "=r"(r185) : "f"(f239));
  // PTX:383 neg.f32 %f240, %f73
  asm("neg.f32 %0, %1;" : "=f"(f240) : "f"(f73));
  // PTX:384 mov.b32 %r186, %f240
  asm("mov.b32 %0, %1;" : "=r"(r186) : "f"(f240));
  // PTX:385 neg.f32 %f241, %f74
  asm("neg.f32 %0, %1;" : "=f"(f241) : "f"(f74));
  // PTX:386 mov.b32 %r187, %f241
  asm("mov.b32 %0, %1;" : "=r"(r187) : "f"(f241));
  // PTX:387 neg.f32 %f242, %f79
  asm("neg.f32 %0, %1;" : "=f"(f242) : "f"(f79));
  // PTX:388 mov.b32 %r194, %f242
  asm("mov.b32 %0, %1;" : "=r"(r194) : "f"(f242));
  // PTX:389 neg.f32 %f243, %f80
  asm("neg.f32 %0, %1;" : "=f"(f243) : "f"(f80));
  // PTX:390 mov.b32 %r195, %f243
  asm("mov.b32 %0, %1;" : "=r"(r195) : "f"(f243));
  // PTX:391 neg.f32 %f244, %f81
  asm("neg.f32 %0, %1;" : "=f"(f244) : "f"(f81));
  // PTX:392 mov.b32 %r196, %f244
  asm("mov.b32 %0, %1;" : "=r"(r196) : "f"(f244));
  // PTX:394 $L__BB20_21:
L_BB20_21:;
  // PTX:395 mov.u32 %r188, %r173
  asm("mov.u32 %0, %1;" : "=r"(r188) : "r"(r173));
  // PTX:396 mov.u32 %r189, %r174
  asm("mov.u32 %0, %1;" : "=r"(r189) : "r"(r174));
  // PTX:397 mov.u32 %r190, %r175
  asm("mov.u32 %0, %1;" : "=r"(r190) : "r"(r175));
  // PTX:398 mov.u32 %r191, %r185
  asm("mov.u32 %0, %1;" : "=r"(r191) : "r"(r185));
  // PTX:399 mov.u32 %r192, %r186
  asm("mov.u32 %0, %1;" : "=r"(r192) : "r"(r186));
  // PTX:400 mov.u32 %r193, %r187
  asm("mov.u32 %0, %1;" : "=r"(r193) : "r"(r187));
  // PTX:402 $L__BB20_22:
L_BB20_22:;
  // PTX:403 mov.b32 %f478, %r188
  asm("mov.b32 %0, %1;" : "=f"(f478) : "r"(r188));
  // PTX:404 mov.b32 %f475, %r191
  asm("mov.b32 %0, %1;" : "=f"(f475) : "r"(r191));
  // PTX:405 mov.b32 %f472, %r194
  asm("mov.b32 %0, %1;" : "=f"(f472) : "r"(r194));
  // PTX:406 mov.b32 %f477, %r189
  asm("mov.b32 %0, %1;" : "=f"(f477) : "r"(r189));
  // PTX:407 mov.b32 %f474, %r192
  asm("mov.b32 %0, %1;" : "=f"(f474) : "r"(r192));
  // PTX:408 mov.b32 %f471, %r195
  asm("mov.b32 %0, %1;" : "=f"(f471) : "r"(r195));
  // PTX:409 mov.b32 %f476, %r190
  asm("mov.b32 %0, %1;" : "=f"(f476) : "r"(r190));
  // PTX:410 mov.b32 %f473, %r193
  asm("mov.b32 %0, %1;" : "=f"(f473) : "r"(r193));
  // PTX:411 mov.b32 %f470, %r196
  asm("mov.b32 %0, %1;" : "=f"(f470) : "r"(r196));
  // PTX:413 $L__BB20_23:
L_BB20_23:;
  // PTX:414 ld.param.u64 %rd62, [_ZN7synreal6kernel41multiply_affine_body_constitutive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPS4_mmm_param_1]
  rd62 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:415 ld.param.u32 %r169, [_ZN7synreal6kernel41multiply_affine_body_constitutive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPS4_mmm_param_5]
  r169 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param5 + (0))));
  // PTX:416 cvta.to.global.u64 %rd35, %rd62
  rd35 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd62));
  // PTX:417 mul.lo.s64 %rd36, %rd8, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd36) : "l"(rd8));
  // PTX:418 add.s64 %rd37, %rd35, %rd36
  asm("add.s64 %0, %1, %2;" : "=l"(rd37) : "l"(rd35), "l"(rd36));
  // PTX:419 ld.global.u32 %r71, [%rd37]
  r71 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (0)))));
  // PTX:420 ld.global.u32 %r72, [%rd37+4]
  r72 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (4)))));
  // PTX:421 ld.global.u32 %r73, [%rd37+8]
  r73 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (8)))));
  // PTX:422 mul.lo.s64 %rd38, %rd9, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd38) : "l"(rd9));
  // PTX:423 add.s64 %rd39, %rd35, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd39) : "l"(rd35), "l"(rd38));
  // PTX:424 ld.global.u32 %r74, [%rd39]
  r74 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (0)))));
  // PTX:425 ld.global.u32 %r75, [%rd39+4]
  r75 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (4)))));
  // PTX:426 ld.global.u32 %r76, [%rd39+8]
  r76 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (8)))));
  // PTX:427 mul.lo.s64 %rd40, %rd10, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd40) : "l"(rd10));
  // PTX:428 add.s64 %rd41, %rd35, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd41) : "l"(rd35), "l"(rd40));
  // PTX:429 ld.global.u32 %r77, [%rd41]
  r77 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (0)))));
  // PTX:430 ld.global.u32 %r78, [%rd41+4]
  r78 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (4)))));
  // PTX:431 ld.global.u32 %r79, [%rd41+8]
  r79 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (8)))));
  // PTX:432 setp.eq.s32 %p19, %r169, 1
  p19 = (((int)(r169)) == ((int)(1)));
  // PTX:433 add.s32 %r80, %r2, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r80) : "r"(r2), "r"(r1));
  // PTX:434 @%p19 bra $L__BB20_25
  if (p19) { goto L_BB20_25; }
  // PTX:435 bra.uni $L__BB20_24
  goto L_BB20_24;
  // PTX:437 $L__BB20_25:
L_BB20_25:;
  // PTX:438 mov.b32 %f322, %r3
  asm("mov.b32 %0, %1;" : "=f"(f322) : "r"(r3));
  // PTX:439 mov.b32 %f323, %r71
  asm("mov.b32 %0, %1;" : "=f"(f323) : "r"(r71));
  // PTX:440 mov.b32 %f324, %r72
  asm("mov.b32 %0, %1;" : "=f"(f324) : "r"(r72));
  // PTX:441 mov.b32 %f325, %r73
  asm("mov.b32 %0, %1;" : "=f"(f325) : "r"(r73));
  // PTX:442 mov.b32 %f326, %r74
  asm("mov.b32 %0, %1;" : "=f"(f326) : "r"(r74));
  // PTX:443 mov.b32 %f327, %r6
  asm("mov.b32 %0, %1;" : "=f"(f327) : "r"(r6));
  // PTX:444 mul.f32 %f328, %f327, %f326
  asm("mul.f32 %0, %1, %2;" : "=f"(f328) : "f"(f327), "f"(f326));
  // PTX:445 mov.b32 %f329, %r75
  asm("mov.b32 %0, %1;" : "=f"(f329) : "r"(r75));
  // PTX:446 mul.f32 %f330, %f327, %f329
  asm("mul.f32 %0, %1, %2;" : "=f"(f330) : "f"(f327), "f"(f329));
  // PTX:447 mov.b32 %f331, %r76
  asm("mov.b32 %0, %1;" : "=f"(f331) : "r"(r76));
  // PTX:448 mul.f32 %f332, %f327, %f331
  asm("mul.f32 %0, %1, %2;" : "=f"(f332) : "f"(f327), "f"(f331));
  // PTX:449 fma.rn.f32 %f333, %f322, %f323, %f328
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f333) : "f"(f322), "f"(f323), "f"(f328));
  // PTX:450 fma.rn.f32 %f334, %f322, %f324, %f330
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f334) : "f"(f322), "f"(f324), "f"(f330));
  // PTX:451 fma.rn.f32 %f335, %f322, %f325, %f332
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f335) : "f"(f322), "f"(f325), "f"(f332));
  // PTX:452 mov.b32 %f336, %r77
  asm("mov.b32 %0, %1;" : "=f"(f336) : "r"(r77));
  // PTX:453 mov.b32 %f337, %r9
  asm("mov.b32 %0, %1;" : "=f"(f337) : "r"(r9));
  // PTX:454 mov.b32 %f338, %r78
  asm("mov.b32 %0, %1;" : "=f"(f338) : "r"(r78));
  // PTX:455 mov.b32 %f339, %r79
  asm("mov.b32 %0, %1;" : "=f"(f339) : "r"(r79));
  // PTX:456 fma.rn.f32 %f340, %f337, %f336, %f333
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f340) : "f"(f337), "f"(f336), "f"(f333));
  // PTX:457 fma.rn.f32 %f341, %f337, %f338, %f334
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f341) : "f"(f337), "f"(f338), "f"(f334));
  // PTX:458 fma.rn.f32 %f342, %f337, %f339, %f335
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f342) : "f"(f337), "f"(f339), "f"(f335));
  // PTX:459 mov.b32 %f343, %r4
  asm("mov.b32 %0, %1;" : "=f"(f343) : "r"(r4));
  // PTX:460 mov.b32 %f344, %r7
  asm("mov.b32 %0, %1;" : "=f"(f344) : "r"(r7));
  // PTX:461 mul.f32 %f345, %f344, %f326
  asm("mul.f32 %0, %1, %2;" : "=f"(f345) : "f"(f344), "f"(f326));
  // PTX:462 mul.f32 %f346, %f344, %f329
  asm("mul.f32 %0, %1, %2;" : "=f"(f346) : "f"(f344), "f"(f329));
  // PTX:463 mul.f32 %f347, %f344, %f331
  asm("mul.f32 %0, %1, %2;" : "=f"(f347) : "f"(f344), "f"(f331));
  // PTX:464 fma.rn.f32 %f348, %f343, %f323, %f345
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f348) : "f"(f343), "f"(f323), "f"(f345));
  // PTX:465 fma.rn.f32 %f349, %f343, %f324, %f346
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f349) : "f"(f343), "f"(f324), "f"(f346));
  // PTX:466 fma.rn.f32 %f350, %f343, %f325, %f347
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f350) : "f"(f343), "f"(f325), "f"(f347));
  // PTX:467 mov.b32 %f351, %r10
  asm("mov.b32 %0, %1;" : "=f"(f351) : "r"(r10));
  // PTX:468 fma.rn.f32 %f352, %f351, %f336, %f348
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f352) : "f"(f351), "f"(f336), "f"(f348));
  // PTX:469 fma.rn.f32 %f353, %f351, %f338, %f349
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f353) : "f"(f351), "f"(f338), "f"(f349));
  // PTX:470 fma.rn.f32 %f354, %f351, %f339, %f350
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f354) : "f"(f351), "f"(f339), "f"(f350));
  // PTX:471 mov.b32 %f355, %r5
  asm("mov.b32 %0, %1;" : "=f"(f355) : "r"(r5));
  // PTX:472 mov.b32 %f356, %r8
  asm("mov.b32 %0, %1;" : "=f"(f356) : "r"(r8));
  // PTX:473 mul.f32 %f357, %f356, %f326
  asm("mul.f32 %0, %1, %2;" : "=f"(f357) : "f"(f356), "f"(f326));
  // PTX:474 mul.f32 %f358, %f356, %f329
  asm("mul.f32 %0, %1, %2;" : "=f"(f358) : "f"(f356), "f"(f329));
  // PTX:475 mul.f32 %f359, %f356, %f331
  asm("mul.f32 %0, %1, %2;" : "=f"(f359) : "f"(f356), "f"(f331));
  // PTX:476 fma.rn.f32 %f360, %f355, %f323, %f357
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f360) : "f"(f355), "f"(f323), "f"(f357));
  // PTX:477 fma.rn.f32 %f361, %f355, %f324, %f358
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f361) : "f"(f355), "f"(f324), "f"(f358));
  // PTX:478 fma.rn.f32 %f362, %f355, %f325, %f359
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f362) : "f"(f355), "f"(f325), "f"(f359));
  // PTX:479 mov.b32 %f363, %r11
  asm("mov.b32 %0, %1;" : "=f"(f363) : "r"(r11));
  // PTX:480 fma.rn.f32 %f364, %f363, %f336, %f360
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f364) : "f"(f363), "f"(f336), "f"(f360));
  // PTX:481 fma.rn.f32 %f365, %f363, %f338, %f361
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f365) : "f"(f363), "f"(f338), "f"(f361));
  // PTX:482 fma.rn.f32 %f366, %f363, %f339, %f362
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f366) : "f"(f363), "f"(f339), "f"(f362));
  // PTX:483 add.f32 %f367, %f340, %f340
  asm("add.f32 %0, %1, %2;" : "=f"(f367) : "f"(f340), "f"(f340));
  // PTX:484 add.f32 %f368, %f352, %f341
  asm("add.f32 %0, %1, %2;" : "=f"(f368) : "f"(f352), "f"(f341));
  // PTX:485 add.f32 %f369, %f364, %f342
  asm("add.f32 %0, %1, %2;" : "=f"(f369) : "f"(f364), "f"(f342));
  // PTX:486 add.f32 %f370, %f353, %f353
  asm("add.f32 %0, %1, %2;" : "=f"(f370) : "f"(f353), "f"(f353));
  // PTX:487 add.f32 %f371, %f365, %f354
  asm("add.f32 %0, %1, %2;" : "=f"(f371) : "f"(f365), "f"(f354));
  // PTX:488 add.f32 %f372, %f366, %f366
  asm("add.f32 %0, %1, %2;" : "=f"(f372) : "f"(f366), "f"(f366));
  // PTX:489 mul.f32 %f373, %f368, %f343
  asm("mul.f32 %0, %1, %2;" : "=f"(f373) : "f"(f368), "f"(f343));
  // PTX:490 mul.f32 %f374, %f370, %f343
  asm("mul.f32 %0, %1, %2;" : "=f"(f374) : "f"(f370), "f"(f343));
  // PTX:491 mul.f32 %f375, %f371, %f343
  asm("mul.f32 %0, %1, %2;" : "=f"(f375) : "f"(f371), "f"(f343));
  // PTX:492 fma.rn.f32 %f376, %f367, %f322, %f373
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f376) : "f"(f367), "f"(f322), "f"(f373));
  // PTX:493 fma.rn.f32 %f377, %f368, %f322, %f374
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f377) : "f"(f368), "f"(f322), "f"(f374));
  // PTX:494 fma.rn.f32 %f378, %f369, %f322, %f375
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f378) : "f"(f369), "f"(f322), "f"(f375));
  // PTX:495 fma.rn.f32 %f479, %f369, %f355, %f376
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f479) : "f"(f369), "f"(f355), "f"(f376));
  // PTX:496 fma.rn.f32 %f480, %f371, %f355, %f377
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f480) : "f"(f371), "f"(f355), "f"(f377));
  // PTX:497 fma.rn.f32 %f481, %f372, %f355, %f378
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f481) : "f"(f372), "f"(f355), "f"(f378));
  // PTX:498 mul.f32 %f382, %f368, %f344
  asm("mul.f32 %0, %1, %2;" : "=f"(f382) : "f"(f368), "f"(f344));
  // PTX:499 mul.f32 %f383, %f370, %f344
  asm("mul.f32 %0, %1, %2;" : "=f"(f383) : "f"(f370), "f"(f344));
  // PTX:500 mul.f32 %f384, %f371, %f344
  asm("mul.f32 %0, %1, %2;" : "=f"(f384) : "f"(f371), "f"(f344));
  // PTX:501 fma.rn.f32 %f385, %f367, %f327, %f382
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f385) : "f"(f367), "f"(f327), "f"(f382));
  // PTX:502 fma.rn.f32 %f386, %f368, %f327, %f383
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f386) : "f"(f368), "f"(f327), "f"(f383));
  // PTX:503 fma.rn.f32 %f387, %f369, %f327, %f384
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f387) : "f"(f369), "f"(f327), "f"(f384));
  // PTX:504 fma.rn.f32 %f482, %f369, %f356, %f385
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f482) : "f"(f369), "f"(f356), "f"(f385));
  // PTX:505 fma.rn.f32 %f483, %f371, %f356, %f386
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f483) : "f"(f371), "f"(f356), "f"(f386));
  // PTX:506 fma.rn.f32 %f484, %f372, %f356, %f387
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f484) : "f"(f372), "f"(f356), "f"(f387));
  // PTX:507 mul.f32 %f391, %f368, %f351
  asm("mul.f32 %0, %1, %2;" : "=f"(f391) : "f"(f368), "f"(f351));
  // PTX:508 mul.f32 %f392, %f370, %f351
  asm("mul.f32 %0, %1, %2;" : "=f"(f392) : "f"(f370), "f"(f351));
  // PTX:509 mul.f32 %f393, %f371, %f351
  asm("mul.f32 %0, %1, %2;" : "=f"(f393) : "f"(f371), "f"(f351));
  // PTX:510 fma.rn.f32 %f394, %f367, %f337, %f391
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f394) : "f"(f367), "f"(f337), "f"(f391));
  // PTX:511 fma.rn.f32 %f395, %f368, %f337, %f392
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f395) : "f"(f368), "f"(f337), "f"(f392));
  // PTX:512 fma.rn.f32 %f396, %f369, %f337, %f393
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f396) : "f"(f369), "f"(f337), "f"(f393));
  // PTX:513 fma.rn.f32 %f485, %f369, %f363, %f394
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f485) : "f"(f369), "f"(f363), "f"(f394));
  // PTX:514 fma.rn.f32 %f486, %f371, %f363, %f395
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f486) : "f"(f371), "f"(f363), "f"(f395));
  // PTX:515 fma.rn.f32 %f487, %f372, %f363, %f396
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f487) : "f"(f372), "f"(f363), "f"(f396));
  // PTX:516 bra.uni $L__BB20_26
  goto L_BB20_26;
  // PTX:518 $L__BB20_24:
L_BB20_24:;
  // PTX:519 mov.b32 %f245, %r71
  asm("mov.b32 %0, %1;" : "=f"(f245) : "r"(r71));
  // PTX:520 mov.b32 %f246, %r72
  asm("mov.b32 %0, %1;" : "=f"(f246) : "r"(r72));
  // PTX:521 mul.f32 %f247, %f477, %f246
  asm("mul.f32 %0, %1, %2;" : "=f"(f247) : "f"(f477), "f"(f246));
  // PTX:522 mul.f32 %f248, %f474, %f246
  asm("mul.f32 %0, %1, %2;" : "=f"(f248) : "f"(f474), "f"(f246));
  // PTX:523 mul.f32 %f249, %f471, %f246
  asm("mul.f32 %0, %1, %2;" : "=f"(f249) : "f"(f471), "f"(f246));
  // PTX:524 fma.rn.f32 %f250, %f478, %f245, %f247
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f250) : "f"(f478), "f"(f245), "f"(f247));
  // PTX:525 fma.rn.f32 %f251, %f475, %f245, %f248
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f251) : "f"(f475), "f"(f245), "f"(f248));
  // PTX:526 fma.rn.f32 %f252, %f472, %f245, %f249
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f252) : "f"(f472), "f"(f245), "f"(f249));
  // PTX:527 mov.b32 %f253, %r73
  asm("mov.b32 %0, %1;" : "=f"(f253) : "r"(r73));
  // PTX:528 fma.rn.f32 %f254, %f476, %f253, %f250
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f254) : "f"(f476), "f"(f253), "f"(f250));
  // PTX:529 fma.rn.f32 %f255, %f473, %f253, %f251
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f255) : "f"(f473), "f"(f253), "f"(f251));
  // PTX:530 fma.rn.f32 %f256, %f470, %f253, %f252
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f256) : "f"(f470), "f"(f253), "f"(f252));
  // PTX:531 mov.b32 %f257, %r74
  asm("mov.b32 %0, %1;" : "=f"(f257) : "r"(r74));
  // PTX:532 mov.b32 %f258, %r75
  asm("mov.b32 %0, %1;" : "=f"(f258) : "r"(r75));
  // PTX:533 mul.f32 %f259, %f477, %f258
  asm("mul.f32 %0, %1, %2;" : "=f"(f259) : "f"(f477), "f"(f258));
  // PTX:534 mul.f32 %f260, %f474, %f258
  asm("mul.f32 %0, %1, %2;" : "=f"(f260) : "f"(f474), "f"(f258));
  // PTX:535 mul.f32 %f261, %f471, %f258
  asm("mul.f32 %0, %1, %2;" : "=f"(f261) : "f"(f471), "f"(f258));
  // PTX:536 fma.rn.f32 %f262, %f478, %f257, %f259
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f262) : "f"(f478), "f"(f257), "f"(f259));
  // PTX:537 fma.rn.f32 %f263, %f475, %f257, %f260
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f263) : "f"(f475), "f"(f257), "f"(f260));
  // PTX:538 fma.rn.f32 %f264, %f472, %f257, %f261
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f264) : "f"(f472), "f"(f257), "f"(f261));
  // PTX:539 mov.b32 %f265, %r76
  asm("mov.b32 %0, %1;" : "=f"(f265) : "r"(r76));
  // PTX:540 fma.rn.f32 %f266, %f476, %f265, %f262
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f266) : "f"(f476), "f"(f265), "f"(f262));
  // PTX:541 fma.rn.f32 %f267, %f473, %f265, %f263
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f267) : "f"(f473), "f"(f265), "f"(f263));
  // PTX:542 fma.rn.f32 %f268, %f470, %f265, %f264
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f268) : "f"(f470), "f"(f265), "f"(f264));
  // PTX:543 mov.b32 %f269, %r77
  asm("mov.b32 %0, %1;" : "=f"(f269) : "r"(r77));
  // PTX:544 mov.b32 %f270, %r78
  asm("mov.b32 %0, %1;" : "=f"(f270) : "r"(r78));
  // PTX:545 mul.f32 %f271, %f477, %f270
  asm("mul.f32 %0, %1, %2;" : "=f"(f271) : "f"(f477), "f"(f270));
  // PTX:546 mul.f32 %f272, %f474, %f270
  asm("mul.f32 %0, %1, %2;" : "=f"(f272) : "f"(f474), "f"(f270));
  // PTX:547 mul.f32 %f273, %f471, %f270
  asm("mul.f32 %0, %1, %2;" : "=f"(f273) : "f"(f471), "f"(f270));
  // PTX:548 fma.rn.f32 %f274, %f478, %f269, %f271
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f274) : "f"(f478), "f"(f269), "f"(f271));
  // PTX:549 fma.rn.f32 %f275, %f475, %f269, %f272
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f275) : "f"(f475), "f"(f269), "f"(f272));
  // PTX:550 fma.rn.f32 %f276, %f472, %f269, %f273
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f276) : "f"(f472), "f"(f269), "f"(f273));
  // PTX:551 mov.b32 %f277, %r79
  asm("mov.b32 %0, %1;" : "=f"(f277) : "r"(r79));
  // PTX:552 fma.rn.f32 %f278, %f476, %f277, %f274
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f278) : "f"(f476), "f"(f277), "f"(f274));
  // PTX:553 fma.rn.f32 %f279, %f473, %f277, %f275
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f279) : "f"(f473), "f"(f277), "f"(f275));
  // PTX:554 fma.rn.f32 %f280, %f470, %f277, %f276
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f280) : "f"(f470), "f"(f277), "f"(f276));
  // PTX:555 add.f32 %f281, %f254, %f254
  asm("add.f32 %0, %1, %2;" : "=f"(f281) : "f"(f254), "f"(f254));
  // PTX:556 add.f32 %f282, %f255, %f266
  asm("add.f32 %0, %1, %2;" : "=f"(f282) : "f"(f255), "f"(f266));
  // PTX:557 add.f32 %f283, %f256, %f278
  asm("add.f32 %0, %1, %2;" : "=f"(f283) : "f"(f256), "f"(f278));
  // PTX:558 add.f32 %f284, %f267, %f267
  asm("add.f32 %0, %1, %2;" : "=f"(f284) : "f"(f267), "f"(f267));
  // PTX:559 add.f32 %f285, %f268, %f279
  asm("add.f32 %0, %1, %2;" : "=f"(f285) : "f"(f268), "f"(f279));
  // PTX:560 add.f32 %f286, %f280, %f280
  asm("add.f32 %0, %1, %2;" : "=f"(f286) : "f"(f280), "f"(f280));
  // PTX:561 add.f32 %f287, %f254, %f267
  asm("add.f32 %0, %1, %2;" : "=f"(f287) : "f"(f254), "f"(f267));
  // PTX:562 add.f32 %f288, %f287, %f280
  asm("add.f32 %0, %1, %2;" : "=f"(f288) : "f"(f287), "f"(f280));
  // PTX:563 add.f32 %f289, %f281, %f288
  asm("add.f32 %0, %1, %2;" : "=f"(f289) : "f"(f281), "f"(f288));
  // PTX:564 fma.rn.f32 %f290, %f288, 0f00000000, %f282
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f290) : "f"(f288), "f"(f282));
  // PTX:565 fma.rn.f32 %f291, %f288, 0f00000000, %f283
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f291) : "f"(f288), "f"(f283));
  // PTX:566 add.f32 %f292, %f284, %f288
  asm("add.f32 %0, %1, %2;" : "=f"(f292) : "f"(f284), "f"(f288));
  // PTX:567 fma.rn.f32 %f293, %f288, 0f00000000, %f285
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f293) : "f"(f288), "f"(f285));
  // PTX:568 add.f32 %f294, %f286, %f288
  asm("add.f32 %0, %1, %2;" : "=f"(f294) : "f"(f286), "f"(f288));
  // PTX:569 mul.f32 %f295, %f475, %f290
  asm("mul.f32 %0, %1, %2;" : "=f"(f295) : "f"(f475), "f"(f290));
  // PTX:570 mul.f32 %f296, %f474, %f290
  asm("mul.f32 %0, %1, %2;" : "=f"(f296) : "f"(f474), "f"(f290));
  // PTX:571 mul.f32 %f297, %f473, %f290
  asm("mul.f32 %0, %1, %2;" : "=f"(f297) : "f"(f473), "f"(f290));
  // PTX:572 fma.rn.f32 %f298, %f478, %f289, %f295
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f298) : "f"(f478), "f"(f289), "f"(f295));
  // PTX:573 fma.rn.f32 %f299, %f477, %f289, %f296
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f299) : "f"(f477), "f"(f289), "f"(f296));
  // PTX:574 fma.rn.f32 %f300, %f476, %f289, %f297
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f300) : "f"(f476), "f"(f289), "f"(f297));
  // PTX:575 fma.rn.f32 %f479, %f472, %f291, %f298
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f479) : "f"(f472), "f"(f291), "f"(f298));
  // PTX:576 fma.rn.f32 %f480, %f471, %f291, %f299
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f480) : "f"(f471), "f"(f291), "f"(f299));
  // PTX:577 fma.rn.f32 %f481, %f470, %f291, %f300
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f481) : "f"(f470), "f"(f291), "f"(f300));
  // PTX:578 mul.f32 %f304, %f478, %f290
  asm("mul.f32 %0, %1, %2;" : "=f"(f304) : "f"(f478), "f"(f290));
  // PTX:579 mul.f32 %f305, %f477, %f290
  asm("mul.f32 %0, %1, %2;" : "=f"(f305) : "f"(f477), "f"(f290));
  // PTX:580 mul.f32 %f306, %f476, %f290
  asm("mul.f32 %0, %1, %2;" : "=f"(f306) : "f"(f476), "f"(f290));
  // PTX:581 fma.rn.f32 %f307, %f475, %f292, %f304
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f307) : "f"(f475), "f"(f292), "f"(f304));
  // PTX:582 fma.rn.f32 %f308, %f474, %f292, %f305
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f308) : "f"(f474), "f"(f292), "f"(f305));
  // PTX:583 fma.rn.f32 %f309, %f473, %f292, %f306
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f309) : "f"(f473), "f"(f292), "f"(f306));
  // PTX:584 fma.rn.f32 %f482, %f472, %f293, %f307
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f482) : "f"(f472), "f"(f293), "f"(f307));
  // PTX:585 fma.rn.f32 %f483, %f471, %f293, %f308
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f483) : "f"(f471), "f"(f293), "f"(f308));
  // PTX:586 fma.rn.f32 %f484, %f470, %f293, %f309
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f484) : "f"(f470), "f"(f293), "f"(f309));
  // PTX:587 mul.f32 %f313, %f475, %f293
  asm("mul.f32 %0, %1, %2;" : "=f"(f313) : "f"(f475), "f"(f293));
  // PTX:588 mul.f32 %f314, %f474, %f293
  asm("mul.f32 %0, %1, %2;" : "=f"(f314) : "f"(f474), "f"(f293));
  // PTX:589 mul.f32 %f315, %f473, %f293
  asm("mul.f32 %0, %1, %2;" : "=f"(f315) : "f"(f473), "f"(f293));
  // PTX:590 fma.rn.f32 %f316, %f478, %f291, %f313
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f316) : "f"(f478), "f"(f291), "f"(f313));
  // PTX:591 fma.rn.f32 %f317, %f477, %f291, %f314
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f317) : "f"(f477), "f"(f291), "f"(f314));
  // PTX:592 fma.rn.f32 %f318, %f476, %f291, %f315
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f318) : "f"(f476), "f"(f291), "f"(f315));
  // PTX:593 fma.rn.f32 %f485, %f472, %f294, %f316
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f485) : "f"(f472), "f"(f294), "f"(f316));
  // PTX:594 fma.rn.f32 %f486, %f471, %f294, %f317
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f486) : "f"(f471), "f"(f294), "f"(f317));
  // PTX:595 fma.rn.f32 %f487, %f470, %f294, %f318
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f487) : "f"(f470), "f"(f294), "f"(f318));
  // PTX:597 $L__BB20_26:
L_BB20_26:;
  // PTX:598 ld.param.u64 %rd64, [_ZN7synreal6kernel41multiply_affine_body_constitutive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPS4_mmm_param_3]
  rd64 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:599 ld.param.f32 %f451, [_ZN7synreal6kernel41multiply_affine_body_constitutive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPS4_mmm_param_4]
  f451 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param4 + (0))));
  // PTX:600 ld.param.u64 %rd63, [_ZN7synreal6kernel41multiply_affine_body_constitutive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPS4_mmm_param_6]
  rd63 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:601 cvta.to.global.u64 %rd42, %rd63
  rd42 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd63));
  // PTX:602 cvta.to.global.u64 %rd43, %rd64
  rd43 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd64));
  // PTX:603 shl.b64 %rd44, %rd66, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd44) : "l"(rd66));
  // PTX:604 add.s64 %rd45, %rd43, %rd44
  asm("add.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd43), "l"(rd44));
  // PTX:605 ld.global.f32 %f400, [%rd45]
  f400 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))));
  // PTX:606 mul.f32 %f401, %f400, %f451
  asm("mul.f32 %0, %1, %2;" : "=f"(f401) : "f"(f400), "f"(f451));
  // PTX:607 mul.f32 %f402, %f401, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f402) : "f"(f401));
  // PTX:608 mul.wide.s32 %rd46, %r80, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd46) : "r"(r80));
  // PTX:609 add.s64 %rd47, %rd42, %rd46
  asm("add.s64 %0, %1, %2;" : "=l"(rd47) : "l"(rd42), "l"(rd46));
  // PTX:610 red.global.add.f32 [%rd47], %f402
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))), (float)(f402));
  // PTX:611 add.s64 %rd48, %rd47, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd48) : "l"(rd47));
  // PTX:612 red.global.add.f32 [%rd48], %f402
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))), (float)(f402));
  // PTX:613 add.s64 %rd49, %rd47, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd49) : "l"(rd47));
  // PTX:614 red.global.add.f32 [%rd49], %f402
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))), (float)(f402));
  // PTX:615 mul.f32 %f407, %f401, %f479
  asm("mul.f32 %0, %1, %2;" : "=f"(f407) : "f"(f401), "f"(f479));
  // PTX:616 mul.f32 %f409, %f401, %f480
  asm("mul.f32 %0, %1, %2;" : "=f"(f409) : "f"(f401), "f"(f480));
  // PTX:617 mul.f32 %f411, %f401, %f481
  asm("mul.f32 %0, %1, %2;" : "=f"(f411) : "f"(f401), "f"(f481));
  // PTX:618 add.s64 %rd51, %rd42, %rd36
  asm("add.s64 %0, %1, %2;" : "=l"(rd51) : "l"(rd42), "l"(rd36));
  // PTX:619 red.global.add.f32 [%rd51], %f407
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))), (float)(f407));
  // PTX:620 add.s64 %rd52, %rd51, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd52) : "l"(rd51));
  // PTX:621 red.global.add.f32 [%rd52], %f409
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))), (float)(f409));
  // PTX:622 add.s64 %rd53, %rd51, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd53) : "l"(rd51));
  // PTX:623 red.global.add.f32 [%rd53], %f411
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))), (float)(f411));
  // PTX:624 mul.f32 %f416, %f401, %f482
  asm("mul.f32 %0, %1, %2;" : "=f"(f416) : "f"(f401), "f"(f482));
  // PTX:625 mul.f32 %f418, %f401, %f483
  asm("mul.f32 %0, %1, %2;" : "=f"(f418) : "f"(f401), "f"(f483));
  // PTX:626 mul.f32 %f420, %f401, %f484
  asm("mul.f32 %0, %1, %2;" : "=f"(f420) : "f"(f401), "f"(f484));
  // PTX:627 add.s64 %rd55, %rd42, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd55) : "l"(rd42), "l"(rd38));
  // PTX:628 red.global.add.f32 [%rd55], %f416
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))), (float)(f416));
  // PTX:629 add.s64 %rd56, %rd55, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd56) : "l"(rd55));
  // PTX:630 red.global.add.f32 [%rd56], %f418
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))), (float)(f418));
  // PTX:631 add.s64 %rd57, %rd55, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd57) : "l"(rd55));
  // PTX:632 red.global.add.f32 [%rd57], %f420
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))), (float)(f420));
  // PTX:633 mul.f32 %f425, %f401, %f485
  asm("mul.f32 %0, %1, %2;" : "=f"(f425) : "f"(f401), "f"(f485));
  // PTX:634 mul.f32 %f427, %f401, %f486
  asm("mul.f32 %0, %1, %2;" : "=f"(f427) : "f"(f401), "f"(f486));
  // PTX:635 mul.f32 %f429, %f401, %f487
  asm("mul.f32 %0, %1, %2;" : "=f"(f429) : "f"(f401), "f"(f487));
  // PTX:636 add.s64 %rd59, %rd42, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd59) : "l"(rd42), "l"(rd40));
  // PTX:637 red.global.add.f32 [%rd59], %f425
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))), (float)(f425));
  // PTX:638 add.s64 %rd60, %rd59, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd60) : "l"(rd59));
  // PTX:639 red.global.add.f32 [%rd60], %f427
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))), (float)(f427));
  // PTX:640 add.s64 %rd61, %rd59, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd61) : "l"(rd59));
  // PTX:641 red.global.add.f32 [%rd61], %f429
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))), (float)(f429));
  // PTX:643 $L__BB20_27:
L_BB20_27:;
  // PTX:644 ret
  return;
}
