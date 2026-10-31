// 机械还原自 PTX：synreal::kernel::add_body_point_line_gauss_newton_hessian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, unsigned long, bool, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 3ec9b1373698f717fd90c7cf8545fa3fb54a1784322e8cc2a61e1f436ced3b0a
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__add_body_point_line_gauss_newton_hessian(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, float param9, unsigned long long param10, unsigned char param11, unsigned long long param12, unsigned long long param13, unsigned long long param14, unsigned long long param15, unsigned long long param16, unsigned long long param17, unsigned long long param18, unsigned long long param19) {
  unsigned long long SP, SPL, rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135, rd136, rd137, rd138, rd139, rd140, rd141, rd142, rd143, rd144, rd145, rd146, rd147, rd148, rd149, rd150, rd151, rd152, rd153, rd154, rd155, rd156, rd157, rd158, rd159, rd160, rd161, rd162, rd163, rd164, rd165, rd166, rd167, rd168, rd169, rd170, rd171, rd172, rd173, rd174, rd175, rd176, rd177, rd178, rd179, rd180, rd181, rd182, rd183, rd184, rd185, rd186, rd187, rd188, rd189, rd190, rd191, rd192, rd193, rd194, rd195, rd196, rd197, rd198, rd199, rd200, rd201, rd202, rd203, rd204, rd205, rd206, rd207, rd208;
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38;
  unsigned short rs0, rs1;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440, f441, f442, f443, f444, f445, f446, f447, f448, f449, f450, f451, f452, f453, f454, f455, f456, f457, f458, f459, f460, f461, f462, f463, f464, f465, f466, f467, f468, f469, f470, f471, f472, f473, f474, f475, f476, f477, f478, f479, f480, f481, f482, f483, f484, f485, f486, f487, f488, f489, f490, f491, f492, f493, f494, f495, f496, f497, f498, f499, f500, f501, f502, f503, f504, f505, f506, f507, f508, f509, f510, f511, f512, f513, f514, f515, f516, f517, f518, f519, f520, f521, f522, f523, f524, f525, f526, f527, f528, f529, f530, f531, f532, f533, f534, f535, f536, f537, f538, f539, f540, f541, f542, f543, f544, f545, f546, f547, f548, f549, f550, f551, f552, f553, f554, f555, f556, f557, f558, f559, f560, f561, f562, f563, f564, f565, f566, f567, f568, f569, f570, f571, f572, f573, f574, f575, f576, f577, f578, f579, f580, f581, f582, f583, f584, f585, f586, f587, f588, f589, f590;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63;
  __align__(16) unsigned char __local_depot56[352];
  // PTX:40 mov.u64 %SPL, __local_depot56
  SPL = (unsigned long long)__cvta_generic_to_local(__local_depot56);
  // PTX:41 ld.param.s8 %rs1, [_ZN7synreal6kernel40add_body_point_line_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKffmbPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_11]
  rs1 = (*reinterpret_cast<volatile signed char*>(((uintptr_t)&param11 + (0))));
  // PTX:42 ld.param.u64 %rd61, [_ZN7synreal6kernel40add_body_point_line_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKffmbPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_0]
  rd61 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:43 ld.param.u64 %rd62, [_ZN7synreal6kernel40add_body_point_line_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKffmbPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_1]
  rd62 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:44 ld.param.u64 %rd49, [_ZN7synreal6kernel40add_body_point_line_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKffmbPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_2]
  rd49 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:45 ld.param.u64 %rd50, [_ZN7synreal6kernel40add_body_point_line_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKffmbPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_3]
  rd50 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:46 ld.param.u64 %rd51, [_ZN7synreal6kernel40add_body_point_line_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKffmbPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_4]
  rd51 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:47 ld.param.u64 %rd52, [_ZN7synreal6kernel40add_body_point_line_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKffmbPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_5]
  rd52 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:48 ld.param.u64 %rd53, [_ZN7synreal6kernel40add_body_point_line_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKffmbPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_6]
  rd53 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:49 ld.param.u64 %rd54, [_ZN7synreal6kernel40add_body_point_line_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKffmbPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_7]
  rd54 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:50 ld.param.u64 %rd55, [_ZN7synreal6kernel40add_body_point_line_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKffmbPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_8]
  rd55 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:51 ld.param.f32 %f235, [_ZN7synreal6kernel40add_body_point_line_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKffmbPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_9]
  f235 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param9 + (0))));
  // PTX:52 ld.param.u64 %rd56, [_ZN7synreal6kernel40add_body_point_line_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKffmbPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_10]
  rd56 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:53 ld.param.u64 %rd63, [_ZN7synreal6kernel40add_body_point_line_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKffmbPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_12]
  rd63 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:54 ld.param.u64 %rd64, [_ZN7synreal6kernel40add_body_point_line_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKffmbPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_13]
  rd64 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:55 ld.param.u64 %rd65, [_ZN7synreal6kernel40add_body_point_line_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKffmbPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_14]
  rd65 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:56 ld.param.u64 %rd57, [_ZN7synreal6kernel40add_body_point_line_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKffmbPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_15]
  rd57 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param15 + (0))));
  // PTX:57 ld.param.u64 %rd66, [_ZN7synreal6kernel40add_body_point_line_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKffmbPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_16]
  rd66 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param16 + (0))));
  // PTX:58 ld.param.u64 %rd58, [_ZN7synreal6kernel40add_body_point_line_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKffmbPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_17]
  rd58 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param17 + (0))));
  // PTX:59 ld.param.u64 %rd59, [_ZN7synreal6kernel40add_body_point_line_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKffmbPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_18]
  rd59 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param18 + (0))));
  // PTX:60 ld.param.u64 %rd60, [_ZN7synreal6kernel40add_body_point_line_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKffmbPNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_19]
  rd60 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param19 + (0))));
  // PTX:61 cvta.to.global.u64 %rd1, %rd65
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd65));
  // PTX:62 cvta.to.global.u64 %rd2, %rd63
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd63));
  // PTX:63 cvta.to.global.u64 %rd3, %rd64
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd64));
  // PTX:64 cvta.to.global.u64 %rd4, %rd61
  rd4 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd61));
  // PTX:65 cvta.to.global.u64 %rd5, %rd62
  rd5 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd62));
  // PTX:66 add.u64 %rd6, %SPL, 0
  asm("add.u64 %0, %1, 0;" : "=l"(rd6) : "l"(SPL));
  // PTX:67 add.u64 %rd7, %SPL, 32
  asm("add.u64 %0, %1, 32;" : "=l"(rd7) : "l"(SPL));
  // PTX:68 add.u64 %rd8, %SPL, 64
  asm("add.u64 %0, %1, 64;" : "=l"(rd8) : "l"(SPL));
  // PTX:69 mov.u32 %r20, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r20) : "r"(blockIdx.x));
  // PTX:70 mov.u32 %r21, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r21) : "r"(blockDim.x));
  // PTX:71 mul.wide.u32 %rd70, %r20, %r21
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd70) : "r"(r20), "r"(r21));
  // PTX:72 mov.u32 %r22, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r22) : "r"(threadIdx.x));
  // PTX:73 cvt.u64.u32 %rd71, %r22
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd71) : "r"(r22));
  // PTX:74 add.s64 %rd9, %rd70, %rd71
  asm("add.s64 %0, %1, %2;" : "=l"(rd9) : "l"(rd70), "l"(rd71));
  // PTX:75 setp.ge.u64 %p2, %rd9, %rd66
  p2 = (((unsigned long long)(rd9)) >= ((unsigned long long)(rd66)));
  // PTX:76 @%p2 bra $L__BB56_51
  if (p2) { goto L_BB56_51; }
  // PTX:78 or.b64 %rd72, %rd9, %rd58
  asm("or.b64 %0, %1, %2;" : "=l"(rd72) : "l"(rd9), "l"(rd58));
  // PTX:79 and.b64 %rd73, %rd72, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd73) : "l"(rd72));
  // PTX:80 setp.eq.s64 %p3, %rd73, 0
  p3 = (((long long)(rd73)) == ((long long)(0)));
  // PTX:81 @%p3 bra $L__BB56_3
  if (p3) { goto L_BB56_3; }
  // PTX:83 rem.u64 %rd201, %rd9, %rd58
  asm("rem.u64 %0, %1, %2;" : "=l"(rd201) : "l"(rd9), "l"(rd58));
  // PTX:84 bra.uni $L__BB56_4
  goto L_BB56_4;
  // PTX:86 $L__BB56_3:
L_BB56_3:;
  // PTX:87 cvt.u32.u64 %r23, %rd58
  asm("cvt.u32.u64 %0, %1;" : "=r"(r23) : "l"(rd58));
  // PTX:88 cvt.u32.u64 %r24, %rd9
  asm("cvt.u32.u64 %0, %1;" : "=r"(r24) : "l"(rd9));
  // PTX:89 rem.u32 %r25, %r24, %r23
  asm("rem.u32 %0, %1, %2;" : "=r"(r25) : "r"(r24), "r"(r23));
  // PTX:90 cvt.u64.u32 %rd201, %r25
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd201) : "r"(r25));
  // PTX:92 $L__BB56_4:
L_BB56_4:;
  // PTX:93 sub.s64 %rd13, %rd58, %rd56
  asm("sub.s64 %0, %1, %2;" : "=l"(rd13) : "l"(rd58), "l"(rd56));
  // PTX:94 setp.ge.u64 %p4, %rd201, %rd13
  p4 = (((unsigned long long)(rd201)) >= ((unsigned long long)(rd13)));
  // PTX:95 setp.eq.s16 %p5, %rs1, 0
  p5 = (((short)(rs1)) == ((short)(0)));
  // PTX:96 and.pred %p6, %p5, %p4
  p6 = ((p5) && (p4));
  // PTX:97 @%p6 bra $L__BB56_51
  if (p6) { goto L_BB56_51; }
  // PTX:99 selp.f32 %f236, %f235, 0f3F800000, %p4
  f236 = p4 ? f235 : as_f32(0x3F800000u);
  // PTX:100 cvta.to.global.u64 %rd74, %rd55
  rd74 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd55));
  // PTX:101 shl.b64 %rd75, %rd201, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd75) : "l"(rd201));
  // PTX:102 add.s64 %rd76, %rd74, %rd75
  asm("add.s64 %0, %1, %2;" : "=l"(rd76) : "l"(rd74), "l"(rd75));
  // PTX:103 ld.global.f32 %f237, [%rd76]
  f237 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (0)))));
  // PTX:104 mul.f32 %f1, %f236, %f237
  asm("mul.f32 %0, %1, %2;" : "=f"(f1) : "f"(f236), "f"(f237));
  // PTX:105 setp.leu.f32 %p8, %f1, 0f00000000
  p8 = ((isnan(((float)(f1))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f1)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:106 @%p8 bra $L__BB56_51
  if (p8) { goto L_BB56_51; }
  // PTX:108 @%p3 bra $L__BB56_8
  if (p3) { goto L_BB56_8; }
  // PTX:110 div.u64 %rd202, %rd9, %rd58
  asm("div.u64 %0, %1, %2;" : "=l"(rd202) : "l"(rd9), "l"(rd58));
  // PTX:111 bra.uni $L__BB56_9
  goto L_BB56_9;
  // PTX:113 $L__BB56_8:
L_BB56_8:;
  // PTX:114 cvt.u32.u64 %r26, %rd58
  asm("cvt.u32.u64 %0, %1;" : "=r"(r26) : "l"(rd58));
  // PTX:115 cvt.u32.u64 %r27, %rd9
  asm("cvt.u32.u64 %0, %1;" : "=r"(r27) : "l"(rd9));
  // PTX:116 div.u32 %r28, %r27, %r26
  asm("div.u32 %0, %1, %2;" : "=r"(r28) : "r"(r27), "r"(r26));
  // PTX:117 cvt.u64.u32 %rd202, %r28
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd202) : "r"(r28));
  // PTX:119 $L__BB56_9:
L_BB56_9:;
  // PTX:120 mul.lo.s64 %rd79, %rd202, %rd59
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd79) : "l"(rd202), "l"(rd59));
  // PTX:121 cvt.u32.u64 %r1, %rd79
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd79));
  // PTX:122 cvta.to.global.u64 %rd80, %rd49
  rd80 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd49));
  // PTX:123 shl.b64 %rd81, %rd201, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd81) : "l"(rd201));
  // PTX:124 add.s64 %rd82, %rd80, %rd81
  asm("add.s64 %0, %1, %2;" : "=l"(rd82) : "l"(rd80), "l"(rd81));
  // PTX:125 ld.global.s32 %rd17, [%rd82+4]
  rd17 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (4)))));
  // PTX:126 ld.global.u32 %r33, [%rd82]
  r33 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (0)))));
  // PTX:127 mul.wide.s32 %rd83, %r33, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd83) : "r"(r33));
  // PTX:128 add.s64 %rd84, %rd5, %rd83
  asm("add.s64 %0, %1, %2;" : "=l"(rd84) : "l"(rd5), "l"(rd83));
  // PTX:129 ld.global.u32 %r34, [%rd84]
  r34 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (0)))));
  // PTX:130 add.s32 %r2, %r34, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r2) : "r"(r34), "r"(r1));
  // PTX:131 ld.global.u32 %r35, [%rd84+4]
  r35 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (4)))));
  // PTX:132 add.s32 %r3, %r35, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r3) : "r"(r35), "r"(r1));
  // PTX:133 ld.global.u32 %r36, [%rd84+8]
  r36 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (8)))));
  // PTX:134 add.s32 %r4, %r36, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r4) : "r"(r36), "r"(r1));
  // PTX:135 ld.global.u32 %r37, [%rd84+12]
  r37 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (12)))));
  // PTX:136 add.s32 %r5, %r37, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r5) : "r"(r37), "r"(r1));
  // PTX:137 cvta.to.global.u64 %rd85, %rd50
  rd85 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd50));
  // PTX:138 shl.b64 %rd86, %rd201, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd86) : "l"(rd201));
  // PTX:139 add.s64 %rd87, %rd85, %rd86
  asm("add.s64 %0, %1, %2;" : "=l"(rd87) : "l"(rd85), "l"(rd86));
  // PTX:140 mul.wide.s32 %rd88, %r2, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd88) : "r"(r2));
  // PTX:141 add.s64 %rd89, %rd4, %rd88
  asm("add.s64 %0, %1, %2;" : "=l"(rd89) : "l"(rd4), "l"(rd88));
  // PTX:142 ld.global.f32 %f238, [%rd89]
  f238 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (0)))));
  // PTX:143 ld.global.f32 %f2, [%rd87]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (0)))));
  // PTX:144 ld.global.f32 %f239, [%rd89+4]
  f239 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (4)))));
  // PTX:145 ld.global.f32 %f240, [%rd89+8]
  f240 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (8)))));
  // PTX:146 mul.wide.s32 %rd90, %r3, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd90) : "r"(r3));
  // PTX:147 add.s64 %rd91, %rd4, %rd90
  asm("add.s64 %0, %1, %2;" : "=l"(rd91) : "l"(rd4), "l"(rd90));
  // PTX:148 ld.global.f32 %f241, [%rd91]
  f241 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (0)))));
  // PTX:149 ld.global.f32 %f3, [%rd87+4]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (4)))));
  // PTX:150 mul.f32 %f242, %f3, %f241
  asm("mul.f32 %0, %1, %2;" : "=f"(f242) : "f"(f3), "f"(f241));
  // PTX:151 ld.global.f32 %f243, [%rd91+4]
  f243 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (4)))));
  // PTX:152 mul.f32 %f244, %f3, %f243
  asm("mul.f32 %0, %1, %2;" : "=f"(f244) : "f"(f3), "f"(f243));
  // PTX:153 ld.global.f32 %f245, [%rd91+8]
  f245 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (8)))));
  // PTX:154 mul.f32 %f246, %f3, %f245
  asm("mul.f32 %0, %1, %2;" : "=f"(f246) : "f"(f3), "f"(f245));
  // PTX:155 fma.rn.f32 %f247, %f2, %f238, %f242
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f247) : "f"(f2), "f"(f238), "f"(f242));
  // PTX:156 fma.rn.f32 %f248, %f2, %f239, %f244
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f248) : "f"(f2), "f"(f239), "f"(f244));
  // PTX:157 fma.rn.f32 %f249, %f2, %f240, %f246
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f249) : "f"(f2), "f"(f240), "f"(f246));
  // PTX:158 mul.wide.s32 %rd92, %r4, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd92) : "r"(r4));
  // PTX:159 add.s64 %rd93, %rd4, %rd92
  asm("add.s64 %0, %1, %2;" : "=l"(rd93) : "l"(rd4), "l"(rd92));
  // PTX:160 ld.global.f32 %f250, [%rd93]
  f250 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (0)))));
  // PTX:161 ld.global.f32 %f4, [%rd87+8]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (8)))));
  // PTX:162 ld.global.f32 %f251, [%rd93+4]
  f251 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (4)))));
  // PTX:163 ld.global.f32 %f252, [%rd93+8]
  f252 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (8)))));
  // PTX:164 fma.rn.f32 %f253, %f4, %f250, %f247
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f253) : "f"(f4), "f"(f250), "f"(f247));
  // PTX:165 fma.rn.f32 %f254, %f4, %f251, %f248
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f254) : "f"(f4), "f"(f251), "f"(f248));
  // PTX:166 fma.rn.f32 %f255, %f4, %f252, %f249
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f255) : "f"(f4), "f"(f252), "f"(f249));
  // PTX:167 mul.wide.s32 %rd94, %r5, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd94) : "r"(r5));
  // PTX:168 add.s64 %rd95, %rd4, %rd94
  asm("add.s64 %0, %1, %2;" : "=l"(rd95) : "l"(rd4), "l"(rd94));
  // PTX:169 ld.global.f32 %f256, [%rd95]
  f256 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd95) + (0)))));
  // PTX:170 ld.global.f32 %f5, [%rd87+12]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (12)))));
  // PTX:171 ld.global.f32 %f257, [%rd95+4]
  f257 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd95) + (4)))));
  // PTX:172 ld.global.f32 %f258, [%rd95+8]
  f258 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd95) + (8)))));
  // PTX:173 fma.rn.f32 %f6, %f5, %f256, %f253
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f6) : "f"(f5), "f"(f256), "f"(f253));
  // PTX:174 fma.rn.f32 %f7, %f5, %f257, %f254
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f7) : "f"(f5), "f"(f257), "f"(f254));
  // PTX:175 fma.rn.f32 %f8, %f5, %f258, %f255
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f8) : "f"(f5), "f"(f258), "f"(f255));
  // PTX:176 cvta.to.global.u64 %rd96, %rd53
  rd96 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd53));
  // PTX:177 mul.lo.s64 %rd97, %rd201, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd97) : "l"(rd201));
  // PTX:178 add.s64 %rd98, %rd96, %rd97
  asm("add.s64 %0, %1, %2;" : "=l"(rd98) : "l"(rd96), "l"(rd97));
  // PTX:179 ld.global.f32 %f515, [%rd98]
  f515 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (0)))));
  // PTX:180 ld.global.f32 %f516, [%rd98+4]
  f516 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (4)))));
  // PTX:181 ld.global.f32 %f517, [%rd98+8]
  f517 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (8)))));
  // PTX:182 cvta.to.global.u64 %rd99, %rd54
  rd99 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd54));
  // PTX:183 add.s64 %rd100, %rd99, %rd97
  asm("add.s64 %0, %1, %2;" : "=l"(rd100) : "l"(rd99), "l"(rd97));
  // PTX:184 ld.global.f32 %f512, [%rd100]
  f512 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (0)))));
  // PTX:185 ld.global.f32 %f513, [%rd100+4]
  f513 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (4)))));
  // PTX:186 ld.global.f32 %f514, [%rd100+8]
  f514 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (8)))));
  // PTX:187 setp.lt.s64 %p10, %rd17, 0
  p10 = (((long long)(rd17)) < ((long long)(0)));
  // PTX:188 cvta.to.global.u64 %rd101, %rd51
  rd101 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd51));
  // PTX:189 add.s64 %rd18, %rd101, %rd86
  asm("add.s64 %0, %1, %2;" : "=l"(rd18) : "l"(rd101), "l"(rd86));
  // PTX:190 cvta.to.global.u64 %rd102, %rd52
  rd102 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd52));
  // PTX:191 add.s64 %rd19, %rd102, %rd86
  asm("add.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd102), "l"(rd86));
  // PTX:192 mov.u32 %r57, 0
  asm("mov.u32 %0, 0;" : "=r"(r57) : );
  // PTX:193 mov.u32 %r58, %r57
  asm("mov.u32 %0, %1;" : "=r"(r58) : "r"(r57));
  // PTX:194 mov.u32 %r59, %r57
  asm("mov.u32 %0, %1;" : "=r"(r59) : "r"(r57));
  // PTX:195 mov.u32 %r60, %r57
  asm("mov.u32 %0, %1;" : "=r"(r60) : "r"(r57));
  // PTX:196 @%p10 bra $L__BB56_11
  if (p10) { goto L_BB56_11; }
  // PTX:198 shl.b64 %rd103, %rd17, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd103) : "l"(rd17));
  // PTX:199 add.s64 %rd104, %rd5, %rd103
  asm("add.s64 %0, %1, %2;" : "=l"(rd104) : "l"(rd5), "l"(rd103));
  // PTX:200 ld.global.u32 %r38, [%rd104]
  r38 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd104) + (0)))));
  // PTX:201 add.s32 %r60, %r38, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r60) : "r"(r38), "r"(r1));
  // PTX:202 ld.global.u32 %r39, [%rd104+4]
  r39 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd104) + (4)))));
  // PTX:203 add.s32 %r59, %r39, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r59) : "r"(r39), "r"(r1));
  // PTX:204 ld.global.u32 %r40, [%rd104+8]
  r40 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd104) + (8)))));
  // PTX:205 add.s32 %r58, %r40, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r58) : "r"(r40), "r"(r1));
  // PTX:206 ld.global.u32 %r41, [%rd104+12]
  r41 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd104) + (12)))));
  // PTX:207 add.s32 %r57, %r41, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r57) : "r"(r41), "r"(r1));
  // PTX:208 mul.wide.s32 %rd105, %r60, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd105) : "r"(r60));
  // PTX:209 add.s64 %rd106, %rd4, %rd105
  asm("add.s64 %0, %1, %2;" : "=l"(rd106) : "l"(rd4), "l"(rd105));
  // PTX:210 ld.global.f32 %f259, [%rd106]
  f259 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (0)))));
  // PTX:211 ld.global.f32 %f260, [%rd18]
  f260 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (0)))));
  // PTX:212 ld.global.f32 %f261, [%rd106+4]
  f261 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (4)))));
  // PTX:213 ld.global.f32 %f262, [%rd106+8]
  f262 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (8)))));
  // PTX:214 mul.wide.s32 %rd107, %r59, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd107) : "r"(r59));
  // PTX:215 add.s64 %rd108, %rd4, %rd107
  asm("add.s64 %0, %1, %2;" : "=l"(rd108) : "l"(rd4), "l"(rd107));
  // PTX:216 ld.global.f32 %f263, [%rd108]
  f263 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd108) + (0)))));
  // PTX:217 ld.global.f32 %f264, [%rd18+4]
  f264 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (4)))));
  // PTX:218 mul.f32 %f265, %f264, %f263
  asm("mul.f32 %0, %1, %2;" : "=f"(f265) : "f"(f264), "f"(f263));
  // PTX:219 ld.global.f32 %f266, [%rd108+4]
  f266 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd108) + (4)))));
  // PTX:220 mul.f32 %f267, %f264, %f266
  asm("mul.f32 %0, %1, %2;" : "=f"(f267) : "f"(f264), "f"(f266));
  // PTX:221 ld.global.f32 %f268, [%rd108+8]
  f268 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd108) + (8)))));
  // PTX:222 mul.f32 %f269, %f264, %f268
  asm("mul.f32 %0, %1, %2;" : "=f"(f269) : "f"(f264), "f"(f268));
  // PTX:223 fma.rn.f32 %f270, %f260, %f259, %f265
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f270) : "f"(f260), "f"(f259), "f"(f265));
  // PTX:224 fma.rn.f32 %f271, %f260, %f261, %f267
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f271) : "f"(f260), "f"(f261), "f"(f267));
  // PTX:225 fma.rn.f32 %f272, %f260, %f262, %f269
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f272) : "f"(f260), "f"(f262), "f"(f269));
  // PTX:226 mul.wide.s32 %rd109, %r58, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd109) : "r"(r58));
  // PTX:227 add.s64 %rd110, %rd4, %rd109
  asm("add.s64 %0, %1, %2;" : "=l"(rd110) : "l"(rd4), "l"(rd109));
  // PTX:228 ld.global.f32 %f273, [%rd110]
  f273 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd110) + (0)))));
  // PTX:229 ld.global.f32 %f274, [%rd18+8]
  f274 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (8)))));
  // PTX:230 ld.global.f32 %f275, [%rd110+4]
  f275 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd110) + (4)))));
  // PTX:231 ld.global.f32 %f276, [%rd110+8]
  f276 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd110) + (8)))));
  // PTX:232 fma.rn.f32 %f277, %f274, %f273, %f270
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f277) : "f"(f274), "f"(f273), "f"(f270));
  // PTX:233 fma.rn.f32 %f278, %f274, %f275, %f271
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f278) : "f"(f274), "f"(f275), "f"(f271));
  // PTX:234 fma.rn.f32 %f279, %f274, %f276, %f272
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f279) : "f"(f274), "f"(f276), "f"(f272));
  // PTX:235 mul.wide.s32 %rd111, %r57, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd111) : "r"(r57));
  // PTX:236 add.s64 %rd112, %rd4, %rd111
  asm("add.s64 %0, %1, %2;" : "=l"(rd112) : "l"(rd4), "l"(rd111));
  // PTX:237 ld.global.f32 %f280, [%rd112]
  f280 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd112) + (0)))));
  // PTX:238 ld.global.f32 %f281, [%rd18+12]
  f281 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (12)))));
  // PTX:239 ld.global.f32 %f282, [%rd112+4]
  f282 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd112) + (4)))));
  // PTX:240 ld.global.f32 %f283, [%rd112+8]
  f283 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd112) + (8)))));
  // PTX:241 fma.rn.f32 %f515, %f281, %f280, %f277
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f515) : "f"(f281), "f"(f280), "f"(f277));
  // PTX:242 fma.rn.f32 %f516, %f281, %f282, %f278
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f516) : "f"(f281), "f"(f282), "f"(f278));
  // PTX:243 fma.rn.f32 %f517, %f281, %f283, %f279
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f517) : "f"(f281), "f"(f283), "f"(f279));
  // PTX:244 ld.global.f32 %f284, [%rd19]
  f284 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))));
  // PTX:245 ld.global.f32 %f285, [%rd19+4]
  f285 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (4)))));
  // PTX:246 mul.f32 %f286, %f285, %f263
  asm("mul.f32 %0, %1, %2;" : "=f"(f286) : "f"(f285), "f"(f263));
  // PTX:247 mul.f32 %f287, %f285, %f266
  asm("mul.f32 %0, %1, %2;" : "=f"(f287) : "f"(f285), "f"(f266));
  // PTX:248 mul.f32 %f288, %f285, %f268
  asm("mul.f32 %0, %1, %2;" : "=f"(f288) : "f"(f285), "f"(f268));
  // PTX:249 fma.rn.f32 %f289, %f284, %f259, %f286
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f289) : "f"(f284), "f"(f259), "f"(f286));
  // PTX:250 fma.rn.f32 %f290, %f284, %f261, %f287
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f290) : "f"(f284), "f"(f261), "f"(f287));
  // PTX:251 fma.rn.f32 %f291, %f284, %f262, %f288
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f291) : "f"(f284), "f"(f262), "f"(f288));
  // PTX:252 ld.global.f32 %f292, [%rd19+8]
  f292 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (8)))));
  // PTX:253 fma.rn.f32 %f293, %f292, %f273, %f289
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f293) : "f"(f292), "f"(f273), "f"(f289));
  // PTX:254 fma.rn.f32 %f294, %f292, %f275, %f290
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f294) : "f"(f292), "f"(f275), "f"(f290));
  // PTX:255 fma.rn.f32 %f295, %f292, %f276, %f291
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f295) : "f"(f292), "f"(f276), "f"(f291));
  // PTX:256 ld.global.f32 %f296, [%rd19+12]
  f296 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (12)))));
  // PTX:257 fma.rn.f32 %f512, %f296, %f280, %f293
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f512) : "f"(f296), "f"(f280), "f"(f293));
  // PTX:258 fma.rn.f32 %f513, %f296, %f282, %f294
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f513) : "f"(f296), "f"(f282), "f"(f294));
  // PTX:259 fma.rn.f32 %f514, %f296, %f283, %f295
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f514) : "f"(f296), "f"(f283), "f"(f295));
  // PTX:261 $L__BB56_11:
L_BB56_11:;
  // PTX:262 sub.f32 %f27, %f6, %f515
  asm("sub.f32 %0, %1, %2;" : "=f"(f27) : "f"(f6), "f"(f515));
  // PTX:263 sub.f32 %f28, %f7, %f516
  asm("sub.f32 %0, %1, %2;" : "=f"(f28) : "f"(f7), "f"(f516));
  // PTX:264 sub.f32 %f29, %f8, %f517
  asm("sub.f32 %0, %1, %2;" : "=f"(f29) : "f"(f8), "f"(f517));
  // PTX:265 sub.f32 %f30, %f512, %f515
  asm("sub.f32 %0, %1, %2;" : "=f"(f30) : "f"(f512), "f"(f515));
  // PTX:266 sub.f32 %f31, %f513, %f516
  asm("sub.f32 %0, %1, %2;" : "=f"(f31) : "f"(f513), "f"(f516));
  // PTX:267 mul.f32 %f298, %f31, %f31
  asm("mul.f32 %0, %1, %2;" : "=f"(f298) : "f"(f31), "f"(f31));
  // PTX:268 sub.f32 %f32, %f514, %f517
  asm("sub.f32 %0, %1, %2;" : "=f"(f32) : "f"(f514), "f"(f517));
  // PTX:269 fma.rn.f32 %f299, %f30, %f30, %f298
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f299) : "f"(f30), "f"(f30), "f"(f298));
  // PTX:270 fma.rn.f32 %f33, %f32, %f32, %f299
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f33) : "f"(f32), "f"(f32), "f"(f299));
  // PTX:271 setp.leu.f32 %p11, %f33, 0f2B8CBCCC
  p11 = ((isnan(((float)(f33))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) || (((float)(f33)) <= ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:272 mov.f32 %f518, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f518) : );
  // PTX:273 @%p11 bra $L__BB56_13
  if (p11) { goto L_BB56_13; }
  // PTX:275 mul.f32 %f300, %f28, %f31
  asm("mul.f32 %0, %1, %2;" : "=f"(f300) : "f"(f28), "f"(f31));
  // PTX:276 fma.rn.f32 %f301, %f27, %f30, %f300
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f301) : "f"(f27), "f"(f30), "f"(f300));
  // PTX:277 fma.rn.f32 %f302, %f29, %f32, %f301
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f302) : "f"(f29), "f"(f32), "f"(f301));
  // PTX:278 div.rn.f32 %f518, %f302, %f33
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f518) : "f"(f302), "f"(f33));
  // PTX:280 $L__BB56_13:
L_BB56_13:;
  // PTX:281 cvt.sat.f32.f32 %f36, %f518
  asm("cvt.sat.f32.f32 %0, %1;" : "=f"(f36) : "f"(f518));
  // PTX:282 ld.global.f32 %f37, [%rd18]
  f37 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (0)))));
  // PTX:283 ld.global.f32 %f38, [%rd18+4]
  f38 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (4)))));
  // PTX:284 ld.global.f32 %f39, [%rd18+8]
  f39 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (8)))));
  // PTX:285 ld.global.f32 %f40, [%rd18+12]
  f40 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (12)))));
  // PTX:286 ld.global.f32 %f41, [%rd19]
  f41 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))));
  // PTX:287 ld.global.f32 %f42, [%rd19+4]
  f42 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (4)))));
  // PTX:288 ld.global.f32 %f43, [%rd19+8]
  f43 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (8)))));
  // PTX:289 ld.global.f32 %f44, [%rd19+12]
  f44 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (12)))));
  // PTX:290 fma.rn.f32 %f45, %f36, 0f00000000, 0f00000000
  asm("fma.rn.f32 %0, %1, 0f00000000, 0f00000000;" : "=f"(f45) : "f"(f36));
  // PTX:291 setp.gt.f32 %p12, %f518, 0f00000000
  p12 = (!(isnan(((float)(f518))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f518)) > ((float)(as_f32(0x00000000u)))));
  // PTX:292 setp.gt.f32 %p13, %f33, 0f2B8CBCCC
  p13 = (!(isnan(((float)(f33))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) && (((float)(f33)) > ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:293 and.pred %p14, %p13, %p12
  p14 = ((p13) && (p12));
  // PTX:294 setp.lt.f32 %p15, %f518, 0f3F800000
  p15 = (!(isnan(((float)(f518))) || isnan(((float)(as_f32(0x3F800000u))))) && (((float)(f518)) < ((float)(as_f32(0x3F800000u)))));
  // PTX:295 and.pred %p1, %p15, %p14
  p1 = ((p15) && (p14));
  // PTX:296 add.f32 %f303, %f36, %f36
  asm("add.f32 %0, %1, %2;" : "=f"(f303) : "f"(f36), "f"(f36));
  // PTX:297 mul.f32 %f304, %f30, %f303
  asm("mul.f32 %0, %1, %2;" : "=f"(f304) : "f"(f30), "f"(f303));
  // PTX:298 mul.f32 %f305, %f31, %f303
  asm("mul.f32 %0, %1, %2;" : "=f"(f305) : "f"(f31), "f"(f303));
  // PTX:299 mul.f32 %f306, %f32, %f303
  asm("mul.f32 %0, %1, %2;" : "=f"(f306) : "f"(f32), "f"(f303));
  // PTX:300 sub.f32 %f46, %f27, %f304
  asm("sub.f32 %0, %1, %2;" : "=f"(f46) : "f"(f27), "f"(f304));
  // PTX:301 sub.f32 %f47, %f28, %f305
  asm("sub.f32 %0, %1, %2;" : "=f"(f47) : "f"(f28), "f"(f305));
  // PTX:302 sub.f32 %f48, %f29, %f306
  asm("sub.f32 %0, %1, %2;" : "=f"(f48) : "f"(f29), "f"(f306));
  // PTX:303 mul.f32 %f49, %f46, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f49) : "f"(f46));
  // PTX:304 mul.f32 %f50, %f47, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f50) : "f"(f47));
  // PTX:305 mul.f32 %f51, %f48, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f51) : "f"(f48));
  // PTX:306 st.local.u32 [%rd6], %r2
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd6) + (0))))) = (unsigned)(r2);
  // PTX:307 neg.f32 %f307, %f2
  asm("neg.f32 %0, %1;" : "=f"(f307) : "f"(f2));
  // PTX:308 st.local.f32 [%rd7], %f307
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd7) + (0))))) = (float)(f307);
  // PTX:309 sub.f32 %f519, %f45, %f2
  asm("sub.f32 %0, %1, %2;" : "=f"(f519) : "f"(f45), "f"(f2));
  // PTX:310 mul.f32 %f520, %f519, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f520) : "f"(f519));
  // PTX:311 not.pred %p16, %p1
  p16 = !(p1);
  // PTX:312 mov.f32 %f521, %f520
  asm("mov.f32 %0, %1;" : "=f"(f521) : "f"(f520));
  // PTX:313 mov.f32 %f522, %f520
  asm("mov.f32 %0, %1;" : "=f"(f522) : "f"(f520));
  // PTX:314 mov.f32 %f523, %f519
  asm("mov.f32 %0, %1;" : "=f"(f523) : "f"(f519));
  // PTX:315 mov.f32 %f524, %f520
  asm("mov.f32 %0, %1;" : "=f"(f524) : "f"(f520));
  // PTX:316 mov.f32 %f525, %f520
  asm("mov.f32 %0, %1;" : "=f"(f525) : "f"(f520));
  // PTX:317 mov.f32 %f526, %f520
  asm("mov.f32 %0, %1;" : "=f"(f526) : "f"(f520));
  // PTX:318 mov.f32 %f527, %f519
  asm("mov.f32 %0, %1;" : "=f"(f527) : "f"(f519));
  // PTX:319 @%p16 bra $L__BB56_15
  if (p16) { goto L_BB56_15; }
  // PTX:321 fma.rn.f32 %f308, %f30, %f2, %f49
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f308) : "f"(f30), "f"(f2), "f"(f49));
  // PTX:322 fma.rn.f32 %f309, %f31, %f2, %f50
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f309) : "f"(f31), "f"(f2), "f"(f50));
  // PTX:323 fma.rn.f32 %f310, %f32, %f2, %f51
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f310) : "f"(f32), "f"(f2), "f"(f51));
  // PTX:324 div.rn.f32 %f311, %f308, %f33
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f311) : "f"(f308), "f"(f33));
  // PTX:325 div.rn.f32 %f312, %f309, %f33
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f312) : "f"(f309), "f"(f33));
  // PTX:326 div.rn.f32 %f313, %f310, %f33
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f313) : "f"(f310), "f"(f33));
  // PTX:327 fma.rn.f32 %f54, %f30, %f311, %f519
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f54) : "f"(f30), "f"(f311), "f"(f519));
  // PTX:328 fma.rn.f32 %f55, %f31, %f311, %f520
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f55) : "f"(f31), "f"(f311), "f"(f520));
  // PTX:329 fma.rn.f32 %f521, %f32, %f311, %f520
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f521) : "f"(f32), "f"(f311), "f"(f520));
  // PTX:330 fma.rn.f32 %f522, %f30, %f312, %f520
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f522) : "f"(f30), "f"(f312), "f"(f520));
  // PTX:331 fma.rn.f32 %f523, %f31, %f312, %f519
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f523) : "f"(f31), "f"(f312), "f"(f519));
  // PTX:332 fma.rn.f32 %f524, %f32, %f312, %f520
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f524) : "f"(f32), "f"(f312), "f"(f520));
  // PTX:333 fma.rn.f32 %f525, %f30, %f313, %f520
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f525) : "f"(f30), "f"(f313), "f"(f520));
  // PTX:334 fma.rn.f32 %f526, %f31, %f313, %f520
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f526) : "f"(f31), "f"(f313), "f"(f520));
  // PTX:335 fma.rn.f32 %f527, %f32, %f313, %f519
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f527) : "f"(f32), "f"(f313), "f"(f519));
  // PTX:336 mov.f32 %f519, %f54
  asm("mov.f32 %0, %1;" : "=f"(f519) : "f"(f54));
  // PTX:337 mov.f32 %f520, %f55
  asm("mov.f32 %0, %1;" : "=f"(f520) : "f"(f55));
  // PTX:339 $L__BB56_15:
L_BB56_15:;
  // PTX:340 st.local.v4.f32 [%rd8], {%f519, %f520, %f521, %f522}
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (0))))) = (float)(f519); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (4))))) = (float)(f520); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (8))))) = (float)(f521); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (12))))) = (float)(f522);
  // PTX:341 st.local.v4.f32 [%rd8+16], {%f523, %f524, %f525, %f526}
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (16))))) = (float)(f523); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (20))))) = (float)(f524); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (24))))) = (float)(f525); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (28))))) = (float)(f526);
  // PTX:342 st.local.f32 [%rd8+32], %f527
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (32))))) = (float)(f527);
  // PTX:343 st.local.u32 [%rd6+4], %r3
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd6) + (4))))) = (unsigned)(r3);
  // PTX:344 neg.f32 %f314, %f3
  asm("neg.f32 %0, %1;" : "=f"(f314) : "f"(f3));
  // PTX:345 st.local.f32 [%rd7+4], %f314
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd7) + (4))))) = (float)(f314);
  // PTX:346 sub.f32 %f528, %f45, %f3
  asm("sub.f32 %0, %1, %2;" : "=f"(f528) : "f"(f45), "f"(f3));
  // PTX:347 mul.f32 %f529, %f528, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f529) : "f"(f528));
  // PTX:348 mov.f32 %f530, %f529
  asm("mov.f32 %0, %1;" : "=f"(f530) : "f"(f529));
  // PTX:349 mov.f32 %f531, %f529
  asm("mov.f32 %0, %1;" : "=f"(f531) : "f"(f529));
  // PTX:350 mov.f32 %f532, %f528
  asm("mov.f32 %0, %1;" : "=f"(f532) : "f"(f528));
  // PTX:351 mov.f32 %f533, %f529
  asm("mov.f32 %0, %1;" : "=f"(f533) : "f"(f529));
  // PTX:352 mov.f32 %f534, %f529
  asm("mov.f32 %0, %1;" : "=f"(f534) : "f"(f529));
  // PTX:353 mov.f32 %f535, %f529
  asm("mov.f32 %0, %1;" : "=f"(f535) : "f"(f529));
  // PTX:354 mov.f32 %f536, %f528
  asm("mov.f32 %0, %1;" : "=f"(f536) : "f"(f528));
  // PTX:355 @%p16 bra $L__BB56_17
  if (p16) { goto L_BB56_17; }
  // PTX:357 fma.rn.f32 %f315, %f30, %f3, %f49
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f315) : "f"(f30), "f"(f3), "f"(f49));
  // PTX:358 fma.rn.f32 %f316, %f31, %f3, %f50
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f316) : "f"(f31), "f"(f3), "f"(f50));
  // PTX:359 fma.rn.f32 %f317, %f32, %f3, %f51
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f317) : "f"(f32), "f"(f3), "f"(f51));
  // PTX:360 div.rn.f32 %f318, %f315, %f33
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f318) : "f"(f315), "f"(f33));
  // PTX:361 div.rn.f32 %f319, %f316, %f33
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f319) : "f"(f316), "f"(f33));
  // PTX:362 div.rn.f32 %f320, %f317, %f33
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f320) : "f"(f317), "f"(f33));
  // PTX:363 fma.rn.f32 %f74, %f30, %f318, %f528
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f74) : "f"(f30), "f"(f318), "f"(f528));
  // PTX:364 fma.rn.f32 %f75, %f31, %f318, %f529
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f75) : "f"(f31), "f"(f318), "f"(f529));
  // PTX:365 fma.rn.f32 %f530, %f32, %f318, %f529
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f530) : "f"(f32), "f"(f318), "f"(f529));
  // PTX:366 fma.rn.f32 %f531, %f30, %f319, %f529
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f531) : "f"(f30), "f"(f319), "f"(f529));
  // PTX:367 fma.rn.f32 %f532, %f31, %f319, %f528
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f532) : "f"(f31), "f"(f319), "f"(f528));
  // PTX:368 fma.rn.f32 %f533, %f32, %f319, %f529
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f533) : "f"(f32), "f"(f319), "f"(f529));
  // PTX:369 fma.rn.f32 %f534, %f30, %f320, %f529
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f534) : "f"(f30), "f"(f320), "f"(f529));
  // PTX:370 fma.rn.f32 %f535, %f31, %f320, %f529
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f535) : "f"(f31), "f"(f320), "f"(f529));
  // PTX:371 fma.rn.f32 %f536, %f32, %f320, %f528
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f536) : "f"(f32), "f"(f320), "f"(f528));
  // PTX:372 mov.f32 %f528, %f74
  asm("mov.f32 %0, %1;" : "=f"(f528) : "f"(f74));
  // PTX:373 mov.f32 %f529, %f75
  asm("mov.f32 %0, %1;" : "=f"(f529) : "f"(f75));
  // PTX:375 $L__BB56_17:
L_BB56_17:;
  // PTX:376 st.local.f32 [%rd8+36], %f528
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (36))))) = (float)(f528);
  // PTX:377 st.local.f32 [%rd8+40], %f529
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (40))))) = (float)(f529);
  // PTX:378 st.local.f32 [%rd8+44], %f530
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (44))))) = (float)(f530);
  // PTX:379 st.local.v4.f32 [%rd8+48], {%f531, %f532, %f533, %f534}
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (48))))) = (float)(f531); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (52))))) = (float)(f532); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (56))))) = (float)(f533); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (60))))) = (float)(f534);
  // PTX:380 st.local.v2.f32 [%rd8+64], {%f535, %f536}
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (64))))) = (float)(f535); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (68))))) = (float)(f536);
  // PTX:381 st.local.u32 [%rd6+8], %r4
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd6) + (8))))) = (unsigned)(r4);
  // PTX:382 neg.f32 %f321, %f4
  asm("neg.f32 %0, %1;" : "=f"(f321) : "f"(f4));
  // PTX:383 st.local.f32 [%rd7+8], %f321
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd7) + (8))))) = (float)(f321);
  // PTX:384 sub.f32 %f537, %f45, %f4
  asm("sub.f32 %0, %1, %2;" : "=f"(f537) : "f"(f45), "f"(f4));
  // PTX:385 mul.f32 %f538, %f537, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f538) : "f"(f537));
  // PTX:386 mov.f32 %f539, %f538
  asm("mov.f32 %0, %1;" : "=f"(f539) : "f"(f538));
  // PTX:387 mov.f32 %f540, %f538
  asm("mov.f32 %0, %1;" : "=f"(f540) : "f"(f538));
  // PTX:388 mov.f32 %f541, %f537
  asm("mov.f32 %0, %1;" : "=f"(f541) : "f"(f537));
  // PTX:389 mov.f32 %f542, %f538
  asm("mov.f32 %0, %1;" : "=f"(f542) : "f"(f538));
  // PTX:390 mov.f32 %f543, %f538
  asm("mov.f32 %0, %1;" : "=f"(f543) : "f"(f538));
  // PTX:391 mov.f32 %f544, %f538
  asm("mov.f32 %0, %1;" : "=f"(f544) : "f"(f538));
  // PTX:392 mov.f32 %f545, %f537
  asm("mov.f32 %0, %1;" : "=f"(f545) : "f"(f537));
  // PTX:393 @%p16 bra $L__BB56_19
  if (p16) { goto L_BB56_19; }
  // PTX:395 fma.rn.f32 %f322, %f30, %f4, %f49
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f322) : "f"(f30), "f"(f4), "f"(f49));
  // PTX:396 fma.rn.f32 %f323, %f31, %f4, %f50
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f323) : "f"(f31), "f"(f4), "f"(f50));
  // PTX:397 fma.rn.f32 %f324, %f32, %f4, %f51
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f324) : "f"(f32), "f"(f4), "f"(f51));
  // PTX:398 div.rn.f32 %f325, %f322, %f33
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f325) : "f"(f322), "f"(f33));
  // PTX:399 div.rn.f32 %f326, %f323, %f33
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f326) : "f"(f323), "f"(f33));
  // PTX:400 div.rn.f32 %f327, %f324, %f33
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f327) : "f"(f324), "f"(f33));
  // PTX:401 fma.rn.f32 %f94, %f30, %f325, %f537
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f94) : "f"(f30), "f"(f325), "f"(f537));
  // PTX:402 fma.rn.f32 %f95, %f31, %f325, %f538
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f95) : "f"(f31), "f"(f325), "f"(f538));
  // PTX:403 fma.rn.f32 %f539, %f32, %f325, %f538
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f539) : "f"(f32), "f"(f325), "f"(f538));
  // PTX:404 fma.rn.f32 %f540, %f30, %f326, %f538
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f540) : "f"(f30), "f"(f326), "f"(f538));
  // PTX:405 fma.rn.f32 %f541, %f31, %f326, %f537
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f541) : "f"(f31), "f"(f326), "f"(f537));
  // PTX:406 fma.rn.f32 %f542, %f32, %f326, %f538
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f542) : "f"(f32), "f"(f326), "f"(f538));
  // PTX:407 fma.rn.f32 %f543, %f30, %f327, %f538
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f543) : "f"(f30), "f"(f327), "f"(f538));
  // PTX:408 fma.rn.f32 %f544, %f31, %f327, %f538
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f544) : "f"(f31), "f"(f327), "f"(f538));
  // PTX:409 fma.rn.f32 %f545, %f32, %f327, %f537
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f545) : "f"(f32), "f"(f327), "f"(f537));
  // PTX:410 mov.f32 %f537, %f94
  asm("mov.f32 %0, %1;" : "=f"(f537) : "f"(f94));
  // PTX:411 mov.f32 %f538, %f95
  asm("mov.f32 %0, %1;" : "=f"(f538) : "f"(f95));
  // PTX:413 $L__BB56_19:
L_BB56_19:;
  // PTX:414 st.local.v2.f32 [%rd8+72], {%f537, %f538}
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (72))))) = (float)(f537); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (76))))) = (float)(f538);
  // PTX:415 st.local.v4.f32 [%rd8+80], {%f539, %f540, %f541, %f542}
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (80))))) = (float)(f539); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (84))))) = (float)(f540); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (88))))) = (float)(f541); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (92))))) = (float)(f542);
  // PTX:416 st.local.v2.f32 [%rd8+96], {%f543, %f544}
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (96))))) = (float)(f543); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (100))))) = (float)(f544);
  // PTX:417 st.local.f32 [%rd8+104], %f545
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (104))))) = (float)(f545);
  // PTX:418 st.local.u32 [%rd6+12], %r5
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd6) + (12))))) = (unsigned)(r5);
  // PTX:419 neg.f32 %f328, %f5
  asm("neg.f32 %0, %1;" : "=f"(f328) : "f"(f5));
  // PTX:420 st.local.f32 [%rd7+12], %f328
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd7) + (12))))) = (float)(f328);
  // PTX:421 sub.f32 %f546, %f45, %f5
  asm("sub.f32 %0, %1, %2;" : "=f"(f546) : "f"(f45), "f"(f5));
  // PTX:422 mul.f32 %f547, %f546, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f547) : "f"(f546));
  // PTX:423 mov.f32 %f548, %f547
  asm("mov.f32 %0, %1;" : "=f"(f548) : "f"(f547));
  // PTX:424 mov.f32 %f549, %f547
  asm("mov.f32 %0, %1;" : "=f"(f549) : "f"(f547));
  // PTX:425 mov.f32 %f550, %f546
  asm("mov.f32 %0, %1;" : "=f"(f550) : "f"(f546));
  // PTX:426 mov.f32 %f551, %f547
  asm("mov.f32 %0, %1;" : "=f"(f551) : "f"(f547));
  // PTX:427 mov.f32 %f552, %f547
  asm("mov.f32 %0, %1;" : "=f"(f552) : "f"(f547));
  // PTX:428 mov.f32 %f553, %f547
  asm("mov.f32 %0, %1;" : "=f"(f553) : "f"(f547));
  // PTX:429 mov.f32 %f554, %f546
  asm("mov.f32 %0, %1;" : "=f"(f554) : "f"(f546));
  // PTX:430 @%p16 bra $L__BB56_21
  if (p16) { goto L_BB56_21; }
  // PTX:432 fma.rn.f32 %f329, %f30, %f5, %f49
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f329) : "f"(f30), "f"(f5), "f"(f49));
  // PTX:433 fma.rn.f32 %f330, %f31, %f5, %f50
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f330) : "f"(f31), "f"(f5), "f"(f50));
  // PTX:434 fma.rn.f32 %f331, %f32, %f5, %f51
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f331) : "f"(f32), "f"(f5), "f"(f51));
  // PTX:435 div.rn.f32 %f332, %f329, %f33
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f332) : "f"(f329), "f"(f33));
  // PTX:436 div.rn.f32 %f333, %f330, %f33
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f333) : "f"(f330), "f"(f33));
  // PTX:437 div.rn.f32 %f334, %f331, %f33
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f334) : "f"(f331), "f"(f33));
  // PTX:438 fma.rn.f32 %f114, %f30, %f332, %f546
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f114) : "f"(f30), "f"(f332), "f"(f546));
  // PTX:439 fma.rn.f32 %f115, %f31, %f332, %f547
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f115) : "f"(f31), "f"(f332), "f"(f547));
  // PTX:440 fma.rn.f32 %f548, %f32, %f332, %f547
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f548) : "f"(f32), "f"(f332), "f"(f547));
  // PTX:441 fma.rn.f32 %f549, %f30, %f333, %f547
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f549) : "f"(f30), "f"(f333), "f"(f547));
  // PTX:442 fma.rn.f32 %f550, %f31, %f333, %f546
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f550) : "f"(f31), "f"(f333), "f"(f546));
  // PTX:443 fma.rn.f32 %f551, %f32, %f333, %f547
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f551) : "f"(f32), "f"(f333), "f"(f547));
  // PTX:444 fma.rn.f32 %f552, %f30, %f334, %f547
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f552) : "f"(f30), "f"(f334), "f"(f547));
  // PTX:445 fma.rn.f32 %f553, %f31, %f334, %f547
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f553) : "f"(f31), "f"(f334), "f"(f547));
  // PTX:446 fma.rn.f32 %f554, %f32, %f334, %f546
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f554) : "f"(f32), "f"(f334), "f"(f546));
  // PTX:447 mov.f32 %f546, %f114
  asm("mov.f32 %0, %1;" : "=f"(f546) : "f"(f114));
  // PTX:448 mov.f32 %f547, %f115
  asm("mov.f32 %0, %1;" : "=f"(f547) : "f"(f115));
  // PTX:450 $L__BB56_21:
L_BB56_21:;
  // PTX:451 cvt.u32.u64 %r43, %rd17
  asm("cvt.u32.u64 %0, %1;" : "=r"(r43) : "l"(rd17));
  // PTX:452 setp.lt.s32 %p20, %r43, 0
  p20 = (((int)(r43)) < ((int)(0)));
  // PTX:453 st.local.f32 [%rd8+108], %f546
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (108))))) = (float)(f546);
  // PTX:454 st.local.v4.f32 [%rd8+112], {%f547, %f548, %f549, %f550}
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (112))))) = (float)(f547); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (116))))) = (float)(f548); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (120))))) = (float)(f549); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (124))))) = (float)(f550);
  // PTX:455 st.local.v4.f32 [%rd8+128], {%f551, %f552, %f553, %f554}
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (128))))) = (float)(f551); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (132))))) = (float)(f552); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (136))))) = (float)(f553); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (140))))) = (float)(f554);
  // PTX:456 mov.u32 %r61, 4
  asm("mov.u32 %0, 4;" : "=r"(r61) : );
  // PTX:457 @%p20 bra $L__BB56_31
  if (p20) { goto L_BB56_31; }
  // PTX:459 st.local.u32 [%rd6+16], %r60
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd6) + (16))))) = (unsigned)(r60);
  // PTX:460 add.f32 %f335, %f37, %f41
  asm("add.f32 %0, %1, %2;" : "=f"(f335) : "f"(f37), "f"(f41));
  // PTX:461 mul.f32 %f336, %f335, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f336) : "f"(f335));
  // PTX:462 st.local.f32 [%rd7+16], %f336
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd7) + (16))))) = (float)(f336);
  // PTX:463 sub.f32 %f132, %f41, %f37
  asm("sub.f32 %0, %1, %2;" : "=f"(f132) : "f"(f41), "f"(f37));
  // PTX:464 fma.rn.f32 %f555, %f36, %f132, %f37
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f555) : "f"(f36), "f"(f132), "f"(f37));
  // PTX:465 mul.f32 %f556, %f555, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f556) : "f"(f555));
  // PTX:466 mov.f32 %f557, %f556
  asm("mov.f32 %0, %1;" : "=f"(f557) : "f"(f556));
  // PTX:467 mov.f32 %f558, %f556
  asm("mov.f32 %0, %1;" : "=f"(f558) : "f"(f556));
  // PTX:468 mov.f32 %f559, %f555
  asm("mov.f32 %0, %1;" : "=f"(f559) : "f"(f555));
  // PTX:469 mov.f32 %f560, %f556
  asm("mov.f32 %0, %1;" : "=f"(f560) : "f"(f556));
  // PTX:470 mov.f32 %f561, %f556
  asm("mov.f32 %0, %1;" : "=f"(f561) : "f"(f556));
  // PTX:471 mov.f32 %f562, %f556
  asm("mov.f32 %0, %1;" : "=f"(f562) : "f"(f556));
  // PTX:472 mov.f32 %f563, %f555
  asm("mov.f32 %0, %1;" : "=f"(f563) : "f"(f555));
  // PTX:473 @%p16 bra $L__BB56_24
  if (p16) { goto L_BB56_24; }
  // PTX:475 mov.f32 %f337, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f337) : );
  // PTX:476 sub.f32 %f338, %f337, %f37
  asm("sub.f32 %0, %1, %2;" : "=f"(f338) : "f"(f337), "f"(f37));
  // PTX:477 mul.f32 %f339, %f46, %f132
  asm("mul.f32 %0, %1, %2;" : "=f"(f339) : "f"(f46), "f"(f132));
  // PTX:478 fma.rn.f32 %f340, %f30, %f338, %f339
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f340) : "f"(f30), "f"(f338), "f"(f339));
  // PTX:479 mul.f32 %f341, %f47, %f132
  asm("mul.f32 %0, %1, %2;" : "=f"(f341) : "f"(f47), "f"(f132));
  // PTX:480 fma.rn.f32 %f342, %f31, %f338, %f341
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f342) : "f"(f31), "f"(f338), "f"(f341));
  // PTX:481 mul.f32 %f343, %f48, %f132
  asm("mul.f32 %0, %1, %2;" : "=f"(f343) : "f"(f48), "f"(f132));
  // PTX:482 fma.rn.f32 %f344, %f32, %f338, %f343
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f344) : "f"(f32), "f"(f338), "f"(f343));
  // PTX:483 div.rn.f32 %f345, %f340, %f33
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f345) : "f"(f340), "f"(f33));
  // PTX:484 div.rn.f32 %f346, %f342, %f33
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f346) : "f"(f342), "f"(f33));
  // PTX:485 div.rn.f32 %f347, %f344, %f33
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f347) : "f"(f344), "f"(f33));
  // PTX:486 fma.rn.f32 %f135, %f30, %f345, %f555
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f135) : "f"(f30), "f"(f345), "f"(f555));
  // PTX:487 fma.rn.f32 %f136, %f31, %f345, %f556
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f136) : "f"(f31), "f"(f345), "f"(f556));
  // PTX:488 fma.rn.f32 %f557, %f32, %f345, %f556
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f557) : "f"(f32), "f"(f345), "f"(f556));
  // PTX:489 fma.rn.f32 %f558, %f30, %f346, %f556
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f558) : "f"(f30), "f"(f346), "f"(f556));
  // PTX:490 fma.rn.f32 %f559, %f31, %f346, %f555
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f559) : "f"(f31), "f"(f346), "f"(f555));
  // PTX:491 fma.rn.f32 %f560, %f32, %f346, %f556
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f560) : "f"(f32), "f"(f346), "f"(f556));
  // PTX:492 fma.rn.f32 %f561, %f30, %f347, %f556
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f561) : "f"(f30), "f"(f347), "f"(f556));
  // PTX:493 fma.rn.f32 %f562, %f31, %f347, %f556
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f562) : "f"(f31), "f"(f347), "f"(f556));
  // PTX:494 fma.rn.f32 %f563, %f32, %f347, %f555
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f563) : "f"(f32), "f"(f347), "f"(f555));
  // PTX:495 mov.f32 %f555, %f135
  asm("mov.f32 %0, %1;" : "=f"(f555) : "f"(f135));
  // PTX:496 mov.f32 %f556, %f136
  asm("mov.f32 %0, %1;" : "=f"(f556) : "f"(f136));
  // PTX:498 $L__BB56_24:
L_BB56_24:;
  // PTX:499 st.local.v4.f32 [%rd8+144], {%f555, %f556, %f557, %f558}
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (144))))) = (float)(f555); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (148))))) = (float)(f556); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (152))))) = (float)(f557); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (156))))) = (float)(f558);
  // PTX:500 st.local.v4.f32 [%rd8+160], {%f559, %f560, %f561, %f562}
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (160))))) = (float)(f559); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (164))))) = (float)(f560); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (168))))) = (float)(f561); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (172))))) = (float)(f562);
  // PTX:501 st.local.f32 [%rd8+176], %f563
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (176))))) = (float)(f563);
  // PTX:502 st.local.u32 [%rd6+20], %r59
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd6) + (20))))) = (unsigned)(r59);
  // PTX:503 add.f32 %f348, %f38, %f42
  asm("add.f32 %0, %1, %2;" : "=f"(f348) : "f"(f38), "f"(f42));
  // PTX:504 mul.f32 %f349, %f348, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f349) : "f"(f348));
  // PTX:505 st.local.f32 [%rd7+20], %f349
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd7) + (20))))) = (float)(f349);
  // PTX:506 sub.f32 %f153, %f42, %f38
  asm("sub.f32 %0, %1, %2;" : "=f"(f153) : "f"(f42), "f"(f38));
  // PTX:507 fma.rn.f32 %f564, %f36, %f153, %f38
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f564) : "f"(f36), "f"(f153), "f"(f38));
  // PTX:508 mul.f32 %f565, %f564, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f565) : "f"(f564));
  // PTX:509 mov.f32 %f566, %f565
  asm("mov.f32 %0, %1;" : "=f"(f566) : "f"(f565));
  // PTX:510 mov.f32 %f567, %f565
  asm("mov.f32 %0, %1;" : "=f"(f567) : "f"(f565));
  // PTX:511 mov.f32 %f568, %f564
  asm("mov.f32 %0, %1;" : "=f"(f568) : "f"(f564));
  // PTX:512 mov.f32 %f569, %f565
  asm("mov.f32 %0, %1;" : "=f"(f569) : "f"(f565));
  // PTX:513 mov.f32 %f570, %f565
  asm("mov.f32 %0, %1;" : "=f"(f570) : "f"(f565));
  // PTX:514 mov.f32 %f571, %f565
  asm("mov.f32 %0, %1;" : "=f"(f571) : "f"(f565));
  // PTX:515 mov.f32 %f572, %f564
  asm("mov.f32 %0, %1;" : "=f"(f572) : "f"(f564));
  // PTX:516 @%p16 bra $L__BB56_26
  if (p16) { goto L_BB56_26; }
  // PTX:518 mov.f32 %f350, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f350) : );
  // PTX:519 sub.f32 %f351, %f350, %f38
  asm("sub.f32 %0, %1, %2;" : "=f"(f351) : "f"(f350), "f"(f38));
  // PTX:520 mul.f32 %f352, %f46, %f153
  asm("mul.f32 %0, %1, %2;" : "=f"(f352) : "f"(f46), "f"(f153));
  // PTX:521 fma.rn.f32 %f353, %f30, %f351, %f352
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f353) : "f"(f30), "f"(f351), "f"(f352));
  // PTX:522 mul.f32 %f354, %f47, %f153
  asm("mul.f32 %0, %1, %2;" : "=f"(f354) : "f"(f47), "f"(f153));
  // PTX:523 fma.rn.f32 %f355, %f31, %f351, %f354
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f355) : "f"(f31), "f"(f351), "f"(f354));
  // PTX:524 mul.f32 %f356, %f48, %f153
  asm("mul.f32 %0, %1, %2;" : "=f"(f356) : "f"(f48), "f"(f153));
  // PTX:525 fma.rn.f32 %f357, %f32, %f351, %f356
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f357) : "f"(f32), "f"(f351), "f"(f356));
  // PTX:526 div.rn.f32 %f358, %f353, %f33
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f358) : "f"(f353), "f"(f33));
  // PTX:527 div.rn.f32 %f359, %f355, %f33
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f359) : "f"(f355), "f"(f33));
  // PTX:528 div.rn.f32 %f360, %f357, %f33
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f360) : "f"(f357), "f"(f33));
  // PTX:529 fma.rn.f32 %f156, %f30, %f358, %f564
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f156) : "f"(f30), "f"(f358), "f"(f564));
  // PTX:530 fma.rn.f32 %f157, %f31, %f358, %f565
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f157) : "f"(f31), "f"(f358), "f"(f565));
  // PTX:531 fma.rn.f32 %f566, %f32, %f358, %f565
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f566) : "f"(f32), "f"(f358), "f"(f565));
  // PTX:532 fma.rn.f32 %f567, %f30, %f359, %f565
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f567) : "f"(f30), "f"(f359), "f"(f565));
  // PTX:533 fma.rn.f32 %f568, %f31, %f359, %f564
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f568) : "f"(f31), "f"(f359), "f"(f564));
  // PTX:534 fma.rn.f32 %f569, %f32, %f359, %f565
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f569) : "f"(f32), "f"(f359), "f"(f565));
  // PTX:535 fma.rn.f32 %f570, %f30, %f360, %f565
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f570) : "f"(f30), "f"(f360), "f"(f565));
  // PTX:536 fma.rn.f32 %f571, %f31, %f360, %f565
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f571) : "f"(f31), "f"(f360), "f"(f565));
  // PTX:537 fma.rn.f32 %f572, %f32, %f360, %f564
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f572) : "f"(f32), "f"(f360), "f"(f564));
  // PTX:538 mov.f32 %f564, %f156
  asm("mov.f32 %0, %1;" : "=f"(f564) : "f"(f156));
  // PTX:539 mov.f32 %f565, %f157
  asm("mov.f32 %0, %1;" : "=f"(f565) : "f"(f157));
  // PTX:541 $L__BB56_26:
L_BB56_26:;
  // PTX:542 st.local.f32 [%rd8+180], %f564
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (180))))) = (float)(f564);
  // PTX:543 st.local.f32 [%rd8+184], %f565
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (184))))) = (float)(f565);
  // PTX:544 st.local.f32 [%rd8+188], %f566
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (188))))) = (float)(f566);
  // PTX:545 st.local.v4.f32 [%rd8+192], {%f567, %f568, %f569, %f570}
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (192))))) = (float)(f567); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (196))))) = (float)(f568); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (200))))) = (float)(f569); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (204))))) = (float)(f570);
  // PTX:546 st.local.v2.f32 [%rd8+208], {%f571, %f572}
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (208))))) = (float)(f571); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (212))))) = (float)(f572);
  // PTX:547 st.local.u32 [%rd6+24], %r58
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd6) + (24))))) = (unsigned)(r58);
  // PTX:548 add.f32 %f361, %f39, %f43
  asm("add.f32 %0, %1, %2;" : "=f"(f361) : "f"(f39), "f"(f43));
  // PTX:549 mul.f32 %f362, %f361, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f362) : "f"(f361));
  // PTX:550 st.local.f32 [%rd7+24], %f362
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd7) + (24))))) = (float)(f362);
  // PTX:551 sub.f32 %f174, %f43, %f39
  asm("sub.f32 %0, %1, %2;" : "=f"(f174) : "f"(f43), "f"(f39));
  // PTX:552 fma.rn.f32 %f573, %f36, %f174, %f39
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f573) : "f"(f36), "f"(f174), "f"(f39));
  // PTX:553 mul.f32 %f574, %f573, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f574) : "f"(f573));
  // PTX:554 mov.f32 %f575, %f574
  asm("mov.f32 %0, %1;" : "=f"(f575) : "f"(f574));
  // PTX:555 mov.f32 %f576, %f574
  asm("mov.f32 %0, %1;" : "=f"(f576) : "f"(f574));
  // PTX:556 mov.f32 %f577, %f573
  asm("mov.f32 %0, %1;" : "=f"(f577) : "f"(f573));
  // PTX:557 mov.f32 %f578, %f574
  asm("mov.f32 %0, %1;" : "=f"(f578) : "f"(f574));
  // PTX:558 mov.f32 %f579, %f574
  asm("mov.f32 %0, %1;" : "=f"(f579) : "f"(f574));
  // PTX:559 mov.f32 %f580, %f574
  asm("mov.f32 %0, %1;" : "=f"(f580) : "f"(f574));
  // PTX:560 mov.f32 %f581, %f573
  asm("mov.f32 %0, %1;" : "=f"(f581) : "f"(f573));
  // PTX:561 @%p16 bra $L__BB56_28
  if (p16) { goto L_BB56_28; }
  // PTX:563 mov.f32 %f363, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f363) : );
  // PTX:564 sub.f32 %f364, %f363, %f39
  asm("sub.f32 %0, %1, %2;" : "=f"(f364) : "f"(f363), "f"(f39));
  // PTX:565 mul.f32 %f365, %f46, %f174
  asm("mul.f32 %0, %1, %2;" : "=f"(f365) : "f"(f46), "f"(f174));
  // PTX:566 fma.rn.f32 %f366, %f30, %f364, %f365
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f366) : "f"(f30), "f"(f364), "f"(f365));
  // PTX:567 mul.f32 %f367, %f47, %f174
  asm("mul.f32 %0, %1, %2;" : "=f"(f367) : "f"(f47), "f"(f174));
  // PTX:568 fma.rn.f32 %f368, %f31, %f364, %f367
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f368) : "f"(f31), "f"(f364), "f"(f367));
  // PTX:569 mul.f32 %f369, %f48, %f174
  asm("mul.f32 %0, %1, %2;" : "=f"(f369) : "f"(f48), "f"(f174));
  // PTX:570 fma.rn.f32 %f370, %f32, %f364, %f369
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f370) : "f"(f32), "f"(f364), "f"(f369));
  // PTX:571 div.rn.f32 %f371, %f366, %f33
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f371) : "f"(f366), "f"(f33));
  // PTX:572 div.rn.f32 %f372, %f368, %f33
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f372) : "f"(f368), "f"(f33));
  // PTX:573 div.rn.f32 %f373, %f370, %f33
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f373) : "f"(f370), "f"(f33));
  // PTX:574 fma.rn.f32 %f177, %f30, %f371, %f573
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f177) : "f"(f30), "f"(f371), "f"(f573));
  // PTX:575 fma.rn.f32 %f178, %f31, %f371, %f574
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f178) : "f"(f31), "f"(f371), "f"(f574));
  // PTX:576 fma.rn.f32 %f575, %f32, %f371, %f574
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f575) : "f"(f32), "f"(f371), "f"(f574));
  // PTX:577 fma.rn.f32 %f576, %f30, %f372, %f574
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f576) : "f"(f30), "f"(f372), "f"(f574));
  // PTX:578 fma.rn.f32 %f577, %f31, %f372, %f573
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f577) : "f"(f31), "f"(f372), "f"(f573));
  // PTX:579 fma.rn.f32 %f578, %f32, %f372, %f574
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f578) : "f"(f32), "f"(f372), "f"(f574));
  // PTX:580 fma.rn.f32 %f579, %f30, %f373, %f574
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f579) : "f"(f30), "f"(f373), "f"(f574));
  // PTX:581 fma.rn.f32 %f580, %f31, %f373, %f574
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f580) : "f"(f31), "f"(f373), "f"(f574));
  // PTX:582 fma.rn.f32 %f581, %f32, %f373, %f573
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f581) : "f"(f32), "f"(f373), "f"(f573));
  // PTX:583 mov.f32 %f573, %f177
  asm("mov.f32 %0, %1;" : "=f"(f573) : "f"(f177));
  // PTX:584 mov.f32 %f574, %f178
  asm("mov.f32 %0, %1;" : "=f"(f574) : "f"(f178));
  // PTX:586 $L__BB56_28:
L_BB56_28:;
  // PTX:587 st.local.v2.f32 [%rd8+216], {%f573, %f574}
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (216))))) = (float)(f573); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (220))))) = (float)(f574);
  // PTX:588 st.local.v4.f32 [%rd8+224], {%f575, %f576, %f577, %f578}
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (224))))) = (float)(f575); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (228))))) = (float)(f576); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (232))))) = (float)(f577); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (236))))) = (float)(f578);
  // PTX:589 st.local.v2.f32 [%rd8+240], {%f579, %f580}
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (240))))) = (float)(f579); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (244))))) = (float)(f580);
  // PTX:590 st.local.f32 [%rd8+248], %f581
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (248))))) = (float)(f581);
  // PTX:591 st.local.u32 [%rd6+28], %r57
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd6) + (28))))) = (unsigned)(r57);
  // PTX:592 add.f32 %f374, %f40, %f44
  asm("add.f32 %0, %1, %2;" : "=f"(f374) : "f"(f40), "f"(f44));
  // PTX:593 mul.f32 %f375, %f374, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f375) : "f"(f374));
  // PTX:594 st.local.f32 [%rd7+28], %f375
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd7) + (28))))) = (float)(f375);
  // PTX:595 sub.f32 %f195, %f44, %f40
  asm("sub.f32 %0, %1, %2;" : "=f"(f195) : "f"(f44), "f"(f40));
  // PTX:596 fma.rn.f32 %f582, %f36, %f195, %f40
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f582) : "f"(f36), "f"(f195), "f"(f40));
  // PTX:597 mul.f32 %f583, %f582, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f583) : "f"(f582));
  // PTX:598 mov.f32 %f584, %f583
  asm("mov.f32 %0, %1;" : "=f"(f584) : "f"(f583));
  // PTX:599 mov.f32 %f585, %f583
  asm("mov.f32 %0, %1;" : "=f"(f585) : "f"(f583));
  // PTX:600 mov.f32 %f586, %f582
  asm("mov.f32 %0, %1;" : "=f"(f586) : "f"(f582));
  // PTX:601 mov.f32 %f587, %f583
  asm("mov.f32 %0, %1;" : "=f"(f587) : "f"(f583));
  // PTX:602 mov.f32 %f588, %f583
  asm("mov.f32 %0, %1;" : "=f"(f588) : "f"(f583));
  // PTX:603 mov.f32 %f589, %f583
  asm("mov.f32 %0, %1;" : "=f"(f589) : "f"(f583));
  // PTX:604 mov.f32 %f590, %f582
  asm("mov.f32 %0, %1;" : "=f"(f590) : "f"(f582));
  // PTX:605 @%p16 bra $L__BB56_30
  if (p16) { goto L_BB56_30; }
  // PTX:607 mov.f32 %f376, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f376) : );
  // PTX:608 sub.f32 %f377, %f376, %f40
  asm("sub.f32 %0, %1, %2;" : "=f"(f377) : "f"(f376), "f"(f40));
  // PTX:609 mul.f32 %f378, %f46, %f195
  asm("mul.f32 %0, %1, %2;" : "=f"(f378) : "f"(f46), "f"(f195));
  // PTX:610 fma.rn.f32 %f379, %f30, %f377, %f378
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f379) : "f"(f30), "f"(f377), "f"(f378));
  // PTX:611 mul.f32 %f380, %f47, %f195
  asm("mul.f32 %0, %1, %2;" : "=f"(f380) : "f"(f47), "f"(f195));
  // PTX:612 fma.rn.f32 %f381, %f31, %f377, %f380
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f381) : "f"(f31), "f"(f377), "f"(f380));
  // PTX:613 mul.f32 %f382, %f48, %f195
  asm("mul.f32 %0, %1, %2;" : "=f"(f382) : "f"(f48), "f"(f195));
  // PTX:614 fma.rn.f32 %f383, %f32, %f377, %f382
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f383) : "f"(f32), "f"(f377), "f"(f382));
  // PTX:615 div.rn.f32 %f384, %f379, %f33
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f384) : "f"(f379), "f"(f33));
  // PTX:616 div.rn.f32 %f385, %f381, %f33
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f385) : "f"(f381), "f"(f33));
  // PTX:617 div.rn.f32 %f386, %f383, %f33
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f386) : "f"(f383), "f"(f33));
  // PTX:618 fma.rn.f32 %f198, %f30, %f384, %f582
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f198) : "f"(f30), "f"(f384), "f"(f582));
  // PTX:619 fma.rn.f32 %f199, %f31, %f384, %f583
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f199) : "f"(f31), "f"(f384), "f"(f583));
  // PTX:620 fma.rn.f32 %f584, %f32, %f384, %f583
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f584) : "f"(f32), "f"(f384), "f"(f583));
  // PTX:621 fma.rn.f32 %f585, %f30, %f385, %f583
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f585) : "f"(f30), "f"(f385), "f"(f583));
  // PTX:622 fma.rn.f32 %f586, %f31, %f385, %f582
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f586) : "f"(f31), "f"(f385), "f"(f582));
  // PTX:623 fma.rn.f32 %f587, %f32, %f385, %f583
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f587) : "f"(f32), "f"(f385), "f"(f583));
  // PTX:624 fma.rn.f32 %f588, %f30, %f386, %f583
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f588) : "f"(f30), "f"(f386), "f"(f583));
  // PTX:625 fma.rn.f32 %f589, %f31, %f386, %f583
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f589) : "f"(f31), "f"(f386), "f"(f583));
  // PTX:626 fma.rn.f32 %f590, %f32, %f386, %f582
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f590) : "f"(f32), "f"(f386), "f"(f582));
  // PTX:627 mov.f32 %f582, %f198
  asm("mov.f32 %0, %1;" : "=f"(f582) : "f"(f198));
  // PTX:628 mov.f32 %f583, %f199
  asm("mov.f32 %0, %1;" : "=f"(f583) : "f"(f199));
  // PTX:630 $L__BB56_30:
L_BB56_30:;
  // PTX:631 st.local.f32 [%rd8+252], %f582
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (252))))) = (float)(f582);
  // PTX:632 st.local.v4.f32 [%rd8+256], {%f583, %f584, %f585, %f586}
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (256))))) = (float)(f583); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (260))))) = (float)(f584); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (264))))) = (float)(f585); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (268))))) = (float)(f586);
  // PTX:633 st.local.v4.f32 [%rd8+272], {%f587, %f588, %f589, %f590}
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (272))))) = (float)(f587); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (276))))) = (float)(f588); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (280))))) = (float)(f589); (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd8) + (284))))) = (float)(f590);
  // PTX:634 mov.u32 %r61, 8
  asm("mov.u32 %0, 8;" : "=r"(r61) : );
  // PTX:636 $L__BB56_31:
L_BB56_31:;
  // PTX:637 mov.u32 %r62, 0
  asm("mov.u32 %0, 0;" : "=r"(r62) : );
  // PTX:638 bra.uni $L__BB56_32
  goto L_BB56_32;
  // PTX:640 $L__BB56_33:
L_BB56_33:;
  // PTX:641 mov.u32 %r63, %r62
  asm("mov.u32 %0, %1;" : "=r"(r63) : "r"(r62));
  // PTX:643 $L__BB56_34:
L_BB56_34:;
  // PTX:644 mul.wide.s32 %rd120, %r63, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd120) : "r"(r63));
  // PTX:645 add.s64 %rd121, %rd8, %rd120
  asm("add.s64 %0, %1, %2;" : "=l"(rd121) : "l"(rd8), "l"(rd120));
  // PTX:646 ld.local.f32 %f428, [%rd121]
  f428 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd121) + (0)))));
  // PTX:647 ld.local.f32 %f429, [%rd121+4]
  f429 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd121) + (4)))));
  // PTX:648 mul.f32 %f430, %f217, %f429
  asm("mul.f32 %0, %1, %2;" : "=f"(f430) : "f"(f217), "f"(f429));
  // PTX:649 ld.local.f32 %f431, [%rd121+8]
  f431 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd121) + (8)))));
  // PTX:650 fma.rn.f32 %f432, %f216, %f428, %f430
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f432) : "f"(f216), "f"(f428), "f"(f430));
  // PTX:651 fma.rn.f32 %f433, %f218, %f431, %f432
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f433) : "f"(f218), "f"(f431), "f"(f432));
  // PTX:652 mul.f32 %f434, %f220, %f429
  asm("mul.f32 %0, %1, %2;" : "=f"(f434) : "f"(f220), "f"(f429));
  // PTX:653 fma.rn.f32 %f435, %f219, %f428, %f434
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f435) : "f"(f219), "f"(f428), "f"(f434));
  // PTX:654 fma.rn.f32 %f436, %f221, %f431, %f435
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f436) : "f"(f221), "f"(f431), "f"(f435));
  // PTX:655 mul.f32 %f437, %f223, %f429
  asm("mul.f32 %0, %1, %2;" : "=f"(f437) : "f"(f223), "f"(f429));
  // PTX:656 fma.rn.f32 %f438, %f222, %f428, %f437
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f438) : "f"(f222), "f"(f428), "f"(f437));
  // PTX:657 fma.rn.f32 %f439, %f224, %f431, %f438
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f439) : "f"(f224), "f"(f431), "f"(f438));
  // PTX:658 ld.local.f32 %f440, [%rd121+12]
  f440 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd121) + (12)))));
  // PTX:659 ld.local.f32 %f441, [%rd121+16]
  f441 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd121) + (16)))));
  // PTX:660 mul.f32 %f442, %f217, %f441
  asm("mul.f32 %0, %1, %2;" : "=f"(f442) : "f"(f217), "f"(f441));
  // PTX:661 ld.local.f32 %f443, [%rd121+20]
  f443 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd121) + (20)))));
  // PTX:662 fma.rn.f32 %f444, %f216, %f440, %f442
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f444) : "f"(f216), "f"(f440), "f"(f442));
  // PTX:663 fma.rn.f32 %f445, %f218, %f443, %f444
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f445) : "f"(f218), "f"(f443), "f"(f444));
  // PTX:664 mul.f32 %f446, %f220, %f441
  asm("mul.f32 %0, %1, %2;" : "=f"(f446) : "f"(f220), "f"(f441));
  // PTX:665 fma.rn.f32 %f447, %f219, %f440, %f446
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f447) : "f"(f219), "f"(f440), "f"(f446));
  // PTX:666 fma.rn.f32 %f448, %f221, %f443, %f447
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f448) : "f"(f221), "f"(f443), "f"(f447));
  // PTX:667 mul.f32 %f449, %f223, %f441
  asm("mul.f32 %0, %1, %2;" : "=f"(f449) : "f"(f223), "f"(f441));
  // PTX:668 fma.rn.f32 %f450, %f222, %f440, %f449
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f450) : "f"(f222), "f"(f440), "f"(f449));
  // PTX:669 fma.rn.f32 %f451, %f224, %f443, %f450
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f451) : "f"(f224), "f"(f443), "f"(f450));
  // PTX:670 ld.local.f32 %f452, [%rd121+24]
  f452 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd121) + (24)))));
  // PTX:671 ld.local.f32 %f453, [%rd121+28]
  f453 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd121) + (28)))));
  // PTX:672 mul.f32 %f454, %f217, %f453
  asm("mul.f32 %0, %1, %2;" : "=f"(f454) : "f"(f217), "f"(f453));
  // PTX:673 ld.local.f32 %f455, [%rd121+32]
  f455 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd121) + (32)))));
  // PTX:674 fma.rn.f32 %f456, %f216, %f452, %f454
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f456) : "f"(f216), "f"(f452), "f"(f454));
  // PTX:675 fma.rn.f32 %f457, %f218, %f455, %f456
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f457) : "f"(f218), "f"(f455), "f"(f456));
  // PTX:676 mul.f32 %f458, %f220, %f453
  asm("mul.f32 %0, %1, %2;" : "=f"(f458) : "f"(f220), "f"(f453));
  // PTX:677 fma.rn.f32 %f459, %f219, %f452, %f458
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f459) : "f"(f219), "f"(f452), "f"(f458));
  // PTX:678 fma.rn.f32 %f460, %f221, %f455, %f459
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f460) : "f"(f221), "f"(f455), "f"(f459));
  // PTX:679 mul.f32 %f461, %f223, %f453
  asm("mul.f32 %0, %1, %2;" : "=f"(f461) : "f"(f223), "f"(f453));
  // PTX:680 fma.rn.f32 %f462, %f222, %f452, %f461
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f462) : "f"(f222), "f"(f452), "f"(f461));
  // PTX:681 fma.rn.f32 %f463, %f224, %f455, %f462
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f463) : "f"(f224), "f"(f455), "f"(f462));
  // PTX:682 mul.wide.s32 %rd122, %r63, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd122) : "r"(r63));
  // PTX:683 add.s64 %rd123, %rd7, %rd122
  asm("add.s64 %0, %1, %2;" : "=l"(rd123) : "l"(rd7), "l"(rd122));
  // PTX:684 ld.local.f32 %f464, [%rd123]
  f464 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd123) + (0)))));
  // PTX:685 mul.f32 %f465, %f225, %f464
  asm("mul.f32 %0, %1, %2;" : "=f"(f465) : "f"(f225), "f"(f464));
  // PTX:686 mul.f32 %f466, %f465, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f466) : "f"(f465));
  // PTX:687 sub.f32 %f467, %f433, %f465
  asm("sub.f32 %0, %1, %2;" : "=f"(f467) : "f"(f433), "f"(f465));
  // PTX:688 sub.f32 %f468, %f436, %f466
  asm("sub.f32 %0, %1, %2;" : "=f"(f468) : "f"(f436), "f"(f466));
  // PTX:689 sub.f32 %f469, %f439, %f466
  asm("sub.f32 %0, %1, %2;" : "=f"(f469) : "f"(f439), "f"(f466));
  // PTX:690 sub.f32 %f470, %f445, %f466
  asm("sub.f32 %0, %1, %2;" : "=f"(f470) : "f"(f445), "f"(f466));
  // PTX:691 sub.f32 %f471, %f448, %f465
  asm("sub.f32 %0, %1, %2;" : "=f"(f471) : "f"(f448), "f"(f465));
  // PTX:692 sub.f32 %f472, %f451, %f466
  asm("sub.f32 %0, %1, %2;" : "=f"(f472) : "f"(f451), "f"(f466));
  // PTX:693 sub.f32 %f473, %f457, %f466
  asm("sub.f32 %0, %1, %2;" : "=f"(f473) : "f"(f457), "f"(f466));
  // PTX:694 sub.f32 %f474, %f460, %f466
  asm("sub.f32 %0, %1, %2;" : "=f"(f474) : "f"(f460), "f"(f466));
  // PTX:695 sub.f32 %f475, %f463, %f465
  asm("sub.f32 %0, %1, %2;" : "=f"(f475) : "f"(f463), "f"(f465));
  // PTX:696 mul.f32 %f226, %f1, %f467
  asm("mul.f32 %0, %1, %2;" : "=f"(f226) : "f"(f1), "f"(f467));
  // PTX:697 mul.f32 %f227, %f1, %f468
  asm("mul.f32 %0, %1, %2;" : "=f"(f227) : "f"(f1), "f"(f468));
  // PTX:698 mul.f32 %f228, %f1, %f469
  asm("mul.f32 %0, %1, %2;" : "=f"(f228) : "f"(f1), "f"(f469));
  // PTX:699 mul.f32 %f229, %f1, %f470
  asm("mul.f32 %0, %1, %2;" : "=f"(f229) : "f"(f1), "f"(f470));
  // PTX:700 mul.f32 %f230, %f1, %f471
  asm("mul.f32 %0, %1, %2;" : "=f"(f230) : "f"(f1), "f"(f471));
  // PTX:701 mul.f32 %f231, %f1, %f472
  asm("mul.f32 %0, %1, %2;" : "=f"(f231) : "f"(f1), "f"(f472));
  // PTX:702 mul.f32 %f232, %f1, %f473
  asm("mul.f32 %0, %1, %2;" : "=f"(f232) : "f"(f1), "f"(f473));
  // PTX:703 mul.f32 %f233, %f1, %f474
  asm("mul.f32 %0, %1, %2;" : "=f"(f233) : "f"(f1), "f"(f474));
  // PTX:704 mul.f32 %f234, %f1, %f475
  asm("mul.f32 %0, %1, %2;" : "=f"(f234) : "f"(f1), "f"(f475));
  // PTX:705 add.s64 %rd124, %rd6, %rd122
  asm("add.s64 %0, %1, %2;" : "=l"(rd124) : "l"(rd6), "l"(rd122));
  // PTX:706 ld.local.u32 %r47, [%rd124]
  r47 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd124) + (0)))));
  // PTX:707 cvt.s64.s32 %rd34, %r47
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd34) : "r"(r47));
  // PTX:708 cvt.u32.u64 %r18, %rd23
  asm("cvt.u32.u64 %0, %1;" : "=r"(r18) : "l"(rd23));
  // PTX:709 setp.eq.s32 %p26, %r18, %r47
  p26 = (((int)(r18)) == ((int)(r47)));
  // PTX:710 @%p26 bra $L__BB56_41
  if (p26) { goto L_BB56_41; }
  // PTX:711 bra.uni $L__BB56_35
  goto L_BB56_35;
  // PTX:713 $L__BB56_41:
L_BB56_41:;
  // PTX:714 mul.wide.s32 %rd200, %r46, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd200) : "r"(r46));
  // PTX:715 add.s64 %rd199, %rd2, %rd200
  asm("add.s64 %0, %1, %2;" : "=l"(rd199) : "l"(rd2), "l"(rd200));
  // PTX:716 add.s64 %rd198, %rd199, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd198) : "l"(rd199));
  // PTX:717 add.s64 %rd197, %rd199, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd197) : "l"(rd199));
  // PTX:718 add.s64 %rd196, %rd199, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd196) : "l"(rd199));
  // PTX:719 mul.wide.s32 %rd195, %r46, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd195) : "r"(r46));
  // PTX:720 add.s64 %rd194, %rd2, %rd195
  asm("add.s64 %0, %1, %2;" : "=l"(rd194) : "l"(rd2), "l"(rd195));
  // PTX:721 add.s64 %rd193, %rd194, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd193) : "l"(rd194));
  // PTX:722 add.s64 %rd192, %rd194, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd192) : "l"(rd194));
  // PTX:723 add.s64 %rd191, %rd194, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd191) : "l"(rd194));
  // PTX:724 add.s64 %rd190, %rd194, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd190) : "l"(rd194));
  // PTX:725 red.global.add.f32 [%rd194], %f226
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd194) + (0)))), (float)(f226));
  // PTX:726 red.global.add.f32 [%rd190], %f227
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd190) + (0)))), (float)(f227));
  // PTX:727 red.global.add.f32 [%rd191], %f228
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd191) + (0)))), (float)(f228));
  // PTX:728 red.global.add.f32 [%rd192], %f229
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd192) + (0)))), (float)(f229));
  // PTX:729 red.global.add.f32 [%rd193], %f230
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd193) + (0)))), (float)(f230));
  // PTX:730 red.global.add.f32 [%rd196], %f231
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd196) + (0)))), (float)(f231));
  // PTX:731 red.global.add.f32 [%rd197], %f232
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd197) + (0)))), (float)(f232));
  // PTX:732 red.global.add.f32 [%rd198], %f233
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd198) + (0)))), (float)(f233));
  // PTX:733 red.global.add.f32 [%rd32], %f234
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (0)))), (float)(f234));
  // PTX:734 bra.uni $L__BB56_42
  goto L_BB56_42;
  // PTX:736 $L__BB56_35:
L_BB56_35:;
  // PTX:737 cvt.s64.s32 %rd189, %r46
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd189) : "r"(r46));
  // PTX:738 shl.b64 %rd188, %rd189, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd188) : "l"(rd189));
  // PTX:739 add.s64 %rd187, %rd3, %rd188
  asm("add.s64 %0, %1, %2;" : "=l"(rd187) : "l"(rd3), "l"(rd188));
  // PTX:740 ld.global.s32 %rd126, [%rd187]
  rd126 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd187) + (0)))));
  // PTX:741 mov.u64 %rd205, 0
  asm("mov.u64 %0, 0;" : "=l"(rd205) : );
  // PTX:742 min.u64 %rd35, %rd126, %rd57
  asm("min.u64 %0, %1, %2;" : "=l"(rd35) : "l"(rd126), "l"(rd57));
  // PTX:743 setp.eq.s64 %p27, %rd35, 0
  p27 = (((long long)(rd35)) == ((long long)(0)));
  // PTX:744 @%p27 bra $L__BB56_38
  if (p27) { goto L_BB56_38; }
  // PTX:746 mov.u64 %rd205, 0
  asm("mov.u64 %0, 0;" : "=l"(rd205) : );
  // PTX:747 mov.u64 %rd203, %rd35
  asm("mov.u64 %0, %1;" : "=l"(rd203) : "l"(rd35));
  // PTX:749 $L__BB56_37:
L_BB56_37:;
  // PTX:750 sub.s64 %rd128, %rd203, %rd205
  asm("sub.s64 %0, %1, %2;" : "=l"(rd128) : "l"(rd203), "l"(rd205));
  // PTX:751 shr.u64 %rd129, %rd128, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd129) : "l"(rd128));
  // PTX:752 add.s64 %rd130, %rd129, %rd205
  asm("add.s64 %0, %1, %2;" : "=l"(rd130) : "l"(rd129), "l"(rd205));
  // PTX:753 mul.lo.s64 %rd131, %rd130, %rd60
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd131) : "l"(rd130), "l"(rd60));
  // PTX:754 add.s64 %rd132, %rd131, %rd23
  asm("add.s64 %0, %1, %2;" : "=l"(rd132) : "l"(rd131), "l"(rd23));
  // PTX:755 mul.lo.s64 %rd133, %rd132, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd133) : "l"(rd132));
  // PTX:756 add.s64 %rd134, %rd1, %rd133
  asm("add.s64 %0, %1, %2;" : "=l"(rd134) : "l"(rd1), "l"(rd133));
  // PTX:757 ld.global.u32 %r48, [%rd134]
  r48 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd134) + (0)))));
  // PTX:758 cvt.u32.u64 %r49, %rd34
  asm("cvt.u32.u64 %0, %1;" : "=r"(r49) : "l"(rd34));
  // PTX:759 setp.lt.s32 %p28, %r48, %r49
  p28 = (((int)(r48)) < ((int)(r49)));
  // PTX:760 add.s64 %rd135, %rd130, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd135) : "l"(rd130));
  // PTX:761 selp.b64 %rd205, %rd135, %rd205, %p28
  rd205 = p28 ? rd135 : rd205;
  // PTX:762 selp.b64 %rd203, %rd203, %rd130, %p28
  rd203 = p28 ? rd203 : rd130;
  // PTX:763 setp.gt.u64 %p29, %rd203, %rd205
  p29 = (((unsigned long long)(rd203)) > ((unsigned long long)(rd205)));
  // PTX:764 @%p29 bra $L__BB56_37
  if (p29) { goto L_BB56_37; }
  // PTX:766 $L__BB56_38:
L_BB56_38:;
  // PTX:767 setp.ge.u64 %p30, %rd205, %rd35
  p30 = (((unsigned long long)(rd205)) >= ((unsigned long long)(rd35)));
  // PTX:768 @%p30 bra $L__BB56_42
  if (p30) { goto L_BB56_42; }
  // PTX:770 cvt.u32.u64 %r50, %rd34
  asm("cvt.u32.u64 %0, %1;" : "=r"(r50) : "l"(rd34));
  // PTX:771 mul.lo.s64 %rd136, %rd205, %rd60
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd136) : "l"(rd205), "l"(rd60));
  // PTX:772 add.s64 %rd41, %rd136, %rd23
  asm("add.s64 %0, %1, %2;" : "=l"(rd41) : "l"(rd136), "l"(rd23));
  // PTX:773 mul.lo.s64 %rd137, %rd41, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd137) : "l"(rd41));
  // PTX:774 add.s64 %rd138, %rd1, %rd137
  asm("add.s64 %0, %1, %2;" : "=l"(rd138) : "l"(rd1), "l"(rd137));
  // PTX:775 ld.global.u32 %r51, [%rd138]
  r51 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd138) + (0)))));
  // PTX:776 setp.ne.s32 %p31, %r51, %r50
  p31 = (((int)(r51)) != ((int)(r50)));
  // PTX:777 @%p31 bra $L__BB56_42
  if (p31) { goto L_BB56_42; }
  // PTX:779 add.s64 %rd141, %rd138, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd141) : "l"(rd138));
  // PTX:780 red.global.add.f32 [%rd141], %f226
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd141) + (0)))), (float)(f226));
  // PTX:781 add.s64 %rd142, %rd138, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd142) : "l"(rd138));
  // PTX:782 red.global.add.f32 [%rd142], %f227
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd142) + (0)))), (float)(f227));
  // PTX:783 add.s64 %rd143, %rd138, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd143) : "l"(rd138));
  // PTX:784 red.global.add.f32 [%rd143], %f228
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd143) + (0)))), (float)(f228));
  // PTX:785 add.s64 %rd144, %rd138, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd144) : "l"(rd138));
  // PTX:786 red.global.add.f32 [%rd144], %f229
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd144) + (0)))), (float)(f229));
  // PTX:787 add.s64 %rd145, %rd138, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd145) : "l"(rd138));
  // PTX:788 red.global.add.f32 [%rd145], %f230
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd145) + (0)))), (float)(f230));
  // PTX:789 add.s64 %rd146, %rd138, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd146) : "l"(rd138));
  // PTX:790 red.global.add.f32 [%rd146], %f231
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd146) + (0)))), (float)(f231));
  // PTX:791 add.s64 %rd147, %rd138, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd147) : "l"(rd138));
  // PTX:792 red.global.add.f32 [%rd147], %f232
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd147) + (0)))), (float)(f232));
  // PTX:793 add.s64 %rd148, %rd138, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd148) : "l"(rd138));
  // PTX:794 red.global.add.f32 [%rd148], %f233
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd148) + (0)))), (float)(f233));
  // PTX:795 add.s64 %rd149, %rd138, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd149) : "l"(rd138));
  // PTX:796 red.global.add.f32 [%rd149], %f234
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd149) + (0)))), (float)(f234));
  // PTX:798 $L__BB56_42:
L_BB56_42:;
  // PTX:799 cvt.u32.u64 %r52, %rd34
  asm("cvt.u32.u64 %0, %1;" : "=r"(r52) : "l"(rd34));
  // PTX:800 setp.eq.s32 %p32, %r18, %r52
  p32 = (((int)(r18)) == ((int)(r52)));
  // PTX:801 @%p32 bra $L__BB56_49
  if (p32) { goto L_BB56_49; }
  // PTX:802 bra.uni $L__BB56_43
  goto L_BB56_43;
  // PTX:804 $L__BB56_49:
L_BB56_49:;
  // PTX:805 mul.lo.s64 %rd177, %rd34, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd177) : "l"(rd34));
  // PTX:806 add.s64 %rd178, %rd2, %rd177
  asm("add.s64 %0, %1, %2;" : "=l"(rd178) : "l"(rd2), "l"(rd177));
  // PTX:807 red.global.add.f32 [%rd178], %f226
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd178) + (0)))), (float)(f226));
  // PTX:808 add.s64 %rd179, %rd178, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd179) : "l"(rd178));
  // PTX:809 red.global.add.f32 [%rd179], %f229
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd179) + (0)))), (float)(f229));
  // PTX:810 add.s64 %rd180, %rd178, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd180) : "l"(rd178));
  // PTX:811 red.global.add.f32 [%rd180], %f232
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (0)))), (float)(f232));
  // PTX:812 add.s64 %rd181, %rd178, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd181) : "l"(rd178));
  // PTX:813 red.global.add.f32 [%rd181], %f227
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd181) + (0)))), (float)(f227));
  // PTX:814 add.s64 %rd182, %rd178, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd182) : "l"(rd178));
  // PTX:815 red.global.add.f32 [%rd182], %f230
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd182) + (0)))), (float)(f230));
  // PTX:816 add.s64 %rd183, %rd178, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd183) : "l"(rd178));
  // PTX:817 red.global.add.f32 [%rd183], %f233
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd183) + (0)))), (float)(f233));
  // PTX:818 add.s64 %rd184, %rd178, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd184) : "l"(rd178));
  // PTX:819 red.global.add.f32 [%rd184], %f228
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd184) + (0)))), (float)(f228));
  // PTX:820 add.s64 %rd185, %rd178, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd185) : "l"(rd178));
  // PTX:821 red.global.add.f32 [%rd185], %f231
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (0)))), (float)(f231));
  // PTX:822 add.s64 %rd186, %rd178, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd186) : "l"(rd178));
  // PTX:823 red.global.add.f32 [%rd186], %f234
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd186) + (0)))), (float)(f234));
  // PTX:824 bra.uni $L__BB56_50
  goto L_BB56_50;
  // PTX:826 $L__BB56_43:
L_BB56_43:;
  // PTX:827 shl.b64 %rd151, %rd34, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd151) : "l"(rd34));
  // PTX:828 add.s64 %rd152, %rd3, %rd151
  asm("add.s64 %0, %1, %2;" : "=l"(rd152) : "l"(rd3), "l"(rd151));
  // PTX:829 ld.global.s32 %rd153, [%rd152]
  rd153 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd152) + (0)))));
  // PTX:830 mov.u64 %rd208, 0
  asm("mov.u64 %0, 0;" : "=l"(rd208) : );
  // PTX:831 min.u64 %rd42, %rd153, %rd57
  asm("min.u64 %0, %1, %2;" : "=l"(rd42) : "l"(rd153), "l"(rd57));
  // PTX:832 setp.eq.s64 %p33, %rd42, 0
  p33 = (((long long)(rd42)) == ((long long)(0)));
  // PTX:833 @%p33 bra $L__BB56_46
  if (p33) { goto L_BB56_46; }
  // PTX:835 mov.u64 %rd208, 0
  asm("mov.u64 %0, 0;" : "=l"(rd208) : );
  // PTX:836 mov.u64 %rd206, %rd42
  asm("mov.u64 %0, %1;" : "=l"(rd206) : "l"(rd42));
  // PTX:838 $L__BB56_45:
L_BB56_45:;
  // PTX:839 sub.s64 %rd155, %rd206, %rd208
  asm("sub.s64 %0, %1, %2;" : "=l"(rd155) : "l"(rd206), "l"(rd208));
  // PTX:840 shr.u64 %rd156, %rd155, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd156) : "l"(rd155));
  // PTX:841 add.s64 %rd157, %rd156, %rd208
  asm("add.s64 %0, %1, %2;" : "=l"(rd157) : "l"(rd156), "l"(rd208));
  // PTX:842 mul.lo.s64 %rd158, %rd157, %rd60
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd158) : "l"(rd157), "l"(rd60));
  // PTX:843 add.s64 %rd159, %rd158, %rd34
  asm("add.s64 %0, %1, %2;" : "=l"(rd159) : "l"(rd158), "l"(rd34));
  // PTX:844 mul.lo.s64 %rd160, %rd159, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd160) : "l"(rd159));
  // PTX:845 add.s64 %rd161, %rd1, %rd160
  asm("add.s64 %0, %1, %2;" : "=l"(rd161) : "l"(rd1), "l"(rd160));
  // PTX:846 ld.global.u32 %r53, [%rd161]
  r53 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd161) + (0)))));
  // PTX:847 setp.lt.s32 %p34, %r53, %r18
  p34 = (((int)(r53)) < ((int)(r18)));
  // PTX:848 add.s64 %rd162, %rd157, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd162) : "l"(rd157));
  // PTX:849 selp.b64 %rd208, %rd162, %rd208, %p34
  rd208 = p34 ? rd162 : rd208;
  // PTX:850 selp.b64 %rd206, %rd206, %rd157, %p34
  rd206 = p34 ? rd206 : rd157;
  // PTX:851 setp.gt.u64 %p35, %rd206, %rd208
  p35 = (((unsigned long long)(rd206)) > ((unsigned long long)(rd208)));
  // PTX:852 @%p35 bra $L__BB56_45
  if (p35) { goto L_BB56_45; }
  // PTX:854 $L__BB56_46:
L_BB56_46:;
  // PTX:855 setp.ge.u64 %p36, %rd208, %rd42
  p36 = (((unsigned long long)(rd208)) >= ((unsigned long long)(rd42)));
  // PTX:856 @%p36 bra $L__BB56_50
  if (p36) { goto L_BB56_50; }
  // PTX:858 mul.lo.s64 %rd163, %rd208, %rd60
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd163) : "l"(rd208), "l"(rd60));
  // PTX:859 add.s64 %rd48, %rd163, %rd34
  asm("add.s64 %0, %1, %2;" : "=l"(rd48) : "l"(rd163), "l"(rd34));
  // PTX:860 mul.lo.s64 %rd164, %rd48, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd164) : "l"(rd48));
  // PTX:861 add.s64 %rd165, %rd1, %rd164
  asm("add.s64 %0, %1, %2;" : "=l"(rd165) : "l"(rd1), "l"(rd164));
  // PTX:862 ld.global.u32 %r56, [%rd165]
  r56 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd165) + (0)))));
  // PTX:863 setp.ne.s32 %p37, %r56, %r18
  p37 = (((int)(r56)) != ((int)(r18)));
  // PTX:864 @%p37 bra $L__BB56_50
  if (p37) { goto L_BB56_50; }
  // PTX:866 add.s64 %rd168, %rd165, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd168) : "l"(rd165));
  // PTX:867 red.global.add.f32 [%rd168], %f226
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd168) + (0)))), (float)(f226));
  // PTX:868 add.s64 %rd169, %rd165, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd169) : "l"(rd165));
  // PTX:869 red.global.add.f32 [%rd169], %f229
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd169) + (0)))), (float)(f229));
  // PTX:870 add.s64 %rd170, %rd165, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd170) : "l"(rd165));
  // PTX:871 red.global.add.f32 [%rd170], %f232
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd170) + (0)))), (float)(f232));
  // PTX:872 add.s64 %rd171, %rd165, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd171) : "l"(rd165));
  // PTX:873 red.global.add.f32 [%rd171], %f227
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd171) + (0)))), (float)(f227));
  // PTX:874 add.s64 %rd172, %rd165, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd172) : "l"(rd165));
  // PTX:875 red.global.add.f32 [%rd172], %f230
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd172) + (0)))), (float)(f230));
  // PTX:876 add.s64 %rd173, %rd165, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd173) : "l"(rd165));
  // PTX:877 red.global.add.f32 [%rd173], %f233
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd173) + (0)))), (float)(f233));
  // PTX:878 add.s64 %rd174, %rd165, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd174) : "l"(rd165));
  // PTX:879 red.global.add.f32 [%rd174], %f228
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd174) + (0)))), (float)(f228));
  // PTX:880 add.s64 %rd175, %rd165, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd175) : "l"(rd165));
  // PTX:881 red.global.add.f32 [%rd175], %f231
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd175) + (0)))), (float)(f231));
  // PTX:882 add.s64 %rd176, %rd165, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd176) : "l"(rd165));
  // PTX:883 red.global.add.f32 [%rd176], %f234
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd176) + (0)))), (float)(f234));
  // PTX:885 $L__BB56_50:
L_BB56_50:;
  // PTX:886 add.s32 %r63, %r63, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r63) : "r"(r63));
  // PTX:887 setp.lt.u32 %p38, %r63, %r61
  p38 = (((unsigned)(r63)) < ((unsigned)(r61)));
  // PTX:888 @%p38 bra $L__BB56_34
  if (p38) { goto L_BB56_34; }
  // PTX:890 $L__BB56_32:
L_BB56_32:;
  // PTX:891 mul.wide.s32 %rd113, %r62, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd113) : "r"(r62));
  // PTX:892 add.s64 %rd114, %rd8, %rd113
  asm("add.s64 %0, %1, %2;" : "=l"(rd114) : "l"(rd8), "l"(rd113));
  // PTX:893 ld.local.f32 %f216, [%rd114]
  f216 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd114) + (0)))));
  // PTX:894 ld.local.f32 %f217, [%rd114+4]
  f217 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd114) + (4)))));
  // PTX:895 mul.f32 %f387, %f217, %f217
  asm("mul.f32 %0, %1, %2;" : "=f"(f387) : "f"(f217), "f"(f217));
  // PTX:896 ld.local.f32 %f218, [%rd114+8]
  f218 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd114) + (8)))));
  // PTX:897 fma.rn.f32 %f388, %f216, %f216, %f387
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f388) : "f"(f216), "f"(f216), "f"(f387));
  // PTX:898 fma.rn.f32 %f389, %f218, %f218, %f388
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f389) : "f"(f218), "f"(f218), "f"(f388));
  // PTX:899 ld.local.f32 %f219, [%rd114+12]
  f219 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd114) + (12)))));
  // PTX:900 ld.local.f32 %f220, [%rd114+16]
  f220 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd114) + (16)))));
  // PTX:901 mul.f32 %f390, %f220, %f217
  asm("mul.f32 %0, %1, %2;" : "=f"(f390) : "f"(f220), "f"(f217));
  // PTX:902 ld.local.f32 %f221, [%rd114+20]
  f221 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd114) + (20)))));
  // PTX:903 fma.rn.f32 %f391, %f219, %f216, %f390
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f391) : "f"(f219), "f"(f216), "f"(f390));
  // PTX:904 fma.rn.f32 %f392, %f221, %f218, %f391
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f392) : "f"(f221), "f"(f218), "f"(f391));
  // PTX:905 ld.local.f32 %f222, [%rd114+24]
  f222 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd114) + (24)))));
  // PTX:906 ld.local.f32 %f223, [%rd114+28]
  f223 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd114) + (28)))));
  // PTX:907 mul.f32 %f393, %f223, %f217
  asm("mul.f32 %0, %1, %2;" : "=f"(f393) : "f"(f223), "f"(f217));
  // PTX:908 ld.local.f32 %f224, [%rd114+32]
  f224 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd114) + (32)))));
  // PTX:909 fma.rn.f32 %f394, %f222, %f216, %f393
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f394) : "f"(f222), "f"(f216), "f"(f393));
  // PTX:910 fma.rn.f32 %f395, %f224, %f218, %f394
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f395) : "f"(f224), "f"(f218), "f"(f394));
  // PTX:911 mul.f32 %f396, %f220, %f220
  asm("mul.f32 %0, %1, %2;" : "=f"(f396) : "f"(f220), "f"(f220));
  // PTX:912 fma.rn.f32 %f397, %f219, %f219, %f396
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f397) : "f"(f219), "f"(f219), "f"(f396));
  // PTX:913 fma.rn.f32 %f398, %f221, %f221, %f397
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f398) : "f"(f221), "f"(f221), "f"(f397));
  // PTX:914 mul.f32 %f399, %f223, %f220
  asm("mul.f32 %0, %1, %2;" : "=f"(f399) : "f"(f223), "f"(f220));
  // PTX:915 fma.rn.f32 %f400, %f222, %f219, %f399
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f400) : "f"(f222), "f"(f219), "f"(f399));
  // PTX:916 fma.rn.f32 %f401, %f224, %f221, %f400
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f401) : "f"(f224), "f"(f221), "f"(f400));
  // PTX:917 mul.f32 %f402, %f223, %f223
  asm("mul.f32 %0, %1, %2;" : "=f"(f402) : "f"(f223), "f"(f223));
  // PTX:918 fma.rn.f32 %f403, %f222, %f222, %f402
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f403) : "f"(f222), "f"(f222), "f"(f402));
  // PTX:919 fma.rn.f32 %f404, %f224, %f224, %f403
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f404) : "f"(f224), "f"(f224), "f"(f403));
  // PTX:920 mul.wide.s32 %rd115, %r62, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd115) : "r"(r62));
  // PTX:921 add.s64 %rd116, %rd7, %rd115
  asm("add.s64 %0, %1, %2;" : "=l"(rd116) : "l"(rd7), "l"(rd115));
  // PTX:922 ld.local.f32 %f225, [%rd116]
  f225 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd116) + (0)))));
  // PTX:923 mul.f32 %f405, %f225, %f225
  asm("mul.f32 %0, %1, %2;" : "=f"(f405) : "f"(f225), "f"(f225));
  // PTX:924 mul.f32 %f406, %f405, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f406) : "f"(f405));
  // PTX:925 sub.f32 %f407, %f389, %f405
  asm("sub.f32 %0, %1, %2;" : "=f"(f407) : "f"(f389), "f"(f405));
  // PTX:926 sub.f32 %f408, %f392, %f406
  asm("sub.f32 %0, %1, %2;" : "=f"(f408) : "f"(f392), "f"(f406));
  // PTX:927 sub.f32 %f409, %f395, %f406
  asm("sub.f32 %0, %1, %2;" : "=f"(f409) : "f"(f395), "f"(f406));
  // PTX:928 sub.f32 %f410, %f398, %f405
  asm("sub.f32 %0, %1, %2;" : "=f"(f410) : "f"(f398), "f"(f405));
  // PTX:929 sub.f32 %f411, %f401, %f406
  asm("sub.f32 %0, %1, %2;" : "=f"(f411) : "f"(f401), "f"(f406));
  // PTX:930 sub.f32 %f412, %f404, %f405
  asm("sub.f32 %0, %1, %2;" : "=f"(f412) : "f"(f404), "f"(f405));
  // PTX:931 mul.f32 %f413, %f1, %f407
  asm("mul.f32 %0, %1, %2;" : "=f"(f413) : "f"(f1), "f"(f407));
  // PTX:932 mul.f32 %f414, %f1, %f408
  asm("mul.f32 %0, %1, %2;" : "=f"(f414) : "f"(f1), "f"(f408));
  // PTX:933 mul.f32 %f415, %f1, %f409
  asm("mul.f32 %0, %1, %2;" : "=f"(f415) : "f"(f1), "f"(f409));
  // PTX:934 mul.f32 %f416, %f1, %f410
  asm("mul.f32 %0, %1, %2;" : "=f"(f416) : "f"(f1), "f"(f410));
  // PTX:935 mul.f32 %f417, %f1, %f411
  asm("mul.f32 %0, %1, %2;" : "=f"(f417) : "f"(f1), "f"(f411));
  // PTX:936 mul.f32 %f418, %f1, %f412
  asm("mul.f32 %0, %1, %2;" : "=f"(f418) : "f"(f1), "f"(f412));
  // PTX:937 add.s64 %rd117, %rd6, %rd115
  asm("add.s64 %0, %1, %2;" : "=l"(rd117) : "l"(rd6), "l"(rd115));
  // PTX:938 ld.local.u32 %r46, [%rd117]
  r46 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd117) + (0)))));
  // PTX:939 cvt.s64.s32 %rd23, %r46
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd23) : "r"(r46));
  // PTX:940 mul.wide.s32 %rd118, %r46, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd118) : "r"(r46));
  // PTX:941 add.s64 %rd24, %rd2, %rd118
  asm("add.s64 %0, %1, %2;" : "=l"(rd24) : "l"(rd2), "l"(rd118));
  // PTX:942 red.global.add.f32 [%rd24], %f413
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (0)))), (float)(f413));
  // PTX:943 add.s64 %rd25, %rd24, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd25) : "l"(rd24));
  // PTX:944 red.global.add.f32 [%rd25], %f414
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (0)))), (float)(f414));
  // PTX:945 add.s64 %rd26, %rd24, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd26) : "l"(rd24));
  // PTX:946 red.global.add.f32 [%rd26], %f415
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (0)))), (float)(f415));
  // PTX:947 add.s64 %rd27, %rd24, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd27) : "l"(rd24));
  // PTX:948 red.global.add.f32 [%rd27], %f414
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))), (float)(f414));
  // PTX:949 add.s64 %rd28, %rd24, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd28) : "l"(rd24));
  // PTX:950 red.global.add.f32 [%rd28], %f416
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (0)))), (float)(f416));
  // PTX:951 add.s64 %rd29, %rd24, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd29) : "l"(rd24));
  // PTX:952 red.global.add.f32 [%rd29], %f417
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (0)))), (float)(f417));
  // PTX:953 add.s64 %rd30, %rd24, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd30) : "l"(rd24));
  // PTX:954 red.global.add.f32 [%rd30], %f415
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0)))), (float)(f415));
  // PTX:955 add.s64 %rd31, %rd24, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd31) : "l"(rd24));
  // PTX:956 red.global.add.f32 [%rd31], %f417
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (0)))), (float)(f417));
  // PTX:957 add.s64 %rd32, %rd24, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd32) : "l"(rd24));
  // PTX:958 red.global.add.f32 [%rd32], %f418
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (0)))), (float)(f418));
  // PTX:959 add.s32 %r62, %r62, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r62) : "r"(r62));
  // PTX:960 setp.ge.u32 %p25, %r62, %r61
  p25 = (((unsigned)(r62)) >= ((unsigned)(r61)));
  // PTX:961 @%p25 bra $L__BB56_51
  if (p25) { goto L_BB56_51; }
  // PTX:962 bra.uni $L__BB56_33
  goto L_BB56_33;
  // PTX:964 $L__BB56_51:
L_BB56_51:;
  // PTX:965 ret
  return;
}
