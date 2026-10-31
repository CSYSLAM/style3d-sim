// 机械还原自 PTX：synreal::kernel::refresh_inertial_cache_nonzeros(float const*, unsigned long const*, int const*, float const*, unsigned long const*, int const*, synreal::NonZeroEntry*, synreal::NonZeroEntry*, unsigned long)
// PTX SHA256: 445ce04fd7fadea048e12c883c82e588f684cc10b8c0d9343ad72ab388f91b86
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__refresh_inertial_cache_nonzeros(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106;
  // PTX:25 ld.param.u64 %rd44, [_ZN7synreal6kernel31refresh_inertial_cache_nonzerosEPKfPKmPKiS2_S4_S6_PNS_12NonZeroEntryES8_m_param_0]
  rd44 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:26 ld.param.u64 %rd40, [_ZN7synreal6kernel31refresh_inertial_cache_nonzerosEPKfPKmPKiS2_S4_S6_PNS_12NonZeroEntryES8_m_param_1]
  rd40 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:27 ld.param.u64 %rd45, [_ZN7synreal6kernel31refresh_inertial_cache_nonzerosEPKfPKmPKiS2_S4_S6_PNS_12NonZeroEntryES8_m_param_2]
  rd45 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:28 ld.param.u64 %rd46, [_ZN7synreal6kernel31refresh_inertial_cache_nonzerosEPKfPKmPKiS2_S4_S6_PNS_12NonZeroEntryES8_m_param_3]
  rd46 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:29 ld.param.u64 %rd41, [_ZN7synreal6kernel31refresh_inertial_cache_nonzerosEPKfPKmPKiS2_S4_S6_PNS_12NonZeroEntryES8_m_param_4]
  rd41 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:30 ld.param.u64 %rd47, [_ZN7synreal6kernel31refresh_inertial_cache_nonzerosEPKfPKmPKiS2_S4_S6_PNS_12NonZeroEntryES8_m_param_5]
  rd47 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:31 ld.param.u64 %rd42, [_ZN7synreal6kernel31refresh_inertial_cache_nonzerosEPKfPKmPKiS2_S4_S6_PNS_12NonZeroEntryES8_m_param_6]
  rd42 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:32 ld.param.u64 %rd43, [_ZN7synreal6kernel31refresh_inertial_cache_nonzerosEPKfPKmPKiS2_S4_S6_PNS_12NonZeroEntryES8_m_param_7]
  rd43 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:33 ld.param.u64 %rd48, [_ZN7synreal6kernel31refresh_inertial_cache_nonzerosEPKfPKmPKiS2_S4_S6_PNS_12NonZeroEntryES8_m_param_8]
  rd48 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:34 cvta.to.global.u64 %rd1, %rd46
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd46));
  // PTX:35 cvta.to.global.u64 %rd2, %rd47
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd47));
  // PTX:36 cvta.to.global.u64 %rd3, %rd44
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd44));
  // PTX:37 cvta.to.global.u64 %rd4, %rd45
  rd4 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd45));
  // PTX:38 mov.u32 %r1, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r1) : "r"(blockIdx.x));
  // PTX:39 mov.u32 %r2, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockDim.x));
  // PTX:40 mul.wide.u32 %rd49, %r1, %r2
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd49) : "r"(r1), "r"(r2));
  // PTX:41 mov.u32 %r3, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(threadIdx.x));
  // PTX:42 cvt.u64.u32 %rd50, %r3
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd50) : "r"(r3));
  // PTX:43 add.s64 %rd5, %rd49, %rd50
  asm("add.s64 %0, %1, %2;" : "=l"(rd5) : "l"(rd49), "l"(rd50));
  // PTX:44 setp.ge.u64 %p1, %rd5, %rd48
  p1 = (((unsigned long long)(rd5)) >= ((unsigned long long)(rd48)));
  // PTX:45 @%p1 bra $L__BB8_19
  if (p1) { goto L_BB8_19; }
  // PTX:47 cvta.to.global.u64 %rd51, %rd40
  rd51 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd40));
  // PTX:48 shl.b64 %rd52, %rd5, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd52) : "l"(rd5));
  // PTX:49 add.s64 %rd53, %rd51, %rd52
  asm("add.s64 %0, %1, %2;" : "=l"(rd53) : "l"(rd51), "l"(rd52));
  // PTX:50 ld.global.u64 %rd6, [%rd53+8]
  rd6 = (*reinterpret_cast<volatile unsigned long long*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (8)))));
  // PTX:51 ld.global.u64 %rd7, [%rd53]
  rd7 = (*reinterpret_cast<volatile unsigned long long*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))));
  // PTX:52 setp.eq.s64 %p2, %rd6, %rd7
  p2 = (((long long)(rd6)) == ((long long)(rd7)));
  // PTX:53 @%p2 bra $L__BB8_10
  if (p2) { goto L_BB8_10; }
  // PTX:55 setp.le.u64 %p3, %rd6, %rd7
  p3 = (((unsigned long long)(rd6)) <= ((unsigned long long)(rd7)));
  // PTX:56 mov.f32 %f43, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f43) : );
  // PTX:57 @%p3 bra $L__BB8_9
  if (p3) { goto L_BB8_9; }
  // PTX:59 sub.s64 %rd54, %rd6, %rd7
  asm("sub.s64 %0, %1, %2;" : "=l"(rd54) : "l"(rd6), "l"(rd7));
  // PTX:60 and.b64 %rd8, %rd54, 3
  asm("and.b64 %0, %1, 3;" : "=l"(rd8) : "l"(rd54));
  // PTX:61 setp.eq.s64 %p4, %rd8, 0
  p4 = (((long long)(rd8)) == ((long long)(0)));
  // PTX:62 mov.f32 %f43, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f43) : );
  // PTX:63 mov.u64 %rd98, %rd7
  asm("mov.u64 %0, %1;" : "=l"(rd98) : "l"(rd7));
  // PTX:64 @%p4 bra $L__BB8_6
  if (p4) { goto L_BB8_6; }
  // PTX:66 shl.b64 %rd55, %rd7, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd55) : "l"(rd7));
  // PTX:67 add.s64 %rd96, %rd4, %rd55
  asm("add.s64 %0, %1, %2;" : "=l"(rd96) : "l"(rd4), "l"(rd55));
  // PTX:68 neg.s64 %rd95, %rd8
  asm("neg.s64 %0, %1;" : "=l"(rd95) : "l"(rd8));
  // PTX:69 mov.f32 %f43, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f43) : );
  // PTX:70 mov.u64 %rd98, %rd7
  asm("mov.u64 %0, %1;" : "=l"(rd98) : "l"(rd7));
  // PTX:72 $L__BB8_5:
L_BB8_5:;
  // PTX:74 ld.global.u32 %r4, [%rd96]
  r4 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (0)))));
  // PTX:75 mul.wide.s32 %rd56, %r4, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd56) : "r"(r4));
  // PTX:76 add.s64 %rd57, %rd3, %rd56
  asm("add.s64 %0, %1, %2;" : "=l"(rd57) : "l"(rd3), "l"(rd56));
  // PTX:77 ld.global.f32 %f19, [%rd57]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))));
  // PTX:78 add.f32 %f43, %f43, %f19
  asm("add.f32 %0, %1, %2;" : "=f"(f43) : "f"(f43), "f"(f19));
  // PTX:79 add.s64 %rd98, %rd98, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd98) : "l"(rd98));
  // PTX:80 add.s64 %rd96, %rd96, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd96) : "l"(rd96));
  // PTX:81 add.s64 %rd95, %rd95, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd95) : "l"(rd95));
  // PTX:82 setp.ne.s64 %p5, %rd95, 0
  p5 = (((long long)(rd95)) != ((long long)(0)));
  // PTX:83 @%p5 bra $L__BB8_5
  if (p5) { goto L_BB8_5; }
  // PTX:85 $L__BB8_6:
L_BB8_6:;
  // PTX:86 not.b64 %rd58, %rd7
  asm("not.b64 %0, %1;" : "=l"(rd58) : "l"(rd7));
  // PTX:87 add.s64 %rd59, %rd6, %rd58
  asm("add.s64 %0, %1, %2;" : "=l"(rd59) : "l"(rd6), "l"(rd58));
  // PTX:88 setp.lt.u64 %p6, %rd59, 3
  p6 = (((unsigned long long)(rd59)) < ((unsigned long long)(3)));
  // PTX:89 @%p6 bra $L__BB8_9
  if (p6) { goto L_BB8_9; }
  // PTX:91 shl.b64 %rd60, %rd98, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd60) : "l"(rd98));
  // PTX:92 add.s64 %rd61, %rd4, %rd60
  asm("add.s64 %0, %1, %2;" : "=l"(rd61) : "l"(rd4), "l"(rd60));
  // PTX:93 add.s64 %rd99, %rd61, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd99) : "l"(rd61));
  // PTX:95 $L__BB8_8:
L_BB8_8:;
  // PTX:96 ld.global.u32 %r5, [%rd99+-8]
  r5 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (-8)))));
  // PTX:97 mul.wide.s32 %rd62, %r5, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd62) : "r"(r5));
  // PTX:98 add.s64 %rd63, %rd3, %rd62
  asm("add.s64 %0, %1, %2;" : "=l"(rd63) : "l"(rd3), "l"(rd62));
  // PTX:99 ld.global.f32 %f20, [%rd63]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (0)))));
  // PTX:100 add.f32 %f21, %f43, %f20
  asm("add.f32 %0, %1, %2;" : "=f"(f21) : "f"(f43), "f"(f20));
  // PTX:101 ld.global.u32 %r6, [%rd99+-4]
  r6 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (-4)))));
  // PTX:102 mul.wide.s32 %rd64, %r6, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd64) : "r"(r6));
  // PTX:103 add.s64 %rd65, %rd3, %rd64
  asm("add.s64 %0, %1, %2;" : "=l"(rd65) : "l"(rd3), "l"(rd64));
  // PTX:104 ld.global.f32 %f22, [%rd65]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (0)))));
  // PTX:105 add.f32 %f23, %f21, %f22
  asm("add.f32 %0, %1, %2;" : "=f"(f23) : "f"(f21), "f"(f22));
  // PTX:106 ld.global.u32 %r7, [%rd99]
  r7 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (0)))));
  // PTX:107 mul.wide.s32 %rd66, %r7, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd66) : "r"(r7));
  // PTX:108 add.s64 %rd67, %rd3, %rd66
  asm("add.s64 %0, %1, %2;" : "=l"(rd67) : "l"(rd3), "l"(rd66));
  // PTX:109 ld.global.f32 %f24, [%rd67]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0)))));
  // PTX:110 add.f32 %f25, %f23, %f24
  asm("add.f32 %0, %1, %2;" : "=f"(f25) : "f"(f23), "f"(f24));
  // PTX:111 ld.global.u32 %r8, [%rd99+4]
  r8 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (4)))));
  // PTX:112 mul.wide.s32 %rd68, %r8, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd68) : "r"(r8));
  // PTX:113 add.s64 %rd69, %rd3, %rd68
  asm("add.s64 %0, %1, %2;" : "=l"(rd69) : "l"(rd3), "l"(rd68));
  // PTX:114 ld.global.f32 %f26, [%rd69]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (0)))));
  // PTX:115 add.f32 %f43, %f25, %f26
  asm("add.f32 %0, %1, %2;" : "=f"(f43) : "f"(f25), "f"(f26));
  // PTX:116 add.s64 %rd99, %rd99, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd99) : "l"(rd99));
  // PTX:117 add.s64 %rd98, %rd98, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd98) : "l"(rd98));
  // PTX:118 setp.lt.u64 %p7, %rd98, %rd6
  p7 = (((unsigned long long)(rd98)) < ((unsigned long long)(rd6)));
  // PTX:119 @%p7 bra $L__BB8_8
  if (p7) { goto L_BB8_8; }
  // PTX:121 $L__BB8_9:
L_BB8_9:;
  // PTX:122 cvta.to.global.u64 %rd70, %rd42
  rd70 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd42));
  // PTX:123 add.s64 %rd72, %rd70, %rd52
  asm("add.s64 %0, %1, %2;" : "=l"(rd72) : "l"(rd70), "l"(rd52));
  // PTX:124 st.global.f32 [%rd72+4], %f43
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (4))))) = (float)(f43);
  // PTX:126 $L__BB8_10:
L_BB8_10:;
  // PTX:127 cvta.to.global.u64 %rd73, %rd41
  rd73 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd41));
  // PTX:128 add.s64 %rd75, %rd73, %rd52
  asm("add.s64 %0, %1, %2;" : "=l"(rd75) : "l"(rd73), "l"(rd52));
  // PTX:129 ld.global.u64 %rd23, [%rd75+8]
  rd23 = (*reinterpret_cast<volatile unsigned long long*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (8)))));
  // PTX:130 ld.global.u64 %rd24, [%rd75]
  rd24 = (*reinterpret_cast<volatile unsigned long long*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (0)))));
  // PTX:131 setp.eq.s64 %p8, %rd23, %rd24
  p8 = (((long long)(rd23)) == ((long long)(rd24)));
  // PTX:132 @%p8 bra $L__BB8_19
  if (p8) { goto L_BB8_19; }
  // PTX:134 setp.le.u64 %p9, %rd23, %rd24
  p9 = (((unsigned long long)(rd23)) <= ((unsigned long long)(rd24)));
  // PTX:135 mov.f32 %f48, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f48) : );
  // PTX:136 @%p9 bra $L__BB8_18
  if (p9) { goto L_BB8_18; }
  // PTX:138 sub.s64 %rd76, %rd23, %rd24
  asm("sub.s64 %0, %1, %2;" : "=l"(rd76) : "l"(rd23), "l"(rd24));
  // PTX:139 and.b64 %rd25, %rd76, 3
  asm("and.b64 %0, %1, 3;" : "=l"(rd25) : "l"(rd76));
  // PTX:140 setp.eq.s64 %p10, %rd25, 0
  p10 = (((long long)(rd25)) == ((long long)(0)));
  // PTX:141 mov.f32 %f48, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f48) : );
  // PTX:142 mov.u64 %rd104, %rd24
  asm("mov.u64 %0, %1;" : "=l"(rd104) : "l"(rd24));
  // PTX:143 @%p10 bra $L__BB8_15
  if (p10) { goto L_BB8_15; }
  // PTX:145 shl.b64 %rd77, %rd24, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd77) : "l"(rd24));
  // PTX:146 add.s64 %rd102, %rd2, %rd77
  asm("add.s64 %0, %1, %2;" : "=l"(rd102) : "l"(rd2), "l"(rd77));
  // PTX:147 neg.s64 %rd101, %rd25
  asm("neg.s64 %0, %1;" : "=l"(rd101) : "l"(rd25));
  // PTX:148 mov.f32 %f48, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f48) : );
  // PTX:149 mov.u64 %rd104, %rd24
  asm("mov.u64 %0, %1;" : "=l"(rd104) : "l"(rd24));
  // PTX:151 $L__BB8_14:
L_BB8_14:;
  // PTX:153 ld.global.u32 %r9, [%rd102]
  r9 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd102) + (0)))));
  // PTX:154 mul.wide.s32 %rd78, %r9, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd78) : "r"(r9));
  // PTX:155 add.s64 %rd79, %rd1, %rd78
  asm("add.s64 %0, %1, %2;" : "=l"(rd79) : "l"(rd1), "l"(rd78));
  // PTX:156 ld.global.f32 %f31, [%rd79]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (0)))));
  // PTX:157 sub.f32 %f48, %f48, %f31
  asm("sub.f32 %0, %1, %2;" : "=f"(f48) : "f"(f48), "f"(f31));
  // PTX:158 add.s64 %rd104, %rd104, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd104) : "l"(rd104));
  // PTX:159 add.s64 %rd102, %rd102, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd102) : "l"(rd102));
  // PTX:160 add.s64 %rd101, %rd101, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd101) : "l"(rd101));
  // PTX:161 setp.ne.s64 %p11, %rd101, 0
  p11 = (((long long)(rd101)) != ((long long)(0)));
  // PTX:162 @%p11 bra $L__BB8_14
  if (p11) { goto L_BB8_14; }
  // PTX:164 $L__BB8_15:
L_BB8_15:;
  // PTX:165 not.b64 %rd80, %rd24
  asm("not.b64 %0, %1;" : "=l"(rd80) : "l"(rd24));
  // PTX:166 add.s64 %rd81, %rd23, %rd80
  asm("add.s64 %0, %1, %2;" : "=l"(rd81) : "l"(rd23), "l"(rd80));
  // PTX:167 setp.lt.u64 %p12, %rd81, 3
  p12 = (((unsigned long long)(rd81)) < ((unsigned long long)(3)));
  // PTX:168 @%p12 bra $L__BB8_18
  if (p12) { goto L_BB8_18; }
  // PTX:170 shl.b64 %rd82, %rd104, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd82) : "l"(rd104));
  // PTX:171 add.s64 %rd83, %rd2, %rd82
  asm("add.s64 %0, %1, %2;" : "=l"(rd83) : "l"(rd2), "l"(rd82));
  // PTX:172 add.s64 %rd105, %rd83, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd105) : "l"(rd83));
  // PTX:174 $L__BB8_17:
L_BB8_17:;
  // PTX:175 ld.global.u32 %r10, [%rd105+-8]
  r10 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (-8)))));
  // PTX:176 mul.wide.s32 %rd84, %r10, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd84) : "r"(r10));
  // PTX:177 add.s64 %rd85, %rd1, %rd84
  asm("add.s64 %0, %1, %2;" : "=l"(rd85) : "l"(rd1), "l"(rd84));
  // PTX:178 ld.global.f32 %f32, [%rd85]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (0)))));
  // PTX:179 sub.f32 %f33, %f48, %f32
  asm("sub.f32 %0, %1, %2;" : "=f"(f33) : "f"(f48), "f"(f32));
  // PTX:180 ld.global.u32 %r11, [%rd105+-4]
  r11 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (-4)))));
  // PTX:181 mul.wide.s32 %rd86, %r11, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd86) : "r"(r11));
  // PTX:182 add.s64 %rd87, %rd1, %rd86
  asm("add.s64 %0, %1, %2;" : "=l"(rd87) : "l"(rd1), "l"(rd86));
  // PTX:183 ld.global.f32 %f34, [%rd87]
  f34 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (0)))));
  // PTX:184 sub.f32 %f35, %f33, %f34
  asm("sub.f32 %0, %1, %2;" : "=f"(f35) : "f"(f33), "f"(f34));
  // PTX:185 ld.global.u32 %r12, [%rd105]
  r12 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (0)))));
  // PTX:186 mul.wide.s32 %rd88, %r12, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd88) : "r"(r12));
  // PTX:187 add.s64 %rd89, %rd1, %rd88
  asm("add.s64 %0, %1, %2;" : "=l"(rd89) : "l"(rd1), "l"(rd88));
  // PTX:188 ld.global.f32 %f36, [%rd89]
  f36 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (0)))));
  // PTX:189 sub.f32 %f37, %f35, %f36
  asm("sub.f32 %0, %1, %2;" : "=f"(f37) : "f"(f35), "f"(f36));
  // PTX:190 ld.global.u32 %r13, [%rd105+4]
  r13 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (4)))));
  // PTX:191 mul.wide.s32 %rd90, %r13, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd90) : "r"(r13));
  // PTX:192 add.s64 %rd91, %rd1, %rd90
  asm("add.s64 %0, %1, %2;" : "=l"(rd91) : "l"(rd1), "l"(rd90));
  // PTX:193 ld.global.f32 %f38, [%rd91]
  f38 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (0)))));
  // PTX:194 sub.f32 %f48, %f37, %f38
  asm("sub.f32 %0, %1, %2;" : "=f"(f48) : "f"(f37), "f"(f38));
  // PTX:195 add.s64 %rd105, %rd105, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd105) : "l"(rd105));
  // PTX:196 add.s64 %rd104, %rd104, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd104) : "l"(rd104));
  // PTX:197 setp.lt.u64 %p13, %rd104, %rd23
  p13 = (((unsigned long long)(rd104)) < ((unsigned long long)(rd23)));
  // PTX:198 @%p13 bra $L__BB8_17
  if (p13) { goto L_BB8_17; }
  // PTX:200 $L__BB8_18:
L_BB8_18:;
  // PTX:201 cvta.to.global.u64 %rd92, %rd43
  rd92 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd43));
  // PTX:202 add.s64 %rd94, %rd92, %rd52
  asm("add.s64 %0, %1, %2;" : "=l"(rd94) : "l"(rd92), "l"(rd52));
  // PTX:203 st.global.f32 [%rd94+4], %f48
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd94) + (4))))) = (float)(f48);
  // PTX:205 $L__BB8_19:
L_BB8_19:;
  // PTX:206 ret
  return;
}
