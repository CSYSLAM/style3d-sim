// 机械还原自 PTX：void synreal::kernel::multiply_matrix_and_reduce<256u, synreal::BlockNonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >(int const*, synreal::BlockNonZeroEntry const*, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, float*, unsigned long, unsigned long)
// PTX SHA256: 8f0f787cb46730c83c059e090f1f85bbcec571d9f4934efb987dec57ddf215fe
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void ernel__multiply_matrix_and_reduce_256u__synreal__BlockNonZeroEntry__glm__mat_3__3__float__(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70;
  __shared__ __align__(4) unsigned char _ZZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_PfmmE17reduction_storage[44];
  // PTX:27 ld.param.u64 %rd21, [_ZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_Pfmm_param_0]
  rd21 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:28 ld.param.u64 %rd29, [_ZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_Pfmm_param_1]
  rd29 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:29 ld.param.u64 %rd22, [_ZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_Pfmm_param_2]
  rd22 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:30 ld.param.u64 %rd23, [_ZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_Pfmm_param_3]
  rd23 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:31 ld.param.u64 %rd30, [_ZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_Pfmm_param_4]
  rd30 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:32 ld.param.u64 %rd24, [_ZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_Pfmm_param_5]
  rd24 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:33 ld.param.u64 %rd25, [_ZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_Pfmm_param_6]
  rd25 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:34 ld.param.u64 %rd26, [_ZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_Pfmm_param_7]
  rd26 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:35 ld.param.u64 %rd27, [_ZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_Pfmm_param_8]
  rd27 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:36 ld.param.u64 %rd28, [_ZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_Pfmm_param_9]
  rd28 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:37 cvta.to.global.u64 %rd1, %rd29
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd29));
  // PTX:38 cvta.to.global.u64 %rd2, %rd30
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd30));
  // PTX:39 mov.u32 %r42, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r42) : "r"(blockIdx.x));
  // PTX:40 cvt.u64.u32 %rd3, %r42
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd3) : "r"(r42));
  // PTX:41 mov.u32 %r43, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r43) : "r"(blockDim.x));
  // PTX:42 mul.wide.u32 %rd31, %r42, %r43
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd31) : "r"(r42), "r"(r43));
  // PTX:43 mov.u32 %r1, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r1) : "r"(threadIdx.x));
  // PTX:44 cvt.u64.u32 %rd32, %r1
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd32) : "r"(r1));
  // PTX:45 add.s64 %rd4, %rd31, %rd32
  asm("add.s64 %0, %1, %2;" : "=l"(rd4) : "l"(rd31), "l"(rd32));
  // PTX:46 setp.ge.u64 %p1, %rd4, %rd27
  p1 = (((unsigned long long)(rd4)) >= ((unsigned long long)(rd27)));
  // PTX:47 mov.f32 %f160, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f160) : );
  // PTX:48 @%p1 bra $L__BB8_24
  if (p1) { goto L_BB8_24; }
  // PTX:50 cvta.to.global.u64 %rd33, %rd23
  rd33 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd23));
  // PTX:51 mul.lo.s64 %rd34, %rd4, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd34) : "l"(rd4));
  // PTX:52 add.s64 %rd35, %rd33, %rd34
  asm("add.s64 %0, %1, %2;" : "=l"(rd35) : "l"(rd33), "l"(rd34));
  // PTX:53 mul.lo.s64 %rd36, %rd4, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd36) : "l"(rd4));
  // PTX:54 add.s64 %rd5, %rd2, %rd36
  asm("add.s64 %0, %1, %2;" : "=l"(rd5) : "l"(rd2), "l"(rd36));
  // PTX:55 ld.global.f32 %f19, [%rd5]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (0)))));
  // PTX:56 ld.global.f32 %f20, [%rd35]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (0)))));
  // PTX:57 ld.global.f32 %f21, [%rd5+4]
  f21 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (4)))));
  // PTX:58 ld.global.f32 %f22, [%rd35+12]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (12)))));
  // PTX:59 mul.f32 %f23, %f22, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f23) : "f"(f22), "f"(f21));
  // PTX:60 fma.rn.f32 %f24, %f20, %f19, %f23
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f24) : "f"(f20), "f"(f19), "f"(f23));
  // PTX:61 ld.global.f32 %f25, [%rd5+8]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (8)))));
  // PTX:62 ld.global.f32 %f26, [%rd35+24]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (24)))));
  // PTX:63 fma.rn.f32 %f1, %f26, %f25, %f24
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1) : "f"(f26), "f"(f25), "f"(f24));
  // PTX:64 ld.global.f32 %f27, [%rd35+4]
  f27 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (4)))));
  // PTX:65 ld.global.f32 %f28, [%rd35+16]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (16)))));
  // PTX:66 mul.f32 %f29, %f28, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f29) : "f"(f28), "f"(f21));
  // PTX:67 fma.rn.f32 %f30, %f27, %f19, %f29
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f30) : "f"(f27), "f"(f19), "f"(f29));
  // PTX:68 ld.global.f32 %f31, [%rd35+28]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (28)))));
  // PTX:69 fma.rn.f32 %f2, %f31, %f25, %f30
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f2) : "f"(f31), "f"(f25), "f"(f30));
  // PTX:70 ld.global.f32 %f32, [%rd35+8]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (8)))));
  // PTX:71 ld.global.f32 %f33, [%rd35+20]
  f33 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (20)))));
  // PTX:72 mul.f32 %f34, %f33, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f34) : "f"(f33), "f"(f21));
  // PTX:73 fma.rn.f32 %f35, %f32, %f19, %f34
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f35) : "f"(f32), "f"(f19), "f"(f34));
  // PTX:74 ld.global.f32 %f36, [%rd35+32]
  f36 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (32)))));
  // PTX:75 fma.rn.f32 %f3, %f36, %f25, %f35
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f3) : "f"(f36), "f"(f25), "f"(f35));
  // PTX:76 setp.eq.s64 %p2, %rd22, 0
  p2 = (((long long)(rd22)) == ((long long)(0)));
  // PTX:77 mov.u32 %r106, 0
  asm("mov.u32 %0, 0;" : "=r"(r106) : );
  // PTX:78 mov.u32 %r107, %r106
  asm("mov.u32 %0, %1;" : "=r"(r107) : "r"(r106));
  // PTX:79 mov.u32 %r108, %r106
  asm("mov.u32 %0, %1;" : "=r"(r108) : "r"(r106));
  // PTX:80 @%p2 bra $L__BB8_21
  if (p2) { goto L_BB8_21; }
  // PTX:82 setp.eq.s64 %p3, %rd28, 0
  p3 = (((long long)(rd28)) == ((long long)(0)));
  // PTX:83 mov.u64 %rd69, %rd4
  asm("mov.u64 %0, %1;" : "=l"(rd69) : "l"(rd4));
  // PTX:84 @%p3 bra $L__BB8_6
  if (p3) { goto L_BB8_6; }
  // PTX:86 or.b64 %rd37, %rd4, %rd28
  asm("or.b64 %0, %1, %2;" : "=l"(rd37) : "l"(rd4), "l"(rd28));
  // PTX:87 and.b64 %rd38, %rd37, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd38) : "l"(rd37));
  // PTX:88 setp.eq.s64 %p4, %rd38, 0
  p4 = (((long long)(rd38)) == ((long long)(0)));
  // PTX:89 @%p4 bra $L__BB8_5
  if (p4) { goto L_BB8_5; }
  // PTX:91 rem.u64 %rd69, %rd4, %rd28
  asm("rem.u64 %0, %1, %2;" : "=l"(rd69) : "l"(rd4), "l"(rd28));
  // PTX:92 bra.uni $L__BB8_6
  goto L_BB8_6;
  // PTX:94 $L__BB8_5:
L_BB8_5:;
  // PTX:95 cvt.u32.u64 %r47, %rd28
  asm("cvt.u32.u64 %0, %1;" : "=r"(r47) : "l"(rd28));
  // PTX:96 cvt.u32.u64 %r48, %rd4
  asm("cvt.u32.u64 %0, %1;" : "=r"(r48) : "l"(rd4));
  // PTX:97 rem.u32 %r49, %r48, %r47
  asm("rem.u32 %0, %1, %2;" : "=r"(r49) : "r"(r48), "r"(r47));
  // PTX:98 cvt.u64.u32 %rd69, %r49
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd69) : "r"(r49));
  // PTX:100 $L__BB8_6:
L_BB8_6:;
  // PTX:101 sub.s64 %rd9, %rd4, %rd69
  asm("sub.s64 %0, %1, %2;" : "=l"(rd9) : "l"(rd4), "l"(rd69));
  // PTX:102 cvta.to.global.u64 %rd39, %rd21
  rd39 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd21));
  // PTX:103 shl.b64 %rd40, %rd69, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd40) : "l"(rd69));
  // PTX:104 add.s64 %rd41, %rd39, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd41) : "l"(rd39), "l"(rd40));
  // PTX:105 ld.global.u32 %r53, [%rd41]
  r53 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (0)))));
  // PTX:106 mov.u32 %r106, 0
  asm("mov.u32 %0, 0;" : "=r"(r106) : );
  // PTX:107 max.s32 %r54, %r53, 0
  asm("max.s32 %0, %1, 0;" : "=r"(r54) : "r"(r53));
  // PTX:108 cvt.u32.u64 %r55, %rd22
  asm("cvt.u32.u64 %0, %1;" : "=r"(r55) : "l"(rd22));
  // PTX:109 min.s32 %r2, %r54, %r55
  asm("min.s32 %0, %1, %2;" : "=r"(r2) : "r"(r54), "r"(r55));
  // PTX:110 setp.lt.s32 %p5, %r2, 1
  p5 = (((int)(r2)) < ((int)(1)));
  // PTX:111 mov.u32 %r107, %r106
  asm("mov.u32 %0, %1;" : "=r"(r107) : "r"(r106));
  // PTX:112 mov.u32 %r108, %r106
  asm("mov.u32 %0, %1;" : "=r"(r108) : "r"(r106));
  // PTX:113 @%p5 bra $L__BB8_21
  if (p5) { goto L_BB8_21; }
  // PTX:115 and.b32 %r3, %r2, 1
  asm("and.b32 %0, %1, 1;" : "=r"(r3) : "r"(r2));
  // PTX:116 setp.eq.s32 %p6, %r2, 1
  p6 = (((int)(r2)) == ((int)(1)));
  // PTX:117 mov.u32 %r108, 0
  asm("mov.u32 %0, 0;" : "=r"(r108) : );
  // PTX:118 mov.u64 %rd70, 0
  asm("mov.u64 %0, 0;" : "=l"(rd70) : );
  // PTX:119 mov.u32 %r107, %r108
  asm("mov.u32 %0, %1;" : "=r"(r107) : "r"(r108));
  // PTX:120 mov.u32 %r106, %r108
  asm("mov.u32 %0, %1;" : "=r"(r106) : "r"(r108));
  // PTX:121 @%p6 bra $L__BB8_17
  if (p6) { goto L_BB8_17; }
  // PTX:123 sub.s32 %r93, %r2, %r3
  asm("sub.s32 %0, %1, %2;" : "=r"(r93) : "r"(r2), "r"(r3));
  // PTX:124 mov.u32 %r89, 0
  asm("mov.u32 %0, 0;" : "=r"(r89) : );
  // PTX:125 mov.u32 %r108, %r89
  asm("mov.u32 %0, %1;" : "=r"(r108) : "r"(r89));
  // PTX:126 mov.u32 %r107, %r89
  asm("mov.u32 %0, %1;" : "=r"(r107) : "r"(r89));
  // PTX:127 mov.u32 %r106, %r89
  asm("mov.u32 %0, %1;" : "=r"(r106) : "r"(r89));
  // PTX:129 $L__BB8_9:
L_BB8_9:;
  // PTX:130 cvt.s64.s32 %rd43, %r89
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd43) : "r"(r89));
  // PTX:131 mul.lo.s64 %rd44, %rd43, %rd28
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd44) : "l"(rd43), "l"(rd28));
  // PTX:132 add.s64 %rd45, %rd44, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd44), "l"(rd69));
  // PTX:133 mul.lo.s64 %rd46, %rd45, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd46) : "l"(rd45));
  // PTX:134 add.s64 %rd10, %rd1, %rd46
  asm("add.s64 %0, %1, %2;" : "=l"(rd10) : "l"(rd1), "l"(rd46));
  // PTX:135 ld.global.s32 %rd11, [%rd10]
  rd11 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (0)))));
  // PTX:136 setp.lt.s64 %p7, %rd11, 0
  p7 = (((long long)(rd11)) < ((long long)(0)));
  // PTX:137 setp.ge.u64 %p8, %rd11, %rd28
  p8 = (((unsigned long long)(rd11)) >= ((unsigned long long)(rd28)));
  // PTX:138 or.pred %p9, %p7, %p8
  p9 = ((p7) || (p8));
  // PTX:139 @%p9 bra $L__BB8_12
  if (p9) { goto L_BB8_12; }
  // PTX:141 add.s64 %rd12, %rd9, %rd11
  asm("add.s64 %0, %1, %2;" : "=l"(rd12) : "l"(rd9), "l"(rd11));
  // PTX:142 setp.ge.u64 %p10, %rd12, %rd27
  p10 = (((unsigned long long)(rd12)) >= ((unsigned long long)(rd27)));
  // PTX:143 @%p10 bra $L__BB8_12
  if (p10) { goto L_BB8_12; }
  // PTX:145 ld.global.f32 %f37, [%rd10+4]
  f37 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (4)))));
  // PTX:146 ld.global.f32 %f38, [%rd10+8]
  f38 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (8)))));
  // PTX:147 ld.global.f32 %f39, [%rd10+12]
  f39 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (12)))));
  // PTX:148 ld.global.f32 %f40, [%rd10+16]
  f40 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (16)))));
  // PTX:149 ld.global.f32 %f41, [%rd10+20]
  f41 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (20)))));
  // PTX:150 ld.global.f32 %f42, [%rd10+24]
  f42 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (24)))));
  // PTX:151 ld.global.f32 %f43, [%rd10+28]
  f43 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (28)))));
  // PTX:152 ld.global.f32 %f44, [%rd10+32]
  f44 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (32)))));
  // PTX:153 ld.global.f32 %f45, [%rd10+36]
  f45 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (36)))));
  // PTX:154 mul.lo.s64 %rd47, %rd12, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd47) : "l"(rd12));
  // PTX:155 add.s64 %rd48, %rd2, %rd47
  asm("add.s64 %0, %1, %2;" : "=l"(rd48) : "l"(rd2), "l"(rd47));
  // PTX:156 ld.global.f32 %f46, [%rd48]
  f46 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))));
  // PTX:157 ld.global.f32 %f47, [%rd48+4]
  f47 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (4)))));
  // PTX:158 mul.f32 %f48, %f40, %f47
  asm("mul.f32 %0, %1, %2;" : "=f"(f48) : "f"(f40), "f"(f47));
  // PTX:159 fma.rn.f32 %f49, %f37, %f46, %f48
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f49) : "f"(f37), "f"(f46), "f"(f48));
  // PTX:160 ld.global.f32 %f50, [%rd48+8]
  f50 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (8)))));
  // PTX:161 fma.rn.f32 %f51, %f43, %f50, %f49
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f51) : "f"(f43), "f"(f50), "f"(f49));
  // PTX:162 mul.f32 %f52, %f41, %f47
  asm("mul.f32 %0, %1, %2;" : "=f"(f52) : "f"(f41), "f"(f47));
  // PTX:163 fma.rn.f32 %f53, %f38, %f46, %f52
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f53) : "f"(f38), "f"(f46), "f"(f52));
  // PTX:164 fma.rn.f32 %f54, %f44, %f50, %f53
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f54) : "f"(f44), "f"(f50), "f"(f53));
  // PTX:165 mul.f32 %f55, %f42, %f47
  asm("mul.f32 %0, %1, %2;" : "=f"(f55) : "f"(f42), "f"(f47));
  // PTX:166 fma.rn.f32 %f56, %f39, %f46, %f55
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f56) : "f"(f39), "f"(f46), "f"(f55));
  // PTX:167 fma.rn.f32 %f57, %f45, %f50, %f56
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f57) : "f"(f45), "f"(f50), "f"(f56));
  // PTX:168 mov.b32 %f58, %r106
  asm("mov.b32 %0, %1;" : "=f"(f58) : "r"(r106));
  // PTX:169 add.f32 %f59, %f51, %f58
  asm("add.f32 %0, %1, %2;" : "=f"(f59) : "f"(f51), "f"(f58));
  // PTX:170 mov.b32 %f60, %r107
  asm("mov.b32 %0, %1;" : "=f"(f60) : "r"(r107));
  // PTX:171 add.f32 %f61, %f54, %f60
  asm("add.f32 %0, %1, %2;" : "=f"(f61) : "f"(f54), "f"(f60));
  // PTX:172 mov.b32 %f62, %r108
  asm("mov.b32 %0, %1;" : "=f"(f62) : "r"(r108));
  // PTX:173 add.f32 %f63, %f57, %f62
  asm("add.f32 %0, %1, %2;" : "=f"(f63) : "f"(f57), "f"(f62));
  // PTX:174 mov.b32 %r106, %f59
  asm("mov.b32 %0, %1;" : "=r"(r106) : "f"(f59));
  // PTX:175 mov.b32 %r107, %f61
  asm("mov.b32 %0, %1;" : "=r"(r107) : "f"(f61));
  // PTX:176 mov.b32 %r108, %f63
  asm("mov.b32 %0, %1;" : "=r"(r108) : "f"(f63));
  // PTX:178 $L__BB8_12:
L_BB8_12:;
  // PTX:179 add.s32 %r64, %r89, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r64) : "r"(r89));
  // PTX:180 cvt.s64.s32 %rd49, %r64
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd49) : "r"(r64));
  // PTX:181 mul.lo.s64 %rd50, %rd49, %rd28
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd49), "l"(rd28));
  // PTX:182 add.s64 %rd51, %rd50, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd51) : "l"(rd50), "l"(rd69));
  // PTX:183 mul.lo.s64 %rd52, %rd51, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd52) : "l"(rd51));
  // PTX:184 add.s64 %rd13, %rd1, %rd52
  asm("add.s64 %0, %1, %2;" : "=l"(rd13) : "l"(rd1), "l"(rd52));
  // PTX:185 ld.global.s32 %rd14, [%rd13]
  rd14 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))));
  // PTX:186 setp.lt.s64 %p11, %rd14, 0
  p11 = (((long long)(rd14)) < ((long long)(0)));
  // PTX:187 setp.ge.u64 %p12, %rd14, %rd28
  p12 = (((unsigned long long)(rd14)) >= ((unsigned long long)(rd28)));
  // PTX:188 or.pred %p13, %p11, %p12
  p13 = ((p11) || (p12));
  // PTX:189 @%p13 bra $L__BB8_15
  if (p13) { goto L_BB8_15; }
  // PTX:191 add.s64 %rd15, %rd9, %rd14
  asm("add.s64 %0, %1, %2;" : "=l"(rd15) : "l"(rd9), "l"(rd14));
  // PTX:192 setp.ge.u64 %p14, %rd15, %rd27
  p14 = (((unsigned long long)(rd15)) >= ((unsigned long long)(rd27)));
  // PTX:193 @%p14 bra $L__BB8_15
  if (p14) { goto L_BB8_15; }
  // PTX:195 ld.global.f32 %f64, [%rd13+4]
  f64 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4)))));
  // PTX:196 ld.global.f32 %f65, [%rd13+8]
  f65 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8)))));
  // PTX:197 ld.global.f32 %f66, [%rd13+12]
  f66 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (12)))));
  // PTX:198 ld.global.f32 %f67, [%rd13+16]
  f67 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (16)))));
  // PTX:199 ld.global.f32 %f68, [%rd13+20]
  f68 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (20)))));
  // PTX:200 ld.global.f32 %f69, [%rd13+24]
  f69 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (24)))));
  // PTX:201 ld.global.f32 %f70, [%rd13+28]
  f70 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (28)))));
  // PTX:202 ld.global.f32 %f71, [%rd13+32]
  f71 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (32)))));
  // PTX:203 ld.global.f32 %f72, [%rd13+36]
  f72 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (36)))));
  // PTX:204 mul.lo.s64 %rd53, %rd15, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd53) : "l"(rd15));
  // PTX:205 add.s64 %rd54, %rd2, %rd53
  asm("add.s64 %0, %1, %2;" : "=l"(rd54) : "l"(rd2), "l"(rd53));
  // PTX:206 ld.global.f32 %f73, [%rd54]
  f73 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))));
  // PTX:207 ld.global.f32 %f74, [%rd54+4]
  f74 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (4)))));
  // PTX:208 mul.f32 %f75, %f67, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f75) : "f"(f67), "f"(f74));
  // PTX:209 fma.rn.f32 %f76, %f64, %f73, %f75
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f76) : "f"(f64), "f"(f73), "f"(f75));
  // PTX:210 ld.global.f32 %f77, [%rd54+8]
  f77 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (8)))));
  // PTX:211 fma.rn.f32 %f78, %f70, %f77, %f76
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f78) : "f"(f70), "f"(f77), "f"(f76));
  // PTX:212 mul.f32 %f79, %f68, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f79) : "f"(f68), "f"(f74));
  // PTX:213 fma.rn.f32 %f80, %f65, %f73, %f79
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f80) : "f"(f65), "f"(f73), "f"(f79));
  // PTX:214 fma.rn.f32 %f81, %f71, %f77, %f80
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f81) : "f"(f71), "f"(f77), "f"(f80));
  // PTX:215 mul.f32 %f82, %f69, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f82) : "f"(f69), "f"(f74));
  // PTX:216 fma.rn.f32 %f83, %f66, %f73, %f82
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f83) : "f"(f66), "f"(f73), "f"(f82));
  // PTX:217 fma.rn.f32 %f84, %f72, %f77, %f83
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f84) : "f"(f72), "f"(f77), "f"(f83));
  // PTX:218 mov.b32 %f85, %r106
  asm("mov.b32 %0, %1;" : "=f"(f85) : "r"(r106));
  // PTX:219 add.f32 %f86, %f78, %f85
  asm("add.f32 %0, %1, %2;" : "=f"(f86) : "f"(f78), "f"(f85));
  // PTX:220 mov.b32 %f87, %r107
  asm("mov.b32 %0, %1;" : "=f"(f87) : "r"(r107));
  // PTX:221 add.f32 %f88, %f81, %f87
  asm("add.f32 %0, %1, %2;" : "=f"(f88) : "f"(f81), "f"(f87));
  // PTX:222 mov.b32 %f89, %r108
  asm("mov.b32 %0, %1;" : "=f"(f89) : "r"(r108));
  // PTX:223 add.f32 %f90, %f84, %f89
  asm("add.f32 %0, %1, %2;" : "=f"(f90) : "f"(f84), "f"(f89));
  // PTX:224 mov.b32 %r106, %f86
  asm("mov.b32 %0, %1;" : "=r"(r106) : "f"(f86));
  // PTX:225 mov.b32 %r107, %f88
  asm("mov.b32 %0, %1;" : "=r"(r107) : "f"(f88));
  // PTX:226 mov.b32 %r108, %f90
  asm("mov.b32 %0, %1;" : "=r"(r108) : "f"(f90));
  // PTX:228 $L__BB8_15:
L_BB8_15:;
  // PTX:229 add.s32 %r89, %r89, 2
  asm("add.s32 %0, %1, 2;" : "=r"(r89) : "r"(r89));
  // PTX:230 add.s32 %r93, %r93, -2
  asm("add.s32 %0, %1, -2;" : "=r"(r93) : "r"(r93));
  // PTX:231 setp.ne.s32 %p15, %r93, 0
  p15 = (((int)(r93)) != ((int)(0)));
  // PTX:232 @%p15 bra $L__BB8_9
  if (p15) { goto L_BB8_9; }
  // PTX:234 cvt.s64.s32 %rd70, %r89
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd70) : "r"(r89));
  // PTX:236 $L__BB8_17:
L_BB8_17:;
  // PTX:237 setp.eq.s32 %p16, %r3, 0
  p16 = (((int)(r3)) == ((int)(0)));
  // PTX:238 @%p16 bra $L__BB8_21
  if (p16) { goto L_BB8_21; }
  // PTX:240 mul.lo.s64 %rd55, %rd70, %rd28
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd55) : "l"(rd70), "l"(rd28));
  // PTX:241 add.s64 %rd56, %rd55, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd56) : "l"(rd55), "l"(rd69));
  // PTX:242 mul.lo.s64 %rd57, %rd56, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd57) : "l"(rd56));
  // PTX:243 add.s64 %rd18, %rd1, %rd57
  asm("add.s64 %0, %1, %2;" : "=l"(rd18) : "l"(rd1), "l"(rd57));
  // PTX:244 ld.global.s32 %rd19, [%rd18]
  rd19 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (0)))));
  // PTX:245 setp.lt.s64 %p17, %rd19, 0
  p17 = (((long long)(rd19)) < ((long long)(0)));
  // PTX:246 setp.ge.u64 %p18, %rd19, %rd28
  p18 = (((unsigned long long)(rd19)) >= ((unsigned long long)(rd28)));
  // PTX:247 or.pred %p19, %p17, %p18
  p19 = ((p17) || (p18));
  // PTX:248 @%p19 bra $L__BB8_21
  if (p19) { goto L_BB8_21; }
  // PTX:250 add.s64 %rd20, %rd9, %rd19
  asm("add.s64 %0, %1, %2;" : "=l"(rd20) : "l"(rd9), "l"(rd19));
  // PTX:251 setp.ge.u64 %p20, %rd20, %rd27
  p20 = (((unsigned long long)(rd20)) >= ((unsigned long long)(rd27)));
  // PTX:252 @%p20 bra $L__BB8_21
  if (p20) { goto L_BB8_21; }
  // PTX:254 ld.global.f32 %f91, [%rd18+4]
  f91 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (4)))));
  // PTX:255 ld.global.f32 %f92, [%rd18+8]
  f92 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (8)))));
  // PTX:256 ld.global.f32 %f93, [%rd18+12]
  f93 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (12)))));
  // PTX:257 ld.global.f32 %f94, [%rd18+16]
  f94 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (16)))));
  // PTX:258 ld.global.f32 %f95, [%rd18+20]
  f95 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (20)))));
  // PTX:259 ld.global.f32 %f96, [%rd18+24]
  f96 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (24)))));
  // PTX:260 ld.global.f32 %f97, [%rd18+28]
  f97 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (28)))));
  // PTX:261 ld.global.f32 %f98, [%rd18+32]
  f98 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (32)))));
  // PTX:262 ld.global.f32 %f99, [%rd18+36]
  f99 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (36)))));
  // PTX:263 mul.lo.s64 %rd58, %rd20, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd58) : "l"(rd20));
  // PTX:264 add.s64 %rd59, %rd2, %rd58
  asm("add.s64 %0, %1, %2;" : "=l"(rd59) : "l"(rd2), "l"(rd58));
  // PTX:265 ld.global.f32 %f100, [%rd59]
  f100 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))));
  // PTX:266 ld.global.f32 %f101, [%rd59+4]
  f101 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (4)))));
  // PTX:267 mul.f32 %f102, %f94, %f101
  asm("mul.f32 %0, %1, %2;" : "=f"(f102) : "f"(f94), "f"(f101));
  // PTX:268 fma.rn.f32 %f103, %f91, %f100, %f102
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f103) : "f"(f91), "f"(f100), "f"(f102));
  // PTX:269 ld.global.f32 %f104, [%rd59+8]
  f104 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (8)))));
  // PTX:270 fma.rn.f32 %f105, %f97, %f104, %f103
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f105) : "f"(f97), "f"(f104), "f"(f103));
  // PTX:271 mul.f32 %f106, %f95, %f101
  asm("mul.f32 %0, %1, %2;" : "=f"(f106) : "f"(f95), "f"(f101));
  // PTX:272 fma.rn.f32 %f107, %f92, %f100, %f106
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f107) : "f"(f92), "f"(f100), "f"(f106));
  // PTX:273 fma.rn.f32 %f108, %f98, %f104, %f107
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f108) : "f"(f98), "f"(f104), "f"(f107));
  // PTX:274 mul.f32 %f109, %f96, %f101
  asm("mul.f32 %0, %1, %2;" : "=f"(f109) : "f"(f96), "f"(f101));
  // PTX:275 fma.rn.f32 %f110, %f93, %f100, %f109
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f110) : "f"(f93), "f"(f100), "f"(f109));
  // PTX:276 fma.rn.f32 %f111, %f99, %f104, %f110
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f111) : "f"(f99), "f"(f104), "f"(f110));
  // PTX:277 mov.b32 %f112, %r106
  asm("mov.b32 %0, %1;" : "=f"(f112) : "r"(r106));
  // PTX:278 add.f32 %f113, %f105, %f112
  asm("add.f32 %0, %1, %2;" : "=f"(f113) : "f"(f105), "f"(f112));
  // PTX:279 mov.b32 %f114, %r107
  asm("mov.b32 %0, %1;" : "=f"(f114) : "r"(r107));
  // PTX:280 add.f32 %f115, %f108, %f114
  asm("add.f32 %0, %1, %2;" : "=f"(f115) : "f"(f108), "f"(f114));
  // PTX:281 mov.b32 %f116, %r108
  asm("mov.b32 %0, %1;" : "=f"(f116) : "r"(r108));
  // PTX:282 add.f32 %f117, %f111, %f116
  asm("add.f32 %0, %1, %2;" : "=f"(f117) : "f"(f111), "f"(f116));
  // PTX:283 mov.b32 %r106, %f113
  asm("mov.b32 %0, %1;" : "=r"(r106) : "f"(f113));
  // PTX:284 mov.b32 %r107, %f115
  asm("mov.b32 %0, %1;" : "=r"(r107) : "f"(f115));
  // PTX:285 mov.b32 %r108, %f117
  asm("mov.b32 %0, %1;" : "=r"(r108) : "f"(f117));
  // PTX:287 $L__BB8_21:
L_BB8_21:;
  // PTX:288 mov.b32 %f118, %r106
  asm("mov.b32 %0, %1;" : "=f"(f118) : "r"(r106));
  // PTX:289 add.f32 %f159, %f1, %f118
  asm("add.f32 %0, %1, %2;" : "=f"(f159) : "f"(f1), "f"(f118));
  // PTX:290 mov.b32 %f119, %r107
  asm("mov.b32 %0, %1;" : "=f"(f119) : "r"(r107));
  // PTX:291 add.f32 %f158, %f2, %f119
  asm("add.f32 %0, %1, %2;" : "=f"(f158) : "f"(f2), "f"(f119));
  // PTX:292 mov.b32 %f120, %r108
  asm("mov.b32 %0, %1;" : "=f"(f120) : "r"(r108));
  // PTX:293 add.f32 %f157, %f3, %f120
  asm("add.f32 %0, %1, %2;" : "=f"(f157) : "f"(f3), "f"(f120));
  // PTX:294 setp.eq.s64 %p21, %rd24, 0
  p21 = (((long long)(rd24)) == ((long long)(0)));
  // PTX:295 @%p21 bra $L__BB8_23
  if (p21) { goto L_BB8_23; }
  // PTX:297 cvta.to.global.u64 %rd60, %rd24
  rd60 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd24));
  // PTX:298 add.s64 %rd62, %rd60, %rd36
  asm("add.s64 %0, %1, %2;" : "=l"(rd62) : "l"(rd60), "l"(rd36));
  // PTX:299 ld.global.f32 %f121, [%rd62]
  f121 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))));
  // PTX:300 add.f32 %f159, %f159, %f121
  asm("add.f32 %0, %1, %2;" : "=f"(f159) : "f"(f159), "f"(f121));
  // PTX:301 ld.global.f32 %f122, [%rd62+4]
  f122 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (4)))));
  // PTX:302 add.f32 %f158, %f158, %f122
  asm("add.f32 %0, %1, %2;" : "=f"(f158) : "f"(f158), "f"(f122));
  // PTX:303 ld.global.f32 %f123, [%rd62+8]
  f123 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (8)))));
  // PTX:304 add.f32 %f157, %f157, %f123
  asm("add.f32 %0, %1, %2;" : "=f"(f157) : "f"(f157), "f"(f123));
  // PTX:306 $L__BB8_23:
L_BB8_23:;
  // PTX:307 cvta.to.global.u64 %rd63, %rd25
  rd63 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd25));
  // PTX:308 add.s64 %rd65, %rd63, %rd36
  asm("add.s64 %0, %1, %2;" : "=l"(rd65) : "l"(rd63), "l"(rd36));
  // PTX:309 st.global.f32 [%rd65], %f159
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (0))))) = (float)(f159);
  // PTX:310 st.global.f32 [%rd65+4], %f158
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (4))))) = (float)(f158);
  // PTX:311 st.global.f32 [%rd65+8], %f157
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (8))))) = (float)(f157);
  // PTX:312 ld.global.f32 %f124, [%rd5]
  f124 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (0)))));
  // PTX:313 ld.global.f32 %f125, [%rd5+4]
  f125 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (4)))));
  // PTX:314 mul.f32 %f126, %f158, %f125
  asm("mul.f32 %0, %1, %2;" : "=f"(f126) : "f"(f158), "f"(f125));
  // PTX:315 ld.global.f32 %f127, [%rd5+8]
  f127 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (8)))));
  // PTX:316 fma.rn.f32 %f128, %f159, %f124, %f126
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f128) : "f"(f159), "f"(f124), "f"(f126));
  // PTX:317 fma.rn.f32 %f160, %f157, %f127, %f128
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f160) : "f"(f157), "f"(f127), "f"(f128));
  // PTX:319 $L__BB8_24:
L_BB8_24:;
  // PTX:321 mov.u32 %r65, %laneid
  asm("mov.u32 %0, %1;" : "=r"(r65) : "r"((threadIdx.x & 31u)));
  // PTX:323 mov.u32 %r67, 1
  asm("mov.u32 %0, 1;" : "=r"(r67) : );
  // PTX:324 mov.u32 %r80, 31
  asm("mov.u32 %0, 31;" : "=r"(r80) : );
  // PTX:325 mov.u32 %r81, -1
  asm("mov.u32 %0, -1;" : "=r"(r81) : );
  // PTX:327 { .reg .f32 r0; .reg .pred p; shfl.sync.down.b32 r0|p, %f160, %r67, %r80, %r81; @p add.f32 r0, r0, %f160; mov.f32 %f129, r0;}
  asm volatile("{ .reg .f32 v; .reg .pred q; shfl.sync.down.b32 v|q, %1, %2, %3, %4; @q add.f32 v, v, %1; mov.f32 %0, v; }" : "=f"(f129) : "f"(f160), "r"(r67), "r"(r80), "r"(r81));
  // PTX:329 mov.u32 %r70, 2
  asm("mov.u32 %0, 2;" : "=r"(r70) : );
  // PTX:331 { .reg .f32 r0; .reg .pred p; shfl.sync.down.b32 r0|p, %f129, %r70, %r80, %r81; @p add.f32 r0, r0, %f129; mov.f32 %f132, r0;}
  asm volatile("{ .reg .f32 v; .reg .pred q; shfl.sync.down.b32 v|q, %1, %2, %3, %4; @q add.f32 v, v, %1; mov.f32 %0, v; }" : "=f"(f132) : "f"(f129), "r"(r70), "r"(r80), "r"(r81));
  // PTX:333 mov.u32 %r73, 4
  asm("mov.u32 %0, 4;" : "=r"(r73) : );
  // PTX:335 { .reg .f32 r0; .reg .pred p; shfl.sync.down.b32 r0|p, %f132, %r73, %r80, %r81; @p add.f32 r0, r0, %f132; mov.f32 %f135, r0;}
  asm volatile("{ .reg .f32 v; .reg .pred q; shfl.sync.down.b32 v|q, %1, %2, %3, %4; @q add.f32 v, v, %1; mov.f32 %0, v; }" : "=f"(f135) : "f"(f132), "r"(r73), "r"(r80), "r"(r81));
  // PTX:337 mov.u32 %r76, 8
  asm("mov.u32 %0, 8;" : "=r"(r76) : );
  // PTX:339 { .reg .f32 r0; .reg .pred p; shfl.sync.down.b32 r0|p, %f135, %r76, %r80, %r81; @p add.f32 r0, r0, %f135; mov.f32 %f138, r0;}
  asm volatile("{ .reg .f32 v; .reg .pred q; shfl.sync.down.b32 v|q, %1, %2, %3, %4; @q add.f32 v, v, %1; mov.f32 %0, v; }" : "=f"(f138) : "f"(f135), "r"(r76), "r"(r80), "r"(r81));
  // PTX:341 mov.u32 %r79, 16
  asm("mov.u32 %0, 16;" : "=r"(r79) : );
  // PTX:343 { .reg .f32 r0; .reg .pred p; shfl.sync.down.b32 r0|p, %f138, %r79, %r80, %r81; @p add.f32 r0, r0, %f138; mov.f32 %f161, r0;}
  asm volatile("{ .reg .f32 v; .reg .pred q; shfl.sync.down.b32 v|q, %1, %2, %3, %4; @q add.f32 v, v, %1; mov.f32 %0, v; }" : "=f"(f161) : "f"(f138), "r"(r79), "r"(r80), "r"(r81));
  // PTX:345 setp.ne.s32 %p22, %r65, 0
  p22 = (((int)(r65)) != ((int)(0)));
  // PTX:346 @%p22 bra $L__BB8_26
  if (p22) { goto L_BB8_26; }
  // PTX:348 shr.s32 %r82, %r1, 31
  asm("shr.s32 %0, %1, 31;" : "=r"(r82) : "r"(r1));
  // PTX:349 shr.u32 %r83, %r82, 27
  asm("shr.u32 %0, %1, 27;" : "=r"(r83) : "r"(r82));
  // PTX:350 add.s32 %r84, %r1, %r83
  asm("add.s32 %0, %1, %2;" : "=r"(r84) : "r"(r1), "r"(r83));
  // PTX:351 shr.s32 %r85, %r84, 5
  asm("shr.s32 %0, %1, 5;" : "=r"(r85) : "r"(r84));
  // PTX:352 shl.b32 %r86, %r85, 2
  asm("shl.b32 %0, %1, 2;" : "=r"(r86) : "r"(r85));
  // PTX:353 mov.u32 %r87, _ZZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_PfmmE17reduction_storage
  r87 = (unsigned)__cvta_generic_to_shared(_ZZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_PfmmE17reduction_storage);
  // PTX:354 add.s32 %r88, %r87, %r86
  asm("add.s32 %0, %1, %2;" : "=r"(r88) : "r"(r87), "r"(r86));
  // PTX:355 st.shared.f32 [%r88+8], %f161
  (*reinterpret_cast<volatile float*>(__cvta_shared_to_generic(((uintptr_t)(r88) + (8))))) = (float)(f161);
  // PTX:357 $L__BB8_26:
L_BB8_26:;
  // PTX:358 bar.sync 0
  __syncthreads();
  // PTX:359 setp.ne.s32 %p23, %r1, 0
  p23 = (((int)(r1)) != ((int)(0)));
  // PTX:360 @%p23 bra $L__BB8_28
  if (p23) { goto L_BB8_28; }
  // PTX:362 ld.shared.f32 %f144, [_ZZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_PfmmE17reduction_storage+12]
  f144 = (*reinterpret_cast<volatile float*>(__cvta_shared_to_generic(((uintptr_t)((unsigned)__cvta_generic_to_shared(_ZZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_PfmmE17reduction_storage)) + (12)))));
  // PTX:363 add.f32 %f145, %f161, %f144
  asm("add.f32 %0, %1, %2;" : "=f"(f145) : "f"(f161), "f"(f144));
  // PTX:364 ld.shared.f32 %f146, [_ZZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_PfmmE17reduction_storage+16]
  f146 = (*reinterpret_cast<volatile float*>(__cvta_shared_to_generic(((uintptr_t)((unsigned)__cvta_generic_to_shared(_ZZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_PfmmE17reduction_storage)) + (16)))));
  // PTX:365 add.f32 %f147, %f145, %f146
  asm("add.f32 %0, %1, %2;" : "=f"(f147) : "f"(f145), "f"(f146));
  // PTX:366 ld.shared.f32 %f148, [_ZZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_PfmmE17reduction_storage+20]
  f148 = (*reinterpret_cast<volatile float*>(__cvta_shared_to_generic(((uintptr_t)((unsigned)__cvta_generic_to_shared(_ZZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_PfmmE17reduction_storage)) + (20)))));
  // PTX:367 add.f32 %f149, %f147, %f148
  asm("add.f32 %0, %1, %2;" : "=f"(f149) : "f"(f147), "f"(f148));
  // PTX:368 ld.shared.f32 %f150, [_ZZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_PfmmE17reduction_storage+24]
  f150 = (*reinterpret_cast<volatile float*>(__cvta_shared_to_generic(((uintptr_t)((unsigned)__cvta_generic_to_shared(_ZZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_PfmmE17reduction_storage)) + (24)))));
  // PTX:369 add.f32 %f151, %f149, %f150
  asm("add.f32 %0, %1, %2;" : "=f"(f151) : "f"(f149), "f"(f150));
  // PTX:370 ld.shared.f32 %f152, [_ZZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_PfmmE17reduction_storage+28]
  f152 = (*reinterpret_cast<volatile float*>(__cvta_shared_to_generic(((uintptr_t)((unsigned)__cvta_generic_to_shared(_ZZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_PfmmE17reduction_storage)) + (28)))));
  // PTX:371 add.f32 %f153, %f151, %f152
  asm("add.f32 %0, %1, %2;" : "=f"(f153) : "f"(f151), "f"(f152));
  // PTX:372 ld.shared.f32 %f154, [_ZZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_PfmmE17reduction_storage+32]
  f154 = (*reinterpret_cast<volatile float*>(__cvta_shared_to_generic(((uintptr_t)((unsigned)__cvta_generic_to_shared(_ZZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_PfmmE17reduction_storage)) + (32)))));
  // PTX:373 add.f32 %f155, %f153, %f154
  asm("add.f32 %0, %1, %2;" : "=f"(f155) : "f"(f153), "f"(f154));
  // PTX:374 ld.shared.f32 %f156, [_ZZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_PfmmE17reduction_storage+36]
  f156 = (*reinterpret_cast<volatile float*>(__cvta_shared_to_generic(((uintptr_t)((unsigned)__cvta_generic_to_shared(_ZZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_PfmmE17reduction_storage)) + (36)))));
  // PTX:375 add.f32 %f161, %f155, %f156
  asm("add.f32 %0, %1, %2;" : "=f"(f161) : "f"(f155), "f"(f156));
  // PTX:377 $L__BB8_28:
L_BB8_28:;
  // PTX:378 @%p23 bra $L__BB8_30
  if (p23) { goto L_BB8_30; }
  // PTX:380 cvta.to.global.u64 %rd66, %rd26
  rd66 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd26));
  // PTX:381 shl.b64 %rd67, %rd3, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd67) : "l"(rd3));
  // PTX:382 add.s64 %rd68, %rd66, %rd67
  asm("add.s64 %0, %1, %2;" : "=l"(rd68) : "l"(rd66), "l"(rd67));
  // PTX:383 st.global.f32 [%rd68], %f161
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (0))))) = (float)(f161);
  // PTX:385 $L__BB8_30:
L_BB8_30:;
  // PTX:386 ret
  return;
}
