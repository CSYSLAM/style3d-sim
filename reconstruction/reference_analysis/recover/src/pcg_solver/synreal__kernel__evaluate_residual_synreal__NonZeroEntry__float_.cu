// 机械还原自 PTX：void synreal::kernel::evaluate_residual<synreal::NonZeroEntry, float>(int const*, synreal::NonZeroEntry const*, unsigned long, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long)
// PTX SHA256: 90553f09df5f3f9f19379d1137cff19f9e4ac6d2ad3e4c8c14a16bd97e59b5d3
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__evaluate_residual_synreal__NonZeroEntry__float_(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121, r122, r123;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83;
  // PTX:26 ld.param.u64 %rd33, [_ZN7synreal6kernel17evaluate_residualINS_12NonZeroEntryEfEEvPKiPKT_mPKT0_PKN3glm3vecILi3EfLNSB_9qualifierE0EEESG_SG_PSE_mm_param_0]
  rd33 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:27 ld.param.u64 %rd41, [_ZN7synreal6kernel17evaluate_residualINS_12NonZeroEntryEfEEvPKiPKT_mPKT0_PKN3glm3vecILi3EfLNSB_9qualifierE0EEESG_SG_PSE_mm_param_1]
  rd41 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:28 ld.param.u64 %rd34, [_ZN7synreal6kernel17evaluate_residualINS_12NonZeroEntryEfEEvPKiPKT_mPKT0_PKN3glm3vecILi3EfLNSB_9qualifierE0EEESG_SG_PSE_mm_param_2]
  rd34 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:29 ld.param.u64 %rd35, [_ZN7synreal6kernel17evaluate_residualINS_12NonZeroEntryEfEEvPKiPKT_mPKT0_PKN3glm3vecILi3EfLNSB_9qualifierE0EEESG_SG_PSE_mm_param_3]
  rd35 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:30 ld.param.u64 %rd42, [_ZN7synreal6kernel17evaluate_residualINS_12NonZeroEntryEfEEvPKiPKT_mPKT0_PKN3glm3vecILi3EfLNSB_9qualifierE0EEESG_SG_PSE_mm_param_4]
  rd42 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:31 ld.param.u64 %rd39, [_ZN7synreal6kernel17evaluate_residualINS_12NonZeroEntryEfEEvPKiPKT_mPKT0_PKN3glm3vecILi3EfLNSB_9qualifierE0EEESG_SG_PSE_mm_param_8]
  rd39 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:32 ld.param.u64 %rd40, [_ZN7synreal6kernel17evaluate_residualINS_12NonZeroEntryEfEEvPKiPKT_mPKT0_PKN3glm3vecILi3EfLNSB_9qualifierE0EEESG_SG_PSE_mm_param_9]
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
  // PTX:42 @%p1 bra $L__BB2_31
  if (p1) { goto L_BB2_31; }
  // PTX:44 cvta.to.global.u64 %rd45, %rd35
  rd45 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd35));
  // PTX:45 shl.b64 %rd46, %rd3, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd46) : "l"(rd3));
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
  // PTX:51 mul.f32 %f1, %f14, %f13
  asm("mul.f32 %0, %1, %2;" : "=f"(f1) : "f"(f14), "f"(f13));
  // PTX:52 ld.global.f32 %f15, [%rd49+4]
  f15 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (4)))));
  // PTX:53 mul.f32 %f2, %f14, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f2) : "f"(f14), "f"(f15));
  // PTX:54 ld.global.f32 %f16, [%rd49+8]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (8)))));
  // PTX:55 mul.f32 %f3, %f14, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f3) : "f"(f14), "f"(f16));
  // PTX:56 setp.eq.s64 %p2, %rd34, 0
  p2 = (((long long)(rd34)) == ((long long)(0)));
  // PTX:57 mov.u32 %r95, 0
  asm("mov.u32 %0, 0;" : "=r"(r95) : );
  // PTX:58 mov.u32 %r96, %r95
  asm("mov.u32 %0, %1;" : "=r"(r96) : "r"(r95));
  // PTX:59 mov.u32 %r97, %r95
  asm("mov.u32 %0, %1;" : "=r"(r97) : "r"(r95));
  // PTX:60 @%p2 bra $L__BB2_28
  if (p2) { goto L_BB2_28; }
  // PTX:62 setp.eq.s64 %p3, %rd40, 0
  p3 = (((long long)(rd40)) == ((long long)(0)));
  // PTX:63 mov.u64 %rd81, %rd3
  asm("mov.u64 %0, %1;" : "=l"(rd81) : "l"(rd3));
  // PTX:64 @%p3 bra $L__BB2_6
  if (p3) { goto L_BB2_6; }
  // PTX:66 or.b64 %rd50, %rd3, %rd40
  asm("or.b64 %0, %1, %2;" : "=l"(rd50) : "l"(rd3), "l"(rd40));
  // PTX:67 and.b64 %rd51, %rd50, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd51) : "l"(rd50));
  // PTX:68 setp.eq.s64 %p4, %rd51, 0
  p4 = (((long long)(rd51)) == ((long long)(0)));
  // PTX:69 @%p4 bra $L__BB2_5
  if (p4) { goto L_BB2_5; }
  // PTX:71 rem.u64 %rd81, %rd3, %rd40
  asm("rem.u64 %0, %1, %2;" : "=l"(rd81) : "l"(rd3), "l"(rd40));
  // PTX:72 bra.uni $L__BB2_6
  goto L_BB2_6;
  // PTX:74 $L__BB2_5:
L_BB2_5:;
  // PTX:75 cvt.u32.u64 %r68, %rd40
  asm("cvt.u32.u64 %0, %1;" : "=r"(r68) : "l"(rd40));
  // PTX:76 cvt.u32.u64 %r69, %rd3
  asm("cvt.u32.u64 %0, %1;" : "=r"(r69) : "l"(rd3));
  // PTX:77 rem.u32 %r70, %r69, %r68
  asm("rem.u32 %0, %1, %2;" : "=r"(r70) : "r"(r69), "r"(r68));
  // PTX:78 cvt.u64.u32 %rd81, %r70
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd81) : "r"(r70));
  // PTX:80 $L__BB2_6:
L_BB2_6:;
  // PTX:81 sub.s64 %rd7, %rd3, %rd81
  asm("sub.s64 %0, %1, %2;" : "=l"(rd7) : "l"(rd3), "l"(rd81));
  // PTX:82 cvta.to.global.u64 %rd52, %rd33
  rd52 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd33));
  // PTX:83 shl.b64 %rd53, %rd81, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd53) : "l"(rd81));
  // PTX:84 add.s64 %rd54, %rd52, %rd53
  asm("add.s64 %0, %1, %2;" : "=l"(rd54) : "l"(rd52), "l"(rd53));
  // PTX:85 ld.global.u32 %r74, [%rd54]
  r74 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))));
  // PTX:86 mov.u32 %r95, 0
  asm("mov.u32 %0, 0;" : "=r"(r95) : );
  // PTX:87 max.s32 %r75, %r74, 0
  asm("max.s32 %0, %1, 0;" : "=r"(r75) : "r"(r74));
  // PTX:88 cvt.u32.u64 %r76, %rd34
  asm("cvt.u32.u64 %0, %1;" : "=r"(r76) : "l"(rd34));
  // PTX:89 min.s32 %r1, %r75, %r76
  asm("min.s32 %0, %1, %2;" : "=r"(r1) : "r"(r75), "r"(r76));
  // PTX:90 setp.lt.s32 %p5, %r1, 1
  p5 = (((int)(r1)) < ((int)(1)));
  // PTX:91 mov.u32 %r96, %r95
  asm("mov.u32 %0, %1;" : "=r"(r96) : "r"(r95));
  // PTX:92 mov.u32 %r97, %r95
  asm("mov.u32 %0, %1;" : "=r"(r97) : "r"(r95));
  // PTX:93 @%p5 bra $L__BB2_28
  if (p5) { goto L_BB2_28; }
  // PTX:95 add.s32 %r82, %r1, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r82) : "r"(r1));
  // PTX:96 and.b32 %r114, %r1, 3
  asm("and.b32 %0, %1, 3;" : "=r"(r114) : "r"(r1));
  // PTX:97 setp.lt.u32 %p6, %r82, 3
  p6 = (((unsigned)(r82)) < ((unsigned)(3)));
  // PTX:98 mov.u32 %r107, 0
  asm("mov.u32 %0, 0;" : "=r"(r107) : );
  // PTX:99 mov.u32 %r97, %r107
  asm("mov.u32 %0, %1;" : "=r"(r97) : "r"(r107));
  // PTX:100 mov.u32 %r96, %r107
  asm("mov.u32 %0, %1;" : "=r"(r96) : "r"(r107));
  // PTX:101 mov.u32 %r95, %r107
  asm("mov.u32 %0, %1;" : "=r"(r95) : "r"(r107));
  // PTX:102 @%p6 bra $L__BB2_22
  if (p6) { goto L_BB2_22; }
  // PTX:104 sub.s32 %r91, %r1, %r114
  asm("sub.s32 %0, %1, %2;" : "=r"(r91) : "r"(r1), "r"(r114));
  // PTX:105 shl.b64 %rd55, %rd81, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd55) : "l"(rd81));
  // PTX:106 add.s64 %rd82, %rd1, %rd55
  asm("add.s64 %0, %1, %2;" : "=l"(rd82) : "l"(rd1), "l"(rd55));
  // PTX:107 shl.b64 %rd9, %rd40, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd9) : "l"(rd40));
  // PTX:108 mov.u32 %r107, 0
  asm("mov.u32 %0, 0;" : "=r"(r107) : );
  // PTX:110 $L__BB2_9:
L_BB2_9:;
  // PTX:111 ld.global.s32 %rd12, [%rd82]
  rd12 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (0)))));
  // PTX:112 setp.lt.s64 %p7, %rd12, 0
  p7 = (((long long)(rd12)) < ((long long)(0)));
  // PTX:113 setp.ge.u64 %p8, %rd12, %rd40
  p8 = (((unsigned long long)(rd12)) >= ((unsigned long long)(rd40)));
  // PTX:114 or.pred %p9, %p7, %p8
  p9 = ((p7) || (p8));
  // PTX:115 @%p9 bra $L__BB2_12
  if (p9) { goto L_BB2_12; }
  // PTX:117 add.s64 %rd13, %rd7, %rd12
  asm("add.s64 %0, %1, %2;" : "=l"(rd13) : "l"(rd7), "l"(rd12));
  // PTX:118 setp.ge.u64 %p10, %rd13, %rd39
  p10 = (((unsigned long long)(rd13)) >= ((unsigned long long)(rd39)));
  // PTX:119 @%p10 bra $L__BB2_12
  if (p10) { goto L_BB2_12; }
  // PTX:121 ld.global.f32 %f17, [%rd82+4]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (4)))));
  // PTX:122 mul.lo.s64 %rd56, %rd13, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd56) : "l"(rd13));
  // PTX:123 add.s64 %rd57, %rd2, %rd56
  asm("add.s64 %0, %1, %2;" : "=l"(rd57) : "l"(rd2), "l"(rd56));
  // PTX:124 ld.global.f32 %f18, [%rd57]
  f18 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))));
  // PTX:125 ld.global.f32 %f19, [%rd57+4]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (4)))));
  // PTX:126 ld.global.f32 %f20, [%rd57+8]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (8)))));
  // PTX:127 mov.b32 %f21, %r95
  asm("mov.b32 %0, %1;" : "=f"(f21) : "r"(r95));
  // PTX:128 fma.rn.f32 %f22, %f17, %f18, %f21
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f22) : "f"(f17), "f"(f18), "f"(f21));
  // PTX:129 mov.b32 %f23, %r96
  asm("mov.b32 %0, %1;" : "=f"(f23) : "r"(r96));
  // PTX:130 fma.rn.f32 %f24, %f17, %f19, %f23
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f24) : "f"(f17), "f"(f19), "f"(f23));
  // PTX:131 mov.b32 %f25, %r97
  asm("mov.b32 %0, %1;" : "=f"(f25) : "r"(r97));
  // PTX:132 fma.rn.f32 %f26, %f17, %f20, %f25
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f26) : "f"(f17), "f"(f20), "f"(f25));
  // PTX:133 mov.b32 %r95, %f22
  asm("mov.b32 %0, %1;" : "=r"(r95) : "f"(f22));
  // PTX:134 mov.b32 %r96, %f24
  asm("mov.b32 %0, %1;" : "=r"(r96) : "f"(f24));
  // PTX:135 mov.b32 %r97, %f26
  asm("mov.b32 %0, %1;" : "=r"(r97) : "f"(f26));
  // PTX:137 $L__BB2_12:
L_BB2_12:;
  // PTX:138 add.s64 %rd15, %rd82, %rd9
  asm("add.s64 %0, %1, %2;" : "=l"(rd15) : "l"(rd82), "l"(rd9));
  // PTX:139 ld.global.s32 %rd16, [%rd15]
  rd16 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))));
  // PTX:140 setp.lt.s64 %p11, %rd16, 0
  p11 = (((long long)(rd16)) < ((long long)(0)));
  // PTX:141 setp.ge.u64 %p12, %rd16, %rd40
  p12 = (((unsigned long long)(rd16)) >= ((unsigned long long)(rd40)));
  // PTX:142 or.pred %p13, %p11, %p12
  p13 = ((p11) || (p12));
  // PTX:143 @%p13 bra $L__BB2_15
  if (p13) { goto L_BB2_15; }
  // PTX:145 add.s64 %rd17, %rd7, %rd16
  asm("add.s64 %0, %1, %2;" : "=l"(rd17) : "l"(rd7), "l"(rd16));
  // PTX:146 setp.ge.u64 %p14, %rd17, %rd39
  p14 = (((unsigned long long)(rd17)) >= ((unsigned long long)(rd39)));
  // PTX:147 @%p14 bra $L__BB2_15
  if (p14) { goto L_BB2_15; }
  // PTX:149 ld.global.f32 %f27, [%rd15+4]
  f27 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (4)))));
  // PTX:150 mul.lo.s64 %rd58, %rd17, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd58) : "l"(rd17));
  // PTX:151 add.s64 %rd59, %rd2, %rd58
  asm("add.s64 %0, %1, %2;" : "=l"(rd59) : "l"(rd2), "l"(rd58));
  // PTX:152 ld.global.f32 %f28, [%rd59]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))));
  // PTX:153 ld.global.f32 %f29, [%rd59+4]
  f29 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (4)))));
  // PTX:154 ld.global.f32 %f30, [%rd59+8]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (8)))));
  // PTX:155 mov.b32 %f31, %r95
  asm("mov.b32 %0, %1;" : "=f"(f31) : "r"(r95));
  // PTX:156 fma.rn.f32 %f32, %f27, %f28, %f31
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f32) : "f"(f27), "f"(f28), "f"(f31));
  // PTX:157 mov.b32 %f33, %r96
  asm("mov.b32 %0, %1;" : "=f"(f33) : "r"(r96));
  // PTX:158 fma.rn.f32 %f34, %f27, %f29, %f33
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f34) : "f"(f27), "f"(f29), "f"(f33));
  // PTX:159 mov.b32 %f35, %r97
  asm("mov.b32 %0, %1;" : "=f"(f35) : "r"(r97));
  // PTX:160 fma.rn.f32 %f36, %f27, %f30, %f35
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f36) : "f"(f27), "f"(f30), "f"(f35));
  // PTX:161 mov.b32 %r95, %f32
  asm("mov.b32 %0, %1;" : "=r"(r95) : "f"(f32));
  // PTX:162 mov.b32 %r96, %f34
  asm("mov.b32 %0, %1;" : "=r"(r96) : "f"(f34));
  // PTX:163 mov.b32 %r97, %f36
  asm("mov.b32 %0, %1;" : "=r"(r97) : "f"(f36));
  // PTX:165 $L__BB2_15:
L_BB2_15:;
  // PTX:166 add.s64 %rd19, %rd15, %rd9
  asm("add.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd15), "l"(rd9));
  // PTX:167 ld.global.s32 %rd20, [%rd19]
  rd20 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))));
  // PTX:168 setp.lt.s64 %p15, %rd20, 0
  p15 = (((long long)(rd20)) < ((long long)(0)));
  // PTX:169 setp.ge.u64 %p16, %rd20, %rd40
  p16 = (((unsigned long long)(rd20)) >= ((unsigned long long)(rd40)));
  // PTX:170 or.pred %p17, %p15, %p16
  p17 = ((p15) || (p16));
  // PTX:171 @%p17 bra $L__BB2_18
  if (p17) { goto L_BB2_18; }
  // PTX:173 add.s64 %rd21, %rd7, %rd20
  asm("add.s64 %0, %1, %2;" : "=l"(rd21) : "l"(rd7), "l"(rd20));
  // PTX:174 setp.ge.u64 %p18, %rd21, %rd39
  p18 = (((unsigned long long)(rd21)) >= ((unsigned long long)(rd39)));
  // PTX:175 @%p18 bra $L__BB2_18
  if (p18) { goto L_BB2_18; }
  // PTX:177 ld.global.f32 %f37, [%rd19+4]
  f37 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (4)))));
  // PTX:178 mul.lo.s64 %rd60, %rd21, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd60) : "l"(rd21));
  // PTX:179 add.s64 %rd61, %rd2, %rd60
  asm("add.s64 %0, %1, %2;" : "=l"(rd61) : "l"(rd2), "l"(rd60));
  // PTX:180 ld.global.f32 %f38, [%rd61]
  f38 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))));
  // PTX:181 ld.global.f32 %f39, [%rd61+4]
  f39 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (4)))));
  // PTX:182 ld.global.f32 %f40, [%rd61+8]
  f40 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (8)))));
  // PTX:183 mov.b32 %f41, %r95
  asm("mov.b32 %0, %1;" : "=f"(f41) : "r"(r95));
  // PTX:184 fma.rn.f32 %f42, %f37, %f38, %f41
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f42) : "f"(f37), "f"(f38), "f"(f41));
  // PTX:185 mov.b32 %f43, %r96
  asm("mov.b32 %0, %1;" : "=f"(f43) : "r"(r96));
  // PTX:186 fma.rn.f32 %f44, %f37, %f39, %f43
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f44) : "f"(f37), "f"(f39), "f"(f43));
  // PTX:187 mov.b32 %f45, %r97
  asm("mov.b32 %0, %1;" : "=f"(f45) : "r"(r97));
  // PTX:188 fma.rn.f32 %f46, %f37, %f40, %f45
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f46) : "f"(f37), "f"(f40), "f"(f45));
  // PTX:189 mov.b32 %r95, %f42
  asm("mov.b32 %0, %1;" : "=r"(r95) : "f"(f42));
  // PTX:190 mov.b32 %r96, %f44
  asm("mov.b32 %0, %1;" : "=r"(r96) : "f"(f44));
  // PTX:191 mov.b32 %r97, %f46
  asm("mov.b32 %0, %1;" : "=r"(r97) : "f"(f46));
  // PTX:193 $L__BB2_18:
L_BB2_18:;
  // PTX:194 add.s64 %rd23, %rd19, %rd9
  asm("add.s64 %0, %1, %2;" : "=l"(rd23) : "l"(rd19), "l"(rd9));
  // PTX:195 ld.global.s32 %rd24, [%rd23]
  rd24 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (0)))));
  // PTX:196 setp.lt.s64 %p19, %rd24, 0
  p19 = (((long long)(rd24)) < ((long long)(0)));
  // PTX:197 setp.ge.u64 %p20, %rd24, %rd40
  p20 = (((unsigned long long)(rd24)) >= ((unsigned long long)(rd40)));
  // PTX:198 or.pred %p21, %p19, %p20
  p21 = ((p19) || (p20));
  // PTX:199 @%p21 bra $L__BB2_21
  if (p21) { goto L_BB2_21; }
  // PTX:201 add.s64 %rd25, %rd7, %rd24
  asm("add.s64 %0, %1, %2;" : "=l"(rd25) : "l"(rd7), "l"(rd24));
  // PTX:202 setp.ge.u64 %p22, %rd25, %rd39
  p22 = (((unsigned long long)(rd25)) >= ((unsigned long long)(rd39)));
  // PTX:203 @%p22 bra $L__BB2_21
  if (p22) { goto L_BB2_21; }
  // PTX:205 ld.global.f32 %f47, [%rd23+4]
  f47 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (4)))));
  // PTX:206 mul.lo.s64 %rd62, %rd25, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd62) : "l"(rd25));
  // PTX:207 add.s64 %rd63, %rd2, %rd62
  asm("add.s64 %0, %1, %2;" : "=l"(rd63) : "l"(rd2), "l"(rd62));
  // PTX:208 ld.global.f32 %f48, [%rd63]
  f48 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (0)))));
  // PTX:209 ld.global.f32 %f49, [%rd63+4]
  f49 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (4)))));
  // PTX:210 ld.global.f32 %f50, [%rd63+8]
  f50 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (8)))));
  // PTX:211 mov.b32 %f51, %r95
  asm("mov.b32 %0, %1;" : "=f"(f51) : "r"(r95));
  // PTX:212 fma.rn.f32 %f52, %f47, %f48, %f51
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f52) : "f"(f47), "f"(f48), "f"(f51));
  // PTX:213 mov.b32 %f53, %r96
  asm("mov.b32 %0, %1;" : "=f"(f53) : "r"(r96));
  // PTX:214 fma.rn.f32 %f54, %f47, %f49, %f53
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f54) : "f"(f47), "f"(f49), "f"(f53));
  // PTX:215 mov.b32 %f55, %r97
  asm("mov.b32 %0, %1;" : "=f"(f55) : "r"(r97));
  // PTX:216 fma.rn.f32 %f56, %f47, %f50, %f55
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f56) : "f"(f47), "f"(f50), "f"(f55));
  // PTX:217 mov.b32 %r95, %f52
  asm("mov.b32 %0, %1;" : "=r"(r95) : "f"(f52));
  // PTX:218 mov.b32 %r96, %f54
  asm("mov.b32 %0, %1;" : "=r"(r96) : "f"(f54));
  // PTX:219 mov.b32 %r97, %f56
  asm("mov.b32 %0, %1;" : "=r"(r97) : "f"(f56));
  // PTX:221 $L__BB2_21:
L_BB2_21:;
  // PTX:222 add.s64 %rd82, %rd23, %rd9
  asm("add.s64 %0, %1, %2;" : "=l"(rd82) : "l"(rd23), "l"(rd9));
  // PTX:223 add.s32 %r107, %r107, 4
  asm("add.s32 %0, %1, 4;" : "=r"(r107) : "r"(r107));
  // PTX:224 add.s32 %r91, %r91, -4
  asm("add.s32 %0, %1, -4;" : "=r"(r91) : "r"(r91));
  // PTX:225 setp.ne.s32 %p23, %r91, 0
  p23 = (((int)(r91)) != ((int)(0)));
  // PTX:226 @%p23 bra $L__BB2_9
  if (p23) { goto L_BB2_9; }
  // PTX:228 $L__BB2_22:
L_BB2_22:;
  // PTX:229 setp.eq.s32 %p24, %r114, 0
  p24 = (((int)(r114)) == ((int)(0)));
  // PTX:230 @%p24 bra $L__BB2_28
  if (p24) { goto L_BB2_28; }
  // PTX:232 cvt.s64.s32 %rd83, %r107
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd83) : "r"(r107));
  // PTX:234 $L__BB2_24:
L_BB2_24:;
  // PTX:236 mul.lo.s64 %rd64, %rd83, %rd40
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd64) : "l"(rd83), "l"(rd40));
  // PTX:237 add.s64 %rd65, %rd64, %rd81
  asm("add.s64 %0, %1, %2;" : "=l"(rd65) : "l"(rd64), "l"(rd81));
  // PTX:238 shl.b64 %rd66, %rd65, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd66) : "l"(rd65));
  // PTX:239 add.s64 %rd29, %rd1, %rd66
  asm("add.s64 %0, %1, %2;" : "=l"(rd29) : "l"(rd1), "l"(rd66));
  // PTX:240 ld.global.s32 %rd30, [%rd29]
  rd30 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (0)))));
  // PTX:241 setp.lt.s64 %p25, %rd30, 0
  p25 = (((long long)(rd30)) < ((long long)(0)));
  // PTX:242 setp.ge.u64 %p26, %rd30, %rd40
  p26 = (((unsigned long long)(rd30)) >= ((unsigned long long)(rd40)));
  // PTX:243 or.pred %p27, %p25, %p26
  p27 = ((p25) || (p26));
  // PTX:244 @%p27 bra $L__BB2_27
  if (p27) { goto L_BB2_27; }
  // PTX:246 add.s64 %rd31, %rd7, %rd30
  asm("add.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd7), "l"(rd30));
  // PTX:247 setp.ge.u64 %p28, %rd31, %rd39
  p28 = (((unsigned long long)(rd31)) >= ((unsigned long long)(rd39)));
  // PTX:248 @%p28 bra $L__BB2_27
  if (p28) { goto L_BB2_27; }
  // PTX:250 ld.global.f32 %f57, [%rd29+4]
  f57 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (4)))));
  // PTX:251 mul.lo.s64 %rd67, %rd31, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd67) : "l"(rd31));
  // PTX:252 add.s64 %rd68, %rd2, %rd67
  asm("add.s64 %0, %1, %2;" : "=l"(rd68) : "l"(rd2), "l"(rd67));
  // PTX:253 ld.global.f32 %f58, [%rd68]
  f58 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (0)))));
  // PTX:254 ld.global.f32 %f59, [%rd68+4]
  f59 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (4)))));
  // PTX:255 ld.global.f32 %f60, [%rd68+8]
  f60 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (8)))));
  // PTX:256 mov.b32 %f61, %r95
  asm("mov.b32 %0, %1;" : "=f"(f61) : "r"(r95));
  // PTX:257 fma.rn.f32 %f62, %f57, %f58, %f61
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f62) : "f"(f57), "f"(f58), "f"(f61));
  // PTX:258 mov.b32 %f63, %r96
  asm("mov.b32 %0, %1;" : "=f"(f63) : "r"(r96));
  // PTX:259 fma.rn.f32 %f64, %f57, %f59, %f63
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f64) : "f"(f57), "f"(f59), "f"(f63));
  // PTX:260 mov.b32 %f65, %r97
  asm("mov.b32 %0, %1;" : "=f"(f65) : "r"(r97));
  // PTX:261 fma.rn.f32 %f66, %f57, %f60, %f65
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f66) : "f"(f57), "f"(f60), "f"(f65));
  // PTX:262 mov.b32 %r95, %f62
  asm("mov.b32 %0, %1;" : "=r"(r95) : "f"(f62));
  // PTX:263 mov.b32 %r96, %f64
  asm("mov.b32 %0, %1;" : "=r"(r96) : "f"(f64));
  // PTX:264 mov.b32 %r97, %f66
  asm("mov.b32 %0, %1;" : "=r"(r97) : "f"(f66));
  // PTX:266 $L__BB2_27:
L_BB2_27:;
  // PTX:267 add.s64 %rd83, %rd83, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd83) : "l"(rd83));
  // PTX:268 add.s32 %r114, %r114, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r114) : "r"(r114));
  // PTX:269 setp.ne.s32 %p29, %r114, 0
  p29 = (((int)(r114)) != ((int)(0)));
  // PTX:270 @%p29 bra $L__BB2_24
  if (p29) { goto L_BB2_24; }
  // PTX:272 $L__BB2_28:
L_BB2_28:;
  // PTX:273 ld.param.u64 %rd79, [_ZN7synreal6kernel17evaluate_residualINS_12NonZeroEntryEfEEvPKiPKT_mPKT0_PKN3glm3vecILi3EfLNSB_9qualifierE0EEESG_SG_PSE_mm_param_6]
  rd79 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:274 mov.b32 %f67, %r95
  asm("mov.b32 %0, %1;" : "=f"(f67) : "r"(r95));
  // PTX:275 add.f32 %f81, %f1, %f67
  asm("add.f32 %0, %1, %2;" : "=f"(f81) : "f"(f1), "f"(f67));
  // PTX:276 mov.b32 %f68, %r96
  asm("mov.b32 %0, %1;" : "=f"(f68) : "r"(r96));
  // PTX:277 add.f32 %f80, %f2, %f68
  asm("add.f32 %0, %1, %2;" : "=f"(f80) : "f"(f2), "f"(f68));
  // PTX:278 mov.b32 %f69, %r97
  asm("mov.b32 %0, %1;" : "=f"(f69) : "r"(r97));
  // PTX:279 add.f32 %f79, %f3, %f69
  asm("add.f32 %0, %1, %2;" : "=f"(f79) : "f"(f3), "f"(f69));
  // PTX:280 setp.eq.s64 %p30, %rd79, 0
  p30 = (((long long)(rd79)) == ((long long)(0)));
  // PTX:281 @%p30 bra $L__BB2_30
  if (p30) { goto L_BB2_30; }
  // PTX:283 ld.param.u64 %rd80, [_ZN7synreal6kernel17evaluate_residualINS_12NonZeroEntryEfEEvPKiPKT_mPKT0_PKN3glm3vecILi3EfLNSB_9qualifierE0EEESG_SG_PSE_mm_param_6]
  rd80 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:284 cvta.to.global.u64 %rd69, %rd80
  rd69 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd80));
  // PTX:285 add.s64 %rd71, %rd69, %rd48
  asm("add.s64 %0, %1, %2;" : "=l"(rd71) : "l"(rd69), "l"(rd48));
  // PTX:286 ld.global.f32 %f70, [%rd71]
  f70 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))));
  // PTX:287 add.f32 %f81, %f81, %f70
  asm("add.f32 %0, %1, %2;" : "=f"(f81) : "f"(f81), "f"(f70));
  // PTX:288 ld.global.f32 %f71, [%rd71+4]
  f71 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (4)))));
  // PTX:289 add.f32 %f80, %f80, %f71
  asm("add.f32 %0, %1, %2;" : "=f"(f80) : "f"(f80), "f"(f71));
  // PTX:290 ld.global.f32 %f72, [%rd71+8]
  f72 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (8)))));
  // PTX:291 add.f32 %f79, %f79, %f72
  asm("add.f32 %0, %1, %2;" : "=f"(f79) : "f"(f79), "f"(f72));
  // PTX:293 $L__BB2_30:
L_BB2_30:;
  // PTX:294 ld.param.u64 %rd78, [_ZN7synreal6kernel17evaluate_residualINS_12NonZeroEntryEfEEvPKiPKT_mPKT0_PKN3glm3vecILi3EfLNSB_9qualifierE0EEESG_SG_PSE_mm_param_7]
  rd78 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:295 ld.param.u64 %rd77, [_ZN7synreal6kernel17evaluate_residualINS_12NonZeroEntryEfEEvPKiPKT_mPKT0_PKN3glm3vecILi3EfLNSB_9qualifierE0EEESG_SG_PSE_mm_param_5]
  rd77 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:296 cvta.to.global.u64 %rd72, %rd77
  rd72 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd77));
  // PTX:297 add.s64 %rd74, %rd72, %rd48
  asm("add.s64 %0, %1, %2;" : "=l"(rd74) : "l"(rd72), "l"(rd48));
  // PTX:298 ld.global.f32 %f73, [%rd74]
  f73 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (0)))));
  // PTX:299 sub.f32 %f74, %f73, %f81
  asm("sub.f32 %0, %1, %2;" : "=f"(f74) : "f"(f73), "f"(f81));
  // PTX:300 ld.global.f32 %f75, [%rd74+4]
  f75 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (4)))));
  // PTX:301 sub.f32 %f76, %f75, %f80
  asm("sub.f32 %0, %1, %2;" : "=f"(f76) : "f"(f75), "f"(f80));
  // PTX:302 ld.global.f32 %f77, [%rd74+8]
  f77 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (8)))));
  // PTX:303 sub.f32 %f78, %f77, %f79
  asm("sub.f32 %0, %1, %2;" : "=f"(f78) : "f"(f77), "f"(f79));
  // PTX:304 cvta.to.global.u64 %rd75, %rd78
  rd75 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd78));
  // PTX:305 add.s64 %rd76, %rd75, %rd48
  asm("add.s64 %0, %1, %2;" : "=l"(rd76) : "l"(rd75), "l"(rd48));
  // PTX:306 st.global.f32 [%rd76], %f74
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (0))))) = (float)(f74);
  // PTX:307 st.global.f32 [%rd76+4], %f76
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (4))))) = (float)(f76);
  // PTX:308 st.global.f32 [%rd76+8], %f78
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (8))))) = (float)(f78);
  // PTX:310 $L__BB2_31:
L_BB2_31:;
  // PTX:311 ret
  return;
}
