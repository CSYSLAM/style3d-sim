// 机械还原自 PTX：synreal::kernel::apply_affine_body_torques(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 053d931f3eb6d95d9f7d2f7dc4c437561e62676e5e0ef5bc905af85c4ccad49a
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__apply_affine_body_torques(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60;
  // PTX:24 ld.param.u64 %rd12, [_ZN7synreal6kernel25apply_affine_body_torquesEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PS4_mmm_param_0]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:25 ld.param.u64 %rd13, [_ZN7synreal6kernel25apply_affine_body_torquesEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PS4_mmm_param_1]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:26 ld.param.u64 %rd14, [_ZN7synreal6kernel25apply_affine_body_torquesEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PS4_mmm_param_2]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:27 ld.param.u64 %rd15, [_ZN7synreal6kernel25apply_affine_body_torquesEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PS4_mmm_param_3]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:28 ld.param.u64 %rd19, [_ZN7synreal6kernel25apply_affine_body_torquesEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PS4_mmm_param_5]
  rd19 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:29 ld.param.u64 %rd17, [_ZN7synreal6kernel25apply_affine_body_torquesEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PS4_mmm_param_6]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:30 ld.param.u64 %rd18, [_ZN7synreal6kernel25apply_affine_body_torquesEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PS4_mmm_param_7]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:31 mov.u32 %r5, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r5) : "r"(blockIdx.x));
  // PTX:32 mov.u32 %r6, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r6) : "r"(blockDim.x));
  // PTX:33 mul.wide.u32 %rd20, %r5, %r6
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd20) : "r"(r5), "r"(r6));
  // PTX:34 mov.u32 %r7, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r7) : "r"(threadIdx.x));
  // PTX:35 cvt.u64.u32 %rd21, %r7
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd21) : "r"(r7));
  // PTX:36 add.s64 %rd1, %rd20, %rd21
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd20), "l"(rd21));
  // PTX:37 setp.ge.u64 %p1, %rd1, %rd19
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd19)));
  // PTX:38 @%p1 bra $L__BB28_13
  if (p1) { goto L_BB28_13; }
  // PTX:40 cvta.to.global.u64 %rd22, %rd15
  rd22 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd15));
  // PTX:41 mul.lo.s64 %rd23, %rd1, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd23) : "l"(rd1));
  // PTX:42 add.s64 %rd24, %rd22, %rd23
  asm("add.s64 %0, %1, %2;" : "=l"(rd24) : "l"(rd22), "l"(rd23));
  // PTX:43 ld.global.u32 %r1, [%rd24+4]
  r1 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (4)))));
  // PTX:44 ld.global.u32 %r2, [%rd24+8]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (8)))));
  // PTX:45 ld.global.f32 %f1, [%rd24]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (0)))));
  // PTX:46 abs.f32 %f27, %f1
  asm("abs.f32 %0, %1;" : "=f"(f27) : "f"(f1));
  // PTX:47 setp.gtu.f32 %p2, %f27, 0f2B8CBCCC
  p2 = ((isnan(((float)(f27))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) || (((float)(f27)) > ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:48 @%p2 bra $L__BB28_4
  if (p2) { goto L_BB28_4; }
  // PTX:50 mov.b32 %f28, %r1
  asm("mov.b32 %0, %1;" : "=f"(f28) : "r"(r1));
  // PTX:51 abs.f32 %f29, %f28
  asm("abs.f32 %0, %1;" : "=f"(f29) : "f"(f28));
  // PTX:52 setp.gtu.f32 %p3, %f29, 0f2B8CBCCC
  p3 = ((isnan(((float)(f29))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) || (((float)(f29)) > ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:53 @%p3 bra $L__BB28_4
  if (p3) { goto L_BB28_4; }
  // PTX:55 mov.b32 %f30, %r2
  asm("mov.b32 %0, %1;" : "=f"(f30) : "r"(r2));
  // PTX:56 abs.f32 %f31, %f30
  asm("abs.f32 %0, %1;" : "=f"(f31) : "f"(f30));
  // PTX:57 setp.le.f32 %p4, %f31, 0f2B8CBCCC
  p4 = (!(isnan(((float)(f31))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) && (((float)(f31)) <= ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:58 @%p4 bra $L__BB28_13
  if (p4) { goto L_BB28_13; }
  // PTX:60 $L__BB28_4:
L_BB28_4:;
  // PTX:61 or.b64 %rd25, %rd1, %rd17
  asm("or.b64 %0, %1, %2;" : "=l"(rd25) : "l"(rd1), "l"(rd17));
  // PTX:62 and.b64 %rd26, %rd25, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd26) : "l"(rd25));
  // PTX:63 setp.eq.s64 %p5, %rd26, 0
  p5 = (((long long)(rd26)) == ((long long)(0)));
  // PTX:64 @%p5 bra $L__BB28_6
  if (p5) { goto L_BB28_6; }
  // PTX:66 div.u64 %rd59, %rd1, %rd17
  asm("div.u64 %0, %1, %2;" : "=l"(rd59) : "l"(rd1), "l"(rd17));
  // PTX:67 mul.lo.s64 %rd27, %rd59, %rd17
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd59), "l"(rd17));
  // PTX:68 sub.s64 %rd60, %rd1, %rd27
  asm("sub.s64 %0, %1, %2;" : "=l"(rd60) : "l"(rd1), "l"(rd27));
  // PTX:69 bra.uni $L__BB28_7
  goto L_BB28_7;
  // PTX:71 $L__BB28_6:
L_BB28_6:;
  // PTX:72 cvt.u32.u64 %r8, %rd17
  asm("cvt.u32.u64 %0, %1;" : "=r"(r8) : "l"(rd17));
  // PTX:73 cvt.u32.u64 %r9, %rd1
  asm("cvt.u32.u64 %0, %1;" : "=r"(r9) : "l"(rd1));
  // PTX:74 div.u32 %r10, %r9, %r8
  asm("div.u32 %0, %1, %2;" : "=r"(r10) : "r"(r9), "r"(r8));
  // PTX:75 mul.lo.s32 %r11, %r10, %r8
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r11) : "r"(r10), "r"(r8));
  // PTX:76 sub.s32 %r12, %r9, %r11
  asm("sub.s32 %0, %1, %2;" : "=r"(r12) : "r"(r9), "r"(r11));
  // PTX:77 cvt.u64.u32 %rd59, %r10
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd59) : "r"(r10));
  // PTX:78 cvt.u64.u32 %rd60, %r12
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd60) : "r"(r12));
  // PTX:80 $L__BB28_7:
L_BB28_7:;
  // PTX:81 cvta.to.global.u64 %rd28, %rd12
  rd28 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd12));
  // PTX:82 mul.lo.s64 %rd29, %rd59, %rd18
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd29) : "l"(rd59), "l"(rd18));
  // PTX:83 cvt.u32.u64 %r3, %rd29
  asm("cvt.u32.u64 %0, %1;" : "=r"(r3) : "l"(rd29));
  // PTX:84 cvta.to.global.u64 %rd30, %rd13
  rd30 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd13));
  // PTX:85 shl.b64 %rd31, %rd60, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd31) : "l"(rd60));
  // PTX:86 add.s64 %rd8, %rd30, %rd31
  asm("add.s64 %0, %1, %2;" : "=l"(rd8) : "l"(rd30), "l"(rd31));
  // PTX:87 ld.global.u32 %r13, [%rd8+4]
  r13 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (4)))));
  // PTX:88 add.s32 %r14, %r13, %r3
  asm("add.s32 %0, %1, %2;" : "=r"(r14) : "r"(r13), "r"(r3));
  // PTX:89 ld.global.u32 %r15, [%rd8+8]
  r15 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (8)))));
  // PTX:90 add.s32 %r16, %r15, %r3
  asm("add.s32 %0, %1, %2;" : "=r"(r16) : "r"(r15), "r"(r3));
  // PTX:91 ld.global.u32 %r17, [%rd8+12]
  r17 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (12)))));
  // PTX:92 add.s32 %r18, %r17, %r3
  asm("add.s32 %0, %1, %2;" : "=r"(r18) : "r"(r17), "r"(r3));
  // PTX:93 cvt.s64.s32 %rd9, %r14
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd9) : "r"(r14));
  // PTX:94 mul.wide.s32 %rd32, %r14, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd32) : "r"(r14));
  // PTX:95 add.s64 %rd33, %rd28, %rd32
  asm("add.s64 %0, %1, %2;" : "=l"(rd33) : "l"(rd28), "l"(rd32));
  // PTX:96 cvt.s64.s32 %rd10, %r16
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd10) : "r"(r16));
  // PTX:97 mul.wide.s32 %rd34, %r16, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd34) : "r"(r16));
  // PTX:98 add.s64 %rd35, %rd28, %rd34
  asm("add.s64 %0, %1, %2;" : "=l"(rd35) : "l"(rd28), "l"(rd34));
  // PTX:99 cvt.s64.s32 %rd11, %r18
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd11) : "r"(r18));
  // PTX:100 mul.wide.s32 %rd36, %r18, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd36) : "r"(r18));
  // PTX:101 add.s64 %rd37, %rd28, %rd36
  asm("add.s64 %0, %1, %2;" : "=l"(rd37) : "l"(rd28), "l"(rd36));
  // PTX:102 cvta.to.global.u64 %rd38, %rd14
  rd38 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd14));
  // PTX:103 mul.lo.s64 %rd39, %rd60, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd39) : "l"(rd60));
  // PTX:104 add.s64 %rd40, %rd38, %rd39
  asm("add.s64 %0, %1, %2;" : "=l"(rd40) : "l"(rd38), "l"(rd39));
  // PTX:105 ld.global.f32 %f32, [%rd40+16]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (16)))));
  // PTX:106 ld.global.f32 %f33, [%rd40]
  f33 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (0)))));
  // PTX:107 add.f32 %f34, %f33, %f32
  asm("add.f32 %0, %1, %2;" : "=f"(f34) : "f"(f33), "f"(f32));
  // PTX:108 ld.global.f32 %f35, [%rd40+32]
  f35 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (32)))));
  // PTX:109 add.f32 %f36, %f34, %f35
  asm("add.f32 %0, %1, %2;" : "=f"(f36) : "f"(f34), "f"(f35));
  // PTX:110 mul.f32 %f37, %f36, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f37) : "f"(f36));
  // PTX:111 mul.f32 %f38, %f37, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f38) : "f"(f37));
  // PTX:112 sub.f32 %f39, %f37, %f33
  asm("sub.f32 %0, %1, %2;" : "=f"(f39) : "f"(f37), "f"(f33));
  // PTX:113 ld.global.f32 %f40, [%rd40+4]
  f40 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (4)))));
  // PTX:114 sub.f32 %f41, %f38, %f40
  asm("sub.f32 %0, %1, %2;" : "=f"(f41) : "f"(f38), "f"(f40));
  // PTX:115 ld.global.f32 %f42, [%rd40+8]
  f42 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (8)))));
  // PTX:116 sub.f32 %f43, %f38, %f42
  asm("sub.f32 %0, %1, %2;" : "=f"(f43) : "f"(f38), "f"(f42));
  // PTX:117 ld.global.f32 %f44, [%rd40+12]
  f44 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (12)))));
  // PTX:118 sub.f32 %f45, %f38, %f44
  asm("sub.f32 %0, %1, %2;" : "=f"(f45) : "f"(f38), "f"(f44));
  // PTX:119 sub.f32 %f46, %f37, %f32
  asm("sub.f32 %0, %1, %2;" : "=f"(f46) : "f"(f37), "f"(f32));
  // PTX:120 ld.global.f32 %f47, [%rd40+20]
  f47 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (20)))));
  // PTX:121 sub.f32 %f48, %f38, %f47
  asm("sub.f32 %0, %1, %2;" : "=f"(f48) : "f"(f38), "f"(f47));
  // PTX:122 ld.global.f32 %f49, [%rd40+24]
  f49 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (24)))));
  // PTX:123 sub.f32 %f50, %f38, %f49
  asm("sub.f32 %0, %1, %2;" : "=f"(f50) : "f"(f38), "f"(f49));
  // PTX:124 ld.global.f32 %f51, [%rd40+28]
  f51 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (28)))));
  // PTX:125 sub.f32 %f52, %f38, %f51
  asm("sub.f32 %0, %1, %2;" : "=f"(f52) : "f"(f38), "f"(f51));
  // PTX:126 sub.f32 %f53, %f37, %f35
  asm("sub.f32 %0, %1, %2;" : "=f"(f53) : "f"(f37), "f"(f35));
  // PTX:127 ld.global.f32 %f54, [%rd33]
  f54 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (0)))));
  // PTX:128 ld.global.f32 %f55, [%rd33+4]
  f55 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (4)))));
  // PTX:129 ld.global.f32 %f56, [%rd33+8]
  f56 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (8)))));
  // PTX:130 ld.global.f32 %f57, [%rd35]
  f57 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (0)))));
  // PTX:131 mul.f32 %f58, %f57, %f41
  asm("mul.f32 %0, %1, %2;" : "=f"(f58) : "f"(f57), "f"(f41));
  // PTX:132 ld.global.f32 %f59, [%rd35+4]
  f59 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (4)))));
  // PTX:133 mul.f32 %f60, %f59, %f41
  asm("mul.f32 %0, %1, %2;" : "=f"(f60) : "f"(f59), "f"(f41));
  // PTX:134 ld.global.f32 %f61, [%rd35+8]
  f61 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (8)))));
  // PTX:135 mul.f32 %f62, %f61, %f41
  asm("mul.f32 %0, %1, %2;" : "=f"(f62) : "f"(f61), "f"(f41));
  // PTX:136 fma.rn.f32 %f63, %f54, %f39, %f58
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f63) : "f"(f54), "f"(f39), "f"(f58));
  // PTX:137 fma.rn.f32 %f64, %f55, %f39, %f60
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f64) : "f"(f55), "f"(f39), "f"(f60));
  // PTX:138 fma.rn.f32 %f65, %f56, %f39, %f62
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f65) : "f"(f56), "f"(f39), "f"(f62));
  // PTX:139 ld.global.f32 %f66, [%rd37]
  f66 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (0)))));
  // PTX:140 ld.global.f32 %f67, [%rd37+4]
  f67 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (4)))));
  // PTX:141 ld.global.f32 %f68, [%rd37+8]
  f68 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (8)))));
  // PTX:142 fma.rn.f32 %f2, %f66, %f43, %f63
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f2) : "f"(f66), "f"(f43), "f"(f63));
  // PTX:143 fma.rn.f32 %f3, %f67, %f43, %f64
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f3) : "f"(f67), "f"(f43), "f"(f64));
  // PTX:144 fma.rn.f32 %f4, %f68, %f43, %f65
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f4) : "f"(f68), "f"(f43), "f"(f65));
  // PTX:145 mul.f32 %f69, %f57, %f46
  asm("mul.f32 %0, %1, %2;" : "=f"(f69) : "f"(f57), "f"(f46));
  // PTX:146 mul.f32 %f70, %f59, %f46
  asm("mul.f32 %0, %1, %2;" : "=f"(f70) : "f"(f59), "f"(f46));
  // PTX:147 mul.f32 %f71, %f61, %f46
  asm("mul.f32 %0, %1, %2;" : "=f"(f71) : "f"(f61), "f"(f46));
  // PTX:148 fma.rn.f32 %f72, %f54, %f45, %f69
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f72) : "f"(f54), "f"(f45), "f"(f69));
  // PTX:149 fma.rn.f32 %f73, %f55, %f45, %f70
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f73) : "f"(f55), "f"(f45), "f"(f70));
  // PTX:150 fma.rn.f32 %f74, %f56, %f45, %f71
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f74) : "f"(f56), "f"(f45), "f"(f71));
  // PTX:151 fma.rn.f32 %f5, %f66, %f48, %f72
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f5) : "f"(f66), "f"(f48), "f"(f72));
  // PTX:152 fma.rn.f32 %f6, %f67, %f48, %f73
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f6) : "f"(f67), "f"(f48), "f"(f73));
  // PTX:153 fma.rn.f32 %f7, %f68, %f48, %f74
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f7) : "f"(f68), "f"(f48), "f"(f74));
  // PTX:154 mul.f32 %f75, %f57, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f75) : "f"(f57), "f"(f52));
  // PTX:155 mul.f32 %f76, %f59, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f76) : "f"(f59), "f"(f52));
  // PTX:156 mul.f32 %f77, %f61, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f77) : "f"(f61), "f"(f52));
  // PTX:157 fma.rn.f32 %f78, %f54, %f50, %f75
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f78) : "f"(f54), "f"(f50), "f"(f75));
  // PTX:158 fma.rn.f32 %f79, %f55, %f50, %f76
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f79) : "f"(f55), "f"(f50), "f"(f76));
  // PTX:159 fma.rn.f32 %f80, %f56, %f50, %f77
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f80) : "f"(f56), "f"(f50), "f"(f77));
  // PTX:160 fma.rn.f32 %f8, %f66, %f53, %f78
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f8) : "f"(f66), "f"(f53), "f"(f78));
  // PTX:161 fma.rn.f32 %f9, %f67, %f53, %f79
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f9) : "f"(f67), "f"(f53), "f"(f79));
  // PTX:162 fma.rn.f32 %f10, %f68, %f53, %f80
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f10) : "f"(f68), "f"(f53), "f"(f80));
  // PTX:163 mul.f32 %f81, %f57, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f81) : "f"(f57), "f"(f5));
  // PTX:164 mul.f32 %f82, %f57, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f82) : "f"(f57), "f"(f6));
  // PTX:165 mul.f32 %f83, %f57, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f83) : "f"(f57), "f"(f7));
  // PTX:166 fma.rn.f32 %f84, %f54, %f2, %f81
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f84) : "f"(f54), "f"(f2), "f"(f81));
  // PTX:167 fma.rn.f32 %f85, %f54, %f3, %f82
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f85) : "f"(f54), "f"(f3), "f"(f82));
  // PTX:168 fma.rn.f32 %f86, %f54, %f4, %f83
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f86) : "f"(f54), "f"(f4), "f"(f83));
  // PTX:169 fma.rn.f32 %f87, %f66, %f8, %f84
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f87) : "f"(f66), "f"(f8), "f"(f84));
  // PTX:170 fma.rn.f32 %f88, %f66, %f9, %f85
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f88) : "f"(f66), "f"(f9), "f"(f85));
  // PTX:171 fma.rn.f32 %f89, %f66, %f10, %f86
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f89) : "f"(f66), "f"(f10), "f"(f86));
  // PTX:172 mul.f32 %f90, %f59, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f90) : "f"(f59), "f"(f5));
  // PTX:173 mul.f32 %f91, %f59, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f91) : "f"(f59), "f"(f6));
  // PTX:174 mul.f32 %f92, %f59, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f92) : "f"(f59), "f"(f7));
  // PTX:175 fma.rn.f32 %f93, %f55, %f2, %f90
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f93) : "f"(f55), "f"(f2), "f"(f90));
  // PTX:176 fma.rn.f32 %f94, %f55, %f3, %f91
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f94) : "f"(f55), "f"(f3), "f"(f91));
  // PTX:177 fma.rn.f32 %f95, %f55, %f4, %f92
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f95) : "f"(f55), "f"(f4), "f"(f92));
  // PTX:178 fma.rn.f32 %f96, %f67, %f8, %f93
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f96) : "f"(f67), "f"(f8), "f"(f93));
  // PTX:179 fma.rn.f32 %f97, %f67, %f9, %f94
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f97) : "f"(f67), "f"(f9), "f"(f94));
  // PTX:180 fma.rn.f32 %f98, %f67, %f10, %f95
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f98) : "f"(f67), "f"(f10), "f"(f95));
  // PTX:181 mul.f32 %f99, %f61, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f99) : "f"(f61), "f"(f5));
  // PTX:182 mul.f32 %f100, %f61, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f100) : "f"(f61), "f"(f6));
  // PTX:183 mul.f32 %f101, %f61, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f101) : "f"(f61), "f"(f7));
  // PTX:184 fma.rn.f32 %f102, %f56, %f2, %f99
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f102) : "f"(f56), "f"(f2), "f"(f99));
  // PTX:185 fma.rn.f32 %f103, %f56, %f3, %f100
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f103) : "f"(f56), "f"(f3), "f"(f100));
  // PTX:186 fma.rn.f32 %f104, %f56, %f4, %f101
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f104) : "f"(f56), "f"(f4), "f"(f101));
  // PTX:187 fma.rn.f32 %f105, %f68, %f8, %f102
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f105) : "f"(f68), "f"(f8), "f"(f102));
  // PTX:188 fma.rn.f32 %f106, %f68, %f9, %f103
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f106) : "f"(f68), "f"(f9), "f"(f103));
  // PTX:189 fma.rn.f32 %f107, %f68, %f10, %f104
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f107) : "f"(f68), "f"(f10), "f"(f104));
  // PTX:190 add.f32 %f108, %f87, %f97
  asm("add.f32 %0, %1, %2;" : "=f"(f108) : "f"(f87), "f"(f97));
  // PTX:191 add.f32 %f109, %f107, %f108
  asm("add.f32 %0, %1, %2;" : "=f"(f109) : "f"(f107), "f"(f108));
  // PTX:192 mul.f32 %f110, %f109, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f110) : "f"(f109));
  // PTX:193 sub.f32 %f11, %f109, %f87
  asm("sub.f32 %0, %1, %2;" : "=f"(f11) : "f"(f109), "f"(f87));
  // PTX:194 sub.f32 %f12, %f110, %f88
  asm("sub.f32 %0, %1, %2;" : "=f"(f12) : "f"(f110), "f"(f88));
  // PTX:195 sub.f32 %f13, %f110, %f89
  asm("sub.f32 %0, %1, %2;" : "=f"(f13) : "f"(f110), "f"(f89));
  // PTX:196 sub.f32 %f14, %f110, %f96
  asm("sub.f32 %0, %1, %2;" : "=f"(f14) : "f"(f110), "f"(f96));
  // PTX:197 sub.f32 %f15, %f109, %f97
  asm("sub.f32 %0, %1, %2;" : "=f"(f15) : "f"(f109), "f"(f97));
  // PTX:198 sub.f32 %f16, %f110, %f98
  asm("sub.f32 %0, %1, %2;" : "=f"(f16) : "f"(f110), "f"(f98));
  // PTX:199 sub.f32 %f17, %f110, %f105
  asm("sub.f32 %0, %1, %2;" : "=f"(f17) : "f"(f110), "f"(f105));
  // PTX:200 sub.f32 %f18, %f110, %f106
  asm("sub.f32 %0, %1, %2;" : "=f"(f18) : "f"(f110), "f"(f106));
  // PTX:201 sub.f32 %f19, %f109, %f107
  asm("sub.f32 %0, %1, %2;" : "=f"(f19) : "f"(f109), "f"(f107));
  // PTX:202 mul.f32 %f111, %f15, %f19
  asm("mul.f32 %0, %1, %2;" : "=f"(f111) : "f"(f15), "f"(f19));
  // PTX:203 mul.f32 %f112, %f18, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f112) : "f"(f18), "f"(f16));
  // PTX:204 sub.f32 %f20, %f111, %f112
  asm("sub.f32 %0, %1, %2;" : "=f"(f20) : "f"(f111), "f"(f112));
  // PTX:205 mul.f32 %f113, %f16, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f113) : "f"(f16), "f"(f17));
  // PTX:206 mul.f32 %f114, %f19, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f114) : "f"(f19), "f"(f14));
  // PTX:207 sub.f32 %f21, %f113, %f114
  asm("sub.f32 %0, %1, %2;" : "=f"(f21) : "f"(f113), "f"(f114));
  // PTX:208 mul.f32 %f115, %f14, %f18
  asm("mul.f32 %0, %1, %2;" : "=f"(f115) : "f"(f14), "f"(f18));
  // PTX:209 mul.f32 %f116, %f15, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f116) : "f"(f15), "f"(f17));
  // PTX:210 sub.f32 %f22, %f115, %f116
  asm("sub.f32 %0, %1, %2;" : "=f"(f22) : "f"(f115), "f"(f116));
  // PTX:211 mul.f32 %f117, %f12, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f117) : "f"(f12), "f"(f21));
  // PTX:212 fma.rn.f32 %f118, %f11, %f20, %f117
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f118) : "f"(f11), "f"(f20), "f"(f117));
  // PTX:213 fma.rn.f32 %f23, %f13, %f22, %f118
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f23) : "f"(f13), "f"(f22), "f"(f118));
  // PTX:214 setp.leu.f32 %p6, %f23, 0f0DA24260
  p6 = ((isnan(((float)(f23))) || isnan(((float)(as_f32(0x0DA24260u))))) || (((float)(f23)) <= ((float)(as_f32(0x0DA24260u)))));
  // PTX:215 @%p6 bra $L__BB28_13
  if (p6) { goto L_BB28_13; }
  // PTX:217 ld.global.u32 %r19, [%rd8]
  r19 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd8) + (0)))));
  // PTX:218 abs.f32 %f119, %f23
  asm("abs.f32 %0, %1;" : "=f"(f119) : "f"(f23));
  // PTX:219 setp.geu.f32 %p7, %f119, 0f7F800000
  p7 = ((isnan(((float)(f119))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f119)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:220 add.s32 %r4, %r19, %r3
  asm("add.s32 %0, %1, %2;" : "=r"(r4) : "r"(r19), "r"(r3));
  // PTX:221 @%p7 bra $L__BB28_13
  if (p7) { goto L_BB28_13; }
  // PTX:223 mul.f32 %f206, %f15, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f206) : "f"(f15), "f"(f17));
  // PTX:224 mul.f32 %f205, %f14, %f18
  asm("mul.f32 %0, %1, %2;" : "=f"(f205) : "f"(f14), "f"(f18));
  // PTX:225 sub.f32 %f204, %f205, %f206
  asm("sub.f32 %0, %1, %2;" : "=f"(f204) : "f"(f205), "f"(f206));
  // PTX:226 mul.f32 %f203, %f19, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f203) : "f"(f19), "f"(f14));
  // PTX:227 mul.f32 %f202, %f16, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f202) : "f"(f16), "f"(f17));
  // PTX:228 sub.f32 %f201, %f202, %f203
  asm("sub.f32 %0, %1, %2;" : "=f"(f201) : "f"(f202), "f"(f203));
  // PTX:229 mul.f32 %f200, %f18, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f200) : "f"(f18), "f"(f16));
  // PTX:230 mul.f32 %f199, %f15, %f19
  asm("mul.f32 %0, %1, %2;" : "=f"(f199) : "f"(f15), "f"(f19));
  // PTX:231 sub.f32 %f198, %f199, %f200
  asm("sub.f32 %0, %1, %2;" : "=f"(f198) : "f"(f199), "f"(f200));
  // PTX:232 rcp.rn.f32 %f120, %f23
  asm("rcp.rn.f32 %0, %1;" : "=f"(f120) : "f"(f23));
  // PTX:233 mul.f32 %f121, %f19, %f12
  asm("mul.f32 %0, %1, %2;" : "=f"(f121) : "f"(f19), "f"(f12));
  // PTX:234 mul.f32 %f122, %f18, %f13
  asm("mul.f32 %0, %1, %2;" : "=f"(f122) : "f"(f18), "f"(f13));
  // PTX:235 sub.f32 %f123, %f122, %f121
  asm("sub.f32 %0, %1, %2;" : "=f"(f123) : "f"(f122), "f"(f121));
  // PTX:236 mul.f32 %f124, %f13, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f124) : "f"(f13), "f"(f17));
  // PTX:237 mul.f32 %f125, %f19, %f11
  asm("mul.f32 %0, %1, %2;" : "=f"(f125) : "f"(f19), "f"(f11));
  // PTX:238 sub.f32 %f126, %f125, %f124
  asm("sub.f32 %0, %1, %2;" : "=f"(f126) : "f"(f125), "f"(f124));
  // PTX:239 mul.f32 %f127, %f11, %f18
  asm("mul.f32 %0, %1, %2;" : "=f"(f127) : "f"(f11), "f"(f18));
  // PTX:240 mul.f32 %f128, %f17, %f12
  asm("mul.f32 %0, %1, %2;" : "=f"(f128) : "f"(f17), "f"(f12));
  // PTX:241 sub.f32 %f129, %f128, %f127
  asm("sub.f32 %0, %1, %2;" : "=f"(f129) : "f"(f128), "f"(f127));
  // PTX:242 mul.f32 %f130, %f15, %f13
  asm("mul.f32 %0, %1, %2;" : "=f"(f130) : "f"(f15), "f"(f13));
  // PTX:243 mul.f32 %f131, %f12, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f131) : "f"(f12), "f"(f16));
  // PTX:244 sub.f32 %f132, %f131, %f130
  asm("sub.f32 %0, %1, %2;" : "=f"(f132) : "f"(f131), "f"(f130));
  // PTX:245 mul.f32 %f133, %f11, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f133) : "f"(f11), "f"(f16));
  // PTX:246 mul.f32 %f134, %f13, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f134) : "f"(f13), "f"(f14));
  // PTX:247 sub.f32 %f135, %f134, %f133
  asm("sub.f32 %0, %1, %2;" : "=f"(f135) : "f"(f134), "f"(f133));
  // PTX:248 mul.f32 %f136, %f14, %f12
  asm("mul.f32 %0, %1, %2;" : "=f"(f136) : "f"(f14), "f"(f12));
  // PTX:249 mul.f32 %f137, %f11, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f137) : "f"(f11), "f"(f15));
  // PTX:250 sub.f32 %f138, %f137, %f136
  asm("sub.f32 %0, %1, %2;" : "=f"(f138) : "f"(f137), "f"(f136));
  // PTX:251 mul.f32 %f139, %f198, %f120
  asm("mul.f32 %0, %1, %2;" : "=f"(f139) : "f"(f198), "f"(f120));
  // PTX:252 mul.f32 %f140, %f201, %f120
  asm("mul.f32 %0, %1, %2;" : "=f"(f140) : "f"(f201), "f"(f120));
  // PTX:253 mul.f32 %f141, %f204, %f120
  asm("mul.f32 %0, %1, %2;" : "=f"(f141) : "f"(f204), "f"(f120));
  // PTX:254 mul.f32 %f142, %f123, %f120
  asm("mul.f32 %0, %1, %2;" : "=f"(f142) : "f"(f123), "f"(f120));
  // PTX:255 mul.f32 %f143, %f126, %f120
  asm("mul.f32 %0, %1, %2;" : "=f"(f143) : "f"(f126), "f"(f120));
  // PTX:256 mul.f32 %f144, %f129, %f120
  asm("mul.f32 %0, %1, %2;" : "=f"(f144) : "f"(f129), "f"(f120));
  // PTX:257 mul.f32 %f145, %f132, %f120
  asm("mul.f32 %0, %1, %2;" : "=f"(f145) : "f"(f132), "f"(f120));
  // PTX:258 mul.f32 %f146, %f135, %f120
  asm("mul.f32 %0, %1, %2;" : "=f"(f146) : "f"(f135), "f"(f120));
  // PTX:259 mul.f32 %f147, %f138, %f120
  asm("mul.f32 %0, %1, %2;" : "=f"(f147) : "f"(f138), "f"(f120));
  // PTX:260 mov.b32 %f148, %r1
  asm("mov.b32 %0, %1;" : "=f"(f148) : "r"(r1));
  // PTX:261 mul.f32 %f149, %f140, %f148
  asm("mul.f32 %0, %1, %2;" : "=f"(f149) : "f"(f140), "f"(f148));
  // PTX:262 mul.f32 %f150, %f143, %f148
  asm("mul.f32 %0, %1, %2;" : "=f"(f150) : "f"(f143), "f"(f148));
  // PTX:263 mul.f32 %f151, %f146, %f148
  asm("mul.f32 %0, %1, %2;" : "=f"(f151) : "f"(f146), "f"(f148));
  // PTX:264 fma.rn.f32 %f152, %f1, %f139, %f149
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f152) : "f"(f1), "f"(f139), "f"(f149));
  // PTX:265 fma.rn.f32 %f153, %f1, %f142, %f150
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f153) : "f"(f1), "f"(f142), "f"(f150));
  // PTX:266 fma.rn.f32 %f154, %f1, %f145, %f151
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f154) : "f"(f1), "f"(f145), "f"(f151));
  // PTX:267 mov.b32 %f155, %r2
  asm("mov.b32 %0, %1;" : "=f"(f155) : "r"(r2));
  // PTX:268 fma.rn.f32 %f24, %f141, %f155, %f152
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f24) : "f"(f141), "f"(f155), "f"(f152));
  // PTX:269 fma.rn.f32 %f25, %f144, %f155, %f153
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f25) : "f"(f144), "f"(f155), "f"(f153));
  // PTX:270 fma.rn.f32 %f26, %f147, %f155, %f154
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f26) : "f"(f147), "f"(f155), "f"(f154));
  // PTX:271 abs.f32 %f156, %f24
  asm("abs.f32 %0, %1;" : "=f"(f156) : "f"(f24));
  // PTX:272 setp.geu.f32 %p8, %f156, 0f7F800000
  p8 = ((isnan(((float)(f156))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f156)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:273 @%p8 bra $L__BB28_13
  if (p8) { goto L_BB28_13; }
  // PTX:275 abs.f32 %f157, %f25
  asm("abs.f32 %0, %1;" : "=f"(f157) : "f"(f25));
  // PTX:276 setp.geu.f32 %p9, %f157, 0f7F800000
  p9 = ((isnan(((float)(f157))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f157)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:277 @%p9 bra $L__BB28_13
  if (p9) { goto L_BB28_13; }
  // PTX:279 abs.f32 %f158, %f26
  asm("abs.f32 %0, %1;" : "=f"(f158) : "f"(f26));
  // PTX:280 setp.geu.f32 %p10, %f158, 0f7F800000
  p10 = ((isnan(((float)(f158))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f158)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:281 @%p10 bra $L__BB28_13
  if (p10) { goto L_BB28_13; }
  // PTX:283 ld.param.u64 %rd58, [_ZN7synreal6kernel25apply_affine_body_torquesEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS1_3matILi3ELi3EfLS3_0EEES6_PS4_mmm_param_4]
  rd58 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:284 cvta.to.global.u64 %rd41, %rd58
  rd41 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd58));
  // PTX:285 mul.f32 %f159, %f4, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f159) : "f"(f4), "f"(f25));
  // PTX:286 mul.f32 %f160, %f3, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f160) : "f"(f3), "f"(f26));
  // PTX:287 sub.f32 %f161, %f159, %f160
  asm("sub.f32 %0, %1, %2;" : "=f"(f161) : "f"(f159), "f"(f160));
  // PTX:288 mul.f32 %f162, %f4, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f162) : "f"(f4), "f"(f24));
  // PTX:289 mul.f32 %f163, %f2, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f163) : "f"(f2), "f"(f26));
  // PTX:290 sub.f32 %f164, %f163, %f162
  asm("sub.f32 %0, %1, %2;" : "=f"(f164) : "f"(f163), "f"(f162));
  // PTX:291 mul.f32 %f165, %f2, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f165) : "f"(f2), "f"(f25));
  // PTX:292 mul.f32 %f166, %f3, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f166) : "f"(f3), "f"(f24));
  // PTX:293 sub.f32 %f167, %f166, %f165
  asm("sub.f32 %0, %1, %2;" : "=f"(f167) : "f"(f166), "f"(f165));
  // PTX:294 mul.f32 %f168, %f6, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f168) : "f"(f6), "f"(f26));
  // PTX:295 mul.f32 %f169, %f7, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f169) : "f"(f7), "f"(f25));
  // PTX:296 sub.f32 %f170, %f169, %f168
  asm("sub.f32 %0, %1, %2;" : "=f"(f170) : "f"(f169), "f"(f168));
  // PTX:297 mul.f32 %f171, %f7, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f171) : "f"(f7), "f"(f24));
  // PTX:298 mul.f32 %f172, %f5, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f172) : "f"(f5), "f"(f26));
  // PTX:299 sub.f32 %f173, %f172, %f171
  asm("sub.f32 %0, %1, %2;" : "=f"(f173) : "f"(f172), "f"(f171));
  // PTX:300 mul.f32 %f174, %f5, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f174) : "f"(f5), "f"(f25));
  // PTX:301 mul.f32 %f175, %f6, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f175) : "f"(f6), "f"(f24));
  // PTX:302 sub.f32 %f176, %f175, %f174
  asm("sub.f32 %0, %1, %2;" : "=f"(f176) : "f"(f175), "f"(f174));
  // PTX:303 mul.f32 %f177, %f9, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f177) : "f"(f9), "f"(f26));
  // PTX:304 mul.f32 %f178, %f10, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f178) : "f"(f10), "f"(f25));
  // PTX:305 sub.f32 %f179, %f178, %f177
  asm("sub.f32 %0, %1, %2;" : "=f"(f179) : "f"(f178), "f"(f177));
  // PTX:306 mul.f32 %f180, %f10, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f180) : "f"(f10), "f"(f24));
  // PTX:307 mul.f32 %f181, %f8, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f181) : "f"(f8), "f"(f26));
  // PTX:308 sub.f32 %f182, %f181, %f180
  asm("sub.f32 %0, %1, %2;" : "=f"(f182) : "f"(f181), "f"(f180));
  // PTX:309 mul.f32 %f183, %f8, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f183) : "f"(f8), "f"(f25));
  // PTX:310 mul.f32 %f184, %f9, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f184) : "f"(f9), "f"(f24));
  // PTX:311 sub.f32 %f185, %f184, %f183
  asm("sub.f32 %0, %1, %2;" : "=f"(f185) : "f"(f184), "f"(f183));
  // PTX:312 mul.wide.s32 %rd42, %r4, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd42) : "r"(r4));
  // PTX:313 add.s64 %rd43, %rd41, %rd42
  asm("add.s64 %0, %1, %2;" : "=l"(rd43) : "l"(rd41), "l"(rd42));
  // PTX:314 red.global.add.f32 [%rd43], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:315 add.s64 %rd44, %rd43, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd44) : "l"(rd43));
  // PTX:316 red.global.add.f32 [%rd44], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:317 add.s64 %rd45, %rd43, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd45) : "l"(rd43));
  // PTX:318 red.global.add.f32 [%rd45], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:319 mul.lo.s64 %rd46, %rd9, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd46) : "l"(rd9));
  // PTX:320 add.s64 %rd47, %rd41, %rd46
  asm("add.s64 %0, %1, %2;" : "=l"(rd47) : "l"(rd41), "l"(rd46));
  // PTX:321 red.global.add.f32 [%rd47], %f161
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))), (float)(f161));
  // PTX:322 add.s64 %rd48, %rd47, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd48) : "l"(rd47));
  // PTX:323 red.global.add.f32 [%rd48], %f164
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))), (float)(f164));
  // PTX:324 add.s64 %rd49, %rd47, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd49) : "l"(rd47));
  // PTX:325 red.global.add.f32 [%rd49], %f167
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))), (float)(f167));
  // PTX:326 mul.lo.s64 %rd50, %rd10, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd50) : "l"(rd10));
  // PTX:327 add.s64 %rd51, %rd41, %rd50
  asm("add.s64 %0, %1, %2;" : "=l"(rd51) : "l"(rd41), "l"(rd50));
  // PTX:328 red.global.add.f32 [%rd51], %f170
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))), (float)(f170));
  // PTX:329 add.s64 %rd52, %rd51, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd52) : "l"(rd51));
  // PTX:330 red.global.add.f32 [%rd52], %f173
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))), (float)(f173));
  // PTX:331 add.s64 %rd53, %rd51, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd53) : "l"(rd51));
  // PTX:332 red.global.add.f32 [%rd53], %f176
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))), (float)(f176));
  // PTX:333 mul.lo.s64 %rd54, %rd11, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd54) : "l"(rd11));
  // PTX:334 add.s64 %rd55, %rd41, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd55) : "l"(rd41), "l"(rd54));
  // PTX:335 red.global.add.f32 [%rd55], %f179
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))), (float)(f179));
  // PTX:336 add.s64 %rd56, %rd55, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd56) : "l"(rd55));
  // PTX:337 red.global.add.f32 [%rd56], %f182
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))), (float)(f182));
  // PTX:338 add.s64 %rd57, %rd55, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd57) : "l"(rd55));
  // PTX:339 red.global.add.f32 [%rd57], %f185
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))), (float)(f185));
  // PTX:341 $L__BB28_13:
L_BB28_13:;
  // PTX:342 ret
  return;
}
