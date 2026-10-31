// 机械还原自 PTX：synreal::kernel::evaluate_angular_limits(synreal::kernel::JointCoordinateView, synreal::kernel::AngularLimitView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, int const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)
// PTX SHA256: fe845ad30ff1093096549be3c94582b90a99a0c78464b6a297f53dc442f213a7
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__evaluate_angular_limits(ByVal<120, 8> param0, ByVal<32, 8> param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, float param6, unsigned long long param7, unsigned long long param8, unsigned long long param9) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57, p58, p59, p60, p61, p62, p63, p64;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440, f441, f442, f443, f444, f445, f446, f447, f448, f449, f450, f451, f452, f453, f454, f455, f456, f457, f458, f459, f460, f461, f462, f463, f464, f465, f466, f467, f468, f469, f470, f471, f472, f473, f474, f475, f476, f477, f478, f479, f480, f481, f482, f483, f484, f485, f486, f487, f488, f489, f490, f491, f492, f493, f494, f495, f496, f497, f498, f499, f500, f501, f502, f503, f504, f505, f506, f507, f508, f509, f510, f511, f512, f513, f514, f515, f516, f517, f518, f519, f520, f521, f522, f523, f524, f525, f526, f527, f528, f529, f530, f531, f532, f533, f534, f535, f536, f537, f538, f539, f540, f541, f542, f543, f544, f545, f546, f547, f548, f549, f550, f551, f552, f553, f554, f555, f556, f557, f558, f559, f560, f561, f562, f563, f564, f565, f566, f567, f568, f569, f570, f571, f572, f573, f574, f575, f576, f577, f578, f579, f580, f581, f582, f583, f584, f585, f586, f587, f588, f589, f590, f591, f592, f593, f594, f595, f596, f597, f598, f599, f600, f601, f602, f603, f604, f605, f606, f607, f608, f609, f610, f611, f612, f613, f614, f615, f616, f617, f618, f619, f620, f621, f622, f623, f624, f625, f626, f627, f628, f629, f630, f631, f632, f633, f634, f635, f636, f637, f638, f639, f640, f641, f642, f643, f644, f645, f646, f647, f648, f649, f650, f651, f652, f653, f654, f655, f656, f657, f658, f659, f660, f661, f662, f663, f664, f665, f666, f667, f668, f669, f670, f671, f672, f673, f674, f675, f676, f677, f678, f679, f680, f681, f682, f683, f684, f685, f686, f687, f688, f689, f690, f691, f692, f693, f694, f695, f696, f697, f698, f699, f700, f701, f702, f703, f704, f705, f706, f707, f708, f709, f710, f711, f712, f713, f714, f715, f716, f717, f718, f719, f720, f721, f722, f723, f724, f725, f726, f727, f728, f729, f730, f731, f732, f733, f734, f735, f736, f737, f738, f739, f740, f741, f742, f743, f744, f745, f746, f747, f748, f749, f750, f751, f752, f753, f754, f755, f756, f757, f758, f759, f760, f761, f762, f763, f764, f765, f766, f767, f768, f769, f770, f771, f772, f773, f774, f775, f776, f777, f778, f779, f780, f781, f782, f783, f784, f785, f786, f787, f788, f789, f790, f791, f792, f793, f794, f795, f796, f797, f798, f799, f800, f801, f802, f803, f804, f805, f806, f807, f808, f809, f810, f811, f812, f813, f814, f815, f816, f817, f818, f819, f820, f821, f822, f823, f824, f825, f826, f827, f828, f829, f830, f831, f832, f833, f834, f835, f836, f837, f838, f839, f840, f841, f842, f843, f844, f845, f846, f847, f848, f849, f850, f851, f852, f853, f854, f855, f856, f857, f858, f859, f860, f861, f862, f863, f864, f865, f866, f867, f868, f869, f870, f871, f872, f873, f874, f875, f876, f877, f878, f879, f880, f881, f882, f883, f884, f885, f886, f887, f888, f889, f890, f891, f892, f893, f894, f895, f896, f897, f898, f899, f900, f901, f902, f903, f904, f905, f906, f907, f908, f909;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135, rd136, rd137, rd138, rd139, rd140, rd141, rd142, rd143, rd144, rd145, rd146, rd147, rd148, rd149, rd150, rd151, rd152, rd153, rd154, rd155, rd156, rd157, rd158, rd159, rd160, rd161, rd162, rd163, rd164, rd165, rd166, rd167, rd168, rd169, rd170, rd171, rd172, rd173, rd174, rd175, rd176, rd177, rd178, rd179, rd180, rd181, rd182, rd183, rd184, rd185, rd186, rd187, rd188, rd189, rd190, rd191, rd192, rd193, rd194, rd195, rd196, rd197, rd198, rd199, rd200, rd201, rd202, rd203, rd204, rd205, rd206, rd207, rd208, rd209, rd210, rd211, rd212, rd213, rd214, rd215, rd216, rd217, rd218, rd219, rd220, rd221, rd222, rd223, rd224, rd225, rd226, rd227, rd228, rd229, rd230, rd231, rd232, rd233, rd234, rd235, rd236, rd237, rd238, rd239, rd240, rd241, rd242, rd243, rd244, rd245, rd246, rd247, rd248, rd249, rd250, rd251, rd252, rd253, rd254, rd255, rd256, rd257, rd258, rd259, rd260, rd261, rd262, rd263, rd264, rd265, rd266, rd267, rd268, rd269, rd270, rd271, rd272, rd273, rd274, rd275, rd276, rd277, rd278, rd279, rd280, rd281, rd282, rd283, rd284, rd285, rd286, rd287, rd288, rd289, rd290, rd291, rd292, rd293, rd294, rd295, rd296, rd297, rd298, rd299, rd300, rd301, rd302, rd303, rd304, rd305, rd306, rd307, rd308, rd309, rd310, rd311, rd312, rd313, rd314, rd315, rd316, rd317, rd318, rd319, rd320;
  // PTX:26 ld.param.u64 %rd55, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_2]
  rd55 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:27 ld.param.u64 %rd53, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_7]
  rd53 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:28 ld.param.u64 %rd54, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_9]
  rd54 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:29 ld.param.u64 %rd50, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_1+24]
  rd50 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (24))));
  // PTX:30 ld.param.u64 %rd49, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_1+16]
  rd49 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (16))));
  // PTX:31 ld.param.u64 %rd46, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_0+112]
  rd46 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (112))));
  // PTX:32 ld.param.u64 %rd45, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_0+104]
  rd45 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (104))));
  // PTX:33 ld.param.u64 %rd44, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_0+96]
  rd44 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (96))));
  // PTX:34 ld.param.u64 %rd43, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_0+88]
  rd43 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (88))));
  // PTX:35 ld.param.u64 %rd41, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_0+72]
  rd41 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (72))));
  // PTX:36 ld.param.u64 %rd40, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_0+64]
  rd40 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (64))));
  // PTX:37 ld.param.u64 %rd39, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_0+56]
  rd39 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (56))));
  // PTX:38 ld.param.u64 %rd38, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_0+48]
  rd38 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (48))));
  // PTX:39 ld.param.u64 %rd37, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_0+40]
  rd37 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (40))));
  // PTX:40 ld.param.u64 %rd36, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_0+32]
  rd36 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (32))));
  // PTX:41 ld.param.u64 %rd35, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_0+24]
  rd35 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (24))));
  // PTX:42 ld.param.u64 %rd34, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_0+16]
  rd34 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (16))));
  // PTX:43 ld.param.u64 %rd33, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_0+8]
  rd33 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (8))));
  // PTX:44 ld.param.u64 %rd32, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_0]
  rd32 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:45 cvta.to.global.u64 %rd1, %rd54
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd54));
  // PTX:46 cvta.to.global.u64 %rd3, %rd53
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd53));
  // PTX:47 cvta.to.global.u64 %rd5, %rd55
  rd5 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd55));
  // PTX:48 mov.u32 %r21, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r21) : "r"(blockIdx.x));
  // PTX:49 mov.u32 %r22, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r22) : "r"(blockDim.x));
  // PTX:50 mul.wide.u32 %rd58, %r21, %r22
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd58) : "r"(r21), "r"(r22));
  // PTX:51 mov.u32 %r23, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r23) : "r"(threadIdx.x));
  // PTX:52 cvt.u64.u32 %rd59, %r23
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd59) : "r"(r23));
  // PTX:53 add.s64 %rd6, %rd58, %rd59
  asm("add.s64 %0, %1, %2;" : "=l"(rd6) : "l"(rd58), "l"(rd59));
  // PTX:54 setp.ge.u64 %p1, %rd6, %rd45
  p1 = (((unsigned long long)(rd6)) >= ((unsigned long long)(rd45)));
  // PTX:55 @%p1 bra $L__BB70_68
  if (p1) { goto L_BB70_68; }
  // PTX:57 or.b64 %rd60, %rd6, %rd44
  asm("or.b64 %0, %1, %2;" : "=l"(rd60) : "l"(rd6), "l"(rd44));
  // PTX:58 and.b64 %rd61, %rd60, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd61) : "l"(rd60));
  // PTX:59 setp.eq.s64 %p2, %rd61, 0
  p2 = (((long long)(rd61)) == ((long long)(0)));
  // PTX:60 @%p2 bra $L__BB70_3
  if (p2) { goto L_BB70_3; }
  // PTX:62 rem.u64 %rd315, %rd6, %rd44
  asm("rem.u64 %0, %1, %2;" : "=l"(rd315) : "l"(rd6), "l"(rd44));
  // PTX:63 bra.uni $L__BB70_4
  goto L_BB70_4;
  // PTX:65 $L__BB70_3:
L_BB70_3:;
  // PTX:66 cvt.u32.u64 %r24, %rd44
  asm("cvt.u32.u64 %0, %1;" : "=r"(r24) : "l"(rd44));
  // PTX:67 cvt.u32.u64 %r25, %rd6
  asm("cvt.u32.u64 %0, %1;" : "=r"(r25) : "l"(rd6));
  // PTX:68 rem.u32 %r26, %r25, %r24
  asm("rem.u32 %0, %1, %2;" : "=r"(r26) : "r"(r25), "r"(r24));
  // PTX:69 cvt.u64.u32 %rd315, %r26
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd315) : "r"(r26));
  // PTX:71 $L__BB70_4:
L_BB70_4:;
  // PTX:72 cvta.to.global.u64 %rd62, %rd33
  rd62 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd33));
  // PTX:73 shl.b64 %rd63, %rd315, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd63) : "l"(rd315));
  // PTX:74 add.s64 %rd64, %rd62, %rd63
  asm("add.s64 %0, %1, %2;" : "=l"(rd64) : "l"(rd62), "l"(rd63));
  // PTX:75 ld.global.u32 %r27, [%rd64]
  r27 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (0)))));
  // PTX:76 setp.ne.s32 %p3, %r27, 1
  p3 = (((int)(r27)) != ((int)(1)));
  // PTX:77 @%p3 bra $L__BB70_68
  if (p3) { goto L_BB70_68; }
  // PTX:79 cvta.to.global.u64 %rd65, %rd43
  rd65 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd43));
  // PTX:80 add.s64 %rd67, %rd65, %rd63
  asm("add.s64 %0, %1, %2;" : "=l"(rd67) : "l"(rd65), "l"(rd63));
  // PTX:81 ld.global.u32 %r28, [%rd67]
  r28 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0)))));
  // PTX:82 cvt.s64.s32 %rd11, %r28
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd11) : "r"(r28));
  // PTX:83 cvta.to.global.u64 %rd68, %rd49
  rd68 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd49));
  // PTX:84 mul.wide.s32 %rd69, %r28, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd69) : "r"(r28));
  // PTX:85 add.s64 %rd70, %rd68, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd70) : "l"(rd68), "l"(rd69));
  // PTX:86 cvta.to.global.u64 %rd71, %rd50
  rd71 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd50));
  // PTX:87 add.s64 %rd72, %rd71, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd72) : "l"(rd71), "l"(rd69));
  // PTX:88 ld.global.f32 %f1, [%rd70]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0)))));
  // PTX:89 setp.eq.f32 %p4, %f1, 0f00000000
  p4 = (!(isnan(((float)(f1))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f1)) == ((float)(as_f32(0x00000000u)))));
  // PTX:90 ld.global.f32 %f2, [%rd72]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (0)))));
  // PTX:91 setp.eq.f32 %p5, %f2, 0f00000000
  p5 = (!(isnan(((float)(f2))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f2)) == ((float)(as_f32(0x00000000u)))));
  // PTX:92 and.pred %p6, %p4, %p5
  p6 = ((p4) && (p5));
  // PTX:93 @%p6 bra $L__BB70_68
  if (p6) { goto L_BB70_68; }
  // PTX:95 @%p2 bra $L__BB70_8
  if (p2) { goto L_BB70_8; }
  // PTX:97 div.u64 %rd316, %rd6, %rd44
  asm("div.u64 %0, %1, %2;" : "=l"(rd316) : "l"(rd6), "l"(rd44));
  // PTX:98 bra.uni $L__BB70_9
  goto L_BB70_9;
  // PTX:100 $L__BB70_8:
L_BB70_8:;
  // PTX:101 cvt.u32.u64 %r29, %rd44
  asm("cvt.u32.u64 %0, %1;" : "=r"(r29) : "l"(rd44));
  // PTX:102 cvt.u32.u64 %r30, %rd6
  asm("cvt.u32.u64 %0, %1;" : "=r"(r30) : "l"(rd6));
  // PTX:103 div.u32 %r31, %r30, %r29
  asm("div.u32 %0, %1, %2;" : "=r"(r31) : "r"(r30), "r"(r29));
  // PTX:104 cvt.u64.u32 %rd316, %r31
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd316) : "r"(r31));
  // PTX:106 $L__BB70_9:
L_BB70_9:;
  // PTX:107 cvta.to.global.u64 %rd79, %rd32
  rd79 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd32));
  // PTX:108 mul.lo.s64 %rd80, %rd316, %rd46
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd80) : "l"(rd316), "l"(rd46));
  // PTX:109 cvt.u32.u64 %r1, %rd80
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd80));
  // PTX:110 cvta.to.global.u64 %rd81, %rd34
  rd81 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd34));
  // PTX:111 shl.b64 %rd82, %rd315, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd82) : "l"(rd315));
  // PTX:112 add.s64 %rd83, %rd81, %rd82
  asm("add.s64 %0, %1, %2;" : "=l"(rd83) : "l"(rd81), "l"(rd82));
  // PTX:113 ld.global.u32 %r32, [%rd83]
  r32 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (0)))));
  // PTX:114 mov.u64 %rd317, 0
  asm("mov.u64 %0, 0;" : "=l"(rd317) : );
  // PTX:115 ld.global.u32 %r33, [%rd83+4]
  r33 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (4)))));
  // PTX:116 mul.wide.s32 %rd84, %r33, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd84) : "r"(r33));
  // PTX:117 add.s64 %rd85, %rd79, %rd84
  asm("add.s64 %0, %1, %2;" : "=l"(rd85) : "l"(rd79), "l"(rd84));
  // PTX:118 ld.global.u32 %r2, [%rd85]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (0)))));
  // PTX:119 ld.global.u32 %r3, [%rd85+4]
  r3 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (4)))));
  // PTX:120 ld.global.u32 %r4, [%rd85+8]
  r4 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (8)))));
  // PTX:121 ld.global.u32 %r5, [%rd85+12]
  r5 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (12)))));
  // PTX:122 cvta.to.global.u64 %rd86, %rd35
  rd86 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd35));
  // PTX:123 mul.lo.s64 %rd87, %rd315, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd87) : "l"(rd315));
  // PTX:124 add.s64 %rd88, %rd86, %rd87
  asm("add.s64 %0, %1, %2;" : "=l"(rd88) : "l"(rd86), "l"(rd87));
  // PTX:125 ld.global.f32 %f900, [%rd88]
  f900 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (0)))));
  // PTX:126 ld.global.f32 %f901, [%rd88+4]
  f901 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (4)))));
  // PTX:127 ld.global.f32 %f902, [%rd88+8]
  f902 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (8)))));
  // PTX:128 cvta.to.global.u64 %rd89, %rd36
  rd89 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd36));
  // PTX:129 add.s64 %rd90, %rd89, %rd87
  asm("add.s64 %0, %1, %2;" : "=l"(rd90) : "l"(rd89), "l"(rd87));
  // PTX:130 ld.global.f32 %f897, [%rd90]
  f897 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (0)))));
  // PTX:131 ld.global.f32 %f898, [%rd90+4]
  f898 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (4)))));
  // PTX:132 ld.global.f32 %f899, [%rd90+8]
  f899 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (8)))));
  // PTX:133 cvta.to.global.u64 %rd91, %rd37
  rd91 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd37));
  // PTX:134 add.s64 %rd92, %rd91, %rd87
  asm("add.s64 %0, %1, %2;" : "=l"(rd92) : "l"(rd91), "l"(rd87));
  // PTX:135 ld.global.u32 %r106, [%rd92+8]
  r106 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (8)))));
  // PTX:136 ld.global.u32 %r105, [%rd92+4]
  r105 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (4)))));
  // PTX:137 ld.global.u32 %r104, [%rd92]
  r104 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (0)))));
  // PTX:138 setp.lt.s32 %p8, %r32, 0
  p8 = (((int)(r32)) < ((int)(0)));
  // PTX:139 mul.wide.s32 %rd93, %r32, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd93) : "r"(r32));
  // PTX:140 add.s64 %rd16, %rd79, %rd93
  asm("add.s64 %0, %1, %2;" : "=l"(rd16) : "l"(rd79), "l"(rd93));
  // PTX:141 cvta.to.global.u64 %rd94, %rd38
  rd94 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd38));
  // PTX:142 shl.b64 %rd95, %rd315, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd95) : "l"(rd315));
  // PTX:143 add.s64 %rd17, %rd94, %rd95
  asm("add.s64 %0, %1, %2;" : "=l"(rd17) : "l"(rd94), "l"(rd95));
  // PTX:144 cvta.to.global.u64 %rd96, %rd40
  rd96 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd40));
  // PTX:145 add.s64 %rd18, %rd96, %rd95
  asm("add.s64 %0, %1, %2;" : "=l"(rd18) : "l"(rd96), "l"(rd95));
  // PTX:146 cvta.to.global.u64 %rd97, %rd41
  rd97 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd41));
  // PTX:147 add.s64 %rd19, %rd97, %rd95
  asm("add.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd97), "l"(rd95));
  // PTX:148 mov.u64 %rd318, %rd317
  asm("mov.u64 %0, %1;" : "=l"(rd318) : "l"(rd317));
  // PTX:149 mov.u64 %rd319, %rd317
  asm("mov.u64 %0, %1;" : "=l"(rd319) : "l"(rd317));
  // PTX:150 mov.u64 %rd320, %rd317
  asm("mov.u64 %0, %1;" : "=l"(rd320) : "l"(rd317));
  // PTX:151 mov.f32 %f878, %f897
  asm("mov.f32 %0, %1;" : "=f"(f878) : "f"(f897));
  // PTX:152 mov.f32 %f879, %f898
  asm("mov.f32 %0, %1;" : "=f"(f879) : "f"(f898));
  // PTX:153 mov.f32 %f880, %f899
  asm("mov.f32 %0, %1;" : "=f"(f880) : "f"(f899));
  // PTX:154 mov.f32 %f881, %f900
  asm("mov.f32 %0, %1;" : "=f"(f881) : "f"(f900));
  // PTX:155 mov.f32 %f882, %f901
  asm("mov.f32 %0, %1;" : "=f"(f882) : "f"(f901));
  // PTX:156 mov.f32 %f883, %f902
  asm("mov.f32 %0, %1;" : "=f"(f883) : "f"(f902));
  // PTX:157 mov.u32 %r101, %r104
  asm("mov.u32 %0, %1;" : "=r"(r101) : "r"(r104));
  // PTX:158 mov.u32 %r102, %r105
  asm("mov.u32 %0, %1;" : "=r"(r102) : "r"(r105));
  // PTX:159 mov.u32 %r103, %r106
  asm("mov.u32 %0, %1;" : "=r"(r103) : "r"(r106));
  // PTX:160 @%p8 bra $L__BB70_11
  if (p8) { goto L_BB70_11; }
  // PTX:162 ld.global.u32 %r34, [%rd16]
  r34 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:163 add.s32 %r35, %r34, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r35) : "r"(r34), "r"(r1));
  // PTX:164 ld.global.u32 %r36, [%rd16+4]
  r36 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (4)))));
  // PTX:165 add.s32 %r37, %r36, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r37) : "r"(r36), "r"(r1));
  // PTX:166 ld.global.u32 %r38, [%rd16+8]
  r38 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (8)))));
  // PTX:167 add.s32 %r39, %r38, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r39) : "r"(r38), "r"(r1));
  // PTX:168 ld.global.u32 %r40, [%rd16+12]
  r40 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (12)))));
  // PTX:169 add.s32 %r41, %r40, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r41) : "r"(r40), "r"(r1));
  // PTX:170 cvt.s64.s32 %rd320, %r35
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd320) : "r"(r35));
  // PTX:171 mul.wide.s32 %rd98, %r35, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd98) : "r"(r35));
  // PTX:172 add.s64 %rd99, %rd5, %rd98
  asm("add.s64 %0, %1, %2;" : "=l"(rd99) : "l"(rd5), "l"(rd98));
  // PTX:173 ld.global.f32 %f184, [%rd99]
  f184 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (0)))));
  // PTX:174 ld.global.f32 %f185, [%rd17]
  f185 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:175 ld.global.f32 %f186, [%rd99+4]
  f186 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (4)))));
  // PTX:176 ld.global.f32 %f187, [%rd99+8]
  f187 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (8)))));
  // PTX:177 cvt.s64.s32 %rd319, %r37
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd319) : "r"(r37));
  // PTX:178 mul.wide.s32 %rd100, %r37, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd100) : "r"(r37));
  // PTX:179 add.s64 %rd101, %rd5, %rd100
  asm("add.s64 %0, %1, %2;" : "=l"(rd101) : "l"(rd5), "l"(rd100));
  // PTX:180 ld.global.f32 %f188, [%rd101]
  f188 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd101) + (0)))));
  // PTX:181 ld.global.f32 %f189, [%rd17+4]
  f189 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (4)))));
  // PTX:182 mul.f32 %f190, %f189, %f188
  asm("mul.f32 %0, %1, %2;" : "=f"(f190) : "f"(f189), "f"(f188));
  // PTX:183 ld.global.f32 %f191, [%rd101+4]
  f191 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd101) + (4)))));
  // PTX:184 mul.f32 %f192, %f189, %f191
  asm("mul.f32 %0, %1, %2;" : "=f"(f192) : "f"(f189), "f"(f191));
  // PTX:185 ld.global.f32 %f193, [%rd101+8]
  f193 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd101) + (8)))));
  // PTX:186 mul.f32 %f194, %f189, %f193
  asm("mul.f32 %0, %1, %2;" : "=f"(f194) : "f"(f189), "f"(f193));
  // PTX:187 fma.rn.f32 %f195, %f185, %f184, %f190
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f195) : "f"(f185), "f"(f184), "f"(f190));
  // PTX:188 fma.rn.f32 %f196, %f185, %f186, %f192
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f196) : "f"(f185), "f"(f186), "f"(f192));
  // PTX:189 fma.rn.f32 %f197, %f185, %f187, %f194
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f197) : "f"(f185), "f"(f187), "f"(f194));
  // PTX:190 cvt.s64.s32 %rd318, %r39
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd318) : "r"(r39));
  // PTX:191 mul.wide.s32 %rd102, %r39, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd102) : "r"(r39));
  // PTX:192 add.s64 %rd103, %rd5, %rd102
  asm("add.s64 %0, %1, %2;" : "=l"(rd103) : "l"(rd5), "l"(rd102));
  // PTX:193 ld.global.f32 %f198, [%rd103]
  f198 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd103) + (0)))));
  // PTX:194 ld.global.f32 %f199, [%rd17+8]
  f199 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (8)))));
  // PTX:195 ld.global.f32 %f200, [%rd103+4]
  f200 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd103) + (4)))));
  // PTX:196 ld.global.f32 %f201, [%rd103+8]
  f201 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd103) + (8)))));
  // PTX:197 fma.rn.f32 %f202, %f199, %f198, %f195
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f202) : "f"(f199), "f"(f198), "f"(f195));
  // PTX:198 fma.rn.f32 %f203, %f199, %f200, %f196
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f203) : "f"(f199), "f"(f200), "f"(f196));
  // PTX:199 fma.rn.f32 %f204, %f199, %f201, %f197
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f204) : "f"(f199), "f"(f201), "f"(f197));
  // PTX:200 cvt.s64.s32 %rd317, %r41
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd317) : "r"(r41));
  // PTX:201 mul.wide.s32 %rd104, %r41, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd104) : "r"(r41));
  // PTX:202 add.s64 %rd105, %rd5, %rd104
  asm("add.s64 %0, %1, %2;" : "=l"(rd105) : "l"(rd5), "l"(rd104));
  // PTX:203 ld.global.f32 %f205, [%rd105]
  f205 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (0)))));
  // PTX:204 ld.global.f32 %f206, [%rd17+12]
  f206 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (12)))));
  // PTX:205 ld.global.f32 %f207, [%rd105+4]
  f207 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (4)))));
  // PTX:206 ld.global.f32 %f208, [%rd105+8]
  f208 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (8)))));
  // PTX:207 fma.rn.f32 %f881, %f206, %f205, %f202
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f881) : "f"(f206), "f"(f205), "f"(f202));
  // PTX:208 fma.rn.f32 %f882, %f206, %f207, %f203
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f882) : "f"(f206), "f"(f207), "f"(f203));
  // PTX:209 fma.rn.f32 %f883, %f206, %f208, %f204
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f883) : "f"(f206), "f"(f208), "f"(f204));
  // PTX:210 ld.global.f32 %f209, [%rd18]
  f209 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (0)))));
  // PTX:211 ld.global.f32 %f210, [%rd18+4]
  f210 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (4)))));
  // PTX:212 mul.f32 %f211, %f210, %f188
  asm("mul.f32 %0, %1, %2;" : "=f"(f211) : "f"(f210), "f"(f188));
  // PTX:213 mul.f32 %f212, %f210, %f191
  asm("mul.f32 %0, %1, %2;" : "=f"(f212) : "f"(f210), "f"(f191));
  // PTX:214 mul.f32 %f213, %f210, %f193
  asm("mul.f32 %0, %1, %2;" : "=f"(f213) : "f"(f210), "f"(f193));
  // PTX:215 fma.rn.f32 %f214, %f209, %f184, %f211
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f214) : "f"(f209), "f"(f184), "f"(f211));
  // PTX:216 fma.rn.f32 %f215, %f209, %f186, %f212
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f215) : "f"(f209), "f"(f186), "f"(f212));
  // PTX:217 fma.rn.f32 %f216, %f209, %f187, %f213
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f216) : "f"(f209), "f"(f187), "f"(f213));
  // PTX:218 ld.global.f32 %f217, [%rd18+8]
  f217 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (8)))));
  // PTX:219 fma.rn.f32 %f218, %f217, %f198, %f214
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f218) : "f"(f217), "f"(f198), "f"(f214));
  // PTX:220 fma.rn.f32 %f219, %f217, %f200, %f215
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f219) : "f"(f217), "f"(f200), "f"(f215));
  // PTX:221 fma.rn.f32 %f220, %f217, %f201, %f216
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f220) : "f"(f217), "f"(f201), "f"(f216));
  // PTX:222 ld.global.f32 %f221, [%rd18+12]
  f221 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (12)))));
  // PTX:223 fma.rn.f32 %f878, %f221, %f205, %f218
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f878) : "f"(f221), "f"(f205), "f"(f218));
  // PTX:224 fma.rn.f32 %f879, %f221, %f207, %f219
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f879) : "f"(f221), "f"(f207), "f"(f219));
  // PTX:225 fma.rn.f32 %f880, %f221, %f208, %f220
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f880) : "f"(f221), "f"(f208), "f"(f220));
  // PTX:226 ld.global.f32 %f222, [%rd19]
  f222 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))));
  // PTX:227 ld.global.f32 %f223, [%rd19+4]
  f223 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (4)))));
  // PTX:228 mul.f32 %f224, %f223, %f188
  asm("mul.f32 %0, %1, %2;" : "=f"(f224) : "f"(f223), "f"(f188));
  // PTX:229 mul.f32 %f225, %f223, %f191
  asm("mul.f32 %0, %1, %2;" : "=f"(f225) : "f"(f223), "f"(f191));
  // PTX:230 mul.f32 %f226, %f223, %f193
  asm("mul.f32 %0, %1, %2;" : "=f"(f226) : "f"(f223), "f"(f193));
  // PTX:231 fma.rn.f32 %f227, %f222, %f184, %f224
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f227) : "f"(f222), "f"(f184), "f"(f224));
  // PTX:232 fma.rn.f32 %f228, %f222, %f186, %f225
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f228) : "f"(f222), "f"(f186), "f"(f225));
  // PTX:233 fma.rn.f32 %f229, %f222, %f187, %f226
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f229) : "f"(f222), "f"(f187), "f"(f226));
  // PTX:234 ld.global.f32 %f230, [%rd19+8]
  f230 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (8)))));
  // PTX:235 fma.rn.f32 %f231, %f230, %f198, %f227
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f231) : "f"(f230), "f"(f198), "f"(f227));
  // PTX:236 fma.rn.f32 %f232, %f230, %f200, %f228
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f232) : "f"(f230), "f"(f200), "f"(f228));
  // PTX:237 fma.rn.f32 %f233, %f230, %f201, %f229
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f233) : "f"(f230), "f"(f201), "f"(f229));
  // PTX:238 ld.global.f32 %f234, [%rd19+12]
  f234 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (12)))));
  // PTX:239 fma.rn.f32 %f235, %f234, %f205, %f231
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f235) : "f"(f234), "f"(f205), "f"(f231));
  // PTX:240 fma.rn.f32 %f236, %f234, %f207, %f232
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f236) : "f"(f234), "f"(f207), "f"(f232));
  // PTX:241 fma.rn.f32 %f237, %f234, %f208, %f233
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f237) : "f"(f234), "f"(f208), "f"(f233));
  // PTX:242 mov.b32 %r103, %f237
  asm("mov.b32 %0, %1;" : "=r"(r103) : "f"(f237));
  // PTX:243 mov.b32 %r102, %f236
  asm("mov.b32 %0, %1;" : "=r"(r102) : "f"(f236));
  // PTX:244 mov.b32 %r101, %f235
  asm("mov.b32 %0, %1;" : "=r"(r101) : "f"(f235));
  // PTX:246 $L__BB70_11:
L_BB70_11:;
  // PTX:247 ld.param.u64 %rd314, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_0+80]
  rd314 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (80))));
  // PTX:248 cvta.to.global.u64 %rd106, %rd39
  rd106 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd39));
  // PTX:249 add.s64 %rd108, %rd106, %rd95
  asm("add.s64 %0, %1, %2;" : "=l"(rd108) : "l"(rd106), "l"(rd95));
  // PTX:250 add.s32 %r42, %r2, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r42) : "r"(r2), "r"(r1));
  // PTX:251 cvt.s64.s32 %rd28, %r42
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd28) : "r"(r42));
  // PTX:252 mul.wide.s32 %rd109, %r42, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd109) : "r"(r42));
  // PTX:253 add.s64 %rd110, %rd5, %rd109
  asm("add.s64 %0, %1, %2;" : "=l"(rd110) : "l"(rd5), "l"(rd109));
  // PTX:254 ld.global.f32 %f238, [%rd110]
  f238 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd110) + (0)))));
  // PTX:255 ld.global.f32 %f21, [%rd108]
  f21 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd108) + (0)))));
  // PTX:256 ld.global.f32 %f239, [%rd110+4]
  f239 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd110) + (4)))));
  // PTX:257 ld.global.f32 %f240, [%rd110+8]
  f240 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd110) + (8)))));
  // PTX:258 add.s32 %r43, %r3, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r43) : "r"(r3), "r"(r1));
  // PTX:259 cvt.s64.s32 %rd29, %r43
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd29) : "r"(r43));
  // PTX:260 mul.wide.s32 %rd111, %r43, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd111) : "r"(r43));
  // PTX:261 add.s64 %rd112, %rd5, %rd111
  asm("add.s64 %0, %1, %2;" : "=l"(rd112) : "l"(rd5), "l"(rd111));
  // PTX:262 ld.global.f32 %f241, [%rd112]
  f241 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd112) + (0)))));
  // PTX:263 ld.global.f32 %f22, [%rd108+4]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd108) + (4)))));
  // PTX:264 mul.f32 %f242, %f22, %f241
  asm("mul.f32 %0, %1, %2;" : "=f"(f242) : "f"(f22), "f"(f241));
  // PTX:265 ld.global.f32 %f243, [%rd112+4]
  f243 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd112) + (4)))));
  // PTX:266 mul.f32 %f244, %f22, %f243
  asm("mul.f32 %0, %1, %2;" : "=f"(f244) : "f"(f22), "f"(f243));
  // PTX:267 ld.global.f32 %f245, [%rd112+8]
  f245 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd112) + (8)))));
  // PTX:268 mul.f32 %f246, %f22, %f245
  asm("mul.f32 %0, %1, %2;" : "=f"(f246) : "f"(f22), "f"(f245));
  // PTX:269 fma.rn.f32 %f247, %f21, %f238, %f242
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f247) : "f"(f21), "f"(f238), "f"(f242));
  // PTX:270 fma.rn.f32 %f248, %f21, %f239, %f244
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f248) : "f"(f21), "f"(f239), "f"(f244));
  // PTX:271 fma.rn.f32 %f249, %f21, %f240, %f246
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f249) : "f"(f21), "f"(f240), "f"(f246));
  // PTX:272 add.s32 %r44, %r4, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r44) : "r"(r4), "r"(r1));
  // PTX:273 cvt.s64.s32 %rd30, %r44
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd30) : "r"(r44));
  // PTX:274 mul.wide.s32 %rd113, %r44, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd113) : "r"(r44));
  // PTX:275 add.s64 %rd114, %rd5, %rd113
  asm("add.s64 %0, %1, %2;" : "=l"(rd114) : "l"(rd5), "l"(rd113));
  // PTX:276 ld.global.f32 %f250, [%rd114]
  f250 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd114) + (0)))));
  // PTX:277 ld.global.f32 %f23, [%rd108+8]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd108) + (8)))));
  // PTX:278 ld.global.f32 %f251, [%rd114+4]
  f251 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd114) + (4)))));
  // PTX:279 ld.global.f32 %f252, [%rd114+8]
  f252 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd114) + (8)))));
  // PTX:280 fma.rn.f32 %f253, %f23, %f250, %f247
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f253) : "f"(f23), "f"(f250), "f"(f247));
  // PTX:281 fma.rn.f32 %f254, %f23, %f251, %f248
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f254) : "f"(f23), "f"(f251), "f"(f248));
  // PTX:282 fma.rn.f32 %f255, %f23, %f252, %f249
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f255) : "f"(f23), "f"(f252), "f"(f249));
  // PTX:283 add.s32 %r45, %r5, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r45) : "r"(r5), "r"(r1));
  // PTX:284 cvt.s64.s32 %rd31, %r45
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd31) : "r"(r45));
  // PTX:285 mul.wide.s32 %rd115, %r45, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd115) : "r"(r45));
  // PTX:286 add.s64 %rd116, %rd5, %rd115
  asm("add.s64 %0, %1, %2;" : "=l"(rd116) : "l"(rd5), "l"(rd115));
  // PTX:287 ld.global.f32 %f256, [%rd116]
  f256 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd116) + (0)))));
  // PTX:288 ld.global.f32 %f24, [%rd108+12]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd108) + (12)))));
  // PTX:289 ld.global.f32 %f257, [%rd116+4]
  f257 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd116) + (4)))));
  // PTX:290 ld.global.f32 %f258, [%rd116+8]
  f258 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd116) + (8)))));
  // PTX:291 fma.rn.f32 %f25, %f24, %f256, %f253
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f25) : "f"(f24), "f"(f256), "f"(f253));
  // PTX:292 fma.rn.f32 %f26, %f24, %f257, %f254
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f26) : "f"(f24), "f"(f257), "f"(f254));
  // PTX:293 fma.rn.f32 %f27, %f24, %f258, %f255
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f27) : "f"(f24), "f"(f258), "f"(f255));
  // PTX:294 cvta.to.global.u64 %rd117, %rd314
  rd117 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd314));
  // PTX:295 add.s64 %rd118, %rd117, %rd95
  asm("add.s64 %0, %1, %2;" : "=l"(rd118) : "l"(rd117), "l"(rd95));
  // PTX:296 ld.global.f32 %f28, [%rd118]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd118) + (0)))));
  // PTX:297 ld.global.f32 %f29, [%rd118+4]
  f29 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd118) + (4)))));
  // PTX:298 mul.f32 %f259, %f29, %f241
  asm("mul.f32 %0, %1, %2;" : "=f"(f259) : "f"(f29), "f"(f241));
  // PTX:299 mul.f32 %f260, %f29, %f243
  asm("mul.f32 %0, %1, %2;" : "=f"(f260) : "f"(f29), "f"(f243));
  // PTX:300 mul.f32 %f261, %f29, %f245
  asm("mul.f32 %0, %1, %2;" : "=f"(f261) : "f"(f29), "f"(f245));
  // PTX:301 fma.rn.f32 %f262, %f28, %f238, %f259
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f262) : "f"(f28), "f"(f238), "f"(f259));
  // PTX:302 fma.rn.f32 %f263, %f28, %f239, %f260
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f263) : "f"(f28), "f"(f239), "f"(f260));
  // PTX:303 fma.rn.f32 %f264, %f28, %f240, %f261
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f264) : "f"(f28), "f"(f240), "f"(f261));
  // PTX:304 ld.global.f32 %f30, [%rd118+8]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd118) + (8)))));
  // PTX:305 fma.rn.f32 %f265, %f30, %f250, %f262
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f265) : "f"(f30), "f"(f250), "f"(f262));
  // PTX:306 fma.rn.f32 %f266, %f30, %f251, %f263
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f266) : "f"(f30), "f"(f251), "f"(f263));
  // PTX:307 fma.rn.f32 %f267, %f30, %f252, %f264
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f267) : "f"(f30), "f"(f252), "f"(f264));
  // PTX:308 ld.global.f32 %f31, [%rd118+12]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd118) + (12)))));
  // PTX:309 fma.rn.f32 %f32, %f31, %f256, %f265
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f32) : "f"(f31), "f"(f256), "f"(f265));
  // PTX:310 fma.rn.f32 %f33, %f31, %f257, %f266
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f33) : "f"(f31), "f"(f257), "f"(f266));
  // PTX:311 fma.rn.f32 %f34, %f31, %f258, %f267
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f34) : "f"(f31), "f"(f258), "f"(f267));
  // PTX:312 sub.f32 %f35, %f878, %f881
  asm("sub.f32 %0, %1, %2;" : "=f"(f35) : "f"(f878), "f"(f881));
  // PTX:313 sub.f32 %f36, %f879, %f882
  asm("sub.f32 %0, %1, %2;" : "=f"(f36) : "f"(f879), "f"(f882));
  // PTX:314 mul.f32 %f268, %f36, %f36
  asm("mul.f32 %0, %1, %2;" : "=f"(f268) : "f"(f36), "f"(f36));
  // PTX:315 sub.f32 %f37, %f880, %f883
  asm("sub.f32 %0, %1, %2;" : "=f"(f37) : "f"(f880), "f"(f883));
  // PTX:316 fma.rn.f32 %f269, %f35, %f35, %f268
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f269) : "f"(f35), "f"(f35), "f"(f268));
  // PTX:317 fma.rn.f32 %f270, %f37, %f37, %f269
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f270) : "f"(f37), "f"(f37), "f"(f269));
  // PTX:318 sqrt.rn.f32 %f38, %f270
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f38) : "f"(f270));
  // PTX:319 setp.leu.f32 %p9, %f38, 0f322BCC77
  p9 = ((isnan(((float)(f38))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f38)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:320 @%p9 bra $L__BB70_68
  if (p9) { goto L_BB70_68; }
  // PTX:322 abs.f32 %f271, %f38
  asm("abs.f32 %0, %1;" : "=f"(f271) : "f"(f38));
  // PTX:323 setp.geu.f32 %p10, %f271, 0f7F800000
  p10 = ((isnan(((float)(f271))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f271)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:324 @%p10 bra $L__BB70_68
  if (p10) { goto L_BB70_68; }
  // PTX:326 div.rn.f32 %f39, %f35, %f38
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f39) : "f"(f35), "f"(f38));
  // PTX:327 mov.b32 %f272, %r101
  asm("mov.b32 %0, %1;" : "=f"(f272) : "r"(r101));
  // PTX:328 sub.f32 %f273, %f272, %f881
  asm("sub.f32 %0, %1, %2;" : "=f"(f273) : "f"(f272), "f"(f881));
  // PTX:329 mov.b32 %f274, %r102
  asm("mov.b32 %0, %1;" : "=f"(f274) : "r"(r102));
  // PTX:330 sub.f32 %f275, %f274, %f882
  asm("sub.f32 %0, %1, %2;" : "=f"(f275) : "f"(f274), "f"(f882));
  // PTX:331 mov.b32 %f276, %r103
  asm("mov.b32 %0, %1;" : "=f"(f276) : "r"(r103));
  // PTX:332 sub.f32 %f277, %f276, %f883
  asm("sub.f32 %0, %1, %2;" : "=f"(f277) : "f"(f276), "f"(f883));
  // PTX:333 div.rn.f32 %f40, %f36, %f38
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f40) : "f"(f36), "f"(f38));
  // PTX:334 mul.f32 %f278, %f275, %f40
  asm("mul.f32 %0, %1, %2;" : "=f"(f278) : "f"(f275), "f"(f40));
  // PTX:335 div.rn.f32 %f41, %f37, %f38
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f41) : "f"(f37), "f"(f38));
  // PTX:336 fma.rn.f32 %f279, %f273, %f39, %f278
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f279) : "f"(f273), "f"(f39), "f"(f278));
  // PTX:337 fma.rn.f32 %f42, %f277, %f41, %f279
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f42) : "f"(f277), "f"(f41), "f"(f279));
  // PTX:338 mul.f32 %f280, %f39, %f42
  asm("mul.f32 %0, %1, %2;" : "=f"(f280) : "f"(f39), "f"(f42));
  // PTX:339 mul.f32 %f281, %f40, %f42
  asm("mul.f32 %0, %1, %2;" : "=f"(f281) : "f"(f40), "f"(f42));
  // PTX:340 mul.f32 %f282, %f41, %f42
  asm("mul.f32 %0, %1, %2;" : "=f"(f282) : "f"(f41), "f"(f42));
  // PTX:341 sub.f32 %f43, %f273, %f280
  asm("sub.f32 %0, %1, %2;" : "=f"(f43) : "f"(f273), "f"(f280));
  // PTX:342 sub.f32 %f44, %f275, %f281
  asm("sub.f32 %0, %1, %2;" : "=f"(f44) : "f"(f275), "f"(f281));
  // PTX:343 sub.f32 %f45, %f277, %f282
  asm("sub.f32 %0, %1, %2;" : "=f"(f45) : "f"(f277), "f"(f282));
  // PTX:344 sub.f32 %f283, %f32, %f25
  asm("sub.f32 %0, %1, %2;" : "=f"(f283) : "f"(f32), "f"(f25));
  // PTX:345 sub.f32 %f284, %f33, %f26
  asm("sub.f32 %0, %1, %2;" : "=f"(f284) : "f"(f33), "f"(f26));
  // PTX:346 mul.f32 %f285, %f284, %f40
  asm("mul.f32 %0, %1, %2;" : "=f"(f285) : "f"(f284), "f"(f40));
  // PTX:347 sub.f32 %f286, %f34, %f27
  asm("sub.f32 %0, %1, %2;" : "=f"(f286) : "f"(f34), "f"(f27));
  // PTX:348 fma.rn.f32 %f287, %f283, %f39, %f285
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f287) : "f"(f283), "f"(f39), "f"(f285));
  // PTX:349 fma.rn.f32 %f46, %f41, %f286, %f287
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f46) : "f"(f41), "f"(f286), "f"(f287));
  // PTX:350 mul.f32 %f288, %f39, %f46
  asm("mul.f32 %0, %1, %2;" : "=f"(f288) : "f"(f39), "f"(f46));
  // PTX:351 mul.f32 %f289, %f40, %f46
  asm("mul.f32 %0, %1, %2;" : "=f"(f289) : "f"(f40), "f"(f46));
  // PTX:352 mul.f32 %f290, %f41, %f46
  asm("mul.f32 %0, %1, %2;" : "=f"(f290) : "f"(f41), "f"(f46));
  // PTX:353 sub.f32 %f47, %f283, %f288
  asm("sub.f32 %0, %1, %2;" : "=f"(f47) : "f"(f283), "f"(f288));
  // PTX:354 sub.f32 %f48, %f284, %f289
  asm("sub.f32 %0, %1, %2;" : "=f"(f48) : "f"(f284), "f"(f289));
  // PTX:355 sub.f32 %f49, %f286, %f290
  asm("sub.f32 %0, %1, %2;" : "=f"(f49) : "f"(f286), "f"(f290));
  // PTX:356 mul.f32 %f291, %f44, %f44
  asm("mul.f32 %0, %1, %2;" : "=f"(f291) : "f"(f44), "f"(f44));
  // PTX:357 fma.rn.f32 %f292, %f43, %f43, %f291
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f292) : "f"(f43), "f"(f43), "f"(f291));
  // PTX:358 fma.rn.f32 %f293, %f45, %f45, %f292
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f293) : "f"(f45), "f"(f45), "f"(f292));
  // PTX:359 sqrt.rn.f32 %f50, %f293
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f50) : "f"(f293));
  // PTX:360 mul.f32 %f294, %f48, %f48
  asm("mul.f32 %0, %1, %2;" : "=f"(f294) : "f"(f48), "f"(f48));
  // PTX:361 fma.rn.f32 %f295, %f47, %f47, %f294
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f295) : "f"(f47), "f"(f47), "f"(f294));
  // PTX:362 fma.rn.f32 %f296, %f49, %f49, %f295
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f296) : "f"(f49), "f"(f49), "f"(f295));
  // PTX:363 sqrt.rn.f32 %f51, %f296
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f51) : "f"(f296));
  // PTX:364 setp.leu.f32 %p11, %f50, 0f322BCC77
  p11 = ((isnan(((float)(f50))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f50)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:365 setp.leu.f32 %p12, %f51, 0f322BCC77
  p12 = ((isnan(((float)(f51))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f51)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:366 or.pred %p13, %p11, %p12
  p13 = ((p11) || (p12));
  // PTX:367 @%p13 bra $L__BB70_68
  if (p13) { goto L_BB70_68; }
  // PTX:369 abs.f32 %f297, %f50
  asm("abs.f32 %0, %1;" : "=f"(f297) : "f"(f50));
  // PTX:370 setp.geu.f32 %p14, %f297, 0f7F800000
  p14 = ((isnan(((float)(f297))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f297)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:371 @%p14 bra $L__BB70_68
  if (p14) { goto L_BB70_68; }
  // PTX:373 abs.f32 %f298, %f51
  asm("abs.f32 %0, %1;" : "=f"(f298) : "f"(f51));
  // PTX:374 setp.geu.f32 %p15, %f298, 0f7F800000
  p15 = ((isnan(((float)(f298))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f298)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:375 @%p15 bra $L__BB70_68
  if (p15) { goto L_BB70_68; }
  // PTX:377 div.rn.f32 %f52, %f43, %f50
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f52) : "f"(f43), "f"(f50));
  // PTX:378 div.rn.f32 %f53, %f49, %f51
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f53) : "f"(f49), "f"(f51));
  // PTX:379 div.rn.f32 %f54, %f44, %f50
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f54) : "f"(f44), "f"(f50));
  // PTX:380 mul.f32 %f299, %f54, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f299) : "f"(f54), "f"(f53));
  // PTX:381 div.rn.f32 %f55, %f48, %f51
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f55) : "f"(f48), "f"(f51));
  // PTX:382 div.rn.f32 %f56, %f45, %f50
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f56) : "f"(f45), "f"(f50));
  // PTX:383 mul.f32 %f300, %f56, %f55
  asm("mul.f32 %0, %1, %2;" : "=f"(f300) : "f"(f56), "f"(f55));
  // PTX:384 sub.f32 %f301, %f299, %f300
  asm("sub.f32 %0, %1, %2;" : "=f"(f301) : "f"(f299), "f"(f300));
  // PTX:385 div.rn.f32 %f57, %f47, %f51
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f57) : "f"(f47), "f"(f51));
  // PTX:386 mul.f32 %f302, %f56, %f57
  asm("mul.f32 %0, %1, %2;" : "=f"(f302) : "f"(f56), "f"(f57));
  // PTX:387 mul.f32 %f303, %f52, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f303) : "f"(f52), "f"(f53));
  // PTX:388 sub.f32 %f304, %f302, %f303
  asm("sub.f32 %0, %1, %2;" : "=f"(f304) : "f"(f302), "f"(f303));
  // PTX:389 mul.f32 %f305, %f52, %f55
  asm("mul.f32 %0, %1, %2;" : "=f"(f305) : "f"(f52), "f"(f55));
  // PTX:390 mul.f32 %f306, %f54, %f57
  asm("mul.f32 %0, %1, %2;" : "=f"(f306) : "f"(f54), "f"(f57));
  // PTX:391 sub.f32 %f307, %f305, %f306
  asm("sub.f32 %0, %1, %2;" : "=f"(f307) : "f"(f305), "f"(f306));
  // PTX:392 mul.f32 %f308, %f40, %f304
  asm("mul.f32 %0, %1, %2;" : "=f"(f308) : "f"(f40), "f"(f304));
  // PTX:393 fma.rn.f32 %f309, %f39, %f301, %f308
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f309) : "f"(f39), "f"(f301), "f"(f308));
  // PTX:394 fma.rn.f32 %f58, %f41, %f307, %f309
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f58) : "f"(f41), "f"(f307), "f"(f309));
  // PTX:395 mul.f32 %f310, %f54, %f55
  asm("mul.f32 %0, %1, %2;" : "=f"(f310) : "f"(f54), "f"(f55));
  // PTX:396 fma.rn.f32 %f311, %f52, %f57, %f310
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f311) : "f"(f52), "f"(f57), "f"(f310));
  // PTX:397 fma.rn.f32 %f59, %f56, %f53, %f311
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f59) : "f"(f56), "f"(f53), "f"(f311));
  // PTX:398 mul.f32 %f312, %f58, %f58
  asm("mul.f32 %0, %1, %2;" : "=f"(f312) : "f"(f58), "f"(f58));
  // PTX:399 fma.rn.f32 %f60, %f59, %f59, %f312
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f60) : "f"(f59), "f"(f59), "f"(f312));
  // PTX:400 setp.leu.f32 %p16, %f60, 0f2B8CBCCC
  p16 = ((isnan(((float)(f60))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) || (((float)(f60)) <= ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:401 @%p16 bra $L__BB70_68
  if (p16) { goto L_BB70_68; }
  // PTX:403 abs.f32 %f313, %f60
  asm("abs.f32 %0, %1;" : "=f"(f313) : "f"(f60));
  // PTX:404 setp.geu.f32 %p17, %f313, 0f7F800000
  p17 = ((isnan(((float)(f313))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f313)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:405 @%p17 bra $L__BB70_68
  if (p17) { goto L_BB70_68; }
  // PTX:407 mul.f32 %f314, %f40, %f56
  asm("mul.f32 %0, %1, %2;" : "=f"(f314) : "f"(f40), "f"(f56));
  // PTX:408 mul.f32 %f315, %f41, %f54
  asm("mul.f32 %0, %1, %2;" : "=f"(f315) : "f"(f41), "f"(f54));
  // PTX:409 sub.f32 %f61, %f314, %f315
  asm("sub.f32 %0, %1, %2;" : "=f"(f61) : "f"(f314), "f"(f315));
  // PTX:410 mul.f32 %f316, %f39, %f56
  asm("mul.f32 %0, %1, %2;" : "=f"(f316) : "f"(f39), "f"(f56));
  // PTX:411 mul.f32 %f317, %f41, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f317) : "f"(f41), "f"(f52));
  // PTX:412 sub.f32 %f62, %f317, %f316
  asm("sub.f32 %0, %1, %2;" : "=f"(f62) : "f"(f317), "f"(f316));
  // PTX:413 mul.f32 %f318, %f40, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f318) : "f"(f40), "f"(f52));
  // PTX:414 mul.f32 %f319, %f39, %f54
  asm("mul.f32 %0, %1, %2;" : "=f"(f319) : "f"(f39), "f"(f54));
  // PTX:415 sub.f32 %f63, %f319, %f318
  asm("sub.f32 %0, %1, %2;" : "=f"(f63) : "f"(f319), "f"(f318));
  // PTX:416 mul.f32 %f320, %f41, %f55
  asm("mul.f32 %0, %1, %2;" : "=f"(f320) : "f"(f41), "f"(f55));
  // PTX:417 mul.f32 %f321, %f40, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f321) : "f"(f40), "f"(f53));
  // PTX:418 sub.f32 %f64, %f321, %f320
  asm("sub.f32 %0, %1, %2;" : "=f"(f64) : "f"(f321), "f"(f320));
  // PTX:419 mul.f32 %f322, %f39, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f322) : "f"(f39), "f"(f53));
  // PTX:420 mul.f32 %f323, %f41, %f57
  asm("mul.f32 %0, %1, %2;" : "=f"(f323) : "f"(f41), "f"(f57));
  // PTX:421 sub.f32 %f65, %f323, %f322
  asm("sub.f32 %0, %1, %2;" : "=f"(f65) : "f"(f323), "f"(f322));
  // PTX:422 mul.f32 %f324, %f40, %f57
  asm("mul.f32 %0, %1, %2;" : "=f"(f324) : "f"(f40), "f"(f57));
  // PTX:423 mul.f32 %f325, %f39, %f55
  asm("mul.f32 %0, %1, %2;" : "=f"(f325) : "f"(f39), "f"(f55));
  // PTX:424 sub.f32 %f66, %f325, %f324
  asm("sub.f32 %0, %1, %2;" : "=f"(f66) : "f"(f325), "f"(f324));
  // PTX:425 abs.f32 %f67, %f59
  asm("abs.f32 %0, %1;" : "=f"(f67) : "f"(f59));
  // PTX:426 setp.eq.f32 %p18, %f67, 0f00000000
  p18 = (!(isnan(((float)(f67))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f67)) == ((float)(as_f32(0x00000000u)))));
  // PTX:427 abs.f32 %f68, %f58
  asm("abs.f32 %0, %1;" : "=f"(f68) : "f"(f58));
  // PTX:428 setp.eq.f32 %p19, %f68, 0f00000000
  p19 = (!(isnan(((float)(f68))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f68)) == ((float)(as_f32(0x00000000u)))));
  // PTX:429 and.pred %p20, %p18, %p19
  p20 = ((p18) && (p19));
  // PTX:430 @%p20 bra $L__BB70_22
  if (p20) { goto L_BB70_22; }
  // PTX:431 bra.uni $L__BB70_19
  goto L_BB70_19;
  // PTX:433 $L__BB70_22:
L_BB70_22:;
  // PTX:434 mov.b32 %r56, %f59
  asm("mov.b32 %0, %1;" : "=r"(r56) : "f"(f59));
  // PTX:435 shr.s32 %r57, %r56, 31
  asm("shr.s32 %0, %1, 31;" : "=r"(r57) : "r"(r56));
  // PTX:436 and.b32 %r58, %r57, 1078530011
  asm("and.b32 %0, %1, 1078530011;" : "=r"(r58) : "r"(r57));
  // PTX:437 mov.b32 %r59, %f58
  asm("mov.b32 %0, %1;" : "=r"(r59) : "f"(f58));
  // PTX:438 and.b32 %r60, %r59, -2147483648
  asm("and.b32 %0, %1, -2147483648;" : "=r"(r60) : "r"(r59));
  // PTX:439 or.b32 %r61, %r60, %r58
  asm("or.b32 %0, %1, %2;" : "=r"(r61) : "r"(r60), "r"(r58));
  // PTX:440 mov.b32 %f884, %r61
  asm("mov.b32 %0, %1;" : "=f"(f884) : "r"(r61));
  // PTX:441 bra.uni $L__BB70_23
  goto L_BB70_23;
  // PTX:443 $L__BB70_19:
L_BB70_19:;
  // PTX:444 abs.f32 %f875, %f58
  asm("abs.f32 %0, %1;" : "=f"(f875) : "f"(f58));
  // PTX:445 abs.f32 %f874, %f59
  asm("abs.f32 %0, %1;" : "=f"(f874) : "f"(f59));
  // PTX:446 setp.eq.f32 %p21, %f874, 0f7F800000
  p21 = (!(isnan(((float)(f874))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f874)) == ((float)(as_f32(0x7F800000u)))));
  // PTX:447 setp.eq.f32 %p22, %f875, 0f7F800000
  p22 = (!(isnan(((float)(f875))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f875)) == ((float)(as_f32(0x7F800000u)))));
  // PTX:448 and.pred %p23, %p21, %p22
  p23 = ((p21) && (p22));
  // PTX:449 @%p23 bra $L__BB70_21
  if (p23) { goto L_BB70_21; }
  // PTX:450 bra.uni $L__BB70_20
  goto L_BB70_20;
  // PTX:452 $L__BB70_21:
L_BB70_21:;
  // PTX:453 mov.b32 %r51, %f59
  asm("mov.b32 %0, %1;" : "=r"(r51) : "f"(f59));
  // PTX:454 setp.lt.s32 %p27, %r51, 0
  p27 = (((int)(r51)) < ((int)(0)));
  // PTX:455 selp.b32 %r52, 1075235812, 1061752795, %p27
  r52 = p27 ? 1075235812 : 1061752795;
  // PTX:456 mov.b32 %r53, %f58
  asm("mov.b32 %0, %1;" : "=r"(r53) : "f"(f58));
  // PTX:457 and.b32 %r54, %r53, -2147483648
  asm("and.b32 %0, %1, -2147483648;" : "=r"(r54) : "r"(r53));
  // PTX:458 or.b32 %r55, %r54, %r52
  asm("or.b32 %0, %1, %2;" : "=r"(r55) : "r"(r54), "r"(r52));
  // PTX:459 mov.b32 %f884, %r55
  asm("mov.b32 %0, %1;" : "=f"(f884) : "r"(r55));
  // PTX:460 bra.uni $L__BB70_23
  goto L_BB70_23;
  // PTX:462 $L__BB70_20:
L_BB70_20:;
  // PTX:463 abs.f32 %f877, %f58
  asm("abs.f32 %0, %1;" : "=f"(f877) : "f"(f58));
  // PTX:464 abs.f32 %f876, %f59
  asm("abs.f32 %0, %1;" : "=f"(f876) : "f"(f59));
  // PTX:465 max.f32 %f326, %f877, %f876
  asm("max.f32 %0, %1, %2;" : "=f"(f326) : "f"(f877), "f"(f876));
  // PTX:466 min.f32 %f327, %f877, %f876
  asm("min.f32 %0, %1, %2;" : "=f"(f327) : "f"(f877), "f"(f876));
  // PTX:467 div.rn.f32 %f328, %f327, %f326
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f328) : "f"(f327), "f"(f326));
  // PTX:468 mul.rn.f32 %f329, %f328, %f328
  asm("mul.rn.f32 %0, %1, %2;" : "=f"(f329) : "f"(f328), "f"(f328));
  // PTX:469 mov.f32 %f330, 0fC0B59883
  asm("mov.f32 %0, 0fC0B59883;" : "=f"(f330) : );
  // PTX:470 mov.f32 %f331, 0fBF52C7EA
  asm("mov.f32 %0, 0fBF52C7EA;" : "=f"(f331) : );
  // PTX:471 fma.rn.f32 %f332, %f329, %f331, %f330
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f332) : "f"(f329), "f"(f331), "f"(f330));
  // PTX:472 mov.f32 %f333, 0fC0D21907
  asm("mov.f32 %0, 0fC0D21907;" : "=f"(f333) : );
  // PTX:473 fma.rn.f32 %f334, %f332, %f329, %f333
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f334) : "f"(f332), "f"(f329), "f"(f333));
  // PTX:474 mul.f32 %f335, %f329, %f334
  asm("mul.f32 %0, %1, %2;" : "=f"(f335) : "f"(f329), "f"(f334));
  // PTX:475 mul.f32 %f336, %f328, %f335
  asm("mul.f32 %0, %1, %2;" : "=f"(f336) : "f"(f328), "f"(f335));
  // PTX:476 add.f32 %f337, %f329, 0f41355DC0
  asm("add.f32 %0, %1, 0f41355DC0;" : "=f"(f337) : "f"(f329));
  // PTX:477 mov.f32 %f338, 0f41E6BD60
  asm("mov.f32 %0, 0f41E6BD60;" : "=f"(f338) : );
  // PTX:478 fma.rn.f32 %f339, %f337, %f329, %f338
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f339) : "f"(f337), "f"(f329), "f"(f338));
  // PTX:479 mov.f32 %f340, 0f419D92C8
  asm("mov.f32 %0, 0f419D92C8;" : "=f"(f340) : );
  // PTX:480 fma.rn.f32 %f341, %f339, %f329, %f340
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f341) : "f"(f339), "f"(f329), "f"(f340));
  // PTX:481 rcp.rn.f32 %f342, %f341
  asm("rcp.rn.f32 %0, %1;" : "=f"(f342) : "f"(f341));
  // PTX:482 fma.rn.f32 %f343, %f336, %f342, %f328
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f343) : "f"(f336), "f"(f342), "f"(f328));
  // PTX:483 mov.f32 %f344, 0f3FC90FDB
  asm("mov.f32 %0, 0f3FC90FDB;" : "=f"(f344) : );
  // PTX:484 sub.f32 %f345, %f344, %f343
  asm("sub.f32 %0, %1, %2;" : "=f"(f345) : "f"(f344), "f"(f343));
  // PTX:485 setp.gt.f32 %p24, %f877, %f876
  p24 = (!(isnan(((float)(f877))) || isnan(((float)(f876)))) && (((float)(f877)) > ((float)(f876))));
  // PTX:486 selp.f32 %f346, %f345, %f343, %p24
  f346 = p24 ? f345 : f343;
  // PTX:487 mov.b32 %r46, %f59
  asm("mov.b32 %0, %1;" : "=r"(r46) : "f"(f59));
  // PTX:488 setp.lt.s32 %p25, %r46, 0
  p25 = (((int)(r46)) < ((int)(0)));
  // PTX:489 mov.f32 %f347, 0f40490FDB
  asm("mov.f32 %0, 0f40490FDB;" : "=f"(f347) : );
  // PTX:490 sub.f32 %f348, %f347, %f346
  asm("sub.f32 %0, %1, %2;" : "=f"(f348) : "f"(f347), "f"(f346));
  // PTX:491 selp.f32 %f349, %f348, %f346, %p25
  f349 = p25 ? f348 : f346;
  // PTX:492 mov.b32 %r47, %f349
  asm("mov.b32 %0, %1;" : "=r"(r47) : "f"(f349));
  // PTX:493 mov.b32 %r48, %f58
  asm("mov.b32 %0, %1;" : "=r"(r48) : "f"(f58));
  // PTX:494 and.b32 %r49, %r48, -2147483648
  asm("and.b32 %0, %1, -2147483648;" : "=r"(r49) : "r"(r48));
  // PTX:495 or.b32 %r50, %r49, %r47
  asm("or.b32 %0, %1, %2;" : "=r"(r50) : "r"(r49), "r"(r47));
  // PTX:496 mov.b32 %f350, %r50
  asm("mov.b32 %0, %1;" : "=f"(f350) : "r"(r50));
  // PTX:497 add.f32 %f351, %f876, %f877
  asm("add.f32 %0, %1, %2;" : "=f"(f351) : "f"(f876), "f"(f877));
  // PTX:498 setp.le.f32 %p26, %f351, 0f7F800000
  p26 = (!(isnan(((float)(f351))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f351)) <= ((float)(as_f32(0x7F800000u)))));
  // PTX:499 selp.f32 %f884, %f350, %f351, %p26
  f884 = p26 ? f350 : f351;
  // PTX:501 $L__BB70_23:
L_BB70_23:;
  // PTX:502 cvt.s64.s32 %rd275, %r32
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd275) : "r"(r32));
  // PTX:503 div.rn.f32 %f353, %f42, %f50
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f353) : "f"(f42), "f"(f50));
  // PTX:504 div.rn.f32 %f354, %f46, %f51
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f354) : "f"(f46), "f"(f51));
  // PTX:505 mul.f32 %f355, %f354, %f64
  asm("mul.f32 %0, %1, %2;" : "=f"(f355) : "f"(f354), "f"(f64));
  // PTX:506 mul.f32 %f356, %f353, %f61
  asm("mul.f32 %0, %1, %2;" : "=f"(f356) : "f"(f353), "f"(f61));
  // PTX:507 sub.f32 %f357, %f356, %f355
  asm("sub.f32 %0, %1, %2;" : "=f"(f357) : "f"(f356), "f"(f355));
  // PTX:508 div.rn.f32 %f73, %f357, %f38
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f73) : "f"(f357), "f"(f38));
  // PTX:509 mul.f32 %f358, %f354, %f65
  asm("mul.f32 %0, %1, %2;" : "=f"(f358) : "f"(f354), "f"(f65));
  // PTX:510 mul.f32 %f359, %f353, %f62
  asm("mul.f32 %0, %1, %2;" : "=f"(f359) : "f"(f353), "f"(f62));
  // PTX:511 sub.f32 %f360, %f359, %f358
  asm("sub.f32 %0, %1, %2;" : "=f"(f360) : "f"(f359), "f"(f358));
  // PTX:512 div.rn.f32 %f74, %f360, %f38
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f74) : "f"(f360), "f"(f38));
  // PTX:513 mul.f32 %f361, %f354, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f361) : "f"(f354), "f"(f66));
  // PTX:514 mul.f32 %f362, %f353, %f63
  asm("mul.f32 %0, %1, %2;" : "=f"(f362) : "f"(f353), "f"(f63));
  // PTX:515 sub.f32 %f363, %f362, %f361
  asm("sub.f32 %0, %1, %2;" : "=f"(f363) : "f"(f362), "f"(f361));
  // PTX:516 div.rn.f32 %f75, %f363, %f38
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f75) : "f"(f363), "f"(f38));
  // PTX:517 cvt.u32.u64 %r62, %rd275
  asm("cvt.u32.u64 %0, %1;" : "=r"(r62) : "l"(rd275));
  // PTX:518 setp.lt.s32 %p28, %r62, 0
  p28 = (((int)(r62)) < ((int)(0)));
  // PTX:519 neg.f32 %f364, %f64
  asm("neg.f32 %0, %1;" : "=f"(f364) : "f"(f64));
  // PTX:520 div.rn.f32 %f365, %f364, %f51
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f365) : "f"(f364), "f"(f51));
  // PTX:521 neg.f32 %f366, %f65
  asm("neg.f32 %0, %1;" : "=f"(f366) : "f"(f65));
  // PTX:522 div.rn.f32 %f367, %f366, %f51
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f367) : "f"(f366), "f"(f51));
  // PTX:523 neg.f32 %f368, %f66
  asm("neg.f32 %0, %1;" : "=f"(f368) : "f"(f66));
  // PTX:524 div.rn.f32 %f369, %f368, %f51
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f369) : "f"(f368), "f"(f51));
  // PTX:525 div.rn.f32 %f370, %f64, %f51
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f370) : "f"(f64), "f"(f51));
  // PTX:526 mul.f32 %f371, %f370, %f28
  asm("mul.f32 %0, %1, %2;" : "=f"(f371) : "f"(f370), "f"(f28));
  // PTX:527 div.rn.f32 %f372, %f65, %f51
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f372) : "f"(f65), "f"(f51));
  // PTX:528 mul.f32 %f373, %f372, %f28
  asm("mul.f32 %0, %1, %2;" : "=f"(f373) : "f"(f372), "f"(f28));
  // PTX:529 div.rn.f32 %f374, %f66, %f51
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f374) : "f"(f66), "f"(f51));
  // PTX:530 mul.f32 %f375, %f374, %f28
  asm("mul.f32 %0, %1, %2;" : "=f"(f375) : "f"(f374), "f"(f28));
  // PTX:531 fma.rn.f32 %f76, %f365, %f21, %f371
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f76) : "f"(f365), "f"(f21), "f"(f371));
  // PTX:532 fma.rn.f32 %f77, %f367, %f21, %f373
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f77) : "f"(f367), "f"(f21), "f"(f373));
  // PTX:533 fma.rn.f32 %f78, %f369, %f21, %f375
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f78) : "f"(f369), "f"(f21), "f"(f375));
  // PTX:534 mul.f32 %f376, %f370, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f376) : "f"(f370), "f"(f29));
  // PTX:535 mul.f32 %f377, %f372, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f377) : "f"(f372), "f"(f29));
  // PTX:536 mul.f32 %f378, %f374, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f378) : "f"(f374), "f"(f29));
  // PTX:537 fma.rn.f32 %f79, %f365, %f22, %f376
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f79) : "f"(f365), "f"(f22), "f"(f376));
  // PTX:538 fma.rn.f32 %f80, %f367, %f22, %f377
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f80) : "f"(f367), "f"(f22), "f"(f377));
  // PTX:539 fma.rn.f32 %f81, %f369, %f22, %f378
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f81) : "f"(f369), "f"(f22), "f"(f378));
  // PTX:540 mul.f32 %f379, %f370, %f30
  asm("mul.f32 %0, %1, %2;" : "=f"(f379) : "f"(f370), "f"(f30));
  // PTX:541 mul.f32 %f380, %f372, %f30
  asm("mul.f32 %0, %1, %2;" : "=f"(f380) : "f"(f372), "f"(f30));
  // PTX:542 mul.f32 %f381, %f374, %f30
  asm("mul.f32 %0, %1, %2;" : "=f"(f381) : "f"(f374), "f"(f30));
  // PTX:543 fma.rn.f32 %f82, %f365, %f23, %f379
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f82) : "f"(f365), "f"(f23), "f"(f379));
  // PTX:544 fma.rn.f32 %f83, %f367, %f23, %f380
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f83) : "f"(f367), "f"(f23), "f"(f380));
  // PTX:545 fma.rn.f32 %f84, %f369, %f23, %f381
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f84) : "f"(f369), "f"(f23), "f"(f381));
  // PTX:546 mul.f32 %f382, %f370, %f31
  asm("mul.f32 %0, %1, %2;" : "=f"(f382) : "f"(f370), "f"(f31));
  // PTX:547 mul.f32 %f383, %f372, %f31
  asm("mul.f32 %0, %1, %2;" : "=f"(f383) : "f"(f372), "f"(f31));
  // PTX:548 mul.f32 %f384, %f374, %f31
  asm("mul.f32 %0, %1, %2;" : "=f"(f384) : "f"(f374), "f"(f31));
  // PTX:549 fma.rn.f32 %f85, %f365, %f24, %f382
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f85) : "f"(f365), "f"(f24), "f"(f382));
  // PTX:550 fma.rn.f32 %f86, %f367, %f24, %f383
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f86) : "f"(f367), "f"(f24), "f"(f383));
  // PTX:551 fma.rn.f32 %f87, %f369, %f24, %f384
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f87) : "f"(f369), "f"(f24), "f"(f384));
  // PTX:552 div.rn.f32 %f88, %f61, %f50
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f88) : "f"(f61), "f"(f50));
  // PTX:553 div.rn.f32 %f89, %f62, %f50
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f89) : "f"(f62), "f"(f50));
  // PTX:554 div.rn.f32 %f90, %f63, %f50
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f90) : "f"(f63), "f"(f50));
  // PTX:555 neg.f32 %f385, %f61
  asm("neg.f32 %0, %1;" : "=f"(f385) : "f"(f61));
  // PTX:556 div.rn.f32 %f91, %f385, %f50
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f91) : "f"(f385), "f"(f50));
  // PTX:557 neg.f32 %f386, %f62
  asm("neg.f32 %0, %1;" : "=f"(f386) : "f"(f62));
  // PTX:558 div.rn.f32 %f92, %f386, %f50
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f92) : "f"(f386), "f"(f50));
  // PTX:559 neg.f32 %f387, %f63
  asm("neg.f32 %0, %1;" : "=f"(f387) : "f"(f63));
  // PTX:560 div.rn.f32 %f93, %f387, %f50
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f93) : "f"(f387), "f"(f50));
  // PTX:561 @%p28 bra $L__BB70_25
  if (p28) { goto L_BB70_25; }
  // PTX:563 shl.b64 %rd295, %rd315, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd295) : "l"(rd315));
  // PTX:564 ld.param.u64 %rd294, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_0+72]
  rd294 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (72))));
  // PTX:565 cvta.to.global.u64 %rd293, %rd294
  rd293 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd294));
  // PTX:566 add.s64 %rd292, %rd293, %rd295
  asm("add.s64 %0, %1, %2;" : "=l"(rd292) : "l"(rd293), "l"(rd295));
  // PTX:567 ld.param.u64 %rd291, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_0+64]
  rd291 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (64))));
  // PTX:568 cvta.to.global.u64 %rd290, %rd291
  rd290 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd291));
  // PTX:569 add.s64 %rd289, %rd290, %rd295
  asm("add.s64 %0, %1, %2;" : "=l"(rd289) : "l"(rd290), "l"(rd295));
  // PTX:570 ld.param.u64 %rd288, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_0+48]
  rd288 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (48))));
  // PTX:571 cvta.to.global.u64 %rd287, %rd288
  rd287 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd288));
  // PTX:572 add.s64 %rd286, %rd287, %rd295
  asm("add.s64 %0, %1, %2;" : "=l"(rd286) : "l"(rd287), "l"(rd295));
  // PTX:573 sub.f32 %f388, %f88, %f73
  asm("sub.f32 %0, %1, %2;" : "=f"(f388) : "f"(f88), "f"(f73));
  // PTX:574 sub.f32 %f389, %f89, %f74
  asm("sub.f32 %0, %1, %2;" : "=f"(f389) : "f"(f89), "f"(f74));
  // PTX:575 sub.f32 %f390, %f90, %f75
  asm("sub.f32 %0, %1, %2;" : "=f"(f390) : "f"(f90), "f"(f75));
  // PTX:576 ld.global.f32 %f391, [%rd286]
  f391 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd286) + (0)))));
  // PTX:577 ld.global.f32 %f392, [%rd289]
  f392 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd289) + (0)))));
  // PTX:578 mul.f32 %f393, %f73, %f392
  asm("mul.f32 %0, %1, %2;" : "=f"(f393) : "f"(f73), "f"(f392));
  // PTX:579 mul.f32 %f394, %f74, %f392
  asm("mul.f32 %0, %1, %2;" : "=f"(f394) : "f"(f74), "f"(f392));
  // PTX:580 mul.f32 %f395, %f75, %f392
  asm("mul.f32 %0, %1, %2;" : "=f"(f395) : "f"(f75), "f"(f392));
  // PTX:581 fma.rn.f32 %f396, %f388, %f391, %f393
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f396) : "f"(f388), "f"(f391), "f"(f393));
  // PTX:582 fma.rn.f32 %f397, %f389, %f391, %f394
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f397) : "f"(f389), "f"(f391), "f"(f394));
  // PTX:583 fma.rn.f32 %f398, %f390, %f391, %f395
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f398) : "f"(f390), "f"(f391), "f"(f395));
  // PTX:584 ld.global.f32 %f399, [%rd292]
  f399 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd292) + (0)))));
  // PTX:585 fma.rn.f32 %f887, %f91, %f399, %f396
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f887) : "f"(f91), "f"(f399), "f"(f396));
  // PTX:586 fma.rn.f32 %f886, %f92, %f399, %f397
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f886) : "f"(f92), "f"(f399), "f"(f397));
  // PTX:587 fma.rn.f32 %f885, %f93, %f399, %f398
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f885) : "f"(f93), "f"(f399), "f"(f398));
  // PTX:588 ld.global.f32 %f400, [%rd286+4]
  f400 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd286) + (4)))));
  // PTX:589 ld.global.f32 %f401, [%rd289+4]
  f401 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd289) + (4)))));
  // PTX:590 mul.f32 %f402, %f73, %f401
  asm("mul.f32 %0, %1, %2;" : "=f"(f402) : "f"(f73), "f"(f401));
  // PTX:591 mul.f32 %f403, %f74, %f401
  asm("mul.f32 %0, %1, %2;" : "=f"(f403) : "f"(f74), "f"(f401));
  // PTX:592 mul.f32 %f404, %f75, %f401
  asm("mul.f32 %0, %1, %2;" : "=f"(f404) : "f"(f75), "f"(f401));
  // PTX:593 fma.rn.f32 %f405, %f388, %f400, %f402
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f405) : "f"(f388), "f"(f400), "f"(f402));
  // PTX:594 fma.rn.f32 %f406, %f389, %f400, %f403
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f406) : "f"(f389), "f"(f400), "f"(f403));
  // PTX:595 fma.rn.f32 %f407, %f390, %f400, %f404
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f407) : "f"(f390), "f"(f400), "f"(f404));
  // PTX:596 ld.global.f32 %f408, [%rd292+4]
  f408 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd292) + (4)))));
  // PTX:597 fma.rn.f32 %f888, %f91, %f408, %f405
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f888) : "f"(f91), "f"(f408), "f"(f405));
  // PTX:598 fma.rn.f32 %f889, %f92, %f408, %f406
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f889) : "f"(f92), "f"(f408), "f"(f406));
  // PTX:599 fma.rn.f32 %f890, %f93, %f408, %f407
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f890) : "f"(f93), "f"(f408), "f"(f407));
  // PTX:600 ld.global.f32 %f409, [%rd286+8]
  f409 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd286) + (8)))));
  // PTX:601 ld.global.f32 %f410, [%rd289+8]
  f410 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd289) + (8)))));
  // PTX:602 mul.f32 %f411, %f73, %f410
  asm("mul.f32 %0, %1, %2;" : "=f"(f411) : "f"(f73), "f"(f410));
  // PTX:603 mul.f32 %f412, %f74, %f410
  asm("mul.f32 %0, %1, %2;" : "=f"(f412) : "f"(f74), "f"(f410));
  // PTX:604 mul.f32 %f413, %f75, %f410
  asm("mul.f32 %0, %1, %2;" : "=f"(f413) : "f"(f75), "f"(f410));
  // PTX:605 fma.rn.f32 %f414, %f388, %f409, %f411
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f414) : "f"(f388), "f"(f409), "f"(f411));
  // PTX:606 fma.rn.f32 %f415, %f389, %f409, %f412
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f415) : "f"(f389), "f"(f409), "f"(f412));
  // PTX:607 fma.rn.f32 %f416, %f390, %f409, %f413
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f416) : "f"(f390), "f"(f409), "f"(f413));
  // PTX:608 ld.global.f32 %f417, [%rd292+8]
  f417 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd292) + (8)))));
  // PTX:609 fma.rn.f32 %f891, %f91, %f417, %f414
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f891) : "f"(f91), "f"(f417), "f"(f414));
  // PTX:610 fma.rn.f32 %f892, %f92, %f417, %f415
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f892) : "f"(f92), "f"(f417), "f"(f415));
  // PTX:611 fma.rn.f32 %f893, %f93, %f417, %f416
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f893) : "f"(f93), "f"(f417), "f"(f416));
  // PTX:612 ld.global.f32 %f418, [%rd286+12]
  f418 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd286) + (12)))));
  // PTX:613 ld.global.f32 %f419, [%rd289+12]
  f419 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd289) + (12)))));
  // PTX:614 mul.f32 %f420, %f73, %f419
  asm("mul.f32 %0, %1, %2;" : "=f"(f420) : "f"(f73), "f"(f419));
  // PTX:615 mul.f32 %f421, %f74, %f419
  asm("mul.f32 %0, %1, %2;" : "=f"(f421) : "f"(f74), "f"(f419));
  // PTX:616 mul.f32 %f422, %f75, %f419
  asm("mul.f32 %0, %1, %2;" : "=f"(f422) : "f"(f75), "f"(f419));
  // PTX:617 fma.rn.f32 %f423, %f388, %f418, %f420
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f423) : "f"(f388), "f"(f418), "f"(f420));
  // PTX:618 fma.rn.f32 %f424, %f389, %f418, %f421
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f424) : "f"(f389), "f"(f418), "f"(f421));
  // PTX:619 fma.rn.f32 %f425, %f390, %f418, %f422
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f425) : "f"(f390), "f"(f418), "f"(f422));
  // PTX:620 ld.global.f32 %f426, [%rd292+12]
  f426 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd292) + (12)))));
  // PTX:621 fma.rn.f32 %f894, %f91, %f426, %f423
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f894) : "f"(f91), "f"(f426), "f"(f423));
  // PTX:622 fma.rn.f32 %f895, %f92, %f426, %f424
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f895) : "f"(f92), "f"(f426), "f"(f424));
  // PTX:623 fma.rn.f32 %f896, %f93, %f426, %f425
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f896) : "f"(f93), "f"(f426), "f"(f425));
  // PTX:625 $L__BB70_25:
L_BB70_25:;
  // PTX:626 ld.param.u64 %rd276, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_5]
  rd276 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:627 cvta.to.global.u64 %rd119, %rd276
  rd119 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd276));
  // PTX:628 shl.b64 %rd120, %rd6, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd120) : "l"(rd6));
  // PTX:629 add.s64 %rd121, %rd119, %rd120
  asm("add.s64 %0, %1, %2;" : "=l"(rd121) : "l"(rd119), "l"(rd120));
  // PTX:630 ld.global.u32 %r63, [%rd121]
  r63 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd121) + (0)))));
  // PTX:631 setp.eq.s32 %p29, %r63, 0
  p29 = (((int)(r63)) == ((int)(0)));
  // PTX:632 @%p29 bra $L__BB70_27
  if (p29) { goto L_BB70_27; }
  // PTX:634 ld.param.u64 %rd277, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_4]
  rd277 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:635 cvta.to.global.u64 %rd122, %rd277
  rd122 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd277));
  // PTX:636 add.s64 %rd124, %rd122, %rd120
  asm("add.s64 %0, %1, %2;" : "=l"(rd124) : "l"(rd122), "l"(rd120));
  // PTX:637 ld.global.f32 %f903, [%rd124]
  f903 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd124) + (0)))));
  // PTX:639 $L__BB70_41:
L_BB70_41:;
  // PTX:640 ld.param.u64 %rd278, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_1]
  rd278 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:641 ld.param.f32 %f872, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_6]
  f872 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param6 + (0))));
  // PTX:642 sub.f32 %f591, %f903, %f884
  asm("sub.f32 %0, %1, %2;" : "=f"(f591) : "f"(f903), "f"(f884));
  // PTX:643 div.rn.f32 %f592, %f591, 0f40C90FDB
  asm("div.rn.f32 %0, %1, 0f40C90FDB;" : "=f"(f592) : "f"(f591));
  // PTX:644 mov.b32 %r89, %f592
  asm("mov.b32 %0, %1;" : "=r"(r89) : "f"(f592));
  // PTX:645 and.b32 %r90, %r89, -2147483648
  asm("and.b32 %0, %1, -2147483648;" : "=r"(r90) : "r"(r89));
  // PTX:646 or.b32 %r91, %r90, 1056964608
  asm("or.b32 %0, %1, 1056964608;" : "=r"(r91) : "r"(r90));
  // PTX:647 mov.b32 %f593, %r91
  asm("mov.b32 %0, %1;" : "=f"(f593) : "r"(r91));
  // PTX:648 add.rz.f32 %f594, %f592, %f593
  asm("add.rz.f32 %0, %1, %2;" : "=f"(f594) : "f"(f592), "f"(f593));
  // PTX:649 cvt.rzi.f32.f32 %f595, %f594
  asm("cvt.rzi.f32.f32 %0, %1;" : "=f"(f595) : "f"(f594));
  // PTX:650 fma.rn.f32 %f161, %f595, 0f40C90FDB, %f884
  asm("fma.rn.f32 %0, %1, 0f40C90FDB, %2;" : "=f"(f161) : "f"(f595), "f"(f884));
  // PTX:651 sub.f32 %f596, %f161, %f903
  asm("sub.f32 %0, %1, %2;" : "=f"(f596) : "f"(f161), "f"(f903));
  // PTX:652 mul.f32 %f162, %f596, %f872
  asm("mul.f32 %0, %1, %2;" : "=f"(f162) : "f"(f596), "f"(f872));
  // PTX:653 cvta.to.global.u64 %rd141, %rd278
  rd141 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd278));
  // PTX:654 shl.b64 %rd142, %rd11, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd142) : "l"(rd11));
  // PTX:655 add.s64 %rd143, %rd141, %rd142
  asm("add.s64 %0, %1, %2;" : "=l"(rd143) : "l"(rd141), "l"(rd142));
  // PTX:656 ld.global.f32 %f163, [%rd143]
  f163 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd143) + (0)))));
  // PTX:657 setp.lt.f32 %p50, %f161, %f163
  p50 = (!(isnan(((float)(f161))) || isnan(((float)(f163)))) && (((float)(f161)) < ((float)(f163))));
  // PTX:658 @%p50 bra $L__BB70_44
  if (p50) { goto L_BB70_44; }
  // PTX:659 bra.uni $L__BB70_42
  goto L_BB70_42;
  // PTX:661 $L__BB70_44:
L_BB70_44:;
  // PTX:662 sub.f32 %f602, %f163, %f161
  asm("sub.f32 %0, %1, %2;" : "=f"(f602) : "f"(f163), "f"(f161));
  // PTX:663 mul.f32 %f603, %f1, %f602
  asm("mul.f32 %0, %1, %2;" : "=f"(f603) : "f"(f1), "f"(f602));
  // PTX:664 mul.f32 %f604, %f2, %f162
  asm("mul.f32 %0, %1, %2;" : "=f"(f604) : "f"(f2), "f"(f162));
  // PTX:665 sub.f32 %f605, %f603, %f604
  asm("sub.f32 %0, %1, %2;" : "=f"(f605) : "f"(f603), "f"(f604));
  // PTX:666 mov.f32 %f606, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f606) : );
  // PTX:667 max.f32 %f904, %f606, %f605
  asm("max.f32 %0, %1, %2;" : "=f"(f904) : "f"(f606), "f"(f605));
  // PTX:668 bra.uni $L__BB70_45
  goto L_BB70_45;
  // PTX:670 $L__BB70_27:
L_BB70_27:;
  // PTX:671 @%p28 bra $L__BB70_29
  if (p28) { goto L_BB70_29; }
  // PTX:673 ld.param.u64 %rd313, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_0]
  rd313 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:674 mul.wide.s32 %rd312, %r32, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd312) : "r"(r32));
  // PTX:675 cvta.to.global.u64 %rd311, %rd313
  rd311 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd313));
  // PTX:676 add.s64 %rd310, %rd311, %rd312
  asm("add.s64 %0, %1, %2;" : "=l"(rd310) : "l"(rd311), "l"(rd312));
  // PTX:677 shl.b64 %rd307, %rd315, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd307) : "l"(rd315));
  // PTX:678 ld.param.u64 %rd306, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_0+72]
  rd306 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (72))));
  // PTX:679 cvta.to.global.u64 %rd305, %rd306
  rd305 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd306));
  // PTX:680 add.s64 %rd304, %rd305, %rd307
  asm("add.s64 %0, %1, %2;" : "=l"(rd304) : "l"(rd305), "l"(rd307));
  // PTX:681 ld.param.u64 %rd303, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_0+64]
  rd303 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (64))));
  // PTX:682 cvta.to.global.u64 %rd302, %rd303
  rd302 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd303));
  // PTX:683 add.s64 %rd301, %rd302, %rd307
  asm("add.s64 %0, %1, %2;" : "=l"(rd301) : "l"(rd302), "l"(rd307));
  // PTX:684 ld.param.u64 %rd300, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_0+48]
  rd300 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (48))));
  // PTX:685 cvta.to.global.u64 %rd299, %rd300
  rd299 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd300));
  // PTX:686 add.s64 %rd298, %rd299, %rd307
  asm("add.s64 %0, %1, %2;" : "=l"(rd298) : "l"(rd299), "l"(rd307));
  // PTX:687 ld.param.u64 %rd297, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_3]
  rd297 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:688 cvta.to.global.u64 %rd296, %rd297
  rd296 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd297));
  // PTX:689 ld.global.u32 %r65, [%rd310]
  r65 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd310) + (0)))));
  // PTX:690 add.s32 %r66, %r65, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r66) : "r"(r65), "r"(r1));
  // PTX:691 ld.global.u32 %r67, [%rd310+4]
  r67 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd310) + (4)))));
  // PTX:692 add.s32 %r68, %r67, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r68) : "r"(r67), "r"(r1));
  // PTX:693 ld.global.u32 %r69, [%rd310+8]
  r69 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd310) + (8)))));
  // PTX:694 add.s32 %r70, %r69, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r70) : "r"(r69), "r"(r1));
  // PTX:695 ld.global.u32 %r71, [%rd310+12]
  r71 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd310) + (12)))));
  // PTX:696 add.s32 %r72, %r71, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r72) : "r"(r71), "r"(r1));
  // PTX:697 mul.wide.s32 %rd125, %r66, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd125) : "r"(r66));
  // PTX:698 add.s64 %rd126, %rd296, %rd125
  asm("add.s64 %0, %1, %2;" : "=l"(rd126) : "l"(rd296), "l"(rd125));
  // PTX:699 ld.global.f32 %f427, [%rd126]
  f427 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd126) + (0)))));
  // PTX:700 ld.global.f32 %f428, [%rd298]
  f428 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd298) + (0)))));
  // PTX:701 ld.global.f32 %f429, [%rd126+4]
  f429 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd126) + (4)))));
  // PTX:702 ld.global.f32 %f430, [%rd126+8]
  f430 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd126) + (8)))));
  // PTX:703 mul.wide.s32 %rd127, %r68, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd127) : "r"(r68));
  // PTX:704 add.s64 %rd128, %rd296, %rd127
  asm("add.s64 %0, %1, %2;" : "=l"(rd128) : "l"(rd296), "l"(rd127));
  // PTX:705 ld.global.f32 %f431, [%rd128]
  f431 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd128) + (0)))));
  // PTX:706 ld.global.f32 %f432, [%rd298+4]
  f432 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd298) + (4)))));
  // PTX:707 mul.f32 %f433, %f432, %f431
  asm("mul.f32 %0, %1, %2;" : "=f"(f433) : "f"(f432), "f"(f431));
  // PTX:708 ld.global.f32 %f434, [%rd128+4]
  f434 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd128) + (4)))));
  // PTX:709 mul.f32 %f435, %f432, %f434
  asm("mul.f32 %0, %1, %2;" : "=f"(f435) : "f"(f432), "f"(f434));
  // PTX:710 ld.global.f32 %f436, [%rd128+8]
  f436 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd128) + (8)))));
  // PTX:711 mul.f32 %f437, %f432, %f436
  asm("mul.f32 %0, %1, %2;" : "=f"(f437) : "f"(f432), "f"(f436));
  // PTX:712 fma.rn.f32 %f438, %f428, %f427, %f433
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f438) : "f"(f428), "f"(f427), "f"(f433));
  // PTX:713 fma.rn.f32 %f439, %f428, %f429, %f435
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f439) : "f"(f428), "f"(f429), "f"(f435));
  // PTX:714 fma.rn.f32 %f440, %f428, %f430, %f437
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f440) : "f"(f428), "f"(f430), "f"(f437));
  // PTX:715 mul.wide.s32 %rd129, %r70, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd129) : "r"(r70));
  // PTX:716 add.s64 %rd130, %rd296, %rd129
  asm("add.s64 %0, %1, %2;" : "=l"(rd130) : "l"(rd296), "l"(rd129));
  // PTX:717 ld.global.f32 %f441, [%rd130]
  f441 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd130) + (0)))));
  // PTX:718 ld.global.f32 %f442, [%rd298+8]
  f442 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd298) + (8)))));
  // PTX:719 ld.global.f32 %f443, [%rd130+4]
  f443 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd130) + (4)))));
  // PTX:720 ld.global.f32 %f444, [%rd130+8]
  f444 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd130) + (8)))));
  // PTX:721 fma.rn.f32 %f445, %f442, %f441, %f438
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f445) : "f"(f442), "f"(f441), "f"(f438));
  // PTX:722 fma.rn.f32 %f446, %f442, %f443, %f439
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f446) : "f"(f442), "f"(f443), "f"(f439));
  // PTX:723 fma.rn.f32 %f447, %f442, %f444, %f440
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f447) : "f"(f442), "f"(f444), "f"(f440));
  // PTX:724 mul.wide.s32 %rd131, %r72, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd131) : "r"(r72));
  // PTX:725 add.s64 %rd132, %rd296, %rd131
  asm("add.s64 %0, %1, %2;" : "=l"(rd132) : "l"(rd296), "l"(rd131));
  // PTX:726 ld.global.f32 %f448, [%rd132]
  f448 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd132) + (0)))));
  // PTX:727 ld.global.f32 %f449, [%rd298+12]
  f449 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd298) + (12)))));
  // PTX:728 ld.global.f32 %f450, [%rd132+4]
  f450 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd132) + (4)))));
  // PTX:729 ld.global.f32 %f451, [%rd132+8]
  f451 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd132) + (8)))));
  // PTX:730 fma.rn.f32 %f900, %f449, %f448, %f445
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f900) : "f"(f449), "f"(f448), "f"(f445));
  // PTX:731 fma.rn.f32 %f901, %f449, %f450, %f446
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f901) : "f"(f449), "f"(f450), "f"(f446));
  // PTX:732 fma.rn.f32 %f902, %f449, %f451, %f447
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f902) : "f"(f449), "f"(f451), "f"(f447));
  // PTX:733 ld.global.f32 %f452, [%rd301]
  f452 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd301) + (0)))));
  // PTX:734 ld.global.f32 %f453, [%rd301+4]
  f453 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd301) + (4)))));
  // PTX:735 mul.f32 %f454, %f453, %f431
  asm("mul.f32 %0, %1, %2;" : "=f"(f454) : "f"(f453), "f"(f431));
  // PTX:736 mul.f32 %f455, %f453, %f434
  asm("mul.f32 %0, %1, %2;" : "=f"(f455) : "f"(f453), "f"(f434));
  // PTX:737 mul.f32 %f456, %f453, %f436
  asm("mul.f32 %0, %1, %2;" : "=f"(f456) : "f"(f453), "f"(f436));
  // PTX:738 fma.rn.f32 %f457, %f452, %f427, %f454
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f457) : "f"(f452), "f"(f427), "f"(f454));
  // PTX:739 fma.rn.f32 %f458, %f452, %f429, %f455
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f458) : "f"(f452), "f"(f429), "f"(f455));
  // PTX:740 fma.rn.f32 %f459, %f452, %f430, %f456
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f459) : "f"(f452), "f"(f430), "f"(f456));
  // PTX:741 ld.global.f32 %f460, [%rd301+8]
  f460 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd301) + (8)))));
  // PTX:742 fma.rn.f32 %f461, %f460, %f441, %f457
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f461) : "f"(f460), "f"(f441), "f"(f457));
  // PTX:743 fma.rn.f32 %f462, %f460, %f443, %f458
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f462) : "f"(f460), "f"(f443), "f"(f458));
  // PTX:744 fma.rn.f32 %f463, %f460, %f444, %f459
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f463) : "f"(f460), "f"(f444), "f"(f459));
  // PTX:745 ld.global.f32 %f464, [%rd301+12]
  f464 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd301) + (12)))));
  // PTX:746 fma.rn.f32 %f897, %f464, %f448, %f461
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f897) : "f"(f464), "f"(f448), "f"(f461));
  // PTX:747 fma.rn.f32 %f898, %f464, %f450, %f462
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f898) : "f"(f464), "f"(f450), "f"(f462));
  // PTX:748 fma.rn.f32 %f899, %f464, %f451, %f463
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f899) : "f"(f464), "f"(f451), "f"(f463));
  // PTX:749 ld.global.f32 %f465, [%rd304]
  f465 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd304) + (0)))));
  // PTX:750 ld.global.f32 %f466, [%rd304+4]
  f466 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd304) + (4)))));
  // PTX:751 mul.f32 %f467, %f466, %f431
  asm("mul.f32 %0, %1, %2;" : "=f"(f467) : "f"(f466), "f"(f431));
  // PTX:752 mul.f32 %f468, %f466, %f434
  asm("mul.f32 %0, %1, %2;" : "=f"(f468) : "f"(f466), "f"(f434));
  // PTX:753 mul.f32 %f469, %f466, %f436
  asm("mul.f32 %0, %1, %2;" : "=f"(f469) : "f"(f466), "f"(f436));
  // PTX:754 fma.rn.f32 %f470, %f465, %f427, %f467
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f470) : "f"(f465), "f"(f427), "f"(f467));
  // PTX:755 fma.rn.f32 %f471, %f465, %f429, %f468
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f471) : "f"(f465), "f"(f429), "f"(f468));
  // PTX:756 fma.rn.f32 %f472, %f465, %f430, %f469
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f472) : "f"(f465), "f"(f430), "f"(f469));
  // PTX:757 ld.global.f32 %f473, [%rd304+8]
  f473 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd304) + (8)))));
  // PTX:758 fma.rn.f32 %f474, %f473, %f441, %f470
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f474) : "f"(f473), "f"(f441), "f"(f470));
  // PTX:759 fma.rn.f32 %f475, %f473, %f443, %f471
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f475) : "f"(f473), "f"(f443), "f"(f471));
  // PTX:760 fma.rn.f32 %f476, %f473, %f444, %f472
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f476) : "f"(f473), "f"(f444), "f"(f472));
  // PTX:761 ld.global.f32 %f477, [%rd304+12]
  f477 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd304) + (12)))));
  // PTX:762 fma.rn.f32 %f478, %f477, %f448, %f474
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f478) : "f"(f477), "f"(f448), "f"(f474));
  // PTX:763 fma.rn.f32 %f479, %f477, %f450, %f475
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f479) : "f"(f477), "f"(f450), "f"(f475));
  // PTX:764 fma.rn.f32 %f480, %f477, %f451, %f476
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f480) : "f"(f477), "f"(f451), "f"(f476));
  // PTX:765 mov.b32 %r106, %f480
  asm("mov.b32 %0, %1;" : "=r"(r106) : "f"(f480));
  // PTX:766 mov.b32 %r105, %f479
  asm("mov.b32 %0, %1;" : "=r"(r105) : "f"(f479));
  // PTX:767 mov.b32 %r104, %f478
  asm("mov.b32 %0, %1;" : "=r"(r104) : "f"(f478));
  // PTX:769 $L__BB70_29:
L_BB70_29:;
  // PTX:770 ld.param.u64 %rd309, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_3]
  rd309 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:771 cvta.to.global.u64 %rd308, %rd309
  rd308 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd309));
  // PTX:772 mul.lo.s64 %rd133, %rd28, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd133) : "l"(rd28));
  // PTX:773 add.s64 %rd134, %rd308, %rd133
  asm("add.s64 %0, %1, %2;" : "=l"(rd134) : "l"(rd308), "l"(rd133));
  // PTX:774 ld.global.f32 %f481, [%rd134]
  f481 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd134) + (0)))));
  // PTX:775 ld.global.f32 %f482, [%rd134+4]
  f482 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd134) + (4)))));
  // PTX:776 ld.global.f32 %f483, [%rd134+8]
  f483 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd134) + (8)))));
  // PTX:777 mul.lo.s64 %rd135, %rd29, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd135) : "l"(rd29));
  // PTX:778 add.s64 %rd136, %rd308, %rd135
  asm("add.s64 %0, %1, %2;" : "=l"(rd136) : "l"(rd308), "l"(rd135));
  // PTX:779 ld.global.f32 %f484, [%rd136]
  f484 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd136) + (0)))));
  // PTX:780 mul.f32 %f485, %f22, %f484
  asm("mul.f32 %0, %1, %2;" : "=f"(f485) : "f"(f22), "f"(f484));
  // PTX:781 ld.global.f32 %f486, [%rd136+4]
  f486 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd136) + (4)))));
  // PTX:782 mul.f32 %f487, %f22, %f486
  asm("mul.f32 %0, %1, %2;" : "=f"(f487) : "f"(f22), "f"(f486));
  // PTX:783 ld.global.f32 %f488, [%rd136+8]
  f488 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd136) + (8)))));
  // PTX:784 mul.f32 %f489, %f22, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f489) : "f"(f22), "f"(f488));
  // PTX:785 fma.rn.f32 %f490, %f21, %f481, %f485
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f490) : "f"(f21), "f"(f481), "f"(f485));
  // PTX:786 fma.rn.f32 %f491, %f21, %f482, %f487
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f491) : "f"(f21), "f"(f482), "f"(f487));
  // PTX:787 fma.rn.f32 %f492, %f21, %f483, %f489
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f492) : "f"(f21), "f"(f483), "f"(f489));
  // PTX:788 mul.lo.s64 %rd137, %rd30, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd137) : "l"(rd30));
  // PTX:789 add.s64 %rd138, %rd308, %rd137
  asm("add.s64 %0, %1, %2;" : "=l"(rd138) : "l"(rd308), "l"(rd137));
  // PTX:790 ld.global.f32 %f493, [%rd138]
  f493 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd138) + (0)))));
  // PTX:791 ld.global.f32 %f494, [%rd138+4]
  f494 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd138) + (4)))));
  // PTX:792 ld.global.f32 %f495, [%rd138+8]
  f495 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd138) + (8)))));
  // PTX:793 fma.rn.f32 %f496, %f23, %f493, %f490
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f496) : "f"(f23), "f"(f493), "f"(f490));
  // PTX:794 fma.rn.f32 %f497, %f23, %f494, %f491
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f497) : "f"(f23), "f"(f494), "f"(f491));
  // PTX:795 fma.rn.f32 %f498, %f23, %f495, %f492
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f498) : "f"(f23), "f"(f495), "f"(f492));
  // PTX:796 mul.lo.s64 %rd139, %rd31, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd139) : "l"(rd31));
  // PTX:797 add.s64 %rd140, %rd308, %rd139
  asm("add.s64 %0, %1, %2;" : "=l"(rd140) : "l"(rd308), "l"(rd139));
  // PTX:798 ld.global.f32 %f499, [%rd140]
  f499 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd140) + (0)))));
  // PTX:799 ld.global.f32 %f500, [%rd140+4]
  f500 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd140) + (4)))));
  // PTX:800 ld.global.f32 %f501, [%rd140+8]
  f501 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd140) + (8)))));
  // PTX:801 fma.rn.f32 %f131, %f24, %f499, %f496
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f131) : "f"(f24), "f"(f499), "f"(f496));
  // PTX:802 fma.rn.f32 %f132, %f24, %f500, %f497
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f132) : "f"(f24), "f"(f500), "f"(f497));
  // PTX:803 fma.rn.f32 %f133, %f24, %f501, %f498
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f133) : "f"(f24), "f"(f501), "f"(f498));
  // PTX:804 mul.f32 %f502, %f29, %f484
  asm("mul.f32 %0, %1, %2;" : "=f"(f502) : "f"(f29), "f"(f484));
  // PTX:805 mul.f32 %f503, %f29, %f486
  asm("mul.f32 %0, %1, %2;" : "=f"(f503) : "f"(f29), "f"(f486));
  // PTX:806 mul.f32 %f504, %f29, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f504) : "f"(f29), "f"(f488));
  // PTX:807 fma.rn.f32 %f505, %f28, %f481, %f502
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f505) : "f"(f28), "f"(f481), "f"(f502));
  // PTX:808 fma.rn.f32 %f506, %f28, %f482, %f503
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f506) : "f"(f28), "f"(f482), "f"(f503));
  // PTX:809 fma.rn.f32 %f507, %f28, %f483, %f504
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f507) : "f"(f28), "f"(f483), "f"(f504));
  // PTX:810 fma.rn.f32 %f508, %f30, %f493, %f505
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f508) : "f"(f30), "f"(f493), "f"(f505));
  // PTX:811 fma.rn.f32 %f509, %f30, %f494, %f506
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f509) : "f"(f30), "f"(f494), "f"(f506));
  // PTX:812 fma.rn.f32 %f510, %f30, %f495, %f507
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f510) : "f"(f30), "f"(f495), "f"(f507));
  // PTX:813 fma.rn.f32 %f134, %f31, %f499, %f508
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f134) : "f"(f31), "f"(f499), "f"(f508));
  // PTX:814 fma.rn.f32 %f135, %f31, %f500, %f509
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f135) : "f"(f31), "f"(f500), "f"(f509));
  // PTX:815 fma.rn.f32 %f136, %f31, %f501, %f510
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f136) : "f"(f31), "f"(f501), "f"(f510));
  // PTX:816 sub.f32 %f137, %f897, %f900
  asm("sub.f32 %0, %1, %2;" : "=f"(f137) : "f"(f897), "f"(f900));
  // PTX:817 sub.f32 %f138, %f898, %f901
  asm("sub.f32 %0, %1, %2;" : "=f"(f138) : "f"(f898), "f"(f901));
  // PTX:818 mul.f32 %f511, %f138, %f138
  asm("mul.f32 %0, %1, %2;" : "=f"(f511) : "f"(f138), "f"(f138));
  // PTX:819 sub.f32 %f139, %f899, %f902
  asm("sub.f32 %0, %1, %2;" : "=f"(f139) : "f"(f899), "f"(f902));
  // PTX:820 fma.rn.f32 %f512, %f137, %f137, %f511
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f512) : "f"(f137), "f"(f137), "f"(f511));
  // PTX:821 fma.rn.f32 %f513, %f139, %f139, %f512
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f513) : "f"(f139), "f"(f139), "f"(f512));
  // PTX:822 sqrt.rn.f32 %f140, %f513
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f140) : "f"(f513));
  // PTX:823 setp.leu.f32 %p31, %f140, 0f322BCC77
  p31 = ((isnan(((float)(f140))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f140)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:824 @%p31 bra $L__BB70_68
  if (p31) { goto L_BB70_68; }
  // PTX:826 abs.f32 %f514, %f140
  asm("abs.f32 %0, %1;" : "=f"(f514) : "f"(f140));
  // PTX:827 setp.geu.f32 %p32, %f514, 0f7F800000
  p32 = ((isnan(((float)(f514))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f514)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:828 @%p32 bra $L__BB70_68
  if (p32) { goto L_BB70_68; }
  // PTX:830 div.rn.f32 %f141, %f137, %f140
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f141) : "f"(f137), "f"(f140));
  // PTX:831 mov.b32 %f515, %r104
  asm("mov.b32 %0, %1;" : "=f"(f515) : "r"(r104));
  // PTX:832 sub.f32 %f516, %f515, %f900
  asm("sub.f32 %0, %1, %2;" : "=f"(f516) : "f"(f515), "f"(f900));
  // PTX:833 mov.b32 %f517, %r105
  asm("mov.b32 %0, %1;" : "=f"(f517) : "r"(r105));
  // PTX:834 sub.f32 %f518, %f517, %f901
  asm("sub.f32 %0, %1, %2;" : "=f"(f518) : "f"(f517), "f"(f901));
  // PTX:835 mov.b32 %f519, %r106
  asm("mov.b32 %0, %1;" : "=f"(f519) : "r"(r106));
  // PTX:836 sub.f32 %f520, %f519, %f902
  asm("sub.f32 %0, %1, %2;" : "=f"(f520) : "f"(f519), "f"(f902));
  // PTX:837 div.rn.f32 %f142, %f138, %f140
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f142) : "f"(f138), "f"(f140));
  // PTX:838 mul.f32 %f521, %f518, %f142
  asm("mul.f32 %0, %1, %2;" : "=f"(f521) : "f"(f518), "f"(f142));
  // PTX:839 div.rn.f32 %f143, %f139, %f140
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f143) : "f"(f139), "f"(f140));
  // PTX:840 fma.rn.f32 %f522, %f516, %f141, %f521
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f522) : "f"(f516), "f"(f141), "f"(f521));
  // PTX:841 fma.rn.f32 %f523, %f520, %f143, %f522
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f523) : "f"(f520), "f"(f143), "f"(f522));
  // PTX:842 mul.f32 %f524, %f141, %f523
  asm("mul.f32 %0, %1, %2;" : "=f"(f524) : "f"(f141), "f"(f523));
  // PTX:843 mul.f32 %f525, %f142, %f523
  asm("mul.f32 %0, %1, %2;" : "=f"(f525) : "f"(f142), "f"(f523));
  // PTX:844 mul.f32 %f526, %f143, %f523
  asm("mul.f32 %0, %1, %2;" : "=f"(f526) : "f"(f143), "f"(f523));
  // PTX:845 sub.f32 %f144, %f516, %f524
  asm("sub.f32 %0, %1, %2;" : "=f"(f144) : "f"(f516), "f"(f524));
  // PTX:846 sub.f32 %f145, %f518, %f525
  asm("sub.f32 %0, %1, %2;" : "=f"(f145) : "f"(f518), "f"(f525));
  // PTX:847 sub.f32 %f146, %f520, %f526
  asm("sub.f32 %0, %1, %2;" : "=f"(f146) : "f"(f520), "f"(f526));
  // PTX:848 sub.f32 %f527, %f134, %f131
  asm("sub.f32 %0, %1, %2;" : "=f"(f527) : "f"(f134), "f"(f131));
  // PTX:849 sub.f32 %f528, %f135, %f132
  asm("sub.f32 %0, %1, %2;" : "=f"(f528) : "f"(f135), "f"(f132));
  // PTX:850 mul.f32 %f529, %f528, %f142
  asm("mul.f32 %0, %1, %2;" : "=f"(f529) : "f"(f528), "f"(f142));
  // PTX:851 sub.f32 %f530, %f136, %f133
  asm("sub.f32 %0, %1, %2;" : "=f"(f530) : "f"(f136), "f"(f133));
  // PTX:852 fma.rn.f32 %f531, %f527, %f141, %f529
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f531) : "f"(f527), "f"(f141), "f"(f529));
  // PTX:853 fma.rn.f32 %f532, %f143, %f530, %f531
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f532) : "f"(f143), "f"(f530), "f"(f531));
  // PTX:854 mul.f32 %f533, %f141, %f532
  asm("mul.f32 %0, %1, %2;" : "=f"(f533) : "f"(f141), "f"(f532));
  // PTX:855 mul.f32 %f534, %f142, %f532
  asm("mul.f32 %0, %1, %2;" : "=f"(f534) : "f"(f142), "f"(f532));
  // PTX:856 mul.f32 %f535, %f143, %f532
  asm("mul.f32 %0, %1, %2;" : "=f"(f535) : "f"(f143), "f"(f532));
  // PTX:857 sub.f32 %f147, %f527, %f533
  asm("sub.f32 %0, %1, %2;" : "=f"(f147) : "f"(f527), "f"(f533));
  // PTX:858 sub.f32 %f148, %f528, %f534
  asm("sub.f32 %0, %1, %2;" : "=f"(f148) : "f"(f528), "f"(f534));
  // PTX:859 sub.f32 %f149, %f530, %f535
  asm("sub.f32 %0, %1, %2;" : "=f"(f149) : "f"(f530), "f"(f535));
  // PTX:860 mul.f32 %f536, %f145, %f145
  asm("mul.f32 %0, %1, %2;" : "=f"(f536) : "f"(f145), "f"(f145));
  // PTX:861 fma.rn.f32 %f537, %f144, %f144, %f536
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f537) : "f"(f144), "f"(f144), "f"(f536));
  // PTX:862 fma.rn.f32 %f538, %f146, %f146, %f537
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f538) : "f"(f146), "f"(f146), "f"(f537));
  // PTX:863 sqrt.rn.f32 %f150, %f538
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f150) : "f"(f538));
  // PTX:864 mul.f32 %f539, %f148, %f148
  asm("mul.f32 %0, %1, %2;" : "=f"(f539) : "f"(f148), "f"(f148));
  // PTX:865 fma.rn.f32 %f540, %f147, %f147, %f539
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f540) : "f"(f147), "f"(f147), "f"(f539));
  // PTX:866 fma.rn.f32 %f541, %f149, %f149, %f540
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f541) : "f"(f149), "f"(f149), "f"(f540));
  // PTX:867 sqrt.rn.f32 %f151, %f541
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f151) : "f"(f541));
  // PTX:868 setp.leu.f32 %p33, %f150, 0f322BCC77
  p33 = ((isnan(((float)(f150))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f150)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:869 setp.leu.f32 %p34, %f151, 0f322BCC77
  p34 = ((isnan(((float)(f151))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f151)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:870 or.pred %p35, %p33, %p34
  p35 = ((p33) || (p34));
  // PTX:871 @%p35 bra $L__BB70_68
  if (p35) { goto L_BB70_68; }
  // PTX:873 abs.f32 %f542, %f150
  asm("abs.f32 %0, %1;" : "=f"(f542) : "f"(f150));
  // PTX:874 setp.geu.f32 %p36, %f542, 0f7F800000
  p36 = ((isnan(((float)(f542))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f542)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:875 @%p36 bra $L__BB70_68
  if (p36) { goto L_BB70_68; }
  // PTX:877 abs.f32 %f543, %f151
  asm("abs.f32 %0, %1;" : "=f"(f543) : "f"(f151));
  // PTX:878 setp.geu.f32 %p37, %f543, 0f7F800000
  p37 = ((isnan(((float)(f543))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f543)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:879 @%p37 bra $L__BB70_68
  if (p37) { goto L_BB70_68; }
  // PTX:881 div.rn.f32 %f544, %f144, %f150
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f544) : "f"(f144), "f"(f150));
  // PTX:882 div.rn.f32 %f545, %f149, %f151
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f545) : "f"(f149), "f"(f151));
  // PTX:883 div.rn.f32 %f546, %f145, %f150
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f546) : "f"(f145), "f"(f150));
  // PTX:884 mul.f32 %f547, %f546, %f545
  asm("mul.f32 %0, %1, %2;" : "=f"(f547) : "f"(f546), "f"(f545));
  // PTX:885 div.rn.f32 %f548, %f148, %f151
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f548) : "f"(f148), "f"(f151));
  // PTX:886 div.rn.f32 %f549, %f146, %f150
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f549) : "f"(f146), "f"(f150));
  // PTX:887 mul.f32 %f550, %f549, %f548
  asm("mul.f32 %0, %1, %2;" : "=f"(f550) : "f"(f549), "f"(f548));
  // PTX:888 sub.f32 %f551, %f547, %f550
  asm("sub.f32 %0, %1, %2;" : "=f"(f551) : "f"(f547), "f"(f550));
  // PTX:889 div.rn.f32 %f552, %f147, %f151
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f552) : "f"(f147), "f"(f151));
  // PTX:890 mul.f32 %f553, %f549, %f552
  asm("mul.f32 %0, %1, %2;" : "=f"(f553) : "f"(f549), "f"(f552));
  // PTX:891 mul.f32 %f554, %f544, %f545
  asm("mul.f32 %0, %1, %2;" : "=f"(f554) : "f"(f544), "f"(f545));
  // PTX:892 sub.f32 %f555, %f553, %f554
  asm("sub.f32 %0, %1, %2;" : "=f"(f555) : "f"(f553), "f"(f554));
  // PTX:893 mul.f32 %f556, %f544, %f548
  asm("mul.f32 %0, %1, %2;" : "=f"(f556) : "f"(f544), "f"(f548));
  // PTX:894 mul.f32 %f557, %f546, %f552
  asm("mul.f32 %0, %1, %2;" : "=f"(f557) : "f"(f546), "f"(f552));
  // PTX:895 sub.f32 %f558, %f556, %f557
  asm("sub.f32 %0, %1, %2;" : "=f"(f558) : "f"(f556), "f"(f557));
  // PTX:896 mul.f32 %f559, %f142, %f555
  asm("mul.f32 %0, %1, %2;" : "=f"(f559) : "f"(f142), "f"(f555));
  // PTX:897 fma.rn.f32 %f560, %f141, %f551, %f559
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f560) : "f"(f141), "f"(f551), "f"(f559));
  // PTX:898 fma.rn.f32 %f152, %f143, %f558, %f560
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f152) : "f"(f143), "f"(f558), "f"(f560));
  // PTX:899 mul.f32 %f561, %f546, %f548
  asm("mul.f32 %0, %1, %2;" : "=f"(f561) : "f"(f546), "f"(f548));
  // PTX:900 fma.rn.f32 %f562, %f544, %f552, %f561
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f562) : "f"(f544), "f"(f552), "f"(f561));
  // PTX:901 fma.rn.f32 %f153, %f549, %f545, %f562
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f153) : "f"(f549), "f"(f545), "f"(f562));
  // PTX:902 mul.f32 %f563, %f152, %f152
  asm("mul.f32 %0, %1, %2;" : "=f"(f563) : "f"(f152), "f"(f152));
  // PTX:903 fma.rn.f32 %f154, %f153, %f153, %f563
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f154) : "f"(f153), "f"(f153), "f"(f563));
  // PTX:904 setp.leu.f32 %p38, %f154, 0f2B8CBCCC
  p38 = ((isnan(((float)(f154))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) || (((float)(f154)) <= ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:905 @%p38 bra $L__BB70_68
  if (p38) { goto L_BB70_68; }
  // PTX:907 abs.f32 %f564, %f154
  asm("abs.f32 %0, %1;" : "=f"(f564) : "f"(f154));
  // PTX:908 setp.geu.f32 %p39, %f564, 0f7F800000
  p39 = ((isnan(((float)(f564))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f564)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:909 @%p39 bra $L__BB70_68
  if (p39) { goto L_BB70_68; }
  // PTX:911 abs.f32 %f155, %f153
  asm("abs.f32 %0, %1;" : "=f"(f155) : "f"(f153));
  // PTX:912 setp.eq.f32 %p40, %f155, 0f00000000
  p40 = (!(isnan(((float)(f155))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f155)) == ((float)(as_f32(0x00000000u)))));
  // PTX:913 abs.f32 %f156, %f152
  asm("abs.f32 %0, %1;" : "=f"(f156) : "f"(f152));
  // PTX:914 setp.eq.f32 %p41, %f156, 0f00000000
  p41 = (!(isnan(((float)(f156))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f156)) == ((float)(as_f32(0x00000000u)))));
  // PTX:915 and.pred %p42, %p40, %p41
  p42 = ((p40) && (p41));
  // PTX:916 @%p42 bra $L__BB70_40
  if (p42) { goto L_BB70_40; }
  // PTX:917 bra.uni $L__BB70_37
  goto L_BB70_37;
  // PTX:919 $L__BB70_40:
L_BB70_40:;
  // PTX:920 mov.b32 %r83, %f153
  asm("mov.b32 %0, %1;" : "=r"(r83) : "f"(f153));
  // PTX:921 shr.s32 %r84, %r83, 31
  asm("shr.s32 %0, %1, 31;" : "=r"(r84) : "r"(r83));
  // PTX:922 and.b32 %r85, %r84, 1078530011
  asm("and.b32 %0, %1, 1078530011;" : "=r"(r85) : "r"(r84));
  // PTX:923 mov.b32 %r86, %f152
  asm("mov.b32 %0, %1;" : "=r"(r86) : "f"(f152));
  // PTX:924 and.b32 %r87, %r86, -2147483648
  asm("and.b32 %0, %1, -2147483648;" : "=r"(r87) : "r"(r86));
  // PTX:925 or.b32 %r88, %r87, %r85
  asm("or.b32 %0, %1, %2;" : "=r"(r88) : "r"(r87), "r"(r85));
  // PTX:926 mov.b32 %f903, %r88
  asm("mov.b32 %0, %1;" : "=f"(f903) : "r"(r88));
  // PTX:927 bra.uni $L__BB70_41
  goto L_BB70_41;
  // PTX:929 $L__BB70_42:
L_BB70_42:;
  // PTX:930 ld.param.u64 %rd279, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_1+8]
  rd279 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (8))));
  // PTX:931 cvta.to.global.u64 %rd144, %rd279
  rd144 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd279));
  // PTX:932 add.s64 %rd146, %rd144, %rd142
  asm("add.s64 %0, %1, %2;" : "=l"(rd146) : "l"(rd144), "l"(rd142));
  // PTX:933 ld.global.f32 %f164, [%rd146]
  f164 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd146) + (0)))));
  // PTX:934 setp.leu.f32 %p51, %f161, %f164
  p51 = ((isnan(((float)(f161))) || isnan(((float)(f164)))) || (((float)(f161)) <= ((float)(f164))));
  // PTX:935 @%p51 bra $L__BB70_68
  if (p51) { goto L_BB70_68; }
  // PTX:937 sub.f32 %f597, %f164, %f161
  asm("sub.f32 %0, %1, %2;" : "=f"(f597) : "f"(f164), "f"(f161));
  // PTX:938 mul.f32 %f598, %f1, %f597
  asm("mul.f32 %0, %1, %2;" : "=f"(f598) : "f"(f1), "f"(f597));
  // PTX:939 mul.f32 %f599, %f2, %f162
  asm("mul.f32 %0, %1, %2;" : "=f"(f599) : "f"(f2), "f"(f162));
  // PTX:940 sub.f32 %f600, %f598, %f599
  asm("sub.f32 %0, %1, %2;" : "=f"(f600) : "f"(f598), "f"(f599));
  // PTX:941 mov.f32 %f601, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f601) : );
  // PTX:942 min.f32 %f904, %f601, %f600
  asm("min.f32 %0, %1, %2;" : "=f"(f904) : "f"(f601), "f"(f600));
  // PTX:944 $L__BB70_45:
L_BB70_45:;
  // PTX:945 setp.eq.f32 %p52, %f904, 0f00000000
  p52 = (!(isnan(((float)(f904))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f904)) == ((float)(as_f32(0x00000000u)))));
  // PTX:946 @%p52 bra $L__BB70_68
  if (p52) { goto L_BB70_68; }
  // PTX:948 abs.f32 %f607, %f904
  asm("abs.f32 %0, %1;" : "=f"(f607) : "f"(f904));
  // PTX:949 setp.geu.f32 %p53, %f607, 0f7F800000
  p53 = ((isnan(((float)(f607))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f607)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:950 @%p53 bra $L__BB70_68
  if (p53) { goto L_BB70_68; }
  // PTX:952 ld.param.u64 %rd280, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_9]
  rd280 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:953 ld.param.f32 %f873, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_6]
  f873 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param6 + (0))));
  // PTX:954 fma.rn.f32 %f168, %f2, %f873, %f1
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f168) : "f"(f2), "f"(f873), "f"(f1));
  // PTX:955 setp.eq.s64 %p54, %rd280, 0
  p54 = (((long long)(rd280)) == ((long long)(0)));
  // PTX:956 @%p54 bra $L__BB70_56
  if (p54) { goto L_BB70_56; }
  // PTX:958 mul.f32 %f608, %f76, %f76
  asm("mul.f32 %0, %1, %2;" : "=f"(f608) : "f"(f76), "f"(f76));
  // PTX:959 mul.f32 %f609, %f168, %f608
  asm("mul.f32 %0, %1, %2;" : "=f"(f609) : "f"(f168), "f"(f608));
  // PTX:960 mul.f32 %f610, %f77, %f76
  asm("mul.f32 %0, %1, %2;" : "=f"(f610) : "f"(f77), "f"(f76));
  // PTX:961 mul.f32 %f611, %f168, %f610
  asm("mul.f32 %0, %1, %2;" : "=f"(f611) : "f"(f168), "f"(f610));
  // PTX:962 mul.f32 %f612, %f78, %f76
  asm("mul.f32 %0, %1, %2;" : "=f"(f612) : "f"(f78), "f"(f76));
  // PTX:963 mul.f32 %f613, %f168, %f612
  asm("mul.f32 %0, %1, %2;" : "=f"(f613) : "f"(f168), "f"(f612));
  // PTX:964 mul.f32 %f614, %f77, %f77
  asm("mul.f32 %0, %1, %2;" : "=f"(f614) : "f"(f77), "f"(f77));
  // PTX:965 mul.f32 %f615, %f168, %f614
  asm("mul.f32 %0, %1, %2;" : "=f"(f615) : "f"(f168), "f"(f614));
  // PTX:966 mul.f32 %f616, %f78, %f77
  asm("mul.f32 %0, %1, %2;" : "=f"(f616) : "f"(f78), "f"(f77));
  // PTX:967 mul.f32 %f617, %f168, %f616
  asm("mul.f32 %0, %1, %2;" : "=f"(f617) : "f"(f168), "f"(f616));
  // PTX:968 mul.f32 %f618, %f78, %f78
  asm("mul.f32 %0, %1, %2;" : "=f"(f618) : "f"(f78), "f"(f78));
  // PTX:969 mul.f32 %f619, %f168, %f618
  asm("mul.f32 %0, %1, %2;" : "=f"(f619) : "f"(f168), "f"(f618));
  // PTX:970 mul.lo.s64 %rd147, %rd28, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd147) : "l"(rd28));
  // PTX:971 add.s64 %rd148, %rd1, %rd147
  asm("add.s64 %0, %1, %2;" : "=l"(rd148) : "l"(rd1), "l"(rd147));
  // PTX:972 red.global.add.f32 [%rd148], %f609
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd148) + (0)))), (float)(f609));
  // PTX:973 add.s64 %rd149, %rd148, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd149) : "l"(rd148));
  // PTX:974 red.global.add.f32 [%rd149], %f611
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd149) + (0)))), (float)(f611));
  // PTX:975 add.s64 %rd150, %rd148, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd150) : "l"(rd148));
  // PTX:976 red.global.add.f32 [%rd150], %f613
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd150) + (0)))), (float)(f613));
  // PTX:977 add.s64 %rd151, %rd148, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd151) : "l"(rd148));
  // PTX:978 red.global.add.f32 [%rd151], %f611
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd151) + (0)))), (float)(f611));
  // PTX:979 add.s64 %rd152, %rd148, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd152) : "l"(rd148));
  // PTX:980 red.global.add.f32 [%rd152], %f615
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd152) + (0)))), (float)(f615));
  // PTX:981 add.s64 %rd153, %rd148, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd153) : "l"(rd148));
  // PTX:982 red.global.add.f32 [%rd153], %f617
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd153) + (0)))), (float)(f617));
  // PTX:983 add.s64 %rd154, %rd148, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd154) : "l"(rd148));
  // PTX:984 red.global.add.f32 [%rd154], %f613
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd154) + (0)))), (float)(f613));
  // PTX:985 add.s64 %rd155, %rd148, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd155) : "l"(rd148));
  // PTX:986 red.global.add.f32 [%rd155], %f617
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd155) + (0)))), (float)(f617));
  // PTX:987 add.s64 %rd156, %rd148, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd156) : "l"(rd148));
  // PTX:988 red.global.add.f32 [%rd156], %f619
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd156) + (0)))), (float)(f619));
  // PTX:989 @%p28 bra $L__BB70_50
  if (p28) { goto L_BB70_50; }
  // PTX:991 mul.f32 %f629, %f887, %f887
  asm("mul.f32 %0, %1, %2;" : "=f"(f629) : "f"(f887), "f"(f887));
  // PTX:992 mul.f32 %f630, %f168, %f629
  asm("mul.f32 %0, %1, %2;" : "=f"(f630) : "f"(f168), "f"(f629));
  // PTX:993 mul.f32 %f631, %f886, %f887
  asm("mul.f32 %0, %1, %2;" : "=f"(f631) : "f"(f886), "f"(f887));
  // PTX:994 mul.f32 %f632, %f168, %f631
  asm("mul.f32 %0, %1, %2;" : "=f"(f632) : "f"(f168), "f"(f631));
  // PTX:995 mul.f32 %f633, %f885, %f887
  asm("mul.f32 %0, %1, %2;" : "=f"(f633) : "f"(f885), "f"(f887));
  // PTX:996 mul.f32 %f634, %f168, %f633
  asm("mul.f32 %0, %1, %2;" : "=f"(f634) : "f"(f168), "f"(f633));
  // PTX:997 mul.f32 %f635, %f886, %f886
  asm("mul.f32 %0, %1, %2;" : "=f"(f635) : "f"(f886), "f"(f886));
  // PTX:998 mul.f32 %f636, %f168, %f635
  asm("mul.f32 %0, %1, %2;" : "=f"(f636) : "f"(f168), "f"(f635));
  // PTX:999 mul.f32 %f637, %f885, %f886
  asm("mul.f32 %0, %1, %2;" : "=f"(f637) : "f"(f885), "f"(f886));
  // PTX:1000 mul.f32 %f638, %f168, %f637
  asm("mul.f32 %0, %1, %2;" : "=f"(f638) : "f"(f168), "f"(f637));
  // PTX:1001 mul.f32 %f639, %f885, %f885
  asm("mul.f32 %0, %1, %2;" : "=f"(f639) : "f"(f885), "f"(f885));
  // PTX:1002 mul.f32 %f640, %f168, %f639
  asm("mul.f32 %0, %1, %2;" : "=f"(f640) : "f"(f168), "f"(f639));
  // PTX:1003 mul.lo.s64 %rd157, %rd320, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd157) : "l"(rd320));
  // PTX:1004 add.s64 %rd158, %rd1, %rd157
  asm("add.s64 %0, %1, %2;" : "=l"(rd158) : "l"(rd1), "l"(rd157));
  // PTX:1005 red.global.add.f32 [%rd158], %f630
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd158) + (0)))), (float)(f630));
  // PTX:1006 add.s64 %rd159, %rd158, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd159) : "l"(rd158));
  // PTX:1007 red.global.add.f32 [%rd159], %f632
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd159) + (0)))), (float)(f632));
  // PTX:1008 add.s64 %rd160, %rd158, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd160) : "l"(rd158));
  // PTX:1009 red.global.add.f32 [%rd160], %f634
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd160) + (0)))), (float)(f634));
  // PTX:1010 add.s64 %rd161, %rd158, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd161) : "l"(rd158));
  // PTX:1011 red.global.add.f32 [%rd161], %f632
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd161) + (0)))), (float)(f632));
  // PTX:1012 add.s64 %rd162, %rd158, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd162) : "l"(rd158));
  // PTX:1013 red.global.add.f32 [%rd162], %f636
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd162) + (0)))), (float)(f636));
  // PTX:1014 add.s64 %rd163, %rd158, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd163) : "l"(rd158));
  // PTX:1015 red.global.add.f32 [%rd163], %f638
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd163) + (0)))), (float)(f638));
  // PTX:1016 add.s64 %rd164, %rd158, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd164) : "l"(rd158));
  // PTX:1017 red.global.add.f32 [%rd164], %f634
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd164) + (0)))), (float)(f634));
  // PTX:1018 add.s64 %rd165, %rd158, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd165) : "l"(rd158));
  // PTX:1019 red.global.add.f32 [%rd165], %f638
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd165) + (0)))), (float)(f638));
  // PTX:1020 add.s64 %rd166, %rd158, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd166) : "l"(rd158));
  // PTX:1021 red.global.add.f32 [%rd166], %f640
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd166) + (0)))), (float)(f640));
  // PTX:1023 $L__BB70_50:
L_BB70_50:;
  // PTX:1024 mul.f32 %f650, %f79, %f79
  asm("mul.f32 %0, %1, %2;" : "=f"(f650) : "f"(f79), "f"(f79));
  // PTX:1025 mul.f32 %f651, %f168, %f650
  asm("mul.f32 %0, %1, %2;" : "=f"(f651) : "f"(f168), "f"(f650));
  // PTX:1026 mul.f32 %f652, %f80, %f79
  asm("mul.f32 %0, %1, %2;" : "=f"(f652) : "f"(f80), "f"(f79));
  // PTX:1027 mul.f32 %f653, %f168, %f652
  asm("mul.f32 %0, %1, %2;" : "=f"(f653) : "f"(f168), "f"(f652));
  // PTX:1028 mul.f32 %f654, %f81, %f79
  asm("mul.f32 %0, %1, %2;" : "=f"(f654) : "f"(f81), "f"(f79));
  // PTX:1029 mul.f32 %f655, %f168, %f654
  asm("mul.f32 %0, %1, %2;" : "=f"(f655) : "f"(f168), "f"(f654));
  // PTX:1030 mul.f32 %f656, %f80, %f80
  asm("mul.f32 %0, %1, %2;" : "=f"(f656) : "f"(f80), "f"(f80));
  // PTX:1031 mul.f32 %f657, %f168, %f656
  asm("mul.f32 %0, %1, %2;" : "=f"(f657) : "f"(f168), "f"(f656));
  // PTX:1032 mul.f32 %f658, %f81, %f80
  asm("mul.f32 %0, %1, %2;" : "=f"(f658) : "f"(f81), "f"(f80));
  // PTX:1033 mul.f32 %f659, %f168, %f658
  asm("mul.f32 %0, %1, %2;" : "=f"(f659) : "f"(f168), "f"(f658));
  // PTX:1034 mul.f32 %f660, %f81, %f81
  asm("mul.f32 %0, %1, %2;" : "=f"(f660) : "f"(f81), "f"(f81));
  // PTX:1035 mul.f32 %f661, %f168, %f660
  asm("mul.f32 %0, %1, %2;" : "=f"(f661) : "f"(f168), "f"(f660));
  // PTX:1036 mul.lo.s64 %rd167, %rd29, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd167) : "l"(rd29));
  // PTX:1037 add.s64 %rd168, %rd1, %rd167
  asm("add.s64 %0, %1, %2;" : "=l"(rd168) : "l"(rd1), "l"(rd167));
  // PTX:1038 red.global.add.f32 [%rd168], %f651
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd168) + (0)))), (float)(f651));
  // PTX:1039 add.s64 %rd169, %rd168, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd169) : "l"(rd168));
  // PTX:1040 red.global.add.f32 [%rd169], %f653
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd169) + (0)))), (float)(f653));
  // PTX:1041 add.s64 %rd170, %rd168, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd170) : "l"(rd168));
  // PTX:1042 red.global.add.f32 [%rd170], %f655
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd170) + (0)))), (float)(f655));
  // PTX:1043 add.s64 %rd171, %rd168, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd171) : "l"(rd168));
  // PTX:1044 red.global.add.f32 [%rd171], %f653
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd171) + (0)))), (float)(f653));
  // PTX:1045 add.s64 %rd172, %rd168, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd172) : "l"(rd168));
  // PTX:1046 red.global.add.f32 [%rd172], %f657
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd172) + (0)))), (float)(f657));
  // PTX:1047 add.s64 %rd173, %rd168, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd173) : "l"(rd168));
  // PTX:1048 red.global.add.f32 [%rd173], %f659
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd173) + (0)))), (float)(f659));
  // PTX:1049 add.s64 %rd174, %rd168, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd174) : "l"(rd168));
  // PTX:1050 red.global.add.f32 [%rd174], %f655
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd174) + (0)))), (float)(f655));
  // PTX:1051 add.s64 %rd175, %rd168, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd175) : "l"(rd168));
  // PTX:1052 red.global.add.f32 [%rd175], %f659
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd175) + (0)))), (float)(f659));
  // PTX:1053 add.s64 %rd176, %rd168, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd176) : "l"(rd168));
  // PTX:1054 red.global.add.f32 [%rd176], %f661
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd176) + (0)))), (float)(f661));
  // PTX:1055 @%p28 bra $L__BB70_52
  if (p28) { goto L_BB70_52; }
  // PTX:1057 mul.f32 %f671, %f888, %f888
  asm("mul.f32 %0, %1, %2;" : "=f"(f671) : "f"(f888), "f"(f888));
  // PTX:1058 mul.f32 %f672, %f168, %f671
  asm("mul.f32 %0, %1, %2;" : "=f"(f672) : "f"(f168), "f"(f671));
  // PTX:1059 mul.f32 %f673, %f889, %f888
  asm("mul.f32 %0, %1, %2;" : "=f"(f673) : "f"(f889), "f"(f888));
  // PTX:1060 mul.f32 %f674, %f168, %f673
  asm("mul.f32 %0, %1, %2;" : "=f"(f674) : "f"(f168), "f"(f673));
  // PTX:1061 mul.f32 %f675, %f890, %f888
  asm("mul.f32 %0, %1, %2;" : "=f"(f675) : "f"(f890), "f"(f888));
  // PTX:1062 mul.f32 %f676, %f168, %f675
  asm("mul.f32 %0, %1, %2;" : "=f"(f676) : "f"(f168), "f"(f675));
  // PTX:1063 mul.f32 %f677, %f889, %f889
  asm("mul.f32 %0, %1, %2;" : "=f"(f677) : "f"(f889), "f"(f889));
  // PTX:1064 mul.f32 %f678, %f168, %f677
  asm("mul.f32 %0, %1, %2;" : "=f"(f678) : "f"(f168), "f"(f677));
  // PTX:1065 mul.f32 %f679, %f890, %f889
  asm("mul.f32 %0, %1, %2;" : "=f"(f679) : "f"(f890), "f"(f889));
  // PTX:1066 mul.f32 %f680, %f168, %f679
  asm("mul.f32 %0, %1, %2;" : "=f"(f680) : "f"(f168), "f"(f679));
  // PTX:1067 mul.f32 %f681, %f890, %f890
  asm("mul.f32 %0, %1, %2;" : "=f"(f681) : "f"(f890), "f"(f890));
  // PTX:1068 mul.f32 %f682, %f168, %f681
  asm("mul.f32 %0, %1, %2;" : "=f"(f682) : "f"(f168), "f"(f681));
  // PTX:1069 mul.lo.s64 %rd177, %rd319, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd177) : "l"(rd319));
  // PTX:1070 add.s64 %rd178, %rd1, %rd177
  asm("add.s64 %0, %1, %2;" : "=l"(rd178) : "l"(rd1), "l"(rd177));
  // PTX:1071 red.global.add.f32 [%rd178], %f672
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd178) + (0)))), (float)(f672));
  // PTX:1072 add.s64 %rd179, %rd178, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd179) : "l"(rd178));
  // PTX:1073 red.global.add.f32 [%rd179], %f674
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd179) + (0)))), (float)(f674));
  // PTX:1074 add.s64 %rd180, %rd178, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd180) : "l"(rd178));
  // PTX:1075 red.global.add.f32 [%rd180], %f676
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (0)))), (float)(f676));
  // PTX:1076 add.s64 %rd181, %rd178, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd181) : "l"(rd178));
  // PTX:1077 red.global.add.f32 [%rd181], %f674
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd181) + (0)))), (float)(f674));
  // PTX:1078 add.s64 %rd182, %rd178, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd182) : "l"(rd178));
  // PTX:1079 red.global.add.f32 [%rd182], %f678
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd182) + (0)))), (float)(f678));
  // PTX:1080 add.s64 %rd183, %rd178, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd183) : "l"(rd178));
  // PTX:1081 red.global.add.f32 [%rd183], %f680
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd183) + (0)))), (float)(f680));
  // PTX:1082 add.s64 %rd184, %rd178, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd184) : "l"(rd178));
  // PTX:1083 red.global.add.f32 [%rd184], %f676
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd184) + (0)))), (float)(f676));
  // PTX:1084 add.s64 %rd185, %rd178, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd185) : "l"(rd178));
  // PTX:1085 red.global.add.f32 [%rd185], %f680
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (0)))), (float)(f680));
  // PTX:1086 add.s64 %rd186, %rd178, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd186) : "l"(rd178));
  // PTX:1087 red.global.add.f32 [%rd186], %f682
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd186) + (0)))), (float)(f682));
  // PTX:1089 $L__BB70_52:
L_BB70_52:;
  // PTX:1090 mul.f32 %f692, %f82, %f82
  asm("mul.f32 %0, %1, %2;" : "=f"(f692) : "f"(f82), "f"(f82));
  // PTX:1091 mul.f32 %f693, %f168, %f692
  asm("mul.f32 %0, %1, %2;" : "=f"(f693) : "f"(f168), "f"(f692));
  // PTX:1092 mul.f32 %f694, %f83, %f82
  asm("mul.f32 %0, %1, %2;" : "=f"(f694) : "f"(f83), "f"(f82));
  // PTX:1093 mul.f32 %f695, %f168, %f694
  asm("mul.f32 %0, %1, %2;" : "=f"(f695) : "f"(f168), "f"(f694));
  // PTX:1094 mul.f32 %f696, %f84, %f82
  asm("mul.f32 %0, %1, %2;" : "=f"(f696) : "f"(f84), "f"(f82));
  // PTX:1095 mul.f32 %f697, %f168, %f696
  asm("mul.f32 %0, %1, %2;" : "=f"(f697) : "f"(f168), "f"(f696));
  // PTX:1096 mul.f32 %f698, %f83, %f83
  asm("mul.f32 %0, %1, %2;" : "=f"(f698) : "f"(f83), "f"(f83));
  // PTX:1097 mul.f32 %f699, %f168, %f698
  asm("mul.f32 %0, %1, %2;" : "=f"(f699) : "f"(f168), "f"(f698));
  // PTX:1098 mul.f32 %f700, %f84, %f83
  asm("mul.f32 %0, %1, %2;" : "=f"(f700) : "f"(f84), "f"(f83));
  // PTX:1099 mul.f32 %f701, %f168, %f700
  asm("mul.f32 %0, %1, %2;" : "=f"(f701) : "f"(f168), "f"(f700));
  // PTX:1100 mul.f32 %f702, %f84, %f84
  asm("mul.f32 %0, %1, %2;" : "=f"(f702) : "f"(f84), "f"(f84));
  // PTX:1101 mul.f32 %f703, %f168, %f702
  asm("mul.f32 %0, %1, %2;" : "=f"(f703) : "f"(f168), "f"(f702));
  // PTX:1102 mul.lo.s64 %rd187, %rd30, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd187) : "l"(rd30));
  // PTX:1103 add.s64 %rd188, %rd1, %rd187
  asm("add.s64 %0, %1, %2;" : "=l"(rd188) : "l"(rd1), "l"(rd187));
  // PTX:1104 red.global.add.f32 [%rd188], %f693
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd188) + (0)))), (float)(f693));
  // PTX:1105 add.s64 %rd189, %rd188, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd189) : "l"(rd188));
  // PTX:1106 red.global.add.f32 [%rd189], %f695
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd189) + (0)))), (float)(f695));
  // PTX:1107 add.s64 %rd190, %rd188, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd190) : "l"(rd188));
  // PTX:1108 red.global.add.f32 [%rd190], %f697
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd190) + (0)))), (float)(f697));
  // PTX:1109 add.s64 %rd191, %rd188, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd191) : "l"(rd188));
  // PTX:1110 red.global.add.f32 [%rd191], %f695
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd191) + (0)))), (float)(f695));
  // PTX:1111 add.s64 %rd192, %rd188, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd192) : "l"(rd188));
  // PTX:1112 red.global.add.f32 [%rd192], %f699
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd192) + (0)))), (float)(f699));
  // PTX:1113 add.s64 %rd193, %rd188, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd193) : "l"(rd188));
  // PTX:1114 red.global.add.f32 [%rd193], %f701
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd193) + (0)))), (float)(f701));
  // PTX:1115 add.s64 %rd194, %rd188, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd194) : "l"(rd188));
  // PTX:1116 red.global.add.f32 [%rd194], %f697
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd194) + (0)))), (float)(f697));
  // PTX:1117 add.s64 %rd195, %rd188, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd195) : "l"(rd188));
  // PTX:1118 red.global.add.f32 [%rd195], %f701
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd195) + (0)))), (float)(f701));
  // PTX:1119 add.s64 %rd196, %rd188, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd196) : "l"(rd188));
  // PTX:1120 red.global.add.f32 [%rd196], %f703
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd196) + (0)))), (float)(f703));
  // PTX:1121 @%p28 bra $L__BB70_54
  if (p28) { goto L_BB70_54; }
  // PTX:1123 mul.f32 %f713, %f891, %f891
  asm("mul.f32 %0, %1, %2;" : "=f"(f713) : "f"(f891), "f"(f891));
  // PTX:1124 mul.f32 %f714, %f168, %f713
  asm("mul.f32 %0, %1, %2;" : "=f"(f714) : "f"(f168), "f"(f713));
  // PTX:1125 mul.f32 %f715, %f892, %f891
  asm("mul.f32 %0, %1, %2;" : "=f"(f715) : "f"(f892), "f"(f891));
  // PTX:1126 mul.f32 %f716, %f168, %f715
  asm("mul.f32 %0, %1, %2;" : "=f"(f716) : "f"(f168), "f"(f715));
  // PTX:1127 mul.f32 %f717, %f893, %f891
  asm("mul.f32 %0, %1, %2;" : "=f"(f717) : "f"(f893), "f"(f891));
  // PTX:1128 mul.f32 %f718, %f168, %f717
  asm("mul.f32 %0, %1, %2;" : "=f"(f718) : "f"(f168), "f"(f717));
  // PTX:1129 mul.f32 %f719, %f892, %f892
  asm("mul.f32 %0, %1, %2;" : "=f"(f719) : "f"(f892), "f"(f892));
  // PTX:1130 mul.f32 %f720, %f168, %f719
  asm("mul.f32 %0, %1, %2;" : "=f"(f720) : "f"(f168), "f"(f719));
  // PTX:1131 mul.f32 %f721, %f893, %f892
  asm("mul.f32 %0, %1, %2;" : "=f"(f721) : "f"(f893), "f"(f892));
  // PTX:1132 mul.f32 %f722, %f168, %f721
  asm("mul.f32 %0, %1, %2;" : "=f"(f722) : "f"(f168), "f"(f721));
  // PTX:1133 mul.f32 %f723, %f893, %f893
  asm("mul.f32 %0, %1, %2;" : "=f"(f723) : "f"(f893), "f"(f893));
  // PTX:1134 mul.f32 %f724, %f168, %f723
  asm("mul.f32 %0, %1, %2;" : "=f"(f724) : "f"(f168), "f"(f723));
  // PTX:1135 mul.lo.s64 %rd197, %rd318, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd197) : "l"(rd318));
  // PTX:1136 add.s64 %rd198, %rd1, %rd197
  asm("add.s64 %0, %1, %2;" : "=l"(rd198) : "l"(rd1), "l"(rd197));
  // PTX:1137 red.global.add.f32 [%rd198], %f714
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd198) + (0)))), (float)(f714));
  // PTX:1138 add.s64 %rd199, %rd198, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd199) : "l"(rd198));
  // PTX:1139 red.global.add.f32 [%rd199], %f716
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd199) + (0)))), (float)(f716));
  // PTX:1140 add.s64 %rd200, %rd198, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd200) : "l"(rd198));
  // PTX:1141 red.global.add.f32 [%rd200], %f718
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd200) + (0)))), (float)(f718));
  // PTX:1142 add.s64 %rd201, %rd198, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd201) : "l"(rd198));
  // PTX:1143 red.global.add.f32 [%rd201], %f716
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd201) + (0)))), (float)(f716));
  // PTX:1144 add.s64 %rd202, %rd198, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd202) : "l"(rd198));
  // PTX:1145 red.global.add.f32 [%rd202], %f720
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd202) + (0)))), (float)(f720));
  // PTX:1146 add.s64 %rd203, %rd198, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd203) : "l"(rd198));
  // PTX:1147 red.global.add.f32 [%rd203], %f722
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd203) + (0)))), (float)(f722));
  // PTX:1148 add.s64 %rd204, %rd198, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd204) : "l"(rd198));
  // PTX:1149 red.global.add.f32 [%rd204], %f718
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd204) + (0)))), (float)(f718));
  // PTX:1150 add.s64 %rd205, %rd198, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd205) : "l"(rd198));
  // PTX:1151 red.global.add.f32 [%rd205], %f722
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd205) + (0)))), (float)(f722));
  // PTX:1152 add.s64 %rd206, %rd198, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd206) : "l"(rd198));
  // PTX:1153 red.global.add.f32 [%rd206], %f724
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd206) + (0)))), (float)(f724));
  // PTX:1155 $L__BB70_54:
L_BB70_54:;
  // PTX:1156 mul.f32 %f734, %f85, %f85
  asm("mul.f32 %0, %1, %2;" : "=f"(f734) : "f"(f85), "f"(f85));
  // PTX:1157 mul.f32 %f735, %f168, %f734
  asm("mul.f32 %0, %1, %2;" : "=f"(f735) : "f"(f168), "f"(f734));
  // PTX:1158 mul.f32 %f736, %f86, %f85
  asm("mul.f32 %0, %1, %2;" : "=f"(f736) : "f"(f86), "f"(f85));
  // PTX:1159 mul.f32 %f737, %f168, %f736
  asm("mul.f32 %0, %1, %2;" : "=f"(f737) : "f"(f168), "f"(f736));
  // PTX:1160 mul.f32 %f738, %f87, %f85
  asm("mul.f32 %0, %1, %2;" : "=f"(f738) : "f"(f87), "f"(f85));
  // PTX:1161 mul.f32 %f739, %f168, %f738
  asm("mul.f32 %0, %1, %2;" : "=f"(f739) : "f"(f168), "f"(f738));
  // PTX:1162 mul.f32 %f740, %f86, %f86
  asm("mul.f32 %0, %1, %2;" : "=f"(f740) : "f"(f86), "f"(f86));
  // PTX:1163 mul.f32 %f741, %f168, %f740
  asm("mul.f32 %0, %1, %2;" : "=f"(f741) : "f"(f168), "f"(f740));
  // PTX:1164 mul.f32 %f742, %f87, %f86
  asm("mul.f32 %0, %1, %2;" : "=f"(f742) : "f"(f87), "f"(f86));
  // PTX:1165 mul.f32 %f743, %f168, %f742
  asm("mul.f32 %0, %1, %2;" : "=f"(f743) : "f"(f168), "f"(f742));
  // PTX:1166 mul.f32 %f744, %f87, %f87
  asm("mul.f32 %0, %1, %2;" : "=f"(f744) : "f"(f87), "f"(f87));
  // PTX:1167 mul.f32 %f745, %f168, %f744
  asm("mul.f32 %0, %1, %2;" : "=f"(f745) : "f"(f168), "f"(f744));
  // PTX:1168 mul.lo.s64 %rd207, %rd31, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd207) : "l"(rd31));
  // PTX:1169 add.s64 %rd208, %rd1, %rd207
  asm("add.s64 %0, %1, %2;" : "=l"(rd208) : "l"(rd1), "l"(rd207));
  // PTX:1170 red.global.add.f32 [%rd208], %f735
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd208) + (0)))), (float)(f735));
  // PTX:1171 add.s64 %rd209, %rd208, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd209) : "l"(rd208));
  // PTX:1172 red.global.add.f32 [%rd209], %f737
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd209) + (0)))), (float)(f737));
  // PTX:1173 add.s64 %rd210, %rd208, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd210) : "l"(rd208));
  // PTX:1174 red.global.add.f32 [%rd210], %f739
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd210) + (0)))), (float)(f739));
  // PTX:1175 add.s64 %rd211, %rd208, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd211) : "l"(rd208));
  // PTX:1176 red.global.add.f32 [%rd211], %f737
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd211) + (0)))), (float)(f737));
  // PTX:1177 add.s64 %rd212, %rd208, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd212) : "l"(rd208));
  // PTX:1178 red.global.add.f32 [%rd212], %f741
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd212) + (0)))), (float)(f741));
  // PTX:1179 add.s64 %rd213, %rd208, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd213) : "l"(rd208));
  // PTX:1180 red.global.add.f32 [%rd213], %f743
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd213) + (0)))), (float)(f743));
  // PTX:1181 add.s64 %rd214, %rd208, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd214) : "l"(rd208));
  // PTX:1182 red.global.add.f32 [%rd214], %f739
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd214) + (0)))), (float)(f739));
  // PTX:1183 add.s64 %rd215, %rd208, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd215) : "l"(rd208));
  // PTX:1184 red.global.add.f32 [%rd215], %f743
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd215) + (0)))), (float)(f743));
  // PTX:1185 add.s64 %rd216, %rd208, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd216) : "l"(rd208));
  // PTX:1186 red.global.add.f32 [%rd216], %f745
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd216) + (0)))), (float)(f745));
  // PTX:1187 @%p28 bra $L__BB70_68
  if (p28) { goto L_BB70_68; }
  // PTX:1189 mul.f32 %f755, %f894, %f894
  asm("mul.f32 %0, %1, %2;" : "=f"(f755) : "f"(f894), "f"(f894));
  // PTX:1190 mul.f32 %f756, %f168, %f755
  asm("mul.f32 %0, %1, %2;" : "=f"(f756) : "f"(f168), "f"(f755));
  // PTX:1191 mul.f32 %f757, %f895, %f894
  asm("mul.f32 %0, %1, %2;" : "=f"(f757) : "f"(f895), "f"(f894));
  // PTX:1192 mul.f32 %f758, %f168, %f757
  asm("mul.f32 %0, %1, %2;" : "=f"(f758) : "f"(f168), "f"(f757));
  // PTX:1193 mul.f32 %f759, %f896, %f894
  asm("mul.f32 %0, %1, %2;" : "=f"(f759) : "f"(f896), "f"(f894));
  // PTX:1194 mul.f32 %f760, %f168, %f759
  asm("mul.f32 %0, %1, %2;" : "=f"(f760) : "f"(f168), "f"(f759));
  // PTX:1195 mul.f32 %f761, %f895, %f895
  asm("mul.f32 %0, %1, %2;" : "=f"(f761) : "f"(f895), "f"(f895));
  // PTX:1196 mul.f32 %f762, %f168, %f761
  asm("mul.f32 %0, %1, %2;" : "=f"(f762) : "f"(f168), "f"(f761));
  // PTX:1197 mul.f32 %f763, %f896, %f895
  asm("mul.f32 %0, %1, %2;" : "=f"(f763) : "f"(f896), "f"(f895));
  // PTX:1198 mul.f32 %f764, %f168, %f763
  asm("mul.f32 %0, %1, %2;" : "=f"(f764) : "f"(f168), "f"(f763));
  // PTX:1199 mul.f32 %f765, %f896, %f896
  asm("mul.f32 %0, %1, %2;" : "=f"(f765) : "f"(f896), "f"(f896));
  // PTX:1200 mul.f32 %f766, %f168, %f765
  asm("mul.f32 %0, %1, %2;" : "=f"(f766) : "f"(f168), "f"(f765));
  // PTX:1201 mul.lo.s64 %rd217, %rd317, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd217) : "l"(rd317));
  // PTX:1202 add.s64 %rd218, %rd1, %rd217
  asm("add.s64 %0, %1, %2;" : "=l"(rd218) : "l"(rd1), "l"(rd217));
  // PTX:1203 red.global.add.f32 [%rd218], %f756
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd218) + (0)))), (float)(f756));
  // PTX:1204 add.s64 %rd219, %rd218, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd219) : "l"(rd218));
  // PTX:1205 red.global.add.f32 [%rd219], %f758
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd219) + (0)))), (float)(f758));
  // PTX:1206 add.s64 %rd220, %rd218, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd220) : "l"(rd218));
  // PTX:1207 red.global.add.f32 [%rd220], %f760
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd220) + (0)))), (float)(f760));
  // PTX:1208 add.s64 %rd221, %rd218, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd221) : "l"(rd218));
  // PTX:1209 red.global.add.f32 [%rd221], %f758
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd221) + (0)))), (float)(f758));
  // PTX:1210 add.s64 %rd222, %rd218, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd222) : "l"(rd218));
  // PTX:1211 red.global.add.f32 [%rd222], %f762
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd222) + (0)))), (float)(f762));
  // PTX:1212 add.s64 %rd223, %rd218, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd223) : "l"(rd218));
  // PTX:1213 red.global.add.f32 [%rd223], %f764
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd223) + (0)))), (float)(f764));
  // PTX:1214 add.s64 %rd224, %rd218, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd224) : "l"(rd218));
  // PTX:1215 red.global.add.f32 [%rd224], %f760
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd224) + (0)))), (float)(f760));
  // PTX:1216 add.s64 %rd225, %rd218, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd225) : "l"(rd218));
  // PTX:1217 red.global.add.f32 [%rd225], %f764
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd225) + (0)))), (float)(f764));
  // PTX:1218 add.s64 %rd226, %rd218, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd226) : "l"(rd218));
  // PTX:1219 red.global.add.f32 [%rd226], %f766
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd226) + (0)))), (float)(f766));
  // PTX:1220 bra.uni $L__BB70_68
  goto L_BB70_68;
  // PTX:1222 $L__BB70_56:
L_BB70_56:;
  // PTX:1223 ld.param.u64 %rd281, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_7]
  rd281 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:1224 setp.eq.s64 %p59, %rd281, 0
  p59 = (((long long)(rd281)) == ((long long)(0)));
  // PTX:1225 @%p59 bra $L__BB70_66
  if (p59) { goto L_BB70_66; }
  // PTX:1227 mul.lo.s64 %rd227, %rd28, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd227) : "l"(rd28));
  // PTX:1228 add.s64 %rd228, %rd3, %rd227
  asm("add.s64 %0, %1, %2;" : "=l"(rd228) : "l"(rd3), "l"(rd227));
  // PTX:1229 ld.global.f32 %f776, [%rd228]
  f776 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd228) + (0)))));
  // PTX:1230 ld.global.f32 %f777, [%rd228+4]
  f777 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd228) + (4)))));
  // PTX:1231 mul.f32 %f778, %f77, %f777
  asm("mul.f32 %0, %1, %2;" : "=f"(f778) : "f"(f77), "f"(f777));
  // PTX:1232 ld.global.f32 %f779, [%rd228+8]
  f779 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd228) + (8)))));
  // PTX:1233 fma.rn.f32 %f780, %f76, %f776, %f778
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f780) : "f"(f76), "f"(f776), "f"(f778));
  // PTX:1234 fma.rn.f32 %f781, %f78, %f779, %f780
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f781) : "f"(f78), "f"(f779), "f"(f780));
  // PTX:1235 add.f32 %f905, %f781, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f905) : "f"(f781));
  // PTX:1236 @%p28 bra $L__BB70_59
  if (p28) { goto L_BB70_59; }
  // PTX:1238 mul.lo.s64 %rd229, %rd320, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd229) : "l"(rd320));
  // PTX:1239 add.s64 %rd230, %rd3, %rd229
  asm("add.s64 %0, %1, %2;" : "=l"(rd230) : "l"(rd3), "l"(rd229));
  // PTX:1240 ld.global.f32 %f782, [%rd230]
  f782 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd230) + (0)))));
  // PTX:1241 ld.global.f32 %f783, [%rd230+4]
  f783 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd230) + (4)))));
  // PTX:1242 mul.f32 %f784, %f886, %f783
  asm("mul.f32 %0, %1, %2;" : "=f"(f784) : "f"(f886), "f"(f783));
  // PTX:1243 ld.global.f32 %f785, [%rd230+8]
  f785 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd230) + (8)))));
  // PTX:1244 fma.rn.f32 %f786, %f887, %f782, %f784
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f786) : "f"(f887), "f"(f782), "f"(f784));
  // PTX:1245 fma.rn.f32 %f787, %f885, %f785, %f786
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f787) : "f"(f885), "f"(f785), "f"(f786));
  // PTX:1246 add.f32 %f905, %f905, %f787
  asm("add.f32 %0, %1, %2;" : "=f"(f905) : "f"(f905), "f"(f787));
  // PTX:1248 $L__BB70_59:
L_BB70_59:;
  // PTX:1249 mul.lo.s64 %rd231, %rd29, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd231) : "l"(rd29));
  // PTX:1250 add.s64 %rd232, %rd3, %rd231
  asm("add.s64 %0, %1, %2;" : "=l"(rd232) : "l"(rd3), "l"(rd231));
  // PTX:1251 ld.global.f32 %f788, [%rd232]
  f788 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd232) + (0)))));
  // PTX:1252 ld.global.f32 %f789, [%rd232+4]
  f789 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd232) + (4)))));
  // PTX:1253 mul.f32 %f790, %f80, %f789
  asm("mul.f32 %0, %1, %2;" : "=f"(f790) : "f"(f80), "f"(f789));
  // PTX:1254 ld.global.f32 %f791, [%rd232+8]
  f791 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd232) + (8)))));
  // PTX:1255 fma.rn.f32 %f792, %f79, %f788, %f790
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f792) : "f"(f79), "f"(f788), "f"(f790));
  // PTX:1256 fma.rn.f32 %f793, %f81, %f791, %f792
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f793) : "f"(f81), "f"(f791), "f"(f792));
  // PTX:1257 add.f32 %f906, %f905, %f793
  asm("add.f32 %0, %1, %2;" : "=f"(f906) : "f"(f905), "f"(f793));
  // PTX:1258 @%p28 bra $L__BB70_61
  if (p28) { goto L_BB70_61; }
  // PTX:1260 mul.lo.s64 %rd233, %rd319, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd233) : "l"(rd319));
  // PTX:1261 add.s64 %rd234, %rd3, %rd233
  asm("add.s64 %0, %1, %2;" : "=l"(rd234) : "l"(rd3), "l"(rd233));
  // PTX:1262 ld.global.f32 %f794, [%rd234]
  f794 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd234) + (0)))));
  // PTX:1263 ld.global.f32 %f795, [%rd234+4]
  f795 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd234) + (4)))));
  // PTX:1264 mul.f32 %f796, %f889, %f795
  asm("mul.f32 %0, %1, %2;" : "=f"(f796) : "f"(f889), "f"(f795));
  // PTX:1265 ld.global.f32 %f797, [%rd234+8]
  f797 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd234) + (8)))));
  // PTX:1266 fma.rn.f32 %f798, %f888, %f794, %f796
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f798) : "f"(f888), "f"(f794), "f"(f796));
  // PTX:1267 fma.rn.f32 %f799, %f890, %f797, %f798
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f799) : "f"(f890), "f"(f797), "f"(f798));
  // PTX:1268 add.f32 %f906, %f906, %f799
  asm("add.f32 %0, %1, %2;" : "=f"(f906) : "f"(f906), "f"(f799));
  // PTX:1270 $L__BB70_61:
L_BB70_61:;
  // PTX:1271 mul.lo.s64 %rd235, %rd30, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd235) : "l"(rd30));
  // PTX:1272 add.s64 %rd236, %rd3, %rd235
  asm("add.s64 %0, %1, %2;" : "=l"(rd236) : "l"(rd3), "l"(rd235));
  // PTX:1273 ld.global.f32 %f800, [%rd236]
  f800 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd236) + (0)))));
  // PTX:1274 ld.global.f32 %f801, [%rd236+4]
  f801 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd236) + (4)))));
  // PTX:1275 mul.f32 %f802, %f83, %f801
  asm("mul.f32 %0, %1, %2;" : "=f"(f802) : "f"(f83), "f"(f801));
  // PTX:1276 ld.global.f32 %f803, [%rd236+8]
  f803 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd236) + (8)))));
  // PTX:1277 fma.rn.f32 %f804, %f82, %f800, %f802
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f804) : "f"(f82), "f"(f800), "f"(f802));
  // PTX:1278 fma.rn.f32 %f805, %f84, %f803, %f804
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f805) : "f"(f84), "f"(f803), "f"(f804));
  // PTX:1279 add.f32 %f907, %f906, %f805
  asm("add.f32 %0, %1, %2;" : "=f"(f907) : "f"(f906), "f"(f805));
  // PTX:1280 @%p28 bra $L__BB70_63
  if (p28) { goto L_BB70_63; }
  // PTX:1282 mul.lo.s64 %rd237, %rd318, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd237) : "l"(rd318));
  // PTX:1283 add.s64 %rd238, %rd3, %rd237
  asm("add.s64 %0, %1, %2;" : "=l"(rd238) : "l"(rd3), "l"(rd237));
  // PTX:1284 ld.global.f32 %f806, [%rd238]
  f806 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd238) + (0)))));
  // PTX:1285 ld.global.f32 %f807, [%rd238+4]
  f807 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd238) + (4)))));
  // PTX:1286 mul.f32 %f808, %f892, %f807
  asm("mul.f32 %0, %1, %2;" : "=f"(f808) : "f"(f892), "f"(f807));
  // PTX:1287 ld.global.f32 %f809, [%rd238+8]
  f809 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd238) + (8)))));
  // PTX:1288 fma.rn.f32 %f810, %f891, %f806, %f808
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f810) : "f"(f891), "f"(f806), "f"(f808));
  // PTX:1289 fma.rn.f32 %f811, %f893, %f809, %f810
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f811) : "f"(f893), "f"(f809), "f"(f810));
  // PTX:1290 add.f32 %f907, %f907, %f811
  asm("add.f32 %0, %1, %2;" : "=f"(f907) : "f"(f907), "f"(f811));
  // PTX:1292 $L__BB70_63:
L_BB70_63:;
  // PTX:1293 mul.lo.s64 %rd239, %rd31, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd239) : "l"(rd31));
  // PTX:1294 add.s64 %rd240, %rd3, %rd239
  asm("add.s64 %0, %1, %2;" : "=l"(rd240) : "l"(rd3), "l"(rd239));
  // PTX:1295 ld.global.f32 %f812, [%rd240]
  f812 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd240) + (0)))));
  // PTX:1296 ld.global.f32 %f813, [%rd240+4]
  f813 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd240) + (4)))));
  // PTX:1297 mul.f32 %f814, %f86, %f813
  asm("mul.f32 %0, %1, %2;" : "=f"(f814) : "f"(f86), "f"(f813));
  // PTX:1298 ld.global.f32 %f815, [%rd240+8]
  f815 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd240) + (8)))));
  // PTX:1299 fma.rn.f32 %f816, %f85, %f812, %f814
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f816) : "f"(f85), "f"(f812), "f"(f814));
  // PTX:1300 fma.rn.f32 %f817, %f87, %f815, %f816
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f817) : "f"(f87), "f"(f815), "f"(f816));
  // PTX:1301 add.f32 %f908, %f907, %f817
  asm("add.f32 %0, %1, %2;" : "=f"(f908) : "f"(f907), "f"(f817));
  // PTX:1302 @%p28 bra $L__BB70_65
  if (p28) { goto L_BB70_65; }
  // PTX:1304 mul.lo.s64 %rd241, %rd317, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd241) : "l"(rd317));
  // PTX:1305 add.s64 %rd242, %rd3, %rd241
  asm("add.s64 %0, %1, %2;" : "=l"(rd242) : "l"(rd3), "l"(rd241));
  // PTX:1306 ld.global.f32 %f818, [%rd242]
  f818 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd242) + (0)))));
  // PTX:1307 ld.global.f32 %f819, [%rd242+4]
  f819 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd242) + (4)))));
  // PTX:1308 mul.f32 %f820, %f895, %f819
  asm("mul.f32 %0, %1, %2;" : "=f"(f820) : "f"(f895), "f"(f819));
  // PTX:1309 ld.global.f32 %f821, [%rd242+8]
  f821 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd242) + (8)))));
  // PTX:1310 fma.rn.f32 %f822, %f894, %f818, %f820
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f822) : "f"(f894), "f"(f818), "f"(f820));
  // PTX:1311 fma.rn.f32 %f823, %f896, %f821, %f822
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f823) : "f"(f896), "f"(f821), "f"(f822));
  // PTX:1312 add.f32 %f908, %f908, %f823
  asm("add.f32 %0, %1, %2;" : "=f"(f908) : "f"(f908), "f"(f823));
  // PTX:1314 $L__BB70_65:
L_BB70_65:;
  // PTX:1315 mul.f32 %f904, %f168, %f908
  asm("mul.f32 %0, %1, %2;" : "=f"(f904) : "f"(f168), "f"(f908));
  // PTX:1317 $L__BB70_66:
L_BB70_66:;
  // PTX:1318 ld.param.u64 %rd283, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_8]
  rd283 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:1319 cvta.to.global.u64 %rd282, %rd283
  rd282 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd283));
  // PTX:1320 mul.lo.s64 %rd243, %rd28, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd243) : "l"(rd28));
  // PTX:1321 add.s64 %rd244, %rd282, %rd243
  asm("add.s64 %0, %1, %2;" : "=l"(rd244) : "l"(rd282), "l"(rd243));
  // PTX:1322 mul.f32 %f824, %f904, %f76
  asm("mul.f32 %0, %1, %2;" : "=f"(f824) : "f"(f904), "f"(f76));
  // PTX:1323 red.global.add.f32 [%rd244], %f824
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd244) + (0)))), (float)(f824));
  // PTX:1324 add.s64 %rd245, %rd244, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd245) : "l"(rd244));
  // PTX:1325 mul.f32 %f826, %f904, %f77
  asm("mul.f32 %0, %1, %2;" : "=f"(f826) : "f"(f904), "f"(f77));
  // PTX:1326 red.global.add.f32 [%rd245], %f826
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd245) + (0)))), (float)(f826));
  // PTX:1327 add.s64 %rd246, %rd244, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd246) : "l"(rd244));
  // PTX:1328 mul.f32 %f828, %f904, %f78
  asm("mul.f32 %0, %1, %2;" : "=f"(f828) : "f"(f904), "f"(f78));
  // PTX:1329 red.global.add.f32 [%rd246], %f828
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd246) + (0)))), (float)(f828));
  // PTX:1330 mul.lo.s64 %rd247, %rd29, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd247) : "l"(rd29));
  // PTX:1331 add.s64 %rd248, %rd282, %rd247
  asm("add.s64 %0, %1, %2;" : "=l"(rd248) : "l"(rd282), "l"(rd247));
  // PTX:1332 mul.f32 %f830, %f904, %f79
  asm("mul.f32 %0, %1, %2;" : "=f"(f830) : "f"(f904), "f"(f79));
  // PTX:1333 red.global.add.f32 [%rd248], %f830
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd248) + (0)))), (float)(f830));
  // PTX:1334 add.s64 %rd249, %rd248, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd249) : "l"(rd248));
  // PTX:1335 mul.f32 %f832, %f904, %f80
  asm("mul.f32 %0, %1, %2;" : "=f"(f832) : "f"(f904), "f"(f80));
  // PTX:1336 red.global.add.f32 [%rd249], %f832
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd249) + (0)))), (float)(f832));
  // PTX:1337 add.s64 %rd250, %rd248, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd250) : "l"(rd248));
  // PTX:1338 mul.f32 %f834, %f904, %f81
  asm("mul.f32 %0, %1, %2;" : "=f"(f834) : "f"(f904), "f"(f81));
  // PTX:1339 red.global.add.f32 [%rd250], %f834
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd250) + (0)))), (float)(f834));
  // PTX:1340 mul.lo.s64 %rd251, %rd30, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd251) : "l"(rd30));
  // PTX:1341 add.s64 %rd252, %rd282, %rd251
  asm("add.s64 %0, %1, %2;" : "=l"(rd252) : "l"(rd282), "l"(rd251));
  // PTX:1342 mul.f32 %f836, %f904, %f82
  asm("mul.f32 %0, %1, %2;" : "=f"(f836) : "f"(f904), "f"(f82));
  // PTX:1343 red.global.add.f32 [%rd252], %f836
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd252) + (0)))), (float)(f836));
  // PTX:1344 add.s64 %rd253, %rd252, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd253) : "l"(rd252));
  // PTX:1345 mul.f32 %f838, %f904, %f83
  asm("mul.f32 %0, %1, %2;" : "=f"(f838) : "f"(f904), "f"(f83));
  // PTX:1346 red.global.add.f32 [%rd253], %f838
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd253) + (0)))), (float)(f838));
  // PTX:1347 add.s64 %rd254, %rd252, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd254) : "l"(rd252));
  // PTX:1348 mul.f32 %f840, %f904, %f84
  asm("mul.f32 %0, %1, %2;" : "=f"(f840) : "f"(f904), "f"(f84));
  // PTX:1349 red.global.add.f32 [%rd254], %f840
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd254) + (0)))), (float)(f840));
  // PTX:1350 mul.lo.s64 %rd255, %rd31, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd255) : "l"(rd31));
  // PTX:1351 add.s64 %rd256, %rd282, %rd255
  asm("add.s64 %0, %1, %2;" : "=l"(rd256) : "l"(rd282), "l"(rd255));
  // PTX:1352 mul.f32 %f842, %f904, %f85
  asm("mul.f32 %0, %1, %2;" : "=f"(f842) : "f"(f904), "f"(f85));
  // PTX:1353 red.global.add.f32 [%rd256], %f842
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd256) + (0)))), (float)(f842));
  // PTX:1354 add.s64 %rd257, %rd256, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd257) : "l"(rd256));
  // PTX:1355 mul.f32 %f844, %f904, %f86
  asm("mul.f32 %0, %1, %2;" : "=f"(f844) : "f"(f904), "f"(f86));
  // PTX:1356 red.global.add.f32 [%rd257], %f844
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd257) + (0)))), (float)(f844));
  // PTX:1357 add.s64 %rd258, %rd256, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd258) : "l"(rd256));
  // PTX:1358 mul.f32 %f846, %f904, %f87
  asm("mul.f32 %0, %1, %2;" : "=f"(f846) : "f"(f904), "f"(f87));
  // PTX:1359 red.global.add.f32 [%rd258], %f846
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd258) + (0)))), (float)(f846));
  // PTX:1360 @%p28 bra $L__BB70_68
  if (p28) { goto L_BB70_68; }
  // PTX:1362 ld.param.u64 %rd285, [_ZN7synreal6kernel23evaluate_angular_limitsENS0_19JointCoordinateViewENS0_16AngularLimitViewEPKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfPKifS8_PS6_PNS3_3matILi3ELi3EfLS5_0EEE_param_8]
  rd285 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:1363 cvta.to.global.u64 %rd284, %rd285
  rd284 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd285));
  // PTX:1364 mul.f32 %f848, %f904, %f887
  asm("mul.f32 %0, %1, %2;" : "=f"(f848) : "f"(f904), "f"(f887));
  // PTX:1365 mul.lo.s64 %rd259, %rd320, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd259) : "l"(rd320));
  // PTX:1366 add.s64 %rd260, %rd284, %rd259
  asm("add.s64 %0, %1, %2;" : "=l"(rd260) : "l"(rd284), "l"(rd259));
  // PTX:1367 red.global.add.f32 [%rd260], %f848
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd260) + (0)))), (float)(f848));
  // PTX:1368 add.s64 %rd261, %rd260, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd261) : "l"(rd260));
  // PTX:1369 mul.f32 %f850, %f904, %f886
  asm("mul.f32 %0, %1, %2;" : "=f"(f850) : "f"(f904), "f"(f886));
  // PTX:1370 red.global.add.f32 [%rd261], %f850
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd261) + (0)))), (float)(f850));
  // PTX:1371 add.s64 %rd262, %rd260, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd262) : "l"(rd260));
  // PTX:1372 mul.f32 %f852, %f904, %f885
  asm("mul.f32 %0, %1, %2;" : "=f"(f852) : "f"(f904), "f"(f885));
  // PTX:1373 red.global.add.f32 [%rd262], %f852
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd262) + (0)))), (float)(f852));
  // PTX:1374 mul.lo.s64 %rd263, %rd319, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd263) : "l"(rd319));
  // PTX:1375 add.s64 %rd264, %rd284, %rd263
  asm("add.s64 %0, %1, %2;" : "=l"(rd264) : "l"(rd284), "l"(rd263));
  // PTX:1376 mul.f32 %f854, %f904, %f888
  asm("mul.f32 %0, %1, %2;" : "=f"(f854) : "f"(f904), "f"(f888));
  // PTX:1377 red.global.add.f32 [%rd264], %f854
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd264) + (0)))), (float)(f854));
  // PTX:1378 add.s64 %rd265, %rd264, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd265) : "l"(rd264));
  // PTX:1379 mul.f32 %f856, %f904, %f889
  asm("mul.f32 %0, %1, %2;" : "=f"(f856) : "f"(f904), "f"(f889));
  // PTX:1380 red.global.add.f32 [%rd265], %f856
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd265) + (0)))), (float)(f856));
  // PTX:1381 add.s64 %rd266, %rd264, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd266) : "l"(rd264));
  // PTX:1382 mul.f32 %f858, %f904, %f890
  asm("mul.f32 %0, %1, %2;" : "=f"(f858) : "f"(f904), "f"(f890));
  // PTX:1383 red.global.add.f32 [%rd266], %f858
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd266) + (0)))), (float)(f858));
  // PTX:1384 mul.lo.s64 %rd267, %rd318, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd267) : "l"(rd318));
  // PTX:1385 add.s64 %rd268, %rd284, %rd267
  asm("add.s64 %0, %1, %2;" : "=l"(rd268) : "l"(rd284), "l"(rd267));
  // PTX:1386 mul.f32 %f860, %f904, %f891
  asm("mul.f32 %0, %1, %2;" : "=f"(f860) : "f"(f904), "f"(f891));
  // PTX:1387 red.global.add.f32 [%rd268], %f860
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd268) + (0)))), (float)(f860));
  // PTX:1388 add.s64 %rd269, %rd268, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd269) : "l"(rd268));
  // PTX:1389 mul.f32 %f862, %f904, %f892
  asm("mul.f32 %0, %1, %2;" : "=f"(f862) : "f"(f904), "f"(f892));
  // PTX:1390 red.global.add.f32 [%rd269], %f862
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd269) + (0)))), (float)(f862));
  // PTX:1391 add.s64 %rd270, %rd268, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd270) : "l"(rd268));
  // PTX:1392 mul.f32 %f864, %f904, %f893
  asm("mul.f32 %0, %1, %2;" : "=f"(f864) : "f"(f904), "f"(f893));
  // PTX:1393 red.global.add.f32 [%rd270], %f864
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd270) + (0)))), (float)(f864));
  // PTX:1394 mul.lo.s64 %rd271, %rd317, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd271) : "l"(rd317));
  // PTX:1395 add.s64 %rd272, %rd284, %rd271
  asm("add.s64 %0, %1, %2;" : "=l"(rd272) : "l"(rd284), "l"(rd271));
  // PTX:1396 mul.f32 %f866, %f904, %f894
  asm("mul.f32 %0, %1, %2;" : "=f"(f866) : "f"(f904), "f"(f894));
  // PTX:1397 red.global.add.f32 [%rd272], %f866
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd272) + (0)))), (float)(f866));
  // PTX:1398 add.s64 %rd273, %rd272, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd273) : "l"(rd272));
  // PTX:1399 mul.f32 %f868, %f904, %f895
  asm("mul.f32 %0, %1, %2;" : "=f"(f868) : "f"(f904), "f"(f895));
  // PTX:1400 red.global.add.f32 [%rd273], %f868
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd273) + (0)))), (float)(f868));
  // PTX:1401 add.s64 %rd274, %rd272, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd274) : "l"(rd272));
  // PTX:1402 mul.f32 %f870, %f904, %f896
  asm("mul.f32 %0, %1, %2;" : "=f"(f870) : "f"(f904), "f"(f896));
  // PTX:1403 red.global.add.f32 [%rd274], %f870
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd274) + (0)))), (float)(f870));
  // PTX:1405 $L__BB70_68:
L_BB70_68:;
  // PTX:1406 ret
  return;
  // PTX:1408 $L__BB70_37:
L_BB70_37:;
  // PTX:1409 setp.eq.f32 %p43, %f155, 0f7F800000
  p43 = (!(isnan(((float)(f155))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f155)) == ((float)(as_f32(0x7F800000u)))));
  // PTX:1410 setp.eq.f32 %p44, %f156, 0f7F800000
  p44 = (!(isnan(((float)(f156))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f156)) == ((float)(as_f32(0x7F800000u)))));
  // PTX:1411 and.pred %p45, %p43, %p44
  p45 = ((p43) && (p44));
  // PTX:1412 @%p45 bra $L__BB70_39
  if (p45) { goto L_BB70_39; }
  // PTX:1413 bra.uni $L__BB70_38
  goto L_BB70_38;
  // PTX:1415 $L__BB70_39:
L_BB70_39:;
  // PTX:1416 mov.b32 %r78, %f153
  asm("mov.b32 %0, %1;" : "=r"(r78) : "f"(f153));
  // PTX:1417 setp.lt.s32 %p49, %r78, 0
  p49 = (((int)(r78)) < ((int)(0)));
  // PTX:1418 selp.b32 %r79, 1075235812, 1061752795, %p49
  r79 = p49 ? 1075235812 : 1061752795;
  // PTX:1419 mov.b32 %r80, %f152
  asm("mov.b32 %0, %1;" : "=r"(r80) : "f"(f152));
  // PTX:1420 and.b32 %r81, %r80, -2147483648
  asm("and.b32 %0, %1, -2147483648;" : "=r"(r81) : "r"(r80));
  // PTX:1421 or.b32 %r82, %r81, %r79
  asm("or.b32 %0, %1, %2;" : "=r"(r82) : "r"(r81), "r"(r79));
  // PTX:1422 mov.b32 %f903, %r82
  asm("mov.b32 %0, %1;" : "=f"(f903) : "r"(r82));
  // PTX:1423 bra.uni $L__BB70_41
  goto L_BB70_41;
  // PTX:1425 $L__BB70_38:
L_BB70_38:;
  // PTX:1426 max.f32 %f565, %f156, %f155
  asm("max.f32 %0, %1, %2;" : "=f"(f565) : "f"(f156), "f"(f155));
  // PTX:1427 min.f32 %f566, %f156, %f155
  asm("min.f32 %0, %1, %2;" : "=f"(f566) : "f"(f156), "f"(f155));
  // PTX:1428 div.rn.f32 %f567, %f566, %f565
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f567) : "f"(f566), "f"(f565));
  // PTX:1429 mul.rn.f32 %f568, %f567, %f567
  asm("mul.rn.f32 %0, %1, %2;" : "=f"(f568) : "f"(f567), "f"(f567));
  // PTX:1430 mov.f32 %f569, 0fC0B59883
  asm("mov.f32 %0, 0fC0B59883;" : "=f"(f569) : );
  // PTX:1431 mov.f32 %f570, 0fBF52C7EA
  asm("mov.f32 %0, 0fBF52C7EA;" : "=f"(f570) : );
  // PTX:1432 fma.rn.f32 %f571, %f568, %f570, %f569
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f571) : "f"(f568), "f"(f570), "f"(f569));
  // PTX:1433 mov.f32 %f572, 0fC0D21907
  asm("mov.f32 %0, 0fC0D21907;" : "=f"(f572) : );
  // PTX:1434 fma.rn.f32 %f573, %f571, %f568, %f572
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f573) : "f"(f571), "f"(f568), "f"(f572));
  // PTX:1435 mul.f32 %f574, %f568, %f573
  asm("mul.f32 %0, %1, %2;" : "=f"(f574) : "f"(f568), "f"(f573));
  // PTX:1436 mul.f32 %f575, %f567, %f574
  asm("mul.f32 %0, %1, %2;" : "=f"(f575) : "f"(f567), "f"(f574));
  // PTX:1437 add.f32 %f576, %f568, 0f41355DC0
  asm("add.f32 %0, %1, 0f41355DC0;" : "=f"(f576) : "f"(f568));
  // PTX:1438 mov.f32 %f577, 0f41E6BD60
  asm("mov.f32 %0, 0f41E6BD60;" : "=f"(f577) : );
  // PTX:1439 fma.rn.f32 %f578, %f576, %f568, %f577
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f578) : "f"(f576), "f"(f568), "f"(f577));
  // PTX:1440 mov.f32 %f579, 0f419D92C8
  asm("mov.f32 %0, 0f419D92C8;" : "=f"(f579) : );
  // PTX:1441 fma.rn.f32 %f580, %f578, %f568, %f579
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f580) : "f"(f578), "f"(f568), "f"(f579));
  // PTX:1442 rcp.rn.f32 %f581, %f580
  asm("rcp.rn.f32 %0, %1;" : "=f"(f581) : "f"(f580));
  // PTX:1443 fma.rn.f32 %f582, %f575, %f581, %f567
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f582) : "f"(f575), "f"(f581), "f"(f567));
  // PTX:1444 mov.f32 %f583, 0f3FC90FDB
  asm("mov.f32 %0, 0f3FC90FDB;" : "=f"(f583) : );
  // PTX:1445 sub.f32 %f584, %f583, %f582
  asm("sub.f32 %0, %1, %2;" : "=f"(f584) : "f"(f583), "f"(f582));
  // PTX:1446 setp.gt.f32 %p46, %f156, %f155
  p46 = (!(isnan(((float)(f156))) || isnan(((float)(f155)))) && (((float)(f156)) > ((float)(f155))));
  // PTX:1447 selp.f32 %f585, %f584, %f582, %p46
  f585 = p46 ? f584 : f582;
  // PTX:1448 mov.b32 %r73, %f153
  asm("mov.b32 %0, %1;" : "=r"(r73) : "f"(f153));
  // PTX:1449 setp.lt.s32 %p47, %r73, 0
  p47 = (((int)(r73)) < ((int)(0)));
  // PTX:1450 mov.f32 %f586, 0f40490FDB
  asm("mov.f32 %0, 0f40490FDB;" : "=f"(f586) : );
  // PTX:1451 sub.f32 %f587, %f586, %f585
  asm("sub.f32 %0, %1, %2;" : "=f"(f587) : "f"(f586), "f"(f585));
  // PTX:1452 selp.f32 %f588, %f587, %f585, %p47
  f588 = p47 ? f587 : f585;
  // PTX:1453 mov.b32 %r74, %f588
  asm("mov.b32 %0, %1;" : "=r"(r74) : "f"(f588));
  // PTX:1454 mov.b32 %r75, %f152
  asm("mov.b32 %0, %1;" : "=r"(r75) : "f"(f152));
  // PTX:1455 and.b32 %r76, %r75, -2147483648
  asm("and.b32 %0, %1, -2147483648;" : "=r"(r76) : "r"(r75));
  // PTX:1456 or.b32 %r77, %r76, %r74
  asm("or.b32 %0, %1, %2;" : "=r"(r77) : "r"(r76), "r"(r74));
  // PTX:1457 mov.b32 %f589, %r77
  asm("mov.b32 %0, %1;" : "=f"(f589) : "r"(r77));
  // PTX:1458 add.f32 %f590, %f155, %f156
  asm("add.f32 %0, %1, %2;" : "=f"(f590) : "f"(f155), "f"(f156));
  // PTX:1459 setp.le.f32 %p48, %f590, 0f7F800000
  p48 = (!(isnan(((float)(f590))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f590)) <= ((float)(as_f32(0x7F800000u)))));
  // PTX:1460 selp.f32 %f903, %f589, %f590, %p48
  f903 = p48 ? f589 : f590;
  // PTX:1461 bra.uni $L__BB70_41
  goto L_BB70_41;
}
