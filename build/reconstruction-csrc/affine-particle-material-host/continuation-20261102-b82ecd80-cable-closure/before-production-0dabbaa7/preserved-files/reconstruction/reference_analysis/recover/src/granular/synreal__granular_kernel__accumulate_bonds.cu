// 机械还原自 PTX：synreal::granular_kernel::accumulate_bonds(synreal::Model, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<2, int, (glm::qualifier)0> const*, float const*, float const*, int const*, int, float, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)
// PTX SHA256: c50fcd77920f6b251332ae5b3194abcb3626ac24f66a990fd58043e988f39e96
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__granular_kernel__accumulate_bonds(ByVal<1864, 8> param0, unsigned long long param1, unsigned long long param2, float param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned param8, float param9, unsigned long long param10, unsigned long long param11, unsigned long long param12) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74;
  // PTX:29 mov.b64 %rd4, _ZN7synreal15granular_kernel16accumulate_bondsENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_fPKNS3_ILi2EiLS4_0EEEPKfSC_PKiifPS5_PNS2_3matILi3ELi3EfLS4_0EEESI__param_0
  rd4 = (unsigned long long)(uintptr_t)&param0;
  // PTX:30 ld.param.u64 %rd5, [_ZN7synreal15granular_kernel16accumulate_bondsENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_fPKNS3_ILi2EiLS4_0EEEPKfSC_PKiifPS5_PNS2_3matILi3ELi3EfLS4_0EEESI__param_1]
  rd5 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:31 ld.param.u64 %rd6, [_ZN7synreal15granular_kernel16accumulate_bondsENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_fPKNS3_ILi2EiLS4_0EEEPKfSC_PKiifPS5_PNS2_3matILi3ELi3EfLS4_0EEESI__param_2]
  rd6 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:32 ld.param.f32 %f19, [_ZN7synreal15granular_kernel16accumulate_bondsENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_fPKNS3_ILi2EiLS4_0EEEPKfSC_PKiifPS5_PNS2_3matILi3ELi3EfLS4_0EEESI__param_3]
  f19 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param3 + (0))));
  // PTX:33 ld.param.u64 %rd7, [_ZN7synreal15granular_kernel16accumulate_bondsENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_fPKNS3_ILi2EiLS4_0EEEPKfSC_PKiifPS5_PNS2_3matILi3ELi3EfLS4_0EEESI__param_4]
  rd7 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:34 ld.param.u64 %rd8, [_ZN7synreal15granular_kernel16accumulate_bondsENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_fPKNS3_ILi2EiLS4_0EEEPKfSC_PKiifPS5_PNS2_3matILi3ELi3EfLS4_0EEESI__param_5]
  rd8 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:35 ld.param.u64 %rd9, [_ZN7synreal15granular_kernel16accumulate_bondsENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_fPKNS3_ILi2EiLS4_0EEEPKfSC_PKiifPS5_PNS2_3matILi3ELi3EfLS4_0EEESI__param_6]
  rd9 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:36 ld.param.u64 %rd10, [_ZN7synreal15granular_kernel16accumulate_bondsENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_fPKNS3_ILi2EiLS4_0EEEPKfSC_PKiifPS5_PNS2_3matILi3ELi3EfLS4_0EEESI__param_7]
  rd10 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:37 ld.param.u32 %r2, [_ZN7synreal15granular_kernel16accumulate_bondsENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_fPKNS3_ILi2EiLS4_0EEEPKfSC_PKiifPS5_PNS2_3matILi3ELi3EfLS4_0EEESI__param_8]
  r2 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param8 + (0))));
  // PTX:38 ld.param.f32 %f20, [_ZN7synreal15granular_kernel16accumulate_bondsENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_fPKNS3_ILi2EiLS4_0EEEPKfSC_PKiifPS5_PNS2_3matILi3ELi3EfLS4_0EEESI__param_9]
  f20 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param9 + (0))));
  // PTX:39 ld.param.u64 %rd11, [_ZN7synreal15granular_kernel16accumulate_bondsENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_fPKNS3_ILi2EiLS4_0EEEPKfSC_PKiifPS5_PNS2_3matILi3ELi3EfLS4_0EEESI__param_10]
  rd11 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:40 ld.param.u64 %rd12, [_ZN7synreal15granular_kernel16accumulate_bondsENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_fPKNS3_ILi2EiLS4_0EEEPKfSC_PKiifPS5_PNS2_3matILi3ELi3EfLS4_0EEESI__param_11]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:41 ld.param.u64 %rd13, [_ZN7synreal15granular_kernel16accumulate_bondsENS_5ModelEPKN3glm3vecILi3EfLNS2_9qualifierE0EEES7_fPKNS3_ILi2EiLS4_0EEEPKfSC_PKiifPS5_PNS2_3matILi3ELi3EfLS4_0EEESI__param_12]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:42 mov.u32 %r3, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(blockDim.x));
  // PTX:43 mov.u32 %r4, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r4) : "r"(blockIdx.x));
  // PTX:44 mov.u32 %r5, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r5) : "r"(threadIdx.x));
  // PTX:45 mad.lo.s32 %r1, %r4, %r3, %r5
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r1) : "r"(r4), "r"(r3), "r"(r5));
  // PTX:46 setp.ge.s32 %p1, %r1, %r2
  p1 = (((int)(r1)) >= ((int)(r2)));
  // PTX:47 @%p1 bra $L__BB3_12
  if (p1) { goto L_BB3_12; }
  // PTX:49 cvta.to.global.u64 %rd14, %rd10
  rd14 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd10));
  // PTX:50 cvt.s64.s32 %rd1, %r1
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd1) : "r"(r1));
  // PTX:51 cvta.to.global.u64 %rd15, %rd13
  rd15 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd13));
  // PTX:52 mul.wide.s32 %rd16, %r1, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd16) : "r"(r1));
  // PTX:53 add.s64 %rd17, %rd15, %rd16
  asm("add.s64 %0, %1, %2;" : "=l"(rd17) : "l"(rd15), "l"(rd16));
  // PTX:54 mov.u32 %r6, 0
  asm("mov.u32 %0, 0;" : "=r"(r6) : );
  // PTX:55 st.global.u32 [%rd17], %r6
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0))))) = (unsigned)(r6);
  // PTX:56 st.global.u32 [%rd17+4], %r6
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (4))))) = (unsigned)(r6);
  // PTX:57 st.global.u32 [%rd17+8], %r6
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (8))))) = (unsigned)(r6);
  // PTX:58 st.global.u32 [%rd17+12], %r6
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (12))))) = (unsigned)(r6);
  // PTX:59 st.global.u32 [%rd17+16], %r6
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (16))))) = (unsigned)(r6);
  // PTX:60 st.global.u32 [%rd17+20], %r6
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (20))))) = (unsigned)(r6);
  // PTX:61 st.global.u32 [%rd17+24], %r6
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (24))))) = (unsigned)(r6);
  // PTX:62 st.global.u32 [%rd17+28], %r6
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (28))))) = (unsigned)(r6);
  // PTX:63 st.global.u32 [%rd17+32], %r6
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (32))))) = (unsigned)(r6);
  // PTX:64 mul.wide.s32 %rd18, %r1, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd18) : "r"(r1));
  // PTX:65 add.s64 %rd19, %rd14, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd14), "l"(rd18));
  // PTX:66 ld.global.u32 %r7, [%rd19]
  r7 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))));
  // PTX:67 setp.eq.s32 %p2, %r7, 0
  p2 = (((int)(r7)) == ((int)(0)));
  // PTX:68 @%p2 bra $L__BB3_12
  if (p2) { goto L_BB3_12; }
  // PTX:70 cvta.to.global.u64 %rd20, %rd5
  rd20 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd5));
  // PTX:71 cvta.to.global.u64 %rd21, %rd7
  rd21 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd7));
  // PTX:72 shl.b64 %rd22, %rd1, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd22) : "l"(rd1));
  // PTX:73 add.s64 %rd23, %rd21, %rd22
  asm("add.s64 %0, %1, %2;" : "=l"(rd23) : "l"(rd21), "l"(rd22));
  // PTX:74 ld.global.u32 %r8, [%rd23]
  r8 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (0)))));
  // PTX:75 cvt.s64.s32 %rd2, %r8
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd2) : "r"(r8));
  // PTX:76 mul.wide.s32 %rd24, %r8, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd24) : "r"(r8));
  // PTX:77 add.s64 %rd25, %rd20, %rd24
  asm("add.s64 %0, %1, %2;" : "=l"(rd25) : "l"(rd20), "l"(rd24));
  // PTX:78 ld.global.u32 %r9, [%rd23+4]
  r9 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (4)))));
  // PTX:79 cvt.s64.s32 %rd3, %r9
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd3) : "r"(r9));
  // PTX:80 mul.wide.s32 %rd26, %r9, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd26) : "r"(r9));
  // PTX:81 add.s64 %rd27, %rd20, %rd26
  asm("add.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd20), "l"(rd26));
  // PTX:82 ld.global.f32 %f21, [%rd27]
  f21 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))));
  // PTX:83 ld.global.f32 %f22, [%rd25]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (0)))));
  // PTX:84 sub.f32 %f1, %f22, %f21
  asm("sub.f32 %0, %1, %2;" : "=f"(f1) : "f"(f22), "f"(f21));
  // PTX:85 ld.global.f32 %f23, [%rd27+4]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (4)))));
  // PTX:86 ld.global.f32 %f24, [%rd25+4]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (4)))));
  // PTX:87 sub.f32 %f2, %f24, %f23
  asm("sub.f32 %0, %1, %2;" : "=f"(f2) : "f"(f24), "f"(f23));
  // PTX:88 ld.global.f32 %f25, [%rd27+8]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (8)))));
  // PTX:89 ld.global.f32 %f26, [%rd25+8]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (8)))));
  // PTX:90 sub.f32 %f3, %f26, %f25
  asm("sub.f32 %0, %1, %2;" : "=f"(f3) : "f"(f26), "f"(f25));
  // PTX:91 mul.f32 %f27, %f2, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f27) : "f"(f2), "f"(f2));
  // PTX:92 fma.rn.f32 %f28, %f1, %f1, %f27
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f28) : "f"(f1), "f"(f1), "f"(f27));
  // PTX:93 fma.rn.f32 %f29, %f3, %f3, %f28
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f29) : "f"(f3), "f"(f3), "f"(f28));
  // PTX:94 sqrt.rn.f32 %f4, %f29
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f4) : "f"(f29));
  // PTX:95 ld.param.f32 %f30, [%rd4+324]
  f30 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd4) + (324))));
  // PTX:96 add.f32 %f31, %f30, 0f3F800000
  asm("add.f32 %0, %1, 0f3F800000;" : "=f"(f31) : "f"(f30));
  // PTX:97 cvta.to.global.u64 %rd29, %rd9
  rd29 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd9));
  // PTX:98 shl.b64 %rd30, %rd1, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd30) : "l"(rd1));
  // PTX:99 add.s64 %rd31, %rd29, %rd30
  asm("add.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd29), "l"(rd30));
  // PTX:100 ld.global.f32 %f5, [%rd31]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (0)))));
  // PTX:101 mul.f32 %f32, %f5, %f31
  asm("mul.f32 %0, %1, %2;" : "=f"(f32) : "f"(f5), "f"(f31));
  // PTX:102 setp.gt.f32 %p3, %f4, %f32
  p3 = (!(isnan(((float)(f4))) || isnan(((float)(f32)))) && (((float)(f4)) > ((float)(f32))));
  // PTX:103 @%p3 bra $L__BB3_12
  if (p3) { goto L_BB3_12; }
  // PTX:105 setp.gt.f32 %p4, %f4, 0f322BCC77
  p4 = (!(isnan(((float)(f4))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f4)) > ((float)(as_f32(0x322BCC77u)))));
  // PTX:106 mov.f32 %f128, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f128) : );
  // PTX:107 mov.f32 %f129, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f129) : );
  // PTX:108 @%p4 bra $L__BB3_8
  if (p4) { goto L_BB3_8; }
  // PTX:109 bra.uni $L__BB3_4
  goto L_BB3_4;
  // PTX:111 $L__BB3_8:
L_BB3_8:;
  // PTX:112 div.rn.f32 %f130, %f1, %f4
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f130) : "f"(f1), "f"(f4));
  // PTX:113 div.rn.f32 %f129, %f2, %f4
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f129) : "f"(f2), "f"(f4));
  // PTX:114 div.rn.f32 %f128, %f3, %f4
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f128) : "f"(f3), "f"(f4));
  // PTX:115 bra.uni $L__BB3_9
  goto L_BB3_9;
  // PTX:117 $L__BB3_4:
L_BB3_4:;
  // PTX:118 cvt.u32.u64 %r11, %rd3
  asm("cvt.u32.u64 %0, %1;" : "=r"(r11) : "l"(rd3));
  // PTX:119 cvt.u32.u64 %r12, %rd2
  asm("cvt.u32.u64 %0, %1;" : "=r"(r12) : "l"(rd2));
  // PTX:120 setp.lt.s32 %p5, %r12, %r11
  p5 = (((int)(r12)) < ((int)(r11)));
  // PTX:121 selp.f32 %f130, 0f3F800000, 0fBF800000, %p5
  f130 = p5 ? as_f32(0x3F800000u) : as_f32(0xBF800000u);
  // PTX:122 setp.gt.s32 %p6, %r12, %r11
  p6 = (((int)(r12)) > ((int)(r11)));
  // PTX:123 selp.b32 %r13, %r11, %r12, %p6
  r13 = p6 ? r11 : r12;
  // PTX:124 selp.b32 %r14, %r11, %r12, %p5
  r14 = p5 ? r11 : r12;
  // PTX:125 add.s32 %r15, %r13, %r14
  asm("add.s32 %0, %1, %2;" : "=r"(r15) : "r"(r13), "r"(r14));
  // PTX:126 mul.hi.s32 %r16, %r15, 1431655766
  asm("mul.hi.s32 %0, %1, 1431655766;" : "=r"(r16) : "r"(r15));
  // PTX:127 shr.u32 %r17, %r16, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r17) : "r"(r16));
  // PTX:128 add.s32 %r18, %r16, %r17
  asm("add.s32 %0, %1, %2;" : "=r"(r18) : "r"(r16), "r"(r17));
  // PTX:129 mul.lo.s32 %r19, %r18, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r19) : "r"(r18));
  // PTX:130 sub.s32 %r10, %r15, %r19
  asm("sub.s32 %0, %1, %2;" : "=r"(r10) : "r"(r15), "r"(r19));
  // PTX:131 setp.eq.s32 %p7, %r10, 2
  p7 = (((int)(r10)) == ((int)(2)));
  // PTX:132 mov.f32 %f127, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f127) : );
  // PTX:133 @%p7 bra $L__BB3_7
  if (p7) { goto L_BB3_7; }
  // PTX:135 setp.ne.s32 %p8, %r10, 1
  p8 = (((int)(r10)) != ((int)(1)));
  // PTX:136 @%p8 bra $L__BB3_9
  if (p8) { goto L_BB3_9; }
  // PTX:138 mov.f32 %f129, %f130
  asm("mov.f32 %0, %1;" : "=f"(f129) : "f"(f130));
  // PTX:139 mov.f32 %f130, %f127
  asm("mov.f32 %0, %1;" : "=f"(f130) : "f"(f127));
  // PTX:140 bra.uni $L__BB3_9
  goto L_BB3_9;
  // PTX:142 $L__BB3_7:
L_BB3_7:;
  // PTX:143 mov.f32 %f128, %f130
  asm("mov.f32 %0, %1;" : "=f"(f128) : "f"(f130));
  // PTX:144 mov.f32 %f130, %f127
  asm("mov.f32 %0, %1;" : "=f"(f130) : "f"(f127));
  // PTX:146 $L__BB3_9:
L_BB3_9:;
  // PTX:147 cvta.to.global.u64 %rd32, %rd8
  rd32 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd8));
  // PTX:148 add.s64 %rd34, %rd32, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd34) : "l"(rd32), "l"(rd18));
  // PTX:149 ld.param.f32 %f39, [%rd4+320]
  f39 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd4) + (320))));
  // PTX:150 mov.f32 %f40, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f40) : );
  // PTX:151 sub.f32 %f41, %f40, %f39
  asm("sub.f32 %0, %1, %2;" : "=f"(f41) : "f"(f40), "f"(f39));
  // PTX:152 ld.global.f32 %f13, [%rd34]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (0)))));
  // PTX:153 mul.f32 %f42, %f13, %f41
  asm("mul.f32 %0, %1, %2;" : "=f"(f42) : "f"(f13), "f"(f41));
  // PTX:154 ld.param.v2.f32 {%f43, %f44}, [%rd4+312]
  f43 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd4) + (312)))); f44 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd4) + (316))));
  // PTX:155 fma.rn.f32 %f47, %f13, %f44, %f4
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f47) : "f"(f13), "f"(f44), "f"(f4));
  // PTX:156 min.f32 %f48, %f5, %f47
  asm("min.f32 %0, %1, %2;" : "=f"(f48) : "f"(f5), "f"(f47));
  // PTX:157 max.f32 %f14, %f42, %f48
  asm("max.f32 %0, %1, %2;" : "=f"(f14) : "f"(f42), "f"(f48));
  // PTX:158 sub.f32 %f49, %f4, %f14
  asm("sub.f32 %0, %1, %2;" : "=f"(f49) : "f"(f4), "f"(f14));
  // PTX:159 mul.f32 %f50, %f49, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f50) : "f"(f49), "f"(f20));
  // PTX:160 neg.f32 %f131, %f50
  asm("neg.f32 %0, %1;" : "=f"(f131) : "f"(f50));
  // PTX:161 div.rn.f32 %f16, %f43, %f19
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f16) : "f"(f43), "f"(f19));
  // PTX:162 setp.leu.f32 %p9, %f16, 0f00000000
  p9 = ((isnan(((float)(f16))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f16)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:163 @%p9 bra $L__BB3_11
  if (p9) { goto L_BB3_11; }
  // PTX:165 cvta.to.global.u64 %rd36, %rd6
  rd36 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd6));
  // PTX:166 mul.lo.s64 %rd37, %rd2, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd37) : "l"(rd2));
  // PTX:167 add.s64 %rd38, %rd36, %rd37
  asm("add.s64 %0, %1, %2;" : "=l"(rd38) : "l"(rd36), "l"(rd37));
  // PTX:168 mul.lo.s64 %rd39, %rd3, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd39) : "l"(rd3));
  // PTX:169 add.s64 %rd40, %rd36, %rd39
  asm("add.s64 %0, %1, %2;" : "=l"(rd40) : "l"(rd36), "l"(rd39));
  // PTX:170 ld.global.f32 %f51, [%rd40]
  f51 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (0)))));
  // PTX:171 ld.global.f32 %f52, [%rd38]
  f52 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (0)))));
  // PTX:172 sub.f32 %f53, %f52, %f51
  asm("sub.f32 %0, %1, %2;" : "=f"(f53) : "f"(f52), "f"(f51));
  // PTX:173 ld.global.f32 %f54, [%rd40+4]
  f54 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (4)))));
  // PTX:174 ld.global.f32 %f55, [%rd38+4]
  f55 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (4)))));
  // PTX:175 sub.f32 %f56, %f55, %f54
  asm("sub.f32 %0, %1, %2;" : "=f"(f56) : "f"(f55), "f"(f54));
  // PTX:176 ld.global.f32 %f57, [%rd40+8]
  f57 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (8)))));
  // PTX:177 ld.global.f32 %f58, [%rd38+8]
  f58 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (8)))));
  // PTX:178 sub.f32 %f59, %f58, %f57
  asm("sub.f32 %0, %1, %2;" : "=f"(f59) : "f"(f58), "f"(f57));
  // PTX:179 mul.f32 %f60, %f56, %f56
  asm("mul.f32 %0, %1, %2;" : "=f"(f60) : "f"(f56), "f"(f56));
  // PTX:180 fma.rn.f32 %f61, %f53, %f53, %f60
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f61) : "f"(f53), "f"(f53), "f"(f60));
  // PTX:181 fma.rn.f32 %f62, %f59, %f59, %f61
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f62) : "f"(f59), "f"(f59), "f"(f61));
  // PTX:182 sqrt.rn.f32 %f63, %f62
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f63) : "f"(f62));
  // PTX:183 sub.f32 %f64, %f4, %f63
  asm("sub.f32 %0, %1, %2;" : "=f"(f64) : "f"(f4), "f"(f63));
  // PTX:184 mul.f32 %f65, %f16, %f64
  asm("mul.f32 %0, %1, %2;" : "=f"(f65) : "f"(f16), "f"(f64));
  // PTX:185 sub.f32 %f131, %f131, %f65
  asm("sub.f32 %0, %1, %2;" : "=f"(f131) : "f"(f131), "f"(f65));
  // PTX:187 $L__BB3_11:
L_BB3_11:;
  // PTX:188 ld.param.f32 %f66, [%rd4+320]
  f66 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd4) + (320))));
  // PTX:189 sub.f32 %f68, %f40, %f66
  asm("sub.f32 %0, %1, %2;" : "=f"(f68) : "f"(f40), "f"(f66));
  // PTX:190 mul.f32 %f69, %f13, %f68
  asm("mul.f32 %0, %1, %2;" : "=f"(f69) : "f"(f13), "f"(f68));
  // PTX:191 setp.gt.f32 %p10, %f14, %f69
  p10 = (!(isnan(((float)(f14))) || isnan(((float)(f69)))) && (((float)(f14)) > ((float)(f69))));
  // PTX:192 setp.lt.f32 %p11, %f14, %f5
  p11 = (!(isnan(((float)(f14))) || isnan(((float)(f5)))) && (((float)(f14)) < ((float)(f5))));
  // PTX:193 and.pred %p12, %p11, %p10
  p12 = ((p11) && (p10));
  // PTX:194 selp.f32 %f70, 0f00000000, %f20, %p12
  f70 = p12 ? as_f32(0x00000000u) : f20;
  // PTX:195 mov.f32 %f71, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f71) : );
  // PTX:196 max.f32 %f73, %f49, %f71
  asm("max.f32 %0, %1, %2;" : "=f"(f73) : "f"(f49), "f"(f71));
  // PTX:197 mul.f32 %f74, %f73, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f74) : "f"(f73), "f"(f20));
  // PTX:198 mov.f32 %f75, 0f322BCC77
  asm("mov.f32 %0, 0f322BCC77;" : "=f"(f75) : );
  // PTX:199 max.f32 %f76, %f4, %f75
  asm("max.f32 %0, %1, %2;" : "=f"(f76) : "f"(f4), "f"(f75));
  // PTX:200 div.rn.f32 %f77, %f74, %f76
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f77) : "f"(f74), "f"(f76));
  // PTX:201 add.f32 %f78, %f16, %f70
  asm("add.f32 %0, %1, %2;" : "=f"(f78) : "f"(f16), "f"(f70));
  // PTX:202 sub.f32 %f79, %f78, %f77
  asm("sub.f32 %0, %1, %2;" : "=f"(f79) : "f"(f78), "f"(f77));
  // PTX:203 mul.f32 %f80, %f130, %f130
  asm("mul.f32 %0, %1, %2;" : "=f"(f80) : "f"(f130), "f"(f130));
  // PTX:204 mul.f32 %f81, %f129, %f130
  asm("mul.f32 %0, %1, %2;" : "=f"(f81) : "f"(f129), "f"(f130));
  // PTX:205 mul.f32 %f82, %f79, %f81
  asm("mul.f32 %0, %1, %2;" : "=f"(f82) : "f"(f79), "f"(f81));
  // PTX:206 mul.f32 %f83, %f128, %f130
  asm("mul.f32 %0, %1, %2;" : "=f"(f83) : "f"(f128), "f"(f130));
  // PTX:207 mul.f32 %f84, %f79, %f83
  asm("mul.f32 %0, %1, %2;" : "=f"(f84) : "f"(f79), "f"(f83));
  // PTX:208 mul.f32 %f85, %f129, %f129
  asm("mul.f32 %0, %1, %2;" : "=f"(f85) : "f"(f129), "f"(f129));
  // PTX:209 mul.f32 %f86, %f128, %f129
  asm("mul.f32 %0, %1, %2;" : "=f"(f86) : "f"(f128), "f"(f129));
  // PTX:210 mul.f32 %f87, %f79, %f86
  asm("mul.f32 %0, %1, %2;" : "=f"(f87) : "f"(f79), "f"(f86));
  // PTX:211 mul.f32 %f88, %f128, %f128
  asm("mul.f32 %0, %1, %2;" : "=f"(f88) : "f"(f128), "f"(f128));
  // PTX:212 fma.rn.f32 %f89, %f79, %f80, %f77
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f89) : "f"(f79), "f"(f80), "f"(f77));
  // PTX:213 fma.rn.f32 %f90, %f77, 0f00000000, %f82
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f90) : "f"(f77), "f"(f82));
  // PTX:214 fma.rn.f32 %f91, %f77, 0f00000000, %f84
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f91) : "f"(f77), "f"(f84));
  // PTX:215 fma.rn.f32 %f92, %f79, %f85, %f77
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f92) : "f"(f79), "f"(f85), "f"(f77));
  // PTX:216 fma.rn.f32 %f93, %f77, 0f00000000, %f87
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f93) : "f"(f77), "f"(f87));
  // PTX:217 fma.rn.f32 %f94, %f79, %f88, %f77
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f94) : "f"(f79), "f"(f88), "f"(f77));
  // PTX:218 st.global.f32 [%rd17], %f89
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0))))) = (float)(f89);
  // PTX:219 st.global.f32 [%rd17+4], %f90
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (4))))) = (float)(f90);
  // PTX:220 st.global.f32 [%rd17+8], %f91
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (8))))) = (float)(f91);
  // PTX:221 st.global.f32 [%rd17+12], %f90
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (12))))) = (float)(f90);
  // PTX:222 st.global.f32 [%rd17+16], %f92
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (16))))) = (float)(f92);
  // PTX:223 st.global.f32 [%rd17+20], %f93
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (20))))) = (float)(f93);
  // PTX:224 st.global.f32 [%rd17+24], %f91
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (24))))) = (float)(f91);
  // PTX:225 st.global.f32 [%rd17+28], %f93
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (28))))) = (float)(f93);
  // PTX:226 st.global.f32 [%rd17+32], %f94
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (32))))) = (float)(f94);
  // PTX:227 cvta.to.global.u64 %rd45, %rd11
  rd45 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd11));
  // PTX:228 mul.lo.s64 %rd46, %rd2, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd46) : "l"(rd2));
  // PTX:229 add.s64 %rd47, %rd45, %rd46
  asm("add.s64 %0, %1, %2;" : "=l"(rd47) : "l"(rd45), "l"(rd46));
  // PTX:230 mul.f32 %f95, %f130, %f131
  asm("mul.f32 %0, %1, %2;" : "=f"(f95) : "f"(f130), "f"(f131));
  // PTX:231 red.global.add.f32 [%rd47], %f95
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))), (float)(f95));
  // PTX:232 add.s64 %rd48, %rd47, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd48) : "l"(rd47));
  // PTX:233 mul.f32 %f97, %f129, %f131
  asm("mul.f32 %0, %1, %2;" : "=f"(f97) : "f"(f129), "f"(f131));
  // PTX:234 red.global.add.f32 [%rd48], %f97
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))), (float)(f97));
  // PTX:235 add.s64 %rd49, %rd47, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd49) : "l"(rd47));
  // PTX:236 mul.f32 %f99, %f128, %f131
  asm("mul.f32 %0, %1, %2;" : "=f"(f99) : "f"(f128), "f"(f131));
  // PTX:237 red.global.add.f32 [%rd49], %f99
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))), (float)(f99));
  // PTX:238 mul.lo.s64 %rd50, %rd3, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd50) : "l"(rd3));
  // PTX:239 add.s64 %rd51, %rd45, %rd50
  asm("add.s64 %0, %1, %2;" : "=l"(rd51) : "l"(rd45), "l"(rd50));
  // PTX:240 neg.f32 %f101, %f95
  asm("neg.f32 %0, %1;" : "=f"(f101) : "f"(f95));
  // PTX:241 neg.f32 %f102, %f97
  asm("neg.f32 %0, %1;" : "=f"(f102) : "f"(f97));
  // PTX:242 neg.f32 %f103, %f99
  asm("neg.f32 %0, %1;" : "=f"(f103) : "f"(f99));
  // PTX:243 red.global.add.f32 [%rd51], %f101
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))), (float)(f101));
  // PTX:244 add.s64 %rd52, %rd51, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd52) : "l"(rd51));
  // PTX:245 red.global.add.f32 [%rd52], %f102
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))), (float)(f102));
  // PTX:246 add.s64 %rd53, %rd51, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd53) : "l"(rd51));
  // PTX:247 red.global.add.f32 [%rd53], %f103
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))), (float)(f103));
  // PTX:248 cvta.to.global.u64 %rd54, %rd12
  rd54 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd12));
  // PTX:249 mul.lo.s64 %rd55, %rd2, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd55) : "l"(rd2));
  // PTX:250 add.s64 %rd56, %rd54, %rd55
  asm("add.s64 %0, %1, %2;" : "=l"(rd56) : "l"(rd54), "l"(rd55));
  // PTX:251 red.global.add.f32 [%rd56], %f89
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))), (float)(f89));
  // PTX:252 add.s64 %rd57, %rd56, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd57) : "l"(rd56));
  // PTX:253 red.global.add.f32 [%rd57], %f90
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))), (float)(f90));
  // PTX:254 add.s64 %rd58, %rd56, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd58) : "l"(rd56));
  // PTX:255 red.global.add.f32 [%rd58], %f91
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (0)))), (float)(f91));
  // PTX:256 add.s64 %rd59, %rd56, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd59) : "l"(rd56));
  // PTX:257 red.global.add.f32 [%rd59], %f90
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))), (float)(f90));
  // PTX:258 add.s64 %rd60, %rd56, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd60) : "l"(rd56));
  // PTX:259 red.global.add.f32 [%rd60], %f92
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))), (float)(f92));
  // PTX:260 add.s64 %rd61, %rd56, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd61) : "l"(rd56));
  // PTX:261 red.global.add.f32 [%rd61], %f93
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))), (float)(f93));
  // PTX:262 add.s64 %rd62, %rd56, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd62) : "l"(rd56));
  // PTX:263 red.global.add.f32 [%rd62], %f91
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))), (float)(f91));
  // PTX:264 add.s64 %rd63, %rd56, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd63) : "l"(rd56));
  // PTX:265 red.global.add.f32 [%rd63], %f93
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (0)))), (float)(f93));
  // PTX:266 add.s64 %rd64, %rd56, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd64) : "l"(rd56));
  // PTX:267 red.global.add.f32 [%rd64], %f94
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (0)))), (float)(f94));
  // PTX:268 mul.lo.s64 %rd65, %rd3, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd65) : "l"(rd3));
  // PTX:269 add.s64 %rd66, %rd54, %rd65
  asm("add.s64 %0, %1, %2;" : "=l"(rd66) : "l"(rd54), "l"(rd65));
  // PTX:270 red.global.add.f32 [%rd66], %f89
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (0)))), (float)(f89));
  // PTX:271 add.s64 %rd67, %rd66, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd67) : "l"(rd66));
  // PTX:272 red.global.add.f32 [%rd67], %f90
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0)))), (float)(f90));
  // PTX:273 add.s64 %rd68, %rd66, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd68) : "l"(rd66));
  // PTX:274 red.global.add.f32 [%rd68], %f91
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (0)))), (float)(f91));
  // PTX:275 add.s64 %rd69, %rd66, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd69) : "l"(rd66));
  // PTX:276 red.global.add.f32 [%rd69], %f90
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (0)))), (float)(f90));
  // PTX:277 add.s64 %rd70, %rd66, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd70) : "l"(rd66));
  // PTX:278 red.global.add.f32 [%rd70], %f92
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0)))), (float)(f92));
  // PTX:279 add.s64 %rd71, %rd66, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd71) : "l"(rd66));
  // PTX:280 red.global.add.f32 [%rd71], %f93
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))), (float)(f93));
  // PTX:281 add.s64 %rd72, %rd66, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd72) : "l"(rd66));
  // PTX:282 red.global.add.f32 [%rd72], %f91
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (0)))), (float)(f91));
  // PTX:283 add.s64 %rd73, %rd66, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd73) : "l"(rd66));
  // PTX:284 red.global.add.f32 [%rd73], %f93
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (0)))), (float)(f93));
  // PTX:285 add.s64 %rd74, %rd66, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd74) : "l"(rd66));
  // PTX:286 red.global.add.f32 [%rd74], %f94
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (0)))), (float)(f94));
  // PTX:288 $L__BB3_12:
L_BB3_12:;
  // PTX:289 ret
  return;
}
