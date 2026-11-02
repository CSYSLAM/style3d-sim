// 机械还原自 PTX：synreal::self_collision_kernel::accumulate_vertex_face(glm::vec<3, float, (glm::qualifier)0> const*, int const*, float const*, glm::vec<3, int, (glm::qualifier)0> const*, int const*, int const*, float const*, float, float, bool, float, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, synreal::SelfCollisionContactTangent*, unsigned int*, unsigned long, unsigned long, unsigned long, int)
// PTX SHA256: fe177f506840a048913c9fe85798e08612910b8ecfd9c12ce9df91defa1607b9
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__self_collision_kernel__accumulate_vertex_face(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, float param7, float param8, unsigned char param9, float param10, unsigned long long param11, unsigned long long param12, unsigned long long param13, unsigned long long param14, unsigned long long param15, unsigned long long param16, unsigned long long param17, unsigned param18) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57, p58, p59, p60, p61, p62, p63, p64, p65, p66, p67, p68, p69, p70, p71, p72, p73;
  unsigned short rs0, rs1, rs2, rs3, rs4, rs5, rs6, rs7, rs8, rs9, rs10, rs11, rs12, rs13, rs14, rs15, rs16, rs17, rs18, rs19, rs20, rs21, rs22, rs23, rs24, rs25, rs26, rs27, rs28, rs29, rs30, rs31, rs32, rs33, rs34, rs35, rs36, rs37, rs38, rs39, rs40, rs41, rs42, rs43, rs44, rs45, rs46, rs47, rs48, rs49, rs50;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135;
  // PTX:36 ld.param.u64 %rd32, [_ZN7synreal21self_collision_kernel22accumulate_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_S8_SA_ffbfPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_0]
  rd32 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:37 ld.param.u64 %rd23, [_ZN7synreal21self_collision_kernel22accumulate_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_S8_SA_ffbfPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_1]
  rd23 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:38 ld.param.u64 %rd24, [_ZN7synreal21self_collision_kernel22accumulate_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_S8_SA_ffbfPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_2]
  rd24 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:39 ld.param.u64 %rd25, [_ZN7synreal21self_collision_kernel22accumulate_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_S8_SA_ffbfPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_3]
  rd25 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:40 ld.param.u64 %rd26, [_ZN7synreal21self_collision_kernel22accumulate_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_S8_SA_ffbfPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_4]
  rd26 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:41 ld.param.u64 %rd27, [_ZN7synreal21self_collision_kernel22accumulate_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_S8_SA_ffbfPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_5]
  rd27 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:42 ld.param.u64 %rd33, [_ZN7synreal21self_collision_kernel22accumulate_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_S8_SA_ffbfPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_6]
  rd33 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:43 ld.param.f32 %f365, [_ZN7synreal21self_collision_kernel22accumulate_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_S8_SA_ffbfPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_7]
  f365 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param7 + (0))));
  // PTX:44 ld.param.f32 %f122, [_ZN7synreal21self_collision_kernel22accumulate_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_S8_SA_ffbfPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_8]
  f122 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param8 + (0))));
  // PTX:45 ld.param.f32 %f123, [_ZN7synreal21self_collision_kernel22accumulate_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_S8_SA_ffbfPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_10]
  f123 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param10 + (0))));
  // PTX:46 ld.param.u64 %rd34, [_ZN7synreal21self_collision_kernel22accumulate_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_S8_SA_ffbfPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_11]
  rd34 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:47 ld.param.u64 %rd35, [_ZN7synreal21self_collision_kernel22accumulate_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_S8_SA_ffbfPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_12]
  rd35 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:48 ld.param.u64 %rd28, [_ZN7synreal21self_collision_kernel22accumulate_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_S8_SA_ffbfPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_13]
  rd28 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:49 ld.param.u64 %rd29, [_ZN7synreal21self_collision_kernel22accumulate_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_S8_SA_ffbfPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_14]
  rd29 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:50 ld.param.u64 %rd36, [_ZN7synreal21self_collision_kernel22accumulate_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_S8_SA_ffbfPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_15]
  rd36 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param15 + (0))));
  // PTX:51 ld.param.u64 %rd30, [_ZN7synreal21self_collision_kernel22accumulate_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_S8_SA_ffbfPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_16]
  rd30 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param16 + (0))));
  // PTX:52 ld.param.u64 %rd31, [_ZN7synreal21self_collision_kernel22accumulate_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_S8_SA_ffbfPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_17]
  rd31 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param17 + (0))));
  // PTX:53 ld.param.u32 %r30, [_ZN7synreal21self_collision_kernel22accumulate_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_S8_SA_ffbfPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_18]
  r30 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param18 + (0))));
  // PTX:54 cvta.to.global.u64 %rd1, %rd35
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd35));
  // PTX:55 cvta.to.global.u64 %rd2, %rd34
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd34));
  // PTX:56 cvta.to.global.u64 %rd3, %rd33
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd33));
  // PTX:57 cvta.to.global.u64 %rd4, %rd32
  rd4 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd32));
  // PTX:58 mov.u32 %r31, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r31) : "r"(blockIdx.x));
  // PTX:59 mov.u32 %r32, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r32) : "r"(blockDim.x));
  // PTX:60 mul.wide.u32 %rd37, %r31, %r32
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd37) : "r"(r31), "r"(r32));
  // PTX:61 mov.u32 %r33, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r33) : "r"(threadIdx.x));
  // PTX:62 cvt.u64.u32 %rd38, %r33
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd38) : "r"(r33));
  // PTX:63 add.s64 %rd5, %rd37, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd5) : "l"(rd37), "l"(rd38));
  // PTX:64 setp.ge.u64 %p1, %rd5, %rd36
  p1 = (((unsigned long long)(rd5)) >= ((unsigned long long)(rd36)));
  // PTX:65 @%p1 bra $L__BB8_69
  if (p1) { goto L_BB8_69; }
  // PTX:67 or.b64 %rd39, %rd5, %rd30
  asm("or.b64 %0, %1, %2;" : "=l"(rd39) : "l"(rd5), "l"(rd30));
  // PTX:68 and.b64 %rd40, %rd39, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd40) : "l"(rd39));
  // PTX:69 setp.eq.s64 %p2, %rd40, 0
  p2 = (((long long)(rd40)) == ((long long)(0)));
  // PTX:70 @%p2 bra $L__BB8_3
  if (p2) { goto L_BB8_3; }
  // PTX:72 div.u64 %rd134, %rd5, %rd30
  asm("div.u64 %0, %1, %2;" : "=l"(rd134) : "l"(rd5), "l"(rd30));
  // PTX:73 mul.lo.s64 %rd41, %rd134, %rd30
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd41) : "l"(rd134), "l"(rd30));
  // PTX:74 sub.s64 %rd135, %rd5, %rd41
  asm("sub.s64 %0, %1, %2;" : "=l"(rd135) : "l"(rd5), "l"(rd41));
  // PTX:75 bra.uni $L__BB8_4
  goto L_BB8_4;
  // PTX:77 $L__BB8_3:
L_BB8_3:;
  // PTX:78 cvt.u32.u64 %r34, %rd30
  asm("cvt.u32.u64 %0, %1;" : "=r"(r34) : "l"(rd30));
  // PTX:79 cvt.u32.u64 %r35, %rd5
  asm("cvt.u32.u64 %0, %1;" : "=r"(r35) : "l"(rd5));
  // PTX:80 div.u32 %r36, %r35, %r34
  asm("div.u32 %0, %1, %2;" : "=r"(r36) : "r"(r35), "r"(r34));
  // PTX:81 mul.lo.s32 %r37, %r36, %r34
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r37) : "r"(r36), "r"(r34));
  // PTX:82 sub.s32 %r38, %r35, %r37
  asm("sub.s32 %0, %1, %2;" : "=r"(r38) : "r"(r35), "r"(r37));
  // PTX:83 cvt.u64.u32 %rd134, %r36
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd134) : "r"(r36));
  // PTX:84 cvt.u64.u32 %rd135, %r38
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd135) : "r"(r38));
  // PTX:86 $L__BB8_4:
L_BB8_4:;
  // PTX:87 mul.lo.s64 %rd42, %rd134, %rd31
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd42) : "l"(rd134), "l"(rd31));
  // PTX:88 cvt.u32.u64 %r1, %rd42
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd42));
  // PTX:89 cvta.to.global.u64 %rd43, %rd23
  rd43 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd23));
  // PTX:90 shl.b64 %rd44, %rd135, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd44) : "l"(rd135));
  // PTX:91 add.s64 %rd45, %rd43, %rd44
  asm("add.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd43), "l"(rd44));
  // PTX:92 ld.global.u32 %r39, [%rd45]
  r39 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))));
  // PTX:93 cvt.s64.s32 %rd12, %r39
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd12) : "r"(r39));
  // PTX:94 add.s32 %r2, %r39, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r2) : "r"(r39), "r"(r1));
  // PTX:95 mul.wide.s32 %rd46, %r2, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd46) : "r"(r2));
  // PTX:96 add.s64 %rd47, %rd4, %rd46
  asm("add.s64 %0, %1, %2;" : "=l"(rd47) : "l"(rd4), "l"(rd46));
  // PTX:97 ld.global.f32 %f1, [%rd47]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))));
  // PTX:98 ld.global.f32 %f2, [%rd47+4]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (4)))));
  // PTX:99 ld.global.f32 %f3, [%rd47+8]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (8)))));
  // PTX:100 mul.wide.s32 %rd48, %r2, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd48) : "r"(r2));
  // PTX:101 add.s64 %rd49, %rd3, %rd48
  asm("add.s64 %0, %1, %2;" : "=l"(rd49) : "l"(rd3), "l"(rd48));
  // PTX:102 ld.global.f32 %f4, [%rd49]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))));
  // PTX:103 setp.eq.s64 %p3, %rd24, 0
  p3 = (((long long)(rd24)) == ((long long)(0)));
  // PTX:104 @%p3 bra $L__BB8_6
  if (p3) { goto L_BB8_6; }
  // PTX:106 cvta.to.global.u64 %rd50, %rd24
  rd50 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd24));
  // PTX:107 shl.b64 %rd51, %rd12, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd51) : "l"(rd12));
  // PTX:108 add.s64 %rd52, %rd50, %rd51
  asm("add.s64 %0, %1, %2;" : "=l"(rd52) : "l"(rd50), "l"(rd51));
  // PTX:109 ld.global.f32 %f365, [%rd52]
  f365 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))));
  // PTX:111 $L__BB8_6:
L_BB8_6:;
  // PTX:112 add.f32 %f7, %f365, %f122
  asm("add.f32 %0, %1, %2;" : "=f"(f7) : "f"(f365), "f"(f122));
  // PTX:113 abs.f32 %f124, %f1
  asm("abs.f32 %0, %1;" : "=f"(f124) : "f"(f1));
  // PTX:114 setp.geu.f32 %p4, %f124, 0f7F800000
  p4 = ((isnan(((float)(f124))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f124)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:115 @%p4 bra $L__BB8_69
  if (p4) { goto L_BB8_69; }
  // PTX:117 abs.f32 %f125, %f2
  asm("abs.f32 %0, %1;" : "=f"(f125) : "f"(f2));
  // PTX:118 setp.geu.f32 %p5, %f125, 0f7F800000
  p5 = ((isnan(((float)(f125))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f125)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:119 @%p5 bra $L__BB8_69
  if (p5) { goto L_BB8_69; }
  // PTX:121 abs.f32 %f126, %f3
  asm("abs.f32 %0, %1;" : "=f"(f126) : "f"(f3));
  // PTX:122 setp.geu.f32 %p6, %f126, 0f7F800000
  p6 = ((isnan(((float)(f126))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f126)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:123 @%p6 bra $L__BB8_69
  if (p6) { goto L_BB8_69; }
  // PTX:125 abs.f32 %f127, %f4
  asm("abs.f32 %0, %1;" : "=f"(f127) : "f"(f4));
  // PTX:126 setp.geu.f32 %p7, %f127, 0f7F800000
  p7 = ((isnan(((float)(f127))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f127)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:127 @%p7 bra $L__BB8_69
  if (p7) { goto L_BB8_69; }
  // PTX:129 abs.f32 %f128, %f365
  asm("abs.f32 %0, %1;" : "=f"(f128) : "f"(f365));
  // PTX:130 setp.geu.f32 %p8, %f128, 0f7F800000
  p8 = ((isnan(((float)(f128))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f128)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:131 @%p8 bra $L__BB8_69
  if (p8) { goto L_BB8_69; }
  // PTX:133 abs.f32 %f129, %f7
  asm("abs.f32 %0, %1;" : "=f"(f129) : "f"(f7));
  // PTX:134 setp.geu.f32 %p9, %f129, 0f7F800000
  p9 = ((isnan(((float)(f129))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f129)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:135 @%p9 bra $L__BB8_69
  if (p9) { goto L_BB8_69; }
  // PTX:137 cvta.to.global.u64 %rd53, %rd26
  rd53 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd26));
  // PTX:138 shl.b64 %rd54, %rd5, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd54) : "l"(rd5));
  // PTX:139 add.s64 %rd14, %rd53, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd14) : "l"(rd53), "l"(rd54));
  // PTX:140 ld.global.u32 %r55, [%rd14]
  r55 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:141 setp.lt.s32 %p10, %r55, 1
  p10 = (((int)(r55)) < ((int)(1)));
  // PTX:142 mov.f32 %f388, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f388) : );
  // PTX:143 mov.f32 %f389, %f388
  asm("mov.f32 %0, %1;" : "=f"(f389) : "f"(f388));
  // PTX:144 mov.f32 %f390, %f388
  asm("mov.f32 %0, %1;" : "=f"(f390) : "f"(f388));
  // PTX:145 mov.f32 %f391, %f388
  asm("mov.f32 %0, %1;" : "=f"(f391) : "f"(f388));
  // PTX:146 mov.f32 %f392, %f388
  asm("mov.f32 %0, %1;" : "=f"(f392) : "f"(f388));
  // PTX:147 mov.f32 %f393, %f388
  asm("mov.f32 %0, %1;" : "=f"(f393) : "f"(f388));
  // PTX:148 mov.f32 %f394, %f388
  asm("mov.f32 %0, %1;" : "=f"(f394) : "f"(f388));
  // PTX:149 mov.f32 %f395, %f388
  asm("mov.f32 %0, %1;" : "=f"(f395) : "f"(f388));
  // PTX:150 mov.f32 %f396, %f388
  asm("mov.f32 %0, %1;" : "=f"(f396) : "f"(f388));
  // PTX:151 mov.f32 %f400, %f388
  asm("mov.f32 %0, %1;" : "=f"(f400) : "f"(f388));
  // PTX:152 mov.f32 %f401, %f388
  asm("mov.f32 %0, %1;" : "=f"(f401) : "f"(f388));
  // PTX:153 mov.f32 %f402, %f388
  asm("mov.f32 %0, %1;" : "=f"(f402) : "f"(f388));
  // PTX:154 @%p10 bra $L__BB8_68
  if (p10) { goto L_BB8_68; }
  // PTX:156 cvt.s64.s32 %rd55, %r30
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd55) : "r"(r30));
  // PTX:157 mul.lo.s64 %rd15, %rd5, %rd55
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd15) : "l"(rd5), "l"(rd55));
  // PTX:158 mul.f32 %f8, %f4, %f123
  asm("mul.f32 %0, %1, %2;" : "=f"(f8) : "f"(f4), "f"(f123));
  // PTX:159 cvta.to.global.u64 %rd16, %rd28
  rd16 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd28));
  // PTX:160 cvta.to.global.u64 %rd17, %rd29
  rd17 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd29));
  // PTX:161 cvta.to.global.u64 %rd18, %rd25
  rd18 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd25));
  // PTX:162 cvta.to.global.u64 %rd19, %rd27
  rd19 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd27));
  // PTX:163 mov.f32 %f388, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f388) : );
  // PTX:164 mov.u32 %r51, 0
  asm("mov.u32 %0, 0;" : "=r"(r51) : );
  // PTX:166 $L__BB8_14:
L_BB8_14:;
  // PTX:167 ld.param.s8 %rs39, [_ZN7synreal21self_collision_kernel22accumulate_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_S8_SA_ffbfPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_9]
  rs39 = (*reinterpret_cast<volatile signed char*>(((uintptr_t)&param9 + (0))));
  // PTX:168 cvt.s64.s32 %rd56, %r51
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd56) : "r"(r51));
  // PTX:169 add.s64 %rd57, %rd15, %rd56
  asm("add.s64 %0, %1, %2;" : "=l"(rd57) : "l"(rd15), "l"(rd56));
  // PTX:170 shl.b64 %rd58, %rd57, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd58) : "l"(rd57));
  // PTX:171 add.s64 %rd59, %rd19, %rd58
  asm("add.s64 %0, %1, %2;" : "=l"(rd59) : "l"(rd19), "l"(rd58));
  // PTX:172 ld.global.u32 %r41, [%rd59]
  r41 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))));
  // PTX:173 mul.wide.s32 %rd60, %r41, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd60) : "r"(r41));
  // PTX:174 add.s64 %rd61, %rd18, %rd60
  asm("add.s64 %0, %1, %2;" : "=l"(rd61) : "l"(rd18), "l"(rd60));
  // PTX:175 ld.global.u32 %r6, [%rd61]
  r6 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))));
  // PTX:176 ld.global.u32 %r7, [%rd61+4]
  r7 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (4)))));
  // PTX:177 ld.global.u32 %r8, [%rd61+8]
  r8 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (8)))));
  // PTX:178 setp.eq.s16 %p11, %rs39, 0
  p11 = (((short)(rs39)) == ((short)(0)));
  // PTX:179 @%p11 bra $L__BB8_16
  if (p11) { goto L_BB8_16; }
  // PTX:181 cvt.u32.u64 %r42, %rd12
  asm("cvt.u32.u64 %0, %1;" : "=r"(r42) : "l"(rd12));
  // PTX:182 setp.eq.s32 %p12, %r42, %r6
  p12 = (((int)(r42)) == ((int)(r6)));
  // PTX:183 setp.eq.s32 %p13, %r42, %r7
  p13 = (((int)(r42)) == ((int)(r7)));
  // PTX:184 or.pred %p14, %p12, %p13
  p14 = ((p12) || (p13));
  // PTX:185 setp.eq.s32 %p15, %r42, %r8
  p15 = (((int)(r42)) == ((int)(r8)));
  // PTX:186 or.pred %p16, %p14, %p15
  p16 = ((p14) || (p15));
  // PTX:187 @%p16 bra $L__BB8_67
  if (p16) { goto L_BB8_67; }
  // PTX:189 $L__BB8_16:
L_BB8_16:;
  // PTX:190 add.s32 %r9, %r6, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r9) : "r"(r6), "r"(r1));
  // PTX:191 cvt.s64.s32 %rd20, %r9
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd20) : "r"(r9));
  // PTX:192 mul.wide.s32 %rd62, %r9, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd62) : "r"(r9));
  // PTX:193 add.s64 %rd63, %rd4, %rd62
  asm("add.s64 %0, %1, %2;" : "=l"(rd63) : "l"(rd4), "l"(rd62));
  // PTX:194 ld.global.u32 %r10, [%rd63+4]
  r10 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (4)))));
  // PTX:195 ld.global.u32 %r11, [%rd63+8]
  r11 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (8)))));
  // PTX:196 add.s32 %r12, %r7, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r12) : "r"(r7), "r"(r1));
  // PTX:197 cvt.s64.s32 %rd21, %r12
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd21) : "r"(r12));
  // PTX:198 mul.wide.s32 %rd64, %r12, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd64) : "r"(r12));
  // PTX:199 add.s64 %rd65, %rd4, %rd64
  asm("add.s64 %0, %1, %2;" : "=l"(rd65) : "l"(rd4), "l"(rd64));
  // PTX:200 ld.global.f32 %f24, [%rd65]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (0)))));
  // PTX:201 ld.global.u32 %r13, [%rd65+4]
  r13 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (4)))));
  // PTX:202 ld.global.u32 %r14, [%rd65+8]
  r14 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (8)))));
  // PTX:203 add.s32 %r15, %r8, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r15) : "r"(r8), "r"(r1));
  // PTX:204 cvt.s64.s32 %rd22, %r15
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd22) : "r"(r15));
  // PTX:205 mul.wide.s32 %rd66, %r15, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd66) : "r"(r15));
  // PTX:206 add.s64 %rd67, %rd4, %rd66
  asm("add.s64 %0, %1, %2;" : "=l"(rd67) : "l"(rd4), "l"(rd66));
  // PTX:207 ld.global.f32 %f25, [%rd67]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0)))));
  // PTX:208 ld.global.u32 %r16, [%rd67+4]
  r16 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (4)))));
  // PTX:209 ld.global.u32 %r17, [%rd67+8]
  r17 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (8)))));
  // PTX:210 ld.global.f32 %f26, [%rd63]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (0)))));
  // PTX:211 abs.f32 %f155, %f26
  asm("abs.f32 %0, %1;" : "=f"(f155) : "f"(f26));
  // PTX:212 setp.geu.f32 %p17, %f155, 0f7F800000
  p17 = ((isnan(((float)(f155))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f155)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:213 mov.u16 %rs42, 0
  asm("mov.u16 %0, 0;" : "=h"(rs42) : );
  // PTX:214 @%p17 bra $L__BB8_19
  if (p17) { goto L_BB8_19; }
  // PTX:216 mov.b32 %f156, %r10
  asm("mov.b32 %0, %1;" : "=f"(f156) : "r"(r10));
  // PTX:217 abs.f32 %f157, %f156
  asm("abs.f32 %0, %1;" : "=f"(f157) : "f"(f156));
  // PTX:218 setp.geu.f32 %p18, %f157, 0f7F800000
  p18 = ((isnan(((float)(f157))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f157)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:219 @%p18 bra $L__BB8_19
  if (p18) { goto L_BB8_19; }
  // PTX:221 mov.b32 %f158, %r11
  asm("mov.b32 %0, %1;" : "=f"(f158) : "r"(r11));
  // PTX:222 abs.f32 %f159, %f158
  asm("abs.f32 %0, %1;" : "=f"(f159) : "f"(f158));
  // PTX:223 setp.lt.f32 %p19, %f159, 0f7F800000
  p19 = (!(isnan(((float)(f159))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f159)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:224 selp.u16 %rs42, 1, 0, %p19
  rs42 = p19 ? 1 : 0;
  // PTX:226 $L__BB8_19:
L_BB8_19:;
  // PTX:227 setp.eq.s16 %p20, %rs42, 0
  p20 = (((short)(rs42)) == ((short)(0)));
  // PTX:228 @%p20 bra $L__BB8_67
  if (p20) { goto L_BB8_67; }
  // PTX:230 abs.f32 %f160, %f24
  asm("abs.f32 %0, %1;" : "=f"(f160) : "f"(f24));
  // PTX:231 setp.geu.f32 %p21, %f160, 0f7F800000
  p21 = ((isnan(((float)(f160))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f160)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:232 mov.u16 %rs43, 0
  asm("mov.u16 %0, 0;" : "=h"(rs43) : );
  // PTX:233 @%p21 bra $L__BB8_23
  if (p21) { goto L_BB8_23; }
  // PTX:235 mov.b32 %f161, %r13
  asm("mov.b32 %0, %1;" : "=f"(f161) : "r"(r13));
  // PTX:236 abs.f32 %f162, %f161
  asm("abs.f32 %0, %1;" : "=f"(f162) : "f"(f161));
  // PTX:237 setp.geu.f32 %p22, %f162, 0f7F800000
  p22 = ((isnan(((float)(f162))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f162)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:238 @%p22 bra $L__BB8_23
  if (p22) { goto L_BB8_23; }
  // PTX:240 mov.b32 %f163, %r14
  asm("mov.b32 %0, %1;" : "=f"(f163) : "r"(r14));
  // PTX:241 abs.f32 %f164, %f163
  asm("abs.f32 %0, %1;" : "=f"(f164) : "f"(f163));
  // PTX:242 setp.lt.f32 %p23, %f164, 0f7F800000
  p23 = (!(isnan(((float)(f164))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f164)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:243 selp.u16 %rs43, 1, 0, %p23
  rs43 = p23 ? 1 : 0;
  // PTX:245 $L__BB8_23:
L_BB8_23:;
  // PTX:246 setp.eq.s16 %p24, %rs43, 0
  p24 = (((short)(rs43)) == ((short)(0)));
  // PTX:247 @%p24 bra $L__BB8_67
  if (p24) { goto L_BB8_67; }
  // PTX:249 abs.f32 %f165, %f25
  asm("abs.f32 %0, %1;" : "=f"(f165) : "f"(f25));
  // PTX:250 setp.geu.f32 %p25, %f165, 0f7F800000
  p25 = ((isnan(((float)(f165))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f165)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:251 mov.u16 %rs44, 0
  asm("mov.u16 %0, 0;" : "=h"(rs44) : );
  // PTX:252 @%p25 bra $L__BB8_27
  if (p25) { goto L_BB8_27; }
  // PTX:254 mov.b32 %f166, %r16
  asm("mov.b32 %0, %1;" : "=f"(f166) : "r"(r16));
  // PTX:255 abs.f32 %f167, %f166
  asm("abs.f32 %0, %1;" : "=f"(f167) : "f"(f166));
  // PTX:256 setp.geu.f32 %p26, %f167, 0f7F800000
  p26 = ((isnan(((float)(f167))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f167)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:257 @%p26 bra $L__BB8_27
  if (p26) { goto L_BB8_27; }
  // PTX:259 mov.b32 %f168, %r17
  asm("mov.b32 %0, %1;" : "=f"(f168) : "r"(r17));
  // PTX:260 abs.f32 %f169, %f168
  asm("abs.f32 %0, %1;" : "=f"(f169) : "f"(f168));
  // PTX:261 setp.lt.f32 %p27, %f169, 0f7F800000
  p27 = (!(isnan(((float)(f169))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f169)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:262 selp.u16 %rs44, 1, 0, %p27
  rs44 = p27 ? 1 : 0;
  // PTX:264 $L__BB8_27:
L_BB8_27:;
  // PTX:265 setp.eq.s16 %p28, %rs44, 0
  p28 = (((short)(rs44)) == ((short)(0)));
  // PTX:266 @%p28 bra $L__BB8_67
  if (p28) { goto L_BB8_67; }
  // PTX:268 sub.f32 %f170, %f24, %f26
  asm("sub.f32 %0, %1, %2;" : "=f"(f170) : "f"(f24), "f"(f26));
  // PTX:269 mov.b32 %f27, %r10
  asm("mov.b32 %0, %1;" : "=f"(f27) : "r"(r10));
  // PTX:270 mov.b32 %f28, %r13
  asm("mov.b32 %0, %1;" : "=f"(f28) : "r"(r13));
  // PTX:271 sub.f32 %f171, %f28, %f27
  asm("sub.f32 %0, %1, %2;" : "=f"(f171) : "f"(f28), "f"(f27));
  // PTX:272 mov.b32 %f29, %r11
  asm("mov.b32 %0, %1;" : "=f"(f29) : "r"(r11));
  // PTX:273 mov.b32 %f30, %r14
  asm("mov.b32 %0, %1;" : "=f"(f30) : "r"(r14));
  // PTX:274 sub.f32 %f172, %f30, %f29
  asm("sub.f32 %0, %1, %2;" : "=f"(f172) : "f"(f30), "f"(f29));
  // PTX:275 mov.b32 %f31, %r16
  asm("mov.b32 %0, %1;" : "=f"(f31) : "r"(r16));
  // PTX:276 sub.f32 %f173, %f31, %f27
  asm("sub.f32 %0, %1, %2;" : "=f"(f173) : "f"(f31), "f"(f27));
  // PTX:277 mov.b32 %f32, %r17
  asm("mov.b32 %0, %1;" : "=f"(f32) : "r"(r17));
  // PTX:278 sub.f32 %f174, %f32, %f29
  asm("sub.f32 %0, %1, %2;" : "=f"(f174) : "f"(f32), "f"(f29));
  // PTX:279 mul.f32 %f175, %f171, %f174
  asm("mul.f32 %0, %1, %2;" : "=f"(f175) : "f"(f171), "f"(f174));
  // PTX:280 mul.f32 %f176, %f172, %f173
  asm("mul.f32 %0, %1, %2;" : "=f"(f176) : "f"(f172), "f"(f173));
  // PTX:281 sub.f32 %f33, %f175, %f176
  asm("sub.f32 %0, %1, %2;" : "=f"(f33) : "f"(f175), "f"(f176));
  // PTX:282 sub.f32 %f177, %f25, %f26
  asm("sub.f32 %0, %1, %2;" : "=f"(f177) : "f"(f25), "f"(f26));
  // PTX:283 mul.f32 %f178, %f172, %f177
  asm("mul.f32 %0, %1, %2;" : "=f"(f178) : "f"(f172), "f"(f177));
  // PTX:284 mul.f32 %f179, %f170, %f174
  asm("mul.f32 %0, %1, %2;" : "=f"(f179) : "f"(f170), "f"(f174));
  // PTX:285 sub.f32 %f34, %f178, %f179
  asm("sub.f32 %0, %1, %2;" : "=f"(f34) : "f"(f178), "f"(f179));
  // PTX:286 mul.f32 %f180, %f170, %f173
  asm("mul.f32 %0, %1, %2;" : "=f"(f180) : "f"(f170), "f"(f173));
  // PTX:287 mul.f32 %f181, %f171, %f177
  asm("mul.f32 %0, %1, %2;" : "=f"(f181) : "f"(f171), "f"(f177));
  // PTX:288 sub.f32 %f35, %f180, %f181
  asm("sub.f32 %0, %1, %2;" : "=f"(f35) : "f"(f180), "f"(f181));
  // PTX:289 mul.f32 %f182, %f34, %f34
  asm("mul.f32 %0, %1, %2;" : "=f"(f182) : "f"(f34), "f"(f34));
  // PTX:290 fma.rn.f32 %f183, %f33, %f33, %f182
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f183) : "f"(f33), "f"(f33), "f"(f182));
  // PTX:291 fma.rn.f32 %f184, %f35, %f35, %f183
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f184) : "f"(f35), "f"(f35), "f"(f183));
  // PTX:292 sqrt.rn.f32 %f36, %f184
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f36) : "f"(f184));
  // PTX:293 setp.lt.f32 %p29, %f36, 0f2B8CBCCC
  p29 = (!(isnan(((float)(f36))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) && (((float)(f36)) < ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:294 mov.u32 %r52, 0
  asm("mov.u32 %0, 0;" : "=r"(r52) : );
  // PTX:295 mov.u32 %r53, %r52
  asm("mov.u32 %0, %1;" : "=r"(r53) : "r"(r52));
  // PTX:296 mov.u32 %r54, %r52
  asm("mov.u32 %0, %1;" : "=r"(r54) : "r"(r52));
  // PTX:297 @%p29 bra $L__BB8_30
  if (p29) { goto L_BB8_30; }
  // PTX:299 div.rn.f32 %f185, %f33, %f36
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f185) : "f"(f33), "f"(f36));
  // PTX:300 div.rn.f32 %f186, %f34, %f36
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f186) : "f"(f34), "f"(f36));
  // PTX:301 div.rn.f32 %f187, %f35, %f36
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f187) : "f"(f35), "f"(f36));
  // PTX:302 mov.b32 %r54, %f187
  asm("mov.b32 %0, %1;" : "=r"(r54) : "f"(f187));
  // PTX:303 mov.b32 %r53, %f186
  asm("mov.b32 %0, %1;" : "=r"(r53) : "f"(f186));
  // PTX:304 mov.b32 %r52, %f185
  asm("mov.b32 %0, %1;" : "=r"(r52) : "f"(f185));
  // PTX:306 $L__BB8_30:
L_BB8_30:;
  // PTX:307 mov.b32 %f37, %r52
  asm("mov.b32 %0, %1;" : "=f"(f37) : "r"(r52));
  // PTX:308 abs.f32 %f188, %f37
  asm("abs.f32 %0, %1;" : "=f"(f188) : "f"(f37));
  // PTX:309 setp.geu.f32 %p30, %f188, 0f7F800000
  p30 = ((isnan(((float)(f188))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f188)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:310 mov.u16 %rs45, 0
  asm("mov.u16 %0, 0;" : "=h"(rs45) : );
  // PTX:311 @%p30 bra $L__BB8_33
  if (p30) { goto L_BB8_33; }
  // PTX:313 mov.b32 %f189, %r53
  asm("mov.b32 %0, %1;" : "=f"(f189) : "r"(r53));
  // PTX:314 abs.f32 %f190, %f189
  asm("abs.f32 %0, %1;" : "=f"(f190) : "f"(f189));
  // PTX:315 setp.geu.f32 %p31, %f190, 0f7F800000
  p31 = ((isnan(((float)(f190))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f190)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:316 @%p31 bra $L__BB8_33
  if (p31) { goto L_BB8_33; }
  // PTX:318 mov.b32 %f191, %r54
  asm("mov.b32 %0, %1;" : "=f"(f191) : "r"(r54));
  // PTX:319 abs.f32 %f192, %f191
  asm("abs.f32 %0, %1;" : "=f"(f192) : "f"(f191));
  // PTX:320 setp.lt.f32 %p32, %f192, 0f7F800000
  p32 = (!(isnan(((float)(f192))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f192)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:321 selp.u16 %rs45, 1, 0, %p32
  rs45 = p32 ? 1 : 0;
  // PTX:323 $L__BB8_33:
L_BB8_33:;
  // PTX:324 setp.eq.s16 %p33, %rs45, 0
  p33 = (((short)(rs45)) == ((short)(0)));
  // PTX:325 @%p33 bra $L__BB8_67
  if (p33) { goto L_BB8_67; }
  // PTX:327 mov.b32 %f361, %r52
  asm("mov.b32 %0, %1;" : "=f"(f361) : "r"(r52));
  // PTX:328 mul.f32 %f38, %f361, %f361
  asm("mul.f32 %0, %1, %2;" : "=f"(f38) : "f"(f361), "f"(f361));
  // PTX:329 mov.b32 %f39, %r53
  asm("mov.b32 %0, %1;" : "=f"(f39) : "r"(r53));
  // PTX:330 mul.f32 %f40, %f39, %f39
  asm("mul.f32 %0, %1, %2;" : "=f"(f40) : "f"(f39), "f"(f39));
  // PTX:331 mov.b32 %f41, %r54
  asm("mov.b32 %0, %1;" : "=f"(f41) : "r"(r54));
  // PTX:332 mul.f32 %f42, %f41, %f41
  asm("mul.f32 %0, %1, %2;" : "=f"(f42) : "f"(f41), "f"(f41));
  // PTX:333 add.f32 %f193, %f38, %f40
  asm("add.f32 %0, %1, %2;" : "=f"(f193) : "f"(f38), "f"(f40));
  // PTX:334 add.f32 %f194, %f42, %f193
  asm("add.f32 %0, %1, %2;" : "=f"(f194) : "f"(f42), "f"(f193));
  // PTX:335 setp.eq.f32 %p34, %f194, 0f00000000
  p34 = (!(isnan(((float)(f194))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f194)) == ((float)(as_f32(0x00000000u)))));
  // PTX:336 @%p34 bra $L__BB8_67
  if (p34) { goto L_BB8_67; }
  // PTX:338 mov.b32 %f364, %r54
  asm("mov.b32 %0, %1;" : "=f"(f364) : "r"(r54));
  // PTX:339 mov.b32 %f363, %r53
  asm("mov.b32 %0, %1;" : "=f"(f363) : "r"(r53));
  // PTX:340 mov.b32 %f362, %r52
  asm("mov.b32 %0, %1;" : "=f"(f362) : "r"(r52));
  // PTX:341 sub.f32 %f195, %f1, %f26
  asm("sub.f32 %0, %1, %2;" : "=f"(f195) : "f"(f1), "f"(f26));
  // PTX:342 sub.f32 %f196, %f2, %f27
  asm("sub.f32 %0, %1, %2;" : "=f"(f196) : "f"(f2), "f"(f27));
  // PTX:343 mul.f32 %f197, %f196, %f363
  asm("mul.f32 %0, %1, %2;" : "=f"(f197) : "f"(f196), "f"(f363));
  // PTX:344 sub.f32 %f198, %f3, %f29
  asm("sub.f32 %0, %1, %2;" : "=f"(f198) : "f"(f3), "f"(f29));
  // PTX:345 fma.rn.f32 %f199, %f195, %f362, %f197
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f199) : "f"(f195), "f"(f362), "f"(f197));
  // PTX:346 fma.rn.f32 %f43, %f198, %f364, %f199
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f43) : "f"(f198), "f"(f364), "f"(f199));
  // PTX:347 abs.f32 %f44, %f43
  asm("abs.f32 %0, %1;" : "=f"(f44) : "f"(f43));
  // PTX:348 setp.geu.f32 %p35, %f44, 0f7F800000
  p35 = ((isnan(((float)(f44))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f44)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:349 setp.gt.f32 %p36, %f44, %f7
  p36 = (!(isnan(((float)(f44))) || isnan(((float)(f7)))) && (((float)(f44)) > ((float)(f7))));
  // PTX:350 or.pred %p37, %p35, %p36
  p37 = ((p35) || (p36));
  // PTX:351 @%p37 bra $L__BB8_67
  if (p37) { goto L_BB8_67; }
  // PTX:353 mov.b32 %f353, %r54
  asm("mov.b32 %0, %1;" : "=f"(f353) : "r"(r54));
  // PTX:354 mov.b32 %f352, %r53
  asm("mov.b32 %0, %1;" : "=f"(f352) : "r"(r53));
  // PTX:355 mov.b32 %f351, %r52
  asm("mov.b32 %0, %1;" : "=f"(f351) : "r"(r52));
  // PTX:356 mul.f32 %f200, %f43, %f351
  asm("mul.f32 %0, %1, %2;" : "=f"(f200) : "f"(f43), "f"(f351));
  // PTX:357 sub.f32 %f201, %f1, %f200
  asm("sub.f32 %0, %1, %2;" : "=f"(f201) : "f"(f1), "f"(f200));
  // PTX:358 mul.f32 %f202, %f43, %f352
  asm("mul.f32 %0, %1, %2;" : "=f"(f202) : "f"(f43), "f"(f352));
  // PTX:359 sub.f32 %f203, %f2, %f202
  asm("sub.f32 %0, %1, %2;" : "=f"(f203) : "f"(f2), "f"(f202));
  // PTX:360 mul.f32 %f204, %f43, %f353
  asm("mul.f32 %0, %1, %2;" : "=f"(f204) : "f"(f43), "f"(f353));
  // PTX:361 sub.f32 %f205, %f3, %f204
  asm("sub.f32 %0, %1, %2;" : "=f"(f205) : "f"(f3), "f"(f204));
  // PTX:362 sub.f32 %f206, %f201, %f25
  asm("sub.f32 %0, %1, %2;" : "=f"(f206) : "f"(f201), "f"(f25));
  // PTX:363 sub.f32 %f207, %f203, %f31
  asm("sub.f32 %0, %1, %2;" : "=f"(f207) : "f"(f203), "f"(f31));
  // PTX:364 sub.f32 %f208, %f205, %f32
  asm("sub.f32 %0, %1, %2;" : "=f"(f208) : "f"(f205), "f"(f32));
  // PTX:365 sub.f32 %f209, %f26, %f25
  asm("sub.f32 %0, %1, %2;" : "=f"(f209) : "f"(f26), "f"(f25));
  // PTX:366 sub.f32 %f210, %f27, %f31
  asm("sub.f32 %0, %1, %2;" : "=f"(f210) : "f"(f27), "f"(f31));
  // PTX:367 mul.f32 %f211, %f210, %f210
  asm("mul.f32 %0, %1, %2;" : "=f"(f211) : "f"(f210), "f"(f210));
  // PTX:368 sub.f32 %f212, %f29, %f32
  asm("sub.f32 %0, %1, %2;" : "=f"(f212) : "f"(f29), "f"(f32));
  // PTX:369 fma.rn.f32 %f213, %f209, %f209, %f211
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f213) : "f"(f209), "f"(f209), "f"(f211));
  // PTX:370 fma.rn.f32 %f45, %f212, %f212, %f213
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f45) : "f"(f212), "f"(f212), "f"(f213));
  // PTX:371 sub.f32 %f214, %f24, %f25
  asm("sub.f32 %0, %1, %2;" : "=f"(f214) : "f"(f24), "f"(f25));
  // PTX:372 sub.f32 %f215, %f28, %f31
  asm("sub.f32 %0, %1, %2;" : "=f"(f215) : "f"(f28), "f"(f31));
  // PTX:373 mul.f32 %f216, %f210, %f215
  asm("mul.f32 %0, %1, %2;" : "=f"(f216) : "f"(f210), "f"(f215));
  // PTX:374 sub.f32 %f217, %f30, %f32
  asm("sub.f32 %0, %1, %2;" : "=f"(f217) : "f"(f30), "f"(f32));
  // PTX:375 fma.rn.f32 %f218, %f209, %f214, %f216
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f218) : "f"(f209), "f"(f214), "f"(f216));
  // PTX:376 fma.rn.f32 %f46, %f212, %f217, %f218
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f46) : "f"(f212), "f"(f217), "f"(f218));
  // PTX:377 mul.f32 %f219, %f210, %f207
  asm("mul.f32 %0, %1, %2;" : "=f"(f219) : "f"(f210), "f"(f207));
  // PTX:378 fma.rn.f32 %f220, %f209, %f206, %f219
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f220) : "f"(f209), "f"(f206), "f"(f219));
  // PTX:379 fma.rn.f32 %f47, %f212, %f208, %f220
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f47) : "f"(f212), "f"(f208), "f"(f220));
  // PTX:380 mul.f32 %f221, %f215, %f215
  asm("mul.f32 %0, %1, %2;" : "=f"(f221) : "f"(f215), "f"(f215));
  // PTX:381 fma.rn.f32 %f222, %f214, %f214, %f221
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f222) : "f"(f214), "f"(f214), "f"(f221));
  // PTX:382 fma.rn.f32 %f48, %f217, %f217, %f222
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f48) : "f"(f217), "f"(f217), "f"(f222));
  // PTX:383 mul.f32 %f223, %f215, %f207
  asm("mul.f32 %0, %1, %2;" : "=f"(f223) : "f"(f215), "f"(f207));
  // PTX:384 fma.rn.f32 %f224, %f214, %f206, %f223
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f224) : "f"(f214), "f"(f206), "f"(f223));
  // PTX:385 fma.rn.f32 %f49, %f217, %f208, %f224
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f49) : "f"(f217), "f"(f208), "f"(f224));
  // PTX:386 mul.f32 %f225, %f45, %f48
  asm("mul.f32 %0, %1, %2;" : "=f"(f225) : "f"(f45), "f"(f48));
  // PTX:387 mul.f32 %f226, %f46, %f46
  asm("mul.f32 %0, %1, %2;" : "=f"(f226) : "f"(f46), "f"(f46));
  // PTX:388 sub.f32 %f50, %f225, %f226
  asm("sub.f32 %0, %1, %2;" : "=f"(f50) : "f"(f225), "f"(f226));
  // PTX:389 abs.f32 %f227, %f50
  asm("abs.f32 %0, %1;" : "=f"(f227) : "f"(f50));
  // PTX:390 setp.lt.f32 %p38, %f227, 0f2B8CBCCC
  p38 = (!(isnan(((float)(f227))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) && (((float)(f227)) < ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:391 mov.u16 %rs46, 0
  asm("mov.u16 %0, 0;" : "=h"(rs46) : );
  // PTX:392 @%p38 bra $L__BB8_40
  if (p38) { goto L_BB8_40; }
  // PTX:394 mov.u16 %rs46, 0
  asm("mov.u16 %0, 0;" : "=h"(rs46) : );
  // PTX:395 rcp.rn.f32 %f228, %f50
  asm("rcp.rn.f32 %0, %1;" : "=f"(f228) : "f"(f50));
  // PTX:396 mov.f32 %f229, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f229) : );
  // PTX:397 mul.f32 %f230, %f46, %f49
  asm("mul.f32 %0, %1, %2;" : "=f"(f230) : "f"(f46), "f"(f49));
  // PTX:398 mul.f32 %f231, %f48, %f47
  asm("mul.f32 %0, %1, %2;" : "=f"(f231) : "f"(f48), "f"(f47));
  // PTX:399 sub.f32 %f232, %f231, %f230
  asm("sub.f32 %0, %1, %2;" : "=f"(f232) : "f"(f231), "f"(f230));
  // PTX:400 mul.f32 %f397, %f228, %f232
  asm("mul.f32 %0, %1, %2;" : "=f"(f397) : "f"(f228), "f"(f232));
  // PTX:401 mul.f32 %f233, %f46, %f47
  asm("mul.f32 %0, %1, %2;" : "=f"(f233) : "f"(f46), "f"(f47));
  // PTX:402 mul.f32 %f234, %f45, %f49
  asm("mul.f32 %0, %1, %2;" : "=f"(f234) : "f"(f45), "f"(f49));
  // PTX:403 sub.f32 %f235, %f234, %f233
  asm("sub.f32 %0, %1, %2;" : "=f"(f235) : "f"(f234), "f"(f233));
  // PTX:404 mul.f32 %f398, %f228, %f235
  asm("mul.f32 %0, %1, %2;" : "=f"(f398) : "f"(f228), "f"(f235));
  // PTX:405 sub.f32 %f236, %f229, %f397
  asm("sub.f32 %0, %1, %2;" : "=f"(f236) : "f"(f229), "f"(f397));
  // PTX:406 sub.f32 %f399, %f236, %f398
  asm("sub.f32 %0, %1, %2;" : "=f"(f399) : "f"(f236), "f"(f398));
  // PTX:407 abs.f32 %f237, %f397
  asm("abs.f32 %0, %1;" : "=f"(f237) : "f"(f397));
  // PTX:408 setp.geu.f32 %p39, %f237, 0f7F800000
  p39 = ((isnan(((float)(f237))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f237)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:409 @%p39 bra $L__BB8_40
  if (p39) { goto L_BB8_40; }
  // PTX:411 mov.u16 %rs46, 0
  asm("mov.u16 %0, 0;" : "=h"(rs46) : );
  // PTX:412 abs.f32 %f238, %f398
  asm("abs.f32 %0, %1;" : "=f"(f238) : "f"(f398));
  // PTX:413 setp.geu.f32 %p40, %f238, 0f7F800000
  p40 = ((isnan(((float)(f238))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f238)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:414 @%p40 bra $L__BB8_40
  if (p40) { goto L_BB8_40; }
  // PTX:416 abs.f32 %f239, %f399
  asm("abs.f32 %0, %1;" : "=f"(f239) : "f"(f399));
  // PTX:417 setp.lt.f32 %p41, %f239, 0f7F800000
  p41 = (!(isnan(((float)(f239))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f239)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:418 selp.u16 %rs46, 1, 0, %p41
  rs46 = p41 ? 1 : 0;
  // PTX:420 $L__BB8_40:
L_BB8_40:;
  // PTX:421 setp.lt.f32 %p42, %f397, 0f00000000
  p42 = (!(isnan(((float)(f397))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f397)) < ((float)(as_f32(0x00000000u)))));
  // PTX:422 setp.eq.s16 %p43, %rs46, 0
  p43 = (((short)(rs46)) == ((short)(0)));
  // PTX:423 or.pred %p44, %p42, %p43
  p44 = ((p42) || (p43));
  // PTX:424 setp.lt.f32 %p45, %f398, 0f00000000
  p45 = (!(isnan(((float)(f398))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f398)) < ((float)(as_f32(0x00000000u)))));
  // PTX:425 or.pred %p46, %p45, %p44
  p46 = ((p45) || (p44));
  // PTX:426 setp.lt.f32 %p47, %f399, 0f00000000
  p47 = (!(isnan(((float)(f399))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f399)) < ((float)(as_f32(0x00000000u)))));
  // PTX:427 or.pred %p48, %p47, %p46
  p48 = ((p47) || (p46));
  // PTX:428 @%p48 bra $L__BB8_67
  if (p48) { goto L_BB8_67; }
  // PTX:430 setp.eq.f32 %p49, %f4, 0f00000000
  p49 = (!(isnan(((float)(f4))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f4)) == ((float)(as_f32(0x00000000u)))));
  // PTX:431 shl.b64 %rd68, %rd21, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd68) : "l"(rd21));
  // PTX:432 add.s64 %rd69, %rd3, %rd68
  asm("add.s64 %0, %1, %2;" : "=l"(rd69) : "l"(rd3), "l"(rd68));
  // PTX:433 ld.global.f32 %f240, [%rd69]
  f240 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (0)))));
  // PTX:434 shl.b64 %rd70, %rd20, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd70) : "l"(rd20));
  // PTX:435 add.s64 %rd71, %rd3, %rd70
  asm("add.s64 %0, %1, %2;" : "=l"(rd71) : "l"(rd3), "l"(rd70));
  // PTX:436 ld.global.f32 %f241, [%rd71]
  f241 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))));
  // PTX:437 add.f32 %f242, %f241, %f240
  asm("add.f32 %0, %1, %2;" : "=f"(f242) : "f"(f241), "f"(f240));
  // PTX:438 shl.b64 %rd72, %rd22, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd72) : "l"(rd22));
  // PTX:439 add.s64 %rd73, %rd3, %rd72
  asm("add.s64 %0, %1, %2;" : "=l"(rd73) : "l"(rd3), "l"(rd72));
  // PTX:440 ld.global.f32 %f243, [%rd73]
  f243 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (0)))));
  // PTX:441 add.f32 %f244, %f242, %f243
  asm("add.f32 %0, %1, %2;" : "=f"(f244) : "f"(f242), "f"(f243));
  // PTX:442 div.rn.f32 %f57, %f244, 0f40400000
  asm("div.rn.f32 %0, %1, 0f40400000;" : "=f"(f57) : "f"(f244));
  // PTX:443 setp.eq.f32 %p50, %f57, 0f00000000
  p50 = (!(isnan(((float)(f57))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f57)) == ((float)(as_f32(0x00000000u)))));
  // PTX:444 or.pred %p51, %p49, %p50
  p51 = ((p49) || (p50));
  // PTX:445 @%p51 bra $L__BB8_46
  if (p51) { goto L_BB8_46; }
  // PTX:446 bra.uni $L__BB8_42
  goto L_BB8_42;
  // PTX:448 $L__BB8_46:
L_BB8_46:;
  // PTX:449 add.f32 %f252, %f4, %f57
  asm("add.f32 %0, %1, %2;" : "=f"(f252) : "f"(f4), "f"(f57));
  // PTX:450 mul.f32 %f384, %f252, %f123
  asm("mul.f32 %0, %1, %2;" : "=f"(f384) : "f"(f252), "f"(f123));
  // PTX:451 bra.uni $L__BB8_47
  goto L_BB8_47;
  // PTX:453 $L__BB8_42:
L_BB8_42:;
  // PTX:454 mul.f32 %f58, %f8, %f57
  asm("mul.f32 %0, %1, %2;" : "=f"(f58) : "f"(f8), "f"(f57));
  // PTX:455 add.f32 %f59, %f4, %f57
  asm("add.f32 %0, %1, %2;" : "=f"(f59) : "f"(f4), "f"(f57));
  // PTX:456 abs.f32 %f245, %f58
  asm("abs.f32 %0, %1;" : "=f"(f245) : "f"(f58));
  // PTX:457 setp.geu.f32 %p52, %f245, 0f7F800000
  p52 = ((isnan(((float)(f245))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f245)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:458 @%p52 bra $L__BB8_45
  if (p52) { goto L_BB8_45; }
  // PTX:460 abs.f32 %f246, %f59
  asm("abs.f32 %0, %1;" : "=f"(f246) : "f"(f59));
  // PTX:461 setp.geu.f32 %p53, %f246, 0f7F800000
  p53 = ((isnan(((float)(f246))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f246)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:462 @%p53 bra $L__BB8_45
  if (p53) { goto L_BB8_45; }
  // PTX:463 bra.uni $L__BB8_44
  goto L_BB8_44;
  // PTX:465 $L__BB8_45:
L_BB8_45:;
  // PTX:466 min.f32 %f247, %f4, %f57
  asm("min.f32 %0, %1, %2;" : "=f"(f247) : "f"(f4), "f"(f57));
  // PTX:467 max.f32 %f248, %f4, %f57
  asm("max.f32 %0, %1, %2;" : "=f"(f248) : "f"(f4), "f"(f57));
  // PTX:468 div.rn.f32 %f249, %f247, %f248
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f249) : "f"(f247), "f"(f248));
  // PTX:469 add.f32 %f250, %f249, 0f3F800000
  asm("add.f32 %0, %1, 0f3F800000;" : "=f"(f250) : "f"(f249));
  // PTX:470 div.rn.f32 %f251, %f247, %f250
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f251) : "f"(f247), "f"(f250));
  // PTX:471 mul.f32 %f384, %f251, %f123
  asm("mul.f32 %0, %1, %2;" : "=f"(f384) : "f"(f251), "f"(f123));
  // PTX:472 bra.uni $L__BB8_47
  goto L_BB8_47;
  // PTX:474 $L__BB8_44:
L_BB8_44:;
  // PTX:475 div.rn.f32 %f384, %f58, %f59
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f384) : "f"(f58), "f"(f59));
  // PTX:477 $L__BB8_47:
L_BB8_47:;
  // PTX:478 mov.b32 %f360, %r52
  asm("mov.b32 %0, %1;" : "=f"(f360) : "r"(r52));
  // PTX:479 mov.b32 %f359, %r54
  asm("mov.b32 %0, %1;" : "=f"(f359) : "r"(r54));
  // PTX:480 mov.b32 %f358, %r53
  asm("mov.b32 %0, %1;" : "=f"(f358) : "r"(r53));
  // PTX:481 mul.f32 %f357, %f359, %f359
  asm("mul.f32 %0, %1, %2;" : "=f"(f357) : "f"(f359), "f"(f359));
  // PTX:482 mul.f32 %f356, %f358, %f358
  asm("mul.f32 %0, %1, %2;" : "=f"(f356) : "f"(f358), "f"(f358));
  // PTX:483 mul.f32 %f355, %f360, %f360
  asm("mul.f32 %0, %1, %2;" : "=f"(f355) : "f"(f360), "f"(f360));
  // PTX:484 abs.f32 %f354, %f43
  asm("abs.f32 %0, %1;" : "=f"(f354) : "f"(f43));
  // PTX:485 setp.lt.f32 %p54, %f43, 0f00000000
  p54 = (!(isnan(((float)(f43))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f43)) < ((float)(as_f32(0x00000000u)))));
  // PTX:486 selp.f32 %f253, 0fBF800000, 0f00000000, %p54
  f253 = p54 ? as_f32(0xBF800000u) : as_f32(0x00000000u);
  // PTX:487 setp.gt.f32 %p55, %f43, 0f00000000
  p55 = (!(isnan(((float)(f43))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f43)) > ((float)(as_f32(0x00000000u)))));
  // PTX:488 selp.f32 %f254, 0f3F800000, %f253, %p55
  f254 = p55 ? as_f32(0x3F800000u) : f253;
  // PTX:489 sub.f32 %f255, %f7, %f354
  asm("sub.f32 %0, %1, %2;" : "=f"(f255) : "f"(f7), "f"(f354));
  // PTX:490 mul.f32 %f256, %f255, %f384
  asm("mul.f32 %0, %1, %2;" : "=f"(f256) : "f"(f255), "f"(f384));
  // PTX:491 mul.f32 %f257, %f254, %f256
  asm("mul.f32 %0, %1, %2;" : "=f"(f257) : "f"(f254), "f"(f256));
  // PTX:492 mul.f32 %f64, %f257, %f360
  asm("mul.f32 %0, %1, %2;" : "=f"(f64) : "f"(f257), "f"(f360));
  // PTX:493 mul.f32 %f65, %f257, %f358
  asm("mul.f32 %0, %1, %2;" : "=f"(f65) : "f"(f257), "f"(f358));
  // PTX:494 mul.f32 %f66, %f257, %f359
  asm("mul.f32 %0, %1, %2;" : "=f"(f66) : "f"(f257), "f"(f359));
  // PTX:495 mul.f32 %f67, %f355, %f384
  asm("mul.f32 %0, %1, %2;" : "=f"(f67) : "f"(f355), "f"(f384));
  // PTX:496 mul.f32 %f258, %f358, %f360
  asm("mul.f32 %0, %1, %2;" : "=f"(f258) : "f"(f358), "f"(f360));
  // PTX:497 mul.f32 %f68, %f258, %f384
  asm("mul.f32 %0, %1, %2;" : "=f"(f68) : "f"(f258), "f"(f384));
  // PTX:498 mul.f32 %f259, %f359, %f360
  asm("mul.f32 %0, %1, %2;" : "=f"(f259) : "f"(f359), "f"(f360));
  // PTX:499 mul.f32 %f69, %f259, %f384
  asm("mul.f32 %0, %1, %2;" : "=f"(f69) : "f"(f259), "f"(f384));
  // PTX:500 mul.f32 %f70, %f356, %f384
  asm("mul.f32 %0, %1, %2;" : "=f"(f70) : "f"(f356), "f"(f384));
  // PTX:501 mul.f32 %f260, %f359, %f358
  asm("mul.f32 %0, %1, %2;" : "=f"(f260) : "f"(f359), "f"(f358));
  // PTX:502 mul.f32 %f71, %f260, %f384
  asm("mul.f32 %0, %1, %2;" : "=f"(f71) : "f"(f260), "f"(f384));
  // PTX:503 mul.f32 %f72, %f357, %f384
  asm("mul.f32 %0, %1, %2;" : "=f"(f72) : "f"(f357), "f"(f384));
  // PTX:504 abs.f32 %f261, %f64
  asm("abs.f32 %0, %1;" : "=f"(f261) : "f"(f64));
  // PTX:505 setp.geu.f32 %p56, %f261, 0f7F800000
  p56 = ((isnan(((float)(f261))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f261)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:506 mov.u16 %rs47, 0
  asm("mov.u16 %0, 0;" : "=h"(rs47) : );
  // PTX:507 @%p56 bra $L__BB8_50
  if (p56) { goto L_BB8_50; }
  // PTX:509 abs.f32 %f262, %f65
  asm("abs.f32 %0, %1;" : "=f"(f262) : "f"(f65));
  // PTX:510 setp.geu.f32 %p57, %f262, 0f7F800000
  p57 = ((isnan(((float)(f262))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f262)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:511 @%p57 bra $L__BB8_50
  if (p57) { goto L_BB8_50; }
  // PTX:513 abs.f32 %f263, %f66
  asm("abs.f32 %0, %1;" : "=f"(f263) : "f"(f66));
  // PTX:514 setp.lt.f32 %p58, %f263, 0f7F800000
  p58 = (!(isnan(((float)(f263))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f263)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:515 selp.u16 %rs47, 1, 0, %p58
  rs47 = p58 ? 1 : 0;
  // PTX:517 $L__BB8_50:
L_BB8_50:;
  // PTX:518 setp.eq.s16 %p59, %rs47, 0
  p59 = (((short)(rs47)) == ((short)(0)));
  // PTX:519 @%p59 bra $L__BB8_67
  if (p59) { goto L_BB8_67; }
  // PTX:521 abs.f32 %f264, %f67
  asm("abs.f32 %0, %1;" : "=f"(f264) : "f"(f67));
  // PTX:522 setp.geu.f32 %p60, %f264, 0f7F800000
  p60 = ((isnan(((float)(f264))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f264)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:523 mov.u16 %rs48, 0
  asm("mov.u16 %0, 0;" : "=h"(rs48) : );
  // PTX:524 @%p60 bra $L__BB8_54
  if (p60) { goto L_BB8_54; }
  // PTX:526 abs.f32 %f265, %f68
  asm("abs.f32 %0, %1;" : "=f"(f265) : "f"(f68));
  // PTX:527 setp.geu.f32 %p61, %f265, 0f7F800000
  p61 = ((isnan(((float)(f265))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f265)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:528 @%p61 bra $L__BB8_54
  if (p61) { goto L_BB8_54; }
  // PTX:530 abs.f32 %f266, %f69
  asm("abs.f32 %0, %1;" : "=f"(f266) : "f"(f69));
  // PTX:531 setp.lt.f32 %p62, %f266, 0f7F800000
  p62 = (!(isnan(((float)(f266))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f266)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:532 selp.u16 %rs48, 1, 0, %p62
  rs48 = p62 ? 1 : 0;
  // PTX:534 $L__BB8_54:
L_BB8_54:;
  // PTX:535 setp.eq.s16 %p63, %rs48, 0
  p63 = (((short)(rs48)) == ((short)(0)));
  // PTX:536 @%p63 bra $L__BB8_67
  if (p63) { goto L_BB8_67; }
  // PTX:538 abs.f32 %f267, %f68
  asm("abs.f32 %0, %1;" : "=f"(f267) : "f"(f68));
  // PTX:539 setp.geu.f32 %p64, %f267, 0f7F800000
  p64 = ((isnan(((float)(f267))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f267)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:540 mov.u16 %rs49, 0
  asm("mov.u16 %0, 0;" : "=h"(rs49) : );
  // PTX:541 @%p64 bra $L__BB8_58
  if (p64) { goto L_BB8_58; }
  // PTX:543 abs.f32 %f268, %f70
  asm("abs.f32 %0, %1;" : "=f"(f268) : "f"(f70));
  // PTX:544 setp.geu.f32 %p65, %f268, 0f7F800000
  p65 = ((isnan(((float)(f268))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f268)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:545 @%p65 bra $L__BB8_58
  if (p65) { goto L_BB8_58; }
  // PTX:547 abs.f32 %f269, %f71
  asm("abs.f32 %0, %1;" : "=f"(f269) : "f"(f71));
  // PTX:548 setp.lt.f32 %p66, %f269, 0f7F800000
  p66 = (!(isnan(((float)(f269))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f269)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:549 selp.u16 %rs49, 1, 0, %p66
  rs49 = p66 ? 1 : 0;
  // PTX:551 $L__BB8_58:
L_BB8_58:;
  // PTX:552 setp.eq.s16 %p67, %rs49, 0
  p67 = (((short)(rs49)) == ((short)(0)));
  // PTX:553 @%p67 bra $L__BB8_67
  if (p67) { goto L_BB8_67; }
  // PTX:555 abs.f32 %f270, %f69
  asm("abs.f32 %0, %1;" : "=f"(f270) : "f"(f69));
  // PTX:556 setp.geu.f32 %p68, %f270, 0f7F800000
  p68 = ((isnan(((float)(f270))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f270)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:557 mov.u16 %rs50, 0
  asm("mov.u16 %0, 0;" : "=h"(rs50) : );
  // PTX:558 @%p68 bra $L__BB8_62
  if (p68) { goto L_BB8_62; }
  // PTX:560 abs.f32 %f271, %f71
  asm("abs.f32 %0, %1;" : "=f"(f271) : "f"(f71));
  // PTX:561 setp.geu.f32 %p69, %f271, 0f7F800000
  p69 = ((isnan(((float)(f271))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f271)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:562 @%p69 bra $L__BB8_62
  if (p69) { goto L_BB8_62; }
  // PTX:564 abs.f32 %f272, %f72
  asm("abs.f32 %0, %1;" : "=f"(f272) : "f"(f72));
  // PTX:565 setp.lt.f32 %p70, %f272, 0f7F800000
  p70 = (!(isnan(((float)(f272))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f272)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:566 selp.u16 %rs50, 1, 0, %p70
  rs50 = p70 ? 1 : 0;
  // PTX:568 $L__BB8_62:
L_BB8_62:;
  // PTX:569 setp.eq.s16 %p71, %rs50, 0
  p71 = (((short)(rs50)) == ((short)(0)));
  // PTX:570 @%p71 bra $L__BB8_67
  if (p71) { goto L_BB8_67; }
  // PTX:572 ld.param.u64 %rd132, [_ZN7synreal21self_collision_kernel22accumulate_vertex_faceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPKNS2_ILi3EiLS3_0EEES8_S8_SA_ffbfPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_13]
  rd132 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:573 setp.eq.s64 %p72, %rd132, 0
  p72 = (((long long)(rd132)) == ((long long)(0)));
  // PTX:574 add.f32 %f400, %f400, %f64
  asm("add.f32 %0, %1, %2;" : "=f"(f400) : "f"(f400), "f"(f64));
  // PTX:575 add.f32 %f401, %f401, %f65
  asm("add.f32 %0, %1, %2;" : "=f"(f401) : "f"(f401), "f"(f65));
  // PTX:576 add.f32 %f402, %f402, %f66
  asm("add.f32 %0, %1, %2;" : "=f"(f402) : "f"(f402), "f"(f66));
  // PTX:577 add.f32 %f388, %f388, %f67
  asm("add.f32 %0, %1, %2;" : "=f"(f388) : "f"(f388), "f"(f67));
  // PTX:578 add.f32 %f389, %f389, %f68
  asm("add.f32 %0, %1, %2;" : "=f"(f389) : "f"(f389), "f"(f68));
  // PTX:579 add.f32 %f390, %f390, %f69
  asm("add.f32 %0, %1, %2;" : "=f"(f390) : "f"(f390), "f"(f69));
  // PTX:580 add.f32 %f391, %f391, %f68
  asm("add.f32 %0, %1, %2;" : "=f"(f391) : "f"(f391), "f"(f68));
  // PTX:581 add.f32 %f392, %f392, %f70
  asm("add.f32 %0, %1, %2;" : "=f"(f392) : "f"(f392), "f"(f70));
  // PTX:582 add.f32 %f393, %f393, %f71
  asm("add.f32 %0, %1, %2;" : "=f"(f393) : "f"(f393), "f"(f71));
  // PTX:583 add.f32 %f394, %f394, %f69
  asm("add.f32 %0, %1, %2;" : "=f"(f394) : "f"(f394), "f"(f69));
  // PTX:584 add.f32 %f395, %f395, %f71
  asm("add.f32 %0, %1, %2;" : "=f"(f395) : "f"(f395), "f"(f71));
  // PTX:585 add.f32 %f396, %f396, %f72
  asm("add.f32 %0, %1, %2;" : "=f"(f396) : "f"(f396), "f"(f72));
  // PTX:586 @%p72 bra $L__BB8_65
  if (p72) { goto L_BB8_65; }
  // PTX:588 neg.f32 %f385, %f399
  asm("neg.f32 %0, %1;" : "=f"(f385) : "f"(f399));
  // PTX:589 atom.global.add.u32 %r46, [%rd17], 1
  r46 = atomicAdd(reinterpret_cast<unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))), (unsigned)(1));
  // PTX:590 mul.wide.u32 %rd74, %r46, 60
  asm("mul.wide.u32 %0, %1, 60;" : "=l"(rd74) : "r"(r46));
  // PTX:591 add.s64 %rd75, %rd16, %rd74
  asm("add.s64 %0, %1, %2;" : "=l"(rd75) : "l"(rd16), "l"(rd74));
  // PTX:592 st.global.u32 [%rd75], %r2
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (0))))) = (unsigned)(r2);
  // PTX:593 st.global.u32 [%rd75+4], %r9
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (4))))) = (unsigned)(r9);
  // PTX:594 st.global.u32 [%rd75+8], %r12
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (8))))) = (unsigned)(r12);
  // PTX:595 st.global.u32 [%rd75+12], %r15
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (12))))) = (unsigned)(r15);
  // PTX:596 mov.u32 %r47, 0
  asm("mov.u32 %0, 0;" : "=r"(r47) : );
  // PTX:597 st.global.u32 [%rd75+16], %r47
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (16))))) = (unsigned)(r47);
  // PTX:598 mov.u32 %r48, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r48) : );
  // PTX:599 st.global.u32 [%rd75+20], %r48
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (20))))) = (unsigned)(r48);
  // PTX:600 neg.f32 %f387, %f397
  asm("neg.f32 %0, %1;" : "=f"(f387) : "f"(f397));
  // PTX:601 st.global.f32 [%rd75+24], %f387
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (24))))) = (float)(f387);
  // PTX:602 neg.f32 %f386, %f398
  asm("neg.f32 %0, %1;" : "=f"(f386) : "f"(f398));
  // PTX:603 st.global.f32 [%rd75+28], %f386
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (28))))) = (float)(f386);
  // PTX:604 st.global.f32 [%rd75+32], %f385
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (32))))) = (float)(f385);
  // PTX:605 st.global.u32 [%rd75+36], %r47
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (36))))) = (unsigned)(r47);
  // PTX:606 st.global.u32 [%rd75+40], %r52
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (40))))) = (unsigned)(r52);
  // PTX:607 st.global.u32 [%rd75+44], %r53
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (44))))) = (unsigned)(r53);
  // PTX:608 st.global.u32 [%rd75+48], %r54
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (48))))) = (unsigned)(r54);
  // PTX:609 st.global.f32 [%rd75+52], %f384
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (52))))) = (float)(f384);
  // PTX:610 mov.u32 %r49, 4
  asm("mov.u32 %0, 4;" : "=r"(r49) : );
  // PTX:611 st.global.u32 [%rd75+56], %r49
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (56))))) = (unsigned)(r49);
  // PTX:612 bra.uni $L__BB8_66
  goto L_BB8_66;
  // PTX:614 $L__BB8_65:
L_BB8_65:;
  // PTX:615 neg.f32 %f387, %f397
  asm("neg.f32 %0, %1;" : "=f"(f387) : "f"(f397));
  // PTX:616 neg.f32 %f386, %f398
  asm("neg.f32 %0, %1;" : "=f"(f386) : "f"(f398));
  // PTX:617 neg.f32 %f385, %f399
  asm("neg.f32 %0, %1;" : "=f"(f385) : "f"(f399));
  // PTX:619 $L__BB8_66:
L_BB8_66:;
  // PTX:620 mul.lo.s64 %rd76, %rd20, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd76) : "l"(rd20));
  // PTX:621 add.s64 %rd77, %rd2, %rd76
  asm("add.s64 %0, %1, %2;" : "=l"(rd77) : "l"(rd2), "l"(rd76));
  // PTX:622 mul.f32 %f273, %f64, %f387
  asm("mul.f32 %0, %1, %2;" : "=f"(f273) : "f"(f64), "f"(f387));
  // PTX:623 red.global.add.f32 [%rd77], %f273
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (0)))), (float)(f273));
  // PTX:624 add.s64 %rd78, %rd77, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd78) : "l"(rd77));
  // PTX:625 mul.f32 %f275, %f65, %f387
  asm("mul.f32 %0, %1, %2;" : "=f"(f275) : "f"(f65), "f"(f387));
  // PTX:626 red.global.add.f32 [%rd78], %f275
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd78) + (0)))), (float)(f275));
  // PTX:627 add.s64 %rd79, %rd77, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd79) : "l"(rd77));
  // PTX:628 mul.f32 %f277, %f66, %f387
  asm("mul.f32 %0, %1, %2;" : "=f"(f277) : "f"(f66), "f"(f387));
  // PTX:629 red.global.add.f32 [%rd79], %f277
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (0)))), (float)(f277));
  // PTX:630 mul.f32 %f279, %f397, %f397
  asm("mul.f32 %0, %1, %2;" : "=f"(f279) : "f"(f397), "f"(f397));
  // PTX:631 mul.f32 %f280, %f279, %f67
  asm("mul.f32 %0, %1, %2;" : "=f"(f280) : "f"(f279), "f"(f67));
  // PTX:632 mul.f32 %f281, %f279, %f68
  asm("mul.f32 %0, %1, %2;" : "=f"(f281) : "f"(f279), "f"(f68));
  // PTX:633 mul.f32 %f282, %f279, %f69
  asm("mul.f32 %0, %1, %2;" : "=f"(f282) : "f"(f279), "f"(f69));
  // PTX:634 mul.f32 %f283, %f279, %f70
  asm("mul.f32 %0, %1, %2;" : "=f"(f283) : "f"(f279), "f"(f70));
  // PTX:635 mul.f32 %f284, %f279, %f71
  asm("mul.f32 %0, %1, %2;" : "=f"(f284) : "f"(f279), "f"(f71));
  // PTX:636 mul.f32 %f285, %f279, %f72
  asm("mul.f32 %0, %1, %2;" : "=f"(f285) : "f"(f279), "f"(f72));
  // PTX:637 mul.lo.s64 %rd80, %rd20, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd80) : "l"(rd20));
  // PTX:638 add.s64 %rd81, %rd1, %rd80
  asm("add.s64 %0, %1, %2;" : "=l"(rd81) : "l"(rd1), "l"(rd80));
  // PTX:639 red.global.add.f32 [%rd81], %f280
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (0)))), (float)(f280));
  // PTX:640 add.s64 %rd82, %rd81, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd82) : "l"(rd81));
  // PTX:641 red.global.add.f32 [%rd82], %f281
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (0)))), (float)(f281));
  // PTX:642 add.s64 %rd83, %rd81, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd83) : "l"(rd81));
  // PTX:643 red.global.add.f32 [%rd83], %f282
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (0)))), (float)(f282));
  // PTX:644 add.s64 %rd84, %rd81, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd84) : "l"(rd81));
  // PTX:645 red.global.add.f32 [%rd84], %f281
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (0)))), (float)(f281));
  // PTX:646 add.s64 %rd85, %rd81, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd85) : "l"(rd81));
  // PTX:647 red.global.add.f32 [%rd85], %f283
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (0)))), (float)(f283));
  // PTX:648 add.s64 %rd86, %rd81, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd86) : "l"(rd81));
  // PTX:649 red.global.add.f32 [%rd86], %f284
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd86) + (0)))), (float)(f284));
  // PTX:650 add.s64 %rd87, %rd81, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd87) : "l"(rd81));
  // PTX:651 red.global.add.f32 [%rd87], %f282
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (0)))), (float)(f282));
  // PTX:652 add.s64 %rd88, %rd81, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd88) : "l"(rd81));
  // PTX:653 red.global.add.f32 [%rd88], %f284
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (0)))), (float)(f284));
  // PTX:654 add.s64 %rd89, %rd81, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd89) : "l"(rd81));
  // PTX:655 red.global.add.f32 [%rd89], %f285
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (0)))), (float)(f285));
  // PTX:656 mul.lo.s64 %rd90, %rd21, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd90) : "l"(rd21));
  // PTX:657 add.s64 %rd91, %rd2, %rd90
  asm("add.s64 %0, %1, %2;" : "=l"(rd91) : "l"(rd2), "l"(rd90));
  // PTX:658 mul.f32 %f295, %f64, %f386
  asm("mul.f32 %0, %1, %2;" : "=f"(f295) : "f"(f64), "f"(f386));
  // PTX:659 red.global.add.f32 [%rd91], %f295
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (0)))), (float)(f295));
  // PTX:660 add.s64 %rd92, %rd91, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd92) : "l"(rd91));
  // PTX:661 mul.f32 %f297, %f65, %f386
  asm("mul.f32 %0, %1, %2;" : "=f"(f297) : "f"(f65), "f"(f386));
  // PTX:662 red.global.add.f32 [%rd92], %f297
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (0)))), (float)(f297));
  // PTX:663 add.s64 %rd93, %rd91, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd93) : "l"(rd91));
  // PTX:664 mul.f32 %f299, %f66, %f386
  asm("mul.f32 %0, %1, %2;" : "=f"(f299) : "f"(f66), "f"(f386));
  // PTX:665 red.global.add.f32 [%rd93], %f299
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (0)))), (float)(f299));
  // PTX:666 mul.f32 %f301, %f398, %f398
  asm("mul.f32 %0, %1, %2;" : "=f"(f301) : "f"(f398), "f"(f398));
  // PTX:667 mul.f32 %f302, %f301, %f67
  asm("mul.f32 %0, %1, %2;" : "=f"(f302) : "f"(f301), "f"(f67));
  // PTX:668 mul.f32 %f303, %f301, %f68
  asm("mul.f32 %0, %1, %2;" : "=f"(f303) : "f"(f301), "f"(f68));
  // PTX:669 mul.f32 %f304, %f301, %f69
  asm("mul.f32 %0, %1, %2;" : "=f"(f304) : "f"(f301), "f"(f69));
  // PTX:670 mul.f32 %f305, %f301, %f70
  asm("mul.f32 %0, %1, %2;" : "=f"(f305) : "f"(f301), "f"(f70));
  // PTX:671 mul.f32 %f306, %f301, %f71
  asm("mul.f32 %0, %1, %2;" : "=f"(f306) : "f"(f301), "f"(f71));
  // PTX:672 mul.f32 %f307, %f301, %f72
  asm("mul.f32 %0, %1, %2;" : "=f"(f307) : "f"(f301), "f"(f72));
  // PTX:673 mul.lo.s64 %rd94, %rd21, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd94) : "l"(rd21));
  // PTX:674 add.s64 %rd95, %rd1, %rd94
  asm("add.s64 %0, %1, %2;" : "=l"(rd95) : "l"(rd1), "l"(rd94));
  // PTX:675 red.global.add.f32 [%rd95], %f302
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd95) + (0)))), (float)(f302));
  // PTX:676 add.s64 %rd96, %rd95, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd96) : "l"(rd95));
  // PTX:677 red.global.add.f32 [%rd96], %f303
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (0)))), (float)(f303));
  // PTX:678 add.s64 %rd97, %rd95, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd97) : "l"(rd95));
  // PTX:679 red.global.add.f32 [%rd97], %f304
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd97) + (0)))), (float)(f304));
  // PTX:680 add.s64 %rd98, %rd95, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd98) : "l"(rd95));
  // PTX:681 red.global.add.f32 [%rd98], %f303
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (0)))), (float)(f303));
  // PTX:682 add.s64 %rd99, %rd95, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd99) : "l"(rd95));
  // PTX:683 red.global.add.f32 [%rd99], %f305
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (0)))), (float)(f305));
  // PTX:684 add.s64 %rd100, %rd95, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd100) : "l"(rd95));
  // PTX:685 red.global.add.f32 [%rd100], %f306
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (0)))), (float)(f306));
  // PTX:686 add.s64 %rd101, %rd95, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd101) : "l"(rd95));
  // PTX:687 red.global.add.f32 [%rd101], %f304
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd101) + (0)))), (float)(f304));
  // PTX:688 add.s64 %rd102, %rd95, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd102) : "l"(rd95));
  // PTX:689 red.global.add.f32 [%rd102], %f306
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd102) + (0)))), (float)(f306));
  // PTX:690 add.s64 %rd103, %rd95, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd103) : "l"(rd95));
  // PTX:691 red.global.add.f32 [%rd103], %f307
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd103) + (0)))), (float)(f307));
  // PTX:692 mul.lo.s64 %rd104, %rd22, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd104) : "l"(rd22));
  // PTX:693 add.s64 %rd105, %rd2, %rd104
  asm("add.s64 %0, %1, %2;" : "=l"(rd105) : "l"(rd2), "l"(rd104));
  // PTX:694 mul.f32 %f317, %f64, %f385
  asm("mul.f32 %0, %1, %2;" : "=f"(f317) : "f"(f64), "f"(f385));
  // PTX:695 red.global.add.f32 [%rd105], %f317
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (0)))), (float)(f317));
  // PTX:696 add.s64 %rd106, %rd105, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd106) : "l"(rd105));
  // PTX:697 mul.f32 %f319, %f65, %f385
  asm("mul.f32 %0, %1, %2;" : "=f"(f319) : "f"(f65), "f"(f385));
  // PTX:698 red.global.add.f32 [%rd106], %f319
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (0)))), (float)(f319));
  // PTX:699 add.s64 %rd107, %rd105, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd107) : "l"(rd105));
  // PTX:700 mul.f32 %f321, %f66, %f385
  asm("mul.f32 %0, %1, %2;" : "=f"(f321) : "f"(f66), "f"(f385));
  // PTX:701 red.global.add.f32 [%rd107], %f321
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd107) + (0)))), (float)(f321));
  // PTX:702 mul.f32 %f323, %f399, %f399
  asm("mul.f32 %0, %1, %2;" : "=f"(f323) : "f"(f399), "f"(f399));
  // PTX:703 mul.f32 %f324, %f323, %f67
  asm("mul.f32 %0, %1, %2;" : "=f"(f324) : "f"(f323), "f"(f67));
  // PTX:704 mul.f32 %f325, %f323, %f68
  asm("mul.f32 %0, %1, %2;" : "=f"(f325) : "f"(f323), "f"(f68));
  // PTX:705 mul.f32 %f326, %f323, %f69
  asm("mul.f32 %0, %1, %2;" : "=f"(f326) : "f"(f323), "f"(f69));
  // PTX:706 mul.f32 %f327, %f323, %f70
  asm("mul.f32 %0, %1, %2;" : "=f"(f327) : "f"(f323), "f"(f70));
  // PTX:707 mul.f32 %f328, %f323, %f71
  asm("mul.f32 %0, %1, %2;" : "=f"(f328) : "f"(f323), "f"(f71));
  // PTX:708 mul.f32 %f329, %f323, %f72
  asm("mul.f32 %0, %1, %2;" : "=f"(f329) : "f"(f323), "f"(f72));
  // PTX:709 mul.lo.s64 %rd108, %rd22, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd108) : "l"(rd22));
  // PTX:710 add.s64 %rd109, %rd1, %rd108
  asm("add.s64 %0, %1, %2;" : "=l"(rd109) : "l"(rd1), "l"(rd108));
  // PTX:711 red.global.add.f32 [%rd109], %f324
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd109) + (0)))), (float)(f324));
  // PTX:712 add.s64 %rd110, %rd109, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd110) : "l"(rd109));
  // PTX:713 red.global.add.f32 [%rd110], %f325
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd110) + (0)))), (float)(f325));
  // PTX:714 add.s64 %rd111, %rd109, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd111) : "l"(rd109));
  // PTX:715 red.global.add.f32 [%rd111], %f326
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd111) + (0)))), (float)(f326));
  // PTX:716 add.s64 %rd112, %rd109, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd112) : "l"(rd109));
  // PTX:717 red.global.add.f32 [%rd112], %f325
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd112) + (0)))), (float)(f325));
  // PTX:718 add.s64 %rd113, %rd109, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd113) : "l"(rd109));
  // PTX:719 red.global.add.f32 [%rd113], %f327
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd113) + (0)))), (float)(f327));
  // PTX:720 add.s64 %rd114, %rd109, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd114) : "l"(rd109));
  // PTX:721 red.global.add.f32 [%rd114], %f328
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd114) + (0)))), (float)(f328));
  // PTX:722 add.s64 %rd115, %rd109, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd115) : "l"(rd109));
  // PTX:723 red.global.add.f32 [%rd115], %f326
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd115) + (0)))), (float)(f326));
  // PTX:724 add.s64 %rd116, %rd109, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd116) : "l"(rd109));
  // PTX:725 red.global.add.f32 [%rd116], %f328
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd116) + (0)))), (float)(f328));
  // PTX:726 add.s64 %rd117, %rd109, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd117) : "l"(rd109));
  // PTX:727 red.global.add.f32 [%rd117], %f329
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd117) + (0)))), (float)(f329));
  // PTX:728 ld.global.u32 %r55, [%rd14]
  r55 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:730 $L__BB8_67:
L_BB8_67:;
  // PTX:731 add.s32 %r51, %r51, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r51) : "r"(r51));
  // PTX:732 setp.lt.s32 %p73, %r51, %r55
  p73 = (((int)(r51)) < ((int)(r55)));
  // PTX:733 @%p73 bra $L__BB8_14
  if (p73) { goto L_BB8_14; }
  // PTX:735 $L__BB8_68:
L_BB8_68:;
  // PTX:736 cvt.s64.s32 %rd133, %r2
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd133) : "r"(r2));
  // PTX:737 mul.lo.s64 %rd118, %rd133, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd118) : "l"(rd133));
  // PTX:738 add.s64 %rd119, %rd2, %rd118
  asm("add.s64 %0, %1, %2;" : "=l"(rd119) : "l"(rd2), "l"(rd118));
  // PTX:739 red.global.add.f32 [%rd119], %f400
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd119) + (0)))), (float)(f400));
  // PTX:740 add.s64 %rd120, %rd119, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd120) : "l"(rd119));
  // PTX:741 red.global.add.f32 [%rd120], %f401
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd120) + (0)))), (float)(f401));
  // PTX:742 add.s64 %rd121, %rd119, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd121) : "l"(rd119));
  // PTX:743 red.global.add.f32 [%rd121], %f402
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd121) + (0)))), (float)(f402));
  // PTX:744 mul.lo.s64 %rd122, %rd133, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd122) : "l"(rd133));
  // PTX:745 add.s64 %rd123, %rd1, %rd122
  asm("add.s64 %0, %1, %2;" : "=l"(rd123) : "l"(rd1), "l"(rd122));
  // PTX:746 red.global.add.f32 [%rd123], %f388
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd123) + (0)))), (float)(f388));
  // PTX:747 add.s64 %rd124, %rd123, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd124) : "l"(rd123));
  // PTX:748 red.global.add.f32 [%rd124], %f389
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd124) + (0)))), (float)(f389));
  // PTX:749 add.s64 %rd125, %rd123, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd125) : "l"(rd123));
  // PTX:750 red.global.add.f32 [%rd125], %f390
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd125) + (0)))), (float)(f390));
  // PTX:751 add.s64 %rd126, %rd123, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd126) : "l"(rd123));
  // PTX:752 red.global.add.f32 [%rd126], %f391
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd126) + (0)))), (float)(f391));
  // PTX:753 add.s64 %rd127, %rd123, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd127) : "l"(rd123));
  // PTX:754 red.global.add.f32 [%rd127], %f392
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd127) + (0)))), (float)(f392));
  // PTX:755 add.s64 %rd128, %rd123, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd128) : "l"(rd123));
  // PTX:756 red.global.add.f32 [%rd128], %f393
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd128) + (0)))), (float)(f393));
  // PTX:757 add.s64 %rd129, %rd123, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd129) : "l"(rd123));
  // PTX:758 red.global.add.f32 [%rd129], %f394
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd129) + (0)))), (float)(f394));
  // PTX:759 add.s64 %rd130, %rd123, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd130) : "l"(rd123));
  // PTX:760 red.global.add.f32 [%rd130], %f395
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd130) + (0)))), (float)(f395));
  // PTX:761 add.s64 %rd131, %rd123, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd131) : "l"(rd123));
  // PTX:762 red.global.add.f32 [%rd131], %f396
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd131) + (0)))), (float)(f396));
  // PTX:764 $L__BB8_69:
L_BB8_69:;
  // PTX:765 ret
  return;
}
