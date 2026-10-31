// 机械还原自 PTX：synreal::kernel::multiply_tetrahedron_tangent(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: fb96cf82f2d974518e2dc88c5454371f46fa7bf10c8b4c2c5fecb4ba62630407
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__multiply_tetrahedron_tangent(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, float param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10) {
  int p0, p1, p2, p3, p4, p5, p6;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440, f441, f442, f443, f444, f445, f446, f447, f448, f449, f450, f451, f452, f453, f454, f455, f456, f457, f458, f459, f460, f461, f462, f463, f464, f465, f466, f467, f468, f469, f470, f471, f472, f473, f474, f475, f476, f477, f478, f479, f480, f481, f482, f483, f484, f485, f486, f487, f488, f489, f490, f491, f492, f493, f494, f495, f496, f497, f498, f499, f500, f501, f502, f503;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72;
  // PTX:27 ld.param.u64 %rd13, [_ZN7synreal6kernel28multiply_tetrahedron_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKffPS4_mmm_param_0]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:28 ld.param.u64 %rd14, [_ZN7synreal6kernel28multiply_tetrahedron_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKffPS4_mmm_param_1]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:29 ld.param.u64 %rd15, [_ZN7synreal6kernel28multiply_tetrahedron_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKffPS4_mmm_param_2]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:30 ld.param.u64 %rd16, [_ZN7synreal6kernel28multiply_tetrahedron_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKffPS4_mmm_param_3]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:31 ld.param.u64 %rd17, [_ZN7synreal6kernel28multiply_tetrahedron_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKffPS4_mmm_param_4]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:32 ld.param.u64 %rd18, [_ZN7synreal6kernel28multiply_tetrahedron_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKffPS4_mmm_param_5]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:33 ld.param.f32 %f76, [_ZN7synreal6kernel28multiply_tetrahedron_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKffPS4_mmm_param_6]
  f76 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param6 + (0))));
  // PTX:34 ld.param.u64 %rd21, [_ZN7synreal6kernel28multiply_tetrahedron_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKffPS4_mmm_param_7]
  rd21 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:35 ld.param.u64 %rd22, [_ZN7synreal6kernel28multiply_tetrahedron_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKffPS4_mmm_param_8]
  rd22 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:36 ld.param.u64 %rd19, [_ZN7synreal6kernel28multiply_tetrahedron_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKffPS4_mmm_param_9]
  rd19 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:37 ld.param.u64 %rd20, [_ZN7synreal6kernel28multiply_tetrahedron_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKffPS4_mmm_param_10]
  rd20 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:38 cvta.to.global.u64 %rd1, %rd21
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd21));
  // PTX:39 mov.u32 %r1, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r1) : "r"(blockIdx.x));
  // PTX:40 mov.u32 %r2, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockDim.x));
  // PTX:41 mul.wide.u32 %rd23, %r1, %r2
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd23) : "r"(r1), "r"(r2));
  // PTX:42 mov.u32 %r3, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(threadIdx.x));
  // PTX:43 cvt.u64.u32 %rd24, %r3
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd24) : "r"(r3));
  // PTX:44 add.s64 %rd2, %rd23, %rd24
  asm("add.s64 %0, %1, %2;" : "=l"(rd2) : "l"(rd23), "l"(rd24));
  // PTX:45 setp.ge.u64 %p1, %rd2, %rd22
  p1 = (((unsigned long long)(rd2)) >= ((unsigned long long)(rd22)));
  // PTX:46 @%p1 bra $L__BB44_13
  if (p1) { goto L_BB44_13; }
  // PTX:48 or.b64 %rd25, %rd2, %rd19
  asm("or.b64 %0, %1, %2;" : "=l"(rd25) : "l"(rd2), "l"(rd19));
  // PTX:49 and.b64 %rd26, %rd25, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd26) : "l"(rd25));
  // PTX:50 setp.eq.s64 %p2, %rd26, 0
  p2 = (((long long)(rd26)) == ((long long)(0)));
  // PTX:51 @%p2 bra $L__BB44_3
  if (p2) { goto L_BB44_3; }
  // PTX:53 div.u64 %rd71, %rd2, %rd19
  asm("div.u64 %0, %1, %2;" : "=l"(rd71) : "l"(rd2), "l"(rd19));
  // PTX:54 mul.lo.s64 %rd27, %rd71, %rd19
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd71), "l"(rd19));
  // PTX:55 sub.s64 %rd72, %rd2, %rd27
  asm("sub.s64 %0, %1, %2;" : "=l"(rd72) : "l"(rd2), "l"(rd27));
  // PTX:56 bra.uni $L__BB44_4
  goto L_BB44_4;
  // PTX:58 $L__BB44_3:
L_BB44_3:;
  // PTX:59 cvt.u32.u64 %r4, %rd19
  asm("cvt.u32.u64 %0, %1;" : "=r"(r4) : "l"(rd19));
  // PTX:60 cvt.u32.u64 %r5, %rd2
  asm("cvt.u32.u64 %0, %1;" : "=r"(r5) : "l"(rd2));
  // PTX:61 div.u32 %r6, %r5, %r4
  asm("div.u32 %0, %1, %2;" : "=r"(r6) : "r"(r5), "r"(r4));
  // PTX:62 mul.lo.s32 %r7, %r6, %r4
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r7) : "r"(r6), "r"(r4));
  // PTX:63 sub.s32 %r8, %r5, %r7
  asm("sub.s32 %0, %1, %2;" : "=r"(r8) : "r"(r5), "r"(r7));
  // PTX:64 cvt.u64.u32 %rd71, %r6
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd71) : "r"(r6));
  // PTX:65 cvt.u64.u32 %rd72, %r8
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd72) : "r"(r8));
  // PTX:67 $L__BB44_4:
L_BB44_4:;
  // PTX:68 cvta.to.global.u64 %rd28, %rd14
  rd28 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd14));
  // PTX:69 cvta.to.global.u64 %rd29, %rd13
  rd29 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd13));
  // PTX:70 mul.lo.s64 %rd30, %rd71, %rd20
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd30) : "l"(rd71), "l"(rd20));
  // PTX:71 cvt.u32.u64 %r9, %rd30
  asm("cvt.u32.u64 %0, %1;" : "=r"(r9) : "l"(rd30));
  // PTX:72 cvta.to.global.u64 %rd31, %rd15
  rd31 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd15));
  // PTX:73 shl.b64 %rd32, %rd72, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd32) : "l"(rd72));
  // PTX:74 add.s64 %rd33, %rd31, %rd32
  asm("add.s64 %0, %1, %2;" : "=l"(rd33) : "l"(rd31), "l"(rd32));
  // PTX:75 ld.global.u32 %r10, [%rd33]
  r10 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (0)))));
  // PTX:76 add.s32 %r11, %r10, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r11) : "r"(r10), "r"(r9));
  // PTX:77 ld.global.u32 %r12, [%rd33+4]
  r12 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (4)))));
  // PTX:78 add.s32 %r13, %r12, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r13) : "r"(r12), "r"(r9));
  // PTX:79 ld.global.u32 %r14, [%rd33+8]
  r14 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (8)))));
  // PTX:80 add.s32 %r15, %r14, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r15) : "r"(r14), "r"(r9));
  // PTX:81 ld.global.u32 %r16, [%rd33+12]
  r16 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (12)))));
  // PTX:82 add.s32 %r17, %r16, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r17) : "r"(r16), "r"(r9));
  // PTX:83 cvta.to.global.u64 %rd34, %rd16
  rd34 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd16));
  // PTX:84 mul.lo.s64 %rd35, %rd72, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd35) : "l"(rd72));
  // PTX:85 add.s64 %rd36, %rd34, %rd35
  asm("add.s64 %0, %1, %2;" : "=l"(rd36) : "l"(rd34), "l"(rd35));
  // PTX:86 cvta.to.global.u64 %rd37, %rd17
  rd37 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd17));
  // PTX:87 mul.lo.s64 %rd38, %rd72, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd38) : "l"(rd72));
  // PTX:88 add.s64 %rd39, %rd37, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd39) : "l"(rd37), "l"(rd38));
  // PTX:89 cvt.s64.s32 %rd9, %r11
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd9) : "r"(r11));
  // PTX:90 mul.wide.s32 %rd40, %r11, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd40) : "r"(r11));
  // PTX:91 add.s64 %rd41, %rd29, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd41) : "l"(rd29), "l"(rd40));
  // PTX:92 cvt.s64.s32 %rd10, %r13
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd10) : "r"(r13));
  // PTX:93 mul.wide.s32 %rd42, %r13, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd42) : "r"(r13));
  // PTX:94 add.s64 %rd43, %rd29, %rd42
  asm("add.s64 %0, %1, %2;" : "=l"(rd43) : "l"(rd29), "l"(rd42));
  // PTX:95 ld.global.f32 %f77, [%rd43]
  f77 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (0)))));
  // PTX:96 ld.global.f32 %f78, [%rd41]
  f78 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (0)))));
  // PTX:97 sub.f32 %f79, %f77, %f78
  asm("sub.f32 %0, %1, %2;" : "=f"(f79) : "f"(f77), "f"(f78));
  // PTX:98 ld.global.f32 %f80, [%rd43+4]
  f80 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (4)))));
  // PTX:99 ld.global.f32 %f81, [%rd41+4]
  f81 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (4)))));
  // PTX:100 sub.f32 %f82, %f80, %f81
  asm("sub.f32 %0, %1, %2;" : "=f"(f82) : "f"(f80), "f"(f81));
  // PTX:101 ld.global.f32 %f83, [%rd43+8]
  f83 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (8)))));
  // PTX:102 ld.global.f32 %f84, [%rd41+8]
  f84 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (8)))));
  // PTX:103 sub.f32 %f85, %f83, %f84
  asm("sub.f32 %0, %1, %2;" : "=f"(f85) : "f"(f83), "f"(f84));
  // PTX:104 cvt.s64.s32 %rd11, %r15
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd11) : "r"(r15));
  // PTX:105 mul.wide.s32 %rd44, %r15, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd44) : "r"(r15));
  // PTX:106 add.s64 %rd45, %rd29, %rd44
  asm("add.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd29), "l"(rd44));
  // PTX:107 ld.global.f32 %f86, [%rd45]
  f86 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))));
  // PTX:108 sub.f32 %f87, %f86, %f78
  asm("sub.f32 %0, %1, %2;" : "=f"(f87) : "f"(f86), "f"(f78));
  // PTX:109 ld.global.f32 %f88, [%rd45+4]
  f88 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (4)))));
  // PTX:110 sub.f32 %f89, %f88, %f81
  asm("sub.f32 %0, %1, %2;" : "=f"(f89) : "f"(f88), "f"(f81));
  // PTX:111 ld.global.f32 %f90, [%rd45+8]
  f90 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (8)))));
  // PTX:112 sub.f32 %f91, %f90, %f84
  asm("sub.f32 %0, %1, %2;" : "=f"(f91) : "f"(f90), "f"(f84));
  // PTX:113 cvt.s64.s32 %rd12, %r17
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd12) : "r"(r17));
  // PTX:114 mul.wide.s32 %rd46, %r17, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd46) : "r"(r17));
  // PTX:115 add.s64 %rd47, %rd29, %rd46
  asm("add.s64 %0, %1, %2;" : "=l"(rd47) : "l"(rd29), "l"(rd46));
  // PTX:116 ld.global.f32 %f92, [%rd47]
  f92 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))));
  // PTX:117 sub.f32 %f93, %f92, %f78
  asm("sub.f32 %0, %1, %2;" : "=f"(f93) : "f"(f92), "f"(f78));
  // PTX:118 ld.global.f32 %f94, [%rd47+4]
  f94 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (4)))));
  // PTX:119 sub.f32 %f95, %f94, %f81
  asm("sub.f32 %0, %1, %2;" : "=f"(f95) : "f"(f94), "f"(f81));
  // PTX:120 ld.global.f32 %f96, [%rd47+8]
  f96 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (8)))));
  // PTX:121 sub.f32 %f97, %f96, %f84
  asm("sub.f32 %0, %1, %2;" : "=f"(f97) : "f"(f96), "f"(f84));
  // PTX:122 ld.global.f32 %f1, [%rd36]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (0)))));
  // PTX:123 ld.global.f32 %f2, [%rd36+12]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (12)))));
  // PTX:124 mul.f32 %f98, %f87, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f98) : "f"(f87), "f"(f2));
  // PTX:125 mul.f32 %f99, %f89, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f99) : "f"(f89), "f"(f2));
  // PTX:126 mul.f32 %f100, %f91, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f100) : "f"(f91), "f"(f2));
  // PTX:127 fma.rn.f32 %f101, %f79, %f1, %f98
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f101) : "f"(f79), "f"(f1), "f"(f98));
  // PTX:128 fma.rn.f32 %f102, %f82, %f1, %f99
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f102) : "f"(f82), "f"(f1), "f"(f99));
  // PTX:129 fma.rn.f32 %f103, %f85, %f1, %f100
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f103) : "f"(f85), "f"(f1), "f"(f100));
  // PTX:130 ld.global.f32 %f3, [%rd36+24]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (24)))));
  // PTX:131 fma.rn.f32 %f4, %f93, %f3, %f101
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f4) : "f"(f93), "f"(f3), "f"(f101));
  // PTX:132 fma.rn.f32 %f5, %f95, %f3, %f102
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f5) : "f"(f95), "f"(f3), "f"(f102));
  // PTX:133 fma.rn.f32 %f6, %f97, %f3, %f103
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f6) : "f"(f97), "f"(f3), "f"(f103));
  // PTX:134 ld.global.f32 %f7, [%rd36+4]
  f7 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (4)))));
  // PTX:135 ld.global.f32 %f8, [%rd36+16]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (16)))));
  // PTX:136 mul.f32 %f104, %f87, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f104) : "f"(f87), "f"(f8));
  // PTX:137 mul.f32 %f105, %f89, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f105) : "f"(f89), "f"(f8));
  // PTX:138 mul.f32 %f106, %f91, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f106) : "f"(f91), "f"(f8));
  // PTX:139 fma.rn.f32 %f107, %f79, %f7, %f104
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f107) : "f"(f79), "f"(f7), "f"(f104));
  // PTX:140 fma.rn.f32 %f108, %f82, %f7, %f105
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f108) : "f"(f82), "f"(f7), "f"(f105));
  // PTX:141 fma.rn.f32 %f109, %f85, %f7, %f106
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f109) : "f"(f85), "f"(f7), "f"(f106));
  // PTX:142 ld.global.f32 %f9, [%rd36+28]
  f9 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (28)))));
  // PTX:143 fma.rn.f32 %f10, %f93, %f9, %f107
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f10) : "f"(f93), "f"(f9), "f"(f107));
  // PTX:144 fma.rn.f32 %f11, %f95, %f9, %f108
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f11) : "f"(f95), "f"(f9), "f"(f108));
  // PTX:145 fma.rn.f32 %f12, %f97, %f9, %f109
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f12) : "f"(f97), "f"(f9), "f"(f109));
  // PTX:146 ld.global.f32 %f13, [%rd36+8]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (8)))));
  // PTX:147 ld.global.f32 %f14, [%rd36+20]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (20)))));
  // PTX:148 mul.f32 %f110, %f87, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f110) : "f"(f87), "f"(f14));
  // PTX:149 mul.f32 %f111, %f89, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f111) : "f"(f89), "f"(f14));
  // PTX:150 mul.f32 %f112, %f91, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f112) : "f"(f91), "f"(f14));
  // PTX:151 fma.rn.f32 %f113, %f79, %f13, %f110
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f113) : "f"(f79), "f"(f13), "f"(f110));
  // PTX:152 fma.rn.f32 %f114, %f82, %f13, %f111
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f114) : "f"(f82), "f"(f13), "f"(f111));
  // PTX:153 fma.rn.f32 %f115, %f85, %f13, %f112
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f115) : "f"(f85), "f"(f13), "f"(f112));
  // PTX:154 ld.global.f32 %f15, [%rd36+32]
  f15 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (32)))));
  // PTX:155 fma.rn.f32 %f16, %f93, %f15, %f113
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f16) : "f"(f93), "f"(f15), "f"(f113));
  // PTX:156 fma.rn.f32 %f17, %f95, %f15, %f114
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f17) : "f"(f95), "f"(f15), "f"(f114));
  // PTX:157 fma.rn.f32 %f18, %f97, %f15, %f115
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f18) : "f"(f97), "f"(f15), "f"(f115));
  // PTX:158 add.s64 %rd48, %rd28, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd48) : "l"(rd28), "l"(rd40));
  // PTX:159 add.s64 %rd49, %rd28, %rd42
  asm("add.s64 %0, %1, %2;" : "=l"(rd49) : "l"(rd28), "l"(rd42));
  // PTX:160 ld.global.f32 %f116, [%rd49]
  f116 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))));
  // PTX:161 ld.global.f32 %f117, [%rd48]
  f117 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))));
  // PTX:162 sub.f32 %f118, %f116, %f117
  asm("sub.f32 %0, %1, %2;" : "=f"(f118) : "f"(f116), "f"(f117));
  // PTX:163 ld.global.f32 %f119, [%rd49+4]
  f119 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (4)))));
  // PTX:164 ld.global.f32 %f120, [%rd48+4]
  f120 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (4)))));
  // PTX:165 sub.f32 %f121, %f119, %f120
  asm("sub.f32 %0, %1, %2;" : "=f"(f121) : "f"(f119), "f"(f120));
  // PTX:166 ld.global.f32 %f122, [%rd49+8]
  f122 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (8)))));
  // PTX:167 ld.global.f32 %f123, [%rd48+8]
  f123 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (8)))));
  // PTX:168 sub.f32 %f124, %f122, %f123
  asm("sub.f32 %0, %1, %2;" : "=f"(f124) : "f"(f122), "f"(f123));
  // PTX:169 add.s64 %rd50, %rd28, %rd44
  asm("add.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd28), "l"(rd44));
  // PTX:170 ld.global.f32 %f125, [%rd50]
  f125 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (0)))));
  // PTX:171 sub.f32 %f126, %f125, %f117
  asm("sub.f32 %0, %1, %2;" : "=f"(f126) : "f"(f125), "f"(f117));
  // PTX:172 ld.global.f32 %f127, [%rd50+4]
  f127 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (4)))));
  // PTX:173 sub.f32 %f128, %f127, %f120
  asm("sub.f32 %0, %1, %2;" : "=f"(f128) : "f"(f127), "f"(f120));
  // PTX:174 ld.global.f32 %f129, [%rd50+8]
  f129 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (8)))));
  // PTX:175 sub.f32 %f130, %f129, %f123
  asm("sub.f32 %0, %1, %2;" : "=f"(f130) : "f"(f129), "f"(f123));
  // PTX:176 add.s64 %rd51, %rd28, %rd46
  asm("add.s64 %0, %1, %2;" : "=l"(rd51) : "l"(rd28), "l"(rd46));
  // PTX:177 ld.global.f32 %f131, [%rd51]
  f131 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))));
  // PTX:178 sub.f32 %f132, %f131, %f117
  asm("sub.f32 %0, %1, %2;" : "=f"(f132) : "f"(f131), "f"(f117));
  // PTX:179 ld.global.f32 %f133, [%rd51+4]
  f133 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (4)))));
  // PTX:180 sub.f32 %f134, %f133, %f120
  asm("sub.f32 %0, %1, %2;" : "=f"(f134) : "f"(f133), "f"(f120));
  // PTX:181 ld.global.f32 %f135, [%rd51+8]
  f135 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (8)))));
  // PTX:182 sub.f32 %f136, %f135, %f123
  asm("sub.f32 %0, %1, %2;" : "=f"(f136) : "f"(f135), "f"(f123));
  // PTX:183 mul.f32 %f137, %f126, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f137) : "f"(f126), "f"(f2));
  // PTX:184 mul.f32 %f138, %f128, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f138) : "f"(f128), "f"(f2));
  // PTX:185 mul.f32 %f139, %f130, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f139) : "f"(f130), "f"(f2));
  // PTX:186 fma.rn.f32 %f140, %f118, %f1, %f137
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f140) : "f"(f118), "f"(f1), "f"(f137));
  // PTX:187 fma.rn.f32 %f141, %f121, %f1, %f138
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f141) : "f"(f121), "f"(f1), "f"(f138));
  // PTX:188 fma.rn.f32 %f142, %f124, %f1, %f139
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f142) : "f"(f124), "f"(f1), "f"(f139));
  // PTX:189 fma.rn.f32 %f143, %f132, %f3, %f140
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f143) : "f"(f132), "f"(f3), "f"(f140));
  // PTX:190 fma.rn.f32 %f144, %f134, %f3, %f141
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f144) : "f"(f134), "f"(f3), "f"(f141));
  // PTX:191 fma.rn.f32 %f145, %f136, %f3, %f142
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f145) : "f"(f136), "f"(f3), "f"(f142));
  // PTX:192 mul.f32 %f146, %f126, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f146) : "f"(f126), "f"(f8));
  // PTX:193 mul.f32 %f147, %f128, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f147) : "f"(f128), "f"(f8));
  // PTX:194 mul.f32 %f148, %f130, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f148) : "f"(f130), "f"(f8));
  // PTX:195 fma.rn.f32 %f149, %f118, %f7, %f146
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f149) : "f"(f118), "f"(f7), "f"(f146));
  // PTX:196 fma.rn.f32 %f150, %f121, %f7, %f147
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f150) : "f"(f121), "f"(f7), "f"(f147));
  // PTX:197 fma.rn.f32 %f151, %f124, %f7, %f148
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f151) : "f"(f124), "f"(f7), "f"(f148));
  // PTX:198 fma.rn.f32 %f152, %f132, %f9, %f149
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f152) : "f"(f132), "f"(f9), "f"(f149));
  // PTX:199 fma.rn.f32 %f153, %f134, %f9, %f150
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f153) : "f"(f134), "f"(f9), "f"(f150));
  // PTX:200 fma.rn.f32 %f154, %f136, %f9, %f151
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f154) : "f"(f136), "f"(f9), "f"(f151));
  // PTX:201 mul.f32 %f155, %f126, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f155) : "f"(f126), "f"(f14));
  // PTX:202 mul.f32 %f156, %f128, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f156) : "f"(f128), "f"(f14));
  // PTX:203 mul.f32 %f157, %f130, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f157) : "f"(f130), "f"(f14));
  // PTX:204 fma.rn.f32 %f158, %f118, %f13, %f155
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f158) : "f"(f118), "f"(f13), "f"(f155));
  // PTX:205 fma.rn.f32 %f159, %f121, %f13, %f156
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f159) : "f"(f121), "f"(f13), "f"(f156));
  // PTX:206 fma.rn.f32 %f160, %f124, %f13, %f157
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f160) : "f"(f124), "f"(f13), "f"(f157));
  // PTX:207 fma.rn.f32 %f161, %f132, %f15, %f158
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f161) : "f"(f132), "f"(f15), "f"(f158));
  // PTX:208 fma.rn.f32 %f162, %f134, %f15, %f159
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f162) : "f"(f134), "f"(f15), "f"(f159));
  // PTX:209 fma.rn.f32 %f163, %f136, %f15, %f160
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f163) : "f"(f136), "f"(f15), "f"(f160));
  // PTX:210 mul.f32 %f164, %f11, %f18
  asm("mul.f32 %0, %1, %2;" : "=f"(f164) : "f"(f11), "f"(f18));
  // PTX:211 mul.f32 %f165, %f17, %f12
  asm("mul.f32 %0, %1, %2;" : "=f"(f165) : "f"(f17), "f"(f12));
  // PTX:212 sub.f32 %f166, %f164, %f165
  asm("sub.f32 %0, %1, %2;" : "=f"(f166) : "f"(f164), "f"(f165));
  // PTX:213 mul.f32 %f167, %f16, %f12
  asm("mul.f32 %0, %1, %2;" : "=f"(f167) : "f"(f16), "f"(f12));
  // PTX:214 mul.f32 %f168, %f10, %f18
  asm("mul.f32 %0, %1, %2;" : "=f"(f168) : "f"(f10), "f"(f18));
  // PTX:215 sub.f32 %f169, %f167, %f168
  asm("sub.f32 %0, %1, %2;" : "=f"(f169) : "f"(f167), "f"(f168));
  // PTX:216 mul.f32 %f170, %f10, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f170) : "f"(f10), "f"(f17));
  // PTX:217 mul.f32 %f171, %f16, %f11
  asm("mul.f32 %0, %1, %2;" : "=f"(f171) : "f"(f16), "f"(f11));
  // PTX:218 sub.f32 %f172, %f170, %f171
  asm("sub.f32 %0, %1, %2;" : "=f"(f172) : "f"(f170), "f"(f171));
  // PTX:219 mul.f32 %f173, %f17, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f173) : "f"(f17), "f"(f6));
  // PTX:220 mul.f32 %f174, %f5, %f18
  asm("mul.f32 %0, %1, %2;" : "=f"(f174) : "f"(f5), "f"(f18));
  // PTX:221 sub.f32 %f175, %f173, %f174
  asm("sub.f32 %0, %1, %2;" : "=f"(f175) : "f"(f173), "f"(f174));
  // PTX:222 mul.f32 %f176, %f4, %f18
  asm("mul.f32 %0, %1, %2;" : "=f"(f176) : "f"(f4), "f"(f18));
  // PTX:223 mul.f32 %f177, %f16, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f177) : "f"(f16), "f"(f6));
  // PTX:224 sub.f32 %f178, %f176, %f177
  asm("sub.f32 %0, %1, %2;" : "=f"(f178) : "f"(f176), "f"(f177));
  // PTX:225 mul.f32 %f179, %f16, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f179) : "f"(f16), "f"(f5));
  // PTX:226 mul.f32 %f180, %f4, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f180) : "f"(f4), "f"(f17));
  // PTX:227 sub.f32 %f181, %f179, %f180
  asm("sub.f32 %0, %1, %2;" : "=f"(f181) : "f"(f179), "f"(f180));
  // PTX:228 mul.f32 %f182, %f5, %f12
  asm("mul.f32 %0, %1, %2;" : "=f"(f182) : "f"(f5), "f"(f12));
  // PTX:229 mul.f32 %f183, %f11, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f183) : "f"(f11), "f"(f6));
  // PTX:230 sub.f32 %f184, %f182, %f183
  asm("sub.f32 %0, %1, %2;" : "=f"(f184) : "f"(f182), "f"(f183));
  // PTX:231 mul.f32 %f185, %f10, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f185) : "f"(f10), "f"(f6));
  // PTX:232 mul.f32 %f186, %f4, %f12
  asm("mul.f32 %0, %1, %2;" : "=f"(f186) : "f"(f4), "f"(f12));
  // PTX:233 sub.f32 %f187, %f185, %f186
  asm("sub.f32 %0, %1, %2;" : "=f"(f187) : "f"(f185), "f"(f186));
  // PTX:234 mul.f32 %f188, %f4, %f11
  asm("mul.f32 %0, %1, %2;" : "=f"(f188) : "f"(f4), "f"(f11));
  // PTX:235 mul.f32 %f189, %f10, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f189) : "f"(f10), "f"(f5));
  // PTX:236 sub.f32 %f190, %f188, %f189
  asm("sub.f32 %0, %1, %2;" : "=f"(f190) : "f"(f188), "f"(f189));
  // PTX:237 ld.global.f32 %f191, [%rd39+4]
  f191 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (4)))));
  // PTX:238 ld.global.f32 %f192, [%rd39]
  f192 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (0)))));
  // PTX:239 add.f32 %f193, %f192, %f191
  asm("add.f32 %0, %1, %2;" : "=f"(f193) : "f"(f192), "f"(f191));
  // PTX:240 mul.f32 %f194, %f169, %f144
  asm("mul.f32 %0, %1, %2;" : "=f"(f194) : "f"(f169), "f"(f144));
  // PTX:241 fma.rn.f32 %f195, %f166, %f143, %f194
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f195) : "f"(f166), "f"(f143), "f"(f194));
  // PTX:242 fma.rn.f32 %f196, %f172, %f145, %f195
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f196) : "f"(f172), "f"(f145), "f"(f195));
  // PTX:243 mul.f32 %f197, %f178, %f153
  asm("mul.f32 %0, %1, %2;" : "=f"(f197) : "f"(f178), "f"(f153));
  // PTX:244 fma.rn.f32 %f198, %f175, %f152, %f197
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f198) : "f"(f175), "f"(f152), "f"(f197));
  // PTX:245 fma.rn.f32 %f199, %f181, %f154, %f198
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f199) : "f"(f181), "f"(f154), "f"(f198));
  // PTX:246 add.f32 %f200, %f196, %f199
  asm("add.f32 %0, %1, %2;" : "=f"(f200) : "f"(f196), "f"(f199));
  // PTX:247 mul.f32 %f201, %f187, %f162
  asm("mul.f32 %0, %1, %2;" : "=f"(f201) : "f"(f187), "f"(f162));
  // PTX:248 fma.rn.f32 %f202, %f184, %f161, %f201
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f202) : "f"(f184), "f"(f161), "f"(f201));
  // PTX:249 fma.rn.f32 %f203, %f190, %f163, %f202
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f203) : "f"(f190), "f"(f163), "f"(f202));
  // PTX:250 add.f32 %f204, %f203, %f200
  asm("add.f32 %0, %1, %2;" : "=f"(f204) : "f"(f203), "f"(f200));
  // PTX:251 mul.f32 %f205, %f193, %f204
  asm("mul.f32 %0, %1, %2;" : "=f"(f205) : "f"(f193), "f"(f204));
  // PTX:252 mul.f32 %f206, %f166, %f205
  asm("mul.f32 %0, %1, %2;" : "=f"(f206) : "f"(f166), "f"(f205));
  // PTX:253 mul.f32 %f207, %f169, %f205
  asm("mul.f32 %0, %1, %2;" : "=f"(f207) : "f"(f169), "f"(f205));
  // PTX:254 mul.f32 %f208, %f172, %f205
  asm("mul.f32 %0, %1, %2;" : "=f"(f208) : "f"(f172), "f"(f205));
  // PTX:255 mul.f32 %f209, %f175, %f205
  asm("mul.f32 %0, %1, %2;" : "=f"(f209) : "f"(f175), "f"(f205));
  // PTX:256 mul.f32 %f210, %f178, %f205
  asm("mul.f32 %0, %1, %2;" : "=f"(f210) : "f"(f178), "f"(f205));
  // PTX:257 mul.f32 %f211, %f181, %f205
  asm("mul.f32 %0, %1, %2;" : "=f"(f211) : "f"(f181), "f"(f205));
  // PTX:258 mul.f32 %f212, %f184, %f205
  asm("mul.f32 %0, %1, %2;" : "=f"(f212) : "f"(f184), "f"(f205));
  // PTX:259 mul.f32 %f213, %f187, %f205
  asm("mul.f32 %0, %1, %2;" : "=f"(f213) : "f"(f187), "f"(f205));
  // PTX:260 mul.f32 %f214, %f190, %f205
  asm("mul.f32 %0, %1, %2;" : "=f"(f214) : "f"(f190), "f"(f205));
  // PTX:261 fma.rn.f32 %f19, %f192, %f143, %f206
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f19) : "f"(f192), "f"(f143), "f"(f206));
  // PTX:262 fma.rn.f32 %f20, %f192, %f144, %f207
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f20) : "f"(f192), "f"(f144), "f"(f207));
  // PTX:263 fma.rn.f32 %f21, %f192, %f145, %f208
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f21) : "f"(f192), "f"(f145), "f"(f208));
  // PTX:264 fma.rn.f32 %f22, %f192, %f152, %f209
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f22) : "f"(f192), "f"(f152), "f"(f209));
  // PTX:265 fma.rn.f32 %f23, %f192, %f153, %f210
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f23) : "f"(f192), "f"(f153), "f"(f210));
  // PTX:266 fma.rn.f32 %f24, %f192, %f154, %f211
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f24) : "f"(f192), "f"(f154), "f"(f211));
  // PTX:267 fma.rn.f32 %f25, %f192, %f161, %f212
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f25) : "f"(f192), "f"(f161), "f"(f212));
  // PTX:268 fma.rn.f32 %f26, %f192, %f162, %f213
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f26) : "f"(f192), "f"(f162), "f"(f213));
  // PTX:269 fma.rn.f32 %f27, %f192, %f163, %f214
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f27) : "f"(f192), "f"(f163), "f"(f214));
  // PTX:270 mul.f32 %f215, %f5, %f144
  asm("mul.f32 %0, %1, %2;" : "=f"(f215) : "f"(f5), "f"(f144));
  // PTX:271 fma.rn.f32 %f216, %f4, %f143, %f215
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f216) : "f"(f4), "f"(f143), "f"(f215));
  // PTX:272 fma.rn.f32 %f217, %f6, %f145, %f216
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f217) : "f"(f6), "f"(f145), "f"(f216));
  // PTX:273 add.f32 %f28, %f217, %f217
  asm("add.f32 %0, %1, %2;" : "=f"(f28) : "f"(f217), "f"(f217));
  // PTX:274 mul.f32 %f218, %f11, %f144
  asm("mul.f32 %0, %1, %2;" : "=f"(f218) : "f"(f11), "f"(f144));
  // PTX:275 fma.rn.f32 %f219, %f10, %f143, %f218
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f219) : "f"(f10), "f"(f143), "f"(f218));
  // PTX:276 fma.rn.f32 %f220, %f12, %f145, %f219
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f220) : "f"(f12), "f"(f145), "f"(f219));
  // PTX:277 mul.f32 %f221, %f5, %f153
  asm("mul.f32 %0, %1, %2;" : "=f"(f221) : "f"(f5), "f"(f153));
  // PTX:278 fma.rn.f32 %f222, %f4, %f152, %f221
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f222) : "f"(f4), "f"(f152), "f"(f221));
  // PTX:279 fma.rn.f32 %f223, %f6, %f154, %f222
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f223) : "f"(f6), "f"(f154), "f"(f222));
  // PTX:280 add.f32 %f224, %f220, %f223
  asm("add.f32 %0, %1, %2;" : "=f"(f224) : "f"(f220), "f"(f223));
  // PTX:281 mul.f32 %f225, %f17, %f144
  asm("mul.f32 %0, %1, %2;" : "=f"(f225) : "f"(f17), "f"(f144));
  // PTX:282 fma.rn.f32 %f226, %f16, %f143, %f225
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f226) : "f"(f16), "f"(f143), "f"(f225));
  // PTX:283 fma.rn.f32 %f227, %f18, %f145, %f226
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f227) : "f"(f18), "f"(f145), "f"(f226));
  // PTX:284 mul.f32 %f228, %f5, %f162
  asm("mul.f32 %0, %1, %2;" : "=f"(f228) : "f"(f5), "f"(f162));
  // PTX:285 fma.rn.f32 %f229, %f4, %f161, %f228
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f229) : "f"(f4), "f"(f161), "f"(f228));
  // PTX:286 fma.rn.f32 %f230, %f6, %f163, %f229
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f230) : "f"(f6), "f"(f163), "f"(f229));
  // PTX:287 add.f32 %f231, %f227, %f230
  asm("add.f32 %0, %1, %2;" : "=f"(f231) : "f"(f227), "f"(f230));
  // PTX:288 mul.f32 %f232, %f11, %f153
  asm("mul.f32 %0, %1, %2;" : "=f"(f232) : "f"(f11), "f"(f153));
  // PTX:289 fma.rn.f32 %f233, %f10, %f152, %f232
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f233) : "f"(f10), "f"(f152), "f"(f232));
  // PTX:290 fma.rn.f32 %f234, %f12, %f154, %f233
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f234) : "f"(f12), "f"(f154), "f"(f233));
  // PTX:291 add.f32 %f29, %f234, %f234
  asm("add.f32 %0, %1, %2;" : "=f"(f29) : "f"(f234), "f"(f234));
  // PTX:292 mul.f32 %f235, %f17, %f153
  asm("mul.f32 %0, %1, %2;" : "=f"(f235) : "f"(f17), "f"(f153));
  // PTX:293 fma.rn.f32 %f236, %f16, %f152, %f235
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f236) : "f"(f16), "f"(f152), "f"(f235));
  // PTX:294 fma.rn.f32 %f237, %f18, %f154, %f236
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f237) : "f"(f18), "f"(f154), "f"(f236));
  // PTX:295 mul.f32 %f238, %f11, %f162
  asm("mul.f32 %0, %1, %2;" : "=f"(f238) : "f"(f11), "f"(f162));
  // PTX:296 fma.rn.f32 %f239, %f10, %f161, %f238
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f239) : "f"(f10), "f"(f161), "f"(f238));
  // PTX:297 fma.rn.f32 %f240, %f12, %f163, %f239
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f240) : "f"(f12), "f"(f163), "f"(f239));
  // PTX:298 add.f32 %f241, %f237, %f240
  asm("add.f32 %0, %1, %2;" : "=f"(f241) : "f"(f237), "f"(f240));
  // PTX:299 mul.f32 %f242, %f17, %f162
  asm("mul.f32 %0, %1, %2;" : "=f"(f242) : "f"(f17), "f"(f162));
  // PTX:300 fma.rn.f32 %f243, %f16, %f161, %f242
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f243) : "f"(f16), "f"(f161), "f"(f242));
  // PTX:301 fma.rn.f32 %f244, %f18, %f163, %f243
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f244) : "f"(f18), "f"(f163), "f"(f243));
  // PTX:302 add.f32 %f30, %f244, %f244
  asm("add.f32 %0, %1, %2;" : "=f"(f30) : "f"(f244), "f"(f244));
  // PTX:303 neg.f32 %f245, %f1
  asm("neg.f32 %0, %1;" : "=f"(f245) : "f"(f1));
  // PTX:304 neg.f32 %f246, %f7
  asm("neg.f32 %0, %1;" : "=f"(f246) : "f"(f7));
  // PTX:305 neg.f32 %f247, %f13
  asm("neg.f32 %0, %1;" : "=f"(f247) : "f"(f13));
  // PTX:306 sub.f32 %f248, %f245, %f2
  asm("sub.f32 %0, %1, %2;" : "=f"(f248) : "f"(f245), "f"(f2));
  // PTX:307 sub.f32 %f249, %f246, %f8
  asm("sub.f32 %0, %1, %2;" : "=f"(f249) : "f"(f246), "f"(f8));
  // PTX:308 sub.f32 %f250, %f247, %f14
  asm("sub.f32 %0, %1, %2;" : "=f"(f250) : "f"(f247), "f"(f14));
  // PTX:309 sub.f32 %f31, %f248, %f3
  asm("sub.f32 %0, %1, %2;" : "=f"(f31) : "f"(f248), "f"(f3));
  // PTX:310 sub.f32 %f32, %f249, %f9
  asm("sub.f32 %0, %1, %2;" : "=f"(f32) : "f"(f249), "f"(f9));
  // PTX:311 sub.f32 %f33, %f250, %f15
  asm("sub.f32 %0, %1, %2;" : "=f"(f33) : "f"(f250), "f"(f15));
  // PTX:312 ld.global.f32 %f34, [%rd39+8]
  f34 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (8)))));
  // PTX:313 setp.leu.f32 %p3, %f34, 0f00000000
  p3 = ((isnan(((float)(f34))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f34)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:314 cvta.to.global.u64 %rd52, %rd18
  rd52 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd18));
  // PTX:315 shl.b64 %rd53, %rd72, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd53) : "l"(rd72));
  // PTX:316 add.s64 %rd54, %rd52, %rd53
  asm("add.s64 %0, %1, %2;" : "=l"(rd54) : "l"(rd52), "l"(rd53));
  // PTX:317 ld.global.f32 %f35, [%rd54]
  f35 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))));
  // PTX:318 mul.f32 %f251, %f34, %f35
  asm("mul.f32 %0, %1, %2;" : "=f"(f251) : "f"(f34), "f"(f35));
  // PTX:319 mul.f32 %f36, %f251, %f76
  asm("mul.f32 %0, %1, %2;" : "=f"(f36) : "f"(f251), "f"(f76));
  // PTX:320 add.f32 %f37, %f224, %f224
  asm("add.f32 %0, %1, %2;" : "=f"(f37) : "f"(f224), "f"(f224));
  // PTX:321 add.f32 %f38, %f231, %f231
  asm("add.f32 %0, %1, %2;" : "=f"(f38) : "f"(f231), "f"(f231));
  // PTX:322 add.f32 %f39, %f241, %f241
  asm("add.f32 %0, %1, %2;" : "=f"(f39) : "f"(f241), "f"(f241));
  // PTX:323 mul.f32 %f252, %f22, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f252) : "f"(f22), "f"(f32));
  // PTX:324 mul.f32 %f253, %f23, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f253) : "f"(f23), "f"(f32));
  // PTX:325 mul.f32 %f254, %f24, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f254) : "f"(f24), "f"(f32));
  // PTX:326 fma.rn.f32 %f255, %f19, %f31, %f252
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f255) : "f"(f19), "f"(f31), "f"(f252));
  // PTX:327 fma.rn.f32 %f256, %f20, %f31, %f253
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f256) : "f"(f20), "f"(f31), "f"(f253));
  // PTX:328 fma.rn.f32 %f257, %f21, %f31, %f254
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f257) : "f"(f21), "f"(f31), "f"(f254));
  // PTX:329 fma.rn.f32 %f258, %f25, %f33, %f255
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f258) : "f"(f25), "f"(f33), "f"(f255));
  // PTX:330 fma.rn.f32 %f259, %f26, %f33, %f256
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f259) : "f"(f26), "f"(f33), "f"(f256));
  // PTX:331 fma.rn.f32 %f260, %f27, %f33, %f257
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f260) : "f"(f27), "f"(f33), "f"(f257));
  // PTX:332 mul.f32 %f492, %f35, %f258
  asm("mul.f32 %0, %1, %2;" : "=f"(f492) : "f"(f35), "f"(f258));
  // PTX:333 mul.f32 %f493, %f35, %f259
  asm("mul.f32 %0, %1, %2;" : "=f"(f493) : "f"(f35), "f"(f259));
  // PTX:334 mul.f32 %f494, %f35, %f260
  asm("mul.f32 %0, %1, %2;" : "=f"(f494) : "f"(f35), "f"(f260));
  // PTX:335 @%p3 bra $L__BB44_6
  if (p3) { goto L_BB44_6; }
  // PTX:337 add.f32 %f261, %f31, %f31
  asm("add.f32 %0, %1, %2;" : "=f"(f261) : "f"(f31), "f"(f31));
  // PTX:338 mul.f32 %f262, %f4, %f261
  asm("mul.f32 %0, %1, %2;" : "=f"(f262) : "f"(f4), "f"(f261));
  // PTX:339 mul.f32 %f263, %f5, %f261
  asm("mul.f32 %0, %1, %2;" : "=f"(f263) : "f"(f5), "f"(f261));
  // PTX:340 mul.f32 %f264, %f6, %f261
  asm("mul.f32 %0, %1, %2;" : "=f"(f264) : "f"(f6), "f"(f261));
  // PTX:341 mul.f32 %f265, %f4, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f265) : "f"(f4), "f"(f32));
  // PTX:342 fma.rn.f32 %f266, %f10, %f31, %f265
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f266) : "f"(f10), "f"(f31), "f"(f265));
  // PTX:343 mul.f32 %f267, %f5, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f267) : "f"(f5), "f"(f32));
  // PTX:344 fma.rn.f32 %f268, %f11, %f31, %f267
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f268) : "f"(f11), "f"(f31), "f"(f267));
  // PTX:345 mul.f32 %f269, %f6, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f269) : "f"(f6), "f"(f32));
  // PTX:346 fma.rn.f32 %f270, %f12, %f31, %f269
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f270) : "f"(f12), "f"(f31), "f"(f269));
  // PTX:347 mul.f32 %f271, %f4, %f33
  asm("mul.f32 %0, %1, %2;" : "=f"(f271) : "f"(f4), "f"(f33));
  // PTX:348 fma.rn.f32 %f272, %f16, %f31, %f271
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f272) : "f"(f16), "f"(f31), "f"(f271));
  // PTX:349 mul.f32 %f273, %f5, %f33
  asm("mul.f32 %0, %1, %2;" : "=f"(f273) : "f"(f5), "f"(f33));
  // PTX:350 fma.rn.f32 %f274, %f17, %f31, %f273
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f274) : "f"(f17), "f"(f31), "f"(f273));
  // PTX:351 mul.f32 %f275, %f6, %f33
  asm("mul.f32 %0, %1, %2;" : "=f"(f275) : "f"(f6), "f"(f33));
  // PTX:352 fma.rn.f32 %f276, %f18, %f31, %f275
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f276) : "f"(f18), "f"(f31), "f"(f275));
  // PTX:353 add.f32 %f277, %f32, %f32
  asm("add.f32 %0, %1, %2;" : "=f"(f277) : "f"(f32), "f"(f32));
  // PTX:354 mul.f32 %f278, %f10, %f277
  asm("mul.f32 %0, %1, %2;" : "=f"(f278) : "f"(f10), "f"(f277));
  // PTX:355 mul.f32 %f279, %f11, %f277
  asm("mul.f32 %0, %1, %2;" : "=f"(f279) : "f"(f11), "f"(f277));
  // PTX:356 mul.f32 %f280, %f12, %f277
  asm("mul.f32 %0, %1, %2;" : "=f"(f280) : "f"(f12), "f"(f277));
  // PTX:357 mul.f32 %f281, %f10, %f33
  asm("mul.f32 %0, %1, %2;" : "=f"(f281) : "f"(f10), "f"(f33));
  // PTX:358 fma.rn.f32 %f282, %f16, %f32, %f281
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f282) : "f"(f16), "f"(f32), "f"(f281));
  // PTX:359 mul.f32 %f283, %f11, %f33
  asm("mul.f32 %0, %1, %2;" : "=f"(f283) : "f"(f11), "f"(f33));
  // PTX:360 fma.rn.f32 %f284, %f17, %f32, %f283
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f284) : "f"(f17), "f"(f32), "f"(f283));
  // PTX:361 mul.f32 %f285, %f12, %f33
  asm("mul.f32 %0, %1, %2;" : "=f"(f285) : "f"(f12), "f"(f33));
  // PTX:362 fma.rn.f32 %f286, %f18, %f32, %f285
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f286) : "f"(f18), "f"(f32), "f"(f285));
  // PTX:363 add.f32 %f287, %f33, %f33
  asm("add.f32 %0, %1, %2;" : "=f"(f287) : "f"(f33), "f"(f33));
  // PTX:364 mul.f32 %f288, %f16, %f287
  asm("mul.f32 %0, %1, %2;" : "=f"(f288) : "f"(f16), "f"(f287));
  // PTX:365 mul.f32 %f289, %f17, %f287
  asm("mul.f32 %0, %1, %2;" : "=f"(f289) : "f"(f17), "f"(f287));
  // PTX:366 mul.f32 %f290, %f18, %f287
  asm("mul.f32 %0, %1, %2;" : "=f"(f290) : "f"(f18), "f"(f287));
  // PTX:367 mul.f32 %f291, %f37, %f266
  asm("mul.f32 %0, %1, %2;" : "=f"(f291) : "f"(f37), "f"(f266));
  // PTX:368 mul.f32 %f292, %f37, %f268
  asm("mul.f32 %0, %1, %2;" : "=f"(f292) : "f"(f37), "f"(f268));
  // PTX:369 mul.f32 %f293, %f37, %f270
  asm("mul.f32 %0, %1, %2;" : "=f"(f293) : "f"(f37), "f"(f270));
  // PTX:370 fma.rn.f32 %f294, %f28, %f262, %f291
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f294) : "f"(f28), "f"(f262), "f"(f291));
  // PTX:371 fma.rn.f32 %f295, %f28, %f263, %f292
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f295) : "f"(f28), "f"(f263), "f"(f292));
  // PTX:372 fma.rn.f32 %f296, %f28, %f264, %f293
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f296) : "f"(f28), "f"(f264), "f"(f293));
  // PTX:373 fma.rn.f32 %f297, %f38, %f272, %f294
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f297) : "f"(f38), "f"(f272), "f"(f294));
  // PTX:374 fma.rn.f32 %f298, %f38, %f274, %f295
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f298) : "f"(f38), "f"(f274), "f"(f295));
  // PTX:375 fma.rn.f32 %f299, %f38, %f276, %f296
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f299) : "f"(f38), "f"(f276), "f"(f296));
  // PTX:376 fma.rn.f32 %f300, %f29, %f278, %f297
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f300) : "f"(f29), "f"(f278), "f"(f297));
  // PTX:377 fma.rn.f32 %f301, %f29, %f279, %f298
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f301) : "f"(f29), "f"(f279), "f"(f298));
  // PTX:378 fma.rn.f32 %f302, %f29, %f280, %f299
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f302) : "f"(f29), "f"(f280), "f"(f299));
  // PTX:379 fma.rn.f32 %f303, %f39, %f282, %f300
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f303) : "f"(f39), "f"(f282), "f"(f300));
  // PTX:380 fma.rn.f32 %f304, %f39, %f284, %f301
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f304) : "f"(f39), "f"(f284), "f"(f301));
  // PTX:381 fma.rn.f32 %f305, %f39, %f286, %f302
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f305) : "f"(f39), "f"(f286), "f"(f302));
  // PTX:382 fma.rn.f32 %f306, %f30, %f288, %f303
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f306) : "f"(f30), "f"(f288), "f"(f303));
  // PTX:383 fma.rn.f32 %f307, %f30, %f289, %f304
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f307) : "f"(f30), "f"(f289), "f"(f304));
  // PTX:384 fma.rn.f32 %f308, %f30, %f290, %f305
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f308) : "f"(f30), "f"(f290), "f"(f305));
  // PTX:385 fma.rn.f32 %f492, %f36, %f306, %f492
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f492) : "f"(f36), "f"(f306), "f"(f492));
  // PTX:386 fma.rn.f32 %f493, %f36, %f307, %f493
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f493) : "f"(f36), "f"(f307), "f"(f493));
  // PTX:387 fma.rn.f32 %f494, %f36, %f308, %f494
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f494) : "f"(f36), "f"(f308), "f"(f494));
  // PTX:389 $L__BB44_6:
L_BB44_6:;
  // PTX:390 mul.lo.s64 %rd55, %rd9, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd55) : "l"(rd9));
  // PTX:391 add.s64 %rd56, %rd1, %rd55
  asm("add.s64 %0, %1, %2;" : "=l"(rd56) : "l"(rd1), "l"(rd55));
  // PTX:392 red.global.add.f32 [%rd56], %f492
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))), (float)(f492));
  // PTX:393 add.s64 %rd57, %rd56, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd57) : "l"(rd56));
  // PTX:394 red.global.add.f32 [%rd57], %f493
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))), (float)(f493));
  // PTX:395 add.s64 %rd58, %rd56, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd58) : "l"(rd56));
  // PTX:396 red.global.add.f32 [%rd58], %f494
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (0)))), (float)(f494));
  // PTX:397 mul.f32 %f312, %f22, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f312) : "f"(f22), "f"(f7));
  // PTX:398 fma.rn.f32 %f313, %f19, %f1, %f312
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f313) : "f"(f19), "f"(f1), "f"(f312));
  // PTX:399 mul.f32 %f314, %f23, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f314) : "f"(f23), "f"(f7));
  // PTX:400 fma.rn.f32 %f315, %f20, %f1, %f314
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f315) : "f"(f20), "f"(f1), "f"(f314));
  // PTX:401 mul.f32 %f316, %f24, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f316) : "f"(f24), "f"(f7));
  // PTX:402 fma.rn.f32 %f317, %f21, %f1, %f316
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f317) : "f"(f21), "f"(f1), "f"(f316));
  // PTX:403 fma.rn.f32 %f318, %f25, %f13, %f313
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f318) : "f"(f25), "f"(f13), "f"(f313));
  // PTX:404 fma.rn.f32 %f319, %f26, %f13, %f315
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f319) : "f"(f26), "f"(f13), "f"(f315));
  // PTX:405 fma.rn.f32 %f320, %f27, %f13, %f317
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f320) : "f"(f27), "f"(f13), "f"(f317));
  // PTX:406 mul.f32 %f495, %f35, %f318
  asm("mul.f32 %0, %1, %2;" : "=f"(f495) : "f"(f35), "f"(f318));
  // PTX:407 mul.f32 %f496, %f35, %f319
  asm("mul.f32 %0, %1, %2;" : "=f"(f496) : "f"(f35), "f"(f319));
  // PTX:408 mul.f32 %f497, %f35, %f320
  asm("mul.f32 %0, %1, %2;" : "=f"(f497) : "f"(f35), "f"(f320));
  // PTX:409 @%p3 bra $L__BB44_8
  if (p3) { goto L_BB44_8; }
  // PTX:411 add.f32 %f321, %f1, %f1
  asm("add.f32 %0, %1, %2;" : "=f"(f321) : "f"(f1), "f"(f1));
  // PTX:412 mul.f32 %f322, %f4, %f321
  asm("mul.f32 %0, %1, %2;" : "=f"(f322) : "f"(f4), "f"(f321));
  // PTX:413 mul.f32 %f323, %f5, %f321
  asm("mul.f32 %0, %1, %2;" : "=f"(f323) : "f"(f5), "f"(f321));
  // PTX:414 mul.f32 %f324, %f6, %f321
  asm("mul.f32 %0, %1, %2;" : "=f"(f324) : "f"(f6), "f"(f321));
  // PTX:415 mul.f32 %f325, %f4, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f325) : "f"(f4), "f"(f7));
  // PTX:416 fma.rn.f32 %f326, %f10, %f1, %f325
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f326) : "f"(f10), "f"(f1), "f"(f325));
  // PTX:417 mul.f32 %f327, %f5, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f327) : "f"(f5), "f"(f7));
  // PTX:418 fma.rn.f32 %f328, %f11, %f1, %f327
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f328) : "f"(f11), "f"(f1), "f"(f327));
  // PTX:419 mul.f32 %f329, %f6, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f329) : "f"(f6), "f"(f7));
  // PTX:420 fma.rn.f32 %f330, %f12, %f1, %f329
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f330) : "f"(f12), "f"(f1), "f"(f329));
  // PTX:421 mul.f32 %f331, %f4, %f13
  asm("mul.f32 %0, %1, %2;" : "=f"(f331) : "f"(f4), "f"(f13));
  // PTX:422 fma.rn.f32 %f332, %f16, %f1, %f331
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f332) : "f"(f16), "f"(f1), "f"(f331));
  // PTX:423 mul.f32 %f333, %f5, %f13
  asm("mul.f32 %0, %1, %2;" : "=f"(f333) : "f"(f5), "f"(f13));
  // PTX:424 fma.rn.f32 %f334, %f17, %f1, %f333
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f334) : "f"(f17), "f"(f1), "f"(f333));
  // PTX:425 mul.f32 %f335, %f6, %f13
  asm("mul.f32 %0, %1, %2;" : "=f"(f335) : "f"(f6), "f"(f13));
  // PTX:426 fma.rn.f32 %f336, %f18, %f1, %f335
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f336) : "f"(f18), "f"(f1), "f"(f335));
  // PTX:427 add.f32 %f337, %f7, %f7
  asm("add.f32 %0, %1, %2;" : "=f"(f337) : "f"(f7), "f"(f7));
  // PTX:428 mul.f32 %f338, %f10, %f337
  asm("mul.f32 %0, %1, %2;" : "=f"(f338) : "f"(f10), "f"(f337));
  // PTX:429 mul.f32 %f339, %f11, %f337
  asm("mul.f32 %0, %1, %2;" : "=f"(f339) : "f"(f11), "f"(f337));
  // PTX:430 mul.f32 %f340, %f12, %f337
  asm("mul.f32 %0, %1, %2;" : "=f"(f340) : "f"(f12), "f"(f337));
  // PTX:431 mul.f32 %f341, %f10, %f13
  asm("mul.f32 %0, %1, %2;" : "=f"(f341) : "f"(f10), "f"(f13));
  // PTX:432 fma.rn.f32 %f342, %f16, %f7, %f341
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f342) : "f"(f16), "f"(f7), "f"(f341));
  // PTX:433 mul.f32 %f343, %f11, %f13
  asm("mul.f32 %0, %1, %2;" : "=f"(f343) : "f"(f11), "f"(f13));
  // PTX:434 fma.rn.f32 %f344, %f17, %f7, %f343
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f344) : "f"(f17), "f"(f7), "f"(f343));
  // PTX:435 mul.f32 %f345, %f12, %f13
  asm("mul.f32 %0, %1, %2;" : "=f"(f345) : "f"(f12), "f"(f13));
  // PTX:436 fma.rn.f32 %f346, %f18, %f7, %f345
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f346) : "f"(f18), "f"(f7), "f"(f345));
  // PTX:437 add.f32 %f347, %f13, %f13
  asm("add.f32 %0, %1, %2;" : "=f"(f347) : "f"(f13), "f"(f13));
  // PTX:438 mul.f32 %f348, %f16, %f347
  asm("mul.f32 %0, %1, %2;" : "=f"(f348) : "f"(f16), "f"(f347));
  // PTX:439 mul.f32 %f349, %f17, %f347
  asm("mul.f32 %0, %1, %2;" : "=f"(f349) : "f"(f17), "f"(f347));
  // PTX:440 mul.f32 %f350, %f18, %f347
  asm("mul.f32 %0, %1, %2;" : "=f"(f350) : "f"(f18), "f"(f347));
  // PTX:441 mul.f32 %f351, %f37, %f326
  asm("mul.f32 %0, %1, %2;" : "=f"(f351) : "f"(f37), "f"(f326));
  // PTX:442 mul.f32 %f352, %f37, %f328
  asm("mul.f32 %0, %1, %2;" : "=f"(f352) : "f"(f37), "f"(f328));
  // PTX:443 mul.f32 %f353, %f37, %f330
  asm("mul.f32 %0, %1, %2;" : "=f"(f353) : "f"(f37), "f"(f330));
  // PTX:444 fma.rn.f32 %f354, %f28, %f322, %f351
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f354) : "f"(f28), "f"(f322), "f"(f351));
  // PTX:445 fma.rn.f32 %f355, %f28, %f323, %f352
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f355) : "f"(f28), "f"(f323), "f"(f352));
  // PTX:446 fma.rn.f32 %f356, %f28, %f324, %f353
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f356) : "f"(f28), "f"(f324), "f"(f353));
  // PTX:447 fma.rn.f32 %f357, %f38, %f332, %f354
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f357) : "f"(f38), "f"(f332), "f"(f354));
  // PTX:448 fma.rn.f32 %f358, %f38, %f334, %f355
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f358) : "f"(f38), "f"(f334), "f"(f355));
  // PTX:449 fma.rn.f32 %f359, %f38, %f336, %f356
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f359) : "f"(f38), "f"(f336), "f"(f356));
  // PTX:450 fma.rn.f32 %f360, %f29, %f338, %f357
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f360) : "f"(f29), "f"(f338), "f"(f357));
  // PTX:451 fma.rn.f32 %f361, %f29, %f339, %f358
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f361) : "f"(f29), "f"(f339), "f"(f358));
  // PTX:452 fma.rn.f32 %f362, %f29, %f340, %f359
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f362) : "f"(f29), "f"(f340), "f"(f359));
  // PTX:453 fma.rn.f32 %f363, %f39, %f342, %f360
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f363) : "f"(f39), "f"(f342), "f"(f360));
  // PTX:454 fma.rn.f32 %f364, %f39, %f344, %f361
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f364) : "f"(f39), "f"(f344), "f"(f361));
  // PTX:455 fma.rn.f32 %f365, %f39, %f346, %f362
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f365) : "f"(f39), "f"(f346), "f"(f362));
  // PTX:456 fma.rn.f32 %f366, %f30, %f348, %f363
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f366) : "f"(f30), "f"(f348), "f"(f363));
  // PTX:457 fma.rn.f32 %f367, %f30, %f349, %f364
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f367) : "f"(f30), "f"(f349), "f"(f364));
  // PTX:458 fma.rn.f32 %f368, %f30, %f350, %f365
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f368) : "f"(f30), "f"(f350), "f"(f365));
  // PTX:459 fma.rn.f32 %f495, %f36, %f366, %f495
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f495) : "f"(f36), "f"(f366), "f"(f495));
  // PTX:460 fma.rn.f32 %f496, %f36, %f367, %f496
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f496) : "f"(f36), "f"(f367), "f"(f496));
  // PTX:461 fma.rn.f32 %f497, %f36, %f368, %f497
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f497) : "f"(f36), "f"(f368), "f"(f497));
  // PTX:463 $L__BB44_8:
L_BB44_8:;
  // PTX:464 mul.lo.s64 %rd59, %rd10, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd59) : "l"(rd10));
  // PTX:465 add.s64 %rd60, %rd1, %rd59
  asm("add.s64 %0, %1, %2;" : "=l"(rd60) : "l"(rd1), "l"(rd59));
  // PTX:466 red.global.add.f32 [%rd60], %f495
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))), (float)(f495));
  // PTX:467 add.s64 %rd61, %rd60, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd61) : "l"(rd60));
  // PTX:468 red.global.add.f32 [%rd61], %f496
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))), (float)(f496));
  // PTX:469 add.s64 %rd62, %rd60, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd62) : "l"(rd60));
  // PTX:470 red.global.add.f32 [%rd62], %f497
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))), (float)(f497));
  // PTX:471 mul.f32 %f372, %f22, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f372) : "f"(f22), "f"(f8));
  // PTX:472 fma.rn.f32 %f373, %f19, %f2, %f372
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f373) : "f"(f19), "f"(f2), "f"(f372));
  // PTX:473 mul.f32 %f374, %f23, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f374) : "f"(f23), "f"(f8));
  // PTX:474 fma.rn.f32 %f375, %f20, %f2, %f374
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f375) : "f"(f20), "f"(f2), "f"(f374));
  // PTX:475 mul.f32 %f376, %f24, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f376) : "f"(f24), "f"(f8));
  // PTX:476 fma.rn.f32 %f377, %f21, %f2, %f376
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f377) : "f"(f21), "f"(f2), "f"(f376));
  // PTX:477 fma.rn.f32 %f378, %f25, %f14, %f373
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f378) : "f"(f25), "f"(f14), "f"(f373));
  // PTX:478 fma.rn.f32 %f379, %f26, %f14, %f375
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f379) : "f"(f26), "f"(f14), "f"(f375));
  // PTX:479 fma.rn.f32 %f380, %f27, %f14, %f377
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f380) : "f"(f27), "f"(f14), "f"(f377));
  // PTX:480 mul.f32 %f498, %f35, %f378
  asm("mul.f32 %0, %1, %2;" : "=f"(f498) : "f"(f35), "f"(f378));
  // PTX:481 mul.f32 %f499, %f35, %f379
  asm("mul.f32 %0, %1, %2;" : "=f"(f499) : "f"(f35), "f"(f379));
  // PTX:482 mul.f32 %f500, %f35, %f380
  asm("mul.f32 %0, %1, %2;" : "=f"(f500) : "f"(f35), "f"(f380));
  // PTX:483 @%p3 bra $L__BB44_10
  if (p3) { goto L_BB44_10; }
  // PTX:485 add.f32 %f381, %f2, %f2
  asm("add.f32 %0, %1, %2;" : "=f"(f381) : "f"(f2), "f"(f2));
  // PTX:486 mul.f32 %f382, %f4, %f381
  asm("mul.f32 %0, %1, %2;" : "=f"(f382) : "f"(f4), "f"(f381));
  // PTX:487 mul.f32 %f383, %f5, %f381
  asm("mul.f32 %0, %1, %2;" : "=f"(f383) : "f"(f5), "f"(f381));
  // PTX:488 mul.f32 %f384, %f6, %f381
  asm("mul.f32 %0, %1, %2;" : "=f"(f384) : "f"(f6), "f"(f381));
  // PTX:489 mul.f32 %f385, %f4, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f385) : "f"(f4), "f"(f8));
  // PTX:490 fma.rn.f32 %f386, %f10, %f2, %f385
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f386) : "f"(f10), "f"(f2), "f"(f385));
  // PTX:491 mul.f32 %f387, %f5, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f387) : "f"(f5), "f"(f8));
  // PTX:492 fma.rn.f32 %f388, %f11, %f2, %f387
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f388) : "f"(f11), "f"(f2), "f"(f387));
  // PTX:493 mul.f32 %f389, %f6, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f389) : "f"(f6), "f"(f8));
  // PTX:494 fma.rn.f32 %f390, %f12, %f2, %f389
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f390) : "f"(f12), "f"(f2), "f"(f389));
  // PTX:495 mul.f32 %f391, %f4, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f391) : "f"(f4), "f"(f14));
  // PTX:496 fma.rn.f32 %f392, %f16, %f2, %f391
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f392) : "f"(f16), "f"(f2), "f"(f391));
  // PTX:497 mul.f32 %f393, %f5, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f393) : "f"(f5), "f"(f14));
  // PTX:498 fma.rn.f32 %f394, %f17, %f2, %f393
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f394) : "f"(f17), "f"(f2), "f"(f393));
  // PTX:499 mul.f32 %f395, %f6, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f395) : "f"(f6), "f"(f14));
  // PTX:500 fma.rn.f32 %f396, %f18, %f2, %f395
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f396) : "f"(f18), "f"(f2), "f"(f395));
  // PTX:501 add.f32 %f397, %f8, %f8
  asm("add.f32 %0, %1, %2;" : "=f"(f397) : "f"(f8), "f"(f8));
  // PTX:502 mul.f32 %f398, %f10, %f397
  asm("mul.f32 %0, %1, %2;" : "=f"(f398) : "f"(f10), "f"(f397));
  // PTX:503 mul.f32 %f399, %f11, %f397
  asm("mul.f32 %0, %1, %2;" : "=f"(f399) : "f"(f11), "f"(f397));
  // PTX:504 mul.f32 %f400, %f12, %f397
  asm("mul.f32 %0, %1, %2;" : "=f"(f400) : "f"(f12), "f"(f397));
  // PTX:505 mul.f32 %f401, %f10, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f401) : "f"(f10), "f"(f14));
  // PTX:506 fma.rn.f32 %f402, %f16, %f8, %f401
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f402) : "f"(f16), "f"(f8), "f"(f401));
  // PTX:507 mul.f32 %f403, %f11, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f403) : "f"(f11), "f"(f14));
  // PTX:508 fma.rn.f32 %f404, %f17, %f8, %f403
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f404) : "f"(f17), "f"(f8), "f"(f403));
  // PTX:509 mul.f32 %f405, %f12, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f405) : "f"(f12), "f"(f14));
  // PTX:510 fma.rn.f32 %f406, %f18, %f8, %f405
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f406) : "f"(f18), "f"(f8), "f"(f405));
  // PTX:511 add.f32 %f407, %f14, %f14
  asm("add.f32 %0, %1, %2;" : "=f"(f407) : "f"(f14), "f"(f14));
  // PTX:512 mul.f32 %f408, %f16, %f407
  asm("mul.f32 %0, %1, %2;" : "=f"(f408) : "f"(f16), "f"(f407));
  // PTX:513 mul.f32 %f409, %f17, %f407
  asm("mul.f32 %0, %1, %2;" : "=f"(f409) : "f"(f17), "f"(f407));
  // PTX:514 mul.f32 %f410, %f18, %f407
  asm("mul.f32 %0, %1, %2;" : "=f"(f410) : "f"(f18), "f"(f407));
  // PTX:515 mul.f32 %f411, %f37, %f386
  asm("mul.f32 %0, %1, %2;" : "=f"(f411) : "f"(f37), "f"(f386));
  // PTX:516 mul.f32 %f412, %f37, %f388
  asm("mul.f32 %0, %1, %2;" : "=f"(f412) : "f"(f37), "f"(f388));
  // PTX:517 mul.f32 %f413, %f37, %f390
  asm("mul.f32 %0, %1, %2;" : "=f"(f413) : "f"(f37), "f"(f390));
  // PTX:518 fma.rn.f32 %f414, %f28, %f382, %f411
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f414) : "f"(f28), "f"(f382), "f"(f411));
  // PTX:519 fma.rn.f32 %f415, %f28, %f383, %f412
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f415) : "f"(f28), "f"(f383), "f"(f412));
  // PTX:520 fma.rn.f32 %f416, %f28, %f384, %f413
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f416) : "f"(f28), "f"(f384), "f"(f413));
  // PTX:521 fma.rn.f32 %f417, %f38, %f392, %f414
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f417) : "f"(f38), "f"(f392), "f"(f414));
  // PTX:522 fma.rn.f32 %f418, %f38, %f394, %f415
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f418) : "f"(f38), "f"(f394), "f"(f415));
  // PTX:523 fma.rn.f32 %f419, %f38, %f396, %f416
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f419) : "f"(f38), "f"(f396), "f"(f416));
  // PTX:524 fma.rn.f32 %f420, %f29, %f398, %f417
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f420) : "f"(f29), "f"(f398), "f"(f417));
  // PTX:525 fma.rn.f32 %f421, %f29, %f399, %f418
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f421) : "f"(f29), "f"(f399), "f"(f418));
  // PTX:526 fma.rn.f32 %f422, %f29, %f400, %f419
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f422) : "f"(f29), "f"(f400), "f"(f419));
  // PTX:527 fma.rn.f32 %f423, %f39, %f402, %f420
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f423) : "f"(f39), "f"(f402), "f"(f420));
  // PTX:528 fma.rn.f32 %f424, %f39, %f404, %f421
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f424) : "f"(f39), "f"(f404), "f"(f421));
  // PTX:529 fma.rn.f32 %f425, %f39, %f406, %f422
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f425) : "f"(f39), "f"(f406), "f"(f422));
  // PTX:530 fma.rn.f32 %f426, %f30, %f408, %f423
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f426) : "f"(f30), "f"(f408), "f"(f423));
  // PTX:531 fma.rn.f32 %f427, %f30, %f409, %f424
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f427) : "f"(f30), "f"(f409), "f"(f424));
  // PTX:532 fma.rn.f32 %f428, %f30, %f410, %f425
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f428) : "f"(f30), "f"(f410), "f"(f425));
  // PTX:533 fma.rn.f32 %f498, %f36, %f426, %f498
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f498) : "f"(f36), "f"(f426), "f"(f498));
  // PTX:534 fma.rn.f32 %f499, %f36, %f427, %f499
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f499) : "f"(f36), "f"(f427), "f"(f499));
  // PTX:535 fma.rn.f32 %f500, %f36, %f428, %f500
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f500) : "f"(f36), "f"(f428), "f"(f500));
  // PTX:537 $L__BB44_10:
L_BB44_10:;
  // PTX:538 mul.lo.s64 %rd63, %rd11, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd63) : "l"(rd11));
  // PTX:539 add.s64 %rd64, %rd1, %rd63
  asm("add.s64 %0, %1, %2;" : "=l"(rd64) : "l"(rd1), "l"(rd63));
  // PTX:540 red.global.add.f32 [%rd64], %f498
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (0)))), (float)(f498));
  // PTX:541 add.s64 %rd65, %rd64, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd65) : "l"(rd64));
  // PTX:542 red.global.add.f32 [%rd65], %f499
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (0)))), (float)(f499));
  // PTX:543 add.s64 %rd66, %rd64, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd66) : "l"(rd64));
  // PTX:544 red.global.add.f32 [%rd66], %f500
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (0)))), (float)(f500));
  // PTX:545 mul.f32 %f432, %f22, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f432) : "f"(f22), "f"(f9));
  // PTX:546 fma.rn.f32 %f433, %f19, %f3, %f432
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f433) : "f"(f19), "f"(f3), "f"(f432));
  // PTX:547 mul.f32 %f434, %f23, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f434) : "f"(f23), "f"(f9));
  // PTX:548 fma.rn.f32 %f435, %f20, %f3, %f434
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f435) : "f"(f20), "f"(f3), "f"(f434));
  // PTX:549 mul.f32 %f436, %f24, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f436) : "f"(f24), "f"(f9));
  // PTX:550 fma.rn.f32 %f437, %f21, %f3, %f436
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f437) : "f"(f21), "f"(f3), "f"(f436));
  // PTX:551 fma.rn.f32 %f438, %f25, %f15, %f433
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f438) : "f"(f25), "f"(f15), "f"(f433));
  // PTX:552 fma.rn.f32 %f439, %f26, %f15, %f435
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f439) : "f"(f26), "f"(f15), "f"(f435));
  // PTX:553 fma.rn.f32 %f440, %f27, %f15, %f437
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f440) : "f"(f27), "f"(f15), "f"(f437));
  // PTX:554 mul.f32 %f501, %f35, %f438
  asm("mul.f32 %0, %1, %2;" : "=f"(f501) : "f"(f35), "f"(f438));
  // PTX:555 mul.f32 %f502, %f35, %f439
  asm("mul.f32 %0, %1, %2;" : "=f"(f502) : "f"(f35), "f"(f439));
  // PTX:556 mul.f32 %f503, %f35, %f440
  asm("mul.f32 %0, %1, %2;" : "=f"(f503) : "f"(f35), "f"(f440));
  // PTX:557 @%p3 bra $L__BB44_12
  if (p3) { goto L_BB44_12; }
  // PTX:559 add.f32 %f441, %f3, %f3
  asm("add.f32 %0, %1, %2;" : "=f"(f441) : "f"(f3), "f"(f3));
  // PTX:560 mul.f32 %f442, %f4, %f441
  asm("mul.f32 %0, %1, %2;" : "=f"(f442) : "f"(f4), "f"(f441));
  // PTX:561 mul.f32 %f443, %f5, %f441
  asm("mul.f32 %0, %1, %2;" : "=f"(f443) : "f"(f5), "f"(f441));
  // PTX:562 mul.f32 %f444, %f6, %f441
  asm("mul.f32 %0, %1, %2;" : "=f"(f444) : "f"(f6), "f"(f441));
  // PTX:563 mul.f32 %f445, %f4, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f445) : "f"(f4), "f"(f9));
  // PTX:564 fma.rn.f32 %f446, %f10, %f3, %f445
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f446) : "f"(f10), "f"(f3), "f"(f445));
  // PTX:565 mul.f32 %f447, %f5, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f447) : "f"(f5), "f"(f9));
  // PTX:566 fma.rn.f32 %f448, %f11, %f3, %f447
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f448) : "f"(f11), "f"(f3), "f"(f447));
  // PTX:567 mul.f32 %f449, %f6, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f449) : "f"(f6), "f"(f9));
  // PTX:568 fma.rn.f32 %f450, %f12, %f3, %f449
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f450) : "f"(f12), "f"(f3), "f"(f449));
  // PTX:569 mul.f32 %f451, %f4, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f451) : "f"(f4), "f"(f15));
  // PTX:570 fma.rn.f32 %f452, %f16, %f3, %f451
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f452) : "f"(f16), "f"(f3), "f"(f451));
  // PTX:571 mul.f32 %f453, %f5, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f453) : "f"(f5), "f"(f15));
  // PTX:572 fma.rn.f32 %f454, %f17, %f3, %f453
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f454) : "f"(f17), "f"(f3), "f"(f453));
  // PTX:573 mul.f32 %f455, %f6, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f455) : "f"(f6), "f"(f15));
  // PTX:574 fma.rn.f32 %f456, %f18, %f3, %f455
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f456) : "f"(f18), "f"(f3), "f"(f455));
  // PTX:575 add.f32 %f457, %f9, %f9
  asm("add.f32 %0, %1, %2;" : "=f"(f457) : "f"(f9), "f"(f9));
  // PTX:576 mul.f32 %f458, %f10, %f457
  asm("mul.f32 %0, %1, %2;" : "=f"(f458) : "f"(f10), "f"(f457));
  // PTX:577 mul.f32 %f459, %f11, %f457
  asm("mul.f32 %0, %1, %2;" : "=f"(f459) : "f"(f11), "f"(f457));
  // PTX:578 mul.f32 %f460, %f12, %f457
  asm("mul.f32 %0, %1, %2;" : "=f"(f460) : "f"(f12), "f"(f457));
  // PTX:579 mul.f32 %f461, %f10, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f461) : "f"(f10), "f"(f15));
  // PTX:580 fma.rn.f32 %f462, %f16, %f9, %f461
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f462) : "f"(f16), "f"(f9), "f"(f461));
  // PTX:581 mul.f32 %f463, %f11, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f463) : "f"(f11), "f"(f15));
  // PTX:582 fma.rn.f32 %f464, %f17, %f9, %f463
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f464) : "f"(f17), "f"(f9), "f"(f463));
  // PTX:583 mul.f32 %f465, %f12, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f465) : "f"(f12), "f"(f15));
  // PTX:584 fma.rn.f32 %f466, %f18, %f9, %f465
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f466) : "f"(f18), "f"(f9), "f"(f465));
  // PTX:585 add.f32 %f467, %f15, %f15
  asm("add.f32 %0, %1, %2;" : "=f"(f467) : "f"(f15), "f"(f15));
  // PTX:586 mul.f32 %f468, %f16, %f467
  asm("mul.f32 %0, %1, %2;" : "=f"(f468) : "f"(f16), "f"(f467));
  // PTX:587 mul.f32 %f469, %f17, %f467
  asm("mul.f32 %0, %1, %2;" : "=f"(f469) : "f"(f17), "f"(f467));
  // PTX:588 mul.f32 %f470, %f18, %f467
  asm("mul.f32 %0, %1, %2;" : "=f"(f470) : "f"(f18), "f"(f467));
  // PTX:589 mul.f32 %f471, %f37, %f446
  asm("mul.f32 %0, %1, %2;" : "=f"(f471) : "f"(f37), "f"(f446));
  // PTX:590 mul.f32 %f472, %f37, %f448
  asm("mul.f32 %0, %1, %2;" : "=f"(f472) : "f"(f37), "f"(f448));
  // PTX:591 mul.f32 %f473, %f37, %f450
  asm("mul.f32 %0, %1, %2;" : "=f"(f473) : "f"(f37), "f"(f450));
  // PTX:592 fma.rn.f32 %f474, %f28, %f442, %f471
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f474) : "f"(f28), "f"(f442), "f"(f471));
  // PTX:593 fma.rn.f32 %f475, %f28, %f443, %f472
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f475) : "f"(f28), "f"(f443), "f"(f472));
  // PTX:594 fma.rn.f32 %f476, %f28, %f444, %f473
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f476) : "f"(f28), "f"(f444), "f"(f473));
  // PTX:595 fma.rn.f32 %f477, %f38, %f452, %f474
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f477) : "f"(f38), "f"(f452), "f"(f474));
  // PTX:596 fma.rn.f32 %f478, %f38, %f454, %f475
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f478) : "f"(f38), "f"(f454), "f"(f475));
  // PTX:597 fma.rn.f32 %f479, %f38, %f456, %f476
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f479) : "f"(f38), "f"(f456), "f"(f476));
  // PTX:598 fma.rn.f32 %f480, %f29, %f458, %f477
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f480) : "f"(f29), "f"(f458), "f"(f477));
  // PTX:599 fma.rn.f32 %f481, %f29, %f459, %f478
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f481) : "f"(f29), "f"(f459), "f"(f478));
  // PTX:600 fma.rn.f32 %f482, %f29, %f460, %f479
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f482) : "f"(f29), "f"(f460), "f"(f479));
  // PTX:601 fma.rn.f32 %f483, %f39, %f462, %f480
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f483) : "f"(f39), "f"(f462), "f"(f480));
  // PTX:602 fma.rn.f32 %f484, %f39, %f464, %f481
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f484) : "f"(f39), "f"(f464), "f"(f481));
  // PTX:603 fma.rn.f32 %f485, %f39, %f466, %f482
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f485) : "f"(f39), "f"(f466), "f"(f482));
  // PTX:604 fma.rn.f32 %f486, %f30, %f468, %f483
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f486) : "f"(f30), "f"(f468), "f"(f483));
  // PTX:605 fma.rn.f32 %f487, %f30, %f469, %f484
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f487) : "f"(f30), "f"(f469), "f"(f484));
  // PTX:606 fma.rn.f32 %f488, %f30, %f470, %f485
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f488) : "f"(f30), "f"(f470), "f"(f485));
  // PTX:607 fma.rn.f32 %f501, %f36, %f486, %f501
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f501) : "f"(f36), "f"(f486), "f"(f501));
  // PTX:608 fma.rn.f32 %f502, %f36, %f487, %f502
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f502) : "f"(f36), "f"(f487), "f"(f502));
  // PTX:609 fma.rn.f32 %f503, %f36, %f488, %f503
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f503) : "f"(f36), "f"(f488), "f"(f503));
  // PTX:611 $L__BB44_12:
L_BB44_12:;
  // PTX:612 mul.lo.s64 %rd67, %rd12, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd67) : "l"(rd12));
  // PTX:613 add.s64 %rd68, %rd1, %rd67
  asm("add.s64 %0, %1, %2;" : "=l"(rd68) : "l"(rd1), "l"(rd67));
  // PTX:614 red.global.add.f32 [%rd68], %f501
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (0)))), (float)(f501));
  // PTX:615 add.s64 %rd69, %rd68, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd69) : "l"(rd68));
  // PTX:616 red.global.add.f32 [%rd69], %f502
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (0)))), (float)(f502));
  // PTX:617 add.s64 %rd70, %rd68, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd70) : "l"(rd68));
  // PTX:618 red.global.add.f32 [%rd70], %f503
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0)))), (float)(f503));
  // PTX:620 $L__BB44_13:
L_BB44_13:;
  // PTX:621 ret
  return;
}
