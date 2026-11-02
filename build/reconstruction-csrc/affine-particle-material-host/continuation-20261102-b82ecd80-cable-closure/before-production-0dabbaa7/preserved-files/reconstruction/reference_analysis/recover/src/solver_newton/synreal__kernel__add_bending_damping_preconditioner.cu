// 机械还原自 PTX：synreal::kernel::add_bending_damping_preconditioner(glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, float, (glm::qualifier)0> const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: d0044806323193db52a16f90fa0ac108193eec3fb1bf372e70f982cbfe1f1c8b
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__add_bending_damping_preconditioner(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, float param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91;
  // PTX:26 ld.param.u64 %rd12, [_ZN7synreal6kernel34add_bending_damping_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_0]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:27 ld.param.u64 %rd13, [_ZN7synreal6kernel34add_bending_damping_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_1]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:28 ld.param.u64 %rd14, [_ZN7synreal6kernel34add_bending_damping_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_2]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:29 ld.param.u64 %rd15, [_ZN7synreal6kernel34add_bending_damping_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_3]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:30 ld.param.u64 %rd16, [_ZN7synreal6kernel34add_bending_damping_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_4]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:31 ld.param.f32 %f12, [_ZN7synreal6kernel34add_bending_damping_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_5]
  f12 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param5 + (0))));
  // PTX:32 ld.param.u64 %rd17, [_ZN7synreal6kernel34add_bending_damping_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_6]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:33 ld.param.u64 %rd20, [_ZN7synreal6kernel34add_bending_damping_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_7]
  rd20 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:34 ld.param.u64 %rd18, [_ZN7synreal6kernel34add_bending_damping_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_8]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:35 ld.param.u64 %rd19, [_ZN7synreal6kernel34add_bending_damping_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKfPKNS2_ILi4EfLS3_0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EfLS3_0EEEfPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_9]
  rd19 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:36 mov.u32 %r11, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r11) : "r"(blockIdx.x));
  // PTX:37 mov.u32 %r12, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r12) : "r"(blockDim.x));
  // PTX:38 mul.wide.u32 %rd21, %r11, %r12
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd21) : "r"(r11), "r"(r12));
  // PTX:39 mov.u32 %r13, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r13) : "r"(threadIdx.x));
  // PTX:40 cvt.u64.u32 %rd22, %r13
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd22) : "r"(r13));
  // PTX:41 add.s64 %rd1, %rd21, %rd22
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd21), "l"(rd22));
  // PTX:42 setp.ge.u64 %p1, %rd1, %rd20
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd20)));
  // PTX:43 @%p1 bra $L__BB48_11
  if (p1) { goto L_BB48_11; }
  // PTX:45 or.b64 %rd23, %rd1, %rd18
  asm("or.b64 %0, %1, %2;" : "=l"(rd23) : "l"(rd1), "l"(rd18));
  // PTX:46 and.b64 %rd24, %rd23, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd24) : "l"(rd23));
  // PTX:47 setp.eq.s64 %p2, %rd24, 0
  p2 = (((long long)(rd24)) == ((long long)(0)));
  // PTX:48 @%p2 bra $L__BB48_3
  if (p2) { goto L_BB48_3; }
  // PTX:50 rem.u64 %rd90, %rd1, %rd18
  asm("rem.u64 %0, %1, %2;" : "=l"(rd90) : "l"(rd1), "l"(rd18));
  // PTX:51 bra.uni $L__BB48_4
  goto L_BB48_4;
  // PTX:53 $L__BB48_3:
L_BB48_3:;
  // PTX:54 cvt.u32.u64 %r14, %rd18
  asm("cvt.u32.u64 %0, %1;" : "=r"(r14) : "l"(rd18));
  // PTX:55 cvt.u32.u64 %r15, %rd1
  asm("cvt.u32.u64 %0, %1;" : "=r"(r15) : "l"(rd1));
  // PTX:56 rem.u32 %r16, %r15, %r14
  asm("rem.u32 %0, %1, %2;" : "=r"(r16) : "r"(r15), "r"(r14));
  // PTX:57 cvt.u64.u32 %rd90, %r16
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd90) : "r"(r16));
  // PTX:59 $L__BB48_4:
L_BB48_4:;
  // PTX:60 cvta.to.global.u64 %rd25, %rd15
  rd25 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd15));
  // PTX:61 shl.b64 %rd26, %rd90, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd26) : "l"(rd90));
  // PTX:62 add.s64 %rd27, %rd25, %rd26
  asm("add.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd25), "l"(rd26));
  // PTX:63 cvta.to.global.u64 %rd28, %rd16
  rd28 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd16));
  // PTX:64 shl.b64 %rd29, %rd90, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd29) : "l"(rd90));
  // PTX:65 add.s64 %rd30, %rd28, %rd29
  asm("add.s64 %0, %1, %2;" : "=l"(rd30) : "l"(rd28), "l"(rd29));
  // PTX:66 ld.global.u32 %r1, [%rd27+4]
  r1 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (4)))));
  // PTX:67 ld.global.u32 %r2, [%rd27]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))));
  // PTX:68 or.b32 %r17, %r1, %r2
  asm("or.b32 %0, %1, %2;" : "=r"(r17) : "r"(r1), "r"(r2));
  // PTX:69 setp.lt.s32 %p3, %r17, 0
  p3 = (((int)(r17)) < ((int)(0)));
  // PTX:70 setp.eq.s32 %p4, %r2, %r1
  p4 = (((int)(r2)) == ((int)(r1)));
  // PTX:71 or.pred %p5, %p4, %p3
  p5 = ((p4) || (p3));
  // PTX:72 ld.global.u32 %r3, [%rd27+8]
  r3 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (8)))));
  // PTX:73 setp.eq.s32 %p6, %r2, %r3
  p6 = (((int)(r2)) == ((int)(r3)));
  // PTX:74 or.pred %p7, %p6, %p5
  p7 = ((p6) || (p5));
  // PTX:75 ld.global.u32 %r4, [%rd27+12]
  r4 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (12)))));
  // PTX:76 setp.eq.s32 %p8, %r2, %r4
  p8 = (((int)(r2)) == ((int)(r4)));
  // PTX:77 or.pred %p9, %p8, %p7
  p9 = ((p8) || (p7));
  // PTX:78 setp.eq.s32 %p10, %r1, %r3
  p10 = (((int)(r1)) == ((int)(r3)));
  // PTX:79 or.pred %p11, %p10, %p9
  p11 = ((p10) || (p9));
  // PTX:80 setp.eq.s32 %p12, %r1, %r4
  p12 = (((int)(r1)) == ((int)(r4)));
  // PTX:81 or.pred %p13, %p12, %p11
  p13 = ((p12) || (p11));
  // PTX:82 setp.eq.s32 %p14, %r3, %r4
  p14 = (((int)(r3)) == ((int)(r4)));
  // PTX:83 or.pred %p15, %p14, %p13
  p15 = ((p14) || (p13));
  // PTX:84 cvta.to.global.u64 %rd31, %rd13
  rd31 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd13));
  // PTX:85 shl.b64 %rd32, %rd90, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd32) : "l"(rd90));
  // PTX:86 add.s64 %rd33, %rd31, %rd32
  asm("add.s64 %0, %1, %2;" : "=l"(rd33) : "l"(rd31), "l"(rd32));
  // PTX:87 ld.global.f32 %f1, [%rd33]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (0)))));
  // PTX:88 setp.le.f32 %p16, %f1, 0f00000000
  p16 = (!(isnan(((float)(f1))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f1)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:89 or.pred %p17, %p16, %p15
  p17 = ((p16) || (p15));
  // PTX:90 ld.global.f32 %f2, [%rd30+4]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (4)))));
  // PTX:91 setp.le.f32 %p18, %f2, 0f00000000
  p18 = (!(isnan(((float)(f2))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f2)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:92 or.pred %p19, %p18, %p17
  p19 = ((p18) || (p17));
  // PTX:93 @%p19 bra $L__BB48_11
  if (p19) { goto L_BB48_11; }
  // PTX:95 @%p2 bra $L__BB48_7
  if (p2) { goto L_BB48_7; }
  // PTX:97 div.u64 %rd91, %rd1, %rd18
  asm("div.u64 %0, %1, %2;" : "=l"(rd91) : "l"(rd1), "l"(rd18));
  // PTX:98 bra.uni $L__BB48_8
  goto L_BB48_8;
  // PTX:100 $L__BB48_7:
L_BB48_7:;
  // PTX:101 cvt.u32.u64 %r18, %rd18
  asm("cvt.u32.u64 %0, %1;" : "=r"(r18) : "l"(rd18));
  // PTX:102 cvt.u32.u64 %r19, %rd1
  asm("cvt.u32.u64 %0, %1;" : "=r"(r19) : "l"(rd1));
  // PTX:103 div.u32 %r20, %r19, %r18
  asm("div.u32 %0, %1, %2;" : "=r"(r20) : "r"(r19), "r"(r18));
  // PTX:104 cvt.u64.u32 %rd91, %r20
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd91) : "r"(r20));
  // PTX:106 $L__BB48_8:
L_BB48_8:;
  // PTX:107 cvta.to.global.u64 %rd36, %rd12
  rd36 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd12));
  // PTX:108 mul.lo.s64 %rd37, %rd91, %rd19
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd37) : "l"(rd91), "l"(rd19));
  // PTX:109 cvt.u32.u64 %r24, %rd37
  asm("cvt.u32.u64 %0, %1;" : "=r"(r24) : "l"(rd37));
  // PTX:110 add.s32 %r25, %r2, %r24
  asm("add.s32 %0, %1, %2;" : "=r"(r25) : "r"(r2), "r"(r24));
  // PTX:111 add.s32 %r26, %r1, %r24
  asm("add.s32 %0, %1, %2;" : "=r"(r26) : "r"(r1), "r"(r24));
  // PTX:112 add.s32 %r27, %r3, %r24
  asm("add.s32 %0, %1, %2;" : "=r"(r27) : "r"(r3), "r"(r24));
  // PTX:113 add.s32 %r28, %r4, %r24
  asm("add.s32 %0, %1, %2;" : "=r"(r28) : "r"(r4), "r"(r24));
  // PTX:114 cvta.to.global.u64 %rd38, %rd14
  rd38 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd14));
  // PTX:115 add.s64 %rd40, %rd38, %rd26
  asm("add.s64 %0, %1, %2;" : "=l"(rd40) : "l"(rd38), "l"(rd26));
  // PTX:116 ld.global.f32 %f3, [%rd40]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (0)))));
  // PTX:117 ld.global.f32 %f4, [%rd40+8]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (8)))));
  // PTX:118 ld.global.f32 %f13, [%rd40+4]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (4)))));
  // PTX:119 neg.f32 %f14, %f13
  asm("neg.f32 %0, %1;" : "=f"(f14) : "f"(f13));
  // PTX:120 ld.global.f32 %f15, [%rd40+12]
  f15 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (12)))));
  // PTX:121 sub.f32 %f5, %f14, %f15
  asm("sub.f32 %0, %1, %2;" : "=f"(f5) : "f"(f14), "f"(f15));
  // PTX:122 add.f32 %f6, %f4, %f15
  asm("add.f32 %0, %1, %2;" : "=f"(f6) : "f"(f4), "f"(f15));
  // PTX:123 add.f32 %f7, %f3, %f13
  asm("add.f32 %0, %1, %2;" : "=f"(f7) : "f"(f3), "f"(f13));
  // PTX:124 cvt.s64.s32 %rd8, %r25
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd8) : "r"(r25));
  // PTX:125 mul.wide.s32 %rd41, %r25, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd41) : "r"(r25));
  // PTX:126 add.s64 %rd42, %rd36, %rd41
  asm("add.s64 %0, %1, %2;" : "=l"(rd42) : "l"(rd36), "l"(rd41));
  // PTX:127 cvt.s64.s32 %rd9, %r26
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd9) : "r"(r26));
  // PTX:128 mul.wide.s32 %rd43, %r26, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd43) : "r"(r26));
  // PTX:129 add.s64 %rd44, %rd36, %rd43
  asm("add.s64 %0, %1, %2;" : "=l"(rd44) : "l"(rd36), "l"(rd43));
  // PTX:130 ld.global.f32 %f16, [%rd44]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))));
  // PTX:131 ld.global.f32 %f17, [%rd42]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (0)))));
  // PTX:132 sub.f32 %f18, %f16, %f17
  asm("sub.f32 %0, %1, %2;" : "=f"(f18) : "f"(f16), "f"(f17));
  // PTX:133 ld.global.f32 %f19, [%rd44+4]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (4)))));
  // PTX:134 ld.global.f32 %f20, [%rd42+4]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (4)))));
  // PTX:135 sub.f32 %f21, %f19, %f20
  asm("sub.f32 %0, %1, %2;" : "=f"(f21) : "f"(f19), "f"(f20));
  // PTX:136 ld.global.f32 %f22, [%rd44+8]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (8)))));
  // PTX:137 ld.global.f32 %f23, [%rd42+8]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (8)))));
  // PTX:138 sub.f32 %f24, %f22, %f23
  asm("sub.f32 %0, %1, %2;" : "=f"(f24) : "f"(f22), "f"(f23));
  // PTX:139 fma.rn.f32 %f25, %f5, %f18, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f25) : "f"(f5), "f"(f18));
  // PTX:140 fma.rn.f32 %f26, %f5, %f21, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f26) : "f"(f5), "f"(f21));
  // PTX:141 fma.rn.f32 %f27, %f5, %f24, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f27) : "f"(f5), "f"(f24));
  // PTX:142 cvt.s64.s32 %rd10, %r27
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd10) : "r"(r27));
  // PTX:143 mul.wide.s32 %rd45, %r27, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd45) : "r"(r27));
  // PTX:144 add.s64 %rd46, %rd36, %rd45
  asm("add.s64 %0, %1, %2;" : "=l"(rd46) : "l"(rd36), "l"(rd45));
  // PTX:145 ld.global.f32 %f28, [%rd46]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (0)))));
  // PTX:146 sub.f32 %f29, %f28, %f17
  asm("sub.f32 %0, %1, %2;" : "=f"(f29) : "f"(f28), "f"(f17));
  // PTX:147 ld.global.f32 %f30, [%rd46+4]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (4)))));
  // PTX:148 sub.f32 %f31, %f30, %f20
  asm("sub.f32 %0, %1, %2;" : "=f"(f31) : "f"(f30), "f"(f20));
  // PTX:149 ld.global.f32 %f32, [%rd46+8]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (8)))));
  // PTX:150 sub.f32 %f33, %f32, %f23
  asm("sub.f32 %0, %1, %2;" : "=f"(f33) : "f"(f32), "f"(f23));
  // PTX:151 fma.rn.f32 %f34, %f6, %f29, %f25
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f34) : "f"(f6), "f"(f29), "f"(f25));
  // PTX:152 fma.rn.f32 %f35, %f6, %f31, %f26
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f35) : "f"(f6), "f"(f31), "f"(f26));
  // PTX:153 fma.rn.f32 %f36, %f6, %f33, %f27
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f36) : "f"(f6), "f"(f33), "f"(f27));
  // PTX:154 cvt.s64.s32 %rd11, %r28
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd11) : "r"(r28));
  // PTX:155 mul.wide.s32 %rd47, %r28, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd47) : "r"(r28));
  // PTX:156 add.s64 %rd48, %rd36, %rd47
  asm("add.s64 %0, %1, %2;" : "=l"(rd48) : "l"(rd36), "l"(rd47));
  // PTX:157 ld.global.f32 %f37, [%rd48]
  f37 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))));
  // PTX:158 sub.f32 %f38, %f37, %f17
  asm("sub.f32 %0, %1, %2;" : "=f"(f38) : "f"(f37), "f"(f17));
  // PTX:159 ld.global.f32 %f39, [%rd48+4]
  f39 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (4)))));
  // PTX:160 sub.f32 %f40, %f39, %f20
  asm("sub.f32 %0, %1, %2;" : "=f"(f40) : "f"(f39), "f"(f20));
  // PTX:161 ld.global.f32 %f41, [%rd48+8]
  f41 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (8)))));
  // PTX:162 sub.f32 %f42, %f41, %f23
  asm("sub.f32 %0, %1, %2;" : "=f"(f42) : "f"(f41), "f"(f23));
  // PTX:163 fma.rn.f32 %f8, %f7, %f38, %f34
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f8) : "f"(f7), "f"(f38), "f"(f34));
  // PTX:164 fma.rn.f32 %f9, %f7, %f40, %f35
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f9) : "f"(f7), "f"(f40), "f"(f35));
  // PTX:165 fma.rn.f32 %f10, %f7, %f42, %f36
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f10) : "f"(f7), "f"(f42), "f"(f36));
  // PTX:166 mul.f32 %f43, %f9, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f43) : "f"(f9), "f"(f9));
  // PTX:167 fma.rn.f32 %f44, %f8, %f8, %f43
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f44) : "f"(f8), "f"(f8), "f"(f43));
  // PTX:168 fma.rn.f32 %f45, %f10, %f10, %f44
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f45) : "f"(f10), "f"(f10), "f"(f44));
  // PTX:169 sqrt.rn.f32 %f11, %f45
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f11) : "f"(f45));
  // PTX:170 setp.leu.f32 %p21, %f11, 0f2B8CBCCC
  p21 = ((isnan(((float)(f11))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) || (((float)(f11)) <= ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:171 mov.u32 %r29, 0
  asm("mov.u32 %0, 0;" : "=r"(r29) : );
  // PTX:172 mov.u32 %r30, %r29
  asm("mov.u32 %0, %1;" : "=r"(r30) : "r"(r29));
  // PTX:173 mov.u32 %r31, %r29
  asm("mov.u32 %0, %1;" : "=r"(r31) : "r"(r29));
  // PTX:174 @%p21 bra $L__BB48_10
  if (p21) { goto L_BB48_10; }
  // PTX:176 div.rn.f32 %f46, %f8, %f11
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f46) : "f"(f8), "f"(f11));
  // PTX:177 div.rn.f32 %f47, %f9, %f11
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f47) : "f"(f9), "f"(f11));
  // PTX:178 div.rn.f32 %f48, %f10, %f11
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f48) : "f"(f10), "f"(f11));
  // PTX:179 mov.b32 %r31, %f48
  asm("mov.b32 %0, %1;" : "=r"(r31) : "f"(f48));
  // PTX:180 mov.b32 %r30, %f47
  asm("mov.b32 %0, %1;" : "=r"(r30) : "f"(f47));
  // PTX:181 mov.b32 %r29, %f46
  asm("mov.b32 %0, %1;" : "=r"(r29) : "f"(f46));
  // PTX:183 $L__BB48_10:
L_BB48_10:;
  // PTX:184 cvta.to.global.u64 %rd49, %rd17
  rd49 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd17));
  // PTX:185 neg.f32 %f49, %f3
  asm("neg.f32 %0, %1;" : "=f"(f49) : "f"(f3));
  // PTX:186 sub.f32 %f50, %f49, %f4
  asm("sub.f32 %0, %1, %2;" : "=f"(f50) : "f"(f49), "f"(f4));
  // PTX:187 mov.f32 %f51, 0f40400000
  asm("mov.f32 %0, 0f40400000;" : "=f"(f51) : );
  // PTX:188 div.rn.f32 %f52, %f51, %f1
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f52) : "f"(f51), "f"(f1));
  // PTX:189 mul.f32 %f53, %f2, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f53) : "f"(f2), "f"(f52));
  // PTX:190 mov.b32 %f54, %r29
  asm("mov.b32 %0, %1;" : "=f"(f54) : "r"(r29));
  // PTX:191 mov.b32 %f55, %r30
  asm("mov.b32 %0, %1;" : "=f"(f55) : "r"(r30));
  // PTX:192 mov.b32 %f56, %r31
  asm("mov.b32 %0, %1;" : "=f"(f56) : "r"(r31));
  // PTX:193 mul.f32 %f57, %f54, %f54
  asm("mul.f32 %0, %1, %2;" : "=f"(f57) : "f"(f54), "f"(f54));
  // PTX:194 mul.f32 %f58, %f55, %f54
  asm("mul.f32 %0, %1, %2;" : "=f"(f58) : "f"(f55), "f"(f54));
  // PTX:195 mul.f32 %f59, %f56, %f54
  asm("mul.f32 %0, %1, %2;" : "=f"(f59) : "f"(f56), "f"(f54));
  // PTX:196 mul.f32 %f60, %f55, %f55
  asm("mul.f32 %0, %1, %2;" : "=f"(f60) : "f"(f55), "f"(f55));
  // PTX:197 mul.f32 %f61, %f56, %f55
  asm("mul.f32 %0, %1, %2;" : "=f"(f61) : "f"(f56), "f"(f55));
  // PTX:198 mul.f32 %f62, %f56, %f56
  asm("mul.f32 %0, %1, %2;" : "=f"(f62) : "f"(f56), "f"(f56));
  // PTX:199 mul.f32 %f63, %f53, %f12
  asm("mul.f32 %0, %1, %2;" : "=f"(f63) : "f"(f53), "f"(f12));
  // PTX:200 mul.f32 %f64, %f63, %f57
  asm("mul.f32 %0, %1, %2;" : "=f"(f64) : "f"(f63), "f"(f57));
  // PTX:201 mul.f32 %f65, %f63, %f58
  asm("mul.f32 %0, %1, %2;" : "=f"(f65) : "f"(f63), "f"(f58));
  // PTX:202 mul.f32 %f66, %f63, %f59
  asm("mul.f32 %0, %1, %2;" : "=f"(f66) : "f"(f63), "f"(f59));
  // PTX:203 mul.f32 %f67, %f63, %f60
  asm("mul.f32 %0, %1, %2;" : "=f"(f67) : "f"(f63), "f"(f60));
  // PTX:204 mul.f32 %f68, %f63, %f61
  asm("mul.f32 %0, %1, %2;" : "=f"(f68) : "f"(f63), "f"(f61));
  // PTX:205 mul.f32 %f69, %f63, %f62
  asm("mul.f32 %0, %1, %2;" : "=f"(f69) : "f"(f63), "f"(f62));
  // PTX:206 mul.f32 %f70, %f50, %f50
  asm("mul.f32 %0, %1, %2;" : "=f"(f70) : "f"(f50), "f"(f50));
  // PTX:207 mul.f32 %f71, %f64, %f70
  asm("mul.f32 %0, %1, %2;" : "=f"(f71) : "f"(f64), "f"(f70));
  // PTX:208 mul.f32 %f72, %f70, %f65
  asm("mul.f32 %0, %1, %2;" : "=f"(f72) : "f"(f70), "f"(f65));
  // PTX:209 mul.f32 %f73, %f70, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f73) : "f"(f70), "f"(f66));
  // PTX:210 mul.lo.s64 %rd50, %rd8, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd50) : "l"(rd8));
  // PTX:211 add.s64 %rd51, %rd49, %rd50
  asm("add.s64 %0, %1, %2;" : "=l"(rd51) : "l"(rd49), "l"(rd50));
  // PTX:212 red.global.add.f32 [%rd51], %f71
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))), (float)(f71));
  // PTX:213 add.s64 %rd52, %rd51, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd52) : "l"(rd51));
  // PTX:214 red.global.add.f32 [%rd52], %f72
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))), (float)(f72));
  // PTX:215 add.s64 %rd53, %rd51, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd53) : "l"(rd51));
  // PTX:216 red.global.add.f32 [%rd53], %f73
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))), (float)(f73));
  // PTX:217 mul.f32 %f77, %f70, %f67
  asm("mul.f32 %0, %1, %2;" : "=f"(f77) : "f"(f70), "f"(f67));
  // PTX:218 mul.f32 %f78, %f70, %f68
  asm("mul.f32 %0, %1, %2;" : "=f"(f78) : "f"(f70), "f"(f68));
  // PTX:219 add.s64 %rd54, %rd51, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd54) : "l"(rd51));
  // PTX:220 red.global.add.f32 [%rd54], %f72
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))), (float)(f72));
  // PTX:221 add.s64 %rd55, %rd51, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd55) : "l"(rd51));
  // PTX:222 red.global.add.f32 [%rd55], %f77
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))), (float)(f77));
  // PTX:223 add.s64 %rd56, %rd51, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd56) : "l"(rd51));
  // PTX:224 red.global.add.f32 [%rd56], %f78
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))), (float)(f78));
  // PTX:225 mul.f32 %f82, %f70, %f69
  asm("mul.f32 %0, %1, %2;" : "=f"(f82) : "f"(f70), "f"(f69));
  // PTX:226 add.s64 %rd57, %rd51, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd57) : "l"(rd51));
  // PTX:227 red.global.add.f32 [%rd57], %f73
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))), (float)(f73));
  // PTX:228 add.s64 %rd58, %rd51, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd58) : "l"(rd51));
  // PTX:229 red.global.add.f32 [%rd58], %f78
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (0)))), (float)(f78));
  // PTX:230 add.s64 %rd59, %rd51, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd59) : "l"(rd51));
  // PTX:231 red.global.add.f32 [%rd59], %f82
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))), (float)(f82));
  // PTX:232 mul.f32 %f86, %f5, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f86) : "f"(f5), "f"(f5));
  // PTX:233 mul.f32 %f87, %f64, %f86
  asm("mul.f32 %0, %1, %2;" : "=f"(f87) : "f"(f64), "f"(f86));
  // PTX:234 mul.f32 %f88, %f86, %f65
  asm("mul.f32 %0, %1, %2;" : "=f"(f88) : "f"(f86), "f"(f65));
  // PTX:235 mul.f32 %f89, %f86, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f89) : "f"(f86), "f"(f66));
  // PTX:236 mul.lo.s64 %rd60, %rd9, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd60) : "l"(rd9));
  // PTX:237 add.s64 %rd61, %rd49, %rd60
  asm("add.s64 %0, %1, %2;" : "=l"(rd61) : "l"(rd49), "l"(rd60));
  // PTX:238 red.global.add.f32 [%rd61], %f87
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))), (float)(f87));
  // PTX:239 add.s64 %rd62, %rd61, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd62) : "l"(rd61));
  // PTX:240 red.global.add.f32 [%rd62], %f88
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))), (float)(f88));
  // PTX:241 add.s64 %rd63, %rd61, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd63) : "l"(rd61));
  // PTX:242 red.global.add.f32 [%rd63], %f89
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (0)))), (float)(f89));
  // PTX:243 mul.f32 %f93, %f86, %f67
  asm("mul.f32 %0, %1, %2;" : "=f"(f93) : "f"(f86), "f"(f67));
  // PTX:244 mul.f32 %f94, %f86, %f68
  asm("mul.f32 %0, %1, %2;" : "=f"(f94) : "f"(f86), "f"(f68));
  // PTX:245 add.s64 %rd64, %rd61, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd64) : "l"(rd61));
  // PTX:246 red.global.add.f32 [%rd64], %f88
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (0)))), (float)(f88));
  // PTX:247 add.s64 %rd65, %rd61, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd65) : "l"(rd61));
  // PTX:248 red.global.add.f32 [%rd65], %f93
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (0)))), (float)(f93));
  // PTX:249 add.s64 %rd66, %rd61, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd66) : "l"(rd61));
  // PTX:250 red.global.add.f32 [%rd66], %f94
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (0)))), (float)(f94));
  // PTX:251 mul.f32 %f98, %f86, %f69
  asm("mul.f32 %0, %1, %2;" : "=f"(f98) : "f"(f86), "f"(f69));
  // PTX:252 add.s64 %rd67, %rd61, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd67) : "l"(rd61));
  // PTX:253 red.global.add.f32 [%rd67], %f89
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0)))), (float)(f89));
  // PTX:254 add.s64 %rd68, %rd61, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd68) : "l"(rd61));
  // PTX:255 red.global.add.f32 [%rd68], %f94
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (0)))), (float)(f94));
  // PTX:256 add.s64 %rd69, %rd61, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd69) : "l"(rd61));
  // PTX:257 red.global.add.f32 [%rd69], %f98
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (0)))), (float)(f98));
  // PTX:258 mul.f32 %f102, %f6, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f102) : "f"(f6), "f"(f6));
  // PTX:259 mul.f32 %f103, %f64, %f102
  asm("mul.f32 %0, %1, %2;" : "=f"(f103) : "f"(f64), "f"(f102));
  // PTX:260 mul.f32 %f104, %f102, %f65
  asm("mul.f32 %0, %1, %2;" : "=f"(f104) : "f"(f102), "f"(f65));
  // PTX:261 mul.f32 %f105, %f102, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f105) : "f"(f102), "f"(f66));
  // PTX:262 mul.lo.s64 %rd70, %rd10, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd70) : "l"(rd10));
  // PTX:263 add.s64 %rd71, %rd49, %rd70
  asm("add.s64 %0, %1, %2;" : "=l"(rd71) : "l"(rd49), "l"(rd70));
  // PTX:264 red.global.add.f32 [%rd71], %f103
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))), (float)(f103));
  // PTX:265 add.s64 %rd72, %rd71, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd72) : "l"(rd71));
  // PTX:266 red.global.add.f32 [%rd72], %f104
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (0)))), (float)(f104));
  // PTX:267 add.s64 %rd73, %rd71, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd73) : "l"(rd71));
  // PTX:268 red.global.add.f32 [%rd73], %f105
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (0)))), (float)(f105));
  // PTX:269 mul.f32 %f109, %f102, %f67
  asm("mul.f32 %0, %1, %2;" : "=f"(f109) : "f"(f102), "f"(f67));
  // PTX:270 mul.f32 %f110, %f102, %f68
  asm("mul.f32 %0, %1, %2;" : "=f"(f110) : "f"(f102), "f"(f68));
  // PTX:271 add.s64 %rd74, %rd71, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd74) : "l"(rd71));
  // PTX:272 red.global.add.f32 [%rd74], %f104
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (0)))), (float)(f104));
  // PTX:273 add.s64 %rd75, %rd71, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd75) : "l"(rd71));
  // PTX:274 red.global.add.f32 [%rd75], %f109
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (0)))), (float)(f109));
  // PTX:275 add.s64 %rd76, %rd71, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd76) : "l"(rd71));
  // PTX:276 red.global.add.f32 [%rd76], %f110
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (0)))), (float)(f110));
  // PTX:277 mul.f32 %f114, %f102, %f69
  asm("mul.f32 %0, %1, %2;" : "=f"(f114) : "f"(f102), "f"(f69));
  // PTX:278 add.s64 %rd77, %rd71, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd77) : "l"(rd71));
  // PTX:279 red.global.add.f32 [%rd77], %f105
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (0)))), (float)(f105));
  // PTX:280 add.s64 %rd78, %rd71, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd78) : "l"(rd71));
  // PTX:281 red.global.add.f32 [%rd78], %f110
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd78) + (0)))), (float)(f110));
  // PTX:282 add.s64 %rd79, %rd71, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd79) : "l"(rd71));
  // PTX:283 red.global.add.f32 [%rd79], %f114
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (0)))), (float)(f114));
  // PTX:284 mul.f32 %f118, %f7, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f118) : "f"(f7), "f"(f7));
  // PTX:285 mul.f32 %f119, %f64, %f118
  asm("mul.f32 %0, %1, %2;" : "=f"(f119) : "f"(f64), "f"(f118));
  // PTX:286 mul.f32 %f120, %f118, %f65
  asm("mul.f32 %0, %1, %2;" : "=f"(f120) : "f"(f118), "f"(f65));
  // PTX:287 mul.f32 %f121, %f118, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f121) : "f"(f118), "f"(f66));
  // PTX:288 mul.lo.s64 %rd80, %rd11, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd80) : "l"(rd11));
  // PTX:289 add.s64 %rd81, %rd49, %rd80
  asm("add.s64 %0, %1, %2;" : "=l"(rd81) : "l"(rd49), "l"(rd80));
  // PTX:290 red.global.add.f32 [%rd81], %f119
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (0)))), (float)(f119));
  // PTX:291 add.s64 %rd82, %rd81, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd82) : "l"(rd81));
  // PTX:292 red.global.add.f32 [%rd82], %f120
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (0)))), (float)(f120));
  // PTX:293 add.s64 %rd83, %rd81, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd83) : "l"(rd81));
  // PTX:294 red.global.add.f32 [%rd83], %f121
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (0)))), (float)(f121));
  // PTX:295 mul.f32 %f125, %f118, %f67
  asm("mul.f32 %0, %1, %2;" : "=f"(f125) : "f"(f118), "f"(f67));
  // PTX:296 mul.f32 %f126, %f118, %f68
  asm("mul.f32 %0, %1, %2;" : "=f"(f126) : "f"(f118), "f"(f68));
  // PTX:297 add.s64 %rd84, %rd81, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd84) : "l"(rd81));
  // PTX:298 red.global.add.f32 [%rd84], %f120
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (0)))), (float)(f120));
  // PTX:299 add.s64 %rd85, %rd81, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd85) : "l"(rd81));
  // PTX:300 red.global.add.f32 [%rd85], %f125
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (0)))), (float)(f125));
  // PTX:301 add.s64 %rd86, %rd81, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd86) : "l"(rd81));
  // PTX:302 red.global.add.f32 [%rd86], %f126
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd86) + (0)))), (float)(f126));
  // PTX:303 mul.f32 %f130, %f118, %f69
  asm("mul.f32 %0, %1, %2;" : "=f"(f130) : "f"(f118), "f"(f69));
  // PTX:304 add.s64 %rd87, %rd81, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd87) : "l"(rd81));
  // PTX:305 red.global.add.f32 [%rd87], %f121
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (0)))), (float)(f121));
  // PTX:306 add.s64 %rd88, %rd81, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd88) : "l"(rd81));
  // PTX:307 red.global.add.f32 [%rd88], %f126
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (0)))), (float)(f126));
  // PTX:308 add.s64 %rd89, %rd81, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd89) : "l"(rd81));
  // PTX:309 red.global.add.f32 [%rd89], %f130
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (0)))), (float)(f130));
  // PTX:311 $L__BB48_11:
L_BB48_11:;
  // PTX:312 ret
  return;
}
