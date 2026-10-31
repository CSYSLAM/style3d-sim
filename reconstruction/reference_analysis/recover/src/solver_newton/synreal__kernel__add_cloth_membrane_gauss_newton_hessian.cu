// 机械还原自 PTX：synreal::kernel::add_cloth_membrane_gauss_newton_hessian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, glm::mat<2, 2, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 762c17eb68f544506da4291dfc02f5995bec48c9041dd66302efa65be5b37257
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__add_cloth_membrane_gauss_newton_hessian(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10, unsigned long long param11, unsigned long long param12) {
  unsigned long long SP, SPL, rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135, rd136, rd137, rd138, rd139, rd140, rd141, rd142, rd143, rd144, rd145, rd146, rd147, rd148, rd149, rd150, rd151, rd152, rd153, rd154, rd155, rd156, rd157, rd158, rd159, rd160, rd161, rd162, rd163, rd164, rd165, rd166, rd167, rd168, rd169, rd170, rd171, rd172, rd173, rd174, rd175, rd176, rd177, rd178, rd179, rd180, rd181, rd182, rd183, rd184, rd185, rd186, rd187, rd188, rd189, rd190, rd191, rd192, rd193, rd194, rd195, rd196, rd197, rd198, rd199, rd200, rd201, rd202, rd203, rd204, rd205, rd206, rd207, rd208, rd209, rd210, rd211, rd212, rd213, rd214, rd215, rd216, rd217, rd218, rd219, rd220, rd221, rd222, rd223, rd224, rd225, rd226, rd227, rd228, rd229, rd230, rd231, rd232, rd233, rd234, rd235, rd236, rd237, rd238, rd239, rd240, rd241, rd242;
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440, f441, f442, f443, f444, f445, f446;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121;
  __align__(4) unsigned char __local_depot52[144];
  // PTX:32 mov.u64 %SPL, __local_depot52
  SPL = (unsigned long long)__cvta_generic_to_local(__local_depot52);
  // PTX:33 ld.param.u64 %rd69, [_ZN7synreal6kernel39add_cloth_membrane_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPKNS1_3matILi2ELi2EfLS3_0EEEPKfS6_PNSA_ILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_0]
  rd69 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:34 ld.param.u64 %rd70, [_ZN7synreal6kernel39add_cloth_membrane_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPKNS1_3matILi2ELi2EfLS3_0EEEPKfS6_PNSA_ILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_1]
  rd70 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:35 ld.param.u64 %rd71, [_ZN7synreal6kernel39add_cloth_membrane_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPKNS1_3matILi2ELi2EfLS3_0EEEPKfS6_PNSA_ILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_2]
  rd71 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:36 ld.param.u64 %rd72, [_ZN7synreal6kernel39add_cloth_membrane_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPKNS1_3matILi2ELi2EfLS3_0EEEPKfS6_PNSA_ILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_3]
  rd72 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:37 ld.param.u64 %rd73, [_ZN7synreal6kernel39add_cloth_membrane_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPKNS1_3matILi2ELi2EfLS3_0EEEPKfS6_PNSA_ILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_4]
  rd73 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:38 ld.param.u64 %rd78, [_ZN7synreal6kernel39add_cloth_membrane_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPKNS1_3matILi2ELi2EfLS3_0EEEPKfS6_PNSA_ILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_5]
  rd78 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:39 ld.param.u64 %rd79, [_ZN7synreal6kernel39add_cloth_membrane_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPKNS1_3matILi2ELi2EfLS3_0EEEPKfS6_PNSA_ILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_6]
  rd79 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:40 ld.param.u64 %rd80, [_ZN7synreal6kernel39add_cloth_membrane_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPKNS1_3matILi2ELi2EfLS3_0EEEPKfS6_PNSA_ILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_7]
  rd80 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:41 ld.param.u64 %rd74, [_ZN7synreal6kernel39add_cloth_membrane_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPKNS1_3matILi2ELi2EfLS3_0EEEPKfS6_PNSA_ILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_8]
  rd74 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:42 ld.param.u64 %rd81, [_ZN7synreal6kernel39add_cloth_membrane_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPKNS1_3matILi2ELi2EfLS3_0EEEPKfS6_PNSA_ILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_9]
  rd81 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:43 ld.param.u64 %rd75, [_ZN7synreal6kernel39add_cloth_membrane_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPKNS1_3matILi2ELi2EfLS3_0EEEPKfS6_PNSA_ILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_10]
  rd75 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:44 ld.param.u64 %rd76, [_ZN7synreal6kernel39add_cloth_membrane_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPKNS1_3matILi2ELi2EfLS3_0EEEPKfS6_PNSA_ILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_11]
  rd76 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:45 ld.param.u64 %rd77, [_ZN7synreal6kernel39add_cloth_membrane_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPKNS1_3matILi2ELi2EfLS3_0EEEPKfS6_PNSA_ILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_12]
  rd77 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:46 cvta.to.global.u64 %rd1, %rd78
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd78));
  // PTX:47 cvta.to.global.u64 %rd2, %rd80
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd80));
  // PTX:48 cvta.to.global.u64 %rd3, %rd79
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd79));
  // PTX:49 add.u64 %rd4, %SPL, 0
  asm("add.u64 %0, %1, 0;" : "=l"(rd4) : "l"(SPL));
  // PTX:50 mov.u32 %r57, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r57) : "r"(blockIdx.x));
  // PTX:51 mov.u32 %r58, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r58) : "r"(blockDim.x));
  // PTX:52 mul.wide.u32 %rd83, %r57, %r58
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd83) : "r"(r57), "r"(r58));
  // PTX:53 mov.u32 %r59, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r59) : "r"(threadIdx.x));
  // PTX:54 cvt.u64.u32 %rd84, %r59
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd84) : "r"(r59));
  // PTX:55 add.s64 %rd5, %rd83, %rd84
  asm("add.s64 %0, %1, %2;" : "=l"(rd5) : "l"(rd83), "l"(rd84));
  // PTX:56 setp.ge.u64 %p1, %rd5, %rd81
  p1 = (((unsigned long long)(rd5)) >= ((unsigned long long)(rd81)));
  // PTX:57 @%p1 bra $L__BB52_70
  if (p1) { goto L_BB52_70; }
  // PTX:59 or.b64 %rd85, %rd5, %rd75
  asm("or.b64 %0, %1, %2;" : "=l"(rd85) : "l"(rd5), "l"(rd75));
  // PTX:60 and.b64 %rd86, %rd85, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd86) : "l"(rd85));
  // PTX:61 setp.eq.s64 %p2, %rd86, 0
  p2 = (((long long)(rd86)) == ((long long)(0)));
  // PTX:62 @%p2 bra $L__BB52_3
  if (p2) { goto L_BB52_3; }
  // PTX:64 div.u64 %rd223, %rd5, %rd75
  asm("div.u64 %0, %1, %2;" : "=l"(rd223) : "l"(rd5), "l"(rd75));
  // PTX:65 mul.lo.s64 %rd87, %rd223, %rd75
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd87) : "l"(rd223), "l"(rd75));
  // PTX:66 sub.s64 %rd224, %rd5, %rd87
  asm("sub.s64 %0, %1, %2;" : "=l"(rd224) : "l"(rd5), "l"(rd87));
  // PTX:67 bra.uni $L__BB52_4
  goto L_BB52_4;
  // PTX:69 $L__BB52_3:
L_BB52_3:;
  // PTX:70 cvt.u32.u64 %r60, %rd75
  asm("cvt.u32.u64 %0, %1;" : "=r"(r60) : "l"(rd75));
  // PTX:71 cvt.u32.u64 %r61, %rd5
  asm("cvt.u32.u64 %0, %1;" : "=r"(r61) : "l"(rd5));
  // PTX:72 div.u32 %r62, %r61, %r60
  asm("div.u32 %0, %1, %2;" : "=r"(r62) : "r"(r61), "r"(r60));
  // PTX:73 mul.lo.s32 %r63, %r62, %r60
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r63) : "r"(r62), "r"(r60));
  // PTX:74 sub.s32 %r64, %r61, %r63
  asm("sub.s32 %0, %1, %2;" : "=r"(r64) : "r"(r61), "r"(r63));
  // PTX:75 cvt.u64.u32 %rd223, %r62
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd223) : "r"(r62));
  // PTX:76 cvt.u64.u32 %rd224, %r64
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd224) : "r"(r64));
  // PTX:78 $L__BB52_4:
L_BB52_4:;
  // PTX:79 cvta.to.global.u64 %rd88, %rd69
  rd88 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd69));
  // PTX:80 mul.lo.s64 %rd89, %rd223, %rd76
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd89) : "l"(rd223), "l"(rd76));
  // PTX:81 cvt.u32.u64 %r68, %rd89
  asm("cvt.u32.u64 %0, %1;" : "=r"(r68) : "l"(rd89));
  // PTX:82 cvta.to.global.u64 %rd90, %rd70
  rd90 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd70));
  // PTX:83 mul.lo.s64 %rd91, %rd224, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd91) : "l"(rd224));
  // PTX:84 add.s64 %rd92, %rd90, %rd91
  asm("add.s64 %0, %1, %2;" : "=l"(rd92) : "l"(rd90), "l"(rd91));
  // PTX:85 ld.global.u32 %r69, [%rd92]
  r69 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (0)))));
  // PTX:86 add.s32 %r1, %r69, %r68
  asm("add.s32 %0, %1, %2;" : "=r"(r1) : "r"(r69), "r"(r68));
  // PTX:87 ld.global.u32 %r70, [%rd92+4]
  r70 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (4)))));
  // PTX:88 add.s32 %r2, %r70, %r68
  asm("add.s32 %0, %1, %2;" : "=r"(r2) : "r"(r70), "r"(r68));
  // PTX:89 ld.global.u32 %r71, [%rd92+8]
  r71 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (8)))));
  // PTX:90 add.s32 %r3, %r71, %r68
  asm("add.s32 %0, %1, %2;" : "=r"(r3) : "r"(r71), "r"(r68));
  // PTX:91 cvt.s64.s32 %rd12, %r2
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd12) : "r"(r2));
  // PTX:92 mul.wide.s32 %rd93, %r2, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd93) : "r"(r2));
  // PTX:93 add.s64 %rd94, %rd88, %rd93
  asm("add.s64 %0, %1, %2;" : "=l"(rd94) : "l"(rd88), "l"(rd93));
  // PTX:94 cvt.s64.s32 %rd13, %r1
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd13) : "r"(r1));
  // PTX:95 mul.wide.s32 %rd95, %r1, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd95) : "r"(r1));
  // PTX:96 add.s64 %rd96, %rd88, %rd95
  asm("add.s64 %0, %1, %2;" : "=l"(rd96) : "l"(rd88), "l"(rd95));
  // PTX:97 ld.global.f32 %f113, [%rd96]
  f113 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (0)))));
  // PTX:98 ld.global.f32 %f114, [%rd94]
  f114 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd94) + (0)))));
  // PTX:99 sub.f32 %f115, %f114, %f113
  asm("sub.f32 %0, %1, %2;" : "=f"(f115) : "f"(f114), "f"(f113));
  // PTX:100 ld.global.f32 %f116, [%rd96+4]
  f116 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (4)))));
  // PTX:101 ld.global.f32 %f117, [%rd94+4]
  f117 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd94) + (4)))));
  // PTX:102 sub.f32 %f118, %f117, %f116
  asm("sub.f32 %0, %1, %2;" : "=f"(f118) : "f"(f117), "f"(f116));
  // PTX:103 ld.global.f32 %f119, [%rd96+8]
  f119 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (8)))));
  // PTX:104 ld.global.f32 %f120, [%rd94+8]
  f120 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd94) + (8)))));
  // PTX:105 sub.f32 %f121, %f120, %f119
  asm("sub.f32 %0, %1, %2;" : "=f"(f121) : "f"(f120), "f"(f119));
  // PTX:106 cvt.s64.s32 %rd14, %r3
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd14) : "r"(r3));
  // PTX:107 mul.wide.s32 %rd97, %r3, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd97) : "r"(r3));
  // PTX:108 add.s64 %rd98, %rd88, %rd97
  asm("add.s64 %0, %1, %2;" : "=l"(rd98) : "l"(rd88), "l"(rd97));
  // PTX:109 ld.global.f32 %f122, [%rd98]
  f122 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (0)))));
  // PTX:110 sub.f32 %f123, %f122, %f113
  asm("sub.f32 %0, %1, %2;" : "=f"(f123) : "f"(f122), "f"(f113));
  // PTX:111 ld.global.f32 %f124, [%rd98+4]
  f124 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (4)))));
  // PTX:112 sub.f32 %f125, %f124, %f116
  asm("sub.f32 %0, %1, %2;" : "=f"(f125) : "f"(f124), "f"(f116));
  // PTX:113 ld.global.f32 %f126, [%rd98+8]
  f126 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (8)))));
  // PTX:114 sub.f32 %f127, %f126, %f119
  asm("sub.f32 %0, %1, %2;" : "=f"(f127) : "f"(f126), "f"(f119));
  // PTX:115 cvta.to.global.u64 %rd99, %rd71
  rd99 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd71));
  // PTX:116 shl.b64 %rd100, %rd224, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd100) : "l"(rd224));
  // PTX:117 add.s64 %rd101, %rd99, %rd100
  asm("add.s64 %0, %1, %2;" : "=l"(rd101) : "l"(rd99), "l"(rd100));
  // PTX:118 ld.global.f32 %f1, [%rd101]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd101) + (0)))));
  // PTX:119 ld.global.f32 %f2, [%rd101+8]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd101) + (8)))));
  // PTX:120 mul.f32 %f128, %f123, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f128) : "f"(f123), "f"(f2));
  // PTX:121 mul.f32 %f129, %f125, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f129) : "f"(f125), "f"(f2));
  // PTX:122 mul.f32 %f130, %f127, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f130) : "f"(f127), "f"(f2));
  // PTX:123 fma.rn.f32 %f3, %f115, %f1, %f128
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f3) : "f"(f115), "f"(f1), "f"(f128));
  // PTX:124 fma.rn.f32 %f4, %f118, %f1, %f129
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f4) : "f"(f118), "f"(f1), "f"(f129));
  // PTX:125 fma.rn.f32 %f5, %f121, %f1, %f130
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f5) : "f"(f121), "f"(f1), "f"(f130));
  // PTX:126 ld.global.f32 %f6, [%rd101+4]
  f6 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd101) + (4)))));
  // PTX:127 ld.global.f32 %f7, [%rd101+12]
  f7 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd101) + (12)))));
  // PTX:128 mul.f32 %f131, %f123, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f131) : "f"(f123), "f"(f7));
  // PTX:129 mul.f32 %f132, %f125, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f132) : "f"(f125), "f"(f7));
  // PTX:130 mul.f32 %f133, %f127, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f133) : "f"(f127), "f"(f7));
  // PTX:131 fma.rn.f32 %f8, %f115, %f6, %f131
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f8) : "f"(f115), "f"(f6), "f"(f131));
  // PTX:132 fma.rn.f32 %f9, %f118, %f6, %f132
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f9) : "f"(f118), "f"(f6), "f"(f132));
  // PTX:133 fma.rn.f32 %f10, %f121, %f6, %f133
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f10) : "f"(f121), "f"(f6), "f"(f133));
  // PTX:134 mul.f32 %f134, %f4, %f4
  asm("mul.f32 %0, %1, %2;" : "=f"(f134) : "f"(f4), "f"(f4));
  // PTX:135 fma.rn.f32 %f135, %f3, %f3, %f134
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f135) : "f"(f3), "f"(f3), "f"(f134));
  // PTX:136 fma.rn.f32 %f11, %f5, %f5, %f135
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f11) : "f"(f5), "f"(f5), "f"(f135));
  // PTX:137 sqrt.rn.f32 %f12, %f11
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f12) : "f"(f11));
  // PTX:138 setp.leu.f32 %p3, %f12, 0f00000000
  p3 = ((isnan(((float)(f12))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f12)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:139 mov.u32 %r103, 0
  asm("mov.u32 %0, 0;" : "=r"(r103) : );
  // PTX:140 mov.u32 %r100, %r103
  asm("mov.u32 %0, %1;" : "=r"(r100) : "r"(r103));
  // PTX:141 mov.u32 %r101, %r103
  asm("mov.u32 %0, %1;" : "=r"(r101) : "r"(r103));
  // PTX:142 mov.u32 %r102, %r103
  asm("mov.u32 %0, %1;" : "=r"(r102) : "r"(r103));
  // PTX:143 @%p3 bra $L__BB52_6
  if (p3) { goto L_BB52_6; }
  // PTX:145 div.rn.f32 %f136, %f3, %f12
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f136) : "f"(f3), "f"(f12));
  // PTX:146 div.rn.f32 %f137, %f4, %f12
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f137) : "f"(f4), "f"(f12));
  // PTX:147 div.rn.f32 %f138, %f5, %f12
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f138) : "f"(f5), "f"(f12));
  // PTX:148 mov.b32 %r102, %f138
  asm("mov.b32 %0, %1;" : "=r"(r102) : "f"(f138));
  // PTX:149 mov.b32 %r101, %f137
  asm("mov.b32 %0, %1;" : "=r"(r101) : "f"(f137));
  // PTX:150 mov.b32 %r100, %f136
  asm("mov.b32 %0, %1;" : "=r"(r100) : "f"(f136));
  // PTX:152 $L__BB52_6:
L_BB52_6:;
  // PTX:153 mul.f32 %f139, %f9, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f139) : "f"(f9), "f"(f9));
  // PTX:154 fma.rn.f32 %f140, %f8, %f8, %f139
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f140) : "f"(f8), "f"(f8), "f"(f139));
  // PTX:155 fma.rn.f32 %f13, %f10, %f10, %f140
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f13) : "f"(f10), "f"(f10), "f"(f140));
  // PTX:156 sqrt.rn.f32 %f14, %f13
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f14) : "f"(f13));
  // PTX:157 setp.leu.f32 %p4, %f14, 0f00000000
  p4 = ((isnan(((float)(f14))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f14)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:158 mov.u32 %r104, %r103
  asm("mov.u32 %0, %1;" : "=r"(r104) : "r"(r103));
  // PTX:159 mov.u32 %r105, %r103
  asm("mov.u32 %0, %1;" : "=r"(r105) : "r"(r103));
  // PTX:160 @%p4 bra $L__BB52_8
  if (p4) { goto L_BB52_8; }
  // PTX:162 div.rn.f32 %f141, %f8, %f14
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f141) : "f"(f8), "f"(f14));
  // PTX:163 div.rn.f32 %f142, %f9, %f14
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f142) : "f"(f9), "f"(f14));
  // PTX:164 div.rn.f32 %f143, %f10, %f14
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f143) : "f"(f10), "f"(f14));
  // PTX:165 mov.b32 %r105, %f143
  asm("mov.b32 %0, %1;" : "=r"(r105) : "f"(f143));
  // PTX:166 mov.b32 %r104, %f142
  asm("mov.b32 %0, %1;" : "=r"(r104) : "f"(f142));
  // PTX:167 mov.b32 %r103, %f141
  asm("mov.b32 %0, %1;" : "=r"(r103) : "f"(f141));
  // PTX:169 $L__BB52_8:
L_BB52_8:;
  // PTX:170 neg.f32 %f144, %f1
  asm("neg.f32 %0, %1;" : "=f"(f144) : "f"(f1));
  // PTX:171 sub.f32 %f15, %f144, %f2
  asm("sub.f32 %0, %1, %2;" : "=f"(f15) : "f"(f144), "f"(f2));
  // PTX:172 neg.f32 %f145, %f6
  asm("neg.f32 %0, %1;" : "=f"(f145) : "f"(f6));
  // PTX:173 sub.f32 %f16, %f145, %f7
  asm("sub.f32 %0, %1, %2;" : "=f"(f16) : "f"(f145), "f"(f7));
  // PTX:174 add.f32 %f146, %f11, 0f2B8CBCCC
  asm("add.f32 %0, %1, 0f2B8CBCCC;" : "=f"(f146) : "f"(f11));
  // PTX:175 sqrt.rn.f32 %f147, %f146
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f147) : "f"(f146));
  // PTX:176 add.f32 %f148, %f13, 0f2B8CBCCC
  asm("add.f32 %0, %1, 0f2B8CBCCC;" : "=f"(f148) : "f"(f13));
  // PTX:177 sqrt.rn.f32 %f149, %f148
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f149) : "f"(f148));
  // PTX:178 div.rn.f32 %f150, %f3, %f147
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f150) : "f"(f3), "f"(f147));
  // PTX:179 div.rn.f32 %f151, %f4, %f147
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f151) : "f"(f4), "f"(f147));
  // PTX:180 div.rn.f32 %f152, %f5, %f147
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f152) : "f"(f5), "f"(f147));
  // PTX:181 div.rn.f32 %f153, %f8, %f149
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f153) : "f"(f8), "f"(f149));
  // PTX:182 div.rn.f32 %f154, %f9, %f149
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f154) : "f"(f9), "f"(f149));
  // PTX:183 div.rn.f32 %f155, %f10, %f149
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f155) : "f"(f10), "f"(f149));
  // PTX:184 mul.f32 %f156, %f151, %f154
  asm("mul.f32 %0, %1, %2;" : "=f"(f156) : "f"(f151), "f"(f154));
  // PTX:185 fma.rn.f32 %f157, %f150, %f153, %f156
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f157) : "f"(f150), "f"(f153), "f"(f156));
  // PTX:186 fma.rn.f32 %f158, %f152, %f155, %f157
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f158) : "f"(f152), "f"(f155), "f"(f157));
  // PTX:187 mul.f32 %f159, %f150, %f158
  asm("mul.f32 %0, %1, %2;" : "=f"(f159) : "f"(f150), "f"(f158));
  // PTX:188 mul.f32 %f160, %f151, %f158
  asm("mul.f32 %0, %1, %2;" : "=f"(f160) : "f"(f151), "f"(f158));
  // PTX:189 mul.f32 %f161, %f152, %f158
  asm("mul.f32 %0, %1, %2;" : "=f"(f161) : "f"(f152), "f"(f158));
  // PTX:190 sub.f32 %f162, %f153, %f159
  asm("sub.f32 %0, %1, %2;" : "=f"(f162) : "f"(f153), "f"(f159));
  // PTX:191 sub.f32 %f163, %f154, %f160
  asm("sub.f32 %0, %1, %2;" : "=f"(f163) : "f"(f154), "f"(f160));
  // PTX:192 sub.f32 %f164, %f155, %f161
  asm("sub.f32 %0, %1, %2;" : "=f"(f164) : "f"(f155), "f"(f161));
  // PTX:193 div.rn.f32 %f165, %f162, %f147
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f165) : "f"(f162), "f"(f147));
  // PTX:194 div.rn.f32 %f166, %f163, %f147
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f166) : "f"(f163), "f"(f147));
  // PTX:195 div.rn.f32 %f167, %f164, %f147
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f167) : "f"(f164), "f"(f147));
  // PTX:196 mul.f32 %f168, %f153, %f158
  asm("mul.f32 %0, %1, %2;" : "=f"(f168) : "f"(f153), "f"(f158));
  // PTX:197 mul.f32 %f169, %f154, %f158
  asm("mul.f32 %0, %1, %2;" : "=f"(f169) : "f"(f154), "f"(f158));
  // PTX:198 mul.f32 %f170, %f155, %f158
  asm("mul.f32 %0, %1, %2;" : "=f"(f170) : "f"(f155), "f"(f158));
  // PTX:199 sub.f32 %f171, %f150, %f168
  asm("sub.f32 %0, %1, %2;" : "=f"(f171) : "f"(f150), "f"(f168));
  // PTX:200 sub.f32 %f172, %f151, %f169
  asm("sub.f32 %0, %1, %2;" : "=f"(f172) : "f"(f151), "f"(f169));
  // PTX:201 sub.f32 %f173, %f152, %f170
  asm("sub.f32 %0, %1, %2;" : "=f"(f173) : "f"(f152), "f"(f170));
  // PTX:202 div.rn.f32 %f174, %f171, %f149
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f174) : "f"(f171), "f"(f149));
  // PTX:203 div.rn.f32 %f175, %f172, %f149
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f175) : "f"(f172), "f"(f149));
  // PTX:204 div.rn.f32 %f176, %f173, %f149
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f176) : "f"(f173), "f"(f149));
  // PTX:205 mov.b32 %f177, %r103
  asm("mov.b32 %0, %1;" : "=f"(f177) : "r"(r103));
  // PTX:206 mov.b32 %f178, %r104
  asm("mov.b32 %0, %1;" : "=f"(f178) : "r"(r104));
  // PTX:207 mov.b32 %f179, %r105
  asm("mov.b32 %0, %1;" : "=f"(f179) : "r"(r105));
  // PTX:208 mov.b32 %f180, %r100
  asm("mov.b32 %0, %1;" : "=f"(f180) : "r"(r100));
  // PTX:209 mul.f32 %f181, %f15, %f180
  asm("mul.f32 %0, %1, %2;" : "=f"(f181) : "f"(f15), "f"(f180));
  // PTX:210 mov.b32 %f182, %r101
  asm("mov.b32 %0, %1;" : "=f"(f182) : "r"(r101));
  // PTX:211 mul.f32 %f183, %f15, %f182
  asm("mul.f32 %0, %1, %2;" : "=f"(f183) : "f"(f15), "f"(f182));
  // PTX:212 mov.b32 %f184, %r102
  asm("mov.b32 %0, %1;" : "=f"(f184) : "r"(r102));
  // PTX:213 mul.f32 %f185, %f15, %f184
  asm("mul.f32 %0, %1, %2;" : "=f"(f185) : "f"(f15), "f"(f184));
  // PTX:214 mul.f32 %f186, %f16, %f177
  asm("mul.f32 %0, %1, %2;" : "=f"(f186) : "f"(f16), "f"(f177));
  // PTX:215 mul.f32 %f187, %f16, %f178
  asm("mul.f32 %0, %1, %2;" : "=f"(f187) : "f"(f16), "f"(f178));
  // PTX:216 mul.f32 %f188, %f16, %f179
  asm("mul.f32 %0, %1, %2;" : "=f"(f188) : "f"(f16), "f"(f179));
  // PTX:217 mul.f32 %f189, %f174, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f189) : "f"(f174), "f"(f16));
  // PTX:218 mul.f32 %f190, %f175, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f190) : "f"(f175), "f"(f16));
  // PTX:219 mul.f32 %f191, %f176, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f191) : "f"(f176), "f"(f16));
  // PTX:220 fma.rn.f32 %f17, %f165, %f15, %f189
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f17) : "f"(f165), "f"(f15), "f"(f189));
  // PTX:221 fma.rn.f32 %f18, %f166, %f15, %f190
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f18) : "f"(f166), "f"(f15), "f"(f190));
  // PTX:222 fma.rn.f32 %f19, %f167, %f15, %f191
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f19) : "f"(f167), "f"(f15), "f"(f191));
  // PTX:223 mul.f32 %f192, %f1, %f180
  asm("mul.f32 %0, %1, %2;" : "=f"(f192) : "f"(f1), "f"(f180));
  // PTX:224 mul.f32 %f193, %f1, %f182
  asm("mul.f32 %0, %1, %2;" : "=f"(f193) : "f"(f1), "f"(f182));
  // PTX:225 mul.f32 %f194, %f1, %f184
  asm("mul.f32 %0, %1, %2;" : "=f"(f194) : "f"(f1), "f"(f184));
  // PTX:226 mul.f32 %f195, %f6, %f177
  asm("mul.f32 %0, %1, %2;" : "=f"(f195) : "f"(f6), "f"(f177));
  // PTX:227 mul.f32 %f196, %f6, %f178
  asm("mul.f32 %0, %1, %2;" : "=f"(f196) : "f"(f6), "f"(f178));
  // PTX:228 mul.f32 %f197, %f6, %f179
  asm("mul.f32 %0, %1, %2;" : "=f"(f197) : "f"(f6), "f"(f179));
  // PTX:229 mul.f32 %f198, %f174, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f198) : "f"(f174), "f"(f6));
  // PTX:230 mul.f32 %f199, %f175, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f199) : "f"(f175), "f"(f6));
  // PTX:231 mul.f32 %f200, %f176, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f200) : "f"(f176), "f"(f6));
  // PTX:232 fma.rn.f32 %f20, %f165, %f1, %f198
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f20) : "f"(f165), "f"(f1), "f"(f198));
  // PTX:233 fma.rn.f32 %f21, %f166, %f1, %f199
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f21) : "f"(f166), "f"(f1), "f"(f199));
  // PTX:234 fma.rn.f32 %f22, %f167, %f1, %f200
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f22) : "f"(f167), "f"(f1), "f"(f200));
  // PTX:235 mul.f32 %f201, %f2, %f180
  asm("mul.f32 %0, %1, %2;" : "=f"(f201) : "f"(f2), "f"(f180));
  // PTX:236 mul.f32 %f202, %f2, %f182
  asm("mul.f32 %0, %1, %2;" : "=f"(f202) : "f"(f2), "f"(f182));
  // PTX:237 mul.f32 %f203, %f2, %f184
  asm("mul.f32 %0, %1, %2;" : "=f"(f203) : "f"(f2), "f"(f184));
  // PTX:238 mul.f32 %f204, %f7, %f177
  asm("mul.f32 %0, %1, %2;" : "=f"(f204) : "f"(f7), "f"(f177));
  // PTX:239 mul.f32 %f205, %f7, %f178
  asm("mul.f32 %0, %1, %2;" : "=f"(f205) : "f"(f7), "f"(f178));
  // PTX:240 mul.f32 %f206, %f7, %f179
  asm("mul.f32 %0, %1, %2;" : "=f"(f206) : "f"(f7), "f"(f179));
  // PTX:241 mul.f32 %f207, %f174, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f207) : "f"(f174), "f"(f7));
  // PTX:242 mul.f32 %f208, %f175, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f208) : "f"(f175), "f"(f7));
  // PTX:243 mul.f32 %f209, %f176, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f209) : "f"(f176), "f"(f7));
  // PTX:244 fma.rn.f32 %f23, %f165, %f2, %f207
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f23) : "f"(f165), "f"(f2), "f"(f207));
  // PTX:245 fma.rn.f32 %f24, %f166, %f2, %f208
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f24) : "f"(f166), "f"(f2), "f"(f208));
  // PTX:246 fma.rn.f32 %f25, %f167, %f2, %f209
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f25) : "f"(f167), "f"(f2), "f"(f209));
  // PTX:247 add.s64 %rd15, %rd4, 140
  asm("add.s64 %0, %1, 140;" : "=l"(rd15) : "l"(rd4));
  // PTX:248 add.s64 %rd16, %rd4, 128
  asm("add.s64 %0, %1, 128;" : "=l"(rd16) : "l"(rd4));
  // PTX:249 add.s64 %rd17, %rd4, 124
  asm("add.s64 %0, %1, 124;" : "=l"(rd17) : "l"(rd4));
  // PTX:250 add.f32 %f210, %f12, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f210) : "f"(f12));
  // PTX:251 st.local.f32 [%rd4], %f210
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (0))))) = (float)(f210);
  // PTX:252 add.f32 %f211, %f14, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f211) : "f"(f14));
  // PTX:253 st.local.f32 [%rd4+4], %f211
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (4))))) = (float)(f211);
  // PTX:254 st.local.f32 [%rd4+8], %f158
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (8))))) = (float)(f158);
  // PTX:255 st.local.f32 [%rd4+12], %f181
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (12))))) = (float)(f181);
  // PTX:256 st.local.f32 [%rd4+16], %f183
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (16))))) = (float)(f183);
  // PTX:257 st.local.f32 [%rd4+20], %f185
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (20))))) = (float)(f185);
  // PTX:258 st.local.f32 [%rd4+24], %f192
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (24))))) = (float)(f192);
  // PTX:259 st.local.f32 [%rd4+28], %f193
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (28))))) = (float)(f193);
  // PTX:260 st.local.f32 [%rd4+32], %f194
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (32))))) = (float)(f194);
  // PTX:261 st.local.f32 [%rd4+36], %f201
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (36))))) = (float)(f201);
  // PTX:262 st.local.f32 [%rd4+40], %f202
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (40))))) = (float)(f202);
  // PTX:263 st.local.f32 [%rd4+44], %f203
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (44))))) = (float)(f203);
  // PTX:264 st.local.f32 [%rd4+48], %f186
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (48))))) = (float)(f186);
  // PTX:265 st.local.f32 [%rd4+52], %f187
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (52))))) = (float)(f187);
  // PTX:266 st.local.f32 [%rd4+56], %f188
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (56))))) = (float)(f188);
  // PTX:267 st.local.f32 [%rd4+60], %f195
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (60))))) = (float)(f195);
  // PTX:268 st.local.f32 [%rd4+64], %f196
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (64))))) = (float)(f196);
  // PTX:269 st.local.f32 [%rd4+68], %f197
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (68))))) = (float)(f197);
  // PTX:270 st.local.f32 [%rd4+72], %f204
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (72))))) = (float)(f204);
  // PTX:271 st.local.f32 [%rd4+76], %f205
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (76))))) = (float)(f205);
  // PTX:272 st.local.f32 [%rd4+80], %f206
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (80))))) = (float)(f206);
  // PTX:273 st.local.f32 [%rd4+84], %f17
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (84))))) = (float)(f17);
  // PTX:274 st.local.f32 [%rd4+88], %f18
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (88))))) = (float)(f18);
  // PTX:275 st.local.f32 [%rd4+92], %f19
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (92))))) = (float)(f19);
  // PTX:276 st.local.f32 [%rd4+96], %f20
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (96))))) = (float)(f20);
  // PTX:277 st.local.f32 [%rd4+100], %f21
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (100))))) = (float)(f21);
  // PTX:278 st.local.f32 [%rd4+104], %f22
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (104))))) = (float)(f22);
  // PTX:279 st.local.f32 [%rd4+108], %f23
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (108))))) = (float)(f23);
  // PTX:280 st.local.f32 [%rd4+112], %f24
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (112))))) = (float)(f24);
  // PTX:281 st.local.f32 [%rd4+116], %f25
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (116))))) = (float)(f25);
  // PTX:282 st.local.f32 [%rd4+120], %f15
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (120))))) = (float)(f15);
  // PTX:283 st.local.f32 [%rd4+124], %f1
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (124))))) = (float)(f1);
  // PTX:284 st.local.f32 [%rd4+128], %f2
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (128))))) = (float)(f2);
  // PTX:285 st.local.f32 [%rd4+132], %f16
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (132))))) = (float)(f16);
  // PTX:286 st.local.f32 [%rd4+136], %f6
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (136))))) = (float)(f6);
  // PTX:287 st.local.f32 [%rd4+140], %f7
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd4) + (140))))) = (float)(f7);
  // PTX:288 cvta.to.global.u64 %rd102, %rd73
  rd102 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd73));
  // PTX:289 add.s64 %rd104, %rd102, %rd91
  asm("add.s64 %0, %1, %2;" : "=l"(rd104) : "l"(rd102), "l"(rd91));
  // PTX:290 ld.global.f32 %f26, [%rd104]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd104) + (0)))));
  // PTX:291 ld.global.f32 %f27, [%rd104+4]
  f27 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd104) + (4)))));
  // PTX:292 ld.global.f32 %f28, [%rd104+8]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd104) + (8)))));
  // PTX:293 cvta.to.global.u64 %rd105, %rd72
  rd105 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd72));
  // PTX:294 shl.b64 %rd106, %rd224, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd106) : "l"(rd224));
  // PTX:295 add.s64 %rd107, %rd105, %rd106
  asm("add.s64 %0, %1, %2;" : "=l"(rd107) : "l"(rd105), "l"(rd106));
  // PTX:296 ld.global.f32 %f29, [%rd107]
  f29 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd107) + (0)))));
  // PTX:297 setp.le.f32 %p5, %f12, 0f322BCC77
  p5 = (!(isnan(((float)(f12))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f12)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:298 mov.u32 %r112, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r112) : );
  // PTX:299 mov.u32 %r113, 0
  asm("mov.u32 %0, 0;" : "=r"(r113) : );
  // PTX:300 mov.u32 %r106, %r112
  asm("mov.u32 %0, %1;" : "=r"(r106) : "r"(r112));
  // PTX:301 mov.u32 %r107, %r113
  asm("mov.u32 %0, %1;" : "=r"(r107) : "r"(r113));
  // PTX:302 mov.u32 %r108, %r113
  asm("mov.u32 %0, %1;" : "=r"(r108) : "r"(r113));
  // PTX:303 mov.u32 %r109, %r112
  asm("mov.u32 %0, %1;" : "=r"(r109) : "r"(r112));
  // PTX:304 mov.u32 %r110, %r113
  asm("mov.u32 %0, %1;" : "=r"(r110) : "r"(r113));
  // PTX:305 mov.u32 %r111, %r112
  asm("mov.u32 %0, %1;" : "=r"(r111) : "r"(r112));
  // PTX:306 @%p5 bra $L__BB52_10
  if (p5) { goto L_BB52_10; }
  // PTX:308 div.rn.f32 %f212, %f3, %f12
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f212) : "f"(f3), "f"(f12));
  // PTX:309 mul.f32 %f213, %f212, %f212
  asm("mul.f32 %0, %1, %2;" : "=f"(f213) : "f"(f212), "f"(f212));
  // PTX:310 div.rn.f32 %f214, %f4, %f12
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f214) : "f"(f4), "f"(f12));
  // PTX:311 mul.f32 %f215, %f214, %f212
  asm("mul.f32 %0, %1, %2;" : "=f"(f215) : "f"(f214), "f"(f212));
  // PTX:312 div.rn.f32 %f216, %f5, %f12
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f216) : "f"(f5), "f"(f12));
  // PTX:313 mul.f32 %f217, %f216, %f212
  asm("mul.f32 %0, %1, %2;" : "=f"(f217) : "f"(f216), "f"(f212));
  // PTX:314 mul.f32 %f218, %f214, %f214
  asm("mul.f32 %0, %1, %2;" : "=f"(f218) : "f"(f214), "f"(f214));
  // PTX:315 mul.f32 %f219, %f216, %f214
  asm("mul.f32 %0, %1, %2;" : "=f"(f219) : "f"(f216), "f"(f214));
  // PTX:316 mul.f32 %f220, %f216, %f216
  asm("mul.f32 %0, %1, %2;" : "=f"(f220) : "f"(f216), "f"(f216));
  // PTX:317 rcp.rn.f32 %f221, %f12
  asm("rcp.rn.f32 %0, %1;" : "=f"(f221) : "f"(f12));
  // PTX:318 mov.f32 %f222, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f222) : );
  // PTX:319 sub.f32 %f223, %f222, %f221
  asm("sub.f32 %0, %1, %2;" : "=f"(f223) : "f"(f222), "f"(f221));
  // PTX:320 mov.f32 %f224, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f224) : );
  // PTX:321 max.f32 %f225, %f224, %f223
  asm("max.f32 %0, %1, %2;" : "=f"(f225) : "f"(f224), "f"(f223));
  // PTX:322 sub.f32 %f226, %f222, %f213
  asm("sub.f32 %0, %1, %2;" : "=f"(f226) : "f"(f222), "f"(f213));
  // PTX:323 sub.f32 %f227, %f224, %f215
  asm("sub.f32 %0, %1, %2;" : "=f"(f227) : "f"(f224), "f"(f215));
  // PTX:324 sub.f32 %f228, %f224, %f217
  asm("sub.f32 %0, %1, %2;" : "=f"(f228) : "f"(f224), "f"(f217));
  // PTX:325 sub.f32 %f229, %f222, %f218
  asm("sub.f32 %0, %1, %2;" : "=f"(f229) : "f"(f222), "f"(f218));
  // PTX:326 sub.f32 %f230, %f224, %f219
  asm("sub.f32 %0, %1, %2;" : "=f"(f230) : "f"(f224), "f"(f219));
  // PTX:327 sub.f32 %f231, %f222, %f220
  asm("sub.f32 %0, %1, %2;" : "=f"(f231) : "f"(f222), "f"(f220));
  // PTX:328 fma.rn.f32 %f232, %f226, %f225, %f213
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f232) : "f"(f226), "f"(f225), "f"(f213));
  // PTX:329 fma.rn.f32 %f233, %f227, %f225, %f215
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f233) : "f"(f227), "f"(f225), "f"(f215));
  // PTX:330 fma.rn.f32 %f234, %f228, %f225, %f217
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f234) : "f"(f228), "f"(f225), "f"(f217));
  // PTX:331 fma.rn.f32 %f235, %f229, %f225, %f218
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f235) : "f"(f229), "f"(f225), "f"(f218));
  // PTX:332 fma.rn.f32 %f236, %f230, %f225, %f219
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f236) : "f"(f230), "f"(f225), "f"(f219));
  // PTX:333 fma.rn.f32 %f237, %f231, %f225, %f220
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f237) : "f"(f231), "f"(f225), "f"(f220));
  // PTX:334 mov.b32 %r111, %f237
  asm("mov.b32 %0, %1;" : "=r"(r111) : "f"(f237));
  // PTX:335 mov.b32 %r110, %f236
  asm("mov.b32 %0, %1;" : "=r"(r110) : "f"(f236));
  // PTX:336 mov.b32 %r108, %f234
  asm("mov.b32 %0, %1;" : "=r"(r108) : "f"(f234));
  // PTX:337 mov.b32 %r109, %f235
  asm("mov.b32 %0, %1;" : "=r"(r109) : "f"(f235));
  // PTX:338 mov.b32 %r107, %f233
  asm("mov.b32 %0, %1;" : "=r"(r107) : "f"(f233));
  // PTX:339 mov.b32 %r106, %f232
  asm("mov.b32 %0, %1;" : "=r"(r106) : "f"(f232));
  // PTX:341 $L__BB52_10:
L_BB52_10:;
  // PTX:342 setp.le.f32 %p6, %f14, 0f322BCC77
  p6 = (!(isnan(((float)(f14))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f14)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:343 mov.u32 %r114, %r113
  asm("mov.u32 %0, %1;" : "=r"(r114) : "r"(r113));
  // PTX:344 mov.u32 %r115, %r112
  asm("mov.u32 %0, %1;" : "=r"(r115) : "r"(r112));
  // PTX:345 mov.u32 %r116, %r113
  asm("mov.u32 %0, %1;" : "=r"(r116) : "r"(r113));
  // PTX:346 mov.u32 %r117, %r112
  asm("mov.u32 %0, %1;" : "=r"(r117) : "r"(r112));
  // PTX:347 @%p6 bra $L__BB52_12
  if (p6) { goto L_BB52_12; }
  // PTX:349 div.rn.f32 %f238, %f8, %f14
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f238) : "f"(f8), "f"(f14));
  // PTX:350 mul.f32 %f239, %f238, %f238
  asm("mul.f32 %0, %1, %2;" : "=f"(f239) : "f"(f238), "f"(f238));
  // PTX:351 div.rn.f32 %f240, %f9, %f14
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f240) : "f"(f9), "f"(f14));
  // PTX:352 mul.f32 %f241, %f240, %f238
  asm("mul.f32 %0, %1, %2;" : "=f"(f241) : "f"(f240), "f"(f238));
  // PTX:353 div.rn.f32 %f242, %f10, %f14
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f242) : "f"(f10), "f"(f14));
  // PTX:354 mul.f32 %f243, %f242, %f238
  asm("mul.f32 %0, %1, %2;" : "=f"(f243) : "f"(f242), "f"(f238));
  // PTX:355 mul.f32 %f244, %f240, %f240
  asm("mul.f32 %0, %1, %2;" : "=f"(f244) : "f"(f240), "f"(f240));
  // PTX:356 mul.f32 %f245, %f242, %f240
  asm("mul.f32 %0, %1, %2;" : "=f"(f245) : "f"(f242), "f"(f240));
  // PTX:357 mul.f32 %f246, %f242, %f242
  asm("mul.f32 %0, %1, %2;" : "=f"(f246) : "f"(f242), "f"(f242));
  // PTX:358 rcp.rn.f32 %f247, %f14
  asm("rcp.rn.f32 %0, %1;" : "=f"(f247) : "f"(f14));
  // PTX:359 mov.f32 %f248, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f248) : );
  // PTX:360 sub.f32 %f249, %f248, %f247
  asm("sub.f32 %0, %1, %2;" : "=f"(f249) : "f"(f248), "f"(f247));
  // PTX:361 mov.f32 %f250, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f250) : );
  // PTX:362 max.f32 %f251, %f250, %f249
  asm("max.f32 %0, %1, %2;" : "=f"(f251) : "f"(f250), "f"(f249));
  // PTX:363 sub.f32 %f252, %f248, %f239
  asm("sub.f32 %0, %1, %2;" : "=f"(f252) : "f"(f248), "f"(f239));
  // PTX:364 sub.f32 %f253, %f250, %f241
  asm("sub.f32 %0, %1, %2;" : "=f"(f253) : "f"(f250), "f"(f241));
  // PTX:365 sub.f32 %f254, %f250, %f243
  asm("sub.f32 %0, %1, %2;" : "=f"(f254) : "f"(f250), "f"(f243));
  // PTX:366 sub.f32 %f255, %f248, %f244
  asm("sub.f32 %0, %1, %2;" : "=f"(f255) : "f"(f248), "f"(f244));
  // PTX:367 sub.f32 %f256, %f250, %f245
  asm("sub.f32 %0, %1, %2;" : "=f"(f256) : "f"(f250), "f"(f245));
  // PTX:368 sub.f32 %f257, %f248, %f246
  asm("sub.f32 %0, %1, %2;" : "=f"(f257) : "f"(f248), "f"(f246));
  // PTX:369 fma.rn.f32 %f258, %f252, %f251, %f239
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f258) : "f"(f252), "f"(f251), "f"(f239));
  // PTX:370 fma.rn.f32 %f259, %f253, %f251, %f241
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f259) : "f"(f253), "f"(f251), "f"(f241));
  // PTX:371 fma.rn.f32 %f260, %f254, %f251, %f243
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f260) : "f"(f254), "f"(f251), "f"(f243));
  // PTX:372 fma.rn.f32 %f261, %f255, %f251, %f244
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f261) : "f"(f255), "f"(f251), "f"(f244));
  // PTX:373 fma.rn.f32 %f262, %f256, %f251, %f245
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f262) : "f"(f256), "f"(f251), "f"(f245));
  // PTX:374 fma.rn.f32 %f263, %f257, %f251, %f246
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f263) : "f"(f257), "f"(f251), "f"(f246));
  // PTX:375 mov.b32 %r117, %f263
  asm("mov.b32 %0, %1;" : "=r"(r117) : "f"(f263));
  // PTX:376 mov.b32 %r116, %f262
  asm("mov.b32 %0, %1;" : "=r"(r116) : "f"(f262));
  // PTX:377 mov.b32 %r114, %f260
  asm("mov.b32 %0, %1;" : "=r"(r114) : "f"(f260));
  // PTX:378 mov.b32 %r115, %f261
  asm("mov.b32 %0, %1;" : "=r"(r115) : "f"(f261));
  // PTX:379 mov.b32 %r113, %f259
  asm("mov.b32 %0, %1;" : "=r"(r113) : "f"(f259));
  // PTX:380 mov.b32 %r112, %f258
  asm("mov.b32 %0, %1;" : "=r"(r112) : "f"(f258));
  // PTX:382 $L__BB52_12:
L_BB52_12:;
  // PTX:383 add.s64 %rd18, %rd4, 136
  asm("add.s64 %0, %1, 136;" : "=l"(rd18) : "l"(rd4));
  // PTX:384 add.s64 %rd19, %rd4, 132
  asm("add.s64 %0, %1, 132;" : "=l"(rd19) : "l"(rd4));
  // PTX:385 add.s64 %rd20, %rd4, 120
  asm("add.s64 %0, %1, 120;" : "=l"(rd20) : "l"(rd4));
  // PTX:386 add.f32 %f30, %f26, %f28
  asm("add.f32 %0, %1, %2;" : "=f"(f30) : "f"(f26), "f"(f28));
  // PTX:387 add.f32 %f31, %f27, %f28
  asm("add.f32 %0, %1, %2;" : "=f"(f31) : "f"(f27), "f"(f28));
  // PTX:388 mov.b32 %f32, %r106
  asm("mov.b32 %0, %1;" : "=f"(f32) : "r"(r106));
  // PTX:389 mov.b32 %f33, %r107
  asm("mov.b32 %0, %1;" : "=f"(f33) : "r"(r107));
  // PTX:390 mov.b32 %f34, %r108
  asm("mov.b32 %0, %1;" : "=f"(f34) : "r"(r108));
  // PTX:391 mov.b32 %f35, %r107
  asm("mov.b32 %0, %1;" : "=f"(f35) : "r"(r107));
  // PTX:392 mov.b32 %f36, %r109
  asm("mov.b32 %0, %1;" : "=f"(f36) : "r"(r109));
  // PTX:393 mov.b32 %f37, %r110
  asm("mov.b32 %0, %1;" : "=f"(f37) : "r"(r110));
  // PTX:394 mov.b32 %f38, %r108
  asm("mov.b32 %0, %1;" : "=f"(f38) : "r"(r108));
  // PTX:395 mov.b32 %f39, %r110
  asm("mov.b32 %0, %1;" : "=f"(f39) : "r"(r110));
  // PTX:396 mov.b32 %f40, %r111
  asm("mov.b32 %0, %1;" : "=f"(f40) : "r"(r111));
  // PTX:397 mov.b32 %f41, %r112
  asm("mov.b32 %0, %1;" : "=f"(f41) : "r"(r112));
  // PTX:398 mov.b32 %f42, %r113
  asm("mov.b32 %0, %1;" : "=f"(f42) : "r"(r113));
  // PTX:399 mov.b32 %f43, %r114
  asm("mov.b32 %0, %1;" : "=f"(f43) : "r"(r114));
  // PTX:400 mov.b32 %f44, %r113
  asm("mov.b32 %0, %1;" : "=f"(f44) : "r"(r113));
  // PTX:401 mov.b32 %f45, %r115
  asm("mov.b32 %0, %1;" : "=f"(f45) : "r"(r115));
  // PTX:402 mov.b32 %f46, %r116
  asm("mov.b32 %0, %1;" : "=f"(f46) : "r"(r116));
  // PTX:403 mov.b32 %f47, %r114
  asm("mov.b32 %0, %1;" : "=f"(f47) : "r"(r114));
  // PTX:404 mov.b32 %f48, %r116
  asm("mov.b32 %0, %1;" : "=f"(f48) : "r"(r116));
  // PTX:405 mov.b32 %f49, %r117
  asm("mov.b32 %0, %1;" : "=f"(f49) : "r"(r117));
  // PTX:406 mov.u32 %r118, 0
  asm("mov.u32 %0, 0;" : "=r"(r118) : );
  // PTX:408 $L__BB52_13:
L_BB52_13:;
  // PTX:409 add.u64 %rd221, %SPL, 0
  asm("add.u64 %0, %1, 0;" : "=l"(rd221) : "l"(SPL));
  // PTX:410 mul.wide.s32 %rd108, %r118, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd108) : "r"(r118));
  // PTX:411 add.s64 %rd109, %rd221, %rd108
  asm("add.s64 %0, %1, %2;" : "=l"(rd109) : "l"(rd221), "l"(rd108));
  // PTX:412 ld.local.f32 %f50, [%rd109+84]
  f50 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd109) + (84)))));
  // PTX:413 ld.local.f32 %f51, [%rd109+88]
  f51 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd109) + (88)))));
  // PTX:414 ld.local.f32 %f52, [%rd109+92]
  f52 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd109) + (92)))));
  // PTX:415 setp.eq.s32 %p7, %r118, 2
  p7 = (((int)(r118)) == ((int)(2)));
  // PTX:416 @%p7 bra $L__BB52_16
  if (p7) { goto L_BB52_16; }
  // PTX:418 setp.ne.s32 %p8, %r118, 1
  p8 = (((int)(r118)) != ((int)(1)));
  // PTX:419 mov.u64 %rd225, %rd20
  asm("mov.u64 %0, %1;" : "=l"(rd225) : "l"(rd20));
  // PTX:420 @%p8 bra $L__BB52_17
  if (p8) { goto L_BB52_17; }
  // PTX:422 mov.u64 %rd225, %rd17
  asm("mov.u64 %0, %1;" : "=l"(rd225) : "l"(rd17));
  // PTX:423 bra.uni $L__BB52_17
  goto L_BB52_17;
  // PTX:425 $L__BB52_16:
L_BB52_16:;
  // PTX:426 mov.u64 %rd225, %rd16
  asm("mov.u64 %0, %1;" : "=l"(rd225) : "l"(rd16));
  // PTX:428 $L__BB52_17:
L_BB52_17:;
  // PTX:429 ld.local.f32 %f53, [%rd225]
  f53 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd225) + (0)))));
  // PTX:430 @%p7 bra $L__BB52_20
  if (p7) { goto L_BB52_20; }
  // PTX:432 setp.ne.s32 %p10, %r118, 1
  p10 = (((int)(r118)) != ((int)(1)));
  // PTX:433 mov.u64 %rd226, %rd19
  asm("mov.u64 %0, %1;" : "=l"(rd226) : "l"(rd19));
  // PTX:434 @%p10 bra $L__BB52_21
  if (p10) { goto L_BB52_21; }
  // PTX:436 mov.u64 %rd226, %rd18
  asm("mov.u64 %0, %1;" : "=l"(rd226) : "l"(rd18));
  // PTX:437 bra.uni $L__BB52_21
  goto L_BB52_21;
  // PTX:439 $L__BB52_20:
L_BB52_20:;
  // PTX:440 mov.u64 %rd226, %rd15
  asm("mov.u64 %0, %1;" : "=l"(rd226) : "l"(rd15));
  // PTX:442 $L__BB52_21:
L_BB52_21:;
  // PTX:443 mul.f32 %f264, %f53, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f264) : "f"(f53), "f"(f15));
  // PTX:444 ld.local.f32 %f265, [%rd226]
  f265 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd226) + (0)))));
  // PTX:445 mul.f32 %f266, %f265, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f266) : "f"(f265), "f"(f16));
  // PTX:446 mul.f32 %f267, %f31, %f266
  asm("mul.f32 %0, %1, %2;" : "=f"(f267) : "f"(f31), "f"(f266));
  // PTX:447 fma.rn.f32 %f54, %f30, %f264, %f267
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f54) : "f"(f30), "f"(f264), "f"(f267));
  // PTX:448 mul.f32 %f268, %f26, %f264
  asm("mul.f32 %0, %1, %2;" : "=f"(f268) : "f"(f26), "f"(f264));
  // PTX:449 mul.f32 %f269, %f27, %f266
  asm("mul.f32 %0, %1, %2;" : "=f"(f269) : "f"(f27), "f"(f266));
  // PTX:450 mul.f32 %f270, %f269, %f41
  asm("mul.f32 %0, %1, %2;" : "=f"(f270) : "f"(f269), "f"(f41));
  // PTX:451 mul.f32 %f271, %f269, %f42
  asm("mul.f32 %0, %1, %2;" : "=f"(f271) : "f"(f269), "f"(f42));
  // PTX:452 mul.f32 %f272, %f269, %f43
  asm("mul.f32 %0, %1, %2;" : "=f"(f272) : "f"(f269), "f"(f43));
  // PTX:453 mul.f32 %f273, %f269, %f44
  asm("mul.f32 %0, %1, %2;" : "=f"(f273) : "f"(f269), "f"(f44));
  // PTX:454 mul.f32 %f274, %f269, %f45
  asm("mul.f32 %0, %1, %2;" : "=f"(f274) : "f"(f269), "f"(f45));
  // PTX:455 mul.f32 %f275, %f269, %f46
  asm("mul.f32 %0, %1, %2;" : "=f"(f275) : "f"(f269), "f"(f46));
  // PTX:456 mul.f32 %f276, %f269, %f47
  asm("mul.f32 %0, %1, %2;" : "=f"(f276) : "f"(f269), "f"(f47));
  // PTX:457 mul.f32 %f277, %f269, %f48
  asm("mul.f32 %0, %1, %2;" : "=f"(f277) : "f"(f269), "f"(f48));
  // PTX:458 mul.f32 %f278, %f269, %f49
  asm("mul.f32 %0, %1, %2;" : "=f"(f278) : "f"(f269), "f"(f49));
  // PTX:459 fma.rn.f32 %f279, %f268, %f32, %f270
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f279) : "f"(f268), "f"(f32), "f"(f270));
  // PTX:460 fma.rn.f32 %f280, %f268, %f33, %f271
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f280) : "f"(f268), "f"(f33), "f"(f271));
  // PTX:461 fma.rn.f32 %f281, %f268, %f34, %f272
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f281) : "f"(f268), "f"(f34), "f"(f272));
  // PTX:462 fma.rn.f32 %f282, %f268, %f35, %f273
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f282) : "f"(f268), "f"(f35), "f"(f273));
  // PTX:463 fma.rn.f32 %f283, %f268, %f36, %f274
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f283) : "f"(f268), "f"(f36), "f"(f274));
  // PTX:464 fma.rn.f32 %f284, %f268, %f37, %f275
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f284) : "f"(f268), "f"(f37), "f"(f275));
  // PTX:465 fma.rn.f32 %f285, %f268, %f38, %f276
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f285) : "f"(f268), "f"(f38), "f"(f276));
  // PTX:466 fma.rn.f32 %f286, %f268, %f39, %f277
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f286) : "f"(f268), "f"(f39), "f"(f277));
  // PTX:467 fma.rn.f32 %f287, %f268, %f40, %f278
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f287) : "f"(f268), "f"(f40), "f"(f278));
  // PTX:468 mul.f32 %f288, %f50, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f288) : "f"(f50), "f"(f17));
  // PTX:469 mul.f32 %f289, %f51, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f289) : "f"(f51), "f"(f17));
  // PTX:470 mul.f32 %f290, %f52, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f290) : "f"(f52), "f"(f17));
  // PTX:471 mul.f32 %f291, %f50, %f18
  asm("mul.f32 %0, %1, %2;" : "=f"(f291) : "f"(f50), "f"(f18));
  // PTX:472 mul.f32 %f292, %f51, %f18
  asm("mul.f32 %0, %1, %2;" : "=f"(f292) : "f"(f51), "f"(f18));
  // PTX:473 mul.f32 %f293, %f52, %f18
  asm("mul.f32 %0, %1, %2;" : "=f"(f293) : "f"(f52), "f"(f18));
  // PTX:474 mul.f32 %f294, %f50, %f19
  asm("mul.f32 %0, %1, %2;" : "=f"(f294) : "f"(f50), "f"(f19));
  // PTX:475 mul.f32 %f295, %f51, %f19
  asm("mul.f32 %0, %1, %2;" : "=f"(f295) : "f"(f51), "f"(f19));
  // PTX:476 mul.f32 %f296, %f52, %f19
  asm("mul.f32 %0, %1, %2;" : "=f"(f296) : "f"(f52), "f"(f19));
  // PTX:477 fma.rn.f32 %f55, %f28, %f288, %f279
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f55) : "f"(f28), "f"(f288), "f"(f279));
  // PTX:478 fma.rn.f32 %f56, %f28, %f289, %f280
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f56) : "f"(f28), "f"(f289), "f"(f280));
  // PTX:479 fma.rn.f32 %f57, %f28, %f290, %f281
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f57) : "f"(f28), "f"(f290), "f"(f281));
  // PTX:480 fma.rn.f32 %f58, %f28, %f291, %f282
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f58) : "f"(f28), "f"(f291), "f"(f282));
  // PTX:481 fma.rn.f32 %f59, %f28, %f292, %f283
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f59) : "f"(f28), "f"(f292), "f"(f283));
  // PTX:482 fma.rn.f32 %f60, %f28, %f293, %f284
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f60) : "f"(f28), "f"(f293), "f"(f284));
  // PTX:483 fma.rn.f32 %f61, %f28, %f294, %f285
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f61) : "f"(f28), "f"(f294), "f"(f285));
  // PTX:484 fma.rn.f32 %f62, %f28, %f295, %f286
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f62) : "f"(f28), "f"(f295), "f"(f286));
  // PTX:485 fma.rn.f32 %f63, %f28, %f296, %f287
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f63) : "f"(f28), "f"(f296), "f"(f287));
  // PTX:486 @%p7 bra $L__BB52_24
  if (p7) { goto L_BB52_24; }
  // PTX:488 setp.ne.s32 %p12, %r118, 1
  p12 = (((int)(r118)) != ((int)(1)));
  // PTX:489 mov.u64 %rd227, %rd13
  asm("mov.u64 %0, %1;" : "=l"(rd227) : "l"(rd13));
  // PTX:490 mov.u32 %r119, %r1
  asm("mov.u32 %0, %1;" : "=r"(r119) : "r"(r1));
  // PTX:491 @%p12 bra $L__BB52_25
  if (p12) { goto L_BB52_25; }
  // PTX:493 mov.u64 %rd227, %rd12
  asm("mov.u64 %0, %1;" : "=l"(rd227) : "l"(rd12));
  // PTX:494 mov.u32 %r119, %r2
  asm("mov.u32 %0, %1;" : "=r"(r119) : "r"(r2));
  // PTX:495 bra.uni $L__BB52_25
  goto L_BB52_25;
  // PTX:497 $L__BB52_24:
L_BB52_24:;
  // PTX:498 mov.u64 %rd227, %rd14
  asm("mov.u64 %0, %1;" : "=l"(rd227) : "l"(rd14));
  // PTX:499 mov.u32 %r119, %r3
  asm("mov.u32 %0, %1;" : "=r"(r119) : "r"(r3));
  // PTX:501 $L__BB52_25:
L_BB52_25:;
  // PTX:502 mul.f32 %f297, %f54, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f297) : "f"(f54));
  // PTX:503 sub.f32 %f298, %f56, %f297
  asm("sub.f32 %0, %1, %2;" : "=f"(f298) : "f"(f56), "f"(f297));
  // PTX:504 sub.f32 %f299, %f57, %f297
  asm("sub.f32 %0, %1, %2;" : "=f"(f299) : "f"(f57), "f"(f297));
  // PTX:505 sub.f32 %f300, %f58, %f297
  asm("sub.f32 %0, %1, %2;" : "=f"(f300) : "f"(f58), "f"(f297));
  // PTX:506 sub.f32 %f301, %f60, %f297
  asm("sub.f32 %0, %1, %2;" : "=f"(f301) : "f"(f60), "f"(f297));
  // PTX:507 sub.f32 %f302, %f61, %f297
  asm("sub.f32 %0, %1, %2;" : "=f"(f302) : "f"(f61), "f"(f297));
  // PTX:508 sub.f32 %f303, %f62, %f297
  asm("sub.f32 %0, %1, %2;" : "=f"(f303) : "f"(f62), "f"(f297));
  // PTX:509 sub.f32 %f304, %f55, %f54
  asm("sub.f32 %0, %1, %2;" : "=f"(f304) : "f"(f55), "f"(f54));
  // PTX:510 mul.f32 %f64, %f29, %f304
  asm("mul.f32 %0, %1, %2;" : "=f"(f64) : "f"(f29), "f"(f304));
  // PTX:511 mul.f32 %f65, %f29, %f298
  asm("mul.f32 %0, %1, %2;" : "=f"(f65) : "f"(f29), "f"(f298));
  // PTX:512 mul.f32 %f66, %f29, %f299
  asm("mul.f32 %0, %1, %2;" : "=f"(f66) : "f"(f29), "f"(f299));
  // PTX:513 mul.f32 %f67, %f29, %f300
  asm("mul.f32 %0, %1, %2;" : "=f"(f67) : "f"(f29), "f"(f300));
  // PTX:514 sub.f32 %f305, %f59, %f54
  asm("sub.f32 %0, %1, %2;" : "=f"(f305) : "f"(f59), "f"(f54));
  // PTX:515 mul.f32 %f68, %f29, %f305
  asm("mul.f32 %0, %1, %2;" : "=f"(f68) : "f"(f29), "f"(f305));
  // PTX:516 mul.f32 %f69, %f29, %f301
  asm("mul.f32 %0, %1, %2;" : "=f"(f69) : "f"(f29), "f"(f301));
  // PTX:517 mul.f32 %f70, %f29, %f302
  asm("mul.f32 %0, %1, %2;" : "=f"(f70) : "f"(f29), "f"(f302));
  // PTX:518 mul.f32 %f71, %f29, %f303
  asm("mul.f32 %0, %1, %2;" : "=f"(f71) : "f"(f29), "f"(f303));
  // PTX:519 sub.f32 %f306, %f63, %f54
  asm("sub.f32 %0, %1, %2;" : "=f"(f306) : "f"(f63), "f"(f54));
  // PTX:520 mul.f32 %f72, %f29, %f306
  asm("mul.f32 %0, %1, %2;" : "=f"(f72) : "f"(f29), "f"(f306));
  // PTX:521 setp.eq.s32 %p13, %r119, %r1
  p13 = (((int)(r119)) == ((int)(r1)));
  // PTX:522 @%p13 bra $L__BB52_32
  if (p13) { goto L_BB52_32; }
  // PTX:523 bra.uni $L__BB52_26
  goto L_BB52_26;
  // PTX:525 $L__BB52_32:
L_BB52_32:;
  // PTX:526 mul.lo.s64 %rd137, %rd227, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd137) : "l"(rd227));
  // PTX:527 add.s64 %rd138, %rd1, %rd137
  asm("add.s64 %0, %1, %2;" : "=l"(rd138) : "l"(rd1), "l"(rd137));
  // PTX:528 red.global.add.f32 [%rd138], %f64
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd138) + (0)))), (float)(f64));
  // PTX:529 add.s64 %rd139, %rd138, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd139) : "l"(rd138));
  // PTX:530 red.global.add.f32 [%rd139], %f65
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd139) + (0)))), (float)(f65));
  // PTX:531 add.s64 %rd140, %rd138, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd140) : "l"(rd138));
  // PTX:532 red.global.add.f32 [%rd140], %f66
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd140) + (0)))), (float)(f66));
  // PTX:533 add.s64 %rd141, %rd138, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd141) : "l"(rd138));
  // PTX:534 red.global.add.f32 [%rd141], %f67
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd141) + (0)))), (float)(f67));
  // PTX:535 add.s64 %rd142, %rd138, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd142) : "l"(rd138));
  // PTX:536 red.global.add.f32 [%rd142], %f68
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd142) + (0)))), (float)(f68));
  // PTX:537 add.s64 %rd143, %rd138, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd143) : "l"(rd138));
  // PTX:538 red.global.add.f32 [%rd143], %f69
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd143) + (0)))), (float)(f69));
  // PTX:539 add.s64 %rd144, %rd138, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd144) : "l"(rd138));
  // PTX:540 red.global.add.f32 [%rd144], %f70
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd144) + (0)))), (float)(f70));
  // PTX:541 add.s64 %rd145, %rd138, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd145) : "l"(rd138));
  // PTX:542 red.global.add.f32 [%rd145], %f71
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd145) + (0)))), (float)(f71));
  // PTX:543 add.s64 %rd146, %rd138, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd146) : "l"(rd138));
  // PTX:544 red.global.add.f32 [%rd146], %f72
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd146) + (0)))), (float)(f72));
  // PTX:545 bra.uni $L__BB52_33
  goto L_BB52_33;
  // PTX:547 $L__BB52_26:
L_BB52_26:;
  // PTX:548 shl.b64 %rd111, %rd227, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd111) : "l"(rd227));
  // PTX:549 add.s64 %rd112, %rd3, %rd111
  asm("add.s64 %0, %1, %2;" : "=l"(rd112) : "l"(rd3), "l"(rd111));
  // PTX:550 ld.global.s32 %rd113, [%rd112]
  rd113 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd112) + (0)))));
  // PTX:551 mov.u64 %rd230, 0
  asm("mov.u64 %0, 0;" : "=l"(rd230) : );
  // PTX:552 min.u64 %rd30, %rd113, %rd74
  asm("min.u64 %0, %1, %2;" : "=l"(rd30) : "l"(rd113), "l"(rd74));
  // PTX:553 setp.eq.s64 %p14, %rd30, 0
  p14 = (((long long)(rd30)) == ((long long)(0)));
  // PTX:554 @%p14 bra $L__BB52_29
  if (p14) { goto L_BB52_29; }
  // PTX:556 mov.u64 %rd230, 0
  asm("mov.u64 %0, 0;" : "=l"(rd230) : );
  // PTX:557 mov.u64 %rd228, %rd30
  asm("mov.u64 %0, %1;" : "=l"(rd228) : "l"(rd30));
  // PTX:559 $L__BB52_28:
L_BB52_28:;
  // PTX:560 sub.s64 %rd115, %rd228, %rd230
  asm("sub.s64 %0, %1, %2;" : "=l"(rd115) : "l"(rd228), "l"(rd230));
  // PTX:561 shr.u64 %rd116, %rd115, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd116) : "l"(rd115));
  // PTX:562 add.s64 %rd117, %rd116, %rd230
  asm("add.s64 %0, %1, %2;" : "=l"(rd117) : "l"(rd116), "l"(rd230));
  // PTX:563 mul.lo.s64 %rd118, %rd117, %rd77
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd118) : "l"(rd117), "l"(rd77));
  // PTX:564 add.s64 %rd119, %rd118, %rd227
  asm("add.s64 %0, %1, %2;" : "=l"(rd119) : "l"(rd118), "l"(rd227));
  // PTX:565 mul.lo.s64 %rd120, %rd119, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd120) : "l"(rd119));
  // PTX:566 add.s64 %rd121, %rd2, %rd120
  asm("add.s64 %0, %1, %2;" : "=l"(rd121) : "l"(rd2), "l"(rd120));
  // PTX:567 ld.global.u32 %r94, [%rd121]
  r94 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd121) + (0)))));
  // PTX:568 setp.lt.s32 %p15, %r94, %r1
  p15 = (((int)(r94)) < ((int)(r1)));
  // PTX:569 add.s64 %rd122, %rd117, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd122) : "l"(rd117));
  // PTX:570 selp.b64 %rd230, %rd122, %rd230, %p15
  rd230 = p15 ? rd122 : rd230;
  // PTX:571 selp.b64 %rd228, %rd228, %rd117, %p15
  rd228 = p15 ? rd228 : rd117;
  // PTX:572 setp.gt.u64 %p16, %rd228, %rd230
  p16 = (((unsigned long long)(rd228)) > ((unsigned long long)(rd230)));
  // PTX:573 @%p16 bra $L__BB52_28
  if (p16) { goto L_BB52_28; }
  // PTX:575 $L__BB52_29:
L_BB52_29:;
  // PTX:576 setp.ge.u64 %p17, %rd230, %rd30
  p17 = (((unsigned long long)(rd230)) >= ((unsigned long long)(rd30)));
  // PTX:577 @%p17 bra $L__BB52_33
  if (p17) { goto L_BB52_33; }
  // PTX:579 mul.lo.s64 %rd123, %rd230, %rd77
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd123) : "l"(rd230), "l"(rd77));
  // PTX:580 add.s64 %rd36, %rd123, %rd227
  asm("add.s64 %0, %1, %2;" : "=l"(rd36) : "l"(rd123), "l"(rd227));
  // PTX:581 mul.lo.s64 %rd124, %rd36, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd124) : "l"(rd36));
  // PTX:582 add.s64 %rd125, %rd2, %rd124
  asm("add.s64 %0, %1, %2;" : "=l"(rd125) : "l"(rd2), "l"(rd124));
  // PTX:583 ld.global.u32 %r95, [%rd125]
  r95 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd125) + (0)))));
  // PTX:584 setp.ne.s32 %p18, %r95, %r1
  p18 = (((int)(r95)) != ((int)(r1)));
  // PTX:585 @%p18 bra $L__BB52_33
  if (p18) { goto L_BB52_33; }
  // PTX:587 add.s64 %rd128, %rd125, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd128) : "l"(rd125));
  // PTX:588 red.global.add.f32 [%rd128], %f64
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd128) + (0)))), (float)(f64));
  // PTX:589 add.s64 %rd129, %rd125, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd129) : "l"(rd125));
  // PTX:590 red.global.add.f32 [%rd129], %f65
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd129) + (0)))), (float)(f65));
  // PTX:591 add.s64 %rd130, %rd125, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd130) : "l"(rd125));
  // PTX:592 red.global.add.f32 [%rd130], %f66
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd130) + (0)))), (float)(f66));
  // PTX:593 add.s64 %rd131, %rd125, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd131) : "l"(rd125));
  // PTX:594 red.global.add.f32 [%rd131], %f67
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd131) + (0)))), (float)(f67));
  // PTX:595 add.s64 %rd132, %rd125, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd132) : "l"(rd125));
  // PTX:596 red.global.add.f32 [%rd132], %f68
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd132) + (0)))), (float)(f68));
  // PTX:597 add.s64 %rd133, %rd125, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd133) : "l"(rd125));
  // PTX:598 red.global.add.f32 [%rd133], %f69
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd133) + (0)))), (float)(f69));
  // PTX:599 add.s64 %rd134, %rd125, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd134) : "l"(rd125));
  // PTX:600 red.global.add.f32 [%rd134], %f70
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd134) + (0)))), (float)(f70));
  // PTX:601 add.s64 %rd135, %rd125, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd135) : "l"(rd125));
  // PTX:602 red.global.add.f32 [%rd135], %f71
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd135) + (0)))), (float)(f71));
  // PTX:603 add.s64 %rd136, %rd125, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd136) : "l"(rd125));
  // PTX:604 red.global.add.f32 [%rd136], %f72
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd136) + (0)))), (float)(f72));
  // PTX:606 $L__BB52_33:
L_BB52_33:;
  // PTX:607 setp.eq.s32 %p19, %r118, 1
  p19 = (((int)(r118)) == ((int)(1)));
  // PTX:608 mov.u64 %rd231, %rd17
  asm("mov.u64 %0, %1;" : "=l"(rd231) : "l"(rd17));
  // PTX:609 @%p19 bra $L__BB52_36
  if (p19) { goto L_BB52_36; }
  // PTX:611 setp.ne.s32 %p20, %r118, 2
  p20 = (((int)(r118)) != ((int)(2)));
  // PTX:612 mov.u64 %rd231, %rd16
  asm("mov.u64 %0, %1;" : "=l"(rd231) : "l"(rd16));
  // PTX:613 @%p20 bra $L__BB52_35
  if (p20) { goto L_BB52_35; }
  // PTX:614 bra.uni $L__BB52_36
  goto L_BB52_36;
  // PTX:616 $L__BB52_35:
L_BB52_35:;
  // PTX:617 mov.u64 %rd231, %rd20
  asm("mov.u64 %0, %1;" : "=l"(rd231) : "l"(rd20));
  // PTX:619 $L__BB52_36:
L_BB52_36:;
  // PTX:620 ld.local.f32 %f73, [%rd231]
  f73 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd231) + (0)))));
  // PTX:621 mov.u64 %rd232, %rd18
  asm("mov.u64 %0, %1;" : "=l"(rd232) : "l"(rd18));
  // PTX:622 @%p19 bra $L__BB52_39
  if (p19) { goto L_BB52_39; }
  // PTX:624 setp.ne.s32 %p22, %r118, 2
  p22 = (((int)(r118)) != ((int)(2)));
  // PTX:625 mov.u64 %rd232, %rd15
  asm("mov.u64 %0, %1;" : "=l"(rd232) : "l"(rd15));
  // PTX:626 @%p22 bra $L__BB52_38
  if (p22) { goto L_BB52_38; }
  // PTX:627 bra.uni $L__BB52_39
  goto L_BB52_39;
  // PTX:629 $L__BB52_38:
L_BB52_38:;
  // PTX:630 mov.u64 %rd232, %rd19
  asm("mov.u64 %0, %1;" : "=l"(rd232) : "l"(rd19));
  // PTX:632 $L__BB52_39:
L_BB52_39:;
  // PTX:633 mul.f32 %f325, %f73, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f325) : "f"(f73), "f"(f1));
  // PTX:634 ld.local.f32 %f326, [%rd232]
  f326 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd232) + (0)))));
  // PTX:635 mul.f32 %f327, %f326, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f327) : "f"(f326), "f"(f6));
  // PTX:636 mul.f32 %f328, %f31, %f327
  asm("mul.f32 %0, %1, %2;" : "=f"(f328) : "f"(f31), "f"(f327));
  // PTX:637 fma.rn.f32 %f74, %f30, %f325, %f328
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f74) : "f"(f30), "f"(f325), "f"(f328));
  // PTX:638 mul.f32 %f329, %f26, %f325
  asm("mul.f32 %0, %1, %2;" : "=f"(f329) : "f"(f26), "f"(f325));
  // PTX:639 mul.f32 %f330, %f27, %f327
  asm("mul.f32 %0, %1, %2;" : "=f"(f330) : "f"(f27), "f"(f327));
  // PTX:640 mul.f32 %f331, %f330, %f41
  asm("mul.f32 %0, %1, %2;" : "=f"(f331) : "f"(f330), "f"(f41));
  // PTX:641 mul.f32 %f332, %f330, %f42
  asm("mul.f32 %0, %1, %2;" : "=f"(f332) : "f"(f330), "f"(f42));
  // PTX:642 mul.f32 %f333, %f330, %f43
  asm("mul.f32 %0, %1, %2;" : "=f"(f333) : "f"(f330), "f"(f43));
  // PTX:643 mul.f32 %f334, %f330, %f44
  asm("mul.f32 %0, %1, %2;" : "=f"(f334) : "f"(f330), "f"(f44));
  // PTX:644 mul.f32 %f335, %f330, %f45
  asm("mul.f32 %0, %1, %2;" : "=f"(f335) : "f"(f330), "f"(f45));
  // PTX:645 mul.f32 %f336, %f330, %f46
  asm("mul.f32 %0, %1, %2;" : "=f"(f336) : "f"(f330), "f"(f46));
  // PTX:646 mul.f32 %f337, %f330, %f47
  asm("mul.f32 %0, %1, %2;" : "=f"(f337) : "f"(f330), "f"(f47));
  // PTX:647 mul.f32 %f338, %f330, %f48
  asm("mul.f32 %0, %1, %2;" : "=f"(f338) : "f"(f330), "f"(f48));
  // PTX:648 mul.f32 %f339, %f330, %f49
  asm("mul.f32 %0, %1, %2;" : "=f"(f339) : "f"(f330), "f"(f49));
  // PTX:649 fma.rn.f32 %f340, %f329, %f32, %f331
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f340) : "f"(f329), "f"(f32), "f"(f331));
  // PTX:650 fma.rn.f32 %f341, %f329, %f33, %f332
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f341) : "f"(f329), "f"(f33), "f"(f332));
  // PTX:651 fma.rn.f32 %f342, %f329, %f34, %f333
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f342) : "f"(f329), "f"(f34), "f"(f333));
  // PTX:652 fma.rn.f32 %f343, %f329, %f35, %f334
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f343) : "f"(f329), "f"(f35), "f"(f334));
  // PTX:653 fma.rn.f32 %f344, %f329, %f36, %f335
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f344) : "f"(f329), "f"(f36), "f"(f335));
  // PTX:654 fma.rn.f32 %f345, %f329, %f37, %f336
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f345) : "f"(f329), "f"(f37), "f"(f336));
  // PTX:655 fma.rn.f32 %f346, %f329, %f38, %f337
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f346) : "f"(f329), "f"(f38), "f"(f337));
  // PTX:656 fma.rn.f32 %f347, %f329, %f39, %f338
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f347) : "f"(f329), "f"(f39), "f"(f338));
  // PTX:657 fma.rn.f32 %f348, %f329, %f40, %f339
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f348) : "f"(f329), "f"(f40), "f"(f339));
  // PTX:658 mul.f32 %f349, %f50, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f349) : "f"(f50), "f"(f20));
  // PTX:659 mul.f32 %f350, %f51, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f350) : "f"(f51), "f"(f20));
  // PTX:660 mul.f32 %f351, %f52, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f351) : "f"(f52), "f"(f20));
  // PTX:661 mul.f32 %f352, %f50, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f352) : "f"(f50), "f"(f21));
  // PTX:662 mul.f32 %f353, %f51, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f353) : "f"(f51), "f"(f21));
  // PTX:663 mul.f32 %f354, %f52, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f354) : "f"(f52), "f"(f21));
  // PTX:664 mul.f32 %f355, %f50, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f355) : "f"(f50), "f"(f22));
  // PTX:665 mul.f32 %f356, %f51, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f356) : "f"(f51), "f"(f22));
  // PTX:666 mul.f32 %f357, %f52, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f357) : "f"(f52), "f"(f22));
  // PTX:667 fma.rn.f32 %f75, %f28, %f349, %f340
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f75) : "f"(f28), "f"(f349), "f"(f340));
  // PTX:668 fma.rn.f32 %f76, %f28, %f350, %f341
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f76) : "f"(f28), "f"(f350), "f"(f341));
  // PTX:669 fma.rn.f32 %f77, %f28, %f351, %f342
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f77) : "f"(f28), "f"(f351), "f"(f342));
  // PTX:670 fma.rn.f32 %f78, %f28, %f352, %f343
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f78) : "f"(f28), "f"(f352), "f"(f343));
  // PTX:671 fma.rn.f32 %f79, %f28, %f353, %f344
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f79) : "f"(f28), "f"(f353), "f"(f344));
  // PTX:672 fma.rn.f32 %f80, %f28, %f354, %f345
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f80) : "f"(f28), "f"(f354), "f"(f345));
  // PTX:673 fma.rn.f32 %f81, %f28, %f355, %f346
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f81) : "f"(f28), "f"(f355), "f"(f346));
  // PTX:674 fma.rn.f32 %f82, %f28, %f356, %f347
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f82) : "f"(f28), "f"(f356), "f"(f347));
  // PTX:675 fma.rn.f32 %f83, %f28, %f357, %f348
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f83) : "f"(f28), "f"(f357), "f"(f348));
  // PTX:676 @%p7 bra $L__BB52_42
  if (p7) { goto L_BB52_42; }
  // PTX:678 setp.ne.s32 %p24, %r118, 1
  p24 = (((int)(r118)) != ((int)(1)));
  // PTX:679 mov.u64 %rd233, %rd13
  asm("mov.u64 %0, %1;" : "=l"(rd233) : "l"(rd13));
  // PTX:680 mov.u32 %r120, %r1
  asm("mov.u32 %0, %1;" : "=r"(r120) : "r"(r1));
  // PTX:681 @%p24 bra $L__BB52_43
  if (p24) { goto L_BB52_43; }
  // PTX:683 mov.u64 %rd233, %rd12
  asm("mov.u64 %0, %1;" : "=l"(rd233) : "l"(rd12));
  // PTX:684 mov.u32 %r120, %r2
  asm("mov.u32 %0, %1;" : "=r"(r120) : "r"(r2));
  // PTX:685 bra.uni $L__BB52_43
  goto L_BB52_43;
  // PTX:687 $L__BB52_42:
L_BB52_42:;
  // PTX:688 mov.u64 %rd233, %rd14
  asm("mov.u64 %0, %1;" : "=l"(rd233) : "l"(rd14));
  // PTX:689 mov.u32 %r120, %r3
  asm("mov.u32 %0, %1;" : "=r"(r120) : "r"(r3));
  // PTX:691 $L__BB52_43:
L_BB52_43:;
  // PTX:692 mul.f32 %f358, %f74, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f358) : "f"(f74));
  // PTX:693 sub.f32 %f359, %f76, %f358
  asm("sub.f32 %0, %1, %2;" : "=f"(f359) : "f"(f76), "f"(f358));
  // PTX:694 sub.f32 %f360, %f77, %f358
  asm("sub.f32 %0, %1, %2;" : "=f"(f360) : "f"(f77), "f"(f358));
  // PTX:695 sub.f32 %f361, %f78, %f358
  asm("sub.f32 %0, %1, %2;" : "=f"(f361) : "f"(f78), "f"(f358));
  // PTX:696 sub.f32 %f362, %f80, %f358
  asm("sub.f32 %0, %1, %2;" : "=f"(f362) : "f"(f80), "f"(f358));
  // PTX:697 sub.f32 %f363, %f81, %f358
  asm("sub.f32 %0, %1, %2;" : "=f"(f363) : "f"(f81), "f"(f358));
  // PTX:698 sub.f32 %f364, %f82, %f358
  asm("sub.f32 %0, %1, %2;" : "=f"(f364) : "f"(f82), "f"(f358));
  // PTX:699 sub.f32 %f365, %f75, %f74
  asm("sub.f32 %0, %1, %2;" : "=f"(f365) : "f"(f75), "f"(f74));
  // PTX:700 mul.f32 %f84, %f29, %f365
  asm("mul.f32 %0, %1, %2;" : "=f"(f84) : "f"(f29), "f"(f365));
  // PTX:701 mul.f32 %f85, %f29, %f359
  asm("mul.f32 %0, %1, %2;" : "=f"(f85) : "f"(f29), "f"(f359));
  // PTX:702 mul.f32 %f86, %f29, %f360
  asm("mul.f32 %0, %1, %2;" : "=f"(f86) : "f"(f29), "f"(f360));
  // PTX:703 mul.f32 %f87, %f29, %f361
  asm("mul.f32 %0, %1, %2;" : "=f"(f87) : "f"(f29), "f"(f361));
  // PTX:704 sub.f32 %f366, %f79, %f74
  asm("sub.f32 %0, %1, %2;" : "=f"(f366) : "f"(f79), "f"(f74));
  // PTX:705 mul.f32 %f88, %f29, %f366
  asm("mul.f32 %0, %1, %2;" : "=f"(f88) : "f"(f29), "f"(f366));
  // PTX:706 mul.f32 %f89, %f29, %f362
  asm("mul.f32 %0, %1, %2;" : "=f"(f89) : "f"(f29), "f"(f362));
  // PTX:707 mul.f32 %f90, %f29, %f363
  asm("mul.f32 %0, %1, %2;" : "=f"(f90) : "f"(f29), "f"(f363));
  // PTX:708 mul.f32 %f91, %f29, %f364
  asm("mul.f32 %0, %1, %2;" : "=f"(f91) : "f"(f29), "f"(f364));
  // PTX:709 sub.f32 %f367, %f83, %f74
  asm("sub.f32 %0, %1, %2;" : "=f"(f367) : "f"(f83), "f"(f74));
  // PTX:710 mul.f32 %f92, %f29, %f367
  asm("mul.f32 %0, %1, %2;" : "=f"(f92) : "f"(f29), "f"(f367));
  // PTX:711 setp.eq.s32 %p25, %r120, %r2
  p25 = (((int)(r120)) == ((int)(r2)));
  // PTX:712 @%p25 bra $L__BB52_50
  if (p25) { goto L_BB52_50; }
  // PTX:713 bra.uni $L__BB52_44
  goto L_BB52_44;
  // PTX:715 $L__BB52_50:
L_BB52_50:;
  // PTX:716 mul.lo.s64 %rd174, %rd233, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd174) : "l"(rd233));
  // PTX:717 add.s64 %rd175, %rd1, %rd174
  asm("add.s64 %0, %1, %2;" : "=l"(rd175) : "l"(rd1), "l"(rd174));
  // PTX:718 red.global.add.f32 [%rd175], %f84
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd175) + (0)))), (float)(f84));
  // PTX:719 add.s64 %rd176, %rd175, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd176) : "l"(rd175));
  // PTX:720 red.global.add.f32 [%rd176], %f85
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd176) + (0)))), (float)(f85));
  // PTX:721 add.s64 %rd177, %rd175, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd177) : "l"(rd175));
  // PTX:722 red.global.add.f32 [%rd177], %f86
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd177) + (0)))), (float)(f86));
  // PTX:723 add.s64 %rd178, %rd175, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd178) : "l"(rd175));
  // PTX:724 red.global.add.f32 [%rd178], %f87
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd178) + (0)))), (float)(f87));
  // PTX:725 add.s64 %rd179, %rd175, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd179) : "l"(rd175));
  // PTX:726 red.global.add.f32 [%rd179], %f88
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd179) + (0)))), (float)(f88));
  // PTX:727 add.s64 %rd180, %rd175, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd180) : "l"(rd175));
  // PTX:728 red.global.add.f32 [%rd180], %f89
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (0)))), (float)(f89));
  // PTX:729 add.s64 %rd181, %rd175, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd181) : "l"(rd175));
  // PTX:730 red.global.add.f32 [%rd181], %f90
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd181) + (0)))), (float)(f90));
  // PTX:731 add.s64 %rd182, %rd175, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd182) : "l"(rd175));
  // PTX:732 red.global.add.f32 [%rd182], %f91
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd182) + (0)))), (float)(f91));
  // PTX:733 add.s64 %rd183, %rd175, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd183) : "l"(rd175));
  // PTX:734 red.global.add.f32 [%rd183], %f92
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd183) + (0)))), (float)(f92));
  // PTX:735 bra.uni $L__BB52_51
  goto L_BB52_51;
  // PTX:737 $L__BB52_44:
L_BB52_44:;
  // PTX:738 shl.b64 %rd148, %rd233, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd148) : "l"(rd233));
  // PTX:739 add.s64 %rd149, %rd3, %rd148
  asm("add.s64 %0, %1, %2;" : "=l"(rd149) : "l"(rd3), "l"(rd148));
  // PTX:740 ld.global.s32 %rd150, [%rd149]
  rd150 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd149) + (0)))));
  // PTX:741 mov.u64 %rd236, 0
  asm("mov.u64 %0, 0;" : "=l"(rd236) : );
  // PTX:742 min.u64 %rd46, %rd150, %rd74
  asm("min.u64 %0, %1, %2;" : "=l"(rd46) : "l"(rd150), "l"(rd74));
  // PTX:743 setp.eq.s64 %p26, %rd46, 0
  p26 = (((long long)(rd46)) == ((long long)(0)));
  // PTX:744 @%p26 bra $L__BB52_47
  if (p26) { goto L_BB52_47; }
  // PTX:746 mov.u64 %rd236, 0
  asm("mov.u64 %0, 0;" : "=l"(rd236) : );
  // PTX:747 mov.u64 %rd234, %rd46
  asm("mov.u64 %0, %1;" : "=l"(rd234) : "l"(rd46));
  // PTX:749 $L__BB52_46:
L_BB52_46:;
  // PTX:750 sub.s64 %rd152, %rd234, %rd236
  asm("sub.s64 %0, %1, %2;" : "=l"(rd152) : "l"(rd234), "l"(rd236));
  // PTX:751 shr.u64 %rd153, %rd152, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd153) : "l"(rd152));
  // PTX:752 add.s64 %rd154, %rd153, %rd236
  asm("add.s64 %0, %1, %2;" : "=l"(rd154) : "l"(rd153), "l"(rd236));
  // PTX:753 mul.lo.s64 %rd155, %rd154, %rd77
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd155) : "l"(rd154), "l"(rd77));
  // PTX:754 add.s64 %rd156, %rd155, %rd233
  asm("add.s64 %0, %1, %2;" : "=l"(rd156) : "l"(rd155), "l"(rd233));
  // PTX:755 mul.lo.s64 %rd157, %rd156, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd157) : "l"(rd156));
  // PTX:756 add.s64 %rd158, %rd2, %rd157
  asm("add.s64 %0, %1, %2;" : "=l"(rd158) : "l"(rd2), "l"(rd157));
  // PTX:757 ld.global.u32 %r96, [%rd158]
  r96 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd158) + (0)))));
  // PTX:758 setp.lt.s32 %p27, %r96, %r2
  p27 = (((int)(r96)) < ((int)(r2)));
  // PTX:759 add.s64 %rd159, %rd154, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd159) : "l"(rd154));
  // PTX:760 selp.b64 %rd236, %rd159, %rd236, %p27
  rd236 = p27 ? rd159 : rd236;
  // PTX:761 selp.b64 %rd234, %rd234, %rd154, %p27
  rd234 = p27 ? rd234 : rd154;
  // PTX:762 setp.gt.u64 %p28, %rd234, %rd236
  p28 = (((unsigned long long)(rd234)) > ((unsigned long long)(rd236)));
  // PTX:763 @%p28 bra $L__BB52_46
  if (p28) { goto L_BB52_46; }
  // PTX:765 $L__BB52_47:
L_BB52_47:;
  // PTX:766 setp.ge.u64 %p29, %rd236, %rd46
  p29 = (((unsigned long long)(rd236)) >= ((unsigned long long)(rd46)));
  // PTX:767 @%p29 bra $L__BB52_51
  if (p29) { goto L_BB52_51; }
  // PTX:769 mul.lo.s64 %rd160, %rd236, %rd77
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd160) : "l"(rd236), "l"(rd77));
  // PTX:770 add.s64 %rd52, %rd160, %rd233
  asm("add.s64 %0, %1, %2;" : "=l"(rd52) : "l"(rd160), "l"(rd233));
  // PTX:771 mul.lo.s64 %rd161, %rd52, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd161) : "l"(rd52));
  // PTX:772 add.s64 %rd162, %rd2, %rd161
  asm("add.s64 %0, %1, %2;" : "=l"(rd162) : "l"(rd2), "l"(rd161));
  // PTX:773 ld.global.u32 %r97, [%rd162]
  r97 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd162) + (0)))));
  // PTX:774 setp.ne.s32 %p30, %r97, %r2
  p30 = (((int)(r97)) != ((int)(r2)));
  // PTX:775 @%p30 bra $L__BB52_51
  if (p30) { goto L_BB52_51; }
  // PTX:777 add.s64 %rd165, %rd162, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd165) : "l"(rd162));
  // PTX:778 red.global.add.f32 [%rd165], %f84
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd165) + (0)))), (float)(f84));
  // PTX:779 add.s64 %rd166, %rd162, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd166) : "l"(rd162));
  // PTX:780 red.global.add.f32 [%rd166], %f85
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd166) + (0)))), (float)(f85));
  // PTX:781 add.s64 %rd167, %rd162, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd167) : "l"(rd162));
  // PTX:782 red.global.add.f32 [%rd167], %f86
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd167) + (0)))), (float)(f86));
  // PTX:783 add.s64 %rd168, %rd162, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd168) : "l"(rd162));
  // PTX:784 red.global.add.f32 [%rd168], %f87
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd168) + (0)))), (float)(f87));
  // PTX:785 add.s64 %rd169, %rd162, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd169) : "l"(rd162));
  // PTX:786 red.global.add.f32 [%rd169], %f88
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd169) + (0)))), (float)(f88));
  // PTX:787 add.s64 %rd170, %rd162, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd170) : "l"(rd162));
  // PTX:788 red.global.add.f32 [%rd170], %f89
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd170) + (0)))), (float)(f89));
  // PTX:789 add.s64 %rd171, %rd162, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd171) : "l"(rd162));
  // PTX:790 red.global.add.f32 [%rd171], %f90
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd171) + (0)))), (float)(f90));
  // PTX:791 add.s64 %rd172, %rd162, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd172) : "l"(rd162));
  // PTX:792 red.global.add.f32 [%rd172], %f91
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd172) + (0)))), (float)(f91));
  // PTX:793 add.s64 %rd173, %rd162, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd173) : "l"(rd162));
  // PTX:794 red.global.add.f32 [%rd173], %f92
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd173) + (0)))), (float)(f92));
  // PTX:796 $L__BB52_51:
L_BB52_51:;
  // PTX:797 mov.u64 %rd237, %rd17
  asm("mov.u64 %0, %1;" : "=l"(rd237) : "l"(rd17));
  // PTX:798 @%p19 bra $L__BB52_54
  if (p19) { goto L_BB52_54; }
  // PTX:800 setp.ne.s32 %p32, %r118, 2
  p32 = (((int)(r118)) != ((int)(2)));
  // PTX:801 mov.u64 %rd237, %rd16
  asm("mov.u64 %0, %1;" : "=l"(rd237) : "l"(rd16));
  // PTX:802 @%p32 bra $L__BB52_53
  if (p32) { goto L_BB52_53; }
  // PTX:803 bra.uni $L__BB52_54
  goto L_BB52_54;
  // PTX:805 $L__BB52_53:
L_BB52_53:;
  // PTX:806 mov.u64 %rd237, %rd20
  asm("mov.u64 %0, %1;" : "=l"(rd237) : "l"(rd20));
  // PTX:808 $L__BB52_54:
L_BB52_54:;
  // PTX:809 ld.local.f32 %f93, [%rd237]
  f93 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd237) + (0)))));
  // PTX:810 mov.u64 %rd238, %rd18
  asm("mov.u64 %0, %1;" : "=l"(rd238) : "l"(rd18));
  // PTX:811 @%p19 bra $L__BB52_57
  if (p19) { goto L_BB52_57; }
  // PTX:813 setp.ne.s32 %p34, %r118, 2
  p34 = (((int)(r118)) != ((int)(2)));
  // PTX:814 mov.u64 %rd238, %rd15
  asm("mov.u64 %0, %1;" : "=l"(rd238) : "l"(rd15));
  // PTX:815 @%p34 bra $L__BB52_56
  if (p34) { goto L_BB52_56; }
  // PTX:816 bra.uni $L__BB52_57
  goto L_BB52_57;
  // PTX:818 $L__BB52_56:
L_BB52_56:;
  // PTX:819 mov.u64 %rd238, %rd19
  asm("mov.u64 %0, %1;" : "=l"(rd238) : "l"(rd19));
  // PTX:821 $L__BB52_57:
L_BB52_57:;
  // PTX:822 mul.f32 %f386, %f93, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f386) : "f"(f93), "f"(f2));
  // PTX:823 ld.local.f32 %f387, [%rd238]
  f387 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd238) + (0)))));
  // PTX:824 mul.f32 %f388, %f387, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f388) : "f"(f387), "f"(f7));
  // PTX:825 mul.f32 %f389, %f31, %f388
  asm("mul.f32 %0, %1, %2;" : "=f"(f389) : "f"(f31), "f"(f388));
  // PTX:826 fma.rn.f32 %f94, %f30, %f386, %f389
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f94) : "f"(f30), "f"(f386), "f"(f389));
  // PTX:827 mul.f32 %f390, %f26, %f386
  asm("mul.f32 %0, %1, %2;" : "=f"(f390) : "f"(f26), "f"(f386));
  // PTX:828 mul.f32 %f391, %f27, %f388
  asm("mul.f32 %0, %1, %2;" : "=f"(f391) : "f"(f27), "f"(f388));
  // PTX:829 mul.f32 %f392, %f391, %f41
  asm("mul.f32 %0, %1, %2;" : "=f"(f392) : "f"(f391), "f"(f41));
  // PTX:830 mul.f32 %f393, %f391, %f42
  asm("mul.f32 %0, %1, %2;" : "=f"(f393) : "f"(f391), "f"(f42));
  // PTX:831 mul.f32 %f394, %f391, %f43
  asm("mul.f32 %0, %1, %2;" : "=f"(f394) : "f"(f391), "f"(f43));
  // PTX:832 mul.f32 %f395, %f391, %f44
  asm("mul.f32 %0, %1, %2;" : "=f"(f395) : "f"(f391), "f"(f44));
  // PTX:833 mul.f32 %f396, %f391, %f45
  asm("mul.f32 %0, %1, %2;" : "=f"(f396) : "f"(f391), "f"(f45));
  // PTX:834 mul.f32 %f397, %f391, %f46
  asm("mul.f32 %0, %1, %2;" : "=f"(f397) : "f"(f391), "f"(f46));
  // PTX:835 mul.f32 %f398, %f391, %f47
  asm("mul.f32 %0, %1, %2;" : "=f"(f398) : "f"(f391), "f"(f47));
  // PTX:836 mul.f32 %f399, %f391, %f48
  asm("mul.f32 %0, %1, %2;" : "=f"(f399) : "f"(f391), "f"(f48));
  // PTX:837 mul.f32 %f400, %f391, %f49
  asm("mul.f32 %0, %1, %2;" : "=f"(f400) : "f"(f391), "f"(f49));
  // PTX:838 fma.rn.f32 %f401, %f390, %f32, %f392
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f401) : "f"(f390), "f"(f32), "f"(f392));
  // PTX:839 fma.rn.f32 %f402, %f390, %f33, %f393
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f402) : "f"(f390), "f"(f33), "f"(f393));
  // PTX:840 fma.rn.f32 %f403, %f390, %f34, %f394
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f403) : "f"(f390), "f"(f34), "f"(f394));
  // PTX:841 fma.rn.f32 %f404, %f390, %f35, %f395
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f404) : "f"(f390), "f"(f35), "f"(f395));
  // PTX:842 fma.rn.f32 %f405, %f390, %f36, %f396
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f405) : "f"(f390), "f"(f36), "f"(f396));
  // PTX:843 fma.rn.f32 %f406, %f390, %f37, %f397
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f406) : "f"(f390), "f"(f37), "f"(f397));
  // PTX:844 fma.rn.f32 %f407, %f390, %f38, %f398
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f407) : "f"(f390), "f"(f38), "f"(f398));
  // PTX:845 fma.rn.f32 %f408, %f390, %f39, %f399
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f408) : "f"(f390), "f"(f39), "f"(f399));
  // PTX:846 fma.rn.f32 %f409, %f390, %f40, %f400
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f409) : "f"(f390), "f"(f40), "f"(f400));
  // PTX:847 mul.f32 %f410, %f50, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f410) : "f"(f50), "f"(f23));
  // PTX:848 mul.f32 %f411, %f51, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f411) : "f"(f51), "f"(f23));
  // PTX:849 mul.f32 %f412, %f52, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f412) : "f"(f52), "f"(f23));
  // PTX:850 mul.f32 %f413, %f50, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f413) : "f"(f50), "f"(f24));
  // PTX:851 mul.f32 %f414, %f51, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f414) : "f"(f51), "f"(f24));
  // PTX:852 mul.f32 %f415, %f52, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f415) : "f"(f52), "f"(f24));
  // PTX:853 mul.f32 %f416, %f50, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f416) : "f"(f50), "f"(f25));
  // PTX:854 mul.f32 %f417, %f51, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f417) : "f"(f51), "f"(f25));
  // PTX:855 mul.f32 %f418, %f52, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f418) : "f"(f52), "f"(f25));
  // PTX:856 fma.rn.f32 %f95, %f28, %f410, %f401
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f95) : "f"(f28), "f"(f410), "f"(f401));
  // PTX:857 fma.rn.f32 %f96, %f28, %f411, %f402
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f96) : "f"(f28), "f"(f411), "f"(f402));
  // PTX:858 fma.rn.f32 %f97, %f28, %f412, %f403
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f97) : "f"(f28), "f"(f412), "f"(f403));
  // PTX:859 fma.rn.f32 %f98, %f28, %f413, %f404
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f98) : "f"(f28), "f"(f413), "f"(f404));
  // PTX:860 fma.rn.f32 %f99, %f28, %f414, %f405
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f99) : "f"(f28), "f"(f414), "f"(f405));
  // PTX:861 fma.rn.f32 %f100, %f28, %f415, %f406
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f100) : "f"(f28), "f"(f415), "f"(f406));
  // PTX:862 fma.rn.f32 %f101, %f28, %f416, %f407
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f101) : "f"(f28), "f"(f416), "f"(f407));
  // PTX:863 fma.rn.f32 %f102, %f28, %f417, %f408
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f102) : "f"(f28), "f"(f417), "f"(f408));
  // PTX:864 fma.rn.f32 %f103, %f28, %f418, %f409
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f103) : "f"(f28), "f"(f418), "f"(f409));
  // PTX:865 @%p7 bra $L__BB52_60
  if (p7) { goto L_BB52_60; }
  // PTX:867 setp.ne.s32 %p36, %r118, 1
  p36 = (((int)(r118)) != ((int)(1)));
  // PTX:868 mov.u64 %rd239, %rd13
  asm("mov.u64 %0, %1;" : "=l"(rd239) : "l"(rd13));
  // PTX:869 mov.u32 %r121, %r1
  asm("mov.u32 %0, %1;" : "=r"(r121) : "r"(r1));
  // PTX:870 @%p36 bra $L__BB52_61
  if (p36) { goto L_BB52_61; }
  // PTX:872 mov.u64 %rd239, %rd12
  asm("mov.u64 %0, %1;" : "=l"(rd239) : "l"(rd12));
  // PTX:873 mov.u32 %r121, %r2
  asm("mov.u32 %0, %1;" : "=r"(r121) : "r"(r2));
  // PTX:874 bra.uni $L__BB52_61
  goto L_BB52_61;
  // PTX:876 $L__BB52_60:
L_BB52_60:;
  // PTX:877 mov.u64 %rd239, %rd14
  asm("mov.u64 %0, %1;" : "=l"(rd239) : "l"(rd14));
  // PTX:878 mov.u32 %r121, %r3
  asm("mov.u32 %0, %1;" : "=r"(r121) : "r"(r3));
  // PTX:880 $L__BB52_61:
L_BB52_61:;
  // PTX:881 mul.f32 %f419, %f94, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f419) : "f"(f94));
  // PTX:882 sub.f32 %f420, %f96, %f419
  asm("sub.f32 %0, %1, %2;" : "=f"(f420) : "f"(f96), "f"(f419));
  // PTX:883 sub.f32 %f421, %f97, %f419
  asm("sub.f32 %0, %1, %2;" : "=f"(f421) : "f"(f97), "f"(f419));
  // PTX:884 sub.f32 %f422, %f98, %f419
  asm("sub.f32 %0, %1, %2;" : "=f"(f422) : "f"(f98), "f"(f419));
  // PTX:885 sub.f32 %f423, %f100, %f419
  asm("sub.f32 %0, %1, %2;" : "=f"(f423) : "f"(f100), "f"(f419));
  // PTX:886 sub.f32 %f424, %f101, %f419
  asm("sub.f32 %0, %1, %2;" : "=f"(f424) : "f"(f101), "f"(f419));
  // PTX:887 sub.f32 %f425, %f102, %f419
  asm("sub.f32 %0, %1, %2;" : "=f"(f425) : "f"(f102), "f"(f419));
  // PTX:888 sub.f32 %f426, %f95, %f94
  asm("sub.f32 %0, %1, %2;" : "=f"(f426) : "f"(f95), "f"(f94));
  // PTX:889 mul.f32 %f104, %f29, %f426
  asm("mul.f32 %0, %1, %2;" : "=f"(f104) : "f"(f29), "f"(f426));
  // PTX:890 mul.f32 %f105, %f29, %f420
  asm("mul.f32 %0, %1, %2;" : "=f"(f105) : "f"(f29), "f"(f420));
  // PTX:891 mul.f32 %f106, %f29, %f421
  asm("mul.f32 %0, %1, %2;" : "=f"(f106) : "f"(f29), "f"(f421));
  // PTX:892 mul.f32 %f107, %f29, %f422
  asm("mul.f32 %0, %1, %2;" : "=f"(f107) : "f"(f29), "f"(f422));
  // PTX:893 sub.f32 %f427, %f99, %f94
  asm("sub.f32 %0, %1, %2;" : "=f"(f427) : "f"(f99), "f"(f94));
  // PTX:894 mul.f32 %f108, %f29, %f427
  asm("mul.f32 %0, %1, %2;" : "=f"(f108) : "f"(f29), "f"(f427));
  // PTX:895 mul.f32 %f109, %f29, %f423
  asm("mul.f32 %0, %1, %2;" : "=f"(f109) : "f"(f29), "f"(f423));
  // PTX:896 mul.f32 %f110, %f29, %f424
  asm("mul.f32 %0, %1, %2;" : "=f"(f110) : "f"(f29), "f"(f424));
  // PTX:897 mul.f32 %f111, %f29, %f425
  asm("mul.f32 %0, %1, %2;" : "=f"(f111) : "f"(f29), "f"(f425));
  // PTX:898 sub.f32 %f428, %f103, %f94
  asm("sub.f32 %0, %1, %2;" : "=f"(f428) : "f"(f103), "f"(f94));
  // PTX:899 mul.f32 %f112, %f29, %f428
  asm("mul.f32 %0, %1, %2;" : "=f"(f112) : "f"(f29), "f"(f428));
  // PTX:900 setp.eq.s32 %p37, %r121, %r3
  p37 = (((int)(r121)) == ((int)(r3)));
  // PTX:901 @%p37 bra $L__BB52_68
  if (p37) { goto L_BB52_68; }
  // PTX:902 bra.uni $L__BB52_62
  goto L_BB52_62;
  // PTX:904 $L__BB52_68:
L_BB52_68:;
  // PTX:905 mul.lo.s64 %rd211, %rd239, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd211) : "l"(rd239));
  // PTX:906 add.s64 %rd212, %rd1, %rd211
  asm("add.s64 %0, %1, %2;" : "=l"(rd212) : "l"(rd1), "l"(rd211));
  // PTX:907 red.global.add.f32 [%rd212], %f104
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd212) + (0)))), (float)(f104));
  // PTX:908 add.s64 %rd213, %rd212, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd213) : "l"(rd212));
  // PTX:909 red.global.add.f32 [%rd213], %f105
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd213) + (0)))), (float)(f105));
  // PTX:910 add.s64 %rd214, %rd212, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd214) : "l"(rd212));
  // PTX:911 red.global.add.f32 [%rd214], %f106
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd214) + (0)))), (float)(f106));
  // PTX:912 add.s64 %rd215, %rd212, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd215) : "l"(rd212));
  // PTX:913 red.global.add.f32 [%rd215], %f107
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd215) + (0)))), (float)(f107));
  // PTX:914 add.s64 %rd216, %rd212, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd216) : "l"(rd212));
  // PTX:915 red.global.add.f32 [%rd216], %f108
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd216) + (0)))), (float)(f108));
  // PTX:916 add.s64 %rd217, %rd212, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd217) : "l"(rd212));
  // PTX:917 red.global.add.f32 [%rd217], %f109
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd217) + (0)))), (float)(f109));
  // PTX:918 add.s64 %rd218, %rd212, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd218) : "l"(rd212));
  // PTX:919 red.global.add.f32 [%rd218], %f110
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd218) + (0)))), (float)(f110));
  // PTX:920 add.s64 %rd219, %rd212, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd219) : "l"(rd212));
  // PTX:921 red.global.add.f32 [%rd219], %f111
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd219) + (0)))), (float)(f111));
  // PTX:922 add.s64 %rd220, %rd212, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd220) : "l"(rd212));
  // PTX:923 red.global.add.f32 [%rd220], %f112
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd220) + (0)))), (float)(f112));
  // PTX:924 bra.uni $L__BB52_69
  goto L_BB52_69;
  // PTX:926 $L__BB52_62:
L_BB52_62:;
  // PTX:927 shl.b64 %rd185, %rd239, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd185) : "l"(rd239));
  // PTX:928 add.s64 %rd186, %rd3, %rd185
  asm("add.s64 %0, %1, %2;" : "=l"(rd186) : "l"(rd3), "l"(rd185));
  // PTX:929 ld.global.s32 %rd187, [%rd186]
  rd187 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd186) + (0)))));
  // PTX:930 mov.u64 %rd242, 0
  asm("mov.u64 %0, 0;" : "=l"(rd242) : );
  // PTX:931 min.u64 %rd62, %rd187, %rd74
  asm("min.u64 %0, %1, %2;" : "=l"(rd62) : "l"(rd187), "l"(rd74));
  // PTX:932 setp.eq.s64 %p38, %rd62, 0
  p38 = (((long long)(rd62)) == ((long long)(0)));
  // PTX:933 @%p38 bra $L__BB52_65
  if (p38) { goto L_BB52_65; }
  // PTX:935 mov.u64 %rd242, 0
  asm("mov.u64 %0, 0;" : "=l"(rd242) : );
  // PTX:936 mov.u64 %rd240, %rd62
  asm("mov.u64 %0, %1;" : "=l"(rd240) : "l"(rd62));
  // PTX:938 $L__BB52_64:
L_BB52_64:;
  // PTX:939 sub.s64 %rd189, %rd240, %rd242
  asm("sub.s64 %0, %1, %2;" : "=l"(rd189) : "l"(rd240), "l"(rd242));
  // PTX:940 shr.u64 %rd190, %rd189, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd190) : "l"(rd189));
  // PTX:941 add.s64 %rd191, %rd190, %rd242
  asm("add.s64 %0, %1, %2;" : "=l"(rd191) : "l"(rd190), "l"(rd242));
  // PTX:942 mul.lo.s64 %rd192, %rd191, %rd77
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd192) : "l"(rd191), "l"(rd77));
  // PTX:943 add.s64 %rd193, %rd192, %rd239
  asm("add.s64 %0, %1, %2;" : "=l"(rd193) : "l"(rd192), "l"(rd239));
  // PTX:944 mul.lo.s64 %rd194, %rd193, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd194) : "l"(rd193));
  // PTX:945 add.s64 %rd195, %rd2, %rd194
  asm("add.s64 %0, %1, %2;" : "=l"(rd195) : "l"(rd2), "l"(rd194));
  // PTX:946 ld.global.u32 %r98, [%rd195]
  r98 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd195) + (0)))));
  // PTX:947 setp.lt.s32 %p39, %r98, %r3
  p39 = (((int)(r98)) < ((int)(r3)));
  // PTX:948 add.s64 %rd196, %rd191, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd196) : "l"(rd191));
  // PTX:949 selp.b64 %rd242, %rd196, %rd242, %p39
  rd242 = p39 ? rd196 : rd242;
  // PTX:950 selp.b64 %rd240, %rd240, %rd191, %p39
  rd240 = p39 ? rd240 : rd191;
  // PTX:951 setp.gt.u64 %p40, %rd240, %rd242
  p40 = (((unsigned long long)(rd240)) > ((unsigned long long)(rd242)));
  // PTX:952 @%p40 bra $L__BB52_64
  if (p40) { goto L_BB52_64; }
  // PTX:954 $L__BB52_65:
L_BB52_65:;
  // PTX:955 setp.ge.u64 %p41, %rd242, %rd62
  p41 = (((unsigned long long)(rd242)) >= ((unsigned long long)(rd62)));
  // PTX:956 @%p41 bra $L__BB52_69
  if (p41) { goto L_BB52_69; }
  // PTX:958 mul.lo.s64 %rd197, %rd242, %rd77
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd197) : "l"(rd242), "l"(rd77));
  // PTX:959 add.s64 %rd68, %rd197, %rd239
  asm("add.s64 %0, %1, %2;" : "=l"(rd68) : "l"(rd197), "l"(rd239));
  // PTX:960 mul.lo.s64 %rd198, %rd68, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd198) : "l"(rd68));
  // PTX:961 add.s64 %rd199, %rd2, %rd198
  asm("add.s64 %0, %1, %2;" : "=l"(rd199) : "l"(rd2), "l"(rd198));
  // PTX:962 ld.global.u32 %r99, [%rd199]
  r99 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd199) + (0)))));
  // PTX:963 setp.ne.s32 %p42, %r99, %r3
  p42 = (((int)(r99)) != ((int)(r3)));
  // PTX:964 @%p42 bra $L__BB52_69
  if (p42) { goto L_BB52_69; }
  // PTX:966 add.s64 %rd202, %rd199, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd202) : "l"(rd199));
  // PTX:967 red.global.add.f32 [%rd202], %f104
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd202) + (0)))), (float)(f104));
  // PTX:968 add.s64 %rd203, %rd199, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd203) : "l"(rd199));
  // PTX:969 red.global.add.f32 [%rd203], %f105
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd203) + (0)))), (float)(f105));
  // PTX:970 add.s64 %rd204, %rd199, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd204) : "l"(rd199));
  // PTX:971 red.global.add.f32 [%rd204], %f106
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd204) + (0)))), (float)(f106));
  // PTX:972 add.s64 %rd205, %rd199, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd205) : "l"(rd199));
  // PTX:973 red.global.add.f32 [%rd205], %f107
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd205) + (0)))), (float)(f107));
  // PTX:974 add.s64 %rd206, %rd199, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd206) : "l"(rd199));
  // PTX:975 red.global.add.f32 [%rd206], %f108
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd206) + (0)))), (float)(f108));
  // PTX:976 add.s64 %rd207, %rd199, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd207) : "l"(rd199));
  // PTX:977 red.global.add.f32 [%rd207], %f109
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd207) + (0)))), (float)(f109));
  // PTX:978 add.s64 %rd208, %rd199, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd208) : "l"(rd199));
  // PTX:979 red.global.add.f32 [%rd208], %f110
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd208) + (0)))), (float)(f110));
  // PTX:980 add.s64 %rd209, %rd199, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd209) : "l"(rd199));
  // PTX:981 red.global.add.f32 [%rd209], %f111
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd209) + (0)))), (float)(f111));
  // PTX:982 add.s64 %rd210, %rd199, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd210) : "l"(rd199));
  // PTX:983 red.global.add.f32 [%rd210], %f112
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd210) + (0)))), (float)(f112));
  // PTX:985 $L__BB52_69:
L_BB52_69:;
  // PTX:986 add.s32 %r118, %r118, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r118) : "r"(r118));
  // PTX:987 setp.lt.u32 %p43, %r118, 3
  p43 = (((unsigned)(r118)) < ((unsigned)(3)));
  // PTX:988 @%p43 bra $L__BB52_13
  if (p43) { goto L_BB52_13; }
  // PTX:990 $L__BB52_70:
L_BB52_70:;
  // PTX:991 ret
  return;
}
