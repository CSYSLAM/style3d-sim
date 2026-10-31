// 机械还原自 PTX：synreal::kernel::evaluate_tetrahedron_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 3220bcf09d5f632247227714810b979168982d9243473509884115759f133414
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__evaluate_tetrahedron_force(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, float param7, unsigned long long param8, unsigned long long param9, unsigned long long param10, unsigned long long param11) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440, f441, f442, f443, f444, f445, f446, f447, f448, f449, f450, f451, f452, f453, f454, f455, f456, f457, f458, f459, f460, f461, f462, f463, f464, f465, f466, f467, f468, f469, f470, f471, f472, f473, f474, f475, f476, f477, f478, f479, f480, f481, f482, f483, f484, f485, f486, f487, f488, f489, f490, f491, f492, f493, f494, f495, f496, f497, f498, f499, f500, f501, f502, f503, f504, f505, f506, f507, f508, f509, f510, f511, f512, f513, f514, f515, f516, f517, f518, f519, f520, f521, f522, f523, f524, f525, f526, f527, f528, f529, f530, f531, f532, f533, f534, f535, f536, f537, f538, f539, f540, f541, f542, f543, f544, f545, f546, f547, f548, f549, f550, f551, f552;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81;
  // PTX:28 ld.param.u64 %rd13, [_ZN7synreal6kernel26evaluate_tetrahedron_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKfSF_fPS4_mmm_param_0]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:29 ld.param.u64 %rd15, [_ZN7synreal6kernel26evaluate_tetrahedron_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKfSF_fPS4_mmm_param_2]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:30 ld.param.u64 %rd16, [_ZN7synreal6kernel26evaluate_tetrahedron_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKfSF_fPS4_mmm_param_3]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:31 ld.param.u64 %rd17, [_ZN7synreal6kernel26evaluate_tetrahedron_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKfSF_fPS4_mmm_param_4]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:32 ld.param.u64 %rd18, [_ZN7synreal6kernel26evaluate_tetrahedron_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKfSF_fPS4_mmm_param_5]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:33 ld.param.u64 %rd19, [_ZN7synreal6kernel26evaluate_tetrahedron_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKfSF_fPS4_mmm_param_6]
  rd19 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:34 ld.param.u64 %rd22, [_ZN7synreal6kernel26evaluate_tetrahedron_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKfSF_fPS4_mmm_param_8]
  rd22 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:35 ld.param.u64 %rd23, [_ZN7synreal6kernel26evaluate_tetrahedron_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKfSF_fPS4_mmm_param_9]
  rd23 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:36 ld.param.u64 %rd20, [_ZN7synreal6kernel26evaluate_tetrahedron_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKfSF_fPS4_mmm_param_10]
  rd20 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:37 ld.param.u64 %rd21, [_ZN7synreal6kernel26evaluate_tetrahedron_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKfSF_fPS4_mmm_param_11]
  rd21 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:38 cvta.to.global.u64 %rd1, %rd22
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd22));
  // PTX:39 mov.u32 %r1, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r1) : "r"(blockIdx.x));
  // PTX:40 mov.u32 %r2, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockDim.x));
  // PTX:41 mul.wide.u32 %rd24, %r1, %r2
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd24) : "r"(r1), "r"(r2));
  // PTX:42 mov.u32 %r3, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(threadIdx.x));
  // PTX:43 cvt.u64.u32 %rd25, %r3
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd25) : "r"(r3));
  // PTX:44 add.s64 %rd2, %rd24, %rd25
  asm("add.s64 %0, %1, %2;" : "=l"(rd2) : "l"(rd24), "l"(rd25));
  // PTX:45 setp.ge.u64 %p1, %rd2, %rd23
  p1 = (((unsigned long long)(rd2)) >= ((unsigned long long)(rd23)));
  // PTX:46 @%p1 bra $L__BB43_19
  if (p1) { goto L_BB43_19; }
  // PTX:48 or.b64 %rd26, %rd2, %rd20
  asm("or.b64 %0, %1, %2;" : "=l"(rd26) : "l"(rd2), "l"(rd20));
  // PTX:49 and.b64 %rd27, %rd26, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd27) : "l"(rd26));
  // PTX:50 setp.eq.s64 %p2, %rd27, 0
  p2 = (((long long)(rd27)) == ((long long)(0)));
  // PTX:51 @%p2 bra $L__BB43_3
  if (p2) { goto L_BB43_3; }
  // PTX:53 div.u64 %rd80, %rd2, %rd20
  asm("div.u64 %0, %1, %2;" : "=l"(rd80) : "l"(rd2), "l"(rd20));
  // PTX:54 mul.lo.s64 %rd28, %rd80, %rd20
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd28) : "l"(rd80), "l"(rd20));
  // PTX:55 sub.s64 %rd81, %rd2, %rd28
  asm("sub.s64 %0, %1, %2;" : "=l"(rd81) : "l"(rd2), "l"(rd28));
  // PTX:56 bra.uni $L__BB43_4
  goto L_BB43_4;
  // PTX:58 $L__BB43_3:
L_BB43_3:;
  // PTX:59 cvt.u32.u64 %r4, %rd20
  asm("cvt.u32.u64 %0, %1;" : "=r"(r4) : "l"(rd20));
  // PTX:60 cvt.u32.u64 %r5, %rd2
  asm("cvt.u32.u64 %0, %1;" : "=r"(r5) : "l"(rd2));
  // PTX:61 div.u32 %r6, %r5, %r4
  asm("div.u32 %0, %1, %2;" : "=r"(r6) : "r"(r5), "r"(r4));
  // PTX:62 mul.lo.s32 %r7, %r6, %r4
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r7) : "r"(r6), "r"(r4));
  // PTX:63 sub.s32 %r8, %r5, %r7
  asm("sub.s32 %0, %1, %2;" : "=r"(r8) : "r"(r5), "r"(r7));
  // PTX:64 cvt.u64.u32 %rd80, %r6
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd80) : "r"(r6));
  // PTX:65 cvt.u64.u32 %rd81, %r8
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd81) : "r"(r8));
  // PTX:67 $L__BB43_4:
L_BB43_4:;
  // PTX:68 cvta.to.global.u64 %rd29, %rd13
  rd29 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd13));
  // PTX:69 mul.lo.s64 %rd30, %rd80, %rd21
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd30) : "l"(rd80), "l"(rd21));
  // PTX:70 cvt.u32.u64 %r9, %rd30
  asm("cvt.u32.u64 %0, %1;" : "=r"(r9) : "l"(rd30));
  // PTX:71 cvta.to.global.u64 %rd31, %rd15
  rd31 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd15));
  // PTX:72 shl.b64 %rd32, %rd81, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd32) : "l"(rd81));
  // PTX:73 add.s64 %rd33, %rd31, %rd32
  asm("add.s64 %0, %1, %2;" : "=l"(rd33) : "l"(rd31), "l"(rd32));
  // PTX:74 ld.global.u32 %r10, [%rd33]
  r10 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (0)))));
  // PTX:75 add.s32 %r11, %r10, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r11) : "r"(r10), "r"(r9));
  // PTX:76 ld.global.u32 %r12, [%rd33+4]
  r12 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (4)))));
  // PTX:77 add.s32 %r13, %r12, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r13) : "r"(r12), "r"(r9));
  // PTX:78 ld.global.u32 %r14, [%rd33+8]
  r14 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (8)))));
  // PTX:79 add.s32 %r15, %r14, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r15) : "r"(r14), "r"(r9));
  // PTX:80 ld.global.u32 %r16, [%rd33+12]
  r16 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (12)))));
  // PTX:81 add.s32 %r17, %r16, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r17) : "r"(r16), "r"(r9));
  // PTX:82 cvta.to.global.u64 %rd34, %rd16
  rd34 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd16));
  // PTX:83 mul.lo.s64 %rd35, %rd81, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd35) : "l"(rd81));
  // PTX:84 add.s64 %rd36, %rd34, %rd35
  asm("add.s64 %0, %1, %2;" : "=l"(rd36) : "l"(rd34), "l"(rd35));
  // PTX:85 cvta.to.global.u64 %rd37, %rd17
  rd37 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd17));
  // PTX:86 mul.lo.s64 %rd38, %rd81, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd38) : "l"(rd81));
  // PTX:87 add.s64 %rd39, %rd37, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd39) : "l"(rd37), "l"(rd38));
  // PTX:88 ld.global.f32 %f1, [%rd39+8]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (8)))));
  // PTX:89 cvta.to.global.u64 %rd40, %rd18
  rd40 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd18));
  // PTX:90 shl.b64 %rd41, %rd81, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd41) : "l"(rd81));
  // PTX:91 add.s64 %rd42, %rd40, %rd41
  asm("add.s64 %0, %1, %2;" : "=l"(rd42) : "l"(rd40), "l"(rd41));
  // PTX:92 ld.global.f32 %f2, [%rd42]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (0)))));
  // PTX:93 cvt.s64.s32 %rd9, %r11
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd9) : "r"(r11));
  // PTX:94 mul.wide.s32 %rd43, %r11, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd43) : "r"(r11));
  // PTX:95 add.s64 %rd44, %rd29, %rd43
  asm("add.s64 %0, %1, %2;" : "=l"(rd44) : "l"(rd29), "l"(rd43));
  // PTX:96 cvt.s64.s32 %rd10, %r13
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd10) : "r"(r13));
  // PTX:97 mul.wide.s32 %rd45, %r13, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd45) : "r"(r13));
  // PTX:98 add.s64 %rd46, %rd29, %rd45
  asm("add.s64 %0, %1, %2;" : "=l"(rd46) : "l"(rd29), "l"(rd45));
  // PTX:99 ld.global.f32 %f95, [%rd46]
  f95 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (0)))));
  // PTX:100 ld.global.f32 %f96, [%rd44]
  f96 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))));
  // PTX:101 sub.f32 %f97, %f95, %f96
  asm("sub.f32 %0, %1, %2;" : "=f"(f97) : "f"(f95), "f"(f96));
  // PTX:102 ld.global.f32 %f98, [%rd46+4]
  f98 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (4)))));
  // PTX:103 ld.global.f32 %f99, [%rd44+4]
  f99 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (4)))));
  // PTX:104 sub.f32 %f100, %f98, %f99
  asm("sub.f32 %0, %1, %2;" : "=f"(f100) : "f"(f98), "f"(f99));
  // PTX:105 ld.global.f32 %f101, [%rd46+8]
  f101 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (8)))));
  // PTX:106 ld.global.f32 %f102, [%rd44+8]
  f102 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (8)))));
  // PTX:107 sub.f32 %f103, %f101, %f102
  asm("sub.f32 %0, %1, %2;" : "=f"(f103) : "f"(f101), "f"(f102));
  // PTX:108 cvt.s64.s32 %rd11, %r15
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd11) : "r"(r15));
  // PTX:109 mul.wide.s32 %rd47, %r15, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd47) : "r"(r15));
  // PTX:110 add.s64 %rd48, %rd29, %rd47
  asm("add.s64 %0, %1, %2;" : "=l"(rd48) : "l"(rd29), "l"(rd47));
  // PTX:111 ld.global.f32 %f104, [%rd48]
  f104 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))));
  // PTX:112 sub.f32 %f105, %f104, %f96
  asm("sub.f32 %0, %1, %2;" : "=f"(f105) : "f"(f104), "f"(f96));
  // PTX:113 ld.global.f32 %f106, [%rd48+4]
  f106 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (4)))));
  // PTX:114 sub.f32 %f107, %f106, %f99
  asm("sub.f32 %0, %1, %2;" : "=f"(f107) : "f"(f106), "f"(f99));
  // PTX:115 ld.global.f32 %f108, [%rd48+8]
  f108 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (8)))));
  // PTX:116 sub.f32 %f109, %f108, %f102
  asm("sub.f32 %0, %1, %2;" : "=f"(f109) : "f"(f108), "f"(f102));
  // PTX:117 cvt.s64.s32 %rd12, %r17
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd12) : "r"(r17));
  // PTX:118 mul.wide.s32 %rd49, %r17, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd49) : "r"(r17));
  // PTX:119 add.s64 %rd50, %rd29, %rd49
  asm("add.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd29), "l"(rd49));
  // PTX:120 ld.global.f32 %f110, [%rd50]
  f110 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (0)))));
  // PTX:121 sub.f32 %f111, %f110, %f96
  asm("sub.f32 %0, %1, %2;" : "=f"(f111) : "f"(f110), "f"(f96));
  // PTX:122 ld.global.f32 %f112, [%rd50+4]
  f112 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (4)))));
  // PTX:123 sub.f32 %f113, %f112, %f99
  asm("sub.f32 %0, %1, %2;" : "=f"(f113) : "f"(f112), "f"(f99));
  // PTX:124 ld.global.f32 %f114, [%rd50+8]
  f114 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (8)))));
  // PTX:125 sub.f32 %f115, %f114, %f102
  asm("sub.f32 %0, %1, %2;" : "=f"(f115) : "f"(f114), "f"(f102));
  // PTX:126 ld.global.f32 %f3, [%rd36]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (0)))));
  // PTX:127 ld.global.f32 %f4, [%rd36+12]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (12)))));
  // PTX:128 mul.f32 %f116, %f105, %f4
  asm("mul.f32 %0, %1, %2;" : "=f"(f116) : "f"(f105), "f"(f4));
  // PTX:129 mul.f32 %f117, %f107, %f4
  asm("mul.f32 %0, %1, %2;" : "=f"(f117) : "f"(f107), "f"(f4));
  // PTX:130 mul.f32 %f118, %f109, %f4
  asm("mul.f32 %0, %1, %2;" : "=f"(f118) : "f"(f109), "f"(f4));
  // PTX:131 fma.rn.f32 %f119, %f97, %f3, %f116
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f119) : "f"(f97), "f"(f3), "f"(f116));
  // PTX:132 fma.rn.f32 %f120, %f100, %f3, %f117
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f120) : "f"(f100), "f"(f3), "f"(f117));
  // PTX:133 fma.rn.f32 %f121, %f103, %f3, %f118
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f121) : "f"(f103), "f"(f3), "f"(f118));
  // PTX:134 ld.global.f32 %f5, [%rd36+24]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (24)))));
  // PTX:135 fma.rn.f32 %f6, %f111, %f5, %f119
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f6) : "f"(f111), "f"(f5), "f"(f119));
  // PTX:136 fma.rn.f32 %f7, %f113, %f5, %f120
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f7) : "f"(f113), "f"(f5), "f"(f120));
  // PTX:137 fma.rn.f32 %f8, %f115, %f5, %f121
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f8) : "f"(f115), "f"(f5), "f"(f121));
  // PTX:138 ld.global.f32 %f9, [%rd36+4]
  f9 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (4)))));
  // PTX:139 ld.global.f32 %f10, [%rd36+16]
  f10 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (16)))));
  // PTX:140 mul.f32 %f122, %f105, %f10
  asm("mul.f32 %0, %1, %2;" : "=f"(f122) : "f"(f105), "f"(f10));
  // PTX:141 mul.f32 %f123, %f107, %f10
  asm("mul.f32 %0, %1, %2;" : "=f"(f123) : "f"(f107), "f"(f10));
  // PTX:142 mul.f32 %f124, %f109, %f10
  asm("mul.f32 %0, %1, %2;" : "=f"(f124) : "f"(f109), "f"(f10));
  // PTX:143 fma.rn.f32 %f125, %f97, %f9, %f122
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f125) : "f"(f97), "f"(f9), "f"(f122));
  // PTX:144 fma.rn.f32 %f126, %f100, %f9, %f123
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f126) : "f"(f100), "f"(f9), "f"(f123));
  // PTX:145 fma.rn.f32 %f127, %f103, %f9, %f124
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f127) : "f"(f103), "f"(f9), "f"(f124));
  // PTX:146 ld.global.f32 %f11, [%rd36+28]
  f11 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (28)))));
  // PTX:147 fma.rn.f32 %f12, %f111, %f11, %f125
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f12) : "f"(f111), "f"(f11), "f"(f125));
  // PTX:148 fma.rn.f32 %f13, %f113, %f11, %f126
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f13) : "f"(f113), "f"(f11), "f"(f126));
  // PTX:149 fma.rn.f32 %f14, %f115, %f11, %f127
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f14) : "f"(f115), "f"(f11), "f"(f127));
  // PTX:150 ld.global.f32 %f15, [%rd36+8]
  f15 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (8)))));
  // PTX:151 ld.global.f32 %f16, [%rd36+20]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (20)))));
  // PTX:152 mul.f32 %f128, %f105, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f128) : "f"(f105), "f"(f16));
  // PTX:153 mul.f32 %f129, %f107, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f129) : "f"(f107), "f"(f16));
  // PTX:154 mul.f32 %f130, %f109, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f130) : "f"(f109), "f"(f16));
  // PTX:155 fma.rn.f32 %f131, %f97, %f15, %f128
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f131) : "f"(f97), "f"(f15), "f"(f128));
  // PTX:156 fma.rn.f32 %f132, %f100, %f15, %f129
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f132) : "f"(f100), "f"(f15), "f"(f129));
  // PTX:157 fma.rn.f32 %f133, %f103, %f15, %f130
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f133) : "f"(f103), "f"(f15), "f"(f130));
  // PTX:158 ld.global.f32 %f17, [%rd36+32]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (32)))));
  // PTX:159 fma.rn.f32 %f18, %f111, %f17, %f131
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f18) : "f"(f111), "f"(f17), "f"(f131));
  // PTX:160 fma.rn.f32 %f19, %f113, %f17, %f132
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f19) : "f"(f113), "f"(f17), "f"(f132));
  // PTX:161 fma.rn.f32 %f20, %f115, %f17, %f133
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f20) : "f"(f115), "f"(f17), "f"(f133));
  // PTX:162 mul.f32 %f134, %f13, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f134) : "f"(f13), "f"(f20));
  // PTX:163 mul.f32 %f135, %f19, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f135) : "f"(f19), "f"(f14));
  // PTX:164 sub.f32 %f21, %f134, %f135
  asm("sub.f32 %0, %1, %2;" : "=f"(f21) : "f"(f134), "f"(f135));
  // PTX:165 mul.f32 %f136, %f18, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f136) : "f"(f18), "f"(f14));
  // PTX:166 mul.f32 %f137, %f12, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f137) : "f"(f12), "f"(f20));
  // PTX:167 sub.f32 %f22, %f136, %f137
  asm("sub.f32 %0, %1, %2;" : "=f"(f22) : "f"(f136), "f"(f137));
  // PTX:168 mul.f32 %f138, %f12, %f19
  asm("mul.f32 %0, %1, %2;" : "=f"(f138) : "f"(f12), "f"(f19));
  // PTX:169 mul.f32 %f139, %f18, %f13
  asm("mul.f32 %0, %1, %2;" : "=f"(f139) : "f"(f18), "f"(f13));
  // PTX:170 sub.f32 %f23, %f138, %f139
  asm("sub.f32 %0, %1, %2;" : "=f"(f23) : "f"(f138), "f"(f139));
  // PTX:171 mul.f32 %f140, %f7, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f140) : "f"(f7), "f"(f22));
  // PTX:172 fma.rn.f32 %f141, %f6, %f21, %f140
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f141) : "f"(f6), "f"(f21), "f"(f140));
  // PTX:173 fma.rn.f32 %f24, %f8, %f23, %f141
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f24) : "f"(f8), "f"(f23), "f"(f141));
  // PTX:174 ld.global.f32 %f142, [%rd39+4]
  f142 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (4)))));
  // PTX:175 ld.global.f32 %f25, [%rd39]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (0)))));
  // PTX:176 add.f32 %f26, %f25, %f142
  asm("add.f32 %0, %1, %2;" : "=f"(f26) : "f"(f25), "f"(f142));
  // PTX:177 setp.eq.s64 %p3, %rd19, 0
  p3 = (((long long)(rd19)) == ((long long)(0)));
  // PTX:178 mov.f32 %f533, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f533) : );
  // PTX:179 @%p3 bra $L__BB43_6
  if (p3) { goto L_BB43_6; }
  // PTX:181 cvta.to.global.u64 %rd51, %rd19
  rd51 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd19));
  // PTX:182 shl.b64 %rd52, %rd2, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd52) : "l"(rd2));
  // PTX:183 add.s64 %rd53, %rd51, %rd52
  asm("add.s64 %0, %1, %2;" : "=l"(rd53) : "l"(rd51), "l"(rd52));
  // PTX:184 ld.global.f32 %f533, [%rd53]
  f533 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))));
  // PTX:186 $L__BB43_6:
L_BB43_6:;
  // PTX:187 setp.leu.f32 %p4, %f26, 0f00000000
  p4 = ((isnan(((float)(f26))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f26)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:188 mov.f32 %f534, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f534) : );
  // PTX:189 @%p4 bra $L__BB43_8
  if (p4) { goto L_BB43_8; }
  // PTX:191 div.rn.f32 %f144, %f25, %f26
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f144) : "f"(f25), "f"(f26));
  // PTX:192 add.f32 %f534, %f144, 0f3F800000
  asm("add.f32 %0, %1, 0f3F800000;" : "=f"(f534) : "f"(f144));
  // PTX:194 $L__BB43_8:
L_BB43_8:;
  // PTX:195 sub.f32 %f151, %f24, %f534
  asm("sub.f32 %0, %1, %2;" : "=f"(f151) : "f"(f24), "f"(f534));
  // PTX:196 add.f32 %f152, %f533, %f151
  asm("add.f32 %0, %1, %2;" : "=f"(f152) : "f"(f533), "f"(f151));
  // PTX:197 mul.f32 %f153, %f26, %f152
  asm("mul.f32 %0, %1, %2;" : "=f"(f153) : "f"(f26), "f"(f152));
  // PTX:198 mul.f32 %f154, %f21, %f153
  asm("mul.f32 %0, %1, %2;" : "=f"(f154) : "f"(f21), "f"(f153));
  // PTX:199 mul.f32 %f155, %f22, %f153
  asm("mul.f32 %0, %1, %2;" : "=f"(f155) : "f"(f22), "f"(f153));
  // PTX:200 mul.f32 %f156, %f23, %f153
  asm("mul.f32 %0, %1, %2;" : "=f"(f156) : "f"(f23), "f"(f153));
  // PTX:201 mul.f32 %f157, %f19, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f157) : "f"(f19), "f"(f8));
  // PTX:202 mul.f32 %f158, %f7, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f158) : "f"(f7), "f"(f20));
  // PTX:203 sub.f32 %f159, %f157, %f158
  asm("sub.f32 %0, %1, %2;" : "=f"(f159) : "f"(f157), "f"(f158));
  // PTX:204 mul.f32 %f160, %f159, %f153
  asm("mul.f32 %0, %1, %2;" : "=f"(f160) : "f"(f159), "f"(f153));
  // PTX:205 mul.f32 %f161, %f6, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f161) : "f"(f6), "f"(f20));
  // PTX:206 mul.f32 %f162, %f18, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f162) : "f"(f18), "f"(f8));
  // PTX:207 sub.f32 %f163, %f161, %f162
  asm("sub.f32 %0, %1, %2;" : "=f"(f163) : "f"(f161), "f"(f162));
  // PTX:208 mul.f32 %f164, %f163, %f153
  asm("mul.f32 %0, %1, %2;" : "=f"(f164) : "f"(f163), "f"(f153));
  // PTX:209 mul.f32 %f165, %f18, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f165) : "f"(f18), "f"(f7));
  // PTX:210 mul.f32 %f166, %f6, %f19
  asm("mul.f32 %0, %1, %2;" : "=f"(f166) : "f"(f6), "f"(f19));
  // PTX:211 sub.f32 %f167, %f165, %f166
  asm("sub.f32 %0, %1, %2;" : "=f"(f167) : "f"(f165), "f"(f166));
  // PTX:212 mul.f32 %f168, %f167, %f153
  asm("mul.f32 %0, %1, %2;" : "=f"(f168) : "f"(f167), "f"(f153));
  // PTX:213 mul.f32 %f169, %f7, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f169) : "f"(f7), "f"(f14));
  // PTX:214 mul.f32 %f170, %f13, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f170) : "f"(f13), "f"(f8));
  // PTX:215 sub.f32 %f171, %f169, %f170
  asm("sub.f32 %0, %1, %2;" : "=f"(f171) : "f"(f169), "f"(f170));
  // PTX:216 mul.f32 %f172, %f171, %f153
  asm("mul.f32 %0, %1, %2;" : "=f"(f172) : "f"(f171), "f"(f153));
  // PTX:217 mul.f32 %f173, %f12, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f173) : "f"(f12), "f"(f8));
  // PTX:218 mul.f32 %f174, %f6, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f174) : "f"(f6), "f"(f14));
  // PTX:219 sub.f32 %f175, %f173, %f174
  asm("sub.f32 %0, %1, %2;" : "=f"(f175) : "f"(f173), "f"(f174));
  // PTX:220 mul.f32 %f176, %f175, %f153
  asm("mul.f32 %0, %1, %2;" : "=f"(f176) : "f"(f175), "f"(f153));
  // PTX:221 mul.f32 %f177, %f6, %f13
  asm("mul.f32 %0, %1, %2;" : "=f"(f177) : "f"(f6), "f"(f13));
  // PTX:222 mul.f32 %f178, %f12, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f178) : "f"(f12), "f"(f7));
  // PTX:223 sub.f32 %f179, %f177, %f178
  asm("sub.f32 %0, %1, %2;" : "=f"(f179) : "f"(f177), "f"(f178));
  // PTX:224 mul.f32 %f180, %f179, %f153
  asm("mul.f32 %0, %1, %2;" : "=f"(f180) : "f"(f179), "f"(f153));
  // PTX:225 fma.rn.f32 %f31, %f25, %f6, %f154
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f31) : "f"(f25), "f"(f6), "f"(f154));
  // PTX:226 fma.rn.f32 %f32, %f25, %f7, %f155
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f32) : "f"(f25), "f"(f7), "f"(f155));
  // PTX:227 fma.rn.f32 %f33, %f25, %f8, %f156
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f33) : "f"(f25), "f"(f8), "f"(f156));
  // PTX:228 fma.rn.f32 %f34, %f25, %f12, %f160
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f34) : "f"(f25), "f"(f12), "f"(f160));
  // PTX:229 fma.rn.f32 %f35, %f25, %f13, %f164
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f35) : "f"(f25), "f"(f13), "f"(f164));
  // PTX:230 fma.rn.f32 %f36, %f25, %f14, %f168
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f36) : "f"(f25), "f"(f14), "f"(f168));
  // PTX:231 fma.rn.f32 %f37, %f25, %f18, %f172
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f37) : "f"(f25), "f"(f18), "f"(f172));
  // PTX:232 fma.rn.f32 %f38, %f25, %f19, %f176
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f38) : "f"(f25), "f"(f19), "f"(f176));
  // PTX:233 fma.rn.f32 %f39, %f25, %f20, %f180
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f39) : "f"(f25), "f"(f20), "f"(f180));
  // PTX:234 setp.leu.f32 %p5, %f1, 0f00000000
  p5 = ((isnan(((float)(f1))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f1)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:235 mov.f32 %f535, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f535) : );
  // PTX:236 mov.f32 %f536, %f535
  asm("mov.f32 %0, %1;" : "=f"(f536) : "f"(f535));
  // PTX:237 mov.f32 %f537, %f535
  asm("mov.f32 %0, %1;" : "=f"(f537) : "f"(f535));
  // PTX:238 mov.f32 %f538, %f535
  asm("mov.f32 %0, %1;" : "=f"(f538) : "f"(f535));
  // PTX:239 mov.f32 %f539, %f535
  asm("mov.f32 %0, %1;" : "=f"(f539) : "f"(f535));
  // PTX:240 mov.f32 %f540, %f535
  asm("mov.f32 %0, %1;" : "=f"(f540) : "f"(f535));
  // PTX:241 @%p5 bra $L__BB43_10
  if (p5) { goto L_BB43_10; }
  // PTX:243 ld.param.f32 %f532, [_ZN7synreal6kernel26evaluate_tetrahedron_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKfSF_fPS4_mmm_param_7]
  f532 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param7 + (0))));
  // PTX:244 ld.param.u64 %rd79, [_ZN7synreal6kernel26evaluate_tetrahedron_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PKfSF_fPS4_mmm_param_1]
  rd79 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:245 cvta.to.global.u64 %rd54, %rd79
  rd54 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd79));
  // PTX:246 mul.lo.s64 %rd55, %rd9, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd55) : "l"(rd9));
  // PTX:247 add.s64 %rd56, %rd54, %rd55
  asm("add.s64 %0, %1, %2;" : "=l"(rd56) : "l"(rd54), "l"(rd55));
  // PTX:248 mul.lo.s64 %rd57, %rd10, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd57) : "l"(rd10));
  // PTX:249 add.s64 %rd58, %rd54, %rd57
  asm("add.s64 %0, %1, %2;" : "=l"(rd58) : "l"(rd54), "l"(rd57));
  // PTX:250 ld.global.f32 %f181, [%rd58]
  f181 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (0)))));
  // PTX:251 ld.global.f32 %f182, [%rd56]
  f182 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))));
  // PTX:252 sub.f32 %f183, %f181, %f182
  asm("sub.f32 %0, %1, %2;" : "=f"(f183) : "f"(f181), "f"(f182));
  // PTX:253 ld.global.f32 %f184, [%rd58+4]
  f184 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (4)))));
  // PTX:254 ld.global.f32 %f185, [%rd56+4]
  f185 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (4)))));
  // PTX:255 sub.f32 %f186, %f184, %f185
  asm("sub.f32 %0, %1, %2;" : "=f"(f186) : "f"(f184), "f"(f185));
  // PTX:256 ld.global.f32 %f187, [%rd58+8]
  f187 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (8)))));
  // PTX:257 ld.global.f32 %f188, [%rd56+8]
  f188 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (8)))));
  // PTX:258 sub.f32 %f189, %f187, %f188
  asm("sub.f32 %0, %1, %2;" : "=f"(f189) : "f"(f187), "f"(f188));
  // PTX:259 mul.lo.s64 %rd59, %rd11, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd59) : "l"(rd11));
  // PTX:260 add.s64 %rd60, %rd54, %rd59
  asm("add.s64 %0, %1, %2;" : "=l"(rd60) : "l"(rd54), "l"(rd59));
  // PTX:261 ld.global.f32 %f190, [%rd60]
  f190 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))));
  // PTX:262 sub.f32 %f191, %f190, %f182
  asm("sub.f32 %0, %1, %2;" : "=f"(f191) : "f"(f190), "f"(f182));
  // PTX:263 ld.global.f32 %f192, [%rd60+4]
  f192 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (4)))));
  // PTX:264 sub.f32 %f193, %f192, %f185
  asm("sub.f32 %0, %1, %2;" : "=f"(f193) : "f"(f192), "f"(f185));
  // PTX:265 ld.global.f32 %f194, [%rd60+8]
  f194 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (8)))));
  // PTX:266 sub.f32 %f195, %f194, %f188
  asm("sub.f32 %0, %1, %2;" : "=f"(f195) : "f"(f194), "f"(f188));
  // PTX:267 mul.lo.s64 %rd61, %rd12, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd61) : "l"(rd12));
  // PTX:268 add.s64 %rd62, %rd54, %rd61
  asm("add.s64 %0, %1, %2;" : "=l"(rd62) : "l"(rd54), "l"(rd61));
  // PTX:269 ld.global.f32 %f196, [%rd62]
  f196 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))));
  // PTX:270 sub.f32 %f197, %f196, %f182
  asm("sub.f32 %0, %1, %2;" : "=f"(f197) : "f"(f196), "f"(f182));
  // PTX:271 ld.global.f32 %f198, [%rd62+4]
  f198 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (4)))));
  // PTX:272 sub.f32 %f199, %f198, %f185
  asm("sub.f32 %0, %1, %2;" : "=f"(f199) : "f"(f198), "f"(f185));
  // PTX:273 ld.global.f32 %f200, [%rd62+8]
  f200 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (8)))));
  // PTX:274 sub.f32 %f201, %f200, %f188
  asm("sub.f32 %0, %1, %2;" : "=f"(f201) : "f"(f200), "f"(f188));
  // PTX:275 mul.f32 %f202, %f191, %f4
  asm("mul.f32 %0, %1, %2;" : "=f"(f202) : "f"(f191), "f"(f4));
  // PTX:276 mul.f32 %f203, %f193, %f4
  asm("mul.f32 %0, %1, %2;" : "=f"(f203) : "f"(f193), "f"(f4));
  // PTX:277 mul.f32 %f204, %f195, %f4
  asm("mul.f32 %0, %1, %2;" : "=f"(f204) : "f"(f195), "f"(f4));
  // PTX:278 fma.rn.f32 %f205, %f183, %f3, %f202
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f205) : "f"(f183), "f"(f3), "f"(f202));
  // PTX:279 fma.rn.f32 %f206, %f186, %f3, %f203
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f206) : "f"(f186), "f"(f3), "f"(f203));
  // PTX:280 fma.rn.f32 %f207, %f189, %f3, %f204
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f207) : "f"(f189), "f"(f3), "f"(f204));
  // PTX:281 fma.rn.f32 %f208, %f197, %f5, %f205
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f208) : "f"(f197), "f"(f5), "f"(f205));
  // PTX:282 fma.rn.f32 %f209, %f199, %f5, %f206
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f209) : "f"(f199), "f"(f5), "f"(f206));
  // PTX:283 fma.rn.f32 %f210, %f201, %f5, %f207
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f210) : "f"(f201), "f"(f5), "f"(f207));
  // PTX:284 mul.f32 %f211, %f191, %f10
  asm("mul.f32 %0, %1, %2;" : "=f"(f211) : "f"(f191), "f"(f10));
  // PTX:285 mul.f32 %f212, %f193, %f10
  asm("mul.f32 %0, %1, %2;" : "=f"(f212) : "f"(f193), "f"(f10));
  // PTX:286 mul.f32 %f213, %f195, %f10
  asm("mul.f32 %0, %1, %2;" : "=f"(f213) : "f"(f195), "f"(f10));
  // PTX:287 fma.rn.f32 %f214, %f183, %f9, %f211
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f214) : "f"(f183), "f"(f9), "f"(f211));
  // PTX:288 fma.rn.f32 %f215, %f186, %f9, %f212
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f215) : "f"(f186), "f"(f9), "f"(f212));
  // PTX:289 fma.rn.f32 %f216, %f189, %f9, %f213
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f216) : "f"(f189), "f"(f9), "f"(f213));
  // PTX:290 fma.rn.f32 %f217, %f197, %f11, %f214
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f217) : "f"(f197), "f"(f11), "f"(f214));
  // PTX:291 fma.rn.f32 %f218, %f199, %f11, %f215
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f218) : "f"(f199), "f"(f11), "f"(f215));
  // PTX:292 fma.rn.f32 %f219, %f201, %f11, %f216
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f219) : "f"(f201), "f"(f11), "f"(f216));
  // PTX:293 mul.f32 %f220, %f191, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f220) : "f"(f191), "f"(f16));
  // PTX:294 mul.f32 %f221, %f193, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f221) : "f"(f193), "f"(f16));
  // PTX:295 mul.f32 %f222, %f195, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f222) : "f"(f195), "f"(f16));
  // PTX:296 fma.rn.f32 %f223, %f183, %f15, %f220
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f223) : "f"(f183), "f"(f15), "f"(f220));
  // PTX:297 fma.rn.f32 %f224, %f186, %f15, %f221
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f224) : "f"(f186), "f"(f15), "f"(f221));
  // PTX:298 fma.rn.f32 %f225, %f189, %f15, %f222
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f225) : "f"(f189), "f"(f15), "f"(f222));
  // PTX:299 fma.rn.f32 %f226, %f197, %f17, %f223
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f226) : "f"(f197), "f"(f17), "f"(f223));
  // PTX:300 fma.rn.f32 %f227, %f199, %f17, %f224
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f227) : "f"(f199), "f"(f17), "f"(f224));
  // PTX:301 fma.rn.f32 %f228, %f201, %f17, %f225
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f228) : "f"(f201), "f"(f17), "f"(f225));
  // PTX:302 mul.f32 %f229, %f7, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f229) : "f"(f7), "f"(f7));
  // PTX:303 fma.rn.f32 %f230, %f6, %f6, %f229
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f230) : "f"(f6), "f"(f6), "f"(f229));
  // PTX:304 fma.rn.f32 %f231, %f8, %f8, %f230
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f231) : "f"(f8), "f"(f8), "f"(f230));
  // PTX:305 mul.f32 %f232, %f209, %f209
  asm("mul.f32 %0, %1, %2;" : "=f"(f232) : "f"(f209), "f"(f209));
  // PTX:306 fma.rn.f32 %f233, %f208, %f208, %f232
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f233) : "f"(f208), "f"(f208), "f"(f232));
  // PTX:307 fma.rn.f32 %f234, %f210, %f210, %f233
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f234) : "f"(f210), "f"(f210), "f"(f233));
  // PTX:308 sub.f32 %f235, %f231, %f234
  asm("sub.f32 %0, %1, %2;" : "=f"(f235) : "f"(f231), "f"(f234));
  // PTX:309 mul.f32 %f535, %f235, %f532
  asm("mul.f32 %0, %1, %2;" : "=f"(f535) : "f"(f235), "f"(f532));
  // PTX:310 mul.f32 %f236, %f7, %f13
  asm("mul.f32 %0, %1, %2;" : "=f"(f236) : "f"(f7), "f"(f13));
  // PTX:311 fma.rn.f32 %f237, %f6, %f12, %f236
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f237) : "f"(f6), "f"(f12), "f"(f236));
  // PTX:312 fma.rn.f32 %f238, %f8, %f14, %f237
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f238) : "f"(f8), "f"(f14), "f"(f237));
  // PTX:313 mul.f32 %f239, %f209, %f218
  asm("mul.f32 %0, %1, %2;" : "=f"(f239) : "f"(f209), "f"(f218));
  // PTX:314 fma.rn.f32 %f240, %f208, %f217, %f239
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f240) : "f"(f208), "f"(f217), "f"(f239));
  // PTX:315 fma.rn.f32 %f241, %f210, %f219, %f240
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f241) : "f"(f210), "f"(f219), "f"(f240));
  // PTX:316 sub.f32 %f242, %f238, %f241
  asm("sub.f32 %0, %1, %2;" : "=f"(f242) : "f"(f238), "f"(f241));
  // PTX:317 mul.f32 %f243, %f242, %f532
  asm("mul.f32 %0, %1, %2;" : "=f"(f243) : "f"(f242), "f"(f532));
  // PTX:318 mul.f32 %f244, %f7, %f19
  asm("mul.f32 %0, %1, %2;" : "=f"(f244) : "f"(f7), "f"(f19));
  // PTX:319 fma.rn.f32 %f245, %f6, %f18, %f244
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f245) : "f"(f6), "f"(f18), "f"(f244));
  // PTX:320 fma.rn.f32 %f246, %f8, %f20, %f245
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f246) : "f"(f8), "f"(f20), "f"(f245));
  // PTX:321 mul.f32 %f247, %f209, %f227
  asm("mul.f32 %0, %1, %2;" : "=f"(f247) : "f"(f209), "f"(f227));
  // PTX:322 fma.rn.f32 %f248, %f208, %f226, %f247
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f248) : "f"(f208), "f"(f226), "f"(f247));
  // PTX:323 fma.rn.f32 %f249, %f210, %f228, %f248
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f249) : "f"(f210), "f"(f228), "f"(f248));
  // PTX:324 sub.f32 %f250, %f246, %f249
  asm("sub.f32 %0, %1, %2;" : "=f"(f250) : "f"(f246), "f"(f249));
  // PTX:325 mul.f32 %f251, %f250, %f532
  asm("mul.f32 %0, %1, %2;" : "=f"(f251) : "f"(f250), "f"(f532));
  // PTX:326 mul.f32 %f252, %f13, %f13
  asm("mul.f32 %0, %1, %2;" : "=f"(f252) : "f"(f13), "f"(f13));
  // PTX:327 fma.rn.f32 %f253, %f12, %f12, %f252
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f253) : "f"(f12), "f"(f12), "f"(f252));
  // PTX:328 fma.rn.f32 %f254, %f14, %f14, %f253
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f254) : "f"(f14), "f"(f14), "f"(f253));
  // PTX:329 mul.f32 %f255, %f218, %f218
  asm("mul.f32 %0, %1, %2;" : "=f"(f255) : "f"(f218), "f"(f218));
  // PTX:330 fma.rn.f32 %f256, %f217, %f217, %f255
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f256) : "f"(f217), "f"(f217), "f"(f255));
  // PTX:331 fma.rn.f32 %f257, %f219, %f219, %f256
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f257) : "f"(f219), "f"(f219), "f"(f256));
  // PTX:332 sub.f32 %f258, %f254, %f257
  asm("sub.f32 %0, %1, %2;" : "=f"(f258) : "f"(f254), "f"(f257));
  // PTX:333 mul.f32 %f538, %f258, %f532
  asm("mul.f32 %0, %1, %2;" : "=f"(f538) : "f"(f258), "f"(f532));
  // PTX:334 mul.f32 %f259, %f13, %f19
  asm("mul.f32 %0, %1, %2;" : "=f"(f259) : "f"(f13), "f"(f19));
  // PTX:335 fma.rn.f32 %f260, %f12, %f18, %f259
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f260) : "f"(f12), "f"(f18), "f"(f259));
  // PTX:336 fma.rn.f32 %f261, %f14, %f20, %f260
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f261) : "f"(f14), "f"(f20), "f"(f260));
  // PTX:337 mul.f32 %f262, %f218, %f227
  asm("mul.f32 %0, %1, %2;" : "=f"(f262) : "f"(f218), "f"(f227));
  // PTX:338 fma.rn.f32 %f263, %f217, %f226, %f262
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f263) : "f"(f217), "f"(f226), "f"(f262));
  // PTX:339 fma.rn.f32 %f264, %f219, %f228, %f263
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f264) : "f"(f219), "f"(f228), "f"(f263));
  // PTX:340 sub.f32 %f265, %f261, %f264
  asm("sub.f32 %0, %1, %2;" : "=f"(f265) : "f"(f261), "f"(f264));
  // PTX:341 mul.f32 %f266, %f265, %f532
  asm("mul.f32 %0, %1, %2;" : "=f"(f266) : "f"(f265), "f"(f532));
  // PTX:342 mul.f32 %f267, %f19, %f19
  asm("mul.f32 %0, %1, %2;" : "=f"(f267) : "f"(f19), "f"(f19));
  // PTX:343 fma.rn.f32 %f268, %f18, %f18, %f267
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f268) : "f"(f18), "f"(f18), "f"(f267));
  // PTX:344 fma.rn.f32 %f269, %f20, %f20, %f268
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f269) : "f"(f20), "f"(f20), "f"(f268));
  // PTX:345 mul.f32 %f270, %f227, %f227
  asm("mul.f32 %0, %1, %2;" : "=f"(f270) : "f"(f227), "f"(f227));
  // PTX:346 fma.rn.f32 %f271, %f226, %f226, %f270
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f271) : "f"(f226), "f"(f226), "f"(f270));
  // PTX:347 fma.rn.f32 %f272, %f228, %f228, %f271
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f272) : "f"(f228), "f"(f228), "f"(f271));
  // PTX:348 sub.f32 %f273, %f269, %f272
  asm("sub.f32 %0, %1, %2;" : "=f"(f273) : "f"(f269), "f"(f272));
  // PTX:349 mul.f32 %f540, %f273, %f532
  asm("mul.f32 %0, %1, %2;" : "=f"(f540) : "f"(f273), "f"(f532));
  // PTX:350 fma.rn.f32 %f536, %f242, %f532, %f243
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f536) : "f"(f242), "f"(f532), "f"(f243));
  // PTX:351 fma.rn.f32 %f537, %f250, %f532, %f251
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f537) : "f"(f250), "f"(f532), "f"(f251));
  // PTX:352 fma.rn.f32 %f539, %f265, %f532, %f266
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f539) : "f"(f265), "f"(f532), "f"(f266));
  // PTX:354 $L__BB43_10:
L_BB43_10:;
  // PTX:355 neg.f32 %f274, %f3
  asm("neg.f32 %0, %1;" : "=f"(f274) : "f"(f3));
  // PTX:356 sub.f32 %f275, %f274, %f4
  asm("sub.f32 %0, %1, %2;" : "=f"(f275) : "f"(f274), "f"(f4));
  // PTX:357 neg.f32 %f276, %f9
  asm("neg.f32 %0, %1;" : "=f"(f276) : "f"(f9));
  // PTX:358 sub.f32 %f277, %f276, %f10
  asm("sub.f32 %0, %1, %2;" : "=f"(f277) : "f"(f276), "f"(f10));
  // PTX:359 neg.f32 %f278, %f15
  asm("neg.f32 %0, %1;" : "=f"(f278) : "f"(f15));
  // PTX:360 sub.f32 %f279, %f278, %f16
  asm("sub.f32 %0, %1, %2;" : "=f"(f279) : "f"(f278), "f"(f16));
  // PTX:361 sub.f32 %f52, %f275, %f5
  asm("sub.f32 %0, %1, %2;" : "=f"(f52) : "f"(f275), "f"(f5));
  // PTX:362 sub.f32 %f53, %f277, %f11
  asm("sub.f32 %0, %1, %2;" : "=f"(f53) : "f"(f277), "f"(f11));
  // PTX:363 sub.f32 %f54, %f279, %f17
  asm("sub.f32 %0, %1, %2;" : "=f"(f54) : "f"(f279), "f"(f17));
  // PTX:364 mul.f32 %f55, %f1, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f55) : "f"(f1), "f"(f2));
  // PTX:365 mul.f32 %f280, %f34, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f280) : "f"(f34), "f"(f53));
  // PTX:366 mul.f32 %f281, %f35, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f281) : "f"(f35), "f"(f53));
  // PTX:367 mul.f32 %f282, %f36, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f282) : "f"(f36), "f"(f53));
  // PTX:368 fma.rn.f32 %f283, %f31, %f52, %f280
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f283) : "f"(f31), "f"(f52), "f"(f280));
  // PTX:369 fma.rn.f32 %f284, %f32, %f52, %f281
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f284) : "f"(f32), "f"(f52), "f"(f281));
  // PTX:370 fma.rn.f32 %f285, %f33, %f52, %f282
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f285) : "f"(f33), "f"(f52), "f"(f282));
  // PTX:371 fma.rn.f32 %f286, %f37, %f54, %f283
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f286) : "f"(f37), "f"(f54), "f"(f283));
  // PTX:372 fma.rn.f32 %f287, %f38, %f54, %f284
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f287) : "f"(f38), "f"(f54), "f"(f284));
  // PTX:373 fma.rn.f32 %f288, %f39, %f54, %f285
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f288) : "f"(f39), "f"(f54), "f"(f285));
  // PTX:374 neg.f32 %f56, %f2
  asm("neg.f32 %0, %1;" : "=f"(f56) : "f"(f2));
  // PTX:375 mul.f32 %f541, %f286, %f56
  asm("mul.f32 %0, %1, %2;" : "=f"(f541) : "f"(f286), "f"(f56));
  // PTX:376 mul.f32 %f542, %f287, %f56
  asm("mul.f32 %0, %1, %2;" : "=f"(f542) : "f"(f287), "f"(f56));
  // PTX:377 mul.f32 %f543, %f288, %f56
  asm("mul.f32 %0, %1, %2;" : "=f"(f543) : "f"(f288), "f"(f56));
  // PTX:378 @%p5 bra $L__BB43_12
  if (p5) { goto L_BB43_12; }
  // PTX:380 add.f32 %f289, %f52, %f52
  asm("add.f32 %0, %1, %2;" : "=f"(f289) : "f"(f52), "f"(f52));
  // PTX:381 mul.f32 %f290, %f6, %f289
  asm("mul.f32 %0, %1, %2;" : "=f"(f290) : "f"(f6), "f"(f289));
  // PTX:382 mul.f32 %f291, %f7, %f289
  asm("mul.f32 %0, %1, %2;" : "=f"(f291) : "f"(f7), "f"(f289));
  // PTX:383 mul.f32 %f292, %f8, %f289
  asm("mul.f32 %0, %1, %2;" : "=f"(f292) : "f"(f8), "f"(f289));
  // PTX:384 mul.f32 %f293, %f6, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f293) : "f"(f6), "f"(f53));
  // PTX:385 fma.rn.f32 %f294, %f12, %f52, %f293
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f294) : "f"(f12), "f"(f52), "f"(f293));
  // PTX:386 mul.f32 %f295, %f7, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f295) : "f"(f7), "f"(f53));
  // PTX:387 fma.rn.f32 %f296, %f13, %f52, %f295
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f296) : "f"(f13), "f"(f52), "f"(f295));
  // PTX:388 mul.f32 %f297, %f8, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f297) : "f"(f8), "f"(f53));
  // PTX:389 fma.rn.f32 %f298, %f14, %f52, %f297
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f298) : "f"(f14), "f"(f52), "f"(f297));
  // PTX:390 mul.f32 %f299, %f6, %f54
  asm("mul.f32 %0, %1, %2;" : "=f"(f299) : "f"(f6), "f"(f54));
  // PTX:391 fma.rn.f32 %f300, %f18, %f52, %f299
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f300) : "f"(f18), "f"(f52), "f"(f299));
  // PTX:392 mul.f32 %f301, %f7, %f54
  asm("mul.f32 %0, %1, %2;" : "=f"(f301) : "f"(f7), "f"(f54));
  // PTX:393 fma.rn.f32 %f302, %f19, %f52, %f301
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f302) : "f"(f19), "f"(f52), "f"(f301));
  // PTX:394 mul.f32 %f303, %f8, %f54
  asm("mul.f32 %0, %1, %2;" : "=f"(f303) : "f"(f8), "f"(f54));
  // PTX:395 fma.rn.f32 %f304, %f20, %f52, %f303
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f304) : "f"(f20), "f"(f52), "f"(f303));
  // PTX:396 add.f32 %f305, %f53, %f53
  asm("add.f32 %0, %1, %2;" : "=f"(f305) : "f"(f53), "f"(f53));
  // PTX:397 mul.f32 %f306, %f12, %f305
  asm("mul.f32 %0, %1, %2;" : "=f"(f306) : "f"(f12), "f"(f305));
  // PTX:398 mul.f32 %f307, %f13, %f305
  asm("mul.f32 %0, %1, %2;" : "=f"(f307) : "f"(f13), "f"(f305));
  // PTX:399 mul.f32 %f308, %f14, %f305
  asm("mul.f32 %0, %1, %2;" : "=f"(f308) : "f"(f14), "f"(f305));
  // PTX:400 mul.f32 %f309, %f12, %f54
  asm("mul.f32 %0, %1, %2;" : "=f"(f309) : "f"(f12), "f"(f54));
  // PTX:401 fma.rn.f32 %f310, %f18, %f53, %f309
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f310) : "f"(f18), "f"(f53), "f"(f309));
  // PTX:402 mul.f32 %f311, %f13, %f54
  asm("mul.f32 %0, %1, %2;" : "=f"(f311) : "f"(f13), "f"(f54));
  // PTX:403 fma.rn.f32 %f312, %f19, %f53, %f311
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f312) : "f"(f19), "f"(f53), "f"(f311));
  // PTX:404 mul.f32 %f313, %f14, %f54
  asm("mul.f32 %0, %1, %2;" : "=f"(f313) : "f"(f14), "f"(f54));
  // PTX:405 fma.rn.f32 %f314, %f20, %f53, %f313
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f314) : "f"(f20), "f"(f53), "f"(f313));
  // PTX:406 add.f32 %f315, %f54, %f54
  asm("add.f32 %0, %1, %2;" : "=f"(f315) : "f"(f54), "f"(f54));
  // PTX:407 mul.f32 %f316, %f18, %f315
  asm("mul.f32 %0, %1, %2;" : "=f"(f316) : "f"(f18), "f"(f315));
  // PTX:408 mul.f32 %f317, %f19, %f315
  asm("mul.f32 %0, %1, %2;" : "=f"(f317) : "f"(f19), "f"(f315));
  // PTX:409 mul.f32 %f318, %f20, %f315
  asm("mul.f32 %0, %1, %2;" : "=f"(f318) : "f"(f20), "f"(f315));
  // PTX:410 mul.f32 %f319, %f536, %f294
  asm("mul.f32 %0, %1, %2;" : "=f"(f319) : "f"(f536), "f"(f294));
  // PTX:411 mul.f32 %f320, %f536, %f296
  asm("mul.f32 %0, %1, %2;" : "=f"(f320) : "f"(f536), "f"(f296));
  // PTX:412 mul.f32 %f321, %f536, %f298
  asm("mul.f32 %0, %1, %2;" : "=f"(f321) : "f"(f536), "f"(f298));
  // PTX:413 fma.rn.f32 %f322, %f535, %f290, %f319
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f322) : "f"(f535), "f"(f290), "f"(f319));
  // PTX:414 fma.rn.f32 %f323, %f535, %f291, %f320
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f323) : "f"(f535), "f"(f291), "f"(f320));
  // PTX:415 fma.rn.f32 %f324, %f535, %f292, %f321
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f324) : "f"(f535), "f"(f292), "f"(f321));
  // PTX:416 fma.rn.f32 %f325, %f537, %f300, %f322
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f325) : "f"(f537), "f"(f300), "f"(f322));
  // PTX:417 fma.rn.f32 %f326, %f537, %f302, %f323
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f326) : "f"(f537), "f"(f302), "f"(f323));
  // PTX:418 fma.rn.f32 %f327, %f537, %f304, %f324
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f327) : "f"(f537), "f"(f304), "f"(f324));
  // PTX:419 fma.rn.f32 %f328, %f538, %f306, %f325
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f328) : "f"(f538), "f"(f306), "f"(f325));
  // PTX:420 fma.rn.f32 %f329, %f538, %f307, %f326
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f329) : "f"(f538), "f"(f307), "f"(f326));
  // PTX:421 fma.rn.f32 %f330, %f538, %f308, %f327
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f330) : "f"(f538), "f"(f308), "f"(f327));
  // PTX:422 fma.rn.f32 %f331, %f539, %f310, %f328
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f331) : "f"(f539), "f"(f310), "f"(f328));
  // PTX:423 fma.rn.f32 %f332, %f539, %f312, %f329
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f332) : "f"(f539), "f"(f312), "f"(f329));
  // PTX:424 fma.rn.f32 %f333, %f539, %f314, %f330
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f333) : "f"(f539), "f"(f314), "f"(f330));
  // PTX:425 fma.rn.f32 %f334, %f540, %f316, %f331
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f334) : "f"(f540), "f"(f316), "f"(f331));
  // PTX:426 fma.rn.f32 %f335, %f540, %f317, %f332
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f335) : "f"(f540), "f"(f317), "f"(f332));
  // PTX:427 fma.rn.f32 %f336, %f540, %f318, %f333
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f336) : "f"(f540), "f"(f318), "f"(f333));
  // PTX:428 mul.f32 %f337, %f55, %f334
  asm("mul.f32 %0, %1, %2;" : "=f"(f337) : "f"(f55), "f"(f334));
  // PTX:429 mul.f32 %f338, %f55, %f335
  asm("mul.f32 %0, %1, %2;" : "=f"(f338) : "f"(f55), "f"(f335));
  // PTX:430 mul.f32 %f339, %f55, %f336
  asm("mul.f32 %0, %1, %2;" : "=f"(f339) : "f"(f55), "f"(f336));
  // PTX:431 sub.f32 %f541, %f541, %f337
  asm("sub.f32 %0, %1, %2;" : "=f"(f541) : "f"(f541), "f"(f337));
  // PTX:432 sub.f32 %f542, %f542, %f338
  asm("sub.f32 %0, %1, %2;" : "=f"(f542) : "f"(f542), "f"(f338));
  // PTX:433 sub.f32 %f543, %f543, %f339
  asm("sub.f32 %0, %1, %2;" : "=f"(f543) : "f"(f543), "f"(f339));
  // PTX:435 $L__BB43_12:
L_BB43_12:;
  // PTX:436 mul.lo.s64 %rd63, %rd9, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd63) : "l"(rd9));
  // PTX:437 add.s64 %rd64, %rd1, %rd63
  asm("add.s64 %0, %1, %2;" : "=l"(rd64) : "l"(rd1), "l"(rd63));
  // PTX:438 red.global.add.f32 [%rd64], %f541
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (0)))), (float)(f541));
  // PTX:439 add.s64 %rd65, %rd64, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd65) : "l"(rd64));
  // PTX:440 red.global.add.f32 [%rd65], %f542
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (0)))), (float)(f542));
  // PTX:441 add.s64 %rd66, %rd64, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd66) : "l"(rd64));
  // PTX:442 red.global.add.f32 [%rd66], %f543
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (0)))), (float)(f543));
  // PTX:443 mul.f32 %f343, %f34, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f343) : "f"(f34), "f"(f9));
  // PTX:444 fma.rn.f32 %f344, %f31, %f3, %f343
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f344) : "f"(f31), "f"(f3), "f"(f343));
  // PTX:445 mul.f32 %f345, %f35, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f345) : "f"(f35), "f"(f9));
  // PTX:446 fma.rn.f32 %f346, %f32, %f3, %f345
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f346) : "f"(f32), "f"(f3), "f"(f345));
  // PTX:447 mul.f32 %f347, %f36, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f347) : "f"(f36), "f"(f9));
  // PTX:448 fma.rn.f32 %f348, %f33, %f3, %f347
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f348) : "f"(f33), "f"(f3), "f"(f347));
  // PTX:449 fma.rn.f32 %f349, %f37, %f15, %f344
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f349) : "f"(f37), "f"(f15), "f"(f344));
  // PTX:450 fma.rn.f32 %f350, %f38, %f15, %f346
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f350) : "f"(f38), "f"(f15), "f"(f346));
  // PTX:451 fma.rn.f32 %f351, %f39, %f15, %f348
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f351) : "f"(f39), "f"(f15), "f"(f348));
  // PTX:452 mul.f32 %f544, %f349, %f56
  asm("mul.f32 %0, %1, %2;" : "=f"(f544) : "f"(f349), "f"(f56));
  // PTX:453 mul.f32 %f545, %f350, %f56
  asm("mul.f32 %0, %1, %2;" : "=f"(f545) : "f"(f350), "f"(f56));
  // PTX:454 mul.f32 %f546, %f351, %f56
  asm("mul.f32 %0, %1, %2;" : "=f"(f546) : "f"(f351), "f"(f56));
  // PTX:455 @%p5 bra $L__BB43_14
  if (p5) { goto L_BB43_14; }
  // PTX:457 add.f32 %f352, %f3, %f3
  asm("add.f32 %0, %1, %2;" : "=f"(f352) : "f"(f3), "f"(f3));
  // PTX:458 mul.f32 %f353, %f6, %f352
  asm("mul.f32 %0, %1, %2;" : "=f"(f353) : "f"(f6), "f"(f352));
  // PTX:459 mul.f32 %f354, %f7, %f352
  asm("mul.f32 %0, %1, %2;" : "=f"(f354) : "f"(f7), "f"(f352));
  // PTX:460 mul.f32 %f355, %f8, %f352
  asm("mul.f32 %0, %1, %2;" : "=f"(f355) : "f"(f8), "f"(f352));
  // PTX:461 mul.f32 %f356, %f6, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f356) : "f"(f6), "f"(f9));
  // PTX:462 fma.rn.f32 %f357, %f12, %f3, %f356
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f357) : "f"(f12), "f"(f3), "f"(f356));
  // PTX:463 mul.f32 %f358, %f7, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f358) : "f"(f7), "f"(f9));
  // PTX:464 fma.rn.f32 %f359, %f13, %f3, %f358
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f359) : "f"(f13), "f"(f3), "f"(f358));
  // PTX:465 mul.f32 %f360, %f8, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f360) : "f"(f8), "f"(f9));
  // PTX:466 fma.rn.f32 %f361, %f14, %f3, %f360
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f361) : "f"(f14), "f"(f3), "f"(f360));
  // PTX:467 mul.f32 %f362, %f6, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f362) : "f"(f6), "f"(f15));
  // PTX:468 fma.rn.f32 %f363, %f18, %f3, %f362
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f363) : "f"(f18), "f"(f3), "f"(f362));
  // PTX:469 mul.f32 %f364, %f7, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f364) : "f"(f7), "f"(f15));
  // PTX:470 fma.rn.f32 %f365, %f19, %f3, %f364
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f365) : "f"(f19), "f"(f3), "f"(f364));
  // PTX:471 mul.f32 %f366, %f8, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f366) : "f"(f8), "f"(f15));
  // PTX:472 fma.rn.f32 %f367, %f20, %f3, %f366
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f367) : "f"(f20), "f"(f3), "f"(f366));
  // PTX:473 add.f32 %f368, %f9, %f9
  asm("add.f32 %0, %1, %2;" : "=f"(f368) : "f"(f9), "f"(f9));
  // PTX:474 mul.f32 %f369, %f12, %f368
  asm("mul.f32 %0, %1, %2;" : "=f"(f369) : "f"(f12), "f"(f368));
  // PTX:475 mul.f32 %f370, %f13, %f368
  asm("mul.f32 %0, %1, %2;" : "=f"(f370) : "f"(f13), "f"(f368));
  // PTX:476 mul.f32 %f371, %f14, %f368
  asm("mul.f32 %0, %1, %2;" : "=f"(f371) : "f"(f14), "f"(f368));
  // PTX:477 mul.f32 %f372, %f12, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f372) : "f"(f12), "f"(f15));
  // PTX:478 fma.rn.f32 %f373, %f18, %f9, %f372
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f373) : "f"(f18), "f"(f9), "f"(f372));
  // PTX:479 mul.f32 %f374, %f13, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f374) : "f"(f13), "f"(f15));
  // PTX:480 fma.rn.f32 %f375, %f19, %f9, %f374
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f375) : "f"(f19), "f"(f9), "f"(f374));
  // PTX:481 mul.f32 %f376, %f14, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f376) : "f"(f14), "f"(f15));
  // PTX:482 fma.rn.f32 %f377, %f20, %f9, %f376
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f377) : "f"(f20), "f"(f9), "f"(f376));
  // PTX:483 add.f32 %f378, %f15, %f15
  asm("add.f32 %0, %1, %2;" : "=f"(f378) : "f"(f15), "f"(f15));
  // PTX:484 mul.f32 %f379, %f18, %f378
  asm("mul.f32 %0, %1, %2;" : "=f"(f379) : "f"(f18), "f"(f378));
  // PTX:485 mul.f32 %f380, %f19, %f378
  asm("mul.f32 %0, %1, %2;" : "=f"(f380) : "f"(f19), "f"(f378));
  // PTX:486 mul.f32 %f381, %f20, %f378
  asm("mul.f32 %0, %1, %2;" : "=f"(f381) : "f"(f20), "f"(f378));
  // PTX:487 mul.f32 %f382, %f536, %f357
  asm("mul.f32 %0, %1, %2;" : "=f"(f382) : "f"(f536), "f"(f357));
  // PTX:488 mul.f32 %f383, %f536, %f359
  asm("mul.f32 %0, %1, %2;" : "=f"(f383) : "f"(f536), "f"(f359));
  // PTX:489 mul.f32 %f384, %f536, %f361
  asm("mul.f32 %0, %1, %2;" : "=f"(f384) : "f"(f536), "f"(f361));
  // PTX:490 fma.rn.f32 %f385, %f535, %f353, %f382
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f385) : "f"(f535), "f"(f353), "f"(f382));
  // PTX:491 fma.rn.f32 %f386, %f535, %f354, %f383
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f386) : "f"(f535), "f"(f354), "f"(f383));
  // PTX:492 fma.rn.f32 %f387, %f535, %f355, %f384
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f387) : "f"(f535), "f"(f355), "f"(f384));
  // PTX:493 fma.rn.f32 %f388, %f537, %f363, %f385
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f388) : "f"(f537), "f"(f363), "f"(f385));
  // PTX:494 fma.rn.f32 %f389, %f537, %f365, %f386
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f389) : "f"(f537), "f"(f365), "f"(f386));
  // PTX:495 fma.rn.f32 %f390, %f537, %f367, %f387
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f390) : "f"(f537), "f"(f367), "f"(f387));
  // PTX:496 fma.rn.f32 %f391, %f538, %f369, %f388
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f391) : "f"(f538), "f"(f369), "f"(f388));
  // PTX:497 fma.rn.f32 %f392, %f538, %f370, %f389
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f392) : "f"(f538), "f"(f370), "f"(f389));
  // PTX:498 fma.rn.f32 %f393, %f538, %f371, %f390
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f393) : "f"(f538), "f"(f371), "f"(f390));
  // PTX:499 fma.rn.f32 %f394, %f539, %f373, %f391
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f394) : "f"(f539), "f"(f373), "f"(f391));
  // PTX:500 fma.rn.f32 %f395, %f539, %f375, %f392
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f395) : "f"(f539), "f"(f375), "f"(f392));
  // PTX:501 fma.rn.f32 %f396, %f539, %f377, %f393
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f396) : "f"(f539), "f"(f377), "f"(f393));
  // PTX:502 fma.rn.f32 %f397, %f540, %f379, %f394
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f397) : "f"(f540), "f"(f379), "f"(f394));
  // PTX:503 fma.rn.f32 %f398, %f540, %f380, %f395
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f398) : "f"(f540), "f"(f380), "f"(f395));
  // PTX:504 fma.rn.f32 %f399, %f540, %f381, %f396
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f399) : "f"(f540), "f"(f381), "f"(f396));
  // PTX:505 mul.f32 %f400, %f55, %f397
  asm("mul.f32 %0, %1, %2;" : "=f"(f400) : "f"(f55), "f"(f397));
  // PTX:506 mul.f32 %f401, %f55, %f398
  asm("mul.f32 %0, %1, %2;" : "=f"(f401) : "f"(f55), "f"(f398));
  // PTX:507 mul.f32 %f402, %f55, %f399
  asm("mul.f32 %0, %1, %2;" : "=f"(f402) : "f"(f55), "f"(f399));
  // PTX:508 sub.f32 %f544, %f544, %f400
  asm("sub.f32 %0, %1, %2;" : "=f"(f544) : "f"(f544), "f"(f400));
  // PTX:509 sub.f32 %f545, %f545, %f401
  asm("sub.f32 %0, %1, %2;" : "=f"(f545) : "f"(f545), "f"(f401));
  // PTX:510 sub.f32 %f546, %f546, %f402
  asm("sub.f32 %0, %1, %2;" : "=f"(f546) : "f"(f546), "f"(f402));
  // PTX:512 $L__BB43_14:
L_BB43_14:;
  // PTX:513 mul.lo.s64 %rd67, %rd10, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd67) : "l"(rd10));
  // PTX:514 add.s64 %rd68, %rd1, %rd67
  asm("add.s64 %0, %1, %2;" : "=l"(rd68) : "l"(rd1), "l"(rd67));
  // PTX:515 red.global.add.f32 [%rd68], %f544
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (0)))), (float)(f544));
  // PTX:516 add.s64 %rd69, %rd68, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd69) : "l"(rd68));
  // PTX:517 red.global.add.f32 [%rd69], %f545
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (0)))), (float)(f545));
  // PTX:518 add.s64 %rd70, %rd68, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd70) : "l"(rd68));
  // PTX:519 red.global.add.f32 [%rd70], %f546
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0)))), (float)(f546));
  // PTX:520 mul.f32 %f406, %f34, %f10
  asm("mul.f32 %0, %1, %2;" : "=f"(f406) : "f"(f34), "f"(f10));
  // PTX:521 fma.rn.f32 %f407, %f31, %f4, %f406
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f407) : "f"(f31), "f"(f4), "f"(f406));
  // PTX:522 mul.f32 %f408, %f35, %f10
  asm("mul.f32 %0, %1, %2;" : "=f"(f408) : "f"(f35), "f"(f10));
  // PTX:523 fma.rn.f32 %f409, %f32, %f4, %f408
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f409) : "f"(f32), "f"(f4), "f"(f408));
  // PTX:524 mul.f32 %f410, %f36, %f10
  asm("mul.f32 %0, %1, %2;" : "=f"(f410) : "f"(f36), "f"(f10));
  // PTX:525 fma.rn.f32 %f411, %f33, %f4, %f410
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f411) : "f"(f33), "f"(f4), "f"(f410));
  // PTX:526 fma.rn.f32 %f412, %f37, %f16, %f407
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f412) : "f"(f37), "f"(f16), "f"(f407));
  // PTX:527 fma.rn.f32 %f413, %f38, %f16, %f409
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f413) : "f"(f38), "f"(f16), "f"(f409));
  // PTX:528 fma.rn.f32 %f414, %f39, %f16, %f411
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f414) : "f"(f39), "f"(f16), "f"(f411));
  // PTX:529 mul.f32 %f547, %f412, %f56
  asm("mul.f32 %0, %1, %2;" : "=f"(f547) : "f"(f412), "f"(f56));
  // PTX:530 mul.f32 %f548, %f413, %f56
  asm("mul.f32 %0, %1, %2;" : "=f"(f548) : "f"(f413), "f"(f56));
  // PTX:531 mul.f32 %f549, %f414, %f56
  asm("mul.f32 %0, %1, %2;" : "=f"(f549) : "f"(f414), "f"(f56));
  // PTX:532 @%p5 bra $L__BB43_16
  if (p5) { goto L_BB43_16; }
  // PTX:534 add.f32 %f415, %f4, %f4
  asm("add.f32 %0, %1, %2;" : "=f"(f415) : "f"(f4), "f"(f4));
  // PTX:535 mul.f32 %f416, %f6, %f415
  asm("mul.f32 %0, %1, %2;" : "=f"(f416) : "f"(f6), "f"(f415));
  // PTX:536 mul.f32 %f417, %f7, %f415
  asm("mul.f32 %0, %1, %2;" : "=f"(f417) : "f"(f7), "f"(f415));
  // PTX:537 mul.f32 %f418, %f8, %f415
  asm("mul.f32 %0, %1, %2;" : "=f"(f418) : "f"(f8), "f"(f415));
  // PTX:538 mul.f32 %f419, %f6, %f10
  asm("mul.f32 %0, %1, %2;" : "=f"(f419) : "f"(f6), "f"(f10));
  // PTX:539 fma.rn.f32 %f420, %f12, %f4, %f419
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f420) : "f"(f12), "f"(f4), "f"(f419));
  // PTX:540 mul.f32 %f421, %f7, %f10
  asm("mul.f32 %0, %1, %2;" : "=f"(f421) : "f"(f7), "f"(f10));
  // PTX:541 fma.rn.f32 %f422, %f13, %f4, %f421
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f422) : "f"(f13), "f"(f4), "f"(f421));
  // PTX:542 mul.f32 %f423, %f8, %f10
  asm("mul.f32 %0, %1, %2;" : "=f"(f423) : "f"(f8), "f"(f10));
  // PTX:543 fma.rn.f32 %f424, %f14, %f4, %f423
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f424) : "f"(f14), "f"(f4), "f"(f423));
  // PTX:544 mul.f32 %f425, %f6, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f425) : "f"(f6), "f"(f16));
  // PTX:545 fma.rn.f32 %f426, %f18, %f4, %f425
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f426) : "f"(f18), "f"(f4), "f"(f425));
  // PTX:546 mul.f32 %f427, %f7, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f427) : "f"(f7), "f"(f16));
  // PTX:547 fma.rn.f32 %f428, %f19, %f4, %f427
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f428) : "f"(f19), "f"(f4), "f"(f427));
  // PTX:548 mul.f32 %f429, %f8, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f429) : "f"(f8), "f"(f16));
  // PTX:549 fma.rn.f32 %f430, %f20, %f4, %f429
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f430) : "f"(f20), "f"(f4), "f"(f429));
  // PTX:550 add.f32 %f431, %f10, %f10
  asm("add.f32 %0, %1, %2;" : "=f"(f431) : "f"(f10), "f"(f10));
  // PTX:551 mul.f32 %f432, %f12, %f431
  asm("mul.f32 %0, %1, %2;" : "=f"(f432) : "f"(f12), "f"(f431));
  // PTX:552 mul.f32 %f433, %f13, %f431
  asm("mul.f32 %0, %1, %2;" : "=f"(f433) : "f"(f13), "f"(f431));
  // PTX:553 mul.f32 %f434, %f14, %f431
  asm("mul.f32 %0, %1, %2;" : "=f"(f434) : "f"(f14), "f"(f431));
  // PTX:554 mul.f32 %f435, %f12, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f435) : "f"(f12), "f"(f16));
  // PTX:555 fma.rn.f32 %f436, %f18, %f10, %f435
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f436) : "f"(f18), "f"(f10), "f"(f435));
  // PTX:556 mul.f32 %f437, %f13, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f437) : "f"(f13), "f"(f16));
  // PTX:557 fma.rn.f32 %f438, %f19, %f10, %f437
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f438) : "f"(f19), "f"(f10), "f"(f437));
  // PTX:558 mul.f32 %f439, %f14, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f439) : "f"(f14), "f"(f16));
  // PTX:559 fma.rn.f32 %f440, %f20, %f10, %f439
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f440) : "f"(f20), "f"(f10), "f"(f439));
  // PTX:560 add.f32 %f441, %f16, %f16
  asm("add.f32 %0, %1, %2;" : "=f"(f441) : "f"(f16), "f"(f16));
  // PTX:561 mul.f32 %f442, %f18, %f441
  asm("mul.f32 %0, %1, %2;" : "=f"(f442) : "f"(f18), "f"(f441));
  // PTX:562 mul.f32 %f443, %f19, %f441
  asm("mul.f32 %0, %1, %2;" : "=f"(f443) : "f"(f19), "f"(f441));
  // PTX:563 mul.f32 %f444, %f20, %f441
  asm("mul.f32 %0, %1, %2;" : "=f"(f444) : "f"(f20), "f"(f441));
  // PTX:564 mul.f32 %f445, %f536, %f420
  asm("mul.f32 %0, %1, %2;" : "=f"(f445) : "f"(f536), "f"(f420));
  // PTX:565 mul.f32 %f446, %f536, %f422
  asm("mul.f32 %0, %1, %2;" : "=f"(f446) : "f"(f536), "f"(f422));
  // PTX:566 mul.f32 %f447, %f536, %f424
  asm("mul.f32 %0, %1, %2;" : "=f"(f447) : "f"(f536), "f"(f424));
  // PTX:567 fma.rn.f32 %f448, %f535, %f416, %f445
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f448) : "f"(f535), "f"(f416), "f"(f445));
  // PTX:568 fma.rn.f32 %f449, %f535, %f417, %f446
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f449) : "f"(f535), "f"(f417), "f"(f446));
  // PTX:569 fma.rn.f32 %f450, %f535, %f418, %f447
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f450) : "f"(f535), "f"(f418), "f"(f447));
  // PTX:570 fma.rn.f32 %f451, %f537, %f426, %f448
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f451) : "f"(f537), "f"(f426), "f"(f448));
  // PTX:571 fma.rn.f32 %f452, %f537, %f428, %f449
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f452) : "f"(f537), "f"(f428), "f"(f449));
  // PTX:572 fma.rn.f32 %f453, %f537, %f430, %f450
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f453) : "f"(f537), "f"(f430), "f"(f450));
  // PTX:573 fma.rn.f32 %f454, %f538, %f432, %f451
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f454) : "f"(f538), "f"(f432), "f"(f451));
  // PTX:574 fma.rn.f32 %f455, %f538, %f433, %f452
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f455) : "f"(f538), "f"(f433), "f"(f452));
  // PTX:575 fma.rn.f32 %f456, %f538, %f434, %f453
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f456) : "f"(f538), "f"(f434), "f"(f453));
  // PTX:576 fma.rn.f32 %f457, %f539, %f436, %f454
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f457) : "f"(f539), "f"(f436), "f"(f454));
  // PTX:577 fma.rn.f32 %f458, %f539, %f438, %f455
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f458) : "f"(f539), "f"(f438), "f"(f455));
  // PTX:578 fma.rn.f32 %f459, %f539, %f440, %f456
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f459) : "f"(f539), "f"(f440), "f"(f456));
  // PTX:579 fma.rn.f32 %f460, %f540, %f442, %f457
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f460) : "f"(f540), "f"(f442), "f"(f457));
  // PTX:580 fma.rn.f32 %f461, %f540, %f443, %f458
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f461) : "f"(f540), "f"(f443), "f"(f458));
  // PTX:581 fma.rn.f32 %f462, %f540, %f444, %f459
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f462) : "f"(f540), "f"(f444), "f"(f459));
  // PTX:582 mul.f32 %f463, %f55, %f460
  asm("mul.f32 %0, %1, %2;" : "=f"(f463) : "f"(f55), "f"(f460));
  // PTX:583 mul.f32 %f464, %f55, %f461
  asm("mul.f32 %0, %1, %2;" : "=f"(f464) : "f"(f55), "f"(f461));
  // PTX:584 mul.f32 %f465, %f55, %f462
  asm("mul.f32 %0, %1, %2;" : "=f"(f465) : "f"(f55), "f"(f462));
  // PTX:585 sub.f32 %f547, %f547, %f463
  asm("sub.f32 %0, %1, %2;" : "=f"(f547) : "f"(f547), "f"(f463));
  // PTX:586 sub.f32 %f548, %f548, %f464
  asm("sub.f32 %0, %1, %2;" : "=f"(f548) : "f"(f548), "f"(f464));
  // PTX:587 sub.f32 %f549, %f549, %f465
  asm("sub.f32 %0, %1, %2;" : "=f"(f549) : "f"(f549), "f"(f465));
  // PTX:589 $L__BB43_16:
L_BB43_16:;
  // PTX:590 mul.lo.s64 %rd71, %rd11, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd71) : "l"(rd11));
  // PTX:591 add.s64 %rd72, %rd1, %rd71
  asm("add.s64 %0, %1, %2;" : "=l"(rd72) : "l"(rd1), "l"(rd71));
  // PTX:592 red.global.add.f32 [%rd72], %f547
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (0)))), (float)(f547));
  // PTX:593 add.s64 %rd73, %rd72, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd73) : "l"(rd72));
  // PTX:594 red.global.add.f32 [%rd73], %f548
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (0)))), (float)(f548));
  // PTX:595 add.s64 %rd74, %rd72, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd74) : "l"(rd72));
  // PTX:596 red.global.add.f32 [%rd74], %f549
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (0)))), (float)(f549));
  // PTX:597 mul.f32 %f469, %f34, %f11
  asm("mul.f32 %0, %1, %2;" : "=f"(f469) : "f"(f34), "f"(f11));
  // PTX:598 fma.rn.f32 %f470, %f31, %f5, %f469
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f470) : "f"(f31), "f"(f5), "f"(f469));
  // PTX:599 mul.f32 %f471, %f35, %f11
  asm("mul.f32 %0, %1, %2;" : "=f"(f471) : "f"(f35), "f"(f11));
  // PTX:600 fma.rn.f32 %f472, %f32, %f5, %f471
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f472) : "f"(f32), "f"(f5), "f"(f471));
  // PTX:601 mul.f32 %f473, %f36, %f11
  asm("mul.f32 %0, %1, %2;" : "=f"(f473) : "f"(f36), "f"(f11));
  // PTX:602 fma.rn.f32 %f474, %f33, %f5, %f473
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f474) : "f"(f33), "f"(f5), "f"(f473));
  // PTX:603 fma.rn.f32 %f475, %f37, %f17, %f470
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f475) : "f"(f37), "f"(f17), "f"(f470));
  // PTX:604 fma.rn.f32 %f476, %f38, %f17, %f472
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f476) : "f"(f38), "f"(f17), "f"(f472));
  // PTX:605 fma.rn.f32 %f477, %f39, %f17, %f474
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f477) : "f"(f39), "f"(f17), "f"(f474));
  // PTX:606 mul.f32 %f550, %f475, %f56
  asm("mul.f32 %0, %1, %2;" : "=f"(f550) : "f"(f475), "f"(f56));
  // PTX:607 mul.f32 %f551, %f476, %f56
  asm("mul.f32 %0, %1, %2;" : "=f"(f551) : "f"(f476), "f"(f56));
  // PTX:608 mul.f32 %f552, %f477, %f56
  asm("mul.f32 %0, %1, %2;" : "=f"(f552) : "f"(f477), "f"(f56));
  // PTX:609 @%p5 bra $L__BB43_18
  if (p5) { goto L_BB43_18; }
  // PTX:611 add.f32 %f478, %f5, %f5
  asm("add.f32 %0, %1, %2;" : "=f"(f478) : "f"(f5), "f"(f5));
  // PTX:612 mul.f32 %f479, %f6, %f478
  asm("mul.f32 %0, %1, %2;" : "=f"(f479) : "f"(f6), "f"(f478));
  // PTX:613 mul.f32 %f480, %f7, %f478
  asm("mul.f32 %0, %1, %2;" : "=f"(f480) : "f"(f7), "f"(f478));
  // PTX:614 mul.f32 %f481, %f8, %f478
  asm("mul.f32 %0, %1, %2;" : "=f"(f481) : "f"(f8), "f"(f478));
  // PTX:615 mul.f32 %f482, %f6, %f11
  asm("mul.f32 %0, %1, %2;" : "=f"(f482) : "f"(f6), "f"(f11));
  // PTX:616 fma.rn.f32 %f483, %f12, %f5, %f482
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f483) : "f"(f12), "f"(f5), "f"(f482));
  // PTX:617 mul.f32 %f484, %f7, %f11
  asm("mul.f32 %0, %1, %2;" : "=f"(f484) : "f"(f7), "f"(f11));
  // PTX:618 fma.rn.f32 %f485, %f13, %f5, %f484
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f485) : "f"(f13), "f"(f5), "f"(f484));
  // PTX:619 mul.f32 %f486, %f8, %f11
  asm("mul.f32 %0, %1, %2;" : "=f"(f486) : "f"(f8), "f"(f11));
  // PTX:620 fma.rn.f32 %f487, %f14, %f5, %f486
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f487) : "f"(f14), "f"(f5), "f"(f486));
  // PTX:621 mul.f32 %f488, %f6, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f488) : "f"(f6), "f"(f17));
  // PTX:622 fma.rn.f32 %f489, %f18, %f5, %f488
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f489) : "f"(f18), "f"(f5), "f"(f488));
  // PTX:623 mul.f32 %f490, %f7, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f490) : "f"(f7), "f"(f17));
  // PTX:624 fma.rn.f32 %f491, %f19, %f5, %f490
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f491) : "f"(f19), "f"(f5), "f"(f490));
  // PTX:625 mul.f32 %f492, %f8, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f492) : "f"(f8), "f"(f17));
  // PTX:626 fma.rn.f32 %f493, %f20, %f5, %f492
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f493) : "f"(f20), "f"(f5), "f"(f492));
  // PTX:627 add.f32 %f494, %f11, %f11
  asm("add.f32 %0, %1, %2;" : "=f"(f494) : "f"(f11), "f"(f11));
  // PTX:628 mul.f32 %f495, %f12, %f494
  asm("mul.f32 %0, %1, %2;" : "=f"(f495) : "f"(f12), "f"(f494));
  // PTX:629 mul.f32 %f496, %f13, %f494
  asm("mul.f32 %0, %1, %2;" : "=f"(f496) : "f"(f13), "f"(f494));
  // PTX:630 mul.f32 %f497, %f14, %f494
  asm("mul.f32 %0, %1, %2;" : "=f"(f497) : "f"(f14), "f"(f494));
  // PTX:631 mul.f32 %f498, %f12, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f498) : "f"(f12), "f"(f17));
  // PTX:632 fma.rn.f32 %f499, %f18, %f11, %f498
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f499) : "f"(f18), "f"(f11), "f"(f498));
  // PTX:633 mul.f32 %f500, %f13, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f500) : "f"(f13), "f"(f17));
  // PTX:634 fma.rn.f32 %f501, %f19, %f11, %f500
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f501) : "f"(f19), "f"(f11), "f"(f500));
  // PTX:635 mul.f32 %f502, %f14, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f502) : "f"(f14), "f"(f17));
  // PTX:636 fma.rn.f32 %f503, %f20, %f11, %f502
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f503) : "f"(f20), "f"(f11), "f"(f502));
  // PTX:637 add.f32 %f504, %f17, %f17
  asm("add.f32 %0, %1, %2;" : "=f"(f504) : "f"(f17), "f"(f17));
  // PTX:638 mul.f32 %f505, %f18, %f504
  asm("mul.f32 %0, %1, %2;" : "=f"(f505) : "f"(f18), "f"(f504));
  // PTX:639 mul.f32 %f506, %f19, %f504
  asm("mul.f32 %0, %1, %2;" : "=f"(f506) : "f"(f19), "f"(f504));
  // PTX:640 mul.f32 %f507, %f20, %f504
  asm("mul.f32 %0, %1, %2;" : "=f"(f507) : "f"(f20), "f"(f504));
  // PTX:641 mul.f32 %f508, %f536, %f483
  asm("mul.f32 %0, %1, %2;" : "=f"(f508) : "f"(f536), "f"(f483));
  // PTX:642 mul.f32 %f509, %f536, %f485
  asm("mul.f32 %0, %1, %2;" : "=f"(f509) : "f"(f536), "f"(f485));
  // PTX:643 mul.f32 %f510, %f536, %f487
  asm("mul.f32 %0, %1, %2;" : "=f"(f510) : "f"(f536), "f"(f487));
  // PTX:644 fma.rn.f32 %f511, %f535, %f479, %f508
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f511) : "f"(f535), "f"(f479), "f"(f508));
  // PTX:645 fma.rn.f32 %f512, %f535, %f480, %f509
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f512) : "f"(f535), "f"(f480), "f"(f509));
  // PTX:646 fma.rn.f32 %f513, %f535, %f481, %f510
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f513) : "f"(f535), "f"(f481), "f"(f510));
  // PTX:647 fma.rn.f32 %f514, %f537, %f489, %f511
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f514) : "f"(f537), "f"(f489), "f"(f511));
  // PTX:648 fma.rn.f32 %f515, %f537, %f491, %f512
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f515) : "f"(f537), "f"(f491), "f"(f512));
  // PTX:649 fma.rn.f32 %f516, %f537, %f493, %f513
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f516) : "f"(f537), "f"(f493), "f"(f513));
  // PTX:650 fma.rn.f32 %f517, %f538, %f495, %f514
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f517) : "f"(f538), "f"(f495), "f"(f514));
  // PTX:651 fma.rn.f32 %f518, %f538, %f496, %f515
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f518) : "f"(f538), "f"(f496), "f"(f515));
  // PTX:652 fma.rn.f32 %f519, %f538, %f497, %f516
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f519) : "f"(f538), "f"(f497), "f"(f516));
  // PTX:653 fma.rn.f32 %f520, %f539, %f499, %f517
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f520) : "f"(f539), "f"(f499), "f"(f517));
  // PTX:654 fma.rn.f32 %f521, %f539, %f501, %f518
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f521) : "f"(f539), "f"(f501), "f"(f518));
  // PTX:655 fma.rn.f32 %f522, %f539, %f503, %f519
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f522) : "f"(f539), "f"(f503), "f"(f519));
  // PTX:656 fma.rn.f32 %f523, %f540, %f505, %f520
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f523) : "f"(f540), "f"(f505), "f"(f520));
  // PTX:657 fma.rn.f32 %f524, %f540, %f506, %f521
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f524) : "f"(f540), "f"(f506), "f"(f521));
  // PTX:658 fma.rn.f32 %f525, %f540, %f507, %f522
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f525) : "f"(f540), "f"(f507), "f"(f522));
  // PTX:659 mul.f32 %f526, %f55, %f523
  asm("mul.f32 %0, %1, %2;" : "=f"(f526) : "f"(f55), "f"(f523));
  // PTX:660 mul.f32 %f527, %f55, %f524
  asm("mul.f32 %0, %1, %2;" : "=f"(f527) : "f"(f55), "f"(f524));
  // PTX:661 mul.f32 %f528, %f55, %f525
  asm("mul.f32 %0, %1, %2;" : "=f"(f528) : "f"(f55), "f"(f525));
  // PTX:662 sub.f32 %f550, %f550, %f526
  asm("sub.f32 %0, %1, %2;" : "=f"(f550) : "f"(f550), "f"(f526));
  // PTX:663 sub.f32 %f551, %f551, %f527
  asm("sub.f32 %0, %1, %2;" : "=f"(f551) : "f"(f551), "f"(f527));
  // PTX:664 sub.f32 %f552, %f552, %f528
  asm("sub.f32 %0, %1, %2;" : "=f"(f552) : "f"(f552), "f"(f528));
  // PTX:666 $L__BB43_18:
L_BB43_18:;
  // PTX:667 mul.lo.s64 %rd75, %rd12, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd75) : "l"(rd12));
  // PTX:668 add.s64 %rd76, %rd1, %rd75
  asm("add.s64 %0, %1, %2;" : "=l"(rd76) : "l"(rd1), "l"(rd75));
  // PTX:669 red.global.add.f32 [%rd76], %f550
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (0)))), (float)(f550));
  // PTX:670 add.s64 %rd77, %rd76, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd77) : "l"(rd76));
  // PTX:671 red.global.add.f32 [%rd77], %f551
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (0)))), (float)(f551));
  // PTX:672 add.s64 %rd78, %rd76, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd78) : "l"(rd76));
  // PTX:673 red.global.add.f32 [%rd78], %f552
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd78) + (0)))), (float)(f552));
  // PTX:675 $L__BB43_19:
L_BB43_19:;
  // PTX:676 ret
  return;
}
