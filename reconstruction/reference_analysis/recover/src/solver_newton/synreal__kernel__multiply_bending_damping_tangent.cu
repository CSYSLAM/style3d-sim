// 机械还原自 PTX：synreal::kernel::multiply_bending_damping_tangent(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 048a73b22678cd8735cddaa3a1660d9bcc12705c79bc01c2a51ea49b8415e3c2
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__multiply_bending_damping_tangent(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, float param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73;
  // PTX:27 ld.param.u64 %rd12, [_ZN7synreal6kernel32multiply_bending_damping_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPS4_mmm_param_0]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:28 ld.param.u64 %rd13, [_ZN7synreal6kernel32multiply_bending_damping_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPS4_mmm_param_1]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:29 ld.param.u64 %rd14, [_ZN7synreal6kernel32multiply_bending_damping_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPS4_mmm_param_2]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:30 ld.param.u64 %rd15, [_ZN7synreal6kernel32multiply_bending_damping_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPS4_mmm_param_3]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:31 ld.param.u64 %rd16, [_ZN7synreal6kernel32multiply_bending_damping_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPS4_mmm_param_4]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:32 ld.param.u64 %rd17, [_ZN7synreal6kernel32multiply_bending_damping_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPS4_mmm_param_5]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:33 ld.param.f32 %f12, [_ZN7synreal6kernel32multiply_bending_damping_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPS4_mmm_param_6]
  f12 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param6 + (0))));
  // PTX:34 ld.param.u64 %rd18, [_ZN7synreal6kernel32multiply_bending_damping_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPS4_mmm_param_7]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:35 ld.param.u64 %rd21, [_ZN7synreal6kernel32multiply_bending_damping_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPS4_mmm_param_8]
  rd21 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:36 ld.param.u64 %rd19, [_ZN7synreal6kernel32multiply_bending_damping_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPS4_mmm_param_9]
  rd19 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:37 ld.param.u64 %rd20, [_ZN7synreal6kernel32multiply_bending_damping_tangentEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPS4_mmm_param_10]
  rd20 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:38 mov.u32 %r11, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r11) : "r"(blockIdx.x));
  // PTX:39 mov.u32 %r12, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r12) : "r"(blockDim.x));
  // PTX:40 mul.wide.u32 %rd22, %r11, %r12
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd22) : "r"(r11), "r"(r12));
  // PTX:41 mov.u32 %r13, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r13) : "r"(threadIdx.x));
  // PTX:42 cvt.u64.u32 %rd23, %r13
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd23) : "r"(r13));
  // PTX:43 add.s64 %rd1, %rd22, %rd23
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd22), "l"(rd23));
  // PTX:44 setp.ge.u64 %p1, %rd1, %rd21
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd21)));
  // PTX:45 @%p1 bra $L__BB47_11
  if (p1) { goto L_BB47_11; }
  // PTX:47 or.b64 %rd24, %rd1, %rd19
  asm("or.b64 %0, %1, %2;" : "=l"(rd24) : "l"(rd1), "l"(rd19));
  // PTX:48 and.b64 %rd25, %rd24, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd25) : "l"(rd24));
  // PTX:49 setp.eq.s64 %p2, %rd25, 0
  p2 = (((long long)(rd25)) == ((long long)(0)));
  // PTX:50 @%p2 bra $L__BB47_3
  if (p2) { goto L_BB47_3; }
  // PTX:52 rem.u64 %rd72, %rd1, %rd19
  asm("rem.u64 %0, %1, %2;" : "=l"(rd72) : "l"(rd1), "l"(rd19));
  // PTX:53 bra.uni $L__BB47_4
  goto L_BB47_4;
  // PTX:55 $L__BB47_3:
L_BB47_3:;
  // PTX:56 cvt.u32.u64 %r14, %rd19
  asm("cvt.u32.u64 %0, %1;" : "=r"(r14) : "l"(rd19));
  // PTX:57 cvt.u32.u64 %r15, %rd1
  asm("cvt.u32.u64 %0, %1;" : "=r"(r15) : "l"(rd1));
  // PTX:58 rem.u32 %r16, %r15, %r14
  asm("rem.u32 %0, %1, %2;" : "=r"(r16) : "r"(r15), "r"(r14));
  // PTX:59 cvt.u64.u32 %rd72, %r16
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd72) : "r"(r16));
  // PTX:61 $L__BB47_4:
L_BB47_4:;
  // PTX:62 cvta.to.global.u64 %rd26, %rd16
  rd26 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd16));
  // PTX:63 shl.b64 %rd27, %rd72, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd27) : "l"(rd72));
  // PTX:64 add.s64 %rd28, %rd26, %rd27
  asm("add.s64 %0, %1, %2;" : "=l"(rd28) : "l"(rd26), "l"(rd27));
  // PTX:65 cvta.to.global.u64 %rd29, %rd17
  rd29 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd17));
  // PTX:66 shl.b64 %rd30, %rd72, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd30) : "l"(rd72));
  // PTX:67 add.s64 %rd31, %rd29, %rd30
  asm("add.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd29), "l"(rd30));
  // PTX:68 ld.global.u32 %r1, [%rd28+4]
  r1 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (4)))));
  // PTX:69 ld.global.u32 %r2, [%rd28]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (0)))));
  // PTX:70 or.b32 %r17, %r1, %r2
  asm("or.b32 %0, %1, %2;" : "=r"(r17) : "r"(r1), "r"(r2));
  // PTX:71 setp.lt.s32 %p3, %r17, 0
  p3 = (((int)(r17)) < ((int)(0)));
  // PTX:72 setp.eq.s32 %p4, %r2, %r1
  p4 = (((int)(r2)) == ((int)(r1)));
  // PTX:73 or.pred %p5, %p4, %p3
  p5 = ((p4) || (p3));
  // PTX:74 ld.global.u32 %r3, [%rd28+8]
  r3 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (8)))));
  // PTX:75 setp.eq.s32 %p6, %r2, %r3
  p6 = (((int)(r2)) == ((int)(r3)));
  // PTX:76 or.pred %p7, %p6, %p5
  p7 = ((p6) || (p5));
  // PTX:77 ld.global.u32 %r4, [%rd28+12]
  r4 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (12)))));
  // PTX:78 setp.eq.s32 %p8, %r2, %r4
  p8 = (((int)(r2)) == ((int)(r4)));
  // PTX:79 or.pred %p9, %p8, %p7
  p9 = ((p8) || (p7));
  // PTX:80 setp.eq.s32 %p10, %r1, %r3
  p10 = (((int)(r1)) == ((int)(r3)));
  // PTX:81 or.pred %p11, %p10, %p9
  p11 = ((p10) || (p9));
  // PTX:82 setp.eq.s32 %p12, %r1, %r4
  p12 = (((int)(r1)) == ((int)(r4)));
  // PTX:83 or.pred %p13, %p12, %p11
  p13 = ((p12) || (p11));
  // PTX:84 setp.eq.s32 %p14, %r3, %r4
  p14 = (((int)(r3)) == ((int)(r4)));
  // PTX:85 or.pred %p15, %p14, %p13
  p15 = ((p14) || (p13));
  // PTX:86 cvta.to.global.u64 %rd32, %rd14
  rd32 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd14));
  // PTX:87 shl.b64 %rd33, %rd72, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd33) : "l"(rd72));
  // PTX:88 add.s64 %rd34, %rd32, %rd33
  asm("add.s64 %0, %1, %2;" : "=l"(rd34) : "l"(rd32), "l"(rd33));
  // PTX:89 ld.global.f32 %f1, [%rd34]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (0)))));
  // PTX:90 setp.le.f32 %p16, %f1, 0f00000000
  p16 = (!(isnan(((float)(f1))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f1)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:91 or.pred %p17, %p16, %p15
  p17 = ((p16) || (p15));
  // PTX:92 ld.global.f32 %f2, [%rd31+4]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (4)))));
  // PTX:93 setp.le.f32 %p18, %f2, 0f00000000
  p18 = (!(isnan(((float)(f2))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f2)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:94 or.pred %p19, %p18, %p17
  p19 = ((p18) || (p17));
  // PTX:95 @%p19 bra $L__BB47_11
  if (p19) { goto L_BB47_11; }
  // PTX:97 @%p2 bra $L__BB47_7
  if (p2) { goto L_BB47_7; }
  // PTX:99 div.u64 %rd73, %rd1, %rd19
  asm("div.u64 %0, %1, %2;" : "=l"(rd73) : "l"(rd1), "l"(rd19));
  // PTX:100 bra.uni $L__BB47_8
  goto L_BB47_8;
  // PTX:102 $L__BB47_7:
L_BB47_7:;
  // PTX:103 cvt.u32.u64 %r18, %rd19
  asm("cvt.u32.u64 %0, %1;" : "=r"(r18) : "l"(rd19));
  // PTX:104 cvt.u32.u64 %r19, %rd1
  asm("cvt.u32.u64 %0, %1;" : "=r"(r19) : "l"(rd1));
  // PTX:105 div.u32 %r20, %r19, %r18
  asm("div.u32 %0, %1, %2;" : "=r"(r20) : "r"(r19), "r"(r18));
  // PTX:106 cvt.u64.u32 %rd73, %r20
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd73) : "r"(r20));
  // PTX:108 $L__BB47_8:
L_BB47_8:;
  // PTX:109 cvta.to.global.u64 %rd37, %rd12
  rd37 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd12));
  // PTX:110 mul.lo.s64 %rd38, %rd73, %rd20
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd38) : "l"(rd73), "l"(rd20));
  // PTX:111 cvt.u32.u64 %r24, %rd38
  asm("cvt.u32.u64 %0, %1;" : "=r"(r24) : "l"(rd38));
  // PTX:112 add.s32 %r25, %r2, %r24
  asm("add.s32 %0, %1, %2;" : "=r"(r25) : "r"(r2), "r"(r24));
  // PTX:113 add.s32 %r26, %r1, %r24
  asm("add.s32 %0, %1, %2;" : "=r"(r26) : "r"(r1), "r"(r24));
  // PTX:114 add.s32 %r27, %r3, %r24
  asm("add.s32 %0, %1, %2;" : "=r"(r27) : "r"(r3), "r"(r24));
  // PTX:115 add.s32 %r28, %r4, %r24
  asm("add.s32 %0, %1, %2;" : "=r"(r28) : "r"(r4), "r"(r24));
  // PTX:116 cvta.to.global.u64 %rd39, %rd15
  rd39 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd15));
  // PTX:117 add.s64 %rd41, %rd39, %rd27
  asm("add.s64 %0, %1, %2;" : "=l"(rd41) : "l"(rd39), "l"(rd27));
  // PTX:118 ld.global.f32 %f3, [%rd41]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (0)))));
  // PTX:119 ld.global.f32 %f4, [%rd41+8]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (8)))));
  // PTX:120 ld.global.f32 %f13, [%rd41+4]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (4)))));
  // PTX:121 neg.f32 %f14, %f13
  asm("neg.f32 %0, %1;" : "=f"(f14) : "f"(f13));
  // PTX:122 ld.global.f32 %f15, [%rd41+12]
  f15 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (12)))));
  // PTX:123 sub.f32 %f5, %f14, %f15
  asm("sub.f32 %0, %1, %2;" : "=f"(f5) : "f"(f14), "f"(f15));
  // PTX:124 add.f32 %f6, %f4, %f15
  asm("add.f32 %0, %1, %2;" : "=f"(f6) : "f"(f4), "f"(f15));
  // PTX:125 add.f32 %f7, %f3, %f13
  asm("add.f32 %0, %1, %2;" : "=f"(f7) : "f"(f3), "f"(f13));
  // PTX:126 cvt.s64.s32 %rd8, %r25
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd8) : "r"(r25));
  // PTX:127 mul.wide.s32 %rd42, %r25, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd42) : "r"(r25));
  // PTX:128 add.s64 %rd43, %rd37, %rd42
  asm("add.s64 %0, %1, %2;" : "=l"(rd43) : "l"(rd37), "l"(rd42));
  // PTX:129 cvt.s64.s32 %rd9, %r26
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd9) : "r"(r26));
  // PTX:130 mul.wide.s32 %rd44, %r26, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd44) : "r"(r26));
  // PTX:131 add.s64 %rd45, %rd37, %rd44
  asm("add.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd37), "l"(rd44));
  // PTX:132 ld.global.f32 %f16, [%rd45]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))));
  // PTX:133 ld.global.f32 %f17, [%rd43]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (0)))));
  // PTX:134 sub.f32 %f18, %f16, %f17
  asm("sub.f32 %0, %1, %2;" : "=f"(f18) : "f"(f16), "f"(f17));
  // PTX:135 ld.global.f32 %f19, [%rd45+4]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (4)))));
  // PTX:136 ld.global.f32 %f20, [%rd43+4]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (4)))));
  // PTX:137 sub.f32 %f21, %f19, %f20
  asm("sub.f32 %0, %1, %2;" : "=f"(f21) : "f"(f19), "f"(f20));
  // PTX:138 ld.global.f32 %f22, [%rd45+8]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (8)))));
  // PTX:139 ld.global.f32 %f23, [%rd43+8]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (8)))));
  // PTX:140 sub.f32 %f24, %f22, %f23
  asm("sub.f32 %0, %1, %2;" : "=f"(f24) : "f"(f22), "f"(f23));
  // PTX:141 fma.rn.f32 %f25, %f5, %f18, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f25) : "f"(f5), "f"(f18));
  // PTX:142 fma.rn.f32 %f26, %f5, %f21, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f26) : "f"(f5), "f"(f21));
  // PTX:143 fma.rn.f32 %f27, %f5, %f24, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f27) : "f"(f5), "f"(f24));
  // PTX:144 cvt.s64.s32 %rd10, %r27
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd10) : "r"(r27));
  // PTX:145 mul.wide.s32 %rd46, %r27, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd46) : "r"(r27));
  // PTX:146 add.s64 %rd47, %rd37, %rd46
  asm("add.s64 %0, %1, %2;" : "=l"(rd47) : "l"(rd37), "l"(rd46));
  // PTX:147 ld.global.f32 %f28, [%rd47]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))));
  // PTX:148 sub.f32 %f29, %f28, %f17
  asm("sub.f32 %0, %1, %2;" : "=f"(f29) : "f"(f28), "f"(f17));
  // PTX:149 ld.global.f32 %f30, [%rd47+4]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (4)))));
  // PTX:150 sub.f32 %f31, %f30, %f20
  asm("sub.f32 %0, %1, %2;" : "=f"(f31) : "f"(f30), "f"(f20));
  // PTX:151 ld.global.f32 %f32, [%rd47+8]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (8)))));
  // PTX:152 sub.f32 %f33, %f32, %f23
  asm("sub.f32 %0, %1, %2;" : "=f"(f33) : "f"(f32), "f"(f23));
  // PTX:153 fma.rn.f32 %f34, %f6, %f29, %f25
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f34) : "f"(f6), "f"(f29), "f"(f25));
  // PTX:154 fma.rn.f32 %f35, %f6, %f31, %f26
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f35) : "f"(f6), "f"(f31), "f"(f26));
  // PTX:155 fma.rn.f32 %f36, %f6, %f33, %f27
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f36) : "f"(f6), "f"(f33), "f"(f27));
  // PTX:156 cvt.s64.s32 %rd11, %r28
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd11) : "r"(r28));
  // PTX:157 mul.wide.s32 %rd48, %r28, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd48) : "r"(r28));
  // PTX:158 add.s64 %rd49, %rd37, %rd48
  asm("add.s64 %0, %1, %2;" : "=l"(rd49) : "l"(rd37), "l"(rd48));
  // PTX:159 ld.global.f32 %f37, [%rd49]
  f37 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))));
  // PTX:160 sub.f32 %f38, %f37, %f17
  asm("sub.f32 %0, %1, %2;" : "=f"(f38) : "f"(f37), "f"(f17));
  // PTX:161 ld.global.f32 %f39, [%rd49+4]
  f39 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (4)))));
  // PTX:162 sub.f32 %f40, %f39, %f20
  asm("sub.f32 %0, %1, %2;" : "=f"(f40) : "f"(f39), "f"(f20));
  // PTX:163 ld.global.f32 %f41, [%rd49+8]
  f41 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (8)))));
  // PTX:164 sub.f32 %f42, %f41, %f23
  asm("sub.f32 %0, %1, %2;" : "=f"(f42) : "f"(f41), "f"(f23));
  // PTX:165 fma.rn.f32 %f8, %f7, %f38, %f34
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f8) : "f"(f7), "f"(f38), "f"(f34));
  // PTX:166 fma.rn.f32 %f9, %f7, %f40, %f35
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f9) : "f"(f7), "f"(f40), "f"(f35));
  // PTX:167 fma.rn.f32 %f10, %f7, %f42, %f36
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f10) : "f"(f7), "f"(f42), "f"(f36));
  // PTX:168 mul.f32 %f43, %f9, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f43) : "f"(f9), "f"(f9));
  // PTX:169 fma.rn.f32 %f44, %f8, %f8, %f43
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f44) : "f"(f8), "f"(f8), "f"(f43));
  // PTX:170 fma.rn.f32 %f45, %f10, %f10, %f44
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f45) : "f"(f10), "f"(f10), "f"(f44));
  // PTX:171 sqrt.rn.f32 %f11, %f45
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f11) : "f"(f45));
  // PTX:172 setp.leu.f32 %p21, %f11, 0f2B8CBCCC
  p21 = ((isnan(((float)(f11))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) || (((float)(f11)) <= ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:173 mov.u32 %r29, 0
  asm("mov.u32 %0, 0;" : "=r"(r29) : );
  // PTX:174 mov.u32 %r30, %r29
  asm("mov.u32 %0, %1;" : "=r"(r30) : "r"(r29));
  // PTX:175 mov.u32 %r31, %r29
  asm("mov.u32 %0, %1;" : "=r"(r31) : "r"(r29));
  // PTX:176 @%p21 bra $L__BB47_10
  if (p21) { goto L_BB47_10; }
  // PTX:178 div.rn.f32 %f46, %f8, %f11
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f46) : "f"(f8), "f"(f11));
  // PTX:179 div.rn.f32 %f47, %f9, %f11
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f47) : "f"(f9), "f"(f11));
  // PTX:180 div.rn.f32 %f48, %f10, %f11
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f48) : "f"(f10), "f"(f11));
  // PTX:181 mov.b32 %r31, %f48
  asm("mov.b32 %0, %1;" : "=r"(r31) : "f"(f48));
  // PTX:182 mov.b32 %r30, %f47
  asm("mov.b32 %0, %1;" : "=r"(r30) : "f"(f47));
  // PTX:183 mov.b32 %r29, %f46
  asm("mov.b32 %0, %1;" : "=r"(r29) : "f"(f46));
  // PTX:185 $L__BB47_10:
L_BB47_10:;
  // PTX:186 cvta.to.global.u64 %rd50, %rd13
  rd50 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd13));
  // PTX:187 cvta.to.global.u64 %rd51, %rd18
  rd51 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd18));
  // PTX:188 neg.f32 %f49, %f3
  asm("neg.f32 %0, %1;" : "=f"(f49) : "f"(f3));
  // PTX:189 sub.f32 %f50, %f49, %f4
  asm("sub.f32 %0, %1, %2;" : "=f"(f50) : "f"(f49), "f"(f4));
  // PTX:190 mul.lo.s64 %rd52, %rd8, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd52) : "l"(rd8));
  // PTX:191 add.s64 %rd53, %rd50, %rd52
  asm("add.s64 %0, %1, %2;" : "=l"(rd53) : "l"(rd50), "l"(rd52));
  // PTX:192 mul.lo.s64 %rd54, %rd9, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd54) : "l"(rd9));
  // PTX:193 add.s64 %rd55, %rd50, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd55) : "l"(rd50), "l"(rd54));
  // PTX:194 ld.global.f32 %f51, [%rd55]
  f51 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))));
  // PTX:195 ld.global.f32 %f52, [%rd53]
  f52 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))));
  // PTX:196 sub.f32 %f53, %f51, %f52
  asm("sub.f32 %0, %1, %2;" : "=f"(f53) : "f"(f51), "f"(f52));
  // PTX:197 ld.global.f32 %f54, [%rd55+4]
  f54 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (4)))));
  // PTX:198 ld.global.f32 %f55, [%rd53+4]
  f55 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (4)))));
  // PTX:199 sub.f32 %f56, %f54, %f55
  asm("sub.f32 %0, %1, %2;" : "=f"(f56) : "f"(f54), "f"(f55));
  // PTX:200 ld.global.f32 %f57, [%rd55+8]
  f57 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (8)))));
  // PTX:201 ld.global.f32 %f58, [%rd53+8]
  f58 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (8)))));
  // PTX:202 sub.f32 %f59, %f57, %f58
  asm("sub.f32 %0, %1, %2;" : "=f"(f59) : "f"(f57), "f"(f58));
  // PTX:203 fma.rn.f32 %f60, %f5, %f53, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f60) : "f"(f5), "f"(f53));
  // PTX:204 fma.rn.f32 %f61, %f5, %f56, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f61) : "f"(f5), "f"(f56));
  // PTX:205 fma.rn.f32 %f62, %f5, %f59, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f62) : "f"(f5), "f"(f59));
  // PTX:206 mul.lo.s64 %rd56, %rd10, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd56) : "l"(rd10));
  // PTX:207 add.s64 %rd57, %rd50, %rd56
  asm("add.s64 %0, %1, %2;" : "=l"(rd57) : "l"(rd50), "l"(rd56));
  // PTX:208 ld.global.f32 %f63, [%rd57]
  f63 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))));
  // PTX:209 sub.f32 %f64, %f63, %f52
  asm("sub.f32 %0, %1, %2;" : "=f"(f64) : "f"(f63), "f"(f52));
  // PTX:210 ld.global.f32 %f65, [%rd57+4]
  f65 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (4)))));
  // PTX:211 sub.f32 %f66, %f65, %f55
  asm("sub.f32 %0, %1, %2;" : "=f"(f66) : "f"(f65), "f"(f55));
  // PTX:212 ld.global.f32 %f67, [%rd57+8]
  f67 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (8)))));
  // PTX:213 sub.f32 %f68, %f67, %f58
  asm("sub.f32 %0, %1, %2;" : "=f"(f68) : "f"(f67), "f"(f58));
  // PTX:214 fma.rn.f32 %f69, %f6, %f64, %f60
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f69) : "f"(f6), "f"(f64), "f"(f60));
  // PTX:215 fma.rn.f32 %f70, %f6, %f66, %f61
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f70) : "f"(f6), "f"(f66), "f"(f61));
  // PTX:216 fma.rn.f32 %f71, %f6, %f68, %f62
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f71) : "f"(f6), "f"(f68), "f"(f62));
  // PTX:217 mul.lo.s64 %rd58, %rd11, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd58) : "l"(rd11));
  // PTX:218 add.s64 %rd59, %rd50, %rd58
  asm("add.s64 %0, %1, %2;" : "=l"(rd59) : "l"(rd50), "l"(rd58));
  // PTX:219 ld.global.f32 %f72, [%rd59]
  f72 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))));
  // PTX:220 sub.f32 %f73, %f72, %f52
  asm("sub.f32 %0, %1, %2;" : "=f"(f73) : "f"(f72), "f"(f52));
  // PTX:221 ld.global.f32 %f74, [%rd59+4]
  f74 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (4)))));
  // PTX:222 sub.f32 %f75, %f74, %f55
  asm("sub.f32 %0, %1, %2;" : "=f"(f75) : "f"(f74), "f"(f55));
  // PTX:223 ld.global.f32 %f76, [%rd59+8]
  f76 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (8)))));
  // PTX:224 sub.f32 %f77, %f76, %f58
  asm("sub.f32 %0, %1, %2;" : "=f"(f77) : "f"(f76), "f"(f58));
  // PTX:225 fma.rn.f32 %f78, %f7, %f73, %f69
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f78) : "f"(f7), "f"(f73), "f"(f69));
  // PTX:226 fma.rn.f32 %f79, %f7, %f75, %f70
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f79) : "f"(f7), "f"(f75), "f"(f70));
  // PTX:227 fma.rn.f32 %f80, %f7, %f77, %f71
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f80) : "f"(f7), "f"(f77), "f"(f71));
  // PTX:228 mov.f32 %f81, 0f40400000
  asm("mov.f32 %0, 0f40400000;" : "=f"(f81) : );
  // PTX:229 div.rn.f32 %f82, %f81, %f1
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f82) : "f"(f81), "f"(f1));
  // PTX:230 mul.f32 %f83, %f2, %f82
  asm("mul.f32 %0, %1, %2;" : "=f"(f83) : "f"(f2), "f"(f82));
  // PTX:231 mul.f32 %f84, %f83, %f12
  asm("mul.f32 %0, %1, %2;" : "=f"(f84) : "f"(f83), "f"(f12));
  // PTX:232 mov.b32 %f85, %r29
  asm("mov.b32 %0, %1;" : "=f"(f85) : "r"(r29));
  // PTX:233 mov.b32 %f86, %r30
  asm("mov.b32 %0, %1;" : "=f"(f86) : "r"(r30));
  // PTX:234 mul.f32 %f87, %f79, %f86
  asm("mul.f32 %0, %1, %2;" : "=f"(f87) : "f"(f79), "f"(f86));
  // PTX:235 mov.b32 %f88, %r31
  asm("mov.b32 %0, %1;" : "=f"(f88) : "r"(r31));
  // PTX:236 fma.rn.f32 %f89, %f78, %f85, %f87
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f89) : "f"(f78), "f"(f85), "f"(f87));
  // PTX:237 fma.rn.f32 %f90, %f80, %f88, %f89
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f90) : "f"(f80), "f"(f88), "f"(f89));
  // PTX:238 mul.f32 %f91, %f84, %f90
  asm("mul.f32 %0, %1, %2;" : "=f"(f91) : "f"(f84), "f"(f90));
  // PTX:239 mul.f32 %f92, %f91, %f85
  asm("mul.f32 %0, %1, %2;" : "=f"(f92) : "f"(f91), "f"(f85));
  // PTX:240 mul.f32 %f93, %f91, %f86
  asm("mul.f32 %0, %1, %2;" : "=f"(f93) : "f"(f91), "f"(f86));
  // PTX:241 mul.f32 %f94, %f91, %f88
  asm("mul.f32 %0, %1, %2;" : "=f"(f94) : "f"(f91), "f"(f88));
  // PTX:242 mul.f32 %f95, %f92, %f50
  asm("mul.f32 %0, %1, %2;" : "=f"(f95) : "f"(f92), "f"(f50));
  // PTX:243 mul.f32 %f96, %f93, %f50
  asm("mul.f32 %0, %1, %2;" : "=f"(f96) : "f"(f93), "f"(f50));
  // PTX:244 mul.f32 %f97, %f94, %f50
  asm("mul.f32 %0, %1, %2;" : "=f"(f97) : "f"(f94), "f"(f50));
  // PTX:245 add.s64 %rd60, %rd51, %rd52
  asm("add.s64 %0, %1, %2;" : "=l"(rd60) : "l"(rd51), "l"(rd52));
  // PTX:246 red.global.add.f32 [%rd60], %f95
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))), (float)(f95));
  // PTX:247 add.s64 %rd61, %rd60, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd61) : "l"(rd60));
  // PTX:248 red.global.add.f32 [%rd61], %f96
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))), (float)(f96));
  // PTX:249 add.s64 %rd62, %rd60, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd62) : "l"(rd60));
  // PTX:250 red.global.add.f32 [%rd62], %f97
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))), (float)(f97));
  // PTX:251 mul.f32 %f101, %f92, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f101) : "f"(f92), "f"(f5));
  // PTX:252 mul.f32 %f102, %f93, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f102) : "f"(f93), "f"(f5));
  // PTX:253 mul.f32 %f103, %f94, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f103) : "f"(f94), "f"(f5));
  // PTX:254 add.s64 %rd63, %rd51, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd63) : "l"(rd51), "l"(rd54));
  // PTX:255 red.global.add.f32 [%rd63], %f101
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (0)))), (float)(f101));
  // PTX:256 add.s64 %rd64, %rd63, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd64) : "l"(rd63));
  // PTX:257 red.global.add.f32 [%rd64], %f102
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (0)))), (float)(f102));
  // PTX:258 add.s64 %rd65, %rd63, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd65) : "l"(rd63));
  // PTX:259 red.global.add.f32 [%rd65], %f103
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (0)))), (float)(f103));
  // PTX:260 mul.f32 %f107, %f92, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f107) : "f"(f92), "f"(f6));
  // PTX:261 mul.f32 %f108, %f93, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f108) : "f"(f93), "f"(f6));
  // PTX:262 mul.f32 %f109, %f94, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f109) : "f"(f94), "f"(f6));
  // PTX:263 add.s64 %rd66, %rd51, %rd56
  asm("add.s64 %0, %1, %2;" : "=l"(rd66) : "l"(rd51), "l"(rd56));
  // PTX:264 red.global.add.f32 [%rd66], %f107
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (0)))), (float)(f107));
  // PTX:265 add.s64 %rd67, %rd66, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd67) : "l"(rd66));
  // PTX:266 red.global.add.f32 [%rd67], %f108
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0)))), (float)(f108));
  // PTX:267 add.s64 %rd68, %rd66, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd68) : "l"(rd66));
  // PTX:268 red.global.add.f32 [%rd68], %f109
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (0)))), (float)(f109));
  // PTX:269 mul.f32 %f113, %f92, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f113) : "f"(f92), "f"(f7));
  // PTX:270 mul.f32 %f114, %f93, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f114) : "f"(f93), "f"(f7));
  // PTX:271 mul.f32 %f115, %f94, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f115) : "f"(f94), "f"(f7));
  // PTX:272 add.s64 %rd69, %rd51, %rd58
  asm("add.s64 %0, %1, %2;" : "=l"(rd69) : "l"(rd51), "l"(rd58));
  // PTX:273 red.global.add.f32 [%rd69], %f113
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (0)))), (float)(f113));
  // PTX:274 add.s64 %rd70, %rd69, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd70) : "l"(rd69));
  // PTX:275 red.global.add.f32 [%rd70], %f114
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0)))), (float)(f114));
  // PTX:276 add.s64 %rd71, %rd69, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd71) : "l"(rd69));
  // PTX:277 red.global.add.f32 [%rd71], %f115
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))), (float)(f115));
  // PTX:279 $L__BB47_11:
L_BB47_11:;
  // PTX:280 ret
  return;
}
