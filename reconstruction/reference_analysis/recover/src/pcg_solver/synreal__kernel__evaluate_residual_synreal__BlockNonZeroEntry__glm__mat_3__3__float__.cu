// 机械还原自 PTX：void synreal::kernel::evaluate_residual<synreal::BlockNonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >(int const*, synreal::BlockNonZeroEntry const*, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long)
// PTX SHA256: 06ea403287851794d3c5f6fbc68b75433b7724802df3f30b73a849faf471dce2
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__evaluate_residual_synreal__BlockNonZeroEntry__glm__mat_3__3__float__(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68;
  // PTX:26 ld.param.u64 %rd19, [_ZN7synreal6kernel17evaluate_residualINS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT_mPKT0_PKNS3_3vecILi3EfLS5_0EEESI_SI_PSG_mm_param_0]
  rd19 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:27 ld.param.u64 %rd27, [_ZN7synreal6kernel17evaluate_residualINS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT_mPKT0_PKNS3_3vecILi3EfLS5_0EEESI_SI_PSG_mm_param_1]
  rd27 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:28 ld.param.u64 %rd20, [_ZN7synreal6kernel17evaluate_residualINS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT_mPKT0_PKNS3_3vecILi3EfLS5_0EEESI_SI_PSG_mm_param_2]
  rd20 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:29 ld.param.u64 %rd21, [_ZN7synreal6kernel17evaluate_residualINS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT_mPKT0_PKNS3_3vecILi3EfLS5_0EEESI_SI_PSG_mm_param_3]
  rd21 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:30 ld.param.u64 %rd28, [_ZN7synreal6kernel17evaluate_residualINS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT_mPKT0_PKNS3_3vecILi3EfLS5_0EEESI_SI_PSG_mm_param_4]
  rd28 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:31 ld.param.u64 %rd22, [_ZN7synreal6kernel17evaluate_residualINS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT_mPKT0_PKNS3_3vecILi3EfLS5_0EEESI_SI_PSG_mm_param_5]
  rd22 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:32 ld.param.u64 %rd23, [_ZN7synreal6kernel17evaluate_residualINS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT_mPKT0_PKNS3_3vecILi3EfLS5_0EEESI_SI_PSG_mm_param_6]
  rd23 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:33 ld.param.u64 %rd24, [_ZN7synreal6kernel17evaluate_residualINS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT_mPKT0_PKNS3_3vecILi3EfLS5_0EEESI_SI_PSG_mm_param_7]
  rd24 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:34 ld.param.u64 %rd25, [_ZN7synreal6kernel17evaluate_residualINS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT_mPKT0_PKNS3_3vecILi3EfLS5_0EEESI_SI_PSG_mm_param_8]
  rd25 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:35 ld.param.u64 %rd26, [_ZN7synreal6kernel17evaluate_residualINS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT_mPKT0_PKNS3_3vecILi3EfLS5_0EEESI_SI_PSG_mm_param_9]
  rd26 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:36 cvta.to.global.u64 %rd1, %rd27
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd27));
  // PTX:37 cvta.to.global.u64 %rd2, %rd28
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd28));
  // PTX:38 mov.u32 %r41, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r41) : "r"(blockIdx.x));
  // PTX:39 mov.u32 %r42, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r42) : "r"(blockDim.x));
  // PTX:40 mul.wide.u32 %rd29, %r41, %r42
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd29) : "r"(r41), "r"(r42));
  // PTX:41 mov.u32 %r43, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r43) : "r"(threadIdx.x));
  // PTX:42 cvt.u64.u32 %rd30, %r43
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd30) : "r"(r43));
  // PTX:43 add.s64 %rd3, %rd29, %rd30
  asm("add.s64 %0, %1, %2;" : "=l"(rd3) : "l"(rd29), "l"(rd30));
  // PTX:44 setp.ge.u64 %p1, %rd3, %rd25
  p1 = (((unsigned long long)(rd3)) >= ((unsigned long long)(rd25)));
  // PTX:45 @%p1 bra $L__BB6_24
  if (p1) { goto L_BB6_24; }
  // PTX:47 cvta.to.global.u64 %rd31, %rd21
  rd31 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd21));
  // PTX:48 mul.lo.s64 %rd32, %rd3, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd32) : "l"(rd3));
  // PTX:49 add.s64 %rd33, %rd31, %rd32
  asm("add.s64 %0, %1, %2;" : "=l"(rd33) : "l"(rd31), "l"(rd32));
  // PTX:50 mul.lo.s64 %rd34, %rd3, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd34) : "l"(rd3));
  // PTX:51 add.s64 %rd35, %rd2, %rd34
  asm("add.s64 %0, %1, %2;" : "=l"(rd35) : "l"(rd2), "l"(rd34));
  // PTX:52 ld.global.f32 %f13, [%rd35]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (0)))));
  // PTX:53 ld.global.f32 %f14, [%rd33]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (0)))));
  // PTX:54 ld.global.f32 %f15, [%rd35+4]
  f15 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (4)))));
  // PTX:55 ld.global.f32 %f16, [%rd33+12]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (12)))));
  // PTX:56 mul.f32 %f17, %f16, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f17) : "f"(f16), "f"(f15));
  // PTX:57 fma.rn.f32 %f18, %f14, %f13, %f17
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f18) : "f"(f14), "f"(f13), "f"(f17));
  // PTX:58 ld.global.f32 %f19, [%rd35+8]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (8)))));
  // PTX:59 ld.global.f32 %f20, [%rd33+24]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (24)))));
  // PTX:60 fma.rn.f32 %f1, %f20, %f19, %f18
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1) : "f"(f20), "f"(f19), "f"(f18));
  // PTX:61 ld.global.f32 %f21, [%rd33+4]
  f21 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (4)))));
  // PTX:62 ld.global.f32 %f22, [%rd33+16]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (16)))));
  // PTX:63 mul.f32 %f23, %f22, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f23) : "f"(f22), "f"(f15));
  // PTX:64 fma.rn.f32 %f24, %f21, %f13, %f23
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f24) : "f"(f21), "f"(f13), "f"(f23));
  // PTX:65 ld.global.f32 %f25, [%rd33+28]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (28)))));
  // PTX:66 fma.rn.f32 %f2, %f25, %f19, %f24
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f2) : "f"(f25), "f"(f19), "f"(f24));
  // PTX:67 ld.global.f32 %f26, [%rd33+8]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (8)))));
  // PTX:68 ld.global.f32 %f27, [%rd33+20]
  f27 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (20)))));
  // PTX:69 mul.f32 %f28, %f27, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f28) : "f"(f27), "f"(f15));
  // PTX:70 fma.rn.f32 %f29, %f26, %f13, %f28
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f29) : "f"(f26), "f"(f13), "f"(f28));
  // PTX:71 ld.global.f32 %f30, [%rd33+32]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (32)))));
  // PTX:72 fma.rn.f32 %f3, %f30, %f19, %f29
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f3) : "f"(f30), "f"(f19), "f"(f29));
  // PTX:73 setp.eq.s64 %p2, %rd20, 0
  p2 = (((long long)(rd20)) == ((long long)(0)));
  // PTX:74 mov.u32 %r82, 0
  asm("mov.u32 %0, 0;" : "=r"(r82) : );
  // PTX:75 mov.u32 %r83, %r82
  asm("mov.u32 %0, %1;" : "=r"(r83) : "r"(r82));
  // PTX:76 mov.u32 %r84, %r82
  asm("mov.u32 %0, %1;" : "=r"(r84) : "r"(r82));
  // PTX:77 @%p2 bra $L__BB6_21
  if (p2) { goto L_BB6_21; }
  // PTX:79 setp.eq.s64 %p3, %rd26, 0
  p3 = (((long long)(rd26)) == ((long long)(0)));
  // PTX:80 mov.u64 %rd67, %rd3
  asm("mov.u64 %0, %1;" : "=l"(rd67) : "l"(rd3));
  // PTX:81 @%p3 bra $L__BB6_6
  if (p3) { goto L_BB6_6; }
  // PTX:83 or.b64 %rd36, %rd3, %rd26
  asm("or.b64 %0, %1, %2;" : "=l"(rd36) : "l"(rd3), "l"(rd26));
  // PTX:84 and.b64 %rd37, %rd36, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd37) : "l"(rd36));
  // PTX:85 setp.eq.s64 %p4, %rd37, 0
  p4 = (((long long)(rd37)) == ((long long)(0)));
  // PTX:86 @%p4 bra $L__BB6_5
  if (p4) { goto L_BB6_5; }
  // PTX:88 rem.u64 %rd67, %rd3, %rd26
  asm("rem.u64 %0, %1, %2;" : "=l"(rd67) : "l"(rd3), "l"(rd26));
  // PTX:89 bra.uni $L__BB6_6
  goto L_BB6_6;
  // PTX:91 $L__BB6_5:
L_BB6_5:;
  // PTX:92 cvt.u32.u64 %r47, %rd26
  asm("cvt.u32.u64 %0, %1;" : "=r"(r47) : "l"(rd26));
  // PTX:93 cvt.u32.u64 %r48, %rd3
  asm("cvt.u32.u64 %0, %1;" : "=r"(r48) : "l"(rd3));
  // PTX:94 rem.u32 %r49, %r48, %r47
  asm("rem.u32 %0, %1, %2;" : "=r"(r49) : "r"(r48), "r"(r47));
  // PTX:95 cvt.u64.u32 %rd67, %r49
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd67) : "r"(r49));
  // PTX:97 $L__BB6_6:
L_BB6_6:;
  // PTX:98 sub.s64 %rd7, %rd3, %rd67
  asm("sub.s64 %0, %1, %2;" : "=l"(rd7) : "l"(rd3), "l"(rd67));
  // PTX:99 cvta.to.global.u64 %rd38, %rd19
  rd38 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd19));
  // PTX:100 shl.b64 %rd39, %rd67, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd39) : "l"(rd67));
  // PTX:101 add.s64 %rd40, %rd38, %rd39
  asm("add.s64 %0, %1, %2;" : "=l"(rd40) : "l"(rd38), "l"(rd39));
  // PTX:102 ld.global.u32 %r53, [%rd40]
  r53 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (0)))));
  // PTX:103 mov.u32 %r82, 0
  asm("mov.u32 %0, 0;" : "=r"(r82) : );
  // PTX:104 max.s32 %r54, %r53, 0
  asm("max.s32 %0, %1, 0;" : "=r"(r54) : "r"(r53));
  // PTX:105 cvt.u32.u64 %r55, %rd20
  asm("cvt.u32.u64 %0, %1;" : "=r"(r55) : "l"(rd20));
  // PTX:106 min.s32 %r1, %r54, %r55
  asm("min.s32 %0, %1, %2;" : "=r"(r1) : "r"(r54), "r"(r55));
  // PTX:107 setp.lt.s32 %p5, %r1, 1
  p5 = (((int)(r1)) < ((int)(1)));
  // PTX:108 mov.u32 %r83, %r82
  asm("mov.u32 %0, %1;" : "=r"(r83) : "r"(r82));
  // PTX:109 mov.u32 %r84, %r82
  asm("mov.u32 %0, %1;" : "=r"(r84) : "r"(r82));
  // PTX:110 @%p5 bra $L__BB6_21
  if (p5) { goto L_BB6_21; }
  // PTX:112 and.b32 %r2, %r1, 1
  asm("and.b32 %0, %1, 1;" : "=r"(r2) : "r"(r1));
  // PTX:113 setp.eq.s32 %p6, %r1, 1
  p6 = (((int)(r1)) == ((int)(1)));
  // PTX:114 mov.u32 %r84, 0
  asm("mov.u32 %0, 0;" : "=r"(r84) : );
  // PTX:115 mov.u64 %rd68, 0
  asm("mov.u64 %0, 0;" : "=l"(rd68) : );
  // PTX:116 mov.u32 %r83, %r84
  asm("mov.u32 %0, %1;" : "=r"(r83) : "r"(r84));
  // PTX:117 mov.u32 %r82, %r84
  asm("mov.u32 %0, %1;" : "=r"(r82) : "r"(r84));
  // PTX:118 @%p6 bra $L__BB6_17
  if (p6) { goto L_BB6_17; }
  // PTX:120 sub.s32 %r69, %r1, %r2
  asm("sub.s32 %0, %1, %2;" : "=r"(r69) : "r"(r1), "r"(r2));
  // PTX:121 mov.u32 %r65, 0
  asm("mov.u32 %0, 0;" : "=r"(r65) : );
  // PTX:122 mov.u32 %r84, %r65
  asm("mov.u32 %0, %1;" : "=r"(r84) : "r"(r65));
  // PTX:123 mov.u32 %r83, %r65
  asm("mov.u32 %0, %1;" : "=r"(r83) : "r"(r65));
  // PTX:124 mov.u32 %r82, %r65
  asm("mov.u32 %0, %1;" : "=r"(r82) : "r"(r65));
  // PTX:126 $L__BB6_9:
L_BB6_9:;
  // PTX:127 cvt.s64.s32 %rd42, %r65
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd42) : "r"(r65));
  // PTX:128 mul.lo.s64 %rd43, %rd42, %rd26
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd43) : "l"(rd42), "l"(rd26));
  // PTX:129 add.s64 %rd44, %rd43, %rd67
  asm("add.s64 %0, %1, %2;" : "=l"(rd44) : "l"(rd43), "l"(rd67));
  // PTX:130 mul.lo.s64 %rd45, %rd44, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd45) : "l"(rd44));
  // PTX:131 add.s64 %rd8, %rd1, %rd45
  asm("add.s64 %0, %1, %2;" : "=l"(rd8) : "l"(rd1), "l"(rd45));
  // PTX:132 ld.global.s32 %rd9, [%rd8]
  rd9 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (0)))));
  // PTX:133 setp.lt.s64 %p7, %rd9, 0
  p7 = (((long long)(rd9)) < ((long long)(0)));
  // PTX:134 setp.ge.u64 %p8, %rd9, %rd26
  p8 = (((unsigned long long)(rd9)) >= ((unsigned long long)(rd26)));
  // PTX:135 or.pred %p9, %p7, %p8
  p9 = ((p7) || (p8));
  // PTX:136 @%p9 bra $L__BB6_12
  if (p9) { goto L_BB6_12; }
  // PTX:138 add.s64 %rd10, %rd7, %rd9
  asm("add.s64 %0, %1, %2;" : "=l"(rd10) : "l"(rd7), "l"(rd9));
  // PTX:139 setp.ge.u64 %p10, %rd10, %rd25
  p10 = (((unsigned long long)(rd10)) >= ((unsigned long long)(rd25)));
  // PTX:140 @%p10 bra $L__BB6_12
  if (p10) { goto L_BB6_12; }
  // PTX:142 ld.global.f32 %f31, [%rd8+4]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (4)))));
  // PTX:143 ld.global.f32 %f32, [%rd8+8]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (8)))));
  // PTX:144 ld.global.f32 %f33, [%rd8+12]
  f33 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (12)))));
  // PTX:145 ld.global.f32 %f34, [%rd8+16]
  f34 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (16)))));
  // PTX:146 ld.global.f32 %f35, [%rd8+20]
  f35 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (20)))));
  // PTX:147 ld.global.f32 %f36, [%rd8+24]
  f36 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (24)))));
  // PTX:148 ld.global.f32 %f37, [%rd8+28]
  f37 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (28)))));
  // PTX:149 ld.global.f32 %f38, [%rd8+32]
  f38 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (32)))));
  // PTX:150 ld.global.f32 %f39, [%rd8+36]
  f39 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (36)))));
  // PTX:151 mul.lo.s64 %rd46, %rd10, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd46) : "l"(rd10));
  // PTX:152 add.s64 %rd47, %rd2, %rd46
  asm("add.s64 %0, %1, %2;" : "=l"(rd47) : "l"(rd2), "l"(rd46));
  // PTX:153 ld.global.f32 %f40, [%rd47]
  f40 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))));
  // PTX:154 ld.global.f32 %f41, [%rd47+4]
  f41 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (4)))));
  // PTX:155 mul.f32 %f42, %f34, %f41
  asm("mul.f32 %0, %1, %2;" : "=f"(f42) : "f"(f34), "f"(f41));
  // PTX:156 fma.rn.f32 %f43, %f31, %f40, %f42
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f43) : "f"(f31), "f"(f40), "f"(f42));
  // PTX:157 ld.global.f32 %f44, [%rd47+8]
  f44 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (8)))));
  // PTX:158 fma.rn.f32 %f45, %f37, %f44, %f43
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f45) : "f"(f37), "f"(f44), "f"(f43));
  // PTX:159 mul.f32 %f46, %f35, %f41
  asm("mul.f32 %0, %1, %2;" : "=f"(f46) : "f"(f35), "f"(f41));
  // PTX:160 fma.rn.f32 %f47, %f32, %f40, %f46
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f47) : "f"(f32), "f"(f40), "f"(f46));
  // PTX:161 fma.rn.f32 %f48, %f38, %f44, %f47
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f48) : "f"(f38), "f"(f44), "f"(f47));
  // PTX:162 mul.f32 %f49, %f36, %f41
  asm("mul.f32 %0, %1, %2;" : "=f"(f49) : "f"(f36), "f"(f41));
  // PTX:163 fma.rn.f32 %f50, %f33, %f40, %f49
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f50) : "f"(f33), "f"(f40), "f"(f49));
  // PTX:164 fma.rn.f32 %f51, %f39, %f44, %f50
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f51) : "f"(f39), "f"(f44), "f"(f50));
  // PTX:165 mov.b32 %f52, %r82
  asm("mov.b32 %0, %1;" : "=f"(f52) : "r"(r82));
  // PTX:166 add.f32 %f53, %f45, %f52
  asm("add.f32 %0, %1, %2;" : "=f"(f53) : "f"(f45), "f"(f52));
  // PTX:167 mov.b32 %f54, %r83
  asm("mov.b32 %0, %1;" : "=f"(f54) : "r"(r83));
  // PTX:168 add.f32 %f55, %f48, %f54
  asm("add.f32 %0, %1, %2;" : "=f"(f55) : "f"(f48), "f"(f54));
  // PTX:169 mov.b32 %f56, %r84
  asm("mov.b32 %0, %1;" : "=f"(f56) : "r"(r84));
  // PTX:170 add.f32 %f57, %f51, %f56
  asm("add.f32 %0, %1, %2;" : "=f"(f57) : "f"(f51), "f"(f56));
  // PTX:171 mov.b32 %r82, %f53
  asm("mov.b32 %0, %1;" : "=r"(r82) : "f"(f53));
  // PTX:172 mov.b32 %r83, %f55
  asm("mov.b32 %0, %1;" : "=r"(r83) : "f"(f55));
  // PTX:173 mov.b32 %r84, %f57
  asm("mov.b32 %0, %1;" : "=r"(r84) : "f"(f57));
  // PTX:175 $L__BB6_12:
L_BB6_12:;
  // PTX:176 add.s32 %r64, %r65, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r64) : "r"(r65));
  // PTX:177 cvt.s64.s32 %rd48, %r64
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd48) : "r"(r64));
  // PTX:178 mul.lo.s64 %rd49, %rd48, %rd26
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd49) : "l"(rd48), "l"(rd26));
  // PTX:179 add.s64 %rd50, %rd49, %rd67
  asm("add.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd49), "l"(rd67));
  // PTX:180 mul.lo.s64 %rd51, %rd50, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd51) : "l"(rd50));
  // PTX:181 add.s64 %rd11, %rd1, %rd51
  asm("add.s64 %0, %1, %2;" : "=l"(rd11) : "l"(rd1), "l"(rd51));
  // PTX:182 ld.global.s32 %rd12, [%rd11]
  rd12 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (0)))));
  // PTX:183 setp.lt.s64 %p11, %rd12, 0
  p11 = (((long long)(rd12)) < ((long long)(0)));
  // PTX:184 setp.ge.u64 %p12, %rd12, %rd26
  p12 = (((unsigned long long)(rd12)) >= ((unsigned long long)(rd26)));
  // PTX:185 or.pred %p13, %p11, %p12
  p13 = ((p11) || (p12));
  // PTX:186 @%p13 bra $L__BB6_15
  if (p13) { goto L_BB6_15; }
  // PTX:188 add.s64 %rd13, %rd7, %rd12
  asm("add.s64 %0, %1, %2;" : "=l"(rd13) : "l"(rd7), "l"(rd12));
  // PTX:189 setp.ge.u64 %p14, %rd13, %rd25
  p14 = (((unsigned long long)(rd13)) >= ((unsigned long long)(rd25)));
  // PTX:190 @%p14 bra $L__BB6_15
  if (p14) { goto L_BB6_15; }
  // PTX:192 ld.global.f32 %f58, [%rd11+4]
  f58 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (4)))));
  // PTX:193 ld.global.f32 %f59, [%rd11+8]
  f59 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (8)))));
  // PTX:194 ld.global.f32 %f60, [%rd11+12]
  f60 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (12)))));
  // PTX:195 ld.global.f32 %f61, [%rd11+16]
  f61 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (16)))));
  // PTX:196 ld.global.f32 %f62, [%rd11+20]
  f62 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (20)))));
  // PTX:197 ld.global.f32 %f63, [%rd11+24]
  f63 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (24)))));
  // PTX:198 ld.global.f32 %f64, [%rd11+28]
  f64 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (28)))));
  // PTX:199 ld.global.f32 %f65, [%rd11+32]
  f65 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (32)))));
  // PTX:200 ld.global.f32 %f66, [%rd11+36]
  f66 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (36)))));
  // PTX:201 mul.lo.s64 %rd52, %rd13, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd52) : "l"(rd13));
  // PTX:202 add.s64 %rd53, %rd2, %rd52
  asm("add.s64 %0, %1, %2;" : "=l"(rd53) : "l"(rd2), "l"(rd52));
  // PTX:203 ld.global.f32 %f67, [%rd53]
  f67 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))));
  // PTX:204 ld.global.f32 %f68, [%rd53+4]
  f68 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (4)))));
  // PTX:205 mul.f32 %f69, %f61, %f68
  asm("mul.f32 %0, %1, %2;" : "=f"(f69) : "f"(f61), "f"(f68));
  // PTX:206 fma.rn.f32 %f70, %f58, %f67, %f69
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f70) : "f"(f58), "f"(f67), "f"(f69));
  // PTX:207 ld.global.f32 %f71, [%rd53+8]
  f71 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (8)))));
  // PTX:208 fma.rn.f32 %f72, %f64, %f71, %f70
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f72) : "f"(f64), "f"(f71), "f"(f70));
  // PTX:209 mul.f32 %f73, %f62, %f68
  asm("mul.f32 %0, %1, %2;" : "=f"(f73) : "f"(f62), "f"(f68));
  // PTX:210 fma.rn.f32 %f74, %f59, %f67, %f73
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f74) : "f"(f59), "f"(f67), "f"(f73));
  // PTX:211 fma.rn.f32 %f75, %f65, %f71, %f74
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f75) : "f"(f65), "f"(f71), "f"(f74));
  // PTX:212 mul.f32 %f76, %f63, %f68
  asm("mul.f32 %0, %1, %2;" : "=f"(f76) : "f"(f63), "f"(f68));
  // PTX:213 fma.rn.f32 %f77, %f60, %f67, %f76
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f77) : "f"(f60), "f"(f67), "f"(f76));
  // PTX:214 fma.rn.f32 %f78, %f66, %f71, %f77
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f78) : "f"(f66), "f"(f71), "f"(f77));
  // PTX:215 mov.b32 %f79, %r82
  asm("mov.b32 %0, %1;" : "=f"(f79) : "r"(r82));
  // PTX:216 add.f32 %f80, %f72, %f79
  asm("add.f32 %0, %1, %2;" : "=f"(f80) : "f"(f72), "f"(f79));
  // PTX:217 mov.b32 %f81, %r83
  asm("mov.b32 %0, %1;" : "=f"(f81) : "r"(r83));
  // PTX:218 add.f32 %f82, %f75, %f81
  asm("add.f32 %0, %1, %2;" : "=f"(f82) : "f"(f75), "f"(f81));
  // PTX:219 mov.b32 %f83, %r84
  asm("mov.b32 %0, %1;" : "=f"(f83) : "r"(r84));
  // PTX:220 add.f32 %f84, %f78, %f83
  asm("add.f32 %0, %1, %2;" : "=f"(f84) : "f"(f78), "f"(f83));
  // PTX:221 mov.b32 %r82, %f80
  asm("mov.b32 %0, %1;" : "=r"(r82) : "f"(f80));
  // PTX:222 mov.b32 %r83, %f82
  asm("mov.b32 %0, %1;" : "=r"(r83) : "f"(f82));
  // PTX:223 mov.b32 %r84, %f84
  asm("mov.b32 %0, %1;" : "=r"(r84) : "f"(f84));
  // PTX:225 $L__BB6_15:
L_BB6_15:;
  // PTX:226 add.s32 %r65, %r65, 2
  asm("add.s32 %0, %1, 2;" : "=r"(r65) : "r"(r65));
  // PTX:227 add.s32 %r69, %r69, -2
  asm("add.s32 %0, %1, -2;" : "=r"(r69) : "r"(r69));
  // PTX:228 setp.ne.s32 %p15, %r69, 0
  p15 = (((int)(r69)) != ((int)(0)));
  // PTX:229 @%p15 bra $L__BB6_9
  if (p15) { goto L_BB6_9; }
  // PTX:231 cvt.s64.s32 %rd68, %r65
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd68) : "r"(r65));
  // PTX:233 $L__BB6_17:
L_BB6_17:;
  // PTX:234 setp.eq.s32 %p16, %r2, 0
  p16 = (((int)(r2)) == ((int)(0)));
  // PTX:235 @%p16 bra $L__BB6_21
  if (p16) { goto L_BB6_21; }
  // PTX:237 mul.lo.s64 %rd54, %rd68, %rd26
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd54) : "l"(rd68), "l"(rd26));
  // PTX:238 add.s64 %rd55, %rd54, %rd67
  asm("add.s64 %0, %1, %2;" : "=l"(rd55) : "l"(rd54), "l"(rd67));
  // PTX:239 mul.lo.s64 %rd56, %rd55, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd56) : "l"(rd55));
  // PTX:240 add.s64 %rd16, %rd1, %rd56
  asm("add.s64 %0, %1, %2;" : "=l"(rd16) : "l"(rd1), "l"(rd56));
  // PTX:241 ld.global.s32 %rd17, [%rd16]
  rd17 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:242 setp.lt.s64 %p17, %rd17, 0
  p17 = (((long long)(rd17)) < ((long long)(0)));
  // PTX:243 setp.ge.u64 %p18, %rd17, %rd26
  p18 = (((unsigned long long)(rd17)) >= ((unsigned long long)(rd26)));
  // PTX:244 or.pred %p19, %p17, %p18
  p19 = ((p17) || (p18));
  // PTX:245 @%p19 bra $L__BB6_21
  if (p19) { goto L_BB6_21; }
  // PTX:247 add.s64 %rd18, %rd7, %rd17
  asm("add.s64 %0, %1, %2;" : "=l"(rd18) : "l"(rd7), "l"(rd17));
  // PTX:248 setp.ge.u64 %p20, %rd18, %rd25
  p20 = (((unsigned long long)(rd18)) >= ((unsigned long long)(rd25)));
  // PTX:249 @%p20 bra $L__BB6_21
  if (p20) { goto L_BB6_21; }
  // PTX:251 ld.global.f32 %f85, [%rd16+4]
  f85 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (4)))));
  // PTX:252 ld.global.f32 %f86, [%rd16+8]
  f86 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (8)))));
  // PTX:253 ld.global.f32 %f87, [%rd16+12]
  f87 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (12)))));
  // PTX:254 ld.global.f32 %f88, [%rd16+16]
  f88 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (16)))));
  // PTX:255 ld.global.f32 %f89, [%rd16+20]
  f89 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (20)))));
  // PTX:256 ld.global.f32 %f90, [%rd16+24]
  f90 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (24)))));
  // PTX:257 ld.global.f32 %f91, [%rd16+28]
  f91 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (28)))));
  // PTX:258 ld.global.f32 %f92, [%rd16+32]
  f92 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (32)))));
  // PTX:259 ld.global.f32 %f93, [%rd16+36]
  f93 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (36)))));
  // PTX:260 mul.lo.s64 %rd57, %rd18, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd57) : "l"(rd18));
  // PTX:261 add.s64 %rd58, %rd2, %rd57
  asm("add.s64 %0, %1, %2;" : "=l"(rd58) : "l"(rd2), "l"(rd57));
  // PTX:262 ld.global.f32 %f94, [%rd58]
  f94 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (0)))));
  // PTX:263 ld.global.f32 %f95, [%rd58+4]
  f95 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (4)))));
  // PTX:264 mul.f32 %f96, %f88, %f95
  asm("mul.f32 %0, %1, %2;" : "=f"(f96) : "f"(f88), "f"(f95));
  // PTX:265 fma.rn.f32 %f97, %f85, %f94, %f96
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f97) : "f"(f85), "f"(f94), "f"(f96));
  // PTX:266 ld.global.f32 %f98, [%rd58+8]
  f98 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (8)))));
  // PTX:267 fma.rn.f32 %f99, %f91, %f98, %f97
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f99) : "f"(f91), "f"(f98), "f"(f97));
  // PTX:268 mul.f32 %f100, %f89, %f95
  asm("mul.f32 %0, %1, %2;" : "=f"(f100) : "f"(f89), "f"(f95));
  // PTX:269 fma.rn.f32 %f101, %f86, %f94, %f100
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f101) : "f"(f86), "f"(f94), "f"(f100));
  // PTX:270 fma.rn.f32 %f102, %f92, %f98, %f101
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f102) : "f"(f92), "f"(f98), "f"(f101));
  // PTX:271 mul.f32 %f103, %f90, %f95
  asm("mul.f32 %0, %1, %2;" : "=f"(f103) : "f"(f90), "f"(f95));
  // PTX:272 fma.rn.f32 %f104, %f87, %f94, %f103
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f104) : "f"(f87), "f"(f94), "f"(f103));
  // PTX:273 fma.rn.f32 %f105, %f93, %f98, %f104
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f105) : "f"(f93), "f"(f98), "f"(f104));
  // PTX:274 mov.b32 %f106, %r82
  asm("mov.b32 %0, %1;" : "=f"(f106) : "r"(r82));
  // PTX:275 add.f32 %f107, %f99, %f106
  asm("add.f32 %0, %1, %2;" : "=f"(f107) : "f"(f99), "f"(f106));
  // PTX:276 mov.b32 %f108, %r83
  asm("mov.b32 %0, %1;" : "=f"(f108) : "r"(r83));
  // PTX:277 add.f32 %f109, %f102, %f108
  asm("add.f32 %0, %1, %2;" : "=f"(f109) : "f"(f102), "f"(f108));
  // PTX:278 mov.b32 %f110, %r84
  asm("mov.b32 %0, %1;" : "=f"(f110) : "r"(r84));
  // PTX:279 add.f32 %f111, %f105, %f110
  asm("add.f32 %0, %1, %2;" : "=f"(f111) : "f"(f105), "f"(f110));
  // PTX:280 mov.b32 %r82, %f107
  asm("mov.b32 %0, %1;" : "=r"(r82) : "f"(f107));
  // PTX:281 mov.b32 %r83, %f109
  asm("mov.b32 %0, %1;" : "=r"(r83) : "f"(f109));
  // PTX:282 mov.b32 %r84, %f111
  asm("mov.b32 %0, %1;" : "=r"(r84) : "f"(f111));
  // PTX:284 $L__BB6_21:
L_BB6_21:;
  // PTX:285 mov.b32 %f112, %r82
  asm("mov.b32 %0, %1;" : "=f"(f112) : "r"(r82));
  // PTX:286 add.f32 %f126, %f1, %f112
  asm("add.f32 %0, %1, %2;" : "=f"(f126) : "f"(f1), "f"(f112));
  // PTX:287 mov.b32 %f113, %r83
  asm("mov.b32 %0, %1;" : "=f"(f113) : "r"(r83));
  // PTX:288 add.f32 %f125, %f2, %f113
  asm("add.f32 %0, %1, %2;" : "=f"(f125) : "f"(f2), "f"(f113));
  // PTX:289 mov.b32 %f114, %r84
  asm("mov.b32 %0, %1;" : "=f"(f114) : "r"(r84));
  // PTX:290 add.f32 %f124, %f3, %f114
  asm("add.f32 %0, %1, %2;" : "=f"(f124) : "f"(f3), "f"(f114));
  // PTX:291 setp.eq.s64 %p21, %rd23, 0
  p21 = (((long long)(rd23)) == ((long long)(0)));
  // PTX:292 @%p21 bra $L__BB6_23
  if (p21) { goto L_BB6_23; }
  // PTX:294 cvta.to.global.u64 %rd59, %rd23
  rd59 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd23));
  // PTX:295 add.s64 %rd61, %rd59, %rd34
  asm("add.s64 %0, %1, %2;" : "=l"(rd61) : "l"(rd59), "l"(rd34));
  // PTX:296 ld.global.f32 %f115, [%rd61]
  f115 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))));
  // PTX:297 add.f32 %f126, %f126, %f115
  asm("add.f32 %0, %1, %2;" : "=f"(f126) : "f"(f126), "f"(f115));
  // PTX:298 ld.global.f32 %f116, [%rd61+4]
  f116 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (4)))));
  // PTX:299 add.f32 %f125, %f125, %f116
  asm("add.f32 %0, %1, %2;" : "=f"(f125) : "f"(f125), "f"(f116));
  // PTX:300 ld.global.f32 %f117, [%rd61+8]
  f117 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (8)))));
  // PTX:301 add.f32 %f124, %f124, %f117
  asm("add.f32 %0, %1, %2;" : "=f"(f124) : "f"(f124), "f"(f117));
  // PTX:303 $L__BB6_23:
L_BB6_23:;
  // PTX:304 cvta.to.global.u64 %rd62, %rd22
  rd62 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd22));
  // PTX:305 add.s64 %rd64, %rd62, %rd34
  asm("add.s64 %0, %1, %2;" : "=l"(rd64) : "l"(rd62), "l"(rd34));
  // PTX:306 ld.global.f32 %f118, [%rd64]
  f118 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (0)))));
  // PTX:307 sub.f32 %f119, %f118, %f126
  asm("sub.f32 %0, %1, %2;" : "=f"(f119) : "f"(f118), "f"(f126));
  // PTX:308 ld.global.f32 %f120, [%rd64+4]
  f120 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (4)))));
  // PTX:309 sub.f32 %f121, %f120, %f125
  asm("sub.f32 %0, %1, %2;" : "=f"(f121) : "f"(f120), "f"(f125));
  // PTX:310 ld.global.f32 %f122, [%rd64+8]
  f122 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (8)))));
  // PTX:311 sub.f32 %f123, %f122, %f124
  asm("sub.f32 %0, %1, %2;" : "=f"(f123) : "f"(f122), "f"(f124));
  // PTX:312 cvta.to.global.u64 %rd65, %rd24
  rd65 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd24));
  // PTX:313 add.s64 %rd66, %rd65, %rd34
  asm("add.s64 %0, %1, %2;" : "=l"(rd66) : "l"(rd65), "l"(rd34));
  // PTX:314 st.global.f32 [%rd66], %f119
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (0))))) = (float)(f119);
  // PTX:315 st.global.f32 [%rd66+4], %f121
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (4))))) = (float)(f121);
  // PTX:316 st.global.f32 [%rd66+8], %f123
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (8))))) = (float)(f123);
  // PTX:318 $L__BB6_24:
L_BB6_24:;
  // PTX:319 ret
  return;
}
