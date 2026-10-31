// 机械还原自 PTX：synreal::kernel::apply_affine_body_preconditioner(glm::vec<4, int, (glm::qualifier)0> const*, float const*, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: e48a2d3d1ee352c527afd85e7c346d501aa419d8e9e1a06a7a6ab3f8fafcbb38
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__apply_affine_body_preconditioner(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7) {
  int p0, p1, p2, p3;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46;
  // PTX:24 ld.param.u64 %rd8, [_ZN7synreal6kernel32apply_affine_body_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKfPKiPKNS2_ILi3EfLS3_0EEEPSB_mmm_param_0]
  rd8 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:25 ld.param.u64 %rd9, [_ZN7synreal6kernel32apply_affine_body_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKfPKiPKNS2_ILi3EfLS3_0EEEPSB_mmm_param_1]
  rd9 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:26 ld.param.u64 %rd10, [_ZN7synreal6kernel32apply_affine_body_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKfPKiPKNS2_ILi3EfLS3_0EEEPSB_mmm_param_2]
  rd10 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:27 ld.param.u64 %rd11, [_ZN7synreal6kernel32apply_affine_body_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKfPKiPKNS2_ILi3EfLS3_0EEEPSB_mmm_param_3]
  rd11 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:28 ld.param.u64 %rd12, [_ZN7synreal6kernel32apply_affine_body_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKfPKiPKNS2_ILi3EfLS3_0EEEPSB_mmm_param_4]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:29 ld.param.u64 %rd15, [_ZN7synreal6kernel32apply_affine_body_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKfPKiPKNS2_ILi3EfLS3_0EEEPSB_mmm_param_5]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:30 ld.param.u64 %rd13, [_ZN7synreal6kernel32apply_affine_body_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKfPKiPKNS2_ILi3EfLS3_0EEEPSB_mmm_param_6]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:31 ld.param.u64 %rd14, [_ZN7synreal6kernel32apply_affine_body_preconditionerEPKN3glm3vecILi4EiLNS1_9qualifierE0EEEPKfPKiPKNS2_ILi3EfLS3_0EEEPSB_mmm_param_7]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:32 mov.u32 %r1, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r1) : "r"(blockIdx.x));
  // PTX:33 mov.u32 %r2, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockDim.x));
  // PTX:34 mul.wide.u32 %rd16, %r1, %r2
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd16) : "r"(r1), "r"(r2));
  // PTX:35 mov.u32 %r3, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(threadIdx.x));
  // PTX:36 cvt.u64.u32 %rd17, %r3
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd17) : "r"(r3));
  // PTX:37 add.s64 %rd1, %rd16, %rd17
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd16), "l"(rd17));
  // PTX:38 setp.ge.u64 %p1, %rd1, %rd15
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd15)));
  // PTX:39 @%p1 bra $L__BB76_6
  if (p1) { goto L_BB76_6; }
  // PTX:41 cvta.to.global.u64 %rd18, %rd10
  rd18 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd10));
  // PTX:42 shl.b64 %rd19, %rd1, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd19) : "l"(rd1));
  // PTX:43 add.s64 %rd20, %rd18, %rd19
  asm("add.s64 %0, %1, %2;" : "=l"(rd20) : "l"(rd18), "l"(rd19));
  // PTX:44 ld.global.u32 %r4, [%rd20]
  r4 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))));
  // PTX:45 setp.eq.s32 %p2, %r4, 0
  p2 = (((int)(r4)) == ((int)(0)));
  // PTX:46 @%p2 bra $L__BB76_6
  if (p2) { goto L_BB76_6; }
  // PTX:48 or.b64 %rd21, %rd1, %rd13
  asm("or.b64 %0, %1, %2;" : "=l"(rd21) : "l"(rd1), "l"(rd13));
  // PTX:49 and.b64 %rd22, %rd21, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd22) : "l"(rd21));
  // PTX:50 setp.eq.s64 %p3, %rd22, 0
  p3 = (((long long)(rd22)) == ((long long)(0)));
  // PTX:51 @%p3 bra $L__BB76_4
  if (p3) { goto L_BB76_4; }
  // PTX:53 div.u64 %rd45, %rd1, %rd13
  asm("div.u64 %0, %1, %2;" : "=l"(rd45) : "l"(rd1), "l"(rd13));
  // PTX:54 mul.lo.s64 %rd23, %rd45, %rd13
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd23) : "l"(rd45), "l"(rd13));
  // PTX:55 sub.s64 %rd46, %rd1, %rd23
  asm("sub.s64 %0, %1, %2;" : "=l"(rd46) : "l"(rd1), "l"(rd23));
  // PTX:56 bra.uni $L__BB76_5
  goto L_BB76_5;
  // PTX:58 $L__BB76_4:
L_BB76_4:;
  // PTX:59 cvt.u32.u64 %r5, %rd13
  asm("cvt.u32.u64 %0, %1;" : "=r"(r5) : "l"(rd13));
  // PTX:60 cvt.u32.u64 %r6, %rd1
  asm("cvt.u32.u64 %0, %1;" : "=r"(r6) : "l"(rd1));
  // PTX:61 div.u32 %r7, %r6, %r5
  asm("div.u32 %0, %1, %2;" : "=r"(r7) : "r"(r6), "r"(r5));
  // PTX:62 mul.lo.s32 %r8, %r7, %r5
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r8) : "r"(r7), "r"(r5));
  // PTX:63 sub.s32 %r9, %r6, %r8
  asm("sub.s32 %0, %1, %2;" : "=r"(r9) : "r"(r6), "r"(r8));
  // PTX:64 cvt.u64.u32 %rd45, %r7
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd45) : "r"(r7));
  // PTX:65 cvt.u64.u32 %rd46, %r9
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd46) : "r"(r9));
  // PTX:67 $L__BB76_5:
L_BB76_5:;
  // PTX:68 cvta.to.global.u64 %rd24, %rd12
  rd24 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd12));
  // PTX:69 cvta.to.global.u64 %rd25, %rd11
  rd25 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd11));
  // PTX:70 mul.lo.s64 %rd26, %rd45, %rd14
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd26) : "l"(rd45), "l"(rd14));
  // PTX:71 cvt.u32.u64 %r10, %rd26
  asm("cvt.u32.u64 %0, %1;" : "=r"(r10) : "l"(rd26));
  // PTX:72 cvta.to.global.u64 %rd27, %rd8
  rd27 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd8));
  // PTX:73 shl.b64 %rd28, %rd46, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd28) : "l"(rd46));
  // PTX:74 add.s64 %rd29, %rd27, %rd28
  asm("add.s64 %0, %1, %2;" : "=l"(rd29) : "l"(rd27), "l"(rd28));
  // PTX:75 ld.global.u32 %r11, [%rd29]
  r11 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (0)))));
  // PTX:76 add.s32 %r12, %r11, %r10
  asm("add.s32 %0, %1, %2;" : "=r"(r12) : "r"(r11), "r"(r10));
  // PTX:77 ld.global.u32 %r13, [%rd29+4]
  r13 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (4)))));
  // PTX:78 add.s32 %r14, %r13, %r10
  asm("add.s32 %0, %1, %2;" : "=r"(r14) : "r"(r13), "r"(r10));
  // PTX:79 ld.global.u32 %r15, [%rd29+8]
  r15 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (8)))));
  // PTX:80 add.s32 %r16, %r15, %r10
  asm("add.s32 %0, %1, %2;" : "=r"(r16) : "r"(r15), "r"(r10));
  // PTX:81 ld.global.u32 %r17, [%rd29+12]
  r17 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (12)))));
  // PTX:82 add.s32 %r18, %r17, %r10
  asm("add.s32 %0, %1, %2;" : "=r"(r18) : "r"(r17), "r"(r10));
  // PTX:83 mul.wide.s32 %rd30, %r12, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd30) : "r"(r12));
  // PTX:84 add.s64 %rd31, %rd25, %rd30
  asm("add.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd25), "l"(rd30));
  // PTX:85 mul.wide.s32 %rd32, %r14, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd32) : "r"(r14));
  // PTX:86 add.s64 %rd33, %rd25, %rd32
  asm("add.s64 %0, %1, %2;" : "=l"(rd33) : "l"(rd25), "l"(rd32));
  // PTX:87 mul.wide.s32 %rd34, %r16, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd34) : "r"(r16));
  // PTX:88 add.s64 %rd35, %rd25, %rd34
  asm("add.s64 %0, %1, %2;" : "=l"(rd35) : "l"(rd25), "l"(rd34));
  // PTX:89 mul.wide.s32 %rd36, %r18, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd36) : "r"(r18));
  // PTX:90 add.s64 %rd37, %rd25, %rd36
  asm("add.s64 %0, %1, %2;" : "=l"(rd37) : "l"(rd25), "l"(rd36));
  // PTX:91 cvta.to.global.u64 %rd38, %rd9
  rd38 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd9));
  // PTX:92 mul.lo.s64 %rd39, %rd1, 576
  asm("mul.lo.s64 %0, %1, 576;" : "=l"(rd39) : "l"(rd1));
  // PTX:93 add.s64 %rd40, %rd38, %rd39
  asm("add.s64 %0, %1, %2;" : "=l"(rd40) : "l"(rd38), "l"(rd39));
  // PTX:94 ld.global.f32 %f1, [%rd40]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (0)))));
  // PTX:95 ld.global.f32 %f2, [%rd31]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (0)))));
  // PTX:96 fma.rn.f32 %f3, %f1, %f2, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f3) : "f"(f1), "f"(f2));
  // PTX:97 ld.global.f32 %f4, [%rd40+4]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (4)))));
  // PTX:98 ld.global.f32 %f5, [%rd31+4]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (4)))));
  // PTX:99 fma.rn.f32 %f6, %f4, %f5, %f3
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f6) : "f"(f4), "f"(f5), "f"(f3));
  // PTX:100 ld.global.f32 %f7, [%rd40+8]
  f7 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (8)))));
  // PTX:101 ld.global.f32 %f8, [%rd31+8]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (8)))));
  // PTX:102 fma.rn.f32 %f9, %f7, %f8, %f6
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f9) : "f"(f7), "f"(f8), "f"(f6));
  // PTX:103 ld.global.f32 %f10, [%rd40+12]
  f10 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (12)))));
  // PTX:104 ld.global.f32 %f11, [%rd33]
  f11 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (0)))));
  // PTX:105 fma.rn.f32 %f12, %f10, %f11, %f9
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f12) : "f"(f10), "f"(f11), "f"(f9));
  // PTX:106 ld.global.f32 %f13, [%rd40+16]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (16)))));
  // PTX:107 ld.global.f32 %f14, [%rd33+4]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (4)))));
  // PTX:108 fma.rn.f32 %f15, %f13, %f14, %f12
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f15) : "f"(f13), "f"(f14), "f"(f12));
  // PTX:109 ld.global.f32 %f16, [%rd40+20]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (20)))));
  // PTX:110 ld.global.f32 %f17, [%rd33+8]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (8)))));
  // PTX:111 fma.rn.f32 %f18, %f16, %f17, %f15
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f18) : "f"(f16), "f"(f17), "f"(f15));
  // PTX:112 ld.global.f32 %f19, [%rd40+24]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (24)))));
  // PTX:113 ld.global.f32 %f20, [%rd35]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (0)))));
  // PTX:114 fma.rn.f32 %f21, %f19, %f20, %f18
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f21) : "f"(f19), "f"(f20), "f"(f18));
  // PTX:115 ld.global.f32 %f22, [%rd40+28]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (28)))));
  // PTX:116 ld.global.f32 %f23, [%rd35+4]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (4)))));
  // PTX:117 fma.rn.f32 %f24, %f22, %f23, %f21
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f24) : "f"(f22), "f"(f23), "f"(f21));
  // PTX:118 ld.global.f32 %f25, [%rd40+32]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (32)))));
  // PTX:119 ld.global.f32 %f26, [%rd35+8]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (8)))));
  // PTX:120 fma.rn.f32 %f27, %f25, %f26, %f24
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f27) : "f"(f25), "f"(f26), "f"(f24));
  // PTX:121 ld.global.f32 %f28, [%rd40+36]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (36)))));
  // PTX:122 ld.global.f32 %f29, [%rd37]
  f29 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (0)))));
  // PTX:123 fma.rn.f32 %f30, %f28, %f29, %f27
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f30) : "f"(f28), "f"(f29), "f"(f27));
  // PTX:124 ld.global.f32 %f31, [%rd40+40]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (40)))));
  // PTX:125 ld.global.f32 %f32, [%rd37+4]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (4)))));
  // PTX:126 fma.rn.f32 %f33, %f31, %f32, %f30
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f33) : "f"(f31), "f"(f32), "f"(f30));
  // PTX:127 ld.global.f32 %f34, [%rd40+44]
  f34 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (44)))));
  // PTX:128 ld.global.f32 %f35, [%rd37+8]
  f35 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (8)))));
  // PTX:129 fma.rn.f32 %f36, %f34, %f35, %f33
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f36) : "f"(f34), "f"(f35), "f"(f33));
  // PTX:130 add.s64 %rd41, %rd24, %rd30
  asm("add.s64 %0, %1, %2;" : "=l"(rd41) : "l"(rd24), "l"(rd30));
  // PTX:131 st.global.f32 [%rd41], %f36
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (0))))) = (float)(f36);
  // PTX:132 ld.global.f32 %f37, [%rd40+48]
  f37 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (48)))));
  // PTX:133 fma.rn.f32 %f38, %f37, %f2, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f38) : "f"(f37), "f"(f2));
  // PTX:134 ld.global.f32 %f39, [%rd40+52]
  f39 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (52)))));
  // PTX:135 fma.rn.f32 %f40, %f39, %f5, %f38
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f40) : "f"(f39), "f"(f5), "f"(f38));
  // PTX:136 ld.global.f32 %f41, [%rd40+56]
  f41 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (56)))));
  // PTX:137 fma.rn.f32 %f42, %f41, %f8, %f40
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f42) : "f"(f41), "f"(f8), "f"(f40));
  // PTX:138 ld.global.f32 %f43, [%rd40+60]
  f43 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (60)))));
  // PTX:139 fma.rn.f32 %f44, %f43, %f11, %f42
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f44) : "f"(f43), "f"(f11), "f"(f42));
  // PTX:140 ld.global.f32 %f45, [%rd40+64]
  f45 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (64)))));
  // PTX:141 fma.rn.f32 %f46, %f45, %f14, %f44
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f46) : "f"(f45), "f"(f14), "f"(f44));
  // PTX:142 ld.global.f32 %f47, [%rd40+68]
  f47 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (68)))));
  // PTX:143 fma.rn.f32 %f48, %f47, %f17, %f46
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f48) : "f"(f47), "f"(f17), "f"(f46));
  // PTX:144 ld.global.f32 %f49, [%rd40+72]
  f49 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (72)))));
  // PTX:145 fma.rn.f32 %f50, %f49, %f20, %f48
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f50) : "f"(f49), "f"(f20), "f"(f48));
  // PTX:146 ld.global.f32 %f51, [%rd40+76]
  f51 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (76)))));
  // PTX:147 fma.rn.f32 %f52, %f51, %f23, %f50
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f52) : "f"(f51), "f"(f23), "f"(f50));
  // PTX:148 ld.global.f32 %f53, [%rd40+80]
  f53 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (80)))));
  // PTX:149 fma.rn.f32 %f54, %f53, %f26, %f52
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f54) : "f"(f53), "f"(f26), "f"(f52));
  // PTX:150 ld.global.f32 %f55, [%rd40+84]
  f55 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (84)))));
  // PTX:151 fma.rn.f32 %f56, %f55, %f29, %f54
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f56) : "f"(f55), "f"(f29), "f"(f54));
  // PTX:152 ld.global.f32 %f57, [%rd40+88]
  f57 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (88)))));
  // PTX:153 fma.rn.f32 %f58, %f57, %f32, %f56
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f58) : "f"(f57), "f"(f32), "f"(f56));
  // PTX:154 ld.global.f32 %f59, [%rd40+92]
  f59 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (92)))));
  // PTX:155 fma.rn.f32 %f60, %f59, %f35, %f58
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f60) : "f"(f59), "f"(f35), "f"(f58));
  // PTX:156 st.global.f32 [%rd41+4], %f60
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (4))))) = (float)(f60);
  // PTX:157 ld.global.f32 %f61, [%rd40+96]
  f61 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (96)))));
  // PTX:158 fma.rn.f32 %f62, %f61, %f2, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f62) : "f"(f61), "f"(f2));
  // PTX:159 ld.global.f32 %f63, [%rd40+100]
  f63 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (100)))));
  // PTX:160 fma.rn.f32 %f64, %f63, %f5, %f62
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f64) : "f"(f63), "f"(f5), "f"(f62));
  // PTX:161 ld.global.f32 %f65, [%rd40+104]
  f65 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (104)))));
  // PTX:162 fma.rn.f32 %f66, %f65, %f8, %f64
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f66) : "f"(f65), "f"(f8), "f"(f64));
  // PTX:163 ld.global.f32 %f67, [%rd40+108]
  f67 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (108)))));
  // PTX:164 fma.rn.f32 %f68, %f67, %f11, %f66
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f68) : "f"(f67), "f"(f11), "f"(f66));
  // PTX:165 ld.global.f32 %f69, [%rd40+112]
  f69 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (112)))));
  // PTX:166 fma.rn.f32 %f70, %f69, %f14, %f68
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f70) : "f"(f69), "f"(f14), "f"(f68));
  // PTX:167 ld.global.f32 %f71, [%rd40+116]
  f71 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (116)))));
  // PTX:168 fma.rn.f32 %f72, %f71, %f17, %f70
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f72) : "f"(f71), "f"(f17), "f"(f70));
  // PTX:169 ld.global.f32 %f73, [%rd40+120]
  f73 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (120)))));
  // PTX:170 fma.rn.f32 %f74, %f73, %f20, %f72
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f74) : "f"(f73), "f"(f20), "f"(f72));
  // PTX:171 ld.global.f32 %f75, [%rd40+124]
  f75 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (124)))));
  // PTX:172 fma.rn.f32 %f76, %f75, %f23, %f74
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f76) : "f"(f75), "f"(f23), "f"(f74));
  // PTX:173 ld.global.f32 %f77, [%rd40+128]
  f77 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (128)))));
  // PTX:174 fma.rn.f32 %f78, %f77, %f26, %f76
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f78) : "f"(f77), "f"(f26), "f"(f76));
  // PTX:175 ld.global.f32 %f79, [%rd40+132]
  f79 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (132)))));
  // PTX:176 fma.rn.f32 %f80, %f79, %f29, %f78
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f80) : "f"(f79), "f"(f29), "f"(f78));
  // PTX:177 ld.global.f32 %f81, [%rd40+136]
  f81 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (136)))));
  // PTX:178 fma.rn.f32 %f82, %f81, %f32, %f80
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f82) : "f"(f81), "f"(f32), "f"(f80));
  // PTX:179 ld.global.f32 %f83, [%rd40+140]
  f83 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (140)))));
  // PTX:180 fma.rn.f32 %f84, %f83, %f35, %f82
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f84) : "f"(f83), "f"(f35), "f"(f82));
  // PTX:181 st.global.f32 [%rd41+8], %f84
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (8))))) = (float)(f84);
  // PTX:182 ld.global.f32 %f85, [%rd40+144]
  f85 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (144)))));
  // PTX:183 fma.rn.f32 %f86, %f85, %f2, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f86) : "f"(f85), "f"(f2));
  // PTX:184 ld.global.f32 %f87, [%rd40+148]
  f87 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (148)))));
  // PTX:185 fma.rn.f32 %f88, %f87, %f5, %f86
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f88) : "f"(f87), "f"(f5), "f"(f86));
  // PTX:186 ld.global.f32 %f89, [%rd40+152]
  f89 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (152)))));
  // PTX:187 fma.rn.f32 %f90, %f89, %f8, %f88
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f90) : "f"(f89), "f"(f8), "f"(f88));
  // PTX:188 ld.global.f32 %f91, [%rd40+156]
  f91 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (156)))));
  // PTX:189 fma.rn.f32 %f92, %f91, %f11, %f90
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f92) : "f"(f91), "f"(f11), "f"(f90));
  // PTX:190 ld.global.f32 %f93, [%rd40+160]
  f93 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (160)))));
  // PTX:191 fma.rn.f32 %f94, %f93, %f14, %f92
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f94) : "f"(f93), "f"(f14), "f"(f92));
  // PTX:192 ld.global.f32 %f95, [%rd40+164]
  f95 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (164)))));
  // PTX:193 fma.rn.f32 %f96, %f95, %f17, %f94
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f96) : "f"(f95), "f"(f17), "f"(f94));
  // PTX:194 ld.global.f32 %f97, [%rd40+168]
  f97 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (168)))));
  // PTX:195 fma.rn.f32 %f98, %f97, %f20, %f96
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f98) : "f"(f97), "f"(f20), "f"(f96));
  // PTX:196 ld.global.f32 %f99, [%rd40+172]
  f99 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (172)))));
  // PTX:197 fma.rn.f32 %f100, %f99, %f23, %f98
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f100) : "f"(f99), "f"(f23), "f"(f98));
  // PTX:198 ld.global.f32 %f101, [%rd40+176]
  f101 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (176)))));
  // PTX:199 fma.rn.f32 %f102, %f101, %f26, %f100
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f102) : "f"(f101), "f"(f26), "f"(f100));
  // PTX:200 ld.global.f32 %f103, [%rd40+180]
  f103 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (180)))));
  // PTX:201 fma.rn.f32 %f104, %f103, %f29, %f102
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f104) : "f"(f103), "f"(f29), "f"(f102));
  // PTX:202 ld.global.f32 %f105, [%rd40+184]
  f105 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (184)))));
  // PTX:203 fma.rn.f32 %f106, %f105, %f32, %f104
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f106) : "f"(f105), "f"(f32), "f"(f104));
  // PTX:204 ld.global.f32 %f107, [%rd40+188]
  f107 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (188)))));
  // PTX:205 fma.rn.f32 %f108, %f107, %f35, %f106
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f108) : "f"(f107), "f"(f35), "f"(f106));
  // PTX:206 add.s64 %rd42, %rd24, %rd32
  asm("add.s64 %0, %1, %2;" : "=l"(rd42) : "l"(rd24), "l"(rd32));
  // PTX:207 st.global.f32 [%rd42], %f108
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (0))))) = (float)(f108);
  // PTX:208 ld.global.f32 %f109, [%rd40+192]
  f109 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (192)))));
  // PTX:209 fma.rn.f32 %f110, %f109, %f2, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f110) : "f"(f109), "f"(f2));
  // PTX:210 ld.global.f32 %f111, [%rd40+196]
  f111 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (196)))));
  // PTX:211 fma.rn.f32 %f112, %f111, %f5, %f110
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f112) : "f"(f111), "f"(f5), "f"(f110));
  // PTX:212 ld.global.f32 %f113, [%rd40+200]
  f113 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (200)))));
  // PTX:213 fma.rn.f32 %f114, %f113, %f8, %f112
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f114) : "f"(f113), "f"(f8), "f"(f112));
  // PTX:214 ld.global.f32 %f115, [%rd40+204]
  f115 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (204)))));
  // PTX:215 fma.rn.f32 %f116, %f115, %f11, %f114
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f116) : "f"(f115), "f"(f11), "f"(f114));
  // PTX:216 ld.global.f32 %f117, [%rd40+208]
  f117 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (208)))));
  // PTX:217 fma.rn.f32 %f118, %f117, %f14, %f116
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f118) : "f"(f117), "f"(f14), "f"(f116));
  // PTX:218 ld.global.f32 %f119, [%rd40+212]
  f119 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (212)))));
  // PTX:219 fma.rn.f32 %f120, %f119, %f17, %f118
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f120) : "f"(f119), "f"(f17), "f"(f118));
  // PTX:220 ld.global.f32 %f121, [%rd40+216]
  f121 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (216)))));
  // PTX:221 fma.rn.f32 %f122, %f121, %f20, %f120
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f122) : "f"(f121), "f"(f20), "f"(f120));
  // PTX:222 ld.global.f32 %f123, [%rd40+220]
  f123 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (220)))));
  // PTX:223 fma.rn.f32 %f124, %f123, %f23, %f122
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f124) : "f"(f123), "f"(f23), "f"(f122));
  // PTX:224 ld.global.f32 %f125, [%rd40+224]
  f125 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (224)))));
  // PTX:225 fma.rn.f32 %f126, %f125, %f26, %f124
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f126) : "f"(f125), "f"(f26), "f"(f124));
  // PTX:226 ld.global.f32 %f127, [%rd40+228]
  f127 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (228)))));
  // PTX:227 fma.rn.f32 %f128, %f127, %f29, %f126
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f128) : "f"(f127), "f"(f29), "f"(f126));
  // PTX:228 ld.global.f32 %f129, [%rd40+232]
  f129 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (232)))));
  // PTX:229 fma.rn.f32 %f130, %f129, %f32, %f128
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f130) : "f"(f129), "f"(f32), "f"(f128));
  // PTX:230 ld.global.f32 %f131, [%rd40+236]
  f131 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (236)))));
  // PTX:231 fma.rn.f32 %f132, %f131, %f35, %f130
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f132) : "f"(f131), "f"(f35), "f"(f130));
  // PTX:232 st.global.f32 [%rd42+4], %f132
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (4))))) = (float)(f132);
  // PTX:233 ld.global.f32 %f133, [%rd40+240]
  f133 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (240)))));
  // PTX:234 fma.rn.f32 %f134, %f133, %f2, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f134) : "f"(f133), "f"(f2));
  // PTX:235 ld.global.f32 %f135, [%rd40+244]
  f135 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (244)))));
  // PTX:236 fma.rn.f32 %f136, %f135, %f5, %f134
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f136) : "f"(f135), "f"(f5), "f"(f134));
  // PTX:237 ld.global.f32 %f137, [%rd40+248]
  f137 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (248)))));
  // PTX:238 fma.rn.f32 %f138, %f137, %f8, %f136
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f138) : "f"(f137), "f"(f8), "f"(f136));
  // PTX:239 ld.global.f32 %f139, [%rd40+252]
  f139 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (252)))));
  // PTX:240 fma.rn.f32 %f140, %f139, %f11, %f138
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f140) : "f"(f139), "f"(f11), "f"(f138));
  // PTX:241 ld.global.f32 %f141, [%rd40+256]
  f141 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (256)))));
  // PTX:242 fma.rn.f32 %f142, %f141, %f14, %f140
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f142) : "f"(f141), "f"(f14), "f"(f140));
  // PTX:243 ld.global.f32 %f143, [%rd40+260]
  f143 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (260)))));
  // PTX:244 fma.rn.f32 %f144, %f143, %f17, %f142
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f144) : "f"(f143), "f"(f17), "f"(f142));
  // PTX:245 ld.global.f32 %f145, [%rd40+264]
  f145 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (264)))));
  // PTX:246 fma.rn.f32 %f146, %f145, %f20, %f144
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f146) : "f"(f145), "f"(f20), "f"(f144));
  // PTX:247 ld.global.f32 %f147, [%rd40+268]
  f147 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (268)))));
  // PTX:248 fma.rn.f32 %f148, %f147, %f23, %f146
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f148) : "f"(f147), "f"(f23), "f"(f146));
  // PTX:249 ld.global.f32 %f149, [%rd40+272]
  f149 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (272)))));
  // PTX:250 fma.rn.f32 %f150, %f149, %f26, %f148
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f150) : "f"(f149), "f"(f26), "f"(f148));
  // PTX:251 ld.global.f32 %f151, [%rd40+276]
  f151 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (276)))));
  // PTX:252 fma.rn.f32 %f152, %f151, %f29, %f150
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f152) : "f"(f151), "f"(f29), "f"(f150));
  // PTX:253 ld.global.f32 %f153, [%rd40+280]
  f153 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (280)))));
  // PTX:254 fma.rn.f32 %f154, %f153, %f32, %f152
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f154) : "f"(f153), "f"(f32), "f"(f152));
  // PTX:255 ld.global.f32 %f155, [%rd40+284]
  f155 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (284)))));
  // PTX:256 fma.rn.f32 %f156, %f155, %f35, %f154
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f156) : "f"(f155), "f"(f35), "f"(f154));
  // PTX:257 st.global.f32 [%rd42+8], %f156
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (8))))) = (float)(f156);
  // PTX:258 ld.global.f32 %f157, [%rd40+288]
  f157 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (288)))));
  // PTX:259 fma.rn.f32 %f158, %f157, %f2, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f158) : "f"(f157), "f"(f2));
  // PTX:260 ld.global.f32 %f159, [%rd40+292]
  f159 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (292)))));
  // PTX:261 fma.rn.f32 %f160, %f159, %f5, %f158
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f160) : "f"(f159), "f"(f5), "f"(f158));
  // PTX:262 ld.global.f32 %f161, [%rd40+296]
  f161 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (296)))));
  // PTX:263 fma.rn.f32 %f162, %f161, %f8, %f160
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f162) : "f"(f161), "f"(f8), "f"(f160));
  // PTX:264 ld.global.f32 %f163, [%rd40+300]
  f163 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (300)))));
  // PTX:265 fma.rn.f32 %f164, %f163, %f11, %f162
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f164) : "f"(f163), "f"(f11), "f"(f162));
  // PTX:266 ld.global.f32 %f165, [%rd40+304]
  f165 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (304)))));
  // PTX:267 fma.rn.f32 %f166, %f165, %f14, %f164
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f166) : "f"(f165), "f"(f14), "f"(f164));
  // PTX:268 ld.global.f32 %f167, [%rd40+308]
  f167 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (308)))));
  // PTX:269 fma.rn.f32 %f168, %f167, %f17, %f166
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f168) : "f"(f167), "f"(f17), "f"(f166));
  // PTX:270 ld.global.f32 %f169, [%rd40+312]
  f169 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (312)))));
  // PTX:271 fma.rn.f32 %f170, %f169, %f20, %f168
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f170) : "f"(f169), "f"(f20), "f"(f168));
  // PTX:272 ld.global.f32 %f171, [%rd40+316]
  f171 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (316)))));
  // PTX:273 fma.rn.f32 %f172, %f171, %f23, %f170
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f172) : "f"(f171), "f"(f23), "f"(f170));
  // PTX:274 ld.global.f32 %f173, [%rd40+320]
  f173 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (320)))));
  // PTX:275 fma.rn.f32 %f174, %f173, %f26, %f172
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f174) : "f"(f173), "f"(f26), "f"(f172));
  // PTX:276 ld.global.f32 %f175, [%rd40+324]
  f175 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (324)))));
  // PTX:277 fma.rn.f32 %f176, %f175, %f29, %f174
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f176) : "f"(f175), "f"(f29), "f"(f174));
  // PTX:278 ld.global.f32 %f177, [%rd40+328]
  f177 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (328)))));
  // PTX:279 fma.rn.f32 %f178, %f177, %f32, %f176
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f178) : "f"(f177), "f"(f32), "f"(f176));
  // PTX:280 ld.global.f32 %f179, [%rd40+332]
  f179 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (332)))));
  // PTX:281 fma.rn.f32 %f180, %f179, %f35, %f178
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f180) : "f"(f179), "f"(f35), "f"(f178));
  // PTX:282 add.s64 %rd43, %rd24, %rd34
  asm("add.s64 %0, %1, %2;" : "=l"(rd43) : "l"(rd24), "l"(rd34));
  // PTX:283 st.global.f32 [%rd43], %f180
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (0))))) = (float)(f180);
  // PTX:284 ld.global.f32 %f181, [%rd40+336]
  f181 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (336)))));
  // PTX:285 fma.rn.f32 %f182, %f181, %f2, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f182) : "f"(f181), "f"(f2));
  // PTX:286 ld.global.f32 %f183, [%rd40+340]
  f183 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (340)))));
  // PTX:287 fma.rn.f32 %f184, %f183, %f5, %f182
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f184) : "f"(f183), "f"(f5), "f"(f182));
  // PTX:288 ld.global.f32 %f185, [%rd40+344]
  f185 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (344)))));
  // PTX:289 fma.rn.f32 %f186, %f185, %f8, %f184
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f186) : "f"(f185), "f"(f8), "f"(f184));
  // PTX:290 ld.global.f32 %f187, [%rd40+348]
  f187 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (348)))));
  // PTX:291 fma.rn.f32 %f188, %f187, %f11, %f186
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f188) : "f"(f187), "f"(f11), "f"(f186));
  // PTX:292 ld.global.f32 %f189, [%rd40+352]
  f189 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (352)))));
  // PTX:293 fma.rn.f32 %f190, %f189, %f14, %f188
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f190) : "f"(f189), "f"(f14), "f"(f188));
  // PTX:294 ld.global.f32 %f191, [%rd40+356]
  f191 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (356)))));
  // PTX:295 fma.rn.f32 %f192, %f191, %f17, %f190
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f192) : "f"(f191), "f"(f17), "f"(f190));
  // PTX:296 ld.global.f32 %f193, [%rd40+360]
  f193 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (360)))));
  // PTX:297 fma.rn.f32 %f194, %f193, %f20, %f192
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f194) : "f"(f193), "f"(f20), "f"(f192));
  // PTX:298 ld.global.f32 %f195, [%rd40+364]
  f195 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (364)))));
  // PTX:299 fma.rn.f32 %f196, %f195, %f23, %f194
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f196) : "f"(f195), "f"(f23), "f"(f194));
  // PTX:300 ld.global.f32 %f197, [%rd40+368]
  f197 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (368)))));
  // PTX:301 fma.rn.f32 %f198, %f197, %f26, %f196
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f198) : "f"(f197), "f"(f26), "f"(f196));
  // PTX:302 ld.global.f32 %f199, [%rd40+372]
  f199 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (372)))));
  // PTX:303 fma.rn.f32 %f200, %f199, %f29, %f198
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f200) : "f"(f199), "f"(f29), "f"(f198));
  // PTX:304 ld.global.f32 %f201, [%rd40+376]
  f201 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (376)))));
  // PTX:305 fma.rn.f32 %f202, %f201, %f32, %f200
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f202) : "f"(f201), "f"(f32), "f"(f200));
  // PTX:306 ld.global.f32 %f203, [%rd40+380]
  f203 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (380)))));
  // PTX:307 fma.rn.f32 %f204, %f203, %f35, %f202
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f204) : "f"(f203), "f"(f35), "f"(f202));
  // PTX:308 st.global.f32 [%rd43+4], %f204
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (4))))) = (float)(f204);
  // PTX:309 ld.global.f32 %f205, [%rd40+384]
  f205 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (384)))));
  // PTX:310 fma.rn.f32 %f206, %f205, %f2, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f206) : "f"(f205), "f"(f2));
  // PTX:311 ld.global.f32 %f207, [%rd40+388]
  f207 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (388)))));
  // PTX:312 fma.rn.f32 %f208, %f207, %f5, %f206
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f208) : "f"(f207), "f"(f5), "f"(f206));
  // PTX:313 ld.global.f32 %f209, [%rd40+392]
  f209 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (392)))));
  // PTX:314 fma.rn.f32 %f210, %f209, %f8, %f208
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f210) : "f"(f209), "f"(f8), "f"(f208));
  // PTX:315 ld.global.f32 %f211, [%rd40+396]
  f211 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (396)))));
  // PTX:316 fma.rn.f32 %f212, %f211, %f11, %f210
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f212) : "f"(f211), "f"(f11), "f"(f210));
  // PTX:317 ld.global.f32 %f213, [%rd40+400]
  f213 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (400)))));
  // PTX:318 fma.rn.f32 %f214, %f213, %f14, %f212
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f214) : "f"(f213), "f"(f14), "f"(f212));
  // PTX:319 ld.global.f32 %f215, [%rd40+404]
  f215 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (404)))));
  // PTX:320 fma.rn.f32 %f216, %f215, %f17, %f214
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f216) : "f"(f215), "f"(f17), "f"(f214));
  // PTX:321 ld.global.f32 %f217, [%rd40+408]
  f217 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (408)))));
  // PTX:322 fma.rn.f32 %f218, %f217, %f20, %f216
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f218) : "f"(f217), "f"(f20), "f"(f216));
  // PTX:323 ld.global.f32 %f219, [%rd40+412]
  f219 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (412)))));
  // PTX:324 fma.rn.f32 %f220, %f219, %f23, %f218
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f220) : "f"(f219), "f"(f23), "f"(f218));
  // PTX:325 ld.global.f32 %f221, [%rd40+416]
  f221 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (416)))));
  // PTX:326 fma.rn.f32 %f222, %f221, %f26, %f220
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f222) : "f"(f221), "f"(f26), "f"(f220));
  // PTX:327 ld.global.f32 %f223, [%rd40+420]
  f223 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (420)))));
  // PTX:328 fma.rn.f32 %f224, %f223, %f29, %f222
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f224) : "f"(f223), "f"(f29), "f"(f222));
  // PTX:329 ld.global.f32 %f225, [%rd40+424]
  f225 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (424)))));
  // PTX:330 fma.rn.f32 %f226, %f225, %f32, %f224
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f226) : "f"(f225), "f"(f32), "f"(f224));
  // PTX:331 ld.global.f32 %f227, [%rd40+428]
  f227 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (428)))));
  // PTX:332 fma.rn.f32 %f228, %f227, %f35, %f226
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f228) : "f"(f227), "f"(f35), "f"(f226));
  // PTX:333 st.global.f32 [%rd43+8], %f228
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (8))))) = (float)(f228);
  // PTX:334 ld.global.f32 %f229, [%rd40+432]
  f229 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (432)))));
  // PTX:335 fma.rn.f32 %f230, %f229, %f2, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f230) : "f"(f229), "f"(f2));
  // PTX:336 ld.global.f32 %f231, [%rd40+436]
  f231 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (436)))));
  // PTX:337 fma.rn.f32 %f232, %f231, %f5, %f230
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f232) : "f"(f231), "f"(f5), "f"(f230));
  // PTX:338 ld.global.f32 %f233, [%rd40+440]
  f233 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (440)))));
  // PTX:339 fma.rn.f32 %f234, %f233, %f8, %f232
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f234) : "f"(f233), "f"(f8), "f"(f232));
  // PTX:340 ld.global.f32 %f235, [%rd40+444]
  f235 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (444)))));
  // PTX:341 fma.rn.f32 %f236, %f235, %f11, %f234
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f236) : "f"(f235), "f"(f11), "f"(f234));
  // PTX:342 ld.global.f32 %f237, [%rd40+448]
  f237 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (448)))));
  // PTX:343 fma.rn.f32 %f238, %f237, %f14, %f236
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f238) : "f"(f237), "f"(f14), "f"(f236));
  // PTX:344 ld.global.f32 %f239, [%rd40+452]
  f239 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (452)))));
  // PTX:345 fma.rn.f32 %f240, %f239, %f17, %f238
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f240) : "f"(f239), "f"(f17), "f"(f238));
  // PTX:346 ld.global.f32 %f241, [%rd40+456]
  f241 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (456)))));
  // PTX:347 fma.rn.f32 %f242, %f241, %f20, %f240
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f242) : "f"(f241), "f"(f20), "f"(f240));
  // PTX:348 ld.global.f32 %f243, [%rd40+460]
  f243 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (460)))));
  // PTX:349 fma.rn.f32 %f244, %f243, %f23, %f242
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f244) : "f"(f243), "f"(f23), "f"(f242));
  // PTX:350 ld.global.f32 %f245, [%rd40+464]
  f245 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (464)))));
  // PTX:351 fma.rn.f32 %f246, %f245, %f26, %f244
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f246) : "f"(f245), "f"(f26), "f"(f244));
  // PTX:352 ld.global.f32 %f247, [%rd40+468]
  f247 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (468)))));
  // PTX:353 fma.rn.f32 %f248, %f247, %f29, %f246
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f248) : "f"(f247), "f"(f29), "f"(f246));
  // PTX:354 ld.global.f32 %f249, [%rd40+472]
  f249 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (472)))));
  // PTX:355 fma.rn.f32 %f250, %f249, %f32, %f248
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f250) : "f"(f249), "f"(f32), "f"(f248));
  // PTX:356 ld.global.f32 %f251, [%rd40+476]
  f251 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (476)))));
  // PTX:357 fma.rn.f32 %f252, %f251, %f35, %f250
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f252) : "f"(f251), "f"(f35), "f"(f250));
  // PTX:358 add.s64 %rd44, %rd24, %rd36
  asm("add.s64 %0, %1, %2;" : "=l"(rd44) : "l"(rd24), "l"(rd36));
  // PTX:359 st.global.f32 [%rd44], %f252
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0))))) = (float)(f252);
  // PTX:360 ld.global.f32 %f253, [%rd40+480]
  f253 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (480)))));
  // PTX:361 fma.rn.f32 %f254, %f253, %f2, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f254) : "f"(f253), "f"(f2));
  // PTX:362 ld.global.f32 %f255, [%rd40+484]
  f255 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (484)))));
  // PTX:363 fma.rn.f32 %f256, %f255, %f5, %f254
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f256) : "f"(f255), "f"(f5), "f"(f254));
  // PTX:364 ld.global.f32 %f257, [%rd40+488]
  f257 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (488)))));
  // PTX:365 fma.rn.f32 %f258, %f257, %f8, %f256
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f258) : "f"(f257), "f"(f8), "f"(f256));
  // PTX:366 ld.global.f32 %f259, [%rd40+492]
  f259 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (492)))));
  // PTX:367 fma.rn.f32 %f260, %f259, %f11, %f258
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f260) : "f"(f259), "f"(f11), "f"(f258));
  // PTX:368 ld.global.f32 %f261, [%rd40+496]
  f261 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (496)))));
  // PTX:369 fma.rn.f32 %f262, %f261, %f14, %f260
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f262) : "f"(f261), "f"(f14), "f"(f260));
  // PTX:370 ld.global.f32 %f263, [%rd40+500]
  f263 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (500)))));
  // PTX:371 fma.rn.f32 %f264, %f263, %f17, %f262
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f264) : "f"(f263), "f"(f17), "f"(f262));
  // PTX:372 ld.global.f32 %f265, [%rd40+504]
  f265 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (504)))));
  // PTX:373 fma.rn.f32 %f266, %f265, %f20, %f264
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f266) : "f"(f265), "f"(f20), "f"(f264));
  // PTX:374 ld.global.f32 %f267, [%rd40+508]
  f267 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (508)))));
  // PTX:375 fma.rn.f32 %f268, %f267, %f23, %f266
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f268) : "f"(f267), "f"(f23), "f"(f266));
  // PTX:376 ld.global.f32 %f269, [%rd40+512]
  f269 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (512)))));
  // PTX:377 fma.rn.f32 %f270, %f269, %f26, %f268
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f270) : "f"(f269), "f"(f26), "f"(f268));
  // PTX:378 ld.global.f32 %f271, [%rd40+516]
  f271 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (516)))));
  // PTX:379 fma.rn.f32 %f272, %f271, %f29, %f270
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f272) : "f"(f271), "f"(f29), "f"(f270));
  // PTX:380 ld.global.f32 %f273, [%rd40+520]
  f273 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (520)))));
  // PTX:381 fma.rn.f32 %f274, %f273, %f32, %f272
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f274) : "f"(f273), "f"(f32), "f"(f272));
  // PTX:382 ld.global.f32 %f275, [%rd40+524]
  f275 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (524)))));
  // PTX:383 fma.rn.f32 %f276, %f275, %f35, %f274
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f276) : "f"(f275), "f"(f35), "f"(f274));
  // PTX:384 st.global.f32 [%rd44+4], %f276
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (4))))) = (float)(f276);
  // PTX:385 ld.global.f32 %f277, [%rd40+528]
  f277 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (528)))));
  // PTX:386 fma.rn.f32 %f278, %f277, %f2, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f278) : "f"(f277), "f"(f2));
  // PTX:387 ld.global.f32 %f279, [%rd40+532]
  f279 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (532)))));
  // PTX:388 fma.rn.f32 %f280, %f279, %f5, %f278
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f280) : "f"(f279), "f"(f5), "f"(f278));
  // PTX:389 ld.global.f32 %f281, [%rd40+536]
  f281 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (536)))));
  // PTX:390 fma.rn.f32 %f282, %f281, %f8, %f280
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f282) : "f"(f281), "f"(f8), "f"(f280));
  // PTX:391 ld.global.f32 %f283, [%rd40+540]
  f283 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (540)))));
  // PTX:392 fma.rn.f32 %f284, %f283, %f11, %f282
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f284) : "f"(f283), "f"(f11), "f"(f282));
  // PTX:393 ld.global.f32 %f285, [%rd40+544]
  f285 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (544)))));
  // PTX:394 fma.rn.f32 %f286, %f285, %f14, %f284
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f286) : "f"(f285), "f"(f14), "f"(f284));
  // PTX:395 ld.global.f32 %f287, [%rd40+548]
  f287 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (548)))));
  // PTX:396 fma.rn.f32 %f288, %f287, %f17, %f286
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f288) : "f"(f287), "f"(f17), "f"(f286));
  // PTX:397 ld.global.f32 %f289, [%rd40+552]
  f289 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (552)))));
  // PTX:398 fma.rn.f32 %f290, %f289, %f20, %f288
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f290) : "f"(f289), "f"(f20), "f"(f288));
  // PTX:399 ld.global.f32 %f291, [%rd40+556]
  f291 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (556)))));
  // PTX:400 fma.rn.f32 %f292, %f291, %f23, %f290
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f292) : "f"(f291), "f"(f23), "f"(f290));
  // PTX:401 ld.global.f32 %f293, [%rd40+560]
  f293 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (560)))));
  // PTX:402 fma.rn.f32 %f294, %f293, %f26, %f292
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f294) : "f"(f293), "f"(f26), "f"(f292));
  // PTX:403 ld.global.f32 %f295, [%rd40+564]
  f295 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (564)))));
  // PTX:404 fma.rn.f32 %f296, %f295, %f29, %f294
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f296) : "f"(f295), "f"(f29), "f"(f294));
  // PTX:405 ld.global.f32 %f297, [%rd40+568]
  f297 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (568)))));
  // PTX:406 fma.rn.f32 %f298, %f297, %f32, %f296
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f298) : "f"(f297), "f"(f32), "f"(f296));
  // PTX:407 ld.global.f32 %f299, [%rd40+572]
  f299 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (572)))));
  // PTX:408 fma.rn.f32 %f300, %f299, %f35, %f298
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f300) : "f"(f299), "f"(f35), "f"(f298));
  // PTX:409 st.global.f32 [%rd44+8], %f300
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (8))))) = (float)(f300);
  // PTX:411 $L__BB76_6:
L_BB76_6:;
  // PTX:412 ret
  return;
}
