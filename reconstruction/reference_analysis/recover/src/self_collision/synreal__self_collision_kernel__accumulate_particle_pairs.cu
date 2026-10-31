// 机械还原自 PTX：synreal::self_collision_kernel::accumulate_particle_pairs(glm::vec<3, float, (glm::qualifier)0> const*, int const*, float const*, int const*, int const*, float const*, float, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, synreal::SelfCollisionContactTangent*, unsigned int*, unsigned long, unsigned long, unsigned long, int)
// PTX SHA256: 2826dcbe71c2cc83f5a184516ec0518b4b90de56f523bbb3278469958a2ec269
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__self_collision_kernel__accumulate_particle_pairs(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, float param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10, unsigned long long param11, unsigned long long param12, unsigned long long param13, unsigned param14) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47;
  unsigned short rs0, rs1, rs2, rs3, rs4, rs5, rs6, rs7, rs8, rs9, rs10, rs11, rs12, rs13, rs14, rs15, rs16, rs17, rs18, rs19, rs20, rs21, rs22, rs23, rs24, rs25;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95;
  // PTX:32 ld.param.u64 %rd43, [_ZN7synreal21self_collision_kernel25accumulate_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_SA_fPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_0]
  rd43 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:33 ld.param.u64 %rd36, [_ZN7synreal21self_collision_kernel25accumulate_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_SA_fPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_1]
  rd36 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:34 ld.param.u64 %rd44, [_ZN7synreal21self_collision_kernel25accumulate_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_SA_fPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_2]
  rd44 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:35 ld.param.u64 %rd37, [_ZN7synreal21self_collision_kernel25accumulate_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_SA_fPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_3]
  rd37 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:36 ld.param.u64 %rd38, [_ZN7synreal21self_collision_kernel25accumulate_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_SA_fPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_4]
  rd38 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:37 ld.param.u64 %rd45, [_ZN7synreal21self_collision_kernel25accumulate_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_SA_fPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_5]
  rd45 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:38 ld.param.f32 %f29, [_ZN7synreal21self_collision_kernel25accumulate_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_SA_fPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_6]
  f29 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param6 + (0))));
  // PTX:39 ld.param.u64 %rd46, [_ZN7synreal21self_collision_kernel25accumulate_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_SA_fPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_7]
  rd46 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:40 ld.param.u64 %rd47, [_ZN7synreal21self_collision_kernel25accumulate_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_SA_fPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_8]
  rd47 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:41 ld.param.u64 %rd39, [_ZN7synreal21self_collision_kernel25accumulate_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_SA_fPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_9]
  rd39 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:42 ld.param.u64 %rd40, [_ZN7synreal21self_collision_kernel25accumulate_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_SA_fPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_10]
  rd40 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:43 ld.param.u64 %rd48, [_ZN7synreal21self_collision_kernel25accumulate_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_SA_fPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_11]
  rd48 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:44 ld.param.u64 %rd41, [_ZN7synreal21self_collision_kernel25accumulate_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_SA_fPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_12]
  rd41 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:45 ld.param.u64 %rd42, [_ZN7synreal21self_collision_kernel25accumulate_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_SA_fPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_13]
  rd42 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:46 ld.param.u32 %r21, [_ZN7synreal21self_collision_kernel25accumulate_particle_pairsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfS8_S8_SA_fPS4_PNS1_3matILi3ELi3EfLS3_0EEEPNS_27SelfCollisionContactTangentEPjmmmi_param_14]
  r21 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param14 + (0))));
  // PTX:47 cvta.to.global.u64 %rd1, %rd47
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd47));
  // PTX:48 cvta.to.global.u64 %rd2, %rd46
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd46));
  // PTX:49 cvta.to.global.u64 %rd3, %rd44
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd44));
  // PTX:50 cvta.to.global.u64 %rd4, %rd45
  rd4 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd45));
  // PTX:51 cvta.to.global.u64 %rd5, %rd43
  rd5 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd43));
  // PTX:52 mov.u32 %r22, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r22) : "r"(blockIdx.x));
  // PTX:53 mov.u32 %r23, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r23) : "r"(blockDim.x));
  // PTX:54 mul.wide.u32 %rd49, %r22, %r23
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd49) : "r"(r22), "r"(r23));
  // PTX:55 mov.u32 %r24, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r24) : "r"(threadIdx.x));
  // PTX:56 cvt.u64.u32 %rd50, %r24
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd50) : "r"(r24));
  // PTX:57 add.s64 %rd6, %rd49, %rd50
  asm("add.s64 %0, %1, %2;" : "=l"(rd6) : "l"(rd49), "l"(rd50));
  // PTX:58 setp.ge.u64 %p3, %rd6, %rd48
  p3 = (((unsigned long long)(rd6)) >= ((unsigned long long)(rd48)));
  // PTX:59 @%p3 bra $L__BB9_48
  if (p3) { goto L_BB9_48; }
  // PTX:61 or.b64 %rd51, %rd6, %rd41
  asm("or.b64 %0, %1, %2;" : "=l"(rd51) : "l"(rd6), "l"(rd41));
  // PTX:62 and.b64 %rd52, %rd51, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd52) : "l"(rd51));
  // PTX:63 setp.eq.s64 %p4, %rd52, 0
  p4 = (((long long)(rd52)) == ((long long)(0)));
  // PTX:64 @%p4 bra $L__BB9_3
  if (p4) { goto L_BB9_3; }
  // PTX:66 div.u64 %rd94, %rd6, %rd41
  asm("div.u64 %0, %1, %2;" : "=l"(rd94) : "l"(rd6), "l"(rd41));
  // PTX:67 mul.lo.s64 %rd53, %rd94, %rd41
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd53) : "l"(rd94), "l"(rd41));
  // PTX:68 sub.s64 %rd95, %rd6, %rd53
  asm("sub.s64 %0, %1, %2;" : "=l"(rd95) : "l"(rd6), "l"(rd53));
  // PTX:69 bra.uni $L__BB9_4
  goto L_BB9_4;
  // PTX:71 $L__BB9_3:
L_BB9_3:;
  // PTX:72 cvt.u32.u64 %r25, %rd41
  asm("cvt.u32.u64 %0, %1;" : "=r"(r25) : "l"(rd41));
  // PTX:73 cvt.u32.u64 %r26, %rd6
  asm("cvt.u32.u64 %0, %1;" : "=r"(r26) : "l"(rd6));
  // PTX:74 div.u32 %r27, %r26, %r25
  asm("div.u32 %0, %1, %2;" : "=r"(r27) : "r"(r26), "r"(r25));
  // PTX:75 mul.lo.s32 %r28, %r27, %r25
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r28) : "r"(r27), "r"(r25));
  // PTX:76 sub.s32 %r29, %r26, %r28
  asm("sub.s32 %0, %1, %2;" : "=r"(r29) : "r"(r26), "r"(r28));
  // PTX:77 cvt.u64.u32 %rd94, %r27
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd94) : "r"(r27));
  // PTX:78 cvt.u64.u32 %rd95, %r29
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd95) : "r"(r29));
  // PTX:80 $L__BB9_4:
L_BB9_4:;
  // PTX:81 mul.lo.s64 %rd54, %rd94, %rd42
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd54) : "l"(rd94), "l"(rd42));
  // PTX:82 cvt.u32.u64 %r1, %rd54
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd54));
  // PTX:83 cvta.to.global.u64 %rd55, %rd36
  rd55 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd36));
  // PTX:84 shl.b64 %rd56, %rd95, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd56) : "l"(rd95));
  // PTX:85 add.s64 %rd57, %rd55, %rd56
  asm("add.s64 %0, %1, %2;" : "=l"(rd57) : "l"(rd55), "l"(rd56));
  // PTX:86 ld.global.u32 %r30, [%rd57]
  r30 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))));
  // PTX:87 cvt.s64.s32 %rd13, %r30
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd13) : "r"(r30));
  // PTX:88 add.s32 %r2, %r30, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r2) : "r"(r30), "r"(r1));
  // PTX:89 cvt.s64.s32 %rd14, %r2
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd14) : "r"(r2));
  // PTX:90 mul.wide.s32 %rd58, %r2, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd58) : "r"(r2));
  // PTX:91 add.s64 %rd15, %rd5, %rd58
  asm("add.s64 %0, %1, %2;" : "=l"(rd15) : "l"(rd5), "l"(rd58));
  // PTX:92 ld.global.f32 %f1, [%rd15+8]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (8)))));
  // PTX:93 mul.wide.s32 %rd59, %r2, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd59) : "r"(r2));
  // PTX:94 add.s64 %rd60, %rd4, %rd59
  asm("add.s64 %0, %1, %2;" : "=l"(rd60) : "l"(rd4), "l"(rd59));
  // PTX:95 ld.global.f32 %f2, [%rd60]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))));
  // PTX:96 ld.global.f32 %f3, [%rd15]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))));
  // PTX:97 abs.f32 %f30, %f3
  asm("abs.f32 %0, %1;" : "=f"(f30) : "f"(f3));
  // PTX:98 setp.geu.f32 %p5, %f30, 0f7F800000
  p5 = ((isnan(((float)(f30))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f30)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:99 @%p5 bra $L__BB9_48
  if (p5) { goto L_BB9_48; }
  // PTX:101 ld.global.f32 %f4, [%rd15+4]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (4)))));
  // PTX:102 abs.f32 %f31, %f4
  asm("abs.f32 %0, %1;" : "=f"(f31) : "f"(f4));
  // PTX:103 setp.geu.f32 %p6, %f31, 0f7F800000
  p6 = ((isnan(((float)(f31))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f31)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:104 @%p6 bra $L__BB9_48
  if (p6) { goto L_BB9_48; }
  // PTX:106 abs.f32 %f32, %f1
  asm("abs.f32 %0, %1;" : "=f"(f32) : "f"(f1));
  // PTX:107 setp.geu.f32 %p7, %f32, 0f7F800000
  p7 = ((isnan(((float)(f32))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f32)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:108 @%p7 bra $L__BB9_48
  if (p7) { goto L_BB9_48; }
  // PTX:110 abs.f32 %f33, %f2
  asm("abs.f32 %0, %1;" : "=f"(f33) : "f"(f2));
  // PTX:111 setp.geu.f32 %p8, %f33, 0f7F800000
  p8 = ((isnan(((float)(f33))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f33)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:112 @%p8 bra $L__BB9_48
  if (p8) { goto L_BB9_48; }
  // PTX:114 cvta.to.global.u64 %rd61, %rd37
  rd61 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd37));
  // PTX:115 shl.b64 %rd62, %rd6, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd62) : "l"(rd6));
  // PTX:116 add.s64 %rd16, %rd61, %rd62
  asm("add.s64 %0, %1, %2;" : "=l"(rd16) : "l"(rd61), "l"(rd62));
  // PTX:117 ld.global.u32 %r52, [%rd16]
  r52 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:118 setp.lt.s32 %p9, %r52, 1
  p9 = (((int)(r52)) < ((int)(1)));
  // PTX:119 @%p9 bra $L__BB9_48
  if (p9) { goto L_BB9_48; }
  // PTX:121 cvt.s64.s32 %rd63, %r21
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd63) : "r"(r21));
  // PTX:122 mul.lo.s64 %rd17, %rd6, %rd63
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd17) : "l"(rd6), "l"(rd63));
  // PTX:123 shl.b64 %rd64, %rd13, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd64) : "l"(rd13));
  // PTX:124 add.s64 %rd18, %rd3, %rd64
  asm("add.s64 %0, %1, %2;" : "=l"(rd18) : "l"(rd3), "l"(rd64));
  // PTX:125 mul.f32 %f5, %f2, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f5) : "f"(f2), "f"(f29));
  // PTX:126 mul.lo.s64 %rd65, %rd14, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd65) : "l"(rd14));
  // PTX:127 add.s64 %rd19, %rd2, %rd65
  asm("add.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd2), "l"(rd65));
  // PTX:128 add.s64 %rd20, %rd19, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd20) : "l"(rd19));
  // PTX:129 add.s64 %rd21, %rd19, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd21) : "l"(rd19));
  // PTX:130 mul.lo.s64 %rd66, %rd14, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd66) : "l"(rd14));
  // PTX:131 add.s64 %rd22, %rd1, %rd66
  asm("add.s64 %0, %1, %2;" : "=l"(rd22) : "l"(rd1), "l"(rd66));
  // PTX:132 add.s64 %rd23, %rd22, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd23) : "l"(rd22));
  // PTX:133 add.s64 %rd24, %rd22, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd24) : "l"(rd22));
  // PTX:134 add.s64 %rd25, %rd22, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd25) : "l"(rd22));
  // PTX:135 add.s64 %rd26, %rd22, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd26) : "l"(rd22));
  // PTX:136 add.s64 %rd27, %rd22, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd27) : "l"(rd22));
  // PTX:137 add.s64 %rd28, %rd22, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd28) : "l"(rd22));
  // PTX:138 add.s64 %rd29, %rd22, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd29) : "l"(rd22));
  // PTX:139 add.s64 %rd30, %rd22, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd30) : "l"(rd22));
  // PTX:140 cvta.to.global.u64 %rd31, %rd38
  rd31 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd38));
  // PTX:141 cvta.to.global.u64 %rd32, %rd40
  rd32 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd40));
  // PTX:142 mov.u32 %r48, 0
  asm("mov.u32 %0, 0;" : "=r"(r48) : );
  // PTX:144 $L__BB9_10:
L_BB9_10:;
  // PTX:145 cvt.s64.s32 %rd67, %r48
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd67) : "r"(r48));
  // PTX:146 add.s64 %rd68, %rd17, %rd67
  asm("add.s64 %0, %1, %2;" : "=l"(rd68) : "l"(rd17), "l"(rd67));
  // PTX:147 shl.b64 %rd69, %rd68, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd69) : "l"(rd68));
  // PTX:148 add.s64 %rd70, %rd31, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd70) : "l"(rd31), "l"(rd69));
  // PTX:149 ld.global.u32 %r32, [%rd70]
  r32 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0)))));
  // PTX:150 cvt.s64.s32 %rd34, %r32
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd34) : "r"(r32));
  // PTX:151 add.s32 %r6, %r32, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r6) : "r"(r32), "r"(r1));
  // PTX:152 cvt.s64.s32 %rd35, %r6
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd35) : "r"(r6));
  // PTX:153 mul.wide.s32 %rd71, %r6, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd71) : "r"(r6));
  // PTX:154 add.s64 %rd72, %rd5, %rd71
  asm("add.s64 %0, %1, %2;" : "=l"(rd72) : "l"(rd5), "l"(rd71));
  // PTX:155 ld.global.u32 %r7, [%rd72+4]
  r7 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (4)))));
  // PTX:156 ld.global.u32 %r8, [%rd72+8]
  r8 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (8)))));
  // PTX:157 ld.global.f32 %f6, [%rd72]
  f6 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (0)))));
  // PTX:158 abs.f32 %f34, %f6
  asm("abs.f32 %0, %1;" : "=f"(f34) : "f"(f6));
  // PTX:159 setp.geu.f32 %p10, %f34, 0f7F800000
  p10 = ((isnan(((float)(f34))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f34)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:160 mov.u16 %rs21, 0
  asm("mov.u16 %0, 0;" : "=h"(rs21) : );
  // PTX:161 @%p10 bra $L__BB9_13
  if (p10) { goto L_BB9_13; }
  // PTX:163 mov.b32 %f35, %r7
  asm("mov.b32 %0, %1;" : "=f"(f35) : "r"(r7));
  // PTX:164 abs.f32 %f36, %f35
  asm("abs.f32 %0, %1;" : "=f"(f36) : "f"(f35));
  // PTX:165 setp.geu.f32 %p11, %f36, 0f7F800000
  p11 = ((isnan(((float)(f36))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f36)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:166 @%p11 bra $L__BB9_13
  if (p11) { goto L_BB9_13; }
  // PTX:168 mov.b32 %f37, %r8
  asm("mov.b32 %0, %1;" : "=f"(f37) : "r"(r8));
  // PTX:169 abs.f32 %f38, %f37
  asm("abs.f32 %0, %1;" : "=f"(f38) : "f"(f37));
  // PTX:170 setp.lt.f32 %p12, %f38, 0f7F800000
  p12 = (!(isnan(((float)(f38))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f38)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:171 selp.u16 %rs21, 1, 0, %p12
  rs21 = p12 ? 1 : 0;
  // PTX:173 $L__BB9_13:
L_BB9_13:;
  // PTX:174 setp.eq.s16 %p13, %rs21, 0
  p13 = (((short)(rs21)) == ((short)(0)));
  // PTX:175 @%p13 bra $L__BB9_47
  if (p13) { goto L_BB9_47; }
  // PTX:177 shl.b64 %rd73, %rd34, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd73) : "l"(rd34));
  // PTX:178 add.s64 %rd74, %rd3, %rd73
  asm("add.s64 %0, %1, %2;" : "=l"(rd74) : "l"(rd3), "l"(rd73));
  // PTX:179 ld.global.f32 %f7, [%rd74]
  f7 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (0)))));
  // PTX:180 abs.f32 %f39, %f7
  asm("abs.f32 %0, %1;" : "=f"(f39) : "f"(f7));
  // PTX:181 setp.geu.f32 %p14, %f39, 0f7F800000
  p14 = ((isnan(((float)(f39))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f39)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:182 @%p14 bra $L__BB9_47
  if (p14) { goto L_BB9_47; }
  // PTX:184 sub.f32 %f8, %f3, %f6
  asm("sub.f32 %0, %1, %2;" : "=f"(f8) : "f"(f3), "f"(f6));
  // PTX:185 mov.b32 %f40, %r7
  asm("mov.b32 %0, %1;" : "=f"(f40) : "r"(r7));
  // PTX:186 sub.f32 %f9, %f4, %f40
  asm("sub.f32 %0, %1, %2;" : "=f"(f9) : "f"(f4), "f"(f40));
  // PTX:187 mov.b32 %f41, %r8
  asm("mov.b32 %0, %1;" : "=f"(f41) : "r"(r8));
  // PTX:188 sub.f32 %f10, %f1, %f41
  asm("sub.f32 %0, %1, %2;" : "=f"(f10) : "f"(f1), "f"(f41));
  // PTX:189 mul.f32 %f42, %f9, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f42) : "f"(f9), "f"(f9));
  // PTX:190 fma.rn.f32 %f43, %f8, %f8, %f42
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f43) : "f"(f8), "f"(f8), "f"(f42));
  // PTX:191 fma.rn.f32 %f44, %f10, %f10, %f43
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f44) : "f"(f10), "f"(f10), "f"(f43));
  // PTX:192 sqrt.rn.f32 %f11, %f44
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f11) : "f"(f44));
  // PTX:193 ld.global.f32 %f45, [%rd18]
  f45 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (0)))));
  // PTX:194 add.f32 %f12, %f45, %f7
  asm("add.f32 %0, %1, %2;" : "=f"(f12) : "f"(f45), "f"(f7));
  // PTX:195 abs.f32 %f46, %f11
  asm("abs.f32 %0, %1;" : "=f"(f46) : "f"(f11));
  // PTX:196 setp.geu.f32 %p16, %f46, 0f7F800000
  p16 = ((isnan(((float)(f46))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f46)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:197 mov.pred %p47, -1
  p47 = ((-1) != 0);
  // PTX:198 @%p16 bra $L__BB9_17
  if (p16) { goto L_BB9_17; }
  // PTX:200 abs.f32 %f47, %f12
  asm("abs.f32 %0, %1;" : "=f"(f47) : "f"(f12));
  // PTX:201 setp.geu.f32 %p47, %f47, 0f7F800000
  p47 = ((isnan(((float)(f47))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f47)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:203 $L__BB9_17:
L_BB9_17:;
  // PTX:204 setp.ge.f32 %p17, %f11, %f12
  p17 = (!(isnan(((float)(f11))) || isnan(((float)(f12)))) && (((float)(f11)) >= ((float)(f12))));
  // PTX:205 or.pred %p18, %p17, %p47
  p18 = ((p17) || (p47));
  // PTX:206 @%p18 bra $L__BB9_47
  if (p18) { goto L_BB9_47; }
  // PTX:208 setp.gt.f32 %p19, %f11, 0f322BCC77
  p19 = (!(isnan(((float)(f11))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f11)) > ((float)(as_f32(0x322BCC77u)))));
  // PTX:209 @%p19 bra $L__BB9_20
  if (p19) { goto L_BB9_20; }
  // PTX:210 bra.uni $L__BB9_19
  goto L_BB9_19;
  // PTX:212 $L__BB9_20:
L_BB9_20:;
  // PTX:213 div.rn.f32 %f48, %f8, %f11
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f48) : "f"(f8), "f"(f11));
  // PTX:214 mov.b32 %r49, %f48
  asm("mov.b32 %0, %1;" : "=r"(r49) : "f"(f48));
  // PTX:215 div.rn.f32 %f49, %f9, %f11
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f49) : "f"(f9), "f"(f11));
  // PTX:216 mov.b32 %r50, %f49
  asm("mov.b32 %0, %1;" : "=r"(r50) : "f"(f49));
  // PTX:217 div.rn.f32 %f50, %f10, %f11
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f50) : "f"(f10), "f"(f11));
  // PTX:218 mov.b32 %r51, %f50
  asm("mov.b32 %0, %1;" : "=r"(r51) : "f"(f50));
  // PTX:219 bra.uni $L__BB9_21
  goto L_BB9_21;
  // PTX:221 $L__BB9_19:
L_BB9_19:;
  // PTX:222 cvt.u32.u64 %r33, %rd34
  asm("cvt.u32.u64 %0, %1;" : "=r"(r33) : "l"(rd34));
  // PTX:223 cvt.u32.u64 %r34, %rd13
  asm("cvt.u32.u64 %0, %1;" : "=r"(r34) : "l"(rd13));
  // PTX:224 xor.b32 %r35, %r33, %r34
  asm("xor.b32 %0, %1, %2;" : "=r"(r35) : "r"(r33), "r"(r34));
  // PTX:225 mul.hi.s32 %r36, %r35, 1431655766
  asm("mul.hi.s32 %0, %1, 1431655766;" : "=r"(r36) : "r"(r35));
  // PTX:226 shr.u32 %r37, %r36, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r37) : "r"(r36));
  // PTX:227 add.s32 %r38, %r36, %r37
  asm("add.s32 %0, %1, %2;" : "=r"(r38) : "r"(r36), "r"(r37));
  // PTX:228 mul.lo.s32 %r39, %r38, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r39) : "r"(r38));
  // PTX:229 sub.s32 %r40, %r35, %r39
  asm("sub.s32 %0, %1, %2;" : "=r"(r40) : "r"(r35), "r"(r39));
  // PTX:230 setp.eq.s32 %p20, %r40, 0
  p20 = (((int)(r40)) == ((int)(0)));
  // PTX:231 setp.eq.s32 %p21, %r40, 1
  p21 = (((int)(r40)) == ((int)(1)));
  // PTX:232 selp.b32 %r41, 1065353216, 0, %p21
  r41 = p21 ? 1065353216 : 0;
  // PTX:233 selp.b32 %r50, 0, %r41, %p20
  r50 = p20 ? 0 : r41;
  // PTX:234 or.pred %p22, %p20, %p21
  p22 = ((p20) || (p21));
  // PTX:235 selp.b32 %r51, 0, 1065353216, %p22
  r51 = p22 ? 0 : 1065353216;
  // PTX:236 selp.b32 %r49, 1065353216, 0, %p20
  r49 = p20 ? 1065353216 : 0;
  // PTX:238 $L__BB9_21:
L_BB9_21:;
  // PTX:239 shl.b64 %rd75, %rd35, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd75) : "l"(rd35));
  // PTX:240 add.s64 %rd76, %rd4, %rd75
  asm("add.s64 %0, %1, %2;" : "=l"(rd76) : "l"(rd4), "l"(rd75));
  // PTX:241 ld.global.f32 %f13, [%rd76]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (0)))));
  // PTX:242 setp.eq.f32 %p23, %f13, 0f00000000
  p23 = (!(isnan(((float)(f13))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f13)) == ((float)(as_f32(0x00000000u)))));
  // PTX:243 setp.eq.f32 %p24, %f2, 0f00000000
  p24 = (!(isnan(((float)(f2))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f2)) == ((float)(as_f32(0x00000000u)))));
  // PTX:244 or.pred %p25, %p24, %p23
  p25 = ((p24) || (p23));
  // PTX:245 @%p25 bra $L__BB9_26
  if (p25) { goto L_BB9_26; }
  // PTX:246 bra.uni $L__BB9_22
  goto L_BB9_22;
  // PTX:248 $L__BB9_26:
L_BB9_26:;
  // PTX:249 add.f32 %f58, %f2, %f13
  asm("add.f32 %0, %1, %2;" : "=f"(f58) : "f"(f2), "f"(f13));
  // PTX:250 mul.f32 %f114, %f58, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f114) : "f"(f58), "f"(f29));
  // PTX:251 bra.uni $L__BB9_27
  goto L_BB9_27;
  // PTX:253 $L__BB9_22:
L_BB9_22:;
  // PTX:254 mul.f32 %f14, %f5, %f13
  asm("mul.f32 %0, %1, %2;" : "=f"(f14) : "f"(f5), "f"(f13));
  // PTX:255 abs.f32 %f51, %f14
  asm("abs.f32 %0, %1;" : "=f"(f51) : "f"(f14));
  // PTX:256 setp.geu.f32 %p26, %f51, 0f7F800000
  p26 = ((isnan(((float)(f51))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f51)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:257 @%p26 bra $L__BB9_25
  if (p26) { goto L_BB9_25; }
  // PTX:259 add.f32 %f110, %f2, %f13
  asm("add.f32 %0, %1, %2;" : "=f"(f110) : "f"(f2), "f"(f13));
  // PTX:260 abs.f32 %f52, %f110
  asm("abs.f32 %0, %1;" : "=f"(f52) : "f"(f110));
  // PTX:261 setp.geu.f32 %p27, %f52, 0f7F800000
  p27 = ((isnan(((float)(f52))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f52)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:262 @%p27 bra $L__BB9_25
  if (p27) { goto L_BB9_25; }
  // PTX:263 bra.uni $L__BB9_24
  goto L_BB9_24;
  // PTX:265 $L__BB9_25:
L_BB9_25:;
  // PTX:266 min.f32 %f53, %f2, %f13
  asm("min.f32 %0, %1, %2;" : "=f"(f53) : "f"(f2), "f"(f13));
  // PTX:267 max.f32 %f54, %f2, %f13
  asm("max.f32 %0, %1, %2;" : "=f"(f54) : "f"(f2), "f"(f13));
  // PTX:268 div.rn.f32 %f55, %f53, %f54
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f55) : "f"(f53), "f"(f54));
  // PTX:269 add.f32 %f56, %f55, 0f3F800000
  asm("add.f32 %0, %1, 0f3F800000;" : "=f"(f56) : "f"(f55));
  // PTX:270 div.rn.f32 %f57, %f53, %f56
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f57) : "f"(f53), "f"(f56));
  // PTX:271 mul.f32 %f114, %f57, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f114) : "f"(f57), "f"(f29));
  // PTX:272 bra.uni $L__BB9_27
  goto L_BB9_27;
  // PTX:274 $L__BB9_24:
L_BB9_24:;
  // PTX:275 mul.f32 %f113, %f2, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f113) : "f"(f2), "f"(f29));
  // PTX:276 mul.f32 %f112, %f113, %f13
  asm("mul.f32 %0, %1, %2;" : "=f"(f112) : "f"(f113), "f"(f13));
  // PTX:277 add.f32 %f111, %f2, %f13
  asm("add.f32 %0, %1, %2;" : "=f"(f111) : "f"(f2), "f"(f13));
  // PTX:278 div.rn.f32 %f114, %f112, %f111
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f114) : "f"(f112), "f"(f111));
  // PTX:280 $L__BB9_27:
L_BB9_27:;
  // PTX:281 abs.f32 %f59, %f114
  asm("abs.f32 %0, %1;" : "=f"(f59) : "f"(f114));
  // PTX:282 setp.geu.f32 %p28, %f59, 0f7F800000
  p28 = ((isnan(((float)(f59))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f59)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:283 @%p28 bra $L__BB9_47
  if (p28) { goto L_BB9_47; }
  // PTX:285 sub.f32 %f60, %f12, %f11
  asm("sub.f32 %0, %1, %2;" : "=f"(f60) : "f"(f12), "f"(f11));
  // PTX:286 mul.f32 %f61, %f60, %f114
  asm("mul.f32 %0, %1, %2;" : "=f"(f61) : "f"(f60), "f"(f114));
  // PTX:287 mov.b32 %f62, %r49
  asm("mov.b32 %0, %1;" : "=f"(f62) : "r"(r49));
  // PTX:288 mul.f32 %f20, %f61, %f62
  asm("mul.f32 %0, %1, %2;" : "=f"(f20) : "f"(f61), "f"(f62));
  // PTX:289 mov.b32 %f63, %r50
  asm("mov.b32 %0, %1;" : "=f"(f63) : "r"(r50));
  // PTX:290 mul.f32 %f21, %f61, %f63
  asm("mul.f32 %0, %1, %2;" : "=f"(f21) : "f"(f61), "f"(f63));
  // PTX:291 mov.b32 %f64, %r51
  asm("mov.b32 %0, %1;" : "=f"(f64) : "r"(r51));
  // PTX:292 mul.f32 %f22, %f61, %f64
  asm("mul.f32 %0, %1, %2;" : "=f"(f22) : "f"(f61), "f"(f64));
  // PTX:293 mul.f32 %f65, %f62, %f62
  asm("mul.f32 %0, %1, %2;" : "=f"(f65) : "f"(f62), "f"(f62));
  // PTX:294 mul.f32 %f66, %f62, %f63
  asm("mul.f32 %0, %1, %2;" : "=f"(f66) : "f"(f62), "f"(f63));
  // PTX:295 mul.f32 %f67, %f62, %f64
  asm("mul.f32 %0, %1, %2;" : "=f"(f67) : "f"(f62), "f"(f64));
  // PTX:296 mul.f32 %f68, %f63, %f63
  asm("mul.f32 %0, %1, %2;" : "=f"(f68) : "f"(f63), "f"(f63));
  // PTX:297 mul.f32 %f69, %f63, %f64
  asm("mul.f32 %0, %1, %2;" : "=f"(f69) : "f"(f63), "f"(f64));
  // PTX:298 mul.f32 %f70, %f64, %f64
  asm("mul.f32 %0, %1, %2;" : "=f"(f70) : "f"(f64), "f"(f64));
  // PTX:299 mul.f32 %f23, %f65, %f114
  asm("mul.f32 %0, %1, %2;" : "=f"(f23) : "f"(f65), "f"(f114));
  // PTX:300 mul.f32 %f24, %f66, %f114
  asm("mul.f32 %0, %1, %2;" : "=f"(f24) : "f"(f66), "f"(f114));
  // PTX:301 mul.f32 %f25, %f67, %f114
  asm("mul.f32 %0, %1, %2;" : "=f"(f25) : "f"(f67), "f"(f114));
  // PTX:302 mul.f32 %f26, %f68, %f114
  asm("mul.f32 %0, %1, %2;" : "=f"(f26) : "f"(f68), "f"(f114));
  // PTX:303 mul.f32 %f27, %f69, %f114
  asm("mul.f32 %0, %1, %2;" : "=f"(f27) : "f"(f69), "f"(f114));
  // PTX:304 mul.f32 %f28, %f70, %f114
  asm("mul.f32 %0, %1, %2;" : "=f"(f28) : "f"(f70), "f"(f114));
  // PTX:305 abs.f32 %f71, %f20
  asm("abs.f32 %0, %1;" : "=f"(f71) : "f"(f20));
  // PTX:306 setp.geu.f32 %p29, %f71, 0f7F800000
  p29 = ((isnan(((float)(f71))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f71)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:307 mov.u16 %rs22, 0
  asm("mov.u16 %0, 0;" : "=h"(rs22) : );
  // PTX:308 @%p29 bra $L__BB9_31
  if (p29) { goto L_BB9_31; }
  // PTX:310 abs.f32 %f72, %f21
  asm("abs.f32 %0, %1;" : "=f"(f72) : "f"(f21));
  // PTX:311 setp.geu.f32 %p30, %f72, 0f7F800000
  p30 = ((isnan(((float)(f72))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f72)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:312 @%p30 bra $L__BB9_31
  if (p30) { goto L_BB9_31; }
  // PTX:314 abs.f32 %f73, %f22
  asm("abs.f32 %0, %1;" : "=f"(f73) : "f"(f22));
  // PTX:315 setp.lt.f32 %p31, %f73, 0f7F800000
  p31 = (!(isnan(((float)(f73))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f73)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:316 selp.u16 %rs22, 1, 0, %p31
  rs22 = p31 ? 1 : 0;
  // PTX:318 $L__BB9_31:
L_BB9_31:;
  // PTX:319 setp.eq.s16 %p32, %rs22, 0
  p32 = (((short)(rs22)) == ((short)(0)));
  // PTX:320 @%p32 bra $L__BB9_47
  if (p32) { goto L_BB9_47; }
  // PTX:322 abs.f32 %f74, %f23
  asm("abs.f32 %0, %1;" : "=f"(f74) : "f"(f23));
  // PTX:323 setp.geu.f32 %p33, %f74, 0f7F800000
  p33 = ((isnan(((float)(f74))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f74)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:324 mov.u16 %rs23, 0
  asm("mov.u16 %0, 0;" : "=h"(rs23) : );
  // PTX:325 @%p33 bra $L__BB9_35
  if (p33) { goto L_BB9_35; }
  // PTX:327 abs.f32 %f75, %f24
  asm("abs.f32 %0, %1;" : "=f"(f75) : "f"(f24));
  // PTX:328 setp.geu.f32 %p34, %f75, 0f7F800000
  p34 = ((isnan(((float)(f75))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f75)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:329 @%p34 bra $L__BB9_35
  if (p34) { goto L_BB9_35; }
  // PTX:331 abs.f32 %f76, %f25
  asm("abs.f32 %0, %1;" : "=f"(f76) : "f"(f25));
  // PTX:332 setp.lt.f32 %p35, %f76, 0f7F800000
  p35 = (!(isnan(((float)(f76))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f76)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:333 selp.u16 %rs23, 1, 0, %p35
  rs23 = p35 ? 1 : 0;
  // PTX:335 $L__BB9_35:
L_BB9_35:;
  // PTX:336 setp.eq.s16 %p36, %rs23, 0
  p36 = (((short)(rs23)) == ((short)(0)));
  // PTX:337 @%p36 bra $L__BB9_47
  if (p36) { goto L_BB9_47; }
  // PTX:339 abs.f32 %f77, %f24
  asm("abs.f32 %0, %1;" : "=f"(f77) : "f"(f24));
  // PTX:340 setp.geu.f32 %p37, %f77, 0f7F800000
  p37 = ((isnan(((float)(f77))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f77)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:341 mov.u16 %rs24, 0
  asm("mov.u16 %0, 0;" : "=h"(rs24) : );
  // PTX:342 @%p37 bra $L__BB9_39
  if (p37) { goto L_BB9_39; }
  // PTX:344 abs.f32 %f78, %f26
  asm("abs.f32 %0, %1;" : "=f"(f78) : "f"(f26));
  // PTX:345 setp.geu.f32 %p38, %f78, 0f7F800000
  p38 = ((isnan(((float)(f78))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f78)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:346 @%p38 bra $L__BB9_39
  if (p38) { goto L_BB9_39; }
  // PTX:348 abs.f32 %f79, %f27
  asm("abs.f32 %0, %1;" : "=f"(f79) : "f"(f27));
  // PTX:349 setp.lt.f32 %p39, %f79, 0f7F800000
  p39 = (!(isnan(((float)(f79))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f79)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:350 selp.u16 %rs24, 1, 0, %p39
  rs24 = p39 ? 1 : 0;
  // PTX:352 $L__BB9_39:
L_BB9_39:;
  // PTX:353 setp.eq.s16 %p40, %rs24, 0
  p40 = (((short)(rs24)) == ((short)(0)));
  // PTX:354 @%p40 bra $L__BB9_47
  if (p40) { goto L_BB9_47; }
  // PTX:356 abs.f32 %f80, %f25
  asm("abs.f32 %0, %1;" : "=f"(f80) : "f"(f25));
  // PTX:357 setp.geu.f32 %p41, %f80, 0f7F800000
  p41 = ((isnan(((float)(f80))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f80)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:358 mov.u16 %rs25, 0
  asm("mov.u16 %0, 0;" : "=h"(rs25) : );
  // PTX:359 @%p41 bra $L__BB9_43
  if (p41) { goto L_BB9_43; }
  // PTX:361 abs.f32 %f81, %f27
  asm("abs.f32 %0, %1;" : "=f"(f81) : "f"(f27));
  // PTX:362 setp.geu.f32 %p42, %f81, 0f7F800000
  p42 = ((isnan(((float)(f81))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f81)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:363 @%p42 bra $L__BB9_43
  if (p42) { goto L_BB9_43; }
  // PTX:365 abs.f32 %f82, %f28
  asm("abs.f32 %0, %1;" : "=f"(f82) : "f"(f28));
  // PTX:366 setp.lt.f32 %p43, %f82, 0f7F800000
  p43 = (!(isnan(((float)(f82))) || isnan(((float)(as_f32(0x7F800000u))))) && (((float)(f82)) < ((float)(as_f32(0x7F800000u)))));
  // PTX:367 selp.u16 %rs25, 1, 0, %p43
  rs25 = p43 ? 1 : 0;
  // PTX:369 $L__BB9_43:
L_BB9_43:;
  // PTX:370 setp.eq.s16 %p44, %rs25, 0
  p44 = (((short)(rs25)) == ((short)(0)));
  // PTX:371 @%p44 bra $L__BB9_47
  if (p44) { goto L_BB9_47; }
  // PTX:373 red.global.add.f32 [%rd19], %f20
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))), (float)(f20));
  // PTX:374 red.global.add.f32 [%rd20], %f21
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))), (float)(f21));
  // PTX:375 red.global.add.f32 [%rd21], %f22
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (0)))), (float)(f22));
  // PTX:376 mul.lo.s64 %rd77, %rd35, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd77) : "l"(rd35));
  // PTX:377 add.s64 %rd78, %rd2, %rd77
  asm("add.s64 %0, %1, %2;" : "=l"(rd78) : "l"(rd2), "l"(rd77));
  // PTX:378 neg.f32 %f86, %f20
  asm("neg.f32 %0, %1;" : "=f"(f86) : "f"(f20));
  // PTX:379 red.global.add.f32 [%rd78], %f86
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd78) + (0)))), (float)(f86));
  // PTX:380 add.s64 %rd79, %rd78, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd79) : "l"(rd78));
  // PTX:381 neg.f32 %f88, %f21
  asm("neg.f32 %0, %1;" : "=f"(f88) : "f"(f21));
  // PTX:382 red.global.add.f32 [%rd79], %f88
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (0)))), (float)(f88));
  // PTX:383 add.s64 %rd80, %rd78, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd80) : "l"(rd78));
  // PTX:384 neg.f32 %f90, %f22
  asm("neg.f32 %0, %1;" : "=f"(f90) : "f"(f22));
  // PTX:385 red.global.add.f32 [%rd80], %f90
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (0)))), (float)(f90));
  // PTX:386 red.global.add.f32 [%rd22], %f23
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (0)))), (float)(f23));
  // PTX:387 red.global.add.f32 [%rd23], %f24
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (0)))), (float)(f24));
  // PTX:388 red.global.add.f32 [%rd24], %f25
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (0)))), (float)(f25));
  // PTX:389 red.global.add.f32 [%rd25], %f24
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (0)))), (float)(f24));
  // PTX:390 red.global.add.f32 [%rd26], %f26
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (0)))), (float)(f26));
  // PTX:391 red.global.add.f32 [%rd27], %f27
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))), (float)(f27));
  // PTX:392 red.global.add.f32 [%rd28], %f25
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (0)))), (float)(f25));
  // PTX:393 red.global.add.f32 [%rd29], %f27
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (0)))), (float)(f27));
  // PTX:394 red.global.add.f32 [%rd30], %f28
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0)))), (float)(f28));
  // PTX:395 mul.lo.s64 %rd81, %rd35, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd81) : "l"(rd35));
  // PTX:396 add.s64 %rd82, %rd1, %rd81
  asm("add.s64 %0, %1, %2;" : "=l"(rd82) : "l"(rd1), "l"(rd81));
  // PTX:397 red.global.add.f32 [%rd82], %f23
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (0)))), (float)(f23));
  // PTX:398 add.s64 %rd83, %rd82, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd83) : "l"(rd82));
  // PTX:399 red.global.add.f32 [%rd83], %f24
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (0)))), (float)(f24));
  // PTX:400 add.s64 %rd84, %rd82, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd84) : "l"(rd82));
  // PTX:401 red.global.add.f32 [%rd84], %f25
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (0)))), (float)(f25));
  // PTX:402 add.s64 %rd85, %rd82, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd85) : "l"(rd82));
  // PTX:403 red.global.add.f32 [%rd85], %f24
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (0)))), (float)(f24));
  // PTX:404 add.s64 %rd86, %rd82, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd86) : "l"(rd82));
  // PTX:405 red.global.add.f32 [%rd86], %f26
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd86) + (0)))), (float)(f26));
  // PTX:406 add.s64 %rd87, %rd82, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd87) : "l"(rd82));
  // PTX:407 red.global.add.f32 [%rd87], %f27
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (0)))), (float)(f27));
  // PTX:408 add.s64 %rd88, %rd82, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd88) : "l"(rd82));
  // PTX:409 red.global.add.f32 [%rd88], %f25
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (0)))), (float)(f25));
  // PTX:410 add.s64 %rd89, %rd82, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd89) : "l"(rd82));
  // PTX:411 red.global.add.f32 [%rd89], %f27
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (0)))), (float)(f27));
  // PTX:412 add.s64 %rd90, %rd82, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd90) : "l"(rd82));
  // PTX:413 red.global.add.f32 [%rd90], %f28
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (0)))), (float)(f28));
  // PTX:414 setp.eq.s64 %p45, %rd39, 0
  p45 = (((long long)(rd39)) == ((long long)(0)));
  // PTX:415 @%p45 bra $L__BB9_46
  if (p45) { goto L_BB9_46; }
  // PTX:417 cvta.to.global.u64 %rd93, %rd39
  rd93 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd39));
  // PTX:418 atom.global.add.u32 %r42, [%rd32], 1
  r42 = atomicAdd(reinterpret_cast<unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (0)))), (unsigned)(1));
  // PTX:419 mul.wide.u32 %rd91, %r42, 60
  asm("mul.wide.u32 %0, %1, 60;" : "=l"(rd91) : "r"(r42));
  // PTX:420 add.s64 %rd92, %rd93, %rd91
  asm("add.s64 %0, %1, %2;" : "=l"(rd92) : "l"(rd93), "l"(rd91));
  // PTX:421 st.global.u32 [%rd92], %r2
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (0))))) = (unsigned)(r2);
  // PTX:422 st.global.u32 [%rd92+4], %r6
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (4))))) = (unsigned)(r6);
  // PTX:423 mov.u32 %r43, 0
  asm("mov.u32 %0, 0;" : "=r"(r43) : );
  // PTX:424 st.global.u32 [%rd92+8], %r43
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (8))))) = (unsigned)(r43);
  // PTX:425 st.global.u32 [%rd92+12], %r43
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (12))))) = (unsigned)(r43);
  // PTX:426 st.global.u32 [%rd92+16], %r43
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (16))))) = (unsigned)(r43);
  // PTX:427 mov.u32 %r44, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r44) : );
  // PTX:428 st.global.u32 [%rd92+20], %r44
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (20))))) = (unsigned)(r44);
  // PTX:429 mov.u32 %r45, -1082130432
  asm("mov.u32 %0, -1082130432;" : "=r"(r45) : );
  // PTX:430 st.global.u32 [%rd92+24], %r45
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (24))))) = (unsigned)(r45);
  // PTX:431 st.global.u32 [%rd92+28], %r43
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (28))))) = (unsigned)(r43);
  // PTX:432 st.global.u32 [%rd92+32], %r43
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (32))))) = (unsigned)(r43);
  // PTX:433 st.global.u32 [%rd92+36], %r43
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (36))))) = (unsigned)(r43);
  // PTX:434 st.global.u32 [%rd92+40], %r49
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (40))))) = (unsigned)(r49);
  // PTX:435 st.global.u32 [%rd92+44], %r50
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (44))))) = (unsigned)(r50);
  // PTX:436 st.global.u32 [%rd92+48], %r51
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (48))))) = (unsigned)(r51);
  // PTX:437 st.global.f32 [%rd92+52], %f114
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (52))))) = (float)(f114);
  // PTX:438 mov.u32 %r46, 2
  asm("mov.u32 %0, 2;" : "=r"(r46) : );
  // PTX:439 st.global.u32 [%rd92+56], %r46
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (56))))) = (unsigned)(r46);
  // PTX:441 $L__BB9_46:
L_BB9_46:;
  // PTX:442 ld.global.u32 %r52, [%rd16]
  r52 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:444 $L__BB9_47:
L_BB9_47:;
  // PTX:445 add.s32 %r48, %r48, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r48) : "r"(r48));
  // PTX:446 setp.lt.s32 %p46, %r48, %r52
  p46 = (((int)(r48)) < ((int)(r52)));
  // PTX:447 @%p46 bra $L__BB9_10
  if (p46) { goto L_BB9_10; }
  // PTX:449 $L__BB9_48:
L_BB9_48:;
  // PTX:450 ret
  return;
}
