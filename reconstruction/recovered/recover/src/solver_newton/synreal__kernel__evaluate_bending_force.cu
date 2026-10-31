// 机械还原自 PTX：synreal::kernel::evaluate_bending_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 5faf14059d162c2a31d4f910aace2e346d4f90fd2a2f5c2e14c50fca32884e5a
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__evaluate_bending_force(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, float param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76;
  // PTX:27 ld.param.u64 %rd12, [_ZN7synreal6kernel22evaluate_bending_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPS4_mmm_param_0]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:28 ld.param.u64 %rd13, [_ZN7synreal6kernel22evaluate_bending_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPS4_mmm_param_1]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:29 ld.param.u64 %rd14, [_ZN7synreal6kernel22evaluate_bending_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPS4_mmm_param_2]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:30 ld.param.u64 %rd15, [_ZN7synreal6kernel22evaluate_bending_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPS4_mmm_param_3]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:31 ld.param.u64 %rd16, [_ZN7synreal6kernel22evaluate_bending_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPS4_mmm_param_4]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:32 ld.param.u64 %rd17, [_ZN7synreal6kernel22evaluate_bending_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPS4_mmm_param_5]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:33 ld.param.f32 %f20, [_ZN7synreal6kernel22evaluate_bending_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPS4_mmm_param_6]
  f20 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param6 + (0))));
  // PTX:34 ld.param.u64 %rd18, [_ZN7synreal6kernel22evaluate_bending_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPS4_mmm_param_7]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:35 ld.param.u64 %rd21, [_ZN7synreal6kernel22evaluate_bending_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPS4_mmm_param_8]
  rd21 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:36 ld.param.u64 %rd19, [_ZN7synreal6kernel22evaluate_bending_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPS4_mmm_param_9]
  rd19 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:37 ld.param.u64 %rd20, [_ZN7synreal6kernel22evaluate_bending_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPS4_mmm_param_10]
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
  // PTX:45 @%p1 bra $L__BB46_10
  if (p1) { goto L_BB46_10; }
  // PTX:47 or.b64 %rd24, %rd1, %rd19
  asm("or.b64 %0, %1, %2;" : "=l"(rd24) : "l"(rd1), "l"(rd19));
  // PTX:48 and.b64 %rd25, %rd24, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd25) : "l"(rd24));
  // PTX:49 setp.eq.s64 %p2, %rd25, 0
  p2 = (((long long)(rd25)) == ((long long)(0)));
  // PTX:50 @%p2 bra $L__BB46_3
  if (p2) { goto L_BB46_3; }
  // PTX:52 div.u64 %rd75, %rd1, %rd19
  asm("div.u64 %0, %1, %2;" : "=l"(rd75) : "l"(rd1), "l"(rd19));
  // PTX:53 mul.lo.s64 %rd26, %rd75, %rd19
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd26) : "l"(rd75), "l"(rd19));
  // PTX:54 sub.s64 %rd76, %rd1, %rd26
  asm("sub.s64 %0, %1, %2;" : "=l"(rd76) : "l"(rd1), "l"(rd26));
  // PTX:55 bra.uni $L__BB46_4
  goto L_BB46_4;
  // PTX:57 $L__BB46_3:
L_BB46_3:;
  // PTX:58 cvt.u32.u64 %r14, %rd19
  asm("cvt.u32.u64 %0, %1;" : "=r"(r14) : "l"(rd19));
  // PTX:59 cvt.u32.u64 %r15, %rd1
  asm("cvt.u32.u64 %0, %1;" : "=r"(r15) : "l"(rd1));
  // PTX:60 div.u32 %r16, %r15, %r14
  asm("div.u32 %0, %1, %2;" : "=r"(r16) : "r"(r15), "r"(r14));
  // PTX:61 mul.lo.s32 %r17, %r16, %r14
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r17) : "r"(r16), "r"(r14));
  // PTX:62 sub.s32 %r18, %r15, %r17
  asm("sub.s32 %0, %1, %2;" : "=r"(r18) : "r"(r15), "r"(r17));
  // PTX:63 cvt.u64.u32 %rd75, %r16
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd75) : "r"(r16));
  // PTX:64 cvt.u64.u32 %rd76, %r18
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd76) : "r"(r18));
  // PTX:66 $L__BB46_4:
L_BB46_4:;
  // PTX:67 cvta.to.global.u64 %rd27, %rd16
  rd27 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd16));
  // PTX:68 shl.b64 %rd28, %rd76, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd28) : "l"(rd76));
  // PTX:69 add.s64 %rd29, %rd27, %rd28
  asm("add.s64 %0, %1, %2;" : "=l"(rd29) : "l"(rd27), "l"(rd28));
  // PTX:70 ld.global.u32 %r1, [%rd29+4]
  r1 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (4)))));
  // PTX:71 ld.global.u32 %r2, [%rd29]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (0)))));
  // PTX:72 or.b32 %r19, %r1, %r2
  asm("or.b32 %0, %1, %2;" : "=r"(r19) : "r"(r1), "r"(r2));
  // PTX:73 setp.lt.s32 %p3, %r19, 0
  p3 = (((int)(r19)) < ((int)(0)));
  // PTX:74 setp.eq.s32 %p4, %r2, %r1
  p4 = (((int)(r2)) == ((int)(r1)));
  // PTX:75 or.pred %p5, %p4, %p3
  p5 = ((p4) || (p3));
  // PTX:76 ld.global.u32 %r3, [%rd29+8]
  r3 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (8)))));
  // PTX:77 setp.eq.s32 %p6, %r2, %r3
  p6 = (((int)(r2)) == ((int)(r3)));
  // PTX:78 or.pred %p7, %p6, %p5
  p7 = ((p6) || (p5));
  // PTX:79 ld.global.u32 %r4, [%rd29+12]
  r4 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (12)))));
  // PTX:80 setp.eq.s32 %p8, %r2, %r4
  p8 = (((int)(r2)) == ((int)(r4)));
  // PTX:81 or.pred %p9, %p8, %p7
  p9 = ((p8) || (p7));
  // PTX:82 setp.eq.s32 %p10, %r1, %r3
  p10 = (((int)(r1)) == ((int)(r3)));
  // PTX:83 or.pred %p11, %p10, %p9
  p11 = ((p10) || (p9));
  // PTX:84 setp.eq.s32 %p12, %r1, %r4
  p12 = (((int)(r1)) == ((int)(r4)));
  // PTX:85 or.pred %p13, %p12, %p11
  p13 = ((p12) || (p11));
  // PTX:86 setp.eq.s32 %p14, %r3, %r4
  p14 = (((int)(r3)) == ((int)(r4)));
  // PTX:87 or.pred %p15, %p14, %p13
  p15 = ((p14) || (p13));
  // PTX:88 cvta.to.global.u64 %rd30, %rd14
  rd30 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd14));
  // PTX:89 shl.b64 %rd31, %rd76, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd31) : "l"(rd76));
  // PTX:90 add.s64 %rd32, %rd30, %rd31
  asm("add.s64 %0, %1, %2;" : "=l"(rd32) : "l"(rd30), "l"(rd31));
  // PTX:91 ld.global.f32 %f1, [%rd32]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (0)))));
  // PTX:92 setp.le.f32 %p16, %f1, 0f00000000
  p16 = (!(isnan(((float)(f1))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f1)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:93 or.pred %p17, %p16, %p15
  p17 = ((p16) || (p15));
  // PTX:94 @%p17 bra $L__BB46_10
  if (p17) { goto L_BB46_10; }
  // PTX:96 cvta.to.global.u64 %rd33, %rd12
  rd33 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd12));
  // PTX:97 mul.lo.s64 %rd34, %rd75, %rd20
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd34) : "l"(rd75), "l"(rd20));
  // PTX:98 cvt.u32.u64 %r20, %rd34
  asm("cvt.u32.u64 %0, %1;" : "=r"(r20) : "l"(rd34));
  // PTX:99 add.s32 %r21, %r2, %r20
  asm("add.s32 %0, %1, %2;" : "=r"(r21) : "r"(r2), "r"(r20));
  // PTX:100 add.s32 %r22, %r1, %r20
  asm("add.s32 %0, %1, %2;" : "=r"(r22) : "r"(r1), "r"(r20));
  // PTX:101 add.s32 %r23, %r3, %r20
  asm("add.s32 %0, %1, %2;" : "=r"(r23) : "r"(r3), "r"(r20));
  // PTX:102 add.s32 %r24, %r4, %r20
  asm("add.s32 %0, %1, %2;" : "=r"(r24) : "r"(r4), "r"(r20));
  // PTX:103 cvta.to.global.u64 %rd35, %rd15
  rd35 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd15));
  // PTX:104 add.s64 %rd37, %rd35, %rd28
  asm("add.s64 %0, %1, %2;" : "=l"(rd37) : "l"(rd35), "l"(rd28));
  // PTX:105 ld.global.f32 %f2, [%rd37]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (0)))));
  // PTX:106 ld.global.f32 %f3, [%rd37+8]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (8)))));
  // PTX:107 ld.global.f32 %f24, [%rd37+4]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (4)))));
  // PTX:108 neg.f32 %f25, %f24
  asm("neg.f32 %0, %1;" : "=f"(f25) : "f"(f24));
  // PTX:109 ld.global.f32 %f26, [%rd37+12]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (12)))));
  // PTX:110 sub.f32 %f4, %f25, %f26
  asm("sub.f32 %0, %1, %2;" : "=f"(f4) : "f"(f25), "f"(f26));
  // PTX:111 add.f32 %f5, %f3, %f26
  asm("add.f32 %0, %1, %2;" : "=f"(f5) : "f"(f3), "f"(f26));
  // PTX:112 add.f32 %f6, %f2, %f24
  asm("add.f32 %0, %1, %2;" : "=f"(f6) : "f"(f2), "f"(f24));
  // PTX:113 cvta.to.global.u64 %rd38, %rd17
  rd38 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd17));
  // PTX:114 shl.b64 %rd39, %rd76, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd39) : "l"(rd76));
  // PTX:115 add.s64 %rd40, %rd38, %rd39
  asm("add.s64 %0, %1, %2;" : "=l"(rd40) : "l"(rd38), "l"(rd39));
  // PTX:116 cvt.s64.s32 %rd8, %r21
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd8) : "r"(r21));
  // PTX:117 mul.wide.s32 %rd41, %r21, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd41) : "r"(r21));
  // PTX:118 add.s64 %rd42, %rd33, %rd41
  asm("add.s64 %0, %1, %2;" : "=l"(rd42) : "l"(rd33), "l"(rd41));
  // PTX:119 cvt.s64.s32 %rd9, %r22
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd9) : "r"(r22));
  // PTX:120 mul.wide.s32 %rd43, %r22, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd43) : "r"(r22));
  // PTX:121 add.s64 %rd44, %rd33, %rd43
  asm("add.s64 %0, %1, %2;" : "=l"(rd44) : "l"(rd33), "l"(rd43));
  // PTX:122 ld.global.f32 %f27, [%rd44]
  f27 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))));
  // PTX:123 ld.global.f32 %f28, [%rd42]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (0)))));
  // PTX:124 sub.f32 %f29, %f27, %f28
  asm("sub.f32 %0, %1, %2;" : "=f"(f29) : "f"(f27), "f"(f28));
  // PTX:125 ld.global.f32 %f30, [%rd44+4]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (4)))));
  // PTX:126 ld.global.f32 %f31, [%rd42+4]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (4)))));
  // PTX:127 sub.f32 %f32, %f30, %f31
  asm("sub.f32 %0, %1, %2;" : "=f"(f32) : "f"(f30), "f"(f31));
  // PTX:128 ld.global.f32 %f33, [%rd44+8]
  f33 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (8)))));
  // PTX:129 ld.global.f32 %f34, [%rd42+8]
  f34 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (8)))));
  // PTX:130 sub.f32 %f35, %f33, %f34
  asm("sub.f32 %0, %1, %2;" : "=f"(f35) : "f"(f33), "f"(f34));
  // PTX:131 fma.rn.f32 %f36, %f4, %f29, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f36) : "f"(f4), "f"(f29));
  // PTX:132 mov.f32 %f139, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f139) : );
  // PTX:133 fma.rn.f32 %f37, %f4, %f32, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f37) : "f"(f4), "f"(f32));
  // PTX:134 fma.rn.f32 %f38, %f4, %f35, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f38) : "f"(f4), "f"(f35));
  // PTX:135 cvt.s64.s32 %rd10, %r23
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd10) : "r"(r23));
  // PTX:136 mul.wide.s32 %rd45, %r23, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd45) : "r"(r23));
  // PTX:137 add.s64 %rd46, %rd33, %rd45
  asm("add.s64 %0, %1, %2;" : "=l"(rd46) : "l"(rd33), "l"(rd45));
  // PTX:138 ld.global.f32 %f39, [%rd46]
  f39 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (0)))));
  // PTX:139 sub.f32 %f40, %f39, %f28
  asm("sub.f32 %0, %1, %2;" : "=f"(f40) : "f"(f39), "f"(f28));
  // PTX:140 ld.global.f32 %f41, [%rd46+4]
  f41 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (4)))));
  // PTX:141 sub.f32 %f42, %f41, %f31
  asm("sub.f32 %0, %1, %2;" : "=f"(f42) : "f"(f41), "f"(f31));
  // PTX:142 ld.global.f32 %f43, [%rd46+8]
  f43 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (8)))));
  // PTX:143 sub.f32 %f44, %f43, %f34
  asm("sub.f32 %0, %1, %2;" : "=f"(f44) : "f"(f43), "f"(f34));
  // PTX:144 fma.rn.f32 %f45, %f5, %f40, %f36
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f45) : "f"(f5), "f"(f40), "f"(f36));
  // PTX:145 fma.rn.f32 %f46, %f5, %f42, %f37
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f46) : "f"(f5), "f"(f42), "f"(f37));
  // PTX:146 fma.rn.f32 %f47, %f5, %f44, %f38
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f47) : "f"(f5), "f"(f44), "f"(f38));
  // PTX:147 cvt.s64.s32 %rd11, %r24
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd11) : "r"(r24));
  // PTX:148 mul.wide.s32 %rd47, %r24, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd47) : "r"(r24));
  // PTX:149 add.s64 %rd48, %rd33, %rd47
  asm("add.s64 %0, %1, %2;" : "=l"(rd48) : "l"(rd33), "l"(rd47));
  // PTX:150 ld.global.f32 %f48, [%rd48]
  f48 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))));
  // PTX:151 sub.f32 %f49, %f48, %f28
  asm("sub.f32 %0, %1, %2;" : "=f"(f49) : "f"(f48), "f"(f28));
  // PTX:152 ld.global.f32 %f50, [%rd48+4]
  f50 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (4)))));
  // PTX:153 sub.f32 %f51, %f50, %f31
  asm("sub.f32 %0, %1, %2;" : "=f"(f51) : "f"(f50), "f"(f31));
  // PTX:154 ld.global.f32 %f52, [%rd48+8]
  f52 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (8)))));
  // PTX:155 sub.f32 %f53, %f52, %f34
  asm("sub.f32 %0, %1, %2;" : "=f"(f53) : "f"(f52), "f"(f34));
  // PTX:156 fma.rn.f32 %f7, %f6, %f49, %f45
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f7) : "f"(f6), "f"(f49), "f"(f45));
  // PTX:157 fma.rn.f32 %f8, %f6, %f51, %f46
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f8) : "f"(f6), "f"(f51), "f"(f46));
  // PTX:158 fma.rn.f32 %f9, %f6, %f53, %f47
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f9) : "f"(f6), "f"(f53), "f"(f47));
  // PTX:159 mov.f32 %f54, 0f40400000
  asm("mov.f32 %0, 0f40400000;" : "=f"(f54) : );
  // PTX:160 div.rn.f32 %f10, %f54, %f1
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f10) : "f"(f54), "f"(f1));
  // PTX:161 ld.global.f32 %f11, [%rd40]
  f11 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (0)))));
  // PTX:162 ld.global.f32 %f55, [%rd40+4]
  f55 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (4)))));
  // PTX:163 mul.f32 %f12, %f10, %f55
  asm("mul.f32 %0, %1, %2;" : "=f"(f12) : "f"(f10), "f"(f55));
  // PTX:164 setp.leu.f32 %p18, %f12, 0f00000000
  p18 = ((isnan(((float)(f12))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f12)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:165 mov.f32 %f140, %f139
  asm("mov.f32 %0, %1;" : "=f"(f140) : "f"(f139));
  // PTX:166 mov.f32 %f141, %f139
  asm("mov.f32 %0, %1;" : "=f"(f141) : "f"(f139));
  // PTX:167 @%p18 bra $L__BB46_9
  if (p18) { goto L_BB46_9; }
  // PTX:169 mul.f32 %f56, %f8, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f56) : "f"(f8), "f"(f8));
  // PTX:170 fma.rn.f32 %f57, %f7, %f7, %f56
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f57) : "f"(f7), "f"(f7), "f"(f56));
  // PTX:171 fma.rn.f32 %f58, %f9, %f9, %f57
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f58) : "f"(f9), "f"(f9), "f"(f57));
  // PTX:172 sqrt.rn.f32 %f13, %f58
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f13) : "f"(f58));
  // PTX:173 setp.leu.f32 %p19, %f13, 0f2B8CBCCC
  p19 = ((isnan(((float)(f13))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) || (((float)(f13)) <= ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:174 mov.u32 %r28, 0
  asm("mov.u32 %0, 0;" : "=r"(r28) : );
  // PTX:175 mov.u32 %r29, %r28
  asm("mov.u32 %0, %1;" : "=r"(r29) : "r"(r28));
  // PTX:176 mov.u32 %r30, %r28
  asm("mov.u32 %0, %1;" : "=r"(r30) : "r"(r28));
  // PTX:177 @%p19 bra $L__BB46_8
  if (p19) { goto L_BB46_8; }
  // PTX:179 div.rn.f32 %f59, %f7, %f13
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f59) : "f"(f7), "f"(f13));
  // PTX:180 div.rn.f32 %f60, %f8, %f13
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f60) : "f"(f8), "f"(f13));
  // PTX:181 div.rn.f32 %f61, %f9, %f13
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f61) : "f"(f9), "f"(f13));
  // PTX:182 mov.b32 %r30, %f61
  asm("mov.b32 %0, %1;" : "=r"(r30) : "f"(f61));
  // PTX:183 mov.b32 %r29, %f60
  asm("mov.b32 %0, %1;" : "=r"(r29) : "f"(f60));
  // PTX:184 mov.b32 %r28, %f59
  asm("mov.b32 %0, %1;" : "=r"(r28) : "f"(f59));
  // PTX:186 $L__BB46_8:
L_BB46_8:;
  // PTX:187 cvta.to.global.u64 %rd49, %rd13
  rd49 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd13));
  // PTX:188 mul.lo.s64 %rd50, %rd8, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd50) : "l"(rd8));
  // PTX:189 add.s64 %rd51, %rd49, %rd50
  asm("add.s64 %0, %1, %2;" : "=l"(rd51) : "l"(rd49), "l"(rd50));
  // PTX:190 mul.lo.s64 %rd52, %rd9, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd52) : "l"(rd9));
  // PTX:191 add.s64 %rd53, %rd49, %rd52
  asm("add.s64 %0, %1, %2;" : "=l"(rd53) : "l"(rd49), "l"(rd52));
  // PTX:192 ld.global.f32 %f62, [%rd53]
  f62 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))));
  // PTX:193 ld.global.f32 %f63, [%rd51]
  f63 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))));
  // PTX:194 sub.f32 %f64, %f62, %f63
  asm("sub.f32 %0, %1, %2;" : "=f"(f64) : "f"(f62), "f"(f63));
  // PTX:195 ld.global.f32 %f65, [%rd53+4]
  f65 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (4)))));
  // PTX:196 ld.global.f32 %f66, [%rd51+4]
  f66 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (4)))));
  // PTX:197 sub.f32 %f67, %f65, %f66
  asm("sub.f32 %0, %1, %2;" : "=f"(f67) : "f"(f65), "f"(f66));
  // PTX:198 ld.global.f32 %f68, [%rd53+8]
  f68 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (8)))));
  // PTX:199 ld.global.f32 %f69, [%rd51+8]
  f69 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (8)))));
  // PTX:200 sub.f32 %f70, %f68, %f69
  asm("sub.f32 %0, %1, %2;" : "=f"(f70) : "f"(f68), "f"(f69));
  // PTX:201 fma.rn.f32 %f71, %f4, %f64, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f71) : "f"(f4), "f"(f64));
  // PTX:202 fma.rn.f32 %f72, %f4, %f67, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f72) : "f"(f4), "f"(f67));
  // PTX:203 fma.rn.f32 %f73, %f4, %f70, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f73) : "f"(f4), "f"(f70));
  // PTX:204 mul.lo.s64 %rd54, %rd10, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd54) : "l"(rd10));
  // PTX:205 add.s64 %rd55, %rd49, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd55) : "l"(rd49), "l"(rd54));
  // PTX:206 ld.global.f32 %f74, [%rd55]
  f74 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))));
  // PTX:207 sub.f32 %f75, %f74, %f63
  asm("sub.f32 %0, %1, %2;" : "=f"(f75) : "f"(f74), "f"(f63));
  // PTX:208 ld.global.f32 %f76, [%rd55+4]
  f76 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (4)))));
  // PTX:209 sub.f32 %f77, %f76, %f66
  asm("sub.f32 %0, %1, %2;" : "=f"(f77) : "f"(f76), "f"(f66));
  // PTX:210 ld.global.f32 %f78, [%rd55+8]
  f78 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (8)))));
  // PTX:211 sub.f32 %f79, %f78, %f69
  asm("sub.f32 %0, %1, %2;" : "=f"(f79) : "f"(f78), "f"(f69));
  // PTX:212 fma.rn.f32 %f80, %f5, %f75, %f71
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f80) : "f"(f5), "f"(f75), "f"(f71));
  // PTX:213 fma.rn.f32 %f81, %f5, %f77, %f72
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f81) : "f"(f5), "f"(f77), "f"(f72));
  // PTX:214 fma.rn.f32 %f82, %f5, %f79, %f73
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f82) : "f"(f5), "f"(f79), "f"(f73));
  // PTX:215 mul.lo.s64 %rd56, %rd11, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd56) : "l"(rd11));
  // PTX:216 add.s64 %rd57, %rd49, %rd56
  asm("add.s64 %0, %1, %2;" : "=l"(rd57) : "l"(rd49), "l"(rd56));
  // PTX:217 ld.global.f32 %f83, [%rd57]
  f83 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))));
  // PTX:218 sub.f32 %f84, %f83, %f63
  asm("sub.f32 %0, %1, %2;" : "=f"(f84) : "f"(f83), "f"(f63));
  // PTX:219 ld.global.f32 %f85, [%rd57+4]
  f85 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (4)))));
  // PTX:220 sub.f32 %f86, %f85, %f66
  asm("sub.f32 %0, %1, %2;" : "=f"(f86) : "f"(f85), "f"(f66));
  // PTX:221 ld.global.f32 %f87, [%rd57+8]
  f87 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (8)))));
  // PTX:222 sub.f32 %f88, %f87, %f69
  asm("sub.f32 %0, %1, %2;" : "=f"(f88) : "f"(f87), "f"(f69));
  // PTX:223 fma.rn.f32 %f89, %f6, %f84, %f80
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f89) : "f"(f6), "f"(f84), "f"(f80));
  // PTX:224 fma.rn.f32 %f90, %f6, %f86, %f81
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f90) : "f"(f6), "f"(f86), "f"(f81));
  // PTX:225 fma.rn.f32 %f91, %f6, %f88, %f82
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f91) : "f"(f6), "f"(f88), "f"(f82));
  // PTX:226 sub.f32 %f92, %f7, %f89
  asm("sub.f32 %0, %1, %2;" : "=f"(f92) : "f"(f7), "f"(f89));
  // PTX:227 sub.f32 %f93, %f8, %f90
  asm("sub.f32 %0, %1, %2;" : "=f"(f93) : "f"(f8), "f"(f90));
  // PTX:228 sub.f32 %f94, %f9, %f91
  asm("sub.f32 %0, %1, %2;" : "=f"(f94) : "f"(f9), "f"(f91));
  // PTX:229 mul.f32 %f95, %f92, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f95) : "f"(f92), "f"(f20));
  // PTX:230 mul.f32 %f96, %f93, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f96) : "f"(f93), "f"(f20));
  // PTX:231 mul.f32 %f97, %f94, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f97) : "f"(f94), "f"(f20));
  // PTX:232 mov.b32 %f98, %r28
  asm("mov.b32 %0, %1;" : "=f"(f98) : "r"(r28));
  // PTX:233 mov.b32 %f99, %r29
  asm("mov.b32 %0, %1;" : "=f"(f99) : "r"(r29));
  // PTX:234 mul.f32 %f100, %f96, %f99
  asm("mul.f32 %0, %1, %2;" : "=f"(f100) : "f"(f96), "f"(f99));
  // PTX:235 mov.b32 %f101, %r30
  asm("mov.b32 %0, %1;" : "=f"(f101) : "r"(r30));
  // PTX:236 fma.rn.f32 %f102, %f95, %f98, %f100
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f102) : "f"(f95), "f"(f98), "f"(f100));
  // PTX:237 fma.rn.f32 %f103, %f97, %f101, %f102
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f103) : "f"(f97), "f"(f101), "f"(f102));
  // PTX:238 mul.f32 %f104, %f12, %f103
  asm("mul.f32 %0, %1, %2;" : "=f"(f104) : "f"(f12), "f"(f103));
  // PTX:239 neg.f32 %f105, %f104
  asm("neg.f32 %0, %1;" : "=f"(f105) : "f"(f104));
  // PTX:240 mul.f32 %f139, %f98, %f105
  asm("mul.f32 %0, %1, %2;" : "=f"(f139) : "f"(f98), "f"(f105));
  // PTX:241 mul.f32 %f140, %f99, %f105
  asm("mul.f32 %0, %1, %2;" : "=f"(f140) : "f"(f99), "f"(f105));
  // PTX:242 mul.f32 %f141, %f101, %f105
  asm("mul.f32 %0, %1, %2;" : "=f"(f141) : "f"(f101), "f"(f105));
  // PTX:244 $L__BB46_9:
L_BB46_9:;
  // PTX:245 cvta.to.global.u64 %rd58, %rd18
  rd58 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd18));
  // PTX:246 neg.f32 %f106, %f2
  asm("neg.f32 %0, %1;" : "=f"(f106) : "f"(f2));
  // PTX:247 sub.f32 %f107, %f106, %f3
  asm("sub.f32 %0, %1, %2;" : "=f"(f107) : "f"(f106), "f"(f3));
  // PTX:248 mul.f32 %f108, %f10, %f11
  asm("mul.f32 %0, %1, %2;" : "=f"(f108) : "f"(f10), "f"(f11));
  // PTX:249 mul.f32 %f109, %f7, %f108
  asm("mul.f32 %0, %1, %2;" : "=f"(f109) : "f"(f7), "f"(f108));
  // PTX:250 mul.f32 %f110, %f8, %f108
  asm("mul.f32 %0, %1, %2;" : "=f"(f110) : "f"(f8), "f"(f108));
  // PTX:251 mul.f32 %f111, %f9, %f108
  asm("mul.f32 %0, %1, %2;" : "=f"(f111) : "f"(f9), "f"(f108));
  // PTX:252 sub.f32 %f112, %f139, %f109
  asm("sub.f32 %0, %1, %2;" : "=f"(f112) : "f"(f139), "f"(f109));
  // PTX:253 sub.f32 %f113, %f140, %f110
  asm("sub.f32 %0, %1, %2;" : "=f"(f113) : "f"(f140), "f"(f110));
  // PTX:254 sub.f32 %f114, %f141, %f111
  asm("sub.f32 %0, %1, %2;" : "=f"(f114) : "f"(f141), "f"(f111));
  // PTX:255 mul.f32 %f115, %f112, %f107
  asm("mul.f32 %0, %1, %2;" : "=f"(f115) : "f"(f112), "f"(f107));
  // PTX:256 mul.f32 %f116, %f113, %f107
  asm("mul.f32 %0, %1, %2;" : "=f"(f116) : "f"(f113), "f"(f107));
  // PTX:257 mul.f32 %f117, %f114, %f107
  asm("mul.f32 %0, %1, %2;" : "=f"(f117) : "f"(f114), "f"(f107));
  // PTX:258 mul.lo.s64 %rd59, %rd8, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd59) : "l"(rd8));
  // PTX:259 add.s64 %rd60, %rd58, %rd59
  asm("add.s64 %0, %1, %2;" : "=l"(rd60) : "l"(rd58), "l"(rd59));
  // PTX:260 red.global.add.f32 [%rd60], %f115
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))), (float)(f115));
  // PTX:261 add.s64 %rd61, %rd60, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd61) : "l"(rd60));
  // PTX:262 red.global.add.f32 [%rd61], %f116
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))), (float)(f116));
  // PTX:263 add.s64 %rd62, %rd60, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd62) : "l"(rd60));
  // PTX:264 red.global.add.f32 [%rd62], %f117
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))), (float)(f117));
  // PTX:265 mul.f32 %f121, %f112, %f4
  asm("mul.f32 %0, %1, %2;" : "=f"(f121) : "f"(f112), "f"(f4));
  // PTX:266 mul.f32 %f122, %f113, %f4
  asm("mul.f32 %0, %1, %2;" : "=f"(f122) : "f"(f113), "f"(f4));
  // PTX:267 mul.f32 %f123, %f114, %f4
  asm("mul.f32 %0, %1, %2;" : "=f"(f123) : "f"(f114), "f"(f4));
  // PTX:268 mul.lo.s64 %rd63, %rd9, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd63) : "l"(rd9));
  // PTX:269 add.s64 %rd64, %rd58, %rd63
  asm("add.s64 %0, %1, %2;" : "=l"(rd64) : "l"(rd58), "l"(rd63));
  // PTX:270 red.global.add.f32 [%rd64], %f121
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (0)))), (float)(f121));
  // PTX:271 add.s64 %rd65, %rd64, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd65) : "l"(rd64));
  // PTX:272 red.global.add.f32 [%rd65], %f122
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (0)))), (float)(f122));
  // PTX:273 add.s64 %rd66, %rd64, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd66) : "l"(rd64));
  // PTX:274 red.global.add.f32 [%rd66], %f123
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (0)))), (float)(f123));
  // PTX:275 mul.f32 %f127, %f112, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f127) : "f"(f112), "f"(f5));
  // PTX:276 mul.f32 %f128, %f113, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f128) : "f"(f113), "f"(f5));
  // PTX:277 mul.f32 %f129, %f114, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f129) : "f"(f114), "f"(f5));
  // PTX:278 mul.lo.s64 %rd67, %rd10, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd67) : "l"(rd10));
  // PTX:279 add.s64 %rd68, %rd58, %rd67
  asm("add.s64 %0, %1, %2;" : "=l"(rd68) : "l"(rd58), "l"(rd67));
  // PTX:280 red.global.add.f32 [%rd68], %f127
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (0)))), (float)(f127));
  // PTX:281 add.s64 %rd69, %rd68, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd69) : "l"(rd68));
  // PTX:282 red.global.add.f32 [%rd69], %f128
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (0)))), (float)(f128));
  // PTX:283 add.s64 %rd70, %rd68, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd70) : "l"(rd68));
  // PTX:284 red.global.add.f32 [%rd70], %f129
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0)))), (float)(f129));
  // PTX:285 mul.f32 %f133, %f112, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f133) : "f"(f112), "f"(f6));
  // PTX:286 mul.f32 %f134, %f113, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f134) : "f"(f113), "f"(f6));
  // PTX:287 mul.f32 %f135, %f114, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f135) : "f"(f114), "f"(f6));
  // PTX:288 mul.lo.s64 %rd71, %rd11, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd71) : "l"(rd11));
  // PTX:289 add.s64 %rd72, %rd58, %rd71
  asm("add.s64 %0, %1, %2;" : "=l"(rd72) : "l"(rd58), "l"(rd71));
  // PTX:290 red.global.add.f32 [%rd72], %f133
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (0)))), (float)(f133));
  // PTX:291 add.s64 %rd73, %rd72, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd73) : "l"(rd72));
  // PTX:292 red.global.add.f32 [%rd73], %f134
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (0)))), (float)(f134));
  // PTX:293 add.s64 %rd74, %rd72, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd74) : "l"(rd72));
  // PTX:294 red.global.add.f32 [%rd74], %f135
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (0)))), (float)(f135));
  // PTX:296 $L__BB46_10:
L_BB46_10:;
  // PTX:297 ret
  return;
}
