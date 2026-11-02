// 机械还原自 PTX：synreal::self_collision_kernel::build_triangle_aabbs(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, synreal::Aabb*, float, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 1b72745587ea0a352ce3ac92445dce71f926dccf3c50d9e0ab4088d3ff91374d
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__self_collision_kernel__build_triangle_aabbs(unsigned long long param0, unsigned long long param1, unsigned long long param2, float param3, unsigned long long param4, unsigned long long param5, unsigned long long param6) {
  int p0, p1, p2;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34;
  // PTX:23 ld.param.u64 %rd8, [_ZN7synreal21self_collision_kernel20build_triangle_aabbsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPNS_4AabbEfmmm_param_0]
  rd8 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:24 ld.param.u64 %rd9, [_ZN7synreal21self_collision_kernel20build_triangle_aabbsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPNS_4AabbEfmmm_param_1]
  rd9 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:25 ld.param.u64 %rd10, [_ZN7synreal21self_collision_kernel20build_triangle_aabbsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPNS_4AabbEfmmm_param_2]
  rd10 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:26 ld.param.f32 %f1, [_ZN7synreal21self_collision_kernel20build_triangle_aabbsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPNS_4AabbEfmmm_param_3]
  f1 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param3 + (0))));
  // PTX:27 ld.param.u64 %rd13, [_ZN7synreal21self_collision_kernel20build_triangle_aabbsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPNS_4AabbEfmmm_param_4]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:28 ld.param.u64 %rd11, [_ZN7synreal21self_collision_kernel20build_triangle_aabbsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPNS_4AabbEfmmm_param_5]
  rd11 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:29 ld.param.u64 %rd12, [_ZN7synreal21self_collision_kernel20build_triangle_aabbsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPNS_4AabbEfmmm_param_6]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:30 mov.u32 %r1, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r1) : "r"(blockIdx.x));
  // PTX:31 mov.u32 %r2, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockDim.x));
  // PTX:32 mul.wide.u32 %rd14, %r1, %r2
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd14) : "r"(r1), "r"(r2));
  // PTX:33 mov.u32 %r3, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(threadIdx.x));
  // PTX:34 cvt.u64.u32 %rd15, %r3
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd15) : "r"(r3));
  // PTX:35 add.s64 %rd1, %rd14, %rd15
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd14), "l"(rd15));
  // PTX:36 setp.ge.u64 %p1, %rd1, %rd13
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd13)));
  // PTX:37 @%p1 bra $L__BB0_5
  if (p1) { goto L_BB0_5; }
  // PTX:39 or.b64 %rd16, %rd1, %rd11
  asm("or.b64 %0, %1, %2;" : "=l"(rd16) : "l"(rd1), "l"(rd11));
  // PTX:40 and.b64 %rd17, %rd16, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd17) : "l"(rd16));
  // PTX:41 setp.eq.s64 %p2, %rd17, 0
  p2 = (((long long)(rd17)) == ((long long)(0)));
  // PTX:42 @%p2 bra $L__BB0_3
  if (p2) { goto L_BB0_3; }
  // PTX:44 div.u64 %rd33, %rd1, %rd11
  asm("div.u64 %0, %1, %2;" : "=l"(rd33) : "l"(rd1), "l"(rd11));
  // PTX:45 mul.lo.s64 %rd18, %rd33, %rd11
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd18) : "l"(rd33), "l"(rd11));
  // PTX:46 sub.s64 %rd34, %rd1, %rd18
  asm("sub.s64 %0, %1, %2;" : "=l"(rd34) : "l"(rd1), "l"(rd18));
  // PTX:47 bra.uni $L__BB0_4
  goto L_BB0_4;
  // PTX:49 $L__BB0_3:
L_BB0_3:;
  // PTX:50 cvt.u32.u64 %r4, %rd11
  asm("cvt.u32.u64 %0, %1;" : "=r"(r4) : "l"(rd11));
  // PTX:51 cvt.u32.u64 %r5, %rd1
  asm("cvt.u32.u64 %0, %1;" : "=r"(r5) : "l"(rd1));
  // PTX:52 div.u32 %r6, %r5, %r4
  asm("div.u32 %0, %1, %2;" : "=r"(r6) : "r"(r5), "r"(r4));
  // PTX:53 mul.lo.s32 %r7, %r6, %r4
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r7) : "r"(r6), "r"(r4));
  // PTX:54 sub.s32 %r8, %r5, %r7
  asm("sub.s32 %0, %1, %2;" : "=r"(r8) : "r"(r5), "r"(r7));
  // PTX:55 cvt.u64.u32 %rd33, %r6
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd33) : "r"(r6));
  // PTX:56 cvt.u64.u32 %rd34, %r8
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd34) : "r"(r8));
  // PTX:58 $L__BB0_4:
L_BB0_4:;
  // PTX:59 cvta.to.global.u64 %rd19, %rd8
  rd19 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd8));
  // PTX:60 mul.lo.s64 %rd20, %rd33, %rd12
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd20) : "l"(rd33), "l"(rd12));
  // PTX:61 cvt.u32.u64 %r9, %rd20
  asm("cvt.u32.u64 %0, %1;" : "=r"(r9) : "l"(rd20));
  // PTX:62 cvta.to.global.u64 %rd21, %rd9
  rd21 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd9));
  // PTX:63 mul.lo.s64 %rd22, %rd34, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd22) : "l"(rd34));
  // PTX:64 add.s64 %rd23, %rd21, %rd22
  asm("add.s64 %0, %1, %2;" : "=l"(rd23) : "l"(rd21), "l"(rd22));
  // PTX:65 ld.global.u32 %r10, [%rd23]
  r10 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (0)))));
  // PTX:66 add.s32 %r11, %r10, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r11) : "r"(r10), "r"(r9));
  // PTX:67 mul.wide.s32 %rd24, %r11, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd24) : "r"(r11));
  // PTX:68 add.s64 %rd25, %rd19, %rd24
  asm("add.s64 %0, %1, %2;" : "=l"(rd25) : "l"(rd19), "l"(rd24));
  // PTX:69 ld.global.u32 %r12, [%rd23+4]
  r12 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (4)))));
  // PTX:70 add.s32 %r13, %r12, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r13) : "r"(r12), "r"(r9));
  // PTX:71 mul.wide.s32 %rd26, %r13, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd26) : "r"(r13));
  // PTX:72 add.s64 %rd27, %rd19, %rd26
  asm("add.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd19), "l"(rd26));
  // PTX:73 ld.global.u32 %r14, [%rd23+8]
  r14 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (8)))));
  // PTX:74 add.s32 %r15, %r14, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r15) : "r"(r14), "r"(r9));
  // PTX:75 mul.wide.s32 %rd28, %r15, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd28) : "r"(r15));
  // PTX:76 add.s64 %rd29, %rd19, %rd28
  asm("add.s64 %0, %1, %2;" : "=l"(rd29) : "l"(rd19), "l"(rd28));
  // PTX:77 ld.global.f32 %f2, [%rd29]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (0)))));
  // PTX:78 ld.global.f32 %f3, [%rd27]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))));
  // PTX:79 min.f32 %f4, %f3, %f2
  asm("min.f32 %0, %1, %2;" : "=f"(f4) : "f"(f3), "f"(f2));
  // PTX:80 ld.global.f32 %f5, [%rd29+4]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (4)))));
  // PTX:81 ld.global.f32 %f6, [%rd27+4]
  f6 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (4)))));
  // PTX:82 min.f32 %f7, %f6, %f5
  asm("min.f32 %0, %1, %2;" : "=f"(f7) : "f"(f6), "f"(f5));
  // PTX:83 ld.global.f32 %f8, [%rd29+8]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (8)))));
  // PTX:84 ld.global.f32 %f9, [%rd27+8]
  f9 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (8)))));
  // PTX:85 min.f32 %f10, %f9, %f8
  asm("min.f32 %0, %1, %2;" : "=f"(f10) : "f"(f9), "f"(f8));
  // PTX:86 ld.global.f32 %f11, [%rd25]
  f11 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (0)))));
  // PTX:87 min.f32 %f12, %f11, %f4
  asm("min.f32 %0, %1, %2;" : "=f"(f12) : "f"(f11), "f"(f4));
  // PTX:88 ld.global.f32 %f13, [%rd25+4]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (4)))));
  // PTX:89 min.f32 %f14, %f13, %f7
  asm("min.f32 %0, %1, %2;" : "=f"(f14) : "f"(f13), "f"(f7));
  // PTX:90 ld.global.f32 %f15, [%rd25+8]
  f15 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (8)))));
  // PTX:91 min.f32 %f16, %f15, %f10
  asm("min.f32 %0, %1, %2;" : "=f"(f16) : "f"(f15), "f"(f10));
  // PTX:92 max.f32 %f17, %f3, %f2
  asm("max.f32 %0, %1, %2;" : "=f"(f17) : "f"(f3), "f"(f2));
  // PTX:93 max.f32 %f18, %f6, %f5
  asm("max.f32 %0, %1, %2;" : "=f"(f18) : "f"(f6), "f"(f5));
  // PTX:94 max.f32 %f19, %f9, %f8
  asm("max.f32 %0, %1, %2;" : "=f"(f19) : "f"(f9), "f"(f8));
  // PTX:95 max.f32 %f20, %f11, %f17
  asm("max.f32 %0, %1, %2;" : "=f"(f20) : "f"(f11), "f"(f17));
  // PTX:96 max.f32 %f21, %f13, %f18
  asm("max.f32 %0, %1, %2;" : "=f"(f21) : "f"(f13), "f"(f18));
  // PTX:97 max.f32 %f22, %f15, %f19
  asm("max.f32 %0, %1, %2;" : "=f"(f22) : "f"(f15), "f"(f19));
  // PTX:98 sub.f32 %f23, %f12, %f1
  asm("sub.f32 %0, %1, %2;" : "=f"(f23) : "f"(f12), "f"(f1));
  // PTX:99 sub.f32 %f24, %f14, %f1
  asm("sub.f32 %0, %1, %2;" : "=f"(f24) : "f"(f14), "f"(f1));
  // PTX:100 sub.f32 %f25, %f16, %f1
  asm("sub.f32 %0, %1, %2;" : "=f"(f25) : "f"(f16), "f"(f1));
  // PTX:101 add.f32 %f26, %f20, %f1
  asm("add.f32 %0, %1, %2;" : "=f"(f26) : "f"(f20), "f"(f1));
  // PTX:102 add.f32 %f27, %f21, %f1
  asm("add.f32 %0, %1, %2;" : "=f"(f27) : "f"(f21), "f"(f1));
  // PTX:103 add.f32 %f28, %f22, %f1
  asm("add.f32 %0, %1, %2;" : "=f"(f28) : "f"(f22), "f"(f1));
  // PTX:104 cvta.to.global.u64 %rd30, %rd10
  rd30 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd10));
  // PTX:105 mul.lo.s64 %rd31, %rd1, 24
  asm("mul.lo.s64 %0, %1, 24;" : "=l"(rd31) : "l"(rd1));
  // PTX:106 add.s64 %rd32, %rd30, %rd31
  asm("add.s64 %0, %1, %2;" : "=l"(rd32) : "l"(rd30), "l"(rd31));
  // PTX:107 st.global.f32 [%rd32], %f23
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (0))))) = (float)(f23);
  // PTX:108 st.global.f32 [%rd32+4], %f24
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (4))))) = (float)(f24);
  // PTX:109 st.global.f32 [%rd32+8], %f25
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (8))))) = (float)(f25);
  // PTX:110 st.global.f32 [%rd32+12], %f26
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (12))))) = (float)(f26);
  // PTX:111 st.global.f32 [%rd32+16], %f27
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (16))))) = (float)(f27);
  // PTX:112 st.global.f32 [%rd32+20], %f28
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (20))))) = (float)(f28);
  // PTX:114 $L__BB0_5:
L_BB0_5:;
  // PTX:115 ret
  return;
}
