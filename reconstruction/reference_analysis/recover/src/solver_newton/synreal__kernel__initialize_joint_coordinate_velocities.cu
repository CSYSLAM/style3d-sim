// 机械还原自 PTX：synreal::kernel::initialize_joint_coordinate_velocities(synreal::kernel::JointCoordinateView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float*)
// PTX SHA256: 6f61837a3939c22e7ff65e3cac0ead12a790cb409f2f5b3a105b073e42126561
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__initialize_joint_coordinate_velocities(ByVal<120, 8> param0, unsigned long long param1, unsigned long long param2, unsigned long long param3) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440, f441, f442, f443, f444, f445, f446, f447, f448, f449, f450, f451, f452, f453, f454, f455, f456, f457, f458, f459, f460, f461, f462, f463, f464, f465, f466, f467, f468, f469, f470, f471, f472, f473, f474, f475, f476, f477, f478, f479, f480, f481, f482, f483, f484, f485, f486, f487, f488, f489, f490, f491, f492, f493, f494, f495, f496, f497, f498, f499, f500, f501, f502, f503, f504, f505, f506, f507, f508, f509, f510, f511, f512, f513, f514, f515, f516, f517, f518, f519, f520, f521, f522, f523, f524, f525, f526, f527, f528, f529, f530, f531, f532, f533, f534, f535, f536, f537, f538, f539, f540, f541, f542, f543, f544, f545, f546, f547, f548, f549, f550, f551, f552, f553, f554, f555;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133;
  // PTX:20 ld.param.u64 %rd44, [_ZN7synreal6kernel38initialize_joint_coordinate_velocitiesENS0_19JointCoordinateViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_Pf_param_1]
  rd44 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:21 ld.param.u64 %rd45, [_ZN7synreal6kernel38initialize_joint_coordinate_velocitiesENS0_19JointCoordinateViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_Pf_param_2]
  rd45 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:22 ld.param.u64 %rd42, [_ZN7synreal6kernel38initialize_joint_coordinate_velocitiesENS0_19JointCoordinateViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_Pf_param_0+112]
  rd42 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (112))));
  // PTX:23 ld.param.u64 %rd41, [_ZN7synreal6kernel38initialize_joint_coordinate_velocitiesENS0_19JointCoordinateViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_Pf_param_0+104]
  rd41 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (104))));
  // PTX:24 ld.param.u64 %rd40, [_ZN7synreal6kernel38initialize_joint_coordinate_velocitiesENS0_19JointCoordinateViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_Pf_param_0+96]
  rd40 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (96))));
  // PTX:25 ld.param.u64 %rd37, [_ZN7synreal6kernel38initialize_joint_coordinate_velocitiesENS0_19JointCoordinateViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_Pf_param_0+72]
  rd37 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (72))));
  // PTX:26 ld.param.u64 %rd36, [_ZN7synreal6kernel38initialize_joint_coordinate_velocitiesENS0_19JointCoordinateViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_Pf_param_0+64]
  rd36 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (64))));
  // PTX:27 ld.param.u64 %rd35, [_ZN7synreal6kernel38initialize_joint_coordinate_velocitiesENS0_19JointCoordinateViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_Pf_param_0+56]
  rd35 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (56))));
  // PTX:28 ld.param.u64 %rd34, [_ZN7synreal6kernel38initialize_joint_coordinate_velocitiesENS0_19JointCoordinateViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_Pf_param_0+48]
  rd34 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (48))));
  // PTX:29 ld.param.u64 %rd33, [_ZN7synreal6kernel38initialize_joint_coordinate_velocitiesENS0_19JointCoordinateViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_Pf_param_0+40]
  rd33 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (40))));
  // PTX:30 ld.param.u64 %rd32, [_ZN7synreal6kernel38initialize_joint_coordinate_velocitiesENS0_19JointCoordinateViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_Pf_param_0+32]
  rd32 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (32))));
  // PTX:31 ld.param.u64 %rd31, [_ZN7synreal6kernel38initialize_joint_coordinate_velocitiesENS0_19JointCoordinateViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_Pf_param_0+24]
  rd31 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (24))));
  // PTX:32 ld.param.u64 %rd30, [_ZN7synreal6kernel38initialize_joint_coordinate_velocitiesENS0_19JointCoordinateViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_Pf_param_0+16]
  rd30 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (16))));
  // PTX:33 ld.param.u64 %rd29, [_ZN7synreal6kernel38initialize_joint_coordinate_velocitiesENS0_19JointCoordinateViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_Pf_param_0+8]
  rd29 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (8))));
  // PTX:34 ld.param.u64 %rd28, [_ZN7synreal6kernel38initialize_joint_coordinate_velocitiesENS0_19JointCoordinateViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_Pf_param_0]
  rd28 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:35 cvta.to.global.u64 %rd1, %rd45
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd45));
  // PTX:36 cvta.to.global.u64 %rd2, %rd44
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd44));
  // PTX:37 cvta.to.global.u64 %rd3, %rd28
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd28));
  // PTX:38 mov.u32 %r15, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r15) : "r"(blockIdx.x));
  // PTX:39 mov.u32 %r16, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r16) : "r"(blockDim.x));
  // PTX:40 mul.wide.u32 %rd46, %r15, %r16
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd46) : "r"(r15), "r"(r16));
  // PTX:41 mov.u32 %r17, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r17) : "r"(threadIdx.x));
  // PTX:42 cvt.u64.u32 %rd47, %r17
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd47) : "r"(r17));
  // PTX:43 add.s64 %rd4, %rd46, %rd47
  asm("add.s64 %0, %1, %2;" : "=l"(rd4) : "l"(rd46), "l"(rd47));
  // PTX:44 setp.ge.u64 %p1, %rd4, %rd41
  p1 = (((unsigned long long)(rd4)) >= ((unsigned long long)(rd41)));
  // PTX:45 @%p1 bra $L__BB68_34
  if (p1) { goto L_BB68_34; }
  // PTX:47 or.b64 %rd48, %rd4, %rd40
  asm("or.b64 %0, %1, %2;" : "=l"(rd48) : "l"(rd4), "l"(rd40));
  // PTX:48 and.b64 %rd49, %rd48, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd49) : "l"(rd48));
  // PTX:49 setp.eq.s64 %p2, %rd49, 0
  p2 = (((long long)(rd49)) == ((long long)(0)));
  // PTX:50 @%p2 bra $L__BB68_3
  if (p2) { goto L_BB68_3; }
  // PTX:52 div.u64 %rd128, %rd4, %rd40
  asm("div.u64 %0, %1, %2;" : "=l"(rd128) : "l"(rd4), "l"(rd40));
  // PTX:53 mul.lo.s64 %rd50, %rd128, %rd40
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd128), "l"(rd40));
  // PTX:54 sub.s64 %rd129, %rd4, %rd50
  asm("sub.s64 %0, %1, %2;" : "=l"(rd129) : "l"(rd4), "l"(rd50));
  // PTX:55 bra.uni $L__BB68_4
  goto L_BB68_4;
  // PTX:57 $L__BB68_3:
L_BB68_3:;
  // PTX:58 cvt.u32.u64 %r18, %rd40
  asm("cvt.u32.u64 %0, %1;" : "=r"(r18) : "l"(rd40));
  // PTX:59 cvt.u32.u64 %r19, %rd4
  asm("cvt.u32.u64 %0, %1;" : "=r"(r19) : "l"(rd4));
  // PTX:60 div.u32 %r20, %r19, %r18
  asm("div.u32 %0, %1, %2;" : "=r"(r20) : "r"(r19), "r"(r18));
  // PTX:61 mul.lo.s32 %r21, %r20, %r18
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r21) : "r"(r20), "r"(r18));
  // PTX:62 sub.s32 %r22, %r19, %r21
  asm("sub.s32 %0, %1, %2;" : "=r"(r22) : "r"(r19), "r"(r21));
  // PTX:63 cvt.u64.u32 %rd128, %r20
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd128) : "r"(r20));
  // PTX:64 cvt.u64.u32 %rd129, %r22
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd129) : "r"(r22));
  // PTX:66 $L__BB68_4:
L_BB68_4:;
  // PTX:67 mul.lo.s64 %rd55, %rd128, %rd42
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd55) : "l"(rd128), "l"(rd42));
  // PTX:68 cvt.u32.u64 %r1, %rd55
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd55));
  // PTX:69 cvta.to.global.u64 %rd56, %rd30
  rd56 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd30));
  // PTX:70 shl.b64 %rd57, %rd129, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd57) : "l"(rd129));
  // PTX:71 add.s64 %rd58, %rd56, %rd57
  asm("add.s64 %0, %1, %2;" : "=l"(rd58) : "l"(rd56), "l"(rd57));
  // PTX:72 ld.global.s32 %rd12, [%rd58]
  rd12 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (0)))));
  // PTX:73 mov.u64 %rd130, 0
  asm("mov.u64 %0, 0;" : "=l"(rd130) : );
  // PTX:74 ld.global.u32 %r23, [%rd58+4]
  r23 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (4)))));
  // PTX:75 mul.wide.s32 %rd59, %r23, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd59) : "r"(r23));
  // PTX:76 add.s64 %rd60, %rd3, %rd59
  asm("add.s64 %0, %1, %2;" : "=l"(rd60) : "l"(rd3), "l"(rd59));
  // PTX:77 ld.global.u32 %r2, [%rd60]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))));
  // PTX:78 ld.global.u32 %r3, [%rd60+4]
  r3 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (4)))));
  // PTX:79 ld.global.u32 %r4, [%rd60+8]
  r4 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (8)))));
  // PTX:80 ld.global.u32 %r5, [%rd60+12]
  r5 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (12)))));
  // PTX:81 cvta.to.global.u64 %rd61, %rd31
  rd61 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd31));
  // PTX:82 mul.lo.s64 %rd62, %rd129, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd62) : "l"(rd129));
  // PTX:83 add.s64 %rd63, %rd61, %rd62
  asm("add.s64 %0, %1, %2;" : "=l"(rd63) : "l"(rd61), "l"(rd62));
  // PTX:84 ld.global.f32 %f516, [%rd63]
  f516 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (0)))));
  // PTX:85 ld.global.f32 %f517, [%rd63+4]
  f517 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (4)))));
  // PTX:86 ld.global.f32 %f518, [%rd63+8]
  f518 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (8)))));
  // PTX:87 cvta.to.global.u64 %rd64, %rd32
  rd64 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd32));
  // PTX:88 add.s64 %rd65, %rd64, %rd62
  asm("add.s64 %0, %1, %2;" : "=l"(rd65) : "l"(rd64), "l"(rd62));
  // PTX:89 ld.global.f32 %f513, [%rd65]
  f513 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (0)))));
  // PTX:90 ld.global.f32 %f514, [%rd65+4]
  f514 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (4)))));
  // PTX:91 ld.global.f32 %f515, [%rd65+8]
  f515 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (8)))));
  // PTX:92 cvta.to.global.u64 %rd66, %rd33
  rd66 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd33));
  // PTX:93 add.s64 %rd67, %rd66, %rd62
  asm("add.s64 %0, %1, %2;" : "=l"(rd67) : "l"(rd66), "l"(rd62));
  // PTX:94 ld.global.u32 %r51, [%rd67+8]
  r51 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (8)))));
  // PTX:95 ld.global.u32 %r50, [%rd67+4]
  r50 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (4)))));
  // PTX:96 ld.global.u32 %r49, [%rd67]
  r49 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0)))));
  // PTX:97 setp.lt.s64 %p3, %rd12, 0
  p3 = (((long long)(rd12)) < ((long long)(0)));
  // PTX:98 cvta.to.global.u64 %rd68, %rd34
  rd68 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd34));
  // PTX:99 shl.b64 %rd69, %rd129, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd69) : "l"(rd129));
  // PTX:100 add.s64 %rd13, %rd68, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd13) : "l"(rd68), "l"(rd69));
  // PTX:101 cvta.to.global.u64 %rd70, %rd36
  rd70 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd36));
  // PTX:102 add.s64 %rd14, %rd70, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd14) : "l"(rd70), "l"(rd69));
  // PTX:103 cvta.to.global.u64 %rd71, %rd37
  rd71 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd37));
  // PTX:104 add.s64 %rd15, %rd71, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd15) : "l"(rd71), "l"(rd69));
  // PTX:105 mov.u64 %rd131, %rd130
  asm("mov.u64 %0, %1;" : "=l"(rd131) : "l"(rd130));
  // PTX:106 mov.u64 %rd132, %rd130
  asm("mov.u64 %0, %1;" : "=l"(rd132) : "l"(rd130));
  // PTX:107 mov.u64 %rd133, %rd130
  asm("mov.u64 %0, %1;" : "=l"(rd133) : "l"(rd130));
  // PTX:108 @%p3 bra $L__BB68_6
  if (p3) { goto L_BB68_6; }
  // PTX:110 shl.b64 %rd72, %rd12, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd72) : "l"(rd12));
  // PTX:111 add.s64 %rd73, %rd3, %rd72
  asm("add.s64 %0, %1, %2;" : "=l"(rd73) : "l"(rd3), "l"(rd72));
  // PTX:112 ld.global.u32 %r24, [%rd73]
  r24 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (0)))));
  // PTX:113 add.s32 %r25, %r24, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r25) : "r"(r24), "r"(r1));
  // PTX:114 ld.global.u32 %r26, [%rd73+4]
  r26 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (4)))));
  // PTX:115 add.s32 %r27, %r26, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r27) : "r"(r26), "r"(r1));
  // PTX:116 ld.global.u32 %r28, [%rd73+8]
  r28 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (8)))));
  // PTX:117 add.s32 %r29, %r28, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r29) : "r"(r28), "r"(r1));
  // PTX:118 ld.global.u32 %r30, [%rd73+12]
  r30 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (12)))));
  // PTX:119 add.s32 %r31, %r30, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r31) : "r"(r30), "r"(r1));
  // PTX:120 cvt.s64.s32 %rd133, %r25
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd133) : "r"(r25));
  // PTX:121 mul.wide.s32 %rd74, %r25, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd74) : "r"(r25));
  // PTX:122 add.s64 %rd75, %rd2, %rd74
  asm("add.s64 %0, %1, %2;" : "=l"(rd75) : "l"(rd2), "l"(rd74));
  // PTX:123 ld.global.f32 %f181, [%rd75]
  f181 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (0)))));
  // PTX:124 ld.global.f32 %f182, [%rd13]
  f182 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))));
  // PTX:125 ld.global.f32 %f183, [%rd75+4]
  f183 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (4)))));
  // PTX:126 ld.global.f32 %f184, [%rd75+8]
  f184 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (8)))));
  // PTX:127 cvt.s64.s32 %rd132, %r27
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd132) : "r"(r27));
  // PTX:128 mul.wide.s32 %rd76, %r27, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd76) : "r"(r27));
  // PTX:129 add.s64 %rd77, %rd2, %rd76
  asm("add.s64 %0, %1, %2;" : "=l"(rd77) : "l"(rd2), "l"(rd76));
  // PTX:130 ld.global.f32 %f185, [%rd77]
  f185 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (0)))));
  // PTX:131 ld.global.f32 %f186, [%rd13+4]
  f186 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4)))));
  // PTX:132 mul.f32 %f187, %f186, %f185
  asm("mul.f32 %0, %1, %2;" : "=f"(f187) : "f"(f186), "f"(f185));
  // PTX:133 ld.global.f32 %f188, [%rd77+4]
  f188 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (4)))));
  // PTX:134 mul.f32 %f189, %f186, %f188
  asm("mul.f32 %0, %1, %2;" : "=f"(f189) : "f"(f186), "f"(f188));
  // PTX:135 ld.global.f32 %f190, [%rd77+8]
  f190 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (8)))));
  // PTX:136 mul.f32 %f191, %f186, %f190
  asm("mul.f32 %0, %1, %2;" : "=f"(f191) : "f"(f186), "f"(f190));
  // PTX:137 fma.rn.f32 %f192, %f182, %f181, %f187
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f192) : "f"(f182), "f"(f181), "f"(f187));
  // PTX:138 fma.rn.f32 %f193, %f182, %f183, %f189
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f193) : "f"(f182), "f"(f183), "f"(f189));
  // PTX:139 fma.rn.f32 %f194, %f182, %f184, %f191
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f194) : "f"(f182), "f"(f184), "f"(f191));
  // PTX:140 cvt.s64.s32 %rd131, %r29
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd131) : "r"(r29));
  // PTX:141 mul.wide.s32 %rd78, %r29, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd78) : "r"(r29));
  // PTX:142 add.s64 %rd79, %rd2, %rd78
  asm("add.s64 %0, %1, %2;" : "=l"(rd79) : "l"(rd2), "l"(rd78));
  // PTX:143 ld.global.f32 %f195, [%rd79]
  f195 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (0)))));
  // PTX:144 ld.global.f32 %f196, [%rd13+8]
  f196 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8)))));
  // PTX:145 ld.global.f32 %f197, [%rd79+4]
  f197 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (4)))));
  // PTX:146 ld.global.f32 %f198, [%rd79+8]
  f198 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (8)))));
  // PTX:147 fma.rn.f32 %f199, %f196, %f195, %f192
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f199) : "f"(f196), "f"(f195), "f"(f192));
  // PTX:148 fma.rn.f32 %f200, %f196, %f197, %f193
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f200) : "f"(f196), "f"(f197), "f"(f193));
  // PTX:149 fma.rn.f32 %f201, %f196, %f198, %f194
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f201) : "f"(f196), "f"(f198), "f"(f194));
  // PTX:150 cvt.s64.s32 %rd130, %r31
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd130) : "r"(r31));
  // PTX:151 mul.wide.s32 %rd80, %r31, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd80) : "r"(r31));
  // PTX:152 add.s64 %rd81, %rd2, %rd80
  asm("add.s64 %0, %1, %2;" : "=l"(rd81) : "l"(rd2), "l"(rd80));
  // PTX:153 ld.global.f32 %f202, [%rd81]
  f202 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (0)))));
  // PTX:154 ld.global.f32 %f203, [%rd13+12]
  f203 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (12)))));
  // PTX:155 ld.global.f32 %f204, [%rd81+4]
  f204 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (4)))));
  // PTX:156 ld.global.f32 %f205, [%rd81+8]
  f205 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (8)))));
  // PTX:157 fma.rn.f32 %f516, %f203, %f202, %f199
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f516) : "f"(f203), "f"(f202), "f"(f199));
  // PTX:158 fma.rn.f32 %f517, %f203, %f204, %f200
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f517) : "f"(f203), "f"(f204), "f"(f200));
  // PTX:159 fma.rn.f32 %f518, %f203, %f205, %f201
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f518) : "f"(f203), "f"(f205), "f"(f201));
  // PTX:160 ld.global.f32 %f206, [%rd14]
  f206 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:161 ld.global.f32 %f207, [%rd14+4]
  f207 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (4)))));
  // PTX:162 mul.f32 %f208, %f207, %f185
  asm("mul.f32 %0, %1, %2;" : "=f"(f208) : "f"(f207), "f"(f185));
  // PTX:163 mul.f32 %f209, %f207, %f188
  asm("mul.f32 %0, %1, %2;" : "=f"(f209) : "f"(f207), "f"(f188));
  // PTX:164 mul.f32 %f210, %f207, %f190
  asm("mul.f32 %0, %1, %2;" : "=f"(f210) : "f"(f207), "f"(f190));
  // PTX:165 fma.rn.f32 %f211, %f206, %f181, %f208
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f211) : "f"(f206), "f"(f181), "f"(f208));
  // PTX:166 fma.rn.f32 %f212, %f206, %f183, %f209
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f212) : "f"(f206), "f"(f183), "f"(f209));
  // PTX:167 fma.rn.f32 %f213, %f206, %f184, %f210
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f213) : "f"(f206), "f"(f184), "f"(f210));
  // PTX:168 ld.global.f32 %f214, [%rd14+8]
  f214 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (8)))));
  // PTX:169 fma.rn.f32 %f215, %f214, %f195, %f211
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f215) : "f"(f214), "f"(f195), "f"(f211));
  // PTX:170 fma.rn.f32 %f216, %f214, %f197, %f212
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f216) : "f"(f214), "f"(f197), "f"(f212));
  // PTX:171 fma.rn.f32 %f217, %f214, %f198, %f213
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f217) : "f"(f214), "f"(f198), "f"(f213));
  // PTX:172 ld.global.f32 %f218, [%rd14+12]
  f218 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (12)))));
  // PTX:173 fma.rn.f32 %f513, %f218, %f202, %f215
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f513) : "f"(f218), "f"(f202), "f"(f215));
  // PTX:174 fma.rn.f32 %f514, %f218, %f204, %f216
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f514) : "f"(f218), "f"(f204), "f"(f216));
  // PTX:175 fma.rn.f32 %f515, %f218, %f205, %f217
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f515) : "f"(f218), "f"(f205), "f"(f217));
  // PTX:176 ld.global.f32 %f219, [%rd15]
  f219 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))));
  // PTX:177 ld.global.f32 %f220, [%rd15+4]
  f220 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (4)))));
  // PTX:178 mul.f32 %f221, %f220, %f185
  asm("mul.f32 %0, %1, %2;" : "=f"(f221) : "f"(f220), "f"(f185));
  // PTX:179 mul.f32 %f222, %f220, %f188
  asm("mul.f32 %0, %1, %2;" : "=f"(f222) : "f"(f220), "f"(f188));
  // PTX:180 mul.f32 %f223, %f220, %f190
  asm("mul.f32 %0, %1, %2;" : "=f"(f223) : "f"(f220), "f"(f190));
  // PTX:181 fma.rn.f32 %f224, %f219, %f181, %f221
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f224) : "f"(f219), "f"(f181), "f"(f221));
  // PTX:182 fma.rn.f32 %f225, %f219, %f183, %f222
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f225) : "f"(f219), "f"(f183), "f"(f222));
  // PTX:183 fma.rn.f32 %f226, %f219, %f184, %f223
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f226) : "f"(f219), "f"(f184), "f"(f223));
  // PTX:184 ld.global.f32 %f227, [%rd15+8]
  f227 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (8)))));
  // PTX:185 fma.rn.f32 %f228, %f227, %f195, %f224
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f228) : "f"(f227), "f"(f195), "f"(f224));
  // PTX:186 fma.rn.f32 %f229, %f227, %f197, %f225
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f229) : "f"(f227), "f"(f197), "f"(f225));
  // PTX:187 fma.rn.f32 %f230, %f227, %f198, %f226
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f230) : "f"(f227), "f"(f198), "f"(f226));
  // PTX:188 ld.global.f32 %f231, [%rd15+12]
  f231 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (12)))));
  // PTX:189 fma.rn.f32 %f232, %f231, %f202, %f228
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f232) : "f"(f231), "f"(f202), "f"(f228));
  // PTX:190 fma.rn.f32 %f233, %f231, %f204, %f229
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f233) : "f"(f231), "f"(f204), "f"(f229));
  // PTX:191 fma.rn.f32 %f234, %f231, %f205, %f230
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f234) : "f"(f231), "f"(f205), "f"(f230));
  // PTX:192 mov.b32 %r51, %f234
  asm("mov.b32 %0, %1;" : "=r"(r51) : "f"(f234));
  // PTX:193 mov.b32 %r50, %f233
  asm("mov.b32 %0, %1;" : "=r"(r50) : "f"(f233));
  // PTX:194 mov.b32 %r49, %f232
  asm("mov.b32 %0, %1;" : "=r"(r49) : "f"(f232));
  // PTX:196 $L__BB68_6:
L_BB68_6:;
  // PTX:197 cvta.to.global.u64 %rd82, %rd35
  rd82 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd35));
  // PTX:198 add.s64 %rd84, %rd82, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd84) : "l"(rd82), "l"(rd69));
  // PTX:199 add.s32 %r32, %r2, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r32) : "r"(r2), "r"(r1));
  // PTX:200 cvt.s64.s32 %rd24, %r32
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd24) : "r"(r32));
  // PTX:201 mul.wide.s32 %rd85, %r32, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd85) : "r"(r32));
  // PTX:202 add.s64 %rd86, %rd2, %rd85
  asm("add.s64 %0, %1, %2;" : "=l"(rd86) : "l"(rd2), "l"(rd85));
  // PTX:203 ld.global.f32 %f19, [%rd86]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd86) + (0)))));
  // PTX:204 ld.global.f32 %f20, [%rd84]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (0)))));
  // PTX:205 ld.global.f32 %f21, [%rd86+4]
  f21 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd86) + (4)))));
  // PTX:206 ld.global.f32 %f22, [%rd86+8]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd86) + (8)))));
  // PTX:207 add.s32 %r33, %r3, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r33) : "r"(r3), "r"(r1));
  // PTX:208 cvt.s64.s32 %rd25, %r33
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd25) : "r"(r33));
  // PTX:209 mul.wide.s32 %rd87, %r33, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd87) : "r"(r33));
  // PTX:210 add.s64 %rd88, %rd2, %rd87
  asm("add.s64 %0, %1, %2;" : "=l"(rd88) : "l"(rd2), "l"(rd87));
  // PTX:211 ld.global.f32 %f23, [%rd88]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (0)))));
  // PTX:212 ld.global.f32 %f24, [%rd84+4]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (4)))));
  // PTX:213 mul.f32 %f235, %f24, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f235) : "f"(f24), "f"(f23));
  // PTX:214 ld.global.f32 %f25, [%rd88+4]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (4)))));
  // PTX:215 mul.f32 %f236, %f24, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f236) : "f"(f24), "f"(f25));
  // PTX:216 ld.global.f32 %f26, [%rd88+8]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (8)))));
  // PTX:217 mul.f32 %f237, %f24, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f237) : "f"(f24), "f"(f26));
  // PTX:218 fma.rn.f32 %f238, %f20, %f19, %f235
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f238) : "f"(f20), "f"(f19), "f"(f235));
  // PTX:219 fma.rn.f32 %f239, %f20, %f21, %f236
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f239) : "f"(f20), "f"(f21), "f"(f236));
  // PTX:220 fma.rn.f32 %f240, %f20, %f22, %f237
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f240) : "f"(f20), "f"(f22), "f"(f237));
  // PTX:221 add.s32 %r34, %r4, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r34) : "r"(r4), "r"(r1));
  // PTX:222 cvt.s64.s32 %rd26, %r34
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd26) : "r"(r34));
  // PTX:223 mul.wide.s32 %rd89, %r34, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd89) : "r"(r34));
  // PTX:224 add.s64 %rd90, %rd2, %rd89
  asm("add.s64 %0, %1, %2;" : "=l"(rd90) : "l"(rd2), "l"(rd89));
  // PTX:225 ld.global.f32 %f27, [%rd90]
  f27 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (0)))));
  // PTX:226 ld.global.f32 %f28, [%rd84+8]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (8)))));
  // PTX:227 ld.global.f32 %f29, [%rd90+4]
  f29 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (4)))));
  // PTX:228 ld.global.f32 %f30, [%rd90+8]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (8)))));
  // PTX:229 fma.rn.f32 %f241, %f28, %f27, %f238
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f241) : "f"(f28), "f"(f27), "f"(f238));
  // PTX:230 fma.rn.f32 %f242, %f28, %f29, %f239
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f242) : "f"(f28), "f"(f29), "f"(f239));
  // PTX:231 fma.rn.f32 %f243, %f28, %f30, %f240
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f243) : "f"(f28), "f"(f30), "f"(f240));
  // PTX:232 add.s32 %r35, %r5, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r35) : "r"(r5), "r"(r1));
  // PTX:233 cvt.s64.s32 %rd27, %r35
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd27) : "r"(r35));
  // PTX:234 mul.wide.s32 %rd91, %r35, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd91) : "r"(r35));
  // PTX:235 add.s64 %rd92, %rd2, %rd91
  asm("add.s64 %0, %1, %2;" : "=l"(rd92) : "l"(rd2), "l"(rd91));
  // PTX:236 ld.global.f32 %f31, [%rd92]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (0)))));
  // PTX:237 ld.global.f32 %f32, [%rd84+12]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (12)))));
  // PTX:238 ld.global.f32 %f33, [%rd92+4]
  f33 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (4)))));
  // PTX:239 ld.global.f32 %f34, [%rd92+8]
  f34 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (8)))));
  // PTX:240 fma.rn.f32 %f35, %f32, %f31, %f241
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f35) : "f"(f32), "f"(f31), "f"(f241));
  // PTX:241 fma.rn.f32 %f36, %f32, %f33, %f242
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f36) : "f"(f32), "f"(f33), "f"(f242));
  // PTX:242 fma.rn.f32 %f37, %f32, %f34, %f243
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f37) : "f"(f32), "f"(f34), "f"(f243));
  // PTX:243 cvta.to.global.u64 %rd93, %rd29
  rd93 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd29));
  // PTX:244 shl.b64 %rd94, %rd129, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd94) : "l"(rd129));
  // PTX:245 add.s64 %rd95, %rd93, %rd94
  asm("add.s64 %0, %1, %2;" : "=l"(rd95) : "l"(rd93), "l"(rd94));
  // PTX:246 ld.global.u32 %r36, [%rd95]
  r36 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd95) + (0)))));
  // PTX:247 setp.eq.s32 %p4, %r36, 0
  p4 = (((int)(r36)) == ((int)(0)));
  // PTX:248 @%p4 bra $L__BB68_16
  if (p4) { goto L_BB68_16; }
  // PTX:250 shl.b64 %rd119, %rd129, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd119) : "l"(rd129));
  // PTX:251 mov.f32 %f555, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f555) : );
  // PTX:252 ld.param.u64 %rd118, [_ZN7synreal6kernel38initialize_joint_coordinate_velocitiesENS0_19JointCoordinateViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_Pf_param_0+80]
  rd118 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (80))));
  // PTX:253 cvta.to.global.u64 %rd96, %rd118
  rd96 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd118));
  // PTX:254 add.s64 %rd98, %rd96, %rd119
  asm("add.s64 %0, %1, %2;" : "=l"(rd98) : "l"(rd96), "l"(rd119));
  // PTX:255 ld.global.f32 %f38, [%rd98]
  f38 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (0)))));
  // PTX:256 ld.global.f32 %f39, [%rd98+4]
  f39 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (4)))));
  // PTX:257 mul.f32 %f245, %f39, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f245) : "f"(f39), "f"(f23));
  // PTX:258 mul.f32 %f246, %f39, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f246) : "f"(f39), "f"(f25));
  // PTX:259 mul.f32 %f247, %f39, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f247) : "f"(f39), "f"(f26));
  // PTX:260 fma.rn.f32 %f248, %f38, %f19, %f245
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f248) : "f"(f38), "f"(f19), "f"(f245));
  // PTX:261 fma.rn.f32 %f249, %f38, %f21, %f246
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f249) : "f"(f38), "f"(f21), "f"(f246));
  // PTX:262 fma.rn.f32 %f250, %f38, %f22, %f247
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f250) : "f"(f38), "f"(f22), "f"(f247));
  // PTX:263 ld.global.f32 %f40, [%rd98+8]
  f40 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (8)))));
  // PTX:264 fma.rn.f32 %f251, %f40, %f27, %f248
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f251) : "f"(f40), "f"(f27), "f"(f248));
  // PTX:265 fma.rn.f32 %f252, %f40, %f29, %f249
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f252) : "f"(f40), "f"(f29), "f"(f249));
  // PTX:266 fma.rn.f32 %f253, %f40, %f30, %f250
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f253) : "f"(f40), "f"(f30), "f"(f250));
  // PTX:267 ld.global.f32 %f41, [%rd98+12]
  f41 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (12)))));
  // PTX:268 fma.rn.f32 %f42, %f41, %f31, %f251
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f42) : "f"(f41), "f"(f31), "f"(f251));
  // PTX:269 fma.rn.f32 %f43, %f41, %f33, %f252
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f43) : "f"(f41), "f"(f33), "f"(f252));
  // PTX:270 fma.rn.f32 %f44, %f41, %f34, %f253
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f44) : "f"(f41), "f"(f34), "f"(f253));
  // PTX:271 sub.f32 %f45, %f513, %f516
  asm("sub.f32 %0, %1, %2;" : "=f"(f45) : "f"(f513), "f"(f516));
  // PTX:272 sub.f32 %f46, %f514, %f517
  asm("sub.f32 %0, %1, %2;" : "=f"(f46) : "f"(f514), "f"(f517));
  // PTX:273 mul.f32 %f254, %f46, %f46
  asm("mul.f32 %0, %1, %2;" : "=f"(f254) : "f"(f46), "f"(f46));
  // PTX:274 sub.f32 %f47, %f515, %f518
  asm("sub.f32 %0, %1, %2;" : "=f"(f47) : "f"(f515), "f"(f518));
  // PTX:275 fma.rn.f32 %f255, %f45, %f45, %f254
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f255) : "f"(f45), "f"(f45), "f"(f254));
  // PTX:276 fma.rn.f32 %f256, %f47, %f47, %f255
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f256) : "f"(f47), "f"(f47), "f"(f255));
  // PTX:277 sqrt.rn.f32 %f48, %f256
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f48) : "f"(f256));
  // PTX:278 setp.leu.f32 %p5, %f48, 0f322BCC77
  p5 = ((isnan(((float)(f48))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f48)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:279 @%p5 bra $L__BB68_33
  if (p5) { goto L_BB68_33; }
  // PTX:281 mov.f32 %f555, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f555) : );
  // PTX:282 abs.f32 %f258, %f48
  asm("abs.f32 %0, %1;" : "=f"(f258) : "f"(f48));
  // PTX:283 setp.geu.f32 %p6, %f258, 0f7F800000
  p6 = ((isnan(((float)(f258))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f258)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:284 @%p6 bra $L__BB68_33
  if (p6) { goto L_BB68_33; }
  // PTX:286 mov.f32 %f555, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f555) : );
  // PTX:287 div.rn.f32 %f49, %f45, %f48
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f49) : "f"(f45), "f"(f48));
  // PTX:288 mov.b32 %f260, %r49
  asm("mov.b32 %0, %1;" : "=f"(f260) : "r"(r49));
  // PTX:289 sub.f32 %f261, %f260, %f516
  asm("sub.f32 %0, %1, %2;" : "=f"(f261) : "f"(f260), "f"(f516));
  // PTX:290 mov.b32 %f262, %r50
  asm("mov.b32 %0, %1;" : "=f"(f262) : "r"(r50));
  // PTX:291 sub.f32 %f263, %f262, %f517
  asm("sub.f32 %0, %1, %2;" : "=f"(f263) : "f"(f262), "f"(f517));
  // PTX:292 mov.b32 %f264, %r51
  asm("mov.b32 %0, %1;" : "=f"(f264) : "r"(r51));
  // PTX:293 sub.f32 %f265, %f264, %f518
  asm("sub.f32 %0, %1, %2;" : "=f"(f265) : "f"(f264), "f"(f518));
  // PTX:294 div.rn.f32 %f50, %f46, %f48
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f50) : "f"(f46), "f"(f48));
  // PTX:295 mul.f32 %f266, %f263, %f50
  asm("mul.f32 %0, %1, %2;" : "=f"(f266) : "f"(f263), "f"(f50));
  // PTX:296 div.rn.f32 %f51, %f47, %f48
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f51) : "f"(f47), "f"(f48));
  // PTX:297 fma.rn.f32 %f267, %f261, %f49, %f266
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f267) : "f"(f261), "f"(f49), "f"(f266));
  // PTX:298 fma.rn.f32 %f52, %f265, %f51, %f267
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f52) : "f"(f265), "f"(f51), "f"(f267));
  // PTX:299 mul.f32 %f268, %f49, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f268) : "f"(f49), "f"(f52));
  // PTX:300 mul.f32 %f269, %f50, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f269) : "f"(f50), "f"(f52));
  // PTX:301 mul.f32 %f270, %f51, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f270) : "f"(f51), "f"(f52));
  // PTX:302 sub.f32 %f53, %f261, %f268
  asm("sub.f32 %0, %1, %2;" : "=f"(f53) : "f"(f261), "f"(f268));
  // PTX:303 sub.f32 %f54, %f263, %f269
  asm("sub.f32 %0, %1, %2;" : "=f"(f54) : "f"(f263), "f"(f269));
  // PTX:304 sub.f32 %f55, %f265, %f270
  asm("sub.f32 %0, %1, %2;" : "=f"(f55) : "f"(f265), "f"(f270));
  // PTX:305 sub.f32 %f271, %f42, %f35
  asm("sub.f32 %0, %1, %2;" : "=f"(f271) : "f"(f42), "f"(f35));
  // PTX:306 sub.f32 %f272, %f43, %f36
  asm("sub.f32 %0, %1, %2;" : "=f"(f272) : "f"(f43), "f"(f36));
  // PTX:307 mul.f32 %f273, %f272, %f50
  asm("mul.f32 %0, %1, %2;" : "=f"(f273) : "f"(f272), "f"(f50));
  // PTX:308 sub.f32 %f274, %f44, %f37
  asm("sub.f32 %0, %1, %2;" : "=f"(f274) : "f"(f44), "f"(f37));
  // PTX:309 fma.rn.f32 %f275, %f271, %f49, %f273
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f275) : "f"(f271), "f"(f49), "f"(f273));
  // PTX:310 fma.rn.f32 %f56, %f51, %f274, %f275
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f56) : "f"(f51), "f"(f274), "f"(f275));
  // PTX:311 mul.f32 %f276, %f49, %f56
  asm("mul.f32 %0, %1, %2;" : "=f"(f276) : "f"(f49), "f"(f56));
  // PTX:312 mul.f32 %f277, %f50, %f56
  asm("mul.f32 %0, %1, %2;" : "=f"(f277) : "f"(f50), "f"(f56));
  // PTX:313 mul.f32 %f278, %f51, %f56
  asm("mul.f32 %0, %1, %2;" : "=f"(f278) : "f"(f51), "f"(f56));
  // PTX:314 sub.f32 %f57, %f271, %f276
  asm("sub.f32 %0, %1, %2;" : "=f"(f57) : "f"(f271), "f"(f276));
  // PTX:315 sub.f32 %f58, %f272, %f277
  asm("sub.f32 %0, %1, %2;" : "=f"(f58) : "f"(f272), "f"(f277));
  // PTX:316 sub.f32 %f59, %f274, %f278
  asm("sub.f32 %0, %1, %2;" : "=f"(f59) : "f"(f274), "f"(f278));
  // PTX:317 mul.f32 %f279, %f54, %f54
  asm("mul.f32 %0, %1, %2;" : "=f"(f279) : "f"(f54), "f"(f54));
  // PTX:318 fma.rn.f32 %f280, %f53, %f53, %f279
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f280) : "f"(f53), "f"(f53), "f"(f279));
  // PTX:319 fma.rn.f32 %f281, %f55, %f55, %f280
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f281) : "f"(f55), "f"(f55), "f"(f280));
  // PTX:320 sqrt.rn.f32 %f60, %f281
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f60) : "f"(f281));
  // PTX:321 mul.f32 %f282, %f58, %f58
  asm("mul.f32 %0, %1, %2;" : "=f"(f282) : "f"(f58), "f"(f58));
  // PTX:322 fma.rn.f32 %f283, %f57, %f57, %f282
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f283) : "f"(f57), "f"(f57), "f"(f282));
  // PTX:323 fma.rn.f32 %f284, %f59, %f59, %f283
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f284) : "f"(f59), "f"(f59), "f"(f283));
  // PTX:324 sqrt.rn.f32 %f61, %f284
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f61) : "f"(f284));
  // PTX:325 setp.leu.f32 %p7, %f60, 0f322BCC77
  p7 = ((isnan(((float)(f60))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f60)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:326 setp.leu.f32 %p8, %f61, 0f322BCC77
  p8 = ((isnan(((float)(f61))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f61)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:327 or.pred %p9, %p7, %p8
  p9 = ((p7) || (p8));
  // PTX:328 @%p9 bra $L__BB68_33
  if (p9) { goto L_BB68_33; }
  // PTX:330 mov.f32 %f555, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f555) : );
  // PTX:331 abs.f32 %f286, %f60
  asm("abs.f32 %0, %1;" : "=f"(f286) : "f"(f60));
  // PTX:332 setp.geu.f32 %p10, %f286, 0f7F800000
  p10 = ((isnan(((float)(f286))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f286)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:333 @%p10 bra $L__BB68_33
  if (p10) { goto L_BB68_33; }
  // PTX:335 mov.f32 %f555, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f555) : );
  // PTX:336 abs.f32 %f288, %f61
  asm("abs.f32 %0, %1;" : "=f"(f288) : "f"(f61));
  // PTX:337 setp.geu.f32 %p11, %f288, 0f7F800000
  p11 = ((isnan(((float)(f288))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f288)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:338 @%p11 bra $L__BB68_33
  if (p11) { goto L_BB68_33; }
  // PTX:340 mov.f32 %f555, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f555) : );
  // PTX:341 div.rn.f32 %f62, %f53, %f60
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f62) : "f"(f53), "f"(f60));
  // PTX:342 div.rn.f32 %f63, %f59, %f61
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f63) : "f"(f59), "f"(f61));
  // PTX:343 div.rn.f32 %f64, %f54, %f60
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f64) : "f"(f54), "f"(f60));
  // PTX:344 mul.f32 %f290, %f64, %f63
  asm("mul.f32 %0, %1, %2;" : "=f"(f290) : "f"(f64), "f"(f63));
  // PTX:345 div.rn.f32 %f65, %f58, %f61
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f65) : "f"(f58), "f"(f61));
  // PTX:346 div.rn.f32 %f66, %f55, %f60
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f66) : "f"(f55), "f"(f60));
  // PTX:347 mul.f32 %f291, %f66, %f65
  asm("mul.f32 %0, %1, %2;" : "=f"(f291) : "f"(f66), "f"(f65));
  // PTX:348 sub.f32 %f292, %f290, %f291
  asm("sub.f32 %0, %1, %2;" : "=f"(f292) : "f"(f290), "f"(f291));
  // PTX:349 div.rn.f32 %f67, %f57, %f61
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f67) : "f"(f57), "f"(f61));
  // PTX:350 mul.f32 %f293, %f66, %f67
  asm("mul.f32 %0, %1, %2;" : "=f"(f293) : "f"(f66), "f"(f67));
  // PTX:351 mul.f32 %f294, %f62, %f63
  asm("mul.f32 %0, %1, %2;" : "=f"(f294) : "f"(f62), "f"(f63));
  // PTX:352 sub.f32 %f295, %f293, %f294
  asm("sub.f32 %0, %1, %2;" : "=f"(f295) : "f"(f293), "f"(f294));
  // PTX:353 mul.f32 %f296, %f62, %f65
  asm("mul.f32 %0, %1, %2;" : "=f"(f296) : "f"(f62), "f"(f65));
  // PTX:354 mul.f32 %f297, %f64, %f67
  asm("mul.f32 %0, %1, %2;" : "=f"(f297) : "f"(f64), "f"(f67));
  // PTX:355 sub.f32 %f298, %f296, %f297
  asm("sub.f32 %0, %1, %2;" : "=f"(f298) : "f"(f296), "f"(f297));
  // PTX:356 mul.f32 %f299, %f50, %f295
  asm("mul.f32 %0, %1, %2;" : "=f"(f299) : "f"(f50), "f"(f295));
  // PTX:357 fma.rn.f32 %f300, %f49, %f292, %f299
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f300) : "f"(f49), "f"(f292), "f"(f299));
  // PTX:358 fma.rn.f32 %f301, %f51, %f298, %f300
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f301) : "f"(f51), "f"(f298), "f"(f300));
  // PTX:359 mul.f32 %f302, %f64, %f65
  asm("mul.f32 %0, %1, %2;" : "=f"(f302) : "f"(f64), "f"(f65));
  // PTX:360 fma.rn.f32 %f303, %f62, %f67, %f302
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f303) : "f"(f62), "f"(f67), "f"(f302));
  // PTX:361 fma.rn.f32 %f304, %f66, %f63, %f303
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f304) : "f"(f66), "f"(f63), "f"(f303));
  // PTX:362 mul.f32 %f305, %f301, %f301
  asm("mul.f32 %0, %1, %2;" : "=f"(f305) : "f"(f301), "f"(f301));
  // PTX:363 fma.rn.f32 %f68, %f304, %f304, %f305
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f68) : "f"(f304), "f"(f304), "f"(f305));
  // PTX:364 setp.leu.f32 %p12, %f68, 0f2B8CBCCC
  p12 = ((isnan(((float)(f68))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) || (((float)(f68)) <= ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:365 @%p12 bra $L__BB68_33
  if (p12) { goto L_BB68_33; }
  // PTX:367 mov.f32 %f555, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f555) : );
  // PTX:368 abs.f32 %f307, %f68
  asm("abs.f32 %0, %1;" : "=f"(f307) : "f"(f68));
  // PTX:369 setp.geu.f32 %p13, %f307, 0f7F800000
  p13 = ((isnan(((float)(f307))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f307)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:370 @%p13 bra $L__BB68_33
  if (p13) { goto L_BB68_33; }
  // PTX:372 cvt.u32.u64 %r37, %rd12
  asm("cvt.u32.u64 %0, %1;" : "=r"(r37) : "l"(rd12));
  // PTX:373 setp.lt.s32 %p14, %r37, 0
  p14 = (((int)(r37)) < ((int)(0)));
  // PTX:374 mul.f32 %f309, %f51, %f64
  asm("mul.f32 %0, %1, %2;" : "=f"(f309) : "f"(f51), "f"(f64));
  // PTX:375 mul.f32 %f310, %f50, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f310) : "f"(f50), "f"(f66));
  // PTX:376 sub.f32 %f69, %f310, %f309
  asm("sub.f32 %0, %1, %2;" : "=f"(f69) : "f"(f310), "f"(f309));
  // PTX:377 mul.f32 %f311, %f49, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f311) : "f"(f49), "f"(f66));
  // PTX:378 mul.f32 %f312, %f51, %f62
  asm("mul.f32 %0, %1, %2;" : "=f"(f312) : "f"(f51), "f"(f62));
  // PTX:379 sub.f32 %f70, %f312, %f311
  asm("sub.f32 %0, %1, %2;" : "=f"(f70) : "f"(f312), "f"(f311));
  // PTX:380 mul.f32 %f313, %f50, %f62
  asm("mul.f32 %0, %1, %2;" : "=f"(f313) : "f"(f50), "f"(f62));
  // PTX:381 mul.f32 %f314, %f49, %f64
  asm("mul.f32 %0, %1, %2;" : "=f"(f314) : "f"(f49), "f"(f64));
  // PTX:382 sub.f32 %f71, %f314, %f313
  asm("sub.f32 %0, %1, %2;" : "=f"(f71) : "f"(f314), "f"(f313));
  // PTX:383 mul.f32 %f315, %f51, %f65
  asm("mul.f32 %0, %1, %2;" : "=f"(f315) : "f"(f51), "f"(f65));
  // PTX:384 mul.f32 %f316, %f50, %f63
  asm("mul.f32 %0, %1, %2;" : "=f"(f316) : "f"(f50), "f"(f63));
  // PTX:385 sub.f32 %f317, %f316, %f315
  asm("sub.f32 %0, %1, %2;" : "=f"(f317) : "f"(f316), "f"(f315));
  // PTX:386 mul.f32 %f318, %f49, %f63
  asm("mul.f32 %0, %1, %2;" : "=f"(f318) : "f"(f49), "f"(f63));
  // PTX:387 mul.f32 %f319, %f51, %f67
  asm("mul.f32 %0, %1, %2;" : "=f"(f319) : "f"(f51), "f"(f67));
  // PTX:388 sub.f32 %f320, %f319, %f318
  asm("sub.f32 %0, %1, %2;" : "=f"(f320) : "f"(f319), "f"(f318));
  // PTX:389 mul.f32 %f321, %f50, %f67
  asm("mul.f32 %0, %1, %2;" : "=f"(f321) : "f"(f50), "f"(f67));
  // PTX:390 mul.f32 %f322, %f49, %f65
  asm("mul.f32 %0, %1, %2;" : "=f"(f322) : "f"(f49), "f"(f65));
  // PTX:391 sub.f32 %f323, %f322, %f321
  asm("sub.f32 %0, %1, %2;" : "=f"(f323) : "f"(f322), "f"(f321));
  // PTX:392 div.rn.f32 %f324, %f52, %f60
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f324) : "f"(f52), "f"(f60));
  // PTX:393 mul.f32 %f325, %f324, %f69
  asm("mul.f32 %0, %1, %2;" : "=f"(f325) : "f"(f324), "f"(f69));
  // PTX:394 mul.f32 %f326, %f324, %f70
  asm("mul.f32 %0, %1, %2;" : "=f"(f326) : "f"(f324), "f"(f70));
  // PTX:395 mul.f32 %f327, %f324, %f71
  asm("mul.f32 %0, %1, %2;" : "=f"(f327) : "f"(f324), "f"(f71));
  // PTX:396 div.rn.f32 %f328, %f56, %f61
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f328) : "f"(f56), "f"(f61));
  // PTX:397 mul.f32 %f329, %f328, %f317
  asm("mul.f32 %0, %1, %2;" : "=f"(f329) : "f"(f328), "f"(f317));
  // PTX:398 mul.f32 %f330, %f328, %f320
  asm("mul.f32 %0, %1, %2;" : "=f"(f330) : "f"(f328), "f"(f320));
  // PTX:399 mul.f32 %f331, %f328, %f323
  asm("mul.f32 %0, %1, %2;" : "=f"(f331) : "f"(f328), "f"(f323));
  // PTX:400 sub.f32 %f332, %f325, %f329
  asm("sub.f32 %0, %1, %2;" : "=f"(f332) : "f"(f325), "f"(f329));
  // PTX:401 sub.f32 %f333, %f326, %f330
  asm("sub.f32 %0, %1, %2;" : "=f"(f333) : "f"(f326), "f"(f330));
  // PTX:402 sub.f32 %f334, %f327, %f331
  asm("sub.f32 %0, %1, %2;" : "=f"(f334) : "f"(f327), "f"(f331));
  // PTX:403 div.rn.f32 %f72, %f332, %f48
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f72) : "f"(f332), "f"(f48));
  // PTX:404 div.rn.f32 %f73, %f333, %f48
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f73) : "f"(f333), "f"(f48));
  // PTX:405 div.rn.f32 %f74, %f334, %f48
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f74) : "f"(f334), "f"(f48));
  // PTX:406 neg.f32 %f335, %f317
  asm("neg.f32 %0, %1;" : "=f"(f335) : "f"(f317));
  // PTX:407 neg.f32 %f336, %f320
  asm("neg.f32 %0, %1;" : "=f"(f336) : "f"(f320));
  // PTX:408 neg.f32 %f337, %f323
  asm("neg.f32 %0, %1;" : "=f"(f337) : "f"(f323));
  // PTX:409 div.rn.f32 %f338, %f335, %f61
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f338) : "f"(f335), "f"(f61));
  // PTX:410 div.rn.f32 %f339, %f336, %f61
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f339) : "f"(f336), "f"(f61));
  // PTX:411 div.rn.f32 %f340, %f337, %f61
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f340) : "f"(f337), "f"(f61));
  // PTX:412 div.rn.f32 %f341, %f317, %f61
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f341) : "f"(f317), "f"(f61));
  // PTX:413 div.rn.f32 %f342, %f320, %f61
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f342) : "f"(f320), "f"(f61));
  // PTX:414 div.rn.f32 %f343, %f323, %f61
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f343) : "f"(f323), "f"(f61));
  // PTX:415 mul.f32 %f344, %f341, %f38
  asm("mul.f32 %0, %1, %2;" : "=f"(f344) : "f"(f341), "f"(f38));
  // PTX:416 mul.f32 %f345, %f342, %f38
  asm("mul.f32 %0, %1, %2;" : "=f"(f345) : "f"(f342), "f"(f38));
  // PTX:417 mul.f32 %f346, %f343, %f38
  asm("mul.f32 %0, %1, %2;" : "=f"(f346) : "f"(f343), "f"(f38));
  // PTX:418 fma.rn.f32 %f547, %f338, %f20, %f344
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f547) : "f"(f338), "f"(f20), "f"(f344));
  // PTX:419 fma.rn.f32 %f546, %f339, %f20, %f345
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f546) : "f"(f339), "f"(f20), "f"(f345));
  // PTX:420 fma.rn.f32 %f545, %f340, %f20, %f346
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f545) : "f"(f340), "f"(f20), "f"(f346));
  // PTX:421 mul.f32 %f347, %f341, %f39
  asm("mul.f32 %0, %1, %2;" : "=f"(f347) : "f"(f341), "f"(f39));
  // PTX:422 mul.f32 %f348, %f342, %f39
  asm("mul.f32 %0, %1, %2;" : "=f"(f348) : "f"(f342), "f"(f39));
  // PTX:423 mul.f32 %f349, %f343, %f39
  asm("mul.f32 %0, %1, %2;" : "=f"(f349) : "f"(f343), "f"(f39));
  // PTX:424 fma.rn.f32 %f544, %f338, %f24, %f347
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f544) : "f"(f338), "f"(f24), "f"(f347));
  // PTX:425 fma.rn.f32 %f543, %f339, %f24, %f348
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f543) : "f"(f339), "f"(f24), "f"(f348));
  // PTX:426 fma.rn.f32 %f542, %f340, %f24, %f349
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f542) : "f"(f340), "f"(f24), "f"(f349));
  // PTX:427 mul.f32 %f350, %f341, %f40
  asm("mul.f32 %0, %1, %2;" : "=f"(f350) : "f"(f341), "f"(f40));
  // PTX:428 mul.f32 %f351, %f342, %f40
  asm("mul.f32 %0, %1, %2;" : "=f"(f351) : "f"(f342), "f"(f40));
  // PTX:429 mul.f32 %f352, %f343, %f40
  asm("mul.f32 %0, %1, %2;" : "=f"(f352) : "f"(f343), "f"(f40));
  // PTX:430 fma.rn.f32 %f541, %f338, %f28, %f350
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f541) : "f"(f338), "f"(f28), "f"(f350));
  // PTX:431 fma.rn.f32 %f540, %f339, %f28, %f351
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f540) : "f"(f339), "f"(f28), "f"(f351));
  // PTX:432 fma.rn.f32 %f539, %f340, %f28, %f352
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f539) : "f"(f340), "f"(f28), "f"(f352));
  // PTX:433 mul.f32 %f353, %f341, %f41
  asm("mul.f32 %0, %1, %2;" : "=f"(f353) : "f"(f341), "f"(f41));
  // PTX:434 mul.f32 %f354, %f342, %f41
  asm("mul.f32 %0, %1, %2;" : "=f"(f354) : "f"(f342), "f"(f41));
  // PTX:435 mul.f32 %f355, %f343, %f41
  asm("mul.f32 %0, %1, %2;" : "=f"(f355) : "f"(f343), "f"(f41));
  // PTX:436 fma.rn.f32 %f538, %f338, %f32, %f353
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f538) : "f"(f338), "f"(f32), "f"(f353));
  // PTX:437 fma.rn.f32 %f537, %f339, %f32, %f354
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f537) : "f"(f339), "f"(f32), "f"(f354));
  // PTX:438 fma.rn.f32 %f536, %f340, %f32, %f355
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f536) : "f"(f340), "f"(f32), "f"(f355));
  // PTX:439 @%p14 bra $L__BB68_25
  if (p14) { goto L_BB68_25; }
  // PTX:441 ld.param.u64 %rd123, [_ZN7synreal6kernel38initialize_joint_coordinate_velocitiesENS0_19JointCoordinateViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_Pf_param_0+72]
  rd123 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (72))));
  // PTX:442 shl.b64 %rd122, %rd129, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd122) : "l"(rd129));
  // PTX:443 cvta.to.global.u64 %rd121, %rd123
  rd121 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd123));
  // PTX:444 add.s64 %rd120, %rd121, %rd122
  asm("add.s64 %0, %1, %2;" : "=l"(rd120) : "l"(rd121), "l"(rd122));
  // PTX:445 div.rn.f32 %f356, %f69, %f60
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f356) : "f"(f69), "f"(f60));
  // PTX:446 sub.f32 %f357, %f356, %f72
  asm("sub.f32 %0, %1, %2;" : "=f"(f357) : "f"(f356), "f"(f72));
  // PTX:447 div.rn.f32 %f358, %f70, %f60
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f358) : "f"(f70), "f"(f60));
  // PTX:448 sub.f32 %f359, %f358, %f73
  asm("sub.f32 %0, %1, %2;" : "=f"(f359) : "f"(f358), "f"(f73));
  // PTX:449 div.rn.f32 %f360, %f71, %f60
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f360) : "f"(f71), "f"(f60));
  // PTX:450 sub.f32 %f361, %f360, %f74
  asm("sub.f32 %0, %1, %2;" : "=f"(f361) : "f"(f360), "f"(f74));
  // PTX:451 neg.f32 %f362, %f69
  asm("neg.f32 %0, %1;" : "=f"(f362) : "f"(f69));
  // PTX:452 div.rn.f32 %f363, %f362, %f60
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f363) : "f"(f362), "f"(f60));
  // PTX:453 neg.f32 %f364, %f70
  asm("neg.f32 %0, %1;" : "=f"(f364) : "f"(f70));
  // PTX:454 div.rn.f32 %f365, %f364, %f60
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f365) : "f"(f364), "f"(f60));
  // PTX:455 neg.f32 %f366, %f71
  asm("neg.f32 %0, %1;" : "=f"(f366) : "f"(f71));
  // PTX:456 div.rn.f32 %f367, %f366, %f60
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f367) : "f"(f366), "f"(f60));
  // PTX:457 ld.global.f32 %f368, [%rd13]
  f368 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))));
  // PTX:458 ld.global.f32 %f369, [%rd14]
  f369 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:459 mul.f32 %f370, %f72, %f369
  asm("mul.f32 %0, %1, %2;" : "=f"(f370) : "f"(f72), "f"(f369));
  // PTX:460 mul.f32 %f371, %f73, %f369
  asm("mul.f32 %0, %1, %2;" : "=f"(f371) : "f"(f73), "f"(f369));
  // PTX:461 mul.f32 %f372, %f74, %f369
  asm("mul.f32 %0, %1, %2;" : "=f"(f372) : "f"(f74), "f"(f369));
  // PTX:462 fma.rn.f32 %f373, %f357, %f368, %f370
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f373) : "f"(f357), "f"(f368), "f"(f370));
  // PTX:463 fma.rn.f32 %f374, %f359, %f368, %f371
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f374) : "f"(f359), "f"(f368), "f"(f371));
  // PTX:464 fma.rn.f32 %f375, %f361, %f368, %f372
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f375) : "f"(f361), "f"(f368), "f"(f372));
  // PTX:465 ld.global.f32 %f376, [%rd120]
  f376 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd120) + (0)))));
  // PTX:466 fma.rn.f32 %f535, %f363, %f376, %f373
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f535) : "f"(f363), "f"(f376), "f"(f373));
  // PTX:467 fma.rn.f32 %f534, %f365, %f376, %f374
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f534) : "f"(f365), "f"(f376), "f"(f374));
  // PTX:468 fma.rn.f32 %f533, %f367, %f376, %f375
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f533) : "f"(f367), "f"(f376), "f"(f375));
  // PTX:469 ld.global.f32 %f377, [%rd13+4]
  f377 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4)))));
  // PTX:470 ld.global.f32 %f378, [%rd14+4]
  f378 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (4)))));
  // PTX:471 mul.f32 %f379, %f72, %f378
  asm("mul.f32 %0, %1, %2;" : "=f"(f379) : "f"(f72), "f"(f378));
  // PTX:472 mul.f32 %f380, %f73, %f378
  asm("mul.f32 %0, %1, %2;" : "=f"(f380) : "f"(f73), "f"(f378));
  // PTX:473 mul.f32 %f381, %f74, %f378
  asm("mul.f32 %0, %1, %2;" : "=f"(f381) : "f"(f74), "f"(f378));
  // PTX:474 fma.rn.f32 %f382, %f357, %f377, %f379
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f382) : "f"(f357), "f"(f377), "f"(f379));
  // PTX:475 fma.rn.f32 %f383, %f359, %f377, %f380
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f383) : "f"(f359), "f"(f377), "f"(f380));
  // PTX:476 fma.rn.f32 %f384, %f361, %f377, %f381
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f384) : "f"(f361), "f"(f377), "f"(f381));
  // PTX:477 ld.global.f32 %f385, [%rd120+4]
  f385 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd120) + (4)))));
  // PTX:478 fma.rn.f32 %f532, %f363, %f385, %f382
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f532) : "f"(f363), "f"(f385), "f"(f382));
  // PTX:479 fma.rn.f32 %f531, %f365, %f385, %f383
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f531) : "f"(f365), "f"(f385), "f"(f383));
  // PTX:480 fma.rn.f32 %f530, %f367, %f385, %f384
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f530) : "f"(f367), "f"(f385), "f"(f384));
  // PTX:481 ld.global.f32 %f386, [%rd13+8]
  f386 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8)))));
  // PTX:482 ld.global.f32 %f387, [%rd14+8]
  f387 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (8)))));
  // PTX:483 mul.f32 %f388, %f72, %f387
  asm("mul.f32 %0, %1, %2;" : "=f"(f388) : "f"(f72), "f"(f387));
  // PTX:484 mul.f32 %f389, %f73, %f387
  asm("mul.f32 %0, %1, %2;" : "=f"(f389) : "f"(f73), "f"(f387));
  // PTX:485 mul.f32 %f390, %f74, %f387
  asm("mul.f32 %0, %1, %2;" : "=f"(f390) : "f"(f74), "f"(f387));
  // PTX:486 fma.rn.f32 %f391, %f357, %f386, %f388
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f391) : "f"(f357), "f"(f386), "f"(f388));
  // PTX:487 fma.rn.f32 %f392, %f359, %f386, %f389
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f392) : "f"(f359), "f"(f386), "f"(f389));
  // PTX:488 fma.rn.f32 %f393, %f361, %f386, %f390
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f393) : "f"(f361), "f"(f386), "f"(f390));
  // PTX:489 ld.global.f32 %f394, [%rd120+8]
  f394 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd120) + (8)))));
  // PTX:490 fma.rn.f32 %f529, %f363, %f394, %f391
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f529) : "f"(f363), "f"(f394), "f"(f391));
  // PTX:491 fma.rn.f32 %f528, %f365, %f394, %f392
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f528) : "f"(f365), "f"(f394), "f"(f392));
  // PTX:492 fma.rn.f32 %f548, %f367, %f394, %f393
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f548) : "f"(f367), "f"(f394), "f"(f393));
  // PTX:493 ld.global.f32 %f395, [%rd13+12]
  f395 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (12)))));
  // PTX:494 ld.global.f32 %f396, [%rd14+12]
  f396 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (12)))));
  // PTX:495 mul.f32 %f397, %f72, %f396
  asm("mul.f32 %0, %1, %2;" : "=f"(f397) : "f"(f72), "f"(f396));
  // PTX:496 mul.f32 %f398, %f73, %f396
  asm("mul.f32 %0, %1, %2;" : "=f"(f398) : "f"(f73), "f"(f396));
  // PTX:497 mul.f32 %f399, %f74, %f396
  asm("mul.f32 %0, %1, %2;" : "=f"(f399) : "f"(f74), "f"(f396));
  // PTX:498 fma.rn.f32 %f400, %f357, %f395, %f397
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f400) : "f"(f357), "f"(f395), "f"(f397));
  // PTX:499 fma.rn.f32 %f401, %f359, %f395, %f398
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f401) : "f"(f359), "f"(f395), "f"(f398));
  // PTX:500 fma.rn.f32 %f402, %f361, %f395, %f399
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f402) : "f"(f361), "f"(f395), "f"(f399));
  // PTX:501 ld.global.f32 %f403, [%rd120+12]
  f403 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd120) + (12)))));
  // PTX:502 fma.rn.f32 %f549, %f363, %f403, %f400
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f549) : "f"(f363), "f"(f403), "f"(f400));
  // PTX:503 fma.rn.f32 %f550, %f365, %f403, %f401
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f550) : "f"(f365), "f"(f403), "f"(f401));
  // PTX:504 fma.rn.f32 %f551, %f367, %f403, %f402
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f551) : "f"(f367), "f"(f403), "f"(f402));
  // PTX:505 bra.uni $L__BB68_25
  goto L_BB68_25;
  // PTX:507 $L__BB68_16:
L_BB68_16:;
  // PTX:508 mov.f32 %f555, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f555) : );
  // PTX:509 sub.f32 %f99, %f513, %f516
  asm("sub.f32 %0, %1, %2;" : "=f"(f99) : "f"(f513), "f"(f516));
  // PTX:510 sub.f32 %f100, %f514, %f517
  asm("sub.f32 %0, %1, %2;" : "=f"(f100) : "f"(f514), "f"(f517));
  // PTX:511 mul.f32 %f405, %f100, %f100
  asm("mul.f32 %0, %1, %2;" : "=f"(f405) : "f"(f100), "f"(f100));
  // PTX:512 sub.f32 %f101, %f515, %f518
  asm("sub.f32 %0, %1, %2;" : "=f"(f101) : "f"(f515), "f"(f518));
  // PTX:513 fma.rn.f32 %f406, %f99, %f99, %f405
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f406) : "f"(f99), "f"(f99), "f"(f405));
  // PTX:514 fma.rn.f32 %f407, %f101, %f101, %f406
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f407) : "f"(f101), "f"(f101), "f"(f406));
  // PTX:515 sqrt.rn.f32 %f102, %f407
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f102) : "f"(f407));
  // PTX:516 setp.le.f32 %p15, %f102, 0f322BCC77
  p15 = (!(isnan(((float)(f102))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f102)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:517 @%p15 bra $L__BB68_33
  if (p15) { goto L_BB68_33; }
  // PTX:519 cvt.u32.u64 %r38, %rd12
  asm("cvt.u32.u64 %0, %1;" : "=r"(r38) : "l"(rd12));
  // PTX:520 setp.lt.s32 %p16, %r38, 0
  p16 = (((int)(r38)) < ((int)(0)));
  // PTX:521 sub.f32 %f409, %f35, %f516
  asm("sub.f32 %0, %1, %2;" : "=f"(f409) : "f"(f35), "f"(f516));
  // PTX:522 div.rn.f32 %f103, %f99, %f102
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f103) : "f"(f99), "f"(f102));
  // PTX:523 sub.f32 %f410, %f36, %f517
  asm("sub.f32 %0, %1, %2;" : "=f"(f410) : "f"(f36), "f"(f517));
  // PTX:524 div.rn.f32 %f104, %f100, %f102
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f104) : "f"(f100), "f"(f102));
  // PTX:525 mul.f32 %f411, %f410, %f104
  asm("mul.f32 %0, %1, %2;" : "=f"(f411) : "f"(f410), "f"(f104));
  // PTX:526 sub.f32 %f412, %f37, %f518
  asm("sub.f32 %0, %1, %2;" : "=f"(f412) : "f"(f37), "f"(f518));
  // PTX:527 div.rn.f32 %f105, %f101, %f102
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f105) : "f"(f101), "f"(f102));
  // PTX:528 fma.rn.f32 %f413, %f409, %f103, %f411
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f413) : "f"(f409), "f"(f103), "f"(f411));
  // PTX:529 fma.rn.f32 %f414, %f412, %f105, %f413
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f414) : "f"(f412), "f"(f105), "f"(f413));
  // PTX:530 mul.f32 %f415, %f103, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f415) : "f"(f103), "f"(f414));
  // PTX:531 mul.f32 %f416, %f104, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f416) : "f"(f104), "f"(f414));
  // PTX:532 mul.f32 %f417, %f105, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f417) : "f"(f105), "f"(f414));
  // PTX:533 sub.f32 %f418, %f409, %f415
  asm("sub.f32 %0, %1, %2;" : "=f"(f418) : "f"(f409), "f"(f415));
  // PTX:534 sub.f32 %f419, %f410, %f416
  asm("sub.f32 %0, %1, %2;" : "=f"(f419) : "f"(f410), "f"(f416));
  // PTX:535 sub.f32 %f420, %f412, %f417
  asm("sub.f32 %0, %1, %2;" : "=f"(f420) : "f"(f412), "f"(f417));
  // PTX:536 div.rn.f32 %f106, %f418, %f102
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f106) : "f"(f418), "f"(f102));
  // PTX:537 div.rn.f32 %f107, %f419, %f102
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f107) : "f"(f419), "f"(f102));
  // PTX:538 div.rn.f32 %f108, %f420, %f102
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f108) : "f"(f420), "f"(f102));
  // PTX:539 add.f32 %f109, %f103, %f106
  asm("add.f32 %0, %1, %2;" : "=f"(f109) : "f"(f103), "f"(f106));
  // PTX:540 add.f32 %f110, %f104, %f107
  asm("add.f32 %0, %1, %2;" : "=f"(f110) : "f"(f104), "f"(f107));
  // PTX:541 add.f32 %f111, %f105, %f108
  asm("add.f32 %0, %1, %2;" : "=f"(f111) : "f"(f105), "f"(f108));
  // PTX:542 @%p16 bra $L__BB68_19
  if (p16) { goto L_BB68_19; }
  // PTX:544 ld.global.f32 %f421, [%rd13]
  f421 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))));
  // PTX:545 mul.f32 %f422, %f109, %f421
  asm("mul.f32 %0, %1, %2;" : "=f"(f422) : "f"(f109), "f"(f421));
  // PTX:546 mul.f32 %f423, %f110, %f421
  asm("mul.f32 %0, %1, %2;" : "=f"(f423) : "f"(f110), "f"(f421));
  // PTX:547 mul.f32 %f424, %f111, %f421
  asm("mul.f32 %0, %1, %2;" : "=f"(f424) : "f"(f111), "f"(f421));
  // PTX:548 ld.global.f32 %f425, [%rd14]
  f425 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:549 mul.f32 %f426, %f106, %f425
  asm("mul.f32 %0, %1, %2;" : "=f"(f426) : "f"(f106), "f"(f425));
  // PTX:550 mul.f32 %f427, %f107, %f425
  asm("mul.f32 %0, %1, %2;" : "=f"(f427) : "f"(f107), "f"(f425));
  // PTX:551 mul.f32 %f428, %f108, %f425
  asm("mul.f32 %0, %1, %2;" : "=f"(f428) : "f"(f108), "f"(f425));
  // PTX:552 sub.f32 %f535, %f426, %f422
  asm("sub.f32 %0, %1, %2;" : "=f"(f535) : "f"(f426), "f"(f422));
  // PTX:553 sub.f32 %f534, %f427, %f423
  asm("sub.f32 %0, %1, %2;" : "=f"(f534) : "f"(f427), "f"(f423));
  // PTX:554 sub.f32 %f533, %f428, %f424
  asm("sub.f32 %0, %1, %2;" : "=f"(f533) : "f"(f428), "f"(f424));
  // PTX:556 $L__BB68_19:
L_BB68_19:;
  // PTX:557 @%p16 bra $L__BB68_21
  if (p16) { goto L_BB68_21; }
  // PTX:559 ld.global.f32 %f430, [%rd13+4]
  f430 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4)))));
  // PTX:560 mul.f32 %f431, %f109, %f430
  asm("mul.f32 %0, %1, %2;" : "=f"(f431) : "f"(f109), "f"(f430));
  // PTX:561 mul.f32 %f432, %f110, %f430
  asm("mul.f32 %0, %1, %2;" : "=f"(f432) : "f"(f110), "f"(f430));
  // PTX:562 mul.f32 %f433, %f111, %f430
  asm("mul.f32 %0, %1, %2;" : "=f"(f433) : "f"(f111), "f"(f430));
  // PTX:563 ld.global.f32 %f434, [%rd14+4]
  f434 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (4)))));
  // PTX:564 mul.f32 %f435, %f106, %f434
  asm("mul.f32 %0, %1, %2;" : "=f"(f435) : "f"(f106), "f"(f434));
  // PTX:565 mul.f32 %f436, %f107, %f434
  asm("mul.f32 %0, %1, %2;" : "=f"(f436) : "f"(f107), "f"(f434));
  // PTX:566 mul.f32 %f437, %f108, %f434
  asm("mul.f32 %0, %1, %2;" : "=f"(f437) : "f"(f108), "f"(f434));
  // PTX:567 sub.f32 %f532, %f435, %f431
  asm("sub.f32 %0, %1, %2;" : "=f"(f532) : "f"(f435), "f"(f431));
  // PTX:568 sub.f32 %f531, %f436, %f432
  asm("sub.f32 %0, %1, %2;" : "=f"(f531) : "f"(f436), "f"(f432));
  // PTX:569 sub.f32 %f530, %f437, %f433
  asm("sub.f32 %0, %1, %2;" : "=f"(f530) : "f"(f437), "f"(f433));
  // PTX:571 $L__BB68_21:
L_BB68_21:;
  // PTX:572 @%p16 bra $L__BB68_23
  if (p16) { goto L_BB68_23; }
  // PTX:574 ld.global.f32 %f439, [%rd13+8]
  f439 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8)))));
  // PTX:575 mul.f32 %f440, %f109, %f439
  asm("mul.f32 %0, %1, %2;" : "=f"(f440) : "f"(f109), "f"(f439));
  // PTX:576 mul.f32 %f441, %f110, %f439
  asm("mul.f32 %0, %1, %2;" : "=f"(f441) : "f"(f110), "f"(f439));
  // PTX:577 mul.f32 %f442, %f111, %f439
  asm("mul.f32 %0, %1, %2;" : "=f"(f442) : "f"(f111), "f"(f439));
  // PTX:578 ld.global.f32 %f443, [%rd14+8]
  f443 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (8)))));
  // PTX:579 mul.f32 %f444, %f106, %f443
  asm("mul.f32 %0, %1, %2;" : "=f"(f444) : "f"(f106), "f"(f443));
  // PTX:580 mul.f32 %f445, %f107, %f443
  asm("mul.f32 %0, %1, %2;" : "=f"(f445) : "f"(f107), "f"(f443));
  // PTX:581 mul.f32 %f446, %f108, %f443
  asm("mul.f32 %0, %1, %2;" : "=f"(f446) : "f"(f108), "f"(f443));
  // PTX:582 sub.f32 %f529, %f444, %f440
  asm("sub.f32 %0, %1, %2;" : "=f"(f529) : "f"(f444), "f"(f440));
  // PTX:583 sub.f32 %f528, %f445, %f441
  asm("sub.f32 %0, %1, %2;" : "=f"(f528) : "f"(f445), "f"(f441));
  // PTX:584 sub.f32 %f548, %f446, %f442
  asm("sub.f32 %0, %1, %2;" : "=f"(f548) : "f"(f446), "f"(f442));
  // PTX:586 $L__BB68_23:
L_BB68_23:;
  // PTX:587 mul.f32 %f547, %f103, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f547) : "f"(f103), "f"(f20));
  // PTX:588 mul.f32 %f546, %f104, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f546) : "f"(f104), "f"(f20));
  // PTX:589 mul.f32 %f545, %f105, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f545) : "f"(f105), "f"(f20));
  // PTX:590 mul.f32 %f544, %f103, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f544) : "f"(f103), "f"(f24));
  // PTX:591 mul.f32 %f543, %f104, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f543) : "f"(f104), "f"(f24));
  // PTX:592 mul.f32 %f542, %f105, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f542) : "f"(f105), "f"(f24));
  // PTX:593 mul.f32 %f541, %f103, %f28
  asm("mul.f32 %0, %1, %2;" : "=f"(f541) : "f"(f103), "f"(f28));
  // PTX:594 mul.f32 %f540, %f104, %f28
  asm("mul.f32 %0, %1, %2;" : "=f"(f540) : "f"(f104), "f"(f28));
  // PTX:595 mul.f32 %f539, %f105, %f28
  asm("mul.f32 %0, %1, %2;" : "=f"(f539) : "f"(f105), "f"(f28));
  // PTX:596 mul.f32 %f538, %f103, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f538) : "f"(f103), "f"(f32));
  // PTX:597 mul.f32 %f537, %f104, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f537) : "f"(f104), "f"(f32));
  // PTX:598 mul.f32 %f536, %f105, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f536) : "f"(f105), "f"(f32));
  // PTX:599 @%p16 bra $L__BB68_25
  if (p16) { goto L_BB68_25; }
  // PTX:601 ld.global.f32 %f448, [%rd13+12]
  f448 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (12)))));
  // PTX:602 mul.f32 %f449, %f109, %f448
  asm("mul.f32 %0, %1, %2;" : "=f"(f449) : "f"(f109), "f"(f448));
  // PTX:603 mul.f32 %f450, %f110, %f448
  asm("mul.f32 %0, %1, %2;" : "=f"(f450) : "f"(f110), "f"(f448));
  // PTX:604 mul.f32 %f451, %f111, %f448
  asm("mul.f32 %0, %1, %2;" : "=f"(f451) : "f"(f111), "f"(f448));
  // PTX:605 ld.global.f32 %f452, [%rd14+12]
  f452 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (12)))));
  // PTX:606 mul.f32 %f453, %f106, %f452
  asm("mul.f32 %0, %1, %2;" : "=f"(f453) : "f"(f106), "f"(f452));
  // PTX:607 mul.f32 %f454, %f107, %f452
  asm("mul.f32 %0, %1, %2;" : "=f"(f454) : "f"(f107), "f"(f452));
  // PTX:608 mul.f32 %f455, %f108, %f452
  asm("mul.f32 %0, %1, %2;" : "=f"(f455) : "f"(f108), "f"(f452));
  // PTX:609 sub.f32 %f549, %f453, %f449
  asm("sub.f32 %0, %1, %2;" : "=f"(f549) : "f"(f453), "f"(f449));
  // PTX:610 sub.f32 %f550, %f454, %f450
  asm("sub.f32 %0, %1, %2;" : "=f"(f550) : "f"(f454), "f"(f450));
  // PTX:611 sub.f32 %f551, %f455, %f451
  asm("sub.f32 %0, %1, %2;" : "=f"(f551) : "f"(f455), "f"(f451));
  // PTX:613 $L__BB68_25:
L_BB68_25:;
  // PTX:614 cvt.u32.u64 %r42, %rd12
  asm("cvt.u32.u64 %0, %1;" : "=r"(r42) : "l"(rd12));
  // PTX:615 setp.lt.s32 %p20, %r42, 0
  p20 = (((int)(r42)) < ((int)(0)));
  // PTX:616 mul.lo.s64 %rd99, %rd24, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd99) : "l"(rd24));
  // PTX:617 add.s64 %rd100, %rd1, %rd99
  asm("add.s64 %0, %1, %2;" : "=l"(rd100) : "l"(rd1), "l"(rd99));
  // PTX:618 ld.global.f32 %f456, [%rd100]
  f456 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (0)))));
  // PTX:619 ld.global.f32 %f457, [%rd100+4]
  f457 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (4)))));
  // PTX:620 mul.f32 %f458, %f546, %f457
  asm("mul.f32 %0, %1, %2;" : "=f"(f458) : "f"(f546), "f"(f457));
  // PTX:621 ld.global.f32 %f459, [%rd100+8]
  f459 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (8)))));
  // PTX:622 fma.rn.f32 %f460, %f547, %f456, %f458
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f460) : "f"(f547), "f"(f456), "f"(f458));
  // PTX:623 fma.rn.f32 %f461, %f545, %f459, %f460
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f461) : "f"(f545), "f"(f459), "f"(f460));
  // PTX:624 add.f32 %f552, %f461, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f552) : "f"(f461));
  // PTX:625 @%p20 bra $L__BB68_27
  if (p20) { goto L_BB68_27; }
  // PTX:627 mul.lo.s64 %rd101, %rd133, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd101) : "l"(rd133));
  // PTX:628 add.s64 %rd102, %rd1, %rd101
  asm("add.s64 %0, %1, %2;" : "=l"(rd102) : "l"(rd1), "l"(rd101));
  // PTX:629 ld.global.f32 %f462, [%rd102]
  f462 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd102) + (0)))));
  // PTX:630 ld.global.f32 %f463, [%rd102+4]
  f463 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd102) + (4)))));
  // PTX:631 mul.f32 %f464, %f534, %f463
  asm("mul.f32 %0, %1, %2;" : "=f"(f464) : "f"(f534), "f"(f463));
  // PTX:632 ld.global.f32 %f465, [%rd102+8]
  f465 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd102) + (8)))));
  // PTX:633 fma.rn.f32 %f466, %f535, %f462, %f464
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f466) : "f"(f535), "f"(f462), "f"(f464));
  // PTX:634 fma.rn.f32 %f467, %f533, %f465, %f466
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f467) : "f"(f533), "f"(f465), "f"(f466));
  // PTX:635 add.f32 %f552, %f552, %f467
  asm("add.f32 %0, %1, %2;" : "=f"(f552) : "f"(f552), "f"(f467));
  // PTX:637 $L__BB68_27:
L_BB68_27:;
  // PTX:638 mul.lo.s64 %rd103, %rd25, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd103) : "l"(rd25));
  // PTX:639 add.s64 %rd104, %rd1, %rd103
  asm("add.s64 %0, %1, %2;" : "=l"(rd104) : "l"(rd1), "l"(rd103));
  // PTX:640 ld.global.f32 %f468, [%rd104]
  f468 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd104) + (0)))));
  // PTX:641 ld.global.f32 %f469, [%rd104+4]
  f469 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd104) + (4)))));
  // PTX:642 mul.f32 %f470, %f543, %f469
  asm("mul.f32 %0, %1, %2;" : "=f"(f470) : "f"(f543), "f"(f469));
  // PTX:643 ld.global.f32 %f471, [%rd104+8]
  f471 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd104) + (8)))));
  // PTX:644 fma.rn.f32 %f472, %f544, %f468, %f470
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f472) : "f"(f544), "f"(f468), "f"(f470));
  // PTX:645 fma.rn.f32 %f473, %f542, %f471, %f472
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f473) : "f"(f542), "f"(f471), "f"(f472));
  // PTX:646 add.f32 %f553, %f552, %f473
  asm("add.f32 %0, %1, %2;" : "=f"(f553) : "f"(f552), "f"(f473));
  // PTX:647 @%p20 bra $L__BB68_29
  if (p20) { goto L_BB68_29; }
  // PTX:649 mul.lo.s64 %rd105, %rd132, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd105) : "l"(rd132));
  // PTX:650 add.s64 %rd106, %rd1, %rd105
  asm("add.s64 %0, %1, %2;" : "=l"(rd106) : "l"(rd1), "l"(rd105));
  // PTX:651 ld.global.f32 %f474, [%rd106]
  f474 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (0)))));
  // PTX:652 ld.global.f32 %f475, [%rd106+4]
  f475 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (4)))));
  // PTX:653 mul.f32 %f476, %f531, %f475
  asm("mul.f32 %0, %1, %2;" : "=f"(f476) : "f"(f531), "f"(f475));
  // PTX:654 ld.global.f32 %f477, [%rd106+8]
  f477 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (8)))));
  // PTX:655 fma.rn.f32 %f478, %f532, %f474, %f476
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f478) : "f"(f532), "f"(f474), "f"(f476));
  // PTX:656 fma.rn.f32 %f479, %f530, %f477, %f478
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f479) : "f"(f530), "f"(f477), "f"(f478));
  // PTX:657 add.f32 %f553, %f553, %f479
  asm("add.f32 %0, %1, %2;" : "=f"(f553) : "f"(f553), "f"(f479));
  // PTX:659 $L__BB68_29:
L_BB68_29:;
  // PTX:660 mul.lo.s64 %rd107, %rd26, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd107) : "l"(rd26));
  // PTX:661 add.s64 %rd108, %rd1, %rd107
  asm("add.s64 %0, %1, %2;" : "=l"(rd108) : "l"(rd1), "l"(rd107));
  // PTX:662 ld.global.f32 %f480, [%rd108]
  f480 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd108) + (0)))));
  // PTX:663 ld.global.f32 %f481, [%rd108+4]
  f481 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd108) + (4)))));
  // PTX:664 mul.f32 %f482, %f540, %f481
  asm("mul.f32 %0, %1, %2;" : "=f"(f482) : "f"(f540), "f"(f481));
  // PTX:665 ld.global.f32 %f483, [%rd108+8]
  f483 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd108) + (8)))));
  // PTX:666 fma.rn.f32 %f484, %f541, %f480, %f482
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f484) : "f"(f541), "f"(f480), "f"(f482));
  // PTX:667 fma.rn.f32 %f485, %f539, %f483, %f484
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f485) : "f"(f539), "f"(f483), "f"(f484));
  // PTX:668 add.f32 %f554, %f553, %f485
  asm("add.f32 %0, %1, %2;" : "=f"(f554) : "f"(f553), "f"(f485));
  // PTX:669 @%p20 bra $L__BB68_31
  if (p20) { goto L_BB68_31; }
  // PTX:671 mul.lo.s64 %rd109, %rd131, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd109) : "l"(rd131));
  // PTX:672 add.s64 %rd110, %rd1, %rd109
  asm("add.s64 %0, %1, %2;" : "=l"(rd110) : "l"(rd1), "l"(rd109));
  // PTX:673 ld.global.f32 %f486, [%rd110]
  f486 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd110) + (0)))));
  // PTX:674 ld.global.f32 %f487, [%rd110+4]
  f487 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd110) + (4)))));
  // PTX:675 mul.f32 %f488, %f528, %f487
  asm("mul.f32 %0, %1, %2;" : "=f"(f488) : "f"(f528), "f"(f487));
  // PTX:676 ld.global.f32 %f489, [%rd110+8]
  f489 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd110) + (8)))));
  // PTX:677 fma.rn.f32 %f490, %f529, %f486, %f488
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f490) : "f"(f529), "f"(f486), "f"(f488));
  // PTX:678 fma.rn.f32 %f491, %f548, %f489, %f490
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f491) : "f"(f548), "f"(f489), "f"(f490));
  // PTX:679 add.f32 %f554, %f554, %f491
  asm("add.f32 %0, %1, %2;" : "=f"(f554) : "f"(f554), "f"(f491));
  // PTX:681 $L__BB68_31:
L_BB68_31:;
  // PTX:682 mul.lo.s64 %rd111, %rd27, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd111) : "l"(rd27));
  // PTX:683 add.s64 %rd112, %rd1, %rd111
  asm("add.s64 %0, %1, %2;" : "=l"(rd112) : "l"(rd1), "l"(rd111));
  // PTX:684 ld.global.f32 %f492, [%rd112]
  f492 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd112) + (0)))));
  // PTX:685 ld.global.f32 %f493, [%rd112+4]
  f493 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd112) + (4)))));
  // PTX:686 mul.f32 %f494, %f537, %f493
  asm("mul.f32 %0, %1, %2;" : "=f"(f494) : "f"(f537), "f"(f493));
  // PTX:687 ld.global.f32 %f495, [%rd112+8]
  f495 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd112) + (8)))));
  // PTX:688 fma.rn.f32 %f496, %f538, %f492, %f494
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f496) : "f"(f538), "f"(f492), "f"(f494));
  // PTX:689 fma.rn.f32 %f497, %f536, %f495, %f496
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f497) : "f"(f536), "f"(f495), "f"(f496));
  // PTX:690 add.f32 %f555, %f554, %f497
  asm("add.f32 %0, %1, %2;" : "=f"(f555) : "f"(f554), "f"(f497));
  // PTX:691 @%p20 bra $L__BB68_33
  if (p20) { goto L_BB68_33; }
  // PTX:693 mul.lo.s64 %rd113, %rd130, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd113) : "l"(rd130));
  // PTX:694 add.s64 %rd114, %rd1, %rd113
  asm("add.s64 %0, %1, %2;" : "=l"(rd114) : "l"(rd1), "l"(rd113));
  // PTX:695 ld.global.f32 %f498, [%rd114]
  f498 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd114) + (0)))));
  // PTX:696 ld.global.f32 %f499, [%rd114+4]
  f499 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd114) + (4)))));
  // PTX:697 mul.f32 %f500, %f550, %f499
  asm("mul.f32 %0, %1, %2;" : "=f"(f500) : "f"(f550), "f"(f499));
  // PTX:698 ld.global.f32 %f501, [%rd114+8]
  f501 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd114) + (8)))));
  // PTX:699 fma.rn.f32 %f502, %f549, %f498, %f500
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f502) : "f"(f549), "f"(f498), "f"(f500));
  // PTX:700 fma.rn.f32 %f503, %f551, %f501, %f502
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f503) : "f"(f551), "f"(f501), "f"(f502));
  // PTX:701 add.f32 %f555, %f555, %f503
  asm("add.f32 %0, %1, %2;" : "=f"(f555) : "f"(f555), "f"(f503));
  // PTX:703 $L__BB68_33:
L_BB68_33:;
  // PTX:704 ld.param.u64 %rd127, [_ZN7synreal6kernel38initialize_joint_coordinate_velocitiesENS0_19JointCoordinateViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_Pf_param_3]
  rd127 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:705 mov.u32 %r48, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r48) : "r"(blockDim.x));
  // PTX:706 mov.u32 %r47, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r47) : "r"(blockIdx.x));
  // PTX:707 mov.u32 %r46, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r46) : "r"(threadIdx.x));
  // PTX:708 cvt.u64.u32 %rd126, %r46
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd126) : "r"(r46));
  // PTX:709 mul.wide.u32 %rd125, %r47, %r48
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd125) : "r"(r47), "r"(r48));
  // PTX:710 add.s64 %rd124, %rd125, %rd126
  asm("add.s64 %0, %1, %2;" : "=l"(rd124) : "l"(rd125), "l"(rd126));
  // PTX:711 cvta.to.global.u64 %rd115, %rd127
  rd115 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd127));
  // PTX:712 shl.b64 %rd116, %rd124, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd116) : "l"(rd124));
  // PTX:713 add.s64 %rd117, %rd115, %rd116
  asm("add.s64 %0, %1, %2;" : "=l"(rd117) : "l"(rd115), "l"(rd116));
  // PTX:714 st.global.f32 [%rd117], %f555
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd117) + (0))))) = (float)(f555);
  // PTX:716 $L__BB68_34:
L_BB68_34:;
  // PTX:717 ret
  return;
}
