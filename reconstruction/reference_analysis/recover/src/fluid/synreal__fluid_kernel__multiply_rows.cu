// 机械还原自 PTX：synreal::fluid_kernel::multiply_rows(synreal::fluid_kernel::View, glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*)
// PTX SHA256: 0ab617cd5012504d7f0242ea73825230799fdd1d356b911d16b806b19e4119ed
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__fluid_kernel__multiply_rows(ByVal<112, 8> param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57, p58, p59, p60, p61;
  unsigned short rs0, rs1, rs2, rs3, rs4, rs5, rs6, rs7, rs8, rs9, rs10, rs11, rs12, rs13, rs14, rs15, rs16, rs17, rs18, rs19, rs20;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121, r122, r123, r124, r125, r126, r127, r128, r129, r130, r131, r132, r133, r134, r135, r136, r137, r138, r139, r140, r141, r142, r143, r144, r145, r146, r147, r148, r149, r150, r151, r152, r153, r154, r155, r156, r157, r158, r159, r160, r161, r162, r163, r164, r165, r166, r167, r168, r169, r170, r171, r172, r173, r174, r175, r176, r177, r178, r179, r180, r181, r182, r183, r184, r185, r186, r187, r188, r189, r190, r191, r192, r193, r194, r195, r196, r197, r198, r199, r200, r201, r202, r203, r204, r205, r206, r207, r208, r209, r210, r211, r212, r213, r214, r215, r216, r217, r218, r219, r220, r221, r222, r223, r224, r225, r226, r227, r228, r229, r230, r231, r232, r233, r234, r235, r236, r237, r238, r239, r240, r241, r242, r243, r244, r245, r246, r247, r248, r249, r250, r251, r252, r253, r254, r255, r256, r257, r258, r259, r260, r261, r262, r263, r264, r265, r266, r267, r268, r269, r270, r271, r272, r273, r274, r275, r276, r277, r278, r279, r280, r281, r282, r283;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135, rd136, rd137, rd138, rd139, rd140, rd141, rd142, rd143, rd144, rd145, rd146, rd147, rd148, rd149, rd150, rd151, rd152, rd153, rd154, rd155, rd156, rd157, rd158, rd159, rd160, rd161, rd162, rd163, rd164, rd165, rd166, rd167, rd168, rd169, rd170, rd171, rd172, rd173, rd174, rd175, rd176, rd177, rd178, rd179, rd180, rd181, rd182, rd183, rd184, rd185, rd186, rd187, rd188, rd189, rd190, rd191, rd192;
  // PTX:22 ld.param.v2.u32 {%r100, %r101}, [_ZN7synreal12fluid_kernel13multiply_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS7_PS5__param_0+80]
  r100 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param0 + (80)))); r101 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param0 + (84))));
  // PTX:23 ld.param.v2.u32 {%r102, %r103}, [_ZN7synreal12fluid_kernel13multiply_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS7_PS5__param_0+88]
  r102 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param0 + (88)))); r103 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param0 + (92))));
  // PTX:24 ld.param.v2.f32 {%f50, %f51}, [_ZN7synreal12fluid_kernel13multiply_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS7_PS5__param_0+96]
  f50 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (96)))); f51 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (100))));
  // PTX:25 ld.param.v2.f32 {%f52, %f53}, [_ZN7synreal12fluid_kernel13multiply_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS7_PS5__param_0+104]
  f52 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (104)))); f53 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (108))));
  // PTX:26 ld.param.u64 %rd56, [_ZN7synreal12fluid_kernel13multiply_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS7_PS5__param_1]
  rd56 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:27 ld.param.u64 %rd57, [_ZN7synreal12fluid_kernel13multiply_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS7_PS5__param_2]
  rd57 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:28 ld.param.u64 %rd58, [_ZN7synreal12fluid_kernel13multiply_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS7_PS5__param_3]
  rd58 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:29 ld.param.u64 %rd59, [_ZN7synreal12fluid_kernel13multiply_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS7_PS5__param_4]
  rd59 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:30 ld.param.u64 %rd55, [_ZN7synreal12fluid_kernel13multiply_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS7_PS5__param_0+72]
  rd55 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (72))));
  // PTX:31 ld.param.u64 %rd54, [_ZN7synreal12fluid_kernel13multiply_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS7_PS5__param_0+64]
  rd54 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (64))));
  // PTX:32 ld.param.u64 %rd53, [_ZN7synreal12fluid_kernel13multiply_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS7_PS5__param_0+56]
  rd53 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (56))));
  // PTX:33 ld.param.u64 %rd52, [_ZN7synreal12fluid_kernel13multiply_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS7_PS5__param_0+48]
  rd52 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (48))));
  // PTX:34 ld.param.u64 %rd51, [_ZN7synreal12fluid_kernel13multiply_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS7_PS5__param_0+40]
  rd51 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (40))));
  // PTX:35 ld.param.u64 %rd50, [_ZN7synreal12fluid_kernel13multiply_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS7_PS5__param_0+32]
  rd50 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (32))));
  // PTX:36 ld.param.u64 %rd49, [_ZN7synreal12fluid_kernel13multiply_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS7_PS5__param_0+24]
  rd49 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (24))));
  // PTX:37 ld.param.u64 %rd48, [_ZN7synreal12fluid_kernel13multiply_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS7_PS5__param_0+16]
  rd48 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (16))));
  // PTX:38 ld.param.u64 %rd47, [_ZN7synreal12fluid_kernel13multiply_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS7_PS5__param_0+8]
  rd47 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (8))));
  // PTX:39 ld.param.u64 %rd46, [_ZN7synreal12fluid_kernel13multiply_rowsENS0_4ViewEPKN3glm3vecILi3EfLNS2_9qualifierE0EEEPKfS7_PS5__param_0]
  rd46 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:40 cvta.to.global.u64 %rd1, %rd59
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd59));
  // PTX:41 cvta.to.global.u64 %rd2, %rd58
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd58));
  // PTX:42 cvta.to.global.u64 %rd3, %rd46
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd46));
  // PTX:43 cvta.to.global.u64 %rd4, %rd47
  rd4 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd47));
  // PTX:44 cvta.to.global.u64 %rd5, %rd48
  rd5 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd48));
  // PTX:45 cvta.to.global.u64 %rd6, %rd49
  rd6 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd49));
  // PTX:46 cvta.to.global.u64 %rd7, %rd50
  rd7 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd50));
  // PTX:47 cvta.to.global.u64 %rd8, %rd51
  rd8 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd51));
  // PTX:48 cvta.to.global.u64 %rd9, %rd52
  rd9 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd52));
  // PTX:49 cvta.to.global.u64 %rd10, %rd54
  rd10 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd54));
  // PTX:50 cvta.to.global.u64 %rd11, %rd55
  rd11 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd55));
  // PTX:51 mov.u32 %r104, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r104) : "r"(blockDim.x));
  // PTX:52 mov.u32 %r105, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r105) : "r"(blockIdx.x));
  // PTX:53 mov.u32 %r106, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r106) : "r"(threadIdx.x));
  // PTX:54 mad.lo.s32 %r1, %r105, %r104, %r106
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r1) : "r"(r105), "r"(r104), "r"(r106));
  // PTX:55 setp.ge.s32 %p1, %r1, %r103
  p1 = (((int)(r1)) >= ((int)(r103)));
  // PTX:56 @%p1 bra $L__BB3_67
  if (p1) { goto L_BB3_67; }
  // PTX:58 cvta.to.global.u64 %rd60, %rd53
  rd60 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd53));
  // PTX:59 div.s32 %r107, %r1, %r102
  asm("div.s32 %0, %1, %2;" : "=r"(r107) : "r"(r1), "r"(r102));
  // PTX:60 mul.lo.s32 %r108, %r107, %r102
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r108) : "r"(r107), "r"(r102));
  // PTX:61 sub.s32 %r109, %r1, %r108
  asm("sub.s32 %0, %1, %2;" : "=r"(r109) : "r"(r1), "r"(r108));
  // PTX:62 mad.lo.s32 %r110, %r107, %r101, %r109
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r110) : "r"(r107), "r"(r101), "r"(r109));
  // PTX:63 cvt.s64.s32 %rd12, %r110
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd12) : "r"(r110));
  // PTX:64 mul.wide.s32 %rd61, %r110, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd61) : "r"(r110));
  // PTX:65 add.s64 %rd62, %rd5, %rd61
  asm("add.s64 %0, %1, %2;" : "=l"(rd62) : "l"(rd5), "l"(rd61));
  // PTX:66 cvt.s64.s32 %rd13, %r1
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd13) : "r"(r1));
  // PTX:67 cvta.to.global.u64 %rd63, %rd56
  rd63 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd56));
  // PTX:68 mul.wide.s32 %rd64, %r1, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd64) : "r"(r1));
  // PTX:69 add.s64 %rd65, %rd63, %rd64
  asm("add.s64 %0, %1, %2;" : "=l"(rd65) : "l"(rd63), "l"(rd64));
  // PTX:70 ld.global.u32 %r111, [%rd62]
  r111 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))));
  // PTX:71 cvt.s64.s32 %rd14, %r111
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd14) : "r"(r111));
  // PTX:72 mul.wide.s32 %rd66, %r111, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd66) : "r"(r111));
  // PTX:73 add.s64 %rd15, %rd2, %rd66
  asm("add.s64 %0, %1, %2;" : "=l"(rd15) : "l"(rd2), "l"(rd66));
  // PTX:74 ld.global.f32 %f54, [%rd15]
  f54 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))));
  // PTX:75 ld.global.f32 %f1, [%rd65]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (0)))));
  // PTX:76 ld.global.f32 %f55, [%rd15+4]
  f55 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (4)))));
  // PTX:77 ld.global.f32 %f2, [%rd65+4]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (4)))));
  // PTX:78 mul.f32 %f56, %f2, %f55
  asm("mul.f32 %0, %1, %2;" : "=f"(f56) : "f"(f2), "f"(f55));
  // PTX:79 ld.global.f32 %f57, [%rd15+8]
  f57 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (8)))));
  // PTX:80 ld.global.f32 %f3, [%rd65+8]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (8)))));
  // PTX:81 fma.rn.f32 %f58, %f1, %f54, %f56
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f58) : "f"(f1), "f"(f54), "f"(f56));
  // PTX:82 fma.rn.f32 %f248, %f3, %f57, %f58
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f248) : "f"(f3), "f"(f57), "f"(f58));
  // PTX:83 mul.wide.s32 %rd67, %r1, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd67) : "r"(r1));
  // PTX:84 add.s64 %rd16, %rd60, %rd67
  asm("add.s64 %0, %1, %2;" : "=l"(rd16) : "l"(rd60), "l"(rd67));
  // PTX:85 ld.global.u32 %r2, [%rd16]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:86 setp.lt.s32 %p2, %r2, 65
  p2 = (((int)(r2)) < ((int)(65)));
  // PTX:87 cvta.to.global.u64 %rd68, %rd57
  rd68 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd57));
  // PTX:88 add.s64 %rd17, %rd68, %rd67
  asm("add.s64 %0, %1, %2;" : "=l"(rd17) : "l"(rd68), "l"(rd67));
  // PTX:89 @%p2 bra $L__BB3_56
  if (p2) { goto L_BB3_56; }
  // PTX:90 bra.uni $L__BB3_2
  goto L_BB3_2;
  // PTX:92 $L__BB3_56:
L_BB3_56:;
  // PTX:93 setp.lt.s32 %p55, %r2, 1
  p55 = (((int)(r2)) < ((int)(1)));
  // PTX:94 @%p55 bra $L__BB3_63
  if (p55) { goto L_BB3_63; }
  // PTX:96 shl.b64 %rd38, %rd13, 6
  asm("shl.b64 %0, %1, 6;" : "=l"(rd38) : "l"(rd13));
  // PTX:97 and.b32 %r282, %r2, 3
  asm("and.b32 %0, %1, 3;" : "=r"(r282) : "r"(r2));
  // PTX:98 add.s32 %r215, %r2, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r215) : "r"(r2));
  // PTX:99 setp.lt.u32 %p56, %r215, 3
  p56 = (((unsigned)(r215)) < ((unsigned)(3)));
  // PTX:100 mov.u32 %r281, 0
  asm("mov.u32 %0, 0;" : "=r"(r281) : );
  // PTX:101 @%p56 bra $L__BB3_60
  if (p56) { goto L_BB3_60; }
  // PTX:103 sub.s32 %r280, %r2, %r282
  asm("sub.s32 %0, %1, %2;" : "=r"(r280) : "r"(r2), "r"(r282));
  // PTX:104 mov.u32 %r281, 0
  asm("mov.u32 %0, 0;" : "=r"(r281) : );
  // PTX:106 $L__BB3_59:
L_BB3_59:;
  // PTX:107 cvt.s64.s32 %rd134, %r281
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd134) : "r"(r281));
  // PTX:108 add.s64 %rd135, %rd38, %rd134
  asm("add.s64 %0, %1, %2;" : "=l"(rd135) : "l"(rd38), "l"(rd134));
  // PTX:109 shl.b64 %rd136, %rd135, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd136) : "l"(rd135));
  // PTX:110 add.s64 %rd137, %rd10, %rd136
  asm("add.s64 %0, %1, %2;" : "=l"(rd137) : "l"(rd10), "l"(rd136));
  // PTX:111 ld.global.u32 %r217, [%rd137]
  r217 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd137) + (0)))));
  // PTX:112 mul.wide.s32 %rd138, %r217, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd138) : "r"(r217));
  // PTX:113 add.s64 %rd139, %rd5, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd139) : "l"(rd5), "l"(rd138));
  // PTX:114 shl.b64 %rd140, %rd135, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd140) : "l"(rd135));
  // PTX:115 add.s64 %rd141, %rd11, %rd140
  asm("add.s64 %0, %1, %2;" : "=l"(rd141) : "l"(rd11), "l"(rd140));
  // PTX:116 ld.global.u32 %r218, [%rd139]
  r218 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd139) + (0)))));
  // PTX:117 mul.wide.s32 %rd142, %r218, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd142) : "r"(r218));
  // PTX:118 add.s64 %rd143, %rd2, %rd142
  asm("add.s64 %0, %1, %2;" : "=l"(rd143) : "l"(rd2), "l"(rd142));
  // PTX:119 ld.global.f32 %f164, [%rd143]
  f164 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd143) + (0)))));
  // PTX:120 ld.global.f32 %f165, [%rd141]
  f165 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd141) + (0)))));
  // PTX:121 ld.global.f32 %f166, [%rd143+4]
  f166 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd143) + (4)))));
  // PTX:122 ld.global.f32 %f167, [%rd141+4]
  f167 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd141) + (4)))));
  // PTX:123 mul.f32 %f168, %f167, %f166
  asm("mul.f32 %0, %1, %2;" : "=f"(f168) : "f"(f167), "f"(f166));
  // PTX:124 ld.global.f32 %f169, [%rd143+8]
  f169 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd143) + (8)))));
  // PTX:125 ld.global.f32 %f170, [%rd141+8]
  f170 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd141) + (8)))));
  // PTX:126 fma.rn.f32 %f171, %f165, %f164, %f168
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f171) : "f"(f165), "f"(f164), "f"(f168));
  // PTX:127 fma.rn.f32 %f172, %f170, %f169, %f171
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f172) : "f"(f170), "f"(f169), "f"(f171));
  // PTX:128 add.f32 %f173, %f248, %f172
  asm("add.f32 %0, %1, %2;" : "=f"(f173) : "f"(f248), "f"(f172));
  // PTX:129 ld.global.u32 %r219, [%rd137+4]
  r219 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd137) + (4)))));
  // PTX:130 mul.wide.s32 %rd144, %r219, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd144) : "r"(r219));
  // PTX:131 add.s64 %rd145, %rd5, %rd144
  asm("add.s64 %0, %1, %2;" : "=l"(rd145) : "l"(rd5), "l"(rd144));
  // PTX:132 ld.global.u32 %r220, [%rd145]
  r220 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd145) + (0)))));
  // PTX:133 mul.wide.s32 %rd146, %r220, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd146) : "r"(r220));
  // PTX:134 add.s64 %rd147, %rd2, %rd146
  asm("add.s64 %0, %1, %2;" : "=l"(rd147) : "l"(rd2), "l"(rd146));
  // PTX:135 ld.global.f32 %f174, [%rd147]
  f174 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd147) + (0)))));
  // PTX:136 ld.global.f32 %f175, [%rd141+16]
  f175 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd141) + (16)))));
  // PTX:137 ld.global.f32 %f176, [%rd147+4]
  f176 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd147) + (4)))));
  // PTX:138 ld.global.f32 %f177, [%rd141+20]
  f177 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd141) + (20)))));
  // PTX:139 mul.f32 %f178, %f177, %f176
  asm("mul.f32 %0, %1, %2;" : "=f"(f178) : "f"(f177), "f"(f176));
  // PTX:140 ld.global.f32 %f179, [%rd147+8]
  f179 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd147) + (8)))));
  // PTX:141 ld.global.f32 %f180, [%rd141+24]
  f180 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd141) + (24)))));
  // PTX:142 fma.rn.f32 %f181, %f175, %f174, %f178
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f181) : "f"(f175), "f"(f174), "f"(f178));
  // PTX:143 fma.rn.f32 %f182, %f180, %f179, %f181
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f182) : "f"(f180), "f"(f179), "f"(f181));
  // PTX:144 add.f32 %f183, %f173, %f182
  asm("add.f32 %0, %1, %2;" : "=f"(f183) : "f"(f173), "f"(f182));
  // PTX:145 ld.global.u32 %r221, [%rd137+8]
  r221 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd137) + (8)))));
  // PTX:146 mul.wide.s32 %rd148, %r221, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd148) : "r"(r221));
  // PTX:147 add.s64 %rd149, %rd5, %rd148
  asm("add.s64 %0, %1, %2;" : "=l"(rd149) : "l"(rd5), "l"(rd148));
  // PTX:148 ld.global.u32 %r222, [%rd149]
  r222 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd149) + (0)))));
  // PTX:149 mul.wide.s32 %rd150, %r222, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd150) : "r"(r222));
  // PTX:150 add.s64 %rd151, %rd2, %rd150
  asm("add.s64 %0, %1, %2;" : "=l"(rd151) : "l"(rd2), "l"(rd150));
  // PTX:151 ld.global.f32 %f184, [%rd151]
  f184 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd151) + (0)))));
  // PTX:152 ld.global.f32 %f185, [%rd141+32]
  f185 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd141) + (32)))));
  // PTX:153 ld.global.f32 %f186, [%rd151+4]
  f186 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd151) + (4)))));
  // PTX:154 ld.global.f32 %f187, [%rd141+36]
  f187 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd141) + (36)))));
  // PTX:155 mul.f32 %f188, %f187, %f186
  asm("mul.f32 %0, %1, %2;" : "=f"(f188) : "f"(f187), "f"(f186));
  // PTX:156 ld.global.f32 %f189, [%rd151+8]
  f189 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd151) + (8)))));
  // PTX:157 ld.global.f32 %f190, [%rd141+40]
  f190 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd141) + (40)))));
  // PTX:158 fma.rn.f32 %f191, %f185, %f184, %f188
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f191) : "f"(f185), "f"(f184), "f"(f188));
  // PTX:159 fma.rn.f32 %f192, %f190, %f189, %f191
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f192) : "f"(f190), "f"(f189), "f"(f191));
  // PTX:160 add.f32 %f193, %f183, %f192
  asm("add.f32 %0, %1, %2;" : "=f"(f193) : "f"(f183), "f"(f192));
  // PTX:161 ld.global.u32 %r223, [%rd137+12]
  r223 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd137) + (12)))));
  // PTX:162 mul.wide.s32 %rd152, %r223, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd152) : "r"(r223));
  // PTX:163 add.s64 %rd153, %rd5, %rd152
  asm("add.s64 %0, %1, %2;" : "=l"(rd153) : "l"(rd5), "l"(rd152));
  // PTX:164 ld.global.u32 %r224, [%rd153]
  r224 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd153) + (0)))));
  // PTX:165 mul.wide.s32 %rd154, %r224, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd154) : "r"(r224));
  // PTX:166 add.s64 %rd155, %rd2, %rd154
  asm("add.s64 %0, %1, %2;" : "=l"(rd155) : "l"(rd2), "l"(rd154));
  // PTX:167 ld.global.f32 %f194, [%rd155]
  f194 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd155) + (0)))));
  // PTX:168 ld.global.f32 %f195, [%rd141+48]
  f195 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd141) + (48)))));
  // PTX:169 ld.global.f32 %f196, [%rd155+4]
  f196 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd155) + (4)))));
  // PTX:170 ld.global.f32 %f197, [%rd141+52]
  f197 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd141) + (52)))));
  // PTX:171 mul.f32 %f198, %f197, %f196
  asm("mul.f32 %0, %1, %2;" : "=f"(f198) : "f"(f197), "f"(f196));
  // PTX:172 ld.global.f32 %f199, [%rd155+8]
  f199 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd155) + (8)))));
  // PTX:173 ld.global.f32 %f200, [%rd141+56]
  f200 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd141) + (56)))));
  // PTX:174 fma.rn.f32 %f201, %f195, %f194, %f198
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f201) : "f"(f195), "f"(f194), "f"(f198));
  // PTX:175 fma.rn.f32 %f202, %f200, %f199, %f201
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f202) : "f"(f200), "f"(f199), "f"(f201));
  // PTX:176 add.f32 %f248, %f193, %f202
  asm("add.f32 %0, %1, %2;" : "=f"(f248) : "f"(f193), "f"(f202));
  // PTX:177 add.s32 %r281, %r281, 4
  asm("add.s32 %0, %1, 4;" : "=r"(r281) : "r"(r281));
  // PTX:178 add.s32 %r280, %r280, -4
  asm("add.s32 %0, %1, -4;" : "=r"(r280) : "r"(r280));
  // PTX:179 setp.ne.s32 %p57, %r280, 0
  p57 = (((int)(r280)) != ((int)(0)));
  // PTX:180 @%p57 bra $L__BB3_59
  if (p57) { goto L_BB3_59; }
  // PTX:182 $L__BB3_60:
L_BB3_60:;
  // PTX:183 setp.eq.s32 %p58, %r282, 0
  p58 = (((int)(r282)) == ((int)(0)));
  // PTX:184 @%p58 bra $L__BB3_63
  if (p58) { goto L_BB3_63; }
  // PTX:186 cvt.s64.s32 %rd156, %r281
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd156) : "r"(r281));
  // PTX:187 add.s64 %rd157, %rd38, %rd156
  asm("add.s64 %0, %1, %2;" : "=l"(rd157) : "l"(rd38), "l"(rd156));
  // PTX:188 shl.b64 %rd158, %rd157, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd158) : "l"(rd157));
  // PTX:189 add.s64 %rd192, %rd11, %rd158
  asm("add.s64 %0, %1, %2;" : "=l"(rd192) : "l"(rd11), "l"(rd158));
  // PTX:190 shl.b64 %rd159, %rd157, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd159) : "l"(rd157));
  // PTX:191 add.s64 %rd191, %rd10, %rd159
  asm("add.s64 %0, %1, %2;" : "=l"(rd191) : "l"(rd10), "l"(rd159));
  // PTX:193 $L__BB3_62:
L_BB3_62:;
  // PTX:195 ld.global.u32 %r225, [%rd191]
  r225 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd191) + (0)))));
  // PTX:196 mul.wide.s32 %rd160, %r225, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd160) : "r"(r225));
  // PTX:197 add.s64 %rd161, %rd5, %rd160
  asm("add.s64 %0, %1, %2;" : "=l"(rd161) : "l"(rd5), "l"(rd160));
  // PTX:198 ld.global.u32 %r226, [%rd161]
  r226 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd161) + (0)))));
  // PTX:199 mul.wide.s32 %rd162, %r226, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd162) : "r"(r226));
  // PTX:200 add.s64 %rd163, %rd2, %rd162
  asm("add.s64 %0, %1, %2;" : "=l"(rd163) : "l"(rd2), "l"(rd162));
  // PTX:201 ld.global.f32 %f203, [%rd163]
  f203 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd163) + (0)))));
  // PTX:202 ld.global.f32 %f204, [%rd192]
  f204 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd192) + (0)))));
  // PTX:203 ld.global.f32 %f205, [%rd163+4]
  f205 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd163) + (4)))));
  // PTX:204 ld.global.f32 %f206, [%rd192+4]
  f206 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd192) + (4)))));
  // PTX:205 mul.f32 %f207, %f206, %f205
  asm("mul.f32 %0, %1, %2;" : "=f"(f207) : "f"(f206), "f"(f205));
  // PTX:206 ld.global.f32 %f208, [%rd163+8]
  f208 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd163) + (8)))));
  // PTX:207 ld.global.f32 %f209, [%rd192+8]
  f209 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd192) + (8)))));
  // PTX:208 fma.rn.f32 %f210, %f204, %f203, %f207
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f210) : "f"(f204), "f"(f203), "f"(f207));
  // PTX:209 fma.rn.f32 %f211, %f209, %f208, %f210
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f211) : "f"(f209), "f"(f208), "f"(f210));
  // PTX:210 add.f32 %f248, %f248, %f211
  asm("add.f32 %0, %1, %2;" : "=f"(f248) : "f"(f248), "f"(f211));
  // PTX:211 add.s64 %rd192, %rd192, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd192) : "l"(rd192));
  // PTX:212 add.s64 %rd191, %rd191, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd191) : "l"(rd191));
  // PTX:213 add.s32 %r282, %r282, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r282) : "r"(r282));
  // PTX:214 setp.ne.s32 %p59, %r282, 0
  p59 = (((int)(r282)) != ((int)(0)));
  // PTX:215 @%p59 bra $L__BB3_62
  if (p59) { goto L_BB3_62; }
  // PTX:217 $L__BB3_63:
L_BB3_63:;
  // PTX:218 ld.global.f32 %f212, [%rd17]
  f212 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:219 mul.f32 %f33, %f248, %f212
  asm("mul.f32 %0, %1, %2;" : "=f"(f33) : "f"(f248), "f"(f212));
  // PTX:220 mul.f32 %f252, %f1, %f33
  asm("mul.f32 %0, %1, %2;" : "=f"(f252) : "f"(f1), "f"(f33));
  // PTX:221 mul.f32 %f253, %f33, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f253) : "f"(f33), "f"(f2));
  // PTX:222 mul.f32 %f254, %f33, %f3
  asm("mul.f32 %0, %1, %2;" : "=f"(f254) : "f"(f33), "f"(f3));
  // PTX:223 @%p55 bra $L__BB3_66
  if (p55) { goto L_BB3_66; }
  // PTX:225 shl.b64 %rd45, %rd13, 6
  asm("shl.b64 %0, %1, 6;" : "=l"(rd45) : "l"(rd13));
  // PTX:226 mov.u32 %r283, 0
  asm("mov.u32 %0, 0;" : "=r"(r283) : );
  // PTX:228 $L__BB3_65:
L_BB3_65:;
  // PTX:229 cvt.s64.s32 %rd164, %r283
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd164) : "r"(r283));
  // PTX:230 add.s64 %rd165, %rd45, %rd164
  asm("add.s64 %0, %1, %2;" : "=l"(rd165) : "l"(rd45), "l"(rd164));
  // PTX:231 shl.b64 %rd166, %rd165, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd166) : "l"(rd165));
  // PTX:232 add.s64 %rd167, %rd10, %rd166
  asm("add.s64 %0, %1, %2;" : "=l"(rd167) : "l"(rd10), "l"(rd166));
  // PTX:233 ld.global.u32 %r228, [%rd167]
  r228 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd167) + (0)))));
  // PTX:234 mul.wide.s32 %rd168, %r228, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd168) : "r"(r228));
  // PTX:235 add.s64 %rd169, %rd5, %rd168
  asm("add.s64 %0, %1, %2;" : "=l"(rd169) : "l"(rd5), "l"(rd168));
  // PTX:236 shl.b64 %rd170, %rd165, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd170) : "l"(rd165));
  // PTX:237 add.s64 %rd171, %rd11, %rd170
  asm("add.s64 %0, %1, %2;" : "=l"(rd171) : "l"(rd11), "l"(rd170));
  // PTX:238 ld.global.u32 %r229, [%rd169]
  r229 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd169) + (0)))));
  // PTX:239 mul.wide.s32 %rd172, %r229, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd172) : "r"(r229));
  // PTX:240 add.s64 %rd173, %rd2, %rd172
  asm("add.s64 %0, %1, %2;" : "=l"(rd173) : "l"(rd2), "l"(rd172));
  // PTX:241 ld.global.f32 %f213, [%rd173]
  f213 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd173) + (0)))));
  // PTX:242 ld.global.f32 %f214, [%rd15]
  f214 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))));
  // PTX:243 sub.f32 %f215, %f214, %f213
  asm("sub.f32 %0, %1, %2;" : "=f"(f215) : "f"(f214), "f"(f213));
  // PTX:244 ld.global.f32 %f216, [%rd173+4]
  f216 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd173) + (4)))));
  // PTX:245 ld.global.f32 %f217, [%rd15+4]
  f217 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (4)))));
  // PTX:246 sub.f32 %f218, %f217, %f216
  asm("sub.f32 %0, %1, %2;" : "=f"(f218) : "f"(f217), "f"(f216));
  // PTX:247 ld.global.f32 %f219, [%rd173+8]
  f219 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd173) + (8)))));
  // PTX:248 ld.global.f32 %f220, [%rd15+8]
  f220 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (8)))));
  // PTX:249 sub.f32 %f221, %f220, %f219
  asm("sub.f32 %0, %1, %2;" : "=f"(f221) : "f"(f220), "f"(f219));
  // PTX:250 ld.global.f32 %f222, [%rd171+12]
  f222 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd171) + (12)))));
  // PTX:251 mul.f32 %f223, %f222, %f215
  asm("mul.f32 %0, %1, %2;" : "=f"(f223) : "f"(f222), "f"(f215));
  // PTX:252 mul.f32 %f224, %f222, %f218
  asm("mul.f32 %0, %1, %2;" : "=f"(f224) : "f"(f222), "f"(f218));
  // PTX:253 mul.f32 %f225, %f222, %f221
  asm("mul.f32 %0, %1, %2;" : "=f"(f225) : "f"(f222), "f"(f221));
  // PTX:254 add.f32 %f252, %f252, %f223
  asm("add.f32 %0, %1, %2;" : "=f"(f252) : "f"(f252), "f"(f223));
  // PTX:255 add.f32 %f253, %f253, %f224
  asm("add.f32 %0, %1, %2;" : "=f"(f253) : "f"(f253), "f"(f224));
  // PTX:256 add.f32 %f254, %f254, %f225
  asm("add.f32 %0, %1, %2;" : "=f"(f254) : "f"(f254), "f"(f225));
  // PTX:257 add.s64 %rd174, %rd1, %rd172
  asm("add.s64 %0, %1, %2;" : "=l"(rd174) : "l"(rd1), "l"(rd172));
  // PTX:258 ld.global.f32 %f226, [%rd171]
  f226 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd171) + (0)))));
  // PTX:259 mul.f32 %f227, %f33, %f226
  asm("mul.f32 %0, %1, %2;" : "=f"(f227) : "f"(f33), "f"(f226));
  // PTX:260 ld.global.f32 %f228, [%rd171+4]
  f228 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd171) + (4)))));
  // PTX:261 mul.f32 %f229, %f33, %f228
  asm("mul.f32 %0, %1, %2;" : "=f"(f229) : "f"(f33), "f"(f228));
  // PTX:262 ld.global.f32 %f230, [%rd171+8]
  f230 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd171) + (8)))));
  // PTX:263 mul.f32 %f231, %f33, %f230
  asm("mul.f32 %0, %1, %2;" : "=f"(f231) : "f"(f33), "f"(f230));
  // PTX:264 sub.f32 %f232, %f227, %f223
  asm("sub.f32 %0, %1, %2;" : "=f"(f232) : "f"(f227), "f"(f223));
  // PTX:265 sub.f32 %f233, %f229, %f224
  asm("sub.f32 %0, %1, %2;" : "=f"(f233) : "f"(f229), "f"(f224));
  // PTX:266 sub.f32 %f234, %f231, %f225
  asm("sub.f32 %0, %1, %2;" : "=f"(f234) : "f"(f231), "f"(f225));
  // PTX:267 red.global.add.f32 [%rd174], %f232
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd174) + (0)))), (float)(f232));
  // PTX:268 add.s64 %rd175, %rd174, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd175) : "l"(rd174));
  // PTX:269 red.global.add.f32 [%rd175], %f233
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd175) + (0)))), (float)(f233));
  // PTX:270 add.s64 %rd176, %rd174, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd176) : "l"(rd174));
  // PTX:271 red.global.add.f32 [%rd176], %f234
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd176) + (0)))), (float)(f234));
  // PTX:272 ld.global.u32 %r230, [%rd16]
  r230 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:273 add.s32 %r283, %r283, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r283) : "r"(r283));
  // PTX:274 setp.lt.s32 %p61, %r283, %r230
  p61 = (((int)(r283)) < ((int)(r230)));
  // PTX:275 @%p61 bra $L__BB3_65
  if (p61) { goto L_BB3_65; }
  // PTX:277 $L__BB3_66:
L_BB3_66:;
  // PTX:278 mul.lo.s64 %rd177, %rd14, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd177) : "l"(rd14));
  // PTX:279 add.s64 %rd178, %rd1, %rd177
  asm("add.s64 %0, %1, %2;" : "=l"(rd178) : "l"(rd1), "l"(rd177));
  // PTX:280 red.global.add.f32 [%rd178], %f252
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd178) + (0)))), (float)(f252));
  // PTX:281 add.s64 %rd179, %rd178, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd179) : "l"(rd178));
  // PTX:282 red.global.add.f32 [%rd179], %f253
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd179) + (0)))), (float)(f253));
  // PTX:283 add.s64 %rd180, %rd178, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd180) : "l"(rd178));
  // PTX:284 red.global.add.f32 [%rd180], %f254
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (0)))), (float)(f254));
  // PTX:285 bra.uni $L__BB3_67
  goto L_BB3_67;
  // PTX:287 $L__BB3_2:
L_BB3_2:;
  // PTX:288 mul.lo.s64 %rd69, %rd12, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd69) : "l"(rd12));
  // PTX:289 add.s64 %rd18, %rd7, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd18) : "l"(rd7), "l"(rd69));
  // PTX:290 shl.b64 %rd70, %rd12, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd70) : "l"(rd12));
  // PTX:291 add.s64 %rd19, %rd6, %rd70
  asm("add.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd6), "l"(rd70));
  // PTX:292 ld.global.u32 %r3, [%rd19]
  r3 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))));
  // PTX:293 ld.global.u32 %r115, [%rd18]
  r115 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (0)))));
  // PTX:294 add.s32 %r4, %r115, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r4) : "r"(r115));
  // PTX:295 mov.u32 %r253, -1
  asm("mov.u32 %0, -1;" : "=r"(r253) : );
  // PTX:296 ld.global.u32 %r116, [%rd18+4]
  r116 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (4)))));
  // PTX:297 add.s32 %r5, %r116, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r5) : "r"(r116));
  // PTX:298 ld.global.u32 %r117, [%rd18+8]
  r117 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (8)))));
  // PTX:299 add.s32 %r6, %r117, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r6) : "r"(r117));
  // PTX:300 add.s32 %r7, %r100, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r7) : "r"(r100));
  // PTX:301 mov.u32 %r250, 0
  asm("mov.u32 %0, 0;" : "=r"(r250) : );
  // PTX:302 bra.uni $L__BB3_3
  goto L_BB3_3;
  // PTX:304 $L__BB3_12:
L_BB3_12:;
  // PTX:305 mul.wide.u32 %rd76, %r250, -1431655765
  asm("mul.wide.u32 %0, %1, -1431655765;" : "=l"(rd76) : "r"(r250));
  // PTX:306 shr.u64 %rd77, %rd76, 33
  asm("shr.u64 %0, %1, 33;" : "=l"(rd77) : "l"(rd76));
  // PTX:307 cvt.u32.u64 %r123, %rd77
  asm("cvt.u32.u64 %0, %1;" : "=r"(r123) : "l"(rd77));
  // PTX:308 mul.lo.s32 %r124, %r123, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r124) : "r"(r123));
  // PTX:309 sub.s32 %r125, %r250, %r124
  asm("sub.s32 %0, %1, %2;" : "=r"(r125) : "r"(r250), "r"(r124));
  // PTX:310 mul.wide.u32 %rd78, %r123, -1431655765
  asm("mul.wide.u32 %0, %1, -1431655765;" : "=l"(rd78) : "r"(r123));
  // PTX:311 shr.u64 %rd79, %rd78, 33
  asm("shr.u64 %0, %1, 33;" : "=l"(rd79) : "l"(rd78));
  // PTX:312 cvt.u32.u64 %r126, %rd79
  asm("cvt.u32.u64 %0, %1;" : "=r"(r126) : "l"(rd79));
  // PTX:313 mul.lo.s32 %r127, %r126, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r127) : "r"(r126));
  // PTX:314 sub.s32 %r128, %r123, %r127
  asm("sub.s32 %0, %1, %2;" : "=r"(r128) : "r"(r123), "r"(r127));
  // PTX:315 add.s32 %r246, %r4, %r125
  asm("add.s32 %0, %1, %2;" : "=r"(r246) : "r"(r4), "r"(r125));
  // PTX:316 add.s32 %r247, %r5, %r128
  asm("add.s32 %0, %1, %2;" : "=r"(r247) : "r"(r5), "r"(r128));
  // PTX:317 mul.wide.u32 %rd80, %r250, 954437177
  asm("mul.wide.u32 %0, %1, 954437177;" : "=l"(rd80) : "r"(r250));
  // PTX:318 shr.u64 %rd81, %rd80, 33
  asm("shr.u64 %0, %1, 33;" : "=l"(rd81) : "l"(rd80));
  // PTX:319 cvt.u32.u64 %r129, %rd81
  asm("cvt.u32.u64 %0, %1;" : "=r"(r129) : "l"(rd81));
  // PTX:320 add.s32 %r248, %r6, %r129
  asm("add.s32 %0, %1, %2;" : "=r"(r248) : "r"(r6), "r"(r129));
  // PTX:321 add.s32 %r250, %r250, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r250) : "r"(r250));
  // PTX:322 mul.lo.s32 %r130, %r246, 73856093
  asm("mul.lo.s32 %0, %1, 73856093;" : "=r"(r130) : "r"(r246));
  // PTX:323 mul.lo.s32 %r131, %r247, 19349663
  asm("mul.lo.s32 %0, %1, 19349663;" : "=r"(r131) : "r"(r247));
  // PTX:324 mul.lo.s32 %r132, %r248, 83492791
  asm("mul.lo.s32 %0, %1, 83492791;" : "=r"(r132) : "r"(r248));
  // PTX:325 xor.b32 %r133, %r132, %r130
  asm("xor.b32 %0, %1, %2;" : "=r"(r133) : "r"(r132), "r"(r130));
  // PTX:326 xor.b32 %r134, %r133, %r131
  asm("xor.b32 %0, %1, %2;" : "=r"(r134) : "r"(r133), "r"(r131));
  // PTX:327 and.b32 %r135, %r134, %r7
  asm("and.b32 %0, %1, %2;" : "=r"(r135) : "r"(r134), "r"(r7));
  // PTX:328 mul.wide.s32 %rd82, %r135, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd82) : "r"(r135));
  // PTX:329 add.s64 %rd83, %rd3, %rd82
  asm("add.s64 %0, %1, %2;" : "=l"(rd83) : "l"(rd3), "l"(rd82));
  // PTX:330 ld.global.u32 %r253, [%rd83]
  r253 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (0)))));
  // PTX:332 $L__BB3_3:
L_BB3_3:;
  // PTX:333 setp.lt.s32 %p3, %r253, 0
  p3 = (((int)(r253)) < ((int)(0)));
  // PTX:334 @%p3 bra $L__BB3_11
  if (p3) { goto L_BB3_11; }
  // PTX:336 mov.u32 %r254, %r253
  asm("mov.u32 %0, %1;" : "=r"(r254) : "r"(r253));
  // PTX:338 $L__BB3_5:
L_BB3_5:;
  // PTX:339 mul.wide.s32 %rd71, %r254, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd71) : "r"(r254));
  // PTX:340 add.s64 %rd72, %rd4, %rd71
  asm("add.s64 %0, %1, %2;" : "=l"(rd72) : "l"(rd4), "l"(rd71));
  // PTX:341 ld.global.u32 %r253, [%rd72]
  r253 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (0)))));
  // PTX:342 mul.wide.s32 %rd73, %r254, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd73) : "r"(r254));
  // PTX:343 add.s64 %rd21, %rd7, %rd73
  asm("add.s64 %0, %1, %2;" : "=l"(rd21) : "l"(rd7), "l"(rd73));
  // PTX:344 ld.global.u32 %r118, [%rd21]
  r118 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (0)))));
  // PTX:345 setp.ne.s32 %p4, %r118, %r246
  p4 = (((int)(r118)) != ((int)(r246)));
  // PTX:346 mov.u16 %rs17, 0
  asm("mov.u16 %0, 0;" : "=h"(rs17) : );
  // PTX:347 @%p4 bra $L__BB3_8
  if (p4) { goto L_BB3_8; }
  // PTX:349 mul.wide.s32 %rd188, %r254, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd188) : "r"(r254));
  // PTX:350 add.s64 %rd187, %rd7, %rd188
  asm("add.s64 %0, %1, %2;" : "=l"(rd187) : "l"(rd7), "l"(rd188));
  // PTX:351 ld.global.u32 %r119, [%rd187+4]
  r119 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd187) + (4)))));
  // PTX:352 setp.ne.s32 %p5, %r119, %r247
  p5 = (((int)(r119)) != ((int)(r247)));
  // PTX:353 @%p5 bra $L__BB3_8
  if (p5) { goto L_BB3_8; }
  // PTX:355 mul.wide.s32 %rd190, %r254, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd190) : "r"(r254));
  // PTX:356 add.s64 %rd189, %rd7, %rd190
  asm("add.s64 %0, %1, %2;" : "=l"(rd189) : "l"(rd7), "l"(rd190));
  // PTX:357 ld.global.u32 %r120, [%rd189+8]
  r120 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd189) + (8)))));
  // PTX:358 setp.eq.s32 %p6, %r120, %r248
  p6 = (((int)(r120)) == ((int)(r248)));
  // PTX:359 selp.u16 %rs17, 1, 0, %p6
  rs17 = p6 ? 1 : 0;
  // PTX:361 $L__BB3_8:
L_BB3_8:;
  // PTX:362 setp.eq.s16 %p7, %rs17, 0
  p7 = (((short)(rs17)) == ((short)(0)));
  // PTX:363 @%p7 bra $L__BB3_10
  if (p7) { goto L_BB3_10; }
  // PTX:365 cvt.s64.s32 %rd181, %r254
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd181) : "r"(r254));
  // PTX:366 shl.b64 %rd74, %rd181, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd74) : "l"(rd181));
  // PTX:367 add.s64 %rd75, %rd6, %rd74
  asm("add.s64 %0, %1, %2;" : "=l"(rd75) : "l"(rd6), "l"(rd74));
  // PTX:368 ld.global.u32 %r121, [%rd75]
  r121 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (0)))));
  // PTX:369 setp.eq.s32 %p8, %r121, %r3
  p8 = (((int)(r121)) == ((int)(r3)));
  // PTX:370 setp.eq.s32 %p9, %r121, -1
  p9 = (((int)(r121)) == ((int)(-1)));
  // PTX:371 or.pred %p10, %p8, %p9
  p10 = ((p8) || (p9));
  // PTX:372 @%p10 bra $L__BB3_13
  if (p10) { goto L_BB3_13; }
  // PTX:374 $L__BB3_10:
L_BB3_10:;
  // PTX:375 setp.gt.s32 %p11, %r253, -1
  p11 = (((int)(r253)) > ((int)(-1)));
  // PTX:376 mov.u32 %r254, %r253
  asm("mov.u32 %0, %1;" : "=r"(r254) : "r"(r253));
  // PTX:377 @%p11 bra $L__BB3_5
  if (p11) { goto L_BB3_5; }
  // PTX:379 $L__BB3_11:
L_BB3_11:;
  // PTX:380 setp.eq.s32 %p12, %r250, 27
  p12 = (((int)(r250)) == ((int)(27)));
  // PTX:381 mov.u32 %r254, -1
  asm("mov.u32 %0, -1;" : "=r"(r254) : );
  // PTX:382 @%p12 bra $L__BB3_13
  if (p12) { goto L_BB3_13; }
  // PTX:383 bra.uni $L__BB3_12
  goto L_BB3_12;
  // PTX:385 $L__BB3_13:
L_BB3_13:;
  // PTX:386 add.s64 %rd22, %rd8, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd22) : "l"(rd8), "l"(rd69));
  // PTX:387 setp.lt.s32 %p13, %r254, 0
  p13 = (((int)(r254)) < ((int)(0)));
  // PTX:388 @%p13 bra $L__BB3_29
  if (p13) { goto L_BB3_29; }
  // PTX:390 mul.f32 %f8, %f50, %f50
  asm("mul.f32 %0, %1, %2;" : "=f"(f8) : "f"(f50), "f"(f50));
  // PTX:391 mul.f32 %f59, %f50, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f59) : "f"(f50), "f"(f8));
  // PTX:392 mul.f32 %f60, %f50, %f59
  asm("mul.f32 %0, %1, %2;" : "=f"(f60) : "f"(f50), "f"(f59));
  // PTX:393 mul.f32 %f9, %f50, %f60
  asm("mul.f32 %0, %1, %2;" : "=f"(f9) : "f"(f50), "f"(f60));
  // PTX:394 cvt.u32.u64 %r136, %rd12
  asm("cvt.u32.u64 %0, %1;" : "=r"(r136) : "l"(rd12));
  // PTX:396 $L__BB3_15:
L_BB3_15:;
  // PTX:397 setp.eq.s32 %p14, %r136, %r254
  p14 = (((int)(r136)) == ((int)(r254)));
  // PTX:398 @%p14 bra $L__BB3_18
  if (p14) { goto L_BB3_18; }
  // PTX:400 cvt.s64.s32 %rd23, %r254
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd23) : "r"(r254));
  // PTX:401 mul.wide.s32 %rd85, %r254, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd85) : "r"(r254));
  // PTX:402 add.s64 %rd86, %rd5, %rd85
  asm("add.s64 %0, %1, %2;" : "=l"(rd86) : "l"(rd5), "l"(rd85));
  // PTX:403 ld.global.u32 %r29, [%rd86]
  r29 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd86) + (0)))));
  // PTX:404 setp.lt.s32 %p15, %r29, 0
  p15 = (((int)(r29)) < ((int)(0)));
  // PTX:405 @%p15 bra $L__BB3_18
  if (p15) { goto L_BB3_18; }
  // PTX:407 shl.b64 %rd87, %rd23, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd87) : "l"(rd23));
  // PTX:408 add.s64 %rd88, %rd9, %rd87
  asm("add.s64 %0, %1, %2;" : "=l"(rd88) : "l"(rd9), "l"(rd87));
  // PTX:409 mul.lo.s64 %rd89, %rd23, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd89) : "l"(rd23));
  // PTX:410 add.s64 %rd90, %rd8, %rd89
  asm("add.s64 %0, %1, %2;" : "=l"(rd90) : "l"(rd8), "l"(rd89));
  // PTX:411 ld.global.f32 %f61, [%rd90]
  f61 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (0)))));
  // PTX:412 ld.global.f32 %f62, [%rd22]
  f62 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (0)))));
  // PTX:413 sub.f32 %f63, %f62, %f61
  asm("sub.f32 %0, %1, %2;" : "=f"(f63) : "f"(f62), "f"(f61));
  // PTX:414 ld.global.f32 %f64, [%rd90+4]
  f64 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (4)))));
  // PTX:415 ld.global.f32 %f65, [%rd22+4]
  f65 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (4)))));
  // PTX:416 sub.f32 %f66, %f65, %f64
  asm("sub.f32 %0, %1, %2;" : "=f"(f66) : "f"(f65), "f"(f64));
  // PTX:417 ld.global.f32 %f67, [%rd90+8]
  f67 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (8)))));
  // PTX:418 ld.global.f32 %f68, [%rd22+8]
  f68 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (8)))));
  // PTX:419 sub.f32 %f69, %f68, %f67
  asm("sub.f32 %0, %1, %2;" : "=f"(f69) : "f"(f68), "f"(f67));
  // PTX:420 mul.f32 %f70, %f66, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f70) : "f"(f66), "f"(f66));
  // PTX:421 fma.rn.f32 %f71, %f63, %f63, %f70
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f71) : "f"(f63), "f"(f63), "f"(f70));
  // PTX:422 fma.rn.f32 %f72, %f69, %f69, %f71
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f72) : "f"(f69), "f"(f69), "f"(f71));
  // PTX:423 div.rn.f32 %f73, %f72, %f8
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f73) : "f"(f72), "f"(f8));
  // PTX:424 mov.f32 %f74, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f74) : );
  // PTX:425 sub.f32 %f75, %f74, %f73
  asm("sub.f32 %0, %1, %2;" : "=f"(f75) : "f"(f74), "f"(f73));
  // PTX:426 mov.f32 %f76, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f76) : );
  // PTX:427 max.f32 %f77, %f75, %f76
  asm("max.f32 %0, %1, %2;" : "=f"(f77) : "f"(f75), "f"(f76));
  // PTX:428 mul.f32 %f78, %f77, 0fC11666C3
  asm("mul.f32 %0, %1, 0fC11666C3;" : "=f"(f78) : "f"(f77));
  // PTX:429 mul.f32 %f79, %f77, %f78
  asm("mul.f32 %0, %1, %2;" : "=f"(f79) : "f"(f77), "f"(f78));
  // PTX:430 mul.f32 %f80, %f63, %f79
  asm("mul.f32 %0, %1, %2;" : "=f"(f80) : "f"(f63), "f"(f79));
  // PTX:431 mul.f32 %f81, %f66, %f79
  asm("mul.f32 %0, %1, %2;" : "=f"(f81) : "f"(f66), "f"(f79));
  // PTX:432 mul.f32 %f82, %f69, %f79
  asm("mul.f32 %0, %1, %2;" : "=f"(f82) : "f"(f69), "f"(f79));
  // PTX:433 div.rn.f32 %f83, %f80, %f9
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f83) : "f"(f80), "f"(f9));
  // PTX:434 div.rn.f32 %f84, %f81, %f9
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f84) : "f"(f81), "f"(f9));
  // PTX:435 div.rn.f32 %f85, %f82, %f9
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f85) : "f"(f82), "f"(f9));
  // PTX:436 mul.wide.s32 %rd91, %r29, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd91) : "r"(r29));
  // PTX:437 add.s64 %rd92, %rd2, %rd91
  asm("add.s64 %0, %1, %2;" : "=l"(rd92) : "l"(rd2), "l"(rd91));
  // PTX:438 ld.global.f32 %f86, [%rd92]
  f86 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (0)))));
  // PTX:439 ld.global.f32 %f87, [%rd92+4]
  f87 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (4)))));
  // PTX:440 mul.f32 %f88, %f87, %f84
  asm("mul.f32 %0, %1, %2;" : "=f"(f88) : "f"(f87), "f"(f84));
  // PTX:441 ld.global.f32 %f89, [%rd92+8]
  f89 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (8)))));
  // PTX:442 fma.rn.f32 %f90, %f86, %f83, %f88
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f90) : "f"(f86), "f"(f83), "f"(f88));
  // PTX:443 fma.rn.f32 %f91, %f85, %f89, %f90
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f91) : "f"(f85), "f"(f89), "f"(f90));
  // PTX:444 ld.global.f32 %f92, [%rd88]
  f92 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (0)))));
  // PTX:445 mul.f32 %f93, %f92, %f91
  asm("mul.f32 %0, %1, %2;" : "=f"(f93) : "f"(f92), "f"(f91));
  // PTX:446 sub.f32 %f248, %f248, %f93
  asm("sub.f32 %0, %1, %2;" : "=f"(f248) : "f"(f248), "f"(f93));
  // PTX:447 bra.uni $L__BB3_18
  goto L_BB3_18;
  // PTX:449 $L__BB3_27:
L_BB3_27:;
  // PTX:450 mul.hi.s32 %r142, %r250, 1431655766
  asm("mul.hi.s32 %0, %1, 1431655766;" : "=r"(r142) : "r"(r250));
  // PTX:451 shr.u32 %r143, %r142, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r143) : "r"(r142));
  // PTX:452 add.s32 %r144, %r142, %r143
  asm("add.s32 %0, %1, %2;" : "=r"(r144) : "r"(r142), "r"(r143));
  // PTX:453 mul.lo.s32 %r145, %r144, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r145) : "r"(r144));
  // PTX:454 sub.s32 %r146, %r250, %r145
  asm("sub.s32 %0, %1, %2;" : "=r"(r146) : "r"(r250), "r"(r145));
  // PTX:455 mul.hi.s32 %r147, %r144, 1431655766
  asm("mul.hi.s32 %0, %1, 1431655766;" : "=r"(r147) : "r"(r144));
  // PTX:456 shr.u32 %r148, %r147, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r148) : "r"(r147));
  // PTX:457 add.s32 %r149, %r147, %r148
  asm("add.s32 %0, %1, %2;" : "=r"(r149) : "r"(r147), "r"(r148));
  // PTX:458 mul.lo.s32 %r150, %r149, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r150) : "r"(r149));
  // PTX:459 sub.s32 %r151, %r144, %r150
  asm("sub.s32 %0, %1, %2;" : "=r"(r151) : "r"(r144), "r"(r150));
  // PTX:460 add.s32 %r246, %r4, %r146
  asm("add.s32 %0, %1, %2;" : "=r"(r246) : "r"(r4), "r"(r146));
  // PTX:461 add.s32 %r247, %r5, %r151
  asm("add.s32 %0, %1, %2;" : "=r"(r247) : "r"(r5), "r"(r151));
  // PTX:462 mul.hi.s32 %r152, %r250, 954437177
  asm("mul.hi.s32 %0, %1, 954437177;" : "=r"(r152) : "r"(r250));
  // PTX:463 shr.u32 %r153, %r152, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r153) : "r"(r152));
  // PTX:464 shr.s32 %r154, %r152, 1
  asm("shr.s32 %0, %1, 1;" : "=r"(r154) : "r"(r152));
  // PTX:465 add.s32 %r155, %r154, %r153
  asm("add.s32 %0, %1, %2;" : "=r"(r155) : "r"(r154), "r"(r153));
  // PTX:466 add.s32 %r248, %r6, %r155
  asm("add.s32 %0, %1, %2;" : "=r"(r248) : "r"(r6), "r"(r155));
  // PTX:467 add.s32 %r250, %r250, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r250) : "r"(r250));
  // PTX:468 mul.lo.s32 %r156, %r246, 73856093
  asm("mul.lo.s32 %0, %1, 73856093;" : "=r"(r156) : "r"(r246));
  // PTX:469 mul.lo.s32 %r157, %r247, 19349663
  asm("mul.lo.s32 %0, %1, 19349663;" : "=r"(r157) : "r"(r247));
  // PTX:470 mul.lo.s32 %r158, %r248, 83492791
  asm("mul.lo.s32 %0, %1, 83492791;" : "=r"(r158) : "r"(r248));
  // PTX:471 xor.b32 %r159, %r158, %r156
  asm("xor.b32 %0, %1, %2;" : "=r"(r159) : "r"(r158), "r"(r156));
  // PTX:472 xor.b32 %r160, %r159, %r157
  asm("xor.b32 %0, %1, %2;" : "=r"(r160) : "r"(r159), "r"(r157));
  // PTX:473 and.b32 %r161, %r160, %r7
  asm("and.b32 %0, %1, %2;" : "=r"(r161) : "r"(r160), "r"(r7));
  // PTX:474 mul.wide.s32 %rd98, %r161, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd98) : "r"(r161));
  // PTX:475 add.s64 %rd99, %rd3, %rd98
  asm("add.s64 %0, %1, %2;" : "=l"(rd99) : "l"(rd3), "l"(rd98));
  // PTX:476 ld.global.u32 %r253, [%rd99]
  r253 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (0)))));
  // PTX:478 $L__BB3_18:
L_BB3_18:;
  // PTX:479 setp.lt.s32 %p16, %r253, 0
  p16 = (((int)(r253)) < ((int)(0)));
  // PTX:480 @%p16 bra $L__BB3_26
  if (p16) { goto L_BB3_26; }
  // PTX:482 mov.u32 %r254, %r253
  asm("mov.u32 %0, %1;" : "=r"(r254) : "r"(r253));
  // PTX:484 $L__BB3_20:
L_BB3_20:;
  // PTX:485 mul.wide.s32 %rd93, %r254, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd93) : "r"(r254));
  // PTX:486 add.s64 %rd94, %rd4, %rd93
  asm("add.s64 %0, %1, %2;" : "=l"(rd94) : "l"(rd4), "l"(rd93));
  // PTX:487 ld.global.u32 %r253, [%rd94]
  r253 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd94) + (0)))));
  // PTX:488 mul.wide.s32 %rd95, %r254, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd95) : "r"(r254));
  // PTX:489 add.s64 %rd25, %rd7, %rd95
  asm("add.s64 %0, %1, %2;" : "=l"(rd25) : "l"(rd7), "l"(rd95));
  // PTX:490 ld.global.u32 %r137, [%rd25]
  r137 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (0)))));
  // PTX:491 setp.ne.s32 %p17, %r137, %r246
  p17 = (((int)(r137)) != ((int)(r246)));
  // PTX:492 mov.u16 %rs18, 0
  asm("mov.u16 %0, 0;" : "=h"(rs18) : );
  // PTX:493 @%p17 bra $L__BB3_23
  if (p17) { goto L_BB3_23; }
  // PTX:495 ld.global.u32 %r138, [%rd25+4]
  r138 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (4)))));
  // PTX:496 setp.ne.s32 %p18, %r138, %r247
  p18 = (((int)(r138)) != ((int)(r247)));
  // PTX:497 @%p18 bra $L__BB3_23
  if (p18) { goto L_BB3_23; }
  // PTX:499 ld.global.u32 %r139, [%rd25+8]
  r139 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (8)))));
  // PTX:500 setp.eq.s32 %p19, %r139, %r248
  p19 = (((int)(r139)) == ((int)(r248)));
  // PTX:501 selp.u16 %rs18, 1, 0, %p19
  rs18 = p19 ? 1 : 0;
  // PTX:503 $L__BB3_23:
L_BB3_23:;
  // PTX:504 setp.eq.s16 %p20, %rs18, 0
  p20 = (((short)(rs18)) == ((short)(0)));
  // PTX:505 @%p20 bra $L__BB3_25
  if (p20) { goto L_BB3_25; }
  // PTX:507 cvt.s64.s32 %rd186, %r254
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd186) : "r"(r254));
  // PTX:508 shl.b64 %rd96, %rd186, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd96) : "l"(rd186));
  // PTX:509 add.s64 %rd97, %rd6, %rd96
  asm("add.s64 %0, %1, %2;" : "=l"(rd97) : "l"(rd6), "l"(rd96));
  // PTX:510 ld.global.u32 %r140, [%rd97]
  r140 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd97) + (0)))));
  // PTX:511 setp.eq.s32 %p21, %r140, %r3
  p21 = (((int)(r140)) == ((int)(r3)));
  // PTX:512 setp.eq.s32 %p22, %r140, -1
  p22 = (((int)(r140)) == ((int)(-1)));
  // PTX:513 or.pred %p23, %p21, %p22
  p23 = ((p21) || (p22));
  // PTX:514 @%p23 bra $L__BB3_28
  if (p23) { goto L_BB3_28; }
  // PTX:516 $L__BB3_25:
L_BB3_25:;
  // PTX:517 setp.gt.s32 %p24, %r253, -1
  p24 = (((int)(r253)) > ((int)(-1)));
  // PTX:518 mov.u32 %r254, %r253
  asm("mov.u32 %0, %1;" : "=r"(r254) : "r"(r253));
  // PTX:519 @%p24 bra $L__BB3_20
  if (p24) { goto L_BB3_20; }
  // PTX:521 $L__BB3_26:
L_BB3_26:;
  // PTX:522 setp.eq.s32 %p25, %r250, 27
  p25 = (((int)(r250)) == ((int)(27)));
  // PTX:523 mov.u32 %r254, -1
  asm("mov.u32 %0, -1;" : "=r"(r254) : );
  // PTX:524 @%p25 bra $L__BB3_28
  if (p25) { goto L_BB3_28; }
  // PTX:525 bra.uni $L__BB3_27
  goto L_BB3_27;
  // PTX:527 $L__BB3_28:
L_BB3_28:;
  // PTX:528 setp.gt.s32 %p26, %r254, -1
  p26 = (((int)(r254)) > ((int)(-1)));
  // PTX:529 @%p26 bra $L__BB3_15
  if (p26) { goto L_BB3_15; }
  // PTX:531 $L__BB3_29:
L_BB3_29:;
  // PTX:532 shl.b64 %rd184, %rd12, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd184) : "l"(rd12));
  // PTX:533 add.s64 %rd183, %rd6, %rd184
  asm("add.s64 %0, %1, %2;" : "=l"(rd183) : "l"(rd6), "l"(rd184));
  // PTX:534 cvt.s64.s32 %rd182, %r111
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd182) : "r"(r111));
  // PTX:535 ld.global.f32 %f94, [%rd17]
  f94 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:536 mul.f32 %f14, %f248, %f94
  asm("mul.f32 %0, %1, %2;" : "=f"(f14) : "f"(f248), "f"(f94));
  // PTX:537 mul.f32 %f95, %f1, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f95) : "f"(f1), "f"(f14));
  // PTX:538 mul.f32 %f96, %f14, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f96) : "f"(f14), "f"(f2));
  // PTX:539 mul.f32 %f97, %f14, %f3
  asm("mul.f32 %0, %1, %2;" : "=f"(f97) : "f"(f14), "f"(f3));
  // PTX:540 mul.lo.s64 %rd100, %rd182, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd100) : "l"(rd182));
  // PTX:541 add.s64 %rd26, %rd1, %rd100
  asm("add.s64 %0, %1, %2;" : "=l"(rd26) : "l"(rd1), "l"(rd100));
  // PTX:542 red.global.add.f32 [%rd26], %f95
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (0)))), (float)(f95));
  // PTX:543 add.s64 %rd27, %rd26, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd27) : "l"(rd26));
  // PTX:544 red.global.add.f32 [%rd27], %f96
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))), (float)(f96));
  // PTX:545 add.s64 %rd28, %rd26, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd28) : "l"(rd26));
  // PTX:546 red.global.add.f32 [%rd28], %f97
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (0)))), (float)(f97));
  // PTX:547 ld.global.u32 %r45, [%rd183]
  r45 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd183) + (0)))));
  // PTX:548 ld.global.u32 %r165, [%rd18]
  r165 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (0)))));
  // PTX:549 add.s32 %r46, %r165, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r46) : "r"(r165));
  // PTX:550 mov.u32 %r277, -1
  asm("mov.u32 %0, -1;" : "=r"(r277) : );
  // PTX:551 ld.global.u32 %r166, [%rd18+4]
  r166 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (4)))));
  // PTX:552 add.s32 %r47, %r166, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r47) : "r"(r166));
  // PTX:553 ld.global.u32 %r167, [%rd18+8]
  r167 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (8)))));
  // PTX:554 add.s32 %r48, %r167, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r48) : "r"(r167));
  // PTX:555 mov.u32 %r274, 0
  asm("mov.u32 %0, 0;" : "=r"(r274) : );
  // PTX:556 bra.uni $L__BB3_30
  goto L_BB3_30;
  // PTX:558 $L__BB3_39:
L_BB3_39:;
  // PTX:559 mul.wide.u32 %rd106, %r274, -1431655765
  asm("mul.wide.u32 %0, %1, -1431655765;" : "=l"(rd106) : "r"(r274));
  // PTX:560 shr.u64 %rd107, %rd106, 33
  asm("shr.u64 %0, %1, 33;" : "=l"(rd107) : "l"(rd106));
  // PTX:561 cvt.u32.u64 %r173, %rd107
  asm("cvt.u32.u64 %0, %1;" : "=r"(r173) : "l"(rd107));
  // PTX:562 mul.lo.s32 %r174, %r173, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r174) : "r"(r173));
  // PTX:563 sub.s32 %r175, %r274, %r174
  asm("sub.s32 %0, %1, %2;" : "=r"(r175) : "r"(r274), "r"(r174));
  // PTX:564 mul.wide.u32 %rd108, %r173, -1431655765
  asm("mul.wide.u32 %0, %1, -1431655765;" : "=l"(rd108) : "r"(r173));
  // PTX:565 shr.u64 %rd109, %rd108, 33
  asm("shr.u64 %0, %1, 33;" : "=l"(rd109) : "l"(rd108));
  // PTX:566 cvt.u32.u64 %r176, %rd109
  asm("cvt.u32.u64 %0, %1;" : "=r"(r176) : "l"(rd109));
  // PTX:567 mul.lo.s32 %r177, %r176, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r177) : "r"(r176));
  // PTX:568 sub.s32 %r178, %r173, %r177
  asm("sub.s32 %0, %1, %2;" : "=r"(r178) : "r"(r173), "r"(r177));
  // PTX:569 add.s32 %r270, %r46, %r175
  asm("add.s32 %0, %1, %2;" : "=r"(r270) : "r"(r46), "r"(r175));
  // PTX:570 add.s32 %r271, %r47, %r178
  asm("add.s32 %0, %1, %2;" : "=r"(r271) : "r"(r47), "r"(r178));
  // PTX:571 mul.wide.u32 %rd110, %r274, 954437177
  asm("mul.wide.u32 %0, %1, 954437177;" : "=l"(rd110) : "r"(r274));
  // PTX:572 shr.u64 %rd111, %rd110, 33
  asm("shr.u64 %0, %1, 33;" : "=l"(rd111) : "l"(rd110));
  // PTX:573 cvt.u32.u64 %r179, %rd111
  asm("cvt.u32.u64 %0, %1;" : "=r"(r179) : "l"(rd111));
  // PTX:574 add.s32 %r272, %r48, %r179
  asm("add.s32 %0, %1, %2;" : "=r"(r272) : "r"(r48), "r"(r179));
  // PTX:575 add.s32 %r274, %r274, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r274) : "r"(r274));
  // PTX:576 mul.lo.s32 %r180, %r270, 73856093
  asm("mul.lo.s32 %0, %1, 73856093;" : "=r"(r180) : "r"(r270));
  // PTX:577 mul.lo.s32 %r181, %r271, 19349663
  asm("mul.lo.s32 %0, %1, 19349663;" : "=r"(r181) : "r"(r271));
  // PTX:578 mul.lo.s32 %r182, %r272, 83492791
  asm("mul.lo.s32 %0, %1, 83492791;" : "=r"(r182) : "r"(r272));
  // PTX:579 xor.b32 %r183, %r182, %r180
  asm("xor.b32 %0, %1, %2;" : "=r"(r183) : "r"(r182), "r"(r180));
  // PTX:580 xor.b32 %r184, %r183, %r181
  asm("xor.b32 %0, %1, %2;" : "=r"(r184) : "r"(r183), "r"(r181));
  // PTX:581 and.b32 %r185, %r184, %r7
  asm("and.b32 %0, %1, %2;" : "=r"(r185) : "r"(r184), "r"(r7));
  // PTX:582 mul.wide.s32 %rd112, %r185, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd112) : "r"(r185));
  // PTX:583 add.s64 %rd113, %rd3, %rd112
  asm("add.s64 %0, %1, %2;" : "=l"(rd113) : "l"(rd3), "l"(rd112));
  // PTX:584 ld.global.u32 %r277, [%rd113]
  r277 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd113) + (0)))));
  // PTX:586 $L__BB3_30:
L_BB3_30:;
  // PTX:587 setp.lt.s32 %p27, %r277, 0
  p27 = (((int)(r277)) < ((int)(0)));
  // PTX:588 @%p27 bra $L__BB3_38
  if (p27) { goto L_BB3_38; }
  // PTX:590 mov.u32 %r278, %r277
  asm("mov.u32 %0, %1;" : "=r"(r278) : "r"(r277));
  // PTX:592 $L__BB3_32:
L_BB3_32:;
  // PTX:593 cvt.s64.s32 %rd29, %r278
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd29) : "r"(r278));
  // PTX:594 mul.wide.s32 %rd101, %r278, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd101) : "r"(r278));
  // PTX:595 add.s64 %rd102, %rd4, %rd101
  asm("add.s64 %0, %1, %2;" : "=l"(rd102) : "l"(rd4), "l"(rd101));
  // PTX:596 ld.global.u32 %r277, [%rd102]
  r277 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd102) + (0)))));
  // PTX:597 mul.wide.s32 %rd103, %r278, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd103) : "r"(r278));
  // PTX:598 add.s64 %rd30, %rd7, %rd103
  asm("add.s64 %0, %1, %2;" : "=l"(rd30) : "l"(rd7), "l"(rd103));
  // PTX:599 ld.global.u32 %r168, [%rd30]
  r168 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0)))));
  // PTX:600 setp.ne.s32 %p28, %r168, %r270
  p28 = (((int)(r168)) != ((int)(r270)));
  // PTX:601 mov.u16 %rs19, 0
  asm("mov.u16 %0, 0;" : "=h"(rs19) : );
  // PTX:602 @%p28 bra $L__BB3_35
  if (p28) { goto L_BB3_35; }
  // PTX:604 ld.global.u32 %r169, [%rd30+4]
  r169 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (4)))));
  // PTX:605 setp.ne.s32 %p29, %r169, %r271
  p29 = (((int)(r169)) != ((int)(r271)));
  // PTX:606 @%p29 bra $L__BB3_35
  if (p29) { goto L_BB3_35; }
  // PTX:608 ld.global.u32 %r170, [%rd30+8]
  r170 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (8)))));
  // PTX:609 setp.eq.s32 %p30, %r170, %r272
  p30 = (((int)(r170)) == ((int)(r272)));
  // PTX:610 selp.u16 %rs19, 1, 0, %p30
  rs19 = p30 ? 1 : 0;
  // PTX:612 $L__BB3_35:
L_BB3_35:;
  // PTX:613 setp.eq.s16 %p31, %rs19, 0
  p31 = (((short)(rs19)) == ((short)(0)));
  // PTX:614 @%p31 bra $L__BB3_37
  if (p31) { goto L_BB3_37; }
  // PTX:616 shl.b64 %rd104, %rd29, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd104) : "l"(rd29));
  // PTX:617 add.s64 %rd105, %rd6, %rd104
  asm("add.s64 %0, %1, %2;" : "=l"(rd105) : "l"(rd6), "l"(rd104));
  // PTX:618 ld.global.u32 %r171, [%rd105]
  r171 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (0)))));
  // PTX:619 setp.eq.s32 %p32, %r171, %r45
  p32 = (((int)(r171)) == ((int)(r45)));
  // PTX:620 setp.eq.s32 %p33, %r171, -1
  p33 = (((int)(r171)) == ((int)(-1)));
  // PTX:621 or.pred %p34, %p32, %p33
  p34 = ((p32) || (p33));
  // PTX:622 @%p34 bra $L__BB3_40
  if (p34) { goto L_BB3_40; }
  // PTX:624 $L__BB3_37:
L_BB3_37:;
  // PTX:625 setp.gt.s32 %p35, %r277, -1
  p35 = (((int)(r277)) > ((int)(-1)));
  // PTX:626 mov.u32 %r278, %r277
  asm("mov.u32 %0, %1;" : "=r"(r278) : "r"(r277));
  // PTX:627 @%p35 bra $L__BB3_32
  if (p35) { goto L_BB3_32; }
  // PTX:629 $L__BB3_38:
L_BB3_38:;
  // PTX:630 setp.eq.s32 %p36, %r274, 27
  p36 = (((int)(r274)) == ((int)(27)));
  // PTX:631 mov.u32 %r278, -1
  asm("mov.u32 %0, -1;" : "=r"(r278) : );
  // PTX:632 @%p36 bra $L__BB3_40
  if (p36) { goto L_BB3_40; }
  // PTX:633 bra.uni $L__BB3_39
  goto L_BB3_39;
  // PTX:635 $L__BB3_40:
L_BB3_40:;
  // PTX:636 setp.lt.s32 %p37, %r278, 0
  p37 = (((int)(r278)) < ((int)(0)));
  // PTX:637 @%p37 bra $L__BB3_67
  if (p37) { goto L_BB3_67; }
  // PTX:639 shl.b64 %rd185, %rd12, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd185) : "l"(rd12));
  // PTX:640 mul.f32 %f15, %f50, %f50
  asm("mul.f32 %0, %1, %2;" : "=f"(f15) : "f"(f50), "f"(f50));
  // PTX:641 mul.f32 %f101, %f50, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f101) : "f"(f50), "f"(f15));
  // PTX:642 mul.f32 %f102, %f50, %f101
  asm("mul.f32 %0, %1, %2;" : "=f"(f102) : "f"(f50), "f"(f101));
  // PTX:643 mul.f32 %f16, %f50, %f102
  asm("mul.f32 %0, %1, %2;" : "=f"(f16) : "f"(f50), "f"(f102));
  // PTX:644 mul.f32 %f17, %f52, 0fC0000000
  asm("mul.f32 %0, %1, 0fC0000000;" : "=f"(f17) : "f"(f52));
  // PTX:645 add.s64 %rd31, %rd9, %rd185
  asm("add.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd9), "l"(rd185));
  // PTX:646 mul.f32 %f103, %f50, 0f3C23D70A
  asm("mul.f32 %0, %1, 0f3C23D70A;" : "=f"(f103) : "f"(f50));
  // PTX:647 mul.f32 %f18, %f50, %f103
  asm("mul.f32 %0, %1, %2;" : "=f"(f18) : "f"(f50), "f"(f103));
  // PTX:648 cvt.u32.u64 %r186, %rd12
  asm("cvt.u32.u64 %0, %1;" : "=r"(r186) : "l"(rd12));
  // PTX:650 $L__BB3_42:
L_BB3_42:;
  // PTX:651 cvt.s64.s32 %rd32, %r278
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd32) : "r"(r278));
  // PTX:652 mul.wide.s32 %rd115, %r278, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd115) : "r"(r278));
  // PTX:653 add.s64 %rd116, %rd5, %rd115
  asm("add.s64 %0, %1, %2;" : "=l"(rd116) : "l"(rd5), "l"(rd115));
  // PTX:654 ld.global.s32 %rd33, [%rd116]
  rd33 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd116) + (0)))));
  // PTX:655 setp.eq.s32 %p38, %r186, %r278
  p38 = (((int)(r186)) == ((int)(r278)));
  // PTX:656 setp.lt.s64 %p39, %rd33, 0
  p39 = (((long long)(rd33)) < ((long long)(0)));
  // PTX:657 or.pred %p40, %p38, %p39
  p40 = ((p38) || (p39));
  // PTX:658 @%p40 bra $L__BB3_45
  if (p40) { goto L_BB3_45; }
  // PTX:660 cvt.u32.u64 %r187, %rd32
  asm("cvt.u32.u64 %0, %1;" : "=r"(r187) : "l"(rd32));
  // PTX:661 mul.lo.s64 %rd117, %rd32, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd117) : "l"(rd32));
  // PTX:662 add.s64 %rd118, %rd8, %rd117
  asm("add.s64 %0, %1, %2;" : "=l"(rd118) : "l"(rd8), "l"(rd117));
  // PTX:663 ld.global.f32 %f104, [%rd118]
  f104 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd118) + (0)))));
  // PTX:664 ld.global.f32 %f105, [%rd22]
  f105 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (0)))));
  // PTX:665 sub.f32 %f19, %f105, %f104
  asm("sub.f32 %0, %1, %2;" : "=f"(f19) : "f"(f105), "f"(f104));
  // PTX:666 ld.global.f32 %f106, [%rd118+4]
  f106 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd118) + (4)))));
  // PTX:667 ld.global.f32 %f107, [%rd22+4]
  f107 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (4)))));
  // PTX:668 sub.f32 %f20, %f107, %f106
  asm("sub.f32 %0, %1, %2;" : "=f"(f20) : "f"(f107), "f"(f106));
  // PTX:669 ld.global.f32 %f108, [%rd118+8]
  f108 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd118) + (8)))));
  // PTX:670 ld.global.f32 %f109, [%rd22+8]
  f109 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (8)))));
  // PTX:671 sub.f32 %f21, %f109, %f108
  asm("sub.f32 %0, %1, %2;" : "=f"(f21) : "f"(f109), "f"(f108));
  // PTX:672 shl.b64 %rd119, %rd32, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd119) : "l"(rd32));
  // PTX:673 add.s64 %rd34, %rd9, %rd119
  asm("add.s64 %0, %1, %2;" : "=l"(rd34) : "l"(rd9), "l"(rd119));
  // PTX:674 ld.global.f32 %f110, [%rd34]
  f110 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (0)))));
  // PTX:675 mul.f32 %f111, %f14, %f110
  asm("mul.f32 %0, %1, %2;" : "=f"(f111) : "f"(f14), "f"(f110));
  // PTX:676 neg.f32 %f112, %f111
  asm("neg.f32 %0, %1;" : "=f"(f112) : "f"(f111));
  // PTX:677 mul.f32 %f113, %f20, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f113) : "f"(f20), "f"(f20));
  // PTX:678 fma.rn.f32 %f114, %f19, %f19, %f113
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f114) : "f"(f19), "f"(f19), "f"(f113));
  // PTX:679 fma.rn.f32 %f22, %f21, %f21, %f114
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f22) : "f"(f21), "f"(f21), "f"(f114));
  // PTX:680 div.rn.f32 %f115, %f22, %f15
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f115) : "f"(f22), "f"(f15));
  // PTX:681 mov.f32 %f116, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f116) : );
  // PTX:682 sub.f32 %f117, %f116, %f115
  asm("sub.f32 %0, %1, %2;" : "=f"(f117) : "f"(f116), "f"(f115));
  // PTX:683 mov.f32 %f118, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f118) : );
  // PTX:684 max.f32 %f119, %f117, %f118
  asm("max.f32 %0, %1, %2;" : "=f"(f119) : "f"(f117), "f"(f118));
  // PTX:685 mul.f32 %f120, %f119, 0fC11666C3
  asm("mul.f32 %0, %1, 0fC11666C3;" : "=f"(f120) : "f"(f119));
  // PTX:686 mul.f32 %f121, %f119, %f120
  asm("mul.f32 %0, %1, %2;" : "=f"(f121) : "f"(f119), "f"(f120));
  // PTX:687 mul.f32 %f122, %f19, %f121
  asm("mul.f32 %0, %1, %2;" : "=f"(f122) : "f"(f19), "f"(f121));
  // PTX:688 mul.f32 %f123, %f20, %f121
  asm("mul.f32 %0, %1, %2;" : "=f"(f123) : "f"(f20), "f"(f121));
  // PTX:689 mul.f32 %f124, %f21, %f121
  asm("mul.f32 %0, %1, %2;" : "=f"(f124) : "f"(f21), "f"(f121));
  // PTX:690 div.rn.f32 %f23, %f122, %f16
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f23) : "f"(f122), "f"(f16));
  // PTX:691 div.rn.f32 %f24, %f123, %f16
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f24) : "f"(f123), "f"(f16));
  // PTX:692 div.rn.f32 %f25, %f124, %f16
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f25) : "f"(f124), "f"(f16));
  // PTX:693 mul.f32 %f125, %f23, %f112
  asm("mul.f32 %0, %1, %2;" : "=f"(f125) : "f"(f23), "f"(f112));
  // PTX:694 mul.f32 %f126, %f24, %f112
  asm("mul.f32 %0, %1, %2;" : "=f"(f126) : "f"(f24), "f"(f112));
  // PTX:695 mul.f32 %f127, %f25, %f112
  asm("mul.f32 %0, %1, %2;" : "=f"(f127) : "f"(f25), "f"(f112));
  // PTX:696 mul.lo.s64 %rd120, %rd33, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd120) : "l"(rd33));
  // PTX:697 add.s64 %rd35, %rd1, %rd120
  asm("add.s64 %0, %1, %2;" : "=l"(rd35) : "l"(rd1), "l"(rd120));
  // PTX:698 red.global.add.f32 [%rd35], %f125
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (0)))), (float)(f125));
  // PTX:699 add.s64 %rd121, %rd35, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd121) : "l"(rd35));
  // PTX:700 red.global.add.f32 [%rd121], %f126
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd121) + (0)))), (float)(f126));
  // PTX:701 add.s64 %rd122, %rd35, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd122) : "l"(rd35));
  // PTX:702 red.global.add.f32 [%rd122], %f127
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd122) + (0)))), (float)(f127));
  // PTX:703 setp.le.s32 %p41, %r187, %r186
  p41 = (((int)(r187)) <= ((int)(r186)));
  // PTX:704 setp.leu.f32 %p42, %f52, 0f00000000
  p42 = ((isnan(((float)(f52))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f52)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:705 or.pred %p43, %p42, %p41
  p43 = ((p42) || (p41));
  // PTX:706 @%p43 bra $L__BB3_45
  if (p43) { goto L_BB3_45; }
  // PTX:708 ld.global.f32 %f131, [%rd31]
  f131 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (0)))));
  // PTX:709 mul.f32 %f132, %f17, %f131
  asm("mul.f32 %0, %1, %2;" : "=f"(f132) : "f"(f17), "f"(f131));
  // PTX:710 ld.global.f32 %f133, [%rd34]
  f133 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (0)))));
  // PTX:711 mul.f32 %f134, %f132, %f133
  asm("mul.f32 %0, %1, %2;" : "=f"(f134) : "f"(f132), "f"(f133));
  // PTX:712 mul.f32 %f135, %f20, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f135) : "f"(f20), "f"(f24));
  // PTX:713 fma.rn.f32 %f136, %f19, %f23, %f135
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f136) : "f"(f19), "f"(f23), "f"(f135));
  // PTX:714 fma.rn.f32 %f137, %f21, %f25, %f136
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f137) : "f"(f21), "f"(f25), "f"(f136));
  // PTX:715 mul.f32 %f138, %f137, %f134
  asm("mul.f32 %0, %1, %2;" : "=f"(f138) : "f"(f137), "f"(f134));
  // PTX:716 add.f32 %f139, %f18, %f22
  asm("add.f32 %0, %1, %2;" : "=f"(f139) : "f"(f18), "f"(f22));
  // PTX:717 div.rn.f32 %f140, %f138, %f139
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f140) : "f"(f138), "f"(f139));
  // PTX:718 div.rn.f32 %f141, %f140, %f53
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f141) : "f"(f140), "f"(f53));
  // PTX:719 add.s64 %rd126, %rd2, %rd120
  asm("add.s64 %0, %1, %2;" : "=l"(rd126) : "l"(rd2), "l"(rd120));
  // PTX:720 ld.global.f32 %f142, [%rd126]
  f142 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd126) + (0)))));
  // PTX:721 ld.global.f32 %f143, [%rd15]
  f143 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))));
  // PTX:722 sub.f32 %f144, %f143, %f142
  asm("sub.f32 %0, %1, %2;" : "=f"(f144) : "f"(f143), "f"(f142));
  // PTX:723 ld.global.f32 %f145, [%rd126+4]
  f145 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd126) + (4)))));
  // PTX:724 ld.global.f32 %f146, [%rd15+4]
  f146 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (4)))));
  // PTX:725 sub.f32 %f147, %f146, %f145
  asm("sub.f32 %0, %1, %2;" : "=f"(f147) : "f"(f146), "f"(f145));
  // PTX:726 ld.global.f32 %f148, [%rd126+8]
  f148 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd126) + (8)))));
  // PTX:727 ld.global.f32 %f149, [%rd15+8]
  f149 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (8)))));
  // PTX:728 sub.f32 %f150, %f149, %f148
  asm("sub.f32 %0, %1, %2;" : "=f"(f150) : "f"(f149), "f"(f148));
  // PTX:729 mul.f32 %f151, %f144, %f141
  asm("mul.f32 %0, %1, %2;" : "=f"(f151) : "f"(f144), "f"(f141));
  // PTX:730 mul.f32 %f152, %f141, %f147
  asm("mul.f32 %0, %1, %2;" : "=f"(f152) : "f"(f141), "f"(f147));
  // PTX:731 mul.f32 %f153, %f141, %f150
  asm("mul.f32 %0, %1, %2;" : "=f"(f153) : "f"(f141), "f"(f150));
  // PTX:732 red.global.add.f32 [%rd26], %f151
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (0)))), (float)(f151));
  // PTX:733 red.global.add.f32 [%rd27], %f152
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))), (float)(f152));
  // PTX:734 red.global.add.f32 [%rd28], %f153
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (0)))), (float)(f153));
  // PTX:735 neg.f32 %f157, %f151
  asm("neg.f32 %0, %1;" : "=f"(f157) : "f"(f151));
  // PTX:736 neg.f32 %f158, %f152
  asm("neg.f32 %0, %1;" : "=f"(f158) : "f"(f152));
  // PTX:737 neg.f32 %f159, %f153
  asm("neg.f32 %0, %1;" : "=f"(f159) : "f"(f153));
  // PTX:738 red.global.add.f32 [%rd35], %f157
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (0)))), (float)(f157));
  // PTX:739 red.global.add.f32 [%rd121], %f158
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd121) + (0)))), (float)(f158));
  // PTX:740 red.global.add.f32 [%rd122], %f159
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd122) + (0)))), (float)(f159));
  // PTX:741 bra.uni $L__BB3_45
  goto L_BB3_45;
  // PTX:743 $L__BB3_54:
L_BB3_54:;
  // PTX:744 mul.hi.s32 %r194, %r274, 1431655766
  asm("mul.hi.s32 %0, %1, 1431655766;" : "=r"(r194) : "r"(r274));
  // PTX:745 shr.u32 %r195, %r194, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r195) : "r"(r194));
  // PTX:746 add.s32 %r196, %r194, %r195
  asm("add.s32 %0, %1, %2;" : "=r"(r196) : "r"(r194), "r"(r195));
  // PTX:747 mul.lo.s32 %r197, %r196, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r197) : "r"(r196));
  // PTX:748 sub.s32 %r198, %r274, %r197
  asm("sub.s32 %0, %1, %2;" : "=r"(r198) : "r"(r274), "r"(r197));
  // PTX:749 mul.hi.s32 %r199, %r196, 1431655766
  asm("mul.hi.s32 %0, %1, 1431655766;" : "=r"(r199) : "r"(r196));
  // PTX:750 shr.u32 %r200, %r199, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r200) : "r"(r199));
  // PTX:751 add.s32 %r201, %r199, %r200
  asm("add.s32 %0, %1, %2;" : "=r"(r201) : "r"(r199), "r"(r200));
  // PTX:752 mul.lo.s32 %r202, %r201, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r202) : "r"(r201));
  // PTX:753 sub.s32 %r203, %r196, %r202
  asm("sub.s32 %0, %1, %2;" : "=r"(r203) : "r"(r196), "r"(r202));
  // PTX:754 add.s32 %r270, %r46, %r198
  asm("add.s32 %0, %1, %2;" : "=r"(r270) : "r"(r46), "r"(r198));
  // PTX:755 add.s32 %r271, %r47, %r203
  asm("add.s32 %0, %1, %2;" : "=r"(r271) : "r"(r47), "r"(r203));
  // PTX:756 mul.hi.s32 %r204, %r274, 954437177
  asm("mul.hi.s32 %0, %1, 954437177;" : "=r"(r204) : "r"(r274));
  // PTX:757 shr.u32 %r205, %r204, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r205) : "r"(r204));
  // PTX:758 shr.s32 %r206, %r204, 1
  asm("shr.s32 %0, %1, 1;" : "=r"(r206) : "r"(r204));
  // PTX:759 add.s32 %r207, %r206, %r205
  asm("add.s32 %0, %1, %2;" : "=r"(r207) : "r"(r206), "r"(r205));
  // PTX:760 add.s32 %r272, %r48, %r207
  asm("add.s32 %0, %1, %2;" : "=r"(r272) : "r"(r48), "r"(r207));
  // PTX:761 add.s32 %r274, %r274, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r274) : "r"(r274));
  // PTX:762 mul.lo.s32 %r208, %r270, 73856093
  asm("mul.lo.s32 %0, %1, 73856093;" : "=r"(r208) : "r"(r270));
  // PTX:763 mul.lo.s32 %r209, %r271, 19349663
  asm("mul.lo.s32 %0, %1, 19349663;" : "=r"(r209) : "r"(r271));
  // PTX:764 mul.lo.s32 %r210, %r272, 83492791
  asm("mul.lo.s32 %0, %1, 83492791;" : "=r"(r210) : "r"(r272));
  // PTX:765 xor.b32 %r211, %r210, %r208
  asm("xor.b32 %0, %1, %2;" : "=r"(r211) : "r"(r210), "r"(r208));
  // PTX:766 xor.b32 %r212, %r211, %r209
  asm("xor.b32 %0, %1, %2;" : "=r"(r212) : "r"(r211), "r"(r209));
  // PTX:767 and.b32 %r213, %r212, %r7
  asm("and.b32 %0, %1, %2;" : "=r"(r213) : "r"(r212), "r"(r7));
  // PTX:768 mul.wide.s32 %rd132, %r213, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd132) : "r"(r213));
  // PTX:769 add.s64 %rd133, %rd3, %rd132
  asm("add.s64 %0, %1, %2;" : "=l"(rd133) : "l"(rd3), "l"(rd132));
  // PTX:770 ld.global.u32 %r277, [%rd133]
  r277 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd133) + (0)))));
  // PTX:772 $L__BB3_45:
L_BB3_45:;
  // PTX:773 setp.lt.s32 %p44, %r277, 0
  p44 = (((int)(r277)) < ((int)(0)));
  // PTX:774 @%p44 bra $L__BB3_53
  if (p44) { goto L_BB3_53; }
  // PTX:776 mov.u32 %r278, %r277
  asm("mov.u32 %0, %1;" : "=r"(r278) : "r"(r277));
  // PTX:778 $L__BB3_47:
L_BB3_47:;
  // PTX:779 cvt.s64.s32 %rd36, %r278
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd36) : "r"(r278));
  // PTX:780 mul.wide.s32 %rd127, %r278, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd127) : "r"(r278));
  // PTX:781 add.s64 %rd128, %rd4, %rd127
  asm("add.s64 %0, %1, %2;" : "=l"(rd128) : "l"(rd4), "l"(rd127));
  // PTX:782 ld.global.u32 %r277, [%rd128]
  r277 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd128) + (0)))));
  // PTX:783 mul.wide.s32 %rd129, %r278, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd129) : "r"(r278));
  // PTX:784 add.s64 %rd37, %rd7, %rd129
  asm("add.s64 %0, %1, %2;" : "=l"(rd37) : "l"(rd7), "l"(rd129));
  // PTX:785 ld.global.u32 %r189, [%rd37]
  r189 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (0)))));
  // PTX:786 setp.ne.s32 %p45, %r189, %r270
  p45 = (((int)(r189)) != ((int)(r270)));
  // PTX:787 mov.u16 %rs20, 0
  asm("mov.u16 %0, 0;" : "=h"(rs20) : );
  // PTX:788 @%p45 bra $L__BB3_50
  if (p45) { goto L_BB3_50; }
  // PTX:790 ld.global.u32 %r190, [%rd37+4]
  r190 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (4)))));
  // PTX:791 setp.ne.s32 %p46, %r190, %r271
  p46 = (((int)(r190)) != ((int)(r271)));
  // PTX:792 @%p46 bra $L__BB3_50
  if (p46) { goto L_BB3_50; }
  // PTX:794 ld.global.u32 %r191, [%rd37+8]
  r191 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (8)))));
  // PTX:795 setp.eq.s32 %p47, %r191, %r272
  p47 = (((int)(r191)) == ((int)(r272)));
  // PTX:796 selp.u16 %rs20, 1, 0, %p47
  rs20 = p47 ? 1 : 0;
  // PTX:798 $L__BB3_50:
L_BB3_50:;
  // PTX:799 setp.eq.s16 %p48, %rs20, 0
  p48 = (((short)(rs20)) == ((short)(0)));
  // PTX:800 @%p48 bra $L__BB3_52
  if (p48) { goto L_BB3_52; }
  // PTX:802 shl.b64 %rd130, %rd36, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd130) : "l"(rd36));
  // PTX:803 add.s64 %rd131, %rd6, %rd130
  asm("add.s64 %0, %1, %2;" : "=l"(rd131) : "l"(rd6), "l"(rd130));
  // PTX:804 ld.global.u32 %r192, [%rd131]
  r192 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd131) + (0)))));
  // PTX:805 setp.eq.s32 %p49, %r192, %r45
  p49 = (((int)(r192)) == ((int)(r45)));
  // PTX:806 setp.eq.s32 %p50, %r192, -1
  p50 = (((int)(r192)) == ((int)(-1)));
  // PTX:807 or.pred %p51, %p49, %p50
  p51 = ((p49) || (p50));
  // PTX:808 @%p51 bra $L__BB3_55
  if (p51) { goto L_BB3_55; }
  // PTX:810 $L__BB3_52:
L_BB3_52:;
  // PTX:811 setp.gt.s32 %p52, %r277, -1
  p52 = (((int)(r277)) > ((int)(-1)));
  // PTX:812 mov.u32 %r278, %r277
  asm("mov.u32 %0, %1;" : "=r"(r278) : "r"(r277));
  // PTX:813 @%p52 bra $L__BB3_47
  if (p52) { goto L_BB3_47; }
  // PTX:815 $L__BB3_53:
L_BB3_53:;
  // PTX:816 setp.eq.s32 %p53, %r274, 27
  p53 = (((int)(r274)) == ((int)(27)));
  // PTX:817 mov.u32 %r278, -1
  asm("mov.u32 %0, -1;" : "=r"(r278) : );
  // PTX:818 @%p53 bra $L__BB3_55
  if (p53) { goto L_BB3_55; }
  // PTX:819 bra.uni $L__BB3_54
  goto L_BB3_54;
  // PTX:821 $L__BB3_55:
L_BB3_55:;
  // PTX:822 setp.gt.s32 %p54, %r278, -1
  p54 = (((int)(r278)) > ((int)(-1)));
  // PTX:823 @%p54 bra $L__BB3_42
  if (p54) { goto L_BB3_42; }
  // PTX:825 $L__BB3_67:
L_BB3_67:;
  // PTX:826 ret
  return;
}
