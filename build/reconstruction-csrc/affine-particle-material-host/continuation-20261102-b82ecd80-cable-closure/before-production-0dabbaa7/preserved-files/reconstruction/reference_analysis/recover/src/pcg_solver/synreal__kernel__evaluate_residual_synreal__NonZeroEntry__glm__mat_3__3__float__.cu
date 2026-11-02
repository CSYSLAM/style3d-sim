// 机械还原自 PTX：void synreal::kernel::evaluate_residual<synreal::NonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >(int const*, synreal::NonZeroEntry const*, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long)
// PTX SHA256: ca9b9302d8c5214a36a14d49ed88987db5714976dbe6e93c004d1707b9230bda
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__evaluate_residual_synreal__NonZeroEntry__glm__mat_3__3__float__(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121, r122, r123;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83;
  // PTX:26 ld.param.u64 %rd33, [_ZN7synreal6kernel17evaluate_residualINS_12NonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT_mPKT0_PKNS3_3vecILi3EfLS5_0EEESI_SI_PSG_mm_param_0]
  rd33 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:27 ld.param.u64 %rd41, [_ZN7synreal6kernel17evaluate_residualINS_12NonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT_mPKT0_PKNS3_3vecILi3EfLS5_0EEESI_SI_PSG_mm_param_1]
  rd41 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:28 ld.param.u64 %rd34, [_ZN7synreal6kernel17evaluate_residualINS_12NonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT_mPKT0_PKNS3_3vecILi3EfLS5_0EEESI_SI_PSG_mm_param_2]
  rd34 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:29 ld.param.u64 %rd35, [_ZN7synreal6kernel17evaluate_residualINS_12NonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT_mPKT0_PKNS3_3vecILi3EfLS5_0EEESI_SI_PSG_mm_param_3]
  rd35 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:30 ld.param.u64 %rd42, [_ZN7synreal6kernel17evaluate_residualINS_12NonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT_mPKT0_PKNS3_3vecILi3EfLS5_0EEESI_SI_PSG_mm_param_4]
  rd42 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:31 ld.param.u64 %rd39, [_ZN7synreal6kernel17evaluate_residualINS_12NonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT_mPKT0_PKNS3_3vecILi3EfLS5_0EEESI_SI_PSG_mm_param_8]
  rd39 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:32 ld.param.u64 %rd40, [_ZN7synreal6kernel17evaluate_residualINS_12NonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT_mPKT0_PKNS3_3vecILi3EfLS5_0EEESI_SI_PSG_mm_param_9]
  rd40 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:33 cvta.to.global.u64 %rd1, %rd41
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd41));
  // PTX:34 cvta.to.global.u64 %rd2, %rd42
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd42));
  // PTX:35 mov.u32 %r62, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r62) : "r"(blockIdx.x));
  // PTX:36 mov.u32 %r63, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r63) : "r"(blockDim.x));
  // PTX:37 mul.wide.u32 %rd43, %r62, %r63
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd43) : "r"(r62), "r"(r63));
  // PTX:38 mov.u32 %r64, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r64) : "r"(threadIdx.x));
  // PTX:39 cvt.u64.u32 %rd44, %r64
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd44) : "r"(r64));
  // PTX:40 add.s64 %rd3, %rd43, %rd44
  asm("add.s64 %0, %1, %2;" : "=l"(rd3) : "l"(rd43), "l"(rd44));
  // PTX:41 setp.ge.u64 %p1, %rd3, %rd39
  p1 = (((unsigned long long)(rd3)) >= ((unsigned long long)(rd39)));
  // PTX:42 @%p1 bra $L__BB10_31
  if (p1) { goto L_BB10_31; }
  // PTX:44 cvta.to.global.u64 %rd45, %rd35
  rd45 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd35));
  // PTX:45 mul.lo.s64 %rd46, %rd3, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd46) : "l"(rd3));
  // PTX:46 add.s64 %rd47, %rd45, %rd46
  asm("add.s64 %0, %1, %2;" : "=l"(rd47) : "l"(rd45), "l"(rd46));
  // PTX:47 mul.lo.s64 %rd48, %rd3, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd48) : "l"(rd3));
  // PTX:48 add.s64 %rd49, %rd2, %rd48
  asm("add.s64 %0, %1, %2;" : "=l"(rd49) : "l"(rd2), "l"(rd48));
  // PTX:49 ld.global.f32 %f13, [%rd49]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))));
  // PTX:50 ld.global.f32 %f14, [%rd47]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))));
  // PTX:51 ld.global.f32 %f15, [%rd49+4]
  f15 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (4)))));
  // PTX:52 ld.global.f32 %f16, [%rd47+12]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (12)))));
  // PTX:53 mul.f32 %f17, %f16, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f17) : "f"(f16), "f"(f15));
  // PTX:54 fma.rn.f32 %f18, %f14, %f13, %f17
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f18) : "f"(f14), "f"(f13), "f"(f17));
  // PTX:55 ld.global.f32 %f19, [%rd49+8]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (8)))));
  // PTX:56 ld.global.f32 %f20, [%rd47+24]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (24)))));
  // PTX:57 fma.rn.f32 %f1, %f20, %f19, %f18
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1) : "f"(f20), "f"(f19), "f"(f18));
  // PTX:58 ld.global.f32 %f21, [%rd47+4]
  f21 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (4)))));
  // PTX:59 ld.global.f32 %f22, [%rd47+16]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (16)))));
  // PTX:60 mul.f32 %f23, %f22, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f23) : "f"(f22), "f"(f15));
  // PTX:61 fma.rn.f32 %f24, %f21, %f13, %f23
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f24) : "f"(f21), "f"(f13), "f"(f23));
  // PTX:62 ld.global.f32 %f25, [%rd47+28]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (28)))));
  // PTX:63 fma.rn.f32 %f2, %f25, %f19, %f24
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f2) : "f"(f25), "f"(f19), "f"(f24));
  // PTX:64 ld.global.f32 %f26, [%rd47+8]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (8)))));
  // PTX:65 ld.global.f32 %f27, [%rd47+20]
  f27 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (20)))));
  // PTX:66 mul.f32 %f28, %f27, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f28) : "f"(f27), "f"(f15));
  // PTX:67 fma.rn.f32 %f29, %f26, %f13, %f28
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f29) : "f"(f26), "f"(f13), "f"(f28));
  // PTX:68 ld.global.f32 %f30, [%rd47+32]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (32)))));
  // PTX:69 fma.rn.f32 %f3, %f30, %f19, %f29
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f3) : "f"(f30), "f"(f19), "f"(f29));
  // PTX:70 setp.eq.s64 %p2, %rd34, 0
  p2 = (((long long)(rd34)) == ((long long)(0)));
  // PTX:71 mov.u32 %r95, 0
  asm("mov.u32 %0, 0;" : "=r"(r95) : );
  // PTX:72 mov.u32 %r96, %r95
  asm("mov.u32 %0, %1;" : "=r"(r96) : "r"(r95));
  // PTX:73 mov.u32 %r97, %r95
  asm("mov.u32 %0, %1;" : "=r"(r97) : "r"(r95));
  // PTX:74 @%p2 bra $L__BB10_28
  if (p2) { goto L_BB10_28; }
  // PTX:76 setp.eq.s64 %p3, %rd40, 0
  p3 = (((long long)(rd40)) == ((long long)(0)));
  // PTX:77 mov.u64 %rd81, %rd3
  asm("mov.u64 %0, %1;" : "=l"(rd81) : "l"(rd3));
  // PTX:78 @%p3 bra $L__BB10_6
  if (p3) { goto L_BB10_6; }
  // PTX:80 or.b64 %rd50, %rd3, %rd40
  asm("or.b64 %0, %1, %2;" : "=l"(rd50) : "l"(rd3), "l"(rd40));
  // PTX:81 and.b64 %rd51, %rd50, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd51) : "l"(rd50));
  // PTX:82 setp.eq.s64 %p4, %rd51, 0
  p4 = (((long long)(rd51)) == ((long long)(0)));
  // PTX:83 @%p4 bra $L__BB10_5
  if (p4) { goto L_BB10_5; }
  // PTX:85 rem.u64 %rd81, %rd3, %rd40
  asm("rem.u64 %0, %1, %2;" : "=l"(rd81) : "l"(rd3), "l"(rd40));
  // PTX:86 bra.uni $L__BB10_6
  goto L_BB10_6;
  // PTX:88 $L__BB10_5:
L_BB10_5:;
  // PTX:89 cvt.u32.u64 %r68, %rd40
  asm("cvt.u32.u64 %0, %1;" : "=r"(r68) : "l"(rd40));
  // PTX:90 cvt.u32.u64 %r69, %rd3
  asm("cvt.u32.u64 %0, %1;" : "=r"(r69) : "l"(rd3));
  // PTX:91 rem.u32 %r70, %r69, %r68
  asm("rem.u32 %0, %1, %2;" : "=r"(r70) : "r"(r69), "r"(r68));
  // PTX:92 cvt.u64.u32 %rd81, %r70
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd81) : "r"(r70));
  // PTX:94 $L__BB10_6:
L_BB10_6:;
  // PTX:95 sub.s64 %rd7, %rd3, %rd81
  asm("sub.s64 %0, %1, %2;" : "=l"(rd7) : "l"(rd3), "l"(rd81));
  // PTX:96 cvta.to.global.u64 %rd52, %rd33
  rd52 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd33));
  // PTX:97 shl.b64 %rd53, %rd81, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd53) : "l"(rd81));
  // PTX:98 add.s64 %rd54, %rd52, %rd53
  asm("add.s64 %0, %1, %2;" : "=l"(rd54) : "l"(rd52), "l"(rd53));
  // PTX:99 ld.global.u32 %r74, [%rd54]
  r74 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))));
  // PTX:100 mov.u32 %r95, 0
  asm("mov.u32 %0, 0;" : "=r"(r95) : );
  // PTX:101 max.s32 %r75, %r74, 0
  asm("max.s32 %0, %1, 0;" : "=r"(r75) : "r"(r74));
  // PTX:102 cvt.u32.u64 %r76, %rd34
  asm("cvt.u32.u64 %0, %1;" : "=r"(r76) : "l"(rd34));
  // PTX:103 min.s32 %r1, %r75, %r76
  asm("min.s32 %0, %1, %2;" : "=r"(r1) : "r"(r75), "r"(r76));
  // PTX:104 setp.lt.s32 %p5, %r1, 1
  p5 = (((int)(r1)) < ((int)(1)));
  // PTX:105 mov.u32 %r96, %r95
  asm("mov.u32 %0, %1;" : "=r"(r96) : "r"(r95));
  // PTX:106 mov.u32 %r97, %r95
  asm("mov.u32 %0, %1;" : "=r"(r97) : "r"(r95));
  // PTX:107 @%p5 bra $L__BB10_28
  if (p5) { goto L_BB10_28; }
  // PTX:109 add.s32 %r82, %r1, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r82) : "r"(r1));
  // PTX:110 and.b32 %r114, %r1, 3
  asm("and.b32 %0, %1, 3;" : "=r"(r114) : "r"(r1));
  // PTX:111 setp.lt.u32 %p6, %r82, 3
  p6 = (((unsigned)(r82)) < ((unsigned)(3)));
  // PTX:112 mov.u32 %r107, 0
  asm("mov.u32 %0, 0;" : "=r"(r107) : );
  // PTX:113 mov.u32 %r97, %r107
  asm("mov.u32 %0, %1;" : "=r"(r97) : "r"(r107));
  // PTX:114 mov.u32 %r96, %r107
  asm("mov.u32 %0, %1;" : "=r"(r96) : "r"(r107));
  // PTX:115 mov.u32 %r95, %r107
  asm("mov.u32 %0, %1;" : "=r"(r95) : "r"(r107));
  // PTX:116 @%p6 bra $L__BB10_22
  if (p6) { goto L_BB10_22; }
  // PTX:118 sub.s32 %r91, %r1, %r114
  asm("sub.s32 %0, %1, %2;" : "=r"(r91) : "r"(r1), "r"(r114));
  // PTX:119 shl.b64 %rd55, %rd81, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd55) : "l"(rd81));
  // PTX:120 add.s64 %rd82, %rd1, %rd55
  asm("add.s64 %0, %1, %2;" : "=l"(rd82) : "l"(rd1), "l"(rd55));
  // PTX:121 shl.b64 %rd9, %rd40, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd9) : "l"(rd40));
  // PTX:122 mov.u32 %r107, 0
  asm("mov.u32 %0, 0;" : "=r"(r107) : );
  // PTX:124 $L__BB10_9:
L_BB10_9:;
  // PTX:125 ld.global.s32 %rd12, [%rd82]
  rd12 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (0)))));
  // PTX:126 setp.lt.s64 %p7, %rd12, 0
  p7 = (((long long)(rd12)) < ((long long)(0)));
  // PTX:127 setp.ge.u64 %p8, %rd12, %rd40
  p8 = (((unsigned long long)(rd12)) >= ((unsigned long long)(rd40)));
  // PTX:128 or.pred %p9, %p7, %p8
  p9 = ((p7) || (p8));
  // PTX:129 @%p9 bra $L__BB10_12
  if (p9) { goto L_BB10_12; }
  // PTX:131 add.s64 %rd13, %rd7, %rd12
  asm("add.s64 %0, %1, %2;" : "=l"(rd13) : "l"(rd7), "l"(rd12));
  // PTX:132 setp.ge.u64 %p10, %rd13, %rd39
  p10 = (((unsigned long long)(rd13)) >= ((unsigned long long)(rd39)));
  // PTX:133 @%p10 bra $L__BB10_12
  if (p10) { goto L_BB10_12; }
  // PTX:135 ld.global.f32 %f31, [%rd82+4]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (4)))));
  // PTX:136 mul.lo.s64 %rd56, %rd13, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd56) : "l"(rd13));
  // PTX:137 add.s64 %rd57, %rd2, %rd56
  asm("add.s64 %0, %1, %2;" : "=l"(rd57) : "l"(rd2), "l"(rd56));
  // PTX:138 ld.global.f32 %f32, [%rd57]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))));
  // PTX:139 ld.global.f32 %f33, [%rd57+4]
  f33 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (4)))));
  // PTX:140 ld.global.f32 %f34, [%rd57+8]
  f34 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (8)))));
  // PTX:141 mov.b32 %f35, %r95
  asm("mov.b32 %0, %1;" : "=f"(f35) : "r"(r95));
  // PTX:142 fma.rn.f32 %f36, %f31, %f32, %f35
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f36) : "f"(f31), "f"(f32), "f"(f35));
  // PTX:143 mov.b32 %f37, %r96
  asm("mov.b32 %0, %1;" : "=f"(f37) : "r"(r96));
  // PTX:144 fma.rn.f32 %f38, %f31, %f33, %f37
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f38) : "f"(f31), "f"(f33), "f"(f37));
  // PTX:145 mov.b32 %f39, %r97
  asm("mov.b32 %0, %1;" : "=f"(f39) : "r"(r97));
  // PTX:146 fma.rn.f32 %f40, %f31, %f34, %f39
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f40) : "f"(f31), "f"(f34), "f"(f39));
  // PTX:147 mov.b32 %r95, %f36
  asm("mov.b32 %0, %1;" : "=r"(r95) : "f"(f36));
  // PTX:148 mov.b32 %r96, %f38
  asm("mov.b32 %0, %1;" : "=r"(r96) : "f"(f38));
  // PTX:149 mov.b32 %r97, %f40
  asm("mov.b32 %0, %1;" : "=r"(r97) : "f"(f40));
  // PTX:151 $L__BB10_12:
L_BB10_12:;
  // PTX:152 add.s64 %rd15, %rd82, %rd9
  asm("add.s64 %0, %1, %2;" : "=l"(rd15) : "l"(rd82), "l"(rd9));
  // PTX:153 ld.global.s32 %rd16, [%rd15]
  rd16 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))));
  // PTX:154 setp.lt.s64 %p11, %rd16, 0
  p11 = (((long long)(rd16)) < ((long long)(0)));
  // PTX:155 setp.ge.u64 %p12, %rd16, %rd40
  p12 = (((unsigned long long)(rd16)) >= ((unsigned long long)(rd40)));
  // PTX:156 or.pred %p13, %p11, %p12
  p13 = ((p11) || (p12));
  // PTX:157 @%p13 bra $L__BB10_15
  if (p13) { goto L_BB10_15; }
  // PTX:159 add.s64 %rd17, %rd7, %rd16
  asm("add.s64 %0, %1, %2;" : "=l"(rd17) : "l"(rd7), "l"(rd16));
  // PTX:160 setp.ge.u64 %p14, %rd17, %rd39
  p14 = (((unsigned long long)(rd17)) >= ((unsigned long long)(rd39)));
  // PTX:161 @%p14 bra $L__BB10_15
  if (p14) { goto L_BB10_15; }
  // PTX:163 ld.global.f32 %f41, [%rd15+4]
  f41 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (4)))));
  // PTX:164 mul.lo.s64 %rd58, %rd17, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd58) : "l"(rd17));
  // PTX:165 add.s64 %rd59, %rd2, %rd58
  asm("add.s64 %0, %1, %2;" : "=l"(rd59) : "l"(rd2), "l"(rd58));
  // PTX:166 ld.global.f32 %f42, [%rd59]
  f42 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))));
  // PTX:167 ld.global.f32 %f43, [%rd59+4]
  f43 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (4)))));
  // PTX:168 ld.global.f32 %f44, [%rd59+8]
  f44 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (8)))));
  // PTX:169 mov.b32 %f45, %r95
  asm("mov.b32 %0, %1;" : "=f"(f45) : "r"(r95));
  // PTX:170 fma.rn.f32 %f46, %f41, %f42, %f45
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f46) : "f"(f41), "f"(f42), "f"(f45));
  // PTX:171 mov.b32 %f47, %r96
  asm("mov.b32 %0, %1;" : "=f"(f47) : "r"(r96));
  // PTX:172 fma.rn.f32 %f48, %f41, %f43, %f47
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f48) : "f"(f41), "f"(f43), "f"(f47));
  // PTX:173 mov.b32 %f49, %r97
  asm("mov.b32 %0, %1;" : "=f"(f49) : "r"(r97));
  // PTX:174 fma.rn.f32 %f50, %f41, %f44, %f49
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f50) : "f"(f41), "f"(f44), "f"(f49));
  // PTX:175 mov.b32 %r95, %f46
  asm("mov.b32 %0, %1;" : "=r"(r95) : "f"(f46));
  // PTX:176 mov.b32 %r96, %f48
  asm("mov.b32 %0, %1;" : "=r"(r96) : "f"(f48));
  // PTX:177 mov.b32 %r97, %f50
  asm("mov.b32 %0, %1;" : "=r"(r97) : "f"(f50));
  // PTX:179 $L__BB10_15:
L_BB10_15:;
  // PTX:180 add.s64 %rd19, %rd15, %rd9
  asm("add.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd15), "l"(rd9));
  // PTX:181 ld.global.s32 %rd20, [%rd19]
  rd20 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))));
  // PTX:182 setp.lt.s64 %p15, %rd20, 0
  p15 = (((long long)(rd20)) < ((long long)(0)));
  // PTX:183 setp.ge.u64 %p16, %rd20, %rd40
  p16 = (((unsigned long long)(rd20)) >= ((unsigned long long)(rd40)));
  // PTX:184 or.pred %p17, %p15, %p16
  p17 = ((p15) || (p16));
  // PTX:185 @%p17 bra $L__BB10_18
  if (p17) { goto L_BB10_18; }
  // PTX:187 add.s64 %rd21, %rd7, %rd20
  asm("add.s64 %0, %1, %2;" : "=l"(rd21) : "l"(rd7), "l"(rd20));
  // PTX:188 setp.ge.u64 %p18, %rd21, %rd39
  p18 = (((unsigned long long)(rd21)) >= ((unsigned long long)(rd39)));
  // PTX:189 @%p18 bra $L__BB10_18
  if (p18) { goto L_BB10_18; }
  // PTX:191 ld.global.f32 %f51, [%rd19+4]
  f51 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (4)))));
  // PTX:192 mul.lo.s64 %rd60, %rd21, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd60) : "l"(rd21));
  // PTX:193 add.s64 %rd61, %rd2, %rd60
  asm("add.s64 %0, %1, %2;" : "=l"(rd61) : "l"(rd2), "l"(rd60));
  // PTX:194 ld.global.f32 %f52, [%rd61]
  f52 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))));
  // PTX:195 ld.global.f32 %f53, [%rd61+4]
  f53 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (4)))));
  // PTX:196 ld.global.f32 %f54, [%rd61+8]
  f54 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (8)))));
  // PTX:197 mov.b32 %f55, %r95
  asm("mov.b32 %0, %1;" : "=f"(f55) : "r"(r95));
  // PTX:198 fma.rn.f32 %f56, %f51, %f52, %f55
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f56) : "f"(f51), "f"(f52), "f"(f55));
  // PTX:199 mov.b32 %f57, %r96
  asm("mov.b32 %0, %1;" : "=f"(f57) : "r"(r96));
  // PTX:200 fma.rn.f32 %f58, %f51, %f53, %f57
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f58) : "f"(f51), "f"(f53), "f"(f57));
  // PTX:201 mov.b32 %f59, %r97
  asm("mov.b32 %0, %1;" : "=f"(f59) : "r"(r97));
  // PTX:202 fma.rn.f32 %f60, %f51, %f54, %f59
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f60) : "f"(f51), "f"(f54), "f"(f59));
  // PTX:203 mov.b32 %r95, %f56
  asm("mov.b32 %0, %1;" : "=r"(r95) : "f"(f56));
  // PTX:204 mov.b32 %r96, %f58
  asm("mov.b32 %0, %1;" : "=r"(r96) : "f"(f58));
  // PTX:205 mov.b32 %r97, %f60
  asm("mov.b32 %0, %1;" : "=r"(r97) : "f"(f60));
  // PTX:207 $L__BB10_18:
L_BB10_18:;
  // PTX:208 add.s64 %rd23, %rd19, %rd9
  asm("add.s64 %0, %1, %2;" : "=l"(rd23) : "l"(rd19), "l"(rd9));
  // PTX:209 ld.global.s32 %rd24, [%rd23]
  rd24 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (0)))));
  // PTX:210 setp.lt.s64 %p19, %rd24, 0
  p19 = (((long long)(rd24)) < ((long long)(0)));
  // PTX:211 setp.ge.u64 %p20, %rd24, %rd40
  p20 = (((unsigned long long)(rd24)) >= ((unsigned long long)(rd40)));
  // PTX:212 or.pred %p21, %p19, %p20
  p21 = ((p19) || (p20));
  // PTX:213 @%p21 bra $L__BB10_21
  if (p21) { goto L_BB10_21; }
  // PTX:215 add.s64 %rd25, %rd7, %rd24
  asm("add.s64 %0, %1, %2;" : "=l"(rd25) : "l"(rd7), "l"(rd24));
  // PTX:216 setp.ge.u64 %p22, %rd25, %rd39
  p22 = (((unsigned long long)(rd25)) >= ((unsigned long long)(rd39)));
  // PTX:217 @%p22 bra $L__BB10_21
  if (p22) { goto L_BB10_21; }
  // PTX:219 ld.global.f32 %f61, [%rd23+4]
  f61 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (4)))));
  // PTX:220 mul.lo.s64 %rd62, %rd25, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd62) : "l"(rd25));
  // PTX:221 add.s64 %rd63, %rd2, %rd62
  asm("add.s64 %0, %1, %2;" : "=l"(rd63) : "l"(rd2), "l"(rd62));
  // PTX:222 ld.global.f32 %f62, [%rd63]
  f62 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (0)))));
  // PTX:223 ld.global.f32 %f63, [%rd63+4]
  f63 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (4)))));
  // PTX:224 ld.global.f32 %f64, [%rd63+8]
  f64 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (8)))));
  // PTX:225 mov.b32 %f65, %r95
  asm("mov.b32 %0, %1;" : "=f"(f65) : "r"(r95));
  // PTX:226 fma.rn.f32 %f66, %f61, %f62, %f65
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f66) : "f"(f61), "f"(f62), "f"(f65));
  // PTX:227 mov.b32 %f67, %r96
  asm("mov.b32 %0, %1;" : "=f"(f67) : "r"(r96));
  // PTX:228 fma.rn.f32 %f68, %f61, %f63, %f67
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f68) : "f"(f61), "f"(f63), "f"(f67));
  // PTX:229 mov.b32 %f69, %r97
  asm("mov.b32 %0, %1;" : "=f"(f69) : "r"(r97));
  // PTX:230 fma.rn.f32 %f70, %f61, %f64, %f69
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f70) : "f"(f61), "f"(f64), "f"(f69));
  // PTX:231 mov.b32 %r95, %f66
  asm("mov.b32 %0, %1;" : "=r"(r95) : "f"(f66));
  // PTX:232 mov.b32 %r96, %f68
  asm("mov.b32 %0, %1;" : "=r"(r96) : "f"(f68));
  // PTX:233 mov.b32 %r97, %f70
  asm("mov.b32 %0, %1;" : "=r"(r97) : "f"(f70));
  // PTX:235 $L__BB10_21:
L_BB10_21:;
  // PTX:236 add.s64 %rd82, %rd23, %rd9
  asm("add.s64 %0, %1, %2;" : "=l"(rd82) : "l"(rd23), "l"(rd9));
  // PTX:237 add.s32 %r107, %r107, 4
  asm("add.s32 %0, %1, 4;" : "=r"(r107) : "r"(r107));
  // PTX:238 add.s32 %r91, %r91, -4
  asm("add.s32 %0, %1, -4;" : "=r"(r91) : "r"(r91));
  // PTX:239 setp.ne.s32 %p23, %r91, 0
  p23 = (((int)(r91)) != ((int)(0)));
  // PTX:240 @%p23 bra $L__BB10_9
  if (p23) { goto L_BB10_9; }
  // PTX:242 $L__BB10_22:
L_BB10_22:;
  // PTX:243 setp.eq.s32 %p24, %r114, 0
  p24 = (((int)(r114)) == ((int)(0)));
  // PTX:244 @%p24 bra $L__BB10_28
  if (p24) { goto L_BB10_28; }
  // PTX:246 cvt.s64.s32 %rd83, %r107
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd83) : "r"(r107));
  // PTX:248 $L__BB10_24:
L_BB10_24:;
  // PTX:250 mul.lo.s64 %rd64, %rd83, %rd40
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd64) : "l"(rd83), "l"(rd40));
  // PTX:251 add.s64 %rd65, %rd64, %rd81
  asm("add.s64 %0, %1, %2;" : "=l"(rd65) : "l"(rd64), "l"(rd81));
  // PTX:252 shl.b64 %rd66, %rd65, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd66) : "l"(rd65));
  // PTX:253 add.s64 %rd29, %rd1, %rd66
  asm("add.s64 %0, %1, %2;" : "=l"(rd29) : "l"(rd1), "l"(rd66));
  // PTX:254 ld.global.s32 %rd30, [%rd29]
  rd30 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (0)))));
  // PTX:255 setp.lt.s64 %p25, %rd30, 0
  p25 = (((long long)(rd30)) < ((long long)(0)));
  // PTX:256 setp.ge.u64 %p26, %rd30, %rd40
  p26 = (((unsigned long long)(rd30)) >= ((unsigned long long)(rd40)));
  // PTX:257 or.pred %p27, %p25, %p26
  p27 = ((p25) || (p26));
  // PTX:258 @%p27 bra $L__BB10_27
  if (p27) { goto L_BB10_27; }
  // PTX:260 add.s64 %rd31, %rd7, %rd30
  asm("add.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd7), "l"(rd30));
  // PTX:261 setp.ge.u64 %p28, %rd31, %rd39
  p28 = (((unsigned long long)(rd31)) >= ((unsigned long long)(rd39)));
  // PTX:262 @%p28 bra $L__BB10_27
  if (p28) { goto L_BB10_27; }
  // PTX:264 ld.global.f32 %f71, [%rd29+4]
  f71 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (4)))));
  // PTX:265 mul.lo.s64 %rd67, %rd31, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd67) : "l"(rd31));
  // PTX:266 add.s64 %rd68, %rd2, %rd67
  asm("add.s64 %0, %1, %2;" : "=l"(rd68) : "l"(rd2), "l"(rd67));
  // PTX:267 ld.global.f32 %f72, [%rd68]
  f72 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (0)))));
  // PTX:268 ld.global.f32 %f73, [%rd68+4]
  f73 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (4)))));
  // PTX:269 ld.global.f32 %f74, [%rd68+8]
  f74 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (8)))));
  // PTX:270 mov.b32 %f75, %r95
  asm("mov.b32 %0, %1;" : "=f"(f75) : "r"(r95));
  // PTX:271 fma.rn.f32 %f76, %f71, %f72, %f75
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f76) : "f"(f71), "f"(f72), "f"(f75));
  // PTX:272 mov.b32 %f77, %r96
  asm("mov.b32 %0, %1;" : "=f"(f77) : "r"(r96));
  // PTX:273 fma.rn.f32 %f78, %f71, %f73, %f77
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f78) : "f"(f71), "f"(f73), "f"(f77));
  // PTX:274 mov.b32 %f79, %r97
  asm("mov.b32 %0, %1;" : "=f"(f79) : "r"(r97));
  // PTX:275 fma.rn.f32 %f80, %f71, %f74, %f79
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f80) : "f"(f71), "f"(f74), "f"(f79));
  // PTX:276 mov.b32 %r95, %f76
  asm("mov.b32 %0, %1;" : "=r"(r95) : "f"(f76));
  // PTX:277 mov.b32 %r96, %f78
  asm("mov.b32 %0, %1;" : "=r"(r96) : "f"(f78));
  // PTX:278 mov.b32 %r97, %f80
  asm("mov.b32 %0, %1;" : "=r"(r97) : "f"(f80));
  // PTX:280 $L__BB10_27:
L_BB10_27:;
  // PTX:281 add.s64 %rd83, %rd83, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd83) : "l"(rd83));
  // PTX:282 add.s32 %r114, %r114, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r114) : "r"(r114));
  // PTX:283 setp.ne.s32 %p29, %r114, 0
  p29 = (((int)(r114)) != ((int)(0)));
  // PTX:284 @%p29 bra $L__BB10_24
  if (p29) { goto L_BB10_24; }
  // PTX:286 $L__BB10_28:
L_BB10_28:;
  // PTX:287 ld.param.u64 %rd79, [_ZN7synreal6kernel17evaluate_residualINS_12NonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT_mPKT0_PKNS3_3vecILi3EfLS5_0EEESI_SI_PSG_mm_param_6]
  rd79 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:288 mov.b32 %f81, %r95
  asm("mov.b32 %0, %1;" : "=f"(f81) : "r"(r95));
  // PTX:289 add.f32 %f95, %f1, %f81
  asm("add.f32 %0, %1, %2;" : "=f"(f95) : "f"(f1), "f"(f81));
  // PTX:290 mov.b32 %f82, %r96
  asm("mov.b32 %0, %1;" : "=f"(f82) : "r"(r96));
  // PTX:291 add.f32 %f94, %f2, %f82
  asm("add.f32 %0, %1, %2;" : "=f"(f94) : "f"(f2), "f"(f82));
  // PTX:292 mov.b32 %f83, %r97
  asm("mov.b32 %0, %1;" : "=f"(f83) : "r"(r97));
  // PTX:293 add.f32 %f93, %f3, %f83
  asm("add.f32 %0, %1, %2;" : "=f"(f93) : "f"(f3), "f"(f83));
  // PTX:294 setp.eq.s64 %p30, %rd79, 0
  p30 = (((long long)(rd79)) == ((long long)(0)));
  // PTX:295 @%p30 bra $L__BB10_30
  if (p30) { goto L_BB10_30; }
  // PTX:297 ld.param.u64 %rd80, [_ZN7synreal6kernel17evaluate_residualINS_12NonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT_mPKT0_PKNS3_3vecILi3EfLS5_0EEESI_SI_PSG_mm_param_6]
  rd80 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:298 cvta.to.global.u64 %rd69, %rd80
  rd69 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd80));
  // PTX:299 add.s64 %rd71, %rd69, %rd48
  asm("add.s64 %0, %1, %2;" : "=l"(rd71) : "l"(rd69), "l"(rd48));
  // PTX:300 ld.global.f32 %f84, [%rd71]
  f84 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))));
  // PTX:301 add.f32 %f95, %f95, %f84
  asm("add.f32 %0, %1, %2;" : "=f"(f95) : "f"(f95), "f"(f84));
  // PTX:302 ld.global.f32 %f85, [%rd71+4]
  f85 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (4)))));
  // PTX:303 add.f32 %f94, %f94, %f85
  asm("add.f32 %0, %1, %2;" : "=f"(f94) : "f"(f94), "f"(f85));
  // PTX:304 ld.global.f32 %f86, [%rd71+8]
  f86 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (8)))));
  // PTX:305 add.f32 %f93, %f93, %f86
  asm("add.f32 %0, %1, %2;" : "=f"(f93) : "f"(f93), "f"(f86));
  // PTX:307 $L__BB10_30:
L_BB10_30:;
  // PTX:308 ld.param.u64 %rd78, [_ZN7synreal6kernel17evaluate_residualINS_12NonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT_mPKT0_PKNS3_3vecILi3EfLS5_0EEESI_SI_PSG_mm_param_7]
  rd78 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:309 ld.param.u64 %rd77, [_ZN7synreal6kernel17evaluate_residualINS_12NonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT_mPKT0_PKNS3_3vecILi3EfLS5_0EEESI_SI_PSG_mm_param_5]
  rd77 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:310 cvta.to.global.u64 %rd72, %rd77
  rd72 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd77));
  // PTX:311 add.s64 %rd74, %rd72, %rd48
  asm("add.s64 %0, %1, %2;" : "=l"(rd74) : "l"(rd72), "l"(rd48));
  // PTX:312 ld.global.f32 %f87, [%rd74]
  f87 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (0)))));
  // PTX:313 sub.f32 %f88, %f87, %f95
  asm("sub.f32 %0, %1, %2;" : "=f"(f88) : "f"(f87), "f"(f95));
  // PTX:314 ld.global.f32 %f89, [%rd74+4]
  f89 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (4)))));
  // PTX:315 sub.f32 %f90, %f89, %f94
  asm("sub.f32 %0, %1, %2;" : "=f"(f90) : "f"(f89), "f"(f94));
  // PTX:316 ld.global.f32 %f91, [%rd74+8]
  f91 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (8)))));
  // PTX:317 sub.f32 %f92, %f91, %f93
  asm("sub.f32 %0, %1, %2;" : "=f"(f92) : "f"(f91), "f"(f93));
  // PTX:318 cvta.to.global.u64 %rd75, %rd78
  rd75 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd78));
  // PTX:319 add.s64 %rd76, %rd75, %rd48
  asm("add.s64 %0, %1, %2;" : "=l"(rd76) : "l"(rd75), "l"(rd48));
  // PTX:320 st.global.f32 [%rd76], %f88
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (0))))) = (float)(f88);
  // PTX:321 st.global.f32 [%rd76+4], %f90
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (4))))) = (float)(f90);
  // PTX:322 st.global.f32 [%rd76+8], %f92
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (8))))) = (float)(f92);
  // PTX:324 $L__BB10_31:
L_BB10_31:;
  // PTX:325 ret
  return;
}
