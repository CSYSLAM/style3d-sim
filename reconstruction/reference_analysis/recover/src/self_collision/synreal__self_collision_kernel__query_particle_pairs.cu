// 机械还原自 PTX：synreal::self_collision_kernel::query_particle_pairs(glm::vec<3, float, (glm::qualifier)0> const*, int const*, float const*, int const*, int const*, synreal::Aabb const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, int const*, int const*, int const*, int*, int*, unsigned long, unsigned long, unsigned long, int)
// PTX SHA256: 3926327ededb1fcad503e97aaa8f425f0d0fe5d89e9088db005139c4b5890ec5
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__self_collision_kernel__query_particle_pairs(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10, unsigned long long param11, unsigned long long param12, unsigned long long param13, unsigned long long param14, unsigned long long param15, unsigned param16) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51;
  unsigned short rs0, rs1, rs2, rs3, rs4, rs5, rs6, rs7, rs8, rs9, rs10, rs11, rs12, rs13, rs14, rs15, rs16, rs17, rs18, rs19, rs20, rs21, rs22, rs23, rs24, rs25, rs26, rs27;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135, rd136, rd137, rd138, rd139, rd140;
  // PTX:34 ld.param.u64 %rd45, [_ZN7synreal21self_collision_kernel20query_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_S8_S8_PiSH_mmmi_param_0]
  rd45 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:35 ld.param.u64 %rd46, [_ZN7synreal21self_collision_kernel20query_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_S8_S8_PiSH_mmmi_param_1]
  rd46 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:36 ld.param.u64 %rd47, [_ZN7synreal21self_collision_kernel20query_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_S8_S8_PiSH_mmmi_param_2]
  rd47 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:37 ld.param.u64 %rd40, [_ZN7synreal21self_collision_kernel20query_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_S8_S8_PiSH_mmmi_param_3]
  rd40 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:38 ld.param.u64 %rd48, [_ZN7synreal21self_collision_kernel20query_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_S8_S8_PiSH_mmmi_param_4]
  rd48 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:39 ld.param.u64 %rd49, [_ZN7synreal21self_collision_kernel20query_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_S8_S8_PiSH_mmmi_param_5]
  rd49 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:40 ld.param.u64 %rd50, [_ZN7synreal21self_collision_kernel20query_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_S8_S8_PiSH_mmmi_param_6]
  rd50 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:41 ld.param.u64 %rd51, [_ZN7synreal21self_collision_kernel20query_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_S8_S8_PiSH_mmmi_param_7]
  rd51 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:42 ld.param.u64 %rd52, [_ZN7synreal21self_collision_kernel20query_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_S8_S8_PiSH_mmmi_param_8]
  rd52 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:43 ld.param.u64 %rd53, [_ZN7synreal21self_collision_kernel20query_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_S8_S8_PiSH_mmmi_param_9]
  rd53 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:44 ld.param.u64 %rd41, [_ZN7synreal21self_collision_kernel20query_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_S8_S8_PiSH_mmmi_param_10]
  rd41 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:45 ld.param.u64 %rd54, [_ZN7synreal21self_collision_kernel20query_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_S8_S8_PiSH_mmmi_param_12]
  rd54 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:46 ld.param.u64 %rd55, [_ZN7synreal21self_collision_kernel20query_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_S8_S8_PiSH_mmmi_param_13]
  rd55 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:47 ld.param.u64 %rd43, [_ZN7synreal21self_collision_kernel20query_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_S8_S8_PiSH_mmmi_param_14]
  rd43 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:48 ld.param.u64 %rd44, [_ZN7synreal21self_collision_kernel20query_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_S8_S8_PiSH_mmmi_param_15]
  rd44 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param15 + (0))));
  // PTX:49 ld.param.u32 %r28, [_ZN7synreal21self_collision_kernel20query_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_S8_S8_PiSH_mmmi_param_16]
  r28 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param16 + (0))));
  // PTX:50 cvta.to.global.u64 %rd1, %rd54
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd54));
  // PTX:51 cvta.to.global.u64 %rd2, %rd40
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd40));
  // PTX:52 cvta.to.global.u64 %rd3, %rd48
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd48));
  // PTX:53 cvta.to.global.u64 %rd4, %rd52
  rd4 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd52));
  // PTX:54 cvta.to.global.u64 %rd5, %rd49
  rd5 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd49));
  // PTX:55 cvta.to.global.u64 %rd6, %rd53
  rd6 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd53));
  // PTX:56 cvta.to.global.u64 %rd7, %rd51
  rd7 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd51));
  // PTX:57 cvta.to.global.u64 %rd8, %rd50
  rd8 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd50));
  // PTX:58 cvta.to.global.u64 %rd9, %rd47
  rd9 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd47));
  // PTX:59 cvta.to.global.u64 %rd10, %rd45
  rd10 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd45));
  // PTX:60 cvta.to.global.u64 %rd11, %rd46
  rd11 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd46));
  // PTX:61 mov.u32 %r29, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r29) : "r"(blockIdx.x));
  // PTX:62 mov.u32 %r30, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r30) : "r"(blockDim.x));
  // PTX:63 mul.wide.u32 %rd56, %r29, %r30
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd56) : "r"(r29), "r"(r30));
  // PTX:64 mov.u32 %r31, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r31) : "r"(threadIdx.x));
  // PTX:65 cvt.u64.u32 %rd57, %r31
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd57) : "r"(r31));
  // PTX:66 add.s64 %rd12, %rd56, %rd57
  asm("add.s64 %0, %1, %2;" : "=l"(rd12) : "l"(rd56), "l"(rd57));
  // PTX:67 setp.ge.u64 %p1, %rd12, %rd55
  p1 = (((unsigned long long)(rd12)) >= ((unsigned long long)(rd55)));
  // PTX:68 @%p1 bra $L__BB5_45
  if (p1) { goto L_BB5_45; }
  // PTX:70 or.b64 %rd58, %rd12, %rd43
  asm("or.b64 %0, %1, %2;" : "=l"(rd58) : "l"(rd12), "l"(rd43));
  // PTX:71 and.b64 %rd59, %rd58, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd59) : "l"(rd58));
  // PTX:72 setp.eq.s64 %p2, %rd59, 0
  p2 = (((long long)(rd59)) == ((long long)(0)));
  // PTX:73 @%p2 bra $L__BB5_3
  if (p2) { goto L_BB5_3; }
  // PTX:75 div.u64 %rd137, %rd12, %rd43
  asm("div.u64 %0, %1, %2;" : "=l"(rd137) : "l"(rd12), "l"(rd43));
  // PTX:76 mul.lo.s64 %rd60, %rd137, %rd43
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd60) : "l"(rd137), "l"(rd43));
  // PTX:77 sub.s64 %rd138, %rd12, %rd60
  asm("sub.s64 %0, %1, %2;" : "=l"(rd138) : "l"(rd12), "l"(rd60));
  // PTX:78 bra.uni $L__BB5_4
  goto L_BB5_4;
  // PTX:80 $L__BB5_3:
L_BB5_3:;
  // PTX:81 cvt.u32.u64 %r32, %rd43
  asm("cvt.u32.u64 %0, %1;" : "=r"(r32) : "l"(rd43));
  // PTX:82 cvt.u32.u64 %r33, %rd12
  asm("cvt.u32.u64 %0, %1;" : "=r"(r33) : "l"(rd12));
  // PTX:83 div.u32 %r34, %r33, %r32
  asm("div.u32 %0, %1, %2;" : "=r"(r34) : "r"(r33), "r"(r32));
  // PTX:84 mul.lo.s32 %r35, %r34, %r32
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r35) : "r"(r34), "r"(r32));
  // PTX:85 sub.s32 %r36, %r33, %r35
  asm("sub.s32 %0, %1, %2;" : "=r"(r36) : "r"(r33), "r"(r35));
  // PTX:86 cvt.u64.u32 %rd137, %r34
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd137) : "r"(r34));
  // PTX:87 cvt.u64.u32 %rd138, %r36
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd138) : "r"(r36));
  // PTX:89 $L__BB5_4:
L_BB5_4:;
  // PTX:90 shl.b64 %rd61, %rd138, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd61) : "l"(rd138));
  // PTX:91 add.s64 %rd62, %rd11, %rd61
  asm("add.s64 %0, %1, %2;" : "=l"(rd62) : "l"(rd11), "l"(rd61));
  // PTX:92 ld.global.u32 %r38, [%rd62]
  r38 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))));
  // PTX:93 cvt.s64.s32 %rd19, %r38
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd19) : "r"(r38));
  // PTX:94 mul.lo.s64 %rd20, %rd137, %rd44
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd20) : "l"(rd137), "l"(rd44));
  // PTX:95 add.s64 %rd63, %rd20, %rd19
  asm("add.s64 %0, %1, %2;" : "=l"(rd63) : "l"(rd20), "l"(rd19));
  // PTX:96 mul.lo.s64 %rd64, %rd63, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd64) : "l"(rd63));
  // PTX:97 add.s64 %rd65, %rd10, %rd64
  asm("add.s64 %0, %1, %2;" : "=l"(rd65) : "l"(rd10), "l"(rd64));
  // PTX:98 mul.wide.s32 %rd66, %r38, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd66) : "r"(r38));
  // PTX:99 add.s64 %rd67, %rd9, %rd66
  asm("add.s64 %0, %1, %2;" : "=l"(rd67) : "l"(rd9), "l"(rd66));
  // PTX:100 ld.global.f32 %f1, [%rd67]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0)))));
  // PTX:101 ld.global.f32 %f2, [%rd65]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (0)))));
  // PTX:102 sub.f32 %f3, %f2, %f1
  asm("sub.f32 %0, %1, %2;" : "=f"(f3) : "f"(f2), "f"(f1));
  // PTX:103 ld.global.f32 %f4, [%rd65+4]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (4)))));
  // PTX:104 sub.f32 %f5, %f4, %f1
  asm("sub.f32 %0, %1, %2;" : "=f"(f5) : "f"(f4), "f"(f1));
  // PTX:105 ld.global.f32 %f6, [%rd65+8]
  f6 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (8)))));
  // PTX:106 sub.f32 %f7, %f6, %f1
  asm("sub.f32 %0, %1, %2;" : "=f"(f7) : "f"(f6), "f"(f1));
  // PTX:107 add.f32 %f8, %f2, %f1
  asm("add.f32 %0, %1, %2;" : "=f"(f8) : "f"(f2), "f"(f1));
  // PTX:108 add.f32 %f9, %f4, %f1
  asm("add.f32 %0, %1, %2;" : "=f"(f9) : "f"(f4), "f"(f1));
  // PTX:109 add.f32 %f10, %f6, %f1
  asm("add.f32 %0, %1, %2;" : "=f"(f10) : "f"(f6), "f"(f1));
  // PTX:110 cvt.u32.u64 %r39, %rd43
  asm("cvt.u32.u64 %0, %1;" : "=r"(r39) : "l"(rd43));
  // PTX:111 add.s32 %r1, %r39, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r1) : "r"(r39));
  // PTX:112 shl.b64 %rd68, %rd43, 1
  asm("shl.b64 %0, %1, 1;" : "=l"(rd68) : "l"(rd43));
  // PTX:113 add.s64 %rd69, %rd68, -1
  asm("add.s64 %0, %1, -1;" : "=l"(rd69) : "l"(rd68));
  // PTX:114 mul.lo.s64 %rd21, %rd137, %rd69
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd21) : "l"(rd137), "l"(rd69));
  // PTX:115 cvta.to.global.u64 %rd70, %rd41
  rd70 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd41));
  // PTX:116 add.s64 %rd71, %rd70, %rd61
  asm("add.s64 %0, %1, %2;" : "=l"(rd71) : "l"(rd70), "l"(rd61));
  // PTX:117 ld.global.u32 %r63, [%rd71]
  r63 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))));
  // PTX:118 mul.wide.s32 %rd72, %r63, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd72) : "r"(r63));
  // PTX:119 add.s64 %rd73, %rd8, %rd72
  asm("add.s64 %0, %1, %2;" : "=l"(rd73) : "l"(rd8), "l"(rd72));
  // PTX:120 ld.global.u32 %r62, [%rd73]
  r62 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (0)))));
  // PTX:121 setp.lt.s32 %p3, %r62, 0
  p3 = (((int)(r62)) < ((int)(0)));
  // PTX:122 setp.lt.s32 %p4, %r28, 1
  p4 = (((int)(r28)) < ((int)(1)));
  // PTX:123 mov.u32 %r67, 0
  asm("mov.u32 %0, 0;" : "=r"(r67) : );
  // PTX:124 or.pred %p5, %p4, %p3
  p5 = ((p4) || (p3));
  // PTX:125 @%p5 bra $L__BB5_44
  if (p5) { goto L_BB5_44; }
  // PTX:127 shl.b64 %rd74, %rd19, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd74) : "l"(rd19));
  // PTX:128 add.s64 %rd22, %rd3, %rd74
  asm("add.s64 %0, %1, %2;" : "=l"(rd22) : "l"(rd3), "l"(rd74));
  // PTX:129 add.s64 %rd23, %rd2, %rd74
  asm("add.s64 %0, %1, %2;" : "=l"(rd23) : "l"(rd2), "l"(rd74));
  // PTX:130 cvt.s64.s32 %rd75, %r28
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd75) : "r"(r28));
  // PTX:131 mul.lo.s64 %rd24, %rd12, %rd75
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd24) : "l"(rd12), "l"(rd75));
  // PTX:132 mov.u32 %r67, 0
  asm("mov.u32 %0, 0;" : "=r"(r67) : );
  // PTX:134 $L__BB5_6:
L_BB5_6:;
  // PTX:135 mov.u32 %r5, %r63
  asm("mov.u32 %0, %1;" : "=r"(r5) : "r"(r63));
  // PTX:136 mov.u32 %r63, %r62
  asm("mov.u32 %0, %1;" : "=r"(r63) : "r"(r62));
  // PTX:137 mul.wide.s32 %rd76, %r63, 8
  asm("mul.wide.s32 %0, %1, 8;" : "=l"(rd76) : "r"(r63));
  // PTX:138 add.s64 %rd77, %rd7, %rd76
  asm("add.s64 %0, %1, %2;" : "=l"(rd77) : "l"(rd7), "l"(rd76));
  // PTX:139 ld.global.u32 %r41, [%rd77]
  r41 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (0)))));
  // PTX:140 setp.eq.s32 %p6, %r41, %r5
  p6 = (((int)(r41)) == ((int)(r5)));
  // PTX:141 ld.global.u32 %r42, [%rd77+4]
  r42 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (4)))));
  // PTX:142 selp.b32 %r65, %r42, %r41, %p6
  r65 = p6 ? r42 : r41;
  // PTX:143 mul.wide.s32 %rd78, %r65, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd78) : "r"(r65));
  // PTX:144 add.s64 %rd79, %rd6, %rd78
  asm("add.s64 %0, %1, %2;" : "=l"(rd79) : "l"(rd6), "l"(rd78));
  // PTX:145 ld.global.u32 %r8, [%rd79]
  r8 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (0)))));
  // PTX:146 setp.eq.s32 %p7, %r65, %r8
  p7 = (((int)(r65)) == ((int)(r8)));
  // PTX:147 setp.lt.s32 %p8, %r65, 0
  p8 = (((int)(r65)) < ((int)(0)));
  // PTX:148 or.pred %p9, %p8, %p7
  p9 = ((p8) || (p7));
  // PTX:149 setp.ge.s32 %p10, %r67, %r28
  p10 = (((int)(r67)) >= ((int)(r28)));
  // PTX:150 or.pred %p11, %p10, %p9
  p11 = ((p10) || (p9));
  // PTX:151 @%p11 bra $L__BB5_43
  if (p11) { goto L_BB5_43; }
  // PTX:153 ld.param.u64 %rd130, [_ZN7synreal21self_collision_kernel20query_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_S8_S8_PiSH_mmmi_param_3]
  rd130 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:154 setp.eq.s64 %p12, %rd130, 0
  p12 = (((long long)(rd130)) == ((long long)(0)));
  // PTX:155 @%p12 bra $L__BB5_26
  if (p12) { goto L_BB5_26; }
  // PTX:157 $L__BB5_8:
L_BB5_8:;
  // PTX:158 cvt.s64.s32 %rd26, %r65
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd26) : "r"(r65));
  // PTX:159 add.s64 %rd80, %rd21, %rd26
  asm("add.s64 %0, %1, %2;" : "=l"(rd80) : "l"(rd21), "l"(rd26));
  // PTX:160 mul.lo.s64 %rd81, %rd80, 24
  asm("mul.lo.s64 %0, %1, 24;" : "=l"(rd81) : "l"(rd80));
  // PTX:161 add.s64 %rd82, %rd5, %rd81
  asm("add.s64 %0, %1, %2;" : "=l"(rd82) : "l"(rd5), "l"(rd81));
  // PTX:162 add.s64 %rd27, %rd82, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd27) : "l"(rd82));
  // PTX:163 ld.global.f32 %f11, [%rd82+12]
  f11 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (12)))));
  // PTX:164 setp.gtu.f32 %p13, %f3, %f11
  p13 = ((isnan(((float)(f3))) || isnan(((float)(f11)))) || (((float)(f3)) > ((float)(f11))));
  // PTX:165 mov.u16 %rs26, 0
  asm("mov.u16 %0, 0;" : "=h"(rs26) : );
  // PTX:166 @%p13 bra $L__BB5_14
  if (p13) { goto L_BB5_14; }
  // PTX:168 mov.u16 %rs26, 0
  asm("mov.u16 %0, 0;" : "=h"(rs26) : );
  // PTX:169 ld.global.f32 %f12, [%rd27+-12]
  f12 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (-12)))));
  // PTX:170 setp.ltu.f32 %p14, %f8, %f12
  p14 = ((isnan(((float)(f8))) || isnan(((float)(f12)))) || (((float)(f8)) < ((float)(f12))));
  // PTX:171 @%p14 bra $L__BB5_14
  if (p14) { goto L_BB5_14; }
  // PTX:173 mov.u16 %rs26, 0
  asm("mov.u16 %0, 0;" : "=h"(rs26) : );
  // PTX:174 ld.global.f32 %f13, [%rd27+4]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (4)))));
  // PTX:175 setp.gtu.f32 %p15, %f5, %f13
  p15 = ((isnan(((float)(f5))) || isnan(((float)(f13)))) || (((float)(f5)) > ((float)(f13))));
  // PTX:176 @%p15 bra $L__BB5_14
  if (p15) { goto L_BB5_14; }
  // PTX:178 mov.u16 %rs26, 0
  asm("mov.u16 %0, 0;" : "=h"(rs26) : );
  // PTX:179 ld.global.f32 %f14, [%rd27+-8]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (-8)))));
  // PTX:180 setp.ltu.f32 %p16, %f9, %f14
  p16 = ((isnan(((float)(f9))) || isnan(((float)(f14)))) || (((float)(f9)) < ((float)(f14))));
  // PTX:181 @%p16 bra $L__BB5_14
  if (p16) { goto L_BB5_14; }
  // PTX:183 mov.u16 %rs26, 0
  asm("mov.u16 %0, 0;" : "=h"(rs26) : );
  // PTX:184 ld.global.f32 %f15, [%rd27+8]
  f15 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (8)))));
  // PTX:185 setp.gtu.f32 %p17, %f7, %f15
  p17 = ((isnan(((float)(f7))) || isnan(((float)(f15)))) || (((float)(f7)) > ((float)(f15))));
  // PTX:186 @%p17 bra $L__BB5_14
  if (p17) { goto L_BB5_14; }
  // PTX:188 ld.global.f32 %f16, [%rd27+-4]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (-4)))));
  // PTX:189 setp.ge.f32 %p18, %f10, %f16
  p18 = (!(isnan(((float)(f10))) || isnan(((float)(f16)))) && (((float)(f10)) >= ((float)(f16))));
  // PTX:190 selp.u16 %rs26, 1, 0, %p18
  rs26 = p18 ? 1 : 0;
  // PTX:192 $L__BB5_14:
L_BB5_14:;
  // PTX:193 setp.eq.s16 %p19, %rs26, 0
  p19 = (((short)(rs26)) == ((short)(0)));
  // PTX:194 @%p19 bra $L__BB5_24
  if (p19) { goto L_BB5_24; }
  // PTX:196 cvt.u32.u64 %r43, %rd26
  asm("cvt.u32.u64 %0, %1;" : "=r"(r43) : "l"(rd26));
  // PTX:197 setp.lt.s32 %p20, %r43, %r1
  p20 = (((int)(r43)) < ((int)(r1)));
  // PTX:198 @%p20 bra $L__BB5_23
  if (p20) { goto L_BB5_23; }
  // PTX:199 bra.uni $L__BB5_16
  goto L_BB5_16;
  // PTX:201 $L__BB5_23:
L_BB5_23:;
  // PTX:202 shl.b64 %rd101, %rd26, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd101) : "l"(rd26));
  // PTX:203 add.s64 %rd139, %rd7, %rd101
  asm("add.s64 %0, %1, %2;" : "=l"(rd139) : "l"(rd7), "l"(rd101));
  // PTX:204 bra.uni $L__BB5_25
  goto L_BB5_25;
  // PTX:206 $L__BB5_24:
L_BB5_24:;
  // PTX:207 shl.b64 %rd102, %rd26, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd102) : "l"(rd26));
  // PTX:208 add.s64 %rd139, %rd6, %rd102
  asm("add.s64 %0, %1, %2;" : "=l"(rd139) : "l"(rd6), "l"(rd102));
  // PTX:209 bra.uni $L__BB5_25
  goto L_BB5_25;
  // PTX:211 $L__BB5_16:
L_BB5_16:;
  // PTX:212 sub.s32 %r45, %r43, %r1
  asm("sub.s32 %0, %1, %2;" : "=r"(r45) : "r"(r43), "r"(r1));
  // PTX:213 mul.wide.s32 %rd83, %r45, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd83) : "r"(r45));
  // PTX:214 add.s64 %rd84, %rd4, %rd83
  asm("add.s64 %0, %1, %2;" : "=l"(rd84) : "l"(rd4), "l"(rd83));
  // PTX:215 ld.global.u32 %r46, [%rd84]
  r46 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (0)))));
  // PTX:216 mul.wide.s32 %rd85, %r46, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd85) : "r"(r46));
  // PTX:217 add.s64 %rd86, %rd11, %rd85
  asm("add.s64 %0, %1, %2;" : "=l"(rd86) : "l"(rd11), "l"(rd85));
  // PTX:218 ld.global.u32 %r11, [%rd86]
  r11 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd86) + (0)))));
  // PTX:219 cvt.s64.s32 %rd28, %r11
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd28) : "r"(r11));
  // PTX:220 cvt.u32.u64 %r47, %rd19
  asm("cvt.u32.u64 %0, %1;" : "=r"(r47) : "l"(rd19));
  // PTX:221 setp.le.s32 %p21, %r11, %r47
  p21 = (((int)(r11)) <= ((int)(r47)));
  // PTX:222 @%p21 bra $L__BB5_22
  if (p21) { goto L_BB5_22; }
  // PTX:224 ld.global.u32 %r12, [%rd22]
  r12 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (0)))));
  // PTX:225 setp.eq.s32 %p22, %r12, 0
  p22 = (((int)(r12)) == ((int)(0)));
  // PTX:226 @%p22 bra $L__BB5_19
  if (p22) { goto L_BB5_19; }
  // PTX:228 shl.b64 %rd87, %rd28, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd87) : "l"(rd28));
  // PTX:229 add.s64 %rd88, %rd3, %rd87
  asm("add.s64 %0, %1, %2;" : "=l"(rd88) : "l"(rd3), "l"(rd87));
  // PTX:230 ld.global.u32 %r48, [%rd88]
  r48 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (0)))));
  // PTX:231 setp.eq.s32 %p23, %r12, %r48
  p23 = (((int)(r12)) == ((int)(r48)));
  // PTX:232 @%p23 bra $L__BB5_22
  if (p23) { goto L_BB5_22; }
  // PTX:234 $L__BB5_19:
L_BB5_19:;
  // PTX:235 ld.global.u32 %r49, [%rd23]
  r49 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (0)))));
  // PTX:236 shl.b64 %rd89, %rd28, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd89) : "l"(rd28));
  // PTX:237 add.s64 %rd90, %rd2, %rd89
  asm("add.s64 %0, %1, %2;" : "=l"(rd90) : "l"(rd2), "l"(rd89));
  // PTX:238 ld.global.u32 %r50, [%rd90]
  r50 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (0)))));
  // PTX:239 or.b32 %r51, %r50, %r49
  asm("or.b32 %0, %1, %2;" : "=r"(r51) : "r"(r50), "r"(r49));
  // PTX:240 setp.eq.s32 %p24, %r49, %r50
  p24 = (((int)(r49)) == ((int)(r50)));
  // PTX:241 selp.u16 %rs10, 1, 0, %p24
  rs10 = p24 ? 1 : 0;
  // PTX:242 shr.u32 %r52, %r51, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r52) : "r"(r51));
  // PTX:243 cvt.u16.u32 %rs11, %r52
  asm("cvt.u16.u32 %0, %1;" : "=h"(rs11) : "r"(r52));
  // PTX:244 or.b16 %rs12, %rs11, %rs10
  asm("or.b16 %0, %1, %2;" : "=h"(rs12) : "h"(rs11), "h"(rs10));
  // PTX:245 setp.eq.s16 %p25, %rs12, 0
  p25 = (((short)(rs12)) == ((short)(0)));
  // PTX:246 @%p25 bra $L__BB5_22
  if (p25) { goto L_BB5_22; }
  // PTX:248 add.s64 %rd91, %rd20, %rd28
  asm("add.s64 %0, %1, %2;" : "=l"(rd91) : "l"(rd20), "l"(rd28));
  // PTX:249 mul.lo.s64 %rd92, %rd91, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd92) : "l"(rd91));
  // PTX:250 add.s64 %rd93, %rd10, %rd92
  asm("add.s64 %0, %1, %2;" : "=l"(rd93) : "l"(rd10), "l"(rd92));
  // PTX:251 ld.global.f32 %f17, [%rd93]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (0)))));
  // PTX:252 sub.f32 %f18, %f2, %f17
  asm("sub.f32 %0, %1, %2;" : "=f"(f18) : "f"(f2), "f"(f17));
  // PTX:253 ld.global.f32 %f19, [%rd93+4]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (4)))));
  // PTX:254 sub.f32 %f20, %f4, %f19
  asm("sub.f32 %0, %1, %2;" : "=f"(f20) : "f"(f4), "f"(f19));
  // PTX:255 ld.global.f32 %f21, [%rd93+8]
  f21 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (8)))));
  // PTX:256 sub.f32 %f22, %f6, %f21
  asm("sub.f32 %0, %1, %2;" : "=f"(f22) : "f"(f6), "f"(f21));
  // PTX:257 add.s64 %rd95, %rd9, %rd89
  asm("add.s64 %0, %1, %2;" : "=l"(rd95) : "l"(rd9), "l"(rd89));
  // PTX:258 ld.global.f32 %f23, [%rd95]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd95) + (0)))));
  // PTX:259 add.f32 %f24, %f1, %f23
  asm("add.f32 %0, %1, %2;" : "=f"(f24) : "f"(f1), "f"(f23));
  // PTX:260 mul.f32 %f25, %f20, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f25) : "f"(f20), "f"(f20));
  // PTX:261 fma.rn.f32 %f26, %f18, %f18, %f25
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f26) : "f"(f18), "f"(f18), "f"(f25));
  // PTX:262 fma.rn.f32 %f27, %f22, %f22, %f26
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f27) : "f"(f22), "f"(f22), "f"(f26));
  // PTX:263 mul.f32 %f28, %f24, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f28) : "f"(f24), "f"(f24));
  // PTX:264 setp.geu.f32 %p26, %f27, %f28
  p26 = ((isnan(((float)(f27))) || isnan(((float)(f28)))) || (((float)(f27)) >= ((float)(f28))));
  // PTX:265 @%p26 bra $L__BB5_22
  if (p26) { goto L_BB5_22; }
  // PTX:267 cvt.s64.s32 %rd96, %r67
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd96) : "r"(r67));
  // PTX:268 add.s64 %rd97, %rd24, %rd96
  asm("add.s64 %0, %1, %2;" : "=l"(rd97) : "l"(rd24), "l"(rd96));
  // PTX:269 shl.b64 %rd98, %rd97, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd98) : "l"(rd97));
  // PTX:270 add.s64 %rd99, %rd1, %rd98
  asm("add.s64 %0, %1, %2;" : "=l"(rd99) : "l"(rd1), "l"(rd98));
  // PTX:271 st.global.u32 [%rd99], %r11
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (0))))) = (unsigned)(r11);
  // PTX:272 add.s32 %r67, %r67, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r67) : "r"(r67));
  // PTX:274 $L__BB5_22:
L_BB5_22:;
  // PTX:275 shl.b64 %rd100, %rd26, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd100) : "l"(rd26));
  // PTX:276 add.s64 %rd139, %rd6, %rd100
  asm("add.s64 %0, %1, %2;" : "=l"(rd139) : "l"(rd6), "l"(rd100));
  // PTX:278 $L__BB5_25:
L_BB5_25:;
  // PTX:279 ld.global.u32 %r65, [%rd139]
  r65 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd139) + (0)))));
  // PTX:280 setp.ne.s32 %p27, %r65, %r8
  p27 = (((int)(r65)) != ((int)(r8)));
  // PTX:281 setp.gt.s32 %p28, %r65, -1
  p28 = (((int)(r65)) > ((int)(-1)));
  // PTX:282 and.pred %p29, %p28, %p27
  p29 = ((p28) && (p27));
  // PTX:283 setp.lt.s32 %p30, %r67, %r28
  p30 = (((int)(r67)) < ((int)(r28)));
  // PTX:284 and.pred %p31, %p30, %p29
  p31 = ((p30) && (p29));
  // PTX:285 @%p31 bra $L__BB5_8
  if (p31) { goto L_BB5_8; }
  // PTX:286 bra.uni $L__BB5_43
  goto L_BB5_43;
  // PTX:288 $L__BB5_26:
L_BB5_26:;
  // PTX:289 cvt.s64.s32 %rd33, %r65
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd33) : "r"(r65));
  // PTX:290 add.s64 %rd103, %rd21, %rd33
  asm("add.s64 %0, %1, %2;" : "=l"(rd103) : "l"(rd21), "l"(rd33));
  // PTX:291 mul.lo.s64 %rd104, %rd103, 24
  asm("mul.lo.s64 %0, %1, 24;" : "=l"(rd104) : "l"(rd103));
  // PTX:292 add.s64 %rd105, %rd5, %rd104
  asm("add.s64 %0, %1, %2;" : "=l"(rd105) : "l"(rd5), "l"(rd104));
  // PTX:293 add.s64 %rd34, %rd105, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd34) : "l"(rd105));
  // PTX:294 ld.global.f32 %f29, [%rd105+12]
  f29 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (12)))));
  // PTX:295 setp.gtu.f32 %p32, %f3, %f29
  p32 = ((isnan(((float)(f3))) || isnan(((float)(f29)))) || (((float)(f3)) > ((float)(f29))));
  // PTX:296 mov.u16 %rs27, 0
  asm("mov.u16 %0, 0;" : "=h"(rs27) : );
  // PTX:297 @%p32 bra $L__BB5_32
  if (p32) { goto L_BB5_32; }
  // PTX:299 mov.u16 %rs27, 0
  asm("mov.u16 %0, 0;" : "=h"(rs27) : );
  // PTX:300 ld.global.f32 %f30, [%rd34+-12]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (-12)))));
  // PTX:301 setp.ltu.f32 %p33, %f8, %f30
  p33 = ((isnan(((float)(f8))) || isnan(((float)(f30)))) || (((float)(f8)) < ((float)(f30))));
  // PTX:302 @%p33 bra $L__BB5_32
  if (p33) { goto L_BB5_32; }
  // PTX:304 mov.u16 %rs27, 0
  asm("mov.u16 %0, 0;" : "=h"(rs27) : );
  // PTX:305 ld.global.f32 %f31, [%rd34+4]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (4)))));
  // PTX:306 setp.gtu.f32 %p34, %f5, %f31
  p34 = ((isnan(((float)(f5))) || isnan(((float)(f31)))) || (((float)(f5)) > ((float)(f31))));
  // PTX:307 @%p34 bra $L__BB5_32
  if (p34) { goto L_BB5_32; }
  // PTX:309 mov.u16 %rs27, 0
  asm("mov.u16 %0, 0;" : "=h"(rs27) : );
  // PTX:310 ld.global.f32 %f32, [%rd34+-8]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (-8)))));
  // PTX:311 setp.ltu.f32 %p35, %f9, %f32
  p35 = ((isnan(((float)(f9))) || isnan(((float)(f32)))) || (((float)(f9)) < ((float)(f32))));
  // PTX:312 @%p35 bra $L__BB5_32
  if (p35) { goto L_BB5_32; }
  // PTX:314 mov.u16 %rs27, 0
  asm("mov.u16 %0, 0;" : "=h"(rs27) : );
  // PTX:315 ld.global.f32 %f33, [%rd34+8]
  f33 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (8)))));
  // PTX:316 setp.gtu.f32 %p36, %f7, %f33
  p36 = ((isnan(((float)(f7))) || isnan(((float)(f33)))) || (((float)(f7)) > ((float)(f33))));
  // PTX:317 @%p36 bra $L__BB5_32
  if (p36) { goto L_BB5_32; }
  // PTX:319 ld.global.f32 %f34, [%rd34+-4]
  f34 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (-4)))));
  // PTX:320 setp.ge.f32 %p37, %f10, %f34
  p37 = (!(isnan(((float)(f10))) || isnan(((float)(f34)))) && (((float)(f10)) >= ((float)(f34))));
  // PTX:321 selp.u16 %rs27, 1, 0, %p37
  rs27 = p37 ? 1 : 0;
  // PTX:323 $L__BB5_32:
L_BB5_32:;
  // PTX:324 setp.eq.s16 %p38, %rs27, 0
  p38 = (((short)(rs27)) == ((short)(0)));
  // PTX:325 @%p38 bra $L__BB5_41
  if (p38) { goto L_BB5_41; }
  // PTX:327 cvt.u32.u64 %r53, %rd33
  asm("cvt.u32.u64 %0, %1;" : "=r"(r53) : "l"(rd33));
  // PTX:328 setp.lt.s32 %p39, %r53, %r1
  p39 = (((int)(r53)) < ((int)(r1)));
  // PTX:329 @%p39 bra $L__BB5_40
  if (p39) { goto L_BB5_40; }
  // PTX:330 bra.uni $L__BB5_34
  goto L_BB5_34;
  // PTX:332 $L__BB5_40:
L_BB5_40:;
  // PTX:333 shl.b64 %rd122, %rd33, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd122) : "l"(rd33));
  // PTX:334 add.s64 %rd140, %rd7, %rd122
  asm("add.s64 %0, %1, %2;" : "=l"(rd140) : "l"(rd7), "l"(rd122));
  // PTX:335 bra.uni $L__BB5_42
  goto L_BB5_42;
  // PTX:337 $L__BB5_41:
L_BB5_41:;
  // PTX:338 shl.b64 %rd123, %rd33, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd123) : "l"(rd33));
  // PTX:339 add.s64 %rd140, %rd6, %rd123
  asm("add.s64 %0, %1, %2;" : "=l"(rd140) : "l"(rd6), "l"(rd123));
  // PTX:340 bra.uni $L__BB5_42
  goto L_BB5_42;
  // PTX:342 $L__BB5_34:
L_BB5_34:;
  // PTX:343 sub.s32 %r55, %r53, %r1
  asm("sub.s32 %0, %1, %2;" : "=r"(r55) : "r"(r53), "r"(r1));
  // PTX:344 mul.wide.s32 %rd106, %r55, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd106) : "r"(r55));
  // PTX:345 add.s64 %rd107, %rd4, %rd106
  asm("add.s64 %0, %1, %2;" : "=l"(rd107) : "l"(rd4), "l"(rd106));
  // PTX:346 ld.global.u32 %r56, [%rd107]
  r56 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd107) + (0)))));
  // PTX:347 mul.wide.s32 %rd108, %r56, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd108) : "r"(r56));
  // PTX:348 add.s64 %rd109, %rd11, %rd108
  asm("add.s64 %0, %1, %2;" : "=l"(rd109) : "l"(rd11), "l"(rd108));
  // PTX:349 ld.global.u32 %r19, [%rd109]
  r19 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd109) + (0)))));
  // PTX:350 cvt.u32.u64 %r57, %rd19
  asm("cvt.u32.u64 %0, %1;" : "=r"(r57) : "l"(rd19));
  // PTX:351 setp.le.s32 %p40, %r19, %r57
  p40 = (((int)(r19)) <= ((int)(r57)));
  // PTX:352 @%p40 bra $L__BB5_39
  if (p40) { goto L_BB5_39; }
  // PTX:354 ld.global.u32 %r20, [%rd22]
  r20 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (0)))));
  // PTX:355 setp.eq.s32 %p41, %r20, 0
  p41 = (((int)(r20)) == ((int)(0)));
  // PTX:356 @%p41 bra $L__BB5_37
  if (p41) { goto L_BB5_37; }
  // PTX:358 cvt.s64.s32 %rd132, %r19
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd132) : "r"(r19));
  // PTX:359 shl.b64 %rd110, %rd132, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd110) : "l"(rd132));
  // PTX:360 add.s64 %rd111, %rd3, %rd110
  asm("add.s64 %0, %1, %2;" : "=l"(rd111) : "l"(rd3), "l"(rd110));
  // PTX:361 ld.global.u32 %r58, [%rd111]
  r58 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd111) + (0)))));
  // PTX:362 setp.eq.s32 %p42, %r20, %r58
  p42 = (((int)(r20)) == ((int)(r58)));
  // PTX:363 @%p42 bra $L__BB5_39
  if (p42) { goto L_BB5_39; }
  // PTX:365 $L__BB5_37:
L_BB5_37:;
  // PTX:366 cvt.s64.s32 %rd133, %r19
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd133) : "r"(r19));
  // PTX:367 add.s64 %rd112, %rd20, %rd133
  asm("add.s64 %0, %1, %2;" : "=l"(rd112) : "l"(rd20), "l"(rd133));
  // PTX:368 mul.lo.s64 %rd113, %rd112, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd113) : "l"(rd112));
  // PTX:369 add.s64 %rd114, %rd10, %rd113
  asm("add.s64 %0, %1, %2;" : "=l"(rd114) : "l"(rd10), "l"(rd113));
  // PTX:370 ld.global.f32 %f35, [%rd114]
  f35 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd114) + (0)))));
  // PTX:371 sub.f32 %f36, %f2, %f35
  asm("sub.f32 %0, %1, %2;" : "=f"(f36) : "f"(f2), "f"(f35));
  // PTX:372 ld.global.f32 %f37, [%rd114+4]
  f37 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd114) + (4)))));
  // PTX:373 sub.f32 %f38, %f4, %f37
  asm("sub.f32 %0, %1, %2;" : "=f"(f38) : "f"(f4), "f"(f37));
  // PTX:374 ld.global.f32 %f39, [%rd114+8]
  f39 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd114) + (8)))));
  // PTX:375 sub.f32 %f40, %f6, %f39
  asm("sub.f32 %0, %1, %2;" : "=f"(f40) : "f"(f6), "f"(f39));
  // PTX:376 shl.b64 %rd115, %rd133, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd115) : "l"(rd133));
  // PTX:377 add.s64 %rd116, %rd9, %rd115
  asm("add.s64 %0, %1, %2;" : "=l"(rd116) : "l"(rd9), "l"(rd115));
  // PTX:378 ld.global.f32 %f41, [%rd116]
  f41 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd116) + (0)))));
  // PTX:379 add.f32 %f42, %f1, %f41
  asm("add.f32 %0, %1, %2;" : "=f"(f42) : "f"(f1), "f"(f41));
  // PTX:380 mul.f32 %f43, %f38, %f38
  asm("mul.f32 %0, %1, %2;" : "=f"(f43) : "f"(f38), "f"(f38));
  // PTX:381 fma.rn.f32 %f44, %f36, %f36, %f43
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f44) : "f"(f36), "f"(f36), "f"(f43));
  // PTX:382 fma.rn.f32 %f45, %f40, %f40, %f44
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f45) : "f"(f40), "f"(f40), "f"(f44));
  // PTX:383 mul.f32 %f46, %f42, %f42
  asm("mul.f32 %0, %1, %2;" : "=f"(f46) : "f"(f42), "f"(f42));
  // PTX:384 setp.geu.f32 %p43, %f45, %f46
  p43 = ((isnan(((float)(f45))) || isnan(((float)(f46)))) || (((float)(f45)) >= ((float)(f46))));
  // PTX:385 @%p43 bra $L__BB5_39
  if (p43) { goto L_BB5_39; }
  // PTX:387 cvt.s64.s32 %rd117, %r67
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd117) : "r"(r67));
  // PTX:388 add.s64 %rd118, %rd24, %rd117
  asm("add.s64 %0, %1, %2;" : "=l"(rd118) : "l"(rd24), "l"(rd117));
  // PTX:389 shl.b64 %rd119, %rd118, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd119) : "l"(rd118));
  // PTX:390 add.s64 %rd120, %rd1, %rd119
  asm("add.s64 %0, %1, %2;" : "=l"(rd120) : "l"(rd1), "l"(rd119));
  // PTX:391 st.global.u32 [%rd120], %r19
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd120) + (0))))) = (unsigned)(r19);
  // PTX:392 add.s32 %r67, %r67, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r67) : "r"(r67));
  // PTX:394 $L__BB5_39:
L_BB5_39:;
  // PTX:395 shl.b64 %rd121, %rd33, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd121) : "l"(rd33));
  // PTX:396 add.s64 %rd140, %rd6, %rd121
  asm("add.s64 %0, %1, %2;" : "=l"(rd140) : "l"(rd6), "l"(rd121));
  // PTX:398 $L__BB5_42:
L_BB5_42:;
  // PTX:399 ld.global.u32 %r65, [%rd140]
  r65 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd140) + (0)))));
  // PTX:400 setp.ne.s32 %p44, %r65, %r8
  p44 = (((int)(r65)) != ((int)(r8)));
  // PTX:401 setp.gt.s32 %p45, %r65, -1
  p45 = (((int)(r65)) > ((int)(-1)));
  // PTX:402 and.pred %p46, %p45, %p44
  p46 = ((p45) && (p44));
  // PTX:403 setp.lt.s32 %p47, %r67, %r28
  p47 = (((int)(r67)) < ((int)(r28)));
  // PTX:404 and.pred %p48, %p47, %p46
  p48 = ((p47) && (p46));
  // PTX:405 @%p48 bra $L__BB5_26
  if (p48) { goto L_BB5_26; }
  // PTX:407 $L__BB5_43:
L_BB5_43:;
  // PTX:408 cvt.s64.s32 %rd129, %r63
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd129) : "r"(r63));
  // PTX:409 shl.b64 %rd124, %rd129, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd124) : "l"(rd129));
  // PTX:410 add.s64 %rd125, %rd8, %rd124
  asm("add.s64 %0, %1, %2;" : "=l"(rd125) : "l"(rd8), "l"(rd124));
  // PTX:411 ld.global.u32 %r62, [%rd125]
  r62 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd125) + (0)))));
  // PTX:412 setp.gt.s32 %p49, %r62, -1
  p49 = (((int)(r62)) > ((int)(-1)));
  // PTX:413 setp.lt.s32 %p50, %r67, %r28
  p50 = (((int)(r67)) < ((int)(r28)));
  // PTX:414 and.pred %p51, %p50, %p49
  p51 = ((p50) && (p49));
  // PTX:415 @%p51 bra $L__BB5_6
  if (p51) { goto L_BB5_6; }
  // PTX:417 $L__BB5_44:
L_BB5_44:;
  // PTX:418 mov.u32 %r61, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r61) : "r"(blockDim.x));
  // PTX:419 mov.u32 %r60, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r60) : "r"(blockIdx.x));
  // PTX:420 mov.u32 %r59, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r59) : "r"(threadIdx.x));
  // PTX:421 cvt.u64.u32 %rd136, %r59
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd136) : "r"(r59));
  // PTX:422 mul.wide.u32 %rd135, %r60, %r61
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd135) : "r"(r60), "r"(r61));
  // PTX:423 add.s64 %rd134, %rd135, %rd136
  asm("add.s64 %0, %1, %2;" : "=l"(rd134) : "l"(rd135), "l"(rd136));
  // PTX:424 ld.param.u64 %rd131, [_ZN7synreal21self_collision_kernel20query_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_PKNS_4AabbES8_PKNS2_ILi2EiLS3_0EEES8_S8_S8_PiSH_mmmi_param_11]
  rd131 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:425 cvta.to.global.u64 %rd126, %rd131
  rd126 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd131));
  // PTX:426 shl.b64 %rd127, %rd134, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd127) : "l"(rd134));
  // PTX:427 add.s64 %rd128, %rd126, %rd127
  asm("add.s64 %0, %1, %2;" : "=l"(rd128) : "l"(rd126), "l"(rd127));
  // PTX:428 st.global.u32 [%rd128], %r67
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd128) + (0))))) = (unsigned)(r67);
  // PTX:430 $L__BB5_45:
L_BB5_45:;
  // PTX:431 ret
  return;
}
