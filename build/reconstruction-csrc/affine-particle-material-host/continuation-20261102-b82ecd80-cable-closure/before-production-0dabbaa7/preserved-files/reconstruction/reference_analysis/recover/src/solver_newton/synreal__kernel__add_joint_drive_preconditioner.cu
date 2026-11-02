// 机械还原自 PTX：synreal::kernel::add_joint_drive_preconditioner(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, int const*, int const*, float const*, float const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: b6b7289794938878156f0ac00385335f4d3574105c373c370ea3332a09031871
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__add_joint_drive_preconditioner(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10, unsigned long long param11, unsigned long long param12, unsigned long long param13, unsigned long long param14, unsigned long long param15, float param16, unsigned long long param17, unsigned long long param18, unsigned long long param19, unsigned long long param20) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440, f441, f442, f443, f444, f445, f446, f447, f448, f449, f450, f451, f452, f453, f454, f455, f456, f457, f458, f459, f460, f461, f462, f463, f464, f465, f466, f467, f468, f469, f470, f471, f472, f473, f474, f475, f476, f477, f478, f479, f480, f481, f482, f483, f484, f485, f486, f487, f488, f489, f490, f491, f492, f493, f494, f495, f496, f497, f498, f499, f500, f501, f502, f503, f504, f505, f506, f507, f508, f509, f510, f511, f512, f513, f514, f515, f516, f517, f518, f519, f520, f521, f522, f523, f524, f525, f526, f527, f528, f529, f530, f531, f532, f533, f534, f535, f536, f537, f538, f539, f540, f541, f542, f543, f544, f545, f546, f547, f548, f549, f550, f551, f552, f553, f554, f555, f556, f557, f558, f559, f560, f561, f562, f563, f564, f565, f566, f567, f568, f569, f570, f571, f572, f573, f574, f575, f576, f577, f578, f579, f580, f581, f582, f583, f584, f585, f586, f587, f588, f589, f590, f591, f592, f593, f594, f595, f596, f597, f598, f599, f600, f601, f602, f603, f604, f605, f606, f607, f608, f609, f610, f611, f612, f613, f614, f615, f616, f617, f618, f619, f620, f621, f622, f623, f624, f625, f626, f627, f628, f629, f630, f631, f632, f633, f634, f635, f636, f637, f638, f639, f640, f641, f642, f643, f644, f645, f646, f647, f648, f649, f650, f651, f652, f653, f654, f655, f656, f657, f658, f659, f660, f661, f662, f663, f664, f665, f666, f667, f668, f669, f670, f671, f672, f673, f674, f675, f676, f677, f678, f679, f680, f681, f682, f683, f684, f685, f686, f687, f688, f689, f690, f691, f692, f693, f694, f695, f696, f697, f698, f699, f700, f701, f702, f703, f704, f705, f706, f707, f708, f709, f710, f711, f712, f713, f714, f715, f716, f717, f718, f719, f720, f721, f722, f723, f724, f725, f726, f727, f728, f729, f730, f731, f732, f733, f734, f735, f736, f737, f738, f739, f740, f741, f742, f743, f744, f745, f746, f747, f748, f749, f750, f751, f752, f753, f754, f755, f756, f757, f758, f759, f760, f761, f762, f763, f764, f765, f766, f767, f768, f769, f770, f771, f772, f773, f774, f775, f776, f777, f778, f779;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135, rd136, rd137, rd138, rd139, rd140, rd141, rd142, rd143, rd144, rd145, rd146, rd147, rd148, rd149, rd150, rd151, rd152, rd153, rd154, rd155, rd156, rd157, rd158, rd159, rd160, rd161, rd162, rd163, rd164, rd165, rd166, rd167, rd168, rd169, rd170, rd171, rd172, rd173, rd174, rd175, rd176, rd177, rd178, rd179, rd180, rd181, rd182, rd183, rd184, rd185, rd186, rd187, rd188, rd189, rd190, rd191, rd192, rd193, rd194, rd195, rd196, rd197, rd198, rd199, rd200, rd201, rd202, rd203, rd204, rd205, rd206, rd207, rd208, rd209, rd210, rd211, rd212, rd213, rd214, rd215, rd216, rd217, rd218, rd219, rd220, rd221, rd222, rd223, rd224, rd225, rd226, rd227, rd228, rd229, rd230, rd231, rd232, rd233, rd234, rd235, rd236, rd237, rd238, rd239, rd240, rd241, rd242, rd243, rd244, rd245, rd246, rd247, rd248, rd249, rd250, rd251, rd252, rd253, rd254, rd255, rd256, rd257, rd258, rd259, rd260, rd261, rd262, rd263, rd264, rd265, rd266, rd267, rd268, rd269, rd270, rd271, rd272, rd273, rd274, rd275, rd276, rd277, rd278;
  // PTX:37 ld.param.u64 %rd49, [_ZN7synreal6kernel30add_joint_drive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_0]
  rd49 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:38 ld.param.u64 %rd50, [_ZN7synreal6kernel30add_joint_drive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_1]
  rd50 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:39 ld.param.u64 %rd33, [_ZN7synreal6kernel30add_joint_drive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_2]
  rd33 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:40 ld.param.u64 %rd34, [_ZN7synreal6kernel30add_joint_drive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_3]
  rd34 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:41 ld.param.u64 %rd35, [_ZN7synreal6kernel30add_joint_drive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_4]
  rd35 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:42 ld.param.u64 %rd36, [_ZN7synreal6kernel30add_joint_drive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_5]
  rd36 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:43 ld.param.u64 %rd37, [_ZN7synreal6kernel30add_joint_drive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_6]
  rd37 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:44 ld.param.u64 %rd38, [_ZN7synreal6kernel30add_joint_drive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_7]
  rd38 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:45 ld.param.u64 %rd39, [_ZN7synreal6kernel30add_joint_drive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_8]
  rd39 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:46 ld.param.u64 %rd40, [_ZN7synreal6kernel30add_joint_drive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_9]
  rd40 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:47 ld.param.u64 %rd41, [_ZN7synreal6kernel30add_joint_drive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_10]
  rd41 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:48 ld.param.u64 %rd42, [_ZN7synreal6kernel30add_joint_drive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_11]
  rd42 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:49 ld.param.u64 %rd43, [_ZN7synreal6kernel30add_joint_drive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_12]
  rd43 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:50 ld.param.u64 %rd44, [_ZN7synreal6kernel30add_joint_drive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_13]
  rd44 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:51 ld.param.u64 %rd45, [_ZN7synreal6kernel30add_joint_drive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_14]
  rd45 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:52 ld.param.u64 %rd46, [_ZN7synreal6kernel30add_joint_drive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_15]
  rd46 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param15 + (0))));
  // PTX:53 ld.param.f32 %f71, [_ZN7synreal6kernel30add_joint_drive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_16]
  f71 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param16 + (0))));
  // PTX:54 ld.param.u64 %rd51, [_ZN7synreal6kernel30add_joint_drive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_17]
  rd51 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param17 + (0))));
  // PTX:55 ld.param.u64 %rd52, [_ZN7synreal6kernel30add_joint_drive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_18]
  rd52 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param18 + (0))));
  // PTX:56 ld.param.u64 %rd47, [_ZN7synreal6kernel30add_joint_drive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_19]
  rd47 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param19 + (0))));
  // PTX:57 ld.param.u64 %rd48, [_ZN7synreal6kernel30add_joint_drive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_20]
  rd48 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param20 + (0))));
  // PTX:58 cvta.to.global.u64 %rd1, %rd51
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd51));
  // PTX:59 cvta.to.global.u64 %rd2, %rd49
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd49));
  // PTX:60 cvta.to.global.u64 %rd3, %rd50
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd50));
  // PTX:61 mov.u32 %r24, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r24) : "r"(blockIdx.x));
  // PTX:62 mov.u32 %r25, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r25) : "r"(blockDim.x));
  // PTX:63 mul.wide.u32 %rd53, %r24, %r25
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd53) : "r"(r24), "r"(r25));
  // PTX:64 mov.u32 %r26, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r26) : "r"(threadIdx.x));
  // PTX:65 cvt.u64.u32 %rd54, %r26
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd54) : "r"(r26));
  // PTX:66 add.s64 %rd4, %rd53, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd4) : "l"(rd53), "l"(rd54));
  // PTX:67 setp.ge.u64 %p1, %rd4, %rd52
  p1 = (((unsigned long long)(rd4)) >= ((unsigned long long)(rd52)));
  // PTX:68 @%p1 bra $L__BB58_28
  if (p1) { goto L_BB58_28; }
  // PTX:70 or.b64 %rd55, %rd4, %rd47
  asm("or.b64 %0, %1, %2;" : "=l"(rd55) : "l"(rd4), "l"(rd47));
  // PTX:71 and.b64 %rd56, %rd55, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd56) : "l"(rd55));
  // PTX:72 setp.eq.s64 %p2, %rd56, 0
  p2 = (((long long)(rd56)) == ((long long)(0)));
  // PTX:73 @%p2 bra $L__BB58_3
  if (p2) { goto L_BB58_3; }
  // PTX:75 div.u64 %rd273, %rd4, %rd47
  asm("div.u64 %0, %1, %2;" : "=l"(rd273) : "l"(rd4), "l"(rd47));
  // PTX:76 mul.lo.s64 %rd57, %rd273, %rd47
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd57) : "l"(rd273), "l"(rd47));
  // PTX:77 sub.s64 %rd274, %rd4, %rd57
  asm("sub.s64 %0, %1, %2;" : "=l"(rd274) : "l"(rd4), "l"(rd57));
  // PTX:78 bra.uni $L__BB58_4
  goto L_BB58_4;
  // PTX:80 $L__BB58_3:
L_BB58_3:;
  // PTX:81 cvt.u32.u64 %r27, %rd47
  asm("cvt.u32.u64 %0, %1;" : "=r"(r27) : "l"(rd47));
  // PTX:82 cvt.u32.u64 %r28, %rd4
  asm("cvt.u32.u64 %0, %1;" : "=r"(r28) : "l"(rd4));
  // PTX:83 div.u32 %r29, %r28, %r27
  asm("div.u32 %0, %1, %2;" : "=r"(r29) : "r"(r28), "r"(r27));
  // PTX:84 mul.lo.s32 %r30, %r29, %r27
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r30) : "r"(r29), "r"(r27));
  // PTX:85 sub.s32 %r31, %r28, %r30
  asm("sub.s32 %0, %1, %2;" : "=r"(r31) : "r"(r28), "r"(r30));
  // PTX:86 cvt.u64.u32 %rd273, %r29
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd273) : "r"(r29));
  // PTX:87 cvt.u64.u32 %rd274, %r31
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd274) : "r"(r31));
  // PTX:89 $L__BB58_4:
L_BB58_4:;
  // PTX:90 mul.lo.s64 %rd62, %rd273, %rd48
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd62) : "l"(rd273), "l"(rd48));
  // PTX:91 cvt.u32.u64 %r1, %rd62
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd62));
  // PTX:92 cvta.to.global.u64 %rd63, %rd34
  rd63 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd34));
  // PTX:93 shl.b64 %rd64, %rd274, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd64) : "l"(rd274));
  // PTX:94 add.s64 %rd65, %rd63, %rd64
  asm("add.s64 %0, %1, %2;" : "=l"(rd65) : "l"(rd63), "l"(rd64));
  // PTX:95 ld.global.s32 %rd11, [%rd65]
  rd11 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (0)))));
  // PTX:96 mov.u64 %rd275, 0
  asm("mov.u64 %0, 0;" : "=l"(rd275) : );
  // PTX:97 ld.global.u32 %r32, [%rd65+4]
  r32 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (4)))));
  // PTX:98 mul.wide.s32 %rd66, %r32, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd66) : "r"(r32));
  // PTX:99 add.s64 %rd67, %rd3, %rd66
  asm("add.s64 %0, %1, %2;" : "=l"(rd67) : "l"(rd3), "l"(rd66));
  // PTX:100 ld.global.u32 %r33, [%rd67]
  r33 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0)))));
  // PTX:101 add.s32 %r2, %r33, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r2) : "r"(r33), "r"(r1));
  // PTX:102 ld.global.u32 %r34, [%rd67+4]
  r34 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (4)))));
  // PTX:103 add.s32 %r3, %r34, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r3) : "r"(r34), "r"(r1));
  // PTX:104 ld.global.u32 %r35, [%rd67+8]
  r35 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (8)))));
  // PTX:105 add.s32 %r4, %r35, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r4) : "r"(r35), "r"(r1));
  // PTX:106 ld.global.u32 %r36, [%rd67+12]
  r36 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (12)))));
  // PTX:107 add.s32 %r5, %r36, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r5) : "r"(r36), "r"(r1));
  // PTX:108 cvta.to.global.u64 %rd68, %rd35
  rd68 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd35));
  // PTX:109 mul.lo.s64 %rd69, %rd274, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd69) : "l"(rd274));
  // PTX:110 add.s64 %rd70, %rd68, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd70) : "l"(rd68), "l"(rd69));
  // PTX:111 ld.global.f32 %f775, [%rd70]
  f775 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0)))));
  // PTX:112 ld.global.f32 %f776, [%rd70+4]
  f776 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (4)))));
  // PTX:113 ld.global.f32 %f777, [%rd70+8]
  f777 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (8)))));
  // PTX:114 cvta.to.global.u64 %rd71, %rd36
  rd71 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd36));
  // PTX:115 add.s64 %rd72, %rd71, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd72) : "l"(rd71), "l"(rd69));
  // PTX:116 ld.global.f32 %f772, [%rd72]
  f772 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (0)))));
  // PTX:117 ld.global.f32 %f773, [%rd72+4]
  f773 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (4)))));
  // PTX:118 ld.global.f32 %f774, [%rd72+8]
  f774 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (8)))));
  // PTX:119 cvta.to.global.u64 %rd73, %rd37
  rd73 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd37));
  // PTX:120 add.s64 %rd74, %rd73, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd74) : "l"(rd73), "l"(rd69));
  // PTX:121 ld.global.u32 %r56, [%rd74+8]
  r56 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (8)))));
  // PTX:122 ld.global.u32 %r55, [%rd74+4]
  r55 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (4)))));
  // PTX:123 ld.global.u32 %r54, [%rd74]
  r54 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (0)))));
  // PTX:124 setp.lt.s64 %p3, %rd11, 0
  p3 = (((long long)(rd11)) < ((long long)(0)));
  // PTX:125 cvta.to.global.u64 %rd75, %rd38
  rd75 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd38));
  // PTX:126 shl.b64 %rd76, %rd274, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd76) : "l"(rd274));
  // PTX:127 add.s64 %rd12, %rd75, %rd76
  asm("add.s64 %0, %1, %2;" : "=l"(rd12) : "l"(rd75), "l"(rd76));
  // PTX:128 cvta.to.global.u64 %rd77, %rd40
  rd77 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd40));
  // PTX:129 add.s64 %rd13, %rd77, %rd76
  asm("add.s64 %0, %1, %2;" : "=l"(rd13) : "l"(rd77), "l"(rd76));
  // PTX:130 cvta.to.global.u64 %rd78, %rd41
  rd78 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd41));
  // PTX:131 add.s64 %rd14, %rd78, %rd76
  asm("add.s64 %0, %1, %2;" : "=l"(rd14) : "l"(rd78), "l"(rd76));
  // PTX:132 mov.u64 %rd276, %rd275
  asm("mov.u64 %0, %1;" : "=l"(rd276) : "l"(rd275));
  // PTX:133 mov.u64 %rd277, %rd275
  asm("mov.u64 %0, %1;" : "=l"(rd277) : "l"(rd275));
  // PTX:134 mov.u64 %rd278, %rd275
  asm("mov.u64 %0, %1;" : "=l"(rd278) : "l"(rd275));
  // PTX:135 @%p3 bra $L__BB58_6
  if (p3) { goto L_BB58_6; }
  // PTX:137 shl.b64 %rd79, %rd11, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd79) : "l"(rd11));
  // PTX:138 add.s64 %rd80, %rd3, %rd79
  asm("add.s64 %0, %1, %2;" : "=l"(rd80) : "l"(rd3), "l"(rd79));
  // PTX:139 ld.global.u32 %r37, [%rd80]
  r37 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (0)))));
  // PTX:140 add.s32 %r38, %r37, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r38) : "r"(r37), "r"(r1));
  // PTX:141 ld.global.u32 %r39, [%rd80+4]
  r39 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (4)))));
  // PTX:142 add.s32 %r40, %r39, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r40) : "r"(r39), "r"(r1));
  // PTX:143 ld.global.u32 %r41, [%rd80+8]
  r41 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (8)))));
  // PTX:144 add.s32 %r42, %r41, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r42) : "r"(r41), "r"(r1));
  // PTX:145 ld.global.u32 %r43, [%rd80+12]
  r43 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (12)))));
  // PTX:146 add.s32 %r44, %r43, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r44) : "r"(r43), "r"(r1));
  // PTX:147 cvt.s64.s32 %rd275, %r38
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd275) : "r"(r38));
  // PTX:148 mul.wide.s32 %rd81, %r38, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd81) : "r"(r38));
  // PTX:149 add.s64 %rd82, %rd2, %rd81
  asm("add.s64 %0, %1, %2;" : "=l"(rd82) : "l"(rd2), "l"(rd81));
  // PTX:150 ld.global.f32 %f72, [%rd82]
  f72 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (0)))));
  // PTX:151 ld.global.f32 %f73, [%rd12]
  f73 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (0)))));
  // PTX:152 ld.global.f32 %f74, [%rd82+4]
  f74 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (4)))));
  // PTX:153 ld.global.f32 %f75, [%rd82+8]
  f75 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (8)))));
  // PTX:154 cvt.s64.s32 %rd276, %r40
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd276) : "r"(r40));
  // PTX:155 mul.wide.s32 %rd83, %r40, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd83) : "r"(r40));
  // PTX:156 add.s64 %rd84, %rd2, %rd83
  asm("add.s64 %0, %1, %2;" : "=l"(rd84) : "l"(rd2), "l"(rd83));
  // PTX:157 ld.global.f32 %f76, [%rd84]
  f76 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (0)))));
  // PTX:158 ld.global.f32 %f77, [%rd12+4]
  f77 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (4)))));
  // PTX:159 mul.f32 %f78, %f77, %f76
  asm("mul.f32 %0, %1, %2;" : "=f"(f78) : "f"(f77), "f"(f76));
  // PTX:160 ld.global.f32 %f79, [%rd84+4]
  f79 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (4)))));
  // PTX:161 mul.f32 %f80, %f77, %f79
  asm("mul.f32 %0, %1, %2;" : "=f"(f80) : "f"(f77), "f"(f79));
  // PTX:162 ld.global.f32 %f81, [%rd84+8]
  f81 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (8)))));
  // PTX:163 mul.f32 %f82, %f77, %f81
  asm("mul.f32 %0, %1, %2;" : "=f"(f82) : "f"(f77), "f"(f81));
  // PTX:164 fma.rn.f32 %f83, %f73, %f72, %f78
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f83) : "f"(f73), "f"(f72), "f"(f78));
  // PTX:165 fma.rn.f32 %f84, %f73, %f74, %f80
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f84) : "f"(f73), "f"(f74), "f"(f80));
  // PTX:166 fma.rn.f32 %f85, %f73, %f75, %f82
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f85) : "f"(f73), "f"(f75), "f"(f82));
  // PTX:167 cvt.s64.s32 %rd277, %r42
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd277) : "r"(r42));
  // PTX:168 mul.wide.s32 %rd85, %r42, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd85) : "r"(r42));
  // PTX:169 add.s64 %rd86, %rd2, %rd85
  asm("add.s64 %0, %1, %2;" : "=l"(rd86) : "l"(rd2), "l"(rd85));
  // PTX:170 ld.global.f32 %f86, [%rd86]
  f86 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd86) + (0)))));
  // PTX:171 ld.global.f32 %f87, [%rd12+8]
  f87 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (8)))));
  // PTX:172 ld.global.f32 %f88, [%rd86+4]
  f88 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd86) + (4)))));
  // PTX:173 ld.global.f32 %f89, [%rd86+8]
  f89 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd86) + (8)))));
  // PTX:174 fma.rn.f32 %f90, %f87, %f86, %f83
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f90) : "f"(f87), "f"(f86), "f"(f83));
  // PTX:175 fma.rn.f32 %f91, %f87, %f88, %f84
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f91) : "f"(f87), "f"(f88), "f"(f84));
  // PTX:176 fma.rn.f32 %f92, %f87, %f89, %f85
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f92) : "f"(f87), "f"(f89), "f"(f85));
  // PTX:177 cvt.s64.s32 %rd278, %r44
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd278) : "r"(r44));
  // PTX:178 mul.wide.s32 %rd87, %r44, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd87) : "r"(r44));
  // PTX:179 add.s64 %rd88, %rd2, %rd87
  asm("add.s64 %0, %1, %2;" : "=l"(rd88) : "l"(rd2), "l"(rd87));
  // PTX:180 ld.global.f32 %f93, [%rd88]
  f93 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (0)))));
  // PTX:181 ld.global.f32 %f94, [%rd12+12]
  f94 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (12)))));
  // PTX:182 ld.global.f32 %f95, [%rd88+4]
  f95 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (4)))));
  // PTX:183 ld.global.f32 %f96, [%rd88+8]
  f96 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (8)))));
  // PTX:184 fma.rn.f32 %f775, %f94, %f93, %f90
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f775) : "f"(f94), "f"(f93), "f"(f90));
  // PTX:185 fma.rn.f32 %f776, %f94, %f95, %f91
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f776) : "f"(f94), "f"(f95), "f"(f91));
  // PTX:186 fma.rn.f32 %f777, %f94, %f96, %f92
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f777) : "f"(f94), "f"(f96), "f"(f92));
  // PTX:187 ld.global.f32 %f97, [%rd13]
  f97 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))));
  // PTX:188 ld.global.f32 %f98, [%rd13+4]
  f98 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4)))));
  // PTX:189 mul.f32 %f99, %f98, %f76
  asm("mul.f32 %0, %1, %2;" : "=f"(f99) : "f"(f98), "f"(f76));
  // PTX:190 mul.f32 %f100, %f98, %f79
  asm("mul.f32 %0, %1, %2;" : "=f"(f100) : "f"(f98), "f"(f79));
  // PTX:191 mul.f32 %f101, %f98, %f81
  asm("mul.f32 %0, %1, %2;" : "=f"(f101) : "f"(f98), "f"(f81));
  // PTX:192 fma.rn.f32 %f102, %f97, %f72, %f99
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f102) : "f"(f97), "f"(f72), "f"(f99));
  // PTX:193 fma.rn.f32 %f103, %f97, %f74, %f100
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f103) : "f"(f97), "f"(f74), "f"(f100));
  // PTX:194 fma.rn.f32 %f104, %f97, %f75, %f101
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f104) : "f"(f97), "f"(f75), "f"(f101));
  // PTX:195 ld.global.f32 %f105, [%rd13+8]
  f105 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8)))));
  // PTX:196 fma.rn.f32 %f106, %f105, %f86, %f102
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f106) : "f"(f105), "f"(f86), "f"(f102));
  // PTX:197 fma.rn.f32 %f107, %f105, %f88, %f103
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f107) : "f"(f105), "f"(f88), "f"(f103));
  // PTX:198 fma.rn.f32 %f108, %f105, %f89, %f104
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f108) : "f"(f105), "f"(f89), "f"(f104));
  // PTX:199 ld.global.f32 %f109, [%rd13+12]
  f109 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (12)))));
  // PTX:200 fma.rn.f32 %f772, %f109, %f93, %f106
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f772) : "f"(f109), "f"(f93), "f"(f106));
  // PTX:201 fma.rn.f32 %f773, %f109, %f95, %f107
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f773) : "f"(f109), "f"(f95), "f"(f107));
  // PTX:202 fma.rn.f32 %f774, %f109, %f96, %f108
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f774) : "f"(f109), "f"(f96), "f"(f108));
  // PTX:203 ld.global.f32 %f110, [%rd14]
  f110 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:204 ld.global.f32 %f111, [%rd14+4]
  f111 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (4)))));
  // PTX:205 mul.f32 %f112, %f111, %f76
  asm("mul.f32 %0, %1, %2;" : "=f"(f112) : "f"(f111), "f"(f76));
  // PTX:206 mul.f32 %f113, %f111, %f79
  asm("mul.f32 %0, %1, %2;" : "=f"(f113) : "f"(f111), "f"(f79));
  // PTX:207 mul.f32 %f114, %f111, %f81
  asm("mul.f32 %0, %1, %2;" : "=f"(f114) : "f"(f111), "f"(f81));
  // PTX:208 fma.rn.f32 %f115, %f110, %f72, %f112
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f115) : "f"(f110), "f"(f72), "f"(f112));
  // PTX:209 fma.rn.f32 %f116, %f110, %f74, %f113
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f116) : "f"(f110), "f"(f74), "f"(f113));
  // PTX:210 fma.rn.f32 %f117, %f110, %f75, %f114
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f117) : "f"(f110), "f"(f75), "f"(f114));
  // PTX:211 ld.global.f32 %f118, [%rd14+8]
  f118 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (8)))));
  // PTX:212 fma.rn.f32 %f119, %f118, %f86, %f115
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f119) : "f"(f118), "f"(f86), "f"(f115));
  // PTX:213 fma.rn.f32 %f120, %f118, %f88, %f116
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f120) : "f"(f118), "f"(f88), "f"(f116));
  // PTX:214 fma.rn.f32 %f121, %f118, %f89, %f117
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f121) : "f"(f118), "f"(f89), "f"(f117));
  // PTX:215 ld.global.f32 %f122, [%rd14+12]
  f122 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (12)))));
  // PTX:216 fma.rn.f32 %f123, %f122, %f93, %f119
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f123) : "f"(f122), "f"(f93), "f"(f119));
  // PTX:217 fma.rn.f32 %f124, %f122, %f95, %f120
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f124) : "f"(f122), "f"(f95), "f"(f120));
  // PTX:218 fma.rn.f32 %f125, %f122, %f96, %f121
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f125) : "f"(f122), "f"(f96), "f"(f121));
  // PTX:219 mov.b32 %r56, %f125
  asm("mov.b32 %0, %1;" : "=r"(r56) : "f"(f125));
  // PTX:220 mov.b32 %r55, %f124
  asm("mov.b32 %0, %1;" : "=r"(r55) : "f"(f124));
  // PTX:221 mov.b32 %r54, %f123
  asm("mov.b32 %0, %1;" : "=r"(r54) : "f"(f123));
  // PTX:223 $L__BB58_6:
L_BB58_6:;
  // PTX:224 sub.f32 %f19, %f772, %f775
  asm("sub.f32 %0, %1, %2;" : "=f"(f19) : "f"(f772), "f"(f775));
  // PTX:225 sub.f32 %f20, %f773, %f776
  asm("sub.f32 %0, %1, %2;" : "=f"(f20) : "f"(f773), "f"(f776));
  // PTX:226 mul.f32 %f126, %f20, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f126) : "f"(f20), "f"(f20));
  // PTX:227 sub.f32 %f21, %f774, %f777
  asm("sub.f32 %0, %1, %2;" : "=f"(f21) : "f"(f774), "f"(f777));
  // PTX:228 fma.rn.f32 %f127, %f19, %f19, %f126
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f127) : "f"(f19), "f"(f19), "f"(f126));
  // PTX:229 fma.rn.f32 %f128, %f21, %f21, %f127
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f128) : "f"(f21), "f"(f21), "f"(f127));
  // PTX:230 sqrt.rn.f32 %f22, %f128
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f22) : "f"(f128));
  // PTX:231 setp.leu.f32 %p4, %f22, 0f00000000
  p4 = ((isnan(((float)(f22))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f22)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:232 mov.u32 %r57, 0
  asm("mov.u32 %0, 0;" : "=r"(r57) : );
  // PTX:233 mov.u32 %r58, %r57
  asm("mov.u32 %0, %1;" : "=r"(r58) : "r"(r57));
  // PTX:234 mov.u32 %r59, %r57
  asm("mov.u32 %0, %1;" : "=r"(r59) : "r"(r57));
  // PTX:235 @%p4 bra $L__BB58_8
  if (p4) { goto L_BB58_8; }
  // PTX:237 div.rn.f32 %f129, %f19, %f22
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f129) : "f"(f19), "f"(f22));
  // PTX:238 div.rn.f32 %f130, %f20, %f22
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f130) : "f"(f20), "f"(f22));
  // PTX:239 div.rn.f32 %f131, %f21, %f22
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f131) : "f"(f21), "f"(f22));
  // PTX:240 mov.b32 %r59, %f131
  asm("mov.b32 %0, %1;" : "=r"(r59) : "f"(f131));
  // PTX:241 mov.b32 %r58, %f130
  asm("mov.b32 %0, %1;" : "=r"(r58) : "f"(f130));
  // PTX:242 mov.b32 %r57, %f129
  asm("mov.b32 %0, %1;" : "=r"(r57) : "f"(f129));
  // PTX:244 $L__BB58_8:
L_BB58_8:;
  // PTX:245 mov.b32 %f23, %r57
  asm("mov.b32 %0, %1;" : "=f"(f23) : "r"(r57));
  // PTX:246 mov.b32 %f24, %r58
  asm("mov.b32 %0, %1;" : "=f"(f24) : "r"(r58));
  // PTX:247 mul.f32 %f132, %f24, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f132) : "f"(f24), "f"(f24));
  // PTX:248 mov.b32 %f25, %r59
  asm("mov.b32 %0, %1;" : "=f"(f25) : "r"(r59));
  // PTX:249 fma.rn.f32 %f133, %f23, %f23, %f132
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f133) : "f"(f23), "f"(f23), "f"(f132));
  // PTX:250 fma.rn.f32 %f134, %f25, %f25, %f133
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f134) : "f"(f25), "f"(f25), "f"(f133));
  // PTX:251 sqrt.rn.f32 %f135, %f134
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f135) : "f"(f134));
  // PTX:252 setp.le.f32 %p5, %f135, 0f322BCC77
  p5 = (!(isnan(((float)(f135))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f135)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:253 @%p5 bra $L__BB58_28
  if (p5) { goto L_BB58_28; }
  // PTX:255 cvta.to.global.u64 %rd89, %rd43
  rd89 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd43));
  // PTX:256 shl.b64 %rd90, %rd274, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd90) : "l"(rd274));
  // PTX:257 add.s64 %rd91, %rd89, %rd90
  asm("add.s64 %0, %1, %2;" : "=l"(rd91) : "l"(rd89), "l"(rd90));
  // PTX:258 ld.global.s32 %rd23, [%rd91]
  rd23 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (0)))));
  // PTX:259 setp.eq.s64 %p6, %rd44, 0
  p6 = (((long long)(rd44)) == ((long long)(0)));
  // PTX:260 @%p6 bra $L__BB58_11
  if (p6) { goto L_BB58_11; }
  // PTX:262 cvta.to.global.u64 %rd92, %rd44
  rd92 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd44));
  // PTX:263 shl.b64 %rd93, %rd23, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd93) : "l"(rd23));
  // PTX:264 add.s64 %rd94, %rd92, %rd93
  asm("add.s64 %0, %1, %2;" : "=l"(rd94) : "l"(rd92), "l"(rd93));
  // PTX:265 ld.global.u32 %r48, [%rd94]
  r48 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd94) + (0)))));
  // PTX:266 add.s32 %r49, %r48, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r49) : "r"(r48));
  // PTX:267 setp.lt.u32 %p7, %r49, 3
  p7 = (((unsigned)(r49)) < ((unsigned)(3)));
  // PTX:268 mov.f32 %f778, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f778) : );
  // PTX:269 @%p7 bra $L__BB58_11
  if (p7) { goto L_BB58_11; }
  // PTX:270 bra.uni $L__BB58_12
  goto L_BB58_12;
  // PTX:272 $L__BB58_11:
L_BB58_11:;
  // PTX:273 cvt.u32.u64 %r50, %rd23
  asm("cvt.u32.u64 %0, %1;" : "=r"(r50) : "l"(rd23));
  // PTX:274 cvta.to.global.u64 %rd95, %rd46
  rd95 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd46));
  // PTX:275 mul.wide.s32 %rd96, %r50, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd96) : "r"(r50));
  // PTX:276 add.s64 %rd97, %rd95, %rd96
  asm("add.s64 %0, %1, %2;" : "=l"(rd97) : "l"(rd95), "l"(rd96));
  // PTX:277 ld.global.f32 %f778, [%rd97]
  f778 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd97) + (0)))));
  // PTX:279 $L__BB58_12:
L_BB58_12:;
  // PTX:280 setp.eq.s64 %p8, %rd45, 0
  p8 = (((long long)(rd45)) == ((long long)(0)));
  // PTX:281 mov.f32 %f779, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f779) : );
  // PTX:282 @%p8 bra $L__BB58_14
  if (p8) { goto L_BB58_14; }
  // PTX:284 cvta.to.global.u64 %rd98, %rd45
  rd98 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd45));
  // PTX:285 shl.b64 %rd99, %rd23, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd99) : "l"(rd23));
  // PTX:286 add.s64 %rd100, %rd98, %rd99
  asm("add.s64 %0, %1, %2;" : "=l"(rd100) : "l"(rd98), "l"(rd99));
  // PTX:287 ld.global.f32 %f779, [%rd100]
  f779 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (0)))));
  // PTX:289 $L__BB58_14:
L_BB58_14:;
  // PTX:290 add.f32 %f138, %f778, %f779
  asm("add.f32 %0, %1, %2;" : "=f"(f138) : "f"(f778), "f"(f779));
  // PTX:291 mul.f32 %f30, %f138, %f71
  asm("mul.f32 %0, %1, %2;" : "=f"(f30) : "f"(f138), "f"(f71));
  // PTX:292 setp.leu.f32 %p9, %f30, 0f00000000
  p9 = ((isnan(((float)(f30))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f30)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:293 @%p9 bra $L__BB58_28
  if (p9) { goto L_BB58_28; }
  // PTX:295 abs.f32 %f139, %f30
  asm("abs.f32 %0, %1;" : "=f"(f139) : "f"(f30));
  // PTX:296 setp.geu.f32 %p10, %f139, 0f7F800000
  p10 = ((isnan(((float)(f139))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f139)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:297 @%p10 bra $L__BB58_28
  if (p10) { goto L_BB58_28; }
  // PTX:299 cvta.to.global.u64 %rd101, %rd33
  rd101 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd33));
  // PTX:300 add.s64 %rd103, %rd101, %rd90
  asm("add.s64 %0, %1, %2;" : "=l"(rd103) : "l"(rd101), "l"(rd90));
  // PTX:301 ld.global.u32 %r51, [%rd103]
  r51 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd103) + (0)))));
  // PTX:302 setp.eq.s32 %p11, %r51, 0
  p11 = (((int)(r51)) == ((int)(0)));
  // PTX:303 cvta.to.global.u64 %rd104, %rd39
  rd104 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd39));
  // PTX:304 add.s64 %rd24, %rd104, %rd76
  asm("add.s64 %0, %1, %2;" : "=l"(rd24) : "l"(rd104), "l"(rd76));
  // PTX:305 ld.global.f32 %f31, [%rd24]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (0)))));
  // PTX:306 ld.global.f32 %f32, [%rd24+4]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (4)))));
  // PTX:307 ld.global.f32 %f33, [%rd24+8]
  f33 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (8)))));
  // PTX:308 ld.global.f32 %f34, [%rd24+12]
  f34 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (12)))));
  // PTX:309 cvt.s64.s32 %rd25, %r2
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd25) : "r"(r2));
  // PTX:310 mul.wide.s32 %rd106, %r2, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd106) : "r"(r2));
  // PTX:311 add.s64 %rd26, %rd2, %rd106
  asm("add.s64 %0, %1, %2;" : "=l"(rd26) : "l"(rd2), "l"(rd106));
  // PTX:312 cvt.s64.s32 %rd27, %r3
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd27) : "r"(r3));
  // PTX:313 mul.wide.s32 %rd107, %r3, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd107) : "r"(r3));
  // PTX:314 add.s64 %rd28, %rd2, %rd107
  asm("add.s64 %0, %1, %2;" : "=l"(rd28) : "l"(rd2), "l"(rd107));
  // PTX:315 cvt.s64.s32 %rd29, %r4
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd29) : "r"(r4));
  // PTX:316 mul.wide.s32 %rd108, %r4, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd108) : "r"(r4));
  // PTX:317 add.s64 %rd30, %rd2, %rd108
  asm("add.s64 %0, %1, %2;" : "=l"(rd30) : "l"(rd2), "l"(rd108));
  // PTX:318 cvt.s64.s32 %rd31, %r5
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd31) : "r"(r5));
  // PTX:319 mul.wide.s32 %rd109, %r5, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd109) : "r"(r5));
  // PTX:320 add.s64 %rd32, %rd2, %rd109
  asm("add.s64 %0, %1, %2;" : "=l"(rd32) : "l"(rd2), "l"(rd109));
  // PTX:321 @%p11 bra $L__BB58_26
  if (p11) { goto L_BB58_26; }
  // PTX:323 ld.global.f32 %f140, [%rd26]
  f140 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (0)))));
  // PTX:324 ld.global.f32 %f141, [%rd26+4]
  f141 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (4)))));
  // PTX:325 ld.global.f32 %f142, [%rd26+8]
  f142 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (8)))));
  // PTX:326 ld.global.f32 %f143, [%rd28]
  f143 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (0)))));
  // PTX:327 mul.f32 %f144, %f143, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f144) : "f"(f143), "f"(f32));
  // PTX:328 ld.global.f32 %f145, [%rd28+4]
  f145 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (4)))));
  // PTX:329 mul.f32 %f146, %f145, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f146) : "f"(f145), "f"(f32));
  // PTX:330 ld.global.f32 %f147, [%rd28+8]
  f147 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (8)))));
  // PTX:331 mul.f32 %f148, %f147, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f148) : "f"(f147), "f"(f32));
  // PTX:332 fma.rn.f32 %f149, %f140, %f31, %f144
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f149) : "f"(f140), "f"(f31), "f"(f144));
  // PTX:333 fma.rn.f32 %f150, %f141, %f31, %f146
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f150) : "f"(f141), "f"(f31), "f"(f146));
  // PTX:334 fma.rn.f32 %f151, %f142, %f31, %f148
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f151) : "f"(f142), "f"(f31), "f"(f148));
  // PTX:335 ld.global.f32 %f152, [%rd30]
  f152 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0)))));
  // PTX:336 ld.global.f32 %f153, [%rd30+4]
  f153 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (4)))));
  // PTX:337 ld.global.f32 %f154, [%rd30+8]
  f154 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (8)))));
  // PTX:338 fma.rn.f32 %f155, %f152, %f33, %f149
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f155) : "f"(f152), "f"(f33), "f"(f149));
  // PTX:339 fma.rn.f32 %f156, %f153, %f33, %f150
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f156) : "f"(f153), "f"(f33), "f"(f150));
  // PTX:340 fma.rn.f32 %f157, %f154, %f33, %f151
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f157) : "f"(f154), "f"(f33), "f"(f151));
  // PTX:341 ld.global.f32 %f158, [%rd32]
  f158 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (0)))));
  // PTX:342 ld.global.f32 %f159, [%rd32+4]
  f159 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (4)))));
  // PTX:343 ld.global.f32 %f160, [%rd32+8]
  f160 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (8)))));
  // PTX:344 fma.rn.f32 %f35, %f158, %f34, %f155
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f35) : "f"(f158), "f"(f34), "f"(f155));
  // PTX:345 fma.rn.f32 %f36, %f159, %f34, %f156
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f36) : "f"(f159), "f"(f34), "f"(f156));
  // PTX:346 fma.rn.f32 %f37, %f160, %f34, %f157
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f37) : "f"(f160), "f"(f34), "f"(f157));
  // PTX:347 cvta.to.global.u64 %rd110, %rd42
  rd110 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd42));
  // PTX:348 add.s64 %rd112, %rd110, %rd76
  asm("add.s64 %0, %1, %2;" : "=l"(rd112) : "l"(rd110), "l"(rd76));
  // PTX:349 ld.global.f32 %f38, [%rd112]
  f38 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd112) + (0)))));
  // PTX:350 ld.global.f32 %f39, [%rd112+4]
  f39 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd112) + (4)))));
  // PTX:351 mul.f32 %f161, %f39, %f143
  asm("mul.f32 %0, %1, %2;" : "=f"(f161) : "f"(f39), "f"(f143));
  // PTX:352 mul.f32 %f162, %f39, %f145
  asm("mul.f32 %0, %1, %2;" : "=f"(f162) : "f"(f39), "f"(f145));
  // PTX:353 mul.f32 %f163, %f39, %f147
  asm("mul.f32 %0, %1, %2;" : "=f"(f163) : "f"(f39), "f"(f147));
  // PTX:354 fma.rn.f32 %f164, %f38, %f140, %f161
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f164) : "f"(f38), "f"(f140), "f"(f161));
  // PTX:355 fma.rn.f32 %f165, %f38, %f141, %f162
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f165) : "f"(f38), "f"(f141), "f"(f162));
  // PTX:356 fma.rn.f32 %f166, %f38, %f142, %f163
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f166) : "f"(f38), "f"(f142), "f"(f163));
  // PTX:357 ld.global.f32 %f40, [%rd112+8]
  f40 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd112) + (8)))));
  // PTX:358 fma.rn.f32 %f167, %f40, %f152, %f164
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f167) : "f"(f40), "f"(f152), "f"(f164));
  // PTX:359 fma.rn.f32 %f168, %f40, %f153, %f165
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f168) : "f"(f40), "f"(f153), "f"(f165));
  // PTX:360 fma.rn.f32 %f169, %f40, %f154, %f166
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f169) : "f"(f40), "f"(f154), "f"(f166));
  // PTX:361 ld.global.f32 %f41, [%rd112+12]
  f41 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd112) + (12)))));
  // PTX:362 fma.rn.f32 %f42, %f41, %f158, %f167
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f42) : "f"(f41), "f"(f158), "f"(f167));
  // PTX:363 fma.rn.f32 %f43, %f41, %f159, %f168
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f43) : "f"(f41), "f"(f159), "f"(f168));
  // PTX:364 fma.rn.f32 %f44, %f41, %f160, %f169
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f44) : "f"(f41), "f"(f160), "f"(f169));
  // PTX:365 setp.leu.f32 %p12, %f22, 0f322BCC77
  p12 = ((isnan(((float)(f22))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f22)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:366 @%p12 bra $L__BB58_28
  if (p12) { goto L_BB58_28; }
  // PTX:368 abs.f32 %f170, %f22
  asm("abs.f32 %0, %1;" : "=f"(f170) : "f"(f22));
  // PTX:369 setp.geu.f32 %p13, %f170, 0f7F800000
  p13 = ((isnan(((float)(f170))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f170)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:370 @%p13 bra $L__BB58_28
  if (p13) { goto L_BB58_28; }
  // PTX:372 div.rn.f32 %f45, %f19, %f22
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f45) : "f"(f19), "f"(f22));
  // PTX:373 mov.b32 %f171, %r54
  asm("mov.b32 %0, %1;" : "=f"(f171) : "r"(r54));
  // PTX:374 sub.f32 %f172, %f171, %f775
  asm("sub.f32 %0, %1, %2;" : "=f"(f172) : "f"(f171), "f"(f775));
  // PTX:375 mov.b32 %f173, %r55
  asm("mov.b32 %0, %1;" : "=f"(f173) : "r"(r55));
  // PTX:376 sub.f32 %f174, %f173, %f776
  asm("sub.f32 %0, %1, %2;" : "=f"(f174) : "f"(f173), "f"(f776));
  // PTX:377 mov.b32 %f175, %r56
  asm("mov.b32 %0, %1;" : "=f"(f175) : "r"(r56));
  // PTX:378 sub.f32 %f176, %f175, %f777
  asm("sub.f32 %0, %1, %2;" : "=f"(f176) : "f"(f175), "f"(f777));
  // PTX:379 div.rn.f32 %f46, %f20, %f22
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f46) : "f"(f20), "f"(f22));
  // PTX:380 mul.f32 %f177, %f46, %f174
  asm("mul.f32 %0, %1, %2;" : "=f"(f177) : "f"(f46), "f"(f174));
  // PTX:381 div.rn.f32 %f47, %f21, %f22
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f47) : "f"(f21), "f"(f22));
  // PTX:382 fma.rn.f32 %f178, %f45, %f172, %f177
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f178) : "f"(f45), "f"(f172), "f"(f177));
  // PTX:383 fma.rn.f32 %f48, %f47, %f176, %f178
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f48) : "f"(f47), "f"(f176), "f"(f178));
  // PTX:384 mul.f32 %f179, %f45, %f48
  asm("mul.f32 %0, %1, %2;" : "=f"(f179) : "f"(f45), "f"(f48));
  // PTX:385 mul.f32 %f180, %f46, %f48
  asm("mul.f32 %0, %1, %2;" : "=f"(f180) : "f"(f46), "f"(f48));
  // PTX:386 mul.f32 %f181, %f47, %f48
  asm("mul.f32 %0, %1, %2;" : "=f"(f181) : "f"(f47), "f"(f48));
  // PTX:387 sub.f32 %f49, %f172, %f179
  asm("sub.f32 %0, %1, %2;" : "=f"(f49) : "f"(f172), "f"(f179));
  // PTX:388 sub.f32 %f50, %f174, %f180
  asm("sub.f32 %0, %1, %2;" : "=f"(f50) : "f"(f174), "f"(f180));
  // PTX:389 sub.f32 %f51, %f176, %f181
  asm("sub.f32 %0, %1, %2;" : "=f"(f51) : "f"(f176), "f"(f181));
  // PTX:390 sub.f32 %f182, %f42, %f35
  asm("sub.f32 %0, %1, %2;" : "=f"(f182) : "f"(f42), "f"(f35));
  // PTX:391 sub.f32 %f183, %f43, %f36
  asm("sub.f32 %0, %1, %2;" : "=f"(f183) : "f"(f43), "f"(f36));
  // PTX:392 mul.f32 %f184, %f46, %f183
  asm("mul.f32 %0, %1, %2;" : "=f"(f184) : "f"(f46), "f"(f183));
  // PTX:393 sub.f32 %f185, %f44, %f37
  asm("sub.f32 %0, %1, %2;" : "=f"(f185) : "f"(f44), "f"(f37));
  // PTX:394 fma.rn.f32 %f186, %f45, %f182, %f184
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f186) : "f"(f45), "f"(f182), "f"(f184));
  // PTX:395 fma.rn.f32 %f52, %f47, %f185, %f186
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f52) : "f"(f47), "f"(f185), "f"(f186));
  // PTX:396 mul.f32 %f187, %f45, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f187) : "f"(f45), "f"(f52));
  // PTX:397 mul.f32 %f188, %f46, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f188) : "f"(f46), "f"(f52));
  // PTX:398 mul.f32 %f189, %f47, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f189) : "f"(f47), "f"(f52));
  // PTX:399 sub.f32 %f53, %f182, %f187
  asm("sub.f32 %0, %1, %2;" : "=f"(f53) : "f"(f182), "f"(f187));
  // PTX:400 sub.f32 %f54, %f183, %f188
  asm("sub.f32 %0, %1, %2;" : "=f"(f54) : "f"(f183), "f"(f188));
  // PTX:401 sub.f32 %f55, %f185, %f189
  asm("sub.f32 %0, %1, %2;" : "=f"(f55) : "f"(f185), "f"(f189));
  // PTX:402 mul.f32 %f190, %f50, %f50
  asm("mul.f32 %0, %1, %2;" : "=f"(f190) : "f"(f50), "f"(f50));
  // PTX:403 fma.rn.f32 %f191, %f49, %f49, %f190
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f191) : "f"(f49), "f"(f49), "f"(f190));
  // PTX:404 fma.rn.f32 %f192, %f51, %f51, %f191
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f192) : "f"(f51), "f"(f51), "f"(f191));
  // PTX:405 sqrt.rn.f32 %f56, %f192
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f56) : "f"(f192));
  // PTX:406 mul.f32 %f193, %f54, %f54
  asm("mul.f32 %0, %1, %2;" : "=f"(f193) : "f"(f54), "f"(f54));
  // PTX:407 fma.rn.f32 %f194, %f53, %f53, %f193
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f194) : "f"(f53), "f"(f53), "f"(f193));
  // PTX:408 fma.rn.f32 %f195, %f55, %f55, %f194
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f195) : "f"(f55), "f"(f55), "f"(f194));
  // PTX:409 sqrt.rn.f32 %f57, %f195
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f57) : "f"(f195));
  // PTX:410 setp.leu.f32 %p14, %f56, 0f322BCC77
  p14 = ((isnan(((float)(f56))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f56)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:411 setp.leu.f32 %p15, %f57, 0f322BCC77
  p15 = ((isnan(((float)(f57))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f57)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:412 or.pred %p16, %p14, %p15
  p16 = ((p14) || (p15));
  // PTX:413 @%p16 bra $L__BB58_28
  if (p16) { goto L_BB58_28; }
  // PTX:415 abs.f32 %f196, %f56
  asm("abs.f32 %0, %1;" : "=f"(f196) : "f"(f56));
  // PTX:416 setp.geu.f32 %p17, %f196, 0f7F800000
  p17 = ((isnan(((float)(f196))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f196)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:417 @%p17 bra $L__BB58_28
  if (p17) { goto L_BB58_28; }
  // PTX:419 abs.f32 %f197, %f57
  asm("abs.f32 %0, %1;" : "=f"(f197) : "f"(f57));
  // PTX:420 setp.geu.f32 %p18, %f197, 0f7F800000
  p18 = ((isnan(((float)(f197))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f197)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:421 @%p18 bra $L__BB58_28
  if (p18) { goto L_BB58_28; }
  // PTX:423 div.rn.f32 %f58, %f49, %f56
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f58) : "f"(f49), "f"(f56));
  // PTX:424 div.rn.f32 %f59, %f55, %f57
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f59) : "f"(f55), "f"(f57));
  // PTX:425 div.rn.f32 %f60, %f50, %f56
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f60) : "f"(f50), "f"(f56));
  // PTX:426 mul.f32 %f198, %f60, %f59
  asm("mul.f32 %0, %1, %2;" : "=f"(f198) : "f"(f60), "f"(f59));
  // PTX:427 div.rn.f32 %f61, %f54, %f57
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f61) : "f"(f54), "f"(f57));
  // PTX:428 div.rn.f32 %f62, %f51, %f56
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f62) : "f"(f51), "f"(f56));
  // PTX:429 mul.f32 %f199, %f62, %f61
  asm("mul.f32 %0, %1, %2;" : "=f"(f199) : "f"(f62), "f"(f61));
  // PTX:430 sub.f32 %f200, %f198, %f199
  asm("sub.f32 %0, %1, %2;" : "=f"(f200) : "f"(f198), "f"(f199));
  // PTX:431 div.rn.f32 %f63, %f53, %f57
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f63) : "f"(f53), "f"(f57));
  // PTX:432 mul.f32 %f201, %f62, %f63
  asm("mul.f32 %0, %1, %2;" : "=f"(f201) : "f"(f62), "f"(f63));
  // PTX:433 mul.f32 %f202, %f58, %f59
  asm("mul.f32 %0, %1, %2;" : "=f"(f202) : "f"(f58), "f"(f59));
  // PTX:434 sub.f32 %f203, %f201, %f202
  asm("sub.f32 %0, %1, %2;" : "=f"(f203) : "f"(f201), "f"(f202));
  // PTX:435 mul.f32 %f204, %f58, %f61
  asm("mul.f32 %0, %1, %2;" : "=f"(f204) : "f"(f58), "f"(f61));
  // PTX:436 mul.f32 %f205, %f60, %f63
  asm("mul.f32 %0, %1, %2;" : "=f"(f205) : "f"(f60), "f"(f63));
  // PTX:437 sub.f32 %f206, %f204, %f205
  asm("sub.f32 %0, %1, %2;" : "=f"(f206) : "f"(f204), "f"(f205));
  // PTX:438 mul.f32 %f207, %f46, %f203
  asm("mul.f32 %0, %1, %2;" : "=f"(f207) : "f"(f46), "f"(f203));
  // PTX:439 fma.rn.f32 %f208, %f45, %f200, %f207
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f208) : "f"(f45), "f"(f200), "f"(f207));
  // PTX:440 fma.rn.f32 %f209, %f47, %f206, %f208
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f209) : "f"(f47), "f"(f206), "f"(f208));
  // PTX:441 mul.f32 %f210, %f60, %f61
  asm("mul.f32 %0, %1, %2;" : "=f"(f210) : "f"(f60), "f"(f61));
  // PTX:442 fma.rn.f32 %f211, %f58, %f63, %f210
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f211) : "f"(f58), "f"(f63), "f"(f210));
  // PTX:443 fma.rn.f32 %f212, %f62, %f59, %f211
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f212) : "f"(f62), "f"(f59), "f"(f211));
  // PTX:444 mul.f32 %f213, %f209, %f209
  asm("mul.f32 %0, %1, %2;" : "=f"(f213) : "f"(f209), "f"(f209));
  // PTX:445 fma.rn.f32 %f64, %f212, %f212, %f213
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f64) : "f"(f212), "f"(f212), "f"(f213));
  // PTX:446 setp.leu.f32 %p19, %f64, 0f2B8CBCCC
  p19 = ((isnan(((float)(f64))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) || (((float)(f64)) <= ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:447 @%p19 bra $L__BB58_28
  if (p19) { goto L_BB58_28; }
  // PTX:449 abs.f32 %f214, %f64
  asm("abs.f32 %0, %1;" : "=f"(f214) : "f"(f64));
  // PTX:450 setp.geu.f32 %p20, %f214, 0f7F800000
  p20 = ((isnan(((float)(f214))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f214)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:451 @%p20 bra $L__BB58_28
  if (p20) { goto L_BB58_28; }
  // PTX:453 cvt.u32.u64 %r52, %rd11
  asm("cvt.u32.u64 %0, %1;" : "=r"(r52) : "l"(rd11));
  // PTX:454 setp.lt.s32 %p21, %r52, 0
  p21 = (((int)(r52)) < ((int)(0)));
  // PTX:455 mul.f32 %f215, %f47, %f60
  asm("mul.f32 %0, %1, %2;" : "=f"(f215) : "f"(f47), "f"(f60));
  // PTX:456 mul.f32 %f216, %f46, %f62
  asm("mul.f32 %0, %1, %2;" : "=f"(f216) : "f"(f46), "f"(f62));
  // PTX:457 sub.f32 %f65, %f216, %f215
  asm("sub.f32 %0, %1, %2;" : "=f"(f65) : "f"(f216), "f"(f215));
  // PTX:458 mul.f32 %f217, %f45, %f62
  asm("mul.f32 %0, %1, %2;" : "=f"(f217) : "f"(f45), "f"(f62));
  // PTX:459 mul.f32 %f218, %f47, %f58
  asm("mul.f32 %0, %1, %2;" : "=f"(f218) : "f"(f47), "f"(f58));
  // PTX:460 sub.f32 %f66, %f218, %f217
  asm("sub.f32 %0, %1, %2;" : "=f"(f66) : "f"(f218), "f"(f217));
  // PTX:461 mul.f32 %f219, %f46, %f58
  asm("mul.f32 %0, %1, %2;" : "=f"(f219) : "f"(f46), "f"(f58));
  // PTX:462 mul.f32 %f220, %f45, %f60
  asm("mul.f32 %0, %1, %2;" : "=f"(f220) : "f"(f45), "f"(f60));
  // PTX:463 sub.f32 %f67, %f220, %f219
  asm("sub.f32 %0, %1, %2;" : "=f"(f67) : "f"(f220), "f"(f219));
  // PTX:464 mul.f32 %f221, %f47, %f61
  asm("mul.f32 %0, %1, %2;" : "=f"(f221) : "f"(f47), "f"(f61));
  // PTX:465 mul.f32 %f222, %f46, %f59
  asm("mul.f32 %0, %1, %2;" : "=f"(f222) : "f"(f46), "f"(f59));
  // PTX:466 sub.f32 %f223, %f222, %f221
  asm("sub.f32 %0, %1, %2;" : "=f"(f223) : "f"(f222), "f"(f221));
  // PTX:467 mul.f32 %f224, %f45, %f59
  asm("mul.f32 %0, %1, %2;" : "=f"(f224) : "f"(f45), "f"(f59));
  // PTX:468 mul.f32 %f225, %f47, %f63
  asm("mul.f32 %0, %1, %2;" : "=f"(f225) : "f"(f47), "f"(f63));
  // PTX:469 sub.f32 %f226, %f225, %f224
  asm("sub.f32 %0, %1, %2;" : "=f"(f226) : "f"(f225), "f"(f224));
  // PTX:470 mul.f32 %f227, %f46, %f63
  asm("mul.f32 %0, %1, %2;" : "=f"(f227) : "f"(f46), "f"(f63));
  // PTX:471 mul.f32 %f228, %f45, %f61
  asm("mul.f32 %0, %1, %2;" : "=f"(f228) : "f"(f45), "f"(f61));
  // PTX:472 sub.f32 %f229, %f228, %f227
  asm("sub.f32 %0, %1, %2;" : "=f"(f229) : "f"(f228), "f"(f227));
  // PTX:473 div.rn.f32 %f230, %f48, %f56
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f230) : "f"(f48), "f"(f56));
  // PTX:474 mul.f32 %f231, %f230, %f65
  asm("mul.f32 %0, %1, %2;" : "=f"(f231) : "f"(f230), "f"(f65));
  // PTX:475 mul.f32 %f232, %f230, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f232) : "f"(f230), "f"(f66));
  // PTX:476 mul.f32 %f233, %f230, %f67
  asm("mul.f32 %0, %1, %2;" : "=f"(f233) : "f"(f230), "f"(f67));
  // PTX:477 div.rn.f32 %f234, %f52, %f57
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f234) : "f"(f52), "f"(f57));
  // PTX:478 mul.f32 %f235, %f234, %f223
  asm("mul.f32 %0, %1, %2;" : "=f"(f235) : "f"(f234), "f"(f223));
  // PTX:479 mul.f32 %f236, %f234, %f226
  asm("mul.f32 %0, %1, %2;" : "=f"(f236) : "f"(f234), "f"(f226));
  // PTX:480 mul.f32 %f237, %f234, %f229
  asm("mul.f32 %0, %1, %2;" : "=f"(f237) : "f"(f234), "f"(f229));
  // PTX:481 sub.f32 %f238, %f231, %f235
  asm("sub.f32 %0, %1, %2;" : "=f"(f238) : "f"(f231), "f"(f235));
  // PTX:482 sub.f32 %f239, %f232, %f236
  asm("sub.f32 %0, %1, %2;" : "=f"(f239) : "f"(f232), "f"(f236));
  // PTX:483 sub.f32 %f240, %f233, %f237
  asm("sub.f32 %0, %1, %2;" : "=f"(f240) : "f"(f233), "f"(f237));
  // PTX:484 div.rn.f32 %f68, %f238, %f22
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f68) : "f"(f238), "f"(f22));
  // PTX:485 div.rn.f32 %f69, %f239, %f22
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f69) : "f"(f239), "f"(f22));
  // PTX:486 div.rn.f32 %f70, %f240, %f22
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f70) : "f"(f240), "f"(f22));
  // PTX:487 neg.f32 %f241, %f223
  asm("neg.f32 %0, %1;" : "=f"(f241) : "f"(f223));
  // PTX:488 neg.f32 %f242, %f226
  asm("neg.f32 %0, %1;" : "=f"(f242) : "f"(f226));
  // PTX:489 neg.f32 %f243, %f229
  asm("neg.f32 %0, %1;" : "=f"(f243) : "f"(f229));
  // PTX:490 div.rn.f32 %f244, %f241, %f57
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f244) : "f"(f241), "f"(f57));
  // PTX:491 div.rn.f32 %f245, %f242, %f57
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f245) : "f"(f242), "f"(f57));
  // PTX:492 div.rn.f32 %f246, %f243, %f57
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f246) : "f"(f243), "f"(f57));
  // PTX:493 div.rn.f32 %f247, %f223, %f57
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f247) : "f"(f223), "f"(f57));
  // PTX:494 div.rn.f32 %f248, %f226, %f57
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f248) : "f"(f226), "f"(f57));
  // PTX:495 div.rn.f32 %f249, %f229, %f57
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f249) : "f"(f229), "f"(f57));
  // PTX:496 mul.f32 %f250, %f247, %f38
  asm("mul.f32 %0, %1, %2;" : "=f"(f250) : "f"(f247), "f"(f38));
  // PTX:497 mul.f32 %f251, %f248, %f38
  asm("mul.f32 %0, %1, %2;" : "=f"(f251) : "f"(f248), "f"(f38));
  // PTX:498 mul.f32 %f252, %f249, %f38
  asm("mul.f32 %0, %1, %2;" : "=f"(f252) : "f"(f249), "f"(f38));
  // PTX:499 fma.rn.f32 %f253, %f244, %f31, %f250
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f253) : "f"(f244), "f"(f31), "f"(f250));
  // PTX:500 fma.rn.f32 %f254, %f245, %f31, %f251
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f254) : "f"(f245), "f"(f31), "f"(f251));
  // PTX:501 fma.rn.f32 %f255, %f246, %f31, %f252
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f255) : "f"(f246), "f"(f31), "f"(f252));
  // PTX:502 mul.f32 %f256, %f247, %f39
  asm("mul.f32 %0, %1, %2;" : "=f"(f256) : "f"(f247), "f"(f39));
  // PTX:503 mul.f32 %f257, %f248, %f39
  asm("mul.f32 %0, %1, %2;" : "=f"(f257) : "f"(f248), "f"(f39));
  // PTX:504 mul.f32 %f258, %f249, %f39
  asm("mul.f32 %0, %1, %2;" : "=f"(f258) : "f"(f249), "f"(f39));
  // PTX:505 fma.rn.f32 %f259, %f244, %f32, %f256
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f259) : "f"(f244), "f"(f32), "f"(f256));
  // PTX:506 fma.rn.f32 %f260, %f245, %f32, %f257
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f260) : "f"(f245), "f"(f32), "f"(f257));
  // PTX:507 fma.rn.f32 %f261, %f246, %f32, %f258
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f261) : "f"(f246), "f"(f32), "f"(f258));
  // PTX:508 mul.f32 %f262, %f247, %f40
  asm("mul.f32 %0, %1, %2;" : "=f"(f262) : "f"(f247), "f"(f40));
  // PTX:509 mul.f32 %f263, %f248, %f40
  asm("mul.f32 %0, %1, %2;" : "=f"(f263) : "f"(f248), "f"(f40));
  // PTX:510 mul.f32 %f264, %f249, %f40
  asm("mul.f32 %0, %1, %2;" : "=f"(f264) : "f"(f249), "f"(f40));
  // PTX:511 fma.rn.f32 %f265, %f244, %f33, %f262
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f265) : "f"(f244), "f"(f33), "f"(f262));
  // PTX:512 fma.rn.f32 %f266, %f245, %f33, %f263
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f266) : "f"(f245), "f"(f33), "f"(f263));
  // PTX:513 fma.rn.f32 %f267, %f246, %f33, %f264
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f267) : "f"(f246), "f"(f33), "f"(f264));
  // PTX:514 mul.f32 %f268, %f247, %f41
  asm("mul.f32 %0, %1, %2;" : "=f"(f268) : "f"(f247), "f"(f41));
  // PTX:515 mul.f32 %f269, %f248, %f41
  asm("mul.f32 %0, %1, %2;" : "=f"(f269) : "f"(f248), "f"(f41));
  // PTX:516 mul.f32 %f270, %f249, %f41
  asm("mul.f32 %0, %1, %2;" : "=f"(f270) : "f"(f249), "f"(f41));
  // PTX:517 fma.rn.f32 %f271, %f244, %f34, %f268
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f271) : "f"(f244), "f"(f34), "f"(f268));
  // PTX:518 fma.rn.f32 %f272, %f245, %f34, %f269
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f272) : "f"(f245), "f"(f34), "f"(f269));
  // PTX:519 fma.rn.f32 %f273, %f246, %f34, %f270
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f273) : "f"(f246), "f"(f34), "f"(f270));
  // PTX:520 mul.f32 %f274, %f253, %f253
  asm("mul.f32 %0, %1, %2;" : "=f"(f274) : "f"(f253), "f"(f253));
  // PTX:521 mul.f32 %f275, %f254, %f253
  asm("mul.f32 %0, %1, %2;" : "=f"(f275) : "f"(f254), "f"(f253));
  // PTX:522 mul.f32 %f276, %f255, %f253
  asm("mul.f32 %0, %1, %2;" : "=f"(f276) : "f"(f255), "f"(f253));
  // PTX:523 mul.f32 %f277, %f254, %f254
  asm("mul.f32 %0, %1, %2;" : "=f"(f277) : "f"(f254), "f"(f254));
  // PTX:524 mul.f32 %f278, %f255, %f254
  asm("mul.f32 %0, %1, %2;" : "=f"(f278) : "f"(f255), "f"(f254));
  // PTX:525 mul.f32 %f279, %f255, %f255
  asm("mul.f32 %0, %1, %2;" : "=f"(f279) : "f"(f255), "f"(f255));
  // PTX:526 mul.f32 %f280, %f30, %f274
  asm("mul.f32 %0, %1, %2;" : "=f"(f280) : "f"(f30), "f"(f274));
  // PTX:527 mul.f32 %f281, %f30, %f275
  asm("mul.f32 %0, %1, %2;" : "=f"(f281) : "f"(f30), "f"(f275));
  // PTX:528 mul.f32 %f282, %f30, %f276
  asm("mul.f32 %0, %1, %2;" : "=f"(f282) : "f"(f30), "f"(f276));
  // PTX:529 mul.f32 %f283, %f30, %f277
  asm("mul.f32 %0, %1, %2;" : "=f"(f283) : "f"(f30), "f"(f277));
  // PTX:530 mul.f32 %f284, %f30, %f278
  asm("mul.f32 %0, %1, %2;" : "=f"(f284) : "f"(f30), "f"(f278));
  // PTX:531 mul.f32 %f285, %f30, %f279
  asm("mul.f32 %0, %1, %2;" : "=f"(f285) : "f"(f30), "f"(f279));
  // PTX:532 mul.wide.s32 %rd113, %r2, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd113) : "r"(r2));
  // PTX:533 add.s64 %rd114, %rd1, %rd113
  asm("add.s64 %0, %1, %2;" : "=l"(rd114) : "l"(rd1), "l"(rd113));
  // PTX:534 red.global.add.f32 [%rd114], %f280
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd114) + (0)))), (float)(f280));
  // PTX:535 add.s64 %rd115, %rd114, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd115) : "l"(rd114));
  // PTX:536 red.global.add.f32 [%rd115], %f281
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd115) + (0)))), (float)(f281));
  // PTX:537 add.s64 %rd116, %rd114, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd116) : "l"(rd114));
  // PTX:538 red.global.add.f32 [%rd116], %f282
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd116) + (0)))), (float)(f282));
  // PTX:539 add.s64 %rd117, %rd114, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd117) : "l"(rd114));
  // PTX:540 red.global.add.f32 [%rd117], %f281
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd117) + (0)))), (float)(f281));
  // PTX:541 add.s64 %rd118, %rd114, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd118) : "l"(rd114));
  // PTX:542 red.global.add.f32 [%rd118], %f283
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd118) + (0)))), (float)(f283));
  // PTX:543 add.s64 %rd119, %rd114, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd119) : "l"(rd114));
  // PTX:544 red.global.add.f32 [%rd119], %f284
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd119) + (0)))), (float)(f284));
  // PTX:545 add.s64 %rd120, %rd114, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd120) : "l"(rd114));
  // PTX:546 red.global.add.f32 [%rd120], %f282
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd120) + (0)))), (float)(f282));
  // PTX:547 add.s64 %rd121, %rd114, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd121) : "l"(rd114));
  // PTX:548 red.global.add.f32 [%rd121], %f284
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd121) + (0)))), (float)(f284));
  // PTX:549 add.s64 %rd122, %rd114, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd122) : "l"(rd114));
  // PTX:550 red.global.add.f32 [%rd122], %f285
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd122) + (0)))), (float)(f285));
  // PTX:551 mul.f32 %f295, %f259, %f259
  asm("mul.f32 %0, %1, %2;" : "=f"(f295) : "f"(f259), "f"(f259));
  // PTX:552 mul.f32 %f296, %f260, %f259
  asm("mul.f32 %0, %1, %2;" : "=f"(f296) : "f"(f260), "f"(f259));
  // PTX:553 mul.f32 %f297, %f261, %f259
  asm("mul.f32 %0, %1, %2;" : "=f"(f297) : "f"(f261), "f"(f259));
  // PTX:554 mul.f32 %f298, %f260, %f260
  asm("mul.f32 %0, %1, %2;" : "=f"(f298) : "f"(f260), "f"(f260));
  // PTX:555 mul.f32 %f299, %f261, %f260
  asm("mul.f32 %0, %1, %2;" : "=f"(f299) : "f"(f261), "f"(f260));
  // PTX:556 mul.f32 %f300, %f261, %f261
  asm("mul.f32 %0, %1, %2;" : "=f"(f300) : "f"(f261), "f"(f261));
  // PTX:557 mul.f32 %f301, %f30, %f295
  asm("mul.f32 %0, %1, %2;" : "=f"(f301) : "f"(f30), "f"(f295));
  // PTX:558 mul.f32 %f302, %f30, %f296
  asm("mul.f32 %0, %1, %2;" : "=f"(f302) : "f"(f30), "f"(f296));
  // PTX:559 mul.f32 %f303, %f30, %f297
  asm("mul.f32 %0, %1, %2;" : "=f"(f303) : "f"(f30), "f"(f297));
  // PTX:560 mul.f32 %f304, %f30, %f298
  asm("mul.f32 %0, %1, %2;" : "=f"(f304) : "f"(f30), "f"(f298));
  // PTX:561 mul.f32 %f305, %f30, %f299
  asm("mul.f32 %0, %1, %2;" : "=f"(f305) : "f"(f30), "f"(f299));
  // PTX:562 mul.f32 %f306, %f30, %f300
  asm("mul.f32 %0, %1, %2;" : "=f"(f306) : "f"(f30), "f"(f300));
  // PTX:563 mul.wide.s32 %rd123, %r3, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd123) : "r"(r3));
  // PTX:564 add.s64 %rd124, %rd1, %rd123
  asm("add.s64 %0, %1, %2;" : "=l"(rd124) : "l"(rd1), "l"(rd123));
  // PTX:565 red.global.add.f32 [%rd124], %f301
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd124) + (0)))), (float)(f301));
  // PTX:566 add.s64 %rd125, %rd124, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd125) : "l"(rd124));
  // PTX:567 red.global.add.f32 [%rd125], %f302
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd125) + (0)))), (float)(f302));
  // PTX:568 add.s64 %rd126, %rd124, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd126) : "l"(rd124));
  // PTX:569 red.global.add.f32 [%rd126], %f303
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd126) + (0)))), (float)(f303));
  // PTX:570 add.s64 %rd127, %rd124, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd127) : "l"(rd124));
  // PTX:571 red.global.add.f32 [%rd127], %f302
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd127) + (0)))), (float)(f302));
  // PTX:572 add.s64 %rd128, %rd124, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd128) : "l"(rd124));
  // PTX:573 red.global.add.f32 [%rd128], %f304
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd128) + (0)))), (float)(f304));
  // PTX:574 add.s64 %rd129, %rd124, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd129) : "l"(rd124));
  // PTX:575 red.global.add.f32 [%rd129], %f305
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd129) + (0)))), (float)(f305));
  // PTX:576 add.s64 %rd130, %rd124, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd130) : "l"(rd124));
  // PTX:577 red.global.add.f32 [%rd130], %f303
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd130) + (0)))), (float)(f303));
  // PTX:578 add.s64 %rd131, %rd124, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd131) : "l"(rd124));
  // PTX:579 red.global.add.f32 [%rd131], %f305
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd131) + (0)))), (float)(f305));
  // PTX:580 add.s64 %rd132, %rd124, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd132) : "l"(rd124));
  // PTX:581 red.global.add.f32 [%rd132], %f306
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd132) + (0)))), (float)(f306));
  // PTX:582 mul.f32 %f316, %f265, %f265
  asm("mul.f32 %0, %1, %2;" : "=f"(f316) : "f"(f265), "f"(f265));
  // PTX:583 mul.f32 %f317, %f266, %f265
  asm("mul.f32 %0, %1, %2;" : "=f"(f317) : "f"(f266), "f"(f265));
  // PTX:584 mul.f32 %f318, %f267, %f265
  asm("mul.f32 %0, %1, %2;" : "=f"(f318) : "f"(f267), "f"(f265));
  // PTX:585 mul.f32 %f319, %f266, %f266
  asm("mul.f32 %0, %1, %2;" : "=f"(f319) : "f"(f266), "f"(f266));
  // PTX:586 mul.f32 %f320, %f267, %f266
  asm("mul.f32 %0, %1, %2;" : "=f"(f320) : "f"(f267), "f"(f266));
  // PTX:587 mul.f32 %f321, %f267, %f267
  asm("mul.f32 %0, %1, %2;" : "=f"(f321) : "f"(f267), "f"(f267));
  // PTX:588 mul.f32 %f322, %f30, %f316
  asm("mul.f32 %0, %1, %2;" : "=f"(f322) : "f"(f30), "f"(f316));
  // PTX:589 mul.f32 %f323, %f30, %f317
  asm("mul.f32 %0, %1, %2;" : "=f"(f323) : "f"(f30), "f"(f317));
  // PTX:590 mul.f32 %f324, %f30, %f318
  asm("mul.f32 %0, %1, %2;" : "=f"(f324) : "f"(f30), "f"(f318));
  // PTX:591 mul.f32 %f325, %f30, %f319
  asm("mul.f32 %0, %1, %2;" : "=f"(f325) : "f"(f30), "f"(f319));
  // PTX:592 mul.f32 %f326, %f30, %f320
  asm("mul.f32 %0, %1, %2;" : "=f"(f326) : "f"(f30), "f"(f320));
  // PTX:593 mul.f32 %f327, %f30, %f321
  asm("mul.f32 %0, %1, %2;" : "=f"(f327) : "f"(f30), "f"(f321));
  // PTX:594 mul.wide.s32 %rd133, %r4, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd133) : "r"(r4));
  // PTX:595 add.s64 %rd134, %rd1, %rd133
  asm("add.s64 %0, %1, %2;" : "=l"(rd134) : "l"(rd1), "l"(rd133));
  // PTX:596 red.global.add.f32 [%rd134], %f322
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd134) + (0)))), (float)(f322));
  // PTX:597 add.s64 %rd135, %rd134, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd135) : "l"(rd134));
  // PTX:598 red.global.add.f32 [%rd135], %f323
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd135) + (0)))), (float)(f323));
  // PTX:599 add.s64 %rd136, %rd134, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd136) : "l"(rd134));
  // PTX:600 red.global.add.f32 [%rd136], %f324
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd136) + (0)))), (float)(f324));
  // PTX:601 add.s64 %rd137, %rd134, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd137) : "l"(rd134));
  // PTX:602 red.global.add.f32 [%rd137], %f323
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd137) + (0)))), (float)(f323));
  // PTX:603 add.s64 %rd138, %rd134, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd138) : "l"(rd134));
  // PTX:604 red.global.add.f32 [%rd138], %f325
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd138) + (0)))), (float)(f325));
  // PTX:605 add.s64 %rd139, %rd134, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd139) : "l"(rd134));
  // PTX:606 red.global.add.f32 [%rd139], %f326
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd139) + (0)))), (float)(f326));
  // PTX:607 add.s64 %rd140, %rd134, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd140) : "l"(rd134));
  // PTX:608 red.global.add.f32 [%rd140], %f324
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd140) + (0)))), (float)(f324));
  // PTX:609 add.s64 %rd141, %rd134, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd141) : "l"(rd134));
  // PTX:610 red.global.add.f32 [%rd141], %f326
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd141) + (0)))), (float)(f326));
  // PTX:611 add.s64 %rd142, %rd134, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd142) : "l"(rd134));
  // PTX:612 red.global.add.f32 [%rd142], %f327
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd142) + (0)))), (float)(f327));
  // PTX:613 mul.f32 %f337, %f271, %f271
  asm("mul.f32 %0, %1, %2;" : "=f"(f337) : "f"(f271), "f"(f271));
  // PTX:614 mul.f32 %f338, %f272, %f271
  asm("mul.f32 %0, %1, %2;" : "=f"(f338) : "f"(f272), "f"(f271));
  // PTX:615 mul.f32 %f339, %f273, %f271
  asm("mul.f32 %0, %1, %2;" : "=f"(f339) : "f"(f273), "f"(f271));
  // PTX:616 mul.f32 %f340, %f272, %f272
  asm("mul.f32 %0, %1, %2;" : "=f"(f340) : "f"(f272), "f"(f272));
  // PTX:617 mul.f32 %f341, %f273, %f272
  asm("mul.f32 %0, %1, %2;" : "=f"(f341) : "f"(f273), "f"(f272));
  // PTX:618 mul.f32 %f342, %f273, %f273
  asm("mul.f32 %0, %1, %2;" : "=f"(f342) : "f"(f273), "f"(f273));
  // PTX:619 mul.f32 %f343, %f30, %f337
  asm("mul.f32 %0, %1, %2;" : "=f"(f343) : "f"(f30), "f"(f337));
  // PTX:620 mul.f32 %f344, %f30, %f338
  asm("mul.f32 %0, %1, %2;" : "=f"(f344) : "f"(f30), "f"(f338));
  // PTX:621 mul.f32 %f345, %f30, %f339
  asm("mul.f32 %0, %1, %2;" : "=f"(f345) : "f"(f30), "f"(f339));
  // PTX:622 mul.f32 %f346, %f30, %f340
  asm("mul.f32 %0, %1, %2;" : "=f"(f346) : "f"(f30), "f"(f340));
  // PTX:623 mul.f32 %f347, %f30, %f341
  asm("mul.f32 %0, %1, %2;" : "=f"(f347) : "f"(f30), "f"(f341));
  // PTX:624 mul.f32 %f348, %f30, %f342
  asm("mul.f32 %0, %1, %2;" : "=f"(f348) : "f"(f30), "f"(f342));
  // PTX:625 mul.wide.s32 %rd143, %r5, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd143) : "r"(r5));
  // PTX:626 add.s64 %rd144, %rd1, %rd143
  asm("add.s64 %0, %1, %2;" : "=l"(rd144) : "l"(rd1), "l"(rd143));
  // PTX:627 red.global.add.f32 [%rd144], %f343
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd144) + (0)))), (float)(f343));
  // PTX:628 add.s64 %rd145, %rd144, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd145) : "l"(rd144));
  // PTX:629 red.global.add.f32 [%rd145], %f344
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd145) + (0)))), (float)(f344));
  // PTX:630 add.s64 %rd146, %rd144, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd146) : "l"(rd144));
  // PTX:631 red.global.add.f32 [%rd146], %f345
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd146) + (0)))), (float)(f345));
  // PTX:632 add.s64 %rd147, %rd144, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd147) : "l"(rd144));
  // PTX:633 red.global.add.f32 [%rd147], %f344
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd147) + (0)))), (float)(f344));
  // PTX:634 add.s64 %rd148, %rd144, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd148) : "l"(rd144));
  // PTX:635 red.global.add.f32 [%rd148], %f346
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd148) + (0)))), (float)(f346));
  // PTX:636 add.s64 %rd149, %rd144, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd149) : "l"(rd144));
  // PTX:637 red.global.add.f32 [%rd149], %f347
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd149) + (0)))), (float)(f347));
  // PTX:638 add.s64 %rd150, %rd144, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd150) : "l"(rd144));
  // PTX:639 red.global.add.f32 [%rd150], %f345
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd150) + (0)))), (float)(f345));
  // PTX:640 add.s64 %rd151, %rd144, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd151) : "l"(rd144));
  // PTX:641 red.global.add.f32 [%rd151], %f347
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd151) + (0)))), (float)(f347));
  // PTX:642 add.s64 %rd152, %rd144, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd152) : "l"(rd144));
  // PTX:643 red.global.add.f32 [%rd152], %f348
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd152) + (0)))), (float)(f348));
  // PTX:644 @%p21 bra $L__BB58_28
  if (p21) { goto L_BB58_28; }
  // PTX:646 div.rn.f32 %f358, %f65, %f56
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f358) : "f"(f65), "f"(f56));
  // PTX:647 sub.f32 %f359, %f358, %f68
  asm("sub.f32 %0, %1, %2;" : "=f"(f359) : "f"(f358), "f"(f68));
  // PTX:648 div.rn.f32 %f360, %f66, %f56
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f360) : "f"(f66), "f"(f56));
  // PTX:649 sub.f32 %f361, %f360, %f69
  asm("sub.f32 %0, %1, %2;" : "=f"(f361) : "f"(f360), "f"(f69));
  // PTX:650 div.rn.f32 %f362, %f67, %f56
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f362) : "f"(f67), "f"(f56));
  // PTX:651 sub.f32 %f363, %f362, %f70
  asm("sub.f32 %0, %1, %2;" : "=f"(f363) : "f"(f362), "f"(f70));
  // PTX:652 neg.f32 %f364, %f65
  asm("neg.f32 %0, %1;" : "=f"(f364) : "f"(f65));
  // PTX:653 div.rn.f32 %f365, %f364, %f56
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f365) : "f"(f364), "f"(f56));
  // PTX:654 neg.f32 %f366, %f66
  asm("neg.f32 %0, %1;" : "=f"(f366) : "f"(f66));
  // PTX:655 div.rn.f32 %f367, %f366, %f56
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f367) : "f"(f366), "f"(f56));
  // PTX:656 neg.f32 %f368, %f67
  asm("neg.f32 %0, %1;" : "=f"(f368) : "f"(f67));
  // PTX:657 div.rn.f32 %f369, %f368, %f56
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f369) : "f"(f368), "f"(f56));
  // PTX:658 ld.global.f32 %f370, [%rd12]
  f370 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (0)))));
  // PTX:659 ld.global.f32 %f371, [%rd13]
  f371 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))));
  // PTX:660 mul.f32 %f372, %f68, %f371
  asm("mul.f32 %0, %1, %2;" : "=f"(f372) : "f"(f68), "f"(f371));
  // PTX:661 mul.f32 %f373, %f69, %f371
  asm("mul.f32 %0, %1, %2;" : "=f"(f373) : "f"(f69), "f"(f371));
  // PTX:662 mul.f32 %f374, %f70, %f371
  asm("mul.f32 %0, %1, %2;" : "=f"(f374) : "f"(f70), "f"(f371));
  // PTX:663 fma.rn.f32 %f375, %f359, %f370, %f372
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f375) : "f"(f359), "f"(f370), "f"(f372));
  // PTX:664 fma.rn.f32 %f376, %f361, %f370, %f373
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f376) : "f"(f361), "f"(f370), "f"(f373));
  // PTX:665 fma.rn.f32 %f377, %f363, %f370, %f374
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f377) : "f"(f363), "f"(f370), "f"(f374));
  // PTX:666 ld.global.f32 %f378, [%rd14]
  f378 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:667 fma.rn.f32 %f379, %f365, %f378, %f375
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f379) : "f"(f365), "f"(f378), "f"(f375));
  // PTX:668 fma.rn.f32 %f380, %f367, %f378, %f376
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f380) : "f"(f367), "f"(f378), "f"(f376));
  // PTX:669 fma.rn.f32 %f381, %f369, %f378, %f377
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f381) : "f"(f369), "f"(f378), "f"(f377));
  // PTX:670 ld.global.f32 %f382, [%rd12+4]
  f382 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (4)))));
  // PTX:671 ld.global.f32 %f383, [%rd13+4]
  f383 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4)))));
  // PTX:672 mul.f32 %f384, %f68, %f383
  asm("mul.f32 %0, %1, %2;" : "=f"(f384) : "f"(f68), "f"(f383));
  // PTX:673 mul.f32 %f385, %f69, %f383
  asm("mul.f32 %0, %1, %2;" : "=f"(f385) : "f"(f69), "f"(f383));
  // PTX:674 mul.f32 %f386, %f70, %f383
  asm("mul.f32 %0, %1, %2;" : "=f"(f386) : "f"(f70), "f"(f383));
  // PTX:675 fma.rn.f32 %f387, %f359, %f382, %f384
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f387) : "f"(f359), "f"(f382), "f"(f384));
  // PTX:676 fma.rn.f32 %f388, %f361, %f382, %f385
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f388) : "f"(f361), "f"(f382), "f"(f385));
  // PTX:677 fma.rn.f32 %f389, %f363, %f382, %f386
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f389) : "f"(f363), "f"(f382), "f"(f386));
  // PTX:678 ld.global.f32 %f390, [%rd14+4]
  f390 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (4)))));
  // PTX:679 fma.rn.f32 %f391, %f365, %f390, %f387
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f391) : "f"(f365), "f"(f390), "f"(f387));
  // PTX:680 fma.rn.f32 %f392, %f367, %f390, %f388
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f392) : "f"(f367), "f"(f390), "f"(f388));
  // PTX:681 fma.rn.f32 %f393, %f369, %f390, %f389
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f393) : "f"(f369), "f"(f390), "f"(f389));
  // PTX:682 ld.global.f32 %f394, [%rd12+8]
  f394 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (8)))));
  // PTX:683 ld.global.f32 %f395, [%rd13+8]
  f395 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8)))));
  // PTX:684 mul.f32 %f396, %f68, %f395
  asm("mul.f32 %0, %1, %2;" : "=f"(f396) : "f"(f68), "f"(f395));
  // PTX:685 mul.f32 %f397, %f69, %f395
  asm("mul.f32 %0, %1, %2;" : "=f"(f397) : "f"(f69), "f"(f395));
  // PTX:686 mul.f32 %f398, %f70, %f395
  asm("mul.f32 %0, %1, %2;" : "=f"(f398) : "f"(f70), "f"(f395));
  // PTX:687 fma.rn.f32 %f399, %f359, %f394, %f396
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f399) : "f"(f359), "f"(f394), "f"(f396));
  // PTX:688 fma.rn.f32 %f400, %f361, %f394, %f397
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f400) : "f"(f361), "f"(f394), "f"(f397));
  // PTX:689 fma.rn.f32 %f401, %f363, %f394, %f398
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f401) : "f"(f363), "f"(f394), "f"(f398));
  // PTX:690 ld.global.f32 %f402, [%rd14+8]
  f402 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (8)))));
  // PTX:691 fma.rn.f32 %f403, %f365, %f402, %f399
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f403) : "f"(f365), "f"(f402), "f"(f399));
  // PTX:692 fma.rn.f32 %f404, %f367, %f402, %f400
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f404) : "f"(f367), "f"(f402), "f"(f400));
  // PTX:693 fma.rn.f32 %f405, %f369, %f402, %f401
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f405) : "f"(f369), "f"(f402), "f"(f401));
  // PTX:694 ld.global.f32 %f406, [%rd12+12]
  f406 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (12)))));
  // PTX:695 ld.global.f32 %f407, [%rd13+12]
  f407 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (12)))));
  // PTX:696 mul.f32 %f408, %f68, %f407
  asm("mul.f32 %0, %1, %2;" : "=f"(f408) : "f"(f68), "f"(f407));
  // PTX:697 mul.f32 %f409, %f69, %f407
  asm("mul.f32 %0, %1, %2;" : "=f"(f409) : "f"(f69), "f"(f407));
  // PTX:698 mul.f32 %f410, %f70, %f407
  asm("mul.f32 %0, %1, %2;" : "=f"(f410) : "f"(f70), "f"(f407));
  // PTX:699 fma.rn.f32 %f411, %f359, %f406, %f408
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f411) : "f"(f359), "f"(f406), "f"(f408));
  // PTX:700 fma.rn.f32 %f412, %f361, %f406, %f409
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f412) : "f"(f361), "f"(f406), "f"(f409));
  // PTX:701 fma.rn.f32 %f413, %f363, %f406, %f410
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f413) : "f"(f363), "f"(f406), "f"(f410));
  // PTX:702 ld.global.f32 %f414, [%rd14+12]
  f414 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (12)))));
  // PTX:703 fma.rn.f32 %f415, %f365, %f414, %f411
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f415) : "f"(f365), "f"(f414), "f"(f411));
  // PTX:704 fma.rn.f32 %f416, %f367, %f414, %f412
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f416) : "f"(f367), "f"(f414), "f"(f412));
  // PTX:705 fma.rn.f32 %f417, %f369, %f414, %f413
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f417) : "f"(f369), "f"(f414), "f"(f413));
  // PTX:706 mul.f32 %f418, %f379, %f379
  asm("mul.f32 %0, %1, %2;" : "=f"(f418) : "f"(f379), "f"(f379));
  // PTX:707 mul.f32 %f419, %f380, %f379
  asm("mul.f32 %0, %1, %2;" : "=f"(f419) : "f"(f380), "f"(f379));
  // PTX:708 mul.f32 %f420, %f381, %f379
  asm("mul.f32 %0, %1, %2;" : "=f"(f420) : "f"(f381), "f"(f379));
  // PTX:709 mul.f32 %f421, %f380, %f380
  asm("mul.f32 %0, %1, %2;" : "=f"(f421) : "f"(f380), "f"(f380));
  // PTX:710 mul.f32 %f422, %f381, %f380
  asm("mul.f32 %0, %1, %2;" : "=f"(f422) : "f"(f381), "f"(f380));
  // PTX:711 mul.f32 %f423, %f381, %f381
  asm("mul.f32 %0, %1, %2;" : "=f"(f423) : "f"(f381), "f"(f381));
  // PTX:712 mul.f32 %f424, %f30, %f418
  asm("mul.f32 %0, %1, %2;" : "=f"(f424) : "f"(f30), "f"(f418));
  // PTX:713 mul.f32 %f425, %f30, %f419
  asm("mul.f32 %0, %1, %2;" : "=f"(f425) : "f"(f30), "f"(f419));
  // PTX:714 mul.f32 %f426, %f30, %f420
  asm("mul.f32 %0, %1, %2;" : "=f"(f426) : "f"(f30), "f"(f420));
  // PTX:715 mul.f32 %f427, %f30, %f421
  asm("mul.f32 %0, %1, %2;" : "=f"(f427) : "f"(f30), "f"(f421));
  // PTX:716 mul.f32 %f428, %f30, %f422
  asm("mul.f32 %0, %1, %2;" : "=f"(f428) : "f"(f30), "f"(f422));
  // PTX:717 mul.f32 %f429, %f30, %f423
  asm("mul.f32 %0, %1, %2;" : "=f"(f429) : "f"(f30), "f"(f423));
  // PTX:718 mul.lo.s64 %rd153, %rd275, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd153) : "l"(rd275));
  // PTX:719 add.s64 %rd154, %rd1, %rd153
  asm("add.s64 %0, %1, %2;" : "=l"(rd154) : "l"(rd1), "l"(rd153));
  // PTX:720 red.global.add.f32 [%rd154], %f424
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd154) + (0)))), (float)(f424));
  // PTX:721 add.s64 %rd155, %rd154, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd155) : "l"(rd154));
  // PTX:722 red.global.add.f32 [%rd155], %f425
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd155) + (0)))), (float)(f425));
  // PTX:723 add.s64 %rd156, %rd154, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd156) : "l"(rd154));
  // PTX:724 red.global.add.f32 [%rd156], %f426
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd156) + (0)))), (float)(f426));
  // PTX:725 add.s64 %rd157, %rd154, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd157) : "l"(rd154));
  // PTX:726 red.global.add.f32 [%rd157], %f425
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd157) + (0)))), (float)(f425));
  // PTX:727 add.s64 %rd158, %rd154, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd158) : "l"(rd154));
  // PTX:728 red.global.add.f32 [%rd158], %f427
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd158) + (0)))), (float)(f427));
  // PTX:729 add.s64 %rd159, %rd154, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd159) : "l"(rd154));
  // PTX:730 red.global.add.f32 [%rd159], %f428
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd159) + (0)))), (float)(f428));
  // PTX:731 add.s64 %rd160, %rd154, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd160) : "l"(rd154));
  // PTX:732 red.global.add.f32 [%rd160], %f426
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd160) + (0)))), (float)(f426));
  // PTX:733 add.s64 %rd161, %rd154, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd161) : "l"(rd154));
  // PTX:734 red.global.add.f32 [%rd161], %f428
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd161) + (0)))), (float)(f428));
  // PTX:735 add.s64 %rd162, %rd154, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd162) : "l"(rd154));
  // PTX:736 red.global.add.f32 [%rd162], %f429
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd162) + (0)))), (float)(f429));
  // PTX:737 mul.f32 %f439, %f391, %f391
  asm("mul.f32 %0, %1, %2;" : "=f"(f439) : "f"(f391), "f"(f391));
  // PTX:738 mul.f32 %f440, %f392, %f391
  asm("mul.f32 %0, %1, %2;" : "=f"(f440) : "f"(f392), "f"(f391));
  // PTX:739 mul.f32 %f441, %f393, %f391
  asm("mul.f32 %0, %1, %2;" : "=f"(f441) : "f"(f393), "f"(f391));
  // PTX:740 mul.f32 %f442, %f392, %f392
  asm("mul.f32 %0, %1, %2;" : "=f"(f442) : "f"(f392), "f"(f392));
  // PTX:741 mul.f32 %f443, %f393, %f392
  asm("mul.f32 %0, %1, %2;" : "=f"(f443) : "f"(f393), "f"(f392));
  // PTX:742 mul.f32 %f444, %f393, %f393
  asm("mul.f32 %0, %1, %2;" : "=f"(f444) : "f"(f393), "f"(f393));
  // PTX:743 mul.f32 %f445, %f30, %f439
  asm("mul.f32 %0, %1, %2;" : "=f"(f445) : "f"(f30), "f"(f439));
  // PTX:744 mul.f32 %f446, %f30, %f440
  asm("mul.f32 %0, %1, %2;" : "=f"(f446) : "f"(f30), "f"(f440));
  // PTX:745 mul.f32 %f447, %f30, %f441
  asm("mul.f32 %0, %1, %2;" : "=f"(f447) : "f"(f30), "f"(f441));
  // PTX:746 mul.f32 %f448, %f30, %f442
  asm("mul.f32 %0, %1, %2;" : "=f"(f448) : "f"(f30), "f"(f442));
  // PTX:747 mul.f32 %f449, %f30, %f443
  asm("mul.f32 %0, %1, %2;" : "=f"(f449) : "f"(f30), "f"(f443));
  // PTX:748 mul.f32 %f450, %f30, %f444
  asm("mul.f32 %0, %1, %2;" : "=f"(f450) : "f"(f30), "f"(f444));
  // PTX:749 mul.lo.s64 %rd163, %rd276, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd163) : "l"(rd276));
  // PTX:750 add.s64 %rd164, %rd1, %rd163
  asm("add.s64 %0, %1, %2;" : "=l"(rd164) : "l"(rd1), "l"(rd163));
  // PTX:751 red.global.add.f32 [%rd164], %f445
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd164) + (0)))), (float)(f445));
  // PTX:752 add.s64 %rd165, %rd164, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd165) : "l"(rd164));
  // PTX:753 red.global.add.f32 [%rd165], %f446
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd165) + (0)))), (float)(f446));
  // PTX:754 add.s64 %rd166, %rd164, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd166) : "l"(rd164));
  // PTX:755 red.global.add.f32 [%rd166], %f447
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd166) + (0)))), (float)(f447));
  // PTX:756 add.s64 %rd167, %rd164, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd167) : "l"(rd164));
  // PTX:757 red.global.add.f32 [%rd167], %f446
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd167) + (0)))), (float)(f446));
  // PTX:758 add.s64 %rd168, %rd164, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd168) : "l"(rd164));
  // PTX:759 red.global.add.f32 [%rd168], %f448
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd168) + (0)))), (float)(f448));
  // PTX:760 add.s64 %rd169, %rd164, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd169) : "l"(rd164));
  // PTX:761 red.global.add.f32 [%rd169], %f449
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd169) + (0)))), (float)(f449));
  // PTX:762 add.s64 %rd170, %rd164, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd170) : "l"(rd164));
  // PTX:763 red.global.add.f32 [%rd170], %f447
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd170) + (0)))), (float)(f447));
  // PTX:764 add.s64 %rd171, %rd164, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd171) : "l"(rd164));
  // PTX:765 red.global.add.f32 [%rd171], %f449
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd171) + (0)))), (float)(f449));
  // PTX:766 add.s64 %rd172, %rd164, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd172) : "l"(rd164));
  // PTX:767 red.global.add.f32 [%rd172], %f450
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd172) + (0)))), (float)(f450));
  // PTX:768 mul.f32 %f460, %f403, %f403
  asm("mul.f32 %0, %1, %2;" : "=f"(f460) : "f"(f403), "f"(f403));
  // PTX:769 mul.f32 %f461, %f404, %f403
  asm("mul.f32 %0, %1, %2;" : "=f"(f461) : "f"(f404), "f"(f403));
  // PTX:770 mul.f32 %f462, %f405, %f403
  asm("mul.f32 %0, %1, %2;" : "=f"(f462) : "f"(f405), "f"(f403));
  // PTX:771 mul.f32 %f463, %f404, %f404
  asm("mul.f32 %0, %1, %2;" : "=f"(f463) : "f"(f404), "f"(f404));
  // PTX:772 mul.f32 %f464, %f405, %f404
  asm("mul.f32 %0, %1, %2;" : "=f"(f464) : "f"(f405), "f"(f404));
  // PTX:773 mul.f32 %f465, %f405, %f405
  asm("mul.f32 %0, %1, %2;" : "=f"(f465) : "f"(f405), "f"(f405));
  // PTX:774 mul.f32 %f466, %f30, %f460
  asm("mul.f32 %0, %1, %2;" : "=f"(f466) : "f"(f30), "f"(f460));
  // PTX:775 mul.f32 %f467, %f30, %f461
  asm("mul.f32 %0, %1, %2;" : "=f"(f467) : "f"(f30), "f"(f461));
  // PTX:776 mul.f32 %f468, %f30, %f462
  asm("mul.f32 %0, %1, %2;" : "=f"(f468) : "f"(f30), "f"(f462));
  // PTX:777 mul.f32 %f469, %f30, %f463
  asm("mul.f32 %0, %1, %2;" : "=f"(f469) : "f"(f30), "f"(f463));
  // PTX:778 mul.f32 %f470, %f30, %f464
  asm("mul.f32 %0, %1, %2;" : "=f"(f470) : "f"(f30), "f"(f464));
  // PTX:779 mul.f32 %f471, %f30, %f465
  asm("mul.f32 %0, %1, %2;" : "=f"(f471) : "f"(f30), "f"(f465));
  // PTX:780 mul.lo.s64 %rd173, %rd277, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd173) : "l"(rd277));
  // PTX:781 add.s64 %rd174, %rd1, %rd173
  asm("add.s64 %0, %1, %2;" : "=l"(rd174) : "l"(rd1), "l"(rd173));
  // PTX:782 red.global.add.f32 [%rd174], %f466
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd174) + (0)))), (float)(f466));
  // PTX:783 add.s64 %rd175, %rd174, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd175) : "l"(rd174));
  // PTX:784 red.global.add.f32 [%rd175], %f467
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd175) + (0)))), (float)(f467));
  // PTX:785 add.s64 %rd176, %rd174, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd176) : "l"(rd174));
  // PTX:786 red.global.add.f32 [%rd176], %f468
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd176) + (0)))), (float)(f468));
  // PTX:787 add.s64 %rd177, %rd174, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd177) : "l"(rd174));
  // PTX:788 red.global.add.f32 [%rd177], %f467
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd177) + (0)))), (float)(f467));
  // PTX:789 add.s64 %rd178, %rd174, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd178) : "l"(rd174));
  // PTX:790 red.global.add.f32 [%rd178], %f469
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd178) + (0)))), (float)(f469));
  // PTX:791 add.s64 %rd179, %rd174, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd179) : "l"(rd174));
  // PTX:792 red.global.add.f32 [%rd179], %f470
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd179) + (0)))), (float)(f470));
  // PTX:793 add.s64 %rd180, %rd174, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd180) : "l"(rd174));
  // PTX:794 red.global.add.f32 [%rd180], %f468
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (0)))), (float)(f468));
  // PTX:795 add.s64 %rd181, %rd174, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd181) : "l"(rd174));
  // PTX:796 red.global.add.f32 [%rd181], %f470
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd181) + (0)))), (float)(f470));
  // PTX:797 add.s64 %rd182, %rd174, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd182) : "l"(rd174));
  // PTX:798 red.global.add.f32 [%rd182], %f471
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd182) + (0)))), (float)(f471));
  // PTX:799 mul.f32 %f481, %f415, %f415
  asm("mul.f32 %0, %1, %2;" : "=f"(f481) : "f"(f415), "f"(f415));
  // PTX:800 mul.f32 %f482, %f416, %f415
  asm("mul.f32 %0, %1, %2;" : "=f"(f482) : "f"(f416), "f"(f415));
  // PTX:801 mul.f32 %f483, %f417, %f415
  asm("mul.f32 %0, %1, %2;" : "=f"(f483) : "f"(f417), "f"(f415));
  // PTX:802 mul.f32 %f484, %f416, %f416
  asm("mul.f32 %0, %1, %2;" : "=f"(f484) : "f"(f416), "f"(f416));
  // PTX:803 mul.f32 %f485, %f417, %f416
  asm("mul.f32 %0, %1, %2;" : "=f"(f485) : "f"(f417), "f"(f416));
  // PTX:804 mul.f32 %f486, %f417, %f417
  asm("mul.f32 %0, %1, %2;" : "=f"(f486) : "f"(f417), "f"(f417));
  // PTX:805 mul.f32 %f487, %f30, %f481
  asm("mul.f32 %0, %1, %2;" : "=f"(f487) : "f"(f30), "f"(f481));
  // PTX:806 mul.f32 %f488, %f30, %f482
  asm("mul.f32 %0, %1, %2;" : "=f"(f488) : "f"(f30), "f"(f482));
  // PTX:807 mul.f32 %f489, %f30, %f483
  asm("mul.f32 %0, %1, %2;" : "=f"(f489) : "f"(f30), "f"(f483));
  // PTX:808 mul.f32 %f490, %f30, %f484
  asm("mul.f32 %0, %1, %2;" : "=f"(f490) : "f"(f30), "f"(f484));
  // PTX:809 mul.f32 %f491, %f30, %f485
  asm("mul.f32 %0, %1, %2;" : "=f"(f491) : "f"(f30), "f"(f485));
  // PTX:810 mul.f32 %f492, %f30, %f486
  asm("mul.f32 %0, %1, %2;" : "=f"(f492) : "f"(f30), "f"(f486));
  // PTX:811 mul.lo.s64 %rd183, %rd278, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd183) : "l"(rd278));
  // PTX:812 add.s64 %rd184, %rd1, %rd183
  asm("add.s64 %0, %1, %2;" : "=l"(rd184) : "l"(rd1), "l"(rd183));
  // PTX:813 red.global.add.f32 [%rd184], %f487
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd184) + (0)))), (float)(f487));
  // PTX:814 add.s64 %rd185, %rd184, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd185) : "l"(rd184));
  // PTX:815 red.global.add.f32 [%rd185], %f488
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (0)))), (float)(f488));
  // PTX:816 add.s64 %rd186, %rd184, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd186) : "l"(rd184));
  // PTX:817 red.global.add.f32 [%rd186], %f489
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd186) + (0)))), (float)(f489));
  // PTX:818 add.s64 %rd187, %rd184, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd187) : "l"(rd184));
  // PTX:819 red.global.add.f32 [%rd187], %f488
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd187) + (0)))), (float)(f488));
  // PTX:820 add.s64 %rd188, %rd184, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd188) : "l"(rd184));
  // PTX:821 red.global.add.f32 [%rd188], %f490
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd188) + (0)))), (float)(f490));
  // PTX:822 add.s64 %rd189, %rd184, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd189) : "l"(rd184));
  // PTX:823 red.global.add.f32 [%rd189], %f491
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd189) + (0)))), (float)(f491));
  // PTX:824 add.s64 %rd190, %rd184, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd190) : "l"(rd184));
  // PTX:825 red.global.add.f32 [%rd190], %f489
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd190) + (0)))), (float)(f489));
  // PTX:826 add.s64 %rd191, %rd184, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd191) : "l"(rd184));
  // PTX:827 red.global.add.f32 [%rd191], %f491
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd191) + (0)))), (float)(f491));
  // PTX:828 add.s64 %rd192, %rd184, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd192) : "l"(rd184));
  // PTX:829 red.global.add.f32 [%rd192], %f492
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd192) + (0)))), (float)(f492));
  // PTX:830 bra.uni $L__BB58_28
  goto L_BB58_28;
  // PTX:832 $L__BB58_26:
L_BB58_26:;
  // PTX:833 cvt.u32.u64 %r53, %rd11
  asm("cvt.u32.u64 %0, %1;" : "=r"(r53) : "l"(rd11));
  // PTX:834 setp.lt.s32 %p22, %r53, 0
  p22 = (((int)(r53)) < ((int)(0)));
  // PTX:835 mul.f32 %f502, %f31, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f502) : "f"(f31), "f"(f23));
  // PTX:836 mul.f32 %f503, %f502, %f502
  asm("mul.f32 %0, %1, %2;" : "=f"(f503) : "f"(f502), "f"(f502));
  // PTX:837 mul.f32 %f504, %f31, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f504) : "f"(f31), "f"(f24));
  // PTX:838 mul.f32 %f505, %f504, %f502
  asm("mul.f32 %0, %1, %2;" : "=f"(f505) : "f"(f504), "f"(f502));
  // PTX:839 mul.f32 %f506, %f31, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f506) : "f"(f31), "f"(f25));
  // PTX:840 mul.f32 %f507, %f506, %f502
  asm("mul.f32 %0, %1, %2;" : "=f"(f507) : "f"(f506), "f"(f502));
  // PTX:841 mul.f32 %f508, %f504, %f504
  asm("mul.f32 %0, %1, %2;" : "=f"(f508) : "f"(f504), "f"(f504));
  // PTX:842 mul.f32 %f509, %f506, %f504
  asm("mul.f32 %0, %1, %2;" : "=f"(f509) : "f"(f506), "f"(f504));
  // PTX:843 mul.f32 %f510, %f506, %f506
  asm("mul.f32 %0, %1, %2;" : "=f"(f510) : "f"(f506), "f"(f506));
  // PTX:844 mul.f32 %f511, %f30, %f503
  asm("mul.f32 %0, %1, %2;" : "=f"(f511) : "f"(f30), "f"(f503));
  // PTX:845 mul.f32 %f512, %f30, %f505
  asm("mul.f32 %0, %1, %2;" : "=f"(f512) : "f"(f30), "f"(f505));
  // PTX:846 mul.f32 %f513, %f30, %f507
  asm("mul.f32 %0, %1, %2;" : "=f"(f513) : "f"(f30), "f"(f507));
  // PTX:847 mul.f32 %f514, %f30, %f508
  asm("mul.f32 %0, %1, %2;" : "=f"(f514) : "f"(f30), "f"(f508));
  // PTX:848 mul.f32 %f515, %f30, %f509
  asm("mul.f32 %0, %1, %2;" : "=f"(f515) : "f"(f30), "f"(f509));
  // PTX:849 mul.f32 %f516, %f30, %f510
  asm("mul.f32 %0, %1, %2;" : "=f"(f516) : "f"(f30), "f"(f510));
  // PTX:850 mul.lo.s64 %rd193, %rd25, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd193) : "l"(rd25));
  // PTX:851 add.s64 %rd194, %rd1, %rd193
  asm("add.s64 %0, %1, %2;" : "=l"(rd194) : "l"(rd1), "l"(rd193));
  // PTX:852 red.global.add.f32 [%rd194], %f511
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd194) + (0)))), (float)(f511));
  // PTX:853 add.s64 %rd195, %rd194, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd195) : "l"(rd194));
  // PTX:854 red.global.add.f32 [%rd195], %f512
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd195) + (0)))), (float)(f512));
  // PTX:855 add.s64 %rd196, %rd194, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd196) : "l"(rd194));
  // PTX:856 red.global.add.f32 [%rd196], %f513
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd196) + (0)))), (float)(f513));
  // PTX:857 add.s64 %rd197, %rd194, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd197) : "l"(rd194));
  // PTX:858 red.global.add.f32 [%rd197], %f512
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd197) + (0)))), (float)(f512));
  // PTX:859 add.s64 %rd198, %rd194, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd198) : "l"(rd194));
  // PTX:860 red.global.add.f32 [%rd198], %f514
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd198) + (0)))), (float)(f514));
  // PTX:861 add.s64 %rd199, %rd194, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd199) : "l"(rd194));
  // PTX:862 red.global.add.f32 [%rd199], %f515
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd199) + (0)))), (float)(f515));
  // PTX:863 add.s64 %rd200, %rd194, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd200) : "l"(rd194));
  // PTX:864 red.global.add.f32 [%rd200], %f513
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd200) + (0)))), (float)(f513));
  // PTX:865 add.s64 %rd201, %rd194, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd201) : "l"(rd194));
  // PTX:866 red.global.add.f32 [%rd201], %f515
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd201) + (0)))), (float)(f515));
  // PTX:867 add.s64 %rd202, %rd194, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd202) : "l"(rd194));
  // PTX:868 red.global.add.f32 [%rd202], %f516
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd202) + (0)))), (float)(f516));
  // PTX:869 mul.f32 %f526, %f32, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f526) : "f"(f32), "f"(f23));
  // PTX:870 mul.f32 %f527, %f526, %f526
  asm("mul.f32 %0, %1, %2;" : "=f"(f527) : "f"(f526), "f"(f526));
  // PTX:871 mul.f32 %f528, %f32, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f528) : "f"(f32), "f"(f24));
  // PTX:872 mul.f32 %f529, %f528, %f526
  asm("mul.f32 %0, %1, %2;" : "=f"(f529) : "f"(f528), "f"(f526));
  // PTX:873 mul.f32 %f530, %f32, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f530) : "f"(f32), "f"(f25));
  // PTX:874 mul.f32 %f531, %f530, %f526
  asm("mul.f32 %0, %1, %2;" : "=f"(f531) : "f"(f530), "f"(f526));
  // PTX:875 mul.f32 %f532, %f528, %f528
  asm("mul.f32 %0, %1, %2;" : "=f"(f532) : "f"(f528), "f"(f528));
  // PTX:876 mul.f32 %f533, %f530, %f528
  asm("mul.f32 %0, %1, %2;" : "=f"(f533) : "f"(f530), "f"(f528));
  // PTX:877 mul.f32 %f534, %f530, %f530
  asm("mul.f32 %0, %1, %2;" : "=f"(f534) : "f"(f530), "f"(f530));
  // PTX:878 mul.f32 %f535, %f30, %f527
  asm("mul.f32 %0, %1, %2;" : "=f"(f535) : "f"(f30), "f"(f527));
  // PTX:879 mul.f32 %f536, %f30, %f529
  asm("mul.f32 %0, %1, %2;" : "=f"(f536) : "f"(f30), "f"(f529));
  // PTX:880 mul.f32 %f537, %f30, %f531
  asm("mul.f32 %0, %1, %2;" : "=f"(f537) : "f"(f30), "f"(f531));
  // PTX:881 mul.f32 %f538, %f30, %f532
  asm("mul.f32 %0, %1, %2;" : "=f"(f538) : "f"(f30), "f"(f532));
  // PTX:882 mul.f32 %f539, %f30, %f533
  asm("mul.f32 %0, %1, %2;" : "=f"(f539) : "f"(f30), "f"(f533));
  // PTX:883 mul.f32 %f540, %f30, %f534
  asm("mul.f32 %0, %1, %2;" : "=f"(f540) : "f"(f30), "f"(f534));
  // PTX:884 mul.lo.s64 %rd203, %rd27, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd203) : "l"(rd27));
  // PTX:885 add.s64 %rd204, %rd1, %rd203
  asm("add.s64 %0, %1, %2;" : "=l"(rd204) : "l"(rd1), "l"(rd203));
  // PTX:886 red.global.add.f32 [%rd204], %f535
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd204) + (0)))), (float)(f535));
  // PTX:887 add.s64 %rd205, %rd204, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd205) : "l"(rd204));
  // PTX:888 red.global.add.f32 [%rd205], %f536
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd205) + (0)))), (float)(f536));
  // PTX:889 add.s64 %rd206, %rd204, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd206) : "l"(rd204));
  // PTX:890 red.global.add.f32 [%rd206], %f537
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd206) + (0)))), (float)(f537));
  // PTX:891 add.s64 %rd207, %rd204, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd207) : "l"(rd204));
  // PTX:892 red.global.add.f32 [%rd207], %f536
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd207) + (0)))), (float)(f536));
  // PTX:893 add.s64 %rd208, %rd204, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd208) : "l"(rd204));
  // PTX:894 red.global.add.f32 [%rd208], %f538
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd208) + (0)))), (float)(f538));
  // PTX:895 add.s64 %rd209, %rd204, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd209) : "l"(rd204));
  // PTX:896 red.global.add.f32 [%rd209], %f539
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd209) + (0)))), (float)(f539));
  // PTX:897 add.s64 %rd210, %rd204, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd210) : "l"(rd204));
  // PTX:898 red.global.add.f32 [%rd210], %f537
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd210) + (0)))), (float)(f537));
  // PTX:899 add.s64 %rd211, %rd204, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd211) : "l"(rd204));
  // PTX:900 red.global.add.f32 [%rd211], %f539
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd211) + (0)))), (float)(f539));
  // PTX:901 add.s64 %rd212, %rd204, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd212) : "l"(rd204));
  // PTX:902 red.global.add.f32 [%rd212], %f540
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd212) + (0)))), (float)(f540));
  // PTX:903 mul.f32 %f550, %f33, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f550) : "f"(f33), "f"(f23));
  // PTX:904 mul.f32 %f551, %f550, %f550
  asm("mul.f32 %0, %1, %2;" : "=f"(f551) : "f"(f550), "f"(f550));
  // PTX:905 mul.f32 %f552, %f33, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f552) : "f"(f33), "f"(f24));
  // PTX:906 mul.f32 %f553, %f552, %f550
  asm("mul.f32 %0, %1, %2;" : "=f"(f553) : "f"(f552), "f"(f550));
  // PTX:907 mul.f32 %f554, %f33, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f554) : "f"(f33), "f"(f25));
  // PTX:908 mul.f32 %f555, %f554, %f550
  asm("mul.f32 %0, %1, %2;" : "=f"(f555) : "f"(f554), "f"(f550));
  // PTX:909 mul.f32 %f556, %f552, %f552
  asm("mul.f32 %0, %1, %2;" : "=f"(f556) : "f"(f552), "f"(f552));
  // PTX:910 mul.f32 %f557, %f554, %f552
  asm("mul.f32 %0, %1, %2;" : "=f"(f557) : "f"(f554), "f"(f552));
  // PTX:911 mul.f32 %f558, %f554, %f554
  asm("mul.f32 %0, %1, %2;" : "=f"(f558) : "f"(f554), "f"(f554));
  // PTX:912 mul.f32 %f559, %f30, %f551
  asm("mul.f32 %0, %1, %2;" : "=f"(f559) : "f"(f30), "f"(f551));
  // PTX:913 mul.f32 %f560, %f30, %f553
  asm("mul.f32 %0, %1, %2;" : "=f"(f560) : "f"(f30), "f"(f553));
  // PTX:914 mul.f32 %f561, %f30, %f555
  asm("mul.f32 %0, %1, %2;" : "=f"(f561) : "f"(f30), "f"(f555));
  // PTX:915 mul.f32 %f562, %f30, %f556
  asm("mul.f32 %0, %1, %2;" : "=f"(f562) : "f"(f30), "f"(f556));
  // PTX:916 mul.f32 %f563, %f30, %f557
  asm("mul.f32 %0, %1, %2;" : "=f"(f563) : "f"(f30), "f"(f557));
  // PTX:917 mul.f32 %f564, %f30, %f558
  asm("mul.f32 %0, %1, %2;" : "=f"(f564) : "f"(f30), "f"(f558));
  // PTX:918 mul.lo.s64 %rd213, %rd29, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd213) : "l"(rd29));
  // PTX:919 add.s64 %rd214, %rd1, %rd213
  asm("add.s64 %0, %1, %2;" : "=l"(rd214) : "l"(rd1), "l"(rd213));
  // PTX:920 red.global.add.f32 [%rd214], %f559
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd214) + (0)))), (float)(f559));
  // PTX:921 add.s64 %rd215, %rd214, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd215) : "l"(rd214));
  // PTX:922 red.global.add.f32 [%rd215], %f560
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd215) + (0)))), (float)(f560));
  // PTX:923 add.s64 %rd216, %rd214, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd216) : "l"(rd214));
  // PTX:924 red.global.add.f32 [%rd216], %f561
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd216) + (0)))), (float)(f561));
  // PTX:925 add.s64 %rd217, %rd214, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd217) : "l"(rd214));
  // PTX:926 red.global.add.f32 [%rd217], %f560
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd217) + (0)))), (float)(f560));
  // PTX:927 add.s64 %rd218, %rd214, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd218) : "l"(rd214));
  // PTX:928 red.global.add.f32 [%rd218], %f562
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd218) + (0)))), (float)(f562));
  // PTX:929 add.s64 %rd219, %rd214, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd219) : "l"(rd214));
  // PTX:930 red.global.add.f32 [%rd219], %f563
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd219) + (0)))), (float)(f563));
  // PTX:931 add.s64 %rd220, %rd214, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd220) : "l"(rd214));
  // PTX:932 red.global.add.f32 [%rd220], %f561
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd220) + (0)))), (float)(f561));
  // PTX:933 add.s64 %rd221, %rd214, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd221) : "l"(rd214));
  // PTX:934 red.global.add.f32 [%rd221], %f563
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd221) + (0)))), (float)(f563));
  // PTX:935 add.s64 %rd222, %rd214, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd222) : "l"(rd214));
  // PTX:936 red.global.add.f32 [%rd222], %f564
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd222) + (0)))), (float)(f564));
  // PTX:937 mul.f32 %f574, %f34, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f574) : "f"(f34), "f"(f23));
  // PTX:938 mul.f32 %f575, %f574, %f574
  asm("mul.f32 %0, %1, %2;" : "=f"(f575) : "f"(f574), "f"(f574));
  // PTX:939 mul.f32 %f576, %f34, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f576) : "f"(f34), "f"(f24));
  // PTX:940 mul.f32 %f577, %f576, %f574
  asm("mul.f32 %0, %1, %2;" : "=f"(f577) : "f"(f576), "f"(f574));
  // PTX:941 mul.f32 %f578, %f34, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f578) : "f"(f34), "f"(f25));
  // PTX:942 mul.f32 %f579, %f578, %f574
  asm("mul.f32 %0, %1, %2;" : "=f"(f579) : "f"(f578), "f"(f574));
  // PTX:943 mul.f32 %f580, %f576, %f576
  asm("mul.f32 %0, %1, %2;" : "=f"(f580) : "f"(f576), "f"(f576));
  // PTX:944 mul.f32 %f581, %f578, %f576
  asm("mul.f32 %0, %1, %2;" : "=f"(f581) : "f"(f578), "f"(f576));
  // PTX:945 mul.f32 %f582, %f578, %f578
  asm("mul.f32 %0, %1, %2;" : "=f"(f582) : "f"(f578), "f"(f578));
  // PTX:946 mul.f32 %f583, %f30, %f575
  asm("mul.f32 %0, %1, %2;" : "=f"(f583) : "f"(f30), "f"(f575));
  // PTX:947 mul.f32 %f584, %f30, %f577
  asm("mul.f32 %0, %1, %2;" : "=f"(f584) : "f"(f30), "f"(f577));
  // PTX:948 mul.f32 %f585, %f30, %f579
  asm("mul.f32 %0, %1, %2;" : "=f"(f585) : "f"(f30), "f"(f579));
  // PTX:949 mul.f32 %f586, %f30, %f580
  asm("mul.f32 %0, %1, %2;" : "=f"(f586) : "f"(f30), "f"(f580));
  // PTX:950 mul.f32 %f587, %f30, %f581
  asm("mul.f32 %0, %1, %2;" : "=f"(f587) : "f"(f30), "f"(f581));
  // PTX:951 mul.f32 %f588, %f30, %f582
  asm("mul.f32 %0, %1, %2;" : "=f"(f588) : "f"(f30), "f"(f582));
  // PTX:952 mul.lo.s64 %rd223, %rd31, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd223) : "l"(rd31));
  // PTX:953 add.s64 %rd224, %rd1, %rd223
  asm("add.s64 %0, %1, %2;" : "=l"(rd224) : "l"(rd1), "l"(rd223));
  // PTX:954 red.global.add.f32 [%rd224], %f583
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd224) + (0)))), (float)(f583));
  // PTX:955 add.s64 %rd225, %rd224, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd225) : "l"(rd224));
  // PTX:956 red.global.add.f32 [%rd225], %f584
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd225) + (0)))), (float)(f584));
  // PTX:957 add.s64 %rd226, %rd224, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd226) : "l"(rd224));
  // PTX:958 red.global.add.f32 [%rd226], %f585
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd226) + (0)))), (float)(f585));
  // PTX:959 add.s64 %rd227, %rd224, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd227) : "l"(rd224));
  // PTX:960 red.global.add.f32 [%rd227], %f584
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd227) + (0)))), (float)(f584));
  // PTX:961 add.s64 %rd228, %rd224, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd228) : "l"(rd224));
  // PTX:962 red.global.add.f32 [%rd228], %f586
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd228) + (0)))), (float)(f586));
  // PTX:963 add.s64 %rd229, %rd224, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd229) : "l"(rd224));
  // PTX:964 red.global.add.f32 [%rd229], %f587
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd229) + (0)))), (float)(f587));
  // PTX:965 add.s64 %rd230, %rd224, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd230) : "l"(rd224));
  // PTX:966 red.global.add.f32 [%rd230], %f585
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd230) + (0)))), (float)(f585));
  // PTX:967 add.s64 %rd231, %rd224, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd231) : "l"(rd224));
  // PTX:968 red.global.add.f32 [%rd231], %f587
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd231) + (0)))), (float)(f587));
  // PTX:969 add.s64 %rd232, %rd224, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd232) : "l"(rd224));
  // PTX:970 red.global.add.f32 [%rd232], %f588
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd232) + (0)))), (float)(f588));
  // PTX:971 setp.le.f32 %p23, %f22, 0f322BCC77
  p23 = (!(isnan(((float)(f22))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f22)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:972 or.pred %p24, %p22, %p23
  p24 = ((p22) || (p23));
  // PTX:973 @%p24 bra $L__BB58_28
  if (p24) { goto L_BB58_28; }
  // PTX:975 ld.global.f32 %f598, [%rd24]
  f598 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (0)))));
  // PTX:976 ld.global.f32 %f599, [%rd26]
  f599 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (0)))));
  // PTX:977 ld.global.f32 %f600, [%rd26+4]
  f600 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (4)))));
  // PTX:978 ld.global.f32 %f601, [%rd26+8]
  f601 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (8)))));
  // PTX:979 ld.global.f32 %f602, [%rd28]
  f602 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (0)))));
  // PTX:980 ld.global.f32 %f603, [%rd24+4]
  f603 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (4)))));
  // PTX:981 mul.f32 %f604, %f603, %f602
  asm("mul.f32 %0, %1, %2;" : "=f"(f604) : "f"(f603), "f"(f602));
  // PTX:982 ld.global.f32 %f605, [%rd28+4]
  f605 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (4)))));
  // PTX:983 mul.f32 %f606, %f603, %f605
  asm("mul.f32 %0, %1, %2;" : "=f"(f606) : "f"(f603), "f"(f605));
  // PTX:984 ld.global.f32 %f607, [%rd28+8]
  f607 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (8)))));
  // PTX:985 mul.f32 %f608, %f603, %f607
  asm("mul.f32 %0, %1, %2;" : "=f"(f608) : "f"(f603), "f"(f607));
  // PTX:986 fma.rn.f32 %f609, %f598, %f599, %f604
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f609) : "f"(f598), "f"(f599), "f"(f604));
  // PTX:987 fma.rn.f32 %f610, %f598, %f600, %f606
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f610) : "f"(f598), "f"(f600), "f"(f606));
  // PTX:988 fma.rn.f32 %f611, %f598, %f601, %f608
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f611) : "f"(f598), "f"(f601), "f"(f608));
  // PTX:989 ld.global.f32 %f612, [%rd30]
  f612 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0)))));
  // PTX:990 ld.global.f32 %f613, [%rd24+8]
  f613 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (8)))));
  // PTX:991 ld.global.f32 %f614, [%rd30+4]
  f614 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (4)))));
  // PTX:992 ld.global.f32 %f615, [%rd30+8]
  f615 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (8)))));
  // PTX:993 fma.rn.f32 %f616, %f613, %f612, %f609
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f616) : "f"(f613), "f"(f612), "f"(f609));
  // PTX:994 fma.rn.f32 %f617, %f613, %f614, %f610
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f617) : "f"(f613), "f"(f614), "f"(f610));
  // PTX:995 fma.rn.f32 %f618, %f613, %f615, %f611
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f618) : "f"(f613), "f"(f615), "f"(f611));
  // PTX:996 ld.global.f32 %f619, [%rd32]
  f619 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (0)))));
  // PTX:997 ld.global.f32 %f620, [%rd24+12]
  f620 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (12)))));
  // PTX:998 ld.global.f32 %f621, [%rd32+4]
  f621 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (4)))));
  // PTX:999 ld.global.f32 %f622, [%rd32+8]
  f622 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (8)))));
  // PTX:1000 fma.rn.f32 %f623, %f620, %f619, %f616
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f623) : "f"(f620), "f"(f619), "f"(f616));
  // PTX:1001 fma.rn.f32 %f624, %f620, %f621, %f617
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f624) : "f"(f620), "f"(f621), "f"(f617));
  // PTX:1002 fma.rn.f32 %f625, %f620, %f622, %f618
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f625) : "f"(f620), "f"(f622), "f"(f618));
  // PTX:1003 sub.f32 %f626, %f623, %f775
  asm("sub.f32 %0, %1, %2;" : "=f"(f626) : "f"(f623), "f"(f775));
  // PTX:1004 sub.f32 %f627, %f624, %f776
  asm("sub.f32 %0, %1, %2;" : "=f"(f627) : "f"(f624), "f"(f776));
  // PTX:1005 sub.f32 %f628, %f625, %f777
  asm("sub.f32 %0, %1, %2;" : "=f"(f628) : "f"(f625), "f"(f777));
  // PTX:1006 mul.f32 %f629, %f627, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f629) : "f"(f627), "f"(f24));
  // PTX:1007 fma.rn.f32 %f630, %f626, %f23, %f629
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f630) : "f"(f626), "f"(f23), "f"(f629));
  // PTX:1008 fma.rn.f32 %f631, %f628, %f25, %f630
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f631) : "f"(f628), "f"(f25), "f"(f630));
  // PTX:1009 mul.f32 %f632, %f631, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f632) : "f"(f631), "f"(f23));
  // PTX:1010 mul.f32 %f633, %f631, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f633) : "f"(f631), "f"(f24));
  // PTX:1011 mul.f32 %f634, %f631, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f634) : "f"(f631), "f"(f25));
  // PTX:1012 sub.f32 %f635, %f626, %f632
  asm("sub.f32 %0, %1, %2;" : "=f"(f635) : "f"(f626), "f"(f632));
  // PTX:1013 sub.f32 %f636, %f627, %f633
  asm("sub.f32 %0, %1, %2;" : "=f"(f636) : "f"(f627), "f"(f633));
  // PTX:1014 sub.f32 %f637, %f628, %f634
  asm("sub.f32 %0, %1, %2;" : "=f"(f637) : "f"(f628), "f"(f634));
  // PTX:1015 div.rn.f32 %f638, %f635, %f22
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f638) : "f"(f635), "f"(f22));
  // PTX:1016 div.rn.f32 %f639, %f636, %f22
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f639) : "f"(f636), "f"(f22));
  // PTX:1017 div.rn.f32 %f640, %f637, %f22
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f640) : "f"(f637), "f"(f22));
  // PTX:1018 add.f32 %f641, %f638, %f23
  asm("add.f32 %0, %1, %2;" : "=f"(f641) : "f"(f638), "f"(f23));
  // PTX:1019 add.f32 %f642, %f639, %f24
  asm("add.f32 %0, %1, %2;" : "=f"(f642) : "f"(f639), "f"(f24));
  // PTX:1020 add.f32 %f643, %f640, %f25
  asm("add.f32 %0, %1, %2;" : "=f"(f643) : "f"(f640), "f"(f25));
  // PTX:1021 ld.global.f32 %f644, [%rd12+4]
  f644 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (4)))));
  // PTX:1022 ld.global.f32 %f645, [%rd12+8]
  f645 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (8)))));
  // PTX:1023 ld.global.f32 %f646, [%rd12+12]
  f646 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (12)))));
  // PTX:1024 ld.global.f32 %f647, [%rd13+4]
  f647 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4)))));
  // PTX:1025 ld.global.f32 %f648, [%rd13+8]
  f648 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8)))));
  // PTX:1026 ld.global.f32 %f649, [%rd13+12]
  f649 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (12)))));
  // PTX:1027 ld.global.f32 %f650, [%rd12]
  f650 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (0)))));
  // PTX:1028 mul.f32 %f651, %f641, %f650
  asm("mul.f32 %0, %1, %2;" : "=f"(f651) : "f"(f641), "f"(f650));
  // PTX:1029 mul.f32 %f652, %f642, %f650
  asm("mul.f32 %0, %1, %2;" : "=f"(f652) : "f"(f642), "f"(f650));
  // PTX:1030 mul.f32 %f653, %f643, %f650
  asm("mul.f32 %0, %1, %2;" : "=f"(f653) : "f"(f643), "f"(f650));
  // PTX:1031 ld.global.f32 %f654, [%rd13]
  f654 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))));
  // PTX:1032 mul.f32 %f655, %f638, %f654
  asm("mul.f32 %0, %1, %2;" : "=f"(f655) : "f"(f638), "f"(f654));
  // PTX:1033 mul.f32 %f656, %f639, %f654
  asm("mul.f32 %0, %1, %2;" : "=f"(f656) : "f"(f639), "f"(f654));
  // PTX:1034 mul.f32 %f657, %f640, %f654
  asm("mul.f32 %0, %1, %2;" : "=f"(f657) : "f"(f640), "f"(f654));
  // PTX:1035 sub.f32 %f658, %f655, %f651
  asm("sub.f32 %0, %1, %2;" : "=f"(f658) : "f"(f655), "f"(f651));
  // PTX:1036 sub.f32 %f659, %f656, %f652
  asm("sub.f32 %0, %1, %2;" : "=f"(f659) : "f"(f656), "f"(f652));
  // PTX:1037 sub.f32 %f660, %f657, %f653
  asm("sub.f32 %0, %1, %2;" : "=f"(f660) : "f"(f657), "f"(f653));
  // PTX:1038 mul.f32 %f661, %f658, %f658
  asm("mul.f32 %0, %1, %2;" : "=f"(f661) : "f"(f658), "f"(f658));
  // PTX:1039 mul.f32 %f662, %f659, %f658
  asm("mul.f32 %0, %1, %2;" : "=f"(f662) : "f"(f659), "f"(f658));
  // PTX:1040 mul.f32 %f663, %f660, %f658
  asm("mul.f32 %0, %1, %2;" : "=f"(f663) : "f"(f660), "f"(f658));
  // PTX:1041 mul.f32 %f664, %f659, %f659
  asm("mul.f32 %0, %1, %2;" : "=f"(f664) : "f"(f659), "f"(f659));
  // PTX:1042 mul.f32 %f665, %f660, %f659
  asm("mul.f32 %0, %1, %2;" : "=f"(f665) : "f"(f660), "f"(f659));
  // PTX:1043 mul.f32 %f666, %f660, %f660
  asm("mul.f32 %0, %1, %2;" : "=f"(f666) : "f"(f660), "f"(f660));
  // PTX:1044 mul.f32 %f667, %f30, %f661
  asm("mul.f32 %0, %1, %2;" : "=f"(f667) : "f"(f30), "f"(f661));
  // PTX:1045 mul.f32 %f668, %f30, %f662
  asm("mul.f32 %0, %1, %2;" : "=f"(f668) : "f"(f30), "f"(f662));
  // PTX:1046 mul.f32 %f669, %f30, %f663
  asm("mul.f32 %0, %1, %2;" : "=f"(f669) : "f"(f30), "f"(f663));
  // PTX:1047 mul.f32 %f670, %f30, %f664
  asm("mul.f32 %0, %1, %2;" : "=f"(f670) : "f"(f30), "f"(f664));
  // PTX:1048 mul.f32 %f671, %f30, %f665
  asm("mul.f32 %0, %1, %2;" : "=f"(f671) : "f"(f30), "f"(f665));
  // PTX:1049 mul.f32 %f672, %f30, %f666
  asm("mul.f32 %0, %1, %2;" : "=f"(f672) : "f"(f30), "f"(f666));
  // PTX:1050 mul.lo.s64 %rd233, %rd275, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd233) : "l"(rd275));
  // PTX:1051 add.s64 %rd234, %rd1, %rd233
  asm("add.s64 %0, %1, %2;" : "=l"(rd234) : "l"(rd1), "l"(rd233));
  // PTX:1052 red.global.add.f32 [%rd234], %f667
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd234) + (0)))), (float)(f667));
  // PTX:1053 add.s64 %rd235, %rd234, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd235) : "l"(rd234));
  // PTX:1054 red.global.add.f32 [%rd235], %f668
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd235) + (0)))), (float)(f668));
  // PTX:1055 add.s64 %rd236, %rd234, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd236) : "l"(rd234));
  // PTX:1056 red.global.add.f32 [%rd236], %f669
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd236) + (0)))), (float)(f669));
  // PTX:1057 add.s64 %rd237, %rd234, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd237) : "l"(rd234));
  // PTX:1058 red.global.add.f32 [%rd237], %f668
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd237) + (0)))), (float)(f668));
  // PTX:1059 add.s64 %rd238, %rd234, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd238) : "l"(rd234));
  // PTX:1060 red.global.add.f32 [%rd238], %f670
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd238) + (0)))), (float)(f670));
  // PTX:1061 add.s64 %rd239, %rd234, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd239) : "l"(rd234));
  // PTX:1062 red.global.add.f32 [%rd239], %f671
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd239) + (0)))), (float)(f671));
  // PTX:1063 add.s64 %rd240, %rd234, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd240) : "l"(rd234));
  // PTX:1064 red.global.add.f32 [%rd240], %f669
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd240) + (0)))), (float)(f669));
  // PTX:1065 add.s64 %rd241, %rd234, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd241) : "l"(rd234));
  // PTX:1066 red.global.add.f32 [%rd241], %f671
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd241) + (0)))), (float)(f671));
  // PTX:1067 add.s64 %rd242, %rd234, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd242) : "l"(rd234));
  // PTX:1068 red.global.add.f32 [%rd242], %f672
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd242) + (0)))), (float)(f672));
  // PTX:1069 mul.f32 %f682, %f641, %f644
  asm("mul.f32 %0, %1, %2;" : "=f"(f682) : "f"(f641), "f"(f644));
  // PTX:1070 mul.f32 %f683, %f642, %f644
  asm("mul.f32 %0, %1, %2;" : "=f"(f683) : "f"(f642), "f"(f644));
  // PTX:1071 mul.f32 %f684, %f643, %f644
  asm("mul.f32 %0, %1, %2;" : "=f"(f684) : "f"(f643), "f"(f644));
  // PTX:1072 mul.f32 %f685, %f638, %f647
  asm("mul.f32 %0, %1, %2;" : "=f"(f685) : "f"(f638), "f"(f647));
  // PTX:1073 mul.f32 %f686, %f639, %f647
  asm("mul.f32 %0, %1, %2;" : "=f"(f686) : "f"(f639), "f"(f647));
  // PTX:1074 mul.f32 %f687, %f640, %f647
  asm("mul.f32 %0, %1, %2;" : "=f"(f687) : "f"(f640), "f"(f647));
  // PTX:1075 sub.f32 %f688, %f685, %f682
  asm("sub.f32 %0, %1, %2;" : "=f"(f688) : "f"(f685), "f"(f682));
  // PTX:1076 sub.f32 %f689, %f686, %f683
  asm("sub.f32 %0, %1, %2;" : "=f"(f689) : "f"(f686), "f"(f683));
  // PTX:1077 sub.f32 %f690, %f687, %f684
  asm("sub.f32 %0, %1, %2;" : "=f"(f690) : "f"(f687), "f"(f684));
  // PTX:1078 mul.f32 %f691, %f688, %f688
  asm("mul.f32 %0, %1, %2;" : "=f"(f691) : "f"(f688), "f"(f688));
  // PTX:1079 mul.f32 %f692, %f689, %f688
  asm("mul.f32 %0, %1, %2;" : "=f"(f692) : "f"(f689), "f"(f688));
  // PTX:1080 mul.f32 %f693, %f690, %f688
  asm("mul.f32 %0, %1, %2;" : "=f"(f693) : "f"(f690), "f"(f688));
  // PTX:1081 mul.f32 %f694, %f689, %f689
  asm("mul.f32 %0, %1, %2;" : "=f"(f694) : "f"(f689), "f"(f689));
  // PTX:1082 mul.f32 %f695, %f690, %f689
  asm("mul.f32 %0, %1, %2;" : "=f"(f695) : "f"(f690), "f"(f689));
  // PTX:1083 mul.f32 %f696, %f690, %f690
  asm("mul.f32 %0, %1, %2;" : "=f"(f696) : "f"(f690), "f"(f690));
  // PTX:1084 mul.f32 %f697, %f30, %f691
  asm("mul.f32 %0, %1, %2;" : "=f"(f697) : "f"(f30), "f"(f691));
  // PTX:1085 mul.f32 %f698, %f30, %f692
  asm("mul.f32 %0, %1, %2;" : "=f"(f698) : "f"(f30), "f"(f692));
  // PTX:1086 mul.f32 %f699, %f30, %f693
  asm("mul.f32 %0, %1, %2;" : "=f"(f699) : "f"(f30), "f"(f693));
  // PTX:1087 mul.f32 %f700, %f30, %f694
  asm("mul.f32 %0, %1, %2;" : "=f"(f700) : "f"(f30), "f"(f694));
  // PTX:1088 mul.f32 %f701, %f30, %f695
  asm("mul.f32 %0, %1, %2;" : "=f"(f701) : "f"(f30), "f"(f695));
  // PTX:1089 mul.f32 %f702, %f30, %f696
  asm("mul.f32 %0, %1, %2;" : "=f"(f702) : "f"(f30), "f"(f696));
  // PTX:1090 mul.lo.s64 %rd243, %rd276, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd243) : "l"(rd276));
  // PTX:1091 add.s64 %rd244, %rd1, %rd243
  asm("add.s64 %0, %1, %2;" : "=l"(rd244) : "l"(rd1), "l"(rd243));
  // PTX:1092 red.global.add.f32 [%rd244], %f697
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd244) + (0)))), (float)(f697));
  // PTX:1093 add.s64 %rd245, %rd244, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd245) : "l"(rd244));
  // PTX:1094 red.global.add.f32 [%rd245], %f698
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd245) + (0)))), (float)(f698));
  // PTX:1095 add.s64 %rd246, %rd244, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd246) : "l"(rd244));
  // PTX:1096 red.global.add.f32 [%rd246], %f699
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd246) + (0)))), (float)(f699));
  // PTX:1097 add.s64 %rd247, %rd244, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd247) : "l"(rd244));
  // PTX:1098 red.global.add.f32 [%rd247], %f698
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd247) + (0)))), (float)(f698));
  // PTX:1099 add.s64 %rd248, %rd244, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd248) : "l"(rd244));
  // PTX:1100 red.global.add.f32 [%rd248], %f700
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd248) + (0)))), (float)(f700));
  // PTX:1101 add.s64 %rd249, %rd244, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd249) : "l"(rd244));
  // PTX:1102 red.global.add.f32 [%rd249], %f701
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd249) + (0)))), (float)(f701));
  // PTX:1103 add.s64 %rd250, %rd244, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd250) : "l"(rd244));
  // PTX:1104 red.global.add.f32 [%rd250], %f699
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd250) + (0)))), (float)(f699));
  // PTX:1105 add.s64 %rd251, %rd244, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd251) : "l"(rd244));
  // PTX:1106 red.global.add.f32 [%rd251], %f701
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd251) + (0)))), (float)(f701));
  // PTX:1107 add.s64 %rd252, %rd244, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd252) : "l"(rd244));
  // PTX:1108 red.global.add.f32 [%rd252], %f702
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd252) + (0)))), (float)(f702));
  // PTX:1109 mul.f32 %f712, %f641, %f645
  asm("mul.f32 %0, %1, %2;" : "=f"(f712) : "f"(f641), "f"(f645));
  // PTX:1110 mul.f32 %f713, %f642, %f645
  asm("mul.f32 %0, %1, %2;" : "=f"(f713) : "f"(f642), "f"(f645));
  // PTX:1111 mul.f32 %f714, %f643, %f645
  asm("mul.f32 %0, %1, %2;" : "=f"(f714) : "f"(f643), "f"(f645));
  // PTX:1112 mul.f32 %f715, %f638, %f648
  asm("mul.f32 %0, %1, %2;" : "=f"(f715) : "f"(f638), "f"(f648));
  // PTX:1113 mul.f32 %f716, %f639, %f648
  asm("mul.f32 %0, %1, %2;" : "=f"(f716) : "f"(f639), "f"(f648));
  // PTX:1114 mul.f32 %f717, %f640, %f648
  asm("mul.f32 %0, %1, %2;" : "=f"(f717) : "f"(f640), "f"(f648));
  // PTX:1115 sub.f32 %f718, %f715, %f712
  asm("sub.f32 %0, %1, %2;" : "=f"(f718) : "f"(f715), "f"(f712));
  // PTX:1116 sub.f32 %f719, %f716, %f713
  asm("sub.f32 %0, %1, %2;" : "=f"(f719) : "f"(f716), "f"(f713));
  // PTX:1117 sub.f32 %f720, %f717, %f714
  asm("sub.f32 %0, %1, %2;" : "=f"(f720) : "f"(f717), "f"(f714));
  // PTX:1118 mul.f32 %f721, %f718, %f718
  asm("mul.f32 %0, %1, %2;" : "=f"(f721) : "f"(f718), "f"(f718));
  // PTX:1119 mul.f32 %f722, %f719, %f718
  asm("mul.f32 %0, %1, %2;" : "=f"(f722) : "f"(f719), "f"(f718));
  // PTX:1120 mul.f32 %f723, %f720, %f718
  asm("mul.f32 %0, %1, %2;" : "=f"(f723) : "f"(f720), "f"(f718));
  // PTX:1121 mul.f32 %f724, %f719, %f719
  asm("mul.f32 %0, %1, %2;" : "=f"(f724) : "f"(f719), "f"(f719));
  // PTX:1122 mul.f32 %f725, %f720, %f719
  asm("mul.f32 %0, %1, %2;" : "=f"(f725) : "f"(f720), "f"(f719));
  // PTX:1123 mul.f32 %f726, %f720, %f720
  asm("mul.f32 %0, %1, %2;" : "=f"(f726) : "f"(f720), "f"(f720));
  // PTX:1124 mul.f32 %f727, %f30, %f721
  asm("mul.f32 %0, %1, %2;" : "=f"(f727) : "f"(f30), "f"(f721));
  // PTX:1125 mul.f32 %f728, %f30, %f722
  asm("mul.f32 %0, %1, %2;" : "=f"(f728) : "f"(f30), "f"(f722));
  // PTX:1126 mul.f32 %f729, %f30, %f723
  asm("mul.f32 %0, %1, %2;" : "=f"(f729) : "f"(f30), "f"(f723));
  // PTX:1127 mul.f32 %f730, %f30, %f724
  asm("mul.f32 %0, %1, %2;" : "=f"(f730) : "f"(f30), "f"(f724));
  // PTX:1128 mul.f32 %f731, %f30, %f725
  asm("mul.f32 %0, %1, %2;" : "=f"(f731) : "f"(f30), "f"(f725));
  // PTX:1129 mul.f32 %f732, %f30, %f726
  asm("mul.f32 %0, %1, %2;" : "=f"(f732) : "f"(f30), "f"(f726));
  // PTX:1130 mul.lo.s64 %rd253, %rd277, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd253) : "l"(rd277));
  // PTX:1131 add.s64 %rd254, %rd1, %rd253
  asm("add.s64 %0, %1, %2;" : "=l"(rd254) : "l"(rd1), "l"(rd253));
  // PTX:1132 red.global.add.f32 [%rd254], %f727
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd254) + (0)))), (float)(f727));
  // PTX:1133 add.s64 %rd255, %rd254, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd255) : "l"(rd254));
  // PTX:1134 red.global.add.f32 [%rd255], %f728
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd255) + (0)))), (float)(f728));
  // PTX:1135 add.s64 %rd256, %rd254, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd256) : "l"(rd254));
  // PTX:1136 red.global.add.f32 [%rd256], %f729
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd256) + (0)))), (float)(f729));
  // PTX:1137 add.s64 %rd257, %rd254, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd257) : "l"(rd254));
  // PTX:1138 red.global.add.f32 [%rd257], %f728
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd257) + (0)))), (float)(f728));
  // PTX:1139 add.s64 %rd258, %rd254, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd258) : "l"(rd254));
  // PTX:1140 red.global.add.f32 [%rd258], %f730
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd258) + (0)))), (float)(f730));
  // PTX:1141 add.s64 %rd259, %rd254, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd259) : "l"(rd254));
  // PTX:1142 red.global.add.f32 [%rd259], %f731
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd259) + (0)))), (float)(f731));
  // PTX:1143 add.s64 %rd260, %rd254, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd260) : "l"(rd254));
  // PTX:1144 red.global.add.f32 [%rd260], %f729
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd260) + (0)))), (float)(f729));
  // PTX:1145 add.s64 %rd261, %rd254, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd261) : "l"(rd254));
  // PTX:1146 red.global.add.f32 [%rd261], %f731
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd261) + (0)))), (float)(f731));
  // PTX:1147 add.s64 %rd262, %rd254, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd262) : "l"(rd254));
  // PTX:1148 red.global.add.f32 [%rd262], %f732
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd262) + (0)))), (float)(f732));
  // PTX:1149 mul.f32 %f742, %f641, %f646
  asm("mul.f32 %0, %1, %2;" : "=f"(f742) : "f"(f641), "f"(f646));
  // PTX:1150 mul.f32 %f743, %f642, %f646
  asm("mul.f32 %0, %1, %2;" : "=f"(f743) : "f"(f642), "f"(f646));
  // PTX:1151 mul.f32 %f744, %f643, %f646
  asm("mul.f32 %0, %1, %2;" : "=f"(f744) : "f"(f643), "f"(f646));
  // PTX:1152 mul.f32 %f745, %f638, %f649
  asm("mul.f32 %0, %1, %2;" : "=f"(f745) : "f"(f638), "f"(f649));
  // PTX:1153 mul.f32 %f746, %f639, %f649
  asm("mul.f32 %0, %1, %2;" : "=f"(f746) : "f"(f639), "f"(f649));
  // PTX:1154 mul.f32 %f747, %f640, %f649
  asm("mul.f32 %0, %1, %2;" : "=f"(f747) : "f"(f640), "f"(f649));
  // PTX:1155 sub.f32 %f748, %f745, %f742
  asm("sub.f32 %0, %1, %2;" : "=f"(f748) : "f"(f745), "f"(f742));
  // PTX:1156 sub.f32 %f749, %f746, %f743
  asm("sub.f32 %0, %1, %2;" : "=f"(f749) : "f"(f746), "f"(f743));
  // PTX:1157 sub.f32 %f750, %f747, %f744
  asm("sub.f32 %0, %1, %2;" : "=f"(f750) : "f"(f747), "f"(f744));
  // PTX:1158 mul.f32 %f751, %f748, %f748
  asm("mul.f32 %0, %1, %2;" : "=f"(f751) : "f"(f748), "f"(f748));
  // PTX:1159 mul.f32 %f752, %f749, %f748
  asm("mul.f32 %0, %1, %2;" : "=f"(f752) : "f"(f749), "f"(f748));
  // PTX:1160 mul.f32 %f753, %f750, %f748
  asm("mul.f32 %0, %1, %2;" : "=f"(f753) : "f"(f750), "f"(f748));
  // PTX:1161 mul.f32 %f754, %f749, %f749
  asm("mul.f32 %0, %1, %2;" : "=f"(f754) : "f"(f749), "f"(f749));
  // PTX:1162 mul.f32 %f755, %f750, %f749
  asm("mul.f32 %0, %1, %2;" : "=f"(f755) : "f"(f750), "f"(f749));
  // PTX:1163 mul.f32 %f756, %f750, %f750
  asm("mul.f32 %0, %1, %2;" : "=f"(f756) : "f"(f750), "f"(f750));
  // PTX:1164 mul.f32 %f757, %f30, %f751
  asm("mul.f32 %0, %1, %2;" : "=f"(f757) : "f"(f30), "f"(f751));
  // PTX:1165 mul.f32 %f758, %f30, %f752
  asm("mul.f32 %0, %1, %2;" : "=f"(f758) : "f"(f30), "f"(f752));
  // PTX:1166 mul.f32 %f759, %f30, %f753
  asm("mul.f32 %0, %1, %2;" : "=f"(f759) : "f"(f30), "f"(f753));
  // PTX:1167 mul.f32 %f760, %f30, %f754
  asm("mul.f32 %0, %1, %2;" : "=f"(f760) : "f"(f30), "f"(f754));
  // PTX:1168 mul.f32 %f761, %f30, %f755
  asm("mul.f32 %0, %1, %2;" : "=f"(f761) : "f"(f30), "f"(f755));
  // PTX:1169 mul.f32 %f762, %f30, %f756
  asm("mul.f32 %0, %1, %2;" : "=f"(f762) : "f"(f30), "f"(f756));
  // PTX:1170 mul.lo.s64 %rd263, %rd278, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd263) : "l"(rd278));
  // PTX:1171 add.s64 %rd264, %rd1, %rd263
  asm("add.s64 %0, %1, %2;" : "=l"(rd264) : "l"(rd1), "l"(rd263));
  // PTX:1172 red.global.add.f32 [%rd264], %f757
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd264) + (0)))), (float)(f757));
  // PTX:1173 add.s64 %rd265, %rd264, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd265) : "l"(rd264));
  // PTX:1174 red.global.add.f32 [%rd265], %f758
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd265) + (0)))), (float)(f758));
  // PTX:1175 add.s64 %rd266, %rd264, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd266) : "l"(rd264));
  // PTX:1176 red.global.add.f32 [%rd266], %f759
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd266) + (0)))), (float)(f759));
  // PTX:1177 add.s64 %rd267, %rd264, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd267) : "l"(rd264));
  // PTX:1178 red.global.add.f32 [%rd267], %f758
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd267) + (0)))), (float)(f758));
  // PTX:1179 add.s64 %rd268, %rd264, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd268) : "l"(rd264));
  // PTX:1180 red.global.add.f32 [%rd268], %f760
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd268) + (0)))), (float)(f760));
  // PTX:1181 add.s64 %rd269, %rd264, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd269) : "l"(rd264));
  // PTX:1182 red.global.add.f32 [%rd269], %f761
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd269) + (0)))), (float)(f761));
  // PTX:1183 add.s64 %rd270, %rd264, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd270) : "l"(rd264));
  // PTX:1184 red.global.add.f32 [%rd270], %f759
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd270) + (0)))), (float)(f759));
  // PTX:1185 add.s64 %rd271, %rd264, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd271) : "l"(rd264));
  // PTX:1186 red.global.add.f32 [%rd271], %f761
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd271) + (0)))), (float)(f761));
  // PTX:1187 add.s64 %rd272, %rd264, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd272) : "l"(rd264));
  // PTX:1188 red.global.add.f32 [%rd272], %f762
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd272) + (0)))), (float)(f762));
  // PTX:1190 $L__BB58_28:
L_BB58_28:;
  // PTX:1191 ret
  return;
}
