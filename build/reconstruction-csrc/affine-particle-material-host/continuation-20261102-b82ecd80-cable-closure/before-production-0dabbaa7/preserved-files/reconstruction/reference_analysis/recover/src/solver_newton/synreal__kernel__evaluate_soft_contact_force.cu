// 机械还原自 PTX：synreal::kernel::evaluate_soft_contact_force(int const*, unsigned long, int const*, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, int const*, unsigned long, unsigned long, int const*, int const*, synreal::Transform const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float const*, float const*, float const*, unsigned long, unsigned long, unsigned long, float, float, float, float, int const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, unsigned long, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, float*, int const*, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)
// PTX SHA256: 609d66ca4954b7a4bd5958ad02cd99d5d60d0c663deaf1078ac8e4a80edaff8e
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__evaluate_soft_contact_force(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10, unsigned long long param11, unsigned long long param12, unsigned long long param13, unsigned long long param14, unsigned long long param15, unsigned long long param16, unsigned long long param17, unsigned long long param18, unsigned long long param19, unsigned long long param20, unsigned long long param21, unsigned long long param22, unsigned long long param23, float param24, float param25, float param26, float param27, unsigned long long param28, unsigned long long param29, unsigned long long param30, unsigned long long param31, unsigned long long param32, unsigned long long param33, unsigned long long param34, float param35, unsigned long long param36, unsigned long long param37, unsigned long long param38, unsigned long long param39, unsigned long long param40, unsigned long long param41) {
  unsigned long long SP, SPL, rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135, rd136, rd137, rd138, rd139, rd140, rd141, rd142, rd143, rd144, rd145, rd146, rd147, rd148, rd149, rd150, rd151, rd152, rd153, rd154, rd155, rd156, rd157, rd158, rd159, rd160, rd161, rd162, rd163, rd164, rd165, rd166, rd167, rd168, rd169, rd170, rd171, rd172, rd173, rd174, rd175, rd176, rd177, rd178, rd179, rd180, rd181, rd182, rd183, rd184, rd185, rd186, rd187, rd188, rd189, rd190, rd191, rd192, rd193, rd194, rd195, rd196, rd197, rd198, rd199, rd200, rd201, rd202, rd203, rd204, rd205, rd206, rd207, rd208, rd209, rd210, rd211, rd212, rd213, rd214, rd215, rd216, rd217, rd218, rd219, rd220, rd221, rd222, rd223, rd224, rd225, rd226, rd227, rd228, rd229, rd230, rd231, rd232, rd233, rd234, rd235, rd236, rd237, rd238, rd239, rd240, rd241, rd242, rd243, rd244, rd245, rd246, rd247, rd248, rd249, rd250, rd251, rd252, rd253, rd254, rd255, rd256, rd257, rd258, rd259, rd260, rd261, rd262, rd263, rd264, rd265, rd266, rd267, rd268, rd269, rd270, rd271, rd272, rd273, rd274, rd275, rd276, rd277, rd278, rd279, rd280, rd281, rd282, rd283, rd284, rd285, rd286, rd287, rd288, rd289, rd290, rd291, rd292, rd293, rd294, rd295, rd296, rd297, rd298, rd299, rd300, rd301, rd302, rd303, rd304, rd305, rd306, rd307, rd308, rd309, rd310, rd311, rd312, rd313, rd314, rd315, rd316, rd317, rd318, rd319, rd320, rd321, rd322, rd323, rd324, rd325, rd326, rd327, rd328, rd329, rd330, rd331, rd332, rd333, rd334, rd335, rd336, rd337, rd338, rd339, rd340, rd341, rd342, rd343, rd344, rd345, rd346, rd347, rd348, rd349, rd350, rd351, rd352, rd353, rd354, rd355, rd356, rd357, rd358, rd359, rd360, rd361, rd362, rd363, rd364, rd365, rd366, rd367, rd368, rd369, rd370, rd371, rd372, rd373;
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57, p58, p59, p60, p61, p62, p63, p64, p65, p66, p67, p68, p69, p70, p71, p72, p73, p74, p75, p76, p77, p78, p79, p80, p81, p82, p83, p84, p85, p86, p87, p88, p89, p90, p91, p92, p93, p94, p95, p96, p97, p98, p99, p100, p101, p102, p103, p104, p105, p106, p107, p108, p109, p110, p111, p112, p113, p114, p115, p116, p117, p118, p119;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440, f441, f442, f443, f444, f445, f446, f447, f448, f449, f450, f451, f452, f453, f454, f455, f456, f457, f458, f459, f460, f461, f462, f463, f464, f465, f466, f467, f468, f469, f470, f471, f472, f473, f474, f475, f476, f477, f478, f479, f480, f481, f482, f483, f484, f485, f486, f487, f488, f489, f490, f491, f492, f493, f494, f495, f496, f497, f498, f499, f500, f501, f502, f503, f504, f505, f506, f507, f508, f509, f510, f511, f512, f513, f514, f515, f516, f517, f518, f519, f520, f521, f522, f523, f524, f525, f526, f527, f528, f529, f530, f531, f532, f533, f534, f535, f536, f537, f538, f539, f540, f541, f542, f543, f544, f545, f546, f547, f548, f549, f550, f551, f552, f553, f554, f555, f556, f557, f558, f559, f560, f561, f562, f563, f564, f565, f566, f567, f568, f569, f570, f571, f572, f573, f574, f575, f576, f577, f578, f579, f580, f581, f582, f583, f584, f585, f586, f587, f588, f589, f590, f591, f592, f593, f594, f595, f596, f597, f598, f599, f600, f601, f602, f603, f604, f605, f606, f607, f608, f609, f610, f611, f612, f613, f614, f615, f616, f617, f618, f619, f620, f621, f622, f623, f624, f625, f626, f627, f628, f629, f630, f631, f632, f633, f634, f635, f636, f637, f638, f639, f640, f641, f642, f643, f644, f645, f646, f647, f648, f649, f650, f651, f652, f653, f654, f655, f656, f657, f658, f659, f660, f661, f662, f663, f664, f665, f666, f667, f668, f669, f670, f671, f672, f673, f674, f675, f676, f677, f678, f679, f680, f681, f682, f683, f684, f685, f686, f687, f688, f689, f690, f691, f692, f693, f694, f695, f696, f697, f698, f699, f700, f701, f702, f703, f704, f705, f706, f707, f708, f709, f710, f711, f712, f713, f714, f715, f716, f717, f718, f719, f720, f721, f722, f723, f724, f725, f726, f727, f728, f729, f730, f731, f732, f733, f734, f735, f736, f737, f738, f739, f740, f741, f742, f743, f744, f745, f746, f747, f748, f749, f750, f751, f752, f753, f754, f755, f756, f757, f758, f759, f760, f761, f762, f763, f764, f765, f766, f767, f768, f769, f770, f771, f772, f773, f774, f775, f776, f777, f778, f779, f780, f781, f782, f783, f784, f785, f786, f787, f788, f789, f790, f791, f792, f793, f794, f795, f796, f797, f798, f799, f800, f801, f802, f803, f804, f805, f806, f807, f808, f809, f810, f811, f812, f813, f814, f815, f816, f817, f818, f819, f820, f821, f822, f823, f824, f825, f826, f827, f828, f829, f830, f831, f832, f833, f834, f835, f836, f837, f838, f839, f840, f841, f842, f843, f844, f845, f846, f847, f848, f849, f850, f851, f852, f853, f854, f855, f856, f857, f858, f859, f860, f861, f862, f863, f864, f865, f866, f867, f868, f869, f870, f871, f872, f873, f874, f875, f876, f877, f878, f879, f880, f881, f882, f883, f884, f885, f886, f887, f888, f889, f890, f891, f892, f893, f894, f895, f896, f897, f898, f899, f900, f901, f902, f903, f904, f905, f906, f907, f908, f909, f910, f911, f912, f913, f914, f915, f916, f917, f918, f919, f920, f921, f922, f923, f924, f925, f926, f927, f928, f929, f930, f931, f932, f933, f934, f935, f936, f937, f938, f939, f940, f941, f942, f943, f944, f945, f946, f947, f948, f949, f950, f951, f952, f953, f954, f955, f956, f957, f958, f959, f960, f961, f962, f963, f964, f965, f966, f967, f968, f969, f970, f971, f972, f973, f974, f975, f976, f977, f978, f979, f980, f981, f982, f983;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121, r122, r123, r124, r125, r126, r127, r128, r129, r130, r131, r132, r133, r134, r135, r136, r137, r138, r139, r140, r141, r142, r143, r144, r145, r146, r147, r148, r149, r150, r151, r152, r153, r154, r155, r156, r157, r158, r159, r160, r161, r162, r163, r164, r165, r166, r167, r168, r169, r170, r171, r172, r173, r174, r175, r176, r177, r178, r179, r180, r181, r182, r183, r184, r185, r186, r187, r188, r189, r190, r191, r192, r193, r194, r195, r196, r197, r198, r199, r200, r201, r202, r203, r204, r205, r206, r207, r208, r209, r210, r211, r212, r213, r214, r215, r216, r217, r218, r219, r220, r221, r222, r223, r224, r225, r226, r227, r228, r229, r230, r231, r232, r233, r234, r235, r236, r237, r238, r239, r240, r241, r242, r243, r244, r245, r246, r247, r248, r249, r250, r251, r252, r253, r254, r255, r256, r257, r258, r259, r260, r261, r262, r263, r264, r265, r266, r267, r268, r269, r270, r271, r272, r273, r274, r275, r276, r277, r278, r279, r280, r281, r282, r283, r284, r285, r286, r287, r288, r289, r290, r291, r292, r293, r294, r295, r296, r297, r298, r299, r300, r301, r302, r303, r304, r305, r306, r307, r308, r309, r310, r311, r312, r313, r314, r315;
  __align__(4) unsigned char __local_depot3[60];
  // PTX:61 mov.u64 %SPL, __local_depot3
  SPL = (unsigned long long)__cvta_generic_to_local(__local_depot3);
  // PTX:62 ld.param.u64 %rd76, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_0]
  rd76 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:63 ld.param.u64 %rd86, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_10]
  rd86 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:64 ld.param.u64 %rd110, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_28]
  rd110 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param28 + (0))));
  // PTX:65 ld.param.u64 %rd102, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_31]
  rd102 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param31 + (0))));
  // PTX:66 ld.param.u64 %rd111, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_32]
  rd111 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param32 + (0))));
  // PTX:67 ld.param.u64 %rd112, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_33]
  rd112 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param33 + (0))));
  // PTX:68 ld.param.u64 %rd103, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_34]
  rd103 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param34 + (0))));
  // PTX:69 ld.param.f32 %f257, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_35]
  f257 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param35 + (0))));
  // PTX:70 ld.param.u64 %rd108, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_40]
  rd108 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param40 + (0))));
  // PTX:71 ld.param.u64 %rd109, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_41]
  rd109 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param41 + (0))));
  // PTX:72 cvta.to.global.u64 %rd1, %rd109
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd109));
  // PTX:73 cvta.to.global.u64 %rd4, %rd112
  rd4 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd112));
  // PTX:74 cvta.to.global.u64 %rd5, %rd103
  rd5 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd103));
  // PTX:75 cvta.to.global.u64 %rd6, %rd111
  rd6 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd111));
  // PTX:76 cvta.to.global.u64 %rd7, %rd110
  rd7 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd110));
  // PTX:77 mov.u32 %r155, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r155) : "r"(blockIdx.x));
  // PTX:78 mov.u32 %r156, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r156) : "r"(blockDim.x));
  // PTX:79 mul.wide.u32 %rd116, %r155, %r156
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd116) : "r"(r155), "r"(r156));
  // PTX:80 mov.u32 %r157, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r157) : "r"(threadIdx.x));
  // PTX:81 cvt.u64.u32 %rd117, %r157
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd117) : "r"(r157));
  // PTX:82 add.s64 %rd11, %rd116, %rd117
  asm("add.s64 %0, %1, %2;" : "=l"(rd11) : "l"(rd116), "l"(rd117));
  // PTX:83 setp.eq.s64 %p6, %rd76, 0
  p6 = (((long long)(rd76)) == ((long long)(0)));
  // PTX:84 mov.u32 %r252, 0
  asm("mov.u32 %0, 0;" : "=r"(r252) : );
  // PTX:85 @%p6 bra $L__BB3_2
  if (p6) { goto L_BB3_2; }
  // PTX:87 cvta.to.global.u64 %rd118, %rd76
  rd118 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd76));
  // PTX:88 ld.global.u32 %r158, [%rd118]
  r158 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd118) + (0)))));
  // PTX:89 max.s32 %r252, %r158, 0
  asm("max.s32 %0, %1, 0;" : "=r"(r252) : "r"(r158));
  // PTX:91 $L__BB3_2:
L_BB3_2:;
  // PTX:92 ld.param.u64 %rd319, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_1]
  rd319 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:93 cvt.u64.u32 %rd119, %r252
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd119) : "r"(r252));
  // PTX:94 setp.ge.u64 %p7, %rd11, %rd119
  p7 = (((unsigned long long)(rd11)) >= ((unsigned long long)(rd119)));
  // PTX:95 setp.ge.u64 %p8, %rd11, %rd319
  p8 = (((unsigned long long)(rd11)) >= ((unsigned long long)(rd319)));
  // PTX:96 or.pred %p9, %p8, %p7
  p9 = ((p8) || (p7));
  // PTX:97 @%p9 bra $L__BB3_145
  if (p9) { goto L_BB3_145; }
  // PTX:99 ld.param.u64 %rd323, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_3]
  rd323 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:100 ld.param.u64 %rd322, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_38]
  rd322 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param38 + (0))));
  // PTX:101 setp.eq.s64 %p10, %rd322, 0
  p10 = (((long long)(rd322)) == ((long long)(0)));
  // PTX:102 cvta.to.global.u64 %rd120, %rd323
  rd120 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd323));
  // PTX:103 shl.b64 %rd121, %rd11, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd121) : "l"(rd11));
  // PTX:104 add.s64 %rd12, %rd120, %rd121
  asm("add.s64 %0, %1, %2;" : "=l"(rd12) : "l"(rd120), "l"(rd121));
  // PTX:105 @%p10 bra $L__BB3_6
  if (p10) { goto L_BB3_6; }
  // PTX:107 ld.param.u64 %rd324, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_39]
  rd324 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param39 + (0))));
  // PTX:108 ld.global.s32 %rd13, [%rd12]
  rd13 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (0)))));
  // PTX:109 setp.lt.s64 %p11, %rd13, 0
  p11 = (((long long)(rd13)) < ((long long)(0)));
  // PTX:110 setp.ge.u64 %p12, %rd13, %rd324
  p12 = (((unsigned long long)(rd13)) >= ((unsigned long long)(rd324)));
  // PTX:111 or.pred %p13, %p11, %p12
  p13 = ((p11) || (p12));
  // PTX:112 @%p13 bra $L__BB3_145
  if (p13) { goto L_BB3_145; }
  // PTX:114 ld.param.u64 %rd307, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_38]
  rd307 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param38 + (0))));
  // PTX:115 cvta.to.global.u64 %rd122, %rd307
  rd122 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd307));
  // PTX:116 shl.b64 %rd123, %rd13, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd123) : "l"(rd13));
  // PTX:117 add.s64 %rd124, %rd122, %rd123
  asm("add.s64 %0, %1, %2;" : "=l"(rd124) : "l"(rd122), "l"(rd123));
  // PTX:118 ld.global.u32 %r159, [%rd124]
  r159 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd124) + (0)))));
  // PTX:119 setp.eq.s32 %p14, %r159, 0
  p14 = (((int)(r159)) == ((int)(0)));
  // PTX:120 @%p14 bra $L__BB3_145
  if (p14) { goto L_BB3_145; }
  // PTX:122 $L__BB3_6:
L_BB3_6:;
  // PTX:123 ld.param.u64 %rd320, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_11]
  rd320 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:124 ld.param.u64 %rd308, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_2]
  rd308 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:125 cvta.to.global.u64 %rd125, %rd308
  rd125 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd308));
  // PTX:126 add.s64 %rd127, %rd125, %rd121
  asm("add.s64 %0, %1, %2;" : "=l"(rd127) : "l"(rd125), "l"(rd121));
  // PTX:127 ld.global.u32 %r3, [%rd127]
  r3 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd127) + (0)))));
  // PTX:128 setp.lt.s32 %p15, %r3, 0
  p15 = (((int)(r3)) < ((int)(0)));
  // PTX:129 setp.eq.s64 %p16, %rd86, 0
  p16 = (((long long)(rd86)) == ((long long)(0)));
  // PTX:130 or.pred %p17, %p16, %p15
  p17 = ((p16) || (p15));
  // PTX:131 cvt.s64.s32 %rd14, %r3
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd14) : "r"(r3));
  // PTX:132 setp.ge.u64 %p18, %rd14, %rd320
  p18 = (((unsigned long long)(rd14)) >= ((unsigned long long)(rd320)));
  // PTX:133 or.pred %p19, %p17, %p18
  p19 = ((p17) || (p18));
  // PTX:134 @%p19 bra $L__BB3_145
  if (p19) { goto L_BB3_145; }
  // PTX:136 or.b64 %rd128, %rd14, %rd86
  asm("or.b64 %0, %1, %2;" : "=l"(rd128) : "l"(rd14), "l"(rd86));
  // PTX:137 and.b64 %rd129, %rd128, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd129) : "l"(rd128));
  // PTX:138 setp.eq.s64 %p20, %rd129, 0
  p20 = (((long long)(rd129)) == ((long long)(0)));
  // PTX:139 @%p20 bra $L__BB3_9
  if (p20) { goto L_BB3_9; }
  // PTX:141 div.u64 %rd362, %rd14, %rd86
  asm("div.u64 %0, %1, %2;" : "=l"(rd362) : "l"(rd14), "l"(rd86));
  // PTX:142 bra.uni $L__BB3_10
  goto L_BB3_10;
  // PTX:144 $L__BB3_9:
L_BB3_9:;
  // PTX:145 cvt.u32.u64 %r160, %rd86
  asm("cvt.u32.u64 %0, %1;" : "=r"(r160) : "l"(rd86));
  // PTX:146 cvt.u32.u64 %r161, %rd14
  asm("cvt.u32.u64 %0, %1;" : "=r"(r161) : "l"(rd14));
  // PTX:147 div.u32 %r162, %r161, %r160
  asm("div.u32 %0, %1, %2;" : "=r"(r162) : "r"(r161), "r"(r160));
  // PTX:148 cvt.u64.u32 %rd362, %r162
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd362) : "r"(r162));
  // PTX:150 $L__BB3_10:
L_BB3_10:;
  // PTX:151 ld.global.s32 %rd18, [%rd12]
  rd18 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (0)))));
  // PTX:152 setp.lt.s64 %p21, %rd18, 0
  p21 = (((long long)(rd18)) < ((long long)(0)));
  // PTX:153 @%p21 bra $L__BB3_145
  if (p21) { goto L_BB3_145; }
  // PTX:155 ld.param.u64 %rd327, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_22]
  rd327 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param22 + (0))));
  // PTX:156 ld.param.u64 %rd321, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_23]
  rd321 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param23 + (0))));
  // PTX:157 mul.lo.s64 %rd19, %rd321, %rd327
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd321), "l"(rd327));
  // PTX:158 setp.gt.u64 %p22, %rd19, %rd18
  p22 = (((unsigned long long)(rd19)) > ((unsigned long long)(rd18)));
  // PTX:159 @%p22 bra $L__BB3_13
  if (p22) { goto L_BB3_13; }
  // PTX:160 bra.uni $L__BB3_12
  goto L_BB3_12;
  // PTX:162 $L__BB3_13:
L_BB3_13:;
  // PTX:163 ld.param.u64 %rd347, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_22]
  rd347 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param22 + (0))));
  // PTX:164 or.b64 %rd131, %rd18, %rd347
  asm("or.b64 %0, %1, %2;" : "=l"(rd131) : "l"(rd18), "l"(rd347));
  // PTX:165 and.b64 %rd132, %rd131, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd132) : "l"(rd131));
  // PTX:166 setp.eq.s64 %p24, %rd132, 0
  p24 = (((long long)(rd132)) == ((long long)(0)));
  // PTX:167 @%p24 bra $L__BB3_15
  if (p24) { goto L_BB3_15; }
  // PTX:169 ld.param.u64 %rd348, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_22]
  rd348 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param22 + (0))));
  // PTX:170 div.u64 %rd363, %rd18, %rd348
  asm("div.u64 %0, %1, %2;" : "=l"(rd363) : "l"(rd18), "l"(rd348));
  // PTX:171 mul.lo.s64 %rd133, %rd363, %rd348
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd133) : "l"(rd363), "l"(rd348));
  // PTX:172 sub.s64 %rd365, %rd18, %rd133
  asm("sub.s64 %0, %1, %2;" : "=l"(rd365) : "l"(rd18), "l"(rd133));
  // PTX:173 bra.uni $L__BB3_16
  goto L_BB3_16;
  // PTX:175 $L__BB3_12:
L_BB3_12:;
  // PTX:176 ld.param.u64 %rd328, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_22]
  rd328 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param22 + (0))));
  // PTX:177 ld.param.u64 %rd309, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_21]
  rd309 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param21 + (0))));
  // PTX:178 sub.s64 %rd130, %rd18, %rd19
  asm("sub.s64 %0, %1, %2;" : "=l"(rd130) : "l"(rd18), "l"(rd19));
  // PTX:179 add.s64 %rd365, %rd130, %rd328
  asm("add.s64 %0, %1, %2;" : "=l"(rd365) : "l"(rd130), "l"(rd328));
  // PTX:180 setp.lt.u64 %p23, %rd365, %rd309
  p23 = (((unsigned long long)(rd365)) < ((unsigned long long)(rd309)));
  // PTX:181 mov.u32 %r253, -1
  asm("mov.u32 %0, -1;" : "=r"(r253) : );
  // PTX:182 @%p23 bra $L__BB3_17
  if (p23) { goto L_BB3_17; }
  // PTX:183 bra.uni $L__BB3_145
  goto L_BB3_145;
  // PTX:185 $L__BB3_15:
L_BB3_15:;
  // PTX:186 ld.param.u64 %rd349, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_22]
  rd349 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param22 + (0))));
  // PTX:187 cvt.u32.u64 %r164, %rd349
  asm("cvt.u32.u64 %0, %1;" : "=r"(r164) : "l"(rd349));
  // PTX:188 cvt.u32.u64 %r165, %rd18
  asm("cvt.u32.u64 %0, %1;" : "=r"(r165) : "l"(rd18));
  // PTX:189 div.u32 %r166, %r165, %r164
  asm("div.u32 %0, %1, %2;" : "=r"(r166) : "r"(r165), "r"(r164));
  // PTX:190 mul.lo.s32 %r167, %r166, %r164
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r167) : "r"(r166), "r"(r164));
  // PTX:191 sub.s32 %r168, %r165, %r167
  asm("sub.s32 %0, %1, %2;" : "=r"(r168) : "r"(r165), "r"(r167));
  // PTX:192 cvt.u64.u32 %rd363, %r166
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd363) : "r"(r166));
  // PTX:193 cvt.u64.u32 %rd365, %r168
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd365) : "r"(r168));
  // PTX:195 $L__BB3_16:
L_BB3_16:;
  // PTX:196 cvt.u32.u64 %r253, %rd363
  asm("cvt.u32.u64 %0, %1;" : "=r"(r253) : "l"(rd363));
  // PTX:198 $L__BB3_17:
L_BB3_17:;
  // PTX:199 cvt.u32.u64 %r169, %rd362
  asm("cvt.u32.u64 %0, %1;" : "=r"(r169) : "l"(rd362));
  // PTX:200 setp.ne.s32 %p25, %r253, %r169
  p25 = (((int)(r253)) != ((int)(r169)));
  // PTX:201 setp.gt.s32 %p26, %r253, -1
  p26 = (((int)(r253)) > ((int)(-1)));
  // PTX:202 and.pred %p27, %p26, %p25
  p27 = ((p26) && (p25));
  // PTX:203 @%p27 bra $L__BB3_145
  if (p27) { goto L_BB3_145; }
  // PTX:205 @%p20 bra $L__BB3_20
  if (p20) { goto L_BB3_20; }
  // PTX:207 ld.param.u64 %rd350, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_10]
  rd350 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:208 rem.u64 %rd366, %rd14, %rd350
  asm("rem.u64 %0, %1, %2;" : "=l"(rd366) : "l"(rd14), "l"(rd350));
  // PTX:209 bra.uni $L__BB3_21
  goto L_BB3_21;
  // PTX:211 $L__BB3_20:
L_BB3_20:;
  // PTX:212 ld.param.u64 %rd352, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_10]
  rd352 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:213 cvt.u32.u64 %r170, %rd352
  asm("cvt.u32.u64 %0, %1;" : "=r"(r170) : "l"(rd352));
  // PTX:214 cvt.u32.u64 %r171, %rd14
  asm("cvt.u32.u64 %0, %1;" : "=r"(r171) : "l"(rd14));
  // PTX:215 rem.u32 %r172, %r171, %r170
  asm("rem.u32 %0, %1, %2;" : "=r"(r172) : "r"(r171), "r"(r170));
  // PTX:216 cvt.u64.u32 %rd366, %r172
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd366) : "r"(r172));
  // PTX:218 $L__BB3_21:
L_BB3_21:;
  // PTX:219 ld.param.u64 %rd310, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_8]
  rd310 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:220 cvta.to.global.u64 %rd136, %rd310
  rd136 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd310));
  // PTX:221 shl.b64 %rd137, %rd366, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd137) : "l"(rd366));
  // PTX:222 add.s64 %rd138, %rd136, %rd137
  asm("add.s64 %0, %1, %2;" : "=l"(rd138) : "l"(rd136), "l"(rd137));
  // PTX:223 ld.global.f32 %f1, [%rd138]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd138) + (0)))));
  // PTX:224 setp.leu.f32 %p29, %f1, 0f00000000
  p29 = ((isnan(((float)(f1))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f1)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:225 @%p29 bra $L__BB3_145
  if (p29) { goto L_BB3_145; }
  // PTX:227 ld.param.u64 %rd325, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_9]
  rd325 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:228 setp.eq.s64 %p30, %rd325, 0
  p30 = (((long long)(rd325)) == ((long long)(0)));
  // PTX:229 @%p30 bra $L__BB3_24
  if (p30) { goto L_BB3_24; }
  // PTX:231 ld.param.u64 %rd326, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_9]
  rd326 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:232 cvta.to.global.u64 %rd139, %rd326
  rd139 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd326));
  // PTX:233 add.s64 %rd141, %rd139, %rd137
  asm("add.s64 %0, %1, %2;" : "=l"(rd141) : "l"(rd139), "l"(rd137));
  // PTX:234 ld.global.u32 %r173, [%rd141]
  r173 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd141) + (0)))));
  // PTX:235 setp.ne.s32 %p31, %r173, 0
  p31 = (((int)(r173)) != ((int)(0)));
  // PTX:236 @%p31 bra $L__BB3_145
  if (p31) { goto L_BB3_145; }
  // PTX:238 $L__BB3_24:
L_BB3_24:;
  // PTX:239 ld.param.u64 %rd311, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_12]
  rd311 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:240 shl.b64 %rd142, %rd365, 32
  asm("shl.b64 %0, %1, 32;" : "=l"(rd142) : "l"(rd365));
  // PTX:241 cvt.s64.s32 %rd31, %rd365
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd31) : "l"(rd365));
  // PTX:242 cvta.to.global.u64 %rd143, %rd311
  rd143 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd311));
  // PTX:243 shr.s64 %rd144, %rd142, 30
  asm("shr.s64 %0, %1, 30;" : "=l"(rd144) : "l"(rd142));
  // PTX:244 add.s64 %rd145, %rd143, %rd144
  asm("add.s64 %0, %1, %2;" : "=l"(rd145) : "l"(rd143), "l"(rd144));
  // PTX:245 ld.global.u32 %r6, [%rd145]
  r6 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd145) + (0)))));
  // PTX:246 cvt.s64.s32 %rd32, %r6
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd32) : "r"(r6));
  // PTX:247 setp.lt.s32 %p32, %r6, 0
  p32 = (((int)(r6)) < ((int)(0)));
  // PTX:248 mov.u32 %r174, -1
  asm("mov.u32 %0, -1;" : "=r"(r174) : );
  // PTX:249 mov.u32 %r254, %r174
  asm("mov.u32 %0, %1;" : "=r"(r254) : "r"(r174));
  // PTX:250 @%p32 bra $L__BB3_32
  if (p32) { goto L_BB3_32; }
  // PTX:252 setp.ge.u64 %p33, %rd32, %rd102
  p33 = (((unsigned long long)(rd32)) >= ((unsigned long long)(rd102)));
  // PTX:253 @%p33 bra $L__BB3_27
  if (p33) { goto L_BB3_27; }
  // PTX:255 cvt.s64.s32 %rd354, %r6
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd354) : "r"(r6));
  // PTX:256 shl.b64 %rd146, %rd354, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd146) : "l"(rd354));
  // PTX:257 add.s64 %rd147, %rd7, %rd146
  asm("add.s64 %0, %1, %2;" : "=l"(rd147) : "l"(rd7), "l"(rd146));
  // PTX:258 ld.global.u32 %r175, [%rd147]
  r175 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd147) + (0)))));
  // PTX:259 setp.eq.s32 %p34, %r175, %r6
  p34 = (((int)(r175)) == ((int)(r6)));
  // PTX:260 mov.u32 %r254, %r6
  asm("mov.u32 %0, %1;" : "=r"(r254) : "r"(r6));
  // PTX:261 @%p34 bra $L__BB3_32
  if (p34) { goto L_BB3_32; }
  // PTX:263 $L__BB3_27:
L_BB3_27:;
  // PTX:264 setp.eq.s64 %p35, %rd102, 0
  p35 = (((long long)(rd102)) == ((long long)(0)));
  // PTX:265 mov.u32 %r254, %r174
  asm("mov.u32 %0, %1;" : "=r"(r254) : "r"(r174));
  // PTX:266 @%p35 bra $L__BB3_32
  if (p35) { goto L_BB3_32; }
  // PTX:268 mov.u64 %rd367, 0
  asm("mov.u64 %0, 0;" : "=l"(rd367) : );
  // PTX:270 $L__BB3_29:
L_BB3_29:;
  // PTX:271 shl.b64 %rd149, %rd367, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd149) : "l"(rd367));
  // PTX:272 add.s64 %rd150, %rd7, %rd149
  asm("add.s64 %0, %1, %2;" : "=l"(rd150) : "l"(rd7), "l"(rd149));
  // PTX:273 ld.global.u32 %r177, [%rd150]
  r177 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd150) + (0)))));
  // PTX:274 setp.eq.s32 %p36, %r177, %r6
  p36 = (((int)(r177)) == ((int)(r6)));
  // PTX:275 @%p36 bra $L__BB3_31
  if (p36) { goto L_BB3_31; }
  // PTX:277 add.s64 %rd367, %rd367, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd367) : "l"(rd367));
  // PTX:278 setp.lt.u64 %p37, %rd367, %rd102
  p37 = (((unsigned long long)(rd367)) < ((unsigned long long)(rd102)));
  // PTX:279 mov.u32 %r254, %r174
  asm("mov.u32 %0, %1;" : "=r"(r254) : "r"(r174));
  // PTX:280 @%p37 bra $L__BB3_29
  if (p37) { goto L_BB3_29; }
  // PTX:281 bra.uni $L__BB3_32
  goto L_BB3_32;
  // PTX:283 $L__BB3_31:
L_BB3_31:;
  // PTX:284 cvt.u32.u64 %r254, %rd367
  asm("cvt.u32.u64 %0, %1;" : "=r"(r254) : "l"(rd367));
  // PTX:286 $L__BB3_32:
L_BB3_32:;
  // PTX:287 setp.lt.s32 %p38, %r254, 0
  p38 = (((int)(r254)) < ((int)(0)));
  // PTX:288 setp.gt.s32 %p39, %r6, -1
  p39 = (((int)(r6)) > ((int)(-1)));
  // PTX:289 and.pred %p40, %p39, %p38
  p40 = ((p39) && (p38));
  // PTX:290 @%p40 bra $L__BB3_145
  if (p40) { goto L_BB3_145; }
  // PTX:292 setp.gt.s32 %p41, %r254, -1
  p41 = (((int)(r254)) > ((int)(-1)));
  // PTX:293 setp.lt.s32 %p42, %r253, 0
  p42 = (((int)(r253)) < ((int)(0)));
  // PTX:294 and.pred %p43, %p42, %p41
  p43 = ((p42) && (p41));
  // PTX:295 @%p43 bra $L__BB3_145
  if (p43) { goto L_BB3_145; }
  // PTX:297 mov.u32 %r255, 0
  asm("mov.u32 %0, 0;" : "=r"(r255) : );
  // PTX:298 mov.u32 %r256, %r255
  asm("mov.u32 %0, %1;" : "=r"(r256) : "r"(r255));
  // PTX:299 mov.u32 %r257, %r255
  asm("mov.u32 %0, %1;" : "=r"(r257) : "r"(r255));
  // PTX:300 mov.u32 %r258, %r255
  asm("mov.u32 %0, %1;" : "=r"(r258) : "r"(r255));
  // PTX:301 @%p38 bra $L__BB3_36
  if (p38) { goto L_BB3_36; }
  // PTX:303 ld.param.u64 %rd351, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_10]
  rd351 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:304 ld.param.u64 %rd312, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_29]
  rd312 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param29 + (0))));
  // PTX:305 cvta.to.global.u64 %rd151, %rd312
  rd151 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd312));
  // PTX:306 mul.wide.s32 %rd152, %r254, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd152) : "r"(r254));
  // PTX:307 add.s64 %rd153, %rd151, %rd152
  asm("add.s64 %0, %1, %2;" : "=l"(rd153) : "l"(rd151), "l"(rd152));
  // PTX:308 cvt.u32.u64 %r183, %rd351
  asm("cvt.u32.u64 %0, %1;" : "=r"(r183) : "l"(rd351));
  // PTX:309 mul.lo.s32 %r184, %r253, %r183
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r184) : "r"(r253), "r"(r183));
  // PTX:310 ld.global.u32 %r185, [%rd153]
  r185 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd153) + (0)))));
  // PTX:311 ld.global.u32 %r186, [%rd153+4]
  r186 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd153) + (4)))));
  // PTX:312 ld.global.u32 %r187, [%rd153+8]
  r187 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd153) + (8)))));
  // PTX:313 ld.global.u32 %r188, [%rd153+12]
  r188 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd153) + (12)))));
  // PTX:314 add.s32 %r258, %r188, %r184
  asm("add.s32 %0, %1, %2;" : "=r"(r258) : "r"(r188), "r"(r184));
  // PTX:315 add.s32 %r257, %r187, %r184
  asm("add.s32 %0, %1, %2;" : "=r"(r257) : "r"(r187), "r"(r184));
  // PTX:316 add.s32 %r256, %r186, %r184
  asm("add.s32 %0, %1, %2;" : "=r"(r256) : "r"(r186), "r"(r184));
  // PTX:317 add.s32 %r255, %r185, %r184
  asm("add.s32 %0, %1, %2;" : "=r"(r255) : "r"(r185), "r"(r184));
  // PTX:319 $L__BB3_36:
L_BB3_36:;
  // PTX:320 ld.param.u64 %rd313, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_13]
  rd313 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:321 cvta.to.global.u64 %rd154, %rd313
  rd154 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd313));
  // PTX:322 shl.b64 %rd155, %rd31, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd155) : "l"(rd31));
  // PTX:323 add.s64 %rd156, %rd154, %rd155
  asm("add.s64 %0, %1, %2;" : "=l"(rd156) : "l"(rd154), "l"(rd155));
  // PTX:324 ld.global.u32 %r17, [%rd156]
  r17 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd156) + (0)))));
  // PTX:325 setp.eq.s32 %p45, %r17, 3
  p45 = (((int)(r17)) == ((int)(3)));
  // PTX:326 @%p45 bra $L__BB3_38
  if (p45) { goto L_BB3_38; }
  // PTX:327 bra.uni $L__BB3_37
  goto L_BB3_37;
  // PTX:329 $L__BB3_38:
L_BB3_38:;
  // PTX:330 ld.param.u64 %rd318, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_14]
  rd318 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:331 cvta.to.global.u64 %rd159, %rd318
  rd159 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd318));
  // PTX:332 mul.lo.s64 %rd160, %rd31, 28
  asm("mul.lo.s64 %0, %1, 28;" : "=l"(rd160) : "l"(rd31));
  // PTX:333 add.s64 %rd370, %rd159, %rd160
  asm("add.s64 %0, %1, %2;" : "=l"(rd370) : "l"(rd159), "l"(rd160));
  // PTX:334 add.s64 %rd369, %rd370, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd369) : "l"(rd370));
  // PTX:335 add.s64 %rd368, %rd370, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd368) : "l"(rd370));
  // PTX:336 bra.uni $L__BB3_39
  goto L_BB3_39;
  // PTX:338 $L__BB3_37:
L_BB3_37:;
  // PTX:339 ld.param.u64 %rd314, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_4]
  rd314 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:340 cvta.to.global.u64 %rd157, %rd314
  rd157 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd314));
  // PTX:341 mul.lo.s64 %rd158, %rd11, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd158) : "l"(rd11));
  // PTX:342 add.s64 %rd370, %rd157, %rd158
  asm("add.s64 %0, %1, %2;" : "=l"(rd370) : "l"(rd157), "l"(rd158));
  // PTX:343 add.s64 %rd369, %rd370, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd369) : "l"(rd370));
  // PTX:344 add.s64 %rd368, %rd370, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd368) : "l"(rd370));
  // PTX:346 $L__BB3_39:
L_BB3_39:;
  // PTX:347 ld.param.u64 %rd315, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_30]
  rd315 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param30 + (0))));
  // PTX:348 ld.global.u32 %r18, [%rd370]
  r18 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd370) + (0)))));
  // PTX:349 ld.global.u32 %r19, [%rd369]
  r19 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd369) + (0)))));
  // PTX:350 ld.global.u32 %r20, [%rd368]
  r20 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd368) + (0)))));
  // PTX:351 cvta.to.global.u64 %rd161, %rd315
  rd161 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd315));
  // PTX:352 mul.wide.s32 %rd162, %r254, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd162) : "r"(r254));
  // PTX:353 add.s64 %rd44, %rd161, %rd162
  asm("add.s64 %0, %1, %2;" : "=l"(rd44) : "l"(rd161), "l"(rd162));
  // PTX:354 mov.u32 %r299, %r20
  asm("mov.u32 %0, %1;" : "=r"(r299) : "r"(r20));
  // PTX:355 mov.u32 %r300, %r19
  asm("mov.u32 %0, %1;" : "=r"(r300) : "r"(r19));
  // PTX:356 mov.u32 %r301, %r18
  asm("mov.u32 %0, %1;" : "=r"(r301) : "r"(r18));
  // PTX:357 @%p38 bra $L__BB3_41
  if (p38) { goto L_BB3_41; }
  // PTX:359 ld.global.f32 %f258, [%rd44]
  f258 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))));
  // PTX:360 mov.b32 %f259, %r18
  asm("mov.b32 %0, %1;" : "=f"(f259) : "r"(r18));
  // PTX:361 sub.f32 %f260, %f259, %f258
  asm("sub.f32 %0, %1, %2;" : "=f"(f260) : "f"(f259), "f"(f258));
  // PTX:362 mov.b32 %f261, %r19
  asm("mov.b32 %0, %1;" : "=f"(f261) : "r"(r19));
  // PTX:363 ld.global.f32 %f262, [%rd44+4]
  f262 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (4)))));
  // PTX:364 sub.f32 %f263, %f261, %f262
  asm("sub.f32 %0, %1, %2;" : "=f"(f263) : "f"(f261), "f"(f262));
  // PTX:365 mov.b32 %f264, %r20
  asm("mov.b32 %0, %1;" : "=f"(f264) : "r"(r20));
  // PTX:366 ld.global.f32 %f265, [%rd44+8]
  f265 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (8)))));
  // PTX:367 sub.f32 %f266, %f264, %f265
  asm("sub.f32 %0, %1, %2;" : "=f"(f266) : "f"(f264), "f"(f265));
  // PTX:368 mul.wide.s32 %rd163, %r255, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd163) : "r"(r255));
  // PTX:369 add.s64 %rd164, %rd6, %rd163
  asm("add.s64 %0, %1, %2;" : "=l"(rd164) : "l"(rd6), "l"(rd163));
  // PTX:370 mul.wide.s32 %rd165, %r256, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd165) : "r"(r256));
  // PTX:371 add.s64 %rd166, %rd6, %rd165
  asm("add.s64 %0, %1, %2;" : "=l"(rd166) : "l"(rd6), "l"(rd165));
  // PTX:372 ld.global.f32 %f267, [%rd166]
  f267 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd166) + (0)))));
  // PTX:373 ld.global.f32 %f268, [%rd166+4]
  f268 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd166) + (4)))));
  // PTX:374 ld.global.f32 %f269, [%rd166+8]
  f269 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd166) + (8)))));
  // PTX:375 ld.global.f32 %f270, [%rd164]
  f270 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd164) + (0)))));
  // PTX:376 fma.rn.f32 %f271, %f260, %f267, %f270
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f271) : "f"(f260), "f"(f267), "f"(f270));
  // PTX:377 ld.global.f32 %f272, [%rd164+4]
  f272 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd164) + (4)))));
  // PTX:378 fma.rn.f32 %f273, %f260, %f268, %f272
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f273) : "f"(f260), "f"(f268), "f"(f272));
  // PTX:379 ld.global.f32 %f274, [%rd164+8]
  f274 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd164) + (8)))));
  // PTX:380 fma.rn.f32 %f275, %f260, %f269, %f274
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f275) : "f"(f260), "f"(f269), "f"(f274));
  // PTX:381 mul.wide.s32 %rd167, %r257, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd167) : "r"(r257));
  // PTX:382 add.s64 %rd168, %rd6, %rd167
  asm("add.s64 %0, %1, %2;" : "=l"(rd168) : "l"(rd6), "l"(rd167));
  // PTX:383 ld.global.f32 %f276, [%rd168]
  f276 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd168) + (0)))));
  // PTX:384 ld.global.f32 %f277, [%rd168+4]
  f277 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd168) + (4)))));
  // PTX:385 ld.global.f32 %f278, [%rd168+8]
  f278 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd168) + (8)))));
  // PTX:386 fma.rn.f32 %f279, %f263, %f276, %f271
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f279) : "f"(f263), "f"(f276), "f"(f271));
  // PTX:387 fma.rn.f32 %f280, %f263, %f277, %f273
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f280) : "f"(f263), "f"(f277), "f"(f273));
  // PTX:388 fma.rn.f32 %f281, %f263, %f278, %f275
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f281) : "f"(f263), "f"(f278), "f"(f275));
  // PTX:389 mul.wide.s32 %rd169, %r258, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd169) : "r"(r258));
  // PTX:390 add.s64 %rd170, %rd6, %rd169
  asm("add.s64 %0, %1, %2;" : "=l"(rd170) : "l"(rd6), "l"(rd169));
  // PTX:391 ld.global.f32 %f282, [%rd170]
  f282 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd170) + (0)))));
  // PTX:392 ld.global.f32 %f283, [%rd170+4]
  f283 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd170) + (4)))));
  // PTX:393 ld.global.f32 %f284, [%rd170+8]
  f284 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd170) + (8)))));
  // PTX:394 fma.rn.f32 %f285, %f266, %f282, %f279
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f285) : "f"(f266), "f"(f282), "f"(f279));
  // PTX:395 fma.rn.f32 %f286, %f266, %f283, %f280
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f286) : "f"(f266), "f"(f283), "f"(f280));
  // PTX:396 fma.rn.f32 %f287, %f266, %f284, %f281
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f287) : "f"(f266), "f"(f284), "f"(f281));
  // PTX:397 mov.b32 %r301, %f285
  asm("mov.b32 %0, %1;" : "=r"(r301) : "f"(f285));
  // PTX:398 mov.b32 %r300, %f286
  asm("mov.b32 %0, %1;" : "=r"(r300) : "f"(f286));
  // PTX:399 mov.b32 %r299, %f287
  asm("mov.b32 %0, %1;" : "=r"(r299) : "f"(f287));
  // PTX:401 $L__BB3_41:
L_BB3_41:;
  // PTX:402 ld.param.u64 %rd316, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_6]
  rd316 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:403 cvta.to.global.u64 %rd171, %rd316
  rd171 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd316));
  // PTX:404 mul.lo.s64 %rd172, %rd11, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd172) : "l"(rd11));
  // PTX:405 add.s64 %rd173, %rd171, %rd172
  asm("add.s64 %0, %1, %2;" : "=l"(rd173) : "l"(rd171), "l"(rd172));
  // PTX:406 ld.global.f32 %f2, [%rd173]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd173) + (0)))));
  // PTX:407 ld.global.f32 %f3, [%rd173+4]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd173) + (4)))));
  // PTX:408 mul.f32 %f288, %f3, %f3
  asm("mul.f32 %0, %1, %2;" : "=f"(f288) : "f"(f3), "f"(f3));
  // PTX:409 ld.global.f32 %f4, [%rd173+8]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd173) + (8)))));
  // PTX:410 fma.rn.f32 %f289, %f2, %f2, %f288
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f289) : "f"(f2), "f"(f2), "f"(f288));
  // PTX:411 fma.rn.f32 %f290, %f4, %f4, %f289
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f290) : "f"(f4), "f"(f4), "f"(f289));
  // PTX:412 sqrt.rn.f32 %f5, %f290
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f5) : "f"(f290));
  // PTX:413 setp.leu.f32 %p47, %f5, 0f00000000
  p47 = ((isnan(((float)(f5))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f5)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:414 mov.u32 %r262, 0
  asm("mov.u32 %0, 0;" : "=r"(r262) : );
  // PTX:415 mov.u32 %r263, %r262
  asm("mov.u32 %0, %1;" : "=r"(r263) : "r"(r262));
  // PTX:416 mov.u32 %r264, %r262
  asm("mov.u32 %0, %1;" : "=r"(r264) : "r"(r262));
  // PTX:417 @%p47 bra $L__BB3_43
  if (p47) { goto L_BB3_43; }
  // PTX:419 div.rn.f32 %f291, %f2, %f5
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f291) : "f"(f2), "f"(f5));
  // PTX:420 div.rn.f32 %f292, %f3, %f5
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f292) : "f"(f3), "f"(f5));
  // PTX:421 div.rn.f32 %f293, %f4, %f5
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f293) : "f"(f4), "f"(f5));
  // PTX:422 mov.b32 %r264, %f293
  asm("mov.b32 %0, %1;" : "=r"(r264) : "f"(f293));
  // PTX:423 mov.b32 %r263, %f292
  asm("mov.b32 %0, %1;" : "=r"(r263) : "f"(f292));
  // PTX:424 mov.b32 %r262, %f291
  asm("mov.b32 %0, %1;" : "=r"(r262) : "f"(f291));
  // PTX:426 $L__BB3_43:
L_BB3_43:;
  // PTX:427 cvt.s64.s32 %rd355, %rd365
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd355) : "l"(rd365));
  // PTX:428 cvt.s64.s32 %rd353, %r3
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd353) : "r"(r3));
  // PTX:429 ld.param.u64 %rd317, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_15]
  rd317 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param15 + (0))));
  // PTX:430 mul.lo.s64 %rd174, %rd353, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd174) : "l"(rd353));
  // PTX:431 add.s64 %rd45, %rd6, %rd174
  asm("add.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd6), "l"(rd174));
  // PTX:432 cvta.to.global.u64 %rd175, %rd317
  rd175 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd317));
  // PTX:433 mul.lo.s64 %rd176, %rd355, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd176) : "l"(rd355));
  // PTX:434 add.s64 %rd46, %rd175, %rd176
  asm("add.s64 %0, %1, %2;" : "=l"(rd46) : "l"(rd175), "l"(rd176));
  // PTX:435 @%p45 bra $L__BB3_45
  if (p45) { goto L_BB3_45; }
  // PTX:436 bra.uni $L__BB3_44
  goto L_BB3_44;
  // PTX:438 $L__BB3_45:
L_BB3_45:;
  // PTX:439 ld.global.f32 %f294, [%rd45]
  f294 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))));
  // PTX:440 mov.b32 %f295, %r301
  asm("mov.b32 %0, %1;" : "=f"(f295) : "r"(r301));
  // PTX:441 sub.f32 %f9, %f294, %f295
  asm("sub.f32 %0, %1, %2;" : "=f"(f9) : "f"(f294), "f"(f295));
  // PTX:442 mov.b32 %f296, %r300
  asm("mov.b32 %0, %1;" : "=f"(f296) : "r"(r300));
  // PTX:443 ld.global.f32 %f297, [%rd45+4]
  f297 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (4)))));
  // PTX:444 sub.f32 %f10, %f297, %f296
  asm("sub.f32 %0, %1, %2;" : "=f"(f10) : "f"(f297), "f"(f296));
  // PTX:445 mov.b32 %f298, %r299
  asm("mov.b32 %0, %1;" : "=f"(f298) : "r"(r299));
  // PTX:446 ld.global.f32 %f299, [%rd45+8]
  f299 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (8)))));
  // PTX:447 sub.f32 %f11, %f299, %f298
  asm("sub.f32 %0, %1, %2;" : "=f"(f11) : "f"(f299), "f"(f298));
  // PTX:448 mul.f32 %f300, %f10, %f10
  asm("mul.f32 %0, %1, %2;" : "=f"(f300) : "f"(f10), "f"(f10));
  // PTX:449 fma.rn.f32 %f301, %f9, %f9, %f300
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f301) : "f"(f9), "f"(f9), "f"(f300));
  // PTX:450 fma.rn.f32 %f302, %f11, %f11, %f301
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f302) : "f"(f11), "f"(f11), "f"(f301));
  // PTX:451 sqrt.rn.f32 %f12, %f302
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f12) : "f"(f302));
  // PTX:452 setp.leu.f32 %p49, %f12, 0f00000000
  p49 = ((isnan(((float)(f12))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f12)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:453 mov.u32 %r265, 0
  asm("mov.u32 %0, 0;" : "=r"(r265) : );
  // PTX:454 mov.u32 %r266, %r265
  asm("mov.u32 %0, %1;" : "=r"(r266) : "r"(r265));
  // PTX:455 mov.u32 %r267, %r265
  asm("mov.u32 %0, %1;" : "=r"(r267) : "r"(r265));
  // PTX:456 @%p49 bra $L__BB3_47
  if (p49) { goto L_BB3_47; }
  // PTX:458 div.rn.f32 %f303, %f9, %f12
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f303) : "f"(f9), "f"(f12));
  // PTX:459 div.rn.f32 %f304, %f10, %f12
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f304) : "f"(f10), "f"(f12));
  // PTX:460 div.rn.f32 %f305, %f11, %f12
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f305) : "f"(f11), "f"(f12));
  // PTX:461 mov.b32 %r267, %f305
  asm("mov.b32 %0, %1;" : "=r"(r267) : "f"(f305));
  // PTX:462 mov.b32 %r266, %f304
  asm("mov.b32 %0, %1;" : "=r"(r266) : "f"(f304));
  // PTX:463 mov.b32 %r265, %f303
  asm("mov.b32 %0, %1;" : "=r"(r265) : "f"(f303));
  // PTX:465 $L__BB3_47:
L_BB3_47:;
  // PTX:466 mov.b32 %f306, %r265
  asm("mov.b32 %0, %1;" : "=f"(f306) : "r"(r265));
  // PTX:467 mov.b32 %f307, %r266
  asm("mov.b32 %0, %1;" : "=f"(f307) : "r"(r266));
  // PTX:468 mul.f32 %f308, %f307, %f307
  asm("mul.f32 %0, %1, %2;" : "=f"(f308) : "f"(f307), "f"(f307));
  // PTX:469 mov.b32 %f309, %r267
  asm("mov.b32 %0, %1;" : "=f"(f309) : "r"(r267));
  // PTX:470 fma.rn.f32 %f310, %f306, %f306, %f308
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f310) : "f"(f306), "f"(f306), "f"(f308));
  // PTX:471 fma.rn.f32 %f311, %f309, %f309, %f310
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f311) : "f"(f309), "f"(f309), "f"(f310));
  // PTX:472 setp.ltu.f32 %p50, %f311, 0f3F000000
  p50 = ((isnan(((float)(f311))) || isnan(((float)(as_f32(0x3F000000u))))) || (((float)(f311)) < ((float)(as_f32(0x3F000000u)))));
  // PTX:473 selp.b32 %r45, %r264, %r267, %p50
  r45 = p50 ? r264 : r267;
  // PTX:474 selp.b32 %r46, %r263, %r266, %p50
  r46 = p50 ? r263 : r266;
  // PTX:475 selp.b32 %r195, %r262, %r265, %p50
  r195 = p50 ? r262 : r265;
  // PTX:476 ld.global.f32 %f13, [%rd46]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (0)))));
  // PTX:477 mov.b32 %f952, %r195
  asm("mov.b32 %0, %1;" : "=f"(f952) : "r"(r195));
  // PTX:478 mov.b32 %f951, %r46
  asm("mov.b32 %0, %1;" : "=f"(f951) : "r"(r46));
  // PTX:479 @%p38 bra $L__BB3_69
  if (p38) { goto L_BB3_69; }
  // PTX:481 mul.f32 %f16, %f13, %f952
  asm("mul.f32 %0, %1, %2;" : "=f"(f16) : "f"(f13), "f"(f952));
  // PTX:482 mul.f32 %f17, %f13, %f951
  asm("mul.f32 %0, %1, %2;" : "=f"(f17) : "f"(f13), "f"(f951));
  // PTX:483 mov.b32 %f950, %r45
  asm("mov.b32 %0, %1;" : "=f"(f950) : "r"(r45));
  // PTX:484 mul.f32 %f19, %f13, %f950
  asm("mul.f32 %0, %1, %2;" : "=f"(f19) : "f"(f13), "f"(f950));
  // PTX:485 mul.wide.s32 %rd177, %r256, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd177) : "r"(r256));
  // PTX:486 add.s64 %rd178, %rd6, %rd177
  asm("add.s64 %0, %1, %2;" : "=l"(rd178) : "l"(rd6), "l"(rd177));
  // PTX:487 mul.wide.s32 %rd179, %r257, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd179) : "r"(r257));
  // PTX:488 add.s64 %rd180, %rd6, %rd179
  asm("add.s64 %0, %1, %2;" : "=l"(rd180) : "l"(rd6), "l"(rd179));
  // PTX:489 mul.wide.s32 %rd181, %r258, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd181) : "r"(r258));
  // PTX:490 add.s64 %rd182, %rd6, %rd181
  asm("add.s64 %0, %1, %2;" : "=l"(rd182) : "l"(rd6), "l"(rd181));
  // PTX:491 ld.global.f32 %f20, [%rd182+8]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd182) + (8)))));
  // PTX:492 ld.global.f32 %f21, [%rd180+4]
  f21 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (4)))));
  // PTX:493 mul.f32 %f312, %f21, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f312) : "f"(f21), "f"(f20));
  // PTX:494 ld.global.f32 %f22, [%rd182+4]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd182) + (4)))));
  // PTX:495 ld.global.f32 %f23, [%rd180+8]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (8)))));
  // PTX:496 mul.f32 %f313, %f23, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f313) : "f"(f23), "f"(f22));
  // PTX:497 sub.f32 %f24, %f312, %f313
  asm("sub.f32 %0, %1, %2;" : "=f"(f24) : "f"(f312), "f"(f313));
  // PTX:498 ld.global.f32 %f25, [%rd182]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd182) + (0)))));
  // PTX:499 mul.f32 %f314, %f23, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f314) : "f"(f23), "f"(f25));
  // PTX:500 ld.global.f32 %f26, [%rd180]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (0)))));
  // PTX:501 mul.f32 %f315, %f26, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f315) : "f"(f26), "f"(f20));
  // PTX:502 sub.f32 %f27, %f314, %f315
  asm("sub.f32 %0, %1, %2;" : "=f"(f27) : "f"(f314), "f"(f315));
  // PTX:503 mul.f32 %f316, %f26, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f316) : "f"(f26), "f"(f22));
  // PTX:504 mul.f32 %f317, %f21, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f317) : "f"(f21), "f"(f25));
  // PTX:505 sub.f32 %f28, %f316, %f317
  asm("sub.f32 %0, %1, %2;" : "=f"(f28) : "f"(f316), "f"(f317));
  // PTX:506 ld.global.f32 %f29, [%rd178]
  f29 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd178) + (0)))));
  // PTX:507 ld.global.f32 %f30, [%rd178+4]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd178) + (4)))));
  // PTX:508 mul.f32 %f318, %f30, %f27
  asm("mul.f32 %0, %1, %2;" : "=f"(f318) : "f"(f30), "f"(f27));
  // PTX:509 ld.global.f32 %f31, [%rd178+8]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd178) + (8)))));
  // PTX:510 fma.rn.f32 %f319, %f29, %f24, %f318
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f319) : "f"(f29), "f"(f24), "f"(f318));
  // PTX:511 fma.rn.f32 %f32, %f31, %f28, %f319
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f32) : "f"(f31), "f"(f28), "f"(f319));
  // PTX:512 abs.f32 %f320, %f32
  asm("abs.f32 %0, %1;" : "=f"(f320) : "f"(f32));
  // PTX:513 setp.leu.f32 %p52, %f320, 0f2EDBE6FF
  p52 = ((isnan(((float)(f320))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) || (((float)(f320)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:514 setp.geu.f32 %p53, %f320, 0f7F800000
  p53 = ((isnan(((float)(f320))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f320)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:515 or.pred %p54, %p52, %p53
  p54 = ((p52) || (p53));
  // PTX:516 @%p54 bra $L__BB3_50
  if (p54) { goto L_BB3_50; }
  // PTX:517 bra.uni $L__BB3_49
  goto L_BB3_49;
  // PTX:519 $L__BB3_50:
L_BB3_50:;
  // PTX:520 mul.f32 %f358, %f30, %f30
  asm("mul.f32 %0, %1, %2;" : "=f"(f358) : "f"(f30), "f"(f30));
  // PTX:521 fma.rn.f32 %f359, %f29, %f29, %f358
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f359) : "f"(f29), "f"(f29), "f"(f358));
  // PTX:522 fma.rn.f32 %f360, %f31, %f31, %f359
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f360) : "f"(f31), "f"(f31), "f"(f359));
  // PTX:523 mul.f32 %f361, %f21, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f361) : "f"(f21), "f"(f21));
  // PTX:524 fma.rn.f32 %f362, %f26, %f26, %f361
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f362) : "f"(f26), "f"(f26), "f"(f361));
  // PTX:525 fma.rn.f32 %f363, %f23, %f23, %f362
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f363) : "f"(f23), "f"(f23), "f"(f362));
  // PTX:526 add.f32 %f364, %f360, %f363
  asm("add.f32 %0, %1, %2;" : "=f"(f364) : "f"(f360), "f"(f363));
  // PTX:527 mul.f32 %f365, %f22, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f365) : "f"(f22), "f"(f22));
  // PTX:528 fma.rn.f32 %f366, %f25, %f25, %f365
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f366) : "f"(f25), "f"(f25), "f"(f365));
  // PTX:529 fma.rn.f32 %f367, %f20, %f20, %f366
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f367) : "f"(f20), "f"(f20), "f"(f366));
  // PTX:530 add.f32 %f368, %f364, %f367
  asm("add.f32 %0, %1, %2;" : "=f"(f368) : "f"(f364), "f"(f367));
  // PTX:531 div.rn.f32 %f369, %f368, 0f40400000
  asm("div.rn.f32 %0, %1, 0f40400000;" : "=f"(f369) : "f"(f368));
  // PTX:532 sqrt.rn.f32 %f33, %f369
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f33) : "f"(f369));
  // PTX:533 setp.leu.f32 %p55, %f33, 0f322BCC77
  p55 = ((isnan(((float)(f33))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f33)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:534 mov.u32 %r284, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r284) : );
  // PTX:535 mov.u32 %r285, 0
  asm("mov.u32 %0, 0;" : "=r"(r285) : );
  // PTX:536 mov.u32 %r286, %r285
  asm("mov.u32 %0, %1;" : "=r"(r286) : "r"(r285));
  // PTX:537 mov.u32 %r287, %r285
  asm("mov.u32 %0, %1;" : "=r"(r287) : "r"(r285));
  // PTX:538 mov.u32 %r288, %r284
  asm("mov.u32 %0, %1;" : "=r"(r288) : "r"(r284));
  // PTX:539 mov.u32 %r289, %r285
  asm("mov.u32 %0, %1;" : "=r"(r289) : "r"(r285));
  // PTX:540 mov.u32 %r290, %r285
  asm("mov.u32 %0, %1;" : "=r"(r290) : "r"(r285));
  // PTX:541 mov.u32 %r291, %r285
  asm("mov.u32 %0, %1;" : "=r"(r291) : "r"(r285));
  // PTX:542 mov.u32 %r292, %r284
  asm("mov.u32 %0, %1;" : "=r"(r292) : "r"(r284));
  // PTX:543 @%p55 bra $L__BB3_67
  if (p55) { goto L_BB3_67; }
  // PTX:545 abs.f32 %f370, %f33
  asm("abs.f32 %0, %1;" : "=f"(f370) : "f"(f33));
  // PTX:546 setp.geu.f32 %p56, %f370, 0f7F800000
  p56 = ((isnan(((float)(f370))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f370)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:547 @%p56 bra $L__BB3_67
  if (p56) { goto L_BB3_67; }
  // PTX:549 rcp.rn.f32 %f371, %f33
  asm("rcp.rn.f32 %0, %1;" : "=f"(f371) : "f"(f33));
  // PTX:550 mul.f32 %f938, %f29, %f371
  asm("mul.f32 %0, %1, %2;" : "=f"(f938) : "f"(f29), "f"(f371));
  // PTX:551 mul.f32 %f939, %f30, %f371
  asm("mul.f32 %0, %1, %2;" : "=f"(f939) : "f"(f30), "f"(f371));
  // PTX:552 mul.f32 %f940, %f31, %f371
  asm("mul.f32 %0, %1, %2;" : "=f"(f940) : "f"(f31), "f"(f371));
  // PTX:553 mul.f32 %f941, %f26, %f371
  asm("mul.f32 %0, %1, %2;" : "=f"(f941) : "f"(f26), "f"(f371));
  // PTX:554 mul.f32 %f942, %f21, %f371
  asm("mul.f32 %0, %1, %2;" : "=f"(f942) : "f"(f21), "f"(f371));
  // PTX:555 mul.f32 %f943, %f23, %f371
  asm("mul.f32 %0, %1, %2;" : "=f"(f943) : "f"(f23), "f"(f371));
  // PTX:556 mul.f32 %f944, %f25, %f371
  asm("mul.f32 %0, %1, %2;" : "=f"(f944) : "f"(f25), "f"(f371));
  // PTX:557 mul.f32 %f945, %f22, %f371
  asm("mul.f32 %0, %1, %2;" : "=f"(f945) : "f"(f22), "f"(f371));
  // PTX:558 mul.f32 %f946, %f20, %f371
  asm("mul.f32 %0, %1, %2;" : "=f"(f946) : "f"(f20), "f"(f371));
  // PTX:559 mov.u32 %r268, 0
  asm("mov.u32 %0, 0;" : "=r"(r268) : );
  // PTX:561 $L__BB3_53:
L_BB3_53:;
  // PTX:562 mul.f32 %f372, %f943, %f945
  asm("mul.f32 %0, %1, %2;" : "=f"(f372) : "f"(f943), "f"(f945));
  // PTX:563 mul.f32 %f373, %f942, %f946
  asm("mul.f32 %0, %1, %2;" : "=f"(f373) : "f"(f942), "f"(f946));
  // PTX:564 sub.f32 %f52, %f373, %f372
  asm("sub.f32 %0, %1, %2;" : "=f"(f52) : "f"(f373), "f"(f372));
  // PTX:565 mul.f32 %f374, %f941, %f946
  asm("mul.f32 %0, %1, %2;" : "=f"(f374) : "f"(f941), "f"(f946));
  // PTX:566 mul.f32 %f375, %f943, %f944
  asm("mul.f32 %0, %1, %2;" : "=f"(f375) : "f"(f943), "f"(f944));
  // PTX:567 sub.f32 %f53, %f375, %f374
  asm("sub.f32 %0, %1, %2;" : "=f"(f53) : "f"(f375), "f"(f374));
  // PTX:568 mul.f32 %f376, %f942, %f944
  asm("mul.f32 %0, %1, %2;" : "=f"(f376) : "f"(f942), "f"(f944));
  // PTX:569 mul.f32 %f377, %f941, %f945
  asm("mul.f32 %0, %1, %2;" : "=f"(f377) : "f"(f941), "f"(f945));
  // PTX:570 sub.f32 %f54, %f377, %f376
  asm("sub.f32 %0, %1, %2;" : "=f"(f54) : "f"(f377), "f"(f376));
  // PTX:571 mul.f32 %f378, %f939, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f378) : "f"(f939), "f"(f53));
  // PTX:572 fma.rn.f32 %f379, %f938, %f52, %f378
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f379) : "f"(f938), "f"(f52), "f"(f378));
  // PTX:573 fma.rn.f32 %f55, %f940, %f54, %f379
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f55) : "f"(f940), "f"(f54), "f"(f379));
  // PTX:574 abs.f32 %f380, %f55
  asm("abs.f32 %0, %1;" : "=f"(f380) : "f"(f55));
  // PTX:575 setp.le.f32 %p57, %f380, 0f2EDBE6FF
  p57 = (!(isnan(((float)(f380))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f380)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:576 setp.geu.f32 %p58, %f380, 0f7F800000
  p58 = ((isnan(((float)(f380))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f380)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:577 or.pred %p59, %p57, %p58
  p59 = ((p57) || (p58));
  // PTX:578 @%p59 bra $L__BB3_56
  if (p59) { goto L_BB3_56; }
  // PTX:580 rcp.rn.f32 %f381, %f55
  asm("rcp.rn.f32 %0, %1;" : "=f"(f381) : "f"(f55));
  // PTX:581 mul.f32 %f382, %f939, %f946
  asm("mul.f32 %0, %1, %2;" : "=f"(f382) : "f"(f939), "f"(f946));
  // PTX:582 mul.f32 %f383, %f940, %f945
  asm("mul.f32 %0, %1, %2;" : "=f"(f383) : "f"(f940), "f"(f945));
  // PTX:583 sub.f32 %f384, %f383, %f382
  asm("sub.f32 %0, %1, %2;" : "=f"(f384) : "f"(f383), "f"(f382));
  // PTX:584 mul.f32 %f385, %f940, %f944
  asm("mul.f32 %0, %1, %2;" : "=f"(f385) : "f"(f940), "f"(f944));
  // PTX:585 mul.f32 %f386, %f938, %f946
  asm("mul.f32 %0, %1, %2;" : "=f"(f386) : "f"(f938), "f"(f946));
  // PTX:586 sub.f32 %f387, %f386, %f385
  asm("sub.f32 %0, %1, %2;" : "=f"(f387) : "f"(f386), "f"(f385));
  // PTX:587 mul.f32 %f388, %f938, %f945
  asm("mul.f32 %0, %1, %2;" : "=f"(f388) : "f"(f938), "f"(f945));
  // PTX:588 mul.f32 %f389, %f939, %f944
  asm("mul.f32 %0, %1, %2;" : "=f"(f389) : "f"(f939), "f"(f944));
  // PTX:589 sub.f32 %f390, %f389, %f388
  asm("sub.f32 %0, %1, %2;" : "=f"(f390) : "f"(f389), "f"(f388));
  // PTX:590 mul.f32 %f391, %f940, %f942
  asm("mul.f32 %0, %1, %2;" : "=f"(f391) : "f"(f940), "f"(f942));
  // PTX:591 mul.f32 %f392, %f939, %f943
  asm("mul.f32 %0, %1, %2;" : "=f"(f392) : "f"(f939), "f"(f943));
  // PTX:592 sub.f32 %f393, %f392, %f391
  asm("sub.f32 %0, %1, %2;" : "=f"(f393) : "f"(f392), "f"(f391));
  // PTX:593 mul.f32 %f394, %f938, %f943
  asm("mul.f32 %0, %1, %2;" : "=f"(f394) : "f"(f938), "f"(f943));
  // PTX:594 mul.f32 %f395, %f940, %f941
  asm("mul.f32 %0, %1, %2;" : "=f"(f395) : "f"(f940), "f"(f941));
  // PTX:595 sub.f32 %f396, %f395, %f394
  asm("sub.f32 %0, %1, %2;" : "=f"(f396) : "f"(f395), "f"(f394));
  // PTX:596 mul.f32 %f397, %f939, %f941
  asm("mul.f32 %0, %1, %2;" : "=f"(f397) : "f"(f939), "f"(f941));
  // PTX:597 mul.f32 %f398, %f938, %f942
  asm("mul.f32 %0, %1, %2;" : "=f"(f398) : "f"(f938), "f"(f942));
  // PTX:598 sub.f32 %f399, %f398, %f397
  asm("sub.f32 %0, %1, %2;" : "=f"(f399) : "f"(f398), "f"(f397));
  // PTX:599 fma.rn.f32 %f400, %f52, %f381, %f938
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f400) : "f"(f52), "f"(f381), "f"(f938));
  // PTX:600 fma.rn.f32 %f401, %f53, %f381, %f939
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f401) : "f"(f53), "f"(f381), "f"(f939));
  // PTX:601 fma.rn.f32 %f402, %f54, %f381, %f940
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f402) : "f"(f54), "f"(f381), "f"(f940));
  // PTX:602 fma.rn.f32 %f403, %f384, %f381, %f941
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f403) : "f"(f384), "f"(f381), "f"(f941));
  // PTX:603 fma.rn.f32 %f404, %f387, %f381, %f942
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f404) : "f"(f387), "f"(f381), "f"(f942));
  // PTX:604 fma.rn.f32 %f405, %f390, %f381, %f943
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f405) : "f"(f390), "f"(f381), "f"(f943));
  // PTX:605 fma.rn.f32 %f406, %f393, %f381, %f944
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f406) : "f"(f393), "f"(f381), "f"(f944));
  // PTX:606 fma.rn.f32 %f407, %f396, %f381, %f945
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f407) : "f"(f396), "f"(f381), "f"(f945));
  // PTX:607 fma.rn.f32 %f408, %f399, %f381, %f946
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f408) : "f"(f399), "f"(f381), "f"(f946));
  // PTX:608 mul.f32 %f938, %f400, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f938) : "f"(f400));
  // PTX:609 mul.f32 %f939, %f401, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f939) : "f"(f401));
  // PTX:610 mul.f32 %f940, %f402, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f940) : "f"(f402));
  // PTX:611 mul.f32 %f941, %f403, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f941) : "f"(f403));
  // PTX:612 mul.f32 %f942, %f404, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f942) : "f"(f404));
  // PTX:613 mul.f32 %f943, %f405, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f943) : "f"(f405));
  // PTX:614 mul.f32 %f944, %f406, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f944) : "f"(f406));
  // PTX:615 mul.f32 %f945, %f407, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f945) : "f"(f407));
  // PTX:616 mul.f32 %f946, %f408, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f946) : "f"(f408));
  // PTX:617 mul.f32 %f409, %f942, %f946
  asm("mul.f32 %0, %1, %2;" : "=f"(f409) : "f"(f942), "f"(f946));
  // PTX:618 mul.f32 %f410, %f943, %f945
  asm("mul.f32 %0, %1, %2;" : "=f"(f410) : "f"(f943), "f"(f945));
  // PTX:619 sub.f32 %f65, %f409, %f410
  asm("sub.f32 %0, %1, %2;" : "=f"(f65) : "f"(f409), "f"(f410));
  // PTX:620 mul.f32 %f411, %f943, %f944
  asm("mul.f32 %0, %1, %2;" : "=f"(f411) : "f"(f943), "f"(f944));
  // PTX:621 mul.f32 %f412, %f941, %f946
  asm("mul.f32 %0, %1, %2;" : "=f"(f412) : "f"(f941), "f"(f946));
  // PTX:622 sub.f32 %f66, %f411, %f412
  asm("sub.f32 %0, %1, %2;" : "=f"(f66) : "f"(f411), "f"(f412));
  // PTX:623 mul.f32 %f413, %f941, %f945
  asm("mul.f32 %0, %1, %2;" : "=f"(f413) : "f"(f941), "f"(f945));
  // PTX:624 mul.f32 %f414, %f942, %f944
  asm("mul.f32 %0, %1, %2;" : "=f"(f414) : "f"(f942), "f"(f944));
  // PTX:625 sub.f32 %f67, %f413, %f414
  asm("sub.f32 %0, %1, %2;" : "=f"(f67) : "f"(f413), "f"(f414));
  // PTX:626 mul.f32 %f415, %f939, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f415) : "f"(f939), "f"(f66));
  // PTX:627 fma.rn.f32 %f416, %f938, %f65, %f415
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f416) : "f"(f938), "f"(f65), "f"(f415));
  // PTX:628 fma.rn.f32 %f68, %f940, %f67, %f416
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f68) : "f"(f940), "f"(f67), "f"(f416));
  // PTX:629 abs.f32 %f417, %f68
  asm("abs.f32 %0, %1;" : "=f"(f417) : "f"(f68));
  // PTX:630 setp.le.f32 %p60, %f417, 0f2EDBE6FF
  p60 = (!(isnan(((float)(f417))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f417)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:631 setp.geu.f32 %p61, %f417, 0f7F800000
  p61 = ((isnan(((float)(f417))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f417)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:632 or.pred %p62, %p60, %p61
  p62 = ((p60) || (p61));
  // PTX:633 @%p62 bra $L__BB3_56
  if (p62) { goto L_BB3_56; }
  // PTX:635 rcp.rn.f32 %f418, %f68
  asm("rcp.rn.f32 %0, %1;" : "=f"(f418) : "f"(f68));
  // PTX:636 mul.f32 %f419, %f939, %f946
  asm("mul.f32 %0, %1, %2;" : "=f"(f419) : "f"(f939), "f"(f946));
  // PTX:637 mul.f32 %f420, %f940, %f945
  asm("mul.f32 %0, %1, %2;" : "=f"(f420) : "f"(f940), "f"(f945));
  // PTX:638 sub.f32 %f421, %f420, %f419
  asm("sub.f32 %0, %1, %2;" : "=f"(f421) : "f"(f420), "f"(f419));
  // PTX:639 mul.f32 %f422, %f940, %f944
  asm("mul.f32 %0, %1, %2;" : "=f"(f422) : "f"(f940), "f"(f944));
  // PTX:640 mul.f32 %f423, %f938, %f946
  asm("mul.f32 %0, %1, %2;" : "=f"(f423) : "f"(f938), "f"(f946));
  // PTX:641 sub.f32 %f424, %f423, %f422
  asm("sub.f32 %0, %1, %2;" : "=f"(f424) : "f"(f423), "f"(f422));
  // PTX:642 mul.f32 %f425, %f938, %f945
  asm("mul.f32 %0, %1, %2;" : "=f"(f425) : "f"(f938), "f"(f945));
  // PTX:643 mul.f32 %f426, %f939, %f944
  asm("mul.f32 %0, %1, %2;" : "=f"(f426) : "f"(f939), "f"(f944));
  // PTX:644 sub.f32 %f427, %f426, %f425
  asm("sub.f32 %0, %1, %2;" : "=f"(f427) : "f"(f426), "f"(f425));
  // PTX:645 mul.f32 %f428, %f940, %f942
  asm("mul.f32 %0, %1, %2;" : "=f"(f428) : "f"(f940), "f"(f942));
  // PTX:646 mul.f32 %f429, %f939, %f943
  asm("mul.f32 %0, %1, %2;" : "=f"(f429) : "f"(f939), "f"(f943));
  // PTX:647 sub.f32 %f430, %f429, %f428
  asm("sub.f32 %0, %1, %2;" : "=f"(f430) : "f"(f429), "f"(f428));
  // PTX:648 mul.f32 %f431, %f938, %f943
  asm("mul.f32 %0, %1, %2;" : "=f"(f431) : "f"(f938), "f"(f943));
  // PTX:649 mul.f32 %f432, %f940, %f941
  asm("mul.f32 %0, %1, %2;" : "=f"(f432) : "f"(f940), "f"(f941));
  // PTX:650 sub.f32 %f433, %f432, %f431
  asm("sub.f32 %0, %1, %2;" : "=f"(f433) : "f"(f432), "f"(f431));
  // PTX:651 mul.f32 %f434, %f939, %f941
  asm("mul.f32 %0, %1, %2;" : "=f"(f434) : "f"(f939), "f"(f941));
  // PTX:652 mul.f32 %f435, %f938, %f942
  asm("mul.f32 %0, %1, %2;" : "=f"(f435) : "f"(f938), "f"(f942));
  // PTX:653 sub.f32 %f436, %f435, %f434
  asm("sub.f32 %0, %1, %2;" : "=f"(f436) : "f"(f435), "f"(f434));
  // PTX:654 fma.rn.f32 %f437, %f65, %f418, %f938
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f437) : "f"(f65), "f"(f418), "f"(f938));
  // PTX:655 fma.rn.f32 %f438, %f66, %f418, %f939
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f438) : "f"(f66), "f"(f418), "f"(f939));
  // PTX:656 fma.rn.f32 %f439, %f67, %f418, %f940
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f439) : "f"(f67), "f"(f418), "f"(f940));
  // PTX:657 fma.rn.f32 %f440, %f421, %f418, %f941
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f440) : "f"(f421), "f"(f418), "f"(f941));
  // PTX:658 fma.rn.f32 %f441, %f424, %f418, %f942
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f441) : "f"(f424), "f"(f418), "f"(f942));
  // PTX:659 fma.rn.f32 %f442, %f427, %f418, %f943
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f442) : "f"(f427), "f"(f418), "f"(f943));
  // PTX:660 fma.rn.f32 %f443, %f430, %f418, %f944
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f443) : "f"(f430), "f"(f418), "f"(f944));
  // PTX:661 fma.rn.f32 %f444, %f433, %f418, %f945
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f444) : "f"(f433), "f"(f418), "f"(f945));
  // PTX:662 fma.rn.f32 %f445, %f436, %f418, %f946
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f445) : "f"(f436), "f"(f418), "f"(f946));
  // PTX:663 mul.f32 %f938, %f437, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f938) : "f"(f437));
  // PTX:664 mul.f32 %f939, %f438, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f939) : "f"(f438));
  // PTX:665 mul.f32 %f940, %f439, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f940) : "f"(f439));
  // PTX:666 mul.f32 %f941, %f440, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f941) : "f"(f440));
  // PTX:667 mul.f32 %f942, %f441, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f942) : "f"(f441));
  // PTX:668 mul.f32 %f943, %f442, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f943) : "f"(f442));
  // PTX:669 mul.f32 %f944, %f443, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f944) : "f"(f443));
  // PTX:670 mul.f32 %f945, %f444, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f945) : "f"(f444));
  // PTX:671 mul.f32 %f946, %f445, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f946) : "f"(f445));
  // PTX:672 add.s32 %r268, %r268, 2
  asm("add.s32 %0, %1, 2;" : "=r"(r268) : "r"(r268));
  // PTX:673 setp.lt.u32 %p63, %r268, 8
  p63 = (((unsigned)(r268)) < ((unsigned)(8)));
  // PTX:674 @%p63 bra $L__BB3_53
  if (p63) { goto L_BB3_53; }
  // PTX:676 $L__BB3_56:
L_BB3_56:;
  // PTX:677 mul.f32 %f446, %f939, %f939
  asm("mul.f32 %0, %1, %2;" : "=f"(f446) : "f"(f939), "f"(f939));
  // PTX:678 fma.rn.f32 %f447, %f938, %f938, %f446
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f447) : "f"(f938), "f"(f938), "f"(f446));
  // PTX:679 fma.rn.f32 %f448, %f940, %f940, %f447
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f448) : "f"(f940), "f"(f940), "f"(f447));
  // PTX:680 sqrt.rn.f32 %f87, %f448
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f87) : "f"(f448));
  // PTX:681 setp.leu.f32 %p64, %f87, 0f00000000
  p64 = ((isnan(((float)(f87))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f87)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:682 mov.u32 %r281, 0
  asm("mov.u32 %0, 0;" : "=r"(r281) : );
  // PTX:683 mov.u32 %r269, %r281
  asm("mov.u32 %0, %1;" : "=r"(r269) : "r"(r281));
  // PTX:684 mov.u32 %r270, %r281
  asm("mov.u32 %0, %1;" : "=r"(r270) : "r"(r281));
  // PTX:685 mov.u32 %r271, %r281
  asm("mov.u32 %0, %1;" : "=r"(r271) : "r"(r281));
  // PTX:686 @%p64 bra $L__BB3_58
  if (p64) { goto L_BB3_58; }
  // PTX:688 div.rn.f32 %f449, %f938, %f87
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f449) : "f"(f938), "f"(f87));
  // PTX:689 div.rn.f32 %f450, %f939, %f87
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f450) : "f"(f939), "f"(f87));
  // PTX:690 div.rn.f32 %f451, %f940, %f87
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f451) : "f"(f940), "f"(f87));
  // PTX:691 mov.b32 %r271, %f451
  asm("mov.b32 %0, %1;" : "=r"(r271) : "f"(f451));
  // PTX:692 mov.b32 %r270, %f450
  asm("mov.b32 %0, %1;" : "=r"(r270) : "f"(f450));
  // PTX:693 mov.b32 %r269, %f449
  asm("mov.b32 %0, %1;" : "=r"(r269) : "f"(f449));
  // PTX:695 $L__BB3_58:
L_BB3_58:;
  // PTX:696 mov.b32 %f88, %r269
  asm("mov.b32 %0, %1;" : "=f"(f88) : "r"(r269));
  // PTX:697 mov.b32 %f89, %r270
  asm("mov.b32 %0, %1;" : "=f"(f89) : "r"(r270));
  // PTX:698 mul.f32 %f452, %f942, %f89
  asm("mul.f32 %0, %1, %2;" : "=f"(f452) : "f"(f942), "f"(f89));
  // PTX:699 mov.b32 %f90, %r271
  asm("mov.b32 %0, %1;" : "=f"(f90) : "r"(r271));
  // PTX:700 fma.rn.f32 %f453, %f941, %f88, %f452
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f453) : "f"(f941), "f"(f88), "f"(f452));
  // PTX:701 fma.rn.f32 %f454, %f943, %f90, %f453
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f454) : "f"(f943), "f"(f90), "f"(f453));
  // PTX:702 mul.f32 %f455, %f454, %f88
  asm("mul.f32 %0, %1, %2;" : "=f"(f455) : "f"(f454), "f"(f88));
  // PTX:703 mul.f32 %f456, %f454, %f89
  asm("mul.f32 %0, %1, %2;" : "=f"(f456) : "f"(f454), "f"(f89));
  // PTX:704 mul.f32 %f457, %f454, %f90
  asm("mul.f32 %0, %1, %2;" : "=f"(f457) : "f"(f454), "f"(f90));
  // PTX:705 sub.f32 %f91, %f941, %f455
  asm("sub.f32 %0, %1, %2;" : "=f"(f91) : "f"(f941), "f"(f455));
  // PTX:706 sub.f32 %f92, %f942, %f456
  asm("sub.f32 %0, %1, %2;" : "=f"(f92) : "f"(f942), "f"(f456));
  // PTX:707 sub.f32 %f93, %f943, %f457
  asm("sub.f32 %0, %1, %2;" : "=f"(f93) : "f"(f943), "f"(f457));
  // PTX:708 mul.f32 %f458, %f92, %f92
  asm("mul.f32 %0, %1, %2;" : "=f"(f458) : "f"(f92), "f"(f92));
  // PTX:709 fma.rn.f32 %f459, %f91, %f91, %f458
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f459) : "f"(f91), "f"(f91), "f"(f458));
  // PTX:710 fma.rn.f32 %f460, %f93, %f93, %f459
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f460) : "f"(f93), "f"(f93), "f"(f459));
  // PTX:711 sqrt.rn.f32 %f94, %f460
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f94) : "f"(f460));
  // PTX:712 setp.leu.f32 %p65, %f94, 0f00000000
  p65 = ((isnan(((float)(f94))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f94)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:713 mov.u32 %r282, %r281
  asm("mov.u32 %0, %1;" : "=r"(r282) : "r"(r281));
  // PTX:714 mov.u32 %r283, %r281
  asm("mov.u32 %0, %1;" : "=r"(r283) : "r"(r281));
  // PTX:715 @%p65 bra $L__BB3_60
  if (p65) { goto L_BB3_60; }
  // PTX:717 div.rn.f32 %f461, %f91, %f94
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f461) : "f"(f91), "f"(f94));
  // PTX:718 div.rn.f32 %f462, %f92, %f94
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f462) : "f"(f92), "f"(f94));
  // PTX:719 div.rn.f32 %f463, %f93, %f94
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f463) : "f"(f93), "f"(f94));
  // PTX:720 mov.b32 %r283, %f463
  asm("mov.b32 %0, %1;" : "=r"(r283) : "f"(f463));
  // PTX:721 mov.b32 %r282, %f462
  asm("mov.b32 %0, %1;" : "=r"(r282) : "f"(f462));
  // PTX:722 mov.b32 %r281, %f461
  asm("mov.b32 %0, %1;" : "=r"(r281) : "f"(f461));
  // PTX:724 $L__BB3_60:
L_BB3_60:;
  // PTX:725 mov.u32 %r284, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r284) : );
  // PTX:726 mul.f32 %f464, %f89, %f89
  asm("mul.f32 %0, %1, %2;" : "=f"(f464) : "f"(f89), "f"(f89));
  // PTX:727 fma.rn.f32 %f465, %f88, %f88, %f464
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f465) : "f"(f88), "f"(f88), "f"(f464));
  // PTX:728 fma.rn.f32 %f466, %f90, %f90, %f465
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f466) : "f"(f90), "f"(f90), "f"(f465));
  // PTX:729 sqrt.rn.f32 %f467, %f466
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f467) : "f"(f466));
  // PTX:730 setp.le.f32 %p66, %f467, 0f322BCC77
  p66 = (!(isnan(((float)(f467))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f467)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:731 mov.u32 %r285, 0
  asm("mov.u32 %0, 0;" : "=r"(r285) : );
  // PTX:732 mov.u32 %r286, %r285
  asm("mov.u32 %0, %1;" : "=r"(r286) : "r"(r285));
  // PTX:733 mov.u32 %r287, %r285
  asm("mov.u32 %0, %1;" : "=r"(r287) : "r"(r285));
  // PTX:734 mov.u32 %r288, %r284
  asm("mov.u32 %0, %1;" : "=r"(r288) : "r"(r284));
  // PTX:735 mov.u32 %r289, %r285
  asm("mov.u32 %0, %1;" : "=r"(r289) : "r"(r285));
  // PTX:736 mov.u32 %r290, %r285
  asm("mov.u32 %0, %1;" : "=r"(r290) : "r"(r285));
  // PTX:737 mov.u32 %r291, %r285
  asm("mov.u32 %0, %1;" : "=r"(r291) : "r"(r285));
  // PTX:738 mov.u32 %r292, %r284
  asm("mov.u32 %0, %1;" : "=r"(r292) : "r"(r284));
  // PTX:739 @%p66 bra $L__BB3_67
  if (p66) { goto L_BB3_67; }
  // PTX:741 mov.u32 %r284, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r284) : );
  // PTX:742 mov.b32 %f95, %r281
  asm("mov.b32 %0, %1;" : "=f"(f95) : "r"(r281));
  // PTX:743 mov.b32 %f96, %r282
  asm("mov.b32 %0, %1;" : "=f"(f96) : "r"(r282));
  // PTX:744 mul.f32 %f468, %f96, %f96
  asm("mul.f32 %0, %1, %2;" : "=f"(f468) : "f"(f96), "f"(f96));
  // PTX:745 mov.b32 %f97, %r283
  asm("mov.b32 %0, %1;" : "=f"(f97) : "r"(r283));
  // PTX:746 fma.rn.f32 %f469, %f95, %f95, %f468
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f469) : "f"(f95), "f"(f95), "f"(f468));
  // PTX:747 fma.rn.f32 %f470, %f97, %f97, %f469
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f470) : "f"(f97), "f"(f97), "f"(f469));
  // PTX:748 sqrt.rn.f32 %f471, %f470
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f471) : "f"(f470));
  // PTX:749 setp.le.f32 %p67, %f471, 0f322BCC77
  p67 = (!(isnan(((float)(f471))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f471)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:750 @%p67 bra $L__BB3_67
  if (p67) { goto L_BB3_67; }
  // PTX:752 mul.f32 %f472, %f89, %f97
  asm("mul.f32 %0, %1, %2;" : "=f"(f472) : "f"(f89), "f"(f97));
  // PTX:753 mul.f32 %f473, %f90, %f96
  asm("mul.f32 %0, %1, %2;" : "=f"(f473) : "f"(f90), "f"(f96));
  // PTX:754 sub.f32 %f98, %f472, %f473
  asm("sub.f32 %0, %1, %2;" : "=f"(f98) : "f"(f472), "f"(f473));
  // PTX:755 mul.f32 %f474, %f88, %f97
  asm("mul.f32 %0, %1, %2;" : "=f"(f474) : "f"(f88), "f"(f97));
  // PTX:756 mul.f32 %f475, %f90, %f95
  asm("mul.f32 %0, %1, %2;" : "=f"(f475) : "f"(f90), "f"(f95));
  // PTX:757 sub.f32 %f99, %f475, %f474
  asm("sub.f32 %0, %1, %2;" : "=f"(f99) : "f"(f475), "f"(f474));
  // PTX:758 mul.f32 %f476, %f89, %f95
  asm("mul.f32 %0, %1, %2;" : "=f"(f476) : "f"(f89), "f"(f95));
  // PTX:759 mul.f32 %f477, %f88, %f96
  asm("mul.f32 %0, %1, %2;" : "=f"(f477) : "f"(f88), "f"(f96));
  // PTX:760 sub.f32 %f100, %f477, %f476
  asm("sub.f32 %0, %1, %2;" : "=f"(f100) : "f"(f477), "f"(f476));
  // PTX:761 mul.f32 %f478, %f99, %f99
  asm("mul.f32 %0, %1, %2;" : "=f"(f478) : "f"(f99), "f"(f99));
  // PTX:762 fma.rn.f32 %f479, %f98, %f98, %f478
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f479) : "f"(f98), "f"(f98), "f"(f478));
  // PTX:763 fma.rn.f32 %f480, %f100, %f100, %f479
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f480) : "f"(f100), "f"(f100), "f"(f479));
  // PTX:764 sqrt.rn.f32 %f101, %f480
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f101) : "f"(f480));
  // PTX:765 setp.leu.f32 %p68, %f101, 0f00000000
  p68 = ((isnan(((float)(f101))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f101)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:766 mov.u32 %r290, 0
  asm("mov.u32 %0, 0;" : "=r"(r290) : );
  // PTX:767 mov.u32 %r291, %r290
  asm("mov.u32 %0, %1;" : "=r"(r291) : "r"(r290));
  // PTX:768 mov.u32 %r292, %r290
  asm("mov.u32 %0, %1;" : "=r"(r292) : "r"(r290));
  // PTX:769 @%p68 bra $L__BB3_64
  if (p68) { goto L_BB3_64; }
  // PTX:771 div.rn.f32 %f481, %f98, %f101
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f481) : "f"(f98), "f"(f101));
  // PTX:772 div.rn.f32 %f482, %f99, %f101
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f482) : "f"(f99), "f"(f101));
  // PTX:773 div.rn.f32 %f483, %f100, %f101
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f483) : "f"(f100), "f"(f101));
  // PTX:774 mov.b32 %r292, %f483
  asm("mov.b32 %0, %1;" : "=r"(r292) : "f"(f483));
  // PTX:775 mov.b32 %r291, %f482
  asm("mov.b32 %0, %1;" : "=r"(r291) : "f"(f482));
  // PTX:776 mov.b32 %r290, %f481
  asm("mov.b32 %0, %1;" : "=r"(r290) : "f"(f481));
  // PTX:778 $L__BB3_64:
L_BB3_64:;
  // PTX:779 mov.b32 %f102, %r290
  asm("mov.b32 %0, %1;" : "=f"(f102) : "r"(r290));
  // PTX:780 mov.b32 %f103, %r291
  asm("mov.b32 %0, %1;" : "=f"(f103) : "r"(r291));
  // PTX:781 mul.f32 %f484, %f945, %f103
  asm("mul.f32 %0, %1, %2;" : "=f"(f484) : "f"(f945), "f"(f103));
  // PTX:782 mov.b32 %f104, %r292
  asm("mov.b32 %0, %1;" : "=f"(f104) : "r"(r292));
  // PTX:783 fma.rn.f32 %f485, %f944, %f102, %f484
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f485) : "f"(f944), "f"(f102), "f"(f484));
  // PTX:784 fma.rn.f32 %f486, %f946, %f104, %f485
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f486) : "f"(f946), "f"(f104), "f"(f485));
  // PTX:785 setp.geu.f32 %p69, %f486, 0f00000000
  p69 = ((isnan(((float)(f486))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f486)) >= ((float)(as_f32(0x00000000u)))));
  // PTX:786 @%p69 bra $L__BB3_66
  if (p69) { goto L_BB3_66; }
  // PTX:788 neg.f32 %f487, %f95
  asm("neg.f32 %0, %1;" : "=f"(f487) : "f"(f95));
  // PTX:789 mov.b32 %r281, %f487
  asm("mov.b32 %0, %1;" : "=r"(r281) : "f"(f487));
  // PTX:790 neg.f32 %f488, %f96
  asm("neg.f32 %0, %1;" : "=f"(f488) : "f"(f96));
  // PTX:791 mov.b32 %r282, %f488
  asm("mov.b32 %0, %1;" : "=r"(r282) : "f"(f488));
  // PTX:792 neg.f32 %f489, %f97
  asm("neg.f32 %0, %1;" : "=f"(f489) : "f"(f97));
  // PTX:793 mov.b32 %r283, %f489
  asm("mov.b32 %0, %1;" : "=r"(r283) : "f"(f489));
  // PTX:794 neg.f32 %f490, %f102
  asm("neg.f32 %0, %1;" : "=f"(f490) : "f"(f102));
  // PTX:795 mov.b32 %r290, %f490
  asm("mov.b32 %0, %1;" : "=r"(r290) : "f"(f490));
  // PTX:796 neg.f32 %f491, %f103
  asm("neg.f32 %0, %1;" : "=f"(f491) : "f"(f103));
  // PTX:797 mov.b32 %r291, %f491
  asm("mov.b32 %0, %1;" : "=r"(r291) : "f"(f491));
  // PTX:798 neg.f32 %f492, %f104
  asm("neg.f32 %0, %1;" : "=f"(f492) : "f"(f104));
  // PTX:799 mov.b32 %r292, %f492
  asm("mov.b32 %0, %1;" : "=r"(r292) : "f"(f492));
  // PTX:801 $L__BB3_66:
L_BB3_66:;
  // PTX:802 mov.u32 %r284, %r269
  asm("mov.u32 %0, %1;" : "=r"(r284) : "r"(r269));
  // PTX:803 mov.u32 %r285, %r270
  asm("mov.u32 %0, %1;" : "=r"(r285) : "r"(r270));
  // PTX:804 mov.u32 %r286, %r271
  asm("mov.u32 %0, %1;" : "=r"(r286) : "r"(r271));
  // PTX:805 mov.u32 %r287, %r281
  asm("mov.u32 %0, %1;" : "=r"(r287) : "r"(r281));
  // PTX:806 mov.u32 %r288, %r282
  asm("mov.u32 %0, %1;" : "=r"(r288) : "r"(r282));
  // PTX:807 mov.u32 %r289, %r283
  asm("mov.u32 %0, %1;" : "=r"(r289) : "r"(r283));
  // PTX:809 $L__BB3_67:
L_BB3_67:;
  // PTX:810 mov.b32 %f493, %r284
  asm("mov.b32 %0, %1;" : "=f"(f493) : "r"(r284));
  // PTX:811 mov.b32 %f494, %r287
  asm("mov.b32 %0, %1;" : "=f"(f494) : "r"(r287));
  // PTX:812 mov.b32 %f495, %r290
  asm("mov.b32 %0, %1;" : "=f"(f495) : "r"(r290));
  // PTX:813 mov.b32 %f496, %r285
  asm("mov.b32 %0, %1;" : "=f"(f496) : "r"(r285));
  // PTX:814 mov.b32 %f497, %r288
  asm("mov.b32 %0, %1;" : "=f"(f497) : "r"(r288));
  // PTX:815 mov.b32 %f498, %r291
  asm("mov.b32 %0, %1;" : "=f"(f498) : "r"(r291));
  // PTX:816 mov.b32 %f499, %r286
  asm("mov.b32 %0, %1;" : "=f"(f499) : "r"(r286));
  // PTX:817 mov.b32 %f500, %r289
  asm("mov.b32 %0, %1;" : "=f"(f500) : "r"(r289));
  // PTX:818 mov.b32 %f501, %r292
  asm("mov.b32 %0, %1;" : "=f"(f501) : "r"(r292));
  // PTX:819 mul.f32 %f502, %f17, %f496
  asm("mul.f32 %0, %1, %2;" : "=f"(f502) : "f"(f17), "f"(f496));
  // PTX:820 mul.f32 %f503, %f17, %f497
  asm("mul.f32 %0, %1, %2;" : "=f"(f503) : "f"(f17), "f"(f497));
  // PTX:821 mul.f32 %f504, %f17, %f498
  asm("mul.f32 %0, %1, %2;" : "=f"(f504) : "f"(f17), "f"(f498));
  // PTX:822 fma.rn.f32 %f505, %f16, %f493, %f502
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f505) : "f"(f16), "f"(f493), "f"(f502));
  // PTX:823 fma.rn.f32 %f506, %f16, %f494, %f503
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f506) : "f"(f16), "f"(f494), "f"(f503));
  // PTX:824 fma.rn.f32 %f507, %f16, %f495, %f504
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f507) : "f"(f16), "f"(f495), "f"(f504));
  // PTX:825 fma.rn.f32 %f947, %f19, %f499, %f505
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f947) : "f"(f19), "f"(f499), "f"(f505));
  // PTX:826 fma.rn.f32 %f948, %f19, %f500, %f506
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f948) : "f"(f19), "f"(f500), "f"(f506));
  // PTX:827 fma.rn.f32 %f949, %f19, %f501, %f507
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f949) : "f"(f19), "f"(f501), "f"(f507));
  // PTX:828 bra.uni $L__BB3_68
  goto L_BB3_68;
  // PTX:830 $L__BB3_44:
L_BB3_44:;
  // PTX:831 mov.b32 %f952, %r262
  asm("mov.b32 %0, %1;" : "=f"(f952) : "r"(r262));
  // PTX:832 mov.b32 %f951, %r263
  asm("mov.b32 %0, %1;" : "=f"(f951) : "r"(r263));
  // PTX:833 mov.b32 %f950, %r264
  asm("mov.b32 %0, %1;" : "=f"(f950) : "r"(r264));
  // PTX:834 mov.u32 %r296, %r18
  asm("mov.u32 %0, %1;" : "=r"(r296) : "r"(r18));
  // PTX:835 mov.u32 %r297, %r19
  asm("mov.u32 %0, %1;" : "=r"(r297) : "r"(r19));
  // PTX:836 mov.u32 %r298, %r20
  asm("mov.u32 %0, %1;" : "=r"(r298) : "r"(r20));
  // PTX:837 bra.uni $L__BB3_70
  goto L_BB3_70;
  // PTX:839 $L__BB3_69:
L_BB3_69:;
  // PTX:840 mov.b32 %f950, %r45
  asm("mov.b32 %0, %1;" : "=f"(f950) : "r"(r45));
  // PTX:841 mov.b32 %f520, %r18
  asm("mov.b32 %0, %1;" : "=f"(f520) : "r"(r18));
  // PTX:842 fma.rn.f32 %f521, %f13, %f952, %f520
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f521) : "f"(f13), "f"(f952), "f"(f520));
  // PTX:843 mov.b32 %f522, %r19
  asm("mov.b32 %0, %1;" : "=f"(f522) : "r"(r19));
  // PTX:844 fma.rn.f32 %f523, %f13, %f951, %f522
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f523) : "f"(f13), "f"(f951), "f"(f522));
  // PTX:845 mov.b32 %f524, %r20
  asm("mov.b32 %0, %1;" : "=f"(f524) : "r"(r20));
  // PTX:846 fma.rn.f32 %f525, %f13, %f950, %f524
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f525) : "f"(f13), "f"(f950), "f"(f524));
  // PTX:847 mov.b32 %r298, %f525
  asm("mov.b32 %0, %1;" : "=r"(r298) : "f"(f525));
  // PTX:848 mov.b32 %r297, %f523
  asm("mov.b32 %0, %1;" : "=r"(r297) : "f"(f523));
  // PTX:849 mov.b32 %r296, %f521
  asm("mov.b32 %0, %1;" : "=r"(r296) : "f"(f521));
  // PTX:850 bra.uni $L__BB3_70
  goto L_BB3_70;
  // PTX:852 $L__BB3_49:
L_BB3_49:;
  // PTX:853 rcp.rn.f32 %f321, %f32
  asm("rcp.rn.f32 %0, %1;" : "=f"(f321) : "f"(f32));
  // PTX:854 mul.f32 %f322, %f30, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f322) : "f"(f30), "f"(f20));
  // PTX:855 mul.f32 %f323, %f31, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f323) : "f"(f31), "f"(f22));
  // PTX:856 sub.f32 %f324, %f323, %f322
  asm("sub.f32 %0, %1, %2;" : "=f"(f324) : "f"(f323), "f"(f322));
  // PTX:857 mul.f32 %f325, %f31, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f325) : "f"(f31), "f"(f25));
  // PTX:858 mul.f32 %f326, %f29, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f326) : "f"(f29), "f"(f20));
  // PTX:859 sub.f32 %f327, %f326, %f325
  asm("sub.f32 %0, %1, %2;" : "=f"(f327) : "f"(f326), "f"(f325));
  // PTX:860 mul.f32 %f328, %f29, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f328) : "f"(f29), "f"(f22));
  // PTX:861 mul.f32 %f329, %f30, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f329) : "f"(f30), "f"(f25));
  // PTX:862 sub.f32 %f330, %f329, %f328
  asm("sub.f32 %0, %1, %2;" : "=f"(f330) : "f"(f329), "f"(f328));
  // PTX:863 mul.f32 %f331, %f31, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f331) : "f"(f31), "f"(f21));
  // PTX:864 mul.f32 %f332, %f30, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f332) : "f"(f30), "f"(f23));
  // PTX:865 sub.f32 %f333, %f332, %f331
  asm("sub.f32 %0, %1, %2;" : "=f"(f333) : "f"(f332), "f"(f331));
  // PTX:866 mul.f32 %f334, %f29, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f334) : "f"(f29), "f"(f23));
  // PTX:867 mul.f32 %f335, %f31, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f335) : "f"(f31), "f"(f26));
  // PTX:868 sub.f32 %f336, %f335, %f334
  asm("sub.f32 %0, %1, %2;" : "=f"(f336) : "f"(f335), "f"(f334));
  // PTX:869 mul.f32 %f337, %f30, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f337) : "f"(f30), "f"(f26));
  // PTX:870 mul.f32 %f338, %f29, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f338) : "f"(f29), "f"(f21));
  // PTX:871 sub.f32 %f339, %f338, %f337
  asm("sub.f32 %0, %1, %2;" : "=f"(f339) : "f"(f338), "f"(f337));
  // PTX:872 mul.f32 %f340, %f24, %f321
  asm("mul.f32 %0, %1, %2;" : "=f"(f340) : "f"(f24), "f"(f321));
  // PTX:873 mul.f32 %f341, %f27, %f321
  asm("mul.f32 %0, %1, %2;" : "=f"(f341) : "f"(f27), "f"(f321));
  // PTX:874 mul.f32 %f342, %f28, %f321
  asm("mul.f32 %0, %1, %2;" : "=f"(f342) : "f"(f28), "f"(f321));
  // PTX:875 mul.f32 %f343, %f324, %f321
  asm("mul.f32 %0, %1, %2;" : "=f"(f343) : "f"(f324), "f"(f321));
  // PTX:876 mul.f32 %f344, %f327, %f321
  asm("mul.f32 %0, %1, %2;" : "=f"(f344) : "f"(f327), "f"(f321));
  // PTX:877 mul.f32 %f345, %f330, %f321
  asm("mul.f32 %0, %1, %2;" : "=f"(f345) : "f"(f330), "f"(f321));
  // PTX:878 mul.f32 %f346, %f333, %f321
  asm("mul.f32 %0, %1, %2;" : "=f"(f346) : "f"(f333), "f"(f321));
  // PTX:879 mul.f32 %f347, %f336, %f321
  asm("mul.f32 %0, %1, %2;" : "=f"(f347) : "f"(f336), "f"(f321));
  // PTX:880 mul.f32 %f348, %f339, %f321
  asm("mul.f32 %0, %1, %2;" : "=f"(f348) : "f"(f339), "f"(f321));
  // PTX:881 mul.f32 %f349, %f17, %f341
  asm("mul.f32 %0, %1, %2;" : "=f"(f349) : "f"(f17), "f"(f341));
  // PTX:882 mul.f32 %f350, %f17, %f344
  asm("mul.f32 %0, %1, %2;" : "=f"(f350) : "f"(f17), "f"(f344));
  // PTX:883 mul.f32 %f351, %f17, %f347
  asm("mul.f32 %0, %1, %2;" : "=f"(f351) : "f"(f17), "f"(f347));
  // PTX:884 fma.rn.f32 %f352, %f16, %f340, %f349
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f352) : "f"(f16), "f"(f340), "f"(f349));
  // PTX:885 fma.rn.f32 %f353, %f16, %f343, %f350
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f353) : "f"(f16), "f"(f343), "f"(f350));
  // PTX:886 fma.rn.f32 %f354, %f16, %f346, %f351
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f354) : "f"(f16), "f"(f346), "f"(f351));
  // PTX:887 fma.rn.f32 %f947, %f19, %f342, %f352
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f947) : "f"(f19), "f"(f342), "f"(f352));
  // PTX:888 fma.rn.f32 %f948, %f19, %f345, %f353
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f948) : "f"(f19), "f"(f345), "f"(f353));
  // PTX:889 fma.rn.f32 %f949, %f19, %f348, %f354
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f949) : "f"(f19), "f"(f348), "f"(f354));
  // PTX:891 $L__BB3_68:
L_BB3_68:;
  // PTX:892 mov.b32 %f512, %r18
  asm("mov.b32 %0, %1;" : "=f"(f512) : "r"(r18));
  // PTX:893 add.f32 %f513, %f512, %f947
  asm("add.f32 %0, %1, %2;" : "=f"(f513) : "f"(f512), "f"(f947));
  // PTX:894 mov.b32 %f515, %r19
  asm("mov.b32 %0, %1;" : "=f"(f515) : "r"(r19));
  // PTX:895 add.f32 %f516, %f515, %f948
  asm("add.f32 %0, %1, %2;" : "=f"(f516) : "f"(f515), "f"(f948));
  // PTX:896 mov.b32 %f518, %r20
  asm("mov.b32 %0, %1;" : "=f"(f518) : "r"(r20));
  // PTX:897 add.f32 %f519, %f518, %f949
  asm("add.f32 %0, %1, %2;" : "=f"(f519) : "f"(f518), "f"(f949));
  // PTX:898 mov.b32 %r296, %f513
  asm("mov.b32 %0, %1;" : "=r"(r296) : "f"(f513));
  // PTX:899 mov.b32 %r297, %f516
  asm("mov.b32 %0, %1;" : "=r"(r297) : "f"(f516));
  // PTX:900 mov.b32 %r298, %f519
  asm("mov.b32 %0, %1;" : "=r"(r298) : "f"(f519));
  // PTX:902 $L__BB3_70:
L_BB3_70:;
  // PTX:903 mul.f32 %f110, %f951, %f951
  asm("mul.f32 %0, %1, %2;" : "=f"(f110) : "f"(f951), "f"(f951));
  // PTX:904 mul.f32 %f111, %f952, %f952
  asm("mul.f32 %0, %1, %2;" : "=f"(f111) : "f"(f952), "f"(f952));
  // PTX:905 add.f32 %f526, %f110, %f111
  asm("add.f32 %0, %1, %2;" : "=f"(f526) : "f"(f110), "f"(f111));
  // PTX:906 mul.f32 %f112, %f950, %f950
  asm("mul.f32 %0, %1, %2;" : "=f"(f112) : "f"(f950), "f"(f950));
  // PTX:907 add.f32 %f527, %f112, %f526
  asm("add.f32 %0, %1, %2;" : "=f"(f527) : "f"(f112), "f"(f526));
  // PTX:908 setp.leu.f32 %p70, %f527, 0f00000000
  p70 = ((isnan(((float)(f527))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f527)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:909 @%p70 bra $L__BB3_145
  if (p70) { goto L_BB3_145; }
  // PTX:911 setp.ne.s32 %p71, %r17, 3
  p71 = (((int)(r17)) != ((int)(3)));
  // PTX:912 @%p71 bra $L__BB3_73
  if (p71) { goto L_BB3_73; }
  // PTX:914 ld.global.f32 %f528, [%rd46]
  f528 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (0)))));
  // PTX:915 mov.b32 %f529, %r301
  asm("mov.b32 %0, %1;" : "=f"(f529) : "r"(r301));
  // PTX:916 fma.rn.f32 %f530, %f528, %f952, %f529
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f530) : "f"(f528), "f"(f952), "f"(f529));
  // PTX:917 mov.b32 %f531, %r300
  asm("mov.b32 %0, %1;" : "=f"(f531) : "r"(r300));
  // PTX:918 fma.rn.f32 %f532, %f528, %f951, %f531
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f532) : "f"(f528), "f"(f951), "f"(f531));
  // PTX:919 mov.b32 %f533, %r299
  asm("mov.b32 %0, %1;" : "=f"(f533) : "r"(r299));
  // PTX:920 fma.rn.f32 %f534, %f528, %f950, %f533
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f534) : "f"(f528), "f"(f950), "f"(f533));
  // PTX:921 mov.b32 %r301, %f530
  asm("mov.b32 %0, %1;" : "=r"(r301) : "f"(f530));
  // PTX:922 mov.b32 %r300, %f532
  asm("mov.b32 %0, %1;" : "=r"(r300) : "f"(f532));
  // PTX:923 mov.b32 %r299, %f534
  asm("mov.b32 %0, %1;" : "=r"(r299) : "f"(f534));
  // PTX:925 $L__BB3_73:
L_BB3_73:;
  // PTX:926 cvt.s64.s32 %rd357, %rd365
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd357) : "l"(rd365));
  // PTX:927 shl.b64 %rd356, %rd357, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd356) : "l"(rd357));
  // PTX:928 ld.param.u64 %rd289, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_7]
  rd289 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:929 ld.param.u64 %rd288, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_16]
  rd288 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param16 + (0))));
  // PTX:930 mov.b32 %f535, %r301
  asm("mov.b32 %0, %1;" : "=f"(f535) : "r"(r301));
  // PTX:931 ld.global.f32 %f113, [%rd45]
  f113 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))));
  // PTX:932 sub.f32 %f536, %f113, %f535
  asm("sub.f32 %0, %1, %2;" : "=f"(f536) : "f"(f113), "f"(f535));
  // PTX:933 mov.b32 %f537, %r300
  asm("mov.b32 %0, %1;" : "=f"(f537) : "r"(r300));
  // PTX:934 ld.global.f32 %f114, [%rd45+4]
  f114 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (4)))));
  // PTX:935 sub.f32 %f538, %f114, %f537
  asm("sub.f32 %0, %1, %2;" : "=f"(f538) : "f"(f114), "f"(f537));
  // PTX:936 mov.b32 %f539, %r299
  asm("mov.b32 %0, %1;" : "=f"(f539) : "r"(r299));
  // PTX:937 ld.global.f32 %f115, [%rd45+8]
  f115 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (8)))));
  // PTX:938 sub.f32 %f540, %f115, %f539
  asm("sub.f32 %0, %1, %2;" : "=f"(f540) : "f"(f115), "f"(f539));
  // PTX:939 mul.f32 %f541, %f538, %f951
  asm("mul.f32 %0, %1, %2;" : "=f"(f541) : "f"(f538), "f"(f951));
  // PTX:940 fma.rn.f32 %f542, %f536, %f952, %f541
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f542) : "f"(f536), "f"(f952), "f"(f541));
  // PTX:941 fma.rn.f32 %f543, %f540, %f950, %f542
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f543) : "f"(f540), "f"(f950), "f"(f542));
  // PTX:942 cvta.to.global.u64 %rd183, %rd288
  rd183 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd288));
  // PTX:943 add.s64 %rd185, %rd183, %rd356
  asm("add.s64 %0, %1, %2;" : "=l"(rd185) : "l"(rd183), "l"(rd356));
  // PTX:944 ld.global.f32 %f544, [%rd185]
  f544 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (0)))));
  // PTX:945 cvta.to.global.u64 %rd186, %rd289
  rd186 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd289));
  // PTX:946 add.s64 %rd188, %rd186, %rd137
  asm("add.s64 %0, %1, %2;" : "=l"(rd188) : "l"(rd186), "l"(rd137));
  // PTX:947 ld.global.f32 %f545, [%rd188]
  f545 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd188) + (0)))));
  // PTX:948 add.f32 %f546, %f545, %f544
  asm("add.f32 %0, %1, %2;" : "=f"(f546) : "f"(f545), "f"(f544));
  // PTX:949 sub.f32 %f116, %f546, %f543
  asm("sub.f32 %0, %1, %2;" : "=f"(f116) : "f"(f546), "f"(f543));
  // PTX:950 setp.le.f32 %p72, %f116, 0f00000000
  p72 = (!(isnan(((float)(f116))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f116)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:951 @%p72 bra $L__BB3_145
  if (p72) { goto L_BB3_145; }
  // PTX:953 ld.param.u64 %rd290, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_34]
  rd290 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param34 + (0))));
  // PTX:954 setp.eq.s64 %p73, %rd290, 0
  p73 = (((long long)(rd290)) == ((long long)(0)));
  // PTX:955 @%p73 bra $L__BB3_76
  if (p73) { goto L_BB3_76; }
  // PTX:957 add.s64 %rd190, %rd5, %rd174
  asm("add.s64 %0, %1, %2;" : "=l"(rd190) : "l"(rd5), "l"(rd174));
  // PTX:958 ld.global.f32 %f547, [%rd190]
  f547 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd190) + (0)))));
  // PTX:959 sub.f32 %f548, %f113, %f547
  asm("sub.f32 %0, %1, %2;" : "=f"(f548) : "f"(f113), "f"(f547));
  // PTX:960 ld.global.f32 %f549, [%rd190+4]
  f549 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd190) + (4)))));
  // PTX:961 sub.f32 %f550, %f114, %f549
  asm("sub.f32 %0, %1, %2;" : "=f"(f550) : "f"(f114), "f"(f549));
  // PTX:962 ld.global.f32 %f551, [%rd190+8]
  f551 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd190) + (8)))));
  // PTX:963 sub.f32 %f552, %f115, %f551
  asm("sub.f32 %0, %1, %2;" : "=f"(f552) : "f"(f115), "f"(f551));
  // PTX:964 mul.f32 %f955, %f548, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f955) : "f"(f548), "f"(f257));
  // PTX:965 mul.f32 %f954, %f550, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f954) : "f"(f550), "f"(f257));
  // PTX:966 mul.f32 %f953, %f552, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f953) : "f"(f552), "f"(f257));
  // PTX:967 bra.uni $L__BB3_77
  goto L_BB3_77;
  // PTX:969 $L__BB3_76:
L_BB3_76:;
  // PTX:970 add.s64 %rd192, %rd4, %rd174
  asm("add.s64 %0, %1, %2;" : "=l"(rd192) : "l"(rd4), "l"(rd174));
  // PTX:971 ld.global.f32 %f955, [%rd192]
  f955 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd192) + (0)))));
  // PTX:972 ld.global.f32 %f954, [%rd192+4]
  f954 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd192) + (4)))));
  // PTX:973 ld.global.f32 %f953, [%rd192+8]
  f953 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd192) + (8)))));
  // PTX:975 $L__BB3_77:
L_BB3_77:;
  // PTX:976 ld.param.u64 %rd291, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_5]
  rd291 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:977 cvta.to.global.u64 %rd193, %rd291
  rd193 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd291));
  // PTX:978 add.s64 %rd195, %rd193, %rd172
  asm("add.s64 %0, %1, %2;" : "=l"(rd195) : "l"(rd193), "l"(rd172));
  // PTX:979 ld.global.u32 %r305, [%rd195]
  r305 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd195) + (0)))));
  // PTX:980 ld.global.u32 %r306, [%rd195+4]
  r306 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd195) + (4)))));
  // PTX:981 ld.global.u32 %r307, [%rd195+8]
  r307 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd195) + (8)))));
  // PTX:982 @%p38 bra $L__BB3_79
  if (p38) { goto L_BB3_79; }
  // PTX:984 mul.wide.s32 %rd196, %r256, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd196) : "r"(r256));
  // PTX:985 add.s64 %rd197, %rd6, %rd196
  asm("add.s64 %0, %1, %2;" : "=l"(rd197) : "l"(rd6), "l"(rd196));
  // PTX:986 ld.global.f32 %f553, [%rd197]
  f553 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd197) + (0)))));
  // PTX:987 mov.b32 %f554, %r305
  asm("mov.b32 %0, %1;" : "=f"(f554) : "r"(r305));
  // PTX:988 ld.global.f32 %f555, [%rd197+4]
  f555 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd197) + (4)))));
  // PTX:989 ld.global.f32 %f556, [%rd197+8]
  f556 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd197) + (8)))));
  // PTX:990 mul.wide.s32 %rd198, %r257, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd198) : "r"(r257));
  // PTX:991 add.s64 %rd199, %rd6, %rd198
  asm("add.s64 %0, %1, %2;" : "=l"(rd199) : "l"(rd6), "l"(rd198));
  // PTX:992 ld.global.f32 %f557, [%rd199]
  f557 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd199) + (0)))));
  // PTX:993 mov.b32 %f558, %r306
  asm("mov.b32 %0, %1;" : "=f"(f558) : "r"(r306));
  // PTX:994 mul.f32 %f559, %f557, %f558
  asm("mul.f32 %0, %1, %2;" : "=f"(f559) : "f"(f557), "f"(f558));
  // PTX:995 ld.global.f32 %f560, [%rd199+4]
  f560 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd199) + (4)))));
  // PTX:996 mul.f32 %f561, %f560, %f558
  asm("mul.f32 %0, %1, %2;" : "=f"(f561) : "f"(f560), "f"(f558));
  // PTX:997 ld.global.f32 %f562, [%rd199+8]
  f562 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd199) + (8)))));
  // PTX:998 mul.f32 %f563, %f562, %f558
  asm("mul.f32 %0, %1, %2;" : "=f"(f563) : "f"(f562), "f"(f558));
  // PTX:999 fma.rn.f32 %f564, %f553, %f554, %f559
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f564) : "f"(f553), "f"(f554), "f"(f559));
  // PTX:1000 fma.rn.f32 %f565, %f555, %f554, %f561
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f565) : "f"(f555), "f"(f554), "f"(f561));
  // PTX:1001 fma.rn.f32 %f566, %f556, %f554, %f563
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f566) : "f"(f556), "f"(f554), "f"(f563));
  // PTX:1002 mul.wide.s32 %rd200, %r258, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd200) : "r"(r258));
  // PTX:1003 add.s64 %rd201, %rd6, %rd200
  asm("add.s64 %0, %1, %2;" : "=l"(rd201) : "l"(rd6), "l"(rd200));
  // PTX:1004 ld.global.f32 %f567, [%rd201]
  f567 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd201) + (0)))));
  // PTX:1005 mov.b32 %f568, %r307
  asm("mov.b32 %0, %1;" : "=f"(f568) : "r"(r307));
  // PTX:1006 ld.global.f32 %f569, [%rd201+4]
  f569 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd201) + (4)))));
  // PTX:1007 ld.global.f32 %f570, [%rd201+8]
  f570 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd201) + (8)))));
  // PTX:1008 fma.rn.f32 %f571, %f567, %f568, %f564
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f571) : "f"(f567), "f"(f568), "f"(f564));
  // PTX:1009 fma.rn.f32 %f572, %f569, %f568, %f565
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f572) : "f"(f569), "f"(f568), "f"(f565));
  // PTX:1010 fma.rn.f32 %f573, %f570, %f568, %f566
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f573) : "f"(f570), "f"(f568), "f"(f566));
  // PTX:1011 mov.b32 %r305, %f571
  asm("mov.b32 %0, %1;" : "=r"(r305) : "f"(f571));
  // PTX:1012 mov.b32 %r306, %f572
  asm("mov.b32 %0, %1;" : "=r"(r306) : "f"(f572));
  // PTX:1013 mov.b32 %r307, %f573
  asm("mov.b32 %0, %1;" : "=r"(r307) : "f"(f573));
  // PTX:1015 $L__BB3_79:
L_BB3_79:;
  // PTX:1016 mov.u32 %r308, %r307
  asm("mov.u32 %0, %1;" : "=r"(r308) : "r"(r307));
  // PTX:1017 mov.u32 %r309, %r306
  asm("mov.u32 %0, %1;" : "=r"(r309) : "r"(r306));
  // PTX:1018 mov.u32 %r310, %r305
  asm("mov.u32 %0, %1;" : "=r"(r310) : "r"(r305));
  // PTX:1019 @%p38 bra $L__BB3_105
  if (p38) { goto L_BB3_105; }
  // PTX:1021 ld.global.f32 %f126, [%rd44]
  f126 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))));
  // PTX:1022 ld.global.f32 %f127, [%rd44+4]
  f127 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (4)))));
  // PTX:1023 ld.global.f32 %f128, [%rd44+8]
  f128 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (8)))));
  // PTX:1024 mul.wide.s32 %rd202, %r255, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd202) : "r"(r255));
  // PTX:1025 add.s64 %rd47, %rd6, %rd202
  asm("add.s64 %0, %1, %2;" : "=l"(rd47) : "l"(rd6), "l"(rd202));
  // PTX:1026 add.s64 %rd48, %rd5, %rd202
  asm("add.s64 %0, %1, %2;" : "=l"(rd48) : "l"(rd5), "l"(rd202));
  // PTX:1027 add.s64 %rd49, %rd4, %rd202
  asm("add.s64 %0, %1, %2;" : "=l"(rd49) : "l"(rd4), "l"(rd202));
  // PTX:1028 @%p73 bra $L__BB3_82
  if (p73) { goto L_BB3_82; }
  // PTX:1030 ld.global.f32 %f574, [%rd47]
  f574 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))));
  // PTX:1031 ld.global.f32 %f575, [%rd48]
  f575 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))));
  // PTX:1032 sub.f32 %f576, %f574, %f575
  asm("sub.f32 %0, %1, %2;" : "=f"(f576) : "f"(f574), "f"(f575));
  // PTX:1033 ld.global.f32 %f577, [%rd48+4]
  f577 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (4)))));
  // PTX:1034 ld.global.f32 %f578, [%rd47+4]
  f578 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (4)))));
  // PTX:1035 sub.f32 %f579, %f578, %f577
  asm("sub.f32 %0, %1, %2;" : "=f"(f579) : "f"(f578), "f"(f577));
  // PTX:1036 ld.global.f32 %f580, [%rd48+8]
  f580 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (8)))));
  // PTX:1037 ld.global.f32 %f581, [%rd47+8]
  f581 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (8)))));
  // PTX:1038 sub.f32 %f582, %f581, %f580
  asm("sub.f32 %0, %1, %2;" : "=f"(f582) : "f"(f581), "f"(f580));
  // PTX:1039 mul.f32 %f956, %f576, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f956) : "f"(f576), "f"(f257));
  // PTX:1040 mul.f32 %f957, %f579, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f957) : "f"(f579), "f"(f257));
  // PTX:1041 mul.f32 %f958, %f582, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f958) : "f"(f582), "f"(f257));
  // PTX:1042 bra.uni $L__BB3_83
  goto L_BB3_83;
  // PTX:1044 $L__BB3_82:
L_BB3_82:;
  // PTX:1045 ld.global.f32 %f956, [%rd49]
  f956 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))));
  // PTX:1046 ld.global.f32 %f957, [%rd49+4]
  f957 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (4)))));
  // PTX:1047 ld.global.f32 %f958, [%rd49+8]
  f958 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (8)))));
  // PTX:1049 $L__BB3_83:
L_BB3_83:;
  // PTX:1050 mul.wide.s32 %rd203, %r256, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd203) : "r"(r256));
  // PTX:1051 add.s64 %rd50, %rd6, %rd203
  asm("add.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd6), "l"(rd203));
  // PTX:1052 add.s64 %rd51, %rd5, %rd203
  asm("add.s64 %0, %1, %2;" : "=l"(rd51) : "l"(rd5), "l"(rd203));
  // PTX:1053 add.s64 %rd52, %rd4, %rd203
  asm("add.s64 %0, %1, %2;" : "=l"(rd52) : "l"(rd4), "l"(rd203));
  // PTX:1054 @%p73 bra $L__BB3_85
  if (p73) { goto L_BB3_85; }
  // PTX:1056 ld.global.f32 %f583, [%rd50]
  f583 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (0)))));
  // PTX:1057 ld.global.f32 %f584, [%rd51]
  f584 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))));
  // PTX:1058 sub.f32 %f585, %f583, %f584
  asm("sub.f32 %0, %1, %2;" : "=f"(f585) : "f"(f583), "f"(f584));
  // PTX:1059 ld.global.f32 %f586, [%rd51+4]
  f586 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (4)))));
  // PTX:1060 ld.global.f32 %f587, [%rd50+4]
  f587 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (4)))));
  // PTX:1061 sub.f32 %f588, %f587, %f586
  asm("sub.f32 %0, %1, %2;" : "=f"(f588) : "f"(f587), "f"(f586));
  // PTX:1062 ld.global.f32 %f589, [%rd51+8]
  f589 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (8)))));
  // PTX:1063 ld.global.f32 %f590, [%rd50+8]
  f590 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (8)))));
  // PTX:1064 sub.f32 %f591, %f590, %f589
  asm("sub.f32 %0, %1, %2;" : "=f"(f591) : "f"(f590), "f"(f589));
  // PTX:1065 mul.f32 %f959, %f585, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f959) : "f"(f585), "f"(f257));
  // PTX:1066 mul.f32 %f960, %f588, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f960) : "f"(f588), "f"(f257));
  // PTX:1067 mul.f32 %f961, %f591, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f961) : "f"(f591), "f"(f257));
  // PTX:1068 bra.uni $L__BB3_86
  goto L_BB3_86;
  // PTX:1070 $L__BB3_85:
L_BB3_85:;
  // PTX:1071 ld.global.f32 %f959, [%rd52]
  f959 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))));
  // PTX:1072 ld.global.f32 %f960, [%rd52+4]
  f960 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (4)))));
  // PTX:1073 ld.global.f32 %f961, [%rd52+8]
  f961 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (8)))));
  // PTX:1075 $L__BB3_86:
L_BB3_86:;
  // PTX:1076 mul.wide.s32 %rd204, %r257, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd204) : "r"(r257));
  // PTX:1077 add.s64 %rd53, %rd6, %rd204
  asm("add.s64 %0, %1, %2;" : "=l"(rd53) : "l"(rd6), "l"(rd204));
  // PTX:1078 add.s64 %rd54, %rd5, %rd204
  asm("add.s64 %0, %1, %2;" : "=l"(rd54) : "l"(rd5), "l"(rd204));
  // PTX:1079 add.s64 %rd55, %rd4, %rd204
  asm("add.s64 %0, %1, %2;" : "=l"(rd55) : "l"(rd4), "l"(rd204));
  // PTX:1080 @%p73 bra $L__BB3_88
  if (p73) { goto L_BB3_88; }
  // PTX:1082 ld.global.f32 %f592, [%rd53]
  f592 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))));
  // PTX:1083 ld.global.f32 %f593, [%rd54]
  f593 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))));
  // PTX:1084 sub.f32 %f594, %f592, %f593
  asm("sub.f32 %0, %1, %2;" : "=f"(f594) : "f"(f592), "f"(f593));
  // PTX:1085 ld.global.f32 %f595, [%rd54+4]
  f595 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (4)))));
  // PTX:1086 ld.global.f32 %f596, [%rd53+4]
  f596 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (4)))));
  // PTX:1087 sub.f32 %f597, %f596, %f595
  asm("sub.f32 %0, %1, %2;" : "=f"(f597) : "f"(f596), "f"(f595));
  // PTX:1088 ld.global.f32 %f598, [%rd54+8]
  f598 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (8)))));
  // PTX:1089 ld.global.f32 %f599, [%rd53+8]
  f599 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (8)))));
  // PTX:1090 sub.f32 %f600, %f599, %f598
  asm("sub.f32 %0, %1, %2;" : "=f"(f600) : "f"(f599), "f"(f598));
  // PTX:1091 mul.f32 %f962, %f594, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f962) : "f"(f594), "f"(f257));
  // PTX:1092 mul.f32 %f963, %f597, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f963) : "f"(f597), "f"(f257));
  // PTX:1093 mul.f32 %f964, %f600, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f964) : "f"(f600), "f"(f257));
  // PTX:1094 bra.uni $L__BB3_89
  goto L_BB3_89;
  // PTX:1096 $L__BB3_88:
L_BB3_88:;
  // PTX:1097 ld.global.f32 %f962, [%rd55]
  f962 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))));
  // PTX:1098 ld.global.f32 %f963, [%rd55+4]
  f963 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (4)))));
  // PTX:1099 ld.global.f32 %f964, [%rd55+8]
  f964 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (8)))));
  // PTX:1101 $L__BB3_89:
L_BB3_89:;
  // PTX:1102 mul.wide.s32 %rd205, %r258, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd205) : "r"(r258));
  // PTX:1103 add.s64 %rd56, %rd6, %rd205
  asm("add.s64 %0, %1, %2;" : "=l"(rd56) : "l"(rd6), "l"(rd205));
  // PTX:1104 add.s64 %rd57, %rd5, %rd205
  asm("add.s64 %0, %1, %2;" : "=l"(rd57) : "l"(rd5), "l"(rd205));
  // PTX:1105 add.s64 %rd58, %rd4, %rd205
  asm("add.s64 %0, %1, %2;" : "=l"(rd58) : "l"(rd4), "l"(rd205));
  // PTX:1106 @%p73 bra $L__BB3_91
  if (p73) { goto L_BB3_91; }
  // PTX:1108 ld.global.f32 %f601, [%rd56]
  f601 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))));
  // PTX:1109 ld.global.f32 %f602, [%rd57]
  f602 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))));
  // PTX:1110 sub.f32 %f603, %f601, %f602
  asm("sub.f32 %0, %1, %2;" : "=f"(f603) : "f"(f601), "f"(f602));
  // PTX:1111 ld.global.f32 %f604, [%rd57+4]
  f604 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (4)))));
  // PTX:1112 ld.global.f32 %f605, [%rd56+4]
  f605 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (4)))));
  // PTX:1113 sub.f32 %f606, %f605, %f604
  asm("sub.f32 %0, %1, %2;" : "=f"(f606) : "f"(f605), "f"(f604));
  // PTX:1114 ld.global.f32 %f607, [%rd57+8]
  f607 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (8)))));
  // PTX:1115 ld.global.f32 %f608, [%rd56+8]
  f608 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (8)))));
  // PTX:1116 sub.f32 %f609, %f608, %f607
  asm("sub.f32 %0, %1, %2;" : "=f"(f609) : "f"(f608), "f"(f607));
  // PTX:1117 mul.f32 %f965, %f603, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f965) : "f"(f603), "f"(f257));
  // PTX:1118 mul.f32 %f966, %f606, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f966) : "f"(f606), "f"(f257));
  // PTX:1119 mul.f32 %f967, %f609, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f967) : "f"(f609), "f"(f257));
  // PTX:1120 bra.uni $L__BB3_92
  goto L_BB3_92;
  // PTX:1122 $L__BB3_91:
L_BB3_91:;
  // PTX:1123 ld.global.f32 %f965, [%rd58]
  f965 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (0)))));
  // PTX:1124 ld.global.f32 %f966, [%rd58+4]
  f966 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (4)))));
  // PTX:1125 ld.global.f32 %f967, [%rd58+8]
  f967 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (8)))));
  // PTX:1127 $L__BB3_92:
L_BB3_92:;
  // PTX:1128 mov.b32 %f610, %r18
  asm("mov.b32 %0, %1;" : "=f"(f610) : "r"(r18));
  // PTX:1129 sub.f32 %f611, %f610, %f126
  asm("sub.f32 %0, %1, %2;" : "=f"(f611) : "f"(f610), "f"(f126));
  // PTX:1130 mov.b32 %f612, %r19
  asm("mov.b32 %0, %1;" : "=f"(f612) : "r"(r19));
  // PTX:1131 sub.f32 %f613, %f612, %f127
  asm("sub.f32 %0, %1, %2;" : "=f"(f613) : "f"(f612), "f"(f127));
  // PTX:1132 mov.b32 %f614, %r20
  asm("mov.b32 %0, %1;" : "=f"(f614) : "r"(r20));
  // PTX:1133 sub.f32 %f615, %f614, %f128
  asm("sub.f32 %0, %1, %2;" : "=f"(f615) : "f"(f614), "f"(f128));
  // PTX:1134 fma.rn.f32 %f616, %f611, %f959, %f956
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f616) : "f"(f611), "f"(f959), "f"(f956));
  // PTX:1135 fma.rn.f32 %f617, %f611, %f960, %f957
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f617) : "f"(f611), "f"(f960), "f"(f957));
  // PTX:1136 fma.rn.f32 %f618, %f611, %f961, %f958
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f618) : "f"(f611), "f"(f961), "f"(f958));
  // PTX:1137 fma.rn.f32 %f619, %f613, %f962, %f616
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f619) : "f"(f613), "f"(f962), "f"(f616));
  // PTX:1138 fma.rn.f32 %f620, %f613, %f963, %f617
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f620) : "f"(f613), "f"(f963), "f"(f617));
  // PTX:1139 fma.rn.f32 %f621, %f613, %f964, %f618
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f621) : "f"(f613), "f"(f964), "f"(f618));
  // PTX:1140 fma.rn.f32 %f165, %f615, %f965, %f619
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f165) : "f"(f615), "f"(f965), "f"(f619));
  // PTX:1141 fma.rn.f32 %f166, %f615, %f966, %f620
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f166) : "f"(f615), "f"(f966), "f"(f620));
  // PTX:1142 fma.rn.f32 %f167, %f615, %f967, %f621
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f167) : "f"(f615), "f"(f967), "f"(f621));
  // PTX:1143 @%p73 bra $L__BB3_94
  if (p73) { goto L_BB3_94; }
  // PTX:1145 ld.global.f32 %f622, [%rd47]
  f622 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))));
  // PTX:1146 ld.global.f32 %f623, [%rd48]
  f623 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))));
  // PTX:1147 sub.f32 %f624, %f622, %f623
  asm("sub.f32 %0, %1, %2;" : "=f"(f624) : "f"(f622), "f"(f623));
  // PTX:1148 ld.global.f32 %f625, [%rd48+4]
  f625 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (4)))));
  // PTX:1149 ld.global.f32 %f626, [%rd47+4]
  f626 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (4)))));
  // PTX:1150 sub.f32 %f627, %f626, %f625
  asm("sub.f32 %0, %1, %2;" : "=f"(f627) : "f"(f626), "f"(f625));
  // PTX:1151 ld.global.f32 %f628, [%rd48+8]
  f628 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (8)))));
  // PTX:1152 ld.global.f32 %f629, [%rd47+8]
  f629 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (8)))));
  // PTX:1153 sub.f32 %f630, %f629, %f628
  asm("sub.f32 %0, %1, %2;" : "=f"(f630) : "f"(f629), "f"(f628));
  // PTX:1154 mul.f32 %f968, %f624, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f968) : "f"(f624), "f"(f257));
  // PTX:1155 mul.f32 %f969, %f627, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f969) : "f"(f627), "f"(f257));
  // PTX:1156 mul.f32 %f970, %f630, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f970) : "f"(f630), "f"(f257));
  // PTX:1157 bra.uni $L__BB3_95
  goto L_BB3_95;
  // PTX:1159 $L__BB3_94:
L_BB3_94:;
  // PTX:1160 ld.global.f32 %f968, [%rd49]
  f968 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))));
  // PTX:1161 ld.global.f32 %f969, [%rd49+4]
  f969 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (4)))));
  // PTX:1162 ld.global.f32 %f970, [%rd49+8]
  f970 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (8)))));
  // PTX:1164 $L__BB3_95:
L_BB3_95:;
  // PTX:1165 @%p73 bra $L__BB3_97
  if (p73) { goto L_BB3_97; }
  // PTX:1167 ld.global.f32 %f631, [%rd50]
  f631 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (0)))));
  // PTX:1168 ld.global.f32 %f632, [%rd51]
  f632 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))));
  // PTX:1169 sub.f32 %f633, %f631, %f632
  asm("sub.f32 %0, %1, %2;" : "=f"(f633) : "f"(f631), "f"(f632));
  // PTX:1170 ld.global.f32 %f634, [%rd51+4]
  f634 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (4)))));
  // PTX:1171 ld.global.f32 %f635, [%rd50+4]
  f635 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (4)))));
  // PTX:1172 sub.f32 %f636, %f635, %f634
  asm("sub.f32 %0, %1, %2;" : "=f"(f636) : "f"(f635), "f"(f634));
  // PTX:1173 ld.global.f32 %f637, [%rd51+8]
  f637 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (8)))));
  // PTX:1174 ld.global.f32 %f638, [%rd50+8]
  f638 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (8)))));
  // PTX:1175 sub.f32 %f639, %f638, %f637
  asm("sub.f32 %0, %1, %2;" : "=f"(f639) : "f"(f638), "f"(f637));
  // PTX:1176 mul.f32 %f971, %f633, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f971) : "f"(f633), "f"(f257));
  // PTX:1177 mul.f32 %f972, %f636, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f972) : "f"(f636), "f"(f257));
  // PTX:1178 mul.f32 %f973, %f639, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f973) : "f"(f639), "f"(f257));
  // PTX:1179 bra.uni $L__BB3_98
  goto L_BB3_98;
  // PTX:1181 $L__BB3_97:
L_BB3_97:;
  // PTX:1182 ld.global.f32 %f971, [%rd52]
  f971 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))));
  // PTX:1183 ld.global.f32 %f972, [%rd52+4]
  f972 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (4)))));
  // PTX:1184 ld.global.f32 %f973, [%rd52+8]
  f973 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (8)))));
  // PTX:1186 $L__BB3_98:
L_BB3_98:;
  // PTX:1187 @%p73 bra $L__BB3_100
  if (p73) { goto L_BB3_100; }
  // PTX:1189 ld.global.f32 %f640, [%rd53]
  f640 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))));
  // PTX:1190 ld.global.f32 %f641, [%rd54]
  f641 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))));
  // PTX:1191 sub.f32 %f642, %f640, %f641
  asm("sub.f32 %0, %1, %2;" : "=f"(f642) : "f"(f640), "f"(f641));
  // PTX:1192 ld.global.f32 %f643, [%rd54+4]
  f643 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (4)))));
  // PTX:1193 ld.global.f32 %f644, [%rd53+4]
  f644 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (4)))));
  // PTX:1194 sub.f32 %f645, %f644, %f643
  asm("sub.f32 %0, %1, %2;" : "=f"(f645) : "f"(f644), "f"(f643));
  // PTX:1195 ld.global.f32 %f646, [%rd54+8]
  f646 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (8)))));
  // PTX:1196 ld.global.f32 %f647, [%rd53+8]
  f647 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (8)))));
  // PTX:1197 sub.f32 %f648, %f647, %f646
  asm("sub.f32 %0, %1, %2;" : "=f"(f648) : "f"(f647), "f"(f646));
  // PTX:1198 mul.f32 %f974, %f642, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f974) : "f"(f642), "f"(f257));
  // PTX:1199 mul.f32 %f975, %f645, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f975) : "f"(f645), "f"(f257));
  // PTX:1200 mul.f32 %f976, %f648, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f976) : "f"(f648), "f"(f257));
  // PTX:1201 bra.uni $L__BB3_101
  goto L_BB3_101;
  // PTX:1203 $L__BB3_100:
L_BB3_100:;
  // PTX:1204 ld.global.f32 %f974, [%rd55]
  f974 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))));
  // PTX:1205 ld.global.f32 %f975, [%rd55+4]
  f975 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (4)))));
  // PTX:1206 ld.global.f32 %f976, [%rd55+8]
  f976 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (8)))));
  // PTX:1208 $L__BB3_101:
L_BB3_101:;
  // PTX:1209 @%p73 bra $L__BB3_103
  if (p73) { goto L_BB3_103; }
  // PTX:1211 ld.global.f32 %f649, [%rd56]
  f649 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))));
  // PTX:1212 ld.global.f32 %f650, [%rd57]
  f650 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))));
  // PTX:1213 sub.f32 %f651, %f649, %f650
  asm("sub.f32 %0, %1, %2;" : "=f"(f651) : "f"(f649), "f"(f650));
  // PTX:1214 ld.global.f32 %f652, [%rd57+4]
  f652 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (4)))));
  // PTX:1215 ld.global.f32 %f653, [%rd56+4]
  f653 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (4)))));
  // PTX:1216 sub.f32 %f654, %f653, %f652
  asm("sub.f32 %0, %1, %2;" : "=f"(f654) : "f"(f653), "f"(f652));
  // PTX:1217 ld.global.f32 %f655, [%rd57+8]
  f655 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (8)))));
  // PTX:1218 ld.global.f32 %f656, [%rd56+8]
  f656 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (8)))));
  // PTX:1219 sub.f32 %f657, %f656, %f655
  asm("sub.f32 %0, %1, %2;" : "=f"(f657) : "f"(f656), "f"(f655));
  // PTX:1220 mul.f32 %f977, %f651, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f977) : "f"(f651), "f"(f257));
  // PTX:1221 mul.f32 %f978, %f654, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f978) : "f"(f654), "f"(f257));
  // PTX:1222 mul.f32 %f979, %f657, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f979) : "f"(f657), "f"(f257));
  // PTX:1223 bra.uni $L__BB3_104
  goto L_BB3_104;
  // PTX:1225 $L__BB3_103:
L_BB3_103:;
  // PTX:1226 ld.global.f32 %f977, [%rd58]
  f977 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (0)))));
  // PTX:1227 ld.global.f32 %f978, [%rd58+4]
  f978 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (4)))));
  // PTX:1228 ld.global.f32 %f979, [%rd58+8]
  f979 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (8)))));
  // PTX:1230 $L__BB3_104:
L_BB3_104:;
  // PTX:1231 mov.b32 %f658, %r305
  asm("mov.b32 %0, %1;" : "=f"(f658) : "r"(r305));
  // PTX:1232 mov.b32 %f659, %r306
  asm("mov.b32 %0, %1;" : "=f"(f659) : "r"(r306));
  // PTX:1233 mov.b32 %f660, %r307
  asm("mov.b32 %0, %1;" : "=f"(f660) : "r"(r307));
  // PTX:1234 mov.b32 %f661, %r296
  asm("mov.b32 %0, %1;" : "=f"(f661) : "r"(r296));
  // PTX:1235 sub.f32 %f662, %f661, %f126
  asm("sub.f32 %0, %1, %2;" : "=f"(f662) : "f"(f661), "f"(f126));
  // PTX:1236 mov.b32 %f663, %r297
  asm("mov.b32 %0, %1;" : "=f"(f663) : "r"(r297));
  // PTX:1237 sub.f32 %f664, %f663, %f127
  asm("sub.f32 %0, %1, %2;" : "=f"(f664) : "f"(f663), "f"(f127));
  // PTX:1238 mov.b32 %f665, %r298
  asm("mov.b32 %0, %1;" : "=f"(f665) : "r"(r298));
  // PTX:1239 sub.f32 %f666, %f665, %f128
  asm("sub.f32 %0, %1, %2;" : "=f"(f666) : "f"(f665), "f"(f128));
  // PTX:1240 fma.rn.f32 %f667, %f662, %f971, %f968
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f667) : "f"(f662), "f"(f971), "f"(f968));
  // PTX:1241 fma.rn.f32 %f668, %f662, %f972, %f969
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f668) : "f"(f662), "f"(f972), "f"(f969));
  // PTX:1242 fma.rn.f32 %f669, %f662, %f973, %f970
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f669) : "f"(f662), "f"(f973), "f"(f970));
  // PTX:1243 fma.rn.f32 %f670, %f664, %f974, %f667
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f670) : "f"(f664), "f"(f974), "f"(f667));
  // PTX:1244 fma.rn.f32 %f671, %f664, %f975, %f668
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f671) : "f"(f664), "f"(f975), "f"(f668));
  // PTX:1245 fma.rn.f32 %f672, %f664, %f976, %f669
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f672) : "f"(f664), "f"(f976), "f"(f669));
  // PTX:1246 fma.rn.f32 %f673, %f666, %f977, %f670
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f673) : "f"(f666), "f"(f977), "f"(f670));
  // PTX:1247 fma.rn.f32 %f674, %f666, %f978, %f671
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f674) : "f"(f666), "f"(f978), "f"(f671));
  // PTX:1248 fma.rn.f32 %f675, %f666, %f979, %f672
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f675) : "f"(f666), "f"(f979), "f"(f672));
  // PTX:1249 add.f32 %f676, %f673, %f658
  asm("add.f32 %0, %1, %2;" : "=f"(f676) : "f"(f673), "f"(f658));
  // PTX:1250 add.f32 %f677, %f674, %f659
  asm("add.f32 %0, %1, %2;" : "=f"(f677) : "f"(f674), "f"(f659));
  // PTX:1251 add.f32 %f678, %f675, %f660
  asm("add.f32 %0, %1, %2;" : "=f"(f678) : "f"(f675), "f"(f660));
  // PTX:1252 mov.b32 %r310, %f676
  asm("mov.b32 %0, %1;" : "=r"(r310) : "f"(f676));
  // PTX:1253 mov.b32 %r309, %f677
  asm("mov.b32 %0, %1;" : "=r"(r309) : "f"(f677));
  // PTX:1254 mov.b32 %r308, %f678
  asm("mov.b32 %0, %1;" : "=r"(r308) : "f"(f678));
  // PTX:1255 add.f32 %f679, %f165, %f658
  asm("add.f32 %0, %1, %2;" : "=f"(f679) : "f"(f165), "f"(f658));
  // PTX:1256 mov.b32 %r305, %f679
  asm("mov.b32 %0, %1;" : "=r"(r305) : "f"(f679));
  // PTX:1257 add.f32 %f680, %f166, %f659
  asm("add.f32 %0, %1, %2;" : "=f"(f680) : "f"(f166), "f"(f659));
  // PTX:1258 mov.b32 %r306, %f680
  asm("mov.b32 %0, %1;" : "=r"(r306) : "f"(f680));
  // PTX:1259 add.f32 %f681, %f167, %f660
  asm("add.f32 %0, %1, %2;" : "=f"(f681) : "f"(f167), "f"(f660));
  // PTX:1260 mov.b32 %r307, %f681
  asm("mov.b32 %0, %1;" : "=r"(r307) : "f"(f681));
  // PTX:1262 $L__BB3_105:
L_BB3_105:;
  // PTX:1263 cvt.s64.s32 %rd359, %rd365
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd359) : "l"(rd365));
  // PTX:1264 shl.b64 %rd358, %rd359, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd358) : "l"(rd359));
  // PTX:1265 ld.param.f32 %f927, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_27]
  f927 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param27 + (0))));
  // PTX:1266 ld.param.u64 %rd294, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_20]
  rd294 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param20 + (0))));
  // PTX:1267 ld.param.f32 %f926, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_25]
  f926 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param25 + (0))));
  // PTX:1268 ld.param.u64 %rd293, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_18]
  rd293 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param18 + (0))));
  // PTX:1269 ld.param.f32 %f925, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_24]
  f925 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param24 + (0))));
  // PTX:1270 ld.param.u64 %rd292, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_17]
  rd292 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param17 + (0))));
  // PTX:1271 mov.b32 %f683, %r305
  asm("mov.b32 %0, %1;" : "=f"(f683) : "r"(r305));
  // PTX:1272 sub.f32 %f684, %f955, %f683
  asm("sub.f32 %0, %1, %2;" : "=f"(f684) : "f"(f955), "f"(f683));
  // PTX:1273 mov.b32 %f685, %r306
  asm("mov.b32 %0, %1;" : "=f"(f685) : "r"(r306));
  // PTX:1274 sub.f32 %f686, %f954, %f685
  asm("sub.f32 %0, %1, %2;" : "=f"(f686) : "f"(f954), "f"(f685));
  // PTX:1275 mov.b32 %f687, %r307
  asm("mov.b32 %0, %1;" : "=f"(f687) : "r"(r307));
  // PTX:1276 sub.f32 %f688, %f953, %f687
  asm("sub.f32 %0, %1, %2;" : "=f"(f688) : "f"(f953), "f"(f687));
  // PTX:1277 mov.b32 %f689, %r310
  asm("mov.b32 %0, %1;" : "=f"(f689) : "r"(r310));
  // PTX:1278 sub.f32 %f690, %f955, %f689
  asm("sub.f32 %0, %1, %2;" : "=f"(f690) : "f"(f955), "f"(f689));
  // PTX:1279 mov.b32 %f691, %r309
  asm("mov.b32 %0, %1;" : "=f"(f691) : "r"(r309));
  // PTX:1280 sub.f32 %f692, %f954, %f691
  asm("sub.f32 %0, %1, %2;" : "=f"(f692) : "f"(f954), "f"(f691));
  // PTX:1281 mov.b32 %f693, %r308
  asm("mov.b32 %0, %1;" : "=f"(f693) : "r"(r308));
  // PTX:1282 sub.f32 %f694, %f953, %f693
  asm("sub.f32 %0, %1, %2;" : "=f"(f694) : "f"(f953), "f"(f693));
  // PTX:1283 mul.f32 %f695, %f686, %f951
  asm("mul.f32 %0, %1, %2;" : "=f"(f695) : "f"(f686), "f"(f951));
  // PTX:1284 fma.rn.f32 %f696, %f684, %f952, %f695
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f696) : "f"(f684), "f"(f952), "f"(f695));
  // PTX:1285 fma.rn.f32 %f697, %f688, %f950, %f696
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f697) : "f"(f688), "f"(f950), "f"(f696));
  // PTX:1286 cvta.to.global.u64 %rd206, %rd292
  rd206 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd292));
  // PTX:1287 add.s64 %rd208, %rd206, %rd358
  asm("add.s64 %0, %1, %2;" : "=l"(rd208) : "l"(rd206), "l"(rd358));
  // PTX:1288 ld.global.f32 %f698, [%rd208]
  f698 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd208) + (0)))));
  // PTX:1289 min.f32 %f204, %f925, %f698
  asm("min.f32 %0, %1, %2;" : "=f"(f204) : "f"(f925), "f"(f698));
  // PTX:1290 cvta.to.global.u64 %rd209, %rd293
  rd209 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd293));
  // PTX:1291 add.s64 %rd210, %rd209, %rd358
  asm("add.s64 %0, %1, %2;" : "=l"(rd210) : "l"(rd209), "l"(rd358));
  // PTX:1292 ld.global.f32 %f699, [%rd210]
  f699 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd210) + (0)))));
  // PTX:1293 min.f32 %f700, %f926, %f699
  asm("min.f32 %0, %1, %2;" : "=f"(f700) : "f"(f926), "f"(f699));
  // PTX:1294 mul.f32 %f701, %f204, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f701) : "f"(f204), "f"(f1));
  // PTX:1295 sqrt.rn.f32 %f702, %f701
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f702) : "f"(f701));
  // PTX:1296 add.f32 %f703, %f702, %f702
  asm("add.f32 %0, %1, %2;" : "=f"(f703) : "f"(f702), "f"(f702));
  // PTX:1297 min.f32 %f205, %f700, %f703
  asm("min.f32 %0, %1, %2;" : "=f"(f205) : "f"(f700), "f"(f703));
  // PTX:1298 cvta.to.global.u64 %rd211, %rd294
  rd211 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd294));
  // PTX:1299 add.s64 %rd212, %rd211, %rd358
  asm("add.s64 %0, %1, %2;" : "=l"(rd212) : "l"(rd211), "l"(rd358));
  // PTX:1300 ld.global.f32 %f704, [%rd212]
  f704 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd212) + (0)))));
  // PTX:1301 min.f32 %f705, %f927, %f704
  asm("min.f32 %0, %1, %2;" : "=f"(f705) : "f"(f927), "f"(f704));
  // PTX:1302 mul.f32 %f706, %f116, %f204
  asm("mul.f32 %0, %1, %2;" : "=f"(f706) : "f"(f116), "f"(f204));
  // PTX:1303 mul.f32 %f707, %f697, %f205
  asm("mul.f32 %0, %1, %2;" : "=f"(f707) : "f"(f697), "f"(f205));
  // PTX:1304 sub.f32 %f708, %f706, %f707
  asm("sub.f32 %0, %1, %2;" : "=f"(f708) : "f"(f706), "f"(f707));
  // PTX:1305 mov.f32 %f980, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f980) : );
  // PTX:1306 max.f32 %f206, %f708, %f980
  asm("max.f32 %0, %1, %2;" : "=f"(f206) : "f"(f708), "f"(f980));
  // PTX:1307 mul.f32 %f709, %f690, %f952
  asm("mul.f32 %0, %1, %2;" : "=f"(f709) : "f"(f690), "f"(f952));
  // PTX:1308 fma.rn.f32 %f710, %f692, %f951, %f709
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f710) : "f"(f692), "f"(f951), "f"(f709));
  // PTX:1309 fma.rn.f32 %f711, %f694, %f950, %f710
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f711) : "f"(f694), "f"(f950), "f"(f710));
  // PTX:1310 mul.f32 %f712, %f711, %f952
  asm("mul.f32 %0, %1, %2;" : "=f"(f712) : "f"(f711), "f"(f952));
  // PTX:1311 mul.f32 %f713, %f711, %f951
  asm("mul.f32 %0, %1, %2;" : "=f"(f713) : "f"(f711), "f"(f951));
  // PTX:1312 mul.f32 %f714, %f711, %f950
  asm("mul.f32 %0, %1, %2;" : "=f"(f714) : "f"(f711), "f"(f950));
  // PTX:1313 sub.f32 %f207, %f690, %f712
  asm("sub.f32 %0, %1, %2;" : "=f"(f207) : "f"(f690), "f"(f712));
  // PTX:1314 sub.f32 %f208, %f692, %f713
  asm("sub.f32 %0, %1, %2;" : "=f"(f208) : "f"(f692), "f"(f713));
  // PTX:1315 sub.f32 %f209, %f694, %f714
  asm("sub.f32 %0, %1, %2;" : "=f"(f209) : "f"(f694), "f"(f714));
  // PTX:1316 mul.f32 %f715, %f208, %f208
  asm("mul.f32 %0, %1, %2;" : "=f"(f715) : "f"(f208), "f"(f208));
  // PTX:1317 fma.rn.f32 %f716, %f207, %f207, %f715
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f716) : "f"(f207), "f"(f207), "f"(f715));
  // PTX:1318 fma.rn.f32 %f210, %f209, %f209, %f716
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f210) : "f"(f209), "f"(f209), "f"(f716));
  // PTX:1319 mul.f32 %f211, %f705, %f206
  asm("mul.f32 %0, %1, %2;" : "=f"(f211) : "f"(f705), "f"(f206));
  // PTX:1320 setp.leu.f32 %p84, %f211, 0f00000000
  p84 = ((isnan(((float)(f211))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f211)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1321 @%p84 bra $L__BB3_107
  if (p84) { goto L_BB3_107; }
  // PTX:1323 cvt.s64.s32 %rd361, %rd365
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd361) : "l"(rd365));
  // PTX:1324 shl.b64 %rd360, %rd361, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd360) : "l"(rd361));
  // PTX:1325 ld.param.f32 %f928, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_26]
  f928 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param26 + (0))));
  // PTX:1326 ld.param.u64 %rd306, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_19]
  rd306 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param19 + (0))));
  // PTX:1327 cvta.to.global.u64 %rd213, %rd306
  rd213 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd306));
  // PTX:1328 add.s64 %rd215, %rd213, %rd360
  asm("add.s64 %0, %1, %2;" : "=l"(rd215) : "l"(rd213), "l"(rd360));
  // PTX:1329 ld.global.f32 %f717, [%rd215]
  f717 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd215) + (0)))));
  // PTX:1330 sqrt.rn.f32 %f718, %f210
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f718) : "f"(f210));
  // PTX:1331 mov.f32 %f719, 0f322BCC77
  asm("mov.f32 %0, 0f322BCC77;" : "=f"(f719) : );
  // PTX:1332 max.f32 %f720, %f718, %f719
  asm("max.f32 %0, %1, %2;" : "=f"(f720) : "f"(f718), "f"(f719));
  // PTX:1333 div.rn.f32 %f721, %f211, %f720
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f721) : "f"(f211), "f"(f720));
  // PTX:1334 min.f32 %f722, %f928, %f717
  asm("min.f32 %0, %1, %2;" : "=f"(f722) : "f"(f928), "f"(f717));
  // PTX:1335 min.f32 %f980, %f722, %f721
  asm("min.f32 %0, %1, %2;" : "=f"(f980) : "f"(f722), "f"(f721));
  // PTX:1337 $L__BB3_107:
L_BB3_107:;
  // PTX:1338 ld.param.u64 %rd295, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_36]
  rd295 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param36 + (0))));
  // PTX:1339 neg.f32 %f723, %f980
  asm("neg.f32 %0, %1;" : "=f"(f723) : "f"(f980));
  // PTX:1340 mul.f32 %f214, %f207, %f723
  asm("mul.f32 %0, %1, %2;" : "=f"(f214) : "f"(f207), "f"(f723));
  // PTX:1341 mul.f32 %f215, %f208, %f723
  asm("mul.f32 %0, %1, %2;" : "=f"(f215) : "f"(f208), "f"(f723));
  // PTX:1342 mul.f32 %f216, %f209, %f723
  asm("mul.f32 %0, %1, %2;" : "=f"(f216) : "f"(f209), "f"(f723));
  // PTX:1343 mul.f32 %f217, %f206, %f952
  asm("mul.f32 %0, %1, %2;" : "=f"(f217) : "f"(f206), "f"(f952));
  // PTX:1344 add.f32 %f218, %f217, %f214
  asm("add.f32 %0, %1, %2;" : "=f"(f218) : "f"(f217), "f"(f214));
  // PTX:1345 mul.f32 %f219, %f206, %f951
  asm("mul.f32 %0, %1, %2;" : "=f"(f219) : "f"(f206), "f"(f951));
  // PTX:1346 add.f32 %f220, %f219, %f215
  asm("add.f32 %0, %1, %2;" : "=f"(f220) : "f"(f219), "f"(f215));
  // PTX:1347 mul.f32 %f221, %f206, %f950
  asm("mul.f32 %0, %1, %2;" : "=f"(f221) : "f"(f206), "f"(f950));
  // PTX:1348 add.f32 %f222, %f221, %f216
  asm("add.f32 %0, %1, %2;" : "=f"(f222) : "f"(f221), "f"(f216));
  // PTX:1349 setp.eq.s64 %p85, %rd295, 0
  p85 = (((long long)(rd295)) == ((long long)(0)));
  // PTX:1350 @%p85 bra $L__BB3_110
  if (p85) { goto L_BB3_110; }
  // PTX:1352 ld.param.u64 %rd297, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_36]
  rd297 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param36 + (0))));
  // PTX:1353 cvta.to.global.u64 %rd296, %rd297
  rd296 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd297));
  // PTX:1354 add.s64 %rd217, %rd296, %rd174
  asm("add.s64 %0, %1, %2;" : "=l"(rd217) : "l"(rd296), "l"(rd174));
  // PTX:1355 red.global.add.f32 [%rd217], %f218
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd217) + (0)))), (float)(f218));
  // PTX:1356 add.s64 %rd218, %rd217, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd218) : "l"(rd217));
  // PTX:1357 red.global.add.f32 [%rd218], %f220
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd218) + (0)))), (float)(f220));
  // PTX:1358 add.s64 %rd219, %rd217, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd219) : "l"(rd217));
  // PTX:1359 red.global.add.f32 [%rd219], %f222
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd219) + (0)))), (float)(f222));
  // PTX:1360 @%p38 bra $L__BB3_110
  if (p38) { goto L_BB3_110; }
  // PTX:1362 ld.param.u64 %rd299, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_36]
  rd299 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param36 + (0))));
  // PTX:1363 cvta.to.global.u64 %rd298, %rd299
  rd298 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd299));
  // PTX:1364 ld.global.f32 %f727, [%rd44]
  f727 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))));
  // PTX:1365 mov.b32 %f728, %r18
  asm("mov.b32 %0, %1;" : "=f"(f728) : "r"(r18));
  // PTX:1366 sub.f32 %f729, %f728, %f727
  asm("sub.f32 %0, %1, %2;" : "=f"(f729) : "f"(f728), "f"(f727));
  // PTX:1367 mov.b32 %f730, %r19
  asm("mov.b32 %0, %1;" : "=f"(f730) : "r"(r19));
  // PTX:1368 ld.global.f32 %f731, [%rd44+4]
  f731 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (4)))));
  // PTX:1369 sub.f32 %f732, %f730, %f731
  asm("sub.f32 %0, %1, %2;" : "=f"(f732) : "f"(f730), "f"(f731));
  // PTX:1370 mov.b32 %f733, %r20
  asm("mov.b32 %0, %1;" : "=f"(f733) : "r"(r20));
  // PTX:1371 ld.global.f32 %f734, [%rd44+8]
  f734 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (8)))));
  // PTX:1372 sub.f32 %f735, %f733, %f734
  asm("sub.f32 %0, %1, %2;" : "=f"(f735) : "f"(f733), "f"(f734));
  // PTX:1373 mul.wide.s32 %rd220, %r255, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd220) : "r"(r255));
  // PTX:1374 add.s64 %rd221, %rd298, %rd220
  asm("add.s64 %0, %1, %2;" : "=l"(rd221) : "l"(rd298), "l"(rd220));
  // PTX:1375 neg.f32 %f736, %f217
  asm("neg.f32 %0, %1;" : "=f"(f736) : "f"(f217));
  // PTX:1376 red.global.add.f32 [%rd221], %f736
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd221) + (0)))), (float)(f736));
  // PTX:1377 add.s64 %rd222, %rd221, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd222) : "l"(rd221));
  // PTX:1378 neg.f32 %f738, %f219
  asm("neg.f32 %0, %1;" : "=f"(f738) : "f"(f219));
  // PTX:1379 red.global.add.f32 [%rd222], %f738
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd222) + (0)))), (float)(f738));
  // PTX:1380 add.s64 %rd223, %rd221, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd223) : "l"(rd221));
  // PTX:1381 neg.f32 %f740, %f221
  asm("neg.f32 %0, %1;" : "=f"(f740) : "f"(f221));
  // PTX:1382 red.global.add.f32 [%rd223], %f740
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd223) + (0)))), (float)(f740));
  // PTX:1383 mul.wide.s32 %rd224, %r256, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd224) : "r"(r256));
  // PTX:1384 add.s64 %rd225, %rd298, %rd224
  asm("add.s64 %0, %1, %2;" : "=l"(rd225) : "l"(rd298), "l"(rd224));
  // PTX:1385 mul.f32 %f742, %f217, %f729
  asm("mul.f32 %0, %1, %2;" : "=f"(f742) : "f"(f217), "f"(f729));
  // PTX:1386 neg.f32 %f743, %f742
  asm("neg.f32 %0, %1;" : "=f"(f743) : "f"(f742));
  // PTX:1387 red.global.add.f32 [%rd225], %f743
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd225) + (0)))), (float)(f743));
  // PTX:1388 add.s64 %rd226, %rd225, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd226) : "l"(rd225));
  // PTX:1389 mul.f32 %f745, %f219, %f729
  asm("mul.f32 %0, %1, %2;" : "=f"(f745) : "f"(f219), "f"(f729));
  // PTX:1390 neg.f32 %f746, %f745
  asm("neg.f32 %0, %1;" : "=f"(f746) : "f"(f745));
  // PTX:1391 red.global.add.f32 [%rd226], %f746
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd226) + (0)))), (float)(f746));
  // PTX:1392 add.s64 %rd227, %rd225, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd227) : "l"(rd225));
  // PTX:1393 mul.f32 %f748, %f221, %f729
  asm("mul.f32 %0, %1, %2;" : "=f"(f748) : "f"(f221), "f"(f729));
  // PTX:1394 neg.f32 %f749, %f748
  asm("neg.f32 %0, %1;" : "=f"(f749) : "f"(f748));
  // PTX:1395 red.global.add.f32 [%rd227], %f749
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd227) + (0)))), (float)(f749));
  // PTX:1396 mul.wide.s32 %rd228, %r257, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd228) : "r"(r257));
  // PTX:1397 add.s64 %rd229, %rd298, %rd228
  asm("add.s64 %0, %1, %2;" : "=l"(rd229) : "l"(rd298), "l"(rd228));
  // PTX:1398 mul.f32 %f751, %f217, %f732
  asm("mul.f32 %0, %1, %2;" : "=f"(f751) : "f"(f217), "f"(f732));
  // PTX:1399 neg.f32 %f752, %f751
  asm("neg.f32 %0, %1;" : "=f"(f752) : "f"(f751));
  // PTX:1400 red.global.add.f32 [%rd229], %f752
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd229) + (0)))), (float)(f752));
  // PTX:1401 add.s64 %rd230, %rd229, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd230) : "l"(rd229));
  // PTX:1402 mul.f32 %f754, %f219, %f732
  asm("mul.f32 %0, %1, %2;" : "=f"(f754) : "f"(f219), "f"(f732));
  // PTX:1403 neg.f32 %f755, %f754
  asm("neg.f32 %0, %1;" : "=f"(f755) : "f"(f754));
  // PTX:1404 red.global.add.f32 [%rd230], %f755
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd230) + (0)))), (float)(f755));
  // PTX:1405 add.s64 %rd231, %rd229, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd231) : "l"(rd229));
  // PTX:1406 mul.f32 %f757, %f221, %f732
  asm("mul.f32 %0, %1, %2;" : "=f"(f757) : "f"(f221), "f"(f732));
  // PTX:1407 neg.f32 %f758, %f757
  asm("neg.f32 %0, %1;" : "=f"(f758) : "f"(f757));
  // PTX:1408 red.global.add.f32 [%rd231], %f758
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd231) + (0)))), (float)(f758));
  // PTX:1409 mul.wide.s32 %rd232, %r258, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd232) : "r"(r258));
  // PTX:1410 add.s64 %rd233, %rd298, %rd232
  asm("add.s64 %0, %1, %2;" : "=l"(rd233) : "l"(rd298), "l"(rd232));
  // PTX:1411 mul.f32 %f760, %f217, %f735
  asm("mul.f32 %0, %1, %2;" : "=f"(f760) : "f"(f217), "f"(f735));
  // PTX:1412 neg.f32 %f761, %f760
  asm("neg.f32 %0, %1;" : "=f"(f761) : "f"(f760));
  // PTX:1413 red.global.add.f32 [%rd233], %f761
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd233) + (0)))), (float)(f761));
  // PTX:1414 add.s64 %rd234, %rd233, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd234) : "l"(rd233));
  // PTX:1415 mul.f32 %f763, %f219, %f735
  asm("mul.f32 %0, %1, %2;" : "=f"(f763) : "f"(f219), "f"(f735));
  // PTX:1416 neg.f32 %f764, %f763
  asm("neg.f32 %0, %1;" : "=f"(f764) : "f"(f763));
  // PTX:1417 red.global.add.f32 [%rd234], %f764
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd234) + (0)))), (float)(f764));
  // PTX:1418 add.s64 %rd235, %rd233, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd235) : "l"(rd233));
  // PTX:1419 mul.f32 %f766, %f221, %f735
  asm("mul.f32 %0, %1, %2;" : "=f"(f766) : "f"(f221), "f"(f735));
  // PTX:1420 neg.f32 %f767, %f766
  asm("neg.f32 %0, %1;" : "=f"(f767) : "f"(f766));
  // PTX:1421 red.global.add.f32 [%rd235], %f767
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd235) + (0)))), (float)(f767));
  // PTX:1422 mov.b32 %f769, %r296
  asm("mov.b32 %0, %1;" : "=f"(f769) : "r"(r296));
  // PTX:1423 ld.global.f32 %f770, [%rd44]
  f770 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))));
  // PTX:1424 sub.f32 %f771, %f769, %f770
  asm("sub.f32 %0, %1, %2;" : "=f"(f771) : "f"(f769), "f"(f770));
  // PTX:1425 mov.b32 %f772, %r297
  asm("mov.b32 %0, %1;" : "=f"(f772) : "r"(r297));
  // PTX:1426 ld.global.f32 %f773, [%rd44+4]
  f773 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (4)))));
  // PTX:1427 sub.f32 %f774, %f772, %f773
  asm("sub.f32 %0, %1, %2;" : "=f"(f774) : "f"(f772), "f"(f773));
  // PTX:1428 mov.b32 %f775, %r298
  asm("mov.b32 %0, %1;" : "=f"(f775) : "r"(r298));
  // PTX:1429 ld.global.f32 %f776, [%rd44+8]
  f776 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (8)))));
  // PTX:1430 sub.f32 %f777, %f775, %f776
  asm("sub.f32 %0, %1, %2;" : "=f"(f777) : "f"(f775), "f"(f776));
  // PTX:1431 neg.f32 %f778, %f214
  asm("neg.f32 %0, %1;" : "=f"(f778) : "f"(f214));
  // PTX:1432 red.global.add.f32 [%rd221], %f778
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd221) + (0)))), (float)(f778));
  // PTX:1433 neg.f32 %f780, %f215
  asm("neg.f32 %0, %1;" : "=f"(f780) : "f"(f215));
  // PTX:1434 red.global.add.f32 [%rd222], %f780
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd222) + (0)))), (float)(f780));
  // PTX:1435 neg.f32 %f782, %f216
  asm("neg.f32 %0, %1;" : "=f"(f782) : "f"(f216));
  // PTX:1436 red.global.add.f32 [%rd223], %f782
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd223) + (0)))), (float)(f782));
  // PTX:1437 mul.f32 %f784, %f214, %f771
  asm("mul.f32 %0, %1, %2;" : "=f"(f784) : "f"(f214), "f"(f771));
  // PTX:1438 neg.f32 %f785, %f784
  asm("neg.f32 %0, %1;" : "=f"(f785) : "f"(f784));
  // PTX:1439 red.global.add.f32 [%rd225], %f785
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd225) + (0)))), (float)(f785));
  // PTX:1440 mul.f32 %f787, %f215, %f771
  asm("mul.f32 %0, %1, %2;" : "=f"(f787) : "f"(f215), "f"(f771));
  // PTX:1441 neg.f32 %f788, %f787
  asm("neg.f32 %0, %1;" : "=f"(f788) : "f"(f787));
  // PTX:1442 red.global.add.f32 [%rd226], %f788
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd226) + (0)))), (float)(f788));
  // PTX:1443 mul.f32 %f790, %f216, %f771
  asm("mul.f32 %0, %1, %2;" : "=f"(f790) : "f"(f216), "f"(f771));
  // PTX:1444 neg.f32 %f791, %f790
  asm("neg.f32 %0, %1;" : "=f"(f791) : "f"(f790));
  // PTX:1445 red.global.add.f32 [%rd227], %f791
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd227) + (0)))), (float)(f791));
  // PTX:1446 mul.f32 %f793, %f214, %f774
  asm("mul.f32 %0, %1, %2;" : "=f"(f793) : "f"(f214), "f"(f774));
  // PTX:1447 neg.f32 %f794, %f793
  asm("neg.f32 %0, %1;" : "=f"(f794) : "f"(f793));
  // PTX:1448 red.global.add.f32 [%rd229], %f794
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd229) + (0)))), (float)(f794));
  // PTX:1449 mul.f32 %f796, %f215, %f774
  asm("mul.f32 %0, %1, %2;" : "=f"(f796) : "f"(f215), "f"(f774));
  // PTX:1450 neg.f32 %f797, %f796
  asm("neg.f32 %0, %1;" : "=f"(f797) : "f"(f796));
  // PTX:1451 red.global.add.f32 [%rd230], %f797
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd230) + (0)))), (float)(f797));
  // PTX:1452 mul.f32 %f799, %f216, %f774
  asm("mul.f32 %0, %1, %2;" : "=f"(f799) : "f"(f216), "f"(f774));
  // PTX:1453 neg.f32 %f800, %f799
  asm("neg.f32 %0, %1;" : "=f"(f800) : "f"(f799));
  // PTX:1454 red.global.add.f32 [%rd231], %f800
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd231) + (0)))), (float)(f800));
  // PTX:1455 mul.f32 %f802, %f214, %f777
  asm("mul.f32 %0, %1, %2;" : "=f"(f802) : "f"(f214), "f"(f777));
  // PTX:1456 neg.f32 %f803, %f802
  asm("neg.f32 %0, %1;" : "=f"(f803) : "f"(f802));
  // PTX:1457 red.global.add.f32 [%rd233], %f803
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd233) + (0)))), (float)(f803));
  // PTX:1458 mul.f32 %f805, %f215, %f777
  asm("mul.f32 %0, %1, %2;" : "=f"(f805) : "f"(f215), "f"(f777));
  // PTX:1459 neg.f32 %f806, %f805
  asm("neg.f32 %0, %1;" : "=f"(f806) : "f"(f805));
  // PTX:1460 red.global.add.f32 [%rd234], %f806
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd234) + (0)))), (float)(f806));
  // PTX:1461 mul.f32 %f808, %f216, %f777
  asm("mul.f32 %0, %1, %2;" : "=f"(f808) : "f"(f216), "f"(f777));
  // PTX:1462 neg.f32 %f809, %f808
  asm("neg.f32 %0, %1;" : "=f"(f809) : "f"(f808));
  // PTX:1463 red.global.add.f32 [%rd235], %f809
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd235) + (0)))), (float)(f809));
  // PTX:1465 $L__BB3_110:
L_BB3_110:;
  // PTX:1466 ld.param.u64 %rd300, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_37]
  rd300 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param37 + (0))));
  // PTX:1467 setp.eq.s64 %p87, %rd300, 0
  p87 = (((long long)(rd300)) == ((long long)(0)));
  // PTX:1468 @%p87 bra $L__BB3_116
  if (p87) { goto L_BB3_116; }
  // PTX:1470 fma.rn.f32 %f981, %f205, %f257, %f204
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f981) : "f"(f205), "f"(f257), "f"(f204));
  // PTX:1471 mul.f32 %f224, %f980, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f224) : "f"(f980), "f"(f257));
  // PTX:1472 @%p45 bra $L__BB3_113
  if (p45) { goto L_BB3_113; }
  // PTX:1474 max.f32 %f981, %f981, %f224
  asm("max.f32 %0, %1, %2;" : "=f"(f981) : "f"(f981), "f"(f224));
  // PTX:1476 $L__BB3_113:
L_BB3_113:;
  // PTX:1477 ld.param.u64 %rd303, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_37]
  rd303 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param37 + (0))));
  // PTX:1478 cvta.to.global.u64 %rd302, %rd303
  rd302 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd303));
  // PTX:1479 cvt.s64.s32 %rd301, %r3
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd301) : "r"(r3));
  // PTX:1480 selp.f32 %f811, %f224, 0f00000000, %p45
  f811 = p45 ? f224 : as_f32(0x00000000u);
  // PTX:1481 add.f32 %f812, %f811, %f981
  asm("add.f32 %0, %1, %2;" : "=f"(f812) : "f"(f811), "f"(f981));
  // PTX:1482 shl.b64 %rd236, %rd301, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd236) : "l"(rd301));
  // PTX:1483 add.s64 %rd237, %rd302, %rd236
  asm("add.s64 %0, %1, %2;" : "=l"(rd237) : "l"(rd302), "l"(rd236));
  // PTX:1484 red.global.add.f32 [%rd237], %f812
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd237) + (0)))), (float)(f812));
  // PTX:1485 @%p38 bra $L__BB3_116
  if (p38) { goto L_BB3_116; }
  // PTX:1487 ld.param.u64 %rd305, [_ZN7synreal6kernel27evaluate_soft_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_PKfSA_S2_mmS2_S2_PKNS_9TransformES8_SA_SA_SA_SA_SA_mmmffffS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_S8_fPS6_PfS2_mPNS3_3matILi3ELi3EfLS5_0EEESL__param_37]
  rd305 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param37 + (0))));
  // PTX:1488 cvta.to.global.u64 %rd304, %rd305
  rd304 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd305));
  // PTX:1489 mov.b32 %f814, %r18
  asm("mov.b32 %0, %1;" : "=f"(f814) : "r"(r18));
  // PTX:1490 ld.global.f32 %f815, [%rd44]
  f815 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))));
  // PTX:1491 sub.f32 %f816, %f814, %f815
  asm("sub.f32 %0, %1, %2;" : "=f"(f816) : "f"(f814), "f"(f815));
  // PTX:1492 mov.b32 %f817, %r19
  asm("mov.b32 %0, %1;" : "=f"(f817) : "r"(r19));
  // PTX:1493 ld.global.f32 %f818, [%rd44+4]
  f818 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (4)))));
  // PTX:1494 sub.f32 %f819, %f817, %f818
  asm("sub.f32 %0, %1, %2;" : "=f"(f819) : "f"(f817), "f"(f818));
  // PTX:1495 mov.b32 %f820, %r20
  asm("mov.b32 %0, %1;" : "=f"(f820) : "r"(r20));
  // PTX:1496 ld.global.f32 %f821, [%rd44+8]
  f821 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (8)))));
  // PTX:1497 sub.f32 %f822, %f820, %f821
  asm("sub.f32 %0, %1, %2;" : "=f"(f822) : "f"(f820), "f"(f821));
  // PTX:1498 mul.wide.s32 %rd238, %r255, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd238) : "r"(r255));
  // PTX:1499 add.s64 %rd59, %rd304, %rd238
  asm("add.s64 %0, %1, %2;" : "=l"(rd59) : "l"(rd304), "l"(rd238));
  // PTX:1500 red.global.add.f32 [%rd59], %f981
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))), (float)(f981));
  // PTX:1501 mul.wide.s32 %rd239, %r256, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd239) : "r"(r256));
  // PTX:1502 add.s64 %rd60, %rd304, %rd239
  asm("add.s64 %0, %1, %2;" : "=l"(rd60) : "l"(rd304), "l"(rd239));
  // PTX:1503 mul.f32 %f824, %f981, %f816
  asm("mul.f32 %0, %1, %2;" : "=f"(f824) : "f"(f981), "f"(f816));
  // PTX:1504 mul.f32 %f825, %f816, %f824
  asm("mul.f32 %0, %1, %2;" : "=f"(f825) : "f"(f816), "f"(f824));
  // PTX:1505 red.global.add.f32 [%rd60], %f825
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))), (float)(f825));
  // PTX:1506 mul.wide.s32 %rd240, %r257, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd240) : "r"(r257));
  // PTX:1507 add.s64 %rd61, %rd304, %rd240
  asm("add.s64 %0, %1, %2;" : "=l"(rd61) : "l"(rd304), "l"(rd240));
  // PTX:1508 mul.f32 %f827, %f981, %f819
  asm("mul.f32 %0, %1, %2;" : "=f"(f827) : "f"(f981), "f"(f819));
  // PTX:1509 mul.f32 %f828, %f819, %f827
  asm("mul.f32 %0, %1, %2;" : "=f"(f828) : "f"(f819), "f"(f827));
  // PTX:1510 red.global.add.f32 [%rd61], %f828
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))), (float)(f828));
  // PTX:1511 mul.wide.s32 %rd241, %r258, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd241) : "r"(r258));
  // PTX:1512 add.s64 %rd62, %rd304, %rd241
  asm("add.s64 %0, %1, %2;" : "=l"(rd62) : "l"(rd304), "l"(rd241));
  // PTX:1513 mul.f32 %f830, %f981, %f822
  asm("mul.f32 %0, %1, %2;" : "=f"(f830) : "f"(f981), "f"(f822));
  // PTX:1514 mul.f32 %f831, %f822, %f830
  asm("mul.f32 %0, %1, %2;" : "=f"(f831) : "f"(f822), "f"(f830));
  // PTX:1515 red.global.add.f32 [%rd62], %f831
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))), (float)(f831));
  // PTX:1516 setp.leu.f32 %p92, %f224, 0f00000000
  p92 = ((isnan(((float)(f224))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f224)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1517 or.pred %p93, %p71, %p92
  p93 = ((p71) || (p92));
  // PTX:1518 @%p93 bra $L__BB3_116
  if (p93) { goto L_BB3_116; }
  // PTX:1520 ld.global.f32 %f833, [%rd44]
  f833 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))));
  // PTX:1521 mov.b32 %f834, %r296
  asm("mov.b32 %0, %1;" : "=f"(f834) : "r"(r296));
  // PTX:1522 sub.f32 %f835, %f834, %f833
  asm("sub.f32 %0, %1, %2;" : "=f"(f835) : "f"(f834), "f"(f833));
  // PTX:1523 mov.b32 %f836, %r297
  asm("mov.b32 %0, %1;" : "=f"(f836) : "r"(r297));
  // PTX:1524 ld.global.f32 %f837, [%rd44+4]
  f837 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (4)))));
  // PTX:1525 sub.f32 %f838, %f836, %f837
  asm("sub.f32 %0, %1, %2;" : "=f"(f838) : "f"(f836), "f"(f837));
  // PTX:1526 mov.b32 %f839, %r298
  asm("mov.b32 %0, %1;" : "=f"(f839) : "r"(r298));
  // PTX:1527 ld.global.f32 %f840, [%rd44+8]
  f840 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (8)))));
  // PTX:1528 sub.f32 %f841, %f839, %f840
  asm("sub.f32 %0, %1, %2;" : "=f"(f841) : "f"(f839), "f"(f840));
  // PTX:1529 red.global.add.f32 [%rd59], %f224
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))), (float)(f224));
  // PTX:1530 mul.f32 %f843, %f224, %f835
  asm("mul.f32 %0, %1, %2;" : "=f"(f843) : "f"(f224), "f"(f835));
  // PTX:1531 mul.f32 %f844, %f835, %f843
  asm("mul.f32 %0, %1, %2;" : "=f"(f844) : "f"(f835), "f"(f843));
  // PTX:1532 red.global.add.f32 [%rd60], %f844
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))), (float)(f844));
  // PTX:1533 mul.f32 %f846, %f224, %f838
  asm("mul.f32 %0, %1, %2;" : "=f"(f846) : "f"(f224), "f"(f838));
  // PTX:1534 mul.f32 %f847, %f838, %f846
  asm("mul.f32 %0, %1, %2;" : "=f"(f847) : "f"(f838), "f"(f846));
  // PTX:1535 red.global.add.f32 [%rd61], %f847
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))), (float)(f847));
  // PTX:1536 mul.f32 %f849, %f224, %f841
  asm("mul.f32 %0, %1, %2;" : "=f"(f849) : "f"(f224), "f"(f841));
  // PTX:1537 mul.f32 %f850, %f841, %f849
  asm("mul.f32 %0, %1, %2;" : "=f"(f850) : "f"(f841), "f"(f849));
  // PTX:1538 red.global.add.f32 [%rd62], %f850
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))), (float)(f850));
  // PTX:1540 $L__BB3_116:
L_BB3_116:;
  // PTX:1541 or.b64 %rd242, %rd108, %rd109
  asm("or.b64 %0, %1, %2;" : "=l"(rd242) : "l"(rd108), "l"(rd109));
  // PTX:1542 setp.eq.s64 %p94, %rd242, 0
  p94 = (((long long)(rd242)) == ((long long)(0)));
  // PTX:1543 @%p94 bra $L__BB3_145
  if (p94) { goto L_BB3_145; }
  // PTX:1545 add.u64 %rd333, %SPL, 40
  asm("add.u64 %0, %1, 40;" : "=l"(rd333) : "l"(SPL));
  // PTX:1546 add.u64 %rd331, %SPL, 20
  asm("add.u64 %0, %1, 20;" : "=l"(rd331) : "l"(SPL));
  // PTX:1547 add.u64 %rd329, %SPL, 0
  asm("add.u64 %0, %1, 0;" : "=l"(rd329) : "l"(SPL));
  // PTX:1548 mov.u32 %r312, 0
  asm("mov.u32 %0, 0;" : "=r"(r312) : );
  // PTX:1549 st.local.u32 [%rd329+4], %r312
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd329) + (4))))) = (unsigned)(r312);
  // PTX:1550 st.local.u32 [%rd329+8], %r312
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd329) + (8))))) = (unsigned)(r312);
  // PTX:1551 st.local.u32 [%rd329+12], %r312
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd329) + (12))))) = (unsigned)(r312);
  // PTX:1552 st.local.u32 [%rd329+16], %r312
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd329) + (16))))) = (unsigned)(r312);
  // PTX:1553 fma.rn.f32 %f227, %f205, %f257, %f204
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f227) : "f"(f205), "f"(f257), "f"(f204));
  // PTX:1554 mul.f32 %f228, %f980, %f257
  asm("mul.f32 %0, %1, %2;" : "=f"(f228) : "f"(f980), "f"(f257));
  // PTX:1555 mul.f32 %f229, %f951, %f952
  asm("mul.f32 %0, %1, %2;" : "=f"(f229) : "f"(f951), "f"(f952));
  // PTX:1556 mul.f32 %f230, %f950, %f952
  asm("mul.f32 %0, %1, %2;" : "=f"(f230) : "f"(f950), "f"(f952));
  // PTX:1557 mul.f32 %f231, %f950, %f951
  asm("mul.f32 %0, %1, %2;" : "=f"(f231) : "f"(f950), "f"(f951));
  // PTX:1558 st.local.u32 [%rd329], %r3
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd329) + (0))))) = (unsigned)(r3);
  // PTX:1559 mov.u32 %r244, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r244) : );
  // PTX:1560 st.local.u32 [%rd331], %r244
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd331) + (0))))) = (unsigned)(r244);
  // PTX:1561 st.local.u32 [%rd331+4], %r312
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd331) + (4))))) = (unsigned)(r312);
  // PTX:1562 st.local.u32 [%rd331+8], %r312
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd331) + (8))))) = (unsigned)(r312);
  // PTX:1563 st.local.u32 [%rd331+12], %r312
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd331) + (12))))) = (unsigned)(r312);
  // PTX:1564 st.local.u32 [%rd331+16], %r312
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd331) + (16))))) = (unsigned)(r312);
  // PTX:1565 st.local.u32 [%rd333], %r244
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd333) + (0))))) = (unsigned)(r244);
  // PTX:1566 st.local.u32 [%rd333+4], %r312
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd333) + (4))))) = (unsigned)(r312);
  // PTX:1567 st.local.u32 [%rd333+8], %r312
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd333) + (8))))) = (unsigned)(r312);
  // PTX:1568 st.local.u32 [%rd333+12], %r312
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd333) + (12))))) = (unsigned)(r312);
  // PTX:1569 st.local.u32 [%rd333+16], %r312
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd333) + (16))))) = (unsigned)(r312);
  // PTX:1570 mov.u32 %r311, 1
  asm("mov.u32 %0, 1;" : "=r"(r311) : );
  // PTX:1571 @%p38 bra $L__BB3_119
  if (p38) { goto L_BB3_119; }
  // PTX:1573 add.u64 %rd345, %SPL, 40
  asm("add.u64 %0, %1, 40;" : "=l"(rd345) : "l"(SPL));
  // PTX:1574 add.u64 %rd343, %SPL, 20
  asm("add.u64 %0, %1, 20;" : "=l"(rd343) : "l"(SPL));
  // PTX:1575 add.u64 %rd341, %SPL, 0
  asm("add.u64 %0, %1, 0;" : "=l"(rd341) : "l"(SPL));
  // PTX:1576 ld.global.f32 %f852, [%rd44]
  f852 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))));
  // PTX:1577 mov.b32 %f853, %r18
  asm("mov.b32 %0, %1;" : "=f"(f853) : "r"(r18));
  // PTX:1578 sub.f32 %f854, %f853, %f852
  asm("sub.f32 %0, %1, %2;" : "=f"(f854) : "f"(f853), "f"(f852));
  // PTX:1579 mov.b32 %f855, %r19
  asm("mov.b32 %0, %1;" : "=f"(f855) : "r"(r19));
  // PTX:1580 ld.global.f32 %f856, [%rd44+4]
  f856 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (4)))));
  // PTX:1581 sub.f32 %f857, %f855, %f856
  asm("sub.f32 %0, %1, %2;" : "=f"(f857) : "f"(f855), "f"(f856));
  // PTX:1582 mov.b32 %f858, %r20
  asm("mov.b32 %0, %1;" : "=f"(f858) : "r"(r20));
  // PTX:1583 ld.global.f32 %f859, [%rd44+8]
  f859 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (8)))));
  // PTX:1584 sub.f32 %f860, %f858, %f859
  asm("sub.f32 %0, %1, %2;" : "=f"(f860) : "f"(f858), "f"(f859));
  // PTX:1585 mov.u32 %r246, -1082130432
  asm("mov.u32 %0, -1082130432;" : "=r"(r246) : );
  // PTX:1586 st.local.u32 [%rd343+4], %r246
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd343) + (4))))) = (unsigned)(r246);
  // PTX:1587 neg.f32 %f861, %f854
  asm("neg.f32 %0, %1;" : "=f"(f861) : "f"(f854));
  // PTX:1588 st.local.f32 [%rd343+8], %f861
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd343) + (8))))) = (float)(f861);
  // PTX:1589 neg.f32 %f862, %f857
  asm("neg.f32 %0, %1;" : "=f"(f862) : "f"(f857));
  // PTX:1590 st.local.f32 [%rd343+12], %f862
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd343) + (12))))) = (float)(f862);
  // PTX:1591 neg.f32 %f863, %f860
  asm("neg.f32 %0, %1;" : "=f"(f863) : "f"(f860));
  // PTX:1592 st.local.f32 [%rd343+16], %f863
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd343) + (16))))) = (float)(f863);
  // PTX:1593 mov.b32 %f864, %r296
  asm("mov.b32 %0, %1;" : "=f"(f864) : "r"(r296));
  // PTX:1594 sub.f32 %f865, %f864, %f852
  asm("sub.f32 %0, %1, %2;" : "=f"(f865) : "f"(f864), "f"(f852));
  // PTX:1595 mov.b32 %f866, %r297
  asm("mov.b32 %0, %1;" : "=f"(f866) : "r"(r297));
  // PTX:1596 sub.f32 %f867, %f866, %f856
  asm("sub.f32 %0, %1, %2;" : "=f"(f867) : "f"(f866), "f"(f856));
  // PTX:1597 mov.b32 %f868, %r298
  asm("mov.b32 %0, %1;" : "=f"(f868) : "r"(r298));
  // PTX:1598 sub.f32 %f869, %f868, %f859
  asm("sub.f32 %0, %1, %2;" : "=f"(f869) : "f"(f868), "f"(f859));
  // PTX:1599 st.local.u32 [%rd341+4], %r255
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd341) + (4))))) = (unsigned)(r255);
  // PTX:1600 st.local.u32 [%rd345+4], %r246
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd345) + (4))))) = (unsigned)(r246);
  // PTX:1601 st.local.u32 [%rd341+8], %r256
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd341) + (8))))) = (unsigned)(r256);
  // PTX:1602 neg.f32 %f870, %f865
  asm("neg.f32 %0, %1;" : "=f"(f870) : "f"(f865));
  // PTX:1603 st.local.f32 [%rd345+8], %f870
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd345) + (8))))) = (float)(f870);
  // PTX:1604 st.local.u32 [%rd341+12], %r257
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd341) + (12))))) = (unsigned)(r257);
  // PTX:1605 neg.f32 %f871, %f867
  asm("neg.f32 %0, %1;" : "=f"(f871) : "f"(f867));
  // PTX:1606 st.local.f32 [%rd345+12], %f871
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd345) + (12))))) = (float)(f871);
  // PTX:1607 st.local.u32 [%rd341+16], %r258
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd341) + (16))))) = (unsigned)(r258);
  // PTX:1608 neg.f32 %f872, %f869
  asm("neg.f32 %0, %1;" : "=f"(f872) : "f"(f869));
  // PTX:1609 st.local.f32 [%rd345+16], %f872
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd345) + (16))))) = (float)(f872);
  // PTX:1610 mov.u32 %r311, 5
  asm("mov.u32 %0, 5;" : "=r"(r311) : );
  // PTX:1612 $L__BB3_119:
L_BB3_119:;
  // PTX:1613 add.u64 %rd372, %SPL, 40
  asm("add.u64 %0, %1, 40;" : "=l"(rd372) : "l"(SPL));
  // PTX:1614 add.u64 %rd371, %SPL, 20
  asm("add.u64 %0, %1, 20;" : "=l"(rd371) : "l"(SPL));
  // PTX:1615 add.u64 %rd373, %SPL, 0
  asm("add.u64 %0, %1, 0;" : "=l"(rd373) : "l"(SPL));
  // PTX:1616 cvta.to.global.u64 %rd66, %rd108
  rd66 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd108));
  // PTX:1617 mov.f32 %f873, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f873) : );
  // PTX:1618 sub.f32 %f232, %f873, %f112
  asm("sub.f32 %0, %1, %2;" : "=f"(f232) : "f"(f873), "f"(f112));
  // PTX:1619 mov.f32 %f874, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f874) : );
  // PTX:1620 sub.f32 %f233, %f874, %f231
  asm("sub.f32 %0, %1, %2;" : "=f"(f233) : "f"(f874), "f"(f231));
  // PTX:1621 sub.f32 %f234, %f873, %f110
  asm("sub.f32 %0, %1, %2;" : "=f"(f234) : "f"(f873), "f"(f110));
  // PTX:1622 sub.f32 %f235, %f874, %f230
  asm("sub.f32 %0, %1, %2;" : "=f"(f235) : "f"(f874), "f"(f230));
  // PTX:1623 sub.f32 %f236, %f874, %f229
  asm("sub.f32 %0, %1, %2;" : "=f"(f236) : "f"(f874), "f"(f229));
  // PTX:1624 sub.f32 %f237, %f873, %f111
  asm("sub.f32 %0, %1, %2;" : "=f"(f237) : "f"(f873), "f"(f111));
  // PTX:1625 setp.gt.f32 %p96, %f206, 0f00000000
  p96 = (!(isnan(((float)(f206))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f206)) > ((float)(as_f32(0x00000000u)))));
  // PTX:1626 selp.f32 %f238, %f227, 0f00000000, %p96
  f238 = p96 ? f227 : as_f32(0x00000000u);
  // PTX:1628 $L__BB3_120:
L_BB3_120:;
  // PTX:1629 ld.local.f32 %f875, [%rd371]
  f875 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd371) + (0)))));
  // PTX:1630 mul.f32 %f239, %f875, %f875
  asm("mul.f32 %0, %1, %2;" : "=f"(f239) : "f"(f875), "f"(f875));
  // PTX:1631 ld.local.f32 %f876, [%rd372]
  f876 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd372) + (0)))));
  // PTX:1632 mul.f32 %f240, %f876, %f876
  asm("mul.f32 %0, %1, %2;" : "=f"(f240) : "f"(f876), "f"(f876));
  // PTX:1633 @%p45 bra $L__BB3_122
  if (p45) { goto L_BB3_122; }
  // PTX:1634 bra.uni $L__BB3_121
  goto L_BB3_121;
  // PTX:1636 $L__BB3_122:
L_BB3_122:;
  // PTX:1637 mul.f32 %f982, %f228, %f240
  asm("mul.f32 %0, %1, %2;" : "=f"(f982) : "f"(f228), "f"(f240));
  // PTX:1638 fma.rn.f32 %f983, %f227, %f239, %f982
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f983) : "f"(f227), "f"(f239), "f"(f982));
  // PTX:1639 bra.uni $L__BB3_123
  goto L_BB3_123;
  // PTX:1641 $L__BB3_121:
L_BB3_121:;
  // PTX:1642 max.f32 %f877, %f227, %f228
  asm("max.f32 %0, %1, %2;" : "=f"(f877) : "f"(f227), "f"(f228));
  // PTX:1643 mul.f32 %f983, %f239, %f877
  asm("mul.f32 %0, %1, %2;" : "=f"(f983) : "f"(f239), "f"(f877));
  // PTX:1644 mul.f32 %f982, %f228, %f240
  asm("mul.f32 %0, %1, %2;" : "=f"(f982) : "f"(f228), "f"(f240));
  // PTX:1646 $L__BB3_123:
L_BB3_123:;
  // PTX:1647 mul.f32 %f878, %f238, %f239
  asm("mul.f32 %0, %1, %2;" : "=f"(f878) : "f"(f238), "f"(f239));
  // PTX:1648 mul.f32 %f879, %f237, %f982
  asm("mul.f32 %0, %1, %2;" : "=f"(f879) : "f"(f237), "f"(f982));
  // PTX:1649 fma.rn.f32 %f880, %f878, %f111, %f879
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f880) : "f"(f878), "f"(f111), "f"(f879));
  // PTX:1650 mul.f32 %f881, %f236, %f982
  asm("mul.f32 %0, %1, %2;" : "=f"(f881) : "f"(f236), "f"(f982));
  // PTX:1651 fma.rn.f32 %f882, %f878, %f229, %f881
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f882) : "f"(f878), "f"(f229), "f"(f881));
  // PTX:1652 mul.f32 %f883, %f235, %f982
  asm("mul.f32 %0, %1, %2;" : "=f"(f883) : "f"(f235), "f"(f982));
  // PTX:1653 fma.rn.f32 %f884, %f878, %f230, %f883
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f884) : "f"(f878), "f"(f230), "f"(f883));
  // PTX:1654 mul.f32 %f885, %f234, %f982
  asm("mul.f32 %0, %1, %2;" : "=f"(f885) : "f"(f234), "f"(f982));
  // PTX:1655 fma.rn.f32 %f886, %f878, %f110, %f885
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f886) : "f"(f878), "f"(f110), "f"(f885));
  // PTX:1656 mul.f32 %f887, %f233, %f982
  asm("mul.f32 %0, %1, %2;" : "=f"(f887) : "f"(f233), "f"(f982));
  // PTX:1657 fma.rn.f32 %f888, %f878, %f231, %f887
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f888) : "f"(f878), "f"(f231), "f"(f887));
  // PTX:1658 mul.f32 %f889, %f232, %f982
  asm("mul.f32 %0, %1, %2;" : "=f"(f889) : "f"(f232), "f"(f982));
  // PTX:1659 fma.rn.f32 %f890, %f878, %f112, %f889
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f890) : "f"(f878), "f"(f112), "f"(f889));
  // PTX:1660 sub.f32 %f247, %f880, %f983
  asm("sub.f32 %0, %1, %2;" : "=f"(f247) : "f"(f880), "f"(f983));
  // PTX:1661 mul.f32 %f891, %f983, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f891) : "f"(f983));
  // PTX:1662 sub.f32 %f248, %f882, %f891
  asm("sub.f32 %0, %1, %2;" : "=f"(f248) : "f"(f882), "f"(f891));
  // PTX:1663 sub.f32 %f249, %f884, %f891
  asm("sub.f32 %0, %1, %2;" : "=f"(f249) : "f"(f884), "f"(f891));
  // PTX:1664 sub.f32 %f250, %f886, %f983
  asm("sub.f32 %0, %1, %2;" : "=f"(f250) : "f"(f886), "f"(f983));
  // PTX:1665 sub.f32 %f251, %f888, %f891
  asm("sub.f32 %0, %1, %2;" : "=f"(f251) : "f"(f888), "f"(f891));
  // PTX:1666 sub.f32 %f252, %f890, %f983
  asm("sub.f32 %0, %1, %2;" : "=f"(f252) : "f"(f890), "f"(f983));
  // PTX:1667 setp.eq.s64 %p98, %rd108, 0
  p98 = (((long long)(rd108)) == ((long long)(0)));
  // PTX:1668 @%p98 bra $L__BB3_142
  if (p98) { goto L_BB3_142; }
  // PTX:1670 setp.eq.s64 %p100, %rd109, 0
  p100 = (((long long)(rd109)) == ((long long)(0)));
  // PTX:1671 ld.local.u32 %r248, [%rd373]
  r248 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd373) + (0)))));
  // PTX:1672 cvt.s64.s32 %rd71, %r248
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd71) : "r"(r248));
  // PTX:1673 mul.wide.s32 %rd243, %r248, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd243) : "r"(r248));
  // PTX:1674 add.s64 %rd72, %rd66, %rd243
  asm("add.s64 %0, %1, %2;" : "=l"(rd72) : "l"(rd66), "l"(rd243));
  // PTX:1675 red.global.add.f32 [%rd72], %f247
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (0)))), (float)(f247));
  // PTX:1676 mov.pred %p115, -1
  p115 = ((-1) != 0);
  // PTX:1677 @%p100 bra $L__BB3_126
  if (p100) { goto L_BB3_126; }
  // PTX:1679 mul.lo.s64 %rd244, %rd71, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd244) : "l"(rd71));
  // PTX:1680 add.s64 %rd245, %rd1, %rd244
  asm("add.s64 %0, %1, %2;" : "=l"(rd245) : "l"(rd1), "l"(rd244));
  // PTX:1681 red.global.add.f32 [%rd245], %f247
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd245) + (0)))), (float)(f247));
  // PTX:1682 mov.pred %p115, 0
  p115 = ((0) != 0);
  // PTX:1684 $L__BB3_126:
L_BB3_126:;
  // PTX:1685 add.s64 %rd246, %rd72, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd246) : "l"(rd72));
  // PTX:1686 red.global.add.f32 [%rd246], %f248
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd246) + (0)))), (float)(f248));
  // PTX:1687 @%p115 bra $L__BB3_128
  if (p115) { goto L_BB3_128; }
  // PTX:1689 mul.lo.s64 %rd247, %rd71, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd247) : "l"(rd71));
  // PTX:1690 add.s64 %rd248, %rd1, %rd247
  asm("add.s64 %0, %1, %2;" : "=l"(rd248) : "l"(rd1), "l"(rd247));
  // PTX:1691 add.s64 %rd249, %rd248, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd249) : "l"(rd248));
  // PTX:1692 red.global.add.f32 [%rd249], %f248
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd249) + (0)))), (float)(f248));
  // PTX:1694 $L__BB3_128:
L_BB3_128:;
  // PTX:1695 add.s64 %rd250, %rd72, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd250) : "l"(rd72));
  // PTX:1696 red.global.add.f32 [%rd250], %f249
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd250) + (0)))), (float)(f249));
  // PTX:1697 mov.pred %p117, -1
  p117 = ((-1) != 0);
  // PTX:1698 mov.pred %p116, %p117
  p116 = ((p117) != 0);
  // PTX:1699 @%p100 bra $L__BB3_130
  if (p100) { goto L_BB3_130; }
  // PTX:1701 mul.lo.s64 %rd251, %rd71, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd251) : "l"(rd71));
  // PTX:1702 add.s64 %rd252, %rd1, %rd251
  asm("add.s64 %0, %1, %2;" : "=l"(rd252) : "l"(rd1), "l"(rd251));
  // PTX:1703 add.s64 %rd253, %rd252, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd253) : "l"(rd252));
  // PTX:1704 red.global.add.f32 [%rd253], %f249
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd253) + (0)))), (float)(f249));
  // PTX:1705 mov.pred %p116, 0
  p116 = ((0) != 0);
  // PTX:1707 $L__BB3_130:
L_BB3_130:;
  // PTX:1708 add.s64 %rd254, %rd72, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd254) : "l"(rd72));
  // PTX:1709 red.global.add.f32 [%rd254], %f248
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd254) + (0)))), (float)(f248));
  // PTX:1710 @%p116 bra $L__BB3_132
  if (p116) { goto L_BB3_132; }
  // PTX:1712 mul.lo.s64 %rd255, %rd71, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd255) : "l"(rd71));
  // PTX:1713 add.s64 %rd256, %rd1, %rd255
  asm("add.s64 %0, %1, %2;" : "=l"(rd256) : "l"(rd1), "l"(rd255));
  // PTX:1714 add.s64 %rd257, %rd256, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd257) : "l"(rd256));
  // PTX:1715 red.global.add.f32 [%rd257], %f248
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd257) + (0)))), (float)(f248));
  // PTX:1716 mov.pred %p117, 0
  p117 = ((0) != 0);
  // PTX:1718 $L__BB3_132:
L_BB3_132:;
  // PTX:1719 add.s64 %rd258, %rd72, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd258) : "l"(rd72));
  // PTX:1720 red.global.add.f32 [%rd258], %f250
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd258) + (0)))), (float)(f250));
  // PTX:1721 @%p117 bra $L__BB3_134
  if (p117) { goto L_BB3_134; }
  // PTX:1723 mul.lo.s64 %rd259, %rd71, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd259) : "l"(rd71));
  // PTX:1724 add.s64 %rd260, %rd1, %rd259
  asm("add.s64 %0, %1, %2;" : "=l"(rd260) : "l"(rd1), "l"(rd259));
  // PTX:1725 add.s64 %rd261, %rd260, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd261) : "l"(rd260));
  // PTX:1726 red.global.add.f32 [%rd261], %f250
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd261) + (0)))), (float)(f250));
  // PTX:1728 $L__BB3_134:
L_BB3_134:;
  // PTX:1729 add.s64 %rd262, %rd72, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd262) : "l"(rd72));
  // PTX:1730 red.global.add.f32 [%rd262], %f251
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd262) + (0)))), (float)(f251));
  // PTX:1731 mov.pred %p119, -1
  p119 = ((-1) != 0);
  // PTX:1732 mov.pred %p118, %p119
  p118 = ((p119) != 0);
  // PTX:1733 @%p100 bra $L__BB3_136
  if (p100) { goto L_BB3_136; }
  // PTX:1735 mul.lo.s64 %rd263, %rd71, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd263) : "l"(rd71));
  // PTX:1736 add.s64 %rd264, %rd1, %rd263
  asm("add.s64 %0, %1, %2;" : "=l"(rd264) : "l"(rd1), "l"(rd263));
  // PTX:1737 add.s64 %rd265, %rd264, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd265) : "l"(rd264));
  // PTX:1738 red.global.add.f32 [%rd265], %f251
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd265) + (0)))), (float)(f251));
  // PTX:1739 mov.pred %p118, 0
  p118 = ((0) != 0);
  // PTX:1741 $L__BB3_136:
L_BB3_136:;
  // PTX:1742 add.s64 %rd266, %rd72, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd266) : "l"(rd72));
  // PTX:1743 red.global.add.f32 [%rd266], %f249
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd266) + (0)))), (float)(f249));
  // PTX:1744 @%p118 bra $L__BB3_138
  if (p118) { goto L_BB3_138; }
  // PTX:1746 mul.lo.s64 %rd267, %rd71, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd267) : "l"(rd71));
  // PTX:1747 add.s64 %rd268, %rd1, %rd267
  asm("add.s64 %0, %1, %2;" : "=l"(rd268) : "l"(rd1), "l"(rd267));
  // PTX:1748 add.s64 %rd269, %rd268, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd269) : "l"(rd268));
  // PTX:1749 red.global.add.f32 [%rd269], %f249
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd269) + (0)))), (float)(f249));
  // PTX:1750 mov.pred %p119, 0
  p119 = ((0) != 0);
  // PTX:1752 $L__BB3_138:
L_BB3_138:;
  // PTX:1753 add.s64 %rd270, %rd72, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd270) : "l"(rd72));
  // PTX:1754 red.global.add.f32 [%rd270], %f251
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd270) + (0)))), (float)(f251));
  // PTX:1755 @%p119 bra $L__BB3_140
  if (p119) { goto L_BB3_140; }
  // PTX:1757 mul.lo.s64 %rd271, %rd71, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd271) : "l"(rd71));
  // PTX:1758 add.s64 %rd272, %rd1, %rd271
  asm("add.s64 %0, %1, %2;" : "=l"(rd272) : "l"(rd1), "l"(rd271));
  // PTX:1759 add.s64 %rd273, %rd272, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd273) : "l"(rd272));
  // PTX:1760 red.global.add.f32 [%rd273], %f251
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd273) + (0)))), (float)(f251));
  // PTX:1762 $L__BB3_140:
L_BB3_140:;
  // PTX:1763 add.s64 %rd274, %rd72, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd274) : "l"(rd72));
  // PTX:1764 red.global.add.f32 [%rd274], %f252
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd274) + (0)))), (float)(f252));
  // PTX:1765 @%p100 bra $L__BB3_144
  if (p100) { goto L_BB3_144; }
  // PTX:1767 mul.lo.s64 %rd275, %rd71, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd275) : "l"(rd71));
  // PTX:1768 add.s64 %rd276, %rd1, %rd275
  asm("add.s64 %0, %1, %2;" : "=l"(rd276) : "l"(rd1), "l"(rd275));
  // PTX:1769 add.s64 %rd277, %rd276, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd277) : "l"(rd276));
  // PTX:1770 red.global.add.f32 [%rd277], %f252
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd277) + (0)))), (float)(f252));
  // PTX:1771 bra.uni $L__BB3_144
  goto L_BB3_144;
  // PTX:1773 $L__BB3_142:
L_BB3_142:;
  // PTX:1774 setp.eq.s64 %p113, %rd109, 0
  p113 = (((long long)(rd109)) == ((long long)(0)));
  // PTX:1775 @%p113 bra $L__BB3_144
  if (p113) { goto L_BB3_144; }
  // PTX:1777 ld.local.u32 %r249, [%rd373]
  r249 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd373) + (0)))));
  // PTX:1778 mul.wide.s32 %rd278, %r249, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd278) : "r"(r249));
  // PTX:1779 add.s64 %rd279, %rd1, %rd278
  asm("add.s64 %0, %1, %2;" : "=l"(rd279) : "l"(rd1), "l"(rd278));
  // PTX:1780 red.global.add.f32 [%rd279], %f247
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd279) + (0)))), (float)(f247));
  // PTX:1781 add.s64 %rd280, %rd279, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd280) : "l"(rd279));
  // PTX:1782 red.global.add.f32 [%rd280], %f248
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd280) + (0)))), (float)(f248));
  // PTX:1783 add.s64 %rd281, %rd279, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd281) : "l"(rd279));
  // PTX:1784 red.global.add.f32 [%rd281], %f249
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd281) + (0)))), (float)(f249));
  // PTX:1785 add.s64 %rd282, %rd279, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd282) : "l"(rd279));
  // PTX:1786 red.global.add.f32 [%rd282], %f248
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd282) + (0)))), (float)(f248));
  // PTX:1787 add.s64 %rd283, %rd279, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd283) : "l"(rd279));
  // PTX:1788 red.global.add.f32 [%rd283], %f250
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd283) + (0)))), (float)(f250));
  // PTX:1789 add.s64 %rd284, %rd279, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd284) : "l"(rd279));
  // PTX:1790 red.global.add.f32 [%rd284], %f251
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd284) + (0)))), (float)(f251));
  // PTX:1791 add.s64 %rd285, %rd279, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd285) : "l"(rd279));
  // PTX:1792 red.global.add.f32 [%rd285], %f249
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd285) + (0)))), (float)(f249));
  // PTX:1793 add.s64 %rd286, %rd279, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd286) : "l"(rd279));
  // PTX:1794 red.global.add.f32 [%rd286], %f251
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd286) + (0)))), (float)(f251));
  // PTX:1795 add.s64 %rd287, %rd279, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd287) : "l"(rd279));
  // PTX:1796 red.global.add.f32 [%rd287], %f252
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd287) + (0)))), (float)(f252));
  // PTX:1798 $L__BB3_144:
L_BB3_144:;
  // PTX:1799 add.s32 %r312, %r312, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r312) : "r"(r312));
  // PTX:1800 add.s64 %rd373, %rd373, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd373) : "l"(rd373));
  // PTX:1801 add.s64 %rd372, %rd372, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd372) : "l"(rd372));
  // PTX:1802 add.s64 %rd371, %rd371, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd371) : "l"(rd371));
  // PTX:1803 setp.lt.u32 %p114, %r312, %r311
  p114 = (((unsigned)(r312)) < ((unsigned)(r311)));
  // PTX:1804 @%p114 bra $L__BB3_120
  if (p114) { goto L_BB3_120; }
  // PTX:1806 $L__BB3_145:
L_BB3_145:;
  // PTX:1807 ret
  return;
}
