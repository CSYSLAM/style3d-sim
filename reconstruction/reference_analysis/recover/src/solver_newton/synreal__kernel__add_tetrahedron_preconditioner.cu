// 机械还原自 PTX：synreal::kernel::add_tetrahedron_preconditioner(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 425e8ec3c891a7e6b2796b79d3a713ebb5a93ccf97bc40db55027bb24e5252f7
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__add_tetrahedron_preconditioner(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, float param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9) {
  int p0, p1, p2, p3, p4, p5, p6;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440, f441, f442, f443, f444, f445, f446, f447, f448, f449, f450, f451, f452, f453, f454, f455, f456, f457, f458, f459, f460, f461, f462, f463, f464, f465, f466, f467, f468, f469, f470, f471, f472, f473, f474, f475, f476, f477, f478, f479, f480, f481, f482, f483, f484, f485, f486, f487, f488, f489, f490, f491, f492, f493, f494, f495, f496, f497, f498, f499, f500, f501, f502, f503, f504, f505, f506, f507, f508, f509, f510, f511, f512, f513, f514, f515, f516, f517, f518, f519, f520, f521, f522, f523, f524, f525, f526, f527, f528, f529, f530, f531, f532, f533, f534, f535, f536, f537, f538, f539, f540, f541, f542, f543, f544, f545, f546, f547, f548, f549, f550, f551, f552, f553, f554, f555, f556, f557, f558, f559, f560, f561, f562, f563, f564, f565, f566, f567, f568, f569, f570, f571, f572, f573, f574, f575, f576, f577, f578, f579, f580, f581, f582, f583, f584, f585, f586, f587, f588, f589, f590, f591, f592, f593, f594, f595, f596, f597, f598, f599, f600, f601, f602, f603, f604, f605, f606, f607, f608, f609, f610, f611, f612, f613, f614, f615, f616, f617, f618, f619, f620, f621, f622, f623, f624, f625, f626, f627, f628, f629, f630, f631, f632, f633, f634, f635, f636, f637, f638, f639, f640, f641, f642, f643, f644, f645, f646, f647, f648, f649, f650, f651, f652, f653, f654, f655, f656, f657, f658, f659;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90;
  // PTX:26 ld.param.u64 %rd13, [_ZN7synreal6kernel30add_tetrahedron_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKffPSB_mmm_param_0]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:27 ld.param.u64 %rd14, [_ZN7synreal6kernel30add_tetrahedron_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKffPSB_mmm_param_1]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:28 ld.param.u64 %rd15, [_ZN7synreal6kernel30add_tetrahedron_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKffPSB_mmm_param_2]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:29 ld.param.u64 %rd16, [_ZN7synreal6kernel30add_tetrahedron_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKffPSB_mmm_param_3]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:30 ld.param.u64 %rd17, [_ZN7synreal6kernel30add_tetrahedron_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKffPSB_mmm_param_4]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:31 ld.param.f32 %f107, [_ZN7synreal6kernel30add_tetrahedron_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKffPSB_mmm_param_5]
  f107 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param5 + (0))));
  // PTX:32 ld.param.u64 %rd20, [_ZN7synreal6kernel30add_tetrahedron_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKffPSB_mmm_param_6]
  rd20 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:33 ld.param.u64 %rd21, [_ZN7synreal6kernel30add_tetrahedron_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKffPSB_mmm_param_7]
  rd21 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:34 ld.param.u64 %rd18, [_ZN7synreal6kernel30add_tetrahedron_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKffPSB_mmm_param_8]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:35 ld.param.u64 %rd19, [_ZN7synreal6kernel30add_tetrahedron_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKffPSB_mmm_param_9]
  rd19 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:36 cvta.to.global.u64 %rd1, %rd20
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd20));
  // PTX:37 mov.u32 %r1, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r1) : "r"(blockIdx.x));
  // PTX:38 mov.u32 %r2, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockDim.x));
  // PTX:39 mul.wide.u32 %rd22, %r1, %r2
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd22) : "r"(r1), "r"(r2));
  // PTX:40 mov.u32 %r3, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(threadIdx.x));
  // PTX:41 cvt.u64.u32 %rd23, %r3
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd23) : "r"(r3));
  // PTX:42 add.s64 %rd2, %rd22, %rd23
  asm("add.s64 %0, %1, %2;" : "=l"(rd2) : "l"(rd22), "l"(rd23));
  // PTX:43 setp.ge.u64 %p1, %rd2, %rd21
  p1 = (((unsigned long long)(rd2)) >= ((unsigned long long)(rd21)));
  // PTX:44 @%p1 bra $L__BB59_13
  if (p1) { goto L_BB59_13; }
  // PTX:46 or.b64 %rd24, %rd2, %rd18
  asm("or.b64 %0, %1, %2;" : "=l"(rd24) : "l"(rd2), "l"(rd18));
  // PTX:47 and.b64 %rd25, %rd24, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd25) : "l"(rd24));
  // PTX:48 setp.eq.s64 %p2, %rd25, 0
  p2 = (((long long)(rd25)) == ((long long)(0)));
  // PTX:49 @%p2 bra $L__BB59_3
  if (p2) { goto L_BB59_3; }
  // PTX:51 div.u64 %rd89, %rd2, %rd18
  asm("div.u64 %0, %1, %2;" : "=l"(rd89) : "l"(rd2), "l"(rd18));
  // PTX:52 mul.lo.s64 %rd26, %rd89, %rd18
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd26) : "l"(rd89), "l"(rd18));
  // PTX:53 sub.s64 %rd90, %rd2, %rd26
  asm("sub.s64 %0, %1, %2;" : "=l"(rd90) : "l"(rd2), "l"(rd26));
  // PTX:54 bra.uni $L__BB59_4
  goto L_BB59_4;
  // PTX:56 $L__BB59_3:
L_BB59_3:;
  // PTX:57 cvt.u32.u64 %r4, %rd18
  asm("cvt.u32.u64 %0, %1;" : "=r"(r4) : "l"(rd18));
  // PTX:58 cvt.u32.u64 %r5, %rd2
  asm("cvt.u32.u64 %0, %1;" : "=r"(r5) : "l"(rd2));
  // PTX:59 div.u32 %r6, %r5, %r4
  asm("div.u32 %0, %1, %2;" : "=r"(r6) : "r"(r5), "r"(r4));
  // PTX:60 mul.lo.s32 %r7, %r6, %r4
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r7) : "r"(r6), "r"(r4));
  // PTX:61 sub.s32 %r8, %r5, %r7
  asm("sub.s32 %0, %1, %2;" : "=r"(r8) : "r"(r5), "r"(r7));
  // PTX:62 cvt.u64.u32 %rd89, %r6
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd89) : "r"(r6));
  // PTX:63 cvt.u64.u32 %rd90, %r8
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd90) : "r"(r8));
  // PTX:65 $L__BB59_4:
L_BB59_4:;
  // PTX:66 cvta.to.global.u64 %rd27, %rd13
  rd27 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd13));
  // PTX:67 mul.lo.s64 %rd28, %rd89, %rd19
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd28) : "l"(rd89), "l"(rd19));
  // PTX:68 cvt.u32.u64 %r9, %rd28
  asm("cvt.u32.u64 %0, %1;" : "=r"(r9) : "l"(rd28));
  // PTX:69 cvta.to.global.u64 %rd29, %rd14
  rd29 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd14));
  // PTX:70 shl.b64 %rd30, %rd90, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd30) : "l"(rd90));
  // PTX:71 add.s64 %rd31, %rd29, %rd30
  asm("add.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd29), "l"(rd30));
  // PTX:72 ld.global.u32 %r10, [%rd31]
  r10 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (0)))));
  // PTX:73 add.s32 %r11, %r10, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r11) : "r"(r10), "r"(r9));
  // PTX:74 ld.global.u32 %r12, [%rd31+4]
  r12 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (4)))));
  // PTX:75 add.s32 %r13, %r12, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r13) : "r"(r12), "r"(r9));
  // PTX:76 ld.global.u32 %r14, [%rd31+8]
  r14 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (8)))));
  // PTX:77 add.s32 %r15, %r14, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r15) : "r"(r14), "r"(r9));
  // PTX:78 ld.global.u32 %r16, [%rd31+12]
  r16 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (12)))));
  // PTX:79 add.s32 %r17, %r16, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r17) : "r"(r16), "r"(r9));
  // PTX:80 cvta.to.global.u64 %rd32, %rd15
  rd32 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd15));
  // PTX:81 mul.lo.s64 %rd33, %rd90, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd33) : "l"(rd90));
  // PTX:82 add.s64 %rd34, %rd32, %rd33
  asm("add.s64 %0, %1, %2;" : "=l"(rd34) : "l"(rd32), "l"(rd33));
  // PTX:83 cvta.to.global.u64 %rd35, %rd16
  rd35 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd16));
  // PTX:84 mul.lo.s64 %rd36, %rd90, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd36) : "l"(rd90));
  // PTX:85 add.s64 %rd37, %rd35, %rd36
  asm("add.s64 %0, %1, %2;" : "=l"(rd37) : "l"(rd35), "l"(rd36));
  // PTX:86 cvt.s64.s32 %rd9, %r11
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd9) : "r"(r11));
  // PTX:87 mul.wide.s32 %rd38, %r11, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd38) : "r"(r11));
  // PTX:88 add.s64 %rd39, %rd27, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd39) : "l"(rd27), "l"(rd38));
  // PTX:89 cvt.s64.s32 %rd10, %r13
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd10) : "r"(r13));
  // PTX:90 mul.wide.s32 %rd40, %r13, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd40) : "r"(r13));
  // PTX:91 add.s64 %rd41, %rd27, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd41) : "l"(rd27), "l"(rd40));
  // PTX:92 ld.global.f32 %f108, [%rd41]
  f108 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (0)))));
  // PTX:93 ld.global.f32 %f109, [%rd39]
  f109 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (0)))));
  // PTX:94 sub.f32 %f110, %f108, %f109
  asm("sub.f32 %0, %1, %2;" : "=f"(f110) : "f"(f108), "f"(f109));
  // PTX:95 ld.global.f32 %f111, [%rd41+4]
  f111 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (4)))));
  // PTX:96 ld.global.f32 %f112, [%rd39+4]
  f112 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (4)))));
  // PTX:97 sub.f32 %f113, %f111, %f112
  asm("sub.f32 %0, %1, %2;" : "=f"(f113) : "f"(f111), "f"(f112));
  // PTX:98 ld.global.f32 %f114, [%rd41+8]
  f114 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (8)))));
  // PTX:99 ld.global.f32 %f115, [%rd39+8]
  f115 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (8)))));
  // PTX:100 sub.f32 %f116, %f114, %f115
  asm("sub.f32 %0, %1, %2;" : "=f"(f116) : "f"(f114), "f"(f115));
  // PTX:101 cvt.s64.s32 %rd11, %r15
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd11) : "r"(r15));
  // PTX:102 mul.wide.s32 %rd42, %r15, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd42) : "r"(r15));
  // PTX:103 add.s64 %rd43, %rd27, %rd42
  asm("add.s64 %0, %1, %2;" : "=l"(rd43) : "l"(rd27), "l"(rd42));
  // PTX:104 ld.global.f32 %f117, [%rd43]
  f117 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (0)))));
  // PTX:105 sub.f32 %f118, %f117, %f109
  asm("sub.f32 %0, %1, %2;" : "=f"(f118) : "f"(f117), "f"(f109));
  // PTX:106 ld.global.f32 %f119, [%rd43+4]
  f119 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (4)))));
  // PTX:107 sub.f32 %f120, %f119, %f112
  asm("sub.f32 %0, %1, %2;" : "=f"(f120) : "f"(f119), "f"(f112));
  // PTX:108 ld.global.f32 %f121, [%rd43+8]
  f121 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (8)))));
  // PTX:109 sub.f32 %f122, %f121, %f115
  asm("sub.f32 %0, %1, %2;" : "=f"(f122) : "f"(f121), "f"(f115));
  // PTX:110 cvt.s64.s32 %rd12, %r17
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd12) : "r"(r17));
  // PTX:111 mul.wide.s32 %rd44, %r17, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd44) : "r"(r17));
  // PTX:112 add.s64 %rd45, %rd27, %rd44
  asm("add.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd27), "l"(rd44));
  // PTX:113 ld.global.f32 %f123, [%rd45]
  f123 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))));
  // PTX:114 sub.f32 %f124, %f123, %f109
  asm("sub.f32 %0, %1, %2;" : "=f"(f124) : "f"(f123), "f"(f109));
  // PTX:115 ld.global.f32 %f125, [%rd45+4]
  f125 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (4)))));
  // PTX:116 sub.f32 %f126, %f125, %f112
  asm("sub.f32 %0, %1, %2;" : "=f"(f126) : "f"(f125), "f"(f112));
  // PTX:117 ld.global.f32 %f127, [%rd45+8]
  f127 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (8)))));
  // PTX:118 sub.f32 %f128, %f127, %f115
  asm("sub.f32 %0, %1, %2;" : "=f"(f128) : "f"(f127), "f"(f115));
  // PTX:119 ld.global.f32 %f1, [%rd34]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (0)))));
  // PTX:120 ld.global.f32 %f2, [%rd34+12]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (12)))));
  // PTX:121 mul.f32 %f129, %f118, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f129) : "f"(f118), "f"(f2));
  // PTX:122 mul.f32 %f130, %f120, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f130) : "f"(f120), "f"(f2));
  // PTX:123 mul.f32 %f131, %f122, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f131) : "f"(f122), "f"(f2));
  // PTX:124 fma.rn.f32 %f132, %f110, %f1, %f129
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f132) : "f"(f110), "f"(f1), "f"(f129));
  // PTX:125 fma.rn.f32 %f133, %f113, %f1, %f130
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f133) : "f"(f113), "f"(f1), "f"(f130));
  // PTX:126 fma.rn.f32 %f134, %f116, %f1, %f131
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f134) : "f"(f116), "f"(f1), "f"(f131));
  // PTX:127 ld.global.f32 %f3, [%rd34+24]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (24)))));
  // PTX:128 fma.rn.f32 %f4, %f124, %f3, %f132
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f4) : "f"(f124), "f"(f3), "f"(f132));
  // PTX:129 fma.rn.f32 %f5, %f126, %f3, %f133
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f5) : "f"(f126), "f"(f3), "f"(f133));
  // PTX:130 fma.rn.f32 %f6, %f128, %f3, %f134
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f6) : "f"(f128), "f"(f3), "f"(f134));
  // PTX:131 ld.global.f32 %f7, [%rd34+4]
  f7 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (4)))));
  // PTX:132 ld.global.f32 %f8, [%rd34+16]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (16)))));
  // PTX:133 mul.f32 %f135, %f118, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f135) : "f"(f118), "f"(f8));
  // PTX:134 mul.f32 %f136, %f120, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f136) : "f"(f120), "f"(f8));
  // PTX:135 mul.f32 %f137, %f122, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f137) : "f"(f122), "f"(f8));
  // PTX:136 fma.rn.f32 %f138, %f110, %f7, %f135
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f138) : "f"(f110), "f"(f7), "f"(f135));
  // PTX:137 fma.rn.f32 %f139, %f113, %f7, %f136
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f139) : "f"(f113), "f"(f7), "f"(f136));
  // PTX:138 fma.rn.f32 %f140, %f116, %f7, %f137
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f140) : "f"(f116), "f"(f7), "f"(f137));
  // PTX:139 ld.global.f32 %f9, [%rd34+28]
  f9 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (28)))));
  // PTX:140 fma.rn.f32 %f10, %f124, %f9, %f138
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f10) : "f"(f124), "f"(f9), "f"(f138));
  // PTX:141 fma.rn.f32 %f11, %f126, %f9, %f139
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f11) : "f"(f126), "f"(f9), "f"(f139));
  // PTX:142 fma.rn.f32 %f12, %f128, %f9, %f140
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f12) : "f"(f128), "f"(f9), "f"(f140));
  // PTX:143 ld.global.f32 %f13, [%rd34+8]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (8)))));
  // PTX:144 ld.global.f32 %f14, [%rd34+20]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (20)))));
  // PTX:145 mul.f32 %f141, %f118, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f141) : "f"(f118), "f"(f14));
  // PTX:146 mul.f32 %f142, %f120, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f142) : "f"(f120), "f"(f14));
  // PTX:147 mul.f32 %f143, %f122, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f143) : "f"(f122), "f"(f14));
  // PTX:148 fma.rn.f32 %f144, %f110, %f13, %f141
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f144) : "f"(f110), "f"(f13), "f"(f141));
  // PTX:149 fma.rn.f32 %f145, %f113, %f13, %f142
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f145) : "f"(f113), "f"(f13), "f"(f142));
  // PTX:150 fma.rn.f32 %f146, %f116, %f13, %f143
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f146) : "f"(f116), "f"(f13), "f"(f143));
  // PTX:151 ld.global.f32 %f15, [%rd34+32]
  f15 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (32)))));
  // PTX:152 fma.rn.f32 %f16, %f124, %f15, %f144
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f16) : "f"(f124), "f"(f15), "f"(f144));
  // PTX:153 fma.rn.f32 %f17, %f126, %f15, %f145
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f17) : "f"(f126), "f"(f15), "f"(f145));
  // PTX:154 fma.rn.f32 %f18, %f128, %f15, %f146
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f18) : "f"(f128), "f"(f15), "f"(f146));
  // PTX:155 mul.f32 %f147, %f11, %f18
  asm("mul.f32 %0, %1, %2;" : "=f"(f147) : "f"(f11), "f"(f18));
  // PTX:156 mul.f32 %f148, %f17, %f12
  asm("mul.f32 %0, %1, %2;" : "=f"(f148) : "f"(f17), "f"(f12));
  // PTX:157 sub.f32 %f19, %f147, %f148
  asm("sub.f32 %0, %1, %2;" : "=f"(f19) : "f"(f147), "f"(f148));
  // PTX:158 mul.f32 %f149, %f16, %f12
  asm("mul.f32 %0, %1, %2;" : "=f"(f149) : "f"(f16), "f"(f12));
  // PTX:159 mul.f32 %f150, %f10, %f18
  asm("mul.f32 %0, %1, %2;" : "=f"(f150) : "f"(f10), "f"(f18));
  // PTX:160 sub.f32 %f20, %f149, %f150
  asm("sub.f32 %0, %1, %2;" : "=f"(f20) : "f"(f149), "f"(f150));
  // PTX:161 mul.f32 %f151, %f10, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f151) : "f"(f10), "f"(f17));
  // PTX:162 mul.f32 %f152, %f16, %f11
  asm("mul.f32 %0, %1, %2;" : "=f"(f152) : "f"(f16), "f"(f11));
  // PTX:163 sub.f32 %f21, %f151, %f152
  asm("sub.f32 %0, %1, %2;" : "=f"(f21) : "f"(f151), "f"(f152));
  // PTX:164 mul.f32 %f153, %f17, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f153) : "f"(f17), "f"(f6));
  // PTX:165 mul.f32 %f154, %f5, %f18
  asm("mul.f32 %0, %1, %2;" : "=f"(f154) : "f"(f5), "f"(f18));
  // PTX:166 sub.f32 %f22, %f153, %f154
  asm("sub.f32 %0, %1, %2;" : "=f"(f22) : "f"(f153), "f"(f154));
  // PTX:167 mul.f32 %f155, %f4, %f18
  asm("mul.f32 %0, %1, %2;" : "=f"(f155) : "f"(f4), "f"(f18));
  // PTX:168 mul.f32 %f156, %f16, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f156) : "f"(f16), "f"(f6));
  // PTX:169 sub.f32 %f23, %f155, %f156
  asm("sub.f32 %0, %1, %2;" : "=f"(f23) : "f"(f155), "f"(f156));
  // PTX:170 mul.f32 %f157, %f16, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f157) : "f"(f16), "f"(f5));
  // PTX:171 mul.f32 %f158, %f4, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f158) : "f"(f4), "f"(f17));
  // PTX:172 sub.f32 %f24, %f157, %f158
  asm("sub.f32 %0, %1, %2;" : "=f"(f24) : "f"(f157), "f"(f158));
  // PTX:173 mul.f32 %f159, %f5, %f12
  asm("mul.f32 %0, %1, %2;" : "=f"(f159) : "f"(f5), "f"(f12));
  // PTX:174 mul.f32 %f160, %f11, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f160) : "f"(f11), "f"(f6));
  // PTX:175 sub.f32 %f25, %f159, %f160
  asm("sub.f32 %0, %1, %2;" : "=f"(f25) : "f"(f159), "f"(f160));
  // PTX:176 mul.f32 %f161, %f10, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f161) : "f"(f10), "f"(f6));
  // PTX:177 mul.f32 %f162, %f4, %f12
  asm("mul.f32 %0, %1, %2;" : "=f"(f162) : "f"(f4), "f"(f12));
  // PTX:178 sub.f32 %f26, %f161, %f162
  asm("sub.f32 %0, %1, %2;" : "=f"(f26) : "f"(f161), "f"(f162));
  // PTX:179 mul.f32 %f163, %f4, %f11
  asm("mul.f32 %0, %1, %2;" : "=f"(f163) : "f"(f4), "f"(f11));
  // PTX:180 mul.f32 %f164, %f10, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f164) : "f"(f10), "f"(f5));
  // PTX:181 sub.f32 %f27, %f163, %f164
  asm("sub.f32 %0, %1, %2;" : "=f"(f27) : "f"(f163), "f"(f164));
  // PTX:182 ld.global.f32 %f165, [%rd37+4]
  f165 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (4)))));
  // PTX:183 ld.global.f32 %f166, [%rd37]
  f166 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (0)))));
  // PTX:184 add.f32 %f167, %f166, %f165
  asm("add.f32 %0, %1, %2;" : "=f"(f167) : "f"(f166), "f"(f165));
  // PTX:185 neg.f32 %f168, %f1
  asm("neg.f32 %0, %1;" : "=f"(f168) : "f"(f1));
  // PTX:186 neg.f32 %f169, %f7
  asm("neg.f32 %0, %1;" : "=f"(f169) : "f"(f7));
  // PTX:187 neg.f32 %f170, %f13
  asm("neg.f32 %0, %1;" : "=f"(f170) : "f"(f13));
  // PTX:188 sub.f32 %f171, %f168, %f2
  asm("sub.f32 %0, %1, %2;" : "=f"(f171) : "f"(f168), "f"(f2));
  // PTX:189 sub.f32 %f172, %f169, %f8
  asm("sub.f32 %0, %1, %2;" : "=f"(f172) : "f"(f169), "f"(f8));
  // PTX:190 sub.f32 %f173, %f170, %f14
  asm("sub.f32 %0, %1, %2;" : "=f"(f173) : "f"(f170), "f"(f14));
  // PTX:191 sub.f32 %f28, %f171, %f3
  asm("sub.f32 %0, %1, %2;" : "=f"(f28) : "f"(f171), "f"(f3));
  // PTX:192 sub.f32 %f29, %f172, %f9
  asm("sub.f32 %0, %1, %2;" : "=f"(f29) : "f"(f172), "f"(f9));
  // PTX:193 sub.f32 %f30, %f173, %f15
  asm("sub.f32 %0, %1, %2;" : "=f"(f30) : "f"(f173), "f"(f15));
  // PTX:194 cvta.to.global.u64 %rd46, %rd17
  rd46 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd17));
  // PTX:195 shl.b64 %rd47, %rd90, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd47) : "l"(rd90));
  // PTX:196 add.s64 %rd48, %rd46, %rd47
  asm("add.s64 %0, %1, %2;" : "=l"(rd48) : "l"(rd46), "l"(rd47));
  // PTX:197 ld.global.f32 %f174, [%rd48]
  f174 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))));
  // PTX:198 mul.f32 %f31, %f166, %f174
  asm("mul.f32 %0, %1, %2;" : "=f"(f31) : "f"(f166), "f"(f174));
  // PTX:199 mul.f32 %f32, %f167, %f174
  asm("mul.f32 %0, %1, %2;" : "=f"(f32) : "f"(f167), "f"(f174));
  // PTX:200 ld.global.f32 %f33, [%rd37+8]
  f33 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (8)))));
  // PTX:201 setp.leu.f32 %p3, %f33, 0f00000000
  p3 = ((isnan(((float)(f33))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f33)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:202 mul.f32 %f175, %f33, %f174
  asm("mul.f32 %0, %1, %2;" : "=f"(f175) : "f"(f33), "f"(f174));
  // PTX:203 mul.f32 %f34, %f175, %f107
  asm("mul.f32 %0, %1, %2;" : "=f"(f34) : "f"(f175), "f"(f107));
  // PTX:204 mul.f32 %f176, %f22, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f176) : "f"(f22), "f"(f29));
  // PTX:205 mul.f32 %f177, %f23, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f177) : "f"(f23), "f"(f29));
  // PTX:206 mul.f32 %f178, %f24, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f178) : "f"(f24), "f"(f29));
  // PTX:207 fma.rn.f32 %f179, %f19, %f28, %f176
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f179) : "f"(f19), "f"(f28), "f"(f176));
  // PTX:208 fma.rn.f32 %f180, %f20, %f28, %f177
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f180) : "f"(f20), "f"(f28), "f"(f177));
  // PTX:209 fma.rn.f32 %f181, %f21, %f28, %f178
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f181) : "f"(f21), "f"(f28), "f"(f178));
  // PTX:210 fma.rn.f32 %f182, %f25, %f30, %f179
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f182) : "f"(f25), "f"(f30), "f"(f179));
  // PTX:211 fma.rn.f32 %f183, %f26, %f30, %f180
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f183) : "f"(f26), "f"(f30), "f"(f180));
  // PTX:212 fma.rn.f32 %f184, %f27, %f30, %f181
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f184) : "f"(f27), "f"(f30), "f"(f181));
  // PTX:213 mul.f32 %f185, %f29, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f185) : "f"(f29), "f"(f29));
  // PTX:214 fma.rn.f32 %f186, %f28, %f28, %f185
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f186) : "f"(f28), "f"(f28), "f"(f185));
  // PTX:215 fma.rn.f32 %f187, %f30, %f30, %f186
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f187) : "f"(f30), "f"(f30), "f"(f186));
  // PTX:216 mul.f32 %f188, %f31, %f187
  asm("mul.f32 %0, %1, %2;" : "=f"(f188) : "f"(f31), "f"(f187));
  // PTX:217 mul.f32 %f189, %f182, %f182
  asm("mul.f32 %0, %1, %2;" : "=f"(f189) : "f"(f182), "f"(f182));
  // PTX:218 mul.f32 %f190, %f183, %f182
  asm("mul.f32 %0, %1, %2;" : "=f"(f190) : "f"(f183), "f"(f182));
  // PTX:219 mul.f32 %f191, %f184, %f182
  asm("mul.f32 %0, %1, %2;" : "=f"(f191) : "f"(f184), "f"(f182));
  // PTX:220 mul.f32 %f192, %f183, %f183
  asm("mul.f32 %0, %1, %2;" : "=f"(f192) : "f"(f183), "f"(f183));
  // PTX:221 mul.f32 %f193, %f184, %f183
  asm("mul.f32 %0, %1, %2;" : "=f"(f193) : "f"(f184), "f"(f183));
  // PTX:222 mul.f32 %f194, %f184, %f184
  asm("mul.f32 %0, %1, %2;" : "=f"(f194) : "f"(f184), "f"(f184));
  // PTX:223 mul.f32 %f195, %f32, %f190
  asm("mul.f32 %0, %1, %2;" : "=f"(f195) : "f"(f32), "f"(f190));
  // PTX:224 mul.f32 %f196, %f32, %f191
  asm("mul.f32 %0, %1, %2;" : "=f"(f196) : "f"(f32), "f"(f191));
  // PTX:225 mul.f32 %f197, %f32, %f193
  asm("mul.f32 %0, %1, %2;" : "=f"(f197) : "f"(f32), "f"(f193));
  // PTX:226 fma.rn.f32 %f641, %f32, %f189, %f188
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f641) : "f"(f32), "f"(f189), "f"(f188));
  // PTX:227 fma.rn.f32 %f640, %f188, 0f00000000, %f195
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f640) : "f"(f188), "f"(f195));
  // PTX:228 fma.rn.f32 %f638, %f188, 0f00000000, %f196
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f638) : "f"(f188), "f"(f196));
  // PTX:229 fma.rn.f32 %f639, %f32, %f192, %f188
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f639) : "f"(f32), "f"(f192), "f"(f188));
  // PTX:230 fma.rn.f32 %f637, %f188, 0f00000000, %f197
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f637) : "f"(f188), "f"(f197));
  // PTX:231 fma.rn.f32 %f636, %f32, %f194, %f188
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f636) : "f"(f32), "f"(f194), "f"(f188));
  // PTX:232 @%p3 bra $L__BB59_6
  if (p3) { goto L_BB59_6; }
  // PTX:234 add.f32 %f198, %f28, %f28
  asm("add.f32 %0, %1, %2;" : "=f"(f198) : "f"(f28), "f"(f28));
  // PTX:235 mul.f32 %f199, %f4, %f198
  asm("mul.f32 %0, %1, %2;" : "=f"(f199) : "f"(f4), "f"(f198));
  // PTX:236 mul.f32 %f200, %f5, %f198
  asm("mul.f32 %0, %1, %2;" : "=f"(f200) : "f"(f5), "f"(f198));
  // PTX:237 mul.f32 %f201, %f6, %f198
  asm("mul.f32 %0, %1, %2;" : "=f"(f201) : "f"(f6), "f"(f198));
  // PTX:238 mul.f32 %f202, %f4, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f202) : "f"(f4), "f"(f29));
  // PTX:239 fma.rn.f32 %f203, %f10, %f28, %f202
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f203) : "f"(f10), "f"(f28), "f"(f202));
  // PTX:240 mul.f32 %f204, %f5, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f204) : "f"(f5), "f"(f29));
  // PTX:241 fma.rn.f32 %f205, %f11, %f28, %f204
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f205) : "f"(f11), "f"(f28), "f"(f204));
  // PTX:242 mul.f32 %f206, %f6, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f206) : "f"(f6), "f"(f29));
  // PTX:243 fma.rn.f32 %f207, %f12, %f28, %f206
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f207) : "f"(f12), "f"(f28), "f"(f206));
  // PTX:244 mul.f32 %f208, %f4, %f30
  asm("mul.f32 %0, %1, %2;" : "=f"(f208) : "f"(f4), "f"(f30));
  // PTX:245 fma.rn.f32 %f209, %f16, %f28, %f208
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f209) : "f"(f16), "f"(f28), "f"(f208));
  // PTX:246 mul.f32 %f210, %f5, %f30
  asm("mul.f32 %0, %1, %2;" : "=f"(f210) : "f"(f5), "f"(f30));
  // PTX:247 fma.rn.f32 %f211, %f17, %f28, %f210
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f211) : "f"(f17), "f"(f28), "f"(f210));
  // PTX:248 mul.f32 %f212, %f6, %f30
  asm("mul.f32 %0, %1, %2;" : "=f"(f212) : "f"(f6), "f"(f30));
  // PTX:249 fma.rn.f32 %f213, %f18, %f28, %f212
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f213) : "f"(f18), "f"(f28), "f"(f212));
  // PTX:250 add.f32 %f214, %f29, %f29
  asm("add.f32 %0, %1, %2;" : "=f"(f214) : "f"(f29), "f"(f29));
  // PTX:251 mul.f32 %f215, %f10, %f214
  asm("mul.f32 %0, %1, %2;" : "=f"(f215) : "f"(f10), "f"(f214));
  // PTX:252 mul.f32 %f216, %f11, %f214
  asm("mul.f32 %0, %1, %2;" : "=f"(f216) : "f"(f11), "f"(f214));
  // PTX:253 mul.f32 %f217, %f12, %f214
  asm("mul.f32 %0, %1, %2;" : "=f"(f217) : "f"(f12), "f"(f214));
  // PTX:254 mul.f32 %f218, %f10, %f30
  asm("mul.f32 %0, %1, %2;" : "=f"(f218) : "f"(f10), "f"(f30));
  // PTX:255 fma.rn.f32 %f219, %f16, %f29, %f218
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f219) : "f"(f16), "f"(f29), "f"(f218));
  // PTX:256 mul.f32 %f220, %f11, %f30
  asm("mul.f32 %0, %1, %2;" : "=f"(f220) : "f"(f11), "f"(f30));
  // PTX:257 fma.rn.f32 %f221, %f17, %f29, %f220
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f221) : "f"(f17), "f"(f29), "f"(f220));
  // PTX:258 mul.f32 %f222, %f12, %f30
  asm("mul.f32 %0, %1, %2;" : "=f"(f222) : "f"(f12), "f"(f30));
  // PTX:259 fma.rn.f32 %f223, %f18, %f29, %f222
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f223) : "f"(f18), "f"(f29), "f"(f222));
  // PTX:260 add.f32 %f224, %f30, %f30
  asm("add.f32 %0, %1, %2;" : "=f"(f224) : "f"(f30), "f"(f30));
  // PTX:261 mul.f32 %f225, %f16, %f224
  asm("mul.f32 %0, %1, %2;" : "=f"(f225) : "f"(f16), "f"(f224));
  // PTX:262 mul.f32 %f226, %f17, %f224
  asm("mul.f32 %0, %1, %2;" : "=f"(f226) : "f"(f17), "f"(f224));
  // PTX:263 mul.f32 %f227, %f18, %f224
  asm("mul.f32 %0, %1, %2;" : "=f"(f227) : "f"(f18), "f"(f224));
  // PTX:264 mul.f32 %f228, %f203, %f203
  asm("mul.f32 %0, %1, %2;" : "=f"(f228) : "f"(f203), "f"(f203));
  // PTX:265 mul.f32 %f229, %f205, %f203
  asm("mul.f32 %0, %1, %2;" : "=f"(f229) : "f"(f205), "f"(f203));
  // PTX:266 mul.f32 %f230, %f207, %f203
  asm("mul.f32 %0, %1, %2;" : "=f"(f230) : "f"(f207), "f"(f203));
  // PTX:267 mul.f32 %f231, %f205, %f205
  asm("mul.f32 %0, %1, %2;" : "=f"(f231) : "f"(f205), "f"(f205));
  // PTX:268 mul.f32 %f232, %f207, %f205
  asm("mul.f32 %0, %1, %2;" : "=f"(f232) : "f"(f207), "f"(f205));
  // PTX:269 mul.f32 %f233, %f207, %f207
  asm("mul.f32 %0, %1, %2;" : "=f"(f233) : "f"(f207), "f"(f207));
  // PTX:270 fma.rn.f32 %f234, %f203, %f203, %f228
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f234) : "f"(f203), "f"(f203), "f"(f228));
  // PTX:271 fma.rn.f32 %f235, %f205, %f203, %f229
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f235) : "f"(f205), "f"(f203), "f"(f229));
  // PTX:272 fma.rn.f32 %f236, %f207, %f203, %f230
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f236) : "f"(f207), "f"(f203), "f"(f230));
  // PTX:273 fma.rn.f32 %f237, %f205, %f205, %f231
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f237) : "f"(f205), "f"(f205), "f"(f231));
  // PTX:274 fma.rn.f32 %f238, %f207, %f205, %f232
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f238) : "f"(f207), "f"(f205), "f"(f232));
  // PTX:275 fma.rn.f32 %f239, %f207, %f207, %f233
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f239) : "f"(f207), "f"(f207), "f"(f233));
  // PTX:276 fma.rn.f32 %f240, %f199, %f199, %f234
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f240) : "f"(f199), "f"(f199), "f"(f234));
  // PTX:277 fma.rn.f32 %f241, %f200, %f199, %f235
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f241) : "f"(f200), "f"(f199), "f"(f235));
  // PTX:278 fma.rn.f32 %f242, %f201, %f199, %f236
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f242) : "f"(f201), "f"(f199), "f"(f236));
  // PTX:279 fma.rn.f32 %f243, %f200, %f200, %f237
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f243) : "f"(f200), "f"(f200), "f"(f237));
  // PTX:280 fma.rn.f32 %f244, %f201, %f200, %f238
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f244) : "f"(f201), "f"(f200), "f"(f238));
  // PTX:281 fma.rn.f32 %f245, %f201, %f201, %f239
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f245) : "f"(f201), "f"(f201), "f"(f239));
  // PTX:282 mul.f32 %f246, %f209, %f209
  asm("mul.f32 %0, %1, %2;" : "=f"(f246) : "f"(f209), "f"(f209));
  // PTX:283 mul.f32 %f247, %f211, %f209
  asm("mul.f32 %0, %1, %2;" : "=f"(f247) : "f"(f211), "f"(f209));
  // PTX:284 mul.f32 %f248, %f213, %f209
  asm("mul.f32 %0, %1, %2;" : "=f"(f248) : "f"(f213), "f"(f209));
  // PTX:285 mul.f32 %f249, %f211, %f211
  asm("mul.f32 %0, %1, %2;" : "=f"(f249) : "f"(f211), "f"(f211));
  // PTX:286 mul.f32 %f250, %f213, %f211
  asm("mul.f32 %0, %1, %2;" : "=f"(f250) : "f"(f213), "f"(f211));
  // PTX:287 mul.f32 %f251, %f213, %f213
  asm("mul.f32 %0, %1, %2;" : "=f"(f251) : "f"(f213), "f"(f213));
  // PTX:288 fma.rn.f32 %f252, %f246, 0f40000000, %f240
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f252) : "f"(f246), "f"(f240));
  // PTX:289 fma.rn.f32 %f253, %f247, 0f40000000, %f241
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f253) : "f"(f247), "f"(f241));
  // PTX:290 fma.rn.f32 %f254, %f248, 0f40000000, %f242
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f254) : "f"(f248), "f"(f242));
  // PTX:291 fma.rn.f32 %f255, %f249, 0f40000000, %f243
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f255) : "f"(f249), "f"(f243));
  // PTX:292 fma.rn.f32 %f256, %f250, 0f40000000, %f244
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f256) : "f"(f250), "f"(f244));
  // PTX:293 fma.rn.f32 %f257, %f251, 0f40000000, %f245
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f257) : "f"(f251), "f"(f245));
  // PTX:294 fma.rn.f32 %f258, %f215, %f215, %f252
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f258) : "f"(f215), "f"(f215), "f"(f252));
  // PTX:295 fma.rn.f32 %f259, %f216, %f215, %f253
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f259) : "f"(f216), "f"(f215), "f"(f253));
  // PTX:296 fma.rn.f32 %f260, %f217, %f215, %f254
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f260) : "f"(f217), "f"(f215), "f"(f254));
  // PTX:297 fma.rn.f32 %f261, %f216, %f216, %f255
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f261) : "f"(f216), "f"(f216), "f"(f255));
  // PTX:298 fma.rn.f32 %f262, %f217, %f216, %f256
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f262) : "f"(f217), "f"(f216), "f"(f256));
  // PTX:299 fma.rn.f32 %f263, %f217, %f217, %f257
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f263) : "f"(f217), "f"(f217), "f"(f257));
  // PTX:300 mul.f32 %f264, %f219, %f219
  asm("mul.f32 %0, %1, %2;" : "=f"(f264) : "f"(f219), "f"(f219));
  // PTX:301 mul.f32 %f265, %f221, %f219
  asm("mul.f32 %0, %1, %2;" : "=f"(f265) : "f"(f221), "f"(f219));
  // PTX:302 mul.f32 %f266, %f223, %f219
  asm("mul.f32 %0, %1, %2;" : "=f"(f266) : "f"(f223), "f"(f219));
  // PTX:303 mul.f32 %f267, %f221, %f221
  asm("mul.f32 %0, %1, %2;" : "=f"(f267) : "f"(f221), "f"(f221));
  // PTX:304 mul.f32 %f268, %f223, %f221
  asm("mul.f32 %0, %1, %2;" : "=f"(f268) : "f"(f223), "f"(f221));
  // PTX:305 mul.f32 %f269, %f223, %f223
  asm("mul.f32 %0, %1, %2;" : "=f"(f269) : "f"(f223), "f"(f223));
  // PTX:306 fma.rn.f32 %f270, %f264, 0f40000000, %f258
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f270) : "f"(f264), "f"(f258));
  // PTX:307 fma.rn.f32 %f271, %f265, 0f40000000, %f259
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f271) : "f"(f265), "f"(f259));
  // PTX:308 fma.rn.f32 %f272, %f266, 0f40000000, %f260
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f272) : "f"(f266), "f"(f260));
  // PTX:309 fma.rn.f32 %f273, %f267, 0f40000000, %f261
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f273) : "f"(f267), "f"(f261));
  // PTX:310 fma.rn.f32 %f274, %f268, 0f40000000, %f262
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f274) : "f"(f268), "f"(f262));
  // PTX:311 fma.rn.f32 %f275, %f269, 0f40000000, %f263
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f275) : "f"(f269), "f"(f263));
  // PTX:312 fma.rn.f32 %f276, %f225, %f225, %f270
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f276) : "f"(f225), "f"(f225), "f"(f270));
  // PTX:313 fma.rn.f32 %f277, %f226, %f225, %f271
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f277) : "f"(f226), "f"(f225), "f"(f271));
  // PTX:314 fma.rn.f32 %f278, %f227, %f225, %f272
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f278) : "f"(f227), "f"(f225), "f"(f272));
  // PTX:315 fma.rn.f32 %f279, %f226, %f226, %f273
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f279) : "f"(f226), "f"(f226), "f"(f273));
  // PTX:316 fma.rn.f32 %f280, %f227, %f226, %f274
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f280) : "f"(f227), "f"(f226), "f"(f274));
  // PTX:317 fma.rn.f32 %f281, %f227, %f227, %f275
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f281) : "f"(f227), "f"(f227), "f"(f275));
  // PTX:318 fma.rn.f32 %f641, %f34, %f276, %f641
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f641) : "f"(f34), "f"(f276), "f"(f641));
  // PTX:319 fma.rn.f32 %f640, %f34, %f277, %f640
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f640) : "f"(f34), "f"(f277), "f"(f640));
  // PTX:320 fma.rn.f32 %f638, %f34, %f278, %f638
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f638) : "f"(f34), "f"(f278), "f"(f638));
  // PTX:321 fma.rn.f32 %f639, %f34, %f279, %f639
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f639) : "f"(f34), "f"(f279), "f"(f639));
  // PTX:322 fma.rn.f32 %f637, %f34, %f280, %f637
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f637) : "f"(f34), "f"(f280), "f"(f637));
  // PTX:323 fma.rn.f32 %f636, %f34, %f281, %f636
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f636) : "f"(f34), "f"(f281), "f"(f636));
  // PTX:325 $L__BB59_6:
L_BB59_6:;
  // PTX:326 mul.lo.s64 %rd49, %rd9, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd49) : "l"(rd9));
  // PTX:327 add.s64 %rd50, %rd1, %rd49
  asm("add.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd1), "l"(rd49));
  // PTX:328 red.global.add.f32 [%rd50], %f641
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (0)))), (float)(f641));
  // PTX:329 add.s64 %rd51, %rd50, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd51) : "l"(rd50));
  // PTX:330 red.global.add.f32 [%rd51], %f640
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))), (float)(f640));
  // PTX:331 add.s64 %rd52, %rd50, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd52) : "l"(rd50));
  // PTX:332 red.global.add.f32 [%rd52], %f638
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))), (float)(f638));
  // PTX:333 add.s64 %rd53, %rd50, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd53) : "l"(rd50));
  // PTX:334 red.global.add.f32 [%rd53], %f640
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))), (float)(f640));
  // PTX:335 add.s64 %rd54, %rd50, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd54) : "l"(rd50));
  // PTX:336 red.global.add.f32 [%rd54], %f639
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))), (float)(f639));
  // PTX:337 add.s64 %rd55, %rd50, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd55) : "l"(rd50));
  // PTX:338 red.global.add.f32 [%rd55], %f637
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))), (float)(f637));
  // PTX:339 add.s64 %rd56, %rd50, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd56) : "l"(rd50));
  // PTX:340 red.global.add.f32 [%rd56], %f638
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))), (float)(f638));
  // PTX:341 add.s64 %rd57, %rd50, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd57) : "l"(rd50));
  // PTX:342 red.global.add.f32 [%rd57], %f637
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))), (float)(f637));
  // PTX:343 add.s64 %rd58, %rd50, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd58) : "l"(rd50));
  // PTX:344 red.global.add.f32 [%rd58], %f636
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (0)))), (float)(f636));
  // PTX:345 mul.f32 %f291, %f22, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f291) : "f"(f22), "f"(f7));
  // PTX:346 fma.rn.f32 %f292, %f19, %f1, %f291
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f292) : "f"(f19), "f"(f1), "f"(f291));
  // PTX:347 mul.f32 %f293, %f23, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f293) : "f"(f23), "f"(f7));
  // PTX:348 fma.rn.f32 %f294, %f20, %f1, %f293
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f294) : "f"(f20), "f"(f1), "f"(f293));
  // PTX:349 mul.f32 %f295, %f24, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f295) : "f"(f24), "f"(f7));
  // PTX:350 fma.rn.f32 %f296, %f21, %f1, %f295
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f296) : "f"(f21), "f"(f1), "f"(f295));
  // PTX:351 fma.rn.f32 %f297, %f25, %f13, %f292
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f297) : "f"(f25), "f"(f13), "f"(f292));
  // PTX:352 fma.rn.f32 %f298, %f26, %f13, %f294
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f298) : "f"(f26), "f"(f13), "f"(f294));
  // PTX:353 fma.rn.f32 %f299, %f27, %f13, %f296
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f299) : "f"(f27), "f"(f13), "f"(f296));
  // PTX:354 mul.f32 %f300, %f7, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f300) : "f"(f7), "f"(f7));
  // PTX:355 fma.rn.f32 %f301, %f1, %f1, %f300
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f301) : "f"(f1), "f"(f1), "f"(f300));
  // PTX:356 fma.rn.f32 %f302, %f13, %f13, %f301
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f302) : "f"(f13), "f"(f13), "f"(f301));
  // PTX:357 mul.f32 %f303, %f31, %f302
  asm("mul.f32 %0, %1, %2;" : "=f"(f303) : "f"(f31), "f"(f302));
  // PTX:358 mul.f32 %f304, %f297, %f297
  asm("mul.f32 %0, %1, %2;" : "=f"(f304) : "f"(f297), "f"(f297));
  // PTX:359 mul.f32 %f305, %f298, %f297
  asm("mul.f32 %0, %1, %2;" : "=f"(f305) : "f"(f298), "f"(f297));
  // PTX:360 mul.f32 %f306, %f299, %f297
  asm("mul.f32 %0, %1, %2;" : "=f"(f306) : "f"(f299), "f"(f297));
  // PTX:361 mul.f32 %f307, %f298, %f298
  asm("mul.f32 %0, %1, %2;" : "=f"(f307) : "f"(f298), "f"(f298));
  // PTX:362 mul.f32 %f308, %f299, %f298
  asm("mul.f32 %0, %1, %2;" : "=f"(f308) : "f"(f299), "f"(f298));
  // PTX:363 mul.f32 %f309, %f299, %f299
  asm("mul.f32 %0, %1, %2;" : "=f"(f309) : "f"(f299), "f"(f299));
  // PTX:364 mul.f32 %f310, %f32, %f305
  asm("mul.f32 %0, %1, %2;" : "=f"(f310) : "f"(f32), "f"(f305));
  // PTX:365 mul.f32 %f311, %f32, %f306
  asm("mul.f32 %0, %1, %2;" : "=f"(f311) : "f"(f32), "f"(f306));
  // PTX:366 mul.f32 %f312, %f32, %f308
  asm("mul.f32 %0, %1, %2;" : "=f"(f312) : "f"(f32), "f"(f308));
  // PTX:367 fma.rn.f32 %f647, %f32, %f304, %f303
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f647) : "f"(f32), "f"(f304), "f"(f303));
  // PTX:368 fma.rn.f32 %f646, %f303, 0f00000000, %f310
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f646) : "f"(f303), "f"(f310));
  // PTX:369 fma.rn.f32 %f644, %f303, 0f00000000, %f311
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f644) : "f"(f303), "f"(f311));
  // PTX:370 fma.rn.f32 %f645, %f32, %f307, %f303
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f645) : "f"(f32), "f"(f307), "f"(f303));
  // PTX:371 fma.rn.f32 %f643, %f303, 0f00000000, %f312
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f643) : "f"(f303), "f"(f312));
  // PTX:372 fma.rn.f32 %f642, %f32, %f309, %f303
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f642) : "f"(f32), "f"(f309), "f"(f303));
  // PTX:373 @%p3 bra $L__BB59_8
  if (p3) { goto L_BB59_8; }
  // PTX:375 add.f32 %f313, %f1, %f1
  asm("add.f32 %0, %1, %2;" : "=f"(f313) : "f"(f1), "f"(f1));
  // PTX:376 mul.f32 %f314, %f4, %f313
  asm("mul.f32 %0, %1, %2;" : "=f"(f314) : "f"(f4), "f"(f313));
  // PTX:377 mul.f32 %f315, %f5, %f313
  asm("mul.f32 %0, %1, %2;" : "=f"(f315) : "f"(f5), "f"(f313));
  // PTX:378 mul.f32 %f316, %f6, %f313
  asm("mul.f32 %0, %1, %2;" : "=f"(f316) : "f"(f6), "f"(f313));
  // PTX:379 mul.f32 %f317, %f4, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f317) : "f"(f4), "f"(f7));
  // PTX:380 fma.rn.f32 %f318, %f10, %f1, %f317
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f318) : "f"(f10), "f"(f1), "f"(f317));
  // PTX:381 mul.f32 %f319, %f5, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f319) : "f"(f5), "f"(f7));
  // PTX:382 fma.rn.f32 %f320, %f11, %f1, %f319
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f320) : "f"(f11), "f"(f1), "f"(f319));
  // PTX:383 mul.f32 %f321, %f6, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f321) : "f"(f6), "f"(f7));
  // PTX:384 fma.rn.f32 %f322, %f12, %f1, %f321
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f322) : "f"(f12), "f"(f1), "f"(f321));
  // PTX:385 mul.f32 %f323, %f4, %f13
  asm("mul.f32 %0, %1, %2;" : "=f"(f323) : "f"(f4), "f"(f13));
  // PTX:386 fma.rn.f32 %f324, %f16, %f1, %f323
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f324) : "f"(f16), "f"(f1), "f"(f323));
  // PTX:387 mul.f32 %f325, %f5, %f13
  asm("mul.f32 %0, %1, %2;" : "=f"(f325) : "f"(f5), "f"(f13));
  // PTX:388 fma.rn.f32 %f326, %f17, %f1, %f325
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f326) : "f"(f17), "f"(f1), "f"(f325));
  // PTX:389 mul.f32 %f327, %f6, %f13
  asm("mul.f32 %0, %1, %2;" : "=f"(f327) : "f"(f6), "f"(f13));
  // PTX:390 fma.rn.f32 %f328, %f18, %f1, %f327
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f328) : "f"(f18), "f"(f1), "f"(f327));
  // PTX:391 add.f32 %f329, %f7, %f7
  asm("add.f32 %0, %1, %2;" : "=f"(f329) : "f"(f7), "f"(f7));
  // PTX:392 mul.f32 %f330, %f10, %f329
  asm("mul.f32 %0, %1, %2;" : "=f"(f330) : "f"(f10), "f"(f329));
  // PTX:393 mul.f32 %f331, %f11, %f329
  asm("mul.f32 %0, %1, %2;" : "=f"(f331) : "f"(f11), "f"(f329));
  // PTX:394 mul.f32 %f332, %f12, %f329
  asm("mul.f32 %0, %1, %2;" : "=f"(f332) : "f"(f12), "f"(f329));
  // PTX:395 mul.f32 %f333, %f10, %f13
  asm("mul.f32 %0, %1, %2;" : "=f"(f333) : "f"(f10), "f"(f13));
  // PTX:396 fma.rn.f32 %f334, %f16, %f7, %f333
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f334) : "f"(f16), "f"(f7), "f"(f333));
  // PTX:397 mul.f32 %f335, %f11, %f13
  asm("mul.f32 %0, %1, %2;" : "=f"(f335) : "f"(f11), "f"(f13));
  // PTX:398 fma.rn.f32 %f336, %f17, %f7, %f335
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f336) : "f"(f17), "f"(f7), "f"(f335));
  // PTX:399 mul.f32 %f337, %f12, %f13
  asm("mul.f32 %0, %1, %2;" : "=f"(f337) : "f"(f12), "f"(f13));
  // PTX:400 fma.rn.f32 %f338, %f18, %f7, %f337
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f338) : "f"(f18), "f"(f7), "f"(f337));
  // PTX:401 add.f32 %f339, %f13, %f13
  asm("add.f32 %0, %1, %2;" : "=f"(f339) : "f"(f13), "f"(f13));
  // PTX:402 mul.f32 %f340, %f16, %f339
  asm("mul.f32 %0, %1, %2;" : "=f"(f340) : "f"(f16), "f"(f339));
  // PTX:403 mul.f32 %f341, %f17, %f339
  asm("mul.f32 %0, %1, %2;" : "=f"(f341) : "f"(f17), "f"(f339));
  // PTX:404 mul.f32 %f342, %f18, %f339
  asm("mul.f32 %0, %1, %2;" : "=f"(f342) : "f"(f18), "f"(f339));
  // PTX:405 mul.f32 %f343, %f318, %f318
  asm("mul.f32 %0, %1, %2;" : "=f"(f343) : "f"(f318), "f"(f318));
  // PTX:406 mul.f32 %f344, %f320, %f318
  asm("mul.f32 %0, %1, %2;" : "=f"(f344) : "f"(f320), "f"(f318));
  // PTX:407 mul.f32 %f345, %f322, %f318
  asm("mul.f32 %0, %1, %2;" : "=f"(f345) : "f"(f322), "f"(f318));
  // PTX:408 mul.f32 %f346, %f320, %f320
  asm("mul.f32 %0, %1, %2;" : "=f"(f346) : "f"(f320), "f"(f320));
  // PTX:409 mul.f32 %f347, %f322, %f320
  asm("mul.f32 %0, %1, %2;" : "=f"(f347) : "f"(f322), "f"(f320));
  // PTX:410 mul.f32 %f348, %f322, %f322
  asm("mul.f32 %0, %1, %2;" : "=f"(f348) : "f"(f322), "f"(f322));
  // PTX:411 fma.rn.f32 %f349, %f318, %f318, %f343
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f349) : "f"(f318), "f"(f318), "f"(f343));
  // PTX:412 fma.rn.f32 %f350, %f320, %f318, %f344
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f350) : "f"(f320), "f"(f318), "f"(f344));
  // PTX:413 fma.rn.f32 %f351, %f322, %f318, %f345
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f351) : "f"(f322), "f"(f318), "f"(f345));
  // PTX:414 fma.rn.f32 %f352, %f320, %f320, %f346
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f352) : "f"(f320), "f"(f320), "f"(f346));
  // PTX:415 fma.rn.f32 %f353, %f322, %f320, %f347
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f353) : "f"(f322), "f"(f320), "f"(f347));
  // PTX:416 fma.rn.f32 %f354, %f322, %f322, %f348
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f354) : "f"(f322), "f"(f322), "f"(f348));
  // PTX:417 fma.rn.f32 %f355, %f314, %f314, %f349
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f355) : "f"(f314), "f"(f314), "f"(f349));
  // PTX:418 fma.rn.f32 %f356, %f315, %f314, %f350
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f356) : "f"(f315), "f"(f314), "f"(f350));
  // PTX:419 fma.rn.f32 %f357, %f316, %f314, %f351
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f357) : "f"(f316), "f"(f314), "f"(f351));
  // PTX:420 fma.rn.f32 %f358, %f315, %f315, %f352
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f358) : "f"(f315), "f"(f315), "f"(f352));
  // PTX:421 fma.rn.f32 %f359, %f316, %f315, %f353
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f359) : "f"(f316), "f"(f315), "f"(f353));
  // PTX:422 fma.rn.f32 %f360, %f316, %f316, %f354
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f360) : "f"(f316), "f"(f316), "f"(f354));
  // PTX:423 mul.f32 %f361, %f324, %f324
  asm("mul.f32 %0, %1, %2;" : "=f"(f361) : "f"(f324), "f"(f324));
  // PTX:424 mul.f32 %f362, %f326, %f324
  asm("mul.f32 %0, %1, %2;" : "=f"(f362) : "f"(f326), "f"(f324));
  // PTX:425 mul.f32 %f363, %f328, %f324
  asm("mul.f32 %0, %1, %2;" : "=f"(f363) : "f"(f328), "f"(f324));
  // PTX:426 mul.f32 %f364, %f326, %f326
  asm("mul.f32 %0, %1, %2;" : "=f"(f364) : "f"(f326), "f"(f326));
  // PTX:427 mul.f32 %f365, %f328, %f326
  asm("mul.f32 %0, %1, %2;" : "=f"(f365) : "f"(f328), "f"(f326));
  // PTX:428 mul.f32 %f366, %f328, %f328
  asm("mul.f32 %0, %1, %2;" : "=f"(f366) : "f"(f328), "f"(f328));
  // PTX:429 fma.rn.f32 %f367, %f361, 0f40000000, %f355
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f367) : "f"(f361), "f"(f355));
  // PTX:430 fma.rn.f32 %f368, %f362, 0f40000000, %f356
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f368) : "f"(f362), "f"(f356));
  // PTX:431 fma.rn.f32 %f369, %f363, 0f40000000, %f357
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f369) : "f"(f363), "f"(f357));
  // PTX:432 fma.rn.f32 %f370, %f364, 0f40000000, %f358
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f370) : "f"(f364), "f"(f358));
  // PTX:433 fma.rn.f32 %f371, %f365, 0f40000000, %f359
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f371) : "f"(f365), "f"(f359));
  // PTX:434 fma.rn.f32 %f372, %f366, 0f40000000, %f360
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f372) : "f"(f366), "f"(f360));
  // PTX:435 fma.rn.f32 %f373, %f330, %f330, %f367
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f373) : "f"(f330), "f"(f330), "f"(f367));
  // PTX:436 fma.rn.f32 %f374, %f331, %f330, %f368
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f374) : "f"(f331), "f"(f330), "f"(f368));
  // PTX:437 fma.rn.f32 %f375, %f332, %f330, %f369
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f375) : "f"(f332), "f"(f330), "f"(f369));
  // PTX:438 fma.rn.f32 %f376, %f331, %f331, %f370
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f376) : "f"(f331), "f"(f331), "f"(f370));
  // PTX:439 fma.rn.f32 %f377, %f332, %f331, %f371
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f377) : "f"(f332), "f"(f331), "f"(f371));
  // PTX:440 fma.rn.f32 %f378, %f332, %f332, %f372
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f378) : "f"(f332), "f"(f332), "f"(f372));
  // PTX:441 mul.f32 %f379, %f334, %f334
  asm("mul.f32 %0, %1, %2;" : "=f"(f379) : "f"(f334), "f"(f334));
  // PTX:442 mul.f32 %f380, %f336, %f334
  asm("mul.f32 %0, %1, %2;" : "=f"(f380) : "f"(f336), "f"(f334));
  // PTX:443 mul.f32 %f381, %f338, %f334
  asm("mul.f32 %0, %1, %2;" : "=f"(f381) : "f"(f338), "f"(f334));
  // PTX:444 mul.f32 %f382, %f336, %f336
  asm("mul.f32 %0, %1, %2;" : "=f"(f382) : "f"(f336), "f"(f336));
  // PTX:445 mul.f32 %f383, %f338, %f336
  asm("mul.f32 %0, %1, %2;" : "=f"(f383) : "f"(f338), "f"(f336));
  // PTX:446 mul.f32 %f384, %f338, %f338
  asm("mul.f32 %0, %1, %2;" : "=f"(f384) : "f"(f338), "f"(f338));
  // PTX:447 fma.rn.f32 %f385, %f379, 0f40000000, %f373
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f385) : "f"(f379), "f"(f373));
  // PTX:448 fma.rn.f32 %f386, %f380, 0f40000000, %f374
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f386) : "f"(f380), "f"(f374));
  // PTX:449 fma.rn.f32 %f387, %f381, 0f40000000, %f375
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f387) : "f"(f381), "f"(f375));
  // PTX:450 fma.rn.f32 %f388, %f382, 0f40000000, %f376
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f388) : "f"(f382), "f"(f376));
  // PTX:451 fma.rn.f32 %f389, %f383, 0f40000000, %f377
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f389) : "f"(f383), "f"(f377));
  // PTX:452 fma.rn.f32 %f390, %f384, 0f40000000, %f378
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f390) : "f"(f384), "f"(f378));
  // PTX:453 fma.rn.f32 %f391, %f340, %f340, %f385
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f391) : "f"(f340), "f"(f340), "f"(f385));
  // PTX:454 fma.rn.f32 %f392, %f341, %f340, %f386
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f392) : "f"(f341), "f"(f340), "f"(f386));
  // PTX:455 fma.rn.f32 %f393, %f342, %f340, %f387
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f393) : "f"(f342), "f"(f340), "f"(f387));
  // PTX:456 fma.rn.f32 %f394, %f341, %f341, %f388
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f394) : "f"(f341), "f"(f341), "f"(f388));
  // PTX:457 fma.rn.f32 %f395, %f342, %f341, %f389
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f395) : "f"(f342), "f"(f341), "f"(f389));
  // PTX:458 fma.rn.f32 %f396, %f342, %f342, %f390
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f396) : "f"(f342), "f"(f342), "f"(f390));
  // PTX:459 fma.rn.f32 %f647, %f34, %f391, %f647
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f647) : "f"(f34), "f"(f391), "f"(f647));
  // PTX:460 fma.rn.f32 %f646, %f34, %f392, %f646
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f646) : "f"(f34), "f"(f392), "f"(f646));
  // PTX:461 fma.rn.f32 %f644, %f34, %f393, %f644
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f644) : "f"(f34), "f"(f393), "f"(f644));
  // PTX:462 fma.rn.f32 %f645, %f34, %f394, %f645
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f645) : "f"(f34), "f"(f394), "f"(f645));
  // PTX:463 fma.rn.f32 %f643, %f34, %f395, %f643
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f643) : "f"(f34), "f"(f395), "f"(f643));
  // PTX:464 fma.rn.f32 %f642, %f34, %f396, %f642
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f642) : "f"(f34), "f"(f396), "f"(f642));
  // PTX:466 $L__BB59_8:
L_BB59_8:;
  // PTX:467 mul.lo.s64 %rd59, %rd10, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd59) : "l"(rd10));
  // PTX:468 add.s64 %rd60, %rd1, %rd59
  asm("add.s64 %0, %1, %2;" : "=l"(rd60) : "l"(rd1), "l"(rd59));
  // PTX:469 red.global.add.f32 [%rd60], %f647
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))), (float)(f647));
  // PTX:470 add.s64 %rd61, %rd60, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd61) : "l"(rd60));
  // PTX:471 red.global.add.f32 [%rd61], %f646
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))), (float)(f646));
  // PTX:472 add.s64 %rd62, %rd60, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd62) : "l"(rd60));
  // PTX:473 red.global.add.f32 [%rd62], %f644
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))), (float)(f644));
  // PTX:474 add.s64 %rd63, %rd60, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd63) : "l"(rd60));
  // PTX:475 red.global.add.f32 [%rd63], %f646
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (0)))), (float)(f646));
  // PTX:476 add.s64 %rd64, %rd60, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd64) : "l"(rd60));
  // PTX:477 red.global.add.f32 [%rd64], %f645
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (0)))), (float)(f645));
  // PTX:478 add.s64 %rd65, %rd60, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd65) : "l"(rd60));
  // PTX:479 red.global.add.f32 [%rd65], %f643
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (0)))), (float)(f643));
  // PTX:480 add.s64 %rd66, %rd60, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd66) : "l"(rd60));
  // PTX:481 red.global.add.f32 [%rd66], %f644
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (0)))), (float)(f644));
  // PTX:482 add.s64 %rd67, %rd60, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd67) : "l"(rd60));
  // PTX:483 red.global.add.f32 [%rd67], %f643
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0)))), (float)(f643));
  // PTX:484 add.s64 %rd68, %rd60, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd68) : "l"(rd60));
  // PTX:485 red.global.add.f32 [%rd68], %f642
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (0)))), (float)(f642));
  // PTX:486 mul.f32 %f406, %f22, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f406) : "f"(f22), "f"(f8));
  // PTX:487 fma.rn.f32 %f407, %f19, %f2, %f406
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f407) : "f"(f19), "f"(f2), "f"(f406));
  // PTX:488 mul.f32 %f408, %f23, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f408) : "f"(f23), "f"(f8));
  // PTX:489 fma.rn.f32 %f409, %f20, %f2, %f408
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f409) : "f"(f20), "f"(f2), "f"(f408));
  // PTX:490 mul.f32 %f410, %f24, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f410) : "f"(f24), "f"(f8));
  // PTX:491 fma.rn.f32 %f411, %f21, %f2, %f410
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f411) : "f"(f21), "f"(f2), "f"(f410));
  // PTX:492 fma.rn.f32 %f412, %f25, %f14, %f407
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f412) : "f"(f25), "f"(f14), "f"(f407));
  // PTX:493 fma.rn.f32 %f413, %f26, %f14, %f409
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f413) : "f"(f26), "f"(f14), "f"(f409));
  // PTX:494 fma.rn.f32 %f414, %f27, %f14, %f411
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f414) : "f"(f27), "f"(f14), "f"(f411));
  // PTX:495 mul.f32 %f415, %f8, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f415) : "f"(f8), "f"(f8));
  // PTX:496 fma.rn.f32 %f416, %f2, %f2, %f415
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f416) : "f"(f2), "f"(f2), "f"(f415));
  // PTX:497 fma.rn.f32 %f417, %f14, %f14, %f416
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f417) : "f"(f14), "f"(f14), "f"(f416));
  // PTX:498 mul.f32 %f418, %f31, %f417
  asm("mul.f32 %0, %1, %2;" : "=f"(f418) : "f"(f31), "f"(f417));
  // PTX:499 mul.f32 %f419, %f412, %f412
  asm("mul.f32 %0, %1, %2;" : "=f"(f419) : "f"(f412), "f"(f412));
  // PTX:500 mul.f32 %f420, %f413, %f412
  asm("mul.f32 %0, %1, %2;" : "=f"(f420) : "f"(f413), "f"(f412));
  // PTX:501 mul.f32 %f421, %f414, %f412
  asm("mul.f32 %0, %1, %2;" : "=f"(f421) : "f"(f414), "f"(f412));
  // PTX:502 mul.f32 %f422, %f413, %f413
  asm("mul.f32 %0, %1, %2;" : "=f"(f422) : "f"(f413), "f"(f413));
  // PTX:503 mul.f32 %f423, %f414, %f413
  asm("mul.f32 %0, %1, %2;" : "=f"(f423) : "f"(f414), "f"(f413));
  // PTX:504 mul.f32 %f424, %f414, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f424) : "f"(f414), "f"(f414));
  // PTX:505 mul.f32 %f425, %f32, %f420
  asm("mul.f32 %0, %1, %2;" : "=f"(f425) : "f"(f32), "f"(f420));
  // PTX:506 mul.f32 %f426, %f32, %f421
  asm("mul.f32 %0, %1, %2;" : "=f"(f426) : "f"(f32), "f"(f421));
  // PTX:507 mul.f32 %f427, %f32, %f423
  asm("mul.f32 %0, %1, %2;" : "=f"(f427) : "f"(f32), "f"(f423));
  // PTX:508 fma.rn.f32 %f653, %f32, %f419, %f418
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f653) : "f"(f32), "f"(f419), "f"(f418));
  // PTX:509 fma.rn.f32 %f652, %f418, 0f00000000, %f425
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f652) : "f"(f418), "f"(f425));
  // PTX:510 fma.rn.f32 %f650, %f418, 0f00000000, %f426
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f650) : "f"(f418), "f"(f426));
  // PTX:511 fma.rn.f32 %f651, %f32, %f422, %f418
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f651) : "f"(f32), "f"(f422), "f"(f418));
  // PTX:512 fma.rn.f32 %f649, %f418, 0f00000000, %f427
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f649) : "f"(f418), "f"(f427));
  // PTX:513 fma.rn.f32 %f648, %f32, %f424, %f418
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f648) : "f"(f32), "f"(f424), "f"(f418));
  // PTX:514 @%p3 bra $L__BB59_10
  if (p3) { goto L_BB59_10; }
  // PTX:516 add.f32 %f428, %f2, %f2
  asm("add.f32 %0, %1, %2;" : "=f"(f428) : "f"(f2), "f"(f2));
  // PTX:517 mul.f32 %f429, %f4, %f428
  asm("mul.f32 %0, %1, %2;" : "=f"(f429) : "f"(f4), "f"(f428));
  // PTX:518 mul.f32 %f430, %f5, %f428
  asm("mul.f32 %0, %1, %2;" : "=f"(f430) : "f"(f5), "f"(f428));
  // PTX:519 mul.f32 %f431, %f6, %f428
  asm("mul.f32 %0, %1, %2;" : "=f"(f431) : "f"(f6), "f"(f428));
  // PTX:520 mul.f32 %f432, %f4, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f432) : "f"(f4), "f"(f8));
  // PTX:521 fma.rn.f32 %f433, %f10, %f2, %f432
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f433) : "f"(f10), "f"(f2), "f"(f432));
  // PTX:522 mul.f32 %f434, %f5, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f434) : "f"(f5), "f"(f8));
  // PTX:523 fma.rn.f32 %f435, %f11, %f2, %f434
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f435) : "f"(f11), "f"(f2), "f"(f434));
  // PTX:524 mul.f32 %f436, %f6, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f436) : "f"(f6), "f"(f8));
  // PTX:525 fma.rn.f32 %f437, %f12, %f2, %f436
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f437) : "f"(f12), "f"(f2), "f"(f436));
  // PTX:526 mul.f32 %f438, %f4, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f438) : "f"(f4), "f"(f14));
  // PTX:527 fma.rn.f32 %f439, %f16, %f2, %f438
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f439) : "f"(f16), "f"(f2), "f"(f438));
  // PTX:528 mul.f32 %f440, %f5, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f440) : "f"(f5), "f"(f14));
  // PTX:529 fma.rn.f32 %f441, %f17, %f2, %f440
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f441) : "f"(f17), "f"(f2), "f"(f440));
  // PTX:530 mul.f32 %f442, %f6, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f442) : "f"(f6), "f"(f14));
  // PTX:531 fma.rn.f32 %f443, %f18, %f2, %f442
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f443) : "f"(f18), "f"(f2), "f"(f442));
  // PTX:532 add.f32 %f444, %f8, %f8
  asm("add.f32 %0, %1, %2;" : "=f"(f444) : "f"(f8), "f"(f8));
  // PTX:533 mul.f32 %f445, %f10, %f444
  asm("mul.f32 %0, %1, %2;" : "=f"(f445) : "f"(f10), "f"(f444));
  // PTX:534 mul.f32 %f446, %f11, %f444
  asm("mul.f32 %0, %1, %2;" : "=f"(f446) : "f"(f11), "f"(f444));
  // PTX:535 mul.f32 %f447, %f12, %f444
  asm("mul.f32 %0, %1, %2;" : "=f"(f447) : "f"(f12), "f"(f444));
  // PTX:536 mul.f32 %f448, %f10, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f448) : "f"(f10), "f"(f14));
  // PTX:537 fma.rn.f32 %f449, %f16, %f8, %f448
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f449) : "f"(f16), "f"(f8), "f"(f448));
  // PTX:538 mul.f32 %f450, %f11, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f450) : "f"(f11), "f"(f14));
  // PTX:539 fma.rn.f32 %f451, %f17, %f8, %f450
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f451) : "f"(f17), "f"(f8), "f"(f450));
  // PTX:540 mul.f32 %f452, %f12, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f452) : "f"(f12), "f"(f14));
  // PTX:541 fma.rn.f32 %f453, %f18, %f8, %f452
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f453) : "f"(f18), "f"(f8), "f"(f452));
  // PTX:542 add.f32 %f454, %f14, %f14
  asm("add.f32 %0, %1, %2;" : "=f"(f454) : "f"(f14), "f"(f14));
  // PTX:543 mul.f32 %f455, %f16, %f454
  asm("mul.f32 %0, %1, %2;" : "=f"(f455) : "f"(f16), "f"(f454));
  // PTX:544 mul.f32 %f456, %f17, %f454
  asm("mul.f32 %0, %1, %2;" : "=f"(f456) : "f"(f17), "f"(f454));
  // PTX:545 mul.f32 %f457, %f18, %f454
  asm("mul.f32 %0, %1, %2;" : "=f"(f457) : "f"(f18), "f"(f454));
  // PTX:546 mul.f32 %f458, %f433, %f433
  asm("mul.f32 %0, %1, %2;" : "=f"(f458) : "f"(f433), "f"(f433));
  // PTX:547 mul.f32 %f459, %f435, %f433
  asm("mul.f32 %0, %1, %2;" : "=f"(f459) : "f"(f435), "f"(f433));
  // PTX:548 mul.f32 %f460, %f437, %f433
  asm("mul.f32 %0, %1, %2;" : "=f"(f460) : "f"(f437), "f"(f433));
  // PTX:549 mul.f32 %f461, %f435, %f435
  asm("mul.f32 %0, %1, %2;" : "=f"(f461) : "f"(f435), "f"(f435));
  // PTX:550 mul.f32 %f462, %f437, %f435
  asm("mul.f32 %0, %1, %2;" : "=f"(f462) : "f"(f437), "f"(f435));
  // PTX:551 mul.f32 %f463, %f437, %f437
  asm("mul.f32 %0, %1, %2;" : "=f"(f463) : "f"(f437), "f"(f437));
  // PTX:552 fma.rn.f32 %f464, %f433, %f433, %f458
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f464) : "f"(f433), "f"(f433), "f"(f458));
  // PTX:553 fma.rn.f32 %f465, %f435, %f433, %f459
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f465) : "f"(f435), "f"(f433), "f"(f459));
  // PTX:554 fma.rn.f32 %f466, %f437, %f433, %f460
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f466) : "f"(f437), "f"(f433), "f"(f460));
  // PTX:555 fma.rn.f32 %f467, %f435, %f435, %f461
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f467) : "f"(f435), "f"(f435), "f"(f461));
  // PTX:556 fma.rn.f32 %f468, %f437, %f435, %f462
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f468) : "f"(f437), "f"(f435), "f"(f462));
  // PTX:557 fma.rn.f32 %f469, %f437, %f437, %f463
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f469) : "f"(f437), "f"(f437), "f"(f463));
  // PTX:558 fma.rn.f32 %f470, %f429, %f429, %f464
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f470) : "f"(f429), "f"(f429), "f"(f464));
  // PTX:559 fma.rn.f32 %f471, %f430, %f429, %f465
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f471) : "f"(f430), "f"(f429), "f"(f465));
  // PTX:560 fma.rn.f32 %f472, %f431, %f429, %f466
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f472) : "f"(f431), "f"(f429), "f"(f466));
  // PTX:561 fma.rn.f32 %f473, %f430, %f430, %f467
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f473) : "f"(f430), "f"(f430), "f"(f467));
  // PTX:562 fma.rn.f32 %f474, %f431, %f430, %f468
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f474) : "f"(f431), "f"(f430), "f"(f468));
  // PTX:563 fma.rn.f32 %f475, %f431, %f431, %f469
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f475) : "f"(f431), "f"(f431), "f"(f469));
  // PTX:564 mul.f32 %f476, %f439, %f439
  asm("mul.f32 %0, %1, %2;" : "=f"(f476) : "f"(f439), "f"(f439));
  // PTX:565 mul.f32 %f477, %f441, %f439
  asm("mul.f32 %0, %1, %2;" : "=f"(f477) : "f"(f441), "f"(f439));
  // PTX:566 mul.f32 %f478, %f443, %f439
  asm("mul.f32 %0, %1, %2;" : "=f"(f478) : "f"(f443), "f"(f439));
  // PTX:567 mul.f32 %f479, %f441, %f441
  asm("mul.f32 %0, %1, %2;" : "=f"(f479) : "f"(f441), "f"(f441));
  // PTX:568 mul.f32 %f480, %f443, %f441
  asm("mul.f32 %0, %1, %2;" : "=f"(f480) : "f"(f443), "f"(f441));
  // PTX:569 mul.f32 %f481, %f443, %f443
  asm("mul.f32 %0, %1, %2;" : "=f"(f481) : "f"(f443), "f"(f443));
  // PTX:570 fma.rn.f32 %f482, %f476, 0f40000000, %f470
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f482) : "f"(f476), "f"(f470));
  // PTX:571 fma.rn.f32 %f483, %f477, 0f40000000, %f471
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f483) : "f"(f477), "f"(f471));
  // PTX:572 fma.rn.f32 %f484, %f478, 0f40000000, %f472
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f484) : "f"(f478), "f"(f472));
  // PTX:573 fma.rn.f32 %f485, %f479, 0f40000000, %f473
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f485) : "f"(f479), "f"(f473));
  // PTX:574 fma.rn.f32 %f486, %f480, 0f40000000, %f474
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f486) : "f"(f480), "f"(f474));
  // PTX:575 fma.rn.f32 %f487, %f481, 0f40000000, %f475
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f487) : "f"(f481), "f"(f475));
  // PTX:576 fma.rn.f32 %f488, %f445, %f445, %f482
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f488) : "f"(f445), "f"(f445), "f"(f482));
  // PTX:577 fma.rn.f32 %f489, %f446, %f445, %f483
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f489) : "f"(f446), "f"(f445), "f"(f483));
  // PTX:578 fma.rn.f32 %f490, %f447, %f445, %f484
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f490) : "f"(f447), "f"(f445), "f"(f484));
  // PTX:579 fma.rn.f32 %f491, %f446, %f446, %f485
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f491) : "f"(f446), "f"(f446), "f"(f485));
  // PTX:580 fma.rn.f32 %f492, %f447, %f446, %f486
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f492) : "f"(f447), "f"(f446), "f"(f486));
  // PTX:581 fma.rn.f32 %f493, %f447, %f447, %f487
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f493) : "f"(f447), "f"(f447), "f"(f487));
  // PTX:582 mul.f32 %f494, %f449, %f449
  asm("mul.f32 %0, %1, %2;" : "=f"(f494) : "f"(f449), "f"(f449));
  // PTX:583 mul.f32 %f495, %f451, %f449
  asm("mul.f32 %0, %1, %2;" : "=f"(f495) : "f"(f451), "f"(f449));
  // PTX:584 mul.f32 %f496, %f453, %f449
  asm("mul.f32 %0, %1, %2;" : "=f"(f496) : "f"(f453), "f"(f449));
  // PTX:585 mul.f32 %f497, %f451, %f451
  asm("mul.f32 %0, %1, %2;" : "=f"(f497) : "f"(f451), "f"(f451));
  // PTX:586 mul.f32 %f498, %f453, %f451
  asm("mul.f32 %0, %1, %2;" : "=f"(f498) : "f"(f453), "f"(f451));
  // PTX:587 mul.f32 %f499, %f453, %f453
  asm("mul.f32 %0, %1, %2;" : "=f"(f499) : "f"(f453), "f"(f453));
  // PTX:588 fma.rn.f32 %f500, %f494, 0f40000000, %f488
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f500) : "f"(f494), "f"(f488));
  // PTX:589 fma.rn.f32 %f501, %f495, 0f40000000, %f489
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f501) : "f"(f495), "f"(f489));
  // PTX:590 fma.rn.f32 %f502, %f496, 0f40000000, %f490
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f502) : "f"(f496), "f"(f490));
  // PTX:591 fma.rn.f32 %f503, %f497, 0f40000000, %f491
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f503) : "f"(f497), "f"(f491));
  // PTX:592 fma.rn.f32 %f504, %f498, 0f40000000, %f492
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f504) : "f"(f498), "f"(f492));
  // PTX:593 fma.rn.f32 %f505, %f499, 0f40000000, %f493
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f505) : "f"(f499), "f"(f493));
  // PTX:594 fma.rn.f32 %f506, %f455, %f455, %f500
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f506) : "f"(f455), "f"(f455), "f"(f500));
  // PTX:595 fma.rn.f32 %f507, %f456, %f455, %f501
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f507) : "f"(f456), "f"(f455), "f"(f501));
  // PTX:596 fma.rn.f32 %f508, %f457, %f455, %f502
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f508) : "f"(f457), "f"(f455), "f"(f502));
  // PTX:597 fma.rn.f32 %f509, %f456, %f456, %f503
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f509) : "f"(f456), "f"(f456), "f"(f503));
  // PTX:598 fma.rn.f32 %f510, %f457, %f456, %f504
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f510) : "f"(f457), "f"(f456), "f"(f504));
  // PTX:599 fma.rn.f32 %f511, %f457, %f457, %f505
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f511) : "f"(f457), "f"(f457), "f"(f505));
  // PTX:600 fma.rn.f32 %f653, %f34, %f506, %f653
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f653) : "f"(f34), "f"(f506), "f"(f653));
  // PTX:601 fma.rn.f32 %f652, %f34, %f507, %f652
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f652) : "f"(f34), "f"(f507), "f"(f652));
  // PTX:602 fma.rn.f32 %f650, %f34, %f508, %f650
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f650) : "f"(f34), "f"(f508), "f"(f650));
  // PTX:603 fma.rn.f32 %f651, %f34, %f509, %f651
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f651) : "f"(f34), "f"(f509), "f"(f651));
  // PTX:604 fma.rn.f32 %f649, %f34, %f510, %f649
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f649) : "f"(f34), "f"(f510), "f"(f649));
  // PTX:605 fma.rn.f32 %f648, %f34, %f511, %f648
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f648) : "f"(f34), "f"(f511), "f"(f648));
  // PTX:607 $L__BB59_10:
L_BB59_10:;
  // PTX:608 mul.lo.s64 %rd69, %rd11, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd69) : "l"(rd11));
  // PTX:609 add.s64 %rd70, %rd1, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd70) : "l"(rd1), "l"(rd69));
  // PTX:610 red.global.add.f32 [%rd70], %f653
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0)))), (float)(f653));
  // PTX:611 add.s64 %rd71, %rd70, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd71) : "l"(rd70));
  // PTX:612 red.global.add.f32 [%rd71], %f652
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))), (float)(f652));
  // PTX:613 add.s64 %rd72, %rd70, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd72) : "l"(rd70));
  // PTX:614 red.global.add.f32 [%rd72], %f650
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (0)))), (float)(f650));
  // PTX:615 add.s64 %rd73, %rd70, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd73) : "l"(rd70));
  // PTX:616 red.global.add.f32 [%rd73], %f652
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (0)))), (float)(f652));
  // PTX:617 add.s64 %rd74, %rd70, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd74) : "l"(rd70));
  // PTX:618 red.global.add.f32 [%rd74], %f651
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (0)))), (float)(f651));
  // PTX:619 add.s64 %rd75, %rd70, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd75) : "l"(rd70));
  // PTX:620 red.global.add.f32 [%rd75], %f649
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (0)))), (float)(f649));
  // PTX:621 add.s64 %rd76, %rd70, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd76) : "l"(rd70));
  // PTX:622 red.global.add.f32 [%rd76], %f650
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (0)))), (float)(f650));
  // PTX:623 add.s64 %rd77, %rd70, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd77) : "l"(rd70));
  // PTX:624 red.global.add.f32 [%rd77], %f649
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (0)))), (float)(f649));
  // PTX:625 add.s64 %rd78, %rd70, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd78) : "l"(rd70));
  // PTX:626 red.global.add.f32 [%rd78], %f648
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd78) + (0)))), (float)(f648));
  // PTX:627 mul.f32 %f521, %f22, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f521) : "f"(f22), "f"(f9));
  // PTX:628 fma.rn.f32 %f522, %f19, %f3, %f521
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f522) : "f"(f19), "f"(f3), "f"(f521));
  // PTX:629 mul.f32 %f523, %f23, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f523) : "f"(f23), "f"(f9));
  // PTX:630 fma.rn.f32 %f524, %f20, %f3, %f523
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f524) : "f"(f20), "f"(f3), "f"(f523));
  // PTX:631 mul.f32 %f525, %f24, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f525) : "f"(f24), "f"(f9));
  // PTX:632 fma.rn.f32 %f526, %f21, %f3, %f525
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f526) : "f"(f21), "f"(f3), "f"(f525));
  // PTX:633 fma.rn.f32 %f527, %f25, %f15, %f522
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f527) : "f"(f25), "f"(f15), "f"(f522));
  // PTX:634 fma.rn.f32 %f528, %f26, %f15, %f524
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f528) : "f"(f26), "f"(f15), "f"(f524));
  // PTX:635 fma.rn.f32 %f529, %f27, %f15, %f526
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f529) : "f"(f27), "f"(f15), "f"(f526));
  // PTX:636 mul.f32 %f530, %f9, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f530) : "f"(f9), "f"(f9));
  // PTX:637 fma.rn.f32 %f531, %f3, %f3, %f530
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f531) : "f"(f3), "f"(f3), "f"(f530));
  // PTX:638 fma.rn.f32 %f532, %f15, %f15, %f531
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f532) : "f"(f15), "f"(f15), "f"(f531));
  // PTX:639 mul.f32 %f533, %f31, %f532
  asm("mul.f32 %0, %1, %2;" : "=f"(f533) : "f"(f31), "f"(f532));
  // PTX:640 mul.f32 %f534, %f527, %f527
  asm("mul.f32 %0, %1, %2;" : "=f"(f534) : "f"(f527), "f"(f527));
  // PTX:641 mul.f32 %f535, %f528, %f527
  asm("mul.f32 %0, %1, %2;" : "=f"(f535) : "f"(f528), "f"(f527));
  // PTX:642 mul.f32 %f536, %f529, %f527
  asm("mul.f32 %0, %1, %2;" : "=f"(f536) : "f"(f529), "f"(f527));
  // PTX:643 mul.f32 %f537, %f528, %f528
  asm("mul.f32 %0, %1, %2;" : "=f"(f537) : "f"(f528), "f"(f528));
  // PTX:644 mul.f32 %f538, %f529, %f528
  asm("mul.f32 %0, %1, %2;" : "=f"(f538) : "f"(f529), "f"(f528));
  // PTX:645 mul.f32 %f539, %f529, %f529
  asm("mul.f32 %0, %1, %2;" : "=f"(f539) : "f"(f529), "f"(f529));
  // PTX:646 mul.f32 %f540, %f32, %f535
  asm("mul.f32 %0, %1, %2;" : "=f"(f540) : "f"(f32), "f"(f535));
  // PTX:647 mul.f32 %f541, %f32, %f536
  asm("mul.f32 %0, %1, %2;" : "=f"(f541) : "f"(f32), "f"(f536));
  // PTX:648 mul.f32 %f542, %f32, %f538
  asm("mul.f32 %0, %1, %2;" : "=f"(f542) : "f"(f32), "f"(f538));
  // PTX:649 fma.rn.f32 %f659, %f32, %f534, %f533
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f659) : "f"(f32), "f"(f534), "f"(f533));
  // PTX:650 fma.rn.f32 %f658, %f533, 0f00000000, %f540
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f658) : "f"(f533), "f"(f540));
  // PTX:651 fma.rn.f32 %f656, %f533, 0f00000000, %f541
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f656) : "f"(f533), "f"(f541));
  // PTX:652 fma.rn.f32 %f657, %f32, %f537, %f533
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f657) : "f"(f32), "f"(f537), "f"(f533));
  // PTX:653 fma.rn.f32 %f655, %f533, 0f00000000, %f542
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f655) : "f"(f533), "f"(f542));
  // PTX:654 fma.rn.f32 %f654, %f32, %f539, %f533
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f654) : "f"(f32), "f"(f539), "f"(f533));
  // PTX:655 @%p3 bra $L__BB59_12
  if (p3) { goto L_BB59_12; }
  // PTX:657 add.f32 %f543, %f3, %f3
  asm("add.f32 %0, %1, %2;" : "=f"(f543) : "f"(f3), "f"(f3));
  // PTX:658 mul.f32 %f544, %f4, %f543
  asm("mul.f32 %0, %1, %2;" : "=f"(f544) : "f"(f4), "f"(f543));
  // PTX:659 mul.f32 %f545, %f5, %f543
  asm("mul.f32 %0, %1, %2;" : "=f"(f545) : "f"(f5), "f"(f543));
  // PTX:660 mul.f32 %f546, %f6, %f543
  asm("mul.f32 %0, %1, %2;" : "=f"(f546) : "f"(f6), "f"(f543));
  // PTX:661 mul.f32 %f547, %f4, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f547) : "f"(f4), "f"(f9));
  // PTX:662 fma.rn.f32 %f548, %f10, %f3, %f547
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f548) : "f"(f10), "f"(f3), "f"(f547));
  // PTX:663 mul.f32 %f549, %f5, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f549) : "f"(f5), "f"(f9));
  // PTX:664 fma.rn.f32 %f550, %f11, %f3, %f549
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f550) : "f"(f11), "f"(f3), "f"(f549));
  // PTX:665 mul.f32 %f551, %f6, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f551) : "f"(f6), "f"(f9));
  // PTX:666 fma.rn.f32 %f552, %f12, %f3, %f551
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f552) : "f"(f12), "f"(f3), "f"(f551));
  // PTX:667 mul.f32 %f553, %f4, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f553) : "f"(f4), "f"(f15));
  // PTX:668 fma.rn.f32 %f554, %f16, %f3, %f553
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f554) : "f"(f16), "f"(f3), "f"(f553));
  // PTX:669 mul.f32 %f555, %f5, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f555) : "f"(f5), "f"(f15));
  // PTX:670 fma.rn.f32 %f556, %f17, %f3, %f555
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f556) : "f"(f17), "f"(f3), "f"(f555));
  // PTX:671 mul.f32 %f557, %f6, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f557) : "f"(f6), "f"(f15));
  // PTX:672 fma.rn.f32 %f558, %f18, %f3, %f557
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f558) : "f"(f18), "f"(f3), "f"(f557));
  // PTX:673 add.f32 %f559, %f9, %f9
  asm("add.f32 %0, %1, %2;" : "=f"(f559) : "f"(f9), "f"(f9));
  // PTX:674 mul.f32 %f560, %f10, %f559
  asm("mul.f32 %0, %1, %2;" : "=f"(f560) : "f"(f10), "f"(f559));
  // PTX:675 mul.f32 %f561, %f11, %f559
  asm("mul.f32 %0, %1, %2;" : "=f"(f561) : "f"(f11), "f"(f559));
  // PTX:676 mul.f32 %f562, %f12, %f559
  asm("mul.f32 %0, %1, %2;" : "=f"(f562) : "f"(f12), "f"(f559));
  // PTX:677 mul.f32 %f563, %f10, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f563) : "f"(f10), "f"(f15));
  // PTX:678 fma.rn.f32 %f564, %f16, %f9, %f563
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f564) : "f"(f16), "f"(f9), "f"(f563));
  // PTX:679 mul.f32 %f565, %f11, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f565) : "f"(f11), "f"(f15));
  // PTX:680 fma.rn.f32 %f566, %f17, %f9, %f565
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f566) : "f"(f17), "f"(f9), "f"(f565));
  // PTX:681 mul.f32 %f567, %f12, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f567) : "f"(f12), "f"(f15));
  // PTX:682 fma.rn.f32 %f568, %f18, %f9, %f567
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f568) : "f"(f18), "f"(f9), "f"(f567));
  // PTX:683 add.f32 %f569, %f15, %f15
  asm("add.f32 %0, %1, %2;" : "=f"(f569) : "f"(f15), "f"(f15));
  // PTX:684 mul.f32 %f570, %f16, %f569
  asm("mul.f32 %0, %1, %2;" : "=f"(f570) : "f"(f16), "f"(f569));
  // PTX:685 mul.f32 %f571, %f17, %f569
  asm("mul.f32 %0, %1, %2;" : "=f"(f571) : "f"(f17), "f"(f569));
  // PTX:686 mul.f32 %f572, %f18, %f569
  asm("mul.f32 %0, %1, %2;" : "=f"(f572) : "f"(f18), "f"(f569));
  // PTX:687 mul.f32 %f573, %f548, %f548
  asm("mul.f32 %0, %1, %2;" : "=f"(f573) : "f"(f548), "f"(f548));
  // PTX:688 mul.f32 %f574, %f550, %f548
  asm("mul.f32 %0, %1, %2;" : "=f"(f574) : "f"(f550), "f"(f548));
  // PTX:689 mul.f32 %f575, %f552, %f548
  asm("mul.f32 %0, %1, %2;" : "=f"(f575) : "f"(f552), "f"(f548));
  // PTX:690 mul.f32 %f576, %f550, %f550
  asm("mul.f32 %0, %1, %2;" : "=f"(f576) : "f"(f550), "f"(f550));
  // PTX:691 mul.f32 %f577, %f552, %f550
  asm("mul.f32 %0, %1, %2;" : "=f"(f577) : "f"(f552), "f"(f550));
  // PTX:692 mul.f32 %f578, %f552, %f552
  asm("mul.f32 %0, %1, %2;" : "=f"(f578) : "f"(f552), "f"(f552));
  // PTX:693 fma.rn.f32 %f579, %f548, %f548, %f573
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f579) : "f"(f548), "f"(f548), "f"(f573));
  // PTX:694 fma.rn.f32 %f580, %f550, %f548, %f574
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f580) : "f"(f550), "f"(f548), "f"(f574));
  // PTX:695 fma.rn.f32 %f581, %f552, %f548, %f575
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f581) : "f"(f552), "f"(f548), "f"(f575));
  // PTX:696 fma.rn.f32 %f582, %f550, %f550, %f576
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f582) : "f"(f550), "f"(f550), "f"(f576));
  // PTX:697 fma.rn.f32 %f583, %f552, %f550, %f577
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f583) : "f"(f552), "f"(f550), "f"(f577));
  // PTX:698 fma.rn.f32 %f584, %f552, %f552, %f578
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f584) : "f"(f552), "f"(f552), "f"(f578));
  // PTX:699 fma.rn.f32 %f585, %f544, %f544, %f579
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f585) : "f"(f544), "f"(f544), "f"(f579));
  // PTX:700 fma.rn.f32 %f586, %f545, %f544, %f580
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f586) : "f"(f545), "f"(f544), "f"(f580));
  // PTX:701 fma.rn.f32 %f587, %f546, %f544, %f581
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f587) : "f"(f546), "f"(f544), "f"(f581));
  // PTX:702 fma.rn.f32 %f588, %f545, %f545, %f582
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f588) : "f"(f545), "f"(f545), "f"(f582));
  // PTX:703 fma.rn.f32 %f589, %f546, %f545, %f583
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f589) : "f"(f546), "f"(f545), "f"(f583));
  // PTX:704 fma.rn.f32 %f590, %f546, %f546, %f584
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f590) : "f"(f546), "f"(f546), "f"(f584));
  // PTX:705 mul.f32 %f591, %f554, %f554
  asm("mul.f32 %0, %1, %2;" : "=f"(f591) : "f"(f554), "f"(f554));
  // PTX:706 mul.f32 %f592, %f556, %f554
  asm("mul.f32 %0, %1, %2;" : "=f"(f592) : "f"(f556), "f"(f554));
  // PTX:707 mul.f32 %f593, %f558, %f554
  asm("mul.f32 %0, %1, %2;" : "=f"(f593) : "f"(f558), "f"(f554));
  // PTX:708 mul.f32 %f594, %f556, %f556
  asm("mul.f32 %0, %1, %2;" : "=f"(f594) : "f"(f556), "f"(f556));
  // PTX:709 mul.f32 %f595, %f558, %f556
  asm("mul.f32 %0, %1, %2;" : "=f"(f595) : "f"(f558), "f"(f556));
  // PTX:710 mul.f32 %f596, %f558, %f558
  asm("mul.f32 %0, %1, %2;" : "=f"(f596) : "f"(f558), "f"(f558));
  // PTX:711 fma.rn.f32 %f597, %f591, 0f40000000, %f585
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f597) : "f"(f591), "f"(f585));
  // PTX:712 fma.rn.f32 %f598, %f592, 0f40000000, %f586
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f598) : "f"(f592), "f"(f586));
  // PTX:713 fma.rn.f32 %f599, %f593, 0f40000000, %f587
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f599) : "f"(f593), "f"(f587));
  // PTX:714 fma.rn.f32 %f600, %f594, 0f40000000, %f588
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f600) : "f"(f594), "f"(f588));
  // PTX:715 fma.rn.f32 %f601, %f595, 0f40000000, %f589
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f601) : "f"(f595), "f"(f589));
  // PTX:716 fma.rn.f32 %f602, %f596, 0f40000000, %f590
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f602) : "f"(f596), "f"(f590));
  // PTX:717 fma.rn.f32 %f603, %f560, %f560, %f597
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f603) : "f"(f560), "f"(f560), "f"(f597));
  // PTX:718 fma.rn.f32 %f604, %f561, %f560, %f598
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f604) : "f"(f561), "f"(f560), "f"(f598));
  // PTX:719 fma.rn.f32 %f605, %f562, %f560, %f599
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f605) : "f"(f562), "f"(f560), "f"(f599));
  // PTX:720 fma.rn.f32 %f606, %f561, %f561, %f600
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f606) : "f"(f561), "f"(f561), "f"(f600));
  // PTX:721 fma.rn.f32 %f607, %f562, %f561, %f601
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f607) : "f"(f562), "f"(f561), "f"(f601));
  // PTX:722 fma.rn.f32 %f608, %f562, %f562, %f602
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f608) : "f"(f562), "f"(f562), "f"(f602));
  // PTX:723 mul.f32 %f609, %f564, %f564
  asm("mul.f32 %0, %1, %2;" : "=f"(f609) : "f"(f564), "f"(f564));
  // PTX:724 mul.f32 %f610, %f566, %f564
  asm("mul.f32 %0, %1, %2;" : "=f"(f610) : "f"(f566), "f"(f564));
  // PTX:725 mul.f32 %f611, %f568, %f564
  asm("mul.f32 %0, %1, %2;" : "=f"(f611) : "f"(f568), "f"(f564));
  // PTX:726 mul.f32 %f612, %f566, %f566
  asm("mul.f32 %0, %1, %2;" : "=f"(f612) : "f"(f566), "f"(f566));
  // PTX:727 mul.f32 %f613, %f568, %f566
  asm("mul.f32 %0, %1, %2;" : "=f"(f613) : "f"(f568), "f"(f566));
  // PTX:728 mul.f32 %f614, %f568, %f568
  asm("mul.f32 %0, %1, %2;" : "=f"(f614) : "f"(f568), "f"(f568));
  // PTX:729 fma.rn.f32 %f615, %f609, 0f40000000, %f603
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f615) : "f"(f609), "f"(f603));
  // PTX:730 fma.rn.f32 %f616, %f610, 0f40000000, %f604
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f616) : "f"(f610), "f"(f604));
  // PTX:731 fma.rn.f32 %f617, %f611, 0f40000000, %f605
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f617) : "f"(f611), "f"(f605));
  // PTX:732 fma.rn.f32 %f618, %f612, 0f40000000, %f606
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f618) : "f"(f612), "f"(f606));
  // PTX:733 fma.rn.f32 %f619, %f613, 0f40000000, %f607
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f619) : "f"(f613), "f"(f607));
  // PTX:734 fma.rn.f32 %f620, %f614, 0f40000000, %f608
  asm("fma.rn.f32 %0, %1, 0f40000000, %2;" : "=f"(f620) : "f"(f614), "f"(f608));
  // PTX:735 fma.rn.f32 %f621, %f570, %f570, %f615
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f621) : "f"(f570), "f"(f570), "f"(f615));
  // PTX:736 fma.rn.f32 %f622, %f571, %f570, %f616
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f622) : "f"(f571), "f"(f570), "f"(f616));
  // PTX:737 fma.rn.f32 %f623, %f572, %f570, %f617
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f623) : "f"(f572), "f"(f570), "f"(f617));
  // PTX:738 fma.rn.f32 %f624, %f571, %f571, %f618
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f624) : "f"(f571), "f"(f571), "f"(f618));
  // PTX:739 fma.rn.f32 %f625, %f572, %f571, %f619
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f625) : "f"(f572), "f"(f571), "f"(f619));
  // PTX:740 fma.rn.f32 %f626, %f572, %f572, %f620
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f626) : "f"(f572), "f"(f572), "f"(f620));
  // PTX:741 fma.rn.f32 %f659, %f34, %f621, %f659
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f659) : "f"(f34), "f"(f621), "f"(f659));
  // PTX:742 fma.rn.f32 %f658, %f34, %f622, %f658
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f658) : "f"(f34), "f"(f622), "f"(f658));
  // PTX:743 fma.rn.f32 %f656, %f34, %f623, %f656
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f656) : "f"(f34), "f"(f623), "f"(f656));
  // PTX:744 fma.rn.f32 %f657, %f34, %f624, %f657
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f657) : "f"(f34), "f"(f624), "f"(f657));
  // PTX:745 fma.rn.f32 %f655, %f34, %f625, %f655
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f655) : "f"(f34), "f"(f625), "f"(f655));
  // PTX:746 fma.rn.f32 %f654, %f34, %f626, %f654
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f654) : "f"(f34), "f"(f626), "f"(f654));
  // PTX:748 $L__BB59_12:
L_BB59_12:;
  // PTX:749 mul.lo.s64 %rd79, %rd12, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd79) : "l"(rd12));
  // PTX:750 add.s64 %rd80, %rd1, %rd79
  asm("add.s64 %0, %1, %2;" : "=l"(rd80) : "l"(rd1), "l"(rd79));
  // PTX:751 red.global.add.f32 [%rd80], %f659
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (0)))), (float)(f659));
  // PTX:752 add.s64 %rd81, %rd80, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd81) : "l"(rd80));
  // PTX:753 red.global.add.f32 [%rd81], %f658
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (0)))), (float)(f658));
  // PTX:754 add.s64 %rd82, %rd80, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd82) : "l"(rd80));
  // PTX:755 red.global.add.f32 [%rd82], %f656
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (0)))), (float)(f656));
  // PTX:756 add.s64 %rd83, %rd80, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd83) : "l"(rd80));
  // PTX:757 red.global.add.f32 [%rd83], %f658
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (0)))), (float)(f658));
  // PTX:758 add.s64 %rd84, %rd80, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd84) : "l"(rd80));
  // PTX:759 red.global.add.f32 [%rd84], %f657
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (0)))), (float)(f657));
  // PTX:760 add.s64 %rd85, %rd80, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd85) : "l"(rd80));
  // PTX:761 red.global.add.f32 [%rd85], %f655
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (0)))), (float)(f655));
  // PTX:762 add.s64 %rd86, %rd80, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd86) : "l"(rd80));
  // PTX:763 red.global.add.f32 [%rd86], %f656
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd86) + (0)))), (float)(f656));
  // PTX:764 add.s64 %rd87, %rd80, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd87) : "l"(rd80));
  // PTX:765 red.global.add.f32 [%rd87], %f655
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (0)))), (float)(f655));
  // PTX:766 add.s64 %rd88, %rd80, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd88) : "l"(rd80));
  // PTX:767 red.global.add.f32 [%rd88], %f654
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (0)))), (float)(f654));
  // PTX:769 $L__BB59_13:
L_BB59_13:;
  // PTX:770 ret
  return;
}
