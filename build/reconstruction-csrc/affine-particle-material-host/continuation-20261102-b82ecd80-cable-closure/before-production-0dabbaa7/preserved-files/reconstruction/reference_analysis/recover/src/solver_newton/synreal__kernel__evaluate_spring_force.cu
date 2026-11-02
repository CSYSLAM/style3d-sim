// 机械还原自 PTX：synreal::kernel::evaluate_spring_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, float const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 214b67cf2a483e8ed9390ee99a767a1a6d5e97a87656dc6d52da2dfb1847bebc
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__evaluate_spring_force(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7) {
  int p0, p1, p2, p3;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47;
  // PTX:24 ld.param.u64 %rd10, [_ZN7synreal6kernel21evaluate_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKfSB_PS4_mmm_param_0]
  rd10 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:25 ld.param.u64 %rd11, [_ZN7synreal6kernel21evaluate_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKfSB_PS4_mmm_param_1]
  rd11 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:26 ld.param.u64 %rd12, [_ZN7synreal6kernel21evaluate_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKfSB_PS4_mmm_param_2]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:27 ld.param.u64 %rd13, [_ZN7synreal6kernel21evaluate_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKfSB_PS4_mmm_param_3]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:28 ld.param.u64 %rd14, [_ZN7synreal6kernel21evaluate_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKfSB_PS4_mmm_param_4]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:29 ld.param.u64 %rd17, [_ZN7synreal6kernel21evaluate_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKfSB_PS4_mmm_param_5]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:30 ld.param.u64 %rd15, [_ZN7synreal6kernel21evaluate_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKfSB_PS4_mmm_param_6]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:31 ld.param.u64 %rd16, [_ZN7synreal6kernel21evaluate_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKfSB_PS4_mmm_param_7]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:32 mov.u32 %r7, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r7) : "r"(blockIdx.x));
  // PTX:33 mov.u32 %r8, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r8) : "r"(blockDim.x));
  // PTX:34 mul.wide.u32 %rd18, %r7, %r8
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd18) : "r"(r7), "r"(r8));
  // PTX:35 mov.u32 %r9, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r9) : "r"(threadIdx.x));
  // PTX:36 cvt.u64.u32 %rd19, %r9
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd19) : "r"(r9));
  // PTX:37 add.s64 %rd1, %rd18, %rd19
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd18), "l"(rd19));
  // PTX:38 setp.ge.u64 %p1, %rd1, %rd17
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd17)));
  // PTX:39 @%p1 bra $L__BB13_7
  if (p1) { goto L_BB13_7; }
  // PTX:41 or.b64 %rd20, %rd1, %rd15
  asm("or.b64 %0, %1, %2;" : "=l"(rd20) : "l"(rd1), "l"(rd15));
  // PTX:42 and.b64 %rd21, %rd20, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd21) : "l"(rd20));
  // PTX:43 setp.eq.s64 %p2, %rd21, 0
  p2 = (((long long)(rd21)) == ((long long)(0)));
  // PTX:44 @%p2 bra $L__BB13_3
  if (p2) { goto L_BB13_3; }
  // PTX:46 div.u64 %rd46, %rd1, %rd15
  asm("div.u64 %0, %1, %2;" : "=l"(rd46) : "l"(rd1), "l"(rd15));
  // PTX:47 mul.lo.s64 %rd22, %rd46, %rd15
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd22) : "l"(rd46), "l"(rd15));
  // PTX:48 sub.s64 %rd47, %rd1, %rd22
  asm("sub.s64 %0, %1, %2;" : "=l"(rd47) : "l"(rd1), "l"(rd22));
  // PTX:49 bra.uni $L__BB13_4
  goto L_BB13_4;
  // PTX:51 $L__BB13_3:
L_BB13_3:;
  // PTX:52 cvt.u32.u64 %r10, %rd15
  asm("cvt.u32.u64 %0, %1;" : "=r"(r10) : "l"(rd15));
  // PTX:53 cvt.u32.u64 %r11, %rd1
  asm("cvt.u32.u64 %0, %1;" : "=r"(r11) : "l"(rd1));
  // PTX:54 div.u32 %r12, %r11, %r10
  asm("div.u32 %0, %1, %2;" : "=r"(r12) : "r"(r11), "r"(r10));
  // PTX:55 mul.lo.s32 %r13, %r12, %r10
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r13) : "r"(r12), "r"(r10));
  // PTX:56 sub.s32 %r14, %r11, %r13
  asm("sub.s32 %0, %1, %2;" : "=r"(r14) : "r"(r11), "r"(r13));
  // PTX:57 cvt.u64.u32 %rd46, %r12
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd46) : "r"(r12));
  // PTX:58 cvt.u64.u32 %rd47, %r14
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd47) : "r"(r14));
  // PTX:60 $L__BB13_4:
L_BB13_4:;
  // PTX:61 cvta.to.global.u64 %rd23, %rd10
  rd23 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd10));
  // PTX:62 mul.lo.s64 %rd24, %rd46, %rd16
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd24) : "l"(rd46), "l"(rd16));
  // PTX:63 cvt.u32.u64 %r18, %rd24
  asm("cvt.u32.u64 %0, %1;" : "=r"(r18) : "l"(rd24));
  // PTX:64 cvta.to.global.u64 %rd25, %rd11
  rd25 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd11));
  // PTX:65 shl.b64 %rd26, %rd47, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd26) : "l"(rd47));
  // PTX:66 add.s64 %rd27, %rd25, %rd26
  asm("add.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd25), "l"(rd26));
  // PTX:67 ld.global.u32 %r19, [%rd27]
  r19 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))));
  // PTX:68 add.s32 %r20, %r19, %r18
  asm("add.s32 %0, %1, %2;" : "=r"(r20) : "r"(r19), "r"(r18));
  // PTX:69 ld.global.u32 %r21, [%rd27+4]
  r21 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (4)))));
  // PTX:70 add.s32 %r22, %r21, %r18
  asm("add.s32 %0, %1, %2;" : "=r"(r22) : "r"(r21), "r"(r18));
  // PTX:71 cvt.s64.s32 %rd8, %r22
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd8) : "r"(r22));
  // PTX:72 mul.wide.s32 %rd28, %r22, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd28) : "r"(r22));
  // PTX:73 add.s64 %rd29, %rd23, %rd28
  asm("add.s64 %0, %1, %2;" : "=l"(rd29) : "l"(rd23), "l"(rd28));
  // PTX:74 cvt.s64.s32 %rd9, %r20
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd9) : "r"(r20));
  // PTX:75 mul.wide.s32 %rd30, %r20, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd30) : "r"(r20));
  // PTX:76 add.s64 %rd31, %rd23, %rd30
  asm("add.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd23), "l"(rd30));
  // PTX:77 ld.global.f32 %f7, [%rd31]
  f7 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (0)))));
  // PTX:78 ld.global.f32 %f8, [%rd29]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (0)))));
  // PTX:79 sub.f32 %f1, %f8, %f7
  asm("sub.f32 %0, %1, %2;" : "=f"(f1) : "f"(f8), "f"(f7));
  // PTX:80 ld.global.f32 %f9, [%rd31+4]
  f9 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (4)))));
  // PTX:81 ld.global.f32 %f10, [%rd29+4]
  f10 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (4)))));
  // PTX:82 sub.f32 %f2, %f10, %f9
  asm("sub.f32 %0, %1, %2;" : "=f"(f2) : "f"(f10), "f"(f9));
  // PTX:83 ld.global.f32 %f11, [%rd31+8]
  f11 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (8)))));
  // PTX:84 ld.global.f32 %f12, [%rd29+8]
  f12 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (8)))));
  // PTX:85 sub.f32 %f3, %f12, %f11
  asm("sub.f32 %0, %1, %2;" : "=f"(f3) : "f"(f12), "f"(f11));
  // PTX:86 cvta.to.global.u64 %rd32, %rd12
  rd32 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd12));
  // PTX:87 shl.b64 %rd33, %rd47, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd33) : "l"(rd47));
  // PTX:88 add.s64 %rd34, %rd32, %rd33
  asm("add.s64 %0, %1, %2;" : "=l"(rd34) : "l"(rd32), "l"(rd33));
  // PTX:89 ld.global.f32 %f4, [%rd34]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (0)))));
  // PTX:90 cvta.to.global.u64 %rd35, %rd13
  rd35 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd13));
  // PTX:91 add.s64 %rd36, %rd35, %rd33
  asm("add.s64 %0, %1, %2;" : "=l"(rd36) : "l"(rd35), "l"(rd33));
  // PTX:92 ld.global.f32 %f5, [%rd36]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (0)))));
  // PTX:93 mul.f32 %f13, %f2, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f13) : "f"(f2), "f"(f2));
  // PTX:94 fma.rn.f32 %f14, %f1, %f1, %f13
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f14) : "f"(f1), "f"(f1), "f"(f13));
  // PTX:95 fma.rn.f32 %f15, %f3, %f3, %f14
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f15) : "f"(f3), "f"(f3), "f"(f14));
  // PTX:96 sqrt.rn.f32 %f6, %f15
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f6) : "f"(f15));
  // PTX:97 setp.leu.f32 %p3, %f6, 0f00000000
  p3 = ((isnan(((float)(f6))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f6)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:98 mov.u32 %r23, 0
  asm("mov.u32 %0, 0;" : "=r"(r23) : );
  // PTX:99 mov.u32 %r24, %r23
  asm("mov.u32 %0, %1;" : "=r"(r24) : "r"(r23));
  // PTX:100 mov.u32 %r25, %r23
  asm("mov.u32 %0, %1;" : "=r"(r25) : "r"(r23));
  // PTX:101 @%p3 bra $L__BB13_6
  if (p3) { goto L_BB13_6; }
  // PTX:103 div.rn.f32 %f16, %f1, %f6
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f16) : "f"(f1), "f"(f6));
  // PTX:104 div.rn.f32 %f17, %f2, %f6
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f17) : "f"(f2), "f"(f6));
  // PTX:105 div.rn.f32 %f18, %f3, %f6
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f18) : "f"(f3), "f"(f6));
  // PTX:106 mov.b32 %r25, %f18
  asm("mov.b32 %0, %1;" : "=r"(r25) : "f"(f18));
  // PTX:107 mov.b32 %r24, %f17
  asm("mov.b32 %0, %1;" : "=r"(r24) : "f"(f17));
  // PTX:108 mov.b32 %r23, %f16
  asm("mov.b32 %0, %1;" : "=r"(r23) : "f"(f16));
  // PTX:110 $L__BB13_6:
L_BB13_6:;
  // PTX:111 cvta.to.global.u64 %rd37, %rd14
  rd37 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd14));
  // PTX:112 mov.b32 %f19, %r23
  asm("mov.b32 %0, %1;" : "=f"(f19) : "r"(r23));
  // PTX:113 mul.f32 %f20, %f5, %f19
  asm("mul.f32 %0, %1, %2;" : "=f"(f20) : "f"(f5), "f"(f19));
  // PTX:114 mov.b32 %f21, %r24
  asm("mov.b32 %0, %1;" : "=f"(f21) : "r"(r24));
  // PTX:115 mul.f32 %f22, %f5, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f22) : "f"(f5), "f"(f21));
  // PTX:116 mov.b32 %f23, %r25
  asm("mov.b32 %0, %1;" : "=f"(f23) : "r"(r25));
  // PTX:117 mul.f32 %f24, %f5, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f24) : "f"(f5), "f"(f23));
  // PTX:118 sub.f32 %f25, %f1, %f20
  asm("sub.f32 %0, %1, %2;" : "=f"(f25) : "f"(f1), "f"(f20));
  // PTX:119 sub.f32 %f26, %f2, %f22
  asm("sub.f32 %0, %1, %2;" : "=f"(f26) : "f"(f2), "f"(f22));
  // PTX:120 sub.f32 %f27, %f3, %f24
  asm("sub.f32 %0, %1, %2;" : "=f"(f27) : "f"(f3), "f"(f24));
  // PTX:121 mul.f32 %f28, %f4, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f28) : "f"(f4), "f"(f25));
  // PTX:122 mul.f32 %f29, %f4, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f29) : "f"(f4), "f"(f26));
  // PTX:123 mul.f32 %f30, %f4, %f27
  asm("mul.f32 %0, %1, %2;" : "=f"(f30) : "f"(f4), "f"(f27));
  // PTX:124 mul.lo.s64 %rd38, %rd9, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd38) : "l"(rd9));
  // PTX:125 add.s64 %rd39, %rd37, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd39) : "l"(rd37), "l"(rd38));
  // PTX:126 red.global.add.f32 [%rd39], %f28
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (0)))), (float)(f28));
  // PTX:127 add.s64 %rd40, %rd39, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd40) : "l"(rd39));
  // PTX:128 red.global.add.f32 [%rd40], %f29
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (0)))), (float)(f29));
  // PTX:129 add.s64 %rd41, %rd39, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd41) : "l"(rd39));
  // PTX:130 red.global.add.f32 [%rd41], %f30
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (0)))), (float)(f30));
  // PTX:131 mul.lo.s64 %rd42, %rd8, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd42) : "l"(rd8));
  // PTX:132 add.s64 %rd43, %rd37, %rd42
  asm("add.s64 %0, %1, %2;" : "=l"(rd43) : "l"(rd37), "l"(rd42));
  // PTX:133 neg.f32 %f34, %f28
  asm("neg.f32 %0, %1;" : "=f"(f34) : "f"(f28));
  // PTX:134 red.global.add.f32 [%rd43], %f34
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (0)))), (float)(f34));
  // PTX:135 add.s64 %rd44, %rd43, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd44) : "l"(rd43));
  // PTX:136 neg.f32 %f36, %f29
  asm("neg.f32 %0, %1;" : "=f"(f36) : "f"(f29));
  // PTX:137 red.global.add.f32 [%rd44], %f36
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))), (float)(f36));
  // PTX:138 add.s64 %rd45, %rd43, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd45) : "l"(rd43));
  // PTX:139 neg.f32 %f38, %f30
  asm("neg.f32 %0, %1;" : "=f"(f38) : "f"(f30));
  // PTX:140 red.global.add.f32 [%rd45], %f38
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))), (float)(f38));
  // PTX:142 $L__BB13_7:
L_BB13_7:;
  // PTX:143 ret
  return;
}
