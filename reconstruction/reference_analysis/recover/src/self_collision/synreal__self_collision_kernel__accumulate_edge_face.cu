// 机械还原自 PTX：synreal::self_collision_kernel::accumulate_edge_face(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, int const*, int const*, glm::vec<3, int, (glm::qualifier)0> const*, int const*, int const*, float const*, float, float, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, synreal::SelfCollisionContactTangent*, unsigned int*, unsigned long, unsigned long, unsigned long, int)
// PTX SHA256: d1e3afa74b39f4195ad66aeb18bb6311405e07a01c2789675f26baf9873b9415
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__self_collision_kernel__accumulate_edge_face(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, float param8, float param9, unsigned long long param10, unsigned long long param11, unsigned long long param12, unsigned long long param13, unsigned long long param14, unsigned long long param15, unsigned long long param16, unsigned param17) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57, p58, p59, p60, p61, p62, p63, p64, p65, p66, p67, p68, p69, p70, p71, p72, p73, p74, p75, p76, p77, p78, p79, p80, p81, p82, p83, p84, p85, p86, p87, p88, p89, p90, p91, p92, p93, p94, p95, p96, p97, p98, p99, p100, p101, p102, p103;
  unsigned short rs0, rs1, rs2, rs3, rs4, rs5, rs6, rs7, rs8, rs9, rs10, rs11, rs12, rs13, rs14, rs15, rs16, rs17, rs18, rs19, rs20, rs21, rs22, rs23, rs24, rs25, rs26, rs27, rs28, rs29, rs30, rs31, rs32, rs33, rs34, rs35, rs36, rs37, rs38, rs39, rs40, rs41, rs42, rs43, rs44, rs45, rs46, rs47, rs48;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440, f441, f442, f443, f444, f445, f446, f447, f448, f449, f450, f451, f452, f453, f454, f455, f456, f457, f458, f459, f460, f461, f462, f463, f464, f465, f466, f467, f468, f469, f470, f471, f472, f473, f474, f475, f476, f477, f478, f479, f480, f481, f482, f483, f484, f485, f486, f487, f488, f489, f490, f491, f492, f493, f494, f495, f496, f497, f498, f499, f500, f501, f502, f503, f504, f505, f506, f507, f508, f509, f510, f511, f512, f513, f514, f515, f516, f517, f518, f519, f520, f521, f522, f523, f524, f525, f526, f527, f528, f529, f530, f531, f532, f533, f534, f535, f536, f537, f538, f539, f540, f541, f542, f543, f544, f545, f546, f547, f548, f549, f550, f551, f552, f553, f554, f555, f556, f557, f558, f559, f560, f561, f562, f563, f564, f565, f566, f567, f568, f569, f570, f571, f572, f573, f574, f575, f576, f577, f578, f579, f580, f581, f582, f583, f584, f585, f586, f587, f588, f589, f590, f591, f592, f593, f594, f595, f596, f597, f598, f599, f600, f601, f602, f603, f604, f605, f606, f607, f608, f609, f610, f611, f612, f613, f614, f615, f616, f617, f618, f619, f620, f621, f622, f623, f624, f625, f626, f627, f628, f629, f630, f631, f632, f633, f634, f635, f636, f637, f638, f639, f640, f641, f642, f643, f644, f645, f646, f647, f648, f649, f650, f651, f652, f653, f654, f655, f656, f657, f658, f659, f660, f661, f662, f663, f664, f665, f666, f667, f668, f669, f670, f671, f672, f673, f674, f675, f676, f677, f678, f679, f680, f681, f682, f683, f684, f685, f686, f687;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135, rd136, rd137, rd138, rd139, rd140, rd141, rd142, rd143, rd144, rd145, rd146, rd147, rd148, rd149, rd150, rd151, rd152, rd153, rd154, rd155, rd156, rd157, rd158, rd159, rd160, rd161, rd162;
  // PTX:35 ld.param.u64 %rd35, [_ZN7synreal21self_collision_kernel20accumulate_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_PKNS2_ILi3EiLS3_0EEESB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_0]
  rd35 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:36 ld.param.u64 %rd25, [_ZN7synreal21self_collision_kernel20accumulate_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_PKNS2_ILi3EiLS3_0EEESB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_1]
  rd25 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:37 ld.param.u64 %rd26, [_ZN7synreal21self_collision_kernel20accumulate_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_PKNS2_ILi3EiLS3_0EEESB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_2]
  rd26 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:38 ld.param.u64 %rd27, [_ZN7synreal21self_collision_kernel20accumulate_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_PKNS2_ILi3EiLS3_0EEESB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_3]
  rd27 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:39 ld.param.u64 %rd28, [_ZN7synreal21self_collision_kernel20accumulate_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_PKNS2_ILi3EiLS3_0EEESB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_4]
  rd28 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:40 ld.param.u64 %rd29, [_ZN7synreal21self_collision_kernel20accumulate_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_PKNS2_ILi3EiLS3_0EEESB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_5]
  rd29 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:41 ld.param.u64 %rd30, [_ZN7synreal21self_collision_kernel20accumulate_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_PKNS2_ILi3EiLS3_0EEESB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_6]
  rd30 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:42 ld.param.u64 %rd36, [_ZN7synreal21self_collision_kernel20accumulate_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_PKNS2_ILi3EiLS3_0EEESB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_7]
  rd36 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:43 ld.param.f32 %f220, [_ZN7synreal21self_collision_kernel20accumulate_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_PKNS2_ILi3EiLS3_0EEESB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_8]
  f220 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param8 + (0))));
  // PTX:44 ld.param.f32 %f221, [_ZN7synreal21self_collision_kernel20accumulate_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_PKNS2_ILi3EiLS3_0EEESB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_9]
  f221 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param9 + (0))));
  // PTX:45 ld.param.u64 %rd37, [_ZN7synreal21self_collision_kernel20accumulate_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_PKNS2_ILi3EiLS3_0EEESB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_10]
  rd37 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:46 ld.param.u64 %rd38, [_ZN7synreal21self_collision_kernel20accumulate_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_PKNS2_ILi3EiLS3_0EEESB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_11]
  rd38 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:47 ld.param.u64 %rd31, [_ZN7synreal21self_collision_kernel20accumulate_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_PKNS2_ILi3EiLS3_0EEESB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_12]
  rd31 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:48 ld.param.u64 %rd32, [_ZN7synreal21self_collision_kernel20accumulate_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_PKNS2_ILi3EiLS3_0EEESB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_13]
  rd32 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:49 ld.param.u64 %rd39, [_ZN7synreal21self_collision_kernel20accumulate_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_PKNS2_ILi3EiLS3_0EEESB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_14]
  rd39 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:50 ld.param.u64 %rd33, [_ZN7synreal21self_collision_kernel20accumulate_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_PKNS2_ILi3EiLS3_0EEESB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_15]
  rd33 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param15 + (0))));
  // PTX:51 ld.param.u64 %rd34, [_ZN7synreal21self_collision_kernel20accumulate_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_PKNS2_ILi3EiLS3_0EEESB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_16]
  rd34 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param16 + (0))));
  // PTX:52 ld.param.u32 %r63, [_ZN7synreal21self_collision_kernel20accumulate_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_PKNS2_ILi3EiLS3_0EEESB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_17]
  r63 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param17 + (0))));
  // PTX:53 cvta.to.global.u64 %rd1, %rd38
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd38));
  // PTX:54 cvta.to.global.u64 %rd2, %rd37
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd37));
  // PTX:55 cvta.to.global.u64 %rd3, %rd36
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd36));
  // PTX:56 cvta.to.global.u64 %rd4, %rd35
  rd4 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd35));
  // PTX:57 mov.u32 %r64, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r64) : "r"(blockIdx.x));
  // PTX:58 mov.u32 %r65, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r65) : "r"(blockDim.x));
  // PTX:59 mul.wide.u32 %rd40, %r64, %r65
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd40) : "r"(r64), "r"(r65));
  // PTX:60 mov.u32 %r66, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r66) : "r"(threadIdx.x));
  // PTX:61 cvt.u64.u32 %rd41, %r66
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd41) : "r"(r66));
  // PTX:62 add.s64 %rd5, %rd40, %rd41
  asm("add.s64 %0, %1, %2;" : "=l"(rd5) : "l"(rd40), "l"(rd41));
  // PTX:63 setp.ge.u64 %p3, %rd5, %rd39
  p3 = (((unsigned long long)(rd5)) >= ((unsigned long long)(rd39)));
  // PTX:64 @%p3 bra $L__BB11_85
  if (p3) { goto L_BB11_85; }
  // PTX:66 or.b64 %rd42, %rd5, %rd33
  asm("or.b64 %0, %1, %2;" : "=l"(rd42) : "l"(rd5), "l"(rd33));
  // PTX:67 and.b64 %rd43, %rd42, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd43) : "l"(rd42));
  // PTX:68 setp.eq.s64 %p4, %rd43, 0
  p4 = (((long long)(rd43)) == ((long long)(0)));
  // PTX:69 @%p4 bra $L__BB11_3
  if (p4) { goto L_BB11_3; }
  // PTX:71 div.u64 %rd161, %rd5, %rd33
  asm("div.u64 %0, %1, %2;" : "=l"(rd161) : "l"(rd5), "l"(rd33));
  // PTX:72 mul.lo.s64 %rd44, %rd161, %rd33
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd44) : "l"(rd161), "l"(rd33));
  // PTX:73 sub.s64 %rd162, %rd5, %rd44
  asm("sub.s64 %0, %1, %2;" : "=l"(rd162) : "l"(rd5), "l"(rd44));
  // PTX:74 bra.uni $L__BB11_4
  goto L_BB11_4;
  // PTX:76 $L__BB11_3:
L_BB11_3:;
  // PTX:77 cvt.u32.u64 %r67, %rd33
  asm("cvt.u32.u64 %0, %1;" : "=r"(r67) : "l"(rd33));
  // PTX:78 cvt.u32.u64 %r68, %rd5
  asm("cvt.u32.u64 %0, %1;" : "=r"(r68) : "l"(rd5));
  // PTX:79 div.u32 %r69, %r68, %r67
  asm("div.u32 %0, %1, %2;" : "=r"(r69) : "r"(r68), "r"(r67));
  // PTX:80 mul.lo.s32 %r70, %r69, %r67
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r70) : "r"(r69), "r"(r67));
  // PTX:81 sub.s32 %r71, %r68, %r70
  asm("sub.s32 %0, %1, %2;" : "=r"(r71) : "r"(r68), "r"(r70));
  // PTX:82 cvt.u64.u32 %rd161, %r69
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd161) : "r"(r69));
  // PTX:83 cvt.u64.u32 %rd162, %r71
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd162) : "r"(r71));
  // PTX:85 $L__BB11_4:
L_BB11_4:;
  // PTX:86 mul.lo.s64 %rd45, %rd161, %rd34
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd161), "l"(rd34));
  // PTX:87 cvt.u32.u64 %r1, %rd45
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd45));
  // PTX:88 cvta.to.global.u64 %rd46, %rd25
  rd46 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd25));
  // PTX:89 shl.b64 %rd47, %rd162, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd47) : "l"(rd162));
  // PTX:90 add.s64 %rd48, %rd46, %rd47
  asm("add.s64 %0, %1, %2;" : "=l"(rd48) : "l"(rd46), "l"(rd47));
  // PTX:91 ld.global.u32 %r2, [%rd48+8]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (8)))));
  // PTX:92 add.s32 %r3, %r2, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r3) : "r"(r2), "r"(r1));
  // PTX:93 ld.global.u32 %r4, [%rd48+12]
  r4 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (12)))));
  // PTX:94 add.s32 %r5, %r4, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r5) : "r"(r4), "r"(r1));
  // PTX:95 cvt.s64.s32 %rd12, %r3
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd12) : "r"(r3));
  // PTX:96 mul.wide.s32 %rd49, %r3, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd49) : "r"(r3));
  // PTX:97 add.s64 %rd50, %rd4, %rd49
  asm("add.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd4), "l"(rd49));
  // PTX:98 cvt.s64.s32 %rd13, %r5
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd13) : "r"(r5));
  // PTX:99 mul.wide.s32 %rd51, %r5, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd51) : "r"(r5));
  // PTX:100 add.s64 %rd52, %rd4, %rd51
  asm("add.s64 %0, %1, %2;" : "=l"(rd52) : "l"(rd4), "l"(rd51));
  // PTX:101 ld.global.f32 %f1, [%rd52]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))));
  // PTX:102 ld.global.f32 %f2, [%rd50]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (0)))));
  // PTX:103 sub.f32 %f3, %f2, %f1
  asm("sub.f32 %0, %1, %2;" : "=f"(f3) : "f"(f2), "f"(f1));
  // PTX:104 ld.global.f32 %f4, [%rd52+4]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (4)))));
  // PTX:105 ld.global.f32 %f5, [%rd50+4]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (4)))));
  // PTX:106 sub.f32 %f6, %f5, %f4
  asm("sub.f32 %0, %1, %2;" : "=f"(f6) : "f"(f5), "f"(f4));
  // PTX:107 ld.global.f32 %f7, [%rd52+8]
  f7 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (8)))));
  // PTX:108 ld.global.f32 %f8, [%rd50+8]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (8)))));
  // PTX:109 sub.f32 %f9, %f8, %f7
  asm("sub.f32 %0, %1, %2;" : "=f"(f9) : "f"(f8), "f"(f7));
  // PTX:110 mul.f32 %f222, %f6, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f222) : "f"(f6), "f"(f6));
  // PTX:111 fma.rn.f32 %f223, %f3, %f3, %f222
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f223) : "f"(f3), "f"(f3), "f"(f222));
  // PTX:112 fma.rn.f32 %f224, %f9, %f9, %f223
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f224) : "f"(f9), "f"(f9), "f"(f223));
  // PTX:113 sqrt.rn.f32 %f10, %f224
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f10) : "f"(f224));
  // PTX:114 abs.f32 %f225, %f2
  asm("abs.f32 %0, %1;" : "=f"(f225) : "f"(f2));
  // PTX:115 setp.geu.f32 %p6, %f225, 0f7F800000
  p6 = ((isnan(((float)(f225))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f225)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:116 mov.pred %p103, -1
  p103 = ((-1) != 0);
  // PTX:117 @%p6 bra $L__BB11_11
  if (p6) { goto L_BB11_11; }
  // PTX:119 abs.f32 %f226, %f5
  asm("abs.f32 %0, %1;" : "=f"(f226) : "f"(f5));
  // PTX:120 setp.geu.f32 %p8, %f226, 0f7F800000
  p8 = ((isnan(((float)(f226))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f226)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:121 @%p8 bra $L__BB11_11
  if (p8) { goto L_BB11_11; }
  // PTX:123 abs.f32 %f227, %f8
  asm("abs.f32 %0, %1;" : "=f"(f227) : "f"(f8));
  // PTX:124 setp.geu.f32 %p10, %f227, 0f7F800000
  p10 = ((isnan(((float)(f227))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f227)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:125 @%p10 bra $L__BB11_11
  if (p10) { goto L_BB11_11; }
  // PTX:127 abs.f32 %f228, %f1
  asm("abs.f32 %0, %1;" : "=f"(f228) : "f"(f1));
  // PTX:128 setp.geu.f32 %p12, %f228, 0f7F800000
  p12 = ((isnan(((float)(f228))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f228)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:129 @%p12 bra $L__BB11_11
  if (p12) { goto L_BB11_11; }
  // PTX:131 abs.f32 %f229, %f4
  asm("abs.f32 %0, %1;" : "=f"(f229) : "f"(f4));
  // PTX:132 setp.geu.f32 %p14, %f229, 0f7F800000
  p14 = ((isnan(((float)(f229))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f229)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:133 @%p14 bra $L__BB11_11
  if (p14) { goto L_BB11_11; }
  // PTX:135 abs.f32 %f230, %f7
  asm("abs.f32 %0, %1;" : "=f"(f230) : "f"(f7));
  // PTX:136 setp.geu.f32 %p16, %f230, 0f7F800000
  p16 = ((isnan(((float)(f230))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f230)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:137 @%p16 bra $L__BB11_11
  if (p16) { goto L_BB11_11; }
  // PTX:139 abs.f32 %f231, %f10
  asm("abs.f32 %0, %1;" : "=f"(f231) : "f"(f10));
  // PTX:140 setp.geu.f32 %p103, %f231, 0f7F800000
  p103 = ((isnan(((float)(f231))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f231)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:142 $L__BB11_11:
L_BB11_11:;
  // PTX:143 setp.lt.f32 %p17, %f10, 0f3A03126F
  p17 = (!(isnan(((float)(f10))) || isnan(((float)(as_f32(0x3A03126Fu))))) && (((float)(f10)) < ((float)(as_f32(0x3A03126Fu)))));
  // PTX:144 or.pred %p18, %p17, %p103
  p18 = ((p17) || (p103));
  // PTX:145 @%p18 bra $L__BB11_85
  if (p18) { goto L_BB11_85; }
  // PTX:147 setp.leu.f32 %p19, %f10, 0f00000000
  p19 = ((isnan(((float)(f10))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f10)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:148 mov.u32 %r92, 0
  asm("mov.u32 %0, 0;" : "=r"(r92) : );
  // PTX:149 mov.u32 %r93, %r92
  asm("mov.u32 %0, %1;" : "=r"(r93) : "r"(r92));
  // PTX:150 mov.u32 %r94, %r92
  asm("mov.u32 %0, %1;" : "=r"(r94) : "r"(r92));
  // PTX:151 @%p19 bra $L__BB11_14
  if (p19) { goto L_BB11_14; }
  // PTX:153 div.rn.f32 %f232, %f3, %f10
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f232) : "f"(f3), "f"(f10));
  // PTX:154 div.rn.f32 %f233, %f6, %f10
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f233) : "f"(f6), "f"(f10));
  // PTX:155 div.rn.f32 %f234, %f9, %f10
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f234) : "f"(f9), "f"(f10));
  // PTX:156 mov.b32 %r94, %f234
  asm("mov.b32 %0, %1;" : "=r"(r94) : "f"(f234));
  // PTX:157 mov.b32 %r93, %f233
  asm("mov.b32 %0, %1;" : "=r"(r93) : "f"(f233));
  // PTX:158 mov.b32 %r92, %f232
  asm("mov.b32 %0, %1;" : "=r"(r92) : "f"(f232));
  // PTX:160 $L__BB11_14:
L_BB11_14:;
  // PTX:161 shl.b64 %rd53, %rd13, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd53) : "l"(rd13));
  // PTX:162 add.s64 %rd54, %rd3, %rd53
  asm("add.s64 %0, %1, %2;" : "=l"(rd54) : "l"(rd3), "l"(rd53));
  // PTX:163 ld.global.f32 %f235, [%rd54]
  f235 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))));
  // PTX:164 shl.b64 %rd55, %rd12, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd55) : "l"(rd12));
  // PTX:165 add.s64 %rd56, %rd3, %rd55
  asm("add.s64 %0, %1, %2;" : "=l"(rd56) : "l"(rd3), "l"(rd55));
  // PTX:166 ld.global.f32 %f236, [%rd56]
  f236 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))));
  // PTX:167 add.f32 %f237, %f236, %f235
  asm("add.f32 %0, %1, %2;" : "=f"(f237) : "f"(f236), "f"(f235));
  // PTX:168 mul.f32 %f11, %f237, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f11) : "f"(f237));
  // PTX:169 abs.f32 %f238, %f11
  asm("abs.f32 %0, %1;" : "=f"(f238) : "f"(f11));
  // PTX:170 setp.geu.f32 %p20, %f238, 0f7F800000
  p20 = ((isnan(((float)(f238))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f238)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:171 @%p20 bra $L__BB11_85
  if (p20) { goto L_BB11_85; }
  // PTX:173 cvta.to.global.u64 %rd57, %rd29
  rd57 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd29));
  // PTX:174 shl.b64 %rd58, %rd5, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd58) : "l"(rd5));
  // PTX:175 add.s64 %rd14, %rd57, %rd58
  asm("add.s64 %0, %1, %2;" : "=l"(rd14) : "l"(rd57), "l"(rd58));
  // PTX:176 ld.global.u32 %r110, [%rd14]
  r110 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:177 setp.lt.s32 %p21, %r110, 1
  p21 = (((int)(r110)) < ((int)(1)));
  // PTX:178 mov.f32 %f637, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f637) : );
  // PTX:179 mov.f32 %f638, %f637
  asm("mov.f32 %0, %1;" : "=f"(f638) : "f"(f637));
  // PTX:180 mov.f32 %f639, %f637
  asm("mov.f32 %0, %1;" : "=f"(f639) : "f"(f637));
  // PTX:181 mov.f32 %f640, %f637
  asm("mov.f32 %0, %1;" : "=f"(f640) : "f"(f637));
  // PTX:182 mov.f32 %f641, %f637
  asm("mov.f32 %0, %1;" : "=f"(f641) : "f"(f637));
  // PTX:183 mov.f32 %f642, %f637
  asm("mov.f32 %0, %1;" : "=f"(f642) : "f"(f637));
  // PTX:184 mov.f32 %f643, %f637
  asm("mov.f32 %0, %1;" : "=f"(f643) : "f"(f637));
  // PTX:185 mov.f32 %f644, %f637
  asm("mov.f32 %0, %1;" : "=f"(f644) : "f"(f637));
  // PTX:186 mov.f32 %f645, %f637
  asm("mov.f32 %0, %1;" : "=f"(f645) : "f"(f637));
  // PTX:187 mov.f32 %f646, %f637
  asm("mov.f32 %0, %1;" : "=f"(f646) : "f"(f637));
  // PTX:188 mov.f32 %f647, %f637
  asm("mov.f32 %0, %1;" : "=f"(f647) : "f"(f637));
  // PTX:189 mov.f32 %f648, %f637
  asm("mov.f32 %0, %1;" : "=f"(f648) : "f"(f637));
  // PTX:190 mov.f32 %f649, %f637
  asm("mov.f32 %0, %1;" : "=f"(f649) : "f"(f637));
  // PTX:191 mov.f32 %f650, %f637
  asm("mov.f32 %0, %1;" : "=f"(f650) : "f"(f637));
  // PTX:192 mov.f32 %f651, %f637
  asm("mov.f32 %0, %1;" : "=f"(f651) : "f"(f637));
  // PTX:193 mov.f32 %f652, %f637
  asm("mov.f32 %0, %1;" : "=f"(f652) : "f"(f637));
  // PTX:194 mov.f32 %f653, %f637
  asm("mov.f32 %0, %1;" : "=f"(f653) : "f"(f637));
  // PTX:195 mov.f32 %f654, %f637
  asm("mov.f32 %0, %1;" : "=f"(f654) : "f"(f637));
  // PTX:196 mov.f32 %f655, %f637
  asm("mov.f32 %0, %1;" : "=f"(f655) : "f"(f637));
  // PTX:197 mov.f32 %f656, %f637
  asm("mov.f32 %0, %1;" : "=f"(f656) : "f"(f637));
  // PTX:198 mov.f32 %f657, %f637
  asm("mov.f32 %0, %1;" : "=f"(f657) : "f"(f637));
  // PTX:199 mov.f32 %f658, %f637
  asm("mov.f32 %0, %1;" : "=f"(f658) : "f"(f637));
  // PTX:200 mov.f32 %f659, %f637
  asm("mov.f32 %0, %1;" : "=f"(f659) : "f"(f637));
  // PTX:201 mov.f32 %f660, %f637
  asm("mov.f32 %0, %1;" : "=f"(f660) : "f"(f637));
  // PTX:202 @%p21 bra $L__BB11_84
  if (p21) { goto L_BB11_84; }
  // PTX:204 cvt.s64.s32 %rd59, %r63
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd59) : "r"(r63));
  // PTX:205 mul.lo.s64 %rd15, %rd5, %rd59
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd15) : "l"(rd5), "l"(rd59));
  // PTX:206 cvta.to.global.u64 %rd60, %rd26
  rd60 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd26));
  // PTX:207 shl.b64 %rd61, %rd162, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd61) : "l"(rd162));
  // PTX:208 add.s64 %rd16, %rd60, %rd61
  asm("add.s64 %0, %1, %2;" : "=l"(rd16) : "l"(rd60), "l"(rd61));
  // PTX:209 mov.b32 %f15, %r93
  asm("mov.b32 %0, %1;" : "=f"(f15) : "r"(r93));
  // PTX:210 mov.b32 %f16, %r94
  asm("mov.b32 %0, %1;" : "=f"(f16) : "r"(r94));
  // PTX:211 mov.b32 %f17, %r92
  asm("mov.b32 %0, %1;" : "=f"(f17) : "r"(r92));
  // PTX:212 mul.f32 %f18, %f11, %f221
  asm("mul.f32 %0, %1, %2;" : "=f"(f18) : "f"(f11), "f"(f221));
  // PTX:213 add.f32 %f19, %f220, %f220
  asm("add.f32 %0, %1, %2;" : "=f"(f19) : "f"(f220), "f"(f220));
  // PTX:214 cvta.to.global.u64 %rd17, %rd30
  rd17 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd30));
  // PTX:215 cvta.to.global.u64 %rd18, %rd28
  rd18 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd28));
  // PTX:216 cvta.to.global.u64 %rd19, %rd32
  rd19 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd32));
  // PTX:217 cvta.to.global.u64 %rd20, %rd31
  rd20 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd31));
  // PTX:218 cvta.to.global.u64 %rd21, %rd27
  rd21 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd27));
  // PTX:219 mov.u32 %r96, 0
  asm("mov.u32 %0, 0;" : "=r"(r96) : );
  // PTX:220 mov.f32 %f637, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f637) : );
  // PTX:222 $L__BB11_17:
L_BB11_17:;
  // PTX:223 cvt.s64.s32 %rd62, %r96
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd62) : "r"(r96));
  // PTX:224 add.s64 %rd63, %rd15, %rd62
  asm("add.s64 %0, %1, %2;" : "=l"(rd63) : "l"(rd15), "l"(rd62));
  // PTX:225 shl.b64 %rd64, %rd63, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd64) : "l"(rd63));
  // PTX:226 add.s64 %rd65, %rd17, %rd64
  asm("add.s64 %0, %1, %2;" : "=l"(rd65) : "l"(rd17), "l"(rd64));
  // PTX:227 ld.global.u32 %r76, [%rd65]
  r76 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (0)))));
  // PTX:228 mul.wide.s32 %rd66, %r76, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd66) : "r"(r76));
  // PTX:229 add.s64 %rd67, %rd18, %rd66
  asm("add.s64 %0, %1, %2;" : "=l"(rd67) : "l"(rd18), "l"(rd66));
  // PTX:230 ld.global.u32 %r15, [%rd67]
  r15 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0)))));
  // PTX:231 setp.eq.s32 %p22, %r15, %r2
  p22 = (((int)(r15)) == ((int)(r2)));
  // PTX:232 setp.eq.s32 %p23, %r15, %r4
  p23 = (((int)(r15)) == ((int)(r4)));
  // PTX:233 or.pred %p24, %p22, %p23
  p24 = ((p22) || (p23));
  // PTX:234 ld.global.u32 %r16, [%rd67+4]
  r16 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (4)))));
  // PTX:235 setp.eq.s32 %p25, %r16, %r2
  p25 = (((int)(r16)) == ((int)(r2)));
  // PTX:236 or.pred %p26, %p24, %p25
  p26 = ((p24) || (p25));
  // PTX:237 setp.eq.s32 %p27, %r16, %r4
  p27 = (((int)(r16)) == ((int)(r4)));
  // PTX:238 or.pred %p28, %p27, %p26
  p28 = ((p27) || (p26));
  // PTX:239 ld.global.u32 %r17, [%rd67+8]
  r17 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (8)))));
  // PTX:240 setp.eq.s32 %p29, %r17, %r2
  p29 = (((int)(r17)) == ((int)(r2)));
  // PTX:241 or.pred %p30, %p29, %p28
  p30 = ((p29) || (p28));
  // PTX:242 setp.eq.s32 %p31, %r17, %r4
  p31 = (((int)(r17)) == ((int)(r4)));
  // PTX:243 or.pred %p32, %p31, %p30
  p32 = ((p31) || (p30));
  // PTX:244 @%p32 bra $L__BB11_83
  if (p32) { goto L_BB11_83; }
  // PTX:246 add.s32 %r18, %r15, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r18) : "r"(r15), "r"(r1));
  // PTX:247 cvt.s64.s32 %rd22, %r18
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd22) : "r"(r18));
  // PTX:248 mul.wide.s32 %rd68, %r18, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd68) : "r"(r18));
  // PTX:249 add.s64 %rd69, %rd4, %rd68
  asm("add.s64 %0, %1, %2;" : "=l"(rd69) : "l"(rd4), "l"(rd68));
  // PTX:250 ld.global.u32 %r19, [%rd69+4]
  r19 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (4)))));
  // PTX:251 ld.global.u32 %r20, [%rd69+8]
  r20 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (8)))));
  // PTX:252 add.s32 %r21, %r16, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r21) : "r"(r16), "r"(r1));
  // PTX:253 cvt.s64.s32 %rd23, %r21
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd23) : "r"(r21));
  // PTX:254 mul.wide.s32 %rd70, %r21, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd70) : "r"(r21));
  // PTX:255 add.s64 %rd71, %rd4, %rd70
  asm("add.s64 %0, %1, %2;" : "=l"(rd71) : "l"(rd4), "l"(rd70));
  // PTX:256 ld.global.f32 %f47, [%rd71]
  f47 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))));
  // PTX:257 ld.global.u32 %r22, [%rd71+4]
  r22 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (4)))));
  // PTX:258 ld.global.u32 %r23, [%rd71+8]
  r23 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (8)))));
  // PTX:259 add.s32 %r24, %r17, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r24) : "r"(r17), "r"(r1));
  // PTX:260 cvt.s64.s32 %rd24, %r24
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd24) : "r"(r24));
  // PTX:261 mul.wide.s32 %rd72, %r24, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd72) : "r"(r24));
  // PTX:262 add.s64 %rd73, %rd4, %rd72
  asm("add.s64 %0, %1, %2;" : "=l"(rd73) : "l"(rd4), "l"(rd72));
  // PTX:263 ld.global.f32 %f48, [%rd73]
  f48 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (0)))));
  // PTX:264 ld.global.u32 %r25, [%rd73+4]
  r25 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (4)))));
  // PTX:265 ld.global.u32 %r26, [%rd73+8]
  r26 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (8)))));
  // PTX:266 ld.global.f32 %f49, [%rd69]
  f49 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (0)))));
  // PTX:267 abs.f32 %f288, %f49
  asm("abs.f32 %0, %1;" : "=f"(f288) : "f"(f49));
  // PTX:268 setp.geu.f32 %p33, %f288, 0f7F800000
  p33 = ((isnan(((float)(f288))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f288)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:269 mov.u16 %rs40, 0
  asm("mov.u16 %0, 0;" : "=h"(rs40) : );
  // PTX:270 @%p33 bra $L__BB11_21
  if (p33) { goto L_BB11_21; }
  // PTX:272 mov.b32 %f289, %r19
  asm("mov.b32 %0, %1;" : "=f"(f289) : "r"(r19));
  // PTX:273 abs.f32 %f290, %f289
  asm("abs.f32 %0, %1;" : "=f"(f290) : "f"(f289));
  // PTX:274 setp.geu.f32 %p34, %f290, 0f7F800000
  p34 = ((isnan(((float)(f290))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f290)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:275 @%p34 bra $L__BB11_21
  if (p34) { goto L_BB11_21; }
  // PTX:277 mov.b32 %f291, %r20
  asm("mov.b32 %0, %1;" : "=f"(f291) : "r"(r20));
  // PTX:278 abs.f32 %f292, %f291
  asm("abs.f32 %0, %1;" : "=f"(f292) : "f"(f291));
  // PTX:279 setp.lt.f32 %p35, %f292, 0f7F800000
  p35 = (!(isnan(((float)(f292))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f292)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:280 selp.u16 %rs40, 1, 0, %p35
  rs40 = p35 ? 1 : 0;
  // PTX:282 $L__BB11_21:
L_BB11_21:;
  // PTX:283 setp.eq.s16 %p36, %rs40, 0
  p36 = (((short)(rs40)) == ((short)(0)));
  // PTX:284 @%p36 bra $L__BB11_83
  if (p36) { goto L_BB11_83; }
  // PTX:286 abs.f32 %f293, %f47
  asm("abs.f32 %0, %1;" : "=f"(f293) : "f"(f47));
  // PTX:287 setp.geu.f32 %p37, %f293, 0f7F800000
  p37 = ((isnan(((float)(f293))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f293)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:288 mov.u16 %rs41, 0
  asm("mov.u16 %0, 0;" : "=h"(rs41) : );
  // PTX:289 @%p37 bra $L__BB11_25
  if (p37) { goto L_BB11_25; }
  // PTX:291 mov.b32 %f294, %r22
  asm("mov.b32 %0, %1;" : "=f"(f294) : "r"(r22));
  // PTX:292 abs.f32 %f295, %f294
  asm("abs.f32 %0, %1;" : "=f"(f295) : "f"(f294));
  // PTX:293 setp.geu.f32 %p38, %f295, 0f7F800000
  p38 = ((isnan(((float)(f295))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f295)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:294 @%p38 bra $L__BB11_25
  if (p38) { goto L_BB11_25; }
  // PTX:296 mov.b32 %f296, %r23
  asm("mov.b32 %0, %1;" : "=f"(f296) : "r"(r23));
  // PTX:297 abs.f32 %f297, %f296
  asm("abs.f32 %0, %1;" : "=f"(f297) : "f"(f296));
  // PTX:298 setp.lt.f32 %p39, %f297, 0f7F800000
  p39 = (!(isnan(((float)(f297))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f297)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:299 selp.u16 %rs41, 1, 0, %p39
  rs41 = p39 ? 1 : 0;
  // PTX:301 $L__BB11_25:
L_BB11_25:;
  // PTX:302 setp.eq.s16 %p40, %rs41, 0
  p40 = (((short)(rs41)) == ((short)(0)));
  // PTX:303 @%p40 bra $L__BB11_83
  if (p40) { goto L_BB11_83; }
  // PTX:305 abs.f32 %f298, %f48
  asm("abs.f32 %0, %1;" : "=f"(f298) : "f"(f48));
  // PTX:306 setp.geu.f32 %p41, %f298, 0f7F800000
  p41 = ((isnan(((float)(f298))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f298)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:307 mov.u16 %rs42, 0
  asm("mov.u16 %0, 0;" : "=h"(rs42) : );
  // PTX:308 @%p41 bra $L__BB11_29
  if (p41) { goto L_BB11_29; }
  // PTX:310 mov.b32 %f299, %r25
  asm("mov.b32 %0, %1;" : "=f"(f299) : "r"(r25));
  // PTX:311 abs.f32 %f300, %f299
  asm("abs.f32 %0, %1;" : "=f"(f300) : "f"(f299));
  // PTX:312 setp.geu.f32 %p42, %f300, 0f7F800000
  p42 = ((isnan(((float)(f300))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f300)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:313 @%p42 bra $L__BB11_29
  if (p42) { goto L_BB11_29; }
  // PTX:315 mov.b32 %f301, %r26
  asm("mov.b32 %0, %1;" : "=f"(f301) : "r"(r26));
  // PTX:316 abs.f32 %f302, %f301
  asm("abs.f32 %0, %1;" : "=f"(f302) : "f"(f301));
  // PTX:317 setp.lt.f32 %p43, %f302, 0f7F800000
  p43 = (!(isnan(((float)(f302))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f302)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:318 selp.u16 %rs42, 1, 0, %p43
  rs42 = p43 ? 1 : 0;
  // PTX:320 $L__BB11_29:
L_BB11_29:;
  // PTX:321 setp.eq.s16 %p44, %rs42, 0
  p44 = (((short)(rs42)) == ((short)(0)));
  // PTX:322 @%p44 bra $L__BB11_83
  if (p44) { goto L_BB11_83; }
  // PTX:324 sub.f32 %f303, %f47, %f49
  asm("sub.f32 %0, %1, %2;" : "=f"(f303) : "f"(f47), "f"(f49));
  // PTX:325 mov.b32 %f50, %r19
  asm("mov.b32 %0, %1;" : "=f"(f50) : "r"(r19));
  // PTX:326 mov.b32 %f51, %r22
  asm("mov.b32 %0, %1;" : "=f"(f51) : "r"(r22));
  // PTX:327 sub.f32 %f304, %f51, %f50
  asm("sub.f32 %0, %1, %2;" : "=f"(f304) : "f"(f51), "f"(f50));
  // PTX:328 mov.b32 %f52, %r20
  asm("mov.b32 %0, %1;" : "=f"(f52) : "r"(r20));
  // PTX:329 mov.b32 %f53, %r23
  asm("mov.b32 %0, %1;" : "=f"(f53) : "r"(r23));
  // PTX:330 sub.f32 %f305, %f53, %f52
  asm("sub.f32 %0, %1, %2;" : "=f"(f305) : "f"(f53), "f"(f52));
  // PTX:331 mov.b32 %f54, %r25
  asm("mov.b32 %0, %1;" : "=f"(f54) : "r"(r25));
  // PTX:332 sub.f32 %f306, %f54, %f51
  asm("sub.f32 %0, %1, %2;" : "=f"(f306) : "f"(f54), "f"(f51));
  // PTX:333 mov.b32 %f55, %r26
  asm("mov.b32 %0, %1;" : "=f"(f55) : "r"(r26));
  // PTX:334 sub.f32 %f307, %f55, %f53
  asm("sub.f32 %0, %1, %2;" : "=f"(f307) : "f"(f55), "f"(f53));
  // PTX:335 mul.f32 %f308, %f304, %f307
  asm("mul.f32 %0, %1, %2;" : "=f"(f308) : "f"(f304), "f"(f307));
  // PTX:336 mul.f32 %f309, %f305, %f306
  asm("mul.f32 %0, %1, %2;" : "=f"(f309) : "f"(f305), "f"(f306));
  // PTX:337 sub.f32 %f56, %f308, %f309
  asm("sub.f32 %0, %1, %2;" : "=f"(f56) : "f"(f308), "f"(f309));
  // PTX:338 sub.f32 %f310, %f48, %f47
  asm("sub.f32 %0, %1, %2;" : "=f"(f310) : "f"(f48), "f"(f47));
  // PTX:339 mul.f32 %f311, %f305, %f310
  asm("mul.f32 %0, %1, %2;" : "=f"(f311) : "f"(f305), "f"(f310));
  // PTX:340 mul.f32 %f312, %f303, %f307
  asm("mul.f32 %0, %1, %2;" : "=f"(f312) : "f"(f303), "f"(f307));
  // PTX:341 sub.f32 %f57, %f311, %f312
  asm("sub.f32 %0, %1, %2;" : "=f"(f57) : "f"(f311), "f"(f312));
  // PTX:342 mul.f32 %f313, %f303, %f306
  asm("mul.f32 %0, %1, %2;" : "=f"(f313) : "f"(f303), "f"(f306));
  // PTX:343 mul.f32 %f314, %f304, %f310
  asm("mul.f32 %0, %1, %2;" : "=f"(f314) : "f"(f304), "f"(f310));
  // PTX:344 sub.f32 %f58, %f313, %f314
  asm("sub.f32 %0, %1, %2;" : "=f"(f58) : "f"(f313), "f"(f314));
  // PTX:345 mul.f32 %f315, %f57, %f57
  asm("mul.f32 %0, %1, %2;" : "=f"(f315) : "f"(f57), "f"(f57));
  // PTX:346 fma.rn.f32 %f316, %f56, %f56, %f315
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f316) : "f"(f56), "f"(f56), "f"(f315));
  // PTX:347 fma.rn.f32 %f317, %f58, %f58, %f316
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f317) : "f"(f58), "f"(f58), "f"(f316));
  // PTX:348 sqrt.rn.f32 %f59, %f317
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f59) : "f"(f317));
  // PTX:349 abs.f32 %f318, %f59
  asm("abs.f32 %0, %1;" : "=f"(f318) : "f"(f59));
  // PTX:350 setp.geu.f32 %p45, %f318, 0f7F800000
  p45 = ((isnan(((float)(f318))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f318)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:351 setp.lt.f32 %p46, %f59, 0f322BCC77
  p46 = (!(isnan(((float)(f59))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f59)) < ((float)(as_f32(0x322BCC77u)))));
  // PTX:352 or.pred %p47, %p46, %p45
  p47 = ((p46) || (p45));
  // PTX:353 @%p47 bra $L__BB11_83
  if (p47) { goto L_BB11_83; }
  // PTX:355 div.rn.f32 %f60, %f56, %f59
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f60) : "f"(f56), "f"(f59));
  // PTX:356 sub.f32 %f319, %f2, %f49
  asm("sub.f32 %0, %1, %2;" : "=f"(f319) : "f"(f2), "f"(f49));
  // PTX:357 sub.f32 %f320, %f5, %f50
  asm("sub.f32 %0, %1, %2;" : "=f"(f320) : "f"(f5), "f"(f50));
  // PTX:358 div.rn.f32 %f61, %f57, %f59
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f61) : "f"(f57), "f"(f59));
  // PTX:359 mul.f32 %f321, %f320, %f61
  asm("mul.f32 %0, %1, %2;" : "=f"(f321) : "f"(f320), "f"(f61));
  // PTX:360 sub.f32 %f322, %f8, %f52
  asm("sub.f32 %0, %1, %2;" : "=f"(f322) : "f"(f8), "f"(f52));
  // PTX:361 div.rn.f32 %f62, %f58, %f59
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f62) : "f"(f58), "f"(f59));
  // PTX:362 fma.rn.f32 %f323, %f319, %f60, %f321
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f323) : "f"(f319), "f"(f60), "f"(f321));
  // PTX:363 fma.rn.f32 %f63, %f322, %f62, %f323
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f63) : "f"(f322), "f"(f62), "f"(f323));
  // PTX:364 sub.f32 %f324, %f1, %f49
  asm("sub.f32 %0, %1, %2;" : "=f"(f324) : "f"(f1), "f"(f49));
  // PTX:365 sub.f32 %f325, %f4, %f50
  asm("sub.f32 %0, %1, %2;" : "=f"(f325) : "f"(f4), "f"(f50));
  // PTX:366 mul.f32 %f326, %f325, %f61
  asm("mul.f32 %0, %1, %2;" : "=f"(f326) : "f"(f325), "f"(f61));
  // PTX:367 sub.f32 %f327, %f7, %f52
  asm("sub.f32 %0, %1, %2;" : "=f"(f327) : "f"(f7), "f"(f52));
  // PTX:368 fma.rn.f32 %f328, %f324, %f60, %f326
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f328) : "f"(f324), "f"(f60), "f"(f326));
  // PTX:369 fma.rn.f32 %f64, %f327, %f62, %f328
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f64) : "f"(f327), "f"(f62), "f"(f328));
  // PTX:370 abs.f32 %f65, %f63
  asm("abs.f32 %0, %1;" : "=f"(f65) : "f"(f63));
  // PTX:371 setp.geu.f32 %p48, %f65, 0f7F800000
  p48 = ((isnan(((float)(f65))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f65)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:372 @%p48 bra $L__BB11_83
  if (p48) { goto L_BB11_83; }
  // PTX:374 abs.f32 %f66, %f64
  asm("abs.f32 %0, %1;" : "=f"(f66) : "f"(f64));
  // PTX:375 setp.geu.f32 %p49, %f66, 0f7F800000
  p49 = ((isnan(((float)(f66))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f66)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:376 mul.f32 %f329, %f63, %f64
  asm("mul.f32 %0, %1, %2;" : "=f"(f329) : "f"(f63), "f"(f64));
  // PTX:377 setp.ge.f32 %p50, %f329, 0f00000000
  p50 = (!(isnan(((float)(f329))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f329)) >= ((float)(as_f32(0x00000000u)))));
  // PTX:378 or.pred %p51, %p50, %p49
  p51 = ((p50) || (p49));
  // PTX:379 @%p51 bra $L__BB11_83
  if (p51) { goto L_BB11_83; }
  // PTX:381 add.f32 %f67, %f65, %f66
  asm("add.f32 %0, %1, %2;" : "=f"(f67) : "f"(f65), "f"(f66));
  // PTX:382 abs.f32 %f330, %f67
  asm("abs.f32 %0, %1;" : "=f"(f330) : "f"(f67));
  // PTX:383 setp.geu.f32 %p52, %f330, 0f7F800000
  p52 = ((isnan(((float)(f330))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f330)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:384 setp.le.f32 %p53, %f67, 0f00000000
  p53 = (!(isnan(((float)(f67))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f67)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:385 or.pred %p54, %p52, %p53
  p54 = ((p52) || (p53));
  // PTX:386 @%p54 bra $L__BB11_83
  if (p54) { goto L_BB11_83; }
  // PTX:388 mul.f32 %f331, %f2, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f331) : "f"(f2), "f"(f66));
  // PTX:389 fma.rn.f32 %f332, %f1, %f65, %f331
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f332) : "f"(f1), "f"(f65), "f"(f331));
  // PTX:390 mul.f32 %f333, %f5, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f333) : "f"(f5), "f"(f66));
  // PTX:391 fma.rn.f32 %f334, %f4, %f65, %f333
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f334) : "f"(f4), "f"(f65), "f"(f333));
  // PTX:392 mul.f32 %f335, %f8, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f335) : "f"(f8), "f"(f66));
  // PTX:393 fma.rn.f32 %f336, %f7, %f65, %f335
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f336) : "f"(f7), "f"(f65), "f"(f335));
  // PTX:394 div.rn.f32 %f68, %f332, %f67
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f68) : "f"(f332), "f"(f67));
  // PTX:395 div.rn.f32 %f69, %f334, %f67
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f69) : "f"(f334), "f"(f67));
  // PTX:396 div.rn.f32 %f70, %f336, %f67
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f70) : "f"(f336), "f"(f67));
  // PTX:397 sub.f32 %f337, %f68, %f48
  asm("sub.f32 %0, %1, %2;" : "=f"(f337) : "f"(f68), "f"(f48));
  // PTX:398 sub.f32 %f338, %f69, %f54
  asm("sub.f32 %0, %1, %2;" : "=f"(f338) : "f"(f69), "f"(f54));
  // PTX:399 sub.f32 %f339, %f70, %f55
  asm("sub.f32 %0, %1, %2;" : "=f"(f339) : "f"(f70), "f"(f55));
  // PTX:400 sub.f32 %f340, %f49, %f48
  asm("sub.f32 %0, %1, %2;" : "=f"(f340) : "f"(f49), "f"(f48));
  // PTX:401 sub.f32 %f341, %f50, %f54
  asm("sub.f32 %0, %1, %2;" : "=f"(f341) : "f"(f50), "f"(f54));
  // PTX:402 mul.f32 %f342, %f341, %f341
  asm("mul.f32 %0, %1, %2;" : "=f"(f342) : "f"(f341), "f"(f341));
  // PTX:403 sub.f32 %f343, %f52, %f55
  asm("sub.f32 %0, %1, %2;" : "=f"(f343) : "f"(f52), "f"(f55));
  // PTX:404 fma.rn.f32 %f344, %f340, %f340, %f342
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f344) : "f"(f340), "f"(f340), "f"(f342));
  // PTX:405 fma.rn.f32 %f71, %f343, %f343, %f344
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f71) : "f"(f343), "f"(f343), "f"(f344));
  // PTX:406 sub.f32 %f345, %f47, %f48
  asm("sub.f32 %0, %1, %2;" : "=f"(f345) : "f"(f47), "f"(f48));
  // PTX:407 sub.f32 %f346, %f51, %f54
  asm("sub.f32 %0, %1, %2;" : "=f"(f346) : "f"(f51), "f"(f54));
  // PTX:408 mul.f32 %f347, %f341, %f346
  asm("mul.f32 %0, %1, %2;" : "=f"(f347) : "f"(f341), "f"(f346));
  // PTX:409 sub.f32 %f348, %f53, %f55
  asm("sub.f32 %0, %1, %2;" : "=f"(f348) : "f"(f53), "f"(f55));
  // PTX:410 fma.rn.f32 %f349, %f340, %f345, %f347
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f349) : "f"(f340), "f"(f345), "f"(f347));
  // PTX:411 fma.rn.f32 %f72, %f343, %f348, %f349
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f72) : "f"(f343), "f"(f348), "f"(f349));
  // PTX:412 mul.f32 %f350, %f341, %f338
  asm("mul.f32 %0, %1, %2;" : "=f"(f350) : "f"(f341), "f"(f338));
  // PTX:413 fma.rn.f32 %f351, %f340, %f337, %f350
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f351) : "f"(f340), "f"(f337), "f"(f350));
  // PTX:414 fma.rn.f32 %f73, %f343, %f339, %f351
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f73) : "f"(f343), "f"(f339), "f"(f351));
  // PTX:415 mul.f32 %f352, %f346, %f346
  asm("mul.f32 %0, %1, %2;" : "=f"(f352) : "f"(f346), "f"(f346));
  // PTX:416 fma.rn.f32 %f353, %f345, %f345, %f352
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f353) : "f"(f345), "f"(f345), "f"(f352));
  // PTX:417 fma.rn.f32 %f74, %f348, %f348, %f353
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f74) : "f"(f348), "f"(f348), "f"(f353));
  // PTX:418 mul.f32 %f354, %f346, %f338
  asm("mul.f32 %0, %1, %2;" : "=f"(f354) : "f"(f346), "f"(f338));
  // PTX:419 fma.rn.f32 %f355, %f345, %f337, %f354
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f355) : "f"(f345), "f"(f337), "f"(f354));
  // PTX:420 fma.rn.f32 %f75, %f348, %f339, %f355
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f75) : "f"(f348), "f"(f339), "f"(f355));
  // PTX:421 mul.f32 %f356, %f71, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f356) : "f"(f71), "f"(f74));
  // PTX:422 mul.f32 %f357, %f72, %f72
  asm("mul.f32 %0, %1, %2;" : "=f"(f357) : "f"(f72), "f"(f72));
  // PTX:423 sub.f32 %f76, %f356, %f357
  asm("sub.f32 %0, %1, %2;" : "=f"(f76) : "f"(f356), "f"(f357));
  // PTX:424 abs.f32 %f358, %f76
  asm("abs.f32 %0, %1;" : "=f"(f358) : "f"(f76));
  // PTX:425 setp.lt.f32 %p55, %f358, 0f2B8CBCCC
  p55 = (!(isnan(((float)(f358))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) && (((float)(f358)) < ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:426 mov.u16 %rs43, 0
  asm("mov.u16 %0, 0;" : "=h"(rs43) : );
  // PTX:427 @%p55 bra $L__BB11_38
  if (p55) { goto L_BB11_38; }
  // PTX:429 mov.u16 %rs43, 0
  asm("mov.u16 %0, 0;" : "=h"(rs43) : );
  // PTX:430 rcp.rn.f32 %f359, %f76
  asm("rcp.rn.f32 %0, %1;" : "=f"(f359) : "f"(f76));
  // PTX:431 mov.f32 %f360, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f360) : );
  // PTX:432 mul.f32 %f361, %f72, %f75
  asm("mul.f32 %0, %1, %2;" : "=f"(f361) : "f"(f72), "f"(f75));
  // PTX:433 mul.f32 %f362, %f74, %f73
  asm("mul.f32 %0, %1, %2;" : "=f"(f362) : "f"(f74), "f"(f73));
  // PTX:434 sub.f32 %f363, %f362, %f361
  asm("sub.f32 %0, %1, %2;" : "=f"(f363) : "f"(f362), "f"(f361));
  // PTX:435 mul.f32 %f663, %f359, %f363
  asm("mul.f32 %0, %1, %2;" : "=f"(f663) : "f"(f359), "f"(f363));
  // PTX:436 mul.f32 %f364, %f72, %f73
  asm("mul.f32 %0, %1, %2;" : "=f"(f364) : "f"(f72), "f"(f73));
  // PTX:437 mul.f32 %f365, %f71, %f75
  asm("mul.f32 %0, %1, %2;" : "=f"(f365) : "f"(f71), "f"(f75));
  // PTX:438 sub.f32 %f366, %f365, %f364
  asm("sub.f32 %0, %1, %2;" : "=f"(f366) : "f"(f365), "f"(f364));
  // PTX:439 mul.f32 %f662, %f359, %f366
  asm("mul.f32 %0, %1, %2;" : "=f"(f662) : "f"(f359), "f"(f366));
  // PTX:440 sub.f32 %f367, %f360, %f663
  asm("sub.f32 %0, %1, %2;" : "=f"(f367) : "f"(f360), "f"(f663));
  // PTX:441 sub.f32 %f661, %f367, %f662
  asm("sub.f32 %0, %1, %2;" : "=f"(f661) : "f"(f367), "f"(f662));
  // PTX:442 abs.f32 %f368, %f663
  asm("abs.f32 %0, %1;" : "=f"(f368) : "f"(f663));
  // PTX:443 setp.geu.f32 %p56, %f368, 0f7F800000
  p56 = ((isnan(((float)(f368))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f368)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:444 @%p56 bra $L__BB11_38
  if (p56) { goto L_BB11_38; }
  // PTX:446 mov.u16 %rs43, 0
  asm("mov.u16 %0, 0;" : "=h"(rs43) : );
  // PTX:447 abs.f32 %f369, %f662
  asm("abs.f32 %0, %1;" : "=f"(f369) : "f"(f662));
  // PTX:448 setp.geu.f32 %p57, %f369, 0f7F800000
  p57 = ((isnan(((float)(f369))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f369)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:449 @%p57 bra $L__BB11_38
  if (p57) { goto L_BB11_38; }
  // PTX:451 abs.f32 %f370, %f661
  asm("abs.f32 %0, %1;" : "=f"(f370) : "f"(f661));
  // PTX:452 setp.lt.f32 %p58, %f370, 0f7F800000
  p58 = (!(isnan(((float)(f370))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f370)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:453 selp.u16 %rs43, 1, 0, %p58
  rs43 = p58 ? 1 : 0;
  // PTX:455 $L__BB11_38:
L_BB11_38:;
  // PTX:456 setp.lt.f32 %p59, %f663, 0f3C23D70A
  p59 = (!(isnan(((float)(f663))) || isnan(((float)(as_f32(0x3C23D70Au))))) && (((float)(f663)) < ((float)(as_f32(0x3C23D70Au)))));
  // PTX:457 setp.eq.s16 %p60, %rs43, 0
  p60 = (((short)(rs43)) == ((short)(0)));
  // PTX:458 or.pred %p61, %p59, %p60
  p61 = ((p59) || (p60));
  // PTX:459 setp.lt.f32 %p62, %f662, 0f3C23D70A
  p62 = (!(isnan(((float)(f662))) || isnan(((float)(as_f32(0x3C23D70Au))))) && (((float)(f662)) < ((float)(as_f32(0x3C23D70Au)))));
  // PTX:460 or.pred %p63, %p62, %p61
  p63 = ((p62) || (p61));
  // PTX:461 setp.lt.f32 %p64, %f661, 0f3C23D70A
  p64 = (!(isnan(((float)(f661))) || isnan(((float)(as_f32(0x3C23D70Au))))) && (((float)(f661)) < ((float)(as_f32(0x3C23D70Au)))));
  // PTX:462 or.pred %p65, %p64, %p63
  p65 = ((p64) || (p63));
  // PTX:463 @%p65 bra $L__BB11_83
  if (p65) { goto L_BB11_83; }
  // PTX:465 ld.global.u32 %r97, [%rd16]
  r97 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:466 ld.global.u32 %r28, [%rd16+4]
  r28 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (4)))));
  // PTX:467 setp.ge.s32 %p66, %r97, %r28
  p66 = (((int)(r97)) >= ((int)(r28)));
  // PTX:468 mov.f32 %f627, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f627) : );
  // PTX:469 mov.f32 %f628, %f627
  asm("mov.f32 %0, %1;" : "=f"(f628) : "f"(f627));
  // PTX:470 mov.f32 %f629, %f627
  asm("mov.f32 %0, %1;" : "=f"(f629) : "f"(f627));
  // PTX:471 @%p66 bra $L__BB11_55
  if (p66) { goto L_BB11_55; }
  // PTX:473 mul.f32 %f377, %f61, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f377) : "f"(f61), "f"(f15));
  // PTX:474 fma.rn.f32 %f378, %f60, %f17, %f377
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f378) : "f"(f60), "f"(f17), "f"(f377));
  // PTX:475 fma.rn.f32 %f83, %f62, %f16, %f378
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f83) : "f"(f62), "f"(f16), "f"(f378));
  // PTX:476 mov.f32 %f629, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f629) : );
  // PTX:477 mov.f32 %f628, %f629
  asm("mov.f32 %0, %1;" : "=f"(f628) : "f"(f629));
  // PTX:478 mov.f32 %f627, %f629
  asm("mov.f32 %0, %1;" : "=f"(f627) : "f"(f629));
  // PTX:480 $L__BB11_41:
L_BB11_41:;
  // PTX:481 sub.f32 %f593, %f1, %f2
  asm("sub.f32 %0, %1, %2;" : "=f"(f593) : "f"(f1), "f"(f2));
  // PTX:482 sub.f32 %f592, %f7, %f8
  asm("sub.f32 %0, %1, %2;" : "=f"(f592) : "f"(f7), "f"(f8));
  // PTX:483 sub.f32 %f591, %f4, %f5
  asm("sub.f32 %0, %1, %2;" : "=f"(f591) : "f"(f4), "f"(f5));
  // PTX:484 mul.wide.s32 %rd74, %r97, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd74) : "r"(r97));
  // PTX:485 add.s64 %rd75, %rd21, %rd74
  asm("add.s64 %0, %1, %2;" : "=l"(rd75) : "l"(rd21), "l"(rd74));
  // PTX:486 ld.global.u32 %r80, [%rd75]
  r80 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (0)))));
  // PTX:487 add.s32 %r81, %r80, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r81) : "r"(r80), "r"(r1));
  // PTX:488 mul.wide.s32 %rd76, %r81, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd76) : "r"(r81));
  // PTX:489 add.s64 %rd77, %rd4, %rd76
  asm("add.s64 %0, %1, %2;" : "=l"(rd77) : "l"(rd4), "l"(rd76));
  // PTX:490 ld.global.f32 %f90, [%rd77]
  f90 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (0)))));
  // PTX:491 sub.f32 %f379, %f90, %f2
  asm("sub.f32 %0, %1, %2;" : "=f"(f379) : "f"(f90), "f"(f2));
  // PTX:492 ld.global.f32 %f91, [%rd77+4]
  f91 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (4)))));
  // PTX:493 sub.f32 %f380, %f91, %f5
  asm("sub.f32 %0, %1, %2;" : "=f"(f380) : "f"(f91), "f"(f5));
  // PTX:494 ld.global.f32 %f92, [%rd77+8]
  f92 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (8)))));
  // PTX:495 sub.f32 %f381, %f92, %f8
  asm("sub.f32 %0, %1, %2;" : "=f"(f381) : "f"(f92), "f"(f8));
  // PTX:496 mul.f32 %f382, %f591, %f381
  asm("mul.f32 %0, %1, %2;" : "=f"(f382) : "f"(f591), "f"(f381));
  // PTX:497 mul.f32 %f383, %f592, %f380
  asm("mul.f32 %0, %1, %2;" : "=f"(f383) : "f"(f592), "f"(f380));
  // PTX:498 sub.f32 %f93, %f382, %f383
  asm("sub.f32 %0, %1, %2;" : "=f"(f93) : "f"(f382), "f"(f383));
  // PTX:499 mul.f32 %f384, %f592, %f379
  asm("mul.f32 %0, %1, %2;" : "=f"(f384) : "f"(f592), "f"(f379));
  // PTX:500 mul.f32 %f385, %f593, %f381
  asm("mul.f32 %0, %1, %2;" : "=f"(f385) : "f"(f593), "f"(f381));
  // PTX:501 sub.f32 %f94, %f384, %f385
  asm("sub.f32 %0, %1, %2;" : "=f"(f94) : "f"(f384), "f"(f385));
  // PTX:502 mul.f32 %f386, %f593, %f380
  asm("mul.f32 %0, %1, %2;" : "=f"(f386) : "f"(f593), "f"(f380));
  // PTX:503 mul.f32 %f387, %f591, %f379
  asm("mul.f32 %0, %1, %2;" : "=f"(f387) : "f"(f591), "f"(f379));
  // PTX:504 sub.f32 %f95, %f386, %f387
  asm("sub.f32 %0, %1, %2;" : "=f"(f95) : "f"(f386), "f"(f387));
  // PTX:505 mul.f32 %f388, %f94, %f94
  asm("mul.f32 %0, %1, %2;" : "=f"(f388) : "f"(f94), "f"(f94));
  // PTX:506 fma.rn.f32 %f389, %f93, %f93, %f388
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f389) : "f"(f93), "f"(f93), "f"(f388));
  // PTX:507 fma.rn.f32 %f390, %f95, %f95, %f389
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f390) : "f"(f95), "f"(f95), "f"(f389));
  // PTX:508 sqrt.rn.f32 %f96, %f390
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f96) : "f"(f390));
  // PTX:509 setp.lt.f32 %p67, %f96, 0f2B8CBCCC
  p67 = (!(isnan(((float)(f96))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) && (((float)(f96)) < ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:510 mov.u32 %r98, 0
  asm("mov.u32 %0, 0;" : "=r"(r98) : );
  // PTX:511 mov.u32 %r99, %r98
  asm("mov.u32 %0, %1;" : "=r"(r99) : "r"(r98));
  // PTX:512 mov.u32 %r100, %r98
  asm("mov.u32 %0, %1;" : "=r"(r100) : "r"(r98));
  // PTX:513 @%p67 bra $L__BB11_43
  if (p67) { goto L_BB11_43; }
  // PTX:515 div.rn.f32 %f391, %f93, %f96
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f391) : "f"(f93), "f"(f96));
  // PTX:516 div.rn.f32 %f392, %f94, %f96
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f392) : "f"(f94), "f"(f96));
  // PTX:517 div.rn.f32 %f393, %f95, %f96
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f393) : "f"(f95), "f"(f96));
  // PTX:518 mov.b32 %r100, %f393
  asm("mov.b32 %0, %1;" : "=r"(r100) : "f"(f393));
  // PTX:519 mov.b32 %r99, %f392
  asm("mov.b32 %0, %1;" : "=r"(r99) : "f"(f392));
  // PTX:520 mov.b32 %r98, %f391
  asm("mov.b32 %0, %1;" : "=r"(r98) : "f"(f391));
  // PTX:522 $L__BB11_43:
L_BB11_43:;
  // PTX:523 mov.b32 %f97, %r98
  asm("mov.b32 %0, %1;" : "=f"(f97) : "r"(r98));
  // PTX:524 abs.f32 %f394, %f97
  asm("abs.f32 %0, %1;" : "=f"(f394) : "f"(f97));
  // PTX:525 setp.geu.f32 %p68, %f394, 0f7F800000
  p68 = ((isnan(((float)(f394))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f394)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:526 mov.u16 %rs44, 0
  asm("mov.u16 %0, 0;" : "=h"(rs44) : );
  // PTX:527 @%p68 bra $L__BB11_46
  if (p68) { goto L_BB11_46; }
  // PTX:529 mov.b32 %f395, %r99
  asm("mov.b32 %0, %1;" : "=f"(f395) : "r"(r99));
  // PTX:530 abs.f32 %f396, %f395
  asm("abs.f32 %0, %1;" : "=f"(f396) : "f"(f395));
  // PTX:531 setp.geu.f32 %p69, %f396, 0f7F800000
  p69 = ((isnan(((float)(f396))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f396)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:532 @%p69 bra $L__BB11_46
  if (p69) { goto L_BB11_46; }
  // PTX:534 mov.b32 %f397, %r100
  asm("mov.b32 %0, %1;" : "=f"(f397) : "r"(r100));
  // PTX:535 abs.f32 %f398, %f397
  asm("abs.f32 %0, %1;" : "=f"(f398) : "f"(f397));
  // PTX:536 setp.lt.f32 %p70, %f398, 0f7F800000
  p70 = (!(isnan(((float)(f398))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f398)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:537 selp.u16 %rs44, 1, 0, %p70
  rs44 = p70 ? 1 : 0;
  // PTX:539 $L__BB11_46:
L_BB11_46:;
  // PTX:540 setp.eq.s16 %p71, %rs44, 0
  p71 = (((short)(rs44)) == ((short)(0)));
  // PTX:541 @%p71 bra $L__BB11_54
  if (p71) { goto L_BB11_54; }
  // PTX:543 mov.b32 %f399, %r100
  asm("mov.b32 %0, %1;" : "=f"(f399) : "r"(r100));
  // PTX:544 mul.f32 %f400, %f61, %f399
  asm("mul.f32 %0, %1, %2;" : "=f"(f400) : "f"(f61), "f"(f399));
  // PTX:545 mov.b32 %f401, %r99
  asm("mov.b32 %0, %1;" : "=f"(f401) : "r"(r99));
  // PTX:546 mul.f32 %f402, %f62, %f401
  asm("mul.f32 %0, %1, %2;" : "=f"(f402) : "f"(f62), "f"(f401));
  // PTX:547 sub.f32 %f98, %f400, %f402
  asm("sub.f32 %0, %1, %2;" : "=f"(f98) : "f"(f400), "f"(f402));
  // PTX:548 mul.f32 %f403, %f60, %f399
  asm("mul.f32 %0, %1, %2;" : "=f"(f403) : "f"(f60), "f"(f399));
  // PTX:549 mul.f32 %f404, %f62, %f97
  asm("mul.f32 %0, %1, %2;" : "=f"(f404) : "f"(f62), "f"(f97));
  // PTX:550 sub.f32 %f99, %f404, %f403
  asm("sub.f32 %0, %1, %2;" : "=f"(f99) : "f"(f404), "f"(f403));
  // PTX:551 mul.f32 %f405, %f60, %f401
  asm("mul.f32 %0, %1, %2;" : "=f"(f405) : "f"(f60), "f"(f401));
  // PTX:552 mul.f32 %f406, %f61, %f97
  asm("mul.f32 %0, %1, %2;" : "=f"(f406) : "f"(f61), "f"(f97));
  // PTX:553 sub.f32 %f100, %f405, %f406
  asm("sub.f32 %0, %1, %2;" : "=f"(f100) : "f"(f405), "f"(f406));
  // PTX:554 mul.f32 %f407, %f99, %f99
  asm("mul.f32 %0, %1, %2;" : "=f"(f407) : "f"(f99), "f"(f99));
  // PTX:555 fma.rn.f32 %f408, %f98, %f98, %f407
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f408) : "f"(f98), "f"(f98), "f"(f407));
  // PTX:556 fma.rn.f32 %f409, %f100, %f100, %f408
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f409) : "f"(f100), "f"(f100), "f"(f408));
  // PTX:557 sqrt.rn.f32 %f101, %f409
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f101) : "f"(f409));
  // PTX:558 setp.lt.f32 %p72, %f101, 0f358637BD
  p72 = (!(isnan(((float)(f101))) || isnan(((float)(as_f32(0x358637BDu))))) && (((float)(f101)) < ((float)(as_f32(0x358637BDu)))));
  // PTX:559 mov.u32 %r106, 0
  asm("mov.u32 %0, 0;" : "=r"(r106) : );
  // PTX:560 mov.u32 %r105, %r106
  asm("mov.u32 %0, %1;" : "=r"(r105) : "r"(r106));
  // PTX:561 mov.u32 %r104, %r106
  asm("mov.u32 %0, %1;" : "=r"(r104) : "r"(r106));
  // PTX:562 @%p72 bra $L__BB11_49
  if (p72) { goto L_BB11_49; }
  // PTX:564 div.rn.f32 %f410, %f98, %f101
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f410) : "f"(f98), "f"(f101));
  // PTX:565 div.rn.f32 %f411, %f99, %f101
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f411) : "f"(f99), "f"(f101));
  // PTX:566 div.rn.f32 %f412, %f100, %f101
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f412) : "f"(f100), "f"(f101));
  // PTX:567 mov.b32 %r104, %f412
  asm("mov.b32 %0, %1;" : "=r"(r104) : "f"(f412));
  // PTX:568 mov.b32 %r105, %f411
  asm("mov.b32 %0, %1;" : "=r"(r105) : "f"(f411));
  // PTX:569 mov.b32 %r106, %f410
  asm("mov.b32 %0, %1;" : "=r"(r106) : "f"(f410));
  // PTX:571 $L__BB11_49:
L_BB11_49:;
  // PTX:572 mov.b32 %f102, %r104
  asm("mov.b32 %0, %1;" : "=f"(f102) : "r"(r104));
  // PTX:573 mul.f32 %f413, %f15, %f102
  asm("mul.f32 %0, %1, %2;" : "=f"(f413) : "f"(f15), "f"(f102));
  // PTX:574 mov.b32 %f103, %r105
  asm("mov.b32 %0, %1;" : "=f"(f103) : "r"(r105));
  // PTX:575 mul.f32 %f414, %f16, %f103
  asm("mul.f32 %0, %1, %2;" : "=f"(f414) : "f"(f16), "f"(f103));
  // PTX:576 sub.f32 %f415, %f413, %f414
  asm("sub.f32 %0, %1, %2;" : "=f"(f415) : "f"(f413), "f"(f414));
  // PTX:577 mov.b32 %f104, %r106
  asm("mov.b32 %0, %1;" : "=f"(f104) : "r"(r106));
  // PTX:578 mul.f32 %f416, %f16, %f104
  asm("mul.f32 %0, %1, %2;" : "=f"(f416) : "f"(f16), "f"(f104));
  // PTX:579 mul.f32 %f417, %f17, %f102
  asm("mul.f32 %0, %1, %2;" : "=f"(f417) : "f"(f17), "f"(f102));
  // PTX:580 sub.f32 %f418, %f416, %f417
  asm("sub.f32 %0, %1, %2;" : "=f"(f418) : "f"(f416), "f"(f417));
  // PTX:581 mul.f32 %f419, %f17, %f103
  asm("mul.f32 %0, %1, %2;" : "=f"(f419) : "f"(f17), "f"(f103));
  // PTX:582 mul.f32 %f420, %f15, %f104
  asm("mul.f32 %0, %1, %2;" : "=f"(f420) : "f"(f15), "f"(f104));
  // PTX:583 sub.f32 %f421, %f419, %f420
  asm("sub.f32 %0, %1, %2;" : "=f"(f421) : "f"(f419), "f"(f420));
  // PTX:584 sub.f32 %f422, %f92, %f70
  asm("sub.f32 %0, %1, %2;" : "=f"(f422) : "f"(f92), "f"(f70));
  // PTX:585 mul.f32 %f423, %f422, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f423) : "f"(f422), "f"(f15));
  // PTX:586 sub.f32 %f424, %f91, %f69
  asm("sub.f32 %0, %1, %2;" : "=f"(f424) : "f"(f91), "f"(f69));
  // PTX:587 mul.f32 %f425, %f424, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f425) : "f"(f424), "f"(f16));
  // PTX:588 sub.f32 %f426, %f423, %f425
  asm("sub.f32 %0, %1, %2;" : "=f"(f426) : "f"(f423), "f"(f425));
  // PTX:589 sub.f32 %f427, %f90, %f68
  asm("sub.f32 %0, %1, %2;" : "=f"(f427) : "f"(f90), "f"(f68));
  // PTX:590 mul.f32 %f428, %f427, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f428) : "f"(f427), "f"(f16));
  // PTX:591 mul.f32 %f429, %f422, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f429) : "f"(f422), "f"(f17));
  // PTX:592 sub.f32 %f430, %f428, %f429
  asm("sub.f32 %0, %1, %2;" : "=f"(f430) : "f"(f428), "f"(f429));
  // PTX:593 mul.f32 %f431, %f424, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f431) : "f"(f424), "f"(f17));
  // PTX:594 mul.f32 %f432, %f427, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f432) : "f"(f427), "f"(f15));
  // PTX:595 sub.f32 %f433, %f431, %f432
  asm("sub.f32 %0, %1, %2;" : "=f"(f433) : "f"(f431), "f"(f432));
  // PTX:596 mul.f32 %f434, %f430, %f418
  asm("mul.f32 %0, %1, %2;" : "=f"(f434) : "f"(f430), "f"(f418));
  // PTX:597 fma.rn.f32 %f435, %f426, %f415, %f434
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f435) : "f"(f426), "f"(f415), "f"(f434));
  // PTX:598 fma.rn.f32 %f436, %f433, %f421, %f435
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f436) : "f"(f433), "f"(f421), "f"(f435));
  // PTX:599 setp.geu.f32 %p73, %f436, 0f00000000
  p73 = ((isnan(((float)(f436))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f436)) >= ((float)(as_f32(0x00000000u)))));
  // PTX:600 @%p73 bra $L__BB11_51
  if (p73) { goto L_BB11_51; }
  // PTX:602 neg.f32 %f437, %f104
  asm("neg.f32 %0, %1;" : "=f"(f437) : "f"(f104));
  // PTX:603 mov.b32 %r106, %f437
  asm("mov.b32 %0, %1;" : "=r"(r106) : "f"(f437));
  // PTX:604 neg.f32 %f438, %f103
  asm("neg.f32 %0, %1;" : "=f"(f438) : "f"(f103));
  // PTX:605 mov.b32 %r105, %f438
  asm("mov.b32 %0, %1;" : "=r"(r105) : "f"(f438));
  // PTX:606 neg.f32 %f439, %f102
  asm("neg.f32 %0, %1;" : "=f"(f439) : "f"(f102));
  // PTX:607 mov.b32 %r104, %f439
  asm("mov.b32 %0, %1;" : "=r"(r104) : "f"(f439));
  // PTX:609 $L__BB11_51:
L_BB11_51:;
  // PTX:610 abs.f32 %f440, %f83
  asm("abs.f32 %0, %1;" : "=f"(f440) : "f"(f83));
  // PTX:611 setp.leu.f32 %p74, %f440, 0f358637BD
  p74 = ((isnan(((float)(f440))) || isnan(((float)(as_f32(0x358637BDu))))) || (((float)(f440)) <= ((float)(as_f32(0x358637BDu)))));
  // PTX:612 @%p74 bra $L__BB11_53
  if (p74) { goto L_BB11_53; }
  // PTX:614 add.f32 %f590, %f62, %f62
  asm("add.f32 %0, %1, %2;" : "=f"(f590) : "f"(f62), "f"(f62));
  // PTX:615 add.f32 %f589, %f61, %f61
  asm("add.f32 %0, %1, %2;" : "=f"(f589) : "f"(f61), "f"(f61));
  // PTX:616 add.f32 %f588, %f60, %f60
  asm("add.f32 %0, %1, %2;" : "=f"(f588) : "f"(f60), "f"(f60));
  // PTX:617 mov.b32 %f441, %r106
  asm("mov.b32 %0, %1;" : "=f"(f441) : "r"(r106));
  // PTX:618 mul.f32 %f442, %f17, %f441
  asm("mul.f32 %0, %1, %2;" : "=f"(f442) : "f"(f17), "f"(f441));
  // PTX:619 mov.b32 %f443, %r105
  asm("mov.b32 %0, %1;" : "=f"(f443) : "r"(r105));
  // PTX:620 mov.b32 %f444, %r104
  asm("mov.b32 %0, %1;" : "=f"(f444) : "r"(r104));
  // PTX:621 fma.rn.f32 %f445, %f15, %f443, %f442
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f445) : "f"(f15), "f"(f443), "f"(f442));
  // PTX:622 fma.rn.f32 %f446, %f16, %f444, %f445
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f446) : "f"(f16), "f"(f444), "f"(f445));
  // PTX:623 mul.f32 %f447, %f588, %f446
  asm("mul.f32 %0, %1, %2;" : "=f"(f447) : "f"(f588), "f"(f446));
  // PTX:624 mul.f32 %f448, %f589, %f446
  asm("mul.f32 %0, %1, %2;" : "=f"(f448) : "f"(f589), "f"(f446));
  // PTX:625 mul.f32 %f449, %f590, %f446
  asm("mul.f32 %0, %1, %2;" : "=f"(f449) : "f"(f590), "f"(f446));
  // PTX:626 div.rn.f32 %f450, %f447, %f83
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f450) : "f"(f447), "f"(f83));
  // PTX:627 div.rn.f32 %f451, %f448, %f83
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f451) : "f"(f448), "f"(f83));
  // PTX:628 div.rn.f32 %f452, %f449, %f83
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f452) : "f"(f449), "f"(f83));
  // PTX:629 sub.f32 %f453, %f441, %f450
  asm("sub.f32 %0, %1, %2;" : "=f"(f453) : "f"(f441), "f"(f450));
  // PTX:630 sub.f32 %f454, %f443, %f451
  asm("sub.f32 %0, %1, %2;" : "=f"(f454) : "f"(f443), "f"(f451));
  // PTX:631 sub.f32 %f455, %f444, %f452
  asm("sub.f32 %0, %1, %2;" : "=f"(f455) : "f"(f444), "f"(f452));
  // PTX:632 mov.b32 %r106, %f453
  asm("mov.b32 %0, %1;" : "=r"(r106) : "f"(f453));
  // PTX:633 mov.b32 %r105, %f454
  asm("mov.b32 %0, %1;" : "=r"(r105) : "f"(f454));
  // PTX:634 mov.b32 %r104, %f455
  asm("mov.b32 %0, %1;" : "=r"(r104) : "f"(f455));
  // PTX:636 $L__BB11_53:
L_BB11_53:;
  // PTX:637 mov.b32 %f456, %r106
  asm("mov.b32 %0, %1;" : "=f"(f456) : "r"(r106));
  // PTX:638 add.f32 %f627, %f627, %f456
  asm("add.f32 %0, %1, %2;" : "=f"(f627) : "f"(f627), "f"(f456));
  // PTX:639 mov.b32 %f457, %r105
  asm("mov.b32 %0, %1;" : "=f"(f457) : "r"(r105));
  // PTX:640 add.f32 %f628, %f628, %f457
  asm("add.f32 %0, %1, %2;" : "=f"(f628) : "f"(f628), "f"(f457));
  // PTX:641 mov.b32 %f458, %r104
  asm("mov.b32 %0, %1;" : "=f"(f458) : "r"(r104));
  // PTX:642 add.f32 %f629, %f629, %f458
  asm("add.f32 %0, %1, %2;" : "=f"(f629) : "f"(f629), "f"(f458));
  // PTX:644 $L__BB11_54:
L_BB11_54:;
  // PTX:645 add.s32 %r97, %r97, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r97) : "r"(r97));
  // PTX:646 setp.lt.s32 %p75, %r97, %r28
  p75 = (((int)(r97)) < ((int)(r28)));
  // PTX:647 @%p75 bra $L__BB11_41
  if (p75) { goto L_BB11_41; }
  // PTX:649 $L__BB11_55:
L_BB11_55:;
  // PTX:650 mul.f32 %f459, %f628, %f628
  asm("mul.f32 %0, %1, %2;" : "=f"(f459) : "f"(f628), "f"(f628));
  // PTX:651 fma.rn.f32 %f460, %f627, %f627, %f459
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f460) : "f"(f627), "f"(f627), "f"(f459));
  // PTX:652 fma.rn.f32 %f461, %f629, %f629, %f460
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f461) : "f"(f629), "f"(f629), "f"(f460));
  // PTX:653 sqrt.rn.f32 %f114, %f461
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f114) : "f"(f461));
  // PTX:654 abs.f32 %f462, %f114
  asm("abs.f32 %0, %1;" : "=f"(f462) : "f"(f114));
  // PTX:655 setp.geu.f32 %p76, %f462, 0f7F800000
  p76 = ((isnan(((float)(f462))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f462)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:656 setp.lt.f32 %p77, %f114, 0f2B8CBCCC
  p77 = (!(isnan(((float)(f114))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) && (((float)(f114)) < ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:657 or.pred %p78, %p77, %p76
  p78 = ((p77) || (p76));
  // PTX:658 @%p78 bra $L__BB11_83
  if (p78) { goto L_BB11_83; }
  // PTX:660 setp.eq.f32 %p79, %f11, 0f00000000
  p79 = (!(isnan(((float)(f11))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f11)) == ((float)(as_f32(0x00000000u)))));
  // PTX:661 div.rn.f32 %f115, %f627, %f114
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f115) : "f"(f627), "f"(f114));
  // PTX:662 div.rn.f32 %f116, %f628, %f114
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f116) : "f"(f628), "f"(f114));
  // PTX:663 div.rn.f32 %f117, %f629, %f114
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f117) : "f"(f629), "f"(f114));
  // PTX:664 shl.b64 %rd78, %rd23, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd78) : "l"(rd23));
  // PTX:665 add.s64 %rd79, %rd3, %rd78
  asm("add.s64 %0, %1, %2;" : "=l"(rd79) : "l"(rd3), "l"(rd78));
  // PTX:666 ld.global.f32 %f463, [%rd79]
  f463 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (0)))));
  // PTX:667 shl.b64 %rd80, %rd22, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd80) : "l"(rd22));
  // PTX:668 add.s64 %rd81, %rd3, %rd80
  asm("add.s64 %0, %1, %2;" : "=l"(rd81) : "l"(rd3), "l"(rd80));
  // PTX:669 ld.global.f32 %f464, [%rd81]
  f464 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (0)))));
  // PTX:670 add.f32 %f465, %f464, %f463
  asm("add.f32 %0, %1, %2;" : "=f"(f465) : "f"(f464), "f"(f463));
  // PTX:671 shl.b64 %rd82, %rd24, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd82) : "l"(rd24));
  // PTX:672 add.s64 %rd83, %rd3, %rd82
  asm("add.s64 %0, %1, %2;" : "=l"(rd83) : "l"(rd3), "l"(rd82));
  // PTX:673 ld.global.f32 %f466, [%rd83]
  f466 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (0)))));
  // PTX:674 add.f32 %f467, %f465, %f466
  asm("add.f32 %0, %1, %2;" : "=f"(f467) : "f"(f465), "f"(f466));
  // PTX:675 div.rn.f32 %f118, %f467, 0f40400000
  asm("div.rn.f32 %0, %1, 0f40400000;" : "=f"(f118) : "f"(f467));
  // PTX:676 setp.eq.f32 %p80, %f118, 0f00000000
  p80 = (!(isnan(((float)(f118))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f118)) == ((float)(as_f32(0x00000000u)))));
  // PTX:677 or.pred %p81, %p79, %p80
  p81 = ((p79) || (p80));
  // PTX:678 @%p81 bra $L__BB11_61
  if (p81) { goto L_BB11_61; }
  // PTX:679 bra.uni $L__BB11_57
  goto L_BB11_57;
  // PTX:681 $L__BB11_61:
L_BB11_61:;
  // PTX:682 add.f32 %f475, %f11, %f118
  asm("add.f32 %0, %1, %2;" : "=f"(f475) : "f"(f11), "f"(f118));
  // PTX:683 mul.f32 %f633, %f475, %f221
  asm("mul.f32 %0, %1, %2;" : "=f"(f633) : "f"(f475), "f"(f221));
  // PTX:684 bra.uni $L__BB11_62
  goto L_BB11_62;
  // PTX:686 $L__BB11_57:
L_BB11_57:;
  // PTX:687 mul.f32 %f119, %f18, %f118
  asm("mul.f32 %0, %1, %2;" : "=f"(f119) : "f"(f18), "f"(f118));
  // PTX:688 add.f32 %f120, %f11, %f118
  asm("add.f32 %0, %1, %2;" : "=f"(f120) : "f"(f11), "f"(f118));
  // PTX:689 abs.f32 %f468, %f119
  asm("abs.f32 %0, %1;" : "=f"(f468) : "f"(f119));
  // PTX:690 setp.geu.f32 %p82, %f468, 0f7F800000
  p82 = ((isnan(((float)(f468))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f468)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:691 @%p82 bra $L__BB11_60
  if (p82) { goto L_BB11_60; }
  // PTX:693 abs.f32 %f469, %f120
  asm("abs.f32 %0, %1;" : "=f"(f469) : "f"(f120));
  // PTX:694 setp.geu.f32 %p83, %f469, 0f7F800000
  p83 = ((isnan(((float)(f469))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f469)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:695 @%p83 bra $L__BB11_60
  if (p83) { goto L_BB11_60; }
  // PTX:696 bra.uni $L__BB11_59
  goto L_BB11_59;
  // PTX:698 $L__BB11_60:
L_BB11_60:;
  // PTX:699 min.f32 %f470, %f11, %f118
  asm("min.f32 %0, %1, %2;" : "=f"(f470) : "f"(f11), "f"(f118));
  // PTX:700 max.f32 %f471, %f11, %f118
  asm("max.f32 %0, %1, %2;" : "=f"(f471) : "f"(f11), "f"(f118));
  // PTX:701 div.rn.f32 %f472, %f470, %f471
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f472) : "f"(f470), "f"(f471));
  // PTX:702 add.f32 %f473, %f472, 0f3F800000
  asm("add.f32 %0, %1, 0f3F800000;" : "=f"(f473) : "f"(f472));
  // PTX:703 div.rn.f32 %f474, %f470, %f473
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f474) : "f"(f470), "f"(f473));
  // PTX:704 mul.f32 %f633, %f474, %f221
  asm("mul.f32 %0, %1, %2;" : "=f"(f633) : "f"(f474), "f"(f221));
  // PTX:705 bra.uni $L__BB11_62
  goto L_BB11_62;
  // PTX:707 $L__BB11_59:
L_BB11_59:;
  // PTX:708 div.rn.f32 %f633, %f119, %f120
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f633) : "f"(f119), "f"(f120));
  // PTX:710 $L__BB11_62:
L_BB11_62:;
  // PTX:711 abs.f32 %f476, %f633
  asm("abs.f32 %0, %1;" : "=f"(f476) : "f"(f633));
  // PTX:712 setp.geu.f32 %p84, %f476, 0f7F800000
  p84 = ((isnan(((float)(f476))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f476)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:713 @%p84 bra $L__BB11_83
  if (p84) { goto L_BB11_83; }
  // PTX:715 mul.f32 %f477, %f19, %f633
  asm("mul.f32 %0, %1, %2;" : "=f"(f477) : "f"(f19), "f"(f633));
  // PTX:716 mul.f32 %f125, %f115, %f477
  asm("mul.f32 %0, %1, %2;" : "=f"(f125) : "f"(f115), "f"(f477));
  // PTX:717 mul.f32 %f126, %f116, %f477
  asm("mul.f32 %0, %1, %2;" : "=f"(f126) : "f"(f116), "f"(f477));
  // PTX:718 mul.f32 %f127, %f117, %f477
  asm("mul.f32 %0, %1, %2;" : "=f"(f127) : "f"(f117), "f"(f477));
  // PTX:719 mul.f32 %f478, %f115, %f115
  asm("mul.f32 %0, %1, %2;" : "=f"(f478) : "f"(f115), "f"(f115));
  // PTX:720 mul.f32 %f128, %f478, %f633
  asm("mul.f32 %0, %1, %2;" : "=f"(f128) : "f"(f478), "f"(f633));
  // PTX:721 mul.f32 %f479, %f116, %f115
  asm("mul.f32 %0, %1, %2;" : "=f"(f479) : "f"(f116), "f"(f115));
  // PTX:722 mul.f32 %f129, %f479, %f633
  asm("mul.f32 %0, %1, %2;" : "=f"(f129) : "f"(f479), "f"(f633));
  // PTX:723 mul.f32 %f480, %f117, %f115
  asm("mul.f32 %0, %1, %2;" : "=f"(f480) : "f"(f117), "f"(f115));
  // PTX:724 mul.f32 %f130, %f480, %f633
  asm("mul.f32 %0, %1, %2;" : "=f"(f130) : "f"(f480), "f"(f633));
  // PTX:725 mul.f32 %f481, %f116, %f116
  asm("mul.f32 %0, %1, %2;" : "=f"(f481) : "f"(f116), "f"(f116));
  // PTX:726 mul.f32 %f131, %f481, %f633
  asm("mul.f32 %0, %1, %2;" : "=f"(f131) : "f"(f481), "f"(f633));
  // PTX:727 mul.f32 %f482, %f117, %f116
  asm("mul.f32 %0, %1, %2;" : "=f"(f482) : "f"(f117), "f"(f116));
  // PTX:728 mul.f32 %f132, %f482, %f633
  asm("mul.f32 %0, %1, %2;" : "=f"(f132) : "f"(f482), "f"(f633));
  // PTX:729 mul.f32 %f483, %f117, %f117
  asm("mul.f32 %0, %1, %2;" : "=f"(f483) : "f"(f117), "f"(f117));
  // PTX:730 mul.f32 %f133, %f483, %f633
  asm("mul.f32 %0, %1, %2;" : "=f"(f133) : "f"(f483), "f"(f633));
  // PTX:731 abs.f32 %f484, %f125
  asm("abs.f32 %0, %1;" : "=f"(f484) : "f"(f125));
  // PTX:732 setp.geu.f32 %p85, %f484, 0f7F800000
  p85 = ((isnan(((float)(f484))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f484)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:733 mov.u16 %rs45, 0
  asm("mov.u16 %0, 0;" : "=h"(rs45) : );
  // PTX:734 @%p85 bra $L__BB11_66
  if (p85) { goto L_BB11_66; }
  // PTX:736 abs.f32 %f485, %f126
  asm("abs.f32 %0, %1;" : "=f"(f485) : "f"(f126));
  // PTX:737 setp.geu.f32 %p86, %f485, 0f7F800000
  p86 = ((isnan(((float)(f485))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f485)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:738 @%p86 bra $L__BB11_66
  if (p86) { goto L_BB11_66; }
  // PTX:740 abs.f32 %f486, %f127
  asm("abs.f32 %0, %1;" : "=f"(f486) : "f"(f127));
  // PTX:741 setp.lt.f32 %p87, %f486, 0f7F800000
  p87 = (!(isnan(((float)(f486))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f486)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:742 selp.u16 %rs45, 1, 0, %p87
  rs45 = p87 ? 1 : 0;
  // PTX:744 $L__BB11_66:
L_BB11_66:;
  // PTX:745 setp.eq.s16 %p88, %rs45, 0
  p88 = (((short)(rs45)) == ((short)(0)));
  // PTX:746 @%p88 bra $L__BB11_83
  if (p88) { goto L_BB11_83; }
  // PTX:748 abs.f32 %f487, %f128
  asm("abs.f32 %0, %1;" : "=f"(f487) : "f"(f128));
  // PTX:749 setp.geu.f32 %p89, %f487, 0f7F800000
  p89 = ((isnan(((float)(f487))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f487)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:750 mov.u16 %rs46, 0
  asm("mov.u16 %0, 0;" : "=h"(rs46) : );
  // PTX:751 @%p89 bra $L__BB11_70
  if (p89) { goto L_BB11_70; }
  // PTX:753 abs.f32 %f488, %f129
  asm("abs.f32 %0, %1;" : "=f"(f488) : "f"(f129));
  // PTX:754 setp.geu.f32 %p90, %f488, 0f7F800000
  p90 = ((isnan(((float)(f488))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f488)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:755 @%p90 bra $L__BB11_70
  if (p90) { goto L_BB11_70; }
  // PTX:757 abs.f32 %f489, %f130
  asm("abs.f32 %0, %1;" : "=f"(f489) : "f"(f130));
  // PTX:758 setp.lt.f32 %p91, %f489, 0f7F800000
  p91 = (!(isnan(((float)(f489))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f489)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:759 selp.u16 %rs46, 1, 0, %p91
  rs46 = p91 ? 1 : 0;
  // PTX:761 $L__BB11_70:
L_BB11_70:;
  // PTX:762 setp.eq.s16 %p92, %rs46, 0
  p92 = (((short)(rs46)) == ((short)(0)));
  // PTX:763 @%p92 bra $L__BB11_83
  if (p92) { goto L_BB11_83; }
  // PTX:765 abs.f32 %f490, %f129
  asm("abs.f32 %0, %1;" : "=f"(f490) : "f"(f129));
  // PTX:766 setp.geu.f32 %p93, %f490, 0f7F800000
  p93 = ((isnan(((float)(f490))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f490)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:767 mov.u16 %rs47, 0
  asm("mov.u16 %0, 0;" : "=h"(rs47) : );
  // PTX:768 @%p93 bra $L__BB11_74
  if (p93) { goto L_BB11_74; }
  // PTX:770 abs.f32 %f491, %f131
  asm("abs.f32 %0, %1;" : "=f"(f491) : "f"(f131));
  // PTX:771 setp.geu.f32 %p94, %f491, 0f7F800000
  p94 = ((isnan(((float)(f491))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f491)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:772 @%p94 bra $L__BB11_74
  if (p94) { goto L_BB11_74; }
  // PTX:774 abs.f32 %f492, %f132
  asm("abs.f32 %0, %1;" : "=f"(f492) : "f"(f132));
  // PTX:775 setp.lt.f32 %p95, %f492, 0f7F800000
  p95 = (!(isnan(((float)(f492))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f492)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:776 selp.u16 %rs47, 1, 0, %p95
  rs47 = p95 ? 1 : 0;
  // PTX:778 $L__BB11_74:
L_BB11_74:;
  // PTX:779 setp.eq.s16 %p96, %rs47, 0
  p96 = (((short)(rs47)) == ((short)(0)));
  // PTX:780 @%p96 bra $L__BB11_83
  if (p96) { goto L_BB11_83; }
  // PTX:782 abs.f32 %f493, %f130
  asm("abs.f32 %0, %1;" : "=f"(f493) : "f"(f130));
  // PTX:783 setp.geu.f32 %p97, %f493, 0f7F800000
  p97 = ((isnan(((float)(f493))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f493)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:784 mov.u16 %rs48, 0
  asm("mov.u16 %0, 0;" : "=h"(rs48) : );
  // PTX:785 @%p97 bra $L__BB11_78
  if (p97) { goto L_BB11_78; }
  // PTX:787 abs.f32 %f494, %f132
  asm("abs.f32 %0, %1;" : "=f"(f494) : "f"(f132));
  // PTX:788 setp.geu.f32 %p98, %f494, 0f7F800000
  p98 = ((isnan(((float)(f494))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f494)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:789 @%p98 bra $L__BB11_78
  if (p98) { goto L_BB11_78; }
  // PTX:791 abs.f32 %f495, %f133
  asm("abs.f32 %0, %1;" : "=f"(f495) : "f"(f133));
  // PTX:792 setp.lt.f32 %p99, %f495, 0f7F800000
  p99 = (!(isnan(((float)(f495))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f495)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:793 selp.u16 %rs48, 1, 0, %p99
  rs48 = p99 ? 1 : 0;
  // PTX:795 $L__BB11_78:
L_BB11_78:;
  // PTX:796 setp.eq.s16 %p100, %rs48, 0
  p100 = (((short)(rs48)) == ((short)(0)));
  // PTX:797 @%p100 bra $L__BB11_83
  if (p100) { goto L_BB11_83; }
  // PTX:799 ld.param.u64 %rd156, [_ZN7synreal21self_collision_kernel20accumulate_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_PKNS2_ILi3EiLS3_0EEESB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_12]
  rd156 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:800 setp.eq.s64 %p101, %rd156, 0
  p101 = (((long long)(rd156)) == ((long long)(0)));
  // PTX:801 div.rn.f32 %f134, %f66, %f67
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f134) : "f"(f66), "f"(f67));
  // PTX:802 div.rn.f32 %f135, %f65, %f67
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f135) : "f"(f65), "f"(f67));
  // PTX:803 @%p101 bra $L__BB11_81
  if (p101) { goto L_BB11_81; }
  // PTX:805 add.s32 %r88, %r4, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r88) : "r"(r4), "r"(r1));
  // PTX:806 add.s32 %r87, %r2, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r87) : "r"(r2), "r"(r1));
  // PTX:807 neg.f32 %f634, %f661
  asm("neg.f32 %0, %1;" : "=f"(f634) : "f"(f661));
  // PTX:808 atom.global.add.u32 %r85, [%rd19], 1
  r85 = atomicAdd(reinterpret_cast<unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))), (unsigned)(1));
  // PTX:809 mul.wide.u32 %rd84, %r85, 60
  asm("mul.wide.u32 %0, %1, 60;" : "=l"(rd84) : "r"(r85));
  // PTX:810 add.s64 %rd85, %rd20, %rd84
  asm("add.s64 %0, %1, %2;" : "=l"(rd85) : "l"(rd20), "l"(rd84));
  // PTX:811 st.global.u32 [%rd85], %r87
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (0))))) = (unsigned)(r87);
  // PTX:812 st.global.u32 [%rd85+4], %r88
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (4))))) = (unsigned)(r88);
  // PTX:813 st.global.u32 [%rd85+8], %r18
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (8))))) = (unsigned)(r18);
  // PTX:814 st.global.u32 [%rd85+12], %r21
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (12))))) = (unsigned)(r21);
  // PTX:815 st.global.u32 [%rd85+16], %r24
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (16))))) = (unsigned)(r24);
  // PTX:816 st.global.f32 [%rd85+20], %f134
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (20))))) = (float)(f134);
  // PTX:817 st.global.f32 [%rd85+24], %f135
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (24))))) = (float)(f135);
  // PTX:818 neg.f32 %f636, %f663
  asm("neg.f32 %0, %1;" : "=f"(f636) : "f"(f663));
  // PTX:819 st.global.f32 [%rd85+28], %f636
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (28))))) = (float)(f636);
  // PTX:820 neg.f32 %f635, %f662
  asm("neg.f32 %0, %1;" : "=f"(f635) : "f"(f662));
  // PTX:821 st.global.f32 [%rd85+32], %f635
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (32))))) = (float)(f635);
  // PTX:822 st.global.f32 [%rd85+36], %f634
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (36))))) = (float)(f634);
  // PTX:823 st.global.f32 [%rd85+40], %f115
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (40))))) = (float)(f115);
  // PTX:824 st.global.f32 [%rd85+44], %f116
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (44))))) = (float)(f116);
  // PTX:825 st.global.f32 [%rd85+48], %f117
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (48))))) = (float)(f117);
  // PTX:826 st.global.f32 [%rd85+52], %f633
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (52))))) = (float)(f633);
  // PTX:827 mov.u32 %r86, 5
  asm("mov.u32 %0, 5;" : "=r"(r86) : );
  // PTX:828 st.global.u32 [%rd85+56], %r86
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (56))))) = (unsigned)(r86);
  // PTX:829 bra.uni $L__BB11_82
  goto L_BB11_82;
  // PTX:831 $L__BB11_81:
L_BB11_81:;
  // PTX:832 neg.f32 %f636, %f663
  asm("neg.f32 %0, %1;" : "=f"(f636) : "f"(f663));
  // PTX:833 neg.f32 %f635, %f662
  asm("neg.f32 %0, %1;" : "=f"(f635) : "f"(f662));
  // PTX:834 neg.f32 %f634, %f661
  asm("neg.f32 %0, %1;" : "=f"(f634) : "f"(f661));
  // PTX:836 $L__BB11_82:
L_BB11_82:;
  // PTX:837 fma.rn.f32 %f655, %f125, %f134, %f655
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f655) : "f"(f125), "f"(f134), "f"(f655));
  // PTX:838 fma.rn.f32 %f656, %f126, %f134, %f656
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f656) : "f"(f126), "f"(f134), "f"(f656));
  // PTX:839 fma.rn.f32 %f657, %f127, %f134, %f657
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f657) : "f"(f127), "f"(f134), "f"(f657));
  // PTX:840 mul.f32 %f496, %f134, %f134
  asm("mul.f32 %0, %1, %2;" : "=f"(f496) : "f"(f134), "f"(f134));
  // PTX:841 fma.rn.f32 %f637, %f128, %f496, %f637
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f637) : "f"(f128), "f"(f496), "f"(f637));
  // PTX:842 fma.rn.f32 %f638, %f496, %f129, %f638
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f638) : "f"(f496), "f"(f129), "f"(f638));
  // PTX:843 fma.rn.f32 %f639, %f496, %f130, %f639
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f639) : "f"(f496), "f"(f130), "f"(f639));
  // PTX:844 fma.rn.f32 %f640, %f496, %f129, %f640
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f640) : "f"(f496), "f"(f129), "f"(f640));
  // PTX:845 fma.rn.f32 %f641, %f496, %f131, %f641
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f641) : "f"(f496), "f"(f131), "f"(f641));
  // PTX:846 fma.rn.f32 %f642, %f496, %f132, %f642
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f642) : "f"(f496), "f"(f132), "f"(f642));
  // PTX:847 fma.rn.f32 %f643, %f496, %f130, %f643
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f643) : "f"(f496), "f"(f130), "f"(f643));
  // PTX:848 fma.rn.f32 %f644, %f496, %f132, %f644
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f644) : "f"(f496), "f"(f132), "f"(f644));
  // PTX:849 fma.rn.f32 %f645, %f496, %f133, %f645
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f645) : "f"(f496), "f"(f133), "f"(f645));
  // PTX:850 fma.rn.f32 %f658, %f125, %f135, %f658
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f658) : "f"(f125), "f"(f135), "f"(f658));
  // PTX:851 fma.rn.f32 %f659, %f126, %f135, %f659
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f659) : "f"(f126), "f"(f135), "f"(f659));
  // PTX:852 fma.rn.f32 %f660, %f127, %f135, %f660
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f660) : "f"(f127), "f"(f135), "f"(f660));
  // PTX:853 mul.f32 %f497, %f135, %f135
  asm("mul.f32 %0, %1, %2;" : "=f"(f497) : "f"(f135), "f"(f135));
  // PTX:854 fma.rn.f32 %f646, %f128, %f497, %f646
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f646) : "f"(f128), "f"(f497), "f"(f646));
  // PTX:855 fma.rn.f32 %f647, %f497, %f129, %f647
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f647) : "f"(f497), "f"(f129), "f"(f647));
  // PTX:856 fma.rn.f32 %f648, %f497, %f130, %f648
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f648) : "f"(f497), "f"(f130), "f"(f648));
  // PTX:857 fma.rn.f32 %f649, %f497, %f129, %f649
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f649) : "f"(f497), "f"(f129), "f"(f649));
  // PTX:858 fma.rn.f32 %f650, %f497, %f131, %f650
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f650) : "f"(f497), "f"(f131), "f"(f650));
  // PTX:859 fma.rn.f32 %f651, %f497, %f132, %f651
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f651) : "f"(f497), "f"(f132), "f"(f651));
  // PTX:860 fma.rn.f32 %f652, %f497, %f130, %f652
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f652) : "f"(f497), "f"(f130), "f"(f652));
  // PTX:861 fma.rn.f32 %f653, %f497, %f132, %f653
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f653) : "f"(f497), "f"(f132), "f"(f653));
  // PTX:862 fma.rn.f32 %f654, %f497, %f133, %f654
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f654) : "f"(f497), "f"(f133), "f"(f654));
  // PTX:863 mul.lo.s64 %rd86, %rd22, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd86) : "l"(rd22));
  // PTX:864 add.s64 %rd87, %rd2, %rd86
  asm("add.s64 %0, %1, %2;" : "=l"(rd87) : "l"(rd2), "l"(rd86));
  // PTX:865 mul.f32 %f498, %f125, %f636
  asm("mul.f32 %0, %1, %2;" : "=f"(f498) : "f"(f125), "f"(f636));
  // PTX:866 red.global.add.f32 [%rd87], %f498
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (0)))), (float)(f498));
  // PTX:867 add.s64 %rd88, %rd87, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd88) : "l"(rd87));
  // PTX:868 mul.f32 %f500, %f126, %f636
  asm("mul.f32 %0, %1, %2;" : "=f"(f500) : "f"(f126), "f"(f636));
  // PTX:869 red.global.add.f32 [%rd88], %f500
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (0)))), (float)(f500));
  // PTX:870 add.s64 %rd89, %rd87, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd89) : "l"(rd87));
  // PTX:871 mul.f32 %f502, %f127, %f636
  asm("mul.f32 %0, %1, %2;" : "=f"(f502) : "f"(f127), "f"(f636));
  // PTX:872 red.global.add.f32 [%rd89], %f502
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (0)))), (float)(f502));
  // PTX:873 mul.f32 %f504, %f663, %f663
  asm("mul.f32 %0, %1, %2;" : "=f"(f504) : "f"(f663), "f"(f663));
  // PTX:874 mul.f32 %f505, %f504, %f128
  asm("mul.f32 %0, %1, %2;" : "=f"(f505) : "f"(f504), "f"(f128));
  // PTX:875 mul.f32 %f506, %f504, %f129
  asm("mul.f32 %0, %1, %2;" : "=f"(f506) : "f"(f504), "f"(f129));
  // PTX:876 mul.f32 %f507, %f504, %f130
  asm("mul.f32 %0, %1, %2;" : "=f"(f507) : "f"(f504), "f"(f130));
  // PTX:877 mul.f32 %f508, %f504, %f131
  asm("mul.f32 %0, %1, %2;" : "=f"(f508) : "f"(f504), "f"(f131));
  // PTX:878 mul.f32 %f509, %f504, %f132
  asm("mul.f32 %0, %1, %2;" : "=f"(f509) : "f"(f504), "f"(f132));
  // PTX:879 mul.f32 %f510, %f504, %f133
  asm("mul.f32 %0, %1, %2;" : "=f"(f510) : "f"(f504), "f"(f133));
  // PTX:880 mul.lo.s64 %rd90, %rd22, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd90) : "l"(rd22));
  // PTX:881 add.s64 %rd91, %rd1, %rd90
  asm("add.s64 %0, %1, %2;" : "=l"(rd91) : "l"(rd1), "l"(rd90));
  // PTX:882 red.global.add.f32 [%rd91], %f505
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (0)))), (float)(f505));
  // PTX:883 add.s64 %rd92, %rd91, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd92) : "l"(rd91));
  // PTX:884 red.global.add.f32 [%rd92], %f506
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (0)))), (float)(f506));
  // PTX:885 add.s64 %rd93, %rd91, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd93) : "l"(rd91));
  // PTX:886 red.global.add.f32 [%rd93], %f507
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (0)))), (float)(f507));
  // PTX:887 add.s64 %rd94, %rd91, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd94) : "l"(rd91));
  // PTX:888 red.global.add.f32 [%rd94], %f506
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd94) + (0)))), (float)(f506));
  // PTX:889 add.s64 %rd95, %rd91, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd95) : "l"(rd91));
  // PTX:890 red.global.add.f32 [%rd95], %f508
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd95) + (0)))), (float)(f508));
  // PTX:891 add.s64 %rd96, %rd91, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd96) : "l"(rd91));
  // PTX:892 red.global.add.f32 [%rd96], %f509
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (0)))), (float)(f509));
  // PTX:893 add.s64 %rd97, %rd91, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd97) : "l"(rd91));
  // PTX:894 red.global.add.f32 [%rd97], %f507
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd97) + (0)))), (float)(f507));
  // PTX:895 add.s64 %rd98, %rd91, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd98) : "l"(rd91));
  // PTX:896 red.global.add.f32 [%rd98], %f509
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (0)))), (float)(f509));
  // PTX:897 add.s64 %rd99, %rd91, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd99) : "l"(rd91));
  // PTX:898 red.global.add.f32 [%rd99], %f510
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (0)))), (float)(f510));
  // PTX:899 mul.lo.s64 %rd100, %rd23, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd100) : "l"(rd23));
  // PTX:900 add.s64 %rd101, %rd2, %rd100
  asm("add.s64 %0, %1, %2;" : "=l"(rd101) : "l"(rd2), "l"(rd100));
  // PTX:901 mul.f32 %f520, %f125, %f635
  asm("mul.f32 %0, %1, %2;" : "=f"(f520) : "f"(f125), "f"(f635));
  // PTX:902 red.global.add.f32 [%rd101], %f520
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd101) + (0)))), (float)(f520));
  // PTX:903 add.s64 %rd102, %rd101, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd102) : "l"(rd101));
  // PTX:904 mul.f32 %f522, %f126, %f635
  asm("mul.f32 %0, %1, %2;" : "=f"(f522) : "f"(f126), "f"(f635));
  // PTX:905 red.global.add.f32 [%rd102], %f522
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd102) + (0)))), (float)(f522));
  // PTX:906 add.s64 %rd103, %rd101, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd103) : "l"(rd101));
  // PTX:907 mul.f32 %f524, %f127, %f635
  asm("mul.f32 %0, %1, %2;" : "=f"(f524) : "f"(f127), "f"(f635));
  // PTX:908 red.global.add.f32 [%rd103], %f524
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd103) + (0)))), (float)(f524));
  // PTX:909 mul.f32 %f526, %f662, %f662
  asm("mul.f32 %0, %1, %2;" : "=f"(f526) : "f"(f662), "f"(f662));
  // PTX:910 mul.f32 %f527, %f526, %f128
  asm("mul.f32 %0, %1, %2;" : "=f"(f527) : "f"(f526), "f"(f128));
  // PTX:911 mul.f32 %f528, %f526, %f129
  asm("mul.f32 %0, %1, %2;" : "=f"(f528) : "f"(f526), "f"(f129));
  // PTX:912 mul.f32 %f529, %f526, %f130
  asm("mul.f32 %0, %1, %2;" : "=f"(f529) : "f"(f526), "f"(f130));
  // PTX:913 mul.f32 %f530, %f526, %f131
  asm("mul.f32 %0, %1, %2;" : "=f"(f530) : "f"(f526), "f"(f131));
  // PTX:914 mul.f32 %f531, %f526, %f132
  asm("mul.f32 %0, %1, %2;" : "=f"(f531) : "f"(f526), "f"(f132));
  // PTX:915 mul.f32 %f532, %f526, %f133
  asm("mul.f32 %0, %1, %2;" : "=f"(f532) : "f"(f526), "f"(f133));
  // PTX:916 mul.lo.s64 %rd104, %rd23, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd104) : "l"(rd23));
  // PTX:917 add.s64 %rd105, %rd1, %rd104
  asm("add.s64 %0, %1, %2;" : "=l"(rd105) : "l"(rd1), "l"(rd104));
  // PTX:918 red.global.add.f32 [%rd105], %f527
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (0)))), (float)(f527));
  // PTX:919 add.s64 %rd106, %rd105, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd106) : "l"(rd105));
  // PTX:920 red.global.add.f32 [%rd106], %f528
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (0)))), (float)(f528));
  // PTX:921 add.s64 %rd107, %rd105, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd107) : "l"(rd105));
  // PTX:922 red.global.add.f32 [%rd107], %f529
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd107) + (0)))), (float)(f529));
  // PTX:923 add.s64 %rd108, %rd105, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd108) : "l"(rd105));
  // PTX:924 red.global.add.f32 [%rd108], %f528
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd108) + (0)))), (float)(f528));
  // PTX:925 add.s64 %rd109, %rd105, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd109) : "l"(rd105));
  // PTX:926 red.global.add.f32 [%rd109], %f530
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd109) + (0)))), (float)(f530));
  // PTX:927 add.s64 %rd110, %rd105, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd110) : "l"(rd105));
  // PTX:928 red.global.add.f32 [%rd110], %f531
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd110) + (0)))), (float)(f531));
  // PTX:929 add.s64 %rd111, %rd105, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd111) : "l"(rd105));
  // PTX:930 red.global.add.f32 [%rd111], %f529
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd111) + (0)))), (float)(f529));
  // PTX:931 add.s64 %rd112, %rd105, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd112) : "l"(rd105));
  // PTX:932 red.global.add.f32 [%rd112], %f531
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd112) + (0)))), (float)(f531));
  // PTX:933 add.s64 %rd113, %rd105, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd113) : "l"(rd105));
  // PTX:934 red.global.add.f32 [%rd113], %f532
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd113) + (0)))), (float)(f532));
  // PTX:935 mul.lo.s64 %rd114, %rd24, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd114) : "l"(rd24));
  // PTX:936 add.s64 %rd115, %rd2, %rd114
  asm("add.s64 %0, %1, %2;" : "=l"(rd115) : "l"(rd2), "l"(rd114));
  // PTX:937 mul.f32 %f542, %f125, %f634
  asm("mul.f32 %0, %1, %2;" : "=f"(f542) : "f"(f125), "f"(f634));
  // PTX:938 red.global.add.f32 [%rd115], %f542
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd115) + (0)))), (float)(f542));
  // PTX:939 add.s64 %rd116, %rd115, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd116) : "l"(rd115));
  // PTX:940 mul.f32 %f544, %f126, %f634
  asm("mul.f32 %0, %1, %2;" : "=f"(f544) : "f"(f126), "f"(f634));
  // PTX:941 red.global.add.f32 [%rd116], %f544
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd116) + (0)))), (float)(f544));
  // PTX:942 add.s64 %rd117, %rd115, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd117) : "l"(rd115));
  // PTX:943 mul.f32 %f546, %f127, %f634
  asm("mul.f32 %0, %1, %2;" : "=f"(f546) : "f"(f127), "f"(f634));
  // PTX:944 red.global.add.f32 [%rd117], %f546
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd117) + (0)))), (float)(f546));
  // PTX:945 mul.f32 %f548, %f661, %f661
  asm("mul.f32 %0, %1, %2;" : "=f"(f548) : "f"(f661), "f"(f661));
  // PTX:946 mul.f32 %f549, %f548, %f128
  asm("mul.f32 %0, %1, %2;" : "=f"(f549) : "f"(f548), "f"(f128));
  // PTX:947 mul.f32 %f550, %f548, %f129
  asm("mul.f32 %0, %1, %2;" : "=f"(f550) : "f"(f548), "f"(f129));
  // PTX:948 mul.f32 %f551, %f548, %f130
  asm("mul.f32 %0, %1, %2;" : "=f"(f551) : "f"(f548), "f"(f130));
  // PTX:949 mul.f32 %f552, %f548, %f131
  asm("mul.f32 %0, %1, %2;" : "=f"(f552) : "f"(f548), "f"(f131));
  // PTX:950 mul.f32 %f553, %f548, %f132
  asm("mul.f32 %0, %1, %2;" : "=f"(f553) : "f"(f548), "f"(f132));
  // PTX:951 mul.f32 %f554, %f548, %f133
  asm("mul.f32 %0, %1, %2;" : "=f"(f554) : "f"(f548), "f"(f133));
  // PTX:952 mul.lo.s64 %rd118, %rd24, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd118) : "l"(rd24));
  // PTX:953 add.s64 %rd119, %rd1, %rd118
  asm("add.s64 %0, %1, %2;" : "=l"(rd119) : "l"(rd1), "l"(rd118));
  // PTX:954 red.global.add.f32 [%rd119], %f549
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd119) + (0)))), (float)(f549));
  // PTX:955 add.s64 %rd120, %rd119, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd120) : "l"(rd119));
  // PTX:956 red.global.add.f32 [%rd120], %f550
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd120) + (0)))), (float)(f550));
  // PTX:957 add.s64 %rd121, %rd119, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd121) : "l"(rd119));
  // PTX:958 red.global.add.f32 [%rd121], %f551
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd121) + (0)))), (float)(f551));
  // PTX:959 add.s64 %rd122, %rd119, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd122) : "l"(rd119));
  // PTX:960 red.global.add.f32 [%rd122], %f550
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd122) + (0)))), (float)(f550));
  // PTX:961 add.s64 %rd123, %rd119, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd123) : "l"(rd119));
  // PTX:962 red.global.add.f32 [%rd123], %f552
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd123) + (0)))), (float)(f552));
  // PTX:963 add.s64 %rd124, %rd119, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd124) : "l"(rd119));
  // PTX:964 red.global.add.f32 [%rd124], %f553
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd124) + (0)))), (float)(f553));
  // PTX:965 add.s64 %rd125, %rd119, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd125) : "l"(rd119));
  // PTX:966 red.global.add.f32 [%rd125], %f551
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd125) + (0)))), (float)(f551));
  // PTX:967 add.s64 %rd126, %rd119, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd126) : "l"(rd119));
  // PTX:968 red.global.add.f32 [%rd126], %f553
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd126) + (0)))), (float)(f553));
  // PTX:969 add.s64 %rd127, %rd119, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd127) : "l"(rd119));
  // PTX:970 red.global.add.f32 [%rd127], %f554
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd127) + (0)))), (float)(f554));
  // PTX:971 ld.global.u32 %r110, [%rd14]
  r110 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:973 $L__BB11_83:
L_BB11_83:;
  // PTX:974 add.s32 %r96, %r96, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r96) : "r"(r96));
  // PTX:975 setp.lt.s32 %p102, %r96, %r110
  p102 = (((int)(r96)) < ((int)(r110)));
  // PTX:976 @%p102 bra $L__BB11_17
  if (p102) { goto L_BB11_17; }
  // PTX:978 $L__BB11_84:
L_BB11_84:;
  // PTX:979 ld.param.u64 %rd160, [_ZN7synreal21self_collision_kernel20accumulate_edge_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiSB_PKNS2_ILi3EiLS3_0EEESB_SB_PKfffPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_16]
  rd160 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param16 + (0))));
  // PTX:980 mul.lo.s64 %rd159, %rd161, %rd160
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd159) : "l"(rd161), "l"(rd160));
  // PTX:981 cvt.u32.u64 %r91, %rd159
  asm("cvt.u32.u64 %0, %1;" : "=r"(r91) : "l"(rd159));
  // PTX:982 add.s32 %r90, %r2, %r91
  asm("add.s32 %0, %1, %2;" : "=r"(r90) : "r"(r2), "r"(r91));
  // PTX:983 cvt.s64.s32 %rd158, %r90
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd158) : "r"(r90));
  // PTX:984 add.s32 %r89, %r4, %r91
  asm("add.s32 %0, %1, %2;" : "=r"(r89) : "r"(r4), "r"(r91));
  // PTX:985 cvt.s64.s32 %rd157, %r89
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd157) : "r"(r89));
  // PTX:986 mul.lo.s64 %rd128, %rd158, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd128) : "l"(rd158));
  // PTX:987 add.s64 %rd129, %rd2, %rd128
  asm("add.s64 %0, %1, %2;" : "=l"(rd129) : "l"(rd2), "l"(rd128));
  // PTX:988 red.global.add.f32 [%rd129], %f655
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd129) + (0)))), (float)(f655));
  // PTX:989 add.s64 %rd130, %rd129, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd130) : "l"(rd129));
  // PTX:990 red.global.add.f32 [%rd130], %f656
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd130) + (0)))), (float)(f656));
  // PTX:991 add.s64 %rd131, %rd129, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd131) : "l"(rd129));
  // PTX:992 red.global.add.f32 [%rd131], %f657
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd131) + (0)))), (float)(f657));
  // PTX:993 mul.lo.s64 %rd132, %rd158, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd132) : "l"(rd158));
  // PTX:994 add.s64 %rd133, %rd1, %rd132
  asm("add.s64 %0, %1, %2;" : "=l"(rd133) : "l"(rd1), "l"(rd132));
  // PTX:995 red.global.add.f32 [%rd133], %f637
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd133) + (0)))), (float)(f637));
  // PTX:996 add.s64 %rd134, %rd133, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd134) : "l"(rd133));
  // PTX:997 red.global.add.f32 [%rd134], %f638
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd134) + (0)))), (float)(f638));
  // PTX:998 add.s64 %rd135, %rd133, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd135) : "l"(rd133));
  // PTX:999 red.global.add.f32 [%rd135], %f639
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd135) + (0)))), (float)(f639));
  // PTX:1000 add.s64 %rd136, %rd133, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd136) : "l"(rd133));
  // PTX:1001 red.global.add.f32 [%rd136], %f640
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd136) + (0)))), (float)(f640));
  // PTX:1002 add.s64 %rd137, %rd133, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd137) : "l"(rd133));
  // PTX:1003 red.global.add.f32 [%rd137], %f641
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd137) + (0)))), (float)(f641));
  // PTX:1004 add.s64 %rd138, %rd133, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd138) : "l"(rd133));
  // PTX:1005 red.global.add.f32 [%rd138], %f642
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd138) + (0)))), (float)(f642));
  // PTX:1006 add.s64 %rd139, %rd133, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd139) : "l"(rd133));
  // PTX:1007 red.global.add.f32 [%rd139], %f643
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd139) + (0)))), (float)(f643));
  // PTX:1008 add.s64 %rd140, %rd133, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd140) : "l"(rd133));
  // PTX:1009 red.global.add.f32 [%rd140], %f644
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd140) + (0)))), (float)(f644));
  // PTX:1010 add.s64 %rd141, %rd133, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd141) : "l"(rd133));
  // PTX:1011 red.global.add.f32 [%rd141], %f645
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd141) + (0)))), (float)(f645));
  // PTX:1012 mul.lo.s64 %rd142, %rd157, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd142) : "l"(rd157));
  // PTX:1013 add.s64 %rd143, %rd2, %rd142
  asm("add.s64 %0, %1, %2;" : "=l"(rd143) : "l"(rd2), "l"(rd142));
  // PTX:1014 red.global.add.f32 [%rd143], %f658
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd143) + (0)))), (float)(f658));
  // PTX:1015 add.s64 %rd144, %rd143, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd144) : "l"(rd143));
  // PTX:1016 red.global.add.f32 [%rd144], %f659
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd144) + (0)))), (float)(f659));
  // PTX:1017 add.s64 %rd145, %rd143, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd145) : "l"(rd143));
  // PTX:1018 red.global.add.f32 [%rd145], %f660
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd145) + (0)))), (float)(f660));
  // PTX:1019 mul.lo.s64 %rd146, %rd157, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd146) : "l"(rd157));
  // PTX:1020 add.s64 %rd147, %rd1, %rd146
  asm("add.s64 %0, %1, %2;" : "=l"(rd147) : "l"(rd1), "l"(rd146));
  // PTX:1021 red.global.add.f32 [%rd147], %f646
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd147) + (0)))), (float)(f646));
  // PTX:1022 add.s64 %rd148, %rd147, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd148) : "l"(rd147));
  // PTX:1023 red.global.add.f32 [%rd148], %f647
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd148) + (0)))), (float)(f647));
  // PTX:1024 add.s64 %rd149, %rd147, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd149) : "l"(rd147));
  // PTX:1025 red.global.add.f32 [%rd149], %f648
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd149) + (0)))), (float)(f648));
  // PTX:1026 add.s64 %rd150, %rd147, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd150) : "l"(rd147));
  // PTX:1027 red.global.add.f32 [%rd150], %f649
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd150) + (0)))), (float)(f649));
  // PTX:1028 add.s64 %rd151, %rd147, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd151) : "l"(rd147));
  // PTX:1029 red.global.add.f32 [%rd151], %f650
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd151) + (0)))), (float)(f650));
  // PTX:1030 add.s64 %rd152, %rd147, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd152) : "l"(rd147));
  // PTX:1031 red.global.add.f32 [%rd152], %f651
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd152) + (0)))), (float)(f651));
  // PTX:1032 add.s64 %rd153, %rd147, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd153) : "l"(rd147));
  // PTX:1033 red.global.add.f32 [%rd153], %f652
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd153) + (0)))), (float)(f652));
  // PTX:1034 add.s64 %rd154, %rd147, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd154) : "l"(rd147));
  // PTX:1035 red.global.add.f32 [%rd154], %f653
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd154) + (0)))), (float)(f653));
  // PTX:1036 add.s64 %rd155, %rd147, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd155) : "l"(rd147));
  // PTX:1037 red.global.add.f32 [%rd155], %f654
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd155) + (0)))), (float)(f654));
  // PTX:1039 $L__BB11_85:
L_BB11_85:;
  // PTX:1040 ret
  return;
}
