// 机械还原自 PTX：synreal::fluid_kernel::accumulate_rows(synreal::fluid_kernel::View, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)
// PTX SHA256: 52738af5531208a46575ef65a8740d27e38a280c85c378c58483904787b7f7cc
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__fluid_kernel__accumulate_rows(ByVal<112, 8> param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33;
  unsigned short rs0, rs1, rs2, rs3, rs4, rs5, rs6, rs7, rs8, rs9, rs10;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121, r122, r123, r124, r125, r126, r127, r128, r129, r130, r131, r132, r133, r134, r135, r136, r137, r138, r139, r140, r141, r142;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135, rd136, rd137, rd138, rd139, rd140, rd141, rd142, rd143, rd144, rd145, rd146, rd147, rd148, rd149, rd150, rd151, rd152, rd153, rd154, rd155, rd156, rd157, rd158, rd159, rd160, rd161, rd162;
  // PTX:24 ld.param.v2.u32 {%r50, %r51}, [_ZN7synreal12fluid_kernel15accumulate_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS9_S7_PS5_PNS2_3matILi3ELi3EfLS4_0EEE_param_0+80]
  r50 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param0 + (80)))); r51 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param0 + (84))));
  // PTX:25 ld.param.v2.u32 {%r52, %r53}, [_ZN7synreal12fluid_kernel15accumulate_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS9_S7_PS5_PNS2_3matILi3ELi3EfLS4_0EEE_param_0+88]
  r52 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param0 + (88)))); r53 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param0 + (92))));
  // PTX:26 ld.param.v2.f32 {%f21, %f22}, [_ZN7synreal12fluid_kernel15accumulate_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS9_S7_PS5_PNS2_3matILi3ELi3EfLS4_0EEE_param_0+96]
  f21 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (96)))); f22 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (100))));
  // PTX:27 ld.param.v2.f32 {%f23, %f24}, [_ZN7synreal12fluid_kernel15accumulate_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS9_S7_PS5_PNS2_3matILi3ELi3EfLS4_0EEE_param_0+104]
  f23 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (104)))); f24 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (108))));
  // PTX:28 ld.param.u64 %rd56, [_ZN7synreal12fluid_kernel15accumulate_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS9_S7_PS5_PNS2_3matILi3ELi3EfLS4_0EEE_param_1]
  rd56 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:29 ld.param.u64 %rd57, [_ZN7synreal12fluid_kernel15accumulate_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS9_S7_PS5_PNS2_3matILi3ELi3EfLS4_0EEE_param_2]
  rd57 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:30 ld.param.u64 %rd58, [_ZN7synreal12fluid_kernel15accumulate_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS9_S7_PS5_PNS2_3matILi3ELi3EfLS4_0EEE_param_3]
  rd58 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:31 ld.param.u64 %rd59, [_ZN7synreal12fluid_kernel15accumulate_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS9_S7_PS5_PNS2_3matILi3ELi3EfLS4_0EEE_param_4]
  rd59 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:32 ld.param.u64 %rd60, [_ZN7synreal12fluid_kernel15accumulate_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS9_S7_PS5_PNS2_3matILi3ELi3EfLS4_0EEE_param_5]
  rd60 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:33 ld.param.u64 %rd61, [_ZN7synreal12fluid_kernel15accumulate_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS9_S7_PS5_PNS2_3matILi3ELi3EfLS4_0EEE_param_6]
  rd61 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:34 ld.param.u64 %rd55, [_ZN7synreal12fluid_kernel15accumulate_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS9_S7_PS5_PNS2_3matILi3ELi3EfLS4_0EEE_param_0+72]
  rd55 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (72))));
  // PTX:35 ld.param.u64 %rd54, [_ZN7synreal12fluid_kernel15accumulate_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS9_S7_PS5_PNS2_3matILi3ELi3EfLS4_0EEE_param_0+64]
  rd54 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (64))));
  // PTX:36 ld.param.u64 %rd53, [_ZN7synreal12fluid_kernel15accumulate_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS9_S7_PS5_PNS2_3matILi3ELi3EfLS4_0EEE_param_0+56]
  rd53 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (56))));
  // PTX:37 ld.param.u64 %rd52, [_ZN7synreal12fluid_kernel15accumulate_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS9_S7_PS5_PNS2_3matILi3ELi3EfLS4_0EEE_param_0+48]
  rd52 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (48))));
  // PTX:38 ld.param.u64 %rd51, [_ZN7synreal12fluid_kernel15accumulate_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS9_S7_PS5_PNS2_3matILi3ELi3EfLS4_0EEE_param_0+40]
  rd51 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (40))));
  // PTX:39 ld.param.u64 %rd50, [_ZN7synreal12fluid_kernel15accumulate_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS9_S7_PS5_PNS2_3matILi3ELi3EfLS4_0EEE_param_0+32]
  rd50 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (32))));
  // PTX:40 ld.param.u64 %rd49, [_ZN7synreal12fluid_kernel15accumulate_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS9_S7_PS5_PNS2_3matILi3ELi3EfLS4_0EEE_param_0+24]
  rd49 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (24))));
  // PTX:41 ld.param.u64 %rd48, [_ZN7synreal12fluid_kernel15accumulate_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS9_S7_PS5_PNS2_3matILi3ELi3EfLS4_0EEE_param_0+16]
  rd48 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (16))));
  // PTX:42 ld.param.u64 %rd47, [_ZN7synreal12fluid_kernel15accumulate_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS9_S7_PS5_PNS2_3matILi3ELi3EfLS4_0EEE_param_0+8]
  rd47 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (8))));
  // PTX:43 ld.param.u64 %rd46, [_ZN7synreal12fluid_kernel15accumulate_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS9_S7_PS5_PNS2_3matILi3ELi3EfLS4_0EEE_param_0]
  rd46 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:44 cvta.to.global.u64 %rd1, %rd61
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd61));
  // PTX:45 cvta.to.global.u64 %rd2, %rd59
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd59));
  // PTX:46 cvta.to.global.u64 %rd3, %rd60
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd60));
  // PTX:47 cvta.to.global.u64 %rd4, %rd46
  rd4 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd46));
  // PTX:48 cvta.to.global.u64 %rd5, %rd47
  rd5 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd47));
  // PTX:49 cvta.to.global.u64 %rd6, %rd48
  rd6 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd48));
  // PTX:50 cvta.to.global.u64 %rd7, %rd49
  rd7 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd49));
  // PTX:51 cvta.to.global.u64 %rd8, %rd50
  rd8 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd50));
  // PTX:52 cvta.to.global.u64 %rd9, %rd51
  rd9 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd51));
  // PTX:53 cvta.to.global.u64 %rd10, %rd52
  rd10 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd52));
  // PTX:54 mov.u32 %r54, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r54) : "r"(blockDim.x));
  // PTX:55 mov.u32 %r55, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r55) : "r"(blockIdx.x));
  // PTX:56 mov.u32 %r56, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r56) : "r"(threadIdx.x));
  // PTX:57 mad.lo.s32 %r1, %r55, %r54, %r56
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r1) : "r"(r55), "r"(r54), "r"(r56));
  // PTX:58 setp.ge.s32 %p1, %r1, %r53
  p1 = (((int)(r1)) >= ((int)(r53)));
  // PTX:59 @%p1 bra $L__BB2_34
  if (p1) { goto L_BB2_34; }
  // PTX:61 cvta.to.global.u64 %rd62, %rd53
  rd62 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd53));
  // PTX:62 div.s32 %r57, %r1, %r52
  asm("div.s32 %0, %1, %2;" : "=r"(r57) : "r"(r1), "r"(r52));
  // PTX:63 mul.lo.s32 %r58, %r57, %r52
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r58) : "r"(r57), "r"(r52));
  // PTX:64 sub.s32 %r59, %r1, %r58
  asm("sub.s32 %0, %1, %2;" : "=r"(r59) : "r"(r1), "r"(r58));
  // PTX:65 mad.lo.s32 %r60, %r57, %r51, %r59
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r60) : "r"(r57), "r"(r51), "r"(r59));
  // PTX:66 cvt.s64.s32 %rd11, %r60
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd11) : "r"(r60));
  // PTX:67 mul.wide.s32 %rd63, %r60, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd63) : "r"(r60));
  // PTX:68 add.s64 %rd64, %rd6, %rd63
  asm("add.s64 %0, %1, %2;" : "=l"(rd64) : "l"(rd6), "l"(rd63));
  // PTX:69 cvt.s64.s32 %rd12, %r1
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd12) : "r"(r1));
  // PTX:70 cvta.to.global.u64 %rd65, %rd58
  rd65 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd58));
  // PTX:71 mul.wide.s32 %rd66, %r1, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd66) : "r"(r1));
  // PTX:72 add.s64 %rd67, %rd65, %rd66
  asm("add.s64 %0, %1, %2;" : "=l"(rd67) : "l"(rd65), "l"(rd66));
  // PTX:73 cvta.to.global.u64 %rd68, %rd56
  rd68 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd56));
  // PTX:74 mul.wide.s32 %rd69, %r1, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd69) : "r"(r1));
  // PTX:75 add.s64 %rd70, %rd68, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd70) : "l"(rd68), "l"(rd69));
  // PTX:76 ld.global.u32 %r61, [%rd64]
  r61 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (0)))));
  // PTX:77 mul.wide.s32 %rd71, %r61, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd71) : "r"(r61));
  // PTX:78 add.s64 %rd13, %rd3, %rd71
  asm("add.s64 %0, %1, %2;" : "=l"(rd13) : "l"(rd3), "l"(rd71));
  // PTX:79 cvta.to.global.u64 %rd72, %rd57
  rd72 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd57));
  // PTX:80 add.s64 %rd14, %rd72, %rd66
  asm("add.s64 %0, %1, %2;" : "=l"(rd14) : "l"(rd72), "l"(rd66));
  // PTX:81 ld.global.f32 %f25, [%rd14]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:82 ld.global.f32 %f1, [%rd67]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0)))));
  // PTX:83 mul.f32 %f26, %f1, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f26) : "f"(f1), "f"(f25));
  // PTX:84 neg.f32 %f27, %f26
  asm("neg.f32 %0, %1;" : "=f"(f27) : "f"(f26));
  // PTX:85 ld.global.f32 %f28, [%rd70]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0)))));
  // PTX:86 mul.f32 %f29, %f28, %f27
  asm("mul.f32 %0, %1, %2;" : "=f"(f29) : "f"(f28), "f"(f27));
  // PTX:87 ld.global.f32 %f30, [%rd70+4]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (4)))));
  // PTX:88 mul.f32 %f31, %f30, %f27
  asm("mul.f32 %0, %1, %2;" : "=f"(f31) : "f"(f30), "f"(f27));
  // PTX:89 ld.global.f32 %f32, [%rd70+8]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (8)))));
  // PTX:90 mul.f32 %f33, %f32, %f27
  asm("mul.f32 %0, %1, %2;" : "=f"(f33) : "f"(f32), "f"(f27));
  // PTX:91 red.global.add.f32 [%rd13], %f29
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))), (float)(f29));
  // PTX:92 add.s64 %rd15, %rd13, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd15) : "l"(rd13));
  // PTX:93 red.global.add.f32 [%rd15], %f31
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))), (float)(f31));
  // PTX:94 add.s64 %rd16, %rd13, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd16) : "l"(rd13));
  // PTX:95 red.global.add.f32 [%rd16], %f33
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))), (float)(f33));
  // PTX:96 mul.f32 %f37, %f28, %f28
  asm("mul.f32 %0, %1, %2;" : "=f"(f37) : "f"(f28), "f"(f28));
  // PTX:97 mul.f32 %f38, %f30, %f28
  asm("mul.f32 %0, %1, %2;" : "=f"(f38) : "f"(f30), "f"(f28));
  // PTX:98 mul.f32 %f39, %f32, %f28
  asm("mul.f32 %0, %1, %2;" : "=f"(f39) : "f"(f32), "f"(f28));
  // PTX:99 mul.f32 %f40, %f30, %f30
  asm("mul.f32 %0, %1, %2;" : "=f"(f40) : "f"(f30), "f"(f30));
  // PTX:100 mul.f32 %f41, %f32, %f30
  asm("mul.f32 %0, %1, %2;" : "=f"(f41) : "f"(f32), "f"(f30));
  // PTX:101 mul.f32 %f42, %f32, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f42) : "f"(f32), "f"(f32));
  // PTX:102 mul.f32 %f43, %f1, %f37
  asm("mul.f32 %0, %1, %2;" : "=f"(f43) : "f"(f1), "f"(f37));
  // PTX:103 mul.f32 %f44, %f1, %f38
  asm("mul.f32 %0, %1, %2;" : "=f"(f44) : "f"(f1), "f"(f38));
  // PTX:104 mul.f32 %f45, %f1, %f39
  asm("mul.f32 %0, %1, %2;" : "=f"(f45) : "f"(f1), "f"(f39));
  // PTX:105 mul.f32 %f46, %f1, %f40
  asm("mul.f32 %0, %1, %2;" : "=f"(f46) : "f"(f1), "f"(f40));
  // PTX:106 mul.f32 %f47, %f1, %f41
  asm("mul.f32 %0, %1, %2;" : "=f"(f47) : "f"(f1), "f"(f41));
  // PTX:107 mul.f32 %f48, %f1, %f42
  asm("mul.f32 %0, %1, %2;" : "=f"(f48) : "f"(f1), "f"(f42));
  // PTX:108 mul.wide.s32 %rd73, %r61, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd73) : "r"(r61));
  // PTX:109 add.s64 %rd17, %rd1, %rd73
  asm("add.s64 %0, %1, %2;" : "=l"(rd17) : "l"(rd1), "l"(rd73));
  // PTX:110 red.global.add.f32 [%rd17], %f43
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))), (float)(f43));
  // PTX:111 add.s64 %rd18, %rd17, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd18) : "l"(rd17));
  // PTX:112 red.global.add.f32 [%rd18], %f44
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (0)))), (float)(f44));
  // PTX:113 add.s64 %rd19, %rd17, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd19) : "l"(rd17));
  // PTX:114 red.global.add.f32 [%rd19], %f45
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))), (float)(f45));
  // PTX:115 add.s64 %rd20, %rd17, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd20) : "l"(rd17));
  // PTX:116 red.global.add.f32 [%rd20], %f44
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))), (float)(f44));
  // PTX:117 add.s64 %rd21, %rd17, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd21) : "l"(rd17));
  // PTX:118 red.global.add.f32 [%rd21], %f46
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (0)))), (float)(f46));
  // PTX:119 add.s64 %rd22, %rd17, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd22) : "l"(rd17));
  // PTX:120 red.global.add.f32 [%rd22], %f47
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (0)))), (float)(f47));
  // PTX:121 add.s64 %rd23, %rd17, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd23) : "l"(rd17));
  // PTX:122 red.global.add.f32 [%rd23], %f45
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (0)))), (float)(f45));
  // PTX:123 add.s64 %rd24, %rd17, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd24) : "l"(rd17));
  // PTX:124 red.global.add.f32 [%rd24], %f47
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (0)))), (float)(f47));
  // PTX:125 add.s64 %rd25, %rd17, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd25) : "l"(rd17));
  // PTX:126 red.global.add.f32 [%rd25], %f48
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (0)))), (float)(f48));
  // PTX:127 add.s64 %rd26, %rd62, %rd66
  asm("add.s64 %0, %1, %2;" : "=l"(rd26) : "l"(rd62), "l"(rd66));
  // PTX:128 ld.global.u32 %r2, [%rd26]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (0)))));
  // PTX:129 setp.lt.s32 %p2, %r2, 65
  p2 = (((int)(r2)) < ((int)(65)));
  // PTX:130 mul.wide.s32 %rd74, %r60, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd74) : "r"(r60));
  // PTX:131 add.s64 %rd27, %rd9, %rd74
  asm("add.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd9), "l"(rd74));
  // PTX:132 add.s64 %rd28, %rd2, %rd71
  asm("add.s64 %0, %1, %2;" : "=l"(rd28) : "l"(rd2), "l"(rd71));
  // PTX:133 @%p2 bra $L__BB2_29
  if (p2) { goto L_BB2_29; }
  // PTX:134 bra.uni $L__BB2_2
  goto L_BB2_2;
  // PTX:136 $L__BB2_29:
L_BB2_29:;
  // PTX:137 setp.lt.s32 %p31, %r2, 1
  p31 = (((int)(r2)) < ((int)(1)));
  // PTX:138 @%p31 bra $L__BB2_34
  if (p31) { goto L_BB2_34; }
  // PTX:140 shl.b64 %rd39, %rd12, 6
  asm("shl.b64 %0, %1, 6;" : "=l"(rd39) : "l"(rd12));
  // PTX:141 cvta.to.global.u64 %rd40, %rd55
  rd40 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd55));
  // PTX:142 cvta.to.global.u64 %rd41, %rd54
  rd41 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd54));
  // PTX:143 mov.u32 %r142, 0
  asm("mov.u32 %0, 0;" : "=r"(r142) : );
  // PTX:145 $L__BB2_31:
L_BB2_31:;
  // PTX:146 cvt.s64.s32 %rd129, %r142
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd129) : "r"(r142));
  // PTX:147 add.s64 %rd130, %rd39, %rd129
  asm("add.s64 %0, %1, %2;" : "=l"(rd130) : "l"(rd39), "l"(rd129));
  // PTX:148 shl.b64 %rd131, %rd130, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd131) : "l"(rd130));
  // PTX:149 add.s64 %rd132, %rd41, %rd131
  asm("add.s64 %0, %1, %2;" : "=l"(rd132) : "l"(rd41), "l"(rd131));
  // PTX:150 ld.global.u32 %r115, [%rd132]
  r115 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd132) + (0)))));
  // PTX:151 cvt.s64.s32 %rd42, %r115
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd42) : "r"(r115));
  // PTX:152 mul.wide.s32 %rd133, %r115, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd133) : "r"(r115));
  // PTX:153 add.s64 %rd134, %rd6, %rd133
  asm("add.s64 %0, %1, %2;" : "=l"(rd134) : "l"(rd6), "l"(rd133));
  // PTX:154 shl.b64 %rd135, %rd130, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd135) : "l"(rd130));
  // PTX:155 add.s64 %rd136, %rd40, %rd135
  asm("add.s64 %0, %1, %2;" : "=l"(rd136) : "l"(rd40), "l"(rd135));
  // PTX:156 ld.global.f32 %f16, [%rd136+12]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd136) + (12)))));
  // PTX:157 ld.global.u32 %r116, [%rd134]
  r116 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd134) + (0)))));
  // PTX:158 cvt.s64.s32 %rd43, %r116
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd43) : "r"(r116));
  // PTX:159 mul.wide.s32 %rd137, %r116, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd137) : "r"(r116));
  // PTX:160 add.s64 %rd44, %rd3, %rd137
  asm("add.s64 %0, %1, %2;" : "=l"(rd44) : "l"(rd3), "l"(rd137));
  // PTX:161 ld.global.f32 %f168, [%rd14]
  f168 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:162 mul.f32 %f169, %f1, %f168
  asm("mul.f32 %0, %1, %2;" : "=f"(f169) : "f"(f1), "f"(f168));
  // PTX:163 neg.f32 %f170, %f169
  asm("neg.f32 %0, %1;" : "=f"(f170) : "f"(f169));
  // PTX:164 ld.global.f32 %f171, [%rd136]
  f171 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd136) + (0)))));
  // PTX:165 mul.f32 %f172, %f171, %f170
  asm("mul.f32 %0, %1, %2;" : "=f"(f172) : "f"(f171), "f"(f170));
  // PTX:166 ld.global.f32 %f173, [%rd136+4]
  f173 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd136) + (4)))));
  // PTX:167 mul.f32 %f174, %f173, %f170
  asm("mul.f32 %0, %1, %2;" : "=f"(f174) : "f"(f173), "f"(f170));
  // PTX:168 ld.global.f32 %f175, [%rd136+8]
  f175 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd136) + (8)))));
  // PTX:169 mul.f32 %f176, %f175, %f170
  asm("mul.f32 %0, %1, %2;" : "=f"(f176) : "f"(f175), "f"(f170));
  // PTX:170 red.global.add.f32 [%rd44], %f172
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))), (float)(f172));
  // PTX:171 add.s64 %rd138, %rd44, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd138) : "l"(rd44));
  // PTX:172 red.global.add.f32 [%rd138], %f174
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd138) + (0)))), (float)(f174));
  // PTX:173 add.s64 %rd139, %rd44, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd139) : "l"(rd44));
  // PTX:174 red.global.add.f32 [%rd139], %f176
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd139) + (0)))), (float)(f176));
  // PTX:175 mul.f32 %f180, %f171, %f171
  asm("mul.f32 %0, %1, %2;" : "=f"(f180) : "f"(f171), "f"(f171));
  // PTX:176 mul.f32 %f181, %f173, %f171
  asm("mul.f32 %0, %1, %2;" : "=f"(f181) : "f"(f173), "f"(f171));
  // PTX:177 mul.f32 %f182, %f175, %f171
  asm("mul.f32 %0, %1, %2;" : "=f"(f182) : "f"(f175), "f"(f171));
  // PTX:178 mul.f32 %f183, %f173, %f173
  asm("mul.f32 %0, %1, %2;" : "=f"(f183) : "f"(f173), "f"(f173));
  // PTX:179 mul.f32 %f184, %f175, %f173
  asm("mul.f32 %0, %1, %2;" : "=f"(f184) : "f"(f175), "f"(f173));
  // PTX:180 mul.f32 %f185, %f175, %f175
  asm("mul.f32 %0, %1, %2;" : "=f"(f185) : "f"(f175), "f"(f175));
  // PTX:181 mul.f32 %f186, %f1, %f180
  asm("mul.f32 %0, %1, %2;" : "=f"(f186) : "f"(f1), "f"(f180));
  // PTX:182 mul.f32 %f187, %f1, %f181
  asm("mul.f32 %0, %1, %2;" : "=f"(f187) : "f"(f1), "f"(f181));
  // PTX:183 mul.f32 %f188, %f1, %f182
  asm("mul.f32 %0, %1, %2;" : "=f"(f188) : "f"(f1), "f"(f182));
  // PTX:184 mul.f32 %f189, %f1, %f183
  asm("mul.f32 %0, %1, %2;" : "=f"(f189) : "f"(f1), "f"(f183));
  // PTX:185 mul.f32 %f190, %f1, %f184
  asm("mul.f32 %0, %1, %2;" : "=f"(f190) : "f"(f1), "f"(f184));
  // PTX:186 mul.f32 %f191, %f1, %f185
  asm("mul.f32 %0, %1, %2;" : "=f"(f191) : "f"(f1), "f"(f185));
  // PTX:187 mul.wide.s32 %rd140, %r116, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd140) : "r"(r116));
  // PTX:188 add.s64 %rd45, %rd1, %rd140
  asm("add.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd1), "l"(rd140));
  // PTX:189 red.global.add.f32 [%rd45], %f186
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))), (float)(f186));
  // PTX:190 add.s64 %rd141, %rd45, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd141) : "l"(rd45));
  // PTX:191 red.global.add.f32 [%rd141], %f187
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd141) + (0)))), (float)(f187));
  // PTX:192 add.s64 %rd142, %rd45, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd142) : "l"(rd45));
  // PTX:193 red.global.add.f32 [%rd142], %f188
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd142) + (0)))), (float)(f188));
  // PTX:194 add.s64 %rd143, %rd45, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd143) : "l"(rd45));
  // PTX:195 red.global.add.f32 [%rd143], %f187
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd143) + (0)))), (float)(f187));
  // PTX:196 add.s64 %rd144, %rd45, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd144) : "l"(rd45));
  // PTX:197 red.global.add.f32 [%rd144], %f189
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd144) + (0)))), (float)(f189));
  // PTX:198 add.s64 %rd145, %rd45, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd145) : "l"(rd45));
  // PTX:199 red.global.add.f32 [%rd145], %f190
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd145) + (0)))), (float)(f190));
  // PTX:200 add.s64 %rd146, %rd45, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd146) : "l"(rd45));
  // PTX:201 red.global.add.f32 [%rd146], %f188
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd146) + (0)))), (float)(f188));
  // PTX:202 add.s64 %rd147, %rd45, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd147) : "l"(rd45));
  // PTX:203 red.global.add.f32 [%rd147], %f190
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd147) + (0)))), (float)(f190));
  // PTX:204 add.s64 %rd148, %rd45, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd148) : "l"(rd45));
  // PTX:205 red.global.add.f32 [%rd148], %f191
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd148) + (0)))), (float)(f191));
  // PTX:206 setp.leu.f32 %p32, %f16, 0f00000000
  p32 = ((isnan(((float)(f16))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f16)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:207 @%p32 bra $L__BB2_33
  if (p32) { goto L_BB2_33; }
  // PTX:209 mul.lo.s64 %rd159, %rd42, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd159) : "l"(rd42));
  // PTX:210 add.s64 %rd160, %rd9, %rd159
  asm("add.s64 %0, %1, %2;" : "=l"(rd160) : "l"(rd9), "l"(rd159));
  // PTX:211 ld.global.f32 %f201, [%rd160]
  f201 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd160) + (0)))));
  // PTX:212 ld.global.f32 %f202, [%rd27]
  f202 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))));
  // PTX:213 sub.f32 %f203, %f202, %f201
  asm("sub.f32 %0, %1, %2;" : "=f"(f203) : "f"(f202), "f"(f201));
  // PTX:214 ld.global.f32 %f204, [%rd160+4]
  f204 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd160) + (4)))));
  // PTX:215 ld.global.f32 %f205, [%rd27+4]
  f205 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (4)))));
  // PTX:216 sub.f32 %f206, %f205, %f204
  asm("sub.f32 %0, %1, %2;" : "=f"(f206) : "f"(f205), "f"(f204));
  // PTX:217 ld.global.f32 %f207, [%rd160+8]
  f207 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd160) + (8)))));
  // PTX:218 ld.global.f32 %f208, [%rd27+8]
  f208 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (8)))));
  // PTX:219 sub.f32 %f209, %f208, %f207
  asm("sub.f32 %0, %1, %2;" : "=f"(f209) : "f"(f208), "f"(f207));
  // PTX:220 mul.lo.s64 %rd161, %rd43, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd161) : "l"(rd43));
  // PTX:221 add.s64 %rd162, %rd2, %rd161
  asm("add.s64 %0, %1, %2;" : "=l"(rd162) : "l"(rd2), "l"(rd161));
  // PTX:222 ld.global.f32 %f210, [%rd162]
  f210 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd162) + (0)))));
  // PTX:223 ld.global.f32 %f211, [%rd28]
  f211 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (0)))));
  // PTX:224 sub.f32 %f212, %f211, %f210
  asm("sub.f32 %0, %1, %2;" : "=f"(f212) : "f"(f211), "f"(f210));
  // PTX:225 ld.global.f32 %f213, [%rd162+4]
  f213 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd162) + (4)))));
  // PTX:226 ld.global.f32 %f214, [%rd28+4]
  f214 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (4)))));
  // PTX:227 sub.f32 %f215, %f214, %f213
  asm("sub.f32 %0, %1, %2;" : "=f"(f215) : "f"(f214), "f"(f213));
  // PTX:228 ld.global.f32 %f216, [%rd162+8]
  f216 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd162) + (8)))));
  // PTX:229 ld.global.f32 %f217, [%rd28+8]
  f217 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (8)))));
  // PTX:230 sub.f32 %f218, %f217, %f216
  asm("sub.f32 %0, %1, %2;" : "=f"(f218) : "f"(f217), "f"(f216));
  // PTX:231 sub.f32 %f219, %f203, %f212
  asm("sub.f32 %0, %1, %2;" : "=f"(f219) : "f"(f203), "f"(f212));
  // PTX:232 sub.f32 %f220, %f206, %f215
  asm("sub.f32 %0, %1, %2;" : "=f"(f220) : "f"(f206), "f"(f215));
  // PTX:233 sub.f32 %f221, %f209, %f218
  asm("sub.f32 %0, %1, %2;" : "=f"(f221) : "f"(f209), "f"(f218));
  // PTX:234 neg.f32 %f222, %f16
  asm("neg.f32 %0, %1;" : "=f"(f222) : "f"(f16));
  // PTX:235 mul.f32 %f223, %f219, %f222
  asm("mul.f32 %0, %1, %2;" : "=f"(f223) : "f"(f219), "f"(f222));
  // PTX:236 mul.f32 %f224, %f220, %f222
  asm("mul.f32 %0, %1, %2;" : "=f"(f224) : "f"(f220), "f"(f222));
  // PTX:237 mul.f32 %f225, %f221, %f222
  asm("mul.f32 %0, %1, %2;" : "=f"(f225) : "f"(f221), "f"(f222));
  // PTX:238 red.global.add.f32 [%rd13], %f223
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))), (float)(f223));
  // PTX:239 red.global.add.f32 [%rd15], %f224
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))), (float)(f224));
  // PTX:240 red.global.add.f32 [%rd16], %f225
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))), (float)(f225));
  // PTX:241 neg.f32 %f229, %f223
  asm("neg.f32 %0, %1;" : "=f"(f229) : "f"(f223));
  // PTX:242 neg.f32 %f230, %f224
  asm("neg.f32 %0, %1;" : "=f"(f230) : "f"(f224));
  // PTX:243 neg.f32 %f231, %f225
  asm("neg.f32 %0, %1;" : "=f"(f231) : "f"(f225));
  // PTX:244 red.global.add.f32 [%rd44], %f229
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))), (float)(f229));
  // PTX:245 red.global.add.f32 [%rd138], %f230
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd138) + (0)))), (float)(f230));
  // PTX:246 red.global.add.f32 [%rd139], %f231
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd139) + (0)))), (float)(f231));
  // PTX:247 red.global.add.f32 [%rd17], %f16
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))), (float)(f16));
  // PTX:248 red.global.add.f32 [%rd18], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:249 red.global.add.f32 [%rd19], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:250 red.global.add.f32 [%rd20], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:251 red.global.add.f32 [%rd21], %f16
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (0)))), (float)(f16));
  // PTX:252 red.global.add.f32 [%rd22], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:253 red.global.add.f32 [%rd23], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:254 red.global.add.f32 [%rd24], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:255 red.global.add.f32 [%rd25], %f16
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (0)))), (float)(f16));
  // PTX:256 red.global.add.f32 [%rd45], %f16
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))), (float)(f16));
  // PTX:257 red.global.add.f32 [%rd141], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd141) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:258 red.global.add.f32 [%rd142], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd142) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:259 red.global.add.f32 [%rd143], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd143) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:260 red.global.add.f32 [%rd144], %f16
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd144) + (0)))), (float)(f16));
  // PTX:261 red.global.add.f32 [%rd145], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd145) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:262 red.global.add.f32 [%rd146], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd146) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:263 red.global.add.f32 [%rd147], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd147) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:264 red.global.add.f32 [%rd148], %f16
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd148) + (0)))), (float)(f16));
  // PTX:266 $L__BB2_33:
L_BB2_33:;
  // PTX:267 add.s32 %r142, %r142, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r142) : "r"(r142));
  // PTX:268 ld.global.u32 %r117, [%rd26]
  r117 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (0)))));
  // PTX:269 setp.lt.s32 %p33, %r142, %r117
  p33 = (((int)(r142)) < ((int)(r117)));
  // PTX:270 @%p33 bra $L__BB2_31
  if (p33) { goto L_BB2_31; }
  // PTX:271 bra.uni $L__BB2_34
  goto L_BB2_34;
  // PTX:273 $L__BB2_2:
L_BB2_2:;
  // PTX:274 mul.lo.s64 %rd75, %rd11, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd75) : "l"(rd11));
  // PTX:275 add.s64 %rd76, %rd8, %rd75
  asm("add.s64 %0, %1, %2;" : "=l"(rd76) : "l"(rd8), "l"(rd75));
  // PTX:276 shl.b64 %rd77, %rd11, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd77) : "l"(rd11));
  // PTX:277 add.s64 %rd78, %rd7, %rd77
  asm("add.s64 %0, %1, %2;" : "=l"(rd78) : "l"(rd7), "l"(rd77));
  // PTX:278 ld.global.u32 %r3, [%rd78]
  r3 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd78) + (0)))));
  // PTX:279 ld.global.u32 %r65, [%rd76]
  r65 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (0)))));
  // PTX:280 add.s32 %r4, %r65, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r4) : "r"(r65));
  // PTX:281 mov.u32 %r140, -1
  asm("mov.u32 %0, -1;" : "=r"(r140) : );
  // PTX:282 ld.global.u32 %r66, [%rd76+4]
  r66 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (4)))));
  // PTX:283 add.s32 %r5, %r66, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r5) : "r"(r66));
  // PTX:284 ld.global.u32 %r67, [%rd76+8]
  r67 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (8)))));
  // PTX:285 add.s32 %r6, %r67, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r6) : "r"(r67));
  // PTX:286 add.s32 %r7, %r50, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r7) : "r"(r50));
  // PTX:287 mov.u32 %r137, 0
  asm("mov.u32 %0, 0;" : "=r"(r137) : );
  // PTX:288 bra.uni $L__BB2_3
  goto L_BB2_3;
  // PTX:290 $L__BB2_12:
L_BB2_12:;
  // PTX:291 mul.wide.u32 %rd84, %r137, -1431655765
  asm("mul.wide.u32 %0, %1, -1431655765;" : "=l"(rd84) : "r"(r137));
  // PTX:292 shr.u64 %rd85, %rd84, 33
  asm("shr.u64 %0, %1, 33;" : "=l"(rd85) : "l"(rd84));
  // PTX:293 cvt.u32.u64 %r73, %rd85
  asm("cvt.u32.u64 %0, %1;" : "=r"(r73) : "l"(rd85));
  // PTX:294 mul.lo.s32 %r74, %r73, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r74) : "r"(r73));
  // PTX:295 sub.s32 %r75, %r137, %r74
  asm("sub.s32 %0, %1, %2;" : "=r"(r75) : "r"(r137), "r"(r74));
  // PTX:296 mul.wide.u32 %rd86, %r73, -1431655765
  asm("mul.wide.u32 %0, %1, -1431655765;" : "=l"(rd86) : "r"(r73));
  // PTX:297 shr.u64 %rd87, %rd86, 33
  asm("shr.u64 %0, %1, 33;" : "=l"(rd87) : "l"(rd86));
  // PTX:298 cvt.u32.u64 %r76, %rd87
  asm("cvt.u32.u64 %0, %1;" : "=r"(r76) : "l"(rd87));
  // PTX:299 mul.lo.s32 %r77, %r76, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r77) : "r"(r76));
  // PTX:300 sub.s32 %r78, %r73, %r77
  asm("sub.s32 %0, %1, %2;" : "=r"(r78) : "r"(r73), "r"(r77));
  // PTX:301 add.s32 %r133, %r4, %r75
  asm("add.s32 %0, %1, %2;" : "=r"(r133) : "r"(r4), "r"(r75));
  // PTX:302 add.s32 %r134, %r5, %r78
  asm("add.s32 %0, %1, %2;" : "=r"(r134) : "r"(r5), "r"(r78));
  // PTX:303 mul.wide.u32 %rd88, %r137, 954437177
  asm("mul.wide.u32 %0, %1, 954437177;" : "=l"(rd88) : "r"(r137));
  // PTX:304 shr.u64 %rd89, %rd88, 33
  asm("shr.u64 %0, %1, 33;" : "=l"(rd89) : "l"(rd88));
  // PTX:305 cvt.u32.u64 %r79, %rd89
  asm("cvt.u32.u64 %0, %1;" : "=r"(r79) : "l"(rd89));
  // PTX:306 add.s32 %r135, %r6, %r79
  asm("add.s32 %0, %1, %2;" : "=r"(r135) : "r"(r6), "r"(r79));
  // PTX:307 add.s32 %r137, %r137, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r137) : "r"(r137));
  // PTX:308 mul.lo.s32 %r80, %r133, 73856093
  asm("mul.lo.s32 %0, %1, 73856093;" : "=r"(r80) : "r"(r133));
  // PTX:309 mul.lo.s32 %r81, %r134, 19349663
  asm("mul.lo.s32 %0, %1, 19349663;" : "=r"(r81) : "r"(r134));
  // PTX:310 mul.lo.s32 %r82, %r135, 83492791
  asm("mul.lo.s32 %0, %1, 83492791;" : "=r"(r82) : "r"(r135));
  // PTX:311 xor.b32 %r83, %r82, %r80
  asm("xor.b32 %0, %1, %2;" : "=r"(r83) : "r"(r82), "r"(r80));
  // PTX:312 xor.b32 %r84, %r83, %r81
  asm("xor.b32 %0, %1, %2;" : "=r"(r84) : "r"(r83), "r"(r81));
  // PTX:313 and.b32 %r85, %r84, %r7
  asm("and.b32 %0, %1, %2;" : "=r"(r85) : "r"(r84), "r"(r7));
  // PTX:314 mul.wide.s32 %rd90, %r85, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd90) : "r"(r85));
  // PTX:315 add.s64 %rd91, %rd4, %rd90
  asm("add.s64 %0, %1, %2;" : "=l"(rd91) : "l"(rd4), "l"(rd90));
  // PTX:316 ld.global.u32 %r140, [%rd91]
  r140 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (0)))));
  // PTX:318 $L__BB2_3:
L_BB2_3:;
  // PTX:319 setp.lt.s32 %p3, %r140, 0
  p3 = (((int)(r140)) < ((int)(0)));
  // PTX:320 @%p3 bra $L__BB2_11
  if (p3) { goto L_BB2_11; }
  // PTX:322 mov.u32 %r141, %r140
  asm("mov.u32 %0, %1;" : "=r"(r141) : "r"(r140));
  // PTX:324 $L__BB2_5:
L_BB2_5:;
  // PTX:325 cvt.s64.s32 %rd29, %r141
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd29) : "r"(r141));
  // PTX:326 mul.wide.s32 %rd79, %r141, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd79) : "r"(r141));
  // PTX:327 add.s64 %rd80, %rd5, %rd79
  asm("add.s64 %0, %1, %2;" : "=l"(rd80) : "l"(rd5), "l"(rd79));
  // PTX:328 ld.global.u32 %r140, [%rd80]
  r140 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (0)))));
  // PTX:329 mul.wide.s32 %rd81, %r141, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd81) : "r"(r141));
  // PTX:330 add.s64 %rd30, %rd8, %rd81
  asm("add.s64 %0, %1, %2;" : "=l"(rd30) : "l"(rd8), "l"(rd81));
  // PTX:331 ld.global.u32 %r68, [%rd30]
  r68 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0)))));
  // PTX:332 setp.ne.s32 %p4, %r68, %r133
  p4 = (((int)(r68)) != ((int)(r133)));
  // PTX:333 mov.u16 %rs9, 0
  asm("mov.u16 %0, 0;" : "=h"(rs9) : );
  // PTX:334 @%p4 bra $L__BB2_8
  if (p4) { goto L_BB2_8; }
  // PTX:336 ld.global.u32 %r69, [%rd30+4]
  r69 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (4)))));
  // PTX:337 setp.ne.s32 %p5, %r69, %r134
  p5 = (((int)(r69)) != ((int)(r134)));
  // PTX:338 @%p5 bra $L__BB2_8
  if (p5) { goto L_BB2_8; }
  // PTX:340 ld.global.u32 %r70, [%rd30+8]
  r70 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (8)))));
  // PTX:341 setp.eq.s32 %p6, %r70, %r135
  p6 = (((int)(r70)) == ((int)(r135)));
  // PTX:342 selp.u16 %rs9, 1, 0, %p6
  rs9 = p6 ? 1 : 0;
  // PTX:344 $L__BB2_8:
L_BB2_8:;
  // PTX:345 setp.eq.s16 %p7, %rs9, 0
  p7 = (((short)(rs9)) == ((short)(0)));
  // PTX:346 @%p7 bra $L__BB2_10
  if (p7) { goto L_BB2_10; }
  // PTX:348 shl.b64 %rd82, %rd29, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd82) : "l"(rd29));
  // PTX:349 add.s64 %rd83, %rd7, %rd82
  asm("add.s64 %0, %1, %2;" : "=l"(rd83) : "l"(rd7), "l"(rd82));
  // PTX:350 ld.global.u32 %r71, [%rd83]
  r71 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (0)))));
  // PTX:351 setp.eq.s32 %p8, %r71, %r3
  p8 = (((int)(r71)) == ((int)(r3)));
  // PTX:352 setp.eq.s32 %p9, %r71, -1
  p9 = (((int)(r71)) == ((int)(-1)));
  // PTX:353 or.pred %p10, %p8, %p9
  p10 = ((p8) || (p9));
  // PTX:354 @%p10 bra $L__BB2_13
  if (p10) { goto L_BB2_13; }
  // PTX:356 $L__BB2_10:
L_BB2_10:;
  // PTX:357 setp.gt.s32 %p11, %r140, -1
  p11 = (((int)(r140)) > ((int)(-1)));
  // PTX:358 mov.u32 %r141, %r140
  asm("mov.u32 %0, %1;" : "=r"(r141) : "r"(r140));
  // PTX:359 @%p11 bra $L__BB2_5
  if (p11) { goto L_BB2_5; }
  // PTX:361 $L__BB2_11:
L_BB2_11:;
  // PTX:362 setp.eq.s32 %p12, %r137, 27
  p12 = (((int)(r137)) == ((int)(27)));
  // PTX:363 mov.u32 %r141, -1
  asm("mov.u32 %0, -1;" : "=r"(r141) : );
  // PTX:364 @%p12 bra $L__BB2_13
  if (p12) { goto L_BB2_13; }
  // PTX:365 bra.uni $L__BB2_12
  goto L_BB2_12;
  // PTX:367 $L__BB2_13:
L_BB2_13:;
  // PTX:368 setp.lt.s32 %p13, %r141, 0
  p13 = (((int)(r141)) < ((int)(0)));
  // PTX:369 @%p13 bra $L__BB2_34
  if (p13) { goto L_BB2_34; }
  // PTX:371 mul.f32 %f5, %f21, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f5) : "f"(f21), "f"(f21));
  // PTX:372 mul.f32 %f58, %f21, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f58) : "f"(f21), "f"(f5));
  // PTX:373 mul.f32 %f59, %f21, %f58
  asm("mul.f32 %0, %1, %2;" : "=f"(f59) : "f"(f21), "f"(f58));
  // PTX:374 mul.f32 %f6, %f21, %f59
  asm("mul.f32 %0, %1, %2;" : "=f"(f6) : "f"(f21), "f"(f59));
  // PTX:375 mul.f32 %f7, %f23, 0fC0000000
  asm("mul.f32 %0, %1, 0fC0000000;" : "=f"(f7) : "f"(f23));
  // PTX:376 add.s64 %rd31, %rd10, %rd77
  asm("add.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd10), "l"(rd77));
  // PTX:377 mul.f32 %f60, %f21, 0f3C23D70A
  asm("mul.f32 %0, %1, 0f3C23D70A;" : "=f"(f60) : "f"(f21));
  // PTX:378 mul.f32 %f8, %f21, %f60
  asm("mul.f32 %0, %1, %2;" : "=f"(f8) : "f"(f21), "f"(f60));
  // PTX:379 cvt.u32.u64 %r86, %rd11
  asm("cvt.u32.u64 %0, %1;" : "=r"(r86) : "l"(rd11));
  // PTX:381 $L__BB2_15:
L_BB2_15:;
  // PTX:382 cvt.s64.s32 %rd32, %r141
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd32) : "r"(r141));
  // PTX:383 mul.wide.s32 %rd93, %r141, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd93) : "r"(r141));
  // PTX:384 add.s64 %rd94, %rd6, %rd93
  asm("add.s64 %0, %1, %2;" : "=l"(rd94) : "l"(rd6), "l"(rd93));
  // PTX:385 ld.global.s32 %rd33, [%rd94]
  rd33 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd94) + (0)))));
  // PTX:386 setp.eq.s32 %p14, %r86, %r141
  p14 = (((int)(r86)) == ((int)(r141)));
  // PTX:387 setp.lt.s64 %p15, %rd33, 0
  p15 = (((long long)(rd33)) < ((long long)(0)));
  // PTX:388 or.pred %p16, %p14, %p15
  p16 = ((p14) || (p15));
  // PTX:389 @%p16 bra $L__BB2_18
  if (p16) { goto L_BB2_18; }
  // PTX:391 cvt.u32.u64 %r87, %rd32
  asm("cvt.u32.u64 %0, %1;" : "=r"(r87) : "l"(rd32));
  // PTX:392 mul.lo.s64 %rd95, %rd32, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd95) : "l"(rd32));
  // PTX:393 add.s64 %rd96, %rd9, %rd95
  asm("add.s64 %0, %1, %2;" : "=l"(rd96) : "l"(rd9), "l"(rd95));
  // PTX:394 ld.global.f32 %f61, [%rd96]
  f61 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (0)))));
  // PTX:395 ld.global.f32 %f62, [%rd27]
  f62 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))));
  // PTX:396 sub.f32 %f9, %f62, %f61
  asm("sub.f32 %0, %1, %2;" : "=f"(f9) : "f"(f62), "f"(f61));
  // PTX:397 ld.global.f32 %f63, [%rd96+4]
  f63 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (4)))));
  // PTX:398 ld.global.f32 %f64, [%rd27+4]
  f64 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (4)))));
  // PTX:399 sub.f32 %f10, %f64, %f63
  asm("sub.f32 %0, %1, %2;" : "=f"(f10) : "f"(f64), "f"(f63));
  // PTX:400 ld.global.f32 %f65, [%rd96+8]
  f65 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (8)))));
  // PTX:401 ld.global.f32 %f66, [%rd27+8]
  f66 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (8)))));
  // PTX:402 sub.f32 %f11, %f66, %f65
  asm("sub.f32 %0, %1, %2;" : "=f"(f11) : "f"(f66), "f"(f65));
  // PTX:403 shl.b64 %rd97, %rd32, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd97) : "l"(rd32));
  // PTX:404 add.s64 %rd34, %rd10, %rd97
  asm("add.s64 %0, %1, %2;" : "=l"(rd34) : "l"(rd10), "l"(rd97));
  // PTX:405 ld.global.f32 %f67, [%rd34]
  f67 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (0)))));
  // PTX:406 neg.f32 %f68, %f67
  asm("neg.f32 %0, %1;" : "=f"(f68) : "f"(f67));
  // PTX:407 mul.f32 %f69, %f10, %f10
  asm("mul.f32 %0, %1, %2;" : "=f"(f69) : "f"(f10), "f"(f10));
  // PTX:408 fma.rn.f32 %f70, %f9, %f9, %f69
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f70) : "f"(f9), "f"(f9), "f"(f69));
  // PTX:409 fma.rn.f32 %f12, %f11, %f11, %f70
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f12) : "f"(f11), "f"(f11), "f"(f70));
  // PTX:410 div.rn.f32 %f71, %f12, %f5
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f71) : "f"(f12), "f"(f5));
  // PTX:411 mov.f32 %f72, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f72) : );
  // PTX:412 sub.f32 %f73, %f72, %f71
  asm("sub.f32 %0, %1, %2;" : "=f"(f73) : "f"(f72), "f"(f71));
  // PTX:413 mov.f32 %f74, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f74) : );
  // PTX:414 max.f32 %f75, %f73, %f74
  asm("max.f32 %0, %1, %2;" : "=f"(f75) : "f"(f73), "f"(f74));
  // PTX:415 mul.f32 %f76, %f75, 0fC11666C3
  asm("mul.f32 %0, %1, 0fC11666C3;" : "=f"(f76) : "f"(f75));
  // PTX:416 mul.f32 %f77, %f75, %f76
  asm("mul.f32 %0, %1, %2;" : "=f"(f77) : "f"(f75), "f"(f76));
  // PTX:417 mul.f32 %f78, %f9, %f77
  asm("mul.f32 %0, %1, %2;" : "=f"(f78) : "f"(f9), "f"(f77));
  // PTX:418 mul.f32 %f79, %f10, %f77
  asm("mul.f32 %0, %1, %2;" : "=f"(f79) : "f"(f10), "f"(f77));
  // PTX:419 mul.f32 %f80, %f11, %f77
  asm("mul.f32 %0, %1, %2;" : "=f"(f80) : "f"(f11), "f"(f77));
  // PTX:420 div.rn.f32 %f13, %f78, %f6
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f13) : "f"(f78), "f"(f6));
  // PTX:421 div.rn.f32 %f14, %f79, %f6
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f14) : "f"(f79), "f"(f6));
  // PTX:422 div.rn.f32 %f15, %f80, %f6
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f15) : "f"(f80), "f"(f6));
  // PTX:423 mul.f32 %f81, %f13, %f68
  asm("mul.f32 %0, %1, %2;" : "=f"(f81) : "f"(f13), "f"(f68));
  // PTX:424 mul.f32 %f82, %f14, %f68
  asm("mul.f32 %0, %1, %2;" : "=f"(f82) : "f"(f14), "f"(f68));
  // PTX:425 mul.f32 %f83, %f15, %f68
  asm("mul.f32 %0, %1, %2;" : "=f"(f83) : "f"(f15), "f"(f68));
  // PTX:426 ld.global.f32 %f84, [%rd14]
  f84 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:427 mul.f32 %f85, %f1, %f84
  asm("mul.f32 %0, %1, %2;" : "=f"(f85) : "f"(f1), "f"(f84));
  // PTX:428 neg.f32 %f86, %f85
  asm("neg.f32 %0, %1;" : "=f"(f86) : "f"(f85));
  // PTX:429 mul.f32 %f87, %f81, %f86
  asm("mul.f32 %0, %1, %2;" : "=f"(f87) : "f"(f81), "f"(f86));
  // PTX:430 mul.f32 %f88, %f82, %f86
  asm("mul.f32 %0, %1, %2;" : "=f"(f88) : "f"(f82), "f"(f86));
  // PTX:431 mul.f32 %f89, %f83, %f86
  asm("mul.f32 %0, %1, %2;" : "=f"(f89) : "f"(f83), "f"(f86));
  // PTX:432 mul.lo.s64 %rd98, %rd33, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd98) : "l"(rd33));
  // PTX:433 add.s64 %rd35, %rd3, %rd98
  asm("add.s64 %0, %1, %2;" : "=l"(rd35) : "l"(rd3), "l"(rd98));
  // PTX:434 red.global.add.f32 [%rd35], %f87
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (0)))), (float)(f87));
  // PTX:435 add.s64 %rd99, %rd35, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd99) : "l"(rd35));
  // PTX:436 red.global.add.f32 [%rd99], %f88
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (0)))), (float)(f88));
  // PTX:437 add.s64 %rd100, %rd35, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd100) : "l"(rd35));
  // PTX:438 red.global.add.f32 [%rd100], %f89
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (0)))), (float)(f89));
  // PTX:439 mul.f32 %f93, %f81, %f81
  asm("mul.f32 %0, %1, %2;" : "=f"(f93) : "f"(f81), "f"(f81));
  // PTX:440 mul.f32 %f94, %f82, %f81
  asm("mul.f32 %0, %1, %2;" : "=f"(f94) : "f"(f82), "f"(f81));
  // PTX:441 mul.f32 %f95, %f83, %f81
  asm("mul.f32 %0, %1, %2;" : "=f"(f95) : "f"(f83), "f"(f81));
  // PTX:442 mul.f32 %f96, %f82, %f82
  asm("mul.f32 %0, %1, %2;" : "=f"(f96) : "f"(f82), "f"(f82));
  // PTX:443 mul.f32 %f97, %f83, %f82
  asm("mul.f32 %0, %1, %2;" : "=f"(f97) : "f"(f83), "f"(f82));
  // PTX:444 mul.f32 %f98, %f83, %f83
  asm("mul.f32 %0, %1, %2;" : "=f"(f98) : "f"(f83), "f"(f83));
  // PTX:445 mul.f32 %f99, %f1, %f93
  asm("mul.f32 %0, %1, %2;" : "=f"(f99) : "f"(f1), "f"(f93));
  // PTX:446 mul.f32 %f100, %f1, %f94
  asm("mul.f32 %0, %1, %2;" : "=f"(f100) : "f"(f1), "f"(f94));
  // PTX:447 mul.f32 %f101, %f1, %f95
  asm("mul.f32 %0, %1, %2;" : "=f"(f101) : "f"(f1), "f"(f95));
  // PTX:448 mul.f32 %f102, %f1, %f96
  asm("mul.f32 %0, %1, %2;" : "=f"(f102) : "f"(f1), "f"(f96));
  // PTX:449 mul.f32 %f103, %f1, %f97
  asm("mul.f32 %0, %1, %2;" : "=f"(f103) : "f"(f1), "f"(f97));
  // PTX:450 mul.f32 %f104, %f1, %f98
  asm("mul.f32 %0, %1, %2;" : "=f"(f104) : "f"(f1), "f"(f98));
  // PTX:451 mul.lo.s64 %rd101, %rd33, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd101) : "l"(rd33));
  // PTX:452 add.s64 %rd36, %rd1, %rd101
  asm("add.s64 %0, %1, %2;" : "=l"(rd36) : "l"(rd1), "l"(rd101));
  // PTX:453 red.global.add.f32 [%rd36], %f99
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (0)))), (float)(f99));
  // PTX:454 add.s64 %rd102, %rd36, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd102) : "l"(rd36));
  // PTX:455 red.global.add.f32 [%rd102], %f100
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd102) + (0)))), (float)(f100));
  // PTX:456 add.s64 %rd103, %rd36, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd103) : "l"(rd36));
  // PTX:457 red.global.add.f32 [%rd103], %f101
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd103) + (0)))), (float)(f101));
  // PTX:458 add.s64 %rd104, %rd36, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd104) : "l"(rd36));
  // PTX:459 red.global.add.f32 [%rd104], %f100
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd104) + (0)))), (float)(f100));
  // PTX:460 add.s64 %rd105, %rd36, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd105) : "l"(rd36));
  // PTX:461 red.global.add.f32 [%rd105], %f102
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (0)))), (float)(f102));
  // PTX:462 add.s64 %rd106, %rd36, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd106) : "l"(rd36));
  // PTX:463 red.global.add.f32 [%rd106], %f103
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (0)))), (float)(f103));
  // PTX:464 add.s64 %rd107, %rd36, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd107) : "l"(rd36));
  // PTX:465 red.global.add.f32 [%rd107], %f101
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd107) + (0)))), (float)(f101));
  // PTX:466 add.s64 %rd108, %rd36, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd108) : "l"(rd36));
  // PTX:467 red.global.add.f32 [%rd108], %f103
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd108) + (0)))), (float)(f103));
  // PTX:468 add.s64 %rd109, %rd36, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd109) : "l"(rd36));
  // PTX:469 red.global.add.f32 [%rd109], %f104
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd109) + (0)))), (float)(f104));
  // PTX:470 setp.le.s32 %p17, %r87, %r86
  p17 = (((int)(r87)) <= ((int)(r86)));
  // PTX:471 setp.leu.f32 %p18, %f23, 0f00000000
  p18 = ((isnan(((float)(f23))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f23)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:472 or.pred %p19, %p18, %p17
  p19 = ((p18) || (p17));
  // PTX:473 @%p19 bra $L__BB2_18
  if (p19) { goto L_BB2_18; }
  // PTX:475 ld.global.f32 %f114, [%rd31]
  f114 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (0)))));
  // PTX:476 mul.f32 %f115, %f7, %f114
  asm("mul.f32 %0, %1, %2;" : "=f"(f115) : "f"(f7), "f"(f114));
  // PTX:477 ld.global.f32 %f116, [%rd34]
  f116 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (0)))));
  // PTX:478 mul.f32 %f117, %f115, %f116
  asm("mul.f32 %0, %1, %2;" : "=f"(f117) : "f"(f115), "f"(f116));
  // PTX:479 mul.f32 %f118, %f10, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f118) : "f"(f10), "f"(f14));
  // PTX:480 fma.rn.f32 %f119, %f9, %f13, %f118
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f119) : "f"(f9), "f"(f13), "f"(f118));
  // PTX:481 fma.rn.f32 %f120, %f11, %f15, %f119
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f120) : "f"(f11), "f"(f15), "f"(f119));
  // PTX:482 mul.f32 %f121, %f120, %f117
  asm("mul.f32 %0, %1, %2;" : "=f"(f121) : "f"(f120), "f"(f117));
  // PTX:483 add.f32 %f122, %f8, %f12
  asm("add.f32 %0, %1, %2;" : "=f"(f122) : "f"(f8), "f"(f12));
  // PTX:484 div.rn.f32 %f123, %f121, %f122
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f123) : "f"(f121), "f"(f122));
  // PTX:485 div.rn.f32 %f124, %f123, %f24
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f124) : "f"(f123), "f"(f24));
  // PTX:486 neg.f32 %f125, %f124
  asm("neg.f32 %0, %1;" : "=f"(f125) : "f"(f124));
  // PTX:487 add.s64 %rd121, %rd2, %rd98
  asm("add.s64 %0, %1, %2;" : "=l"(rd121) : "l"(rd2), "l"(rd98));
  // PTX:488 ld.global.f32 %f126, [%rd121]
  f126 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd121) + (0)))));
  // PTX:489 ld.global.f32 %f127, [%rd28]
  f127 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (0)))));
  // PTX:490 sub.f32 %f128, %f127, %f126
  asm("sub.f32 %0, %1, %2;" : "=f"(f128) : "f"(f127), "f"(f126));
  // PTX:491 ld.global.f32 %f129, [%rd121+4]
  f129 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd121) + (4)))));
  // PTX:492 ld.global.f32 %f130, [%rd28+4]
  f130 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (4)))));
  // PTX:493 sub.f32 %f131, %f130, %f129
  asm("sub.f32 %0, %1, %2;" : "=f"(f131) : "f"(f130), "f"(f129));
  // PTX:494 ld.global.f32 %f132, [%rd121+8]
  f132 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd121) + (8)))));
  // PTX:495 ld.global.f32 %f133, [%rd28+8]
  f133 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (8)))));
  // PTX:496 sub.f32 %f134, %f133, %f132
  asm("sub.f32 %0, %1, %2;" : "=f"(f134) : "f"(f133), "f"(f132));
  // PTX:497 sub.f32 %f135, %f9, %f128
  asm("sub.f32 %0, %1, %2;" : "=f"(f135) : "f"(f9), "f"(f128));
  // PTX:498 sub.f32 %f136, %f10, %f131
  asm("sub.f32 %0, %1, %2;" : "=f"(f136) : "f"(f10), "f"(f131));
  // PTX:499 sub.f32 %f137, %f11, %f134
  asm("sub.f32 %0, %1, %2;" : "=f"(f137) : "f"(f11), "f"(f134));
  // PTX:500 mul.f32 %f138, %f135, %f125
  asm("mul.f32 %0, %1, %2;" : "=f"(f138) : "f"(f135), "f"(f125));
  // PTX:501 mul.f32 %f139, %f136, %f125
  asm("mul.f32 %0, %1, %2;" : "=f"(f139) : "f"(f136), "f"(f125));
  // PTX:502 mul.f32 %f140, %f137, %f125
  asm("mul.f32 %0, %1, %2;" : "=f"(f140) : "f"(f137), "f"(f125));
  // PTX:503 red.global.add.f32 [%rd13], %f138
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))), (float)(f138));
  // PTX:504 red.global.add.f32 [%rd15], %f139
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))), (float)(f139));
  // PTX:505 red.global.add.f32 [%rd16], %f140
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))), (float)(f140));
  // PTX:506 neg.f32 %f144, %f138
  asm("neg.f32 %0, %1;" : "=f"(f144) : "f"(f138));
  // PTX:507 neg.f32 %f145, %f139
  asm("neg.f32 %0, %1;" : "=f"(f145) : "f"(f139));
  // PTX:508 neg.f32 %f146, %f140
  asm("neg.f32 %0, %1;" : "=f"(f146) : "f"(f140));
  // PTX:509 red.global.add.f32 [%rd35], %f144
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (0)))), (float)(f144));
  // PTX:510 red.global.add.f32 [%rd99], %f145
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (0)))), (float)(f145));
  // PTX:511 red.global.add.f32 [%rd100], %f146
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (0)))), (float)(f146));
  // PTX:512 red.global.add.f32 [%rd17], %f124
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))), (float)(f124));
  // PTX:513 red.global.add.f32 [%rd18], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:514 red.global.add.f32 [%rd19], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:515 red.global.add.f32 [%rd20], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:516 red.global.add.f32 [%rd21], %f124
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (0)))), (float)(f124));
  // PTX:517 red.global.add.f32 [%rd22], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:518 red.global.add.f32 [%rd23], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:519 red.global.add.f32 [%rd24], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:520 red.global.add.f32 [%rd25], %f124
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (0)))), (float)(f124));
  // PTX:521 red.global.add.f32 [%rd36], %f124
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (0)))), (float)(f124));
  // PTX:522 red.global.add.f32 [%rd102], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd102) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:523 red.global.add.f32 [%rd103], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd103) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:524 red.global.add.f32 [%rd104], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd104) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:525 red.global.add.f32 [%rd105], %f124
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (0)))), (float)(f124));
  // PTX:526 red.global.add.f32 [%rd106], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:527 red.global.add.f32 [%rd107], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd107) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:528 red.global.add.f32 [%rd108], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd108) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:529 red.global.add.f32 [%rd109], %f124
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd109) + (0)))), (float)(f124));
  // PTX:530 bra.uni $L__BB2_18
  goto L_BB2_18;
  // PTX:532 $L__BB2_27:
L_BB2_27:;
  // PTX:533 mul.hi.s32 %r94, %r137, 1431655766
  asm("mul.hi.s32 %0, %1, 1431655766;" : "=r"(r94) : "r"(r137));
  // PTX:534 shr.u32 %r95, %r94, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r95) : "r"(r94));
  // PTX:535 add.s32 %r96, %r94, %r95
  asm("add.s32 %0, %1, %2;" : "=r"(r96) : "r"(r94), "r"(r95));
  // PTX:536 mul.lo.s32 %r97, %r96, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r97) : "r"(r96));
  // PTX:537 sub.s32 %r98, %r137, %r97
  asm("sub.s32 %0, %1, %2;" : "=r"(r98) : "r"(r137), "r"(r97));
  // PTX:538 mul.hi.s32 %r99, %r96, 1431655766
  asm("mul.hi.s32 %0, %1, 1431655766;" : "=r"(r99) : "r"(r96));
  // PTX:539 shr.u32 %r100, %r99, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r100) : "r"(r99));
  // PTX:540 add.s32 %r101, %r99, %r100
  asm("add.s32 %0, %1, %2;" : "=r"(r101) : "r"(r99), "r"(r100));
  // PTX:541 mul.lo.s32 %r102, %r101, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r102) : "r"(r101));
  // PTX:542 sub.s32 %r103, %r96, %r102
  asm("sub.s32 %0, %1, %2;" : "=r"(r103) : "r"(r96), "r"(r102));
  // PTX:543 add.s32 %r133, %r4, %r98
  asm("add.s32 %0, %1, %2;" : "=r"(r133) : "r"(r4), "r"(r98));
  // PTX:544 add.s32 %r134, %r5, %r103
  asm("add.s32 %0, %1, %2;" : "=r"(r134) : "r"(r5), "r"(r103));
  // PTX:545 mul.hi.s32 %r104, %r137, 954437177
  asm("mul.hi.s32 %0, %1, 954437177;" : "=r"(r104) : "r"(r137));
  // PTX:546 shr.u32 %r105, %r104, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r105) : "r"(r104));
  // PTX:547 shr.s32 %r106, %r104, 1
  asm("shr.s32 %0, %1, 1;" : "=r"(r106) : "r"(r104));
  // PTX:548 add.s32 %r107, %r106, %r105
  asm("add.s32 %0, %1, %2;" : "=r"(r107) : "r"(r106), "r"(r105));
  // PTX:549 add.s32 %r135, %r6, %r107
  asm("add.s32 %0, %1, %2;" : "=r"(r135) : "r"(r6), "r"(r107));
  // PTX:550 add.s32 %r137, %r137, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r137) : "r"(r137));
  // PTX:551 mul.lo.s32 %r108, %r133, 73856093
  asm("mul.lo.s32 %0, %1, 73856093;" : "=r"(r108) : "r"(r133));
  // PTX:552 mul.lo.s32 %r109, %r134, 19349663
  asm("mul.lo.s32 %0, %1, 19349663;" : "=r"(r109) : "r"(r134));
  // PTX:553 mul.lo.s32 %r110, %r135, 83492791
  asm("mul.lo.s32 %0, %1, 83492791;" : "=r"(r110) : "r"(r135));
  // PTX:554 xor.b32 %r111, %r110, %r108
  asm("xor.b32 %0, %1, %2;" : "=r"(r111) : "r"(r110), "r"(r108));
  // PTX:555 xor.b32 %r112, %r111, %r109
  asm("xor.b32 %0, %1, %2;" : "=r"(r112) : "r"(r111), "r"(r109));
  // PTX:556 and.b32 %r113, %r112, %r7
  asm("and.b32 %0, %1, %2;" : "=r"(r113) : "r"(r112), "r"(r7));
  // PTX:557 mul.wide.s32 %rd127, %r113, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd127) : "r"(r113));
  // PTX:558 add.s64 %rd128, %rd4, %rd127
  asm("add.s64 %0, %1, %2;" : "=l"(rd128) : "l"(rd4), "l"(rd127));
  // PTX:559 ld.global.u32 %r140, [%rd128]
  r140 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd128) + (0)))));
  // PTX:561 $L__BB2_18:
L_BB2_18:;
  // PTX:562 setp.lt.s32 %p20, %r140, 0
  p20 = (((int)(r140)) < ((int)(0)));
  // PTX:563 @%p20 bra $L__BB2_26
  if (p20) { goto L_BB2_26; }
  // PTX:565 mov.u32 %r141, %r140
  asm("mov.u32 %0, %1;" : "=r"(r141) : "r"(r140));
  // PTX:567 $L__BB2_20:
L_BB2_20:;
  // PTX:568 cvt.s64.s32 %rd37, %r141
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd37) : "r"(r141));
  // PTX:569 mul.wide.s32 %rd122, %r141, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd122) : "r"(r141));
  // PTX:570 add.s64 %rd123, %rd5, %rd122
  asm("add.s64 %0, %1, %2;" : "=l"(rd123) : "l"(rd5), "l"(rd122));
  // PTX:571 ld.global.u32 %r140, [%rd123]
  r140 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd123) + (0)))));
  // PTX:572 mul.wide.s32 %rd124, %r141, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd124) : "r"(r141));
  // PTX:573 add.s64 %rd38, %rd8, %rd124
  asm("add.s64 %0, %1, %2;" : "=l"(rd38) : "l"(rd8), "l"(rd124));
  // PTX:574 ld.global.u32 %r89, [%rd38]
  r89 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (0)))));
  // PTX:575 setp.ne.s32 %p21, %r89, %r133
  p21 = (((int)(r89)) != ((int)(r133)));
  // PTX:576 mov.u16 %rs10, 0
  asm("mov.u16 %0, 0;" : "=h"(rs10) : );
  // PTX:577 @%p21 bra $L__BB2_23
  if (p21) { goto L_BB2_23; }
  // PTX:579 ld.global.u32 %r90, [%rd38+4]
  r90 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (4)))));
  // PTX:580 setp.ne.s32 %p22, %r90, %r134
  p22 = (((int)(r90)) != ((int)(r134)));
  // PTX:581 @%p22 bra $L__BB2_23
  if (p22) { goto L_BB2_23; }
  // PTX:583 ld.global.u32 %r91, [%rd38+8]
  r91 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (8)))));
  // PTX:584 setp.eq.s32 %p23, %r91, %r135
  p23 = (((int)(r91)) == ((int)(r135)));
  // PTX:585 selp.u16 %rs10, 1, 0, %p23
  rs10 = p23 ? 1 : 0;
  // PTX:587 $L__BB2_23:
L_BB2_23:;
  // PTX:588 setp.eq.s16 %p24, %rs10, 0
  p24 = (((short)(rs10)) == ((short)(0)));
  // PTX:589 @%p24 bra $L__BB2_25
  if (p24) { goto L_BB2_25; }
  // PTX:591 shl.b64 %rd125, %rd37, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd125) : "l"(rd37));
  // PTX:592 add.s64 %rd126, %rd7, %rd125
  asm("add.s64 %0, %1, %2;" : "=l"(rd126) : "l"(rd7), "l"(rd125));
  // PTX:593 ld.global.u32 %r92, [%rd126]
  r92 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd126) + (0)))));
  // PTX:594 setp.eq.s32 %p25, %r92, %r3
  p25 = (((int)(r92)) == ((int)(r3)));
  // PTX:595 setp.eq.s32 %p26, %r92, -1
  p26 = (((int)(r92)) == ((int)(-1)));
  // PTX:596 or.pred %p27, %p25, %p26
  p27 = ((p25) || (p26));
  // PTX:597 @%p27 bra $L__BB2_28
  if (p27) { goto L_BB2_28; }
  // PTX:599 $L__BB2_25:
L_BB2_25:;
  // PTX:600 setp.gt.s32 %p28, %r140, -1
  p28 = (((int)(r140)) > ((int)(-1)));
  // PTX:601 mov.u32 %r141, %r140
  asm("mov.u32 %0, %1;" : "=r"(r141) : "r"(r140));
  // PTX:602 @%p28 bra $L__BB2_20
  if (p28) { goto L_BB2_20; }
  // PTX:604 $L__BB2_26:
L_BB2_26:;
  // PTX:605 setp.eq.s32 %p29, %r137, 27
  p29 = (((int)(r137)) == ((int)(27)));
  // PTX:606 mov.u32 %r141, -1
  asm("mov.u32 %0, -1;" : "=r"(r141) : );
  // PTX:607 @%p29 bra $L__BB2_28
  if (p29) { goto L_BB2_28; }
  // PTX:608 bra.uni $L__BB2_27
  goto L_BB2_27;
  // PTX:610 $L__BB2_28:
L_BB2_28:;
  // PTX:611 setp.gt.s32 %p30, %r141, -1
  p30 = (((int)(r141)) > ((int)(-1)));
  // PTX:612 @%p30 bra $L__BB2_15
  if (p30) { goto L_BB2_15; }
  // PTX:614 $L__BB2_34:
L_BB2_34:;
  // PTX:615 ret
  return;
}
