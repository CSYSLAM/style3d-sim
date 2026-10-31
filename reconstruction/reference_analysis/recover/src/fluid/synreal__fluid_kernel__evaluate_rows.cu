// 机械还原自 PTX：synreal::fluid_kernel::evaluate_rows(synreal::fluid_kernel::View, glm::vec<3, float, (glm::qualifier)0>*, float*, float*, int*, int*, glm::vec<4, float, (glm::qualifier)0>*)
// PTX SHA256: d9ce428c5c21a3624d6a88aab07be3d60fdb47de4c451ed5e1a0276e7d7638c0
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__fluid_kernel__evaluate_rows(ByVal<112, 8> param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32;
  unsigned short rs0, rs1, rs2, rs3, rs4, rs5, rs6, rs7, rs8, rs9, rs10;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121, r122, r123, r124, r125, r126, r127, r128, r129, r130, r131, r132, r133, r134, r135, r136, r137, r138, r139, r140, r141, r142, r143, r144, r145, r146, r147, r148, r149, r150, r151;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100;
  // PTX:24 ld.param.v2.u32 {%r51, %r52}, [_ZN7synreal12fluid_kernel13evaluate_rowsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPfS7_PiS8_PNS3_ILi4EfLS4_0EEE_param_0+80]
  r51 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param0 + (80)))); r52 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param0 + (84))));
  // PTX:25 ld.param.v2.u32 {%r53, %r54}, [_ZN7synreal12fluid_kernel13evaluate_rowsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPfS7_PiS8_PNS3_ILi4EfLS4_0EEE_param_0+88]
  r53 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param0 + (88)))); r54 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param0 + (92))));
  // PTX:26 ld.param.v2.f32 {%f49, %f50}, [_ZN7synreal12fluid_kernel13evaluate_rowsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPfS7_PiS8_PNS3_ILi4EfLS4_0EEE_param_0+96]
  f49 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (96)))); f50 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (100))));
  // PTX:27 ld.param.v2.f32 {%f51, %f52}, [_ZN7synreal12fluid_kernel13evaluate_rowsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPfS7_PiS8_PNS3_ILi4EfLS4_0EEE_param_0+104]
  f51 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (104)))); f52 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (108))));
  // PTX:28 ld.param.u64 %rd40, [_ZN7synreal12fluid_kernel13evaluate_rowsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPfS7_PiS8_PNS3_ILi4EfLS4_0EEE_param_5]
  rd40 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:29 ld.param.u64 %rd41, [_ZN7synreal12fluid_kernel13evaluate_rowsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPfS7_PiS8_PNS3_ILi4EfLS4_0EEE_param_6]
  rd41 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:30 ld.param.u64 %rd32, [_ZN7synreal12fluid_kernel13evaluate_rowsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPfS7_PiS8_PNS3_ILi4EfLS4_0EEE_param_0+48]
  rd32 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (48))));
  // PTX:31 ld.param.u64 %rd31, [_ZN7synreal12fluid_kernel13evaluate_rowsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPfS7_PiS8_PNS3_ILi4EfLS4_0EEE_param_0+40]
  rd31 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (40))));
  // PTX:32 ld.param.u64 %rd30, [_ZN7synreal12fluid_kernel13evaluate_rowsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPfS7_PiS8_PNS3_ILi4EfLS4_0EEE_param_0+32]
  rd30 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (32))));
  // PTX:33 ld.param.u64 %rd29, [_ZN7synreal12fluid_kernel13evaluate_rowsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPfS7_PiS8_PNS3_ILi4EfLS4_0EEE_param_0+24]
  rd29 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (24))));
  // PTX:34 ld.param.u64 %rd28, [_ZN7synreal12fluid_kernel13evaluate_rowsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPfS7_PiS8_PNS3_ILi4EfLS4_0EEE_param_0+16]
  rd28 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (16))));
  // PTX:35 ld.param.u64 %rd27, [_ZN7synreal12fluid_kernel13evaluate_rowsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPfS7_PiS8_PNS3_ILi4EfLS4_0EEE_param_0+8]
  rd27 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (8))));
  // PTX:36 ld.param.u64 %rd26, [_ZN7synreal12fluid_kernel13evaluate_rowsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPfS7_PiS8_PNS3_ILi4EfLS4_0EEE_param_0]
  rd26 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:37 cvta.to.global.u64 %rd1, %rd26
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd26));
  // PTX:38 cvta.to.global.u64 %rd2, %rd27
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd27));
  // PTX:39 cvta.to.global.u64 %rd3, %rd29
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd29));
  // PTX:40 cvta.to.global.u64 %rd4, %rd30
  rd4 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd30));
  // PTX:41 cvta.to.global.u64 %rd5, %rd31
  rd5 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd31));
  // PTX:42 cvta.to.global.u64 %rd6, %rd32
  rd6 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd32));
  // PTX:43 mov.u32 %r55, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r55) : "r"(blockDim.x));
  // PTX:44 mov.u32 %r56, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r56) : "r"(blockIdx.x));
  // PTX:45 mov.u32 %r57, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r57) : "r"(threadIdx.x));
  // PTX:46 mad.lo.s32 %r1, %r56, %r55, %r57
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r1) : "r"(r56), "r"(r55), "r"(r57));
  // PTX:47 setp.ge.s32 %p1, %r1, %r54
  p1 = (((int)(r1)) >= ((int)(r54)));
  // PTX:48 @%p1 bra $L__BB1_36
  if (p1) { goto L_BB1_36; }
  // PTX:50 div.s32 %r61, %r1, %r53
  asm("div.s32 %0, %1, %2;" : "=r"(r61) : "r"(r1), "r"(r53));
  // PTX:51 mul.lo.s32 %r62, %r61, %r53
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r62) : "r"(r61), "r"(r53));
  // PTX:52 sub.s32 %r63, %r1, %r62
  asm("sub.s32 %0, %1, %2;" : "=r"(r63) : "r"(r1), "r"(r62));
  // PTX:53 mad.lo.s32 %r64, %r61, %r52, %r63
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r64) : "r"(r61), "r"(r52), "r"(r63));
  // PTX:54 cvt.s64.s32 %rd7, %r64
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd7) : "r"(r64));
  // PTX:55 mul.wide.s32 %rd42, %r64, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd42) : "r"(r64));
  // PTX:56 add.s64 %rd43, %rd4, %rd42
  asm("add.s64 %0, %1, %2;" : "=l"(rd43) : "l"(rd4), "l"(rd42));
  // PTX:57 mul.wide.s32 %rd44, %r64, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd44) : "r"(r64));
  // PTX:58 add.s64 %rd45, %rd3, %rd44
  asm("add.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd3), "l"(rd44));
  // PTX:59 ld.global.u32 %r2, [%rd45]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))));
  // PTX:60 ld.global.u32 %r65, [%rd43]
  r65 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (0)))));
  // PTX:61 add.s32 %r3, %r65, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r3) : "r"(r65));
  // PTX:62 mov.u32 %r149, -1
  asm("mov.u32 %0, -1;" : "=r"(r149) : );
  // PTX:63 ld.global.u32 %r66, [%rd43+4]
  r66 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (4)))));
  // PTX:64 add.s32 %r4, %r66, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r4) : "r"(r66));
  // PTX:65 ld.global.u32 %r67, [%rd43+8]
  r67 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (8)))));
  // PTX:66 add.s32 %r5, %r67, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r5) : "r"(r67));
  // PTX:67 add.s32 %r6, %r51, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r6) : "r"(r51));
  // PTX:68 cvta.to.global.u64 %rd8, %rd28
  rd8 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd28));
  // PTX:69 cvta.to.global.u64 %rd13, %rd40
  rd13 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd40));
  // PTX:70 cvta.to.global.u64 %rd14, %rd41
  rd14 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd41));
  // PTX:71 mov.u32 %r146, 0
  asm("mov.u32 %0, 0;" : "=r"(r146) : );
  // PTX:72 bra.uni $L__BB1_2
  goto L_BB1_2;
  // PTX:74 $L__BB1_11:
L_BB1_11:;
  // PTX:75 mul.wide.u32 %rd51, %r146, -1431655765
  asm("mul.wide.u32 %0, %1, -1431655765;" : "=l"(rd51) : "r"(r146));
  // PTX:76 shr.u64 %rd52, %rd51, 33
  asm("shr.u64 %0, %1, 33;" : "=l"(rd52) : "l"(rd51));
  // PTX:77 cvt.u32.u64 %r73, %rd52
  asm("cvt.u32.u64 %0, %1;" : "=r"(r73) : "l"(rd52));
  // PTX:78 mul.lo.s32 %r74, %r73, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r74) : "r"(r73));
  // PTX:79 sub.s32 %r75, %r146, %r74
  asm("sub.s32 %0, %1, %2;" : "=r"(r75) : "r"(r146), "r"(r74));
  // PTX:80 mul.wide.u32 %rd53, %r73, -1431655765
  asm("mul.wide.u32 %0, %1, -1431655765;" : "=l"(rd53) : "r"(r73));
  // PTX:81 shr.u64 %rd54, %rd53, 33
  asm("shr.u64 %0, %1, 33;" : "=l"(rd54) : "l"(rd53));
  // PTX:82 cvt.u32.u64 %r76, %rd54
  asm("cvt.u32.u64 %0, %1;" : "=r"(r76) : "l"(rd54));
  // PTX:83 mul.lo.s32 %r77, %r76, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r77) : "r"(r76));
  // PTX:84 sub.s32 %r78, %r73, %r77
  asm("sub.s32 %0, %1, %2;" : "=r"(r78) : "r"(r73), "r"(r77));
  // PTX:85 add.s32 %r142, %r3, %r75
  asm("add.s32 %0, %1, %2;" : "=r"(r142) : "r"(r3), "r"(r75));
  // PTX:86 add.s32 %r143, %r4, %r78
  asm("add.s32 %0, %1, %2;" : "=r"(r143) : "r"(r4), "r"(r78));
  // PTX:87 mul.wide.u32 %rd55, %r146, 954437177
  asm("mul.wide.u32 %0, %1, 954437177;" : "=l"(rd55) : "r"(r146));
  // PTX:88 shr.u64 %rd56, %rd55, 33
  asm("shr.u64 %0, %1, 33;" : "=l"(rd56) : "l"(rd55));
  // PTX:89 cvt.u32.u64 %r79, %rd56
  asm("cvt.u32.u64 %0, %1;" : "=r"(r79) : "l"(rd56));
  // PTX:90 add.s32 %r144, %r5, %r79
  asm("add.s32 %0, %1, %2;" : "=r"(r144) : "r"(r5), "r"(r79));
  // PTX:91 add.s32 %r146, %r146, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r146) : "r"(r146));
  // PTX:92 mul.lo.s32 %r80, %r142, 73856093
  asm("mul.lo.s32 %0, %1, 73856093;" : "=r"(r80) : "r"(r142));
  // PTX:93 mul.lo.s32 %r81, %r143, 19349663
  asm("mul.lo.s32 %0, %1, 19349663;" : "=r"(r81) : "r"(r143));
  // PTX:94 mul.lo.s32 %r82, %r144, 83492791
  asm("mul.lo.s32 %0, %1, 83492791;" : "=r"(r82) : "r"(r144));
  // PTX:95 xor.b32 %r83, %r82, %r80
  asm("xor.b32 %0, %1, %2;" : "=r"(r83) : "r"(r82), "r"(r80));
  // PTX:96 xor.b32 %r84, %r83, %r81
  asm("xor.b32 %0, %1, %2;" : "=r"(r84) : "r"(r83), "r"(r81));
  // PTX:97 and.b32 %r85, %r84, %r6
  asm("and.b32 %0, %1, %2;" : "=r"(r85) : "r"(r84), "r"(r6));
  // PTX:98 mul.wide.s32 %rd57, %r85, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd57) : "r"(r85));
  // PTX:99 add.s64 %rd58, %rd1, %rd57
  asm("add.s64 %0, %1, %2;" : "=l"(rd58) : "l"(rd1), "l"(rd57));
  // PTX:100 ld.global.u32 %r149, [%rd58]
  r149 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (0)))));
  // PTX:102 $L__BB1_2:
L_BB1_2:;
  // PTX:103 setp.lt.s32 %p2, %r149, 0
  p2 = (((int)(r149)) < ((int)(0)));
  // PTX:104 @%p2 bra $L__BB1_10
  if (p2) { goto L_BB1_10; }
  // PTX:106 mov.u32 %r150, %r149
  asm("mov.u32 %0, %1;" : "=r"(r150) : "r"(r149));
  // PTX:108 $L__BB1_4:
L_BB1_4:;
  // PTX:109 cvt.s64.s32 %rd15, %r150
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd15) : "r"(r150));
  // PTX:110 mul.wide.s32 %rd46, %r150, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd46) : "r"(r150));
  // PTX:111 add.s64 %rd47, %rd2, %rd46
  asm("add.s64 %0, %1, %2;" : "=l"(rd47) : "l"(rd2), "l"(rd46));
  // PTX:112 ld.global.u32 %r149, [%rd47]
  r149 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))));
  // PTX:113 mul.wide.s32 %rd48, %r150, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd48) : "r"(r150));
  // PTX:114 add.s64 %rd16, %rd4, %rd48
  asm("add.s64 %0, %1, %2;" : "=l"(rd16) : "l"(rd4), "l"(rd48));
  // PTX:115 ld.global.u32 %r68, [%rd16]
  r68 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:116 setp.ne.s32 %p3, %r68, %r142
  p3 = (((int)(r68)) != ((int)(r142)));
  // PTX:117 mov.u16 %rs9, 0
  asm("mov.u16 %0, 0;" : "=h"(rs9) : );
  // PTX:118 @%p3 bra $L__BB1_7
  if (p3) { goto L_BB1_7; }
  // PTX:120 ld.global.u32 %r69, [%rd16+4]
  r69 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (4)))));
  // PTX:121 setp.ne.s32 %p4, %r69, %r143
  p4 = (((int)(r69)) != ((int)(r143)));
  // PTX:122 @%p4 bra $L__BB1_7
  if (p4) { goto L_BB1_7; }
  // PTX:124 ld.global.u32 %r70, [%rd16+8]
  r70 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (8)))));
  // PTX:125 setp.eq.s32 %p5, %r70, %r144
  p5 = (((int)(r70)) == ((int)(r144)));
  // PTX:126 selp.u16 %rs9, 1, 0, %p5
  rs9 = p5 ? 1 : 0;
  // PTX:128 $L__BB1_7:
L_BB1_7:;
  // PTX:129 setp.eq.s16 %p6, %rs9, 0
  p6 = (((short)(rs9)) == ((short)(0)));
  // PTX:130 @%p6 bra $L__BB1_9
  if (p6) { goto L_BB1_9; }
  // PTX:132 shl.b64 %rd49, %rd15, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd49) : "l"(rd15));
  // PTX:133 add.s64 %rd50, %rd3, %rd49
  asm("add.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd3), "l"(rd49));
  // PTX:134 ld.global.u32 %r71, [%rd50]
  r71 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (0)))));
  // PTX:135 setp.eq.s32 %p7, %r71, %r2
  p7 = (((int)(r71)) == ((int)(r2)));
  // PTX:136 setp.eq.s32 %p8, %r71, -1
  p8 = (((int)(r71)) == ((int)(-1)));
  // PTX:137 or.pred %p9, %p7, %p8
  p9 = ((p7) || (p8));
  // PTX:138 @%p9 bra $L__BB1_12
  if (p9) { goto L_BB1_12; }
  // PTX:140 $L__BB1_9:
L_BB1_9:;
  // PTX:141 setp.gt.s32 %p10, %r149, -1
  p10 = (((int)(r149)) > ((int)(-1)));
  // PTX:142 mov.u32 %r150, %r149
  asm("mov.u32 %0, %1;" : "=r"(r150) : "r"(r149));
  // PTX:143 @%p10 bra $L__BB1_4
  if (p10) { goto L_BB1_4; }
  // PTX:145 $L__BB1_10:
L_BB1_10:;
  // PTX:146 setp.eq.s32 %p11, %r146, 27
  p11 = (((int)(r146)) == ((int)(27)));
  // PTX:147 mov.u32 %r150, -1
  asm("mov.u32 %0, -1;" : "=r"(r150) : );
  // PTX:148 @%p11 bra $L__BB1_12
  if (p11) { goto L_BB1_12; }
  // PTX:149 bra.uni $L__BB1_11
  goto L_BB1_11;
  // PTX:151 $L__BB1_12:
L_BB1_12:;
  // PTX:152 shl.b64 %rd59, %rd7, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd59) : "l"(rd7));
  // PTX:153 add.s64 %rd17, %rd6, %rd59
  asm("add.s64 %0, %1, %2;" : "=l"(rd17) : "l"(rd6), "l"(rd59));
  // PTX:154 setp.gt.s32 %p12, %r150, -1
  p12 = (((int)(r150)) > ((int)(-1)));
  // PTX:155 @%p12 bra $L__BB1_14
  if (p12) { goto L_BB1_14; }
  // PTX:156 bra.uni $L__BB1_13
  goto L_BB1_13;
  // PTX:158 $L__BB1_14:
L_BB1_14:;
  // PTX:159 mov.u32 %r124, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r124) : "r"(threadIdx.x));
  // PTX:160 mov.u32 %r123, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r123) : "r"(blockDim.x));
  // PTX:161 mov.u32 %r122, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r122) : "r"(blockIdx.x));
  // PTX:162 mad.lo.s32 %r121, %r122, %r123, %r124
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r121) : "r"(r122), "r"(r123), "r"(r124));
  // PTX:163 mul.lo.s64 %rd60, %rd7, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd60) : "l"(rd7));
  // PTX:164 add.s64 %rd18, %rd5, %rd60
  asm("add.s64 %0, %1, %2;" : "=l"(rd18) : "l"(rd5), "l"(rd60));
  // PTX:165 mul.f32 %f5, %f49, %f49
  asm("mul.f32 %0, %1, %2;" : "=f"(f5) : "f"(f49), "f"(f49));
  // PTX:166 mul.f32 %f6, %f49, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f6) : "f"(f49), "f"(f5));
  // PTX:167 mul.f32 %f64, %f49, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f64) : "f"(f49), "f"(f6));
  // PTX:168 mul.f32 %f7, %f49, %f64
  asm("mul.f32 %0, %1, %2;" : "=f"(f7) : "f"(f49), "f"(f64));
  // PTX:169 mul.wide.s32 %rd19, %r121, 64
  asm("mul.wide.s32 %0, %1, 64;" : "=l"(rd19) : "r"(r121));
  // PTX:170 mul.f32 %f8, %f51, 0fC0000000
  asm("mul.f32 %0, %1, 0fC0000000;" : "=f"(f8) : "f"(f51));
  // PTX:171 mul.f32 %f65, %f49, 0f3C23D70A
  asm("mul.f32 %0, %1, 0f3C23D70A;" : "=f"(f65) : "f"(f49));
  // PTX:172 mul.f32 %f9, %f49, %f65
  asm("mul.f32 %0, %1, %2;" : "=f"(f9) : "f"(f49), "f"(f65));
  // PTX:173 mov.f32 %f63, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f63) : );
  // PTX:174 mov.u32 %r141, 0
  asm("mov.u32 %0, 0;" : "=r"(r141) : );
  // PTX:175 mov.f32 %f122, %f63
  asm("mov.f32 %0, %1;" : "=f"(f122) : "f"(f63));
  // PTX:176 mov.f32 %f114, %f63
  asm("mov.f32 %0, %1;" : "=f"(f114) : "f"(f63));
  // PTX:177 mov.f32 %f116, %f63
  asm("mov.f32 %0, %1;" : "=f"(f116) : "f"(f63));
  // PTX:178 mov.f32 %f118, %f63
  asm("mov.f32 %0, %1;" : "=f"(f118) : "f"(f63));
  // PTX:180 $L__BB1_15:
L_BB1_15:;
  // PTX:181 ld.param.u64 %rd99, [_ZN7synreal12fluid_kernel13evaluate_rowsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPfS7_PiS8_PNS3_ILi4EfLS4_0EEE_param_0+48]
  rd99 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (48))));
  // PTX:182 cvta.to.global.u64 %rd98, %rd99
  rd98 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd99));
  // PTX:183 mul.wide.s32 %rd61, %r150, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd61) : "r"(r150));
  // PTX:184 add.s64 %rd62, %rd5, %rd61
  asm("add.s64 %0, %1, %2;" : "=l"(rd62) : "l"(rd5), "l"(rd61));
  // PTX:185 ld.global.f32 %f66, [%rd62]
  f66 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))));
  // PTX:186 ld.global.f32 %f67, [%rd18]
  f67 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (0)))));
  // PTX:187 sub.f32 %f17, %f67, %f66
  asm("sub.f32 %0, %1, %2;" : "=f"(f17) : "f"(f67), "f"(f66));
  // PTX:188 ld.global.f32 %f68, [%rd62+4]
  f68 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (4)))));
  // PTX:189 ld.global.f32 %f69, [%rd18+4]
  f69 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (4)))));
  // PTX:190 sub.f32 %f18, %f69, %f68
  asm("sub.f32 %0, %1, %2;" : "=f"(f18) : "f"(f69), "f"(f68));
  // PTX:191 ld.global.f32 %f70, [%rd62+8]
  f70 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (8)))));
  // PTX:192 ld.global.f32 %f71, [%rd18+8]
  f71 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (8)))));
  // PTX:193 sub.f32 %f19, %f71, %f70
  asm("sub.f32 %0, %1, %2;" : "=f"(f19) : "f"(f71), "f"(f70));
  // PTX:194 mul.wide.s32 %rd63, %r150, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd63) : "r"(r150));
  // PTX:195 add.s64 %rd21, %rd98, %rd63
  asm("add.s64 %0, %1, %2;" : "=l"(rd21) : "l"(rd98), "l"(rd63));
  // PTX:196 mul.f32 %f72, %f18, %f18
  asm("mul.f32 %0, %1, %2;" : "=f"(f72) : "f"(f18), "f"(f18));
  // PTX:197 fma.rn.f32 %f73, %f17, %f17, %f72
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f73) : "f"(f17), "f"(f17), "f"(f72));
  // PTX:198 fma.rn.f32 %f20, %f19, %f19, %f73
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f20) : "f"(f19), "f"(f19), "f"(f73));
  // PTX:199 div.rn.f32 %f74, %f20, %f5
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f74) : "f"(f20), "f"(f5));
  // PTX:200 mov.f32 %f75, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f75) : );
  // PTX:201 sub.f32 %f76, %f75, %f74
  asm("sub.f32 %0, %1, %2;" : "=f"(f76) : "f"(f75), "f"(f74));
  // PTX:202 max.f32 %f21, %f76, %f63
  asm("max.f32 %0, %1, %2;" : "=f"(f21) : "f"(f76), "f"(f63));
  // PTX:203 mul.f32 %f78, %f21, 0f3FC88904
  asm("mul.f32 %0, %1, 0f3FC88904;" : "=f"(f78) : "f"(f21));
  // PTX:204 mul.f32 %f79, %f21, %f78
  asm("mul.f32 %0, %1, %2;" : "=f"(f79) : "f"(f21), "f"(f78));
  // PTX:205 mul.f32 %f80, %f21, %f79
  asm("mul.f32 %0, %1, %2;" : "=f"(f80) : "f"(f21), "f"(f79));
  // PTX:206 div.rn.f32 %f81, %f80, %f6
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f81) : "f"(f80), "f"(f6));
  // PTX:207 ld.global.f32 %f22, [%rd21]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (0)))));
  // PTX:208 fma.rn.f32 %f122, %f22, %f81, %f122
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f122) : "f"(f22), "f"(f81), "f"(f122));
  // PTX:209 cvt.u32.u64 %r88, %rd7
  asm("cvt.u32.u64 %0, %1;" : "=r"(r88) : "l"(rd7));
  // PTX:210 setp.eq.s32 %p13, %r88, %r150
  p13 = (((int)(r88)) == ((int)(r150)));
  // PTX:211 @%p13 bra $L__BB1_22
  if (p13) { goto L_BB1_22; }
  // PTX:213 cvt.s64.s32 %rd85, %r150
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd85) : "r"(r150));
  // PTX:214 mul.f32 %f82, %f21, 0fC11666C3
  asm("mul.f32 %0, %1, 0fC11666C3;" : "=f"(f82) : "f"(f21));
  // PTX:215 mul.f32 %f83, %f21, %f82
  asm("mul.f32 %0, %1, %2;" : "=f"(f83) : "f"(f21), "f"(f82));
  // PTX:216 mul.f32 %f84, %f17, %f83
  asm("mul.f32 %0, %1, %2;" : "=f"(f84) : "f"(f17), "f"(f83));
  // PTX:217 mul.f32 %f85, %f18, %f83
  asm("mul.f32 %0, %1, %2;" : "=f"(f85) : "f"(f18), "f"(f83));
  // PTX:218 mul.f32 %f86, %f19, %f83
  asm("mul.f32 %0, %1, %2;" : "=f"(f86) : "f"(f19), "f"(f83));
  // PTX:219 div.rn.f32 %f24, %f84, %f7
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f24) : "f"(f84), "f"(f7));
  // PTX:220 div.rn.f32 %f25, %f85, %f7
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f25) : "f"(f85), "f"(f7));
  // PTX:221 div.rn.f32 %f26, %f86, %f7
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f26) : "f"(f86), "f"(f7));
  // PTX:222 fma.rn.f32 %f118, %f24, %f22, %f118
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f118) : "f"(f24), "f"(f22), "f"(f118));
  // PTX:223 fma.rn.f32 %f116, %f25, %f22, %f116
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f116) : "f"(f25), "f"(f22), "f"(f116));
  // PTX:224 fma.rn.f32 %f114, %f26, %f22, %f114
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f114) : "f"(f26), "f"(f22), "f"(f114));
  // PTX:225 shl.b64 %rd64, %rd85, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd64) : "l"(rd85));
  // PTX:226 add.s64 %rd65, %rd8, %rd64
  asm("add.s64 %0, %1, %2;" : "=l"(rd65) : "l"(rd8), "l"(rd64));
  // PTX:227 ld.global.u32 %r89, [%rd65]
  r89 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (0)))));
  // PTX:228 setp.lt.s32 %p14, %r89, 0
  p14 = (((int)(r89)) < ((int)(0)));
  // PTX:229 setp.geu.f32 %p15, %f20, %f5
  p15 = ((isnan(((float)(f20))) || isnan(((float)(f5)))) || (((float)(f20)) >= ((float)(f5))));
  // PTX:230 or.pred %p16, %p15, %p14
  p16 = ((p15) || (p14));
  // PTX:231 @%p16 bra $L__BB1_22
  if (p16) { goto L_BB1_22; }
  // PTX:233 setp.gt.s32 %p17, %r141, 63
  p17 = (((int)(r141)) > ((int)(63)));
  // PTX:234 @%p17 bra $L__BB1_21
  if (p17) { goto L_BB1_21; }
  // PTX:236 cvt.u32.u64 %r116, %rd7
  asm("cvt.u32.u64 %0, %1;" : "=r"(r116) : "l"(rd7));
  // PTX:237 ld.param.u64 %rd89, [_ZN7synreal12fluid_kernel13evaluate_rowsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPfS7_PiS8_PNS3_ILi4EfLS4_0EEE_param_0+48]
  rd89 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (48))));
  // PTX:238 mul.wide.s32 %rd88, %r150, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd88) : "r"(r150));
  // PTX:239 cvta.to.global.u64 %rd87, %rd89
  rd87 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd89));
  // PTX:240 add.s64 %rd86, %rd87, %rd88
  asm("add.s64 %0, %1, %2;" : "=l"(rd86) : "l"(rd87), "l"(rd88));
  // PTX:241 setp.leu.f32 %p18, %f51, 0f00000000
  p18 = ((isnan(((float)(f51))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f51)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:242 mov.f32 %f112, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f112) : );
  // PTX:243 cvt.s64.s32 %rd66, %r141
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd66) : "r"(r141));
  // PTX:244 add.s64 %rd22, %rd19, %rd66
  asm("add.s64 %0, %1, %2;" : "=l"(rd22) : "l"(rd19), "l"(rd66));
  // PTX:245 shl.b64 %rd67, %rd22, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd67) : "l"(rd22));
  // PTX:246 add.s64 %rd68, %rd13, %rd67
  asm("add.s64 %0, %1, %2;" : "=l"(rd68) : "l"(rd13), "l"(rd67));
  // PTX:247 st.global.u32 [%rd68], %r150
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (0))))) = (unsigned)(r150);
  // PTX:248 ld.global.f32 %f30, [%rd86]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd86) + (0)))));
  // PTX:249 setp.le.s32 %p19, %r150, %r116
  p19 = (((int)(r150)) <= ((int)(r116)));
  // PTX:250 or.pred %p20, %p18, %p19
  p20 = ((p18) || (p19));
  // PTX:251 @%p20 bra $L__BB1_20
  if (p20) { goto L_BB1_20; }
  // PTX:253 ld.global.f32 %f88, [%rd17]
  f88 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:254 mul.f32 %f89, %f8, %f88
  asm("mul.f32 %0, %1, %2;" : "=f"(f89) : "f"(f8), "f"(f88));
  // PTX:255 mul.f32 %f90, %f89, %f30
  asm("mul.f32 %0, %1, %2;" : "=f"(f90) : "f"(f89), "f"(f30));
  // PTX:256 mul.f32 %f91, %f18, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f91) : "f"(f18), "f"(f25));
  // PTX:257 fma.rn.f32 %f92, %f17, %f24, %f91
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f92) : "f"(f17), "f"(f24), "f"(f91));
  // PTX:258 fma.rn.f32 %f93, %f19, %f26, %f92
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f93) : "f"(f19), "f"(f26), "f"(f92));
  // PTX:259 mul.f32 %f94, %f93, %f90
  asm("mul.f32 %0, %1, %2;" : "=f"(f94) : "f"(f93), "f"(f90));
  // PTX:260 add.f32 %f95, %f9, %f20
  asm("add.f32 %0, %1, %2;" : "=f"(f95) : "f"(f9), "f"(f20));
  // PTX:261 div.rn.f32 %f96, %f94, %f95
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f96) : "f"(f94), "f"(f95));
  // PTX:262 div.rn.f32 %f112, %f96, %f52
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f112) : "f"(f96), "f"(f52));
  // PTX:264 $L__BB1_20:
L_BB1_20:;
  // PTX:265 neg.f32 %f97, %f30
  asm("neg.f32 %0, %1;" : "=f"(f97) : "f"(f30));
  // PTX:266 shl.b64 %rd69, %rd22, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd69) : "l"(rd22));
  // PTX:267 add.s64 %rd70, %rd14, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd70) : "l"(rd14), "l"(rd69));
  // PTX:268 mul.f32 %f98, %f24, %f97
  asm("mul.f32 %0, %1, %2;" : "=f"(f98) : "f"(f24), "f"(f97));
  // PTX:269 st.global.f32 [%rd70], %f98
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0))))) = (float)(f98);
  // PTX:270 mul.f32 %f99, %f25, %f97
  asm("mul.f32 %0, %1, %2;" : "=f"(f99) : "f"(f25), "f"(f97));
  // PTX:271 st.global.f32 [%rd70+4], %f99
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (4))))) = (float)(f99);
  // PTX:272 mul.f32 %f100, %f26, %f97
  asm("mul.f32 %0, %1, %2;" : "=f"(f100) : "f"(f26), "f"(f97));
  // PTX:273 st.global.f32 [%rd70+8], %f100
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (8))))) = (float)(f100);
  // PTX:274 st.global.f32 [%rd70+12], %f112
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (12))))) = (float)(f112);
  // PTX:276 $L__BB1_21:
L_BB1_21:;
  // PTX:277 add.s32 %r141, %r141, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r141) : "r"(r141));
  // PTX:278 bra.uni $L__BB1_22
  goto L_BB1_22;
  // PTX:280 $L__BB1_31:
L_BB1_31:;
  // PTX:281 mul.hi.s32 %r96, %r146, 1431655766
  asm("mul.hi.s32 %0, %1, 1431655766;" : "=r"(r96) : "r"(r146));
  // PTX:282 shr.u32 %r97, %r96, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r97) : "r"(r96));
  // PTX:283 add.s32 %r98, %r96, %r97
  asm("add.s32 %0, %1, %2;" : "=r"(r98) : "r"(r96), "r"(r97));
  // PTX:284 mul.lo.s32 %r99, %r98, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r99) : "r"(r98));
  // PTX:285 sub.s32 %r100, %r146, %r99
  asm("sub.s32 %0, %1, %2;" : "=r"(r100) : "r"(r146), "r"(r99));
  // PTX:286 mul.hi.s32 %r101, %r98, 1431655766
  asm("mul.hi.s32 %0, %1, 1431655766;" : "=r"(r101) : "r"(r98));
  // PTX:287 shr.u32 %r102, %r101, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r102) : "r"(r101));
  // PTX:288 add.s32 %r103, %r101, %r102
  asm("add.s32 %0, %1, %2;" : "=r"(r103) : "r"(r101), "r"(r102));
  // PTX:289 mul.lo.s32 %r104, %r103, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r104) : "r"(r103));
  // PTX:290 sub.s32 %r105, %r98, %r104
  asm("sub.s32 %0, %1, %2;" : "=r"(r105) : "r"(r98), "r"(r104));
  // PTX:291 add.s32 %r142, %r3, %r100
  asm("add.s32 %0, %1, %2;" : "=r"(r142) : "r"(r3), "r"(r100));
  // PTX:292 add.s32 %r143, %r4, %r105
  asm("add.s32 %0, %1, %2;" : "=r"(r143) : "r"(r4), "r"(r105));
  // PTX:293 mul.hi.s32 %r106, %r146, 954437177
  asm("mul.hi.s32 %0, %1, 954437177;" : "=r"(r106) : "r"(r146));
  // PTX:294 shr.u32 %r107, %r106, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r107) : "r"(r106));
  // PTX:295 shr.s32 %r108, %r106, 1
  asm("shr.s32 %0, %1, 1;" : "=r"(r108) : "r"(r106));
  // PTX:296 add.s32 %r109, %r108, %r107
  asm("add.s32 %0, %1, %2;" : "=r"(r109) : "r"(r108), "r"(r107));
  // PTX:297 add.s32 %r144, %r5, %r109
  asm("add.s32 %0, %1, %2;" : "=r"(r144) : "r"(r5), "r"(r109));
  // PTX:298 add.s32 %r146, %r146, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r146) : "r"(r146));
  // PTX:299 mul.lo.s32 %r110, %r142, 73856093
  asm("mul.lo.s32 %0, %1, 73856093;" : "=r"(r110) : "r"(r142));
  // PTX:300 mul.lo.s32 %r111, %r143, 19349663
  asm("mul.lo.s32 %0, %1, 19349663;" : "=r"(r111) : "r"(r143));
  // PTX:301 mul.lo.s32 %r112, %r144, 83492791
  asm("mul.lo.s32 %0, %1, 83492791;" : "=r"(r112) : "r"(r144));
  // PTX:302 xor.b32 %r113, %r112, %r110
  asm("xor.b32 %0, %1, %2;" : "=r"(r113) : "r"(r112), "r"(r110));
  // PTX:303 xor.b32 %r114, %r113, %r111
  asm("xor.b32 %0, %1, %2;" : "=r"(r114) : "r"(r113), "r"(r111));
  // PTX:304 and.b32 %r115, %r114, %r6
  asm("and.b32 %0, %1, %2;" : "=r"(r115) : "r"(r114), "r"(r6));
  // PTX:305 mul.wide.s32 %rd76, %r115, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd76) : "r"(r115));
  // PTX:306 add.s64 %rd77, %rd1, %rd76
  asm("add.s64 %0, %1, %2;" : "=l"(rd77) : "l"(rd1), "l"(rd76));
  // PTX:307 ld.global.u32 %r149, [%rd77]
  r149 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (0)))));
  // PTX:309 $L__BB1_22:
L_BB1_22:;
  // PTX:310 setp.lt.s32 %p21, %r149, 0
  p21 = (((int)(r149)) < ((int)(0)));
  // PTX:311 @%p21 bra $L__BB1_30
  if (p21) { goto L_BB1_30; }
  // PTX:313 mov.u32 %r150, %r149
  asm("mov.u32 %0, %1;" : "=r"(r150) : "r"(r149));
  // PTX:315 $L__BB1_24:
L_BB1_24:;
  // PTX:316 mul.wide.s32 %rd71, %r150, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd71) : "r"(r150));
  // PTX:317 add.s64 %rd72, %rd2, %rd71
  asm("add.s64 %0, %1, %2;" : "=l"(rd72) : "l"(rd2), "l"(rd71));
  // PTX:318 ld.global.u32 %r149, [%rd72]
  r149 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (0)))));
  // PTX:319 mul.wide.s32 %rd73, %r150, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd73) : "r"(r150));
  // PTX:320 add.s64 %rd24, %rd4, %rd73
  asm("add.s64 %0, %1, %2;" : "=l"(rd24) : "l"(rd4), "l"(rd73));
  // PTX:321 ld.global.u32 %r91, [%rd24]
  r91 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (0)))));
  // PTX:322 setp.ne.s32 %p22, %r91, %r142
  p22 = (((int)(r91)) != ((int)(r142)));
  // PTX:323 mov.u16 %rs10, 0
  asm("mov.u16 %0, 0;" : "=h"(rs10) : );
  // PTX:324 @%p22 bra $L__BB1_27
  if (p22) { goto L_BB1_27; }
  // PTX:326 ld.global.u32 %r92, [%rd24+4]
  r92 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (4)))));
  // PTX:327 setp.ne.s32 %p23, %r92, %r143
  p23 = (((int)(r92)) != ((int)(r143)));
  // PTX:328 @%p23 bra $L__BB1_27
  if (p23) { goto L_BB1_27; }
  // PTX:330 ld.global.u32 %r93, [%rd24+8]
  r93 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (8)))));
  // PTX:331 setp.eq.s32 %p24, %r93, %r144
  p24 = (((int)(r93)) == ((int)(r144)));
  // PTX:332 selp.u16 %rs10, 1, 0, %p24
  rs10 = p24 ? 1 : 0;
  // PTX:334 $L__BB1_27:
L_BB1_27:;
  // PTX:335 setp.eq.s16 %p25, %rs10, 0
  p25 = (((short)(rs10)) == ((short)(0)));
  // PTX:336 @%p25 bra $L__BB1_29
  if (p25) { goto L_BB1_29; }
  // PTX:338 cvt.s64.s32 %rd100, %r150
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd100) : "r"(r150));
  // PTX:339 shl.b64 %rd74, %rd100, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd74) : "l"(rd100));
  // PTX:340 add.s64 %rd75, %rd3, %rd74
  asm("add.s64 %0, %1, %2;" : "=l"(rd75) : "l"(rd3), "l"(rd74));
  // PTX:341 ld.global.u32 %r94, [%rd75]
  r94 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (0)))));
  // PTX:342 setp.eq.s32 %p26, %r94, %r2
  p26 = (((int)(r94)) == ((int)(r2)));
  // PTX:343 setp.eq.s32 %p27, %r94, -1
  p27 = (((int)(r94)) == ((int)(-1)));
  // PTX:344 or.pred %p28, %p26, %p27
  p28 = ((p26) || (p27));
  // PTX:345 @%p28 bra $L__BB1_32
  if (p28) { goto L_BB1_32; }
  // PTX:347 $L__BB1_29:
L_BB1_29:;
  // PTX:348 setp.gt.s32 %p29, %r149, -1
  p29 = (((int)(r149)) > ((int)(-1)));
  // PTX:349 mov.u32 %r150, %r149
  asm("mov.u32 %0, %1;" : "=r"(r150) : "r"(r149));
  // PTX:350 @%p29 bra $L__BB1_24
  if (p29) { goto L_BB1_24; }
  // PTX:352 $L__BB1_30:
L_BB1_30:;
  // PTX:353 setp.eq.s32 %p30, %r146, 27
  p30 = (((int)(r146)) == ((int)(27)));
  // PTX:354 mov.u32 %r150, -1
  asm("mov.u32 %0, -1;" : "=r"(r150) : );
  // PTX:355 @%p30 bra $L__BB1_32
  if (p30) { goto L_BB1_32; }
  // PTX:356 bra.uni $L__BB1_31
  goto L_BB1_31;
  // PTX:358 $L__BB1_32:
L_BB1_32:;
  // PTX:359 setp.gt.s32 %p31, %r150, -1
  p31 = (((int)(r150)) > ((int)(-1)));
  // PTX:360 @%p31 bra $L__BB1_15
  if (p31) { goto L_BB1_15; }
  // PTX:361 bra.uni $L__BB1_33
  goto L_BB1_33;
  // PTX:363 $L__BB1_13:
L_BB1_13:;
  // PTX:364 mov.u32 %r141, 0
  asm("mov.u32 %0, 0;" : "=r"(r141) : );
  // PTX:365 mov.f32 %f118, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f118) : );
  // PTX:366 mov.f32 %f116, %f118
  asm("mov.f32 %0, %1;" : "=f"(f116) : "f"(f118));
  // PTX:367 mov.f32 %f114, %f118
  asm("mov.f32 %0, %1;" : "=f"(f114) : "f"(f118));
  // PTX:368 mov.f32 %f122, %f118
  asm("mov.f32 %0, %1;" : "=f"(f122) : "f"(f118));
  // PTX:370 $L__BB1_33:
L_BB1_33:;
  // PTX:371 ld.param.u64 %rd93, [_ZN7synreal12fluid_kernel13evaluate_rowsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPfS7_PiS8_PNS3_ILi4EfLS4_0EEE_param_2]
  rd93 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:372 cvta.to.global.u64 %rd92, %rd93
  rd92 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd93));
  // PTX:373 ld.param.u64 %rd91, [_ZN7synreal12fluid_kernel13evaluate_rowsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPfS7_PiS8_PNS3_ILi4EfLS4_0EEE_param_1]
  rd91 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:374 cvta.to.global.u64 %rd90, %rd91
  rd90 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd91));
  // PTX:375 mov.u32 %r120, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r120) : "r"(threadIdx.x));
  // PTX:376 mov.u32 %r119, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r119) : "r"(blockDim.x));
  // PTX:377 mov.u32 %r118, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r118) : "r"(blockIdx.x));
  // PTX:378 mad.lo.s32 %r117, %r118, %r119, %r120
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r117) : "r"(r118), "r"(r119), "r"(r120));
  // PTX:379 cvt.s64.s32 %rd25, %r117
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd25) : "r"(r117));
  // PTX:380 mul.wide.s32 %rd78, %r117, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd78) : "r"(r117));
  // PTX:381 add.s64 %rd79, %rd90, %rd78
  asm("add.s64 %0, %1, %2;" : "=l"(rd79) : "l"(rd90), "l"(rd78));
  // PTX:382 st.global.f32 [%rd79], %f118
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (0))))) = (float)(f118);
  // PTX:383 st.global.f32 [%rd79+4], %f116
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (4))))) = (float)(f116);
  // PTX:384 st.global.f32 [%rd79+8], %f114
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (8))))) = (float)(f114);
  // PTX:385 add.f32 %f102, %f122, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f102) : "f"(f122));
  // PTX:386 mov.f32 %f123, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f123) : );
  // PTX:387 max.f32 %f103, %f102, %f123
  asm("max.f32 %0, %1, %2;" : "=f"(f103) : "f"(f102), "f"(f123));
  // PTX:388 mul.wide.s32 %rd80, %r117, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd80) : "r"(r117));
  // PTX:389 add.s64 %rd81, %rd92, %rd80
  asm("add.s64 %0, %1, %2;" : "=l"(rd81) : "l"(rd92), "l"(rd80));
  // PTX:390 st.global.f32 [%rd81], %f103
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (0))))) = (float)(f103);
  // PTX:391 setp.leu.f32 %p32, %f122, 0f3F800000
  p32 = ((isnan(((float)(f122))) || isnan(((float)(as_f32(0x3F800000u))))) || (((float)(f122)) <= ((float)(as_f32(0x3F800000u)))));
  // PTX:392 @%p32 bra $L__BB1_35
  if (p32) { goto L_BB1_35; }
  // PTX:394 ld.global.f32 %f104, [%rd17]
  f104 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:395 mul.f32 %f123, %f50, %f104
  asm("mul.f32 %0, %1, %2;" : "=f"(f123) : "f"(f50), "f"(f104));
  // PTX:397 $L__BB1_35:
L_BB1_35:;
  // PTX:398 ld.param.u64 %rd97, [_ZN7synreal12fluid_kernel13evaluate_rowsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPfS7_PiS8_PNS3_ILi4EfLS4_0EEE_param_4]
  rd97 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:399 cvta.to.global.u64 %rd96, %rd97
  rd96 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd97));
  // PTX:400 ld.param.u64 %rd95, [_ZN7synreal12fluid_kernel13evaluate_rowsENS0_4ViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEEPfS7_PiS8_PNS3_ILi4EfLS4_0EEE_param_3]
  rd95 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:401 cvta.to.global.u64 %rd94, %rd95
  rd94 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd95));
  // PTX:402 shl.b64 %rd82, %rd25, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd82) : "l"(rd25));
  // PTX:403 add.s64 %rd83, %rd94, %rd82
  asm("add.s64 %0, %1, %2;" : "=l"(rd83) : "l"(rd94), "l"(rd82));
  // PTX:404 st.global.f32 [%rd83], %f123
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (0))))) = (float)(f123);
  // PTX:405 add.s64 %rd84, %rd96, %rd82
  asm("add.s64 %0, %1, %2;" : "=l"(rd84) : "l"(rd96), "l"(rd82));
  // PTX:406 st.global.u32 [%rd84], %r141
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (0))))) = (unsigned)(r141);
  // PTX:408 $L__BB1_36:
L_BB1_36:;
  // PTX:409 ret
  return;
}
