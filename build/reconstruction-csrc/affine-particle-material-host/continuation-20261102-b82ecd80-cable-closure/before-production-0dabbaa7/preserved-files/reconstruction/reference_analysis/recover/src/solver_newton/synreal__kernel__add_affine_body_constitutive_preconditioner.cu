// 机械还原自 PTX：synreal::kernel::add_affine_body_constitutive_preconditioner(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, float, synreal::AffineBodyRigidityModel, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 58e9cc7b55fc090bd5f605826277957a7963df8ee725f5e81d3a75c0d042d225
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__add_affine_body_constitutive_preconditioner(unsigned long long param0, unsigned long long param1, unsigned long long param2, float param3, unsigned param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8) {
  unsigned long long SP, SPL, rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64;
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440, f441, f442, f443, f444, f445, f446, f447, f448, f449, f450, f451, f452, f453, f454, f455, f456, f457, f458, f459, f460, f461, f462, f463, f464, f465, f466, f467, f468, f469, f470, f471, f472, f473, f474, f475, f476, f477, f478, f479, f480, f481, f482, f483, f484, f485, f486, f487, f488, f489, f490, f491, f492, f493, f494, f495, f496, f497, f498, f499, f500, f501, f502, f503, f504, f505, f506, f507, f508, f509, f510, f511, f512, f513, f514, f515, f516, f517, f518, f519, f520, f521, f522, f523, f524, f525, f526, f527, f528, f529, f530, f531, f532, f533, f534, f535, f536, f537, f538, f539, f540, f541, f542, f543, f544, f545, f546, f547, f548, f549, f550, f551, f552, f553, f554, f555, f556, f557, f558, f559, f560, f561, f562, f563, f564, f565, f566, f567, f568, f569, f570, f571, f572, f573, f574, f575, f576, f577, f578, f579, f580, f581, f582, f583, f584, f585, f586, f587, f588, f589, f590, f591, f592, f593, f594, f595, f596, f597, f598, f599, f600, f601, f602, f603, f604, f605, f606, f607, f608, f609, f610, f611, f612, f613, f614, f615, f616, f617, f618, f619, f620, f621, f622, f623, f624, f625, f626, f627, f628, f629, f630, f631, f632, f633, f634, f635, f636, f637, f638, f639, f640, f641, f642, f643, f644, f645, f646, f647, f648, f649, f650, f651, f652, f653, f654;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121, r122, r123, r124, r125, r126, r127, r128, r129, r130, r131, r132, r133, r134, r135, r136, r137, r138, r139, r140, r141, r142, r143, r144, r145, r146, r147, r148, r149, r150, r151, r152, r153, r154, r155, r156, r157, r158, r159, r160, r161, r162, r163, r164, r165, r166, r167, r168, r169, r170, r171, r172, r173, r174, r175, r176, r177, r178, r179, r180, r181, r182, r183, r184, r185, r186, r187, r188, r189, r190, r191, r192, r193, r194, r195, r196, r197, r198, r199, r200, r201, r202, r203, r204, r205, r206, r207, r208, r209, r210, r211, r212, r213, r214, r215, r216, r217, r218, r219, r220, r221, r222, r223, r224, r225, r226, r227, r228, r229, r230, r231, r232, r233, r234, r235, r236, r237, r238, r239, r240, r241, r242, r243, r244, r245, r246, r247, r248, r249, r250, r251, r252, r253, r254, r255, r256, r257, r258, r259, r260, r261, r262, r263, r264, r265, r266, r267, r268, r269, r270, r271, r272, r273, r274, r275, r276, r277, r278, r279, r280, r281, r282, r283, r284, r285;
  __align__(16) unsigned char __local_depot60[112];
  // PTX:28 mov.u64 %SPL, __local_depot60
  SPL = (unsigned long long)__cvta_generic_to_local(__local_depot60);
  // PTX:29 ld.param.u64 %rd21, [_ZN7synreal6kernel43add_affine_body_constitutive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_0]
  rd21 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:30 ld.param.u64 %rd22, [_ZN7synreal6kernel43add_affine_body_constitutive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_1]
  rd22 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:31 ld.param.u64 %rd23, [_ZN7synreal6kernel43add_affine_body_constitutive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_2]
  rd23 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:32 ld.param.f32 %f168, [_ZN7synreal6kernel43add_affine_body_constitutive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_3]
  f168 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param3 + (0))));
  // PTX:33 ld.param.u32 %r157, [_ZN7synreal6kernel43add_affine_body_constitutive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_4]
  r157 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param4 + (0))));
  // PTX:34 ld.param.u64 %rd24, [_ZN7synreal6kernel43add_affine_body_constitutive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_5]
  rd24 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:35 ld.param.u64 %rd27, [_ZN7synreal6kernel43add_affine_body_constitutive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_6]
  rd27 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:36 ld.param.u64 %rd25, [_ZN7synreal6kernel43add_affine_body_constitutive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_7]
  rd25 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:37 ld.param.u64 %rd26, [_ZN7synreal6kernel43add_affine_body_constitutive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_8]
  rd26 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:38 add.u64 %rd64, %SPL, 0
  asm("add.u64 %0, %1, 0;" : "=l"(rd64) : "l"(SPL));
  // PTX:39 add.u64 %rd2, %SPL, 64
  asm("add.u64 %0, %1, 64;" : "=l"(rd2) : "l"(SPL));
  // PTX:40 mov.u32 %r158, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r158) : "r"(blockIdx.x));
  // PTX:41 mov.u32 %r159, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r159) : "r"(blockDim.x));
  // PTX:42 mul.wide.u32 %rd30, %r158, %r159
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd30) : "r"(r158), "r"(r159));
  // PTX:43 mov.u32 %r160, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r160) : "r"(threadIdx.x));
  // PTX:44 cvt.u64.u32 %rd31, %r160
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd31) : "r"(r160));
  // PTX:45 add.s64 %rd3, %rd30, %rd31
  asm("add.s64 %0, %1, %2;" : "=l"(rd3) : "l"(rd30), "l"(rd31));
  // PTX:46 setp.ge.u64 %p1, %rd3, %rd27
  p1 = (((unsigned long long)(rd3)) >= ((unsigned long long)(rd27)));
  // PTX:47 @%p1 bra $L__BB60_35
  if (p1) { goto L_BB60_35; }
  // PTX:49 or.b64 %rd32, %rd3, %rd25
  asm("or.b64 %0, %1, %2;" : "=l"(rd32) : "l"(rd3), "l"(rd25));
  // PTX:50 and.b64 %rd33, %rd32, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd33) : "l"(rd32));
  // PTX:51 setp.eq.s64 %p2, %rd33, 0
  p2 = (((long long)(rd33)) == ((long long)(0)));
  // PTX:52 @%p2 bra $L__BB60_3
  if (p2) { goto L_BB60_3; }
  // PTX:54 div.u64 %rd60, %rd3, %rd25
  asm("div.u64 %0, %1, %2;" : "=l"(rd60) : "l"(rd3), "l"(rd25));
  // PTX:55 mul.lo.s64 %rd34, %rd60, %rd25
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd34) : "l"(rd60), "l"(rd25));
  // PTX:56 sub.s64 %rd61, %rd3, %rd34
  asm("sub.s64 %0, %1, %2;" : "=l"(rd61) : "l"(rd3), "l"(rd34));
  // PTX:57 bra.uni $L__BB60_4
  goto L_BB60_4;
  // PTX:59 $L__BB60_3:
L_BB60_3:;
  // PTX:60 cvt.u32.u64 %r161, %rd25
  asm("cvt.u32.u64 %0, %1;" : "=r"(r161) : "l"(rd25));
  // PTX:61 cvt.u32.u64 %r162, %rd3
  asm("cvt.u32.u64 %0, %1;" : "=r"(r162) : "l"(rd3));
  // PTX:62 div.u32 %r163, %r162, %r161
  asm("div.u32 %0, %1, %2;" : "=r"(r163) : "r"(r162), "r"(r161));
  // PTX:63 mul.lo.s32 %r164, %r163, %r161
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r164) : "r"(r163), "r"(r161));
  // PTX:64 sub.s32 %r165, %r162, %r164
  asm("sub.s32 %0, %1, %2;" : "=r"(r165) : "r"(r162), "r"(r164));
  // PTX:65 cvt.u64.u32 %rd60, %r163
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd60) : "r"(r163));
  // PTX:66 cvt.u64.u32 %rd61, %r165
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd61) : "r"(r165));
  // PTX:68 $L__BB60_4:
L_BB60_4:;
  // PTX:69 cvta.to.global.u64 %rd35, %rd21
  rd35 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd21));
  // PTX:70 mul.lo.s64 %rd36, %rd60, %rd26
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd36) : "l"(rd60), "l"(rd26));
  // PTX:71 cvt.u32.u64 %r166, %rd36
  asm("cvt.u32.u64 %0, %1;" : "=r"(r166) : "l"(rd36));
  // PTX:72 cvta.to.global.u64 %rd37, %rd22
  rd37 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd22));
  // PTX:73 shl.b64 %rd38, %rd61, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd38) : "l"(rd61));
  // PTX:74 add.s64 %rd39, %rd37, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd39) : "l"(rd37), "l"(rd38));
  // PTX:75 ld.global.u32 %r167, [%rd39]
  r167 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (0)))));
  // PTX:76 ld.global.u32 %r168, [%rd39+4]
  r168 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (4)))));
  // PTX:77 ld.global.u32 %r169, [%rd39+8]
  r169 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (8)))));
  // PTX:78 ld.global.u32 %r170, [%rd39+12]
  r170 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (12)))));
  // PTX:79 add.s32 %r171, %r170, %r166
  asm("add.s32 %0, %1, %2;" : "=r"(r171) : "r"(r170), "r"(r166));
  // PTX:80 add.s32 %r172, %r169, %r166
  asm("add.s32 %0, %1, %2;" : "=r"(r172) : "r"(r169), "r"(r166));
  // PTX:81 add.s32 %r173, %r168, %r166
  asm("add.s32 %0, %1, %2;" : "=r"(r173) : "r"(r168), "r"(r166));
  // PTX:82 add.s32 %r174, %r167, %r166
  asm("add.s32 %0, %1, %2;" : "=r"(r174) : "r"(r167), "r"(r166));
  // PTX:83 st.local.v4.u32 [%rd64], {%r174, %r173, %r172, %r171}
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd64) + (0))))) = (unsigned)(r174); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd64) + (4))))) = (unsigned)(r173); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd64) + (8))))) = (unsigned)(r172); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd64) + (12))))) = (unsigned)(r171);
  // PTX:84 mul.wide.s32 %rd40, %r173, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd40) : "r"(r173));
  // PTX:85 add.s64 %rd41, %rd35, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd41) : "l"(rd35), "l"(rd40));
  // PTX:86 ld.global.f32 %f1, [%rd41]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (0)))));
  // PTX:87 ld.global.u32 %r1, [%rd41+4]
  r1 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (4)))));
  // PTX:88 ld.global.u32 %r2, [%rd41+8]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (8)))));
  // PTX:89 mul.wide.s32 %rd42, %r172, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd42) : "r"(r172));
  // PTX:90 add.s64 %rd43, %rd35, %rd42
  asm("add.s64 %0, %1, %2;" : "=l"(rd43) : "l"(rd35), "l"(rd42));
  // PTX:91 ld.global.u32 %r3, [%rd43]
  r3 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (0)))));
  // PTX:92 ld.global.u32 %r4, [%rd43+4]
  r4 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (4)))));
  // PTX:93 ld.global.u32 %r5, [%rd43+8]
  r5 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (8)))));
  // PTX:94 mul.wide.s32 %rd44, %r171, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd44) : "r"(r171));
  // PTX:95 add.s64 %rd45, %rd35, %rd44
  asm("add.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd35), "l"(rd44));
  // PTX:96 ld.global.u32 %r6, [%rd45]
  r6 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))));
  // PTX:97 ld.global.u32 %r7, [%rd45+4]
  r7 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (4)))));
  // PTX:98 ld.global.u32 %r8, [%rd45+8]
  r8 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (8)))));
  // PTX:99 setp.eq.s32 %p3, %r157, 0
  p3 = (((int)(r157)) == ((int)(0)));
  // PTX:100 @%p3 bra $L__BB60_6
  if (p3) { goto L_BB60_6; }
  // PTX:102 mov.b32 %f645, %r3
  asm("mov.b32 %0, %1;" : "=f"(f645) : "r"(r3));
  // PTX:103 mov.b32 %f644, %r6
  asm("mov.b32 %0, %1;" : "=f"(f644) : "r"(r6));
  // PTX:104 mov.b32 %f643, %r1
  asm("mov.b32 %0, %1;" : "=f"(f643) : "r"(r1));
  // PTX:105 mov.b32 %f642, %r4
  asm("mov.b32 %0, %1;" : "=f"(f642) : "r"(r4));
  // PTX:106 mov.b32 %f641, %r7
  asm("mov.b32 %0, %1;" : "=f"(f641) : "r"(r7));
  // PTX:107 mov.b32 %f640, %r2
  asm("mov.b32 %0, %1;" : "=f"(f640) : "r"(r2));
  // PTX:108 mov.b32 %f639, %r5
  asm("mov.b32 %0, %1;" : "=f"(f639) : "r"(r5));
  // PTX:109 mov.b32 %f638, %r8
  asm("mov.b32 %0, %1;" : "=f"(f638) : "r"(r8));
  // PTX:110 mov.f32 %f648, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f648) : );
  // PTX:111 mov.f32 %f646, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f646) : );
  // PTX:112 mov.f32 %f647, %f646
  asm("mov.f32 %0, %1;" : "=f"(f647) : "f"(f646));
  // PTX:113 mov.f32 %f649, %f646
  asm("mov.f32 %0, %1;" : "=f"(f649) : "f"(f646));
  // PTX:114 mov.f32 %f650, %f648
  asm("mov.f32 %0, %1;" : "=f"(f650) : "f"(f648));
  // PTX:115 mov.f32 %f651, %f646
  asm("mov.f32 %0, %1;" : "=f"(f651) : "f"(f646));
  // PTX:116 mov.f32 %f652, %f646
  asm("mov.f32 %0, %1;" : "=f"(f652) : "f"(f646));
  // PTX:117 mov.f32 %f653, %f646
  asm("mov.f32 %0, %1;" : "=f"(f653) : "f"(f646));
  // PTX:118 mov.f32 %f654, %f648
  asm("mov.f32 %0, %1;" : "=f"(f654) : "f"(f648));
  // PTX:119 bra.uni $L__BB60_24
  goto L_BB60_24;
  // PTX:121 $L__BB60_6:
L_BB60_6:;
  // PTX:122 mov.b32 %f643, %r1
  asm("mov.b32 %0, %1;" : "=f"(f643) : "r"(r1));
  // PTX:123 mul.f32 %f178, %f643, %f643
  asm("mul.f32 %0, %1, %2;" : "=f"(f178) : "f"(f643), "f"(f643));
  // PTX:124 mov.b32 %f640, %r2
  asm("mov.b32 %0, %1;" : "=f"(f640) : "r"(r2));
  // PTX:125 fma.rn.f32 %f179, %f1, %f1, %f178
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f179) : "f"(f1), "f"(f1), "f"(f178));
  // PTX:126 fma.rn.f32 %f180, %f640, %f640, %f179
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f180) : "f"(f640), "f"(f640), "f"(f179));
  // PTX:127 mov.b32 %f645, %r3
  asm("mov.b32 %0, %1;" : "=f"(f645) : "r"(r3));
  // PTX:128 mov.b32 %f642, %r4
  asm("mov.b32 %0, %1;" : "=f"(f642) : "r"(r4));
  // PTX:129 mul.f32 %f181, %f642, %f642
  asm("mul.f32 %0, %1, %2;" : "=f"(f181) : "f"(f642), "f"(f642));
  // PTX:130 mov.b32 %f639, %r5
  asm("mov.b32 %0, %1;" : "=f"(f639) : "r"(r5));
  // PTX:131 fma.rn.f32 %f182, %f645, %f645, %f181
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f182) : "f"(f645), "f"(f645), "f"(f181));
  // PTX:132 fma.rn.f32 %f183, %f639, %f639, %f182
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f183) : "f"(f639), "f"(f639), "f"(f182));
  // PTX:133 add.f32 %f184, %f180, %f183
  asm("add.f32 %0, %1, %2;" : "=f"(f184) : "f"(f180), "f"(f183));
  // PTX:134 mov.b32 %f644, %r6
  asm("mov.b32 %0, %1;" : "=f"(f644) : "r"(r6));
  // PTX:135 mov.b32 %f641, %r7
  asm("mov.b32 %0, %1;" : "=f"(f641) : "r"(r7));
  // PTX:136 mul.f32 %f185, %f641, %f641
  asm("mul.f32 %0, %1, %2;" : "=f"(f185) : "f"(f641), "f"(f641));
  // PTX:137 mov.b32 %f638, %r8
  asm("mov.b32 %0, %1;" : "=f"(f638) : "r"(r8));
  // PTX:138 fma.rn.f32 %f186, %f644, %f644, %f185
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f186) : "f"(f644), "f"(f644), "f"(f185));
  // PTX:139 fma.rn.f32 %f187, %f638, %f638, %f186
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f187) : "f"(f638), "f"(f638), "f"(f186));
  // PTX:140 add.f32 %f188, %f184, %f187
  asm("add.f32 %0, %1, %2;" : "=f"(f188) : "f"(f184), "f"(f187));
  // PTX:141 div.rn.f32 %f189, %f188, 0f40400000
  asm("div.rn.f32 %0, %1, 0f40400000;" : "=f"(f189) : "f"(f188));
  // PTX:142 sqrt.rn.f32 %f18, %f189
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f18) : "f"(f189));
  // PTX:143 setp.leu.f32 %p4, %f18, 0f322BCC77
  p4 = ((isnan(((float)(f18))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f18)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:144 mov.u32 %r249, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r249) : );
  // PTX:145 mov.u32 %r250, 0
  asm("mov.u32 %0, 0;" : "=r"(r250) : );
  // PTX:146 mov.u32 %r251, %r250
  asm("mov.u32 %0, %1;" : "=r"(r251) : "r"(r250));
  // PTX:147 mov.u32 %r252, %r250
  asm("mov.u32 %0, %1;" : "=r"(r252) : "r"(r250));
  // PTX:148 mov.u32 %r253, %r249
  asm("mov.u32 %0, %1;" : "=r"(r253) : "r"(r249));
  // PTX:149 mov.u32 %r254, %r250
  asm("mov.u32 %0, %1;" : "=r"(r254) : "r"(r250));
  // PTX:150 mov.u32 %r255, %r250
  asm("mov.u32 %0, %1;" : "=r"(r255) : "r"(r250));
  // PTX:151 mov.u32 %r256, %r250
  asm("mov.u32 %0, %1;" : "=r"(r256) : "r"(r250));
  // PTX:152 mov.u32 %r257, %r249
  asm("mov.u32 %0, %1;" : "=r"(r257) : "r"(r249));
  // PTX:153 @%p4 bra $L__BB60_23
  if (p4) { goto L_BB60_23; }
  // PTX:155 abs.f32 %f190, %f18
  asm("abs.f32 %0, %1;" : "=f"(f190) : "f"(f18));
  // PTX:156 setp.geu.f32 %p5, %f190, 0f7F800000
  p5 = ((isnan(((float)(f190))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f190)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:157 @%p5 bra $L__BB60_23
  if (p5) { goto L_BB60_23; }
  // PTX:159 rcp.rn.f32 %f191, %f18
  asm("rcp.rn.f32 %0, %1;" : "=f"(f191) : "f"(f18));
  // PTX:160 mul.f32 %f629, %f191, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f629) : "f"(f191), "f"(f1));
  // PTX:161 mul.f32 %f630, %f191, %f643
  asm("mul.f32 %0, %1, %2;" : "=f"(f630) : "f"(f191), "f"(f643));
  // PTX:162 mul.f32 %f631, %f191, %f640
  asm("mul.f32 %0, %1, %2;" : "=f"(f631) : "f"(f191), "f"(f640));
  // PTX:163 mul.f32 %f632, %f191, %f645
  asm("mul.f32 %0, %1, %2;" : "=f"(f632) : "f"(f191), "f"(f645));
  // PTX:164 mul.f32 %f633, %f191, %f642
  asm("mul.f32 %0, %1, %2;" : "=f"(f633) : "f"(f191), "f"(f642));
  // PTX:165 mul.f32 %f634, %f191, %f639
  asm("mul.f32 %0, %1, %2;" : "=f"(f634) : "f"(f191), "f"(f639));
  // PTX:166 mul.f32 %f635, %f191, %f644
  asm("mul.f32 %0, %1, %2;" : "=f"(f635) : "f"(f191), "f"(f644));
  // PTX:167 mul.f32 %f636, %f191, %f641
  asm("mul.f32 %0, %1, %2;" : "=f"(f636) : "f"(f191), "f"(f641));
  // PTX:168 mul.f32 %f637, %f191, %f638
  asm("mul.f32 %0, %1, %2;" : "=f"(f637) : "f"(f191), "f"(f638));
  // PTX:169 mov.u32 %r233, 0
  asm("mov.u32 %0, 0;" : "=r"(r233) : );
  // PTX:171 $L__BB60_9:
L_BB60_9:;
  // PTX:172 mul.f32 %f192, %f634, %f636
  asm("mul.f32 %0, %1, %2;" : "=f"(f192) : "f"(f634), "f"(f636));
  // PTX:173 mul.f32 %f193, %f633, %f637
  asm("mul.f32 %0, %1, %2;" : "=f"(f193) : "f"(f633), "f"(f637));
  // PTX:174 sub.f32 %f37, %f193, %f192
  asm("sub.f32 %0, %1, %2;" : "=f"(f37) : "f"(f193), "f"(f192));
  // PTX:175 mul.f32 %f194, %f632, %f637
  asm("mul.f32 %0, %1, %2;" : "=f"(f194) : "f"(f632), "f"(f637));
  // PTX:176 mul.f32 %f195, %f634, %f635
  asm("mul.f32 %0, %1, %2;" : "=f"(f195) : "f"(f634), "f"(f635));
  // PTX:177 sub.f32 %f38, %f195, %f194
  asm("sub.f32 %0, %1, %2;" : "=f"(f38) : "f"(f195), "f"(f194));
  // PTX:178 mul.f32 %f196, %f633, %f635
  asm("mul.f32 %0, %1, %2;" : "=f"(f196) : "f"(f633), "f"(f635));
  // PTX:179 mul.f32 %f197, %f632, %f636
  asm("mul.f32 %0, %1, %2;" : "=f"(f197) : "f"(f632), "f"(f636));
  // PTX:180 sub.f32 %f39, %f197, %f196
  asm("sub.f32 %0, %1, %2;" : "=f"(f39) : "f"(f197), "f"(f196));
  // PTX:181 mul.f32 %f198, %f630, %f38
  asm("mul.f32 %0, %1, %2;" : "=f"(f198) : "f"(f630), "f"(f38));
  // PTX:182 fma.rn.f32 %f199, %f629, %f37, %f198
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f199) : "f"(f629), "f"(f37), "f"(f198));
  // PTX:183 fma.rn.f32 %f40, %f631, %f39, %f199
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f40) : "f"(f631), "f"(f39), "f"(f199));
  // PTX:184 abs.f32 %f200, %f40
  asm("abs.f32 %0, %1;" : "=f"(f200) : "f"(f40));
  // PTX:185 setp.le.f32 %p6, %f200, 0f2EDBE6FF
  p6 = (!(isnan(((float)(f200))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f200)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:186 setp.geu.f32 %p7, %f200, 0f7F800000
  p7 = ((isnan(((float)(f200))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f200)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:187 or.pred %p8, %p6, %p7
  p8 = ((p6) || (p7));
  // PTX:188 @%p8 bra $L__BB60_12
  if (p8) { goto L_BB60_12; }
  // PTX:190 rcp.rn.f32 %f201, %f40
  asm("rcp.rn.f32 %0, %1;" : "=f"(f201) : "f"(f40));
  // PTX:191 mul.f32 %f202, %f630, %f637
  asm("mul.f32 %0, %1, %2;" : "=f"(f202) : "f"(f630), "f"(f637));
  // PTX:192 mul.f32 %f203, %f631, %f636
  asm("mul.f32 %0, %1, %2;" : "=f"(f203) : "f"(f631), "f"(f636));
  // PTX:193 sub.f32 %f204, %f203, %f202
  asm("sub.f32 %0, %1, %2;" : "=f"(f204) : "f"(f203), "f"(f202));
  // PTX:194 mul.f32 %f205, %f631, %f635
  asm("mul.f32 %0, %1, %2;" : "=f"(f205) : "f"(f631), "f"(f635));
  // PTX:195 mul.f32 %f206, %f629, %f637
  asm("mul.f32 %0, %1, %2;" : "=f"(f206) : "f"(f629), "f"(f637));
  // PTX:196 sub.f32 %f207, %f206, %f205
  asm("sub.f32 %0, %1, %2;" : "=f"(f207) : "f"(f206), "f"(f205));
  // PTX:197 mul.f32 %f208, %f629, %f636
  asm("mul.f32 %0, %1, %2;" : "=f"(f208) : "f"(f629), "f"(f636));
  // PTX:198 mul.f32 %f209, %f630, %f635
  asm("mul.f32 %0, %1, %2;" : "=f"(f209) : "f"(f630), "f"(f635));
  // PTX:199 sub.f32 %f210, %f209, %f208
  asm("sub.f32 %0, %1, %2;" : "=f"(f210) : "f"(f209), "f"(f208));
  // PTX:200 mul.f32 %f211, %f631, %f633
  asm("mul.f32 %0, %1, %2;" : "=f"(f211) : "f"(f631), "f"(f633));
  // PTX:201 mul.f32 %f212, %f630, %f634
  asm("mul.f32 %0, %1, %2;" : "=f"(f212) : "f"(f630), "f"(f634));
  // PTX:202 sub.f32 %f213, %f212, %f211
  asm("sub.f32 %0, %1, %2;" : "=f"(f213) : "f"(f212), "f"(f211));
  // PTX:203 mul.f32 %f214, %f629, %f634
  asm("mul.f32 %0, %1, %2;" : "=f"(f214) : "f"(f629), "f"(f634));
  // PTX:204 mul.f32 %f215, %f631, %f632
  asm("mul.f32 %0, %1, %2;" : "=f"(f215) : "f"(f631), "f"(f632));
  // PTX:205 sub.f32 %f216, %f215, %f214
  asm("sub.f32 %0, %1, %2;" : "=f"(f216) : "f"(f215), "f"(f214));
  // PTX:206 mul.f32 %f217, %f630, %f632
  asm("mul.f32 %0, %1, %2;" : "=f"(f217) : "f"(f630), "f"(f632));
  // PTX:207 mul.f32 %f218, %f629, %f633
  asm("mul.f32 %0, %1, %2;" : "=f"(f218) : "f"(f629), "f"(f633));
  // PTX:208 sub.f32 %f219, %f218, %f217
  asm("sub.f32 %0, %1, %2;" : "=f"(f219) : "f"(f218), "f"(f217));
  // PTX:209 fma.rn.f32 %f220, %f37, %f201, %f629
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f220) : "f"(f37), "f"(f201), "f"(f629));
  // PTX:210 fma.rn.f32 %f221, %f38, %f201, %f630
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f221) : "f"(f38), "f"(f201), "f"(f630));
  // PTX:211 fma.rn.f32 %f222, %f39, %f201, %f631
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f222) : "f"(f39), "f"(f201), "f"(f631));
  // PTX:212 fma.rn.f32 %f223, %f204, %f201, %f632
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f223) : "f"(f204), "f"(f201), "f"(f632));
  // PTX:213 fma.rn.f32 %f224, %f207, %f201, %f633
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f224) : "f"(f207), "f"(f201), "f"(f633));
  // PTX:214 fma.rn.f32 %f225, %f210, %f201, %f634
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f225) : "f"(f210), "f"(f201), "f"(f634));
  // PTX:215 fma.rn.f32 %f226, %f213, %f201, %f635
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f226) : "f"(f213), "f"(f201), "f"(f635));
  // PTX:216 fma.rn.f32 %f227, %f216, %f201, %f636
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f227) : "f"(f216), "f"(f201), "f"(f636));
  // PTX:217 fma.rn.f32 %f228, %f219, %f201, %f637
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f228) : "f"(f219), "f"(f201), "f"(f637));
  // PTX:218 mul.f32 %f629, %f220, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f629) : "f"(f220));
  // PTX:219 mul.f32 %f630, %f221, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f630) : "f"(f221));
  // PTX:220 mul.f32 %f631, %f222, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f631) : "f"(f222));
  // PTX:221 mul.f32 %f632, %f223, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f632) : "f"(f223));
  // PTX:222 mul.f32 %f633, %f224, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f633) : "f"(f224));
  // PTX:223 mul.f32 %f634, %f225, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f634) : "f"(f225));
  // PTX:224 mul.f32 %f635, %f226, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f635) : "f"(f226));
  // PTX:225 mul.f32 %f636, %f227, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f636) : "f"(f227));
  // PTX:226 mul.f32 %f637, %f228, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f637) : "f"(f228));
  // PTX:227 mul.f32 %f229, %f633, %f637
  asm("mul.f32 %0, %1, %2;" : "=f"(f229) : "f"(f633), "f"(f637));
  // PTX:228 mul.f32 %f230, %f634, %f636
  asm("mul.f32 %0, %1, %2;" : "=f"(f230) : "f"(f634), "f"(f636));
  // PTX:229 sub.f32 %f50, %f229, %f230
  asm("sub.f32 %0, %1, %2;" : "=f"(f50) : "f"(f229), "f"(f230));
  // PTX:230 mul.f32 %f231, %f634, %f635
  asm("mul.f32 %0, %1, %2;" : "=f"(f231) : "f"(f634), "f"(f635));
  // PTX:231 mul.f32 %f232, %f632, %f637
  asm("mul.f32 %0, %1, %2;" : "=f"(f232) : "f"(f632), "f"(f637));
  // PTX:232 sub.f32 %f51, %f231, %f232
  asm("sub.f32 %0, %1, %2;" : "=f"(f51) : "f"(f231), "f"(f232));
  // PTX:233 mul.f32 %f233, %f632, %f636
  asm("mul.f32 %0, %1, %2;" : "=f"(f233) : "f"(f632), "f"(f636));
  // PTX:234 mul.f32 %f234, %f633, %f635
  asm("mul.f32 %0, %1, %2;" : "=f"(f234) : "f"(f633), "f"(f635));
  // PTX:235 sub.f32 %f52, %f233, %f234
  asm("sub.f32 %0, %1, %2;" : "=f"(f52) : "f"(f233), "f"(f234));
  // PTX:236 mul.f32 %f235, %f630, %f51
  asm("mul.f32 %0, %1, %2;" : "=f"(f235) : "f"(f630), "f"(f51));
  // PTX:237 fma.rn.f32 %f236, %f629, %f50, %f235
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f236) : "f"(f629), "f"(f50), "f"(f235));
  // PTX:238 fma.rn.f32 %f53, %f631, %f52, %f236
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f53) : "f"(f631), "f"(f52), "f"(f236));
  // PTX:239 abs.f32 %f237, %f53
  asm("abs.f32 %0, %1;" : "=f"(f237) : "f"(f53));
  // PTX:240 setp.le.f32 %p9, %f237, 0f2EDBE6FF
  p9 = (!(isnan(((float)(f237))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f237)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:241 setp.geu.f32 %p10, %f237, 0f7F800000
  p10 = ((isnan(((float)(f237))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f237)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:242 or.pred %p11, %p9, %p10
  p11 = ((p9) || (p10));
  // PTX:243 @%p11 bra $L__BB60_12
  if (p11) { goto L_BB60_12; }
  // PTX:245 rcp.rn.f32 %f238, %f53
  asm("rcp.rn.f32 %0, %1;" : "=f"(f238) : "f"(f53));
  // PTX:246 mul.f32 %f239, %f630, %f637
  asm("mul.f32 %0, %1, %2;" : "=f"(f239) : "f"(f630), "f"(f637));
  // PTX:247 mul.f32 %f240, %f631, %f636
  asm("mul.f32 %0, %1, %2;" : "=f"(f240) : "f"(f631), "f"(f636));
  // PTX:248 sub.f32 %f241, %f240, %f239
  asm("sub.f32 %0, %1, %2;" : "=f"(f241) : "f"(f240), "f"(f239));
  // PTX:249 mul.f32 %f242, %f631, %f635
  asm("mul.f32 %0, %1, %2;" : "=f"(f242) : "f"(f631), "f"(f635));
  // PTX:250 mul.f32 %f243, %f629, %f637
  asm("mul.f32 %0, %1, %2;" : "=f"(f243) : "f"(f629), "f"(f637));
  // PTX:251 sub.f32 %f244, %f243, %f242
  asm("sub.f32 %0, %1, %2;" : "=f"(f244) : "f"(f243), "f"(f242));
  // PTX:252 mul.f32 %f245, %f629, %f636
  asm("mul.f32 %0, %1, %2;" : "=f"(f245) : "f"(f629), "f"(f636));
  // PTX:253 mul.f32 %f246, %f630, %f635
  asm("mul.f32 %0, %1, %2;" : "=f"(f246) : "f"(f630), "f"(f635));
  // PTX:254 sub.f32 %f247, %f246, %f245
  asm("sub.f32 %0, %1, %2;" : "=f"(f247) : "f"(f246), "f"(f245));
  // PTX:255 mul.f32 %f248, %f631, %f633
  asm("mul.f32 %0, %1, %2;" : "=f"(f248) : "f"(f631), "f"(f633));
  // PTX:256 mul.f32 %f249, %f630, %f634
  asm("mul.f32 %0, %1, %2;" : "=f"(f249) : "f"(f630), "f"(f634));
  // PTX:257 sub.f32 %f250, %f249, %f248
  asm("sub.f32 %0, %1, %2;" : "=f"(f250) : "f"(f249), "f"(f248));
  // PTX:258 mul.f32 %f251, %f629, %f634
  asm("mul.f32 %0, %1, %2;" : "=f"(f251) : "f"(f629), "f"(f634));
  // PTX:259 mul.f32 %f252, %f631, %f632
  asm("mul.f32 %0, %1, %2;" : "=f"(f252) : "f"(f631), "f"(f632));
  // PTX:260 sub.f32 %f253, %f252, %f251
  asm("sub.f32 %0, %1, %2;" : "=f"(f253) : "f"(f252), "f"(f251));
  // PTX:261 mul.f32 %f254, %f630, %f632
  asm("mul.f32 %0, %1, %2;" : "=f"(f254) : "f"(f630), "f"(f632));
  // PTX:262 mul.f32 %f255, %f629, %f633
  asm("mul.f32 %0, %1, %2;" : "=f"(f255) : "f"(f629), "f"(f633));
  // PTX:263 sub.f32 %f256, %f255, %f254
  asm("sub.f32 %0, %1, %2;" : "=f"(f256) : "f"(f255), "f"(f254));
  // PTX:264 fma.rn.f32 %f257, %f50, %f238, %f629
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f257) : "f"(f50), "f"(f238), "f"(f629));
  // PTX:265 fma.rn.f32 %f258, %f51, %f238, %f630
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f258) : "f"(f51), "f"(f238), "f"(f630));
  // PTX:266 fma.rn.f32 %f259, %f52, %f238, %f631
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f259) : "f"(f52), "f"(f238), "f"(f631));
  // PTX:267 fma.rn.f32 %f260, %f241, %f238, %f632
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f260) : "f"(f241), "f"(f238), "f"(f632));
  // PTX:268 fma.rn.f32 %f261, %f244, %f238, %f633
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f261) : "f"(f244), "f"(f238), "f"(f633));
  // PTX:269 fma.rn.f32 %f262, %f247, %f238, %f634
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f262) : "f"(f247), "f"(f238), "f"(f634));
  // PTX:270 fma.rn.f32 %f263, %f250, %f238, %f635
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f263) : "f"(f250), "f"(f238), "f"(f635));
  // PTX:271 fma.rn.f32 %f264, %f253, %f238, %f636
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f264) : "f"(f253), "f"(f238), "f"(f636));
  // PTX:272 fma.rn.f32 %f265, %f256, %f238, %f637
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f265) : "f"(f256), "f"(f238), "f"(f637));
  // PTX:273 mul.f32 %f629, %f257, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f629) : "f"(f257));
  // PTX:274 mul.f32 %f630, %f258, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f630) : "f"(f258));
  // PTX:275 mul.f32 %f631, %f259, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f631) : "f"(f259));
  // PTX:276 mul.f32 %f632, %f260, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f632) : "f"(f260));
  // PTX:277 mul.f32 %f633, %f261, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f633) : "f"(f261));
  // PTX:278 mul.f32 %f634, %f262, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f634) : "f"(f262));
  // PTX:279 mul.f32 %f635, %f263, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f635) : "f"(f263));
  // PTX:280 mul.f32 %f636, %f264, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f636) : "f"(f264));
  // PTX:281 mul.f32 %f637, %f265, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f637) : "f"(f265));
  // PTX:282 add.s32 %r233, %r233, 2
  asm("add.s32 %0, %1, 2;" : "=r"(r233) : "r"(r233));
  // PTX:283 setp.lt.u32 %p12, %r233, 8
  p12 = (((unsigned)(r233)) < ((unsigned)(8)));
  // PTX:284 @%p12 bra $L__BB60_9
  if (p12) { goto L_BB60_9; }
  // PTX:286 $L__BB60_12:
L_BB60_12:;
  // PTX:287 mul.f32 %f266, %f630, %f630
  asm("mul.f32 %0, %1, %2;" : "=f"(f266) : "f"(f630), "f"(f630));
  // PTX:288 fma.rn.f32 %f267, %f629, %f629, %f266
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f267) : "f"(f629), "f"(f629), "f"(f266));
  // PTX:289 fma.rn.f32 %f268, %f631, %f631, %f267
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f268) : "f"(f631), "f"(f631), "f"(f267));
  // PTX:290 sqrt.rn.f32 %f72, %f268
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f72) : "f"(f268));
  // PTX:291 setp.leu.f32 %p13, %f72, 0f00000000
  p13 = ((isnan(((float)(f72))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f72)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:292 mov.u32 %r246, 0
  asm("mov.u32 %0, 0;" : "=r"(r246) : );
  // PTX:293 mov.u32 %r234, %r246
  asm("mov.u32 %0, %1;" : "=r"(r234) : "r"(r246));
  // PTX:294 mov.u32 %r235, %r246
  asm("mov.u32 %0, %1;" : "=r"(r235) : "r"(r246));
  // PTX:295 mov.u32 %r236, %r246
  asm("mov.u32 %0, %1;" : "=r"(r236) : "r"(r246));
  // PTX:296 @%p13 bra $L__BB60_14
  if (p13) { goto L_BB60_14; }
  // PTX:298 div.rn.f32 %f269, %f629, %f72
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f269) : "f"(f629), "f"(f72));
  // PTX:299 div.rn.f32 %f270, %f630, %f72
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f270) : "f"(f630), "f"(f72));
  // PTX:300 div.rn.f32 %f271, %f631, %f72
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f271) : "f"(f631), "f"(f72));
  // PTX:301 mov.b32 %r236, %f271
  asm("mov.b32 %0, %1;" : "=r"(r236) : "f"(f271));
  // PTX:302 mov.b32 %r235, %f270
  asm("mov.b32 %0, %1;" : "=r"(r235) : "f"(f270));
  // PTX:303 mov.b32 %r234, %f269
  asm("mov.b32 %0, %1;" : "=r"(r234) : "f"(f269));
  // PTX:305 $L__BB60_14:
L_BB60_14:;
  // PTX:306 mov.b32 %f73, %r234
  asm("mov.b32 %0, %1;" : "=f"(f73) : "r"(r234));
  // PTX:307 mov.b32 %f74, %r235
  asm("mov.b32 %0, %1;" : "=f"(f74) : "r"(r235));
  // PTX:308 mul.f32 %f272, %f633, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f272) : "f"(f633), "f"(f74));
  // PTX:309 mov.b32 %f75, %r236
  asm("mov.b32 %0, %1;" : "=f"(f75) : "r"(r236));
  // PTX:310 fma.rn.f32 %f273, %f632, %f73, %f272
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f273) : "f"(f632), "f"(f73), "f"(f272));
  // PTX:311 fma.rn.f32 %f274, %f634, %f75, %f273
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f274) : "f"(f634), "f"(f75), "f"(f273));
  // PTX:312 mul.f32 %f275, %f274, %f73
  asm("mul.f32 %0, %1, %2;" : "=f"(f275) : "f"(f274), "f"(f73));
  // PTX:313 mul.f32 %f276, %f274, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f276) : "f"(f274), "f"(f74));
  // PTX:314 mul.f32 %f277, %f274, %f75
  asm("mul.f32 %0, %1, %2;" : "=f"(f277) : "f"(f274), "f"(f75));
  // PTX:315 sub.f32 %f76, %f632, %f275
  asm("sub.f32 %0, %1, %2;" : "=f"(f76) : "f"(f632), "f"(f275));
  // PTX:316 sub.f32 %f77, %f633, %f276
  asm("sub.f32 %0, %1, %2;" : "=f"(f77) : "f"(f633), "f"(f276));
  // PTX:317 sub.f32 %f78, %f634, %f277
  asm("sub.f32 %0, %1, %2;" : "=f"(f78) : "f"(f634), "f"(f277));
  // PTX:318 mul.f32 %f278, %f77, %f77
  asm("mul.f32 %0, %1, %2;" : "=f"(f278) : "f"(f77), "f"(f77));
  // PTX:319 fma.rn.f32 %f279, %f76, %f76, %f278
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f279) : "f"(f76), "f"(f76), "f"(f278));
  // PTX:320 fma.rn.f32 %f280, %f78, %f78, %f279
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f280) : "f"(f78), "f"(f78), "f"(f279));
  // PTX:321 sqrt.rn.f32 %f79, %f280
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f79) : "f"(f280));
  // PTX:322 setp.leu.f32 %p14, %f79, 0f00000000
  p14 = ((isnan(((float)(f79))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f79)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:323 mov.u32 %r247, %r246
  asm("mov.u32 %0, %1;" : "=r"(r247) : "r"(r246));
  // PTX:324 mov.u32 %r248, %r246
  asm("mov.u32 %0, %1;" : "=r"(r248) : "r"(r246));
  // PTX:325 @%p14 bra $L__BB60_16
  if (p14) { goto L_BB60_16; }
  // PTX:327 div.rn.f32 %f281, %f76, %f79
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f281) : "f"(f76), "f"(f79));
  // PTX:328 div.rn.f32 %f282, %f77, %f79
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f282) : "f"(f77), "f"(f79));
  // PTX:329 div.rn.f32 %f283, %f78, %f79
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f283) : "f"(f78), "f"(f79));
  // PTX:330 mov.b32 %r248, %f283
  asm("mov.b32 %0, %1;" : "=r"(r248) : "f"(f283));
  // PTX:331 mov.b32 %r247, %f282
  asm("mov.b32 %0, %1;" : "=r"(r247) : "f"(f282));
  // PTX:332 mov.b32 %r246, %f281
  asm("mov.b32 %0, %1;" : "=r"(r246) : "f"(f281));
  // PTX:334 $L__BB60_16:
L_BB60_16:;
  // PTX:335 mul.f32 %f284, %f74, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f284) : "f"(f74), "f"(f74));
  // PTX:336 fma.rn.f32 %f285, %f73, %f73, %f284
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f285) : "f"(f73), "f"(f73), "f"(f284));
  // PTX:337 fma.rn.f32 %f286, %f75, %f75, %f285
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f286) : "f"(f75), "f"(f75), "f"(f285));
  // PTX:338 sqrt.rn.f32 %f287, %f286
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f287) : "f"(f286));
  // PTX:339 setp.le.f32 %p15, %f287, 0f322BCC77
  p15 = (!(isnan(((float)(f287))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f287)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:340 mov.u32 %r250, 0
  asm("mov.u32 %0, 0;" : "=r"(r250) : );
  // PTX:341 mov.u32 %r251, %r250
  asm("mov.u32 %0, %1;" : "=r"(r251) : "r"(r250));
  // PTX:342 mov.u32 %r252, %r250
  asm("mov.u32 %0, %1;" : "=r"(r252) : "r"(r250));
  // PTX:343 mov.u32 %r253, %r249
  asm("mov.u32 %0, %1;" : "=r"(r253) : "r"(r249));
  // PTX:344 mov.u32 %r254, %r250
  asm("mov.u32 %0, %1;" : "=r"(r254) : "r"(r250));
  // PTX:345 mov.u32 %r255, %r250
  asm("mov.u32 %0, %1;" : "=r"(r255) : "r"(r250));
  // PTX:346 mov.u32 %r256, %r250
  asm("mov.u32 %0, %1;" : "=r"(r256) : "r"(r250));
  // PTX:347 mov.u32 %r257, %r249
  asm("mov.u32 %0, %1;" : "=r"(r257) : "r"(r249));
  // PTX:348 @%p15 bra $L__BB60_23
  if (p15) { goto L_BB60_23; }
  // PTX:350 mov.b32 %f80, %r246
  asm("mov.b32 %0, %1;" : "=f"(f80) : "r"(r246));
  // PTX:351 mov.b32 %f81, %r247
  asm("mov.b32 %0, %1;" : "=f"(f81) : "r"(r247));
  // PTX:352 mul.f32 %f288, %f81, %f81
  asm("mul.f32 %0, %1, %2;" : "=f"(f288) : "f"(f81), "f"(f81));
  // PTX:353 mov.b32 %f82, %r248
  asm("mov.b32 %0, %1;" : "=f"(f82) : "r"(r248));
  // PTX:354 fma.rn.f32 %f289, %f80, %f80, %f288
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f289) : "f"(f80), "f"(f80), "f"(f288));
  // PTX:355 fma.rn.f32 %f290, %f82, %f82, %f289
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f290) : "f"(f82), "f"(f82), "f"(f289));
  // PTX:356 sqrt.rn.f32 %f291, %f290
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f291) : "f"(f290));
  // PTX:357 setp.le.f32 %p16, %f291, 0f322BCC77
  p16 = (!(isnan(((float)(f291))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f291)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:358 mov.u32 %r253, %r249
  asm("mov.u32 %0, %1;" : "=r"(r253) : "r"(r249));
  // PTX:359 mov.u32 %r257, %r249
  asm("mov.u32 %0, %1;" : "=r"(r257) : "r"(r249));
  // PTX:360 @%p16 bra $L__BB60_23
  if (p16) { goto L_BB60_23; }
  // PTX:362 mul.f32 %f292, %f74, %f82
  asm("mul.f32 %0, %1, %2;" : "=f"(f292) : "f"(f74), "f"(f82));
  // PTX:363 mul.f32 %f293, %f75, %f81
  asm("mul.f32 %0, %1, %2;" : "=f"(f293) : "f"(f75), "f"(f81));
  // PTX:364 sub.f32 %f83, %f292, %f293
  asm("sub.f32 %0, %1, %2;" : "=f"(f83) : "f"(f292), "f"(f293));
  // PTX:365 mul.f32 %f294, %f73, %f82
  asm("mul.f32 %0, %1, %2;" : "=f"(f294) : "f"(f73), "f"(f82));
  // PTX:366 mul.f32 %f295, %f75, %f80
  asm("mul.f32 %0, %1, %2;" : "=f"(f295) : "f"(f75), "f"(f80));
  // PTX:367 sub.f32 %f84, %f295, %f294
  asm("sub.f32 %0, %1, %2;" : "=f"(f84) : "f"(f295), "f"(f294));
  // PTX:368 mul.f32 %f296, %f74, %f80
  asm("mul.f32 %0, %1, %2;" : "=f"(f296) : "f"(f74), "f"(f80));
  // PTX:369 mul.f32 %f297, %f73, %f81
  asm("mul.f32 %0, %1, %2;" : "=f"(f297) : "f"(f73), "f"(f81));
  // PTX:370 sub.f32 %f85, %f297, %f296
  asm("sub.f32 %0, %1, %2;" : "=f"(f85) : "f"(f297), "f"(f296));
  // PTX:371 mul.f32 %f298, %f84, %f84
  asm("mul.f32 %0, %1, %2;" : "=f"(f298) : "f"(f84), "f"(f84));
  // PTX:372 fma.rn.f32 %f299, %f83, %f83, %f298
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f299) : "f"(f83), "f"(f83), "f"(f298));
  // PTX:373 fma.rn.f32 %f300, %f85, %f85, %f299
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f300) : "f"(f85), "f"(f85), "f"(f299));
  // PTX:374 sqrt.rn.f32 %f86, %f300
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f86) : "f"(f300));
  // PTX:375 setp.leu.f32 %p17, %f86, 0f00000000
  p17 = ((isnan(((float)(f86))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f86)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:376 mov.u32 %r255, 0
  asm("mov.u32 %0, 0;" : "=r"(r255) : );
  // PTX:377 mov.u32 %r256, %r255
  asm("mov.u32 %0, %1;" : "=r"(r256) : "r"(r255));
  // PTX:378 mov.u32 %r257, %r255
  asm("mov.u32 %0, %1;" : "=r"(r257) : "r"(r255));
  // PTX:379 @%p17 bra $L__BB60_20
  if (p17) { goto L_BB60_20; }
  // PTX:381 div.rn.f32 %f301, %f83, %f86
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f301) : "f"(f83), "f"(f86));
  // PTX:382 div.rn.f32 %f302, %f84, %f86
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f302) : "f"(f84), "f"(f86));
  // PTX:383 div.rn.f32 %f303, %f85, %f86
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f303) : "f"(f85), "f"(f86));
  // PTX:384 mov.b32 %r257, %f303
  asm("mov.b32 %0, %1;" : "=r"(r257) : "f"(f303));
  // PTX:385 mov.b32 %r256, %f302
  asm("mov.b32 %0, %1;" : "=r"(r256) : "f"(f302));
  // PTX:386 mov.b32 %r255, %f301
  asm("mov.b32 %0, %1;" : "=r"(r255) : "f"(f301));
  // PTX:388 $L__BB60_20:
L_BB60_20:;
  // PTX:389 mov.b32 %f87, %r255
  asm("mov.b32 %0, %1;" : "=f"(f87) : "r"(r255));
  // PTX:390 mov.b32 %f88, %r256
  asm("mov.b32 %0, %1;" : "=f"(f88) : "r"(r256));
  // PTX:391 mul.f32 %f304, %f636, %f88
  asm("mul.f32 %0, %1, %2;" : "=f"(f304) : "f"(f636), "f"(f88));
  // PTX:392 mov.b32 %f89, %r257
  asm("mov.b32 %0, %1;" : "=f"(f89) : "r"(r257));
  // PTX:393 fma.rn.f32 %f305, %f635, %f87, %f304
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f305) : "f"(f635), "f"(f87), "f"(f304));
  // PTX:394 fma.rn.f32 %f306, %f637, %f89, %f305
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f306) : "f"(f637), "f"(f89), "f"(f305));
  // PTX:395 setp.geu.f32 %p18, %f306, 0f00000000
  p18 = ((isnan(((float)(f306))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f306)) >= ((float)(as_f32(0x00000000u)))));
  // PTX:396 @%p18 bra $L__BB60_22
  if (p18) { goto L_BB60_22; }
  // PTX:398 neg.f32 %f307, %f80
  asm("neg.f32 %0, %1;" : "=f"(f307) : "f"(f80));
  // PTX:399 mov.b32 %r246, %f307
  asm("mov.b32 %0, %1;" : "=r"(r246) : "f"(f307));
  // PTX:400 neg.f32 %f308, %f81
  asm("neg.f32 %0, %1;" : "=f"(f308) : "f"(f81));
  // PTX:401 mov.b32 %r247, %f308
  asm("mov.b32 %0, %1;" : "=r"(r247) : "f"(f308));
  // PTX:402 neg.f32 %f309, %f82
  asm("neg.f32 %0, %1;" : "=f"(f309) : "f"(f82));
  // PTX:403 mov.b32 %r248, %f309
  asm("mov.b32 %0, %1;" : "=r"(r248) : "f"(f309));
  // PTX:404 neg.f32 %f310, %f87
  asm("neg.f32 %0, %1;" : "=f"(f310) : "f"(f87));
  // PTX:405 mov.b32 %r255, %f310
  asm("mov.b32 %0, %1;" : "=r"(r255) : "f"(f310));
  // PTX:406 neg.f32 %f311, %f88
  asm("neg.f32 %0, %1;" : "=f"(f311) : "f"(f88));
  // PTX:407 mov.b32 %r256, %f311
  asm("mov.b32 %0, %1;" : "=r"(r256) : "f"(f311));
  // PTX:408 neg.f32 %f312, %f89
  asm("neg.f32 %0, %1;" : "=f"(f312) : "f"(f89));
  // PTX:409 mov.b32 %r257, %f312
  asm("mov.b32 %0, %1;" : "=r"(r257) : "f"(f312));
  // PTX:411 $L__BB60_22:
L_BB60_22:;
  // PTX:412 mov.u32 %r249, %r234
  asm("mov.u32 %0, %1;" : "=r"(r249) : "r"(r234));
  // PTX:413 mov.u32 %r250, %r235
  asm("mov.u32 %0, %1;" : "=r"(r250) : "r"(r235));
  // PTX:414 mov.u32 %r251, %r236
  asm("mov.u32 %0, %1;" : "=r"(r251) : "r"(r236));
  // PTX:415 mov.u32 %r252, %r246
  asm("mov.u32 %0, %1;" : "=r"(r252) : "r"(r246));
  // PTX:416 mov.u32 %r253, %r247
  asm("mov.u32 %0, %1;" : "=r"(r253) : "r"(r247));
  // PTX:417 mov.u32 %r254, %r248
  asm("mov.u32 %0, %1;" : "=r"(r254) : "r"(r248));
  // PTX:419 $L__BB60_23:
L_BB60_23:;
  // PTX:420 mov.b32 %f648, %r249
  asm("mov.b32 %0, %1;" : "=f"(f648) : "r"(r249));
  // PTX:421 mov.b32 %f649, %r252
  asm("mov.b32 %0, %1;" : "=f"(f649) : "r"(r252));
  // PTX:422 mov.b32 %f652, %r255
  asm("mov.b32 %0, %1;" : "=f"(f652) : "r"(r255));
  // PTX:423 mov.b32 %f647, %r250
  asm("mov.b32 %0, %1;" : "=f"(f647) : "r"(r250));
  // PTX:424 mov.b32 %f650, %r253
  asm("mov.b32 %0, %1;" : "=f"(f650) : "r"(r253));
  // PTX:425 mov.b32 %f653, %r256
  asm("mov.b32 %0, %1;" : "=f"(f653) : "r"(r256));
  // PTX:426 mov.b32 %f646, %r251
  asm("mov.b32 %0, %1;" : "=f"(f646) : "r"(r251));
  // PTX:427 mov.b32 %f651, %r254
  asm("mov.b32 %0, %1;" : "=f"(f651) : "r"(r254));
  // PTX:428 mov.b32 %f654, %r257
  asm("mov.b32 %0, %1;" : "=f"(f654) : "r"(r257));
  // PTX:430 $L__BB60_24:
L_BB60_24:;
  // PTX:431 cvta.to.global.u64 %rd10, %rd24
  rd10 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd24));
  // PTX:432 add.u64 %rd11, %SPL, 16
  asm("add.u64 %0, %1, 16;" : "=l"(rd11) : "l"(SPL));
  // PTX:433 cvta.to.global.u64 %rd47, %rd23
  rd47 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd23));
  // PTX:434 shl.b64 %rd48, %rd61, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd48) : "l"(rd61));
  // PTX:435 add.s64 %rd49, %rd47, %rd48
  asm("add.s64 %0, %1, %2;" : "=l"(rd49) : "l"(rd47), "l"(rd48));
  // PTX:436 ld.global.f32 %f313, [%rd49]
  f313 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))));
  // PTX:437 mul.f32 %f116, %f313, %f168
  asm("mul.f32 %0, %1, %2;" : "=f"(f116) : "f"(f313), "f"(f168));
  // PTX:438 mul.f32 %f314, %f645, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f314) : "f"(f645));
  // PTX:439 fma.rn.f32 %f315, %f1, 0f00000000, %f314
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f315) : "f"(f1), "f"(f314));
  // PTX:440 fma.rn.f32 %f117, %f644, 0f00000000, %f315
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f117) : "f"(f644), "f"(f315));
  // PTX:441 mul.f32 %f316, %f642, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f316) : "f"(f642));
  // PTX:442 fma.rn.f32 %f317, %f643, 0f00000000, %f316
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f317) : "f"(f643), "f"(f316));
  // PTX:443 fma.rn.f32 %f118, %f641, 0f00000000, %f317
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f118) : "f"(f641), "f"(f317));
  // PTX:444 mul.f32 %f318, %f639, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f318) : "f"(f639));
  // PTX:445 fma.rn.f32 %f319, %f640, 0f00000000, %f318
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f319) : "f"(f640), "f"(f318));
  // PTX:446 fma.rn.f32 %f119, %f638, 0f00000000, %f319
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f119) : "f"(f638), "f"(f319));
  // PTX:447 add.f32 %f320, %f118, %f118
  asm("add.f32 %0, %1, %2;" : "=f"(f320) : "f"(f118), "f"(f118));
  // PTX:448 add.f32 %f321, %f119, %f118
  asm("add.f32 %0, %1, %2;" : "=f"(f321) : "f"(f119), "f"(f118));
  // PTX:449 add.f32 %f322, %f119, %f119
  asm("add.f32 %0, %1, %2;" : "=f"(f322) : "f"(f119), "f"(f119));
  // PTX:450 mul.f32 %f120, %f320, %f643
  asm("mul.f32 %0, %1, %2;" : "=f"(f120) : "f"(f320), "f"(f643));
  // PTX:451 mul.f32 %f121, %f321, %f643
  asm("mul.f32 %0, %1, %2;" : "=f"(f121) : "f"(f321), "f"(f643));
  // PTX:452 mul.f32 %f122, %f321, %f640
  asm("mul.f32 %0, %1, %2;" : "=f"(f122) : "f"(f321), "f"(f640));
  // PTX:453 mul.f32 %f123, %f322, %f640
  asm("mul.f32 %0, %1, %2;" : "=f"(f123) : "f"(f322), "f"(f640));
  // PTX:454 mul.f32 %f124, %f320, %f642
  asm("mul.f32 %0, %1, %2;" : "=f"(f124) : "f"(f320), "f"(f642));
  // PTX:455 mul.f32 %f125, %f321, %f642
  asm("mul.f32 %0, %1, %2;" : "=f"(f125) : "f"(f321), "f"(f642));
  // PTX:456 mul.f32 %f126, %f321, %f639
  asm("mul.f32 %0, %1, %2;" : "=f"(f126) : "f"(f321), "f"(f639));
  // PTX:457 mul.f32 %f127, %f322, %f639
  asm("mul.f32 %0, %1, %2;" : "=f"(f127) : "f"(f322), "f"(f639));
  // PTX:458 mul.f32 %f128, %f320, %f641
  asm("mul.f32 %0, %1, %2;" : "=f"(f128) : "f"(f320), "f"(f641));
  // PTX:459 mul.f32 %f129, %f321, %f641
  asm("mul.f32 %0, %1, %2;" : "=f"(f129) : "f"(f321), "f"(f641));
  // PTX:460 mul.f32 %f130, %f321, %f638
  asm("mul.f32 %0, %1, %2;" : "=f"(f130) : "f"(f321), "f"(f638));
  // PTX:461 mul.f32 %f131, %f322, %f638
  asm("mul.f32 %0, %1, %2;" : "=f"(f131) : "f"(f322), "f"(f638));
  // PTX:462 mul.f32 %f132, %f646, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f132) : "f"(f646));
  // PTX:463 mul.f32 %f133, %f651, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f133) : "f"(f651));
  // PTX:464 mul.f32 %f134, %f654, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f134) : "f"(f654));
  // PTX:465 add.f32 %f323, %f117, %f117
  asm("add.f32 %0, %1, %2;" : "=f"(f323) : "f"(f117), "f"(f117));
  // PTX:466 add.f32 %f324, %f119, %f117
  asm("add.f32 %0, %1, %2;" : "=f"(f324) : "f"(f119), "f"(f117));
  // PTX:467 mul.f32 %f135, %f323, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f135) : "f"(f323), "f"(f1));
  // PTX:468 mul.f32 %f136, %f324, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f136) : "f"(f324), "f"(f1));
  // PTX:469 mul.f32 %f137, %f324, %f640
  asm("mul.f32 %0, %1, %2;" : "=f"(f137) : "f"(f324), "f"(f640));
  // PTX:470 mul.f32 %f138, %f323, %f645
  asm("mul.f32 %0, %1, %2;" : "=f"(f138) : "f"(f323), "f"(f645));
  // PTX:471 mul.f32 %f139, %f324, %f645
  asm("mul.f32 %0, %1, %2;" : "=f"(f139) : "f"(f324), "f"(f645));
  // PTX:472 mul.f32 %f140, %f324, %f639
  asm("mul.f32 %0, %1, %2;" : "=f"(f140) : "f"(f324), "f"(f639));
  // PTX:473 mul.f32 %f141, %f323, %f644
  asm("mul.f32 %0, %1, %2;" : "=f"(f141) : "f"(f323), "f"(f644));
  // PTX:474 mul.f32 %f142, %f324, %f644
  asm("mul.f32 %0, %1, %2;" : "=f"(f142) : "f"(f324), "f"(f644));
  // PTX:475 mul.f32 %f143, %f324, %f638
  asm("mul.f32 %0, %1, %2;" : "=f"(f143) : "f"(f324), "f"(f638));
  // PTX:476 add.f32 %f325, %f118, %f117
  asm("add.f32 %0, %1, %2;" : "=f"(f325) : "f"(f118), "f"(f117));
  // PTX:477 fma.rn.f32 %f144, %f325, %f643, %f135
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f144) : "f"(f325), "f"(f643), "f"(f135));
  // PTX:478 fma.rn.f32 %f145, %f325, %f1, %f120
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f145) : "f"(f325), "f"(f1), "f"(f120));
  // PTX:479 fma.rn.f32 %f146, %f325, %f642, %f138
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f146) : "f"(f325), "f"(f642), "f"(f138));
  // PTX:480 fma.rn.f32 %f147, %f325, %f645, %f124
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f147) : "f"(f325), "f"(f645), "f"(f124));
  // PTX:481 fma.rn.f32 %f148, %f325, %f641, %f141
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f148) : "f"(f325), "f"(f641), "f"(f141));
  // PTX:482 fma.rn.f32 %f149, %f325, %f644, %f128
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f149) : "f"(f325), "f"(f644), "f"(f128));
  // PTX:483 mul.f32 %f150, %f648, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f150) : "f"(f648));
  // PTX:484 mul.f32 %f151, %f647, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f151) : "f"(f647));
  // PTX:485 add.f32 %f152, %f150, %f151
  asm("add.f32 %0, %1, %2;" : "=f"(f152) : "f"(f150), "f"(f151));
  // PTX:486 mul.f32 %f153, %f649, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f153) : "f"(f649));
  // PTX:487 mul.f32 %f154, %f650, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f154) : "f"(f650));
  // PTX:488 add.f32 %f155, %f153, %f154
  asm("add.f32 %0, %1, %2;" : "=f"(f155) : "f"(f153), "f"(f154));
  // PTX:489 mul.f32 %f156, %f652, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f156) : "f"(f652));
  // PTX:490 mul.f32 %f157, %f653, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f157) : "f"(f653));
  // PTX:491 add.f32 %f158, %f156, %f157
  asm("add.f32 %0, %1, %2;" : "=f"(f158) : "f"(f156), "f"(f157));
  // PTX:492 mov.u32 %r221, 0
  asm("mov.u32 %0, 0;" : "=r"(r221) : );
  // PTX:493 mov.u64 %rd62, %rd2
  asm("mov.u64 %0, %1;" : "=l"(rd62) : "l"(rd2));
  // PTX:494 mov.u64 %rd63, %rd11
  asm("mov.u64 %0, %1;" : "=l"(rd63) : "l"(rd11));
  // PTX:495 mov.u32 %r258, %r221
  asm("mov.u32 %0, %1;" : "=r"(r258) : "r"(r221));
  // PTX:497 $L__BB60_25:
L_BB60_25:;
  // PTX:498 ld.param.u32 %r230, [_ZN7synreal6kernel43add_affine_body_constitutive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_4]
  r230 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param4 + (0))));
  // PTX:499 st.local.v4.u32 [%rd11], {%r221, %r221, %r221, %r221}
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (0))))) = (unsigned)(r221); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (4))))) = (unsigned)(r221); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (8))))) = (unsigned)(r221); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (12))))) = (unsigned)(r221);
  // PTX:500 st.local.v4.u32 [%rd11+16], {%r221, %r221, %r221, %r221}
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (16))))) = (unsigned)(r221); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (20))))) = (unsigned)(r221); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (24))))) = (unsigned)(r221); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (28))))) = (unsigned)(r221);
  // PTX:501 st.local.v4.u32 [%rd11+32], {%r221, %r221, %r221, %r221}
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (32))))) = (unsigned)(r221); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (36))))) = (unsigned)(r221); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (40))))) = (unsigned)(r221); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (44))))) = (unsigned)(r221);
  // PTX:502 mov.u32 %r223, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r223) : );
  // PTX:503 st.local.u32 [%rd63], %r223
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd63) + (0))))) = (unsigned)(r223);
  // PTX:504 ld.local.f32 %f159, [%rd11+12]
  f159 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (12)))));
  // PTX:505 ld.local.u32 %r69, [%rd11+24]
  r69 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (24)))));
  // PTX:506 ld.local.u32 %r70, [%rd11+36]
  r70 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (36)))));
  // PTX:507 setp.eq.s32 %p19, %r230, 1
  p19 = (((int)(r230)) == ((int)(1)));
  // PTX:508 @%p19 bra $L__BB60_27
  if (p19) { goto L_BB60_27; }
  // PTX:509 bra.uni $L__BB60_26
  goto L_BB60_26;
  // PTX:511 $L__BB60_27:
L_BB60_27:;
  // PTX:512 mov.b32 %f387, %r69
  asm("mov.b32 %0, %1;" : "=f"(f387) : "r"(r69));
  // PTX:513 mul.f32 %f388, %f645, %f387
  asm("mul.f32 %0, %1, %2;" : "=f"(f388) : "f"(f645), "f"(f387));
  // PTX:514 fma.rn.f32 %f389, %f159, %f1, %f388
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f389) : "f"(f159), "f"(f1), "f"(f388));
  // PTX:515 mov.b32 %f390, %r70
  asm("mov.b32 %0, %1;" : "=f"(f390) : "r"(r70));
  // PTX:516 fma.rn.f32 %f391, %f644, %f390, %f389
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f391) : "f"(f644), "f"(f390), "f"(f389));
  // PTX:517 mul.f32 %f392, %f642, %f387
  asm("mul.f32 %0, %1, %2;" : "=f"(f392) : "f"(f642), "f"(f387));
  // PTX:518 fma.rn.f32 %f393, %f159, %f643, %f392
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f393) : "f"(f159), "f"(f643), "f"(f392));
  // PTX:519 fma.rn.f32 %f394, %f641, %f390, %f393
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f394) : "f"(f641), "f"(f390), "f"(f393));
  // PTX:520 mul.f32 %f395, %f639, %f387
  asm("mul.f32 %0, %1, %2;" : "=f"(f395) : "f"(f639), "f"(f387));
  // PTX:521 fma.rn.f32 %f396, %f159, %f640, %f395
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f396) : "f"(f159), "f"(f640), "f"(f395));
  // PTX:522 fma.rn.f32 %f397, %f638, %f390, %f396
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f397) : "f"(f638), "f"(f390), "f"(f396));
  // PTX:523 add.f32 %f398, %f391, %f391
  asm("add.f32 %0, %1, %2;" : "=f"(f398) : "f"(f391), "f"(f391));
  // PTX:524 add.f32 %f399, %f394, %f117
  asm("add.f32 %0, %1, %2;" : "=f"(f399) : "f"(f394), "f"(f117));
  // PTX:525 add.f32 %f400, %f397, %f117
  asm("add.f32 %0, %1, %2;" : "=f"(f400) : "f"(f397), "f"(f117));
  // PTX:526 mul.f32 %f401, %f399, %f643
  asm("mul.f32 %0, %1, %2;" : "=f"(f401) : "f"(f399), "f"(f643));
  // PTX:527 fma.rn.f32 %f402, %f398, %f1, %f401
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f402) : "f"(f398), "f"(f1), "f"(f401));
  // PTX:528 fma.rn.f32 %f403, %f399, %f1, %f120
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f403) : "f"(f399), "f"(f1), "f"(f120));
  // PTX:529 fma.rn.f32 %f404, %f400, %f1, %f121
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f404) : "f"(f400), "f"(f1), "f"(f121));
  // PTX:530 fma.rn.f32 %f405, %f400, %f640, %f402
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f405) : "f"(f400), "f"(f640), "f"(f402));
  // PTX:531 add.f32 %f406, %f403, %f122
  asm("add.f32 %0, %1, %2;" : "=f"(f406) : "f"(f403), "f"(f122));
  // PTX:532 add.f32 %f407, %f123, %f404
  asm("add.f32 %0, %1, %2;" : "=f"(f407) : "f"(f123), "f"(f404));
  // PTX:533 mul.f32 %f408, %f399, %f642
  asm("mul.f32 %0, %1, %2;" : "=f"(f408) : "f"(f399), "f"(f642));
  // PTX:534 fma.rn.f32 %f409, %f398, %f645, %f408
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f409) : "f"(f398), "f"(f645), "f"(f408));
  // PTX:535 fma.rn.f32 %f410, %f399, %f645, %f124
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f410) : "f"(f399), "f"(f645), "f"(f124));
  // PTX:536 fma.rn.f32 %f411, %f400, %f645, %f125
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f411) : "f"(f400), "f"(f645), "f"(f125));
  // PTX:537 fma.rn.f32 %f412, %f400, %f639, %f409
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f412) : "f"(f400), "f"(f639), "f"(f409));
  // PTX:538 add.f32 %f413, %f410, %f126
  asm("add.f32 %0, %1, %2;" : "=f"(f413) : "f"(f410), "f"(f126));
  // PTX:539 add.f32 %f414, %f127, %f411
  asm("add.f32 %0, %1, %2;" : "=f"(f414) : "f"(f127), "f"(f411));
  // PTX:540 mul.f32 %f415, %f399, %f641
  asm("mul.f32 %0, %1, %2;" : "=f"(f415) : "f"(f399), "f"(f641));
  // PTX:541 fma.rn.f32 %f416, %f398, %f644, %f415
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f416) : "f"(f398), "f"(f644), "f"(f415));
  // PTX:542 fma.rn.f32 %f417, %f399, %f644, %f128
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f417) : "f"(f399), "f"(f644), "f"(f128));
  // PTX:543 fma.rn.f32 %f418, %f400, %f644, %f129
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f418) : "f"(f400), "f"(f644), "f"(f129));
  // PTX:544 fma.rn.f32 %f419, %f400, %f638, %f416
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f419) : "f"(f400), "f"(f638), "f"(f416));
  // PTX:545 add.f32 %f420, %f417, %f130
  asm("add.f32 %0, %1, %2;" : "=f"(f420) : "f"(f417), "f"(f130));
  // PTX:546 add.f32 %f421, %f131, %f418
  asm("add.f32 %0, %1, %2;" : "=f"(f421) : "f"(f131), "f"(f418));
  // PTX:547 mov.b32 %r265, %f419
  asm("mov.b32 %0, %1;" : "=r"(r265) : "f"(f419));
  // PTX:548 mov.b32 %r262, %f412
  asm("mov.b32 %0, %1;" : "=r"(r262) : "f"(f412));
  // PTX:549 mov.b32 %r259, %f405
  asm("mov.b32 %0, %1;" : "=r"(r259) : "f"(f405));
  // PTX:550 mov.b32 %r267, %f421
  asm("mov.b32 %0, %1;" : "=r"(r267) : "f"(f421));
  // PTX:551 mov.b32 %r266, %f420
  asm("mov.b32 %0, %1;" : "=r"(r266) : "f"(f420));
  // PTX:552 mov.b32 %r264, %f414
  asm("mov.b32 %0, %1;" : "=r"(r264) : "f"(f414));
  // PTX:553 mov.b32 %r263, %f413
  asm("mov.b32 %0, %1;" : "=r"(r263) : "f"(f413));
  // PTX:554 mov.b32 %r261, %f407
  asm("mov.b32 %0, %1;" : "=r"(r261) : "f"(f407));
  // PTX:555 mov.b32 %r260, %f406
  asm("mov.b32 %0, %1;" : "=r"(r260) : "f"(f406));
  // PTX:556 bra.uni $L__BB60_28
  goto L_BB60_28;
  // PTX:558 $L__BB60_26:
L_BB60_26:;
  // PTX:559 fma.rn.f32 %f326, %f648, %f159, %f151
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f326) : "f"(f648), "f"(f159), "f"(f151));
  // PTX:560 fma.rn.f32 %f327, %f649, %f159, %f154
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f327) : "f"(f649), "f"(f159), "f"(f154));
  // PTX:561 fma.rn.f32 %f328, %f652, %f159, %f157
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f328) : "f"(f652), "f"(f159), "f"(f157));
  // PTX:562 add.f32 %f329, %f326, %f132
  asm("add.f32 %0, %1, %2;" : "=f"(f329) : "f"(f326), "f"(f132));
  // PTX:563 add.f32 %f330, %f327, %f133
  asm("add.f32 %0, %1, %2;" : "=f"(f330) : "f"(f327), "f"(f133));
  // PTX:564 add.f32 %f331, %f328, %f134
  asm("add.f32 %0, %1, %2;" : "=f"(f331) : "f"(f328), "f"(f134));
  // PTX:565 mov.b32 %f332, %r69
  asm("mov.b32 %0, %1;" : "=f"(f332) : "r"(r69));
  // PTX:566 fma.rn.f32 %f333, %f648, %f332, %f151
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f333) : "f"(f648), "f"(f332), "f"(f151));
  // PTX:567 fma.rn.f32 %f334, %f649, %f332, %f154
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f334) : "f"(f649), "f"(f332), "f"(f154));
  // PTX:568 fma.rn.f32 %f335, %f652, %f332, %f157
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f335) : "f"(f652), "f"(f332), "f"(f157));
  // PTX:569 add.f32 %f336, %f333, %f132
  asm("add.f32 %0, %1, %2;" : "=f"(f336) : "f"(f333), "f"(f132));
  // PTX:570 add.f32 %f337, %f334, %f133
  asm("add.f32 %0, %1, %2;" : "=f"(f337) : "f"(f334), "f"(f133));
  // PTX:571 add.f32 %f338, %f335, %f134
  asm("add.f32 %0, %1, %2;" : "=f"(f338) : "f"(f335), "f"(f134));
  // PTX:572 mov.b32 %f339, %r70
  asm("mov.b32 %0, %1;" : "=f"(f339) : "r"(r70));
  // PTX:573 fma.rn.f32 %f340, %f648, %f339, %f151
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f340) : "f"(f648), "f"(f339), "f"(f151));
  // PTX:574 fma.rn.f32 %f341, %f649, %f339, %f154
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f341) : "f"(f649), "f"(f339), "f"(f154));
  // PTX:575 fma.rn.f32 %f342, %f652, %f339, %f157
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f342) : "f"(f652), "f"(f339), "f"(f157));
  // PTX:576 add.f32 %f343, %f340, %f132
  asm("add.f32 %0, %1, %2;" : "=f"(f343) : "f"(f340), "f"(f132));
  // PTX:577 add.f32 %f344, %f341, %f133
  asm("add.f32 %0, %1, %2;" : "=f"(f344) : "f"(f341), "f"(f133));
  // PTX:578 add.f32 %f345, %f342, %f134
  asm("add.f32 %0, %1, %2;" : "=f"(f345) : "f"(f342), "f"(f134));
  // PTX:579 add.f32 %f346, %f329, %f329
  asm("add.f32 %0, %1, %2;" : "=f"(f346) : "f"(f329), "f"(f329));
  // PTX:580 add.f32 %f347, %f330, %f336
  asm("add.f32 %0, %1, %2;" : "=f"(f347) : "f"(f330), "f"(f336));
  // PTX:581 add.f32 %f348, %f331, %f343
  asm("add.f32 %0, %1, %2;" : "=f"(f348) : "f"(f331), "f"(f343));
  // PTX:582 add.f32 %f349, %f337, %f337
  asm("add.f32 %0, %1, %2;" : "=f"(f349) : "f"(f337), "f"(f337));
  // PTX:583 add.f32 %f350, %f338, %f344
  asm("add.f32 %0, %1, %2;" : "=f"(f350) : "f"(f338), "f"(f344));
  // PTX:584 add.f32 %f351, %f345, %f345
  asm("add.f32 %0, %1, %2;" : "=f"(f351) : "f"(f345), "f"(f345));
  // PTX:585 add.f32 %f352, %f329, %f337
  asm("add.f32 %0, %1, %2;" : "=f"(f352) : "f"(f329), "f"(f337));
  // PTX:586 add.f32 %f353, %f352, %f345
  asm("add.f32 %0, %1, %2;" : "=f"(f353) : "f"(f352), "f"(f345));
  // PTX:587 add.f32 %f354, %f346, %f353
  asm("add.f32 %0, %1, %2;" : "=f"(f354) : "f"(f346), "f"(f353));
  // PTX:588 fma.rn.f32 %f355, %f353, 0f00000000, %f347
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f355) : "f"(f353), "f"(f347));
  // PTX:589 fma.rn.f32 %f356, %f353, 0f00000000, %f348
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f356) : "f"(f353), "f"(f348));
  // PTX:590 add.f32 %f357, %f349, %f353
  asm("add.f32 %0, %1, %2;" : "=f"(f357) : "f"(f349), "f"(f353));
  // PTX:591 fma.rn.f32 %f358, %f353, 0f00000000, %f350
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f358) : "f"(f353), "f"(f350));
  // PTX:592 add.f32 %f359, %f351, %f353
  asm("add.f32 %0, %1, %2;" : "=f"(f359) : "f"(f351), "f"(f353));
  // PTX:593 mul.f32 %f360, %f649, %f355
  asm("mul.f32 %0, %1, %2;" : "=f"(f360) : "f"(f649), "f"(f355));
  // PTX:594 mul.f32 %f361, %f650, %f355
  asm("mul.f32 %0, %1, %2;" : "=f"(f361) : "f"(f650), "f"(f355));
  // PTX:595 mul.f32 %f362, %f651, %f355
  asm("mul.f32 %0, %1, %2;" : "=f"(f362) : "f"(f651), "f"(f355));
  // PTX:596 fma.rn.f32 %f363, %f648, %f354, %f360
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f363) : "f"(f648), "f"(f354), "f"(f360));
  // PTX:597 fma.rn.f32 %f364, %f647, %f354, %f361
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f364) : "f"(f647), "f"(f354), "f"(f361));
  // PTX:598 fma.rn.f32 %f365, %f646, %f354, %f362
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f365) : "f"(f646), "f"(f354), "f"(f362));
  // PTX:599 fma.rn.f32 %f366, %f652, %f356, %f363
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f366) : "f"(f652), "f"(f356), "f"(f363));
  // PTX:600 fma.rn.f32 %f367, %f653, %f356, %f364
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f367) : "f"(f653), "f"(f356), "f"(f364));
  // PTX:601 fma.rn.f32 %f368, %f654, %f356, %f365
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f368) : "f"(f654), "f"(f356), "f"(f365));
  // PTX:602 mul.f32 %f369, %f648, %f355
  asm("mul.f32 %0, %1, %2;" : "=f"(f369) : "f"(f648), "f"(f355));
  // PTX:603 mul.f32 %f370, %f647, %f355
  asm("mul.f32 %0, %1, %2;" : "=f"(f370) : "f"(f647), "f"(f355));
  // PTX:604 mul.f32 %f371, %f646, %f355
  asm("mul.f32 %0, %1, %2;" : "=f"(f371) : "f"(f646), "f"(f355));
  // PTX:605 fma.rn.f32 %f372, %f649, %f357, %f369
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f372) : "f"(f649), "f"(f357), "f"(f369));
  // PTX:606 fma.rn.f32 %f373, %f650, %f357, %f370
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f373) : "f"(f650), "f"(f357), "f"(f370));
  // PTX:607 fma.rn.f32 %f374, %f651, %f357, %f371
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f374) : "f"(f651), "f"(f357), "f"(f371));
  // PTX:608 fma.rn.f32 %f375, %f652, %f358, %f372
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f375) : "f"(f652), "f"(f358), "f"(f372));
  // PTX:609 fma.rn.f32 %f376, %f653, %f358, %f373
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f376) : "f"(f653), "f"(f358), "f"(f373));
  // PTX:610 fma.rn.f32 %f377, %f654, %f358, %f374
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f377) : "f"(f654), "f"(f358), "f"(f374));
  // PTX:611 mul.f32 %f378, %f649, %f358
  asm("mul.f32 %0, %1, %2;" : "=f"(f378) : "f"(f649), "f"(f358));
  // PTX:612 mul.f32 %f379, %f650, %f358
  asm("mul.f32 %0, %1, %2;" : "=f"(f379) : "f"(f650), "f"(f358));
  // PTX:613 mul.f32 %f380, %f651, %f358
  asm("mul.f32 %0, %1, %2;" : "=f"(f380) : "f"(f651), "f"(f358));
  // PTX:614 fma.rn.f32 %f381, %f648, %f356, %f378
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f381) : "f"(f648), "f"(f356), "f"(f378));
  // PTX:615 fma.rn.f32 %f382, %f647, %f356, %f379
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f382) : "f"(f647), "f"(f356), "f"(f379));
  // PTX:616 fma.rn.f32 %f383, %f646, %f356, %f380
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f383) : "f"(f646), "f"(f356), "f"(f380));
  // PTX:617 fma.rn.f32 %f384, %f652, %f359, %f381
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f384) : "f"(f652), "f"(f359), "f"(f381));
  // PTX:618 fma.rn.f32 %f385, %f653, %f359, %f382
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f385) : "f"(f653), "f"(f359), "f"(f382));
  // PTX:619 fma.rn.f32 %f386, %f654, %f359, %f383
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f386) : "f"(f654), "f"(f359), "f"(f383));
  // PTX:620 mov.b32 %r267, %f386
  asm("mov.b32 %0, %1;" : "=r"(r267) : "f"(f386));
  // PTX:621 mov.b32 %r266, %f385
  asm("mov.b32 %0, %1;" : "=r"(r266) : "f"(f385));
  // PTX:622 mov.b32 %r265, %f384
  asm("mov.b32 %0, %1;" : "=r"(r265) : "f"(f384));
  // PTX:623 mov.b32 %r264, %f377
  asm("mov.b32 %0, %1;" : "=r"(r264) : "f"(f377));
  // PTX:624 mov.b32 %r263, %f376
  asm("mov.b32 %0, %1;" : "=r"(r263) : "f"(f376));
  // PTX:625 mov.b32 %r262, %f375
  asm("mov.b32 %0, %1;" : "=r"(r262) : "f"(f375));
  // PTX:626 mov.b32 %r261, %f368
  asm("mov.b32 %0, %1;" : "=r"(r261) : "f"(f368));
  // PTX:627 mov.b32 %r260, %f367
  asm("mov.b32 %0, %1;" : "=r"(r260) : "f"(f367));
  // PTX:628 mov.b32 %r259, %f366
  asm("mov.b32 %0, %1;" : "=r"(r259) : "f"(f366));
  // PTX:630 $L__BB60_28:
L_BB60_28:;
  // PTX:631 ld.param.u32 %r231, [_ZN7synreal6kernel43add_affine_body_constitutive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_4]
  r231 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param4 + (0))));
  // PTX:632 setp.eq.s32 %p23, %r231, 1
  p23 = (((int)(r231)) == ((int)(1)));
  // PTX:633 mov.u32 %r224, 0
  asm("mov.u32 %0, 0;" : "=r"(r224) : );
  // PTX:634 st.local.v4.u32 [%rd2], {%r224, %r224, %r224, %r259}
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (0))))) = (unsigned)(r224); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (4))))) = (unsigned)(r224); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (8))))) = (unsigned)(r224); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (12))))) = (unsigned)(r259);
  // PTX:635 st.local.v4.u32 [%rd2+16], {%r260, %r261, %r262, %r263}
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (16))))) = (unsigned)(r260); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (20))))) = (unsigned)(r261); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (24))))) = (unsigned)(r262); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (28))))) = (unsigned)(r263);
  // PTX:636 st.local.v4.u32 [%rd2+32], {%r264, %r265, %r266, %r267}
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (32))))) = (unsigned)(r264); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (36))))) = (unsigned)(r265); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (40))))) = (unsigned)(r266); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (44))))) = (unsigned)(r267);
  // PTX:637 ld.local.f32 %f160, [%rd62]
  f160 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd62) + (0)))));
  // PTX:638 ld.local.f32 %f161, [%rd62+4]
  f161 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd62) + (4)))));
  // PTX:639 ld.local.f32 %f162, [%rd62+8]
  f162 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd62) + (8)))));
  // PTX:640 st.local.v4.u32 [%rd11], {%r224, %r224, %r224, %r224}
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (0))))) = (unsigned)(r224); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (4))))) = (unsigned)(r224); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (8))))) = (unsigned)(r224); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (12))))) = (unsigned)(r224);
  // PTX:641 st.local.v4.u32 [%rd11+16], {%r224, %r224, %r224, %r224}
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (16))))) = (unsigned)(r224); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (20))))) = (unsigned)(r224); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (24))))) = (unsigned)(r224); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (28))))) = (unsigned)(r224);
  // PTX:642 st.local.v4.u32 [%rd11+32], {%r224, %r224, %r224, %r224}
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (32))))) = (unsigned)(r224); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (36))))) = (unsigned)(r224); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (40))))) = (unsigned)(r224); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (44))))) = (unsigned)(r224);
  // PTX:643 mov.u32 %r225, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r225) : );
  // PTX:644 st.local.u32 [%rd63+4], %r225
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd63) + (4))))) = (unsigned)(r225);
  // PTX:645 ld.local.f32 %f163, [%rd11+16]
  f163 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (16)))));
  // PTX:646 ld.local.u32 %r98, [%rd11+28]
  r98 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (28)))));
  // PTX:647 ld.local.u32 %r99, [%rd11+40]
  r99 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (40)))));
  // PTX:648 @%p23 bra $L__BB60_30
  if (p23) { goto L_BB60_30; }
  // PTX:649 bra.uni $L__BB60_29
  goto L_BB60_29;
  // PTX:651 $L__BB60_30:
L_BB60_30:;
  // PTX:652 mov.b32 %f483, %r98
  asm("mov.b32 %0, %1;" : "=f"(f483) : "r"(r98));
  // PTX:653 mul.f32 %f484, %f645, %f483
  asm("mul.f32 %0, %1, %2;" : "=f"(f484) : "f"(f645), "f"(f483));
  // PTX:654 fma.rn.f32 %f485, %f1, %f163, %f484
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f485) : "f"(f1), "f"(f163), "f"(f484));
  // PTX:655 mov.b32 %f486, %r99
  asm("mov.b32 %0, %1;" : "=f"(f486) : "r"(r99));
  // PTX:656 fma.rn.f32 %f487, %f644, %f486, %f485
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f487) : "f"(f644), "f"(f486), "f"(f485));
  // PTX:657 mul.f32 %f488, %f642, %f483
  asm("mul.f32 %0, %1, %2;" : "=f"(f488) : "f"(f642), "f"(f483));
  // PTX:658 fma.rn.f32 %f489, %f643, %f163, %f488
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f489) : "f"(f643), "f"(f163), "f"(f488));
  // PTX:659 fma.rn.f32 %f490, %f641, %f486, %f489
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f490) : "f"(f641), "f"(f486), "f"(f489));
  // PTX:660 mul.f32 %f491, %f639, %f483
  asm("mul.f32 %0, %1, %2;" : "=f"(f491) : "f"(f639), "f"(f483));
  // PTX:661 fma.rn.f32 %f492, %f640, %f163, %f491
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f492) : "f"(f640), "f"(f163), "f"(f491));
  // PTX:662 fma.rn.f32 %f493, %f638, %f486, %f492
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f493) : "f"(f638), "f"(f486), "f"(f492));
  // PTX:663 add.f32 %f494, %f118, %f487
  asm("add.f32 %0, %1, %2;" : "=f"(f494) : "f"(f118), "f"(f487));
  // PTX:664 add.f32 %f495, %f490, %f490
  asm("add.f32 %0, %1, %2;" : "=f"(f495) : "f"(f490), "f"(f490));
  // PTX:665 add.f32 %f496, %f493, %f118
  asm("add.f32 %0, %1, %2;" : "=f"(f496) : "f"(f493), "f"(f118));
  // PTX:666 mul.f32 %f497, %f495, %f643
  asm("mul.f32 %0, %1, %2;" : "=f"(f497) : "f"(f495), "f"(f643));
  // PTX:667 fma.rn.f32 %f498, %f494, %f643, %f135
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f498) : "f"(f494), "f"(f643), "f"(f135));
  // PTX:668 fma.rn.f32 %f499, %f494, %f1, %f497
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f499) : "f"(f494), "f"(f1), "f"(f497));
  // PTX:669 fma.rn.f32 %f500, %f496, %f643, %f136
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f500) : "f"(f496), "f"(f643), "f"(f136));
  // PTX:670 add.f32 %f501, %f498, %f137
  asm("add.f32 %0, %1, %2;" : "=f"(f501) : "f"(f498), "f"(f137));
  // PTX:671 fma.rn.f32 %f502, %f496, %f640, %f499
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f502) : "f"(f496), "f"(f640), "f"(f499));
  // PTX:672 add.f32 %f503, %f123, %f500
  asm("add.f32 %0, %1, %2;" : "=f"(f503) : "f"(f123), "f"(f500));
  // PTX:673 mul.f32 %f504, %f495, %f642
  asm("mul.f32 %0, %1, %2;" : "=f"(f504) : "f"(f495), "f"(f642));
  // PTX:674 fma.rn.f32 %f505, %f494, %f642, %f138
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f505) : "f"(f494), "f"(f642), "f"(f138));
  // PTX:675 fma.rn.f32 %f506, %f494, %f645, %f504
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f506) : "f"(f494), "f"(f645), "f"(f504));
  // PTX:676 fma.rn.f32 %f507, %f496, %f642, %f139
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f507) : "f"(f496), "f"(f642), "f"(f139));
  // PTX:677 add.f32 %f508, %f505, %f140
  asm("add.f32 %0, %1, %2;" : "=f"(f508) : "f"(f505), "f"(f140));
  // PTX:678 fma.rn.f32 %f509, %f496, %f639, %f506
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f509) : "f"(f496), "f"(f639), "f"(f506));
  // PTX:679 add.f32 %f510, %f127, %f507
  asm("add.f32 %0, %1, %2;" : "=f"(f510) : "f"(f127), "f"(f507));
  // PTX:680 mul.f32 %f511, %f495, %f641
  asm("mul.f32 %0, %1, %2;" : "=f"(f511) : "f"(f495), "f"(f641));
  // PTX:681 fma.rn.f32 %f512, %f494, %f641, %f141
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f512) : "f"(f494), "f"(f641), "f"(f141));
  // PTX:682 fma.rn.f32 %f513, %f494, %f644, %f511
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f513) : "f"(f494), "f"(f644), "f"(f511));
  // PTX:683 fma.rn.f32 %f514, %f496, %f641, %f142
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f514) : "f"(f496), "f"(f641), "f"(f142));
  // PTX:684 add.f32 %f515, %f512, %f143
  asm("add.f32 %0, %1, %2;" : "=f"(f515) : "f"(f512), "f"(f143));
  // PTX:685 fma.rn.f32 %f516, %f496, %f638, %f513
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f516) : "f"(f496), "f"(f638), "f"(f513));
  // PTX:686 add.f32 %f517, %f131, %f514
  asm("add.f32 %0, %1, %2;" : "=f"(f517) : "f"(f131), "f"(f514));
  // PTX:687 mov.b32 %r275, %f516
  asm("mov.b32 %0, %1;" : "=r"(r275) : "f"(f516));
  // PTX:688 mov.b32 %r272, %f509
  asm("mov.b32 %0, %1;" : "=r"(r272) : "f"(f509));
  // PTX:689 mov.b32 %r269, %f502
  asm("mov.b32 %0, %1;" : "=r"(r269) : "f"(f502));
  // PTX:690 mov.b32 %r276, %f517
  asm("mov.b32 %0, %1;" : "=r"(r276) : "f"(f517));
  // PTX:691 mov.b32 %r274, %f515
  asm("mov.b32 %0, %1;" : "=r"(r274) : "f"(f515));
  // PTX:692 mov.b32 %r273, %f510
  asm("mov.b32 %0, %1;" : "=r"(r273) : "f"(f510));
  // PTX:693 mov.b32 %r271, %f508
  asm("mov.b32 %0, %1;" : "=r"(r271) : "f"(f508));
  // PTX:694 mov.b32 %r270, %f503
  asm("mov.b32 %0, %1;" : "=r"(r270) : "f"(f503));
  // PTX:695 mov.b32 %r268, %f501
  asm("mov.b32 %0, %1;" : "=r"(r268) : "f"(f501));
  // PTX:696 bra.uni $L__BB60_31
  goto L_BB60_31;
  // PTX:698 $L__BB60_29:
L_BB60_29:;
  // PTX:699 fma.rn.f32 %f422, %f647, %f163, %f150
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f422) : "f"(f647), "f"(f163), "f"(f150));
  // PTX:700 fma.rn.f32 %f423, %f650, %f163, %f153
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f423) : "f"(f650), "f"(f163), "f"(f153));
  // PTX:701 fma.rn.f32 %f424, %f653, %f163, %f156
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f424) : "f"(f653), "f"(f163), "f"(f156));
  // PTX:702 add.f32 %f425, %f422, %f132
  asm("add.f32 %0, %1, %2;" : "=f"(f425) : "f"(f422), "f"(f132));
  // PTX:703 add.f32 %f426, %f423, %f133
  asm("add.f32 %0, %1, %2;" : "=f"(f426) : "f"(f423), "f"(f133));
  // PTX:704 add.f32 %f427, %f424, %f134
  asm("add.f32 %0, %1, %2;" : "=f"(f427) : "f"(f424), "f"(f134));
  // PTX:705 mov.b32 %f428, %r98
  asm("mov.b32 %0, %1;" : "=f"(f428) : "r"(r98));
  // PTX:706 fma.rn.f32 %f429, %f647, %f428, %f150
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f429) : "f"(f647), "f"(f428), "f"(f150));
  // PTX:707 fma.rn.f32 %f430, %f650, %f428, %f153
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f430) : "f"(f650), "f"(f428), "f"(f153));
  // PTX:708 fma.rn.f32 %f431, %f653, %f428, %f156
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f431) : "f"(f653), "f"(f428), "f"(f156));
  // PTX:709 add.f32 %f432, %f429, %f132
  asm("add.f32 %0, %1, %2;" : "=f"(f432) : "f"(f429), "f"(f132));
  // PTX:710 add.f32 %f433, %f430, %f133
  asm("add.f32 %0, %1, %2;" : "=f"(f433) : "f"(f430), "f"(f133));
  // PTX:711 add.f32 %f434, %f431, %f134
  asm("add.f32 %0, %1, %2;" : "=f"(f434) : "f"(f431), "f"(f134));
  // PTX:712 mov.b32 %f435, %r99
  asm("mov.b32 %0, %1;" : "=f"(f435) : "r"(r99));
  // PTX:713 fma.rn.f32 %f436, %f647, %f435, %f150
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f436) : "f"(f647), "f"(f435), "f"(f150));
  // PTX:714 fma.rn.f32 %f437, %f650, %f435, %f153
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f437) : "f"(f650), "f"(f435), "f"(f153));
  // PTX:715 fma.rn.f32 %f438, %f653, %f435, %f156
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f438) : "f"(f653), "f"(f435), "f"(f156));
  // PTX:716 add.f32 %f439, %f436, %f132
  asm("add.f32 %0, %1, %2;" : "=f"(f439) : "f"(f436), "f"(f132));
  // PTX:717 add.f32 %f440, %f437, %f133
  asm("add.f32 %0, %1, %2;" : "=f"(f440) : "f"(f437), "f"(f133));
  // PTX:718 add.f32 %f441, %f438, %f134
  asm("add.f32 %0, %1, %2;" : "=f"(f441) : "f"(f438), "f"(f134));
  // PTX:719 add.f32 %f442, %f425, %f425
  asm("add.f32 %0, %1, %2;" : "=f"(f442) : "f"(f425), "f"(f425));
  // PTX:720 add.f32 %f443, %f426, %f432
  asm("add.f32 %0, %1, %2;" : "=f"(f443) : "f"(f426), "f"(f432));
  // PTX:721 add.f32 %f444, %f427, %f439
  asm("add.f32 %0, %1, %2;" : "=f"(f444) : "f"(f427), "f"(f439));
  // PTX:722 add.f32 %f445, %f433, %f433
  asm("add.f32 %0, %1, %2;" : "=f"(f445) : "f"(f433), "f"(f433));
  // PTX:723 add.f32 %f446, %f434, %f440
  asm("add.f32 %0, %1, %2;" : "=f"(f446) : "f"(f434), "f"(f440));
  // PTX:724 add.f32 %f447, %f441, %f441
  asm("add.f32 %0, %1, %2;" : "=f"(f447) : "f"(f441), "f"(f441));
  // PTX:725 add.f32 %f448, %f425, %f433
  asm("add.f32 %0, %1, %2;" : "=f"(f448) : "f"(f425), "f"(f433));
  // PTX:726 add.f32 %f449, %f448, %f441
  asm("add.f32 %0, %1, %2;" : "=f"(f449) : "f"(f448), "f"(f441));
  // PTX:727 add.f32 %f450, %f442, %f449
  asm("add.f32 %0, %1, %2;" : "=f"(f450) : "f"(f442), "f"(f449));
  // PTX:728 fma.rn.f32 %f451, %f449, 0f00000000, %f443
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f451) : "f"(f449), "f"(f443));
  // PTX:729 fma.rn.f32 %f452, %f449, 0f00000000, %f444
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f452) : "f"(f449), "f"(f444));
  // PTX:730 add.f32 %f453, %f445, %f449
  asm("add.f32 %0, %1, %2;" : "=f"(f453) : "f"(f445), "f"(f449));
  // PTX:731 fma.rn.f32 %f454, %f449, 0f00000000, %f446
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f454) : "f"(f449), "f"(f446));
  // PTX:732 add.f32 %f455, %f447, %f449
  asm("add.f32 %0, %1, %2;" : "=f"(f455) : "f"(f447), "f"(f449));
  // PTX:733 mul.f32 %f456, %f649, %f451
  asm("mul.f32 %0, %1, %2;" : "=f"(f456) : "f"(f649), "f"(f451));
  // PTX:734 mul.f32 %f457, %f650, %f451
  asm("mul.f32 %0, %1, %2;" : "=f"(f457) : "f"(f650), "f"(f451));
  // PTX:735 mul.f32 %f458, %f651, %f451
  asm("mul.f32 %0, %1, %2;" : "=f"(f458) : "f"(f651), "f"(f451));
  // PTX:736 fma.rn.f32 %f459, %f648, %f450, %f456
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f459) : "f"(f648), "f"(f450), "f"(f456));
  // PTX:737 fma.rn.f32 %f460, %f647, %f450, %f457
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f460) : "f"(f647), "f"(f450), "f"(f457));
  // PTX:738 fma.rn.f32 %f461, %f646, %f450, %f458
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f461) : "f"(f646), "f"(f450), "f"(f458));
  // PTX:739 fma.rn.f32 %f462, %f652, %f452, %f459
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f462) : "f"(f652), "f"(f452), "f"(f459));
  // PTX:740 fma.rn.f32 %f463, %f653, %f452, %f460
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f463) : "f"(f653), "f"(f452), "f"(f460));
  // PTX:741 fma.rn.f32 %f464, %f654, %f452, %f461
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f464) : "f"(f654), "f"(f452), "f"(f461));
  // PTX:742 mul.f32 %f465, %f648, %f451
  asm("mul.f32 %0, %1, %2;" : "=f"(f465) : "f"(f648), "f"(f451));
  // PTX:743 mul.f32 %f466, %f647, %f451
  asm("mul.f32 %0, %1, %2;" : "=f"(f466) : "f"(f647), "f"(f451));
  // PTX:744 mul.f32 %f467, %f646, %f451
  asm("mul.f32 %0, %1, %2;" : "=f"(f467) : "f"(f646), "f"(f451));
  // PTX:745 fma.rn.f32 %f468, %f649, %f453, %f465
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f468) : "f"(f649), "f"(f453), "f"(f465));
  // PTX:746 fma.rn.f32 %f469, %f650, %f453, %f466
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f469) : "f"(f650), "f"(f453), "f"(f466));
  // PTX:747 fma.rn.f32 %f470, %f651, %f453, %f467
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f470) : "f"(f651), "f"(f453), "f"(f467));
  // PTX:748 fma.rn.f32 %f471, %f652, %f454, %f468
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f471) : "f"(f652), "f"(f454), "f"(f468));
  // PTX:749 fma.rn.f32 %f472, %f653, %f454, %f469
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f472) : "f"(f653), "f"(f454), "f"(f469));
  // PTX:750 fma.rn.f32 %f473, %f654, %f454, %f470
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f473) : "f"(f654), "f"(f454), "f"(f470));
  // PTX:751 mul.f32 %f474, %f649, %f454
  asm("mul.f32 %0, %1, %2;" : "=f"(f474) : "f"(f649), "f"(f454));
  // PTX:752 mul.f32 %f475, %f650, %f454
  asm("mul.f32 %0, %1, %2;" : "=f"(f475) : "f"(f650), "f"(f454));
  // PTX:753 mul.f32 %f476, %f651, %f454
  asm("mul.f32 %0, %1, %2;" : "=f"(f476) : "f"(f651), "f"(f454));
  // PTX:754 fma.rn.f32 %f477, %f648, %f452, %f474
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f477) : "f"(f648), "f"(f452), "f"(f474));
  // PTX:755 fma.rn.f32 %f478, %f647, %f452, %f475
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f478) : "f"(f647), "f"(f452), "f"(f475));
  // PTX:756 fma.rn.f32 %f479, %f646, %f452, %f476
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f479) : "f"(f646), "f"(f452), "f"(f476));
  // PTX:757 fma.rn.f32 %f480, %f652, %f455, %f477
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f480) : "f"(f652), "f"(f455), "f"(f477));
  // PTX:758 fma.rn.f32 %f481, %f653, %f455, %f478
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f481) : "f"(f653), "f"(f455), "f"(f478));
  // PTX:759 fma.rn.f32 %f482, %f654, %f455, %f479
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f482) : "f"(f654), "f"(f455), "f"(f479));
  // PTX:760 mov.b32 %r276, %f482
  asm("mov.b32 %0, %1;" : "=r"(r276) : "f"(f482));
  // PTX:761 mov.b32 %r275, %f481
  asm("mov.b32 %0, %1;" : "=r"(r275) : "f"(f481));
  // PTX:762 mov.b32 %r274, %f480
  asm("mov.b32 %0, %1;" : "=r"(r274) : "f"(f480));
  // PTX:763 mov.b32 %r273, %f473
  asm("mov.b32 %0, %1;" : "=r"(r273) : "f"(f473));
  // PTX:764 mov.b32 %r272, %f472
  asm("mov.b32 %0, %1;" : "=r"(r272) : "f"(f472));
  // PTX:765 mov.b32 %r271, %f471
  asm("mov.b32 %0, %1;" : "=r"(r271) : "f"(f471));
  // PTX:766 mov.b32 %r270, %f464
  asm("mov.b32 %0, %1;" : "=r"(r270) : "f"(f464));
  // PTX:767 mov.b32 %r269, %f463
  asm("mov.b32 %0, %1;" : "=r"(r269) : "f"(f463));
  // PTX:768 mov.b32 %r268, %f462
  asm("mov.b32 %0, %1;" : "=r"(r268) : "f"(f462));
  // PTX:770 $L__BB60_31:
L_BB60_31:;
  // PTX:771 ld.param.u32 %r232, [_ZN7synreal6kernel43add_affine_body_constitutive_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffNS_23AffineBodyRigidityModelEPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_4]
  r232 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param4 + (0))));
  // PTX:772 setp.eq.s32 %p24, %r232, 1
  p24 = (((int)(r232)) == ((int)(1)));
  // PTX:773 mov.u32 %r226, 0
  asm("mov.u32 %0, 0;" : "=r"(r226) : );
  // PTX:774 st.local.v4.u32 [%rd2], {%r226, %r226, %r226, %r268}
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (0))))) = (unsigned)(r226); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (4))))) = (unsigned)(r226); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (8))))) = (unsigned)(r226); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (12))))) = (unsigned)(r268);
  // PTX:775 st.local.v4.u32 [%rd2+16], {%r269, %r270, %r271, %r272}
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (16))))) = (unsigned)(r269); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (20))))) = (unsigned)(r270); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (24))))) = (unsigned)(r271); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (28))))) = (unsigned)(r272);
  // PTX:776 st.local.v4.u32 [%rd2+32], {%r273, %r274, %r275, %r276}
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (32))))) = (unsigned)(r273); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (36))))) = (unsigned)(r274); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (40))))) = (unsigned)(r275); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (44))))) = (unsigned)(r276);
  // PTX:777 ld.local.f32 %f164, [%rd62]
  f164 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd62) + (0)))));
  // PTX:778 ld.local.f32 %f165, [%rd62+4]
  f165 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd62) + (4)))));
  // PTX:779 ld.local.f32 %f166, [%rd62+8]
  f166 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd62) + (8)))));
  // PTX:780 st.local.v4.u32 [%rd11], {%r226, %r226, %r226, %r226}
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (0))))) = (unsigned)(r226); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (4))))) = (unsigned)(r226); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (8))))) = (unsigned)(r226); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (12))))) = (unsigned)(r226);
  // PTX:781 st.local.v4.u32 [%rd11+16], {%r226, %r226, %r226, %r226}
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (16))))) = (unsigned)(r226); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (20))))) = (unsigned)(r226); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (24))))) = (unsigned)(r226); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (28))))) = (unsigned)(r226);
  // PTX:782 st.local.v4.u32 [%rd11+32], {%r226, %r226, %r226, %r226}
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (32))))) = (unsigned)(r226); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (36))))) = (unsigned)(r226); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (40))))) = (unsigned)(r226); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (44))))) = (unsigned)(r226);
  // PTX:783 mov.u32 %r227, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r227) : );
  // PTX:784 st.local.u32 [%rd63+8], %r227
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd63) + (8))))) = (unsigned)(r227);
  // PTX:785 ld.local.f32 %f167, [%rd11+20]
  f167 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (20)))));
  // PTX:786 ld.local.u32 %r127, [%rd11+32]
  r127 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (32)))));
  // PTX:787 ld.local.u32 %r128, [%rd11+44]
  r128 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (44)))));
  // PTX:788 @%p24 bra $L__BB60_33
  if (p24) { goto L_BB60_33; }
  // PTX:789 bra.uni $L__BB60_32
  goto L_BB60_32;
  // PTX:791 $L__BB60_33:
L_BB60_33:;
  // PTX:792 mov.b32 %f570, %r127
  asm("mov.b32 %0, %1;" : "=f"(f570) : "r"(r127));
  // PTX:793 mul.f32 %f571, %f645, %f570
  asm("mul.f32 %0, %1, %2;" : "=f"(f571) : "f"(f645), "f"(f570));
  // PTX:794 fma.rn.f32 %f572, %f1, %f167, %f571
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f572) : "f"(f1), "f"(f167), "f"(f571));
  // PTX:795 mov.b32 %f573, %r128
  asm("mov.b32 %0, %1;" : "=f"(f573) : "r"(r128));
  // PTX:796 fma.rn.f32 %f574, %f644, %f573, %f572
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f574) : "f"(f644), "f"(f573), "f"(f572));
  // PTX:797 mul.f32 %f575, %f642, %f570
  asm("mul.f32 %0, %1, %2;" : "=f"(f575) : "f"(f642), "f"(f570));
  // PTX:798 fma.rn.f32 %f576, %f643, %f167, %f575
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f576) : "f"(f643), "f"(f167), "f"(f575));
  // PTX:799 fma.rn.f32 %f577, %f641, %f573, %f576
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f577) : "f"(f641), "f"(f573), "f"(f576));
  // PTX:800 mul.f32 %f578, %f639, %f570
  asm("mul.f32 %0, %1, %2;" : "=f"(f578) : "f"(f639), "f"(f570));
  // PTX:801 fma.rn.f32 %f579, %f640, %f167, %f578
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f579) : "f"(f640), "f"(f167), "f"(f578));
  // PTX:802 fma.rn.f32 %f580, %f638, %f573, %f579
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f580) : "f"(f638), "f"(f573), "f"(f579));
  // PTX:803 add.f32 %f581, %f119, %f574
  asm("add.f32 %0, %1, %2;" : "=f"(f581) : "f"(f119), "f"(f574));
  // PTX:804 add.f32 %f582, %f119, %f577
  asm("add.f32 %0, %1, %2;" : "=f"(f582) : "f"(f119), "f"(f577));
  // PTX:805 add.f32 %f583, %f580, %f580
  asm("add.f32 %0, %1, %2;" : "=f"(f583) : "f"(f580), "f"(f580));
  // PTX:806 mul.f32 %f584, %f582, %f643
  asm("mul.f32 %0, %1, %2;" : "=f"(f584) : "f"(f582), "f"(f643));
  // PTX:807 fma.rn.f32 %f585, %f581, %f1, %f584
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f585) : "f"(f581), "f"(f1), "f"(f584));
  // PTX:808 fma.rn.f32 %f586, %f581, %f640, %f144
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f586) : "f"(f581), "f"(f640), "f"(f144));
  // PTX:809 fma.rn.f32 %f587, %f582, %f640, %f145
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f587) : "f"(f582), "f"(f640), "f"(f145));
  // PTX:810 fma.rn.f32 %f588, %f583, %f640, %f585
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f588) : "f"(f583), "f"(f640), "f"(f585));
  // PTX:811 mul.f32 %f589, %f582, %f642
  asm("mul.f32 %0, %1, %2;" : "=f"(f589) : "f"(f582), "f"(f642));
  // PTX:812 fma.rn.f32 %f590, %f581, %f645, %f589
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f590) : "f"(f581), "f"(f645), "f"(f589));
  // PTX:813 fma.rn.f32 %f591, %f581, %f639, %f146
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f591) : "f"(f581), "f"(f639), "f"(f146));
  // PTX:814 fma.rn.f32 %f592, %f582, %f639, %f147
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f592) : "f"(f582), "f"(f639), "f"(f147));
  // PTX:815 fma.rn.f32 %f593, %f583, %f639, %f590
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f593) : "f"(f583), "f"(f639), "f"(f590));
  // PTX:816 mul.f32 %f594, %f582, %f641
  asm("mul.f32 %0, %1, %2;" : "=f"(f594) : "f"(f582), "f"(f641));
  // PTX:817 fma.rn.f32 %f595, %f581, %f644, %f594
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f595) : "f"(f581), "f"(f644), "f"(f594));
  // PTX:818 fma.rn.f32 %f596, %f581, %f638, %f148
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f596) : "f"(f581), "f"(f638), "f"(f148));
  // PTX:819 fma.rn.f32 %f597, %f582, %f638, %f149
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f597) : "f"(f582), "f"(f638), "f"(f149));
  // PTX:820 fma.rn.f32 %f598, %f583, %f638, %f595
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f598) : "f"(f583), "f"(f638), "f"(f595));
  // PTX:821 mov.b32 %r285, %f598
  asm("mov.b32 %0, %1;" : "=r"(r285) : "f"(f598));
  // PTX:822 mov.b32 %r282, %f593
  asm("mov.b32 %0, %1;" : "=r"(r282) : "f"(f593));
  // PTX:823 mov.b32 %r279, %f588
  asm("mov.b32 %0, %1;" : "=r"(r279) : "f"(f588));
  // PTX:824 mov.b32 %r284, %f597
  asm("mov.b32 %0, %1;" : "=r"(r284) : "f"(f597));
  // PTX:825 mov.b32 %r283, %f596
  asm("mov.b32 %0, %1;" : "=r"(r283) : "f"(f596));
  // PTX:826 mov.b32 %r281, %f592
  asm("mov.b32 %0, %1;" : "=r"(r281) : "f"(f592));
  // PTX:827 mov.b32 %r280, %f591
  asm("mov.b32 %0, %1;" : "=r"(r280) : "f"(f591));
  // PTX:828 mov.b32 %r278, %f587
  asm("mov.b32 %0, %1;" : "=r"(r278) : "f"(f587));
  // PTX:829 mov.b32 %r277, %f586
  asm("mov.b32 %0, %1;" : "=r"(r277) : "f"(f586));
  // PTX:830 bra.uni $L__BB60_34
  goto L_BB60_34;
  // PTX:832 $L__BB60_32:
L_BB60_32:;
  // PTX:833 fma.rn.f32 %f518, %f646, %f167, %f152
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f518) : "f"(f646), "f"(f167), "f"(f152));
  // PTX:834 fma.rn.f32 %f519, %f651, %f167, %f155
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f519) : "f"(f651), "f"(f167), "f"(f155));
  // PTX:835 fma.rn.f32 %f520, %f654, %f167, %f158
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f520) : "f"(f654), "f"(f167), "f"(f158));
  // PTX:836 mov.b32 %f521, %r127
  asm("mov.b32 %0, %1;" : "=f"(f521) : "r"(r127));
  // PTX:837 fma.rn.f32 %f522, %f646, %f521, %f152
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f522) : "f"(f646), "f"(f521), "f"(f152));
  // PTX:838 fma.rn.f32 %f523, %f651, %f521, %f155
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f523) : "f"(f651), "f"(f521), "f"(f155));
  // PTX:839 fma.rn.f32 %f524, %f654, %f521, %f158
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f524) : "f"(f654), "f"(f521), "f"(f158));
  // PTX:840 mov.b32 %f525, %r128
  asm("mov.b32 %0, %1;" : "=f"(f525) : "r"(r128));
  // PTX:841 fma.rn.f32 %f526, %f646, %f525, %f152
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f526) : "f"(f646), "f"(f525), "f"(f152));
  // PTX:842 fma.rn.f32 %f527, %f651, %f525, %f155
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f527) : "f"(f651), "f"(f525), "f"(f155));
  // PTX:843 fma.rn.f32 %f528, %f654, %f525, %f158
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f528) : "f"(f654), "f"(f525), "f"(f158));
  // PTX:844 add.f32 %f529, %f518, %f518
  asm("add.f32 %0, %1, %2;" : "=f"(f529) : "f"(f518), "f"(f518));
  // PTX:845 add.f32 %f530, %f519, %f522
  asm("add.f32 %0, %1, %2;" : "=f"(f530) : "f"(f519), "f"(f522));
  // PTX:846 add.f32 %f531, %f520, %f526
  asm("add.f32 %0, %1, %2;" : "=f"(f531) : "f"(f520), "f"(f526));
  // PTX:847 add.f32 %f532, %f523, %f523
  asm("add.f32 %0, %1, %2;" : "=f"(f532) : "f"(f523), "f"(f523));
  // PTX:848 add.f32 %f533, %f524, %f527
  asm("add.f32 %0, %1, %2;" : "=f"(f533) : "f"(f524), "f"(f527));
  // PTX:849 add.f32 %f534, %f528, %f528
  asm("add.f32 %0, %1, %2;" : "=f"(f534) : "f"(f528), "f"(f528));
  // PTX:850 add.f32 %f535, %f518, %f523
  asm("add.f32 %0, %1, %2;" : "=f"(f535) : "f"(f518), "f"(f523));
  // PTX:851 add.f32 %f536, %f535, %f528
  asm("add.f32 %0, %1, %2;" : "=f"(f536) : "f"(f535), "f"(f528));
  // PTX:852 add.f32 %f537, %f529, %f536
  asm("add.f32 %0, %1, %2;" : "=f"(f537) : "f"(f529), "f"(f536));
  // PTX:853 fma.rn.f32 %f538, %f536, 0f00000000, %f530
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f538) : "f"(f536), "f"(f530));
  // PTX:854 fma.rn.f32 %f539, %f536, 0f00000000, %f531
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f539) : "f"(f536), "f"(f531));
  // PTX:855 add.f32 %f540, %f532, %f536
  asm("add.f32 %0, %1, %2;" : "=f"(f540) : "f"(f532), "f"(f536));
  // PTX:856 fma.rn.f32 %f541, %f536, 0f00000000, %f533
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f541) : "f"(f536), "f"(f533));
  // PTX:857 add.f32 %f542, %f534, %f536
  asm("add.f32 %0, %1, %2;" : "=f"(f542) : "f"(f534), "f"(f536));
  // PTX:858 mul.f32 %f543, %f649, %f538
  asm("mul.f32 %0, %1, %2;" : "=f"(f543) : "f"(f649), "f"(f538));
  // PTX:859 mul.f32 %f544, %f650, %f538
  asm("mul.f32 %0, %1, %2;" : "=f"(f544) : "f"(f650), "f"(f538));
  // PTX:860 mul.f32 %f545, %f651, %f538
  asm("mul.f32 %0, %1, %2;" : "=f"(f545) : "f"(f651), "f"(f538));
  // PTX:861 fma.rn.f32 %f546, %f648, %f537, %f543
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f546) : "f"(f648), "f"(f537), "f"(f543));
  // PTX:862 fma.rn.f32 %f547, %f647, %f537, %f544
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f547) : "f"(f647), "f"(f537), "f"(f544));
  // PTX:863 fma.rn.f32 %f548, %f646, %f537, %f545
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f548) : "f"(f646), "f"(f537), "f"(f545));
  // PTX:864 fma.rn.f32 %f549, %f652, %f539, %f546
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f549) : "f"(f652), "f"(f539), "f"(f546));
  // PTX:865 fma.rn.f32 %f550, %f653, %f539, %f547
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f550) : "f"(f653), "f"(f539), "f"(f547));
  // PTX:866 fma.rn.f32 %f551, %f654, %f539, %f548
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f551) : "f"(f654), "f"(f539), "f"(f548));
  // PTX:867 mul.f32 %f552, %f648, %f538
  asm("mul.f32 %0, %1, %2;" : "=f"(f552) : "f"(f648), "f"(f538));
  // PTX:868 mul.f32 %f553, %f647, %f538
  asm("mul.f32 %0, %1, %2;" : "=f"(f553) : "f"(f647), "f"(f538));
  // PTX:869 mul.f32 %f554, %f646, %f538
  asm("mul.f32 %0, %1, %2;" : "=f"(f554) : "f"(f646), "f"(f538));
  // PTX:870 fma.rn.f32 %f555, %f649, %f540, %f552
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f555) : "f"(f649), "f"(f540), "f"(f552));
  // PTX:871 fma.rn.f32 %f556, %f650, %f540, %f553
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f556) : "f"(f650), "f"(f540), "f"(f553));
  // PTX:872 fma.rn.f32 %f557, %f651, %f540, %f554
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f557) : "f"(f651), "f"(f540), "f"(f554));
  // PTX:873 fma.rn.f32 %f558, %f652, %f541, %f555
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f558) : "f"(f652), "f"(f541), "f"(f555));
  // PTX:874 fma.rn.f32 %f559, %f653, %f541, %f556
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f559) : "f"(f653), "f"(f541), "f"(f556));
  // PTX:875 fma.rn.f32 %f560, %f654, %f541, %f557
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f560) : "f"(f654), "f"(f541), "f"(f557));
  // PTX:876 mul.f32 %f561, %f649, %f541
  asm("mul.f32 %0, %1, %2;" : "=f"(f561) : "f"(f649), "f"(f541));
  // PTX:877 mul.f32 %f562, %f650, %f541
  asm("mul.f32 %0, %1, %2;" : "=f"(f562) : "f"(f650), "f"(f541));
  // PTX:878 mul.f32 %f563, %f651, %f541
  asm("mul.f32 %0, %1, %2;" : "=f"(f563) : "f"(f651), "f"(f541));
  // PTX:879 fma.rn.f32 %f564, %f648, %f539, %f561
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f564) : "f"(f648), "f"(f539), "f"(f561));
  // PTX:880 fma.rn.f32 %f565, %f647, %f539, %f562
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f565) : "f"(f647), "f"(f539), "f"(f562));
  // PTX:881 fma.rn.f32 %f566, %f646, %f539, %f563
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f566) : "f"(f646), "f"(f539), "f"(f563));
  // PTX:882 fma.rn.f32 %f567, %f652, %f542, %f564
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f567) : "f"(f652), "f"(f542), "f"(f564));
  // PTX:883 fma.rn.f32 %f568, %f653, %f542, %f565
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f568) : "f"(f653), "f"(f542), "f"(f565));
  // PTX:884 fma.rn.f32 %f569, %f654, %f542, %f566
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f569) : "f"(f654), "f"(f542), "f"(f566));
  // PTX:885 mov.b32 %r285, %f569
  asm("mov.b32 %0, %1;" : "=r"(r285) : "f"(f569));
  // PTX:886 mov.b32 %r284, %f568
  asm("mov.b32 %0, %1;" : "=r"(r284) : "f"(f568));
  // PTX:887 mov.b32 %r283, %f567
  asm("mov.b32 %0, %1;" : "=r"(r283) : "f"(f567));
  // PTX:888 mov.b32 %r282, %f560
  asm("mov.b32 %0, %1;" : "=r"(r282) : "f"(f560));
  // PTX:889 mov.b32 %r281, %f559
  asm("mov.b32 %0, %1;" : "=r"(r281) : "f"(f559));
  // PTX:890 mov.b32 %r280, %f558
  asm("mov.b32 %0, %1;" : "=r"(r280) : "f"(f558));
  // PTX:891 mov.b32 %r279, %f551
  asm("mov.b32 %0, %1;" : "=r"(r279) : "f"(f551));
  // PTX:892 mov.b32 %r278, %f550
  asm("mov.b32 %0, %1;" : "=r"(r278) : "f"(f550));
  // PTX:893 mov.b32 %r277, %f549
  asm("mov.b32 %0, %1;" : "=r"(r277) : "f"(f549));
  // PTX:895 $L__BB60_34:
L_BB60_34:;
  // PTX:896 mov.u32 %r228, 0
  asm("mov.u32 %0, 0;" : "=r"(r228) : );
  // PTX:897 st.local.v4.u32 [%rd2], {%r228, %r228, %r228, %r277}
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (0))))) = (unsigned)(r228); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (4))))) = (unsigned)(r228); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (8))))) = (unsigned)(r228); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (12))))) = (unsigned)(r277);
  // PTX:898 st.local.v4.u32 [%rd2+16], {%r278, %r279, %r280, %r281}
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (16))))) = (unsigned)(r278); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (20))))) = (unsigned)(r279); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (24))))) = (unsigned)(r280); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (28))))) = (unsigned)(r281);
  // PTX:899 st.local.v4.u32 [%rd2+32], {%r282, %r283, %r284, %r285}
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (32))))) = (unsigned)(r282); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (36))))) = (unsigned)(r283); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (40))))) = (unsigned)(r284); (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (44))))) = (unsigned)(r285);
  // PTX:900 ld.local.f32 %f599, [%rd62]
  f599 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd62) + (0)))));
  // PTX:901 mul.f32 %f600, %f116, %f599
  asm("mul.f32 %0, %1, %2;" : "=f"(f600) : "f"(f116), "f"(f599));
  // PTX:902 ld.local.f32 %f601, [%rd62+4]
  f601 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd62) + (4)))));
  // PTX:903 mul.f32 %f602, %f116, %f601
  asm("mul.f32 %0, %1, %2;" : "=f"(f602) : "f"(f116), "f"(f601));
  // PTX:904 ld.local.f32 %f603, [%rd62+8]
  f603 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd62) + (8)))));
  // PTX:905 mul.f32 %f604, %f116, %f603
  asm("mul.f32 %0, %1, %2;" : "=f"(f604) : "f"(f116), "f"(f603));
  // PTX:906 ld.local.u32 %r229, [%rd64]
  r229 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd64) + (0)))));
  // PTX:907 mul.wide.s32 %rd50, %r229, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd50) : "r"(r229));
  // PTX:908 add.s64 %rd51, %rd10, %rd50
  asm("add.s64 %0, %1, %2;" : "=l"(rd51) : "l"(rd10), "l"(rd50));
  // PTX:909 mul.f32 %f605, %f116, %f160
  asm("mul.f32 %0, %1, %2;" : "=f"(f605) : "f"(f116), "f"(f160));
  // PTX:910 red.global.add.f32 [%rd51], %f605
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))), (float)(f605));
  // PTX:911 add.s64 %rd52, %rd51, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd52) : "l"(rd51));
  // PTX:912 mul.f32 %f607, %f116, %f161
  asm("mul.f32 %0, %1, %2;" : "=f"(f607) : "f"(f116), "f"(f161));
  // PTX:913 red.global.add.f32 [%rd52], %f607
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))), (float)(f607));
  // PTX:914 add.s64 %rd53, %rd51, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd53) : "l"(rd51));
  // PTX:915 mul.f32 %f609, %f116, %f162
  asm("mul.f32 %0, %1, %2;" : "=f"(f609) : "f"(f116), "f"(f162));
  // PTX:916 red.global.add.f32 [%rd53], %f609
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))), (float)(f609));
  // PTX:917 add.s64 %rd54, %rd51, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd54) : "l"(rd51));
  // PTX:918 mul.f32 %f611, %f116, %f164
  asm("mul.f32 %0, %1, %2;" : "=f"(f611) : "f"(f116), "f"(f164));
  // PTX:919 red.global.add.f32 [%rd54], %f611
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))), (float)(f611));
  // PTX:920 add.s64 %rd55, %rd51, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd55) : "l"(rd51));
  // PTX:921 mul.f32 %f613, %f116, %f165
  asm("mul.f32 %0, %1, %2;" : "=f"(f613) : "f"(f116), "f"(f165));
  // PTX:922 red.global.add.f32 [%rd55], %f613
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))), (float)(f613));
  // PTX:923 add.s64 %rd56, %rd51, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd56) : "l"(rd51));
  // PTX:924 mul.f32 %f615, %f116, %f166
  asm("mul.f32 %0, %1, %2;" : "=f"(f615) : "f"(f116), "f"(f166));
  // PTX:925 red.global.add.f32 [%rd56], %f615
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))), (float)(f615));
  // PTX:926 add.s64 %rd57, %rd51, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd57) : "l"(rd51));
  // PTX:927 red.global.add.f32 [%rd57], %f600
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))), (float)(f600));
  // PTX:928 add.s64 %rd58, %rd51, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd58) : "l"(rd51));
  // PTX:929 red.global.add.f32 [%rd58], %f602
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (0)))), (float)(f602));
  // PTX:930 add.s64 %rd59, %rd51, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd59) : "l"(rd51));
  // PTX:931 red.global.add.f32 [%rd59], %f604
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))), (float)(f604));
  // PTX:932 add.s64 %rd64, %rd64, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd64) : "l"(rd64));
  // PTX:933 add.s64 %rd63, %rd63, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd63) : "l"(rd63));
  // PTX:934 add.s64 %rd62, %rd62, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd62) : "l"(rd62));
  // PTX:935 add.s32 %r258, %r258, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r258) : "r"(r258));
  // PTX:936 setp.ne.s32 %p22, %r258, 4
  p22 = (((int)(r258)) != ((int)(4)));
  // PTX:937 @%p22 bra $L__BB60_25
  if (p22) { goto L_BB60_25; }
  // PTX:939 $L__BB60_35:
L_BB60_35:;
  // PTX:940 ret
  return;
}
