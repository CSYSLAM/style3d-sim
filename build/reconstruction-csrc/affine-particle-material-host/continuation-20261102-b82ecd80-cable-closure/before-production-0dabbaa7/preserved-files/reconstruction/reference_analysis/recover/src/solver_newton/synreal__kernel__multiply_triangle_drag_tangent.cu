// 机械还原自 PTX：synreal::kernel::multiply_triangle_drag_tangent(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 874b9c9bdf358ca6ecd064d2e6c59526deb631fb7b2045ac768af6462444281b
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__multiply_triangle_drag_tangent(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7) {
  int p0, p1, p2;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49;
  // PTX:24 ld.param.u64 %rd8, [_ZN7synreal6kernel30multiply_triangle_drag_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEES6_PKfPS4_mmm_param_0]
  rd8 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:25 ld.param.u64 %rd9, [_ZN7synreal6kernel30multiply_triangle_drag_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEES6_PKfPS4_mmm_param_1]
  rd9 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:26 ld.param.u64 %rd10, [_ZN7synreal6kernel30multiply_triangle_drag_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEES6_PKfPS4_mmm_param_2]
  rd10 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:27 ld.param.u64 %rd11, [_ZN7synreal6kernel30multiply_triangle_drag_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEES6_PKfPS4_mmm_param_3]
  rd11 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:28 ld.param.u64 %rd12, [_ZN7synreal6kernel30multiply_triangle_drag_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEES6_PKfPS4_mmm_param_4]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:29 ld.param.u64 %rd15, [_ZN7synreal6kernel30multiply_triangle_drag_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEES6_PKfPS4_mmm_param_5]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:30 ld.param.u64 %rd13, [_ZN7synreal6kernel30multiply_triangle_drag_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEES6_PKfPS4_mmm_param_6]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:31 ld.param.u64 %rd14, [_ZN7synreal6kernel30multiply_triangle_drag_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEES6_PKfPS4_mmm_param_7]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:32 mov.u32 %r1, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r1) : "r"(blockIdx.x));
  // PTX:33 mov.u32 %r2, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockDim.x));
  // PTX:34 mul.wide.u32 %rd16, %r1, %r2
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd16) : "r"(r1), "r"(r2));
  // PTX:35 mov.u32 %r3, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(threadIdx.x));
  // PTX:36 cvt.u64.u32 %rd17, %r3
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd17) : "r"(r3));
  // PTX:37 add.s64 %rd1, %rd16, %rd17
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd16), "l"(rd17));
  // PTX:38 setp.ge.u64 %p1, %rd1, %rd15
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd15)));
  // PTX:39 @%p1 bra $L__BB41_5
  if (p1) { goto L_BB41_5; }
  // PTX:41 or.b64 %rd18, %rd1, %rd13
  asm("or.b64 %0, %1, %2;" : "=l"(rd18) : "l"(rd1), "l"(rd13));
  // PTX:42 and.b64 %rd19, %rd18, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd19) : "l"(rd18));
  // PTX:43 setp.eq.s64 %p2, %rd19, 0
  p2 = (((long long)(rd19)) == ((long long)(0)));
  // PTX:44 @%p2 bra $L__BB41_3
  if (p2) { goto L_BB41_3; }
  // PTX:46 div.u64 %rd48, %rd1, %rd13
  asm("div.u64 %0, %1, %2;" : "=l"(rd48) : "l"(rd1), "l"(rd13));
  // PTX:47 mul.lo.s64 %rd20, %rd48, %rd13
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd20) : "l"(rd48), "l"(rd13));
  // PTX:48 sub.s64 %rd49, %rd1, %rd20
  asm("sub.s64 %0, %1, %2;" : "=l"(rd49) : "l"(rd1), "l"(rd20));
  // PTX:49 bra.uni $L__BB41_4
  goto L_BB41_4;
  // PTX:51 $L__BB41_3:
L_BB41_3:;
  // PTX:52 cvt.u32.u64 %r4, %rd13
  asm("cvt.u32.u64 %0, %1;" : "=r"(r4) : "l"(rd13));
  // PTX:53 cvt.u32.u64 %r5, %rd1
  asm("cvt.u32.u64 %0, %1;" : "=r"(r5) : "l"(rd1));
  // PTX:54 div.u32 %r6, %r5, %r4
  asm("div.u32 %0, %1, %2;" : "=r"(r6) : "r"(r5), "r"(r4));
  // PTX:55 mul.lo.s32 %r7, %r6, %r4
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r7) : "r"(r6), "r"(r4));
  // PTX:56 sub.s32 %r8, %r5, %r7
  asm("sub.s32 %0, %1, %2;" : "=r"(r8) : "r"(r5), "r"(r7));
  // PTX:57 cvt.u64.u32 %rd48, %r6
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd48) : "r"(r6));
  // PTX:58 cvt.u64.u32 %rd49, %r8
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd49) : "r"(r8));
  // PTX:60 $L__BB41_4:
L_BB41_4:;
  // PTX:61 cvta.to.global.u64 %rd21, %rd12
  rd21 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd12));
  // PTX:62 cvta.to.global.u64 %rd22, %rd8
  rd22 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd8));
  // PTX:63 cvta.to.global.u64 %rd23, %rd9
  rd23 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd9));
  // PTX:64 mul.lo.s64 %rd24, %rd49, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd24) : "l"(rd49));
  // PTX:65 add.s64 %rd25, %rd23, %rd24
  asm("add.s64 %0, %1, %2;" : "=l"(rd25) : "l"(rd23), "l"(rd24));
  // PTX:66 mul.lo.s64 %rd26, %rd48, %rd14
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd26) : "l"(rd48), "l"(rd14));
  // PTX:67 cvt.u32.u64 %r9, %rd26
  asm("cvt.u32.u64 %0, %1;" : "=r"(r9) : "l"(rd26));
  // PTX:68 ld.global.u32 %r10, [%rd25]
  r10 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (0)))));
  // PTX:69 add.s32 %r11, %r10, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r11) : "r"(r10), "r"(r9));
  // PTX:70 ld.global.u32 %r12, [%rd25+4]
  r12 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (4)))));
  // PTX:71 add.s32 %r13, %r12, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r13) : "r"(r12), "r"(r9));
  // PTX:72 ld.global.u32 %r14, [%rd25+8]
  r14 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (8)))));
  // PTX:73 add.s32 %r15, %r14, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r15) : "r"(r14), "r"(r9));
  // PTX:74 cvta.to.global.u64 %rd27, %rd10
  rd27 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd10));
  // PTX:75 mul.lo.s64 %rd28, %rd1, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd28) : "l"(rd1));
  // PTX:76 add.s64 %rd29, %rd27, %rd28
  asm("add.s64 %0, %1, %2;" : "=l"(rd29) : "l"(rd27), "l"(rd28));
  // PTX:77 mul.wide.s32 %rd30, %r11, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd30) : "r"(r11));
  // PTX:78 add.s64 %rd31, %rd22, %rd30
  asm("add.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd22), "l"(rd30));
  // PTX:79 mul.wide.s32 %rd32, %r13, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd32) : "r"(r13));
  // PTX:80 add.s64 %rd33, %rd22, %rd32
  asm("add.s64 %0, %1, %2;" : "=l"(rd33) : "l"(rd22), "l"(rd32));
  // PTX:81 ld.global.f32 %f1, [%rd33]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (0)))));
  // PTX:82 ld.global.f32 %f2, [%rd31]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (0)))));
  // PTX:83 add.f32 %f3, %f2, %f1
  asm("add.f32 %0, %1, %2;" : "=f"(f3) : "f"(f2), "f"(f1));
  // PTX:84 ld.global.f32 %f4, [%rd33+4]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (4)))));
  // PTX:85 ld.global.f32 %f5, [%rd31+4]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (4)))));
  // PTX:86 add.f32 %f6, %f5, %f4
  asm("add.f32 %0, %1, %2;" : "=f"(f6) : "f"(f5), "f"(f4));
  // PTX:87 ld.global.f32 %f7, [%rd33+8]
  f7 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (8)))));
  // PTX:88 ld.global.f32 %f8, [%rd31+8]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (8)))));
  // PTX:89 add.f32 %f9, %f8, %f7
  asm("add.f32 %0, %1, %2;" : "=f"(f9) : "f"(f8), "f"(f7));
  // PTX:90 mul.wide.s32 %rd34, %r15, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd34) : "r"(r15));
  // PTX:91 add.s64 %rd35, %rd22, %rd34
  asm("add.s64 %0, %1, %2;" : "=l"(rd35) : "l"(rd22), "l"(rd34));
  // PTX:92 ld.global.f32 %f10, [%rd35]
  f10 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (0)))));
  // PTX:93 add.f32 %f11, %f3, %f10
  asm("add.f32 %0, %1, %2;" : "=f"(f11) : "f"(f3), "f"(f10));
  // PTX:94 ld.global.f32 %f12, [%rd35+4]
  f12 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (4)))));
  // PTX:95 add.f32 %f13, %f6, %f12
  asm("add.f32 %0, %1, %2;" : "=f"(f13) : "f"(f6), "f"(f12));
  // PTX:96 ld.global.f32 %f14, [%rd35+8]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (8)))));
  // PTX:97 add.f32 %f15, %f9, %f14
  asm("add.f32 %0, %1, %2;" : "=f"(f15) : "f"(f9), "f"(f14));
  // PTX:98 ld.global.f32 %f16, [%rd29]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (0)))));
  // PTX:99 ld.global.f32 %f17, [%rd29+4]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (4)))));
  // PTX:100 mul.f32 %f18, %f17, %f13
  asm("mul.f32 %0, %1, %2;" : "=f"(f18) : "f"(f17), "f"(f13));
  // PTX:101 ld.global.f32 %f19, [%rd29+8]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (8)))));
  // PTX:102 fma.rn.f32 %f20, %f16, %f11, %f18
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f20) : "f"(f16), "f"(f11), "f"(f18));
  // PTX:103 fma.rn.f32 %f21, %f19, %f15, %f20
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f21) : "f"(f19), "f"(f15), "f"(f20));
  // PTX:104 cvta.to.global.u64 %rd36, %rd11
  rd36 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd11));
  // PTX:105 shl.b64 %rd37, %rd1, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd37) : "l"(rd1));
  // PTX:106 add.s64 %rd38, %rd36, %rd37
  asm("add.s64 %0, %1, %2;" : "=l"(rd38) : "l"(rd36), "l"(rd37));
  // PTX:107 ld.global.f32 %f22, [%rd38]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (0)))));
  // PTX:108 mul.f32 %f23, %f22, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f23) : "f"(f22), "f"(f21));
  // PTX:109 mul.f32 %f24, %f16, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f24) : "f"(f16), "f"(f23));
  // PTX:110 mul.f32 %f25, %f17, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f25) : "f"(f17), "f"(f23));
  // PTX:111 mul.f32 %f26, %f19, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f26) : "f"(f19), "f"(f23));
  // PTX:112 add.s64 %rd39, %rd21, %rd30
  asm("add.s64 %0, %1, %2;" : "=l"(rd39) : "l"(rd21), "l"(rd30));
  // PTX:113 red.global.add.f32 [%rd39], %f24
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (0)))), (float)(f24));
  // PTX:114 add.s64 %rd40, %rd39, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd40) : "l"(rd39));
  // PTX:115 red.global.add.f32 [%rd40], %f25
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (0)))), (float)(f25));
  // PTX:116 add.s64 %rd41, %rd39, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd41) : "l"(rd39));
  // PTX:117 red.global.add.f32 [%rd41], %f26
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (0)))), (float)(f26));
  // PTX:118 add.s64 %rd42, %rd21, %rd32
  asm("add.s64 %0, %1, %2;" : "=l"(rd42) : "l"(rd21), "l"(rd32));
  // PTX:119 red.global.add.f32 [%rd42], %f24
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (0)))), (float)(f24));
  // PTX:120 add.s64 %rd43, %rd42, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd43) : "l"(rd42));
  // PTX:121 red.global.add.f32 [%rd43], %f25
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (0)))), (float)(f25));
  // PTX:122 add.s64 %rd44, %rd42, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd44) : "l"(rd42));
  // PTX:123 red.global.add.f32 [%rd44], %f26
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))), (float)(f26));
  // PTX:124 add.s64 %rd45, %rd21, %rd34
  asm("add.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd21), "l"(rd34));
  // PTX:125 red.global.add.f32 [%rd45], %f24
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))), (float)(f24));
  // PTX:126 add.s64 %rd46, %rd45, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd46) : "l"(rd45));
  // PTX:127 red.global.add.f32 [%rd46], %f25
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (0)))), (float)(f25));
  // PTX:128 add.s64 %rd47, %rd45, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd47) : "l"(rd45));
  // PTX:129 red.global.add.f32 [%rd47], %f26
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))), (float)(f26));
  // PTX:131 $L__BB41_5:
L_BB41_5:;
  // PTX:132 ret
  return;
}
