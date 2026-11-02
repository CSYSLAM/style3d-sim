// 机械还原自 PTX：synreal::kernel::add_affine_body_spring_gauss_newton_hessian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)
// PTX SHA256: e12fcf3dcbc16ba073b83203b68686096ffaa52f55338b6a7b08c5330cb3c300
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__add_affine_body_spring_gauss_newton_hessian(unsigned long long param0, unsigned long long param1, unsigned long long param2, float param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10, unsigned long long param11) {
  unsigned long long SP, SPL, rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135, rd136, rd137, rd138, rd139, rd140, rd141, rd142, rd143, rd144, rd145, rd146, rd147, rd148, rd149, rd150, rd151, rd152, rd153, rd154, rd155, rd156, rd157, rd158, rd159, rd160, rd161, rd162, rd163, rd164, rd165, rd166, rd167, rd168, rd169, rd170, rd171, rd172, rd173, rd174, rd175, rd176, rd177, rd178, rd179, rd180, rd181, rd182, rd183, rd184, rd185, rd186, rd187, rd188, rd189, rd190, rd191, rd192, rd193, rd194, rd195, rd196, rd197, rd198, rd199, rd200, rd201, rd202, rd203, rd204, rd205, rd206, rd207, rd208, rd209, rd210, rd211, rd212, rd213, rd214, rd215, rd216, rd217, rd218, rd219, rd220, rd221, rd222, rd223, rd224, rd225, rd226, rd227, rd228, rd229, rd230, rd231, rd232, rd233, rd234, rd235, rd236, rd237, rd238, rd239, rd240, rd241, rd242, rd243, rd244, rd245, rd246, rd247, rd248, rd249, rd250, rd251, rd252, rd253, rd254, rd255, rd256, rd257, rd258, rd259, rd260, rd261, rd262, rd263, rd264, rd265, rd266, rd267, rd268, rd269, rd270, rd271, rd272, rd273, rd274, rd275, rd276, rd277, rd278, rd279, rd280, rd281, rd282, rd283, rd284, rd285, rd286, rd287, rd288, rd289, rd290, rd291, rd292, rd293, rd294, rd295, rd296, rd297, rd298, rd299, rd300, rd301, rd302, rd303, rd304, rd305, rd306, rd307, rd308, rd309, rd310, rd311, rd312, rd313, rd314, rd315, rd316, rd317, rd318, rd319, rd320, rd321, rd322, rd323, rd324, rd325, rd326, rd327, rd328, rd329, rd330, rd331, rd332, rd333, rd334, rd335, rd336, rd337, rd338, rd339, rd340, rd341, rd342, rd343, rd344;
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121, r122, r123, r124, r125, r126, r127, r128, r129, r130, r131, r132, r133, r134, r135, r136, r137, r138, r139, r140, r141, r142, r143, r144, r145, r146, r147, r148, r149, r150, r151, r152, r153, r154, r155, r156, r157, r158, r159, r160, r161, r162, r163, r164, r165, r166, r167, r168, r169, r170, r171, r172, r173, r174, r175, r176, r177, r178, r179, r180, r181, r182, r183, r184, r185, r186, r187, r188, r189, r190, r191, r192, r193, r194, r195, r196, r197, r198, r199, r200, r201, r202, r203, r204, r205, r206, r207, r208, r209, r210, r211, r212, r213, r214, r215, r216, r217, r218, r219, r220, r221, r222, r223, r224, r225, r226, r227;
  __align__(16) unsigned char __local_depot54[16];
  // PTX:31 mov.u64 %SPL, __local_depot54
  SPL = (unsigned long long)__cvta_generic_to_local(__local_depot54);
  // PTX:32 ld.param.u64 %rd60, [_ZN7synreal6kernel43add_affine_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_0]
  rd60 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:33 ld.param.u64 %rd54, [_ZN7synreal6kernel43add_affine_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_1]
  rd54 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:34 ld.param.u64 %rd55, [_ZN7synreal6kernel43add_affine_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_2]
  rd55 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:35 ld.param.f32 %f40, [_ZN7synreal6kernel43add_affine_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_3]
  f40 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param3 + (0))));
  // PTX:36 ld.param.u64 %rd61, [_ZN7synreal6kernel43add_affine_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_4]
  rd61 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:37 ld.param.u64 %rd62, [_ZN7synreal6kernel43add_affine_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_5]
  rd62 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:38 ld.param.u64 %rd63, [_ZN7synreal6kernel43add_affine_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_6]
  rd63 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:39 ld.param.u64 %rd56, [_ZN7synreal6kernel43add_affine_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_7]
  rd56 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:40 ld.param.u64 %rd64, [_ZN7synreal6kernel43add_affine_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_8]
  rd64 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:41 ld.param.u64 %rd57, [_ZN7synreal6kernel43add_affine_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_9]
  rd57 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:42 ld.param.u64 %rd58, [_ZN7synreal6kernel43add_affine_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_10]
  rd58 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:43 ld.param.u64 %rd59, [_ZN7synreal6kernel43add_affine_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_11]
  rd59 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:44 cvta.to.global.u64 %rd1, %rd63
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd63));
  // PTX:45 cvta.to.global.u64 %rd2, %rd61
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd61));
  // PTX:46 cvta.to.global.u64 %rd3, %rd62
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd62));
  // PTX:47 cvta.to.global.u64 %rd4, %rd60
  rd4 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd60));
  // PTX:48 add.u64 %rd5, %SPL, 0
  asm("add.u64 %0, %1, 0;" : "=l"(rd5) : "l"(SPL));
  // PTX:49 mov.u32 %r96, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r96) : "r"(blockIdx.x));
  // PTX:50 mov.u32 %r97, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r97) : "r"(blockDim.x));
  // PTX:51 mul.wide.u32 %rd66, %r96, %r97
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd66) : "r"(r96), "r"(r97));
  // PTX:52 mov.u32 %r98, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r98) : "r"(threadIdx.x));
  // PTX:53 cvt.u64.u32 %rd67, %r98
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd67) : "r"(r98));
  // PTX:54 add.s64 %rd6, %rd66, %rd67
  asm("add.s64 %0, %1, %2;" : "=l"(rd6) : "l"(rd66), "l"(rd67));
  // PTX:55 setp.ge.u64 %p1, %rd6, %rd64
  p1 = (((unsigned long long)(rd6)) >= ((unsigned long long)(rd64)));
  // PTX:56 @%p1 bra $L__BB54_12
  if (p1) { goto L_BB54_12; }
  // PTX:58 or.b64 %rd68, %rd6, %rd57
  asm("or.b64 %0, %1, %2;" : "=l"(rd68) : "l"(rd6), "l"(rd57));
  // PTX:59 and.b64 %rd69, %rd68, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd69) : "l"(rd68));
  // PTX:60 setp.eq.s64 %p2, %rd69, 0
  p2 = (((long long)(rd69)) == ((long long)(0)));
  // PTX:61 @%p2 bra $L__BB54_3
  if (p2) { goto L_BB54_3; }
  // PTX:63 div.u64 %rd331, %rd6, %rd57
  asm("div.u64 %0, %1, %2;" : "=l"(rd331) : "l"(rd6), "l"(rd57));
  // PTX:64 mul.lo.s64 %rd70, %rd331, %rd57
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd70) : "l"(rd331), "l"(rd57));
  // PTX:65 sub.s64 %rd332, %rd6, %rd70
  asm("sub.s64 %0, %1, %2;" : "=l"(rd332) : "l"(rd6), "l"(rd70));
  // PTX:66 bra.uni $L__BB54_4
  goto L_BB54_4;
  // PTX:68 $L__BB54_3:
L_BB54_3:;
  // PTX:69 cvt.u32.u64 %r99, %rd57
  asm("cvt.u32.u64 %0, %1;" : "=r"(r99) : "l"(rd57));
  // PTX:70 cvt.u32.u64 %r100, %rd6
  asm("cvt.u32.u64 %0, %1;" : "=r"(r100) : "l"(rd6));
  // PTX:71 div.u32 %r101, %r100, %r99
  asm("div.u32 %0, %1, %2;" : "=r"(r101) : "r"(r100), "r"(r99));
  // PTX:72 mul.lo.s32 %r102, %r101, %r99
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r102) : "r"(r101), "r"(r99));
  // PTX:73 sub.s32 %r103, %r100, %r102
  asm("sub.s32 %0, %1, %2;" : "=r"(r103) : "r"(r100), "r"(r102));
  // PTX:74 cvt.u64.u32 %rd331, %r101
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd331) : "r"(r101));
  // PTX:75 cvt.u64.u32 %rd332, %r103
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd332) : "r"(r103));
  // PTX:77 $L__BB54_4:
L_BB54_4:;
  // PTX:78 mul.lo.s64 %rd71, %rd331, %rd58
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd71) : "l"(rd331), "l"(rd58));
  // PTX:79 cvt.u32.u64 %r113, %rd71
  asm("cvt.u32.u64 %0, %1;" : "=r"(r113) : "l"(rd71));
  // PTX:80 cvta.to.global.u64 %rd72, %rd54
  rd72 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd54));
  // PTX:81 shl.b64 %rd73, %rd332, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd73) : "l"(rd332));
  // PTX:82 add.s64 %rd74, %rd72, %rd73
  asm("add.s64 %0, %1, %2;" : "=l"(rd74) : "l"(rd72), "l"(rd73));
  // PTX:83 ld.global.u32 %r114, [%rd74]
  r114 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (0)))));
  // PTX:84 ld.global.u32 %r115, [%rd74+4]
  r115 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (4)))));
  // PTX:85 ld.global.u32 %r116, [%rd74+8]
  r116 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (8)))));
  // PTX:86 add.s32 %r1, %r116, %r113
  asm("add.s32 %0, %1, %2;" : "=r"(r1) : "r"(r116), "r"(r113));
  // PTX:87 ld.global.u32 %r117, [%rd74+12]
  r117 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (12)))));
  // PTX:88 add.s32 %r2, %r117, %r113
  asm("add.s32 %0, %1, %2;" : "=r"(r2) : "r"(r117), "r"(r113));
  // PTX:89 add.s32 %r118, %r115, %r113
  asm("add.s32 %0, %1, %2;" : "=r"(r118) : "r"(r115), "r"(r113));
  // PTX:90 add.s32 %r119, %r114, %r113
  asm("add.s32 %0, %1, %2;" : "=r"(r119) : "r"(r114), "r"(r113));
  // PTX:91 st.local.v4.u32 [%rd5], {%r119, %r118, %r1, %r2}
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd5) + (0))))) = (unsigned)(r119); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd5) + (4))))) = (unsigned)(r118); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd5) + (8))))) = (unsigned)(r1); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd5) + (12))))) = (unsigned)(r2);
  // PTX:92 cvta.to.global.u64 %rd75, %rd55
  rd75 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd55));
  // PTX:93 shl.b64 %rd76, %rd332, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd76) : "l"(rd332));
  // PTX:94 add.s64 %rd77, %rd75, %rd76
  asm("add.s64 %0, %1, %2;" : "=l"(rd77) : "l"(rd75), "l"(rd76));
  // PTX:95 ld.global.f32 %f41, [%rd77]
  f41 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (0)))));
  // PTX:96 mul.f32 %f1, %f41, %f40
  asm("mul.f32 %0, %1, %2;" : "=f"(f1) : "f"(f41), "f"(f40));
  // PTX:97 cvt.s64.s32 %rd13, %r118
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd13) : "r"(r118));
  // PTX:98 mul.wide.s32 %rd78, %r118, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd78) : "r"(r118));
  // PTX:99 add.s64 %rd79, %rd4, %rd78
  asm("add.s64 %0, %1, %2;" : "=l"(rd79) : "l"(rd4), "l"(rd78));
  // PTX:100 ld.global.f32 %f2, [%rd79]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (0)))));
  // PTX:101 ld.global.f32 %f3, [%rd79+4]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (4)))));
  // PTX:102 mul.f32 %f42, %f3, %f3
  asm("mul.f32 %0, %1, %2;" : "=f"(f42) : "f"(f3), "f"(f3));
  // PTX:103 ld.global.f32 %f4, [%rd79+8]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (8)))));
  // PTX:104 fma.rn.f32 %f43, %f2, %f2, %f42
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f43) : "f"(f2), "f"(f2), "f"(f42));
  // PTX:105 fma.rn.f32 %f44, %f4, %f4, %f43
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f44) : "f"(f4), "f"(f4), "f"(f43));
  // PTX:106 sqrt.rn.f32 %f5, %f44
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f5) : "f"(f44));
  // PTX:107 setp.le.f32 %p3, %f5, 0f322BCC77
  p3 = (!(isnan(((float)(f5))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f5)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:108 mov.u32 %r203, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r203) : );
  // PTX:109 mov.u32 %r204, 0
  asm("mov.u32 %0, 0;" : "=r"(r204) : );
  // PTX:110 mov.u32 %r197, %r203
  asm("mov.u32 %0, %1;" : "=r"(r197) : "r"(r203));
  // PTX:111 mov.u32 %r198, %r204
  asm("mov.u32 %0, %1;" : "=r"(r198) : "r"(r204));
  // PTX:112 mov.u32 %r199, %r204
  asm("mov.u32 %0, %1;" : "=r"(r199) : "r"(r204));
  // PTX:113 mov.u32 %r200, %r203
  asm("mov.u32 %0, %1;" : "=r"(r200) : "r"(r203));
  // PTX:114 mov.u32 %r201, %r204
  asm("mov.u32 %0, %1;" : "=r"(r201) : "r"(r204));
  // PTX:115 mov.u32 %r202, %r203
  asm("mov.u32 %0, %1;" : "=r"(r202) : "r"(r203));
  // PTX:116 @%p3 bra $L__BB54_6
  if (p3) { goto L_BB54_6; }
  // PTX:118 div.rn.f32 %f45, %f2, %f5
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f45) : "f"(f2), "f"(f5));
  // PTX:119 mul.f32 %f46, %f45, %f45
  asm("mul.f32 %0, %1, %2;" : "=f"(f46) : "f"(f45), "f"(f45));
  // PTX:120 div.rn.f32 %f47, %f3, %f5
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f47) : "f"(f3), "f"(f5));
  // PTX:121 mul.f32 %f48, %f47, %f45
  asm("mul.f32 %0, %1, %2;" : "=f"(f48) : "f"(f47), "f"(f45));
  // PTX:122 div.rn.f32 %f49, %f4, %f5
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f49) : "f"(f4), "f"(f5));
  // PTX:123 mul.f32 %f50, %f49, %f45
  asm("mul.f32 %0, %1, %2;" : "=f"(f50) : "f"(f49), "f"(f45));
  // PTX:124 mul.f32 %f51, %f47, %f47
  asm("mul.f32 %0, %1, %2;" : "=f"(f51) : "f"(f47), "f"(f47));
  // PTX:125 mul.f32 %f52, %f49, %f47
  asm("mul.f32 %0, %1, %2;" : "=f"(f52) : "f"(f49), "f"(f47));
  // PTX:126 mul.f32 %f53, %f49, %f49
  asm("mul.f32 %0, %1, %2;" : "=f"(f53) : "f"(f49), "f"(f49));
  // PTX:127 rcp.rn.f32 %f54, %f5
  asm("rcp.rn.f32 %0, %1;" : "=f"(f54) : "f"(f5));
  // PTX:128 mov.f32 %f55, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f55) : );
  // PTX:129 sub.f32 %f56, %f55, %f54
  asm("sub.f32 %0, %1, %2;" : "=f"(f56) : "f"(f55), "f"(f54));
  // PTX:130 mov.f32 %f57, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f57) : );
  // PTX:131 max.f32 %f58, %f57, %f56
  asm("max.f32 %0, %1, %2;" : "=f"(f58) : "f"(f57), "f"(f56));
  // PTX:132 sub.f32 %f59, %f55, %f46
  asm("sub.f32 %0, %1, %2;" : "=f"(f59) : "f"(f55), "f"(f46));
  // PTX:133 sub.f32 %f60, %f57, %f48
  asm("sub.f32 %0, %1, %2;" : "=f"(f60) : "f"(f57), "f"(f48));
  // PTX:134 sub.f32 %f61, %f57, %f50
  asm("sub.f32 %0, %1, %2;" : "=f"(f61) : "f"(f57), "f"(f50));
  // PTX:135 sub.f32 %f62, %f55, %f51
  asm("sub.f32 %0, %1, %2;" : "=f"(f62) : "f"(f55), "f"(f51));
  // PTX:136 sub.f32 %f63, %f57, %f52
  asm("sub.f32 %0, %1, %2;" : "=f"(f63) : "f"(f57), "f"(f52));
  // PTX:137 sub.f32 %f64, %f55, %f53
  asm("sub.f32 %0, %1, %2;" : "=f"(f64) : "f"(f55), "f"(f53));
  // PTX:138 fma.rn.f32 %f65, %f59, %f58, %f46
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f65) : "f"(f59), "f"(f58), "f"(f46));
  // PTX:139 fma.rn.f32 %f66, %f60, %f58, %f48
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f66) : "f"(f60), "f"(f58), "f"(f48));
  // PTX:140 fma.rn.f32 %f67, %f61, %f58, %f50
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f67) : "f"(f61), "f"(f58), "f"(f50));
  // PTX:141 fma.rn.f32 %f68, %f62, %f58, %f51
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f68) : "f"(f62), "f"(f58), "f"(f51));
  // PTX:142 fma.rn.f32 %f69, %f63, %f58, %f52
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f69) : "f"(f63), "f"(f58), "f"(f52));
  // PTX:143 fma.rn.f32 %f70, %f64, %f58, %f53
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f70) : "f"(f64), "f"(f58), "f"(f53));
  // PTX:144 mov.b32 %r202, %f70
  asm("mov.b32 %0, %1;" : "=r"(r202) : "f"(f70));
  // PTX:145 mov.b32 %r201, %f69
  asm("mov.b32 %0, %1;" : "=r"(r201) : "f"(f69));
  // PTX:146 mov.b32 %r199, %f67
  asm("mov.b32 %0, %1;" : "=r"(r199) : "f"(f67));
  // PTX:147 mov.b32 %r200, %f68
  asm("mov.b32 %0, %1;" : "=r"(r200) : "f"(f68));
  // PTX:148 mov.b32 %r198, %f66
  asm("mov.b32 %0, %1;" : "=r"(r198) : "f"(f66));
  // PTX:149 mov.b32 %r197, %f65
  asm("mov.b32 %0, %1;" : "=r"(r197) : "f"(f65));
  // PTX:151 $L__BB54_6:
L_BB54_6:;
  // PTX:152 mov.b32 %f71, %r197
  asm("mov.b32 %0, %1;" : "=f"(f71) : "r"(r197));
  // PTX:153 add.f32 %f72, %f71, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f72) : "f"(f71));
  // PTX:154 mov.b32 %f73, %r198
  asm("mov.b32 %0, %1;" : "=f"(f73) : "r"(r198));
  // PTX:155 mov.b32 %f74, %r199
  asm("mov.b32 %0, %1;" : "=f"(f74) : "r"(r199));
  // PTX:156 mov.b32 %f75, %r198
  asm("mov.b32 %0, %1;" : "=f"(f75) : "r"(r198));
  // PTX:157 mov.b32 %f76, %r200
  asm("mov.b32 %0, %1;" : "=f"(f76) : "r"(r200));
  // PTX:158 add.f32 %f77, %f76, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f77) : "f"(f76));
  // PTX:159 mov.b32 %f78, %r201
  asm("mov.b32 %0, %1;" : "=f"(f78) : "r"(r201));
  // PTX:160 mov.b32 %f79, %r199
  asm("mov.b32 %0, %1;" : "=f"(f79) : "r"(r199));
  // PTX:161 mov.b32 %f80, %r201
  asm("mov.b32 %0, %1;" : "=f"(f80) : "r"(r201));
  // PTX:162 mov.b32 %f81, %r202
  asm("mov.b32 %0, %1;" : "=f"(f81) : "r"(r202));
  // PTX:163 add.f32 %f82, %f81, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f82) : "f"(f81));
  // PTX:164 mul.f32 %f83, %f1, %f72
  asm("mul.f32 %0, %1, %2;" : "=f"(f83) : "f"(f1), "f"(f72));
  // PTX:165 mul.f32 %f84, %f1, %f73
  asm("mul.f32 %0, %1, %2;" : "=f"(f84) : "f"(f1), "f"(f73));
  // PTX:166 mul.f32 %f85, %f1, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f85) : "f"(f1), "f"(f74));
  // PTX:167 mul.f32 %f86, %f1, %f75
  asm("mul.f32 %0, %1, %2;" : "=f"(f86) : "f"(f1), "f"(f75));
  // PTX:168 mul.f32 %f87, %f1, %f77
  asm("mul.f32 %0, %1, %2;" : "=f"(f87) : "f"(f1), "f"(f77));
  // PTX:169 mul.f32 %f88, %f1, %f78
  asm("mul.f32 %0, %1, %2;" : "=f"(f88) : "f"(f1), "f"(f78));
  // PTX:170 mul.f32 %f89, %f1, %f79
  asm("mul.f32 %0, %1, %2;" : "=f"(f89) : "f"(f1), "f"(f79));
  // PTX:171 mul.f32 %f90, %f1, %f80
  asm("mul.f32 %0, %1, %2;" : "=f"(f90) : "f"(f1), "f"(f80));
  // PTX:172 mul.f32 %f91, %f1, %f82
  asm("mul.f32 %0, %1, %2;" : "=f"(f91) : "f"(f1), "f"(f82));
  // PTX:173 mul.lo.s64 %rd80, %rd13, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd80) : "l"(rd13));
  // PTX:174 add.s64 %rd81, %rd2, %rd80
  asm("add.s64 %0, %1, %2;" : "=l"(rd81) : "l"(rd2), "l"(rd80));
  // PTX:175 red.global.add.f32 [%rd81], %f83
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (0)))), (float)(f83));
  // PTX:176 add.s64 %rd82, %rd81, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd82) : "l"(rd81));
  // PTX:177 red.global.add.f32 [%rd82], %f84
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (0)))), (float)(f84));
  // PTX:178 add.s64 %rd83, %rd81, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd83) : "l"(rd81));
  // PTX:179 red.global.add.f32 [%rd83], %f85
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (0)))), (float)(f85));
  // PTX:180 add.s64 %rd84, %rd81, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd84) : "l"(rd81));
  // PTX:181 red.global.add.f32 [%rd84], %f86
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (0)))), (float)(f86));
  // PTX:182 add.s64 %rd85, %rd81, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd85) : "l"(rd81));
  // PTX:183 red.global.add.f32 [%rd85], %f87
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (0)))), (float)(f87));
  // PTX:184 add.s64 %rd86, %rd81, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd86) : "l"(rd81));
  // PTX:185 red.global.add.f32 [%rd86], %f88
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd86) + (0)))), (float)(f88));
  // PTX:186 add.s64 %rd87, %rd81, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd87) : "l"(rd81));
  // PTX:187 red.global.add.f32 [%rd87], %f89
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (0)))), (float)(f89));
  // PTX:188 add.s64 %rd88, %rd81, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd88) : "l"(rd81));
  // PTX:189 red.global.add.f32 [%rd88], %f90
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (0)))), (float)(f90));
  // PTX:190 add.s64 %rd89, %rd81, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd89) : "l"(rd81));
  // PTX:191 red.global.add.f32 [%rd89], %f91
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (0)))), (float)(f91));
  // PTX:192 cvt.s64.s32 %rd14, %r1
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd14) : "r"(r1));
  // PTX:193 mul.wide.s32 %rd90, %r1, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd90) : "r"(r1));
  // PTX:194 add.s64 %rd91, %rd4, %rd90
  asm("add.s64 %0, %1, %2;" : "=l"(rd91) : "l"(rd4), "l"(rd90));
  // PTX:195 ld.global.f32 %f6, [%rd91]
  f6 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (0)))));
  // PTX:196 ld.global.f32 %f7, [%rd91+4]
  f7 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (4)))));
  // PTX:197 mul.f32 %f101, %f7, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f101) : "f"(f7), "f"(f7));
  // PTX:198 ld.global.f32 %f8, [%rd91+8]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (8)))));
  // PTX:199 fma.rn.f32 %f102, %f6, %f6, %f101
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f102) : "f"(f6), "f"(f6), "f"(f101));
  // PTX:200 fma.rn.f32 %f103, %f8, %f8, %f102
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f103) : "f"(f8), "f"(f8), "f"(f102));
  // PTX:201 sqrt.rn.f32 %f9, %f103
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f9) : "f"(f103));
  // PTX:202 setp.le.f32 %p4, %f9, 0f322BCC77
  p4 = (!(isnan(((float)(f9))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f9)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:203 mov.u32 %r205, %r204
  asm("mov.u32 %0, %1;" : "=r"(r205) : "r"(r204));
  // PTX:204 mov.u32 %r206, %r203
  asm("mov.u32 %0, %1;" : "=r"(r206) : "r"(r203));
  // PTX:205 mov.u32 %r207, %r204
  asm("mov.u32 %0, %1;" : "=r"(r207) : "r"(r204));
  // PTX:206 mov.u32 %r208, %r203
  asm("mov.u32 %0, %1;" : "=r"(r208) : "r"(r203));
  // PTX:207 @%p4 bra $L__BB54_8
  if (p4) { goto L_BB54_8; }
  // PTX:209 div.rn.f32 %f104, %f6, %f9
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f104) : "f"(f6), "f"(f9));
  // PTX:210 mul.f32 %f105, %f104, %f104
  asm("mul.f32 %0, %1, %2;" : "=f"(f105) : "f"(f104), "f"(f104));
  // PTX:211 div.rn.f32 %f106, %f7, %f9
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f106) : "f"(f7), "f"(f9));
  // PTX:212 mul.f32 %f107, %f106, %f104
  asm("mul.f32 %0, %1, %2;" : "=f"(f107) : "f"(f106), "f"(f104));
  // PTX:213 div.rn.f32 %f108, %f8, %f9
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f108) : "f"(f8), "f"(f9));
  // PTX:214 mul.f32 %f109, %f108, %f104
  asm("mul.f32 %0, %1, %2;" : "=f"(f109) : "f"(f108), "f"(f104));
  // PTX:215 mul.f32 %f110, %f106, %f106
  asm("mul.f32 %0, %1, %2;" : "=f"(f110) : "f"(f106), "f"(f106));
  // PTX:216 mul.f32 %f111, %f108, %f106
  asm("mul.f32 %0, %1, %2;" : "=f"(f111) : "f"(f108), "f"(f106));
  // PTX:217 mul.f32 %f112, %f108, %f108
  asm("mul.f32 %0, %1, %2;" : "=f"(f112) : "f"(f108), "f"(f108));
  // PTX:218 rcp.rn.f32 %f113, %f9
  asm("rcp.rn.f32 %0, %1;" : "=f"(f113) : "f"(f9));
  // PTX:219 mov.f32 %f114, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f114) : );
  // PTX:220 sub.f32 %f115, %f114, %f113
  asm("sub.f32 %0, %1, %2;" : "=f"(f115) : "f"(f114), "f"(f113));
  // PTX:221 mov.f32 %f116, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f116) : );
  // PTX:222 max.f32 %f117, %f116, %f115
  asm("max.f32 %0, %1, %2;" : "=f"(f117) : "f"(f116), "f"(f115));
  // PTX:223 sub.f32 %f118, %f114, %f105
  asm("sub.f32 %0, %1, %2;" : "=f"(f118) : "f"(f114), "f"(f105));
  // PTX:224 sub.f32 %f119, %f116, %f107
  asm("sub.f32 %0, %1, %2;" : "=f"(f119) : "f"(f116), "f"(f107));
  // PTX:225 sub.f32 %f120, %f116, %f109
  asm("sub.f32 %0, %1, %2;" : "=f"(f120) : "f"(f116), "f"(f109));
  // PTX:226 sub.f32 %f121, %f114, %f110
  asm("sub.f32 %0, %1, %2;" : "=f"(f121) : "f"(f114), "f"(f110));
  // PTX:227 sub.f32 %f122, %f116, %f111
  asm("sub.f32 %0, %1, %2;" : "=f"(f122) : "f"(f116), "f"(f111));
  // PTX:228 sub.f32 %f123, %f114, %f112
  asm("sub.f32 %0, %1, %2;" : "=f"(f123) : "f"(f114), "f"(f112));
  // PTX:229 fma.rn.f32 %f124, %f118, %f117, %f105
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f124) : "f"(f118), "f"(f117), "f"(f105));
  // PTX:230 fma.rn.f32 %f125, %f119, %f117, %f107
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f125) : "f"(f119), "f"(f117), "f"(f107));
  // PTX:231 fma.rn.f32 %f126, %f120, %f117, %f109
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f126) : "f"(f120), "f"(f117), "f"(f109));
  // PTX:232 fma.rn.f32 %f127, %f121, %f117, %f110
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f127) : "f"(f121), "f"(f117), "f"(f110));
  // PTX:233 fma.rn.f32 %f128, %f122, %f117, %f111
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f128) : "f"(f122), "f"(f117), "f"(f111));
  // PTX:234 fma.rn.f32 %f129, %f123, %f117, %f112
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f129) : "f"(f123), "f"(f117), "f"(f112));
  // PTX:235 mov.b32 %r208, %f129
  asm("mov.b32 %0, %1;" : "=r"(r208) : "f"(f129));
  // PTX:236 mov.b32 %r207, %f128
  asm("mov.b32 %0, %1;" : "=r"(r207) : "f"(f128));
  // PTX:237 mov.b32 %r205, %f126
  asm("mov.b32 %0, %1;" : "=r"(r205) : "f"(f126));
  // PTX:238 mov.b32 %r206, %f127
  asm("mov.b32 %0, %1;" : "=r"(r206) : "f"(f127));
  // PTX:239 mov.b32 %r204, %f125
  asm("mov.b32 %0, %1;" : "=r"(r204) : "f"(f125));
  // PTX:240 mov.b32 %r203, %f124
  asm("mov.b32 %0, %1;" : "=r"(r203) : "f"(f124));
  // PTX:242 $L__BB54_8:
L_BB54_8:;
  // PTX:243 mov.b32 %f130, %r203
  asm("mov.b32 %0, %1;" : "=f"(f130) : "r"(r203));
  // PTX:244 add.f32 %f131, %f130, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f131) : "f"(f130));
  // PTX:245 mov.b32 %f132, %r204
  asm("mov.b32 %0, %1;" : "=f"(f132) : "r"(r204));
  // PTX:246 mov.b32 %f133, %r205
  asm("mov.b32 %0, %1;" : "=f"(f133) : "r"(r205));
  // PTX:247 mov.b32 %f134, %r204
  asm("mov.b32 %0, %1;" : "=f"(f134) : "r"(r204));
  // PTX:248 mov.b32 %f135, %r206
  asm("mov.b32 %0, %1;" : "=f"(f135) : "r"(r206));
  // PTX:249 add.f32 %f136, %f135, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f136) : "f"(f135));
  // PTX:250 mov.b32 %f137, %r207
  asm("mov.b32 %0, %1;" : "=f"(f137) : "r"(r207));
  // PTX:251 mov.b32 %f138, %r205
  asm("mov.b32 %0, %1;" : "=f"(f138) : "r"(r205));
  // PTX:252 mov.b32 %f139, %r207
  asm("mov.b32 %0, %1;" : "=f"(f139) : "r"(r207));
  // PTX:253 mov.b32 %f140, %r208
  asm("mov.b32 %0, %1;" : "=f"(f140) : "r"(r208));
  // PTX:254 add.f32 %f141, %f140, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f141) : "f"(f140));
  // PTX:255 mul.f32 %f142, %f1, %f131
  asm("mul.f32 %0, %1, %2;" : "=f"(f142) : "f"(f1), "f"(f131));
  // PTX:256 mul.f32 %f143, %f1, %f132
  asm("mul.f32 %0, %1, %2;" : "=f"(f143) : "f"(f1), "f"(f132));
  // PTX:257 mul.f32 %f144, %f1, %f133
  asm("mul.f32 %0, %1, %2;" : "=f"(f144) : "f"(f1), "f"(f133));
  // PTX:258 mul.f32 %f145, %f1, %f134
  asm("mul.f32 %0, %1, %2;" : "=f"(f145) : "f"(f1), "f"(f134));
  // PTX:259 mul.f32 %f146, %f1, %f136
  asm("mul.f32 %0, %1, %2;" : "=f"(f146) : "f"(f1), "f"(f136));
  // PTX:260 mul.f32 %f147, %f1, %f137
  asm("mul.f32 %0, %1, %2;" : "=f"(f147) : "f"(f1), "f"(f137));
  // PTX:261 mul.f32 %f148, %f1, %f138
  asm("mul.f32 %0, %1, %2;" : "=f"(f148) : "f"(f1), "f"(f138));
  // PTX:262 mul.f32 %f149, %f1, %f139
  asm("mul.f32 %0, %1, %2;" : "=f"(f149) : "f"(f1), "f"(f139));
  // PTX:263 mul.f32 %f150, %f1, %f141
  asm("mul.f32 %0, %1, %2;" : "=f"(f150) : "f"(f1), "f"(f141));
  // PTX:264 mul.lo.s64 %rd92, %rd14, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd92) : "l"(rd14));
  // PTX:265 add.s64 %rd93, %rd2, %rd92
  asm("add.s64 %0, %1, %2;" : "=l"(rd93) : "l"(rd2), "l"(rd92));
  // PTX:266 red.global.add.f32 [%rd93], %f142
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (0)))), (float)(f142));
  // PTX:267 add.s64 %rd94, %rd93, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd94) : "l"(rd93));
  // PTX:268 red.global.add.f32 [%rd94], %f143
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd94) + (0)))), (float)(f143));
  // PTX:269 add.s64 %rd95, %rd93, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd95) : "l"(rd93));
  // PTX:270 red.global.add.f32 [%rd95], %f144
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd95) + (0)))), (float)(f144));
  // PTX:271 add.s64 %rd96, %rd93, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd96) : "l"(rd93));
  // PTX:272 red.global.add.f32 [%rd96], %f145
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (0)))), (float)(f145));
  // PTX:273 add.s64 %rd97, %rd93, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd97) : "l"(rd93));
  // PTX:274 red.global.add.f32 [%rd97], %f146
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd97) + (0)))), (float)(f146));
  // PTX:275 add.s64 %rd98, %rd93, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd98) : "l"(rd93));
  // PTX:276 red.global.add.f32 [%rd98], %f147
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (0)))), (float)(f147));
  // PTX:277 add.s64 %rd99, %rd93, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd99) : "l"(rd93));
  // PTX:278 red.global.add.f32 [%rd99], %f148
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (0)))), (float)(f148));
  // PTX:279 add.s64 %rd100, %rd93, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd100) : "l"(rd93));
  // PTX:280 red.global.add.f32 [%rd100], %f149
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (0)))), (float)(f149));
  // PTX:281 add.s64 %rd101, %rd93, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd101) : "l"(rd93));
  // PTX:282 red.global.add.f32 [%rd101], %f150
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd101) + (0)))), (float)(f150));
  // PTX:283 cvt.s64.s32 %rd15, %r2
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd15) : "r"(r2));
  // PTX:284 mul.wide.s32 %rd102, %r2, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd102) : "r"(r2));
  // PTX:285 add.s64 %rd103, %rd4, %rd102
  asm("add.s64 %0, %1, %2;" : "=l"(rd103) : "l"(rd4), "l"(rd102));
  // PTX:286 ld.global.f32 %f10, [%rd103]
  f10 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd103) + (0)))));
  // PTX:287 ld.global.f32 %f11, [%rd103+4]
  f11 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd103) + (4)))));
  // PTX:288 mul.f32 %f160, %f11, %f11
  asm("mul.f32 %0, %1, %2;" : "=f"(f160) : "f"(f11), "f"(f11));
  // PTX:289 ld.global.f32 %f12, [%rd103+8]
  f12 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd103) + (8)))));
  // PTX:290 fma.rn.f32 %f161, %f10, %f10, %f160
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f161) : "f"(f10), "f"(f10), "f"(f160));
  // PTX:291 fma.rn.f32 %f162, %f12, %f12, %f161
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f162) : "f"(f12), "f"(f12), "f"(f161));
  // PTX:292 sqrt.rn.f32 %f13, %f162
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f13) : "f"(f162));
  // PTX:293 setp.le.f32 %p5, %f13, 0f322BCC77
  p5 = (!(isnan(((float)(f13))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f13)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:294 mov.u32 %r209, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r209) : );
  // PTX:295 mov.u32 %r210, 0
  asm("mov.u32 %0, 0;" : "=r"(r210) : );
  // PTX:296 mov.u32 %r211, %r210
  asm("mov.u32 %0, %1;" : "=r"(r211) : "r"(r210));
  // PTX:297 mov.u32 %r212, %r209
  asm("mov.u32 %0, %1;" : "=r"(r212) : "r"(r209));
  // PTX:298 mov.u32 %r213, %r210
  asm("mov.u32 %0, %1;" : "=r"(r213) : "r"(r210));
  // PTX:299 mov.u32 %r214, %r209
  asm("mov.u32 %0, %1;" : "=r"(r214) : "r"(r209));
  // PTX:300 @%p5 bra $L__BB54_10
  if (p5) { goto L_BB54_10; }
  // PTX:302 div.rn.f32 %f163, %f10, %f13
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f163) : "f"(f10), "f"(f13));
  // PTX:303 mul.f32 %f164, %f163, %f163
  asm("mul.f32 %0, %1, %2;" : "=f"(f164) : "f"(f163), "f"(f163));
  // PTX:304 div.rn.f32 %f165, %f11, %f13
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f165) : "f"(f11), "f"(f13));
  // PTX:305 mul.f32 %f166, %f165, %f163
  asm("mul.f32 %0, %1, %2;" : "=f"(f166) : "f"(f165), "f"(f163));
  // PTX:306 div.rn.f32 %f167, %f12, %f13
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f167) : "f"(f12), "f"(f13));
  // PTX:307 mul.f32 %f168, %f167, %f163
  asm("mul.f32 %0, %1, %2;" : "=f"(f168) : "f"(f167), "f"(f163));
  // PTX:308 mul.f32 %f169, %f165, %f165
  asm("mul.f32 %0, %1, %2;" : "=f"(f169) : "f"(f165), "f"(f165));
  // PTX:309 mul.f32 %f170, %f167, %f165
  asm("mul.f32 %0, %1, %2;" : "=f"(f170) : "f"(f167), "f"(f165));
  // PTX:310 mul.f32 %f171, %f167, %f167
  asm("mul.f32 %0, %1, %2;" : "=f"(f171) : "f"(f167), "f"(f167));
  // PTX:311 rcp.rn.f32 %f172, %f13
  asm("rcp.rn.f32 %0, %1;" : "=f"(f172) : "f"(f13));
  // PTX:312 mov.f32 %f173, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f173) : );
  // PTX:313 sub.f32 %f174, %f173, %f172
  asm("sub.f32 %0, %1, %2;" : "=f"(f174) : "f"(f173), "f"(f172));
  // PTX:314 mov.f32 %f175, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f175) : );
  // PTX:315 max.f32 %f176, %f175, %f174
  asm("max.f32 %0, %1, %2;" : "=f"(f176) : "f"(f175), "f"(f174));
  // PTX:316 sub.f32 %f177, %f173, %f164
  asm("sub.f32 %0, %1, %2;" : "=f"(f177) : "f"(f173), "f"(f164));
  // PTX:317 sub.f32 %f178, %f175, %f166
  asm("sub.f32 %0, %1, %2;" : "=f"(f178) : "f"(f175), "f"(f166));
  // PTX:318 sub.f32 %f179, %f175, %f168
  asm("sub.f32 %0, %1, %2;" : "=f"(f179) : "f"(f175), "f"(f168));
  // PTX:319 sub.f32 %f180, %f173, %f169
  asm("sub.f32 %0, %1, %2;" : "=f"(f180) : "f"(f173), "f"(f169));
  // PTX:320 sub.f32 %f181, %f175, %f170
  asm("sub.f32 %0, %1, %2;" : "=f"(f181) : "f"(f175), "f"(f170));
  // PTX:321 sub.f32 %f182, %f173, %f171
  asm("sub.f32 %0, %1, %2;" : "=f"(f182) : "f"(f173), "f"(f171));
  // PTX:322 fma.rn.f32 %f183, %f177, %f176, %f164
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f183) : "f"(f177), "f"(f176), "f"(f164));
  // PTX:323 fma.rn.f32 %f184, %f178, %f176, %f166
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f184) : "f"(f178), "f"(f176), "f"(f166));
  // PTX:324 fma.rn.f32 %f185, %f179, %f176, %f168
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f185) : "f"(f179), "f"(f176), "f"(f168));
  // PTX:325 fma.rn.f32 %f186, %f180, %f176, %f169
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f186) : "f"(f180), "f"(f176), "f"(f169));
  // PTX:326 fma.rn.f32 %f187, %f181, %f176, %f170
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f187) : "f"(f181), "f"(f176), "f"(f170));
  // PTX:327 fma.rn.f32 %f188, %f182, %f176, %f171
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f188) : "f"(f182), "f"(f176), "f"(f171));
  // PTX:328 mov.b32 %r214, %f188
  asm("mov.b32 %0, %1;" : "=r"(r214) : "f"(f188));
  // PTX:329 mov.b32 %r213, %f187
  asm("mov.b32 %0, %1;" : "=r"(r213) : "f"(f187));
  // PTX:330 mov.b32 %r211, %f185
  asm("mov.b32 %0, %1;" : "=r"(r211) : "f"(f185));
  // PTX:331 mov.b32 %r212, %f186
  asm("mov.b32 %0, %1;" : "=r"(r212) : "f"(f186));
  // PTX:332 mov.b32 %r210, %f184
  asm("mov.b32 %0, %1;" : "=r"(r210) : "f"(f184));
  // PTX:333 mov.b32 %r209, %f183
  asm("mov.b32 %0, %1;" : "=r"(r209) : "f"(f183));
  // PTX:335 $L__BB54_10:
L_BB54_10:;
  // PTX:336 mov.b32 %f189, %r209
  asm("mov.b32 %0, %1;" : "=f"(f189) : "r"(r209));
  // PTX:337 add.f32 %f190, %f189, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f190) : "f"(f189));
  // PTX:338 mov.b32 %f191, %r210
  asm("mov.b32 %0, %1;" : "=f"(f191) : "r"(r210));
  // PTX:339 mov.b32 %f192, %r211
  asm("mov.b32 %0, %1;" : "=f"(f192) : "r"(r211));
  // PTX:340 mov.b32 %f193, %r210
  asm("mov.b32 %0, %1;" : "=f"(f193) : "r"(r210));
  // PTX:341 mov.b32 %f194, %r212
  asm("mov.b32 %0, %1;" : "=f"(f194) : "r"(r212));
  // PTX:342 add.f32 %f195, %f194, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f195) : "f"(f194));
  // PTX:343 mov.b32 %f196, %r213
  asm("mov.b32 %0, %1;" : "=f"(f196) : "r"(r213));
  // PTX:344 mov.b32 %f197, %r211
  asm("mov.b32 %0, %1;" : "=f"(f197) : "r"(r211));
  // PTX:345 mov.b32 %f198, %r213
  asm("mov.b32 %0, %1;" : "=f"(f198) : "r"(r213));
  // PTX:346 mov.b32 %f199, %r214
  asm("mov.b32 %0, %1;" : "=f"(f199) : "r"(r214));
  // PTX:347 add.f32 %f200, %f199, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f200) : "f"(f199));
  // PTX:348 mul.f32 %f201, %f1, %f190
  asm("mul.f32 %0, %1, %2;" : "=f"(f201) : "f"(f1), "f"(f190));
  // PTX:349 mul.f32 %f202, %f1, %f191
  asm("mul.f32 %0, %1, %2;" : "=f"(f202) : "f"(f1), "f"(f191));
  // PTX:350 mul.f32 %f203, %f1, %f192
  asm("mul.f32 %0, %1, %2;" : "=f"(f203) : "f"(f1), "f"(f192));
  // PTX:351 mul.f32 %f204, %f1, %f193
  asm("mul.f32 %0, %1, %2;" : "=f"(f204) : "f"(f1), "f"(f193));
  // PTX:352 mul.f32 %f205, %f1, %f195
  asm("mul.f32 %0, %1, %2;" : "=f"(f205) : "f"(f1), "f"(f195));
  // PTX:353 mul.f32 %f206, %f1, %f196
  asm("mul.f32 %0, %1, %2;" : "=f"(f206) : "f"(f1), "f"(f196));
  // PTX:354 mul.f32 %f207, %f1, %f197
  asm("mul.f32 %0, %1, %2;" : "=f"(f207) : "f"(f1), "f"(f197));
  // PTX:355 mul.f32 %f208, %f1, %f198
  asm("mul.f32 %0, %1, %2;" : "=f"(f208) : "f"(f1), "f"(f198));
  // PTX:356 mul.f32 %f209, %f1, %f200
  asm("mul.f32 %0, %1, %2;" : "=f"(f209) : "f"(f1), "f"(f200));
  // PTX:357 mul.lo.s64 %rd104, %rd15, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd104) : "l"(rd15));
  // PTX:358 add.s64 %rd105, %rd2, %rd104
  asm("add.s64 %0, %1, %2;" : "=l"(rd105) : "l"(rd2), "l"(rd104));
  // PTX:359 red.global.add.f32 [%rd105], %f201
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (0)))), (float)(f201));
  // PTX:360 add.s64 %rd106, %rd105, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd106) : "l"(rd105));
  // PTX:361 red.global.add.f32 [%rd106], %f202
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (0)))), (float)(f202));
  // PTX:362 add.s64 %rd107, %rd105, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd107) : "l"(rd105));
  // PTX:363 red.global.add.f32 [%rd107], %f203
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd107) + (0)))), (float)(f203));
  // PTX:364 add.s64 %rd108, %rd105, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd108) : "l"(rd105));
  // PTX:365 red.global.add.f32 [%rd108], %f204
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd108) + (0)))), (float)(f204));
  // PTX:366 add.s64 %rd109, %rd105, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd109) : "l"(rd105));
  // PTX:367 red.global.add.f32 [%rd109], %f205
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd109) + (0)))), (float)(f205));
  // PTX:368 add.s64 %rd110, %rd105, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd110) : "l"(rd105));
  // PTX:369 red.global.add.f32 [%rd110], %f206
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd110) + (0)))), (float)(f206));
  // PTX:370 add.s64 %rd111, %rd105, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd111) : "l"(rd105));
  // PTX:371 red.global.add.f32 [%rd111], %f207
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd111) + (0)))), (float)(f207));
  // PTX:372 add.s64 %rd112, %rd105, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd112) : "l"(rd105));
  // PTX:373 red.global.add.f32 [%rd112], %f208
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd112) + (0)))), (float)(f208));
  // PTX:374 add.s64 %rd113, %rd105, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd113) : "l"(rd105));
  // PTX:375 red.global.add.f32 [%rd113], %f209
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd113) + (0)))), (float)(f209));
  // PTX:376 mov.u32 %r215, 1
  asm("mov.u32 %0, 1;" : "=r"(r215) : );
  // PTX:377 bra.uni $L__BB54_11
  goto L_BB54_11;
  // PTX:379 $L__BB54_51:
L_BB54_51:;
  // PTX:380 cvt.s64.s32 %rd329, %r161
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd329) : "r"(r161));
  // PTX:381 mul.lo.s64 %rd328, %rd329, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd328) : "l"(rd329));
  // PTX:382 add.s64 %rd327, %rd2, %rd328
  asm("add.s64 %0, %1, %2;" : "=l"(rd327) : "l"(rd2), "l"(rd328));
  // PTX:383 add.s64 %rd326, %rd327, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd326) : "l"(rd327));
  // PTX:384 add.s64 %rd325, %rd327, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd325) : "l"(rd327));
  // PTX:385 add.s32 %r215, %r57, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r215) : "r"(r57));
  // PTX:386 red.global.add.f32 [%rd327], %f31
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd327) + (0)))), (float)(f31));
  // PTX:387 red.global.add.f32 [%rd325], %f32
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd325) + (0)))), (float)(f32));
  // PTX:388 red.global.add.f32 [%rd326], %f33
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd326) + (0)))), (float)(f33));
  // PTX:389 red.global.add.f32 [%rd219], %f34
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd219) + (0)))), (float)(f34));
  // PTX:390 red.global.add.f32 [%rd220], %f35
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd220) + (0)))), (float)(f35));
  // PTX:391 red.global.add.f32 [%rd221], %f36
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd221) + (0)))), (float)(f36));
  // PTX:392 red.global.add.f32 [%rd222], %f37
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd222) + (0)))), (float)(f37));
  // PTX:393 red.global.add.f32 [%rd223], %f38
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd223) + (0)))), (float)(f38));
  // PTX:394 red.global.add.f32 [%rd224], %f39
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd224) + (0)))), (float)(f39));
  // PTX:396 $L__BB54_11:
L_BB54_11:;
  // PTX:397 mov.u32 %r57, %r215
  asm("mov.u32 %0, %1;" : "=r"(r57) : "r"(r215));
  // PTX:398 add.s32 %r58, %r57, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r58) : "r"(r57));
  // PTX:399 setp.lt.u32 %p6, %r58, 4
  p6 = (((unsigned)(r58)) < ((unsigned)(4)));
  // PTX:400 @%p6 bra $L__BB54_13
  if (p6) { goto L_BB54_13; }
  // PTX:401 bra.uni $L__BB54_12
  goto L_BB54_12;
  // PTX:403 $L__BB54_13:
L_BB54_13:;
  // PTX:404 add.u64 %rd293, %SPL, 0
  asm("add.u64 %0, %1, 0;" : "=l"(rd293) : "l"(SPL));
  // PTX:405 setp.leu.f32 %p7, %f1, 0f00000000
  p7 = ((isnan(((float)(f1))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f1)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:406 mul.wide.s32 %rd114, %r57, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd114) : "r"(r57));
  // PTX:407 add.s64 %rd16, %rd293, %rd114
  asm("add.s64 %0, %1, %2;" : "=l"(rd16) : "l"(rd293), "l"(rd114));
  // PTX:408 ld.local.u32 %r139, [%rd16]
  r139 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:409 cvt.s64.s32 %rd17, %r139
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd17) : "r"(r139));
  // PTX:410 mul.wide.s32 %rd115, %r139, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd115) : "r"(r139));
  // PTX:411 add.s64 %rd18, %rd4, %rd115
  asm("add.s64 %0, %1, %2;" : "=l"(rd18) : "l"(rd4), "l"(rd115));
  // PTX:412 ld.local.u32 %r140, [%rd16+4]
  r140 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd16) + (4)))));
  // PTX:413 cvt.s64.s32 %rd20, %r140
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd20) : "r"(r140));
  // PTX:414 mul.wide.s32 %rd117, %r140, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd117) : "r"(r140));
  // PTX:415 add.s64 %rd118, %rd4, %rd117
  asm("add.s64 %0, %1, %2;" : "=l"(rd118) : "l"(rd4), "l"(rd117));
  // PTX:416 ld.global.f32 %f219, [%rd18]
  f219 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (0)))));
  // PTX:417 ld.global.f32 %f220, [%rd118]
  f220 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd118) + (0)))));
  // PTX:418 sub.f32 %f14, %f220, %f219
  asm("sub.f32 %0, %1, %2;" : "=f"(f14) : "f"(f220), "f"(f219));
  // PTX:419 ld.global.f32 %f221, [%rd18+4]
  f221 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (4)))));
  // PTX:420 ld.global.f32 %f222, [%rd118+4]
  f222 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd118) + (4)))));
  // PTX:421 sub.f32 %f15, %f222, %f221
  asm("sub.f32 %0, %1, %2;" : "=f"(f15) : "f"(f222), "f"(f221));
  // PTX:422 ld.global.f32 %f223, [%rd18+8]
  f223 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (8)))));
  // PTX:423 ld.global.f32 %f224, [%rd118+8]
  f224 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd118) + (8)))));
  // PTX:424 sub.f32 %f16, %f224, %f223
  asm("sub.f32 %0, %1, %2;" : "=f"(f16) : "f"(f224), "f"(f223));
  // PTX:425 @%p7 bra $L__BB54_32
  if (p7) { goto L_BB54_32; }
  // PTX:427 mul.f32 %f225, %f15, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f225) : "f"(f15), "f"(f15));
  // PTX:428 fma.rn.f32 %f226, %f14, %f14, %f225
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f226) : "f"(f14), "f"(f14), "f"(f225));
  // PTX:429 fma.rn.f32 %f227, %f16, %f16, %f226
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f227) : "f"(f16), "f"(f16), "f"(f226));
  // PTX:430 sqrt.rn.f32 %f17, %f227
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f17) : "f"(f227));
  // PTX:431 setp.le.f32 %p8, %f17, 0f322BCC77
  p8 = (!(isnan(((float)(f17))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f17)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:432 mov.u32 %r216, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r216) : );
  // PTX:433 mov.u32 %r217, 0
  asm("mov.u32 %0, 0;" : "=r"(r217) : );
  // PTX:434 mov.u32 %r218, %r217
  asm("mov.u32 %0, %1;" : "=r"(r218) : "r"(r217));
  // PTX:435 mov.u32 %r219, %r216
  asm("mov.u32 %0, %1;" : "=r"(r219) : "r"(r216));
  // PTX:436 mov.u32 %r220, %r217
  asm("mov.u32 %0, %1;" : "=r"(r220) : "r"(r217));
  // PTX:437 mov.u32 %r221, %r216
  asm("mov.u32 %0, %1;" : "=r"(r221) : "r"(r216));
  // PTX:438 @%p8 bra $L__BB54_16
  if (p8) { goto L_BB54_16; }
  // PTX:440 div.rn.f32 %f228, %f14, %f17
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f228) : "f"(f14), "f"(f17));
  // PTX:441 mul.f32 %f229, %f228, %f228
  asm("mul.f32 %0, %1, %2;" : "=f"(f229) : "f"(f228), "f"(f228));
  // PTX:442 div.rn.f32 %f230, %f15, %f17
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f230) : "f"(f15), "f"(f17));
  // PTX:443 mul.f32 %f231, %f230, %f228
  asm("mul.f32 %0, %1, %2;" : "=f"(f231) : "f"(f230), "f"(f228));
  // PTX:444 div.rn.f32 %f232, %f16, %f17
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f232) : "f"(f16), "f"(f17));
  // PTX:445 mul.f32 %f233, %f232, %f228
  asm("mul.f32 %0, %1, %2;" : "=f"(f233) : "f"(f232), "f"(f228));
  // PTX:446 mul.f32 %f234, %f230, %f230
  asm("mul.f32 %0, %1, %2;" : "=f"(f234) : "f"(f230), "f"(f230));
  // PTX:447 mul.f32 %f235, %f232, %f230
  asm("mul.f32 %0, %1, %2;" : "=f"(f235) : "f"(f232), "f"(f230));
  // PTX:448 mul.f32 %f236, %f232, %f232
  asm("mul.f32 %0, %1, %2;" : "=f"(f236) : "f"(f232), "f"(f232));
  // PTX:449 mov.f32 %f237, 0fBFB504F3
  asm("mov.f32 %0, 0fBFB504F3;" : "=f"(f237) : );
  // PTX:450 div.rn.f32 %f238, %f237, %f17
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f238) : "f"(f237), "f"(f17));
  // PTX:451 add.f32 %f239, %f238, 0f3F800000
  asm("add.f32 %0, %1, 0f3F800000;" : "=f"(f239) : "f"(f238));
  // PTX:452 mov.f32 %f240, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f240) : );
  // PTX:453 mov.f32 %f241, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f241) : );
  // PTX:454 max.f32 %f242, %f241, %f239
  asm("max.f32 %0, %1, %2;" : "=f"(f242) : "f"(f241), "f"(f239));
  // PTX:455 sub.f32 %f243, %f240, %f229
  asm("sub.f32 %0, %1, %2;" : "=f"(f243) : "f"(f240), "f"(f229));
  // PTX:456 sub.f32 %f244, %f241, %f231
  asm("sub.f32 %0, %1, %2;" : "=f"(f244) : "f"(f241), "f"(f231));
  // PTX:457 sub.f32 %f245, %f241, %f233
  asm("sub.f32 %0, %1, %2;" : "=f"(f245) : "f"(f241), "f"(f233));
  // PTX:458 sub.f32 %f246, %f240, %f234
  asm("sub.f32 %0, %1, %2;" : "=f"(f246) : "f"(f240), "f"(f234));
  // PTX:459 sub.f32 %f247, %f241, %f235
  asm("sub.f32 %0, %1, %2;" : "=f"(f247) : "f"(f241), "f"(f235));
  // PTX:460 sub.f32 %f248, %f240, %f236
  asm("sub.f32 %0, %1, %2;" : "=f"(f248) : "f"(f240), "f"(f236));
  // PTX:461 fma.rn.f32 %f249, %f243, %f242, %f229
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f249) : "f"(f243), "f"(f242), "f"(f229));
  // PTX:462 fma.rn.f32 %f250, %f244, %f242, %f231
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f250) : "f"(f244), "f"(f242), "f"(f231));
  // PTX:463 fma.rn.f32 %f251, %f245, %f242, %f233
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f251) : "f"(f245), "f"(f242), "f"(f233));
  // PTX:464 fma.rn.f32 %f252, %f246, %f242, %f234
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f252) : "f"(f246), "f"(f242), "f"(f234));
  // PTX:465 fma.rn.f32 %f253, %f247, %f242, %f235
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f253) : "f"(f247), "f"(f242), "f"(f235));
  // PTX:466 fma.rn.f32 %f254, %f248, %f242, %f236
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f254) : "f"(f248), "f"(f242), "f"(f236));
  // PTX:467 mov.b32 %r221, %f254
  asm("mov.b32 %0, %1;" : "=r"(r221) : "f"(f254));
  // PTX:468 mov.b32 %r220, %f253
  asm("mov.b32 %0, %1;" : "=r"(r220) : "f"(f253));
  // PTX:469 mov.b32 %r218, %f251
  asm("mov.b32 %0, %1;" : "=r"(r218) : "f"(f251));
  // PTX:470 mov.b32 %r219, %f252
  asm("mov.b32 %0, %1;" : "=r"(r219) : "f"(f252));
  // PTX:471 mov.b32 %r217, %f250
  asm("mov.b32 %0, %1;" : "=r"(r217) : "f"(f250));
  // PTX:472 mov.b32 %r216, %f249
  asm("mov.b32 %0, %1;" : "=r"(r216) : "f"(f249));
  // PTX:474 $L__BB54_16:
L_BB54_16:;
  // PTX:475 cvt.s64.s32 %rd295, %r140
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd295) : "r"(r140));
  // PTX:476 mov.b32 %f255, %r216
  asm("mov.b32 %0, %1;" : "=f"(f255) : "r"(r216));
  // PTX:477 add.f32 %f256, %f255, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f256) : "f"(f255));
  // PTX:478 mov.b32 %f257, %r217
  asm("mov.b32 %0, %1;" : "=f"(f257) : "r"(r217));
  // PTX:479 mov.b32 %f258, %r218
  asm("mov.b32 %0, %1;" : "=f"(f258) : "r"(r218));
  // PTX:480 mov.b32 %f259, %r217
  asm("mov.b32 %0, %1;" : "=f"(f259) : "r"(r217));
  // PTX:481 mov.b32 %f260, %r219
  asm("mov.b32 %0, %1;" : "=f"(f260) : "r"(r219));
  // PTX:482 add.f32 %f261, %f260, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f261) : "f"(f260));
  // PTX:483 mov.b32 %f262, %r220
  asm("mov.b32 %0, %1;" : "=f"(f262) : "r"(r220));
  // PTX:484 mov.b32 %f263, %r218
  asm("mov.b32 %0, %1;" : "=f"(f263) : "r"(r218));
  // PTX:485 mov.b32 %f264, %r220
  asm("mov.b32 %0, %1;" : "=f"(f264) : "r"(r220));
  // PTX:486 mov.b32 %f265, %r221
  asm("mov.b32 %0, %1;" : "=f"(f265) : "r"(r221));
  // PTX:487 add.f32 %f266, %f265, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f266) : "f"(f265));
  // PTX:488 mul.f32 %f267, %f1, %f256
  asm("mul.f32 %0, %1, %2;" : "=f"(f267) : "f"(f1), "f"(f256));
  // PTX:489 mul.f32 %f268, %f1, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f268) : "f"(f1), "f"(f257));
  // PTX:490 mul.f32 %f269, %f1, %f258
  asm("mul.f32 %0, %1, %2;" : "=f"(f269) : "f"(f1), "f"(f258));
  // PTX:491 mul.f32 %f270, %f1, %f259
  asm("mul.f32 %0, %1, %2;" : "=f"(f270) : "f"(f1), "f"(f259));
  // PTX:492 mul.f32 %f271, %f1, %f261
  asm("mul.f32 %0, %1, %2;" : "=f"(f271) : "f"(f1), "f"(f261));
  // PTX:493 mul.f32 %f272, %f1, %f262
  asm("mul.f32 %0, %1, %2;" : "=f"(f272) : "f"(f1), "f"(f262));
  // PTX:494 mul.f32 %f273, %f1, %f263
  asm("mul.f32 %0, %1, %2;" : "=f"(f273) : "f"(f1), "f"(f263));
  // PTX:495 mul.f32 %f274, %f1, %f264
  asm("mul.f32 %0, %1, %2;" : "=f"(f274) : "f"(f1), "f"(f264));
  // PTX:496 mul.f32 %f275, %f1, %f266
  asm("mul.f32 %0, %1, %2;" : "=f"(f275) : "f"(f1), "f"(f266));
  // PTX:497 mul.lo.s64 %rd119, %rd17, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd119) : "l"(rd17));
  // PTX:498 add.s64 %rd21, %rd2, %rd119
  asm("add.s64 %0, %1, %2;" : "=l"(rd21) : "l"(rd2), "l"(rd119));
  // PTX:499 red.global.add.f32 [%rd21], %f267
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (0)))), (float)(f267));
  // PTX:500 add.s64 %rd120, %rd21, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd120) : "l"(rd21));
  // PTX:501 red.global.add.f32 [%rd120], %f268
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd120) + (0)))), (float)(f268));
  // PTX:502 add.s64 %rd121, %rd21, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd121) : "l"(rd21));
  // PTX:503 red.global.add.f32 [%rd121], %f269
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd121) + (0)))), (float)(f269));
  // PTX:504 add.s64 %rd122, %rd21, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd122) : "l"(rd21));
  // PTX:505 red.global.add.f32 [%rd122], %f270
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd122) + (0)))), (float)(f270));
  // PTX:506 add.s64 %rd123, %rd21, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd123) : "l"(rd21));
  // PTX:507 red.global.add.f32 [%rd123], %f271
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd123) + (0)))), (float)(f271));
  // PTX:508 add.s64 %rd124, %rd21, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd124) : "l"(rd21));
  // PTX:509 red.global.add.f32 [%rd124], %f272
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd124) + (0)))), (float)(f272));
  // PTX:510 add.s64 %rd125, %rd21, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd125) : "l"(rd21));
  // PTX:511 red.global.add.f32 [%rd125], %f273
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd125) + (0)))), (float)(f273));
  // PTX:512 add.s64 %rd126, %rd21, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd126) : "l"(rd21));
  // PTX:513 red.global.add.f32 [%rd126], %f274
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd126) + (0)))), (float)(f274));
  // PTX:514 add.s64 %rd127, %rd21, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd127) : "l"(rd21));
  // PTX:515 red.global.add.f32 [%rd127], %f275
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd127) + (0)))), (float)(f275));
  // PTX:516 mul.lo.s64 %rd128, %rd295, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd128) : "l"(rd295));
  // PTX:517 add.s64 %rd22, %rd2, %rd128
  asm("add.s64 %0, %1, %2;" : "=l"(rd22) : "l"(rd2), "l"(rd128));
  // PTX:518 red.global.add.f32 [%rd22], %f267
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (0)))), (float)(f267));
  // PTX:519 add.s64 %rd129, %rd22, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd129) : "l"(rd22));
  // PTX:520 red.global.add.f32 [%rd129], %f268
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd129) + (0)))), (float)(f268));
  // PTX:521 add.s64 %rd130, %rd22, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd130) : "l"(rd22));
  // PTX:522 red.global.add.f32 [%rd130], %f269
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd130) + (0)))), (float)(f269));
  // PTX:523 add.s64 %rd131, %rd22, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd131) : "l"(rd22));
  // PTX:524 red.global.add.f32 [%rd131], %f270
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd131) + (0)))), (float)(f270));
  // PTX:525 add.s64 %rd132, %rd22, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd132) : "l"(rd22));
  // PTX:526 red.global.add.f32 [%rd132], %f271
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd132) + (0)))), (float)(f271));
  // PTX:527 add.s64 %rd133, %rd22, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd133) : "l"(rd22));
  // PTX:528 red.global.add.f32 [%rd133], %f272
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd133) + (0)))), (float)(f272));
  // PTX:529 add.s64 %rd134, %rd22, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd134) : "l"(rd22));
  // PTX:530 red.global.add.f32 [%rd134], %f273
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd134) + (0)))), (float)(f273));
  // PTX:531 add.s64 %rd135, %rd22, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd135) : "l"(rd22));
  // PTX:532 red.global.add.f32 [%rd135], %f274
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd135) + (0)))), (float)(f274));
  // PTX:533 add.s64 %rd136, %rd22, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd136) : "l"(rd22));
  // PTX:534 red.global.add.f32 [%rd136], %f275
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd136) + (0)))), (float)(f275));
  // PTX:535 neg.f32 %f18, %f267
  asm("neg.f32 %0, %1;" : "=f"(f18) : "f"(f267));
  // PTX:536 neg.f32 %f19, %f268
  asm("neg.f32 %0, %1;" : "=f"(f19) : "f"(f268));
  // PTX:537 neg.f32 %f20, %f269
  asm("neg.f32 %0, %1;" : "=f"(f20) : "f"(f269));
  // PTX:538 neg.f32 %f21, %f270
  asm("neg.f32 %0, %1;" : "=f"(f21) : "f"(f270));
  // PTX:539 neg.f32 %f22, %f271
  asm("neg.f32 %0, %1;" : "=f"(f22) : "f"(f271));
  // PTX:540 neg.f32 %f23, %f272
  asm("neg.f32 %0, %1;" : "=f"(f23) : "f"(f272));
  // PTX:541 neg.f32 %f24, %f273
  asm("neg.f32 %0, %1;" : "=f"(f24) : "f"(f273));
  // PTX:542 neg.f32 %f25, %f274
  asm("neg.f32 %0, %1;" : "=f"(f25) : "f"(f274));
  // PTX:543 neg.f32 %f26, %f275
  asm("neg.f32 %0, %1;" : "=f"(f26) : "f"(f275));
  // PTX:544 cvt.u32.u64 %r77, %rd295
  asm("cvt.u32.u64 %0, %1;" : "=r"(r77) : "l"(rd295));
  // PTX:545 cvt.u32.u64 %r150, %rd17
  asm("cvt.u32.u64 %0, %1;" : "=r"(r150) : "l"(rd17));
  // PTX:546 setp.eq.s32 %p9, %r150, %r77
  p9 = (((int)(r150)) == ((int)(r77)));
  // PTX:547 @%p9 bra $L__BB54_23
  if (p9) { goto L_BB54_23; }
  // PTX:548 bra.uni $L__BB54_17
  goto L_BB54_17;
  // PTX:550 $L__BB54_23:
L_BB54_23:;
  // PTX:551 red.global.add.f32 [%rd21], %f18
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (0)))), (float)(f18));
  // PTX:552 red.global.add.f32 [%rd120], %f19
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd120) + (0)))), (float)(f19));
  // PTX:553 red.global.add.f32 [%rd121], %f20
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd121) + (0)))), (float)(f20));
  // PTX:554 red.global.add.f32 [%rd122], %f21
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd122) + (0)))), (float)(f21));
  // PTX:555 red.global.add.f32 [%rd123], %f22
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd123) + (0)))), (float)(f22));
  // PTX:556 red.global.add.f32 [%rd124], %f23
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd124) + (0)))), (float)(f23));
  // PTX:557 red.global.add.f32 [%rd125], %f24
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd125) + (0)))), (float)(f24));
  // PTX:558 red.global.add.f32 [%rd126], %f25
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd126) + (0)))), (float)(f25));
  // PTX:559 red.global.add.f32 [%rd127], %f26
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd127) + (0)))), (float)(f26));
  // PTX:560 bra.uni $L__BB54_24
  goto L_BB54_24;
  // PTX:562 $L__BB54_17:
L_BB54_17:;
  // PTX:563 mul.wide.s32 %rd297, %r139, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd297) : "r"(r139));
  // PTX:564 add.s64 %rd296, %rd3, %rd297
  asm("add.s64 %0, %1, %2;" : "=l"(rd296) : "l"(rd3), "l"(rd297));
  // PTX:565 ld.global.s32 %rd138, [%rd296]
  rd138 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd296) + (0)))));
  // PTX:566 mov.u64 %rd335, 0
  asm("mov.u64 %0, 0;" : "=l"(rd335) : );
  // PTX:567 min.u64 %rd23, %rd138, %rd56
  asm("min.u64 %0, %1, %2;" : "=l"(rd23) : "l"(rd138), "l"(rd56));
  // PTX:568 setp.eq.s64 %p10, %rd23, 0
  p10 = (((long long)(rd23)) == ((long long)(0)));
  // PTX:569 @%p10 bra $L__BB54_20
  if (p10) { goto L_BB54_20; }
  // PTX:571 mov.u64 %rd335, 0
  asm("mov.u64 %0, 0;" : "=l"(rd335) : );
  // PTX:572 mov.u64 %rd333, %rd23
  asm("mov.u64 %0, %1;" : "=l"(rd333) : "l"(rd23));
  // PTX:574 $L__BB54_19:
L_BB54_19:;
  // PTX:575 cvt.s64.s32 %rd312, %r140
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd312) : "r"(r140));
  // PTX:576 cvt.u32.u64 %r189, %rd312
  asm("cvt.u32.u64 %0, %1;" : "=r"(r189) : "l"(rd312));
  // PTX:577 sub.s64 %rd140, %rd333, %rd335
  asm("sub.s64 %0, %1, %2;" : "=l"(rd140) : "l"(rd333), "l"(rd335));
  // PTX:578 shr.u64 %rd141, %rd140, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd141) : "l"(rd140));
  // PTX:579 add.s64 %rd142, %rd141, %rd335
  asm("add.s64 %0, %1, %2;" : "=l"(rd142) : "l"(rd141), "l"(rd335));
  // PTX:580 mul.lo.s64 %rd143, %rd142, %rd59
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd143) : "l"(rd142), "l"(rd59));
  // PTX:581 add.s64 %rd144, %rd143, %rd17
  asm("add.s64 %0, %1, %2;" : "=l"(rd144) : "l"(rd143), "l"(rd17));
  // PTX:582 mul.lo.s64 %rd145, %rd144, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd145) : "l"(rd144));
  // PTX:583 add.s64 %rd146, %rd1, %rd145
  asm("add.s64 %0, %1, %2;" : "=l"(rd146) : "l"(rd1), "l"(rd145));
  // PTX:584 ld.global.u32 %r151, [%rd146]
  r151 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd146) + (0)))));
  // PTX:585 setp.lt.s32 %p11, %r151, %r189
  p11 = (((int)(r151)) < ((int)(r189)));
  // PTX:586 add.s64 %rd147, %rd142, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd147) : "l"(rd142));
  // PTX:587 selp.b64 %rd335, %rd147, %rd335, %p11
  rd335 = p11 ? rd147 : rd335;
  // PTX:588 selp.b64 %rd333, %rd333, %rd142, %p11
  rd333 = p11 ? rd333 : rd142;
  // PTX:589 setp.gt.u64 %p12, %rd333, %rd335
  p12 = (((unsigned long long)(rd333)) > ((unsigned long long)(rd335)));
  // PTX:590 @%p12 bra $L__BB54_19
  if (p12) { goto L_BB54_19; }
  // PTX:592 $L__BB54_20:
L_BB54_20:;
  // PTX:593 setp.ge.u64 %p13, %rd335, %rd23
  p13 = (((unsigned long long)(rd335)) >= ((unsigned long long)(rd23)));
  // PTX:594 @%p13 bra $L__BB54_24
  if (p13) { goto L_BB54_24; }
  // PTX:596 cvt.s64.s32 %rd321, %r140
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd321) : "r"(r140));
  // PTX:597 cvt.u32.u64 %r192, %rd321
  asm("cvt.u32.u64 %0, %1;" : "=r"(r192) : "l"(rd321));
  // PTX:598 mul.lo.s64 %rd148, %rd335, %rd59
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd148) : "l"(rd335), "l"(rd59));
  // PTX:599 add.s64 %rd29, %rd148, %rd17
  asm("add.s64 %0, %1, %2;" : "=l"(rd29) : "l"(rd148), "l"(rd17));
  // PTX:600 mul.lo.s64 %rd149, %rd29, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd149) : "l"(rd29));
  // PTX:601 add.s64 %rd150, %rd1, %rd149
  asm("add.s64 %0, %1, %2;" : "=l"(rd150) : "l"(rd1), "l"(rd149));
  // PTX:602 ld.global.u32 %r154, [%rd150]
  r154 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd150) + (0)))));
  // PTX:603 setp.ne.s32 %p14, %r154, %r192
  p14 = (((int)(r154)) != ((int)(r192)));
  // PTX:604 @%p14 bra $L__BB54_24
  if (p14) { goto L_BB54_24; }
  // PTX:606 add.s64 %rd153, %rd150, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd153) : "l"(rd150));
  // PTX:607 red.global.add.f32 [%rd153], %f18
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd153) + (0)))), (float)(f18));
  // PTX:608 add.s64 %rd154, %rd150, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd154) : "l"(rd150));
  // PTX:609 red.global.add.f32 [%rd154], %f19
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd154) + (0)))), (float)(f19));
  // PTX:610 add.s64 %rd155, %rd150, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd155) : "l"(rd150));
  // PTX:611 red.global.add.f32 [%rd155], %f20
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd155) + (0)))), (float)(f20));
  // PTX:612 add.s64 %rd156, %rd150, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd156) : "l"(rd150));
  // PTX:613 red.global.add.f32 [%rd156], %f21
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd156) + (0)))), (float)(f21));
  // PTX:614 add.s64 %rd157, %rd150, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd157) : "l"(rd150));
  // PTX:615 red.global.add.f32 [%rd157], %f22
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd157) + (0)))), (float)(f22));
  // PTX:616 add.s64 %rd158, %rd150, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd158) : "l"(rd150));
  // PTX:617 red.global.add.f32 [%rd158], %f23
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd158) + (0)))), (float)(f23));
  // PTX:618 add.s64 %rd159, %rd150, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd159) : "l"(rd150));
  // PTX:619 red.global.add.f32 [%rd159], %f24
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd159) + (0)))), (float)(f24));
  // PTX:620 add.s64 %rd160, %rd150, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd160) : "l"(rd150));
  // PTX:621 red.global.add.f32 [%rd160], %f25
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd160) + (0)))), (float)(f25));
  // PTX:622 add.s64 %rd161, %rd150, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd161) : "l"(rd150));
  // PTX:623 red.global.add.f32 [%rd161], %f26
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd161) + (0)))), (float)(f26));
  // PTX:625 $L__BB54_24:
L_BB54_24:;
  // PTX:626 @%p9 bra $L__BB54_31
  if (p9) { goto L_BB54_31; }
  // PTX:627 bra.uni $L__BB54_25
  goto L_BB54_25;
  // PTX:629 $L__BB54_31:
L_BB54_31:;
  // PTX:630 cvt.s64.s32 %rd320, %r140
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd320) : "r"(r140));
  // PTX:631 mul.lo.s64 %rd319, %rd320, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd319) : "l"(rd320));
  // PTX:632 add.s64 %rd318, %rd2, %rd319
  asm("add.s64 %0, %1, %2;" : "=l"(rd318) : "l"(rd2), "l"(rd319));
  // PTX:633 add.s64 %rd317, %rd318, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd317) : "l"(rd318));
  // PTX:634 add.s64 %rd316, %rd318, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd316) : "l"(rd318));
  // PTX:635 add.s64 %rd315, %rd318, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd315) : "l"(rd318));
  // PTX:636 mul.lo.s64 %rd311, %rd320, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd311) : "l"(rd320));
  // PTX:637 add.s64 %rd310, %rd2, %rd311
  asm("add.s64 %0, %1, %2;" : "=l"(rd310) : "l"(rd2), "l"(rd311));
  // PTX:638 add.s64 %rd309, %rd310, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd309) : "l"(rd310));
  // PTX:639 add.s64 %rd308, %rd310, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd308) : "l"(rd310));
  // PTX:640 add.s64 %rd307, %rd310, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd307) : "l"(rd310));
  // PTX:641 cvt.s64.s32 %rd306, %r140
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd306) : "r"(r140));
  // PTX:642 red.global.add.f32 [%rd310], %f18
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd310) + (0)))), (float)(f18));
  // PTX:643 red.global.add.f32 [%rd307], %f19
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd307) + (0)))), (float)(f19));
  // PTX:644 red.global.add.f32 [%rd308], %f20
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd308) + (0)))), (float)(f20));
  // PTX:645 red.global.add.f32 [%rd309], %f21
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd309) + (0)))), (float)(f21));
  // PTX:646 red.global.add.f32 [%rd315], %f22
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd315) + (0)))), (float)(f22));
  // PTX:647 red.global.add.f32 [%rd316], %f23
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd316) + (0)))), (float)(f23));
  // PTX:648 red.global.add.f32 [%rd317], %f24
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd317) + (0)))), (float)(f24));
  // PTX:649 red.global.add.f32 [%rd135], %f25
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd135) + (0)))), (float)(f25));
  // PTX:650 red.global.add.f32 [%rd136], %f26
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd136) + (0)))), (float)(f26));
  // PTX:651 bra.uni $L__BB54_32
  goto L_BB54_32;
  // PTX:653 $L__BB54_25:
L_BB54_25:;
  // PTX:654 shl.b64 %rd171, %rd20, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd171) : "l"(rd20));
  // PTX:655 add.s64 %rd172, %rd3, %rd171
  asm("add.s64 %0, %1, %2;" : "=l"(rd172) : "l"(rd3), "l"(rd171));
  // PTX:656 ld.global.s32 %rd173, [%rd172]
  rd173 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd172) + (0)))));
  // PTX:657 mov.u64 %rd338, 0
  asm("mov.u64 %0, 0;" : "=l"(rd338) : );
  // PTX:658 min.u64 %rd30, %rd173, %rd56
  asm("min.u64 %0, %1, %2;" : "=l"(rd30) : "l"(rd173), "l"(rd56));
  // PTX:659 setp.eq.s64 %p16, %rd30, 0
  p16 = (((long long)(rd30)) == ((long long)(0)));
  // PTX:660 @%p16 bra $L__BB54_28
  if (p16) { goto L_BB54_28; }
  // PTX:662 mov.u64 %rd338, 0
  asm("mov.u64 %0, 0;" : "=l"(rd338) : );
  // PTX:663 mov.u64 %rd336, %rd30
  asm("mov.u64 %0, %1;" : "=l"(rd336) : "l"(rd30));
  // PTX:665 $L__BB54_27:
L_BB54_27:;
  // PTX:666 cvt.s64.s32 %rd313, %r139
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd313) : "r"(r139));
  // PTX:667 cvt.u32.u64 %r190, %rd313
  asm("cvt.u32.u64 %0, %1;" : "=r"(r190) : "l"(rd313));
  // PTX:668 sub.s64 %rd175, %rd336, %rd338
  asm("sub.s64 %0, %1, %2;" : "=l"(rd175) : "l"(rd336), "l"(rd338));
  // PTX:669 shr.u64 %rd176, %rd175, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd176) : "l"(rd175));
  // PTX:670 add.s64 %rd177, %rd176, %rd338
  asm("add.s64 %0, %1, %2;" : "=l"(rd177) : "l"(rd176), "l"(rd338));
  // PTX:671 mul.lo.s64 %rd178, %rd177, %rd59
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd178) : "l"(rd177), "l"(rd59));
  // PTX:672 add.s64 %rd179, %rd178, %rd20
  asm("add.s64 %0, %1, %2;" : "=l"(rd179) : "l"(rd178), "l"(rd20));
  // PTX:673 mul.lo.s64 %rd180, %rd179, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd180) : "l"(rd179));
  // PTX:674 add.s64 %rd181, %rd1, %rd180
  asm("add.s64 %0, %1, %2;" : "=l"(rd181) : "l"(rd1), "l"(rd180));
  // PTX:675 ld.global.u32 %r156, [%rd181]
  r156 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd181) + (0)))));
  // PTX:676 setp.lt.s32 %p17, %r156, %r190
  p17 = (((int)(r156)) < ((int)(r190)));
  // PTX:677 add.s64 %rd182, %rd177, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd182) : "l"(rd177));
  // PTX:678 selp.b64 %rd338, %rd182, %rd338, %p17
  rd338 = p17 ? rd182 : rd338;
  // PTX:679 selp.b64 %rd336, %rd336, %rd177, %p17
  rd336 = p17 ? rd336 : rd177;
  // PTX:680 setp.gt.u64 %p18, %rd336, %rd338
  p18 = (((unsigned long long)(rd336)) > ((unsigned long long)(rd338)));
  // PTX:681 @%p18 bra $L__BB54_27
  if (p18) { goto L_BB54_27; }
  // PTX:683 $L__BB54_28:
L_BB54_28:;
  // PTX:684 setp.ge.u64 %p19, %rd338, %rd30
  p19 = (((unsigned long long)(rd338)) >= ((unsigned long long)(rd30)));
  // PTX:685 @%p19 bra $L__BB54_32
  if (p19) { goto L_BB54_32; }
  // PTX:687 cvt.s64.s32 %rd314, %r139
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd314) : "r"(r139));
  // PTX:688 cvt.u32.u64 %r191, %rd314
  asm("cvt.u32.u64 %0, %1;" : "=r"(r191) : "l"(rd314));
  // PTX:689 mul.lo.s64 %rd183, %rd338, %rd59
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd183) : "l"(rd338), "l"(rd59));
  // PTX:690 add.s64 %rd36, %rd183, %rd20
  asm("add.s64 %0, %1, %2;" : "=l"(rd36) : "l"(rd183), "l"(rd20));
  // PTX:691 mul.lo.s64 %rd184, %rd36, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd184) : "l"(rd36));
  // PTX:692 add.s64 %rd185, %rd1, %rd184
  asm("add.s64 %0, %1, %2;" : "=l"(rd185) : "l"(rd1), "l"(rd184));
  // PTX:693 ld.global.u32 %r159, [%rd185]
  r159 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (0)))));
  // PTX:694 setp.ne.s32 %p20, %r159, %r191
  p20 = (((int)(r159)) != ((int)(r191)));
  // PTX:695 @%p20 bra $L__BB54_32
  if (p20) { goto L_BB54_32; }
  // PTX:697 add.s64 %rd188, %rd185, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd188) : "l"(rd185));
  // PTX:698 red.global.add.f32 [%rd188], %f18
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd188) + (0)))), (float)(f18));
  // PTX:699 add.s64 %rd189, %rd185, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd189) : "l"(rd185));
  // PTX:700 red.global.add.f32 [%rd189], %f19
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd189) + (0)))), (float)(f19));
  // PTX:701 add.s64 %rd190, %rd185, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd190) : "l"(rd185));
  // PTX:702 red.global.add.f32 [%rd190], %f20
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd190) + (0)))), (float)(f20));
  // PTX:703 add.s64 %rd191, %rd185, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd191) : "l"(rd185));
  // PTX:704 red.global.add.f32 [%rd191], %f21
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd191) + (0)))), (float)(f21));
  // PTX:705 add.s64 %rd192, %rd185, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd192) : "l"(rd185));
  // PTX:706 red.global.add.f32 [%rd192], %f22
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd192) + (0)))), (float)(f22));
  // PTX:707 add.s64 %rd193, %rd185, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd193) : "l"(rd185));
  // PTX:708 red.global.add.f32 [%rd193], %f23
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd193) + (0)))), (float)(f23));
  // PTX:709 add.s64 %rd194, %rd185, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd194) : "l"(rd185));
  // PTX:710 red.global.add.f32 [%rd194], %f24
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd194) + (0)))), (float)(f24));
  // PTX:711 add.s64 %rd195, %rd185, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd195) : "l"(rd185));
  // PTX:712 red.global.add.f32 [%rd195], %f25
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd195) + (0)))), (float)(f25));
  // PTX:713 add.s64 %rd196, %rd185, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd196) : "l"(rd185));
  // PTX:714 red.global.add.f32 [%rd196], %f26
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd196) + (0)))), (float)(f26));
  // PTX:716 $L__BB54_32:
L_BB54_32:;
  // PTX:717 add.s32 %r215, %r57, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r215) : "r"(r57));
  // PTX:718 add.s32 %r160, %r57, 2
  asm("add.s32 %0, %1, 2;" : "=r"(r160) : "r"(r57));
  // PTX:719 setp.gt.u32 %p21, %r160, 3
  p21 = (((unsigned)(r160)) > ((unsigned)(3)));
  // PTX:720 @%p21 bra $L__BB54_11
  if (p21) { goto L_BB54_11; }
  // PTX:722 setp.leu.f32 %p36, %f1, 0f00000000
  p36 = ((isnan(((float)(f1))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f1)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:723 mul.wide.s32 %rd303, %r139, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd303) : "r"(r139));
  // PTX:724 add.s64 %rd302, %rd4, %rd303
  asm("add.s64 %0, %1, %2;" : "=l"(rd302) : "l"(rd4), "l"(rd303));
  // PTX:725 mul.wide.s32 %rd300, %r57, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd300) : "r"(r57));
  // PTX:726 add.u64 %rd299, %SPL, 0
  asm("add.u64 %0, %1, 0;" : "=l"(rd299) : "l"(SPL));
  // PTX:727 add.s64 %rd298, %rd293, %rd300
  asm("add.s64 %0, %1, %2;" : "=l"(rd298) : "l"(rd293), "l"(rd300));
  // PTX:728 add.s32 %r215, %r57, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r215) : "r"(r57));
  // PTX:729 ld.local.u32 %r161, [%rd298+8]
  r161 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd298) + (8)))));
  // PTX:730 cvt.s64.s32 %rd37, %r161
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd37) : "r"(r161));
  // PTX:731 mul.wide.s32 %rd205, %r161, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd205) : "r"(r161));
  // PTX:732 add.s64 %rd206, %rd4, %rd205
  asm("add.s64 %0, %1, %2;" : "=l"(rd206) : "l"(rd4), "l"(rd205));
  // PTX:733 ld.global.f32 %f330, [%rd302]
  f330 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd302) + (0)))));
  // PTX:734 ld.global.f32 %f331, [%rd206]
  f331 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd206) + (0)))));
  // PTX:735 sub.f32 %f27, %f331, %f330
  asm("sub.f32 %0, %1, %2;" : "=f"(f27) : "f"(f331), "f"(f330));
  // PTX:736 ld.global.f32 %f332, [%rd302+4]
  f332 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd302) + (4)))));
  // PTX:737 ld.global.f32 %f333, [%rd206+4]
  f333 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd206) + (4)))));
  // PTX:738 sub.f32 %f28, %f333, %f332
  asm("sub.f32 %0, %1, %2;" : "=f"(f28) : "f"(f333), "f"(f332));
  // PTX:739 ld.global.f32 %f334, [%rd302+8]
  f334 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd302) + (8)))));
  // PTX:740 ld.global.f32 %f335, [%rd206+8]
  f335 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd206) + (8)))));
  // PTX:741 sub.f32 %f29, %f335, %f334
  asm("sub.f32 %0, %1, %2;" : "=f"(f29) : "f"(f335), "f"(f334));
  // PTX:742 @%p36 bra $L__BB54_11
  if (p36) { goto L_BB54_11; }
  // PTX:744 mul.f32 %f336, %f28, %f28
  asm("mul.f32 %0, %1, %2;" : "=f"(f336) : "f"(f28), "f"(f28));
  // PTX:745 fma.rn.f32 %f337, %f27, %f27, %f336
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f337) : "f"(f27), "f"(f27), "f"(f336));
  // PTX:746 fma.rn.f32 %f338, %f29, %f29, %f337
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f338) : "f"(f29), "f"(f29), "f"(f337));
  // PTX:747 sqrt.rn.f32 %f30, %f338
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f30) : "f"(f338));
  // PTX:748 setp.le.f32 %p23, %f30, 0f322BCC77
  p23 = (!(isnan(((float)(f30))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f30)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:749 mov.u32 %r222, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r222) : );
  // PTX:750 mov.u32 %r223, 0
  asm("mov.u32 %0, 0;" : "=r"(r223) : );
  // PTX:751 mov.u32 %r224, %r223
  asm("mov.u32 %0, %1;" : "=r"(r224) : "r"(r223));
  // PTX:752 mov.u32 %r225, %r222
  asm("mov.u32 %0, %1;" : "=r"(r225) : "r"(r222));
  // PTX:753 mov.u32 %r226, %r223
  asm("mov.u32 %0, %1;" : "=r"(r226) : "r"(r223));
  // PTX:754 mov.u32 %r227, %r222
  asm("mov.u32 %0, %1;" : "=r"(r227) : "r"(r222));
  // PTX:755 @%p23 bra $L__BB54_36
  if (p23) { goto L_BB54_36; }
  // PTX:757 div.rn.f32 %f339, %f27, %f30
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f339) : "f"(f27), "f"(f30));
  // PTX:758 mul.f32 %f340, %f339, %f339
  asm("mul.f32 %0, %1, %2;" : "=f"(f340) : "f"(f339), "f"(f339));
  // PTX:759 div.rn.f32 %f341, %f28, %f30
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f341) : "f"(f28), "f"(f30));
  // PTX:760 mul.f32 %f342, %f341, %f339
  asm("mul.f32 %0, %1, %2;" : "=f"(f342) : "f"(f341), "f"(f339));
  // PTX:761 div.rn.f32 %f343, %f29, %f30
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f343) : "f"(f29), "f"(f30));
  // PTX:762 mul.f32 %f344, %f343, %f339
  asm("mul.f32 %0, %1, %2;" : "=f"(f344) : "f"(f343), "f"(f339));
  // PTX:763 mul.f32 %f345, %f341, %f341
  asm("mul.f32 %0, %1, %2;" : "=f"(f345) : "f"(f341), "f"(f341));
  // PTX:764 mul.f32 %f346, %f343, %f341
  asm("mul.f32 %0, %1, %2;" : "=f"(f346) : "f"(f343), "f"(f341));
  // PTX:765 mul.f32 %f347, %f343, %f343
  asm("mul.f32 %0, %1, %2;" : "=f"(f347) : "f"(f343), "f"(f343));
  // PTX:766 mov.f32 %f348, 0fBFB504F3
  asm("mov.f32 %0, 0fBFB504F3;" : "=f"(f348) : );
  // PTX:767 div.rn.f32 %f349, %f348, %f30
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f349) : "f"(f348), "f"(f30));
  // PTX:768 add.f32 %f350, %f349, 0f3F800000
  asm("add.f32 %0, %1, 0f3F800000;" : "=f"(f350) : "f"(f349));
  // PTX:769 mov.f32 %f351, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f351) : );
  // PTX:770 mov.f32 %f352, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f352) : );
  // PTX:771 max.f32 %f353, %f352, %f350
  asm("max.f32 %0, %1, %2;" : "=f"(f353) : "f"(f352), "f"(f350));
  // PTX:772 sub.f32 %f354, %f351, %f340
  asm("sub.f32 %0, %1, %2;" : "=f"(f354) : "f"(f351), "f"(f340));
  // PTX:773 sub.f32 %f355, %f352, %f342
  asm("sub.f32 %0, %1, %2;" : "=f"(f355) : "f"(f352), "f"(f342));
  // PTX:774 sub.f32 %f356, %f352, %f344
  asm("sub.f32 %0, %1, %2;" : "=f"(f356) : "f"(f352), "f"(f344));
  // PTX:775 sub.f32 %f357, %f351, %f345
  asm("sub.f32 %0, %1, %2;" : "=f"(f357) : "f"(f351), "f"(f345));
  // PTX:776 sub.f32 %f358, %f352, %f346
  asm("sub.f32 %0, %1, %2;" : "=f"(f358) : "f"(f352), "f"(f346));
  // PTX:777 sub.f32 %f359, %f351, %f347
  asm("sub.f32 %0, %1, %2;" : "=f"(f359) : "f"(f351), "f"(f347));
  // PTX:778 fma.rn.f32 %f360, %f354, %f353, %f340
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f360) : "f"(f354), "f"(f353), "f"(f340));
  // PTX:779 fma.rn.f32 %f361, %f355, %f353, %f342
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f361) : "f"(f355), "f"(f353), "f"(f342));
  // PTX:780 fma.rn.f32 %f362, %f356, %f353, %f344
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f362) : "f"(f356), "f"(f353), "f"(f344));
  // PTX:781 fma.rn.f32 %f363, %f357, %f353, %f345
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f363) : "f"(f357), "f"(f353), "f"(f345));
  // PTX:782 fma.rn.f32 %f364, %f358, %f353, %f346
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f364) : "f"(f358), "f"(f353), "f"(f346));
  // PTX:783 fma.rn.f32 %f365, %f359, %f353, %f347
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f365) : "f"(f359), "f"(f353), "f"(f347));
  // PTX:784 mov.b32 %r227, %f365
  asm("mov.b32 %0, %1;" : "=r"(r227) : "f"(f365));
  // PTX:785 mov.b32 %r226, %f364
  asm("mov.b32 %0, %1;" : "=r"(r226) : "f"(f364));
  // PTX:786 mov.b32 %r224, %f362
  asm("mov.b32 %0, %1;" : "=r"(r224) : "f"(f362));
  // PTX:787 mov.b32 %r225, %f363
  asm("mov.b32 %0, %1;" : "=r"(r225) : "f"(f363));
  // PTX:788 mov.b32 %r223, %f361
  asm("mov.b32 %0, %1;" : "=r"(r223) : "f"(f361));
  // PTX:789 mov.b32 %r222, %f360
  asm("mov.b32 %0, %1;" : "=r"(r222) : "f"(f360));
  // PTX:791 $L__BB54_36:
L_BB54_36:;
  // PTX:792 mov.b32 %f366, %r222
  asm("mov.b32 %0, %1;" : "=f"(f366) : "r"(r222));
  // PTX:793 add.f32 %f367, %f366, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f367) : "f"(f366));
  // PTX:794 mov.b32 %f368, %r223
  asm("mov.b32 %0, %1;" : "=f"(f368) : "r"(r223));
  // PTX:795 mov.b32 %f369, %r224
  asm("mov.b32 %0, %1;" : "=f"(f369) : "r"(r224));
  // PTX:796 mov.b32 %f370, %r223
  asm("mov.b32 %0, %1;" : "=f"(f370) : "r"(r223));
  // PTX:797 mov.b32 %f371, %r225
  asm("mov.b32 %0, %1;" : "=f"(f371) : "r"(r225));
  // PTX:798 add.f32 %f372, %f371, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f372) : "f"(f371));
  // PTX:799 mov.b32 %f373, %r226
  asm("mov.b32 %0, %1;" : "=f"(f373) : "r"(r226));
  // PTX:800 mov.b32 %f374, %r224
  asm("mov.b32 %0, %1;" : "=f"(f374) : "r"(r224));
  // PTX:801 mov.b32 %f375, %r226
  asm("mov.b32 %0, %1;" : "=f"(f375) : "r"(r226));
  // PTX:802 mov.b32 %f376, %r227
  asm("mov.b32 %0, %1;" : "=f"(f376) : "r"(r227));
  // PTX:803 add.f32 %f377, %f376, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f377) : "f"(f376));
  // PTX:804 mul.f32 %f378, %f1, %f367
  asm("mul.f32 %0, %1, %2;" : "=f"(f378) : "f"(f1), "f"(f367));
  // PTX:805 mul.f32 %f379, %f1, %f368
  asm("mul.f32 %0, %1, %2;" : "=f"(f379) : "f"(f1), "f"(f368));
  // PTX:806 mul.f32 %f380, %f1, %f369
  asm("mul.f32 %0, %1, %2;" : "=f"(f380) : "f"(f1), "f"(f369));
  // PTX:807 mul.f32 %f381, %f1, %f370
  asm("mul.f32 %0, %1, %2;" : "=f"(f381) : "f"(f1), "f"(f370));
  // PTX:808 mul.f32 %f382, %f1, %f372
  asm("mul.f32 %0, %1, %2;" : "=f"(f382) : "f"(f1), "f"(f372));
  // PTX:809 mul.f32 %f383, %f1, %f373
  asm("mul.f32 %0, %1, %2;" : "=f"(f383) : "f"(f1), "f"(f373));
  // PTX:810 mul.f32 %f384, %f1, %f374
  asm("mul.f32 %0, %1, %2;" : "=f"(f384) : "f"(f1), "f"(f374));
  // PTX:811 mul.f32 %f385, %f1, %f375
  asm("mul.f32 %0, %1, %2;" : "=f"(f385) : "f"(f1), "f"(f375));
  // PTX:812 mul.f32 %f386, %f1, %f377
  asm("mul.f32 %0, %1, %2;" : "=f"(f386) : "f"(f1), "f"(f377));
  // PTX:813 mul.lo.s64 %rd207, %rd17, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd207) : "l"(rd17));
  // PTX:814 add.s64 %rd38, %rd2, %rd207
  asm("add.s64 %0, %1, %2;" : "=l"(rd38) : "l"(rd2), "l"(rd207));
  // PTX:815 red.global.add.f32 [%rd38], %f378
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (0)))), (float)(f378));
  // PTX:816 add.s64 %rd208, %rd38, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd208) : "l"(rd38));
  // PTX:817 red.global.add.f32 [%rd208], %f379
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd208) + (0)))), (float)(f379));
  // PTX:818 add.s64 %rd209, %rd38, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd209) : "l"(rd38));
  // PTX:819 red.global.add.f32 [%rd209], %f380
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd209) + (0)))), (float)(f380));
  // PTX:820 add.s64 %rd210, %rd38, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd210) : "l"(rd38));
  // PTX:821 red.global.add.f32 [%rd210], %f381
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd210) + (0)))), (float)(f381));
  // PTX:822 add.s64 %rd211, %rd38, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd211) : "l"(rd38));
  // PTX:823 red.global.add.f32 [%rd211], %f382
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd211) + (0)))), (float)(f382));
  // PTX:824 add.s64 %rd212, %rd38, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd212) : "l"(rd38));
  // PTX:825 red.global.add.f32 [%rd212], %f383
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd212) + (0)))), (float)(f383));
  // PTX:826 add.s64 %rd213, %rd38, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd213) : "l"(rd38));
  // PTX:827 red.global.add.f32 [%rd213], %f384
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd213) + (0)))), (float)(f384));
  // PTX:828 add.s64 %rd214, %rd38, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd214) : "l"(rd38));
  // PTX:829 red.global.add.f32 [%rd214], %f385
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd214) + (0)))), (float)(f385));
  // PTX:830 add.s64 %rd215, %rd38, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd215) : "l"(rd38));
  // PTX:831 red.global.add.f32 [%rd215], %f386
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd215) + (0)))), (float)(f386));
  // PTX:832 mul.lo.s64 %rd216, %rd37, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd216) : "l"(rd37));
  // PTX:833 add.s64 %rd39, %rd2, %rd216
  asm("add.s64 %0, %1, %2;" : "=l"(rd39) : "l"(rd2), "l"(rd216));
  // PTX:834 red.global.add.f32 [%rd39], %f378
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (0)))), (float)(f378));
  // PTX:835 add.s64 %rd217, %rd39, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd217) : "l"(rd39));
  // PTX:836 red.global.add.f32 [%rd217], %f379
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd217) + (0)))), (float)(f379));
  // PTX:837 add.s64 %rd218, %rd39, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd218) : "l"(rd39));
  // PTX:838 red.global.add.f32 [%rd218], %f380
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd218) + (0)))), (float)(f380));
  // PTX:839 add.s64 %rd219, %rd39, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd219) : "l"(rd39));
  // PTX:840 red.global.add.f32 [%rd219], %f381
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd219) + (0)))), (float)(f381));
  // PTX:841 add.s64 %rd220, %rd39, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd220) : "l"(rd39));
  // PTX:842 red.global.add.f32 [%rd220], %f382
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd220) + (0)))), (float)(f382));
  // PTX:843 add.s64 %rd221, %rd39, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd221) : "l"(rd39));
  // PTX:844 red.global.add.f32 [%rd221], %f383
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd221) + (0)))), (float)(f383));
  // PTX:845 add.s64 %rd222, %rd39, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd222) : "l"(rd39));
  // PTX:846 red.global.add.f32 [%rd222], %f384
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd222) + (0)))), (float)(f384));
  // PTX:847 add.s64 %rd223, %rd39, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd223) : "l"(rd39));
  // PTX:848 red.global.add.f32 [%rd223], %f385
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd223) + (0)))), (float)(f385));
  // PTX:849 add.s64 %rd224, %rd39, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd224) : "l"(rd39));
  // PTX:850 red.global.add.f32 [%rd224], %f386
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd224) + (0)))), (float)(f386));
  // PTX:851 neg.f32 %f31, %f378
  asm("neg.f32 %0, %1;" : "=f"(f31) : "f"(f378));
  // PTX:852 neg.f32 %f32, %f379
  asm("neg.f32 %0, %1;" : "=f"(f32) : "f"(f379));
  // PTX:853 neg.f32 %f33, %f380
  asm("neg.f32 %0, %1;" : "=f"(f33) : "f"(f380));
  // PTX:854 neg.f32 %f34, %f381
  asm("neg.f32 %0, %1;" : "=f"(f34) : "f"(f381));
  // PTX:855 neg.f32 %f35, %f382
  asm("neg.f32 %0, %1;" : "=f"(f35) : "f"(f382));
  // PTX:856 neg.f32 %f36, %f383
  asm("neg.f32 %0, %1;" : "=f"(f36) : "f"(f383));
  // PTX:857 neg.f32 %f37, %f384
  asm("neg.f32 %0, %1;" : "=f"(f37) : "f"(f384));
  // PTX:858 neg.f32 %f38, %f385
  asm("neg.f32 %0, %1;" : "=f"(f38) : "f"(f385));
  // PTX:859 neg.f32 %f39, %f386
  asm("neg.f32 %0, %1;" : "=f"(f39) : "f"(f386));
  // PTX:860 cvt.u32.u64 %r171, %rd37
  asm("cvt.u32.u64 %0, %1;" : "=r"(r171) : "l"(rd37));
  // PTX:861 cvt.u32.u64 %r172, %rd17
  asm("cvt.u32.u64 %0, %1;" : "=r"(r172) : "l"(rd17));
  // PTX:862 setp.eq.s32 %p24, %r172, %r171
  p24 = (((int)(r172)) == ((int)(r171)));
  // PTX:863 @%p24 bra $L__BB54_43
  if (p24) { goto L_BB54_43; }
  // PTX:864 bra.uni $L__BB54_37
  goto L_BB54_37;
  // PTX:866 $L__BB54_43:
L_BB54_43:;
  // PTX:867 red.global.add.f32 [%rd38], %f31
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (0)))), (float)(f31));
  // PTX:868 red.global.add.f32 [%rd208], %f32
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd208) + (0)))), (float)(f32));
  // PTX:869 red.global.add.f32 [%rd209], %f33
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd209) + (0)))), (float)(f33));
  // PTX:870 red.global.add.f32 [%rd210], %f34
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd210) + (0)))), (float)(f34));
  // PTX:871 red.global.add.f32 [%rd211], %f35
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd211) + (0)))), (float)(f35));
  // PTX:872 red.global.add.f32 [%rd212], %f36
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd212) + (0)))), (float)(f36));
  // PTX:873 red.global.add.f32 [%rd213], %f37
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd213) + (0)))), (float)(f37));
  // PTX:874 red.global.add.f32 [%rd214], %f38
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd214) + (0)))), (float)(f38));
  // PTX:875 red.global.add.f32 [%rd215], %f39
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd215) + (0)))), (float)(f39));
  // PTX:876 bra.uni $L__BB54_44
  goto L_BB54_44;
  // PTX:878 $L__BB54_37:
L_BB54_37:;
  // PTX:879 mul.wide.s32 %rd305, %r139, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd305) : "r"(r139));
  // PTX:880 add.s64 %rd304, %rd3, %rd305
  asm("add.s64 %0, %1, %2;" : "=l"(rd304) : "l"(rd3), "l"(rd305));
  // PTX:881 ld.global.s32 %rd226, [%rd304]
  rd226 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd304) + (0)))));
  // PTX:882 mov.u64 %rd341, 0
  asm("mov.u64 %0, 0;" : "=l"(rd341) : );
  // PTX:883 min.u64 %rd40, %rd226, %rd56
  asm("min.u64 %0, %1, %2;" : "=l"(rd40) : "l"(rd226), "l"(rd56));
  // PTX:884 setp.eq.s64 %p25, %rd40, 0
  p25 = (((long long)(rd40)) == ((long long)(0)));
  // PTX:885 @%p25 bra $L__BB54_40
  if (p25) { goto L_BB54_40; }
  // PTX:887 mov.u64 %rd341, 0
  asm("mov.u64 %0, 0;" : "=l"(rd341) : );
  // PTX:888 mov.u64 %rd339, %rd40
  asm("mov.u64 %0, %1;" : "=l"(rd339) : "l"(rd40));
  // PTX:890 $L__BB54_39:
L_BB54_39:;
  // PTX:891 cvt.s64.s32 %rd322, %r161
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd322) : "r"(r161));
  // PTX:892 cvt.u32.u64 %r193, %rd322
  asm("cvt.u32.u64 %0, %1;" : "=r"(r193) : "l"(rd322));
  // PTX:893 sub.s64 %rd228, %rd339, %rd341
  asm("sub.s64 %0, %1, %2;" : "=l"(rd228) : "l"(rd339), "l"(rd341));
  // PTX:894 shr.u64 %rd229, %rd228, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd229) : "l"(rd228));
  // PTX:895 add.s64 %rd230, %rd229, %rd341
  asm("add.s64 %0, %1, %2;" : "=l"(rd230) : "l"(rd229), "l"(rd341));
  // PTX:896 mul.lo.s64 %rd231, %rd230, %rd59
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd231) : "l"(rd230), "l"(rd59));
  // PTX:897 add.s64 %rd232, %rd231, %rd17
  asm("add.s64 %0, %1, %2;" : "=l"(rd232) : "l"(rd231), "l"(rd17));
  // PTX:898 mul.lo.s64 %rd233, %rd232, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd233) : "l"(rd232));
  // PTX:899 add.s64 %rd234, %rd1, %rd233
  asm("add.s64 %0, %1, %2;" : "=l"(rd234) : "l"(rd1), "l"(rd233));
  // PTX:900 ld.global.u32 %r173, [%rd234]
  r173 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd234) + (0)))));
  // PTX:901 setp.lt.s32 %p26, %r173, %r193
  p26 = (((int)(r173)) < ((int)(r193)));
  // PTX:902 add.s64 %rd235, %rd230, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd235) : "l"(rd230));
  // PTX:903 selp.b64 %rd341, %rd235, %rd341, %p26
  rd341 = p26 ? rd235 : rd341;
  // PTX:904 selp.b64 %rd339, %rd339, %rd230, %p26
  rd339 = p26 ? rd339 : rd230;
  // PTX:905 setp.gt.u64 %p27, %rd339, %rd341
  p27 = (((unsigned long long)(rd339)) > ((unsigned long long)(rd341)));
  // PTX:906 @%p27 bra $L__BB54_39
  if (p27) { goto L_BB54_39; }
  // PTX:908 $L__BB54_40:
L_BB54_40:;
  // PTX:909 setp.ge.u64 %p28, %rd341, %rd40
  p28 = (((unsigned long long)(rd341)) >= ((unsigned long long)(rd40)));
  // PTX:910 @%p28 bra $L__BB54_44
  if (p28) { goto L_BB54_44; }
  // PTX:912 cvt.s64.s32 %rd330, %r161
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd330) : "r"(r161));
  // PTX:913 cvt.u32.u64 %r196, %rd330
  asm("cvt.u32.u64 %0, %1;" : "=r"(r196) : "l"(rd330));
  // PTX:914 mul.lo.s64 %rd236, %rd341, %rd59
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd236) : "l"(rd341), "l"(rd59));
  // PTX:915 add.s64 %rd46, %rd236, %rd17
  asm("add.s64 %0, %1, %2;" : "=l"(rd46) : "l"(rd236), "l"(rd17));
  // PTX:916 mul.lo.s64 %rd237, %rd46, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd237) : "l"(rd46));
  // PTX:917 add.s64 %rd238, %rd1, %rd237
  asm("add.s64 %0, %1, %2;" : "=l"(rd238) : "l"(rd1), "l"(rd237));
  // PTX:918 ld.global.u32 %r176, [%rd238]
  r176 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd238) + (0)))));
  // PTX:919 setp.ne.s32 %p29, %r176, %r196
  p29 = (((int)(r176)) != ((int)(r196)));
  // PTX:920 @%p29 bra $L__BB54_44
  if (p29) { goto L_BB54_44; }
  // PTX:922 add.s64 %rd241, %rd238, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd241) : "l"(rd238));
  // PTX:923 red.global.add.f32 [%rd241], %f31
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd241) + (0)))), (float)(f31));
  // PTX:924 add.s64 %rd242, %rd238, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd242) : "l"(rd238));
  // PTX:925 red.global.add.f32 [%rd242], %f32
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd242) + (0)))), (float)(f32));
  // PTX:926 add.s64 %rd243, %rd238, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd243) : "l"(rd238));
  // PTX:927 red.global.add.f32 [%rd243], %f33
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd243) + (0)))), (float)(f33));
  // PTX:928 add.s64 %rd244, %rd238, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd244) : "l"(rd238));
  // PTX:929 red.global.add.f32 [%rd244], %f34
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd244) + (0)))), (float)(f34));
  // PTX:930 add.s64 %rd245, %rd238, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd245) : "l"(rd238));
  // PTX:931 red.global.add.f32 [%rd245], %f35
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd245) + (0)))), (float)(f35));
  // PTX:932 add.s64 %rd246, %rd238, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd246) : "l"(rd238));
  // PTX:933 red.global.add.f32 [%rd246], %f36
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd246) + (0)))), (float)(f36));
  // PTX:934 add.s64 %rd247, %rd238, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd247) : "l"(rd238));
  // PTX:935 red.global.add.f32 [%rd247], %f37
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd247) + (0)))), (float)(f37));
  // PTX:936 add.s64 %rd248, %rd238, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd248) : "l"(rd238));
  // PTX:937 red.global.add.f32 [%rd248], %f38
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd248) + (0)))), (float)(f38));
  // PTX:938 add.s64 %rd249, %rd238, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd249) : "l"(rd238));
  // PTX:939 red.global.add.f32 [%rd249], %f39
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd249) + (0)))), (float)(f39));
  // PTX:941 $L__BB54_44:
L_BB54_44:;
  // PTX:942 @%p24 bra $L__BB54_51
  if (p24) { goto L_BB54_51; }
  // PTX:944 shl.b64 %rd259, %rd37, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd259) : "l"(rd37));
  // PTX:945 add.s64 %rd260, %rd3, %rd259
  asm("add.s64 %0, %1, %2;" : "=l"(rd260) : "l"(rd3), "l"(rd259));
  // PTX:946 ld.global.s32 %rd261, [%rd260]
  rd261 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd260) + (0)))));
  // PTX:947 mov.u64 %rd344, 0
  asm("mov.u64 %0, 0;" : "=l"(rd344) : );
  // PTX:948 min.u64 %rd47, %rd261, %rd56
  asm("min.u64 %0, %1, %2;" : "=l"(rd47) : "l"(rd261), "l"(rd56));
  // PTX:949 setp.eq.s64 %p31, %rd47, 0
  p31 = (((long long)(rd47)) == ((long long)(0)));
  // PTX:950 @%p31 bra $L__BB54_48
  if (p31) { goto L_BB54_48; }
  // PTX:952 mov.u64 %rd344, 0
  asm("mov.u64 %0, 0;" : "=l"(rd344) : );
  // PTX:953 mov.u64 %rd342, %rd47
  asm("mov.u64 %0, %1;" : "=l"(rd342) : "l"(rd47));
  // PTX:955 $L__BB54_47:
L_BB54_47:;
  // PTX:956 cvt.s64.s32 %rd323, %r139
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd323) : "r"(r139));
  // PTX:957 cvt.u32.u64 %r194, %rd323
  asm("cvt.u32.u64 %0, %1;" : "=r"(r194) : "l"(rd323));
  // PTX:958 sub.s64 %rd263, %rd342, %rd344
  asm("sub.s64 %0, %1, %2;" : "=l"(rd263) : "l"(rd342), "l"(rd344));
  // PTX:959 shr.u64 %rd264, %rd263, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd264) : "l"(rd263));
  // PTX:960 add.s64 %rd265, %rd264, %rd344
  asm("add.s64 %0, %1, %2;" : "=l"(rd265) : "l"(rd264), "l"(rd344));
  // PTX:961 mul.lo.s64 %rd266, %rd265, %rd59
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd266) : "l"(rd265), "l"(rd59));
  // PTX:962 add.s64 %rd267, %rd266, %rd37
  asm("add.s64 %0, %1, %2;" : "=l"(rd267) : "l"(rd266), "l"(rd37));
  // PTX:963 mul.lo.s64 %rd268, %rd267, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd268) : "l"(rd267));
  // PTX:964 add.s64 %rd269, %rd1, %rd268
  asm("add.s64 %0, %1, %2;" : "=l"(rd269) : "l"(rd1), "l"(rd268));
  // PTX:965 ld.global.u32 %r179, [%rd269]
  r179 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd269) + (0)))));
  // PTX:966 setp.lt.s32 %p32, %r179, %r194
  p32 = (((int)(r179)) < ((int)(r194)));
  // PTX:967 add.s64 %rd270, %rd265, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd270) : "l"(rd265));
  // PTX:968 selp.b64 %rd344, %rd270, %rd344, %p32
  rd344 = p32 ? rd270 : rd344;
  // PTX:969 selp.b64 %rd342, %rd342, %rd265, %p32
  rd342 = p32 ? rd342 : rd265;
  // PTX:970 setp.gt.u64 %p33, %rd342, %rd344
  p33 = (((unsigned long long)(rd342)) > ((unsigned long long)(rd344)));
  // PTX:971 @%p33 bra $L__BB54_47
  if (p33) { goto L_BB54_47; }
  // PTX:973 $L__BB54_48:
L_BB54_48:;
  // PTX:974 add.s32 %r215, %r57, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r215) : "r"(r57));
  // PTX:975 setp.ge.u64 %p34, %rd344, %rd47
  p34 = (((unsigned long long)(rd344)) >= ((unsigned long long)(rd47)));
  // PTX:976 @%p34 bra $L__BB54_11
  if (p34) { goto L_BB54_11; }
  // PTX:978 cvt.s64.s32 %rd324, %r139
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd324) : "r"(r139));
  // PTX:979 cvt.u32.u64 %r195, %rd324
  asm("cvt.u32.u64 %0, %1;" : "=r"(r195) : "l"(rd324));
  // PTX:980 add.s32 %r215, %r57, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r215) : "r"(r57));
  // PTX:981 mul.lo.s64 %rd271, %rd344, %rd59
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd271) : "l"(rd344), "l"(rd59));
  // PTX:982 add.s64 %rd53, %rd271, %rd37
  asm("add.s64 %0, %1, %2;" : "=l"(rd53) : "l"(rd271), "l"(rd37));
  // PTX:983 mul.lo.s64 %rd272, %rd53, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd272) : "l"(rd53));
  // PTX:984 add.s64 %rd273, %rd1, %rd272
  asm("add.s64 %0, %1, %2;" : "=l"(rd273) : "l"(rd1), "l"(rd272));
  // PTX:985 ld.global.u32 %r182, [%rd273]
  r182 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd273) + (0)))));
  // PTX:986 setp.ne.s32 %p35, %r182, %r195
  p35 = (((int)(r182)) != ((int)(r195)));
  // PTX:987 @%p35 bra $L__BB54_11
  if (p35) { goto L_BB54_11; }
  // PTX:989 add.s32 %r215, %r57, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r215) : "r"(r57));
  // PTX:990 add.s64 %rd276, %rd273, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd276) : "l"(rd273));
  // PTX:991 red.global.add.f32 [%rd276], %f31
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd276) + (0)))), (float)(f31));
  // PTX:992 add.s64 %rd277, %rd273, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd277) : "l"(rd273));
  // PTX:993 red.global.add.f32 [%rd277], %f32
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd277) + (0)))), (float)(f32));
  // PTX:994 add.s64 %rd278, %rd273, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd278) : "l"(rd273));
  // PTX:995 red.global.add.f32 [%rd278], %f33
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd278) + (0)))), (float)(f33));
  // PTX:996 add.s64 %rd279, %rd273, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd279) : "l"(rd273));
  // PTX:997 red.global.add.f32 [%rd279], %f34
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd279) + (0)))), (float)(f34));
  // PTX:998 add.s64 %rd280, %rd273, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd280) : "l"(rd273));
  // PTX:999 red.global.add.f32 [%rd280], %f35
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd280) + (0)))), (float)(f35));
  // PTX:1000 add.s64 %rd281, %rd273, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd281) : "l"(rd273));
  // PTX:1001 red.global.add.f32 [%rd281], %f36
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd281) + (0)))), (float)(f36));
  // PTX:1002 add.s64 %rd282, %rd273, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd282) : "l"(rd273));
  // PTX:1003 red.global.add.f32 [%rd282], %f37
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd282) + (0)))), (float)(f37));
  // PTX:1004 add.s64 %rd283, %rd273, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd283) : "l"(rd273));
  // PTX:1005 red.global.add.f32 [%rd283], %f38
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd283) + (0)))), (float)(f38));
  // PTX:1006 add.s64 %rd284, %rd273, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd284) : "l"(rd273));
  // PTX:1007 red.global.add.f32 [%rd284], %f39
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd284) + (0)))), (float)(f39));
  // PTX:1008 bra.uni $L__BB54_11
  goto L_BB54_11;
  // PTX:1010 $L__BB54_12:
L_BB54_12:;
  // PTX:1011 ret
  return;
}
