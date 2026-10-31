// 机械还原自 PTX：synreal::kernel::generate_morton_codes(unsigned int*, synreal::Aabb const*, synreal::Aabb, unsigned int)
// PTX SHA256: 0b9e69a594fced68260cd5f5b80018a6c6f049439101ff4569345153e3132ffd
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__generate_morton_codes(unsigned long long param0, unsigned long long param1, ByVal<24, 4> param2, unsigned param3) {
  int p0, p1, p2, p3, p4;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9;
  // PTX:20 ld.param.u64 %rd2, [_ZN7synreal6kernel21generate_morton_codesEPjPKNS_4AabbES2_j_param_0]
  rd2 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:21 ld.param.u64 %rd3, [_ZN7synreal6kernel21generate_morton_codesEPjPKNS_4AabbES2_j_param_1]
  rd3 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:22 ld.param.u32 %r8, [_ZN7synreal6kernel21generate_morton_codesEPjPKNS_4AabbES2_j_param_3]
  r8 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param3 + (0))));
  // PTX:23 ld.param.u32 %r7, [_ZN7synreal6kernel21generate_morton_codesEPjPKNS_4AabbES2_j_param_2+20]
  r7 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param2 + (20))));
  // PTX:24 ld.param.u32 %r6, [_ZN7synreal6kernel21generate_morton_codesEPjPKNS_4AabbES2_j_param_2+16]
  r6 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param2 + (16))));
  // PTX:25 ld.param.u32 %r5, [_ZN7synreal6kernel21generate_morton_codesEPjPKNS_4AabbES2_j_param_2+12]
  r5 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param2 + (12))));
  // PTX:26 ld.param.u32 %r4, [_ZN7synreal6kernel21generate_morton_codesEPjPKNS_4AabbES2_j_param_2+8]
  r4 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param2 + (8))));
  // PTX:27 ld.param.u32 %r3, [_ZN7synreal6kernel21generate_morton_codesEPjPKNS_4AabbES2_j_param_2+4]
  r3 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param2 + (4))));
  // PTX:28 ld.param.u32 %r2, [_ZN7synreal6kernel21generate_morton_codesEPjPKNS_4AabbES2_j_param_2]
  r2 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param2 + (0))));
  // PTX:29 mov.u32 %r9, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r9) : "r"(blockDim.x));
  // PTX:30 mov.u32 %r10, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r10) : "r"(blockIdx.x));
  // PTX:31 mov.u32 %r11, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r11) : "r"(threadIdx.x));
  // PTX:32 mad.lo.s32 %r1, %r10, %r9, %r11
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r1) : "r"(r10), "r"(r9), "r"(r11));
  // PTX:33 setp.ge.u32 %p1, %r1, %r8
  p1 = (((unsigned)(r1)) >= ((unsigned)(r8)));
  // PTX:34 @%p1 bra $L__BB0_8
  if (p1) { goto L_BB0_8; }
  // PTX:36 cvt.u64.u32 %rd1, %r1
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd1) : "r"(r1));
  // PTX:37 cvta.to.global.u64 %rd4, %rd3
  rd4 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd3));
  // PTX:38 mul.wide.u32 %rd5, %r1, 24
  asm("mul.wide.u32 %0, %1, 24;" : "=l"(rd5) : "r"(r1));
  // PTX:39 add.s64 %rd6, %rd4, %rd5
  asm("add.s64 %0, %1, %2;" : "=l"(rd6) : "l"(rd4), "l"(rd5));
  // PTX:40 ld.global.f32 %f17, [%rd6+12]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd6) + (12)))));
  // PTX:41 ld.global.f32 %f18, [%rd6]
  f18 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd6) + (0)))));
  // PTX:42 add.f32 %f1, %f18, %f17
  asm("add.f32 %0, %1, %2;" : "=f"(f1) : "f"(f18), "f"(f17));
  // PTX:43 ld.global.f32 %f19, [%rd6+16]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd6) + (16)))));
  // PTX:44 ld.global.f32 %f20, [%rd6+4]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd6) + (4)))));
  // PTX:45 add.f32 %f21, %f20, %f19
  asm("add.f32 %0, %1, %2;" : "=f"(f21) : "f"(f20), "f"(f19));
  // PTX:46 mul.f32 %f2, %f21, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f2) : "f"(f21));
  // PTX:47 mov.f32 %f46, 0f3F000000
  asm("mov.f32 %0, 0f3F000000;" : "=f"(f46) : );
  // PTX:48 ld.global.f32 %f22, [%rd6+20]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd6) + (20)))));
  // PTX:49 ld.global.f32 %f23, [%rd6+8]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd6) + (8)))));
  // PTX:50 add.f32 %f3, %f23, %f22
  asm("add.f32 %0, %1, %2;" : "=f"(f3) : "f"(f23), "f"(f22));
  // PTX:51 mov.b32 %f24, %r5
  asm("mov.b32 %0, %1;" : "=f"(f24) : "r"(r5));
  // PTX:52 mov.b32 %f4, %r2
  asm("mov.b32 %0, %1;" : "=f"(f4) : "r"(r2));
  // PTX:53 sub.f32 %f5, %f24, %f4
  asm("sub.f32 %0, %1, %2;" : "=f"(f5) : "f"(f24), "f"(f4));
  // PTX:54 mov.b32 %f25, %r6
  asm("mov.b32 %0, %1;" : "=f"(f25) : "r"(r6));
  // PTX:55 mov.b32 %f6, %r3
  asm("mov.b32 %0, %1;" : "=f"(f6) : "r"(r3));
  // PTX:56 sub.f32 %f7, %f25, %f6
  asm("sub.f32 %0, %1, %2;" : "=f"(f7) : "f"(f25), "f"(f6));
  // PTX:57 mov.b32 %f26, %r7
  asm("mov.b32 %0, %1;" : "=f"(f26) : "r"(r7));
  // PTX:58 mov.b32 %f8, %r4
  asm("mov.b32 %0, %1;" : "=f"(f8) : "r"(r4));
  // PTX:59 sub.f32 %f9, %f26, %f8
  asm("sub.f32 %0, %1, %2;" : "=f"(f9) : "f"(f26), "f"(f8));
  // PTX:60 setp.leu.f32 %p2, %f5, 0f00000000
  p2 = ((isnan(((float)(f5))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f5)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:61 mov.f32 %f45, %f46
  asm("mov.f32 %0, %1;" : "=f"(f45) : "f"(f46));
  // PTX:62 @%p2 bra $L__BB0_3
  if (p2) { goto L_BB0_3; }
  // PTX:64 mul.f32 %f27, %f1, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f27) : "f"(f1));
  // PTX:65 sub.f32 %f28, %f27, %f4
  asm("sub.f32 %0, %1, %2;" : "=f"(f28) : "f"(f27), "f"(f4));
  // PTX:66 div.rn.f32 %f45, %f28, %f5
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f45) : "f"(f28), "f"(f5));
  // PTX:68 $L__BB0_3:
L_BB0_3:;
  // PTX:69 setp.leu.f32 %p3, %f7, 0f00000000
  p3 = ((isnan(((float)(f7))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f7)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:70 @%p3 bra $L__BB0_5
  if (p3) { goto L_BB0_5; }
  // PTX:72 sub.f32 %f30, %f2, %f6
  asm("sub.f32 %0, %1, %2;" : "=f"(f30) : "f"(f2), "f"(f6));
  // PTX:73 div.rn.f32 %f46, %f30, %f7
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f46) : "f"(f30), "f"(f7));
  // PTX:75 $L__BB0_5:
L_BB0_5:;
  // PTX:76 setp.leu.f32 %p4, %f9, 0f00000000
  p4 = ((isnan(((float)(f9))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f9)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:77 mov.f32 %f47, 0f3F000000
  asm("mov.f32 %0, 0f3F000000;" : "=f"(f47) : );
  // PTX:78 @%p4 bra $L__BB0_7
  if (p4) { goto L_BB0_7; }
  // PTX:80 mul.f32 %f32, %f3, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f32) : "f"(f3));
  // PTX:81 sub.f32 %f33, %f32, %f8
  asm("sub.f32 %0, %1, %2;" : "=f"(f33) : "f"(f32), "f"(f8));
  // PTX:82 div.rn.f32 %f47, %f33, %f9
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f47) : "f"(f33), "f"(f9));
  // PTX:84 $L__BB0_7:
L_BB0_7:;
  // PTX:85 mov.f32 %f34, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f34) : );
  // PTX:86 max.f32 %f35, %f45, %f34
  asm("max.f32 %0, %1, %2;" : "=f"(f35) : "f"(f45), "f"(f34));
  // PTX:87 mov.f32 %f36, 0f3F7FFFFF
  asm("mov.f32 %0, 0f3F7FFFFF;" : "=f"(f36) : );
  // PTX:88 min.f32 %f37, %f35, %f36
  asm("min.f32 %0, %1, %2;" : "=f"(f37) : "f"(f35), "f"(f36));
  // PTX:89 mul.f32 %f38, %f37, 0f44800000
  asm("mul.f32 %0, %1, 0f44800000;" : "=f"(f38) : "f"(f37));
  // PTX:90 cvt.rzi.u32.f32 %r12, %f38
  asm("cvt.rzi.u32.f32 %0, %1;" : "=r"(r12) : "f"(f38));
  // PTX:91 mul.lo.s32 %r13, %r12, 65537
  asm("mul.lo.s32 %0, %1, 65537;" : "=r"(r13) : "r"(r12));
  // PTX:92 and.b32 %r14, %r13, 50331903
  asm("and.b32 %0, %1, 50331903;" : "=r"(r14) : "r"(r13));
  // PTX:93 mul.lo.s32 %r15, %r14, 257
  asm("mul.lo.s32 %0, %1, 257;" : "=r"(r15) : "r"(r14));
  // PTX:94 and.b32 %r16, %r15, 50393103
  asm("and.b32 %0, %1, 50393103;" : "=r"(r16) : "r"(r15));
  // PTX:95 mul.lo.s32 %r17, %r16, 17
  asm("mul.lo.s32 %0, %1, 17;" : "=r"(r17) : "r"(r16));
  // PTX:96 and.b32 %r18, %r17, 51130563
  asm("and.b32 %0, %1, 51130563;" : "=r"(r18) : "r"(r17));
  // PTX:97 max.f32 %f39, %f46, %f34
  asm("max.f32 %0, %1, %2;" : "=f"(f39) : "f"(f46), "f"(f34));
  // PTX:98 min.f32 %f40, %f39, %f36
  asm("min.f32 %0, %1, %2;" : "=f"(f40) : "f"(f39), "f"(f36));
  // PTX:99 mul.f32 %f41, %f40, 0f44800000
  asm("mul.f32 %0, %1, 0f44800000;" : "=f"(f41) : "f"(f40));
  // PTX:100 cvt.rzi.u32.f32 %r19, %f41
  asm("cvt.rzi.u32.f32 %0, %1;" : "=r"(r19) : "f"(f41));
  // PTX:101 mul.lo.s32 %r20, %r19, 65537
  asm("mul.lo.s32 %0, %1, 65537;" : "=r"(r20) : "r"(r19));
  // PTX:102 and.b32 %r21, %r20, 251658495
  asm("and.b32 %0, %1, 251658495;" : "=r"(r21) : "r"(r20));
  // PTX:103 mul.lo.s32 %r22, %r21, 257
  asm("mul.lo.s32 %0, %1, 257;" : "=r"(r22) : "r"(r21));
  // PTX:104 and.b32 %r23, %r22, 251719695
  asm("and.b32 %0, %1, 251719695;" : "=r"(r23) : "r"(r22));
  // PTX:105 mul.lo.s32 %r24, %r23, 17
  asm("mul.lo.s32 %0, %1, 17;" : "=r"(r24) : "r"(r23));
  // PTX:106 and.b32 %r25, %r24, 1124872387
  asm("and.b32 %0, %1, 1124872387;" : "=r"(r25) : "r"(r24));
  // PTX:107 max.f32 %f42, %f47, %f34
  asm("max.f32 %0, %1, %2;" : "=f"(f42) : "f"(f47), "f"(f34));
  // PTX:108 min.f32 %f43, %f42, %f36
  asm("min.f32 %0, %1, %2;" : "=f"(f43) : "f"(f42), "f"(f36));
  // PTX:109 mul.f32 %f44, %f43, 0f44800000
  asm("mul.f32 %0, %1, 0f44800000;" : "=f"(f44) : "f"(f43));
  // PTX:110 cvt.rzi.u32.f32 %r26, %f44
  asm("cvt.rzi.u32.f32 %0, %1;" : "=r"(r26) : "f"(f44));
  // PTX:111 mul.lo.s32 %r27, %r26, 65537
  asm("mul.lo.s32 %0, %1, 65537;" : "=r"(r27) : "r"(r26));
  // PTX:112 and.b32 %r28, %r27, 251658495
  asm("and.b32 %0, %1, 251658495;" : "=r"(r28) : "r"(r27));
  // PTX:113 mul.lo.s32 %r29, %r28, 257
  asm("mul.lo.s32 %0, %1, 257;" : "=r"(r29) : "r"(r28));
  // PTX:114 and.b32 %r30, %r29, 251719695
  asm("and.b32 %0, %1, 251719695;" : "=r"(r30) : "r"(r29));
  // PTX:115 mul.lo.s32 %r31, %r30, 17
  asm("mul.lo.s32 %0, %1, 17;" : "=r"(r31) : "r"(r30));
  // PTX:116 and.b32 %r32, %r31, 1124872387
  asm("and.b32 %0, %1, 1124872387;" : "=r"(r32) : "r"(r31));
  // PTX:117 mul.lo.s32 %r33, %r32, 5
  asm("mul.lo.s32 %0, %1, 5;" : "=r"(r33) : "r"(r32));
  // PTX:118 and.b32 %r34, %r33, 1227133513
  asm("and.b32 %0, %1, 1227133513;" : "=r"(r34) : "r"(r33));
  // PTX:119 mul.lo.s32 %r35, %r18, 20
  asm("mul.lo.s32 %0, %1, 20;" : "=r"(r35) : "r"(r18));
  // PTX:120 and.b32 %r36, %r35, 613566756
  asm("and.b32 %0, %1, 613566756;" : "=r"(r36) : "r"(r35));
  // PTX:121 mul.lo.s32 %r37, %r25, 10
  asm("mul.lo.s32 %0, %1, 10;" : "=r"(r37) : "r"(r25));
  // PTX:122 and.b32 %r38, %r37, -1840700270
  asm("and.b32 %0, %1, -1840700270;" : "=r"(r38) : "r"(r37));
  // PTX:123 or.b32 %r39, %r38, %r36
  asm("or.b32 %0, %1, %2;" : "=r"(r39) : "r"(r38), "r"(r36));
  // PTX:124 or.b32 %r40, %r39, %r34
  asm("or.b32 %0, %1, %2;" : "=r"(r40) : "r"(r39), "r"(r34));
  // PTX:125 cvta.to.global.u64 %rd7, %rd2
  rd7 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd2));
  // PTX:126 shl.b64 %rd8, %rd1, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd8) : "l"(rd1));
  // PTX:127 add.s64 %rd9, %rd7, %rd8
  asm("add.s64 %0, %1, %2;" : "=l"(rd9) : "l"(rd7), "l"(rd8));
  // PTX:128 st.global.u32 [%rd9], %r40
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (0))))) = (unsigned)(r40);
  // PTX:130 $L__BB0_8:
L_BB0_8:;
  // PTX:131 ret
  return;
}
