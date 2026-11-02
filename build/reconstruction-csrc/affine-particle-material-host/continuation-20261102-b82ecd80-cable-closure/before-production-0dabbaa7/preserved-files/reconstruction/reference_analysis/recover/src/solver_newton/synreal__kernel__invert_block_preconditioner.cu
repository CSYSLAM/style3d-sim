// 机械还原自 PTX：synreal::kernel::invert_block_preconditioner(glm::mat<3, 3, float, (glm::qualifier)0> const*, float const*, int const*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long)
// PTX SHA256: dd3756fe7f796add553d00cf333837bd9c5fbe30862b51c82f3e9cc18ae65b00
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__invert_block_preconditioner(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30;
  // PTX:22 ld.param.u64 %rd5, [_ZN7synreal6kernel27invert_block_preconditionerEPKN3glm3matILi3ELi3EfLNS1_9qualifierE0EEEPKfPKiPS4_mm_param_0]
  rd5 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:23 ld.param.u64 %rd6, [_ZN7synreal6kernel27invert_block_preconditionerEPKN3glm3matILi3ELi3EfLNS1_9qualifierE0EEEPKfPKiPS4_mm_param_1]
  rd6 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:24 ld.param.u64 %rd7, [_ZN7synreal6kernel27invert_block_preconditionerEPKN3glm3matILi3ELi3EfLNS1_9qualifierE0EEEPKfPKiPS4_mm_param_2]
  rd7 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:25 ld.param.u64 %rd8, [_ZN7synreal6kernel27invert_block_preconditionerEPKN3glm3matILi3ELi3EfLNS1_9qualifierE0EEEPKfPKiPS4_mm_param_3]
  rd8 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:26 ld.param.u64 %rd10, [_ZN7synreal6kernel27invert_block_preconditionerEPKN3glm3matILi3ELi3EfLNS1_9qualifierE0EEEPKfPKiPS4_mm_param_4]
  rd10 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:27 ld.param.u64 %rd9, [_ZN7synreal6kernel27invert_block_preconditionerEPKN3glm3matILi3ELi3EfLNS1_9qualifierE0EEEPKfPKiPS4_mm_param_5]
  rd9 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:28 mov.u32 %r34, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r34) : "r"(blockIdx.x));
  // PTX:29 mov.u32 %r35, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r35) : "r"(blockDim.x));
  // PTX:30 mul.wide.u32 %rd11, %r34, %r35
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd11) : "r"(r34), "r"(r35));
  // PTX:31 mov.u32 %r36, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r36) : "r"(threadIdx.x));
  // PTX:32 cvt.u64.u32 %rd12, %r36
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd12) : "r"(r36));
  // PTX:33 add.s64 %rd1, %rd11, %rd12
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd11), "l"(rd12));
  // PTX:34 setp.ge.u64 %p1, %rd1, %rd10
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd10)));
  // PTX:35 @%p1 bra $L__BB62_18
  if (p1) { goto L_BB62_18; }
  // PTX:37 or.b64 %rd13, %rd1, %rd9
  asm("or.b64 %0, %1, %2;" : "=l"(rd13) : "l"(rd1), "l"(rd9));
  // PTX:38 and.b64 %rd14, %rd13, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd14) : "l"(rd13));
  // PTX:39 setp.eq.s64 %p2, %rd14, 0
  p2 = (((long long)(rd14)) == ((long long)(0)));
  // PTX:40 @%p2 bra $L__BB62_3
  if (p2) { goto L_BB62_3; }
  // PTX:42 rem.u64 %rd30, %rd1, %rd9
  asm("rem.u64 %0, %1, %2;" : "=l"(rd30) : "l"(rd1), "l"(rd9));
  // PTX:43 bra.uni $L__BB62_4
  goto L_BB62_4;
  // PTX:45 $L__BB62_3:
L_BB62_3:;
  // PTX:46 cvt.u32.u64 %r37, %rd9
  asm("cvt.u32.u64 %0, %1;" : "=r"(r37) : "l"(rd9));
  // PTX:47 cvt.u32.u64 %r38, %rd1
  asm("cvt.u32.u64 %0, %1;" : "=r"(r38) : "l"(rd1));
  // PTX:48 rem.u32 %r39, %r38, %r37
  asm("rem.u32 %0, %1, %2;" : "=r"(r39) : "r"(r38), "r"(r37));
  // PTX:49 cvt.u64.u32 %rd30, %r39
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd30) : "r"(r39));
  // PTX:51 $L__BB62_4:
L_BB62_4:;
  // PTX:52 cvta.to.global.u64 %rd15, %rd6
  rd15 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd6));
  // PTX:53 shl.b64 %rd16, %rd30, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd16) : "l"(rd30));
  // PTX:54 add.s64 %rd17, %rd15, %rd16
  asm("add.s64 %0, %1, %2;" : "=l"(rd17) : "l"(rd15), "l"(rd16));
  // PTX:55 ld.global.f32 %f12, [%rd17]
  f12 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:56 setp.leu.f32 %p3, %f12, 0f00000000
  p3 = ((isnan(((float)(f12))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f12)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:57 mov.u32 %r69, 0
  asm("mov.u32 %0, 0;" : "=r"(r69) : );
  // PTX:58 mov.u32 %r70, %r69
  asm("mov.u32 %0, %1;" : "=r"(r70) : "r"(r69));
  // PTX:59 mov.u32 %r71, %r69
  asm("mov.u32 %0, %1;" : "=r"(r71) : "r"(r69));
  // PTX:60 mov.u32 %r72, %r69
  asm("mov.u32 %0, %1;" : "=r"(r72) : "r"(r69));
  // PTX:61 mov.u32 %r73, %r69
  asm("mov.u32 %0, %1;" : "=r"(r73) : "r"(r69));
  // PTX:62 mov.u32 %r74, %r69
  asm("mov.u32 %0, %1;" : "=r"(r74) : "r"(r69));
  // PTX:63 @%p3 bra $L__BB62_17
  if (p3) { goto L_BB62_17; }
  // PTX:65 setp.eq.s64 %p4, %rd7, 0
  p4 = (((long long)(rd7)) == ((long long)(0)));
  // PTX:66 @%p4 bra $L__BB62_7
  if (p4) { goto L_BB62_7; }
  // PTX:68 cvta.to.global.u64 %rd18, %rd7
  rd18 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd7));
  // PTX:69 add.s64 %rd20, %rd18, %rd16
  asm("add.s64 %0, %1, %2;" : "=l"(rd20) : "l"(rd18), "l"(rd16));
  // PTX:70 ld.global.u32 %r58, [%rd20]
  r58 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))));
  // PTX:71 and.b32 %r59, %r58, 1
  asm("and.b32 %0, %1, 1;" : "=r"(r59) : "r"(r58));
  // PTX:72 setp.eq.b32 %p5, %r59, 1
  p5 = (((unsigned)(r59)) == ((unsigned)(1)));
  // PTX:73 mov.pred %p6, 0
  p6 = ((0) != 0);
  // PTX:74 xor.pred %p7, %p5, %p6
  p7 = ((p5) != (p6));
  // PTX:75 not.pred %p8, %p7
  p8 = !(p7);
  // PTX:76 mov.u32 %r70, %r69
  asm("mov.u32 %0, %1;" : "=r"(r70) : "r"(r69));
  // PTX:77 mov.u32 %r71, %r69
  asm("mov.u32 %0, %1;" : "=r"(r71) : "r"(r69));
  // PTX:78 mov.u32 %r72, %r69
  asm("mov.u32 %0, %1;" : "=r"(r72) : "r"(r69));
  // PTX:79 mov.u32 %r73, %r69
  asm("mov.u32 %0, %1;" : "=r"(r73) : "r"(r69));
  // PTX:80 mov.u32 %r74, %r69
  asm("mov.u32 %0, %1;" : "=r"(r74) : "r"(r69));
  // PTX:81 @%p8 bra $L__BB62_17
  if (p8) { goto L_BB62_17; }
  // PTX:83 $L__BB62_7:
L_BB62_7:;
  // PTX:84 cvta.to.global.u64 %rd21, %rd5
  rd21 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd5));
  // PTX:85 mul.lo.s64 %rd22, %rd1, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd22) : "l"(rd1));
  // PTX:86 add.s64 %rd23, %rd21, %rd22
  asm("add.s64 %0, %1, %2;" : "=l"(rd23) : "l"(rd21), "l"(rd22));
  // PTX:87 ld.global.f32 %f13, [%rd23+12]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (12)))));
  // PTX:88 ld.global.f32 %f14, [%rd23+4]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (4)))));
  // PTX:89 add.f32 %f15, %f14, %f13
  asm("add.f32 %0, %1, %2;" : "=f"(f15) : "f"(f14), "f"(f13));
  // PTX:90 mul.f32 %f1, %f15, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1) : "f"(f15));
  // PTX:91 ld.global.f32 %f16, [%rd23+24]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (24)))));
  // PTX:92 ld.global.f32 %f17, [%rd23+8]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (8)))));
  // PTX:93 add.f32 %f18, %f17, %f16
  asm("add.f32 %0, %1, %2;" : "=f"(f18) : "f"(f17), "f"(f16));
  // PTX:94 mul.f32 %f2, %f18, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f2) : "f"(f18));
  // PTX:95 ld.global.f32 %f19, [%rd23+28]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (28)))));
  // PTX:96 ld.global.f32 %f20, [%rd23+20]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (20)))));
  // PTX:97 add.f32 %f21, %f20, %f19
  asm("add.f32 %0, %1, %2;" : "=f"(f21) : "f"(f20), "f"(f19));
  // PTX:98 mul.f32 %f3, %f21, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f3) : "f"(f21));
  // PTX:99 ld.global.f32 %f4, [%rd23+32]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (32)))));
  // PTX:100 ld.global.f32 %f5, [%rd23+16]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (16)))));
  // PTX:101 mul.f32 %f22, %f5, %f4
  asm("mul.f32 %0, %1, %2;" : "=f"(f22) : "f"(f5), "f"(f4));
  // PTX:102 mul.f32 %f23, %f3, %f3
  asm("mul.f32 %0, %1, %2;" : "=f"(f23) : "f"(f3), "f"(f3));
  // PTX:103 sub.f32 %f6, %f22, %f23
  asm("sub.f32 %0, %1, %2;" : "=f"(f6) : "f"(f22), "f"(f23));
  // PTX:104 mul.f32 %f24, %f2, %f3
  asm("mul.f32 %0, %1, %2;" : "=f"(f24) : "f"(f2), "f"(f3));
  // PTX:105 mul.f32 %f25, %f1, %f4
  asm("mul.f32 %0, %1, %2;" : "=f"(f25) : "f"(f1), "f"(f4));
  // PTX:106 sub.f32 %f7, %f24, %f25
  asm("sub.f32 %0, %1, %2;" : "=f"(f7) : "f"(f24), "f"(f25));
  // PTX:107 mul.f32 %f26, %f1, %f3
  asm("mul.f32 %0, %1, %2;" : "=f"(f26) : "f"(f1), "f"(f3));
  // PTX:108 mul.f32 %f27, %f5, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f27) : "f"(f5), "f"(f2));
  // PTX:109 sub.f32 %f8, %f26, %f27
  asm("sub.f32 %0, %1, %2;" : "=f"(f8) : "f"(f26), "f"(f27));
  // PTX:110 ld.global.f32 %f9, [%rd23]
  f9 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (0)))));
  // PTX:111 mul.f32 %f28, %f1, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f28) : "f"(f1), "f"(f7));
  // PTX:112 fma.rn.f32 %f29, %f9, %f6, %f28
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f29) : "f"(f9), "f"(f6), "f"(f28));
  // PTX:113 fma.rn.f32 %f10, %f2, %f8, %f29
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f10) : "f"(f2), "f"(f8), "f"(f29));
  // PTX:114 setp.leu.f32 %p9, %f10, 0f0DA24260
  p9 = ((isnan(((float)(f10))) || isnan(((float)(as_f32(0x0DA24260u))))) || (((float)(f10)) <= ((float)(as_f32(0x0DA24260u)))));
  // PTX:115 @%p9 bra $L__BB62_10
  if (p9) { goto L_BB62_10; }
  // PTX:117 abs.f32 %f30, %f10
  asm("abs.f32 %0, %1;" : "=f"(f30) : "f"(f10));
  // PTX:118 setp.geu.f32 %p10, %f30, 0f7F800000
  p10 = ((isnan(((float)(f30))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f30)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:119 mul.f32 %f31, %f9, %f3
  asm("mul.f32 %0, %1, %2;" : "=f"(f31) : "f"(f9), "f"(f3));
  // PTX:120 mul.f32 %f32, %f1, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f32) : "f"(f1), "f"(f2));
  // PTX:121 sub.f32 %f11, %f32, %f31
  asm("sub.f32 %0, %1, %2;" : "=f"(f11) : "f"(f32), "f"(f31));
  // PTX:122 @%p10 bra $L__BB62_10
  if (p10) { goto L_BB62_10; }
  // PTX:123 bra.uni $L__BB62_9
  goto L_BB62_9;
  // PTX:125 $L__BB62_10:
L_BB62_10:;
  // PTX:126 setp.leu.f32 %p11, %f9, 0f00000000
  p11 = ((isnan(((float)(f9))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f9)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:127 mov.u32 %r72, 0
  asm("mov.u32 %0, 0;" : "=r"(r72) : );
  // PTX:128 mov.u32 %r69, %r72
  asm("mov.u32 %0, %1;" : "=r"(r69) : "r"(r72));
  // PTX:129 @%p11 bra $L__BB62_12
  if (p11) { goto L_BB62_12; }
  // PTX:131 rcp.rn.f32 %f46, %f9
  asm("rcp.rn.f32 %0, %1;" : "=f"(f46) : "f"(f9));
  // PTX:132 mov.b32 %r69, %f46
  asm("mov.b32 %0, %1;" : "=r"(r69) : "f"(f46));
  // PTX:134 $L__BB62_12:
L_BB62_12:;
  // PTX:135 setp.leu.f32 %p12, %f5, 0f00000000
  p12 = ((isnan(((float)(f5))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f5)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:136 @%p12 bra $L__BB62_14
  if (p12) { goto L_BB62_14; }
  // PTX:138 rcp.rn.f32 %f47, %f5
  asm("rcp.rn.f32 %0, %1;" : "=f"(f47) : "f"(f5));
  // PTX:139 mov.b32 %r72, %f47
  asm("mov.b32 %0, %1;" : "=r"(r72) : "f"(f47));
  // PTX:141 $L__BB62_14:
L_BB62_14:;
  // PTX:142 setp.leu.f32 %p13, %f4, 0f00000000
  p13 = ((isnan(((float)(f4))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f4)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:143 mov.u32 %r70, 0
  asm("mov.u32 %0, 0;" : "=r"(r70) : );
  // PTX:144 mov.u32 %r74, %r70
  asm("mov.u32 %0, %1;" : "=r"(r74) : "r"(r70));
  // PTX:145 @%p13 bra $L__BB62_16
  if (p13) { goto L_BB62_16; }
  // PTX:147 rcp.rn.f32 %f48, %f4
  asm("rcp.rn.f32 %0, %1;" : "=f"(f48) : "f"(f4));
  // PTX:148 mov.b32 %r74, %f48
  asm("mov.b32 %0, %1;" : "=r"(r74) : "f"(f48));
  // PTX:150 $L__BB62_16:
L_BB62_16:;
  // PTX:151 mov.u32 %r71, %r70
  asm("mov.u32 %0, %1;" : "=r"(r71) : "r"(r70));
  // PTX:152 mov.u32 %r73, %r70
  asm("mov.u32 %0, %1;" : "=r"(r73) : "r"(r70));
  // PTX:153 bra.uni $L__BB62_17
  goto L_BB62_17;
  // PTX:155 $L__BB62_9:
L_BB62_9:;
  // PTX:156 rcp.rn.f32 %f33, %f10
  asm("rcp.rn.f32 %0, %1;" : "=f"(f33) : "f"(f10));
  // PTX:157 mul.f32 %f34, %f6, %f33
  asm("mul.f32 %0, %1, %2;" : "=f"(f34) : "f"(f6), "f"(f33));
  // PTX:158 mul.f32 %f35, %f7, %f33
  asm("mul.f32 %0, %1, %2;" : "=f"(f35) : "f"(f7), "f"(f33));
  // PTX:159 mul.f32 %f36, %f8, %f33
  asm("mul.f32 %0, %1, %2;" : "=f"(f36) : "f"(f8), "f"(f33));
  // PTX:160 mul.f32 %f37, %f9, %f4
  asm("mul.f32 %0, %1, %2;" : "=f"(f37) : "f"(f9), "f"(f4));
  // PTX:161 mul.f32 %f38, %f2, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f38) : "f"(f2), "f"(f2));
  // PTX:162 sub.f32 %f39, %f37, %f38
  asm("sub.f32 %0, %1, %2;" : "=f"(f39) : "f"(f37), "f"(f38));
  // PTX:163 mul.f32 %f40, %f39, %f33
  asm("mul.f32 %0, %1, %2;" : "=f"(f40) : "f"(f39), "f"(f33));
  // PTX:164 mul.f32 %f41, %f11, %f33
  asm("mul.f32 %0, %1, %2;" : "=f"(f41) : "f"(f11), "f"(f33));
  // PTX:165 mul.f32 %f42, %f9, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f42) : "f"(f9), "f"(f5));
  // PTX:166 mul.f32 %f43, %f1, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f43) : "f"(f1), "f"(f1));
  // PTX:167 sub.f32 %f44, %f42, %f43
  asm("sub.f32 %0, %1, %2;" : "=f"(f44) : "f"(f42), "f"(f43));
  // PTX:168 mul.f32 %f45, %f44, %f33
  asm("mul.f32 %0, %1, %2;" : "=f"(f45) : "f"(f44), "f"(f33));
  // PTX:169 mov.b32 %r73, %f41
  asm("mov.b32 %0, %1;" : "=r"(r73) : "f"(f41));
  // PTX:170 mov.b32 %r71, %f36
  asm("mov.b32 %0, %1;" : "=r"(r71) : "f"(f36));
  // PTX:171 mov.b32 %r70, %f35
  asm("mov.b32 %0, %1;" : "=r"(r70) : "f"(f35));
  // PTX:172 mov.b32 %r69, %f34
  asm("mov.b32 %0, %1;" : "=r"(r69) : "f"(f34));
  // PTX:173 mov.b32 %r74, %f45
  asm("mov.b32 %0, %1;" : "=r"(r74) : "f"(f45));
  // PTX:174 mov.b32 %r72, %f40
  asm("mov.b32 %0, %1;" : "=r"(r72) : "f"(f40));
  // PTX:176 $L__BB62_17:
L_BB62_17:;
  // PTX:177 cvta.to.global.u64 %rd27, %rd8
  rd27 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd8));
  // PTX:178 mul.lo.s64 %rd28, %rd1, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd28) : "l"(rd1));
  // PTX:179 add.s64 %rd29, %rd27, %rd28
  asm("add.s64 %0, %1, %2;" : "=l"(rd29) : "l"(rd27), "l"(rd28));
  // PTX:180 st.global.u32 [%rd29], %r69
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (0))))) = (unsigned)(r69);
  // PTX:181 st.global.u32 [%rd29+4], %r70
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (4))))) = (unsigned)(r70);
  // PTX:182 st.global.u32 [%rd29+8], %r71
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (8))))) = (unsigned)(r71);
  // PTX:183 st.global.u32 [%rd29+12], %r70
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (12))))) = (unsigned)(r70);
  // PTX:184 st.global.u32 [%rd29+16], %r72
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (16))))) = (unsigned)(r72);
  // PTX:185 st.global.u32 [%rd29+20], %r73
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (20))))) = (unsigned)(r73);
  // PTX:186 st.global.u32 [%rd29+24], %r71
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (24))))) = (unsigned)(r71);
  // PTX:187 st.global.u32 [%rd29+28], %r73
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (28))))) = (unsigned)(r73);
  // PTX:188 st.global.u32 [%rd29+32], %r74
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (32))))) = (unsigned)(r74);
  // PTX:190 $L__BB62_18:
L_BB62_18:;
  // PTX:191 ret
  return;
}
