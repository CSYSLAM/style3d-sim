// 机械还原自 PTX：synreal::granular_kernel::form_bonds(synreal::Model, synreal::granular_kernel::View, int const*, int const*, int*, glm::vec<2, int, (glm::qualifier)0>*, float*, float*, int*)
// PTX SHA256: 723587595a4d38c0199e44a0b780eebd202e5045c36f31657acc0cd12c8d5442
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__granular_kernel__form_bonds(ByVal<1864, 8> param0, ByVal<120, 8> param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57, p58, p59, p60, p61, p62, p63, p64, p65, p66, p67, p68, p69, p70, p71, p72, p73, p74, p75, p76, p77, p78, p79, p80, p81, p82;
  unsigned short rs0, rs1, rs2, rs3, rs4, rs5, rs6, rs7, rs8, rs9, rs10, rs11, rs12, rs13, rs14, rs15, rs16, rs17, rs18, rs19, rs20, rs21, rs22;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121, r122, r123, r124, r125, r126, r127, r128, r129, r130, r131, r132, r133, r134, r135, r136, r137, r138, r139, r140, r141, r142, r143, r144, r145, r146, r147, r148, r149, r150, r151, r152, r153, r154, r155, r156, r157, r158, r159, r160, r161, r162, r163, r164, r165, r166, r167, r168, r169, r170, r171, r172, r173, r174, r175, r176, r177, r178, r179, r180, r181, r182, r183, r184, r185, r186, r187, r188, r189, r190, r191, r192, r193, r194, r195, r196, r197, r198, r199, r200, r201, r202, r203, r204, r205, r206, r207, r208, r209, r210, r211, r212, r213, r214, r215, r216, r217, r218, r219, r220, r221, r222, r223, r224, r225, r226, r227, r228, r229, r230, r231, r232, r233, r234, r235, r236, r237, r238, r239, r240, r241, r242, r243, r244, r245, r246, r247, r248, r249, r250, r251, r252, r253, r254, r255, r256, r257;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135, rd136, rd137, rd138, rd139, rd140, rd141, rd142, rd143, rd144, rd145, rd146, rd147, rd148, rd149, rd150, rd151, rd152, rd153, rd154, rd155, rd156, rd157, rd158, rd159, rd160, rd161, rd162, rd163, rd164, rd165, rd166, rd167, rd168, rd169, rd170, rd171, rd172, rd173, rd174, rd175, rd176, rd177, rd178;
  // PTX:26 mov.b64 %rd41, _ZN7synreal15granular_kernel10form_bondsENS_5ModelENS0_4ViewEPKiS4_PiPN3glm3vecILi2EiLNS6_9qualifierE0EEEPfSB_S5__param_0
  rd41 = (unsigned long long)(uintptr_t)&param0;
  // PTX:27 ld.param.v2.u32 {%r96, %r97}, [_ZN7synreal15granular_kernel10form_bondsENS_5ModelENS0_4ViewEPKiS4_PiPN3glm3vecILi2EiLNS6_9qualifierE0EEEPfSB_S5__param_1+88]
  r96 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param1 + (88)))); r97 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param1 + (92))));
  // PTX:28 ld.param.u64 %rd57, [_ZN7synreal15granular_kernel10form_bondsENS_5ModelENS0_4ViewEPKiS4_PiPN3glm3vecILi2EiLNS6_9qualifierE0EEEPfSB_S5__param_3]
  rd57 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:29 ld.param.u64 %rd58, [_ZN7synreal15granular_kernel10form_bondsENS_5ModelENS0_4ViewEPKiS4_PiPN3glm3vecILi2EiLNS6_9qualifierE0EEEPfSB_S5__param_4]
  rd58 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:30 ld.param.u64 %rd59, [_ZN7synreal15granular_kernel10form_bondsENS_5ModelENS0_4ViewEPKiS4_PiPN3glm3vecILi2EiLNS6_9qualifierE0EEEPfSB_S5__param_8]
  rd59 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:31 ld.param.u64 %rd49, [_ZN7synreal15granular_kernel10form_bondsENS_5ModelENS0_4ViewEPKiS4_PiPN3glm3vecILi2EiLNS6_9qualifierE0EEEPfSB_S5__param_1+56]
  rd49 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (56))));
  // PTX:32 ld.param.u64 %rd48, [_ZN7synreal15granular_kernel10form_bondsENS_5ModelENS0_4ViewEPKiS4_PiPN3glm3vecILi2EiLNS6_9qualifierE0EEEPfSB_S5__param_1+48]
  rd48 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (48))));
  // PTX:33 ld.param.u64 %rd47, [_ZN7synreal15granular_kernel10form_bondsENS_5ModelENS0_4ViewEPKiS4_PiPN3glm3vecILi2EiLNS6_9qualifierE0EEEPfSB_S5__param_1+40]
  rd47 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (40))));
  // PTX:34 ld.param.u64 %rd46, [_ZN7synreal15granular_kernel10form_bondsENS_5ModelENS0_4ViewEPKiS4_PiPN3glm3vecILi2EiLNS6_9qualifierE0EEEPfSB_S5__param_1+32]
  rd46 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (32))));
  // PTX:35 ld.param.u64 %rd45, [_ZN7synreal15granular_kernel10form_bondsENS_5ModelENS0_4ViewEPKiS4_PiPN3glm3vecILi2EiLNS6_9qualifierE0EEEPfSB_S5__param_1+24]
  rd45 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (24))));
  // PTX:36 ld.param.u64 %rd44, [_ZN7synreal15granular_kernel10form_bondsENS_5ModelENS0_4ViewEPKiS4_PiPN3glm3vecILi2EiLNS6_9qualifierE0EEEPfSB_S5__param_1+16]
  rd44 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (16))));
  // PTX:37 ld.param.u64 %rd43, [_ZN7synreal15granular_kernel10form_bondsENS_5ModelENS0_4ViewEPKiS4_PiPN3glm3vecILi2EiLNS6_9qualifierE0EEEPfSB_S5__param_1+8]
  rd43 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (8))));
  // PTX:38 ld.param.u64 %rd42, [_ZN7synreal15granular_kernel10form_bondsENS_5ModelENS0_4ViewEPKiS4_PiPN3glm3vecILi2EiLNS6_9qualifierE0EEEPfSB_S5__param_1]
  rd42 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:39 cvta.to.global.u64 %rd1, %rd57
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd57));
  // PTX:40 cvta.to.global.u64 %rd2, %rd59
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd59));
  // PTX:41 cvta.to.global.u64 %rd3, %rd58
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd58));
  // PTX:42 cvta.to.global.u64 %rd4, %rd42
  rd4 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd42));
  // PTX:43 cvta.to.global.u64 %rd5, %rd43
  rd5 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd43));
  // PTX:44 cvta.to.global.u64 %rd6, %rd44
  rd6 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd44));
  // PTX:45 cvta.to.global.u64 %rd7, %rd45
  rd7 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd45));
  // PTX:46 cvta.to.global.u64 %rd8, %rd46
  rd8 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd46));
  // PTX:47 cvta.to.global.u64 %rd9, %rd47
  rd9 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd47));
  // PTX:48 cvta.to.global.u64 %rd10, %rd48
  rd10 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd48));
  // PTX:49 cvta.to.global.u64 %rd11, %rd49
  rd11 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd49));
  // PTX:50 mov.u32 %r98, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r98) : "r"(blockDim.x));
  // PTX:51 mov.u32 %r99, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r99) : "r"(blockIdx.x));
  // PTX:52 mov.u32 %r100, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r100) : "r"(threadIdx.x));
  // PTX:53 mad.lo.s32 %r1, %r99, %r98, %r100
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r1) : "r"(r99), "r"(r98), "r"(r100));
  // PTX:54 setp.ge.s32 %p7, %r1, %r96
  p7 = (((int)(r1)) >= ((int)(r96)));
  // PTX:55 @%p7 bra $L__BB6_77
  if (p7) { goto L_BB6_77; }
  // PTX:57 add.s64 %rd12, %rd41, 340
  asm("add.s64 %0, %1, 340;" : "=l"(rd12) : "l"(rd41));
  // PTX:58 ld.param.u32 %r2, [%rd41+340]
  r2 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)(rd41) + (340))));
  // PTX:59 mul.lo.s32 %r3, %r2, %r1
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r3) : "r"(r2), "r"(r1));
  // PTX:60 setp.eq.s32 %p8, %r2, 0
  p8 = (((int)(r2)) == ((int)(0)));
  // PTX:61 @%p8 bra $L__BB6_77
  if (p8) { goto L_BB6_77; }
  // PTX:63 cvt.s64.s32 %rd13, %r1
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd13) : "r"(r1));
  // PTX:64 mul.wide.s32 %rd61, %r1, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd61) : "r"(r1));
  // PTX:65 add.s64 %rd15, %rd9, %rd61
  asm("add.s64 %0, %1, %2;" : "=l"(rd15) : "l"(rd9), "l"(rd61));
  // PTX:66 mul.wide.s32 %rd62, %r1, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd62) : "r"(r1));
  // PTX:67 add.s64 %rd14, %rd11, %rd62
  asm("add.s64 %0, %1, %2;" : "=l"(rd14) : "l"(rd11), "l"(rd62));
  // PTX:68 and.b32 %r4, %r2, 3
  asm("and.b32 %0, %1, 3;" : "=r"(r4) : "r"(r2));
  // PTX:69 add.s32 %r5, %r2, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r5) : "r"(r2));
  // PTX:70 setp.lt.u32 %p9, %r5, 3
  p9 = (((unsigned)(r5)) < ((unsigned)(3)));
  // PTX:71 mov.u32 %r210, 0
  asm("mov.u32 %0, 0;" : "=r"(r210) : );
  // PTX:72 @%p9 bra $L__BB6_21
  if (p9) { goto L_BB6_21; }
  // PTX:74 sub.s32 %r209, %r2, %r4
  asm("sub.s32 %0, %1, %2;" : "=r"(r209) : "r"(r2), "r"(r4));
  // PTX:75 mov.u32 %r210, 0
  asm("mov.u32 %0, 0;" : "=r"(r210) : );
  // PTX:77 $L__BB6_4:
L_BB6_4:;
  // PTX:78 add.s32 %r103, %r210, %r3
  asm("add.s32 %0, %1, %2;" : "=r"(r103) : "r"(r210), "r"(r3));
  // PTX:79 cvt.u64.u32 %rd16, %r103
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd16) : "r"(r103));
  // PTX:80 mul.wide.u32 %rd63, %r103, 4
  asm("mul.wide.u32 %0, %1, 4;" : "=l"(rd63) : "r"(r103));
  // PTX:81 add.s64 %rd17, %rd3, %rd63
  asm("add.s64 %0, %1, %2;" : "=l"(rd17) : "l"(rd3), "l"(rd63));
  // PTX:82 ld.global.u32 %r9, [%rd17]
  r9 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:83 setp.lt.s32 %p10, %r9, 0
  p10 = (((int)(r9)) < ((int)(0)));
  // PTX:84 @%p10 bra $L__BB6_8
  if (p10) { goto L_BB6_8; }
  // PTX:86 shl.b64 %rd64, %rd16, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd64) : "l"(rd16));
  // PTX:87 add.s64 %rd65, %rd2, %rd64
  asm("add.s64 %0, %1, %2;" : "=l"(rd65) : "l"(rd2), "l"(rd64));
  // PTX:88 ld.global.u32 %r104, [%rd65]
  r104 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (0)))));
  // PTX:89 setp.ne.s32 %p11, %r104, 0
  p11 = (((int)(r104)) != ((int)(0)));
  // PTX:90 @%p11 bra $L__BB6_8
  if (p11) { goto L_BB6_8; }
  // PTX:92 mul.wide.s32 %rd66, %r9, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd66) : "r"(r9));
  // PTX:93 add.s64 %rd67, %rd9, %rd66
  asm("add.s64 %0, %1, %2;" : "=l"(rd67) : "l"(rd9), "l"(rd66));
  // PTX:94 ld.global.f32 %f20, [%rd67]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0)))));
  // PTX:95 ld.global.f32 %f21, [%rd15]
  f21 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))));
  // PTX:96 sub.f32 %f22, %f21, %f20
  asm("sub.f32 %0, %1, %2;" : "=f"(f22) : "f"(f21), "f"(f20));
  // PTX:97 ld.global.f32 %f23, [%rd67+4]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (4)))));
  // PTX:98 ld.global.f32 %f24, [%rd15+4]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (4)))));
  // PTX:99 sub.f32 %f25, %f24, %f23
  asm("sub.f32 %0, %1, %2;" : "=f"(f25) : "f"(f24), "f"(f23));
  // PTX:100 ld.global.f32 %f26, [%rd67+8]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (8)))));
  // PTX:101 ld.global.f32 %f27, [%rd15+8]
  f27 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (8)))));
  // PTX:102 sub.f32 %f28, %f27, %f26
  asm("sub.f32 %0, %1, %2;" : "=f"(f28) : "f"(f27), "f"(f26));
  // PTX:103 mul.wide.s32 %rd68, %r9, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd68) : "r"(r9));
  // PTX:104 add.s64 %rd69, %rd11, %rd68
  asm("add.s64 %0, %1, %2;" : "=l"(rd69) : "l"(rd11), "l"(rd68));
  // PTX:105 ld.global.f32 %f29, [%rd69]
  f29 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (0)))));
  // PTX:106 ld.global.f32 %f30, [%rd14]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:107 add.f32 %f31, %f30, %f29
  asm("add.f32 %0, %1, %2;" : "=f"(f31) : "f"(f30), "f"(f29));
  // PTX:108 ld.param.f32 %f32, [%rd12+-8]
  f32 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd12) + (-8))));
  // PTX:109 add.f32 %f33, %f31, %f32
  asm("add.f32 %0, %1, %2;" : "=f"(f33) : "f"(f31), "f"(f32));
  // PTX:110 mul.f32 %f34, %f25, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f34) : "f"(f25), "f"(f25));
  // PTX:111 fma.rn.f32 %f35, %f22, %f22, %f34
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f35) : "f"(f22), "f"(f22), "f"(f34));
  // PTX:112 fma.rn.f32 %f36, %f28, %f28, %f35
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f36) : "f"(f28), "f"(f28), "f"(f35));
  // PTX:113 mul.f32 %f37, %f33, %f33
  asm("mul.f32 %0, %1, %2;" : "=f"(f37) : "f"(f33), "f"(f33));
  // PTX:114 setp.leu.f32 %p12, %f36, %f37
  p12 = ((isnan(((float)(f36))) || isnan(((float)(f37)))) || (((float)(f36)) <= ((float)(f37))));
  // PTX:115 @%p12 bra $L__BB6_8
  if (p12) { goto L_BB6_8; }
  // PTX:117 mov.u32 %r105, -1
  asm("mov.u32 %0, -1;" : "=r"(r105) : );
  // PTX:118 st.global.u32 [%rd17], %r105
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0))))) = (unsigned)(r105);
  // PTX:120 $L__BB6_8:
L_BB6_8:;
  // PTX:121 cvt.u32.u64 %r106, %rd16
  asm("cvt.u32.u64 %0, %1;" : "=r"(r106) : "l"(rd16));
  // PTX:122 add.s32 %r107, %r106, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r107) : "r"(r106));
  // PTX:123 cvt.u64.u32 %rd18, %r107
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd18) : "r"(r107));
  // PTX:124 mul.wide.u32 %rd70, %r107, 4
  asm("mul.wide.u32 %0, %1, 4;" : "=l"(rd70) : "r"(r107));
  // PTX:125 add.s64 %rd19, %rd3, %rd70
  asm("add.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd3), "l"(rd70));
  // PTX:126 ld.global.u32 %r10, [%rd19]
  r10 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))));
  // PTX:127 setp.lt.s32 %p13, %r10, 0
  p13 = (((int)(r10)) < ((int)(0)));
  // PTX:128 @%p13 bra $L__BB6_12
  if (p13) { goto L_BB6_12; }
  // PTX:130 shl.b64 %rd71, %rd18, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd71) : "l"(rd18));
  // PTX:131 add.s64 %rd72, %rd2, %rd71
  asm("add.s64 %0, %1, %2;" : "=l"(rd72) : "l"(rd2), "l"(rd71));
  // PTX:132 ld.global.u32 %r108, [%rd72]
  r108 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (0)))));
  // PTX:133 setp.ne.s32 %p14, %r108, 0
  p14 = (((int)(r108)) != ((int)(0)));
  // PTX:134 @%p14 bra $L__BB6_12
  if (p14) { goto L_BB6_12; }
  // PTX:136 mul.wide.s32 %rd73, %r10, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd73) : "r"(r10));
  // PTX:137 add.s64 %rd74, %rd9, %rd73
  asm("add.s64 %0, %1, %2;" : "=l"(rd74) : "l"(rd9), "l"(rd73));
  // PTX:138 ld.global.f32 %f38, [%rd74]
  f38 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (0)))));
  // PTX:139 ld.global.f32 %f39, [%rd15]
  f39 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))));
  // PTX:140 sub.f32 %f40, %f39, %f38
  asm("sub.f32 %0, %1, %2;" : "=f"(f40) : "f"(f39), "f"(f38));
  // PTX:141 ld.global.f32 %f41, [%rd74+4]
  f41 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (4)))));
  // PTX:142 ld.global.f32 %f42, [%rd15+4]
  f42 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (4)))));
  // PTX:143 sub.f32 %f43, %f42, %f41
  asm("sub.f32 %0, %1, %2;" : "=f"(f43) : "f"(f42), "f"(f41));
  // PTX:144 ld.global.f32 %f44, [%rd74+8]
  f44 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (8)))));
  // PTX:145 ld.global.f32 %f45, [%rd15+8]
  f45 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (8)))));
  // PTX:146 sub.f32 %f46, %f45, %f44
  asm("sub.f32 %0, %1, %2;" : "=f"(f46) : "f"(f45), "f"(f44));
  // PTX:147 mul.wide.s32 %rd75, %r10, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd75) : "r"(r10));
  // PTX:148 add.s64 %rd76, %rd11, %rd75
  asm("add.s64 %0, %1, %2;" : "=l"(rd76) : "l"(rd11), "l"(rd75));
  // PTX:149 ld.global.f32 %f47, [%rd76]
  f47 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (0)))));
  // PTX:150 ld.global.f32 %f48, [%rd14]
  f48 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:151 add.f32 %f49, %f48, %f47
  asm("add.f32 %0, %1, %2;" : "=f"(f49) : "f"(f48), "f"(f47));
  // PTX:152 ld.param.f32 %f50, [%rd12+-8]
  f50 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd12) + (-8))));
  // PTX:153 add.f32 %f51, %f49, %f50
  asm("add.f32 %0, %1, %2;" : "=f"(f51) : "f"(f49), "f"(f50));
  // PTX:154 mul.f32 %f52, %f43, %f43
  asm("mul.f32 %0, %1, %2;" : "=f"(f52) : "f"(f43), "f"(f43));
  // PTX:155 fma.rn.f32 %f53, %f40, %f40, %f52
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f53) : "f"(f40), "f"(f40), "f"(f52));
  // PTX:156 fma.rn.f32 %f54, %f46, %f46, %f53
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f54) : "f"(f46), "f"(f46), "f"(f53));
  // PTX:157 mul.f32 %f55, %f51, %f51
  asm("mul.f32 %0, %1, %2;" : "=f"(f55) : "f"(f51), "f"(f51));
  // PTX:158 setp.leu.f32 %p15, %f54, %f55
  p15 = ((isnan(((float)(f54))) || isnan(((float)(f55)))) || (((float)(f54)) <= ((float)(f55))));
  // PTX:159 @%p15 bra $L__BB6_12
  if (p15) { goto L_BB6_12; }
  // PTX:161 mov.u32 %r109, -1
  asm("mov.u32 %0, -1;" : "=r"(r109) : );
  // PTX:162 st.global.u32 [%rd19], %r109
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0))))) = (unsigned)(r109);
  // PTX:164 $L__BB6_12:
L_BB6_12:;
  // PTX:165 add.s32 %r111, %r106, 2
  asm("add.s32 %0, %1, 2;" : "=r"(r111) : "r"(r106));
  // PTX:166 cvt.u64.u32 %rd20, %r111
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd20) : "r"(r111));
  // PTX:167 mul.wide.u32 %rd77, %r111, 4
  asm("mul.wide.u32 %0, %1, 4;" : "=l"(rd77) : "r"(r111));
  // PTX:168 add.s64 %rd21, %rd3, %rd77
  asm("add.s64 %0, %1, %2;" : "=l"(rd21) : "l"(rd3), "l"(rd77));
  // PTX:169 ld.global.u32 %r11, [%rd21]
  r11 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (0)))));
  // PTX:170 setp.lt.s32 %p16, %r11, 0
  p16 = (((int)(r11)) < ((int)(0)));
  // PTX:171 @%p16 bra $L__BB6_16
  if (p16) { goto L_BB6_16; }
  // PTX:173 shl.b64 %rd78, %rd20, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd78) : "l"(rd20));
  // PTX:174 add.s64 %rd79, %rd2, %rd78
  asm("add.s64 %0, %1, %2;" : "=l"(rd79) : "l"(rd2), "l"(rd78));
  // PTX:175 ld.global.u32 %r112, [%rd79]
  r112 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (0)))));
  // PTX:176 setp.ne.s32 %p17, %r112, 0
  p17 = (((int)(r112)) != ((int)(0)));
  // PTX:177 @%p17 bra $L__BB6_16
  if (p17) { goto L_BB6_16; }
  // PTX:179 mul.wide.s32 %rd80, %r11, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd80) : "r"(r11));
  // PTX:180 add.s64 %rd81, %rd9, %rd80
  asm("add.s64 %0, %1, %2;" : "=l"(rd81) : "l"(rd9), "l"(rd80));
  // PTX:181 ld.global.f32 %f56, [%rd81]
  f56 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (0)))));
  // PTX:182 ld.global.f32 %f57, [%rd15]
  f57 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))));
  // PTX:183 sub.f32 %f58, %f57, %f56
  asm("sub.f32 %0, %1, %2;" : "=f"(f58) : "f"(f57), "f"(f56));
  // PTX:184 ld.global.f32 %f59, [%rd81+4]
  f59 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (4)))));
  // PTX:185 ld.global.f32 %f60, [%rd15+4]
  f60 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (4)))));
  // PTX:186 sub.f32 %f61, %f60, %f59
  asm("sub.f32 %0, %1, %2;" : "=f"(f61) : "f"(f60), "f"(f59));
  // PTX:187 ld.global.f32 %f62, [%rd81+8]
  f62 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (8)))));
  // PTX:188 ld.global.f32 %f63, [%rd15+8]
  f63 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (8)))));
  // PTX:189 sub.f32 %f64, %f63, %f62
  asm("sub.f32 %0, %1, %2;" : "=f"(f64) : "f"(f63), "f"(f62));
  // PTX:190 mul.wide.s32 %rd82, %r11, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd82) : "r"(r11));
  // PTX:191 add.s64 %rd83, %rd11, %rd82
  asm("add.s64 %0, %1, %2;" : "=l"(rd83) : "l"(rd11), "l"(rd82));
  // PTX:192 ld.global.f32 %f65, [%rd83]
  f65 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (0)))));
  // PTX:193 ld.global.f32 %f66, [%rd14]
  f66 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:194 add.f32 %f67, %f66, %f65
  asm("add.f32 %0, %1, %2;" : "=f"(f67) : "f"(f66), "f"(f65));
  // PTX:195 ld.param.f32 %f68, [%rd12+-8]
  f68 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd12) + (-8))));
  // PTX:196 add.f32 %f69, %f67, %f68
  asm("add.f32 %0, %1, %2;" : "=f"(f69) : "f"(f67), "f"(f68));
  // PTX:197 mul.f32 %f70, %f61, %f61
  asm("mul.f32 %0, %1, %2;" : "=f"(f70) : "f"(f61), "f"(f61));
  // PTX:198 fma.rn.f32 %f71, %f58, %f58, %f70
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f71) : "f"(f58), "f"(f58), "f"(f70));
  // PTX:199 fma.rn.f32 %f72, %f64, %f64, %f71
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f72) : "f"(f64), "f"(f64), "f"(f71));
  // PTX:200 mul.f32 %f73, %f69, %f69
  asm("mul.f32 %0, %1, %2;" : "=f"(f73) : "f"(f69), "f"(f69));
  // PTX:201 setp.leu.f32 %p18, %f72, %f73
  p18 = ((isnan(((float)(f72))) || isnan(((float)(f73)))) || (((float)(f72)) <= ((float)(f73))));
  // PTX:202 @%p18 bra $L__BB6_16
  if (p18) { goto L_BB6_16; }
  // PTX:204 mov.u32 %r113, -1
  asm("mov.u32 %0, -1;" : "=r"(r113) : );
  // PTX:205 st.global.u32 [%rd21], %r113
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (0))))) = (unsigned)(r113);
  // PTX:207 $L__BB6_16:
L_BB6_16:;
  // PTX:208 add.s32 %r115, %r106, 3
  asm("add.s32 %0, %1, 3;" : "=r"(r115) : "r"(r106));
  // PTX:209 cvt.u64.u32 %rd22, %r115
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd22) : "r"(r115));
  // PTX:210 mul.wide.u32 %rd84, %r115, 4
  asm("mul.wide.u32 %0, %1, 4;" : "=l"(rd84) : "r"(r115));
  // PTX:211 add.s64 %rd23, %rd3, %rd84
  asm("add.s64 %0, %1, %2;" : "=l"(rd23) : "l"(rd3), "l"(rd84));
  // PTX:212 ld.global.u32 %r12, [%rd23]
  r12 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (0)))));
  // PTX:213 setp.lt.s32 %p19, %r12, 0
  p19 = (((int)(r12)) < ((int)(0)));
  // PTX:214 @%p19 bra $L__BB6_20
  if (p19) { goto L_BB6_20; }
  // PTX:216 shl.b64 %rd85, %rd22, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd85) : "l"(rd22));
  // PTX:217 add.s64 %rd86, %rd2, %rd85
  asm("add.s64 %0, %1, %2;" : "=l"(rd86) : "l"(rd2), "l"(rd85));
  // PTX:218 ld.global.u32 %r116, [%rd86]
  r116 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd86) + (0)))));
  // PTX:219 setp.ne.s32 %p20, %r116, 0
  p20 = (((int)(r116)) != ((int)(0)));
  // PTX:220 @%p20 bra $L__BB6_20
  if (p20) { goto L_BB6_20; }
  // PTX:222 mul.wide.s32 %rd87, %r12, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd87) : "r"(r12));
  // PTX:223 add.s64 %rd88, %rd9, %rd87
  asm("add.s64 %0, %1, %2;" : "=l"(rd88) : "l"(rd9), "l"(rd87));
  // PTX:224 ld.global.f32 %f74, [%rd88]
  f74 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (0)))));
  // PTX:225 ld.global.f32 %f75, [%rd15]
  f75 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))));
  // PTX:226 sub.f32 %f76, %f75, %f74
  asm("sub.f32 %0, %1, %2;" : "=f"(f76) : "f"(f75), "f"(f74));
  // PTX:227 ld.global.f32 %f77, [%rd88+4]
  f77 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (4)))));
  // PTX:228 ld.global.f32 %f78, [%rd15+4]
  f78 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (4)))));
  // PTX:229 sub.f32 %f79, %f78, %f77
  asm("sub.f32 %0, %1, %2;" : "=f"(f79) : "f"(f78), "f"(f77));
  // PTX:230 ld.global.f32 %f80, [%rd88+8]
  f80 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (8)))));
  // PTX:231 ld.global.f32 %f81, [%rd15+8]
  f81 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (8)))));
  // PTX:232 sub.f32 %f82, %f81, %f80
  asm("sub.f32 %0, %1, %2;" : "=f"(f82) : "f"(f81), "f"(f80));
  // PTX:233 mul.wide.s32 %rd89, %r12, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd89) : "r"(r12));
  // PTX:234 add.s64 %rd90, %rd11, %rd89
  asm("add.s64 %0, %1, %2;" : "=l"(rd90) : "l"(rd11), "l"(rd89));
  // PTX:235 ld.global.f32 %f83, [%rd90]
  f83 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (0)))));
  // PTX:236 ld.global.f32 %f84, [%rd14]
  f84 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:237 add.f32 %f85, %f84, %f83
  asm("add.f32 %0, %1, %2;" : "=f"(f85) : "f"(f84), "f"(f83));
  // PTX:238 ld.param.f32 %f86, [%rd12+-8]
  f86 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd12) + (-8))));
  // PTX:239 add.f32 %f87, %f85, %f86
  asm("add.f32 %0, %1, %2;" : "=f"(f87) : "f"(f85), "f"(f86));
  // PTX:240 mul.f32 %f88, %f79, %f79
  asm("mul.f32 %0, %1, %2;" : "=f"(f88) : "f"(f79), "f"(f79));
  // PTX:241 fma.rn.f32 %f89, %f76, %f76, %f88
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f89) : "f"(f76), "f"(f76), "f"(f88));
  // PTX:242 fma.rn.f32 %f90, %f82, %f82, %f89
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f90) : "f"(f82), "f"(f82), "f"(f89));
  // PTX:243 mul.f32 %f91, %f87, %f87
  asm("mul.f32 %0, %1, %2;" : "=f"(f91) : "f"(f87), "f"(f87));
  // PTX:244 setp.leu.f32 %p21, %f90, %f91
  p21 = ((isnan(((float)(f90))) || isnan(((float)(f91)))) || (((float)(f90)) <= ((float)(f91))));
  // PTX:245 @%p21 bra $L__BB6_20
  if (p21) { goto L_BB6_20; }
  // PTX:247 mov.u32 %r117, -1
  asm("mov.u32 %0, -1;" : "=r"(r117) : );
  // PTX:248 st.global.u32 [%rd23], %r117
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (0))))) = (unsigned)(r117);
  // PTX:250 $L__BB6_20:
L_BB6_20:;
  // PTX:251 add.s32 %r210, %r210, 4
  asm("add.s32 %0, %1, 4;" : "=r"(r210) : "r"(r210));
  // PTX:252 add.s32 %r209, %r209, -4
  asm("add.s32 %0, %1, -4;" : "=r"(r209) : "r"(r209));
  // PTX:253 setp.ne.s32 %p22, %r209, 0
  p22 = (((int)(r209)) != ((int)(0)));
  // PTX:254 @%p22 bra $L__BB6_4
  if (p22) { goto L_BB6_4; }
  // PTX:256 $L__BB6_21:
L_BB6_21:;
  // PTX:257 setp.eq.s32 %p23, %r4, 0
  p23 = (((int)(r4)) == ((int)(0)));
  // PTX:258 @%p23 bra $L__BB6_28
  if (p23) { goto L_BB6_28; }
  // PTX:260 mov.u32 %r212, %r4
  asm("mov.u32 %0, %1;" : "=r"(r212) : "r"(r4));
  // PTX:262 $L__BB6_23:
L_BB6_23:;
  // PTX:264 add.s32 %r118, %r210, %r3
  asm("add.s32 %0, %1, %2;" : "=r"(r118) : "r"(r210), "r"(r3));
  // PTX:265 cvt.u64.u32 %rd24, %r118
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd24) : "r"(r118));
  // PTX:266 mul.wide.u32 %rd91, %r118, 4
  asm("mul.wide.u32 %0, %1, 4;" : "=l"(rd91) : "r"(r118));
  // PTX:267 add.s64 %rd25, %rd3, %rd91
  asm("add.s64 %0, %1, %2;" : "=l"(rd25) : "l"(rd3), "l"(rd91));
  // PTX:268 ld.global.u32 %r18, [%rd25]
  r18 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (0)))));
  // PTX:269 setp.lt.s32 %p24, %r18, 0
  p24 = (((int)(r18)) < ((int)(0)));
  // PTX:270 @%p24 bra $L__BB6_27
  if (p24) { goto L_BB6_27; }
  // PTX:272 shl.b64 %rd92, %rd24, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd92) : "l"(rd24));
  // PTX:273 add.s64 %rd93, %rd2, %rd92
  asm("add.s64 %0, %1, %2;" : "=l"(rd93) : "l"(rd2), "l"(rd92));
  // PTX:274 ld.global.u32 %r119, [%rd93]
  r119 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (0)))));
  // PTX:275 setp.ne.s32 %p25, %r119, 0
  p25 = (((int)(r119)) != ((int)(0)));
  // PTX:276 @%p25 bra $L__BB6_27
  if (p25) { goto L_BB6_27; }
  // PTX:278 mul.wide.s32 %rd94, %r18, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd94) : "r"(r18));
  // PTX:279 add.s64 %rd95, %rd9, %rd94
  asm("add.s64 %0, %1, %2;" : "=l"(rd95) : "l"(rd9), "l"(rd94));
  // PTX:280 ld.global.f32 %f92, [%rd95]
  f92 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd95) + (0)))));
  // PTX:281 ld.global.f32 %f93, [%rd15]
  f93 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))));
  // PTX:282 sub.f32 %f94, %f93, %f92
  asm("sub.f32 %0, %1, %2;" : "=f"(f94) : "f"(f93), "f"(f92));
  // PTX:283 ld.global.f32 %f95, [%rd95+4]
  f95 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd95) + (4)))));
  // PTX:284 ld.global.f32 %f96, [%rd15+4]
  f96 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (4)))));
  // PTX:285 sub.f32 %f97, %f96, %f95
  asm("sub.f32 %0, %1, %2;" : "=f"(f97) : "f"(f96), "f"(f95));
  // PTX:286 ld.global.f32 %f98, [%rd95+8]
  f98 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd95) + (8)))));
  // PTX:287 ld.global.f32 %f99, [%rd15+8]
  f99 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (8)))));
  // PTX:288 sub.f32 %f100, %f99, %f98
  asm("sub.f32 %0, %1, %2;" : "=f"(f100) : "f"(f99), "f"(f98));
  // PTX:289 mul.wide.s32 %rd96, %r18, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd96) : "r"(r18));
  // PTX:290 add.s64 %rd97, %rd11, %rd96
  asm("add.s64 %0, %1, %2;" : "=l"(rd97) : "l"(rd11), "l"(rd96));
  // PTX:291 ld.global.f32 %f101, [%rd97]
  f101 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd97) + (0)))));
  // PTX:292 ld.global.f32 %f102, [%rd14]
  f102 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:293 add.f32 %f103, %f102, %f101
  asm("add.f32 %0, %1, %2;" : "=f"(f103) : "f"(f102), "f"(f101));
  // PTX:294 ld.param.f32 %f104, [%rd12+-8]
  f104 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd12) + (-8))));
  // PTX:295 add.f32 %f105, %f103, %f104
  asm("add.f32 %0, %1, %2;" : "=f"(f105) : "f"(f103), "f"(f104));
  // PTX:296 mul.f32 %f106, %f97, %f97
  asm("mul.f32 %0, %1, %2;" : "=f"(f106) : "f"(f97), "f"(f97));
  // PTX:297 fma.rn.f32 %f107, %f94, %f94, %f106
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f107) : "f"(f94), "f"(f94), "f"(f106));
  // PTX:298 fma.rn.f32 %f108, %f100, %f100, %f107
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f108) : "f"(f100), "f"(f100), "f"(f107));
  // PTX:299 mul.f32 %f109, %f105, %f105
  asm("mul.f32 %0, %1, %2;" : "=f"(f109) : "f"(f105), "f"(f105));
  // PTX:300 setp.leu.f32 %p26, %f108, %f109
  p26 = ((isnan(((float)(f108))) || isnan(((float)(f109)))) || (((float)(f108)) <= ((float)(f109))));
  // PTX:301 @%p26 bra $L__BB6_27
  if (p26) { goto L_BB6_27; }
  // PTX:303 mov.u32 %r120, -1
  asm("mov.u32 %0, -1;" : "=r"(r120) : );
  // PTX:304 st.global.u32 [%rd25], %r120
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (0))))) = (unsigned)(r120);
  // PTX:306 $L__BB6_27:
L_BB6_27:;
  // PTX:307 add.s32 %r210, %r210, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r210) : "r"(r210));
  // PTX:308 add.s32 %r212, %r212, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r212) : "r"(r212));
  // PTX:309 setp.ne.s32 %p27, %r212, 0
  p27 = (((int)(r212)) != ((int)(0)));
  // PTX:310 @%p27 bra $L__BB6_23
  if (p27) { goto L_BB6_23; }
  // PTX:312 $L__BB6_28:
L_BB6_28:;
  // PTX:313 ld.param.u64 %rd178, [_ZN7synreal15granular_kernel10form_bondsENS_5ModelENS0_4ViewEPKiS4_PiPN3glm3vecILi2EiLNS6_9qualifierE0EEEPfSB_S5__param_5]
  rd178 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:314 ld.param.u64 %rd177, [_ZN7synreal15granular_kernel10form_bondsENS_5ModelENS0_4ViewEPKiS4_PiPN3glm3vecILi2EiLNS6_9qualifierE0EEEPfSB_S5__param_7]
  rd177 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:315 ld.param.u64 %rd176, [_ZN7synreal15granular_kernel10form_bondsENS_5ModelENS0_4ViewEPKiS4_PiPN3glm3vecILi2EiLNS6_9qualifierE0EEEPfSB_S5__param_6]
  rd176 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:316 ld.param.u64 %rd175, [_ZN7synreal15granular_kernel10form_bondsENS_5ModelENS0_4ViewEPKiS4_PiPN3glm3vecILi2EiLNS6_9qualifierE0EEEPfSB_S5__param_2]
  rd175 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:317 mul.lo.s64 %rd98, %rd13, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd98) : "l"(rd13));
  // PTX:318 add.s64 %rd26, %rd8, %rd98
  asm("add.s64 %0, %1, %2;" : "=l"(rd26) : "l"(rd8), "l"(rd98));
  // PTX:319 shl.b64 %rd99, %rd13, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd99) : "l"(rd13));
  // PTX:320 add.s64 %rd27, %rd7, %rd99
  asm("add.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd7), "l"(rd99));
  // PTX:321 add.s32 %r21, %r97, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r21) : "r"(r97));
  // PTX:322 cvta.to.global.u64 %rd100, %rd175
  rd100 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd175));
  // PTX:323 add.s64 %rd28, %rd100, %rd99
  asm("add.s64 %0, %1, %2;" : "=l"(rd28) : "l"(rd100), "l"(rd99));
  // PTX:324 add.s64 %rd29, %rd10, %rd98
  asm("add.s64 %0, %1, %2;" : "=l"(rd29) : "l"(rd10), "l"(rd98));
  // PTX:325 add.s64 %rd30, %rd6, %rd99
  asm("add.s64 %0, %1, %2;" : "=l"(rd30) : "l"(rd6), "l"(rd99));
  // PTX:326 sub.s32 %r22, %r2, %r4
  asm("sub.s32 %0, %1, %2;" : "=r"(r22) : "r"(r2), "r"(r4));
  // PTX:327 cvta.to.global.u64 %rd31, %rd176
  rd31 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd176));
  // PTX:328 cvta.to.global.u64 %rd32, %rd177
  rd32 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd177));
  // PTX:329 cvta.to.global.u64 %rd33, %rd178
  rd33 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd178));
  // PTX:330 mov.u32 %r213, 0
  asm("mov.u32 %0, 0;" : "=r"(r213) : );
  // PTX:332 $L__BB6_29:
L_BB6_29:;
  // PTX:333 add.s32 %r123, %r213, %r3
  asm("add.s32 %0, %1, %2;" : "=r"(r123) : "r"(r213), "r"(r3));
  // PTX:334 mul.wide.u32 %rd101, %r123, 4
  asm("mul.wide.u32 %0, %1, 4;" : "=l"(rd101) : "r"(r123));
  // PTX:335 add.s64 %rd35, %rd3, %rd101
  asm("add.s64 %0, %1, %2;" : "=l"(rd35) : "l"(rd3), "l"(rd101));
  // PTX:336 ld.global.u32 %r124, [%rd35]
  r124 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (0)))));
  // PTX:337 setp.gt.s32 %p28, %r124, -1
  p28 = (((int)(r124)) > ((int)(-1)));
  // PTX:338 @%p28 bra $L__BB6_76
  if (p28) { goto L_BB6_76; }
  // PTX:340 ld.global.u32 %r127, [%rd26]
  r127 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (0)))));
  // PTX:341 ld.global.u32 %r27, [%rd27]
  r27 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))));
  // PTX:342 add.s32 %r28, %r127, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r28) : "r"(r127));
  // PTX:343 mov.u32 %r249, -1
  asm("mov.u32 %0, -1;" : "=r"(r249) : );
  // PTX:344 ld.global.u32 %r128, [%rd26+4]
  r128 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (4)))));
  // PTX:345 add.s32 %r29, %r128, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r29) : "r"(r128));
  // PTX:346 ld.global.u32 %r129, [%rd26+8]
  r129 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (8)))));
  // PTX:347 add.s32 %r30, %r129, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r30) : "r"(r129));
  // PTX:348 mov.u32 %r246, 0
  asm("mov.u32 %0, 0;" : "=r"(r246) : );
  // PTX:349 bra.uni $L__BB6_31
  goto L_BB6_31;
  // PTX:351 $L__BB6_40:
L_BB6_40:;
  // PTX:352 mul.wide.u32 %rd107, %r246, -1431655765
  asm("mul.wide.u32 %0, %1, -1431655765;" : "=l"(rd107) : "r"(r246));
  // PTX:353 shr.u64 %rd108, %rd107, 33
  asm("shr.u64 %0, %1, 33;" : "=l"(rd108) : "l"(rd107));
  // PTX:354 cvt.u32.u64 %r135, %rd108
  asm("cvt.u32.u64 %0, %1;" : "=r"(r135) : "l"(rd108));
  // PTX:355 mul.lo.s32 %r136, %r135, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r136) : "r"(r135));
  // PTX:356 sub.s32 %r137, %r246, %r136
  asm("sub.s32 %0, %1, %2;" : "=r"(r137) : "r"(r246), "r"(r136));
  // PTX:357 mul.wide.u32 %rd109, %r135, -1431655765
  asm("mul.wide.u32 %0, %1, -1431655765;" : "=l"(rd109) : "r"(r135));
  // PTX:358 shr.u64 %rd110, %rd109, 33
  asm("shr.u64 %0, %1, 33;" : "=l"(rd110) : "l"(rd109));
  // PTX:359 cvt.u32.u64 %r138, %rd110
  asm("cvt.u32.u64 %0, %1;" : "=r"(r138) : "l"(rd110));
  // PTX:360 mul.lo.s32 %r139, %r138, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r139) : "r"(r138));
  // PTX:361 sub.s32 %r140, %r135, %r139
  asm("sub.s32 %0, %1, %2;" : "=r"(r140) : "r"(r135), "r"(r139));
  // PTX:362 add.s32 %r242, %r28, %r137
  asm("add.s32 %0, %1, %2;" : "=r"(r242) : "r"(r28), "r"(r137));
  // PTX:363 add.s32 %r243, %r29, %r140
  asm("add.s32 %0, %1, %2;" : "=r"(r243) : "r"(r29), "r"(r140));
  // PTX:364 mul.wide.u32 %rd111, %r246, 954437177
  asm("mul.wide.u32 %0, %1, 954437177;" : "=l"(rd111) : "r"(r246));
  // PTX:365 shr.u64 %rd112, %rd111, 33
  asm("shr.u64 %0, %1, 33;" : "=l"(rd112) : "l"(rd111));
  // PTX:366 cvt.u32.u64 %r141, %rd112
  asm("cvt.u32.u64 %0, %1;" : "=r"(r141) : "l"(rd112));
  // PTX:367 add.s32 %r244, %r30, %r141
  asm("add.s32 %0, %1, %2;" : "=r"(r244) : "r"(r30), "r"(r141));
  // PTX:368 add.s32 %r246, %r246, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r246) : "r"(r246));
  // PTX:369 mul.lo.s32 %r142, %r242, 73856093
  asm("mul.lo.s32 %0, %1, 73856093;" : "=r"(r142) : "r"(r242));
  // PTX:370 mul.lo.s32 %r143, %r243, 19349663
  asm("mul.lo.s32 %0, %1, 19349663;" : "=r"(r143) : "r"(r243));
  // PTX:371 mul.lo.s32 %r144, %r244, 83492791
  asm("mul.lo.s32 %0, %1, 83492791;" : "=r"(r144) : "r"(r244));
  // PTX:372 xor.b32 %r145, %r144, %r142
  asm("xor.b32 %0, %1, %2;" : "=r"(r145) : "r"(r144), "r"(r142));
  // PTX:373 xor.b32 %r146, %r145, %r143
  asm("xor.b32 %0, %1, %2;" : "=r"(r146) : "r"(r145), "r"(r143));
  // PTX:374 and.b32 %r147, %r146, %r21
  asm("and.b32 %0, %1, %2;" : "=r"(r147) : "r"(r146), "r"(r21));
  // PTX:375 mul.wide.s32 %rd113, %r147, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd113) : "r"(r147));
  // PTX:376 add.s64 %rd114, %rd4, %rd113
  asm("add.s64 %0, %1, %2;" : "=l"(rd114) : "l"(rd4), "l"(rd113));
  // PTX:377 ld.global.u32 %r249, [%rd114]
  r249 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd114) + (0)))));
  // PTX:379 $L__BB6_31:
L_BB6_31:;
  // PTX:380 setp.lt.s32 %p29, %r249, 0
  p29 = (((int)(r249)) < ((int)(0)));
  // PTX:381 @%p29 bra $L__BB6_39
  if (p29) { goto L_BB6_39; }
  // PTX:383 mov.u32 %r250, %r249
  asm("mov.u32 %0, %1;" : "=r"(r250) : "r"(r249));
  // PTX:385 $L__BB6_33:
L_BB6_33:;
  // PTX:386 mul.wide.s32 %rd102, %r250, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd102) : "r"(r250));
  // PTX:387 add.s64 %rd103, %rd5, %rd102
  asm("add.s64 %0, %1, %2;" : "=l"(rd103) : "l"(rd5), "l"(rd102));
  // PTX:388 ld.global.u32 %r249, [%rd103]
  r249 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd103) + (0)))));
  // PTX:389 mul.wide.s32 %rd104, %r250, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd104) : "r"(r250));
  // PTX:390 add.s64 %rd37, %rd8, %rd104
  asm("add.s64 %0, %1, %2;" : "=l"(rd37) : "l"(rd8), "l"(rd104));
  // PTX:391 ld.global.u32 %r130, [%rd37]
  r130 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (0)))));
  // PTX:392 setp.ne.s32 %p30, %r130, %r242
  p30 = (((int)(r130)) != ((int)(r242)));
  // PTX:393 mov.u16 %rs20, 0
  asm("mov.u16 %0, 0;" : "=h"(rs20) : );
  // PTX:394 @%p30 bra $L__BB6_36
  if (p30) { goto L_BB6_36; }
  // PTX:396 mul.wide.s32 %rd167, %r250, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd167) : "r"(r250));
  // PTX:397 add.s64 %rd166, %rd8, %rd167
  asm("add.s64 %0, %1, %2;" : "=l"(rd166) : "l"(rd8), "l"(rd167));
  // PTX:398 ld.global.u32 %r131, [%rd166+4]
  r131 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd166) + (4)))));
  // PTX:399 setp.ne.s32 %p31, %r131, %r243
  p31 = (((int)(r131)) != ((int)(r243)));
  // PTX:400 @%p31 bra $L__BB6_36
  if (p31) { goto L_BB6_36; }
  // PTX:402 mul.wide.s32 %rd169, %r250, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd169) : "r"(r250));
  // PTX:403 add.s64 %rd168, %rd8, %rd169
  asm("add.s64 %0, %1, %2;" : "=l"(rd168) : "l"(rd8), "l"(rd169));
  // PTX:404 ld.global.u32 %r132, [%rd168+8]
  r132 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd168) + (8)))));
  // PTX:405 setp.eq.s32 %p32, %r132, %r244
  p32 = (((int)(r132)) == ((int)(r244)));
  // PTX:406 selp.u16 %rs20, 1, 0, %p32
  rs20 = p32 ? 1 : 0;
  // PTX:408 $L__BB6_36:
L_BB6_36:;
  // PTX:409 setp.eq.s16 %p33, %rs20, 0
  p33 = (((short)(rs20)) == ((short)(0)));
  // PTX:410 @%p33 bra $L__BB6_38
  if (p33) { goto L_BB6_38; }
  // PTX:412 cvt.s64.s32 %rd165, %r250
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd165) : "r"(r250));
  // PTX:413 shl.b64 %rd105, %rd165, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd105) : "l"(rd165));
  // PTX:414 add.s64 %rd106, %rd7, %rd105
  asm("add.s64 %0, %1, %2;" : "=l"(rd106) : "l"(rd7), "l"(rd105));
  // PTX:415 ld.global.u32 %r133, [%rd106]
  r133 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (0)))));
  // PTX:416 setp.eq.s32 %p34, %r133, %r27
  p34 = (((int)(r133)) == ((int)(r27)));
  // PTX:417 @%p34 bra $L__BB6_41
  if (p34) { goto L_BB6_41; }
  // PTX:419 $L__BB6_38:
L_BB6_38:;
  // PTX:420 setp.gt.s32 %p35, %r249, -1
  p35 = (((int)(r249)) > ((int)(-1)));
  // PTX:421 mov.u32 %r250, %r249
  asm("mov.u32 %0, %1;" : "=r"(r250) : "r"(r249));
  // PTX:422 @%p35 bra $L__BB6_33
  if (p35) { goto L_BB6_33; }
  // PTX:424 $L__BB6_39:
L_BB6_39:;
  // PTX:425 setp.eq.s32 %p36, %r246, 27
  p36 = (((int)(r246)) == ((int)(27)));
  // PTX:426 mov.u32 %r250, -1
  asm("mov.u32 %0, -1;" : "=r"(r250) : );
  // PTX:427 @%p36 bra $L__BB6_41
  if (p36) { goto L_BB6_41; }
  // PTX:428 bra.uni $L__BB6_40
  goto L_BB6_40;
  // PTX:430 $L__BB6_41:
L_BB6_41:;
  // PTX:431 setp.lt.s32 %p37, %r250, 0
  p37 = (((int)(r250)) < ((int)(0)));
  // PTX:432 mov.f32 %f150, 0f7F800000
  asm("mov.f32 %0, 0f7F800000;" : "=f"(f150) : );
  // PTX:433 mov.u32 %r241, -1
  asm("mov.u32 %0, -1;" : "=r"(r241) : );
  // PTX:434 @%p37 bra $L__BB6_74
  if (p37) { goto L_BB6_74; }
  // PTX:436 mov.b64 %rd162, _ZN7synreal15granular_kernel10form_bondsENS_5ModelENS0_4ViewEPKiS4_PiPN3glm3vecILi2EiLNS6_9qualifierE0EEEPfSB_S5__param_0
  rd162 = (unsigned long long)(uintptr_t)&param0;
  // PTX:437 add.s64 %rd161, %rd162, 340
  asm("add.s64 %0, %1, 340;" : "=l"(rd161) : "l"(rd162));
  // PTX:438 mov.u32 %r241, -1
  asm("mov.u32 %0, -1;" : "=r"(r241) : );
  // PTX:439 mov.f32 %f150, 0f7F800000
  asm("mov.f32 %0, 0f7F800000;" : "=f"(f150) : );
  // PTX:441 $L__BB6_43:
L_BB6_43:;
  // PTX:442 setp.le.s32 %p38, %r250, %r1
  p38 = (((int)(r250)) <= ((int)(r1)));
  // PTX:443 @%p38 bra $L__BB6_63
  if (p38) { goto L_BB6_63; }
  // PTX:445 ld.global.u32 %r235, [%rd28]
  r235 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (0)))));
  // PTX:446 ld.global.u32 %r54, [%rd28+4]
  r54 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (4)))));
  // PTX:447 setp.le.s32 %p39, %r54, %r235
  p39 = (((int)(r54)) <= ((int)(r235)));
  // PTX:448 @%p39 bra $L__BB6_47
  if (p39) { goto L_BB6_47; }
  // PTX:450 mov.u32 %r233, %r54
  asm("mov.u32 %0, %1;" : "=r"(r233) : "r"(r54));
  // PTX:452 $L__BB6_46:
L_BB6_46:;
  // PTX:453 sub.s32 %r150, %r233, %r235
  asm("sub.s32 %0, %1, %2;" : "=r"(r150) : "r"(r233), "r"(r235));
  // PTX:454 shr.u32 %r151, %r150, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r151) : "r"(r150));
  // PTX:455 add.s32 %r152, %r150, %r151
  asm("add.s32 %0, %1, %2;" : "=r"(r152) : "r"(r150), "r"(r151));
  // PTX:456 shr.s32 %r153, %r152, 1
  asm("shr.s32 %0, %1, 1;" : "=r"(r153) : "r"(r152));
  // PTX:457 add.s32 %r154, %r153, %r235
  asm("add.s32 %0, %1, %2;" : "=r"(r154) : "r"(r153), "r"(r235));
  // PTX:458 mul.wide.s32 %rd115, %r154, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd115) : "r"(r154));
  // PTX:459 add.s64 %rd116, %rd1, %rd115
  asm("add.s64 %0, %1, %2;" : "=l"(rd116) : "l"(rd1), "l"(rd115));
  // PTX:460 ld.global.u32 %r155, [%rd116]
  r155 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd116) + (0)))));
  // PTX:461 setp.lt.s32 %p40, %r155, %r250
  p40 = (((int)(r155)) < ((int)(r250)));
  // PTX:462 add.s32 %r156, %r154, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r156) : "r"(r154));
  // PTX:463 selp.b32 %r235, %r156, %r235, %p40
  r235 = p40 ? r156 : r235;
  // PTX:464 selp.b32 %r233, %r233, %r154, %p40
  r233 = p40 ? r233 : r154;
  // PTX:465 setp.gt.s32 %p41, %r233, %r235
  p41 = (((int)(r233)) > ((int)(r235)));
  // PTX:466 @%p41 bra $L__BB6_46
  if (p41) { goto L_BB6_46; }
  // PTX:468 $L__BB6_47:
L_BB6_47:;
  // PTX:469 setp.ge.s32 %p42, %r235, %r54
  p42 = (((int)(r235)) >= ((int)(r54)));
  // PTX:470 mov.u16 %rs21, 0
  asm("mov.u16 %0, 0;" : "=h"(rs21) : );
  // PTX:471 @%p42 bra $L__BB6_49
  if (p42) { goto L_BB6_49; }
  // PTX:473 mul.wide.s32 %rd117, %r235, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd117) : "r"(r235));
  // PTX:474 add.s64 %rd118, %rd1, %rd117
  asm("add.s64 %0, %1, %2;" : "=l"(rd118) : "l"(rd1), "l"(rd117));
  // PTX:475 ld.global.u32 %r157, [%rd118]
  r157 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd118) + (0)))));
  // PTX:476 setp.eq.s32 %p43, %r157, %r250
  p43 = (((int)(r157)) == ((int)(r250)));
  // PTX:477 selp.u16 %rs21, 1, 0, %p43
  rs21 = p43 ? 1 : 0;
  // PTX:479 $L__BB6_49:
L_BB6_49:;
  // PTX:480 setp.ne.s16 %p44, %rs21, 0
  p44 = (((short)(rs21)) != ((short)(0)));
  // PTX:481 @%p44 bra $L__BB6_63
  if (p44) { goto L_BB6_63; }
  // PTX:483 mov.b64 %rd164, _ZN7synreal15granular_kernel10form_bondsENS_5ModelENS0_4ViewEPKiS4_PiPN3glm3vecILi2EiLNS6_9qualifierE0EEEPfSB_S5__param_0
  rd164 = (unsigned long long)(uintptr_t)&param0;
  // PTX:484 add.s64 %rd163, %rd164, 340
  asm("add.s64 %0, %1, 340;" : "=l"(rd163) : "l"(rd164));
  // PTX:485 ld.param.f32 %f148, [%rd161+-8]
  f148 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd161) + (-8))));
  // PTX:486 mul.wide.s32 %rd119, %r250, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd119) : "r"(r250));
  // PTX:487 add.s64 %rd120, %rd9, %rd119
  asm("add.s64 %0, %1, %2;" : "=l"(rd120) : "l"(rd9), "l"(rd119));
  // PTX:488 ld.global.f32 %f114, [%rd120]
  f114 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd120) + (0)))));
  // PTX:489 ld.global.f32 %f115, [%rd15]
  f115 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))));
  // PTX:490 sub.f32 %f5, %f115, %f114
  asm("sub.f32 %0, %1, %2;" : "=f"(f5) : "f"(f115), "f"(f114));
  // PTX:491 ld.global.f32 %f116, [%rd120+4]
  f116 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd120) + (4)))));
  // PTX:492 ld.global.f32 %f117, [%rd15+4]
  f117 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (4)))));
  // PTX:493 sub.f32 %f6, %f117, %f116
  asm("sub.f32 %0, %1, %2;" : "=f"(f6) : "f"(f117), "f"(f116));
  // PTX:494 ld.global.f32 %f118, [%rd120+8]
  f118 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd120) + (8)))));
  // PTX:495 ld.global.f32 %f119, [%rd15+8]
  f119 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (8)))));
  // PTX:496 sub.f32 %f7, %f119, %f118
  asm("sub.f32 %0, %1, %2;" : "=f"(f7) : "f"(f119), "f"(f118));
  // PTX:497 mul.f32 %f120, %f6, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f120) : "f"(f6), "f"(f6));
  // PTX:498 fma.rn.f32 %f121, %f5, %f5, %f120
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f121) : "f"(f5), "f"(f5), "f"(f120));
  // PTX:499 fma.rn.f32 %f8, %f7, %f7, %f121
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f8) : "f"(f7), "f"(f7), "f"(f121));
  // PTX:500 mul.wide.s32 %rd121, %r250, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd121) : "r"(r250));
  // PTX:501 add.s64 %rd122, %rd11, %rd121
  asm("add.s64 %0, %1, %2;" : "=l"(rd122) : "l"(rd11), "l"(rd121));
  // PTX:502 ld.global.f32 %f122, [%rd122]
  f122 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd122) + (0)))));
  // PTX:503 ld.global.f32 %f123, [%rd14]
  f123 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:504 add.f32 %f124, %f123, %f122
  asm("add.f32 %0, %1, %2;" : "=f"(f124) : "f"(f123), "f"(f122));
  // PTX:505 add.f32 %f125, %f124, %f148
  asm("add.f32 %0, %1, %2;" : "=f"(f125) : "f"(f124), "f"(f148));
  // PTX:506 setp.le.f32 %p45, %f8, 0f24E69595
  p45 = (!(isnan(((float)(f8))) || isnan(((float)(as_f32(0x24E69595u))))) && (((float)(f8)) <= ((float)(as_f32(0x24E69595u)))));
  // PTX:507 mul.f32 %f126, %f125, %f125
  asm("mul.f32 %0, %1, %2;" : "=f"(f126) : "f"(f125), "f"(f125));
  // PTX:508 setp.gt.f32 %p46, %f8, %f126
  p46 = (!(isnan(((float)(f8))) || isnan(((float)(f126)))) && (((float)(f8)) > ((float)(f126))));
  // PTX:509 or.pred %p47, %p45, %p46
  p47 = ((p45) || (p46));
  // PTX:510 @%p47 bra $L__BB6_63
  if (p47) { goto L_BB6_63; }
  // PTX:512 mov.b64 %rd156, _ZN7synreal15granular_kernel10form_bondsENS_5ModelENS0_4ViewEPKiS4_PiPN3glm3vecILi2EiLNS6_9qualifierE0EEEPfSB_S5__param_0
  rd156 = (unsigned long long)(uintptr_t)&param0;
  // PTX:513 add.s64 %rd155, %rd156, 340
  asm("add.s64 %0, %1, 340;" : "=l"(rd155) : "l"(rd156));
  // PTX:514 ld.param.f32 %f146, [%rd155+-4]
  f146 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd155) + (-4))));
  // PTX:515 ld.param.f32 %f145, [_ZN7synreal15granular_kernel10form_bondsENS_5ModelENS0_4ViewEPKiS4_PiPN3glm3vecILi2EiLNS6_9qualifierE0EEEPfSB_S5__param_1+112]
  f145 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param1 + (112))));
  // PTX:516 mul.f32 %f144, %f145, %f146
  asm("mul.f32 %0, %1, %2;" : "=f"(f144) : "f"(f145), "f"(f146));
  // PTX:517 mul.f32 %f143, %f144, %f144
  asm("mul.f32 %0, %1, %2;" : "=f"(f143) : "f"(f144), "f"(f144));
  // PTX:518 cvt.s64.s32 %rd154, %r250
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd154) : "r"(r250));
  // PTX:519 mul.lo.s64 %rd123, %rd154, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd123) : "l"(rd154));
  // PTX:520 add.s64 %rd124, %rd10, %rd123
  asm("add.s64 %0, %1, %2;" : "=l"(rd124) : "l"(rd10), "l"(rd123));
  // PTX:521 ld.global.f32 %f127, [%rd124]
  f127 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd124) + (0)))));
  // PTX:522 ld.global.f32 %f128, [%rd29]
  f128 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (0)))));
  // PTX:523 sub.f32 %f129, %f128, %f127
  asm("sub.f32 %0, %1, %2;" : "=f"(f129) : "f"(f128), "f"(f127));
  // PTX:524 ld.global.f32 %f130, [%rd124+4]
  f130 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd124) + (4)))));
  // PTX:525 ld.global.f32 %f131, [%rd29+4]
  f131 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (4)))));
  // PTX:526 sub.f32 %f132, %f131, %f130
  asm("sub.f32 %0, %1, %2;" : "=f"(f132) : "f"(f131), "f"(f130));
  // PTX:527 ld.global.f32 %f133, [%rd124+8]
  f133 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd124) + (8)))));
  // PTX:528 ld.global.f32 %f134, [%rd29+8]
  f134 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (8)))));
  // PTX:529 sub.f32 %f135, %f134, %f133
  asm("sub.f32 %0, %1, %2;" : "=f"(f135) : "f"(f134), "f"(f133));
  // PTX:530 sub.f32 %f136, %f5, %f129
  asm("sub.f32 %0, %1, %2;" : "=f"(f136) : "f"(f5), "f"(f129));
  // PTX:531 sub.f32 %f137, %f6, %f132
  asm("sub.f32 %0, %1, %2;" : "=f"(f137) : "f"(f6), "f"(f132));
  // PTX:532 sub.f32 %f138, %f7, %f135
  asm("sub.f32 %0, %1, %2;" : "=f"(f138) : "f"(f7), "f"(f135));
  // PTX:533 mul.f32 %f139, %f137, %f137
  asm("mul.f32 %0, %1, %2;" : "=f"(f139) : "f"(f137), "f"(f137));
  // PTX:534 fma.rn.f32 %f140, %f136, %f136, %f139
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f140) : "f"(f136), "f"(f136), "f"(f139));
  // PTX:535 fma.rn.f32 %f141, %f138, %f138, %f140
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f141) : "f"(f138), "f"(f138), "f"(f140));
  // PTX:536 setp.gt.f32 %p48, %f141, %f143
  p48 = (!(isnan(((float)(f141))) || isnan(((float)(f143)))) && (((float)(f141)) > ((float)(f143))));
  // PTX:537 @%p48 bra $L__BB6_63
  if (p48) { goto L_BB6_63; }
  // PTX:539 mov.u32 %r239, 0
  asm("mov.u32 %0, 0;" : "=r"(r239) : );
  // PTX:540 mov.u32 %r240, %r239
  asm("mov.u32 %0, %1;" : "=r"(r240) : "r"(r239));
  // PTX:541 @%p9 bra $L__BB6_55
  if (p9) { goto L_BB6_55; }
  // PTX:543 mov.u32 %r239, 0
  asm("mov.u32 %0, 0;" : "=r"(r239) : );
  // PTX:544 mov.u32 %r238, %r22
  asm("mov.u32 %0, %1;" : "=r"(r238) : "r"(r22));
  // PTX:546 $L__BB6_54:
L_BB6_54:;
  // PTX:547 add.s32 %r162, %r239, %r3
  asm("add.s32 %0, %1, %2;" : "=r"(r162) : "r"(r239), "r"(r3));
  // PTX:548 mul.wide.u32 %rd125, %r162, 4
  asm("mul.wide.u32 %0, %1, 4;" : "=l"(rd125) : "r"(r162));
  // PTX:549 add.s64 %rd126, %rd3, %rd125
  asm("add.s64 %0, %1, %2;" : "=l"(rd126) : "l"(rd3), "l"(rd125));
  // PTX:550 ld.global.u32 %r163, [%rd126]
  r163 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd126) + (0)))));
  // PTX:551 setp.eq.s32 %p51, %r163, %r250
  p51 = (((int)(r163)) == ((int)(r250)));
  // PTX:552 selp.u32 %r164, 1, 0, %p51
  r164 = p51 ? 1 : 0;
  // PTX:553 or.b32 %r165, %r240, %r164
  asm("or.b32 %0, %1, %2;" : "=r"(r165) : "r"(r240), "r"(r164));
  // PTX:554 setp.ne.s32 %p52, %r165, 0
  p52 = (((int)(r165)) != ((int)(0)));
  // PTX:555 add.s32 %r166, %r162, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r166) : "r"(r162));
  // PTX:556 mul.wide.u32 %rd127, %r166, 4
  asm("mul.wide.u32 %0, %1, 4;" : "=l"(rd127) : "r"(r166));
  // PTX:557 add.s64 %rd128, %rd3, %rd127
  asm("add.s64 %0, %1, %2;" : "=l"(rd128) : "l"(rd3), "l"(rd127));
  // PTX:558 ld.global.u32 %r167, [%rd128]
  r167 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd128) + (0)))));
  // PTX:559 setp.eq.s32 %p53, %r167, %r250
  p53 = (((int)(r167)) == ((int)(r250)));
  // PTX:560 or.pred %p54, %p52, %p53
  p54 = ((p52) || (p53));
  // PTX:561 add.s32 %r168, %r162, 2
  asm("add.s32 %0, %1, 2;" : "=r"(r168) : "r"(r162));
  // PTX:562 mul.wide.u32 %rd129, %r168, 4
  asm("mul.wide.u32 %0, %1, 4;" : "=l"(rd129) : "r"(r168));
  // PTX:563 add.s64 %rd130, %rd3, %rd129
  asm("add.s64 %0, %1, %2;" : "=l"(rd130) : "l"(rd3), "l"(rd129));
  // PTX:564 ld.global.u32 %r169, [%rd130]
  r169 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd130) + (0)))));
  // PTX:565 setp.eq.s32 %p55, %r169, %r250
  p55 = (((int)(r169)) == ((int)(r250)));
  // PTX:566 or.pred %p56, %p54, %p55
  p56 = ((p54) || (p55));
  // PTX:567 add.s32 %r170, %r162, 3
  asm("add.s32 %0, %1, 3;" : "=r"(r170) : "r"(r162));
  // PTX:568 mul.wide.u32 %rd131, %r170, 4
  asm("mul.wide.u32 %0, %1, 4;" : "=l"(rd131) : "r"(r170));
  // PTX:569 add.s64 %rd132, %rd3, %rd131
  asm("add.s64 %0, %1, %2;" : "=l"(rd132) : "l"(rd3), "l"(rd131));
  // PTX:570 ld.global.u32 %r171, [%rd132]
  r171 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd132) + (0)))));
  // PTX:571 setp.eq.s32 %p57, %r171, %r250
  p57 = (((int)(r171)) == ((int)(r250)));
  // PTX:572 or.pred %p82, %p56, %p57
  p82 = ((p56) || (p57));
  // PTX:573 selp.u32 %r240, 1, 0, %p82
  r240 = p82 ? 1 : 0;
  // PTX:574 add.s32 %r239, %r239, 4
  asm("add.s32 %0, %1, 4;" : "=r"(r239) : "r"(r239));
  // PTX:575 add.s32 %r238, %r238, -4
  asm("add.s32 %0, %1, -4;" : "=r"(r238) : "r"(r238));
  // PTX:576 setp.ne.s32 %p58, %r238, 0
  p58 = (((int)(r238)) != ((int)(0)));
  // PTX:577 @%p58 bra $L__BB6_54
  if (p58) { goto L_BB6_54; }
  // PTX:579 $L__BB6_55:
L_BB6_55:;
  // PTX:580 @%p23 bra $L__BB6_59
  if (p23) { goto L_BB6_59; }
  // PTX:582 setp.eq.s32 %p60, %r4, 1
  p60 = (((int)(r4)) == ((int)(1)));
  // PTX:583 add.s32 %r68, %r239, %r3
  asm("add.s32 %0, %1, %2;" : "=r"(r68) : "r"(r239), "r"(r3));
  // PTX:584 mul.wide.u32 %rd133, %r68, 4
  asm("mul.wide.u32 %0, %1, 4;" : "=l"(rd133) : "r"(r68));
  // PTX:585 add.s64 %rd134, %rd3, %rd133
  asm("add.s64 %0, %1, %2;" : "=l"(rd134) : "l"(rd3), "l"(rd133));
  // PTX:586 ld.global.u32 %r172, [%rd134]
  r172 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd134) + (0)))));
  // PTX:587 setp.eq.s32 %p61, %r172, %r250
  p61 = (((int)(r172)) == ((int)(r250)));
  // PTX:588 selp.u32 %r173, 1, 0, %p61
  r173 = p61 ? 1 : 0;
  // PTX:589 or.b32 %r69, %r240, %r173
  asm("or.b32 %0, %1, %2;" : "=r"(r69) : "r"(r240), "r"(r173));
  // PTX:590 setp.ne.s32 %p82, %r69, 0
  p82 = (((int)(r69)) != ((int)(0)));
  // PTX:591 @%p60 bra $L__BB6_59
  if (p60) { goto L_BB6_59; }
  // PTX:593 setp.ne.s32 %p62, %r69, 0
  p62 = (((int)(r69)) != ((int)(0)));
  // PTX:594 add.s32 %r174, %r68, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r174) : "r"(r68));
  // PTX:595 mul.wide.u32 %rd135, %r174, 4
  asm("mul.wide.u32 %0, %1, 4;" : "=l"(rd135) : "r"(r174));
  // PTX:596 add.s64 %rd136, %rd3, %rd135
  asm("add.s64 %0, %1, %2;" : "=l"(rd136) : "l"(rd3), "l"(rd135));
  // PTX:597 ld.global.u32 %r175, [%rd136]
  r175 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd136) + (0)))));
  // PTX:598 setp.eq.s32 %p63, %r175, %r250
  p63 = (((int)(r175)) == ((int)(r250)));
  // PTX:599 or.pred %p82, %p62, %p63
  p82 = ((p62) || (p63));
  // PTX:600 setp.eq.s32 %p64, %r4, 2
  p64 = (((int)(r4)) == ((int)(2)));
  // PTX:601 @%p64 bra $L__BB6_59
  if (p64) { goto L_BB6_59; }
  // PTX:603 add.s32 %r176, %r68, 2
  asm("add.s32 %0, %1, 2;" : "=r"(r176) : "r"(r68));
  // PTX:604 mul.wide.u32 %rd137, %r176, 4
  asm("mul.wide.u32 %0, %1, 4;" : "=l"(rd137) : "r"(r176));
  // PTX:605 add.s64 %rd138, %rd3, %rd137
  asm("add.s64 %0, %1, %2;" : "=l"(rd138) : "l"(rd3), "l"(rd137));
  // PTX:606 ld.global.u32 %r177, [%rd138]
  r177 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd138) + (0)))));
  // PTX:607 setp.eq.s32 %p65, %r177, %r250
  p65 = (((int)(r177)) == ((int)(r250)));
  // PTX:608 or.pred %p82, %p82, %p65
  p82 = ((p82) || (p65));
  // PTX:610 $L__BB6_59:
L_BB6_59:;
  // PTX:611 @%p82 bra $L__BB6_63
  if (p82) { goto L_BB6_63; }
  // PTX:613 setp.lt.f32 %p66, %f8, %f150
  p66 = (!(isnan(((float)(f8))) || isnan(((float)(f150)))) && (((float)(f8)) < ((float)(f150))));
  // PTX:614 @%p66 bra $L__BB6_62
  if (p66) { goto L_BB6_62; }
  // PTX:616 setp.neu.f32 %p67, %f8, %f150
  p67 = ((isnan(((float)(f8))) || isnan(((float)(f150)))) || (((float)(f8)) != ((float)(f150))));
  // PTX:617 setp.ge.s32 %p68, %r250, %r241
  p68 = (((int)(r250)) >= ((int)(r241)));
  // PTX:618 or.pred %p69, %p68, %p67
  p69 = ((p68) || (p67));
  // PTX:619 @%p69 bra $L__BB6_63
  if (p69) { goto L_BB6_63; }
  // PTX:621 $L__BB6_62:
L_BB6_62:;
  // PTX:622 mov.u32 %r241, %r250
  asm("mov.u32 %0, %1;" : "=r"(r241) : "r"(r250));
  // PTX:623 mov.f32 %f150, %f8
  asm("mov.f32 %0, %1;" : "=f"(f150) : "f"(f8));
  // PTX:624 bra.uni $L__BB6_63
  goto L_BB6_63;
  // PTX:626 $L__BB6_72:
L_BB6_72:;
  // PTX:627 mul.hi.s32 %r183, %r246, 1431655766
  asm("mul.hi.s32 %0, %1, 1431655766;" : "=r"(r183) : "r"(r246));
  // PTX:628 shr.u32 %r184, %r183, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r184) : "r"(r183));
  // PTX:629 add.s32 %r185, %r183, %r184
  asm("add.s32 %0, %1, %2;" : "=r"(r185) : "r"(r183), "r"(r184));
  // PTX:630 mul.lo.s32 %r186, %r185, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r186) : "r"(r185));
  // PTX:631 sub.s32 %r187, %r246, %r186
  asm("sub.s32 %0, %1, %2;" : "=r"(r187) : "r"(r246), "r"(r186));
  // PTX:632 mul.hi.s32 %r188, %r185, 1431655766
  asm("mul.hi.s32 %0, %1, 1431655766;" : "=r"(r188) : "r"(r185));
  // PTX:633 shr.u32 %r189, %r188, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r189) : "r"(r188));
  // PTX:634 add.s32 %r190, %r188, %r189
  asm("add.s32 %0, %1, %2;" : "=r"(r190) : "r"(r188), "r"(r189));
  // PTX:635 mul.lo.s32 %r191, %r190, 3
  asm("mul.lo.s32 %0, %1, 3;" : "=r"(r191) : "r"(r190));
  // PTX:636 sub.s32 %r192, %r185, %r191
  asm("sub.s32 %0, %1, %2;" : "=r"(r192) : "r"(r185), "r"(r191));
  // PTX:637 add.s32 %r242, %r28, %r187
  asm("add.s32 %0, %1, %2;" : "=r"(r242) : "r"(r28), "r"(r187));
  // PTX:638 add.s32 %r243, %r29, %r192
  asm("add.s32 %0, %1, %2;" : "=r"(r243) : "r"(r29), "r"(r192));
  // PTX:639 mul.hi.s32 %r193, %r246, 954437177
  asm("mul.hi.s32 %0, %1, 954437177;" : "=r"(r193) : "r"(r246));
  // PTX:640 shr.u32 %r194, %r193, 31
  asm("shr.u32 %0, %1, 31;" : "=r"(r194) : "r"(r193));
  // PTX:641 shr.s32 %r195, %r193, 1
  asm("shr.s32 %0, %1, 1;" : "=r"(r195) : "r"(r193));
  // PTX:642 add.s32 %r196, %r195, %r194
  asm("add.s32 %0, %1, %2;" : "=r"(r196) : "r"(r195), "r"(r194));
  // PTX:643 add.s32 %r244, %r30, %r196
  asm("add.s32 %0, %1, %2;" : "=r"(r244) : "r"(r30), "r"(r196));
  // PTX:644 add.s32 %r246, %r246, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r246) : "r"(r246));
  // PTX:645 mul.lo.s32 %r197, %r242, 73856093
  asm("mul.lo.s32 %0, %1, 73856093;" : "=r"(r197) : "r"(r242));
  // PTX:646 mul.lo.s32 %r198, %r243, 19349663
  asm("mul.lo.s32 %0, %1, 19349663;" : "=r"(r198) : "r"(r243));
  // PTX:647 mul.lo.s32 %r199, %r244, 83492791
  asm("mul.lo.s32 %0, %1, 83492791;" : "=r"(r199) : "r"(r244));
  // PTX:648 xor.b32 %r200, %r199, %r197
  asm("xor.b32 %0, %1, %2;" : "=r"(r200) : "r"(r199), "r"(r197));
  // PTX:649 xor.b32 %r201, %r200, %r198
  asm("xor.b32 %0, %1, %2;" : "=r"(r201) : "r"(r200), "r"(r198));
  // PTX:650 and.b32 %r202, %r201, %r21
  asm("and.b32 %0, %1, %2;" : "=r"(r202) : "r"(r201), "r"(r21));
  // PTX:651 mul.wide.s32 %rd144, %r202, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd144) : "r"(r202));
  // PTX:652 add.s64 %rd145, %rd4, %rd144
  asm("add.s64 %0, %1, %2;" : "=l"(rd145) : "l"(rd4), "l"(rd144));
  // PTX:653 ld.global.u32 %r249, [%rd145]
  r249 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd145) + (0)))));
  // PTX:655 $L__BB6_63:
L_BB6_63:;
  // PTX:656 setp.lt.s32 %p70, %r249, 0
  p70 = (((int)(r249)) < ((int)(0)));
  // PTX:657 @%p70 bra $L__BB6_71
  if (p70) { goto L_BB6_71; }
  // PTX:659 mov.u32 %r250, %r249
  asm("mov.u32 %0, %1;" : "=r"(r250) : "r"(r249));
  // PTX:661 $L__BB6_65:
L_BB6_65:;
  // PTX:662 mul.wide.s32 %rd139, %r250, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd139) : "r"(r250));
  // PTX:663 add.s64 %rd140, %rd5, %rd139
  asm("add.s64 %0, %1, %2;" : "=l"(rd140) : "l"(rd5), "l"(rd139));
  // PTX:664 ld.global.u32 %r249, [%rd140]
  r249 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd140) + (0)))));
  // PTX:665 mul.wide.s32 %rd141, %r250, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd141) : "r"(r250));
  // PTX:666 add.s64 %rd40, %rd8, %rd141
  asm("add.s64 %0, %1, %2;" : "=l"(rd40) : "l"(rd8), "l"(rd141));
  // PTX:667 ld.global.u32 %r178, [%rd40]
  r178 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (0)))));
  // PTX:668 setp.ne.s32 %p71, %r178, %r242
  p71 = (((int)(r178)) != ((int)(r242)));
  // PTX:669 mov.u16 %rs22, 0
  asm("mov.u16 %0, 0;" : "=h"(rs22) : );
  // PTX:670 @%p71 bra $L__BB6_68
  if (p71) { goto L_BB6_68; }
  // PTX:672 mul.wide.s32 %rd172, %r250, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd172) : "r"(r250));
  // PTX:673 add.s64 %rd171, %rd8, %rd172
  asm("add.s64 %0, %1, %2;" : "=l"(rd171) : "l"(rd8), "l"(rd172));
  // PTX:674 ld.global.u32 %r179, [%rd171+4]
  r179 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd171) + (4)))));
  // PTX:675 setp.ne.s32 %p72, %r179, %r243
  p72 = (((int)(r179)) != ((int)(r243)));
  // PTX:676 @%p72 bra $L__BB6_68
  if (p72) { goto L_BB6_68; }
  // PTX:678 mul.wide.s32 %rd174, %r250, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd174) : "r"(r250));
  // PTX:679 add.s64 %rd173, %rd8, %rd174
  asm("add.s64 %0, %1, %2;" : "=l"(rd173) : "l"(rd8), "l"(rd174));
  // PTX:680 ld.global.u32 %r180, [%rd173+8]
  r180 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd173) + (8)))));
  // PTX:681 setp.eq.s32 %p73, %r180, %r244
  p73 = (((int)(r180)) == ((int)(r244)));
  // PTX:682 selp.u16 %rs22, 1, 0, %p73
  rs22 = p73 ? 1 : 0;
  // PTX:684 $L__BB6_68:
L_BB6_68:;
  // PTX:685 setp.eq.s16 %p74, %rs22, 0
  p74 = (((short)(rs22)) == ((short)(0)));
  // PTX:686 @%p74 bra $L__BB6_70
  if (p74) { goto L_BB6_70; }
  // PTX:688 cvt.s64.s32 %rd170, %r250
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd170) : "r"(r250));
  // PTX:689 shl.b64 %rd142, %rd170, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd142) : "l"(rd170));
  // PTX:690 add.s64 %rd143, %rd7, %rd142
  asm("add.s64 %0, %1, %2;" : "=l"(rd143) : "l"(rd7), "l"(rd142));
  // PTX:691 ld.global.u32 %r181, [%rd143]
  r181 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd143) + (0)))));
  // PTX:692 setp.eq.s32 %p75, %r181, %r27
  p75 = (((int)(r181)) == ((int)(r27)));
  // PTX:693 @%p75 bra $L__BB6_73
  if (p75) { goto L_BB6_73; }
  // PTX:695 $L__BB6_70:
L_BB6_70:;
  // PTX:696 setp.gt.s32 %p76, %r249, -1
  p76 = (((int)(r249)) > ((int)(-1)));
  // PTX:697 mov.u32 %r250, %r249
  asm("mov.u32 %0, %1;" : "=r"(r250) : "r"(r249));
  // PTX:698 @%p76 bra $L__BB6_65
  if (p76) { goto L_BB6_65; }
  // PTX:700 $L__BB6_71:
L_BB6_71:;
  // PTX:701 setp.eq.s32 %p77, %r246, 27
  p77 = (((int)(r246)) == ((int)(27)));
  // PTX:702 mov.u32 %r250, -1
  asm("mov.u32 %0, -1;" : "=r"(r250) : );
  // PTX:703 @%p77 bra $L__BB6_73
  if (p77) { goto L_BB6_73; }
  // PTX:704 bra.uni $L__BB6_72
  goto L_BB6_72;
  // PTX:706 $L__BB6_73:
L_BB6_73:;
  // PTX:707 setp.gt.s32 %p78, %r250, -1
  p78 = (((int)(r250)) > ((int)(-1)));
  // PTX:708 @%p78 bra $L__BB6_43
  if (p78) { goto L_BB6_43; }
  // PTX:710 $L__BB6_74:
L_BB6_74:;
  // PTX:711 setp.lt.s32 %p79, %r241, 0
  p79 = (((int)(r241)) < ((int)(0)));
  // PTX:712 @%p79 bra $L__BB6_77
  if (p79) { goto L_BB6_77; }
  // PTX:714 add.s32 %r206, %r213, %r3
  asm("add.s32 %0, %1, %2;" : "=r"(r206) : "r"(r213), "r"(r3));
  // PTX:715 cvt.u64.u32 %rd159, %r206
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd159) : "r"(r206));
  // PTX:716 mul.wide.u32 %rd158, %r206, 4
  asm("mul.wide.u32 %0, %1, 4;" : "=l"(rd158) : "r"(r206));
  // PTX:717 add.s64 %rd157, %rd3, %rd158
  asm("add.s64 %0, %1, %2;" : "=l"(rd157) : "l"(rd3), "l"(rd158));
  // PTX:718 st.global.u32 [%rd157], %r241
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd157) + (0))))) = (unsigned)(r241);
  // PTX:719 ld.global.u32 %r203, [%rd30]
  r203 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0)))));
  // PTX:720 mul.wide.s32 %rd146, %r241, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd146) : "r"(r241));
  // PTX:721 add.s64 %rd147, %rd6, %rd146
  asm("add.s64 %0, %1, %2;" : "=l"(rd147) : "l"(rd6), "l"(rd146));
  // PTX:722 ld.global.u32 %r204, [%rd147]
  r204 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd147) + (0)))));
  // PTX:723 shl.b64 %rd148, %rd159, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd148) : "l"(rd159));
  // PTX:724 add.s64 %rd149, %rd33, %rd148
  asm("add.s64 %0, %1, %2;" : "=l"(rd149) : "l"(rd33), "l"(rd148));
  // PTX:725 st.global.u32 [%rd149], %r203
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd149) + (0))))) = (unsigned)(r203);
  // PTX:726 st.global.u32 [%rd149+4], %r204
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd149) + (4))))) = (unsigned)(r204);
  // PTX:727 shl.b64 %rd150, %rd159, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd150) : "l"(rd159));
  // PTX:728 add.s64 %rd151, %rd32, %rd150
  asm("add.s64 %0, %1, %2;" : "=l"(rd151) : "l"(rd32), "l"(rd150));
  // PTX:729 sqrt.rn.f32 %f142, %f150
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f142) : "f"(f150));
  // PTX:730 st.global.f32 [%rd151], %f142
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd151) + (0))))) = (float)(f142);
  // PTX:731 add.s64 %rd152, %rd31, %rd150
  asm("add.s64 %0, %1, %2;" : "=l"(rd152) : "l"(rd31), "l"(rd150));
  // PTX:732 st.global.f32 [%rd152], %f142
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd152) + (0))))) = (float)(f142);
  // PTX:733 add.s64 %rd153, %rd2, %rd150
  asm("add.s64 %0, %1, %2;" : "=l"(rd153) : "l"(rd2), "l"(rd150));
  // PTX:734 mov.u32 %r205, 1
  asm("mov.u32 %0, 1;" : "=r"(r205) : );
  // PTX:735 st.global.u32 [%rd153], %r205
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd153) + (0))))) = (unsigned)(r205);
  // PTX:737 $L__BB6_76:
L_BB6_76:;
  // PTX:738 mov.b64 %rd160, _ZN7synreal15granular_kernel10form_bondsENS_5ModelENS0_4ViewEPKiS4_PiPN3glm3vecILi2EiLNS6_9qualifierE0EEEPfSB_S5__param_0
  rd160 = (unsigned long long)(uintptr_t)&param0;
  // PTX:739 ld.param.u32 %r207, [%rd160+340]
  r207 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)(rd160) + (340))));
  // PTX:740 add.s32 %r213, %r213, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r213) : "r"(r213));
  // PTX:741 setp.lt.u32 %p80, %r213, %r207
  p80 = (((unsigned)(r213)) < ((unsigned)(r207)));
  // PTX:742 @%p80 bra $L__BB6_29
  if (p80) { goto L_BB6_29; }
  // PTX:744 $L__BB6_77:
L_BB6_77:;
  // PTX:745 ret
  return;
}
