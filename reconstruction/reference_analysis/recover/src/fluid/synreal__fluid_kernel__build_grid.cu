// 机械还原自 PTX：synreal::fluid_kernel::build_grid(synreal::Model, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, float*, int*, int*, glm::vec<3, int, (glm::qualifier)0>*, int*, int*, int, int)
// PTX SHA256: 99ebeed0e6fadb061831f0d284666867ed9ee712cda09b1ae0aca815b65931a5
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__fluid_kernel__build_grid(ByVal<1864, 8> param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned param9, unsigned param10) {
  int p0, p1, p2, p3, p4, p5;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55;
  // PTX:27 mov.b64 %rd7, _ZN7synreal12fluid_kernel10build_gridENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5_PfPiSA_PNS3_ILi3EiLS4_0EEESA_SA_ii_param_0
  rd7 = (unsigned long long)(uintptr_t)&param0;
  // PTX:28 ld.param.u64 %rd8, [_ZN7synreal12fluid_kernel10build_gridENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5_PfPiSA_PNS3_ILi3EiLS4_0EEESA_SA_ii_param_1]
  rd8 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:29 ld.param.u64 %rd9, [_ZN7synreal12fluid_kernel10build_gridENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5_PfPiSA_PNS3_ILi3EiLS4_0EEESA_SA_ii_param_2]
  rd9 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:30 ld.param.u64 %rd10, [_ZN7synreal12fluid_kernel10build_gridENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5_PfPiSA_PNS3_ILi3EiLS4_0EEESA_SA_ii_param_3]
  rd10 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:31 ld.param.u64 %rd11, [_ZN7synreal12fluid_kernel10build_gridENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5_PfPiSA_PNS3_ILi3EiLS4_0EEESA_SA_ii_param_4]
  rd11 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:32 ld.param.u64 %rd12, [_ZN7synreal12fluid_kernel10build_gridENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5_PfPiSA_PNS3_ILi3EiLS4_0EEESA_SA_ii_param_5]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:33 ld.param.u64 %rd13, [_ZN7synreal12fluid_kernel10build_gridENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5_PfPiSA_PNS3_ILi3EiLS4_0EEESA_SA_ii_param_6]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:34 ld.param.u64 %rd14, [_ZN7synreal12fluid_kernel10build_gridENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5_PfPiSA_PNS3_ILi3EiLS4_0EEESA_SA_ii_param_7]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:35 ld.param.u64 %rd15, [_ZN7synreal12fluid_kernel10build_gridENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5_PfPiSA_PNS3_ILi3EiLS4_0EEESA_SA_ii_param_8]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:36 ld.param.u32 %r8, [_ZN7synreal12fluid_kernel10build_gridENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5_PfPiSA_PNS3_ILi3EiLS4_0EEESA_SA_ii_param_9]
  r8 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param9 + (0))));
  // PTX:37 ld.param.u32 %r7, [_ZN7synreal12fluid_kernel10build_gridENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPS5_PfPiSA_PNS3_ILi3EiLS4_0EEESA_SA_ii_param_10]
  r7 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param10 + (0))));
  // PTX:38 mov.u32 %r9, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r9) : "r"(blockDim.x));
  // PTX:39 mov.u32 %r10, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r10) : "r"(blockIdx.x));
  // PTX:40 mov.u32 %r11, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r11) : "r"(threadIdx.x));
  // PTX:41 mad.lo.s32 %r1, %r10, %r9, %r11
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r1) : "r"(r10), "r"(r9), "r"(r11));
  // PTX:42 setp.ge.s32 %p1, %r1, %r8
  p1 = (((int)(r1)) >= ((int)(r8)));
  // PTX:43 @%p1 bra $L__BB0_8
  if (p1) { goto L_BB0_8; }
  // PTX:45 add.s64 %rd1, %rd7, 192
  asm("add.s64 %0, %1, 192;" : "=l"(rd1) : "l"(rd7));
  // PTX:46 ld.param.u32 %r12, [%rd7+232]
  r12 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)(rd7) + (232))));
  // PTX:47 ld.param.u32 %r2, [%rd7+192]
  r2 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)(rd7) + (192))));
  // PTX:48 add.s32 %r13, %r12, %r2
  asm("add.s32 %0, %1, %2;" : "=r"(r13) : "r"(r12), "r"(r2));
  // PTX:49 div.u32 %r50, %r1, %r13
  asm("div.u32 %0, %1, %2;" : "=r"(r50) : "r"(r1), "r"(r13));
  // PTX:50 mul.lo.s32 %r14, %r50, %r13
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r14) : "r"(r50), "r"(r13));
  // PTX:51 sub.s32 %r4, %r1, %r14
  asm("sub.s32 %0, %1, %2;" : "=r"(r4) : "r"(r1), "r"(r14));
  // PTX:52 setp.lt.u32 %p2, %r4, %r2
  p2 = (((unsigned)(r4)) < ((unsigned)(r2)));
  // PTX:53 cvta.to.global.u64 %rd17, %rd11
  rd17 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd11));
  // PTX:54 mul.wide.s32 %rd18, %r1, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd18) : "r"(r1));
  // PTX:55 add.s64 %rd2, %rd17, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd2) : "l"(rd17), "l"(rd18));
  // PTX:56 cvta.to.global.u64 %rd19, %rd12
  rd19 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd12));
  // PTX:57 add.s64 %rd3, %rd19, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd3) : "l"(rd19), "l"(rd18));
  // PTX:58 cvta.to.global.u64 %rd20, %rd9
  rd20 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd9));
  // PTX:59 mul.wide.s32 %rd21, %r1, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd21) : "r"(r1));
  // PTX:60 add.s64 %rd4, %rd20, %rd21
  asm("add.s64 %0, %1, %2;" : "=l"(rd4) : "l"(rd20), "l"(rd21));
  // PTX:61 cvta.to.global.u64 %rd22, %rd10
  rd22 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd10));
  // PTX:62 add.s64 %rd5, %rd22, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd5) : "l"(rd22), "l"(rd18));
  // PTX:63 @%p2 bra $L__BB0_3
  if (p2) { goto L_BB0_3; }
  // PTX:64 bra.uni $L__BB0_2
  goto L_BB0_2;
  // PTX:66 $L__BB0_3:
L_BB0_3:;
  // PTX:67 ld.param.u64 %rd31, [%rd1+8]
  rd31 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd1) + (8))));
  // PTX:68 cvta.to.global.u64 %rd32, %rd31
  rd32 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd31));
  // PTX:69 mul.wide.u32 %rd33, %r4, 4
  asm("mul.wide.u32 %0, %1, 4;" : "=l"(rd33) : "r"(r4));
  // PTX:70 add.s64 %rd34, %rd32, %rd33
  asm("add.s64 %0, %1, %2;" : "=l"(rd34) : "l"(rd32), "l"(rd33));
  // PTX:71 ld.global.u32 %r25, [%rd34]
  r25 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (0)))));
  // PTX:72 cvt.s64.s32 %rd6, %r25
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd6) : "r"(r25));
  // PTX:73 ld.param.v2.u32 {%r26, %r27}, [%rd1+-168]
  r26 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)(rd1) + (-168)))); r27 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)(rd1) + (-164))));
  // PTX:74 mad.lo.s32 %r30, %r26, %r50, %r25
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r30) : "r"(r26), "r"(r50), "r"(r25));
  // PTX:75 st.global.u32 [%rd2], %r30
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (0))))) = (unsigned)(r30);
  // PTX:76 ld.param.u32 %r31, [%rd1+-168]
  r31 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)(rd1) + (-168))));
  // PTX:77 setp.gt.u32 %p4, %r27, %r31
  p4 = (((unsigned)(r27)) > ((unsigned)(r31)));
  // PTX:78 @%p4 bra $L__BB0_6
  if (p4) { goto L_BB0_6; }
  // PTX:80 ld.param.u64 %rd35, [%rd1+-64]
  rd35 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd1) + (-64))));
  // PTX:81 setp.eq.s64 %p5, %rd35, 0
  p5 = (((long long)(rd35)) == ((long long)(0)));
  // PTX:82 mov.u32 %r50, 0
  asm("mov.u32 %0, 0;" : "=r"(r50) : );
  // PTX:83 @%p5 bra $L__BB0_6
  if (p5) { goto L_BB0_6; }
  // PTX:85 ld.param.u64 %rd36, [%rd1+-72]
  rd36 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd1) + (-72))));
  // PTX:86 cvta.to.global.u64 %rd37, %rd36
  rd37 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd36));
  // PTX:87 shl.b64 %rd38, %rd6, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd38) : "l"(rd6));
  // PTX:88 add.s64 %rd39, %rd37, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd39) : "l"(rd37), "l"(rd38));
  // PTX:89 ld.global.u32 %r33, [%rd39]
  r33 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (0)))));
  // PTX:90 max.s32 %r50, %r33, 0
  asm("max.s32 %0, %1, 0;" : "=r"(r50) : "r"(r33));
  // PTX:92 $L__BB0_6:
L_BB0_6:;
  // PTX:93 st.global.u32 [%rd3], %r50
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd3) + (0))))) = (unsigned)(r50);
  // PTX:94 ld.global.u32 %r34, [%rd2]
  r34 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (0)))));
  // PTX:95 cvta.to.global.u64 %rd40, %rd8
  rd40 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd8));
  // PTX:96 mul.wide.s32 %rd41, %r34, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd41) : "r"(r34));
  // PTX:97 add.s64 %rd42, %rd40, %rd41
  asm("add.s64 %0, %1, %2;" : "=l"(rd42) : "l"(rd40), "l"(rd41));
  // PTX:98 ld.global.u32 %r35, [%rd42]
  r35 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (0)))));
  // PTX:99 ld.global.u32 %r36, [%rd42+4]
  r36 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (4)))));
  // PTX:100 ld.global.u32 %r37, [%rd42+8]
  r37 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (8)))));
  // PTX:101 st.global.u32 [%rd4], %r35
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd4) + (0))))) = (unsigned)(r35);
  // PTX:102 st.global.u32 [%rd4+4], %r36
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd4) + (4))))) = (unsigned)(r36);
  // PTX:103 st.global.u32 [%rd4+8], %r37
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd4) + (8))))) = (unsigned)(r37);
  // PTX:104 cvt.u32.u64 %r38, %rd6
  asm("cvt.u32.u64 %0, %1;" : "=r"(r38) : "l"(rd6));
  // PTX:105 ld.param.u64 %rd43, [%rd1+-144]
  rd43 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd1) + (-144))));
  // PTX:106 cvta.to.global.u64 %rd44, %rd43
  rd44 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd43));
  // PTX:107 mul.wide.s32 %rd45, %r38, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd45) : "r"(r38));
  // PTX:108 add.s64 %rd46, %rd44, %rd45
  asm("add.s64 %0, %1, %2;" : "=l"(rd46) : "l"(rd44), "l"(rd45));
  // PTX:109 ld.param.f32 %f2, [%rd1+24]
  f2 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd1) + (24))));
  // PTX:110 ld.global.f32 %f3, [%rd46]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (0)))));
  // PTX:111 div.rn.f32 %f4, %f3, %f2
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f4) : "f"(f3), "f"(f2));
  // PTX:112 st.global.f32 [%rd5], %f4
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (0))))) = (float)(f4);
  // PTX:113 bra.uni $L__BB0_7
  goto L_BB0_7;
  // PTX:115 $L__BB0_2:
L_BB0_2:;
  // PTX:116 sub.s32 %r15, %r4, %r2
  asm("sub.s32 %0, %1, %2;" : "=r"(r15) : "r"(r4), "r"(r2));
  // PTX:117 mov.u32 %r16, -1
  asm("mov.u32 %0, -1;" : "=r"(r16) : );
  // PTX:118 st.global.u32 [%rd2], %r16
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (0))))) = (unsigned)(r16);
  // PTX:119 ld.param.v2.u32 {%r17, %r18}, [%rd1+-168]
  r17 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)(rd1) + (-168)))); r18 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)(rd1) + (-164))));
  // PTX:120 setp.gt.u32 %p3, %r18, %r17
  p3 = (((unsigned)(r18)) > ((unsigned)(r17)));
  // PTX:121 selp.b32 %r21, %r50, -1, %p3
  r21 = p3 ? r50 : -1;
  // PTX:122 st.global.u32 [%rd3], %r21
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd3) + (0))))) = (unsigned)(r21);
  // PTX:123 ld.param.u64 %rd23, [%rd1+48]
  rd23 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd1) + (48))));
  // PTX:124 cvta.to.global.u64 %rd24, %rd23
  rd24 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd23));
  // PTX:125 mul.wide.u32 %rd25, %r15, 12
  asm("mul.wide.u32 %0, %1, 12;" : "=l"(rd25) : "r"(r15));
  // PTX:126 add.s64 %rd26, %rd24, %rd25
  asm("add.s64 %0, %1, %2;" : "=l"(rd26) : "l"(rd24), "l"(rd25));
  // PTX:127 ld.global.u32 %r22, [%rd26]
  r22 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (0)))));
  // PTX:128 ld.global.u32 %r23, [%rd26+4]
  r23 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (4)))));
  // PTX:129 ld.global.u32 %r24, [%rd26+8]
  r24 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (8)))));
  // PTX:130 st.global.u32 [%rd4], %r22
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd4) + (0))))) = (unsigned)(r22);
  // PTX:131 st.global.u32 [%rd4+4], %r23
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd4) + (4))))) = (unsigned)(r23);
  // PTX:132 st.global.u32 [%rd4+8], %r24
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd4) + (8))))) = (unsigned)(r24);
  // PTX:133 ld.param.u64 %rd27, [%rd1+64]
  rd27 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd1) + (64))));
  // PTX:134 cvta.to.global.u64 %rd28, %rd27
  rd28 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd27));
  // PTX:135 mul.wide.u32 %rd29, %r15, 4
  asm("mul.wide.u32 %0, %1, 4;" : "=l"(rd29) : "r"(r15));
  // PTX:136 add.s64 %rd30, %rd28, %rd29
  asm("add.s64 %0, %1, %2;" : "=l"(rd30) : "l"(rd28), "l"(rd29));
  // PTX:137 ld.global.f32 %f1, [%rd30]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0)))));
  // PTX:138 st.global.f32 [%rd5], %f1
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (0))))) = (float)(f1);
  // PTX:140 $L__BB0_7:
L_BB0_7:;
  // PTX:141 ld.param.f32 %f5, [%rd1+28]
  f5 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd1) + (28))));
  // PTX:142 ld.global.f32 %f6, [%rd4]
  f6 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd4) + (0)))));
  // PTX:143 div.rn.f32 %f7, %f6, %f5
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f7) : "f"(f6), "f"(f5));
  // PTX:144 cvt.rmi.f32.f32 %f8, %f7
  asm("cvt.rmi.f32.f32 %0, %1;" : "=f"(f8) : "f"(f7));
  // PTX:145 cvt.rzi.s32.f32 %r39, %f8
  asm("cvt.rzi.s32.f32 %0, %1;" : "=r"(r39) : "f"(f8));
  // PTX:146 ld.global.f32 %f9, [%rd4+4]
  f9 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd4) + (4)))));
  // PTX:147 div.rn.f32 %f10, %f9, %f5
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f10) : "f"(f9), "f"(f5));
  // PTX:148 cvt.rmi.f32.f32 %f11, %f10
  asm("cvt.rmi.f32.f32 %0, %1;" : "=f"(f11) : "f"(f10));
  // PTX:149 cvt.rzi.s32.f32 %r40, %f11
  asm("cvt.rzi.s32.f32 %0, %1;" : "=r"(r40) : "f"(f11));
  // PTX:150 ld.global.f32 %f12, [%rd4+8]
  f12 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd4) + (8)))));
  // PTX:151 div.rn.f32 %f13, %f12, %f5
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f13) : "f"(f12), "f"(f5));
  // PTX:152 cvt.rmi.f32.f32 %f14, %f13
  asm("cvt.rmi.f32.f32 %0, %1;" : "=f"(f14) : "f"(f13));
  // PTX:153 cvt.rzi.s32.f32 %r41, %f14
  asm("cvt.rzi.s32.f32 %0, %1;" : "=r"(r41) : "f"(f14));
  // PTX:154 cvta.to.global.u64 %rd47, %rd13
  rd47 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd13));
  // PTX:155 add.s64 %rd49, %rd47, %rd21
  asm("add.s64 %0, %1, %2;" : "=l"(rd49) : "l"(rd47), "l"(rd21));
  // PTX:156 st.global.u32 [%rd49], %r39
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0))))) = (unsigned)(r39);
  // PTX:157 st.global.u32 [%rd49+4], %r40
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (4))))) = (unsigned)(r40);
  // PTX:158 st.global.u32 [%rd49+8], %r41
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (8))))) = (unsigned)(r41);
  // PTX:159 mul.lo.s32 %r42, %r39, 73856093
  asm("mul.lo.s32 %0, %1, 73856093;" : "=r"(r42) : "r"(r39));
  // PTX:160 mul.lo.s32 %r43, %r40, 19349663
  asm("mul.lo.s32 %0, %1, 19349663;" : "=r"(r43) : "r"(r40));
  // PTX:161 xor.b32 %r44, %r43, %r42
  asm("xor.b32 %0, %1, %2;" : "=r"(r44) : "r"(r43), "r"(r42));
  // PTX:162 mul.lo.s32 %r45, %r41, 83492791
  asm("mul.lo.s32 %0, %1, 83492791;" : "=r"(r45) : "r"(r41));
  // PTX:163 xor.b32 %r46, %r44, %r45
  asm("xor.b32 %0, %1, %2;" : "=r"(r46) : "r"(r44), "r"(r45));
  // PTX:164 add.s32 %r47, %r7, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r47) : "r"(r7));
  // PTX:165 and.b32 %r48, %r46, %r47
  asm("and.b32 %0, %1, %2;" : "=r"(r48) : "r"(r46), "r"(r47));
  // PTX:166 cvta.to.global.u64 %rd50, %rd14
  rd50 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd14));
  // PTX:167 mul.wide.s32 %rd51, %r48, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd51) : "r"(r48));
  // PTX:168 add.s64 %rd52, %rd50, %rd51
  asm("add.s64 %0, %1, %2;" : "=l"(rd52) : "l"(rd50), "l"(rd51));
  // PTX:169 atom.global.exch.b32 %r49, [%rd52], %r1
  r49 = atomicExch(reinterpret_cast<unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))), (unsigned)(r1));
  // PTX:170 cvta.to.global.u64 %rd53, %rd15
  rd53 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd15));
  // PTX:171 add.s64 %rd55, %rd53, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd55) : "l"(rd53), "l"(rd18));
  // PTX:172 st.global.u32 [%rd55], %r49
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0))))) = (unsigned)(r49);
  // PTX:174 $L__BB0_8:
L_BB0_8:;
  // PTX:175 ret
  return;
}
