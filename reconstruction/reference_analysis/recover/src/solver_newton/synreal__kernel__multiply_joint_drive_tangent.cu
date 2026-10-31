// 机械还原自 PTX：synreal::kernel::multiply_joint_drive_tangent(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, int const*, int const*, float const*, float const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: f12048999e8f94da1153bbf68cd7a2193780d004d80a07c3c49a2c006ce3f6ef
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__multiply_joint_drive_tangent(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10, unsigned long long param11, unsigned long long param12, unsigned long long param13, unsigned long long param14, unsigned long long param15, unsigned long long param16, float param17, unsigned long long param18, unsigned long long param19, unsigned long long param20, unsigned long long param21) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440, f441, f442, f443, f444, f445, f446, f447, f448, f449, f450, f451, f452, f453, f454, f455, f456, f457, f458, f459, f460, f461, f462, f463, f464, f465, f466, f467, f468, f469, f470, f471, f472, f473, f474, f475, f476, f477, f478, f479, f480, f481, f482, f483, f484, f485, f486, f487, f488, f489, f490, f491, f492, f493, f494, f495, f496, f497, f498, f499, f500, f501, f502, f503, f504, f505, f506, f507, f508, f509, f510, f511, f512, f513, f514, f515, f516, f517, f518, f519, f520, f521, f522, f523, f524, f525, f526, f527, f528, f529, f530, f531, f532, f533, f534, f535, f536, f537, f538, f539, f540, f541, f542, f543, f544, f545, f546, f547, f548, f549, f550, f551, f552, f553, f554, f555, f556, f557, f558, f559, f560, f561, f562, f563, f564, f565, f566, f567, f568, f569, f570, f571, f572, f573, f574, f575, f576, f577, f578, f579, f580, f581, f582, f583, f584, f585, f586, f587, f588, f589, f590, f591, f592, f593, f594, f595, f596, f597, f598, f599, f600, f601, f602, f603, f604, f605, f606, f607, f608, f609, f610, f611, f612, f613, f614, f615, f616, f617, f618, f619, f620, f621, f622, f623, f624, f625, f626, f627, f628, f629, f630, f631, f632, f633, f634, f635, f636, f637, f638, f639, f640, f641, f642, f643, f644, f645, f646, f647, f648, f649, f650, f651, f652, f653, f654, f655, f656, f657, f658, f659, f660, f661, f662, f663, f664, f665, f666, f667, f668, f669, f670, f671, f672, f673, f674, f675, f676, f677, f678, f679, f680, f681, f682, f683, f684, f685, f686, f687, f688, f689, f690, f691, f692, f693, f694, f695, f696, f697, f698, f699, f700, f701, f702, f703, f704, f705, f706, f707, f708, f709, f710, f711, f712, f713, f714, f715, f716, f717, f718, f719, f720, f721, f722, f723, f724, f725, f726, f727, f728, f729, f730, f731, f732, f733, f734, f735, f736, f737;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135, rd136, rd137, rd138, rd139, rd140, rd141, rd142, rd143, rd144, rd145, rd146, rd147, rd148, rd149, rd150, rd151, rd152, rd153, rd154, rd155, rd156, rd157, rd158, rd159, rd160, rd161, rd162, rd163, rd164, rd165, rd166, rd167, rd168, rd169, rd170, rd171, rd172, rd173, rd174, rd175, rd176, rd177, rd178, rd179, rd180, rd181, rd182, rd183, rd184, rd185, rd186, rd187, rd188, rd189, rd190, rd191, rd192, rd193, rd194, rd195, rd196, rd197, rd198, rd199, rd200, rd201, rd202, rd203, rd204, rd205, rd206, rd207, rd208, rd209, rd210, rd211, rd212, rd213, rd214, rd215, rd216, rd217, rd218, rd219, rd220, rd221, rd222, rd223, rd224, rd225, rd226, rd227, rd228, rd229, rd230, rd231, rd232, rd233, rd234, rd235, rd236, rd237, rd238, rd239, rd240;
  // PTX:38 ld.param.u64 %rd53, [_ZN7synreal6kernel28multiply_joint_drive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPS4_mmm_param_0]
  rd53 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:39 ld.param.u64 %rd54, [_ZN7synreal6kernel28multiply_joint_drive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPS4_mmm_param_1]
  rd54 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:40 ld.param.u64 %rd55, [_ZN7synreal6kernel28multiply_joint_drive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPS4_mmm_param_2]
  rd55 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:41 ld.param.u64 %rd37, [_ZN7synreal6kernel28multiply_joint_drive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPS4_mmm_param_3]
  rd37 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:42 ld.param.u64 %rd38, [_ZN7synreal6kernel28multiply_joint_drive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPS4_mmm_param_4]
  rd38 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:43 ld.param.u64 %rd39, [_ZN7synreal6kernel28multiply_joint_drive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPS4_mmm_param_5]
  rd39 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:44 ld.param.u64 %rd40, [_ZN7synreal6kernel28multiply_joint_drive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPS4_mmm_param_6]
  rd40 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:45 ld.param.u64 %rd41, [_ZN7synreal6kernel28multiply_joint_drive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPS4_mmm_param_7]
  rd41 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:46 ld.param.u64 %rd42, [_ZN7synreal6kernel28multiply_joint_drive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPS4_mmm_param_8]
  rd42 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:47 ld.param.u64 %rd43, [_ZN7synreal6kernel28multiply_joint_drive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPS4_mmm_param_9]
  rd43 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:48 ld.param.u64 %rd44, [_ZN7synreal6kernel28multiply_joint_drive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPS4_mmm_param_10]
  rd44 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:49 ld.param.u64 %rd45, [_ZN7synreal6kernel28multiply_joint_drive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPS4_mmm_param_11]
  rd45 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:50 ld.param.u64 %rd46, [_ZN7synreal6kernel28multiply_joint_drive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPS4_mmm_param_12]
  rd46 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:51 ld.param.u64 %rd47, [_ZN7synreal6kernel28multiply_joint_drive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPS4_mmm_param_13]
  rd47 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:52 ld.param.u64 %rd48, [_ZN7synreal6kernel28multiply_joint_drive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPS4_mmm_param_14]
  rd48 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:53 ld.param.u64 %rd49, [_ZN7synreal6kernel28multiply_joint_drive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPS4_mmm_param_15]
  rd49 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param15 + (0))));
  // PTX:54 ld.param.u64 %rd50, [_ZN7synreal6kernel28multiply_joint_drive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPS4_mmm_param_16]
  rd50 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param16 + (0))));
  // PTX:55 ld.param.f32 %f121, [_ZN7synreal6kernel28multiply_joint_drive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPS4_mmm_param_17]
  f121 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param17 + (0))));
  // PTX:56 ld.param.u64 %rd56, [_ZN7synreal6kernel28multiply_joint_drive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPS4_mmm_param_18]
  rd56 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param18 + (0))));
  // PTX:57 ld.param.u64 %rd57, [_ZN7synreal6kernel28multiply_joint_drive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPS4_mmm_param_19]
  rd57 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param19 + (0))));
  // PTX:58 ld.param.u64 %rd51, [_ZN7synreal6kernel28multiply_joint_drive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPS4_mmm_param_20]
  rd51 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param20 + (0))));
  // PTX:59 ld.param.u64 %rd52, [_ZN7synreal6kernel28multiply_joint_drive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPS4_mmm_param_21]
  rd52 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param21 + (0))));
  // PTX:60 cvta.to.global.u64 %rd1, %rd54
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd54));
  // PTX:61 cvta.to.global.u64 %rd2, %rd56
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd56));
  // PTX:62 cvta.to.global.u64 %rd3, %rd53
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd53));
  // PTX:63 cvta.to.global.u64 %rd4, %rd55
  rd4 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd55));
  // PTX:64 mov.u32 %r25, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r25) : "r"(blockIdx.x));
  // PTX:65 mov.u32 %r26, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r26) : "r"(blockDim.x));
  // PTX:66 mul.wide.u32 %rd58, %r25, %r26
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd58) : "r"(r25), "r"(r26));
  // PTX:67 mov.u32 %r27, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r27) : "r"(threadIdx.x));
  // PTX:68 cvt.u64.u32 %rd59, %r27
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd59) : "r"(r27));
  // PTX:69 add.s64 %rd5, %rd58, %rd59
  asm("add.s64 %0, %1, %2;" : "=l"(rd5) : "l"(rd58), "l"(rd59));
  // PTX:70 setp.ge.u64 %p1, %rd5, %rd57
  p1 = (((unsigned long long)(rd5)) >= ((unsigned long long)(rd57)));
  // PTX:71 @%p1 bra $L__BB32_37
  if (p1) { goto L_BB32_37; }
  // PTX:73 or.b64 %rd60, %rd5, %rd51
  asm("or.b64 %0, %1, %2;" : "=l"(rd60) : "l"(rd5), "l"(rd51));
  // PTX:74 and.b64 %rd61, %rd60, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd61) : "l"(rd60));
  // PTX:75 setp.eq.s64 %p2, %rd61, 0
  p2 = (((long long)(rd61)) == ((long long)(0)));
  // PTX:76 @%p2 bra $L__BB32_3
  if (p2) { goto L_BB32_3; }
  // PTX:78 div.u64 %rd235, %rd5, %rd51
  asm("div.u64 %0, %1, %2;" : "=l"(rd235) : "l"(rd5), "l"(rd51));
  // PTX:79 mul.lo.s64 %rd62, %rd235, %rd51
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd62) : "l"(rd235), "l"(rd51));
  // PTX:80 sub.s64 %rd236, %rd5, %rd62
  asm("sub.s64 %0, %1, %2;" : "=l"(rd236) : "l"(rd5), "l"(rd62));
  // PTX:81 bra.uni $L__BB32_4
  goto L_BB32_4;
  // PTX:83 $L__BB32_3:
L_BB32_3:;
  // PTX:84 cvt.u32.u64 %r28, %rd51
  asm("cvt.u32.u64 %0, %1;" : "=r"(r28) : "l"(rd51));
  // PTX:85 cvt.u32.u64 %r29, %rd5
  asm("cvt.u32.u64 %0, %1;" : "=r"(r29) : "l"(rd5));
  // PTX:86 div.u32 %r30, %r29, %r28
  asm("div.u32 %0, %1, %2;" : "=r"(r30) : "r"(r29), "r"(r28));
  // PTX:87 mul.lo.s32 %r31, %r30, %r28
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r31) : "r"(r30), "r"(r28));
  // PTX:88 sub.s32 %r32, %r29, %r31
  asm("sub.s32 %0, %1, %2;" : "=r"(r32) : "r"(r29), "r"(r31));
  // PTX:89 cvt.u64.u32 %rd235, %r30
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd235) : "r"(r30));
  // PTX:90 cvt.u64.u32 %rd236, %r32
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd236) : "r"(r32));
  // PTX:92 $L__BB32_4:
L_BB32_4:;
  // PTX:93 mul.lo.s64 %rd67, %rd235, %rd52
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd67) : "l"(rd235), "l"(rd52));
  // PTX:94 cvt.u32.u64 %r1, %rd67
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd67));
  // PTX:95 cvta.to.global.u64 %rd68, %rd38
  rd68 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd38));
  // PTX:96 shl.b64 %rd69, %rd236, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd69) : "l"(rd236));
  // PTX:97 add.s64 %rd70, %rd68, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd70) : "l"(rd68), "l"(rd69));
  // PTX:98 ld.global.s32 %rd12, [%rd70]
  rd12 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0)))));
  // PTX:99 mov.u64 %rd20, 0
  asm("mov.u64 %0, 0;" : "=l"(rd20) : );
  // PTX:100 ld.global.u32 %r33, [%rd70+4]
  r33 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (4)))));
  // PTX:101 mul.wide.s32 %rd71, %r33, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd71) : "r"(r33));
  // PTX:102 add.s64 %rd72, %rd4, %rd71
  asm("add.s64 %0, %1, %2;" : "=l"(rd72) : "l"(rd4), "l"(rd71));
  // PTX:103 ld.global.u32 %r2, [%rd72]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (0)))));
  // PTX:104 ld.global.u32 %r34, [%rd72+4]
  r34 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (4)))));
  // PTX:105 add.s32 %r3, %r34, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r3) : "r"(r34), "r"(r1));
  // PTX:106 ld.global.u32 %r35, [%rd72+8]
  r35 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (8)))));
  // PTX:107 add.s32 %r4, %r35, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r4) : "r"(r35), "r"(r1));
  // PTX:108 ld.global.u32 %r36, [%rd72+12]
  r36 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (12)))));
  // PTX:109 add.s32 %r5, %r36, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r5) : "r"(r36), "r"(r1));
  // PTX:110 cvta.to.global.u64 %rd73, %rd39
  rd73 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd39));
  // PTX:111 mul.lo.s64 %rd74, %rd236, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd74) : "l"(rd236));
  // PTX:112 add.s64 %rd75, %rd73, %rd74
  asm("add.s64 %0, %1, %2;" : "=l"(rd75) : "l"(rd73), "l"(rd74));
  // PTX:113 ld.global.f32 %f16, [%rd75]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (0)))));
  // PTX:114 ld.global.f32 %f17, [%rd75+4]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (4)))));
  // PTX:115 ld.global.f32 %f18, [%rd75+8]
  f18 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (8)))));
  // PTX:116 cvta.to.global.u64 %rd76, %rd40
  rd76 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd40));
  // PTX:117 add.s64 %rd77, %rd76, %rd74
  asm("add.s64 %0, %1, %2;" : "=l"(rd77) : "l"(rd76), "l"(rd74));
  // PTX:118 ld.global.f32 %f714, [%rd77]
  f714 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (0)))));
  // PTX:119 ld.global.f32 %f715, [%rd77+4]
  f715 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (4)))));
  // PTX:120 ld.global.f32 %f716, [%rd77+8]
  f716 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (8)))));
  // PTX:121 cvta.to.global.u64 %rd78, %rd41
  rd78 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd41));
  // PTX:122 add.s64 %rd79, %rd78, %rd74
  asm("add.s64 %0, %1, %2;" : "=l"(rd79) : "l"(rd78), "l"(rd74));
  // PTX:123 ld.global.u32 %r59, [%rd79+8]
  r59 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (8)))));
  // PTX:124 ld.global.u32 %r58, [%rd79+4]
  r58 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (4)))));
  // PTX:125 ld.global.u32 %r57, [%rd79]
  r57 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (0)))));
  // PTX:126 setp.lt.s64 %p3, %rd12, 0
  p3 = (((long long)(rd12)) < ((long long)(0)));
  // PTX:127 cvta.to.global.u64 %rd80, %rd42
  rd80 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd42));
  // PTX:128 shl.b64 %rd81, %rd236, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd81) : "l"(rd236));
  // PTX:129 add.s64 %rd13, %rd80, %rd81
  asm("add.s64 %0, %1, %2;" : "=l"(rd13) : "l"(rd80), "l"(rd81));
  // PTX:130 cvta.to.global.u64 %rd82, %rd44
  rd82 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd44));
  // PTX:131 add.s64 %rd14, %rd82, %rd81
  asm("add.s64 %0, %1, %2;" : "=l"(rd14) : "l"(rd82), "l"(rd81));
  // PTX:132 cvta.to.global.u64 %rd83, %rd45
  rd83 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd45));
  // PTX:133 add.s64 %rd15, %rd83, %rd81
  asm("add.s64 %0, %1, %2;" : "=l"(rd15) : "l"(rd83), "l"(rd81));
  // PTX:134 mov.u64 %rd21, %rd20
  asm("mov.u64 %0, %1;" : "=l"(rd21) : "l"(rd20));
  // PTX:135 mov.u64 %rd22, %rd20
  asm("mov.u64 %0, %1;" : "=l"(rd22) : "l"(rd20));
  // PTX:136 mov.u64 %rd23, %rd20
  asm("mov.u64 %0, %1;" : "=l"(rd23) : "l"(rd20));
  // PTX:137 @%p3 bra $L__BB32_6
  if (p3) { goto L_BB32_6; }
  // PTX:139 shl.b64 %rd84, %rd12, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd84) : "l"(rd12));
  // PTX:140 add.s64 %rd85, %rd4, %rd84
  asm("add.s64 %0, %1, %2;" : "=l"(rd85) : "l"(rd4), "l"(rd84));
  // PTX:141 ld.global.u32 %r37, [%rd85]
  r37 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (0)))));
  // PTX:142 add.s32 %r38, %r37, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r38) : "r"(r37), "r"(r1));
  // PTX:143 ld.global.u32 %r39, [%rd85+4]
  r39 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (4)))));
  // PTX:144 add.s32 %r40, %r39, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r40) : "r"(r39), "r"(r1));
  // PTX:145 ld.global.u32 %r41, [%rd85+8]
  r41 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (8)))));
  // PTX:146 add.s32 %r42, %r41, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r42) : "r"(r41), "r"(r1));
  // PTX:147 ld.global.u32 %r43, [%rd85+12]
  r43 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (12)))));
  // PTX:148 add.s32 %r44, %r43, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r44) : "r"(r43), "r"(r1));
  // PTX:149 cvt.s64.s32 %rd20, %r38
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd20) : "r"(r38));
  // PTX:150 mul.wide.s32 %rd86, %r38, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd86) : "r"(r38));
  // PTX:151 add.s64 %rd87, %rd3, %rd86
  asm("add.s64 %0, %1, %2;" : "=l"(rd87) : "l"(rd3), "l"(rd86));
  // PTX:152 ld.global.f32 %f122, [%rd87]
  f122 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (0)))));
  // PTX:153 ld.global.f32 %f123, [%rd13]
  f123 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))));
  // PTX:154 ld.global.f32 %f124, [%rd87+4]
  f124 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (4)))));
  // PTX:155 ld.global.f32 %f125, [%rd87+8]
  f125 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (8)))));
  // PTX:156 cvt.s64.s32 %rd21, %r40
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd21) : "r"(r40));
  // PTX:157 mul.wide.s32 %rd88, %r40, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd88) : "r"(r40));
  // PTX:158 add.s64 %rd89, %rd3, %rd88
  asm("add.s64 %0, %1, %2;" : "=l"(rd89) : "l"(rd3), "l"(rd88));
  // PTX:159 ld.global.f32 %f126, [%rd89]
  f126 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (0)))));
  // PTX:160 ld.global.f32 %f127, [%rd13+4]
  f127 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4)))));
  // PTX:161 mul.f32 %f128, %f127, %f126
  asm("mul.f32 %0, %1, %2;" : "=f"(f128) : "f"(f127), "f"(f126));
  // PTX:162 ld.global.f32 %f129, [%rd89+4]
  f129 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (4)))));
  // PTX:163 mul.f32 %f130, %f127, %f129
  asm("mul.f32 %0, %1, %2;" : "=f"(f130) : "f"(f127), "f"(f129));
  // PTX:164 ld.global.f32 %f131, [%rd89+8]
  f131 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (8)))));
  // PTX:165 mul.f32 %f132, %f127, %f131
  asm("mul.f32 %0, %1, %2;" : "=f"(f132) : "f"(f127), "f"(f131));
  // PTX:166 fma.rn.f32 %f133, %f123, %f122, %f128
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f133) : "f"(f123), "f"(f122), "f"(f128));
  // PTX:167 fma.rn.f32 %f134, %f123, %f124, %f130
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f134) : "f"(f123), "f"(f124), "f"(f130));
  // PTX:168 fma.rn.f32 %f135, %f123, %f125, %f132
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f135) : "f"(f123), "f"(f125), "f"(f132));
  // PTX:169 cvt.s64.s32 %rd22, %r42
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd22) : "r"(r42));
  // PTX:170 mul.wide.s32 %rd90, %r42, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd90) : "r"(r42));
  // PTX:171 add.s64 %rd91, %rd3, %rd90
  asm("add.s64 %0, %1, %2;" : "=l"(rd91) : "l"(rd3), "l"(rd90));
  // PTX:172 ld.global.f32 %f136, [%rd91]
  f136 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (0)))));
  // PTX:173 ld.global.f32 %f137, [%rd13+8]
  f137 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8)))));
  // PTX:174 ld.global.f32 %f138, [%rd91+4]
  f138 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (4)))));
  // PTX:175 ld.global.f32 %f139, [%rd91+8]
  f139 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (8)))));
  // PTX:176 fma.rn.f32 %f140, %f137, %f136, %f133
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f140) : "f"(f137), "f"(f136), "f"(f133));
  // PTX:177 fma.rn.f32 %f141, %f137, %f138, %f134
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f141) : "f"(f137), "f"(f138), "f"(f134));
  // PTX:178 fma.rn.f32 %f142, %f137, %f139, %f135
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f142) : "f"(f137), "f"(f139), "f"(f135));
  // PTX:179 cvt.s64.s32 %rd23, %r44
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd23) : "r"(r44));
  // PTX:180 mul.wide.s32 %rd92, %r44, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd92) : "r"(r44));
  // PTX:181 add.s64 %rd93, %rd3, %rd92
  asm("add.s64 %0, %1, %2;" : "=l"(rd93) : "l"(rd3), "l"(rd92));
  // PTX:182 ld.global.f32 %f143, [%rd93]
  f143 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (0)))));
  // PTX:183 ld.global.f32 %f144, [%rd13+12]
  f144 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (12)))));
  // PTX:184 ld.global.f32 %f145, [%rd93+4]
  f145 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (4)))));
  // PTX:185 ld.global.f32 %f146, [%rd93+8]
  f146 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (8)))));
  // PTX:186 fma.rn.f32 %f16, %f144, %f143, %f140
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f16) : "f"(f144), "f"(f143), "f"(f140));
  // PTX:187 fma.rn.f32 %f17, %f144, %f145, %f141
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f17) : "f"(f144), "f"(f145), "f"(f141));
  // PTX:188 fma.rn.f32 %f18, %f144, %f146, %f142
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f18) : "f"(f144), "f"(f146), "f"(f142));
  // PTX:189 ld.global.f32 %f147, [%rd14]
  f147 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:190 ld.global.f32 %f148, [%rd14+4]
  f148 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (4)))));
  // PTX:191 mul.f32 %f149, %f148, %f126
  asm("mul.f32 %0, %1, %2;" : "=f"(f149) : "f"(f148), "f"(f126));
  // PTX:192 mul.f32 %f150, %f148, %f129
  asm("mul.f32 %0, %1, %2;" : "=f"(f150) : "f"(f148), "f"(f129));
  // PTX:193 mul.f32 %f151, %f148, %f131
  asm("mul.f32 %0, %1, %2;" : "=f"(f151) : "f"(f148), "f"(f131));
  // PTX:194 fma.rn.f32 %f152, %f147, %f122, %f149
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f152) : "f"(f147), "f"(f122), "f"(f149));
  // PTX:195 fma.rn.f32 %f153, %f147, %f124, %f150
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f153) : "f"(f147), "f"(f124), "f"(f150));
  // PTX:196 fma.rn.f32 %f154, %f147, %f125, %f151
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f154) : "f"(f147), "f"(f125), "f"(f151));
  // PTX:197 ld.global.f32 %f155, [%rd14+8]
  f155 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (8)))));
  // PTX:198 fma.rn.f32 %f156, %f155, %f136, %f152
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f156) : "f"(f155), "f"(f136), "f"(f152));
  // PTX:199 fma.rn.f32 %f157, %f155, %f138, %f153
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f157) : "f"(f155), "f"(f138), "f"(f153));
  // PTX:200 fma.rn.f32 %f158, %f155, %f139, %f154
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f158) : "f"(f155), "f"(f139), "f"(f154));
  // PTX:201 ld.global.f32 %f159, [%rd14+12]
  f159 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (12)))));
  // PTX:202 fma.rn.f32 %f714, %f159, %f143, %f156
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f714) : "f"(f159), "f"(f143), "f"(f156));
  // PTX:203 fma.rn.f32 %f715, %f159, %f145, %f157
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f715) : "f"(f159), "f"(f145), "f"(f157));
  // PTX:204 fma.rn.f32 %f716, %f159, %f146, %f158
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f716) : "f"(f159), "f"(f146), "f"(f158));
  // PTX:205 ld.global.f32 %f160, [%rd15]
  f160 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))));
  // PTX:206 ld.global.f32 %f161, [%rd15+4]
  f161 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (4)))));
  // PTX:207 mul.f32 %f162, %f161, %f126
  asm("mul.f32 %0, %1, %2;" : "=f"(f162) : "f"(f161), "f"(f126));
  // PTX:208 mul.f32 %f163, %f161, %f129
  asm("mul.f32 %0, %1, %2;" : "=f"(f163) : "f"(f161), "f"(f129));
  // PTX:209 mul.f32 %f164, %f161, %f131
  asm("mul.f32 %0, %1, %2;" : "=f"(f164) : "f"(f161), "f"(f131));
  // PTX:210 fma.rn.f32 %f165, %f160, %f122, %f162
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f165) : "f"(f160), "f"(f122), "f"(f162));
  // PTX:211 fma.rn.f32 %f166, %f160, %f124, %f163
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f166) : "f"(f160), "f"(f124), "f"(f163));
  // PTX:212 fma.rn.f32 %f167, %f160, %f125, %f164
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f167) : "f"(f160), "f"(f125), "f"(f164));
  // PTX:213 ld.global.f32 %f168, [%rd15+8]
  f168 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (8)))));
  // PTX:214 fma.rn.f32 %f169, %f168, %f136, %f165
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f169) : "f"(f168), "f"(f136), "f"(f165));
  // PTX:215 fma.rn.f32 %f170, %f168, %f138, %f166
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f170) : "f"(f168), "f"(f138), "f"(f166));
  // PTX:216 fma.rn.f32 %f171, %f168, %f139, %f167
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f171) : "f"(f168), "f"(f139), "f"(f167));
  // PTX:217 ld.global.f32 %f172, [%rd15+12]
  f172 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (12)))));
  // PTX:218 fma.rn.f32 %f173, %f172, %f143, %f169
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f173) : "f"(f172), "f"(f143), "f"(f169));
  // PTX:219 fma.rn.f32 %f174, %f172, %f145, %f170
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f174) : "f"(f172), "f"(f145), "f"(f170));
  // PTX:220 fma.rn.f32 %f175, %f172, %f146, %f171
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f175) : "f"(f172), "f"(f146), "f"(f171));
  // PTX:221 mov.b32 %r59, %f175
  asm("mov.b32 %0, %1;" : "=r"(r59) : "f"(f175));
  // PTX:222 mov.b32 %r58, %f174
  asm("mov.b32 %0, %1;" : "=r"(r58) : "f"(f174));
  // PTX:223 mov.b32 %r57, %f173
  asm("mov.b32 %0, %1;" : "=r"(r57) : "f"(f173));
  // PTX:225 $L__BB32_6:
L_BB32_6:;
  // PTX:226 sub.f32 %f19, %f714, %f16
  asm("sub.f32 %0, %1, %2;" : "=f"(f19) : "f"(f714), "f"(f16));
  // PTX:227 sub.f32 %f20, %f715, %f17
  asm("sub.f32 %0, %1, %2;" : "=f"(f20) : "f"(f715), "f"(f17));
  // PTX:228 mul.f32 %f176, %f20, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f176) : "f"(f20), "f"(f20));
  // PTX:229 sub.f32 %f21, %f716, %f18
  asm("sub.f32 %0, %1, %2;" : "=f"(f21) : "f"(f716), "f"(f18));
  // PTX:230 fma.rn.f32 %f177, %f19, %f19, %f176
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f177) : "f"(f19), "f"(f19), "f"(f176));
  // PTX:231 fma.rn.f32 %f178, %f21, %f21, %f177
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f178) : "f"(f21), "f"(f21), "f"(f177));
  // PTX:232 sqrt.rn.f32 %f22, %f178
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f22) : "f"(f178));
  // PTX:233 setp.leu.f32 %p4, %f22, 0f00000000
  p4 = ((isnan(((float)(f22))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f22)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:234 add.s32 %r15, %r2, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r15) : "r"(r2), "r"(r1));
  // PTX:235 mov.u32 %r60, 0
  asm("mov.u32 %0, 0;" : "=r"(r60) : );
  // PTX:236 mov.u32 %r61, %r60
  asm("mov.u32 %0, %1;" : "=r"(r61) : "r"(r60));
  // PTX:237 mov.u32 %r62, %r60
  asm("mov.u32 %0, %1;" : "=r"(r62) : "r"(r60));
  // PTX:238 @%p4 bra $L__BB32_8
  if (p4) { goto L_BB32_8; }
  // PTX:240 div.rn.f32 %f179, %f19, %f22
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f179) : "f"(f19), "f"(f22));
  // PTX:241 div.rn.f32 %f180, %f20, %f22
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f180) : "f"(f20), "f"(f22));
  // PTX:242 div.rn.f32 %f181, %f21, %f22
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f181) : "f"(f21), "f"(f22));
  // PTX:243 mov.b32 %r62, %f181
  asm("mov.b32 %0, %1;" : "=r"(r62) : "f"(f181));
  // PTX:244 mov.b32 %r61, %f180
  asm("mov.b32 %0, %1;" : "=r"(r61) : "f"(f180));
  // PTX:245 mov.b32 %r60, %f179
  asm("mov.b32 %0, %1;" : "=r"(r60) : "f"(f179));
  // PTX:247 $L__BB32_8:
L_BB32_8:;
  // PTX:248 mov.b32 %f23, %r60
  asm("mov.b32 %0, %1;" : "=f"(f23) : "r"(r60));
  // PTX:249 mov.b32 %f24, %r61
  asm("mov.b32 %0, %1;" : "=f"(f24) : "r"(r61));
  // PTX:250 mul.f32 %f182, %f24, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f182) : "f"(f24), "f"(f24));
  // PTX:251 mov.b32 %f25, %r62
  asm("mov.b32 %0, %1;" : "=f"(f25) : "r"(r62));
  // PTX:252 fma.rn.f32 %f183, %f23, %f23, %f182
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f183) : "f"(f23), "f"(f23), "f"(f182));
  // PTX:253 fma.rn.f32 %f184, %f25, %f25, %f183
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f184) : "f"(f25), "f"(f25), "f"(f183));
  // PTX:254 sqrt.rn.f32 %f185, %f184
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f185) : "f"(f184));
  // PTX:255 setp.le.f32 %p5, %f185, 0f322BCC77
  p5 = (!(isnan(((float)(f185))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f185)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:256 @%p5 bra $L__BB32_37
  if (p5) { goto L_BB32_37; }
  // PTX:258 cvta.to.global.u64 %rd94, %rd47
  rd94 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd47));
  // PTX:259 shl.b64 %rd95, %rd236, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd95) : "l"(rd236));
  // PTX:260 add.s64 %rd96, %rd94, %rd95
  asm("add.s64 %0, %1, %2;" : "=l"(rd96) : "l"(rd94), "l"(rd95));
  // PTX:261 ld.global.s32 %rd24, [%rd96]
  rd24 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (0)))));
  // PTX:262 setp.eq.s64 %p6, %rd48, 0
  p6 = (((long long)(rd48)) == ((long long)(0)));
  // PTX:263 @%p6 bra $L__BB32_11
  if (p6) { goto L_BB32_11; }
  // PTX:265 cvta.to.global.u64 %rd97, %rd48
  rd97 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd48));
  // PTX:266 shl.b64 %rd98, %rd24, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd98) : "l"(rd24));
  // PTX:267 add.s64 %rd99, %rd97, %rd98
  asm("add.s64 %0, %1, %2;" : "=l"(rd99) : "l"(rd97), "l"(rd98));
  // PTX:268 ld.global.u32 %r48, [%rd99]
  r48 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (0)))));
  // PTX:269 add.s32 %r49, %r48, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r49) : "r"(r48));
  // PTX:270 setp.lt.u32 %p7, %r49, 3
  p7 = (((unsigned)(r49)) < ((unsigned)(3)));
  // PTX:271 mov.f32 %f720, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f720) : );
  // PTX:272 @%p7 bra $L__BB32_11
  if (p7) { goto L_BB32_11; }
  // PTX:273 bra.uni $L__BB32_12
  goto L_BB32_12;
  // PTX:275 $L__BB32_11:
L_BB32_11:;
  // PTX:276 cvt.u32.u64 %r50, %rd24
  asm("cvt.u32.u64 %0, %1;" : "=r"(r50) : "l"(rd24));
  // PTX:277 cvta.to.global.u64 %rd100, %rd50
  rd100 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd50));
  // PTX:278 mul.wide.s32 %rd101, %r50, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd101) : "r"(r50));
  // PTX:279 add.s64 %rd102, %rd100, %rd101
  asm("add.s64 %0, %1, %2;" : "=l"(rd102) : "l"(rd100), "l"(rd101));
  // PTX:280 ld.global.f32 %f720, [%rd102]
  f720 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd102) + (0)))));
  // PTX:282 $L__BB32_12:
L_BB32_12:;
  // PTX:283 setp.eq.s64 %p8, %rd49, 0
  p8 = (((long long)(rd49)) == ((long long)(0)));
  // PTX:284 mov.f32 %f721, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f721) : );
  // PTX:285 @%p8 bra $L__BB32_14
  if (p8) { goto L_BB32_14; }
  // PTX:287 cvta.to.global.u64 %rd103, %rd49
  rd103 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd49));
  // PTX:288 shl.b64 %rd104, %rd24, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd104) : "l"(rd24));
  // PTX:289 add.s64 %rd105, %rd103, %rd104
  asm("add.s64 %0, %1, %2;" : "=l"(rd105) : "l"(rd103), "l"(rd104));
  // PTX:290 ld.global.f32 %f721, [%rd105]
  f721 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (0)))));
  // PTX:292 $L__BB32_14:
L_BB32_14:;
  // PTX:293 add.f32 %f188, %f720, %f721
  asm("add.f32 %0, %1, %2;" : "=f"(f188) : "f"(f720), "f"(f721));
  // PTX:294 mul.f32 %f30, %f188, %f121
  asm("mul.f32 %0, %1, %2;" : "=f"(f30) : "f"(f188), "f"(f121));
  // PTX:295 setp.leu.f32 %p9, %f30, 0f00000000
  p9 = ((isnan(((float)(f30))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f30)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:296 @%p9 bra $L__BB32_37
  if (p9) { goto L_BB32_37; }
  // PTX:298 abs.f32 %f189, %f30
  asm("abs.f32 %0, %1;" : "=f"(f189) : "f"(f30));
  // PTX:299 setp.geu.f32 %p10, %f189, 0f7F800000
  p10 = ((isnan(((float)(f189))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f189)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:300 @%p10 bra $L__BB32_37
  if (p10) { goto L_BB32_37; }
  // PTX:302 cvta.to.global.u64 %rd106, %rd37
  rd106 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd37));
  // PTX:303 add.s64 %rd108, %rd106, %rd95
  asm("add.s64 %0, %1, %2;" : "=l"(rd108) : "l"(rd106), "l"(rd95));
  // PTX:304 ld.global.u32 %r51, [%rd108]
  r51 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd108) + (0)))));
  // PTX:305 setp.eq.s32 %p11, %r51, 0
  p11 = (((int)(r51)) == ((int)(0)));
  // PTX:306 cvta.to.global.u64 %rd109, %rd43
  rd109 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd43));
  // PTX:307 add.s64 %rd111, %rd109, %rd81
  asm("add.s64 %0, %1, %2;" : "=l"(rd111) : "l"(rd109), "l"(rd81));
  // PTX:308 ld.global.f32 %f31, [%rd111]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd111) + (0)))));
  // PTX:309 ld.global.f32 %f32, [%rd111+4]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd111) + (4)))));
  // PTX:310 ld.global.f32 %f33, [%rd111+8]
  f33 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd111) + (8)))));
  // PTX:311 ld.global.f32 %f34, [%rd111+12]
  f34 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd111) + (12)))));
  // PTX:312 cvt.s64.s32 %rd25, %r15
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd25) : "r"(r15));
  // PTX:313 mul.wide.s32 %rd112, %r15, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd112) : "r"(r15));
  // PTX:314 add.s64 %rd26, %rd3, %rd112
  asm("add.s64 %0, %1, %2;" : "=l"(rd26) : "l"(rd3), "l"(rd112));
  // PTX:315 cvt.s64.s32 %rd27, %r3
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd27) : "r"(r3));
  // PTX:316 mul.wide.s32 %rd113, %r3, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd113) : "r"(r3));
  // PTX:317 add.s64 %rd28, %rd3, %rd113
  asm("add.s64 %0, %1, %2;" : "=l"(rd28) : "l"(rd3), "l"(rd113));
  // PTX:318 cvt.s64.s32 %rd29, %r4
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd29) : "r"(r4));
  // PTX:319 mul.wide.s32 %rd114, %r4, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd114) : "r"(r4));
  // PTX:320 add.s64 %rd30, %rd3, %rd114
  asm("add.s64 %0, %1, %2;" : "=l"(rd30) : "l"(rd3), "l"(rd114));
  // PTX:321 cvt.s64.s32 %rd31, %r5
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd31) : "r"(r5));
  // PTX:322 mul.wide.s32 %rd115, %r5, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd115) : "r"(r5));
  // PTX:323 add.s64 %rd32, %rd3, %rd115
  asm("add.s64 %0, %1, %2;" : "=l"(rd32) : "l"(rd3), "l"(rd115));
  // PTX:324 add.s64 %rd33, %rd1, %rd112
  asm("add.s64 %0, %1, %2;" : "=l"(rd33) : "l"(rd1), "l"(rd112));
  // PTX:325 @%p11 bra $L__BB32_31
  if (p11) { goto L_BB32_31; }
  // PTX:327 ld.global.f32 %f190, [%rd26]
  f190 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (0)))));
  // PTX:328 ld.global.f32 %f191, [%rd26+4]
  f191 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (4)))));
  // PTX:329 ld.global.f32 %f192, [%rd26+8]
  f192 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (8)))));
  // PTX:330 ld.global.f32 %f193, [%rd28]
  f193 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (0)))));
  // PTX:331 mul.f32 %f194, %f193, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f194) : "f"(f193), "f"(f32));
  // PTX:332 ld.global.f32 %f195, [%rd28+4]
  f195 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (4)))));
  // PTX:333 mul.f32 %f196, %f195, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f196) : "f"(f195), "f"(f32));
  // PTX:334 ld.global.f32 %f197, [%rd28+8]
  f197 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (8)))));
  // PTX:335 mul.f32 %f198, %f197, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f198) : "f"(f197), "f"(f32));
  // PTX:336 fma.rn.f32 %f199, %f31, %f190, %f194
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f199) : "f"(f31), "f"(f190), "f"(f194));
  // PTX:337 fma.rn.f32 %f200, %f31, %f191, %f196
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f200) : "f"(f31), "f"(f191), "f"(f196));
  // PTX:338 fma.rn.f32 %f201, %f31, %f192, %f198
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f201) : "f"(f31), "f"(f192), "f"(f198));
  // PTX:339 ld.global.f32 %f202, [%rd30]
  f202 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0)))));
  // PTX:340 ld.global.f32 %f203, [%rd30+4]
  f203 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (4)))));
  // PTX:341 ld.global.f32 %f204, [%rd30+8]
  f204 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (8)))));
  // PTX:342 fma.rn.f32 %f205, %f202, %f33, %f199
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f205) : "f"(f202), "f"(f33), "f"(f199));
  // PTX:343 fma.rn.f32 %f206, %f203, %f33, %f200
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f206) : "f"(f203), "f"(f33), "f"(f200));
  // PTX:344 fma.rn.f32 %f207, %f204, %f33, %f201
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f207) : "f"(f204), "f"(f33), "f"(f201));
  // PTX:345 ld.global.f32 %f208, [%rd32]
  f208 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (0)))));
  // PTX:346 ld.global.f32 %f209, [%rd32+4]
  f209 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (4)))));
  // PTX:347 ld.global.f32 %f210, [%rd32+8]
  f210 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (8)))));
  // PTX:348 fma.rn.f32 %f35, %f208, %f34, %f205
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f35) : "f"(f208), "f"(f34), "f"(f205));
  // PTX:349 fma.rn.f32 %f36, %f209, %f34, %f206
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f36) : "f"(f209), "f"(f34), "f"(f206));
  // PTX:350 fma.rn.f32 %f37, %f210, %f34, %f207
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f37) : "f"(f210), "f"(f34), "f"(f207));
  // PTX:351 cvta.to.global.u64 %rd116, %rd46
  rd116 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd46));
  // PTX:352 add.s64 %rd118, %rd116, %rd81
  asm("add.s64 %0, %1, %2;" : "=l"(rd118) : "l"(rd116), "l"(rd81));
  // PTX:353 ld.global.f32 %f38, [%rd118]
  f38 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd118) + (0)))));
  // PTX:354 ld.global.f32 %f39, [%rd118+4]
  f39 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd118) + (4)))));
  // PTX:355 mul.f32 %f211, %f39, %f193
  asm("mul.f32 %0, %1, %2;" : "=f"(f211) : "f"(f39), "f"(f193));
  // PTX:356 mul.f32 %f212, %f39, %f195
  asm("mul.f32 %0, %1, %2;" : "=f"(f212) : "f"(f39), "f"(f195));
  // PTX:357 mul.f32 %f213, %f39, %f197
  asm("mul.f32 %0, %1, %2;" : "=f"(f213) : "f"(f39), "f"(f197));
  // PTX:358 fma.rn.f32 %f214, %f38, %f190, %f211
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f214) : "f"(f38), "f"(f190), "f"(f211));
  // PTX:359 fma.rn.f32 %f215, %f38, %f191, %f212
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f215) : "f"(f38), "f"(f191), "f"(f212));
  // PTX:360 fma.rn.f32 %f216, %f38, %f192, %f213
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f216) : "f"(f38), "f"(f192), "f"(f213));
  // PTX:361 ld.global.f32 %f40, [%rd118+8]
  f40 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd118) + (8)))));
  // PTX:362 fma.rn.f32 %f217, %f40, %f202, %f214
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f217) : "f"(f40), "f"(f202), "f"(f214));
  // PTX:363 fma.rn.f32 %f218, %f40, %f203, %f215
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f218) : "f"(f40), "f"(f203), "f"(f215));
  // PTX:364 fma.rn.f32 %f219, %f40, %f204, %f216
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f219) : "f"(f40), "f"(f204), "f"(f216));
  // PTX:365 ld.global.f32 %f41, [%rd118+12]
  f41 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd118) + (12)))));
  // PTX:366 fma.rn.f32 %f42, %f41, %f208, %f217
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f42) : "f"(f41), "f"(f208), "f"(f217));
  // PTX:367 fma.rn.f32 %f43, %f41, %f209, %f218
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f43) : "f"(f41), "f"(f209), "f"(f218));
  // PTX:368 fma.rn.f32 %f44, %f41, %f210, %f219
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f44) : "f"(f41), "f"(f210), "f"(f219));
  // PTX:369 setp.leu.f32 %p12, %f22, 0f322BCC77
  p12 = ((isnan(((float)(f22))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f22)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:370 @%p12 bra $L__BB32_37
  if (p12) { goto L_BB32_37; }
  // PTX:372 abs.f32 %f220, %f22
  asm("abs.f32 %0, %1;" : "=f"(f220) : "f"(f22));
  // PTX:373 setp.geu.f32 %p13, %f220, 0f7F800000
  p13 = ((isnan(((float)(f220))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f220)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:374 @%p13 bra $L__BB32_37
  if (p13) { goto L_BB32_37; }
  // PTX:376 div.rn.f32 %f45, %f19, %f22
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f45) : "f"(f19), "f"(f22));
  // PTX:377 mov.b32 %f221, %r57
  asm("mov.b32 %0, %1;" : "=f"(f221) : "r"(r57));
  // PTX:378 sub.f32 %f222, %f221, %f16
  asm("sub.f32 %0, %1, %2;" : "=f"(f222) : "f"(f221), "f"(f16));
  // PTX:379 mov.b32 %f223, %r58
  asm("mov.b32 %0, %1;" : "=f"(f223) : "r"(r58));
  // PTX:380 sub.f32 %f224, %f223, %f17
  asm("sub.f32 %0, %1, %2;" : "=f"(f224) : "f"(f223), "f"(f17));
  // PTX:381 mov.b32 %f225, %r59
  asm("mov.b32 %0, %1;" : "=f"(f225) : "r"(r59));
  // PTX:382 sub.f32 %f226, %f225, %f18
  asm("sub.f32 %0, %1, %2;" : "=f"(f226) : "f"(f225), "f"(f18));
  // PTX:383 div.rn.f32 %f46, %f20, %f22
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f46) : "f"(f20), "f"(f22));
  // PTX:384 mul.f32 %f227, %f46, %f224
  asm("mul.f32 %0, %1, %2;" : "=f"(f227) : "f"(f46), "f"(f224));
  // PTX:385 div.rn.f32 %f47, %f21, %f22
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f47) : "f"(f21), "f"(f22));
  // PTX:386 fma.rn.f32 %f228, %f45, %f222, %f227
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f228) : "f"(f45), "f"(f222), "f"(f227));
  // PTX:387 fma.rn.f32 %f48, %f47, %f226, %f228
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f48) : "f"(f47), "f"(f226), "f"(f228));
  // PTX:388 mul.f32 %f229, %f45, %f48
  asm("mul.f32 %0, %1, %2;" : "=f"(f229) : "f"(f45), "f"(f48));
  // PTX:389 mul.f32 %f230, %f46, %f48
  asm("mul.f32 %0, %1, %2;" : "=f"(f230) : "f"(f46), "f"(f48));
  // PTX:390 mul.f32 %f231, %f47, %f48
  asm("mul.f32 %0, %1, %2;" : "=f"(f231) : "f"(f47), "f"(f48));
  // PTX:391 sub.f32 %f49, %f222, %f229
  asm("sub.f32 %0, %1, %2;" : "=f"(f49) : "f"(f222), "f"(f229));
  // PTX:392 sub.f32 %f50, %f224, %f230
  asm("sub.f32 %0, %1, %2;" : "=f"(f50) : "f"(f224), "f"(f230));
  // PTX:393 sub.f32 %f51, %f226, %f231
  asm("sub.f32 %0, %1, %2;" : "=f"(f51) : "f"(f226), "f"(f231));
  // PTX:394 sub.f32 %f232, %f42, %f35
  asm("sub.f32 %0, %1, %2;" : "=f"(f232) : "f"(f42), "f"(f35));
  // PTX:395 sub.f32 %f233, %f43, %f36
  asm("sub.f32 %0, %1, %2;" : "=f"(f233) : "f"(f43), "f"(f36));
  // PTX:396 mul.f32 %f234, %f46, %f233
  asm("mul.f32 %0, %1, %2;" : "=f"(f234) : "f"(f46), "f"(f233));
  // PTX:397 sub.f32 %f235, %f44, %f37
  asm("sub.f32 %0, %1, %2;" : "=f"(f235) : "f"(f44), "f"(f37));
  // PTX:398 fma.rn.f32 %f236, %f45, %f232, %f234
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f236) : "f"(f45), "f"(f232), "f"(f234));
  // PTX:399 fma.rn.f32 %f52, %f47, %f235, %f236
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f52) : "f"(f47), "f"(f235), "f"(f236));
  // PTX:400 mul.f32 %f237, %f45, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f237) : "f"(f45), "f"(f52));
  // PTX:401 mul.f32 %f238, %f46, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f238) : "f"(f46), "f"(f52));
  // PTX:402 mul.f32 %f239, %f47, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f239) : "f"(f47), "f"(f52));
  // PTX:403 sub.f32 %f53, %f232, %f237
  asm("sub.f32 %0, %1, %2;" : "=f"(f53) : "f"(f232), "f"(f237));
  // PTX:404 sub.f32 %f54, %f233, %f238
  asm("sub.f32 %0, %1, %2;" : "=f"(f54) : "f"(f233), "f"(f238));
  // PTX:405 sub.f32 %f55, %f235, %f239
  asm("sub.f32 %0, %1, %2;" : "=f"(f55) : "f"(f235), "f"(f239));
  // PTX:406 mul.f32 %f240, %f50, %f50
  asm("mul.f32 %0, %1, %2;" : "=f"(f240) : "f"(f50), "f"(f50));
  // PTX:407 fma.rn.f32 %f241, %f49, %f49, %f240
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f241) : "f"(f49), "f"(f49), "f"(f240));
  // PTX:408 fma.rn.f32 %f242, %f51, %f51, %f241
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f242) : "f"(f51), "f"(f51), "f"(f241));
  // PTX:409 sqrt.rn.f32 %f56, %f242
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f56) : "f"(f242));
  // PTX:410 mul.f32 %f243, %f54, %f54
  asm("mul.f32 %0, %1, %2;" : "=f"(f243) : "f"(f54), "f"(f54));
  // PTX:411 fma.rn.f32 %f244, %f53, %f53, %f243
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f244) : "f"(f53), "f"(f53), "f"(f243));
  // PTX:412 fma.rn.f32 %f245, %f55, %f55, %f244
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f245) : "f"(f55), "f"(f55), "f"(f244));
  // PTX:413 sqrt.rn.f32 %f57, %f245
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f57) : "f"(f245));
  // PTX:414 setp.leu.f32 %p14, %f56, 0f322BCC77
  p14 = ((isnan(((float)(f56))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f56)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:415 setp.leu.f32 %p15, %f57, 0f322BCC77
  p15 = ((isnan(((float)(f57))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f57)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:416 or.pred %p16, %p14, %p15
  p16 = ((p14) || (p15));
  // PTX:417 @%p16 bra $L__BB32_37
  if (p16) { goto L_BB32_37; }
  // PTX:419 abs.f32 %f246, %f56
  asm("abs.f32 %0, %1;" : "=f"(f246) : "f"(f56));
  // PTX:420 setp.geu.f32 %p17, %f246, 0f7F800000
  p17 = ((isnan(((float)(f246))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f246)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:421 @%p17 bra $L__BB32_37
  if (p17) { goto L_BB32_37; }
  // PTX:423 abs.f32 %f247, %f57
  asm("abs.f32 %0, %1;" : "=f"(f247) : "f"(f57));
  // PTX:424 setp.geu.f32 %p18, %f247, 0f7F800000
  p18 = ((isnan(((float)(f247))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f247)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:425 @%p18 bra $L__BB32_37
  if (p18) { goto L_BB32_37; }
  // PTX:427 div.rn.f32 %f58, %f49, %f56
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f58) : "f"(f49), "f"(f56));
  // PTX:428 div.rn.f32 %f59, %f55, %f57
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f59) : "f"(f55), "f"(f57));
  // PTX:429 div.rn.f32 %f60, %f50, %f56
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f60) : "f"(f50), "f"(f56));
  // PTX:430 mul.f32 %f248, %f60, %f59
  asm("mul.f32 %0, %1, %2;" : "=f"(f248) : "f"(f60), "f"(f59));
  // PTX:431 div.rn.f32 %f61, %f54, %f57
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f61) : "f"(f54), "f"(f57));
  // PTX:432 div.rn.f32 %f62, %f51, %f56
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f62) : "f"(f51), "f"(f56));
  // PTX:433 mul.f32 %f249, %f62, %f61
  asm("mul.f32 %0, %1, %2;" : "=f"(f249) : "f"(f62), "f"(f61));
  // PTX:434 sub.f32 %f250, %f248, %f249
  asm("sub.f32 %0, %1, %2;" : "=f"(f250) : "f"(f248), "f"(f249));
  // PTX:435 div.rn.f32 %f63, %f53, %f57
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f63) : "f"(f53), "f"(f57));
  // PTX:436 mul.f32 %f251, %f62, %f63
  asm("mul.f32 %0, %1, %2;" : "=f"(f251) : "f"(f62), "f"(f63));
  // PTX:437 mul.f32 %f252, %f58, %f59
  asm("mul.f32 %0, %1, %2;" : "=f"(f252) : "f"(f58), "f"(f59));
  // PTX:438 sub.f32 %f253, %f251, %f252
  asm("sub.f32 %0, %1, %2;" : "=f"(f253) : "f"(f251), "f"(f252));
  // PTX:439 mul.f32 %f254, %f58, %f61
  asm("mul.f32 %0, %1, %2;" : "=f"(f254) : "f"(f58), "f"(f61));
  // PTX:440 mul.f32 %f255, %f60, %f63
  asm("mul.f32 %0, %1, %2;" : "=f"(f255) : "f"(f60), "f"(f63));
  // PTX:441 sub.f32 %f256, %f254, %f255
  asm("sub.f32 %0, %1, %2;" : "=f"(f256) : "f"(f254), "f"(f255));
  // PTX:442 mul.f32 %f257, %f46, %f253
  asm("mul.f32 %0, %1, %2;" : "=f"(f257) : "f"(f46), "f"(f253));
  // PTX:443 fma.rn.f32 %f258, %f45, %f250, %f257
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f258) : "f"(f45), "f"(f250), "f"(f257));
  // PTX:444 fma.rn.f32 %f259, %f47, %f256, %f258
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f259) : "f"(f47), "f"(f256), "f"(f258));
  // PTX:445 mul.f32 %f260, %f60, %f61
  asm("mul.f32 %0, %1, %2;" : "=f"(f260) : "f"(f60), "f"(f61));
  // PTX:446 fma.rn.f32 %f261, %f58, %f63, %f260
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f261) : "f"(f58), "f"(f63), "f"(f260));
  // PTX:447 fma.rn.f32 %f262, %f62, %f59, %f261
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f262) : "f"(f62), "f"(f59), "f"(f261));
  // PTX:448 mul.f32 %f263, %f259, %f259
  asm("mul.f32 %0, %1, %2;" : "=f"(f263) : "f"(f259), "f"(f259));
  // PTX:449 fma.rn.f32 %f64, %f262, %f262, %f263
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f64) : "f"(f262), "f"(f262), "f"(f263));
  // PTX:450 setp.leu.f32 %p19, %f64, 0f2B8CBCCC
  p19 = ((isnan(((float)(f64))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) || (((float)(f64)) <= ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:451 @%p19 bra $L__BB32_37
  if (p19) { goto L_BB32_37; }
  // PTX:453 abs.f32 %f264, %f64
  asm("abs.f32 %0, %1;" : "=f"(f264) : "f"(f64));
  // PTX:454 setp.geu.f32 %p20, %f264, 0f7F800000
  p20 = ((isnan(((float)(f264))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f264)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:455 @%p20 bra $L__BB32_37
  if (p20) { goto L_BB32_37; }
  // PTX:457 cvt.u32.u64 %r52, %rd12
  asm("cvt.u32.u64 %0, %1;" : "=r"(r52) : "l"(rd12));
  // PTX:458 setp.lt.s32 %p21, %r52, 0
  p21 = (((int)(r52)) < ((int)(0)));
  // PTX:459 mul.f32 %f266, %f47, %f60
  asm("mul.f32 %0, %1, %2;" : "=f"(f266) : "f"(f47), "f"(f60));
  // PTX:460 mul.f32 %f267, %f46, %f62
  asm("mul.f32 %0, %1, %2;" : "=f"(f267) : "f"(f46), "f"(f62));
  // PTX:461 sub.f32 %f65, %f267, %f266
  asm("sub.f32 %0, %1, %2;" : "=f"(f65) : "f"(f267), "f"(f266));
  // PTX:462 mul.f32 %f268, %f45, %f62
  asm("mul.f32 %0, %1, %2;" : "=f"(f268) : "f"(f45), "f"(f62));
  // PTX:463 mul.f32 %f269, %f47, %f58
  asm("mul.f32 %0, %1, %2;" : "=f"(f269) : "f"(f47), "f"(f58));
  // PTX:464 sub.f32 %f66, %f269, %f268
  asm("sub.f32 %0, %1, %2;" : "=f"(f66) : "f"(f269), "f"(f268));
  // PTX:465 mul.f32 %f270, %f46, %f58
  asm("mul.f32 %0, %1, %2;" : "=f"(f270) : "f"(f46), "f"(f58));
  // PTX:466 mul.f32 %f271, %f45, %f60
  asm("mul.f32 %0, %1, %2;" : "=f"(f271) : "f"(f45), "f"(f60));
  // PTX:467 sub.f32 %f67, %f271, %f270
  asm("sub.f32 %0, %1, %2;" : "=f"(f67) : "f"(f271), "f"(f270));
  // PTX:468 mul.f32 %f272, %f47, %f61
  asm("mul.f32 %0, %1, %2;" : "=f"(f272) : "f"(f47), "f"(f61));
  // PTX:469 mul.f32 %f273, %f46, %f59
  asm("mul.f32 %0, %1, %2;" : "=f"(f273) : "f"(f46), "f"(f59));
  // PTX:470 sub.f32 %f274, %f273, %f272
  asm("sub.f32 %0, %1, %2;" : "=f"(f274) : "f"(f273), "f"(f272));
  // PTX:471 mul.f32 %f275, %f45, %f59
  asm("mul.f32 %0, %1, %2;" : "=f"(f275) : "f"(f45), "f"(f59));
  // PTX:472 mul.f32 %f276, %f47, %f63
  asm("mul.f32 %0, %1, %2;" : "=f"(f276) : "f"(f47), "f"(f63));
  // PTX:473 sub.f32 %f277, %f276, %f275
  asm("sub.f32 %0, %1, %2;" : "=f"(f277) : "f"(f276), "f"(f275));
  // PTX:474 mul.f32 %f278, %f46, %f63
  asm("mul.f32 %0, %1, %2;" : "=f"(f278) : "f"(f46), "f"(f63));
  // PTX:475 mul.f32 %f279, %f45, %f61
  asm("mul.f32 %0, %1, %2;" : "=f"(f279) : "f"(f45), "f"(f61));
  // PTX:476 sub.f32 %f280, %f279, %f278
  asm("sub.f32 %0, %1, %2;" : "=f"(f280) : "f"(f279), "f"(f278));
  // PTX:477 div.rn.f32 %f281, %f48, %f56
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f281) : "f"(f48), "f"(f56));
  // PTX:478 mul.f32 %f282, %f281, %f65
  asm("mul.f32 %0, %1, %2;" : "=f"(f282) : "f"(f281), "f"(f65));
  // PTX:479 mul.f32 %f283, %f281, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f283) : "f"(f281), "f"(f66));
  // PTX:480 mul.f32 %f284, %f281, %f67
  asm("mul.f32 %0, %1, %2;" : "=f"(f284) : "f"(f281), "f"(f67));
  // PTX:481 div.rn.f32 %f285, %f52, %f57
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f285) : "f"(f52), "f"(f57));
  // PTX:482 mul.f32 %f286, %f285, %f274
  asm("mul.f32 %0, %1, %2;" : "=f"(f286) : "f"(f285), "f"(f274));
  // PTX:483 mul.f32 %f287, %f285, %f277
  asm("mul.f32 %0, %1, %2;" : "=f"(f287) : "f"(f285), "f"(f277));
  // PTX:484 mul.f32 %f288, %f285, %f280
  asm("mul.f32 %0, %1, %2;" : "=f"(f288) : "f"(f285), "f"(f280));
  // PTX:485 sub.f32 %f289, %f282, %f286
  asm("sub.f32 %0, %1, %2;" : "=f"(f289) : "f"(f282), "f"(f286));
  // PTX:486 sub.f32 %f290, %f283, %f287
  asm("sub.f32 %0, %1, %2;" : "=f"(f290) : "f"(f283), "f"(f287));
  // PTX:487 sub.f32 %f291, %f284, %f288
  asm("sub.f32 %0, %1, %2;" : "=f"(f291) : "f"(f284), "f"(f288));
  // PTX:488 div.rn.f32 %f68, %f289, %f22
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f68) : "f"(f289), "f"(f22));
  // PTX:489 div.rn.f32 %f69, %f290, %f22
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f69) : "f"(f290), "f"(f22));
  // PTX:490 div.rn.f32 %f70, %f291, %f22
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f70) : "f"(f291), "f"(f22));
  // PTX:491 neg.f32 %f292, %f274
  asm("neg.f32 %0, %1;" : "=f"(f292) : "f"(f274));
  // PTX:492 neg.f32 %f293, %f277
  asm("neg.f32 %0, %1;" : "=f"(f293) : "f"(f277));
  // PTX:493 neg.f32 %f294, %f280
  asm("neg.f32 %0, %1;" : "=f"(f294) : "f"(f280));
  // PTX:494 div.rn.f32 %f295, %f292, %f57
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f295) : "f"(f292), "f"(f57));
  // PTX:495 div.rn.f32 %f296, %f293, %f57
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f296) : "f"(f293), "f"(f57));
  // PTX:496 div.rn.f32 %f297, %f294, %f57
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f297) : "f"(f294), "f"(f57));
  // PTX:497 div.rn.f32 %f298, %f274, %f57
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f298) : "f"(f274), "f"(f57));
  // PTX:498 div.rn.f32 %f299, %f277, %f57
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f299) : "f"(f277), "f"(f57));
  // PTX:499 div.rn.f32 %f300, %f280, %f57
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f300) : "f"(f280), "f"(f57));
  // PTX:500 mul.f32 %f301, %f298, %f38
  asm("mul.f32 %0, %1, %2;" : "=f"(f301) : "f"(f298), "f"(f38));
  // PTX:501 mul.f32 %f302, %f299, %f38
  asm("mul.f32 %0, %1, %2;" : "=f"(f302) : "f"(f299), "f"(f38));
  // PTX:502 mul.f32 %f303, %f300, %f38
  asm("mul.f32 %0, %1, %2;" : "=f"(f303) : "f"(f300), "f"(f38));
  // PTX:503 fma.rn.f32 %f71, %f295, %f31, %f301
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f71) : "f"(f295), "f"(f31), "f"(f301));
  // PTX:504 fma.rn.f32 %f72, %f296, %f31, %f302
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f72) : "f"(f296), "f"(f31), "f"(f302));
  // PTX:505 fma.rn.f32 %f73, %f297, %f31, %f303
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f73) : "f"(f297), "f"(f31), "f"(f303));
  // PTX:506 mul.f32 %f304, %f298, %f39
  asm("mul.f32 %0, %1, %2;" : "=f"(f304) : "f"(f298), "f"(f39));
  // PTX:507 mul.f32 %f305, %f299, %f39
  asm("mul.f32 %0, %1, %2;" : "=f"(f305) : "f"(f299), "f"(f39));
  // PTX:508 mul.f32 %f306, %f300, %f39
  asm("mul.f32 %0, %1, %2;" : "=f"(f306) : "f"(f300), "f"(f39));
  // PTX:509 fma.rn.f32 %f74, %f295, %f32, %f304
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f74) : "f"(f295), "f"(f32), "f"(f304));
  // PTX:510 fma.rn.f32 %f75, %f296, %f32, %f305
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f75) : "f"(f296), "f"(f32), "f"(f305));
  // PTX:511 fma.rn.f32 %f76, %f297, %f32, %f306
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f76) : "f"(f297), "f"(f32), "f"(f306));
  // PTX:512 mul.f32 %f307, %f298, %f40
  asm("mul.f32 %0, %1, %2;" : "=f"(f307) : "f"(f298), "f"(f40));
  // PTX:513 mul.f32 %f308, %f299, %f40
  asm("mul.f32 %0, %1, %2;" : "=f"(f308) : "f"(f299), "f"(f40));
  // PTX:514 mul.f32 %f309, %f300, %f40
  asm("mul.f32 %0, %1, %2;" : "=f"(f309) : "f"(f300), "f"(f40));
  // PTX:515 fma.rn.f32 %f77, %f295, %f33, %f307
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f77) : "f"(f295), "f"(f33), "f"(f307));
  // PTX:516 fma.rn.f32 %f78, %f296, %f33, %f308
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f78) : "f"(f296), "f"(f33), "f"(f308));
  // PTX:517 fma.rn.f32 %f79, %f297, %f33, %f309
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f79) : "f"(f297), "f"(f33), "f"(f309));
  // PTX:518 mul.f32 %f310, %f298, %f41
  asm("mul.f32 %0, %1, %2;" : "=f"(f310) : "f"(f298), "f"(f41));
  // PTX:519 mul.f32 %f311, %f299, %f41
  asm("mul.f32 %0, %1, %2;" : "=f"(f311) : "f"(f299), "f"(f41));
  // PTX:520 mul.f32 %f312, %f300, %f41
  asm("mul.f32 %0, %1, %2;" : "=f"(f312) : "f"(f300), "f"(f41));
  // PTX:521 fma.rn.f32 %f80, %f295, %f34, %f310
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f80) : "f"(f295), "f"(f34), "f"(f310));
  // PTX:522 fma.rn.f32 %f81, %f296, %f34, %f311
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f81) : "f"(f296), "f"(f34), "f"(f311));
  // PTX:523 fma.rn.f32 %f82, %f297, %f34, %f312
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f82) : "f"(f297), "f"(f34), "f"(f312));
  // PTX:524 @%p21 bra $L__BB32_26
  if (p21) { goto L_BB32_26; }
  // PTX:526 div.rn.f32 %f313, %f65, %f56
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f313) : "f"(f65), "f"(f56));
  // PTX:527 sub.f32 %f314, %f313, %f68
  asm("sub.f32 %0, %1, %2;" : "=f"(f314) : "f"(f313), "f"(f68));
  // PTX:528 div.rn.f32 %f315, %f66, %f56
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f315) : "f"(f66), "f"(f56));
  // PTX:529 sub.f32 %f316, %f315, %f69
  asm("sub.f32 %0, %1, %2;" : "=f"(f316) : "f"(f315), "f"(f69));
  // PTX:530 div.rn.f32 %f317, %f67, %f56
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f317) : "f"(f67), "f"(f56));
  // PTX:531 sub.f32 %f318, %f317, %f70
  asm("sub.f32 %0, %1, %2;" : "=f"(f318) : "f"(f317), "f"(f70));
  // PTX:532 neg.f32 %f319, %f65
  asm("neg.f32 %0, %1;" : "=f"(f319) : "f"(f65));
  // PTX:533 div.rn.f32 %f320, %f319, %f56
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f320) : "f"(f319), "f"(f56));
  // PTX:534 neg.f32 %f321, %f66
  asm("neg.f32 %0, %1;" : "=f"(f321) : "f"(f66));
  // PTX:535 div.rn.f32 %f322, %f321, %f56
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f322) : "f"(f321), "f"(f56));
  // PTX:536 neg.f32 %f323, %f67
  asm("neg.f32 %0, %1;" : "=f"(f323) : "f"(f67));
  // PTX:537 div.rn.f32 %f324, %f323, %f56
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f324) : "f"(f323), "f"(f56));
  // PTX:538 ld.global.f32 %f325, [%rd13]
  f325 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))));
  // PTX:539 ld.global.f32 %f326, [%rd14]
  f326 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:540 mul.f32 %f327, %f68, %f326
  asm("mul.f32 %0, %1, %2;" : "=f"(f327) : "f"(f68), "f"(f326));
  // PTX:541 mul.f32 %f328, %f69, %f326
  asm("mul.f32 %0, %1, %2;" : "=f"(f328) : "f"(f69), "f"(f326));
  // PTX:542 mul.f32 %f329, %f70, %f326
  asm("mul.f32 %0, %1, %2;" : "=f"(f329) : "f"(f70), "f"(f326));
  // PTX:543 fma.rn.f32 %f330, %f314, %f325, %f327
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f330) : "f"(f314), "f"(f325), "f"(f327));
  // PTX:544 fma.rn.f32 %f331, %f316, %f325, %f328
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f331) : "f"(f316), "f"(f325), "f"(f328));
  // PTX:545 fma.rn.f32 %f332, %f318, %f325, %f329
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f332) : "f"(f318), "f"(f325), "f"(f329));
  // PTX:546 ld.global.f32 %f333, [%rd15]
  f333 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))));
  // PTX:547 fma.rn.f32 %f729, %f320, %f333, %f330
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f729) : "f"(f320), "f"(f333), "f"(f330));
  // PTX:548 fma.rn.f32 %f728, %f322, %f333, %f331
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f728) : "f"(f322), "f"(f333), "f"(f331));
  // PTX:549 fma.rn.f32 %f727, %f324, %f333, %f332
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f727) : "f"(f324), "f"(f333), "f"(f332));
  // PTX:550 ld.global.f32 %f334, [%rd13+4]
  f334 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4)))));
  // PTX:551 ld.global.f32 %f335, [%rd14+4]
  f335 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (4)))));
  // PTX:552 mul.f32 %f336, %f68, %f335
  asm("mul.f32 %0, %1, %2;" : "=f"(f336) : "f"(f68), "f"(f335));
  // PTX:553 mul.f32 %f337, %f69, %f335
  asm("mul.f32 %0, %1, %2;" : "=f"(f337) : "f"(f69), "f"(f335));
  // PTX:554 mul.f32 %f338, %f70, %f335
  asm("mul.f32 %0, %1, %2;" : "=f"(f338) : "f"(f70), "f"(f335));
  // PTX:555 fma.rn.f32 %f339, %f314, %f334, %f336
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f339) : "f"(f314), "f"(f334), "f"(f336));
  // PTX:556 fma.rn.f32 %f340, %f316, %f334, %f337
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f340) : "f"(f316), "f"(f334), "f"(f337));
  // PTX:557 fma.rn.f32 %f341, %f318, %f334, %f338
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f341) : "f"(f318), "f"(f334), "f"(f338));
  // PTX:558 ld.global.f32 %f342, [%rd15+4]
  f342 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (4)))));
  // PTX:559 fma.rn.f32 %f726, %f320, %f342, %f339
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f726) : "f"(f320), "f"(f342), "f"(f339));
  // PTX:560 fma.rn.f32 %f725, %f322, %f342, %f340
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f725) : "f"(f322), "f"(f342), "f"(f340));
  // PTX:561 fma.rn.f32 %f724, %f324, %f342, %f341
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f724) : "f"(f324), "f"(f342), "f"(f341));
  // PTX:562 ld.global.f32 %f343, [%rd13+8]
  f343 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8)))));
  // PTX:563 ld.global.f32 %f344, [%rd14+8]
  f344 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (8)))));
  // PTX:564 mul.f32 %f345, %f68, %f344
  asm("mul.f32 %0, %1, %2;" : "=f"(f345) : "f"(f68), "f"(f344));
  // PTX:565 mul.f32 %f346, %f69, %f344
  asm("mul.f32 %0, %1, %2;" : "=f"(f346) : "f"(f69), "f"(f344));
  // PTX:566 mul.f32 %f347, %f70, %f344
  asm("mul.f32 %0, %1, %2;" : "=f"(f347) : "f"(f70), "f"(f344));
  // PTX:567 fma.rn.f32 %f348, %f314, %f343, %f345
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f348) : "f"(f314), "f"(f343), "f"(f345));
  // PTX:568 fma.rn.f32 %f349, %f316, %f343, %f346
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f349) : "f"(f316), "f"(f343), "f"(f346));
  // PTX:569 fma.rn.f32 %f350, %f318, %f343, %f347
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f350) : "f"(f318), "f"(f343), "f"(f347));
  // PTX:570 ld.global.f32 %f351, [%rd15+8]
  f351 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (8)))));
  // PTX:571 fma.rn.f32 %f723, %f320, %f351, %f348
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f723) : "f"(f320), "f"(f351), "f"(f348));
  // PTX:572 fma.rn.f32 %f722, %f322, %f351, %f349
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f722) : "f"(f322), "f"(f351), "f"(f349));
  // PTX:573 fma.rn.f32 %f730, %f324, %f351, %f350
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f730) : "f"(f324), "f"(f351), "f"(f350));
  // PTX:574 ld.global.f32 %f352, [%rd13+12]
  f352 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (12)))));
  // PTX:575 ld.global.f32 %f353, [%rd14+12]
  f353 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (12)))));
  // PTX:576 mul.f32 %f354, %f68, %f353
  asm("mul.f32 %0, %1, %2;" : "=f"(f354) : "f"(f68), "f"(f353));
  // PTX:577 mul.f32 %f355, %f69, %f353
  asm("mul.f32 %0, %1, %2;" : "=f"(f355) : "f"(f69), "f"(f353));
  // PTX:578 mul.f32 %f356, %f70, %f353
  asm("mul.f32 %0, %1, %2;" : "=f"(f356) : "f"(f70), "f"(f353));
  // PTX:579 fma.rn.f32 %f357, %f314, %f352, %f354
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f357) : "f"(f314), "f"(f352), "f"(f354));
  // PTX:580 fma.rn.f32 %f358, %f316, %f352, %f355
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f358) : "f"(f316), "f"(f352), "f"(f355));
  // PTX:581 fma.rn.f32 %f359, %f318, %f352, %f356
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f359) : "f"(f318), "f"(f352), "f"(f356));
  // PTX:582 ld.global.f32 %f360, [%rd15+12]
  f360 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (12)))));
  // PTX:583 fma.rn.f32 %f731, %f320, %f360, %f357
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f731) : "f"(f320), "f"(f360), "f"(f357));
  // PTX:584 fma.rn.f32 %f732, %f322, %f360, %f358
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f732) : "f"(f322), "f"(f360), "f"(f358));
  // PTX:585 fma.rn.f32 %f733, %f324, %f360, %f359
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f733) : "f"(f324), "f"(f360), "f"(f359));
  // PTX:587 $L__BB32_26:
L_BB32_26:;
  // PTX:588 ld.param.u64 %rd232, [_ZN7synreal6kernel28multiply_joint_drive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPS4_mmm_param_1]
  rd232 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:589 cvta.to.global.u64 %rd231, %rd232
  rd231 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd232));
  // PTX:590 ld.global.f32 %f361, [%rd33]
  f361 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (0)))));
  // PTX:591 ld.global.f32 %f362, [%rd33+4]
  f362 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (4)))));
  // PTX:592 mul.f32 %f363, %f72, %f362
  asm("mul.f32 %0, %1, %2;" : "=f"(f363) : "f"(f72), "f"(f362));
  // PTX:593 ld.global.f32 %f364, [%rd33+8]
  f364 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (8)))));
  // PTX:594 fma.rn.f32 %f365, %f71, %f361, %f363
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f365) : "f"(f71), "f"(f361), "f"(f363));
  // PTX:595 fma.rn.f32 %f366, %f73, %f364, %f365
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f366) : "f"(f73), "f"(f364), "f"(f365));
  // PTX:596 add.f32 %f367, %f366, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f367) : "f"(f366));
  // PTX:597 mul.lo.s64 %rd119, %rd27, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd119) : "l"(rd27));
  // PTX:598 add.s64 %rd120, %rd231, %rd119
  asm("add.s64 %0, %1, %2;" : "=l"(rd120) : "l"(rd231), "l"(rd119));
  // PTX:599 ld.global.f32 %f368, [%rd120]
  f368 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd120) + (0)))));
  // PTX:600 ld.global.f32 %f369, [%rd120+4]
  f369 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd120) + (4)))));
  // PTX:601 mul.f32 %f370, %f75, %f369
  asm("mul.f32 %0, %1, %2;" : "=f"(f370) : "f"(f75), "f"(f369));
  // PTX:602 ld.global.f32 %f371, [%rd120+8]
  f371 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd120) + (8)))));
  // PTX:603 fma.rn.f32 %f372, %f74, %f368, %f370
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f372) : "f"(f74), "f"(f368), "f"(f370));
  // PTX:604 fma.rn.f32 %f373, %f76, %f371, %f372
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f373) : "f"(f76), "f"(f371), "f"(f372));
  // PTX:605 add.f32 %f374, %f367, %f373
  asm("add.f32 %0, %1, %2;" : "=f"(f374) : "f"(f367), "f"(f373));
  // PTX:606 mul.lo.s64 %rd121, %rd29, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd121) : "l"(rd29));
  // PTX:607 add.s64 %rd122, %rd231, %rd121
  asm("add.s64 %0, %1, %2;" : "=l"(rd122) : "l"(rd231), "l"(rd121));
  // PTX:608 ld.global.f32 %f375, [%rd122]
  f375 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd122) + (0)))));
  // PTX:609 ld.global.f32 %f376, [%rd122+4]
  f376 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd122) + (4)))));
  // PTX:610 mul.f32 %f377, %f78, %f376
  asm("mul.f32 %0, %1, %2;" : "=f"(f377) : "f"(f78), "f"(f376));
  // PTX:611 ld.global.f32 %f378, [%rd122+8]
  f378 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd122) + (8)))));
  // PTX:612 fma.rn.f32 %f379, %f77, %f375, %f377
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f379) : "f"(f77), "f"(f375), "f"(f377));
  // PTX:613 fma.rn.f32 %f380, %f79, %f378, %f379
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f380) : "f"(f79), "f"(f378), "f"(f379));
  // PTX:614 add.f32 %f381, %f374, %f380
  asm("add.f32 %0, %1, %2;" : "=f"(f381) : "f"(f374), "f"(f380));
  // PTX:615 mul.lo.s64 %rd123, %rd31, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd123) : "l"(rd31));
  // PTX:616 add.s64 %rd124, %rd231, %rd123
  asm("add.s64 %0, %1, %2;" : "=l"(rd124) : "l"(rd231), "l"(rd123));
  // PTX:617 ld.global.f32 %f382, [%rd124]
  f382 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd124) + (0)))));
  // PTX:618 ld.global.f32 %f383, [%rd124+4]
  f383 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd124) + (4)))));
  // PTX:619 mul.f32 %f384, %f81, %f383
  asm("mul.f32 %0, %1, %2;" : "=f"(f384) : "f"(f81), "f"(f383));
  // PTX:620 ld.global.f32 %f385, [%rd124+8]
  f385 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd124) + (8)))));
  // PTX:621 fma.rn.f32 %f386, %f80, %f382, %f384
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f386) : "f"(f80), "f"(f382), "f"(f384));
  // PTX:622 fma.rn.f32 %f387, %f82, %f385, %f386
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f387) : "f"(f82), "f"(f385), "f"(f386));
  // PTX:623 add.f32 %f734, %f381, %f387
  asm("add.f32 %0, %1, %2;" : "=f"(f734) : "f"(f381), "f"(f387));
  // PTX:624 @%p21 bra $L__BB32_28
  if (p21) { goto L_BB32_28; }
  // PTX:626 ld.param.u64 %rd234, [_ZN7synreal6kernel28multiply_joint_drive_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKiPKNS2_ILi2EiLS3_0EEES6_S6_S6_PKNS2_ILi4EfLS3_0EEESH_SH_SH_SH_SB_SB_PKfSJ_fPS4_mmm_param_1]
  rd234 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:627 cvta.to.global.u64 %rd233, %rd234
  rd233 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd234));
  // PTX:628 mul.lo.s64 %rd125, %rd20, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd125) : "l"(rd20));
  // PTX:629 add.s64 %rd126, %rd233, %rd125
  asm("add.s64 %0, %1, %2;" : "=l"(rd126) : "l"(rd233), "l"(rd125));
  // PTX:630 ld.global.f32 %f388, [%rd126]
  f388 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd126) + (0)))));
  // PTX:631 ld.global.f32 %f389, [%rd126+4]
  f389 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd126) + (4)))));
  // PTX:632 mul.f32 %f390, %f728, %f389
  asm("mul.f32 %0, %1, %2;" : "=f"(f390) : "f"(f728), "f"(f389));
  // PTX:633 ld.global.f32 %f391, [%rd126+8]
  f391 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd126) + (8)))));
  // PTX:634 fma.rn.f32 %f392, %f729, %f388, %f390
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f392) : "f"(f729), "f"(f388), "f"(f390));
  // PTX:635 fma.rn.f32 %f393, %f727, %f391, %f392
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f393) : "f"(f727), "f"(f391), "f"(f392));
  // PTX:636 add.f32 %f394, %f734, %f393
  asm("add.f32 %0, %1, %2;" : "=f"(f394) : "f"(f734), "f"(f393));
  // PTX:637 mul.lo.s64 %rd127, %rd21, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd127) : "l"(rd21));
  // PTX:638 add.s64 %rd128, %rd233, %rd127
  asm("add.s64 %0, %1, %2;" : "=l"(rd128) : "l"(rd233), "l"(rd127));
  // PTX:639 ld.global.f32 %f395, [%rd128]
  f395 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd128) + (0)))));
  // PTX:640 ld.global.f32 %f396, [%rd128+4]
  f396 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd128) + (4)))));
  // PTX:641 mul.f32 %f397, %f725, %f396
  asm("mul.f32 %0, %1, %2;" : "=f"(f397) : "f"(f725), "f"(f396));
  // PTX:642 ld.global.f32 %f398, [%rd128+8]
  f398 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd128) + (8)))));
  // PTX:643 fma.rn.f32 %f399, %f726, %f395, %f397
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f399) : "f"(f726), "f"(f395), "f"(f397));
  // PTX:644 fma.rn.f32 %f400, %f724, %f398, %f399
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f400) : "f"(f724), "f"(f398), "f"(f399));
  // PTX:645 add.f32 %f401, %f394, %f400
  asm("add.f32 %0, %1, %2;" : "=f"(f401) : "f"(f394), "f"(f400));
  // PTX:646 mul.lo.s64 %rd129, %rd22, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd129) : "l"(rd22));
  // PTX:647 add.s64 %rd130, %rd233, %rd129
  asm("add.s64 %0, %1, %2;" : "=l"(rd130) : "l"(rd233), "l"(rd129));
  // PTX:648 ld.global.f32 %f402, [%rd130]
  f402 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd130) + (0)))));
  // PTX:649 ld.global.f32 %f403, [%rd130+4]
  f403 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd130) + (4)))));
  // PTX:650 mul.f32 %f404, %f722, %f403
  asm("mul.f32 %0, %1, %2;" : "=f"(f404) : "f"(f722), "f"(f403));
  // PTX:651 ld.global.f32 %f405, [%rd130+8]
  f405 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd130) + (8)))));
  // PTX:652 fma.rn.f32 %f406, %f723, %f402, %f404
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f406) : "f"(f723), "f"(f402), "f"(f404));
  // PTX:653 fma.rn.f32 %f407, %f730, %f405, %f406
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f407) : "f"(f730), "f"(f405), "f"(f406));
  // PTX:654 add.f32 %f408, %f401, %f407
  asm("add.f32 %0, %1, %2;" : "=f"(f408) : "f"(f401), "f"(f407));
  // PTX:655 mul.lo.s64 %rd131, %rd23, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd131) : "l"(rd23));
  // PTX:656 add.s64 %rd132, %rd233, %rd131
  asm("add.s64 %0, %1, %2;" : "=l"(rd132) : "l"(rd233), "l"(rd131));
  // PTX:657 ld.global.f32 %f409, [%rd132]
  f409 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd132) + (0)))));
  // PTX:658 ld.global.f32 %f410, [%rd132+4]
  f410 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd132) + (4)))));
  // PTX:659 mul.f32 %f411, %f732, %f410
  asm("mul.f32 %0, %1, %2;" : "=f"(f411) : "f"(f732), "f"(f410));
  // PTX:660 ld.global.f32 %f412, [%rd132+8]
  f412 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd132) + (8)))));
  // PTX:661 fma.rn.f32 %f413, %f731, %f409, %f411
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f413) : "f"(f731), "f"(f409), "f"(f411));
  // PTX:662 fma.rn.f32 %f414, %f733, %f412, %f413
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f414) : "f"(f733), "f"(f412), "f"(f413));
  // PTX:663 add.f32 %f734, %f408, %f414
  asm("add.f32 %0, %1, %2;" : "=f"(f734) : "f"(f408), "f"(f414));
  // PTX:665 $L__BB32_28:
L_BB32_28:;
  // PTX:666 mul.f32 %f110, %f30, %f734
  asm("mul.f32 %0, %1, %2;" : "=f"(f110) : "f"(f30), "f"(f734));
  // PTX:667 abs.f32 %f415, %f110
  asm("abs.f32 %0, %1;" : "=f"(f415) : "f"(f110));
  // PTX:668 setp.geu.f32 %p23, %f415, 0f7F800000
  p23 = ((isnan(((float)(f415))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f415)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:669 @%p23 bra $L__BB32_37
  if (p23) { goto L_BB32_37; }
  // PTX:671 mul.lo.s64 %rd133, %rd25, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd133) : "l"(rd25));
  // PTX:672 add.s64 %rd134, %rd2, %rd133
  asm("add.s64 %0, %1, %2;" : "=l"(rd134) : "l"(rd2), "l"(rd133));
  // PTX:673 mul.f32 %f416, %f110, %f71
  asm("mul.f32 %0, %1, %2;" : "=f"(f416) : "f"(f110), "f"(f71));
  // PTX:674 red.global.add.f32 [%rd134], %f416
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd134) + (0)))), (float)(f416));
  // PTX:675 add.s64 %rd135, %rd134, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd135) : "l"(rd134));
  // PTX:676 mul.f32 %f418, %f110, %f72
  asm("mul.f32 %0, %1, %2;" : "=f"(f418) : "f"(f110), "f"(f72));
  // PTX:677 red.global.add.f32 [%rd135], %f418
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd135) + (0)))), (float)(f418));
  // PTX:678 add.s64 %rd136, %rd134, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd136) : "l"(rd134));
  // PTX:679 mul.f32 %f420, %f110, %f73
  asm("mul.f32 %0, %1, %2;" : "=f"(f420) : "f"(f110), "f"(f73));
  // PTX:680 red.global.add.f32 [%rd136], %f420
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd136) + (0)))), (float)(f420));
  // PTX:681 add.s64 %rd138, %rd2, %rd119
  asm("add.s64 %0, %1, %2;" : "=l"(rd138) : "l"(rd2), "l"(rd119));
  // PTX:682 mul.f32 %f422, %f110, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f422) : "f"(f110), "f"(f74));
  // PTX:683 red.global.add.f32 [%rd138], %f422
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd138) + (0)))), (float)(f422));
  // PTX:684 add.s64 %rd139, %rd138, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd139) : "l"(rd138));
  // PTX:685 mul.f32 %f424, %f110, %f75
  asm("mul.f32 %0, %1, %2;" : "=f"(f424) : "f"(f110), "f"(f75));
  // PTX:686 red.global.add.f32 [%rd139], %f424
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd139) + (0)))), (float)(f424));
  // PTX:687 add.s64 %rd140, %rd138, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd140) : "l"(rd138));
  // PTX:688 mul.f32 %f426, %f110, %f76
  asm("mul.f32 %0, %1, %2;" : "=f"(f426) : "f"(f110), "f"(f76));
  // PTX:689 red.global.add.f32 [%rd140], %f426
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd140) + (0)))), (float)(f426));
  // PTX:690 add.s64 %rd142, %rd2, %rd121
  asm("add.s64 %0, %1, %2;" : "=l"(rd142) : "l"(rd2), "l"(rd121));
  // PTX:691 mul.f32 %f428, %f110, %f77
  asm("mul.f32 %0, %1, %2;" : "=f"(f428) : "f"(f110), "f"(f77));
  // PTX:692 red.global.add.f32 [%rd142], %f428
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd142) + (0)))), (float)(f428));
  // PTX:693 add.s64 %rd143, %rd142, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd143) : "l"(rd142));
  // PTX:694 mul.f32 %f430, %f110, %f78
  asm("mul.f32 %0, %1, %2;" : "=f"(f430) : "f"(f110), "f"(f78));
  // PTX:695 red.global.add.f32 [%rd143], %f430
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd143) + (0)))), (float)(f430));
  // PTX:696 add.s64 %rd144, %rd142, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd144) : "l"(rd142));
  // PTX:697 mul.f32 %f432, %f110, %f79
  asm("mul.f32 %0, %1, %2;" : "=f"(f432) : "f"(f110), "f"(f79));
  // PTX:698 red.global.add.f32 [%rd144], %f432
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd144) + (0)))), (float)(f432));
  // PTX:699 add.s64 %rd146, %rd2, %rd123
  asm("add.s64 %0, %1, %2;" : "=l"(rd146) : "l"(rd2), "l"(rd123));
  // PTX:700 mul.f32 %f434, %f110, %f80
  asm("mul.f32 %0, %1, %2;" : "=f"(f434) : "f"(f110), "f"(f80));
  // PTX:701 red.global.add.f32 [%rd146], %f434
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd146) + (0)))), (float)(f434));
  // PTX:702 add.s64 %rd147, %rd146, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd147) : "l"(rd146));
  // PTX:703 mul.f32 %f436, %f110, %f81
  asm("mul.f32 %0, %1, %2;" : "=f"(f436) : "f"(f110), "f"(f81));
  // PTX:704 red.global.add.f32 [%rd147], %f436
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd147) + (0)))), (float)(f436));
  // PTX:705 add.s64 %rd148, %rd146, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd148) : "l"(rd146));
  // PTX:706 mul.f32 %f438, %f110, %f82
  asm("mul.f32 %0, %1, %2;" : "=f"(f438) : "f"(f110), "f"(f82));
  // PTX:707 red.global.add.f32 [%rd148], %f438
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd148) + (0)))), (float)(f438));
  // PTX:708 @%p21 bra $L__BB32_37
  if (p21) { goto L_BB32_37; }
  // PTX:710 mul.f32 %f440, %f110, %f729
  asm("mul.f32 %0, %1, %2;" : "=f"(f440) : "f"(f110), "f"(f729));
  // PTX:711 mul.lo.s64 %rd149, %rd20, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd149) : "l"(rd20));
  // PTX:712 add.s64 %rd150, %rd2, %rd149
  asm("add.s64 %0, %1, %2;" : "=l"(rd150) : "l"(rd2), "l"(rd149));
  // PTX:713 red.global.add.f32 [%rd150], %f440
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd150) + (0)))), (float)(f440));
  // PTX:714 add.s64 %rd151, %rd150, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd151) : "l"(rd150));
  // PTX:715 mul.f32 %f442, %f110, %f728
  asm("mul.f32 %0, %1, %2;" : "=f"(f442) : "f"(f110), "f"(f728));
  // PTX:716 red.global.add.f32 [%rd151], %f442
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd151) + (0)))), (float)(f442));
  // PTX:717 add.s64 %rd152, %rd150, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd152) : "l"(rd150));
  // PTX:718 mul.f32 %f444, %f110, %f727
  asm("mul.f32 %0, %1, %2;" : "=f"(f444) : "f"(f110), "f"(f727));
  // PTX:719 red.global.add.f32 [%rd152], %f444
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd152) + (0)))), (float)(f444));
  // PTX:720 mul.lo.s64 %rd153, %rd21, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd153) : "l"(rd21));
  // PTX:721 add.s64 %rd154, %rd2, %rd153
  asm("add.s64 %0, %1, %2;" : "=l"(rd154) : "l"(rd2), "l"(rd153));
  // PTX:722 mul.f32 %f446, %f110, %f726
  asm("mul.f32 %0, %1, %2;" : "=f"(f446) : "f"(f110), "f"(f726));
  // PTX:723 red.global.add.f32 [%rd154], %f446
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd154) + (0)))), (float)(f446));
  // PTX:724 add.s64 %rd155, %rd154, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd155) : "l"(rd154));
  // PTX:725 mul.f32 %f448, %f110, %f725
  asm("mul.f32 %0, %1, %2;" : "=f"(f448) : "f"(f110), "f"(f725));
  // PTX:726 red.global.add.f32 [%rd155], %f448
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd155) + (0)))), (float)(f448));
  // PTX:727 add.s64 %rd156, %rd154, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd156) : "l"(rd154));
  // PTX:728 mul.f32 %f450, %f110, %f724
  asm("mul.f32 %0, %1, %2;" : "=f"(f450) : "f"(f110), "f"(f724));
  // PTX:729 red.global.add.f32 [%rd156], %f450
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd156) + (0)))), (float)(f450));
  // PTX:730 mul.lo.s64 %rd157, %rd22, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd157) : "l"(rd22));
  // PTX:731 add.s64 %rd158, %rd2, %rd157
  asm("add.s64 %0, %1, %2;" : "=l"(rd158) : "l"(rd2), "l"(rd157));
  // PTX:732 mul.f32 %f452, %f110, %f723
  asm("mul.f32 %0, %1, %2;" : "=f"(f452) : "f"(f110), "f"(f723));
  // PTX:733 red.global.add.f32 [%rd158], %f452
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd158) + (0)))), (float)(f452));
  // PTX:734 add.s64 %rd159, %rd158, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd159) : "l"(rd158));
  // PTX:735 mul.f32 %f454, %f110, %f722
  asm("mul.f32 %0, %1, %2;" : "=f"(f454) : "f"(f110), "f"(f722));
  // PTX:736 red.global.add.f32 [%rd159], %f454
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd159) + (0)))), (float)(f454));
  // PTX:737 add.s64 %rd160, %rd158, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd160) : "l"(rd158));
  // PTX:738 mul.f32 %f456, %f110, %f730
  asm("mul.f32 %0, %1, %2;" : "=f"(f456) : "f"(f110), "f"(f730));
  // PTX:739 red.global.add.f32 [%rd160], %f456
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd160) + (0)))), (float)(f456));
  // PTX:740 mul.lo.s64 %rd161, %rd23, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd161) : "l"(rd23));
  // PTX:741 add.s64 %rd162, %rd2, %rd161
  asm("add.s64 %0, %1, %2;" : "=l"(rd162) : "l"(rd2), "l"(rd161));
  // PTX:742 mul.f32 %f458, %f110, %f731
  asm("mul.f32 %0, %1, %2;" : "=f"(f458) : "f"(f110), "f"(f731));
  // PTX:743 red.global.add.f32 [%rd162], %f458
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd162) + (0)))), (float)(f458));
  // PTX:744 add.s64 %rd163, %rd162, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd163) : "l"(rd162));
  // PTX:745 mul.f32 %f460, %f110, %f732
  asm("mul.f32 %0, %1, %2;" : "=f"(f460) : "f"(f110), "f"(f732));
  // PTX:746 red.global.add.f32 [%rd163], %f460
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd163) + (0)))), (float)(f460));
  // PTX:747 add.s64 %rd164, %rd162, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd164) : "l"(rd162));
  // PTX:748 mul.f32 %f462, %f110, %f733
  asm("mul.f32 %0, %1, %2;" : "=f"(f462) : "f"(f110), "f"(f733));
  // PTX:749 red.global.add.f32 [%rd164], %f462
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd164) + (0)))), (float)(f462));
  // PTX:750 bra.uni $L__BB32_37
  goto L_BB32_37;
  // PTX:752 $L__BB32_31:
L_BB32_31:;
  // PTX:753 cvt.u32.u64 %r55, %rd12
  asm("cvt.u32.u64 %0, %1;" : "=r"(r55) : "l"(rd12));
  // PTX:754 setp.lt.s32 %p25, %r55, 0
  p25 = (((int)(r55)) < ((int)(0)));
  // PTX:755 ld.global.f32 %f467, [%rd33]
  f467 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (0)))));
  // PTX:756 ld.global.f32 %f468, [%rd33+4]
  f468 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (4)))));
  // PTX:757 ld.global.f32 %f469, [%rd33+8]
  f469 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (8)))));
  // PTX:758 mul.lo.s64 %rd165, %rd27, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd165) : "l"(rd27));
  // PTX:759 add.s64 %rd166, %rd1, %rd165
  asm("add.s64 %0, %1, %2;" : "=l"(rd166) : "l"(rd1), "l"(rd165));
  // PTX:760 ld.global.f32 %f470, [%rd166]
  f470 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd166) + (0)))));
  // PTX:761 mul.f32 %f471, %f470, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f471) : "f"(f470), "f"(f32));
  // PTX:762 ld.global.f32 %f472, [%rd166+4]
  f472 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd166) + (4)))));
  // PTX:763 mul.f32 %f473, %f472, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f473) : "f"(f472), "f"(f32));
  // PTX:764 ld.global.f32 %f474, [%rd166+8]
  f474 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd166) + (8)))));
  // PTX:765 mul.f32 %f475, %f474, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f475) : "f"(f474), "f"(f32));
  // PTX:766 fma.rn.f32 %f476, %f31, %f467, %f471
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f476) : "f"(f31), "f"(f467), "f"(f471));
  // PTX:767 fma.rn.f32 %f477, %f31, %f468, %f473
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f477) : "f"(f31), "f"(f468), "f"(f473));
  // PTX:768 fma.rn.f32 %f478, %f31, %f469, %f475
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f478) : "f"(f31), "f"(f469), "f"(f475));
  // PTX:769 mul.lo.s64 %rd167, %rd29, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd167) : "l"(rd29));
  // PTX:770 add.s64 %rd168, %rd1, %rd167
  asm("add.s64 %0, %1, %2;" : "=l"(rd168) : "l"(rd1), "l"(rd167));
  // PTX:771 ld.global.f32 %f479, [%rd168]
  f479 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd168) + (0)))));
  // PTX:772 ld.global.f32 %f480, [%rd168+4]
  f480 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd168) + (4)))));
  // PTX:773 ld.global.f32 %f481, [%rd168+8]
  f481 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd168) + (8)))));
  // PTX:774 fma.rn.f32 %f482, %f479, %f33, %f476
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f482) : "f"(f479), "f"(f33), "f"(f476));
  // PTX:775 fma.rn.f32 %f483, %f480, %f33, %f477
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f483) : "f"(f480), "f"(f33), "f"(f477));
  // PTX:776 fma.rn.f32 %f484, %f481, %f33, %f478
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f484) : "f"(f481), "f"(f33), "f"(f478));
  // PTX:777 mul.lo.s64 %rd169, %rd31, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd169) : "l"(rd31));
  // PTX:778 add.s64 %rd170, %rd1, %rd169
  asm("add.s64 %0, %1, %2;" : "=l"(rd170) : "l"(rd1), "l"(rd169));
  // PTX:779 ld.global.f32 %f485, [%rd170]
  f485 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd170) + (0)))));
  // PTX:780 ld.global.f32 %f486, [%rd170+4]
  f486 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd170) + (4)))));
  // PTX:781 ld.global.f32 %f487, [%rd170+8]
  f487 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd170) + (8)))));
  // PTX:782 fma.rn.f32 %f111, %f485, %f34, %f482
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f111) : "f"(f485), "f"(f34), "f"(f482));
  // PTX:783 fma.rn.f32 %f112, %f486, %f34, %f483
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f112) : "f"(f486), "f"(f34), "f"(f483));
  // PTX:784 fma.rn.f32 %f113, %f487, %f34, %f484
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f113) : "f"(f487), "f"(f34), "f"(f484));
  // PTX:785 mov.f32 %f735, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f735) : );
  // PTX:786 mov.f32 %f736, %f735
  asm("mov.f32 %0, %1;" : "=f"(f736) : "f"(f735));
  // PTX:787 mov.f32 %f737, %f735
  asm("mov.f32 %0, %1;" : "=f"(f737) : "f"(f735));
  // PTX:788 @%p25 bra $L__BB32_33
  if (p25) { goto L_BB32_33; }
  // PTX:790 ld.global.f32 %f488, [%rd13]
  f488 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))));
  // PTX:791 mul.lo.s64 %rd171, %rd20, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd171) : "l"(rd20));
  // PTX:792 add.s64 %rd172, %rd1, %rd171
  asm("add.s64 %0, %1, %2;" : "=l"(rd172) : "l"(rd1), "l"(rd171));
  // PTX:793 ld.global.f32 %f489, [%rd172]
  f489 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd172) + (0)))));
  // PTX:794 ld.global.f32 %f490, [%rd172+4]
  f490 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd172) + (4)))));
  // PTX:795 ld.global.f32 %f491, [%rd172+8]
  f491 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd172) + (8)))));
  // PTX:796 mul.lo.s64 %rd173, %rd21, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd173) : "l"(rd21));
  // PTX:797 add.s64 %rd174, %rd1, %rd173
  asm("add.s64 %0, %1, %2;" : "=l"(rd174) : "l"(rd1), "l"(rd173));
  // PTX:798 ld.global.f32 %f492, [%rd174]
  f492 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd174) + (0)))));
  // PTX:799 ld.global.f32 %f493, [%rd13+4]
  f493 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4)))));
  // PTX:800 mul.f32 %f494, %f493, %f492
  asm("mul.f32 %0, %1, %2;" : "=f"(f494) : "f"(f493), "f"(f492));
  // PTX:801 ld.global.f32 %f495, [%rd174+4]
  f495 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd174) + (4)))));
  // PTX:802 mul.f32 %f496, %f493, %f495
  asm("mul.f32 %0, %1, %2;" : "=f"(f496) : "f"(f493), "f"(f495));
  // PTX:803 ld.global.f32 %f497, [%rd174+8]
  f497 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd174) + (8)))));
  // PTX:804 mul.f32 %f498, %f493, %f497
  asm("mul.f32 %0, %1, %2;" : "=f"(f498) : "f"(f493), "f"(f497));
  // PTX:805 fma.rn.f32 %f499, %f488, %f489, %f494
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f499) : "f"(f488), "f"(f489), "f"(f494));
  // PTX:806 fma.rn.f32 %f500, %f488, %f490, %f496
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f500) : "f"(f488), "f"(f490), "f"(f496));
  // PTX:807 fma.rn.f32 %f501, %f488, %f491, %f498
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f501) : "f"(f488), "f"(f491), "f"(f498));
  // PTX:808 mul.lo.s64 %rd175, %rd22, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd175) : "l"(rd22));
  // PTX:809 add.s64 %rd176, %rd1, %rd175
  asm("add.s64 %0, %1, %2;" : "=l"(rd176) : "l"(rd1), "l"(rd175));
  // PTX:810 ld.global.f32 %f502, [%rd176]
  f502 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd176) + (0)))));
  // PTX:811 ld.global.f32 %f503, [%rd13+8]
  f503 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8)))));
  // PTX:812 ld.global.f32 %f504, [%rd176+4]
  f504 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd176) + (4)))));
  // PTX:813 ld.global.f32 %f505, [%rd176+8]
  f505 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd176) + (8)))));
  // PTX:814 fma.rn.f32 %f506, %f503, %f502, %f499
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f506) : "f"(f503), "f"(f502), "f"(f499));
  // PTX:815 fma.rn.f32 %f507, %f503, %f504, %f500
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f507) : "f"(f503), "f"(f504), "f"(f500));
  // PTX:816 fma.rn.f32 %f508, %f503, %f505, %f501
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f508) : "f"(f503), "f"(f505), "f"(f501));
  // PTX:817 mul.lo.s64 %rd177, %rd23, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd177) : "l"(rd23));
  // PTX:818 add.s64 %rd178, %rd1, %rd177
  asm("add.s64 %0, %1, %2;" : "=l"(rd178) : "l"(rd1), "l"(rd177));
  // PTX:819 ld.global.f32 %f509, [%rd178]
  f509 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd178) + (0)))));
  // PTX:820 ld.global.f32 %f510, [%rd13+12]
  f510 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (12)))));
  // PTX:821 ld.global.f32 %f511, [%rd178+4]
  f511 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd178) + (4)))));
  // PTX:822 ld.global.f32 %f512, [%rd178+8]
  f512 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd178) + (8)))));
  // PTX:823 fma.rn.f32 %f735, %f510, %f509, %f506
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f735) : "f"(f510), "f"(f509), "f"(f506));
  // PTX:824 fma.rn.f32 %f736, %f510, %f511, %f507
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f736) : "f"(f510), "f"(f511), "f"(f507));
  // PTX:825 fma.rn.f32 %f737, %f510, %f512, %f508
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f737) : "f"(f510), "f"(f512), "f"(f508));
  // PTX:827 $L__BB32_33:
L_BB32_33:;
  // PTX:828 setp.gt.s32 %p26, %r55, -1
  p26 = (((int)(r55)) > ((int)(-1)));
  // PTX:829 sub.f32 %f513, %f111, %f735
  asm("sub.f32 %0, %1, %2;" : "=f"(f513) : "f"(f111), "f"(f735));
  // PTX:830 sub.f32 %f514, %f112, %f736
  asm("sub.f32 %0, %1, %2;" : "=f"(f514) : "f"(f112), "f"(f736));
  // PTX:831 mul.f32 %f515, %f514, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f515) : "f"(f514), "f"(f24));
  // PTX:832 sub.f32 %f516, %f113, %f737
  asm("sub.f32 %0, %1, %2;" : "=f"(f516) : "f"(f113), "f"(f737));
  // PTX:833 fma.rn.f32 %f517, %f513, %f23, %f515
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f517) : "f"(f513), "f"(f23), "f"(f515));
  // PTX:834 fma.rn.f32 %f120, %f516, %f25, %f517
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f120) : "f"(f516), "f"(f25), "f"(f517));
  // PTX:835 @%p26 bra $L__BB32_35
  if (p26) { goto L_BB32_35; }
  // PTX:836 bra.uni $L__BB32_34
  goto L_BB32_34;
  // PTX:838 $L__BB32_35:
L_BB32_35:;
  // PTX:839 setp.le.f32 %p27, %f22, 0f322BCC77
  p27 = (!(isnan(((float)(f22))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f22)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:840 @%p27 bra $L__BB32_37
  if (p27) { goto L_BB32_37; }
  // PTX:842 ld.global.f32 %f546, [%rd14]
  f546 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:843 mul.lo.s64 %rd195, %rd20, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd195) : "l"(rd20));
  // PTX:844 add.s64 %rd196, %rd1, %rd195
  asm("add.s64 %0, %1, %2;" : "=l"(rd196) : "l"(rd1), "l"(rd195));
  // PTX:845 ld.global.f32 %f547, [%rd196]
  f547 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd196) + (0)))));
  // PTX:846 ld.global.f32 %f548, [%rd196+4]
  f548 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd196) + (4)))));
  // PTX:847 ld.global.f32 %f549, [%rd196+8]
  f549 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd196) + (8)))));
  // PTX:848 mul.lo.s64 %rd197, %rd21, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd197) : "l"(rd21));
  // PTX:849 add.s64 %rd198, %rd1, %rd197
  asm("add.s64 %0, %1, %2;" : "=l"(rd198) : "l"(rd1), "l"(rd197));
  // PTX:850 ld.global.f32 %f550, [%rd198]
  f550 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd198) + (0)))));
  // PTX:851 ld.global.f32 %f551, [%rd14+4]
  f551 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (4)))));
  // PTX:852 mul.f32 %f552, %f551, %f550
  asm("mul.f32 %0, %1, %2;" : "=f"(f552) : "f"(f551), "f"(f550));
  // PTX:853 ld.global.f32 %f553, [%rd198+4]
  f553 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd198) + (4)))));
  // PTX:854 mul.f32 %f554, %f551, %f553
  asm("mul.f32 %0, %1, %2;" : "=f"(f554) : "f"(f551), "f"(f553));
  // PTX:855 ld.global.f32 %f555, [%rd198+8]
  f555 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd198) + (8)))));
  // PTX:856 mul.f32 %f556, %f551, %f555
  asm("mul.f32 %0, %1, %2;" : "=f"(f556) : "f"(f551), "f"(f555));
  // PTX:857 fma.rn.f32 %f557, %f546, %f547, %f552
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f557) : "f"(f546), "f"(f547), "f"(f552));
  // PTX:858 fma.rn.f32 %f558, %f546, %f548, %f554
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f558) : "f"(f546), "f"(f548), "f"(f554));
  // PTX:859 fma.rn.f32 %f559, %f546, %f549, %f556
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f559) : "f"(f546), "f"(f549), "f"(f556));
  // PTX:860 mul.lo.s64 %rd199, %rd22, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd199) : "l"(rd22));
  // PTX:861 add.s64 %rd200, %rd1, %rd199
  asm("add.s64 %0, %1, %2;" : "=l"(rd200) : "l"(rd1), "l"(rd199));
  // PTX:862 ld.global.f32 %f560, [%rd200]
  f560 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd200) + (0)))));
  // PTX:863 ld.global.f32 %f561, [%rd14+8]
  f561 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (8)))));
  // PTX:864 ld.global.f32 %f562, [%rd200+4]
  f562 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd200) + (4)))));
  // PTX:865 ld.global.f32 %f563, [%rd200+8]
  f563 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd200) + (8)))));
  // PTX:866 fma.rn.f32 %f564, %f561, %f560, %f557
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f564) : "f"(f561), "f"(f560), "f"(f557));
  // PTX:867 fma.rn.f32 %f565, %f561, %f562, %f558
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f565) : "f"(f561), "f"(f562), "f"(f558));
  // PTX:868 fma.rn.f32 %f566, %f561, %f563, %f559
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f566) : "f"(f561), "f"(f563), "f"(f559));
  // PTX:869 mul.lo.s64 %rd201, %rd23, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd201) : "l"(rd23));
  // PTX:870 add.s64 %rd202, %rd1, %rd201
  asm("add.s64 %0, %1, %2;" : "=l"(rd202) : "l"(rd1), "l"(rd201));
  // PTX:871 ld.global.f32 %f567, [%rd202]
  f567 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd202) + (0)))));
  // PTX:872 ld.global.f32 %f568, [%rd14+12]
  f568 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (12)))));
  // PTX:873 ld.global.f32 %f569, [%rd202+4]
  f569 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd202) + (4)))));
  // PTX:874 ld.global.f32 %f570, [%rd202+8]
  f570 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd202) + (8)))));
  // PTX:875 fma.rn.f32 %f571, %f568, %f567, %f564
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f571) : "f"(f568), "f"(f567), "f"(f564));
  // PTX:876 fma.rn.f32 %f572, %f568, %f569, %f565
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f572) : "f"(f568), "f"(f569), "f"(f565));
  // PTX:877 fma.rn.f32 %f573, %f568, %f570, %f566
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f573) : "f"(f568), "f"(f570), "f"(f566));
  // PTX:878 ld.global.f32 %f574, [%rd26]
  f574 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (0)))));
  // PTX:879 ld.global.f32 %f575, [%rd26+4]
  f575 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (4)))));
  // PTX:880 ld.global.f32 %f576, [%rd26+8]
  f576 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (8)))));
  // PTX:881 ld.global.f32 %f577, [%rd28]
  f577 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (0)))));
  // PTX:882 mul.f32 %f578, %f32, %f577
  asm("mul.f32 %0, %1, %2;" : "=f"(f578) : "f"(f32), "f"(f577));
  // PTX:883 ld.global.f32 %f579, [%rd28+4]
  f579 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (4)))));
  // PTX:884 mul.f32 %f580, %f32, %f579
  asm("mul.f32 %0, %1, %2;" : "=f"(f580) : "f"(f32), "f"(f579));
  // PTX:885 ld.global.f32 %f581, [%rd28+8]
  f581 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (8)))));
  // PTX:886 mul.f32 %f582, %f32, %f581
  asm("mul.f32 %0, %1, %2;" : "=f"(f582) : "f"(f32), "f"(f581));
  // PTX:887 fma.rn.f32 %f583, %f31, %f574, %f578
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f583) : "f"(f31), "f"(f574), "f"(f578));
  // PTX:888 fma.rn.f32 %f584, %f31, %f575, %f580
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f584) : "f"(f31), "f"(f575), "f"(f580));
  // PTX:889 fma.rn.f32 %f585, %f31, %f576, %f582
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f585) : "f"(f31), "f"(f576), "f"(f582));
  // PTX:890 ld.global.f32 %f586, [%rd30]
  f586 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0)))));
  // PTX:891 ld.global.f32 %f587, [%rd30+4]
  f587 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (4)))));
  // PTX:892 ld.global.f32 %f588, [%rd30+8]
  f588 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (8)))));
  // PTX:893 fma.rn.f32 %f589, %f33, %f586, %f583
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f589) : "f"(f33), "f"(f586), "f"(f583));
  // PTX:894 fma.rn.f32 %f590, %f33, %f587, %f584
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f590) : "f"(f33), "f"(f587), "f"(f584));
  // PTX:895 fma.rn.f32 %f591, %f33, %f588, %f585
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f591) : "f"(f33), "f"(f588), "f"(f585));
  // PTX:896 ld.global.f32 %f592, [%rd32]
  f592 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (0)))));
  // PTX:897 ld.global.f32 %f593, [%rd32+4]
  f593 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (4)))));
  // PTX:898 ld.global.f32 %f594, [%rd32+8]
  f594 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (8)))));
  // PTX:899 fma.rn.f32 %f595, %f34, %f592, %f589
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f595) : "f"(f34), "f"(f592), "f"(f589));
  // PTX:900 fma.rn.f32 %f596, %f34, %f593, %f590
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f596) : "f"(f34), "f"(f593), "f"(f590));
  // PTX:901 fma.rn.f32 %f597, %f34, %f594, %f591
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f597) : "f"(f34), "f"(f594), "f"(f591));
  // PTX:902 sub.f32 %f598, %f595, %f16
  asm("sub.f32 %0, %1, %2;" : "=f"(f598) : "f"(f595), "f"(f16));
  // PTX:903 sub.f32 %f599, %f596, %f17
  asm("sub.f32 %0, %1, %2;" : "=f"(f599) : "f"(f596), "f"(f17));
  // PTX:904 sub.f32 %f600, %f597, %f18
  asm("sub.f32 %0, %1, %2;" : "=f"(f600) : "f"(f597), "f"(f18));
  // PTX:905 mul.f32 %f601, %f599, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f601) : "f"(f599), "f"(f24));
  // PTX:906 fma.rn.f32 %f602, %f598, %f23, %f601
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f602) : "f"(f598), "f"(f23), "f"(f601));
  // PTX:907 fma.rn.f32 %f603, %f600, %f25, %f602
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f603) : "f"(f600), "f"(f25), "f"(f602));
  // PTX:908 mul.f32 %f604, %f603, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f604) : "f"(f603), "f"(f23));
  // PTX:909 mul.f32 %f605, %f603, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f605) : "f"(f603), "f"(f24));
  // PTX:910 mul.f32 %f606, %f603, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f606) : "f"(f603), "f"(f25));
  // PTX:911 sub.f32 %f607, %f598, %f604
  asm("sub.f32 %0, %1, %2;" : "=f"(f607) : "f"(f598), "f"(f604));
  // PTX:912 sub.f32 %f608, %f599, %f605
  asm("sub.f32 %0, %1, %2;" : "=f"(f608) : "f"(f599), "f"(f605));
  // PTX:913 sub.f32 %f609, %f600, %f606
  asm("sub.f32 %0, %1, %2;" : "=f"(f609) : "f"(f600), "f"(f606));
  // PTX:914 div.rn.f32 %f610, %f607, %f22
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f610) : "f"(f607), "f"(f22));
  // PTX:915 div.rn.f32 %f611, %f608, %f22
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f611) : "f"(f608), "f"(f22));
  // PTX:916 div.rn.f32 %f612, %f609, %f22
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f612) : "f"(f609), "f"(f22));
  // PTX:917 sub.f32 %f613, %f571, %f735
  asm("sub.f32 %0, %1, %2;" : "=f"(f613) : "f"(f571), "f"(f735));
  // PTX:918 sub.f32 %f614, %f572, %f736
  asm("sub.f32 %0, %1, %2;" : "=f"(f614) : "f"(f572), "f"(f736));
  // PTX:919 sub.f32 %f615, %f573, %f737
  asm("sub.f32 %0, %1, %2;" : "=f"(f615) : "f"(f573), "f"(f737));
  // PTX:920 mul.f32 %f616, %f614, %f611
  asm("mul.f32 %0, %1, %2;" : "=f"(f616) : "f"(f614), "f"(f611));
  // PTX:921 fma.rn.f32 %f617, %f613, %f610, %f616
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f617) : "f"(f613), "f"(f610), "f"(f616));
  // PTX:922 fma.rn.f32 %f618, %f615, %f612, %f617
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f618) : "f"(f615), "f"(f612), "f"(f617));
  // PTX:923 add.f32 %f619, %f120, %f618
  asm("add.f32 %0, %1, %2;" : "=f"(f619) : "f"(f120), "f"(f618));
  // PTX:924 mul.f32 %f620, %f30, %f619
  asm("mul.f32 %0, %1, %2;" : "=f"(f620) : "f"(f30), "f"(f619));
  // PTX:925 mul.f32 %f621, %f620, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f621) : "f"(f620), "f"(f23));
  // PTX:926 mul.f32 %f622, %f620, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f622) : "f"(f620), "f"(f24));
  // PTX:927 mul.f32 %f623, %f620, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f623) : "f"(f620), "f"(f25));
  // PTX:928 mul.f32 %f624, %f31, %f621
  asm("mul.f32 %0, %1, %2;" : "=f"(f624) : "f"(f31), "f"(f621));
  // PTX:929 mul.f32 %f625, %f31, %f622
  asm("mul.f32 %0, %1, %2;" : "=f"(f625) : "f"(f31), "f"(f622));
  // PTX:930 mul.f32 %f626, %f31, %f623
  asm("mul.f32 %0, %1, %2;" : "=f"(f626) : "f"(f31), "f"(f623));
  // PTX:931 mul.f32 %f627, %f32, %f621
  asm("mul.f32 %0, %1, %2;" : "=f"(f627) : "f"(f32), "f"(f621));
  // PTX:932 mul.f32 %f628, %f32, %f622
  asm("mul.f32 %0, %1, %2;" : "=f"(f628) : "f"(f32), "f"(f622));
  // PTX:933 mul.f32 %f629, %f32, %f623
  asm("mul.f32 %0, %1, %2;" : "=f"(f629) : "f"(f32), "f"(f623));
  // PTX:934 mul.f32 %f630, %f33, %f621
  asm("mul.f32 %0, %1, %2;" : "=f"(f630) : "f"(f33), "f"(f621));
  // PTX:935 mul.f32 %f631, %f33, %f622
  asm("mul.f32 %0, %1, %2;" : "=f"(f631) : "f"(f33), "f"(f622));
  // PTX:936 mul.f32 %f632, %f33, %f623
  asm("mul.f32 %0, %1, %2;" : "=f"(f632) : "f"(f33), "f"(f623));
  // PTX:937 mul.f32 %f633, %f34, %f621
  asm("mul.f32 %0, %1, %2;" : "=f"(f633) : "f"(f34), "f"(f621));
  // PTX:938 mul.f32 %f634, %f34, %f622
  asm("mul.f32 %0, %1, %2;" : "=f"(f634) : "f"(f34), "f"(f622));
  // PTX:939 mul.f32 %f635, %f34, %f623
  asm("mul.f32 %0, %1, %2;" : "=f"(f635) : "f"(f34), "f"(f623));
  // PTX:940 mul.lo.s64 %rd203, %rd25, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd203) : "l"(rd25));
  // PTX:941 add.s64 %rd204, %rd2, %rd203
  asm("add.s64 %0, %1, %2;" : "=l"(rd204) : "l"(rd2), "l"(rd203));
  // PTX:942 red.global.add.f32 [%rd204], %f624
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd204) + (0)))), (float)(f624));
  // PTX:943 add.s64 %rd205, %rd204, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd205) : "l"(rd204));
  // PTX:944 red.global.add.f32 [%rd205], %f625
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd205) + (0)))), (float)(f625));
  // PTX:945 add.s64 %rd206, %rd204, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd206) : "l"(rd204));
  // PTX:946 red.global.add.f32 [%rd206], %f626
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd206) + (0)))), (float)(f626));
  // PTX:947 add.s64 %rd208, %rd2, %rd165
  asm("add.s64 %0, %1, %2;" : "=l"(rd208) : "l"(rd2), "l"(rd165));
  // PTX:948 red.global.add.f32 [%rd208], %f627
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd208) + (0)))), (float)(f627));
  // PTX:949 add.s64 %rd209, %rd208, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd209) : "l"(rd208));
  // PTX:950 red.global.add.f32 [%rd209], %f628
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd209) + (0)))), (float)(f628));
  // PTX:951 add.s64 %rd210, %rd208, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd210) : "l"(rd208));
  // PTX:952 red.global.add.f32 [%rd210], %f629
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd210) + (0)))), (float)(f629));
  // PTX:953 add.s64 %rd212, %rd2, %rd167
  asm("add.s64 %0, %1, %2;" : "=l"(rd212) : "l"(rd2), "l"(rd167));
  // PTX:954 red.global.add.f32 [%rd212], %f630
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd212) + (0)))), (float)(f630));
  // PTX:955 add.s64 %rd213, %rd212, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd213) : "l"(rd212));
  // PTX:956 red.global.add.f32 [%rd213], %f631
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd213) + (0)))), (float)(f631));
  // PTX:957 add.s64 %rd214, %rd212, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd214) : "l"(rd212));
  // PTX:958 red.global.add.f32 [%rd214], %f632
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd214) + (0)))), (float)(f632));
  // PTX:959 add.s64 %rd216, %rd2, %rd169
  asm("add.s64 %0, %1, %2;" : "=l"(rd216) : "l"(rd2), "l"(rd169));
  // PTX:960 red.global.add.f32 [%rd216], %f633
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd216) + (0)))), (float)(f633));
  // PTX:961 add.s64 %rd217, %rd216, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd217) : "l"(rd216));
  // PTX:962 red.global.add.f32 [%rd217], %f634
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd217) + (0)))), (float)(f634));
  // PTX:963 add.s64 %rd218, %rd216, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd218) : "l"(rd216));
  // PTX:964 red.global.add.f32 [%rd218], %f635
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd218) + (0)))), (float)(f635));
  // PTX:965 neg.f32 %f648, %f620
  asm("neg.f32 %0, %1;" : "=f"(f648) : "f"(f620));
  // PTX:966 add.f32 %f649, %f610, %f23
  asm("add.f32 %0, %1, %2;" : "=f"(f649) : "f"(f610), "f"(f23));
  // PTX:967 add.f32 %f650, %f611, %f24
  asm("add.f32 %0, %1, %2;" : "=f"(f650) : "f"(f611), "f"(f24));
  // PTX:968 add.f32 %f651, %f612, %f25
  asm("add.f32 %0, %1, %2;" : "=f"(f651) : "f"(f612), "f"(f25));
  // PTX:969 mul.f32 %f652, %f649, %f648
  asm("mul.f32 %0, %1, %2;" : "=f"(f652) : "f"(f649), "f"(f648));
  // PTX:970 mul.f32 %f653, %f650, %f648
  asm("mul.f32 %0, %1, %2;" : "=f"(f653) : "f"(f650), "f"(f648));
  // PTX:971 mul.f32 %f654, %f651, %f648
  asm("mul.f32 %0, %1, %2;" : "=f"(f654) : "f"(f651), "f"(f648));
  // PTX:972 ld.global.f32 %f655, [%rd13]
  f655 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))));
  // PTX:973 mul.f32 %f656, %f652, %f655
  asm("mul.f32 %0, %1, %2;" : "=f"(f656) : "f"(f652), "f"(f655));
  // PTX:974 mul.f32 %f657, %f653, %f655
  asm("mul.f32 %0, %1, %2;" : "=f"(f657) : "f"(f653), "f"(f655));
  // PTX:975 mul.f32 %f658, %f654, %f655
  asm("mul.f32 %0, %1, %2;" : "=f"(f658) : "f"(f654), "f"(f655));
  // PTX:976 ld.global.f32 %f659, [%rd13+4]
  f659 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4)))));
  // PTX:977 mul.f32 %f660, %f652, %f659
  asm("mul.f32 %0, %1, %2;" : "=f"(f660) : "f"(f652), "f"(f659));
  // PTX:978 mul.f32 %f661, %f653, %f659
  asm("mul.f32 %0, %1, %2;" : "=f"(f661) : "f"(f653), "f"(f659));
  // PTX:979 mul.f32 %f662, %f654, %f659
  asm("mul.f32 %0, %1, %2;" : "=f"(f662) : "f"(f654), "f"(f659));
  // PTX:980 ld.global.f32 %f663, [%rd13+8]
  f663 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8)))));
  // PTX:981 mul.f32 %f664, %f652, %f663
  asm("mul.f32 %0, %1, %2;" : "=f"(f664) : "f"(f652), "f"(f663));
  // PTX:982 mul.f32 %f665, %f653, %f663
  asm("mul.f32 %0, %1, %2;" : "=f"(f665) : "f"(f653), "f"(f663));
  // PTX:983 mul.f32 %f666, %f654, %f663
  asm("mul.f32 %0, %1, %2;" : "=f"(f666) : "f"(f654), "f"(f663));
  // PTX:984 ld.global.f32 %f667, [%rd13+12]
  f667 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (12)))));
  // PTX:985 mul.f32 %f668, %f652, %f667
  asm("mul.f32 %0, %1, %2;" : "=f"(f668) : "f"(f652), "f"(f667));
  // PTX:986 mul.f32 %f669, %f653, %f667
  asm("mul.f32 %0, %1, %2;" : "=f"(f669) : "f"(f653), "f"(f667));
  // PTX:987 mul.f32 %f670, %f654, %f667
  asm("mul.f32 %0, %1, %2;" : "=f"(f670) : "f"(f654), "f"(f667));
  // PTX:988 add.s64 %rd219, %rd2, %rd195
  asm("add.s64 %0, %1, %2;" : "=l"(rd219) : "l"(rd2), "l"(rd195));
  // PTX:989 red.global.add.f32 [%rd219], %f656
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd219) + (0)))), (float)(f656));
  // PTX:990 add.s64 %rd220, %rd219, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd220) : "l"(rd219));
  // PTX:991 red.global.add.f32 [%rd220], %f657
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd220) + (0)))), (float)(f657));
  // PTX:992 add.s64 %rd221, %rd219, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd221) : "l"(rd219));
  // PTX:993 red.global.add.f32 [%rd221], %f658
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd221) + (0)))), (float)(f658));
  // PTX:994 add.s64 %rd222, %rd2, %rd197
  asm("add.s64 %0, %1, %2;" : "=l"(rd222) : "l"(rd2), "l"(rd197));
  // PTX:995 red.global.add.f32 [%rd222], %f660
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd222) + (0)))), (float)(f660));
  // PTX:996 add.s64 %rd223, %rd222, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd223) : "l"(rd222));
  // PTX:997 red.global.add.f32 [%rd223], %f661
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd223) + (0)))), (float)(f661));
  // PTX:998 add.s64 %rd224, %rd222, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd224) : "l"(rd222));
  // PTX:999 red.global.add.f32 [%rd224], %f662
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd224) + (0)))), (float)(f662));
  // PTX:1000 add.s64 %rd225, %rd2, %rd199
  asm("add.s64 %0, %1, %2;" : "=l"(rd225) : "l"(rd2), "l"(rd199));
  // PTX:1001 red.global.add.f32 [%rd225], %f664
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd225) + (0)))), (float)(f664));
  // PTX:1002 add.s64 %rd226, %rd225, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd226) : "l"(rd225));
  // PTX:1003 red.global.add.f32 [%rd226], %f665
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd226) + (0)))), (float)(f665));
  // PTX:1004 add.s64 %rd227, %rd225, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd227) : "l"(rd225));
  // PTX:1005 red.global.add.f32 [%rd227], %f666
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd227) + (0)))), (float)(f666));
  // PTX:1006 add.s64 %rd228, %rd2, %rd201
  asm("add.s64 %0, %1, %2;" : "=l"(rd228) : "l"(rd2), "l"(rd201));
  // PTX:1007 red.global.add.f32 [%rd228], %f668
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd228) + (0)))), (float)(f668));
  // PTX:1008 add.s64 %rd229, %rd228, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd229) : "l"(rd228));
  // PTX:1009 red.global.add.f32 [%rd229], %f669
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd229) + (0)))), (float)(f669));
  // PTX:1010 add.s64 %rd230, %rd228, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd230) : "l"(rd228));
  // PTX:1011 red.global.add.f32 [%rd230], %f670
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd230) + (0)))), (float)(f670));
  // PTX:1012 mul.f32 %f683, %f610, %f620
  asm("mul.f32 %0, %1, %2;" : "=f"(f683) : "f"(f610), "f"(f620));
  // PTX:1013 mul.f32 %f684, %f611, %f620
  asm("mul.f32 %0, %1, %2;" : "=f"(f684) : "f"(f611), "f"(f620));
  // PTX:1014 mul.f32 %f685, %f612, %f620
  asm("mul.f32 %0, %1, %2;" : "=f"(f685) : "f"(f612), "f"(f620));
  // PTX:1015 ld.global.f32 %f686, [%rd14]
  f686 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:1016 mul.f32 %f687, %f683, %f686
  asm("mul.f32 %0, %1, %2;" : "=f"(f687) : "f"(f683), "f"(f686));
  // PTX:1017 mul.f32 %f688, %f684, %f686
  asm("mul.f32 %0, %1, %2;" : "=f"(f688) : "f"(f684), "f"(f686));
  // PTX:1018 mul.f32 %f689, %f685, %f686
  asm("mul.f32 %0, %1, %2;" : "=f"(f689) : "f"(f685), "f"(f686));
  // PTX:1019 ld.global.f32 %f690, [%rd14+4]
  f690 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (4)))));
  // PTX:1020 mul.f32 %f691, %f683, %f690
  asm("mul.f32 %0, %1, %2;" : "=f"(f691) : "f"(f683), "f"(f690));
  // PTX:1021 mul.f32 %f692, %f684, %f690
  asm("mul.f32 %0, %1, %2;" : "=f"(f692) : "f"(f684), "f"(f690));
  // PTX:1022 mul.f32 %f693, %f685, %f690
  asm("mul.f32 %0, %1, %2;" : "=f"(f693) : "f"(f685), "f"(f690));
  // PTX:1023 ld.global.f32 %f694, [%rd14+8]
  f694 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (8)))));
  // PTX:1024 mul.f32 %f695, %f683, %f694
  asm("mul.f32 %0, %1, %2;" : "=f"(f695) : "f"(f683), "f"(f694));
  // PTX:1025 mul.f32 %f696, %f684, %f694
  asm("mul.f32 %0, %1, %2;" : "=f"(f696) : "f"(f684), "f"(f694));
  // PTX:1026 mul.f32 %f697, %f685, %f694
  asm("mul.f32 %0, %1, %2;" : "=f"(f697) : "f"(f685), "f"(f694));
  // PTX:1027 ld.global.f32 %f698, [%rd14+12]
  f698 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (12)))));
  // PTX:1028 mul.f32 %f699, %f683, %f698
  asm("mul.f32 %0, %1, %2;" : "=f"(f699) : "f"(f683), "f"(f698));
  // PTX:1029 mul.f32 %f700, %f684, %f698
  asm("mul.f32 %0, %1, %2;" : "=f"(f700) : "f"(f684), "f"(f698));
  // PTX:1030 mul.f32 %f701, %f685, %f698
  asm("mul.f32 %0, %1, %2;" : "=f"(f701) : "f"(f685), "f"(f698));
  // PTX:1031 red.global.add.f32 [%rd219], %f687
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd219) + (0)))), (float)(f687));
  // PTX:1032 red.global.add.f32 [%rd220], %f688
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd220) + (0)))), (float)(f688));
  // PTX:1033 red.global.add.f32 [%rd221], %f689
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd221) + (0)))), (float)(f689));
  // PTX:1034 red.global.add.f32 [%rd222], %f691
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd222) + (0)))), (float)(f691));
  // PTX:1035 red.global.add.f32 [%rd223], %f692
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd223) + (0)))), (float)(f692));
  // PTX:1036 red.global.add.f32 [%rd224], %f693
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd224) + (0)))), (float)(f693));
  // PTX:1037 red.global.add.f32 [%rd225], %f695
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd225) + (0)))), (float)(f695));
  // PTX:1038 red.global.add.f32 [%rd226], %f696
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd226) + (0)))), (float)(f696));
  // PTX:1039 red.global.add.f32 [%rd227], %f697
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd227) + (0)))), (float)(f697));
  // PTX:1040 red.global.add.f32 [%rd228], %f699
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd228) + (0)))), (float)(f699));
  // PTX:1041 red.global.add.f32 [%rd229], %f700
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd229) + (0)))), (float)(f700));
  // PTX:1042 red.global.add.f32 [%rd230], %f701
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd230) + (0)))), (float)(f701));
  // PTX:1043 bra.uni $L__BB32_37
  goto L_BB32_37;
  // PTX:1045 $L__BB32_34:
L_BB32_34:;
  // PTX:1046 mul.f32 %f518, %f30, %f120
  asm("mul.f32 %0, %1, %2;" : "=f"(f518) : "f"(f30), "f"(f120));
  // PTX:1047 mul.f32 %f519, %f518, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f519) : "f"(f518), "f"(f23));
  // PTX:1048 mul.f32 %f520, %f518, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f520) : "f"(f518), "f"(f24));
  // PTX:1049 mul.f32 %f521, %f518, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f521) : "f"(f518), "f"(f25));
  // PTX:1050 mul.f32 %f522, %f519, %f31
  asm("mul.f32 %0, %1, %2;" : "=f"(f522) : "f"(f519), "f"(f31));
  // PTX:1051 mul.f32 %f523, %f520, %f31
  asm("mul.f32 %0, %1, %2;" : "=f"(f523) : "f"(f520), "f"(f31));
  // PTX:1052 mul.f32 %f524, %f521, %f31
  asm("mul.f32 %0, %1, %2;" : "=f"(f524) : "f"(f521), "f"(f31));
  // PTX:1053 mul.f32 %f525, %f519, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f525) : "f"(f519), "f"(f32));
  // PTX:1054 mul.f32 %f526, %f520, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f526) : "f"(f520), "f"(f32));
  // PTX:1055 mul.f32 %f527, %f521, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f527) : "f"(f521), "f"(f32));
  // PTX:1056 mul.f32 %f528, %f519, %f33
  asm("mul.f32 %0, %1, %2;" : "=f"(f528) : "f"(f519), "f"(f33));
  // PTX:1057 mul.f32 %f529, %f520, %f33
  asm("mul.f32 %0, %1, %2;" : "=f"(f529) : "f"(f520), "f"(f33));
  // PTX:1058 mul.f32 %f530, %f521, %f33
  asm("mul.f32 %0, %1, %2;" : "=f"(f530) : "f"(f521), "f"(f33));
  // PTX:1059 mul.f32 %f531, %f519, %f34
  asm("mul.f32 %0, %1, %2;" : "=f"(f531) : "f"(f519), "f"(f34));
  // PTX:1060 mul.f32 %f532, %f520, %f34
  asm("mul.f32 %0, %1, %2;" : "=f"(f532) : "f"(f520), "f"(f34));
  // PTX:1061 mul.f32 %f533, %f521, %f34
  asm("mul.f32 %0, %1, %2;" : "=f"(f533) : "f"(f521), "f"(f34));
  // PTX:1062 mul.lo.s64 %rd179, %rd25, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd179) : "l"(rd25));
  // PTX:1063 add.s64 %rd180, %rd2, %rd179
  asm("add.s64 %0, %1, %2;" : "=l"(rd180) : "l"(rd2), "l"(rd179));
  // PTX:1064 red.global.add.f32 [%rd180], %f522
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (0)))), (float)(f522));
  // PTX:1065 add.s64 %rd181, %rd180, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd181) : "l"(rd180));
  // PTX:1066 red.global.add.f32 [%rd181], %f523
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd181) + (0)))), (float)(f523));
  // PTX:1067 add.s64 %rd182, %rd180, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd182) : "l"(rd180));
  // PTX:1068 red.global.add.f32 [%rd182], %f524
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd182) + (0)))), (float)(f524));
  // PTX:1069 add.s64 %rd184, %rd2, %rd165
  asm("add.s64 %0, %1, %2;" : "=l"(rd184) : "l"(rd2), "l"(rd165));
  // PTX:1070 red.global.add.f32 [%rd184], %f525
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd184) + (0)))), (float)(f525));
  // PTX:1071 add.s64 %rd185, %rd184, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd185) : "l"(rd184));
  // PTX:1072 red.global.add.f32 [%rd185], %f526
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (0)))), (float)(f526));
  // PTX:1073 add.s64 %rd186, %rd184, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd186) : "l"(rd184));
  // PTX:1074 red.global.add.f32 [%rd186], %f527
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd186) + (0)))), (float)(f527));
  // PTX:1075 add.s64 %rd188, %rd2, %rd167
  asm("add.s64 %0, %1, %2;" : "=l"(rd188) : "l"(rd2), "l"(rd167));
  // PTX:1076 red.global.add.f32 [%rd188], %f528
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd188) + (0)))), (float)(f528));
  // PTX:1077 add.s64 %rd189, %rd188, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd189) : "l"(rd188));
  // PTX:1078 red.global.add.f32 [%rd189], %f529
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd189) + (0)))), (float)(f529));
  // PTX:1079 add.s64 %rd190, %rd188, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd190) : "l"(rd188));
  // PTX:1080 red.global.add.f32 [%rd190], %f530
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd190) + (0)))), (float)(f530));
  // PTX:1081 add.s64 %rd192, %rd2, %rd169
  asm("add.s64 %0, %1, %2;" : "=l"(rd192) : "l"(rd2), "l"(rd169));
  // PTX:1082 red.global.add.f32 [%rd192], %f531
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd192) + (0)))), (float)(f531));
  // PTX:1083 add.s64 %rd193, %rd192, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd193) : "l"(rd192));
  // PTX:1084 red.global.add.f32 [%rd193], %f532
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd193) + (0)))), (float)(f532));
  // PTX:1085 add.s64 %rd194, %rd192, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd194) : "l"(rd192));
  // PTX:1086 red.global.add.f32 [%rd194], %f533
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd194) + (0)))), (float)(f533));
  // PTX:1088 $L__BB32_37:
L_BB32_37:;
  // PTX:1089 ret
  return;
}
