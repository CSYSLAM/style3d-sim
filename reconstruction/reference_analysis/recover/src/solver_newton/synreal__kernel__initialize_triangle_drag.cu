// 机械还原自 PTX：synreal::kernel::initialize_triangle_drag(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, float*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: d322e6067d2e100c7663cf8bb77b0e3f97d967232d4532a55fe64c4f3c3b4bd9
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__initialize_triangle_drag(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6) {
  int p0, p1, p2, p3;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38;
  // PTX:23 ld.param.u64 %rd8, [_ZN7synreal6kernel24initialize_triangle_dragEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPS4_Pfmmm_param_0]
  rd8 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:24 ld.param.u64 %rd9, [_ZN7synreal6kernel24initialize_triangle_dragEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPS4_Pfmmm_param_1]
  rd9 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:25 ld.param.u64 %rd10, [_ZN7synreal6kernel24initialize_triangle_dragEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPS4_Pfmmm_param_2]
  rd10 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:26 ld.param.u64 %rd11, [_ZN7synreal6kernel24initialize_triangle_dragEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPS4_Pfmmm_param_3]
  rd11 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:27 ld.param.u64 %rd14, [_ZN7synreal6kernel24initialize_triangle_dragEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPS4_Pfmmm_param_4]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:28 ld.param.u64 %rd12, [_ZN7synreal6kernel24initialize_triangle_dragEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPS4_Pfmmm_param_5]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:29 ld.param.u64 %rd13, [_ZN7synreal6kernel24initialize_triangle_dragEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPS4_Pfmmm_param_6]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:30 mov.u32 %r7, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r7) : "r"(blockIdx.x));
  // PTX:31 mov.u32 %r8, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r8) : "r"(blockDim.x));
  // PTX:32 mul.wide.u32 %rd15, %r7, %r8
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd15) : "r"(r7), "r"(r8));
  // PTX:33 mov.u32 %r9, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r9) : "r"(threadIdx.x));
  // PTX:34 cvt.u64.u32 %rd16, %r9
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd16) : "r"(r9));
  // PTX:35 add.s64 %rd1, %rd15, %rd16
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd15), "l"(rd16));
  // PTX:36 setp.ge.u64 %p1, %rd1, %rd14
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd14)));
  // PTX:37 @%p1 bra $L__BB39_7
  if (p1) { goto L_BB39_7; }
  // PTX:39 or.b64 %rd17, %rd1, %rd12
  asm("or.b64 %0, %1, %2;" : "=l"(rd17) : "l"(rd1), "l"(rd12));
  // PTX:40 and.b64 %rd18, %rd17, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd18) : "l"(rd17));
  // PTX:41 setp.eq.s64 %p2, %rd18, 0
  p2 = (((long long)(rd18)) == ((long long)(0)));
  // PTX:42 @%p2 bra $L__BB39_3
  if (p2) { goto L_BB39_3; }
  // PTX:44 div.u64 %rd37, %rd1, %rd12
  asm("div.u64 %0, %1, %2;" : "=l"(rd37) : "l"(rd1), "l"(rd12));
  // PTX:45 mul.lo.s64 %rd19, %rd37, %rd12
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd37), "l"(rd12));
  // PTX:46 sub.s64 %rd38, %rd1, %rd19
  asm("sub.s64 %0, %1, %2;" : "=l"(rd38) : "l"(rd1), "l"(rd19));
  // PTX:47 bra.uni $L__BB39_4
  goto L_BB39_4;
  // PTX:49 $L__BB39_3:
L_BB39_3:;
  // PTX:50 cvt.u32.u64 %r10, %rd12
  asm("cvt.u32.u64 %0, %1;" : "=r"(r10) : "l"(rd12));
  // PTX:51 cvt.u32.u64 %r11, %rd1
  asm("cvt.u32.u64 %0, %1;" : "=r"(r11) : "l"(rd1));
  // PTX:52 div.u32 %r12, %r11, %r10
  asm("div.u32 %0, %1, %2;" : "=r"(r12) : "r"(r11), "r"(r10));
  // PTX:53 mul.lo.s32 %r13, %r12, %r10
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r13) : "r"(r12), "r"(r10));
  // PTX:54 sub.s32 %r14, %r11, %r13
  asm("sub.s32 %0, %1, %2;" : "=r"(r14) : "r"(r11), "r"(r13));
  // PTX:55 cvt.u64.u32 %rd37, %r12
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd37) : "r"(r12));
  // PTX:56 cvt.u64.u32 %rd38, %r14
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd38) : "r"(r14));
  // PTX:58 $L__BB39_4:
L_BB39_4:;
  // PTX:59 cvta.to.global.u64 %rd20, %rd8
  rd20 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd8));
  // PTX:60 cvta.to.global.u64 %rd21, %rd9
  rd21 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd9));
  // PTX:61 mul.lo.s64 %rd22, %rd38, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd22) : "l"(rd38));
  // PTX:62 add.s64 %rd23, %rd21, %rd22
  asm("add.s64 %0, %1, %2;" : "=l"(rd23) : "l"(rd21), "l"(rd22));
  // PTX:63 mul.lo.s64 %rd24, %rd37, %rd13
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd24) : "l"(rd37), "l"(rd13));
  // PTX:64 cvt.u32.u64 %r18, %rd24
  asm("cvt.u32.u64 %0, %1;" : "=r"(r18) : "l"(rd24));
  // PTX:65 ld.global.u32 %r19, [%rd23]
  r19 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (0)))));
  // PTX:66 add.s32 %r20, %r19, %r18
  asm("add.s32 %0, %1, %2;" : "=r"(r20) : "r"(r19), "r"(r18));
  // PTX:67 ld.global.u32 %r21, [%rd23+4]
  r21 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (4)))));
  // PTX:68 add.s32 %r22, %r21, %r18
  asm("add.s32 %0, %1, %2;" : "=r"(r22) : "r"(r21), "r"(r18));
  // PTX:69 ld.global.u32 %r23, [%rd23+8]
  r23 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (8)))));
  // PTX:70 add.s32 %r24, %r23, %r18
  asm("add.s32 %0, %1, %2;" : "=r"(r24) : "r"(r23), "r"(r18));
  // PTX:71 mul.wide.s32 %rd25, %r22, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd25) : "r"(r22));
  // PTX:72 add.s64 %rd26, %rd20, %rd25
  asm("add.s64 %0, %1, %2;" : "=l"(rd26) : "l"(rd20), "l"(rd25));
  // PTX:73 mul.wide.s32 %rd27, %r20, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd27) : "r"(r20));
  // PTX:74 add.s64 %rd28, %rd20, %rd27
  asm("add.s64 %0, %1, %2;" : "=l"(rd28) : "l"(rd20), "l"(rd27));
  // PTX:75 ld.global.f32 %f5, [%rd28]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (0)))));
  // PTX:76 ld.global.f32 %f6, [%rd26]
  f6 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (0)))));
  // PTX:77 sub.f32 %f7, %f6, %f5
  asm("sub.f32 %0, %1, %2;" : "=f"(f7) : "f"(f6), "f"(f5));
  // PTX:78 ld.global.f32 %f8, [%rd28+4]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (4)))));
  // PTX:79 ld.global.f32 %f9, [%rd26+4]
  f9 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (4)))));
  // PTX:80 sub.f32 %f10, %f9, %f8
  asm("sub.f32 %0, %1, %2;" : "=f"(f10) : "f"(f9), "f"(f8));
  // PTX:81 ld.global.f32 %f11, [%rd28+8]
  f11 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (8)))));
  // PTX:82 ld.global.f32 %f12, [%rd26+8]
  f12 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (8)))));
  // PTX:83 sub.f32 %f13, %f12, %f11
  asm("sub.f32 %0, %1, %2;" : "=f"(f13) : "f"(f12), "f"(f11));
  // PTX:84 mul.wide.s32 %rd29, %r24, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd29) : "r"(r24));
  // PTX:85 add.s64 %rd30, %rd20, %rd29
  asm("add.s64 %0, %1, %2;" : "=l"(rd30) : "l"(rd20), "l"(rd29));
  // PTX:86 ld.global.f32 %f14, [%rd30]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0)))));
  // PTX:87 sub.f32 %f15, %f14, %f5
  asm("sub.f32 %0, %1, %2;" : "=f"(f15) : "f"(f14), "f"(f5));
  // PTX:88 ld.global.f32 %f16, [%rd30+4]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (4)))));
  // PTX:89 sub.f32 %f17, %f16, %f8
  asm("sub.f32 %0, %1, %2;" : "=f"(f17) : "f"(f16), "f"(f8));
  // PTX:90 ld.global.f32 %f18, [%rd30+8]
  f18 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (8)))));
  // PTX:91 sub.f32 %f19, %f18, %f11
  asm("sub.f32 %0, %1, %2;" : "=f"(f19) : "f"(f18), "f"(f11));
  // PTX:92 mul.f32 %f20, %f10, %f19
  asm("mul.f32 %0, %1, %2;" : "=f"(f20) : "f"(f10), "f"(f19));
  // PTX:93 mul.f32 %f21, %f13, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f21) : "f"(f13), "f"(f17));
  // PTX:94 sub.f32 %f1, %f20, %f21
  asm("sub.f32 %0, %1, %2;" : "=f"(f1) : "f"(f20), "f"(f21));
  // PTX:95 mul.f32 %f22, %f13, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f22) : "f"(f13), "f"(f15));
  // PTX:96 mul.f32 %f23, %f7, %f19
  asm("mul.f32 %0, %1, %2;" : "=f"(f23) : "f"(f7), "f"(f19));
  // PTX:97 sub.f32 %f2, %f22, %f23
  asm("sub.f32 %0, %1, %2;" : "=f"(f2) : "f"(f22), "f"(f23));
  // PTX:98 mul.f32 %f24, %f7, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f24) : "f"(f7), "f"(f17));
  // PTX:99 mul.f32 %f25, %f10, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f25) : "f"(f10), "f"(f15));
  // PTX:100 sub.f32 %f3, %f24, %f25
  asm("sub.f32 %0, %1, %2;" : "=f"(f3) : "f"(f24), "f"(f25));
  // PTX:101 mul.f32 %f26, %f2, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f26) : "f"(f2), "f"(f2));
  // PTX:102 fma.rn.f32 %f27, %f1, %f1, %f26
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f27) : "f"(f1), "f"(f1), "f"(f26));
  // PTX:103 fma.rn.f32 %f28, %f3, %f3, %f27
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f28) : "f"(f3), "f"(f3), "f"(f27));
  // PTX:104 sqrt.rn.f32 %f4, %f28
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f4) : "f"(f28));
  // PTX:105 mul.f32 %f29, %f4, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f29) : "f"(f4));
  // PTX:106 cvta.to.global.u64 %rd31, %rd11
  rd31 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd11));
  // PTX:107 shl.b64 %rd32, %rd1, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd32) : "l"(rd1));
  // PTX:108 add.s64 %rd33, %rd31, %rd32
  asm("add.s64 %0, %1, %2;" : "=l"(rd33) : "l"(rd31), "l"(rd32));
  // PTX:109 st.global.f32 [%rd33], %f29
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (0))))) = (float)(f29);
  // PTX:110 setp.leu.f32 %p3, %f4, 0f2B8CBCCC
  p3 = ((isnan(((float)(f4))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) || (((float)(f4)) <= ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:111 mov.u32 %r25, 0
  asm("mov.u32 %0, 0;" : "=r"(r25) : );
  // PTX:112 mov.u32 %r26, %r25
  asm("mov.u32 %0, %1;" : "=r"(r26) : "r"(r25));
  // PTX:113 mov.u32 %r27, %r25
  asm("mov.u32 %0, %1;" : "=r"(r27) : "r"(r25));
  // PTX:114 @%p3 bra $L__BB39_6
  if (p3) { goto L_BB39_6; }
  // PTX:116 div.rn.f32 %f30, %f1, %f4
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f30) : "f"(f1), "f"(f4));
  // PTX:117 div.rn.f32 %f31, %f2, %f4
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f31) : "f"(f2), "f"(f4));
  // PTX:118 div.rn.f32 %f32, %f3, %f4
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f32) : "f"(f3), "f"(f4));
  // PTX:119 mov.b32 %r27, %f32
  asm("mov.b32 %0, %1;" : "=r"(r27) : "f"(f32));
  // PTX:120 mov.b32 %r26, %f31
  asm("mov.b32 %0, %1;" : "=r"(r26) : "f"(f31));
  // PTX:121 mov.b32 %r25, %f30
  asm("mov.b32 %0, %1;" : "=r"(r25) : "f"(f30));
  // PTX:123 $L__BB39_6:
L_BB39_6:;
  // PTX:124 cvta.to.global.u64 %rd34, %rd10
  rd34 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd10));
  // PTX:125 mul.lo.s64 %rd35, %rd1, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd35) : "l"(rd1));
  // PTX:126 add.s64 %rd36, %rd34, %rd35
  asm("add.s64 %0, %1, %2;" : "=l"(rd36) : "l"(rd34), "l"(rd35));
  // PTX:127 st.global.u32 [%rd36], %r25
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (0))))) = (unsigned)(r25);
  // PTX:128 st.global.u32 [%rd36+4], %r26
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (4))))) = (unsigned)(r26);
  // PTX:129 st.global.u32 [%rd36+8], %r27
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (8))))) = (unsigned)(r27);
  // PTX:131 $L__BB39_7:
L_BB39_7:;
  // PTX:132 ret
  return;
}
