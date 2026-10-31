// 机械还原自 PTX：synreal::kernel::evaluate_joint_armature(synreal::kernel::JointCoordinateView, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)
// PTX SHA256: c6108166b8b786dafaf6bc4bf3910ad962b67e2513e89d970b5b9c9ab51bc7d7
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__evaluate_joint_armature(ByVal<120, 8> param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, float param5, unsigned long long param6, unsigned long long param7, unsigned long long param8) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57, p58, p59, p60, p61, p62, p63, p64, p65, p66, p67;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440, f441, f442, f443, f444, f445, f446, f447, f448, f449, f450, f451, f452, f453, f454, f455, f456, f457, f458, f459, f460, f461, f462, f463, f464, f465, f466, f467, f468, f469, f470, f471, f472, f473, f474, f475, f476, f477, f478, f479, f480, f481, f482, f483, f484, f485, f486, f487, f488, f489, f490, f491, f492, f493, f494, f495, f496, f497, f498, f499, f500, f501, f502, f503, f504, f505, f506, f507, f508, f509, f510, f511, f512, f513, f514, f515, f516, f517, f518, f519, f520, f521, f522, f523, f524, f525, f526, f527, f528, f529, f530, f531, f532, f533, f534, f535, f536, f537, f538, f539, f540, f541, f542, f543, f544, f545, f546, f547, f548, f549, f550, f551, f552, f553, f554, f555, f556, f557, f558, f559, f560, f561, f562, f563, f564, f565, f566, f567, f568, f569, f570, f571, f572, f573, f574, f575, f576, f577, f578, f579, f580, f581, f582, f583, f584, f585, f586, f587, f588, f589, f590, f591, f592, f593, f594, f595, f596, f597, f598, f599, f600, f601, f602, f603, f604, f605, f606, f607, f608, f609, f610, f611, f612, f613, f614, f615, f616, f617, f618, f619, f620, f621, f622, f623, f624, f625, f626, f627, f628, f629, f630, f631, f632, f633, f634, f635, f636, f637, f638, f639, f640, f641, f642, f643, f644, f645, f646, f647, f648, f649, f650, f651, f652, f653, f654, f655, f656, f657, f658, f659, f660, f661, f662, f663, f664, f665, f666, f667, f668, f669, f670, f671, f672, f673, f674, f675, f676, f677, f678, f679, f680, f681, f682, f683, f684, f685, f686, f687, f688, f689, f690, f691, f692, f693, f694, f695, f696, f697, f698, f699, f700, f701, f702, f703, f704, f705, f706, f707, f708, f709, f710, f711, f712, f713, f714, f715, f716, f717, f718, f719, f720, f721, f722, f723, f724, f725, f726, f727, f728, f729, f730, f731, f732, f733, f734, f735, f736, f737, f738, f739, f740, f741, f742, f743, f744, f745, f746, f747, f748, f749, f750, f751, f752, f753, f754, f755, f756, f757, f758, f759, f760, f761, f762, f763, f764, f765, f766, f767, f768, f769, f770, f771, f772, f773, f774, f775, f776, f777, f778, f779, f780, f781, f782, f783, f784, f785, f786, f787, f788, f789, f790, f791, f792, f793, f794, f795, f796, f797, f798, f799, f800, f801, f802, f803, f804, f805, f806, f807, f808, f809, f810, f811, f812, f813, f814, f815, f816, f817, f818, f819, f820, f821, f822, f823, f824, f825, f826, f827, f828, f829, f830, f831, f832, f833, f834, f835, f836, f837, f838, f839, f840, f841, f842, f843, f844, f845, f846, f847, f848, f849, f850, f851, f852, f853, f854, f855, f856, f857, f858, f859, f860, f861, f862, f863, f864, f865, f866, f867, f868, f869, f870, f871, f872, f873, f874, f875, f876, f877, f878, f879, f880, f881, f882, f883, f884, f885, f886, f887, f888, f889, f890, f891, f892, f893, f894, f895, f896, f897, f898, f899, f900, f901, f902, f903, f904, f905, f906, f907, f908, f909, f910, f911, f912, f913, f914, f915, f916, f917, f918, f919, f920, f921, f922, f923, f924, f925, f926, f927, f928, f929, f930, f931, f932, f933, f934, f935, f936, f937, f938, f939, f940, f941, f942, f943, f944, f945, f946, f947, f948, f949, f950, f951, f952, f953, f954, f955, f956, f957, f958, f959, f960, f961, f962, f963, f964, f965, f966, f967, f968, f969, f970, f971, f972, f973, f974, f975, f976, f977, f978, f979, f980, f981, f982, f983, f984, f985, f986, f987, f988, f989, f990, f991, f992, f993, f994, f995, f996, f997, f998, f999, f1000, f1001, f1002, f1003, f1004, f1005, f1006, f1007, f1008, f1009, f1010, f1011, f1012, f1013, f1014, f1015, f1016, f1017, f1018, f1019, f1020, f1021, f1022, f1023, f1024, f1025, f1026, f1027, f1028, f1029, f1030, f1031, f1032, f1033, f1034, f1035, f1036, f1037, f1038, f1039, f1040, f1041, f1042, f1043, f1044, f1045, f1046, f1047, f1048, f1049, f1050, f1051, f1052;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135, rd136, rd137, rd138, rd139, rd140, rd141, rd142, rd143, rd144, rd145, rd146, rd147, rd148, rd149, rd150, rd151, rd152, rd153, rd154, rd155, rd156, rd157, rd158, rd159, rd160, rd161, rd162, rd163, rd164, rd165, rd166, rd167, rd168, rd169, rd170, rd171, rd172, rd173, rd174, rd175, rd176, rd177, rd178, rd179, rd180, rd181, rd182, rd183, rd184, rd185, rd186, rd187, rd188, rd189, rd190, rd191, rd192, rd193, rd194, rd195, rd196, rd197, rd198, rd199, rd200, rd201, rd202, rd203, rd204, rd205, rd206, rd207, rd208, rd209, rd210, rd211, rd212, rd213, rd214, rd215, rd216, rd217, rd218, rd219, rd220, rd221, rd222, rd223, rd224, rd225, rd226, rd227, rd228, rd229, rd230, rd231, rd232, rd233, rd234, rd235, rd236, rd237, rd238, rd239, rd240, rd241, rd242, rd243, rd244, rd245, rd246, rd247, rd248, rd249, rd250, rd251, rd252, rd253, rd254, rd255, rd256, rd257, rd258, rd259, rd260, rd261, rd262, rd263, rd264, rd265, rd266, rd267, rd268, rd269, rd270, rd271, rd272, rd273, rd274, rd275, rd276, rd277, rd278, rd279, rd280, rd281, rd282, rd283, rd284, rd285, rd286, rd287, rd288, rd289, rd290, rd291, rd292, rd293, rd294, rd295, rd296, rd297, rd298, rd299, rd300, rd301, rd302, rd303, rd304, rd305, rd306, rd307, rd308, rd309, rd310, rd311, rd312, rd313, rd314, rd315, rd316, rd317, rd318, rd319, rd320, rd321, rd322;
  // PTX:25 ld.param.u64 %rd47, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_1]
  rd47 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:26 ld.param.u64 %rd51, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_2]
  rd51 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:27 ld.param.u64 %rd49, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_6]
  rd49 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:28 ld.param.u64 %rd50, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_8]
  rd50 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:29 ld.param.u64 %rd46, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_0+112]
  rd46 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (112))));
  // PTX:30 ld.param.u64 %rd45, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_0+104]
  rd45 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (104))));
  // PTX:31 ld.param.u64 %rd44, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_0+96]
  rd44 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (96))));
  // PTX:32 ld.param.u64 %rd43, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_0+88]
  rd43 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (88))));
  // PTX:33 ld.param.u64 %rd41, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_0+72]
  rd41 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (72))));
  // PTX:34 ld.param.u64 %rd40, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_0+64]
  rd40 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (64))));
  // PTX:35 ld.param.u64 %rd38, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_0+48]
  rd38 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (48))));
  // PTX:36 ld.param.u64 %rd37, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_0+40]
  rd37 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (40))));
  // PTX:37 ld.param.u64 %rd36, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_0+32]
  rd36 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (32))));
  // PTX:38 ld.param.u64 %rd35, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_0+24]
  rd35 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (24))));
  // PTX:39 ld.param.u64 %rd34, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_0+16]
  rd34 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (16))));
  // PTX:40 ld.param.u64 %rd32, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_0]
  rd32 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:41 cvta.to.global.u64 %rd1, %rd50
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd50));
  // PTX:42 cvta.to.global.u64 %rd4, %rd49
  rd4 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd49));
  // PTX:43 cvta.to.global.u64 %rd5, %rd51
  rd5 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd51));
  // PTX:44 mov.u32 %r22, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r22) : "r"(blockIdx.x));
  // PTX:45 mov.u32 %r23, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r23) : "r"(blockDim.x));
  // PTX:46 mul.wide.u32 %rd54, %r22, %r23
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd54) : "r"(r22), "r"(r23));
  // PTX:47 mov.u32 %r24, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r24) : "r"(threadIdx.x));
  // PTX:48 cvt.u64.u32 %rd55, %r24
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd55) : "r"(r24));
  // PTX:49 add.s64 %rd6, %rd54, %rd55
  asm("add.s64 %0, %1, %2;" : "=l"(rd6) : "l"(rd54), "l"(rd55));
  // PTX:50 setp.ge.u64 %p1, %rd6, %rd45
  p1 = (((unsigned long long)(rd6)) >= ((unsigned long long)(rd45)));
  // PTX:51 @%p1 bra $L__BB69_74
  if (p1) { goto L_BB69_74; }
  // PTX:53 or.b64 %rd56, %rd6, %rd44
  asm("or.b64 %0, %1, %2;" : "=l"(rd56) : "l"(rd6), "l"(rd44));
  // PTX:54 and.b64 %rd57, %rd56, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd57) : "l"(rd56));
  // PTX:55 setp.eq.s64 %p2, %rd57, 0
  p2 = (((long long)(rd57)) == ((long long)(0)));
  // PTX:56 @%p2 bra $L__BB69_3
  if (p2) { goto L_BB69_3; }
  // PTX:58 rem.u64 %rd10, %rd6, %rd44
  asm("rem.u64 %0, %1, %2;" : "=l"(rd10) : "l"(rd6), "l"(rd44));
  // PTX:59 bra.uni $L__BB69_4
  goto L_BB69_4;
  // PTX:61 $L__BB69_3:
L_BB69_3:;
  // PTX:62 cvt.u32.u64 %r25, %rd44
  asm("cvt.u32.u64 %0, %1;" : "=r"(r25) : "l"(rd44));
  // PTX:63 cvt.u32.u64 %r26, %rd6
  asm("cvt.u32.u64 %0, %1;" : "=r"(r26) : "l"(rd6));
  // PTX:64 rem.u32 %r27, %r26, %r25
  asm("rem.u32 %0, %1, %2;" : "=r"(r27) : "r"(r26), "r"(r25));
  // PTX:65 cvt.u64.u32 %rd10, %r27
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd10) : "r"(r27));
  // PTX:67 $L__BB69_4:
L_BB69_4:;
  // PTX:68 cvta.to.global.u64 %rd58, %rd43
  rd58 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd43));
  // PTX:69 shl.b64 %rd59, %rd10, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd59) : "l"(rd10));
  // PTX:70 add.s64 %rd60, %rd58, %rd59
  asm("add.s64 %0, %1, %2;" : "=l"(rd60) : "l"(rd58), "l"(rd59));
  // PTX:71 ld.global.u32 %r28, [%rd60]
  r28 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))));
  // PTX:72 cvta.to.global.u64 %rd61, %rd47
  rd61 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd47));
  // PTX:73 mul.wide.s32 %rd62, %r28, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd62) : "r"(r28));
  // PTX:74 add.s64 %rd63, %rd61, %rd62
  asm("add.s64 %0, %1, %2;" : "=l"(rd63) : "l"(rd61), "l"(rd62));
  // PTX:75 ld.global.f32 %f1, [%rd63]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (0)))));
  // PTX:76 setp.leu.f32 %p3, %f1, 0f00000000
  p3 = ((isnan(((float)(f1))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f1)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:77 @%p3 bra $L__BB69_74
  if (p3) { goto L_BB69_74; }
  // PTX:79 @%p2 bra $L__BB69_7
  if (p2) { goto L_BB69_7; }
  // PTX:81 div.u64 %rd318, %rd6, %rd44
  asm("div.u64 %0, %1, %2;" : "=l"(rd318) : "l"(rd6), "l"(rd44));
  // PTX:82 bra.uni $L__BB69_8
  goto L_BB69_8;
  // PTX:84 $L__BB69_7:
L_BB69_7:;
  // PTX:85 cvt.u32.u64 %r29, %rd44
  asm("cvt.u32.u64 %0, %1;" : "=r"(r29) : "l"(rd44));
  // PTX:86 cvt.u32.u64 %r30, %rd6
  asm("cvt.u32.u64 %0, %1;" : "=r"(r30) : "l"(rd6));
  // PTX:87 div.u32 %r31, %r30, %r29
  asm("div.u32 %0, %1, %2;" : "=r"(r31) : "r"(r30), "r"(r29));
  // PTX:88 cvt.u64.u32 %rd318, %r31
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd318) : "r"(r31));
  // PTX:90 $L__BB69_8:
L_BB69_8:;
  // PTX:91 cvta.to.global.u64 %rd70, %rd32
  rd70 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd32));
  // PTX:92 mul.lo.s64 %rd71, %rd318, %rd46
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd71) : "l"(rd318), "l"(rd46));
  // PTX:93 cvt.u32.u64 %r1, %rd71
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd71));
  // PTX:94 cvta.to.global.u64 %rd72, %rd34
  rd72 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd34));
  // PTX:95 shl.b64 %rd73, %rd10, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd73) : "l"(rd10));
  // PTX:96 add.s64 %rd74, %rd72, %rd73
  asm("add.s64 %0, %1, %2;" : "=l"(rd74) : "l"(rd72), "l"(rd73));
  // PTX:97 ld.global.u32 %r32, [%rd74]
  r32 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (0)))));
  // PTX:98 mov.u64 %rd319, 0
  asm("mov.u64 %0, 0;" : "=l"(rd319) : );
  // PTX:99 cvt.s64.s32 %rd14, %r32
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd14) : "r"(r32));
  // PTX:100 ld.global.u32 %r33, [%rd74+4]
  r33 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (4)))));
  // PTX:101 mul.wide.s32 %rd75, %r33, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd75) : "r"(r33));
  // PTX:102 add.s64 %rd76, %rd70, %rd75
  asm("add.s64 %0, %1, %2;" : "=l"(rd76) : "l"(rd70), "l"(rd75));
  // PTX:103 ld.global.u32 %r2, [%rd76]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (0)))));
  // PTX:104 ld.global.u32 %r3, [%rd76+4]
  r3 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (4)))));
  // PTX:105 ld.global.u32 %r4, [%rd76+8]
  r4 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (8)))));
  // PTX:106 ld.global.u32 %r5, [%rd76+12]
  r5 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (12)))));
  // PTX:107 cvta.to.global.u64 %rd77, %rd35
  rd77 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd35));
  // PTX:108 mul.lo.s64 %rd78, %rd10, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd78) : "l"(rd10));
  // PTX:109 add.s64 %rd79, %rd77, %rd78
  asm("add.s64 %0, %1, %2;" : "=l"(rd79) : "l"(rd77), "l"(rd78));
  // PTX:110 ld.global.f32 %f1048, [%rd79]
  f1048 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (0)))));
  // PTX:111 ld.global.f32 %f1049, [%rd79+4]
  f1049 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (4)))));
  // PTX:112 ld.global.f32 %f1050, [%rd79+8]
  f1050 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (8)))));
  // PTX:113 cvta.to.global.u64 %rd80, %rd36
  rd80 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd36));
  // PTX:114 add.s64 %rd81, %rd80, %rd78
  asm("add.s64 %0, %1, %2;" : "=l"(rd81) : "l"(rd80), "l"(rd78));
  // PTX:115 ld.global.f32 %f1045, [%rd81]
  f1045 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (0)))));
  // PTX:116 ld.global.f32 %f1046, [%rd81+4]
  f1046 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (4)))));
  // PTX:117 ld.global.f32 %f1047, [%rd81+8]
  f1047 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (8)))));
  // PTX:118 cvta.to.global.u64 %rd82, %rd37
  rd82 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd37));
  // PTX:119 add.s64 %rd83, %rd82, %rd78
  asm("add.s64 %0, %1, %2;" : "=l"(rd83) : "l"(rd82), "l"(rd78));
  // PTX:120 ld.global.u32 %r112, [%rd83+8]
  r112 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (8)))));
  // PTX:121 ld.global.u32 %r111, [%rd83+4]
  r111 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (4)))));
  // PTX:122 ld.global.u32 %r110, [%rd83]
  r110 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (0)))));
  // PTX:123 setp.lt.s32 %p5, %r32, 0
  p5 = (((int)(r32)) < ((int)(0)));
  // PTX:124 mul.wide.s32 %rd84, %r32, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd84) : "r"(r32));
  // PTX:125 add.s64 %rd15, %rd70, %rd84
  asm("add.s64 %0, %1, %2;" : "=l"(rd15) : "l"(rd70), "l"(rd84));
  // PTX:126 cvta.to.global.u64 %rd85, %rd38
  rd85 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd38));
  // PTX:127 shl.b64 %rd86, %rd10, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd86) : "l"(rd10));
  // PTX:128 add.s64 %rd16, %rd85, %rd86
  asm("add.s64 %0, %1, %2;" : "=l"(rd16) : "l"(rd85), "l"(rd86));
  // PTX:129 cvta.to.global.u64 %rd87, %rd40
  rd87 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd40));
  // PTX:130 add.s64 %rd17, %rd87, %rd86
  asm("add.s64 %0, %1, %2;" : "=l"(rd17) : "l"(rd87), "l"(rd86));
  // PTX:131 cvta.to.global.u64 %rd88, %rd41
  rd88 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd41));
  // PTX:132 add.s64 %rd18, %rd88, %rd86
  asm("add.s64 %0, %1, %2;" : "=l"(rd18) : "l"(rd88), "l"(rd86));
  // PTX:133 mov.u64 %rd320, %rd319
  asm("mov.u64 %0, %1;" : "=l"(rd320) : "l"(rd319));
  // PTX:134 mov.u64 %rd321, %rd319
  asm("mov.u64 %0, %1;" : "=l"(rd321) : "l"(rd319));
  // PTX:135 mov.u64 %rd322, %rd319
  asm("mov.u64 %0, %1;" : "=l"(rd322) : "l"(rd319));
  // PTX:136 mov.f32 %f1001, %f1045
  asm("mov.f32 %0, %1;" : "=f"(f1001) : "f"(f1045));
  // PTX:137 mov.f32 %f1002, %f1046
  asm("mov.f32 %0, %1;" : "=f"(f1002) : "f"(f1046));
  // PTX:138 mov.f32 %f1003, %f1047
  asm("mov.f32 %0, %1;" : "=f"(f1003) : "f"(f1047));
  // PTX:139 mov.f32 %f1004, %f1048
  asm("mov.f32 %0, %1;" : "=f"(f1004) : "f"(f1048));
  // PTX:140 mov.f32 %f1005, %f1049
  asm("mov.f32 %0, %1;" : "=f"(f1005) : "f"(f1049));
  // PTX:141 mov.f32 %f1006, %f1050
  asm("mov.f32 %0, %1;" : "=f"(f1006) : "f"(f1050));
  // PTX:142 mov.u32 %r107, %r110
  asm("mov.u32 %0, %1;" : "=r"(r107) : "r"(r110));
  // PTX:143 mov.u32 %r108, %r111
  asm("mov.u32 %0, %1;" : "=r"(r108) : "r"(r111));
  // PTX:144 mov.u32 %r109, %r112
  asm("mov.u32 %0, %1;" : "=r"(r109) : "r"(r112));
  // PTX:145 @%p5 bra $L__BB69_10
  if (p5) { goto L_BB69_10; }
  // PTX:147 ld.global.u32 %r34, [%rd15]
  r34 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))));
  // PTX:148 add.s32 %r35, %r34, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r35) : "r"(r34), "r"(r1));
  // PTX:149 ld.global.u32 %r36, [%rd15+4]
  r36 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (4)))));
  // PTX:150 add.s32 %r37, %r36, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r37) : "r"(r36), "r"(r1));
  // PTX:151 ld.global.u32 %r38, [%rd15+8]
  r38 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (8)))));
  // PTX:152 add.s32 %r39, %r38, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r39) : "r"(r38), "r"(r1));
  // PTX:153 ld.global.u32 %r40, [%rd15+12]
  r40 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (12)))));
  // PTX:154 add.s32 %r41, %r40, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r41) : "r"(r40), "r"(r1));
  // PTX:155 cvt.s64.s32 %rd322, %r35
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd322) : "r"(r35));
  // PTX:156 mul.wide.s32 %rd89, %r35, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd89) : "r"(r35));
  // PTX:157 add.s64 %rd90, %rd5, %rd89
  asm("add.s64 %0, %1, %2;" : "=l"(rd90) : "l"(rd5), "l"(rd89));
  // PTX:158 ld.global.f32 %f265, [%rd90]
  f265 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (0)))));
  // PTX:159 ld.global.f32 %f266, [%rd16]
  f266 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:160 ld.global.f32 %f267, [%rd90+4]
  f267 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (4)))));
  // PTX:161 ld.global.f32 %f268, [%rd90+8]
  f268 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (8)))));
  // PTX:162 cvt.s64.s32 %rd321, %r37
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd321) : "r"(r37));
  // PTX:163 mul.wide.s32 %rd91, %r37, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd91) : "r"(r37));
  // PTX:164 add.s64 %rd92, %rd5, %rd91
  asm("add.s64 %0, %1, %2;" : "=l"(rd92) : "l"(rd5), "l"(rd91));
  // PTX:165 ld.global.f32 %f269, [%rd92]
  f269 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (0)))));
  // PTX:166 ld.global.f32 %f270, [%rd16+4]
  f270 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (4)))));
  // PTX:167 mul.f32 %f271, %f270, %f269
  asm("mul.f32 %0, %1, %2;" : "=f"(f271) : "f"(f270), "f"(f269));
  // PTX:168 ld.global.f32 %f272, [%rd92+4]
  f272 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (4)))));
  // PTX:169 mul.f32 %f273, %f270, %f272
  asm("mul.f32 %0, %1, %2;" : "=f"(f273) : "f"(f270), "f"(f272));
  // PTX:170 ld.global.f32 %f274, [%rd92+8]
  f274 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (8)))));
  // PTX:171 mul.f32 %f275, %f270, %f274
  asm("mul.f32 %0, %1, %2;" : "=f"(f275) : "f"(f270), "f"(f274));
  // PTX:172 fma.rn.f32 %f276, %f266, %f265, %f271
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f276) : "f"(f266), "f"(f265), "f"(f271));
  // PTX:173 fma.rn.f32 %f277, %f266, %f267, %f273
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f277) : "f"(f266), "f"(f267), "f"(f273));
  // PTX:174 fma.rn.f32 %f278, %f266, %f268, %f275
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f278) : "f"(f266), "f"(f268), "f"(f275));
  // PTX:175 cvt.s64.s32 %rd320, %r39
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd320) : "r"(r39));
  // PTX:176 mul.wide.s32 %rd93, %r39, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd93) : "r"(r39));
  // PTX:177 add.s64 %rd94, %rd5, %rd93
  asm("add.s64 %0, %1, %2;" : "=l"(rd94) : "l"(rd5), "l"(rd93));
  // PTX:178 ld.global.f32 %f279, [%rd94]
  f279 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd94) + (0)))));
  // PTX:179 ld.global.f32 %f280, [%rd16+8]
  f280 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (8)))));
  // PTX:180 ld.global.f32 %f281, [%rd94+4]
  f281 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd94) + (4)))));
  // PTX:181 ld.global.f32 %f282, [%rd94+8]
  f282 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd94) + (8)))));
  // PTX:182 fma.rn.f32 %f283, %f280, %f279, %f276
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f283) : "f"(f280), "f"(f279), "f"(f276));
  // PTX:183 fma.rn.f32 %f284, %f280, %f281, %f277
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f284) : "f"(f280), "f"(f281), "f"(f277));
  // PTX:184 fma.rn.f32 %f285, %f280, %f282, %f278
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f285) : "f"(f280), "f"(f282), "f"(f278));
  // PTX:185 cvt.s64.s32 %rd319, %r41
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd319) : "r"(r41));
  // PTX:186 mul.wide.s32 %rd95, %r41, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd95) : "r"(r41));
  // PTX:187 add.s64 %rd96, %rd5, %rd95
  asm("add.s64 %0, %1, %2;" : "=l"(rd96) : "l"(rd5), "l"(rd95));
  // PTX:188 ld.global.f32 %f286, [%rd96]
  f286 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (0)))));
  // PTX:189 ld.global.f32 %f287, [%rd16+12]
  f287 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (12)))));
  // PTX:190 ld.global.f32 %f288, [%rd96+4]
  f288 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (4)))));
  // PTX:191 ld.global.f32 %f289, [%rd96+8]
  f289 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (8)))));
  // PTX:192 fma.rn.f32 %f1004, %f287, %f286, %f283
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1004) : "f"(f287), "f"(f286), "f"(f283));
  // PTX:193 fma.rn.f32 %f1005, %f287, %f288, %f284
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1005) : "f"(f287), "f"(f288), "f"(f284));
  // PTX:194 fma.rn.f32 %f1006, %f287, %f289, %f285
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1006) : "f"(f287), "f"(f289), "f"(f285));
  // PTX:195 ld.global.f32 %f290, [%rd17]
  f290 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:196 ld.global.f32 %f291, [%rd17+4]
  f291 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (4)))));
  // PTX:197 mul.f32 %f292, %f291, %f269
  asm("mul.f32 %0, %1, %2;" : "=f"(f292) : "f"(f291), "f"(f269));
  // PTX:198 mul.f32 %f293, %f291, %f272
  asm("mul.f32 %0, %1, %2;" : "=f"(f293) : "f"(f291), "f"(f272));
  // PTX:199 mul.f32 %f294, %f291, %f274
  asm("mul.f32 %0, %1, %2;" : "=f"(f294) : "f"(f291), "f"(f274));
  // PTX:200 fma.rn.f32 %f295, %f290, %f265, %f292
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f295) : "f"(f290), "f"(f265), "f"(f292));
  // PTX:201 fma.rn.f32 %f296, %f290, %f267, %f293
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f296) : "f"(f290), "f"(f267), "f"(f293));
  // PTX:202 fma.rn.f32 %f297, %f290, %f268, %f294
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f297) : "f"(f290), "f"(f268), "f"(f294));
  // PTX:203 ld.global.f32 %f298, [%rd17+8]
  f298 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (8)))));
  // PTX:204 fma.rn.f32 %f299, %f298, %f279, %f295
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f299) : "f"(f298), "f"(f279), "f"(f295));
  // PTX:205 fma.rn.f32 %f300, %f298, %f281, %f296
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f300) : "f"(f298), "f"(f281), "f"(f296));
  // PTX:206 fma.rn.f32 %f301, %f298, %f282, %f297
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f301) : "f"(f298), "f"(f282), "f"(f297));
  // PTX:207 ld.global.f32 %f302, [%rd17+12]
  f302 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (12)))));
  // PTX:208 fma.rn.f32 %f1001, %f302, %f286, %f299
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1001) : "f"(f302), "f"(f286), "f"(f299));
  // PTX:209 fma.rn.f32 %f1002, %f302, %f288, %f300
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1002) : "f"(f302), "f"(f288), "f"(f300));
  // PTX:210 fma.rn.f32 %f1003, %f302, %f289, %f301
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1003) : "f"(f302), "f"(f289), "f"(f301));
  // PTX:211 ld.global.f32 %f303, [%rd18]
  f303 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (0)))));
  // PTX:212 ld.global.f32 %f304, [%rd18+4]
  f304 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (4)))));
  // PTX:213 mul.f32 %f305, %f304, %f269
  asm("mul.f32 %0, %1, %2;" : "=f"(f305) : "f"(f304), "f"(f269));
  // PTX:214 mul.f32 %f306, %f304, %f272
  asm("mul.f32 %0, %1, %2;" : "=f"(f306) : "f"(f304), "f"(f272));
  // PTX:215 mul.f32 %f307, %f304, %f274
  asm("mul.f32 %0, %1, %2;" : "=f"(f307) : "f"(f304), "f"(f274));
  // PTX:216 fma.rn.f32 %f308, %f303, %f265, %f305
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f308) : "f"(f303), "f"(f265), "f"(f305));
  // PTX:217 fma.rn.f32 %f309, %f303, %f267, %f306
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f309) : "f"(f303), "f"(f267), "f"(f306));
  // PTX:218 fma.rn.f32 %f310, %f303, %f268, %f307
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f310) : "f"(f303), "f"(f268), "f"(f307));
  // PTX:219 ld.global.f32 %f311, [%rd18+8]
  f311 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (8)))));
  // PTX:220 fma.rn.f32 %f312, %f311, %f279, %f308
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f312) : "f"(f311), "f"(f279), "f"(f308));
  // PTX:221 fma.rn.f32 %f313, %f311, %f281, %f309
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f313) : "f"(f311), "f"(f281), "f"(f309));
  // PTX:222 fma.rn.f32 %f314, %f311, %f282, %f310
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f314) : "f"(f311), "f"(f282), "f"(f310));
  // PTX:223 ld.global.f32 %f315, [%rd18+12]
  f315 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (12)))));
  // PTX:224 fma.rn.f32 %f316, %f315, %f286, %f312
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f316) : "f"(f315), "f"(f286), "f"(f312));
  // PTX:225 fma.rn.f32 %f317, %f315, %f288, %f313
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f317) : "f"(f315), "f"(f288), "f"(f313));
  // PTX:226 fma.rn.f32 %f318, %f315, %f289, %f314
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f318) : "f"(f315), "f"(f289), "f"(f314));
  // PTX:227 mov.b32 %r109, %f318
  asm("mov.b32 %0, %1;" : "=r"(r109) : "f"(f318));
  // PTX:228 mov.b32 %r108, %f317
  asm("mov.b32 %0, %1;" : "=r"(r108) : "f"(f317));
  // PTX:229 mov.b32 %r107, %f316
  asm("mov.b32 %0, %1;" : "=r"(r107) : "f"(f316));
  // PTX:231 $L__BB69_10:
L_BB69_10:;
  // PTX:232 ld.param.u64 %rd315, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_0+8]
  rd315 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (8))));
  // PTX:233 ld.param.u64 %rd314, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_0+56]
  rd314 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (56))));
  // PTX:234 cvta.to.global.u64 %rd97, %rd314
  rd97 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd314));
  // PTX:235 add.s64 %rd99, %rd97, %rd86
  asm("add.s64 %0, %1, %2;" : "=l"(rd99) : "l"(rd97), "l"(rd86));
  // PTX:236 add.s32 %r42, %r2, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r42) : "r"(r2), "r"(r1));
  // PTX:237 cvt.s64.s32 %rd27, %r42
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd27) : "r"(r42));
  // PTX:238 mul.wide.s32 %rd100, %r42, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd100) : "r"(r42));
  // PTX:239 add.s64 %rd101, %rd5, %rd100
  asm("add.s64 %0, %1, %2;" : "=l"(rd101) : "l"(rd5), "l"(rd100));
  // PTX:240 ld.global.f32 %f20, [%rd101]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd101) + (0)))));
  // PTX:241 ld.global.f32 %f21, [%rd99]
  f21 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (0)))));
  // PTX:242 ld.global.f32 %f22, [%rd101+4]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd101) + (4)))));
  // PTX:243 ld.global.f32 %f23, [%rd101+8]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd101) + (8)))));
  // PTX:244 add.s32 %r43, %r3, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r43) : "r"(r3), "r"(r1));
  // PTX:245 cvt.s64.s32 %rd28, %r43
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd28) : "r"(r43));
  // PTX:246 mul.wide.s32 %rd102, %r43, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd102) : "r"(r43));
  // PTX:247 add.s64 %rd103, %rd5, %rd102
  asm("add.s64 %0, %1, %2;" : "=l"(rd103) : "l"(rd5), "l"(rd102));
  // PTX:248 ld.global.f32 %f24, [%rd103]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd103) + (0)))));
  // PTX:249 ld.global.f32 %f25, [%rd99+4]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (4)))));
  // PTX:250 mul.f32 %f319, %f25, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f319) : "f"(f25), "f"(f24));
  // PTX:251 ld.global.f32 %f26, [%rd103+4]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd103) + (4)))));
  // PTX:252 mul.f32 %f320, %f25, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f320) : "f"(f25), "f"(f26));
  // PTX:253 ld.global.f32 %f27, [%rd103+8]
  f27 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd103) + (8)))));
  // PTX:254 mul.f32 %f321, %f25, %f27
  asm("mul.f32 %0, %1, %2;" : "=f"(f321) : "f"(f25), "f"(f27));
  // PTX:255 fma.rn.f32 %f322, %f21, %f20, %f319
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f322) : "f"(f21), "f"(f20), "f"(f319));
  // PTX:256 fma.rn.f32 %f323, %f21, %f22, %f320
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f323) : "f"(f21), "f"(f22), "f"(f320));
  // PTX:257 fma.rn.f32 %f324, %f21, %f23, %f321
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f324) : "f"(f21), "f"(f23), "f"(f321));
  // PTX:258 add.s32 %r44, %r4, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r44) : "r"(r4), "r"(r1));
  // PTX:259 cvt.s64.s32 %rd29, %r44
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd29) : "r"(r44));
  // PTX:260 mul.wide.s32 %rd104, %r44, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd104) : "r"(r44));
  // PTX:261 add.s64 %rd105, %rd5, %rd104
  asm("add.s64 %0, %1, %2;" : "=l"(rd105) : "l"(rd5), "l"(rd104));
  // PTX:262 ld.global.f32 %f28, [%rd105]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (0)))));
  // PTX:263 ld.global.f32 %f29, [%rd99+8]
  f29 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (8)))));
  // PTX:264 ld.global.f32 %f30, [%rd105+4]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (4)))));
  // PTX:265 ld.global.f32 %f31, [%rd105+8]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (8)))));
  // PTX:266 fma.rn.f32 %f325, %f29, %f28, %f322
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f325) : "f"(f29), "f"(f28), "f"(f322));
  // PTX:267 fma.rn.f32 %f326, %f29, %f30, %f323
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f326) : "f"(f29), "f"(f30), "f"(f323));
  // PTX:268 fma.rn.f32 %f327, %f29, %f31, %f324
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f327) : "f"(f29), "f"(f31), "f"(f324));
  // PTX:269 add.s32 %r45, %r5, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r45) : "r"(r5), "r"(r1));
  // PTX:270 cvt.s64.s32 %rd30, %r45
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd30) : "r"(r45));
  // PTX:271 mul.wide.s32 %rd106, %r45, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd106) : "r"(r45));
  // PTX:272 add.s64 %rd107, %rd5, %rd106
  asm("add.s64 %0, %1, %2;" : "=l"(rd107) : "l"(rd5), "l"(rd106));
  // PTX:273 ld.global.f32 %f32, [%rd107]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd107) + (0)))));
  // PTX:274 ld.global.f32 %f33, [%rd99+12]
  f33 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (12)))));
  // PTX:275 ld.global.f32 %f34, [%rd107+4]
  f34 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd107) + (4)))));
  // PTX:276 ld.global.f32 %f35, [%rd107+8]
  f35 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd107) + (8)))));
  // PTX:277 fma.rn.f32 %f36, %f33, %f32, %f325
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f36) : "f"(f33), "f"(f32), "f"(f325));
  // PTX:278 fma.rn.f32 %f37, %f33, %f34, %f326
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f37) : "f"(f33), "f"(f34), "f"(f326));
  // PTX:279 fma.rn.f32 %f38, %f33, %f35, %f327
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f38) : "f"(f33), "f"(f35), "f"(f327));
  // PTX:280 cvta.to.global.u64 %rd108, %rd315
  rd108 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd315));
  // PTX:281 add.s64 %rd110, %rd108, %rd59
  asm("add.s64 %0, %1, %2;" : "=l"(rd110) : "l"(rd108), "l"(rd59));
  // PTX:282 ld.global.u32 %r15, [%rd110]
  r15 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd110) + (0)))));
  // PTX:283 setp.eq.s32 %p6, %r15, 0
  p6 = (((int)(r15)) == ((int)(0)));
  // PTX:284 @%p6 bra $L__BB69_25
  if (p6) { goto L_BB69_25; }
  // PTX:286 ld.param.u64 %rd262, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_0+80]
  rd262 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (80))));
  // PTX:287 shl.b64 %rd261, %rd10, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd261) : "l"(rd10));
  // PTX:288 cvta.to.global.u64 %rd260, %rd262
  rd260 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd262));
  // PTX:289 add.s64 %rd259, %rd260, %rd261
  asm("add.s64 %0, %1, %2;" : "=l"(rd259) : "l"(rd260), "l"(rd261));
  // PTX:290 ld.global.f32 %f39, [%rd259]
  f39 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd259) + (0)))));
  // PTX:291 ld.global.f32 %f40, [%rd259+4]
  f40 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd259) + (4)))));
  // PTX:292 mul.f32 %f328, %f40, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f328) : "f"(f40), "f"(f24));
  // PTX:293 mul.f32 %f329, %f40, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f329) : "f"(f40), "f"(f26));
  // PTX:294 mul.f32 %f330, %f40, %f27
  asm("mul.f32 %0, %1, %2;" : "=f"(f330) : "f"(f40), "f"(f27));
  // PTX:295 fma.rn.f32 %f331, %f39, %f20, %f328
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f331) : "f"(f39), "f"(f20), "f"(f328));
  // PTX:296 fma.rn.f32 %f332, %f39, %f22, %f329
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f332) : "f"(f39), "f"(f22), "f"(f329));
  // PTX:297 fma.rn.f32 %f333, %f39, %f23, %f330
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f333) : "f"(f39), "f"(f23), "f"(f330));
  // PTX:298 ld.global.f32 %f41, [%rd259+8]
  f41 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd259) + (8)))));
  // PTX:299 fma.rn.f32 %f334, %f41, %f28, %f331
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f334) : "f"(f41), "f"(f28), "f"(f331));
  // PTX:300 fma.rn.f32 %f335, %f41, %f30, %f332
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f335) : "f"(f41), "f"(f30), "f"(f332));
  // PTX:301 fma.rn.f32 %f336, %f41, %f31, %f333
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f336) : "f"(f41), "f"(f31), "f"(f333));
  // PTX:302 ld.global.f32 %f42, [%rd259+12]
  f42 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd259) + (12)))));
  // PTX:303 fma.rn.f32 %f43, %f42, %f32, %f334
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f43) : "f"(f42), "f"(f32), "f"(f334));
  // PTX:304 fma.rn.f32 %f44, %f42, %f34, %f335
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f44) : "f"(f42), "f"(f34), "f"(f335));
  // PTX:305 fma.rn.f32 %f45, %f42, %f35, %f336
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f45) : "f"(f42), "f"(f35), "f"(f336));
  // PTX:306 sub.f32 %f46, %f1001, %f1004
  asm("sub.f32 %0, %1, %2;" : "=f"(f46) : "f"(f1001), "f"(f1004));
  // PTX:307 sub.f32 %f47, %f1002, %f1005
  asm("sub.f32 %0, %1, %2;" : "=f"(f47) : "f"(f1002), "f"(f1005));
  // PTX:308 mul.f32 %f337, %f47, %f47
  asm("mul.f32 %0, %1, %2;" : "=f"(f337) : "f"(f47), "f"(f47));
  // PTX:309 sub.f32 %f48, %f1003, %f1006
  asm("sub.f32 %0, %1, %2;" : "=f"(f48) : "f"(f1003), "f"(f1006));
  // PTX:310 fma.rn.f32 %f338, %f46, %f46, %f337
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f338) : "f"(f46), "f"(f46), "f"(f337));
  // PTX:311 fma.rn.f32 %f339, %f48, %f48, %f338
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f339) : "f"(f48), "f"(f48), "f"(f338));
  // PTX:312 sqrt.rn.f32 %f49, %f339
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f49) : "f"(f339));
  // PTX:313 setp.leu.f32 %p7, %f49, 0f322BCC77
  p7 = ((isnan(((float)(f49))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f49)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:314 @%p7 bra $L__BB69_74
  if (p7) { goto L_BB69_74; }
  // PTX:316 abs.f32 %f340, %f49
  asm("abs.f32 %0, %1;" : "=f"(f340) : "f"(f49));
  // PTX:317 setp.geu.f32 %p8, %f340, 0f7F800000
  p8 = ((isnan(((float)(f340))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f340)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:318 @%p8 bra $L__BB69_74
  if (p8) { goto L_BB69_74; }
  // PTX:320 div.rn.f32 %f50, %f46, %f49
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f50) : "f"(f46), "f"(f49));
  // PTX:321 mov.b32 %f341, %r107
  asm("mov.b32 %0, %1;" : "=f"(f341) : "r"(r107));
  // PTX:322 sub.f32 %f342, %f341, %f1004
  asm("sub.f32 %0, %1, %2;" : "=f"(f342) : "f"(f341), "f"(f1004));
  // PTX:323 mov.b32 %f343, %r108
  asm("mov.b32 %0, %1;" : "=f"(f343) : "r"(r108));
  // PTX:324 sub.f32 %f344, %f343, %f1005
  asm("sub.f32 %0, %1, %2;" : "=f"(f344) : "f"(f343), "f"(f1005));
  // PTX:325 mov.b32 %f345, %r109
  asm("mov.b32 %0, %1;" : "=f"(f345) : "r"(r109));
  // PTX:326 sub.f32 %f346, %f345, %f1006
  asm("sub.f32 %0, %1, %2;" : "=f"(f346) : "f"(f345), "f"(f1006));
  // PTX:327 div.rn.f32 %f51, %f47, %f49
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f51) : "f"(f47), "f"(f49));
  // PTX:328 mul.f32 %f347, %f344, %f51
  asm("mul.f32 %0, %1, %2;" : "=f"(f347) : "f"(f344), "f"(f51));
  // PTX:329 div.rn.f32 %f52, %f48, %f49
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f52) : "f"(f48), "f"(f49));
  // PTX:330 fma.rn.f32 %f348, %f342, %f50, %f347
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f348) : "f"(f342), "f"(f50), "f"(f347));
  // PTX:331 fma.rn.f32 %f53, %f346, %f52, %f348
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f53) : "f"(f346), "f"(f52), "f"(f348));
  // PTX:332 mul.f32 %f349, %f50, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f349) : "f"(f50), "f"(f53));
  // PTX:333 mul.f32 %f350, %f51, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f350) : "f"(f51), "f"(f53));
  // PTX:334 mul.f32 %f351, %f52, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f351) : "f"(f52), "f"(f53));
  // PTX:335 sub.f32 %f54, %f342, %f349
  asm("sub.f32 %0, %1, %2;" : "=f"(f54) : "f"(f342), "f"(f349));
  // PTX:336 sub.f32 %f55, %f344, %f350
  asm("sub.f32 %0, %1, %2;" : "=f"(f55) : "f"(f344), "f"(f350));
  // PTX:337 sub.f32 %f56, %f346, %f351
  asm("sub.f32 %0, %1, %2;" : "=f"(f56) : "f"(f346), "f"(f351));
  // PTX:338 sub.f32 %f352, %f43, %f36
  asm("sub.f32 %0, %1, %2;" : "=f"(f352) : "f"(f43), "f"(f36));
  // PTX:339 sub.f32 %f353, %f44, %f37
  asm("sub.f32 %0, %1, %2;" : "=f"(f353) : "f"(f44), "f"(f37));
  // PTX:340 mul.f32 %f354, %f353, %f51
  asm("mul.f32 %0, %1, %2;" : "=f"(f354) : "f"(f353), "f"(f51));
  // PTX:341 sub.f32 %f355, %f45, %f38
  asm("sub.f32 %0, %1, %2;" : "=f"(f355) : "f"(f45), "f"(f38));
  // PTX:342 fma.rn.f32 %f356, %f352, %f50, %f354
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f356) : "f"(f352), "f"(f50), "f"(f354));
  // PTX:343 fma.rn.f32 %f57, %f52, %f355, %f356
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f57) : "f"(f52), "f"(f355), "f"(f356));
  // PTX:344 mul.f32 %f357, %f50, %f57
  asm("mul.f32 %0, %1, %2;" : "=f"(f357) : "f"(f50), "f"(f57));
  // PTX:345 mul.f32 %f358, %f51, %f57
  asm("mul.f32 %0, %1, %2;" : "=f"(f358) : "f"(f51), "f"(f57));
  // PTX:346 mul.f32 %f359, %f52, %f57
  asm("mul.f32 %0, %1, %2;" : "=f"(f359) : "f"(f52), "f"(f57));
  // PTX:347 sub.f32 %f58, %f352, %f357
  asm("sub.f32 %0, %1, %2;" : "=f"(f58) : "f"(f352), "f"(f357));
  // PTX:348 sub.f32 %f59, %f353, %f358
  asm("sub.f32 %0, %1, %2;" : "=f"(f59) : "f"(f353), "f"(f358));
  // PTX:349 sub.f32 %f60, %f355, %f359
  asm("sub.f32 %0, %1, %2;" : "=f"(f60) : "f"(f355), "f"(f359));
  // PTX:350 mul.f32 %f360, %f55, %f55
  asm("mul.f32 %0, %1, %2;" : "=f"(f360) : "f"(f55), "f"(f55));
  // PTX:351 fma.rn.f32 %f361, %f54, %f54, %f360
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f361) : "f"(f54), "f"(f54), "f"(f360));
  // PTX:352 fma.rn.f32 %f362, %f56, %f56, %f361
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f362) : "f"(f56), "f"(f56), "f"(f361));
  // PTX:353 sqrt.rn.f32 %f61, %f362
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f61) : "f"(f362));
  // PTX:354 mul.f32 %f363, %f59, %f59
  asm("mul.f32 %0, %1, %2;" : "=f"(f363) : "f"(f59), "f"(f59));
  // PTX:355 fma.rn.f32 %f364, %f58, %f58, %f363
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f364) : "f"(f58), "f"(f58), "f"(f363));
  // PTX:356 fma.rn.f32 %f365, %f60, %f60, %f364
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f365) : "f"(f60), "f"(f60), "f"(f364));
  // PTX:357 sqrt.rn.f32 %f62, %f365
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f62) : "f"(f365));
  // PTX:358 setp.leu.f32 %p9, %f61, 0f322BCC77
  p9 = ((isnan(((float)(f61))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f61)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:359 setp.leu.f32 %p10, %f62, 0f322BCC77
  p10 = ((isnan(((float)(f62))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f62)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:360 or.pred %p11, %p9, %p10
  p11 = ((p9) || (p10));
  // PTX:361 @%p11 bra $L__BB69_74
  if (p11) { goto L_BB69_74; }
  // PTX:363 abs.f32 %f366, %f61
  asm("abs.f32 %0, %1;" : "=f"(f366) : "f"(f61));
  // PTX:364 setp.geu.f32 %p12, %f366, 0f7F800000
  p12 = ((isnan(((float)(f366))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f366)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:365 @%p12 bra $L__BB69_74
  if (p12) { goto L_BB69_74; }
  // PTX:367 abs.f32 %f367, %f62
  asm("abs.f32 %0, %1;" : "=f"(f367) : "f"(f62));
  // PTX:368 setp.geu.f32 %p13, %f367, 0f7F800000
  p13 = ((isnan(((float)(f367))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f367)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:369 @%p13 bra $L__BB69_74
  if (p13) { goto L_BB69_74; }
  // PTX:371 div.rn.f32 %f63, %f54, %f61
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f63) : "f"(f54), "f"(f61));
  // PTX:372 div.rn.f32 %f64, %f60, %f62
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f64) : "f"(f60), "f"(f62));
  // PTX:373 div.rn.f32 %f65, %f55, %f61
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f65) : "f"(f55), "f"(f61));
  // PTX:374 mul.f32 %f368, %f65, %f64
  asm("mul.f32 %0, %1, %2;" : "=f"(f368) : "f"(f65), "f"(f64));
  // PTX:375 div.rn.f32 %f66, %f59, %f62
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f66) : "f"(f59), "f"(f62));
  // PTX:376 div.rn.f32 %f67, %f56, %f61
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f67) : "f"(f56), "f"(f61));
  // PTX:377 mul.f32 %f369, %f67, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f369) : "f"(f67), "f"(f66));
  // PTX:378 sub.f32 %f370, %f368, %f369
  asm("sub.f32 %0, %1, %2;" : "=f"(f370) : "f"(f368), "f"(f369));
  // PTX:379 div.rn.f32 %f68, %f58, %f62
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f68) : "f"(f58), "f"(f62));
  // PTX:380 mul.f32 %f371, %f67, %f68
  asm("mul.f32 %0, %1, %2;" : "=f"(f371) : "f"(f67), "f"(f68));
  // PTX:381 mul.f32 %f372, %f63, %f64
  asm("mul.f32 %0, %1, %2;" : "=f"(f372) : "f"(f63), "f"(f64));
  // PTX:382 sub.f32 %f373, %f371, %f372
  asm("sub.f32 %0, %1, %2;" : "=f"(f373) : "f"(f371), "f"(f372));
  // PTX:383 mul.f32 %f374, %f63, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f374) : "f"(f63), "f"(f66));
  // PTX:384 mul.f32 %f375, %f65, %f68
  asm("mul.f32 %0, %1, %2;" : "=f"(f375) : "f"(f65), "f"(f68));
  // PTX:385 sub.f32 %f376, %f374, %f375
  asm("sub.f32 %0, %1, %2;" : "=f"(f376) : "f"(f374), "f"(f375));
  // PTX:386 mul.f32 %f377, %f51, %f373
  asm("mul.f32 %0, %1, %2;" : "=f"(f377) : "f"(f51), "f"(f373));
  // PTX:387 fma.rn.f32 %f378, %f50, %f370, %f377
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f378) : "f"(f50), "f"(f370), "f"(f377));
  // PTX:388 fma.rn.f32 %f69, %f52, %f376, %f378
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f69) : "f"(f52), "f"(f376), "f"(f378));
  // PTX:389 mul.f32 %f379, %f65, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f379) : "f"(f65), "f"(f66));
  // PTX:390 fma.rn.f32 %f380, %f63, %f68, %f379
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f380) : "f"(f63), "f"(f68), "f"(f379));
  // PTX:391 fma.rn.f32 %f70, %f67, %f64, %f380
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f70) : "f"(f67), "f"(f64), "f"(f380));
  // PTX:392 mul.f32 %f381, %f69, %f69
  asm("mul.f32 %0, %1, %2;" : "=f"(f381) : "f"(f69), "f"(f69));
  // PTX:393 fma.rn.f32 %f71, %f70, %f70, %f381
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f71) : "f"(f70), "f"(f70), "f"(f381));
  // PTX:394 setp.leu.f32 %p14, %f71, 0f2B8CBCCC
  p14 = ((isnan(((float)(f71))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) || (((float)(f71)) <= ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:395 @%p14 bra $L__BB69_74
  if (p14) { goto L_BB69_74; }
  // PTX:397 abs.f32 %f382, %f71
  asm("abs.f32 %0, %1;" : "=f"(f382) : "f"(f71));
  // PTX:398 setp.geu.f32 %p15, %f382, 0f7F800000
  p15 = ((isnan(((float)(f382))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f382)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:399 @%p15 bra $L__BB69_74
  if (p15) { goto L_BB69_74; }
  // PTX:401 mul.f32 %f383, %f51, %f67
  asm("mul.f32 %0, %1, %2;" : "=f"(f383) : "f"(f51), "f"(f67));
  // PTX:402 mul.f32 %f384, %f52, %f65
  asm("mul.f32 %0, %1, %2;" : "=f"(f384) : "f"(f52), "f"(f65));
  // PTX:403 sub.f32 %f72, %f383, %f384
  asm("sub.f32 %0, %1, %2;" : "=f"(f72) : "f"(f383), "f"(f384));
  // PTX:404 mul.f32 %f385, %f50, %f67
  asm("mul.f32 %0, %1, %2;" : "=f"(f385) : "f"(f50), "f"(f67));
  // PTX:405 mul.f32 %f386, %f52, %f63
  asm("mul.f32 %0, %1, %2;" : "=f"(f386) : "f"(f52), "f"(f63));
  // PTX:406 sub.f32 %f73, %f386, %f385
  asm("sub.f32 %0, %1, %2;" : "=f"(f73) : "f"(f386), "f"(f385));
  // PTX:407 mul.f32 %f387, %f51, %f63
  asm("mul.f32 %0, %1, %2;" : "=f"(f387) : "f"(f51), "f"(f63));
  // PTX:408 mul.f32 %f388, %f50, %f65
  asm("mul.f32 %0, %1, %2;" : "=f"(f388) : "f"(f50), "f"(f65));
  // PTX:409 sub.f32 %f74, %f388, %f387
  asm("sub.f32 %0, %1, %2;" : "=f"(f74) : "f"(f388), "f"(f387));
  // PTX:410 mul.f32 %f389, %f52, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f389) : "f"(f52), "f"(f66));
  // PTX:411 mul.f32 %f390, %f51, %f64
  asm("mul.f32 %0, %1, %2;" : "=f"(f390) : "f"(f51), "f"(f64));
  // PTX:412 sub.f32 %f75, %f390, %f389
  asm("sub.f32 %0, %1, %2;" : "=f"(f75) : "f"(f390), "f"(f389));
  // PTX:413 mul.f32 %f391, %f50, %f64
  asm("mul.f32 %0, %1, %2;" : "=f"(f391) : "f"(f50), "f"(f64));
  // PTX:414 mul.f32 %f392, %f52, %f68
  asm("mul.f32 %0, %1, %2;" : "=f"(f392) : "f"(f52), "f"(f68));
  // PTX:415 sub.f32 %f76, %f392, %f391
  asm("sub.f32 %0, %1, %2;" : "=f"(f76) : "f"(f392), "f"(f391));
  // PTX:416 mul.f32 %f393, %f51, %f68
  asm("mul.f32 %0, %1, %2;" : "=f"(f393) : "f"(f51), "f"(f68));
  // PTX:417 mul.f32 %f394, %f50, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f394) : "f"(f50), "f"(f66));
  // PTX:418 sub.f32 %f77, %f394, %f393
  asm("sub.f32 %0, %1, %2;" : "=f"(f77) : "f"(f394), "f"(f393));
  // PTX:419 abs.f32 %f78, %f70
  asm("abs.f32 %0, %1;" : "=f"(f78) : "f"(f70));
  // PTX:420 setp.eq.f32 %p16, %f78, 0f00000000
  p16 = (!(isnan(((float)(f78))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f78)) == ((float)(as_f32(0x00000000u)))));
  // PTX:421 abs.f32 %f79, %f69
  asm("abs.f32 %0, %1;" : "=f"(f79) : "f"(f69));
  // PTX:422 setp.eq.f32 %p17, %f79, 0f00000000
  p17 = (!(isnan(((float)(f79))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f79)) == ((float)(as_f32(0x00000000u)))));
  // PTX:423 and.pred %p18, %p16, %p17
  p18 = ((p16) && (p17));
  // PTX:424 @%p18 bra $L__BB69_22
  if (p18) { goto L_BB69_22; }
  // PTX:425 bra.uni $L__BB69_19
  goto L_BB69_19;
  // PTX:427 $L__BB69_22:
L_BB69_22:;
  // PTX:428 mov.b32 %r56, %f70
  asm("mov.b32 %0, %1;" : "=r"(r56) : "f"(f70));
  // PTX:429 shr.s32 %r57, %r56, 31
  asm("shr.s32 %0, %1, 31;" : "=r"(r57) : "r"(r56));
  // PTX:430 and.b32 %r58, %r57, 1078530011
  asm("and.b32 %0, %1, 1078530011;" : "=r"(r58) : "r"(r57));
  // PTX:431 mov.b32 %r59, %f69
  asm("mov.b32 %0, %1;" : "=r"(r59) : "f"(f69));
  // PTX:432 and.b32 %r60, %r59, -2147483648
  asm("and.b32 %0, %1, -2147483648;" : "=r"(r60) : "r"(r59));
  // PTX:433 or.b32 %r61, %r60, %r58
  asm("or.b32 %0, %1, %2;" : "=r"(r61) : "r"(r60), "r"(r58));
  // PTX:434 mov.b32 %f1036, %r61
  asm("mov.b32 %0, %1;" : "=f"(f1036) : "r"(r61));
  // PTX:435 bra.uni $L__BB69_23
  goto L_BB69_23;
  // PTX:437 $L__BB69_25:
L_BB69_25:;
  // PTX:438 sub.f32 %f117, %f1001, %f1004
  asm("sub.f32 %0, %1, %2;" : "=f"(f117) : "f"(f1001), "f"(f1004));
  // PTX:439 sub.f32 %f118, %f1002, %f1005
  asm("sub.f32 %0, %1, %2;" : "=f"(f118) : "f"(f1002), "f"(f1005));
  // PTX:440 mul.f32 %f496, %f118, %f118
  asm("mul.f32 %0, %1, %2;" : "=f"(f496) : "f"(f118), "f"(f118));
  // PTX:441 sub.f32 %f119, %f1003, %f1006
  asm("sub.f32 %0, %1, %2;" : "=f"(f119) : "f"(f1003), "f"(f1006));
  // PTX:442 fma.rn.f32 %f497, %f117, %f117, %f496
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f497) : "f"(f117), "f"(f117), "f"(f496));
  // PTX:443 fma.rn.f32 %f498, %f119, %f119, %f497
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f498) : "f"(f119), "f"(f119), "f"(f497));
  // PTX:444 sqrt.rn.f32 %f120, %f498
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f120) : "f"(f498));
  // PTX:445 setp.le.f32 %p27, %f120, 0f322BCC77
  p27 = (!(isnan(((float)(f120))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f120)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:446 @%p27 bra $L__BB69_74
  if (p27) { goto L_BB69_74; }
  // PTX:448 cvt.u32.u64 %r63, %rd14
  asm("cvt.u32.u64 %0, %1;" : "=r"(r63) : "l"(rd14));
  // PTX:449 setp.lt.s32 %p28, %r63, 0
  p28 = (((int)(r63)) < ((int)(0)));
  // PTX:450 sub.f32 %f500, %f36, %f1004
  asm("sub.f32 %0, %1, %2;" : "=f"(f500) : "f"(f36), "f"(f1004));
  // PTX:451 div.rn.f32 %f121, %f117, %f120
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f121) : "f"(f117), "f"(f120));
  // PTX:452 sub.f32 %f501, %f37, %f1005
  asm("sub.f32 %0, %1, %2;" : "=f"(f501) : "f"(f37), "f"(f1005));
  // PTX:453 div.rn.f32 %f122, %f118, %f120
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f122) : "f"(f118), "f"(f120));
  // PTX:454 mul.f32 %f502, %f501, %f122
  asm("mul.f32 %0, %1, %2;" : "=f"(f502) : "f"(f501), "f"(f122));
  // PTX:455 sub.f32 %f503, %f38, %f1006
  asm("sub.f32 %0, %1, %2;" : "=f"(f503) : "f"(f38), "f"(f1006));
  // PTX:456 div.rn.f32 %f123, %f119, %f120
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f123) : "f"(f119), "f"(f120));
  // PTX:457 fma.rn.f32 %f504, %f500, %f121, %f502
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f504) : "f"(f500), "f"(f121), "f"(f502));
  // PTX:458 fma.rn.f32 %f1036, %f503, %f123, %f504
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1036) : "f"(f503), "f"(f123), "f"(f504));
  // PTX:459 mul.f32 %f505, %f121, %f1036
  asm("mul.f32 %0, %1, %2;" : "=f"(f505) : "f"(f121), "f"(f1036));
  // PTX:460 mul.f32 %f506, %f122, %f1036
  asm("mul.f32 %0, %1, %2;" : "=f"(f506) : "f"(f122), "f"(f1036));
  // PTX:461 mul.f32 %f507, %f123, %f1036
  asm("mul.f32 %0, %1, %2;" : "=f"(f507) : "f"(f123), "f"(f1036));
  // PTX:462 sub.f32 %f508, %f500, %f505
  asm("sub.f32 %0, %1, %2;" : "=f"(f508) : "f"(f500), "f"(f505));
  // PTX:463 sub.f32 %f509, %f501, %f506
  asm("sub.f32 %0, %1, %2;" : "=f"(f509) : "f"(f501), "f"(f506));
  // PTX:464 sub.f32 %f510, %f503, %f507
  asm("sub.f32 %0, %1, %2;" : "=f"(f510) : "f"(f503), "f"(f507));
  // PTX:465 div.rn.f32 %f125, %f508, %f120
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f125) : "f"(f508), "f"(f120));
  // PTX:466 div.rn.f32 %f126, %f509, %f120
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f126) : "f"(f509), "f"(f120));
  // PTX:467 div.rn.f32 %f127, %f510, %f120
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f127) : "f"(f510), "f"(f120));
  // PTX:468 @%p28 bra $L__BB69_28
  if (p28) { goto L_BB69_28; }
  // PTX:470 add.f32 %f991, %f123, %f127
  asm("add.f32 %0, %1, %2;" : "=f"(f991) : "f"(f123), "f"(f127));
  // PTX:471 add.f32 %f990, %f122, %f126
  asm("add.f32 %0, %1, %2;" : "=f"(f990) : "f"(f122), "f"(f126));
  // PTX:472 add.f32 %f989, %f121, %f125
  asm("add.f32 %0, %1, %2;" : "=f"(f989) : "f"(f121), "f"(f125));
  // PTX:473 ld.global.f32 %f511, [%rd16]
  f511 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:474 mul.f32 %f512, %f989, %f511
  asm("mul.f32 %0, %1, %2;" : "=f"(f512) : "f"(f989), "f"(f511));
  // PTX:475 mul.f32 %f513, %f990, %f511
  asm("mul.f32 %0, %1, %2;" : "=f"(f513) : "f"(f990), "f"(f511));
  // PTX:476 mul.f32 %f514, %f991, %f511
  asm("mul.f32 %0, %1, %2;" : "=f"(f514) : "f"(f991), "f"(f511));
  // PTX:477 ld.global.f32 %f515, [%rd17]
  f515 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:478 mul.f32 %f516, %f125, %f515
  asm("mul.f32 %0, %1, %2;" : "=f"(f516) : "f"(f125), "f"(f515));
  // PTX:479 mul.f32 %f517, %f126, %f515
  asm("mul.f32 %0, %1, %2;" : "=f"(f517) : "f"(f126), "f"(f515));
  // PTX:480 mul.f32 %f518, %f127, %f515
  asm("mul.f32 %0, %1, %2;" : "=f"(f518) : "f"(f127), "f"(f515));
  // PTX:481 sub.f32 %f1019, %f516, %f512
  asm("sub.f32 %0, %1, %2;" : "=f"(f1019) : "f"(f516), "f"(f512));
  // PTX:482 sub.f32 %f1018, %f517, %f513
  asm("sub.f32 %0, %1, %2;" : "=f"(f1018) : "f"(f517), "f"(f513));
  // PTX:483 sub.f32 %f1017, %f518, %f514
  asm("sub.f32 %0, %1, %2;" : "=f"(f1017) : "f"(f518), "f"(f514));
  // PTX:485 $L__BB69_28:
L_BB69_28:;
  // PTX:486 @%p28 bra $L__BB69_30
  if (p28) { goto L_BB69_30; }
  // PTX:488 add.f32 %f994, %f123, %f127
  asm("add.f32 %0, %1, %2;" : "=f"(f994) : "f"(f123), "f"(f127));
  // PTX:489 add.f32 %f993, %f122, %f126
  asm("add.f32 %0, %1, %2;" : "=f"(f993) : "f"(f122), "f"(f126));
  // PTX:490 add.f32 %f992, %f121, %f125
  asm("add.f32 %0, %1, %2;" : "=f"(f992) : "f"(f121), "f"(f125));
  // PTX:491 ld.global.f32 %f520, [%rd16+4]
  f520 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (4)))));
  // PTX:492 mul.f32 %f521, %f992, %f520
  asm("mul.f32 %0, %1, %2;" : "=f"(f521) : "f"(f992), "f"(f520));
  // PTX:493 mul.f32 %f522, %f993, %f520
  asm("mul.f32 %0, %1, %2;" : "=f"(f522) : "f"(f993), "f"(f520));
  // PTX:494 mul.f32 %f523, %f994, %f520
  asm("mul.f32 %0, %1, %2;" : "=f"(f523) : "f"(f994), "f"(f520));
  // PTX:495 ld.global.f32 %f524, [%rd17+4]
  f524 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (4)))));
  // PTX:496 mul.f32 %f525, %f125, %f524
  asm("mul.f32 %0, %1, %2;" : "=f"(f525) : "f"(f125), "f"(f524));
  // PTX:497 mul.f32 %f526, %f126, %f524
  asm("mul.f32 %0, %1, %2;" : "=f"(f526) : "f"(f126), "f"(f524));
  // PTX:498 mul.f32 %f527, %f127, %f524
  asm("mul.f32 %0, %1, %2;" : "=f"(f527) : "f"(f127), "f"(f524));
  // PTX:499 sub.f32 %f1032, %f525, %f521
  asm("sub.f32 %0, %1, %2;" : "=f"(f1032) : "f"(f525), "f"(f521));
  // PTX:500 sub.f32 %f1033, %f526, %f522
  asm("sub.f32 %0, %1, %2;" : "=f"(f1033) : "f"(f526), "f"(f522));
  // PTX:501 sub.f32 %f1034, %f527, %f523
  asm("sub.f32 %0, %1, %2;" : "=f"(f1034) : "f"(f527), "f"(f523));
  // PTX:503 $L__BB69_30:
L_BB69_30:;
  // PTX:504 @%p28 bra $L__BB69_32
  if (p28) { goto L_BB69_32; }
  // PTX:506 add.f32 %f997, %f123, %f127
  asm("add.f32 %0, %1, %2;" : "=f"(f997) : "f"(f123), "f"(f127));
  // PTX:507 add.f32 %f996, %f122, %f126
  asm("add.f32 %0, %1, %2;" : "=f"(f996) : "f"(f122), "f"(f126));
  // PTX:508 add.f32 %f995, %f121, %f125
  asm("add.f32 %0, %1, %2;" : "=f"(f995) : "f"(f121), "f"(f125));
  // PTX:509 ld.global.f32 %f529, [%rd16+8]
  f529 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (8)))));
  // PTX:510 mul.f32 %f530, %f995, %f529
  asm("mul.f32 %0, %1, %2;" : "=f"(f530) : "f"(f995), "f"(f529));
  // PTX:511 mul.f32 %f531, %f996, %f529
  asm("mul.f32 %0, %1, %2;" : "=f"(f531) : "f"(f996), "f"(f529));
  // PTX:512 mul.f32 %f532, %f997, %f529
  asm("mul.f32 %0, %1, %2;" : "=f"(f532) : "f"(f997), "f"(f529));
  // PTX:513 ld.global.f32 %f533, [%rd17+8]
  f533 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (8)))));
  // PTX:514 mul.f32 %f534, %f125, %f533
  asm("mul.f32 %0, %1, %2;" : "=f"(f534) : "f"(f125), "f"(f533));
  // PTX:515 mul.f32 %f535, %f126, %f533
  asm("mul.f32 %0, %1, %2;" : "=f"(f535) : "f"(f126), "f"(f533));
  // PTX:516 mul.f32 %f536, %f127, %f533
  asm("mul.f32 %0, %1, %2;" : "=f"(f536) : "f"(f127), "f"(f533));
  // PTX:517 sub.f32 %f1035, %f534, %f530
  asm("sub.f32 %0, %1, %2;" : "=f"(f1035) : "f"(f534), "f"(f530));
  // PTX:518 sub.f32 %f1037, %f535, %f531
  asm("sub.f32 %0, %1, %2;" : "=f"(f1037) : "f"(f535), "f"(f531));
  // PTX:519 sub.f32 %f1038, %f536, %f532
  asm("sub.f32 %0, %1, %2;" : "=f"(f1038) : "f"(f536), "f"(f532));
  // PTX:521 $L__BB69_32:
L_BB69_32:;
  // PTX:522 mul.f32 %f1031, %f121, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f1031) : "f"(f121), "f"(f21));
  // PTX:523 mul.f32 %f1030, %f122, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f1030) : "f"(f122), "f"(f21));
  // PTX:524 mul.f32 %f1029, %f123, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f1029) : "f"(f123), "f"(f21));
  // PTX:525 mul.f32 %f1028, %f121, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f1028) : "f"(f121), "f"(f25));
  // PTX:526 mul.f32 %f1027, %f122, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f1027) : "f"(f122), "f"(f25));
  // PTX:527 mul.f32 %f1026, %f123, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f1026) : "f"(f123), "f"(f25));
  // PTX:528 mul.f32 %f1025, %f121, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f1025) : "f"(f121), "f"(f29));
  // PTX:529 mul.f32 %f1024, %f122, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f1024) : "f"(f122), "f"(f29));
  // PTX:530 mul.f32 %f1023, %f123, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f1023) : "f"(f123), "f"(f29));
  // PTX:531 mul.f32 %f1022, %f121, %f33
  asm("mul.f32 %0, %1, %2;" : "=f"(f1022) : "f"(f121), "f"(f33));
  // PTX:532 mul.f32 %f1021, %f122, %f33
  asm("mul.f32 %0, %1, %2;" : "=f"(f1021) : "f"(f122), "f"(f33));
  // PTX:533 mul.f32 %f1020, %f123, %f33
  asm("mul.f32 %0, %1, %2;" : "=f"(f1020) : "f"(f123), "f"(f33));
  // PTX:534 @%p28 bra $L__BB69_34
  if (p28) { goto L_BB69_34; }
  // PTX:536 shl.b64 %rd313, %rd10, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd313) : "l"(rd10));
  // PTX:537 ld.param.u64 %rd312, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_0+64]
  rd312 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (64))));
  // PTX:538 cvta.to.global.u64 %rd311, %rd312
  rd311 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd312));
  // PTX:539 add.s64 %rd310, %rd311, %rd313
  asm("add.s64 %0, %1, %2;" : "=l"(rd310) : "l"(rd311), "l"(rd313));
  // PTX:540 ld.param.u64 %rd309, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_0+48]
  rd309 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (48))));
  // PTX:541 cvta.to.global.u64 %rd308, %rd309
  rd308 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd309));
  // PTX:542 add.s64 %rd307, %rd308, %rd313
  asm("add.s64 %0, %1, %2;" : "=l"(rd307) : "l"(rd308), "l"(rd313));
  // PTX:543 add.f32 %f1000, %f123, %f127
  asm("add.f32 %0, %1, %2;" : "=f"(f1000) : "f"(f123), "f"(f127));
  // PTX:544 add.f32 %f999, %f122, %f126
  asm("add.f32 %0, %1, %2;" : "=f"(f999) : "f"(f122), "f"(f126));
  // PTX:545 add.f32 %f998, %f121, %f125
  asm("add.f32 %0, %1, %2;" : "=f"(f998) : "f"(f121), "f"(f125));
  // PTX:546 ld.global.f32 %f538, [%rd307+12]
  f538 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd307) + (12)))));
  // PTX:547 mul.f32 %f539, %f998, %f538
  asm("mul.f32 %0, %1, %2;" : "=f"(f539) : "f"(f998), "f"(f538));
  // PTX:548 mul.f32 %f540, %f999, %f538
  asm("mul.f32 %0, %1, %2;" : "=f"(f540) : "f"(f999), "f"(f538));
  // PTX:549 mul.f32 %f541, %f1000, %f538
  asm("mul.f32 %0, %1, %2;" : "=f"(f541) : "f"(f1000), "f"(f538));
  // PTX:550 ld.global.f32 %f542, [%rd310+12]
  f542 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd310) + (12)))));
  // PTX:551 mul.f32 %f543, %f125, %f542
  asm("mul.f32 %0, %1, %2;" : "=f"(f543) : "f"(f125), "f"(f542));
  // PTX:552 mul.f32 %f544, %f126, %f542
  asm("mul.f32 %0, %1, %2;" : "=f"(f544) : "f"(f126), "f"(f542));
  // PTX:553 mul.f32 %f545, %f127, %f542
  asm("mul.f32 %0, %1, %2;" : "=f"(f545) : "f"(f127), "f"(f542));
  // PTX:554 sub.f32 %f1039, %f543, %f539
  asm("sub.f32 %0, %1, %2;" : "=f"(f1039) : "f"(f543), "f"(f539));
  // PTX:555 sub.f32 %f1040, %f544, %f540
  asm("sub.f32 %0, %1, %2;" : "=f"(f1040) : "f"(f544), "f"(f540));
  // PTX:556 sub.f32 %f1041, %f545, %f541
  asm("sub.f32 %0, %1, %2;" : "=f"(f1041) : "f"(f545), "f"(f541));
  // PTX:558 $L__BB69_34:
L_BB69_34:;
  // PTX:559 ld.param.u64 %rd267, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_8]
  rd267 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:560 ld.param.f32 %f987, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_5]
  f987 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param5 + (0))));
  // PTX:561 mul.f32 %f546, %f1, %f987
  asm("mul.f32 %0, %1, %2;" : "=f"(f546) : "f"(f1), "f"(f987));
  // PTX:562 mul.f32 %f189, %f546, %f987
  asm("mul.f32 %0, %1, %2;" : "=f"(f189) : "f"(f546), "f"(f987));
  // PTX:563 setp.eq.s64 %p32, %rd267, 0
  p32 = (((long long)(rd267)) == ((long long)(0)));
  // PTX:564 @%p32 bra $L__BB69_43
  if (p32) { goto L_BB69_43; }
  // PTX:566 cvt.u32.u64 %r67, %rd14
  asm("cvt.u32.u64 %0, %1;" : "=r"(r67) : "l"(rd14));
  // PTX:567 setp.lt.s32 %p33, %r67, 0
  p33 = (((int)(r67)) < ((int)(0)));
  // PTX:568 mul.f32 %f547, %f1031, %f1031
  asm("mul.f32 %0, %1, %2;" : "=f"(f547) : "f"(f1031), "f"(f1031));
  // PTX:569 mul.f32 %f548, %f189, %f547
  asm("mul.f32 %0, %1, %2;" : "=f"(f548) : "f"(f189), "f"(f547));
  // PTX:570 mul.f32 %f549, %f1030, %f1031
  asm("mul.f32 %0, %1, %2;" : "=f"(f549) : "f"(f1030), "f"(f1031));
  // PTX:571 mul.f32 %f550, %f189, %f549
  asm("mul.f32 %0, %1, %2;" : "=f"(f550) : "f"(f189), "f"(f549));
  // PTX:572 mul.f32 %f551, %f1029, %f1031
  asm("mul.f32 %0, %1, %2;" : "=f"(f551) : "f"(f1029), "f"(f1031));
  // PTX:573 mul.f32 %f552, %f189, %f551
  asm("mul.f32 %0, %1, %2;" : "=f"(f552) : "f"(f189), "f"(f551));
  // PTX:574 mul.f32 %f553, %f1030, %f1030
  asm("mul.f32 %0, %1, %2;" : "=f"(f553) : "f"(f1030), "f"(f1030));
  // PTX:575 mul.f32 %f554, %f189, %f553
  asm("mul.f32 %0, %1, %2;" : "=f"(f554) : "f"(f189), "f"(f553));
  // PTX:576 mul.f32 %f555, %f1029, %f1030
  asm("mul.f32 %0, %1, %2;" : "=f"(f555) : "f"(f1029), "f"(f1030));
  // PTX:577 mul.f32 %f556, %f189, %f555
  asm("mul.f32 %0, %1, %2;" : "=f"(f556) : "f"(f189), "f"(f555));
  // PTX:578 mul.f32 %f557, %f1029, %f1029
  asm("mul.f32 %0, %1, %2;" : "=f"(f557) : "f"(f1029), "f"(f1029));
  // PTX:579 mul.f32 %f558, %f189, %f557
  asm("mul.f32 %0, %1, %2;" : "=f"(f558) : "f"(f189), "f"(f557));
  // PTX:580 mul.lo.s64 %rd112, %rd27, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd112) : "l"(rd27));
  // PTX:581 add.s64 %rd113, %rd1, %rd112
  asm("add.s64 %0, %1, %2;" : "=l"(rd113) : "l"(rd1), "l"(rd112));
  // PTX:582 red.global.add.f32 [%rd113], %f548
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd113) + (0)))), (float)(f548));
  // PTX:583 add.s64 %rd114, %rd113, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd114) : "l"(rd113));
  // PTX:584 red.global.add.f32 [%rd114], %f550
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd114) + (0)))), (float)(f550));
  // PTX:585 add.s64 %rd115, %rd113, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd115) : "l"(rd113));
  // PTX:586 red.global.add.f32 [%rd115], %f552
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd115) + (0)))), (float)(f552));
  // PTX:587 add.s64 %rd116, %rd113, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd116) : "l"(rd113));
  // PTX:588 red.global.add.f32 [%rd116], %f550
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd116) + (0)))), (float)(f550));
  // PTX:589 add.s64 %rd117, %rd113, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd117) : "l"(rd113));
  // PTX:590 red.global.add.f32 [%rd117], %f554
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd117) + (0)))), (float)(f554));
  // PTX:591 add.s64 %rd118, %rd113, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd118) : "l"(rd113));
  // PTX:592 red.global.add.f32 [%rd118], %f556
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd118) + (0)))), (float)(f556));
  // PTX:593 add.s64 %rd119, %rd113, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd119) : "l"(rd113));
  // PTX:594 red.global.add.f32 [%rd119], %f552
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd119) + (0)))), (float)(f552));
  // PTX:595 add.s64 %rd120, %rd113, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd120) : "l"(rd113));
  // PTX:596 red.global.add.f32 [%rd120], %f556
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd120) + (0)))), (float)(f556));
  // PTX:597 add.s64 %rd121, %rd113, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd121) : "l"(rd113));
  // PTX:598 red.global.add.f32 [%rd121], %f558
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd121) + (0)))), (float)(f558));
  // PTX:599 @%p33 bra $L__BB69_37
  if (p33) { goto L_BB69_37; }
  // PTX:601 mul.f32 %f568, %f1019, %f1019
  asm("mul.f32 %0, %1, %2;" : "=f"(f568) : "f"(f1019), "f"(f1019));
  // PTX:602 mul.f32 %f569, %f189, %f568
  asm("mul.f32 %0, %1, %2;" : "=f"(f569) : "f"(f189), "f"(f568));
  // PTX:603 mul.f32 %f570, %f1018, %f1019
  asm("mul.f32 %0, %1, %2;" : "=f"(f570) : "f"(f1018), "f"(f1019));
  // PTX:604 mul.f32 %f571, %f189, %f570
  asm("mul.f32 %0, %1, %2;" : "=f"(f571) : "f"(f189), "f"(f570));
  // PTX:605 mul.f32 %f572, %f1017, %f1019
  asm("mul.f32 %0, %1, %2;" : "=f"(f572) : "f"(f1017), "f"(f1019));
  // PTX:606 mul.f32 %f573, %f189, %f572
  asm("mul.f32 %0, %1, %2;" : "=f"(f573) : "f"(f189), "f"(f572));
  // PTX:607 mul.f32 %f574, %f1018, %f1018
  asm("mul.f32 %0, %1, %2;" : "=f"(f574) : "f"(f1018), "f"(f1018));
  // PTX:608 mul.f32 %f575, %f189, %f574
  asm("mul.f32 %0, %1, %2;" : "=f"(f575) : "f"(f189), "f"(f574));
  // PTX:609 mul.f32 %f576, %f1017, %f1018
  asm("mul.f32 %0, %1, %2;" : "=f"(f576) : "f"(f1017), "f"(f1018));
  // PTX:610 mul.f32 %f577, %f189, %f576
  asm("mul.f32 %0, %1, %2;" : "=f"(f577) : "f"(f189), "f"(f576));
  // PTX:611 mul.f32 %f578, %f1017, %f1017
  asm("mul.f32 %0, %1, %2;" : "=f"(f578) : "f"(f1017), "f"(f1017));
  // PTX:612 mul.f32 %f579, %f189, %f578
  asm("mul.f32 %0, %1, %2;" : "=f"(f579) : "f"(f189), "f"(f578));
  // PTX:613 mul.lo.s64 %rd122, %rd322, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd122) : "l"(rd322));
  // PTX:614 add.s64 %rd123, %rd1, %rd122
  asm("add.s64 %0, %1, %2;" : "=l"(rd123) : "l"(rd1), "l"(rd122));
  // PTX:615 red.global.add.f32 [%rd123], %f569
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd123) + (0)))), (float)(f569));
  // PTX:616 add.s64 %rd124, %rd123, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd124) : "l"(rd123));
  // PTX:617 red.global.add.f32 [%rd124], %f571
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd124) + (0)))), (float)(f571));
  // PTX:618 add.s64 %rd125, %rd123, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd125) : "l"(rd123));
  // PTX:619 red.global.add.f32 [%rd125], %f573
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd125) + (0)))), (float)(f573));
  // PTX:620 add.s64 %rd126, %rd123, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd126) : "l"(rd123));
  // PTX:621 red.global.add.f32 [%rd126], %f571
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd126) + (0)))), (float)(f571));
  // PTX:622 add.s64 %rd127, %rd123, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd127) : "l"(rd123));
  // PTX:623 red.global.add.f32 [%rd127], %f575
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd127) + (0)))), (float)(f575));
  // PTX:624 add.s64 %rd128, %rd123, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd128) : "l"(rd123));
  // PTX:625 red.global.add.f32 [%rd128], %f577
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd128) + (0)))), (float)(f577));
  // PTX:626 add.s64 %rd129, %rd123, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd129) : "l"(rd123));
  // PTX:627 red.global.add.f32 [%rd129], %f573
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd129) + (0)))), (float)(f573));
  // PTX:628 add.s64 %rd130, %rd123, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd130) : "l"(rd123));
  // PTX:629 red.global.add.f32 [%rd130], %f577
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd130) + (0)))), (float)(f577));
  // PTX:630 add.s64 %rd131, %rd123, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd131) : "l"(rd123));
  // PTX:631 red.global.add.f32 [%rd131], %f579
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd131) + (0)))), (float)(f579));
  // PTX:633 $L__BB69_37:
L_BB69_37:;
  // PTX:634 mul.f32 %f589, %f1028, %f1028
  asm("mul.f32 %0, %1, %2;" : "=f"(f589) : "f"(f1028), "f"(f1028));
  // PTX:635 mul.f32 %f590, %f189, %f589
  asm("mul.f32 %0, %1, %2;" : "=f"(f590) : "f"(f189), "f"(f589));
  // PTX:636 mul.f32 %f591, %f1027, %f1028
  asm("mul.f32 %0, %1, %2;" : "=f"(f591) : "f"(f1027), "f"(f1028));
  // PTX:637 mul.f32 %f592, %f189, %f591
  asm("mul.f32 %0, %1, %2;" : "=f"(f592) : "f"(f189), "f"(f591));
  // PTX:638 mul.f32 %f593, %f1026, %f1028
  asm("mul.f32 %0, %1, %2;" : "=f"(f593) : "f"(f1026), "f"(f1028));
  // PTX:639 mul.f32 %f594, %f189, %f593
  asm("mul.f32 %0, %1, %2;" : "=f"(f594) : "f"(f189), "f"(f593));
  // PTX:640 mul.f32 %f595, %f1027, %f1027
  asm("mul.f32 %0, %1, %2;" : "=f"(f595) : "f"(f1027), "f"(f1027));
  // PTX:641 mul.f32 %f596, %f189, %f595
  asm("mul.f32 %0, %1, %2;" : "=f"(f596) : "f"(f189), "f"(f595));
  // PTX:642 mul.f32 %f597, %f1026, %f1027
  asm("mul.f32 %0, %1, %2;" : "=f"(f597) : "f"(f1026), "f"(f1027));
  // PTX:643 mul.f32 %f598, %f189, %f597
  asm("mul.f32 %0, %1, %2;" : "=f"(f598) : "f"(f189), "f"(f597));
  // PTX:644 mul.f32 %f599, %f1026, %f1026
  asm("mul.f32 %0, %1, %2;" : "=f"(f599) : "f"(f1026), "f"(f1026));
  // PTX:645 mul.f32 %f600, %f189, %f599
  asm("mul.f32 %0, %1, %2;" : "=f"(f600) : "f"(f189), "f"(f599));
  // PTX:646 mul.lo.s64 %rd132, %rd28, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd132) : "l"(rd28));
  // PTX:647 add.s64 %rd133, %rd1, %rd132
  asm("add.s64 %0, %1, %2;" : "=l"(rd133) : "l"(rd1), "l"(rd132));
  // PTX:648 red.global.add.f32 [%rd133], %f590
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd133) + (0)))), (float)(f590));
  // PTX:649 add.s64 %rd134, %rd133, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd134) : "l"(rd133));
  // PTX:650 red.global.add.f32 [%rd134], %f592
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd134) + (0)))), (float)(f592));
  // PTX:651 add.s64 %rd135, %rd133, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd135) : "l"(rd133));
  // PTX:652 red.global.add.f32 [%rd135], %f594
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd135) + (0)))), (float)(f594));
  // PTX:653 add.s64 %rd136, %rd133, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd136) : "l"(rd133));
  // PTX:654 red.global.add.f32 [%rd136], %f592
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd136) + (0)))), (float)(f592));
  // PTX:655 add.s64 %rd137, %rd133, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd137) : "l"(rd133));
  // PTX:656 red.global.add.f32 [%rd137], %f596
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd137) + (0)))), (float)(f596));
  // PTX:657 add.s64 %rd138, %rd133, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd138) : "l"(rd133));
  // PTX:658 red.global.add.f32 [%rd138], %f598
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd138) + (0)))), (float)(f598));
  // PTX:659 add.s64 %rd139, %rd133, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd139) : "l"(rd133));
  // PTX:660 red.global.add.f32 [%rd139], %f594
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd139) + (0)))), (float)(f594));
  // PTX:661 add.s64 %rd140, %rd133, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd140) : "l"(rd133));
  // PTX:662 red.global.add.f32 [%rd140], %f598
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd140) + (0)))), (float)(f598));
  // PTX:663 add.s64 %rd141, %rd133, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd141) : "l"(rd133));
  // PTX:664 red.global.add.f32 [%rd141], %f600
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd141) + (0)))), (float)(f600));
  // PTX:665 @%p33 bra $L__BB69_39
  if (p33) { goto L_BB69_39; }
  // PTX:667 mul.f32 %f610, %f1032, %f1032
  asm("mul.f32 %0, %1, %2;" : "=f"(f610) : "f"(f1032), "f"(f1032));
  // PTX:668 mul.f32 %f611, %f189, %f610
  asm("mul.f32 %0, %1, %2;" : "=f"(f611) : "f"(f189), "f"(f610));
  // PTX:669 mul.f32 %f612, %f1033, %f1032
  asm("mul.f32 %0, %1, %2;" : "=f"(f612) : "f"(f1033), "f"(f1032));
  // PTX:670 mul.f32 %f613, %f189, %f612
  asm("mul.f32 %0, %1, %2;" : "=f"(f613) : "f"(f189), "f"(f612));
  // PTX:671 mul.f32 %f614, %f1034, %f1032
  asm("mul.f32 %0, %1, %2;" : "=f"(f614) : "f"(f1034), "f"(f1032));
  // PTX:672 mul.f32 %f615, %f189, %f614
  asm("mul.f32 %0, %1, %2;" : "=f"(f615) : "f"(f189), "f"(f614));
  // PTX:673 mul.f32 %f616, %f1033, %f1033
  asm("mul.f32 %0, %1, %2;" : "=f"(f616) : "f"(f1033), "f"(f1033));
  // PTX:674 mul.f32 %f617, %f189, %f616
  asm("mul.f32 %0, %1, %2;" : "=f"(f617) : "f"(f189), "f"(f616));
  // PTX:675 mul.f32 %f618, %f1034, %f1033
  asm("mul.f32 %0, %1, %2;" : "=f"(f618) : "f"(f1034), "f"(f1033));
  // PTX:676 mul.f32 %f619, %f189, %f618
  asm("mul.f32 %0, %1, %2;" : "=f"(f619) : "f"(f189), "f"(f618));
  // PTX:677 mul.f32 %f620, %f1034, %f1034
  asm("mul.f32 %0, %1, %2;" : "=f"(f620) : "f"(f1034), "f"(f1034));
  // PTX:678 mul.f32 %f621, %f189, %f620
  asm("mul.f32 %0, %1, %2;" : "=f"(f621) : "f"(f189), "f"(f620));
  // PTX:679 mul.lo.s64 %rd142, %rd321, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd142) : "l"(rd321));
  // PTX:680 add.s64 %rd143, %rd1, %rd142
  asm("add.s64 %0, %1, %2;" : "=l"(rd143) : "l"(rd1), "l"(rd142));
  // PTX:681 red.global.add.f32 [%rd143], %f611
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd143) + (0)))), (float)(f611));
  // PTX:682 add.s64 %rd144, %rd143, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd144) : "l"(rd143));
  // PTX:683 red.global.add.f32 [%rd144], %f613
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd144) + (0)))), (float)(f613));
  // PTX:684 add.s64 %rd145, %rd143, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd145) : "l"(rd143));
  // PTX:685 red.global.add.f32 [%rd145], %f615
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd145) + (0)))), (float)(f615));
  // PTX:686 add.s64 %rd146, %rd143, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd146) : "l"(rd143));
  // PTX:687 red.global.add.f32 [%rd146], %f613
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd146) + (0)))), (float)(f613));
  // PTX:688 add.s64 %rd147, %rd143, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd147) : "l"(rd143));
  // PTX:689 red.global.add.f32 [%rd147], %f617
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd147) + (0)))), (float)(f617));
  // PTX:690 add.s64 %rd148, %rd143, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd148) : "l"(rd143));
  // PTX:691 red.global.add.f32 [%rd148], %f619
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd148) + (0)))), (float)(f619));
  // PTX:692 add.s64 %rd149, %rd143, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd149) : "l"(rd143));
  // PTX:693 red.global.add.f32 [%rd149], %f615
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd149) + (0)))), (float)(f615));
  // PTX:694 add.s64 %rd150, %rd143, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd150) : "l"(rd143));
  // PTX:695 red.global.add.f32 [%rd150], %f619
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd150) + (0)))), (float)(f619));
  // PTX:696 add.s64 %rd151, %rd143, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd151) : "l"(rd143));
  // PTX:697 red.global.add.f32 [%rd151], %f621
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd151) + (0)))), (float)(f621));
  // PTX:699 $L__BB69_39:
L_BB69_39:;
  // PTX:700 mul.f32 %f631, %f1025, %f1025
  asm("mul.f32 %0, %1, %2;" : "=f"(f631) : "f"(f1025), "f"(f1025));
  // PTX:701 mul.f32 %f632, %f189, %f631
  asm("mul.f32 %0, %1, %2;" : "=f"(f632) : "f"(f189), "f"(f631));
  // PTX:702 mul.f32 %f633, %f1024, %f1025
  asm("mul.f32 %0, %1, %2;" : "=f"(f633) : "f"(f1024), "f"(f1025));
  // PTX:703 mul.f32 %f634, %f189, %f633
  asm("mul.f32 %0, %1, %2;" : "=f"(f634) : "f"(f189), "f"(f633));
  // PTX:704 mul.f32 %f635, %f1023, %f1025
  asm("mul.f32 %0, %1, %2;" : "=f"(f635) : "f"(f1023), "f"(f1025));
  // PTX:705 mul.f32 %f636, %f189, %f635
  asm("mul.f32 %0, %1, %2;" : "=f"(f636) : "f"(f189), "f"(f635));
  // PTX:706 mul.f32 %f637, %f1024, %f1024
  asm("mul.f32 %0, %1, %2;" : "=f"(f637) : "f"(f1024), "f"(f1024));
  // PTX:707 mul.f32 %f638, %f189, %f637
  asm("mul.f32 %0, %1, %2;" : "=f"(f638) : "f"(f189), "f"(f637));
  // PTX:708 mul.f32 %f639, %f1023, %f1024
  asm("mul.f32 %0, %1, %2;" : "=f"(f639) : "f"(f1023), "f"(f1024));
  // PTX:709 mul.f32 %f640, %f189, %f639
  asm("mul.f32 %0, %1, %2;" : "=f"(f640) : "f"(f189), "f"(f639));
  // PTX:710 mul.f32 %f641, %f1023, %f1023
  asm("mul.f32 %0, %1, %2;" : "=f"(f641) : "f"(f1023), "f"(f1023));
  // PTX:711 mul.f32 %f642, %f189, %f641
  asm("mul.f32 %0, %1, %2;" : "=f"(f642) : "f"(f189), "f"(f641));
  // PTX:712 mul.lo.s64 %rd152, %rd29, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd152) : "l"(rd29));
  // PTX:713 add.s64 %rd153, %rd1, %rd152
  asm("add.s64 %0, %1, %2;" : "=l"(rd153) : "l"(rd1), "l"(rd152));
  // PTX:714 red.global.add.f32 [%rd153], %f632
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd153) + (0)))), (float)(f632));
  // PTX:715 add.s64 %rd154, %rd153, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd154) : "l"(rd153));
  // PTX:716 red.global.add.f32 [%rd154], %f634
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd154) + (0)))), (float)(f634));
  // PTX:717 add.s64 %rd155, %rd153, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd155) : "l"(rd153));
  // PTX:718 red.global.add.f32 [%rd155], %f636
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd155) + (0)))), (float)(f636));
  // PTX:719 add.s64 %rd156, %rd153, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd156) : "l"(rd153));
  // PTX:720 red.global.add.f32 [%rd156], %f634
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd156) + (0)))), (float)(f634));
  // PTX:721 add.s64 %rd157, %rd153, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd157) : "l"(rd153));
  // PTX:722 red.global.add.f32 [%rd157], %f638
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd157) + (0)))), (float)(f638));
  // PTX:723 add.s64 %rd158, %rd153, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd158) : "l"(rd153));
  // PTX:724 red.global.add.f32 [%rd158], %f640
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd158) + (0)))), (float)(f640));
  // PTX:725 add.s64 %rd159, %rd153, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd159) : "l"(rd153));
  // PTX:726 red.global.add.f32 [%rd159], %f636
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd159) + (0)))), (float)(f636));
  // PTX:727 add.s64 %rd160, %rd153, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd160) : "l"(rd153));
  // PTX:728 red.global.add.f32 [%rd160], %f640
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd160) + (0)))), (float)(f640));
  // PTX:729 add.s64 %rd161, %rd153, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd161) : "l"(rd153));
  // PTX:730 red.global.add.f32 [%rd161], %f642
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd161) + (0)))), (float)(f642));
  // PTX:731 @%p33 bra $L__BB69_41
  if (p33) { goto L_BB69_41; }
  // PTX:733 mul.f32 %f652, %f1035, %f1035
  asm("mul.f32 %0, %1, %2;" : "=f"(f652) : "f"(f1035), "f"(f1035));
  // PTX:734 mul.f32 %f653, %f189, %f652
  asm("mul.f32 %0, %1, %2;" : "=f"(f653) : "f"(f189), "f"(f652));
  // PTX:735 mul.f32 %f654, %f1037, %f1035
  asm("mul.f32 %0, %1, %2;" : "=f"(f654) : "f"(f1037), "f"(f1035));
  // PTX:736 mul.f32 %f655, %f189, %f654
  asm("mul.f32 %0, %1, %2;" : "=f"(f655) : "f"(f189), "f"(f654));
  // PTX:737 mul.f32 %f656, %f1038, %f1035
  asm("mul.f32 %0, %1, %2;" : "=f"(f656) : "f"(f1038), "f"(f1035));
  // PTX:738 mul.f32 %f657, %f189, %f656
  asm("mul.f32 %0, %1, %2;" : "=f"(f657) : "f"(f189), "f"(f656));
  // PTX:739 mul.f32 %f658, %f1037, %f1037
  asm("mul.f32 %0, %1, %2;" : "=f"(f658) : "f"(f1037), "f"(f1037));
  // PTX:740 mul.f32 %f659, %f189, %f658
  asm("mul.f32 %0, %1, %2;" : "=f"(f659) : "f"(f189), "f"(f658));
  // PTX:741 mul.f32 %f660, %f1038, %f1037
  asm("mul.f32 %0, %1, %2;" : "=f"(f660) : "f"(f1038), "f"(f1037));
  // PTX:742 mul.f32 %f661, %f189, %f660
  asm("mul.f32 %0, %1, %2;" : "=f"(f661) : "f"(f189), "f"(f660));
  // PTX:743 mul.f32 %f662, %f1038, %f1038
  asm("mul.f32 %0, %1, %2;" : "=f"(f662) : "f"(f1038), "f"(f1038));
  // PTX:744 mul.f32 %f663, %f189, %f662
  asm("mul.f32 %0, %1, %2;" : "=f"(f663) : "f"(f189), "f"(f662));
  // PTX:745 mul.lo.s64 %rd162, %rd320, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd162) : "l"(rd320));
  // PTX:746 add.s64 %rd163, %rd1, %rd162
  asm("add.s64 %0, %1, %2;" : "=l"(rd163) : "l"(rd1), "l"(rd162));
  // PTX:747 red.global.add.f32 [%rd163], %f653
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd163) + (0)))), (float)(f653));
  // PTX:748 add.s64 %rd164, %rd163, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd164) : "l"(rd163));
  // PTX:749 red.global.add.f32 [%rd164], %f655
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd164) + (0)))), (float)(f655));
  // PTX:750 add.s64 %rd165, %rd163, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd165) : "l"(rd163));
  // PTX:751 red.global.add.f32 [%rd165], %f657
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd165) + (0)))), (float)(f657));
  // PTX:752 add.s64 %rd166, %rd163, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd166) : "l"(rd163));
  // PTX:753 red.global.add.f32 [%rd166], %f655
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd166) + (0)))), (float)(f655));
  // PTX:754 add.s64 %rd167, %rd163, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd167) : "l"(rd163));
  // PTX:755 red.global.add.f32 [%rd167], %f659
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd167) + (0)))), (float)(f659));
  // PTX:756 add.s64 %rd168, %rd163, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd168) : "l"(rd163));
  // PTX:757 red.global.add.f32 [%rd168], %f661
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd168) + (0)))), (float)(f661));
  // PTX:758 add.s64 %rd169, %rd163, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd169) : "l"(rd163));
  // PTX:759 red.global.add.f32 [%rd169], %f657
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd169) + (0)))), (float)(f657));
  // PTX:760 add.s64 %rd170, %rd163, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd170) : "l"(rd163));
  // PTX:761 red.global.add.f32 [%rd170], %f661
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd170) + (0)))), (float)(f661));
  // PTX:762 add.s64 %rd171, %rd163, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd171) : "l"(rd163));
  // PTX:763 red.global.add.f32 [%rd171], %f663
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd171) + (0)))), (float)(f663));
  // PTX:765 $L__BB69_41:
L_BB69_41:;
  // PTX:766 mul.f32 %f673, %f1022, %f1022
  asm("mul.f32 %0, %1, %2;" : "=f"(f673) : "f"(f1022), "f"(f1022));
  // PTX:767 mul.f32 %f674, %f189, %f673
  asm("mul.f32 %0, %1, %2;" : "=f"(f674) : "f"(f189), "f"(f673));
  // PTX:768 mul.f32 %f675, %f1021, %f1022
  asm("mul.f32 %0, %1, %2;" : "=f"(f675) : "f"(f1021), "f"(f1022));
  // PTX:769 mul.f32 %f676, %f189, %f675
  asm("mul.f32 %0, %1, %2;" : "=f"(f676) : "f"(f189), "f"(f675));
  // PTX:770 mul.f32 %f677, %f1020, %f1022
  asm("mul.f32 %0, %1, %2;" : "=f"(f677) : "f"(f1020), "f"(f1022));
  // PTX:771 mul.f32 %f678, %f189, %f677
  asm("mul.f32 %0, %1, %2;" : "=f"(f678) : "f"(f189), "f"(f677));
  // PTX:772 mul.f32 %f679, %f1021, %f1021
  asm("mul.f32 %0, %1, %2;" : "=f"(f679) : "f"(f1021), "f"(f1021));
  // PTX:773 mul.f32 %f680, %f189, %f679
  asm("mul.f32 %0, %1, %2;" : "=f"(f680) : "f"(f189), "f"(f679));
  // PTX:774 mul.f32 %f681, %f1020, %f1021
  asm("mul.f32 %0, %1, %2;" : "=f"(f681) : "f"(f1020), "f"(f1021));
  // PTX:775 mul.f32 %f682, %f189, %f681
  asm("mul.f32 %0, %1, %2;" : "=f"(f682) : "f"(f189), "f"(f681));
  // PTX:776 mul.f32 %f683, %f1020, %f1020
  asm("mul.f32 %0, %1, %2;" : "=f"(f683) : "f"(f1020), "f"(f1020));
  // PTX:777 mul.f32 %f684, %f189, %f683
  asm("mul.f32 %0, %1, %2;" : "=f"(f684) : "f"(f189), "f"(f683));
  // PTX:778 mul.lo.s64 %rd172, %rd30, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd172) : "l"(rd30));
  // PTX:779 add.s64 %rd173, %rd1, %rd172
  asm("add.s64 %0, %1, %2;" : "=l"(rd173) : "l"(rd1), "l"(rd172));
  // PTX:780 red.global.add.f32 [%rd173], %f674
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd173) + (0)))), (float)(f674));
  // PTX:781 add.s64 %rd174, %rd173, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd174) : "l"(rd173));
  // PTX:782 red.global.add.f32 [%rd174], %f676
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd174) + (0)))), (float)(f676));
  // PTX:783 add.s64 %rd175, %rd173, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd175) : "l"(rd173));
  // PTX:784 red.global.add.f32 [%rd175], %f678
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd175) + (0)))), (float)(f678));
  // PTX:785 add.s64 %rd176, %rd173, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd176) : "l"(rd173));
  // PTX:786 red.global.add.f32 [%rd176], %f676
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd176) + (0)))), (float)(f676));
  // PTX:787 add.s64 %rd177, %rd173, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd177) : "l"(rd173));
  // PTX:788 red.global.add.f32 [%rd177], %f680
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd177) + (0)))), (float)(f680));
  // PTX:789 add.s64 %rd178, %rd173, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd178) : "l"(rd173));
  // PTX:790 red.global.add.f32 [%rd178], %f682
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd178) + (0)))), (float)(f682));
  // PTX:791 add.s64 %rd179, %rd173, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd179) : "l"(rd173));
  // PTX:792 red.global.add.f32 [%rd179], %f678
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd179) + (0)))), (float)(f678));
  // PTX:793 add.s64 %rd180, %rd173, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd180) : "l"(rd173));
  // PTX:794 red.global.add.f32 [%rd180], %f682
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (0)))), (float)(f682));
  // PTX:795 add.s64 %rd181, %rd173, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd181) : "l"(rd173));
  // PTX:796 red.global.add.f32 [%rd181], %f684
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd181) + (0)))), (float)(f684));
  // PTX:797 @%p33 bra $L__BB69_74
  if (p33) { goto L_BB69_74; }
  // PTX:799 mul.f32 %f694, %f1039, %f1039
  asm("mul.f32 %0, %1, %2;" : "=f"(f694) : "f"(f1039), "f"(f1039));
  // PTX:800 mul.f32 %f695, %f189, %f694
  asm("mul.f32 %0, %1, %2;" : "=f"(f695) : "f"(f189), "f"(f694));
  // PTX:801 mul.f32 %f696, %f1040, %f1039
  asm("mul.f32 %0, %1, %2;" : "=f"(f696) : "f"(f1040), "f"(f1039));
  // PTX:802 mul.f32 %f697, %f189, %f696
  asm("mul.f32 %0, %1, %2;" : "=f"(f697) : "f"(f189), "f"(f696));
  // PTX:803 mul.f32 %f698, %f1041, %f1039
  asm("mul.f32 %0, %1, %2;" : "=f"(f698) : "f"(f1041), "f"(f1039));
  // PTX:804 mul.f32 %f699, %f189, %f698
  asm("mul.f32 %0, %1, %2;" : "=f"(f699) : "f"(f189), "f"(f698));
  // PTX:805 mul.f32 %f700, %f1040, %f1040
  asm("mul.f32 %0, %1, %2;" : "=f"(f700) : "f"(f1040), "f"(f1040));
  // PTX:806 mul.f32 %f701, %f189, %f700
  asm("mul.f32 %0, %1, %2;" : "=f"(f701) : "f"(f189), "f"(f700));
  // PTX:807 mul.f32 %f702, %f1041, %f1040
  asm("mul.f32 %0, %1, %2;" : "=f"(f702) : "f"(f1041), "f"(f1040));
  // PTX:808 mul.f32 %f703, %f189, %f702
  asm("mul.f32 %0, %1, %2;" : "=f"(f703) : "f"(f189), "f"(f702));
  // PTX:809 mul.f32 %f704, %f1041, %f1041
  asm("mul.f32 %0, %1, %2;" : "=f"(f704) : "f"(f1041), "f"(f1041));
  // PTX:810 mul.f32 %f705, %f189, %f704
  asm("mul.f32 %0, %1, %2;" : "=f"(f705) : "f"(f189), "f"(f704));
  // PTX:811 mul.lo.s64 %rd182, %rd319, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd182) : "l"(rd319));
  // PTX:812 add.s64 %rd183, %rd1, %rd182
  asm("add.s64 %0, %1, %2;" : "=l"(rd183) : "l"(rd1), "l"(rd182));
  // PTX:813 red.global.add.f32 [%rd183], %f695
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd183) + (0)))), (float)(f695));
  // PTX:814 add.s64 %rd184, %rd183, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd184) : "l"(rd183));
  // PTX:815 red.global.add.f32 [%rd184], %f697
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd184) + (0)))), (float)(f697));
  // PTX:816 add.s64 %rd185, %rd183, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd185) : "l"(rd183));
  // PTX:817 red.global.add.f32 [%rd185], %f699
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (0)))), (float)(f699));
  // PTX:818 add.s64 %rd186, %rd183, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd186) : "l"(rd183));
  // PTX:819 red.global.add.f32 [%rd186], %f697
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd186) + (0)))), (float)(f697));
  // PTX:820 add.s64 %rd187, %rd183, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd187) : "l"(rd183));
  // PTX:821 red.global.add.f32 [%rd187], %f701
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd187) + (0)))), (float)(f701));
  // PTX:822 add.s64 %rd188, %rd183, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd188) : "l"(rd183));
  // PTX:823 red.global.add.f32 [%rd188], %f703
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd188) + (0)))), (float)(f703));
  // PTX:824 add.s64 %rd189, %rd183, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd189) : "l"(rd183));
  // PTX:825 red.global.add.f32 [%rd189], %f699
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd189) + (0)))), (float)(f699));
  // PTX:826 add.s64 %rd190, %rd183, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd190) : "l"(rd183));
  // PTX:827 red.global.add.f32 [%rd190], %f703
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd190) + (0)))), (float)(f703));
  // PTX:828 add.s64 %rd191, %rd183, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd191) : "l"(rd183));
  // PTX:829 red.global.add.f32 [%rd191], %f705
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd191) + (0)))), (float)(f705));
  // PTX:830 bra.uni $L__BB69_74
  goto L_BB69_74;
  // PTX:832 $L__BB69_43:
L_BB69_43:;
  // PTX:833 ld.param.u64 %rd268, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_6]
  rd268 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:834 setp.eq.s64 %p37, %rd268, 0
  p37 = (((long long)(rd268)) == ((long long)(0)));
  // PTX:835 @%p37 bra $L__BB69_52
  if (p37) { goto L_BB69_52; }
  // PTX:837 cvt.u32.u64 %r71, %rd14
  asm("cvt.u32.u64 %0, %1;" : "=r"(r71) : "l"(rd14));
  // PTX:838 setp.lt.s32 %p38, %r71, 0
  p38 = (((int)(r71)) < ((int)(0)));
  // PTX:839 mul.lo.s64 %rd192, %rd27, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd192) : "l"(rd27));
  // PTX:840 add.s64 %rd193, %rd4, %rd192
  asm("add.s64 %0, %1, %2;" : "=l"(rd193) : "l"(rd4), "l"(rd192));
  // PTX:841 ld.global.f32 %f715, [%rd193]
  f715 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd193) + (0)))));
  // PTX:842 ld.global.f32 %f716, [%rd193+4]
  f716 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd193) + (4)))));
  // PTX:843 mul.f32 %f717, %f1030, %f716
  asm("mul.f32 %0, %1, %2;" : "=f"(f717) : "f"(f1030), "f"(f716));
  // PTX:844 ld.global.f32 %f718, [%rd193+8]
  f718 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd193) + (8)))));
  // PTX:845 fma.rn.f32 %f719, %f1031, %f715, %f717
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f719) : "f"(f1031), "f"(f715), "f"(f717));
  // PTX:846 fma.rn.f32 %f720, %f1029, %f718, %f719
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f720) : "f"(f1029), "f"(f718), "f"(f719));
  // PTX:847 add.f32 %f1042, %f720, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1042) : "f"(f720));
  // PTX:848 @%p38 bra $L__BB69_46
  if (p38) { goto L_BB69_46; }
  // PTX:850 mul.lo.s64 %rd194, %rd322, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd194) : "l"(rd322));
  // PTX:851 add.s64 %rd195, %rd4, %rd194
  asm("add.s64 %0, %1, %2;" : "=l"(rd195) : "l"(rd4), "l"(rd194));
  // PTX:852 ld.global.f32 %f721, [%rd195]
  f721 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd195) + (0)))));
  // PTX:853 ld.global.f32 %f722, [%rd195+4]
  f722 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd195) + (4)))));
  // PTX:854 mul.f32 %f723, %f1018, %f722
  asm("mul.f32 %0, %1, %2;" : "=f"(f723) : "f"(f1018), "f"(f722));
  // PTX:855 ld.global.f32 %f724, [%rd195+8]
  f724 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd195) + (8)))));
  // PTX:856 fma.rn.f32 %f725, %f1019, %f721, %f723
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f725) : "f"(f1019), "f"(f721), "f"(f723));
  // PTX:857 fma.rn.f32 %f726, %f1017, %f724, %f725
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f726) : "f"(f1017), "f"(f724), "f"(f725));
  // PTX:858 add.f32 %f1042, %f1042, %f726
  asm("add.f32 %0, %1, %2;" : "=f"(f1042) : "f"(f1042), "f"(f726));
  // PTX:860 $L__BB69_46:
L_BB69_46:;
  // PTX:861 mul.lo.s64 %rd196, %rd28, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd196) : "l"(rd28));
  // PTX:862 add.s64 %rd197, %rd4, %rd196
  asm("add.s64 %0, %1, %2;" : "=l"(rd197) : "l"(rd4), "l"(rd196));
  // PTX:863 ld.global.f32 %f727, [%rd197]
  f727 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd197) + (0)))));
  // PTX:864 ld.global.f32 %f728, [%rd197+4]
  f728 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd197) + (4)))));
  // PTX:865 mul.f32 %f729, %f1027, %f728
  asm("mul.f32 %0, %1, %2;" : "=f"(f729) : "f"(f1027), "f"(f728));
  // PTX:866 ld.global.f32 %f730, [%rd197+8]
  f730 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd197) + (8)))));
  // PTX:867 fma.rn.f32 %f731, %f1028, %f727, %f729
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f731) : "f"(f1028), "f"(f727), "f"(f729));
  // PTX:868 fma.rn.f32 %f732, %f1026, %f730, %f731
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f732) : "f"(f1026), "f"(f730), "f"(f731));
  // PTX:869 add.f32 %f1043, %f1042, %f732
  asm("add.f32 %0, %1, %2;" : "=f"(f1043) : "f"(f1042), "f"(f732));
  // PTX:870 @%p38 bra $L__BB69_48
  if (p38) { goto L_BB69_48; }
  // PTX:872 mul.lo.s64 %rd198, %rd321, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd198) : "l"(rd321));
  // PTX:873 add.s64 %rd199, %rd4, %rd198
  asm("add.s64 %0, %1, %2;" : "=l"(rd199) : "l"(rd4), "l"(rd198));
  // PTX:874 ld.global.f32 %f733, [%rd199]
  f733 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd199) + (0)))));
  // PTX:875 ld.global.f32 %f734, [%rd199+4]
  f734 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd199) + (4)))));
  // PTX:876 mul.f32 %f735, %f1033, %f734
  asm("mul.f32 %0, %1, %2;" : "=f"(f735) : "f"(f1033), "f"(f734));
  // PTX:877 ld.global.f32 %f736, [%rd199+8]
  f736 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd199) + (8)))));
  // PTX:878 fma.rn.f32 %f737, %f1032, %f733, %f735
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f737) : "f"(f1032), "f"(f733), "f"(f735));
  // PTX:879 fma.rn.f32 %f738, %f1034, %f736, %f737
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f738) : "f"(f1034), "f"(f736), "f"(f737));
  // PTX:880 add.f32 %f1043, %f1043, %f738
  asm("add.f32 %0, %1, %2;" : "=f"(f1043) : "f"(f1043), "f"(f738));
  // PTX:882 $L__BB69_48:
L_BB69_48:;
  // PTX:883 mul.lo.s64 %rd200, %rd29, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd200) : "l"(rd29));
  // PTX:884 add.s64 %rd201, %rd4, %rd200
  asm("add.s64 %0, %1, %2;" : "=l"(rd201) : "l"(rd4), "l"(rd200));
  // PTX:885 ld.global.f32 %f739, [%rd201]
  f739 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd201) + (0)))));
  // PTX:886 ld.global.f32 %f740, [%rd201+4]
  f740 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd201) + (4)))));
  // PTX:887 mul.f32 %f741, %f1024, %f740
  asm("mul.f32 %0, %1, %2;" : "=f"(f741) : "f"(f1024), "f"(f740));
  // PTX:888 ld.global.f32 %f742, [%rd201+8]
  f742 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd201) + (8)))));
  // PTX:889 fma.rn.f32 %f743, %f1025, %f739, %f741
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f743) : "f"(f1025), "f"(f739), "f"(f741));
  // PTX:890 fma.rn.f32 %f744, %f1023, %f742, %f743
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f744) : "f"(f1023), "f"(f742), "f"(f743));
  // PTX:891 add.f32 %f1044, %f1043, %f744
  asm("add.f32 %0, %1, %2;" : "=f"(f1044) : "f"(f1043), "f"(f744));
  // PTX:892 @%p38 bra $L__BB69_50
  if (p38) { goto L_BB69_50; }
  // PTX:894 mul.lo.s64 %rd202, %rd320, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd202) : "l"(rd320));
  // PTX:895 add.s64 %rd203, %rd4, %rd202
  asm("add.s64 %0, %1, %2;" : "=l"(rd203) : "l"(rd4), "l"(rd202));
  // PTX:896 ld.global.f32 %f745, [%rd203]
  f745 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd203) + (0)))));
  // PTX:897 ld.global.f32 %f746, [%rd203+4]
  f746 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd203) + (4)))));
  // PTX:898 mul.f32 %f747, %f1037, %f746
  asm("mul.f32 %0, %1, %2;" : "=f"(f747) : "f"(f1037), "f"(f746));
  // PTX:899 ld.global.f32 %f748, [%rd203+8]
  f748 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd203) + (8)))));
  // PTX:900 fma.rn.f32 %f749, %f1035, %f745, %f747
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f749) : "f"(f1035), "f"(f745), "f"(f747));
  // PTX:901 fma.rn.f32 %f750, %f1038, %f748, %f749
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f750) : "f"(f1038), "f"(f748), "f"(f749));
  // PTX:902 add.f32 %f1044, %f1044, %f750
  asm("add.f32 %0, %1, %2;" : "=f"(f1044) : "f"(f1044), "f"(f750));
  // PTX:904 $L__BB69_50:
L_BB69_50:;
  // PTX:905 mul.lo.s64 %rd204, %rd30, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd204) : "l"(rd30));
  // PTX:906 add.s64 %rd205, %rd4, %rd204
  asm("add.s64 %0, %1, %2;" : "=l"(rd205) : "l"(rd4), "l"(rd204));
  // PTX:907 ld.global.f32 %f751, [%rd205]
  f751 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd205) + (0)))));
  // PTX:908 ld.global.f32 %f752, [%rd205+4]
  f752 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd205) + (4)))));
  // PTX:909 mul.f32 %f753, %f1021, %f752
  asm("mul.f32 %0, %1, %2;" : "=f"(f753) : "f"(f1021), "f"(f752));
  // PTX:910 ld.global.f32 %f754, [%rd205+8]
  f754 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd205) + (8)))));
  // PTX:911 fma.rn.f32 %f755, %f1022, %f751, %f753
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f755) : "f"(f1022), "f"(f751), "f"(f753));
  // PTX:912 fma.rn.f32 %f756, %f1020, %f754, %f755
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f756) : "f"(f1020), "f"(f754), "f"(f755));
  // PTX:913 add.f32 %f1052, %f1044, %f756
  asm("add.f32 %0, %1, %2;" : "=f"(f1052) : "f"(f1044), "f"(f756));
  // PTX:914 @%p38 bra $L__BB69_71
  if (p38) { goto L_BB69_71; }
  // PTX:916 mul.lo.s64 %rd206, %rd319, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd206) : "l"(rd319));
  // PTX:917 add.s64 %rd207, %rd4, %rd206
  asm("add.s64 %0, %1, %2;" : "=l"(rd207) : "l"(rd4), "l"(rd206));
  // PTX:918 ld.global.f32 %f757, [%rd207]
  f757 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd207) + (0)))));
  // PTX:919 ld.global.f32 %f758, [%rd207+4]
  f758 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd207) + (4)))));
  // PTX:920 mul.f32 %f759, %f1040, %f758
  asm("mul.f32 %0, %1, %2;" : "=f"(f759) : "f"(f1040), "f"(f758));
  // PTX:921 ld.global.f32 %f760, [%rd207+8]
  f760 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd207) + (8)))));
  // PTX:922 fma.rn.f32 %f761, %f1039, %f757, %f759
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f761) : "f"(f1039), "f"(f757), "f"(f759));
  // PTX:923 fma.rn.f32 %f762, %f1041, %f760, %f761
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f762) : "f"(f1041), "f"(f760), "f"(f761));
  // PTX:924 add.f32 %f1052, %f1052, %f762
  asm("add.f32 %0, %1, %2;" : "=f"(f1052) : "f"(f1052), "f"(f762));
  // PTX:926 $L__BB69_71:
L_BB69_71:;
  // PTX:927 mul.f32 %f263, %f189, %f1052
  asm("mul.f32 %0, %1, %2;" : "=f"(f263) : "f"(f189), "f"(f1052));
  // PTX:928 abs.f32 %f938, %f263
  asm("abs.f32 %0, %1;" : "=f"(f938) : "f"(f263));
  // PTX:929 setp.geu.f32 %p65, %f938, 0f7F800000
  p65 = ((isnan(((float)(f938))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f938)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:930 @%p65 bra $L__BB69_74
  if (p65) { goto L_BB69_74; }
  // PTX:932 ld.param.u64 %rd270, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_7]
  rd270 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:933 cvta.to.global.u64 %rd269, %rd270
  rd269 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd270));
  // PTX:934 cvt.u32.u64 %r103, %rd14
  asm("cvt.u32.u64 %0, %1;" : "=r"(r103) : "l"(rd14));
  // PTX:935 setp.lt.s32 %p66, %r103, 0
  p66 = (((int)(r103)) < ((int)(0)));
  // PTX:936 mul.lo.s64 %rd227, %rd27, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd227) : "l"(rd27));
  // PTX:937 add.s64 %rd228, %rd269, %rd227
  asm("add.s64 %0, %1, %2;" : "=l"(rd228) : "l"(rd269), "l"(rd227));
  // PTX:938 mul.f32 %f939, %f263, %f1031
  asm("mul.f32 %0, %1, %2;" : "=f"(f939) : "f"(f263), "f"(f1031));
  // PTX:939 red.global.add.f32 [%rd228], %f939
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd228) + (0)))), (float)(f939));
  // PTX:940 add.s64 %rd229, %rd228, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd229) : "l"(rd228));
  // PTX:941 mul.f32 %f941, %f263, %f1030
  asm("mul.f32 %0, %1, %2;" : "=f"(f941) : "f"(f263), "f"(f1030));
  // PTX:942 red.global.add.f32 [%rd229], %f941
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd229) + (0)))), (float)(f941));
  // PTX:943 add.s64 %rd230, %rd228, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd230) : "l"(rd228));
  // PTX:944 mul.f32 %f943, %f263, %f1029
  asm("mul.f32 %0, %1, %2;" : "=f"(f943) : "f"(f263), "f"(f1029));
  // PTX:945 red.global.add.f32 [%rd230], %f943
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd230) + (0)))), (float)(f943));
  // PTX:946 mul.lo.s64 %rd231, %rd28, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd231) : "l"(rd28));
  // PTX:947 add.s64 %rd232, %rd269, %rd231
  asm("add.s64 %0, %1, %2;" : "=l"(rd232) : "l"(rd269), "l"(rd231));
  // PTX:948 mul.f32 %f945, %f263, %f1028
  asm("mul.f32 %0, %1, %2;" : "=f"(f945) : "f"(f263), "f"(f1028));
  // PTX:949 red.global.add.f32 [%rd232], %f945
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd232) + (0)))), (float)(f945));
  // PTX:950 add.s64 %rd233, %rd232, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd233) : "l"(rd232));
  // PTX:951 mul.f32 %f947, %f263, %f1027
  asm("mul.f32 %0, %1, %2;" : "=f"(f947) : "f"(f263), "f"(f1027));
  // PTX:952 red.global.add.f32 [%rd233], %f947
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd233) + (0)))), (float)(f947));
  // PTX:953 add.s64 %rd234, %rd232, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd234) : "l"(rd232));
  // PTX:954 mul.f32 %f949, %f263, %f1026
  asm("mul.f32 %0, %1, %2;" : "=f"(f949) : "f"(f263), "f"(f1026));
  // PTX:955 red.global.add.f32 [%rd234], %f949
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd234) + (0)))), (float)(f949));
  // PTX:956 mul.lo.s64 %rd235, %rd29, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd235) : "l"(rd29));
  // PTX:957 add.s64 %rd236, %rd269, %rd235
  asm("add.s64 %0, %1, %2;" : "=l"(rd236) : "l"(rd269), "l"(rd235));
  // PTX:958 mul.f32 %f951, %f263, %f1025
  asm("mul.f32 %0, %1, %2;" : "=f"(f951) : "f"(f263), "f"(f1025));
  // PTX:959 red.global.add.f32 [%rd236], %f951
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd236) + (0)))), (float)(f951));
  // PTX:960 add.s64 %rd237, %rd236, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd237) : "l"(rd236));
  // PTX:961 mul.f32 %f953, %f263, %f1024
  asm("mul.f32 %0, %1, %2;" : "=f"(f953) : "f"(f263), "f"(f1024));
  // PTX:962 red.global.add.f32 [%rd237], %f953
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd237) + (0)))), (float)(f953));
  // PTX:963 add.s64 %rd238, %rd236, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd238) : "l"(rd236));
  // PTX:964 mul.f32 %f955, %f263, %f1023
  asm("mul.f32 %0, %1, %2;" : "=f"(f955) : "f"(f263), "f"(f1023));
  // PTX:965 red.global.add.f32 [%rd238], %f955
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd238) + (0)))), (float)(f955));
  // PTX:966 mul.lo.s64 %rd239, %rd30, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd239) : "l"(rd30));
  // PTX:967 add.s64 %rd240, %rd269, %rd239
  asm("add.s64 %0, %1, %2;" : "=l"(rd240) : "l"(rd269), "l"(rd239));
  // PTX:968 mul.f32 %f957, %f263, %f1022
  asm("mul.f32 %0, %1, %2;" : "=f"(f957) : "f"(f263), "f"(f1022));
  // PTX:969 red.global.add.f32 [%rd240], %f957
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd240) + (0)))), (float)(f957));
  // PTX:970 add.s64 %rd241, %rd240, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd241) : "l"(rd240));
  // PTX:971 mul.f32 %f959, %f263, %f1021
  asm("mul.f32 %0, %1, %2;" : "=f"(f959) : "f"(f263), "f"(f1021));
  // PTX:972 red.global.add.f32 [%rd241], %f959
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd241) + (0)))), (float)(f959));
  // PTX:973 add.s64 %rd242, %rd240, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd242) : "l"(rd240));
  // PTX:974 mul.f32 %f961, %f263, %f1020
  asm("mul.f32 %0, %1, %2;" : "=f"(f961) : "f"(f263), "f"(f1020));
  // PTX:975 red.global.add.f32 [%rd242], %f961
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd242) + (0)))), (float)(f961));
  // PTX:976 @%p66 bra $L__BB69_74
  if (p66) { goto L_BB69_74; }
  // PTX:978 ld.param.u64 %rd272, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_7]
  rd272 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:979 cvta.to.global.u64 %rd271, %rd272
  rd271 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd272));
  // PTX:980 mul.f32 %f963, %f263, %f1019
  asm("mul.f32 %0, %1, %2;" : "=f"(f963) : "f"(f263), "f"(f1019));
  // PTX:981 mul.lo.s64 %rd243, %rd322, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd243) : "l"(rd322));
  // PTX:982 add.s64 %rd244, %rd271, %rd243
  asm("add.s64 %0, %1, %2;" : "=l"(rd244) : "l"(rd271), "l"(rd243));
  // PTX:983 red.global.add.f32 [%rd244], %f963
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd244) + (0)))), (float)(f963));
  // PTX:984 add.s64 %rd245, %rd244, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd245) : "l"(rd244));
  // PTX:985 mul.f32 %f965, %f263, %f1018
  asm("mul.f32 %0, %1, %2;" : "=f"(f965) : "f"(f263), "f"(f1018));
  // PTX:986 red.global.add.f32 [%rd245], %f965
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd245) + (0)))), (float)(f965));
  // PTX:987 add.s64 %rd246, %rd244, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd246) : "l"(rd244));
  // PTX:988 mul.f32 %f967, %f263, %f1017
  asm("mul.f32 %0, %1, %2;" : "=f"(f967) : "f"(f263), "f"(f1017));
  // PTX:989 red.global.add.f32 [%rd246], %f967
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd246) + (0)))), (float)(f967));
  // PTX:990 mul.lo.s64 %rd247, %rd321, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd247) : "l"(rd321));
  // PTX:991 add.s64 %rd248, %rd271, %rd247
  asm("add.s64 %0, %1, %2;" : "=l"(rd248) : "l"(rd271), "l"(rd247));
  // PTX:992 mul.f32 %f969, %f263, %f1032
  asm("mul.f32 %0, %1, %2;" : "=f"(f969) : "f"(f263), "f"(f1032));
  // PTX:993 red.global.add.f32 [%rd248], %f969
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd248) + (0)))), (float)(f969));
  // PTX:994 add.s64 %rd249, %rd248, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd249) : "l"(rd248));
  // PTX:995 mul.f32 %f971, %f263, %f1033
  asm("mul.f32 %0, %1, %2;" : "=f"(f971) : "f"(f263), "f"(f1033));
  // PTX:996 red.global.add.f32 [%rd249], %f971
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd249) + (0)))), (float)(f971));
  // PTX:997 add.s64 %rd250, %rd248, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd250) : "l"(rd248));
  // PTX:998 mul.f32 %f973, %f263, %f1034
  asm("mul.f32 %0, %1, %2;" : "=f"(f973) : "f"(f263), "f"(f1034));
  // PTX:999 red.global.add.f32 [%rd250], %f973
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd250) + (0)))), (float)(f973));
  // PTX:1000 mul.lo.s64 %rd251, %rd320, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd251) : "l"(rd320));
  // PTX:1001 add.s64 %rd252, %rd271, %rd251
  asm("add.s64 %0, %1, %2;" : "=l"(rd252) : "l"(rd271), "l"(rd251));
  // PTX:1002 mul.f32 %f975, %f263, %f1035
  asm("mul.f32 %0, %1, %2;" : "=f"(f975) : "f"(f263), "f"(f1035));
  // PTX:1003 red.global.add.f32 [%rd252], %f975
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd252) + (0)))), (float)(f975));
  // PTX:1004 add.s64 %rd253, %rd252, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd253) : "l"(rd252));
  // PTX:1005 mul.f32 %f977, %f263, %f1037
  asm("mul.f32 %0, %1, %2;" : "=f"(f977) : "f"(f263), "f"(f1037));
  // PTX:1006 red.global.add.f32 [%rd253], %f977
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd253) + (0)))), (float)(f977));
  // PTX:1007 add.s64 %rd254, %rd252, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd254) : "l"(rd252));
  // PTX:1008 mul.f32 %f979, %f263, %f1038
  asm("mul.f32 %0, %1, %2;" : "=f"(f979) : "f"(f263), "f"(f1038));
  // PTX:1009 red.global.add.f32 [%rd254], %f979
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd254) + (0)))), (float)(f979));
  // PTX:1010 mul.lo.s64 %rd255, %rd319, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd255) : "l"(rd319));
  // PTX:1011 add.s64 %rd256, %rd271, %rd255
  asm("add.s64 %0, %1, %2;" : "=l"(rd256) : "l"(rd271), "l"(rd255));
  // PTX:1012 mul.f32 %f981, %f263, %f1039
  asm("mul.f32 %0, %1, %2;" : "=f"(f981) : "f"(f263), "f"(f1039));
  // PTX:1013 red.global.add.f32 [%rd256], %f981
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd256) + (0)))), (float)(f981));
  // PTX:1014 add.s64 %rd257, %rd256, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd257) : "l"(rd256));
  // PTX:1015 mul.f32 %f983, %f263, %f1040
  asm("mul.f32 %0, %1, %2;" : "=f"(f983) : "f"(f263), "f"(f1040));
  // PTX:1016 red.global.add.f32 [%rd257], %f983
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd257) + (0)))), (float)(f983));
  // PTX:1017 add.s64 %rd258, %rd256, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd258) : "l"(rd256));
  // PTX:1018 mul.f32 %f985, %f263, %f1041
  asm("mul.f32 %0, %1, %2;" : "=f"(f985) : "f"(f263), "f"(f1041));
  // PTX:1019 red.global.add.f32 [%rd258], %f985
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd258) + (0)))), (float)(f985));
  // PTX:1020 bra.uni $L__BB69_74
  goto L_BB69_74;
  // PTX:1022 $L__BB69_52:
L_BB69_52:;
  // PTX:1023 cvt.u32.u64 %r75, %rd14
  asm("cvt.u32.u64 %0, %1;" : "=r"(r75) : "l"(rd14));
  // PTX:1024 setp.lt.s32 %p42, %r75, 0
  p42 = (((int)(r75)) < ((int)(0)));
  // PTX:1025 @%p42 bra $L__BB69_54
  if (p42) { goto L_BB69_54; }
  // PTX:1027 shl.b64 %rd306, %rd10, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd306) : "l"(rd10));
  // PTX:1028 ld.param.u64 %rd305, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_0+64]
  rd305 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (64))));
  // PTX:1029 cvta.to.global.u64 %rd304, %rd305
  rd304 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd305));
  // PTX:1030 add.s64 %rd303, %rd304, %rd306
  asm("add.s64 %0, %1, %2;" : "=l"(rd303) : "l"(rd304), "l"(rd306));
  // PTX:1031 ld.param.u64 %rd302, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_0+48]
  rd302 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (48))));
  // PTX:1032 cvta.to.global.u64 %rd301, %rd302
  rd301 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd302));
  // PTX:1033 add.s64 %rd300, %rd301, %rd306
  asm("add.s64 %0, %1, %2;" : "=l"(rd300) : "l"(rd301), "l"(rd306));
  // PTX:1034 ld.param.u64 %rd282, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_0+72]
  rd282 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (72))));
  // PTX:1035 shl.b64 %rd281, %rd10, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd281) : "l"(rd10));
  // PTX:1036 cvta.to.global.u64 %rd280, %rd282
  rd280 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd282));
  // PTX:1037 add.s64 %rd279, %rd280, %rd281
  asm("add.s64 %0, %1, %2;" : "=l"(rd279) : "l"(rd280), "l"(rd281));
  // PTX:1038 ld.param.u64 %rd278, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_0]
  rd278 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:1039 mul.wide.s32 %rd277, %r32, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd277) : "r"(r32));
  // PTX:1040 cvta.to.global.u64 %rd276, %rd278
  rd276 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd278));
  // PTX:1041 add.s64 %rd275, %rd276, %rd277
  asm("add.s64 %0, %1, %2;" : "=l"(rd275) : "l"(rd276), "l"(rd277));
  // PTX:1042 ld.param.u64 %rd274, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_3]
  rd274 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:1043 cvta.to.global.u64 %rd273, %rd274
  rd273 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd274));
  // PTX:1044 ld.global.u32 %r76, [%rd275]
  r76 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd275) + (0)))));
  // PTX:1045 add.s32 %r77, %r76, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r77) : "r"(r76), "r"(r1));
  // PTX:1046 ld.global.u32 %r78, [%rd275+4]
  r78 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd275) + (4)))));
  // PTX:1047 add.s32 %r79, %r78, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r79) : "r"(r78), "r"(r1));
  // PTX:1048 ld.global.u32 %r80, [%rd275+8]
  r80 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd275) + (8)))));
  // PTX:1049 add.s32 %r81, %r80, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r81) : "r"(r80), "r"(r1));
  // PTX:1050 ld.global.u32 %r82, [%rd275+12]
  r82 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd275) + (12)))));
  // PTX:1051 add.s32 %r83, %r82, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r83) : "r"(r82), "r"(r1));
  // PTX:1052 mul.wide.s32 %rd208, %r77, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd208) : "r"(r77));
  // PTX:1053 add.s64 %rd209, %rd273, %rd208
  asm("add.s64 %0, %1, %2;" : "=l"(rd209) : "l"(rd273), "l"(rd208));
  // PTX:1054 ld.global.f32 %f763, [%rd209]
  f763 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd209) + (0)))));
  // PTX:1055 ld.global.f32 %f764, [%rd300]
  f764 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd300) + (0)))));
  // PTX:1056 ld.global.f32 %f765, [%rd209+4]
  f765 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd209) + (4)))));
  // PTX:1057 ld.global.f32 %f766, [%rd209+8]
  f766 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd209) + (8)))));
  // PTX:1058 mul.wide.s32 %rd210, %r79, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd210) : "r"(r79));
  // PTX:1059 add.s64 %rd211, %rd273, %rd210
  asm("add.s64 %0, %1, %2;" : "=l"(rd211) : "l"(rd273), "l"(rd210));
  // PTX:1060 ld.global.f32 %f767, [%rd211]
  f767 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd211) + (0)))));
  // PTX:1061 ld.global.f32 %f768, [%rd300+4]
  f768 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd300) + (4)))));
  // PTX:1062 mul.f32 %f769, %f768, %f767
  asm("mul.f32 %0, %1, %2;" : "=f"(f769) : "f"(f768), "f"(f767));
  // PTX:1063 ld.global.f32 %f770, [%rd211+4]
  f770 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd211) + (4)))));
  // PTX:1064 mul.f32 %f771, %f768, %f770
  asm("mul.f32 %0, %1, %2;" : "=f"(f771) : "f"(f768), "f"(f770));
  // PTX:1065 ld.global.f32 %f772, [%rd211+8]
  f772 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd211) + (8)))));
  // PTX:1066 mul.f32 %f773, %f768, %f772
  asm("mul.f32 %0, %1, %2;" : "=f"(f773) : "f"(f768), "f"(f772));
  // PTX:1067 fma.rn.f32 %f774, %f764, %f763, %f769
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f774) : "f"(f764), "f"(f763), "f"(f769));
  // PTX:1068 fma.rn.f32 %f775, %f764, %f765, %f771
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f775) : "f"(f764), "f"(f765), "f"(f771));
  // PTX:1069 fma.rn.f32 %f776, %f764, %f766, %f773
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f776) : "f"(f764), "f"(f766), "f"(f773));
  // PTX:1070 mul.wide.s32 %rd212, %r81, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd212) : "r"(r81));
  // PTX:1071 add.s64 %rd213, %rd273, %rd212
  asm("add.s64 %0, %1, %2;" : "=l"(rd213) : "l"(rd273), "l"(rd212));
  // PTX:1072 ld.global.f32 %f777, [%rd213]
  f777 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd213) + (0)))));
  // PTX:1073 ld.global.f32 %f778, [%rd300+8]
  f778 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd300) + (8)))));
  // PTX:1074 ld.global.f32 %f779, [%rd213+4]
  f779 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd213) + (4)))));
  // PTX:1075 ld.global.f32 %f780, [%rd213+8]
  f780 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd213) + (8)))));
  // PTX:1076 fma.rn.f32 %f781, %f778, %f777, %f774
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f781) : "f"(f778), "f"(f777), "f"(f774));
  // PTX:1077 fma.rn.f32 %f782, %f778, %f779, %f775
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f782) : "f"(f778), "f"(f779), "f"(f775));
  // PTX:1078 fma.rn.f32 %f783, %f778, %f780, %f776
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f783) : "f"(f778), "f"(f780), "f"(f776));
  // PTX:1079 mul.wide.s32 %rd214, %r83, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd214) : "r"(r83));
  // PTX:1080 add.s64 %rd215, %rd273, %rd214
  asm("add.s64 %0, %1, %2;" : "=l"(rd215) : "l"(rd273), "l"(rd214));
  // PTX:1081 ld.global.f32 %f784, [%rd215]
  f784 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd215) + (0)))));
  // PTX:1082 ld.global.f32 %f785, [%rd300+12]
  f785 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd300) + (12)))));
  // PTX:1083 ld.global.f32 %f786, [%rd215+4]
  f786 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd215) + (4)))));
  // PTX:1084 ld.global.f32 %f787, [%rd215+8]
  f787 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd215) + (8)))));
  // PTX:1085 fma.rn.f32 %f1048, %f785, %f784, %f781
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1048) : "f"(f785), "f"(f784), "f"(f781));
  // PTX:1086 fma.rn.f32 %f1049, %f785, %f786, %f782
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1049) : "f"(f785), "f"(f786), "f"(f782));
  // PTX:1087 fma.rn.f32 %f1050, %f785, %f787, %f783
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1050) : "f"(f785), "f"(f787), "f"(f783));
  // PTX:1088 ld.global.f32 %f788, [%rd303]
  f788 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd303) + (0)))));
  // PTX:1089 ld.global.f32 %f789, [%rd303+4]
  f789 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd303) + (4)))));
  // PTX:1090 mul.f32 %f790, %f789, %f767
  asm("mul.f32 %0, %1, %2;" : "=f"(f790) : "f"(f789), "f"(f767));
  // PTX:1091 mul.f32 %f791, %f789, %f770
  asm("mul.f32 %0, %1, %2;" : "=f"(f791) : "f"(f789), "f"(f770));
  // PTX:1092 mul.f32 %f792, %f789, %f772
  asm("mul.f32 %0, %1, %2;" : "=f"(f792) : "f"(f789), "f"(f772));
  // PTX:1093 fma.rn.f32 %f793, %f788, %f763, %f790
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f793) : "f"(f788), "f"(f763), "f"(f790));
  // PTX:1094 fma.rn.f32 %f794, %f788, %f765, %f791
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f794) : "f"(f788), "f"(f765), "f"(f791));
  // PTX:1095 fma.rn.f32 %f795, %f788, %f766, %f792
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f795) : "f"(f788), "f"(f766), "f"(f792));
  // PTX:1096 ld.global.f32 %f796, [%rd303+8]
  f796 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd303) + (8)))));
  // PTX:1097 fma.rn.f32 %f797, %f796, %f777, %f793
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f797) : "f"(f796), "f"(f777), "f"(f793));
  // PTX:1098 fma.rn.f32 %f798, %f796, %f779, %f794
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f798) : "f"(f796), "f"(f779), "f"(f794));
  // PTX:1099 fma.rn.f32 %f799, %f796, %f780, %f795
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f799) : "f"(f796), "f"(f780), "f"(f795));
  // PTX:1100 ld.global.f32 %f800, [%rd303+12]
  f800 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd303) + (12)))));
  // PTX:1101 fma.rn.f32 %f1045, %f800, %f784, %f797
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1045) : "f"(f800), "f"(f784), "f"(f797));
  // PTX:1102 fma.rn.f32 %f1046, %f800, %f786, %f798
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1046) : "f"(f800), "f"(f786), "f"(f798));
  // PTX:1103 fma.rn.f32 %f1047, %f800, %f787, %f799
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1047) : "f"(f800), "f"(f787), "f"(f799));
  // PTX:1104 ld.global.f32 %f801, [%rd279]
  f801 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd279) + (0)))));
  // PTX:1105 ld.global.f32 %f802, [%rd279+4]
  f802 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd279) + (4)))));
  // PTX:1106 mul.f32 %f803, %f802, %f767
  asm("mul.f32 %0, %1, %2;" : "=f"(f803) : "f"(f802), "f"(f767));
  // PTX:1107 mul.f32 %f804, %f802, %f770
  asm("mul.f32 %0, %1, %2;" : "=f"(f804) : "f"(f802), "f"(f770));
  // PTX:1108 mul.f32 %f805, %f802, %f772
  asm("mul.f32 %0, %1, %2;" : "=f"(f805) : "f"(f802), "f"(f772));
  // PTX:1109 fma.rn.f32 %f806, %f801, %f763, %f803
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f806) : "f"(f801), "f"(f763), "f"(f803));
  // PTX:1110 fma.rn.f32 %f807, %f801, %f765, %f804
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f807) : "f"(f801), "f"(f765), "f"(f804));
  // PTX:1111 fma.rn.f32 %f808, %f801, %f766, %f805
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f808) : "f"(f801), "f"(f766), "f"(f805));
  // PTX:1112 ld.global.f32 %f809, [%rd279+8]
  f809 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd279) + (8)))));
  // PTX:1113 fma.rn.f32 %f810, %f809, %f777, %f806
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f810) : "f"(f809), "f"(f777), "f"(f806));
  // PTX:1114 fma.rn.f32 %f811, %f809, %f779, %f807
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f811) : "f"(f809), "f"(f779), "f"(f807));
  // PTX:1115 fma.rn.f32 %f812, %f809, %f780, %f808
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f812) : "f"(f809), "f"(f780), "f"(f808));
  // PTX:1116 ld.global.f32 %f813, [%rd279+12]
  f813 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd279) + (12)))));
  // PTX:1117 fma.rn.f32 %f814, %f813, %f784, %f810
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f814) : "f"(f813), "f"(f784), "f"(f810));
  // PTX:1118 fma.rn.f32 %f815, %f813, %f786, %f811
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f815) : "f"(f813), "f"(f786), "f"(f811));
  // PTX:1119 fma.rn.f32 %f816, %f813, %f787, %f812
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f816) : "f"(f813), "f"(f787), "f"(f812));
  // PTX:1120 mov.b32 %r112, %f816
  asm("mov.b32 %0, %1;" : "=r"(r112) : "f"(f816));
  // PTX:1121 mov.b32 %r111, %f815
  asm("mov.b32 %0, %1;" : "=r"(r111) : "f"(f815));
  // PTX:1122 mov.b32 %r110, %f814
  asm("mov.b32 %0, %1;" : "=r"(r110) : "f"(f814));
  // PTX:1124 $L__BB69_54:
L_BB69_54:;
  // PTX:1125 setp.eq.s32 %p67, %r15, 0
  p67 = (((int)(r15)) == ((int)(0)));
  // PTX:1126 ld.param.u64 %rd284, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_3]
  rd284 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:1127 cvta.to.global.u64 %rd283, %rd284
  rd283 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd284));
  // PTX:1128 mul.lo.s64 %rd216, %rd27, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd216) : "l"(rd27));
  // PTX:1129 add.s64 %rd217, %rd283, %rd216
  asm("add.s64 %0, %1, %2;" : "=l"(rd217) : "l"(rd283), "l"(rd216));
  // PTX:1130 ld.global.f32 %f213, [%rd217]
  f213 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd217) + (0)))));
  // PTX:1131 ld.global.f32 %f214, [%rd217+4]
  f214 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd217) + (4)))));
  // PTX:1132 ld.global.f32 %f215, [%rd217+8]
  f215 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd217) + (8)))));
  // PTX:1133 mul.lo.s64 %rd218, %rd28, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd218) : "l"(rd28));
  // PTX:1134 add.s64 %rd219, %rd283, %rd218
  asm("add.s64 %0, %1, %2;" : "=l"(rd219) : "l"(rd283), "l"(rd218));
  // PTX:1135 ld.global.f32 %f216, [%rd219]
  f216 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd219) + (0)))));
  // PTX:1136 mul.f32 %f817, %f25, %f216
  asm("mul.f32 %0, %1, %2;" : "=f"(f817) : "f"(f25), "f"(f216));
  // PTX:1137 ld.global.f32 %f217, [%rd219+4]
  f217 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd219) + (4)))));
  // PTX:1138 mul.f32 %f818, %f25, %f217
  asm("mul.f32 %0, %1, %2;" : "=f"(f818) : "f"(f25), "f"(f217));
  // PTX:1139 ld.global.f32 %f218, [%rd219+8]
  f218 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd219) + (8)))));
  // PTX:1140 mul.f32 %f819, %f25, %f218
  asm("mul.f32 %0, %1, %2;" : "=f"(f819) : "f"(f25), "f"(f218));
  // PTX:1141 fma.rn.f32 %f820, %f21, %f213, %f817
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f820) : "f"(f21), "f"(f213), "f"(f817));
  // PTX:1142 fma.rn.f32 %f821, %f21, %f214, %f818
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f821) : "f"(f21), "f"(f214), "f"(f818));
  // PTX:1143 fma.rn.f32 %f822, %f21, %f215, %f819
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f822) : "f"(f21), "f"(f215), "f"(f819));
  // PTX:1144 mul.lo.s64 %rd220, %rd29, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd220) : "l"(rd29));
  // PTX:1145 add.s64 %rd221, %rd283, %rd220
  asm("add.s64 %0, %1, %2;" : "=l"(rd221) : "l"(rd283), "l"(rd220));
  // PTX:1146 ld.global.f32 %f219, [%rd221]
  f219 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd221) + (0)))));
  // PTX:1147 ld.global.f32 %f220, [%rd221+4]
  f220 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd221) + (4)))));
  // PTX:1148 ld.global.f32 %f221, [%rd221+8]
  f221 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd221) + (8)))));
  // PTX:1149 fma.rn.f32 %f823, %f29, %f219, %f820
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f823) : "f"(f29), "f"(f219), "f"(f820));
  // PTX:1150 fma.rn.f32 %f824, %f29, %f220, %f821
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f824) : "f"(f29), "f"(f220), "f"(f821));
  // PTX:1151 fma.rn.f32 %f825, %f29, %f221, %f822
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f825) : "f"(f29), "f"(f221), "f"(f822));
  // PTX:1152 mul.lo.s64 %rd222, %rd30, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd222) : "l"(rd30));
  // PTX:1153 add.s64 %rd223, %rd283, %rd222
  asm("add.s64 %0, %1, %2;" : "=l"(rd223) : "l"(rd283), "l"(rd222));
  // PTX:1154 ld.global.f32 %f222, [%rd223]
  f222 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd223) + (0)))));
  // PTX:1155 ld.global.f32 %f223, [%rd223+4]
  f223 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd223) + (4)))));
  // PTX:1156 ld.global.f32 %f224, [%rd223+8]
  f224 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd223) + (8)))));
  // PTX:1157 fma.rn.f32 %f225, %f33, %f222, %f823
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f225) : "f"(f33), "f"(f222), "f"(f823));
  // PTX:1158 fma.rn.f32 %f226, %f33, %f223, %f824
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f226) : "f"(f33), "f"(f223), "f"(f824));
  // PTX:1159 fma.rn.f32 %f227, %f33, %f224, %f825
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f227) : "f"(f33), "f"(f224), "f"(f825));
  // PTX:1160 @%p67 bra $L__BB69_67
  if (p67) { goto L_BB69_67; }
  // PTX:1162 ld.param.u64 %rd288, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_0+80]
  rd288 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (80))));
  // PTX:1163 shl.b64 %rd287, %rd10, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd287) : "l"(rd10));
  // PTX:1164 cvta.to.global.u64 %rd286, %rd288
  rd286 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd288));
  // PTX:1165 add.s64 %rd285, %rd286, %rd287
  asm("add.s64 %0, %1, %2;" : "=l"(rd285) : "l"(rd286), "l"(rd287));
  // PTX:1166 ld.global.f32 %f826, [%rd285]
  f826 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd285) + (0)))));
  // PTX:1167 ld.global.f32 %f827, [%rd285+4]
  f827 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd285) + (4)))));
  // PTX:1168 mul.f32 %f828, %f827, %f216
  asm("mul.f32 %0, %1, %2;" : "=f"(f828) : "f"(f827), "f"(f216));
  // PTX:1169 mul.f32 %f829, %f827, %f217
  asm("mul.f32 %0, %1, %2;" : "=f"(f829) : "f"(f827), "f"(f217));
  // PTX:1170 mul.f32 %f830, %f827, %f218
  asm("mul.f32 %0, %1, %2;" : "=f"(f830) : "f"(f827), "f"(f218));
  // PTX:1171 fma.rn.f32 %f831, %f826, %f213, %f828
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f831) : "f"(f826), "f"(f213), "f"(f828));
  // PTX:1172 fma.rn.f32 %f832, %f826, %f214, %f829
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f832) : "f"(f826), "f"(f214), "f"(f829));
  // PTX:1173 fma.rn.f32 %f833, %f826, %f215, %f830
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f833) : "f"(f826), "f"(f215), "f"(f830));
  // PTX:1174 ld.global.f32 %f834, [%rd285+8]
  f834 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd285) + (8)))));
  // PTX:1175 fma.rn.f32 %f835, %f834, %f219, %f831
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f835) : "f"(f834), "f"(f219), "f"(f831));
  // PTX:1176 fma.rn.f32 %f836, %f834, %f220, %f832
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f836) : "f"(f834), "f"(f220), "f"(f832));
  // PTX:1177 fma.rn.f32 %f837, %f834, %f221, %f833
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f837) : "f"(f834), "f"(f221), "f"(f833));
  // PTX:1178 ld.global.f32 %f838, [%rd285+12]
  f838 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd285) + (12)))));
  // PTX:1179 fma.rn.f32 %f228, %f838, %f222, %f835
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f228) : "f"(f838), "f"(f222), "f"(f835));
  // PTX:1180 fma.rn.f32 %f229, %f838, %f223, %f836
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f229) : "f"(f838), "f"(f223), "f"(f836));
  // PTX:1181 fma.rn.f32 %f230, %f838, %f224, %f837
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f230) : "f"(f838), "f"(f224), "f"(f837));
  // PTX:1182 sub.f32 %f231, %f1045, %f1048
  asm("sub.f32 %0, %1, %2;" : "=f"(f231) : "f"(f1045), "f"(f1048));
  // PTX:1183 sub.f32 %f232, %f1046, %f1049
  asm("sub.f32 %0, %1, %2;" : "=f"(f232) : "f"(f1046), "f"(f1049));
  // PTX:1184 mul.f32 %f839, %f232, %f232
  asm("mul.f32 %0, %1, %2;" : "=f"(f839) : "f"(f232), "f"(f232));
  // PTX:1185 sub.f32 %f233, %f1047, %f1050
  asm("sub.f32 %0, %1, %2;" : "=f"(f233) : "f"(f1047), "f"(f1050));
  // PTX:1186 fma.rn.f32 %f840, %f231, %f231, %f839
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f840) : "f"(f231), "f"(f231), "f"(f839));
  // PTX:1187 fma.rn.f32 %f841, %f233, %f233, %f840
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f841) : "f"(f233), "f"(f233), "f"(f840));
  // PTX:1188 sqrt.rn.f32 %f234, %f841
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f234) : "f"(f841));
  // PTX:1189 setp.leu.f32 %p44, %f234, 0f322BCC77
  p44 = ((isnan(((float)(f234))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f234)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:1190 @%p44 bra $L__BB69_74
  if (p44) { goto L_BB69_74; }
  // PTX:1192 abs.f32 %f842, %f234
  asm("abs.f32 %0, %1;" : "=f"(f842) : "f"(f234));
  // PTX:1193 setp.geu.f32 %p45, %f842, 0f7F800000
  p45 = ((isnan(((float)(f842))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f842)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1194 @%p45 bra $L__BB69_74
  if (p45) { goto L_BB69_74; }
  // PTX:1196 div.rn.f32 %f235, %f231, %f234
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f235) : "f"(f231), "f"(f234));
  // PTX:1197 mov.b32 %f843, %r110
  asm("mov.b32 %0, %1;" : "=f"(f843) : "r"(r110));
  // PTX:1198 sub.f32 %f844, %f843, %f1048
  asm("sub.f32 %0, %1, %2;" : "=f"(f844) : "f"(f843), "f"(f1048));
  // PTX:1199 mov.b32 %f845, %r111
  asm("mov.b32 %0, %1;" : "=f"(f845) : "r"(r111));
  // PTX:1200 sub.f32 %f846, %f845, %f1049
  asm("sub.f32 %0, %1, %2;" : "=f"(f846) : "f"(f845), "f"(f1049));
  // PTX:1201 mov.b32 %f847, %r112
  asm("mov.b32 %0, %1;" : "=f"(f847) : "r"(r112));
  // PTX:1202 sub.f32 %f848, %f847, %f1050
  asm("sub.f32 %0, %1, %2;" : "=f"(f848) : "f"(f847), "f"(f1050));
  // PTX:1203 div.rn.f32 %f236, %f232, %f234
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f236) : "f"(f232), "f"(f234));
  // PTX:1204 mul.f32 %f849, %f846, %f236
  asm("mul.f32 %0, %1, %2;" : "=f"(f849) : "f"(f846), "f"(f236));
  // PTX:1205 div.rn.f32 %f237, %f233, %f234
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f237) : "f"(f233), "f"(f234));
  // PTX:1206 fma.rn.f32 %f850, %f844, %f235, %f849
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f850) : "f"(f844), "f"(f235), "f"(f849));
  // PTX:1207 fma.rn.f32 %f851, %f848, %f237, %f850
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f851) : "f"(f848), "f"(f237), "f"(f850));
  // PTX:1208 mul.f32 %f852, %f235, %f851
  asm("mul.f32 %0, %1, %2;" : "=f"(f852) : "f"(f235), "f"(f851));
  // PTX:1209 mul.f32 %f853, %f236, %f851
  asm("mul.f32 %0, %1, %2;" : "=f"(f853) : "f"(f236), "f"(f851));
  // PTX:1210 mul.f32 %f854, %f237, %f851
  asm("mul.f32 %0, %1, %2;" : "=f"(f854) : "f"(f237), "f"(f851));
  // PTX:1211 sub.f32 %f238, %f844, %f852
  asm("sub.f32 %0, %1, %2;" : "=f"(f238) : "f"(f844), "f"(f852));
  // PTX:1212 sub.f32 %f239, %f846, %f853
  asm("sub.f32 %0, %1, %2;" : "=f"(f239) : "f"(f846), "f"(f853));
  // PTX:1213 sub.f32 %f240, %f848, %f854
  asm("sub.f32 %0, %1, %2;" : "=f"(f240) : "f"(f848), "f"(f854));
  // PTX:1214 sub.f32 %f855, %f228, %f225
  asm("sub.f32 %0, %1, %2;" : "=f"(f855) : "f"(f228), "f"(f225));
  // PTX:1215 sub.f32 %f856, %f229, %f226
  asm("sub.f32 %0, %1, %2;" : "=f"(f856) : "f"(f229), "f"(f226));
  // PTX:1216 mul.f32 %f857, %f856, %f236
  asm("mul.f32 %0, %1, %2;" : "=f"(f857) : "f"(f856), "f"(f236));
  // PTX:1217 sub.f32 %f858, %f230, %f227
  asm("sub.f32 %0, %1, %2;" : "=f"(f858) : "f"(f230), "f"(f227));
  // PTX:1218 fma.rn.f32 %f859, %f855, %f235, %f857
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f859) : "f"(f855), "f"(f235), "f"(f857));
  // PTX:1219 fma.rn.f32 %f860, %f237, %f858, %f859
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f860) : "f"(f237), "f"(f858), "f"(f859));
  // PTX:1220 mul.f32 %f861, %f235, %f860
  asm("mul.f32 %0, %1, %2;" : "=f"(f861) : "f"(f235), "f"(f860));
  // PTX:1221 mul.f32 %f862, %f236, %f860
  asm("mul.f32 %0, %1, %2;" : "=f"(f862) : "f"(f236), "f"(f860));
  // PTX:1222 mul.f32 %f863, %f237, %f860
  asm("mul.f32 %0, %1, %2;" : "=f"(f863) : "f"(f237), "f"(f860));
  // PTX:1223 sub.f32 %f241, %f855, %f861
  asm("sub.f32 %0, %1, %2;" : "=f"(f241) : "f"(f855), "f"(f861));
  // PTX:1224 sub.f32 %f242, %f856, %f862
  asm("sub.f32 %0, %1, %2;" : "=f"(f242) : "f"(f856), "f"(f862));
  // PTX:1225 sub.f32 %f243, %f858, %f863
  asm("sub.f32 %0, %1, %2;" : "=f"(f243) : "f"(f858), "f"(f863));
  // PTX:1226 mul.f32 %f864, %f239, %f239
  asm("mul.f32 %0, %1, %2;" : "=f"(f864) : "f"(f239), "f"(f239));
  // PTX:1227 fma.rn.f32 %f865, %f238, %f238, %f864
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f865) : "f"(f238), "f"(f238), "f"(f864));
  // PTX:1228 fma.rn.f32 %f866, %f240, %f240, %f865
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f866) : "f"(f240), "f"(f240), "f"(f865));
  // PTX:1229 sqrt.rn.f32 %f244, %f866
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f244) : "f"(f866));
  // PTX:1230 mul.f32 %f867, %f242, %f242
  asm("mul.f32 %0, %1, %2;" : "=f"(f867) : "f"(f242), "f"(f242));
  // PTX:1231 fma.rn.f32 %f868, %f241, %f241, %f867
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f868) : "f"(f241), "f"(f241), "f"(f867));
  // PTX:1232 fma.rn.f32 %f869, %f243, %f243, %f868
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f869) : "f"(f243), "f"(f243), "f"(f868));
  // PTX:1233 sqrt.rn.f32 %f245, %f869
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f245) : "f"(f869));
  // PTX:1234 setp.leu.f32 %p46, %f244, 0f322BCC77
  p46 = ((isnan(((float)(f244))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f244)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:1235 setp.leu.f32 %p47, %f245, 0f322BCC77
  p47 = ((isnan(((float)(f245))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f245)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:1236 or.pred %p48, %p46, %p47
  p48 = ((p46) || (p47));
  // PTX:1237 @%p48 bra $L__BB69_74
  if (p48) { goto L_BB69_74; }
  // PTX:1239 abs.f32 %f870, %f244
  asm("abs.f32 %0, %1;" : "=f"(f870) : "f"(f244));
  // PTX:1240 setp.geu.f32 %p49, %f870, 0f7F800000
  p49 = ((isnan(((float)(f870))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f870)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1241 @%p49 bra $L__BB69_74
  if (p49) { goto L_BB69_74; }
  // PTX:1243 abs.f32 %f871, %f245
  asm("abs.f32 %0, %1;" : "=f"(f871) : "f"(f245));
  // PTX:1244 setp.geu.f32 %p50, %f871, 0f7F800000
  p50 = ((isnan(((float)(f871))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f871)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1245 @%p50 bra $L__BB69_74
  if (p50) { goto L_BB69_74; }
  // PTX:1247 div.rn.f32 %f872, %f238, %f244
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f872) : "f"(f238), "f"(f244));
  // PTX:1248 div.rn.f32 %f873, %f243, %f245
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f873) : "f"(f243), "f"(f245));
  // PTX:1249 div.rn.f32 %f874, %f239, %f244
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f874) : "f"(f239), "f"(f244));
  // PTX:1250 mul.f32 %f875, %f874, %f873
  asm("mul.f32 %0, %1, %2;" : "=f"(f875) : "f"(f874), "f"(f873));
  // PTX:1251 div.rn.f32 %f876, %f242, %f245
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f876) : "f"(f242), "f"(f245));
  // PTX:1252 div.rn.f32 %f877, %f240, %f244
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f877) : "f"(f240), "f"(f244));
  // PTX:1253 mul.f32 %f878, %f877, %f876
  asm("mul.f32 %0, %1, %2;" : "=f"(f878) : "f"(f877), "f"(f876));
  // PTX:1254 sub.f32 %f879, %f875, %f878
  asm("sub.f32 %0, %1, %2;" : "=f"(f879) : "f"(f875), "f"(f878));
  // PTX:1255 div.rn.f32 %f880, %f241, %f245
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f880) : "f"(f241), "f"(f245));
  // PTX:1256 mul.f32 %f881, %f877, %f880
  asm("mul.f32 %0, %1, %2;" : "=f"(f881) : "f"(f877), "f"(f880));
  // PTX:1257 mul.f32 %f882, %f872, %f873
  asm("mul.f32 %0, %1, %2;" : "=f"(f882) : "f"(f872), "f"(f873));
  // PTX:1258 sub.f32 %f883, %f881, %f882
  asm("sub.f32 %0, %1, %2;" : "=f"(f883) : "f"(f881), "f"(f882));
  // PTX:1259 mul.f32 %f884, %f872, %f876
  asm("mul.f32 %0, %1, %2;" : "=f"(f884) : "f"(f872), "f"(f876));
  // PTX:1260 mul.f32 %f885, %f874, %f880
  asm("mul.f32 %0, %1, %2;" : "=f"(f885) : "f"(f874), "f"(f880));
  // PTX:1261 sub.f32 %f886, %f884, %f885
  asm("sub.f32 %0, %1, %2;" : "=f"(f886) : "f"(f884), "f"(f885));
  // PTX:1262 mul.f32 %f887, %f236, %f883
  asm("mul.f32 %0, %1, %2;" : "=f"(f887) : "f"(f236), "f"(f883));
  // PTX:1263 fma.rn.f32 %f888, %f235, %f879, %f887
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f888) : "f"(f235), "f"(f879), "f"(f887));
  // PTX:1264 fma.rn.f32 %f246, %f237, %f886, %f888
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f246) : "f"(f237), "f"(f886), "f"(f888));
  // PTX:1265 mul.f32 %f889, %f874, %f876
  asm("mul.f32 %0, %1, %2;" : "=f"(f889) : "f"(f874), "f"(f876));
  // PTX:1266 fma.rn.f32 %f890, %f872, %f880, %f889
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f890) : "f"(f872), "f"(f880), "f"(f889));
  // PTX:1267 fma.rn.f32 %f247, %f877, %f873, %f890
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f247) : "f"(f877), "f"(f873), "f"(f890));
  // PTX:1268 mul.f32 %f891, %f246, %f246
  asm("mul.f32 %0, %1, %2;" : "=f"(f891) : "f"(f246), "f"(f246));
  // PTX:1269 fma.rn.f32 %f248, %f247, %f247, %f891
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f248) : "f"(f247), "f"(f247), "f"(f891));
  // PTX:1270 setp.leu.f32 %p51, %f248, 0f2B8CBCCC
  p51 = ((isnan(((float)(f248))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) || (((float)(f248)) <= ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:1271 @%p51 bra $L__BB69_74
  if (p51) { goto L_BB69_74; }
  // PTX:1273 abs.f32 %f892, %f248
  asm("abs.f32 %0, %1;" : "=f"(f892) : "f"(f248));
  // PTX:1274 setp.geu.f32 %p52, %f892, 0f7F800000
  p52 = ((isnan(((float)(f892))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f892)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1275 @%p52 bra $L__BB69_74
  if (p52) { goto L_BB69_74; }
  // PTX:1277 abs.f32 %f249, %f247
  asm("abs.f32 %0, %1;" : "=f"(f249) : "f"(f247));
  // PTX:1278 setp.eq.f32 %p53, %f249, 0f00000000
  p53 = (!(isnan(((float)(f249))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f249)) == ((float)(as_f32(0x00000000u)))));
  // PTX:1279 abs.f32 %f250, %f246
  asm("abs.f32 %0, %1;" : "=f"(f250) : "f"(f246));
  // PTX:1280 setp.eq.f32 %p54, %f250, 0f00000000
  p54 = (!(isnan(((float)(f250))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f250)) == ((float)(as_f32(0x00000000u)))));
  // PTX:1281 and.pred %p55, %p53, %p54
  p55 = ((p53) && (p54));
  // PTX:1282 @%p55 bra $L__BB69_66
  if (p55) { goto L_BB69_66; }
  // PTX:1283 bra.uni $L__BB69_63
  goto L_BB69_63;
  // PTX:1285 $L__BB69_66:
L_BB69_66:;
  // PTX:1286 mov.b32 %r94, %f247
  asm("mov.b32 %0, %1;" : "=r"(r94) : "f"(f247));
  // PTX:1287 shr.s32 %r95, %r94, 31
  asm("shr.s32 %0, %1, 31;" : "=r"(r95) : "r"(r94));
  // PTX:1288 and.b32 %r96, %r95, 1078530011
  asm("and.b32 %0, %1, 1078530011;" : "=r"(r96) : "r"(r95));
  // PTX:1289 mov.b32 %r97, %f246
  asm("mov.b32 %0, %1;" : "=r"(r97) : "f"(f246));
  // PTX:1290 and.b32 %r98, %r97, -2147483648
  asm("and.b32 %0, %1, -2147483648;" : "=r"(r98) : "r"(r97));
  // PTX:1291 or.b32 %r99, %r98, %r96
  asm("or.b32 %0, %1, %2;" : "=r"(r99) : "r"(r98), "r"(r96));
  // PTX:1292 mov.b32 %f1051, %r99
  asm("mov.b32 %0, %1;" : "=f"(f1051) : "r"(r99));
  // PTX:1293 bra.uni $L__BB69_69
  goto L_BB69_69;
  // PTX:1295 $L__BB69_67:
L_BB69_67:;
  // PTX:1296 sub.f32 %f254, %f1045, %f1048
  asm("sub.f32 %0, %1, %2;" : "=f"(f254) : "f"(f1045), "f"(f1048));
  // PTX:1297 sub.f32 %f255, %f1046, %f1049
  asm("sub.f32 %0, %1, %2;" : "=f"(f255) : "f"(f1046), "f"(f1049));
  // PTX:1298 mul.f32 %f919, %f255, %f255
  asm("mul.f32 %0, %1, %2;" : "=f"(f919) : "f"(f255), "f"(f255));
  // PTX:1299 sub.f32 %f256, %f1047, %f1050
  asm("sub.f32 %0, %1, %2;" : "=f"(f256) : "f"(f1047), "f"(f1050));
  // PTX:1300 fma.rn.f32 %f920, %f254, %f254, %f919
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f920) : "f"(f254), "f"(f254), "f"(f919));
  // PTX:1301 fma.rn.f32 %f921, %f256, %f256, %f920
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f921) : "f"(f256), "f"(f256), "f"(f920));
  // PTX:1302 sqrt.rn.f32 %f257, %f921
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f257) : "f"(f921));
  // PTX:1303 setp.le.f32 %p63, %f257, 0f322BCC77
  p63 = (!(isnan(((float)(f257))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f257)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:1304 @%p63 bra $L__BB69_74
  if (p63) { goto L_BB69_74; }
  // PTX:1306 div.rn.f32 %f922, %f254, %f257
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f922) : "f"(f254), "f"(f257));
  // PTX:1307 sub.f32 %f923, %f225, %f1048
  asm("sub.f32 %0, %1, %2;" : "=f"(f923) : "f"(f225), "f"(f1048));
  // PTX:1308 sub.f32 %f924, %f226, %f1049
  asm("sub.f32 %0, %1, %2;" : "=f"(f924) : "f"(f226), "f"(f1049));
  // PTX:1309 div.rn.f32 %f925, %f255, %f257
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f925) : "f"(f255), "f"(f257));
  // PTX:1310 mul.f32 %f926, %f924, %f925
  asm("mul.f32 %0, %1, %2;" : "=f"(f926) : "f"(f924), "f"(f925));
  // PTX:1311 sub.f32 %f927, %f227, %f1050
  asm("sub.f32 %0, %1, %2;" : "=f"(f927) : "f"(f227), "f"(f1050));
  // PTX:1312 div.rn.f32 %f928, %f256, %f257
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f928) : "f"(f256), "f"(f257));
  // PTX:1313 fma.rn.f32 %f929, %f923, %f922, %f926
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f929) : "f"(f923), "f"(f922), "f"(f926));
  // PTX:1314 fma.rn.f32 %f1051, %f927, %f928, %f929
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1051) : "f"(f927), "f"(f928), "f"(f929));
  // PTX:1316 $L__BB69_69:
L_BB69_69:;
  // PTX:1317 ld.param.u64 %rd292, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_4]
  rd292 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:1318 ld.param.f32 %f988, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_5]
  f988 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param5 + (0))));
  // PTX:1319 mov.u32 %r106, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r106) : "r"(blockDim.x));
  // PTX:1320 mov.u32 %r105, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r105) : "r"(blockIdx.x));
  // PTX:1321 mov.u32 %r104, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r104) : "r"(threadIdx.x));
  // PTX:1322 cvt.u64.u32 %rd291, %r104
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd291) : "r"(r104));
  // PTX:1323 mul.wide.u32 %rd290, %r105, %r106
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd290) : "r"(r105), "r"(r106));
  // PTX:1324 add.s64 %rd289, %rd290, %rd291
  asm("add.s64 %0, %1, %2;" : "=l"(rd289) : "l"(rd290), "l"(rd291));
  // PTX:1325 cvta.to.global.u64 %rd224, %rd292
  rd224 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd292));
  // PTX:1326 shl.b64 %rd225, %rd289, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd225) : "l"(rd289));
  // PTX:1327 add.s64 %rd226, %rd224, %rd225
  asm("add.s64 %0, %1, %2;" : "=l"(rd226) : "l"(rd224), "l"(rd225));
  // PTX:1328 ld.global.f32 %f930, [%rd226]
  f930 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd226) + (0)))));
  // PTX:1329 div.rn.f32 %f931, %f930, %f988
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f931) : "f"(f930), "f"(f988));
  // PTX:1330 sub.f32 %f932, %f1036, %f1051
  asm("sub.f32 %0, %1, %2;" : "=f"(f932) : "f"(f1036), "f"(f1051));
  // PTX:1331 sub.f32 %f1052, %f931, %f932
  asm("sub.f32 %0, %1, %2;" : "=f"(f1052) : "f"(f931), "f"(f932));
  // PTX:1332 setp.ne.s32 %p64, %r15, 1
  p64 = (((int)(r15)) != ((int)(1)));
  // PTX:1333 @%p64 bra $L__BB69_71
  if (p64) { goto L_BB69_71; }
  // PTX:1335 div.rn.f32 %f933, %f1052, 0f40C90FDB
  asm("div.rn.f32 %0, %1, 0f40C90FDB;" : "=f"(f933) : "f"(f1052));
  // PTX:1336 mov.b32 %r100, %f933
  asm("mov.b32 %0, %1;" : "=r"(r100) : "f"(f933));
  // PTX:1337 and.b32 %r101, %r100, -2147483648
  asm("and.b32 %0, %1, -2147483648;" : "=r"(r101) : "r"(r100));
  // PTX:1338 or.b32 %r102, %r101, 1056964608
  asm("or.b32 %0, %1, 1056964608;" : "=r"(r102) : "r"(r101));
  // PTX:1339 mov.b32 %f934, %r102
  asm("mov.b32 %0, %1;" : "=f"(f934) : "r"(r102));
  // PTX:1340 add.rz.f32 %f935, %f933, %f934
  asm("add.rz.f32 %0, %1, %2;" : "=f"(f935) : "f"(f933), "f"(f934));
  // PTX:1341 cvt.rzi.f32.f32 %f936, %f935
  asm("cvt.rzi.f32.f32 %0, %1;" : "=f"(f936) : "f"(f935));
  // PTX:1342 mul.f32 %f937, %f936, 0f40C90FDB
  asm("mul.f32 %0, %1, 0f40C90FDB;" : "=f"(f937) : "f"(f936));
  // PTX:1343 sub.f32 %f1052, %f1052, %f937
  asm("sub.f32 %0, %1, %2;" : "=f"(f1052) : "f"(f1052), "f"(f937));
  // PTX:1344 bra.uni $L__BB69_71
  goto L_BB69_71;
  // PTX:1346 $L__BB69_74:
L_BB69_74:;
  // PTX:1347 ret
  return;
  // PTX:1349 $L__BB69_19:
L_BB69_19:;
  // PTX:1350 setp.eq.f32 %p19, %f78, 0f7F800000
  p19 = (!(isnan(((float)(f78))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f78)) == ((float)(as_f32(0x7F800000u)))));
  // PTX:1351 setp.eq.f32 %p20, %f79, 0f7F800000
  p20 = (!(isnan(((float)(f79))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f79)) == ((float)(as_f32(0x7F800000u)))));
  // PTX:1352 and.pred %p21, %p19, %p20
  p21 = ((p19) && (p20));
  // PTX:1353 @%p21 bra $L__BB69_21
  if (p21) { goto L_BB69_21; }
  // PTX:1354 bra.uni $L__BB69_20
  goto L_BB69_20;
  // PTX:1356 $L__BB69_21:
L_BB69_21:;
  // PTX:1357 mov.b32 %r51, %f70
  asm("mov.b32 %0, %1;" : "=r"(r51) : "f"(f70));
  // PTX:1358 setp.lt.s32 %p25, %r51, 0
  p25 = (((int)(r51)) < ((int)(0)));
  // PTX:1359 selp.b32 %r52, 1075235812, 1061752795, %p25
  r52 = p25 ? 1075235812 : 1061752795;
  // PTX:1360 mov.b32 %r53, %f69
  asm("mov.b32 %0, %1;" : "=r"(r53) : "f"(f69));
  // PTX:1361 and.b32 %r54, %r53, -2147483648
  asm("and.b32 %0, %1, -2147483648;" : "=r"(r54) : "r"(r53));
  // PTX:1362 or.b32 %r55, %r54, %r52
  asm("or.b32 %0, %1, %2;" : "=r"(r55) : "r"(r54), "r"(r52));
  // PTX:1363 mov.b32 %f1036, %r55
  asm("mov.b32 %0, %1;" : "=f"(f1036) : "r"(r55));
  // PTX:1364 bra.uni $L__BB69_23
  goto L_BB69_23;
  // PTX:1366 $L__BB69_20:
L_BB69_20:;
  // PTX:1367 max.f32 %f395, %f79, %f78
  asm("max.f32 %0, %1, %2;" : "=f"(f395) : "f"(f79), "f"(f78));
  // PTX:1368 min.f32 %f396, %f79, %f78
  asm("min.f32 %0, %1, %2;" : "=f"(f396) : "f"(f79), "f"(f78));
  // PTX:1369 div.rn.f32 %f397, %f396, %f395
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f397) : "f"(f396), "f"(f395));
  // PTX:1370 mul.rn.f32 %f398, %f397, %f397
  asm("mul.rn.f32 %0, %1, %2;" : "=f"(f398) : "f"(f397), "f"(f397));
  // PTX:1371 mov.f32 %f399, 0fC0B59883
  asm("mov.f32 %0, 0fC0B59883;" : "=f"(f399) : );
  // PTX:1372 mov.f32 %f400, 0fBF52C7EA
  asm("mov.f32 %0, 0fBF52C7EA;" : "=f"(f400) : );
  // PTX:1373 fma.rn.f32 %f401, %f398, %f400, %f399
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f401) : "f"(f398), "f"(f400), "f"(f399));
  // PTX:1374 mov.f32 %f402, 0fC0D21907
  asm("mov.f32 %0, 0fC0D21907;" : "=f"(f402) : );
  // PTX:1375 fma.rn.f32 %f403, %f401, %f398, %f402
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f403) : "f"(f401), "f"(f398), "f"(f402));
  // PTX:1376 mul.f32 %f404, %f398, %f403
  asm("mul.f32 %0, %1, %2;" : "=f"(f404) : "f"(f398), "f"(f403));
  // PTX:1377 mul.f32 %f405, %f397, %f404
  asm("mul.f32 %0, %1, %2;" : "=f"(f405) : "f"(f397), "f"(f404));
  // PTX:1378 add.f32 %f406, %f398, 0f41355DC0
  asm("add.f32 %0, %1, 0f41355DC0;" : "=f"(f406) : "f"(f398));
  // PTX:1379 mov.f32 %f407, 0f41E6BD60
  asm("mov.f32 %0, 0f41E6BD60;" : "=f"(f407) : );
  // PTX:1380 fma.rn.f32 %f408, %f406, %f398, %f407
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f408) : "f"(f406), "f"(f398), "f"(f407));
  // PTX:1381 mov.f32 %f409, 0f419D92C8
  asm("mov.f32 %0, 0f419D92C8;" : "=f"(f409) : );
  // PTX:1382 fma.rn.f32 %f410, %f408, %f398, %f409
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f410) : "f"(f408), "f"(f398), "f"(f409));
  // PTX:1383 rcp.rn.f32 %f411, %f410
  asm("rcp.rn.f32 %0, %1;" : "=f"(f411) : "f"(f410));
  // PTX:1384 fma.rn.f32 %f412, %f405, %f411, %f397
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f412) : "f"(f405), "f"(f411), "f"(f397));
  // PTX:1385 mov.f32 %f413, 0f3FC90FDB
  asm("mov.f32 %0, 0f3FC90FDB;" : "=f"(f413) : );
  // PTX:1386 sub.f32 %f414, %f413, %f412
  asm("sub.f32 %0, %1, %2;" : "=f"(f414) : "f"(f413), "f"(f412));
  // PTX:1387 setp.gt.f32 %p22, %f79, %f78
  p22 = (!(isnan(((float)(f79))) || isnan(((float)(f78)))) && (((float)(f79)) > ((float)(f78))));
  // PTX:1388 selp.f32 %f415, %f414, %f412, %p22
  f415 = p22 ? f414 : f412;
  // PTX:1389 mov.b32 %r46, %f70
  asm("mov.b32 %0, %1;" : "=r"(r46) : "f"(f70));
  // PTX:1390 setp.lt.s32 %p23, %r46, 0
  p23 = (((int)(r46)) < ((int)(0)));
  // PTX:1391 mov.f32 %f416, 0f40490FDB
  asm("mov.f32 %0, 0f40490FDB;" : "=f"(f416) : );
  // PTX:1392 sub.f32 %f417, %f416, %f415
  asm("sub.f32 %0, %1, %2;" : "=f"(f417) : "f"(f416), "f"(f415));
  // PTX:1393 selp.f32 %f418, %f417, %f415, %p23
  f418 = p23 ? f417 : f415;
  // PTX:1394 mov.b32 %r47, %f418
  asm("mov.b32 %0, %1;" : "=r"(r47) : "f"(f418));
  // PTX:1395 mov.b32 %r48, %f69
  asm("mov.b32 %0, %1;" : "=r"(r48) : "f"(f69));
  // PTX:1396 and.b32 %r49, %r48, -2147483648
  asm("and.b32 %0, %1, -2147483648;" : "=r"(r49) : "r"(r48));
  // PTX:1397 or.b32 %r50, %r49, %r47
  asm("or.b32 %0, %1, %2;" : "=r"(r50) : "r"(r49), "r"(r47));
  // PTX:1398 mov.b32 %f419, %r50
  asm("mov.b32 %0, %1;" : "=f"(f419) : "r"(r50));
  // PTX:1399 add.f32 %f420, %f78, %f79
  asm("add.f32 %0, %1, %2;" : "=f"(f420) : "f"(f78), "f"(f79));
  // PTX:1400 setp.le.f32 %p24, %f420, 0f7F800000
  p24 = (!(isnan(((float)(f420))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f420)) <= ((float)(as_f32(0x7F800000u)))));
  // PTX:1401 selp.f32 %f1036, %f419, %f420, %p24
  f1036 = p24 ? f419 : f420;
  // PTX:1403 $L__BB69_23:
L_BB69_23:;
  // PTX:1404 div.rn.f32 %f422, %f53, %f61
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f422) : "f"(f53), "f"(f61));
  // PTX:1405 div.rn.f32 %f423, %f57, %f62
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f423) : "f"(f57), "f"(f62));
  // PTX:1406 mul.f32 %f424, %f423, %f75
  asm("mul.f32 %0, %1, %2;" : "=f"(f424) : "f"(f423), "f"(f75));
  // PTX:1407 mul.f32 %f425, %f422, %f72
  asm("mul.f32 %0, %1, %2;" : "=f"(f425) : "f"(f422), "f"(f72));
  // PTX:1408 sub.f32 %f426, %f425, %f424
  asm("sub.f32 %0, %1, %2;" : "=f"(f426) : "f"(f425), "f"(f424));
  // PTX:1409 div.rn.f32 %f84, %f426, %f49
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f84) : "f"(f426), "f"(f49));
  // PTX:1410 mul.f32 %f427, %f423, %f76
  asm("mul.f32 %0, %1, %2;" : "=f"(f427) : "f"(f423), "f"(f76));
  // PTX:1411 mul.f32 %f428, %f422, %f73
  asm("mul.f32 %0, %1, %2;" : "=f"(f428) : "f"(f422), "f"(f73));
  // PTX:1412 sub.f32 %f429, %f428, %f427
  asm("sub.f32 %0, %1, %2;" : "=f"(f429) : "f"(f428), "f"(f427));
  // PTX:1413 div.rn.f32 %f85, %f429, %f49
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f85) : "f"(f429), "f"(f49));
  // PTX:1414 mul.f32 %f430, %f423, %f77
  asm("mul.f32 %0, %1, %2;" : "=f"(f430) : "f"(f423), "f"(f77));
  // PTX:1415 mul.f32 %f431, %f422, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f431) : "f"(f422), "f"(f74));
  // PTX:1416 sub.f32 %f432, %f431, %f430
  asm("sub.f32 %0, %1, %2;" : "=f"(f432) : "f"(f431), "f"(f430));
  // PTX:1417 div.rn.f32 %f86, %f432, %f49
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f86) : "f"(f432), "f"(f49));
  // PTX:1418 cvt.u32.u64 %r62, %rd14
  asm("cvt.u32.u64 %0, %1;" : "=r"(r62) : "l"(rd14));
  // PTX:1419 setp.lt.s32 %p26, %r62, 0
  p26 = (((int)(r62)) < ((int)(0)));
  // PTX:1420 neg.f32 %f433, %f75
  asm("neg.f32 %0, %1;" : "=f"(f433) : "f"(f75));
  // PTX:1421 div.rn.f32 %f434, %f433, %f62
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f434) : "f"(f433), "f"(f62));
  // PTX:1422 neg.f32 %f435, %f76
  asm("neg.f32 %0, %1;" : "=f"(f435) : "f"(f76));
  // PTX:1423 div.rn.f32 %f436, %f435, %f62
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f436) : "f"(f435), "f"(f62));
  // PTX:1424 neg.f32 %f437, %f77
  asm("neg.f32 %0, %1;" : "=f"(f437) : "f"(f77));
  // PTX:1425 div.rn.f32 %f438, %f437, %f62
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f438) : "f"(f437), "f"(f62));
  // PTX:1426 div.rn.f32 %f439, %f75, %f62
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f439) : "f"(f75), "f"(f62));
  // PTX:1427 mul.f32 %f440, %f439, %f39
  asm("mul.f32 %0, %1, %2;" : "=f"(f440) : "f"(f439), "f"(f39));
  // PTX:1428 div.rn.f32 %f441, %f76, %f62
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f441) : "f"(f76), "f"(f62));
  // PTX:1429 mul.f32 %f442, %f441, %f39
  asm("mul.f32 %0, %1, %2;" : "=f"(f442) : "f"(f441), "f"(f39));
  // PTX:1430 div.rn.f32 %f443, %f77, %f62
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f443) : "f"(f77), "f"(f62));
  // PTX:1431 mul.f32 %f444, %f443, %f39
  asm("mul.f32 %0, %1, %2;" : "=f"(f444) : "f"(f443), "f"(f39));
  // PTX:1432 fma.rn.f32 %f1031, %f434, %f21, %f440
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1031) : "f"(f434), "f"(f21), "f"(f440));
  // PTX:1433 fma.rn.f32 %f1030, %f436, %f21, %f442
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1030) : "f"(f436), "f"(f21), "f"(f442));
  // PTX:1434 fma.rn.f32 %f1029, %f438, %f21, %f444
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1029) : "f"(f438), "f"(f21), "f"(f444));
  // PTX:1435 mul.f32 %f445, %f439, %f40
  asm("mul.f32 %0, %1, %2;" : "=f"(f445) : "f"(f439), "f"(f40));
  // PTX:1436 mul.f32 %f446, %f441, %f40
  asm("mul.f32 %0, %1, %2;" : "=f"(f446) : "f"(f441), "f"(f40));
  // PTX:1437 mul.f32 %f447, %f443, %f40
  asm("mul.f32 %0, %1, %2;" : "=f"(f447) : "f"(f443), "f"(f40));
  // PTX:1438 fma.rn.f32 %f1028, %f434, %f25, %f445
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1028) : "f"(f434), "f"(f25), "f"(f445));
  // PTX:1439 fma.rn.f32 %f1027, %f436, %f25, %f446
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1027) : "f"(f436), "f"(f25), "f"(f446));
  // PTX:1440 fma.rn.f32 %f1026, %f438, %f25, %f447
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1026) : "f"(f438), "f"(f25), "f"(f447));
  // PTX:1441 mul.f32 %f448, %f439, %f41
  asm("mul.f32 %0, %1, %2;" : "=f"(f448) : "f"(f439), "f"(f41));
  // PTX:1442 mul.f32 %f449, %f441, %f41
  asm("mul.f32 %0, %1, %2;" : "=f"(f449) : "f"(f441), "f"(f41));
  // PTX:1443 mul.f32 %f450, %f443, %f41
  asm("mul.f32 %0, %1, %2;" : "=f"(f450) : "f"(f443), "f"(f41));
  // PTX:1444 fma.rn.f32 %f1025, %f434, %f29, %f448
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1025) : "f"(f434), "f"(f29), "f"(f448));
  // PTX:1445 fma.rn.f32 %f1024, %f436, %f29, %f449
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1024) : "f"(f436), "f"(f29), "f"(f449));
  // PTX:1446 fma.rn.f32 %f1023, %f438, %f29, %f450
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1023) : "f"(f438), "f"(f29), "f"(f450));
  // PTX:1447 mul.f32 %f451, %f439, %f42
  asm("mul.f32 %0, %1, %2;" : "=f"(f451) : "f"(f439), "f"(f42));
  // PTX:1448 mul.f32 %f452, %f441, %f42
  asm("mul.f32 %0, %1, %2;" : "=f"(f452) : "f"(f441), "f"(f42));
  // PTX:1449 mul.f32 %f453, %f443, %f42
  asm("mul.f32 %0, %1, %2;" : "=f"(f453) : "f"(f443), "f"(f42));
  // PTX:1450 fma.rn.f32 %f1022, %f434, %f33, %f451
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1022) : "f"(f434), "f"(f33), "f"(f451));
  // PTX:1451 fma.rn.f32 %f1021, %f436, %f33, %f452
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1021) : "f"(f436), "f"(f33), "f"(f452));
  // PTX:1452 fma.rn.f32 %f1020, %f438, %f33, %f453
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1020) : "f"(f438), "f"(f33), "f"(f453));
  // PTX:1453 div.rn.f32 %f99, %f72, %f61
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f99) : "f"(f72), "f"(f61));
  // PTX:1454 div.rn.f32 %f100, %f73, %f61
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f100) : "f"(f73), "f"(f61));
  // PTX:1455 div.rn.f32 %f101, %f74, %f61
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f101) : "f"(f74), "f"(f61));
  // PTX:1456 neg.f32 %f454, %f72
  asm("neg.f32 %0, %1;" : "=f"(f454) : "f"(f72));
  // PTX:1457 div.rn.f32 %f102, %f454, %f61
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f102) : "f"(f454), "f"(f61));
  // PTX:1458 neg.f32 %f455, %f73
  asm("neg.f32 %0, %1;" : "=f"(f455) : "f"(f73));
  // PTX:1459 div.rn.f32 %f103, %f455, %f61
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f103) : "f"(f455), "f"(f61));
  // PTX:1460 neg.f32 %f456, %f74
  asm("neg.f32 %0, %1;" : "=f"(f456) : "f"(f74));
  // PTX:1461 div.rn.f32 %f104, %f456, %f61
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f104) : "f"(f456), "f"(f61));
  // PTX:1462 @%p26 bra $L__BB69_34
  if (p26) { goto L_BB69_34; }
  // PTX:1464 shl.b64 %rd299, %rd10, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd299) : "l"(rd10));
  // PTX:1465 ld.param.u64 %rd298, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_0+64]
  rd298 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (64))));
  // PTX:1466 cvta.to.global.u64 %rd297, %rd298
  rd297 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd298));
  // PTX:1467 add.s64 %rd296, %rd297, %rd299
  asm("add.s64 %0, %1, %2;" : "=l"(rd296) : "l"(rd297), "l"(rd299));
  // PTX:1468 ld.param.u64 %rd295, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_0+48]
  rd295 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (48))));
  // PTX:1469 cvta.to.global.u64 %rd294, %rd295
  rd294 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd295));
  // PTX:1470 add.s64 %rd293, %rd294, %rd299
  asm("add.s64 %0, %1, %2;" : "=l"(rd293) : "l"(rd294), "l"(rd299));
  // PTX:1471 ld.param.u64 %rd266, [_ZN7synreal6kernel23evaluate_joint_armatureENS0_19JointCoordinateViewEPKfPKN3glm3vecILi3EfLNS4_9qualifierE0EEES9_S3_fS9_PS7_PNS4_3matILi3ELi3EfLS6_0EEE_param_0+72]
  rd266 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (72))));
  // PTX:1472 shl.b64 %rd265, %rd10, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd265) : "l"(rd10));
  // PTX:1473 cvta.to.global.u64 %rd264, %rd266
  rd264 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd266));
  // PTX:1474 add.s64 %rd263, %rd264, %rd265
  asm("add.s64 %0, %1, %2;" : "=l"(rd263) : "l"(rd264), "l"(rd265));
  // PTX:1475 sub.f32 %f457, %f99, %f84
  asm("sub.f32 %0, %1, %2;" : "=f"(f457) : "f"(f99), "f"(f84));
  // PTX:1476 sub.f32 %f458, %f100, %f85
  asm("sub.f32 %0, %1, %2;" : "=f"(f458) : "f"(f100), "f"(f85));
  // PTX:1477 sub.f32 %f459, %f101, %f86
  asm("sub.f32 %0, %1, %2;" : "=f"(f459) : "f"(f101), "f"(f86));
  // PTX:1478 ld.global.f32 %f460, [%rd293]
  f460 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd293) + (0)))));
  // PTX:1479 ld.global.f32 %f461, [%rd296]
  f461 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd296) + (0)))));
  // PTX:1480 mul.f32 %f462, %f84, %f461
  asm("mul.f32 %0, %1, %2;" : "=f"(f462) : "f"(f84), "f"(f461));
  // PTX:1481 mul.f32 %f463, %f85, %f461
  asm("mul.f32 %0, %1, %2;" : "=f"(f463) : "f"(f85), "f"(f461));
  // PTX:1482 mul.f32 %f464, %f86, %f461
  asm("mul.f32 %0, %1, %2;" : "=f"(f464) : "f"(f86), "f"(f461));
  // PTX:1483 fma.rn.f32 %f465, %f457, %f460, %f462
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f465) : "f"(f457), "f"(f460), "f"(f462));
  // PTX:1484 fma.rn.f32 %f466, %f458, %f460, %f463
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f466) : "f"(f458), "f"(f460), "f"(f463));
  // PTX:1485 fma.rn.f32 %f467, %f459, %f460, %f464
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f467) : "f"(f459), "f"(f460), "f"(f464));
  // PTX:1486 ld.global.f32 %f468, [%rd263]
  f468 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd263) + (0)))));
  // PTX:1487 fma.rn.f32 %f1019, %f102, %f468, %f465
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1019) : "f"(f102), "f"(f468), "f"(f465));
  // PTX:1488 fma.rn.f32 %f1018, %f103, %f468, %f466
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1018) : "f"(f103), "f"(f468), "f"(f466));
  // PTX:1489 fma.rn.f32 %f1017, %f104, %f468, %f467
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1017) : "f"(f104), "f"(f468), "f"(f467));
  // PTX:1490 ld.global.f32 %f469, [%rd293+4]
  f469 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd293) + (4)))));
  // PTX:1491 ld.global.f32 %f470, [%rd296+4]
  f470 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd296) + (4)))));
  // PTX:1492 mul.f32 %f471, %f84, %f470
  asm("mul.f32 %0, %1, %2;" : "=f"(f471) : "f"(f84), "f"(f470));
  // PTX:1493 mul.f32 %f472, %f85, %f470
  asm("mul.f32 %0, %1, %2;" : "=f"(f472) : "f"(f85), "f"(f470));
  // PTX:1494 mul.f32 %f473, %f86, %f470
  asm("mul.f32 %0, %1, %2;" : "=f"(f473) : "f"(f86), "f"(f470));
  // PTX:1495 fma.rn.f32 %f474, %f457, %f469, %f471
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f474) : "f"(f457), "f"(f469), "f"(f471));
  // PTX:1496 fma.rn.f32 %f475, %f458, %f469, %f472
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f475) : "f"(f458), "f"(f469), "f"(f472));
  // PTX:1497 fma.rn.f32 %f476, %f459, %f469, %f473
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f476) : "f"(f459), "f"(f469), "f"(f473));
  // PTX:1498 ld.global.f32 %f477, [%rd263+4]
  f477 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd263) + (4)))));
  // PTX:1499 fma.rn.f32 %f1032, %f102, %f477, %f474
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1032) : "f"(f102), "f"(f477), "f"(f474));
  // PTX:1500 fma.rn.f32 %f1033, %f103, %f477, %f475
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1033) : "f"(f103), "f"(f477), "f"(f475));
  // PTX:1501 fma.rn.f32 %f1034, %f104, %f477, %f476
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1034) : "f"(f104), "f"(f477), "f"(f476));
  // PTX:1502 ld.global.f32 %f478, [%rd293+8]
  f478 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd293) + (8)))));
  // PTX:1503 ld.global.f32 %f479, [%rd296+8]
  f479 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd296) + (8)))));
  // PTX:1504 mul.f32 %f480, %f84, %f479
  asm("mul.f32 %0, %1, %2;" : "=f"(f480) : "f"(f84), "f"(f479));
  // PTX:1505 mul.f32 %f481, %f85, %f479
  asm("mul.f32 %0, %1, %2;" : "=f"(f481) : "f"(f85), "f"(f479));
  // PTX:1506 mul.f32 %f482, %f86, %f479
  asm("mul.f32 %0, %1, %2;" : "=f"(f482) : "f"(f86), "f"(f479));
  // PTX:1507 fma.rn.f32 %f483, %f457, %f478, %f480
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f483) : "f"(f457), "f"(f478), "f"(f480));
  // PTX:1508 fma.rn.f32 %f484, %f458, %f478, %f481
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f484) : "f"(f458), "f"(f478), "f"(f481));
  // PTX:1509 fma.rn.f32 %f485, %f459, %f478, %f482
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f485) : "f"(f459), "f"(f478), "f"(f482));
  // PTX:1510 ld.global.f32 %f486, [%rd263+8]
  f486 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd263) + (8)))));
  // PTX:1511 fma.rn.f32 %f1035, %f102, %f486, %f483
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1035) : "f"(f102), "f"(f486), "f"(f483));
  // PTX:1512 fma.rn.f32 %f1037, %f103, %f486, %f484
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1037) : "f"(f103), "f"(f486), "f"(f484));
  // PTX:1513 fma.rn.f32 %f1038, %f104, %f486, %f485
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1038) : "f"(f104), "f"(f486), "f"(f485));
  // PTX:1514 ld.global.f32 %f487, [%rd293+12]
  f487 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd293) + (12)))));
  // PTX:1515 ld.global.f32 %f488, [%rd296+12]
  f488 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd296) + (12)))));
  // PTX:1516 mul.f32 %f489, %f84, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f489) : "f"(f84), "f"(f488));
  // PTX:1517 mul.f32 %f490, %f85, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f490) : "f"(f85), "f"(f488));
  // PTX:1518 mul.f32 %f491, %f86, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f491) : "f"(f86), "f"(f488));
  // PTX:1519 fma.rn.f32 %f492, %f457, %f487, %f489
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f492) : "f"(f457), "f"(f487), "f"(f489));
  // PTX:1520 fma.rn.f32 %f493, %f458, %f487, %f490
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f493) : "f"(f458), "f"(f487), "f"(f490));
  // PTX:1521 fma.rn.f32 %f494, %f459, %f487, %f491
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f494) : "f"(f459), "f"(f487), "f"(f491));
  // PTX:1522 ld.global.f32 %f495, [%rd263+12]
  f495 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd263) + (12)))));
  // PTX:1523 fma.rn.f32 %f1039, %f102, %f495, %f492
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1039) : "f"(f102), "f"(f495), "f"(f492));
  // PTX:1524 fma.rn.f32 %f1040, %f103, %f495, %f493
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1040) : "f"(f103), "f"(f495), "f"(f493));
  // PTX:1525 fma.rn.f32 %f1041, %f104, %f495, %f494
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1041) : "f"(f104), "f"(f495), "f"(f494));
  // PTX:1526 bra.uni $L__BB69_34
  goto L_BB69_34;
  // PTX:1528 $L__BB69_63:
L_BB69_63:;
  // PTX:1529 setp.eq.f32 %p56, %f249, 0f7F800000
  p56 = (!(isnan(((float)(f249))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f249)) == ((float)(as_f32(0x7F800000u)))));
  // PTX:1530 setp.eq.f32 %p57, %f250, 0f7F800000
  p57 = (!(isnan(((float)(f250))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f250)) == ((float)(as_f32(0x7F800000u)))));
  // PTX:1531 and.pred %p58, %p56, %p57
  p58 = ((p56) && (p57));
  // PTX:1532 @%p58 bra $L__BB69_65
  if (p58) { goto L_BB69_65; }
  // PTX:1533 bra.uni $L__BB69_64
  goto L_BB69_64;
  // PTX:1535 $L__BB69_65:
L_BB69_65:;
  // PTX:1536 mov.b32 %r89, %f247
  asm("mov.b32 %0, %1;" : "=r"(r89) : "f"(f247));
  // PTX:1537 setp.lt.s32 %p62, %r89, 0
  p62 = (((int)(r89)) < ((int)(0)));
  // PTX:1538 selp.b32 %r90, 1075235812, 1061752795, %p62
  r90 = p62 ? 1075235812 : 1061752795;
  // PTX:1539 mov.b32 %r91, %f246
  asm("mov.b32 %0, %1;" : "=r"(r91) : "f"(f246));
  // PTX:1540 and.b32 %r92, %r91, -2147483648
  asm("and.b32 %0, %1, -2147483648;" : "=r"(r92) : "r"(r91));
  // PTX:1541 or.b32 %r93, %r92, %r90
  asm("or.b32 %0, %1, %2;" : "=r"(r93) : "r"(r92), "r"(r90));
  // PTX:1542 mov.b32 %f1051, %r93
  asm("mov.b32 %0, %1;" : "=f"(f1051) : "r"(r93));
  // PTX:1543 bra.uni $L__BB69_69
  goto L_BB69_69;
  // PTX:1545 $L__BB69_64:
L_BB69_64:;
  // PTX:1546 max.f32 %f893, %f250, %f249
  asm("max.f32 %0, %1, %2;" : "=f"(f893) : "f"(f250), "f"(f249));
  // PTX:1547 min.f32 %f894, %f250, %f249
  asm("min.f32 %0, %1, %2;" : "=f"(f894) : "f"(f250), "f"(f249));
  // PTX:1548 div.rn.f32 %f895, %f894, %f893
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f895) : "f"(f894), "f"(f893));
  // PTX:1549 mul.rn.f32 %f896, %f895, %f895
  asm("mul.rn.f32 %0, %1, %2;" : "=f"(f896) : "f"(f895), "f"(f895));
  // PTX:1550 mov.f32 %f897, 0fC0B59883
  asm("mov.f32 %0, 0fC0B59883;" : "=f"(f897) : );
  // PTX:1551 mov.f32 %f898, 0fBF52C7EA
  asm("mov.f32 %0, 0fBF52C7EA;" : "=f"(f898) : );
  // PTX:1552 fma.rn.f32 %f899, %f896, %f898, %f897
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f899) : "f"(f896), "f"(f898), "f"(f897));
  // PTX:1553 mov.f32 %f900, 0fC0D21907
  asm("mov.f32 %0, 0fC0D21907;" : "=f"(f900) : );
  // PTX:1554 fma.rn.f32 %f901, %f899, %f896, %f900
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f901) : "f"(f899), "f"(f896), "f"(f900));
  // PTX:1555 mul.f32 %f902, %f896, %f901
  asm("mul.f32 %0, %1, %2;" : "=f"(f902) : "f"(f896), "f"(f901));
  // PTX:1556 mul.f32 %f903, %f895, %f902
  asm("mul.f32 %0, %1, %2;" : "=f"(f903) : "f"(f895), "f"(f902));
  // PTX:1557 add.f32 %f904, %f896, 0f41355DC0
  asm("add.f32 %0, %1, 0f41355DC0;" : "=f"(f904) : "f"(f896));
  // PTX:1558 mov.f32 %f905, 0f41E6BD60
  asm("mov.f32 %0, 0f41E6BD60;" : "=f"(f905) : );
  // PTX:1559 fma.rn.f32 %f906, %f904, %f896, %f905
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f906) : "f"(f904), "f"(f896), "f"(f905));
  // PTX:1560 mov.f32 %f907, 0f419D92C8
  asm("mov.f32 %0, 0f419D92C8;" : "=f"(f907) : );
  // PTX:1561 fma.rn.f32 %f908, %f906, %f896, %f907
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f908) : "f"(f906), "f"(f896), "f"(f907));
  // PTX:1562 rcp.rn.f32 %f909, %f908
  asm("rcp.rn.f32 %0, %1;" : "=f"(f909) : "f"(f908));
  // PTX:1563 fma.rn.f32 %f910, %f903, %f909, %f895
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f910) : "f"(f903), "f"(f909), "f"(f895));
  // PTX:1564 mov.f32 %f911, 0f3FC90FDB
  asm("mov.f32 %0, 0f3FC90FDB;" : "=f"(f911) : );
  // PTX:1565 sub.f32 %f912, %f911, %f910
  asm("sub.f32 %0, %1, %2;" : "=f"(f912) : "f"(f911), "f"(f910));
  // PTX:1566 setp.gt.f32 %p59, %f250, %f249
  p59 = (!(isnan(((float)(f250))) || isnan(((float)(f249)))) && (((float)(f250)) > ((float)(f249))));
  // PTX:1567 selp.f32 %f913, %f912, %f910, %p59
  f913 = p59 ? f912 : f910;
  // PTX:1568 mov.b32 %r84, %f247
  asm("mov.b32 %0, %1;" : "=r"(r84) : "f"(f247));
  // PTX:1569 setp.lt.s32 %p60, %r84, 0
  p60 = (((int)(r84)) < ((int)(0)));
  // PTX:1570 mov.f32 %f914, 0f40490FDB
  asm("mov.f32 %0, 0f40490FDB;" : "=f"(f914) : );
  // PTX:1571 sub.f32 %f915, %f914, %f913
  asm("sub.f32 %0, %1, %2;" : "=f"(f915) : "f"(f914), "f"(f913));
  // PTX:1572 selp.f32 %f916, %f915, %f913, %p60
  f916 = p60 ? f915 : f913;
  // PTX:1573 mov.b32 %r85, %f916
  asm("mov.b32 %0, %1;" : "=r"(r85) : "f"(f916));
  // PTX:1574 mov.b32 %r86, %f246
  asm("mov.b32 %0, %1;" : "=r"(r86) : "f"(f246));
  // PTX:1575 and.b32 %r87, %r86, -2147483648
  asm("and.b32 %0, %1, -2147483648;" : "=r"(r87) : "r"(r86));
  // PTX:1576 or.b32 %r88, %r87, %r85
  asm("or.b32 %0, %1, %2;" : "=r"(r88) : "r"(r87), "r"(r85));
  // PTX:1577 mov.b32 %f917, %r88
  asm("mov.b32 %0, %1;" : "=f"(f917) : "r"(r88));
  // PTX:1578 add.f32 %f918, %f249, %f250
  asm("add.f32 %0, %1, %2;" : "=f"(f918) : "f"(f249), "f"(f250));
  // PTX:1579 setp.le.f32 %p61, %f918, 0f7F800000
  p61 = (!(isnan(((float)(f918))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f918)) <= ((float)(as_f32(0x7F800000u)))));
  // PTX:1580 selp.f32 %f1051, %f917, %f918, %p61
  f1051 = p61 ? f917 : f918;
  // PTX:1581 bra.uni $L__BB69_69
  goto L_BB69_69;
}
