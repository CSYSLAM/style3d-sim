// 机械还原自 PTX：synreal::self_collision_kernel::accumulate_edge_edge(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, int const*, int const*, int const*, int const*, float const*, float, float, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, synreal::SelfCollisionContactTangent*, unsigned int*, unsigned long, unsigned long, unsigned long, int)
// PTX SHA256: 695fae1fddb52a2bd8f2f21aaef909acf6e00c6e77190d104e22c96d0cd725db
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__self_collision_kernel__accumulate_edge_edge(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, float param7, float param8, unsigned long long param9, unsigned long long param10, unsigned long long param11, unsigned long long param12, unsigned long long param13, unsigned long long param14, unsigned long long param15, unsigned param16) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57, p58, p59, p60, p61, p62, p63, p64, p65, p66, p67, p68, p69, p70, p71, p72, p73, p74, p75, p76, p77, p78, p79, p80, p81, p82, p83, p84, p85, p86;
  unsigned short rs0, rs1, rs2, rs3, rs4, rs5, rs6, rs7, rs8, rs9, rs10, rs11, rs12, rs13, rs14, rs15, rs16, rs17, rs18, rs19, rs20, rs21, rs22, rs23, rs24, rs25, rs26, rs27, rs28, rs29, rs30;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440, f441, f442, f443, f444, f445, f446, f447, f448, f449, f450, f451, f452, f453, f454, f455, f456, f457, f458, f459, f460, f461, f462, f463, f464, f465, f466, f467, f468, f469, f470, f471, f472, f473, f474, f475, f476, f477, f478, f479, f480, f481, f482, f483, f484, f485, f486, f487, f488, f489, f490, f491, f492, f493, f494, f495, f496, f497, f498, f499, f500, f501, f502, f503, f504, f505, f506, f507, f508, f509, f510, f511, f512;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135, rd136, rd137, rd138, rd139, rd140, rd141, rd142, rd143, rd144, rd145, rd146, rd147, rd148, rd149, rd150, rd151, rd152, rd153, rd154, rd155, rd156;
  // PTX:34 ld.param.u64 %rd32, [_ZN7synreal21self_collision_kernel20accumulate_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_SB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_0]
  rd32 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:35 ld.param.u64 %rd33, [_ZN7synreal21self_collision_kernel20accumulate_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_SB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_1]
  rd33 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:36 ld.param.u64 %rd34, [_ZN7synreal21self_collision_kernel20accumulate_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_SB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_2]
  rd34 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:37 ld.param.u64 %rd35, [_ZN7synreal21self_collision_kernel20accumulate_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_SB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_3]
  rd35 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:38 ld.param.u64 %rd36, [_ZN7synreal21self_collision_kernel20accumulate_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_SB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_6]
  rd36 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:39 ld.param.f32 %f170, [_ZN7synreal21self_collision_kernel20accumulate_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_SB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_7]
  f170 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param7 + (0))));
  // PTX:40 ld.param.f32 %f171, [_ZN7synreal21self_collision_kernel20accumulate_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_SB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_8]
  f171 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param8 + (0))));
  // PTX:41 ld.param.u64 %rd37, [_ZN7synreal21self_collision_kernel20accumulate_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_SB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_9]
  rd37 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:42 ld.param.u64 %rd38, [_ZN7synreal21self_collision_kernel20accumulate_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_SB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_10]
  rd38 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:43 ld.param.u64 %rd39, [_ZN7synreal21self_collision_kernel20accumulate_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_SB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_13]
  rd39 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:44 ld.param.u64 %rd30, [_ZN7synreal21self_collision_kernel20accumulate_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_SB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_14]
  rd30 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:45 ld.param.u64 %rd31, [_ZN7synreal21self_collision_kernel20accumulate_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_SB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_15]
  rd31 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param15 + (0))));
  // PTX:46 cvta.to.global.u64 %rd1, %rd38
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd38));
  // PTX:47 cvta.to.global.u64 %rd2, %rd35
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd35));
  // PTX:48 cvta.to.global.u64 %rd3, %rd34
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd34));
  // PTX:49 cvta.to.global.u64 %rd4, %rd37
  rd4 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd37));
  // PTX:50 cvta.to.global.u64 %rd5, %rd36
  rd5 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd36));
  // PTX:51 cvta.to.global.u64 %rd6, %rd32
  rd6 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd32));
  // PTX:52 cvta.to.global.u64 %rd7, %rd33
  rd7 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd33));
  // PTX:53 mov.u32 %r42, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r42) : "r"(blockIdx.x));
  // PTX:54 mov.u32 %r43, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r43) : "r"(blockDim.x));
  // PTX:55 mul.wide.u32 %rd40, %r42, %r43
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd40) : "r"(r42), "r"(r43));
  // PTX:56 mov.u32 %r44, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r44) : "r"(threadIdx.x));
  // PTX:57 cvt.u64.u32 %rd41, %r44
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd41) : "r"(r44));
  // PTX:58 add.s64 %rd8, %rd40, %rd41
  asm("add.s64 %0, %1, %2;" : "=l"(rd8) : "l"(rd40), "l"(rd41));
  // PTX:59 setp.ge.u64 %p1, %rd8, %rd39
  p1 = (((unsigned long long)(rd8)) >= ((unsigned long long)(rd39)));
  // PTX:60 @%p1 bra $L__BB10_85
  if (p1) { goto L_BB10_85; }
  // PTX:62 or.b64 %rd42, %rd8, %rd30
  asm("or.b64 %0, %1, %2;" : "=l"(rd42) : "l"(rd8), "l"(rd30));
  // PTX:63 and.b64 %rd43, %rd42, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd43) : "l"(rd42));
  // PTX:64 setp.eq.s64 %p2, %rd43, 0
  p2 = (((long long)(rd43)) == ((long long)(0)));
  // PTX:65 @%p2 bra $L__BB10_3
  if (p2) { goto L_BB10_3; }
  // PTX:67 div.u64 %rd155, %rd8, %rd30
  asm("div.u64 %0, %1, %2;" : "=l"(rd155) : "l"(rd8), "l"(rd30));
  // PTX:68 mul.lo.s64 %rd44, %rd155, %rd30
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd44) : "l"(rd155), "l"(rd30));
  // PTX:69 sub.s64 %rd156, %rd8, %rd44
  asm("sub.s64 %0, %1, %2;" : "=l"(rd156) : "l"(rd8), "l"(rd44));
  // PTX:70 bra.uni $L__BB10_4
  goto L_BB10_4;
  // PTX:72 $L__BB10_3:
L_BB10_3:;
  // PTX:73 cvt.u32.u64 %r45, %rd30
  asm("cvt.u32.u64 %0, %1;" : "=r"(r45) : "l"(rd30));
  // PTX:74 cvt.u32.u64 %r46, %rd8
  asm("cvt.u32.u64 %0, %1;" : "=r"(r46) : "l"(rd8));
  // PTX:75 div.u32 %r47, %r46, %r45
  asm("div.u32 %0, %1, %2;" : "=r"(r47) : "r"(r46), "r"(r45));
  // PTX:76 mul.lo.s32 %r48, %r47, %r45
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r48) : "r"(r47), "r"(r45));
  // PTX:77 sub.s32 %r49, %r46, %r48
  asm("sub.s32 %0, %1, %2;" : "=r"(r49) : "r"(r46), "r"(r48));
  // PTX:78 cvt.u64.u32 %rd155, %r47
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd155) : "r"(r47));
  // PTX:79 cvt.u64.u32 %rd156, %r49
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd156) : "r"(r49));
  // PTX:81 $L__BB10_4:
L_BB10_4:;
  // PTX:82 mul.lo.s64 %rd45, %rd155, %rd31
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd155), "l"(rd31));
  // PTX:83 cvt.u32.u64 %r1, %rd45
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd45));
  // PTX:84 shl.b64 %rd46, %rd156, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd46) : "l"(rd156));
  // PTX:85 add.s64 %rd47, %rd7, %rd46
  asm("add.s64 %0, %1, %2;" : "=l"(rd47) : "l"(rd7), "l"(rd46));
  // PTX:86 ld.global.u32 %r2, [%rd47+8]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (8)))));
  // PTX:87 add.s32 %r3, %r2, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r3) : "r"(r2), "r"(r1));
  // PTX:88 ld.global.u32 %r4, [%rd47+12]
  r4 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (12)))));
  // PTX:89 add.s32 %r5, %r4, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r5) : "r"(r4), "r"(r1));
  // PTX:90 mul.wide.s32 %rd48, %r3, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd48) : "r"(r3));
  // PTX:91 add.s64 %rd49, %rd6, %rd48
  asm("add.s64 %0, %1, %2;" : "=l"(rd49) : "l"(rd6), "l"(rd48));
  // PTX:92 mul.wide.s32 %rd50, %r5, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd50) : "r"(r5));
  // PTX:93 add.s64 %rd51, %rd6, %rd50
  asm("add.s64 %0, %1, %2;" : "=l"(rd51) : "l"(rd6), "l"(rd50));
  // PTX:94 ld.global.f32 %f1, [%rd51]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))));
  // PTX:95 ld.global.f32 %f2, [%rd49]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))));
  // PTX:96 sub.f32 %f172, %f2, %f1
  asm("sub.f32 %0, %1, %2;" : "=f"(f172) : "f"(f2), "f"(f1));
  // PTX:97 ld.global.f32 %f3, [%rd51+4]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (4)))));
  // PTX:98 ld.global.f32 %f4, [%rd49+4]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (4)))));
  // PTX:99 sub.f32 %f173, %f4, %f3
  asm("sub.f32 %0, %1, %2;" : "=f"(f173) : "f"(f4), "f"(f3));
  // PTX:100 ld.global.f32 %f5, [%rd51+8]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (8)))));
  // PTX:101 ld.global.f32 %f6, [%rd49+8]
  f6 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (8)))));
  // PTX:102 sub.f32 %f174, %f6, %f5
  asm("sub.f32 %0, %1, %2;" : "=f"(f174) : "f"(f6), "f"(f5));
  // PTX:103 mul.f32 %f175, %f173, %f173
  asm("mul.f32 %0, %1, %2;" : "=f"(f175) : "f"(f173), "f"(f173));
  // PTX:104 fma.rn.f32 %f176, %f172, %f172, %f175
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f176) : "f"(f172), "f"(f172), "f"(f175));
  // PTX:105 fma.rn.f32 %f177, %f174, %f174, %f176
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f177) : "f"(f174), "f"(f174), "f"(f176));
  // PTX:106 sqrt.rn.f32 %f7, %f177
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f7) : "f"(f177));
  // PTX:107 mul.wide.s32 %rd52, %r3, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd52) : "r"(r3));
  // PTX:108 add.s64 %rd53, %rd5, %rd52
  asm("add.s64 %0, %1, %2;" : "=l"(rd53) : "l"(rd5), "l"(rd52));
  // PTX:109 mul.wide.s32 %rd54, %r5, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd54) : "r"(r5));
  // PTX:110 add.s64 %rd55, %rd5, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd55) : "l"(rd5), "l"(rd54));
  // PTX:111 ld.global.f32 %f178, [%rd55]
  f178 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))));
  // PTX:112 ld.global.f32 %f179, [%rd53]
  f179 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))));
  // PTX:113 add.f32 %f180, %f179, %f178
  asm("add.f32 %0, %1, %2;" : "=f"(f180) : "f"(f179), "f"(f178));
  // PTX:114 mul.f32 %f8, %f180, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f8) : "f"(f180));
  // PTX:115 abs.f32 %f181, %f2
  asm("abs.f32 %0, %1;" : "=f"(f181) : "f"(f2));
  // PTX:116 setp.geu.f32 %p3, %f181, 0f7F800000
  p3 = ((isnan(((float)(f181))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f181)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:117 @%p3 bra $L__BB10_85
  if (p3) { goto L_BB10_85; }
  // PTX:119 abs.f32 %f182, %f4
  asm("abs.f32 %0, %1;" : "=f"(f182) : "f"(f4));
  // PTX:120 setp.geu.f32 %p4, %f182, 0f7F800000
  p4 = ((isnan(((float)(f182))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f182)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:121 @%p4 bra $L__BB10_85
  if (p4) { goto L_BB10_85; }
  // PTX:123 abs.f32 %f183, %f6
  asm("abs.f32 %0, %1;" : "=f"(f183) : "f"(f6));
  // PTX:124 setp.geu.f32 %p5, %f183, 0f7F800000
  p5 = ((isnan(((float)(f183))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f183)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:125 @%p5 bra $L__BB10_85
  if (p5) { goto L_BB10_85; }
  // PTX:127 abs.f32 %f184, %f1
  asm("abs.f32 %0, %1;" : "=f"(f184) : "f"(f1));
  // PTX:128 setp.geu.f32 %p6, %f184, 0f7F800000
  p6 = ((isnan(((float)(f184))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f184)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:129 @%p6 bra $L__BB10_85
  if (p6) { goto L_BB10_85; }
  // PTX:131 abs.f32 %f185, %f3
  asm("abs.f32 %0, %1;" : "=f"(f185) : "f"(f3));
  // PTX:132 setp.geu.f32 %p7, %f185, 0f7F800000
  p7 = ((isnan(((float)(f185))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f185)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:133 @%p7 bra $L__BB10_85
  if (p7) { goto L_BB10_85; }
  // PTX:135 abs.f32 %f186, %f5
  asm("abs.f32 %0, %1;" : "=f"(f186) : "f"(f5));
  // PTX:136 setp.geu.f32 %p8, %f186, 0f7F800000
  p8 = ((isnan(((float)(f186))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f186)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:137 @%p8 bra $L__BB10_85
  if (p8) { goto L_BB10_85; }
  // PTX:139 abs.f32 %f187, %f7
  asm("abs.f32 %0, %1;" : "=f"(f187) : "f"(f7));
  // PTX:140 setp.geu.f32 %p9, %f187, 0f7F800000
  p9 = ((isnan(((float)(f187))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f187)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:141 @%p9 bra $L__BB10_85
  if (p9) { goto L_BB10_85; }
  // PTX:143 abs.f32 %f188, %f8
  asm("abs.f32 %0, %1;" : "=f"(f188) : "f"(f8));
  // PTX:144 setp.geu.f32 %p10, %f188, 0f7F800000
  p10 = ((isnan(((float)(f188))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f188)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:145 @%p10 bra $L__BB10_85
  if (p10) { goto L_BB10_85; }
  // PTX:147 ld.param.u64 %rd151, [_ZN7synreal21self_collision_kernel20accumulate_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_SB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_4]
  rd151 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:148 cvta.to.global.u64 %rd56, %rd151
  rd56 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd151));
  // PTX:149 shl.b64 %rd57, %rd8, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd57) : "l"(rd8));
  // PTX:150 add.s64 %rd17, %rd56, %rd57
  asm("add.s64 %0, %1, %2;" : "=l"(rd17) : "l"(rd56), "l"(rd57));
  // PTX:151 ld.global.u32 %r78, [%rd17]
  r78 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:152 setp.lt.s32 %p11, %r78, 1
  p11 = (((int)(r78)) < ((int)(1)));
  // PTX:153 mov.f32 %f465, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f465) : );
  // PTX:154 mov.f32 %f466, %f465
  asm("mov.f32 %0, %1;" : "=f"(f466) : "f"(f465));
  // PTX:155 mov.f32 %f467, %f465
  asm("mov.f32 %0, %1;" : "=f"(f467) : "f"(f465));
  // PTX:156 mov.f32 %f468, %f465
  asm("mov.f32 %0, %1;" : "=f"(f468) : "f"(f465));
  // PTX:157 mov.f32 %f469, %f465
  asm("mov.f32 %0, %1;" : "=f"(f469) : "f"(f465));
  // PTX:158 mov.f32 %f470, %f465
  asm("mov.f32 %0, %1;" : "=f"(f470) : "f"(f465));
  // PTX:159 mov.f32 %f471, %f465
  asm("mov.f32 %0, %1;" : "=f"(f471) : "f"(f465));
  // PTX:160 mov.f32 %f472, %f465
  asm("mov.f32 %0, %1;" : "=f"(f472) : "f"(f465));
  // PTX:161 mov.f32 %f473, %f465
  asm("mov.f32 %0, %1;" : "=f"(f473) : "f"(f465));
  // PTX:162 mov.f32 %f474, %f465
  asm("mov.f32 %0, %1;" : "=f"(f474) : "f"(f465));
  // PTX:163 mov.f32 %f475, %f465
  asm("mov.f32 %0, %1;" : "=f"(f475) : "f"(f465));
  // PTX:164 mov.f32 %f476, %f465
  asm("mov.f32 %0, %1;" : "=f"(f476) : "f"(f465));
  // PTX:165 mov.f32 %f477, %f465
  asm("mov.f32 %0, %1;" : "=f"(f477) : "f"(f465));
  // PTX:166 mov.f32 %f478, %f465
  asm("mov.f32 %0, %1;" : "=f"(f478) : "f"(f465));
  // PTX:167 mov.f32 %f479, %f465
  asm("mov.f32 %0, %1;" : "=f"(f479) : "f"(f465));
  // PTX:168 mov.f32 %f480, %f465
  asm("mov.f32 %0, %1;" : "=f"(f480) : "f"(f465));
  // PTX:169 mov.f32 %f481, %f465
  asm("mov.f32 %0, %1;" : "=f"(f481) : "f"(f465));
  // PTX:170 mov.f32 %f482, %f465
  asm("mov.f32 %0, %1;" : "=f"(f482) : "f"(f465));
  // PTX:171 mov.f32 %f483, %f465
  asm("mov.f32 %0, %1;" : "=f"(f483) : "f"(f465));
  // PTX:172 mov.f32 %f484, %f465
  asm("mov.f32 %0, %1;" : "=f"(f484) : "f"(f465));
  // PTX:173 mov.f32 %f485, %f465
  asm("mov.f32 %0, %1;" : "=f"(f485) : "f"(f465));
  // PTX:174 mov.f32 %f486, %f465
  asm("mov.f32 %0, %1;" : "=f"(f486) : "f"(f465));
  // PTX:175 mov.f32 %f487, %f465
  asm("mov.f32 %0, %1;" : "=f"(f487) : "f"(f465));
  // PTX:176 mov.f32 %f488, %f465
  asm("mov.f32 %0, %1;" : "=f"(f488) : "f"(f465));
  // PTX:177 @%p11 bra $L__BB10_84
  if (p11) { goto L_BB10_84; }
  // PTX:179 ld.param.u64 %rd154, [_ZN7synreal21self_collision_kernel20accumulate_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_SB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_11]
  rd154 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:180 ld.param.u64 %rd153, [_ZN7synreal21self_collision_kernel20accumulate_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_SB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_12]
  rd153 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:181 ld.param.u64 %rd152, [_ZN7synreal21self_collision_kernel20accumulate_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_SB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_5]
  rd152 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:182 ld.param.u32 %r69, [_ZN7synreal21self_collision_kernel20accumulate_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_SB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_16]
  r69 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param16 + (0))));
  // PTX:183 cvt.s64.s32 %rd58, %r69
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd58) : "r"(r69));
  // PTX:184 mul.lo.s64 %rd18, %rd8, %rd58
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd18) : "l"(rd8), "l"(rd58));
  // PTX:185 sub.f32 %f9, %f1, %f2
  asm("sub.f32 %0, %1, %2;" : "=f"(f9) : "f"(f1), "f"(f2));
  // PTX:186 sub.f32 %f10, %f3, %f4
  asm("sub.f32 %0, %1, %2;" : "=f"(f10) : "f"(f3), "f"(f4));
  // PTX:187 mul.f32 %f237, %f10, %f10
  asm("mul.f32 %0, %1, %2;" : "=f"(f237) : "f"(f10), "f"(f10));
  // PTX:188 sub.f32 %f11, %f5, %f6
  asm("sub.f32 %0, %1, %2;" : "=f"(f11) : "f"(f5), "f"(f6));
  // PTX:189 fma.rn.f32 %f238, %f9, %f9, %f237
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f238) : "f"(f9), "f"(f9), "f"(f237));
  // PTX:190 fma.rn.f32 %f12, %f11, %f11, %f238
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f12) : "f"(f11), "f"(f11), "f"(f238));
  // PTX:191 shl.b64 %rd59, %rd156, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd59) : "l"(rd156));
  // PTX:192 add.s64 %rd19, %rd3, %rd59
  asm("add.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd3), "l"(rd59));
  // PTX:193 mul.f32 %f13, %f8, %f171
  asm("mul.f32 %0, %1, %2;" : "=f"(f13) : "f"(f8), "f"(f171));
  // PTX:194 cvta.to.global.u64 %rd20, %rd152
  rd20 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd152));
  // PTX:195 cvta.to.global.u64 %rd21, %rd153
  rd21 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd153));
  // PTX:196 cvta.to.global.u64 %rd22, %rd154
  rd22 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd154));
  // PTX:197 mov.u32 %r71, 0
  asm("mov.u32 %0, 0;" : "=r"(r71) : );
  // PTX:198 mov.f32 %f465, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f465) : );
  // PTX:200 $L__BB10_14:
L_BB10_14:;
  // PTX:201 cvt.s64.s32 %rd60, %r71
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd60) : "r"(r71));
  // PTX:202 add.s64 %rd61, %rd18, %rd60
  asm("add.s64 %0, %1, %2;" : "=l"(rd61) : "l"(rd18), "l"(rd60));
  // PTX:203 shl.b64 %rd62, %rd61, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd62) : "l"(rd61));
  // PTX:204 add.s64 %rd63, %rd20, %rd62
  asm("add.s64 %0, %1, %2;" : "=l"(rd63) : "l"(rd20), "l"(rd62));
  // PTX:205 ld.global.s32 %rd23, [%rd63]
  rd23 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (0)))));
  // PTX:206 setp.ge.u64 %p12, %rd156, %rd23
  p12 = (((unsigned long long)(rd156)) >= ((unsigned long long)(rd23)));
  // PTX:207 @%p12 bra $L__BB10_83
  if (p12) { goto L_BB10_83; }
  // PTX:209 shl.b64 %rd64, %rd23, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd64) : "l"(rd23));
  // PTX:210 add.s64 %rd65, %rd7, %rd64
  asm("add.s64 %0, %1, %2;" : "=l"(rd65) : "l"(rd7), "l"(rd64));
  // PTX:211 ld.global.u32 %r9, [%rd65+8]
  r9 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (8)))));
  // PTX:212 setp.eq.s32 %p13, %r2, %r9
  p13 = (((int)(r2)) == ((int)(r9)));
  // PTX:213 ld.global.u32 %r10, [%rd65+12]
  r10 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (12)))));
  // PTX:214 setp.eq.s32 %p14, %r2, %r10
  p14 = (((int)(r2)) == ((int)(r10)));
  // PTX:215 or.pred %p15, %p13, %p14
  p15 = ((p13) || (p14));
  // PTX:216 setp.eq.s32 %p16, %r4, %r9
  p16 = (((int)(r4)) == ((int)(r9)));
  // PTX:217 or.pred %p17, %p16, %p15
  p17 = ((p16) || (p15));
  // PTX:218 setp.eq.s32 %p18, %r4, %r10
  p18 = (((int)(r4)) == ((int)(r10)));
  // PTX:219 or.pred %p19, %p18, %p17
  p19 = ((p18) || (p17));
  // PTX:220 @%p19 bra $L__BB10_83
  if (p19) { goto L_BB10_83; }
  // PTX:222 ld.param.u64 %rd150, [_ZN7synreal21self_collision_kernel20accumulate_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_SB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_15]
  rd150 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param15 + (0))));
  // PTX:223 mul.lo.s64 %rd149, %rd155, %rd150
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd149) : "l"(rd155), "l"(rd150));
  // PTX:224 cvt.u32.u64 %r66, %rd149
  asm("cvt.u32.u64 %0, %1;" : "=r"(r66) : "l"(rd149));
  // PTX:225 add.s32 %r11, %r9, %r66
  asm("add.s32 %0, %1, %2;" : "=r"(r11) : "r"(r9), "r"(r66));
  // PTX:226 cvt.s64.s32 %rd24, %r11
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd24) : "r"(r11));
  // PTX:227 mul.wide.s32 %rd66, %r11, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd66) : "r"(r11));
  // PTX:228 add.s64 %rd67, %rd6, %rd66
  asm("add.s64 %0, %1, %2;" : "=l"(rd67) : "l"(rd6), "l"(rd66));
  // PTX:229 ld.global.u32 %r12, [%rd67+4]
  r12 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (4)))));
  // PTX:230 ld.global.u32 %r13, [%rd67+8]
  r13 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (8)))));
  // PTX:231 add.s32 %r14, %r10, %r66
  asm("add.s32 %0, %1, %2;" : "=r"(r14) : "r"(r10), "r"(r66));
  // PTX:232 cvt.s64.s32 %rd25, %r14
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd25) : "r"(r14));
  // PTX:233 mul.wide.s32 %rd68, %r14, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd68) : "r"(r14));
  // PTX:234 add.s64 %rd69, %rd6, %rd68
  asm("add.s64 %0, %1, %2;" : "=l"(rd69) : "l"(rd6), "l"(rd68));
  // PTX:235 ld.global.f32 %f38, [%rd69]
  f38 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (0)))));
  // PTX:236 ld.global.u32 %r15, [%rd69+4]
  r15 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (4)))));
  // PTX:237 ld.global.u32 %r16, [%rd69+8]
  r16 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (8)))));
  // PTX:238 ld.global.f32 %f39, [%rd67]
  f39 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0)))));
  // PTX:239 abs.f32 %f239, %f39
  asm("abs.f32 %0, %1;" : "=f"(f239) : "f"(f39));
  // PTX:240 setp.geu.f32 %p20, %f239, 0f7F800000
  p20 = ((isnan(((float)(f239))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f239)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:241 mov.u16 %rs25, 0
  asm("mov.u16 %0, 0;" : "=h"(rs25) : );
  // PTX:242 @%p20 bra $L__BB10_19
  if (p20) { goto L_BB10_19; }
  // PTX:244 mov.b32 %f240, %r12
  asm("mov.b32 %0, %1;" : "=f"(f240) : "r"(r12));
  // PTX:245 abs.f32 %f241, %f240
  asm("abs.f32 %0, %1;" : "=f"(f241) : "f"(f240));
  // PTX:246 setp.geu.f32 %p21, %f241, 0f7F800000
  p21 = ((isnan(((float)(f241))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f241)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:247 @%p21 bra $L__BB10_19
  if (p21) { goto L_BB10_19; }
  // PTX:249 mov.b32 %f242, %r13
  asm("mov.b32 %0, %1;" : "=f"(f242) : "r"(r13));
  // PTX:250 abs.f32 %f243, %f242
  asm("abs.f32 %0, %1;" : "=f"(f243) : "f"(f242));
  // PTX:251 setp.lt.f32 %p22, %f243, 0f7F800000
  p22 = (!(isnan(((float)(f243))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f243)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:252 selp.u16 %rs25, 1, 0, %p22
  rs25 = p22 ? 1 : 0;
  // PTX:254 $L__BB10_19:
L_BB10_19:;
  // PTX:255 setp.eq.s16 %p23, %rs25, 0
  p23 = (((short)(rs25)) == ((short)(0)));
  // PTX:256 @%p23 bra $L__BB10_83
  if (p23) { goto L_BB10_83; }
  // PTX:258 abs.f32 %f244, %f38
  asm("abs.f32 %0, %1;" : "=f"(f244) : "f"(f38));
  // PTX:259 setp.geu.f32 %p24, %f244, 0f7F800000
  p24 = ((isnan(((float)(f244))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f244)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:260 mov.u16 %rs26, 0
  asm("mov.u16 %0, 0;" : "=h"(rs26) : );
  // PTX:261 @%p24 bra $L__BB10_23
  if (p24) { goto L_BB10_23; }
  // PTX:263 mov.b32 %f245, %r15
  asm("mov.b32 %0, %1;" : "=f"(f245) : "r"(r15));
  // PTX:264 abs.f32 %f246, %f245
  asm("abs.f32 %0, %1;" : "=f"(f246) : "f"(f245));
  // PTX:265 setp.geu.f32 %p25, %f246, 0f7F800000
  p25 = ((isnan(((float)(f246))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f246)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:266 @%p25 bra $L__BB10_23
  if (p25) { goto L_BB10_23; }
  // PTX:268 mov.b32 %f247, %r16
  asm("mov.b32 %0, %1;" : "=f"(f247) : "r"(r16));
  // PTX:269 abs.f32 %f248, %f247
  asm("abs.f32 %0, %1;" : "=f"(f248) : "f"(f247));
  // PTX:270 setp.lt.f32 %p26, %f248, 0f7F800000
  p26 = (!(isnan(((float)(f248))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f248)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:271 selp.u16 %rs26, 1, 0, %p26
  rs26 = p26 ? 1 : 0;
  // PTX:273 $L__BB10_23:
L_BB10_23:;
  // PTX:274 setp.eq.s16 %p27, %rs26, 0
  p27 = (((short)(rs26)) == ((short)(0)));
  // PTX:275 @%p27 bra $L__BB10_83
  if (p27) { goto L_BB10_83; }
  // PTX:277 setp.le.f32 %p28, %f12, 0f3727C5AC
  p28 = (!(isnan(((float)(f12))) || isnan(((float)(as_f32(0x3727C5ACu))))) && (((float)(f12)) <= ((float)(as_f32(0x3727C5ACu)))));
  // PTX:278 mov.b32 %f40, %r12
  asm("mov.b32 %0, %1;" : "=f"(f40) : "r"(r12));
  // PTX:279 mov.b32 %f41, %r15
  asm("mov.b32 %0, %1;" : "=f"(f41) : "r"(r15));
  // PTX:280 sub.f32 %f42, %f41, %f40
  asm("sub.f32 %0, %1, %2;" : "=f"(f42) : "f"(f41), "f"(f40));
  // PTX:281 mov.b32 %f43, %r13
  asm("mov.b32 %0, %1;" : "=f"(f43) : "r"(r13));
  // PTX:282 mov.b32 %f44, %r16
  asm("mov.b32 %0, %1;" : "=f"(f44) : "r"(r16));
  // PTX:283 sub.f32 %f45, %f44, %f43
  asm("sub.f32 %0, %1, %2;" : "=f"(f45) : "f"(f44), "f"(f43));
  // PTX:284 sub.f32 %f46, %f4, %f40
  asm("sub.f32 %0, %1, %2;" : "=f"(f46) : "f"(f4), "f"(f40));
  // PTX:285 sub.f32 %f47, %f6, %f43
  asm("sub.f32 %0, %1, %2;" : "=f"(f47) : "f"(f6), "f"(f43));
  // PTX:286 sub.f32 %f48, %f38, %f39
  asm("sub.f32 %0, %1, %2;" : "=f"(f48) : "f"(f38), "f"(f39));
  // PTX:287 mul.f32 %f249, %f42, %f42
  asm("mul.f32 %0, %1, %2;" : "=f"(f249) : "f"(f42), "f"(f42));
  // PTX:288 fma.rn.f32 %f250, %f48, %f48, %f249
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f250) : "f"(f48), "f"(f48), "f"(f249));
  // PTX:289 fma.rn.f32 %f49, %f45, %f45, %f250
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f49) : "f"(f45), "f"(f45), "f"(f250));
  // PTX:290 sub.f32 %f50, %f2, %f39
  asm("sub.f32 %0, %1, %2;" : "=f"(f50) : "f"(f2), "f"(f39));
  // PTX:291 mul.f32 %f251, %f46, %f42
  asm("mul.f32 %0, %1, %2;" : "=f"(f251) : "f"(f46), "f"(f42));
  // PTX:292 fma.rn.f32 %f252, %f50, %f48, %f251
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f252) : "f"(f50), "f"(f48), "f"(f251));
  // PTX:293 fma.rn.f32 %f51, %f47, %f45, %f252
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f51) : "f"(f47), "f"(f45), "f"(f252));
  // PTX:294 setp.le.f32 %p29, %f49, 0f3727C5AC
  p29 = (!(isnan(((float)(f49))) || isnan(((float)(as_f32(0x3727C5ACu))))) && (((float)(f49)) <= ((float)(as_f32(0x3727C5ACu)))));
  // PTX:295 and.pred %p30, %p28, %p29
  p30 = ((p28) && (p29));
  // PTX:296 mov.u32 %r72, 0
  asm("mov.u32 %0, 0;" : "=r"(r72) : );
  // PTX:297 mov.u32 %r73, %r72
  asm("mov.u32 %0, %1;" : "=r"(r73) : "r"(r72));
  // PTX:298 @%p30 bra $L__BB10_36
  if (p30) { goto L_BB10_36; }
  // PTX:300 setp.gtu.f32 %p31, %f12, 0f3727C5AC
  p31 = ((isnan(((float)(f12))) || isnan(((float)(as_f32(0x3727C5ACu))))) || (((float)(f12)) > ((float)(as_f32(0x3727C5ACu)))));
  // PTX:301 @%p31 bra $L__BB10_27
  if (p31) { goto L_BB10_27; }
  // PTX:302 bra.uni $L__BB10_26
  goto L_BB10_26;
  // PTX:304 $L__BB10_27:
L_BB10_27:;
  // PTX:305 mov.b32 %f413, %r13
  asm("mov.b32 %0, %1;" : "=f"(f413) : "r"(r13));
  // PTX:306 sub.f32 %f412, %f6, %f413
  asm("sub.f32 %0, %1, %2;" : "=f"(f412) : "f"(f6), "f"(f413));
  // PTX:307 mov.b32 %f411, %r12
  asm("mov.b32 %0, %1;" : "=f"(f411) : "r"(r12));
  // PTX:308 sub.f32 %f410, %f4, %f411
  asm("sub.f32 %0, %1, %2;" : "=f"(f410) : "f"(f4), "f"(f411));
  // PTX:309 sub.f32 %f409, %f2, %f39
  asm("sub.f32 %0, %1, %2;" : "=f"(f409) : "f"(f2), "f"(f39));
  // PTX:310 setp.gtu.f32 %p32, %f49, 0f3727C5AC
  p32 = ((isnan(((float)(f49))) || isnan(((float)(as_f32(0x3727C5ACu))))) || (((float)(f49)) > ((float)(as_f32(0x3727C5ACu)))));
  // PTX:311 mul.f32 %f255, %f10, %f410
  asm("mul.f32 %0, %1, %2;" : "=f"(f255) : "f"(f10), "f"(f410));
  // PTX:312 fma.rn.f32 %f256, %f9, %f409, %f255
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f256) : "f"(f9), "f"(f409), "f"(f255));
  // PTX:313 fma.rn.f32 %f52, %f11, %f412, %f256
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f52) : "f"(f11), "f"(f412), "f"(f256));
  // PTX:314 @%p32 bra $L__BB10_29
  if (p32) { goto L_BB10_29; }
  // PTX:315 bra.uni $L__BB10_28
  goto L_BB10_28;
  // PTX:317 $L__BB10_29:
L_BB10_29:;
  // PTX:318 sub.f32 %f408, %f38, %f39
  asm("sub.f32 %0, %1, %2;" : "=f"(f408) : "f"(f38), "f"(f39));
  // PTX:319 mul.f32 %f261, %f10, %f42
  asm("mul.f32 %0, %1, %2;" : "=f"(f261) : "f"(f10), "f"(f42));
  // PTX:320 fma.rn.f32 %f262, %f9, %f408, %f261
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f262) : "f"(f9), "f"(f408), "f"(f261));
  // PTX:321 fma.rn.f32 %f53, %f11, %f45, %f262
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f53) : "f"(f11), "f"(f45), "f"(f262));
  // PTX:322 mul.f32 %f263, %f53, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f263) : "f"(f53), "f"(f53));
  // PTX:323 neg.f32 %f264, %f263
  asm("neg.f32 %0, %1;" : "=f"(f264) : "f"(f263));
  // PTX:324 fma.rn.f32 %f265, %f12, %f49, %f264
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f265) : "f"(f12), "f"(f49), "f"(f264));
  // PTX:325 neg.f32 %f266, %f53
  asm("neg.f32 %0, %1;" : "=f"(f266) : "f"(f53));
  // PTX:326 fma.rn.f32 %f267, %f266, %f53, %f263
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f267) : "f"(f266), "f"(f53), "f"(f263));
  // PTX:327 add.f32 %f54, %f265, %f267
  asm("add.f32 %0, %1, %2;" : "=f"(f54) : "f"(f265), "f"(f267));
  // PTX:328 setp.leu.f32 %p33, %f54, 0f00000000
  p33 = ((isnan(((float)(f54))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f54)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:329 mov.f32 %f459, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f459) : );
  // PTX:330 @%p33 bra $L__BB10_31
  if (p33) { goto L_BB10_31; }
  // PTX:332 mul.f32 %f268, %f52, %f49
  asm("mul.f32 %0, %1, %2;" : "=f"(f268) : "f"(f52), "f"(f49));
  // PTX:333 neg.f32 %f269, %f268
  asm("neg.f32 %0, %1;" : "=f"(f269) : "f"(f268));
  // PTX:334 fma.rn.f32 %f270, %f53, %f51, %f269
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f270) : "f"(f53), "f"(f51), "f"(f269));
  // PTX:335 neg.f32 %f271, %f52
  asm("neg.f32 %0, %1;" : "=f"(f271) : "f"(f52));
  // PTX:336 fma.rn.f32 %f272, %f271, %f49, %f268
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f272) : "f"(f271), "f"(f49), "f"(f268));
  // PTX:337 add.f32 %f273, %f270, %f272
  asm("add.f32 %0, %1, %2;" : "=f"(f273) : "f"(f270), "f"(f272));
  // PTX:338 div.rn.f32 %f274, %f273, %f54
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f274) : "f"(f273), "f"(f54));
  // PTX:339 cvt.sat.f32.f32 %f459, %f274
  asm("cvt.sat.f32.f32 %0, %1;" : "=f"(f459) : "f"(f274));
  // PTX:341 $L__BB10_31:
L_BB10_31:;
  // PTX:342 fma.rn.f32 %f275, %f53, %f459, %f51
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f275) : "f"(f53), "f"(f459), "f"(f51));
  // PTX:343 div.rn.f32 %f460, %f275, %f49
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f460) : "f"(f275), "f"(f49));
  // PTX:344 setp.lt.f32 %p34, %f460, 0f00000000
  p34 = (!(isnan(((float)(f460))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f460)) < ((float)(as_f32(0x00000000u)))));
  // PTX:345 @%p34 bra $L__BB10_34
  if (p34) { goto L_BB10_34; }
  // PTX:346 bra.uni $L__BB10_32
  goto L_BB10_32;
  // PTX:348 $L__BB10_34:
L_BB10_34:;
  // PTX:349 neg.f32 %f280, %f52
  asm("neg.f32 %0, %1;" : "=f"(f280) : "f"(f52));
  // PTX:350 div.rn.f32 %f281, %f280, %f12
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f281) : "f"(f280), "f"(f12));
  // PTX:351 mov.f32 %f460, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f460) : );
  // PTX:352 cvt.sat.f32.f32 %f459, %f281
  asm("cvt.sat.f32.f32 %0, %1;" : "=f"(f459) : "f"(f281));
  // PTX:353 bra.uni $L__BB10_35
  goto L_BB10_35;
  // PTX:355 $L__BB10_26:
L_BB10_26:;
  // PTX:356 mov.u32 %r72, 0
  asm("mov.u32 %0, 0;" : "=r"(r72) : );
  // PTX:357 div.rn.f32 %f253, %f51, %f49
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f253) : "f"(f51), "f"(f49));
  // PTX:358 cvt.sat.f32.f32 %f254, %f253
  asm("cvt.sat.f32.f32 %0, %1;" : "=f"(f254) : "f"(f253));
  // PTX:359 mov.b32 %r73, %f254
  asm("mov.b32 %0, %1;" : "=r"(r73) : "f"(f254));
  // PTX:360 bra.uni $L__BB10_36
  goto L_BB10_36;
  // PTX:362 $L__BB10_28:
L_BB10_28:;
  // PTX:363 mov.u32 %r73, 0
  asm("mov.u32 %0, 0;" : "=r"(r73) : );
  // PTX:364 neg.f32 %f257, %f52
  asm("neg.f32 %0, %1;" : "=f"(f257) : "f"(f52));
  // PTX:365 div.rn.f32 %f258, %f257, %f12
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f258) : "f"(f257), "f"(f12));
  // PTX:366 cvt.sat.f32.f32 %f259, %f258
  asm("cvt.sat.f32.f32 %0, %1;" : "=f"(f259) : "f"(f258));
  // PTX:367 mov.b32 %r72, %f259
  asm("mov.b32 %0, %1;" : "=r"(r72) : "f"(f259));
  // PTX:368 bra.uni $L__BB10_36
  goto L_BB10_36;
  // PTX:370 $L__BB10_32:
L_BB10_32:;
  // PTX:371 setp.leu.f32 %p35, %f460, 0f3F800000
  p35 = ((isnan(((float)(f460))) || isnan(((float)(as_f32(0x3F800000u))))) || (((float)(f460)) <= ((float)(as_f32(0x3F800000u)))));
  // PTX:372 @%p35 bra $L__BB10_35
  if (p35) { goto L_BB10_35; }
  // PTX:374 sub.f32 %f277, %f53, %f52
  asm("sub.f32 %0, %1, %2;" : "=f"(f277) : "f"(f53), "f"(f52));
  // PTX:375 div.rn.f32 %f278, %f277, %f12
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f278) : "f"(f277), "f"(f12));
  // PTX:376 cvt.sat.f32.f32 %f459, %f278
  asm("cvt.sat.f32.f32 %0, %1;" : "=f"(f459) : "f"(f278));
  // PTX:377 mov.f32 %f460, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f460) : );
  // PTX:379 $L__BB10_35:
L_BB10_35:;
  // PTX:380 mov.b32 %r73, %f460
  asm("mov.b32 %0, %1;" : "=r"(r73) : "f"(f460));
  // PTX:381 mov.b32 %r72, %f459
  asm("mov.b32 %0, %1;" : "=r"(r72) : "f"(f459));
  // PTX:383 $L__BB10_36:
L_BB10_36:;
  // PTX:384 mov.b32 %f62, %r72
  asm("mov.b32 %0, %1;" : "=f"(f62) : "r"(r72));
  // PTX:385 abs.f32 %f282, %f62
  asm("abs.f32 %0, %1;" : "=f"(f282) : "f"(f62));
  // PTX:386 setp.geu.f32 %p36, %f282, 0f7F800000
  p36 = ((isnan(((float)(f282))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f282)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:387 @%p36 bra $L__BB10_83
  if (p36) { goto L_BB10_83; }
  // PTX:389 mov.b32 %f416, %r72
  asm("mov.b32 %0, %1;" : "=f"(f416) : "r"(r72));
  // PTX:390 mov.b32 %f63, %r73
  asm("mov.b32 %0, %1;" : "=f"(f63) : "r"(r73));
  // PTX:391 abs.f32 %f283, %f63
  asm("abs.f32 %0, %1;" : "=f"(f283) : "f"(f63));
  // PTX:392 setp.geu.f32 %p37, %f283, 0f7F800000
  p37 = ((isnan(((float)(f283))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f283)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:393 setp.le.f32 %p38, %f416, 0f00000000
  p38 = (!(isnan(((float)(f416))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f416)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:394 or.pred %p39, %p38, %p37
  p39 = ((p38) || (p37));
  // PTX:395 setp.ge.f32 %p40, %f416, 0f3F800000
  p40 = (!(isnan(((float)(f416))) || isnan(((float)(as_f32(0x3F800000u))))) && (((float)(f416)) >= ((float)(as_f32(0x3F800000u)))));
  // PTX:396 or.pred %p41, %p40, %p39
  p41 = ((p40) || (p39));
  // PTX:397 setp.le.f32 %p42, %f63, 0f00000000
  p42 = (!(isnan(((float)(f63))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f63)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:398 or.pred %p43, %p42, %p41
  p43 = ((p42) || (p41));
  // PTX:399 setp.ge.f32 %p44, %f63, 0f3F800000
  p44 = (!(isnan(((float)(f63))) || isnan(((float)(as_f32(0x3F800000u))))) && (((float)(f63)) >= ((float)(as_f32(0x3F800000u)))));
  // PTX:400 or.pred %p45, %p44, %p43
  p45 = ((p44) || (p43));
  // PTX:401 @%p45 bra $L__BB10_83
  if (p45) { goto L_BB10_83; }
  // PTX:403 mov.b32 %f417, %r72
  asm("mov.b32 %0, %1;" : "=f"(f417) : "r"(r72));
  // PTX:404 mov.b32 %f415, %r13
  asm("mov.b32 %0, %1;" : "=f"(f415) : "r"(r13));
  // PTX:405 mov.b32 %f414, %r12
  asm("mov.b32 %0, %1;" : "=f"(f414) : "r"(r12));
  // PTX:406 sub.f32 %f407, %f38, %f39
  asm("sub.f32 %0, %1, %2;" : "=f"(f407) : "f"(f38), "f"(f39));
  // PTX:407 fma.rn.f32 %f284, %f9, %f417, %f2
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f284) : "f"(f9), "f"(f417), "f"(f2));
  // PTX:408 fma.rn.f32 %f285, %f10, %f417, %f4
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f285) : "f"(f10), "f"(f417), "f"(f4));
  // PTX:409 fma.rn.f32 %f286, %f11, %f417, %f6
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f286) : "f"(f11), "f"(f417), "f"(f6));
  // PTX:410 fma.rn.f32 %f287, %f407, %f63, %f39
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f287) : "f"(f407), "f"(f63), "f"(f39));
  // PTX:411 fma.rn.f32 %f288, %f42, %f63, %f414
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f288) : "f"(f42), "f"(f63), "f"(f414));
  // PTX:412 fma.rn.f32 %f289, %f45, %f63, %f415
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f289) : "f"(f45), "f"(f63), "f"(f415));
  // PTX:413 sub.f32 %f64, %f284, %f287
  asm("sub.f32 %0, %1, %2;" : "=f"(f64) : "f"(f284), "f"(f287));
  // PTX:414 sub.f32 %f65, %f285, %f288
  asm("sub.f32 %0, %1, %2;" : "=f"(f65) : "f"(f285), "f"(f288));
  // PTX:415 sub.f32 %f66, %f286, %f289
  asm("sub.f32 %0, %1, %2;" : "=f"(f66) : "f"(f286), "f"(f289));
  // PTX:416 mul.f32 %f290, %f65, %f65
  asm("mul.f32 %0, %1, %2;" : "=f"(f290) : "f"(f65), "f"(f65));
  // PTX:417 fma.rn.f32 %f291, %f64, %f64, %f290
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f291) : "f"(f64), "f"(f64), "f"(f290));
  // PTX:418 fma.rn.f32 %f292, %f66, %f66, %f291
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f292) : "f"(f66), "f"(f66), "f"(f291));
  // PTX:419 sqrt.rn.f32 %f67, %f292
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f67) : "f"(f292));
  // PTX:420 sub.f32 %f293, %f39, %f38
  asm("sub.f32 %0, %1, %2;" : "=f"(f293) : "f"(f39), "f"(f38));
  // PTX:421 sub.f32 %f294, %f414, %f41
  asm("sub.f32 %0, %1, %2;" : "=f"(f294) : "f"(f414), "f"(f41));
  // PTX:422 mul.f32 %f295, %f294, %f294
  asm("mul.f32 %0, %1, %2;" : "=f"(f295) : "f"(f294), "f"(f294));
  // PTX:423 sub.f32 %f296, %f415, %f44
  asm("sub.f32 %0, %1, %2;" : "=f"(f296) : "f"(f415), "f"(f44));
  // PTX:424 fma.rn.f32 %f297, %f293, %f293, %f295
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f297) : "f"(f293), "f"(f293), "f"(f295));
  // PTX:425 fma.rn.f32 %f298, %f296, %f296, %f297
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f298) : "f"(f296), "f"(f296), "f"(f297));
  // PTX:426 sqrt.rn.f32 %f299, %f298
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f299) : "f"(f298));
  // PTX:427 add.f32 %f300, %f7, %f299
  asm("add.f32 %0, %1, %2;" : "=f"(f300) : "f"(f7), "f"(f299));
  // PTX:428 mul.f32 %f68, %f300, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f68) : "f"(f300));
  // PTX:429 abs.f32 %f301, %f67
  asm("abs.f32 %0, %1;" : "=f"(f301) : "f"(f67));
  // PTX:430 setp.geu.f32 %p46, %f301, 0f7F800000
  p46 = ((isnan(((float)(f301))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f301)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:431 @%p46 bra $L__BB10_83
  if (p46) { goto L_BB10_83; }
  // PTX:433 abs.f32 %f302, %f68
  asm("abs.f32 %0, %1;" : "=f"(f302) : "f"(f68));
  // PTX:434 setp.geu.f32 %p47, %f302, 0f7F800000
  p47 = ((isnan(((float)(f302))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f302)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:435 @%p47 bra $L__BB10_83
  if (p47) { goto L_BB10_83; }
  // PTX:437 ld.global.u32 %r75, [%rd19]
  r75 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))));
  // PTX:438 ld.global.u32 %r27, [%rd19+4]
  r27 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (4)))));
  // PTX:439 setp.ge.s32 %p48, %r75, %r27
  p48 = (((int)(r75)) >= ((int)(r27)));
  // PTX:440 @%p48 bra $L__BB10_44
  if (p48) { goto L_BB10_44; }
  // PTX:442 mov.u32 %r74, %r75
  asm("mov.u32 %0, %1;" : "=r"(r74) : "r"(r75));
  // PTX:444 $L__BB10_42:
L_BB10_42:;
  // PTX:445 mul.wide.s32 %rd70, %r74, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd70) : "r"(r74));
  // PTX:446 add.s64 %rd71, %rd2, %rd70
  asm("add.s64 %0, %1, %2;" : "=l"(rd71) : "l"(rd2), "l"(rd70));
  // PTX:447 ld.global.u32 %r53, [%rd71]
  r53 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))));
  // PTX:448 setp.eq.s32 %p49, %r53, %r9
  p49 = (((int)(r53)) == ((int)(r9)));
  // PTX:449 add.s32 %r74, %r74, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r74) : "r"(r74));
  // PTX:450 @%p49 bra $L__BB10_54
  if (p49) { goto L_BB10_54; }
  // PTX:452 setp.lt.s32 %p50, %r74, %r27
  p50 = (((int)(r74)) < ((int)(r27)));
  // PTX:453 @%p50 bra $L__BB10_42
  if (p50) { goto L_BB10_42; }
  // PTX:455 $L__BB10_44:
L_BB10_44:;
  // PTX:456 @%p48 bra $L__BB10_47
  if (p48) { goto L_BB10_47; }
  // PTX:458 $L__BB10_45:
L_BB10_45:;
  // PTX:459 mul.wide.s32 %rd72, %r75, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd72) : "r"(r75));
  // PTX:460 add.s64 %rd73, %rd2, %rd72
  asm("add.s64 %0, %1, %2;" : "=l"(rd73) : "l"(rd2), "l"(rd72));
  // PTX:461 ld.global.u32 %r54, [%rd73]
  r54 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (0)))));
  // PTX:462 setp.eq.s32 %p52, %r54, %r10
  p52 = (((int)(r54)) == ((int)(r10)));
  // PTX:463 add.s32 %r75, %r75, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r75) : "r"(r75));
  // PTX:464 @%p52 bra $L__BB10_54
  if (p52) { goto L_BB10_54; }
  // PTX:466 setp.lt.s32 %p53, %r75, %r27
  p53 = (((int)(r75)) < ((int)(r27)));
  // PTX:467 @%p53 bra $L__BB10_45
  if (p53) { goto L_BB10_45; }
  // PTX:469 $L__BB10_47:
L_BB10_47:;
  // PTX:470 shl.b64 %rd74, %rd23, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd74) : "l"(rd23));
  // PTX:471 add.s64 %rd75, %rd3, %rd74
  asm("add.s64 %0, %1, %2;" : "=l"(rd75) : "l"(rd3), "l"(rd74));
  // PTX:472 ld.global.u32 %r32, [%rd75+4]
  r32 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (4)))));
  // PTX:473 ld.global.u32 %r77, [%rd75]
  r77 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (0)))));
  // PTX:474 setp.ge.s32 %p54, %r77, %r32
  p54 = (((int)(r77)) >= ((int)(r32)));
  // PTX:475 @%p54 bra $L__BB10_51
  if (p54) { goto L_BB10_51; }
  // PTX:477 mov.u32 %r76, %r77
  asm("mov.u32 %0, %1;" : "=r"(r76) : "r"(r77));
  // PTX:479 $L__BB10_49:
L_BB10_49:;
  // PTX:480 mul.wide.s32 %rd76, %r76, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd76) : "r"(r76));
  // PTX:481 add.s64 %rd77, %rd2, %rd76
  asm("add.s64 %0, %1, %2;" : "=l"(rd77) : "l"(rd2), "l"(rd76));
  // PTX:482 ld.global.u32 %r55, [%rd77]
  r55 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (0)))));
  // PTX:483 setp.eq.s32 %p55, %r55, %r2
  p55 = (((int)(r55)) == ((int)(r2)));
  // PTX:484 add.s32 %r76, %r76, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r76) : "r"(r76));
  // PTX:485 @%p55 bra $L__BB10_54
  if (p55) { goto L_BB10_54; }
  // PTX:487 setp.lt.s32 %p56, %r76, %r32
  p56 = (((int)(r76)) < ((int)(r32)));
  // PTX:488 @%p56 bra $L__BB10_49
  if (p56) { goto L_BB10_49; }
  // PTX:490 $L__BB10_51:
L_BB10_51:;
  // PTX:491 mov.f32 %f461, %f170
  asm("mov.f32 %0, %1;" : "=f"(f461) : "f"(f170));
  // PTX:492 @%p54 bra $L__BB10_55
  if (p54) { goto L_BB10_55; }
  // PTX:494 $L__BB10_52:
L_BB10_52:;
  // PTX:495 mul.wide.s32 %rd78, %r77, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd78) : "r"(r77));
  // PTX:496 add.s64 %rd79, %rd2, %rd78
  asm("add.s64 %0, %1, %2;" : "=l"(rd79) : "l"(rd2), "l"(rd78));
  // PTX:497 ld.global.u32 %r56, [%rd79]
  r56 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (0)))));
  // PTX:498 setp.eq.s32 %p58, %r56, %r4
  p58 = (((int)(r56)) == ((int)(r4)));
  // PTX:499 add.s32 %r77, %r77, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r77) : "r"(r77));
  // PTX:500 @%p58 bra $L__BB10_54
  if (p58) { goto L_BB10_54; }
  // PTX:502 setp.lt.s32 %p59, %r77, %r32
  p59 = (((int)(r77)) < ((int)(r32)));
  // PTX:503 mov.f32 %f461, %f170
  asm("mov.f32 %0, %1;" : "=f"(f461) : "f"(f170));
  // PTX:504 @%p59 bra $L__BB10_52
  if (p59) { goto L_BB10_52; }
  // PTX:505 bra.uni $L__BB10_55
  goto L_BB10_55;
  // PTX:507 $L__BB10_54:
L_BB10_54:;
  // PTX:508 mul.f32 %f303, %f68, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f303) : "f"(f68));
  // PTX:509 min.f32 %f461, %f170, %f303
  asm("min.f32 %0, %1, %2;" : "=f"(f461) : "f"(f170), "f"(f303));
  // PTX:511 $L__BB10_55:
L_BB10_55:;
  // PTX:512 setp.ge.f32 %p60, %f67, %f461
  p60 = (!(isnan(((float)(f67))) || isnan(((float)(f461)))) && (((float)(f67)) >= ((float)(f461))));
  // PTX:513 setp.le.f32 %p61, %f67, 0f358637BD
  p61 = (!(isnan(((float)(f67))) || isnan(((float)(as_f32(0x358637BDu))))) && (((float)(f67)) <= ((float)(as_f32(0x358637BDu)))));
  // PTX:514 or.pred %p62, %p61, %p60
  p62 = ((p61) || (p60));
  // PTX:515 @%p62 bra $L__BB10_83
  if (p62) { goto L_BB10_83; }
  // PTX:517 setp.eq.f32 %p63, %f8, 0f00000000
  p63 = (!(isnan(((float)(f8))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f8)) == ((float)(as_f32(0x00000000u)))));
  // PTX:518 div.rn.f32 %f71, %f64, %f67
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f71) : "f"(f64), "f"(f67));
  // PTX:519 div.rn.f32 %f72, %f65, %f67
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f72) : "f"(f65), "f"(f67));
  // PTX:520 div.rn.f32 %f73, %f66, %f67
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f73) : "f"(f66), "f"(f67));
  // PTX:521 shl.b64 %rd80, %rd25, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd80) : "l"(rd25));
  // PTX:522 add.s64 %rd81, %rd5, %rd80
  asm("add.s64 %0, %1, %2;" : "=l"(rd81) : "l"(rd5), "l"(rd80));
  // PTX:523 ld.global.f32 %f304, [%rd81]
  f304 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (0)))));
  // PTX:524 shl.b64 %rd82, %rd24, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd82) : "l"(rd24));
  // PTX:525 add.s64 %rd83, %rd5, %rd82
  asm("add.s64 %0, %1, %2;" : "=l"(rd83) : "l"(rd5), "l"(rd82));
  // PTX:526 ld.global.f32 %f305, [%rd83]
  f305 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (0)))));
  // PTX:527 add.f32 %f306, %f305, %f304
  asm("add.f32 %0, %1, %2;" : "=f"(f306) : "f"(f305), "f"(f304));
  // PTX:528 mul.f32 %f74, %f306, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f74) : "f"(f306));
  // PTX:529 setp.eq.f32 %p64, %f74, 0f00000000
  p64 = (!(isnan(((float)(f74))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f74)) == ((float)(as_f32(0x00000000u)))));
  // PTX:530 or.pred %p65, %p63, %p64
  p65 = ((p63) || (p64));
  // PTX:531 @%p65 bra $L__BB10_61
  if (p65) { goto L_BB10_61; }
  // PTX:532 bra.uni $L__BB10_57
  goto L_BB10_57;
  // PTX:534 $L__BB10_61:
L_BB10_61:;
  // PTX:535 add.f32 %f314, %f8, %f74
  asm("add.f32 %0, %1, %2;" : "=f"(f314) : "f"(f8), "f"(f74));
  // PTX:536 mul.f32 %f462, %f314, %f171
  asm("mul.f32 %0, %1, %2;" : "=f"(f462) : "f"(f314), "f"(f171));
  // PTX:537 bra.uni $L__BB10_62
  goto L_BB10_62;
  // PTX:539 $L__BB10_57:
L_BB10_57:;
  // PTX:540 mul.f32 %f75, %f13, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f75) : "f"(f13), "f"(f74));
  // PTX:541 add.f32 %f76, %f8, %f74
  asm("add.f32 %0, %1, %2;" : "=f"(f76) : "f"(f8), "f"(f74));
  // PTX:542 abs.f32 %f307, %f75
  asm("abs.f32 %0, %1;" : "=f"(f307) : "f"(f75));
  // PTX:543 setp.geu.f32 %p66, %f307, 0f7F800000
  p66 = ((isnan(((float)(f307))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f307)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:544 @%p66 bra $L__BB10_60
  if (p66) { goto L_BB10_60; }
  // PTX:546 abs.f32 %f308, %f76
  asm("abs.f32 %0, %1;" : "=f"(f308) : "f"(f76));
  // PTX:547 setp.geu.f32 %p67, %f308, 0f7F800000
  p67 = ((isnan(((float)(f308))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f308)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:548 @%p67 bra $L__BB10_60
  if (p67) { goto L_BB10_60; }
  // PTX:549 bra.uni $L__BB10_59
  goto L_BB10_59;
  // PTX:551 $L__BB10_60:
L_BB10_60:;
  // PTX:552 min.f32 %f309, %f8, %f74
  asm("min.f32 %0, %1, %2;" : "=f"(f309) : "f"(f8), "f"(f74));
  // PTX:553 max.f32 %f310, %f8, %f74
  asm("max.f32 %0, %1, %2;" : "=f"(f310) : "f"(f8), "f"(f74));
  // PTX:554 div.rn.f32 %f311, %f309, %f310
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f311) : "f"(f309), "f"(f310));
  // PTX:555 add.f32 %f312, %f311, 0f3F800000
  asm("add.f32 %0, %1, 0f3F800000;" : "=f"(f312) : "f"(f311));
  // PTX:556 div.rn.f32 %f313, %f309, %f312
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f313) : "f"(f309), "f"(f312));
  // PTX:557 mul.f32 %f462, %f313, %f171
  asm("mul.f32 %0, %1, %2;" : "=f"(f462) : "f"(f313), "f"(f171));
  // PTX:558 bra.uni $L__BB10_62
  goto L_BB10_62;
  // PTX:560 $L__BB10_59:
L_BB10_59:;
  // PTX:561 div.rn.f32 %f462, %f75, %f76
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f462) : "f"(f75), "f"(f76));
  // PTX:563 $L__BB10_62:
L_BB10_62:;
  // PTX:564 abs.f32 %f315, %f462
  asm("abs.f32 %0, %1;" : "=f"(f315) : "f"(f462));
  // PTX:565 setp.geu.f32 %p68, %f315, 0f7F800000
  p68 = ((isnan(((float)(f315))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f315)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:566 @%p68 bra $L__BB10_83
  if (p68) { goto L_BB10_83; }
  // PTX:568 sub.f32 %f316, %f461, %f67
  asm("sub.f32 %0, %1, %2;" : "=f"(f316) : "f"(f461), "f"(f67));
  // PTX:569 mul.f32 %f317, %f316, %f462
  asm("mul.f32 %0, %1, %2;" : "=f"(f317) : "f"(f316), "f"(f462));
  // PTX:570 mul.f32 %f81, %f71, %f317
  asm("mul.f32 %0, %1, %2;" : "=f"(f81) : "f"(f71), "f"(f317));
  // PTX:571 mul.f32 %f318, %f71, %f71
  asm("mul.f32 %0, %1, %2;" : "=f"(f318) : "f"(f71), "f"(f71));
  // PTX:572 mul.f32 %f84, %f318, %f462
  asm("mul.f32 %0, %1, %2;" : "=f"(f84) : "f"(f318), "f"(f462));
  // PTX:573 mul.f32 %f319, %f72, %f71
  asm("mul.f32 %0, %1, %2;" : "=f"(f319) : "f"(f72), "f"(f71));
  // PTX:574 mul.f32 %f85, %f319, %f462
  asm("mul.f32 %0, %1, %2;" : "=f"(f85) : "f"(f319), "f"(f462));
  // PTX:575 mul.f32 %f320, %f73, %f71
  asm("mul.f32 %0, %1, %2;" : "=f"(f320) : "f"(f73), "f"(f71));
  // PTX:576 mul.f32 %f86, %f320, %f462
  asm("mul.f32 %0, %1, %2;" : "=f"(f86) : "f"(f320), "f"(f462));
  // PTX:577 mul.f32 %f321, %f72, %f72
  asm("mul.f32 %0, %1, %2;" : "=f"(f321) : "f"(f72), "f"(f72));
  // PTX:578 mul.f32 %f87, %f321, %f462
  asm("mul.f32 %0, %1, %2;" : "=f"(f87) : "f"(f321), "f"(f462));
  // PTX:579 mul.f32 %f322, %f73, %f72
  asm("mul.f32 %0, %1, %2;" : "=f"(f322) : "f"(f73), "f"(f72));
  // PTX:580 mul.f32 %f88, %f322, %f462
  asm("mul.f32 %0, %1, %2;" : "=f"(f88) : "f"(f322), "f"(f462));
  // PTX:581 mul.f32 %f323, %f73, %f73
  asm("mul.f32 %0, %1, %2;" : "=f"(f323) : "f"(f73), "f"(f73));
  // PTX:582 mul.f32 %f89, %f323, %f462
  asm("mul.f32 %0, %1, %2;" : "=f"(f89) : "f"(f323), "f"(f462));
  // PTX:583 abs.f32 %f324, %f81
  asm("abs.f32 %0, %1;" : "=f"(f324) : "f"(f81));
  // PTX:584 setp.geu.f32 %p69, %f324, 0f7F800000
  p69 = ((isnan(((float)(f324))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f324)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:585 mov.u16 %rs27, 0
  asm("mov.u16 %0, 0;" : "=h"(rs27) : );
  // PTX:586 @%p69 bra $L__BB10_66
  if (p69) { goto L_BB10_66; }
  // PTX:588 mul.f32 %f420, %f72, %f317
  asm("mul.f32 %0, %1, %2;" : "=f"(f420) : "f"(f72), "f"(f317));
  // PTX:589 abs.f32 %f325, %f420
  asm("abs.f32 %0, %1;" : "=f"(f325) : "f"(f420));
  // PTX:590 setp.geu.f32 %p70, %f325, 0f7F800000
  p70 = ((isnan(((float)(f325))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f325)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:591 @%p70 bra $L__BB10_66
  if (p70) { goto L_BB10_66; }
  // PTX:593 mul.f32 %f421, %f73, %f317
  asm("mul.f32 %0, %1, %2;" : "=f"(f421) : "f"(f73), "f"(f317));
  // PTX:594 abs.f32 %f326, %f421
  asm("abs.f32 %0, %1;" : "=f"(f326) : "f"(f421));
  // PTX:595 setp.lt.f32 %p71, %f326, 0f7F800000
  p71 = (!(isnan(((float)(f326))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f326)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:596 selp.u16 %rs27, 1, 0, %p71
  rs27 = p71 ? 1 : 0;
  // PTX:598 $L__BB10_66:
L_BB10_66:;
  // PTX:599 setp.eq.s16 %p72, %rs27, 0
  p72 = (((short)(rs27)) == ((short)(0)));
  // PTX:600 @%p72 bra $L__BB10_83
  if (p72) { goto L_BB10_83; }
  // PTX:602 abs.f32 %f327, %f84
  asm("abs.f32 %0, %1;" : "=f"(f327) : "f"(f84));
  // PTX:603 setp.geu.f32 %p73, %f327, 0f7F800000
  p73 = ((isnan(((float)(f327))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f327)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:604 mov.u16 %rs28, 0
  asm("mov.u16 %0, 0;" : "=h"(rs28) : );
  // PTX:605 @%p73 bra $L__BB10_70
  if (p73) { goto L_BB10_70; }
  // PTX:607 abs.f32 %f328, %f85
  asm("abs.f32 %0, %1;" : "=f"(f328) : "f"(f85));
  // PTX:608 setp.geu.f32 %p74, %f328, 0f7F800000
  p74 = ((isnan(((float)(f328))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f328)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:609 @%p74 bra $L__BB10_70
  if (p74) { goto L_BB10_70; }
  // PTX:611 abs.f32 %f329, %f86
  asm("abs.f32 %0, %1;" : "=f"(f329) : "f"(f86));
  // PTX:612 setp.lt.f32 %p75, %f329, 0f7F800000
  p75 = (!(isnan(((float)(f329))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f329)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:613 selp.u16 %rs28, 1, 0, %p75
  rs28 = p75 ? 1 : 0;
  // PTX:615 $L__BB10_70:
L_BB10_70:;
  // PTX:616 setp.eq.s16 %p76, %rs28, 0
  p76 = (((short)(rs28)) == ((short)(0)));
  // PTX:617 @%p76 bra $L__BB10_83
  if (p76) { goto L_BB10_83; }
  // PTX:619 abs.f32 %f330, %f85
  asm("abs.f32 %0, %1;" : "=f"(f330) : "f"(f85));
  // PTX:620 setp.geu.f32 %p77, %f330, 0f7F800000
  p77 = ((isnan(((float)(f330))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f330)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:621 mov.u16 %rs29, 0
  asm("mov.u16 %0, 0;" : "=h"(rs29) : );
  // PTX:622 @%p77 bra $L__BB10_74
  if (p77) { goto L_BB10_74; }
  // PTX:624 abs.f32 %f331, %f87
  asm("abs.f32 %0, %1;" : "=f"(f331) : "f"(f87));
  // PTX:625 setp.geu.f32 %p78, %f331, 0f7F800000
  p78 = ((isnan(((float)(f331))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f331)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:626 @%p78 bra $L__BB10_74
  if (p78) { goto L_BB10_74; }
  // PTX:628 abs.f32 %f332, %f88
  asm("abs.f32 %0, %1;" : "=f"(f332) : "f"(f88));
  // PTX:629 setp.lt.f32 %p79, %f332, 0f7F800000
  p79 = (!(isnan(((float)(f332))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f332)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:630 selp.u16 %rs29, 1, 0, %p79
  rs29 = p79 ? 1 : 0;
  // PTX:632 $L__BB10_74:
L_BB10_74:;
  // PTX:633 setp.eq.s16 %p80, %rs29, 0
  p80 = (((short)(rs29)) == ((short)(0)));
  // PTX:634 @%p80 bra $L__BB10_83
  if (p80) { goto L_BB10_83; }
  // PTX:636 abs.f32 %f333, %f86
  asm("abs.f32 %0, %1;" : "=f"(f333) : "f"(f86));
  // PTX:637 setp.geu.f32 %p81, %f333, 0f7F800000
  p81 = ((isnan(((float)(f333))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f333)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:638 mov.u16 %rs30, 0
  asm("mov.u16 %0, 0;" : "=h"(rs30) : );
  // PTX:639 @%p81 bra $L__BB10_78
  if (p81) { goto L_BB10_78; }
  // PTX:641 abs.f32 %f334, %f88
  asm("abs.f32 %0, %1;" : "=f"(f334) : "f"(f88));
  // PTX:642 setp.geu.f32 %p82, %f334, 0f7F800000
  p82 = ((isnan(((float)(f334))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f334)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:643 @%p82 bra $L__BB10_78
  if (p82) { goto L_BB10_78; }
  // PTX:645 abs.f32 %f335, %f89
  asm("abs.f32 %0, %1;" : "=f"(f335) : "f"(f89));
  // PTX:646 setp.lt.f32 %p83, %f335, 0f7F800000
  p83 = (!(isnan(((float)(f335))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f335)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:647 selp.u16 %rs30, 1, 0, %p83
  rs30 = p83 ? 1 : 0;
  // PTX:649 $L__BB10_78:
L_BB10_78:;
  // PTX:650 setp.eq.s16 %p84, %rs30, 0
  p84 = (((short)(rs30)) == ((short)(0)));
  // PTX:651 @%p84 bra $L__BB10_83
  if (p84) { goto L_BB10_83; }
  // PTX:653 ld.param.u64 %rd142, [_ZN7synreal21self_collision_kernel20accumulate_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_SB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_11]
  rd142 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:654 setp.eq.s64 %p85, %rd142, 0
  p85 = (((long long)(rd142)) == ((long long)(0)));
  // PTX:655 mov.f32 %f336, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f336) : );
  // PTX:656 sub.f32 %f91, %f336, %f63
  asm("sub.f32 %0, %1, %2;" : "=f"(f91) : "f"(f336), "f"(f63));
  // PTX:657 @%p85 bra $L__BB10_81
  if (p85) { goto L_BB10_81; }
  // PTX:659 mov.b32 %f428, %r73
  asm("mov.b32 %0, %1;" : "=f"(f428) : "r"(r73));
  // PTX:660 mov.b32 %f427, %r72
  asm("mov.b32 %0, %1;" : "=f"(f427) : "r"(r72));
  // PTX:661 mov.f32 %f426, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f426) : );
  // PTX:662 sub.f32 %f425, %f426, %f427
  asm("sub.f32 %0, %1, %2;" : "=f"(f425) : "f"(f426), "f"(f427));
  // PTX:663 ld.param.u64 %rd144, [_ZN7synreal21self_collision_kernel20accumulate_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_SB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_15]
  rd144 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param15 + (0))));
  // PTX:664 mul.lo.s64 %rd143, %rd155, %rd144
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd143) : "l"(rd155), "l"(rd144));
  // PTX:665 cvt.u32.u64 %r62, %rd143
  asm("cvt.u32.u64 %0, %1;" : "=r"(r62) : "l"(rd143));
  // PTX:666 add.s32 %r61, %r10, %r62
  asm("add.s32 %0, %1, %2;" : "=r"(r61) : "r"(r10), "r"(r62));
  // PTX:667 add.s32 %r60, %r9, %r62
  asm("add.s32 %0, %1, %2;" : "=r"(r60) : "r"(r9), "r"(r62));
  // PTX:668 neg.f32 %f463, %f428
  asm("neg.f32 %0, %1;" : "=f"(f463) : "f"(f428));
  // PTX:669 atom.global.add.u32 %r57, [%rd21], 1
  r57 = atomicAdd(reinterpret_cast<unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (0)))), (unsigned)(1));
  // PTX:670 mul.wide.u32 %rd84, %r57, 60
  asm("mul.wide.u32 %0, %1, 60;" : "=l"(rd84) : "r"(r57));
  // PTX:671 add.s64 %rd85, %rd22, %rd84
  asm("add.s64 %0, %1, %2;" : "=l"(rd85) : "l"(rd22), "l"(rd84));
  // PTX:672 st.global.u32 [%rd85], %r3
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (0))))) = (unsigned)(r3);
  // PTX:673 st.global.u32 [%rd85+4], %r5
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (4))))) = (unsigned)(r5);
  // PTX:674 st.global.u32 [%rd85+8], %r60
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (8))))) = (unsigned)(r60);
  // PTX:675 st.global.u32 [%rd85+12], %r61
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (12))))) = (unsigned)(r61);
  // PTX:676 mov.u32 %r58, 0
  asm("mov.u32 %0, 0;" : "=r"(r58) : );
  // PTX:677 st.global.u32 [%rd85+16], %r58
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (16))))) = (unsigned)(r58);
  // PTX:678 st.global.f32 [%rd85+20], %f425
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (20))))) = (float)(f425);
  // PTX:679 st.global.u32 [%rd85+24], %r72
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (24))))) = (unsigned)(r72);
  // PTX:680 neg.f32 %f464, %f91
  asm("neg.f32 %0, %1;" : "=f"(f464) : "f"(f91));
  // PTX:681 st.global.f32 [%rd85+28], %f464
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (28))))) = (float)(f464);
  // PTX:682 st.global.f32 [%rd85+32], %f463
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (32))))) = (float)(f463);
  // PTX:683 st.global.u32 [%rd85+36], %r58
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (36))))) = (unsigned)(r58);
  // PTX:684 st.global.f32 [%rd85+40], %f71
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (40))))) = (float)(f71);
  // PTX:685 st.global.f32 [%rd85+44], %f72
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (44))))) = (float)(f72);
  // PTX:686 st.global.f32 [%rd85+48], %f73
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (48))))) = (float)(f73);
  // PTX:687 st.global.f32 [%rd85+52], %f462
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (52))))) = (float)(f462);
  // PTX:688 mov.u32 %r59, 4
  asm("mov.u32 %0, 4;" : "=r"(r59) : );
  // PTX:689 st.global.u32 [%rd85+56], %r59
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (56))))) = (unsigned)(r59);
  // PTX:690 bra.uni $L__BB10_82
  goto L_BB10_82;
  // PTX:692 $L__BB10_81:
L_BB10_81:;
  // PTX:693 mov.b32 %f433, %r73
  asm("mov.b32 %0, %1;" : "=f"(f433) : "r"(r73));
  // PTX:694 neg.f32 %f464, %f91
  asm("neg.f32 %0, %1;" : "=f"(f464) : "f"(f91));
  // PTX:695 neg.f32 %f463, %f433
  asm("neg.f32 %0, %1;" : "=f"(f463) : "f"(f433));
  // PTX:697 $L__BB10_82:
L_BB10_82:;
  // PTX:698 mov.b32 %f432, %r73
  asm("mov.b32 %0, %1;" : "=f"(f432) : "r"(r73));
  // PTX:699 mov.b32 %f431, %r72
  asm("mov.b32 %0, %1;" : "=f"(f431) : "r"(r72));
  // PTX:700 mov.f32 %f430, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f430) : );
  // PTX:701 sub.f32 %f429, %f430, %f431
  asm("sub.f32 %0, %1, %2;" : "=f"(f429) : "f"(f430), "f"(f431));
  // PTX:702 mul.f32 %f424, %f71, %f317
  asm("mul.f32 %0, %1, %2;" : "=f"(f424) : "f"(f71), "f"(f317));
  // PTX:703 mul.f32 %f423, %f73, %f317
  asm("mul.f32 %0, %1, %2;" : "=f"(f423) : "f"(f73), "f"(f317));
  // PTX:704 mul.f32 %f422, %f72, %f317
  asm("mul.f32 %0, %1, %2;" : "=f"(f422) : "f"(f72), "f"(f317));
  // PTX:705 mov.b32 %f419, %r72
  asm("mov.b32 %0, %1;" : "=f"(f419) : "r"(r72));
  // PTX:706 fma.rn.f32 %f483, %f424, %f429, %f483
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f483) : "f"(f424), "f"(f429), "f"(f483));
  // PTX:707 fma.rn.f32 %f484, %f422, %f429, %f484
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f484) : "f"(f422), "f"(f429), "f"(f484));
  // PTX:708 fma.rn.f32 %f485, %f423, %f429, %f485
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f485) : "f"(f423), "f"(f429), "f"(f485));
  // PTX:709 mul.f32 %f337, %f429, %f429
  asm("mul.f32 %0, %1, %2;" : "=f"(f337) : "f"(f429), "f"(f429));
  // PTX:710 fma.rn.f32 %f465, %f84, %f337, %f465
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f465) : "f"(f84), "f"(f337), "f"(f465));
  // PTX:711 fma.rn.f32 %f466, %f337, %f85, %f466
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f466) : "f"(f337), "f"(f85), "f"(f466));
  // PTX:712 fma.rn.f32 %f467, %f337, %f86, %f467
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f467) : "f"(f337), "f"(f86), "f"(f467));
  // PTX:713 fma.rn.f32 %f468, %f337, %f85, %f468
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f468) : "f"(f337), "f"(f85), "f"(f468));
  // PTX:714 fma.rn.f32 %f469, %f337, %f87, %f469
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f469) : "f"(f337), "f"(f87), "f"(f469));
  // PTX:715 fma.rn.f32 %f470, %f337, %f88, %f470
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f470) : "f"(f337), "f"(f88), "f"(f470));
  // PTX:716 fma.rn.f32 %f471, %f337, %f86, %f471
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f471) : "f"(f337), "f"(f86), "f"(f471));
  // PTX:717 fma.rn.f32 %f472, %f337, %f88, %f472
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f472) : "f"(f337), "f"(f88), "f"(f472));
  // PTX:718 fma.rn.f32 %f473, %f337, %f89, %f473
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f473) : "f"(f337), "f"(f89), "f"(f473));
  // PTX:719 mul.lo.s64 %rd86, %rd24, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd86) : "l"(rd24));
  // PTX:720 add.s64 %rd87, %rd4, %rd86
  asm("add.s64 %0, %1, %2;" : "=l"(rd87) : "l"(rd4), "l"(rd86));
  // PTX:721 mul.f32 %f338, %f424, %f464
  asm("mul.f32 %0, %1, %2;" : "=f"(f338) : "f"(f424), "f"(f464));
  // PTX:722 red.global.add.f32 [%rd87], %f338
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (0)))), (float)(f338));
  // PTX:723 add.s64 %rd88, %rd87, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd88) : "l"(rd87));
  // PTX:724 mul.f32 %f340, %f422, %f464
  asm("mul.f32 %0, %1, %2;" : "=f"(f340) : "f"(f422), "f"(f464));
  // PTX:725 red.global.add.f32 [%rd88], %f340
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (0)))), (float)(f340));
  // PTX:726 add.s64 %rd89, %rd87, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd89) : "l"(rd87));
  // PTX:727 mul.f32 %f342, %f423, %f464
  asm("mul.f32 %0, %1, %2;" : "=f"(f342) : "f"(f423), "f"(f464));
  // PTX:728 red.global.add.f32 [%rd89], %f342
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (0)))), (float)(f342));
  // PTX:729 mul.f32 %f344, %f91, %f91
  asm("mul.f32 %0, %1, %2;" : "=f"(f344) : "f"(f91), "f"(f91));
  // PTX:730 mul.f32 %f345, %f84, %f344
  asm("mul.f32 %0, %1, %2;" : "=f"(f345) : "f"(f84), "f"(f344));
  // PTX:731 mul.f32 %f346, %f344, %f85
  asm("mul.f32 %0, %1, %2;" : "=f"(f346) : "f"(f344), "f"(f85));
  // PTX:732 mul.f32 %f347, %f344, %f86
  asm("mul.f32 %0, %1, %2;" : "=f"(f347) : "f"(f344), "f"(f86));
  // PTX:733 mul.f32 %f348, %f344, %f87
  asm("mul.f32 %0, %1, %2;" : "=f"(f348) : "f"(f344), "f"(f87));
  // PTX:734 mul.f32 %f349, %f344, %f88
  asm("mul.f32 %0, %1, %2;" : "=f"(f349) : "f"(f344), "f"(f88));
  // PTX:735 mul.f32 %f350, %f344, %f89
  asm("mul.f32 %0, %1, %2;" : "=f"(f350) : "f"(f344), "f"(f89));
  // PTX:736 mul.lo.s64 %rd90, %rd24, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd90) : "l"(rd24));
  // PTX:737 add.s64 %rd91, %rd1, %rd90
  asm("add.s64 %0, %1, %2;" : "=l"(rd91) : "l"(rd1), "l"(rd90));
  // PTX:738 red.global.add.f32 [%rd91], %f345
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (0)))), (float)(f345));
  // PTX:739 add.s64 %rd92, %rd91, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd92) : "l"(rd91));
  // PTX:740 red.global.add.f32 [%rd92], %f346
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (0)))), (float)(f346));
  // PTX:741 add.s64 %rd93, %rd91, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd93) : "l"(rd91));
  // PTX:742 red.global.add.f32 [%rd93], %f347
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (0)))), (float)(f347));
  // PTX:743 add.s64 %rd94, %rd91, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd94) : "l"(rd91));
  // PTX:744 red.global.add.f32 [%rd94], %f346
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd94) + (0)))), (float)(f346));
  // PTX:745 add.s64 %rd95, %rd91, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd95) : "l"(rd91));
  // PTX:746 red.global.add.f32 [%rd95], %f348
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd95) + (0)))), (float)(f348));
  // PTX:747 add.s64 %rd96, %rd91, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd96) : "l"(rd91));
  // PTX:748 red.global.add.f32 [%rd96], %f349
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (0)))), (float)(f349));
  // PTX:749 add.s64 %rd97, %rd91, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd97) : "l"(rd91));
  // PTX:750 red.global.add.f32 [%rd97], %f347
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd97) + (0)))), (float)(f347));
  // PTX:751 add.s64 %rd98, %rd91, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd98) : "l"(rd91));
  // PTX:752 red.global.add.f32 [%rd98], %f349
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (0)))), (float)(f349));
  // PTX:753 add.s64 %rd99, %rd91, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd99) : "l"(rd91));
  // PTX:754 red.global.add.f32 [%rd99], %f350
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (0)))), (float)(f350));
  // PTX:755 fma.rn.f32 %f486, %f424, %f419, %f486
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f486) : "f"(f424), "f"(f419), "f"(f486));
  // PTX:756 fma.rn.f32 %f487, %f422, %f419, %f487
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f487) : "f"(f422), "f"(f419), "f"(f487));
  // PTX:757 fma.rn.f32 %f488, %f423, %f419, %f488
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f488) : "f"(f423), "f"(f419), "f"(f488));
  // PTX:758 mul.f32 %f360, %f419, %f419
  asm("mul.f32 %0, %1, %2;" : "=f"(f360) : "f"(f419), "f"(f419));
  // PTX:759 fma.rn.f32 %f474, %f84, %f360, %f474
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f474) : "f"(f84), "f"(f360), "f"(f474));
  // PTX:760 fma.rn.f32 %f475, %f360, %f85, %f475
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f475) : "f"(f360), "f"(f85), "f"(f475));
  // PTX:761 fma.rn.f32 %f476, %f360, %f86, %f476
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f476) : "f"(f360), "f"(f86), "f"(f476));
  // PTX:762 fma.rn.f32 %f477, %f360, %f85, %f477
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f477) : "f"(f360), "f"(f85), "f"(f477));
  // PTX:763 fma.rn.f32 %f478, %f360, %f87, %f478
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f478) : "f"(f360), "f"(f87), "f"(f478));
  // PTX:764 fma.rn.f32 %f479, %f360, %f88, %f479
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f479) : "f"(f360), "f"(f88), "f"(f479));
  // PTX:765 fma.rn.f32 %f480, %f360, %f86, %f480
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f480) : "f"(f360), "f"(f86), "f"(f480));
  // PTX:766 fma.rn.f32 %f481, %f360, %f88, %f481
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f481) : "f"(f360), "f"(f88), "f"(f481));
  // PTX:767 fma.rn.f32 %f482, %f360, %f89, %f482
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f482) : "f"(f360), "f"(f89), "f"(f482));
  // PTX:768 mul.lo.s64 %rd100, %rd25, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd100) : "l"(rd25));
  // PTX:769 add.s64 %rd101, %rd4, %rd100
  asm("add.s64 %0, %1, %2;" : "=l"(rd101) : "l"(rd4), "l"(rd100));
  // PTX:770 mul.f32 %f361, %f424, %f463
  asm("mul.f32 %0, %1, %2;" : "=f"(f361) : "f"(f424), "f"(f463));
  // PTX:771 red.global.add.f32 [%rd101], %f361
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd101) + (0)))), (float)(f361));
  // PTX:772 add.s64 %rd102, %rd101, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd102) : "l"(rd101));
  // PTX:773 mul.f32 %f363, %f422, %f463
  asm("mul.f32 %0, %1, %2;" : "=f"(f363) : "f"(f422), "f"(f463));
  // PTX:774 red.global.add.f32 [%rd102], %f363
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd102) + (0)))), (float)(f363));
  // PTX:775 add.s64 %rd103, %rd101, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd103) : "l"(rd101));
  // PTX:776 mul.f32 %f365, %f423, %f463
  asm("mul.f32 %0, %1, %2;" : "=f"(f365) : "f"(f423), "f"(f463));
  // PTX:777 red.global.add.f32 [%rd103], %f365
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd103) + (0)))), (float)(f365));
  // PTX:778 mul.f32 %f367, %f432, %f432
  asm("mul.f32 %0, %1, %2;" : "=f"(f367) : "f"(f432), "f"(f432));
  // PTX:779 mul.f32 %f368, %f84, %f367
  asm("mul.f32 %0, %1, %2;" : "=f"(f368) : "f"(f84), "f"(f367));
  // PTX:780 mul.f32 %f369, %f367, %f85
  asm("mul.f32 %0, %1, %2;" : "=f"(f369) : "f"(f367), "f"(f85));
  // PTX:781 mul.f32 %f370, %f367, %f86
  asm("mul.f32 %0, %1, %2;" : "=f"(f370) : "f"(f367), "f"(f86));
  // PTX:782 mul.f32 %f371, %f367, %f87
  asm("mul.f32 %0, %1, %2;" : "=f"(f371) : "f"(f367), "f"(f87));
  // PTX:783 mul.f32 %f372, %f367, %f88
  asm("mul.f32 %0, %1, %2;" : "=f"(f372) : "f"(f367), "f"(f88));
  // PTX:784 mul.f32 %f373, %f367, %f89
  asm("mul.f32 %0, %1, %2;" : "=f"(f373) : "f"(f367), "f"(f89));
  // PTX:785 mul.lo.s64 %rd104, %rd25, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd104) : "l"(rd25));
  // PTX:786 add.s64 %rd105, %rd1, %rd104
  asm("add.s64 %0, %1, %2;" : "=l"(rd105) : "l"(rd1), "l"(rd104));
  // PTX:787 red.global.add.f32 [%rd105], %f368
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (0)))), (float)(f368));
  // PTX:788 add.s64 %rd106, %rd105, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd106) : "l"(rd105));
  // PTX:789 red.global.add.f32 [%rd106], %f369
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (0)))), (float)(f369));
  // PTX:790 add.s64 %rd107, %rd105, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd107) : "l"(rd105));
  // PTX:791 red.global.add.f32 [%rd107], %f370
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd107) + (0)))), (float)(f370));
  // PTX:792 add.s64 %rd108, %rd105, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd108) : "l"(rd105));
  // PTX:793 red.global.add.f32 [%rd108], %f369
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd108) + (0)))), (float)(f369));
  // PTX:794 add.s64 %rd109, %rd105, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd109) : "l"(rd105));
  // PTX:795 red.global.add.f32 [%rd109], %f371
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd109) + (0)))), (float)(f371));
  // PTX:796 add.s64 %rd110, %rd105, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd110) : "l"(rd105));
  // PTX:797 red.global.add.f32 [%rd110], %f372
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd110) + (0)))), (float)(f372));
  // PTX:798 add.s64 %rd111, %rd105, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd111) : "l"(rd105));
  // PTX:799 red.global.add.f32 [%rd111], %f370
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd111) + (0)))), (float)(f370));
  // PTX:800 add.s64 %rd112, %rd105, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd112) : "l"(rd105));
  // PTX:801 red.global.add.f32 [%rd112], %f372
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd112) + (0)))), (float)(f372));
  // PTX:802 add.s64 %rd113, %rd105, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd113) : "l"(rd105));
  // PTX:803 red.global.add.f32 [%rd113], %f373
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd113) + (0)))), (float)(f373));
  // PTX:804 ld.global.u32 %r78, [%rd17]
  r78 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:806 $L__BB10_83:
L_BB10_83:;
  // PTX:807 add.s32 %r71, %r71, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r71) : "r"(r71));
  // PTX:808 setp.lt.s32 %p86, %r71, %r78
  p86 = (((int)(r71)) < ((int)(r78)));
  // PTX:809 @%p86 bra $L__BB10_14
  if (p86) { goto L_BB10_14; }
  // PTX:811 $L__BB10_84:
L_BB10_84:;
  // PTX:812 ld.param.u64 %rd148, [_ZN7synreal21self_collision_kernel20accumulate_edge_edgeEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_SB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_15]
  rd148 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param15 + (0))));
  // PTX:813 mul.lo.s64 %rd147, %rd155, %rd148
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd147) : "l"(rd155), "l"(rd148));
  // PTX:814 cvt.u32.u64 %r65, %rd147
  asm("cvt.u32.u64 %0, %1;" : "=r"(r65) : "l"(rd147));
  // PTX:815 add.s32 %r64, %r4, %r65
  asm("add.s32 %0, %1, %2;" : "=r"(r64) : "r"(r4), "r"(r65));
  // PTX:816 cvt.s64.s32 %rd146, %r64
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd146) : "r"(r64));
  // PTX:817 add.s32 %r63, %r2, %r65
  asm("add.s32 %0, %1, %2;" : "=r"(r63) : "r"(r2), "r"(r65));
  // PTX:818 cvt.s64.s32 %rd145, %r63
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd145) : "r"(r63));
  // PTX:819 mul.lo.s64 %rd114, %rd145, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd114) : "l"(rd145));
  // PTX:820 add.s64 %rd115, %rd4, %rd114
  asm("add.s64 %0, %1, %2;" : "=l"(rd115) : "l"(rd4), "l"(rd114));
  // PTX:821 red.global.add.f32 [%rd115], %f483
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd115) + (0)))), (float)(f483));
  // PTX:822 add.s64 %rd116, %rd115, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd116) : "l"(rd115));
  // PTX:823 red.global.add.f32 [%rd116], %f484
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd116) + (0)))), (float)(f484));
  // PTX:824 add.s64 %rd117, %rd115, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd117) : "l"(rd115));
  // PTX:825 red.global.add.f32 [%rd117], %f485
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd117) + (0)))), (float)(f485));
  // PTX:826 mul.lo.s64 %rd118, %rd145, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd118) : "l"(rd145));
  // PTX:827 add.s64 %rd119, %rd1, %rd118
  asm("add.s64 %0, %1, %2;" : "=l"(rd119) : "l"(rd1), "l"(rd118));
  // PTX:828 red.global.add.f32 [%rd119], %f465
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd119) + (0)))), (float)(f465));
  // PTX:829 add.s64 %rd120, %rd119, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd120) : "l"(rd119));
  // PTX:830 red.global.add.f32 [%rd120], %f466
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd120) + (0)))), (float)(f466));
  // PTX:831 add.s64 %rd121, %rd119, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd121) : "l"(rd119));
  // PTX:832 red.global.add.f32 [%rd121], %f467
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd121) + (0)))), (float)(f467));
  // PTX:833 add.s64 %rd122, %rd119, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd122) : "l"(rd119));
  // PTX:834 red.global.add.f32 [%rd122], %f468
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd122) + (0)))), (float)(f468));
  // PTX:835 add.s64 %rd123, %rd119, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd123) : "l"(rd119));
  // PTX:836 red.global.add.f32 [%rd123], %f469
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd123) + (0)))), (float)(f469));
  // PTX:837 add.s64 %rd124, %rd119, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd124) : "l"(rd119));
  // PTX:838 red.global.add.f32 [%rd124], %f470
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd124) + (0)))), (float)(f470));
  // PTX:839 add.s64 %rd125, %rd119, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd125) : "l"(rd119));
  // PTX:840 red.global.add.f32 [%rd125], %f471
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd125) + (0)))), (float)(f471));
  // PTX:841 add.s64 %rd126, %rd119, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd126) : "l"(rd119));
  // PTX:842 red.global.add.f32 [%rd126], %f472
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd126) + (0)))), (float)(f472));
  // PTX:843 add.s64 %rd127, %rd119, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd127) : "l"(rd119));
  // PTX:844 red.global.add.f32 [%rd127], %f473
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd127) + (0)))), (float)(f473));
  // PTX:845 mul.lo.s64 %rd128, %rd146, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd128) : "l"(rd146));
  // PTX:846 add.s64 %rd129, %rd4, %rd128
  asm("add.s64 %0, %1, %2;" : "=l"(rd129) : "l"(rd4), "l"(rd128));
  // PTX:847 red.global.add.f32 [%rd129], %f486
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd129) + (0)))), (float)(f486));
  // PTX:848 add.s64 %rd130, %rd129, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd130) : "l"(rd129));
  // PTX:849 red.global.add.f32 [%rd130], %f487
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd130) + (0)))), (float)(f487));
  // PTX:850 add.s64 %rd131, %rd129, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd131) : "l"(rd129));
  // PTX:851 red.global.add.f32 [%rd131], %f488
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd131) + (0)))), (float)(f488));
  // PTX:852 mul.lo.s64 %rd132, %rd146, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd132) : "l"(rd146));
  // PTX:853 add.s64 %rd133, %rd1, %rd132
  asm("add.s64 %0, %1, %2;" : "=l"(rd133) : "l"(rd1), "l"(rd132));
  // PTX:854 red.global.add.f32 [%rd133], %f474
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd133) + (0)))), (float)(f474));
  // PTX:855 add.s64 %rd134, %rd133, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd134) : "l"(rd133));
  // PTX:856 red.global.add.f32 [%rd134], %f475
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd134) + (0)))), (float)(f475));
  // PTX:857 add.s64 %rd135, %rd133, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd135) : "l"(rd133));
  // PTX:858 red.global.add.f32 [%rd135], %f476
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd135) + (0)))), (float)(f476));
  // PTX:859 add.s64 %rd136, %rd133, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd136) : "l"(rd133));
  // PTX:860 red.global.add.f32 [%rd136], %f477
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd136) + (0)))), (float)(f477));
  // PTX:861 add.s64 %rd137, %rd133, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd137) : "l"(rd133));
  // PTX:862 red.global.add.f32 [%rd137], %f478
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd137) + (0)))), (float)(f478));
  // PTX:863 add.s64 %rd138, %rd133, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd138) : "l"(rd133));
  // PTX:864 red.global.add.f32 [%rd138], %f479
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd138) + (0)))), (float)(f479));
  // PTX:865 add.s64 %rd139, %rd133, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd139) : "l"(rd133));
  // PTX:866 red.global.add.f32 [%rd139], %f480
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd139) + (0)))), (float)(f480));
  // PTX:867 add.s64 %rd140, %rd133, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd140) : "l"(rd133));
  // PTX:868 red.global.add.f32 [%rd140], %f481
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd140) + (0)))), (float)(f481));
  // PTX:869 add.s64 %rd141, %rd133, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd141) : "l"(rd133));
  // PTX:870 red.global.add.f32 [%rd141], %f482
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd141) + (0)))), (float)(f482));
  // PTX:872 $L__BB10_85:
L_BB10_85:;
  // PTX:873 ret
  return;
}
