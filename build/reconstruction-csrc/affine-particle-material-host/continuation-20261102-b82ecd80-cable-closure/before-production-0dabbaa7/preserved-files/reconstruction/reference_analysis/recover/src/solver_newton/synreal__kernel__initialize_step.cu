// 机械还原自 PTX：synreal::kernel::initialize_step(float, glm::vec<3, float, (glm::qualifier)0> const*, unsigned long, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, float const*, float const*, float, float const*, float, float const*, float, float const*, float, float const*, float, float const*, int const*, int const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, float*, unsigned long, unsigned long)
// PTX SHA256: 4ab805d7ee0f725c2ad0a809d06e89ff29287e7ee07b5d7069fc5ac4b0d06ab9
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__initialize_step(float param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, float param8, unsigned long long param9, float param10, unsigned long long param11, float param12, unsigned long long param13, float param14, unsigned long long param15, float param16, unsigned long long param17, unsigned long long param18, unsigned long long param19, unsigned long long param20, unsigned long long param21, unsigned long long param22, unsigned long long param23, unsigned long long param24) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77;
  // PTX:41 ld.param.f32 %f8, [_ZN7synreal6kernel15initialize_stepEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEEmPKiS6_PS4_PKfSB_fSB_fSB_fSB_fSB_fSB_S8_S8_S9_S9_Pfmm_param_0]
  f8 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (0))));
  // PTX:42 ld.param.u64 %rd14, [_ZN7synreal6kernel15initialize_stepEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEEmPKiS6_PS4_PKfSB_fSB_fSB_fSB_fSB_fSB_S8_S8_S9_S9_Pfmm_param_1]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:43 ld.param.u64 %rd15, [_ZN7synreal6kernel15initialize_stepEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEEmPKiS6_PS4_PKfSB_fSB_fSB_fSB_fSB_fSB_S8_S8_S9_S9_Pfmm_param_2]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:44 ld.param.u64 %rd16, [_ZN7synreal6kernel15initialize_stepEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEEmPKiS6_PS4_PKfSB_fSB_fSB_fSB_fSB_fSB_S8_S8_S9_S9_Pfmm_param_3]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:45 ld.param.u64 %rd17, [_ZN7synreal6kernel15initialize_stepEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEEmPKiS6_PS4_PKfSB_fSB_fSB_fSB_fSB_fSB_S8_S8_S9_S9_Pfmm_param_4]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:46 ld.param.u64 %rd18, [_ZN7synreal6kernel15initialize_stepEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEEmPKiS6_PS4_PKfSB_fSB_fSB_fSB_fSB_fSB_S8_S8_S9_S9_Pfmm_param_5]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:47 ld.param.u64 %rd19, [_ZN7synreal6kernel15initialize_stepEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEEmPKiS6_PS4_PKfSB_fSB_fSB_fSB_fSB_fSB_S8_S8_S9_S9_Pfmm_param_6]
  rd19 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:48 ld.param.u64 %rd20, [_ZN7synreal6kernel15initialize_stepEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEEmPKiS6_PS4_PKfSB_fSB_fSB_fSB_fSB_fSB_S8_S8_S9_S9_Pfmm_param_7]
  rd20 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:49 ld.param.f32 %f9, [_ZN7synreal6kernel15initialize_stepEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEEmPKiS6_PS4_PKfSB_fSB_fSB_fSB_fSB_fSB_S8_S8_S9_S9_Pfmm_param_8]
  f9 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param8 + (0))));
  // PTX:50 ld.param.u64 %rd21, [_ZN7synreal6kernel15initialize_stepEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEEmPKiS6_PS4_PKfSB_fSB_fSB_fSB_fSB_fSB_S8_S8_S9_S9_Pfmm_param_9]
  rd21 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:51 ld.param.f32 %f10, [_ZN7synreal6kernel15initialize_stepEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEEmPKiS6_PS4_PKfSB_fSB_fSB_fSB_fSB_fSB_S8_S8_S9_S9_Pfmm_param_10]
  f10 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param10 + (0))));
  // PTX:52 ld.param.u64 %rd22, [_ZN7synreal6kernel15initialize_stepEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEEmPKiS6_PS4_PKfSB_fSB_fSB_fSB_fSB_fSB_S8_S8_S9_S9_Pfmm_param_11]
  rd22 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:53 ld.param.f32 %f11, [_ZN7synreal6kernel15initialize_stepEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEEmPKiS6_PS4_PKfSB_fSB_fSB_fSB_fSB_fSB_S8_S8_S9_S9_Pfmm_param_12]
  f11 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param12 + (0))));
  // PTX:54 ld.param.u64 %rd23, [_ZN7synreal6kernel15initialize_stepEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEEmPKiS6_PS4_PKfSB_fSB_fSB_fSB_fSB_fSB_S8_S8_S9_S9_Pfmm_param_13]
  rd23 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:55 ld.param.f32 %f12, [_ZN7synreal6kernel15initialize_stepEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEEmPKiS6_PS4_PKfSB_fSB_fSB_fSB_fSB_fSB_S8_S8_S9_S9_Pfmm_param_14]
  f12 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param14 + (0))));
  // PTX:56 ld.param.u64 %rd24, [_ZN7synreal6kernel15initialize_stepEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEEmPKiS6_PS4_PKfSB_fSB_fSB_fSB_fSB_fSB_S8_S8_S9_S9_Pfmm_param_15]
  rd24 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param15 + (0))));
  // PTX:57 ld.param.f32 %f13, [_ZN7synreal6kernel15initialize_stepEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEEmPKiS6_PS4_PKfSB_fSB_fSB_fSB_fSB_fSB_S8_S8_S9_S9_Pfmm_param_16]
  f13 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param16 + (0))));
  // PTX:58 ld.param.u64 %rd25, [_ZN7synreal6kernel15initialize_stepEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEEmPKiS6_PS4_PKfSB_fSB_fSB_fSB_fSB_fSB_S8_S8_S9_S9_Pfmm_param_17]
  rd25 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param17 + (0))));
  // PTX:59 ld.param.u64 %rd26, [_ZN7synreal6kernel15initialize_stepEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEEmPKiS6_PS4_PKfSB_fSB_fSB_fSB_fSB_fSB_S8_S8_S9_S9_Pfmm_param_18]
  rd26 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param18 + (0))));
  // PTX:60 ld.param.u64 %rd27, [_ZN7synreal6kernel15initialize_stepEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEEmPKiS6_PS4_PKfSB_fSB_fSB_fSB_fSB_fSB_S8_S8_S9_S9_Pfmm_param_19]
  rd27 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param19 + (0))));
  // PTX:61 ld.param.u64 %rd28, [_ZN7synreal6kernel15initialize_stepEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEEmPKiS6_PS4_PKfSB_fSB_fSB_fSB_fSB_fSB_S8_S8_S9_S9_Pfmm_param_20]
  rd28 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param20 + (0))));
  // PTX:62 ld.param.u64 %rd29, [_ZN7synreal6kernel15initialize_stepEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEEmPKiS6_PS4_PKfSB_fSB_fSB_fSB_fSB_fSB_S8_S8_S9_S9_Pfmm_param_21]
  rd29 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param21 + (0))));
  // PTX:63 ld.param.u64 %rd31, [_ZN7synreal6kernel15initialize_stepEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEEmPKiS6_PS4_PKfSB_fSB_fSB_fSB_fSB_fSB_S8_S8_S9_S9_Pfmm_param_22]
  rd31 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param22 + (0))));
  // PTX:64 ld.param.u64 %rd32, [_ZN7synreal6kernel15initialize_stepEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEEmPKiS6_PS4_PKfSB_fSB_fSB_fSB_fSB_fSB_S8_S8_S9_S9_Pfmm_param_23]
  rd32 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param23 + (0))));
  // PTX:65 ld.param.u64 %rd30, [_ZN7synreal6kernel15initialize_stepEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEEmPKiS6_PS4_PKfSB_fSB_fSB_fSB_fSB_fSB_S8_S8_S9_S9_Pfmm_param_24]
  rd30 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param24 + (0))));
  // PTX:66 cvta.to.global.u64 %rd1, %rd31
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd31));
  // PTX:67 mov.u32 %r7, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r7) : "r"(blockIdx.x));
  // PTX:68 mov.u32 %r8, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r8) : "r"(blockDim.x));
  // PTX:69 mul.wide.u32 %rd33, %r7, %r8
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd33) : "r"(r7), "r"(r8));
  // PTX:70 mov.u32 %r9, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r9) : "r"(threadIdx.x));
  // PTX:71 cvt.u64.u32 %rd34, %r9
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd34) : "r"(r9));
  // PTX:72 add.s64 %rd2, %rd33, %rd34
  asm("add.s64 %0, %1, %2;" : "=l"(rd2) : "l"(rd33), "l"(rd34));
  // PTX:73 setp.ge.u64 %p3, %rd2, %rd32
  p3 = (((unsigned long long)(rd2)) >= ((unsigned long long)(rd32)));
  // PTX:74 @%p3 bra $L__BB11_24
  if (p3) { goto L_BB11_24; }
  // PTX:76 or.b64 %rd35, %rd2, %rd30
  asm("or.b64 %0, %1, %2;" : "=l"(rd35) : "l"(rd2), "l"(rd30));
  // PTX:77 and.b64 %rd36, %rd35, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd36) : "l"(rd35));
  // PTX:78 setp.eq.s64 %p4, %rd36, 0
  p4 = (((long long)(rd36)) == ((long long)(0)));
  // PTX:79 @%p4 bra $L__BB11_3
  if (p4) { goto L_BB11_3; }
  // PTX:81 rem.u64 %rd76, %rd2, %rd30
  asm("rem.u64 %0, %1, %2;" : "=l"(rd76) : "l"(rd2), "l"(rd30));
  // PTX:82 bra.uni $L__BB11_4
  goto L_BB11_4;
  // PTX:84 $L__BB11_3:
L_BB11_3:;
  // PTX:85 cvt.u32.u64 %r10, %rd30
  asm("cvt.u32.u64 %0, %1;" : "=r"(r10) : "l"(rd30));
  // PTX:86 cvt.u32.u64 %r11, %rd2
  asm("cvt.u32.u64 %0, %1;" : "=r"(r11) : "l"(rd2));
  // PTX:87 rem.u32 %r12, %r11, %r10
  asm("rem.u32 %0, %1, %2;" : "=r"(r12) : "r"(r11), "r"(r10));
  // PTX:88 cvt.u64.u32 %rd76, %r12
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd76) : "r"(r12));
  // PTX:90 $L__BB11_4:
L_BB11_4:;
  // PTX:91 cvta.to.global.u64 %rd37, %rd18
  rd37 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd18));
  // PTX:92 mul.lo.s64 %rd38, %rd2, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd38) : "l"(rd2));
  // PTX:93 add.s64 %rd6, %rd37, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd6) : "l"(rd37), "l"(rd38));
  // PTX:94 ld.global.u32 %r1, [%rd6]
  r1 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd6) + (0)))));
  // PTX:95 ld.global.u32 %r2, [%rd6+4]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd6) + (4)))));
  // PTX:96 ld.global.u32 %r3, [%rd6+8]
  r3 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd6) + (8)))));
  // PTX:97 cvta.to.global.u64 %rd39, %rd25
  rd39 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd25));
  // PTX:98 shl.b64 %rd40, %rd76, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd40) : "l"(rd76));
  // PTX:99 add.s64 %rd41, %rd39, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd41) : "l"(rd39), "l"(rd40));
  // PTX:100 ld.global.f32 %f1, [%rd41]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (0)))));
  // PTX:101 setp.gt.f32 %p5, %f1, 0f00000000
  p5 = (!(isnan(((float)(f1))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f1)) > ((float)(as_f32(0x00000000u)))));
  // PTX:102 cvta.to.global.u64 %rd42, %rd28
  rd42 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd28));
  // PTX:103 add.s64 %rd7, %rd42, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd7) : "l"(rd42), "l"(rd38));
  // PTX:104 cvta.to.global.u64 %rd43, %rd27
  rd43 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd27));
  // PTX:105 add.s64 %rd8, %rd43, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd8) : "l"(rd43), "l"(rd40));
  // PTX:106 cvta.to.global.u64 %rd44, %rd17
  rd44 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd17));
  // PTX:107 add.s64 %rd9, %rd44, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd9) : "l"(rd44), "l"(rd38));
  // PTX:108 cvta.to.global.u64 %rd45, %rd29
  rd45 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd29));
  // PTX:109 add.s64 %rd10, %rd45, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd10) : "l"(rd45), "l"(rd38));
  // PTX:110 @%p5 bra $L__BB11_6
  if (p5) { goto L_BB11_6; }
  // PTX:111 bra.uni $L__BB11_5
  goto L_BB11_5;
  // PTX:113 $L__BB11_6:
L_BB11_6:;
  // PTX:114 setp.eq.s64 %p6, %rd26, 0
  p6 = (((long long)(rd26)) == ((long long)(0)));
  // PTX:115 @%p6 bra $L__BB11_12
  if (p6) { goto L_BB11_12; }
  // PTX:117 cvta.to.global.u64 %rd46, %rd26
  rd46 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd26));
  // PTX:118 add.s64 %rd48, %rd46, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd48) : "l"(rd46), "l"(rd40));
  // PTX:119 ld.global.u32 %r13, [%rd48]
  r13 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))));
  // PTX:120 and.b32 %r14, %r13, 1
  asm("and.b32 %0, %1, 1;" : "=r"(r14) : "r"(r13));
  // PTX:121 setp.eq.b32 %p7, %r14, 1
  p7 = (((unsigned)(r14)) == ((unsigned)(1)));
  // PTX:122 mov.pred %p8, 0
  p8 = ((0) != 0);
  // PTX:123 xor.pred %p9, %p7, %p8
  p9 = ((p7) != (p8));
  // PTX:124 st.global.u32 [%rd7], %r1
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd7) + (0))))) = (unsigned)(r1);
  // PTX:125 st.global.u32 [%rd7+4], %r2
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd7) + (4))))) = (unsigned)(r2);
  // PTX:126 st.global.u32 [%rd7+8], %r3
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd7) + (8))))) = (unsigned)(r3);
  // PTX:127 @%p9 bra $L__BB11_13
  if (p9) { goto L_BB11_13; }
  // PTX:128 bra.uni $L__BB11_8
  goto L_BB11_8;
  // PTX:130 $L__BB11_5:
L_BB11_5:;
  // PTX:131 st.global.u32 [%rd7], %r1
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd7) + (0))))) = (unsigned)(r1);
  // PTX:132 st.global.u32 [%rd7+4], %r2
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd7) + (4))))) = (unsigned)(r2);
  // PTX:133 st.global.u32 [%rd7+8], %r3
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd7) + (8))))) = (unsigned)(r3);
  // PTX:135 $L__BB11_8:
L_BB11_8:;
  // PTX:136 setp.eq.s64 %p10, %rd27, 0
  p10 = (((long long)(rd27)) == ((long long)(0)));
  // PTX:137 @%p10 bra $L__BB11_11
  if (p10) { goto L_BB11_11; }
  // PTX:139 ld.global.u32 %r15, [%rd8]
  r15 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (0)))));
  // PTX:140 setp.eq.s32 %p11, %r15, 0
  p11 = (((int)(r15)) == ((int)(0)));
  // PTX:141 @%p11 bra $L__BB11_11
  if (p11) { goto L_BB11_11; }
  // PTX:143 ld.global.f32 %f14, [%rd9]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (0)))));
  // PTX:144 mul.f32 %f15, %f14, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f15) : "f"(f14), "f"(f8));
  // PTX:145 ld.global.f32 %f16, [%rd9+4]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (4)))));
  // PTX:146 mul.f32 %f17, %f16, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f17) : "f"(f16), "f"(f8));
  // PTX:147 ld.global.f32 %f18, [%rd9+8]
  f18 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (8)))));
  // PTX:148 mul.f32 %f19, %f18, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f19) : "f"(f18), "f"(f8));
  // PTX:149 mov.b32 %f20, %r1
  asm("mov.b32 %0, %1;" : "=f"(f20) : "r"(r1));
  // PTX:150 sub.f32 %f21, %f20, %f15
  asm("sub.f32 %0, %1, %2;" : "=f"(f21) : "f"(f20), "f"(f15));
  // PTX:151 mov.b32 %f22, %r2
  asm("mov.b32 %0, %1;" : "=f"(f22) : "r"(r2));
  // PTX:152 sub.f32 %f23, %f22, %f17
  asm("sub.f32 %0, %1, %2;" : "=f"(f23) : "f"(f22), "f"(f17));
  // PTX:153 mov.b32 %f24, %r3
  asm("mov.b32 %0, %1;" : "=f"(f24) : "r"(r3));
  // PTX:154 sub.f32 %f25, %f24, %f19
  asm("sub.f32 %0, %1, %2;" : "=f"(f25) : "f"(f24), "f"(f19));
  // PTX:155 st.global.f32 [%rd7], %f21
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd7) + (0))))) = (float)(f21);
  // PTX:156 st.global.f32 [%rd7+4], %f23
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd7) + (4))))) = (float)(f23);
  // PTX:157 st.global.f32 [%rd7+8], %f25
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd7) + (8))))) = (float)(f25);
  // PTX:159 $L__BB11_11:
L_BB11_11:;
  // PTX:160 st.global.u32 [%rd10], %r1
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (0))))) = (unsigned)(r1);
  // PTX:161 st.global.u32 [%rd10+4], %r2
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (4))))) = (unsigned)(r2);
  // PTX:162 st.global.u32 [%rd10+8], %r3
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (8))))) = (unsigned)(r3);
  // PTX:163 shl.b64 %rd49, %rd2, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd49) : "l"(rd2));
  // PTX:164 add.s64 %rd50, %rd1, %rd49
  asm("add.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd1), "l"(rd49));
  // PTX:165 mov.u32 %r16, 0
  asm("mov.u32 %0, 0;" : "=r"(r16) : );
  // PTX:166 st.global.u32 [%rd50], %r16
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (0))))) = (unsigned)(r16);
  // PTX:167 bra.uni $L__BB11_24
  goto L_BB11_24;
  // PTX:169 $L__BB11_12:
L_BB11_12:;
  // PTX:170 st.global.u32 [%rd7], %r1
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd7) + (0))))) = (unsigned)(r1);
  // PTX:171 st.global.u32 [%rd7+4], %r2
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd7) + (4))))) = (unsigned)(r2);
  // PTX:172 st.global.u32 [%rd7+8], %r3
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd7) + (8))))) = (unsigned)(r3);
  // PTX:174 $L__BB11_13:
L_BB11_13:;
  // PTX:175 setp.eq.s64 %p12, %rd16, 0
  p12 = (((long long)(rd16)) == ((long long)(0)));
  // PTX:176 @%p12 bra $L__BB11_15
  if (p12) { goto L_BB11_15; }
  // PTX:178 cvta.to.global.u64 %rd51, %rd16
  rd51 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd16));
  // PTX:179 add.s64 %rd53, %rd51, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd53) : "l"(rd51), "l"(rd40));
  // PTX:180 ld.global.u32 %r25, [%rd53]
  r25 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))));
  // PTX:181 bra.uni $L__BB11_19
  goto L_BB11_19;
  // PTX:183 $L__BB11_15:
L_BB11_15:;
  // PTX:184 @%p4 bra $L__BB11_17
  if (p4) { goto L_BB11_17; }
  // PTX:186 div.u64 %rd77, %rd2, %rd30
  asm("div.u64 %0, %1, %2;" : "=l"(rd77) : "l"(rd2), "l"(rd30));
  // PTX:187 bra.uni $L__BB11_18
  goto L_BB11_18;
  // PTX:189 $L__BB11_17:
L_BB11_17:;
  // PTX:190 cvt.u32.u64 %r17, %rd30
  asm("cvt.u32.u64 %0, %1;" : "=r"(r17) : "l"(rd30));
  // PTX:191 cvt.u32.u64 %r18, %rd2
  asm("cvt.u32.u64 %0, %1;" : "=r"(r18) : "l"(rd2));
  // PTX:192 div.u32 %r19, %r18, %r17
  asm("div.u32 %0, %1, %2;" : "=r"(r19) : "r"(r18), "r"(r17));
  // PTX:193 cvt.u64.u32 %rd77, %r19
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd77) : "r"(r19));
  // PTX:195 $L__BB11_18:
L_BB11_18:;
  // PTX:196 cvt.u32.u64 %r25, %rd77
  asm("cvt.u32.u64 %0, %1;" : "=r"(r25) : "l"(rd77));
  // PTX:198 $L__BB11_19:
L_BB11_19:;
  // PTX:199 setp.eq.s64 %p15, %rd27, 0
  p15 = (((long long)(rd27)) == ((long long)(0)));
  // PTX:200 mov.pred %p19, 0
  p19 = ((0) != 0);
  // PTX:201 @%p15 bra $L__BB11_21
  if (p15) { goto L_BB11_21; }
  // PTX:203 ld.global.u32 %r20, [%rd8]
  r20 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (0)))));
  // PTX:204 setp.eq.s32 %p19, %r20, 2
  p19 = (((int)(r20)) == ((int)(2)));
  // PTX:206 $L__BB11_21:
L_BB11_21:;
  // PTX:207 setp.eq.s64 %p16, %rd15, 0
  p16 = (((long long)(rd15)) == ((long long)(0)));
  // PTX:208 or.pred %p17, %p16, %p19
  p17 = ((p16) || (p19));
  // PTX:209 mov.f32 %f55, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f55) : );
  // PTX:210 mov.f32 %f56, %f55
  asm("mov.f32 %0, %1;" : "=f"(f56) : "f"(f55));
  // PTX:211 mov.f32 %f57, %f55
  asm("mov.f32 %0, %1;" : "=f"(f57) : "f"(f55));
  // PTX:212 @%p17 bra $L__BB11_23
  if (p17) { goto L_BB11_23; }
  // PTX:214 max.s32 %r21, %r25, 0
  asm("max.s32 %0, %1, 0;" : "=r"(r21) : "r"(r25));
  // PTX:215 cvt.u32.u64 %r22, %rd15
  asm("cvt.u32.u64 %0, %1;" : "=r"(r22) : "l"(rd15));
  // PTX:216 add.s32 %r23, %r22, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r23) : "r"(r22));
  // PTX:217 min.s32 %r24, %r21, %r23
  asm("min.s32 %0, %1, %2;" : "=r"(r24) : "r"(r21), "r"(r23));
  // PTX:218 cvt.s64.s32 %rd56, %r24
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd56) : "r"(r24));
  // PTX:219 selp.b64 %rd57, 0, %rd56, %p16
  rd57 = p16 ? 0 : rd56;
  // PTX:220 cvta.to.global.u64 %rd58, %rd14
  rd58 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd14));
  // PTX:221 mul.lo.s64 %rd59, %rd57, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd59) : "l"(rd57));
  // PTX:222 add.s64 %rd60, %rd58, %rd59
  asm("add.s64 %0, %1, %2;" : "=l"(rd60) : "l"(rd58), "l"(rd59));
  // PTX:223 ld.global.f32 %f55, [%rd60]
  f55 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))));
  // PTX:224 ld.global.f32 %f56, [%rd60+4]
  f56 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (4)))));
  // PTX:225 ld.global.f32 %f57, [%rd60+8]
  f57 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (8)))));
  // PTX:227 $L__BB11_23:
L_BB11_23:;
  // PTX:228 ld.global.f32 %f29, [%rd9]
  f29 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (0)))));
  // PTX:229 ld.global.f32 %f30, [%rd9+4]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (4)))));
  // PTX:230 ld.global.f32 %f31, [%rd9+8]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (8)))));
  // PTX:231 cvta.to.global.u64 %rd61, %rd20
  rd61 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd20));
  // PTX:232 add.s64 %rd63, %rd61, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd63) : "l"(rd61), "l"(rd40));
  // PTX:233 ld.global.f32 %f32, [%rd63]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (0)))));
  // PTX:234 fma.rn.f32 %f33, %f32, %f9, %f1
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f33) : "f"(f32), "f"(f9), "f"(f1));
  // PTX:235 cvta.to.global.u64 %rd64, %rd21
  rd64 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd21));
  // PTX:236 add.s64 %rd65, %rd64, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd65) : "l"(rd64), "l"(rd40));
  // PTX:237 ld.global.f32 %f34, [%rd65]
  f34 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (0)))));
  // PTX:238 fma.rn.f32 %f35, %f34, %f10, %f33
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f35) : "f"(f34), "f"(f10), "f"(f33));
  // PTX:239 cvta.to.global.u64 %rd66, %rd22
  rd66 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd22));
  // PTX:240 add.s64 %rd67, %rd66, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd67) : "l"(rd66), "l"(rd40));
  // PTX:241 ld.global.f32 %f36, [%rd67]
  f36 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0)))));
  // PTX:242 fma.rn.f32 %f37, %f36, %f11, %f35
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f37) : "f"(f36), "f"(f11), "f"(f35));
  // PTX:243 cvta.to.global.u64 %rd68, %rd23
  rd68 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd23));
  // PTX:244 add.s64 %rd69, %rd68, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd69) : "l"(rd68), "l"(rd40));
  // PTX:245 ld.global.f32 %f38, [%rd69]
  f38 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (0)))));
  // PTX:246 fma.rn.f32 %f39, %f38, %f12, %f37
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f39) : "f"(f38), "f"(f12), "f"(f37));
  // PTX:247 cvta.to.global.u64 %rd70, %rd24
  rd70 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd24));
  // PTX:248 add.s64 %rd71, %rd70, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd71) : "l"(rd70), "l"(rd40));
  // PTX:249 ld.global.f32 %f40, [%rd71]
  f40 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))));
  // PTX:250 fma.rn.f32 %f41, %f40, %f13, %f39
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f41) : "f"(f40), "f"(f13), "f"(f39));
  // PTX:251 mul.f32 %f42, %f8, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f42) : "f"(f8), "f"(f8));
  // PTX:252 div.rn.f32 %f43, %f41, %f42
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f43) : "f"(f41), "f"(f42));
  // PTX:253 cvta.to.global.u64 %rd72, %rd19
  rd72 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd19));
  // PTX:254 add.s64 %rd73, %rd72, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd73) : "l"(rd72), "l"(rd40));
  // PTX:255 ld.global.f32 %f44, [%rd73]
  f44 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (0)))));
  // PTX:256 add.f32 %f45, %f44, %f43
  asm("add.f32 %0, %1, %2;" : "=f"(f45) : "f"(f44), "f"(f43));
  // PTX:257 shl.b64 %rd74, %rd2, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd74) : "l"(rd2));
  // PTX:258 add.s64 %rd75, %rd1, %rd74
  asm("add.s64 %0, %1, %2;" : "=l"(rd75) : "l"(rd1), "l"(rd74));
  // PTX:259 st.global.f32 [%rd75], %f45
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (0))))) = (float)(f45);
  // PTX:260 mov.b32 %f46, %r1
  asm("mov.b32 %0, %1;" : "=f"(f46) : "r"(r1));
  // PTX:261 fma.rn.f32 %f47, %f29, %f8, %f46
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f47) : "f"(f29), "f"(f8), "f"(f46));
  // PTX:262 mov.b32 %f48, %r2
  asm("mov.b32 %0, %1;" : "=f"(f48) : "r"(r2));
  // PTX:263 fma.rn.f32 %f49, %f30, %f8, %f48
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f49) : "f"(f30), "f"(f8), "f"(f48));
  // PTX:264 mov.b32 %f50, %r3
  asm("mov.b32 %0, %1;" : "=f"(f50) : "r"(r3));
  // PTX:265 fma.rn.f32 %f51, %f31, %f8, %f50
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f51) : "f"(f31), "f"(f8), "f"(f50));
  // PTX:266 fma.rn.f32 %f52, %f42, %f55, %f47
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f52) : "f"(f42), "f"(f55), "f"(f47));
  // PTX:267 fma.rn.f32 %f53, %f42, %f56, %f49
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f53) : "f"(f42), "f"(f56), "f"(f49));
  // PTX:268 fma.rn.f32 %f54, %f42, %f57, %f51
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f54) : "f"(f42), "f"(f57), "f"(f51));
  // PTX:269 st.global.f32 [%rd10], %f52
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (0))))) = (float)(f52);
  // PTX:270 st.global.f32 [%rd10+4], %f53
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (4))))) = (float)(f53);
  // PTX:271 st.global.f32 [%rd10+8], %f54
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (8))))) = (float)(f54);
  // PTX:272 st.global.f32 [%rd6], %f52
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd6) + (0))))) = (float)(f52);
  // PTX:273 st.global.f32 [%rd6+4], %f53
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd6) + (4))))) = (float)(f53);
  // PTX:274 st.global.f32 [%rd6+8], %f54
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd6) + (8))))) = (float)(f54);
  // PTX:276 $L__BB11_24:
L_BB11_24:;
  // PTX:277 ret
  return;
}
