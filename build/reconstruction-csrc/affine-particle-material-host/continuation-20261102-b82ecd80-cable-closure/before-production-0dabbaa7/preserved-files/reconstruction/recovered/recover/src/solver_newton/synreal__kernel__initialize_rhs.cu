// 机械还原自 PTX：synreal::kernel::initialize_rhs(float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, int const*, synreal::NonZeroEntry const*, unsigned long, glm::vec<3, float, (glm::qualifier)0> const*, int const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long)
// PTX SHA256: 285ec69c4264b24dd73883d4b40041112f15f631a34bbc843839867f461b20d3
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__initialize_rhs(float param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10, unsigned long long param11) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121, r122, r123, r124, r125, r126, r127, r128, r129, r130, r131, r132;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101;
  // PTX:28 ld.param.u64 %rd43, [_ZN7synreal6kernel14initialize_rhsEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKiPKNS_12NonZeroEntryEmS6_SA_PS4_mm_param_1]
  rd43 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:29 ld.param.u64 %rd44, [_ZN7synreal6kernel14initialize_rhsEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKiPKNS_12NonZeroEntryEmS6_SA_PS4_mm_param_2]
  rd44 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:30 ld.param.u64 %rd35, [_ZN7synreal6kernel14initialize_rhsEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKiPKNS_12NonZeroEntryEmS6_SA_PS4_mm_param_3]
  rd35 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:31 ld.param.u64 %rd36, [_ZN7synreal6kernel14initialize_rhsEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKiPKNS_12NonZeroEntryEmS6_SA_PS4_mm_param_4]
  rd36 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:32 ld.param.u64 %rd45, [_ZN7synreal6kernel14initialize_rhsEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKiPKNS_12NonZeroEntryEmS6_SA_PS4_mm_param_5]
  rd45 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:33 ld.param.u64 %rd37, [_ZN7synreal6kernel14initialize_rhsEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKiPKNS_12NonZeroEntryEmS6_SA_PS4_mm_param_6]
  rd37 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:34 ld.param.u64 %rd39, [_ZN7synreal6kernel14initialize_rhsEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKiPKNS_12NonZeroEntryEmS6_SA_PS4_mm_param_8]
  rd39 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:35 ld.param.u64 %rd40, [_ZN7synreal6kernel14initialize_rhsEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKiPKNS_12NonZeroEntryEmS6_SA_PS4_mm_param_9]
  rd40 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:36 ld.param.u64 %rd41, [_ZN7synreal6kernel14initialize_rhsEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKiPKNS_12NonZeroEntryEmS6_SA_PS4_mm_param_10]
  rd41 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:37 ld.param.u64 %rd42, [_ZN7synreal6kernel14initialize_rhsEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKiPKNS_12NonZeroEntryEmS6_SA_PS4_mm_param_11]
  rd42 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:38 cvta.to.global.u64 %rd1, %rd45
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd45));
  // PTX:39 cvta.to.global.u64 %rd2, %rd43
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd43));
  // PTX:40 cvta.to.global.u64 %rd3, %rd44
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd44));
  // PTX:41 mov.u32 %r62, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r62) : "r"(blockIdx.x));
  // PTX:42 mov.u32 %r63, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r63) : "r"(blockDim.x));
  // PTX:43 mul.wide.u32 %rd46, %r62, %r63
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd46) : "r"(r62), "r"(r63));
  // PTX:44 mov.u32 %r64, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r64) : "r"(threadIdx.x));
  // PTX:45 cvt.u64.u32 %rd47, %r64
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd47) : "r"(r64));
  // PTX:46 add.s64 %rd4, %rd46, %rd47
  asm("add.s64 %0, %1, %2;" : "=l"(rd4) : "l"(rd46), "l"(rd47));
  // PTX:47 setp.ge.u64 %p1, %rd4, %rd41
  p1 = (((unsigned long long)(rd4)) >= ((unsigned long long)(rd41)));
  // PTX:48 @%p1 bra $L__BB12_34
  if (p1) { goto L_BB12_34; }
  // PTX:50 or.b64 %rd48, %rd4, %rd42
  asm("or.b64 %0, %1, %2;" : "=l"(rd48) : "l"(rd4), "l"(rd42));
  // PTX:51 and.b64 %rd49, %rd48, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd49) : "l"(rd48));
  // PTX:52 setp.eq.s64 %p2, %rd49, 0
  p2 = (((long long)(rd49)) == ((long long)(0)));
  // PTX:53 @%p2 bra $L__BB12_3
  if (p2) { goto L_BB12_3; }
  // PTX:55 rem.u64 %rd99, %rd4, %rd42
  asm("rem.u64 %0, %1, %2;" : "=l"(rd99) : "l"(rd4), "l"(rd42));
  // PTX:56 bra.uni $L__BB12_4
  goto L_BB12_4;
  // PTX:58 $L__BB12_3:
L_BB12_3:;
  // PTX:59 cvt.u32.u64 %r65, %rd42
  asm("cvt.u32.u64 %0, %1;" : "=r"(r65) : "l"(rd42));
  // PTX:60 cvt.u32.u64 %r66, %rd4
  asm("cvt.u32.u64 %0, %1;" : "=r"(r66) : "l"(rd4));
  // PTX:61 rem.u32 %r67, %r66, %r65
  asm("rem.u32 %0, %1, %2;" : "=r"(r67) : "r"(r66), "r"(r65));
  // PTX:62 cvt.u64.u32 %rd99, %r67
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd99) : "r"(r67));
  // PTX:64 $L__BB12_4:
L_BB12_4:;
  // PTX:65 cvta.to.global.u64 %rd50, %rd35
  rd50 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd35));
  // PTX:66 shl.b64 %rd51, %rd99, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd51) : "l"(rd99));
  // PTX:67 add.s64 %rd52, %rd50, %rd51
  asm("add.s64 %0, %1, %2;" : "=l"(rd52) : "l"(rd50), "l"(rd51));
  // PTX:68 ld.global.f32 %f1, [%rd52]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))));
  // PTX:69 setp.leu.f32 %p3, %f1, 0f00000000
  p3 = ((isnan(((float)(f1))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f1)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:70 cvta.to.global.u64 %rd53, %rd40
  rd53 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd40));
  // PTX:71 mul.lo.s64 %rd54, %rd4, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd54) : "l"(rd4));
  // PTX:72 add.s64 %rd8, %rd53, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd8) : "l"(rd53), "l"(rd54));
  // PTX:73 @%p3 bra $L__BB12_7
  if (p3) { goto L_BB12_7; }
  // PTX:75 setp.eq.s64 %p4, %rd39, 0
  p4 = (((long long)(rd39)) == ((long long)(0)));
  // PTX:76 @%p4 bra $L__BB12_8
  if (p4) { goto L_BB12_8; }
  // PTX:78 cvta.to.global.u64 %rd55, %rd39
  rd55 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd39));
  // PTX:79 add.s64 %rd57, %rd55, %rd51
  asm("add.s64 %0, %1, %2;" : "=l"(rd57) : "l"(rd55), "l"(rd51));
  // PTX:80 ld.global.u32 %r68, [%rd57]
  r68 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))));
  // PTX:81 and.b32 %r69, %r68, 1
  asm("and.b32 %0, %1, 1;" : "=r"(r69) : "r"(r68));
  // PTX:82 setp.eq.b32 %p5, %r69, 1
  p5 = (((unsigned)(r69)) == ((unsigned)(1)));
  // PTX:83 mov.pred %p6, 0
  p6 = ((0) != 0);
  // PTX:84 xor.pred %p7, %p5, %p6
  p7 = ((p5) != (p6));
  // PTX:85 @%p7 bra $L__BB12_8
  if (p7) { goto L_BB12_8; }
  // PTX:87 $L__BB12_7:
L_BB12_7:;
  // PTX:88 mov.u32 %r70, 0
  asm("mov.u32 %0, 0;" : "=r"(r70) : );
  // PTX:89 st.global.u32 [%rd8], %r70
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (0))))) = (unsigned)(r70);
  // PTX:90 st.global.u32 [%rd8+4], %r70
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (4))))) = (unsigned)(r70);
  // PTX:91 st.global.u32 [%rd8+8], %r70
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (8))))) = (unsigned)(r70);
  // PTX:92 bra.uni $L__BB12_34
  goto L_BB12_34;
  // PTX:94 $L__BB12_8:
L_BB12_8:;
  // PTX:95 add.s64 %rd59, %rd3, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd59) : "l"(rd3), "l"(rd54));
  // PTX:96 add.s64 %rd60, %rd2, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd60) : "l"(rd2), "l"(rd54));
  // PTX:97 ld.global.f32 %f15, [%rd60]
  f15 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))));
  // PTX:98 ld.global.f32 %f16, [%rd59]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))));
  // PTX:99 sub.f32 %f17, %f16, %f15
  asm("sub.f32 %0, %1, %2;" : "=f"(f17) : "f"(f16), "f"(f15));
  // PTX:100 ld.global.f32 %f18, [%rd60+4]
  f18 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (4)))));
  // PTX:101 ld.global.f32 %f19, [%rd59+4]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (4)))));
  // PTX:102 sub.f32 %f20, %f19, %f18
  asm("sub.f32 %0, %1, %2;" : "=f"(f20) : "f"(f19), "f"(f18));
  // PTX:103 ld.global.f32 %f21, [%rd60+8]
  f21 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (8)))));
  // PTX:104 ld.global.f32 %f22, [%rd59+8]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (8)))));
  // PTX:105 sub.f32 %f23, %f22, %f21
  asm("sub.f32 %0, %1, %2;" : "=f"(f23) : "f"(f22), "f"(f21));
  // PTX:106 mul.f32 %f2, %f1, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f2) : "f"(f1), "f"(f17));
  // PTX:107 mul.f32 %f3, %f1, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f3) : "f"(f1), "f"(f20));
  // PTX:108 mul.f32 %f4, %f1, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f4) : "f"(f1), "f"(f23));
  // PTX:109 setp.eq.s64 %p8, %rd37, 0
  p8 = (((long long)(rd37)) == ((long long)(0)));
  // PTX:110 mov.u32 %r104, 0
  asm("mov.u32 %0, 0;" : "=r"(r104) : );
  // PTX:111 mov.u32 %r105, %r104
  asm("mov.u32 %0, %1;" : "=r"(r105) : "r"(r104));
  // PTX:112 mov.u32 %r106, %r104
  asm("mov.u32 %0, %1;" : "=r"(r106) : "r"(r104));
  // PTX:113 @%p8 bra $L__BB12_31
  if (p8) { goto L_BB12_31; }
  // PTX:115 sub.s64 %rd9, %rd4, %rd99
  asm("sub.s64 %0, %1, %2;" : "=l"(rd9) : "l"(rd4), "l"(rd99));
  // PTX:116 cvta.to.global.u64 %rd61, %rd36
  rd61 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd36));
  // PTX:117 add.s64 %rd63, %rd61, %rd51
  asm("add.s64 %0, %1, %2;" : "=l"(rd63) : "l"(rd61), "l"(rd51));
  // PTX:118 ld.global.u32 %r77, [%rd63]
  r77 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (0)))));
  // PTX:119 mov.u32 %r104, 0
  asm("mov.u32 %0, 0;" : "=r"(r104) : );
  // PTX:120 max.s32 %r78, %r77, 0
  asm("max.s32 %0, %1, 0;" : "=r"(r78) : "r"(r77));
  // PTX:121 cvt.u32.u64 %r79, %rd37
  asm("cvt.u32.u64 %0, %1;" : "=r"(r79) : "l"(rd37));
  // PTX:122 min.s32 %r1, %r78, %r79
  asm("min.s32 %0, %1, %2;" : "=r"(r1) : "r"(r78), "r"(r79));
  // PTX:123 setp.lt.s32 %p9, %r1, 1
  p9 = (((int)(r1)) < ((int)(1)));
  // PTX:124 @%p9 bra $L__BB12_31
  if (p9) { goto L_BB12_31; }
  // PTX:126 add.s32 %r85, %r1, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r85) : "r"(r1));
  // PTX:127 and.b32 %r123, %r1, 3
  asm("and.b32 %0, %1, 3;" : "=r"(r123) : "r"(r1));
  // PTX:128 setp.lt.u32 %p10, %r85, 3
  p10 = (((unsigned)(r85)) < ((unsigned)(3)));
  // PTX:129 mov.u32 %r116, 0
  asm("mov.u32 %0, 0;" : "=r"(r116) : );
  // PTX:130 mov.u32 %r106, %r116
  asm("mov.u32 %0, %1;" : "=r"(r106) : "r"(r116));
  // PTX:131 mov.u32 %r105, %r116
  asm("mov.u32 %0, %1;" : "=r"(r105) : "r"(r116));
  // PTX:132 mov.u32 %r104, %r116
  asm("mov.u32 %0, %1;" : "=r"(r104) : "r"(r116));
  // PTX:133 @%p10 bra $L__BB12_25
  if (p10) { goto L_BB12_25; }
  // PTX:135 sub.s32 %r100, %r1, %r123
  asm("sub.s32 %0, %1, %2;" : "=r"(r100) : "r"(r1), "r"(r123));
  // PTX:136 shl.b64 %rd64, %rd99, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd64) : "l"(rd99));
  // PTX:137 add.s64 %rd100, %rd1, %rd64
  asm("add.s64 %0, %1, %2;" : "=l"(rd100) : "l"(rd1), "l"(rd64));
  // PTX:138 shl.b64 %rd11, %rd42, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd11) : "l"(rd42));
  // PTX:139 mov.u32 %r116, 0
  asm("mov.u32 %0, 0;" : "=r"(r116) : );
  // PTX:141 $L__BB12_12:
L_BB12_12:;
  // PTX:142 ld.global.s32 %rd14, [%rd100]
  rd14 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (0)))));
  // PTX:143 setp.lt.s64 %p11, %rd14, 0
  p11 = (((long long)(rd14)) < ((long long)(0)));
  // PTX:144 setp.ge.u64 %p12, %rd14, %rd42
  p12 = (((unsigned long long)(rd14)) >= ((unsigned long long)(rd42)));
  // PTX:145 or.pred %p13, %p11, %p12
  p13 = ((p11) || (p12));
  // PTX:146 @%p13 bra $L__BB12_15
  if (p13) { goto L_BB12_15; }
  // PTX:148 add.s64 %rd15, %rd9, %rd14
  asm("add.s64 %0, %1, %2;" : "=l"(rd15) : "l"(rd9), "l"(rd14));
  // PTX:149 setp.ge.u64 %p14, %rd15, %rd41
  p14 = (((unsigned long long)(rd15)) >= ((unsigned long long)(rd41)));
  // PTX:150 @%p14 bra $L__BB12_15
  if (p14) { goto L_BB12_15; }
  // PTX:152 ld.global.f32 %f24, [%rd100+4]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (4)))));
  // PTX:153 mul.lo.s64 %rd65, %rd15, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd65) : "l"(rd15));
  // PTX:154 add.s64 %rd66, %rd3, %rd65
  asm("add.s64 %0, %1, %2;" : "=l"(rd66) : "l"(rd3), "l"(rd65));
  // PTX:155 add.s64 %rd67, %rd2, %rd65
  asm("add.s64 %0, %1, %2;" : "=l"(rd67) : "l"(rd2), "l"(rd65));
  // PTX:156 ld.global.f32 %f25, [%rd67]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0)))));
  // PTX:157 ld.global.f32 %f26, [%rd66]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (0)))));
  // PTX:158 sub.f32 %f27, %f26, %f25
  asm("sub.f32 %0, %1, %2;" : "=f"(f27) : "f"(f26), "f"(f25));
  // PTX:159 ld.global.f32 %f28, [%rd67+4]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (4)))));
  // PTX:160 ld.global.f32 %f29, [%rd66+4]
  f29 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (4)))));
  // PTX:161 sub.f32 %f30, %f29, %f28
  asm("sub.f32 %0, %1, %2;" : "=f"(f30) : "f"(f29), "f"(f28));
  // PTX:162 ld.global.f32 %f31, [%rd67+8]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (8)))));
  // PTX:163 ld.global.f32 %f32, [%rd66+8]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (8)))));
  // PTX:164 sub.f32 %f33, %f32, %f31
  asm("sub.f32 %0, %1, %2;" : "=f"(f33) : "f"(f32), "f"(f31));
  // PTX:165 mov.b32 %f34, %r104
  asm("mov.b32 %0, %1;" : "=f"(f34) : "r"(r104));
  // PTX:166 fma.rn.f32 %f35, %f24, %f27, %f34
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f35) : "f"(f24), "f"(f27), "f"(f34));
  // PTX:167 mov.b32 %f36, %r105
  asm("mov.b32 %0, %1;" : "=f"(f36) : "r"(r105));
  // PTX:168 fma.rn.f32 %f37, %f24, %f30, %f36
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f37) : "f"(f24), "f"(f30), "f"(f36));
  // PTX:169 mov.b32 %f38, %r106
  asm("mov.b32 %0, %1;" : "=f"(f38) : "r"(r106));
  // PTX:170 fma.rn.f32 %f39, %f24, %f33, %f38
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f39) : "f"(f24), "f"(f33), "f"(f38));
  // PTX:171 mov.b32 %r104, %f35
  asm("mov.b32 %0, %1;" : "=r"(r104) : "f"(f35));
  // PTX:172 mov.b32 %r105, %f37
  asm("mov.b32 %0, %1;" : "=r"(r105) : "f"(f37));
  // PTX:173 mov.b32 %r106, %f39
  asm("mov.b32 %0, %1;" : "=r"(r106) : "f"(f39));
  // PTX:175 $L__BB12_15:
L_BB12_15:;
  // PTX:176 add.s64 %rd17, %rd100, %rd11
  asm("add.s64 %0, %1, %2;" : "=l"(rd17) : "l"(rd100), "l"(rd11));
  // PTX:177 ld.global.s32 %rd18, [%rd17]
  rd18 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:178 setp.lt.s64 %p15, %rd18, 0
  p15 = (((long long)(rd18)) < ((long long)(0)));
  // PTX:179 setp.ge.u64 %p16, %rd18, %rd42
  p16 = (((unsigned long long)(rd18)) >= ((unsigned long long)(rd42)));
  // PTX:180 or.pred %p17, %p15, %p16
  p17 = ((p15) || (p16));
  // PTX:181 @%p17 bra $L__BB12_18
  if (p17) { goto L_BB12_18; }
  // PTX:183 add.s64 %rd19, %rd9, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd9), "l"(rd18));
  // PTX:184 setp.ge.u64 %p18, %rd19, %rd41
  p18 = (((unsigned long long)(rd19)) >= ((unsigned long long)(rd41)));
  // PTX:185 @%p18 bra $L__BB12_18
  if (p18) { goto L_BB12_18; }
  // PTX:187 ld.global.f32 %f40, [%rd17+4]
  f40 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (4)))));
  // PTX:188 mul.lo.s64 %rd68, %rd19, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd68) : "l"(rd19));
  // PTX:189 add.s64 %rd69, %rd3, %rd68
  asm("add.s64 %0, %1, %2;" : "=l"(rd69) : "l"(rd3), "l"(rd68));
  // PTX:190 add.s64 %rd70, %rd2, %rd68
  asm("add.s64 %0, %1, %2;" : "=l"(rd70) : "l"(rd2), "l"(rd68));
  // PTX:191 ld.global.f32 %f41, [%rd70]
  f41 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0)))));
  // PTX:192 ld.global.f32 %f42, [%rd69]
  f42 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (0)))));
  // PTX:193 sub.f32 %f43, %f42, %f41
  asm("sub.f32 %0, %1, %2;" : "=f"(f43) : "f"(f42), "f"(f41));
  // PTX:194 ld.global.f32 %f44, [%rd70+4]
  f44 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (4)))));
  // PTX:195 ld.global.f32 %f45, [%rd69+4]
  f45 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (4)))));
  // PTX:196 sub.f32 %f46, %f45, %f44
  asm("sub.f32 %0, %1, %2;" : "=f"(f46) : "f"(f45), "f"(f44));
  // PTX:197 ld.global.f32 %f47, [%rd70+8]
  f47 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (8)))));
  // PTX:198 ld.global.f32 %f48, [%rd69+8]
  f48 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (8)))));
  // PTX:199 sub.f32 %f49, %f48, %f47
  asm("sub.f32 %0, %1, %2;" : "=f"(f49) : "f"(f48), "f"(f47));
  // PTX:200 mov.b32 %f50, %r104
  asm("mov.b32 %0, %1;" : "=f"(f50) : "r"(r104));
  // PTX:201 fma.rn.f32 %f51, %f40, %f43, %f50
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f51) : "f"(f40), "f"(f43), "f"(f50));
  // PTX:202 mov.b32 %f52, %r105
  asm("mov.b32 %0, %1;" : "=f"(f52) : "r"(r105));
  // PTX:203 fma.rn.f32 %f53, %f40, %f46, %f52
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f53) : "f"(f40), "f"(f46), "f"(f52));
  // PTX:204 mov.b32 %f54, %r106
  asm("mov.b32 %0, %1;" : "=f"(f54) : "r"(r106));
  // PTX:205 fma.rn.f32 %f55, %f40, %f49, %f54
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f55) : "f"(f40), "f"(f49), "f"(f54));
  // PTX:206 mov.b32 %r104, %f51
  asm("mov.b32 %0, %1;" : "=r"(r104) : "f"(f51));
  // PTX:207 mov.b32 %r105, %f53
  asm("mov.b32 %0, %1;" : "=r"(r105) : "f"(f53));
  // PTX:208 mov.b32 %r106, %f55
  asm("mov.b32 %0, %1;" : "=r"(r106) : "f"(f55));
  // PTX:210 $L__BB12_18:
L_BB12_18:;
  // PTX:211 add.s64 %rd21, %rd17, %rd11
  asm("add.s64 %0, %1, %2;" : "=l"(rd21) : "l"(rd17), "l"(rd11));
  // PTX:212 ld.global.s32 %rd22, [%rd21]
  rd22 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (0)))));
  // PTX:213 setp.lt.s64 %p19, %rd22, 0
  p19 = (((long long)(rd22)) < ((long long)(0)));
  // PTX:214 setp.ge.u64 %p20, %rd22, %rd42
  p20 = (((unsigned long long)(rd22)) >= ((unsigned long long)(rd42)));
  // PTX:215 or.pred %p21, %p19, %p20
  p21 = ((p19) || (p20));
  // PTX:216 @%p21 bra $L__BB12_21
  if (p21) { goto L_BB12_21; }
  // PTX:218 add.s64 %rd23, %rd9, %rd22
  asm("add.s64 %0, %1, %2;" : "=l"(rd23) : "l"(rd9), "l"(rd22));
  // PTX:219 setp.ge.u64 %p22, %rd23, %rd41
  p22 = (((unsigned long long)(rd23)) >= ((unsigned long long)(rd41)));
  // PTX:220 @%p22 bra $L__BB12_21
  if (p22) { goto L_BB12_21; }
  // PTX:222 ld.global.f32 %f56, [%rd21+4]
  f56 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (4)))));
  // PTX:223 mul.lo.s64 %rd71, %rd23, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd71) : "l"(rd23));
  // PTX:224 add.s64 %rd72, %rd3, %rd71
  asm("add.s64 %0, %1, %2;" : "=l"(rd72) : "l"(rd3), "l"(rd71));
  // PTX:225 add.s64 %rd73, %rd2, %rd71
  asm("add.s64 %0, %1, %2;" : "=l"(rd73) : "l"(rd2), "l"(rd71));
  // PTX:226 ld.global.f32 %f57, [%rd73]
  f57 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (0)))));
  // PTX:227 ld.global.f32 %f58, [%rd72]
  f58 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (0)))));
  // PTX:228 sub.f32 %f59, %f58, %f57
  asm("sub.f32 %0, %1, %2;" : "=f"(f59) : "f"(f58), "f"(f57));
  // PTX:229 ld.global.f32 %f60, [%rd73+4]
  f60 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (4)))));
  // PTX:230 ld.global.f32 %f61, [%rd72+4]
  f61 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (4)))));
  // PTX:231 sub.f32 %f62, %f61, %f60
  asm("sub.f32 %0, %1, %2;" : "=f"(f62) : "f"(f61), "f"(f60));
  // PTX:232 ld.global.f32 %f63, [%rd73+8]
  f63 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (8)))));
  // PTX:233 ld.global.f32 %f64, [%rd72+8]
  f64 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (8)))));
  // PTX:234 sub.f32 %f65, %f64, %f63
  asm("sub.f32 %0, %1, %2;" : "=f"(f65) : "f"(f64), "f"(f63));
  // PTX:235 mov.b32 %f66, %r104
  asm("mov.b32 %0, %1;" : "=f"(f66) : "r"(r104));
  // PTX:236 fma.rn.f32 %f67, %f56, %f59, %f66
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f67) : "f"(f56), "f"(f59), "f"(f66));
  // PTX:237 mov.b32 %f68, %r105
  asm("mov.b32 %0, %1;" : "=f"(f68) : "r"(r105));
  // PTX:238 fma.rn.f32 %f69, %f56, %f62, %f68
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f69) : "f"(f56), "f"(f62), "f"(f68));
  // PTX:239 mov.b32 %f70, %r106
  asm("mov.b32 %0, %1;" : "=f"(f70) : "r"(r106));
  // PTX:240 fma.rn.f32 %f71, %f56, %f65, %f70
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f71) : "f"(f56), "f"(f65), "f"(f70));
  // PTX:241 mov.b32 %r104, %f67
  asm("mov.b32 %0, %1;" : "=r"(r104) : "f"(f67));
  // PTX:242 mov.b32 %r105, %f69
  asm("mov.b32 %0, %1;" : "=r"(r105) : "f"(f69));
  // PTX:243 mov.b32 %r106, %f71
  asm("mov.b32 %0, %1;" : "=r"(r106) : "f"(f71));
  // PTX:245 $L__BB12_21:
L_BB12_21:;
  // PTX:246 add.s64 %rd25, %rd21, %rd11
  asm("add.s64 %0, %1, %2;" : "=l"(rd25) : "l"(rd21), "l"(rd11));
  // PTX:247 ld.global.s32 %rd26, [%rd25]
  rd26 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (0)))));
  // PTX:248 setp.lt.s64 %p23, %rd26, 0
  p23 = (((long long)(rd26)) < ((long long)(0)));
  // PTX:249 setp.ge.u64 %p24, %rd26, %rd42
  p24 = (((unsigned long long)(rd26)) >= ((unsigned long long)(rd42)));
  // PTX:250 or.pred %p25, %p23, %p24
  p25 = ((p23) || (p24));
  // PTX:251 @%p25 bra $L__BB12_24
  if (p25) { goto L_BB12_24; }
  // PTX:253 add.s64 %rd27, %rd9, %rd26
  asm("add.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd9), "l"(rd26));
  // PTX:254 setp.ge.u64 %p26, %rd27, %rd41
  p26 = (((unsigned long long)(rd27)) >= ((unsigned long long)(rd41)));
  // PTX:255 @%p26 bra $L__BB12_24
  if (p26) { goto L_BB12_24; }
  // PTX:257 ld.global.f32 %f72, [%rd25+4]
  f72 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (4)))));
  // PTX:258 mul.lo.s64 %rd74, %rd27, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd74) : "l"(rd27));
  // PTX:259 add.s64 %rd75, %rd3, %rd74
  asm("add.s64 %0, %1, %2;" : "=l"(rd75) : "l"(rd3), "l"(rd74));
  // PTX:260 add.s64 %rd76, %rd2, %rd74
  asm("add.s64 %0, %1, %2;" : "=l"(rd76) : "l"(rd2), "l"(rd74));
  // PTX:261 ld.global.f32 %f73, [%rd76]
  f73 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (0)))));
  // PTX:262 ld.global.f32 %f74, [%rd75]
  f74 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (0)))));
  // PTX:263 sub.f32 %f75, %f74, %f73
  asm("sub.f32 %0, %1, %2;" : "=f"(f75) : "f"(f74), "f"(f73));
  // PTX:264 ld.global.f32 %f76, [%rd76+4]
  f76 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (4)))));
  // PTX:265 ld.global.f32 %f77, [%rd75+4]
  f77 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (4)))));
  // PTX:266 sub.f32 %f78, %f77, %f76
  asm("sub.f32 %0, %1, %2;" : "=f"(f78) : "f"(f77), "f"(f76));
  // PTX:267 ld.global.f32 %f79, [%rd76+8]
  f79 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (8)))));
  // PTX:268 ld.global.f32 %f80, [%rd75+8]
  f80 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (8)))));
  // PTX:269 sub.f32 %f81, %f80, %f79
  asm("sub.f32 %0, %1, %2;" : "=f"(f81) : "f"(f80), "f"(f79));
  // PTX:270 mov.b32 %f82, %r104
  asm("mov.b32 %0, %1;" : "=f"(f82) : "r"(r104));
  // PTX:271 fma.rn.f32 %f83, %f72, %f75, %f82
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f83) : "f"(f72), "f"(f75), "f"(f82));
  // PTX:272 mov.b32 %f84, %r105
  asm("mov.b32 %0, %1;" : "=f"(f84) : "r"(r105));
  // PTX:273 fma.rn.f32 %f85, %f72, %f78, %f84
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f85) : "f"(f72), "f"(f78), "f"(f84));
  // PTX:274 mov.b32 %f86, %r106
  asm("mov.b32 %0, %1;" : "=f"(f86) : "r"(r106));
  // PTX:275 fma.rn.f32 %f87, %f72, %f81, %f86
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f87) : "f"(f72), "f"(f81), "f"(f86));
  // PTX:276 mov.b32 %r104, %f83
  asm("mov.b32 %0, %1;" : "=r"(r104) : "f"(f83));
  // PTX:277 mov.b32 %r105, %f85
  asm("mov.b32 %0, %1;" : "=r"(r105) : "f"(f85));
  // PTX:278 mov.b32 %r106, %f87
  asm("mov.b32 %0, %1;" : "=r"(r106) : "f"(f87));
  // PTX:280 $L__BB12_24:
L_BB12_24:;
  // PTX:281 add.s64 %rd100, %rd25, %rd11
  asm("add.s64 %0, %1, %2;" : "=l"(rd100) : "l"(rd25), "l"(rd11));
  // PTX:282 add.s32 %r116, %r116, 4
  asm("add.s32 %0, %1, 4;" : "=r"(r116) : "r"(r116));
  // PTX:283 add.s32 %r100, %r100, -4
  asm("add.s32 %0, %1, -4;" : "=r"(r100) : "r"(r100));
  // PTX:284 setp.ne.s32 %p27, %r100, 0
  p27 = (((int)(r100)) != ((int)(0)));
  // PTX:285 @%p27 bra $L__BB12_12
  if (p27) { goto L_BB12_12; }
  // PTX:287 $L__BB12_25:
L_BB12_25:;
  // PTX:288 setp.eq.s32 %p28, %r123, 0
  p28 = (((int)(r123)) == ((int)(0)));
  // PTX:289 @%p28 bra $L__BB12_31
  if (p28) { goto L_BB12_31; }
  // PTX:291 cvt.s64.s32 %rd101, %r116
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd101) : "r"(r116));
  // PTX:293 $L__BB12_27:
L_BB12_27:;
  // PTX:295 mul.lo.s64 %rd77, %rd101, %rd42
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd77) : "l"(rd101), "l"(rd42));
  // PTX:296 add.s64 %rd78, %rd77, %rd99
  asm("add.s64 %0, %1, %2;" : "=l"(rd78) : "l"(rd77), "l"(rd99));
  // PTX:297 shl.b64 %rd79, %rd78, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd79) : "l"(rd78));
  // PTX:298 add.s64 %rd31, %rd1, %rd79
  asm("add.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd1), "l"(rd79));
  // PTX:299 ld.global.s32 %rd32, [%rd31]
  rd32 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (0)))));
  // PTX:300 setp.lt.s64 %p29, %rd32, 0
  p29 = (((long long)(rd32)) < ((long long)(0)));
  // PTX:301 setp.ge.u64 %p30, %rd32, %rd42
  p30 = (((unsigned long long)(rd32)) >= ((unsigned long long)(rd42)));
  // PTX:302 or.pred %p31, %p29, %p30
  p31 = ((p29) || (p30));
  // PTX:303 @%p31 bra $L__BB12_30
  if (p31) { goto L_BB12_30; }
  // PTX:305 add.s64 %rd33, %rd9, %rd32
  asm("add.s64 %0, %1, %2;" : "=l"(rd33) : "l"(rd9), "l"(rd32));
  // PTX:306 setp.ge.u64 %p32, %rd33, %rd41
  p32 = (((unsigned long long)(rd33)) >= ((unsigned long long)(rd41)));
  // PTX:307 @%p32 bra $L__BB12_30
  if (p32) { goto L_BB12_30; }
  // PTX:309 ld.global.f32 %f88, [%rd31+4]
  f88 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (4)))));
  // PTX:310 mul.lo.s64 %rd80, %rd33, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd80) : "l"(rd33));
  // PTX:311 add.s64 %rd81, %rd3, %rd80
  asm("add.s64 %0, %1, %2;" : "=l"(rd81) : "l"(rd3), "l"(rd80));
  // PTX:312 add.s64 %rd82, %rd2, %rd80
  asm("add.s64 %0, %1, %2;" : "=l"(rd82) : "l"(rd2), "l"(rd80));
  // PTX:313 ld.global.f32 %f89, [%rd82]
  f89 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (0)))));
  // PTX:314 ld.global.f32 %f90, [%rd81]
  f90 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (0)))));
  // PTX:315 sub.f32 %f91, %f90, %f89
  asm("sub.f32 %0, %1, %2;" : "=f"(f91) : "f"(f90), "f"(f89));
  // PTX:316 ld.global.f32 %f92, [%rd82+4]
  f92 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (4)))));
  // PTX:317 ld.global.f32 %f93, [%rd81+4]
  f93 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (4)))));
  // PTX:318 sub.f32 %f94, %f93, %f92
  asm("sub.f32 %0, %1, %2;" : "=f"(f94) : "f"(f93), "f"(f92));
  // PTX:319 ld.global.f32 %f95, [%rd82+8]
  f95 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (8)))));
  // PTX:320 ld.global.f32 %f96, [%rd81+8]
  f96 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (8)))));
  // PTX:321 sub.f32 %f97, %f96, %f95
  asm("sub.f32 %0, %1, %2;" : "=f"(f97) : "f"(f96), "f"(f95));
  // PTX:322 mov.b32 %f98, %r104
  asm("mov.b32 %0, %1;" : "=f"(f98) : "r"(r104));
  // PTX:323 fma.rn.f32 %f99, %f88, %f91, %f98
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f99) : "f"(f88), "f"(f91), "f"(f98));
  // PTX:324 mov.b32 %f100, %r105
  asm("mov.b32 %0, %1;" : "=f"(f100) : "r"(r105));
  // PTX:325 fma.rn.f32 %f101, %f88, %f94, %f100
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f101) : "f"(f88), "f"(f94), "f"(f100));
  // PTX:326 mov.b32 %f102, %r106
  asm("mov.b32 %0, %1;" : "=f"(f102) : "r"(r106));
  // PTX:327 fma.rn.f32 %f103, %f88, %f97, %f102
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f103) : "f"(f88), "f"(f97), "f"(f102));
  // PTX:328 mov.b32 %r104, %f99
  asm("mov.b32 %0, %1;" : "=r"(r104) : "f"(f99));
  // PTX:329 mov.b32 %r105, %f101
  asm("mov.b32 %0, %1;" : "=r"(r105) : "f"(f101));
  // PTX:330 mov.b32 %r106, %f103
  asm("mov.b32 %0, %1;" : "=r"(r106) : "f"(f103));
  // PTX:332 $L__BB12_30:
L_BB12_30:;
  // PTX:333 add.s64 %rd101, %rd101, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd101) : "l"(rd101));
  // PTX:334 add.s32 %r123, %r123, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r123) : "r"(r123));
  // PTX:335 setp.ne.s32 %p33, %r123, 0
  p33 = (((int)(r123)) != ((int)(0)));
  // PTX:336 @%p33 bra $L__BB12_27
  if (p33) { goto L_BB12_27; }
  // PTX:338 $L__BB12_31:
L_BB12_31:;
  // PTX:339 ld.param.u64 %rd97, [_ZN7synreal6kernel14initialize_rhsEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKiPKNS_12NonZeroEntryEmS6_SA_PS4_mm_param_7]
  rd97 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:340 mov.b32 %f107, %r104
  asm("mov.b32 %0, %1;" : "=f"(f107) : "r"(r104));
  // PTX:341 add.f32 %f5, %f2, %f107
  asm("add.f32 %0, %1, %2;" : "=f"(f5) : "f"(f2), "f"(f107));
  // PTX:342 mov.b32 %f108, %r105
  asm("mov.b32 %0, %1;" : "=f"(f108) : "r"(r105));
  // PTX:343 add.f32 %f6, %f3, %f108
  asm("add.f32 %0, %1, %2;" : "=f"(f6) : "f"(f3), "f"(f108));
  // PTX:344 mov.b32 %f109, %r106
  asm("mov.b32 %0, %1;" : "=f"(f109) : "r"(r106));
  // PTX:345 add.f32 %f7, %f4, %f109
  asm("add.f32 %0, %1, %2;" : "=f"(f7) : "f"(f4), "f"(f109));
  // PTX:346 setp.eq.s64 %p34, %rd97, 0
  p34 = (((long long)(rd97)) == ((long long)(0)));
  // PTX:347 mov.f32 %f114, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f114) : );
  // PTX:348 mov.f32 %f115, %f114
  asm("mov.f32 %0, %1;" : "=f"(f115) : "f"(f114));
  // PTX:349 mov.f32 %f116, %f114
  asm("mov.f32 %0, %1;" : "=f"(f116) : "f"(f114));
  // PTX:350 @%p34 bra $L__BB12_33
  if (p34) { goto L_BB12_33; }
  // PTX:352 ld.param.u64 %rd98, [_ZN7synreal6kernel14initialize_rhsEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKiPKNS_12NonZeroEntryEmS6_SA_PS4_mm_param_7]
  rd98 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:353 mov.u32 %r92, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r92) : "r"(blockDim.x));
  // PTX:354 mov.u32 %r91, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r91) : "r"(blockIdx.x));
  // PTX:355 mov.u32 %r90, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r90) : "r"(threadIdx.x));
  // PTX:356 cvt.u64.u32 %rd89, %r90
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd89) : "r"(r90));
  // PTX:357 mul.wide.u32 %rd88, %r91, %r92
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd88) : "r"(r91), "r"(r92));
  // PTX:358 add.s64 %rd87, %rd88, %rd89
  asm("add.s64 %0, %1, %2;" : "=l"(rd87) : "l"(rd88), "l"(rd89));
  // PTX:359 mul.lo.s64 %rd86, %rd87, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd86) : "l"(rd87));
  // PTX:360 cvta.to.global.u64 %rd83, %rd98
  rd83 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd98));
  // PTX:361 add.s64 %rd85, %rd83, %rd86
  asm("add.s64 %0, %1, %2;" : "=l"(rd85) : "l"(rd83), "l"(rd86));
  // PTX:362 ld.global.f32 %f116, [%rd85]
  f116 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (0)))));
  // PTX:363 ld.global.f32 %f115, [%rd85+4]
  f115 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (4)))));
  // PTX:364 ld.global.f32 %f114, [%rd85+8]
  f114 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (8)))));
  // PTX:366 $L__BB12_33:
L_BB12_33:;
  // PTX:367 ld.param.f32 %f113, [_ZN7synreal6kernel14initialize_rhsEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKiPKNS_12NonZeroEntryEmS6_SA_PS4_mm_param_0]
  f113 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (0))));
  // PTX:368 ld.param.u64 %rd96, [_ZN7synreal6kernel14initialize_rhsEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKiPKNS_12NonZeroEntryEmS6_SA_PS4_mm_param_9]
  rd96 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:369 mov.u32 %r95, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r95) : "r"(blockDim.x));
  // PTX:370 mov.u32 %r94, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r94) : "r"(blockIdx.x));
  // PTX:371 mov.u32 %r93, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r93) : "r"(threadIdx.x));
  // PTX:372 cvt.u64.u32 %rd95, %r93
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd95) : "r"(r93));
  // PTX:373 mul.wide.u32 %rd94, %r94, %r95
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd94) : "r"(r94), "r"(r95));
  // PTX:374 add.s64 %rd93, %rd94, %rd95
  asm("add.s64 %0, %1, %2;" : "=l"(rd93) : "l"(rd94), "l"(rd95));
  // PTX:375 mul.lo.s64 %rd92, %rd93, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd92) : "l"(rd93));
  // PTX:376 cvta.to.global.u64 %rd91, %rd96
  rd91 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd96));
  // PTX:377 add.s64 %rd90, %rd91, %rd92
  asm("add.s64 %0, %1, %2;" : "=l"(rd90) : "l"(rd91), "l"(rd92));
  // PTX:378 fma.rn.f32 %f110, %f5, %f113, %f116
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f110) : "f"(f5), "f"(f113), "f"(f116));
  // PTX:379 fma.rn.f32 %f111, %f6, %f113, %f115
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f111) : "f"(f6), "f"(f113), "f"(f115));
  // PTX:380 fma.rn.f32 %f112, %f7, %f113, %f114
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f112) : "f"(f7), "f"(f113), "f"(f114));
  // PTX:381 st.global.f32 [%rd90], %f110
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (0))))) = (float)(f110);
  // PTX:382 st.global.f32 [%rd90+4], %f111
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (4))))) = (float)(f111);
  // PTX:383 st.global.f32 [%rd90+8], %f112
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (8))))) = (float)(f112);
  // PTX:385 $L__BB12_34:
L_BB12_34:;
  // PTX:386 ret
  return;
}
