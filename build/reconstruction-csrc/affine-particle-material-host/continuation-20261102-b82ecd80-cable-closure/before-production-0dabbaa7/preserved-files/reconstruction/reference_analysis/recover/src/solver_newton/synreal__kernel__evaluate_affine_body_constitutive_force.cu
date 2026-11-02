// 机械还原自 PTX：synreal::kernel::evaluate_affine_body_constitutive_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, float, synreal::AffineBodyRigidityModel, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: abe9f0221546a9ee183dffcf2edc45a7feddca496577acdad2a1438e370fddc6
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__evaluate_affine_body_constitutive_force(unsigned long long param0, unsigned long long param1, unsigned long long param2, float param3, unsigned param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440, f441, f442, f443, f444, f445, f446, f447, f448, f449, f450, f451, f452, f453, f454, f455, f456, f457, f458, f459, f460, f461, f462, f463, f464, f465, f466, f467, f468, f469;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121, r122, r123, r124, r125, r126, r127, r128, r129, r130, r131, r132, r133, r134, r135, r136, r137, r138, r139, r140, r141, r142, r143, r144, r145, r146, r147, r148, r149, r150, r151, r152, r153, r154, r155, r156, r157, r158, r159, r160, r161, r162, r163, r164, r165, r166, r167, r168, r169, r170, r171, r172, r173, r174, r175, r176, r177, r178, r179, r180, r181, r182, r183, r184, r185, r186, r187, r188, r189, r190, r191, r192, r193, r194, r195, r196, r197, r198, r199, r200, r201, r202, r203, r204;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57;
  // PTX:25 ld.param.u64 %rd11, [_ZN7synreal6kernel39evaluate_affine_body_constitutive_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPS4_mmm_param_0]
  rd11 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:26 ld.param.u64 %rd12, [_ZN7synreal6kernel39evaluate_affine_body_constitutive_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPS4_mmm_param_1]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:27 ld.param.u32 %r98, [_ZN7synreal6kernel39evaluate_affine_body_constitutive_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPS4_mmm_param_4]
  r98 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param4 + (0))));
  // PTX:28 ld.param.u64 %rd17, [_ZN7synreal6kernel39evaluate_affine_body_constitutive_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPS4_mmm_param_6]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:29 ld.param.u64 %rd15, [_ZN7synreal6kernel39evaluate_affine_body_constitutive_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPS4_mmm_param_7]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:30 ld.param.u64 %rd16, [_ZN7synreal6kernel39evaluate_affine_body_constitutive_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPS4_mmm_param_8]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:31 mov.u32 %r99, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r99) : "r"(blockIdx.x));
  // PTX:32 mov.u32 %r100, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r100) : "r"(blockDim.x));
  // PTX:33 mul.wide.u32 %rd18, %r99, %r100
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd18) : "r"(r99), "r"(r100));
  // PTX:34 mov.u32 %r101, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r101) : "r"(threadIdx.x));
  // PTX:35 cvt.u64.u32 %rd19, %r101
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd19) : "r"(r101));
  // PTX:36 add.s64 %rd1, %rd18, %rd19
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd18), "l"(rd19));
  // PTX:37 setp.ge.u64 %p1, %rd1, %rd17
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd17)));
  // PTX:38 @%p1 bra $L__BB19_27
  if (p1) { goto L_BB19_27; }
  // PTX:40 or.b64 %rd20, %rd1, %rd15
  asm("or.b64 %0, %1, %2;" : "=l"(rd20) : "l"(rd1), "l"(rd15));
  // PTX:41 and.b64 %rd21, %rd20, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd21) : "l"(rd20));
  // PTX:42 setp.eq.s64 %p2, %rd21, 0
  p2 = (((long long)(rd21)) == ((long long)(0)));
  // PTX:43 @%p2 bra $L__BB19_3
  if (p2) { goto L_BB19_3; }
  // PTX:45 div.u64 %rd56, %rd1, %rd15
  asm("div.u64 %0, %1, %2;" : "=l"(rd56) : "l"(rd1), "l"(rd15));
  // PTX:46 mul.lo.s64 %rd22, %rd56, %rd15
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd22) : "l"(rd56), "l"(rd15));
  // PTX:47 sub.s64 %rd57, %rd1, %rd22
  asm("sub.s64 %0, %1, %2;" : "=l"(rd57) : "l"(rd1), "l"(rd22));
  // PTX:48 bra.uni $L__BB19_4
  goto L_BB19_4;
  // PTX:50 $L__BB19_3:
L_BB19_3:;
  // PTX:51 cvt.u32.u64 %r102, %rd15
  asm("cvt.u32.u64 %0, %1;" : "=r"(r102) : "l"(rd15));
  // PTX:52 cvt.u32.u64 %r103, %rd1
  asm("cvt.u32.u64 %0, %1;" : "=r"(r103) : "l"(rd1));
  // PTX:53 div.u32 %r104, %r103, %r102
  asm("div.u32 %0, %1, %2;" : "=r"(r104) : "r"(r103), "r"(r102));
  // PTX:54 mul.lo.s32 %r105, %r104, %r102
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r105) : "r"(r104), "r"(r102));
  // PTX:55 sub.s32 %r106, %r103, %r105
  asm("sub.s32 %0, %1, %2;" : "=r"(r106) : "r"(r103), "r"(r105));
  // PTX:56 cvt.u64.u32 %rd56, %r104
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd56) : "r"(r104));
  // PTX:57 cvt.u64.u32 %rd57, %r106
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd57) : "r"(r106));
  // PTX:59 $L__BB19_4:
L_BB19_4:;
  // PTX:60 cvta.to.global.u64 %rd23, %rd11
  rd23 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd11));
  // PTX:61 mul.lo.s64 %rd24, %rd56, %rd16
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd24) : "l"(rd56), "l"(rd16));
  // PTX:62 cvt.u32.u64 %r1, %rd24
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd24));
  // PTX:63 cvta.to.global.u64 %rd25, %rd12
  rd25 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd12));
  // PTX:64 shl.b64 %rd26, %rd57, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd26) : "l"(rd57));
  // PTX:65 add.s64 %rd27, %rd25, %rd26
  asm("add.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd25), "l"(rd26));
  // PTX:66 ld.global.u32 %r2, [%rd27]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))));
  // PTX:67 ld.global.u32 %r107, [%rd27+4]
  r107 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (4)))));
  // PTX:68 add.s32 %r108, %r107, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r108) : "r"(r107), "r"(r1));
  // PTX:69 ld.global.u32 %r109, [%rd27+8]
  r109 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (8)))));
  // PTX:70 add.s32 %r110, %r109, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r110) : "r"(r109), "r"(r1));
  // PTX:71 ld.global.u32 %r111, [%rd27+12]
  r111 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (12)))));
  // PTX:72 add.s32 %r112, %r111, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r112) : "r"(r111), "r"(r1));
  // PTX:73 cvt.s64.s32 %rd8, %r108
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd8) : "r"(r108));
  // PTX:74 mul.wide.s32 %rd28, %r108, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd28) : "r"(r108));
  // PTX:75 add.s64 %rd29, %rd23, %rd28
  asm("add.s64 %0, %1, %2;" : "=l"(rd29) : "l"(rd23), "l"(rd28));
  // PTX:76 ld.global.f32 %f1, [%rd29]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (0)))));
  // PTX:77 ld.global.u32 %r3, [%rd29+4]
  r3 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (4)))));
  // PTX:78 ld.global.u32 %r4, [%rd29+8]
  r4 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (8)))));
  // PTX:79 cvt.s64.s32 %rd9, %r110
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd9) : "r"(r110));
  // PTX:80 mul.wide.s32 %rd30, %r110, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd30) : "r"(r110));
  // PTX:81 add.s64 %rd31, %rd23, %rd30
  asm("add.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd23), "l"(rd30));
  // PTX:82 ld.global.u32 %r5, [%rd31]
  r5 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (0)))));
  // PTX:83 ld.global.u32 %r6, [%rd31+4]
  r6 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (4)))));
  // PTX:84 ld.global.u32 %r7, [%rd31+8]
  r7 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (8)))));
  // PTX:85 cvt.s64.s32 %rd10, %r112
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd10) : "r"(r112));
  // PTX:86 mul.wide.s32 %rd32, %r112, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd32) : "r"(r112));
  // PTX:87 add.s64 %rd33, %rd23, %rd32
  asm("add.s64 %0, %1, %2;" : "=l"(rd33) : "l"(rd23), "l"(rd32));
  // PTX:88 ld.global.u32 %r8, [%rd33]
  r8 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (0)))));
  // PTX:89 ld.global.u32 %r9, [%rd33+4]
  r9 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (4)))));
  // PTX:90 ld.global.u32 %r10, [%rd33+8]
  r10 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (8)))));
  // PTX:91 setp.ne.s32 %p3, %r98, 0
  p3 = (((int)(r98)) != ((int)(0)));
  // PTX:92 mov.f32 %f452, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f452) : );
  // PTX:93 mov.f32 %f453, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f453) : );
  // PTX:94 mov.f32 %f454, %f453
  asm("mov.f32 %0, %1;" : "=f"(f454) : "f"(f453));
  // PTX:95 mov.f32 %f455, %f453
  asm("mov.f32 %0, %1;" : "=f"(f455) : "f"(f453));
  // PTX:96 mov.f32 %f456, %f452
  asm("mov.f32 %0, %1;" : "=f"(f456) : "f"(f452));
  // PTX:97 mov.f32 %f457, %f453
  asm("mov.f32 %0, %1;" : "=f"(f457) : "f"(f453));
  // PTX:98 mov.f32 %f458, %f453
  asm("mov.f32 %0, %1;" : "=f"(f458) : "f"(f453));
  // PTX:99 mov.f32 %f459, %f453
  asm("mov.f32 %0, %1;" : "=f"(f459) : "f"(f453));
  // PTX:100 mov.f32 %f460, %f452
  asm("mov.f32 %0, %1;" : "=f"(f460) : "f"(f452));
  // PTX:101 @%p3 bra $L__BB19_23
  if (p3) { goto L_BB19_23; }
  // PTX:103 mov.b32 %f2, %r3
  asm("mov.b32 %0, %1;" : "=f"(f2) : "r"(r3));
  // PTX:104 mul.f32 %f110, %f2, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f110) : "f"(f2), "f"(f2));
  // PTX:105 mov.b32 %f3, %r4
  asm("mov.b32 %0, %1;" : "=f"(f3) : "r"(r4));
  // PTX:106 fma.rn.f32 %f111, %f1, %f1, %f110
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f111) : "f"(f1), "f"(f1), "f"(f110));
  // PTX:107 fma.rn.f32 %f112, %f3, %f3, %f111
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f112) : "f"(f3), "f"(f3), "f"(f111));
  // PTX:108 mov.b32 %f4, %r5
  asm("mov.b32 %0, %1;" : "=f"(f4) : "r"(r5));
  // PTX:109 mov.b32 %f5, %r6
  asm("mov.b32 %0, %1;" : "=f"(f5) : "r"(r6));
  // PTX:110 mul.f32 %f113, %f5, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f113) : "f"(f5), "f"(f5));
  // PTX:111 mov.b32 %f6, %r7
  asm("mov.b32 %0, %1;" : "=f"(f6) : "r"(r7));
  // PTX:112 fma.rn.f32 %f114, %f4, %f4, %f113
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f114) : "f"(f4), "f"(f4), "f"(f113));
  // PTX:113 fma.rn.f32 %f115, %f6, %f6, %f114
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f115) : "f"(f6), "f"(f6), "f"(f114));
  // PTX:114 add.f32 %f116, %f112, %f115
  asm("add.f32 %0, %1, %2;" : "=f"(f116) : "f"(f112), "f"(f115));
  // PTX:115 mov.b32 %f7, %r8
  asm("mov.b32 %0, %1;" : "=f"(f7) : "r"(r8));
  // PTX:116 mov.b32 %f8, %r9
  asm("mov.b32 %0, %1;" : "=f"(f8) : "r"(r9));
  // PTX:117 mul.f32 %f117, %f8, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f117) : "f"(f8), "f"(f8));
  // PTX:118 mov.b32 %f9, %r10
  asm("mov.b32 %0, %1;" : "=f"(f9) : "r"(r10));
  // PTX:119 fma.rn.f32 %f118, %f7, %f7, %f117
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f118) : "f"(f7), "f"(f7), "f"(f117));
  // PTX:120 fma.rn.f32 %f119, %f9, %f9, %f118
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f119) : "f"(f9), "f"(f9), "f"(f118));
  // PTX:121 add.f32 %f120, %f116, %f119
  asm("add.f32 %0, %1, %2;" : "=f"(f120) : "f"(f116), "f"(f119));
  // PTX:122 div.rn.f32 %f121, %f120, 0f40400000
  asm("div.rn.f32 %0, %1, 0f40400000;" : "=f"(f121) : "f"(f120));
  // PTX:123 sqrt.rn.f32 %f10, %f121
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f10) : "f"(f121));
  // PTX:124 setp.leu.f32 %p4, %f10, 0f322BCC77
  p4 = ((isnan(((float)(f10))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f10)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:125 mov.u32 %r178, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r178) : );
  // PTX:126 mov.u32 %r179, 0
  asm("mov.u32 %0, 0;" : "=r"(r179) : );
  // PTX:127 mov.u32 %r180, %r179
  asm("mov.u32 %0, %1;" : "=r"(r180) : "r"(r179));
  // PTX:128 mov.u32 %r181, %r179
  asm("mov.u32 %0, %1;" : "=r"(r181) : "r"(r179));
  // PTX:129 mov.u32 %r182, %r178
  asm("mov.u32 %0, %1;" : "=r"(r182) : "r"(r178));
  // PTX:130 mov.u32 %r183, %r179
  asm("mov.u32 %0, %1;" : "=r"(r183) : "r"(r179));
  // PTX:131 mov.u32 %r184, %r179
  asm("mov.u32 %0, %1;" : "=r"(r184) : "r"(r179));
  // PTX:132 mov.u32 %r185, %r179
  asm("mov.u32 %0, %1;" : "=r"(r185) : "r"(r179));
  // PTX:133 mov.u32 %r186, %r178
  asm("mov.u32 %0, %1;" : "=r"(r186) : "r"(r178));
  // PTX:134 @%p4 bra $L__BB19_22
  if (p4) { goto L_BB19_22; }
  // PTX:136 abs.f32 %f122, %f10
  asm("abs.f32 %0, %1;" : "=f"(f122) : "f"(f10));
  // PTX:137 setp.geu.f32 %p5, %f122, 0f7F800000
  p5 = ((isnan(((float)(f122))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f122)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:138 @%p5 bra $L__BB19_22
  if (p5) { goto L_BB19_22; }
  // PTX:140 rcp.rn.f32 %f123, %f10
  asm("rcp.rn.f32 %0, %1;" : "=f"(f123) : "f"(f10));
  // PTX:141 mul.f32 %f443, %f1, %f123
  asm("mul.f32 %0, %1, %2;" : "=f"(f443) : "f"(f1), "f"(f123));
  // PTX:142 mul.f32 %f444, %f123, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f444) : "f"(f123), "f"(f2));
  // PTX:143 mul.f32 %f445, %f123, %f3
  asm("mul.f32 %0, %1, %2;" : "=f"(f445) : "f"(f123), "f"(f3));
  // PTX:144 mul.f32 %f446, %f123, %f4
  asm("mul.f32 %0, %1, %2;" : "=f"(f446) : "f"(f123), "f"(f4));
  // PTX:145 mul.f32 %f447, %f123, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f447) : "f"(f123), "f"(f5));
  // PTX:146 mul.f32 %f448, %f123, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f448) : "f"(f123), "f"(f6));
  // PTX:147 mul.f32 %f449, %f123, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f449) : "f"(f123), "f"(f7));
  // PTX:148 mul.f32 %f450, %f123, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f450) : "f"(f123), "f"(f8));
  // PTX:149 mul.f32 %f451, %f123, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f451) : "f"(f123), "f"(f9));
  // PTX:150 mov.u32 %r162, 0
  asm("mov.u32 %0, 0;" : "=r"(r162) : );
  // PTX:152 $L__BB19_8:
L_BB19_8:;
  // PTX:153 mul.f32 %f124, %f448, %f450
  asm("mul.f32 %0, %1, %2;" : "=f"(f124) : "f"(f448), "f"(f450));
  // PTX:154 mul.f32 %f125, %f447, %f451
  asm("mul.f32 %0, %1, %2;" : "=f"(f125) : "f"(f447), "f"(f451));
  // PTX:155 sub.f32 %f29, %f125, %f124
  asm("sub.f32 %0, %1, %2;" : "=f"(f29) : "f"(f125), "f"(f124));
  // PTX:156 mul.f32 %f126, %f446, %f451
  asm("mul.f32 %0, %1, %2;" : "=f"(f126) : "f"(f446), "f"(f451));
  // PTX:157 mul.f32 %f127, %f448, %f449
  asm("mul.f32 %0, %1, %2;" : "=f"(f127) : "f"(f448), "f"(f449));
  // PTX:158 sub.f32 %f30, %f127, %f126
  asm("sub.f32 %0, %1, %2;" : "=f"(f30) : "f"(f127), "f"(f126));
  // PTX:159 mul.f32 %f128, %f447, %f449
  asm("mul.f32 %0, %1, %2;" : "=f"(f128) : "f"(f447), "f"(f449));
  // PTX:160 mul.f32 %f129, %f446, %f450
  asm("mul.f32 %0, %1, %2;" : "=f"(f129) : "f"(f446), "f"(f450));
  // PTX:161 sub.f32 %f31, %f129, %f128
  asm("sub.f32 %0, %1, %2;" : "=f"(f31) : "f"(f129), "f"(f128));
  // PTX:162 mul.f32 %f130, %f444, %f30
  asm("mul.f32 %0, %1, %2;" : "=f"(f130) : "f"(f444), "f"(f30));
  // PTX:163 fma.rn.f32 %f131, %f443, %f29, %f130
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f131) : "f"(f443), "f"(f29), "f"(f130));
  // PTX:164 fma.rn.f32 %f32, %f445, %f31, %f131
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f32) : "f"(f445), "f"(f31), "f"(f131));
  // PTX:165 abs.f32 %f132, %f32
  asm("abs.f32 %0, %1;" : "=f"(f132) : "f"(f32));
  // PTX:166 setp.le.f32 %p6, %f132, 0f2EDBE6FF
  p6 = (!(isnan(((float)(f132))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f132)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:167 setp.geu.f32 %p7, %f132, 0f7F800000
  p7 = ((isnan(((float)(f132))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f132)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:168 or.pred %p8, %p6, %p7
  p8 = ((p6) || (p7));
  // PTX:169 @%p8 bra $L__BB19_11
  if (p8) { goto L_BB19_11; }
  // PTX:171 rcp.rn.f32 %f133, %f32
  asm("rcp.rn.f32 %0, %1;" : "=f"(f133) : "f"(f32));
  // PTX:172 mul.f32 %f134, %f444, %f451
  asm("mul.f32 %0, %1, %2;" : "=f"(f134) : "f"(f444), "f"(f451));
  // PTX:173 mul.f32 %f135, %f445, %f450
  asm("mul.f32 %0, %1, %2;" : "=f"(f135) : "f"(f445), "f"(f450));
  // PTX:174 sub.f32 %f136, %f135, %f134
  asm("sub.f32 %0, %1, %2;" : "=f"(f136) : "f"(f135), "f"(f134));
  // PTX:175 mul.f32 %f137, %f445, %f449
  asm("mul.f32 %0, %1, %2;" : "=f"(f137) : "f"(f445), "f"(f449));
  // PTX:176 mul.f32 %f138, %f443, %f451
  asm("mul.f32 %0, %1, %2;" : "=f"(f138) : "f"(f443), "f"(f451));
  // PTX:177 sub.f32 %f139, %f138, %f137
  asm("sub.f32 %0, %1, %2;" : "=f"(f139) : "f"(f138), "f"(f137));
  // PTX:178 mul.f32 %f140, %f443, %f450
  asm("mul.f32 %0, %1, %2;" : "=f"(f140) : "f"(f443), "f"(f450));
  // PTX:179 mul.f32 %f141, %f444, %f449
  asm("mul.f32 %0, %1, %2;" : "=f"(f141) : "f"(f444), "f"(f449));
  // PTX:180 sub.f32 %f142, %f141, %f140
  asm("sub.f32 %0, %1, %2;" : "=f"(f142) : "f"(f141), "f"(f140));
  // PTX:181 mul.f32 %f143, %f445, %f447
  asm("mul.f32 %0, %1, %2;" : "=f"(f143) : "f"(f445), "f"(f447));
  // PTX:182 mul.f32 %f144, %f444, %f448
  asm("mul.f32 %0, %1, %2;" : "=f"(f144) : "f"(f444), "f"(f448));
  // PTX:183 sub.f32 %f145, %f144, %f143
  asm("sub.f32 %0, %1, %2;" : "=f"(f145) : "f"(f144), "f"(f143));
  // PTX:184 mul.f32 %f146, %f443, %f448
  asm("mul.f32 %0, %1, %2;" : "=f"(f146) : "f"(f443), "f"(f448));
  // PTX:185 mul.f32 %f147, %f445, %f446
  asm("mul.f32 %0, %1, %2;" : "=f"(f147) : "f"(f445), "f"(f446));
  // PTX:186 sub.f32 %f148, %f147, %f146
  asm("sub.f32 %0, %1, %2;" : "=f"(f148) : "f"(f147), "f"(f146));
  // PTX:187 mul.f32 %f149, %f444, %f446
  asm("mul.f32 %0, %1, %2;" : "=f"(f149) : "f"(f444), "f"(f446));
  // PTX:188 mul.f32 %f150, %f443, %f447
  asm("mul.f32 %0, %1, %2;" : "=f"(f150) : "f"(f443), "f"(f447));
  // PTX:189 sub.f32 %f151, %f150, %f149
  asm("sub.f32 %0, %1, %2;" : "=f"(f151) : "f"(f150), "f"(f149));
  // PTX:190 fma.rn.f32 %f152, %f29, %f133, %f443
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f152) : "f"(f29), "f"(f133), "f"(f443));
  // PTX:191 fma.rn.f32 %f153, %f30, %f133, %f444
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f153) : "f"(f30), "f"(f133), "f"(f444));
  // PTX:192 fma.rn.f32 %f154, %f31, %f133, %f445
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f154) : "f"(f31), "f"(f133), "f"(f445));
  // PTX:193 fma.rn.f32 %f155, %f136, %f133, %f446
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f155) : "f"(f136), "f"(f133), "f"(f446));
  // PTX:194 fma.rn.f32 %f156, %f139, %f133, %f447
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f156) : "f"(f139), "f"(f133), "f"(f447));
  // PTX:195 fma.rn.f32 %f157, %f142, %f133, %f448
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f157) : "f"(f142), "f"(f133), "f"(f448));
  // PTX:196 fma.rn.f32 %f158, %f145, %f133, %f449
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f158) : "f"(f145), "f"(f133), "f"(f449));
  // PTX:197 fma.rn.f32 %f159, %f148, %f133, %f450
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f159) : "f"(f148), "f"(f133), "f"(f450));
  // PTX:198 fma.rn.f32 %f160, %f151, %f133, %f451
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f160) : "f"(f151), "f"(f133), "f"(f451));
  // PTX:199 mul.f32 %f443, %f152, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f443) : "f"(f152));
  // PTX:200 mul.f32 %f444, %f153, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f444) : "f"(f153));
  // PTX:201 mul.f32 %f445, %f154, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f445) : "f"(f154));
  // PTX:202 mul.f32 %f446, %f155, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f446) : "f"(f155));
  // PTX:203 mul.f32 %f447, %f156, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f447) : "f"(f156));
  // PTX:204 mul.f32 %f448, %f157, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f448) : "f"(f157));
  // PTX:205 mul.f32 %f449, %f158, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f449) : "f"(f158));
  // PTX:206 mul.f32 %f450, %f159, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f450) : "f"(f159));
  // PTX:207 mul.f32 %f451, %f160, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f451) : "f"(f160));
  // PTX:208 mul.f32 %f161, %f447, %f451
  asm("mul.f32 %0, %1, %2;" : "=f"(f161) : "f"(f447), "f"(f451));
  // PTX:209 mul.f32 %f162, %f448, %f450
  asm("mul.f32 %0, %1, %2;" : "=f"(f162) : "f"(f448), "f"(f450));
  // PTX:210 sub.f32 %f42, %f161, %f162
  asm("sub.f32 %0, %1, %2;" : "=f"(f42) : "f"(f161), "f"(f162));
  // PTX:211 mul.f32 %f163, %f448, %f449
  asm("mul.f32 %0, %1, %2;" : "=f"(f163) : "f"(f448), "f"(f449));
  // PTX:212 mul.f32 %f164, %f446, %f451
  asm("mul.f32 %0, %1, %2;" : "=f"(f164) : "f"(f446), "f"(f451));
  // PTX:213 sub.f32 %f43, %f163, %f164
  asm("sub.f32 %0, %1, %2;" : "=f"(f43) : "f"(f163), "f"(f164));
  // PTX:214 mul.f32 %f165, %f446, %f450
  asm("mul.f32 %0, %1, %2;" : "=f"(f165) : "f"(f446), "f"(f450));
  // PTX:215 mul.f32 %f166, %f447, %f449
  asm("mul.f32 %0, %1, %2;" : "=f"(f166) : "f"(f447), "f"(f449));
  // PTX:216 sub.f32 %f44, %f165, %f166
  asm("sub.f32 %0, %1, %2;" : "=f"(f44) : "f"(f165), "f"(f166));
  // PTX:217 mul.f32 %f167, %f444, %f43
  asm("mul.f32 %0, %1, %2;" : "=f"(f167) : "f"(f444), "f"(f43));
  // PTX:218 fma.rn.f32 %f168, %f443, %f42, %f167
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f168) : "f"(f443), "f"(f42), "f"(f167));
  // PTX:219 fma.rn.f32 %f45, %f445, %f44, %f168
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f45) : "f"(f445), "f"(f44), "f"(f168));
  // PTX:220 abs.f32 %f169, %f45
  asm("abs.f32 %0, %1;" : "=f"(f169) : "f"(f45));
  // PTX:221 setp.le.f32 %p9, %f169, 0f2EDBE6FF
  p9 = (!(isnan(((float)(f169))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f169)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:222 setp.geu.f32 %p10, %f169, 0f7F800000
  p10 = ((isnan(((float)(f169))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f169)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:223 or.pred %p11, %p9, %p10
  p11 = ((p9) || (p10));
  // PTX:224 @%p11 bra $L__BB19_11
  if (p11) { goto L_BB19_11; }
  // PTX:226 rcp.rn.f32 %f170, %f45
  asm("rcp.rn.f32 %0, %1;" : "=f"(f170) : "f"(f45));
  // PTX:227 mul.f32 %f171, %f444, %f451
  asm("mul.f32 %0, %1, %2;" : "=f"(f171) : "f"(f444), "f"(f451));
  // PTX:228 mul.f32 %f172, %f445, %f450
  asm("mul.f32 %0, %1, %2;" : "=f"(f172) : "f"(f445), "f"(f450));
  // PTX:229 sub.f32 %f173, %f172, %f171
  asm("sub.f32 %0, %1, %2;" : "=f"(f173) : "f"(f172), "f"(f171));
  // PTX:230 mul.f32 %f174, %f445, %f449
  asm("mul.f32 %0, %1, %2;" : "=f"(f174) : "f"(f445), "f"(f449));
  // PTX:231 mul.f32 %f175, %f443, %f451
  asm("mul.f32 %0, %1, %2;" : "=f"(f175) : "f"(f443), "f"(f451));
  // PTX:232 sub.f32 %f176, %f175, %f174
  asm("sub.f32 %0, %1, %2;" : "=f"(f176) : "f"(f175), "f"(f174));
  // PTX:233 mul.f32 %f177, %f443, %f450
  asm("mul.f32 %0, %1, %2;" : "=f"(f177) : "f"(f443), "f"(f450));
  // PTX:234 mul.f32 %f178, %f444, %f449
  asm("mul.f32 %0, %1, %2;" : "=f"(f178) : "f"(f444), "f"(f449));
  // PTX:235 sub.f32 %f179, %f178, %f177
  asm("sub.f32 %0, %1, %2;" : "=f"(f179) : "f"(f178), "f"(f177));
  // PTX:236 mul.f32 %f180, %f445, %f447
  asm("mul.f32 %0, %1, %2;" : "=f"(f180) : "f"(f445), "f"(f447));
  // PTX:237 mul.f32 %f181, %f444, %f448
  asm("mul.f32 %0, %1, %2;" : "=f"(f181) : "f"(f444), "f"(f448));
  // PTX:238 sub.f32 %f182, %f181, %f180
  asm("sub.f32 %0, %1, %2;" : "=f"(f182) : "f"(f181), "f"(f180));
  // PTX:239 mul.f32 %f183, %f443, %f448
  asm("mul.f32 %0, %1, %2;" : "=f"(f183) : "f"(f443), "f"(f448));
  // PTX:240 mul.f32 %f184, %f445, %f446
  asm("mul.f32 %0, %1, %2;" : "=f"(f184) : "f"(f445), "f"(f446));
  // PTX:241 sub.f32 %f185, %f184, %f183
  asm("sub.f32 %0, %1, %2;" : "=f"(f185) : "f"(f184), "f"(f183));
  // PTX:242 mul.f32 %f186, %f444, %f446
  asm("mul.f32 %0, %1, %2;" : "=f"(f186) : "f"(f444), "f"(f446));
  // PTX:243 mul.f32 %f187, %f443, %f447
  asm("mul.f32 %0, %1, %2;" : "=f"(f187) : "f"(f443), "f"(f447));
  // PTX:244 sub.f32 %f188, %f187, %f186
  asm("sub.f32 %0, %1, %2;" : "=f"(f188) : "f"(f187), "f"(f186));
  // PTX:245 fma.rn.f32 %f189, %f42, %f170, %f443
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f189) : "f"(f42), "f"(f170), "f"(f443));
  // PTX:246 fma.rn.f32 %f190, %f43, %f170, %f444
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f190) : "f"(f43), "f"(f170), "f"(f444));
  // PTX:247 fma.rn.f32 %f191, %f44, %f170, %f445
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f191) : "f"(f44), "f"(f170), "f"(f445));
  // PTX:248 fma.rn.f32 %f192, %f173, %f170, %f446
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f192) : "f"(f173), "f"(f170), "f"(f446));
  // PTX:249 fma.rn.f32 %f193, %f176, %f170, %f447
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f193) : "f"(f176), "f"(f170), "f"(f447));
  // PTX:250 fma.rn.f32 %f194, %f179, %f170, %f448
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f194) : "f"(f179), "f"(f170), "f"(f448));
  // PTX:251 fma.rn.f32 %f195, %f182, %f170, %f449
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f195) : "f"(f182), "f"(f170), "f"(f449));
  // PTX:252 fma.rn.f32 %f196, %f185, %f170, %f450
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f196) : "f"(f185), "f"(f170), "f"(f450));
  // PTX:253 fma.rn.f32 %f197, %f188, %f170, %f451
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f197) : "f"(f188), "f"(f170), "f"(f451));
  // PTX:254 mul.f32 %f443, %f189, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f443) : "f"(f189));
  // PTX:255 mul.f32 %f444, %f190, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f444) : "f"(f190));
  // PTX:256 mul.f32 %f445, %f191, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f445) : "f"(f191));
  // PTX:257 mul.f32 %f446, %f192, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f446) : "f"(f192));
  // PTX:258 mul.f32 %f447, %f193, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f447) : "f"(f193));
  // PTX:259 mul.f32 %f448, %f194, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f448) : "f"(f194));
  // PTX:260 mul.f32 %f449, %f195, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f449) : "f"(f195));
  // PTX:261 mul.f32 %f450, %f196, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f450) : "f"(f196));
  // PTX:262 mul.f32 %f451, %f197, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f451) : "f"(f197));
  // PTX:263 add.s32 %r162, %r162, 2
  asm("add.s32 %0, %1, 2;" : "=r"(r162) : "r"(r162));
  // PTX:264 setp.lt.u32 %p12, %r162, 8
  p12 = (((unsigned)(r162)) < ((unsigned)(8)));
  // PTX:265 @%p12 bra $L__BB19_8
  if (p12) { goto L_BB19_8; }
  // PTX:267 $L__BB19_11:
L_BB19_11:;
  // PTX:268 mul.f32 %f198, %f444, %f444
  asm("mul.f32 %0, %1, %2;" : "=f"(f198) : "f"(f444), "f"(f444));
  // PTX:269 fma.rn.f32 %f199, %f443, %f443, %f198
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f199) : "f"(f443), "f"(f443), "f"(f198));
  // PTX:270 fma.rn.f32 %f200, %f445, %f445, %f199
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f200) : "f"(f445), "f"(f445), "f"(f199));
  // PTX:271 sqrt.rn.f32 %f64, %f200
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f64) : "f"(f200));
  // PTX:272 setp.leu.f32 %p13, %f64, 0f00000000
  p13 = ((isnan(((float)(f64))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f64)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:273 mov.u32 %r175, 0
  asm("mov.u32 %0, 0;" : "=r"(r175) : );
  // PTX:274 mov.u32 %r163, %r175
  asm("mov.u32 %0, %1;" : "=r"(r163) : "r"(r175));
  // PTX:275 mov.u32 %r164, %r175
  asm("mov.u32 %0, %1;" : "=r"(r164) : "r"(r175));
  // PTX:276 mov.u32 %r165, %r175
  asm("mov.u32 %0, %1;" : "=r"(r165) : "r"(r175));
  // PTX:277 @%p13 bra $L__BB19_13
  if (p13) { goto L_BB19_13; }
  // PTX:279 div.rn.f32 %f201, %f443, %f64
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f201) : "f"(f443), "f"(f64));
  // PTX:280 div.rn.f32 %f202, %f444, %f64
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f202) : "f"(f444), "f"(f64));
  // PTX:281 div.rn.f32 %f203, %f445, %f64
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f203) : "f"(f445), "f"(f64));
  // PTX:282 mov.b32 %r165, %f203
  asm("mov.b32 %0, %1;" : "=r"(r165) : "f"(f203));
  // PTX:283 mov.b32 %r164, %f202
  asm("mov.b32 %0, %1;" : "=r"(r164) : "f"(f202));
  // PTX:284 mov.b32 %r163, %f201
  asm("mov.b32 %0, %1;" : "=r"(r163) : "f"(f201));
  // PTX:286 $L__BB19_13:
L_BB19_13:;
  // PTX:287 mov.b32 %f65, %r163
  asm("mov.b32 %0, %1;" : "=f"(f65) : "r"(r163));
  // PTX:288 mov.b32 %f66, %r164
  asm("mov.b32 %0, %1;" : "=f"(f66) : "r"(r164));
  // PTX:289 mul.f32 %f204, %f447, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f204) : "f"(f447), "f"(f66));
  // PTX:290 mov.b32 %f67, %r165
  asm("mov.b32 %0, %1;" : "=f"(f67) : "r"(r165));
  // PTX:291 fma.rn.f32 %f205, %f446, %f65, %f204
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f205) : "f"(f446), "f"(f65), "f"(f204));
  // PTX:292 fma.rn.f32 %f206, %f448, %f67, %f205
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f206) : "f"(f448), "f"(f67), "f"(f205));
  // PTX:293 mul.f32 %f207, %f206, %f65
  asm("mul.f32 %0, %1, %2;" : "=f"(f207) : "f"(f206), "f"(f65));
  // PTX:294 mul.f32 %f208, %f206, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f208) : "f"(f206), "f"(f66));
  // PTX:295 mul.f32 %f209, %f206, %f67
  asm("mul.f32 %0, %1, %2;" : "=f"(f209) : "f"(f206), "f"(f67));
  // PTX:296 sub.f32 %f68, %f446, %f207
  asm("sub.f32 %0, %1, %2;" : "=f"(f68) : "f"(f446), "f"(f207));
  // PTX:297 sub.f32 %f69, %f447, %f208
  asm("sub.f32 %0, %1, %2;" : "=f"(f69) : "f"(f447), "f"(f208));
  // PTX:298 sub.f32 %f70, %f448, %f209
  asm("sub.f32 %0, %1, %2;" : "=f"(f70) : "f"(f448), "f"(f209));
  // PTX:299 mul.f32 %f210, %f69, %f69
  asm("mul.f32 %0, %1, %2;" : "=f"(f210) : "f"(f69), "f"(f69));
  // PTX:300 fma.rn.f32 %f211, %f68, %f68, %f210
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f211) : "f"(f68), "f"(f68), "f"(f210));
  // PTX:301 fma.rn.f32 %f212, %f70, %f70, %f211
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f212) : "f"(f70), "f"(f70), "f"(f211));
  // PTX:302 sqrt.rn.f32 %f71, %f212
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f71) : "f"(f212));
  // PTX:303 setp.leu.f32 %p14, %f71, 0f00000000
  p14 = ((isnan(((float)(f71))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f71)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:304 mov.u32 %r176, %r175
  asm("mov.u32 %0, %1;" : "=r"(r176) : "r"(r175));
  // PTX:305 mov.u32 %r177, %r175
  asm("mov.u32 %0, %1;" : "=r"(r177) : "r"(r175));
  // PTX:306 @%p14 bra $L__BB19_15
  if (p14) { goto L_BB19_15; }
  // PTX:308 div.rn.f32 %f213, %f68, %f71
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f213) : "f"(f68), "f"(f71));
  // PTX:309 div.rn.f32 %f214, %f69, %f71
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f214) : "f"(f69), "f"(f71));
  // PTX:310 div.rn.f32 %f215, %f70, %f71
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f215) : "f"(f70), "f"(f71));
  // PTX:311 mov.b32 %r177, %f215
  asm("mov.b32 %0, %1;" : "=r"(r177) : "f"(f215));
  // PTX:312 mov.b32 %r176, %f214
  asm("mov.b32 %0, %1;" : "=r"(r176) : "f"(f214));
  // PTX:313 mov.b32 %r175, %f213
  asm("mov.b32 %0, %1;" : "=r"(r175) : "f"(f213));
  // PTX:315 $L__BB19_15:
L_BB19_15:;
  // PTX:316 mov.u32 %r178, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r178) : );
  // PTX:317 mul.f32 %f216, %f66, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f216) : "f"(f66), "f"(f66));
  // PTX:318 fma.rn.f32 %f217, %f65, %f65, %f216
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f217) : "f"(f65), "f"(f65), "f"(f216));
  // PTX:319 fma.rn.f32 %f218, %f67, %f67, %f217
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f218) : "f"(f67), "f"(f67), "f"(f217));
  // PTX:320 sqrt.rn.f32 %f219, %f218
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f219) : "f"(f218));
  // PTX:321 setp.le.f32 %p15, %f219, 0f322BCC77
  p15 = (!(isnan(((float)(f219))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f219)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:322 mov.u32 %r179, 0
  asm("mov.u32 %0, 0;" : "=r"(r179) : );
  // PTX:323 mov.u32 %r180, %r179
  asm("mov.u32 %0, %1;" : "=r"(r180) : "r"(r179));
  // PTX:324 mov.u32 %r181, %r179
  asm("mov.u32 %0, %1;" : "=r"(r181) : "r"(r179));
  // PTX:325 mov.u32 %r182, %r178
  asm("mov.u32 %0, %1;" : "=r"(r182) : "r"(r178));
  // PTX:326 mov.u32 %r183, %r179
  asm("mov.u32 %0, %1;" : "=r"(r183) : "r"(r179));
  // PTX:327 mov.u32 %r184, %r179
  asm("mov.u32 %0, %1;" : "=r"(r184) : "r"(r179));
  // PTX:328 mov.u32 %r185, %r179
  asm("mov.u32 %0, %1;" : "=r"(r185) : "r"(r179));
  // PTX:329 mov.u32 %r186, %r178
  asm("mov.u32 %0, %1;" : "=r"(r186) : "r"(r178));
  // PTX:330 @%p15 bra $L__BB19_22
  if (p15) { goto L_BB19_22; }
  // PTX:332 mov.u32 %r178, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r178) : );
  // PTX:333 mov.b32 %f72, %r175
  asm("mov.b32 %0, %1;" : "=f"(f72) : "r"(r175));
  // PTX:334 mov.b32 %f73, %r176
  asm("mov.b32 %0, %1;" : "=f"(f73) : "r"(r176));
  // PTX:335 mul.f32 %f220, %f73, %f73
  asm("mul.f32 %0, %1, %2;" : "=f"(f220) : "f"(f73), "f"(f73));
  // PTX:336 mov.b32 %f74, %r177
  asm("mov.b32 %0, %1;" : "=f"(f74) : "r"(r177));
  // PTX:337 fma.rn.f32 %f221, %f72, %f72, %f220
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f221) : "f"(f72), "f"(f72), "f"(f220));
  // PTX:338 fma.rn.f32 %f222, %f74, %f74, %f221
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f222) : "f"(f74), "f"(f74), "f"(f221));
  // PTX:339 sqrt.rn.f32 %f223, %f222
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f223) : "f"(f222));
  // PTX:340 setp.le.f32 %p16, %f223, 0f322BCC77
  p16 = (!(isnan(((float)(f223))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f223)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:341 @%p16 bra $L__BB19_22
  if (p16) { goto L_BB19_22; }
  // PTX:343 mul.f32 %f224, %f66, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f224) : "f"(f66), "f"(f74));
  // PTX:344 mul.f32 %f225, %f67, %f73
  asm("mul.f32 %0, %1, %2;" : "=f"(f225) : "f"(f67), "f"(f73));
  // PTX:345 sub.f32 %f75, %f224, %f225
  asm("sub.f32 %0, %1, %2;" : "=f"(f75) : "f"(f224), "f"(f225));
  // PTX:346 mul.f32 %f226, %f65, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f226) : "f"(f65), "f"(f74));
  // PTX:347 mul.f32 %f227, %f67, %f72
  asm("mul.f32 %0, %1, %2;" : "=f"(f227) : "f"(f67), "f"(f72));
  // PTX:348 sub.f32 %f76, %f227, %f226
  asm("sub.f32 %0, %1, %2;" : "=f"(f76) : "f"(f227), "f"(f226));
  // PTX:349 mul.f32 %f228, %f66, %f72
  asm("mul.f32 %0, %1, %2;" : "=f"(f228) : "f"(f66), "f"(f72));
  // PTX:350 mul.f32 %f229, %f65, %f73
  asm("mul.f32 %0, %1, %2;" : "=f"(f229) : "f"(f65), "f"(f73));
  // PTX:351 sub.f32 %f77, %f229, %f228
  asm("sub.f32 %0, %1, %2;" : "=f"(f77) : "f"(f229), "f"(f228));
  // PTX:352 mul.f32 %f230, %f76, %f76
  asm("mul.f32 %0, %1, %2;" : "=f"(f230) : "f"(f76), "f"(f76));
  // PTX:353 fma.rn.f32 %f231, %f75, %f75, %f230
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f231) : "f"(f75), "f"(f75), "f"(f230));
  // PTX:354 fma.rn.f32 %f232, %f77, %f77, %f231
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f232) : "f"(f77), "f"(f77), "f"(f231));
  // PTX:355 sqrt.rn.f32 %f78, %f232
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f78) : "f"(f232));
  // PTX:356 setp.leu.f32 %p17, %f78, 0f00000000
  p17 = ((isnan(((float)(f78))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f78)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:357 mov.u32 %r184, 0
  asm("mov.u32 %0, 0;" : "=r"(r184) : );
  // PTX:358 mov.u32 %r185, %r184
  asm("mov.u32 %0, %1;" : "=r"(r185) : "r"(r184));
  // PTX:359 mov.u32 %r186, %r184
  asm("mov.u32 %0, %1;" : "=r"(r186) : "r"(r184));
  // PTX:360 @%p17 bra $L__BB19_19
  if (p17) { goto L_BB19_19; }
  // PTX:362 div.rn.f32 %f233, %f75, %f78
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f233) : "f"(f75), "f"(f78));
  // PTX:363 div.rn.f32 %f234, %f76, %f78
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f234) : "f"(f76), "f"(f78));
  // PTX:364 div.rn.f32 %f235, %f77, %f78
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f235) : "f"(f77), "f"(f78));
  // PTX:365 mov.b32 %r186, %f235
  asm("mov.b32 %0, %1;" : "=r"(r186) : "f"(f235));
  // PTX:366 mov.b32 %r185, %f234
  asm("mov.b32 %0, %1;" : "=r"(r185) : "f"(f234));
  // PTX:367 mov.b32 %r184, %f233
  asm("mov.b32 %0, %1;" : "=r"(r184) : "f"(f233));
  // PTX:369 $L__BB19_19:
L_BB19_19:;
  // PTX:370 mov.b32 %f79, %r184
  asm("mov.b32 %0, %1;" : "=f"(f79) : "r"(r184));
  // PTX:371 mov.b32 %f80, %r185
  asm("mov.b32 %0, %1;" : "=f"(f80) : "r"(r185));
  // PTX:372 mul.f32 %f236, %f450, %f80
  asm("mul.f32 %0, %1, %2;" : "=f"(f236) : "f"(f450), "f"(f80));
  // PTX:373 mov.b32 %f81, %r186
  asm("mov.b32 %0, %1;" : "=f"(f81) : "r"(r186));
  // PTX:374 fma.rn.f32 %f237, %f449, %f79, %f236
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f237) : "f"(f449), "f"(f79), "f"(f236));
  // PTX:375 fma.rn.f32 %f238, %f451, %f81, %f237
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f238) : "f"(f451), "f"(f81), "f"(f237));
  // PTX:376 setp.geu.f32 %p18, %f238, 0f00000000
  p18 = ((isnan(((float)(f238))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f238)) >= ((float)(as_f32(0x00000000u)))));
  // PTX:377 @%p18 bra $L__BB19_21
  if (p18) { goto L_BB19_21; }
  // PTX:379 neg.f32 %f239, %f72
  asm("neg.f32 %0, %1;" : "=f"(f239) : "f"(f72));
  // PTX:380 mov.b32 %r175, %f239
  asm("mov.b32 %0, %1;" : "=r"(r175) : "f"(f239));
  // PTX:381 neg.f32 %f240, %f73
  asm("neg.f32 %0, %1;" : "=f"(f240) : "f"(f73));
  // PTX:382 mov.b32 %r176, %f240
  asm("mov.b32 %0, %1;" : "=r"(r176) : "f"(f240));
  // PTX:383 neg.f32 %f241, %f74
  asm("neg.f32 %0, %1;" : "=f"(f241) : "f"(f74));
  // PTX:384 mov.b32 %r177, %f241
  asm("mov.b32 %0, %1;" : "=r"(r177) : "f"(f241));
  // PTX:385 neg.f32 %f242, %f79
  asm("neg.f32 %0, %1;" : "=f"(f242) : "f"(f79));
  // PTX:386 mov.b32 %r184, %f242
  asm("mov.b32 %0, %1;" : "=r"(r184) : "f"(f242));
  // PTX:387 neg.f32 %f243, %f80
  asm("neg.f32 %0, %1;" : "=f"(f243) : "f"(f80));
  // PTX:388 mov.b32 %r185, %f243
  asm("mov.b32 %0, %1;" : "=r"(r185) : "f"(f243));
  // PTX:389 neg.f32 %f244, %f81
  asm("neg.f32 %0, %1;" : "=f"(f244) : "f"(f81));
  // PTX:390 mov.b32 %r186, %f244
  asm("mov.b32 %0, %1;" : "=r"(r186) : "f"(f244));
  // PTX:392 $L__BB19_21:
L_BB19_21:;
  // PTX:393 mov.u32 %r178, %r163
  asm("mov.u32 %0, %1;" : "=r"(r178) : "r"(r163));
  // PTX:394 mov.u32 %r179, %r164
  asm("mov.u32 %0, %1;" : "=r"(r179) : "r"(r164));
  // PTX:395 mov.u32 %r180, %r165
  asm("mov.u32 %0, %1;" : "=r"(r180) : "r"(r165));
  // PTX:396 mov.u32 %r181, %r175
  asm("mov.u32 %0, %1;" : "=r"(r181) : "r"(r175));
  // PTX:397 mov.u32 %r182, %r176
  asm("mov.u32 %0, %1;" : "=r"(r182) : "r"(r176));
  // PTX:398 mov.u32 %r183, %r177
  asm("mov.u32 %0, %1;" : "=r"(r183) : "r"(r177));
  // PTX:400 $L__BB19_22:
L_BB19_22:;
  // PTX:401 mov.b32 %f460, %r178
  asm("mov.b32 %0, %1;" : "=f"(f460) : "r"(r178));
  // PTX:402 mov.b32 %f457, %r181
  asm("mov.b32 %0, %1;" : "=f"(f457) : "r"(r181));
  // PTX:403 mov.b32 %f454, %r184
  asm("mov.b32 %0, %1;" : "=f"(f454) : "r"(r184));
  // PTX:404 mov.b32 %f459, %r179
  asm("mov.b32 %0, %1;" : "=f"(f459) : "r"(r179));
  // PTX:405 mov.b32 %f456, %r182
  asm("mov.b32 %0, %1;" : "=f"(f456) : "r"(r182));
  // PTX:406 mov.b32 %f453, %r185
  asm("mov.b32 %0, %1;" : "=f"(f453) : "r"(r185));
  // PTX:407 mov.b32 %f458, %r180
  asm("mov.b32 %0, %1;" : "=f"(f458) : "r"(r180));
  // PTX:408 mov.b32 %f455, %r183
  asm("mov.b32 %0, %1;" : "=f"(f455) : "r"(r183));
  // PTX:409 mov.b32 %f452, %r186
  asm("mov.b32 %0, %1;" : "=f"(f452) : "r"(r186));
  // PTX:411 $L__BB19_23:
L_BB19_23:;
  // PTX:412 ld.param.u32 %r159, [_ZN7synreal6kernel39evaluate_affine_body_constitutive_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPS4_mmm_param_4]
  r159 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param4 + (0))));
  // PTX:413 setp.eq.s32 %p19, %r159, 1
  p19 = (((int)(r159)) == ((int)(1)));
  // PTX:414 add.s32 %r70, %r2, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r70) : "r"(r2), "r"(r1));
  // PTX:415 @%p19 bra $L__BB19_25
  if (p19) { goto L_BB19_25; }
  // PTX:416 bra.uni $L__BB19_24
  goto L_BB19_24;
  // PTX:418 $L__BB19_25:
L_BB19_25:;
  // PTX:419 mov.b32 %f325, %r3
  asm("mov.b32 %0, %1;" : "=f"(f325) : "r"(r3));
  // PTX:420 mov.b32 %f326, %r4
  asm("mov.b32 %0, %1;" : "=f"(f326) : "r"(r4));
  // PTX:421 mov.b32 %f327, %r5
  asm("mov.b32 %0, %1;" : "=f"(f327) : "r"(r5));
  // PTX:422 mul.f32 %f328, %f327, %f327
  asm("mul.f32 %0, %1, %2;" : "=f"(f328) : "f"(f327), "f"(f327));
  // PTX:423 mov.b32 %f329, %r6
  asm("mov.b32 %0, %1;" : "=f"(f329) : "r"(r6));
  // PTX:424 mul.f32 %f330, %f327, %f329
  asm("mul.f32 %0, %1, %2;" : "=f"(f330) : "f"(f327), "f"(f329));
  // PTX:425 mov.b32 %f331, %r7
  asm("mov.b32 %0, %1;" : "=f"(f331) : "r"(r7));
  // PTX:426 mul.f32 %f332, %f327, %f331
  asm("mul.f32 %0, %1, %2;" : "=f"(f332) : "f"(f327), "f"(f331));
  // PTX:427 fma.rn.f32 %f333, %f1, %f1, %f328
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f333) : "f"(f1), "f"(f1), "f"(f328));
  // PTX:428 fma.rn.f32 %f334, %f1, %f325, %f330
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f334) : "f"(f1), "f"(f325), "f"(f330));
  // PTX:429 fma.rn.f32 %f335, %f1, %f326, %f332
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f335) : "f"(f1), "f"(f326), "f"(f332));
  // PTX:430 mov.b32 %f336, %r8
  asm("mov.b32 %0, %1;" : "=f"(f336) : "r"(r8));
  // PTX:431 mov.b32 %f337, %r9
  asm("mov.b32 %0, %1;" : "=f"(f337) : "r"(r9));
  // PTX:432 mov.b32 %f338, %r10
  asm("mov.b32 %0, %1;" : "=f"(f338) : "r"(r10));
  // PTX:433 fma.rn.f32 %f339, %f336, %f336, %f333
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f339) : "f"(f336), "f"(f336), "f"(f333));
  // PTX:434 fma.rn.f32 %f340, %f336, %f337, %f334
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f340) : "f"(f336), "f"(f337), "f"(f334));
  // PTX:435 fma.rn.f32 %f341, %f336, %f338, %f335
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f341) : "f"(f336), "f"(f338), "f"(f335));
  // PTX:436 mul.f32 %f342, %f329, %f329
  asm("mul.f32 %0, %1, %2;" : "=f"(f342) : "f"(f329), "f"(f329));
  // PTX:437 mul.f32 %f343, %f329, %f331
  asm("mul.f32 %0, %1, %2;" : "=f"(f343) : "f"(f329), "f"(f331));
  // PTX:438 fma.rn.f32 %f344, %f325, %f325, %f342
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f344) : "f"(f325), "f"(f325), "f"(f342));
  // PTX:439 fma.rn.f32 %f345, %f325, %f326, %f343
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f345) : "f"(f325), "f"(f326), "f"(f343));
  // PTX:440 fma.rn.f32 %f346, %f337, %f337, %f344
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f346) : "f"(f337), "f"(f337), "f"(f344));
  // PTX:441 fma.rn.f32 %f347, %f337, %f338, %f345
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f347) : "f"(f337), "f"(f338), "f"(f345));
  // PTX:442 mul.f32 %f348, %f331, %f331
  asm("mul.f32 %0, %1, %2;" : "=f"(f348) : "f"(f331), "f"(f331));
  // PTX:443 fma.rn.f32 %f349, %f326, %f326, %f348
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f349) : "f"(f326), "f"(f326), "f"(f348));
  // PTX:444 fma.rn.f32 %f350, %f338, %f338, %f349
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f350) : "f"(f338), "f"(f338), "f"(f349));
  // PTX:445 add.f32 %f351, %f339, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f351) : "f"(f339));
  // PTX:446 add.f32 %f352, %f346, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f352) : "f"(f346));
  // PTX:447 add.f32 %f353, %f350, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f353) : "f"(f350));
  // PTX:448 mul.f32 %f354, %f340, %f325
  asm("mul.f32 %0, %1, %2;" : "=f"(f354) : "f"(f340), "f"(f325));
  // PTX:449 mul.f32 %f355, %f352, %f325
  asm("mul.f32 %0, %1, %2;" : "=f"(f355) : "f"(f352), "f"(f325));
  // PTX:450 mul.f32 %f356, %f347, %f325
  asm("mul.f32 %0, %1, %2;" : "=f"(f356) : "f"(f347), "f"(f325));
  // PTX:451 fma.rn.f32 %f357, %f1, %f351, %f354
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f357) : "f"(f1), "f"(f351), "f"(f354));
  // PTX:452 fma.rn.f32 %f358, %f1, %f340, %f355
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f358) : "f"(f1), "f"(f340), "f"(f355));
  // PTX:453 fma.rn.f32 %f359, %f1, %f341, %f356
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f359) : "f"(f1), "f"(f341), "f"(f356));
  // PTX:454 fma.rn.f32 %f461, %f341, %f326, %f357
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f461) : "f"(f341), "f"(f326), "f"(f357));
  // PTX:455 fma.rn.f32 %f462, %f347, %f326, %f358
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f462) : "f"(f347), "f"(f326), "f"(f358));
  // PTX:456 fma.rn.f32 %f463, %f353, %f326, %f359
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f463) : "f"(f353), "f"(f326), "f"(f359));
  // PTX:457 mul.f32 %f363, %f340, %f329
  asm("mul.f32 %0, %1, %2;" : "=f"(f363) : "f"(f340), "f"(f329));
  // PTX:458 mul.f32 %f364, %f352, %f329
  asm("mul.f32 %0, %1, %2;" : "=f"(f364) : "f"(f352), "f"(f329));
  // PTX:459 mul.f32 %f365, %f347, %f329
  asm("mul.f32 %0, %1, %2;" : "=f"(f365) : "f"(f347), "f"(f329));
  // PTX:460 fma.rn.f32 %f366, %f351, %f327, %f363
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f366) : "f"(f351), "f"(f327), "f"(f363));
  // PTX:461 fma.rn.f32 %f367, %f340, %f327, %f364
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f367) : "f"(f340), "f"(f327), "f"(f364));
  // PTX:462 fma.rn.f32 %f368, %f341, %f327, %f365
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f368) : "f"(f341), "f"(f327), "f"(f365));
  // PTX:463 fma.rn.f32 %f464, %f341, %f331, %f366
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f464) : "f"(f341), "f"(f331), "f"(f366));
  // PTX:464 fma.rn.f32 %f465, %f347, %f331, %f367
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f465) : "f"(f347), "f"(f331), "f"(f367));
  // PTX:465 fma.rn.f32 %f466, %f353, %f331, %f368
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f466) : "f"(f353), "f"(f331), "f"(f368));
  // PTX:466 mul.f32 %f372, %f340, %f337
  asm("mul.f32 %0, %1, %2;" : "=f"(f372) : "f"(f340), "f"(f337));
  // PTX:467 mul.f32 %f373, %f352, %f337
  asm("mul.f32 %0, %1, %2;" : "=f"(f373) : "f"(f352), "f"(f337));
  // PTX:468 mul.f32 %f374, %f347, %f337
  asm("mul.f32 %0, %1, %2;" : "=f"(f374) : "f"(f347), "f"(f337));
  // PTX:469 fma.rn.f32 %f375, %f351, %f336, %f372
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f375) : "f"(f351), "f"(f336), "f"(f372));
  // PTX:470 fma.rn.f32 %f376, %f340, %f336, %f373
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f376) : "f"(f340), "f"(f336), "f"(f373));
  // PTX:471 fma.rn.f32 %f377, %f341, %f336, %f374
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f377) : "f"(f341), "f"(f336), "f"(f374));
  // PTX:472 fma.rn.f32 %f467, %f341, %f338, %f375
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f467) : "f"(f341), "f"(f338), "f"(f375));
  // PTX:473 fma.rn.f32 %f468, %f347, %f338, %f376
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f468) : "f"(f347), "f"(f338), "f"(f376));
  // PTX:474 fma.rn.f32 %f469, %f353, %f338, %f377
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f469) : "f"(f353), "f"(f338), "f"(f377));
  // PTX:475 bra.uni $L__BB19_26
  goto L_BB19_26;
  // PTX:477 $L__BB19_24:
L_BB19_24:;
  // PTX:478 mul.f32 %f245, %f1, %f460
  asm("mul.f32 %0, %1, %2;" : "=f"(f245) : "f"(f1), "f"(f460));
  // PTX:479 mov.b32 %f246, %r3
  asm("mov.b32 %0, %1;" : "=f"(f246) : "r"(r3));
  // PTX:480 fma.rn.f32 %f247, %f459, %f246, %f245
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f247) : "f"(f459), "f"(f246), "f"(f245));
  // PTX:481 mul.f32 %f248, %f1, %f457
  asm("mul.f32 %0, %1, %2;" : "=f"(f248) : "f"(f1), "f"(f457));
  // PTX:482 fma.rn.f32 %f249, %f456, %f246, %f248
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f249) : "f"(f456), "f"(f246), "f"(f248));
  // PTX:483 mul.f32 %f250, %f1, %f454
  asm("mul.f32 %0, %1, %2;" : "=f"(f250) : "f"(f1), "f"(f454));
  // PTX:484 fma.rn.f32 %f251, %f453, %f246, %f250
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f251) : "f"(f453), "f"(f246), "f"(f250));
  // PTX:485 mov.b32 %f252, %r4
  asm("mov.b32 %0, %1;" : "=f"(f252) : "r"(r4));
  // PTX:486 fma.rn.f32 %f253, %f458, %f252, %f247
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f253) : "f"(f458), "f"(f252), "f"(f247));
  // PTX:487 fma.rn.f32 %f254, %f455, %f252, %f249
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f254) : "f"(f455), "f"(f252), "f"(f249));
  // PTX:488 fma.rn.f32 %f255, %f452, %f252, %f251
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f255) : "f"(f452), "f"(f252), "f"(f251));
  // PTX:489 mov.b32 %f256, %r5
  asm("mov.b32 %0, %1;" : "=f"(f256) : "r"(r5));
  // PTX:490 mul.f32 %f257, %f460, %f256
  asm("mul.f32 %0, %1, %2;" : "=f"(f257) : "f"(f460), "f"(f256));
  // PTX:491 mul.f32 %f258, %f457, %f256
  asm("mul.f32 %0, %1, %2;" : "=f"(f258) : "f"(f457), "f"(f256));
  // PTX:492 mul.f32 %f259, %f454, %f256
  asm("mul.f32 %0, %1, %2;" : "=f"(f259) : "f"(f454), "f"(f256));
  // PTX:493 mov.b32 %f260, %r6
  asm("mov.b32 %0, %1;" : "=f"(f260) : "r"(r6));
  // PTX:494 fma.rn.f32 %f261, %f459, %f260, %f257
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f261) : "f"(f459), "f"(f260), "f"(f257));
  // PTX:495 fma.rn.f32 %f262, %f456, %f260, %f258
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f262) : "f"(f456), "f"(f260), "f"(f258));
  // PTX:496 fma.rn.f32 %f263, %f453, %f260, %f259
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f263) : "f"(f453), "f"(f260), "f"(f259));
  // PTX:497 mov.b32 %f264, %r7
  asm("mov.b32 %0, %1;" : "=f"(f264) : "r"(r7));
  // PTX:498 fma.rn.f32 %f265, %f458, %f264, %f261
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f265) : "f"(f458), "f"(f264), "f"(f261));
  // PTX:499 fma.rn.f32 %f266, %f455, %f264, %f262
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f266) : "f"(f455), "f"(f264), "f"(f262));
  // PTX:500 fma.rn.f32 %f267, %f452, %f264, %f263
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f267) : "f"(f452), "f"(f264), "f"(f263));
  // PTX:501 mov.b32 %f268, %r8
  asm("mov.b32 %0, %1;" : "=f"(f268) : "r"(r8));
  // PTX:502 mul.f32 %f269, %f460, %f268
  asm("mul.f32 %0, %1, %2;" : "=f"(f269) : "f"(f460), "f"(f268));
  // PTX:503 mul.f32 %f270, %f457, %f268
  asm("mul.f32 %0, %1, %2;" : "=f"(f270) : "f"(f457), "f"(f268));
  // PTX:504 mul.f32 %f271, %f454, %f268
  asm("mul.f32 %0, %1, %2;" : "=f"(f271) : "f"(f454), "f"(f268));
  // PTX:505 mov.b32 %f272, %r9
  asm("mov.b32 %0, %1;" : "=f"(f272) : "r"(r9));
  // PTX:506 fma.rn.f32 %f273, %f459, %f272, %f269
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f273) : "f"(f459), "f"(f272), "f"(f269));
  // PTX:507 fma.rn.f32 %f274, %f456, %f272, %f270
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f274) : "f"(f456), "f"(f272), "f"(f270));
  // PTX:508 fma.rn.f32 %f275, %f453, %f272, %f271
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f275) : "f"(f453), "f"(f272), "f"(f271));
  // PTX:509 mov.b32 %f276, %r10
  asm("mov.b32 %0, %1;" : "=f"(f276) : "r"(r10));
  // PTX:510 fma.rn.f32 %f277, %f458, %f276, %f273
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f277) : "f"(f458), "f"(f276), "f"(f273));
  // PTX:511 fma.rn.f32 %f278, %f455, %f276, %f274
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f278) : "f"(f455), "f"(f276), "f"(f274));
  // PTX:512 fma.rn.f32 %f279, %f452, %f276, %f275
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f279) : "f"(f452), "f"(f276), "f"(f275));
  // PTX:513 add.f32 %f280, %f253, %f253
  asm("add.f32 %0, %1, %2;" : "=f"(f280) : "f"(f253), "f"(f253));
  // PTX:514 add.f32 %f281, %f254, %f265
  asm("add.f32 %0, %1, %2;" : "=f"(f281) : "f"(f254), "f"(f265));
  // PTX:515 add.f32 %f282, %f255, %f277
  asm("add.f32 %0, %1, %2;" : "=f"(f282) : "f"(f255), "f"(f277));
  // PTX:516 add.f32 %f283, %f266, %f266
  asm("add.f32 %0, %1, %2;" : "=f"(f283) : "f"(f266), "f"(f266));
  // PTX:517 add.f32 %f284, %f267, %f278
  asm("add.f32 %0, %1, %2;" : "=f"(f284) : "f"(f267), "f"(f278));
  // PTX:518 add.f32 %f285, %f279, %f279
  asm("add.f32 %0, %1, %2;" : "=f"(f285) : "f"(f279), "f"(f279));
  // PTX:519 add.f32 %f286, %f280, 0fC0000000
  asm("add.f32 %0, %1, 0fC0000000;" : "=f"(f286) : "f"(f280));
  // PTX:520 add.f32 %f287, %f283, 0fC0000000
  asm("add.f32 %0, %1, 0fC0000000;" : "=f"(f287) : "f"(f283));
  // PTX:521 add.f32 %f288, %f285, 0fC0000000
  asm("add.f32 %0, %1, 0fC0000000;" : "=f"(f288) : "f"(f285));
  // PTX:522 add.f32 %f289, %f266, %f253
  asm("add.f32 %0, %1, %2;" : "=f"(f289) : "f"(f266), "f"(f253));
  // PTX:523 add.f32 %f290, %f279, %f289
  asm("add.f32 %0, %1, %2;" : "=f"(f290) : "f"(f279), "f"(f289));
  // PTX:524 add.f32 %f291, %f290, 0fC0400000
  asm("add.f32 %0, %1, 0fC0400000;" : "=f"(f291) : "f"(f290));
  // PTX:525 add.f32 %f292, %f286, %f291
  asm("add.f32 %0, %1, %2;" : "=f"(f292) : "f"(f286), "f"(f291));
  // PTX:526 fma.rn.f32 %f293, %f291, 0f00000000, %f281
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f293) : "f"(f291), "f"(f281));
  // PTX:527 fma.rn.f32 %f294, %f291, 0f00000000, %f282
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f294) : "f"(f291), "f"(f282));
  // PTX:528 add.f32 %f295, %f287, %f291
  asm("add.f32 %0, %1, %2;" : "=f"(f295) : "f"(f287), "f"(f291));
  // PTX:529 fma.rn.f32 %f296, %f291, 0f00000000, %f284
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f296) : "f"(f291), "f"(f284));
  // PTX:530 add.f32 %f297, %f288, %f291
  asm("add.f32 %0, %1, %2;" : "=f"(f297) : "f"(f288), "f"(f291));
  // PTX:531 mul.f32 %f298, %f457, %f293
  asm("mul.f32 %0, %1, %2;" : "=f"(f298) : "f"(f457), "f"(f293));
  // PTX:532 mul.f32 %f299, %f456, %f293
  asm("mul.f32 %0, %1, %2;" : "=f"(f299) : "f"(f456), "f"(f293));
  // PTX:533 mul.f32 %f300, %f455, %f293
  asm("mul.f32 %0, %1, %2;" : "=f"(f300) : "f"(f455), "f"(f293));
  // PTX:534 fma.rn.f32 %f301, %f460, %f292, %f298
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f301) : "f"(f460), "f"(f292), "f"(f298));
  // PTX:535 fma.rn.f32 %f302, %f459, %f292, %f299
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f302) : "f"(f459), "f"(f292), "f"(f299));
  // PTX:536 fma.rn.f32 %f303, %f458, %f292, %f300
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f303) : "f"(f458), "f"(f292), "f"(f300));
  // PTX:537 fma.rn.f32 %f461, %f454, %f294, %f301
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f461) : "f"(f454), "f"(f294), "f"(f301));
  // PTX:538 fma.rn.f32 %f462, %f453, %f294, %f302
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f462) : "f"(f453), "f"(f294), "f"(f302));
  // PTX:539 fma.rn.f32 %f463, %f452, %f294, %f303
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f463) : "f"(f452), "f"(f294), "f"(f303));
  // PTX:540 mul.f32 %f307, %f460, %f293
  asm("mul.f32 %0, %1, %2;" : "=f"(f307) : "f"(f460), "f"(f293));
  // PTX:541 mul.f32 %f308, %f459, %f293
  asm("mul.f32 %0, %1, %2;" : "=f"(f308) : "f"(f459), "f"(f293));
  // PTX:542 mul.f32 %f309, %f458, %f293
  asm("mul.f32 %0, %1, %2;" : "=f"(f309) : "f"(f458), "f"(f293));
  // PTX:543 fma.rn.f32 %f310, %f457, %f295, %f307
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f310) : "f"(f457), "f"(f295), "f"(f307));
  // PTX:544 fma.rn.f32 %f311, %f456, %f295, %f308
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f311) : "f"(f456), "f"(f295), "f"(f308));
  // PTX:545 fma.rn.f32 %f312, %f455, %f295, %f309
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f312) : "f"(f455), "f"(f295), "f"(f309));
  // PTX:546 fma.rn.f32 %f464, %f454, %f296, %f310
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f464) : "f"(f454), "f"(f296), "f"(f310));
  // PTX:547 fma.rn.f32 %f465, %f453, %f296, %f311
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f465) : "f"(f453), "f"(f296), "f"(f311));
  // PTX:548 fma.rn.f32 %f466, %f452, %f296, %f312
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f466) : "f"(f452), "f"(f296), "f"(f312));
  // PTX:549 mul.f32 %f316, %f457, %f296
  asm("mul.f32 %0, %1, %2;" : "=f"(f316) : "f"(f457), "f"(f296));
  // PTX:550 mul.f32 %f317, %f456, %f296
  asm("mul.f32 %0, %1, %2;" : "=f"(f317) : "f"(f456), "f"(f296));
  // PTX:551 mul.f32 %f318, %f455, %f296
  asm("mul.f32 %0, %1, %2;" : "=f"(f318) : "f"(f455), "f"(f296));
  // PTX:552 fma.rn.f32 %f319, %f460, %f294, %f316
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f319) : "f"(f460), "f"(f294), "f"(f316));
  // PTX:553 fma.rn.f32 %f320, %f459, %f294, %f317
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f320) : "f"(f459), "f"(f294), "f"(f317));
  // PTX:554 fma.rn.f32 %f321, %f458, %f294, %f318
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f321) : "f"(f458), "f"(f294), "f"(f318));
  // PTX:555 fma.rn.f32 %f467, %f454, %f297, %f319
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f467) : "f"(f454), "f"(f297), "f"(f319));
  // PTX:556 fma.rn.f32 %f468, %f453, %f297, %f320
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f468) : "f"(f453), "f"(f297), "f"(f320));
  // PTX:557 fma.rn.f32 %f469, %f452, %f297, %f321
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f469) : "f"(f452), "f"(f297), "f"(f321));
  // PTX:559 $L__BB19_26:
L_BB19_26:;
  // PTX:560 ld.param.f32 %f433, [_ZN7synreal6kernel39evaluate_affine_body_constitutive_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPS4_mmm_param_3]
  f433 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param3 + (0))));
  // PTX:561 ld.param.u64 %rd55, [_ZN7synreal6kernel39evaluate_affine_body_constitutive_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPS4_mmm_param_2]
  rd55 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:562 ld.param.u64 %rd54, [_ZN7synreal6kernel39evaluate_affine_body_constitutive_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPS4_mmm_param_5]
  rd54 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:563 cvta.to.global.u64 %rd34, %rd54
  rd34 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd54));
  // PTX:564 cvta.to.global.u64 %rd35, %rd55
  rd35 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd55));
  // PTX:565 shl.b64 %rd36, %rd57, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd36) : "l"(rd57));
  // PTX:566 add.s64 %rd37, %rd35, %rd36
  asm("add.s64 %0, %1, %2;" : "=l"(rd37) : "l"(rd35), "l"(rd36));
  // PTX:567 ld.global.f32 %f381, [%rd37]
  f381 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (0)))));
  // PTX:568 mul.f32 %f382, %f381, %f433
  asm("mul.f32 %0, %1, %2;" : "=f"(f382) : "f"(f381), "f"(f433));
  // PTX:569 neg.f32 %f383, %f382
  asm("neg.f32 %0, %1;" : "=f"(f383) : "f"(f382));
  // PTX:570 mul.f32 %f384, %f382, 0f80000000
  asm("mul.f32 %0, %1, 0f80000000;" : "=f"(f384) : "f"(f382));
  // PTX:571 mul.wide.s32 %rd38, %r70, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd38) : "r"(r70));
  // PTX:572 add.s64 %rd39, %rd34, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd39) : "l"(rd34), "l"(rd38));
  // PTX:573 red.global.add.f32 [%rd39], %f384
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (0)))), (float)(f384));
  // PTX:574 add.s64 %rd40, %rd39, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd40) : "l"(rd39));
  // PTX:575 red.global.add.f32 [%rd40], %f384
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (0)))), (float)(f384));
  // PTX:576 add.s64 %rd41, %rd39, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd41) : "l"(rd39));
  // PTX:577 red.global.add.f32 [%rd41], %f384
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (0)))), (float)(f384));
  // PTX:578 mul.f32 %f389, %f461, %f383
  asm("mul.f32 %0, %1, %2;" : "=f"(f389) : "f"(f461), "f"(f383));
  // PTX:579 mul.f32 %f391, %f462, %f383
  asm("mul.f32 %0, %1, %2;" : "=f"(f391) : "f"(f462), "f"(f383));
  // PTX:580 mul.f32 %f393, %f463, %f383
  asm("mul.f32 %0, %1, %2;" : "=f"(f393) : "f"(f463), "f"(f383));
  // PTX:581 mul.lo.s64 %rd42, %rd8, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd42) : "l"(rd8));
  // PTX:582 add.s64 %rd43, %rd34, %rd42
  asm("add.s64 %0, %1, %2;" : "=l"(rd43) : "l"(rd34), "l"(rd42));
  // PTX:583 red.global.add.f32 [%rd43], %f389
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (0)))), (float)(f389));
  // PTX:584 add.s64 %rd44, %rd43, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd44) : "l"(rd43));
  // PTX:585 red.global.add.f32 [%rd44], %f391
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))), (float)(f391));
  // PTX:586 add.s64 %rd45, %rd43, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd45) : "l"(rd43));
  // PTX:587 red.global.add.f32 [%rd45], %f393
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))), (float)(f393));
  // PTX:588 mul.f32 %f398, %f464, %f383
  asm("mul.f32 %0, %1, %2;" : "=f"(f398) : "f"(f464), "f"(f383));
  // PTX:589 mul.f32 %f400, %f465, %f383
  asm("mul.f32 %0, %1, %2;" : "=f"(f400) : "f"(f465), "f"(f383));
  // PTX:590 mul.f32 %f402, %f466, %f383
  asm("mul.f32 %0, %1, %2;" : "=f"(f402) : "f"(f466), "f"(f383));
  // PTX:591 mul.lo.s64 %rd46, %rd9, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd46) : "l"(rd9));
  // PTX:592 add.s64 %rd47, %rd34, %rd46
  asm("add.s64 %0, %1, %2;" : "=l"(rd47) : "l"(rd34), "l"(rd46));
  // PTX:593 red.global.add.f32 [%rd47], %f398
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))), (float)(f398));
  // PTX:594 add.s64 %rd48, %rd47, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd48) : "l"(rd47));
  // PTX:595 red.global.add.f32 [%rd48], %f400
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))), (float)(f400));
  // PTX:596 add.s64 %rd49, %rd47, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd49) : "l"(rd47));
  // PTX:597 red.global.add.f32 [%rd49], %f402
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))), (float)(f402));
  // PTX:598 mul.f32 %f407, %f467, %f383
  asm("mul.f32 %0, %1, %2;" : "=f"(f407) : "f"(f467), "f"(f383));
  // PTX:599 mul.f32 %f409, %f468, %f383
  asm("mul.f32 %0, %1, %2;" : "=f"(f409) : "f"(f468), "f"(f383));
  // PTX:600 mul.f32 %f411, %f469, %f383
  asm("mul.f32 %0, %1, %2;" : "=f"(f411) : "f"(f469), "f"(f383));
  // PTX:601 mul.lo.s64 %rd50, %rd10, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd50) : "l"(rd10));
  // PTX:602 add.s64 %rd51, %rd34, %rd50
  asm("add.s64 %0, %1, %2;" : "=l"(rd51) : "l"(rd34), "l"(rd50));
  // PTX:603 red.global.add.f32 [%rd51], %f407
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))), (float)(f407));
  // PTX:604 add.s64 %rd52, %rd51, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd52) : "l"(rd51));
  // PTX:605 red.global.add.f32 [%rd52], %f409
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))), (float)(f409));
  // PTX:606 add.s64 %rd53, %rd51, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd53) : "l"(rd51));
  // PTX:607 red.global.add.f32 [%rd53], %f411
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))), (float)(f411));
  // PTX:609 $L__BB19_27:
L_BB19_27:;
  // PTX:610 ret
  return;
}
