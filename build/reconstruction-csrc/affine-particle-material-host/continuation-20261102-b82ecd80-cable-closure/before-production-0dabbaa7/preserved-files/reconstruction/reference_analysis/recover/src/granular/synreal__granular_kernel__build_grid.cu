// 机械还原自 PTX：synreal::granular_kernel::build_grid(synreal::Model, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, synreal::granular_kernel::View, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, float*, int*, int*, glm::vec<3, int, (glm::qualifier)0>*, int*, int*)
// PTX SHA256: 19365998dbe26140144e933a9dde6035d1bcaa706c2a3a945d9cf4b41092c71d
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__granular_kernel__build_grid(ByVal<1864, 8> param0, unsigned long long param1, unsigned long long param2, ByVal<120, 8> param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10, unsigned long long param11) {
  int p0, p1, p2, p3;
  unsigned short rs0, rs1, rs2, rs3, rs4, rs5, rs6, rs7, rs8;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64;
  // PTX:29 mov.b64 %rd4, _ZN7synreal15granular_kernel10build_gridENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_NS0_4ViewEPS5_S9_PfPiSB_PNS3_ILi3EiLS4_0EEESB_SB__param_0
  rd4 = (unsigned long long)(uintptr_t)&param0;
  // PTX:30 ld.param.u64 %rd5, [_ZN7synreal15granular_kernel10build_gridENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_NS0_4ViewEPS5_S9_PfPiSB_PNS3_ILi3EiLS4_0EEESB_SB__param_1]
  rd5 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:31 ld.param.u64 %rd6, [_ZN7synreal15granular_kernel10build_gridENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_NS0_4ViewEPS5_S9_PfPiSB_PNS3_ILi3EiLS4_0EEESB_SB__param_2]
  rd6 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:32 ld.param.v2.u32 {%r8, %r9}, [_ZN7synreal15granular_kernel10build_gridENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_NS0_4ViewEPS5_S9_PfPiSB_PNS3_ILi3EiLS4_0EEESB_SB__param_3+88]
  r8 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param3 + (88)))); r9 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param3 + (92))));
  // PTX:33 ld.param.v2.f32 {%f6, %f7}, [_ZN7synreal15granular_kernel10build_gridENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_NS0_4ViewEPS5_S9_PfPiSB_PNS3_ILi3EiLS4_0EEESB_SB__param_3+96]
  f6 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param3 + (96)))); f7 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param3 + (100))));
  // PTX:34 ld.param.u64 %rd18, [_ZN7synreal15granular_kernel10build_gridENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_NS0_4ViewEPS5_S9_PfPiSB_PNS3_ILi3EiLS4_0EEESB_SB__param_4]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:35 ld.param.u64 %rd19, [_ZN7synreal15granular_kernel10build_gridENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_NS0_4ViewEPS5_S9_PfPiSB_PNS3_ILi3EiLS4_0EEESB_SB__param_5]
  rd19 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:36 ld.param.u64 %rd20, [_ZN7synreal15granular_kernel10build_gridENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_NS0_4ViewEPS5_S9_PfPiSB_PNS3_ILi3EiLS4_0EEESB_SB__param_6]
  rd20 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:37 ld.param.u64 %rd21, [_ZN7synreal15granular_kernel10build_gridENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_NS0_4ViewEPS5_S9_PfPiSB_PNS3_ILi3EiLS4_0EEESB_SB__param_7]
  rd21 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:38 ld.param.u64 %rd22, [_ZN7synreal15granular_kernel10build_gridENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_NS0_4ViewEPS5_S9_PfPiSB_PNS3_ILi3EiLS4_0EEESB_SB__param_8]
  rd22 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:39 ld.param.u64 %rd23, [_ZN7synreal15granular_kernel10build_gridENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_NS0_4ViewEPS5_S9_PfPiSB_PNS3_ILi3EiLS4_0EEESB_SB__param_9]
  rd23 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:40 ld.param.u64 %rd24, [_ZN7synreal15granular_kernel10build_gridENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_NS0_4ViewEPS5_S9_PfPiSB_PNS3_ILi3EiLS4_0EEESB_SB__param_10]
  rd24 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:41 ld.param.u64 %rd25, [_ZN7synreal15granular_kernel10build_gridENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_NS0_4ViewEPS5_S9_PfPiSB_PNS3_ILi3EiLS4_0EEESB_SB__param_11]
  rd25 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:42 mov.u32 %r10, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r10) : "r"(blockDim.x));
  // PTX:43 mov.u32 %r11, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r11) : "r"(blockIdx.x));
  // PTX:44 mov.u32 %r12, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r12) : "r"(threadIdx.x));
  // PTX:45 mad.lo.s32 %r1, %r11, %r10, %r12
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r1) : "r"(r11), "r"(r10), "r"(r12));
  // PTX:46 setp.ge.s32 %p1, %r1, %r8
  p1 = (((int)(r1)) >= ((int)(r8)));
  // PTX:47 @%p1 bra $L__BB0_5
  if (p1) { goto L_BB0_5; }
  // PTX:49 cvta.to.global.u64 %rd26, %rd21
  rd26 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd21));
  // PTX:50 add.s64 %rd1, %rd4, 272
  asm("add.s64 %0, %1, 272;" : "=l"(rd1) : "l"(rd4));
  // PTX:51 ld.param.u32 %r13, [%rd4+272]
  r13 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)(rd4) + (272))));
  // PTX:52 div.u32 %r42, %r1, %r13
  asm("div.u32 %0, %1, %2;" : "=r"(r42) : "r"(r1), "r"(r13));
  // PTX:53 mul.lo.s32 %r14, %r42, %r13
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r14) : "r"(r42), "r"(r13));
  // PTX:54 sub.s32 %r15, %r1, %r14
  asm("sub.s32 %0, %1, %2;" : "=r"(r15) : "r"(r1), "r"(r14));
  // PTX:55 ld.param.u64 %rd28, [%rd4+280]
  rd28 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (280))));
  // PTX:56 cvta.to.global.u64 %rd29, %rd28
  rd29 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd28));
  // PTX:57 mul.wide.u32 %rd30, %r15, 4
  asm("mul.wide.u32 %0, %1, 4;" : "=l"(rd30) : "r"(r15));
  // PTX:58 add.s64 %rd31, %rd29, %rd30
  asm("add.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd29), "l"(rd30));
  // PTX:59 ld.global.u32 %r16, [%rd31]
  r16 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (0)))));
  // PTX:60 cvt.s64.s32 %rd2, %r16
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd2) : "r"(r16));
  // PTX:61 ld.param.v2.u32 {%r17, %r18}, [%rd4+24]
  r17 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)(rd4) + (24)))); r18 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)(rd4) + (28))));
  // PTX:62 mad.lo.s32 %r3, %r17, %r42, %r16
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r3) : "r"(r17), "r"(r42), "r"(r16));
  // PTX:63 cvt.s64.s32 %rd3, %r1
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd3) : "r"(r1));
  // PTX:64 mul.wide.s32 %rd32, %r1, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd32) : "r"(r1));
  // PTX:65 add.s64 %rd33, %rd26, %rd32
  asm("add.s64 %0, %1, %2;" : "=l"(rd33) : "l"(rd26), "l"(rd32));
  // PTX:66 st.global.u32 [%rd33], %r3
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (0))))) = (unsigned)(r3);
  // PTX:67 ld.param.u32 %r21, [%rd4+24]
  r21 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)(rd4) + (24))));
  // PTX:68 setp.gt.u32 %p2, %r18, %r21
  p2 = (((unsigned)(r18)) > ((unsigned)(r21)));
  // PTX:69 @%p2 bra $L__BB0_4
  if (p2) { goto L_BB0_4; }
  // PTX:71 ld.param.u64 %rd34, [%rd1+-144]
  rd34 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd1) + (-144))));
  // PTX:72 setp.eq.s64 %p3, %rd34, 0
  p3 = (((long long)(rd34)) == ((long long)(0)));
  // PTX:73 mov.u32 %r42, 0
  asm("mov.u32 %0, 0;" : "=r"(r42) : );
  // PTX:74 @%p3 bra $L__BB0_4
  if (p3) { goto L_BB0_4; }
  // PTX:76 ld.param.u64 %rd35, [%rd1+-152]
  rd35 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd1) + (-152))));
  // PTX:77 cvta.to.global.u64 %rd36, %rd35
  rd36 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd35));
  // PTX:78 shl.b64 %rd37, %rd2, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd37) : "l"(rd2));
  // PTX:79 add.s64 %rd38, %rd36, %rd37
  asm("add.s64 %0, %1, %2;" : "=l"(rd38) : "l"(rd36), "l"(rd37));
  // PTX:80 ld.global.u32 %r23, [%rd38]
  r23 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (0)))));
  // PTX:81 max.s32 %r42, %r23, 0
  asm("max.s32 %0, %1, 0;" : "=r"(r42) : "r"(r23));
  // PTX:83 $L__BB0_4:
L_BB0_4:;
  // PTX:84 cvta.to.global.u64 %rd39, %rd22
  rd39 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd22));
  // PTX:85 shl.b64 %rd40, %rd3, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd40) : "l"(rd3));
  // PTX:86 add.s64 %rd41, %rd39, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd41) : "l"(rd39), "l"(rd40));
  // PTX:87 st.global.u32 [%rd41], %r42
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (0))))) = (unsigned)(r42);
  // PTX:88 cvta.to.global.u64 %rd42, %rd5
  rd42 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd5));
  // PTX:89 mul.wide.u32 %rd43, %r3, 12
  asm("mul.wide.u32 %0, %1, 12;" : "=l"(rd43) : "r"(r3));
  // PTX:90 add.s64 %rd44, %rd42, %rd43
  asm("add.s64 %0, %1, %2;" : "=l"(rd44) : "l"(rd42), "l"(rd43));
  // PTX:91 ld.global.u32 %r24, [%rd44]
  r24 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))));
  // PTX:92 ld.global.u32 %r25, [%rd44+4]
  r25 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (4)))));
  // PTX:93 ld.global.u32 %r26, [%rd44+8]
  r26 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (8)))));
  // PTX:94 cvta.to.global.u64 %rd45, %rd18
  rd45 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd18));
  // PTX:95 mul.lo.s64 %rd46, %rd3, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd46) : "l"(rd3));
  // PTX:96 add.s64 %rd47, %rd45, %rd46
  asm("add.s64 %0, %1, %2;" : "=l"(rd47) : "l"(rd45), "l"(rd46));
  // PTX:97 st.global.u32 [%rd47], %r24
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0))))) = (unsigned)(r24);
  // PTX:98 st.global.u32 [%rd47+4], %r25
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (4))))) = (unsigned)(r25);
  // PTX:99 st.global.u32 [%rd47+8], %r26
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (8))))) = (unsigned)(r26);
  // PTX:100 cvta.to.global.u64 %rd48, %rd6
  rd48 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd6));
  // PTX:101 add.s64 %rd49, %rd48, %rd43
  asm("add.s64 %0, %1, %2;" : "=l"(rd49) : "l"(rd48), "l"(rd43));
  // PTX:102 ld.global.u32 %r27, [%rd49]
  r27 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))));
  // PTX:103 ld.global.u32 %r28, [%rd49+4]
  r28 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (4)))));
  // PTX:104 ld.global.u32 %r29, [%rd49+8]
  r29 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (8)))));
  // PTX:105 cvta.to.global.u64 %rd50, %rd19
  rd50 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd19));
  // PTX:106 add.s64 %rd51, %rd50, %rd46
  asm("add.s64 %0, %1, %2;" : "=l"(rd51) : "l"(rd50), "l"(rd46));
  // PTX:107 st.global.u32 [%rd51], %r27
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0))))) = (unsigned)(r27);
  // PTX:108 st.global.u32 [%rd51+4], %r28
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (4))))) = (unsigned)(r28);
  // PTX:109 st.global.u32 [%rd51+8], %r29
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (8))))) = (unsigned)(r29);
  // PTX:110 cvt.u32.u64 %r30, %rd2
  asm("cvt.u32.u64 %0, %1;" : "=r"(r30) : "l"(rd2));
  // PTX:111 ld.param.u64 %rd52, [%rd1+-136]
  rd52 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd1) + (-136))));
  // PTX:112 cvta.to.global.u64 %rd53, %rd52
  rd53 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd52));
  // PTX:113 mul.wide.s32 %rd54, %r30, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd54) : "r"(r30));
  // PTX:114 add.s64 %rd55, %rd53, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd55) : "l"(rd53), "l"(rd54));
  // PTX:115 ld.global.f32 %f10, [%rd55]
  f10 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))));
  // PTX:116 cvta.to.global.u64 %rd56, %rd20
  rd56 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd20));
  // PTX:117 add.s64 %rd57, %rd56, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd57) : "l"(rd56), "l"(rd40));
  // PTX:118 st.global.f32 [%rd57], %f10
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0))))) = (float)(f10);
  // PTX:119 ld.global.f32 %f11, [%rd47]
  f11 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))));
  // PTX:120 div.rn.f32 %f12, %f11, %f6
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f12) : "f"(f11), "f"(f6));
  // PTX:121 cvt.rmi.f32.f32 %f13, %f12
  asm("cvt.rmi.f32.f32 %0, %1;" : "=f"(f13) : "f"(f12));
  // PTX:122 cvt.rzi.s32.f32 %r31, %f13
  asm("cvt.rzi.s32.f32 %0, %1;" : "=r"(r31) : "f"(f13));
  // PTX:123 ld.global.f32 %f14, [%rd47+4]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (4)))));
  // PTX:124 div.rn.f32 %f15, %f14, %f6
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f15) : "f"(f14), "f"(f6));
  // PTX:125 cvt.rmi.f32.f32 %f16, %f15
  asm("cvt.rmi.f32.f32 %0, %1;" : "=f"(f16) : "f"(f15));
  // PTX:126 cvt.rzi.s32.f32 %r32, %f16
  asm("cvt.rzi.s32.f32 %0, %1;" : "=r"(r32) : "f"(f16));
  // PTX:127 ld.global.f32 %f17, [%rd47+8]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (8)))));
  // PTX:128 div.rn.f32 %f18, %f17, %f6
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f18) : "f"(f17), "f"(f6));
  // PTX:129 cvt.rmi.f32.f32 %f19, %f18
  asm("cvt.rmi.f32.f32 %0, %1;" : "=f"(f19) : "f"(f18));
  // PTX:130 cvt.rzi.s32.f32 %r33, %f19
  asm("cvt.rzi.s32.f32 %0, %1;" : "=r"(r33) : "f"(f19));
  // PTX:131 cvta.to.global.u64 %rd58, %rd23
  rd58 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd23));
  // PTX:132 add.s64 %rd59, %rd58, %rd46
  asm("add.s64 %0, %1, %2;" : "=l"(rd59) : "l"(rd58), "l"(rd46));
  // PTX:133 st.global.u32 [%rd59], %r31
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0))))) = (unsigned)(r31);
  // PTX:134 st.global.u32 [%rd59+4], %r32
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (4))))) = (unsigned)(r32);
  // PTX:135 st.global.u32 [%rd59+8], %r33
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (8))))) = (unsigned)(r33);
  // PTX:136 mul.lo.s32 %r34, %r31, 73856093
  asm("mul.lo.s32 %0, %1, 73856093;" : "=r"(r34) : "r"(r31));
  // PTX:137 mul.lo.s32 %r35, %r32, 19349663
  asm("mul.lo.s32 %0, %1, 19349663;" : "=r"(r35) : "r"(r32));
  // PTX:138 xor.b32 %r36, %r35, %r34
  asm("xor.b32 %0, %1, %2;" : "=r"(r36) : "r"(r35), "r"(r34));
  // PTX:139 mul.lo.s32 %r37, %r33, 83492791
  asm("mul.lo.s32 %0, %1, 83492791;" : "=r"(r37) : "r"(r33));
  // PTX:140 xor.b32 %r38, %r36, %r37
  asm("xor.b32 %0, %1, %2;" : "=r"(r38) : "r"(r36), "r"(r37));
  // PTX:141 add.s32 %r39, %r9, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r39) : "r"(r9));
  // PTX:142 and.b32 %r40, %r38, %r39
  asm("and.b32 %0, %1, %2;" : "=r"(r40) : "r"(r38), "r"(r39));
  // PTX:143 cvta.to.global.u64 %rd60, %rd24
  rd60 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd24));
  // PTX:144 mul.wide.s32 %rd61, %r40, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd61) : "r"(r40));
  // PTX:145 add.s64 %rd62, %rd60, %rd61
  asm("add.s64 %0, %1, %2;" : "=l"(rd62) : "l"(rd60), "l"(rd61));
  // PTX:146 atom.global.exch.b32 %r41, [%rd62], %r1
  r41 = atomicExch(reinterpret_cast<unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))), (unsigned)(r1));
  // PTX:147 cvta.to.global.u64 %rd63, %rd25
  rd63 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd25));
  // PTX:148 add.s64 %rd64, %rd63, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd64) : "l"(rd63), "l"(rd40));
  // PTX:149 st.global.u32 [%rd64], %r41
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (0))))) = (unsigned)(r41);
  // PTX:151 $L__BB0_5:
L_BB0_5:;
  // PTX:152 ret
  return;
}
