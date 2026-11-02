// 机械还原自 PTX：synreal::kernel::evaluate_joint_drive_load(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float*, int*, glm::vec<4, int, (glm::qualifier)0> const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, int const*, int const*, float const*, float const*, float const*, int const*, float const*, float const*, float const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, float)
// PTX SHA256: 362dccb2d046e72a5d7777d61110332444dee513c5424539ff75e7296a6619b5
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__evaluate_joint_drive_load(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10, unsigned long long param11, unsigned long long param12, unsigned long long param13, unsigned long long param14, unsigned long long param15, unsigned long long param16, unsigned long long param17, unsigned long long param18, unsigned long long param19, unsigned long long param20, unsigned long long param21, unsigned long long param22, unsigned long long param23, unsigned long long param24, unsigned long long param25, unsigned long long param26, unsigned long long param27, unsigned long long param28, unsigned long long param29, unsigned long long param30, unsigned long long param31, float param32) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57, p58, p59, p60, p61, p62, p63, p64, p65, p66, p67, p68, p69, p70, p71, p72, p73, p74, p75;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440, f441, f442, f443, f444, f445, f446, f447, f448, f449, f450, f451, f452, f453, f454, f455, f456, f457, f458, f459, f460, f461, f462, f463, f464, f465, f466, f467, f468, f469, f470, f471, f472, f473, f474, f475, f476, f477, f478, f479, f480, f481, f482, f483, f484, f485, f486, f487, f488, f489, f490, f491, f492, f493, f494, f495, f496, f497, f498, f499, f500, f501, f502, f503, f504, f505, f506, f507, f508, f509, f510, f511, f512, f513, f514, f515, f516, f517, f518, f519, f520, f521, f522, f523, f524, f525, f526, f527, f528, f529, f530, f531, f532, f533, f534, f535, f536, f537, f538, f539, f540, f541, f542, f543, f544, f545, f546, f547, f548, f549, f550, f551, f552, f553, f554, f555, f556, f557, f558, f559, f560, f561, f562, f563, f564, f565, f566, f567, f568, f569, f570, f571, f572, f573, f574, f575, f576, f577, f578, f579, f580, f581, f582, f583, f584, f585, f586, f587, f588, f589, f590, f591, f592, f593, f594, f595, f596, f597, f598, f599, f600, f601, f602, f603, f604, f605, f606, f607, f608, f609, f610, f611, f612, f613, f614, f615, f616, f617, f618, f619, f620, f621, f622, f623, f624, f625, f626, f627, f628, f629, f630, f631, f632, f633, f634, f635, f636, f637, f638, f639, f640, f641, f642, f643, f644, f645, f646, f647, f648, f649, f650, f651, f652, f653, f654, f655, f656, f657, f658, f659, f660, f661, f662, f663, f664, f665, f666, f667, f668, f669, f670, f671, f672, f673, f674, f675, f676, f677, f678, f679, f680, f681, f682, f683, f684, f685, f686, f687, f688, f689, f690, f691, f692, f693, f694, f695, f696, f697, f698, f699, f700, f701, f702, f703, f704, f705, f706, f707, f708, f709, f710, f711, f712, f713, f714, f715, f716, f717, f718, f719, f720, f721, f722, f723, f724, f725, f726, f727, f728, f729, f730, f731, f732, f733, f734, f735, f736, f737, f738, f739, f740, f741, f742, f743, f744, f745, f746, f747, f748, f749, f750, f751, f752, f753, f754, f755, f756, f757, f758, f759, f760, f761, f762, f763, f764, f765, f766, f767, f768, f769, f770, f771, f772, f773, f774, f775, f776, f777, f778, f779, f780, f781, f782, f783, f784, f785, f786, f787, f788, f789, f790, f791, f792, f793, f794, f795, f796, f797, f798, f799, f800, f801, f802, f803, f804, f805, f806, f807, f808, f809, f810, f811, f812, f813, f814, f815, f816, f817, f818, f819, f820, f821, f822, f823, f824, f825, f826, f827, f828, f829, f830, f831, f832, f833, f834, f835, f836, f837, f838, f839, f840, f841, f842, f843, f844, f845, f846, f847, f848, f849, f850, f851, f852, f853, f854, f855, f856, f857, f858, f859, f860, f861, f862, f863, f864, f865, f866, f867, f868, f869, f870, f871, f872, f873, f874, f875, f876, f877, f878, f879, f880, f881, f882, f883, f884, f885, f886, f887, f888, f889, f890, f891, f892, f893, f894, f895, f896, f897, f898, f899, f900, f901, f902, f903, f904, f905, f906, f907, f908, f909, f910, f911, f912, f913, f914, f915, f916, f917, f918, f919, f920, f921, f922, f923, f924, f925, f926, f927, f928, f929, f930, f931, f932, f933, f934, f935, f936, f937, f938, f939, f940, f941, f942, f943, f944, f945, f946, f947, f948, f949, f950;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121, r122, r123, r124, r125, r126, r127, r128, r129, r130, r131, r132, r133, r134, r135, r136, r137, r138, r139, r140, r141, r142, r143, r144, r145, r146, r147, r148, r149, r150, r151, r152, r153, r154, r155, r156, r157, r158, r159, r160, r161, r162, r163, r164, r165, r166, r167, r168, r169, r170, r171, r172, r173, r174, r175, r176, r177, r178, r179;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135, rd136, rd137, rd138, rd139, rd140, rd141, rd142, rd143, rd144, rd145, rd146, rd147, rd148, rd149, rd150, rd151, rd152, rd153, rd154, rd155, rd156, rd157, rd158, rd159, rd160, rd161, rd162, rd163, rd164, rd165, rd166, rd167, rd168, rd169, rd170, rd171, rd172, rd173, rd174, rd175, rd176, rd177, rd178, rd179, rd180, rd181, rd182, rd183, rd184, rd185, rd186, rd187, rd188, rd189, rd190, rd191, rd192, rd193, rd194, rd195, rd196, rd197, rd198, rd199, rd200, rd201, rd202, rd203, rd204, rd205, rd206, rd207, rd208, rd209, rd210, rd211, rd212, rd213, rd214, rd215, rd216, rd217, rd218, rd219, rd220, rd221, rd222, rd223, rd224, rd225, rd226, rd227, rd228, rd229, rd230, rd231, rd232, rd233, rd234, rd235, rd236, rd237, rd238, rd239, rd240, rd241, rd242, rd243, rd244, rd245, rd246, rd247, rd248, rd249, rd250, rd251, rd252, rd253, rd254, rd255, rd256, rd257, rd258, rd259, rd260, rd261, rd262, rd263, rd264, rd265, rd266, rd267, rd268, rd269, rd270, rd271, rd272, rd273, rd274, rd275, rd276, rd277, rd278, rd279, rd280, rd281, rd282, rd283, rd284, rd285, rd286, rd287, rd288, rd289, rd290, rd291, rd292, rd293, rd294, rd295, rd296, rd297, rd298, rd299, rd300, rd301, rd302, rd303, rd304, rd305, rd306, rd307, rd308, rd309, rd310, rd311, rd312, rd313, rd314, rd315, rd316, rd317, rd318, rd319, rd320, rd321, rd322, rd323, rd324, rd325, rd326, rd327, rd328, rd329, rd330, rd331, rd332, rd333, rd334, rd335;
  // PTX:49 ld.param.u64 %rd61, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_0]
  rd61 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:50 ld.param.u64 %rd63, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_5]
  rd63 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:51 ld.param.u64 %rd43, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_11]
  rd43 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:52 ld.param.u64 %rd44, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_12]
  rd44 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:53 ld.param.u64 %rd45, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_13]
  rd45 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:54 ld.param.u64 %rd46, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_14]
  rd46 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:55 ld.param.u64 %rd66, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_27]
  rd66 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param27 + (0))));
  // PTX:56 ld.param.u64 %rd57, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_28]
  rd57 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param28 + (0))));
  // PTX:57 cvta.to.global.u64 %rd5, %rd61
  rd5 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd61));
  // PTX:58 cvta.to.global.u64 %rd6, %rd63
  rd6 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd63));
  // PTX:59 mov.u32 %r63, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r63) : "r"(blockIdx.x));
  // PTX:60 mov.u32 %r64, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r64) : "r"(blockDim.x));
  // PTX:61 mul.wide.u32 %rd67, %r63, %r64
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd67) : "r"(r63), "r"(r64));
  // PTX:62 mov.u32 %r65, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r65) : "r"(threadIdx.x));
  // PTX:63 cvt.u64.u32 %rd68, %r65
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd68) : "r"(r65));
  // PTX:64 add.s64 %rd7, %rd67, %rd68
  asm("add.s64 %0, %1, %2;" : "=l"(rd7) : "l"(rd67), "l"(rd68));
  // PTX:65 setp.ge.u64 %p1, %rd7, %rd66
  p1 = (((unsigned long long)(rd7)) >= ((unsigned long long)(rd66)));
  // PTX:66 @%p1 bra $L__BB29_80
  if (p1) { goto L_BB29_80; }
  // PTX:68 or.b64 %rd69, %rd7, %rd57
  asm("or.b64 %0, %1, %2;" : "=l"(rd69) : "l"(rd7), "l"(rd57));
  // PTX:69 and.b64 %rd70, %rd69, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd70) : "l"(rd69));
  // PTX:70 setp.eq.s64 %p2, %rd70, 0
  p2 = (((long long)(rd70)) == ((long long)(0)));
  // PTX:71 @%p2 bra $L__BB29_3
  if (p2) { goto L_BB29_3; }
  // PTX:73 div.u64 %rd334, %rd7, %rd57
  asm("div.u64 %0, %1, %2;" : "=l"(rd334) : "l"(rd7), "l"(rd57));
  // PTX:74 mul.lo.s64 %rd71, %rd334, %rd57
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd71) : "l"(rd334), "l"(rd57));
  // PTX:75 sub.s64 %rd335, %rd7, %rd71
  asm("sub.s64 %0, %1, %2;" : "=l"(rd335) : "l"(rd7), "l"(rd71));
  // PTX:76 bra.uni $L__BB29_4
  goto L_BB29_4;
  // PTX:78 $L__BB29_3:
L_BB29_3:;
  // PTX:79 cvt.u32.u64 %r66, %rd57
  asm("cvt.u32.u64 %0, %1;" : "=r"(r66) : "l"(rd57));
  // PTX:80 cvt.u32.u64 %r67, %rd7
  asm("cvt.u32.u64 %0, %1;" : "=r"(r67) : "l"(rd7));
  // PTX:81 div.u32 %r68, %r67, %r66
  asm("div.u32 %0, %1, %2;" : "=r"(r68) : "r"(r67), "r"(r66));
  // PTX:82 mul.lo.s32 %r69, %r68, %r66
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r69) : "r"(r68), "r"(r66));
  // PTX:83 sub.s32 %r70, %r67, %r69
  asm("sub.s32 %0, %1, %2;" : "=r"(r70) : "r"(r67), "r"(r69));
  // PTX:84 cvt.u64.u32 %rd334, %r68
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd334) : "r"(r68));
  // PTX:85 cvt.u64.u32 %rd335, %r70
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd335) : "r"(r70));
  // PTX:87 $L__BB29_4:
L_BB29_4:;
  // PTX:88 ld.param.u64 %rd333, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_29]
  rd333 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param29 + (0))));
  // PTX:89 ld.param.u64 %rd332, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_10]
  rd332 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:90 ld.param.u64 %rd331, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_9]
  rd331 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:91 ld.param.u64 %rd330, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_8]
  rd330 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:92 ld.param.u64 %rd329, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_7]
  rd329 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:93 mul.lo.s64 %rd72, %rd334, %rd333
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd72) : "l"(rd334), "l"(rd333));
  // PTX:94 cvt.u32.u64 %r1, %rd72
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd72));
  // PTX:95 cvta.to.global.u64 %rd73, %rd329
  rd73 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd329));
  // PTX:96 shl.b64 %rd74, %rd335, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd74) : "l"(rd335));
  // PTX:97 add.s64 %rd75, %rd73, %rd74
  asm("add.s64 %0, %1, %2;" : "=l"(rd75) : "l"(rd73), "l"(rd74));
  // PTX:98 ld.global.s32 %rd14, [%rd75]
  rd14 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (0)))));
  // PTX:99 ld.global.u32 %r75, [%rd75+4]
  r75 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (4)))));
  // PTX:100 mul.wide.s32 %rd76, %r75, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd76) : "r"(r75));
  // PTX:101 add.s64 %rd77, %rd6, %rd76
  asm("add.s64 %0, %1, %2;" : "=l"(rd77) : "l"(rd6), "l"(rd76));
  // PTX:102 ld.global.u32 %r2, [%rd77]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (0)))));
  // PTX:103 ld.global.u32 %r3, [%rd77+4]
  r3 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (4)))));
  // PTX:104 ld.global.u32 %r4, [%rd77+8]
  r4 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (8)))));
  // PTX:105 ld.global.u32 %r5, [%rd77+12]
  r5 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (12)))));
  // PTX:106 cvta.to.global.u64 %rd78, %rd330
  rd78 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd330));
  // PTX:107 mul.lo.s64 %rd79, %rd335, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd79) : "l"(rd335));
  // PTX:108 add.s64 %rd80, %rd78, %rd79
  asm("add.s64 %0, %1, %2;" : "=l"(rd80) : "l"(rd78), "l"(rd79));
  // PTX:109 cvta.to.global.u64 %rd81, %rd331
  rd81 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd331));
  // PTX:110 add.s64 %rd82, %rd81, %rd79
  asm("add.s64 %0, %1, %2;" : "=l"(rd82) : "l"(rd81), "l"(rd79));
  // PTX:111 cvta.to.global.u64 %rd83, %rd332
  rd83 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd332));
  // PTX:112 add.s64 %rd84, %rd83, %rd79
  asm("add.s64 %0, %1, %2;" : "=l"(rd84) : "l"(rd83), "l"(rd79));
  // PTX:113 ld.global.u32 %r168, [%rd84+8]
  r168 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (8)))));
  // PTX:114 ld.global.u32 %r167, [%rd84+4]
  r167 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (4)))));
  // PTX:115 ld.global.u32 %r166, [%rd84]
  r166 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (0)))));
  // PTX:116 setp.lt.s64 %p3, %rd14, 0
  p3 = (((long long)(rd14)) < ((long long)(0)));
  // PTX:117 ld.global.f32 %f927, [%rd80]
  f927 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (0)))));
  // PTX:118 ld.global.f32 %f928, [%rd80+4]
  f928 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (4)))));
  // PTX:119 ld.global.f32 %f929, [%rd80+8]
  f929 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (8)))));
  // PTX:120 ld.global.f32 %f930, [%rd82]
  f930 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (0)))));
  // PTX:121 ld.global.f32 %f931, [%rd82+4]
  f931 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (4)))));
  // PTX:122 ld.global.f32 %f932, [%rd82+8]
  f932 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (8)))));
  // PTX:123 cvta.to.global.u64 %rd85, %rd43
  rd85 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd43));
  // PTX:124 shl.b64 %rd86, %rd335, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd86) : "l"(rd335));
  // PTX:125 add.s64 %rd15, %rd85, %rd86
  asm("add.s64 %0, %1, %2;" : "=l"(rd15) : "l"(rd85), "l"(rd86));
  // PTX:126 cvta.to.global.u64 %rd87, %rd45
  rd87 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd45));
  // PTX:127 add.s64 %rd16, %rd87, %rd86
  asm("add.s64 %0, %1, %2;" : "=l"(rd16) : "l"(rd87), "l"(rd86));
  // PTX:128 cvta.to.global.u64 %rd88, %rd46
  rd88 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd46));
  // PTX:129 add.s64 %rd17, %rd88, %rd86
  asm("add.s64 %0, %1, %2;" : "=l"(rd17) : "l"(rd88), "l"(rd86));
  // PTX:130 mov.u32 %r150, 0
  asm("mov.u32 %0, 0;" : "=r"(r150) : );
  // PTX:131 mov.f32 %f920, %f930
  asm("mov.f32 %0, %1;" : "=f"(f920) : "f"(f930));
  // PTX:132 mov.f32 %f921, %f931
  asm("mov.f32 %0, %1;" : "=f"(f921) : "f"(f931));
  // PTX:133 mov.f32 %f922, %f932
  asm("mov.f32 %0, %1;" : "=f"(f922) : "f"(f932));
  // PTX:134 mov.f32 %f923, %f927
  asm("mov.f32 %0, %1;" : "=f"(f923) : "f"(f927));
  // PTX:135 mov.f32 %f924, %f928
  asm("mov.f32 %0, %1;" : "=f"(f924) : "f"(f928));
  // PTX:136 mov.f32 %f925, %f929
  asm("mov.f32 %0, %1;" : "=f"(f925) : "f"(f929));
  // PTX:137 mov.u32 %r151, %r150
  asm("mov.u32 %0, %1;" : "=r"(r151) : "r"(r150));
  // PTX:138 mov.u32 %r152, %r150
  asm("mov.u32 %0, %1;" : "=r"(r152) : "r"(r150));
  // PTX:139 mov.u32 %r153, %r150
  asm("mov.u32 %0, %1;" : "=r"(r153) : "r"(r150));
  // PTX:140 mov.u32 %r154, %r166
  asm("mov.u32 %0, %1;" : "=r"(r154) : "r"(r166));
  // PTX:141 mov.u32 %r155, %r167
  asm("mov.u32 %0, %1;" : "=r"(r155) : "r"(r167));
  // PTX:142 mov.u32 %r156, %r168
  asm("mov.u32 %0, %1;" : "=r"(r156) : "r"(r168));
  // PTX:143 @%p3 bra $L__BB29_6
  if (p3) { goto L_BB29_6; }
  // PTX:145 shl.b64 %rd89, %rd14, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd89) : "l"(rd14));
  // PTX:146 add.s64 %rd90, %rd6, %rd89
  asm("add.s64 %0, %1, %2;" : "=l"(rd90) : "l"(rd6), "l"(rd89));
  // PTX:147 ld.global.u32 %r76, [%rd90]
  r76 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (0)))));
  // PTX:148 ld.global.u32 %r77, [%rd90+4]
  r77 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (4)))));
  // PTX:149 ld.global.u32 %r78, [%rd90+8]
  r78 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (8)))));
  // PTX:150 ld.global.u32 %r79, [%rd90+12]
  r79 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (12)))));
  // PTX:151 add.s32 %r153, %r79, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r153) : "r"(r79), "r"(r1));
  // PTX:152 add.s32 %r152, %r78, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r152) : "r"(r78), "r"(r1));
  // PTX:153 add.s32 %r151, %r77, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r151) : "r"(r77), "r"(r1));
  // PTX:154 add.s32 %r150, %r76, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r150) : "r"(r76), "r"(r1));
  // PTX:155 mul.wide.s32 %rd91, %r150, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd91) : "r"(r150));
  // PTX:156 add.s64 %rd92, %rd5, %rd91
  asm("add.s64 %0, %1, %2;" : "=l"(rd92) : "l"(rd5), "l"(rd91));
  // PTX:157 ld.global.f32 %f198, [%rd92]
  f198 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (0)))));
  // PTX:158 ld.global.f32 %f199, [%rd15]
  f199 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))));
  // PTX:159 ld.global.f32 %f200, [%rd92+4]
  f200 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (4)))));
  // PTX:160 ld.global.f32 %f201, [%rd92+8]
  f201 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (8)))));
  // PTX:161 mul.wide.s32 %rd93, %r151, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd93) : "r"(r151));
  // PTX:162 add.s64 %rd94, %rd5, %rd93
  asm("add.s64 %0, %1, %2;" : "=l"(rd94) : "l"(rd5), "l"(rd93));
  // PTX:163 ld.global.f32 %f202, [%rd94]
  f202 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd94) + (0)))));
  // PTX:164 ld.global.f32 %f203, [%rd15+4]
  f203 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (4)))));
  // PTX:165 mul.f32 %f204, %f203, %f202
  asm("mul.f32 %0, %1, %2;" : "=f"(f204) : "f"(f203), "f"(f202));
  // PTX:166 ld.global.f32 %f205, [%rd94+4]
  f205 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd94) + (4)))));
  // PTX:167 mul.f32 %f206, %f203, %f205
  asm("mul.f32 %0, %1, %2;" : "=f"(f206) : "f"(f203), "f"(f205));
  // PTX:168 ld.global.f32 %f207, [%rd94+8]
  f207 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd94) + (8)))));
  // PTX:169 mul.f32 %f208, %f203, %f207
  asm("mul.f32 %0, %1, %2;" : "=f"(f208) : "f"(f203), "f"(f207));
  // PTX:170 fma.rn.f32 %f209, %f199, %f198, %f204
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f209) : "f"(f199), "f"(f198), "f"(f204));
  // PTX:171 fma.rn.f32 %f210, %f199, %f200, %f206
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f210) : "f"(f199), "f"(f200), "f"(f206));
  // PTX:172 fma.rn.f32 %f211, %f199, %f201, %f208
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f211) : "f"(f199), "f"(f201), "f"(f208));
  // PTX:173 mul.wide.s32 %rd95, %r152, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd95) : "r"(r152));
  // PTX:174 add.s64 %rd96, %rd5, %rd95
  asm("add.s64 %0, %1, %2;" : "=l"(rd96) : "l"(rd5), "l"(rd95));
  // PTX:175 ld.global.f32 %f212, [%rd96]
  f212 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (0)))));
  // PTX:176 ld.global.f32 %f213, [%rd15+8]
  f213 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (8)))));
  // PTX:177 ld.global.f32 %f214, [%rd96+4]
  f214 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (4)))));
  // PTX:178 ld.global.f32 %f215, [%rd96+8]
  f215 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (8)))));
  // PTX:179 fma.rn.f32 %f216, %f213, %f212, %f209
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f216) : "f"(f213), "f"(f212), "f"(f209));
  // PTX:180 fma.rn.f32 %f217, %f213, %f214, %f210
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f217) : "f"(f213), "f"(f214), "f"(f210));
  // PTX:181 fma.rn.f32 %f218, %f213, %f215, %f211
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f218) : "f"(f213), "f"(f215), "f"(f211));
  // PTX:182 mul.wide.s32 %rd97, %r153, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd97) : "r"(r153));
  // PTX:183 add.s64 %rd98, %rd5, %rd97
  asm("add.s64 %0, %1, %2;" : "=l"(rd98) : "l"(rd5), "l"(rd97));
  // PTX:184 ld.global.f32 %f219, [%rd98]
  f219 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (0)))));
  // PTX:185 ld.global.f32 %f220, [%rd15+12]
  f220 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (12)))));
  // PTX:186 ld.global.f32 %f221, [%rd98+4]
  f221 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (4)))));
  // PTX:187 ld.global.f32 %f222, [%rd98+8]
  f222 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (8)))));
  // PTX:188 fma.rn.f32 %f923, %f220, %f219, %f216
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f923) : "f"(f220), "f"(f219), "f"(f216));
  // PTX:189 fma.rn.f32 %f924, %f220, %f221, %f217
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f924) : "f"(f220), "f"(f221), "f"(f217));
  // PTX:190 fma.rn.f32 %f925, %f220, %f222, %f218
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f925) : "f"(f220), "f"(f222), "f"(f218));
  // PTX:191 ld.global.f32 %f223, [%rd16]
  f223 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:192 ld.global.f32 %f224, [%rd16+4]
  f224 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (4)))));
  // PTX:193 mul.f32 %f225, %f224, %f202
  asm("mul.f32 %0, %1, %2;" : "=f"(f225) : "f"(f224), "f"(f202));
  // PTX:194 mul.f32 %f226, %f224, %f205
  asm("mul.f32 %0, %1, %2;" : "=f"(f226) : "f"(f224), "f"(f205));
  // PTX:195 mul.f32 %f227, %f224, %f207
  asm("mul.f32 %0, %1, %2;" : "=f"(f227) : "f"(f224), "f"(f207));
  // PTX:196 fma.rn.f32 %f228, %f223, %f198, %f225
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f228) : "f"(f223), "f"(f198), "f"(f225));
  // PTX:197 fma.rn.f32 %f229, %f223, %f200, %f226
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f229) : "f"(f223), "f"(f200), "f"(f226));
  // PTX:198 fma.rn.f32 %f230, %f223, %f201, %f227
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f230) : "f"(f223), "f"(f201), "f"(f227));
  // PTX:199 ld.global.f32 %f231, [%rd16+8]
  f231 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (8)))));
  // PTX:200 fma.rn.f32 %f232, %f231, %f212, %f228
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f232) : "f"(f231), "f"(f212), "f"(f228));
  // PTX:201 fma.rn.f32 %f233, %f231, %f214, %f229
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f233) : "f"(f231), "f"(f214), "f"(f229));
  // PTX:202 fma.rn.f32 %f234, %f231, %f215, %f230
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f234) : "f"(f231), "f"(f215), "f"(f230));
  // PTX:203 ld.global.f32 %f235, [%rd16+12]
  f235 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (12)))));
  // PTX:204 fma.rn.f32 %f920, %f235, %f219, %f232
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f920) : "f"(f235), "f"(f219), "f"(f232));
  // PTX:205 fma.rn.f32 %f921, %f235, %f221, %f233
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f921) : "f"(f235), "f"(f221), "f"(f233));
  // PTX:206 fma.rn.f32 %f922, %f235, %f222, %f234
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f922) : "f"(f235), "f"(f222), "f"(f234));
  // PTX:207 ld.global.f32 %f236, [%rd17]
  f236 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:208 ld.global.f32 %f237, [%rd17+4]
  f237 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (4)))));
  // PTX:209 mul.f32 %f238, %f237, %f202
  asm("mul.f32 %0, %1, %2;" : "=f"(f238) : "f"(f237), "f"(f202));
  // PTX:210 mul.f32 %f239, %f237, %f205
  asm("mul.f32 %0, %1, %2;" : "=f"(f239) : "f"(f237), "f"(f205));
  // PTX:211 mul.f32 %f240, %f237, %f207
  asm("mul.f32 %0, %1, %2;" : "=f"(f240) : "f"(f237), "f"(f207));
  // PTX:212 fma.rn.f32 %f241, %f236, %f198, %f238
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f241) : "f"(f236), "f"(f198), "f"(f238));
  // PTX:213 fma.rn.f32 %f242, %f236, %f200, %f239
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f242) : "f"(f236), "f"(f200), "f"(f239));
  // PTX:214 fma.rn.f32 %f243, %f236, %f201, %f240
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f243) : "f"(f236), "f"(f201), "f"(f240));
  // PTX:215 ld.global.f32 %f244, [%rd17+8]
  f244 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (8)))));
  // PTX:216 fma.rn.f32 %f245, %f244, %f212, %f241
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f245) : "f"(f244), "f"(f212), "f"(f241));
  // PTX:217 fma.rn.f32 %f246, %f244, %f214, %f242
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f246) : "f"(f244), "f"(f214), "f"(f242));
  // PTX:218 fma.rn.f32 %f247, %f244, %f215, %f243
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f247) : "f"(f244), "f"(f215), "f"(f243));
  // PTX:219 ld.global.f32 %f248, [%rd17+12]
  f248 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (12)))));
  // PTX:220 fma.rn.f32 %f249, %f248, %f219, %f245
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f249) : "f"(f248), "f"(f219), "f"(f245));
  // PTX:221 fma.rn.f32 %f250, %f248, %f221, %f246
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f250) : "f"(f248), "f"(f221), "f"(f246));
  // PTX:222 fma.rn.f32 %f251, %f248, %f222, %f247
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f251) : "f"(f248), "f"(f222), "f"(f247));
  // PTX:223 mov.b32 %r156, %f251
  asm("mov.b32 %0, %1;" : "=r"(r156) : "f"(f251));
  // PTX:224 mov.b32 %r155, %f250
  asm("mov.b32 %0, %1;" : "=r"(r155) : "f"(f250));
  // PTX:225 mov.b32 %r154, %f249
  asm("mov.b32 %0, %1;" : "=r"(r154) : "f"(f249));
  // PTX:227 $L__BB29_6:
L_BB29_6:;
  // PTX:228 mov.u32 %r157, 0
  asm("mov.u32 %0, 0;" : "=r"(r157) : );
  // PTX:229 shl.b64 %rd308, %rd335, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd308) : "l"(rd335));
  // PTX:230 cvta.to.global.u64 %rd99, %rd44
  rd99 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd44));
  // PTX:231 add.s64 %rd18, %rd99, %rd308
  asm("add.s64 %0, %1, %2;" : "=l"(rd18) : "l"(rd99), "l"(rd308));
  // PTX:232 add.s32 %r83, %r2, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r83) : "r"(r2), "r"(r1));
  // PTX:233 cvt.s64.s32 %rd19, %r83
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd19) : "r"(r83));
  // PTX:234 mul.wide.s32 %rd101, %r83, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd101) : "r"(r83));
  // PTX:235 add.s64 %rd102, %rd5, %rd101
  asm("add.s64 %0, %1, %2;" : "=l"(rd102) : "l"(rd5), "l"(rd101));
  // PTX:236 ld.global.f32 %f19, [%rd102]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd102) + (0)))));
  // PTX:237 ld.global.f32 %f20, [%rd18]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (0)))));
  // PTX:238 ld.global.f32 %f21, [%rd102+4]
  f21 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd102) + (4)))));
  // PTX:239 ld.global.f32 %f22, [%rd102+8]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd102) + (8)))));
  // PTX:240 add.s32 %r84, %r3, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r84) : "r"(r3), "r"(r1));
  // PTX:241 cvt.s64.s32 %rd20, %r84
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd20) : "r"(r84));
  // PTX:242 mul.wide.s32 %rd103, %r84, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd103) : "r"(r84));
  // PTX:243 add.s64 %rd104, %rd5, %rd103
  asm("add.s64 %0, %1, %2;" : "=l"(rd104) : "l"(rd5), "l"(rd103));
  // PTX:244 ld.global.f32 %f23, [%rd104]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd104) + (0)))));
  // PTX:245 ld.global.f32 %f24, [%rd18+4]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (4)))));
  // PTX:246 mul.f32 %f252, %f24, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f252) : "f"(f24), "f"(f23));
  // PTX:247 ld.global.f32 %f25, [%rd104+4]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd104) + (4)))));
  // PTX:248 mul.f32 %f253, %f24, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f253) : "f"(f24), "f"(f25));
  // PTX:249 ld.global.f32 %f26, [%rd104+8]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd104) + (8)))));
  // PTX:250 mul.f32 %f254, %f24, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f254) : "f"(f24), "f"(f26));
  // PTX:251 fma.rn.f32 %f255, %f20, %f19, %f252
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f255) : "f"(f20), "f"(f19), "f"(f252));
  // PTX:252 fma.rn.f32 %f256, %f20, %f21, %f253
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f256) : "f"(f20), "f"(f21), "f"(f253));
  // PTX:253 fma.rn.f32 %f257, %f20, %f22, %f254
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f257) : "f"(f20), "f"(f22), "f"(f254));
  // PTX:254 add.s32 %r85, %r4, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r85) : "r"(r4), "r"(r1));
  // PTX:255 cvt.s64.s32 %rd21, %r85
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd21) : "r"(r85));
  // PTX:256 mul.wide.s32 %rd105, %r85, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd105) : "r"(r85));
  // PTX:257 add.s64 %rd106, %rd5, %rd105
  asm("add.s64 %0, %1, %2;" : "=l"(rd106) : "l"(rd5), "l"(rd105));
  // PTX:258 ld.global.f32 %f27, [%rd106]
  f27 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (0)))));
  // PTX:259 ld.global.f32 %f28, [%rd18+8]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (8)))));
  // PTX:260 ld.global.f32 %f29, [%rd106+4]
  f29 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (4)))));
  // PTX:261 ld.global.f32 %f30, [%rd106+8]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (8)))));
  // PTX:262 fma.rn.f32 %f258, %f28, %f27, %f255
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f258) : "f"(f28), "f"(f27), "f"(f255));
  // PTX:263 fma.rn.f32 %f259, %f28, %f29, %f256
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f259) : "f"(f28), "f"(f29), "f"(f256));
  // PTX:264 fma.rn.f32 %f260, %f28, %f30, %f257
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f260) : "f"(f28), "f"(f30), "f"(f257));
  // PTX:265 add.s32 %r86, %r5, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r86) : "r"(r5), "r"(r1));
  // PTX:266 cvt.s64.s32 %rd22, %r86
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd22) : "r"(r86));
  // PTX:267 mul.wide.s32 %rd107, %r86, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd107) : "r"(r86));
  // PTX:268 add.s64 %rd108, %rd5, %rd107
  asm("add.s64 %0, %1, %2;" : "=l"(rd108) : "l"(rd5), "l"(rd107));
  // PTX:269 ld.global.f32 %f31, [%rd108]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd108) + (0)))));
  // PTX:270 ld.global.f32 %f32, [%rd18+12]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (12)))));
  // PTX:271 ld.global.f32 %f33, [%rd108+4]
  f33 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd108) + (4)))));
  // PTX:272 ld.global.f32 %f34, [%rd108+8]
  f34 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd108) + (8)))));
  // PTX:273 fma.rn.f32 %f35, %f32, %f31, %f258
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f35) : "f"(f32), "f"(f31), "f"(f258));
  // PTX:274 fma.rn.f32 %f36, %f32, %f33, %f259
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f36) : "f"(f32), "f"(f33), "f"(f259));
  // PTX:275 fma.rn.f32 %f37, %f32, %f34, %f260
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f37) : "f"(f32), "f"(f34), "f"(f260));
  // PTX:276 sub.f32 %f38, %f920, %f923
  asm("sub.f32 %0, %1, %2;" : "=f"(f38) : "f"(f920), "f"(f923));
  // PTX:277 sub.f32 %f39, %f921, %f924
  asm("sub.f32 %0, %1, %2;" : "=f"(f39) : "f"(f921), "f"(f924));
  // PTX:278 mul.f32 %f261, %f39, %f39
  asm("mul.f32 %0, %1, %2;" : "=f"(f261) : "f"(f39), "f"(f39));
  // PTX:279 sub.f32 %f40, %f922, %f925
  asm("sub.f32 %0, %1, %2;" : "=f"(f40) : "f"(f922), "f"(f925));
  // PTX:280 fma.rn.f32 %f262, %f38, %f38, %f261
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f262) : "f"(f38), "f"(f38), "f"(f261));
  // PTX:281 fma.rn.f32 %f263, %f40, %f40, %f262
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f263) : "f"(f40), "f"(f40), "f"(f262));
  // PTX:282 sqrt.rn.f32 %f41, %f263
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f41) : "f"(f263));
  // PTX:283 setp.leu.f32 %p4, %f41, 0f00000000
  p4 = ((isnan(((float)(f41))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f41)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:284 mov.u32 %r158, %r157
  asm("mov.u32 %0, %1;" : "=r"(r158) : "r"(r157));
  // PTX:285 mov.u32 %r159, %r157
  asm("mov.u32 %0, %1;" : "=r"(r159) : "r"(r157));
  // PTX:286 @%p4 bra $L__BB29_8
  if (p4) { goto L_BB29_8; }
  // PTX:288 div.rn.f32 %f264, %f38, %f41
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f264) : "f"(f38), "f"(f41));
  // PTX:289 div.rn.f32 %f265, %f39, %f41
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f265) : "f"(f39), "f"(f41));
  // PTX:290 div.rn.f32 %f266, %f40, %f41
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f266) : "f"(f40), "f"(f41));
  // PTX:291 mov.b32 %r159, %f266
  asm("mov.b32 %0, %1;" : "=r"(r159) : "f"(f266));
  // PTX:292 mov.b32 %r158, %f265
  asm("mov.b32 %0, %1;" : "=r"(r158) : "f"(f265));
  // PTX:293 mov.b32 %r157, %f264
  asm("mov.b32 %0, %1;" : "=r"(r157) : "f"(f264));
  // PTX:295 $L__BB29_8:
L_BB29_8:;
  // PTX:296 mov.b32 %f42, %r157
  asm("mov.b32 %0, %1;" : "=f"(f42) : "r"(r157));
  // PTX:297 mov.b32 %f43, %r158
  asm("mov.b32 %0, %1;" : "=f"(f43) : "r"(r158));
  // PTX:298 mul.f32 %f267, %f43, %f43
  asm("mul.f32 %0, %1, %2;" : "=f"(f267) : "f"(f43), "f"(f43));
  // PTX:299 mov.b32 %f44, %r159
  asm("mov.b32 %0, %1;" : "=f"(f44) : "r"(r159));
  // PTX:300 fma.rn.f32 %f268, %f42, %f42, %f267
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f268) : "f"(f42), "f"(f42), "f"(f267));
  // PTX:301 fma.rn.f32 %f269, %f44, %f44, %f268
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f269) : "f"(f44), "f"(f44), "f"(f268));
  // PTX:302 sqrt.rn.f32 %f270, %f269
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f270) : "f"(f269));
  // PTX:303 setp.le.f32 %p5, %f270, 0f322BCC77
  p5 = (!(isnan(((float)(f270))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f270)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:304 @%p5 bra $L__BB29_80
  if (p5) { goto L_BB29_80; }
  // PTX:306 ld.param.u64 %rd251, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_21]
  rd251 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param21 + (0))));
  // PTX:307 ld.param.u64 %rd250, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_1]
  rd250 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:308 cvta.to.global.u64 %rd249, %rd250
  rd249 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd250));
  // PTX:309 ld.param.u64 %rd244, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_19]
  rd244 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param19 + (0))));
  // PTX:310 ld.param.u64 %rd242, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_6]
  rd242 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:311 ld.param.u64 %rd241, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_2]
  rd241 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:312 ld.param.u64 %rd240, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_23]
  rd240 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param23 + (0))));
  // PTX:313 ld.param.u64 %rd239, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_25]
  rd239 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param25 + (0))));
  // PTX:314 ld.param.u64 %rd238, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_24]
  rd238 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param24 + (0))));
  // PTX:315 ld.param.u64 %rd237, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_17]
  rd237 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param17 + (0))));
  // PTX:316 ld.param.u64 %rd236, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_31]
  rd236 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param31 + (0))));
  // PTX:317 ld.param.u64 %rd235, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_30]
  rd235 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param30 + (0))));
  // PTX:318 ld.param.u64 %rd234, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_16]
  rd234 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param16 + (0))));
  // PTX:319 cvta.to.global.u64 %rd109, %rd234
  rd109 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd234));
  // PTX:320 shl.b64 %rd110, %rd335, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd110) : "l"(rd335));
  // PTX:321 add.s64 %rd111, %rd109, %rd110
  asm("add.s64 %0, %1, %2;" : "=l"(rd111) : "l"(rd109), "l"(rd110));
  // PTX:322 ld.global.u32 %r87, [%rd111]
  r87 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd111) + (0)))));
  // PTX:323 cvt.s64.s32 %rd23, %r87
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd23) : "r"(r87));
  // PTX:324 mul.lo.s64 %rd112, %rd334, %rd235
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd112) : "l"(rd334), "l"(rd235));
  // PTX:325 cvt.u32.u64 %r88, %rd112
  asm("cvt.u32.u64 %0, %1;" : "=r"(r88) : "l"(rd112));
  // PTX:326 add.s32 %r89, %r87, %r88
  asm("add.s32 %0, %1, %2;" : "=r"(r89) : "r"(r87), "r"(r88));
  // PTX:327 mul.lo.s64 %rd113, %rd334, %rd236
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd113) : "l"(rd334), "l"(rd236));
  // PTX:328 cvt.u32.u64 %r90, %rd113
  asm("cvt.u32.u64 %0, %1;" : "=r"(r90) : "l"(rd113));
  // PTX:329 cvta.to.global.u64 %rd114, %rd237
  rd114 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd237));
  // PTX:330 add.s64 %rd115, %rd114, %rd110
  asm("add.s64 %0, %1, %2;" : "=l"(rd115) : "l"(rd114), "l"(rd110));
  // PTX:331 ld.global.u32 %r91, [%rd115]
  r91 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd115) + (0)))));
  // PTX:332 add.s32 %r92, %r91, %r90
  asm("add.s32 %0, %1, %2;" : "=r"(r92) : "r"(r91), "r"(r90));
  // PTX:333 cvta.to.global.u64 %rd116, %rd238
  rd116 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd238));
  // PTX:334 mul.wide.s32 %rd117, %r92, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd117) : "r"(r92));
  // PTX:335 add.s64 %rd118, %rd116, %rd117
  asm("add.s64 %0, %1, %2;" : "=l"(rd118) : "l"(rd116), "l"(rd117));
  // PTX:336 ld.global.f32 %f45, [%rd118]
  f45 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd118) + (0)))));
  // PTX:337 cvta.to.global.u64 %rd119, %rd239
  rd119 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd239));
  // PTX:338 mul.wide.s32 %rd120, %r89, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd120) : "r"(r89));
  // PTX:339 add.s64 %rd121, %rd119, %rd120
  asm("add.s64 %0, %1, %2;" : "=l"(rd121) : "l"(rd119), "l"(rd120));
  // PTX:340 ld.global.f32 %f46, [%rd121]
  f46 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd121) + (0)))));
  // PTX:341 cvta.to.global.u64 %rd122, %rd240
  rd122 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd240));
  // PTX:342 add.s64 %rd123, %rd122, %rd120
  asm("add.s64 %0, %1, %2;" : "=l"(rd123) : "l"(rd122), "l"(rd120));
  // PTX:343 ld.global.f32 %f47, [%rd123]
  f47 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd123) + (0)))));
  // PTX:344 cvta.to.global.u64 %rd124, %rd241
  rd124 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd241));
  // PTX:345 shl.b64 %rd125, %rd7, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd125) : "l"(rd7));
  // PTX:346 add.s64 %rd126, %rd124, %rd125
  asm("add.s64 %0, %1, %2;" : "=l"(rd126) : "l"(rd124), "l"(rd125));
  // PTX:347 ld.global.f32 %f48, [%rd126]
  f48 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd126) + (0)))));
  // PTX:348 cvta.to.global.u64 %rd127, %rd242
  rd127 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd242));
  // PTX:349 add.s64 %rd128, %rd127, %rd110
  asm("add.s64 %0, %1, %2;" : "=l"(rd128) : "l"(rd127), "l"(rd110));
  // PTX:350 ld.global.u32 %r93, [%rd128]
  r93 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd128) + (0)))));
  // PTX:351 setp.eq.s32 %p6, %r93, 0
  p6 = (((int)(r93)) == ((int)(0)));
  // PTX:352 mul.lo.s64 %rd129, %rd19, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd129) : "l"(rd19));
  // PTX:353 add.s64 %rd24, %rd249, %rd129
  asm("add.s64 %0, %1, %2;" : "=l"(rd24) : "l"(rd249), "l"(rd129));
  // PTX:354 mul.lo.s64 %rd130, %rd20, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd130) : "l"(rd20));
  // PTX:355 add.s64 %rd25, %rd249, %rd130
  asm("add.s64 %0, %1, %2;" : "=l"(rd25) : "l"(rd249), "l"(rd130));
  // PTX:356 mul.lo.s64 %rd131, %rd21, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd131) : "l"(rd21));
  // PTX:357 add.s64 %rd26, %rd249, %rd131
  asm("add.s64 %0, %1, %2;" : "=l"(rd26) : "l"(rd249), "l"(rd131));
  // PTX:358 mul.lo.s64 %rd132, %rd22, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd132) : "l"(rd22));
  // PTX:359 add.s64 %rd27, %rd249, %rd132
  asm("add.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd249), "l"(rd132));
  // PTX:360 cvta.to.global.u64 %rd133, %rd251
  rd133 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd251));
  // PTX:361 mul.wide.s32 %rd134, %r87, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd134) : "r"(r87));
  // PTX:362 add.s64 %rd28, %rd133, %rd134
  asm("add.s64 %0, %1, %2;" : "=l"(rd28) : "l"(rd133), "l"(rd134));
  // PTX:363 cvta.to.global.u64 %rd136, %rd244
  rd136 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd244));
  // PTX:364 add.s64 %rd30, %rd136, %rd134
  asm("add.s64 %0, %1, %2;" : "=l"(rd30) : "l"(rd136), "l"(rd134));
  // PTX:365 @%p6 bra $L__BB29_57
  if (p6) { goto L_BB29_57; }
  // PTX:367 ld.param.u64 %rd246, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_15]
  rd246 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param15 + (0))));
  // PTX:368 shl.b64 %rd245, %rd335, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd245) : "l"(rd335));
  // PTX:369 cvta.to.global.u64 %rd137, %rd246
  rd137 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd246));
  // PTX:370 add.s64 %rd31, %rd137, %rd245
  asm("add.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd137), "l"(rd245));
  // PTX:371 ld.global.f32 %f49, [%rd31]
  f49 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (0)))));
  // PTX:372 ld.global.f32 %f50, [%rd31+4]
  f50 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (4)))));
  // PTX:373 mul.f32 %f271, %f50, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f271) : "f"(f50), "f"(f23));
  // PTX:374 mul.f32 %f272, %f50, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f272) : "f"(f50), "f"(f25));
  // PTX:375 mul.f32 %f273, %f50, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f273) : "f"(f50), "f"(f26));
  // PTX:376 fma.rn.f32 %f274, %f49, %f19, %f271
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f274) : "f"(f49), "f"(f19), "f"(f271));
  // PTX:377 fma.rn.f32 %f275, %f49, %f21, %f272
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f275) : "f"(f49), "f"(f21), "f"(f272));
  // PTX:378 fma.rn.f32 %f276, %f49, %f22, %f273
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f276) : "f"(f49), "f"(f22), "f"(f273));
  // PTX:379 ld.global.f32 %f51, [%rd31+8]
  f51 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (8)))));
  // PTX:380 fma.rn.f32 %f277, %f51, %f27, %f274
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f277) : "f"(f51), "f"(f27), "f"(f274));
  // PTX:381 fma.rn.f32 %f278, %f51, %f29, %f275
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f278) : "f"(f51), "f"(f29), "f"(f275));
  // PTX:382 fma.rn.f32 %f279, %f51, %f30, %f276
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f279) : "f"(f51), "f"(f30), "f"(f276));
  // PTX:383 ld.global.f32 %f52, [%rd31+12]
  f52 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (12)))));
  // PTX:384 fma.rn.f32 %f53, %f52, %f31, %f277
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f53) : "f"(f52), "f"(f31), "f"(f277));
  // PTX:385 fma.rn.f32 %f54, %f52, %f33, %f278
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f54) : "f"(f52), "f"(f33), "f"(f278));
  // PTX:386 fma.rn.f32 %f55, %f52, %f34, %f279
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f55) : "f"(f52), "f"(f34), "f"(f279));
  // PTX:387 setp.leu.f32 %p7, %f41, 0f322BCC77
  p7 = ((isnan(((float)(f41))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f41)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:388 @%p7 bra $L__BB29_80
  if (p7) { goto L_BB29_80; }
  // PTX:390 abs.f32 %f280, %f41
  asm("abs.f32 %0, %1;" : "=f"(f280) : "f"(f41));
  // PTX:391 setp.geu.f32 %p8, %f280, 0f7F800000
  p8 = ((isnan(((float)(f280))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f280)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:392 @%p8 bra $L__BB29_80
  if (p8) { goto L_BB29_80; }
  // PTX:394 div.rn.f32 %f56, %f38, %f41
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f56) : "f"(f38), "f"(f41));
  // PTX:395 mov.b32 %f281, %r154
  asm("mov.b32 %0, %1;" : "=f"(f281) : "r"(r154));
  // PTX:396 sub.f32 %f282, %f281, %f923
  asm("sub.f32 %0, %1, %2;" : "=f"(f282) : "f"(f281), "f"(f923));
  // PTX:397 mov.b32 %f283, %r155
  asm("mov.b32 %0, %1;" : "=f"(f283) : "r"(r155));
  // PTX:398 sub.f32 %f284, %f283, %f924
  asm("sub.f32 %0, %1, %2;" : "=f"(f284) : "f"(f283), "f"(f924));
  // PTX:399 mov.b32 %f285, %r156
  asm("mov.b32 %0, %1;" : "=f"(f285) : "r"(r156));
  // PTX:400 sub.f32 %f286, %f285, %f925
  asm("sub.f32 %0, %1, %2;" : "=f"(f286) : "f"(f285), "f"(f925));
  // PTX:401 div.rn.f32 %f57, %f39, %f41
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f57) : "f"(f39), "f"(f41));
  // PTX:402 mul.f32 %f287, %f284, %f57
  asm("mul.f32 %0, %1, %2;" : "=f"(f287) : "f"(f284), "f"(f57));
  // PTX:403 div.rn.f32 %f58, %f40, %f41
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f58) : "f"(f40), "f"(f41));
  // PTX:404 fma.rn.f32 %f288, %f282, %f56, %f287
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f288) : "f"(f282), "f"(f56), "f"(f287));
  // PTX:405 fma.rn.f32 %f59, %f286, %f58, %f288
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f59) : "f"(f286), "f"(f58), "f"(f288));
  // PTX:406 mul.f32 %f289, %f56, %f59
  asm("mul.f32 %0, %1, %2;" : "=f"(f289) : "f"(f56), "f"(f59));
  // PTX:407 mul.f32 %f290, %f57, %f59
  asm("mul.f32 %0, %1, %2;" : "=f"(f290) : "f"(f57), "f"(f59));
  // PTX:408 mul.f32 %f291, %f58, %f59
  asm("mul.f32 %0, %1, %2;" : "=f"(f291) : "f"(f58), "f"(f59));
  // PTX:409 sub.f32 %f60, %f282, %f289
  asm("sub.f32 %0, %1, %2;" : "=f"(f60) : "f"(f282), "f"(f289));
  // PTX:410 sub.f32 %f61, %f284, %f290
  asm("sub.f32 %0, %1, %2;" : "=f"(f61) : "f"(f284), "f"(f290));
  // PTX:411 sub.f32 %f62, %f286, %f291
  asm("sub.f32 %0, %1, %2;" : "=f"(f62) : "f"(f286), "f"(f291));
  // PTX:412 sub.f32 %f292, %f53, %f35
  asm("sub.f32 %0, %1, %2;" : "=f"(f292) : "f"(f53), "f"(f35));
  // PTX:413 sub.f32 %f293, %f54, %f36
  asm("sub.f32 %0, %1, %2;" : "=f"(f293) : "f"(f54), "f"(f36));
  // PTX:414 mul.f32 %f294, %f57, %f293
  asm("mul.f32 %0, %1, %2;" : "=f"(f294) : "f"(f57), "f"(f293));
  // PTX:415 sub.f32 %f295, %f55, %f37
  asm("sub.f32 %0, %1, %2;" : "=f"(f295) : "f"(f55), "f"(f37));
  // PTX:416 fma.rn.f32 %f296, %f56, %f292, %f294
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f296) : "f"(f56), "f"(f292), "f"(f294));
  // PTX:417 fma.rn.f32 %f63, %f58, %f295, %f296
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f63) : "f"(f58), "f"(f295), "f"(f296));
  // PTX:418 mul.f32 %f297, %f56, %f63
  asm("mul.f32 %0, %1, %2;" : "=f"(f297) : "f"(f56), "f"(f63));
  // PTX:419 mul.f32 %f298, %f57, %f63
  asm("mul.f32 %0, %1, %2;" : "=f"(f298) : "f"(f57), "f"(f63));
  // PTX:420 mul.f32 %f299, %f58, %f63
  asm("mul.f32 %0, %1, %2;" : "=f"(f299) : "f"(f58), "f"(f63));
  // PTX:421 sub.f32 %f64, %f292, %f297
  asm("sub.f32 %0, %1, %2;" : "=f"(f64) : "f"(f292), "f"(f297));
  // PTX:422 sub.f32 %f65, %f293, %f298
  asm("sub.f32 %0, %1, %2;" : "=f"(f65) : "f"(f293), "f"(f298));
  // PTX:423 sub.f32 %f66, %f295, %f299
  asm("sub.f32 %0, %1, %2;" : "=f"(f66) : "f"(f295), "f"(f299));
  // PTX:424 mul.f32 %f300, %f61, %f61
  asm("mul.f32 %0, %1, %2;" : "=f"(f300) : "f"(f61), "f"(f61));
  // PTX:425 fma.rn.f32 %f301, %f60, %f60, %f300
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f301) : "f"(f60), "f"(f60), "f"(f300));
  // PTX:426 fma.rn.f32 %f302, %f62, %f62, %f301
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f302) : "f"(f62), "f"(f62), "f"(f301));
  // PTX:427 sqrt.rn.f32 %f67, %f302
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f67) : "f"(f302));
  // PTX:428 mul.f32 %f303, %f65, %f65
  asm("mul.f32 %0, %1, %2;" : "=f"(f303) : "f"(f65), "f"(f65));
  // PTX:429 fma.rn.f32 %f304, %f64, %f64, %f303
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f304) : "f"(f64), "f"(f64), "f"(f303));
  // PTX:430 fma.rn.f32 %f305, %f66, %f66, %f304
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f305) : "f"(f66), "f"(f66), "f"(f304));
  // PTX:431 sqrt.rn.f32 %f68, %f305
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f68) : "f"(f305));
  // PTX:432 setp.leu.f32 %p9, %f67, 0f322BCC77
  p9 = ((isnan(((float)(f67))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f67)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:433 setp.leu.f32 %p10, %f68, 0f322BCC77
  p10 = ((isnan(((float)(f68))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f68)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:434 or.pred %p11, %p9, %p10
  p11 = ((p9) || (p10));
  // PTX:435 @%p11 bra $L__BB29_80
  if (p11) { goto L_BB29_80; }
  // PTX:437 abs.f32 %f306, %f67
  asm("abs.f32 %0, %1;" : "=f"(f306) : "f"(f67));
  // PTX:438 setp.geu.f32 %p12, %f306, 0f7F800000
  p12 = ((isnan(((float)(f306))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f306)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:439 @%p12 bra $L__BB29_80
  if (p12) { goto L_BB29_80; }
  // PTX:441 abs.f32 %f307, %f68
  asm("abs.f32 %0, %1;" : "=f"(f307) : "f"(f68));
  // PTX:442 setp.geu.f32 %p13, %f307, 0f7F800000
  p13 = ((isnan(((float)(f307))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f307)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:443 @%p13 bra $L__BB29_80
  if (p13) { goto L_BB29_80; }
  // PTX:445 div.rn.f32 %f69, %f60, %f67
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f69) : "f"(f60), "f"(f67));
  // PTX:446 div.rn.f32 %f70, %f66, %f68
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f70) : "f"(f66), "f"(f68));
  // PTX:447 div.rn.f32 %f71, %f61, %f67
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f71) : "f"(f61), "f"(f67));
  // PTX:448 mul.f32 %f308, %f71, %f70
  asm("mul.f32 %0, %1, %2;" : "=f"(f308) : "f"(f71), "f"(f70));
  // PTX:449 div.rn.f32 %f72, %f65, %f68
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f72) : "f"(f65), "f"(f68));
  // PTX:450 div.rn.f32 %f73, %f62, %f67
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f73) : "f"(f62), "f"(f67));
  // PTX:451 mul.f32 %f309, %f73, %f72
  asm("mul.f32 %0, %1, %2;" : "=f"(f309) : "f"(f73), "f"(f72));
  // PTX:452 sub.f32 %f310, %f308, %f309
  asm("sub.f32 %0, %1, %2;" : "=f"(f310) : "f"(f308), "f"(f309));
  // PTX:453 div.rn.f32 %f74, %f64, %f68
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f74) : "f"(f64), "f"(f68));
  // PTX:454 mul.f32 %f311, %f73, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f311) : "f"(f73), "f"(f74));
  // PTX:455 mul.f32 %f312, %f69, %f70
  asm("mul.f32 %0, %1, %2;" : "=f"(f312) : "f"(f69), "f"(f70));
  // PTX:456 sub.f32 %f313, %f311, %f312
  asm("sub.f32 %0, %1, %2;" : "=f"(f313) : "f"(f311), "f"(f312));
  // PTX:457 mul.f32 %f314, %f69, %f72
  asm("mul.f32 %0, %1, %2;" : "=f"(f314) : "f"(f69), "f"(f72));
  // PTX:458 mul.f32 %f315, %f71, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f315) : "f"(f71), "f"(f74));
  // PTX:459 sub.f32 %f316, %f314, %f315
  asm("sub.f32 %0, %1, %2;" : "=f"(f316) : "f"(f314), "f"(f315));
  // PTX:460 mul.f32 %f317, %f57, %f313
  asm("mul.f32 %0, %1, %2;" : "=f"(f317) : "f"(f57), "f"(f313));
  // PTX:461 fma.rn.f32 %f318, %f56, %f310, %f317
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f318) : "f"(f56), "f"(f310), "f"(f317));
  // PTX:462 fma.rn.f32 %f75, %f58, %f316, %f318
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f75) : "f"(f58), "f"(f316), "f"(f318));
  // PTX:463 mul.f32 %f319, %f71, %f72
  asm("mul.f32 %0, %1, %2;" : "=f"(f319) : "f"(f71), "f"(f72));
  // PTX:464 fma.rn.f32 %f320, %f69, %f74, %f319
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f320) : "f"(f69), "f"(f74), "f"(f319));
  // PTX:465 fma.rn.f32 %f76, %f73, %f70, %f320
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f76) : "f"(f73), "f"(f70), "f"(f320));
  // PTX:466 mul.f32 %f321, %f75, %f75
  asm("mul.f32 %0, %1, %2;" : "=f"(f321) : "f"(f75), "f"(f75));
  // PTX:467 fma.rn.f32 %f77, %f76, %f76, %f321
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f77) : "f"(f76), "f"(f76), "f"(f321));
  // PTX:468 setp.leu.f32 %p14, %f77, 0f2B8CBCCC
  p14 = ((isnan(((float)(f77))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) || (((float)(f77)) <= ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:469 @%p14 bra $L__BB29_80
  if (p14) { goto L_BB29_80; }
  // PTX:471 abs.f32 %f322, %f77
  asm("abs.f32 %0, %1;" : "=f"(f322) : "f"(f77));
  // PTX:472 setp.geu.f32 %p15, %f322, 0f7F800000
  p15 = ((isnan(((float)(f322))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f322)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:473 @%p15 bra $L__BB29_80
  if (p15) { goto L_BB29_80; }
  // PTX:475 mul.f32 %f323, %f57, %f73
  asm("mul.f32 %0, %1, %2;" : "=f"(f323) : "f"(f57), "f"(f73));
  // PTX:476 mul.f32 %f324, %f58, %f71
  asm("mul.f32 %0, %1, %2;" : "=f"(f324) : "f"(f58), "f"(f71));
  // PTX:477 sub.f32 %f78, %f323, %f324
  asm("sub.f32 %0, %1, %2;" : "=f"(f78) : "f"(f323), "f"(f324));
  // PTX:478 mul.f32 %f325, %f56, %f73
  asm("mul.f32 %0, %1, %2;" : "=f"(f325) : "f"(f56), "f"(f73));
  // PTX:479 mul.f32 %f326, %f58, %f69
  asm("mul.f32 %0, %1, %2;" : "=f"(f326) : "f"(f58), "f"(f69));
  // PTX:480 sub.f32 %f79, %f326, %f325
  asm("sub.f32 %0, %1, %2;" : "=f"(f79) : "f"(f326), "f"(f325));
  // PTX:481 mul.f32 %f327, %f57, %f69
  asm("mul.f32 %0, %1, %2;" : "=f"(f327) : "f"(f57), "f"(f69));
  // PTX:482 mul.f32 %f328, %f56, %f71
  asm("mul.f32 %0, %1, %2;" : "=f"(f328) : "f"(f56), "f"(f71));
  // PTX:483 sub.f32 %f80, %f328, %f327
  asm("sub.f32 %0, %1, %2;" : "=f"(f80) : "f"(f328), "f"(f327));
  // PTX:484 mul.f32 %f329, %f58, %f72
  asm("mul.f32 %0, %1, %2;" : "=f"(f329) : "f"(f58), "f"(f72));
  // PTX:485 mul.f32 %f330, %f57, %f70
  asm("mul.f32 %0, %1, %2;" : "=f"(f330) : "f"(f57), "f"(f70));
  // PTX:486 sub.f32 %f81, %f330, %f329
  asm("sub.f32 %0, %1, %2;" : "=f"(f81) : "f"(f330), "f"(f329));
  // PTX:487 mul.f32 %f331, %f56, %f70
  asm("mul.f32 %0, %1, %2;" : "=f"(f331) : "f"(f56), "f"(f70));
  // PTX:488 mul.f32 %f332, %f58, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f332) : "f"(f58), "f"(f74));
  // PTX:489 sub.f32 %f82, %f332, %f331
  asm("sub.f32 %0, %1, %2;" : "=f"(f82) : "f"(f332), "f"(f331));
  // PTX:490 mul.f32 %f333, %f57, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f333) : "f"(f57), "f"(f74));
  // PTX:491 mul.f32 %f334, %f56, %f72
  asm("mul.f32 %0, %1, %2;" : "=f"(f334) : "f"(f56), "f"(f72));
  // PTX:492 sub.f32 %f83, %f334, %f333
  asm("sub.f32 %0, %1, %2;" : "=f"(f83) : "f"(f334), "f"(f333));
  // PTX:493 div.rn.f32 %f335, %f59, %f67
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f335) : "f"(f59), "f"(f67));
  // PTX:494 mul.f32 %f336, %f335, %f78
  asm("mul.f32 %0, %1, %2;" : "=f"(f336) : "f"(f335), "f"(f78));
  // PTX:495 mul.f32 %f337, %f335, %f79
  asm("mul.f32 %0, %1, %2;" : "=f"(f337) : "f"(f335), "f"(f79));
  // PTX:496 mul.f32 %f338, %f335, %f80
  asm("mul.f32 %0, %1, %2;" : "=f"(f338) : "f"(f335), "f"(f80));
  // PTX:497 div.rn.f32 %f339, %f63, %f68
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f339) : "f"(f63), "f"(f68));
  // PTX:498 mul.f32 %f340, %f339, %f81
  asm("mul.f32 %0, %1, %2;" : "=f"(f340) : "f"(f339), "f"(f81));
  // PTX:499 mul.f32 %f341, %f339, %f82
  asm("mul.f32 %0, %1, %2;" : "=f"(f341) : "f"(f339), "f"(f82));
  // PTX:500 mul.f32 %f342, %f339, %f83
  asm("mul.f32 %0, %1, %2;" : "=f"(f342) : "f"(f339), "f"(f83));
  // PTX:501 sub.f32 %f343, %f336, %f340
  asm("sub.f32 %0, %1, %2;" : "=f"(f343) : "f"(f336), "f"(f340));
  // PTX:502 sub.f32 %f344, %f337, %f341
  asm("sub.f32 %0, %1, %2;" : "=f"(f344) : "f"(f337), "f"(f341));
  // PTX:503 sub.f32 %f345, %f338, %f342
  asm("sub.f32 %0, %1, %2;" : "=f"(f345) : "f"(f338), "f"(f342));
  // PTX:504 div.rn.f32 %f84, %f343, %f41
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f84) : "f"(f343), "f"(f41));
  // PTX:505 div.rn.f32 %f85, %f344, %f41
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f85) : "f"(f344), "f"(f41));
  // PTX:506 div.rn.f32 %f86, %f345, %f41
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f86) : "f"(f345), "f"(f41));
  // PTX:507 abs.f32 %f87, %f76
  asm("abs.f32 %0, %1;" : "=f"(f87) : "f"(f76));
  // PTX:508 setp.eq.f32 %p16, %f87, 0f00000000
  p16 = (!(isnan(((float)(f87))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f87)) == ((float)(as_f32(0x00000000u)))));
  // PTX:509 abs.f32 %f88, %f75
  asm("abs.f32 %0, %1;" : "=f"(f88) : "f"(f75));
  // PTX:510 setp.eq.f32 %p17, %f88, 0f00000000
  p17 = (!(isnan(((float)(f88))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f88)) == ((float)(as_f32(0x00000000u)))));
  // PTX:511 and.pred %p18, %p16, %p17
  p18 = ((p16) && (p17));
  // PTX:512 @%p18 bra $L__BB29_21
  if (p18) { goto L_BB29_21; }
  // PTX:513 bra.uni $L__BB29_18
  goto L_BB29_18;
  // PTX:515 $L__BB29_21:
L_BB29_21:;
  // PTX:516 mov.b32 %r104, %f76
  asm("mov.b32 %0, %1;" : "=r"(r104) : "f"(f76));
  // PTX:517 shr.s32 %r105, %r104, 31
  asm("shr.s32 %0, %1, 31;" : "=r"(r105) : "r"(r104));
  // PTX:518 and.b32 %r106, %r105, 1078530011
  asm("and.b32 %0, %1, 1078530011;" : "=r"(r106) : "r"(r105));
  // PTX:519 mov.b32 %r107, %f75
  asm("mov.b32 %0, %1;" : "=r"(r107) : "f"(f75));
  // PTX:520 and.b32 %r108, %r107, -2147483648
  asm("and.b32 %0, %1, -2147483648;" : "=r"(r108) : "r"(r107));
  // PTX:521 or.b32 %r109, %r108, %r106
  asm("or.b32 %0, %1, %2;" : "=r"(r109) : "r"(r108), "r"(r106));
  // PTX:522 mov.b32 %f926, %r109
  asm("mov.b32 %0, %1;" : "=f"(f926) : "r"(r109));
  // PTX:523 bra.uni $L__BB29_22
  goto L_BB29_22;
  // PTX:525 $L__BB29_57:
L_BB29_57:;
  // PTX:526 cvt.u32.u64 %r139, %rd14
  asm("cvt.u32.u64 %0, %1;" : "=r"(r139) : "l"(rd14));
  // PTX:527 setp.lt.s32 %p59, %r139, 0
  p59 = (((int)(r139)) < ((int)(0)));
  // PTX:528 sub.f32 %f159, %f35, %f923
  asm("sub.f32 %0, %1, %2;" : "=f"(f159) : "f"(f35), "f"(f923));
  // PTX:529 sub.f32 %f160, %f36, %f924
  asm("sub.f32 %0, %1, %2;" : "=f"(f160) : "f"(f36), "f"(f924));
  // PTX:530 mul.f32 %f704, %f160, %f43
  asm("mul.f32 %0, %1, %2;" : "=f"(f704) : "f"(f160), "f"(f43));
  // PTX:531 sub.f32 %f161, %f37, %f925
  asm("sub.f32 %0, %1, %2;" : "=f"(f161) : "f"(f37), "f"(f925));
  // PTX:532 fma.rn.f32 %f705, %f159, %f42, %f704
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f705) : "f"(f159), "f"(f42), "f"(f704));
  // PTX:533 fma.rn.f32 %f162, %f161, %f44, %f705
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f162) : "f"(f161), "f"(f44), "f"(f705));
  // PTX:534 @%p59 bra $L__BB29_59
  if (p59) { goto L_BB29_59; }
  // PTX:536 ld.param.u64 %rd328, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_11]
  rd328 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:537 shl.b64 %rd327, %rd335, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd327) : "l"(rd335));
  // PTX:538 cvta.to.global.u64 %rd326, %rd328
  rd326 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd328));
  // PTX:539 add.s64 %rd325, %rd326, %rd327
  asm("add.s64 %0, %1, %2;" : "=l"(rd325) : "l"(rd326), "l"(rd327));
  // PTX:540 ld.param.u64 %rd275, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_1]
  rd275 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:541 cvta.to.global.u64 %rd274, %rd275
  rd274 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd275));
  // PTX:542 ld.global.f32 %f706, [%rd325]
  f706 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd325) + (0)))));
  // PTX:543 mul.wide.s32 %rd188, %r150, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd188) : "r"(r150));
  // PTX:544 add.s64 %rd189, %rd274, %rd188
  asm("add.s64 %0, %1, %2;" : "=l"(rd189) : "l"(rd274), "l"(rd188));
  // PTX:545 ld.global.f32 %f707, [%rd189]
  f707 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd189) + (0)))));
  // PTX:546 ld.global.f32 %f708, [%rd189+4]
  f708 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd189) + (4)))));
  // PTX:547 ld.global.f32 %f709, [%rd189+8]
  f709 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd189) + (8)))));
  // PTX:548 mul.wide.s32 %rd190, %r151, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd190) : "r"(r151));
  // PTX:549 add.s64 %rd191, %rd274, %rd190
  asm("add.s64 %0, %1, %2;" : "=l"(rd191) : "l"(rd274), "l"(rd190));
  // PTX:550 ld.global.f32 %f710, [%rd191]
  f710 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd191) + (0)))));
  // PTX:551 ld.global.f32 %f711, [%rd325+4]
  f711 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd325) + (4)))));
  // PTX:552 mul.f32 %f712, %f711, %f710
  asm("mul.f32 %0, %1, %2;" : "=f"(f712) : "f"(f711), "f"(f710));
  // PTX:553 ld.global.f32 %f713, [%rd191+4]
  f713 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd191) + (4)))));
  // PTX:554 mul.f32 %f714, %f711, %f713
  asm("mul.f32 %0, %1, %2;" : "=f"(f714) : "f"(f711), "f"(f713));
  // PTX:555 ld.global.f32 %f715, [%rd191+8]
  f715 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd191) + (8)))));
  // PTX:556 mul.f32 %f716, %f711, %f715
  asm("mul.f32 %0, %1, %2;" : "=f"(f716) : "f"(f711), "f"(f715));
  // PTX:557 fma.rn.f32 %f717, %f706, %f707, %f712
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f717) : "f"(f706), "f"(f707), "f"(f712));
  // PTX:558 fma.rn.f32 %f718, %f706, %f708, %f714
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f718) : "f"(f706), "f"(f708), "f"(f714));
  // PTX:559 fma.rn.f32 %f719, %f706, %f709, %f716
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f719) : "f"(f706), "f"(f709), "f"(f716));
  // PTX:560 mul.wide.s32 %rd192, %r152, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd192) : "r"(r152));
  // PTX:561 add.s64 %rd193, %rd274, %rd192
  asm("add.s64 %0, %1, %2;" : "=l"(rd193) : "l"(rd274), "l"(rd192));
  // PTX:562 ld.global.f32 %f720, [%rd193]
  f720 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd193) + (0)))));
  // PTX:563 ld.global.f32 %f721, [%rd325+8]
  f721 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd325) + (8)))));
  // PTX:564 ld.global.f32 %f722, [%rd193+4]
  f722 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd193) + (4)))));
  // PTX:565 ld.global.f32 %f723, [%rd193+8]
  f723 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd193) + (8)))));
  // PTX:566 fma.rn.f32 %f724, %f721, %f720, %f717
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f724) : "f"(f721), "f"(f720), "f"(f717));
  // PTX:567 fma.rn.f32 %f725, %f721, %f722, %f718
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f725) : "f"(f721), "f"(f722), "f"(f718));
  // PTX:568 fma.rn.f32 %f726, %f721, %f723, %f719
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f726) : "f"(f721), "f"(f723), "f"(f719));
  // PTX:569 mul.wide.s32 %rd194, %r153, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd194) : "r"(r153));
  // PTX:570 add.s64 %rd195, %rd274, %rd194
  asm("add.s64 %0, %1, %2;" : "=l"(rd195) : "l"(rd274), "l"(rd194));
  // PTX:571 ld.global.f32 %f727, [%rd195]
  f727 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd195) + (0)))));
  // PTX:572 ld.global.f32 %f728, [%rd325+12]
  f728 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd325) + (12)))));
  // PTX:573 ld.global.f32 %f729, [%rd195+4]
  f729 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd195) + (4)))));
  // PTX:574 ld.global.f32 %f730, [%rd195+8]
  f730 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd195) + (8)))));
  // PTX:575 fma.rn.f32 %f927, %f728, %f727, %f724
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f927) : "f"(f728), "f"(f727), "f"(f724));
  // PTX:576 fma.rn.f32 %f928, %f728, %f729, %f725
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f928) : "f"(f728), "f"(f729), "f"(f725));
  // PTX:577 fma.rn.f32 %f929, %f728, %f730, %f726
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f929) : "f"(f728), "f"(f730), "f"(f726));
  // PTX:578 ld.global.f32 %f731, [%rd16]
  f731 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:579 ld.global.f32 %f732, [%rd16+4]
  f732 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (4)))));
  // PTX:580 mul.f32 %f733, %f732, %f710
  asm("mul.f32 %0, %1, %2;" : "=f"(f733) : "f"(f732), "f"(f710));
  // PTX:581 mul.f32 %f734, %f732, %f713
  asm("mul.f32 %0, %1, %2;" : "=f"(f734) : "f"(f732), "f"(f713));
  // PTX:582 mul.f32 %f735, %f732, %f715
  asm("mul.f32 %0, %1, %2;" : "=f"(f735) : "f"(f732), "f"(f715));
  // PTX:583 fma.rn.f32 %f736, %f731, %f707, %f733
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f736) : "f"(f731), "f"(f707), "f"(f733));
  // PTX:584 fma.rn.f32 %f737, %f731, %f708, %f734
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f737) : "f"(f731), "f"(f708), "f"(f734));
  // PTX:585 fma.rn.f32 %f738, %f731, %f709, %f735
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f738) : "f"(f731), "f"(f709), "f"(f735));
  // PTX:586 ld.global.f32 %f739, [%rd16+8]
  f739 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (8)))));
  // PTX:587 fma.rn.f32 %f740, %f739, %f720, %f736
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f740) : "f"(f739), "f"(f720), "f"(f736));
  // PTX:588 fma.rn.f32 %f741, %f739, %f722, %f737
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f741) : "f"(f739), "f"(f722), "f"(f737));
  // PTX:589 fma.rn.f32 %f742, %f739, %f723, %f738
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f742) : "f"(f739), "f"(f723), "f"(f738));
  // PTX:590 ld.global.f32 %f743, [%rd16+12]
  f743 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (12)))));
  // PTX:591 fma.rn.f32 %f930, %f743, %f727, %f740
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f930) : "f"(f743), "f"(f727), "f"(f740));
  // PTX:592 fma.rn.f32 %f931, %f743, %f729, %f741
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f931) : "f"(f743), "f"(f729), "f"(f741));
  // PTX:593 fma.rn.f32 %f932, %f743, %f730, %f742
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f932) : "f"(f743), "f"(f730), "f"(f742));
  // PTX:595 $L__BB29_59:
L_BB29_59:;
  // PTX:596 sub.f32 %f175, %f930, %f927
  asm("sub.f32 %0, %1, %2;" : "=f"(f175) : "f"(f930), "f"(f927));
  // PTX:597 mul.f32 %f744, %f175, %f175
  asm("mul.f32 %0, %1, %2;" : "=f"(f744) : "f"(f175), "f"(f175));
  // PTX:598 sub.f32 %f176, %f931, %f928
  asm("sub.f32 %0, %1, %2;" : "=f"(f176) : "f"(f931), "f"(f928));
  // PTX:599 sub.f32 %f177, %f932, %f929
  asm("sub.f32 %0, %1, %2;" : "=f"(f177) : "f"(f932), "f"(f929));
  // PTX:600 fma.rn.f32 %f745, %f176, %f176, %f744
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f745) : "f"(f176), "f"(f176), "f"(f744));
  // PTX:601 fma.rn.f32 %f746, %f177, %f177, %f745
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f746) : "f"(f177), "f"(f177), "f"(f745));
  // PTX:602 sqrt.rn.f32 %f178, %f746
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f178) : "f"(f746));
  // PTX:603 setp.leu.f32 %p60, %f178, 0f00000000
  p60 = ((isnan(((float)(f178))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f178)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:604 mov.u32 %r170, 0
  asm("mov.u32 %0, 0;" : "=r"(r170) : );
  // PTX:605 mov.u32 %r171, %r170
  asm("mov.u32 %0, %1;" : "=r"(r171) : "r"(r170));
  // PTX:606 mov.u32 %r172, %r170
  asm("mov.u32 %0, %1;" : "=r"(r172) : "r"(r170));
  // PTX:607 @%p60 bra $L__BB29_61
  if (p60) { goto L_BB29_61; }
  // PTX:609 div.rn.f32 %f747, %f175, %f178
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f747) : "f"(f175), "f"(f178));
  // PTX:610 div.rn.f32 %f748, %f176, %f178
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f748) : "f"(f176), "f"(f178));
  // PTX:611 div.rn.f32 %f749, %f177, %f178
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f749) : "f"(f177), "f"(f178));
  // PTX:612 mov.b32 %r172, %f749
  asm("mov.b32 %0, %1;" : "=r"(r172) : "f"(f749));
  // PTX:613 mov.b32 %r171, %f748
  asm("mov.b32 %0, %1;" : "=r"(r171) : "f"(f748));
  // PTX:614 mov.b32 %r170, %f747
  asm("mov.b32 %0, %1;" : "=r"(r170) : "f"(f747));
  // PTX:616 $L__BB29_61:
L_BB29_61:;
  // PTX:617 mov.b32 %f179, %r170
  asm("mov.b32 %0, %1;" : "=f"(f179) : "r"(r170));
  // PTX:618 mov.b32 %f180, %r171
  asm("mov.b32 %0, %1;" : "=f"(f180) : "r"(r171));
  // PTX:619 mul.f32 %f750, %f180, %f180
  asm("mul.f32 %0, %1, %2;" : "=f"(f750) : "f"(f180), "f"(f180));
  // PTX:620 mov.b32 %f181, %r172
  asm("mov.b32 %0, %1;" : "=f"(f181) : "r"(r172));
  // PTX:621 fma.rn.f32 %f751, %f179, %f179, %f750
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f751) : "f"(f179), "f"(f179), "f"(f750));
  // PTX:622 fma.rn.f32 %f752, %f181, %f181, %f751
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f752) : "f"(f181), "f"(f181), "f"(f751));
  // PTX:623 sqrt.rn.f32 %f753, %f752
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f753) : "f"(f752));
  // PTX:624 setp.le.f32 %p61, %f753, 0f322BCC77
  p61 = (!(isnan(((float)(f753))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f753)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:625 @%p61 bra $L__BB29_80
  if (p61) { goto L_BB29_80; }
  // PTX:627 ld.param.u64 %rd270, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_21]
  rd270 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param21 + (0))));
  // PTX:628 ld.global.f32 %f754, [%rd24]
  f754 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (0)))));
  // PTX:629 ld.global.f32 %f755, [%rd24+4]
  f755 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (4)))));
  // PTX:630 ld.global.f32 %f756, [%rd24+8]
  f756 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (8)))));
  // PTX:631 ld.global.f32 %f757, [%rd25]
  f757 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (0)))));
  // PTX:632 mul.f32 %f758, %f24, %f757
  asm("mul.f32 %0, %1, %2;" : "=f"(f758) : "f"(f24), "f"(f757));
  // PTX:633 ld.global.f32 %f759, [%rd25+4]
  f759 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (4)))));
  // PTX:634 mul.f32 %f760, %f24, %f759
  asm("mul.f32 %0, %1, %2;" : "=f"(f760) : "f"(f24), "f"(f759));
  // PTX:635 ld.global.f32 %f761, [%rd25+8]
  f761 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (8)))));
  // PTX:636 mul.f32 %f762, %f24, %f761
  asm("mul.f32 %0, %1, %2;" : "=f"(f762) : "f"(f24), "f"(f761));
  // PTX:637 fma.rn.f32 %f763, %f20, %f754, %f758
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f763) : "f"(f20), "f"(f754), "f"(f758));
  // PTX:638 fma.rn.f32 %f764, %f20, %f755, %f760
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f764) : "f"(f20), "f"(f755), "f"(f760));
  // PTX:639 fma.rn.f32 %f765, %f20, %f756, %f762
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f765) : "f"(f20), "f"(f756), "f"(f762));
  // PTX:640 ld.global.f32 %f766, [%rd26]
  f766 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (0)))));
  // PTX:641 ld.global.f32 %f767, [%rd26+4]
  f767 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (4)))));
  // PTX:642 ld.global.f32 %f768, [%rd26+8]
  f768 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (8)))));
  // PTX:643 fma.rn.f32 %f769, %f28, %f766, %f763
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f769) : "f"(f28), "f"(f766), "f"(f763));
  // PTX:644 fma.rn.f32 %f770, %f28, %f767, %f764
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f770) : "f"(f28), "f"(f767), "f"(f764));
  // PTX:645 fma.rn.f32 %f771, %f28, %f768, %f765
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f771) : "f"(f28), "f"(f768), "f"(f765));
  // PTX:646 ld.global.f32 %f772, [%rd27]
  f772 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))));
  // PTX:647 ld.global.f32 %f773, [%rd27+4]
  f773 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (4)))));
  // PTX:648 ld.global.f32 %f774, [%rd27+8]
  f774 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (8)))));
  // PTX:649 fma.rn.f32 %f775, %f32, %f772, %f769
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f775) : "f"(f32), "f"(f772), "f"(f769));
  // PTX:650 fma.rn.f32 %f776, %f32, %f773, %f770
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f776) : "f"(f32), "f"(f773), "f"(f770));
  // PTX:651 fma.rn.f32 %f777, %f32, %f774, %f771
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f777) : "f"(f32), "f"(f774), "f"(f771));
  // PTX:652 sub.f32 %f778, %f775, %f927
  asm("sub.f32 %0, %1, %2;" : "=f"(f778) : "f"(f775), "f"(f927));
  // PTX:653 sub.f32 %f779, %f776, %f928
  asm("sub.f32 %0, %1, %2;" : "=f"(f779) : "f"(f776), "f"(f928));
  // PTX:654 sub.f32 %f780, %f777, %f929
  asm("sub.f32 %0, %1, %2;" : "=f"(f780) : "f"(f777), "f"(f929));
  // PTX:655 mul.f32 %f781, %f779, %f180
  asm("mul.f32 %0, %1, %2;" : "=f"(f781) : "f"(f779), "f"(f180));
  // PTX:656 fma.rn.f32 %f782, %f778, %f179, %f781
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f782) : "f"(f778), "f"(f179), "f"(f781));
  // PTX:657 fma.rn.f32 %f182, %f780, %f181, %f782
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f182) : "f"(f780), "f"(f181), "f"(f782));
  // PTX:658 setp.eq.s64 %p62, %rd270, 0
  p62 = (((long long)(rd270)) == ((long long)(0)));
  // PTX:659 mov.u32 %r173, 3
  asm("mov.u32 %0, 3;" : "=r"(r173) : );
  // PTX:660 @%p62 bra $L__BB29_64
  if (p62) { goto L_BB29_64; }
  // PTX:662 ld.global.u32 %r173, [%rd28]
  r173 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (0)))));
  // PTX:664 $L__BB29_64:
L_BB29_64:;
  // PTX:665 or.b32 %r144, %r173, 2
  asm("or.b32 %0, %1, 2;" : "=r"(r144) : "r"(r173));
  // PTX:666 setp.ne.s32 %p63, %r144, 3
  p63 = (((int)(r144)) != ((int)(3)));
  // PTX:667 mov.f32 %f947, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f947) : );
  // PTX:668 @%p63 bra $L__BB29_66
  if (p63) { goto L_BB29_66; }
  // PTX:670 ld.param.u64 %rd324, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_18]
  rd324 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param18 + (0))));
  // PTX:671 mul.wide.s32 %rd323, %r87, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd323) : "r"(r87));
  // PTX:672 cvta.to.global.u64 %rd322, %rd324
  rd322 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd324));
  // PTX:673 add.s64 %rd321, %rd322, %rd323
  asm("add.s64 %0, %1, %2;" : "=l"(rd321) : "l"(rd322), "l"(rd323));
  // PTX:674 ld.global.f32 %f784, [%rd321]
  f784 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd321) + (0)))));
  // PTX:675 sub.f32 %f785, %f45, %f182
  asm("sub.f32 %0, %1, %2;" : "=f"(f785) : "f"(f45), "f"(f182));
  // PTX:676 fma.rn.f32 %f947, %f785, %f784, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f947) : "f"(f785), "f"(f784));
  // PTX:678 $L__BB29_66:
L_BB29_66:;
  // PTX:679 setp.eq.s32 %p64, %r173, 1
  p64 = (((int)(r173)) == ((int)(1)));
  // PTX:680 @%p64 bra $L__BB29_69
  if (p64) { goto L_BB29_69; }
  // PTX:681 bra.uni $L__BB29_67
  goto L_BB29_67;
  // PTX:683 $L__BB29_69:
L_BB29_69:;
  // PTX:684 ld.global.f32 %f788, [%rd30]
  f788 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0)))));
  // PTX:685 mul.f32 %f789, %f48, %f788
  asm("mul.f32 %0, %1, %2;" : "=f"(f789) : "f"(f48), "f"(f788));
  // PTX:686 sub.f32 %f947, %f947, %f789
  asm("sub.f32 %0, %1, %2;" : "=f"(f947) : "f"(f947), "f"(f789));
  // PTX:687 bra.uni $L__BB29_70
  goto L_BB29_70;
  // PTX:689 $L__BB29_67:
L_BB29_67:;
  // PTX:690 or.b32 %r145, %r173, 1
  asm("or.b32 %0, %1, 1;" : "=r"(r145) : "r"(r173));
  // PTX:691 setp.eq.s32 %p65, %r145, 3
  p65 = (((int)(r145)) == ((int)(3)));
  // PTX:692 @%p65 bra $L__BB29_68
  if (p65) { goto L_BB29_68; }
  // PTX:693 bra.uni $L__BB29_70
  goto L_BB29_70;
  // PTX:695 $L__BB29_68:
L_BB29_68:;
  // PTX:696 ld.global.f32 %f786, [%rd30]
  f786 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0)))));
  // PTX:697 sub.f32 %f787, %f46, %f48
  asm("sub.f32 %0, %1, %2;" : "=f"(f787) : "f"(f46), "f"(f48));
  // PTX:698 fma.rn.f32 %f947, %f787, %f786, %f947
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f947) : "f"(f787), "f"(f786), "f"(f947));
  // PTX:700 $L__BB29_70:
L_BB29_70:;
  // PTX:701 ld.param.u64 %rd273, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_22]
  rd273 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param22 + (0))));
  // PTX:702 ld.param.u64 %rd272, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_20]
  rd272 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param20 + (0))));
  // PTX:703 cvta.to.global.u64 %rd271, %rd272
  rd271 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd272));
  // PTX:704 shl.b64 %rd196, %rd23, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd196) : "l"(rd23));
  // PTX:705 add.s64 %rd197, %rd271, %rd196
  asm("add.s64 %0, %1, %2;" : "=l"(rd197) : "l"(rd271), "l"(rd196));
  // PTX:706 ld.global.f32 %f791, [%rd197]
  f791 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd197) + (0)))));
  // PTX:707 neg.f32 %f792, %f791
  asm("neg.f32 %0, %1;" : "=f"(f792) : "f"(f791));
  // PTX:708 max.f32 %f793, %f792, %f947
  asm("max.f32 %0, %1, %2;" : "=f"(f793) : "f"(f792), "f"(f947));
  // PTX:709 min.f32 %f188, %f791, %f793
  asm("min.f32 %0, %1, %2;" : "=f"(f188) : "f"(f791), "f"(f793));
  // PTX:710 setp.eq.s64 %p66, %rd273, 0
  p66 = (((long long)(rd273)) == ((long long)(0)));
  // PTX:711 mov.f32 %f948, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f948) : );
  // PTX:712 @%p66 bra $L__BB29_72
  if (p66) { goto L_BB29_72; }
  // PTX:714 ld.param.u64 %rd310, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_22]
  rd310 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param22 + (0))));
  // PTX:715 cvta.to.global.u64 %rd309, %rd310
  rd309 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd310));
  // PTX:716 add.s64 %rd199, %rd309, %rd196
  asm("add.s64 %0, %1, %2;" : "=l"(rd199) : "l"(rd309), "l"(rd196));
  // PTX:717 ld.global.f32 %f948, [%rd199]
  f948 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd199) + (0)))));
  // PTX:719 $L__BB29_72:
L_BB29_72:;
  // PTX:720 mul.f32 %f794, %f48, %f948
  asm("mul.f32 %0, %1, %2;" : "=f"(f794) : "f"(f48), "f"(f948));
  // PTX:721 add.f32 %f795, %f47, %f188
  asm("add.f32 %0, %1, %2;" : "=f"(f795) : "f"(f47), "f"(f188));
  // PTX:722 sub.f32 %f191, %f795, %f794
  asm("sub.f32 %0, %1, %2;" : "=f"(f191) : "f"(f795), "f"(f794));
  // PTX:723 @%p62 bra $L__BB29_74
  if (p62) { goto L_BB29_74; }
  // PTX:725 ld.global.u32 %r146, [%rd28]
  r146 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (0)))));
  // PTX:726 add.s32 %r147, %r146, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r147) : "r"(r146));
  // PTX:727 setp.gt.u32 %p68, %r147, 2
  p68 = (((unsigned)(r147)) > ((unsigned)(2)));
  // PTX:728 mov.f32 %f949, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f949) : );
  // PTX:729 @%p68 bra $L__BB29_75
  if (p68) { goto L_BB29_75; }
  // PTX:731 $L__BB29_74:
L_BB29_74:;
  // PTX:732 ld.global.f32 %f949, [%rd30]
  f949 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0)))));
  // PTX:734 $L__BB29_75:
L_BB29_75:;
  // PTX:735 mov.f32 %f950, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f950) : );
  // PTX:736 @%p66 bra $L__BB29_77
  if (p66) { goto L_BB29_77; }
  // PTX:738 ld.param.u64 %rd312, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_22]
  rd312 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param22 + (0))));
  // PTX:739 cvta.to.global.u64 %rd311, %rd312
  rd311 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd312));
  // PTX:740 add.s64 %rd201, %rd311, %rd196
  asm("add.s64 %0, %1, %2;" : "=l"(rd201) : "l"(rd311), "l"(rd196));
  // PTX:741 ld.global.f32 %f950, [%rd201]
  f950 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd201) + (0)))));
  // PTX:743 $L__BB29_77:
L_BB29_77:;
  // PTX:744 ld.param.f32 %f919, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_32]
  f919 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param32 + (0))));
  // PTX:745 sub.f32 %f798, %f162, %f182
  asm("sub.f32 %0, %1, %2;" : "=f"(f798) : "f"(f162), "f"(f182));
  // PTX:746 mul.f32 %f799, %f798, %f919
  asm("mul.f32 %0, %1, %2;" : "=f"(f799) : "f"(f798), "f"(f919));
  // PTX:747 sub.f32 %f800, %f799, %f48
  asm("sub.f32 %0, %1, %2;" : "=f"(f800) : "f"(f799), "f"(f48));
  // PTX:748 add.f32 %f801, %f949, %f950
  asm("add.f32 %0, %1, %2;" : "=f"(f801) : "f"(f949), "f"(f950));
  // PTX:749 mul.f32 %f802, %f800, %f801
  asm("mul.f32 %0, %1, %2;" : "=f"(f802) : "f"(f800), "f"(f801));
  // PTX:750 sub.f32 %f196, %f191, %f802
  asm("sub.f32 %0, %1, %2;" : "=f"(f196) : "f"(f191), "f"(f802));
  // PTX:751 abs.f32 %f803, %f196
  asm("abs.f32 %0, %1;" : "=f"(f803) : "f"(f196));
  // PTX:752 setp.geu.f32 %p70, %f803, 0f7F800000
  p70 = ((isnan(((float)(f803))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f803)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:753 setp.le.f32 %p71, %f803, 0f2B8CBCCC
  p71 = (!(isnan(((float)(f803))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) && (((float)(f803)) <= ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:754 or.pred %p72, %p70, %p71
  p72 = ((p70) || (p71));
  // PTX:755 @%p72 bra $L__BB29_80
  if (p72) { goto L_BB29_80; }
  // PTX:757 ld.param.u64 %rd314, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_26]
  rd314 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param26 + (0))));
  // PTX:758 cvta.to.global.u64 %rd313, %rd314
  rd313 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd314));
  // PTX:759 mul.lo.s64 %rd283, %rd22, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd283) : "l"(rd22));
  // PTX:760 mul.lo.s64 %rd282, %rd21, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd282) : "l"(rd21));
  // PTX:761 mul.lo.s64 %rd281, %rd20, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd281) : "l"(rd20));
  // PTX:762 mul.lo.s64 %rd280, %rd19, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd280) : "l"(rd19));
  // PTX:763 mul.f32 %f804, %f196, %f42
  asm("mul.f32 %0, %1, %2;" : "=f"(f804) : "f"(f196), "f"(f42));
  // PTX:764 mul.f32 %f805, %f804, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f805) : "f"(f804), "f"(f20));
  // PTX:765 mul.f32 %f806, %f196, %f43
  asm("mul.f32 %0, %1, %2;" : "=f"(f806) : "f"(f196), "f"(f43));
  // PTX:766 mul.f32 %f807, %f806, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f807) : "f"(f806), "f"(f20));
  // PTX:767 mul.f32 %f808, %f196, %f44
  asm("mul.f32 %0, %1, %2;" : "=f"(f808) : "f"(f196), "f"(f44));
  // PTX:768 mul.f32 %f809, %f808, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f809) : "f"(f808), "f"(f20));
  // PTX:769 mul.f32 %f810, %f804, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f810) : "f"(f804), "f"(f24));
  // PTX:770 mul.f32 %f811, %f806, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f811) : "f"(f806), "f"(f24));
  // PTX:771 mul.f32 %f812, %f808, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f812) : "f"(f808), "f"(f24));
  // PTX:772 mul.f32 %f813, %f804, %f28
  asm("mul.f32 %0, %1, %2;" : "=f"(f813) : "f"(f804), "f"(f28));
  // PTX:773 mul.f32 %f814, %f806, %f28
  asm("mul.f32 %0, %1, %2;" : "=f"(f814) : "f"(f806), "f"(f28));
  // PTX:774 mul.f32 %f815, %f808, %f28
  asm("mul.f32 %0, %1, %2;" : "=f"(f815) : "f"(f808), "f"(f28));
  // PTX:775 mul.f32 %f816, %f804, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f816) : "f"(f804), "f"(f32));
  // PTX:776 mul.f32 %f817, %f806, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f817) : "f"(f806), "f"(f32));
  // PTX:777 mul.f32 %f818, %f808, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f818) : "f"(f808), "f"(f32));
  // PTX:778 add.s64 %rd203, %rd313, %rd280
  asm("add.s64 %0, %1, %2;" : "=l"(rd203) : "l"(rd313), "l"(rd280));
  // PTX:779 red.global.add.f32 [%rd203], %f805
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd203) + (0)))), (float)(f805));
  // PTX:780 add.s64 %rd204, %rd203, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd204) : "l"(rd203));
  // PTX:781 red.global.add.f32 [%rd204], %f807
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd204) + (0)))), (float)(f807));
  // PTX:782 add.s64 %rd205, %rd203, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd205) : "l"(rd203));
  // PTX:783 red.global.add.f32 [%rd205], %f809
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd205) + (0)))), (float)(f809));
  // PTX:784 add.s64 %rd207, %rd313, %rd281
  asm("add.s64 %0, %1, %2;" : "=l"(rd207) : "l"(rd313), "l"(rd281));
  // PTX:785 red.global.add.f32 [%rd207], %f810
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd207) + (0)))), (float)(f810));
  // PTX:786 add.s64 %rd208, %rd207, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd208) : "l"(rd207));
  // PTX:787 red.global.add.f32 [%rd208], %f811
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd208) + (0)))), (float)(f811));
  // PTX:788 add.s64 %rd209, %rd207, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd209) : "l"(rd207));
  // PTX:789 red.global.add.f32 [%rd209], %f812
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd209) + (0)))), (float)(f812));
  // PTX:790 add.s64 %rd211, %rd313, %rd282
  asm("add.s64 %0, %1, %2;" : "=l"(rd211) : "l"(rd313), "l"(rd282));
  // PTX:791 red.global.add.f32 [%rd211], %f813
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd211) + (0)))), (float)(f813));
  // PTX:792 add.s64 %rd212, %rd211, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd212) : "l"(rd211));
  // PTX:793 red.global.add.f32 [%rd212], %f814
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd212) + (0)))), (float)(f814));
  // PTX:794 add.s64 %rd213, %rd211, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd213) : "l"(rd211));
  // PTX:795 red.global.add.f32 [%rd213], %f815
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd213) + (0)))), (float)(f815));
  // PTX:796 add.s64 %rd215, %rd313, %rd283
  asm("add.s64 %0, %1, %2;" : "=l"(rd215) : "l"(rd313), "l"(rd283));
  // PTX:797 red.global.add.f32 [%rd215], %f816
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd215) + (0)))), (float)(f816));
  // PTX:798 add.s64 %rd216, %rd215, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd216) : "l"(rd215));
  // PTX:799 red.global.add.f32 [%rd216], %f817
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd216) + (0)))), (float)(f817));
  // PTX:800 add.s64 %rd217, %rd215, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd217) : "l"(rd215));
  // PTX:801 red.global.add.f32 [%rd217], %f818
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd217) + (0)))), (float)(f818));
  // PTX:802 setp.le.f32 %p74, %f41, 0f322BCC77
  p74 = (!(isnan(((float)(f41))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f41)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:803 or.pred %p75, %p59, %p74
  p75 = ((p59) || (p74));
  // PTX:804 @%p75 bra $L__BB29_80
  if (p75) { goto L_BB29_80; }
  // PTX:806 ld.param.u64 %rd320, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_11]
  rd320 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:807 shl.b64 %rd319, %rd335, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd319) : "l"(rd335));
  // PTX:808 cvta.to.global.u64 %rd318, %rd320
  rd318 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd320));
  // PTX:809 add.s64 %rd317, %rd318, %rd319
  asm("add.s64 %0, %1, %2;" : "=l"(rd317) : "l"(rd318), "l"(rd319));
  // PTX:810 ld.param.u64 %rd316, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_26]
  rd316 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param26 + (0))));
  // PTX:811 cvta.to.global.u64 %rd315, %rd316
  rd315 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd316));
  // PTX:812 mul.f32 %f831, %f162, %f42
  asm("mul.f32 %0, %1, %2;" : "=f"(f831) : "f"(f162), "f"(f42));
  // PTX:813 sub.f32 %f832, %f159, %f831
  asm("sub.f32 %0, %1, %2;" : "=f"(f832) : "f"(f159), "f"(f831));
  // PTX:814 mul.f32 %f833, %f162, %f43
  asm("mul.f32 %0, %1, %2;" : "=f"(f833) : "f"(f162), "f"(f43));
  // PTX:815 sub.f32 %f834, %f160, %f833
  asm("sub.f32 %0, %1, %2;" : "=f"(f834) : "f"(f160), "f"(f833));
  // PTX:816 mul.f32 %f835, %f162, %f44
  asm("mul.f32 %0, %1, %2;" : "=f"(f835) : "f"(f162), "f"(f44));
  // PTX:817 sub.f32 %f836, %f161, %f835
  asm("sub.f32 %0, %1, %2;" : "=f"(f836) : "f"(f161), "f"(f835));
  // PTX:818 div.rn.f32 %f837, %f832, %f41
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f837) : "f"(f832), "f"(f41));
  // PTX:819 div.rn.f32 %f838, %f834, %f41
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f838) : "f"(f834), "f"(f41));
  // PTX:820 div.rn.f32 %f839, %f836, %f41
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f839) : "f"(f836), "f"(f41));
  // PTX:821 add.f32 %f840, %f837, %f42
  asm("add.f32 %0, %1, %2;" : "=f"(f840) : "f"(f837), "f"(f42));
  // PTX:822 add.f32 %f841, %f838, %f43
  asm("add.f32 %0, %1, %2;" : "=f"(f841) : "f"(f838), "f"(f43));
  // PTX:823 add.f32 %f842, %f839, %f44
  asm("add.f32 %0, %1, %2;" : "=f"(f842) : "f"(f839), "f"(f44));
  // PTX:824 neg.f32 %f843, %f196
  asm("neg.f32 %0, %1;" : "=f"(f843) : "f"(f196));
  // PTX:825 mul.f32 %f844, %f840, %f843
  asm("mul.f32 %0, %1, %2;" : "=f"(f844) : "f"(f840), "f"(f843));
  // PTX:826 mul.f32 %f845, %f841, %f843
  asm("mul.f32 %0, %1, %2;" : "=f"(f845) : "f"(f841), "f"(f843));
  // PTX:827 mul.f32 %f846, %f842, %f843
  asm("mul.f32 %0, %1, %2;" : "=f"(f846) : "f"(f842), "f"(f843));
  // PTX:828 ld.global.f32 %f847, [%rd317]
  f847 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd317) + (0)))));
  // PTX:829 mul.f32 %f848, %f844, %f847
  asm("mul.f32 %0, %1, %2;" : "=f"(f848) : "f"(f844), "f"(f847));
  // PTX:830 mul.f32 %f849, %f845, %f847
  asm("mul.f32 %0, %1, %2;" : "=f"(f849) : "f"(f845), "f"(f847));
  // PTX:831 mul.f32 %f850, %f846, %f847
  asm("mul.f32 %0, %1, %2;" : "=f"(f850) : "f"(f846), "f"(f847));
  // PTX:832 ld.global.f32 %f851, [%rd317+4]
  f851 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd317) + (4)))));
  // PTX:833 mul.f32 %f852, %f844, %f851
  asm("mul.f32 %0, %1, %2;" : "=f"(f852) : "f"(f844), "f"(f851));
  // PTX:834 mul.f32 %f853, %f845, %f851
  asm("mul.f32 %0, %1, %2;" : "=f"(f853) : "f"(f845), "f"(f851));
  // PTX:835 mul.f32 %f854, %f846, %f851
  asm("mul.f32 %0, %1, %2;" : "=f"(f854) : "f"(f846), "f"(f851));
  // PTX:836 ld.global.f32 %f855, [%rd317+8]
  f855 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd317) + (8)))));
  // PTX:837 mul.f32 %f856, %f844, %f855
  asm("mul.f32 %0, %1, %2;" : "=f"(f856) : "f"(f844), "f"(f855));
  // PTX:838 mul.f32 %f857, %f845, %f855
  asm("mul.f32 %0, %1, %2;" : "=f"(f857) : "f"(f845), "f"(f855));
  // PTX:839 mul.f32 %f858, %f846, %f855
  asm("mul.f32 %0, %1, %2;" : "=f"(f858) : "f"(f846), "f"(f855));
  // PTX:840 ld.global.f32 %f859, [%rd317+12]
  f859 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd317) + (12)))));
  // PTX:841 mul.f32 %f860, %f844, %f859
  asm("mul.f32 %0, %1, %2;" : "=f"(f860) : "f"(f844), "f"(f859));
  // PTX:842 mul.f32 %f861, %f845, %f859
  asm("mul.f32 %0, %1, %2;" : "=f"(f861) : "f"(f845), "f"(f859));
  // PTX:843 mul.f32 %f862, %f846, %f859
  asm("mul.f32 %0, %1, %2;" : "=f"(f862) : "f"(f846), "f"(f859));
  // PTX:844 mul.wide.s32 %rd218, %r150, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd218) : "r"(r150));
  // PTX:845 add.s64 %rd219, %rd315, %rd218
  asm("add.s64 %0, %1, %2;" : "=l"(rd219) : "l"(rd315), "l"(rd218));
  // PTX:846 red.global.add.f32 [%rd219], %f848
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd219) + (0)))), (float)(f848));
  // PTX:847 add.s64 %rd220, %rd219, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd220) : "l"(rd219));
  // PTX:848 red.global.add.f32 [%rd220], %f849
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd220) + (0)))), (float)(f849));
  // PTX:849 add.s64 %rd221, %rd219, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd221) : "l"(rd219));
  // PTX:850 red.global.add.f32 [%rd221], %f850
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd221) + (0)))), (float)(f850));
  // PTX:851 mul.wide.s32 %rd222, %r151, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd222) : "r"(r151));
  // PTX:852 add.s64 %rd223, %rd315, %rd222
  asm("add.s64 %0, %1, %2;" : "=l"(rd223) : "l"(rd315), "l"(rd222));
  // PTX:853 red.global.add.f32 [%rd223], %f852
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd223) + (0)))), (float)(f852));
  // PTX:854 add.s64 %rd224, %rd223, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd224) : "l"(rd223));
  // PTX:855 red.global.add.f32 [%rd224], %f853
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd224) + (0)))), (float)(f853));
  // PTX:856 add.s64 %rd225, %rd223, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd225) : "l"(rd223));
  // PTX:857 red.global.add.f32 [%rd225], %f854
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd225) + (0)))), (float)(f854));
  // PTX:858 mul.wide.s32 %rd226, %r152, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd226) : "r"(r152));
  // PTX:859 add.s64 %rd227, %rd315, %rd226
  asm("add.s64 %0, %1, %2;" : "=l"(rd227) : "l"(rd315), "l"(rd226));
  // PTX:860 red.global.add.f32 [%rd227], %f856
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd227) + (0)))), (float)(f856));
  // PTX:861 add.s64 %rd228, %rd227, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd228) : "l"(rd227));
  // PTX:862 red.global.add.f32 [%rd228], %f857
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd228) + (0)))), (float)(f857));
  // PTX:863 add.s64 %rd229, %rd227, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd229) : "l"(rd227));
  // PTX:864 red.global.add.f32 [%rd229], %f858
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd229) + (0)))), (float)(f858));
  // PTX:865 mul.wide.s32 %rd230, %r153, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd230) : "r"(r153));
  // PTX:866 add.s64 %rd231, %rd315, %rd230
  asm("add.s64 %0, %1, %2;" : "=l"(rd231) : "l"(rd315), "l"(rd230));
  // PTX:867 red.global.add.f32 [%rd231], %f860
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd231) + (0)))), (float)(f860));
  // PTX:868 add.s64 %rd232, %rd231, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd232) : "l"(rd231));
  // PTX:869 red.global.add.f32 [%rd232], %f861
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd232) + (0)))), (float)(f861));
  // PTX:870 add.s64 %rd233, %rd231, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd233) : "l"(rd231));
  // PTX:871 red.global.add.f32 [%rd233], %f862
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd233) + (0)))), (float)(f862));
  // PTX:872 mul.f32 %f875, %f837, %f196
  asm("mul.f32 %0, %1, %2;" : "=f"(f875) : "f"(f837), "f"(f196));
  // PTX:873 mul.f32 %f876, %f838, %f196
  asm("mul.f32 %0, %1, %2;" : "=f"(f876) : "f"(f838), "f"(f196));
  // PTX:874 mul.f32 %f877, %f839, %f196
  asm("mul.f32 %0, %1, %2;" : "=f"(f877) : "f"(f839), "f"(f196));
  // PTX:875 ld.global.f32 %f878, [%rd16]
  f878 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:876 mul.f32 %f879, %f875, %f878
  asm("mul.f32 %0, %1, %2;" : "=f"(f879) : "f"(f875), "f"(f878));
  // PTX:877 mul.f32 %f880, %f876, %f878
  asm("mul.f32 %0, %1, %2;" : "=f"(f880) : "f"(f876), "f"(f878));
  // PTX:878 mul.f32 %f881, %f877, %f878
  asm("mul.f32 %0, %1, %2;" : "=f"(f881) : "f"(f877), "f"(f878));
  // PTX:879 ld.global.f32 %f882, [%rd16+4]
  f882 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (4)))));
  // PTX:880 mul.f32 %f883, %f875, %f882
  asm("mul.f32 %0, %1, %2;" : "=f"(f883) : "f"(f875), "f"(f882));
  // PTX:881 mul.f32 %f884, %f876, %f882
  asm("mul.f32 %0, %1, %2;" : "=f"(f884) : "f"(f876), "f"(f882));
  // PTX:882 mul.f32 %f885, %f877, %f882
  asm("mul.f32 %0, %1, %2;" : "=f"(f885) : "f"(f877), "f"(f882));
  // PTX:883 ld.global.f32 %f886, [%rd16+8]
  f886 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (8)))));
  // PTX:884 mul.f32 %f887, %f875, %f886
  asm("mul.f32 %0, %1, %2;" : "=f"(f887) : "f"(f875), "f"(f886));
  // PTX:885 mul.f32 %f888, %f876, %f886
  asm("mul.f32 %0, %1, %2;" : "=f"(f888) : "f"(f876), "f"(f886));
  // PTX:886 mul.f32 %f889, %f877, %f886
  asm("mul.f32 %0, %1, %2;" : "=f"(f889) : "f"(f877), "f"(f886));
  // PTX:887 ld.global.f32 %f890, [%rd16+12]
  f890 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (12)))));
  // PTX:888 mul.f32 %f891, %f875, %f890
  asm("mul.f32 %0, %1, %2;" : "=f"(f891) : "f"(f875), "f"(f890));
  // PTX:889 mul.f32 %f892, %f876, %f890
  asm("mul.f32 %0, %1, %2;" : "=f"(f892) : "f"(f876), "f"(f890));
  // PTX:890 mul.f32 %f893, %f877, %f890
  asm("mul.f32 %0, %1, %2;" : "=f"(f893) : "f"(f877), "f"(f890));
  // PTX:891 red.global.add.f32 [%rd219], %f879
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd219) + (0)))), (float)(f879));
  // PTX:892 red.global.add.f32 [%rd220], %f880
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd220) + (0)))), (float)(f880));
  // PTX:893 red.global.add.f32 [%rd221], %f881
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd221) + (0)))), (float)(f881));
  // PTX:894 red.global.add.f32 [%rd223], %f883
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd223) + (0)))), (float)(f883));
  // PTX:895 red.global.add.f32 [%rd224], %f884
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd224) + (0)))), (float)(f884));
  // PTX:896 red.global.add.f32 [%rd225], %f885
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd225) + (0)))), (float)(f885));
  // PTX:897 red.global.add.f32 [%rd227], %f887
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd227) + (0)))), (float)(f887));
  // PTX:898 red.global.add.f32 [%rd228], %f888
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd228) + (0)))), (float)(f888));
  // PTX:899 red.global.add.f32 [%rd229], %f889
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd229) + (0)))), (float)(f889));
  // PTX:900 red.global.add.f32 [%rd231], %f891
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd231) + (0)))), (float)(f891));
  // PTX:901 red.global.add.f32 [%rd232], %f892
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd232) + (0)))), (float)(f892));
  // PTX:902 red.global.add.f32 [%rd233], %f893
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd233) + (0)))), (float)(f893));
  // PTX:904 $L__BB29_80:
L_BB29_80:;
  // PTX:905 ret
  return;
  // PTX:907 $L__BB29_18:
L_BB29_18:;
  // PTX:908 setp.eq.f32 %p19, %f87, 0f7F800000
  p19 = (!(isnan(((float)(f87))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f87)) == ((float)(as_f32(0x7F800000u)))));
  // PTX:909 setp.eq.f32 %p20, %f88, 0f7F800000
  p20 = (!(isnan(((float)(f88))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f88)) == ((float)(as_f32(0x7F800000u)))));
  // PTX:910 and.pred %p21, %p19, %p20
  p21 = ((p19) && (p20));
  // PTX:911 @%p21 bra $L__BB29_20
  if (p21) { goto L_BB29_20; }
  // PTX:912 bra.uni $L__BB29_19
  goto L_BB29_19;
  // PTX:914 $L__BB29_20:
L_BB29_20:;
  // PTX:915 mov.b32 %r99, %f76
  asm("mov.b32 %0, %1;" : "=r"(r99) : "f"(f76));
  // PTX:916 setp.lt.s32 %p25, %r99, 0
  p25 = (((int)(r99)) < ((int)(0)));
  // PTX:917 selp.b32 %r100, 1075235812, 1061752795, %p25
  r100 = p25 ? 1075235812 : 1061752795;
  // PTX:918 mov.b32 %r101, %f75
  asm("mov.b32 %0, %1;" : "=r"(r101) : "f"(f75));
  // PTX:919 and.b32 %r102, %r101, -2147483648
  asm("and.b32 %0, %1, -2147483648;" : "=r"(r102) : "r"(r101));
  // PTX:920 or.b32 %r103, %r102, %r100
  asm("or.b32 %0, %1, %2;" : "=r"(r103) : "r"(r102), "r"(r100));
  // PTX:921 mov.b32 %f926, %r103
  asm("mov.b32 %0, %1;" : "=f"(f926) : "r"(r103));
  // PTX:922 bra.uni $L__BB29_22
  goto L_BB29_22;
  // PTX:924 $L__BB29_19:
L_BB29_19:;
  // PTX:925 max.f32 %f346, %f88, %f87
  asm("max.f32 %0, %1, %2;" : "=f"(f346) : "f"(f88), "f"(f87));
  // PTX:926 min.f32 %f347, %f88, %f87
  asm("min.f32 %0, %1, %2;" : "=f"(f347) : "f"(f88), "f"(f87));
  // PTX:927 div.rn.f32 %f348, %f347, %f346
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f348) : "f"(f347), "f"(f346));
  // PTX:928 mul.rn.f32 %f349, %f348, %f348
  asm("mul.rn.f32 %0, %1, %2;" : "=f"(f349) : "f"(f348), "f"(f348));
  // PTX:929 mov.f32 %f350, 0fC0B59883
  asm("mov.f32 %0, 0fC0B59883;" : "=f"(f350) : );
  // PTX:930 mov.f32 %f351, 0fBF52C7EA
  asm("mov.f32 %0, 0fBF52C7EA;" : "=f"(f351) : );
  // PTX:931 fma.rn.f32 %f352, %f349, %f351, %f350
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f352) : "f"(f349), "f"(f351), "f"(f350));
  // PTX:932 mov.f32 %f353, 0fC0D21907
  asm("mov.f32 %0, 0fC0D21907;" : "=f"(f353) : );
  // PTX:933 fma.rn.f32 %f354, %f352, %f349, %f353
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f354) : "f"(f352), "f"(f349), "f"(f353));
  // PTX:934 mul.f32 %f355, %f349, %f354
  asm("mul.f32 %0, %1, %2;" : "=f"(f355) : "f"(f349), "f"(f354));
  // PTX:935 mul.f32 %f356, %f348, %f355
  asm("mul.f32 %0, %1, %2;" : "=f"(f356) : "f"(f348), "f"(f355));
  // PTX:936 add.f32 %f357, %f349, 0f41355DC0
  asm("add.f32 %0, %1, 0f41355DC0;" : "=f"(f357) : "f"(f349));
  // PTX:937 mov.f32 %f358, 0f41E6BD60
  asm("mov.f32 %0, 0f41E6BD60;" : "=f"(f358) : );
  // PTX:938 fma.rn.f32 %f359, %f357, %f349, %f358
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f359) : "f"(f357), "f"(f349), "f"(f358));
  // PTX:939 mov.f32 %f360, 0f419D92C8
  asm("mov.f32 %0, 0f419D92C8;" : "=f"(f360) : );
  // PTX:940 fma.rn.f32 %f361, %f359, %f349, %f360
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f361) : "f"(f359), "f"(f349), "f"(f360));
  // PTX:941 rcp.rn.f32 %f362, %f361
  asm("rcp.rn.f32 %0, %1;" : "=f"(f362) : "f"(f361));
  // PTX:942 fma.rn.f32 %f363, %f356, %f362, %f348
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f363) : "f"(f356), "f"(f362), "f"(f348));
  // PTX:943 mov.f32 %f364, 0f3FC90FDB
  asm("mov.f32 %0, 0f3FC90FDB;" : "=f"(f364) : );
  // PTX:944 sub.f32 %f365, %f364, %f363
  asm("sub.f32 %0, %1, %2;" : "=f"(f365) : "f"(f364), "f"(f363));
  // PTX:945 setp.gt.f32 %p22, %f88, %f87
  p22 = (!(isnan(((float)(f88))) || isnan(((float)(f87)))) && (((float)(f88)) > ((float)(f87))));
  // PTX:946 selp.f32 %f366, %f365, %f363, %p22
  f366 = p22 ? f365 : f363;
  // PTX:947 mov.b32 %r94, %f76
  asm("mov.b32 %0, %1;" : "=r"(r94) : "f"(f76));
  // PTX:948 setp.lt.s32 %p23, %r94, 0
  p23 = (((int)(r94)) < ((int)(0)));
  // PTX:949 mov.f32 %f367, 0f40490FDB
  asm("mov.f32 %0, 0f40490FDB;" : "=f"(f367) : );
  // PTX:950 sub.f32 %f368, %f367, %f366
  asm("sub.f32 %0, %1, %2;" : "=f"(f368) : "f"(f367), "f"(f366));
  // PTX:951 selp.f32 %f369, %f368, %f366, %p23
  f369 = p23 ? f368 : f366;
  // PTX:952 mov.b32 %r95, %f369
  asm("mov.b32 %0, %1;" : "=r"(r95) : "f"(f369));
  // PTX:953 mov.b32 %r96, %f75
  asm("mov.b32 %0, %1;" : "=r"(r96) : "f"(f75));
  // PTX:954 and.b32 %r97, %r96, -2147483648
  asm("and.b32 %0, %1, -2147483648;" : "=r"(r97) : "r"(r96));
  // PTX:955 or.b32 %r98, %r97, %r95
  asm("or.b32 %0, %1, %2;" : "=r"(r98) : "r"(r97), "r"(r95));
  // PTX:956 mov.b32 %f370, %r98
  asm("mov.b32 %0, %1;" : "=f"(f370) : "r"(r98));
  // PTX:957 add.f32 %f371, %f87, %f88
  asm("add.f32 %0, %1, %2;" : "=f"(f371) : "f"(f87), "f"(f88));
  // PTX:958 setp.le.f32 %p24, %f371, 0f7F800000
  p24 = (!(isnan(((float)(f371))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f371)) <= ((float)(as_f32(0x7F800000u)))));
  // PTX:959 selp.f32 %f926, %f370, %f371, %p24
  f926 = p24 ? f370 : f371;
  // PTX:961 $L__BB29_22:
L_BB29_22:;
  // PTX:962 cvt.u32.u64 %r110, %rd14
  asm("cvt.u32.u64 %0, %1;" : "=r"(r110) : "l"(rd14));
  // PTX:963 setp.lt.s32 %p26, %r110, 0
  p26 = (((int)(r110)) < ((int)(0)));
  // PTX:964 div.rn.f32 %f93, %f78, %f67
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f93) : "f"(f78), "f"(f67));
  // PTX:965 div.rn.f32 %f94, %f79, %f67
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f94) : "f"(f79), "f"(f67));
  // PTX:966 div.rn.f32 %f95, %f80, %f67
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f95) : "f"(f80), "f"(f67));
  // PTX:967 neg.f32 %f372, %f78
  asm("neg.f32 %0, %1;" : "=f"(f372) : "f"(f78));
  // PTX:968 div.rn.f32 %f96, %f372, %f67
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f96) : "f"(f372), "f"(f67));
  // PTX:969 neg.f32 %f373, %f79
  asm("neg.f32 %0, %1;" : "=f"(f373) : "f"(f79));
  // PTX:970 div.rn.f32 %f97, %f373, %f67
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f97) : "f"(f373), "f"(f67));
  // PTX:971 neg.f32 %f374, %f80
  asm("neg.f32 %0, %1;" : "=f"(f374) : "f"(f80));
  // PTX:972 div.rn.f32 %f98, %f374, %f67
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f98) : "f"(f374), "f"(f67));
  // PTX:973 neg.f32 %f375, %f81
  asm("neg.f32 %0, %1;" : "=f"(f375) : "f"(f81));
  // PTX:974 div.rn.f32 %f99, %f375, %f68
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f99) : "f"(f375), "f"(f68));
  // PTX:975 neg.f32 %f376, %f82
  asm("neg.f32 %0, %1;" : "=f"(f376) : "f"(f82));
  // PTX:976 div.rn.f32 %f100, %f376, %f68
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f100) : "f"(f376), "f"(f68));
  // PTX:977 neg.f32 %f377, %f83
  asm("neg.f32 %0, %1;" : "=f"(f377) : "f"(f83));
  // PTX:978 div.rn.f32 %f101, %f377, %f68
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f101) : "f"(f377), "f"(f68));
  // PTX:979 div.rn.f32 %f102, %f81, %f68
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f102) : "f"(f81), "f"(f68));
  // PTX:980 div.rn.f32 %f103, %f82, %f68
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f103) : "f"(f82), "f"(f68));
  // PTX:981 div.rn.f32 %f104, %f83, %f68
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f104) : "f"(f83), "f"(f68));
  // PTX:982 @%p26 bra $L__BB29_24
  if (p26) { goto L_BB29_24; }
  // PTX:984 ld.param.u64 %rd307, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_11]
  rd307 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:985 shl.b64 %rd306, %rd335, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd306) : "l"(rd335));
  // PTX:986 cvta.to.global.u64 %rd305, %rd307
  rd305 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd307));
  // PTX:987 add.s64 %rd304, %rd305, %rd306
  asm("add.s64 %0, %1, %2;" : "=l"(rd304) : "l"(rd305), "l"(rd306));
  // PTX:988 ld.param.u64 %rd269, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_1]
  rd269 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:989 cvta.to.global.u64 %rd268, %rd269
  rd268 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd269));
  // PTX:990 ld.param.u64 %rd267, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_14]
  rd267 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:991 shl.b64 %rd266, %rd335, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd266) : "l"(rd335));
  // PTX:992 cvta.to.global.u64 %rd265, %rd267
  rd265 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd267));
  // PTX:993 add.s64 %rd264, %rd265, %rd266
  asm("add.s64 %0, %1, %2;" : "=l"(rd264) : "l"(rd265), "l"(rd266));
  // PTX:994 ld.global.f32 %f378, [%rd304]
  f378 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd304) + (0)))));
  // PTX:995 mul.wide.s32 %rd139, %r150, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd139) : "r"(r150));
  // PTX:996 add.s64 %rd140, %rd268, %rd139
  asm("add.s64 %0, %1, %2;" : "=l"(rd140) : "l"(rd268), "l"(rd139));
  // PTX:997 ld.global.f32 %f379, [%rd140]
  f379 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd140) + (0)))));
  // PTX:998 ld.global.f32 %f380, [%rd140+4]
  f380 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd140) + (4)))));
  // PTX:999 ld.global.f32 %f381, [%rd140+8]
  f381 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd140) + (8)))));
  // PTX:1000 mul.wide.s32 %rd141, %r151, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd141) : "r"(r151));
  // PTX:1001 add.s64 %rd142, %rd268, %rd141
  asm("add.s64 %0, %1, %2;" : "=l"(rd142) : "l"(rd268), "l"(rd141));
  // PTX:1002 ld.global.f32 %f382, [%rd142]
  f382 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd142) + (0)))));
  // PTX:1003 ld.global.f32 %f383, [%rd304+4]
  f383 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd304) + (4)))));
  // PTX:1004 mul.f32 %f384, %f383, %f382
  asm("mul.f32 %0, %1, %2;" : "=f"(f384) : "f"(f383), "f"(f382));
  // PTX:1005 ld.global.f32 %f385, [%rd142+4]
  f385 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd142) + (4)))));
  // PTX:1006 mul.f32 %f386, %f383, %f385
  asm("mul.f32 %0, %1, %2;" : "=f"(f386) : "f"(f383), "f"(f385));
  // PTX:1007 ld.global.f32 %f387, [%rd142+8]
  f387 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd142) + (8)))));
  // PTX:1008 mul.f32 %f388, %f383, %f387
  asm("mul.f32 %0, %1, %2;" : "=f"(f388) : "f"(f383), "f"(f387));
  // PTX:1009 fma.rn.f32 %f389, %f378, %f379, %f384
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f389) : "f"(f378), "f"(f379), "f"(f384));
  // PTX:1010 fma.rn.f32 %f390, %f378, %f380, %f386
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f390) : "f"(f378), "f"(f380), "f"(f386));
  // PTX:1011 fma.rn.f32 %f391, %f378, %f381, %f388
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f391) : "f"(f378), "f"(f381), "f"(f388));
  // PTX:1012 mul.wide.s32 %rd143, %r152, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd143) : "r"(r152));
  // PTX:1013 add.s64 %rd144, %rd268, %rd143
  asm("add.s64 %0, %1, %2;" : "=l"(rd144) : "l"(rd268), "l"(rd143));
  // PTX:1014 ld.global.f32 %f392, [%rd144]
  f392 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd144) + (0)))));
  // PTX:1015 ld.global.f32 %f393, [%rd304+8]
  f393 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd304) + (8)))));
  // PTX:1016 ld.global.f32 %f394, [%rd144+4]
  f394 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd144) + (4)))));
  // PTX:1017 ld.global.f32 %f395, [%rd144+8]
  f395 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd144) + (8)))));
  // PTX:1018 fma.rn.f32 %f396, %f393, %f392, %f389
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f396) : "f"(f393), "f"(f392), "f"(f389));
  // PTX:1019 fma.rn.f32 %f397, %f393, %f394, %f390
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f397) : "f"(f393), "f"(f394), "f"(f390));
  // PTX:1020 fma.rn.f32 %f398, %f393, %f395, %f391
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f398) : "f"(f393), "f"(f395), "f"(f391));
  // PTX:1021 mul.wide.s32 %rd145, %r153, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd145) : "r"(r153));
  // PTX:1022 add.s64 %rd146, %rd268, %rd145
  asm("add.s64 %0, %1, %2;" : "=l"(rd146) : "l"(rd268), "l"(rd145));
  // PTX:1023 ld.global.f32 %f399, [%rd146]
  f399 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd146) + (0)))));
  // PTX:1024 ld.global.f32 %f400, [%rd304+12]
  f400 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd304) + (12)))));
  // PTX:1025 ld.global.f32 %f401, [%rd146+4]
  f401 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd146) + (4)))));
  // PTX:1026 ld.global.f32 %f402, [%rd146+8]
  f402 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd146) + (8)))));
  // PTX:1027 fma.rn.f32 %f927, %f400, %f399, %f396
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f927) : "f"(f400), "f"(f399), "f"(f396));
  // PTX:1028 fma.rn.f32 %f928, %f400, %f401, %f397
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f928) : "f"(f400), "f"(f401), "f"(f397));
  // PTX:1029 fma.rn.f32 %f929, %f400, %f402, %f398
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f929) : "f"(f400), "f"(f402), "f"(f398));
  // PTX:1030 ld.global.f32 %f406, [%rd16]
  f406 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:1031 ld.global.f32 %f407, [%rd16+4]
  f407 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (4)))));
  // PTX:1032 mul.f32 %f408, %f407, %f382
  asm("mul.f32 %0, %1, %2;" : "=f"(f408) : "f"(f407), "f"(f382));
  // PTX:1033 mul.f32 %f409, %f407, %f385
  asm("mul.f32 %0, %1, %2;" : "=f"(f409) : "f"(f407), "f"(f385));
  // PTX:1034 mul.f32 %f410, %f407, %f387
  asm("mul.f32 %0, %1, %2;" : "=f"(f410) : "f"(f407), "f"(f387));
  // PTX:1035 fma.rn.f32 %f411, %f406, %f379, %f408
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f411) : "f"(f406), "f"(f379), "f"(f408));
  // PTX:1036 fma.rn.f32 %f412, %f406, %f380, %f409
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f412) : "f"(f406), "f"(f380), "f"(f409));
  // PTX:1037 fma.rn.f32 %f413, %f406, %f381, %f410
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f413) : "f"(f406), "f"(f381), "f"(f410));
  // PTX:1038 ld.global.f32 %f414, [%rd16+8]
  f414 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (8)))));
  // PTX:1039 fma.rn.f32 %f415, %f414, %f392, %f411
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f415) : "f"(f414), "f"(f392), "f"(f411));
  // PTX:1040 fma.rn.f32 %f416, %f414, %f394, %f412
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f416) : "f"(f414), "f"(f394), "f"(f412));
  // PTX:1041 fma.rn.f32 %f417, %f414, %f395, %f413
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f417) : "f"(f414), "f"(f395), "f"(f413));
  // PTX:1042 ld.global.f32 %f418, [%rd16+12]
  f418 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (12)))));
  // PTX:1043 fma.rn.f32 %f930, %f418, %f399, %f415
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f930) : "f"(f418), "f"(f399), "f"(f415));
  // PTX:1044 fma.rn.f32 %f931, %f418, %f401, %f416
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f931) : "f"(f418), "f"(f401), "f"(f416));
  // PTX:1045 fma.rn.f32 %f932, %f418, %f402, %f417
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f932) : "f"(f418), "f"(f402), "f"(f417));
  // PTX:1046 ld.global.f32 %f422, [%rd264]
  f422 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd264) + (0)))));
  // PTX:1047 ld.global.f32 %f423, [%rd264+4]
  f423 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd264) + (4)))));
  // PTX:1048 mul.f32 %f424, %f423, %f382
  asm("mul.f32 %0, %1, %2;" : "=f"(f424) : "f"(f423), "f"(f382));
  // PTX:1049 mul.f32 %f425, %f423, %f385
  asm("mul.f32 %0, %1, %2;" : "=f"(f425) : "f"(f423), "f"(f385));
  // PTX:1050 mul.f32 %f426, %f423, %f387
  asm("mul.f32 %0, %1, %2;" : "=f"(f426) : "f"(f423), "f"(f387));
  // PTX:1051 fma.rn.f32 %f427, %f422, %f379, %f424
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f427) : "f"(f422), "f"(f379), "f"(f424));
  // PTX:1052 fma.rn.f32 %f428, %f422, %f380, %f425
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f428) : "f"(f422), "f"(f380), "f"(f425));
  // PTX:1053 fma.rn.f32 %f429, %f422, %f381, %f426
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f429) : "f"(f422), "f"(f381), "f"(f426));
  // PTX:1054 ld.global.f32 %f430, [%rd264+8]
  f430 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd264) + (8)))));
  // PTX:1055 fma.rn.f32 %f431, %f430, %f392, %f427
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f431) : "f"(f430), "f"(f392), "f"(f427));
  // PTX:1056 fma.rn.f32 %f432, %f430, %f394, %f428
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f432) : "f"(f430), "f"(f394), "f"(f428));
  // PTX:1057 fma.rn.f32 %f433, %f430, %f395, %f429
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f433) : "f"(f430), "f"(f395), "f"(f429));
  // PTX:1058 ld.global.f32 %f434, [%rd264+12]
  f434 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd264) + (12)))));
  // PTX:1059 fma.rn.f32 %f435, %f434, %f399, %f431
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f435) : "f"(f434), "f"(f399), "f"(f431));
  // PTX:1060 fma.rn.f32 %f436, %f434, %f401, %f432
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f436) : "f"(f434), "f"(f401), "f"(f432));
  // PTX:1061 fma.rn.f32 %f437, %f434, %f402, %f433
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f437) : "f"(f434), "f"(f402), "f"(f433));
  // PTX:1062 mov.b32 %r168, %f437
  asm("mov.b32 %0, %1;" : "=r"(r168) : "f"(f437));
  // PTX:1063 mov.b32 %r167, %f436
  asm("mov.b32 %0, %1;" : "=r"(r167) : "f"(f436));
  // PTX:1064 mov.b32 %r166, %f435
  asm("mov.b32 %0, %1;" : "=r"(r166) : "f"(f435));
  // PTX:1066 $L__BB29_24:
L_BB29_24:;
  // PTX:1067 ld.global.f32 %f438, [%rd24]
  f438 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (0)))));
  // PTX:1068 ld.global.f32 %f439, [%rd24+4]
  f439 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (4)))));
  // PTX:1069 ld.global.f32 %f440, [%rd24+8]
  f440 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (8)))));
  // PTX:1070 ld.global.f32 %f441, [%rd25]
  f441 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (0)))));
  // PTX:1071 mul.f32 %f442, %f24, %f441
  asm("mul.f32 %0, %1, %2;" : "=f"(f442) : "f"(f24), "f"(f441));
  // PTX:1072 ld.global.f32 %f443, [%rd25+4]
  f443 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (4)))));
  // PTX:1073 mul.f32 %f444, %f24, %f443
  asm("mul.f32 %0, %1, %2;" : "=f"(f444) : "f"(f24), "f"(f443));
  // PTX:1074 ld.global.f32 %f445, [%rd25+8]
  f445 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (8)))));
  // PTX:1075 mul.f32 %f446, %f24, %f445
  asm("mul.f32 %0, %1, %2;" : "=f"(f446) : "f"(f24), "f"(f445));
  // PTX:1076 fma.rn.f32 %f447, %f20, %f438, %f442
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f447) : "f"(f20), "f"(f438), "f"(f442));
  // PTX:1077 fma.rn.f32 %f448, %f20, %f439, %f444
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f448) : "f"(f20), "f"(f439), "f"(f444));
  // PTX:1078 fma.rn.f32 %f449, %f20, %f440, %f446
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f449) : "f"(f20), "f"(f440), "f"(f446));
  // PTX:1079 ld.global.f32 %f450, [%rd26]
  f450 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (0)))));
  // PTX:1080 ld.global.f32 %f451, [%rd26+4]
  f451 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (4)))));
  // PTX:1081 ld.global.f32 %f452, [%rd26+8]
  f452 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (8)))));
  // PTX:1082 fma.rn.f32 %f453, %f28, %f450, %f447
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f453) : "f"(f28), "f"(f450), "f"(f447));
  // PTX:1083 fma.rn.f32 %f454, %f28, %f451, %f448
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f454) : "f"(f28), "f"(f451), "f"(f448));
  // PTX:1084 fma.rn.f32 %f455, %f28, %f452, %f449
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f455) : "f"(f28), "f"(f452), "f"(f449));
  // PTX:1085 ld.global.f32 %f456, [%rd27]
  f456 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))));
  // PTX:1086 ld.global.f32 %f457, [%rd27+4]
  f457 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (4)))));
  // PTX:1087 ld.global.f32 %f458, [%rd27+8]
  f458 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (8)))));
  // PTX:1088 fma.rn.f32 %f105, %f32, %f456, %f453
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f105) : "f"(f32), "f"(f456), "f"(f453));
  // PTX:1089 fma.rn.f32 %f106, %f32, %f457, %f454
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f106) : "f"(f32), "f"(f457), "f"(f454));
  // PTX:1090 fma.rn.f32 %f107, %f32, %f458, %f455
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f107) : "f"(f32), "f"(f458), "f"(f455));
  // PTX:1091 mul.f32 %f459, %f50, %f441
  asm("mul.f32 %0, %1, %2;" : "=f"(f459) : "f"(f50), "f"(f441));
  // PTX:1092 mul.f32 %f460, %f50, %f443
  asm("mul.f32 %0, %1, %2;" : "=f"(f460) : "f"(f50), "f"(f443));
  // PTX:1093 mul.f32 %f461, %f50, %f445
  asm("mul.f32 %0, %1, %2;" : "=f"(f461) : "f"(f50), "f"(f445));
  // PTX:1094 fma.rn.f32 %f462, %f49, %f438, %f459
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f462) : "f"(f49), "f"(f438), "f"(f459));
  // PTX:1095 fma.rn.f32 %f463, %f49, %f439, %f460
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f463) : "f"(f49), "f"(f439), "f"(f460));
  // PTX:1096 fma.rn.f32 %f464, %f49, %f440, %f461
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f464) : "f"(f49), "f"(f440), "f"(f461));
  // PTX:1097 fma.rn.f32 %f465, %f51, %f450, %f462
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f465) : "f"(f51), "f"(f450), "f"(f462));
  // PTX:1098 fma.rn.f32 %f466, %f51, %f451, %f463
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f466) : "f"(f51), "f"(f451), "f"(f463));
  // PTX:1099 fma.rn.f32 %f467, %f51, %f452, %f464
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f467) : "f"(f51), "f"(f452), "f"(f464));
  // PTX:1100 fma.rn.f32 %f108, %f52, %f456, %f465
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f108) : "f"(f52), "f"(f456), "f"(f465));
  // PTX:1101 fma.rn.f32 %f109, %f52, %f457, %f466
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f109) : "f"(f52), "f"(f457), "f"(f466));
  // PTX:1102 fma.rn.f32 %f110, %f52, %f458, %f467
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f110) : "f"(f52), "f"(f458), "f"(f467));
  // PTX:1103 sub.f32 %f112, %f930, %f927
  asm("sub.f32 %0, %1, %2;" : "=f"(f112) : "f"(f930), "f"(f927));
  // PTX:1104 sub.f32 %f114, %f931, %f928
  asm("sub.f32 %0, %1, %2;" : "=f"(f114) : "f"(f931), "f"(f928));
  // PTX:1105 sub.f32 %f116, %f932, %f929
  asm("sub.f32 %0, %1, %2;" : "=f"(f116) : "f"(f932), "f"(f929));
  // PTX:1106 mul.f32 %f471, %f114, %f114
  asm("mul.f32 %0, %1, %2;" : "=f"(f471) : "f"(f114), "f"(f114));
  // PTX:1107 fma.rn.f32 %f472, %f112, %f112, %f471
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f472) : "f"(f112), "f"(f112), "f"(f471));
  // PTX:1108 fma.rn.f32 %f473, %f116, %f116, %f472
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f473) : "f"(f116), "f"(f116), "f"(f472));
  // PTX:1109 sqrt.rn.f32 %f117, %f473
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f117) : "f"(f473));
  // PTX:1110 setp.leu.f32 %p27, %f117, 0f322BCC77
  p27 = ((isnan(((float)(f117))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f117)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:1111 @%p27 bra $L__BB29_80
  if (p27) { goto L_BB29_80; }
  // PTX:1113 abs.f32 %f474, %f117
  asm("abs.f32 %0, %1;" : "=f"(f474) : "f"(f117));
  // PTX:1114 setp.geu.f32 %p28, %f474, 0f7F800000
  p28 = ((isnan(((float)(f474))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f474)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1115 @%p28 bra $L__BB29_80
  if (p28) { goto L_BB29_80; }
  // PTX:1117 div.rn.f32 %f118, %f112, %f117
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f118) : "f"(f112), "f"(f117));
  // PTX:1118 mov.b32 %f475, %r166
  asm("mov.b32 %0, %1;" : "=f"(f475) : "r"(r166));
  // PTX:1119 sub.f32 %f476, %f475, %f927
  asm("sub.f32 %0, %1, %2;" : "=f"(f476) : "f"(f475), "f"(f927));
  // PTX:1120 mov.b32 %f477, %r167
  asm("mov.b32 %0, %1;" : "=f"(f477) : "r"(r167));
  // PTX:1121 sub.f32 %f478, %f477, %f928
  asm("sub.f32 %0, %1, %2;" : "=f"(f478) : "f"(f477), "f"(f928));
  // PTX:1122 mov.b32 %f479, %r168
  asm("mov.b32 %0, %1;" : "=f"(f479) : "r"(r168));
  // PTX:1123 sub.f32 %f480, %f479, %f929
  asm("sub.f32 %0, %1, %2;" : "=f"(f480) : "f"(f479), "f"(f929));
  // PTX:1124 div.rn.f32 %f119, %f114, %f117
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f119) : "f"(f114), "f"(f117));
  // PTX:1125 mul.f32 %f481, %f478, %f119
  asm("mul.f32 %0, %1, %2;" : "=f"(f481) : "f"(f478), "f"(f119));
  // PTX:1126 div.rn.f32 %f120, %f116, %f117
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f120) : "f"(f116), "f"(f117));
  // PTX:1127 fma.rn.f32 %f482, %f476, %f118, %f481
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f482) : "f"(f476), "f"(f118), "f"(f481));
  // PTX:1128 fma.rn.f32 %f483, %f480, %f120, %f482
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f483) : "f"(f480), "f"(f120), "f"(f482));
  // PTX:1129 mul.f32 %f484, %f118, %f483
  asm("mul.f32 %0, %1, %2;" : "=f"(f484) : "f"(f118), "f"(f483));
  // PTX:1130 mul.f32 %f485, %f119, %f483
  asm("mul.f32 %0, %1, %2;" : "=f"(f485) : "f"(f119), "f"(f483));
  // PTX:1131 mul.f32 %f486, %f120, %f483
  asm("mul.f32 %0, %1, %2;" : "=f"(f486) : "f"(f120), "f"(f483));
  // PTX:1132 sub.f32 %f121, %f476, %f484
  asm("sub.f32 %0, %1, %2;" : "=f"(f121) : "f"(f476), "f"(f484));
  // PTX:1133 sub.f32 %f122, %f478, %f485
  asm("sub.f32 %0, %1, %2;" : "=f"(f122) : "f"(f478), "f"(f485));
  // PTX:1134 sub.f32 %f123, %f480, %f486
  asm("sub.f32 %0, %1, %2;" : "=f"(f123) : "f"(f480), "f"(f486));
  // PTX:1135 sub.f32 %f487, %f108, %f105
  asm("sub.f32 %0, %1, %2;" : "=f"(f487) : "f"(f108), "f"(f105));
  // PTX:1136 sub.f32 %f488, %f109, %f106
  asm("sub.f32 %0, %1, %2;" : "=f"(f488) : "f"(f109), "f"(f106));
  // PTX:1137 mul.f32 %f489, %f488, %f119
  asm("mul.f32 %0, %1, %2;" : "=f"(f489) : "f"(f488), "f"(f119));
  // PTX:1138 sub.f32 %f490, %f110, %f107
  asm("sub.f32 %0, %1, %2;" : "=f"(f490) : "f"(f110), "f"(f107));
  // PTX:1139 fma.rn.f32 %f491, %f487, %f118, %f489
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f491) : "f"(f487), "f"(f118), "f"(f489));
  // PTX:1140 fma.rn.f32 %f492, %f120, %f490, %f491
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f492) : "f"(f120), "f"(f490), "f"(f491));
  // PTX:1141 mul.f32 %f493, %f118, %f492
  asm("mul.f32 %0, %1, %2;" : "=f"(f493) : "f"(f118), "f"(f492));
  // PTX:1142 mul.f32 %f494, %f119, %f492
  asm("mul.f32 %0, %1, %2;" : "=f"(f494) : "f"(f119), "f"(f492));
  // PTX:1143 mul.f32 %f495, %f120, %f492
  asm("mul.f32 %0, %1, %2;" : "=f"(f495) : "f"(f120), "f"(f492));
  // PTX:1144 sub.f32 %f124, %f487, %f493
  asm("sub.f32 %0, %1, %2;" : "=f"(f124) : "f"(f487), "f"(f493));
  // PTX:1145 sub.f32 %f125, %f488, %f494
  asm("sub.f32 %0, %1, %2;" : "=f"(f125) : "f"(f488), "f"(f494));
  // PTX:1146 sub.f32 %f126, %f490, %f495
  asm("sub.f32 %0, %1, %2;" : "=f"(f126) : "f"(f490), "f"(f495));
  // PTX:1147 mul.f32 %f496, %f122, %f122
  asm("mul.f32 %0, %1, %2;" : "=f"(f496) : "f"(f122), "f"(f122));
  // PTX:1148 fma.rn.f32 %f497, %f121, %f121, %f496
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f497) : "f"(f121), "f"(f121), "f"(f496));
  // PTX:1149 fma.rn.f32 %f498, %f123, %f123, %f497
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f498) : "f"(f123), "f"(f123), "f"(f497));
  // PTX:1150 sqrt.rn.f32 %f127, %f498
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f127) : "f"(f498));
  // PTX:1151 mul.f32 %f499, %f125, %f125
  asm("mul.f32 %0, %1, %2;" : "=f"(f499) : "f"(f125), "f"(f125));
  // PTX:1152 fma.rn.f32 %f500, %f124, %f124, %f499
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f500) : "f"(f124), "f"(f124), "f"(f499));
  // PTX:1153 fma.rn.f32 %f501, %f126, %f126, %f500
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f501) : "f"(f126), "f"(f126), "f"(f500));
  // PTX:1154 sqrt.rn.f32 %f128, %f501
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f128) : "f"(f501));
  // PTX:1155 setp.leu.f32 %p29, %f127, 0f322BCC77
  p29 = ((isnan(((float)(f127))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f127)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:1156 setp.leu.f32 %p30, %f128, 0f322BCC77
  p30 = ((isnan(((float)(f128))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f128)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:1157 or.pred %p31, %p29, %p30
  p31 = ((p29) || (p30));
  // PTX:1158 @%p31 bra $L__BB29_80
  if (p31) { goto L_BB29_80; }
  // PTX:1160 abs.f32 %f502, %f127
  asm("abs.f32 %0, %1;" : "=f"(f502) : "f"(f127));
  // PTX:1161 setp.geu.f32 %p32, %f502, 0f7F800000
  p32 = ((isnan(((float)(f502))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f502)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1162 @%p32 bra $L__BB29_80
  if (p32) { goto L_BB29_80; }
  // PTX:1164 abs.f32 %f503, %f128
  asm("abs.f32 %0, %1;" : "=f"(f503) : "f"(f128));
  // PTX:1165 setp.geu.f32 %p33, %f503, 0f7F800000
  p33 = ((isnan(((float)(f503))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f503)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1166 @%p33 bra $L__BB29_80
  if (p33) { goto L_BB29_80; }
  // PTX:1168 div.rn.f32 %f504, %f121, %f127
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f504) : "f"(f121), "f"(f127));
  // PTX:1169 div.rn.f32 %f505, %f126, %f128
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f505) : "f"(f126), "f"(f128));
  // PTX:1170 div.rn.f32 %f506, %f122, %f127
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f506) : "f"(f122), "f"(f127));
  // PTX:1171 mul.f32 %f507, %f506, %f505
  asm("mul.f32 %0, %1, %2;" : "=f"(f507) : "f"(f506), "f"(f505));
  // PTX:1172 div.rn.f32 %f508, %f125, %f128
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f508) : "f"(f125), "f"(f128));
  // PTX:1173 div.rn.f32 %f509, %f123, %f127
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f509) : "f"(f123), "f"(f127));
  // PTX:1174 mul.f32 %f510, %f509, %f508
  asm("mul.f32 %0, %1, %2;" : "=f"(f510) : "f"(f509), "f"(f508));
  // PTX:1175 sub.f32 %f511, %f507, %f510
  asm("sub.f32 %0, %1, %2;" : "=f"(f511) : "f"(f507), "f"(f510));
  // PTX:1176 div.rn.f32 %f512, %f124, %f128
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f512) : "f"(f124), "f"(f128));
  // PTX:1177 mul.f32 %f513, %f509, %f512
  asm("mul.f32 %0, %1, %2;" : "=f"(f513) : "f"(f509), "f"(f512));
  // PTX:1178 mul.f32 %f514, %f504, %f505
  asm("mul.f32 %0, %1, %2;" : "=f"(f514) : "f"(f504), "f"(f505));
  // PTX:1179 sub.f32 %f515, %f513, %f514
  asm("sub.f32 %0, %1, %2;" : "=f"(f515) : "f"(f513), "f"(f514));
  // PTX:1180 mul.f32 %f516, %f504, %f508
  asm("mul.f32 %0, %1, %2;" : "=f"(f516) : "f"(f504), "f"(f508));
  // PTX:1181 mul.f32 %f517, %f506, %f512
  asm("mul.f32 %0, %1, %2;" : "=f"(f517) : "f"(f506), "f"(f512));
  // PTX:1182 sub.f32 %f518, %f516, %f517
  asm("sub.f32 %0, %1, %2;" : "=f"(f518) : "f"(f516), "f"(f517));
  // PTX:1183 mul.f32 %f519, %f119, %f515
  asm("mul.f32 %0, %1, %2;" : "=f"(f519) : "f"(f119), "f"(f515));
  // PTX:1184 fma.rn.f32 %f520, %f118, %f511, %f519
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f520) : "f"(f118), "f"(f511), "f"(f519));
  // PTX:1185 fma.rn.f32 %f129, %f120, %f518, %f520
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f129) : "f"(f120), "f"(f518), "f"(f520));
  // PTX:1186 mul.f32 %f521, %f506, %f508
  asm("mul.f32 %0, %1, %2;" : "=f"(f521) : "f"(f506), "f"(f508));
  // PTX:1187 fma.rn.f32 %f522, %f504, %f512, %f521
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f522) : "f"(f504), "f"(f512), "f"(f521));
  // PTX:1188 fma.rn.f32 %f130, %f509, %f505, %f522
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f130) : "f"(f509), "f"(f505), "f"(f522));
  // PTX:1189 mul.f32 %f523, %f129, %f129
  asm("mul.f32 %0, %1, %2;" : "=f"(f523) : "f"(f129), "f"(f129));
  // PTX:1190 fma.rn.f32 %f131, %f130, %f130, %f523
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f131) : "f"(f130), "f"(f130), "f"(f523));
  // PTX:1191 setp.leu.f32 %p34, %f131, 0f2B8CBCCC
  p34 = ((isnan(((float)(f131))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) || (((float)(f131)) <= ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:1192 @%p34 bra $L__BB29_80
  if (p34) { goto L_BB29_80; }
  // PTX:1194 abs.f32 %f524, %f131
  asm("abs.f32 %0, %1;" : "=f"(f524) : "f"(f131));
  // PTX:1195 setp.geu.f32 %p35, %f524, 0f7F800000
  p35 = ((isnan(((float)(f524))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f524)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1196 @%p35 bra $L__BB29_80
  if (p35) { goto L_BB29_80; }
  // PTX:1198 abs.f32 %f132, %f130
  asm("abs.f32 %0, %1;" : "=f"(f132) : "f"(f130));
  // PTX:1199 setp.eq.f32 %p36, %f132, 0f00000000
  p36 = (!(isnan(((float)(f132))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f132)) == ((float)(as_f32(0x00000000u)))));
  // PTX:1200 abs.f32 %f133, %f129
  asm("abs.f32 %0, %1;" : "=f"(f133) : "f"(f129));
  // PTX:1201 setp.eq.f32 %p37, %f133, 0f00000000
  p37 = (!(isnan(((float)(f133))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f133)) == ((float)(as_f32(0x00000000u)))));
  // PTX:1202 and.pred %p38, %p36, %p37
  p38 = ((p36) && (p37));
  // PTX:1203 @%p38 bra $L__BB29_35
  if (p38) { goto L_BB29_35; }
  // PTX:1204 bra.uni $L__BB29_32
  goto L_BB29_32;
  // PTX:1206 $L__BB29_35:
L_BB29_35:;
  // PTX:1207 mov.b32 %r121, %f130
  asm("mov.b32 %0, %1;" : "=r"(r121) : "f"(f130));
  // PTX:1208 shr.s32 %r122, %r121, 31
  asm("shr.s32 %0, %1, 31;" : "=r"(r122) : "r"(r121));
  // PTX:1209 and.b32 %r123, %r122, 1078530011
  asm("and.b32 %0, %1, 1078530011;" : "=r"(r123) : "r"(r122));
  // PTX:1210 mov.b32 %r124, %f129
  asm("mov.b32 %0, %1;" : "=r"(r124) : "f"(f129));
  // PTX:1211 and.b32 %r125, %r124, -2147483648
  asm("and.b32 %0, %1, -2147483648;" : "=r"(r125) : "r"(r124));
  // PTX:1212 or.b32 %r126, %r125, %r123
  asm("or.b32 %0, %1, %2;" : "=r"(r126) : "r"(r125), "r"(r123));
  // PTX:1213 mov.b32 %f933, %r126
  asm("mov.b32 %0, %1;" : "=f"(f933) : "r"(r126));
  // PTX:1214 bra.uni $L__BB29_36
  goto L_BB29_36;
  // PTX:1216 $L__BB29_32:
L_BB29_32:;
  // PTX:1217 setp.eq.f32 %p39, %f132, 0f7F800000
  p39 = (!(isnan(((float)(f132))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f132)) == ((float)(as_f32(0x7F800000u)))));
  // PTX:1218 setp.eq.f32 %p40, %f133, 0f7F800000
  p40 = (!(isnan(((float)(f133))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f133)) == ((float)(as_f32(0x7F800000u)))));
  // PTX:1219 and.pred %p41, %p39, %p40
  p41 = ((p39) && (p40));
  // PTX:1220 @%p41 bra $L__BB29_34
  if (p41) { goto L_BB29_34; }
  // PTX:1221 bra.uni $L__BB29_33
  goto L_BB29_33;
  // PTX:1223 $L__BB29_34:
L_BB29_34:;
  // PTX:1224 mov.b32 %r116, %f130
  asm("mov.b32 %0, %1;" : "=r"(r116) : "f"(f130));
  // PTX:1225 setp.lt.s32 %p45, %r116, 0
  p45 = (((int)(r116)) < ((int)(0)));
  // PTX:1226 selp.b32 %r117, 1075235812, 1061752795, %p45
  r117 = p45 ? 1075235812 : 1061752795;
  // PTX:1227 mov.b32 %r118, %f129
  asm("mov.b32 %0, %1;" : "=r"(r118) : "f"(f129));
  // PTX:1228 and.b32 %r119, %r118, -2147483648
  asm("and.b32 %0, %1, -2147483648;" : "=r"(r119) : "r"(r118));
  // PTX:1229 or.b32 %r120, %r119, %r117
  asm("or.b32 %0, %1, %2;" : "=r"(r120) : "r"(r119), "r"(r117));
  // PTX:1230 mov.b32 %f933, %r120
  asm("mov.b32 %0, %1;" : "=f"(f933) : "r"(r120));
  // PTX:1231 bra.uni $L__BB29_36
  goto L_BB29_36;
  // PTX:1233 $L__BB29_33:
L_BB29_33:;
  // PTX:1234 max.f32 %f525, %f133, %f132
  asm("max.f32 %0, %1, %2;" : "=f"(f525) : "f"(f133), "f"(f132));
  // PTX:1235 min.f32 %f526, %f133, %f132
  asm("min.f32 %0, %1, %2;" : "=f"(f526) : "f"(f133), "f"(f132));
  // PTX:1236 div.rn.f32 %f527, %f526, %f525
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f527) : "f"(f526), "f"(f525));
  // PTX:1237 mul.rn.f32 %f528, %f527, %f527
  asm("mul.rn.f32 %0, %1, %2;" : "=f"(f528) : "f"(f527), "f"(f527));
  // PTX:1238 mov.f32 %f529, 0fC0B59883
  asm("mov.f32 %0, 0fC0B59883;" : "=f"(f529) : );
  // PTX:1239 mov.f32 %f530, 0fBF52C7EA
  asm("mov.f32 %0, 0fBF52C7EA;" : "=f"(f530) : );
  // PTX:1240 fma.rn.f32 %f531, %f528, %f530, %f529
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f531) : "f"(f528), "f"(f530), "f"(f529));
  // PTX:1241 mov.f32 %f532, 0fC0D21907
  asm("mov.f32 %0, 0fC0D21907;" : "=f"(f532) : );
  // PTX:1242 fma.rn.f32 %f533, %f531, %f528, %f532
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f533) : "f"(f531), "f"(f528), "f"(f532));
  // PTX:1243 mul.f32 %f534, %f528, %f533
  asm("mul.f32 %0, %1, %2;" : "=f"(f534) : "f"(f528), "f"(f533));
  // PTX:1244 mul.f32 %f535, %f527, %f534
  asm("mul.f32 %0, %1, %2;" : "=f"(f535) : "f"(f527), "f"(f534));
  // PTX:1245 add.f32 %f536, %f528, 0f41355DC0
  asm("add.f32 %0, %1, 0f41355DC0;" : "=f"(f536) : "f"(f528));
  // PTX:1246 mov.f32 %f537, 0f41E6BD60
  asm("mov.f32 %0, 0f41E6BD60;" : "=f"(f537) : );
  // PTX:1247 fma.rn.f32 %f538, %f536, %f528, %f537
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f538) : "f"(f536), "f"(f528), "f"(f537));
  // PTX:1248 mov.f32 %f539, 0f419D92C8
  asm("mov.f32 %0, 0f419D92C8;" : "=f"(f539) : );
  // PTX:1249 fma.rn.f32 %f540, %f538, %f528, %f539
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f540) : "f"(f538), "f"(f528), "f"(f539));
  // PTX:1250 rcp.rn.f32 %f541, %f540
  asm("rcp.rn.f32 %0, %1;" : "=f"(f541) : "f"(f540));
  // PTX:1251 fma.rn.f32 %f542, %f535, %f541, %f527
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f542) : "f"(f535), "f"(f541), "f"(f527));
  // PTX:1252 mov.f32 %f543, 0f3FC90FDB
  asm("mov.f32 %0, 0f3FC90FDB;" : "=f"(f543) : );
  // PTX:1253 sub.f32 %f544, %f543, %f542
  asm("sub.f32 %0, %1, %2;" : "=f"(f544) : "f"(f543), "f"(f542));
  // PTX:1254 setp.gt.f32 %p42, %f133, %f132
  p42 = (!(isnan(((float)(f133))) || isnan(((float)(f132)))) && (((float)(f133)) > ((float)(f132))));
  // PTX:1255 selp.f32 %f545, %f544, %f542, %p42
  f545 = p42 ? f544 : f542;
  // PTX:1256 mov.b32 %r111, %f130
  asm("mov.b32 %0, %1;" : "=r"(r111) : "f"(f130));
  // PTX:1257 setp.lt.s32 %p43, %r111, 0
  p43 = (((int)(r111)) < ((int)(0)));
  // PTX:1258 mov.f32 %f546, 0f40490FDB
  asm("mov.f32 %0, 0f40490FDB;" : "=f"(f546) : );
  // PTX:1259 sub.f32 %f547, %f546, %f545
  asm("sub.f32 %0, %1, %2;" : "=f"(f547) : "f"(f546), "f"(f545));
  // PTX:1260 selp.f32 %f548, %f547, %f545, %p43
  f548 = p43 ? f547 : f545;
  // PTX:1261 mov.b32 %r112, %f548
  asm("mov.b32 %0, %1;" : "=r"(r112) : "f"(f548));
  // PTX:1262 mov.b32 %r113, %f129
  asm("mov.b32 %0, %1;" : "=r"(r113) : "f"(f129));
  // PTX:1263 and.b32 %r114, %r113, -2147483648
  asm("and.b32 %0, %1, -2147483648;" : "=r"(r114) : "r"(r113));
  // PTX:1264 or.b32 %r115, %r114, %r112
  asm("or.b32 %0, %1, %2;" : "=r"(r115) : "r"(r114), "r"(r112));
  // PTX:1265 mov.b32 %f549, %r115
  asm("mov.b32 %0, %1;" : "=f"(f549) : "r"(r115));
  // PTX:1266 add.f32 %f550, %f132, %f133
  asm("add.f32 %0, %1, %2;" : "=f"(f550) : "f"(f132), "f"(f133));
  // PTX:1267 setp.le.f32 %p44, %f550, 0f7F800000
  p44 = (!(isnan(((float)(f550))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f550)) <= ((float)(as_f32(0x7F800000u)))));
  // PTX:1268 selp.f32 %f933, %f549, %f550, %p44
  f933 = p44 ? f549 : f550;
  // PTX:1270 $L__BB29_36:
L_BB29_36:;
  // PTX:1271 ld.param.u64 %rd248, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_3]
  rd248 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:1272 ld.param.u64 %rd247, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_4]
  rd247 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:1273 cvta.to.global.u64 %rd147, %rd247
  rd147 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd247));
  // PTX:1274 add.s64 %rd32, %rd147, %rd125
  asm("add.s64 %0, %1, %2;" : "=l"(rd32) : "l"(rd147), "l"(rd125));
  // PTX:1275 ld.global.u32 %r127, [%rd32]
  r127 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (0)))));
  // PTX:1276 setp.eq.s32 %p46, %r127, 0
  p46 = (((int)(r127)) == ((int)(0)));
  // PTX:1277 cvta.to.global.u64 %rd149, %rd248
  rd149 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd248));
  // PTX:1278 add.s64 %rd33, %rd149, %rd125
  asm("add.s64 %0, %1, %2;" : "=l"(rd33) : "l"(rd149), "l"(rd125));
  // PTX:1279 @%p46 bra $L__BB29_38
  if (p46) { goto L_BB29_38; }
  // PTX:1281 ld.global.f32 %f933, [%rd33]
  f933 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (0)))));
  // PTX:1282 bra.uni $L__BB29_39
  goto L_BB29_39;
  // PTX:1284 $L__BB29_38:
L_BB29_38:;
  // PTX:1285 st.global.f32 [%rd33], %f933
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (0))))) = (float)(f933);
  // PTX:1286 mov.u32 %r128, 1
  asm("mov.u32 %0, 1;" : "=r"(r128) : );
  // PTX:1287 st.global.u32 [%rd32], %r128
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (0))))) = (unsigned)(r128);
  // PTX:1289 $L__BB29_39:
L_BB29_39:;
  // PTX:1290 ld.param.u64 %rd252, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_21]
  rd252 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param21 + (0))));
  // PTX:1291 sub.f32 %f551, %f933, %f926
  asm("sub.f32 %0, %1, %2;" : "=f"(f551) : "f"(f933), "f"(f926));
  // PTX:1292 div.rn.f32 %f552, %f551, 0f40C90FDB
  asm("div.rn.f32 %0, %1, 0f40C90FDB;" : "=f"(f552) : "f"(f551));
  // PTX:1293 mov.b32 %r130, %f552
  asm("mov.b32 %0, %1;" : "=r"(r130) : "f"(f552));
  // PTX:1294 and.b32 %r131, %r130, -2147483648
  asm("and.b32 %0, %1, -2147483648;" : "=r"(r131) : "r"(r130));
  // PTX:1295 or.b32 %r132, %r131, 1056964608
  asm("or.b32 %0, %1, 1056964608;" : "=r"(r132) : "r"(r131));
  // PTX:1296 mov.b32 %f553, %r132
  asm("mov.b32 %0, %1;" : "=f"(f553) : "r"(r132));
  // PTX:1297 add.rz.f32 %f554, %f552, %f553
  asm("add.rz.f32 %0, %1, %2;" : "=f"(f554) : "f"(f552), "f"(f553));
  // PTX:1298 cvt.rzi.f32.f32 %f555, %f554
  asm("cvt.rzi.f32.f32 %0, %1;" : "=f"(f555) : "f"(f554));
  // PTX:1299 fma.rn.f32 %f140, %f555, 0f40C90FDB, %f926
  asm("fma.rn.f32 %0, %1, 0f40C90FDB, %2;" : "=f"(f140) : "f"(f555), "f"(f926));
  // PTX:1300 setp.eq.s64 %p47, %rd252, 0
  p47 = (((long long)(rd252)) == ((long long)(0)));
  // PTX:1301 mov.u32 %r169, 3
  asm("mov.u32 %0, 3;" : "=r"(r169) : );
  // PTX:1302 @%p47 bra $L__BB29_41
  if (p47) { goto L_BB29_41; }
  // PTX:1304 ld.global.u32 %r169, [%rd28]
  r169 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (0)))));
  // PTX:1306 $L__BB29_41:
L_BB29_41:;
  // PTX:1307 or.b32 %r133, %r169, 2
  asm("or.b32 %0, %1, 2;" : "=r"(r133) : "r"(r169));
  // PTX:1308 setp.ne.s32 %p48, %r133, 3
  p48 = (((int)(r133)) != ((int)(3)));
  // PTX:1309 mov.f32 %f936, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f936) : );
  // PTX:1310 @%p48 bra $L__BB29_43
  if (p48) { goto L_BB29_43; }
  // PTX:1312 ld.param.u64 %rd303, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_18]
  rd303 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param18 + (0))));
  // PTX:1313 mul.wide.s32 %rd302, %r87, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd302) : "r"(r87));
  // PTX:1314 cvta.to.global.u64 %rd301, %rd303
  rd301 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd303));
  // PTX:1315 add.s64 %rd300, %rd301, %rd302
  asm("add.s64 %0, %1, %2;" : "=l"(rd300) : "l"(rd301), "l"(rd302));
  // PTX:1316 ld.global.f32 %f557, [%rd300]
  f557 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd300) + (0)))));
  // PTX:1317 sub.f32 %f558, %f45, %f933
  asm("sub.f32 %0, %1, %2;" : "=f"(f558) : "f"(f45), "f"(f933));
  // PTX:1318 fma.rn.f32 %f936, %f558, %f557, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f936) : "f"(f558), "f"(f557));
  // PTX:1320 $L__BB29_43:
L_BB29_43:;
  // PTX:1321 setp.eq.s32 %p49, %r169, 1
  p49 = (((int)(r169)) == ((int)(1)));
  // PTX:1322 sub.f32 %f143, %f140, %f933
  asm("sub.f32 %0, %1, %2;" : "=f"(f143) : "f"(f140), "f"(f933));
  // PTX:1323 @%p49 bra $L__BB29_46
  if (p49) { goto L_BB29_46; }
  // PTX:1324 bra.uni $L__BB29_44
  goto L_BB29_44;
  // PTX:1326 $L__BB29_46:
L_BB29_46:;
  // PTX:1327 ld.global.f32 %f561, [%rd30]
  f561 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0)))));
  // PTX:1328 mul.f32 %f562, %f48, %f561
  asm("mul.f32 %0, %1, %2;" : "=f"(f562) : "f"(f48), "f"(f561));
  // PTX:1329 sub.f32 %f936, %f936, %f562
  asm("sub.f32 %0, %1, %2;" : "=f"(f936) : "f"(f936), "f"(f562));
  // PTX:1330 bra.uni $L__BB29_47
  goto L_BB29_47;
  // PTX:1332 $L__BB29_44:
L_BB29_44:;
  // PTX:1333 or.b32 %r134, %r169, 1
  asm("or.b32 %0, %1, 1;" : "=r"(r134) : "r"(r169));
  // PTX:1334 setp.eq.s32 %p50, %r134, 3
  p50 = (((int)(r134)) == ((int)(3)));
  // PTX:1335 @%p50 bra $L__BB29_45
  if (p50) { goto L_BB29_45; }
  // PTX:1336 bra.uni $L__BB29_47
  goto L_BB29_47;
  // PTX:1338 $L__BB29_45:
L_BB29_45:;
  // PTX:1339 ld.global.f32 %f559, [%rd30]
  f559 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0)))));
  // PTX:1340 sub.f32 %f560, %f46, %f48
  asm("sub.f32 %0, %1, %2;" : "=f"(f560) : "f"(f46), "f"(f48));
  // PTX:1341 fma.rn.f32 %f936, %f560, %f559, %f936
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f936) : "f"(f560), "f"(f559), "f"(f936));
  // PTX:1343 $L__BB29_47:
L_BB29_47:;
  // PTX:1344 ld.param.u64 %rd255, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_22]
  rd255 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param22 + (0))));
  // PTX:1345 ld.param.u64 %rd254, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_20]
  rd254 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param20 + (0))));
  // PTX:1346 cvta.to.global.u64 %rd253, %rd254
  rd253 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd254));
  // PTX:1347 sub.f32 %f147, %f93, %f84
  asm("sub.f32 %0, %1, %2;" : "=f"(f147) : "f"(f93), "f"(f84));
  // PTX:1348 sub.f32 %f148, %f94, %f85
  asm("sub.f32 %0, %1, %2;" : "=f"(f148) : "f"(f94), "f"(f85));
  // PTX:1349 sub.f32 %f149, %f95, %f86
  asm("sub.f32 %0, %1, %2;" : "=f"(f149) : "f"(f95), "f"(f86));
  // PTX:1350 cvt.u32.u64 %r135, %rd23
  asm("cvt.u32.u64 %0, %1;" : "=r"(r135) : "l"(rd23));
  // PTX:1351 mul.wide.s32 %rd150, %r135, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd150) : "r"(r135));
  // PTX:1352 add.s64 %rd151, %rd253, %rd150
  asm("add.s64 %0, %1, %2;" : "=l"(rd151) : "l"(rd253), "l"(rd150));
  // PTX:1353 ld.global.f32 %f564, [%rd151]
  f564 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd151) + (0)))));
  // PTX:1354 neg.f32 %f565, %f564
  asm("neg.f32 %0, %1;" : "=f"(f565) : "f"(f564));
  // PTX:1355 max.f32 %f566, %f565, %f936
  asm("max.f32 %0, %1, %2;" : "=f"(f566) : "f"(f565), "f"(f936));
  // PTX:1356 min.f32 %f150, %f564, %f566
  asm("min.f32 %0, %1, %2;" : "=f"(f150) : "f"(f564), "f"(f566));
  // PTX:1357 setp.eq.s64 %p51, %rd255, 0
  p51 = (((long long)(rd255)) == ((long long)(0)));
  // PTX:1358 mov.f32 %f937, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f937) : );
  // PTX:1359 @%p51 bra $L__BB29_49
  if (p51) { goto L_BB29_49; }
  // PTX:1361 ld.param.u64 %rd285, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_22]
  rd285 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param22 + (0))));
  // PTX:1362 cvta.to.global.u64 %rd284, %rd285
  rd284 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd285));
  // PTX:1363 shl.b64 %rd152, %rd23, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd152) : "l"(rd23));
  // PTX:1364 add.s64 %rd153, %rd284, %rd152
  asm("add.s64 %0, %1, %2;" : "=l"(rd153) : "l"(rd284), "l"(rd152));
  // PTX:1365 ld.global.f32 %f937, [%rd153]
  f937 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd153) + (0)))));
  // PTX:1367 $L__BB29_49:
L_BB29_49:;
  // PTX:1368 mul.f32 %f567, %f48, %f937
  asm("mul.f32 %0, %1, %2;" : "=f"(f567) : "f"(f48), "f"(f937));
  // PTX:1369 add.f32 %f568, %f47, %f150
  asm("add.f32 %0, %1, %2;" : "=f"(f568) : "f"(f47), "f"(f150));
  // PTX:1370 sub.f32 %f153, %f568, %f567
  asm("sub.f32 %0, %1, %2;" : "=f"(f153) : "f"(f568), "f"(f567));
  // PTX:1371 @%p47 bra $L__BB29_51
  if (p47) { goto L_BB29_51; }
  // PTX:1373 ld.global.u32 %r136, [%rd28]
  r136 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (0)))));
  // PTX:1374 add.s32 %r137, %r136, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r137) : "r"(r136));
  // PTX:1375 setp.gt.u32 %p53, %r137, 2
  p53 = (((unsigned)(r137)) > ((unsigned)(2)));
  // PTX:1376 mov.f32 %f938, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f938) : );
  // PTX:1377 @%p53 bra $L__BB29_52
  if (p53) { goto L_BB29_52; }
  // PTX:1379 $L__BB29_51:
L_BB29_51:;
  // PTX:1380 ld.global.f32 %f938, [%rd30]
  f938 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0)))));
  // PTX:1382 $L__BB29_52:
L_BB29_52:;
  // PTX:1383 mov.f32 %f939, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f939) : );
  // PTX:1384 @%p51 bra $L__BB29_54
  if (p51) { goto L_BB29_54; }
  // PTX:1386 ld.param.u64 %rd287, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_22]
  rd287 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param22 + (0))));
  // PTX:1387 cvta.to.global.u64 %rd286, %rd287
  rd286 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd287));
  // PTX:1388 shl.b64 %rd154, %rd23, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd154) : "l"(rd23));
  // PTX:1389 add.s64 %rd155, %rd286, %rd154
  asm("add.s64 %0, %1, %2;" : "=l"(rd155) : "l"(rd286), "l"(rd154));
  // PTX:1390 ld.global.f32 %f939, [%rd155]
  f939 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd155) + (0)))));
  // PTX:1392 $L__BB29_54:
L_BB29_54:;
  // PTX:1393 ld.param.f32 %f918, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_32]
  f918 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param32 + (0))));
  // PTX:1394 mul.f32 %f571, %f143, %f918
  asm("mul.f32 %0, %1, %2;" : "=f"(f571) : "f"(f143), "f"(f918));
  // PTX:1395 sub.f32 %f572, %f571, %f48
  asm("sub.f32 %0, %1, %2;" : "=f"(f572) : "f"(f571), "f"(f48));
  // PTX:1396 add.f32 %f573, %f938, %f939
  asm("add.f32 %0, %1, %2;" : "=f"(f573) : "f"(f938), "f"(f939));
  // PTX:1397 mul.f32 %f574, %f572, %f573
  asm("mul.f32 %0, %1, %2;" : "=f"(f574) : "f"(f572), "f"(f573));
  // PTX:1398 sub.f32 %f158, %f153, %f574
  asm("sub.f32 %0, %1, %2;" : "=f"(f158) : "f"(f153), "f"(f574));
  // PTX:1399 abs.f32 %f575, %f158
  asm("abs.f32 %0, %1;" : "=f"(f575) : "f"(f158));
  // PTX:1400 setp.geu.f32 %p55, %f575, 0f7F800000
  p55 = ((isnan(((float)(f575))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f575)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1401 setp.le.f32 %p56, %f575, 0f2B8CBCCC
  p56 = (!(isnan(((float)(f575))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) && (((float)(f575)) <= ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:1402 or.pred %p57, %p55, %p56
  p57 = ((p55) || (p56));
  // PTX:1403 @%p57 bra $L__BB29_80
  if (p57) { goto L_BB29_80; }
  // PTX:1405 ld.param.u64 %rd293, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_15]
  rd293 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param15 + (0))));
  // PTX:1406 shl.b64 %rd292, %rd335, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd292) : "l"(rd335));
  // PTX:1407 cvta.to.global.u64 %rd291, %rd293
  rd291 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd293));
  // PTX:1408 add.s64 %rd290, %rd291, %rd292
  asm("add.s64 %0, %1, %2;" : "=l"(rd290) : "l"(rd291), "l"(rd292));
  // PTX:1409 ld.param.u64 %rd289, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_26]
  rd289 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param26 + (0))));
  // PTX:1410 cvta.to.global.u64 %rd288, %rd289
  rd288 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd289));
  // PTX:1411 mul.lo.s64 %rd279, %rd22, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd279) : "l"(rd22));
  // PTX:1412 mul.lo.s64 %rd278, %rd21, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd278) : "l"(rd21));
  // PTX:1413 mul.lo.s64 %rd277, %rd20, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd277) : "l"(rd20));
  // PTX:1414 mul.lo.s64 %rd276, %rd19, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd276) : "l"(rd19));
  // PTX:1415 ld.param.u64 %rd259, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_12]
  rd259 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:1416 shl.b64 %rd258, %rd335, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd258) : "l"(rd335));
  // PTX:1417 cvta.to.global.u64 %rd257, %rd259
  rd257 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd259));
  // PTX:1418 add.s64 %rd256, %rd257, %rd258
  asm("add.s64 %0, %1, %2;" : "=l"(rd256) : "l"(rd257), "l"(rd258));
  // PTX:1419 ld.global.f32 %f576, [%rd256]
  f576 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd256) + (0)))));
  // PTX:1420 ld.global.f32 %f577, [%rd290]
  f577 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd290) + (0)))));
  // PTX:1421 mul.f32 %f578, %f102, %f577
  asm("mul.f32 %0, %1, %2;" : "=f"(f578) : "f"(f102), "f"(f577));
  // PTX:1422 mul.f32 %f579, %f103, %f577
  asm("mul.f32 %0, %1, %2;" : "=f"(f579) : "f"(f103), "f"(f577));
  // PTX:1423 mul.f32 %f580, %f104, %f577
  asm("mul.f32 %0, %1, %2;" : "=f"(f580) : "f"(f104), "f"(f577));
  // PTX:1424 fma.rn.f32 %f581, %f99, %f576, %f578
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f581) : "f"(f99), "f"(f576), "f"(f578));
  // PTX:1425 fma.rn.f32 %f582, %f100, %f576, %f579
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f582) : "f"(f100), "f"(f576), "f"(f579));
  // PTX:1426 fma.rn.f32 %f583, %f101, %f576, %f580
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f583) : "f"(f101), "f"(f576), "f"(f580));
  // PTX:1427 ld.global.f32 %f584, [%rd256+4]
  f584 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd256) + (4)))));
  // PTX:1428 ld.global.f32 %f585, [%rd290+4]
  f585 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd290) + (4)))));
  // PTX:1429 mul.f32 %f586, %f102, %f585
  asm("mul.f32 %0, %1, %2;" : "=f"(f586) : "f"(f102), "f"(f585));
  // PTX:1430 mul.f32 %f587, %f103, %f585
  asm("mul.f32 %0, %1, %2;" : "=f"(f587) : "f"(f103), "f"(f585));
  // PTX:1431 mul.f32 %f588, %f104, %f585
  asm("mul.f32 %0, %1, %2;" : "=f"(f588) : "f"(f104), "f"(f585));
  // PTX:1432 fma.rn.f32 %f589, %f99, %f584, %f586
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f589) : "f"(f99), "f"(f584), "f"(f586));
  // PTX:1433 fma.rn.f32 %f590, %f100, %f584, %f587
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f590) : "f"(f100), "f"(f584), "f"(f587));
  // PTX:1434 fma.rn.f32 %f591, %f101, %f584, %f588
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f591) : "f"(f101), "f"(f584), "f"(f588));
  // PTX:1435 ld.global.f32 %f592, [%rd256+8]
  f592 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd256) + (8)))));
  // PTX:1436 ld.global.f32 %f593, [%rd290+8]
  f593 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd290) + (8)))));
  // PTX:1437 mul.f32 %f594, %f102, %f593
  asm("mul.f32 %0, %1, %2;" : "=f"(f594) : "f"(f102), "f"(f593));
  // PTX:1438 mul.f32 %f595, %f103, %f593
  asm("mul.f32 %0, %1, %2;" : "=f"(f595) : "f"(f103), "f"(f593));
  // PTX:1439 mul.f32 %f596, %f104, %f593
  asm("mul.f32 %0, %1, %2;" : "=f"(f596) : "f"(f104), "f"(f593));
  // PTX:1440 fma.rn.f32 %f597, %f99, %f592, %f594
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f597) : "f"(f99), "f"(f592), "f"(f594));
  // PTX:1441 fma.rn.f32 %f598, %f100, %f592, %f595
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f598) : "f"(f100), "f"(f592), "f"(f595));
  // PTX:1442 fma.rn.f32 %f599, %f101, %f592, %f596
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f599) : "f"(f101), "f"(f592), "f"(f596));
  // PTX:1443 ld.global.f32 %f600, [%rd256+12]
  f600 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd256) + (12)))));
  // PTX:1444 ld.global.f32 %f601, [%rd290+12]
  f601 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd290) + (12)))));
  // PTX:1445 mul.f32 %f602, %f102, %f601
  asm("mul.f32 %0, %1, %2;" : "=f"(f602) : "f"(f102), "f"(f601));
  // PTX:1446 mul.f32 %f603, %f103, %f601
  asm("mul.f32 %0, %1, %2;" : "=f"(f603) : "f"(f103), "f"(f601));
  // PTX:1447 mul.f32 %f604, %f104, %f601
  asm("mul.f32 %0, %1, %2;" : "=f"(f604) : "f"(f104), "f"(f601));
  // PTX:1448 fma.rn.f32 %f605, %f99, %f600, %f602
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f605) : "f"(f99), "f"(f600), "f"(f602));
  // PTX:1449 fma.rn.f32 %f606, %f100, %f600, %f603
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f606) : "f"(f100), "f"(f600), "f"(f603));
  // PTX:1450 fma.rn.f32 %f607, %f101, %f600, %f604
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f607) : "f"(f101), "f"(f600), "f"(f604));
  // PTX:1451 mul.f32 %f608, %f158, %f581
  asm("mul.f32 %0, %1, %2;" : "=f"(f608) : "f"(f158), "f"(f581));
  // PTX:1452 mul.f32 %f609, %f158, %f582
  asm("mul.f32 %0, %1, %2;" : "=f"(f609) : "f"(f158), "f"(f582));
  // PTX:1453 mul.f32 %f610, %f158, %f583
  asm("mul.f32 %0, %1, %2;" : "=f"(f610) : "f"(f158), "f"(f583));
  // PTX:1454 add.s64 %rd157, %rd288, %rd276
  asm("add.s64 %0, %1, %2;" : "=l"(rd157) : "l"(rd288), "l"(rd276));
  // PTX:1455 red.global.add.f32 [%rd157], %f608
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd157) + (0)))), (float)(f608));
  // PTX:1456 add.s64 %rd158, %rd157, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd158) : "l"(rd157));
  // PTX:1457 red.global.add.f32 [%rd158], %f609
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd158) + (0)))), (float)(f609));
  // PTX:1458 add.s64 %rd159, %rd157, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd159) : "l"(rd157));
  // PTX:1459 red.global.add.f32 [%rd159], %f610
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd159) + (0)))), (float)(f610));
  // PTX:1460 mul.f32 %f614, %f158, %f589
  asm("mul.f32 %0, %1, %2;" : "=f"(f614) : "f"(f158), "f"(f589));
  // PTX:1461 mul.f32 %f615, %f158, %f590
  asm("mul.f32 %0, %1, %2;" : "=f"(f615) : "f"(f158), "f"(f590));
  // PTX:1462 mul.f32 %f616, %f158, %f591
  asm("mul.f32 %0, %1, %2;" : "=f"(f616) : "f"(f158), "f"(f591));
  // PTX:1463 add.s64 %rd161, %rd288, %rd277
  asm("add.s64 %0, %1, %2;" : "=l"(rd161) : "l"(rd288), "l"(rd277));
  // PTX:1464 red.global.add.f32 [%rd161], %f614
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd161) + (0)))), (float)(f614));
  // PTX:1465 add.s64 %rd162, %rd161, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd162) : "l"(rd161));
  // PTX:1466 red.global.add.f32 [%rd162], %f615
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd162) + (0)))), (float)(f615));
  // PTX:1467 add.s64 %rd163, %rd161, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd163) : "l"(rd161));
  // PTX:1468 red.global.add.f32 [%rd163], %f616
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd163) + (0)))), (float)(f616));
  // PTX:1469 mul.f32 %f620, %f158, %f597
  asm("mul.f32 %0, %1, %2;" : "=f"(f620) : "f"(f158), "f"(f597));
  // PTX:1470 mul.f32 %f621, %f158, %f598
  asm("mul.f32 %0, %1, %2;" : "=f"(f621) : "f"(f158), "f"(f598));
  // PTX:1471 mul.f32 %f622, %f158, %f599
  asm("mul.f32 %0, %1, %2;" : "=f"(f622) : "f"(f158), "f"(f599));
  // PTX:1472 add.s64 %rd165, %rd288, %rd278
  asm("add.s64 %0, %1, %2;" : "=l"(rd165) : "l"(rd288), "l"(rd278));
  // PTX:1473 red.global.add.f32 [%rd165], %f620
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd165) + (0)))), (float)(f620));
  // PTX:1474 add.s64 %rd166, %rd165, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd166) : "l"(rd165));
  // PTX:1475 red.global.add.f32 [%rd166], %f621
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd166) + (0)))), (float)(f621));
  // PTX:1476 add.s64 %rd167, %rd165, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd167) : "l"(rd165));
  // PTX:1477 red.global.add.f32 [%rd167], %f622
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd167) + (0)))), (float)(f622));
  // PTX:1478 mul.f32 %f626, %f158, %f605
  asm("mul.f32 %0, %1, %2;" : "=f"(f626) : "f"(f158), "f"(f605));
  // PTX:1479 mul.f32 %f627, %f158, %f606
  asm("mul.f32 %0, %1, %2;" : "=f"(f627) : "f"(f158), "f"(f606));
  // PTX:1480 mul.f32 %f628, %f158, %f607
  asm("mul.f32 %0, %1, %2;" : "=f"(f628) : "f"(f158), "f"(f607));
  // PTX:1481 add.s64 %rd169, %rd288, %rd279
  asm("add.s64 %0, %1, %2;" : "=l"(rd169) : "l"(rd288), "l"(rd279));
  // PTX:1482 red.global.add.f32 [%rd169], %f626
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd169) + (0)))), (float)(f626));
  // PTX:1483 add.s64 %rd170, %rd169, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd170) : "l"(rd169));
  // PTX:1484 red.global.add.f32 [%rd170], %f627
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd170) + (0)))), (float)(f627));
  // PTX:1485 add.s64 %rd171, %rd169, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd171) : "l"(rd169));
  // PTX:1486 red.global.add.f32 [%rd171], %f628
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd171) + (0)))), (float)(f628));
  // PTX:1487 @%p26 bra $L__BB29_80
  if (p26) { goto L_BB29_80; }
  // PTX:1489 ld.param.u64 %rd299, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_11]
  rd299 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:1490 shl.b64 %rd298, %rd335, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd298) : "l"(rd335));
  // PTX:1491 cvta.to.global.u64 %rd297, %rd299
  rd297 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd299));
  // PTX:1492 add.s64 %rd296, %rd297, %rd298
  asm("add.s64 %0, %1, %2;" : "=l"(rd296) : "l"(rd297), "l"(rd298));
  // PTX:1493 ld.param.u64 %rd295, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_26]
  rd295 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param26 + (0))));
  // PTX:1494 cvta.to.global.u64 %rd294, %rd295
  rd294 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd295));
  // PTX:1495 ld.param.u64 %rd263, [_ZN7synreal6kernel25evaluate_joint_drive_loadEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPfPiPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESL_SL_SL_SL_SF_SF_S8_S8_S8_SF_S8_S8_S8_S8_PS4_mmmmmf_param_14]
  rd263 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:1496 shl.b64 %rd262, %rd335, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd262) : "l"(rd335));
  // PTX:1497 cvta.to.global.u64 %rd261, %rd263
  rd261 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd263));
  // PTX:1498 add.s64 %rd260, %rd261, %rd262
  asm("add.s64 %0, %1, %2;" : "=l"(rd260) : "l"(rd261), "l"(rd262));
  // PTX:1499 ld.global.f32 %f632, [%rd296]
  f632 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd296) + (0)))));
  // PTX:1500 ld.global.f32 %f633, [%rd16]
  f633 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:1501 mul.f32 %f634, %f84, %f633
  asm("mul.f32 %0, %1, %2;" : "=f"(f634) : "f"(f84), "f"(f633));
  // PTX:1502 mul.f32 %f635, %f85, %f633
  asm("mul.f32 %0, %1, %2;" : "=f"(f635) : "f"(f85), "f"(f633));
  // PTX:1503 mul.f32 %f636, %f86, %f633
  asm("mul.f32 %0, %1, %2;" : "=f"(f636) : "f"(f86), "f"(f633));
  // PTX:1504 fma.rn.f32 %f637, %f147, %f632, %f634
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f637) : "f"(f147), "f"(f632), "f"(f634));
  // PTX:1505 fma.rn.f32 %f638, %f148, %f632, %f635
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f638) : "f"(f148), "f"(f632), "f"(f635));
  // PTX:1506 fma.rn.f32 %f639, %f149, %f632, %f636
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f639) : "f"(f149), "f"(f632), "f"(f636));
  // PTX:1507 ld.global.f32 %f640, [%rd260]
  f640 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd260) + (0)))));
  // PTX:1508 fma.rn.f32 %f641, %f96, %f640, %f637
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f641) : "f"(f96), "f"(f640), "f"(f637));
  // PTX:1509 fma.rn.f32 %f642, %f97, %f640, %f638
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f642) : "f"(f97), "f"(f640), "f"(f638));
  // PTX:1510 fma.rn.f32 %f643, %f98, %f640, %f639
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f643) : "f"(f98), "f"(f640), "f"(f639));
  // PTX:1511 ld.global.f32 %f644, [%rd296+4]
  f644 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd296) + (4)))));
  // PTX:1512 ld.global.f32 %f645, [%rd16+4]
  f645 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (4)))));
  // PTX:1513 mul.f32 %f646, %f84, %f645
  asm("mul.f32 %0, %1, %2;" : "=f"(f646) : "f"(f84), "f"(f645));
  // PTX:1514 mul.f32 %f647, %f85, %f645
  asm("mul.f32 %0, %1, %2;" : "=f"(f647) : "f"(f85), "f"(f645));
  // PTX:1515 mul.f32 %f648, %f86, %f645
  asm("mul.f32 %0, %1, %2;" : "=f"(f648) : "f"(f86), "f"(f645));
  // PTX:1516 fma.rn.f32 %f649, %f147, %f644, %f646
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f649) : "f"(f147), "f"(f644), "f"(f646));
  // PTX:1517 fma.rn.f32 %f650, %f148, %f644, %f647
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f650) : "f"(f148), "f"(f644), "f"(f647));
  // PTX:1518 fma.rn.f32 %f651, %f149, %f644, %f648
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f651) : "f"(f149), "f"(f644), "f"(f648));
  // PTX:1519 ld.global.f32 %f652, [%rd260+4]
  f652 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd260) + (4)))));
  // PTX:1520 fma.rn.f32 %f653, %f96, %f652, %f649
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f653) : "f"(f96), "f"(f652), "f"(f649));
  // PTX:1521 fma.rn.f32 %f654, %f97, %f652, %f650
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f654) : "f"(f97), "f"(f652), "f"(f650));
  // PTX:1522 fma.rn.f32 %f655, %f98, %f652, %f651
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f655) : "f"(f98), "f"(f652), "f"(f651));
  // PTX:1523 ld.global.f32 %f656, [%rd296+8]
  f656 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd296) + (8)))));
  // PTX:1524 ld.global.f32 %f657, [%rd16+8]
  f657 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (8)))));
  // PTX:1525 mul.f32 %f658, %f84, %f657
  asm("mul.f32 %0, %1, %2;" : "=f"(f658) : "f"(f84), "f"(f657));
  // PTX:1526 mul.f32 %f659, %f85, %f657
  asm("mul.f32 %0, %1, %2;" : "=f"(f659) : "f"(f85), "f"(f657));
  // PTX:1527 mul.f32 %f660, %f86, %f657
  asm("mul.f32 %0, %1, %2;" : "=f"(f660) : "f"(f86), "f"(f657));
  // PTX:1528 fma.rn.f32 %f661, %f147, %f656, %f658
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f661) : "f"(f147), "f"(f656), "f"(f658));
  // PTX:1529 fma.rn.f32 %f662, %f148, %f656, %f659
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f662) : "f"(f148), "f"(f656), "f"(f659));
  // PTX:1530 fma.rn.f32 %f663, %f149, %f656, %f660
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f663) : "f"(f149), "f"(f656), "f"(f660));
  // PTX:1531 ld.global.f32 %f664, [%rd260+8]
  f664 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd260) + (8)))));
  // PTX:1532 fma.rn.f32 %f665, %f96, %f664, %f661
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f665) : "f"(f96), "f"(f664), "f"(f661));
  // PTX:1533 fma.rn.f32 %f666, %f97, %f664, %f662
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f666) : "f"(f97), "f"(f664), "f"(f662));
  // PTX:1534 fma.rn.f32 %f667, %f98, %f664, %f663
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f667) : "f"(f98), "f"(f664), "f"(f663));
  // PTX:1535 ld.global.f32 %f668, [%rd296+12]
  f668 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd296) + (12)))));
  // PTX:1536 ld.global.f32 %f669, [%rd16+12]
  f669 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (12)))));
  // PTX:1537 mul.f32 %f670, %f84, %f669
  asm("mul.f32 %0, %1, %2;" : "=f"(f670) : "f"(f84), "f"(f669));
  // PTX:1538 mul.f32 %f671, %f85, %f669
  asm("mul.f32 %0, %1, %2;" : "=f"(f671) : "f"(f85), "f"(f669));
  // PTX:1539 mul.f32 %f672, %f86, %f669
  asm("mul.f32 %0, %1, %2;" : "=f"(f672) : "f"(f86), "f"(f669));
  // PTX:1540 fma.rn.f32 %f673, %f147, %f668, %f670
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f673) : "f"(f147), "f"(f668), "f"(f670));
  // PTX:1541 fma.rn.f32 %f674, %f148, %f668, %f671
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f674) : "f"(f148), "f"(f668), "f"(f671));
  // PTX:1542 fma.rn.f32 %f675, %f149, %f668, %f672
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f675) : "f"(f149), "f"(f668), "f"(f672));
  // PTX:1543 ld.global.f32 %f676, [%rd260+12]
  f676 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd260) + (12)))));
  // PTX:1544 fma.rn.f32 %f677, %f96, %f676, %f673
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f677) : "f"(f96), "f"(f676), "f"(f673));
  // PTX:1545 fma.rn.f32 %f678, %f97, %f676, %f674
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f678) : "f"(f97), "f"(f676), "f"(f674));
  // PTX:1546 fma.rn.f32 %f679, %f98, %f676, %f675
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f679) : "f"(f98), "f"(f676), "f"(f675));
  // PTX:1547 mul.f32 %f680, %f158, %f641
  asm("mul.f32 %0, %1, %2;" : "=f"(f680) : "f"(f158), "f"(f641));
  // PTX:1548 mul.f32 %f681, %f158, %f642
  asm("mul.f32 %0, %1, %2;" : "=f"(f681) : "f"(f158), "f"(f642));
  // PTX:1549 mul.f32 %f682, %f158, %f643
  asm("mul.f32 %0, %1, %2;" : "=f"(f682) : "f"(f158), "f"(f643));
  // PTX:1550 mul.wide.s32 %rd172, %r150, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd172) : "r"(r150));
  // PTX:1551 add.s64 %rd173, %rd294, %rd172
  asm("add.s64 %0, %1, %2;" : "=l"(rd173) : "l"(rd294), "l"(rd172));
  // PTX:1552 red.global.add.f32 [%rd173], %f680
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd173) + (0)))), (float)(f680));
  // PTX:1553 add.s64 %rd174, %rd173, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd174) : "l"(rd173));
  // PTX:1554 red.global.add.f32 [%rd174], %f681
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd174) + (0)))), (float)(f681));
  // PTX:1555 add.s64 %rd175, %rd173, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd175) : "l"(rd173));
  // PTX:1556 red.global.add.f32 [%rd175], %f682
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd175) + (0)))), (float)(f682));
  // PTX:1557 mul.f32 %f686, %f158, %f653
  asm("mul.f32 %0, %1, %2;" : "=f"(f686) : "f"(f158), "f"(f653));
  // PTX:1558 mul.f32 %f687, %f158, %f654
  asm("mul.f32 %0, %1, %2;" : "=f"(f687) : "f"(f158), "f"(f654));
  // PTX:1559 mul.f32 %f688, %f158, %f655
  asm("mul.f32 %0, %1, %2;" : "=f"(f688) : "f"(f158), "f"(f655));
  // PTX:1560 mul.wide.s32 %rd176, %r151, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd176) : "r"(r151));
  // PTX:1561 add.s64 %rd177, %rd294, %rd176
  asm("add.s64 %0, %1, %2;" : "=l"(rd177) : "l"(rd294), "l"(rd176));
  // PTX:1562 red.global.add.f32 [%rd177], %f686
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd177) + (0)))), (float)(f686));
  // PTX:1563 add.s64 %rd178, %rd177, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd178) : "l"(rd177));
  // PTX:1564 red.global.add.f32 [%rd178], %f687
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd178) + (0)))), (float)(f687));
  // PTX:1565 add.s64 %rd179, %rd177, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd179) : "l"(rd177));
  // PTX:1566 red.global.add.f32 [%rd179], %f688
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd179) + (0)))), (float)(f688));
  // PTX:1567 mul.f32 %f692, %f158, %f665
  asm("mul.f32 %0, %1, %2;" : "=f"(f692) : "f"(f158), "f"(f665));
  // PTX:1568 mul.f32 %f693, %f158, %f666
  asm("mul.f32 %0, %1, %2;" : "=f"(f693) : "f"(f158), "f"(f666));
  // PTX:1569 mul.f32 %f694, %f158, %f667
  asm("mul.f32 %0, %1, %2;" : "=f"(f694) : "f"(f158), "f"(f667));
  // PTX:1570 mul.wide.s32 %rd180, %r152, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd180) : "r"(r152));
  // PTX:1571 add.s64 %rd181, %rd294, %rd180
  asm("add.s64 %0, %1, %2;" : "=l"(rd181) : "l"(rd294), "l"(rd180));
  // PTX:1572 red.global.add.f32 [%rd181], %f692
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd181) + (0)))), (float)(f692));
  // PTX:1573 add.s64 %rd182, %rd181, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd182) : "l"(rd181));
  // PTX:1574 red.global.add.f32 [%rd182], %f693
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd182) + (0)))), (float)(f693));
  // PTX:1575 add.s64 %rd183, %rd181, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd183) : "l"(rd181));
  // PTX:1576 red.global.add.f32 [%rd183], %f694
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd183) + (0)))), (float)(f694));
  // PTX:1577 mul.f32 %f698, %f158, %f677
  asm("mul.f32 %0, %1, %2;" : "=f"(f698) : "f"(f158), "f"(f677));
  // PTX:1578 mul.f32 %f699, %f158, %f678
  asm("mul.f32 %0, %1, %2;" : "=f"(f699) : "f"(f158), "f"(f678));
  // PTX:1579 mul.f32 %f700, %f158, %f679
  asm("mul.f32 %0, %1, %2;" : "=f"(f700) : "f"(f158), "f"(f679));
  // PTX:1580 mul.wide.s32 %rd184, %r153, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd184) : "r"(r153));
  // PTX:1581 add.s64 %rd185, %rd294, %rd184
  asm("add.s64 %0, %1, %2;" : "=l"(rd185) : "l"(rd294), "l"(rd184));
  // PTX:1582 red.global.add.f32 [%rd185], %f698
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (0)))), (float)(f698));
  // PTX:1583 add.s64 %rd186, %rd185, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd186) : "l"(rd185));
  // PTX:1584 red.global.add.f32 [%rd186], %f699
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd186) + (0)))), (float)(f699));
  // PTX:1585 add.s64 %rd187, %rd185, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd187) : "l"(rd185));
  // PTX:1586 red.global.add.f32 [%rd187], %f700
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd187) + (0)))), (float)(f700));
  // PTX:1587 bra.uni $L__BB29_80
  goto L_BB29_80;
}
