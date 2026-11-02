// 机械还原自 PTX：synreal::kernel::refit_aabbs(synreal::Aabb*, synreal::Aabb const*, int const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, unsigned int*, unsigned int)
// PTX SHA256: 627dab9761ab9d6b9868476b3f4eb8e290b417bbd9906da03f36067086e08989
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__refit_aabbs(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned param6) {
  int p0, p1, p2, p3, p4;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33;
  // PTX:23 ld.param.u64 %rd10, [_ZN7synreal6kernel11refit_aabbsEPNS_4AabbEPKS1_PKiS6_PKN3glm3vecILi2EiLNS7_9qualifierE0EEEPjj_param_0]
  rd10 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:24 ld.param.u64 %rd6, [_ZN7synreal6kernel11refit_aabbsEPNS_4AabbEPKS1_PKiS6_PKN3glm3vecILi2EiLNS7_9qualifierE0EEEPjj_param_1]
  rd6 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:25 ld.param.u64 %rd7, [_ZN7synreal6kernel11refit_aabbsEPNS_4AabbEPKS1_PKiS6_PKN3glm3vecILi2EiLNS7_9qualifierE0EEEPjj_param_2]
  rd7 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:26 ld.param.u64 %rd11, [_ZN7synreal6kernel11refit_aabbsEPNS_4AabbEPKS1_PKiS6_PKN3glm3vecILi2EiLNS7_9qualifierE0EEEPjj_param_3]
  rd11 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:27 ld.param.u64 %rd8, [_ZN7synreal6kernel11refit_aabbsEPNS_4AabbEPKS1_PKiS6_PKN3glm3vecILi2EiLNS7_9qualifierE0EEEPjj_param_4]
  rd8 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:28 ld.param.u64 %rd9, [_ZN7synreal6kernel11refit_aabbsEPNS_4AabbEPKS1_PKiS6_PKN3glm3vecILi2EiLNS7_9qualifierE0EEEPjj_param_5]
  rd9 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:29 ld.param.u32 %r5, [_ZN7synreal6kernel11refit_aabbsEPNS_4AabbEPKS1_PKiS6_PKN3glm3vecILi2EiLNS7_9qualifierE0EEEPjj_param_6]
  r5 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param6 + (0))));
  // PTX:30 cvta.to.global.u64 %rd1, %rd11
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd11));
  // PTX:31 cvta.to.global.u64 %rd2, %rd10
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd10));
  // PTX:32 mov.u32 %r6, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r6) : "r"(blockDim.x));
  // PTX:33 mov.u32 %r7, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r7) : "r"(blockIdx.x));
  // PTX:34 mov.u32 %r8, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r8) : "r"(threadIdx.x));
  // PTX:35 mad.lo.s32 %r1, %r7, %r6, %r8
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r1) : "r"(r7), "r"(r6), "r"(r8));
  // PTX:36 setp.ge.u32 %p1, %r1, %r5
  p1 = (((unsigned)(r1)) >= ((unsigned)(r5)));
  // PTX:37 @%p1 bra $L__BB4_5
  if (p1) { goto L_BB4_5; }
  // PTX:39 cvta.to.global.u64 %rd12, %rd7
  rd12 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd7));
  // PTX:40 add.s32 %r9, %r1, %r5
  asm("add.s32 %0, %1, %2;" : "=r"(r9) : "r"(r1), "r"(r5));
  // PTX:41 add.s32 %r10, %r9, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r10) : "r"(r9));
  // PTX:42 mul.wide.u32 %rd13, %r1, 4
  asm("mul.wide.u32 %0, %1, 4;" : "=l"(rd13) : "r"(r1));
  // PTX:43 add.s64 %rd14, %rd12, %rd13
  asm("add.s64 %0, %1, %2;" : "=l"(rd14) : "l"(rd12), "l"(rd13));
  // PTX:44 ld.global.u32 %r11, [%rd14]
  r11 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:45 cvta.to.global.u64 %rd15, %rd6
  rd15 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd6));
  // PTX:46 mul.wide.s32 %rd16, %r11, 24
  asm("mul.wide.s32 %0, %1, 24;" : "=l"(rd16) : "r"(r11));
  // PTX:47 add.s64 %rd17, %rd15, %rd16
  asm("add.s64 %0, %1, %2;" : "=l"(rd17) : "l"(rd15), "l"(rd16));
  // PTX:48 ld.global.u32 %r12, [%rd17]
  r12 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:49 ld.global.u32 %r13, [%rd17+4]
  r13 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (4)))));
  // PTX:50 ld.global.u32 %r14, [%rd17+8]
  r14 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (8)))));
  // PTX:51 ld.global.u32 %r15, [%rd17+12]
  r15 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (12)))));
  // PTX:52 ld.global.u32 %r16, [%rd17+16]
  r16 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (16)))));
  // PTX:53 ld.global.u32 %r17, [%rd17+20]
  r17 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (20)))));
  // PTX:54 mul.wide.s32 %rd18, %r10, 24
  asm("mul.wide.s32 %0, %1, 24;" : "=l"(rd18) : "r"(r10));
  // PTX:55 add.s64 %rd19, %rd2, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd2), "l"(rd18));
  // PTX:56 st.global.u32 [%rd19], %r12
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0))))) = (unsigned)(r12);
  // PTX:57 st.global.u32 [%rd19+4], %r13
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (4))))) = (unsigned)(r13);
  // PTX:58 st.global.u32 [%rd19+8], %r14
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (8))))) = (unsigned)(r14);
  // PTX:59 st.global.u32 [%rd19+12], %r15
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (12))))) = (unsigned)(r15);
  // PTX:60 st.global.u32 [%rd19+16], %r16
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (16))))) = (unsigned)(r16);
  // PTX:61 st.global.u32 [%rd19+20], %r17
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (20))))) = (unsigned)(r17);
  // PTX:62 membar.gl
  __threadfence();
  // PTX:63 mul.wide.s32 %rd20, %r10, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd20) : "r"(r10));
  // PTX:64 add.s64 %rd21, %rd1, %rd20
  asm("add.s64 %0, %1, %2;" : "=l"(rd21) : "l"(rd1), "l"(rd20));
  // PTX:65 ld.global.u32 %r21, [%rd21]
  r21 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (0)))));
  // PTX:66 setp.lt.s32 %p2, %r21, 0
  p2 = (((int)(r21)) < ((int)(0)));
  // PTX:67 @%p2 bra $L__BB4_5
  if (p2) { goto L_BB4_5; }
  // PTX:69 cvta.to.global.u64 %rd3, %rd8
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd8));
  // PTX:70 cvta.to.global.u64 %rd4, %rd9
  rd4 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd9));
  // PTX:72 $L__BB4_3:
L_BB4_3:;
  // PTX:73 cvt.s64.s32 %rd5, %r21
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd5) : "r"(r21));
  // PTX:74 mul.wide.s32 %rd22, %r21, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd22) : "r"(r21));
  // PTX:75 add.s64 %rd23, %rd4, %rd22
  asm("add.s64 %0, %1, %2;" : "=l"(rd23) : "l"(rd4), "l"(rd22));
  // PTX:76 atom.global.add.u32 %r18, [%rd23], 1
  r18 = atomicAdd(reinterpret_cast<unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (0)))), (unsigned)(1));
  // PTX:77 setp.eq.s32 %p3, %r18, 0
  p3 = (((int)(r18)) == ((int)(0)));
  // PTX:78 @%p3 bra $L__BB4_5
  if (p3) { goto L_BB4_5; }
  // PTX:80 membar.gl
  __threadfence();
  // PTX:81 shl.b64 %rd24, %rd5, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd24) : "l"(rd5));
  // PTX:82 add.s64 %rd25, %rd3, %rd24
  asm("add.s64 %0, %1, %2;" : "=l"(rd25) : "l"(rd3), "l"(rd24));
  // PTX:83 ld.global.u32 %r19, [%rd25]
  r19 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (0)))));
  // PTX:84 mul.wide.s32 %rd26, %r19, 24
  asm("mul.wide.s32 %0, %1, 24;" : "=l"(rd26) : "r"(r19));
  // PTX:85 add.s64 %rd27, %rd2, %rd26
  asm("add.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd2), "l"(rd26));
  // PTX:86 ld.global.u32 %r20, [%rd25+4]
  r20 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (4)))));
  // PTX:87 mul.wide.s32 %rd28, %r20, 24
  asm("mul.wide.s32 %0, %1, 24;" : "=l"(rd28) : "r"(r20));
  // PTX:88 add.s64 %rd29, %rd2, %rd28
  asm("add.s64 %0, %1, %2;" : "=l"(rd29) : "l"(rd2), "l"(rd28));
  // PTX:89 ld.global.f32 %f1, [%rd29]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (0)))));
  // PTX:90 ld.global.f32 %f2, [%rd27]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))));
  // PTX:91 min.f32 %f3, %f2, %f1
  asm("min.f32 %0, %1, %2;" : "=f"(f3) : "f"(f2), "f"(f1));
  // PTX:92 ld.global.f32 %f4, [%rd29+4]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (4)))));
  // PTX:93 ld.global.f32 %f5, [%rd27+4]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (4)))));
  // PTX:94 min.f32 %f6, %f5, %f4
  asm("min.f32 %0, %1, %2;" : "=f"(f6) : "f"(f5), "f"(f4));
  // PTX:95 ld.global.f32 %f7, [%rd29+8]
  f7 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (8)))));
  // PTX:96 ld.global.f32 %f8, [%rd27+8]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (8)))));
  // PTX:97 min.f32 %f9, %f8, %f7
  asm("min.f32 %0, %1, %2;" : "=f"(f9) : "f"(f8), "f"(f7));
  // PTX:98 ld.global.f32 %f10, [%rd29+12]
  f10 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (12)))));
  // PTX:99 ld.global.f32 %f11, [%rd27+12]
  f11 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (12)))));
  // PTX:100 max.f32 %f12, %f11, %f10
  asm("max.f32 %0, %1, %2;" : "=f"(f12) : "f"(f11), "f"(f10));
  // PTX:101 ld.global.f32 %f13, [%rd29+16]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (16)))));
  // PTX:102 ld.global.f32 %f14, [%rd27+16]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (16)))));
  // PTX:103 max.f32 %f15, %f14, %f13
  asm("max.f32 %0, %1, %2;" : "=f"(f15) : "f"(f14), "f"(f13));
  // PTX:104 ld.global.f32 %f16, [%rd29+20]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (20)))));
  // PTX:105 ld.global.f32 %f17, [%rd27+20]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (20)))));
  // PTX:106 max.f32 %f18, %f17, %f16
  asm("max.f32 %0, %1, %2;" : "=f"(f18) : "f"(f17), "f"(f16));
  // PTX:107 mul.lo.s64 %rd30, %rd5, 24
  asm("mul.lo.s64 %0, %1, 24;" : "=l"(rd30) : "l"(rd5));
  // PTX:108 add.s64 %rd31, %rd2, %rd30
  asm("add.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd2), "l"(rd30));
  // PTX:109 st.global.f32 [%rd31], %f3
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (0))))) = (float)(f3);
  // PTX:110 st.global.f32 [%rd31+4], %f6
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (4))))) = (float)(f6);
  // PTX:111 st.global.f32 [%rd31+8], %f9
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (8))))) = (float)(f9);
  // PTX:112 st.global.f32 [%rd31+12], %f12
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (12))))) = (float)(f12);
  // PTX:113 st.global.f32 [%rd31+16], %f15
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (16))))) = (float)(f15);
  // PTX:114 st.global.f32 [%rd31+20], %f18
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (20))))) = (float)(f18);
  // PTX:115 membar.gl
  __threadfence();
  // PTX:116 shl.b64 %rd32, %rd5, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd32) : "l"(rd5));
  // PTX:117 add.s64 %rd33, %rd1, %rd32
  asm("add.s64 %0, %1, %2;" : "=l"(rd33) : "l"(rd1), "l"(rd32));
  // PTX:118 ld.global.u32 %r21, [%rd33]
  r21 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (0)))));
  // PTX:119 setp.gt.s32 %p4, %r21, -1
  p4 = (((int)(r21)) > ((int)(-1)));
  // PTX:120 @%p4 bra $L__BB4_3
  if (p4) { goto L_BB4_3; }
  // PTX:122 $L__BB4_5:
L_BB4_5:;
  // PTX:123 ret
  return;
}
