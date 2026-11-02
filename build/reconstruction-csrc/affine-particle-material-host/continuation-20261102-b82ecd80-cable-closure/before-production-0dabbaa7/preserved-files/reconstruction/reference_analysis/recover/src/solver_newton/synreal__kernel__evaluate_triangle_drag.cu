// 机械还原自 PTX：synreal::kernel::evaluate_triangle_drag(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, glm::vec<3, float, (glm::qualifier)0>, float, glm::vec<3, float, (glm::qualifier)0>*, float*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: b07c7bf08a0e3ddfb6d0ec190875cf183d91376c1c3ac018c24d4c49dcd9dd9c
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__evaluate_triangle_drag(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, float param6, ByVal<12, 4> param7, float param8, unsigned long long param9, unsigned long long param10, unsigned long long param11, unsigned long long param12, unsigned long long param13) {
  int p0, p1, p2;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61;
  // PTX:30 ld.param.u64 %rd8, [_ZN7synreal6kernel22evaluate_triangle_dragEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi3EiLS3_0EEEPKfS6_SB_fS4_fPS4_Pfmmm_param_0]
  rd8 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:31 ld.param.u64 %rd9, [_ZN7synreal6kernel22evaluate_triangle_dragEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi3EiLS3_0EEEPKfS6_SB_fS4_fPS4_Pfmmm_param_1]
  rd9 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:32 ld.param.u64 %rd10, [_ZN7synreal6kernel22evaluate_triangle_dragEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi3EiLS3_0EEEPKfS6_SB_fS4_fPS4_Pfmmm_param_2]
  rd10 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:33 ld.param.u64 %rd11, [_ZN7synreal6kernel22evaluate_triangle_dragEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi3EiLS3_0EEEPKfS6_SB_fS4_fPS4_Pfmmm_param_3]
  rd11 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:34 ld.param.u64 %rd12, [_ZN7synreal6kernel22evaluate_triangle_dragEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi3EiLS3_0EEEPKfS6_SB_fS4_fPS4_Pfmmm_param_4]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:35 ld.param.u64 %rd13, [_ZN7synreal6kernel22evaluate_triangle_dragEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi3EiLS3_0EEEPKfS6_SB_fS4_fPS4_Pfmmm_param_5]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:36 ld.param.f32 %f1, [_ZN7synreal6kernel22evaluate_triangle_dragEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi3EiLS3_0EEEPKfS6_SB_fS4_fPS4_Pfmmm_param_6]
  f1 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param6 + (0))));
  // PTX:37 ld.param.f32 %f2, [_ZN7synreal6kernel22evaluate_triangle_dragEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi3EiLS3_0EEEPKfS6_SB_fS4_fPS4_Pfmmm_param_8]
  f2 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param8 + (0))));
  // PTX:38 ld.param.u64 %rd14, [_ZN7synreal6kernel22evaluate_triangle_dragEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi3EiLS3_0EEEPKfS6_SB_fS4_fPS4_Pfmmm_param_9]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:39 ld.param.u64 %rd15, [_ZN7synreal6kernel22evaluate_triangle_dragEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi3EiLS3_0EEEPKfS6_SB_fS4_fPS4_Pfmmm_param_10]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:40 ld.param.u64 %rd18, [_ZN7synreal6kernel22evaluate_triangle_dragEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi3EiLS3_0EEEPKfS6_SB_fS4_fPS4_Pfmmm_param_11]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:41 ld.param.u64 %rd16, [_ZN7synreal6kernel22evaluate_triangle_dragEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi3EiLS3_0EEEPKfS6_SB_fS4_fPS4_Pfmmm_param_12]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:42 ld.param.u64 %rd17, [_ZN7synreal6kernel22evaluate_triangle_dragEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi3EiLS3_0EEEPKfS6_SB_fS4_fPS4_Pfmmm_param_13]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:43 ld.param.u32 %r3, [_ZN7synreal6kernel22evaluate_triangle_dragEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi3EiLS3_0EEEPKfS6_SB_fS4_fPS4_Pfmmm_param_7+8]
  r3 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param7 + (8))));
  // PTX:44 ld.param.u32 %r2, [_ZN7synreal6kernel22evaluate_triangle_dragEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi3EiLS3_0EEEPKfS6_SB_fS4_fPS4_Pfmmm_param_7+4]
  r2 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param7 + (4))));
  // PTX:45 ld.param.u32 %r1, [_ZN7synreal6kernel22evaluate_triangle_dragEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi3EiLS3_0EEEPKfS6_SB_fS4_fPS4_Pfmmm_param_7]
  r1 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param7 + (0))));
  // PTX:46 mov.u32 %r4, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r4) : "r"(blockIdx.x));
  // PTX:47 mov.u32 %r5, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r5) : "r"(blockDim.x));
  // PTX:48 mul.wide.u32 %rd19, %r4, %r5
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd19) : "r"(r4), "r"(r5));
  // PTX:49 mov.u32 %r6, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r6) : "r"(threadIdx.x));
  // PTX:50 cvt.u64.u32 %rd20, %r6
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd20) : "r"(r6));
  // PTX:51 add.s64 %rd1, %rd19, %rd20
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd19), "l"(rd20));
  // PTX:52 setp.ge.u64 %p1, %rd1, %rd18
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd18)));
  // PTX:53 @%p1 bra $L__BB40_5
  if (p1) { goto L_BB40_5; }
  // PTX:55 or.b64 %rd21, %rd1, %rd16
  asm("or.b64 %0, %1, %2;" : "=l"(rd21) : "l"(rd1), "l"(rd16));
  // PTX:56 and.b64 %rd22, %rd21, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd22) : "l"(rd21));
  // PTX:57 setp.eq.s64 %p2, %rd22, 0
  p2 = (((long long)(rd22)) == ((long long)(0)));
  // PTX:58 @%p2 bra $L__BB40_3
  if (p2) { goto L_BB40_3; }
  // PTX:60 div.u64 %rd60, %rd1, %rd16
  asm("div.u64 %0, %1, %2;" : "=l"(rd60) : "l"(rd1), "l"(rd16));
  // PTX:61 mul.lo.s64 %rd23, %rd60, %rd16
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd23) : "l"(rd60), "l"(rd16));
  // PTX:62 sub.s64 %rd61, %rd1, %rd23
  asm("sub.s64 %0, %1, %2;" : "=l"(rd61) : "l"(rd1), "l"(rd23));
  // PTX:63 bra.uni $L__BB40_4
  goto L_BB40_4;
  // PTX:65 $L__BB40_3:
L_BB40_3:;
  // PTX:66 cvt.u32.u64 %r7, %rd16
  asm("cvt.u32.u64 %0, %1;" : "=r"(r7) : "l"(rd16));
  // PTX:67 cvt.u32.u64 %r8, %rd1
  asm("cvt.u32.u64 %0, %1;" : "=r"(r8) : "l"(rd1));
  // PTX:68 div.u32 %r9, %r8, %r7
  asm("div.u32 %0, %1, %2;" : "=r"(r9) : "r"(r8), "r"(r7));
  // PTX:69 mul.lo.s32 %r10, %r9, %r7
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r10) : "r"(r9), "r"(r7));
  // PTX:70 sub.s32 %r11, %r8, %r10
  asm("sub.s32 %0, %1, %2;" : "=r"(r11) : "r"(r8), "r"(r10));
  // PTX:71 cvt.u64.u32 %rd60, %r9
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd60) : "r"(r9));
  // PTX:72 cvt.u64.u32 %rd61, %r11
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd61) : "r"(r11));
  // PTX:74 $L__BB40_4:
L_BB40_4:;
  // PTX:75 cvta.to.global.u64 %rd24, %rd14
  rd24 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd14));
  // PTX:76 cvta.to.global.u64 %rd25, %rd9
  rd25 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd9));
  // PTX:77 cvta.to.global.u64 %rd26, %rd8
  rd26 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd8));
  // PTX:78 cvta.to.global.u64 %rd27, %rd10
  rd27 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd10));
  // PTX:79 mul.lo.s64 %rd28, %rd61, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd28) : "l"(rd61));
  // PTX:80 add.s64 %rd29, %rd27, %rd28
  asm("add.s64 %0, %1, %2;" : "=l"(rd29) : "l"(rd27), "l"(rd28));
  // PTX:81 mul.lo.s64 %rd30, %rd60, %rd17
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd30) : "l"(rd60), "l"(rd17));
  // PTX:82 cvt.u32.u64 %r12, %rd30
  asm("cvt.u32.u64 %0, %1;" : "=r"(r12) : "l"(rd30));
  // PTX:83 ld.global.u32 %r13, [%rd29]
  r13 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (0)))));
  // PTX:84 add.s32 %r14, %r13, %r12
  asm("add.s32 %0, %1, %2;" : "=r"(r14) : "r"(r13), "r"(r12));
  // PTX:85 ld.global.u32 %r15, [%rd29+4]
  r15 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (4)))));
  // PTX:86 add.s32 %r16, %r15, %r12
  asm("add.s32 %0, %1, %2;" : "=r"(r16) : "r"(r15), "r"(r12));
  // PTX:87 ld.global.u32 %r17, [%rd29+8]
  r17 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (8)))));
  // PTX:88 add.s32 %r18, %r17, %r12
  asm("add.s32 %0, %1, %2;" : "=r"(r18) : "r"(r17), "r"(r12));
  // PTX:89 mul.wide.s32 %rd31, %r14, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd31) : "r"(r14));
  // PTX:90 add.s64 %rd32, %rd26, %rd31
  asm("add.s64 %0, %1, %2;" : "=l"(rd32) : "l"(rd26), "l"(rd31));
  // PTX:91 add.s64 %rd33, %rd25, %rd31
  asm("add.s64 %0, %1, %2;" : "=l"(rd33) : "l"(rd25), "l"(rd31));
  // PTX:92 ld.global.f32 %f3, [%rd33]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (0)))));
  // PTX:93 ld.global.f32 %f4, [%rd32]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (0)))));
  // PTX:94 sub.f32 %f5, %f4, %f3
  asm("sub.f32 %0, %1, %2;" : "=f"(f5) : "f"(f4), "f"(f3));
  // PTX:95 ld.global.f32 %f6, [%rd33+4]
  f6 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (4)))));
  // PTX:96 ld.global.f32 %f7, [%rd32+4]
  f7 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (4)))));
  // PTX:97 sub.f32 %f8, %f7, %f6
  asm("sub.f32 %0, %1, %2;" : "=f"(f8) : "f"(f7), "f"(f6));
  // PTX:98 ld.global.f32 %f9, [%rd33+8]
  f9 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (8)))));
  // PTX:99 ld.global.f32 %f10, [%rd32+8]
  f10 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (8)))));
  // PTX:100 sub.f32 %f11, %f10, %f9
  asm("sub.f32 %0, %1, %2;" : "=f"(f11) : "f"(f10), "f"(f9));
  // PTX:101 mul.wide.s32 %rd34, %r16, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd34) : "r"(r16));
  // PTX:102 add.s64 %rd35, %rd26, %rd34
  asm("add.s64 %0, %1, %2;" : "=l"(rd35) : "l"(rd26), "l"(rd34));
  // PTX:103 add.s64 %rd36, %rd25, %rd34
  asm("add.s64 %0, %1, %2;" : "=l"(rd36) : "l"(rd25), "l"(rd34));
  // PTX:104 ld.global.f32 %f12, [%rd36]
  f12 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (0)))));
  // PTX:105 ld.global.f32 %f13, [%rd35]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (0)))));
  // PTX:106 sub.f32 %f14, %f13, %f12
  asm("sub.f32 %0, %1, %2;" : "=f"(f14) : "f"(f13), "f"(f12));
  // PTX:107 ld.global.f32 %f15, [%rd36+4]
  f15 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (4)))));
  // PTX:108 ld.global.f32 %f16, [%rd35+4]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (4)))));
  // PTX:109 sub.f32 %f17, %f16, %f15
  asm("sub.f32 %0, %1, %2;" : "=f"(f17) : "f"(f16), "f"(f15));
  // PTX:110 ld.global.f32 %f18, [%rd36+8]
  f18 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (8)))));
  // PTX:111 ld.global.f32 %f19, [%rd35+8]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (8)))));
  // PTX:112 sub.f32 %f20, %f19, %f18
  asm("sub.f32 %0, %1, %2;" : "=f"(f20) : "f"(f19), "f"(f18));
  // PTX:113 add.f32 %f21, %f5, %f14
  asm("add.f32 %0, %1, %2;" : "=f"(f21) : "f"(f5), "f"(f14));
  // PTX:114 add.f32 %f22, %f8, %f17
  asm("add.f32 %0, %1, %2;" : "=f"(f22) : "f"(f8), "f"(f17));
  // PTX:115 add.f32 %f23, %f11, %f20
  asm("add.f32 %0, %1, %2;" : "=f"(f23) : "f"(f11), "f"(f20));
  // PTX:116 mul.wide.s32 %rd37, %r18, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd37) : "r"(r18));
  // PTX:117 add.s64 %rd38, %rd26, %rd37
  asm("add.s64 %0, %1, %2;" : "=l"(rd38) : "l"(rd26), "l"(rd37));
  // PTX:118 add.s64 %rd39, %rd25, %rd37
  asm("add.s64 %0, %1, %2;" : "=l"(rd39) : "l"(rd25), "l"(rd37));
  // PTX:119 ld.global.f32 %f24, [%rd39]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (0)))));
  // PTX:120 ld.global.f32 %f25, [%rd38]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (0)))));
  // PTX:121 sub.f32 %f26, %f25, %f24
  asm("sub.f32 %0, %1, %2;" : "=f"(f26) : "f"(f25), "f"(f24));
  // PTX:122 ld.global.f32 %f27, [%rd39+4]
  f27 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (4)))));
  // PTX:123 ld.global.f32 %f28, [%rd38+4]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (4)))));
  // PTX:124 sub.f32 %f29, %f28, %f27
  asm("sub.f32 %0, %1, %2;" : "=f"(f29) : "f"(f28), "f"(f27));
  // PTX:125 ld.global.f32 %f30, [%rd39+8]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (8)))));
  // PTX:126 ld.global.f32 %f31, [%rd38+8]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (8)))));
  // PTX:127 sub.f32 %f32, %f31, %f30
  asm("sub.f32 %0, %1, %2;" : "=f"(f32) : "f"(f31), "f"(f30));
  // PTX:128 add.f32 %f33, %f21, %f26
  asm("add.f32 %0, %1, %2;" : "=f"(f33) : "f"(f21), "f"(f26));
  // PTX:129 add.f32 %f34, %f22, %f29
  asm("add.f32 %0, %1, %2;" : "=f"(f34) : "f"(f22), "f"(f29));
  // PTX:130 add.f32 %f35, %f23, %f32
  asm("add.f32 %0, %1, %2;" : "=f"(f35) : "f"(f23), "f"(f32));
  // PTX:131 div.rn.f32 %f36, %f2, 0f40400000
  asm("div.rn.f32 %0, %1, 0f40400000;" : "=f"(f36) : "f"(f2));
  // PTX:132 mul.f32 %f37, %f36, %f33
  asm("mul.f32 %0, %1, %2;" : "=f"(f37) : "f"(f36), "f"(f33));
  // PTX:133 mul.f32 %f38, %f36, %f34
  asm("mul.f32 %0, %1, %2;" : "=f"(f38) : "f"(f36), "f"(f34));
  // PTX:134 mul.f32 %f39, %f36, %f35
  asm("mul.f32 %0, %1, %2;" : "=f"(f39) : "f"(f36), "f"(f35));
  // PTX:135 cvta.to.global.u64 %rd40, %rd12
  rd40 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd12));
  // PTX:136 mul.lo.s64 %rd41, %rd1, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd41) : "l"(rd1));
  // PTX:137 add.s64 %rd42, %rd40, %rd41
  asm("add.s64 %0, %1, %2;" : "=l"(rd42) : "l"(rd40), "l"(rd41));
  // PTX:138 mov.b32 %f40, %r1
  asm("mov.b32 %0, %1;" : "=f"(f40) : "r"(r1));
  // PTX:139 sub.f32 %f41, %f37, %f40
  asm("sub.f32 %0, %1, %2;" : "=f"(f41) : "f"(f37), "f"(f40));
  // PTX:140 mov.b32 %f42, %r2
  asm("mov.b32 %0, %1;" : "=f"(f42) : "r"(r2));
  // PTX:141 sub.f32 %f43, %f38, %f42
  asm("sub.f32 %0, %1, %2;" : "=f"(f43) : "f"(f38), "f"(f42));
  // PTX:142 mov.b32 %f44, %r3
  asm("mov.b32 %0, %1;" : "=f"(f44) : "r"(r3));
  // PTX:143 sub.f32 %f45, %f39, %f44
  asm("sub.f32 %0, %1, %2;" : "=f"(f45) : "f"(f39), "f"(f44));
  // PTX:144 ld.global.f32 %f46, [%rd42]
  f46 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (0)))));
  // PTX:145 ld.global.f32 %f47, [%rd42+4]
  f47 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (4)))));
  // PTX:146 mul.f32 %f48, %f43, %f47
  asm("mul.f32 %0, %1, %2;" : "=f"(f48) : "f"(f43), "f"(f47));
  // PTX:147 ld.global.f32 %f49, [%rd42+8]
  f49 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (8)))));
  // PTX:148 fma.rn.f32 %f50, %f41, %f46, %f48
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f50) : "f"(f41), "f"(f46), "f"(f48));
  // PTX:149 fma.rn.f32 %f51, %f49, %f45, %f50
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f51) : "f"(f49), "f"(f45), "f"(f50));
  // PTX:150 cvta.to.global.u64 %rd43, %rd11
  rd43 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd11));
  // PTX:151 shl.b64 %rd44, %rd61, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd44) : "l"(rd61));
  // PTX:152 add.s64 %rd45, %rd43, %rd44
  asm("add.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd43), "l"(rd44));
  // PTX:153 ld.global.f32 %f52, [%rd45]
  f52 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))));
  // PTX:154 mul.f32 %f53, %f1, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f53) : "f"(f1));
  // PTX:155 mul.f32 %f54, %f53, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f54) : "f"(f53), "f"(f52));
  // PTX:156 cvta.to.global.u64 %rd46, %rd13
  rd46 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd13));
  // PTX:157 shl.b64 %rd47, %rd1, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd47) : "l"(rd1));
  // PTX:158 add.s64 %rd48, %rd46, %rd47
  asm("add.s64 %0, %1, %2;" : "=l"(rd48) : "l"(rd46), "l"(rd47));
  // PTX:159 ld.global.f32 %f55, [%rd48]
  f55 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))));
  // PTX:160 mul.f32 %f56, %f54, %f55
  asm("mul.f32 %0, %1, %2;" : "=f"(f56) : "f"(f54), "f"(f55));
  // PTX:161 mul.f32 %f57, %f56, %f51
  asm("mul.f32 %0, %1, %2;" : "=f"(f57) : "f"(f56), "f"(f51));
  // PTX:162 abs.f32 %f58, %f51
  asm("abs.f32 %0, %1;" : "=f"(f58) : "f"(f51));
  // PTX:163 mul.f32 %f59, %f58, %f57
  asm("mul.f32 %0, %1, %2;" : "=f"(f59) : "f"(f58), "f"(f57));
  // PTX:164 div.rn.f32 %f60, %f59, 0fC0400000
  asm("div.rn.f32 %0, %1, 0fC0400000;" : "=f"(f60) : "f"(f59));
  // PTX:165 mul.f32 %f61, %f46, %f60
  asm("mul.f32 %0, %1, %2;" : "=f"(f61) : "f"(f46), "f"(f60));
  // PTX:166 mul.f32 %f62, %f47, %f60
  asm("mul.f32 %0, %1, %2;" : "=f"(f62) : "f"(f47), "f"(f60));
  // PTX:167 mul.f32 %f63, %f49, %f60
  asm("mul.f32 %0, %1, %2;" : "=f"(f63) : "f"(f49), "f"(f60));
  // PTX:168 add.s64 %rd49, %rd24, %rd31
  asm("add.s64 %0, %1, %2;" : "=l"(rd49) : "l"(rd24), "l"(rd31));
  // PTX:169 red.global.add.f32 [%rd49], %f61
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))), (float)(f61));
  // PTX:170 add.s64 %rd50, %rd49, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd50) : "l"(rd49));
  // PTX:171 red.global.add.f32 [%rd50], %f62
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (0)))), (float)(f62));
  // PTX:172 add.s64 %rd51, %rd49, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd51) : "l"(rd49));
  // PTX:173 red.global.add.f32 [%rd51], %f63
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))), (float)(f63));
  // PTX:174 add.s64 %rd52, %rd24, %rd34
  asm("add.s64 %0, %1, %2;" : "=l"(rd52) : "l"(rd24), "l"(rd34));
  // PTX:175 red.global.add.f32 [%rd52], %f61
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))), (float)(f61));
  // PTX:176 add.s64 %rd53, %rd52, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd53) : "l"(rd52));
  // PTX:177 red.global.add.f32 [%rd53], %f62
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))), (float)(f62));
  // PTX:178 add.s64 %rd54, %rd52, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd54) : "l"(rd52));
  // PTX:179 red.global.add.f32 [%rd54], %f63
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))), (float)(f63));
  // PTX:180 add.s64 %rd55, %rd24, %rd37
  asm("add.s64 %0, %1, %2;" : "=l"(rd55) : "l"(rd24), "l"(rd37));
  // PTX:181 red.global.add.f32 [%rd55], %f61
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))), (float)(f61));
  // PTX:182 add.s64 %rd56, %rd55, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd56) : "l"(rd55));
  // PTX:183 red.global.add.f32 [%rd56], %f62
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))), (float)(f62));
  // PTX:184 add.s64 %rd57, %rd55, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd57) : "l"(rd55));
  // PTX:185 red.global.add.f32 [%rd57], %f63
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))), (float)(f63));
  // PTX:186 add.f32 %f73, %f56, %f56
  asm("add.f32 %0, %1, %2;" : "=f"(f73) : "f"(f56), "f"(f56));
  // PTX:187 mul.f32 %f74, %f58, %f73
  asm("mul.f32 %0, %1, %2;" : "=f"(f74) : "f"(f58), "f"(f73));
  // PTX:188 mul.f32 %f75, %f74, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f75) : "f"(f74), "f"(f2));
  // PTX:189 div.rn.f32 %f76, %f75, 0f41100000
  asm("div.rn.f32 %0, %1, 0f41100000;" : "=f"(f76) : "f"(f75));
  // PTX:190 cvta.to.global.u64 %rd58, %rd15
  rd58 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd15));
  // PTX:191 add.s64 %rd59, %rd58, %rd47
  asm("add.s64 %0, %1, %2;" : "=l"(rd59) : "l"(rd58), "l"(rd47));
  // PTX:192 st.global.f32 [%rd59], %f76
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0))))) = (float)(f76);
  // PTX:194 $L__BB40_5:
L_BB40_5:;
  // PTX:195 ret
  return;
}
