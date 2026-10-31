// 机械还原自 PTX：synreal::kernel::add_body_spring_gauss_newton_hessian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)
// PTX SHA256: f949a4ebcb7ea149a9c684e5546dd47eebecee7fbf38fea69193575994c6e86b
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__add_body_spring_gauss_newton_hessian(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10, unsigned long long param11, unsigned long long param12, unsigned long long param13, unsigned long long param14, unsigned long long param15, unsigned long long param16) {
  unsigned long long SP, SPL, rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135, rd136, rd137, rd138, rd139, rd140, rd141, rd142, rd143, rd144, rd145, rd146, rd147, rd148, rd149, rd150, rd151, rd152, rd153, rd154, rd155, rd156, rd157, rd158, rd159, rd160, rd161, rd162, rd163, rd164, rd165, rd166, rd167, rd168, rd169, rd170, rd171, rd172, rd173, rd174, rd175, rd176, rd177, rd178, rd179, rd180, rd181, rd182, rd183, rd184, rd185, rd186, rd187, rd188, rd189, rd190, rd191, rd192, rd193, rd194, rd195, rd196, rd197, rd198, rd199, rd200, rd201, rd202, rd203, rd204, rd205, rd206, rd207, rd208, rd209, rd210, rd211, rd212, rd213, rd214, rd215, rd216, rd217, rd218, rd219, rd220, rd221, rd222, rd223, rd224, rd225, rd226, rd227, rd228, rd229, rd230, rd231, rd232, rd233, rd234, rd235, rd236, rd237, rd238, rd239, rd240, rd241, rd242, rd243, rd244, rd245, rd246, rd247, rd248, rd249, rd250, rd251, rd252, rd253, rd254, rd255, rd256, rd257, rd258, rd259, rd260, rd261, rd262, rd263, rd264, rd265, rd266, rd267, rd268, rd269, rd270, rd271, rd272, rd273, rd274, rd275, rd276, rd277, rd278, rd279, rd280, rd281, rd282, rd283, rd284, rd285, rd286, rd287, rd288, rd289, rd290, rd291, rd292, rd293, rd294, rd295, rd296, rd297, rd298, rd299, rd300, rd301, rd302, rd303, rd304, rd305, rd306, rd307, rd308, rd309, rd310, rd311, rd312, rd313, rd314, rd315, rd316, rd317, rd318, rd319, rd320, rd321, rd322, rd323, rd324, rd325, rd326, rd327, rd328, rd329, rd330, rd331, rd332, rd333, rd334, rd335, rd336, rd337, rd338, rd339, rd340, rd341, rd342, rd343, rd344, rd345, rd346, rd347, rd348, rd349, rd350, rd351, rd352, rd353, rd354, rd355, rd356, rd357, rd358, rd359, rd360, rd361, rd362, rd363, rd364, rd365, rd366, rd367, rd368, rd369, rd370, rd371, rd372, rd373, rd374, rd375, rd376, rd377, rd378, rd379, rd380, rd381, rd382, rd383, rd384, rd385, rd386, rd387, rd388, rd389, rd390, rd391, rd392, rd393, rd394, rd395, rd396, rd397, rd398, rd399, rd400, rd401, rd402, rd403, rd404, rd405, rd406, rd407, rd408, rd409, rd410, rd411, rd412, rd413, rd414, rd415, rd416, rd417, rd418, rd419, rd420, rd421, rd422, rd423, rd424, rd425, rd426, rd427, rd428, rd429, rd430, rd431, rd432, rd433, rd434, rd435, rd436, rd437, rd438, rd439, rd440, rd441, rd442, rd443, rd444, rd445, rd446, rd447, rd448, rd449, rd450, rd451, rd452, rd453, rd454, rd455, rd456, rd457, rd458, rd459, rd460, rd461, rd462, rd463, rd464, rd465, rd466, rd467, rd468, rd469, rd470, rd471, rd472, rd473, rd474, rd475, rd476, rd477, rd478, rd479, rd480, rd481, rd482, rd483, rd484, rd485, rd486, rd487, rd488, rd489, rd490, rd491, rd492, rd493, rd494, rd495, rd496, rd497, rd498, rd499, rd500, rd501, rd502, rd503, rd504, rd505, rd506, rd507, rd508, rd509, rd510, rd511, rd512, rd513, rd514, rd515, rd516, rd517, rd518, rd519, rd520, rd521, rd522, rd523, rd524, rd525, rd526, rd527, rd528, rd529, rd530, rd531, rd532, rd533, rd534, rd535, rd536, rd537, rd538, rd539, rd540, rd541, rd542, rd543, rd544, rd545, rd546, rd547, rd548, rd549, rd550, rd551, rd552, rd553, rd554, rd555, rd556, rd557, rd558, rd559, rd560, rd561, rd562, rd563, rd564, rd565, rd566, rd567, rd568, rd569, rd570, rd571, rd572, rd573, rd574, rd575, rd576, rd577, rd578, rd579, rd580, rd581, rd582, rd583, rd584, rd585, rd586, rd587, rd588, rd589, rd590, rd591, rd592, rd593, rd594, rd595, rd596, rd597, rd598, rd599, rd600, rd601, rd602, rd603, rd604, rd605, rd606, rd607, rd608, rd609, rd610, rd611, rd612, rd613, rd614, rd615, rd616, rd617, rd618, rd619, rd620, rd621, rd622, rd623, rd624, rd625, rd626, rd627, rd628, rd629, rd630, rd631, rd632, rd633, rd634, rd635, rd636, rd637, rd638, rd639, rd640, rd641, rd642, rd643, rd644, rd645, rd646, rd647, rd648, rd649, rd650, rd651, rd652, rd653, rd654, rd655, rd656, rd657, rd658, rd659, rd660, rd661, rd662, rd663, rd664, rd665, rd666, rd667, rd668, rd669, rd670, rd671, rd672, rd673, rd674, rd675, rd676, rd677, rd678, rd679, rd680, rd681, rd682, rd683, rd684, rd685, rd686, rd687, rd688, rd689, rd690, rd691, rd692, rd693, rd694, rd695, rd696, rd697, rd698, rd699, rd700, rd701, rd702, rd703, rd704, rd705, rd706, rd707, rd708, rd709, rd710, rd711, rd712, rd713, rd714, rd715, rd716, rd717, rd718, rd719, rd720, rd721, rd722, rd723, rd724, rd725, rd726, rd727, rd728, rd729, rd730, rd731, rd732, rd733, rd734, rd735, rd736, rd737, rd738, rd739, rd740, rd741, rd742, rd743, rd744, rd745, rd746, rd747;
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57, p58, p59, p60, p61, p62, p63, p64, p65, p66, p67, p68, p69, p70, p71, p72, p73, p74, p75, p76, p77, p78, p79, p80, p81, p82, p83, p84, p85, p86, p87, p88, p89, p90, p91, p92, p93, p94, p95, p96, p97, p98, p99, p100, p101;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440, f441, f442, f443, f444, f445, f446, f447, f448, f449, f450, f451, f452, f453, f454, f455, f456, f457, f458, f459, f460, f461, f462, f463, f464, f465, f466, f467, f468, f469, f470, f471, f472, f473, f474, f475, f476, f477, f478, f479, f480, f481, f482, f483, f484, f485;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121, r122, r123, r124, r125, r126, r127, r128, r129, r130, r131, r132, r133, r134, r135, r136, r137, r138, r139, r140, r141, r142, r143, r144, r145, r146, r147, r148, r149, r150, r151, r152, r153, r154, r155, r156, r157, r158, r159, r160, r161, r162, r163, r164, r165;
  __align__(16) unsigned char __local_depot55[64];
  // PTX:36 mov.u64 %SPL, __local_depot55
  SPL = (unsigned long long)__cvta_generic_to_local(__local_depot55);
  // PTX:37 ld.param.u64 %rd139, [_ZN7synreal6kernel36add_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_0]
  rd139 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:38 ld.param.u64 %rd140, [_ZN7synreal6kernel36add_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_1]
  rd140 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:39 ld.param.u64 %rd128, [_ZN7synreal6kernel36add_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_2]
  rd128 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:40 ld.param.u64 %rd129, [_ZN7synreal6kernel36add_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_3]
  rd129 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:41 ld.param.u64 %rd130, [_ZN7synreal6kernel36add_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_4]
  rd130 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:42 ld.param.u64 %rd131, [_ZN7synreal6kernel36add_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_5]
  rd131 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:43 ld.param.u64 %rd132, [_ZN7synreal6kernel36add_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_6]
  rd132 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:44 ld.param.u64 %rd133, [_ZN7synreal6kernel36add_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_7]
  rd133 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:45 ld.param.u64 %rd134, [_ZN7synreal6kernel36add_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_8]
  rd134 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:46 ld.param.u64 %rd141, [_ZN7synreal6kernel36add_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_9]
  rd141 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:47 ld.param.u64 %rd142, [_ZN7synreal6kernel36add_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_10]
  rd142 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:48 ld.param.u64 %rd143, [_ZN7synreal6kernel36add_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_11]
  rd143 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:49 ld.param.u64 %rd135, [_ZN7synreal6kernel36add_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_12]
  rd135 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:50 ld.param.u64 %rd144, [_ZN7synreal6kernel36add_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_13]
  rd144 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:51 ld.param.u64 %rd136, [_ZN7synreal6kernel36add_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_14]
  rd136 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:52 ld.param.u64 %rd137, [_ZN7synreal6kernel36add_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_15]
  rd137 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param15 + (0))));
  // PTX:53 ld.param.u64 %rd138, [_ZN7synreal6kernel36add_body_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_16]
  rd138 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param16 + (0))));
  // PTX:54 cvta.to.global.u64 %rd1, %rd143
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd143));
  // PTX:55 cvta.to.global.u64 %rd2, %rd141
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd141));
  // PTX:56 cvta.to.global.u64 %rd3, %rd142
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd142));
  // PTX:57 cvta.to.global.u64 %rd4, %rd139
  rd4 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd139));
  // PTX:58 cvta.to.global.u64 %rd5, %rd140
  rd5 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd140));
  // PTX:59 add.u64 %rd6, %SPL, 0
  asm("add.u64 %0, %1, 0;" : "=l"(rd6) : "l"(SPL));
  // PTX:60 add.u64 %rd7, %SPL, 32
  asm("add.u64 %0, %1, 32;" : "=l"(rd7) : "l"(SPL));
  // PTX:61 mov.u32 %r29, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r29) : "r"(blockIdx.x));
  // PTX:62 mov.u32 %r30, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r30) : "r"(blockDim.x));
  // PTX:63 mul.wide.u32 %rd147, %r29, %r30
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd147) : "r"(r29), "r"(r30));
  // PTX:64 mov.u32 %r31, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r31) : "r"(threadIdx.x));
  // PTX:65 cvt.u64.u32 %rd148, %r31
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd148) : "r"(r31));
  // PTX:66 add.s64 %rd8, %rd147, %rd148
  asm("add.s64 %0, %1, %2;" : "=l"(rd8) : "l"(rd147), "l"(rd148));
  // PTX:67 setp.ge.u64 %p1, %rd8, %rd144
  p1 = (((unsigned long long)(rd8)) >= ((unsigned long long)(rd144)));
  // PTX:68 @%p1 bra $L__BB55_137
  if (p1) { goto L_BB55_137; }
  // PTX:70 or.b64 %rd149, %rd8, %rd136
  asm("or.b64 %0, %1, %2;" : "=l"(rd149) : "l"(rd8), "l"(rd136));
  // PTX:71 and.b64 %rd150, %rd149, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd150) : "l"(rd149));
  // PTX:72 setp.eq.s64 %p2, %rd150, 0
  p2 = (((long long)(rd150)) == ((long long)(0)));
  // PTX:73 @%p2 bra $L__BB55_3
  if (p2) { goto L_BB55_3; }
  // PTX:75 rem.u64 %rd704, %rd8, %rd136
  asm("rem.u64 %0, %1, %2;" : "=l"(rd704) : "l"(rd8), "l"(rd136));
  // PTX:76 bra.uni $L__BB55_4
  goto L_BB55_4;
  // PTX:78 $L__BB55_3:
L_BB55_3:;
  // PTX:79 cvt.u32.u64 %r32, %rd136
  asm("cvt.u32.u64 %0, %1;" : "=r"(r32) : "l"(rd136));
  // PTX:80 cvt.u32.u64 %r33, %rd8
  asm("cvt.u32.u64 %0, %1;" : "=r"(r33) : "l"(rd8));
  // PTX:81 rem.u32 %r34, %r33, %r32
  asm("rem.u32 %0, %1, %2;" : "=r"(r34) : "r"(r33), "r"(r32));
  // PTX:82 cvt.u64.u32 %rd704, %r34
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd704) : "r"(r34));
  // PTX:84 $L__BB55_4:
L_BB55_4:;
  // PTX:85 cvta.to.global.u64 %rd151, %rd134
  rd151 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd134));
  // PTX:86 shl.b64 %rd152, %rd704, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd152) : "l"(rd704));
  // PTX:87 add.s64 %rd153, %rd151, %rd152
  asm("add.s64 %0, %1, %2;" : "=l"(rd153) : "l"(rd151), "l"(rd152));
  // PTX:88 ld.global.f32 %f1, [%rd153]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd153) + (0)))));
  // PTX:89 setp.le.f32 %p3, %f1, 0f00000000
  p3 = (!(isnan(((float)(f1))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f1)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:90 @%p3 bra $L__BB55_137
  if (p3) { goto L_BB55_137; }
  // PTX:92 cvta.to.global.u64 %rd154, %rd133
  rd154 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd133));
  // PTX:93 add.s64 %rd156, %rd154, %rd152
  asm("add.s64 %0, %1, %2;" : "=l"(rd156) : "l"(rd154), "l"(rd152));
  // PTX:94 ld.global.f32 %f2, [%rd156]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd156) + (0)))));
  // PTX:95 setp.leu.f32 %p4, %f2, 0f00000000
  p4 = ((isnan(((float)(f2))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f2)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:96 @%p4 bra $L__BB55_137
  if (p4) { goto L_BB55_137; }
  // PTX:98 @%p2 bra $L__BB55_8
  if (p2) { goto L_BB55_8; }
  // PTX:100 div.u64 %rd705, %rd8, %rd136
  asm("div.u64 %0, %1, %2;" : "=l"(rd705) : "l"(rd8), "l"(rd136));
  // PTX:101 bra.uni $L__BB55_9
  goto L_BB55_9;
  // PTX:103 $L__BB55_8:
L_BB55_8:;
  // PTX:104 cvt.u32.u64 %r35, %rd136
  asm("cvt.u32.u64 %0, %1;" : "=r"(r35) : "l"(rd136));
  // PTX:105 cvt.u32.u64 %r36, %rd8
  asm("cvt.u32.u64 %0, %1;" : "=r"(r36) : "l"(rd8));
  // PTX:106 div.u32 %r37, %r36, %r35
  asm("div.u32 %0, %1, %2;" : "=r"(r37) : "r"(r36), "r"(r35));
  // PTX:107 cvt.u64.u32 %rd705, %r37
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd705) : "r"(r37));
  // PTX:109 $L__BB55_9:
L_BB55_9:;
  // PTX:110 mul.lo.s64 %rd159, %rd705, %rd137
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd159) : "l"(rd705), "l"(rd137));
  // PTX:111 cvt.u32.u64 %r1, %rd159
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd159));
  // PTX:112 cvta.to.global.u64 %rd160, %rd128
  rd160 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd128));
  // PTX:113 shl.b64 %rd161, %rd704, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd161) : "l"(rd704));
  // PTX:114 add.s64 %rd162, %rd160, %rd161
  asm("add.s64 %0, %1, %2;" : "=l"(rd162) : "l"(rd160), "l"(rd161));
  // PTX:115 ld.global.u32 %r2, [%rd162]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd162) + (0)))));
  // PTX:116 ld.global.s32 %rd15, [%rd162+4]
  rd15 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd162) + (4)))));
  // PTX:117 cvta.to.global.u64 %rd163, %rd129
  rd163 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd129));
  // PTX:118 mul.lo.s64 %rd164, %rd704, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd164) : "l"(rd704));
  // PTX:119 add.s64 %rd165, %rd163, %rd164
  asm("add.s64 %0, %1, %2;" : "=l"(rd165) : "l"(rd163), "l"(rd164));
  // PTX:120 ld.global.f32 %f481, [%rd165]
  f481 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd165) + (0)))));
  // PTX:121 ld.global.f32 %f480, [%rd165+4]
  f480 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd165) + (4)))));
  // PTX:122 ld.global.f32 %f479, [%rd165+8]
  f479 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd165) + (8)))));
  // PTX:123 cvta.to.global.u64 %rd166, %rd130
  rd166 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd130));
  // PTX:124 add.s64 %rd167, %rd166, %rd164
  asm("add.s64 %0, %1, %2;" : "=l"(rd167) : "l"(rd166), "l"(rd164));
  // PTX:125 ld.global.f32 %f484, [%rd167]
  f484 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd167) + (0)))));
  // PTX:126 ld.global.f32 %f483, [%rd167+4]
  f483 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd167) + (4)))));
  // PTX:127 ld.global.f32 %f482, [%rd167+8]
  f482 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd167) + (8)))));
  // PTX:128 setp.lt.s32 %p6, %r2, 0
  p6 = (((int)(r2)) < ((int)(0)));
  // PTX:129 mov.u32 %r157, 0
  asm("mov.u32 %0, 0;" : "=r"(r157) : );
  // PTX:130 @%p6 bra $L__BB55_11
  if (p6) { goto L_BB55_11; }
  // PTX:132 mul.wide.s32 %rd168, %r2, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd168) : "r"(r2));
  // PTX:133 add.s64 %rd169, %rd5, %rd168
  asm("add.s64 %0, %1, %2;" : "=l"(rd169) : "l"(rd5), "l"(rd168));
  // PTX:134 ld.global.u32 %r40, [%rd169]
  r40 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd169) + (0)))));
  // PTX:135 ld.global.u32 %r41, [%rd169+4]
  r41 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd169) + (4)))));
  // PTX:136 ld.global.u32 %r42, [%rd169+8]
  r42 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd169) + (8)))));
  // PTX:137 ld.global.u32 %r43, [%rd169+12]
  r43 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd169) + (12)))));
  // PTX:138 cvta.to.global.u64 %rd170, %rd131
  rd170 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd131));
  // PTX:139 shl.b64 %rd171, %rd704, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd171) : "l"(rd704));
  // PTX:140 add.s64 %rd172, %rd170, %rd171
  asm("add.s64 %0, %1, %2;" : "=l"(rd172) : "l"(rd170), "l"(rd171));
  // PTX:141 add.s32 %r44, %r40, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r44) : "r"(r40), "r"(r1));
  // PTX:142 mul.wide.s32 %rd173, %r44, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd173) : "r"(r44));
  // PTX:143 add.s64 %rd174, %rd4, %rd173
  asm("add.s64 %0, %1, %2;" : "=l"(rd174) : "l"(rd4), "l"(rd173));
  // PTX:144 ld.global.f32 %f100, [%rd174]
  f100 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd174) + (0)))));
  // PTX:145 ld.global.f32 %f101, [%rd172]
  f101 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd172) + (0)))));
  // PTX:146 ld.global.f32 %f102, [%rd174+4]
  f102 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd174) + (4)))));
  // PTX:147 ld.global.f32 %f103, [%rd174+8]
  f103 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd174) + (8)))));
  // PTX:148 add.s32 %r45, %r41, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r45) : "r"(r41), "r"(r1));
  // PTX:149 mul.wide.s32 %rd175, %r45, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd175) : "r"(r45));
  // PTX:150 add.s64 %rd176, %rd4, %rd175
  asm("add.s64 %0, %1, %2;" : "=l"(rd176) : "l"(rd4), "l"(rd175));
  // PTX:151 ld.global.f32 %f104, [%rd176]
  f104 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd176) + (0)))));
  // PTX:152 ld.global.f32 %f105, [%rd172+4]
  f105 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd172) + (4)))));
  // PTX:153 mul.f32 %f106, %f105, %f104
  asm("mul.f32 %0, %1, %2;" : "=f"(f106) : "f"(f105), "f"(f104));
  // PTX:154 ld.global.f32 %f107, [%rd176+4]
  f107 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd176) + (4)))));
  // PTX:155 mul.f32 %f108, %f105, %f107
  asm("mul.f32 %0, %1, %2;" : "=f"(f108) : "f"(f105), "f"(f107));
  // PTX:156 ld.global.f32 %f109, [%rd176+8]
  f109 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd176) + (8)))));
  // PTX:157 mul.f32 %f110, %f105, %f109
  asm("mul.f32 %0, %1, %2;" : "=f"(f110) : "f"(f105), "f"(f109));
  // PTX:158 fma.rn.f32 %f111, %f101, %f100, %f106
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f111) : "f"(f101), "f"(f100), "f"(f106));
  // PTX:159 fma.rn.f32 %f112, %f101, %f102, %f108
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f112) : "f"(f101), "f"(f102), "f"(f108));
  // PTX:160 fma.rn.f32 %f113, %f101, %f103, %f110
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f113) : "f"(f101), "f"(f103), "f"(f110));
  // PTX:161 add.s32 %r46, %r42, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r46) : "r"(r42), "r"(r1));
  // PTX:162 mul.wide.s32 %rd177, %r46, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd177) : "r"(r46));
  // PTX:163 add.s64 %rd178, %rd4, %rd177
  asm("add.s64 %0, %1, %2;" : "=l"(rd178) : "l"(rd4), "l"(rd177));
  // PTX:164 ld.global.f32 %f114, [%rd178]
  f114 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd178) + (0)))));
  // PTX:165 ld.global.f32 %f115, [%rd172+8]
  f115 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd172) + (8)))));
  // PTX:166 ld.global.f32 %f116, [%rd178+4]
  f116 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd178) + (4)))));
  // PTX:167 ld.global.f32 %f117, [%rd178+8]
  f117 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd178) + (8)))));
  // PTX:168 fma.rn.f32 %f118, %f115, %f114, %f111
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f118) : "f"(f115), "f"(f114), "f"(f111));
  // PTX:169 fma.rn.f32 %f119, %f115, %f116, %f112
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f119) : "f"(f115), "f"(f116), "f"(f112));
  // PTX:170 fma.rn.f32 %f120, %f115, %f117, %f113
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f120) : "f"(f115), "f"(f117), "f"(f113));
  // PTX:171 add.s32 %r47, %r43, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r47) : "r"(r43), "r"(r1));
  // PTX:172 mul.wide.s32 %rd179, %r47, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd179) : "r"(r47));
  // PTX:173 add.s64 %rd180, %rd4, %rd179
  asm("add.s64 %0, %1, %2;" : "=l"(rd180) : "l"(rd4), "l"(rd179));
  // PTX:174 ld.global.f32 %f121, [%rd180]
  f121 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (0)))));
  // PTX:175 ld.global.f32 %f122, [%rd172+12]
  f122 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd172) + (12)))));
  // PTX:176 ld.global.f32 %f123, [%rd180+4]
  f123 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (4)))));
  // PTX:177 ld.global.f32 %f124, [%rd180+8]
  f124 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (8)))));
  // PTX:178 st.local.v4.u32 [%rd6], {%r44, %r45, %r46, %r47}
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd6) + (0))))) = (unsigned)(r44); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd6) + (4))))) = (unsigned)(r45); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd6) + (8))))) = (unsigned)(r46); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd6) + (12))))) = (unsigned)(r47);
  // PTX:179 neg.f32 %f125, %f122
  asm("neg.f32 %0, %1;" : "=f"(f125) : "f"(f122));
  // PTX:180 neg.f32 %f126, %f115
  asm("neg.f32 %0, %1;" : "=f"(f126) : "f"(f115));
  // PTX:181 neg.f32 %f127, %f105
  asm("neg.f32 %0, %1;" : "=f"(f127) : "f"(f105));
  // PTX:182 neg.f32 %f128, %f101
  asm("neg.f32 %0, %1;" : "=f"(f128) : "f"(f101));
  // PTX:183 st.local.v4.f32 [%rd7], {%f128, %f127, %f126, %f125}
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd7) + (0))))) = (float)(f128); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd7) + (4))))) = (float)(f127); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd7) + (8))))) = (float)(f126); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd7) + (12))))) = (float)(f125);
  // PTX:184 fma.rn.f32 %f481, %f122, %f121, %f118
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f481) : "f"(f122), "f"(f121), "f"(f118));
  // PTX:185 fma.rn.f32 %f480, %f122, %f123, %f119
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f480) : "f"(f122), "f"(f123), "f"(f119));
  // PTX:186 fma.rn.f32 %f479, %f122, %f124, %f120
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f479) : "f"(f122), "f"(f124), "f"(f120));
  // PTX:187 mov.u32 %r157, 4
  asm("mov.u32 %0, 4;" : "=r"(r157) : );
  // PTX:189 $L__BB55_11:
L_BB55_11:;
  // PTX:190 cvt.u32.u64 %r48, %rd15
  asm("cvt.u32.u64 %0, %1;" : "=r"(r48) : "l"(rd15));
  // PTX:191 setp.lt.s32 %p7, %r48, 0
  p7 = (((int)(r48)) < ((int)(0)));
  // PTX:192 @%p7 bra $L__BB55_13
  if (p7) { goto L_BB55_13; }
  // PTX:194 shl.b64 %rd181, %rd15, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd181) : "l"(rd15));
  // PTX:195 add.s64 %rd182, %rd5, %rd181
  asm("add.s64 %0, %1, %2;" : "=l"(rd182) : "l"(rd5), "l"(rd181));
  // PTX:196 ld.global.u32 %r49, [%rd182]
  r49 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd182) + (0)))));
  // PTX:197 add.s32 %r50, %r49, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r50) : "r"(r49), "r"(r1));
  // PTX:198 ld.global.u32 %r51, [%rd182+4]
  r51 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd182) + (4)))));
  // PTX:199 add.s32 %r52, %r51, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r52) : "r"(r51), "r"(r1));
  // PTX:200 ld.global.u32 %r53, [%rd182+8]
  r53 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd182) + (8)))));
  // PTX:201 add.s32 %r54, %r53, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r54) : "r"(r53), "r"(r1));
  // PTX:202 ld.global.u32 %r55, [%rd182+12]
  r55 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd182) + (12)))));
  // PTX:203 add.s32 %r56, %r55, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r56) : "r"(r55), "r"(r1));
  // PTX:204 cvta.to.global.u64 %rd183, %rd132
  rd183 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd132));
  // PTX:205 shl.b64 %rd184, %rd704, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd184) : "l"(rd704));
  // PTX:206 add.s64 %rd185, %rd183, %rd184
  asm("add.s64 %0, %1, %2;" : "=l"(rd185) : "l"(rd183), "l"(rd184));
  // PTX:207 mul.wide.s32 %rd186, %r50, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd186) : "r"(r50));
  // PTX:208 add.s64 %rd187, %rd4, %rd186
  asm("add.s64 %0, %1, %2;" : "=l"(rd187) : "l"(rd4), "l"(rd186));
  // PTX:209 ld.global.f32 %f129, [%rd187]
  f129 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd187) + (0)))));
  // PTX:210 ld.global.f32 %f130, [%rd185]
  f130 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (0)))));
  // PTX:211 ld.global.f32 %f131, [%rd187+4]
  f131 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd187) + (4)))));
  // PTX:212 ld.global.f32 %f132, [%rd187+8]
  f132 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd187) + (8)))));
  // PTX:213 mul.wide.s32 %rd188, %r52, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd188) : "r"(r52));
  // PTX:214 add.s64 %rd189, %rd4, %rd188
  asm("add.s64 %0, %1, %2;" : "=l"(rd189) : "l"(rd4), "l"(rd188));
  // PTX:215 ld.global.f32 %f133, [%rd189]
  f133 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd189) + (0)))));
  // PTX:216 ld.global.f32 %f134, [%rd185+4]
  f134 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (4)))));
  // PTX:217 mul.f32 %f135, %f134, %f133
  asm("mul.f32 %0, %1, %2;" : "=f"(f135) : "f"(f134), "f"(f133));
  // PTX:218 ld.global.f32 %f136, [%rd189+4]
  f136 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd189) + (4)))));
  // PTX:219 mul.f32 %f137, %f134, %f136
  asm("mul.f32 %0, %1, %2;" : "=f"(f137) : "f"(f134), "f"(f136));
  // PTX:220 ld.global.f32 %f138, [%rd189+8]
  f138 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd189) + (8)))));
  // PTX:221 mul.f32 %f139, %f134, %f138
  asm("mul.f32 %0, %1, %2;" : "=f"(f139) : "f"(f134), "f"(f138));
  // PTX:222 fma.rn.f32 %f140, %f130, %f129, %f135
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f140) : "f"(f130), "f"(f129), "f"(f135));
  // PTX:223 fma.rn.f32 %f141, %f130, %f131, %f137
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f141) : "f"(f130), "f"(f131), "f"(f137));
  // PTX:224 fma.rn.f32 %f142, %f130, %f132, %f139
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f142) : "f"(f130), "f"(f132), "f"(f139));
  // PTX:225 mul.wide.s32 %rd190, %r54, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd190) : "r"(r54));
  // PTX:226 add.s64 %rd191, %rd4, %rd190
  asm("add.s64 %0, %1, %2;" : "=l"(rd191) : "l"(rd4), "l"(rd190));
  // PTX:227 ld.global.f32 %f143, [%rd191]
  f143 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd191) + (0)))));
  // PTX:228 ld.global.f32 %f144, [%rd185+8]
  f144 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (8)))));
  // PTX:229 ld.global.f32 %f145, [%rd191+4]
  f145 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd191) + (4)))));
  // PTX:230 ld.global.f32 %f146, [%rd191+8]
  f146 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd191) + (8)))));
  // PTX:231 fma.rn.f32 %f147, %f144, %f143, %f140
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f147) : "f"(f144), "f"(f143), "f"(f140));
  // PTX:232 fma.rn.f32 %f148, %f144, %f145, %f141
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f148) : "f"(f144), "f"(f145), "f"(f141));
  // PTX:233 fma.rn.f32 %f149, %f144, %f146, %f142
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f149) : "f"(f144), "f"(f146), "f"(f142));
  // PTX:234 mul.wide.s32 %rd192, %r56, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd192) : "r"(r56));
  // PTX:235 add.s64 %rd193, %rd4, %rd192
  asm("add.s64 %0, %1, %2;" : "=l"(rd193) : "l"(rd4), "l"(rd192));
  // PTX:236 ld.global.f32 %f150, [%rd193]
  f150 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd193) + (0)))));
  // PTX:237 ld.global.f32 %f151, [%rd185+12]
  f151 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (12)))));
  // PTX:238 ld.global.f32 %f152, [%rd193+4]
  f152 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd193) + (4)))));
  // PTX:239 ld.global.f32 %f153, [%rd193+8]
  f153 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd193) + (8)))));
  // PTX:240 mul.wide.u32 %rd194, %r157, 4
  asm("mul.wide.u32 %0, %1, 4;" : "=l"(rd194) : "r"(r157));
  // PTX:241 add.s64 %rd195, %rd6, %rd194
  asm("add.s64 %0, %1, %2;" : "=l"(rd195) : "l"(rd6), "l"(rd194));
  // PTX:242 st.local.u32 [%rd195], %r50
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd195) + (0))))) = (unsigned)(r50);
  // PTX:243 add.s64 %rd196, %rd7, %rd194
  asm("add.s64 %0, %1, %2;" : "=l"(rd196) : "l"(rd7), "l"(rd194));
  // PTX:244 st.local.f32 [%rd196], %f130
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd196) + (0))))) = (float)(f130);
  // PTX:245 st.local.u32 [%rd195+4], %r52
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd195) + (4))))) = (unsigned)(r52);
  // PTX:246 st.local.f32 [%rd196+4], %f134
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd196) + (4))))) = (float)(f134);
  // PTX:247 st.local.u32 [%rd195+8], %r54
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd195) + (8))))) = (unsigned)(r54);
  // PTX:248 st.local.f32 [%rd196+8], %f144
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd196) + (8))))) = (float)(f144);
  // PTX:249 st.local.u32 [%rd195+12], %r56
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd195) + (12))))) = (unsigned)(r56);
  // PTX:250 st.local.f32 [%rd196+12], %f151
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd196) + (12))))) = (float)(f151);
  // PTX:251 fma.rn.f32 %f484, %f151, %f150, %f147
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f484) : "f"(f151), "f"(f150), "f"(f147));
  // PTX:252 fma.rn.f32 %f483, %f151, %f152, %f148
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f483) : "f"(f151), "f"(f152), "f"(f148));
  // PTX:253 fma.rn.f32 %f482, %f151, %f153, %f149
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f482) : "f"(f151), "f"(f153), "f"(f149));
  // PTX:254 add.s32 %r157, %r157, 4
  asm("add.s32 %0, %1, 4;" : "=r"(r157) : "r"(r157));
  // PTX:256 $L__BB55_13:
L_BB55_13:;
  // PTX:257 sub.f32 %f21, %f484, %f481
  asm("sub.f32 %0, %1, %2;" : "=f"(f21) : "f"(f484), "f"(f481));
  // PTX:258 mul.f32 %f154, %f21, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f154) : "f"(f21), "f"(f21));
  // PTX:259 sub.f32 %f22, %f483, %f480
  asm("sub.f32 %0, %1, %2;" : "=f"(f22) : "f"(f483), "f"(f480));
  // PTX:260 sub.f32 %f23, %f482, %f479
  asm("sub.f32 %0, %1, %2;" : "=f"(f23) : "f"(f482), "f"(f479));
  // PTX:261 fma.rn.f32 %f155, %f22, %f22, %f154
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f155) : "f"(f22), "f"(f22), "f"(f154));
  // PTX:262 fma.rn.f32 %f156, %f23, %f23, %f155
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f156) : "f"(f23), "f"(f23), "f"(f155));
  // PTX:263 sqrt.rn.f32 %f24, %f156
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f24) : "f"(f156));
  // PTX:264 setp.le.f32 %p8, %f24, 0f322BCC77
  p8 = (!(isnan(((float)(f24))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f24)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:265 mov.u32 %r158, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r158) : );
  // PTX:266 mov.u32 %r159, 0
  asm("mov.u32 %0, 0;" : "=r"(r159) : );
  // PTX:267 mov.u32 %r160, %r159
  asm("mov.u32 %0, %1;" : "=r"(r160) : "r"(r159));
  // PTX:268 mov.u32 %r161, %r158
  asm("mov.u32 %0, %1;" : "=r"(r161) : "r"(r158));
  // PTX:269 mov.u32 %r162, %r159
  asm("mov.u32 %0, %1;" : "=r"(r162) : "r"(r159));
  // PTX:270 mov.u32 %r163, %r158
  asm("mov.u32 %0, %1;" : "=r"(r163) : "r"(r158));
  // PTX:271 @%p8 bra $L__BB55_15
  if (p8) { goto L_BB55_15; }
  // PTX:273 div.rn.f32 %f157, %f21, %f24
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f157) : "f"(f21), "f"(f24));
  // PTX:274 mul.f32 %f158, %f157, %f157
  asm("mul.f32 %0, %1, %2;" : "=f"(f158) : "f"(f157), "f"(f157));
  // PTX:275 div.rn.f32 %f159, %f22, %f24
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f159) : "f"(f22), "f"(f24));
  // PTX:276 mul.f32 %f160, %f159, %f157
  asm("mul.f32 %0, %1, %2;" : "=f"(f160) : "f"(f159), "f"(f157));
  // PTX:277 div.rn.f32 %f161, %f23, %f24
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f161) : "f"(f23), "f"(f24));
  // PTX:278 mul.f32 %f162, %f161, %f157
  asm("mul.f32 %0, %1, %2;" : "=f"(f162) : "f"(f161), "f"(f157));
  // PTX:279 mul.f32 %f163, %f159, %f159
  asm("mul.f32 %0, %1, %2;" : "=f"(f163) : "f"(f159), "f"(f159));
  // PTX:280 mul.f32 %f164, %f161, %f159
  asm("mul.f32 %0, %1, %2;" : "=f"(f164) : "f"(f161), "f"(f159));
  // PTX:281 mul.f32 %f165, %f161, %f161
  asm("mul.f32 %0, %1, %2;" : "=f"(f165) : "f"(f161), "f"(f161));
  // PTX:282 div.rn.f32 %f166, %f1, %f24
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f166) : "f"(f1), "f"(f24));
  // PTX:283 mov.f32 %f167, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f167) : );
  // PTX:284 sub.f32 %f168, %f167, %f166
  asm("sub.f32 %0, %1, %2;" : "=f"(f168) : "f"(f167), "f"(f166));
  // PTX:285 mov.f32 %f169, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f169) : );
  // PTX:286 max.f32 %f170, %f169, %f168
  asm("max.f32 %0, %1, %2;" : "=f"(f170) : "f"(f169), "f"(f168));
  // PTX:287 sub.f32 %f171, %f167, %f158
  asm("sub.f32 %0, %1, %2;" : "=f"(f171) : "f"(f167), "f"(f158));
  // PTX:288 sub.f32 %f172, %f169, %f160
  asm("sub.f32 %0, %1, %2;" : "=f"(f172) : "f"(f169), "f"(f160));
  // PTX:289 sub.f32 %f173, %f169, %f162
  asm("sub.f32 %0, %1, %2;" : "=f"(f173) : "f"(f169), "f"(f162));
  // PTX:290 sub.f32 %f174, %f167, %f163
  asm("sub.f32 %0, %1, %2;" : "=f"(f174) : "f"(f167), "f"(f163));
  // PTX:291 sub.f32 %f175, %f169, %f164
  asm("sub.f32 %0, %1, %2;" : "=f"(f175) : "f"(f169), "f"(f164));
  // PTX:292 sub.f32 %f176, %f167, %f165
  asm("sub.f32 %0, %1, %2;" : "=f"(f176) : "f"(f167), "f"(f165));
  // PTX:293 fma.rn.f32 %f177, %f171, %f170, %f158
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f177) : "f"(f171), "f"(f170), "f"(f158));
  // PTX:294 fma.rn.f32 %f178, %f172, %f170, %f160
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f178) : "f"(f172), "f"(f170), "f"(f160));
  // PTX:295 fma.rn.f32 %f179, %f173, %f170, %f162
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f179) : "f"(f173), "f"(f170), "f"(f162));
  // PTX:296 fma.rn.f32 %f180, %f174, %f170, %f163
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f180) : "f"(f174), "f"(f170), "f"(f163));
  // PTX:297 fma.rn.f32 %f181, %f175, %f170, %f164
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f181) : "f"(f175), "f"(f170), "f"(f164));
  // PTX:298 fma.rn.f32 %f182, %f176, %f170, %f165
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f182) : "f"(f176), "f"(f170), "f"(f165));
  // PTX:299 mov.b32 %r163, %f182
  asm("mov.b32 %0, %1;" : "=r"(r163) : "f"(f182));
  // PTX:300 mov.b32 %r162, %f181
  asm("mov.b32 %0, %1;" : "=r"(r162) : "f"(f181));
  // PTX:301 mov.b32 %r160, %f179
  asm("mov.b32 %0, %1;" : "=r"(r160) : "f"(f179));
  // PTX:302 mov.b32 %r161, %f180
  asm("mov.b32 %0, %1;" : "=r"(r161) : "f"(f180));
  // PTX:303 mov.b32 %r159, %f178
  asm("mov.b32 %0, %1;" : "=r"(r159) : "f"(f178));
  // PTX:304 mov.b32 %r158, %f177
  asm("mov.b32 %0, %1;" : "=r"(r158) : "f"(f177));
  // PTX:306 $L__BB55_15:
L_BB55_15:;
  // PTX:307 mov.b32 %f183, %r158
  asm("mov.b32 %0, %1;" : "=f"(f183) : "r"(r158));
  // PTX:308 add.f32 %f184, %f183, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f184) : "f"(f183));
  // PTX:309 mov.b32 %f185, %r159
  asm("mov.b32 %0, %1;" : "=f"(f185) : "r"(r159));
  // PTX:310 mov.b32 %f186, %r160
  asm("mov.b32 %0, %1;" : "=f"(f186) : "r"(r160));
  // PTX:311 mov.b32 %f187, %r159
  asm("mov.b32 %0, %1;" : "=f"(f187) : "r"(r159));
  // PTX:312 mov.b32 %f188, %r161
  asm("mov.b32 %0, %1;" : "=f"(f188) : "r"(r161));
  // PTX:313 add.f32 %f189, %f188, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f189) : "f"(f188));
  // PTX:314 mov.b32 %f190, %r162
  asm("mov.b32 %0, %1;" : "=f"(f190) : "r"(r162));
  // PTX:315 mov.b32 %f191, %r160
  asm("mov.b32 %0, %1;" : "=f"(f191) : "r"(r160));
  // PTX:316 mov.b32 %f192, %r162
  asm("mov.b32 %0, %1;" : "=f"(f192) : "r"(r162));
  // PTX:317 mov.b32 %f193, %r163
  asm("mov.b32 %0, %1;" : "=f"(f193) : "r"(r163));
  // PTX:318 add.f32 %f194, %f193, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f194) : "f"(f193));
  // PTX:319 mul.f32 %f25, %f2, %f184
  asm("mul.f32 %0, %1, %2;" : "=f"(f25) : "f"(f2), "f"(f184));
  // PTX:320 mul.f32 %f26, %f2, %f185
  asm("mul.f32 %0, %1, %2;" : "=f"(f26) : "f"(f2), "f"(f185));
  // PTX:321 mul.f32 %f27, %f2, %f186
  asm("mul.f32 %0, %1, %2;" : "=f"(f27) : "f"(f2), "f"(f186));
  // PTX:322 mul.f32 %f28, %f2, %f187
  asm("mul.f32 %0, %1, %2;" : "=f"(f28) : "f"(f2), "f"(f187));
  // PTX:323 mul.f32 %f29, %f2, %f189
  asm("mul.f32 %0, %1, %2;" : "=f"(f29) : "f"(f2), "f"(f189));
  // PTX:324 mul.f32 %f30, %f2, %f190
  asm("mul.f32 %0, %1, %2;" : "=f"(f30) : "f"(f2), "f"(f190));
  // PTX:325 mul.f32 %f31, %f2, %f191
  asm("mul.f32 %0, %1, %2;" : "=f"(f31) : "f"(f2), "f"(f191));
  // PTX:326 mul.f32 %f32, %f2, %f192
  asm("mul.f32 %0, %1, %2;" : "=f"(f32) : "f"(f2), "f"(f192));
  // PTX:327 mul.f32 %f33, %f2, %f194
  asm("mul.f32 %0, %1, %2;" : "=f"(f33) : "f"(f2), "f"(f194));
  // PTX:328 setp.lt.s32 %p9, %r157, 1
  p9 = (((int)(r157)) < ((int)(1)));
  // PTX:329 @%p9 bra $L__BB55_137
  if (p9) { goto L_BB55_137; }
  // PTX:331 ld.local.u32 %r164, [%rd6]
  r164 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd6) + (0)))));
  // PTX:332 ld.local.f32 %f485, [%rd7]
  f485 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd7) + (0)))));
  // PTX:333 mov.u32 %r165, 0
  asm("mov.u32 %0, 0;" : "=r"(r165) : );
  // PTX:334 bra.uni $L__BB55_17
  goto L_BB55_17;
  // PTX:336 $L__BB55_136:
L_BB55_136:;
  // PTX:337 add.s32 %r165, %r165, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r165) : "r"(r165));
  // PTX:339 $L__BB55_17:
L_BB55_17:;
  // PTX:340 mov.f32 %f35, %f485
  asm("mov.f32 %0, %1;" : "=f"(f35) : "f"(f485));
  // PTX:341 mul.f32 %f195, %f35, %f35
  asm("mul.f32 %0, %1, %2;" : "=f"(f195) : "f"(f35), "f"(f35));
  // PTX:342 mul.f32 %f196, %f25, %f195
  asm("mul.f32 %0, %1, %2;" : "=f"(f196) : "f"(f25), "f"(f195));
  // PTX:343 mul.f32 %f197, %f26, %f195
  asm("mul.f32 %0, %1, %2;" : "=f"(f197) : "f"(f26), "f"(f195));
  // PTX:344 mul.f32 %f198, %f27, %f195
  asm("mul.f32 %0, %1, %2;" : "=f"(f198) : "f"(f27), "f"(f195));
  // PTX:345 mul.f32 %f199, %f28, %f195
  asm("mul.f32 %0, %1, %2;" : "=f"(f199) : "f"(f28), "f"(f195));
  // PTX:346 mul.f32 %f200, %f29, %f195
  asm("mul.f32 %0, %1, %2;" : "=f"(f200) : "f"(f29), "f"(f195));
  // PTX:347 mul.f32 %f201, %f30, %f195
  asm("mul.f32 %0, %1, %2;" : "=f"(f201) : "f"(f30), "f"(f195));
  // PTX:348 mul.f32 %f202, %f31, %f195
  asm("mul.f32 %0, %1, %2;" : "=f"(f202) : "f"(f31), "f"(f195));
  // PTX:349 mul.f32 %f203, %f32, %f195
  asm("mul.f32 %0, %1, %2;" : "=f"(f203) : "f"(f32), "f"(f195));
  // PTX:350 mul.f32 %f204, %f33, %f195
  asm("mul.f32 %0, %1, %2;" : "=f"(f204) : "f"(f33), "f"(f195));
  // PTX:351 cvt.s64.s32 %rd18, %r164
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd18) : "r"(r164));
  // PTX:352 mul.wide.s32 %rd197, %r164, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd197) : "r"(r164));
  // PTX:353 add.s64 %rd19, %rd2, %rd197
  asm("add.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd2), "l"(rd197));
  // PTX:354 red.global.add.f32 [%rd19], %f196
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))), (float)(f196));
  // PTX:355 add.s64 %rd198, %rd19, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd198) : "l"(rd19));
  // PTX:356 red.global.add.f32 [%rd198], %f197
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd198) + (0)))), (float)(f197));
  // PTX:357 add.s64 %rd199, %rd19, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd199) : "l"(rd19));
  // PTX:358 red.global.add.f32 [%rd199], %f198
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd199) + (0)))), (float)(f198));
  // PTX:359 add.s64 %rd200, %rd19, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd200) : "l"(rd19));
  // PTX:360 red.global.add.f32 [%rd200], %f199
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd200) + (0)))), (float)(f199));
  // PTX:361 add.s64 %rd201, %rd19, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd201) : "l"(rd19));
  // PTX:362 red.global.add.f32 [%rd201], %f200
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd201) + (0)))), (float)(f200));
  // PTX:363 add.s64 %rd202, %rd19, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd202) : "l"(rd19));
  // PTX:364 red.global.add.f32 [%rd202], %f201
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd202) + (0)))), (float)(f201));
  // PTX:365 add.s64 %rd203, %rd19, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd203) : "l"(rd19));
  // PTX:366 red.global.add.f32 [%rd203], %f202
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd203) + (0)))), (float)(f202));
  // PTX:367 add.s64 %rd204, %rd19, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd204) : "l"(rd19));
  // PTX:368 red.global.add.f32 [%rd204], %f203
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd204) + (0)))), (float)(f203));
  // PTX:369 add.s64 %rd205, %rd19, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd205) : "l"(rd19));
  // PTX:370 red.global.add.f32 [%rd205], %f204
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd205) + (0)))), (float)(f204));
  // PTX:371 add.s32 %r67, %r165, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r67) : "r"(r165));
  // PTX:372 setp.ge.s32 %p10, %r67, %r157
  p10 = (((int)(r67)) >= ((int)(r157)));
  // PTX:373 @%p10 bra $L__BB55_137
  if (p10) { goto L_BB55_137; }
  // PTX:375 add.u64 %rd702, %SPL, 32
  asm("add.u64 %0, %1, 32;" : "=l"(rd702) : "l"(SPL));
  // PTX:376 add.u64 %rd700, %SPL, 0
  asm("add.u64 %0, %1, 0;" : "=l"(rd700) : "l"(SPL));
  // PTX:377 cvt.u32.u64 %r68, %rd18
  asm("cvt.u32.u64 %0, %1;" : "=r"(r68) : "l"(rd18));
  // PTX:378 shl.b64 %rd206, %rd18, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd206) : "l"(rd18));
  // PTX:379 add.s64 %rd20, %rd3, %rd206
  asm("add.s64 %0, %1, %2;" : "=l"(rd20) : "l"(rd3), "l"(rd206));
  // PTX:380 mul.wide.s32 %rd207, %r165, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd207) : "r"(r165));
  // PTX:381 add.s64 %rd208, %rd702, %rd207
  asm("add.s64 %0, %1, %2;" : "=l"(rd208) : "l"(rd702), "l"(rd207));
  // PTX:382 add.s64 %rd21, %rd208, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd21) : "l"(rd208));
  // PTX:383 ld.local.f32 %f485, [%rd208+4]
  f485 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd208) + (4)))));
  // PTX:384 mul.f32 %f214, %f35, %f485
  asm("mul.f32 %0, %1, %2;" : "=f"(f214) : "f"(f35), "f"(f485));
  // PTX:385 mul.f32 %f37, %f25, %f214
  asm("mul.f32 %0, %1, %2;" : "=f"(f37) : "f"(f25), "f"(f214));
  // PTX:386 mul.f32 %f38, %f26, %f214
  asm("mul.f32 %0, %1, %2;" : "=f"(f38) : "f"(f26), "f"(f214));
  // PTX:387 mul.f32 %f39, %f27, %f214
  asm("mul.f32 %0, %1, %2;" : "=f"(f39) : "f"(f27), "f"(f214));
  // PTX:388 mul.f32 %f40, %f28, %f214
  asm("mul.f32 %0, %1, %2;" : "=f"(f40) : "f"(f28), "f"(f214));
  // PTX:389 mul.f32 %f41, %f29, %f214
  asm("mul.f32 %0, %1, %2;" : "=f"(f41) : "f"(f29), "f"(f214));
  // PTX:390 mul.f32 %f42, %f30, %f214
  asm("mul.f32 %0, %1, %2;" : "=f"(f42) : "f"(f30), "f"(f214));
  // PTX:391 mul.f32 %f43, %f31, %f214
  asm("mul.f32 %0, %1, %2;" : "=f"(f43) : "f"(f31), "f"(f214));
  // PTX:392 mul.f32 %f44, %f32, %f214
  asm("mul.f32 %0, %1, %2;" : "=f"(f44) : "f"(f32), "f"(f214));
  // PTX:393 mul.f32 %f45, %f33, %f214
  asm("mul.f32 %0, %1, %2;" : "=f"(f45) : "f"(f33), "f"(f214));
  // PTX:394 add.s64 %rd209, %rd700, %rd207
  asm("add.s64 %0, %1, %2;" : "=l"(rd209) : "l"(rd700), "l"(rd207));
  // PTX:395 add.s64 %rd22, %rd209, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd22) : "l"(rd209));
  // PTX:396 ld.local.u32 %r164, [%rd209+4]
  r164 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd209) + (4)))));
  // PTX:397 cvt.s64.s32 %rd23, %r164
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd23) : "r"(r164));
  // PTX:398 setp.eq.s32 %p11, %r68, %r164
  p11 = (((int)(r68)) == ((int)(r164)));
  // PTX:399 @%p11 bra $L__BB55_25
  if (p11) { goto L_BB55_25; }
  // PTX:400 bra.uni $L__BB55_19
  goto L_BB55_19;
  // PTX:402 $L__BB55_25:
L_BB55_25:;
  // PTX:403 red.global.add.f32 [%rd19], %f37
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))), (float)(f37));
  // PTX:404 red.global.add.f32 [%rd198], %f38
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd198) + (0)))), (float)(f38));
  // PTX:405 red.global.add.f32 [%rd199], %f39
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd199) + (0)))), (float)(f39));
  // PTX:406 red.global.add.f32 [%rd200], %f40
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd200) + (0)))), (float)(f40));
  // PTX:407 red.global.add.f32 [%rd201], %f41
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd201) + (0)))), (float)(f41));
  // PTX:408 red.global.add.f32 [%rd202], %f42
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd202) + (0)))), (float)(f42));
  // PTX:409 red.global.add.f32 [%rd203], %f43
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd203) + (0)))), (float)(f43));
  // PTX:410 red.global.add.f32 [%rd204], %f44
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd204) + (0)))), (float)(f44));
  // PTX:411 red.global.add.f32 [%rd205], %f45
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd205) + (0)))), (float)(f45));
  // PTX:412 bra.uni $L__BB55_26
  goto L_BB55_26;
  // PTX:414 $L__BB55_19:
L_BB55_19:;
  // PTX:415 ld.global.s32 %rd211, [%rd20]
  rd211 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))));
  // PTX:416 mov.u64 %rd708, 0
  asm("mov.u64 %0, 0;" : "=l"(rd708) : );
  // PTX:417 min.u64 %rd24, %rd211, %rd135
  asm("min.u64 %0, %1, %2;" : "=l"(rd24) : "l"(rd211), "l"(rd135));
  // PTX:418 setp.eq.s64 %p12, %rd24, 0
  p12 = (((long long)(rd24)) == ((long long)(0)));
  // PTX:419 @%p12 bra $L__BB55_22
  if (p12) { goto L_BB55_22; }
  // PTX:421 mov.u64 %rd708, 0
  asm("mov.u64 %0, 0;" : "=l"(rd708) : );
  // PTX:422 mov.u64 %rd706, %rd24
  asm("mov.u64 %0, %1;" : "=l"(rd706) : "l"(rd24));
  // PTX:424 $L__BB55_21:
L_BB55_21:;
  // PTX:425 sub.s64 %rd213, %rd706, %rd708
  asm("sub.s64 %0, %1, %2;" : "=l"(rd213) : "l"(rd706), "l"(rd708));
  // PTX:426 shr.u64 %rd214, %rd213, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd214) : "l"(rd213));
  // PTX:427 add.s64 %rd215, %rd214, %rd708
  asm("add.s64 %0, %1, %2;" : "=l"(rd215) : "l"(rd214), "l"(rd708));
  // PTX:428 mul.lo.s64 %rd216, %rd215, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd216) : "l"(rd215), "l"(rd138));
  // PTX:429 add.s64 %rd217, %rd216, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd217) : "l"(rd216), "l"(rd18));
  // PTX:430 mul.lo.s64 %rd218, %rd217, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd218) : "l"(rd217));
  // PTX:431 add.s64 %rd219, %rd1, %rd218
  asm("add.s64 %0, %1, %2;" : "=l"(rd219) : "l"(rd1), "l"(rd218));
  // PTX:432 ld.global.u32 %r69, [%rd219]
  r69 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd219) + (0)))));
  // PTX:433 setp.lt.s32 %p13, %r69, %r164
  p13 = (((int)(r69)) < ((int)(r164)));
  // PTX:434 add.s64 %rd220, %rd215, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd220) : "l"(rd215));
  // PTX:435 selp.b64 %rd708, %rd220, %rd708, %p13
  rd708 = p13 ? rd220 : rd708;
  // PTX:436 selp.b64 %rd706, %rd706, %rd215, %p13
  rd706 = p13 ? rd706 : rd215;
  // PTX:437 setp.gt.u64 %p14, %rd706, %rd708
  p14 = (((unsigned long long)(rd706)) > ((unsigned long long)(rd708)));
  // PTX:438 @%p14 bra $L__BB55_21
  if (p14) { goto L_BB55_21; }
  // PTX:440 $L__BB55_22:
L_BB55_22:;
  // PTX:441 setp.ge.u64 %p15, %rd708, %rd24
  p15 = (((unsigned long long)(rd708)) >= ((unsigned long long)(rd24)));
  // PTX:442 @%p15 bra $L__BB55_26
  if (p15) { goto L_BB55_26; }
  // PTX:444 mul.lo.s64 %rd221, %rd708, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd221) : "l"(rd708), "l"(rd138));
  // PTX:445 add.s64 %rd30, %rd221, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd30) : "l"(rd221), "l"(rd18));
  // PTX:446 mul.lo.s64 %rd222, %rd30, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd222) : "l"(rd30));
  // PTX:447 add.s64 %rd223, %rd1, %rd222
  asm("add.s64 %0, %1, %2;" : "=l"(rd223) : "l"(rd1), "l"(rd222));
  // PTX:448 ld.global.u32 %r70, [%rd223]
  r70 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd223) + (0)))));
  // PTX:449 setp.ne.s32 %p16, %r70, %r164
  p16 = (((int)(r70)) != ((int)(r164)));
  // PTX:450 @%p16 bra $L__BB55_26
  if (p16) { goto L_BB55_26; }
  // PTX:452 add.s64 %rd226, %rd223, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd226) : "l"(rd223));
  // PTX:453 red.global.add.f32 [%rd226], %f37
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd226) + (0)))), (float)(f37));
  // PTX:454 add.s64 %rd227, %rd223, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd227) : "l"(rd223));
  // PTX:455 red.global.add.f32 [%rd227], %f38
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd227) + (0)))), (float)(f38));
  // PTX:456 add.s64 %rd228, %rd223, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd228) : "l"(rd223));
  // PTX:457 red.global.add.f32 [%rd228], %f39
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd228) + (0)))), (float)(f39));
  // PTX:458 add.s64 %rd229, %rd223, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd229) : "l"(rd223));
  // PTX:459 red.global.add.f32 [%rd229], %f40
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd229) + (0)))), (float)(f40));
  // PTX:460 add.s64 %rd230, %rd223, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd230) : "l"(rd223));
  // PTX:461 red.global.add.f32 [%rd230], %f41
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd230) + (0)))), (float)(f41));
  // PTX:462 add.s64 %rd231, %rd223, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd231) : "l"(rd223));
  // PTX:463 red.global.add.f32 [%rd231], %f42
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd231) + (0)))), (float)(f42));
  // PTX:464 add.s64 %rd232, %rd223, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd232) : "l"(rd223));
  // PTX:465 red.global.add.f32 [%rd232], %f43
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd232) + (0)))), (float)(f43));
  // PTX:466 add.s64 %rd233, %rd223, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd233) : "l"(rd223));
  // PTX:467 red.global.add.f32 [%rd233], %f44
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd233) + (0)))), (float)(f44));
  // PTX:468 add.s64 %rd234, %rd223, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd234) : "l"(rd223));
  // PTX:469 red.global.add.f32 [%rd234], %f45
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd234) + (0)))), (float)(f45));
  // PTX:471 $L__BB55_26:
L_BB55_26:;
  // PTX:472 cvt.u32.u64 %r154, %rd18
  asm("cvt.u32.u64 %0, %1;" : "=r"(r154) : "l"(rd18));
  // PTX:473 setp.eq.s32 %p101, %r154, %r164
  p101 = (((int)(r154)) == ((int)(r164)));
  // PTX:474 @%p101 bra $L__BB55_33
  if (p101) { goto L_BB55_33; }
  // PTX:475 bra.uni $L__BB55_27
  goto L_BB55_27;
  // PTX:477 $L__BB55_33:
L_BB55_33:;
  // PTX:478 mul.lo.s64 %rd270, %rd23, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd270) : "l"(rd23));
  // PTX:479 add.s64 %rd271, %rd2, %rd270
  asm("add.s64 %0, %1, %2;" : "=l"(rd271) : "l"(rd2), "l"(rd270));
  // PTX:480 red.global.add.f32 [%rd271], %f37
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd271) + (0)))), (float)(f37));
  // PTX:481 add.s64 %rd272, %rd271, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd272) : "l"(rd271));
  // PTX:482 red.global.add.f32 [%rd272], %f38
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd272) + (0)))), (float)(f38));
  // PTX:483 add.s64 %rd273, %rd271, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd273) : "l"(rd271));
  // PTX:484 red.global.add.f32 [%rd273], %f39
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd273) + (0)))), (float)(f39));
  // PTX:485 add.s64 %rd274, %rd271, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd274) : "l"(rd271));
  // PTX:486 red.global.add.f32 [%rd274], %f40
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd274) + (0)))), (float)(f40));
  // PTX:487 add.s64 %rd275, %rd271, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd275) : "l"(rd271));
  // PTX:488 red.global.add.f32 [%rd275], %f41
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd275) + (0)))), (float)(f41));
  // PTX:489 add.s64 %rd276, %rd271, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd276) : "l"(rd271));
  // PTX:490 red.global.add.f32 [%rd276], %f42
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd276) + (0)))), (float)(f42));
  // PTX:491 add.s64 %rd277, %rd271, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd277) : "l"(rd271));
  // PTX:492 red.global.add.f32 [%rd277], %f43
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd277) + (0)))), (float)(f43));
  // PTX:493 add.s64 %rd278, %rd271, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd278) : "l"(rd271));
  // PTX:494 red.global.add.f32 [%rd278], %f44
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd278) + (0)))), (float)(f44));
  // PTX:495 add.s64 %rd279, %rd271, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd279) : "l"(rd271));
  // PTX:496 red.global.add.f32 [%rd279], %f45
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd279) + (0)))), (float)(f45));
  // PTX:497 bra.uni $L__BB55_34
  goto L_BB55_34;
  // PTX:499 $L__BB55_27:
L_BB55_27:;
  // PTX:500 shl.b64 %rd244, %rd23, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd244) : "l"(rd23));
  // PTX:501 add.s64 %rd245, %rd3, %rd244
  asm("add.s64 %0, %1, %2;" : "=l"(rd245) : "l"(rd3), "l"(rd244));
  // PTX:502 ld.global.s32 %rd246, [%rd245]
  rd246 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd245) + (0)))));
  // PTX:503 mov.u64 %rd711, 0
  asm("mov.u64 %0, 0;" : "=l"(rd711) : );
  // PTX:504 min.u64 %rd31, %rd246, %rd135
  asm("min.u64 %0, %1, %2;" : "=l"(rd31) : "l"(rd246), "l"(rd135));
  // PTX:505 setp.eq.s64 %p18, %rd31, 0
  p18 = (((long long)(rd31)) == ((long long)(0)));
  // PTX:506 @%p18 bra $L__BB55_30
  if (p18) { goto L_BB55_30; }
  // PTX:508 mov.u64 %rd711, 0
  asm("mov.u64 %0, 0;" : "=l"(rd711) : );
  // PTX:509 mov.u64 %rd709, %rd31
  asm("mov.u64 %0, %1;" : "=l"(rd709) : "l"(rd31));
  // PTX:511 $L__BB55_29:
L_BB55_29:;
  // PTX:512 sub.s64 %rd248, %rd709, %rd711
  asm("sub.s64 %0, %1, %2;" : "=l"(rd248) : "l"(rd709), "l"(rd711));
  // PTX:513 shr.u64 %rd249, %rd248, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd249) : "l"(rd248));
  // PTX:514 add.s64 %rd250, %rd249, %rd711
  asm("add.s64 %0, %1, %2;" : "=l"(rd250) : "l"(rd249), "l"(rd711));
  // PTX:515 mul.lo.s64 %rd251, %rd250, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd251) : "l"(rd250), "l"(rd138));
  // PTX:516 add.s64 %rd252, %rd251, %rd23
  asm("add.s64 %0, %1, %2;" : "=l"(rd252) : "l"(rd251), "l"(rd23));
  // PTX:517 mul.lo.s64 %rd253, %rd252, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd253) : "l"(rd252));
  // PTX:518 add.s64 %rd254, %rd1, %rd253
  asm("add.s64 %0, %1, %2;" : "=l"(rd254) : "l"(rd1), "l"(rd253));
  // PTX:519 ld.global.u32 %r72, [%rd254]
  r72 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd254) + (0)))));
  // PTX:520 setp.lt.s32 %p19, %r72, %r68
  p19 = (((int)(r72)) < ((int)(r68)));
  // PTX:521 add.s64 %rd255, %rd250, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd255) : "l"(rd250));
  // PTX:522 selp.b64 %rd711, %rd255, %rd711, %p19
  rd711 = p19 ? rd255 : rd711;
  // PTX:523 selp.b64 %rd709, %rd709, %rd250, %p19
  rd709 = p19 ? rd709 : rd250;
  // PTX:524 setp.gt.u64 %p20, %rd709, %rd711
  p20 = (((unsigned long long)(rd709)) > ((unsigned long long)(rd711)));
  // PTX:525 @%p20 bra $L__BB55_29
  if (p20) { goto L_BB55_29; }
  // PTX:527 $L__BB55_30:
L_BB55_30:;
  // PTX:528 setp.ge.u64 %p21, %rd711, %rd31
  p21 = (((unsigned long long)(rd711)) >= ((unsigned long long)(rd31)));
  // PTX:529 @%p21 bra $L__BB55_34
  if (p21) { goto L_BB55_34; }
  // PTX:531 mul.lo.s64 %rd256, %rd711, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd256) : "l"(rd711), "l"(rd138));
  // PTX:532 add.s64 %rd37, %rd256, %rd23
  asm("add.s64 %0, %1, %2;" : "=l"(rd37) : "l"(rd256), "l"(rd23));
  // PTX:533 mul.lo.s64 %rd257, %rd37, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd257) : "l"(rd37));
  // PTX:534 add.s64 %rd258, %rd1, %rd257
  asm("add.s64 %0, %1, %2;" : "=l"(rd258) : "l"(rd1), "l"(rd257));
  // PTX:535 ld.global.u32 %r75, [%rd258]
  r75 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd258) + (0)))));
  // PTX:536 setp.ne.s32 %p22, %r75, %r68
  p22 = (((int)(r75)) != ((int)(r68)));
  // PTX:537 @%p22 bra $L__BB55_34
  if (p22) { goto L_BB55_34; }
  // PTX:539 add.s64 %rd261, %rd258, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd261) : "l"(rd258));
  // PTX:540 red.global.add.f32 [%rd261], %f37
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd261) + (0)))), (float)(f37));
  // PTX:541 add.s64 %rd262, %rd258, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd262) : "l"(rd258));
  // PTX:542 red.global.add.f32 [%rd262], %f38
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd262) + (0)))), (float)(f38));
  // PTX:543 add.s64 %rd263, %rd258, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd263) : "l"(rd258));
  // PTX:544 red.global.add.f32 [%rd263], %f39
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd263) + (0)))), (float)(f39));
  // PTX:545 add.s64 %rd264, %rd258, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd264) : "l"(rd258));
  // PTX:546 red.global.add.f32 [%rd264], %f40
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd264) + (0)))), (float)(f40));
  // PTX:547 add.s64 %rd265, %rd258, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd265) : "l"(rd258));
  // PTX:548 red.global.add.f32 [%rd265], %f41
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd265) + (0)))), (float)(f41));
  // PTX:549 add.s64 %rd266, %rd258, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd266) : "l"(rd258));
  // PTX:550 red.global.add.f32 [%rd266], %f42
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd266) + (0)))), (float)(f42));
  // PTX:551 add.s64 %rd267, %rd258, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd267) : "l"(rd258));
  // PTX:552 red.global.add.f32 [%rd267], %f43
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd267) + (0)))), (float)(f43));
  // PTX:553 add.s64 %rd268, %rd258, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd268) : "l"(rd258));
  // PTX:554 red.global.add.f32 [%rd268], %f44
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd268) + (0)))), (float)(f44));
  // PTX:555 add.s64 %rd269, %rd258, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd269) : "l"(rd258));
  // PTX:556 red.global.add.f32 [%rd269], %f45
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd269) + (0)))), (float)(f45));
  // PTX:558 $L__BB55_34:
L_BB55_34:;
  // PTX:559 add.s32 %r76, %r165, 2
  asm("add.s32 %0, %1, 2;" : "=r"(r76) : "r"(r165));
  // PTX:560 setp.ge.s32 %p23, %r76, %r157
  p23 = (((int)(r76)) >= ((int)(r157)));
  // PTX:561 @%p23 bra $L__BB55_136
  if (p23) { goto L_BB55_136; }
  // PTX:563 ld.local.f32 %f251, [%rd21+4]
  f251 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd21) + (4)))));
  // PTX:564 mul.f32 %f252, %f35, %f251
  asm("mul.f32 %0, %1, %2;" : "=f"(f252) : "f"(f35), "f"(f251));
  // PTX:565 mul.f32 %f46, %f25, %f252
  asm("mul.f32 %0, %1, %2;" : "=f"(f46) : "f"(f25), "f"(f252));
  // PTX:566 mul.f32 %f47, %f26, %f252
  asm("mul.f32 %0, %1, %2;" : "=f"(f47) : "f"(f26), "f"(f252));
  // PTX:567 mul.f32 %f48, %f27, %f252
  asm("mul.f32 %0, %1, %2;" : "=f"(f48) : "f"(f27), "f"(f252));
  // PTX:568 mul.f32 %f49, %f28, %f252
  asm("mul.f32 %0, %1, %2;" : "=f"(f49) : "f"(f28), "f"(f252));
  // PTX:569 mul.f32 %f50, %f29, %f252
  asm("mul.f32 %0, %1, %2;" : "=f"(f50) : "f"(f29), "f"(f252));
  // PTX:570 mul.f32 %f51, %f30, %f252
  asm("mul.f32 %0, %1, %2;" : "=f"(f51) : "f"(f30), "f"(f252));
  // PTX:571 mul.f32 %f52, %f31, %f252
  asm("mul.f32 %0, %1, %2;" : "=f"(f52) : "f"(f31), "f"(f252));
  // PTX:572 mul.f32 %f53, %f32, %f252
  asm("mul.f32 %0, %1, %2;" : "=f"(f53) : "f"(f32), "f"(f252));
  // PTX:573 mul.f32 %f54, %f33, %f252
  asm("mul.f32 %0, %1, %2;" : "=f"(f54) : "f"(f33), "f"(f252));
  // PTX:574 ld.local.u32 %r78, [%rd22+4]
  r78 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd22) + (4)))));
  // PTX:575 cvt.s64.s32 %rd38, %r78
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd38) : "r"(r78));
  // PTX:576 setp.eq.s32 %p24, %r68, %r78
  p24 = (((int)(r68)) == ((int)(r78)));
  // PTX:577 @%p24 bra $L__BB55_42
  if (p24) { goto L_BB55_42; }
  // PTX:578 bra.uni $L__BB55_36
  goto L_BB55_36;
  // PTX:580 $L__BB55_42:
L_BB55_42:;
  // PTX:581 red.global.add.f32 [%rd19], %f46
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))), (float)(f46));
  // PTX:582 red.global.add.f32 [%rd198], %f47
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd198) + (0)))), (float)(f47));
  // PTX:583 red.global.add.f32 [%rd199], %f48
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd199) + (0)))), (float)(f48));
  // PTX:584 red.global.add.f32 [%rd200], %f49
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd200) + (0)))), (float)(f49));
  // PTX:585 red.global.add.f32 [%rd201], %f50
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd201) + (0)))), (float)(f50));
  // PTX:586 red.global.add.f32 [%rd202], %f51
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd202) + (0)))), (float)(f51));
  // PTX:587 red.global.add.f32 [%rd203], %f52
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd203) + (0)))), (float)(f52));
  // PTX:588 red.global.add.f32 [%rd204], %f53
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd204) + (0)))), (float)(f53));
  // PTX:589 red.global.add.f32 [%rd205], %f54
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd205) + (0)))), (float)(f54));
  // PTX:590 bra.uni $L__BB55_43
  goto L_BB55_43;
  // PTX:592 $L__BB55_36:
L_BB55_36:;
  // PTX:593 ld.global.s32 %rd281, [%rd20]
  rd281 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))));
  // PTX:594 mov.u64 %rd714, 0
  asm("mov.u64 %0, 0;" : "=l"(rd714) : );
  // PTX:595 min.u64 %rd39, %rd281, %rd135
  asm("min.u64 %0, %1, %2;" : "=l"(rd39) : "l"(rd281), "l"(rd135));
  // PTX:596 setp.eq.s64 %p25, %rd39, 0
  p25 = (((long long)(rd39)) == ((long long)(0)));
  // PTX:597 @%p25 bra $L__BB55_39
  if (p25) { goto L_BB55_39; }
  // PTX:599 mov.u64 %rd714, 0
  asm("mov.u64 %0, 0;" : "=l"(rd714) : );
  // PTX:600 mov.u64 %rd712, %rd39
  asm("mov.u64 %0, %1;" : "=l"(rd712) : "l"(rd39));
  // PTX:602 $L__BB55_38:
L_BB55_38:;
  // PTX:603 sub.s64 %rd283, %rd712, %rd714
  asm("sub.s64 %0, %1, %2;" : "=l"(rd283) : "l"(rd712), "l"(rd714));
  // PTX:604 shr.u64 %rd284, %rd283, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd284) : "l"(rd283));
  // PTX:605 add.s64 %rd285, %rd284, %rd714
  asm("add.s64 %0, %1, %2;" : "=l"(rd285) : "l"(rd284), "l"(rd714));
  // PTX:606 mul.lo.s64 %rd286, %rd285, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd286) : "l"(rd285), "l"(rd138));
  // PTX:607 add.s64 %rd287, %rd286, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd287) : "l"(rd286), "l"(rd18));
  // PTX:608 mul.lo.s64 %rd288, %rd287, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd288) : "l"(rd287));
  // PTX:609 add.s64 %rd289, %rd1, %rd288
  asm("add.s64 %0, %1, %2;" : "=l"(rd289) : "l"(rd1), "l"(rd288));
  // PTX:610 ld.global.u32 %r79, [%rd289]
  r79 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd289) + (0)))));
  // PTX:611 cvt.u32.u64 %r80, %rd38
  asm("cvt.u32.u64 %0, %1;" : "=r"(r80) : "l"(rd38));
  // PTX:612 setp.lt.s32 %p26, %r79, %r80
  p26 = (((int)(r79)) < ((int)(r80)));
  // PTX:613 add.s64 %rd290, %rd285, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd290) : "l"(rd285));
  // PTX:614 selp.b64 %rd714, %rd290, %rd714, %p26
  rd714 = p26 ? rd290 : rd714;
  // PTX:615 selp.b64 %rd712, %rd712, %rd285, %p26
  rd712 = p26 ? rd712 : rd285;
  // PTX:616 setp.gt.u64 %p27, %rd712, %rd714
  p27 = (((unsigned long long)(rd712)) > ((unsigned long long)(rd714)));
  // PTX:617 @%p27 bra $L__BB55_38
  if (p27) { goto L_BB55_38; }
  // PTX:619 $L__BB55_39:
L_BB55_39:;
  // PTX:620 setp.ge.u64 %p28, %rd714, %rd39
  p28 = (((unsigned long long)(rd714)) >= ((unsigned long long)(rd39)));
  // PTX:621 @%p28 bra $L__BB55_43
  if (p28) { goto L_BB55_43; }
  // PTX:623 cvt.u32.u64 %r81, %rd38
  asm("cvt.u32.u64 %0, %1;" : "=r"(r81) : "l"(rd38));
  // PTX:624 mul.lo.s64 %rd291, %rd714, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd291) : "l"(rd714), "l"(rd138));
  // PTX:625 add.s64 %rd45, %rd291, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd291), "l"(rd18));
  // PTX:626 mul.lo.s64 %rd292, %rd45, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd292) : "l"(rd45));
  // PTX:627 add.s64 %rd293, %rd1, %rd292
  asm("add.s64 %0, %1, %2;" : "=l"(rd293) : "l"(rd1), "l"(rd292));
  // PTX:628 ld.global.u32 %r82, [%rd293]
  r82 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd293) + (0)))));
  // PTX:629 setp.ne.s32 %p29, %r82, %r81
  p29 = (((int)(r82)) != ((int)(r81)));
  // PTX:630 @%p29 bra $L__BB55_43
  if (p29) { goto L_BB55_43; }
  // PTX:632 add.s64 %rd296, %rd293, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd296) : "l"(rd293));
  // PTX:633 red.global.add.f32 [%rd296], %f46
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd296) + (0)))), (float)(f46));
  // PTX:634 add.s64 %rd297, %rd293, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd297) : "l"(rd293));
  // PTX:635 red.global.add.f32 [%rd297], %f47
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd297) + (0)))), (float)(f47));
  // PTX:636 add.s64 %rd298, %rd293, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd298) : "l"(rd293));
  // PTX:637 red.global.add.f32 [%rd298], %f48
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd298) + (0)))), (float)(f48));
  // PTX:638 add.s64 %rd299, %rd293, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd299) : "l"(rd293));
  // PTX:639 red.global.add.f32 [%rd299], %f49
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd299) + (0)))), (float)(f49));
  // PTX:640 add.s64 %rd300, %rd293, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd300) : "l"(rd293));
  // PTX:641 red.global.add.f32 [%rd300], %f50
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd300) + (0)))), (float)(f50));
  // PTX:642 add.s64 %rd301, %rd293, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd301) : "l"(rd293));
  // PTX:643 red.global.add.f32 [%rd301], %f51
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd301) + (0)))), (float)(f51));
  // PTX:644 add.s64 %rd302, %rd293, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd302) : "l"(rd293));
  // PTX:645 red.global.add.f32 [%rd302], %f52
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd302) + (0)))), (float)(f52));
  // PTX:646 add.s64 %rd303, %rd293, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd303) : "l"(rd293));
  // PTX:647 red.global.add.f32 [%rd303], %f53
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd303) + (0)))), (float)(f53));
  // PTX:648 add.s64 %rd304, %rd293, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd304) : "l"(rd293));
  // PTX:649 red.global.add.f32 [%rd304], %f54
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd304) + (0)))), (float)(f54));
  // PTX:651 $L__BB55_43:
L_BB55_43:;
  // PTX:652 cvt.u32.u64 %r84, %rd38
  asm("cvt.u32.u64 %0, %1;" : "=r"(r84) : "l"(rd38));
  // PTX:653 setp.eq.s32 %p30, %r68, %r84
  p30 = (((int)(r68)) == ((int)(r84)));
  // PTX:654 @%p30 bra $L__BB55_50
  if (p30) { goto L_BB55_50; }
  // PTX:655 bra.uni $L__BB55_44
  goto L_BB55_44;
  // PTX:657 $L__BB55_50:
L_BB55_50:;
  // PTX:658 mul.lo.s64 %rd340, %rd38, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd340) : "l"(rd38));
  // PTX:659 add.s64 %rd341, %rd2, %rd340
  asm("add.s64 %0, %1, %2;" : "=l"(rd341) : "l"(rd2), "l"(rd340));
  // PTX:660 red.global.add.f32 [%rd341], %f46
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd341) + (0)))), (float)(f46));
  // PTX:661 add.s64 %rd342, %rd341, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd342) : "l"(rd341));
  // PTX:662 red.global.add.f32 [%rd342], %f47
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd342) + (0)))), (float)(f47));
  // PTX:663 add.s64 %rd343, %rd341, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd343) : "l"(rd341));
  // PTX:664 red.global.add.f32 [%rd343], %f48
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd343) + (0)))), (float)(f48));
  // PTX:665 add.s64 %rd344, %rd341, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd344) : "l"(rd341));
  // PTX:666 red.global.add.f32 [%rd344], %f49
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd344) + (0)))), (float)(f49));
  // PTX:667 add.s64 %rd345, %rd341, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd345) : "l"(rd341));
  // PTX:668 red.global.add.f32 [%rd345], %f50
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd345) + (0)))), (float)(f50));
  // PTX:669 add.s64 %rd346, %rd341, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd346) : "l"(rd341));
  // PTX:670 red.global.add.f32 [%rd346], %f51
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd346) + (0)))), (float)(f51));
  // PTX:671 add.s64 %rd347, %rd341, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd347) : "l"(rd341));
  // PTX:672 red.global.add.f32 [%rd347], %f52
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd347) + (0)))), (float)(f52));
  // PTX:673 add.s64 %rd348, %rd341, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd348) : "l"(rd341));
  // PTX:674 red.global.add.f32 [%rd348], %f53
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd348) + (0)))), (float)(f53));
  // PTX:675 add.s64 %rd349, %rd341, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd349) : "l"(rd341));
  // PTX:676 red.global.add.f32 [%rd349], %f54
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd349) + (0)))), (float)(f54));
  // PTX:677 bra.uni $L__BB55_51
  goto L_BB55_51;
  // PTX:679 $L__BB55_44:
L_BB55_44:;
  // PTX:680 shl.b64 %rd314, %rd38, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd314) : "l"(rd38));
  // PTX:681 add.s64 %rd315, %rd3, %rd314
  asm("add.s64 %0, %1, %2;" : "=l"(rd315) : "l"(rd3), "l"(rd314));
  // PTX:682 ld.global.s32 %rd316, [%rd315]
  rd316 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd315) + (0)))));
  // PTX:683 mov.u64 %rd717, 0
  asm("mov.u64 %0, 0;" : "=l"(rd717) : );
  // PTX:684 min.u64 %rd46, %rd316, %rd135
  asm("min.u64 %0, %1, %2;" : "=l"(rd46) : "l"(rd316), "l"(rd135));
  // PTX:685 setp.eq.s64 %p31, %rd46, 0
  p31 = (((long long)(rd46)) == ((long long)(0)));
  // PTX:686 @%p31 bra $L__BB55_47
  if (p31) { goto L_BB55_47; }
  // PTX:688 mov.u64 %rd717, 0
  asm("mov.u64 %0, 0;" : "=l"(rd717) : );
  // PTX:689 mov.u64 %rd715, %rd46
  asm("mov.u64 %0, %1;" : "=l"(rd715) : "l"(rd46));
  // PTX:691 $L__BB55_46:
L_BB55_46:;
  // PTX:692 sub.s64 %rd318, %rd715, %rd717
  asm("sub.s64 %0, %1, %2;" : "=l"(rd318) : "l"(rd715), "l"(rd717));
  // PTX:693 shr.u64 %rd319, %rd318, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd319) : "l"(rd318));
  // PTX:694 add.s64 %rd320, %rd319, %rd717
  asm("add.s64 %0, %1, %2;" : "=l"(rd320) : "l"(rd319), "l"(rd717));
  // PTX:695 mul.lo.s64 %rd321, %rd320, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd321) : "l"(rd320), "l"(rd138));
  // PTX:696 add.s64 %rd322, %rd321, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd322) : "l"(rd321), "l"(rd38));
  // PTX:697 mul.lo.s64 %rd323, %rd322, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd323) : "l"(rd322));
  // PTX:698 add.s64 %rd324, %rd1, %rd323
  asm("add.s64 %0, %1, %2;" : "=l"(rd324) : "l"(rd1), "l"(rd323));
  // PTX:699 ld.global.u32 %r85, [%rd324]
  r85 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd324) + (0)))));
  // PTX:700 setp.lt.s32 %p32, %r85, %r68
  p32 = (((int)(r85)) < ((int)(r68)));
  // PTX:701 add.s64 %rd325, %rd320, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd325) : "l"(rd320));
  // PTX:702 selp.b64 %rd717, %rd325, %rd717, %p32
  rd717 = p32 ? rd325 : rd717;
  // PTX:703 selp.b64 %rd715, %rd715, %rd320, %p32
  rd715 = p32 ? rd715 : rd320;
  // PTX:704 setp.gt.u64 %p33, %rd715, %rd717
  p33 = (((unsigned long long)(rd715)) > ((unsigned long long)(rd717)));
  // PTX:705 @%p33 bra $L__BB55_46
  if (p33) { goto L_BB55_46; }
  // PTX:707 $L__BB55_47:
L_BB55_47:;
  // PTX:708 setp.ge.u64 %p34, %rd717, %rd46
  p34 = (((unsigned long long)(rd717)) >= ((unsigned long long)(rd46)));
  // PTX:709 @%p34 bra $L__BB55_51
  if (p34) { goto L_BB55_51; }
  // PTX:711 mul.lo.s64 %rd326, %rd717, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd326) : "l"(rd717), "l"(rd138));
  // PTX:712 add.s64 %rd52, %rd326, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd52) : "l"(rd326), "l"(rd38));
  // PTX:713 mul.lo.s64 %rd327, %rd52, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd327) : "l"(rd52));
  // PTX:714 add.s64 %rd328, %rd1, %rd327
  asm("add.s64 %0, %1, %2;" : "=l"(rd328) : "l"(rd1), "l"(rd327));
  // PTX:715 ld.global.u32 %r88, [%rd328]
  r88 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd328) + (0)))));
  // PTX:716 setp.ne.s32 %p35, %r88, %r68
  p35 = (((int)(r88)) != ((int)(r68)));
  // PTX:717 @%p35 bra $L__BB55_51
  if (p35) { goto L_BB55_51; }
  // PTX:719 add.s64 %rd331, %rd328, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd331) : "l"(rd328));
  // PTX:720 red.global.add.f32 [%rd331], %f46
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd331) + (0)))), (float)(f46));
  // PTX:721 add.s64 %rd332, %rd328, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd332) : "l"(rd328));
  // PTX:722 red.global.add.f32 [%rd332], %f47
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd332) + (0)))), (float)(f47));
  // PTX:723 add.s64 %rd333, %rd328, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd333) : "l"(rd328));
  // PTX:724 red.global.add.f32 [%rd333], %f48
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd333) + (0)))), (float)(f48));
  // PTX:725 add.s64 %rd334, %rd328, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd334) : "l"(rd328));
  // PTX:726 red.global.add.f32 [%rd334], %f49
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd334) + (0)))), (float)(f49));
  // PTX:727 add.s64 %rd335, %rd328, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd335) : "l"(rd328));
  // PTX:728 red.global.add.f32 [%rd335], %f50
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd335) + (0)))), (float)(f50));
  // PTX:729 add.s64 %rd336, %rd328, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd336) : "l"(rd328));
  // PTX:730 red.global.add.f32 [%rd336], %f51
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd336) + (0)))), (float)(f51));
  // PTX:731 add.s64 %rd337, %rd328, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd337) : "l"(rd328));
  // PTX:732 red.global.add.f32 [%rd337], %f52
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd337) + (0)))), (float)(f52));
  // PTX:733 add.s64 %rd338, %rd328, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd338) : "l"(rd328));
  // PTX:734 red.global.add.f32 [%rd338], %f53
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd338) + (0)))), (float)(f53));
  // PTX:735 add.s64 %rd339, %rd328, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd339) : "l"(rd328));
  // PTX:736 red.global.add.f32 [%rd339], %f54
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd339) + (0)))), (float)(f54));
  // PTX:738 $L__BB55_51:
L_BB55_51:;
  // PTX:739 add.s32 %r89, %r165, 3
  asm("add.s32 %0, %1, 3;" : "=r"(r89) : "r"(r165));
  // PTX:740 setp.ge.s32 %p36, %r89, %r157
  p36 = (((int)(r89)) >= ((int)(r157)));
  // PTX:741 @%p36 bra $L__BB55_136
  if (p36) { goto L_BB55_136; }
  // PTX:743 ld.local.f32 %f289, [%rd21+8]
  f289 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd21) + (8)))));
  // PTX:744 mul.f32 %f290, %f35, %f289
  asm("mul.f32 %0, %1, %2;" : "=f"(f290) : "f"(f35), "f"(f289));
  // PTX:745 mul.f32 %f55, %f25, %f290
  asm("mul.f32 %0, %1, %2;" : "=f"(f55) : "f"(f25), "f"(f290));
  // PTX:746 mul.f32 %f56, %f26, %f290
  asm("mul.f32 %0, %1, %2;" : "=f"(f56) : "f"(f26), "f"(f290));
  // PTX:747 mul.f32 %f57, %f27, %f290
  asm("mul.f32 %0, %1, %2;" : "=f"(f57) : "f"(f27), "f"(f290));
  // PTX:748 mul.f32 %f58, %f28, %f290
  asm("mul.f32 %0, %1, %2;" : "=f"(f58) : "f"(f28), "f"(f290));
  // PTX:749 mul.f32 %f59, %f29, %f290
  asm("mul.f32 %0, %1, %2;" : "=f"(f59) : "f"(f29), "f"(f290));
  // PTX:750 mul.f32 %f60, %f30, %f290
  asm("mul.f32 %0, %1, %2;" : "=f"(f60) : "f"(f30), "f"(f290));
  // PTX:751 mul.f32 %f61, %f31, %f290
  asm("mul.f32 %0, %1, %2;" : "=f"(f61) : "f"(f31), "f"(f290));
  // PTX:752 mul.f32 %f62, %f32, %f290
  asm("mul.f32 %0, %1, %2;" : "=f"(f62) : "f"(f32), "f"(f290));
  // PTX:753 mul.f32 %f63, %f33, %f290
  asm("mul.f32 %0, %1, %2;" : "=f"(f63) : "f"(f33), "f"(f290));
  // PTX:754 ld.local.u32 %r91, [%rd22+8]
  r91 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd22) + (8)))));
  // PTX:755 cvt.s64.s32 %rd53, %r91
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd53) : "r"(r91));
  // PTX:756 setp.eq.s32 %p37, %r68, %r91
  p37 = (((int)(r68)) == ((int)(r91)));
  // PTX:757 @%p37 bra $L__BB55_59
  if (p37) { goto L_BB55_59; }
  // PTX:758 bra.uni $L__BB55_53
  goto L_BB55_53;
  // PTX:760 $L__BB55_59:
L_BB55_59:;
  // PTX:761 red.global.add.f32 [%rd19], %f55
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))), (float)(f55));
  // PTX:762 red.global.add.f32 [%rd198], %f56
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd198) + (0)))), (float)(f56));
  // PTX:763 red.global.add.f32 [%rd199], %f57
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd199) + (0)))), (float)(f57));
  // PTX:764 red.global.add.f32 [%rd200], %f58
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd200) + (0)))), (float)(f58));
  // PTX:765 red.global.add.f32 [%rd201], %f59
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd201) + (0)))), (float)(f59));
  // PTX:766 red.global.add.f32 [%rd202], %f60
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd202) + (0)))), (float)(f60));
  // PTX:767 red.global.add.f32 [%rd203], %f61
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd203) + (0)))), (float)(f61));
  // PTX:768 red.global.add.f32 [%rd204], %f62
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd204) + (0)))), (float)(f62));
  // PTX:769 red.global.add.f32 [%rd205], %f63
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd205) + (0)))), (float)(f63));
  // PTX:770 bra.uni $L__BB55_60
  goto L_BB55_60;
  // PTX:772 $L__BB55_53:
L_BB55_53:;
  // PTX:773 ld.global.s32 %rd351, [%rd20]
  rd351 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))));
  // PTX:774 mov.u64 %rd720, 0
  asm("mov.u64 %0, 0;" : "=l"(rd720) : );
  // PTX:775 min.u64 %rd54, %rd351, %rd135
  asm("min.u64 %0, %1, %2;" : "=l"(rd54) : "l"(rd351), "l"(rd135));
  // PTX:776 setp.eq.s64 %p38, %rd54, 0
  p38 = (((long long)(rd54)) == ((long long)(0)));
  // PTX:777 @%p38 bra $L__BB55_56
  if (p38) { goto L_BB55_56; }
  // PTX:779 mov.u64 %rd720, 0
  asm("mov.u64 %0, 0;" : "=l"(rd720) : );
  // PTX:780 mov.u64 %rd718, %rd54
  asm("mov.u64 %0, %1;" : "=l"(rd718) : "l"(rd54));
  // PTX:782 $L__BB55_55:
L_BB55_55:;
  // PTX:783 sub.s64 %rd353, %rd718, %rd720
  asm("sub.s64 %0, %1, %2;" : "=l"(rd353) : "l"(rd718), "l"(rd720));
  // PTX:784 shr.u64 %rd354, %rd353, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd354) : "l"(rd353));
  // PTX:785 add.s64 %rd355, %rd354, %rd720
  asm("add.s64 %0, %1, %2;" : "=l"(rd355) : "l"(rd354), "l"(rd720));
  // PTX:786 mul.lo.s64 %rd356, %rd355, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd356) : "l"(rd355), "l"(rd138));
  // PTX:787 add.s64 %rd357, %rd356, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd357) : "l"(rd356), "l"(rd18));
  // PTX:788 mul.lo.s64 %rd358, %rd357, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd358) : "l"(rd357));
  // PTX:789 add.s64 %rd359, %rd1, %rd358
  asm("add.s64 %0, %1, %2;" : "=l"(rd359) : "l"(rd1), "l"(rd358));
  // PTX:790 ld.global.u32 %r92, [%rd359]
  r92 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd359) + (0)))));
  // PTX:791 cvt.u32.u64 %r93, %rd53
  asm("cvt.u32.u64 %0, %1;" : "=r"(r93) : "l"(rd53));
  // PTX:792 setp.lt.s32 %p39, %r92, %r93
  p39 = (((int)(r92)) < ((int)(r93)));
  // PTX:793 add.s64 %rd360, %rd355, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd360) : "l"(rd355));
  // PTX:794 selp.b64 %rd720, %rd360, %rd720, %p39
  rd720 = p39 ? rd360 : rd720;
  // PTX:795 selp.b64 %rd718, %rd718, %rd355, %p39
  rd718 = p39 ? rd718 : rd355;
  // PTX:796 setp.gt.u64 %p40, %rd718, %rd720
  p40 = (((unsigned long long)(rd718)) > ((unsigned long long)(rd720)));
  // PTX:797 @%p40 bra $L__BB55_55
  if (p40) { goto L_BB55_55; }
  // PTX:799 $L__BB55_56:
L_BB55_56:;
  // PTX:800 setp.ge.u64 %p41, %rd720, %rd54
  p41 = (((unsigned long long)(rd720)) >= ((unsigned long long)(rd54)));
  // PTX:801 @%p41 bra $L__BB55_60
  if (p41) { goto L_BB55_60; }
  // PTX:803 cvt.u32.u64 %r94, %rd53
  asm("cvt.u32.u64 %0, %1;" : "=r"(r94) : "l"(rd53));
  // PTX:804 mul.lo.s64 %rd361, %rd720, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd361) : "l"(rd720), "l"(rd138));
  // PTX:805 add.s64 %rd60, %rd361, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd60) : "l"(rd361), "l"(rd18));
  // PTX:806 mul.lo.s64 %rd362, %rd60, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd362) : "l"(rd60));
  // PTX:807 add.s64 %rd363, %rd1, %rd362
  asm("add.s64 %0, %1, %2;" : "=l"(rd363) : "l"(rd1), "l"(rd362));
  // PTX:808 ld.global.u32 %r95, [%rd363]
  r95 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd363) + (0)))));
  // PTX:809 setp.ne.s32 %p42, %r95, %r94
  p42 = (((int)(r95)) != ((int)(r94)));
  // PTX:810 @%p42 bra $L__BB55_60
  if (p42) { goto L_BB55_60; }
  // PTX:812 add.s64 %rd366, %rd363, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd366) : "l"(rd363));
  // PTX:813 red.global.add.f32 [%rd366], %f55
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd366) + (0)))), (float)(f55));
  // PTX:814 add.s64 %rd367, %rd363, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd367) : "l"(rd363));
  // PTX:815 red.global.add.f32 [%rd367], %f56
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd367) + (0)))), (float)(f56));
  // PTX:816 add.s64 %rd368, %rd363, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd368) : "l"(rd363));
  // PTX:817 red.global.add.f32 [%rd368], %f57
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd368) + (0)))), (float)(f57));
  // PTX:818 add.s64 %rd369, %rd363, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd369) : "l"(rd363));
  // PTX:819 red.global.add.f32 [%rd369], %f58
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd369) + (0)))), (float)(f58));
  // PTX:820 add.s64 %rd370, %rd363, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd370) : "l"(rd363));
  // PTX:821 red.global.add.f32 [%rd370], %f59
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd370) + (0)))), (float)(f59));
  // PTX:822 add.s64 %rd371, %rd363, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd371) : "l"(rd363));
  // PTX:823 red.global.add.f32 [%rd371], %f60
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd371) + (0)))), (float)(f60));
  // PTX:824 add.s64 %rd372, %rd363, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd372) : "l"(rd363));
  // PTX:825 red.global.add.f32 [%rd372], %f61
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd372) + (0)))), (float)(f61));
  // PTX:826 add.s64 %rd373, %rd363, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd373) : "l"(rd363));
  // PTX:827 red.global.add.f32 [%rd373], %f62
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd373) + (0)))), (float)(f62));
  // PTX:828 add.s64 %rd374, %rd363, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd374) : "l"(rd363));
  // PTX:829 red.global.add.f32 [%rd374], %f63
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd374) + (0)))), (float)(f63));
  // PTX:831 $L__BB55_60:
L_BB55_60:;
  // PTX:832 cvt.u32.u64 %r97, %rd53
  asm("cvt.u32.u64 %0, %1;" : "=r"(r97) : "l"(rd53));
  // PTX:833 setp.eq.s32 %p43, %r68, %r97
  p43 = (((int)(r68)) == ((int)(r97)));
  // PTX:834 @%p43 bra $L__BB55_67
  if (p43) { goto L_BB55_67; }
  // PTX:835 bra.uni $L__BB55_61
  goto L_BB55_61;
  // PTX:837 $L__BB55_67:
L_BB55_67:;
  // PTX:838 mul.lo.s64 %rd410, %rd53, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd410) : "l"(rd53));
  // PTX:839 add.s64 %rd411, %rd2, %rd410
  asm("add.s64 %0, %1, %2;" : "=l"(rd411) : "l"(rd2), "l"(rd410));
  // PTX:840 red.global.add.f32 [%rd411], %f55
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd411) + (0)))), (float)(f55));
  // PTX:841 add.s64 %rd412, %rd411, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd412) : "l"(rd411));
  // PTX:842 red.global.add.f32 [%rd412], %f56
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd412) + (0)))), (float)(f56));
  // PTX:843 add.s64 %rd413, %rd411, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd413) : "l"(rd411));
  // PTX:844 red.global.add.f32 [%rd413], %f57
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd413) + (0)))), (float)(f57));
  // PTX:845 add.s64 %rd414, %rd411, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd414) : "l"(rd411));
  // PTX:846 red.global.add.f32 [%rd414], %f58
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd414) + (0)))), (float)(f58));
  // PTX:847 add.s64 %rd415, %rd411, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd415) : "l"(rd411));
  // PTX:848 red.global.add.f32 [%rd415], %f59
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd415) + (0)))), (float)(f59));
  // PTX:849 add.s64 %rd416, %rd411, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd416) : "l"(rd411));
  // PTX:850 red.global.add.f32 [%rd416], %f60
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd416) + (0)))), (float)(f60));
  // PTX:851 add.s64 %rd417, %rd411, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd417) : "l"(rd411));
  // PTX:852 red.global.add.f32 [%rd417], %f61
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd417) + (0)))), (float)(f61));
  // PTX:853 add.s64 %rd418, %rd411, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd418) : "l"(rd411));
  // PTX:854 red.global.add.f32 [%rd418], %f62
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd418) + (0)))), (float)(f62));
  // PTX:855 add.s64 %rd419, %rd411, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd419) : "l"(rd411));
  // PTX:856 red.global.add.f32 [%rd419], %f63
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd419) + (0)))), (float)(f63));
  // PTX:857 bra.uni $L__BB55_68
  goto L_BB55_68;
  // PTX:859 $L__BB55_61:
L_BB55_61:;
  // PTX:860 shl.b64 %rd384, %rd53, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd384) : "l"(rd53));
  // PTX:861 add.s64 %rd385, %rd3, %rd384
  asm("add.s64 %0, %1, %2;" : "=l"(rd385) : "l"(rd3), "l"(rd384));
  // PTX:862 ld.global.s32 %rd386, [%rd385]
  rd386 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd385) + (0)))));
  // PTX:863 mov.u64 %rd723, 0
  asm("mov.u64 %0, 0;" : "=l"(rd723) : );
  // PTX:864 min.u64 %rd61, %rd386, %rd135
  asm("min.u64 %0, %1, %2;" : "=l"(rd61) : "l"(rd386), "l"(rd135));
  // PTX:865 setp.eq.s64 %p44, %rd61, 0
  p44 = (((long long)(rd61)) == ((long long)(0)));
  // PTX:866 @%p44 bra $L__BB55_64
  if (p44) { goto L_BB55_64; }
  // PTX:868 mov.u64 %rd723, 0
  asm("mov.u64 %0, 0;" : "=l"(rd723) : );
  // PTX:869 mov.u64 %rd721, %rd61
  asm("mov.u64 %0, %1;" : "=l"(rd721) : "l"(rd61));
  // PTX:871 $L__BB55_63:
L_BB55_63:;
  // PTX:872 sub.s64 %rd388, %rd721, %rd723
  asm("sub.s64 %0, %1, %2;" : "=l"(rd388) : "l"(rd721), "l"(rd723));
  // PTX:873 shr.u64 %rd389, %rd388, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd389) : "l"(rd388));
  // PTX:874 add.s64 %rd390, %rd389, %rd723
  asm("add.s64 %0, %1, %2;" : "=l"(rd390) : "l"(rd389), "l"(rd723));
  // PTX:875 mul.lo.s64 %rd391, %rd390, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd391) : "l"(rd390), "l"(rd138));
  // PTX:876 add.s64 %rd392, %rd391, %rd53
  asm("add.s64 %0, %1, %2;" : "=l"(rd392) : "l"(rd391), "l"(rd53));
  // PTX:877 mul.lo.s64 %rd393, %rd392, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd393) : "l"(rd392));
  // PTX:878 add.s64 %rd394, %rd1, %rd393
  asm("add.s64 %0, %1, %2;" : "=l"(rd394) : "l"(rd1), "l"(rd393));
  // PTX:879 ld.global.u32 %r98, [%rd394]
  r98 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd394) + (0)))));
  // PTX:880 setp.lt.s32 %p45, %r98, %r68
  p45 = (((int)(r98)) < ((int)(r68)));
  // PTX:881 add.s64 %rd395, %rd390, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd395) : "l"(rd390));
  // PTX:882 selp.b64 %rd723, %rd395, %rd723, %p45
  rd723 = p45 ? rd395 : rd723;
  // PTX:883 selp.b64 %rd721, %rd721, %rd390, %p45
  rd721 = p45 ? rd721 : rd390;
  // PTX:884 setp.gt.u64 %p46, %rd721, %rd723
  p46 = (((unsigned long long)(rd721)) > ((unsigned long long)(rd723)));
  // PTX:885 @%p46 bra $L__BB55_63
  if (p46) { goto L_BB55_63; }
  // PTX:887 $L__BB55_64:
L_BB55_64:;
  // PTX:888 setp.ge.u64 %p47, %rd723, %rd61
  p47 = (((unsigned long long)(rd723)) >= ((unsigned long long)(rd61)));
  // PTX:889 @%p47 bra $L__BB55_68
  if (p47) { goto L_BB55_68; }
  // PTX:891 mul.lo.s64 %rd396, %rd723, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd396) : "l"(rd723), "l"(rd138));
  // PTX:892 add.s64 %rd67, %rd396, %rd53
  asm("add.s64 %0, %1, %2;" : "=l"(rd67) : "l"(rd396), "l"(rd53));
  // PTX:893 mul.lo.s64 %rd397, %rd67, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd397) : "l"(rd67));
  // PTX:894 add.s64 %rd398, %rd1, %rd397
  asm("add.s64 %0, %1, %2;" : "=l"(rd398) : "l"(rd1), "l"(rd397));
  // PTX:895 ld.global.u32 %r101, [%rd398]
  r101 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd398) + (0)))));
  // PTX:896 setp.ne.s32 %p48, %r101, %r68
  p48 = (((int)(r101)) != ((int)(r68)));
  // PTX:897 @%p48 bra $L__BB55_68
  if (p48) { goto L_BB55_68; }
  // PTX:899 add.s64 %rd401, %rd398, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd401) : "l"(rd398));
  // PTX:900 red.global.add.f32 [%rd401], %f55
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd401) + (0)))), (float)(f55));
  // PTX:901 add.s64 %rd402, %rd398, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd402) : "l"(rd398));
  // PTX:902 red.global.add.f32 [%rd402], %f56
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd402) + (0)))), (float)(f56));
  // PTX:903 add.s64 %rd403, %rd398, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd403) : "l"(rd398));
  // PTX:904 red.global.add.f32 [%rd403], %f57
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd403) + (0)))), (float)(f57));
  // PTX:905 add.s64 %rd404, %rd398, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd404) : "l"(rd398));
  // PTX:906 red.global.add.f32 [%rd404], %f58
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd404) + (0)))), (float)(f58));
  // PTX:907 add.s64 %rd405, %rd398, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd405) : "l"(rd398));
  // PTX:908 red.global.add.f32 [%rd405], %f59
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd405) + (0)))), (float)(f59));
  // PTX:909 add.s64 %rd406, %rd398, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd406) : "l"(rd398));
  // PTX:910 red.global.add.f32 [%rd406], %f60
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd406) + (0)))), (float)(f60));
  // PTX:911 add.s64 %rd407, %rd398, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd407) : "l"(rd398));
  // PTX:912 red.global.add.f32 [%rd407], %f61
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd407) + (0)))), (float)(f61));
  // PTX:913 add.s64 %rd408, %rd398, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd408) : "l"(rd398));
  // PTX:914 red.global.add.f32 [%rd408], %f62
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd408) + (0)))), (float)(f62));
  // PTX:915 add.s64 %rd409, %rd398, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd409) : "l"(rd398));
  // PTX:916 red.global.add.f32 [%rd409], %f63
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd409) + (0)))), (float)(f63));
  // PTX:918 $L__BB55_68:
L_BB55_68:;
  // PTX:919 add.s32 %r102, %r165, 4
  asm("add.s32 %0, %1, 4;" : "=r"(r102) : "r"(r165));
  // PTX:920 setp.ge.s32 %p49, %r102, %r157
  p49 = (((int)(r102)) >= ((int)(r157)));
  // PTX:921 @%p49 bra $L__BB55_136
  if (p49) { goto L_BB55_136; }
  // PTX:923 ld.local.f32 %f327, [%rd21+12]
  f327 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd21) + (12)))));
  // PTX:924 mul.f32 %f328, %f35, %f327
  asm("mul.f32 %0, %1, %2;" : "=f"(f328) : "f"(f35), "f"(f327));
  // PTX:925 mul.f32 %f64, %f25, %f328
  asm("mul.f32 %0, %1, %2;" : "=f"(f64) : "f"(f25), "f"(f328));
  // PTX:926 mul.f32 %f65, %f26, %f328
  asm("mul.f32 %0, %1, %2;" : "=f"(f65) : "f"(f26), "f"(f328));
  // PTX:927 mul.f32 %f66, %f27, %f328
  asm("mul.f32 %0, %1, %2;" : "=f"(f66) : "f"(f27), "f"(f328));
  // PTX:928 mul.f32 %f67, %f28, %f328
  asm("mul.f32 %0, %1, %2;" : "=f"(f67) : "f"(f28), "f"(f328));
  // PTX:929 mul.f32 %f68, %f29, %f328
  asm("mul.f32 %0, %1, %2;" : "=f"(f68) : "f"(f29), "f"(f328));
  // PTX:930 mul.f32 %f69, %f30, %f328
  asm("mul.f32 %0, %1, %2;" : "=f"(f69) : "f"(f30), "f"(f328));
  // PTX:931 mul.f32 %f70, %f31, %f328
  asm("mul.f32 %0, %1, %2;" : "=f"(f70) : "f"(f31), "f"(f328));
  // PTX:932 mul.f32 %f71, %f32, %f328
  asm("mul.f32 %0, %1, %2;" : "=f"(f71) : "f"(f32), "f"(f328));
  // PTX:933 mul.f32 %f72, %f33, %f328
  asm("mul.f32 %0, %1, %2;" : "=f"(f72) : "f"(f33), "f"(f328));
  // PTX:934 ld.local.u32 %r104, [%rd22+12]
  r104 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd22) + (12)))));
  // PTX:935 cvt.s64.s32 %rd68, %r104
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd68) : "r"(r104));
  // PTX:936 setp.eq.s32 %p50, %r68, %r104
  p50 = (((int)(r68)) == ((int)(r104)));
  // PTX:937 @%p50 bra $L__BB55_76
  if (p50) { goto L_BB55_76; }
  // PTX:938 bra.uni $L__BB55_70
  goto L_BB55_70;
  // PTX:940 $L__BB55_76:
L_BB55_76:;
  // PTX:941 red.global.add.f32 [%rd19], %f64
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))), (float)(f64));
  // PTX:942 red.global.add.f32 [%rd198], %f65
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd198) + (0)))), (float)(f65));
  // PTX:943 red.global.add.f32 [%rd199], %f66
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd199) + (0)))), (float)(f66));
  // PTX:944 red.global.add.f32 [%rd200], %f67
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd200) + (0)))), (float)(f67));
  // PTX:945 red.global.add.f32 [%rd201], %f68
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd201) + (0)))), (float)(f68));
  // PTX:946 red.global.add.f32 [%rd202], %f69
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd202) + (0)))), (float)(f69));
  // PTX:947 red.global.add.f32 [%rd203], %f70
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd203) + (0)))), (float)(f70));
  // PTX:948 red.global.add.f32 [%rd204], %f71
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd204) + (0)))), (float)(f71));
  // PTX:949 red.global.add.f32 [%rd205], %f72
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd205) + (0)))), (float)(f72));
  // PTX:950 bra.uni $L__BB55_77
  goto L_BB55_77;
  // PTX:952 $L__BB55_70:
L_BB55_70:;
  // PTX:953 ld.global.s32 %rd421, [%rd20]
  rd421 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))));
  // PTX:954 mov.u64 %rd726, 0
  asm("mov.u64 %0, 0;" : "=l"(rd726) : );
  // PTX:955 min.u64 %rd69, %rd421, %rd135
  asm("min.u64 %0, %1, %2;" : "=l"(rd69) : "l"(rd421), "l"(rd135));
  // PTX:956 setp.eq.s64 %p51, %rd69, 0
  p51 = (((long long)(rd69)) == ((long long)(0)));
  // PTX:957 @%p51 bra $L__BB55_73
  if (p51) { goto L_BB55_73; }
  // PTX:959 mov.u64 %rd726, 0
  asm("mov.u64 %0, 0;" : "=l"(rd726) : );
  // PTX:960 mov.u64 %rd724, %rd69
  asm("mov.u64 %0, %1;" : "=l"(rd724) : "l"(rd69));
  // PTX:962 $L__BB55_72:
L_BB55_72:;
  // PTX:963 sub.s64 %rd423, %rd724, %rd726
  asm("sub.s64 %0, %1, %2;" : "=l"(rd423) : "l"(rd724), "l"(rd726));
  // PTX:964 shr.u64 %rd424, %rd423, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd424) : "l"(rd423));
  // PTX:965 add.s64 %rd425, %rd424, %rd726
  asm("add.s64 %0, %1, %2;" : "=l"(rd425) : "l"(rd424), "l"(rd726));
  // PTX:966 mul.lo.s64 %rd426, %rd425, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd426) : "l"(rd425), "l"(rd138));
  // PTX:967 add.s64 %rd427, %rd426, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd427) : "l"(rd426), "l"(rd18));
  // PTX:968 mul.lo.s64 %rd428, %rd427, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd428) : "l"(rd427));
  // PTX:969 add.s64 %rd429, %rd1, %rd428
  asm("add.s64 %0, %1, %2;" : "=l"(rd429) : "l"(rd1), "l"(rd428));
  // PTX:970 ld.global.u32 %r105, [%rd429]
  r105 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd429) + (0)))));
  // PTX:971 cvt.u32.u64 %r106, %rd68
  asm("cvt.u32.u64 %0, %1;" : "=r"(r106) : "l"(rd68));
  // PTX:972 setp.lt.s32 %p52, %r105, %r106
  p52 = (((int)(r105)) < ((int)(r106)));
  // PTX:973 add.s64 %rd430, %rd425, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd430) : "l"(rd425));
  // PTX:974 selp.b64 %rd726, %rd430, %rd726, %p52
  rd726 = p52 ? rd430 : rd726;
  // PTX:975 selp.b64 %rd724, %rd724, %rd425, %p52
  rd724 = p52 ? rd724 : rd425;
  // PTX:976 setp.gt.u64 %p53, %rd724, %rd726
  p53 = (((unsigned long long)(rd724)) > ((unsigned long long)(rd726)));
  // PTX:977 @%p53 bra $L__BB55_72
  if (p53) { goto L_BB55_72; }
  // PTX:979 $L__BB55_73:
L_BB55_73:;
  // PTX:980 setp.ge.u64 %p54, %rd726, %rd69
  p54 = (((unsigned long long)(rd726)) >= ((unsigned long long)(rd69)));
  // PTX:981 @%p54 bra $L__BB55_77
  if (p54) { goto L_BB55_77; }
  // PTX:983 cvt.u32.u64 %r107, %rd68
  asm("cvt.u32.u64 %0, %1;" : "=r"(r107) : "l"(rd68));
  // PTX:984 mul.lo.s64 %rd431, %rd726, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd431) : "l"(rd726), "l"(rd138));
  // PTX:985 add.s64 %rd75, %rd431, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd75) : "l"(rd431), "l"(rd18));
  // PTX:986 mul.lo.s64 %rd432, %rd75, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd432) : "l"(rd75));
  // PTX:987 add.s64 %rd433, %rd1, %rd432
  asm("add.s64 %0, %1, %2;" : "=l"(rd433) : "l"(rd1), "l"(rd432));
  // PTX:988 ld.global.u32 %r108, [%rd433]
  r108 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd433) + (0)))));
  // PTX:989 setp.ne.s32 %p55, %r108, %r107
  p55 = (((int)(r108)) != ((int)(r107)));
  // PTX:990 @%p55 bra $L__BB55_77
  if (p55) { goto L_BB55_77; }
  // PTX:992 add.s64 %rd436, %rd433, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd436) : "l"(rd433));
  // PTX:993 red.global.add.f32 [%rd436], %f64
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd436) + (0)))), (float)(f64));
  // PTX:994 add.s64 %rd437, %rd433, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd437) : "l"(rd433));
  // PTX:995 red.global.add.f32 [%rd437], %f65
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd437) + (0)))), (float)(f65));
  // PTX:996 add.s64 %rd438, %rd433, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd438) : "l"(rd433));
  // PTX:997 red.global.add.f32 [%rd438], %f66
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd438) + (0)))), (float)(f66));
  // PTX:998 add.s64 %rd439, %rd433, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd439) : "l"(rd433));
  // PTX:999 red.global.add.f32 [%rd439], %f67
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd439) + (0)))), (float)(f67));
  // PTX:1000 add.s64 %rd440, %rd433, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd440) : "l"(rd433));
  // PTX:1001 red.global.add.f32 [%rd440], %f68
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd440) + (0)))), (float)(f68));
  // PTX:1002 add.s64 %rd441, %rd433, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd441) : "l"(rd433));
  // PTX:1003 red.global.add.f32 [%rd441], %f69
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd441) + (0)))), (float)(f69));
  // PTX:1004 add.s64 %rd442, %rd433, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd442) : "l"(rd433));
  // PTX:1005 red.global.add.f32 [%rd442], %f70
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd442) + (0)))), (float)(f70));
  // PTX:1006 add.s64 %rd443, %rd433, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd443) : "l"(rd433));
  // PTX:1007 red.global.add.f32 [%rd443], %f71
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd443) + (0)))), (float)(f71));
  // PTX:1008 add.s64 %rd444, %rd433, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd444) : "l"(rd433));
  // PTX:1009 red.global.add.f32 [%rd444], %f72
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd444) + (0)))), (float)(f72));
  // PTX:1011 $L__BB55_77:
L_BB55_77:;
  // PTX:1012 cvt.u32.u64 %r110, %rd68
  asm("cvt.u32.u64 %0, %1;" : "=r"(r110) : "l"(rd68));
  // PTX:1013 setp.eq.s32 %p56, %r68, %r110
  p56 = (((int)(r68)) == ((int)(r110)));
  // PTX:1014 @%p56 bra $L__BB55_84
  if (p56) { goto L_BB55_84; }
  // PTX:1015 bra.uni $L__BB55_78
  goto L_BB55_78;
  // PTX:1017 $L__BB55_84:
L_BB55_84:;
  // PTX:1018 mul.lo.s64 %rd480, %rd68, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd480) : "l"(rd68));
  // PTX:1019 add.s64 %rd481, %rd2, %rd480
  asm("add.s64 %0, %1, %2;" : "=l"(rd481) : "l"(rd2), "l"(rd480));
  // PTX:1020 red.global.add.f32 [%rd481], %f64
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd481) + (0)))), (float)(f64));
  // PTX:1021 add.s64 %rd482, %rd481, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd482) : "l"(rd481));
  // PTX:1022 red.global.add.f32 [%rd482], %f65
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd482) + (0)))), (float)(f65));
  // PTX:1023 add.s64 %rd483, %rd481, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd483) : "l"(rd481));
  // PTX:1024 red.global.add.f32 [%rd483], %f66
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd483) + (0)))), (float)(f66));
  // PTX:1025 add.s64 %rd484, %rd481, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd484) : "l"(rd481));
  // PTX:1026 red.global.add.f32 [%rd484], %f67
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd484) + (0)))), (float)(f67));
  // PTX:1027 add.s64 %rd485, %rd481, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd485) : "l"(rd481));
  // PTX:1028 red.global.add.f32 [%rd485], %f68
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd485) + (0)))), (float)(f68));
  // PTX:1029 add.s64 %rd486, %rd481, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd486) : "l"(rd481));
  // PTX:1030 red.global.add.f32 [%rd486], %f69
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd486) + (0)))), (float)(f69));
  // PTX:1031 add.s64 %rd487, %rd481, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd487) : "l"(rd481));
  // PTX:1032 red.global.add.f32 [%rd487], %f70
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd487) + (0)))), (float)(f70));
  // PTX:1033 add.s64 %rd488, %rd481, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd488) : "l"(rd481));
  // PTX:1034 red.global.add.f32 [%rd488], %f71
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd488) + (0)))), (float)(f71));
  // PTX:1035 add.s64 %rd489, %rd481, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd489) : "l"(rd481));
  // PTX:1036 red.global.add.f32 [%rd489], %f72
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd489) + (0)))), (float)(f72));
  // PTX:1037 bra.uni $L__BB55_85
  goto L_BB55_85;
  // PTX:1039 $L__BB55_78:
L_BB55_78:;
  // PTX:1040 shl.b64 %rd454, %rd68, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd454) : "l"(rd68));
  // PTX:1041 add.s64 %rd455, %rd3, %rd454
  asm("add.s64 %0, %1, %2;" : "=l"(rd455) : "l"(rd3), "l"(rd454));
  // PTX:1042 ld.global.s32 %rd456, [%rd455]
  rd456 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd455) + (0)))));
  // PTX:1043 mov.u64 %rd729, 0
  asm("mov.u64 %0, 0;" : "=l"(rd729) : );
  // PTX:1044 min.u64 %rd76, %rd456, %rd135
  asm("min.u64 %0, %1, %2;" : "=l"(rd76) : "l"(rd456), "l"(rd135));
  // PTX:1045 setp.eq.s64 %p57, %rd76, 0
  p57 = (((long long)(rd76)) == ((long long)(0)));
  // PTX:1046 @%p57 bra $L__BB55_81
  if (p57) { goto L_BB55_81; }
  // PTX:1048 mov.u64 %rd729, 0
  asm("mov.u64 %0, 0;" : "=l"(rd729) : );
  // PTX:1049 mov.u64 %rd727, %rd76
  asm("mov.u64 %0, %1;" : "=l"(rd727) : "l"(rd76));
  // PTX:1051 $L__BB55_80:
L_BB55_80:;
  // PTX:1052 sub.s64 %rd458, %rd727, %rd729
  asm("sub.s64 %0, %1, %2;" : "=l"(rd458) : "l"(rd727), "l"(rd729));
  // PTX:1053 shr.u64 %rd459, %rd458, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd459) : "l"(rd458));
  // PTX:1054 add.s64 %rd460, %rd459, %rd729
  asm("add.s64 %0, %1, %2;" : "=l"(rd460) : "l"(rd459), "l"(rd729));
  // PTX:1055 mul.lo.s64 %rd461, %rd460, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd461) : "l"(rd460), "l"(rd138));
  // PTX:1056 add.s64 %rd462, %rd461, %rd68
  asm("add.s64 %0, %1, %2;" : "=l"(rd462) : "l"(rd461), "l"(rd68));
  // PTX:1057 mul.lo.s64 %rd463, %rd462, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd463) : "l"(rd462));
  // PTX:1058 add.s64 %rd464, %rd1, %rd463
  asm("add.s64 %0, %1, %2;" : "=l"(rd464) : "l"(rd1), "l"(rd463));
  // PTX:1059 ld.global.u32 %r111, [%rd464]
  r111 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd464) + (0)))));
  // PTX:1060 setp.lt.s32 %p58, %r111, %r68
  p58 = (((int)(r111)) < ((int)(r68)));
  // PTX:1061 add.s64 %rd465, %rd460, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd465) : "l"(rd460));
  // PTX:1062 selp.b64 %rd729, %rd465, %rd729, %p58
  rd729 = p58 ? rd465 : rd729;
  // PTX:1063 selp.b64 %rd727, %rd727, %rd460, %p58
  rd727 = p58 ? rd727 : rd460;
  // PTX:1064 setp.gt.u64 %p59, %rd727, %rd729
  p59 = (((unsigned long long)(rd727)) > ((unsigned long long)(rd729)));
  // PTX:1065 @%p59 bra $L__BB55_80
  if (p59) { goto L_BB55_80; }
  // PTX:1067 $L__BB55_81:
L_BB55_81:;
  // PTX:1068 setp.ge.u64 %p60, %rd729, %rd76
  p60 = (((unsigned long long)(rd729)) >= ((unsigned long long)(rd76)));
  // PTX:1069 @%p60 bra $L__BB55_85
  if (p60) { goto L_BB55_85; }
  // PTX:1071 mul.lo.s64 %rd466, %rd729, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd466) : "l"(rd729), "l"(rd138));
  // PTX:1072 add.s64 %rd82, %rd466, %rd68
  asm("add.s64 %0, %1, %2;" : "=l"(rd82) : "l"(rd466), "l"(rd68));
  // PTX:1073 mul.lo.s64 %rd467, %rd82, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd467) : "l"(rd82));
  // PTX:1074 add.s64 %rd468, %rd1, %rd467
  asm("add.s64 %0, %1, %2;" : "=l"(rd468) : "l"(rd1), "l"(rd467));
  // PTX:1075 ld.global.u32 %r114, [%rd468]
  r114 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd468) + (0)))));
  // PTX:1076 setp.ne.s32 %p61, %r114, %r68
  p61 = (((int)(r114)) != ((int)(r68)));
  // PTX:1077 @%p61 bra $L__BB55_85
  if (p61) { goto L_BB55_85; }
  // PTX:1079 add.s64 %rd471, %rd468, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd471) : "l"(rd468));
  // PTX:1080 red.global.add.f32 [%rd471], %f64
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd471) + (0)))), (float)(f64));
  // PTX:1081 add.s64 %rd472, %rd468, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd472) : "l"(rd468));
  // PTX:1082 red.global.add.f32 [%rd472], %f65
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd472) + (0)))), (float)(f65));
  // PTX:1083 add.s64 %rd473, %rd468, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd473) : "l"(rd468));
  // PTX:1084 red.global.add.f32 [%rd473], %f66
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd473) + (0)))), (float)(f66));
  // PTX:1085 add.s64 %rd474, %rd468, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd474) : "l"(rd468));
  // PTX:1086 red.global.add.f32 [%rd474], %f67
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd474) + (0)))), (float)(f67));
  // PTX:1087 add.s64 %rd475, %rd468, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd475) : "l"(rd468));
  // PTX:1088 red.global.add.f32 [%rd475], %f68
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd475) + (0)))), (float)(f68));
  // PTX:1089 add.s64 %rd476, %rd468, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd476) : "l"(rd468));
  // PTX:1090 red.global.add.f32 [%rd476], %f69
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd476) + (0)))), (float)(f69));
  // PTX:1091 add.s64 %rd477, %rd468, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd477) : "l"(rd468));
  // PTX:1092 red.global.add.f32 [%rd477], %f70
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd477) + (0)))), (float)(f70));
  // PTX:1093 add.s64 %rd478, %rd468, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd478) : "l"(rd468));
  // PTX:1094 red.global.add.f32 [%rd478], %f71
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd478) + (0)))), (float)(f71));
  // PTX:1095 add.s64 %rd479, %rd468, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd479) : "l"(rd468));
  // PTX:1096 red.global.add.f32 [%rd479], %f72
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd479) + (0)))), (float)(f72));
  // PTX:1098 $L__BB55_85:
L_BB55_85:;
  // PTX:1099 add.s32 %r115, %r165, 5
  asm("add.s32 %0, %1, 5;" : "=r"(r115) : "r"(r165));
  // PTX:1100 setp.ge.s32 %p62, %r115, %r157
  p62 = (((int)(r115)) >= ((int)(r157)));
  // PTX:1101 @%p62 bra $L__BB55_136
  if (p62) { goto L_BB55_136; }
  // PTX:1103 ld.local.f32 %f365, [%rd21+16]
  f365 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd21) + (16)))));
  // PTX:1104 mul.f32 %f366, %f35, %f365
  asm("mul.f32 %0, %1, %2;" : "=f"(f366) : "f"(f35), "f"(f365));
  // PTX:1105 mul.f32 %f73, %f25, %f366
  asm("mul.f32 %0, %1, %2;" : "=f"(f73) : "f"(f25), "f"(f366));
  // PTX:1106 mul.f32 %f74, %f26, %f366
  asm("mul.f32 %0, %1, %2;" : "=f"(f74) : "f"(f26), "f"(f366));
  // PTX:1107 mul.f32 %f75, %f27, %f366
  asm("mul.f32 %0, %1, %2;" : "=f"(f75) : "f"(f27), "f"(f366));
  // PTX:1108 mul.f32 %f76, %f28, %f366
  asm("mul.f32 %0, %1, %2;" : "=f"(f76) : "f"(f28), "f"(f366));
  // PTX:1109 mul.f32 %f77, %f29, %f366
  asm("mul.f32 %0, %1, %2;" : "=f"(f77) : "f"(f29), "f"(f366));
  // PTX:1110 mul.f32 %f78, %f30, %f366
  asm("mul.f32 %0, %1, %2;" : "=f"(f78) : "f"(f30), "f"(f366));
  // PTX:1111 mul.f32 %f79, %f31, %f366
  asm("mul.f32 %0, %1, %2;" : "=f"(f79) : "f"(f31), "f"(f366));
  // PTX:1112 mul.f32 %f80, %f32, %f366
  asm("mul.f32 %0, %1, %2;" : "=f"(f80) : "f"(f32), "f"(f366));
  // PTX:1113 mul.f32 %f81, %f33, %f366
  asm("mul.f32 %0, %1, %2;" : "=f"(f81) : "f"(f33), "f"(f366));
  // PTX:1114 ld.local.u32 %r117, [%rd22+16]
  r117 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd22) + (16)))));
  // PTX:1115 cvt.s64.s32 %rd83, %r117
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd83) : "r"(r117));
  // PTX:1116 setp.eq.s32 %p63, %r68, %r117
  p63 = (((int)(r68)) == ((int)(r117)));
  // PTX:1117 @%p63 bra $L__BB55_93
  if (p63) { goto L_BB55_93; }
  // PTX:1118 bra.uni $L__BB55_87
  goto L_BB55_87;
  // PTX:1120 $L__BB55_93:
L_BB55_93:;
  // PTX:1121 red.global.add.f32 [%rd19], %f73
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))), (float)(f73));
  // PTX:1122 red.global.add.f32 [%rd198], %f74
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd198) + (0)))), (float)(f74));
  // PTX:1123 red.global.add.f32 [%rd199], %f75
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd199) + (0)))), (float)(f75));
  // PTX:1124 red.global.add.f32 [%rd200], %f76
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd200) + (0)))), (float)(f76));
  // PTX:1125 red.global.add.f32 [%rd201], %f77
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd201) + (0)))), (float)(f77));
  // PTX:1126 red.global.add.f32 [%rd202], %f78
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd202) + (0)))), (float)(f78));
  // PTX:1127 red.global.add.f32 [%rd203], %f79
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd203) + (0)))), (float)(f79));
  // PTX:1128 red.global.add.f32 [%rd204], %f80
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd204) + (0)))), (float)(f80));
  // PTX:1129 red.global.add.f32 [%rd205], %f81
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd205) + (0)))), (float)(f81));
  // PTX:1130 bra.uni $L__BB55_94
  goto L_BB55_94;
  // PTX:1132 $L__BB55_87:
L_BB55_87:;
  // PTX:1133 ld.global.s32 %rd491, [%rd20]
  rd491 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))));
  // PTX:1134 mov.u64 %rd732, 0
  asm("mov.u64 %0, 0;" : "=l"(rd732) : );
  // PTX:1135 min.u64 %rd84, %rd491, %rd135
  asm("min.u64 %0, %1, %2;" : "=l"(rd84) : "l"(rd491), "l"(rd135));
  // PTX:1136 setp.eq.s64 %p64, %rd84, 0
  p64 = (((long long)(rd84)) == ((long long)(0)));
  // PTX:1137 @%p64 bra $L__BB55_90
  if (p64) { goto L_BB55_90; }
  // PTX:1139 mov.u64 %rd732, 0
  asm("mov.u64 %0, 0;" : "=l"(rd732) : );
  // PTX:1140 mov.u64 %rd730, %rd84
  asm("mov.u64 %0, %1;" : "=l"(rd730) : "l"(rd84));
  // PTX:1142 $L__BB55_89:
L_BB55_89:;
  // PTX:1143 sub.s64 %rd493, %rd730, %rd732
  asm("sub.s64 %0, %1, %2;" : "=l"(rd493) : "l"(rd730), "l"(rd732));
  // PTX:1144 shr.u64 %rd494, %rd493, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd494) : "l"(rd493));
  // PTX:1145 add.s64 %rd495, %rd494, %rd732
  asm("add.s64 %0, %1, %2;" : "=l"(rd495) : "l"(rd494), "l"(rd732));
  // PTX:1146 mul.lo.s64 %rd496, %rd495, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd496) : "l"(rd495), "l"(rd138));
  // PTX:1147 add.s64 %rd497, %rd496, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd497) : "l"(rd496), "l"(rd18));
  // PTX:1148 mul.lo.s64 %rd498, %rd497, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd498) : "l"(rd497));
  // PTX:1149 add.s64 %rd499, %rd1, %rd498
  asm("add.s64 %0, %1, %2;" : "=l"(rd499) : "l"(rd1), "l"(rd498));
  // PTX:1150 ld.global.u32 %r118, [%rd499]
  r118 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd499) + (0)))));
  // PTX:1151 cvt.u32.u64 %r119, %rd83
  asm("cvt.u32.u64 %0, %1;" : "=r"(r119) : "l"(rd83));
  // PTX:1152 setp.lt.s32 %p65, %r118, %r119
  p65 = (((int)(r118)) < ((int)(r119)));
  // PTX:1153 add.s64 %rd500, %rd495, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd500) : "l"(rd495));
  // PTX:1154 selp.b64 %rd732, %rd500, %rd732, %p65
  rd732 = p65 ? rd500 : rd732;
  // PTX:1155 selp.b64 %rd730, %rd730, %rd495, %p65
  rd730 = p65 ? rd730 : rd495;
  // PTX:1156 setp.gt.u64 %p66, %rd730, %rd732
  p66 = (((unsigned long long)(rd730)) > ((unsigned long long)(rd732)));
  // PTX:1157 @%p66 bra $L__BB55_89
  if (p66) { goto L_BB55_89; }
  // PTX:1159 $L__BB55_90:
L_BB55_90:;
  // PTX:1160 setp.ge.u64 %p67, %rd732, %rd84
  p67 = (((unsigned long long)(rd732)) >= ((unsigned long long)(rd84)));
  // PTX:1161 @%p67 bra $L__BB55_94
  if (p67) { goto L_BB55_94; }
  // PTX:1163 cvt.u32.u64 %r120, %rd83
  asm("cvt.u32.u64 %0, %1;" : "=r"(r120) : "l"(rd83));
  // PTX:1164 mul.lo.s64 %rd501, %rd732, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd501) : "l"(rd732), "l"(rd138));
  // PTX:1165 add.s64 %rd90, %rd501, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd90) : "l"(rd501), "l"(rd18));
  // PTX:1166 mul.lo.s64 %rd502, %rd90, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd502) : "l"(rd90));
  // PTX:1167 add.s64 %rd503, %rd1, %rd502
  asm("add.s64 %0, %1, %2;" : "=l"(rd503) : "l"(rd1), "l"(rd502));
  // PTX:1168 ld.global.u32 %r121, [%rd503]
  r121 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd503) + (0)))));
  // PTX:1169 setp.ne.s32 %p68, %r121, %r120
  p68 = (((int)(r121)) != ((int)(r120)));
  // PTX:1170 @%p68 bra $L__BB55_94
  if (p68) { goto L_BB55_94; }
  // PTX:1172 add.s64 %rd506, %rd503, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd506) : "l"(rd503));
  // PTX:1173 red.global.add.f32 [%rd506], %f73
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd506) + (0)))), (float)(f73));
  // PTX:1174 add.s64 %rd507, %rd503, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd507) : "l"(rd503));
  // PTX:1175 red.global.add.f32 [%rd507], %f74
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd507) + (0)))), (float)(f74));
  // PTX:1176 add.s64 %rd508, %rd503, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd508) : "l"(rd503));
  // PTX:1177 red.global.add.f32 [%rd508], %f75
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd508) + (0)))), (float)(f75));
  // PTX:1178 add.s64 %rd509, %rd503, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd509) : "l"(rd503));
  // PTX:1179 red.global.add.f32 [%rd509], %f76
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd509) + (0)))), (float)(f76));
  // PTX:1180 add.s64 %rd510, %rd503, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd510) : "l"(rd503));
  // PTX:1181 red.global.add.f32 [%rd510], %f77
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd510) + (0)))), (float)(f77));
  // PTX:1182 add.s64 %rd511, %rd503, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd511) : "l"(rd503));
  // PTX:1183 red.global.add.f32 [%rd511], %f78
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd511) + (0)))), (float)(f78));
  // PTX:1184 add.s64 %rd512, %rd503, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd512) : "l"(rd503));
  // PTX:1185 red.global.add.f32 [%rd512], %f79
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd512) + (0)))), (float)(f79));
  // PTX:1186 add.s64 %rd513, %rd503, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd513) : "l"(rd503));
  // PTX:1187 red.global.add.f32 [%rd513], %f80
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd513) + (0)))), (float)(f80));
  // PTX:1188 add.s64 %rd514, %rd503, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd514) : "l"(rd503));
  // PTX:1189 red.global.add.f32 [%rd514], %f81
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd514) + (0)))), (float)(f81));
  // PTX:1191 $L__BB55_94:
L_BB55_94:;
  // PTX:1192 cvt.u32.u64 %r123, %rd83
  asm("cvt.u32.u64 %0, %1;" : "=r"(r123) : "l"(rd83));
  // PTX:1193 setp.eq.s32 %p69, %r68, %r123
  p69 = (((int)(r68)) == ((int)(r123)));
  // PTX:1194 @%p69 bra $L__BB55_101
  if (p69) { goto L_BB55_101; }
  // PTX:1195 bra.uni $L__BB55_95
  goto L_BB55_95;
  // PTX:1197 $L__BB55_101:
L_BB55_101:;
  // PTX:1198 mul.lo.s64 %rd550, %rd83, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd550) : "l"(rd83));
  // PTX:1199 add.s64 %rd551, %rd2, %rd550
  asm("add.s64 %0, %1, %2;" : "=l"(rd551) : "l"(rd2), "l"(rd550));
  // PTX:1200 red.global.add.f32 [%rd551], %f73
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd551) + (0)))), (float)(f73));
  // PTX:1201 add.s64 %rd552, %rd551, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd552) : "l"(rd551));
  // PTX:1202 red.global.add.f32 [%rd552], %f74
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd552) + (0)))), (float)(f74));
  // PTX:1203 add.s64 %rd553, %rd551, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd553) : "l"(rd551));
  // PTX:1204 red.global.add.f32 [%rd553], %f75
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd553) + (0)))), (float)(f75));
  // PTX:1205 add.s64 %rd554, %rd551, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd554) : "l"(rd551));
  // PTX:1206 red.global.add.f32 [%rd554], %f76
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd554) + (0)))), (float)(f76));
  // PTX:1207 add.s64 %rd555, %rd551, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd555) : "l"(rd551));
  // PTX:1208 red.global.add.f32 [%rd555], %f77
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd555) + (0)))), (float)(f77));
  // PTX:1209 add.s64 %rd556, %rd551, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd556) : "l"(rd551));
  // PTX:1210 red.global.add.f32 [%rd556], %f78
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd556) + (0)))), (float)(f78));
  // PTX:1211 add.s64 %rd557, %rd551, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd557) : "l"(rd551));
  // PTX:1212 red.global.add.f32 [%rd557], %f79
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd557) + (0)))), (float)(f79));
  // PTX:1213 add.s64 %rd558, %rd551, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd558) : "l"(rd551));
  // PTX:1214 red.global.add.f32 [%rd558], %f80
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd558) + (0)))), (float)(f80));
  // PTX:1215 add.s64 %rd559, %rd551, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd559) : "l"(rd551));
  // PTX:1216 red.global.add.f32 [%rd559], %f81
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd559) + (0)))), (float)(f81));
  // PTX:1217 bra.uni $L__BB55_102
  goto L_BB55_102;
  // PTX:1219 $L__BB55_95:
L_BB55_95:;
  // PTX:1220 shl.b64 %rd524, %rd83, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd524) : "l"(rd83));
  // PTX:1221 add.s64 %rd525, %rd3, %rd524
  asm("add.s64 %0, %1, %2;" : "=l"(rd525) : "l"(rd3), "l"(rd524));
  // PTX:1222 ld.global.s32 %rd526, [%rd525]
  rd526 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd525) + (0)))));
  // PTX:1223 mov.u64 %rd735, 0
  asm("mov.u64 %0, 0;" : "=l"(rd735) : );
  // PTX:1224 min.u64 %rd91, %rd526, %rd135
  asm("min.u64 %0, %1, %2;" : "=l"(rd91) : "l"(rd526), "l"(rd135));
  // PTX:1225 setp.eq.s64 %p70, %rd91, 0
  p70 = (((long long)(rd91)) == ((long long)(0)));
  // PTX:1226 @%p70 bra $L__BB55_98
  if (p70) { goto L_BB55_98; }
  // PTX:1228 mov.u64 %rd735, 0
  asm("mov.u64 %0, 0;" : "=l"(rd735) : );
  // PTX:1229 mov.u64 %rd733, %rd91
  asm("mov.u64 %0, %1;" : "=l"(rd733) : "l"(rd91));
  // PTX:1231 $L__BB55_97:
L_BB55_97:;
  // PTX:1232 sub.s64 %rd528, %rd733, %rd735
  asm("sub.s64 %0, %1, %2;" : "=l"(rd528) : "l"(rd733), "l"(rd735));
  // PTX:1233 shr.u64 %rd529, %rd528, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd529) : "l"(rd528));
  // PTX:1234 add.s64 %rd530, %rd529, %rd735
  asm("add.s64 %0, %1, %2;" : "=l"(rd530) : "l"(rd529), "l"(rd735));
  // PTX:1235 mul.lo.s64 %rd531, %rd530, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd531) : "l"(rd530), "l"(rd138));
  // PTX:1236 add.s64 %rd532, %rd531, %rd83
  asm("add.s64 %0, %1, %2;" : "=l"(rd532) : "l"(rd531), "l"(rd83));
  // PTX:1237 mul.lo.s64 %rd533, %rd532, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd533) : "l"(rd532));
  // PTX:1238 add.s64 %rd534, %rd1, %rd533
  asm("add.s64 %0, %1, %2;" : "=l"(rd534) : "l"(rd1), "l"(rd533));
  // PTX:1239 ld.global.u32 %r124, [%rd534]
  r124 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd534) + (0)))));
  // PTX:1240 setp.lt.s32 %p71, %r124, %r68
  p71 = (((int)(r124)) < ((int)(r68)));
  // PTX:1241 add.s64 %rd535, %rd530, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd535) : "l"(rd530));
  // PTX:1242 selp.b64 %rd735, %rd535, %rd735, %p71
  rd735 = p71 ? rd535 : rd735;
  // PTX:1243 selp.b64 %rd733, %rd733, %rd530, %p71
  rd733 = p71 ? rd733 : rd530;
  // PTX:1244 setp.gt.u64 %p72, %rd733, %rd735
  p72 = (((unsigned long long)(rd733)) > ((unsigned long long)(rd735)));
  // PTX:1245 @%p72 bra $L__BB55_97
  if (p72) { goto L_BB55_97; }
  // PTX:1247 $L__BB55_98:
L_BB55_98:;
  // PTX:1248 setp.ge.u64 %p73, %rd735, %rd91
  p73 = (((unsigned long long)(rd735)) >= ((unsigned long long)(rd91)));
  // PTX:1249 @%p73 bra $L__BB55_102
  if (p73) { goto L_BB55_102; }
  // PTX:1251 mul.lo.s64 %rd536, %rd735, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd536) : "l"(rd735), "l"(rd138));
  // PTX:1252 add.s64 %rd97, %rd536, %rd83
  asm("add.s64 %0, %1, %2;" : "=l"(rd97) : "l"(rd536), "l"(rd83));
  // PTX:1253 mul.lo.s64 %rd537, %rd97, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd537) : "l"(rd97));
  // PTX:1254 add.s64 %rd538, %rd1, %rd537
  asm("add.s64 %0, %1, %2;" : "=l"(rd538) : "l"(rd1), "l"(rd537));
  // PTX:1255 ld.global.u32 %r127, [%rd538]
  r127 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd538) + (0)))));
  // PTX:1256 setp.ne.s32 %p74, %r127, %r68
  p74 = (((int)(r127)) != ((int)(r68)));
  // PTX:1257 @%p74 bra $L__BB55_102
  if (p74) { goto L_BB55_102; }
  // PTX:1259 add.s64 %rd541, %rd538, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd541) : "l"(rd538));
  // PTX:1260 red.global.add.f32 [%rd541], %f73
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd541) + (0)))), (float)(f73));
  // PTX:1261 add.s64 %rd542, %rd538, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd542) : "l"(rd538));
  // PTX:1262 red.global.add.f32 [%rd542], %f74
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd542) + (0)))), (float)(f74));
  // PTX:1263 add.s64 %rd543, %rd538, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd543) : "l"(rd538));
  // PTX:1264 red.global.add.f32 [%rd543], %f75
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd543) + (0)))), (float)(f75));
  // PTX:1265 add.s64 %rd544, %rd538, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd544) : "l"(rd538));
  // PTX:1266 red.global.add.f32 [%rd544], %f76
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd544) + (0)))), (float)(f76));
  // PTX:1267 add.s64 %rd545, %rd538, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd545) : "l"(rd538));
  // PTX:1268 red.global.add.f32 [%rd545], %f77
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd545) + (0)))), (float)(f77));
  // PTX:1269 add.s64 %rd546, %rd538, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd546) : "l"(rd538));
  // PTX:1270 red.global.add.f32 [%rd546], %f78
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd546) + (0)))), (float)(f78));
  // PTX:1271 add.s64 %rd547, %rd538, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd547) : "l"(rd538));
  // PTX:1272 red.global.add.f32 [%rd547], %f79
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd547) + (0)))), (float)(f79));
  // PTX:1273 add.s64 %rd548, %rd538, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd548) : "l"(rd538));
  // PTX:1274 red.global.add.f32 [%rd548], %f80
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd548) + (0)))), (float)(f80));
  // PTX:1275 add.s64 %rd549, %rd538, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd549) : "l"(rd538));
  // PTX:1276 red.global.add.f32 [%rd549], %f81
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd549) + (0)))), (float)(f81));
  // PTX:1278 $L__BB55_102:
L_BB55_102:;
  // PTX:1279 add.s32 %r128, %r165, 6
  asm("add.s32 %0, %1, 6;" : "=r"(r128) : "r"(r165));
  // PTX:1280 setp.ge.s32 %p75, %r128, %r157
  p75 = (((int)(r128)) >= ((int)(r157)));
  // PTX:1281 @%p75 bra $L__BB55_136
  if (p75) { goto L_BB55_136; }
  // PTX:1283 ld.local.f32 %f403, [%rd21+20]
  f403 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd21) + (20)))));
  // PTX:1284 mul.f32 %f404, %f35, %f403
  asm("mul.f32 %0, %1, %2;" : "=f"(f404) : "f"(f35), "f"(f403));
  // PTX:1285 mul.f32 %f82, %f25, %f404
  asm("mul.f32 %0, %1, %2;" : "=f"(f82) : "f"(f25), "f"(f404));
  // PTX:1286 mul.f32 %f83, %f26, %f404
  asm("mul.f32 %0, %1, %2;" : "=f"(f83) : "f"(f26), "f"(f404));
  // PTX:1287 mul.f32 %f84, %f27, %f404
  asm("mul.f32 %0, %1, %2;" : "=f"(f84) : "f"(f27), "f"(f404));
  // PTX:1288 mul.f32 %f85, %f28, %f404
  asm("mul.f32 %0, %1, %2;" : "=f"(f85) : "f"(f28), "f"(f404));
  // PTX:1289 mul.f32 %f86, %f29, %f404
  asm("mul.f32 %0, %1, %2;" : "=f"(f86) : "f"(f29), "f"(f404));
  // PTX:1290 mul.f32 %f87, %f30, %f404
  asm("mul.f32 %0, %1, %2;" : "=f"(f87) : "f"(f30), "f"(f404));
  // PTX:1291 mul.f32 %f88, %f31, %f404
  asm("mul.f32 %0, %1, %2;" : "=f"(f88) : "f"(f31), "f"(f404));
  // PTX:1292 mul.f32 %f89, %f32, %f404
  asm("mul.f32 %0, %1, %2;" : "=f"(f89) : "f"(f32), "f"(f404));
  // PTX:1293 mul.f32 %f90, %f33, %f404
  asm("mul.f32 %0, %1, %2;" : "=f"(f90) : "f"(f33), "f"(f404));
  // PTX:1294 ld.local.u32 %r130, [%rd22+20]
  r130 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd22) + (20)))));
  // PTX:1295 cvt.s64.s32 %rd98, %r130
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd98) : "r"(r130));
  // PTX:1296 setp.eq.s32 %p76, %r68, %r130
  p76 = (((int)(r68)) == ((int)(r130)));
  // PTX:1297 @%p76 bra $L__BB55_110
  if (p76) { goto L_BB55_110; }
  // PTX:1298 bra.uni $L__BB55_104
  goto L_BB55_104;
  // PTX:1300 $L__BB55_110:
L_BB55_110:;
  // PTX:1301 red.global.add.f32 [%rd19], %f82
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))), (float)(f82));
  // PTX:1302 red.global.add.f32 [%rd198], %f83
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd198) + (0)))), (float)(f83));
  // PTX:1303 red.global.add.f32 [%rd199], %f84
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd199) + (0)))), (float)(f84));
  // PTX:1304 red.global.add.f32 [%rd200], %f85
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd200) + (0)))), (float)(f85));
  // PTX:1305 red.global.add.f32 [%rd201], %f86
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd201) + (0)))), (float)(f86));
  // PTX:1306 red.global.add.f32 [%rd202], %f87
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd202) + (0)))), (float)(f87));
  // PTX:1307 red.global.add.f32 [%rd203], %f88
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd203) + (0)))), (float)(f88));
  // PTX:1308 red.global.add.f32 [%rd204], %f89
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd204) + (0)))), (float)(f89));
  // PTX:1309 red.global.add.f32 [%rd205], %f90
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd205) + (0)))), (float)(f90));
  // PTX:1310 bra.uni $L__BB55_111
  goto L_BB55_111;
  // PTX:1312 $L__BB55_104:
L_BB55_104:;
  // PTX:1313 ld.global.s32 %rd561, [%rd20]
  rd561 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))));
  // PTX:1314 mov.u64 %rd738, 0
  asm("mov.u64 %0, 0;" : "=l"(rd738) : );
  // PTX:1315 min.u64 %rd99, %rd561, %rd135
  asm("min.u64 %0, %1, %2;" : "=l"(rd99) : "l"(rd561), "l"(rd135));
  // PTX:1316 setp.eq.s64 %p77, %rd99, 0
  p77 = (((long long)(rd99)) == ((long long)(0)));
  // PTX:1317 @%p77 bra $L__BB55_107
  if (p77) { goto L_BB55_107; }
  // PTX:1319 mov.u64 %rd738, 0
  asm("mov.u64 %0, 0;" : "=l"(rd738) : );
  // PTX:1320 mov.u64 %rd736, %rd99
  asm("mov.u64 %0, %1;" : "=l"(rd736) : "l"(rd99));
  // PTX:1322 $L__BB55_106:
L_BB55_106:;
  // PTX:1323 sub.s64 %rd563, %rd736, %rd738
  asm("sub.s64 %0, %1, %2;" : "=l"(rd563) : "l"(rd736), "l"(rd738));
  // PTX:1324 shr.u64 %rd564, %rd563, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd564) : "l"(rd563));
  // PTX:1325 add.s64 %rd565, %rd564, %rd738
  asm("add.s64 %0, %1, %2;" : "=l"(rd565) : "l"(rd564), "l"(rd738));
  // PTX:1326 mul.lo.s64 %rd566, %rd565, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd566) : "l"(rd565), "l"(rd138));
  // PTX:1327 add.s64 %rd567, %rd566, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd567) : "l"(rd566), "l"(rd18));
  // PTX:1328 mul.lo.s64 %rd568, %rd567, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd568) : "l"(rd567));
  // PTX:1329 add.s64 %rd569, %rd1, %rd568
  asm("add.s64 %0, %1, %2;" : "=l"(rd569) : "l"(rd1), "l"(rd568));
  // PTX:1330 ld.global.u32 %r131, [%rd569]
  r131 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd569) + (0)))));
  // PTX:1331 cvt.u32.u64 %r132, %rd98
  asm("cvt.u32.u64 %0, %1;" : "=r"(r132) : "l"(rd98));
  // PTX:1332 setp.lt.s32 %p78, %r131, %r132
  p78 = (((int)(r131)) < ((int)(r132)));
  // PTX:1333 add.s64 %rd570, %rd565, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd570) : "l"(rd565));
  // PTX:1334 selp.b64 %rd738, %rd570, %rd738, %p78
  rd738 = p78 ? rd570 : rd738;
  // PTX:1335 selp.b64 %rd736, %rd736, %rd565, %p78
  rd736 = p78 ? rd736 : rd565;
  // PTX:1336 setp.gt.u64 %p79, %rd736, %rd738
  p79 = (((unsigned long long)(rd736)) > ((unsigned long long)(rd738)));
  // PTX:1337 @%p79 bra $L__BB55_106
  if (p79) { goto L_BB55_106; }
  // PTX:1339 $L__BB55_107:
L_BB55_107:;
  // PTX:1340 setp.ge.u64 %p80, %rd738, %rd99
  p80 = (((unsigned long long)(rd738)) >= ((unsigned long long)(rd99)));
  // PTX:1341 @%p80 bra $L__BB55_111
  if (p80) { goto L_BB55_111; }
  // PTX:1343 cvt.u32.u64 %r133, %rd98
  asm("cvt.u32.u64 %0, %1;" : "=r"(r133) : "l"(rd98));
  // PTX:1344 mul.lo.s64 %rd571, %rd738, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd571) : "l"(rd738), "l"(rd138));
  // PTX:1345 add.s64 %rd105, %rd571, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd105) : "l"(rd571), "l"(rd18));
  // PTX:1346 mul.lo.s64 %rd572, %rd105, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd572) : "l"(rd105));
  // PTX:1347 add.s64 %rd573, %rd1, %rd572
  asm("add.s64 %0, %1, %2;" : "=l"(rd573) : "l"(rd1), "l"(rd572));
  // PTX:1348 ld.global.u32 %r134, [%rd573]
  r134 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd573) + (0)))));
  // PTX:1349 setp.ne.s32 %p81, %r134, %r133
  p81 = (((int)(r134)) != ((int)(r133)));
  // PTX:1350 @%p81 bra $L__BB55_111
  if (p81) { goto L_BB55_111; }
  // PTX:1352 add.s64 %rd576, %rd573, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd576) : "l"(rd573));
  // PTX:1353 red.global.add.f32 [%rd576], %f82
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd576) + (0)))), (float)(f82));
  // PTX:1354 add.s64 %rd577, %rd573, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd577) : "l"(rd573));
  // PTX:1355 red.global.add.f32 [%rd577], %f83
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd577) + (0)))), (float)(f83));
  // PTX:1356 add.s64 %rd578, %rd573, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd578) : "l"(rd573));
  // PTX:1357 red.global.add.f32 [%rd578], %f84
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd578) + (0)))), (float)(f84));
  // PTX:1358 add.s64 %rd579, %rd573, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd579) : "l"(rd573));
  // PTX:1359 red.global.add.f32 [%rd579], %f85
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd579) + (0)))), (float)(f85));
  // PTX:1360 add.s64 %rd580, %rd573, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd580) : "l"(rd573));
  // PTX:1361 red.global.add.f32 [%rd580], %f86
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd580) + (0)))), (float)(f86));
  // PTX:1362 add.s64 %rd581, %rd573, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd581) : "l"(rd573));
  // PTX:1363 red.global.add.f32 [%rd581], %f87
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd581) + (0)))), (float)(f87));
  // PTX:1364 add.s64 %rd582, %rd573, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd582) : "l"(rd573));
  // PTX:1365 red.global.add.f32 [%rd582], %f88
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd582) + (0)))), (float)(f88));
  // PTX:1366 add.s64 %rd583, %rd573, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd583) : "l"(rd573));
  // PTX:1367 red.global.add.f32 [%rd583], %f89
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd583) + (0)))), (float)(f89));
  // PTX:1368 add.s64 %rd584, %rd573, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd584) : "l"(rd573));
  // PTX:1369 red.global.add.f32 [%rd584], %f90
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd584) + (0)))), (float)(f90));
  // PTX:1371 $L__BB55_111:
L_BB55_111:;
  // PTX:1372 cvt.u32.u64 %r136, %rd98
  asm("cvt.u32.u64 %0, %1;" : "=r"(r136) : "l"(rd98));
  // PTX:1373 setp.eq.s32 %p82, %r68, %r136
  p82 = (((int)(r68)) == ((int)(r136)));
  // PTX:1374 @%p82 bra $L__BB55_118
  if (p82) { goto L_BB55_118; }
  // PTX:1375 bra.uni $L__BB55_112
  goto L_BB55_112;
  // PTX:1377 $L__BB55_118:
L_BB55_118:;
  // PTX:1378 mul.lo.s64 %rd620, %rd98, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd620) : "l"(rd98));
  // PTX:1379 add.s64 %rd621, %rd2, %rd620
  asm("add.s64 %0, %1, %2;" : "=l"(rd621) : "l"(rd2), "l"(rd620));
  // PTX:1380 red.global.add.f32 [%rd621], %f82
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd621) + (0)))), (float)(f82));
  // PTX:1381 add.s64 %rd622, %rd621, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd622) : "l"(rd621));
  // PTX:1382 red.global.add.f32 [%rd622], %f83
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd622) + (0)))), (float)(f83));
  // PTX:1383 add.s64 %rd623, %rd621, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd623) : "l"(rd621));
  // PTX:1384 red.global.add.f32 [%rd623], %f84
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd623) + (0)))), (float)(f84));
  // PTX:1385 add.s64 %rd624, %rd621, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd624) : "l"(rd621));
  // PTX:1386 red.global.add.f32 [%rd624], %f85
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd624) + (0)))), (float)(f85));
  // PTX:1387 add.s64 %rd625, %rd621, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd625) : "l"(rd621));
  // PTX:1388 red.global.add.f32 [%rd625], %f86
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd625) + (0)))), (float)(f86));
  // PTX:1389 add.s64 %rd626, %rd621, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd626) : "l"(rd621));
  // PTX:1390 red.global.add.f32 [%rd626], %f87
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd626) + (0)))), (float)(f87));
  // PTX:1391 add.s64 %rd627, %rd621, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd627) : "l"(rd621));
  // PTX:1392 red.global.add.f32 [%rd627], %f88
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd627) + (0)))), (float)(f88));
  // PTX:1393 add.s64 %rd628, %rd621, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd628) : "l"(rd621));
  // PTX:1394 red.global.add.f32 [%rd628], %f89
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd628) + (0)))), (float)(f89));
  // PTX:1395 add.s64 %rd629, %rd621, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd629) : "l"(rd621));
  // PTX:1396 red.global.add.f32 [%rd629], %f90
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd629) + (0)))), (float)(f90));
  // PTX:1397 bra.uni $L__BB55_119
  goto L_BB55_119;
  // PTX:1399 $L__BB55_112:
L_BB55_112:;
  // PTX:1400 shl.b64 %rd594, %rd98, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd594) : "l"(rd98));
  // PTX:1401 add.s64 %rd595, %rd3, %rd594
  asm("add.s64 %0, %1, %2;" : "=l"(rd595) : "l"(rd3), "l"(rd594));
  // PTX:1402 ld.global.s32 %rd596, [%rd595]
  rd596 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd595) + (0)))));
  // PTX:1403 mov.u64 %rd741, 0
  asm("mov.u64 %0, 0;" : "=l"(rd741) : );
  // PTX:1404 min.u64 %rd106, %rd596, %rd135
  asm("min.u64 %0, %1, %2;" : "=l"(rd106) : "l"(rd596), "l"(rd135));
  // PTX:1405 setp.eq.s64 %p83, %rd106, 0
  p83 = (((long long)(rd106)) == ((long long)(0)));
  // PTX:1406 @%p83 bra $L__BB55_115
  if (p83) { goto L_BB55_115; }
  // PTX:1408 mov.u64 %rd741, 0
  asm("mov.u64 %0, 0;" : "=l"(rd741) : );
  // PTX:1409 mov.u64 %rd739, %rd106
  asm("mov.u64 %0, %1;" : "=l"(rd739) : "l"(rd106));
  // PTX:1411 $L__BB55_114:
L_BB55_114:;
  // PTX:1412 sub.s64 %rd598, %rd739, %rd741
  asm("sub.s64 %0, %1, %2;" : "=l"(rd598) : "l"(rd739), "l"(rd741));
  // PTX:1413 shr.u64 %rd599, %rd598, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd599) : "l"(rd598));
  // PTX:1414 add.s64 %rd600, %rd599, %rd741
  asm("add.s64 %0, %1, %2;" : "=l"(rd600) : "l"(rd599), "l"(rd741));
  // PTX:1415 mul.lo.s64 %rd601, %rd600, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd601) : "l"(rd600), "l"(rd138));
  // PTX:1416 add.s64 %rd602, %rd601, %rd98
  asm("add.s64 %0, %1, %2;" : "=l"(rd602) : "l"(rd601), "l"(rd98));
  // PTX:1417 mul.lo.s64 %rd603, %rd602, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd603) : "l"(rd602));
  // PTX:1418 add.s64 %rd604, %rd1, %rd603
  asm("add.s64 %0, %1, %2;" : "=l"(rd604) : "l"(rd1), "l"(rd603));
  // PTX:1419 ld.global.u32 %r137, [%rd604]
  r137 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd604) + (0)))));
  // PTX:1420 setp.lt.s32 %p84, %r137, %r68
  p84 = (((int)(r137)) < ((int)(r68)));
  // PTX:1421 add.s64 %rd605, %rd600, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd605) : "l"(rd600));
  // PTX:1422 selp.b64 %rd741, %rd605, %rd741, %p84
  rd741 = p84 ? rd605 : rd741;
  // PTX:1423 selp.b64 %rd739, %rd739, %rd600, %p84
  rd739 = p84 ? rd739 : rd600;
  // PTX:1424 setp.gt.u64 %p85, %rd739, %rd741
  p85 = (((unsigned long long)(rd739)) > ((unsigned long long)(rd741)));
  // PTX:1425 @%p85 bra $L__BB55_114
  if (p85) { goto L_BB55_114; }
  // PTX:1427 $L__BB55_115:
L_BB55_115:;
  // PTX:1428 setp.ge.u64 %p86, %rd741, %rd106
  p86 = (((unsigned long long)(rd741)) >= ((unsigned long long)(rd106)));
  // PTX:1429 @%p86 bra $L__BB55_119
  if (p86) { goto L_BB55_119; }
  // PTX:1431 mul.lo.s64 %rd606, %rd741, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd606) : "l"(rd741), "l"(rd138));
  // PTX:1432 add.s64 %rd112, %rd606, %rd98
  asm("add.s64 %0, %1, %2;" : "=l"(rd112) : "l"(rd606), "l"(rd98));
  // PTX:1433 mul.lo.s64 %rd607, %rd112, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd607) : "l"(rd112));
  // PTX:1434 add.s64 %rd608, %rd1, %rd607
  asm("add.s64 %0, %1, %2;" : "=l"(rd608) : "l"(rd1), "l"(rd607));
  // PTX:1435 ld.global.u32 %r140, [%rd608]
  r140 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd608) + (0)))));
  // PTX:1436 setp.ne.s32 %p87, %r140, %r68
  p87 = (((int)(r140)) != ((int)(r68)));
  // PTX:1437 @%p87 bra $L__BB55_119
  if (p87) { goto L_BB55_119; }
  // PTX:1439 add.s64 %rd611, %rd608, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd611) : "l"(rd608));
  // PTX:1440 red.global.add.f32 [%rd611], %f82
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd611) + (0)))), (float)(f82));
  // PTX:1441 add.s64 %rd612, %rd608, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd612) : "l"(rd608));
  // PTX:1442 red.global.add.f32 [%rd612], %f83
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd612) + (0)))), (float)(f83));
  // PTX:1443 add.s64 %rd613, %rd608, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd613) : "l"(rd608));
  // PTX:1444 red.global.add.f32 [%rd613], %f84
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd613) + (0)))), (float)(f84));
  // PTX:1445 add.s64 %rd614, %rd608, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd614) : "l"(rd608));
  // PTX:1446 red.global.add.f32 [%rd614], %f85
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd614) + (0)))), (float)(f85));
  // PTX:1447 add.s64 %rd615, %rd608, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd615) : "l"(rd608));
  // PTX:1448 red.global.add.f32 [%rd615], %f86
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd615) + (0)))), (float)(f86));
  // PTX:1449 add.s64 %rd616, %rd608, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd616) : "l"(rd608));
  // PTX:1450 red.global.add.f32 [%rd616], %f87
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd616) + (0)))), (float)(f87));
  // PTX:1451 add.s64 %rd617, %rd608, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd617) : "l"(rd608));
  // PTX:1452 red.global.add.f32 [%rd617], %f88
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd617) + (0)))), (float)(f88));
  // PTX:1453 add.s64 %rd618, %rd608, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd618) : "l"(rd608));
  // PTX:1454 red.global.add.f32 [%rd618], %f89
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd618) + (0)))), (float)(f89));
  // PTX:1455 add.s64 %rd619, %rd608, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd619) : "l"(rd608));
  // PTX:1456 red.global.add.f32 [%rd619], %f90
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd619) + (0)))), (float)(f90));
  // PTX:1458 $L__BB55_119:
L_BB55_119:;
  // PTX:1459 add.s32 %r141, %r165, 7
  asm("add.s32 %0, %1, 7;" : "=r"(r141) : "r"(r165));
  // PTX:1460 setp.ge.s32 %p88, %r141, %r157
  p88 = (((int)(r141)) >= ((int)(r157)));
  // PTX:1461 @%p88 bra $L__BB55_136
  if (p88) { goto L_BB55_136; }
  // PTX:1463 ld.local.f32 %f441, [%rd21+24]
  f441 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd21) + (24)))));
  // PTX:1464 mul.f32 %f442, %f35, %f441
  asm("mul.f32 %0, %1, %2;" : "=f"(f442) : "f"(f35), "f"(f441));
  // PTX:1465 mul.f32 %f91, %f25, %f442
  asm("mul.f32 %0, %1, %2;" : "=f"(f91) : "f"(f25), "f"(f442));
  // PTX:1466 mul.f32 %f92, %f26, %f442
  asm("mul.f32 %0, %1, %2;" : "=f"(f92) : "f"(f26), "f"(f442));
  // PTX:1467 mul.f32 %f93, %f27, %f442
  asm("mul.f32 %0, %1, %2;" : "=f"(f93) : "f"(f27), "f"(f442));
  // PTX:1468 mul.f32 %f94, %f28, %f442
  asm("mul.f32 %0, %1, %2;" : "=f"(f94) : "f"(f28), "f"(f442));
  // PTX:1469 mul.f32 %f95, %f29, %f442
  asm("mul.f32 %0, %1, %2;" : "=f"(f95) : "f"(f29), "f"(f442));
  // PTX:1470 mul.f32 %f96, %f30, %f442
  asm("mul.f32 %0, %1, %2;" : "=f"(f96) : "f"(f30), "f"(f442));
  // PTX:1471 mul.f32 %f97, %f31, %f442
  asm("mul.f32 %0, %1, %2;" : "=f"(f97) : "f"(f31), "f"(f442));
  // PTX:1472 mul.f32 %f98, %f32, %f442
  asm("mul.f32 %0, %1, %2;" : "=f"(f98) : "f"(f32), "f"(f442));
  // PTX:1473 mul.f32 %f99, %f33, %f442
  asm("mul.f32 %0, %1, %2;" : "=f"(f99) : "f"(f33), "f"(f442));
  // PTX:1474 ld.local.u32 %r143, [%rd22+24]
  r143 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd22) + (24)))));
  // PTX:1475 cvt.s64.s32 %rd113, %r143
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd113) : "r"(r143));
  // PTX:1476 setp.eq.s32 %p89, %r68, %r143
  p89 = (((int)(r68)) == ((int)(r143)));
  // PTX:1477 @%p89 bra $L__BB55_127
  if (p89) { goto L_BB55_127; }
  // PTX:1478 bra.uni $L__BB55_121
  goto L_BB55_121;
  // PTX:1480 $L__BB55_127:
L_BB55_127:;
  // PTX:1481 red.global.add.f32 [%rd19], %f91
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))), (float)(f91));
  // PTX:1482 red.global.add.f32 [%rd198], %f92
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd198) + (0)))), (float)(f92));
  // PTX:1483 red.global.add.f32 [%rd199], %f93
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd199) + (0)))), (float)(f93));
  // PTX:1484 red.global.add.f32 [%rd200], %f94
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd200) + (0)))), (float)(f94));
  // PTX:1485 red.global.add.f32 [%rd201], %f95
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd201) + (0)))), (float)(f95));
  // PTX:1486 red.global.add.f32 [%rd202], %f96
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd202) + (0)))), (float)(f96));
  // PTX:1487 red.global.add.f32 [%rd203], %f97
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd203) + (0)))), (float)(f97));
  // PTX:1488 red.global.add.f32 [%rd204], %f98
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd204) + (0)))), (float)(f98));
  // PTX:1489 red.global.add.f32 [%rd205], %f99
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd205) + (0)))), (float)(f99));
  // PTX:1490 bra.uni $L__BB55_128
  goto L_BB55_128;
  // PTX:1492 $L__BB55_121:
L_BB55_121:;
  // PTX:1493 ld.global.s32 %rd631, [%rd20]
  rd631 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))));
  // PTX:1494 mov.u64 %rd744, 0
  asm("mov.u64 %0, 0;" : "=l"(rd744) : );
  // PTX:1495 min.u64 %rd114, %rd631, %rd135
  asm("min.u64 %0, %1, %2;" : "=l"(rd114) : "l"(rd631), "l"(rd135));
  // PTX:1496 setp.eq.s64 %p90, %rd114, 0
  p90 = (((long long)(rd114)) == ((long long)(0)));
  // PTX:1497 @%p90 bra $L__BB55_124
  if (p90) { goto L_BB55_124; }
  // PTX:1499 mov.u64 %rd744, 0
  asm("mov.u64 %0, 0;" : "=l"(rd744) : );
  // PTX:1500 mov.u64 %rd742, %rd114
  asm("mov.u64 %0, %1;" : "=l"(rd742) : "l"(rd114));
  // PTX:1502 $L__BB55_123:
L_BB55_123:;
  // PTX:1503 sub.s64 %rd633, %rd742, %rd744
  asm("sub.s64 %0, %1, %2;" : "=l"(rd633) : "l"(rd742), "l"(rd744));
  // PTX:1504 shr.u64 %rd634, %rd633, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd634) : "l"(rd633));
  // PTX:1505 add.s64 %rd635, %rd634, %rd744
  asm("add.s64 %0, %1, %2;" : "=l"(rd635) : "l"(rd634), "l"(rd744));
  // PTX:1506 mul.lo.s64 %rd636, %rd635, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd636) : "l"(rd635), "l"(rd138));
  // PTX:1507 add.s64 %rd637, %rd636, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd637) : "l"(rd636), "l"(rd18));
  // PTX:1508 mul.lo.s64 %rd638, %rd637, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd638) : "l"(rd637));
  // PTX:1509 add.s64 %rd639, %rd1, %rd638
  asm("add.s64 %0, %1, %2;" : "=l"(rd639) : "l"(rd1), "l"(rd638));
  // PTX:1510 ld.global.u32 %r144, [%rd639]
  r144 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd639) + (0)))));
  // PTX:1511 cvt.u32.u64 %r145, %rd113
  asm("cvt.u32.u64 %0, %1;" : "=r"(r145) : "l"(rd113));
  // PTX:1512 setp.lt.s32 %p91, %r144, %r145
  p91 = (((int)(r144)) < ((int)(r145)));
  // PTX:1513 add.s64 %rd640, %rd635, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd640) : "l"(rd635));
  // PTX:1514 selp.b64 %rd744, %rd640, %rd744, %p91
  rd744 = p91 ? rd640 : rd744;
  // PTX:1515 selp.b64 %rd742, %rd742, %rd635, %p91
  rd742 = p91 ? rd742 : rd635;
  // PTX:1516 setp.gt.u64 %p92, %rd742, %rd744
  p92 = (((unsigned long long)(rd742)) > ((unsigned long long)(rd744)));
  // PTX:1517 @%p92 bra $L__BB55_123
  if (p92) { goto L_BB55_123; }
  // PTX:1519 $L__BB55_124:
L_BB55_124:;
  // PTX:1520 setp.ge.u64 %p93, %rd744, %rd114
  p93 = (((unsigned long long)(rd744)) >= ((unsigned long long)(rd114)));
  // PTX:1521 @%p93 bra $L__BB55_128
  if (p93) { goto L_BB55_128; }
  // PTX:1523 cvt.u32.u64 %r146, %rd113
  asm("cvt.u32.u64 %0, %1;" : "=r"(r146) : "l"(rd113));
  // PTX:1524 mul.lo.s64 %rd641, %rd744, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd641) : "l"(rd744), "l"(rd138));
  // PTX:1525 add.s64 %rd120, %rd641, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd120) : "l"(rd641), "l"(rd18));
  // PTX:1526 mul.lo.s64 %rd642, %rd120, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd642) : "l"(rd120));
  // PTX:1527 add.s64 %rd643, %rd1, %rd642
  asm("add.s64 %0, %1, %2;" : "=l"(rd643) : "l"(rd1), "l"(rd642));
  // PTX:1528 ld.global.u32 %r147, [%rd643]
  r147 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd643) + (0)))));
  // PTX:1529 setp.ne.s32 %p94, %r147, %r146
  p94 = (((int)(r147)) != ((int)(r146)));
  // PTX:1530 @%p94 bra $L__BB55_128
  if (p94) { goto L_BB55_128; }
  // PTX:1532 add.s64 %rd646, %rd643, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd646) : "l"(rd643));
  // PTX:1533 red.global.add.f32 [%rd646], %f91
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd646) + (0)))), (float)(f91));
  // PTX:1534 add.s64 %rd647, %rd643, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd647) : "l"(rd643));
  // PTX:1535 red.global.add.f32 [%rd647], %f92
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd647) + (0)))), (float)(f92));
  // PTX:1536 add.s64 %rd648, %rd643, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd648) : "l"(rd643));
  // PTX:1537 red.global.add.f32 [%rd648], %f93
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd648) + (0)))), (float)(f93));
  // PTX:1538 add.s64 %rd649, %rd643, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd649) : "l"(rd643));
  // PTX:1539 red.global.add.f32 [%rd649], %f94
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd649) + (0)))), (float)(f94));
  // PTX:1540 add.s64 %rd650, %rd643, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd650) : "l"(rd643));
  // PTX:1541 red.global.add.f32 [%rd650], %f95
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd650) + (0)))), (float)(f95));
  // PTX:1542 add.s64 %rd651, %rd643, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd651) : "l"(rd643));
  // PTX:1543 red.global.add.f32 [%rd651], %f96
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd651) + (0)))), (float)(f96));
  // PTX:1544 add.s64 %rd652, %rd643, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd652) : "l"(rd643));
  // PTX:1545 red.global.add.f32 [%rd652], %f97
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd652) + (0)))), (float)(f97));
  // PTX:1546 add.s64 %rd653, %rd643, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd653) : "l"(rd643));
  // PTX:1547 red.global.add.f32 [%rd653], %f98
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd653) + (0)))), (float)(f98));
  // PTX:1548 add.s64 %rd654, %rd643, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd654) : "l"(rd643));
  // PTX:1549 red.global.add.f32 [%rd654], %f99
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd654) + (0)))), (float)(f99));
  // PTX:1551 $L__BB55_128:
L_BB55_128:;
  // PTX:1552 cvt.u32.u64 %r149, %rd113
  asm("cvt.u32.u64 %0, %1;" : "=r"(r149) : "l"(rd113));
  // PTX:1553 setp.eq.s32 %p95, %r68, %r149
  p95 = (((int)(r68)) == ((int)(r149)));
  // PTX:1554 @%p95 bra $L__BB55_135
  if (p95) { goto L_BB55_135; }
  // PTX:1555 bra.uni $L__BB55_129
  goto L_BB55_129;
  // PTX:1557 $L__BB55_135:
L_BB55_135:;
  // PTX:1558 mul.lo.s64 %rd690, %rd113, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd690) : "l"(rd113));
  // PTX:1559 add.s64 %rd691, %rd2, %rd690
  asm("add.s64 %0, %1, %2;" : "=l"(rd691) : "l"(rd2), "l"(rd690));
  // PTX:1560 red.global.add.f32 [%rd691], %f91
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd691) + (0)))), (float)(f91));
  // PTX:1561 add.s64 %rd692, %rd691, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd692) : "l"(rd691));
  // PTX:1562 red.global.add.f32 [%rd692], %f92
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd692) + (0)))), (float)(f92));
  // PTX:1563 add.s64 %rd693, %rd691, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd693) : "l"(rd691));
  // PTX:1564 red.global.add.f32 [%rd693], %f93
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd693) + (0)))), (float)(f93));
  // PTX:1565 add.s64 %rd694, %rd691, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd694) : "l"(rd691));
  // PTX:1566 red.global.add.f32 [%rd694], %f94
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd694) + (0)))), (float)(f94));
  // PTX:1567 add.s64 %rd695, %rd691, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd695) : "l"(rd691));
  // PTX:1568 red.global.add.f32 [%rd695], %f95
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd695) + (0)))), (float)(f95));
  // PTX:1569 add.s64 %rd696, %rd691, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd696) : "l"(rd691));
  // PTX:1570 red.global.add.f32 [%rd696], %f96
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd696) + (0)))), (float)(f96));
  // PTX:1571 add.s64 %rd697, %rd691, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd697) : "l"(rd691));
  // PTX:1572 red.global.add.f32 [%rd697], %f97
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd697) + (0)))), (float)(f97));
  // PTX:1573 add.s64 %rd698, %rd691, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd698) : "l"(rd691));
  // PTX:1574 red.global.add.f32 [%rd698], %f98
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd698) + (0)))), (float)(f98));
  // PTX:1575 add.s64 %rd699, %rd691, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd699) : "l"(rd691));
  // PTX:1576 red.global.add.f32 [%rd699], %f99
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd699) + (0)))), (float)(f99));
  // PTX:1577 bra.uni $L__BB55_136
  goto L_BB55_136;
  // PTX:1579 $L__BB55_129:
L_BB55_129:;
  // PTX:1580 shl.b64 %rd664, %rd113, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd664) : "l"(rd113));
  // PTX:1581 add.s64 %rd665, %rd3, %rd664
  asm("add.s64 %0, %1, %2;" : "=l"(rd665) : "l"(rd3), "l"(rd664));
  // PTX:1582 ld.global.s32 %rd666, [%rd665]
  rd666 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd665) + (0)))));
  // PTX:1583 mov.u64 %rd747, 0
  asm("mov.u64 %0, 0;" : "=l"(rd747) : );
  // PTX:1584 min.u64 %rd121, %rd666, %rd135
  asm("min.u64 %0, %1, %2;" : "=l"(rd121) : "l"(rd666), "l"(rd135));
  // PTX:1585 setp.eq.s64 %p96, %rd121, 0
  p96 = (((long long)(rd121)) == ((long long)(0)));
  // PTX:1586 @%p96 bra $L__BB55_132
  if (p96) { goto L_BB55_132; }
  // PTX:1588 mov.u64 %rd747, 0
  asm("mov.u64 %0, 0;" : "=l"(rd747) : );
  // PTX:1589 mov.u64 %rd745, %rd121
  asm("mov.u64 %0, %1;" : "=l"(rd745) : "l"(rd121));
  // PTX:1591 $L__BB55_131:
L_BB55_131:;
  // PTX:1592 sub.s64 %rd668, %rd745, %rd747
  asm("sub.s64 %0, %1, %2;" : "=l"(rd668) : "l"(rd745), "l"(rd747));
  // PTX:1593 shr.u64 %rd669, %rd668, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd669) : "l"(rd668));
  // PTX:1594 add.s64 %rd670, %rd669, %rd747
  asm("add.s64 %0, %1, %2;" : "=l"(rd670) : "l"(rd669), "l"(rd747));
  // PTX:1595 mul.lo.s64 %rd671, %rd670, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd671) : "l"(rd670), "l"(rd138));
  // PTX:1596 add.s64 %rd672, %rd671, %rd113
  asm("add.s64 %0, %1, %2;" : "=l"(rd672) : "l"(rd671), "l"(rd113));
  // PTX:1597 mul.lo.s64 %rd673, %rd672, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd673) : "l"(rd672));
  // PTX:1598 add.s64 %rd674, %rd1, %rd673
  asm("add.s64 %0, %1, %2;" : "=l"(rd674) : "l"(rd1), "l"(rd673));
  // PTX:1599 ld.global.u32 %r150, [%rd674]
  r150 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd674) + (0)))));
  // PTX:1600 setp.lt.s32 %p97, %r150, %r68
  p97 = (((int)(r150)) < ((int)(r68)));
  // PTX:1601 add.s64 %rd675, %rd670, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd675) : "l"(rd670));
  // PTX:1602 selp.b64 %rd747, %rd675, %rd747, %p97
  rd747 = p97 ? rd675 : rd747;
  // PTX:1603 selp.b64 %rd745, %rd745, %rd670, %p97
  rd745 = p97 ? rd745 : rd670;
  // PTX:1604 setp.gt.u64 %p98, %rd745, %rd747
  p98 = (((unsigned long long)(rd745)) > ((unsigned long long)(rd747)));
  // PTX:1605 @%p98 bra $L__BB55_131
  if (p98) { goto L_BB55_131; }
  // PTX:1607 $L__BB55_132:
L_BB55_132:;
  // PTX:1608 setp.ge.u64 %p99, %rd747, %rd121
  p99 = (((unsigned long long)(rd747)) >= ((unsigned long long)(rd121)));
  // PTX:1609 @%p99 bra $L__BB55_136
  if (p99) { goto L_BB55_136; }
  // PTX:1611 mul.lo.s64 %rd676, %rd747, %rd138
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd676) : "l"(rd747), "l"(rd138));
  // PTX:1612 add.s64 %rd127, %rd676, %rd113
  asm("add.s64 %0, %1, %2;" : "=l"(rd127) : "l"(rd676), "l"(rd113));
  // PTX:1613 mul.lo.s64 %rd677, %rd127, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd677) : "l"(rd127));
  // PTX:1614 add.s64 %rd678, %rd1, %rd677
  asm("add.s64 %0, %1, %2;" : "=l"(rd678) : "l"(rd1), "l"(rd677));
  // PTX:1615 ld.global.u32 %r153, [%rd678]
  r153 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd678) + (0)))));
  // PTX:1616 setp.ne.s32 %p100, %r153, %r68
  p100 = (((int)(r153)) != ((int)(r68)));
  // PTX:1617 @%p100 bra $L__BB55_136
  if (p100) { goto L_BB55_136; }
  // PTX:1619 add.s64 %rd681, %rd678, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd681) : "l"(rd678));
  // PTX:1620 red.global.add.f32 [%rd681], %f91
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd681) + (0)))), (float)(f91));
  // PTX:1621 add.s64 %rd682, %rd678, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd682) : "l"(rd678));
  // PTX:1622 red.global.add.f32 [%rd682], %f92
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd682) + (0)))), (float)(f92));
  // PTX:1623 add.s64 %rd683, %rd678, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd683) : "l"(rd678));
  // PTX:1624 red.global.add.f32 [%rd683], %f93
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd683) + (0)))), (float)(f93));
  // PTX:1625 add.s64 %rd684, %rd678, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd684) : "l"(rd678));
  // PTX:1626 red.global.add.f32 [%rd684], %f94
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd684) + (0)))), (float)(f94));
  // PTX:1627 add.s64 %rd685, %rd678, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd685) : "l"(rd678));
  // PTX:1628 red.global.add.f32 [%rd685], %f95
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd685) + (0)))), (float)(f95));
  // PTX:1629 add.s64 %rd686, %rd678, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd686) : "l"(rd678));
  // PTX:1630 red.global.add.f32 [%rd686], %f96
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd686) + (0)))), (float)(f96));
  // PTX:1631 add.s64 %rd687, %rd678, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd687) : "l"(rd678));
  // PTX:1632 red.global.add.f32 [%rd687], %f97
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd687) + (0)))), (float)(f97));
  // PTX:1633 add.s64 %rd688, %rd678, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd688) : "l"(rd678));
  // PTX:1634 red.global.add.f32 [%rd688], %f98
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd688) + (0)))), (float)(f98));
  // PTX:1635 add.s64 %rd689, %rd678, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd689) : "l"(rd678));
  // PTX:1636 red.global.add.f32 [%rd689], %f99
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd689) + (0)))), (float)(f99));
  // PTX:1637 bra.uni $L__BB55_136
  goto L_BB55_136;
  // PTX:1639 $L__BB55_137:
L_BB55_137:;
  // PTX:1640 ret
  return;
}
