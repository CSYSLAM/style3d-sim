// 机械还原自 PTX：synreal::kernel::add_affine_body_so3_augmented_lagrangian_preconditioner(glm::vec<4, int, (glm::qualifier)0> const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 121be9f5416a91f2fc2d2922fdcd3a83d76a0a38f42f525225c0729b641cce21
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__add_affine_body_so3_augmented_lagrangian_preconditioner(unsigned long long param0, unsigned long long param1, unsigned long long param2, float param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7) {
  int p0, p1, p2;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62;
  // PTX:24 ld.param.u64 %rd8, [_ZN7synreal6kernel55add_affine_body_so3_augmented_lagrangian_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEEfPSA_mmm_param_0]
  rd8 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:25 ld.param.u64 %rd9, [_ZN7synreal6kernel55add_affine_body_so3_augmented_lagrangian_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEEfPSA_mmm_param_1]
  rd9 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:26 ld.param.u64 %rd10, [_ZN7synreal6kernel55add_affine_body_so3_augmented_lagrangian_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEEfPSA_mmm_param_2]
  rd10 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:27 ld.param.f32 %f1, [_ZN7synreal6kernel55add_affine_body_so3_augmented_lagrangian_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEEfPSA_mmm_param_3]
  f1 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param3 + (0))));
  // PTX:28 ld.param.u64 %rd11, [_ZN7synreal6kernel55add_affine_body_so3_augmented_lagrangian_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEEfPSA_mmm_param_4]
  rd11 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:29 ld.param.u64 %rd14, [_ZN7synreal6kernel55add_affine_body_so3_augmented_lagrangian_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEEfPSA_mmm_param_5]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:30 ld.param.u64 %rd12, [_ZN7synreal6kernel55add_affine_body_so3_augmented_lagrangian_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEEfPSA_mmm_param_6]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:31 ld.param.u64 %rd13, [_ZN7synreal6kernel55add_affine_body_so3_augmented_lagrangian_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKfPKNS1_3matILi3ELi3EfLS3_0EEEfPSA_mmm_param_7]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:32 mov.u32 %r1, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r1) : "r"(blockIdx.x));
  // PTX:33 mov.u32 %r2, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockDim.x));
  // PTX:34 mul.wide.u32 %rd15, %r1, %r2
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd15) : "r"(r1), "r"(r2));
  // PTX:35 mov.u32 %r3, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(threadIdx.x));
  // PTX:36 cvt.u64.u32 %rd16, %r3
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd16) : "r"(r3));
  // PTX:37 add.s64 %rd1, %rd15, %rd16
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd15), "l"(rd16));
  // PTX:38 setp.ge.u64 %p1, %rd1, %rd14
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd14)));
  // PTX:39 @%p1 bra $L__BB61_5
  if (p1) { goto L_BB61_5; }
  // PTX:41 or.b64 %rd17, %rd1, %rd12
  asm("or.b64 %0, %1, %2;" : "=l"(rd17) : "l"(rd1), "l"(rd12));
  // PTX:42 and.b64 %rd18, %rd17, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd18) : "l"(rd17));
  // PTX:43 setp.eq.s64 %p2, %rd18, 0
  p2 = (((long long)(rd18)) == ((long long)(0)));
  // PTX:44 @%p2 bra $L__BB61_3
  if (p2) { goto L_BB61_3; }
  // PTX:46 div.u64 %rd61, %rd1, %rd12
  asm("div.u64 %0, %1, %2;" : "=l"(rd61) : "l"(rd1), "l"(rd12));
  // PTX:47 mul.lo.s64 %rd19, %rd61, %rd12
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd61), "l"(rd12));
  // PTX:48 sub.s64 %rd62, %rd1, %rd19
  asm("sub.s64 %0, %1, %2;" : "=l"(rd62) : "l"(rd1), "l"(rd19));
  // PTX:49 bra.uni $L__BB61_4
  goto L_BB61_4;
  // PTX:51 $L__BB61_3:
L_BB61_3:;
  // PTX:52 cvt.u32.u64 %r4, %rd12
  asm("cvt.u32.u64 %0, %1;" : "=r"(r4) : "l"(rd12));
  // PTX:53 cvt.u32.u64 %r5, %rd1
  asm("cvt.u32.u64 %0, %1;" : "=r"(r5) : "l"(rd1));
  // PTX:54 div.u32 %r6, %r5, %r4
  asm("div.u32 %0, %1, %2;" : "=r"(r6) : "r"(r5), "r"(r4));
  // PTX:55 mul.lo.s32 %r7, %r6, %r4
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r7) : "r"(r6), "r"(r4));
  // PTX:56 sub.s32 %r8, %r5, %r7
  asm("sub.s32 %0, %1, %2;" : "=r"(r8) : "r"(r5), "r"(r7));
  // PTX:57 cvt.u64.u32 %rd61, %r6
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd61) : "r"(r6));
  // PTX:58 cvt.u64.u32 %rd62, %r8
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd62) : "r"(r8));
  // PTX:60 $L__BB61_4:
L_BB61_4:;
  // PTX:61 cvta.to.global.u64 %rd20, %rd11
  rd20 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd11));
  // PTX:62 mul.lo.s64 %rd21, %rd61, %rd13
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd21) : "l"(rd61), "l"(rd13));
  // PTX:63 cvt.u32.u64 %r9, %rd21
  asm("cvt.u32.u64 %0, %1;" : "=r"(r9) : "l"(rd21));
  // PTX:64 cvta.to.global.u64 %rd22, %rd8
  rd22 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd8));
  // PTX:65 shl.b64 %rd23, %rd62, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd23) : "l"(rd62));
  // PTX:66 add.s64 %rd24, %rd22, %rd23
  asm("add.s64 %0, %1, %2;" : "=l"(rd24) : "l"(rd22), "l"(rd23));
  // PTX:67 ld.global.u32 %r10, [%rd24+4]
  r10 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (4)))));
  // PTX:68 add.s32 %r11, %r10, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r11) : "r"(r10), "r"(r9));
  // PTX:69 ld.global.u32 %r12, [%rd24+8]
  r12 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (8)))));
  // PTX:70 add.s32 %r13, %r12, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r13) : "r"(r12), "r"(r9));
  // PTX:71 ld.global.u32 %r14, [%rd24+12]
  r14 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (12)))));
  // PTX:72 add.s32 %r15, %r14, %r9
  asm("add.s32 %0, %1, %2;" : "=r"(r15) : "r"(r14), "r"(r9));
  // PTX:73 cvta.to.global.u64 %rd25, %rd9
  rd25 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd9));
  // PTX:74 shl.b64 %rd26, %rd62, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd26) : "l"(rd62));
  // PTX:75 add.s64 %rd27, %rd25, %rd26
  asm("add.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd25), "l"(rd26));
  // PTX:76 ld.global.f32 %f2, [%rd27]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))));
  // PTX:77 mul.f32 %f3, %f2, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f3) : "f"(f2), "f"(f1));
  // PTX:78 cvta.to.global.u64 %rd28, %rd10
  rd28 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd10));
  // PTX:79 mul.lo.s64 %rd29, %rd1, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd29) : "l"(rd1));
  // PTX:80 add.s64 %rd30, %rd28, %rd29
  asm("add.s64 %0, %1, %2;" : "=l"(rd30) : "l"(rd28), "l"(rd29));
  // PTX:81 ld.global.f32 %f4, [%rd30+4]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (4)))));
  // PTX:82 mul.f32 %f5, %f4, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f5) : "f"(f4));
  // PTX:83 ld.global.f32 %f6, [%rd30+16]
  f6 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (16)))));
  // PTX:84 mul.f32 %f7, %f6, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f7) : "f"(f6));
  // PTX:85 ld.global.f32 %f8, [%rd30+28]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (28)))));
  // PTX:86 mul.f32 %f9, %f8, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f9) : "f"(f8));
  // PTX:87 ld.global.f32 %f10, [%rd30]
  f10 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0)))));
  // PTX:88 add.f32 %f11, %f10, %f5
  asm("add.f32 %0, %1, %2;" : "=f"(f11) : "f"(f10), "f"(f5));
  // PTX:89 ld.global.f32 %f12, [%rd30+12]
  f12 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (12)))));
  // PTX:90 add.f32 %f13, %f12, %f7
  asm("add.f32 %0, %1, %2;" : "=f"(f13) : "f"(f12), "f"(f7));
  // PTX:91 ld.global.f32 %f14, [%rd30+24]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (24)))));
  // PTX:92 add.f32 %f15, %f14, %f9
  asm("add.f32 %0, %1, %2;" : "=f"(f15) : "f"(f14), "f"(f9));
  // PTX:93 ld.global.f32 %f16, [%rd30+8]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (8)))));
  // PTX:94 ld.global.f32 %f17, [%rd30+20]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (20)))));
  // PTX:95 ld.global.f32 %f18, [%rd30+32]
  f18 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (32)))));
  // PTX:96 fma.rn.f32 %f19, %f16, 0f00000000, %f11
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f19) : "f"(f16), "f"(f11));
  // PTX:97 fma.rn.f32 %f20, %f17, 0f00000000, %f13
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f20) : "f"(f17), "f"(f13));
  // PTX:98 fma.rn.f32 %f21, %f18, 0f00000000, %f15
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f21) : "f"(f18), "f"(f15));
  // PTX:99 fma.rn.f32 %f22, %f10, 0f00000000, %f5
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f22) : "f"(f10), "f"(f5));
  // PTX:100 fma.rn.f32 %f23, %f16, 0f00000000, %f22
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f23) : "f"(f16), "f"(f22));
  // PTX:101 add.f32 %f24, %f19, %f19
  asm("add.f32 %0, %1, %2;" : "=f"(f24) : "f"(f19), "f"(f19));
  // PTX:102 add.f32 %f25, %f20, %f23
  asm("add.f32 %0, %1, %2;" : "=f"(f25) : "f"(f20), "f"(f23));
  // PTX:103 add.f32 %f26, %f21, %f23
  asm("add.f32 %0, %1, %2;" : "=f"(f26) : "f"(f21), "f"(f23));
  // PTX:104 mul.f32 %f27, %f24, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f27) : "f"(f24));
  // PTX:105 mul.f32 %f28, %f25, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f28) : "f"(f25));
  // PTX:106 mul.f32 %f29, %f26, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f29) : "f"(f26));
  // PTX:107 mul.f32 %f30, %f12, %f28
  asm("mul.f32 %0, %1, %2;" : "=f"(f30) : "f"(f12), "f"(f28));
  // PTX:108 mul.f32 %f31, %f6, %f28
  asm("mul.f32 %0, %1, %2;" : "=f"(f31) : "f"(f6), "f"(f28));
  // PTX:109 mul.f32 %f32, %f17, %f28
  asm("mul.f32 %0, %1, %2;" : "=f"(f32) : "f"(f17), "f"(f28));
  // PTX:110 fma.rn.f32 %f33, %f10, %f27, %f30
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f33) : "f"(f10), "f"(f27), "f"(f30));
  // PTX:111 fma.rn.f32 %f34, %f4, %f27, %f31
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f34) : "f"(f4), "f"(f27), "f"(f31));
  // PTX:112 fma.rn.f32 %f35, %f16, %f27, %f32
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f35) : "f"(f16), "f"(f27), "f"(f32));
  // PTX:113 fma.rn.f32 %f36, %f14, %f29, %f33
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f36) : "f"(f14), "f"(f29), "f"(f33));
  // PTX:114 fma.rn.f32 %f37, %f8, %f29, %f34
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f37) : "f"(f8), "f"(f29), "f"(f34));
  // PTX:115 fma.rn.f32 %f38, %f18, %f29, %f35
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f38) : "f"(f18), "f"(f29), "f"(f35));
  // PTX:116 mul.f32 %f39, %f3, %f36
  asm("mul.f32 %0, %1, %2;" : "=f"(f39) : "f"(f3), "f"(f36));
  // PTX:117 mul.f32 %f40, %f3, %f37
  asm("mul.f32 %0, %1, %2;" : "=f"(f40) : "f"(f3), "f"(f37));
  // PTX:118 mul.f32 %f41, %f3, %f38
  asm("mul.f32 %0, %1, %2;" : "=f"(f41) : "f"(f3), "f"(f38));
  // PTX:119 fma.rn.f32 %f42, %f10, 0f00000000, %f4
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f42) : "f"(f10), "f"(f4));
  // PTX:120 fma.rn.f32 %f43, %f12, 0f00000000, %f6
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f43) : "f"(f12), "f"(f6));
  // PTX:121 fma.rn.f32 %f44, %f14, 0f00000000, %f8
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f44) : "f"(f14), "f"(f8));
  // PTX:122 fma.rn.f32 %f45, %f16, 0f00000000, %f42
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f45) : "f"(f16), "f"(f42));
  // PTX:123 fma.rn.f32 %f46, %f17, 0f00000000, %f43
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f46) : "f"(f17), "f"(f43));
  // PTX:124 fma.rn.f32 %f47, %f18, 0f00000000, %f44
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f47) : "f"(f18), "f"(f44));
  // PTX:125 add.f32 %f48, %f45, %f45
  asm("add.f32 %0, %1, %2;" : "=f"(f48) : "f"(f45), "f"(f45));
  // PTX:126 add.f32 %f49, %f46, %f23
  asm("add.f32 %0, %1, %2;" : "=f"(f49) : "f"(f46), "f"(f23));
  // PTX:127 add.f32 %f50, %f47, %f23
  asm("add.f32 %0, %1, %2;" : "=f"(f50) : "f"(f47), "f"(f23));
  // PTX:128 mul.f32 %f51, %f48, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f51) : "f"(f48));
  // PTX:129 mul.f32 %f52, %f49, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f52) : "f"(f49));
  // PTX:130 mul.f32 %f53, %f50, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f53) : "f"(f50));
  // PTX:131 mul.f32 %f54, %f12, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f54) : "f"(f12), "f"(f52));
  // PTX:132 mul.f32 %f55, %f6, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f55) : "f"(f6), "f"(f52));
  // PTX:133 mul.f32 %f56, %f17, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f56) : "f"(f17), "f"(f52));
  // PTX:134 fma.rn.f32 %f57, %f10, %f51, %f54
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f57) : "f"(f10), "f"(f51), "f"(f54));
  // PTX:135 fma.rn.f32 %f58, %f4, %f51, %f55
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f58) : "f"(f4), "f"(f51), "f"(f55));
  // PTX:136 fma.rn.f32 %f59, %f16, %f51, %f56
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f59) : "f"(f16), "f"(f51), "f"(f56));
  // PTX:137 fma.rn.f32 %f60, %f14, %f53, %f57
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f60) : "f"(f14), "f"(f53), "f"(f57));
  // PTX:138 fma.rn.f32 %f61, %f8, %f53, %f58
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f61) : "f"(f8), "f"(f53), "f"(f58));
  // PTX:139 fma.rn.f32 %f62, %f18, %f53, %f59
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f62) : "f"(f18), "f"(f53), "f"(f59));
  // PTX:140 mul.f32 %f63, %f3, %f60
  asm("mul.f32 %0, %1, %2;" : "=f"(f63) : "f"(f3), "f"(f60));
  // PTX:141 mul.f32 %f64, %f3, %f61
  asm("mul.f32 %0, %1, %2;" : "=f"(f64) : "f"(f3), "f"(f61));
  // PTX:142 mul.f32 %f65, %f3, %f62
  asm("mul.f32 %0, %1, %2;" : "=f"(f65) : "f"(f3), "f"(f62));
  // PTX:143 fma.rn.f32 %f66, %f12, 0f00000000, %f7
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f66) : "f"(f12), "f"(f7));
  // PTX:144 fma.rn.f32 %f67, %f14, 0f00000000, %f9
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f67) : "f"(f14), "f"(f9));
  // PTX:145 add.f32 %f68, %f22, %f16
  asm("add.f32 %0, %1, %2;" : "=f"(f68) : "f"(f22), "f"(f16));
  // PTX:146 add.f32 %f69, %f66, %f17
  asm("add.f32 %0, %1, %2;" : "=f"(f69) : "f"(f66), "f"(f17));
  // PTX:147 add.f32 %f70, %f67, %f18
  asm("add.f32 %0, %1, %2;" : "=f"(f70) : "f"(f67), "f"(f18));
  // PTX:148 add.f32 %f71, %f68, %f68
  asm("add.f32 %0, %1, %2;" : "=f"(f71) : "f"(f68), "f"(f68));
  // PTX:149 add.f32 %f72, %f69, %f23
  asm("add.f32 %0, %1, %2;" : "=f"(f72) : "f"(f69), "f"(f23));
  // PTX:150 add.f32 %f73, %f70, %f23
  asm("add.f32 %0, %1, %2;" : "=f"(f73) : "f"(f70), "f"(f23));
  // PTX:151 mul.f32 %f74, %f71, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f74) : "f"(f71));
  // PTX:152 mul.f32 %f75, %f72, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f75) : "f"(f72));
  // PTX:153 mul.f32 %f76, %f73, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f76) : "f"(f73));
  // PTX:154 mul.f32 %f77, %f12, %f75
  asm("mul.f32 %0, %1, %2;" : "=f"(f77) : "f"(f12), "f"(f75));
  // PTX:155 mul.f32 %f78, %f6, %f75
  asm("mul.f32 %0, %1, %2;" : "=f"(f78) : "f"(f6), "f"(f75));
  // PTX:156 mul.f32 %f79, %f17, %f75
  asm("mul.f32 %0, %1, %2;" : "=f"(f79) : "f"(f17), "f"(f75));
  // PTX:157 fma.rn.f32 %f80, %f10, %f74, %f77
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f80) : "f"(f10), "f"(f74), "f"(f77));
  // PTX:158 fma.rn.f32 %f81, %f4, %f74, %f78
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f81) : "f"(f4), "f"(f74), "f"(f78));
  // PTX:159 fma.rn.f32 %f82, %f16, %f74, %f79
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f82) : "f"(f16), "f"(f74), "f"(f79));
  // PTX:160 fma.rn.f32 %f83, %f14, %f76, %f80
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f83) : "f"(f14), "f"(f76), "f"(f80));
  // PTX:161 fma.rn.f32 %f84, %f8, %f76, %f81
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f84) : "f"(f8), "f"(f76), "f"(f81));
  // PTX:162 fma.rn.f32 %f85, %f18, %f76, %f82
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f85) : "f"(f18), "f"(f76), "f"(f82));
  // PTX:163 mul.f32 %f86, %f3, %f83
  asm("mul.f32 %0, %1, %2;" : "=f"(f86) : "f"(f3), "f"(f83));
  // PTX:164 mul.f32 %f87, %f3, %f84
  asm("mul.f32 %0, %1, %2;" : "=f"(f87) : "f"(f3), "f"(f84));
  // PTX:165 mul.f32 %f88, %f3, %f85
  asm("mul.f32 %0, %1, %2;" : "=f"(f88) : "f"(f3), "f"(f85));
  // PTX:166 mul.wide.s32 %rd31, %r11, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd31) : "r"(r11));
  // PTX:167 add.s64 %rd32, %rd20, %rd31
  asm("add.s64 %0, %1, %2;" : "=l"(rd32) : "l"(rd20), "l"(rd31));
  // PTX:168 red.global.add.f32 [%rd32], %f39
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (0)))), (float)(f39));
  // PTX:169 add.s64 %rd33, %rd32, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd33) : "l"(rd32));
  // PTX:170 red.global.add.f32 [%rd33], %f40
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (0)))), (float)(f40));
  // PTX:171 add.s64 %rd34, %rd32, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd34) : "l"(rd32));
  // PTX:172 red.global.add.f32 [%rd34], %f41
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (0)))), (float)(f41));
  // PTX:173 add.s64 %rd35, %rd32, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd35) : "l"(rd32));
  // PTX:174 red.global.add.f32 [%rd35], %f63
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (0)))), (float)(f63));
  // PTX:175 add.s64 %rd36, %rd32, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd36) : "l"(rd32));
  // PTX:176 red.global.add.f32 [%rd36], %f64
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (0)))), (float)(f64));
  // PTX:177 add.s64 %rd37, %rd32, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd37) : "l"(rd32));
  // PTX:178 red.global.add.f32 [%rd37], %f65
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (0)))), (float)(f65));
  // PTX:179 add.s64 %rd38, %rd32, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd38) : "l"(rd32));
  // PTX:180 red.global.add.f32 [%rd38], %f86
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (0)))), (float)(f86));
  // PTX:181 add.s64 %rd39, %rd32, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd39) : "l"(rd32));
  // PTX:182 red.global.add.f32 [%rd39], %f87
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (0)))), (float)(f87));
  // PTX:183 add.s64 %rd40, %rd32, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd40) : "l"(rd32));
  // PTX:184 red.global.add.f32 [%rd40], %f88
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (0)))), (float)(f88));
  // PTX:185 ld.global.f32 %f98, [%rd30+12]
  f98 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (12)))));
  // PTX:186 ld.global.f32 %f99, [%rd30+16]
  f99 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (16)))));
  // PTX:187 mul.f32 %f100, %f99, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f100) : "f"(f99));
  // PTX:188 fma.rn.f32 %f101, %f98, 0f00000000, %f100
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f101) : "f"(f98), "f"(f100));
  // PTX:189 ld.global.f32 %f102, [%rd30+20]
  f102 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (20)))));
  // PTX:190 fma.rn.f32 %f103, %f102, 0f00000000, %f101
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f103) : "f"(f102), "f"(f101));
  // PTX:191 ld.global.f32 %f104, [%rd30+4]
  f104 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (4)))));
  // PTX:192 mul.f32 %f105, %f104, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f105) : "f"(f104));
  // PTX:193 ld.global.f32 %f106, [%rd30+28]
  f106 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (28)))));
  // PTX:194 mul.f32 %f107, %f106, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f107) : "f"(f106));
  // PTX:195 ld.global.f32 %f108, [%rd30]
  f108 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0)))));
  // PTX:196 add.f32 %f109, %f108, %f105
  asm("add.f32 %0, %1, %2;" : "=f"(f109) : "f"(f108), "f"(f105));
  // PTX:197 fma.rn.f32 %f110, %f99, 0f00000000, %f98
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f110) : "f"(f99), "f"(f98));
  // PTX:198 ld.global.f32 %f111, [%rd30+24]
  f111 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (24)))));
  // PTX:199 add.f32 %f112, %f111, %f107
  asm("add.f32 %0, %1, %2;" : "=f"(f112) : "f"(f111), "f"(f107));
  // PTX:200 ld.global.f32 %f113, [%rd30+8]
  f113 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (8)))));
  // PTX:201 ld.global.f32 %f114, [%rd30+32]
  f114 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (32)))));
  // PTX:202 fma.rn.f32 %f115, %f113, 0f00000000, %f109
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f115) : "f"(f113), "f"(f109));
  // PTX:203 fma.rn.f32 %f116, %f102, 0f00000000, %f110
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f116) : "f"(f102), "f"(f110));
  // PTX:204 fma.rn.f32 %f117, %f114, 0f00000000, %f112
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f117) : "f"(f114), "f"(f112));
  // PTX:205 add.f32 %f118, %f103, %f115
  asm("add.f32 %0, %1, %2;" : "=f"(f118) : "f"(f103), "f"(f115));
  // PTX:206 add.f32 %f119, %f116, %f116
  asm("add.f32 %0, %1, %2;" : "=f"(f119) : "f"(f116), "f"(f116));
  // PTX:207 add.f32 %f120, %f117, %f103
  asm("add.f32 %0, %1, %2;" : "=f"(f120) : "f"(f117), "f"(f103));
  // PTX:208 mul.f32 %f121, %f118, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f121) : "f"(f118));
  // PTX:209 mul.f32 %f122, %f119, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f122) : "f"(f119));
  // PTX:210 mul.f32 %f123, %f120, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f123) : "f"(f120));
  // PTX:211 mul.f32 %f124, %f98, %f122
  asm("mul.f32 %0, %1, %2;" : "=f"(f124) : "f"(f98), "f"(f122));
  // PTX:212 mul.f32 %f125, %f99, %f122
  asm("mul.f32 %0, %1, %2;" : "=f"(f125) : "f"(f99), "f"(f122));
  // PTX:213 mul.f32 %f126, %f102, %f122
  asm("mul.f32 %0, %1, %2;" : "=f"(f126) : "f"(f102), "f"(f122));
  // PTX:214 fma.rn.f32 %f127, %f108, %f121, %f124
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f127) : "f"(f108), "f"(f121), "f"(f124));
  // PTX:215 fma.rn.f32 %f128, %f104, %f121, %f125
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f128) : "f"(f104), "f"(f121), "f"(f125));
  // PTX:216 fma.rn.f32 %f129, %f113, %f121, %f126
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f129) : "f"(f113), "f"(f121), "f"(f126));
  // PTX:217 fma.rn.f32 %f130, %f111, %f123, %f127
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f130) : "f"(f111), "f"(f123), "f"(f127));
  // PTX:218 fma.rn.f32 %f131, %f106, %f123, %f128
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f131) : "f"(f106), "f"(f123), "f"(f128));
  // PTX:219 fma.rn.f32 %f132, %f114, %f123, %f129
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f132) : "f"(f114), "f"(f123), "f"(f129));
  // PTX:220 mul.f32 %f133, %f3, %f130
  asm("mul.f32 %0, %1, %2;" : "=f"(f133) : "f"(f3), "f"(f130));
  // PTX:221 mul.f32 %f134, %f3, %f131
  asm("mul.f32 %0, %1, %2;" : "=f"(f134) : "f"(f3), "f"(f131));
  // PTX:222 mul.f32 %f135, %f3, %f132
  asm("mul.f32 %0, %1, %2;" : "=f"(f135) : "f"(f3), "f"(f132));
  // PTX:223 fma.rn.f32 %f136, %f108, 0f00000000, %f104
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f136) : "f"(f108), "f"(f104));
  // PTX:224 fma.rn.f32 %f137, %f98, 0f00000000, %f99
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f137) : "f"(f98), "f"(f99));
  // PTX:225 fma.rn.f32 %f138, %f111, 0f00000000, %f106
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f138) : "f"(f111), "f"(f106));
  // PTX:226 fma.rn.f32 %f139, %f113, 0f00000000, %f136
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f139) : "f"(f113), "f"(f136));
  // PTX:227 fma.rn.f32 %f140, %f102, 0f00000000, %f137
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f140) : "f"(f102), "f"(f137));
  // PTX:228 fma.rn.f32 %f141, %f114, 0f00000000, %f138
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f141) : "f"(f114), "f"(f138));
  // PTX:229 add.f32 %f142, %f103, %f139
  asm("add.f32 %0, %1, %2;" : "=f"(f142) : "f"(f103), "f"(f139));
  // PTX:230 add.f32 %f143, %f140, %f140
  asm("add.f32 %0, %1, %2;" : "=f"(f143) : "f"(f140), "f"(f140));
  // PTX:231 add.f32 %f144, %f141, %f103
  asm("add.f32 %0, %1, %2;" : "=f"(f144) : "f"(f141), "f"(f103));
  // PTX:232 mul.f32 %f145, %f142, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f145) : "f"(f142));
  // PTX:233 mul.f32 %f146, %f143, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f146) : "f"(f143));
  // PTX:234 mul.f32 %f147, %f144, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f147) : "f"(f144));
  // PTX:235 mul.f32 %f148, %f98, %f146
  asm("mul.f32 %0, %1, %2;" : "=f"(f148) : "f"(f98), "f"(f146));
  // PTX:236 mul.f32 %f149, %f99, %f146
  asm("mul.f32 %0, %1, %2;" : "=f"(f149) : "f"(f99), "f"(f146));
  // PTX:237 mul.f32 %f150, %f102, %f146
  asm("mul.f32 %0, %1, %2;" : "=f"(f150) : "f"(f102), "f"(f146));
  // PTX:238 fma.rn.f32 %f151, %f108, %f145, %f148
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f151) : "f"(f108), "f"(f145), "f"(f148));
  // PTX:239 fma.rn.f32 %f152, %f104, %f145, %f149
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f152) : "f"(f104), "f"(f145), "f"(f149));
  // PTX:240 fma.rn.f32 %f153, %f113, %f145, %f150
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f153) : "f"(f113), "f"(f145), "f"(f150));
  // PTX:241 fma.rn.f32 %f154, %f111, %f147, %f151
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f154) : "f"(f111), "f"(f147), "f"(f151));
  // PTX:242 fma.rn.f32 %f155, %f106, %f147, %f152
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f155) : "f"(f106), "f"(f147), "f"(f152));
  // PTX:243 fma.rn.f32 %f156, %f114, %f147, %f153
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f156) : "f"(f114), "f"(f147), "f"(f153));
  // PTX:244 mul.f32 %f157, %f3, %f154
  asm("mul.f32 %0, %1, %2;" : "=f"(f157) : "f"(f3), "f"(f154));
  // PTX:245 mul.f32 %f158, %f3, %f155
  asm("mul.f32 %0, %1, %2;" : "=f"(f158) : "f"(f3), "f"(f155));
  // PTX:246 mul.f32 %f159, %f3, %f156
  asm("mul.f32 %0, %1, %2;" : "=f"(f159) : "f"(f3), "f"(f156));
  // PTX:247 fma.rn.f32 %f160, %f108, 0f00000000, %f105
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f160) : "f"(f108), "f"(f105));
  // PTX:248 fma.rn.f32 %f161, %f111, 0f00000000, %f107
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f161) : "f"(f111), "f"(f107));
  // PTX:249 add.f32 %f162, %f160, %f113
  asm("add.f32 %0, %1, %2;" : "=f"(f162) : "f"(f160), "f"(f113));
  // PTX:250 add.f32 %f163, %f101, %f102
  asm("add.f32 %0, %1, %2;" : "=f"(f163) : "f"(f101), "f"(f102));
  // PTX:251 add.f32 %f164, %f161, %f114
  asm("add.f32 %0, %1, %2;" : "=f"(f164) : "f"(f161), "f"(f114));
  // PTX:252 add.f32 %f165, %f103, %f162
  asm("add.f32 %0, %1, %2;" : "=f"(f165) : "f"(f103), "f"(f162));
  // PTX:253 add.f32 %f166, %f163, %f163
  asm("add.f32 %0, %1, %2;" : "=f"(f166) : "f"(f163), "f"(f163));
  // PTX:254 add.f32 %f167, %f164, %f103
  asm("add.f32 %0, %1, %2;" : "=f"(f167) : "f"(f164), "f"(f103));
  // PTX:255 mul.f32 %f168, %f165, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f168) : "f"(f165));
  // PTX:256 mul.f32 %f169, %f166, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f169) : "f"(f166));
  // PTX:257 mul.f32 %f170, %f167, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f170) : "f"(f167));
  // PTX:258 mul.f32 %f171, %f98, %f169
  asm("mul.f32 %0, %1, %2;" : "=f"(f171) : "f"(f98), "f"(f169));
  // PTX:259 mul.f32 %f172, %f99, %f169
  asm("mul.f32 %0, %1, %2;" : "=f"(f172) : "f"(f99), "f"(f169));
  // PTX:260 mul.f32 %f173, %f102, %f169
  asm("mul.f32 %0, %1, %2;" : "=f"(f173) : "f"(f102), "f"(f169));
  // PTX:261 fma.rn.f32 %f174, %f108, %f168, %f171
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f174) : "f"(f108), "f"(f168), "f"(f171));
  // PTX:262 fma.rn.f32 %f175, %f104, %f168, %f172
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f175) : "f"(f104), "f"(f168), "f"(f172));
  // PTX:263 fma.rn.f32 %f176, %f113, %f168, %f173
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f176) : "f"(f113), "f"(f168), "f"(f173));
  // PTX:264 fma.rn.f32 %f177, %f111, %f170, %f174
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f177) : "f"(f111), "f"(f170), "f"(f174));
  // PTX:265 fma.rn.f32 %f178, %f106, %f170, %f175
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f178) : "f"(f106), "f"(f170), "f"(f175));
  // PTX:266 fma.rn.f32 %f179, %f114, %f170, %f176
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f179) : "f"(f114), "f"(f170), "f"(f176));
  // PTX:267 mul.f32 %f180, %f3, %f177
  asm("mul.f32 %0, %1, %2;" : "=f"(f180) : "f"(f3), "f"(f177));
  // PTX:268 mul.f32 %f181, %f3, %f178
  asm("mul.f32 %0, %1, %2;" : "=f"(f181) : "f"(f3), "f"(f178));
  // PTX:269 mul.f32 %f182, %f3, %f179
  asm("mul.f32 %0, %1, %2;" : "=f"(f182) : "f"(f3), "f"(f179));
  // PTX:270 mul.wide.s32 %rd41, %r13, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd41) : "r"(r13));
  // PTX:271 add.s64 %rd42, %rd20, %rd41
  asm("add.s64 %0, %1, %2;" : "=l"(rd42) : "l"(rd20), "l"(rd41));
  // PTX:272 red.global.add.f32 [%rd42], %f133
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (0)))), (float)(f133));
  // PTX:273 add.s64 %rd43, %rd42, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd43) : "l"(rd42));
  // PTX:274 red.global.add.f32 [%rd43], %f134
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (0)))), (float)(f134));
  // PTX:275 add.s64 %rd44, %rd42, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd44) : "l"(rd42));
  // PTX:276 red.global.add.f32 [%rd44], %f135
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))), (float)(f135));
  // PTX:277 add.s64 %rd45, %rd42, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd45) : "l"(rd42));
  // PTX:278 red.global.add.f32 [%rd45], %f157
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))), (float)(f157));
  // PTX:279 add.s64 %rd46, %rd42, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd46) : "l"(rd42));
  // PTX:280 red.global.add.f32 [%rd46], %f158
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (0)))), (float)(f158));
  // PTX:281 add.s64 %rd47, %rd42, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd47) : "l"(rd42));
  // PTX:282 red.global.add.f32 [%rd47], %f159
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))), (float)(f159));
  // PTX:283 add.s64 %rd48, %rd42, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd48) : "l"(rd42));
  // PTX:284 red.global.add.f32 [%rd48], %f180
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))), (float)(f180));
  // PTX:285 add.s64 %rd49, %rd42, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd49) : "l"(rd42));
  // PTX:286 red.global.add.f32 [%rd49], %f181
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))), (float)(f181));
  // PTX:287 add.s64 %rd50, %rd42, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd50) : "l"(rd42));
  // PTX:288 red.global.add.f32 [%rd50], %f182
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (0)))), (float)(f182));
  // PTX:289 ld.global.f32 %f192, [%rd30+24]
  f192 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (24)))));
  // PTX:290 ld.global.f32 %f193, [%rd30+28]
  f193 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (28)))));
  // PTX:291 mul.f32 %f194, %f193, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f194) : "f"(f193));
  // PTX:292 fma.rn.f32 %f195, %f192, 0f00000000, %f194
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f195) : "f"(f192), "f"(f194));
  // PTX:293 ld.global.f32 %f196, [%rd30+32]
  f196 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (32)))));
  // PTX:294 fma.rn.f32 %f197, %f196, 0f00000000, %f195
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f197) : "f"(f196), "f"(f195));
  // PTX:295 ld.global.f32 %f198, [%rd30+4]
  f198 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (4)))));
  // PTX:296 mul.f32 %f199, %f198, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f199) : "f"(f198));
  // PTX:297 ld.global.f32 %f200, [%rd30+16]
  f200 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (16)))));
  // PTX:298 mul.f32 %f201, %f200, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f201) : "f"(f200));
  // PTX:299 ld.global.f32 %f202, [%rd30]
  f202 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0)))));
  // PTX:300 add.f32 %f203, %f202, %f199
  asm("add.f32 %0, %1, %2;" : "=f"(f203) : "f"(f202), "f"(f199));
  // PTX:301 ld.global.f32 %f204, [%rd30+12]
  f204 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (12)))));
  // PTX:302 add.f32 %f205, %f204, %f201
  asm("add.f32 %0, %1, %2;" : "=f"(f205) : "f"(f204), "f"(f201));
  // PTX:303 fma.rn.f32 %f206, %f193, 0f00000000, %f192
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f206) : "f"(f193), "f"(f192));
  // PTX:304 ld.global.f32 %f207, [%rd30+8]
  f207 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (8)))));
  // PTX:305 ld.global.f32 %f208, [%rd30+20]
  f208 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (20)))));
  // PTX:306 fma.rn.f32 %f209, %f207, 0f00000000, %f203
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f209) : "f"(f207), "f"(f203));
  // PTX:307 fma.rn.f32 %f210, %f208, 0f00000000, %f205
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f210) : "f"(f208), "f"(f205));
  // PTX:308 fma.rn.f32 %f211, %f196, 0f00000000, %f206
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f211) : "f"(f196), "f"(f206));
  // PTX:309 add.f32 %f212, %f197, %f209
  asm("add.f32 %0, %1, %2;" : "=f"(f212) : "f"(f197), "f"(f209));
  // PTX:310 add.f32 %f213, %f197, %f210
  asm("add.f32 %0, %1, %2;" : "=f"(f213) : "f"(f197), "f"(f210));
  // PTX:311 add.f32 %f214, %f211, %f211
  asm("add.f32 %0, %1, %2;" : "=f"(f214) : "f"(f211), "f"(f211));
  // PTX:312 mul.f32 %f215, %f212, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f215) : "f"(f212));
  // PTX:313 mul.f32 %f216, %f213, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f216) : "f"(f213));
  // PTX:314 mul.f32 %f217, %f214, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f217) : "f"(f214));
  // PTX:315 mul.f32 %f218, %f204, %f216
  asm("mul.f32 %0, %1, %2;" : "=f"(f218) : "f"(f204), "f"(f216));
  // PTX:316 mul.f32 %f219, %f200, %f216
  asm("mul.f32 %0, %1, %2;" : "=f"(f219) : "f"(f200), "f"(f216));
  // PTX:317 mul.f32 %f220, %f208, %f216
  asm("mul.f32 %0, %1, %2;" : "=f"(f220) : "f"(f208), "f"(f216));
  // PTX:318 fma.rn.f32 %f221, %f202, %f215, %f218
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f221) : "f"(f202), "f"(f215), "f"(f218));
  // PTX:319 fma.rn.f32 %f222, %f198, %f215, %f219
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f222) : "f"(f198), "f"(f215), "f"(f219));
  // PTX:320 fma.rn.f32 %f223, %f207, %f215, %f220
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f223) : "f"(f207), "f"(f215), "f"(f220));
  // PTX:321 fma.rn.f32 %f224, %f192, %f217, %f221
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f224) : "f"(f192), "f"(f217), "f"(f221));
  // PTX:322 fma.rn.f32 %f225, %f193, %f217, %f222
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f225) : "f"(f193), "f"(f217), "f"(f222));
  // PTX:323 fma.rn.f32 %f226, %f196, %f217, %f223
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f226) : "f"(f196), "f"(f217), "f"(f223));
  // PTX:324 mul.f32 %f227, %f3, %f224
  asm("mul.f32 %0, %1, %2;" : "=f"(f227) : "f"(f3), "f"(f224));
  // PTX:325 mul.f32 %f228, %f3, %f225
  asm("mul.f32 %0, %1, %2;" : "=f"(f228) : "f"(f3), "f"(f225));
  // PTX:326 mul.f32 %f229, %f3, %f226
  asm("mul.f32 %0, %1, %2;" : "=f"(f229) : "f"(f3), "f"(f226));
  // PTX:327 fma.rn.f32 %f230, %f202, 0f00000000, %f198
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f230) : "f"(f202), "f"(f198));
  // PTX:328 fma.rn.f32 %f231, %f204, 0f00000000, %f200
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f231) : "f"(f204), "f"(f200));
  // PTX:329 fma.rn.f32 %f232, %f192, 0f00000000, %f193
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f232) : "f"(f192), "f"(f193));
  // PTX:330 fma.rn.f32 %f233, %f207, 0f00000000, %f230
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f233) : "f"(f207), "f"(f230));
  // PTX:331 fma.rn.f32 %f234, %f208, 0f00000000, %f231
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f234) : "f"(f208), "f"(f231));
  // PTX:332 fma.rn.f32 %f235, %f196, 0f00000000, %f232
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f235) : "f"(f196), "f"(f232));
  // PTX:333 add.f32 %f236, %f197, %f233
  asm("add.f32 %0, %1, %2;" : "=f"(f236) : "f"(f197), "f"(f233));
  // PTX:334 add.f32 %f237, %f197, %f234
  asm("add.f32 %0, %1, %2;" : "=f"(f237) : "f"(f197), "f"(f234));
  // PTX:335 add.f32 %f238, %f235, %f235
  asm("add.f32 %0, %1, %2;" : "=f"(f238) : "f"(f235), "f"(f235));
  // PTX:336 mul.f32 %f239, %f236, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f239) : "f"(f236));
  // PTX:337 mul.f32 %f240, %f237, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f240) : "f"(f237));
  // PTX:338 mul.f32 %f241, %f238, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f241) : "f"(f238));
  // PTX:339 mul.f32 %f242, %f204, %f240
  asm("mul.f32 %0, %1, %2;" : "=f"(f242) : "f"(f204), "f"(f240));
  // PTX:340 mul.f32 %f243, %f200, %f240
  asm("mul.f32 %0, %1, %2;" : "=f"(f243) : "f"(f200), "f"(f240));
  // PTX:341 mul.f32 %f244, %f208, %f240
  asm("mul.f32 %0, %1, %2;" : "=f"(f244) : "f"(f208), "f"(f240));
  // PTX:342 fma.rn.f32 %f245, %f202, %f239, %f242
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f245) : "f"(f202), "f"(f239), "f"(f242));
  // PTX:343 fma.rn.f32 %f246, %f198, %f239, %f243
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f246) : "f"(f198), "f"(f239), "f"(f243));
  // PTX:344 fma.rn.f32 %f247, %f207, %f239, %f244
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f247) : "f"(f207), "f"(f239), "f"(f244));
  // PTX:345 fma.rn.f32 %f248, %f192, %f241, %f245
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f248) : "f"(f192), "f"(f241), "f"(f245));
  // PTX:346 fma.rn.f32 %f249, %f193, %f241, %f246
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f249) : "f"(f193), "f"(f241), "f"(f246));
  // PTX:347 fma.rn.f32 %f250, %f196, %f241, %f247
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f250) : "f"(f196), "f"(f241), "f"(f247));
  // PTX:348 mul.f32 %f251, %f3, %f248
  asm("mul.f32 %0, %1, %2;" : "=f"(f251) : "f"(f3), "f"(f248));
  // PTX:349 mul.f32 %f252, %f3, %f249
  asm("mul.f32 %0, %1, %2;" : "=f"(f252) : "f"(f3), "f"(f249));
  // PTX:350 mul.f32 %f253, %f3, %f250
  asm("mul.f32 %0, %1, %2;" : "=f"(f253) : "f"(f3), "f"(f250));
  // PTX:351 fma.rn.f32 %f254, %f202, 0f00000000, %f199
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f254) : "f"(f202), "f"(f199));
  // PTX:352 fma.rn.f32 %f255, %f204, 0f00000000, %f201
  asm("fma.rn.f32 %0, %1, 0f00000000, %2;" : "=f"(f255) : "f"(f204), "f"(f201));
  // PTX:353 add.f32 %f256, %f254, %f207
  asm("add.f32 %0, %1, %2;" : "=f"(f256) : "f"(f254), "f"(f207));
  // PTX:354 add.f32 %f257, %f255, %f208
  asm("add.f32 %0, %1, %2;" : "=f"(f257) : "f"(f255), "f"(f208));
  // PTX:355 add.f32 %f258, %f195, %f196
  asm("add.f32 %0, %1, %2;" : "=f"(f258) : "f"(f195), "f"(f196));
  // PTX:356 add.f32 %f259, %f197, %f256
  asm("add.f32 %0, %1, %2;" : "=f"(f259) : "f"(f197), "f"(f256));
  // PTX:357 add.f32 %f260, %f197, %f257
  asm("add.f32 %0, %1, %2;" : "=f"(f260) : "f"(f197), "f"(f257));
  // PTX:358 add.f32 %f261, %f258, %f258
  asm("add.f32 %0, %1, %2;" : "=f"(f261) : "f"(f258), "f"(f258));
  // PTX:359 mul.f32 %f262, %f259, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f262) : "f"(f259));
  // PTX:360 mul.f32 %f263, %f260, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f263) : "f"(f260));
  // PTX:361 mul.f32 %f264, %f261, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f264) : "f"(f261));
  // PTX:362 mul.f32 %f265, %f204, %f263
  asm("mul.f32 %0, %1, %2;" : "=f"(f265) : "f"(f204), "f"(f263));
  // PTX:363 mul.f32 %f266, %f200, %f263
  asm("mul.f32 %0, %1, %2;" : "=f"(f266) : "f"(f200), "f"(f263));
  // PTX:364 mul.f32 %f267, %f208, %f263
  asm("mul.f32 %0, %1, %2;" : "=f"(f267) : "f"(f208), "f"(f263));
  // PTX:365 fma.rn.f32 %f268, %f202, %f262, %f265
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f268) : "f"(f202), "f"(f262), "f"(f265));
  // PTX:366 fma.rn.f32 %f269, %f198, %f262, %f266
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f269) : "f"(f198), "f"(f262), "f"(f266));
  // PTX:367 fma.rn.f32 %f270, %f207, %f262, %f267
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f270) : "f"(f207), "f"(f262), "f"(f267));
  // PTX:368 fma.rn.f32 %f271, %f192, %f264, %f268
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f271) : "f"(f192), "f"(f264), "f"(f268));
  // PTX:369 fma.rn.f32 %f272, %f193, %f264, %f269
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f272) : "f"(f193), "f"(f264), "f"(f269));
  // PTX:370 fma.rn.f32 %f273, %f196, %f264, %f270
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f273) : "f"(f196), "f"(f264), "f"(f270));
  // PTX:371 mul.f32 %f274, %f3, %f271
  asm("mul.f32 %0, %1, %2;" : "=f"(f274) : "f"(f3), "f"(f271));
  // PTX:372 mul.f32 %f275, %f3, %f272
  asm("mul.f32 %0, %1, %2;" : "=f"(f275) : "f"(f3), "f"(f272));
  // PTX:373 mul.f32 %f276, %f3, %f273
  asm("mul.f32 %0, %1, %2;" : "=f"(f276) : "f"(f3), "f"(f273));
  // PTX:374 mul.wide.s32 %rd51, %r15, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd51) : "r"(r15));
  // PTX:375 add.s64 %rd52, %rd20, %rd51
  asm("add.s64 %0, %1, %2;" : "=l"(rd52) : "l"(rd20), "l"(rd51));
  // PTX:376 red.global.add.f32 [%rd52], %f227
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))), (float)(f227));
  // PTX:377 add.s64 %rd53, %rd52, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd53) : "l"(rd52));
  // PTX:378 red.global.add.f32 [%rd53], %f228
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))), (float)(f228));
  // PTX:379 add.s64 %rd54, %rd52, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd54) : "l"(rd52));
  // PTX:380 red.global.add.f32 [%rd54], %f229
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))), (float)(f229));
  // PTX:381 add.s64 %rd55, %rd52, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd55) : "l"(rd52));
  // PTX:382 red.global.add.f32 [%rd55], %f251
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))), (float)(f251));
  // PTX:383 add.s64 %rd56, %rd52, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd56) : "l"(rd52));
  // PTX:384 red.global.add.f32 [%rd56], %f252
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))), (float)(f252));
  // PTX:385 add.s64 %rd57, %rd52, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd57) : "l"(rd52));
  // PTX:386 red.global.add.f32 [%rd57], %f253
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))), (float)(f253));
  // PTX:387 add.s64 %rd58, %rd52, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd58) : "l"(rd52));
  // PTX:388 red.global.add.f32 [%rd58], %f274
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (0)))), (float)(f274));
  // PTX:389 add.s64 %rd59, %rd52, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd59) : "l"(rd52));
  // PTX:390 red.global.add.f32 [%rd59], %f275
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))), (float)(f275));
  // PTX:391 add.s64 %rd60, %rd52, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd60) : "l"(rd52));
  // PTX:392 red.global.add.f32 [%rd60], %f276
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))), (float)(f276));
  // PTX:394 $L__BB61_5:
L_BB61_5:;
  // PTX:395 ret
  return;
}
