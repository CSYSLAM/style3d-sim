// 机械还原自 PTX：synreal::self_collision_kernel::build_edge_aabbs(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, synreal::Aabb*, float, unsigned long, unsigned long, unsigned long)
// PTX SHA256: ac7f2ea67b408e9c511ed5cd37a299c3b2172d46f664a2e45fcfef28a9f8a377
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__self_collision_kernel__build_edge_aabbs(unsigned long long param0, unsigned long long param1, unsigned long long param2, float param3, unsigned long long param4, unsigned long long param5, unsigned long long param6) {
  int p0, p1, p2;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32;
  // PTX:23 ld.param.u64 %rd8, [_ZN7synreal21self_collision_kernel16build_edge_aabbsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPNS_4AabbEfmmm_param_0]
  rd8 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:24 ld.param.u64 %rd9, [_ZN7synreal21self_collision_kernel16build_edge_aabbsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPNS_4AabbEfmmm_param_1]
  rd9 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:25 ld.param.u64 %rd10, [_ZN7synreal21self_collision_kernel16build_edge_aabbsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPNS_4AabbEfmmm_param_2]
  rd10 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:26 ld.param.f32 %f1, [_ZN7synreal21self_collision_kernel16build_edge_aabbsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPNS_4AabbEfmmm_param_3]
  f1 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param3 + (0))));
  // PTX:27 ld.param.u64 %rd13, [_ZN7synreal21self_collision_kernel16build_edge_aabbsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPNS_4AabbEfmmm_param_4]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:28 ld.param.u64 %rd11, [_ZN7synreal21self_collision_kernel16build_edge_aabbsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPNS_4AabbEfmmm_param_5]
  rd11 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:29 ld.param.u64 %rd12, [_ZN7synreal21self_collision_kernel16build_edge_aabbsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPNS_4AabbEfmmm_param_6]
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
  // PTX:37 @%p1 bra $L__BB1_5
  if (p1) { goto L_BB1_5; }
  // PTX:39 or.b64 %rd16, %rd1, %rd11
  asm("or.b64 %0, %1, %2;" : "=l"(rd16) : "l"(rd1), "l"(rd11));
  // PTX:40 and.b64 %rd17, %rd16, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd17) : "l"(rd16));
  // PTX:41 setp.eq.s64 %p2, %rd17, 0
  p2 = (((long long)(rd17)) == ((long long)(0)));
  // PTX:42 @%p2 bra $L__BB1_3
  if (p2) { goto L_BB1_3; }
  // PTX:44 div.u64 %rd31, %rd1, %rd11
  asm("div.u64 %0, %1, %2;" : "=l"(rd31) : "l"(rd1), "l"(rd11));
  // PTX:45 mul.lo.s64 %rd18, %rd31, %rd11
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd18) : "l"(rd31), "l"(rd11));
  // PTX:46 sub.s64 %rd32, %rd1, %rd18
  asm("sub.s64 %0, %1, %2;" : "=l"(rd32) : "l"(rd1), "l"(rd18));
  // PTX:47 bra.uni $L__BB1_4
  goto L_BB1_4;
  // PTX:49 $L__BB1_3:
L_BB1_3:;
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
  // PTX:55 cvt.u64.u32 %rd31, %r6
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd31) : "r"(r6));
  // PTX:56 cvt.u64.u32 %rd32, %r8
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd32) : "r"(r8));
  // PTX:58 $L__BB1_4:
L_BB1_4:;
  // PTX:59 cvta.to.global.u64 %rd19, %rd8
  rd19 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd8));
  // PTX:60 mul.lo.s64 %rd20, %rd31, %rd12
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd20) : "l"(rd31), "l"(rd12));
  // PTX:61 cvt.u32.u64 %r9, %rd20
  asm("cvt.u32.u64 %0, %1;" : "=r"(r9) : "l"(rd20));
  // PTX:62 cvta.to.global.u64 %rd21, %rd9
  rd21 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd9));
  // PTX:63 shl.b64 %rd22, %rd32, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd22) : "l"(rd32));
  // PTX:64 add.s64 %rd23, %rd21, %rd22
  asm("add.s64 %0, %1, %2;" : "=l"(rd23) : "l"(rd21), "l"(rd22));
  // PTX:65 ld.global.u32 %r10, [%rd23+8]
  r10 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (8)))));
  // PTX:66 add.s32 %r11, %r10, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r11) : "r"(r10), "r"(r9));
  // PTX:67 mul.wide.s32 %rd24, %r11, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd24) : "r"(r11));
  // PTX:68 add.s64 %rd25, %rd19, %rd24
  asm("add.s64 %0, %1, %2;" : "=l"(rd25) : "l"(rd19), "l"(rd24));
  // PTX:69 ld.global.u32 %r12, [%rd23+12]
  r12 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (12)))));
  // PTX:70 add.s32 %r13, %r12, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r13) : "r"(r12), "r"(r9));
  // PTX:71 mul.wide.s32 %rd26, %r13, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd26) : "r"(r13));
  // PTX:72 add.s64 %rd27, %rd19, %rd26
  asm("add.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd19), "l"(rd26));
  // PTX:73 ld.global.f32 %f2, [%rd27]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))));
  // PTX:74 ld.global.f32 %f3, [%rd25]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (0)))));
  // PTX:75 min.f32 %f4, %f3, %f2
  asm("min.f32 %0, %1, %2;" : "=f"(f4) : "f"(f3), "f"(f2));
  // PTX:76 ld.global.f32 %f5, [%rd27+4]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (4)))));
  // PTX:77 ld.global.f32 %f6, [%rd25+4]
  f6 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (4)))));
  // PTX:78 min.f32 %f7, %f6, %f5
  asm("min.f32 %0, %1, %2;" : "=f"(f7) : "f"(f6), "f"(f5));
  // PTX:79 ld.global.f32 %f8, [%rd27+8]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (8)))));
  // PTX:80 ld.global.f32 %f9, [%rd25+8]
  f9 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (8)))));
  // PTX:81 min.f32 %f10, %f9, %f8
  asm("min.f32 %0, %1, %2;" : "=f"(f10) : "f"(f9), "f"(f8));
  // PTX:82 max.f32 %f11, %f3, %f2
  asm("max.f32 %0, %1, %2;" : "=f"(f11) : "f"(f3), "f"(f2));
  // PTX:83 max.f32 %f12, %f6, %f5
  asm("max.f32 %0, %1, %2;" : "=f"(f12) : "f"(f6), "f"(f5));
  // PTX:84 max.f32 %f13, %f9, %f8
  asm("max.f32 %0, %1, %2;" : "=f"(f13) : "f"(f9), "f"(f8));
  // PTX:85 sub.f32 %f14, %f4, %f1
  asm("sub.f32 %0, %1, %2;" : "=f"(f14) : "f"(f4), "f"(f1));
  // PTX:86 sub.f32 %f15, %f7, %f1
  asm("sub.f32 %0, %1, %2;" : "=f"(f15) : "f"(f7), "f"(f1));
  // PTX:87 sub.f32 %f16, %f10, %f1
  asm("sub.f32 %0, %1, %2;" : "=f"(f16) : "f"(f10), "f"(f1));
  // PTX:88 add.f32 %f17, %f11, %f1
  asm("add.f32 %0, %1, %2;" : "=f"(f17) : "f"(f11), "f"(f1));
  // PTX:89 add.f32 %f18, %f12, %f1
  asm("add.f32 %0, %1, %2;" : "=f"(f18) : "f"(f12), "f"(f1));
  // PTX:90 add.f32 %f19, %f13, %f1
  asm("add.f32 %0, %1, %2;" : "=f"(f19) : "f"(f13), "f"(f1));
  // PTX:91 cvta.to.global.u64 %rd28, %rd10
  rd28 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd10));
  // PTX:92 mul.lo.s64 %rd29, %rd1, 24
  asm("mul.lo.s64 %0, %1, 24;" : "=l"(rd29) : "l"(rd1));
  // PTX:93 add.s64 %rd30, %rd28, %rd29
  asm("add.s64 %0, %1, %2;" : "=l"(rd30) : "l"(rd28), "l"(rd29));
  // PTX:94 st.global.f32 [%rd30], %f14
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0))))) = (float)(f14);
  // PTX:95 st.global.f32 [%rd30+4], %f15
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (4))))) = (float)(f15);
  // PTX:96 st.global.f32 [%rd30+8], %f16
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (8))))) = (float)(f16);
  // PTX:97 st.global.f32 [%rd30+12], %f17
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (12))))) = (float)(f17);
  // PTX:98 st.global.f32 [%rd30+16], %f18
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (16))))) = (float)(f18);
  // PTX:99 st.global.f32 [%rd30+20], %f19
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (20))))) = (float)(f19);
  // PTX:101 $L__BB1_5:
L_BB1_5:;
  // PTX:102 ret
  return;
}
