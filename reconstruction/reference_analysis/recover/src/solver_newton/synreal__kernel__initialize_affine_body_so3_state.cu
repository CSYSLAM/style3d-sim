// 机械还原自 PTX：synreal::kernel::initialize_affine_body_so3_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 879d1b671bc92c1f6ffd74088a2d79e35b9ac8efa007385c29d7b3a50ad0a242
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__initialize_affine_body_so3_state(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121, r122, r123, r124, r125, r126, r127, r128, r129, r130, r131, r132, r133, r134, r135, r136, r137, r138, r139, r140, r141, r142, r143, r144, r145, r146;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37;
  // PTX:23 ld.param.u64 %rd8, [_ZN7synreal6kernel32initialize_affine_body_so3_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPNS1_3matILi3ELi3EfLS3_0EEESC_mmm_param_0]
  rd8 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:24 ld.param.u64 %rd9, [_ZN7synreal6kernel32initialize_affine_body_so3_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPNS1_3matILi3ELi3EfLS3_0EEESC_mmm_param_1]
  rd9 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:25 ld.param.u64 %rd10, [_ZN7synreal6kernel32initialize_affine_body_so3_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPNS1_3matILi3ELi3EfLS3_0EEESC_mmm_param_2]
  rd10 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:26 ld.param.u64 %rd11, [_ZN7synreal6kernel32initialize_affine_body_so3_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPNS1_3matILi3ELi3EfLS3_0EEESC_mmm_param_3]
  rd11 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:27 ld.param.u64 %rd14, [_ZN7synreal6kernel32initialize_affine_body_so3_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPNS1_3matILi3ELi3EfLS3_0EEESC_mmm_param_4]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:28 ld.param.u64 %rd12, [_ZN7synreal6kernel32initialize_affine_body_so3_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPNS1_3matILi3ELi3EfLS3_0EEESC_mmm_param_5]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:29 ld.param.u64 %rd13, [_ZN7synreal6kernel32initialize_affine_body_so3_stateEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPNS1_3matILi3ELi3EfLS3_0EEESC_mmm_param_6]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:30 mov.u32 %r60, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r60) : "r"(blockIdx.x));
  // PTX:31 mov.u32 %r61, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r61) : "r"(blockDim.x));
  // PTX:32 mul.wide.u32 %rd15, %r60, %r61
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd15) : "r"(r60), "r"(r61));
  // PTX:33 mov.u32 %r62, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r62) : "r"(threadIdx.x));
  // PTX:34 cvt.u64.u32 %rd16, %r62
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd16) : "r"(r62));
  // PTX:35 add.s64 %rd1, %rd15, %rd16
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd15), "l"(rd16));
  // PTX:36 setp.ge.u64 %p1, %rd1, %rd14
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd14)));
  // PTX:37 @%p1 bra $L__BB15_22
  if (p1) { goto L_BB15_22; }
  // PTX:39 or.b64 %rd17, %rd1, %rd12
  asm("or.b64 %0, %1, %2;" : "=l"(rd17) : "l"(rd1), "l"(rd12));
  // PTX:40 and.b64 %rd18, %rd17, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd18) : "l"(rd17));
  // PTX:41 setp.eq.s64 %p2, %rd18, 0
  p2 = (((long long)(rd18)) == ((long long)(0)));
  // PTX:42 @%p2 bra $L__BB15_3
  if (p2) { goto L_BB15_3; }
  // PTX:44 div.u64 %rd36, %rd1, %rd12
  asm("div.u64 %0, %1, %2;" : "=l"(rd36) : "l"(rd1), "l"(rd12));
  // PTX:45 mul.lo.s64 %rd19, %rd36, %rd12
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd36), "l"(rd12));
  // PTX:46 sub.s64 %rd37, %rd1, %rd19
  asm("sub.s64 %0, %1, %2;" : "=l"(rd37) : "l"(rd1), "l"(rd19));
  // PTX:47 bra.uni $L__BB15_4
  goto L_BB15_4;
  // PTX:49 $L__BB15_3:
L_BB15_3:;
  // PTX:50 cvt.u32.u64 %r63, %rd12
  asm("cvt.u32.u64 %0, %1;" : "=r"(r63) : "l"(rd12));
  // PTX:51 cvt.u32.u64 %r64, %rd1
  asm("cvt.u32.u64 %0, %1;" : "=r"(r64) : "l"(rd1));
  // PTX:52 div.u32 %r65, %r64, %r63
  asm("div.u32 %0, %1, %2;" : "=r"(r65) : "r"(r64), "r"(r63));
  // PTX:53 mul.lo.s32 %r66, %r65, %r63
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r66) : "r"(r65), "r"(r63));
  // PTX:54 sub.s32 %r67, %r64, %r66
  asm("sub.s32 %0, %1, %2;" : "=r"(r67) : "r"(r64), "r"(r66));
  // PTX:55 cvt.u64.u32 %rd36, %r65
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd36) : "r"(r65));
  // PTX:56 cvt.u64.u32 %rd37, %r67
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd37) : "r"(r67));
  // PTX:58 $L__BB15_4:
L_BB15_4:;
  // PTX:59 cvta.to.global.u64 %rd20, %rd8
  rd20 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd8));
  // PTX:60 mul.lo.s64 %rd21, %rd36, %rd13
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd21) : "l"(rd36), "l"(rd13));
  // PTX:61 cvt.u32.u64 %r77, %rd21
  asm("cvt.u32.u64 %0, %1;" : "=r"(r77) : "l"(rd21));
  // PTX:62 cvta.to.global.u64 %rd22, %rd9
  rd22 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd9));
  // PTX:63 shl.b64 %rd23, %rd37, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd23) : "l"(rd37));
  // PTX:64 add.s64 %rd24, %rd22, %rd23
  asm("add.s64 %0, %1, %2;" : "=l"(rd24) : "l"(rd22), "l"(rd23));
  // PTX:65 ld.global.u32 %r78, [%rd24+4]
  r78 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (4)))));
  // PTX:66 add.s32 %r79, %r78, %r77
  asm("add.s32 %0, %1, %2;" : "=r"(r79) : "r"(r78), "r"(r77));
  // PTX:67 ld.global.u32 %r80, [%rd24+8]
  r80 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (8)))));
  // PTX:68 add.s32 %r81, %r80, %r77
  asm("add.s32 %0, %1, %2;" : "=r"(r81) : "r"(r80), "r"(r77));
  // PTX:69 ld.global.u32 %r82, [%rd24+12]
  r82 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (12)))));
  // PTX:70 add.s32 %r83, %r82, %r77
  asm("add.s32 %0, %1, %2;" : "=r"(r83) : "r"(r82), "r"(r77));
  // PTX:71 mul.wide.s32 %rd25, %r79, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd25) : "r"(r79));
  // PTX:72 add.s64 %rd26, %rd20, %rd25
  asm("add.s64 %0, %1, %2;" : "=l"(rd26) : "l"(rd20), "l"(rd25));
  // PTX:73 mul.wide.s32 %rd27, %r81, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd27) : "r"(r81));
  // PTX:74 add.s64 %rd28, %rd20, %rd27
  asm("add.s64 %0, %1, %2;" : "=l"(rd28) : "l"(rd20), "l"(rd27));
  // PTX:75 mul.wide.s32 %rd29, %r83, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd29) : "r"(r83));
  // PTX:76 add.s64 %rd30, %rd20, %rd29
  asm("add.s64 %0, %1, %2;" : "=l"(rd30) : "l"(rd20), "l"(rd29));
  // PTX:77 ld.global.f32 %f1, [%rd26]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (0)))));
  // PTX:78 ld.global.f32 %f2, [%rd26+4]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (4)))));
  // PTX:79 mul.f32 %f82, %f2, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f82) : "f"(f2), "f"(f2));
  // PTX:80 ld.global.f32 %f3, [%rd26+8]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (8)))));
  // PTX:81 fma.rn.f32 %f83, %f1, %f1, %f82
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f83) : "f"(f1), "f"(f1), "f"(f82));
  // PTX:82 fma.rn.f32 %f84, %f3, %f3, %f83
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f84) : "f"(f3), "f"(f3), "f"(f83));
  // PTX:83 ld.global.f32 %f4, [%rd28]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (0)))));
  // PTX:84 ld.global.f32 %f5, [%rd28+4]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (4)))));
  // PTX:85 mul.f32 %f85, %f5, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f85) : "f"(f5), "f"(f5));
  // PTX:86 ld.global.f32 %f6, [%rd28+8]
  f6 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (8)))));
  // PTX:87 fma.rn.f32 %f86, %f4, %f4, %f85
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f86) : "f"(f4), "f"(f4), "f"(f85));
  // PTX:88 fma.rn.f32 %f87, %f6, %f6, %f86
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f87) : "f"(f6), "f"(f6), "f"(f86));
  // PTX:89 add.f32 %f88, %f84, %f87
  asm("add.f32 %0, %1, %2;" : "=f"(f88) : "f"(f84), "f"(f87));
  // PTX:90 ld.global.f32 %f7, [%rd30]
  f7 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0)))));
  // PTX:91 ld.global.f32 %f8, [%rd30+4]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (4)))));
  // PTX:92 mul.f32 %f89, %f8, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f89) : "f"(f8), "f"(f8));
  // PTX:93 ld.global.f32 %f9, [%rd30+8]
  f9 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (8)))));
  // PTX:94 fma.rn.f32 %f90, %f7, %f7, %f89
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f90) : "f"(f7), "f"(f7), "f"(f89));
  // PTX:95 fma.rn.f32 %f91, %f9, %f9, %f90
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f91) : "f"(f9), "f"(f9), "f"(f90));
  // PTX:96 add.f32 %f92, %f88, %f91
  asm("add.f32 %0, %1, %2;" : "=f"(f92) : "f"(f88), "f"(f91));
  // PTX:97 div.rn.f32 %f93, %f92, 0f40400000
  asm("div.rn.f32 %0, %1, 0f40400000;" : "=f"(f93) : "f"(f92));
  // PTX:98 sqrt.rn.f32 %f10, %f93
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f10) : "f"(f93));
  // PTX:99 setp.leu.f32 %p3, %f10, 0f322BCC77
  p3 = ((isnan(((float)(f10))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f10)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:100 mov.u32 %r138, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r138) : );
  // PTX:101 mov.u32 %r70, 0
  asm("mov.u32 %0, 0;" : "=r"(r70) : );
  // PTX:102 mov.u32 %r139, %r70
  asm("mov.u32 %0, %1;" : "=r"(r139) : "r"(r70));
  // PTX:103 mov.u32 %r140, %r70
  asm("mov.u32 %0, %1;" : "=r"(r140) : "r"(r70));
  // PTX:104 mov.u32 %r141, %r70
  asm("mov.u32 %0, %1;" : "=r"(r141) : "r"(r70));
  // PTX:105 mov.u32 %r142, %r138
  asm("mov.u32 %0, %1;" : "=r"(r142) : "r"(r138));
  // PTX:106 mov.u32 %r143, %r70
  asm("mov.u32 %0, %1;" : "=r"(r143) : "r"(r70));
  // PTX:107 mov.u32 %r144, %r70
  asm("mov.u32 %0, %1;" : "=r"(r144) : "r"(r70));
  // PTX:108 mov.u32 %r145, %r70
  asm("mov.u32 %0, %1;" : "=r"(r145) : "r"(r70));
  // PTX:109 mov.u32 %r146, %r138
  asm("mov.u32 %0, %1;" : "=r"(r146) : "r"(r138));
  // PTX:110 @%p3 bra $L__BB15_21
  if (p3) { goto L_BB15_21; }
  // PTX:112 abs.f32 %f94, %f10
  asm("abs.f32 %0, %1;" : "=f"(f94) : "f"(f10));
  // PTX:113 setp.geu.f32 %p4, %f94, 0f7F800000
  p4 = ((isnan(((float)(f94))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f94)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:114 @%p4 bra $L__BB15_21
  if (p4) { goto L_BB15_21; }
  // PTX:116 rcp.rn.f32 %f95, %f10
  asm("rcp.rn.f32 %0, %1;" : "=f"(f95) : "f"(f10));
  // PTX:117 mul.f32 %f226, %f1, %f95
  asm("mul.f32 %0, %1, %2;" : "=f"(f226) : "f"(f1), "f"(f95));
  // PTX:118 mul.f32 %f227, %f2, %f95
  asm("mul.f32 %0, %1, %2;" : "=f"(f227) : "f"(f2), "f"(f95));
  // PTX:119 mul.f32 %f228, %f3, %f95
  asm("mul.f32 %0, %1, %2;" : "=f"(f228) : "f"(f3), "f"(f95));
  // PTX:120 mul.f32 %f229, %f4, %f95
  asm("mul.f32 %0, %1, %2;" : "=f"(f229) : "f"(f4), "f"(f95));
  // PTX:121 mul.f32 %f230, %f5, %f95
  asm("mul.f32 %0, %1, %2;" : "=f"(f230) : "f"(f5), "f"(f95));
  // PTX:122 mul.f32 %f231, %f6, %f95
  asm("mul.f32 %0, %1, %2;" : "=f"(f231) : "f"(f6), "f"(f95));
  // PTX:123 mul.f32 %f232, %f7, %f95
  asm("mul.f32 %0, %1, %2;" : "=f"(f232) : "f"(f7), "f"(f95));
  // PTX:124 mul.f32 %f233, %f8, %f95
  asm("mul.f32 %0, %1, %2;" : "=f"(f233) : "f"(f8), "f"(f95));
  // PTX:125 mul.f32 %f234, %f9, %f95
  asm("mul.f32 %0, %1, %2;" : "=f"(f234) : "f"(f9), "f"(f95));
  // PTX:126 mov.u32 %r122, 0
  asm("mov.u32 %0, 0;" : "=r"(r122) : );
  // PTX:128 $L__BB15_7:
L_BB15_7:;
  // PTX:129 mul.f32 %f96, %f231, %f233
  asm("mul.f32 %0, %1, %2;" : "=f"(f96) : "f"(f231), "f"(f233));
  // PTX:130 mul.f32 %f97, %f230, %f234
  asm("mul.f32 %0, %1, %2;" : "=f"(f97) : "f"(f230), "f"(f234));
  // PTX:131 sub.f32 %f29, %f97, %f96
  asm("sub.f32 %0, %1, %2;" : "=f"(f29) : "f"(f97), "f"(f96));
  // PTX:132 mul.f32 %f98, %f229, %f234
  asm("mul.f32 %0, %1, %2;" : "=f"(f98) : "f"(f229), "f"(f234));
  // PTX:133 mul.f32 %f99, %f231, %f232
  asm("mul.f32 %0, %1, %2;" : "=f"(f99) : "f"(f231), "f"(f232));
  // PTX:134 sub.f32 %f30, %f99, %f98
  asm("sub.f32 %0, %1, %2;" : "=f"(f30) : "f"(f99), "f"(f98));
  // PTX:135 mul.f32 %f100, %f230, %f232
  asm("mul.f32 %0, %1, %2;" : "=f"(f100) : "f"(f230), "f"(f232));
  // PTX:136 mul.f32 %f101, %f229, %f233
  asm("mul.f32 %0, %1, %2;" : "=f"(f101) : "f"(f229), "f"(f233));
  // PTX:137 sub.f32 %f31, %f101, %f100
  asm("sub.f32 %0, %1, %2;" : "=f"(f31) : "f"(f101), "f"(f100));
  // PTX:138 mul.f32 %f102, %f227, %f30
  asm("mul.f32 %0, %1, %2;" : "=f"(f102) : "f"(f227), "f"(f30));
  // PTX:139 fma.rn.f32 %f103, %f226, %f29, %f102
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f103) : "f"(f226), "f"(f29), "f"(f102));
  // PTX:140 fma.rn.f32 %f32, %f228, %f31, %f103
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f32) : "f"(f228), "f"(f31), "f"(f103));
  // PTX:141 abs.f32 %f104, %f32
  asm("abs.f32 %0, %1;" : "=f"(f104) : "f"(f32));
  // PTX:142 setp.le.f32 %p5, %f104, 0f2EDBE6FF
  p5 = (!(isnan(((float)(f104))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f104)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:143 setp.geu.f32 %p6, %f104, 0f7F800000
  p6 = ((isnan(((float)(f104))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f104)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:144 or.pred %p7, %p5, %p6
  p7 = ((p5) || (p6));
  // PTX:145 @%p7 bra $L__BB15_10
  if (p7) { goto L_BB15_10; }
  // PTX:147 rcp.rn.f32 %f105, %f32
  asm("rcp.rn.f32 %0, %1;" : "=f"(f105) : "f"(f32));
  // PTX:148 mul.f32 %f106, %f227, %f234
  asm("mul.f32 %0, %1, %2;" : "=f"(f106) : "f"(f227), "f"(f234));
  // PTX:149 mul.f32 %f107, %f228, %f233
  asm("mul.f32 %0, %1, %2;" : "=f"(f107) : "f"(f228), "f"(f233));
  // PTX:150 sub.f32 %f108, %f107, %f106
  asm("sub.f32 %0, %1, %2;" : "=f"(f108) : "f"(f107), "f"(f106));
  // PTX:151 mul.f32 %f109, %f228, %f232
  asm("mul.f32 %0, %1, %2;" : "=f"(f109) : "f"(f228), "f"(f232));
  // PTX:152 mul.f32 %f110, %f226, %f234
  asm("mul.f32 %0, %1, %2;" : "=f"(f110) : "f"(f226), "f"(f234));
  // PTX:153 sub.f32 %f111, %f110, %f109
  asm("sub.f32 %0, %1, %2;" : "=f"(f111) : "f"(f110), "f"(f109));
  // PTX:154 mul.f32 %f112, %f226, %f233
  asm("mul.f32 %0, %1, %2;" : "=f"(f112) : "f"(f226), "f"(f233));
  // PTX:155 mul.f32 %f113, %f227, %f232
  asm("mul.f32 %0, %1, %2;" : "=f"(f113) : "f"(f227), "f"(f232));
  // PTX:156 sub.f32 %f114, %f113, %f112
  asm("sub.f32 %0, %1, %2;" : "=f"(f114) : "f"(f113), "f"(f112));
  // PTX:157 mul.f32 %f115, %f228, %f230
  asm("mul.f32 %0, %1, %2;" : "=f"(f115) : "f"(f228), "f"(f230));
  // PTX:158 mul.f32 %f116, %f227, %f231
  asm("mul.f32 %0, %1, %2;" : "=f"(f116) : "f"(f227), "f"(f231));
  // PTX:159 sub.f32 %f117, %f116, %f115
  asm("sub.f32 %0, %1, %2;" : "=f"(f117) : "f"(f116), "f"(f115));
  // PTX:160 mul.f32 %f118, %f226, %f231
  asm("mul.f32 %0, %1, %2;" : "=f"(f118) : "f"(f226), "f"(f231));
  // PTX:161 mul.f32 %f119, %f228, %f229
  asm("mul.f32 %0, %1, %2;" : "=f"(f119) : "f"(f228), "f"(f229));
  // PTX:162 sub.f32 %f120, %f119, %f118
  asm("sub.f32 %0, %1, %2;" : "=f"(f120) : "f"(f119), "f"(f118));
  // PTX:163 mul.f32 %f121, %f227, %f229
  asm("mul.f32 %0, %1, %2;" : "=f"(f121) : "f"(f227), "f"(f229));
  // PTX:164 mul.f32 %f122, %f226, %f230
  asm("mul.f32 %0, %1, %2;" : "=f"(f122) : "f"(f226), "f"(f230));
  // PTX:165 sub.f32 %f123, %f122, %f121
  asm("sub.f32 %0, %1, %2;" : "=f"(f123) : "f"(f122), "f"(f121));
  // PTX:166 fma.rn.f32 %f124, %f29, %f105, %f226
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f124) : "f"(f29), "f"(f105), "f"(f226));
  // PTX:167 fma.rn.f32 %f125, %f30, %f105, %f227
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f125) : "f"(f30), "f"(f105), "f"(f227));
  // PTX:168 fma.rn.f32 %f126, %f31, %f105, %f228
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f126) : "f"(f31), "f"(f105), "f"(f228));
  // PTX:169 fma.rn.f32 %f127, %f108, %f105, %f229
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f127) : "f"(f108), "f"(f105), "f"(f229));
  // PTX:170 fma.rn.f32 %f128, %f111, %f105, %f230
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f128) : "f"(f111), "f"(f105), "f"(f230));
  // PTX:171 fma.rn.f32 %f129, %f114, %f105, %f231
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f129) : "f"(f114), "f"(f105), "f"(f231));
  // PTX:172 fma.rn.f32 %f130, %f117, %f105, %f232
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f130) : "f"(f117), "f"(f105), "f"(f232));
  // PTX:173 fma.rn.f32 %f131, %f120, %f105, %f233
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f131) : "f"(f120), "f"(f105), "f"(f233));
  // PTX:174 fma.rn.f32 %f132, %f123, %f105, %f234
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f132) : "f"(f123), "f"(f105), "f"(f234));
  // PTX:175 mul.f32 %f226, %f124, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f226) : "f"(f124));
  // PTX:176 mul.f32 %f227, %f125, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f227) : "f"(f125));
  // PTX:177 mul.f32 %f228, %f126, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f228) : "f"(f126));
  // PTX:178 mul.f32 %f229, %f127, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f229) : "f"(f127));
  // PTX:179 mul.f32 %f230, %f128, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f230) : "f"(f128));
  // PTX:180 mul.f32 %f231, %f129, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f231) : "f"(f129));
  // PTX:181 mul.f32 %f232, %f130, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f232) : "f"(f130));
  // PTX:182 mul.f32 %f233, %f131, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f233) : "f"(f131));
  // PTX:183 mul.f32 %f234, %f132, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f234) : "f"(f132));
  // PTX:184 mul.f32 %f133, %f230, %f234
  asm("mul.f32 %0, %1, %2;" : "=f"(f133) : "f"(f230), "f"(f234));
  // PTX:185 mul.f32 %f134, %f231, %f233
  asm("mul.f32 %0, %1, %2;" : "=f"(f134) : "f"(f231), "f"(f233));
  // PTX:186 sub.f32 %f42, %f133, %f134
  asm("sub.f32 %0, %1, %2;" : "=f"(f42) : "f"(f133), "f"(f134));
  // PTX:187 mul.f32 %f135, %f231, %f232
  asm("mul.f32 %0, %1, %2;" : "=f"(f135) : "f"(f231), "f"(f232));
  // PTX:188 mul.f32 %f136, %f229, %f234
  asm("mul.f32 %0, %1, %2;" : "=f"(f136) : "f"(f229), "f"(f234));
  // PTX:189 sub.f32 %f43, %f135, %f136
  asm("sub.f32 %0, %1, %2;" : "=f"(f43) : "f"(f135), "f"(f136));
  // PTX:190 mul.f32 %f137, %f229, %f233
  asm("mul.f32 %0, %1, %2;" : "=f"(f137) : "f"(f229), "f"(f233));
  // PTX:191 mul.f32 %f138, %f230, %f232
  asm("mul.f32 %0, %1, %2;" : "=f"(f138) : "f"(f230), "f"(f232));
  // PTX:192 sub.f32 %f44, %f137, %f138
  asm("sub.f32 %0, %1, %2;" : "=f"(f44) : "f"(f137), "f"(f138));
  // PTX:193 mul.f32 %f139, %f227, %f43
  asm("mul.f32 %0, %1, %2;" : "=f"(f139) : "f"(f227), "f"(f43));
  // PTX:194 fma.rn.f32 %f140, %f226, %f42, %f139
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f140) : "f"(f226), "f"(f42), "f"(f139));
  // PTX:195 fma.rn.f32 %f45, %f228, %f44, %f140
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f45) : "f"(f228), "f"(f44), "f"(f140));
  // PTX:196 abs.f32 %f141, %f45
  asm("abs.f32 %0, %1;" : "=f"(f141) : "f"(f45));
  // PTX:197 setp.le.f32 %p8, %f141, 0f2EDBE6FF
  p8 = (!(isnan(((float)(f141))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f141)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:198 setp.geu.f32 %p9, %f141, 0f7F800000
  p9 = ((isnan(((float)(f141))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f141)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:199 or.pred %p10, %p8, %p9
  p10 = ((p8) || (p9));
  // PTX:200 @%p10 bra $L__BB15_10
  if (p10) { goto L_BB15_10; }
  // PTX:202 rcp.rn.f32 %f142, %f45
  asm("rcp.rn.f32 %0, %1;" : "=f"(f142) : "f"(f45));
  // PTX:203 mul.f32 %f143, %f227, %f234
  asm("mul.f32 %0, %1, %2;" : "=f"(f143) : "f"(f227), "f"(f234));
  // PTX:204 mul.f32 %f144, %f228, %f233
  asm("mul.f32 %0, %1, %2;" : "=f"(f144) : "f"(f228), "f"(f233));
  // PTX:205 sub.f32 %f145, %f144, %f143
  asm("sub.f32 %0, %1, %2;" : "=f"(f145) : "f"(f144), "f"(f143));
  // PTX:206 mul.f32 %f146, %f228, %f232
  asm("mul.f32 %0, %1, %2;" : "=f"(f146) : "f"(f228), "f"(f232));
  // PTX:207 mul.f32 %f147, %f226, %f234
  asm("mul.f32 %0, %1, %2;" : "=f"(f147) : "f"(f226), "f"(f234));
  // PTX:208 sub.f32 %f148, %f147, %f146
  asm("sub.f32 %0, %1, %2;" : "=f"(f148) : "f"(f147), "f"(f146));
  // PTX:209 mul.f32 %f149, %f226, %f233
  asm("mul.f32 %0, %1, %2;" : "=f"(f149) : "f"(f226), "f"(f233));
  // PTX:210 mul.f32 %f150, %f227, %f232
  asm("mul.f32 %0, %1, %2;" : "=f"(f150) : "f"(f227), "f"(f232));
  // PTX:211 sub.f32 %f151, %f150, %f149
  asm("sub.f32 %0, %1, %2;" : "=f"(f151) : "f"(f150), "f"(f149));
  // PTX:212 mul.f32 %f152, %f228, %f230
  asm("mul.f32 %0, %1, %2;" : "=f"(f152) : "f"(f228), "f"(f230));
  // PTX:213 mul.f32 %f153, %f227, %f231
  asm("mul.f32 %0, %1, %2;" : "=f"(f153) : "f"(f227), "f"(f231));
  // PTX:214 sub.f32 %f154, %f153, %f152
  asm("sub.f32 %0, %1, %2;" : "=f"(f154) : "f"(f153), "f"(f152));
  // PTX:215 mul.f32 %f155, %f226, %f231
  asm("mul.f32 %0, %1, %2;" : "=f"(f155) : "f"(f226), "f"(f231));
  // PTX:216 mul.f32 %f156, %f228, %f229
  asm("mul.f32 %0, %1, %2;" : "=f"(f156) : "f"(f228), "f"(f229));
  // PTX:217 sub.f32 %f157, %f156, %f155
  asm("sub.f32 %0, %1, %2;" : "=f"(f157) : "f"(f156), "f"(f155));
  // PTX:218 mul.f32 %f158, %f227, %f229
  asm("mul.f32 %0, %1, %2;" : "=f"(f158) : "f"(f227), "f"(f229));
  // PTX:219 mul.f32 %f159, %f226, %f230
  asm("mul.f32 %0, %1, %2;" : "=f"(f159) : "f"(f226), "f"(f230));
  // PTX:220 sub.f32 %f160, %f159, %f158
  asm("sub.f32 %0, %1, %2;" : "=f"(f160) : "f"(f159), "f"(f158));
  // PTX:221 fma.rn.f32 %f161, %f42, %f142, %f226
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f161) : "f"(f42), "f"(f142), "f"(f226));
  // PTX:222 fma.rn.f32 %f162, %f43, %f142, %f227
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f162) : "f"(f43), "f"(f142), "f"(f227));
  // PTX:223 fma.rn.f32 %f163, %f44, %f142, %f228
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f163) : "f"(f44), "f"(f142), "f"(f228));
  // PTX:224 fma.rn.f32 %f164, %f145, %f142, %f229
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f164) : "f"(f145), "f"(f142), "f"(f229));
  // PTX:225 fma.rn.f32 %f165, %f148, %f142, %f230
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f165) : "f"(f148), "f"(f142), "f"(f230));
  // PTX:226 fma.rn.f32 %f166, %f151, %f142, %f231
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f166) : "f"(f151), "f"(f142), "f"(f231));
  // PTX:227 fma.rn.f32 %f167, %f154, %f142, %f232
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f167) : "f"(f154), "f"(f142), "f"(f232));
  // PTX:228 fma.rn.f32 %f168, %f157, %f142, %f233
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f168) : "f"(f157), "f"(f142), "f"(f233));
  // PTX:229 fma.rn.f32 %f169, %f160, %f142, %f234
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f169) : "f"(f160), "f"(f142), "f"(f234));
  // PTX:230 mul.f32 %f226, %f161, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f226) : "f"(f161));
  // PTX:231 mul.f32 %f227, %f162, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f227) : "f"(f162));
  // PTX:232 mul.f32 %f228, %f163, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f228) : "f"(f163));
  // PTX:233 mul.f32 %f229, %f164, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f229) : "f"(f164));
  // PTX:234 mul.f32 %f230, %f165, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f230) : "f"(f165));
  // PTX:235 mul.f32 %f231, %f166, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f231) : "f"(f166));
  // PTX:236 mul.f32 %f232, %f167, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f232) : "f"(f167));
  // PTX:237 mul.f32 %f233, %f168, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f233) : "f"(f168));
  // PTX:238 mul.f32 %f234, %f169, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f234) : "f"(f169));
  // PTX:239 add.s32 %r122, %r122, 2
  asm("add.s32 %0, %1, 2;" : "=r"(r122) : "r"(r122));
  // PTX:240 setp.lt.u32 %p11, %r122, 8
  p11 = (((unsigned)(r122)) < ((unsigned)(8)));
  // PTX:241 @%p11 bra $L__BB15_7
  if (p11) { goto L_BB15_7; }
  // PTX:243 $L__BB15_10:
L_BB15_10:;
  // PTX:244 mul.f32 %f170, %f227, %f227
  asm("mul.f32 %0, %1, %2;" : "=f"(f170) : "f"(f227), "f"(f227));
  // PTX:245 fma.rn.f32 %f171, %f226, %f226, %f170
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f171) : "f"(f226), "f"(f226), "f"(f170));
  // PTX:246 fma.rn.f32 %f172, %f228, %f228, %f171
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f172) : "f"(f228), "f"(f228), "f"(f171));
  // PTX:247 sqrt.rn.f32 %f64, %f172
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f64) : "f"(f172));
  // PTX:248 setp.leu.f32 %p12, %f64, 0f00000000
  p12 = ((isnan(((float)(f64))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f64)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:249 mov.u32 %r135, 0
  asm("mov.u32 %0, 0;" : "=r"(r135) : );
  // PTX:250 mov.u32 %r123, %r135
  asm("mov.u32 %0, %1;" : "=r"(r123) : "r"(r135));
  // PTX:251 mov.u32 %r124, %r135
  asm("mov.u32 %0, %1;" : "=r"(r124) : "r"(r135));
  // PTX:252 mov.u32 %r125, %r135
  asm("mov.u32 %0, %1;" : "=r"(r125) : "r"(r135));
  // PTX:253 @%p12 bra $L__BB15_12
  if (p12) { goto L_BB15_12; }
  // PTX:255 div.rn.f32 %f173, %f226, %f64
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f173) : "f"(f226), "f"(f64));
  // PTX:256 div.rn.f32 %f174, %f227, %f64
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f174) : "f"(f227), "f"(f64));
  // PTX:257 div.rn.f32 %f175, %f228, %f64
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f175) : "f"(f228), "f"(f64));
  // PTX:258 mov.b32 %r125, %f175
  asm("mov.b32 %0, %1;" : "=r"(r125) : "f"(f175));
  // PTX:259 mov.b32 %r124, %f174
  asm("mov.b32 %0, %1;" : "=r"(r124) : "f"(f174));
  // PTX:260 mov.b32 %r123, %f173
  asm("mov.b32 %0, %1;" : "=r"(r123) : "f"(f173));
  // PTX:262 $L__BB15_12:
L_BB15_12:;
  // PTX:263 mov.b32 %f65, %r123
  asm("mov.b32 %0, %1;" : "=f"(f65) : "r"(r123));
  // PTX:264 mov.b32 %f66, %r124
  asm("mov.b32 %0, %1;" : "=f"(f66) : "r"(r124));
  // PTX:265 mul.f32 %f176, %f230, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f176) : "f"(f230), "f"(f66));
  // PTX:266 mov.b32 %f67, %r125
  asm("mov.b32 %0, %1;" : "=f"(f67) : "r"(r125));
  // PTX:267 fma.rn.f32 %f177, %f229, %f65, %f176
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f177) : "f"(f229), "f"(f65), "f"(f176));
  // PTX:268 fma.rn.f32 %f178, %f231, %f67, %f177
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f178) : "f"(f231), "f"(f67), "f"(f177));
  // PTX:269 mul.f32 %f179, %f178, %f65
  asm("mul.f32 %0, %1, %2;" : "=f"(f179) : "f"(f178), "f"(f65));
  // PTX:270 mul.f32 %f180, %f178, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f180) : "f"(f178), "f"(f66));
  // PTX:271 mul.f32 %f181, %f178, %f67
  asm("mul.f32 %0, %1, %2;" : "=f"(f181) : "f"(f178), "f"(f67));
  // PTX:272 sub.f32 %f68, %f229, %f179
  asm("sub.f32 %0, %1, %2;" : "=f"(f68) : "f"(f229), "f"(f179));
  // PTX:273 sub.f32 %f69, %f230, %f180
  asm("sub.f32 %0, %1, %2;" : "=f"(f69) : "f"(f230), "f"(f180));
  // PTX:274 sub.f32 %f70, %f231, %f181
  asm("sub.f32 %0, %1, %2;" : "=f"(f70) : "f"(f231), "f"(f181));
  // PTX:275 mul.f32 %f182, %f69, %f69
  asm("mul.f32 %0, %1, %2;" : "=f"(f182) : "f"(f69), "f"(f69));
  // PTX:276 fma.rn.f32 %f183, %f68, %f68, %f182
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f183) : "f"(f68), "f"(f68), "f"(f182));
  // PTX:277 fma.rn.f32 %f184, %f70, %f70, %f183
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f184) : "f"(f70), "f"(f70), "f"(f183));
  // PTX:278 sqrt.rn.f32 %f71, %f184
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f71) : "f"(f184));
  // PTX:279 setp.leu.f32 %p13, %f71, 0f00000000
  p13 = ((isnan(((float)(f71))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f71)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:280 mov.u32 %r136, %r135
  asm("mov.u32 %0, %1;" : "=r"(r136) : "r"(r135));
  // PTX:281 mov.u32 %r137, %r135
  asm("mov.u32 %0, %1;" : "=r"(r137) : "r"(r135));
  // PTX:282 @%p13 bra $L__BB15_14
  if (p13) { goto L_BB15_14; }
  // PTX:284 div.rn.f32 %f185, %f68, %f71
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f185) : "f"(f68), "f"(f71));
  // PTX:285 div.rn.f32 %f186, %f69, %f71
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f186) : "f"(f69), "f"(f71));
  // PTX:286 div.rn.f32 %f187, %f70, %f71
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f187) : "f"(f70), "f"(f71));
  // PTX:287 mov.b32 %r137, %f187
  asm("mov.b32 %0, %1;" : "=r"(r137) : "f"(f187));
  // PTX:288 mov.b32 %r136, %f186
  asm("mov.b32 %0, %1;" : "=r"(r136) : "f"(f186));
  // PTX:289 mov.b32 %r135, %f185
  asm("mov.b32 %0, %1;" : "=r"(r135) : "f"(f185));
  // PTX:291 $L__BB15_14:
L_BB15_14:;
  // PTX:292 mul.f32 %f188, %f66, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f188) : "f"(f66), "f"(f66));
  // PTX:293 fma.rn.f32 %f189, %f65, %f65, %f188
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f189) : "f"(f65), "f"(f65), "f"(f188));
  // PTX:294 fma.rn.f32 %f190, %f67, %f67, %f189
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f190) : "f"(f67), "f"(f67), "f"(f189));
  // PTX:295 sqrt.rn.f32 %f191, %f190
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f191) : "f"(f190));
  // PTX:296 setp.le.f32 %p14, %f191, 0f322BCC77
  p14 = (!(isnan(((float)(f191))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f191)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:297 mov.u32 %r139, 0
  asm("mov.u32 %0, 0;" : "=r"(r139) : );
  // PTX:298 mov.u32 %r140, %r139
  asm("mov.u32 %0, %1;" : "=r"(r140) : "r"(r139));
  // PTX:299 mov.u32 %r141, %r139
  asm("mov.u32 %0, %1;" : "=r"(r141) : "r"(r139));
  // PTX:300 mov.u32 %r142, %r138
  asm("mov.u32 %0, %1;" : "=r"(r142) : "r"(r138));
  // PTX:301 mov.u32 %r143, %r139
  asm("mov.u32 %0, %1;" : "=r"(r143) : "r"(r139));
  // PTX:302 mov.u32 %r144, %r139
  asm("mov.u32 %0, %1;" : "=r"(r144) : "r"(r139));
  // PTX:303 mov.u32 %r145, %r139
  asm("mov.u32 %0, %1;" : "=r"(r145) : "r"(r139));
  // PTX:304 mov.u32 %r146, %r138
  asm("mov.u32 %0, %1;" : "=r"(r146) : "r"(r138));
  // PTX:305 @%p14 bra $L__BB15_21
  if (p14) { goto L_BB15_21; }
  // PTX:307 mov.b32 %f72, %r135
  asm("mov.b32 %0, %1;" : "=f"(f72) : "r"(r135));
  // PTX:308 mov.b32 %f73, %r136
  asm("mov.b32 %0, %1;" : "=f"(f73) : "r"(r136));
  // PTX:309 mul.f32 %f192, %f73, %f73
  asm("mul.f32 %0, %1, %2;" : "=f"(f192) : "f"(f73), "f"(f73));
  // PTX:310 mov.b32 %f74, %r137
  asm("mov.b32 %0, %1;" : "=f"(f74) : "r"(r137));
  // PTX:311 fma.rn.f32 %f193, %f72, %f72, %f192
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f193) : "f"(f72), "f"(f72), "f"(f192));
  // PTX:312 fma.rn.f32 %f194, %f74, %f74, %f193
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f194) : "f"(f74), "f"(f74), "f"(f193));
  // PTX:313 sqrt.rn.f32 %f195, %f194
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f195) : "f"(f194));
  // PTX:314 setp.le.f32 %p15, %f195, 0f322BCC77
  p15 = (!(isnan(((float)(f195))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f195)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:315 mov.u32 %r142, %r138
  asm("mov.u32 %0, %1;" : "=r"(r142) : "r"(r138));
  // PTX:316 mov.u32 %r146, %r138
  asm("mov.u32 %0, %1;" : "=r"(r146) : "r"(r138));
  // PTX:317 @%p15 bra $L__BB15_21
  if (p15) { goto L_BB15_21; }
  // PTX:319 mul.f32 %f196, %f66, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f196) : "f"(f66), "f"(f74));
  // PTX:320 mul.f32 %f197, %f67, %f73
  asm("mul.f32 %0, %1, %2;" : "=f"(f197) : "f"(f67), "f"(f73));
  // PTX:321 sub.f32 %f75, %f196, %f197
  asm("sub.f32 %0, %1, %2;" : "=f"(f75) : "f"(f196), "f"(f197));
  // PTX:322 mul.f32 %f198, %f65, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f198) : "f"(f65), "f"(f74));
  // PTX:323 mul.f32 %f199, %f67, %f72
  asm("mul.f32 %0, %1, %2;" : "=f"(f199) : "f"(f67), "f"(f72));
  // PTX:324 sub.f32 %f76, %f199, %f198
  asm("sub.f32 %0, %1, %2;" : "=f"(f76) : "f"(f199), "f"(f198));
  // PTX:325 mul.f32 %f200, %f66, %f72
  asm("mul.f32 %0, %1, %2;" : "=f"(f200) : "f"(f66), "f"(f72));
  // PTX:326 mul.f32 %f201, %f65, %f73
  asm("mul.f32 %0, %1, %2;" : "=f"(f201) : "f"(f65), "f"(f73));
  // PTX:327 sub.f32 %f77, %f201, %f200
  asm("sub.f32 %0, %1, %2;" : "=f"(f77) : "f"(f201), "f"(f200));
  // PTX:328 mul.f32 %f202, %f76, %f76
  asm("mul.f32 %0, %1, %2;" : "=f"(f202) : "f"(f76), "f"(f76));
  // PTX:329 fma.rn.f32 %f203, %f75, %f75, %f202
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f203) : "f"(f75), "f"(f75), "f"(f202));
  // PTX:330 fma.rn.f32 %f204, %f77, %f77, %f203
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f204) : "f"(f77), "f"(f77), "f"(f203));
  // PTX:331 sqrt.rn.f32 %f78, %f204
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f78) : "f"(f204));
  // PTX:332 setp.leu.f32 %p16, %f78, 0f00000000
  p16 = ((isnan(((float)(f78))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f78)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:333 mov.u32 %r144, 0
  asm("mov.u32 %0, 0;" : "=r"(r144) : );
  // PTX:334 mov.u32 %r145, %r144
  asm("mov.u32 %0, %1;" : "=r"(r145) : "r"(r144));
  // PTX:335 mov.u32 %r146, %r144
  asm("mov.u32 %0, %1;" : "=r"(r146) : "r"(r144));
  // PTX:336 @%p16 bra $L__BB15_18
  if (p16) { goto L_BB15_18; }
  // PTX:338 div.rn.f32 %f205, %f75, %f78
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f205) : "f"(f75), "f"(f78));
  // PTX:339 div.rn.f32 %f206, %f76, %f78
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f206) : "f"(f76), "f"(f78));
  // PTX:340 div.rn.f32 %f207, %f77, %f78
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f207) : "f"(f77), "f"(f78));
  // PTX:341 mov.b32 %r146, %f207
  asm("mov.b32 %0, %1;" : "=r"(r146) : "f"(f207));
  // PTX:342 mov.b32 %r145, %f206
  asm("mov.b32 %0, %1;" : "=r"(r145) : "f"(f206));
  // PTX:343 mov.b32 %r144, %f205
  asm("mov.b32 %0, %1;" : "=r"(r144) : "f"(f205));
  // PTX:345 $L__BB15_18:
L_BB15_18:;
  // PTX:346 mov.b32 %f79, %r144
  asm("mov.b32 %0, %1;" : "=f"(f79) : "r"(r144));
  // PTX:347 mov.b32 %f80, %r145
  asm("mov.b32 %0, %1;" : "=f"(f80) : "r"(r145));
  // PTX:348 mul.f32 %f208, %f233, %f80
  asm("mul.f32 %0, %1, %2;" : "=f"(f208) : "f"(f233), "f"(f80));
  // PTX:349 mov.b32 %f81, %r146
  asm("mov.b32 %0, %1;" : "=f"(f81) : "r"(r146));
  // PTX:350 fma.rn.f32 %f209, %f232, %f79, %f208
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f209) : "f"(f232), "f"(f79), "f"(f208));
  // PTX:351 fma.rn.f32 %f210, %f234, %f81, %f209
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f210) : "f"(f234), "f"(f81), "f"(f209));
  // PTX:352 setp.geu.f32 %p17, %f210, 0f00000000
  p17 = ((isnan(((float)(f210))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f210)) >= ((float)(as_f32(0x00000000u)))));
  // PTX:353 @%p17 bra $L__BB15_20
  if (p17) { goto L_BB15_20; }
  // PTX:355 neg.f32 %f211, %f72
  asm("neg.f32 %0, %1;" : "=f"(f211) : "f"(f72));
  // PTX:356 mov.b32 %r135, %f211
  asm("mov.b32 %0, %1;" : "=r"(r135) : "f"(f211));
  // PTX:357 neg.f32 %f212, %f73
  asm("neg.f32 %0, %1;" : "=f"(f212) : "f"(f73));
  // PTX:358 mov.b32 %r136, %f212
  asm("mov.b32 %0, %1;" : "=r"(r136) : "f"(f212));
  // PTX:359 neg.f32 %f213, %f74
  asm("neg.f32 %0, %1;" : "=f"(f213) : "f"(f74));
  // PTX:360 mov.b32 %r137, %f213
  asm("mov.b32 %0, %1;" : "=r"(r137) : "f"(f213));
  // PTX:361 neg.f32 %f214, %f79
  asm("neg.f32 %0, %1;" : "=f"(f214) : "f"(f79));
  // PTX:362 mov.b32 %r144, %f214
  asm("mov.b32 %0, %1;" : "=r"(r144) : "f"(f214));
  // PTX:363 neg.f32 %f215, %f80
  asm("neg.f32 %0, %1;" : "=f"(f215) : "f"(f80));
  // PTX:364 mov.b32 %r145, %f215
  asm("mov.b32 %0, %1;" : "=r"(r145) : "f"(f215));
  // PTX:365 neg.f32 %f216, %f81
  asm("neg.f32 %0, %1;" : "=f"(f216) : "f"(f81));
  // PTX:366 mov.b32 %r146, %f216
  asm("mov.b32 %0, %1;" : "=r"(r146) : "f"(f216));
  // PTX:368 $L__BB15_20:
L_BB15_20:;
  // PTX:369 mov.u32 %r138, %r123
  asm("mov.u32 %0, %1;" : "=r"(r138) : "r"(r123));
  // PTX:370 mov.u32 %r139, %r124
  asm("mov.u32 %0, %1;" : "=r"(r139) : "r"(r124));
  // PTX:371 mov.u32 %r140, %r125
  asm("mov.u32 %0, %1;" : "=r"(r140) : "r"(r125));
  // PTX:372 mov.u32 %r141, %r135
  asm("mov.u32 %0, %1;" : "=r"(r141) : "r"(r135));
  // PTX:373 mov.u32 %r142, %r136
  asm("mov.u32 %0, %1;" : "=r"(r142) : "r"(r136));
  // PTX:374 mov.u32 %r143, %r137
  asm("mov.u32 %0, %1;" : "=r"(r143) : "r"(r137));
  // PTX:376 $L__BB15_21:
L_BB15_21:;
  // PTX:377 cvta.to.global.u64 %rd31, %rd10
  rd31 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd10));
  // PTX:378 mul.lo.s64 %rd32, %rd1, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd32) : "l"(rd1));
  // PTX:379 add.s64 %rd33, %rd31, %rd32
  asm("add.s64 %0, %1, %2;" : "=l"(rd33) : "l"(rd31), "l"(rd32));
  // PTX:380 st.global.u32 [%rd33], %r138
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (0))))) = (unsigned)(r138);
  // PTX:381 st.global.u32 [%rd33+4], %r139
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (4))))) = (unsigned)(r139);
  // PTX:382 st.global.u32 [%rd33+8], %r140
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (8))))) = (unsigned)(r140);
  // PTX:383 st.global.u32 [%rd33+12], %r141
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (12))))) = (unsigned)(r141);
  // PTX:384 st.global.u32 [%rd33+16], %r142
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (16))))) = (unsigned)(r142);
  // PTX:385 st.global.u32 [%rd33+20], %r143
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (20))))) = (unsigned)(r143);
  // PTX:386 st.global.u32 [%rd33+24], %r144
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (24))))) = (unsigned)(r144);
  // PTX:387 st.global.u32 [%rd33+28], %r145
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (28))))) = (unsigned)(r145);
  // PTX:388 st.global.u32 [%rd33+32], %r146
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (32))))) = (unsigned)(r146);
  // PTX:389 cvta.to.global.u64 %rd34, %rd11
  rd34 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd11));
  // PTX:390 add.s64 %rd35, %rd34, %rd32
  asm("add.s64 %0, %1, %2;" : "=l"(rd35) : "l"(rd34), "l"(rd32));
  // PTX:391 st.global.u32 [%rd35], %r70
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (0))))) = (unsigned)(r70);
  // PTX:392 st.global.u32 [%rd35+4], %r70
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (4))))) = (unsigned)(r70);
  // PTX:393 st.global.u32 [%rd35+8], %r70
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (8))))) = (unsigned)(r70);
  // PTX:394 st.global.u32 [%rd35+12], %r70
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (12))))) = (unsigned)(r70);
  // PTX:395 st.global.u32 [%rd35+16], %r70
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (16))))) = (unsigned)(r70);
  // PTX:396 st.global.u32 [%rd35+20], %r70
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (20))))) = (unsigned)(r70);
  // PTX:397 st.global.u32 [%rd35+24], %r70
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (24))))) = (unsigned)(r70);
  // PTX:398 st.global.u32 [%rd35+28], %r70
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (28))))) = (unsigned)(r70);
  // PTX:399 st.global.u32 [%rd35+32], %r70
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (32))))) = (unsigned)(r70);
  // PTX:401 $L__BB15_22:
L_BB15_22:;
  // PTX:402 ret
  return;
}
