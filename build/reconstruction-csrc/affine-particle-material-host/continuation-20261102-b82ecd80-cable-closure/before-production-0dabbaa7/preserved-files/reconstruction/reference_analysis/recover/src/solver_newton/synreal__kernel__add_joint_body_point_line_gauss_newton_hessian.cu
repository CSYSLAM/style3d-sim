// 机械还原自 PTX：synreal::kernel::add_joint_body_point_line_gauss_newton_hessian(glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 2b89fcfe4ed118f3cc9ee0dee6e61738e1f24bdb4bbca205132873dee929e352
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__add_joint_body_point_line_gauss_newton_hessian(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, float param8, unsigned long long param9, unsigned long long param10, unsigned long long param11, unsigned long long param12, unsigned long long param13, unsigned long long param14, unsigned long long param15, unsigned long long param16, unsigned long long param17) {
  unsigned long long SP, SPL, rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135, rd136, rd137, rd138, rd139, rd140, rd141, rd142, rd143, rd144, rd145, rd146, rd147, rd148, rd149, rd150, rd151, rd152, rd153, rd154, rd155, rd156, rd157, rd158, rd159, rd160, rd161, rd162, rd163, rd164, rd165, rd166, rd167, rd168, rd169, rd170, rd171, rd172, rd173, rd174, rd175, rd176, rd177, rd178, rd179, rd180, rd181, rd182, rd183, rd184, rd185, rd186, rd187, rd188, rd189, rd190, rd191, rd192, rd193, rd194, rd195, rd196, rd197, rd198, rd199, rd200, rd201, rd202, rd203, rd204, rd205, rd206, rd207, rd208, rd209, rd210, rd211, rd212, rd213, rd214, rd215, rd216, rd217, rd218, rd219, rd220, rd221, rd222, rd223, rd224, rd225, rd226, rd227, rd228, rd229, rd230, rd231, rd232, rd233, rd234, rd235, rd236, rd237, rd238, rd239, rd240, rd241, rd242, rd243, rd244, rd245, rd246, rd247, rd248, rd249, rd250, rd251, rd252, rd253, rd254, rd255, rd256, rd257, rd258, rd259, rd260, rd261, rd262, rd263, rd264, rd265, rd266, rd267, rd268, rd269, rd270, rd271, rd272, rd273, rd274, rd275, rd276, rd277, rd278, rd279, rd280, rd281, rd282, rd283, rd284, rd285, rd286, rd287, rd288, rd289, rd290, rd291, rd292, rd293, rd294, rd295, rd296, rd297, rd298, rd299, rd300, rd301, rd302, rd303, rd304, rd305, rd306, rd307, rd308, rd309, rd310, rd311, rd312, rd313, rd314, rd315, rd316, rd317, rd318, rd319, rd320, rd321, rd322, rd323, rd324, rd325, rd326, rd327, rd328, rd329, rd330, rd331, rd332, rd333, rd334, rd335, rd336, rd337, rd338, rd339, rd340, rd341, rd342, rd343, rd344, rd345, rd346, rd347, rd348, rd349, rd350, rd351, rd352, rd353, rd354, rd355, rd356, rd357, rd358, rd359, rd360, rd361, rd362, rd363, rd364, rd365, rd366, rd367, rd368, rd369, rd370, rd371, rd372, rd373, rd374, rd375, rd376, rd377, rd378, rd379, rd380, rd381, rd382, rd383, rd384, rd385, rd386, rd387, rd388, rd389, rd390, rd391, rd392, rd393, rd394, rd395, rd396, rd397, rd398, rd399, rd400, rd401, rd402, rd403, rd404, rd405, rd406, rd407, rd408, rd409, rd410, rd411, rd412, rd413, rd414, rd415, rd416, rd417, rd418, rd419, rd420, rd421, rd422, rd423, rd424, rd425, rd426, rd427, rd428, rd429, rd430, rd431, rd432, rd433, rd434, rd435, rd436, rd437, rd438, rd439, rd440, rd441, rd442, rd443, rd444, rd445, rd446, rd447, rd448, rd449, rd450, rd451, rd452, rd453, rd454, rd455, rd456, rd457, rd458, rd459, rd460, rd461, rd462, rd463, rd464, rd465, rd466, rd467, rd468, rd469, rd470, rd471, rd472, rd473, rd474, rd475, rd476, rd477, rd478, rd479, rd480, rd481, rd482, rd483, rd484, rd485, rd486, rd487, rd488, rd489, rd490, rd491, rd492, rd493, rd494, rd495, rd496, rd497, rd498, rd499, rd500, rd501, rd502, rd503, rd504, rd505, rd506, rd507, rd508, rd509, rd510, rd511, rd512, rd513, rd514, rd515, rd516, rd517, rd518, rd519, rd520, rd521, rd522, rd523, rd524, rd525, rd526, rd527, rd528, rd529, rd530, rd531, rd532, rd533, rd534, rd535, rd536, rd537, rd538, rd539, rd540, rd541, rd542, rd543, rd544, rd545, rd546, rd547, rd548, rd549, rd550, rd551, rd552, rd553, rd554, rd555, rd556, rd557, rd558, rd559, rd560, rd561, rd562, rd563, rd564, rd565, rd566, rd567, rd568, rd569, rd570, rd571, rd572, rd573, rd574, rd575, rd576, rd577, rd578, rd579, rd580, rd581, rd582, rd583, rd584, rd585, rd586, rd587, rd588, rd589, rd590, rd591, rd592, rd593, rd594, rd595, rd596, rd597, rd598, rd599, rd600, rd601, rd602, rd603, rd604, rd605, rd606, rd607, rd608, rd609, rd610, rd611, rd612, rd613, rd614, rd615, rd616, rd617, rd618, rd619, rd620, rd621, rd622, rd623, rd624, rd625, rd626, rd627, rd628, rd629, rd630, rd631, rd632, rd633, rd634, rd635, rd636, rd637, rd638, rd639, rd640, rd641, rd642, rd643, rd644, rd645, rd646, rd647, rd648, rd649, rd650, rd651, rd652, rd653, rd654, rd655, rd656, rd657, rd658, rd659, rd660, rd661, rd662, rd663, rd664, rd665, rd666, rd667, rd668, rd669, rd670, rd671, rd672, rd673, rd674, rd675, rd676, rd677, rd678, rd679, rd680, rd681, rd682, rd683, rd684, rd685, rd686, rd687, rd688, rd689, rd690, rd691, rd692, rd693, rd694, rd695, rd696, rd697, rd698, rd699, rd700, rd701, rd702, rd703, rd704, rd705, rd706, rd707, rd708, rd709, rd710, rd711, rd712, rd713, rd714, rd715, rd716, rd717, rd718, rd719, rd720, rd721, rd722, rd723, rd724, rd725, rd726, rd727, rd728, rd729;
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57, p58, p59, p60, p61, p62, p63, p64, p65, p66, p67, p68, p69, p70, p71, p72, p73, p74, p75, p76, p77, p78, p79, p80, p81, p82, p83, p84, p85, p86, p87, p88, p89, p90, p91, p92, p93, p94, p95, p96, p97;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440, f441, f442, f443, f444, f445, f446, f447, f448, f449, f450, f451, f452, f453, f454, f455, f456, f457, f458, f459, f460;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121, r122, r123, r124, r125, r126, r127, r128, r129, r130, r131, r132;
  __align__(16) unsigned char __local_depot57[64];
  // PTX:37 mov.u64 %SPL, __local_depot57
  SPL = (unsigned long long)__cvta_generic_to_local(__local_depot57);
  // PTX:38 ld.param.u64 %rd141, [_ZN7synreal6kernel46add_joint_body_point_line_gauss_newton_hessianEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_PKiPNS_17BlockNonZeroEntryEmmmmmm_param_0]
  rd141 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:39 ld.param.u64 %rd129, [_ZN7synreal6kernel46add_joint_body_point_line_gauss_newton_hessianEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_PKiPNS_17BlockNonZeroEntryEmmmmmm_param_1]
  rd129 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:40 ld.param.u64 %rd130, [_ZN7synreal6kernel46add_joint_body_point_line_gauss_newton_hessianEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_PKiPNS_17BlockNonZeroEntryEmmmmmm_param_2]
  rd130 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:41 ld.param.u64 %rd131, [_ZN7synreal6kernel46add_joint_body_point_line_gauss_newton_hessianEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_PKiPNS_17BlockNonZeroEntryEmmmmmm_param_3]
  rd131 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:42 ld.param.u64 %rd132, [_ZN7synreal6kernel46add_joint_body_point_line_gauss_newton_hessianEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_PKiPNS_17BlockNonZeroEntryEmmmmmm_param_4]
  rd132 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:43 ld.param.u64 %rd133, [_ZN7synreal6kernel46add_joint_body_point_line_gauss_newton_hessianEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_PKiPNS_17BlockNonZeroEntryEmmmmmm_param_5]
  rd133 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:44 ld.param.u64 %rd134, [_ZN7synreal6kernel46add_joint_body_point_line_gauss_newton_hessianEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_PKiPNS_17BlockNonZeroEntryEmmmmmm_param_6]
  rd134 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:45 ld.param.u64 %rd135, [_ZN7synreal6kernel46add_joint_body_point_line_gauss_newton_hessianEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_PKiPNS_17BlockNonZeroEntryEmmmmmm_param_7]
  rd135 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:46 ld.param.f32 %f77, [_ZN7synreal6kernel46add_joint_body_point_line_gauss_newton_hessianEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_PKiPNS_17BlockNonZeroEntryEmmmmmm_param_8]
  f77 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param8 + (0))));
  // PTX:47 ld.param.u64 %rd142, [_ZN7synreal6kernel46add_joint_body_point_line_gauss_newton_hessianEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_PKiPNS_17BlockNonZeroEntryEmmmmmm_param_9]
  rd142 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:48 ld.param.u64 %rd143, [_ZN7synreal6kernel46add_joint_body_point_line_gauss_newton_hessianEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_PKiPNS_17BlockNonZeroEntryEmmmmmm_param_10]
  rd143 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:49 ld.param.u64 %rd144, [_ZN7synreal6kernel46add_joint_body_point_line_gauss_newton_hessianEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_PKiPNS_17BlockNonZeroEntryEmmmmmm_param_11]
  rd144 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:50 ld.param.u64 %rd136, [_ZN7synreal6kernel46add_joint_body_point_line_gauss_newton_hessianEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_PKiPNS_17BlockNonZeroEntryEmmmmmm_param_12]
  rd136 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:51 ld.param.u64 %rd145, [_ZN7synreal6kernel46add_joint_body_point_line_gauss_newton_hessianEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_PKiPNS_17BlockNonZeroEntryEmmmmmm_param_13]
  rd145 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:52 ld.param.u64 %rd137, [_ZN7synreal6kernel46add_joint_body_point_line_gauss_newton_hessianEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_PKiPNS_17BlockNonZeroEntryEmmmmmm_param_14]
  rd137 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:53 ld.param.u64 %rd138, [_ZN7synreal6kernel46add_joint_body_point_line_gauss_newton_hessianEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_PKiPNS_17BlockNonZeroEntryEmmmmmm_param_15]
  rd138 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param15 + (0))));
  // PTX:54 ld.param.u64 %rd139, [_ZN7synreal6kernel46add_joint_body_point_line_gauss_newton_hessianEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_PKiPNS_17BlockNonZeroEntryEmmmmmm_param_16]
  rd139 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param16 + (0))));
  // PTX:55 ld.param.u64 %rd140, [_ZN7synreal6kernel46add_joint_body_point_line_gauss_newton_hessianEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESC_SC_PKfSE_PKNS1_3matILi3ELi3EfLS3_0EEEfPSG_PKiPNS_17BlockNonZeroEntryEmmmmmm_param_17]
  rd140 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param17 + (0))));
  // PTX:56 cvta.to.global.u64 %rd1, %rd144
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd144));
  // PTX:57 cvta.to.global.u64 %rd2, %rd142
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd142));
  // PTX:58 cvta.to.global.u64 %rd3, %rd143
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd143));
  // PTX:59 cvta.to.global.u64 %rd4, %rd141
  rd4 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd141));
  // PTX:60 add.u64 %rd5, %SPL, 0
  asm("add.u64 %0, %1, 0;" : "=l"(rd5) : "l"(SPL));
  // PTX:61 add.u64 %rd6, %SPL, 32
  asm("add.u64 %0, %1, 32;" : "=l"(rd6) : "l"(SPL));
  // PTX:62 mov.u32 %r13, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r13) : "r"(blockIdx.x));
  // PTX:63 mov.u32 %r14, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r14) : "r"(blockDim.x));
  // PTX:64 mul.wide.u32 %rd148, %r13, %r14
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd148) : "r"(r13), "r"(r14));
  // PTX:65 mov.u32 %r15, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r15) : "r"(threadIdx.x));
  // PTX:66 cvt.u64.u32 %rd149, %r15
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd149) : "r"(r15));
  // PTX:67 add.s64 %rd7, %rd148, %rd149
  asm("add.s64 %0, %1, %2;" : "=l"(rd7) : "l"(rd148), "l"(rd149));
  // PTX:68 setp.ge.u64 %p1, %rd7, %rd145
  p1 = (((unsigned long long)(rd7)) >= ((unsigned long long)(rd145)));
  // PTX:69 @%p1 bra $L__BB57_131
  if (p1) { goto L_BB57_131; }
  // PTX:71 or.b64 %rd150, %rd7, %rd138
  asm("or.b64 %0, %1, %2;" : "=l"(rd150) : "l"(rd7), "l"(rd138));
  // PTX:72 and.b64 %rd151, %rd150, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd151) : "l"(rd150));
  // PTX:73 setp.eq.s64 %p2, %rd151, 0
  p2 = (((long long)(rd151)) == ((long long)(0)));
  // PTX:74 @%p2 bra $L__BB57_3
  if (p2) { goto L_BB57_3; }
  // PTX:76 rem.u64 %rd686, %rd7, %rd138
  asm("rem.u64 %0, %1, %2;" : "=l"(rd686) : "l"(rd7), "l"(rd138));
  // PTX:77 bra.uni $L__BB57_4
  goto L_BB57_4;
  // PTX:79 $L__BB57_3:
L_BB57_3:;
  // PTX:80 cvt.u32.u64 %r16, %rd138
  asm("cvt.u32.u64 %0, %1;" : "=r"(r16) : "l"(rd138));
  // PTX:81 cvt.u32.u64 %r17, %rd7
  asm("cvt.u32.u64 %0, %1;" : "=r"(r17) : "l"(rd7));
  // PTX:82 rem.u32 %r18, %r17, %r16
  asm("rem.u32 %0, %1, %2;" : "=r"(r18) : "r"(r17), "r"(r16));
  // PTX:83 cvt.u64.u32 %rd686, %r18
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd686) : "r"(r18));
  // PTX:85 $L__BB57_4:
L_BB57_4:;
  // PTX:86 sub.s64 %rd152, %rd137, %rd138
  asm("sub.s64 %0, %1, %2;" : "=l"(rd152) : "l"(rd137), "l"(rd138));
  // PTX:87 add.s64 %rd11, %rd686, %rd152
  asm("add.s64 %0, %1, %2;" : "=l"(rd11) : "l"(rd686), "l"(rd152));
  // PTX:88 cvta.to.global.u64 %rd153, %rd133
  rd153 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd133));
  // PTX:89 shl.b64 %rd154, %rd11, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd154) : "l"(rd11));
  // PTX:90 add.s64 %rd155, %rd153, %rd154
  asm("add.s64 %0, %1, %2;" : "=l"(rd155) : "l"(rd153), "l"(rd154));
  // PTX:91 ld.global.f32 %f78, [%rd155]
  f78 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd155) + (0)))));
  // PTX:92 mul.f32 %f1, %f78, %f77
  asm("mul.f32 %0, %1, %2;" : "=f"(f1) : "f"(f78), "f"(f77));
  // PTX:93 setp.leu.f32 %p3, %f1, 0f00000000
  p3 = ((isnan(((float)(f1))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f1)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:94 @%p3 bra $L__BB57_131
  if (p3) { goto L_BB57_131; }
  // PTX:96 @%p2 bra $L__BB57_7
  if (p2) { goto L_BB57_7; }
  // PTX:98 div.u64 %rd687, %rd7, %rd138
  asm("div.u64 %0, %1, %2;" : "=l"(rd687) : "l"(rd7), "l"(rd138));
  // PTX:99 bra.uni $L__BB57_8
  goto L_BB57_8;
  // PTX:101 $L__BB57_7:
L_BB57_7:;
  // PTX:102 cvt.u32.u64 %r19, %rd138
  asm("cvt.u32.u64 %0, %1;" : "=r"(r19) : "l"(rd138));
  // PTX:103 cvt.u32.u64 %r20, %rd7
  asm("cvt.u32.u64 %0, %1;" : "=r"(r20) : "l"(rd7));
  // PTX:104 div.u32 %r21, %r20, %r19
  asm("div.u32 %0, %1, %2;" : "=r"(r21) : "r"(r20), "r"(r19));
  // PTX:105 cvt.u64.u32 %rd687, %r21
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd687) : "r"(r21));
  // PTX:107 $L__BB57_8:
L_BB57_8:;
  // PTX:108 mul.lo.s64 %rd158, %rd687, %rd139
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd158) : "l"(rd687), "l"(rd139));
  // PTX:109 cvt.u32.u64 %r1, %rd158
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd158));
  // PTX:110 cvta.to.global.u64 %rd159, %rd129
  rd159 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd129));
  // PTX:111 shl.b64 %rd160, %rd11, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd160) : "l"(rd11));
  // PTX:112 add.s64 %rd161, %rd159, %rd160
  asm("add.s64 %0, %1, %2;" : "=l"(rd161) : "l"(rd159), "l"(rd160));
  // PTX:113 ld.global.u32 %r2, [%rd161+4]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd161) + (4)))));
  // PTX:114 ld.global.u32 %r23, [%rd161]
  r23 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd161) + (0)))));
  // PTX:115 mul.wide.s32 %rd162, %r23, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd162) : "r"(r23));
  // PTX:116 add.s64 %rd163, %rd4, %rd162
  asm("add.s64 %0, %1, %2;" : "=l"(rd163) : "l"(rd4), "l"(rd162));
  // PTX:117 cvta.to.global.u64 %rd164, %rd131
  rd164 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd131));
  // PTX:118 shl.b64 %rd165, %rd11, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd165) : "l"(rd11));
  // PTX:119 add.s64 %rd166, %rd164, %rd165
  asm("add.s64 %0, %1, %2;" : "=l"(rd166) : "l"(rd164), "l"(rd165));
  // PTX:120 cvta.to.global.u64 %rd167, %rd132
  rd167 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd132));
  // PTX:121 add.s64 %rd168, %rd167, %rd165
  asm("add.s64 %0, %1, %2;" : "=l"(rd168) : "l"(rd167), "l"(rd165));
  // PTX:122 ld.global.f32 %f79, [%rd168]
  f79 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd168) + (0)))));
  // PTX:123 ld.global.f32 %f80, [%rd166]
  f80 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd166) + (0)))));
  // PTX:124 add.f32 %f81, %f80, %f79
  asm("add.f32 %0, %1, %2;" : "=f"(f81) : "f"(f80), "f"(f79));
  // PTX:125 ld.global.f32 %f82, [%rd168+4]
  f82 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd168) + (4)))));
  // PTX:126 ld.global.f32 %f83, [%rd166+4]
  f83 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd166) + (4)))));
  // PTX:127 add.f32 %f84, %f83, %f82
  asm("add.f32 %0, %1, %2;" : "=f"(f84) : "f"(f83), "f"(f82));
  // PTX:128 ld.global.f32 %f85, [%rd168+8]
  f85 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd168) + (8)))));
  // PTX:129 ld.global.f32 %f86, [%rd166+8]
  f86 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd166) + (8)))));
  // PTX:130 add.f32 %f87, %f86, %f85
  asm("add.f32 %0, %1, %2;" : "=f"(f87) : "f"(f86), "f"(f85));
  // PTX:131 ld.global.f32 %f88, [%rd168+12]
  f88 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd168) + (12)))));
  // PTX:132 ld.global.f32 %f89, [%rd166+12]
  f89 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd166) + (12)))));
  // PTX:133 add.f32 %f90, %f89, %f88
  asm("add.f32 %0, %1, %2;" : "=f"(f90) : "f"(f89), "f"(f88));
  // PTX:134 sub.f32 %f91, %f79, %f80
  asm("sub.f32 %0, %1, %2;" : "=f"(f91) : "f"(f79), "f"(f80));
  // PTX:135 sub.f32 %f92, %f82, %f83
  asm("sub.f32 %0, %1, %2;" : "=f"(f92) : "f"(f82), "f"(f83));
  // PTX:136 sub.f32 %f93, %f85, %f86
  asm("sub.f32 %0, %1, %2;" : "=f"(f93) : "f"(f85), "f"(f86));
  // PTX:137 sub.f32 %f94, %f88, %f89
  asm("sub.f32 %0, %1, %2;" : "=f"(f94) : "f"(f88), "f"(f89));
  // PTX:138 cvta.to.global.u64 %rd169, %rd134
  rd169 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd134));
  // PTX:139 shl.b64 %rd170, %rd7, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd170) : "l"(rd7));
  // PTX:140 add.s64 %rd171, %rd169, %rd170
  asm("add.s64 %0, %1, %2;" : "=l"(rd171) : "l"(rd169), "l"(rd170));
  // PTX:141 ld.global.f32 %f95, [%rd171]
  f95 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd171) + (0)))));
  // PTX:142 mul.f32 %f96, %f95, %f91
  asm("mul.f32 %0, %1, %2;" : "=f"(f96) : "f"(f95), "f"(f91));
  // PTX:143 mul.f32 %f97, %f95, %f92
  asm("mul.f32 %0, %1, %2;" : "=f"(f97) : "f"(f95), "f"(f92));
  // PTX:144 mul.f32 %f98, %f95, %f93
  asm("mul.f32 %0, %1, %2;" : "=f"(f98) : "f"(f95), "f"(f93));
  // PTX:145 mul.f32 %f99, %f95, %f94
  asm("mul.f32 %0, %1, %2;" : "=f"(f99) : "f"(f95), "f"(f94));
  // PTX:146 ld.global.u32 %r24, [%rd163]
  r24 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd163) + (0)))));
  // PTX:147 cvta.to.global.u64 %rd172, %rd130
  rd172 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd130));
  // PTX:148 add.s64 %rd173, %rd172, %rd165
  asm("add.s64 %0, %1, %2;" : "=l"(rd173) : "l"(rd172), "l"(rd165));
  // PTX:149 ld.global.f32 %f100, [%rd173]
  f100 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd173) + (0)))));
  // PTX:150 ld.global.u32 %r25, [%rd163+4]
  r25 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd163) + (4)))));
  // PTX:151 ld.global.f32 %f101, [%rd173+4]
  f101 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd173) + (4)))));
  // PTX:152 ld.global.u32 %r26, [%rd163+8]
  r26 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd163) + (8)))));
  // PTX:153 ld.global.f32 %f102, [%rd173+8]
  f102 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd173) + (8)))));
  // PTX:154 ld.global.u32 %r27, [%rd163+12]
  r27 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd163) + (12)))));
  // PTX:155 add.s32 %r6, %r27, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r6) : "r"(r27), "r"(r1));
  // PTX:156 add.s32 %r5, %r26, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r5) : "r"(r26), "r"(r1));
  // PTX:157 add.s32 %r4, %r25, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r4) : "r"(r25), "r"(r1));
  // PTX:158 add.s32 %r131, %r24, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r131) : "r"(r24), "r"(r1));
  // PTX:159 st.local.v4.u32 [%rd5], {%r131, %r4, %r5, %r6}
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd5) + (0))))) = (unsigned)(r131); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd5) + (4))))) = (unsigned)(r4); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd5) + (8))))) = (unsigned)(r5); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd5) + (12))))) = (unsigned)(r6);
  // PTX:160 ld.global.f32 %f103, [%rd173+12]
  f103 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd173) + (12)))));
  // PTX:161 neg.f32 %f4, %f102
  asm("neg.f32 %0, %1;" : "=f"(f4) : "f"(f102));
  // PTX:162 neg.f32 %f3, %f101
  asm("neg.f32 %0, %1;" : "=f"(f3) : "f"(f101));
  // PTX:163 neg.f32 %f2, %f100
  asm("neg.f32 %0, %1;" : "=f"(f2) : "f"(f100));
  // PTX:164 neg.f32 %f5, %f103
  asm("neg.f32 %0, %1;" : "=f"(f5) : "f"(f103));
  // PTX:165 st.local.v4.f32 [%rd6], {%f2, %f3, %f4, %f5}
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd6) + (0))))) = (float)(f2); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd6) + (4))))) = (float)(f3); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd6) + (8))))) = (float)(f4); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd6) + (12))))) = (float)(f5);
  // PTX:166 fma.rn.f32 %f6, %f81, 0f3F000000, %f96
  asm("fma.rn.f32 %0, %1, 0f3F000000, %2;" : "=f"(f6) : "f"(f81), "f"(f96));
  // PTX:167 fma.rn.f32 %f7, %f84, 0f3F000000, %f97
  asm("fma.rn.f32 %0, %1, 0f3F000000, %2;" : "=f"(f7) : "f"(f84), "f"(f97));
  // PTX:168 fma.rn.f32 %f8, %f87, 0f3F000000, %f98
  asm("fma.rn.f32 %0, %1, 0f3F000000, %2;" : "=f"(f8) : "f"(f87), "f"(f98));
  // PTX:169 fma.rn.f32 %f9, %f90, 0f3F000000, %f99
  asm("fma.rn.f32 %0, %1, 0f3F000000, %2;" : "=f"(f9) : "f"(f90), "f"(f99));
  // PTX:170 setp.lt.s32 %p5, %r2, 0
  p5 = (((int)(r2)) < ((int)(0)));
  // PTX:171 mov.u32 %r130, 4
  asm("mov.u32 %0, 4;" : "=r"(r130) : );
  // PTX:172 @%p5 bra $L__BB57_10
  if (p5) { goto L_BB57_10; }
  // PTX:174 mul.wide.s32 %rd174, %r2, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd174) : "r"(r2));
  // PTX:175 add.s64 %rd175, %rd4, %rd174
  asm("add.s64 %0, %1, %2;" : "=l"(rd175) : "l"(rd4), "l"(rd174));
  // PTX:176 ld.global.u32 %r29, [%rd175]
  r29 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd175) + (0)))));
  // PTX:177 ld.global.u32 %r30, [%rd175+4]
  r30 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd175) + (4)))));
  // PTX:178 ld.global.u32 %r31, [%rd175+8]
  r31 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd175) + (8)))));
  // PTX:179 ld.global.u32 %r32, [%rd175+12]
  r32 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd175) + (12)))));
  // PTX:180 add.s32 %r33, %r32, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r33) : "r"(r32), "r"(r1));
  // PTX:181 add.s32 %r34, %r31, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r34) : "r"(r31), "r"(r1));
  // PTX:182 add.s32 %r35, %r30, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r35) : "r"(r30), "r"(r1));
  // PTX:183 add.s32 %r36, %r29, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r36) : "r"(r29), "r"(r1));
  // PTX:184 st.local.v4.u32 [%rd5+16], {%r36, %r35, %r34, %r33}
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd5) + (16))))) = (unsigned)(r36); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd5) + (20))))) = (unsigned)(r35); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd5) + (24))))) = (unsigned)(r34); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd5) + (28))))) = (unsigned)(r33);
  // PTX:185 st.local.v4.f32 [%rd6+16], {%f6, %f7, %f8, %f9}
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd6) + (16))))) = (float)(f6); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd6) + (20))))) = (float)(f7); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd6) + (24))))) = (float)(f8); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd6) + (28))))) = (float)(f9);
  // PTX:186 mov.u32 %r130, 8
  asm("mov.u32 %0, 8;" : "=r"(r130) : );
  // PTX:188 $L__BB57_10:
L_BB57_10:;
  // PTX:189 cvta.to.global.u64 %rd176, %rd135
  rd176 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd135));
  // PTX:190 mul.lo.s64 %rd177, %rd7, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd177) : "l"(rd7));
  // PTX:191 add.s64 %rd17, %rd176, %rd177
  asm("add.s64 %0, %1, %2;" : "=l"(rd17) : "l"(rd176), "l"(rd177));
  // PTX:192 mov.b32 %r38, %f2
  asm("mov.b32 %0, %1;" : "=r"(r38) : "f"(f2));
  // PTX:193 mov.b64 %rd178, {%r38, %r39}
  asm("mov.b64 %0, {%1, %2};" : "=l"(rd178) : "r"(r38), "r"(r39));
  // PTX:194 cvt.u32.u64 %r40, %rd178
  asm("cvt.u32.u64 %0, %1;" : "=r"(r40) : "l"(rd178));
  // PTX:195 mov.b32 %f460, %r40
  asm("mov.b32 %0, %1;" : "=f"(f460) : "r"(r40));
  // PTX:196 mov.u32 %r132, 0
  asm("mov.u32 %0, 0;" : "=r"(r132) : );
  // PTX:197 bra.uni $L__BB57_11
  goto L_BB57_11;
  // PTX:199 $L__BB57_130:
L_BB57_130:;
  // PTX:200 add.s32 %r132, %r132, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r132) : "r"(r132));
  // PTX:202 $L__BB57_11:
L_BB57_11:;
  // PTX:203 mul.f32 %f12, %f1, %f460
  asm("mul.f32 %0, %1, %2;" : "=f"(f12) : "f"(f1), "f"(f460));
  // PTX:204 mul.f32 %f104, %f460, %f12
  asm("mul.f32 %0, %1, %2;" : "=f"(f104) : "f"(f460), "f"(f12));
  // PTX:205 ld.global.f32 %f105, [%rd17]
  f105 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:206 mul.f32 %f106, %f105, %f104
  asm("mul.f32 %0, %1, %2;" : "=f"(f106) : "f"(f105), "f"(f104));
  // PTX:207 ld.global.f32 %f107, [%rd17+4]
  f107 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (4)))));
  // PTX:208 mul.f32 %f108, %f107, %f104
  asm("mul.f32 %0, %1, %2;" : "=f"(f108) : "f"(f107), "f"(f104));
  // PTX:209 ld.global.f32 %f109, [%rd17+8]
  f109 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (8)))));
  // PTX:210 mul.f32 %f110, %f104, %f109
  asm("mul.f32 %0, %1, %2;" : "=f"(f110) : "f"(f104), "f"(f109));
  // PTX:211 ld.global.f32 %f111, [%rd17+12]
  f111 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (12)))));
  // PTX:212 mul.f32 %f112, %f104, %f111
  asm("mul.f32 %0, %1, %2;" : "=f"(f112) : "f"(f104), "f"(f111));
  // PTX:213 ld.global.f32 %f113, [%rd17+16]
  f113 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (16)))));
  // PTX:214 mul.f32 %f114, %f104, %f113
  asm("mul.f32 %0, %1, %2;" : "=f"(f114) : "f"(f104), "f"(f113));
  // PTX:215 ld.global.f32 %f115, [%rd17+20]
  f115 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (20)))));
  // PTX:216 mul.f32 %f116, %f104, %f115
  asm("mul.f32 %0, %1, %2;" : "=f"(f116) : "f"(f104), "f"(f115));
  // PTX:217 ld.global.f32 %f117, [%rd17+24]
  f117 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (24)))));
  // PTX:218 mul.f32 %f118, %f104, %f117
  asm("mul.f32 %0, %1, %2;" : "=f"(f118) : "f"(f104), "f"(f117));
  // PTX:219 ld.global.f32 %f119, [%rd17+28]
  f119 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (28)))));
  // PTX:220 mul.f32 %f120, %f104, %f119
  asm("mul.f32 %0, %1, %2;" : "=f"(f120) : "f"(f104), "f"(f119));
  // PTX:221 ld.global.f32 %f121, [%rd17+32]
  f121 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (32)))));
  // PTX:222 mul.f32 %f122, %f104, %f121
  asm("mul.f32 %0, %1, %2;" : "=f"(f122) : "f"(f104), "f"(f121));
  // PTX:223 cvt.s64.s32 %rd19, %r131
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd19) : "r"(r131));
  // PTX:224 mul.wide.s32 %rd179, %r131, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd179) : "r"(r131));
  // PTX:225 add.s64 %rd20, %rd2, %rd179
  asm("add.s64 %0, %1, %2;" : "=l"(rd20) : "l"(rd2), "l"(rd179));
  // PTX:226 red.global.add.f32 [%rd20], %f106
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))), (float)(f106));
  // PTX:227 add.s64 %rd180, %rd20, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd180) : "l"(rd20));
  // PTX:228 red.global.add.f32 [%rd180], %f108
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (0)))), (float)(f108));
  // PTX:229 add.s64 %rd181, %rd20, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd181) : "l"(rd20));
  // PTX:230 red.global.add.f32 [%rd181], %f110
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd181) + (0)))), (float)(f110));
  // PTX:231 add.s64 %rd182, %rd20, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd182) : "l"(rd20));
  // PTX:232 red.global.add.f32 [%rd182], %f112
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd182) + (0)))), (float)(f112));
  // PTX:233 add.s64 %rd183, %rd20, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd183) : "l"(rd20));
  // PTX:234 red.global.add.f32 [%rd183], %f114
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd183) + (0)))), (float)(f114));
  // PTX:235 add.s64 %rd184, %rd20, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd184) : "l"(rd20));
  // PTX:236 red.global.add.f32 [%rd184], %f116
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd184) + (0)))), (float)(f116));
  // PTX:237 add.s64 %rd185, %rd20, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd185) : "l"(rd20));
  // PTX:238 red.global.add.f32 [%rd185], %f118
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (0)))), (float)(f118));
  // PTX:239 add.s64 %rd186, %rd20, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd186) : "l"(rd20));
  // PTX:240 red.global.add.f32 [%rd186], %f120
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd186) + (0)))), (float)(f120));
  // PTX:241 add.s64 %rd187, %rd20, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd187) : "l"(rd20));
  // PTX:242 red.global.add.f32 [%rd187], %f122
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd187) + (0)))), (float)(f122));
  // PTX:243 add.s32 %r41, %r132, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r41) : "r"(r132));
  // PTX:244 setp.ge.u32 %p6, %r41, %r130
  p6 = (((unsigned)(r41)) >= ((unsigned)(r130)));
  // PTX:245 @%p6 bra $L__BB57_131
  if (p6) { goto L_BB57_131; }
  // PTX:247 add.u64 %rd684, %SPL, 32
  asm("add.u64 %0, %1, 32;" : "=l"(rd684) : "l"(SPL));
  // PTX:248 add.u64 %rd682, %SPL, 0
  asm("add.u64 %0, %1, 0;" : "=l"(rd682) : "l"(SPL));
  // PTX:249 cvt.u32.u64 %r42, %rd19
  asm("cvt.u32.u64 %0, %1;" : "=r"(r42) : "l"(rd19));
  // PTX:250 shl.b64 %rd188, %rd19, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd188) : "l"(rd19));
  // PTX:251 add.s64 %rd21, %rd3, %rd188
  asm("add.s64 %0, %1, %2;" : "=l"(rd21) : "l"(rd3), "l"(rd188));
  // PTX:252 mul.wide.s32 %rd189, %r132, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd189) : "r"(r132));
  // PTX:253 add.s64 %rd190, %rd684, %rd189
  asm("add.s64 %0, %1, %2;" : "=l"(rd190) : "l"(rd684), "l"(rd189));
  // PTX:254 add.s64 %rd22, %rd190, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd22) : "l"(rd190));
  // PTX:255 ld.local.f32 %f460, [%rd190+4]
  f460 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd190) + (4)))));
  // PTX:256 mul.f32 %f132, %f12, %f460
  asm("mul.f32 %0, %1, %2;" : "=f"(f132) : "f"(f12), "f"(f460));
  // PTX:257 ld.global.f32 %f133, [%rd17]
  f133 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:258 mul.f32 %f14, %f133, %f132
  asm("mul.f32 %0, %1, %2;" : "=f"(f14) : "f"(f133), "f"(f132));
  // PTX:259 ld.global.f32 %f134, [%rd17+4]
  f134 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (4)))));
  // PTX:260 mul.f32 %f15, %f132, %f134
  asm("mul.f32 %0, %1, %2;" : "=f"(f15) : "f"(f132), "f"(f134));
  // PTX:261 ld.global.f32 %f135, [%rd17+8]
  f135 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (8)))));
  // PTX:262 mul.f32 %f16, %f132, %f135
  asm("mul.f32 %0, %1, %2;" : "=f"(f16) : "f"(f132), "f"(f135));
  // PTX:263 ld.global.f32 %f136, [%rd17+12]
  f136 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (12)))));
  // PTX:264 mul.f32 %f17, %f132, %f136
  asm("mul.f32 %0, %1, %2;" : "=f"(f17) : "f"(f132), "f"(f136));
  // PTX:265 ld.global.f32 %f137, [%rd17+16]
  f137 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (16)))));
  // PTX:266 mul.f32 %f18, %f132, %f137
  asm("mul.f32 %0, %1, %2;" : "=f"(f18) : "f"(f132), "f"(f137));
  // PTX:267 ld.global.f32 %f138, [%rd17+20]
  f138 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (20)))));
  // PTX:268 mul.f32 %f19, %f132, %f138
  asm("mul.f32 %0, %1, %2;" : "=f"(f19) : "f"(f132), "f"(f138));
  // PTX:269 ld.global.f32 %f139, [%rd17+24]
  f139 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (24)))));
  // PTX:270 mul.f32 %f20, %f132, %f139
  asm("mul.f32 %0, %1, %2;" : "=f"(f20) : "f"(f132), "f"(f139));
  // PTX:271 ld.global.f32 %f140, [%rd17+28]
  f140 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (28)))));
  // PTX:272 mul.f32 %f21, %f132, %f140
  asm("mul.f32 %0, %1, %2;" : "=f"(f21) : "f"(f132), "f"(f140));
  // PTX:273 ld.global.f32 %f141, [%rd17+32]
  f141 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (32)))));
  // PTX:274 mul.f32 %f22, %f132, %f141
  asm("mul.f32 %0, %1, %2;" : "=f"(f22) : "f"(f132), "f"(f141));
  // PTX:275 add.s64 %rd191, %rd682, %rd189
  asm("add.s64 %0, %1, %2;" : "=l"(rd191) : "l"(rd682), "l"(rd189));
  // PTX:276 add.s64 %rd23, %rd191, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd23) : "l"(rd191));
  // PTX:277 ld.local.u32 %r131, [%rd191+4]
  r131 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd191) + (4)))));
  // PTX:278 cvt.s64.s32 %rd24, %r131
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd24) : "r"(r131));
  // PTX:279 setp.eq.s32 %p7, %r42, %r131
  p7 = (((int)(r42)) == ((int)(r131)));
  // PTX:280 @%p7 bra $L__BB57_19
  if (p7) { goto L_BB57_19; }
  // PTX:281 bra.uni $L__BB57_13
  goto L_BB57_13;
  // PTX:283 $L__BB57_19:
L_BB57_19:;
  // PTX:284 red.global.add.f32 [%rd20], %f14
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))), (float)(f14));
  // PTX:285 red.global.add.f32 [%rd180], %f15
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (0)))), (float)(f15));
  // PTX:286 red.global.add.f32 [%rd181], %f16
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd181) + (0)))), (float)(f16));
  // PTX:287 red.global.add.f32 [%rd182], %f17
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd182) + (0)))), (float)(f17));
  // PTX:288 red.global.add.f32 [%rd183], %f18
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd183) + (0)))), (float)(f18));
  // PTX:289 red.global.add.f32 [%rd184], %f19
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd184) + (0)))), (float)(f19));
  // PTX:290 red.global.add.f32 [%rd185], %f20
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (0)))), (float)(f20));
  // PTX:291 red.global.add.f32 [%rd186], %f21
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd186) + (0)))), (float)(f21));
  // PTX:292 red.global.add.f32 [%rd187], %f22
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd187) + (0)))), (float)(f22));
  // PTX:293 bra.uni $L__BB57_20
  goto L_BB57_20;
  // PTX:295 $L__BB57_13:
L_BB57_13:;
  // PTX:296 ld.global.s32 %rd193, [%rd21]
  rd193 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (0)))));
  // PTX:297 mov.u64 %rd690, 0
  asm("mov.u64 %0, 0;" : "=l"(rd690) : );
  // PTX:298 min.u64 %rd25, %rd193, %rd136
  asm("min.u64 %0, %1, %2;" : "=l"(rd25) : "l"(rd193), "l"(rd136));
  // PTX:299 setp.eq.s64 %p8, %rd25, 0
  p8 = (((long long)(rd25)) == ((long long)(0)));
  // PTX:300 @%p8 bra $L__BB57_16
  if (p8) { goto L_BB57_16; }
  // PTX:302 mov.u64 %rd690, 0
  asm("mov.u64 %0, 0;" : "=l"(rd690) : );
  // PTX:303 mov.u64 %rd688, %rd25
  asm("mov.u64 %0, %1;" : "=l"(rd688) : "l"(rd25));
  // PTX:305 $L__BB57_15:
L_BB57_15:;
  // PTX:306 sub.s64 %rd195, %rd688, %rd690
  asm("sub.s64 %0, %1, %2;" : "=l"(rd195) : "l"(rd688), "l"(rd690));
  // PTX:307 shr.u64 %rd196, %rd195, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd196) : "l"(rd195));
  // PTX:308 add.s64 %rd197, %rd196, %rd690
  asm("add.s64 %0, %1, %2;" : "=l"(rd197) : "l"(rd196), "l"(rd690));
  // PTX:309 mul.lo.s64 %rd198, %rd197, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd198) : "l"(rd197), "l"(rd140));
  // PTX:310 add.s64 %rd199, %rd198, %rd19
  asm("add.s64 %0, %1, %2;" : "=l"(rd199) : "l"(rd198), "l"(rd19));
  // PTX:311 mul.lo.s64 %rd200, %rd199, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd200) : "l"(rd199));
  // PTX:312 add.s64 %rd201, %rd1, %rd200
  asm("add.s64 %0, %1, %2;" : "=l"(rd201) : "l"(rd1), "l"(rd200));
  // PTX:313 ld.global.u32 %r43, [%rd201]
  r43 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd201) + (0)))));
  // PTX:314 setp.lt.s32 %p9, %r43, %r131
  p9 = (((int)(r43)) < ((int)(r131)));
  // PTX:315 add.s64 %rd202, %rd197, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd202) : "l"(rd197));
  // PTX:316 selp.b64 %rd690, %rd202, %rd690, %p9
  rd690 = p9 ? rd202 : rd690;
  // PTX:317 selp.b64 %rd688, %rd688, %rd197, %p9
  rd688 = p9 ? rd688 : rd197;
  // PTX:318 setp.gt.u64 %p10, %rd688, %rd690
  p10 = (((unsigned long long)(rd688)) > ((unsigned long long)(rd690)));
  // PTX:319 @%p10 bra $L__BB57_15
  if (p10) { goto L_BB57_15; }
  // PTX:321 $L__BB57_16:
L_BB57_16:;
  // PTX:322 setp.ge.u64 %p11, %rd690, %rd25
  p11 = (((unsigned long long)(rd690)) >= ((unsigned long long)(rd25)));
  // PTX:323 @%p11 bra $L__BB57_20
  if (p11) { goto L_BB57_20; }
  // PTX:325 mul.lo.s64 %rd203, %rd690, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd203) : "l"(rd690), "l"(rd140));
  // PTX:326 add.s64 %rd31, %rd203, %rd19
  asm("add.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd203), "l"(rd19));
  // PTX:327 mul.lo.s64 %rd204, %rd31, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd204) : "l"(rd31));
  // PTX:328 add.s64 %rd205, %rd1, %rd204
  asm("add.s64 %0, %1, %2;" : "=l"(rd205) : "l"(rd1), "l"(rd204));
  // PTX:329 ld.global.u32 %r44, [%rd205]
  r44 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd205) + (0)))));
  // PTX:330 setp.ne.s32 %p12, %r44, %r131
  p12 = (((int)(r44)) != ((int)(r131)));
  // PTX:331 @%p12 bra $L__BB57_20
  if (p12) { goto L_BB57_20; }
  // PTX:333 add.s64 %rd208, %rd205, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd208) : "l"(rd205));
  // PTX:334 red.global.add.f32 [%rd208], %f14
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd208) + (0)))), (float)(f14));
  // PTX:335 add.s64 %rd209, %rd205, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd209) : "l"(rd205));
  // PTX:336 red.global.add.f32 [%rd209], %f15
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd209) + (0)))), (float)(f15));
  // PTX:337 add.s64 %rd210, %rd205, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd210) : "l"(rd205));
  // PTX:338 red.global.add.f32 [%rd210], %f16
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd210) + (0)))), (float)(f16));
  // PTX:339 add.s64 %rd211, %rd205, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd211) : "l"(rd205));
  // PTX:340 red.global.add.f32 [%rd211], %f17
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd211) + (0)))), (float)(f17));
  // PTX:341 add.s64 %rd212, %rd205, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd212) : "l"(rd205));
  // PTX:342 red.global.add.f32 [%rd212], %f18
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd212) + (0)))), (float)(f18));
  // PTX:343 add.s64 %rd213, %rd205, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd213) : "l"(rd205));
  // PTX:344 red.global.add.f32 [%rd213], %f19
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd213) + (0)))), (float)(f19));
  // PTX:345 add.s64 %rd214, %rd205, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd214) : "l"(rd205));
  // PTX:346 red.global.add.f32 [%rd214], %f20
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd214) + (0)))), (float)(f20));
  // PTX:347 add.s64 %rd215, %rd205, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd215) : "l"(rd205));
  // PTX:348 red.global.add.f32 [%rd215], %f21
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd215) + (0)))), (float)(f21));
  // PTX:349 add.s64 %rd216, %rd205, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd216) : "l"(rd205));
  // PTX:350 red.global.add.f32 [%rd216], %f22
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd216) + (0)))), (float)(f22));
  // PTX:352 $L__BB57_20:
L_BB57_20:;
  // PTX:353 cvt.u32.u64 %r128, %rd19
  asm("cvt.u32.u64 %0, %1;" : "=r"(r128) : "l"(rd19));
  // PTX:354 setp.eq.s32 %p97, %r128, %r131
  p97 = (((int)(r128)) == ((int)(r131)));
  // PTX:355 @%p97 bra $L__BB57_27
  if (p97) { goto L_BB57_27; }
  // PTX:356 bra.uni $L__BB57_21
  goto L_BB57_21;
  // PTX:358 $L__BB57_27:
L_BB57_27:;
  // PTX:359 mul.lo.s64 %rd252, %rd24, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd252) : "l"(rd24));
  // PTX:360 add.s64 %rd253, %rd2, %rd252
  asm("add.s64 %0, %1, %2;" : "=l"(rd253) : "l"(rd2), "l"(rd252));
  // PTX:361 red.global.add.f32 [%rd253], %f14
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd253) + (0)))), (float)(f14));
  // PTX:362 add.s64 %rd254, %rd253, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd254) : "l"(rd253));
  // PTX:363 red.global.add.f32 [%rd254], %f15
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd254) + (0)))), (float)(f15));
  // PTX:364 add.s64 %rd255, %rd253, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd255) : "l"(rd253));
  // PTX:365 red.global.add.f32 [%rd255], %f16
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd255) + (0)))), (float)(f16));
  // PTX:366 add.s64 %rd256, %rd253, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd256) : "l"(rd253));
  // PTX:367 red.global.add.f32 [%rd256], %f17
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd256) + (0)))), (float)(f17));
  // PTX:368 add.s64 %rd257, %rd253, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd257) : "l"(rd253));
  // PTX:369 red.global.add.f32 [%rd257], %f18
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd257) + (0)))), (float)(f18));
  // PTX:370 add.s64 %rd258, %rd253, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd258) : "l"(rd253));
  // PTX:371 red.global.add.f32 [%rd258], %f19
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd258) + (0)))), (float)(f19));
  // PTX:372 add.s64 %rd259, %rd253, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd259) : "l"(rd253));
  // PTX:373 red.global.add.f32 [%rd259], %f20
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd259) + (0)))), (float)(f20));
  // PTX:374 add.s64 %rd260, %rd253, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd260) : "l"(rd253));
  // PTX:375 red.global.add.f32 [%rd260], %f21
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd260) + (0)))), (float)(f21));
  // PTX:376 add.s64 %rd261, %rd253, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd261) : "l"(rd253));
  // PTX:377 red.global.add.f32 [%rd261], %f22
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd261) + (0)))), (float)(f22));
  // PTX:378 bra.uni $L__BB57_28
  goto L_BB57_28;
  // PTX:380 $L__BB57_21:
L_BB57_21:;
  // PTX:381 shl.b64 %rd226, %rd24, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd226) : "l"(rd24));
  // PTX:382 add.s64 %rd227, %rd3, %rd226
  asm("add.s64 %0, %1, %2;" : "=l"(rd227) : "l"(rd3), "l"(rd226));
  // PTX:383 ld.global.s32 %rd228, [%rd227]
  rd228 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd227) + (0)))));
  // PTX:384 mov.u64 %rd693, 0
  asm("mov.u64 %0, 0;" : "=l"(rd693) : );
  // PTX:385 min.u64 %rd32, %rd228, %rd136
  asm("min.u64 %0, %1, %2;" : "=l"(rd32) : "l"(rd228), "l"(rd136));
  // PTX:386 setp.eq.s64 %p14, %rd32, 0
  p14 = (((long long)(rd32)) == ((long long)(0)));
  // PTX:387 @%p14 bra $L__BB57_24
  if (p14) { goto L_BB57_24; }
  // PTX:389 mov.u64 %rd693, 0
  asm("mov.u64 %0, 0;" : "=l"(rd693) : );
  // PTX:390 mov.u64 %rd691, %rd32
  asm("mov.u64 %0, %1;" : "=l"(rd691) : "l"(rd32));
  // PTX:392 $L__BB57_23:
L_BB57_23:;
  // PTX:393 sub.s64 %rd230, %rd691, %rd693
  asm("sub.s64 %0, %1, %2;" : "=l"(rd230) : "l"(rd691), "l"(rd693));
  // PTX:394 shr.u64 %rd231, %rd230, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd231) : "l"(rd230));
  // PTX:395 add.s64 %rd232, %rd231, %rd693
  asm("add.s64 %0, %1, %2;" : "=l"(rd232) : "l"(rd231), "l"(rd693));
  // PTX:396 mul.lo.s64 %rd233, %rd232, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd233) : "l"(rd232), "l"(rd140));
  // PTX:397 add.s64 %rd234, %rd233, %rd24
  asm("add.s64 %0, %1, %2;" : "=l"(rd234) : "l"(rd233), "l"(rd24));
  // PTX:398 mul.lo.s64 %rd235, %rd234, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd235) : "l"(rd234));
  // PTX:399 add.s64 %rd236, %rd1, %rd235
  asm("add.s64 %0, %1, %2;" : "=l"(rd236) : "l"(rd1), "l"(rd235));
  // PTX:400 ld.global.u32 %r46, [%rd236]
  r46 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd236) + (0)))));
  // PTX:401 setp.lt.s32 %p15, %r46, %r42
  p15 = (((int)(r46)) < ((int)(r42)));
  // PTX:402 add.s64 %rd237, %rd232, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd237) : "l"(rd232));
  // PTX:403 selp.b64 %rd693, %rd237, %rd693, %p15
  rd693 = p15 ? rd237 : rd693;
  // PTX:404 selp.b64 %rd691, %rd691, %rd232, %p15
  rd691 = p15 ? rd691 : rd232;
  // PTX:405 setp.gt.u64 %p16, %rd691, %rd693
  p16 = (((unsigned long long)(rd691)) > ((unsigned long long)(rd693)));
  // PTX:406 @%p16 bra $L__BB57_23
  if (p16) { goto L_BB57_23; }
  // PTX:408 $L__BB57_24:
L_BB57_24:;
  // PTX:409 setp.ge.u64 %p17, %rd693, %rd32
  p17 = (((unsigned long long)(rd693)) >= ((unsigned long long)(rd32)));
  // PTX:410 @%p17 bra $L__BB57_28
  if (p17) { goto L_BB57_28; }
  // PTX:412 mul.lo.s64 %rd238, %rd693, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd238) : "l"(rd693), "l"(rd140));
  // PTX:413 add.s64 %rd38, %rd238, %rd24
  asm("add.s64 %0, %1, %2;" : "=l"(rd38) : "l"(rd238), "l"(rd24));
  // PTX:414 mul.lo.s64 %rd239, %rd38, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd239) : "l"(rd38));
  // PTX:415 add.s64 %rd240, %rd1, %rd239
  asm("add.s64 %0, %1, %2;" : "=l"(rd240) : "l"(rd1), "l"(rd239));
  // PTX:416 ld.global.u32 %r49, [%rd240]
  r49 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd240) + (0)))));
  // PTX:417 setp.ne.s32 %p18, %r49, %r42
  p18 = (((int)(r49)) != ((int)(r42)));
  // PTX:418 @%p18 bra $L__BB57_28
  if (p18) { goto L_BB57_28; }
  // PTX:420 add.s64 %rd243, %rd240, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd243) : "l"(rd240));
  // PTX:421 red.global.add.f32 [%rd243], %f14
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd243) + (0)))), (float)(f14));
  // PTX:422 add.s64 %rd244, %rd240, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd244) : "l"(rd240));
  // PTX:423 red.global.add.f32 [%rd244], %f15
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd244) + (0)))), (float)(f15));
  // PTX:424 add.s64 %rd245, %rd240, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd245) : "l"(rd240));
  // PTX:425 red.global.add.f32 [%rd245], %f16
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd245) + (0)))), (float)(f16));
  // PTX:426 add.s64 %rd246, %rd240, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd246) : "l"(rd240));
  // PTX:427 red.global.add.f32 [%rd246], %f17
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd246) + (0)))), (float)(f17));
  // PTX:428 add.s64 %rd247, %rd240, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd247) : "l"(rd240));
  // PTX:429 red.global.add.f32 [%rd247], %f18
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd247) + (0)))), (float)(f18));
  // PTX:430 add.s64 %rd248, %rd240, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd248) : "l"(rd240));
  // PTX:431 red.global.add.f32 [%rd248], %f19
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd248) + (0)))), (float)(f19));
  // PTX:432 add.s64 %rd249, %rd240, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd249) : "l"(rd240));
  // PTX:433 red.global.add.f32 [%rd249], %f20
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd249) + (0)))), (float)(f20));
  // PTX:434 add.s64 %rd250, %rd240, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd250) : "l"(rd240));
  // PTX:435 red.global.add.f32 [%rd250], %f21
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd250) + (0)))), (float)(f21));
  // PTX:436 add.s64 %rd251, %rd240, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd251) : "l"(rd240));
  // PTX:437 red.global.add.f32 [%rd251], %f22
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd251) + (0)))), (float)(f22));
  // PTX:439 $L__BB57_28:
L_BB57_28:;
  // PTX:440 add.s32 %r50, %r132, 2
  asm("add.s32 %0, %1, 2;" : "=r"(r50) : "r"(r132));
  // PTX:441 setp.ge.u32 %p19, %r50, %r130
  p19 = (((unsigned)(r50)) >= ((unsigned)(r130)));
  // PTX:442 @%p19 bra $L__BB57_130
  if (p19) { goto L_BB57_130; }
  // PTX:444 ld.local.f32 %f178, [%rd22+4]
  f178 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd22) + (4)))));
  // PTX:445 mul.f32 %f179, %f12, %f178
  asm("mul.f32 %0, %1, %2;" : "=f"(f179) : "f"(f12), "f"(f178));
  // PTX:446 ld.global.f32 %f180, [%rd17]
  f180 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:447 mul.f32 %f23, %f180, %f179
  asm("mul.f32 %0, %1, %2;" : "=f"(f23) : "f"(f180), "f"(f179));
  // PTX:448 ld.global.f32 %f181, [%rd17+4]
  f181 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (4)))));
  // PTX:449 mul.f32 %f24, %f179, %f181
  asm("mul.f32 %0, %1, %2;" : "=f"(f24) : "f"(f179), "f"(f181));
  // PTX:450 ld.global.f32 %f182, [%rd17+8]
  f182 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (8)))));
  // PTX:451 mul.f32 %f25, %f179, %f182
  asm("mul.f32 %0, %1, %2;" : "=f"(f25) : "f"(f179), "f"(f182));
  // PTX:452 ld.global.f32 %f183, [%rd17+12]
  f183 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (12)))));
  // PTX:453 mul.f32 %f26, %f179, %f183
  asm("mul.f32 %0, %1, %2;" : "=f"(f26) : "f"(f179), "f"(f183));
  // PTX:454 ld.global.f32 %f184, [%rd17+16]
  f184 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (16)))));
  // PTX:455 mul.f32 %f27, %f179, %f184
  asm("mul.f32 %0, %1, %2;" : "=f"(f27) : "f"(f179), "f"(f184));
  // PTX:456 ld.global.f32 %f185, [%rd17+20]
  f185 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (20)))));
  // PTX:457 mul.f32 %f28, %f179, %f185
  asm("mul.f32 %0, %1, %2;" : "=f"(f28) : "f"(f179), "f"(f185));
  // PTX:458 ld.global.f32 %f186, [%rd17+24]
  f186 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (24)))));
  // PTX:459 mul.f32 %f29, %f179, %f186
  asm("mul.f32 %0, %1, %2;" : "=f"(f29) : "f"(f179), "f"(f186));
  // PTX:460 ld.global.f32 %f187, [%rd17+28]
  f187 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (28)))));
  // PTX:461 mul.f32 %f30, %f179, %f187
  asm("mul.f32 %0, %1, %2;" : "=f"(f30) : "f"(f179), "f"(f187));
  // PTX:462 ld.global.f32 %f188, [%rd17+32]
  f188 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (32)))));
  // PTX:463 mul.f32 %f31, %f179, %f188
  asm("mul.f32 %0, %1, %2;" : "=f"(f31) : "f"(f179), "f"(f188));
  // PTX:464 ld.local.u32 %r52, [%rd23+4]
  r52 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd23) + (4)))));
  // PTX:465 cvt.s64.s32 %rd39, %r52
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd39) : "r"(r52));
  // PTX:466 setp.eq.s32 %p20, %r42, %r52
  p20 = (((int)(r42)) == ((int)(r52)));
  // PTX:467 @%p20 bra $L__BB57_36
  if (p20) { goto L_BB57_36; }
  // PTX:468 bra.uni $L__BB57_30
  goto L_BB57_30;
  // PTX:470 $L__BB57_36:
L_BB57_36:;
  // PTX:471 red.global.add.f32 [%rd20], %f23
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))), (float)(f23));
  // PTX:472 red.global.add.f32 [%rd180], %f24
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (0)))), (float)(f24));
  // PTX:473 red.global.add.f32 [%rd181], %f25
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd181) + (0)))), (float)(f25));
  // PTX:474 red.global.add.f32 [%rd182], %f26
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd182) + (0)))), (float)(f26));
  // PTX:475 red.global.add.f32 [%rd183], %f27
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd183) + (0)))), (float)(f27));
  // PTX:476 red.global.add.f32 [%rd184], %f28
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd184) + (0)))), (float)(f28));
  // PTX:477 red.global.add.f32 [%rd185], %f29
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (0)))), (float)(f29));
  // PTX:478 red.global.add.f32 [%rd186], %f30
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd186) + (0)))), (float)(f30));
  // PTX:479 red.global.add.f32 [%rd187], %f31
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd187) + (0)))), (float)(f31));
  // PTX:480 bra.uni $L__BB57_37
  goto L_BB57_37;
  // PTX:482 $L__BB57_30:
L_BB57_30:;
  // PTX:483 ld.global.s32 %rd263, [%rd21]
  rd263 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (0)))));
  // PTX:484 mov.u64 %rd696, 0
  asm("mov.u64 %0, 0;" : "=l"(rd696) : );
  // PTX:485 min.u64 %rd40, %rd263, %rd136
  asm("min.u64 %0, %1, %2;" : "=l"(rd40) : "l"(rd263), "l"(rd136));
  // PTX:486 setp.eq.s64 %p21, %rd40, 0
  p21 = (((long long)(rd40)) == ((long long)(0)));
  // PTX:487 @%p21 bra $L__BB57_33
  if (p21) { goto L_BB57_33; }
  // PTX:489 mov.u64 %rd696, 0
  asm("mov.u64 %0, 0;" : "=l"(rd696) : );
  // PTX:490 mov.u64 %rd694, %rd40
  asm("mov.u64 %0, %1;" : "=l"(rd694) : "l"(rd40));
  // PTX:492 $L__BB57_32:
L_BB57_32:;
  // PTX:493 sub.s64 %rd265, %rd694, %rd696
  asm("sub.s64 %0, %1, %2;" : "=l"(rd265) : "l"(rd694), "l"(rd696));
  // PTX:494 shr.u64 %rd266, %rd265, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd266) : "l"(rd265));
  // PTX:495 add.s64 %rd267, %rd266, %rd696
  asm("add.s64 %0, %1, %2;" : "=l"(rd267) : "l"(rd266), "l"(rd696));
  // PTX:496 mul.lo.s64 %rd268, %rd267, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd268) : "l"(rd267), "l"(rd140));
  // PTX:497 add.s64 %rd269, %rd268, %rd19
  asm("add.s64 %0, %1, %2;" : "=l"(rd269) : "l"(rd268), "l"(rd19));
  // PTX:498 mul.lo.s64 %rd270, %rd269, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd270) : "l"(rd269));
  // PTX:499 add.s64 %rd271, %rd1, %rd270
  asm("add.s64 %0, %1, %2;" : "=l"(rd271) : "l"(rd1), "l"(rd270));
  // PTX:500 ld.global.u32 %r53, [%rd271]
  r53 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd271) + (0)))));
  // PTX:501 cvt.u32.u64 %r54, %rd39
  asm("cvt.u32.u64 %0, %1;" : "=r"(r54) : "l"(rd39));
  // PTX:502 setp.lt.s32 %p22, %r53, %r54
  p22 = (((int)(r53)) < ((int)(r54)));
  // PTX:503 add.s64 %rd272, %rd267, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd272) : "l"(rd267));
  // PTX:504 selp.b64 %rd696, %rd272, %rd696, %p22
  rd696 = p22 ? rd272 : rd696;
  // PTX:505 selp.b64 %rd694, %rd694, %rd267, %p22
  rd694 = p22 ? rd694 : rd267;
  // PTX:506 setp.gt.u64 %p23, %rd694, %rd696
  p23 = (((unsigned long long)(rd694)) > ((unsigned long long)(rd696)));
  // PTX:507 @%p23 bra $L__BB57_32
  if (p23) { goto L_BB57_32; }
  // PTX:509 $L__BB57_33:
L_BB57_33:;
  // PTX:510 setp.ge.u64 %p24, %rd696, %rd40
  p24 = (((unsigned long long)(rd696)) >= ((unsigned long long)(rd40)));
  // PTX:511 @%p24 bra $L__BB57_37
  if (p24) { goto L_BB57_37; }
  // PTX:513 cvt.u32.u64 %r55, %rd39
  asm("cvt.u32.u64 %0, %1;" : "=r"(r55) : "l"(rd39));
  // PTX:514 mul.lo.s64 %rd273, %rd696, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd273) : "l"(rd696), "l"(rd140));
  // PTX:515 add.s64 %rd46, %rd273, %rd19
  asm("add.s64 %0, %1, %2;" : "=l"(rd46) : "l"(rd273), "l"(rd19));
  // PTX:516 mul.lo.s64 %rd274, %rd46, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd274) : "l"(rd46));
  // PTX:517 add.s64 %rd275, %rd1, %rd274
  asm("add.s64 %0, %1, %2;" : "=l"(rd275) : "l"(rd1), "l"(rd274));
  // PTX:518 ld.global.u32 %r56, [%rd275]
  r56 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd275) + (0)))));
  // PTX:519 setp.ne.s32 %p25, %r56, %r55
  p25 = (((int)(r56)) != ((int)(r55)));
  // PTX:520 @%p25 bra $L__BB57_37
  if (p25) { goto L_BB57_37; }
  // PTX:522 add.s64 %rd278, %rd275, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd278) : "l"(rd275));
  // PTX:523 red.global.add.f32 [%rd278], %f23
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd278) + (0)))), (float)(f23));
  // PTX:524 add.s64 %rd279, %rd275, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd279) : "l"(rd275));
  // PTX:525 red.global.add.f32 [%rd279], %f24
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd279) + (0)))), (float)(f24));
  // PTX:526 add.s64 %rd280, %rd275, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd280) : "l"(rd275));
  // PTX:527 red.global.add.f32 [%rd280], %f25
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd280) + (0)))), (float)(f25));
  // PTX:528 add.s64 %rd281, %rd275, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd281) : "l"(rd275));
  // PTX:529 red.global.add.f32 [%rd281], %f26
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd281) + (0)))), (float)(f26));
  // PTX:530 add.s64 %rd282, %rd275, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd282) : "l"(rd275));
  // PTX:531 red.global.add.f32 [%rd282], %f27
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd282) + (0)))), (float)(f27));
  // PTX:532 add.s64 %rd283, %rd275, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd283) : "l"(rd275));
  // PTX:533 red.global.add.f32 [%rd283], %f28
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd283) + (0)))), (float)(f28));
  // PTX:534 add.s64 %rd284, %rd275, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd284) : "l"(rd275));
  // PTX:535 red.global.add.f32 [%rd284], %f29
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd284) + (0)))), (float)(f29));
  // PTX:536 add.s64 %rd285, %rd275, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd285) : "l"(rd275));
  // PTX:537 red.global.add.f32 [%rd285], %f30
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd285) + (0)))), (float)(f30));
  // PTX:538 add.s64 %rd286, %rd275, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd286) : "l"(rd275));
  // PTX:539 red.global.add.f32 [%rd286], %f31
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd286) + (0)))), (float)(f31));
  // PTX:541 $L__BB57_37:
L_BB57_37:;
  // PTX:542 cvt.u32.u64 %r58, %rd39
  asm("cvt.u32.u64 %0, %1;" : "=r"(r58) : "l"(rd39));
  // PTX:543 setp.eq.s32 %p26, %r42, %r58
  p26 = (((int)(r42)) == ((int)(r58)));
  // PTX:544 @%p26 bra $L__BB57_44
  if (p26) { goto L_BB57_44; }
  // PTX:545 bra.uni $L__BB57_38
  goto L_BB57_38;
  // PTX:547 $L__BB57_44:
L_BB57_44:;
  // PTX:548 mul.lo.s64 %rd322, %rd39, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd322) : "l"(rd39));
  // PTX:549 add.s64 %rd323, %rd2, %rd322
  asm("add.s64 %0, %1, %2;" : "=l"(rd323) : "l"(rd2), "l"(rd322));
  // PTX:550 red.global.add.f32 [%rd323], %f23
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd323) + (0)))), (float)(f23));
  // PTX:551 add.s64 %rd324, %rd323, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd324) : "l"(rd323));
  // PTX:552 red.global.add.f32 [%rd324], %f24
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd324) + (0)))), (float)(f24));
  // PTX:553 add.s64 %rd325, %rd323, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd325) : "l"(rd323));
  // PTX:554 red.global.add.f32 [%rd325], %f25
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd325) + (0)))), (float)(f25));
  // PTX:555 add.s64 %rd326, %rd323, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd326) : "l"(rd323));
  // PTX:556 red.global.add.f32 [%rd326], %f26
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd326) + (0)))), (float)(f26));
  // PTX:557 add.s64 %rd327, %rd323, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd327) : "l"(rd323));
  // PTX:558 red.global.add.f32 [%rd327], %f27
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd327) + (0)))), (float)(f27));
  // PTX:559 add.s64 %rd328, %rd323, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd328) : "l"(rd323));
  // PTX:560 red.global.add.f32 [%rd328], %f28
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd328) + (0)))), (float)(f28));
  // PTX:561 add.s64 %rd329, %rd323, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd329) : "l"(rd323));
  // PTX:562 red.global.add.f32 [%rd329], %f29
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd329) + (0)))), (float)(f29));
  // PTX:563 add.s64 %rd330, %rd323, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd330) : "l"(rd323));
  // PTX:564 red.global.add.f32 [%rd330], %f30
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd330) + (0)))), (float)(f30));
  // PTX:565 add.s64 %rd331, %rd323, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd331) : "l"(rd323));
  // PTX:566 red.global.add.f32 [%rd331], %f31
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd331) + (0)))), (float)(f31));
  // PTX:567 bra.uni $L__BB57_45
  goto L_BB57_45;
  // PTX:569 $L__BB57_38:
L_BB57_38:;
  // PTX:570 shl.b64 %rd296, %rd39, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd296) : "l"(rd39));
  // PTX:571 add.s64 %rd297, %rd3, %rd296
  asm("add.s64 %0, %1, %2;" : "=l"(rd297) : "l"(rd3), "l"(rd296));
  // PTX:572 ld.global.s32 %rd298, [%rd297]
  rd298 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd297) + (0)))));
  // PTX:573 mov.u64 %rd699, 0
  asm("mov.u64 %0, 0;" : "=l"(rd699) : );
  // PTX:574 min.u64 %rd47, %rd298, %rd136
  asm("min.u64 %0, %1, %2;" : "=l"(rd47) : "l"(rd298), "l"(rd136));
  // PTX:575 setp.eq.s64 %p27, %rd47, 0
  p27 = (((long long)(rd47)) == ((long long)(0)));
  // PTX:576 @%p27 bra $L__BB57_41
  if (p27) { goto L_BB57_41; }
  // PTX:578 mov.u64 %rd699, 0
  asm("mov.u64 %0, 0;" : "=l"(rd699) : );
  // PTX:579 mov.u64 %rd697, %rd47
  asm("mov.u64 %0, %1;" : "=l"(rd697) : "l"(rd47));
  // PTX:581 $L__BB57_40:
L_BB57_40:;
  // PTX:582 sub.s64 %rd300, %rd697, %rd699
  asm("sub.s64 %0, %1, %2;" : "=l"(rd300) : "l"(rd697), "l"(rd699));
  // PTX:583 shr.u64 %rd301, %rd300, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd301) : "l"(rd300));
  // PTX:584 add.s64 %rd302, %rd301, %rd699
  asm("add.s64 %0, %1, %2;" : "=l"(rd302) : "l"(rd301), "l"(rd699));
  // PTX:585 mul.lo.s64 %rd303, %rd302, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd303) : "l"(rd302), "l"(rd140));
  // PTX:586 add.s64 %rd304, %rd303, %rd39
  asm("add.s64 %0, %1, %2;" : "=l"(rd304) : "l"(rd303), "l"(rd39));
  // PTX:587 mul.lo.s64 %rd305, %rd304, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd305) : "l"(rd304));
  // PTX:588 add.s64 %rd306, %rd1, %rd305
  asm("add.s64 %0, %1, %2;" : "=l"(rd306) : "l"(rd1), "l"(rd305));
  // PTX:589 ld.global.u32 %r59, [%rd306]
  r59 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd306) + (0)))));
  // PTX:590 setp.lt.s32 %p28, %r59, %r42
  p28 = (((int)(r59)) < ((int)(r42)));
  // PTX:591 add.s64 %rd307, %rd302, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd307) : "l"(rd302));
  // PTX:592 selp.b64 %rd699, %rd307, %rd699, %p28
  rd699 = p28 ? rd307 : rd699;
  // PTX:593 selp.b64 %rd697, %rd697, %rd302, %p28
  rd697 = p28 ? rd697 : rd302;
  // PTX:594 setp.gt.u64 %p29, %rd697, %rd699
  p29 = (((unsigned long long)(rd697)) > ((unsigned long long)(rd699)));
  // PTX:595 @%p29 bra $L__BB57_40
  if (p29) { goto L_BB57_40; }
  // PTX:597 $L__BB57_41:
L_BB57_41:;
  // PTX:598 setp.ge.u64 %p30, %rd699, %rd47
  p30 = (((unsigned long long)(rd699)) >= ((unsigned long long)(rd47)));
  // PTX:599 @%p30 bra $L__BB57_45
  if (p30) { goto L_BB57_45; }
  // PTX:601 mul.lo.s64 %rd308, %rd699, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd308) : "l"(rd699), "l"(rd140));
  // PTX:602 add.s64 %rd53, %rd308, %rd39
  asm("add.s64 %0, %1, %2;" : "=l"(rd53) : "l"(rd308), "l"(rd39));
  // PTX:603 mul.lo.s64 %rd309, %rd53, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd309) : "l"(rd53));
  // PTX:604 add.s64 %rd310, %rd1, %rd309
  asm("add.s64 %0, %1, %2;" : "=l"(rd310) : "l"(rd1), "l"(rd309));
  // PTX:605 ld.global.u32 %r62, [%rd310]
  r62 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd310) + (0)))));
  // PTX:606 setp.ne.s32 %p31, %r62, %r42
  p31 = (((int)(r62)) != ((int)(r42)));
  // PTX:607 @%p31 bra $L__BB57_45
  if (p31) { goto L_BB57_45; }
  // PTX:609 add.s64 %rd313, %rd310, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd313) : "l"(rd310));
  // PTX:610 red.global.add.f32 [%rd313], %f23
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd313) + (0)))), (float)(f23));
  // PTX:611 add.s64 %rd314, %rd310, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd314) : "l"(rd310));
  // PTX:612 red.global.add.f32 [%rd314], %f24
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd314) + (0)))), (float)(f24));
  // PTX:613 add.s64 %rd315, %rd310, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd315) : "l"(rd310));
  // PTX:614 red.global.add.f32 [%rd315], %f25
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd315) + (0)))), (float)(f25));
  // PTX:615 add.s64 %rd316, %rd310, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd316) : "l"(rd310));
  // PTX:616 red.global.add.f32 [%rd316], %f26
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd316) + (0)))), (float)(f26));
  // PTX:617 add.s64 %rd317, %rd310, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd317) : "l"(rd310));
  // PTX:618 red.global.add.f32 [%rd317], %f27
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd317) + (0)))), (float)(f27));
  // PTX:619 add.s64 %rd318, %rd310, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd318) : "l"(rd310));
  // PTX:620 red.global.add.f32 [%rd318], %f28
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd318) + (0)))), (float)(f28));
  // PTX:621 add.s64 %rd319, %rd310, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd319) : "l"(rd310));
  // PTX:622 red.global.add.f32 [%rd319], %f29
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd319) + (0)))), (float)(f29));
  // PTX:623 add.s64 %rd320, %rd310, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd320) : "l"(rd310));
  // PTX:624 red.global.add.f32 [%rd320], %f30
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd320) + (0)))), (float)(f30));
  // PTX:625 add.s64 %rd321, %rd310, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd321) : "l"(rd310));
  // PTX:626 red.global.add.f32 [%rd321], %f31
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd321) + (0)))), (float)(f31));
  // PTX:628 $L__BB57_45:
L_BB57_45:;
  // PTX:629 add.s32 %r63, %r132, 3
  asm("add.s32 %0, %1, 3;" : "=r"(r63) : "r"(r132));
  // PTX:630 setp.ge.u32 %p32, %r63, %r130
  p32 = (((unsigned)(r63)) >= ((unsigned)(r130)));
  // PTX:631 @%p32 bra $L__BB57_130
  if (p32) { goto L_BB57_130; }
  // PTX:633 ld.local.f32 %f225, [%rd22+8]
  f225 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd22) + (8)))));
  // PTX:634 mul.f32 %f226, %f12, %f225
  asm("mul.f32 %0, %1, %2;" : "=f"(f226) : "f"(f12), "f"(f225));
  // PTX:635 ld.global.f32 %f227, [%rd17]
  f227 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:636 mul.f32 %f32, %f227, %f226
  asm("mul.f32 %0, %1, %2;" : "=f"(f32) : "f"(f227), "f"(f226));
  // PTX:637 ld.global.f32 %f228, [%rd17+4]
  f228 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (4)))));
  // PTX:638 mul.f32 %f33, %f226, %f228
  asm("mul.f32 %0, %1, %2;" : "=f"(f33) : "f"(f226), "f"(f228));
  // PTX:639 ld.global.f32 %f229, [%rd17+8]
  f229 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (8)))));
  // PTX:640 mul.f32 %f34, %f226, %f229
  asm("mul.f32 %0, %1, %2;" : "=f"(f34) : "f"(f226), "f"(f229));
  // PTX:641 ld.global.f32 %f230, [%rd17+12]
  f230 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (12)))));
  // PTX:642 mul.f32 %f35, %f226, %f230
  asm("mul.f32 %0, %1, %2;" : "=f"(f35) : "f"(f226), "f"(f230));
  // PTX:643 ld.global.f32 %f231, [%rd17+16]
  f231 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (16)))));
  // PTX:644 mul.f32 %f36, %f226, %f231
  asm("mul.f32 %0, %1, %2;" : "=f"(f36) : "f"(f226), "f"(f231));
  // PTX:645 ld.global.f32 %f232, [%rd17+20]
  f232 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (20)))));
  // PTX:646 mul.f32 %f37, %f226, %f232
  asm("mul.f32 %0, %1, %2;" : "=f"(f37) : "f"(f226), "f"(f232));
  // PTX:647 ld.global.f32 %f233, [%rd17+24]
  f233 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (24)))));
  // PTX:648 mul.f32 %f38, %f226, %f233
  asm("mul.f32 %0, %1, %2;" : "=f"(f38) : "f"(f226), "f"(f233));
  // PTX:649 ld.global.f32 %f234, [%rd17+28]
  f234 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (28)))));
  // PTX:650 mul.f32 %f39, %f226, %f234
  asm("mul.f32 %0, %1, %2;" : "=f"(f39) : "f"(f226), "f"(f234));
  // PTX:651 ld.global.f32 %f235, [%rd17+32]
  f235 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (32)))));
  // PTX:652 mul.f32 %f40, %f226, %f235
  asm("mul.f32 %0, %1, %2;" : "=f"(f40) : "f"(f226), "f"(f235));
  // PTX:653 ld.local.u32 %r65, [%rd23+8]
  r65 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd23) + (8)))));
  // PTX:654 cvt.s64.s32 %rd54, %r65
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd54) : "r"(r65));
  // PTX:655 setp.eq.s32 %p33, %r42, %r65
  p33 = (((int)(r42)) == ((int)(r65)));
  // PTX:656 @%p33 bra $L__BB57_53
  if (p33) { goto L_BB57_53; }
  // PTX:657 bra.uni $L__BB57_47
  goto L_BB57_47;
  // PTX:659 $L__BB57_53:
L_BB57_53:;
  // PTX:660 red.global.add.f32 [%rd20], %f32
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))), (float)(f32));
  // PTX:661 red.global.add.f32 [%rd180], %f33
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (0)))), (float)(f33));
  // PTX:662 red.global.add.f32 [%rd181], %f34
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd181) + (0)))), (float)(f34));
  // PTX:663 red.global.add.f32 [%rd182], %f35
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd182) + (0)))), (float)(f35));
  // PTX:664 red.global.add.f32 [%rd183], %f36
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd183) + (0)))), (float)(f36));
  // PTX:665 red.global.add.f32 [%rd184], %f37
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd184) + (0)))), (float)(f37));
  // PTX:666 red.global.add.f32 [%rd185], %f38
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (0)))), (float)(f38));
  // PTX:667 red.global.add.f32 [%rd186], %f39
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd186) + (0)))), (float)(f39));
  // PTX:668 red.global.add.f32 [%rd187], %f40
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd187) + (0)))), (float)(f40));
  // PTX:669 bra.uni $L__BB57_54
  goto L_BB57_54;
  // PTX:671 $L__BB57_47:
L_BB57_47:;
  // PTX:672 ld.global.s32 %rd333, [%rd21]
  rd333 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (0)))));
  // PTX:673 mov.u64 %rd702, 0
  asm("mov.u64 %0, 0;" : "=l"(rd702) : );
  // PTX:674 min.u64 %rd55, %rd333, %rd136
  asm("min.u64 %0, %1, %2;" : "=l"(rd55) : "l"(rd333), "l"(rd136));
  // PTX:675 setp.eq.s64 %p34, %rd55, 0
  p34 = (((long long)(rd55)) == ((long long)(0)));
  // PTX:676 @%p34 bra $L__BB57_50
  if (p34) { goto L_BB57_50; }
  // PTX:678 mov.u64 %rd702, 0
  asm("mov.u64 %0, 0;" : "=l"(rd702) : );
  // PTX:679 mov.u64 %rd700, %rd55
  asm("mov.u64 %0, %1;" : "=l"(rd700) : "l"(rd55));
  // PTX:681 $L__BB57_49:
L_BB57_49:;
  // PTX:682 sub.s64 %rd335, %rd700, %rd702
  asm("sub.s64 %0, %1, %2;" : "=l"(rd335) : "l"(rd700), "l"(rd702));
  // PTX:683 shr.u64 %rd336, %rd335, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd336) : "l"(rd335));
  // PTX:684 add.s64 %rd337, %rd336, %rd702
  asm("add.s64 %0, %1, %2;" : "=l"(rd337) : "l"(rd336), "l"(rd702));
  // PTX:685 mul.lo.s64 %rd338, %rd337, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd338) : "l"(rd337), "l"(rd140));
  // PTX:686 add.s64 %rd339, %rd338, %rd19
  asm("add.s64 %0, %1, %2;" : "=l"(rd339) : "l"(rd338), "l"(rd19));
  // PTX:687 mul.lo.s64 %rd340, %rd339, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd340) : "l"(rd339));
  // PTX:688 add.s64 %rd341, %rd1, %rd340
  asm("add.s64 %0, %1, %2;" : "=l"(rd341) : "l"(rd1), "l"(rd340));
  // PTX:689 ld.global.u32 %r66, [%rd341]
  r66 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd341) + (0)))));
  // PTX:690 cvt.u32.u64 %r67, %rd54
  asm("cvt.u32.u64 %0, %1;" : "=r"(r67) : "l"(rd54));
  // PTX:691 setp.lt.s32 %p35, %r66, %r67
  p35 = (((int)(r66)) < ((int)(r67)));
  // PTX:692 add.s64 %rd342, %rd337, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd342) : "l"(rd337));
  // PTX:693 selp.b64 %rd702, %rd342, %rd702, %p35
  rd702 = p35 ? rd342 : rd702;
  // PTX:694 selp.b64 %rd700, %rd700, %rd337, %p35
  rd700 = p35 ? rd700 : rd337;
  // PTX:695 setp.gt.u64 %p36, %rd700, %rd702
  p36 = (((unsigned long long)(rd700)) > ((unsigned long long)(rd702)));
  // PTX:696 @%p36 bra $L__BB57_49
  if (p36) { goto L_BB57_49; }
  // PTX:698 $L__BB57_50:
L_BB57_50:;
  // PTX:699 setp.ge.u64 %p37, %rd702, %rd55
  p37 = (((unsigned long long)(rd702)) >= ((unsigned long long)(rd55)));
  // PTX:700 @%p37 bra $L__BB57_54
  if (p37) { goto L_BB57_54; }
  // PTX:702 cvt.u32.u64 %r68, %rd54
  asm("cvt.u32.u64 %0, %1;" : "=r"(r68) : "l"(rd54));
  // PTX:703 mul.lo.s64 %rd343, %rd702, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd343) : "l"(rd702), "l"(rd140));
  // PTX:704 add.s64 %rd61, %rd343, %rd19
  asm("add.s64 %0, %1, %2;" : "=l"(rd61) : "l"(rd343), "l"(rd19));
  // PTX:705 mul.lo.s64 %rd344, %rd61, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd344) : "l"(rd61));
  // PTX:706 add.s64 %rd345, %rd1, %rd344
  asm("add.s64 %0, %1, %2;" : "=l"(rd345) : "l"(rd1), "l"(rd344));
  // PTX:707 ld.global.u32 %r69, [%rd345]
  r69 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd345) + (0)))));
  // PTX:708 setp.ne.s32 %p38, %r69, %r68
  p38 = (((int)(r69)) != ((int)(r68)));
  // PTX:709 @%p38 bra $L__BB57_54
  if (p38) { goto L_BB57_54; }
  // PTX:711 add.s64 %rd348, %rd345, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd348) : "l"(rd345));
  // PTX:712 red.global.add.f32 [%rd348], %f32
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd348) + (0)))), (float)(f32));
  // PTX:713 add.s64 %rd349, %rd345, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd349) : "l"(rd345));
  // PTX:714 red.global.add.f32 [%rd349], %f33
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd349) + (0)))), (float)(f33));
  // PTX:715 add.s64 %rd350, %rd345, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd350) : "l"(rd345));
  // PTX:716 red.global.add.f32 [%rd350], %f34
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd350) + (0)))), (float)(f34));
  // PTX:717 add.s64 %rd351, %rd345, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd351) : "l"(rd345));
  // PTX:718 red.global.add.f32 [%rd351], %f35
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd351) + (0)))), (float)(f35));
  // PTX:719 add.s64 %rd352, %rd345, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd352) : "l"(rd345));
  // PTX:720 red.global.add.f32 [%rd352], %f36
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd352) + (0)))), (float)(f36));
  // PTX:721 add.s64 %rd353, %rd345, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd353) : "l"(rd345));
  // PTX:722 red.global.add.f32 [%rd353], %f37
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd353) + (0)))), (float)(f37));
  // PTX:723 add.s64 %rd354, %rd345, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd354) : "l"(rd345));
  // PTX:724 red.global.add.f32 [%rd354], %f38
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd354) + (0)))), (float)(f38));
  // PTX:725 add.s64 %rd355, %rd345, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd355) : "l"(rd345));
  // PTX:726 red.global.add.f32 [%rd355], %f39
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd355) + (0)))), (float)(f39));
  // PTX:727 add.s64 %rd356, %rd345, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd356) : "l"(rd345));
  // PTX:728 red.global.add.f32 [%rd356], %f40
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd356) + (0)))), (float)(f40));
  // PTX:730 $L__BB57_54:
L_BB57_54:;
  // PTX:731 cvt.u32.u64 %r71, %rd54
  asm("cvt.u32.u64 %0, %1;" : "=r"(r71) : "l"(rd54));
  // PTX:732 setp.eq.s32 %p39, %r42, %r71
  p39 = (((int)(r42)) == ((int)(r71)));
  // PTX:733 @%p39 bra $L__BB57_61
  if (p39) { goto L_BB57_61; }
  // PTX:734 bra.uni $L__BB57_55
  goto L_BB57_55;
  // PTX:736 $L__BB57_61:
L_BB57_61:;
  // PTX:737 mul.lo.s64 %rd392, %rd54, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd392) : "l"(rd54));
  // PTX:738 add.s64 %rd393, %rd2, %rd392
  asm("add.s64 %0, %1, %2;" : "=l"(rd393) : "l"(rd2), "l"(rd392));
  // PTX:739 red.global.add.f32 [%rd393], %f32
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd393) + (0)))), (float)(f32));
  // PTX:740 add.s64 %rd394, %rd393, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd394) : "l"(rd393));
  // PTX:741 red.global.add.f32 [%rd394], %f33
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd394) + (0)))), (float)(f33));
  // PTX:742 add.s64 %rd395, %rd393, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd395) : "l"(rd393));
  // PTX:743 red.global.add.f32 [%rd395], %f34
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd395) + (0)))), (float)(f34));
  // PTX:744 add.s64 %rd396, %rd393, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd396) : "l"(rd393));
  // PTX:745 red.global.add.f32 [%rd396], %f35
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd396) + (0)))), (float)(f35));
  // PTX:746 add.s64 %rd397, %rd393, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd397) : "l"(rd393));
  // PTX:747 red.global.add.f32 [%rd397], %f36
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd397) + (0)))), (float)(f36));
  // PTX:748 add.s64 %rd398, %rd393, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd398) : "l"(rd393));
  // PTX:749 red.global.add.f32 [%rd398], %f37
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd398) + (0)))), (float)(f37));
  // PTX:750 add.s64 %rd399, %rd393, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd399) : "l"(rd393));
  // PTX:751 red.global.add.f32 [%rd399], %f38
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd399) + (0)))), (float)(f38));
  // PTX:752 add.s64 %rd400, %rd393, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd400) : "l"(rd393));
  // PTX:753 red.global.add.f32 [%rd400], %f39
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd400) + (0)))), (float)(f39));
  // PTX:754 add.s64 %rd401, %rd393, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd401) : "l"(rd393));
  // PTX:755 red.global.add.f32 [%rd401], %f40
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd401) + (0)))), (float)(f40));
  // PTX:756 bra.uni $L__BB57_62
  goto L_BB57_62;
  // PTX:758 $L__BB57_55:
L_BB57_55:;
  // PTX:759 shl.b64 %rd366, %rd54, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd366) : "l"(rd54));
  // PTX:760 add.s64 %rd367, %rd3, %rd366
  asm("add.s64 %0, %1, %2;" : "=l"(rd367) : "l"(rd3), "l"(rd366));
  // PTX:761 ld.global.s32 %rd368, [%rd367]
  rd368 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd367) + (0)))));
  // PTX:762 mov.u64 %rd705, 0
  asm("mov.u64 %0, 0;" : "=l"(rd705) : );
  // PTX:763 min.u64 %rd62, %rd368, %rd136
  asm("min.u64 %0, %1, %2;" : "=l"(rd62) : "l"(rd368), "l"(rd136));
  // PTX:764 setp.eq.s64 %p40, %rd62, 0
  p40 = (((long long)(rd62)) == ((long long)(0)));
  // PTX:765 @%p40 bra $L__BB57_58
  if (p40) { goto L_BB57_58; }
  // PTX:767 mov.u64 %rd705, 0
  asm("mov.u64 %0, 0;" : "=l"(rd705) : );
  // PTX:768 mov.u64 %rd703, %rd62
  asm("mov.u64 %0, %1;" : "=l"(rd703) : "l"(rd62));
  // PTX:770 $L__BB57_57:
L_BB57_57:;
  // PTX:771 sub.s64 %rd370, %rd703, %rd705
  asm("sub.s64 %0, %1, %2;" : "=l"(rd370) : "l"(rd703), "l"(rd705));
  // PTX:772 shr.u64 %rd371, %rd370, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd371) : "l"(rd370));
  // PTX:773 add.s64 %rd372, %rd371, %rd705
  asm("add.s64 %0, %1, %2;" : "=l"(rd372) : "l"(rd371), "l"(rd705));
  // PTX:774 mul.lo.s64 %rd373, %rd372, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd373) : "l"(rd372), "l"(rd140));
  // PTX:775 add.s64 %rd374, %rd373, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd374) : "l"(rd373), "l"(rd54));
  // PTX:776 mul.lo.s64 %rd375, %rd374, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd375) : "l"(rd374));
  // PTX:777 add.s64 %rd376, %rd1, %rd375
  asm("add.s64 %0, %1, %2;" : "=l"(rd376) : "l"(rd1), "l"(rd375));
  // PTX:778 ld.global.u32 %r72, [%rd376]
  r72 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd376) + (0)))));
  // PTX:779 setp.lt.s32 %p41, %r72, %r42
  p41 = (((int)(r72)) < ((int)(r42)));
  // PTX:780 add.s64 %rd377, %rd372, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd377) : "l"(rd372));
  // PTX:781 selp.b64 %rd705, %rd377, %rd705, %p41
  rd705 = p41 ? rd377 : rd705;
  // PTX:782 selp.b64 %rd703, %rd703, %rd372, %p41
  rd703 = p41 ? rd703 : rd372;
  // PTX:783 setp.gt.u64 %p42, %rd703, %rd705
  p42 = (((unsigned long long)(rd703)) > ((unsigned long long)(rd705)));
  // PTX:784 @%p42 bra $L__BB57_57
  if (p42) { goto L_BB57_57; }
  // PTX:786 $L__BB57_58:
L_BB57_58:;
  // PTX:787 setp.ge.u64 %p43, %rd705, %rd62
  p43 = (((unsigned long long)(rd705)) >= ((unsigned long long)(rd62)));
  // PTX:788 @%p43 bra $L__BB57_62
  if (p43) { goto L_BB57_62; }
  // PTX:790 mul.lo.s64 %rd378, %rd705, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd378) : "l"(rd705), "l"(rd140));
  // PTX:791 add.s64 %rd68, %rd378, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd68) : "l"(rd378), "l"(rd54));
  // PTX:792 mul.lo.s64 %rd379, %rd68, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd379) : "l"(rd68));
  // PTX:793 add.s64 %rd380, %rd1, %rd379
  asm("add.s64 %0, %1, %2;" : "=l"(rd380) : "l"(rd1), "l"(rd379));
  // PTX:794 ld.global.u32 %r75, [%rd380]
  r75 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd380) + (0)))));
  // PTX:795 setp.ne.s32 %p44, %r75, %r42
  p44 = (((int)(r75)) != ((int)(r42)));
  // PTX:796 @%p44 bra $L__BB57_62
  if (p44) { goto L_BB57_62; }
  // PTX:798 add.s64 %rd383, %rd380, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd383) : "l"(rd380));
  // PTX:799 red.global.add.f32 [%rd383], %f32
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd383) + (0)))), (float)(f32));
  // PTX:800 add.s64 %rd384, %rd380, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd384) : "l"(rd380));
  // PTX:801 red.global.add.f32 [%rd384], %f33
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd384) + (0)))), (float)(f33));
  // PTX:802 add.s64 %rd385, %rd380, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd385) : "l"(rd380));
  // PTX:803 red.global.add.f32 [%rd385], %f34
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd385) + (0)))), (float)(f34));
  // PTX:804 add.s64 %rd386, %rd380, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd386) : "l"(rd380));
  // PTX:805 red.global.add.f32 [%rd386], %f35
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd386) + (0)))), (float)(f35));
  // PTX:806 add.s64 %rd387, %rd380, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd387) : "l"(rd380));
  // PTX:807 red.global.add.f32 [%rd387], %f36
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd387) + (0)))), (float)(f36));
  // PTX:808 add.s64 %rd388, %rd380, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd388) : "l"(rd380));
  // PTX:809 red.global.add.f32 [%rd388], %f37
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd388) + (0)))), (float)(f37));
  // PTX:810 add.s64 %rd389, %rd380, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd389) : "l"(rd380));
  // PTX:811 red.global.add.f32 [%rd389], %f38
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd389) + (0)))), (float)(f38));
  // PTX:812 add.s64 %rd390, %rd380, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd390) : "l"(rd380));
  // PTX:813 red.global.add.f32 [%rd390], %f39
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd390) + (0)))), (float)(f39));
  // PTX:814 add.s64 %rd391, %rd380, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd391) : "l"(rd380));
  // PTX:815 red.global.add.f32 [%rd391], %f40
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd391) + (0)))), (float)(f40));
  // PTX:817 $L__BB57_62:
L_BB57_62:;
  // PTX:818 add.s32 %r76, %r132, 4
  asm("add.s32 %0, %1, 4;" : "=r"(r76) : "r"(r132));
  // PTX:819 setp.ge.u32 %p45, %r76, %r130
  p45 = (((unsigned)(r76)) >= ((unsigned)(r130)));
  // PTX:820 @%p45 bra $L__BB57_130
  if (p45) { goto L_BB57_130; }
  // PTX:822 ld.local.f32 %f272, [%rd22+12]
  f272 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd22) + (12)))));
  // PTX:823 mul.f32 %f273, %f12, %f272
  asm("mul.f32 %0, %1, %2;" : "=f"(f273) : "f"(f12), "f"(f272));
  // PTX:824 ld.global.f32 %f274, [%rd17]
  f274 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:825 mul.f32 %f41, %f274, %f273
  asm("mul.f32 %0, %1, %2;" : "=f"(f41) : "f"(f274), "f"(f273));
  // PTX:826 ld.global.f32 %f275, [%rd17+4]
  f275 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (4)))));
  // PTX:827 mul.f32 %f42, %f273, %f275
  asm("mul.f32 %0, %1, %2;" : "=f"(f42) : "f"(f273), "f"(f275));
  // PTX:828 ld.global.f32 %f276, [%rd17+8]
  f276 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (8)))));
  // PTX:829 mul.f32 %f43, %f273, %f276
  asm("mul.f32 %0, %1, %2;" : "=f"(f43) : "f"(f273), "f"(f276));
  // PTX:830 ld.global.f32 %f277, [%rd17+12]
  f277 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (12)))));
  // PTX:831 mul.f32 %f44, %f273, %f277
  asm("mul.f32 %0, %1, %2;" : "=f"(f44) : "f"(f273), "f"(f277));
  // PTX:832 ld.global.f32 %f278, [%rd17+16]
  f278 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (16)))));
  // PTX:833 mul.f32 %f45, %f273, %f278
  asm("mul.f32 %0, %1, %2;" : "=f"(f45) : "f"(f273), "f"(f278));
  // PTX:834 ld.global.f32 %f279, [%rd17+20]
  f279 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (20)))));
  // PTX:835 mul.f32 %f46, %f273, %f279
  asm("mul.f32 %0, %1, %2;" : "=f"(f46) : "f"(f273), "f"(f279));
  // PTX:836 ld.global.f32 %f280, [%rd17+24]
  f280 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (24)))));
  // PTX:837 mul.f32 %f47, %f273, %f280
  asm("mul.f32 %0, %1, %2;" : "=f"(f47) : "f"(f273), "f"(f280));
  // PTX:838 ld.global.f32 %f281, [%rd17+28]
  f281 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (28)))));
  // PTX:839 mul.f32 %f48, %f273, %f281
  asm("mul.f32 %0, %1, %2;" : "=f"(f48) : "f"(f273), "f"(f281));
  // PTX:840 ld.global.f32 %f282, [%rd17+32]
  f282 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (32)))));
  // PTX:841 mul.f32 %f49, %f273, %f282
  asm("mul.f32 %0, %1, %2;" : "=f"(f49) : "f"(f273), "f"(f282));
  // PTX:842 ld.local.u32 %r78, [%rd23+12]
  r78 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd23) + (12)))));
  // PTX:843 cvt.s64.s32 %rd69, %r78
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd69) : "r"(r78));
  // PTX:844 setp.eq.s32 %p46, %r42, %r78
  p46 = (((int)(r42)) == ((int)(r78)));
  // PTX:845 @%p46 bra $L__BB57_70
  if (p46) { goto L_BB57_70; }
  // PTX:846 bra.uni $L__BB57_64
  goto L_BB57_64;
  // PTX:848 $L__BB57_70:
L_BB57_70:;
  // PTX:849 red.global.add.f32 [%rd20], %f41
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))), (float)(f41));
  // PTX:850 red.global.add.f32 [%rd180], %f42
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (0)))), (float)(f42));
  // PTX:851 red.global.add.f32 [%rd181], %f43
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd181) + (0)))), (float)(f43));
  // PTX:852 red.global.add.f32 [%rd182], %f44
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd182) + (0)))), (float)(f44));
  // PTX:853 red.global.add.f32 [%rd183], %f45
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd183) + (0)))), (float)(f45));
  // PTX:854 red.global.add.f32 [%rd184], %f46
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd184) + (0)))), (float)(f46));
  // PTX:855 red.global.add.f32 [%rd185], %f47
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (0)))), (float)(f47));
  // PTX:856 red.global.add.f32 [%rd186], %f48
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd186) + (0)))), (float)(f48));
  // PTX:857 red.global.add.f32 [%rd187], %f49
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd187) + (0)))), (float)(f49));
  // PTX:858 bra.uni $L__BB57_71
  goto L_BB57_71;
  // PTX:860 $L__BB57_64:
L_BB57_64:;
  // PTX:861 ld.global.s32 %rd403, [%rd21]
  rd403 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (0)))));
  // PTX:862 mov.u64 %rd708, 0
  asm("mov.u64 %0, 0;" : "=l"(rd708) : );
  // PTX:863 min.u64 %rd70, %rd403, %rd136
  asm("min.u64 %0, %1, %2;" : "=l"(rd70) : "l"(rd403), "l"(rd136));
  // PTX:864 setp.eq.s64 %p47, %rd70, 0
  p47 = (((long long)(rd70)) == ((long long)(0)));
  // PTX:865 @%p47 bra $L__BB57_67
  if (p47) { goto L_BB57_67; }
  // PTX:867 mov.u64 %rd708, 0
  asm("mov.u64 %0, 0;" : "=l"(rd708) : );
  // PTX:868 mov.u64 %rd706, %rd70
  asm("mov.u64 %0, %1;" : "=l"(rd706) : "l"(rd70));
  // PTX:870 $L__BB57_66:
L_BB57_66:;
  // PTX:871 sub.s64 %rd405, %rd706, %rd708
  asm("sub.s64 %0, %1, %2;" : "=l"(rd405) : "l"(rd706), "l"(rd708));
  // PTX:872 shr.u64 %rd406, %rd405, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd406) : "l"(rd405));
  // PTX:873 add.s64 %rd407, %rd406, %rd708
  asm("add.s64 %0, %1, %2;" : "=l"(rd407) : "l"(rd406), "l"(rd708));
  // PTX:874 mul.lo.s64 %rd408, %rd407, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd408) : "l"(rd407), "l"(rd140));
  // PTX:875 add.s64 %rd409, %rd408, %rd19
  asm("add.s64 %0, %1, %2;" : "=l"(rd409) : "l"(rd408), "l"(rd19));
  // PTX:876 mul.lo.s64 %rd410, %rd409, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd410) : "l"(rd409));
  // PTX:877 add.s64 %rd411, %rd1, %rd410
  asm("add.s64 %0, %1, %2;" : "=l"(rd411) : "l"(rd1), "l"(rd410));
  // PTX:878 ld.global.u32 %r79, [%rd411]
  r79 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd411) + (0)))));
  // PTX:879 cvt.u32.u64 %r80, %rd69
  asm("cvt.u32.u64 %0, %1;" : "=r"(r80) : "l"(rd69));
  // PTX:880 setp.lt.s32 %p48, %r79, %r80
  p48 = (((int)(r79)) < ((int)(r80)));
  // PTX:881 add.s64 %rd412, %rd407, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd412) : "l"(rd407));
  // PTX:882 selp.b64 %rd708, %rd412, %rd708, %p48
  rd708 = p48 ? rd412 : rd708;
  // PTX:883 selp.b64 %rd706, %rd706, %rd407, %p48
  rd706 = p48 ? rd706 : rd407;
  // PTX:884 setp.gt.u64 %p49, %rd706, %rd708
  p49 = (((unsigned long long)(rd706)) > ((unsigned long long)(rd708)));
  // PTX:885 @%p49 bra $L__BB57_66
  if (p49) { goto L_BB57_66; }
  // PTX:887 $L__BB57_67:
L_BB57_67:;
  // PTX:888 setp.ge.u64 %p50, %rd708, %rd70
  p50 = (((unsigned long long)(rd708)) >= ((unsigned long long)(rd70)));
  // PTX:889 @%p50 bra $L__BB57_71
  if (p50) { goto L_BB57_71; }
  // PTX:891 cvt.u32.u64 %r81, %rd69
  asm("cvt.u32.u64 %0, %1;" : "=r"(r81) : "l"(rd69));
  // PTX:892 mul.lo.s64 %rd413, %rd708, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd413) : "l"(rd708), "l"(rd140));
  // PTX:893 add.s64 %rd76, %rd413, %rd19
  asm("add.s64 %0, %1, %2;" : "=l"(rd76) : "l"(rd413), "l"(rd19));
  // PTX:894 mul.lo.s64 %rd414, %rd76, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd414) : "l"(rd76));
  // PTX:895 add.s64 %rd415, %rd1, %rd414
  asm("add.s64 %0, %1, %2;" : "=l"(rd415) : "l"(rd1), "l"(rd414));
  // PTX:896 ld.global.u32 %r82, [%rd415]
  r82 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd415) + (0)))));
  // PTX:897 setp.ne.s32 %p51, %r82, %r81
  p51 = (((int)(r82)) != ((int)(r81)));
  // PTX:898 @%p51 bra $L__BB57_71
  if (p51) { goto L_BB57_71; }
  // PTX:900 add.s64 %rd418, %rd415, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd418) : "l"(rd415));
  // PTX:901 red.global.add.f32 [%rd418], %f41
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd418) + (0)))), (float)(f41));
  // PTX:902 add.s64 %rd419, %rd415, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd419) : "l"(rd415));
  // PTX:903 red.global.add.f32 [%rd419], %f42
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd419) + (0)))), (float)(f42));
  // PTX:904 add.s64 %rd420, %rd415, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd420) : "l"(rd415));
  // PTX:905 red.global.add.f32 [%rd420], %f43
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd420) + (0)))), (float)(f43));
  // PTX:906 add.s64 %rd421, %rd415, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd421) : "l"(rd415));
  // PTX:907 red.global.add.f32 [%rd421], %f44
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd421) + (0)))), (float)(f44));
  // PTX:908 add.s64 %rd422, %rd415, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd422) : "l"(rd415));
  // PTX:909 red.global.add.f32 [%rd422], %f45
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd422) + (0)))), (float)(f45));
  // PTX:910 add.s64 %rd423, %rd415, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd423) : "l"(rd415));
  // PTX:911 red.global.add.f32 [%rd423], %f46
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd423) + (0)))), (float)(f46));
  // PTX:912 add.s64 %rd424, %rd415, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd424) : "l"(rd415));
  // PTX:913 red.global.add.f32 [%rd424], %f47
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd424) + (0)))), (float)(f47));
  // PTX:914 add.s64 %rd425, %rd415, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd425) : "l"(rd415));
  // PTX:915 red.global.add.f32 [%rd425], %f48
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd425) + (0)))), (float)(f48));
  // PTX:916 add.s64 %rd426, %rd415, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd426) : "l"(rd415));
  // PTX:917 red.global.add.f32 [%rd426], %f49
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd426) + (0)))), (float)(f49));
  // PTX:919 $L__BB57_71:
L_BB57_71:;
  // PTX:920 cvt.u32.u64 %r84, %rd69
  asm("cvt.u32.u64 %0, %1;" : "=r"(r84) : "l"(rd69));
  // PTX:921 setp.eq.s32 %p52, %r42, %r84
  p52 = (((int)(r42)) == ((int)(r84)));
  // PTX:922 @%p52 bra $L__BB57_78
  if (p52) { goto L_BB57_78; }
  // PTX:923 bra.uni $L__BB57_72
  goto L_BB57_72;
  // PTX:925 $L__BB57_78:
L_BB57_78:;
  // PTX:926 mul.lo.s64 %rd462, %rd69, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd462) : "l"(rd69));
  // PTX:927 add.s64 %rd463, %rd2, %rd462
  asm("add.s64 %0, %1, %2;" : "=l"(rd463) : "l"(rd2), "l"(rd462));
  // PTX:928 red.global.add.f32 [%rd463], %f41
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd463) + (0)))), (float)(f41));
  // PTX:929 add.s64 %rd464, %rd463, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd464) : "l"(rd463));
  // PTX:930 red.global.add.f32 [%rd464], %f42
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd464) + (0)))), (float)(f42));
  // PTX:931 add.s64 %rd465, %rd463, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd465) : "l"(rd463));
  // PTX:932 red.global.add.f32 [%rd465], %f43
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd465) + (0)))), (float)(f43));
  // PTX:933 add.s64 %rd466, %rd463, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd466) : "l"(rd463));
  // PTX:934 red.global.add.f32 [%rd466], %f44
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd466) + (0)))), (float)(f44));
  // PTX:935 add.s64 %rd467, %rd463, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd467) : "l"(rd463));
  // PTX:936 red.global.add.f32 [%rd467], %f45
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd467) + (0)))), (float)(f45));
  // PTX:937 add.s64 %rd468, %rd463, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd468) : "l"(rd463));
  // PTX:938 red.global.add.f32 [%rd468], %f46
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd468) + (0)))), (float)(f46));
  // PTX:939 add.s64 %rd469, %rd463, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd469) : "l"(rd463));
  // PTX:940 red.global.add.f32 [%rd469], %f47
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd469) + (0)))), (float)(f47));
  // PTX:941 add.s64 %rd470, %rd463, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd470) : "l"(rd463));
  // PTX:942 red.global.add.f32 [%rd470], %f48
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd470) + (0)))), (float)(f48));
  // PTX:943 add.s64 %rd471, %rd463, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd471) : "l"(rd463));
  // PTX:944 red.global.add.f32 [%rd471], %f49
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd471) + (0)))), (float)(f49));
  // PTX:945 bra.uni $L__BB57_79
  goto L_BB57_79;
  // PTX:947 $L__BB57_72:
L_BB57_72:;
  // PTX:948 shl.b64 %rd436, %rd69, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd436) : "l"(rd69));
  // PTX:949 add.s64 %rd437, %rd3, %rd436
  asm("add.s64 %0, %1, %2;" : "=l"(rd437) : "l"(rd3), "l"(rd436));
  // PTX:950 ld.global.s32 %rd438, [%rd437]
  rd438 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd437) + (0)))));
  // PTX:951 mov.u64 %rd711, 0
  asm("mov.u64 %0, 0;" : "=l"(rd711) : );
  // PTX:952 min.u64 %rd77, %rd438, %rd136
  asm("min.u64 %0, %1, %2;" : "=l"(rd77) : "l"(rd438), "l"(rd136));
  // PTX:953 setp.eq.s64 %p53, %rd77, 0
  p53 = (((long long)(rd77)) == ((long long)(0)));
  // PTX:954 @%p53 bra $L__BB57_75
  if (p53) { goto L_BB57_75; }
  // PTX:956 mov.u64 %rd711, 0
  asm("mov.u64 %0, 0;" : "=l"(rd711) : );
  // PTX:957 mov.u64 %rd709, %rd77
  asm("mov.u64 %0, %1;" : "=l"(rd709) : "l"(rd77));
  // PTX:959 $L__BB57_74:
L_BB57_74:;
  // PTX:960 sub.s64 %rd440, %rd709, %rd711
  asm("sub.s64 %0, %1, %2;" : "=l"(rd440) : "l"(rd709), "l"(rd711));
  // PTX:961 shr.u64 %rd441, %rd440, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd441) : "l"(rd440));
  // PTX:962 add.s64 %rd442, %rd441, %rd711
  asm("add.s64 %0, %1, %2;" : "=l"(rd442) : "l"(rd441), "l"(rd711));
  // PTX:963 mul.lo.s64 %rd443, %rd442, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd443) : "l"(rd442), "l"(rd140));
  // PTX:964 add.s64 %rd444, %rd443, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd444) : "l"(rd443), "l"(rd69));
  // PTX:965 mul.lo.s64 %rd445, %rd444, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd445) : "l"(rd444));
  // PTX:966 add.s64 %rd446, %rd1, %rd445
  asm("add.s64 %0, %1, %2;" : "=l"(rd446) : "l"(rd1), "l"(rd445));
  // PTX:967 ld.global.u32 %r85, [%rd446]
  r85 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd446) + (0)))));
  // PTX:968 setp.lt.s32 %p54, %r85, %r42
  p54 = (((int)(r85)) < ((int)(r42)));
  // PTX:969 add.s64 %rd447, %rd442, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd447) : "l"(rd442));
  // PTX:970 selp.b64 %rd711, %rd447, %rd711, %p54
  rd711 = p54 ? rd447 : rd711;
  // PTX:971 selp.b64 %rd709, %rd709, %rd442, %p54
  rd709 = p54 ? rd709 : rd442;
  // PTX:972 setp.gt.u64 %p55, %rd709, %rd711
  p55 = (((unsigned long long)(rd709)) > ((unsigned long long)(rd711)));
  // PTX:973 @%p55 bra $L__BB57_74
  if (p55) { goto L_BB57_74; }
  // PTX:975 $L__BB57_75:
L_BB57_75:;
  // PTX:976 setp.ge.u64 %p56, %rd711, %rd77
  p56 = (((unsigned long long)(rd711)) >= ((unsigned long long)(rd77)));
  // PTX:977 @%p56 bra $L__BB57_79
  if (p56) { goto L_BB57_79; }
  // PTX:979 mul.lo.s64 %rd448, %rd711, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd448) : "l"(rd711), "l"(rd140));
  // PTX:980 add.s64 %rd83, %rd448, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd83) : "l"(rd448), "l"(rd69));
  // PTX:981 mul.lo.s64 %rd449, %rd83, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd449) : "l"(rd83));
  // PTX:982 add.s64 %rd450, %rd1, %rd449
  asm("add.s64 %0, %1, %2;" : "=l"(rd450) : "l"(rd1), "l"(rd449));
  // PTX:983 ld.global.u32 %r88, [%rd450]
  r88 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd450) + (0)))));
  // PTX:984 setp.ne.s32 %p57, %r88, %r42
  p57 = (((int)(r88)) != ((int)(r42)));
  // PTX:985 @%p57 bra $L__BB57_79
  if (p57) { goto L_BB57_79; }
  // PTX:987 add.s64 %rd453, %rd450, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd453) : "l"(rd450));
  // PTX:988 red.global.add.f32 [%rd453], %f41
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd453) + (0)))), (float)(f41));
  // PTX:989 add.s64 %rd454, %rd450, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd454) : "l"(rd450));
  // PTX:990 red.global.add.f32 [%rd454], %f42
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd454) + (0)))), (float)(f42));
  // PTX:991 add.s64 %rd455, %rd450, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd455) : "l"(rd450));
  // PTX:992 red.global.add.f32 [%rd455], %f43
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd455) + (0)))), (float)(f43));
  // PTX:993 add.s64 %rd456, %rd450, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd456) : "l"(rd450));
  // PTX:994 red.global.add.f32 [%rd456], %f44
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd456) + (0)))), (float)(f44));
  // PTX:995 add.s64 %rd457, %rd450, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd457) : "l"(rd450));
  // PTX:996 red.global.add.f32 [%rd457], %f45
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd457) + (0)))), (float)(f45));
  // PTX:997 add.s64 %rd458, %rd450, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd458) : "l"(rd450));
  // PTX:998 red.global.add.f32 [%rd458], %f46
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd458) + (0)))), (float)(f46));
  // PTX:999 add.s64 %rd459, %rd450, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd459) : "l"(rd450));
  // PTX:1000 red.global.add.f32 [%rd459], %f47
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd459) + (0)))), (float)(f47));
  // PTX:1001 add.s64 %rd460, %rd450, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd460) : "l"(rd450));
  // PTX:1002 red.global.add.f32 [%rd460], %f48
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd460) + (0)))), (float)(f48));
  // PTX:1003 add.s64 %rd461, %rd450, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd461) : "l"(rd450));
  // PTX:1004 red.global.add.f32 [%rd461], %f49
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd461) + (0)))), (float)(f49));
  // PTX:1006 $L__BB57_79:
L_BB57_79:;
  // PTX:1007 add.s32 %r89, %r132, 5
  asm("add.s32 %0, %1, 5;" : "=r"(r89) : "r"(r132));
  // PTX:1008 setp.ge.u32 %p58, %r89, %r130
  p58 = (((unsigned)(r89)) >= ((unsigned)(r130)));
  // PTX:1009 @%p58 bra $L__BB57_130
  if (p58) { goto L_BB57_130; }
  // PTX:1011 ld.local.f32 %f319, [%rd22+16]
  f319 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd22) + (16)))));
  // PTX:1012 mul.f32 %f320, %f12, %f319
  asm("mul.f32 %0, %1, %2;" : "=f"(f320) : "f"(f12), "f"(f319));
  // PTX:1013 ld.global.f32 %f321, [%rd17]
  f321 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:1014 mul.f32 %f50, %f321, %f320
  asm("mul.f32 %0, %1, %2;" : "=f"(f50) : "f"(f321), "f"(f320));
  // PTX:1015 ld.global.f32 %f322, [%rd17+4]
  f322 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (4)))));
  // PTX:1016 mul.f32 %f51, %f320, %f322
  asm("mul.f32 %0, %1, %2;" : "=f"(f51) : "f"(f320), "f"(f322));
  // PTX:1017 ld.global.f32 %f323, [%rd17+8]
  f323 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (8)))));
  // PTX:1018 mul.f32 %f52, %f320, %f323
  asm("mul.f32 %0, %1, %2;" : "=f"(f52) : "f"(f320), "f"(f323));
  // PTX:1019 ld.global.f32 %f324, [%rd17+12]
  f324 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (12)))));
  // PTX:1020 mul.f32 %f53, %f320, %f324
  asm("mul.f32 %0, %1, %2;" : "=f"(f53) : "f"(f320), "f"(f324));
  // PTX:1021 ld.global.f32 %f325, [%rd17+16]
  f325 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (16)))));
  // PTX:1022 mul.f32 %f54, %f320, %f325
  asm("mul.f32 %0, %1, %2;" : "=f"(f54) : "f"(f320), "f"(f325));
  // PTX:1023 ld.global.f32 %f326, [%rd17+20]
  f326 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (20)))));
  // PTX:1024 mul.f32 %f55, %f320, %f326
  asm("mul.f32 %0, %1, %2;" : "=f"(f55) : "f"(f320), "f"(f326));
  // PTX:1025 ld.global.f32 %f327, [%rd17+24]
  f327 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (24)))));
  // PTX:1026 mul.f32 %f56, %f320, %f327
  asm("mul.f32 %0, %1, %2;" : "=f"(f56) : "f"(f320), "f"(f327));
  // PTX:1027 ld.global.f32 %f328, [%rd17+28]
  f328 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (28)))));
  // PTX:1028 mul.f32 %f57, %f320, %f328
  asm("mul.f32 %0, %1, %2;" : "=f"(f57) : "f"(f320), "f"(f328));
  // PTX:1029 ld.global.f32 %f329, [%rd17+32]
  f329 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (32)))));
  // PTX:1030 mul.f32 %f58, %f320, %f329
  asm("mul.f32 %0, %1, %2;" : "=f"(f58) : "f"(f320), "f"(f329));
  // PTX:1031 ld.local.u32 %r91, [%rd23+16]
  r91 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd23) + (16)))));
  // PTX:1032 cvt.s64.s32 %rd84, %r91
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd84) : "r"(r91));
  // PTX:1033 setp.eq.s32 %p59, %r42, %r91
  p59 = (((int)(r42)) == ((int)(r91)));
  // PTX:1034 @%p59 bra $L__BB57_87
  if (p59) { goto L_BB57_87; }
  // PTX:1035 bra.uni $L__BB57_81
  goto L_BB57_81;
  // PTX:1037 $L__BB57_87:
L_BB57_87:;
  // PTX:1038 red.global.add.f32 [%rd20], %f50
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))), (float)(f50));
  // PTX:1039 red.global.add.f32 [%rd180], %f51
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (0)))), (float)(f51));
  // PTX:1040 red.global.add.f32 [%rd181], %f52
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd181) + (0)))), (float)(f52));
  // PTX:1041 red.global.add.f32 [%rd182], %f53
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd182) + (0)))), (float)(f53));
  // PTX:1042 red.global.add.f32 [%rd183], %f54
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd183) + (0)))), (float)(f54));
  // PTX:1043 red.global.add.f32 [%rd184], %f55
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd184) + (0)))), (float)(f55));
  // PTX:1044 red.global.add.f32 [%rd185], %f56
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (0)))), (float)(f56));
  // PTX:1045 red.global.add.f32 [%rd186], %f57
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd186) + (0)))), (float)(f57));
  // PTX:1046 red.global.add.f32 [%rd187], %f58
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd187) + (0)))), (float)(f58));
  // PTX:1047 bra.uni $L__BB57_88
  goto L_BB57_88;
  // PTX:1049 $L__BB57_81:
L_BB57_81:;
  // PTX:1050 ld.global.s32 %rd473, [%rd21]
  rd473 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (0)))));
  // PTX:1051 mov.u64 %rd714, 0
  asm("mov.u64 %0, 0;" : "=l"(rd714) : );
  // PTX:1052 min.u64 %rd85, %rd473, %rd136
  asm("min.u64 %0, %1, %2;" : "=l"(rd85) : "l"(rd473), "l"(rd136));
  // PTX:1053 setp.eq.s64 %p60, %rd85, 0
  p60 = (((long long)(rd85)) == ((long long)(0)));
  // PTX:1054 @%p60 bra $L__BB57_84
  if (p60) { goto L_BB57_84; }
  // PTX:1056 mov.u64 %rd714, 0
  asm("mov.u64 %0, 0;" : "=l"(rd714) : );
  // PTX:1057 mov.u64 %rd712, %rd85
  asm("mov.u64 %0, %1;" : "=l"(rd712) : "l"(rd85));
  // PTX:1059 $L__BB57_83:
L_BB57_83:;
  // PTX:1060 sub.s64 %rd475, %rd712, %rd714
  asm("sub.s64 %0, %1, %2;" : "=l"(rd475) : "l"(rd712), "l"(rd714));
  // PTX:1061 shr.u64 %rd476, %rd475, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd476) : "l"(rd475));
  // PTX:1062 add.s64 %rd477, %rd476, %rd714
  asm("add.s64 %0, %1, %2;" : "=l"(rd477) : "l"(rd476), "l"(rd714));
  // PTX:1063 mul.lo.s64 %rd478, %rd477, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd478) : "l"(rd477), "l"(rd140));
  // PTX:1064 add.s64 %rd479, %rd478, %rd19
  asm("add.s64 %0, %1, %2;" : "=l"(rd479) : "l"(rd478), "l"(rd19));
  // PTX:1065 mul.lo.s64 %rd480, %rd479, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd480) : "l"(rd479));
  // PTX:1066 add.s64 %rd481, %rd1, %rd480
  asm("add.s64 %0, %1, %2;" : "=l"(rd481) : "l"(rd1), "l"(rd480));
  // PTX:1067 ld.global.u32 %r92, [%rd481]
  r92 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd481) + (0)))));
  // PTX:1068 cvt.u32.u64 %r93, %rd84
  asm("cvt.u32.u64 %0, %1;" : "=r"(r93) : "l"(rd84));
  // PTX:1069 setp.lt.s32 %p61, %r92, %r93
  p61 = (((int)(r92)) < ((int)(r93)));
  // PTX:1070 add.s64 %rd482, %rd477, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd482) : "l"(rd477));
  // PTX:1071 selp.b64 %rd714, %rd482, %rd714, %p61
  rd714 = p61 ? rd482 : rd714;
  // PTX:1072 selp.b64 %rd712, %rd712, %rd477, %p61
  rd712 = p61 ? rd712 : rd477;
  // PTX:1073 setp.gt.u64 %p62, %rd712, %rd714
  p62 = (((unsigned long long)(rd712)) > ((unsigned long long)(rd714)));
  // PTX:1074 @%p62 bra $L__BB57_83
  if (p62) { goto L_BB57_83; }
  // PTX:1076 $L__BB57_84:
L_BB57_84:;
  // PTX:1077 setp.ge.u64 %p63, %rd714, %rd85
  p63 = (((unsigned long long)(rd714)) >= ((unsigned long long)(rd85)));
  // PTX:1078 @%p63 bra $L__BB57_88
  if (p63) { goto L_BB57_88; }
  // PTX:1080 cvt.u32.u64 %r94, %rd84
  asm("cvt.u32.u64 %0, %1;" : "=r"(r94) : "l"(rd84));
  // PTX:1081 mul.lo.s64 %rd483, %rd714, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd483) : "l"(rd714), "l"(rd140));
  // PTX:1082 add.s64 %rd91, %rd483, %rd19
  asm("add.s64 %0, %1, %2;" : "=l"(rd91) : "l"(rd483), "l"(rd19));
  // PTX:1083 mul.lo.s64 %rd484, %rd91, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd484) : "l"(rd91));
  // PTX:1084 add.s64 %rd485, %rd1, %rd484
  asm("add.s64 %0, %1, %2;" : "=l"(rd485) : "l"(rd1), "l"(rd484));
  // PTX:1085 ld.global.u32 %r95, [%rd485]
  r95 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd485) + (0)))));
  // PTX:1086 setp.ne.s32 %p64, %r95, %r94
  p64 = (((int)(r95)) != ((int)(r94)));
  // PTX:1087 @%p64 bra $L__BB57_88
  if (p64) { goto L_BB57_88; }
  // PTX:1089 add.s64 %rd488, %rd485, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd488) : "l"(rd485));
  // PTX:1090 red.global.add.f32 [%rd488], %f50
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd488) + (0)))), (float)(f50));
  // PTX:1091 add.s64 %rd489, %rd485, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd489) : "l"(rd485));
  // PTX:1092 red.global.add.f32 [%rd489], %f51
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd489) + (0)))), (float)(f51));
  // PTX:1093 add.s64 %rd490, %rd485, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd490) : "l"(rd485));
  // PTX:1094 red.global.add.f32 [%rd490], %f52
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd490) + (0)))), (float)(f52));
  // PTX:1095 add.s64 %rd491, %rd485, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd491) : "l"(rd485));
  // PTX:1096 red.global.add.f32 [%rd491], %f53
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd491) + (0)))), (float)(f53));
  // PTX:1097 add.s64 %rd492, %rd485, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd492) : "l"(rd485));
  // PTX:1098 red.global.add.f32 [%rd492], %f54
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd492) + (0)))), (float)(f54));
  // PTX:1099 add.s64 %rd493, %rd485, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd493) : "l"(rd485));
  // PTX:1100 red.global.add.f32 [%rd493], %f55
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd493) + (0)))), (float)(f55));
  // PTX:1101 add.s64 %rd494, %rd485, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd494) : "l"(rd485));
  // PTX:1102 red.global.add.f32 [%rd494], %f56
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd494) + (0)))), (float)(f56));
  // PTX:1103 add.s64 %rd495, %rd485, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd495) : "l"(rd485));
  // PTX:1104 red.global.add.f32 [%rd495], %f57
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd495) + (0)))), (float)(f57));
  // PTX:1105 add.s64 %rd496, %rd485, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd496) : "l"(rd485));
  // PTX:1106 red.global.add.f32 [%rd496], %f58
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd496) + (0)))), (float)(f58));
  // PTX:1108 $L__BB57_88:
L_BB57_88:;
  // PTX:1109 cvt.u32.u64 %r97, %rd84
  asm("cvt.u32.u64 %0, %1;" : "=r"(r97) : "l"(rd84));
  // PTX:1110 setp.eq.s32 %p65, %r42, %r97
  p65 = (((int)(r42)) == ((int)(r97)));
  // PTX:1111 @%p65 bra $L__BB57_95
  if (p65) { goto L_BB57_95; }
  // PTX:1112 bra.uni $L__BB57_89
  goto L_BB57_89;
  // PTX:1114 $L__BB57_95:
L_BB57_95:;
  // PTX:1115 mul.lo.s64 %rd532, %rd84, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd532) : "l"(rd84));
  // PTX:1116 add.s64 %rd533, %rd2, %rd532
  asm("add.s64 %0, %1, %2;" : "=l"(rd533) : "l"(rd2), "l"(rd532));
  // PTX:1117 red.global.add.f32 [%rd533], %f50
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd533) + (0)))), (float)(f50));
  // PTX:1118 add.s64 %rd534, %rd533, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd534) : "l"(rd533));
  // PTX:1119 red.global.add.f32 [%rd534], %f51
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd534) + (0)))), (float)(f51));
  // PTX:1120 add.s64 %rd535, %rd533, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd535) : "l"(rd533));
  // PTX:1121 red.global.add.f32 [%rd535], %f52
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd535) + (0)))), (float)(f52));
  // PTX:1122 add.s64 %rd536, %rd533, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd536) : "l"(rd533));
  // PTX:1123 red.global.add.f32 [%rd536], %f53
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd536) + (0)))), (float)(f53));
  // PTX:1124 add.s64 %rd537, %rd533, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd537) : "l"(rd533));
  // PTX:1125 red.global.add.f32 [%rd537], %f54
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd537) + (0)))), (float)(f54));
  // PTX:1126 add.s64 %rd538, %rd533, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd538) : "l"(rd533));
  // PTX:1127 red.global.add.f32 [%rd538], %f55
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd538) + (0)))), (float)(f55));
  // PTX:1128 add.s64 %rd539, %rd533, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd539) : "l"(rd533));
  // PTX:1129 red.global.add.f32 [%rd539], %f56
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd539) + (0)))), (float)(f56));
  // PTX:1130 add.s64 %rd540, %rd533, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd540) : "l"(rd533));
  // PTX:1131 red.global.add.f32 [%rd540], %f57
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd540) + (0)))), (float)(f57));
  // PTX:1132 add.s64 %rd541, %rd533, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd541) : "l"(rd533));
  // PTX:1133 red.global.add.f32 [%rd541], %f58
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd541) + (0)))), (float)(f58));
  // PTX:1134 bra.uni $L__BB57_96
  goto L_BB57_96;
  // PTX:1136 $L__BB57_89:
L_BB57_89:;
  // PTX:1137 shl.b64 %rd506, %rd84, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd506) : "l"(rd84));
  // PTX:1138 add.s64 %rd507, %rd3, %rd506
  asm("add.s64 %0, %1, %2;" : "=l"(rd507) : "l"(rd3), "l"(rd506));
  // PTX:1139 ld.global.s32 %rd508, [%rd507]
  rd508 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd507) + (0)))));
  // PTX:1140 mov.u64 %rd717, 0
  asm("mov.u64 %0, 0;" : "=l"(rd717) : );
  // PTX:1141 min.u64 %rd92, %rd508, %rd136
  asm("min.u64 %0, %1, %2;" : "=l"(rd92) : "l"(rd508), "l"(rd136));
  // PTX:1142 setp.eq.s64 %p66, %rd92, 0
  p66 = (((long long)(rd92)) == ((long long)(0)));
  // PTX:1143 @%p66 bra $L__BB57_92
  if (p66) { goto L_BB57_92; }
  // PTX:1145 mov.u64 %rd717, 0
  asm("mov.u64 %0, 0;" : "=l"(rd717) : );
  // PTX:1146 mov.u64 %rd715, %rd92
  asm("mov.u64 %0, %1;" : "=l"(rd715) : "l"(rd92));
  // PTX:1148 $L__BB57_91:
L_BB57_91:;
  // PTX:1149 sub.s64 %rd510, %rd715, %rd717
  asm("sub.s64 %0, %1, %2;" : "=l"(rd510) : "l"(rd715), "l"(rd717));
  // PTX:1150 shr.u64 %rd511, %rd510, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd511) : "l"(rd510));
  // PTX:1151 add.s64 %rd512, %rd511, %rd717
  asm("add.s64 %0, %1, %2;" : "=l"(rd512) : "l"(rd511), "l"(rd717));
  // PTX:1152 mul.lo.s64 %rd513, %rd512, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd513) : "l"(rd512), "l"(rd140));
  // PTX:1153 add.s64 %rd514, %rd513, %rd84
  asm("add.s64 %0, %1, %2;" : "=l"(rd514) : "l"(rd513), "l"(rd84));
  // PTX:1154 mul.lo.s64 %rd515, %rd514, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd515) : "l"(rd514));
  // PTX:1155 add.s64 %rd516, %rd1, %rd515
  asm("add.s64 %0, %1, %2;" : "=l"(rd516) : "l"(rd1), "l"(rd515));
  // PTX:1156 ld.global.u32 %r98, [%rd516]
  r98 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd516) + (0)))));
  // PTX:1157 setp.lt.s32 %p67, %r98, %r42
  p67 = (((int)(r98)) < ((int)(r42)));
  // PTX:1158 add.s64 %rd517, %rd512, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd517) : "l"(rd512));
  // PTX:1159 selp.b64 %rd717, %rd517, %rd717, %p67
  rd717 = p67 ? rd517 : rd717;
  // PTX:1160 selp.b64 %rd715, %rd715, %rd512, %p67
  rd715 = p67 ? rd715 : rd512;
  // PTX:1161 setp.gt.u64 %p68, %rd715, %rd717
  p68 = (((unsigned long long)(rd715)) > ((unsigned long long)(rd717)));
  // PTX:1162 @%p68 bra $L__BB57_91
  if (p68) { goto L_BB57_91; }
  // PTX:1164 $L__BB57_92:
L_BB57_92:;
  // PTX:1165 setp.ge.u64 %p69, %rd717, %rd92
  p69 = (((unsigned long long)(rd717)) >= ((unsigned long long)(rd92)));
  // PTX:1166 @%p69 bra $L__BB57_96
  if (p69) { goto L_BB57_96; }
  // PTX:1168 mul.lo.s64 %rd518, %rd717, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd518) : "l"(rd717), "l"(rd140));
  // PTX:1169 add.s64 %rd98, %rd518, %rd84
  asm("add.s64 %0, %1, %2;" : "=l"(rd98) : "l"(rd518), "l"(rd84));
  // PTX:1170 mul.lo.s64 %rd519, %rd98, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd519) : "l"(rd98));
  // PTX:1171 add.s64 %rd520, %rd1, %rd519
  asm("add.s64 %0, %1, %2;" : "=l"(rd520) : "l"(rd1), "l"(rd519));
  // PTX:1172 ld.global.u32 %r101, [%rd520]
  r101 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd520) + (0)))));
  // PTX:1173 setp.ne.s32 %p70, %r101, %r42
  p70 = (((int)(r101)) != ((int)(r42)));
  // PTX:1174 @%p70 bra $L__BB57_96
  if (p70) { goto L_BB57_96; }
  // PTX:1176 add.s64 %rd523, %rd520, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd523) : "l"(rd520));
  // PTX:1177 red.global.add.f32 [%rd523], %f50
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd523) + (0)))), (float)(f50));
  // PTX:1178 add.s64 %rd524, %rd520, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd524) : "l"(rd520));
  // PTX:1179 red.global.add.f32 [%rd524], %f51
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd524) + (0)))), (float)(f51));
  // PTX:1180 add.s64 %rd525, %rd520, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd525) : "l"(rd520));
  // PTX:1181 red.global.add.f32 [%rd525], %f52
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd525) + (0)))), (float)(f52));
  // PTX:1182 add.s64 %rd526, %rd520, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd526) : "l"(rd520));
  // PTX:1183 red.global.add.f32 [%rd526], %f53
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd526) + (0)))), (float)(f53));
  // PTX:1184 add.s64 %rd527, %rd520, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd527) : "l"(rd520));
  // PTX:1185 red.global.add.f32 [%rd527], %f54
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd527) + (0)))), (float)(f54));
  // PTX:1186 add.s64 %rd528, %rd520, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd528) : "l"(rd520));
  // PTX:1187 red.global.add.f32 [%rd528], %f55
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd528) + (0)))), (float)(f55));
  // PTX:1188 add.s64 %rd529, %rd520, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd529) : "l"(rd520));
  // PTX:1189 red.global.add.f32 [%rd529], %f56
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd529) + (0)))), (float)(f56));
  // PTX:1190 add.s64 %rd530, %rd520, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd530) : "l"(rd520));
  // PTX:1191 red.global.add.f32 [%rd530], %f57
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd530) + (0)))), (float)(f57));
  // PTX:1192 add.s64 %rd531, %rd520, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd531) : "l"(rd520));
  // PTX:1193 red.global.add.f32 [%rd531], %f58
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd531) + (0)))), (float)(f58));
  // PTX:1195 $L__BB57_96:
L_BB57_96:;
  // PTX:1196 add.s32 %r102, %r132, 6
  asm("add.s32 %0, %1, 6;" : "=r"(r102) : "r"(r132));
  // PTX:1197 setp.ge.u32 %p71, %r102, %r130
  p71 = (((unsigned)(r102)) >= ((unsigned)(r130)));
  // PTX:1198 @%p71 bra $L__BB57_130
  if (p71) { goto L_BB57_130; }
  // PTX:1200 ld.local.f32 %f366, [%rd22+20]
  f366 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd22) + (20)))));
  // PTX:1201 mul.f32 %f367, %f12, %f366
  asm("mul.f32 %0, %1, %2;" : "=f"(f367) : "f"(f12), "f"(f366));
  // PTX:1202 ld.global.f32 %f368, [%rd17]
  f368 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:1203 mul.f32 %f59, %f368, %f367
  asm("mul.f32 %0, %1, %2;" : "=f"(f59) : "f"(f368), "f"(f367));
  // PTX:1204 ld.global.f32 %f369, [%rd17+4]
  f369 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (4)))));
  // PTX:1205 mul.f32 %f60, %f367, %f369
  asm("mul.f32 %0, %1, %2;" : "=f"(f60) : "f"(f367), "f"(f369));
  // PTX:1206 ld.global.f32 %f370, [%rd17+8]
  f370 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (8)))));
  // PTX:1207 mul.f32 %f61, %f367, %f370
  asm("mul.f32 %0, %1, %2;" : "=f"(f61) : "f"(f367), "f"(f370));
  // PTX:1208 ld.global.f32 %f371, [%rd17+12]
  f371 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (12)))));
  // PTX:1209 mul.f32 %f62, %f367, %f371
  asm("mul.f32 %0, %1, %2;" : "=f"(f62) : "f"(f367), "f"(f371));
  // PTX:1210 ld.global.f32 %f372, [%rd17+16]
  f372 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (16)))));
  // PTX:1211 mul.f32 %f63, %f367, %f372
  asm("mul.f32 %0, %1, %2;" : "=f"(f63) : "f"(f367), "f"(f372));
  // PTX:1212 ld.global.f32 %f373, [%rd17+20]
  f373 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (20)))));
  // PTX:1213 mul.f32 %f64, %f367, %f373
  asm("mul.f32 %0, %1, %2;" : "=f"(f64) : "f"(f367), "f"(f373));
  // PTX:1214 ld.global.f32 %f374, [%rd17+24]
  f374 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (24)))));
  // PTX:1215 mul.f32 %f65, %f367, %f374
  asm("mul.f32 %0, %1, %2;" : "=f"(f65) : "f"(f367), "f"(f374));
  // PTX:1216 ld.global.f32 %f375, [%rd17+28]
  f375 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (28)))));
  // PTX:1217 mul.f32 %f66, %f367, %f375
  asm("mul.f32 %0, %1, %2;" : "=f"(f66) : "f"(f367), "f"(f375));
  // PTX:1218 ld.global.f32 %f376, [%rd17+32]
  f376 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (32)))));
  // PTX:1219 mul.f32 %f67, %f367, %f376
  asm("mul.f32 %0, %1, %2;" : "=f"(f67) : "f"(f367), "f"(f376));
  // PTX:1220 ld.local.u32 %r104, [%rd23+20]
  r104 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd23) + (20)))));
  // PTX:1221 cvt.s64.s32 %rd99, %r104
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd99) : "r"(r104));
  // PTX:1222 setp.eq.s32 %p72, %r42, %r104
  p72 = (((int)(r42)) == ((int)(r104)));
  // PTX:1223 @%p72 bra $L__BB57_104
  if (p72) { goto L_BB57_104; }
  // PTX:1224 bra.uni $L__BB57_98
  goto L_BB57_98;
  // PTX:1226 $L__BB57_104:
L_BB57_104:;
  // PTX:1227 red.global.add.f32 [%rd20], %f59
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))), (float)(f59));
  // PTX:1228 red.global.add.f32 [%rd180], %f60
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (0)))), (float)(f60));
  // PTX:1229 red.global.add.f32 [%rd181], %f61
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd181) + (0)))), (float)(f61));
  // PTX:1230 red.global.add.f32 [%rd182], %f62
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd182) + (0)))), (float)(f62));
  // PTX:1231 red.global.add.f32 [%rd183], %f63
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd183) + (0)))), (float)(f63));
  // PTX:1232 red.global.add.f32 [%rd184], %f64
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd184) + (0)))), (float)(f64));
  // PTX:1233 red.global.add.f32 [%rd185], %f65
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (0)))), (float)(f65));
  // PTX:1234 red.global.add.f32 [%rd186], %f66
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd186) + (0)))), (float)(f66));
  // PTX:1235 red.global.add.f32 [%rd187], %f67
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd187) + (0)))), (float)(f67));
  // PTX:1236 bra.uni $L__BB57_105
  goto L_BB57_105;
  // PTX:1238 $L__BB57_98:
L_BB57_98:;
  // PTX:1239 ld.global.s32 %rd543, [%rd21]
  rd543 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (0)))));
  // PTX:1240 mov.u64 %rd720, 0
  asm("mov.u64 %0, 0;" : "=l"(rd720) : );
  // PTX:1241 min.u64 %rd100, %rd543, %rd136
  asm("min.u64 %0, %1, %2;" : "=l"(rd100) : "l"(rd543), "l"(rd136));
  // PTX:1242 setp.eq.s64 %p73, %rd100, 0
  p73 = (((long long)(rd100)) == ((long long)(0)));
  // PTX:1243 @%p73 bra $L__BB57_101
  if (p73) { goto L_BB57_101; }
  // PTX:1245 mov.u64 %rd720, 0
  asm("mov.u64 %0, 0;" : "=l"(rd720) : );
  // PTX:1246 mov.u64 %rd718, %rd100
  asm("mov.u64 %0, %1;" : "=l"(rd718) : "l"(rd100));
  // PTX:1248 $L__BB57_100:
L_BB57_100:;
  // PTX:1249 sub.s64 %rd545, %rd718, %rd720
  asm("sub.s64 %0, %1, %2;" : "=l"(rd545) : "l"(rd718), "l"(rd720));
  // PTX:1250 shr.u64 %rd546, %rd545, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd546) : "l"(rd545));
  // PTX:1251 add.s64 %rd547, %rd546, %rd720
  asm("add.s64 %0, %1, %2;" : "=l"(rd547) : "l"(rd546), "l"(rd720));
  // PTX:1252 mul.lo.s64 %rd548, %rd547, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd548) : "l"(rd547), "l"(rd140));
  // PTX:1253 add.s64 %rd549, %rd548, %rd19
  asm("add.s64 %0, %1, %2;" : "=l"(rd549) : "l"(rd548), "l"(rd19));
  // PTX:1254 mul.lo.s64 %rd550, %rd549, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd550) : "l"(rd549));
  // PTX:1255 add.s64 %rd551, %rd1, %rd550
  asm("add.s64 %0, %1, %2;" : "=l"(rd551) : "l"(rd1), "l"(rd550));
  // PTX:1256 ld.global.u32 %r105, [%rd551]
  r105 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd551) + (0)))));
  // PTX:1257 cvt.u32.u64 %r106, %rd99
  asm("cvt.u32.u64 %0, %1;" : "=r"(r106) : "l"(rd99));
  // PTX:1258 setp.lt.s32 %p74, %r105, %r106
  p74 = (((int)(r105)) < ((int)(r106)));
  // PTX:1259 add.s64 %rd552, %rd547, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd552) : "l"(rd547));
  // PTX:1260 selp.b64 %rd720, %rd552, %rd720, %p74
  rd720 = p74 ? rd552 : rd720;
  // PTX:1261 selp.b64 %rd718, %rd718, %rd547, %p74
  rd718 = p74 ? rd718 : rd547;
  // PTX:1262 setp.gt.u64 %p75, %rd718, %rd720
  p75 = (((unsigned long long)(rd718)) > ((unsigned long long)(rd720)));
  // PTX:1263 @%p75 bra $L__BB57_100
  if (p75) { goto L_BB57_100; }
  // PTX:1265 $L__BB57_101:
L_BB57_101:;
  // PTX:1266 setp.ge.u64 %p76, %rd720, %rd100
  p76 = (((unsigned long long)(rd720)) >= ((unsigned long long)(rd100)));
  // PTX:1267 @%p76 bra $L__BB57_105
  if (p76) { goto L_BB57_105; }
  // PTX:1269 cvt.u32.u64 %r107, %rd99
  asm("cvt.u32.u64 %0, %1;" : "=r"(r107) : "l"(rd99));
  // PTX:1270 mul.lo.s64 %rd553, %rd720, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd553) : "l"(rd720), "l"(rd140));
  // PTX:1271 add.s64 %rd106, %rd553, %rd19
  asm("add.s64 %0, %1, %2;" : "=l"(rd106) : "l"(rd553), "l"(rd19));
  // PTX:1272 mul.lo.s64 %rd554, %rd106, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd554) : "l"(rd106));
  // PTX:1273 add.s64 %rd555, %rd1, %rd554
  asm("add.s64 %0, %1, %2;" : "=l"(rd555) : "l"(rd1), "l"(rd554));
  // PTX:1274 ld.global.u32 %r108, [%rd555]
  r108 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd555) + (0)))));
  // PTX:1275 setp.ne.s32 %p77, %r108, %r107
  p77 = (((int)(r108)) != ((int)(r107)));
  // PTX:1276 @%p77 bra $L__BB57_105
  if (p77) { goto L_BB57_105; }
  // PTX:1278 add.s64 %rd558, %rd555, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd558) : "l"(rd555));
  // PTX:1279 red.global.add.f32 [%rd558], %f59
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd558) + (0)))), (float)(f59));
  // PTX:1280 add.s64 %rd559, %rd555, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd559) : "l"(rd555));
  // PTX:1281 red.global.add.f32 [%rd559], %f60
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd559) + (0)))), (float)(f60));
  // PTX:1282 add.s64 %rd560, %rd555, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd560) : "l"(rd555));
  // PTX:1283 red.global.add.f32 [%rd560], %f61
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd560) + (0)))), (float)(f61));
  // PTX:1284 add.s64 %rd561, %rd555, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd561) : "l"(rd555));
  // PTX:1285 red.global.add.f32 [%rd561], %f62
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd561) + (0)))), (float)(f62));
  // PTX:1286 add.s64 %rd562, %rd555, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd562) : "l"(rd555));
  // PTX:1287 red.global.add.f32 [%rd562], %f63
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd562) + (0)))), (float)(f63));
  // PTX:1288 add.s64 %rd563, %rd555, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd563) : "l"(rd555));
  // PTX:1289 red.global.add.f32 [%rd563], %f64
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd563) + (0)))), (float)(f64));
  // PTX:1290 add.s64 %rd564, %rd555, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd564) : "l"(rd555));
  // PTX:1291 red.global.add.f32 [%rd564], %f65
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd564) + (0)))), (float)(f65));
  // PTX:1292 add.s64 %rd565, %rd555, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd565) : "l"(rd555));
  // PTX:1293 red.global.add.f32 [%rd565], %f66
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd565) + (0)))), (float)(f66));
  // PTX:1294 add.s64 %rd566, %rd555, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd566) : "l"(rd555));
  // PTX:1295 red.global.add.f32 [%rd566], %f67
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd566) + (0)))), (float)(f67));
  // PTX:1297 $L__BB57_105:
L_BB57_105:;
  // PTX:1298 cvt.u32.u64 %r110, %rd99
  asm("cvt.u32.u64 %0, %1;" : "=r"(r110) : "l"(rd99));
  // PTX:1299 setp.eq.s32 %p78, %r42, %r110
  p78 = (((int)(r42)) == ((int)(r110)));
  // PTX:1300 @%p78 bra $L__BB57_112
  if (p78) { goto L_BB57_112; }
  // PTX:1301 bra.uni $L__BB57_106
  goto L_BB57_106;
  // PTX:1303 $L__BB57_112:
L_BB57_112:;
  // PTX:1304 mul.lo.s64 %rd602, %rd99, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd602) : "l"(rd99));
  // PTX:1305 add.s64 %rd603, %rd2, %rd602
  asm("add.s64 %0, %1, %2;" : "=l"(rd603) : "l"(rd2), "l"(rd602));
  // PTX:1306 red.global.add.f32 [%rd603], %f59
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd603) + (0)))), (float)(f59));
  // PTX:1307 add.s64 %rd604, %rd603, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd604) : "l"(rd603));
  // PTX:1308 red.global.add.f32 [%rd604], %f60
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd604) + (0)))), (float)(f60));
  // PTX:1309 add.s64 %rd605, %rd603, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd605) : "l"(rd603));
  // PTX:1310 red.global.add.f32 [%rd605], %f61
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd605) + (0)))), (float)(f61));
  // PTX:1311 add.s64 %rd606, %rd603, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd606) : "l"(rd603));
  // PTX:1312 red.global.add.f32 [%rd606], %f62
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd606) + (0)))), (float)(f62));
  // PTX:1313 add.s64 %rd607, %rd603, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd607) : "l"(rd603));
  // PTX:1314 red.global.add.f32 [%rd607], %f63
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd607) + (0)))), (float)(f63));
  // PTX:1315 add.s64 %rd608, %rd603, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd608) : "l"(rd603));
  // PTX:1316 red.global.add.f32 [%rd608], %f64
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd608) + (0)))), (float)(f64));
  // PTX:1317 add.s64 %rd609, %rd603, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd609) : "l"(rd603));
  // PTX:1318 red.global.add.f32 [%rd609], %f65
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd609) + (0)))), (float)(f65));
  // PTX:1319 add.s64 %rd610, %rd603, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd610) : "l"(rd603));
  // PTX:1320 red.global.add.f32 [%rd610], %f66
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd610) + (0)))), (float)(f66));
  // PTX:1321 add.s64 %rd611, %rd603, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd611) : "l"(rd603));
  // PTX:1322 red.global.add.f32 [%rd611], %f67
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd611) + (0)))), (float)(f67));
  // PTX:1323 bra.uni $L__BB57_113
  goto L_BB57_113;
  // PTX:1325 $L__BB57_106:
L_BB57_106:;
  // PTX:1326 shl.b64 %rd576, %rd99, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd576) : "l"(rd99));
  // PTX:1327 add.s64 %rd577, %rd3, %rd576
  asm("add.s64 %0, %1, %2;" : "=l"(rd577) : "l"(rd3), "l"(rd576));
  // PTX:1328 ld.global.s32 %rd578, [%rd577]
  rd578 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd577) + (0)))));
  // PTX:1329 mov.u64 %rd723, 0
  asm("mov.u64 %0, 0;" : "=l"(rd723) : );
  // PTX:1330 min.u64 %rd107, %rd578, %rd136
  asm("min.u64 %0, %1, %2;" : "=l"(rd107) : "l"(rd578), "l"(rd136));
  // PTX:1331 setp.eq.s64 %p79, %rd107, 0
  p79 = (((long long)(rd107)) == ((long long)(0)));
  // PTX:1332 @%p79 bra $L__BB57_109
  if (p79) { goto L_BB57_109; }
  // PTX:1334 mov.u64 %rd723, 0
  asm("mov.u64 %0, 0;" : "=l"(rd723) : );
  // PTX:1335 mov.u64 %rd721, %rd107
  asm("mov.u64 %0, %1;" : "=l"(rd721) : "l"(rd107));
  // PTX:1337 $L__BB57_108:
L_BB57_108:;
  // PTX:1338 sub.s64 %rd580, %rd721, %rd723
  asm("sub.s64 %0, %1, %2;" : "=l"(rd580) : "l"(rd721), "l"(rd723));
  // PTX:1339 shr.u64 %rd581, %rd580, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd581) : "l"(rd580));
  // PTX:1340 add.s64 %rd582, %rd581, %rd723
  asm("add.s64 %0, %1, %2;" : "=l"(rd582) : "l"(rd581), "l"(rd723));
  // PTX:1341 mul.lo.s64 %rd583, %rd582, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd583) : "l"(rd582), "l"(rd140));
  // PTX:1342 add.s64 %rd584, %rd583, %rd99
  asm("add.s64 %0, %1, %2;" : "=l"(rd584) : "l"(rd583), "l"(rd99));
  // PTX:1343 mul.lo.s64 %rd585, %rd584, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd585) : "l"(rd584));
  // PTX:1344 add.s64 %rd586, %rd1, %rd585
  asm("add.s64 %0, %1, %2;" : "=l"(rd586) : "l"(rd1), "l"(rd585));
  // PTX:1345 ld.global.u32 %r111, [%rd586]
  r111 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd586) + (0)))));
  // PTX:1346 setp.lt.s32 %p80, %r111, %r42
  p80 = (((int)(r111)) < ((int)(r42)));
  // PTX:1347 add.s64 %rd587, %rd582, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd587) : "l"(rd582));
  // PTX:1348 selp.b64 %rd723, %rd587, %rd723, %p80
  rd723 = p80 ? rd587 : rd723;
  // PTX:1349 selp.b64 %rd721, %rd721, %rd582, %p80
  rd721 = p80 ? rd721 : rd582;
  // PTX:1350 setp.gt.u64 %p81, %rd721, %rd723
  p81 = (((unsigned long long)(rd721)) > ((unsigned long long)(rd723)));
  // PTX:1351 @%p81 bra $L__BB57_108
  if (p81) { goto L_BB57_108; }
  // PTX:1353 $L__BB57_109:
L_BB57_109:;
  // PTX:1354 setp.ge.u64 %p82, %rd723, %rd107
  p82 = (((unsigned long long)(rd723)) >= ((unsigned long long)(rd107)));
  // PTX:1355 @%p82 bra $L__BB57_113
  if (p82) { goto L_BB57_113; }
  // PTX:1357 mul.lo.s64 %rd588, %rd723, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd588) : "l"(rd723), "l"(rd140));
  // PTX:1358 add.s64 %rd113, %rd588, %rd99
  asm("add.s64 %0, %1, %2;" : "=l"(rd113) : "l"(rd588), "l"(rd99));
  // PTX:1359 mul.lo.s64 %rd589, %rd113, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd589) : "l"(rd113));
  // PTX:1360 add.s64 %rd590, %rd1, %rd589
  asm("add.s64 %0, %1, %2;" : "=l"(rd590) : "l"(rd1), "l"(rd589));
  // PTX:1361 ld.global.u32 %r114, [%rd590]
  r114 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd590) + (0)))));
  // PTX:1362 setp.ne.s32 %p83, %r114, %r42
  p83 = (((int)(r114)) != ((int)(r42)));
  // PTX:1363 @%p83 bra $L__BB57_113
  if (p83) { goto L_BB57_113; }
  // PTX:1365 add.s64 %rd593, %rd590, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd593) : "l"(rd590));
  // PTX:1366 red.global.add.f32 [%rd593], %f59
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd593) + (0)))), (float)(f59));
  // PTX:1367 add.s64 %rd594, %rd590, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd594) : "l"(rd590));
  // PTX:1368 red.global.add.f32 [%rd594], %f60
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd594) + (0)))), (float)(f60));
  // PTX:1369 add.s64 %rd595, %rd590, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd595) : "l"(rd590));
  // PTX:1370 red.global.add.f32 [%rd595], %f61
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd595) + (0)))), (float)(f61));
  // PTX:1371 add.s64 %rd596, %rd590, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd596) : "l"(rd590));
  // PTX:1372 red.global.add.f32 [%rd596], %f62
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd596) + (0)))), (float)(f62));
  // PTX:1373 add.s64 %rd597, %rd590, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd597) : "l"(rd590));
  // PTX:1374 red.global.add.f32 [%rd597], %f63
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd597) + (0)))), (float)(f63));
  // PTX:1375 add.s64 %rd598, %rd590, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd598) : "l"(rd590));
  // PTX:1376 red.global.add.f32 [%rd598], %f64
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd598) + (0)))), (float)(f64));
  // PTX:1377 add.s64 %rd599, %rd590, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd599) : "l"(rd590));
  // PTX:1378 red.global.add.f32 [%rd599], %f65
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd599) + (0)))), (float)(f65));
  // PTX:1379 add.s64 %rd600, %rd590, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd600) : "l"(rd590));
  // PTX:1380 red.global.add.f32 [%rd600], %f66
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd600) + (0)))), (float)(f66));
  // PTX:1381 add.s64 %rd601, %rd590, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd601) : "l"(rd590));
  // PTX:1382 red.global.add.f32 [%rd601], %f67
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd601) + (0)))), (float)(f67));
  // PTX:1384 $L__BB57_113:
L_BB57_113:;
  // PTX:1385 add.s32 %r115, %r132, 7
  asm("add.s32 %0, %1, 7;" : "=r"(r115) : "r"(r132));
  // PTX:1386 setp.ge.u32 %p84, %r115, %r130
  p84 = (((unsigned)(r115)) >= ((unsigned)(r130)));
  // PTX:1387 @%p84 bra $L__BB57_130
  if (p84) { goto L_BB57_130; }
  // PTX:1389 ld.local.f32 %f413, [%rd22+24]
  f413 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd22) + (24)))));
  // PTX:1390 mul.f32 %f414, %f12, %f413
  asm("mul.f32 %0, %1, %2;" : "=f"(f414) : "f"(f12), "f"(f413));
  // PTX:1391 ld.global.f32 %f415, [%rd17]
  f415 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:1392 mul.f32 %f68, %f415, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f68) : "f"(f415), "f"(f414));
  // PTX:1393 ld.global.f32 %f416, [%rd17+4]
  f416 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (4)))));
  // PTX:1394 mul.f32 %f69, %f414, %f416
  asm("mul.f32 %0, %1, %2;" : "=f"(f69) : "f"(f414), "f"(f416));
  // PTX:1395 ld.global.f32 %f417, [%rd17+8]
  f417 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (8)))));
  // PTX:1396 mul.f32 %f70, %f414, %f417
  asm("mul.f32 %0, %1, %2;" : "=f"(f70) : "f"(f414), "f"(f417));
  // PTX:1397 ld.global.f32 %f418, [%rd17+12]
  f418 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (12)))));
  // PTX:1398 mul.f32 %f71, %f414, %f418
  asm("mul.f32 %0, %1, %2;" : "=f"(f71) : "f"(f414), "f"(f418));
  // PTX:1399 ld.global.f32 %f419, [%rd17+16]
  f419 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (16)))));
  // PTX:1400 mul.f32 %f72, %f414, %f419
  asm("mul.f32 %0, %1, %2;" : "=f"(f72) : "f"(f414), "f"(f419));
  // PTX:1401 ld.global.f32 %f420, [%rd17+20]
  f420 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (20)))));
  // PTX:1402 mul.f32 %f73, %f414, %f420
  asm("mul.f32 %0, %1, %2;" : "=f"(f73) : "f"(f414), "f"(f420));
  // PTX:1403 ld.global.f32 %f421, [%rd17+24]
  f421 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (24)))));
  // PTX:1404 mul.f32 %f74, %f414, %f421
  asm("mul.f32 %0, %1, %2;" : "=f"(f74) : "f"(f414), "f"(f421));
  // PTX:1405 ld.global.f32 %f422, [%rd17+28]
  f422 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (28)))));
  // PTX:1406 mul.f32 %f75, %f414, %f422
  asm("mul.f32 %0, %1, %2;" : "=f"(f75) : "f"(f414), "f"(f422));
  // PTX:1407 ld.global.f32 %f423, [%rd17+32]
  f423 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (32)))));
  // PTX:1408 mul.f32 %f76, %f414, %f423
  asm("mul.f32 %0, %1, %2;" : "=f"(f76) : "f"(f414), "f"(f423));
  // PTX:1409 ld.local.u32 %r117, [%rd23+24]
  r117 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd23) + (24)))));
  // PTX:1410 cvt.s64.s32 %rd114, %r117
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd114) : "r"(r117));
  // PTX:1411 setp.eq.s32 %p85, %r42, %r117
  p85 = (((int)(r42)) == ((int)(r117)));
  // PTX:1412 @%p85 bra $L__BB57_121
  if (p85) { goto L_BB57_121; }
  // PTX:1413 bra.uni $L__BB57_115
  goto L_BB57_115;
  // PTX:1415 $L__BB57_121:
L_BB57_121:;
  // PTX:1416 red.global.add.f32 [%rd20], %f68
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))), (float)(f68));
  // PTX:1417 red.global.add.f32 [%rd180], %f69
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (0)))), (float)(f69));
  // PTX:1418 red.global.add.f32 [%rd181], %f70
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd181) + (0)))), (float)(f70));
  // PTX:1419 red.global.add.f32 [%rd182], %f71
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd182) + (0)))), (float)(f71));
  // PTX:1420 red.global.add.f32 [%rd183], %f72
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd183) + (0)))), (float)(f72));
  // PTX:1421 red.global.add.f32 [%rd184], %f73
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd184) + (0)))), (float)(f73));
  // PTX:1422 red.global.add.f32 [%rd185], %f74
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (0)))), (float)(f74));
  // PTX:1423 red.global.add.f32 [%rd186], %f75
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd186) + (0)))), (float)(f75));
  // PTX:1424 red.global.add.f32 [%rd187], %f76
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd187) + (0)))), (float)(f76));
  // PTX:1425 bra.uni $L__BB57_122
  goto L_BB57_122;
  // PTX:1427 $L__BB57_115:
L_BB57_115:;
  // PTX:1428 ld.global.s32 %rd613, [%rd21]
  rd613 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (0)))));
  // PTX:1429 mov.u64 %rd726, 0
  asm("mov.u64 %0, 0;" : "=l"(rd726) : );
  // PTX:1430 min.u64 %rd115, %rd613, %rd136
  asm("min.u64 %0, %1, %2;" : "=l"(rd115) : "l"(rd613), "l"(rd136));
  // PTX:1431 setp.eq.s64 %p86, %rd115, 0
  p86 = (((long long)(rd115)) == ((long long)(0)));
  // PTX:1432 @%p86 bra $L__BB57_118
  if (p86) { goto L_BB57_118; }
  // PTX:1434 mov.u64 %rd726, 0
  asm("mov.u64 %0, 0;" : "=l"(rd726) : );
  // PTX:1435 mov.u64 %rd724, %rd115
  asm("mov.u64 %0, %1;" : "=l"(rd724) : "l"(rd115));
  // PTX:1437 $L__BB57_117:
L_BB57_117:;
  // PTX:1438 sub.s64 %rd615, %rd724, %rd726
  asm("sub.s64 %0, %1, %2;" : "=l"(rd615) : "l"(rd724), "l"(rd726));
  // PTX:1439 shr.u64 %rd616, %rd615, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd616) : "l"(rd615));
  // PTX:1440 add.s64 %rd617, %rd616, %rd726
  asm("add.s64 %0, %1, %2;" : "=l"(rd617) : "l"(rd616), "l"(rd726));
  // PTX:1441 mul.lo.s64 %rd618, %rd617, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd618) : "l"(rd617), "l"(rd140));
  // PTX:1442 add.s64 %rd619, %rd618, %rd19
  asm("add.s64 %0, %1, %2;" : "=l"(rd619) : "l"(rd618), "l"(rd19));
  // PTX:1443 mul.lo.s64 %rd620, %rd619, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd620) : "l"(rd619));
  // PTX:1444 add.s64 %rd621, %rd1, %rd620
  asm("add.s64 %0, %1, %2;" : "=l"(rd621) : "l"(rd1), "l"(rd620));
  // PTX:1445 ld.global.u32 %r118, [%rd621]
  r118 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd621) + (0)))));
  // PTX:1446 cvt.u32.u64 %r119, %rd114
  asm("cvt.u32.u64 %0, %1;" : "=r"(r119) : "l"(rd114));
  // PTX:1447 setp.lt.s32 %p87, %r118, %r119
  p87 = (((int)(r118)) < ((int)(r119)));
  // PTX:1448 add.s64 %rd622, %rd617, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd622) : "l"(rd617));
  // PTX:1449 selp.b64 %rd726, %rd622, %rd726, %p87
  rd726 = p87 ? rd622 : rd726;
  // PTX:1450 selp.b64 %rd724, %rd724, %rd617, %p87
  rd724 = p87 ? rd724 : rd617;
  // PTX:1451 setp.gt.u64 %p88, %rd724, %rd726
  p88 = (((unsigned long long)(rd724)) > ((unsigned long long)(rd726)));
  // PTX:1452 @%p88 bra $L__BB57_117
  if (p88) { goto L_BB57_117; }
  // PTX:1454 $L__BB57_118:
L_BB57_118:;
  // PTX:1455 setp.ge.u64 %p89, %rd726, %rd115
  p89 = (((unsigned long long)(rd726)) >= ((unsigned long long)(rd115)));
  // PTX:1456 @%p89 bra $L__BB57_122
  if (p89) { goto L_BB57_122; }
  // PTX:1458 cvt.u32.u64 %r120, %rd114
  asm("cvt.u32.u64 %0, %1;" : "=r"(r120) : "l"(rd114));
  // PTX:1459 mul.lo.s64 %rd623, %rd726, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd623) : "l"(rd726), "l"(rd140));
  // PTX:1460 add.s64 %rd121, %rd623, %rd19
  asm("add.s64 %0, %1, %2;" : "=l"(rd121) : "l"(rd623), "l"(rd19));
  // PTX:1461 mul.lo.s64 %rd624, %rd121, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd624) : "l"(rd121));
  // PTX:1462 add.s64 %rd625, %rd1, %rd624
  asm("add.s64 %0, %1, %2;" : "=l"(rd625) : "l"(rd1), "l"(rd624));
  // PTX:1463 ld.global.u32 %r121, [%rd625]
  r121 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd625) + (0)))));
  // PTX:1464 setp.ne.s32 %p90, %r121, %r120
  p90 = (((int)(r121)) != ((int)(r120)));
  // PTX:1465 @%p90 bra $L__BB57_122
  if (p90) { goto L_BB57_122; }
  // PTX:1467 add.s64 %rd628, %rd625, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd628) : "l"(rd625));
  // PTX:1468 red.global.add.f32 [%rd628], %f68
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd628) + (0)))), (float)(f68));
  // PTX:1469 add.s64 %rd629, %rd625, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd629) : "l"(rd625));
  // PTX:1470 red.global.add.f32 [%rd629], %f69
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd629) + (0)))), (float)(f69));
  // PTX:1471 add.s64 %rd630, %rd625, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd630) : "l"(rd625));
  // PTX:1472 red.global.add.f32 [%rd630], %f70
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd630) + (0)))), (float)(f70));
  // PTX:1473 add.s64 %rd631, %rd625, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd631) : "l"(rd625));
  // PTX:1474 red.global.add.f32 [%rd631], %f71
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd631) + (0)))), (float)(f71));
  // PTX:1475 add.s64 %rd632, %rd625, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd632) : "l"(rd625));
  // PTX:1476 red.global.add.f32 [%rd632], %f72
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd632) + (0)))), (float)(f72));
  // PTX:1477 add.s64 %rd633, %rd625, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd633) : "l"(rd625));
  // PTX:1478 red.global.add.f32 [%rd633], %f73
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd633) + (0)))), (float)(f73));
  // PTX:1479 add.s64 %rd634, %rd625, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd634) : "l"(rd625));
  // PTX:1480 red.global.add.f32 [%rd634], %f74
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd634) + (0)))), (float)(f74));
  // PTX:1481 add.s64 %rd635, %rd625, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd635) : "l"(rd625));
  // PTX:1482 red.global.add.f32 [%rd635], %f75
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd635) + (0)))), (float)(f75));
  // PTX:1483 add.s64 %rd636, %rd625, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd636) : "l"(rd625));
  // PTX:1484 red.global.add.f32 [%rd636], %f76
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd636) + (0)))), (float)(f76));
  // PTX:1486 $L__BB57_122:
L_BB57_122:;
  // PTX:1487 cvt.u32.u64 %r123, %rd114
  asm("cvt.u32.u64 %0, %1;" : "=r"(r123) : "l"(rd114));
  // PTX:1488 setp.eq.s32 %p91, %r42, %r123
  p91 = (((int)(r42)) == ((int)(r123)));
  // PTX:1489 @%p91 bra $L__BB57_129
  if (p91) { goto L_BB57_129; }
  // PTX:1490 bra.uni $L__BB57_123
  goto L_BB57_123;
  // PTX:1492 $L__BB57_129:
L_BB57_129:;
  // PTX:1493 mul.lo.s64 %rd672, %rd114, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd672) : "l"(rd114));
  // PTX:1494 add.s64 %rd673, %rd2, %rd672
  asm("add.s64 %0, %1, %2;" : "=l"(rd673) : "l"(rd2), "l"(rd672));
  // PTX:1495 red.global.add.f32 [%rd673], %f68
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd673) + (0)))), (float)(f68));
  // PTX:1496 add.s64 %rd674, %rd673, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd674) : "l"(rd673));
  // PTX:1497 red.global.add.f32 [%rd674], %f69
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd674) + (0)))), (float)(f69));
  // PTX:1498 add.s64 %rd675, %rd673, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd675) : "l"(rd673));
  // PTX:1499 red.global.add.f32 [%rd675], %f70
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd675) + (0)))), (float)(f70));
  // PTX:1500 add.s64 %rd676, %rd673, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd676) : "l"(rd673));
  // PTX:1501 red.global.add.f32 [%rd676], %f71
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd676) + (0)))), (float)(f71));
  // PTX:1502 add.s64 %rd677, %rd673, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd677) : "l"(rd673));
  // PTX:1503 red.global.add.f32 [%rd677], %f72
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd677) + (0)))), (float)(f72));
  // PTX:1504 add.s64 %rd678, %rd673, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd678) : "l"(rd673));
  // PTX:1505 red.global.add.f32 [%rd678], %f73
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd678) + (0)))), (float)(f73));
  // PTX:1506 add.s64 %rd679, %rd673, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd679) : "l"(rd673));
  // PTX:1507 red.global.add.f32 [%rd679], %f74
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd679) + (0)))), (float)(f74));
  // PTX:1508 add.s64 %rd680, %rd673, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd680) : "l"(rd673));
  // PTX:1509 red.global.add.f32 [%rd680], %f75
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd680) + (0)))), (float)(f75));
  // PTX:1510 add.s64 %rd681, %rd673, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd681) : "l"(rd673));
  // PTX:1511 red.global.add.f32 [%rd681], %f76
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd681) + (0)))), (float)(f76));
  // PTX:1512 bra.uni $L__BB57_130
  goto L_BB57_130;
  // PTX:1514 $L__BB57_123:
L_BB57_123:;
  // PTX:1515 shl.b64 %rd646, %rd114, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd646) : "l"(rd114));
  // PTX:1516 add.s64 %rd647, %rd3, %rd646
  asm("add.s64 %0, %1, %2;" : "=l"(rd647) : "l"(rd3), "l"(rd646));
  // PTX:1517 ld.global.s32 %rd648, [%rd647]
  rd648 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd647) + (0)))));
  // PTX:1518 mov.u64 %rd729, 0
  asm("mov.u64 %0, 0;" : "=l"(rd729) : );
  // PTX:1519 min.u64 %rd122, %rd648, %rd136
  asm("min.u64 %0, %1, %2;" : "=l"(rd122) : "l"(rd648), "l"(rd136));
  // PTX:1520 setp.eq.s64 %p92, %rd122, 0
  p92 = (((long long)(rd122)) == ((long long)(0)));
  // PTX:1521 @%p92 bra $L__BB57_126
  if (p92) { goto L_BB57_126; }
  // PTX:1523 mov.u64 %rd729, 0
  asm("mov.u64 %0, 0;" : "=l"(rd729) : );
  // PTX:1524 mov.u64 %rd727, %rd122
  asm("mov.u64 %0, %1;" : "=l"(rd727) : "l"(rd122));
  // PTX:1526 $L__BB57_125:
L_BB57_125:;
  // PTX:1527 sub.s64 %rd650, %rd727, %rd729
  asm("sub.s64 %0, %1, %2;" : "=l"(rd650) : "l"(rd727), "l"(rd729));
  // PTX:1528 shr.u64 %rd651, %rd650, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd651) : "l"(rd650));
  // PTX:1529 add.s64 %rd652, %rd651, %rd729
  asm("add.s64 %0, %1, %2;" : "=l"(rd652) : "l"(rd651), "l"(rd729));
  // PTX:1530 mul.lo.s64 %rd653, %rd652, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd653) : "l"(rd652), "l"(rd140));
  // PTX:1531 add.s64 %rd654, %rd653, %rd114
  asm("add.s64 %0, %1, %2;" : "=l"(rd654) : "l"(rd653), "l"(rd114));
  // PTX:1532 mul.lo.s64 %rd655, %rd654, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd655) : "l"(rd654));
  // PTX:1533 add.s64 %rd656, %rd1, %rd655
  asm("add.s64 %0, %1, %2;" : "=l"(rd656) : "l"(rd1), "l"(rd655));
  // PTX:1534 ld.global.u32 %r124, [%rd656]
  r124 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd656) + (0)))));
  // PTX:1535 setp.lt.s32 %p93, %r124, %r42
  p93 = (((int)(r124)) < ((int)(r42)));
  // PTX:1536 add.s64 %rd657, %rd652, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd657) : "l"(rd652));
  // PTX:1537 selp.b64 %rd729, %rd657, %rd729, %p93
  rd729 = p93 ? rd657 : rd729;
  // PTX:1538 selp.b64 %rd727, %rd727, %rd652, %p93
  rd727 = p93 ? rd727 : rd652;
  // PTX:1539 setp.gt.u64 %p94, %rd727, %rd729
  p94 = (((unsigned long long)(rd727)) > ((unsigned long long)(rd729)));
  // PTX:1540 @%p94 bra $L__BB57_125
  if (p94) { goto L_BB57_125; }
  // PTX:1542 $L__BB57_126:
L_BB57_126:;
  // PTX:1543 setp.ge.u64 %p95, %rd729, %rd122
  p95 = (((unsigned long long)(rd729)) >= ((unsigned long long)(rd122)));
  // PTX:1544 @%p95 bra $L__BB57_130
  if (p95) { goto L_BB57_130; }
  // PTX:1546 mul.lo.s64 %rd658, %rd729, %rd140
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd658) : "l"(rd729), "l"(rd140));
  // PTX:1547 add.s64 %rd128, %rd658, %rd114
  asm("add.s64 %0, %1, %2;" : "=l"(rd128) : "l"(rd658), "l"(rd114));
  // PTX:1548 mul.lo.s64 %rd659, %rd128, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd659) : "l"(rd128));
  // PTX:1549 add.s64 %rd660, %rd1, %rd659
  asm("add.s64 %0, %1, %2;" : "=l"(rd660) : "l"(rd1), "l"(rd659));
  // PTX:1550 ld.global.u32 %r127, [%rd660]
  r127 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd660) + (0)))));
  // PTX:1551 setp.ne.s32 %p96, %r127, %r42
  p96 = (((int)(r127)) != ((int)(r42)));
  // PTX:1552 @%p96 bra $L__BB57_130
  if (p96) { goto L_BB57_130; }
  // PTX:1554 add.s64 %rd663, %rd660, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd663) : "l"(rd660));
  // PTX:1555 red.global.add.f32 [%rd663], %f68
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd663) + (0)))), (float)(f68));
  // PTX:1556 add.s64 %rd664, %rd660, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd664) : "l"(rd660));
  // PTX:1557 red.global.add.f32 [%rd664], %f69
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd664) + (0)))), (float)(f69));
  // PTX:1558 add.s64 %rd665, %rd660, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd665) : "l"(rd660));
  // PTX:1559 red.global.add.f32 [%rd665], %f70
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd665) + (0)))), (float)(f70));
  // PTX:1560 add.s64 %rd666, %rd660, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd666) : "l"(rd660));
  // PTX:1561 red.global.add.f32 [%rd666], %f71
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd666) + (0)))), (float)(f71));
  // PTX:1562 add.s64 %rd667, %rd660, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd667) : "l"(rd660));
  // PTX:1563 red.global.add.f32 [%rd667], %f72
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd667) + (0)))), (float)(f72));
  // PTX:1564 add.s64 %rd668, %rd660, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd668) : "l"(rd660));
  // PTX:1565 red.global.add.f32 [%rd668], %f73
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd668) + (0)))), (float)(f73));
  // PTX:1566 add.s64 %rd669, %rd660, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd669) : "l"(rd660));
  // PTX:1567 red.global.add.f32 [%rd669], %f74
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd669) + (0)))), (float)(f74));
  // PTX:1568 add.s64 %rd670, %rd660, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd670) : "l"(rd660));
  // PTX:1569 red.global.add.f32 [%rd670], %f75
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd670) + (0)))), (float)(f75));
  // PTX:1570 add.s64 %rd671, %rd660, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd671) : "l"(rd660));
  // PTX:1571 red.global.add.f32 [%rd671], %f76
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd671) + (0)))), (float)(f76));
  // PTX:1572 bra.uni $L__BB57_130
  goto L_BB57_130;
  // PTX:1574 $L__BB57_131:
L_BB57_131:;
  // PTX:1575 ret
  return;
}
