// 机械还原自 PTX：synreal::kernel::prepare_cable_penalties(glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0>*, int*, unsigned long, unsigned long, float, float, float, float, float, bool, bool, int const*)
// PTX SHA256: f561bf5c2845bd59d4131883b0a1e086f2d155e6f4aaf4a64791e5254013de4d
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__prepare_cable_penalties(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, float param5, float param6, float param7, float param8, float param9, unsigned char param10, unsigned char param11, unsigned long long param12) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11;
  unsigned short rs0, rs1, rs2;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27;
  // PTX:30 ld.param.s8 %rs2, [_ZN7synreal6kernel23prepare_cable_penaltiesEPKN3glm3vecILi4EfLNS1_9qualifierE0EEEPS4_PimmfffffbbPKi_param_11]
  rs2 = (*reinterpret_cast<volatile signed char*>(((uintptr_t)&param11 + (0))));
  // PTX:31 ld.param.s8 %rs1, [_ZN7synreal6kernel23prepare_cable_penaltiesEPKN3glm3vecILi4EfLNS1_9qualifierE0EEEPS4_PimmfffffbbPKi_param_10]
  rs1 = (*reinterpret_cast<volatile signed char*>(((uintptr_t)&param10 + (0))));
  // PTX:32 ld.param.u64 %rd7, [_ZN7synreal6kernel23prepare_cable_penaltiesEPKN3glm3vecILi4EfLNS1_9qualifierE0EEEPS4_PimmfffffbbPKi_param_0]
  rd7 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:33 ld.param.u64 %rd8, [_ZN7synreal6kernel23prepare_cable_penaltiesEPKN3glm3vecILi4EfLNS1_9qualifierE0EEEPS4_PimmfffffbbPKi_param_1]
  rd8 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:34 ld.param.u64 %rd9, [_ZN7synreal6kernel23prepare_cable_penaltiesEPKN3glm3vecILi4EfLNS1_9qualifierE0EEEPS4_PimmfffffbbPKi_param_2]
  rd9 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:35 ld.param.u64 %rd10, [_ZN7synreal6kernel23prepare_cable_penaltiesEPKN3glm3vecILi4EfLNS1_9qualifierE0EEEPS4_PimmfffffbbPKi_param_3]
  rd10 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:36 ld.param.u64 %rd12, [_ZN7synreal6kernel23prepare_cable_penaltiesEPKN3glm3vecILi4EfLNS1_9qualifierE0EEEPS4_PimmfffffbbPKi_param_4]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:37 ld.param.f32 %f21, [_ZN7synreal6kernel23prepare_cable_penaltiesEPKN3glm3vecILi4EfLNS1_9qualifierE0EEEPS4_PimmfffffbbPKi_param_5]
  f21 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param5 + (0))));
  // PTX:38 ld.param.f32 %f22, [_ZN7synreal6kernel23prepare_cable_penaltiesEPKN3glm3vecILi4EfLNS1_9qualifierE0EEEPS4_PimmfffffbbPKi_param_6]
  f22 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param6 + (0))));
  // PTX:39 ld.param.f32 %f23, [_ZN7synreal6kernel23prepare_cable_penaltiesEPKN3glm3vecILi4EfLNS1_9qualifierE0EEEPS4_PimmfffffbbPKi_param_7]
  f23 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param7 + (0))));
  // PTX:40 ld.param.f32 %f24, [_ZN7synreal6kernel23prepare_cable_penaltiesEPKN3glm3vecILi4EfLNS1_9qualifierE0EEEPS4_PimmfffffbbPKi_param_8]
  f24 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param8 + (0))));
  // PTX:41 ld.param.f32 %f25, [_ZN7synreal6kernel23prepare_cable_penaltiesEPKN3glm3vecILi4EfLNS1_9qualifierE0EEEPS4_PimmfffffbbPKi_param_9]
  f25 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param9 + (0))));
  // PTX:42 ld.param.u64 %rd11, [_ZN7synreal6kernel23prepare_cable_penaltiesEPKN3glm3vecILi4EfLNS1_9qualifierE0EEEPS4_PimmfffffbbPKi_param_12]
  rd11 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:43 mov.u32 %r1, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r1) : "r"(blockIdx.x));
  // PTX:44 mov.u32 %r2, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockDim.x));
  // PTX:45 mul.wide.u32 %rd13, %r1, %r2
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd13) : "r"(r1), "r"(r2));
  // PTX:46 mov.u32 %r3, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(threadIdx.x));
  // PTX:47 cvt.u64.u32 %rd14, %r3
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd14) : "r"(r3));
  // PTX:48 add.s64 %rd1, %rd13, %rd14
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd13), "l"(rd14));
  // PTX:49 setp.ge.u64 %p1, %rd1, %rd12
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd12)));
  // PTX:50 @%p1 bra $L__BB71_18
  if (p1) { goto L_BB71_18; }
  // PTX:52 setp.eq.s64 %p2, %rd11, 0
  p2 = (((long long)(rd11)) == ((long long)(0)));
  // PTX:53 @%p2 bra $L__BB71_3
  if (p2) { goto L_BB71_3; }
  // PTX:55 cvta.to.global.u64 %rd15, %rd11
  rd15 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd11));
  // PTX:56 shl.b64 %rd16, %rd1, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd16) : "l"(rd1));
  // PTX:57 add.s64 %rd17, %rd15, %rd16
  asm("add.s64 %0, %1, %2;" : "=l"(rd17) : "l"(rd15), "l"(rd16));
  // PTX:58 ld.global.u32 %r4, [%rd17]
  r4 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:59 setp.eq.s32 %p3, %r4, 0
  p3 = (((int)(r4)) == ((int)(0)));
  // PTX:60 @%p3 bra $L__BB71_18
  if (p3) { goto L_BB71_18; }
  // PTX:62 $L__BB71_3:
L_BB71_3:;
  // PTX:63 or.b64 %rd18, %rd1, %rd10
  asm("or.b64 %0, %1, %2;" : "=l"(rd18) : "l"(rd1), "l"(rd10));
  // PTX:64 and.b64 %rd19, %rd18, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd19) : "l"(rd18));
  // PTX:65 setp.eq.s64 %p4, %rd19, 0
  p4 = (((long long)(rd19)) == ((long long)(0)));
  // PTX:66 @%p4 bra $L__BB71_5
  if (p4) { goto L_BB71_5; }
  // PTX:68 rem.u64 %rd27, %rd1, %rd10
  asm("rem.u64 %0, %1, %2;" : "=l"(rd27) : "l"(rd1), "l"(rd10));
  // PTX:69 bra.uni $L__BB71_6
  goto L_BB71_6;
  // PTX:71 $L__BB71_5:
L_BB71_5:;
  // PTX:72 cvt.u32.u64 %r5, %rd10
  asm("cvt.u32.u64 %0, %1;" : "=r"(r5) : "l"(rd10));
  // PTX:73 cvt.u32.u64 %r6, %rd1
  asm("cvt.u32.u64 %0, %1;" : "=r"(r6) : "l"(rd1));
  // PTX:74 rem.u32 %r7, %r6, %r5
  asm("rem.u32 %0, %1, %2;" : "=r"(r7) : "r"(r6), "r"(r5));
  // PTX:75 cvt.u64.u32 %rd27, %r7
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd27) : "r"(r7));
  // PTX:77 $L__BB71_6:
L_BB71_6:;
  // PTX:78 cvta.to.global.u64 %rd20, %rd7
  rd20 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd7));
  // PTX:79 shl.b64 %rd21, %rd27, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd21) : "l"(rd27));
  // PTX:80 add.s64 %rd22, %rd20, %rd21
  asm("add.s64 %0, %1, %2;" : "=l"(rd22) : "l"(rd20), "l"(rd21));
  // PTX:81 ld.global.f32 %f1, [%rd22]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (0)))));
  // PTX:82 ld.global.f32 %f2, [%rd22+4]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (4)))));
  // PTX:83 ld.global.f32 %f3, [%rd22+8]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (8)))));
  // PTX:84 ld.global.f32 %f4, [%rd22+12]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (12)))));
  // PTX:85 setp.leu.f32 %p5, %f21, 0f00000000
  p5 = ((isnan(((float)(f21))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f21)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:86 mov.f32 %f39, %f1
  asm("mov.f32 %0, %1;" : "=f"(f39) : "f"(f1));
  // PTX:87 @%p5 bra $L__BB71_8
  if (p5) { goto L_BB71_8; }
  // PTX:89 min.f32 %f39, %f24, %f1
  asm("min.f32 %0, %1, %2;" : "=f"(f39) : "f"(f24), "f"(f1));
  // PTX:91 $L__BB71_8:
L_BB71_8:;
  // PTX:92 mov.f32 %f40, %f2
  asm("mov.f32 %0, %1;" : "=f"(f40) : "f"(f2));
  // PTX:93 @%p5 bra $L__BB71_10
  if (p5) { goto L_BB71_10; }
  // PTX:95 min.f32 %f40, %f24, %f2
  asm("min.f32 %0, %1, %2;" : "=f"(f40) : "f"(f24), "f"(f2));
  // PTX:97 $L__BB71_10:
L_BB71_10:;
  // PTX:98 setp.leu.f32 %p7, %f22, 0f00000000
  p7 = ((isnan(((float)(f22))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f22)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:99 mov.f32 %f41, %f3
  asm("mov.f32 %0, %1;" : "=f"(f41) : "f"(f3));
  // PTX:100 @%p7 bra $L__BB71_12
  if (p7) { goto L_BB71_12; }
  // PTX:102 min.f32 %f41, %f25, %f3
  asm("min.f32 %0, %1, %2;" : "=f"(f41) : "f"(f25), "f"(f3));
  // PTX:104 $L__BB71_12:
L_BB71_12:;
  // PTX:105 mov.f32 %f42, %f4
  asm("mov.f32 %0, %1;" : "=f"(f42) : "f"(f4));
  // PTX:106 @%p7 bra $L__BB71_14
  if (p7) { goto L_BB71_14; }
  // PTX:108 min.f32 %f42, %f25, %f4
  asm("min.f32 %0, %1, %2;" : "=f"(f42) : "f"(f25), "f"(f4));
  // PTX:110 $L__BB71_14:
L_BB71_14:;
  // PTX:111 cvta.to.global.u64 %rd23, %rd9
  rd23 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd9));
  // PTX:112 shl.b64 %rd24, %rd1, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd24) : "l"(rd1));
  // PTX:113 add.s64 %rd5, %rd23, %rd24
  asm("add.s64 %0, %1, %2;" : "=l"(rd5) : "l"(rd23), "l"(rd24));
  // PTX:114 cvta.to.global.u64 %rd25, %rd8
  rd25 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd8));
  // PTX:115 shl.b64 %rd26, %rd1, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd26) : "l"(rd1));
  // PTX:116 add.s64 %rd6, %rd25, %rd26
  asm("add.s64 %0, %1, %2;" : "=l"(rd6) : "l"(rd25), "l"(rd26));
  // PTX:117 setp.eq.s16 %p9, %rs1, 0
  p9 = (((short)(rs1)) == ((short)(0)));
  // PTX:118 mov.f32 %f43, %f39
  asm("mov.f32 %0, %1;" : "=f"(f43) : "f"(f39));
  // PTX:119 mov.f32 %f44, %f40
  asm("mov.f32 %0, %1;" : "=f"(f44) : "f"(f40));
  // PTX:120 mov.f32 %f45, %f41
  asm("mov.f32 %0, %1;" : "=f"(f45) : "f"(f41));
  // PTX:121 mov.f32 %f46, %f42
  asm("mov.f32 %0, %1;" : "=f"(f46) : "f"(f42));
  // PTX:122 @%p9 bra $L__BB71_15
  if (p9) { goto L_BB71_15; }
  // PTX:123 bra.uni $L__BB71_17
  goto L_BB71_17;
  // PTX:125 $L__BB71_15:
L_BB71_15:;
  // PTX:126 ld.global.u32 %r8, [%rd5]
  r8 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (0)))));
  // PTX:127 setp.eq.s32 %p10, %r8, 0
  p10 = (((int)(r8)) == ((int)(0)));
  // PTX:128 mov.f32 %f43, %f39
  asm("mov.f32 %0, %1;" : "=f"(f43) : "f"(f39));
  // PTX:129 mov.f32 %f44, %f40
  asm("mov.f32 %0, %1;" : "=f"(f44) : "f"(f40));
  // PTX:130 mov.f32 %f45, %f41
  asm("mov.f32 %0, %1;" : "=f"(f45) : "f"(f41));
  // PTX:131 mov.f32 %f46, %f42
  asm("mov.f32 %0, %1;" : "=f"(f46) : "f"(f42));
  // PTX:132 @%p10 bra $L__BB71_17
  if (p10) { goto L_BB71_17; }
  // PTX:134 ld.global.f32 %f43, [%rd6]
  f43 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd6) + (0)))));
  // PTX:135 ld.global.f32 %f44, [%rd6+4]
  f44 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd6) + (4)))));
  // PTX:136 ld.global.f32 %f45, [%rd6+8]
  f45 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd6) + (8)))));
  // PTX:137 ld.global.f32 %f46, [%rd6+12]
  f46 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd6) + (12)))));
  // PTX:139 $L__BB71_17:
L_BB71_17:;
  // PTX:140 setp.eq.s16 %p11, %rs2, 0
  p11 = (((short)(rs2)) == ((short)(0)));
  // PTX:141 selp.f32 %f26, 0f3F800000, %f23, %p11
  f26 = p11 ? as_f32(0x3F800000u) : f23;
  // PTX:142 mul.f32 %f27, %f26, %f43
  asm("mul.f32 %0, %1, %2;" : "=f"(f27) : "f"(f26), "f"(f43));
  // PTX:143 max.f32 %f28, %f39, %f27
  asm("max.f32 %0, %1, %2;" : "=f"(f28) : "f"(f39), "f"(f27));
  // PTX:144 min.f32 %f29, %f1, %f28
  asm("min.f32 %0, %1, %2;" : "=f"(f29) : "f"(f1), "f"(f28));
  // PTX:145 mul.f32 %f30, %f26, %f44
  asm("mul.f32 %0, %1, %2;" : "=f"(f30) : "f"(f26), "f"(f44));
  // PTX:146 max.f32 %f31, %f40, %f30
  asm("max.f32 %0, %1, %2;" : "=f"(f31) : "f"(f40), "f"(f30));
  // PTX:147 min.f32 %f32, %f2, %f31
  asm("min.f32 %0, %1, %2;" : "=f"(f32) : "f"(f2), "f"(f31));
  // PTX:148 mul.f32 %f33, %f26, %f45
  asm("mul.f32 %0, %1, %2;" : "=f"(f33) : "f"(f26), "f"(f45));
  // PTX:149 max.f32 %f34, %f41, %f33
  asm("max.f32 %0, %1, %2;" : "=f"(f34) : "f"(f41), "f"(f33));
  // PTX:150 min.f32 %f35, %f3, %f34
  asm("min.f32 %0, %1, %2;" : "=f"(f35) : "f"(f3), "f"(f34));
  // PTX:151 mul.f32 %f36, %f26, %f46
  asm("mul.f32 %0, %1, %2;" : "=f"(f36) : "f"(f26), "f"(f46));
  // PTX:152 max.f32 %f37, %f42, %f36
  asm("max.f32 %0, %1, %2;" : "=f"(f37) : "f"(f42), "f"(f36));
  // PTX:153 min.f32 %f38, %f4, %f37
  asm("min.f32 %0, %1, %2;" : "=f"(f38) : "f"(f4), "f"(f37));
  // PTX:154 st.global.f32 [%rd6], %f29
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd6) + (0))))) = (float)(f29);
  // PTX:155 st.global.f32 [%rd6+4], %f32
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd6) + (4))))) = (float)(f32);
  // PTX:156 st.global.f32 [%rd6+8], %f35
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd6) + (8))))) = (float)(f35);
  // PTX:157 st.global.f32 [%rd6+12], %f38
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd6) + (12))))) = (float)(f38);
  // PTX:158 mov.u32 %r9, 1
  asm("mov.u32 %0, 1;" : "=r"(r9) : );
  // PTX:159 st.global.u32 [%rd5], %r9
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (0))))) = (unsigned)(r9);
  // PTX:161 $L__BB71_18:
L_BB71_18:;
  // PTX:162 ret
  return;
}
