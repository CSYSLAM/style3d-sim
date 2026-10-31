// 机械还原自 PTX：synreal::kernel::evaluate_stretch_force(glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::mat<2, 2, float, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: f7721c3a263f765630f4092fe4ba8bbd3b486d24e84ededdde89aa6a2d6a8115
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__evaluate_stretch_force(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8) {
  int p0, p1, p2, p3, p4;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59;
  // PTX:25 ld.param.u64 %rd11, [_ZN7synreal6kernel22evaluate_stretch_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKfPKNS1_3matILi2ELi2EfLS3_0EEEPKNS2_ILi3EiLS3_0EEES6_PS4_mmm_param_0]
  rd11 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:26 ld.param.u64 %rd12, [_ZN7synreal6kernel22evaluate_stretch_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKfPKNS1_3matILi2ELi2EfLS3_0EEEPKNS2_ILi3EiLS3_0EEES6_PS4_mmm_param_1]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:27 ld.param.u64 %rd13, [_ZN7synreal6kernel22evaluate_stretch_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKfPKNS1_3matILi2ELi2EfLS3_0EEEPKNS2_ILi3EiLS3_0EEES6_PS4_mmm_param_2]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:28 ld.param.u64 %rd14, [_ZN7synreal6kernel22evaluate_stretch_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKfPKNS1_3matILi2ELi2EfLS3_0EEEPKNS2_ILi3EiLS3_0EEES6_PS4_mmm_param_3]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:29 ld.param.u64 %rd15, [_ZN7synreal6kernel22evaluate_stretch_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKfPKNS1_3matILi2ELi2EfLS3_0EEEPKNS2_ILi3EiLS3_0EEES6_PS4_mmm_param_4]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:30 ld.param.u64 %rd16, [_ZN7synreal6kernel22evaluate_stretch_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKfPKNS1_3matILi2ELi2EfLS3_0EEEPKNS2_ILi3EiLS3_0EEES6_PS4_mmm_param_5]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:31 ld.param.u64 %rd19, [_ZN7synreal6kernel22evaluate_stretch_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKfPKNS1_3matILi2ELi2EfLS3_0EEEPKNS2_ILi3EiLS3_0EEES6_PS4_mmm_param_6]
  rd19 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:32 ld.param.u64 %rd17, [_ZN7synreal6kernel22evaluate_stretch_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKfPKNS1_3matILi2ELi2EfLS3_0EEEPKNS2_ILi3EiLS3_0EEES6_PS4_mmm_param_7]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:33 ld.param.u64 %rd18, [_ZN7synreal6kernel22evaluate_stretch_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKfPKNS1_3matILi2ELi2EfLS3_0EEEPKNS2_ILi3EiLS3_0EEES6_PS4_mmm_param_8]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:34 mov.u32 %r13, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r13) : "r"(blockIdx.x));
  // PTX:35 mov.u32 %r14, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r14) : "r"(blockDim.x));
  // PTX:36 mul.wide.u32 %rd20, %r13, %r14
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd20) : "r"(r13), "r"(r14));
  // PTX:37 mov.u32 %r15, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r15) : "r"(threadIdx.x));
  // PTX:38 cvt.u64.u32 %rd21, %r15
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd21) : "r"(r15));
  // PTX:39 add.s64 %rd1, %rd20, %rd21
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd20), "l"(rd21));
  // PTX:40 setp.ge.u64 %p1, %rd1, %rd19
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd19)));
  // PTX:41 @%p1 bra $L__BB45_9
  if (p1) { goto L_BB45_9; }
  // PTX:43 or.b64 %rd22, %rd1, %rd17
  asm("or.b64 %0, %1, %2;" : "=l"(rd22) : "l"(rd1), "l"(rd17));
  // PTX:44 and.b64 %rd23, %rd22, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd23) : "l"(rd22));
  // PTX:45 setp.eq.s64 %p2, %rd23, 0
  p2 = (((long long)(rd23)) == ((long long)(0)));
  // PTX:46 @%p2 bra $L__BB45_3
  if (p2) { goto L_BB45_3; }
  // PTX:48 div.u64 %rd58, %rd1, %rd17
  asm("div.u64 %0, %1, %2;" : "=l"(rd58) : "l"(rd1), "l"(rd17));
  // PTX:49 mul.lo.s64 %rd24, %rd58, %rd17
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd24) : "l"(rd58), "l"(rd17));
  // PTX:50 sub.s64 %rd59, %rd1, %rd24
  asm("sub.s64 %0, %1, %2;" : "=l"(rd59) : "l"(rd1), "l"(rd24));
  // PTX:51 bra.uni $L__BB45_4
  goto L_BB45_4;
  // PTX:53 $L__BB45_3:
L_BB45_3:;
  // PTX:54 cvt.u32.u64 %r16, %rd17
  asm("cvt.u32.u64 %0, %1;" : "=r"(r16) : "l"(rd17));
  // PTX:55 cvt.u32.u64 %r17, %rd1
  asm("cvt.u32.u64 %0, %1;" : "=r"(r17) : "l"(rd1));
  // PTX:56 div.u32 %r18, %r17, %r16
  asm("div.u32 %0, %1, %2;" : "=r"(r18) : "r"(r17), "r"(r16));
  // PTX:57 mul.lo.s32 %r19, %r18, %r16
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r19) : "r"(r18), "r"(r16));
  // PTX:58 sub.s32 %r20, %r17, %r19
  asm("sub.s32 %0, %1, %2;" : "=r"(r20) : "r"(r17), "r"(r19));
  // PTX:59 cvt.u64.u32 %rd58, %r18
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd58) : "r"(r18));
  // PTX:60 cvt.u64.u32 %rd59, %r20
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd59) : "r"(r20));
  // PTX:62 $L__BB45_4:
L_BB45_4:;
  // PTX:63 cvta.to.global.u64 %rd25, %rd11
  rd25 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd11));
  // PTX:64 mul.lo.s64 %rd26, %rd58, %rd18
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd26) : "l"(rd58), "l"(rd18));
  // PTX:65 cvt.u32.u64 %r24, %rd26
  asm("cvt.u32.u64 %0, %1;" : "=r"(r24) : "l"(rd26));
  // PTX:66 cvta.to.global.u64 %rd27, %rd14
  rd27 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd14));
  // PTX:67 mul.lo.s64 %rd28, %rd59, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd28) : "l"(rd59));
  // PTX:68 add.s64 %rd29, %rd27, %rd28
  asm("add.s64 %0, %1, %2;" : "=l"(rd29) : "l"(rd27), "l"(rd28));
  // PTX:69 ld.global.u32 %r25, [%rd29]
  r25 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (0)))));
  // PTX:70 add.s32 %r26, %r25, %r24
  asm("add.s32 %0, %1, %2;" : "=r"(r26) : "r"(r25), "r"(r24));
  // PTX:71 ld.global.u32 %r27, [%rd29+4]
  r27 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (4)))));
  // PTX:72 add.s32 %r28, %r27, %r24
  asm("add.s32 %0, %1, %2;" : "=r"(r28) : "r"(r27), "r"(r24));
  // PTX:73 ld.global.u32 %r29, [%rd29+8]
  r29 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (8)))));
  // PTX:74 add.s32 %r30, %r29, %r24
  asm("add.s32 %0, %1, %2;" : "=r"(r30) : "r"(r29), "r"(r24));
  // PTX:75 cvt.s64.s32 %rd8, %r28
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd8) : "r"(r28));
  // PTX:76 mul.wide.s32 %rd30, %r28, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd30) : "r"(r28));
  // PTX:77 add.s64 %rd31, %rd25, %rd30
  asm("add.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd25), "l"(rd30));
  // PTX:78 cvt.s64.s32 %rd9, %r26
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd9) : "r"(r26));
  // PTX:79 mul.wide.s32 %rd32, %r26, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd32) : "r"(r26));
  // PTX:80 add.s64 %rd33, %rd25, %rd32
  asm("add.s64 %0, %1, %2;" : "=l"(rd33) : "l"(rd25), "l"(rd32));
  // PTX:81 ld.global.f32 %f15, [%rd33]
  f15 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (0)))));
  // PTX:82 ld.global.f32 %f16, [%rd31]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (0)))));
  // PTX:83 sub.f32 %f17, %f16, %f15
  asm("sub.f32 %0, %1, %2;" : "=f"(f17) : "f"(f16), "f"(f15));
  // PTX:84 ld.global.f32 %f18, [%rd33+4]
  f18 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (4)))));
  // PTX:85 ld.global.f32 %f19, [%rd31+4]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (4)))));
  // PTX:86 sub.f32 %f20, %f19, %f18
  asm("sub.f32 %0, %1, %2;" : "=f"(f20) : "f"(f19), "f"(f18));
  // PTX:87 ld.global.f32 %f21, [%rd33+8]
  f21 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (8)))));
  // PTX:88 ld.global.f32 %f22, [%rd31+8]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (8)))));
  // PTX:89 sub.f32 %f23, %f22, %f21
  asm("sub.f32 %0, %1, %2;" : "=f"(f23) : "f"(f22), "f"(f21));
  // PTX:90 cvt.s64.s32 %rd10, %r30
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd10) : "r"(r30));
  // PTX:91 mul.wide.s32 %rd34, %r30, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd34) : "r"(r30));
  // PTX:92 add.s64 %rd35, %rd25, %rd34
  asm("add.s64 %0, %1, %2;" : "=l"(rd35) : "l"(rd25), "l"(rd34));
  // PTX:93 ld.global.f32 %f24, [%rd35]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (0)))));
  // PTX:94 sub.f32 %f25, %f24, %f15
  asm("sub.f32 %0, %1, %2;" : "=f"(f25) : "f"(f24), "f"(f15));
  // PTX:95 ld.global.f32 %f26, [%rd35+4]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (4)))));
  // PTX:96 sub.f32 %f27, %f26, %f18
  asm("sub.f32 %0, %1, %2;" : "=f"(f27) : "f"(f26), "f"(f18));
  // PTX:97 ld.global.f32 %f28, [%rd35+8]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (8)))));
  // PTX:98 sub.f32 %f29, %f28, %f21
  asm("sub.f32 %0, %1, %2;" : "=f"(f29) : "f"(f28), "f"(f21));
  // PTX:99 cvta.to.global.u64 %rd36, %rd13
  rd36 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd13));
  // PTX:100 shl.b64 %rd37, %rd59, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd37) : "l"(rd59));
  // PTX:101 add.s64 %rd38, %rd36, %rd37
  asm("add.s64 %0, %1, %2;" : "=l"(rd38) : "l"(rd36), "l"(rd37));
  // PTX:102 ld.global.f32 %f1, [%rd38]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (0)))));
  // PTX:103 ld.global.f32 %f2, [%rd38+8]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (8)))));
  // PTX:104 mul.f32 %f30, %f25, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f30) : "f"(f25), "f"(f2));
  // PTX:105 mul.f32 %f31, %f27, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f31) : "f"(f27), "f"(f2));
  // PTX:106 mul.f32 %f32, %f29, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f32) : "f"(f29), "f"(f2));
  // PTX:107 fma.rn.f32 %f3, %f17, %f1, %f30
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f3) : "f"(f17), "f"(f1), "f"(f30));
  // PTX:108 fma.rn.f32 %f4, %f20, %f1, %f31
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f4) : "f"(f20), "f"(f1), "f"(f31));
  // PTX:109 fma.rn.f32 %f5, %f23, %f1, %f32
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f5) : "f"(f23), "f"(f1), "f"(f32));
  // PTX:110 ld.global.f32 %f6, [%rd38+4]
  f6 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (4)))));
  // PTX:111 ld.global.f32 %f7, [%rd38+12]
  f7 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (12)))));
  // PTX:112 mul.f32 %f33, %f25, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f33) : "f"(f25), "f"(f7));
  // PTX:113 mul.f32 %f34, %f27, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f34) : "f"(f27), "f"(f7));
  // PTX:114 mul.f32 %f35, %f29, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f35) : "f"(f29), "f"(f7));
  // PTX:115 fma.rn.f32 %f8, %f17, %f6, %f33
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f8) : "f"(f17), "f"(f6), "f"(f33));
  // PTX:116 fma.rn.f32 %f9, %f20, %f6, %f34
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f9) : "f"(f20), "f"(f6), "f"(f34));
  // PTX:117 fma.rn.f32 %f10, %f23, %f6, %f35
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f10) : "f"(f23), "f"(f6), "f"(f35));
  // PTX:118 mul.f32 %f36, %f4, %f4
  asm("mul.f32 %0, %1, %2;" : "=f"(f36) : "f"(f4), "f"(f4));
  // PTX:119 fma.rn.f32 %f37, %f3, %f3, %f36
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f37) : "f"(f3), "f"(f3), "f"(f36));
  // PTX:120 fma.rn.f32 %f11, %f5, %f5, %f37
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f11) : "f"(f5), "f"(f5), "f"(f37));
  // PTX:121 sqrt.rn.f32 %f12, %f11
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f12) : "f"(f11));
  // PTX:122 setp.leu.f32 %p3, %f12, 0f00000000
  p3 = ((isnan(((float)(f12))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f12)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:123 mov.u32 %r37, 0
  asm("mov.u32 %0, 0;" : "=r"(r37) : );
  // PTX:124 mov.u32 %r34, %r37
  asm("mov.u32 %0, %1;" : "=r"(r34) : "r"(r37));
  // PTX:125 mov.u32 %r35, %r37
  asm("mov.u32 %0, %1;" : "=r"(r35) : "r"(r37));
  // PTX:126 mov.u32 %r36, %r37
  asm("mov.u32 %0, %1;" : "=r"(r36) : "r"(r37));
  // PTX:127 @%p3 bra $L__BB45_6
  if (p3) { goto L_BB45_6; }
  // PTX:129 div.rn.f32 %f38, %f3, %f12
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f38) : "f"(f3), "f"(f12));
  // PTX:130 div.rn.f32 %f39, %f4, %f12
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f39) : "f"(f4), "f"(f12));
  // PTX:131 div.rn.f32 %f40, %f5, %f12
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f40) : "f"(f5), "f"(f12));
  // PTX:132 mov.b32 %r36, %f40
  asm("mov.b32 %0, %1;" : "=r"(r36) : "f"(f40));
  // PTX:133 mov.b32 %r35, %f39
  asm("mov.b32 %0, %1;" : "=r"(r35) : "f"(f39));
  // PTX:134 mov.b32 %r34, %f38
  asm("mov.b32 %0, %1;" : "=r"(r34) : "f"(f38));
  // PTX:136 $L__BB45_6:
L_BB45_6:;
  // PTX:137 mul.f32 %f41, %f9, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f41) : "f"(f9), "f"(f9));
  // PTX:138 fma.rn.f32 %f42, %f8, %f8, %f41
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f42) : "f"(f8), "f"(f8), "f"(f41));
  // PTX:139 fma.rn.f32 %f13, %f10, %f10, %f42
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f13) : "f"(f10), "f"(f10), "f"(f42));
  // PTX:140 sqrt.rn.f32 %f14, %f13
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f14) : "f"(f13));
  // PTX:141 setp.leu.f32 %p4, %f14, 0f00000000
  p4 = ((isnan(((float)(f14))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f14)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:142 mov.u32 %r38, %r37
  asm("mov.u32 %0, %1;" : "=r"(r38) : "r"(r37));
  // PTX:143 mov.u32 %r39, %r37
  asm("mov.u32 %0, %1;" : "=r"(r39) : "r"(r37));
  // PTX:144 @%p4 bra $L__BB45_8
  if (p4) { goto L_BB45_8; }
  // PTX:146 div.rn.f32 %f43, %f8, %f14
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f43) : "f"(f8), "f"(f14));
  // PTX:147 div.rn.f32 %f44, %f9, %f14
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f44) : "f"(f9), "f"(f14));
  // PTX:148 div.rn.f32 %f45, %f10, %f14
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f45) : "f"(f10), "f"(f14));
  // PTX:149 mov.b32 %r39, %f45
  asm("mov.b32 %0, %1;" : "=r"(r39) : "f"(f45));
  // PTX:150 mov.b32 %r38, %f44
  asm("mov.b32 %0, %1;" : "=r"(r38) : "f"(f44));
  // PTX:151 mov.b32 %r37, %f43
  asm("mov.b32 %0, %1;" : "=r"(r37) : "f"(f43));
  // PTX:153 $L__BB45_8:
L_BB45_8:;
  // PTX:154 cvta.to.global.u64 %rd39, %rd16
  rd39 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd16));
  // PTX:155 neg.f32 %f46, %f1
  asm("neg.f32 %0, %1;" : "=f"(f46) : "f"(f1));
  // PTX:156 sub.f32 %f47, %f46, %f2
  asm("sub.f32 %0, %1, %2;" : "=f"(f47) : "f"(f46), "f"(f2));
  // PTX:157 neg.f32 %f48, %f6
  asm("neg.f32 %0, %1;" : "=f"(f48) : "f"(f6));
  // PTX:158 sub.f32 %f49, %f48, %f7
  asm("sub.f32 %0, %1, %2;" : "=f"(f49) : "f"(f48), "f"(f7));
  // PTX:159 add.f32 %f50, %f11, 0f2B8CBCCC
  asm("add.f32 %0, %1, 0f2B8CBCCC;" : "=f"(f50) : "f"(f11));
  // PTX:160 sqrt.rn.f32 %f51, %f50
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f51) : "f"(f50));
  // PTX:161 add.f32 %f52, %f13, 0f2B8CBCCC
  asm("add.f32 %0, %1, 0f2B8CBCCC;" : "=f"(f52) : "f"(f13));
  // PTX:162 sqrt.rn.f32 %f53, %f52
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f53) : "f"(f52));
  // PTX:163 div.rn.f32 %f54, %f3, %f51
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f54) : "f"(f3), "f"(f51));
  // PTX:164 div.rn.f32 %f55, %f4, %f51
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f55) : "f"(f4), "f"(f51));
  // PTX:165 div.rn.f32 %f56, %f5, %f51
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f56) : "f"(f5), "f"(f51));
  // PTX:166 div.rn.f32 %f57, %f8, %f53
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f57) : "f"(f8), "f"(f53));
  // PTX:167 div.rn.f32 %f58, %f9, %f53
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f58) : "f"(f9), "f"(f53));
  // PTX:168 div.rn.f32 %f59, %f10, %f53
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f59) : "f"(f10), "f"(f53));
  // PTX:169 mul.f32 %f60, %f55, %f58
  asm("mul.f32 %0, %1, %2;" : "=f"(f60) : "f"(f55), "f"(f58));
  // PTX:170 fma.rn.f32 %f61, %f54, %f57, %f60
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f61) : "f"(f54), "f"(f57), "f"(f60));
  // PTX:171 fma.rn.f32 %f62, %f56, %f59, %f61
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f62) : "f"(f56), "f"(f59), "f"(f61));
  // PTX:172 mul.f32 %f63, %f54, %f62
  asm("mul.f32 %0, %1, %2;" : "=f"(f63) : "f"(f54), "f"(f62));
  // PTX:173 mul.f32 %f64, %f55, %f62
  asm("mul.f32 %0, %1, %2;" : "=f"(f64) : "f"(f55), "f"(f62));
  // PTX:174 mul.f32 %f65, %f56, %f62
  asm("mul.f32 %0, %1, %2;" : "=f"(f65) : "f"(f56), "f"(f62));
  // PTX:175 sub.f32 %f66, %f57, %f63
  asm("sub.f32 %0, %1, %2;" : "=f"(f66) : "f"(f57), "f"(f63));
  // PTX:176 sub.f32 %f67, %f58, %f64
  asm("sub.f32 %0, %1, %2;" : "=f"(f67) : "f"(f58), "f"(f64));
  // PTX:177 sub.f32 %f68, %f59, %f65
  asm("sub.f32 %0, %1, %2;" : "=f"(f68) : "f"(f59), "f"(f65));
  // PTX:178 div.rn.f32 %f69, %f66, %f51
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f69) : "f"(f66), "f"(f51));
  // PTX:179 div.rn.f32 %f70, %f67, %f51
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f70) : "f"(f67), "f"(f51));
  // PTX:180 div.rn.f32 %f71, %f68, %f51
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f71) : "f"(f68), "f"(f51));
  // PTX:181 mul.f32 %f72, %f57, %f62
  asm("mul.f32 %0, %1, %2;" : "=f"(f72) : "f"(f57), "f"(f62));
  // PTX:182 mul.f32 %f73, %f58, %f62
  asm("mul.f32 %0, %1, %2;" : "=f"(f73) : "f"(f58), "f"(f62));
  // PTX:183 mul.f32 %f74, %f59, %f62
  asm("mul.f32 %0, %1, %2;" : "=f"(f74) : "f"(f59), "f"(f62));
  // PTX:184 sub.f32 %f75, %f54, %f72
  asm("sub.f32 %0, %1, %2;" : "=f"(f75) : "f"(f54), "f"(f72));
  // PTX:185 sub.f32 %f76, %f55, %f73
  asm("sub.f32 %0, %1, %2;" : "=f"(f76) : "f"(f55), "f"(f73));
  // PTX:186 sub.f32 %f77, %f56, %f74
  asm("sub.f32 %0, %1, %2;" : "=f"(f77) : "f"(f56), "f"(f74));
  // PTX:187 div.rn.f32 %f78, %f75, %f53
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f78) : "f"(f75), "f"(f53));
  // PTX:188 div.rn.f32 %f79, %f76, %f53
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f79) : "f"(f76), "f"(f53));
  // PTX:189 div.rn.f32 %f80, %f77, %f53
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f80) : "f"(f77), "f"(f53));
  // PTX:190 mov.b32 %f81, %r37
  asm("mov.b32 %0, %1;" : "=f"(f81) : "r"(r37));
  // PTX:191 mov.b32 %f82, %r38
  asm("mov.b32 %0, %1;" : "=f"(f82) : "r"(r38));
  // PTX:192 mov.b32 %f83, %r39
  asm("mov.b32 %0, %1;" : "=f"(f83) : "r"(r39));
  // PTX:193 mov.b32 %f84, %r34
  asm("mov.b32 %0, %1;" : "=f"(f84) : "r"(r34));
  // PTX:194 mul.f32 %f85, %f47, %f84
  asm("mul.f32 %0, %1, %2;" : "=f"(f85) : "f"(f47), "f"(f84));
  // PTX:195 mov.b32 %f86, %r35
  asm("mov.b32 %0, %1;" : "=f"(f86) : "r"(r35));
  // PTX:196 mul.f32 %f87, %f47, %f86
  asm("mul.f32 %0, %1, %2;" : "=f"(f87) : "f"(f47), "f"(f86));
  // PTX:197 mov.b32 %f88, %r36
  asm("mov.b32 %0, %1;" : "=f"(f88) : "r"(r36));
  // PTX:198 mul.f32 %f89, %f47, %f88
  asm("mul.f32 %0, %1, %2;" : "=f"(f89) : "f"(f47), "f"(f88));
  // PTX:199 mul.f32 %f90, %f49, %f81
  asm("mul.f32 %0, %1, %2;" : "=f"(f90) : "f"(f49), "f"(f81));
  // PTX:200 mul.f32 %f91, %f49, %f82
  asm("mul.f32 %0, %1, %2;" : "=f"(f91) : "f"(f49), "f"(f82));
  // PTX:201 mul.f32 %f92, %f49, %f83
  asm("mul.f32 %0, %1, %2;" : "=f"(f92) : "f"(f49), "f"(f83));
  // PTX:202 mul.f32 %f93, %f78, %f49
  asm("mul.f32 %0, %1, %2;" : "=f"(f93) : "f"(f78), "f"(f49));
  // PTX:203 mul.f32 %f94, %f79, %f49
  asm("mul.f32 %0, %1, %2;" : "=f"(f94) : "f"(f79), "f"(f49));
  // PTX:204 mul.f32 %f95, %f80, %f49
  asm("mul.f32 %0, %1, %2;" : "=f"(f95) : "f"(f80), "f"(f49));
  // PTX:205 fma.rn.f32 %f96, %f69, %f47, %f93
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f96) : "f"(f69), "f"(f47), "f"(f93));
  // PTX:206 fma.rn.f32 %f97, %f70, %f47, %f94
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f97) : "f"(f70), "f"(f47), "f"(f94));
  // PTX:207 fma.rn.f32 %f98, %f71, %f47, %f95
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f98) : "f"(f71), "f"(f47), "f"(f95));
  // PTX:208 mul.f32 %f99, %f1, %f84
  asm("mul.f32 %0, %1, %2;" : "=f"(f99) : "f"(f1), "f"(f84));
  // PTX:209 mul.f32 %f100, %f1, %f86
  asm("mul.f32 %0, %1, %2;" : "=f"(f100) : "f"(f1), "f"(f86));
  // PTX:210 mul.f32 %f101, %f1, %f88
  asm("mul.f32 %0, %1, %2;" : "=f"(f101) : "f"(f1), "f"(f88));
  // PTX:211 mul.f32 %f102, %f6, %f81
  asm("mul.f32 %0, %1, %2;" : "=f"(f102) : "f"(f6), "f"(f81));
  // PTX:212 mul.f32 %f103, %f6, %f82
  asm("mul.f32 %0, %1, %2;" : "=f"(f103) : "f"(f6), "f"(f82));
  // PTX:213 mul.f32 %f104, %f6, %f83
  asm("mul.f32 %0, %1, %2;" : "=f"(f104) : "f"(f6), "f"(f83));
  // PTX:214 mul.f32 %f105, %f78, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f105) : "f"(f78), "f"(f6));
  // PTX:215 mul.f32 %f106, %f79, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f106) : "f"(f79), "f"(f6));
  // PTX:216 mul.f32 %f107, %f80, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f107) : "f"(f80), "f"(f6));
  // PTX:217 fma.rn.f32 %f108, %f69, %f1, %f105
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f108) : "f"(f69), "f"(f1), "f"(f105));
  // PTX:218 fma.rn.f32 %f109, %f70, %f1, %f106
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f109) : "f"(f70), "f"(f1), "f"(f106));
  // PTX:219 fma.rn.f32 %f110, %f71, %f1, %f107
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f110) : "f"(f71), "f"(f1), "f"(f107));
  // PTX:220 mul.f32 %f111, %f2, %f84
  asm("mul.f32 %0, %1, %2;" : "=f"(f111) : "f"(f2), "f"(f84));
  // PTX:221 mul.f32 %f112, %f2, %f86
  asm("mul.f32 %0, %1, %2;" : "=f"(f112) : "f"(f2), "f"(f86));
  // PTX:222 mul.f32 %f113, %f2, %f88
  asm("mul.f32 %0, %1, %2;" : "=f"(f113) : "f"(f2), "f"(f88));
  // PTX:223 mul.f32 %f114, %f7, %f81
  asm("mul.f32 %0, %1, %2;" : "=f"(f114) : "f"(f7), "f"(f81));
  // PTX:224 mul.f32 %f115, %f7, %f82
  asm("mul.f32 %0, %1, %2;" : "=f"(f115) : "f"(f7), "f"(f82));
  // PTX:225 mul.f32 %f116, %f7, %f83
  asm("mul.f32 %0, %1, %2;" : "=f"(f116) : "f"(f7), "f"(f83));
  // PTX:226 mul.f32 %f117, %f78, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f117) : "f"(f78), "f"(f7));
  // PTX:227 mul.f32 %f118, %f79, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f118) : "f"(f79), "f"(f7));
  // PTX:228 mul.f32 %f119, %f80, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f119) : "f"(f80), "f"(f7));
  // PTX:229 fma.rn.f32 %f120, %f69, %f2, %f117
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f120) : "f"(f69), "f"(f2), "f"(f117));
  // PTX:230 fma.rn.f32 %f121, %f70, %f2, %f118
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f121) : "f"(f70), "f"(f2), "f"(f118));
  // PTX:231 fma.rn.f32 %f122, %f71, %f2, %f119
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f122) : "f"(f71), "f"(f2), "f"(f119));
  // PTX:232 cvta.to.global.u64 %rd40, %rd15
  rd40 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd15));
  // PTX:233 add.s64 %rd42, %rd40, %rd28
  asm("add.s64 %0, %1, %2;" : "=l"(rd42) : "l"(rd40), "l"(rd28));
  // PTX:234 ld.global.f32 %f123, [%rd42]
  f123 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (0)))));
  // PTX:235 add.f32 %f124, %f12, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f124) : "f"(f12));
  // PTX:236 mul.f32 %f125, %f123, %f124
  asm("mul.f32 %0, %1, %2;" : "=f"(f125) : "f"(f123), "f"(f124));
  // PTX:237 ld.global.f32 %f126, [%rd42+4]
  f126 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (4)))));
  // PTX:238 add.f32 %f127, %f14, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f127) : "f"(f14));
  // PTX:239 mul.f32 %f128, %f126, %f127
  asm("mul.f32 %0, %1, %2;" : "=f"(f128) : "f"(f126), "f"(f127));
  // PTX:240 ld.global.f32 %f129, [%rd42+8]
  f129 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (8)))));
  // PTX:241 mul.f32 %f130, %f129, %f62
  asm("mul.f32 %0, %1, %2;" : "=f"(f130) : "f"(f129), "f"(f62));
  // PTX:242 mul.f32 %f131, %f90, %f128
  asm("mul.f32 %0, %1, %2;" : "=f"(f131) : "f"(f90), "f"(f128));
  // PTX:243 mul.f32 %f132, %f128, %f91
  asm("mul.f32 %0, %1, %2;" : "=f"(f132) : "f"(f128), "f"(f91));
  // PTX:244 mul.f32 %f133, %f128, %f92
  asm("mul.f32 %0, %1, %2;" : "=f"(f133) : "f"(f128), "f"(f92));
  // PTX:245 fma.rn.f32 %f134, %f85, %f125, %f131
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f134) : "f"(f85), "f"(f125), "f"(f131));
  // PTX:246 fma.rn.f32 %f135, %f125, %f87, %f132
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f135) : "f"(f125), "f"(f87), "f"(f132));
  // PTX:247 fma.rn.f32 %f136, %f125, %f89, %f133
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f136) : "f"(f125), "f"(f89), "f"(f133));
  // PTX:248 fma.rn.f32 %f137, %f96, %f130, %f134
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f137) : "f"(f96), "f"(f130), "f"(f134));
  // PTX:249 fma.rn.f32 %f138, %f130, %f97, %f135
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f138) : "f"(f130), "f"(f97), "f"(f135));
  // PTX:250 fma.rn.f32 %f139, %f130, %f98, %f136
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f139) : "f"(f130), "f"(f98), "f"(f136));
  // PTX:251 cvta.to.global.u64 %rd43, %rd12
  rd43 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd12));
  // PTX:252 shl.b64 %rd44, %rd59, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd44) : "l"(rd59));
  // PTX:253 add.s64 %rd45, %rd43, %rd44
  asm("add.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd43), "l"(rd44));
  // PTX:254 ld.global.f32 %f140, [%rd45]
  f140 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))));
  // PTX:255 neg.f32 %f141, %f140
  asm("neg.f32 %0, %1;" : "=f"(f141) : "f"(f140));
  // PTX:256 mul.f32 %f142, %f137, %f141
  asm("mul.f32 %0, %1, %2;" : "=f"(f142) : "f"(f137), "f"(f141));
  // PTX:257 mul.f32 %f143, %f138, %f141
  asm("mul.f32 %0, %1, %2;" : "=f"(f143) : "f"(f138), "f"(f141));
  // PTX:258 mul.f32 %f144, %f139, %f141
  asm("mul.f32 %0, %1, %2;" : "=f"(f144) : "f"(f139), "f"(f141));
  // PTX:259 mul.lo.s64 %rd46, %rd9, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd46) : "l"(rd9));
  // PTX:260 add.s64 %rd47, %rd39, %rd46
  asm("add.s64 %0, %1, %2;" : "=l"(rd47) : "l"(rd39), "l"(rd46));
  // PTX:261 red.global.add.f32 [%rd47], %f142
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))), (float)(f142));
  // PTX:262 add.s64 %rd48, %rd47, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd48) : "l"(rd47));
  // PTX:263 red.global.add.f32 [%rd48], %f143
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))), (float)(f143));
  // PTX:264 add.s64 %rd49, %rd47, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd49) : "l"(rd47));
  // PTX:265 red.global.add.f32 [%rd49], %f144
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))), (float)(f144));
  // PTX:266 mul.f32 %f148, %f102, %f128
  asm("mul.f32 %0, %1, %2;" : "=f"(f148) : "f"(f102), "f"(f128));
  // PTX:267 mul.f32 %f149, %f128, %f103
  asm("mul.f32 %0, %1, %2;" : "=f"(f149) : "f"(f128), "f"(f103));
  // PTX:268 mul.f32 %f150, %f128, %f104
  asm("mul.f32 %0, %1, %2;" : "=f"(f150) : "f"(f128), "f"(f104));
  // PTX:269 fma.rn.f32 %f151, %f99, %f125, %f148
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f151) : "f"(f99), "f"(f125), "f"(f148));
  // PTX:270 fma.rn.f32 %f152, %f125, %f100, %f149
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f152) : "f"(f125), "f"(f100), "f"(f149));
  // PTX:271 fma.rn.f32 %f153, %f125, %f101, %f150
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f153) : "f"(f125), "f"(f101), "f"(f150));
  // PTX:272 fma.rn.f32 %f154, %f108, %f130, %f151
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f154) : "f"(f108), "f"(f130), "f"(f151));
  // PTX:273 fma.rn.f32 %f155, %f130, %f109, %f152
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f155) : "f"(f130), "f"(f109), "f"(f152));
  // PTX:274 fma.rn.f32 %f156, %f130, %f110, %f153
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f156) : "f"(f130), "f"(f110), "f"(f153));
  // PTX:275 ld.global.f32 %f157, [%rd45]
  f157 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))));
  // PTX:276 neg.f32 %f158, %f157
  asm("neg.f32 %0, %1;" : "=f"(f158) : "f"(f157));
  // PTX:277 mul.f32 %f159, %f154, %f158
  asm("mul.f32 %0, %1, %2;" : "=f"(f159) : "f"(f154), "f"(f158));
  // PTX:278 mul.f32 %f160, %f155, %f158
  asm("mul.f32 %0, %1, %2;" : "=f"(f160) : "f"(f155), "f"(f158));
  // PTX:279 mul.f32 %f161, %f156, %f158
  asm("mul.f32 %0, %1, %2;" : "=f"(f161) : "f"(f156), "f"(f158));
  // PTX:280 mul.lo.s64 %rd50, %rd8, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd50) : "l"(rd8));
  // PTX:281 add.s64 %rd51, %rd39, %rd50
  asm("add.s64 %0, %1, %2;" : "=l"(rd51) : "l"(rd39), "l"(rd50));
  // PTX:282 red.global.add.f32 [%rd51], %f159
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))), (float)(f159));
  // PTX:283 add.s64 %rd52, %rd51, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd52) : "l"(rd51));
  // PTX:284 red.global.add.f32 [%rd52], %f160
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))), (float)(f160));
  // PTX:285 add.s64 %rd53, %rd51, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd53) : "l"(rd51));
  // PTX:286 red.global.add.f32 [%rd53], %f161
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))), (float)(f161));
  // PTX:287 mul.f32 %f165, %f114, %f128
  asm("mul.f32 %0, %1, %2;" : "=f"(f165) : "f"(f114), "f"(f128));
  // PTX:288 mul.f32 %f166, %f128, %f115
  asm("mul.f32 %0, %1, %2;" : "=f"(f166) : "f"(f128), "f"(f115));
  // PTX:289 mul.f32 %f167, %f128, %f116
  asm("mul.f32 %0, %1, %2;" : "=f"(f167) : "f"(f128), "f"(f116));
  // PTX:290 fma.rn.f32 %f168, %f111, %f125, %f165
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f168) : "f"(f111), "f"(f125), "f"(f165));
  // PTX:291 fma.rn.f32 %f169, %f125, %f112, %f166
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f169) : "f"(f125), "f"(f112), "f"(f166));
  // PTX:292 fma.rn.f32 %f170, %f125, %f113, %f167
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f170) : "f"(f125), "f"(f113), "f"(f167));
  // PTX:293 fma.rn.f32 %f171, %f120, %f130, %f168
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f171) : "f"(f120), "f"(f130), "f"(f168));
  // PTX:294 fma.rn.f32 %f172, %f130, %f121, %f169
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f172) : "f"(f130), "f"(f121), "f"(f169));
  // PTX:295 fma.rn.f32 %f173, %f130, %f122, %f170
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f173) : "f"(f130), "f"(f122), "f"(f170));
  // PTX:296 ld.global.f32 %f174, [%rd45]
  f174 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))));
  // PTX:297 neg.f32 %f175, %f174
  asm("neg.f32 %0, %1;" : "=f"(f175) : "f"(f174));
  // PTX:298 mul.f32 %f176, %f171, %f175
  asm("mul.f32 %0, %1, %2;" : "=f"(f176) : "f"(f171), "f"(f175));
  // PTX:299 mul.f32 %f177, %f172, %f175
  asm("mul.f32 %0, %1, %2;" : "=f"(f177) : "f"(f172), "f"(f175));
  // PTX:300 mul.f32 %f178, %f173, %f175
  asm("mul.f32 %0, %1, %2;" : "=f"(f178) : "f"(f173), "f"(f175));
  // PTX:301 mul.lo.s64 %rd54, %rd10, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd54) : "l"(rd10));
  // PTX:302 add.s64 %rd55, %rd39, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd55) : "l"(rd39), "l"(rd54));
  // PTX:303 red.global.add.f32 [%rd55], %f176
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))), (float)(f176));
  // PTX:304 add.s64 %rd56, %rd55, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd56) : "l"(rd55));
  // PTX:305 red.global.add.f32 [%rd56], %f177
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))), (float)(f177));
  // PTX:306 add.s64 %rd57, %rd55, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd57) : "l"(rd55));
  // PTX:307 red.global.add.f32 [%rd57], %f178
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))), (float)(f178));
  // PTX:309 $L__BB45_9:
L_BB45_9:;
  // PTX:310 ret
  return;
}
