// 机械还原自 PTX：synreal::self_collision_kernel::refit_bvh(synreal::Aabb const*, int const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, unsigned int*, synreal::Aabb*, unsigned long, unsigned long)
// PTX SHA256: 464268a6305c950eb16b4afd5a267a6af85bad7da591bc5c9cdc99b665c79017
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__self_collision_kernel__refit_bvh(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7) {
  int p0, p1, p2, p3, p4, p5;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66;
  // PTX:24 ld.param.u64 %rd15, [_ZN7synreal21self_collision_kernel9refit_bvhEPKNS_4AabbEPKiS5_PKN3glm3vecILi2EiLNS6_9qualifierE0EEEPjPS1_mm_param_0]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:25 ld.param.u64 %rd16, [_ZN7synreal21self_collision_kernel9refit_bvhEPKNS_4AabbEPKiS5_PKN3glm3vecILi2EiLNS6_9qualifierE0EEEPjPS1_mm_param_1]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:26 ld.param.u64 %rd20, [_ZN7synreal21self_collision_kernel9refit_bvhEPKNS_4AabbEPKiS5_PKN3glm3vecILi2EiLNS6_9qualifierE0EEEPjPS1_mm_param_2]
  rd20 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:27 ld.param.u64 %rd17, [_ZN7synreal21self_collision_kernel9refit_bvhEPKNS_4AabbEPKiS5_PKN3glm3vecILi2EiLNS6_9qualifierE0EEEPjPS1_mm_param_3]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:28 ld.param.u64 %rd18, [_ZN7synreal21self_collision_kernel9refit_bvhEPKNS_4AabbEPKiS5_PKN3glm3vecILi2EiLNS6_9qualifierE0EEEPjPS1_mm_param_4]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:29 ld.param.u64 %rd21, [_ZN7synreal21self_collision_kernel9refit_bvhEPKNS_4AabbEPKiS5_PKN3glm3vecILi2EiLNS6_9qualifierE0EEEPjPS1_mm_param_5]
  rd21 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:30 ld.param.u64 %rd22, [_ZN7synreal21self_collision_kernel9refit_bvhEPKNS_4AabbEPKiS5_PKN3glm3vecILi2EiLNS6_9qualifierE0EEEPjPS1_mm_param_6]
  rd22 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:31 ld.param.u64 %rd19, [_ZN7synreal21self_collision_kernel9refit_bvhEPKNS_4AabbEPKiS5_PKN3glm3vecILi2EiLNS6_9qualifierE0EEEPjPS1_mm_param_7]
  rd19 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:32 cvta.to.global.u64 %rd1, %rd20
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd20));
  // PTX:33 cvta.to.global.u64 %rd2, %rd21
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd21));
  // PTX:34 mov.u32 %r4, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r4) : "r"(blockIdx.x));
  // PTX:35 mov.u32 %r5, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r5) : "r"(blockDim.x));
  // PTX:36 mul.wide.u32 %rd23, %r4, %r5
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd23) : "r"(r4), "r"(r5));
  // PTX:37 mov.u32 %r6, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r6) : "r"(threadIdx.x));
  // PTX:38 cvt.u64.u32 %rd24, %r6
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd24) : "r"(r6));
  // PTX:39 add.s64 %rd3, %rd23, %rd24
  asm("add.s64 %0, %1, %2;" : "=l"(rd3) : "l"(rd23), "l"(rd24));
  // PTX:40 setp.ge.u64 %p1, %rd3, %rd22
  p1 = (((unsigned long long)(rd3)) >= ((unsigned long long)(rd22)));
  // PTX:41 @%p1 bra $L__BB3_8
  if (p1) { goto L_BB3_8; }
  // PTX:43 or.b64 %rd25, %rd3, %rd19
  asm("or.b64 %0, %1, %2;" : "=l"(rd25) : "l"(rd3), "l"(rd19));
  // PTX:44 and.b64 %rd26, %rd25, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd26) : "l"(rd25));
  // PTX:45 setp.eq.s64 %p2, %rd26, 0
  p2 = (((long long)(rd26)) == ((long long)(0)));
  // PTX:46 @%p2 bra $L__BB3_3
  if (p2) { goto L_BB3_3; }
  // PTX:48 div.u64 %rd65, %rd3, %rd19
  asm("div.u64 %0, %1, %2;" : "=l"(rd65) : "l"(rd3), "l"(rd19));
  // PTX:49 mul.lo.s64 %rd27, %rd65, %rd19
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd65), "l"(rd19));
  // PTX:50 sub.s64 %rd66, %rd3, %rd27
  asm("sub.s64 %0, %1, %2;" : "=l"(rd66) : "l"(rd3), "l"(rd27));
  // PTX:51 bra.uni $L__BB3_4
  goto L_BB3_4;
  // PTX:53 $L__BB3_3:
L_BB3_3:;
  // PTX:54 cvt.u32.u64 %r7, %rd19
  asm("cvt.u32.u64 %0, %1;" : "=r"(r7) : "l"(rd19));
  // PTX:55 cvt.u32.u64 %r8, %rd3
  asm("cvt.u32.u64 %0, %1;" : "=r"(r8) : "l"(rd3));
  // PTX:56 div.u32 %r9, %r8, %r7
  asm("div.u32 %0, %1, %2;" : "=r"(r9) : "r"(r8), "r"(r7));
  // PTX:57 mul.lo.s32 %r10, %r9, %r7
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r10) : "r"(r9), "r"(r7));
  // PTX:58 sub.s32 %r11, %r8, %r10
  asm("sub.s32 %0, %1, %2;" : "=r"(r11) : "r"(r8), "r"(r10));
  // PTX:59 cvt.u64.u32 %rd65, %r9
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd65) : "r"(r9));
  // PTX:60 cvt.u64.u32 %rd66, %r11
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd66) : "r"(r11));
  // PTX:62 $L__BB3_4:
L_BB3_4:;
  // PTX:63 add.s64 %rd28, %rd19, -1
  asm("add.s64 %0, %1, -1;" : "=l"(rd28) : "l"(rd19));
  // PTX:64 add.s64 %rd29, %rd28, %rd19
  asm("add.s64 %0, %1, %2;" : "=l"(rd29) : "l"(rd28), "l"(rd19));
  // PTX:65 mul.lo.s64 %rd10, %rd65, %rd29
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd10) : "l"(rd65), "l"(rd29));
  // PTX:66 mul.lo.s64 %rd11, %rd65, %rd28
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd11) : "l"(rd65), "l"(rd28));
  // PTX:67 add.s64 %rd30, %rd66, %rd28
  asm("add.s64 %0, %1, %2;" : "=l"(rd30) : "l"(rd66), "l"(rd28));
  // PTX:68 shl.b64 %rd31, %rd30, 32
  asm("shl.b64 %0, %1, 32;" : "=l"(rd31) : "l"(rd30));
  // PTX:69 cvt.s64.s32 %rd32, %rd30
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd32) : "l"(rd30));
  // PTX:70 add.s64 %rd33, %rd32, %rd10
  asm("add.s64 %0, %1, %2;" : "=l"(rd33) : "l"(rd32), "l"(rd10));
  // PTX:71 cvta.to.global.u64 %rd34, %rd16
  rd34 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd16));
  // PTX:72 shl.b64 %rd35, %rd66, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd35) : "l"(rd66));
  // PTX:73 add.s64 %rd36, %rd34, %rd35
  asm("add.s64 %0, %1, %2;" : "=l"(rd36) : "l"(rd34), "l"(rd35));
  // PTX:74 ld.global.s32 %rd37, [%rd36]
  rd37 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (0)))));
  // PTX:75 mul.lo.s64 %rd38, %rd65, %rd19
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd38) : "l"(rd65), "l"(rd19));
  // PTX:76 add.s64 %rd39, %rd38, %rd37
  asm("add.s64 %0, %1, %2;" : "=l"(rd39) : "l"(rd38), "l"(rd37));
  // PTX:77 cvta.to.global.u64 %rd40, %rd15
  rd40 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd15));
  // PTX:78 mul.lo.s64 %rd41, %rd39, 24
  asm("mul.lo.s64 %0, %1, 24;" : "=l"(rd41) : "l"(rd39));
  // PTX:79 add.s64 %rd42, %rd40, %rd41
  asm("add.s64 %0, %1, %2;" : "=l"(rd42) : "l"(rd40), "l"(rd41));
  // PTX:80 ld.global.u32 %r12, [%rd42]
  r12 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (0)))));
  // PTX:81 ld.global.u32 %r13, [%rd42+4]
  r13 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (4)))));
  // PTX:82 ld.global.u32 %r14, [%rd42+8]
  r14 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (8)))));
  // PTX:83 ld.global.u32 %r15, [%rd42+12]
  r15 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (12)))));
  // PTX:84 ld.global.u32 %r16, [%rd42+16]
  r16 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (16)))));
  // PTX:85 ld.global.u32 %r17, [%rd42+20]
  r17 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (20)))));
  // PTX:86 mul.lo.s64 %rd43, %rd33, 24
  asm("mul.lo.s64 %0, %1, 24;" : "=l"(rd43) : "l"(rd33));
  // PTX:87 add.s64 %rd44, %rd2, %rd43
  asm("add.s64 %0, %1, %2;" : "=l"(rd44) : "l"(rd2), "l"(rd43));
  // PTX:88 st.global.u32 [%rd44], %r12
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0))))) = (unsigned)(r12);
  // PTX:89 st.global.u32 [%rd44+4], %r13
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (4))))) = (unsigned)(r13);
  // PTX:90 st.global.u32 [%rd44+8], %r14
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (8))))) = (unsigned)(r14);
  // PTX:91 st.global.u32 [%rd44+12], %r15
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (12))))) = (unsigned)(r15);
  // PTX:92 st.global.u32 [%rd44+16], %r16
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (16))))) = (unsigned)(r16);
  // PTX:93 st.global.u32 [%rd44+20], %r17
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (20))))) = (unsigned)(r17);
  // PTX:94 membar.gl
  __threadfence();
  // PTX:95 shr.s64 %rd45, %rd31, 30
  asm("shr.s64 %0, %1, 30;" : "=l"(rd45) : "l"(rd31));
  // PTX:96 add.s64 %rd46, %rd1, %rd45
  asm("add.s64 %0, %1, %2;" : "=l"(rd46) : "l"(rd1), "l"(rd45));
  // PTX:97 ld.global.u32 %r19, [%rd46]
  r19 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (0)))));
  // PTX:98 setp.lt.s32 %p3, %r19, 0
  p3 = (((int)(r19)) < ((int)(0)));
  // PTX:99 @%p3 bra $L__BB3_8
  if (p3) { goto L_BB3_8; }
  // PTX:101 cvta.to.global.u64 %rd12, %rd18
  rd12 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd18));
  // PTX:102 cvta.to.global.u64 %rd13, %rd17
  rd13 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd17));
  // PTX:104 $L__BB3_6:
L_BB3_6:;
  // PTX:105 cvt.s64.s32 %rd14, %r19
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd14) : "r"(r19));
  // PTX:106 add.s64 %rd47, %rd11, %rd14
  asm("add.s64 %0, %1, %2;" : "=l"(rd47) : "l"(rd11), "l"(rd14));
  // PTX:107 shl.b64 %rd48, %rd47, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd48) : "l"(rd47));
  // PTX:108 add.s64 %rd49, %rd12, %rd48
  asm("add.s64 %0, %1, %2;" : "=l"(rd49) : "l"(rd12), "l"(rd48));
  // PTX:109 atom.global.add.u32 %r18, [%rd49], 1
  r18 = atomicAdd(reinterpret_cast<unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))), (unsigned)(1));
  // PTX:110 setp.eq.s32 %p4, %r18, 0
  p4 = (((int)(r18)) == ((int)(0)));
  // PTX:111 @%p4 bra $L__BB3_8
  if (p4) { goto L_BB3_8; }
  // PTX:113 membar.gl
  __threadfence();
  // PTX:114 shl.b64 %rd50, %rd14, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd50) : "l"(rd14));
  // PTX:115 add.s64 %rd51, %rd13, %rd50
  asm("add.s64 %0, %1, %2;" : "=l"(rd51) : "l"(rd13), "l"(rd50));
  // PTX:116 ld.global.s32 %rd52, [%rd51]
  rd52 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))));
  // PTX:117 add.s64 %rd53, %rd10, %rd52
  asm("add.s64 %0, %1, %2;" : "=l"(rd53) : "l"(rd10), "l"(rd52));
  // PTX:118 mul.lo.s64 %rd54, %rd53, 24
  asm("mul.lo.s64 %0, %1, 24;" : "=l"(rd54) : "l"(rd53));
  // PTX:119 add.s64 %rd55, %rd2, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd55) : "l"(rd2), "l"(rd54));
  // PTX:120 ld.global.s32 %rd56, [%rd51+4]
  rd56 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (4)))));
  // PTX:121 add.s64 %rd57, %rd10, %rd56
  asm("add.s64 %0, %1, %2;" : "=l"(rd57) : "l"(rd10), "l"(rd56));
  // PTX:122 mul.lo.s64 %rd58, %rd57, 24
  asm("mul.lo.s64 %0, %1, 24;" : "=l"(rd58) : "l"(rd57));
  // PTX:123 add.s64 %rd59, %rd2, %rd58
  asm("add.s64 %0, %1, %2;" : "=l"(rd59) : "l"(rd2), "l"(rd58));
  // PTX:124 ld.global.f32 %f1, [%rd59]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))));
  // PTX:125 ld.global.f32 %f2, [%rd55]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))));
  // PTX:126 min.f32 %f3, %f2, %f1
  asm("min.f32 %0, %1, %2;" : "=f"(f3) : "f"(f2), "f"(f1));
  // PTX:127 ld.global.f32 %f4, [%rd59+4]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (4)))));
  // PTX:128 ld.global.f32 %f5, [%rd55+4]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (4)))));
  // PTX:129 min.f32 %f6, %f5, %f4
  asm("min.f32 %0, %1, %2;" : "=f"(f6) : "f"(f5), "f"(f4));
  // PTX:130 ld.global.f32 %f7, [%rd59+8]
  f7 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (8)))));
  // PTX:131 ld.global.f32 %f8, [%rd55+8]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (8)))));
  // PTX:132 min.f32 %f9, %f8, %f7
  asm("min.f32 %0, %1, %2;" : "=f"(f9) : "f"(f8), "f"(f7));
  // PTX:133 ld.global.f32 %f10, [%rd59+12]
  f10 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (12)))));
  // PTX:134 ld.global.f32 %f11, [%rd55+12]
  f11 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (12)))));
  // PTX:135 max.f32 %f12, %f11, %f10
  asm("max.f32 %0, %1, %2;" : "=f"(f12) : "f"(f11), "f"(f10));
  // PTX:136 ld.global.f32 %f13, [%rd59+16]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (16)))));
  // PTX:137 ld.global.f32 %f14, [%rd55+16]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (16)))));
  // PTX:138 max.f32 %f15, %f14, %f13
  asm("max.f32 %0, %1, %2;" : "=f"(f15) : "f"(f14), "f"(f13));
  // PTX:139 ld.global.f32 %f16, [%rd59+20]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (20)))));
  // PTX:140 ld.global.f32 %f17, [%rd55+20]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (20)))));
  // PTX:141 max.f32 %f18, %f17, %f16
  asm("max.f32 %0, %1, %2;" : "=f"(f18) : "f"(f17), "f"(f16));
  // PTX:142 add.s64 %rd60, %rd10, %rd14
  asm("add.s64 %0, %1, %2;" : "=l"(rd60) : "l"(rd10), "l"(rd14));
  // PTX:143 mul.lo.s64 %rd61, %rd60, 24
  asm("mul.lo.s64 %0, %1, 24;" : "=l"(rd61) : "l"(rd60));
  // PTX:144 add.s64 %rd62, %rd2, %rd61
  asm("add.s64 %0, %1, %2;" : "=l"(rd62) : "l"(rd2), "l"(rd61));
  // PTX:145 st.global.f32 [%rd62], %f3
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0))))) = (float)(f3);
  // PTX:146 st.global.f32 [%rd62+4], %f6
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (4))))) = (float)(f6);
  // PTX:147 st.global.f32 [%rd62+8], %f9
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (8))))) = (float)(f9);
  // PTX:148 st.global.f32 [%rd62+12], %f12
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (12))))) = (float)(f12);
  // PTX:149 st.global.f32 [%rd62+16], %f15
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (16))))) = (float)(f15);
  // PTX:150 st.global.f32 [%rd62+20], %f18
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (20))))) = (float)(f18);
  // PTX:151 membar.gl
  __threadfence();
  // PTX:152 shl.b64 %rd63, %rd14, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd63) : "l"(rd14));
  // PTX:153 add.s64 %rd64, %rd1, %rd63
  asm("add.s64 %0, %1, %2;" : "=l"(rd64) : "l"(rd1), "l"(rd63));
  // PTX:154 ld.global.u32 %r19, [%rd64]
  r19 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (0)))));
  // PTX:155 setp.gt.s32 %p5, %r19, -1
  p5 = (((int)(r19)) > ((int)(-1)));
  // PTX:156 @%p5 bra $L__BB3_6
  if (p5) { goto L_BB3_6; }
  // PTX:158 $L__BB3_8:
L_BB3_8:;
  // PTX:159 ret
  return;
}
