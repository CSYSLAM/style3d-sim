// 机械还原自 PTX：synreal::kernel::add_triangle_drag_preconditioner(glm::vec<3, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 0e1fe1426269e9a71da1a276832a66ad52326e5605f02d19a36f329fde8f4a1c
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__add_triangle_drag_preconditioner(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6) {
  int p0, p1, p2;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62;
  // PTX:23 ld.param.u64 %rd8, [_ZN7synreal6kernel32add_triangle_drag_preconditionerEPKN3glm3vecILi3EiLNS1_9qualifierE0EEEPKNS2_ILi3EfLS3_0EEEPKfPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_0]
  rd8 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:24 ld.param.u64 %rd9, [_ZN7synreal6kernel32add_triangle_drag_preconditionerEPKN3glm3vecILi3EiLNS1_9qualifierE0EEEPKNS2_ILi3EfLS3_0EEEPKfPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_1]
  rd9 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:25 ld.param.u64 %rd10, [_ZN7synreal6kernel32add_triangle_drag_preconditionerEPKN3glm3vecILi3EiLNS1_9qualifierE0EEEPKNS2_ILi3EfLS3_0EEEPKfPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_2]
  rd10 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:26 ld.param.u64 %rd11, [_ZN7synreal6kernel32add_triangle_drag_preconditionerEPKN3glm3vecILi3EiLNS1_9qualifierE0EEEPKNS2_ILi3EfLS3_0EEEPKfPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_3]
  rd11 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:27 ld.param.u64 %rd14, [_ZN7synreal6kernel32add_triangle_drag_preconditionerEPKN3glm3vecILi3EiLNS1_9qualifierE0EEEPKNS2_ILi3EfLS3_0EEEPKfPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_4]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:28 ld.param.u64 %rd12, [_ZN7synreal6kernel32add_triangle_drag_preconditionerEPKN3glm3vecILi3EiLNS1_9qualifierE0EEEPKNS2_ILi3EfLS3_0EEEPKfPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_5]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:29 ld.param.u64 %rd13, [_ZN7synreal6kernel32add_triangle_drag_preconditionerEPKN3glm3vecILi3EiLNS1_9qualifierE0EEEPKNS2_ILi3EfLS3_0EEEPKfPNS1_3matILi3ELi3EfLS3_0EEEmmm_param_6]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:30 mov.u32 %r1, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r1) : "r"(blockIdx.x));
  // PTX:31 mov.u32 %r2, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockDim.x));
  // PTX:32 mul.wide.u32 %rd15, %r1, %r2
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd15) : "r"(r1), "r"(r2));
  // PTX:33 mov.u32 %r3, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(threadIdx.x));
  // PTX:34 cvt.u64.u32 %rd16, %r3
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd16) : "r"(r3));
  // PTX:35 add.s64 %rd1, %rd15, %rd16
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd15), "l"(rd16));
  // PTX:36 setp.ge.u64 %p1, %rd1, %rd14
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd14)));
  // PTX:37 @%p1 bra $L__BB42_5
  if (p1) { goto L_BB42_5; }
  // PTX:39 or.b64 %rd17, %rd1, %rd12
  asm("or.b64 %0, %1, %2;" : "=l"(rd17) : "l"(rd1), "l"(rd12));
  // PTX:40 and.b64 %rd18, %rd17, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd18) : "l"(rd17));
  // PTX:41 setp.eq.s64 %p2, %rd18, 0
  p2 = (((long long)(rd18)) == ((long long)(0)));
  // PTX:42 @%p2 bra $L__BB42_3
  if (p2) { goto L_BB42_3; }
  // PTX:44 div.u64 %rd61, %rd1, %rd12
  asm("div.u64 %0, %1, %2;" : "=l"(rd61) : "l"(rd1), "l"(rd12));
  // PTX:45 mul.lo.s64 %rd19, %rd61, %rd12
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd61), "l"(rd12));
  // PTX:46 sub.s64 %rd62, %rd1, %rd19
  asm("sub.s64 %0, %1, %2;" : "=l"(rd62) : "l"(rd1), "l"(rd19));
  // PTX:47 bra.uni $L__BB42_4
  goto L_BB42_4;
  // PTX:49 $L__BB42_3:
L_BB42_3:;
  // PTX:50 cvt.u32.u64 %r4, %rd12
  asm("cvt.u32.u64 %0, %1;" : "=r"(r4) : "l"(rd12));
  // PTX:51 cvt.u32.u64 %r5, %rd1
  asm("cvt.u32.u64 %0, %1;" : "=r"(r5) : "l"(rd1));
  // PTX:52 div.u32 %r6, %r5, %r4
  asm("div.u32 %0, %1, %2;" : "=r"(r6) : "r"(r5), "r"(r4));
  // PTX:53 mul.lo.s32 %r7, %r6, %r4
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r7) : "r"(r6), "r"(r4));
  // PTX:54 sub.s32 %r8, %r5, %r7
  asm("sub.s32 %0, %1, %2;" : "=r"(r8) : "r"(r5), "r"(r7));
  // PTX:55 cvt.u64.u32 %rd61, %r6
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd61) : "r"(r6));
  // PTX:56 cvt.u64.u32 %rd62, %r8
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd62) : "r"(r8));
  // PTX:58 $L__BB42_4:
L_BB42_4:;
  // PTX:59 cvta.to.global.u64 %rd20, %rd11
  rd20 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd11));
  // PTX:60 cvta.to.global.u64 %rd21, %rd8
  rd21 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd8));
  // PTX:61 mul.lo.s64 %rd22, %rd62, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd22) : "l"(rd62));
  // PTX:62 add.s64 %rd23, %rd21, %rd22
  asm("add.s64 %0, %1, %2;" : "=l"(rd23) : "l"(rd21), "l"(rd22));
  // PTX:63 ld.global.u32 %r9, [%rd23+4]
  r9 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (4)))));
  // PTX:64 ld.global.u32 %r10, [%rd23+8]
  r10 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (8)))));
  // PTX:65 cvta.to.global.u64 %rd24, %rd9
  rd24 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd9));
  // PTX:66 mul.lo.s64 %rd25, %rd1, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd25) : "l"(rd1));
  // PTX:67 add.s64 %rd26, %rd24, %rd25
  asm("add.s64 %0, %1, %2;" : "=l"(rd26) : "l"(rd24), "l"(rd25));
  // PTX:68 ld.global.f32 %f1, [%rd26]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (0)))));
  // PTX:69 mul.f32 %f2, %f1, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f2) : "f"(f1), "f"(f1));
  // PTX:70 ld.global.f32 %f3, [%rd26+4]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (4)))));
  // PTX:71 mul.f32 %f4, %f3, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f4) : "f"(f3), "f"(f1));
  // PTX:72 ld.global.f32 %f5, [%rd26+8]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (8)))));
  // PTX:73 mul.f32 %f6, %f5, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f6) : "f"(f5), "f"(f1));
  // PTX:74 mul.f32 %f7, %f3, %f3
  asm("mul.f32 %0, %1, %2;" : "=f"(f7) : "f"(f3), "f"(f3));
  // PTX:75 mul.f32 %f8, %f5, %f3
  asm("mul.f32 %0, %1, %2;" : "=f"(f8) : "f"(f5), "f"(f3));
  // PTX:76 mul.f32 %f9, %f5, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f9) : "f"(f5), "f"(f5));
  // PTX:77 mul.lo.s64 %rd27, %rd61, %rd13
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd61), "l"(rd13));
  // PTX:78 cvt.u32.u64 %r11, %rd27
  asm("cvt.u32.u64 %0, %1;" : "=r"(r11) : "l"(rd27));
  // PTX:79 cvta.to.global.u64 %rd28, %rd10
  rd28 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd10));
  // PTX:80 shl.b64 %rd29, %rd1, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd29) : "l"(rd1));
  // PTX:81 add.s64 %rd30, %rd28, %rd29
  asm("add.s64 %0, %1, %2;" : "=l"(rd30) : "l"(rd28), "l"(rd29));
  // PTX:82 ld.global.f32 %f10, [%rd30]
  f10 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0)))));
  // PTX:83 mul.f32 %f11, %f10, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f11) : "f"(f10), "f"(f2));
  // PTX:84 mul.f32 %f12, %f10, %f4
  asm("mul.f32 %0, %1, %2;" : "=f"(f12) : "f"(f10), "f"(f4));
  // PTX:85 mul.f32 %f13, %f10, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f13) : "f"(f10), "f"(f6));
  // PTX:86 mul.f32 %f14, %f10, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f14) : "f"(f10), "f"(f7));
  // PTX:87 mul.f32 %f15, %f10, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f15) : "f"(f10), "f"(f8));
  // PTX:88 mul.f32 %f16, %f10, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f16) : "f"(f10), "f"(f9));
  // PTX:89 ld.global.u32 %r12, [%rd23]
  r12 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (0)))));
  // PTX:90 add.s32 %r13, %r12, %r11
  asm("add.s32 %0, %1, %2;" : "=r"(r13) : "r"(r12), "r"(r11));
  // PTX:91 mul.wide.s32 %rd31, %r13, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd31) : "r"(r13));
  // PTX:92 add.s64 %rd32, %rd20, %rd31
  asm("add.s64 %0, %1, %2;" : "=l"(rd32) : "l"(rd20), "l"(rd31));
  // PTX:93 red.global.add.f32 [%rd32], %f11
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd32) + (0)))), (float)(f11));
  // PTX:94 add.s64 %rd33, %rd32, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd33) : "l"(rd32));
  // PTX:95 red.global.add.f32 [%rd33], %f12
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (0)))), (float)(f12));
  // PTX:96 add.s64 %rd34, %rd32, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd34) : "l"(rd32));
  // PTX:97 red.global.add.f32 [%rd34], %f13
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (0)))), (float)(f13));
  // PTX:98 add.s64 %rd35, %rd32, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd35) : "l"(rd32));
  // PTX:99 red.global.add.f32 [%rd35], %f12
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (0)))), (float)(f12));
  // PTX:100 add.s64 %rd36, %rd32, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd36) : "l"(rd32));
  // PTX:101 red.global.add.f32 [%rd36], %f14
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd36) + (0)))), (float)(f14));
  // PTX:102 add.s64 %rd37, %rd32, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd37) : "l"(rd32));
  // PTX:103 red.global.add.f32 [%rd37], %f15
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (0)))), (float)(f15));
  // PTX:104 add.s64 %rd38, %rd32, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd38) : "l"(rd32));
  // PTX:105 red.global.add.f32 [%rd38], %f13
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (0)))), (float)(f13));
  // PTX:106 add.s64 %rd39, %rd32, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd39) : "l"(rd32));
  // PTX:107 red.global.add.f32 [%rd39], %f15
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (0)))), (float)(f15));
  // PTX:108 add.s64 %rd40, %rd32, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd40) : "l"(rd32));
  // PTX:109 red.global.add.f32 [%rd40], %f16
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (0)))), (float)(f16));
  // PTX:110 add.s32 %r14, %r9, %r11
  asm("add.s32 %0, %1, %2;" : "=r"(r14) : "r"(r9), "r"(r11));
  // PTX:111 mul.wide.s32 %rd41, %r14, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd41) : "r"(r14));
  // PTX:112 add.s64 %rd42, %rd20, %rd41
  asm("add.s64 %0, %1, %2;" : "=l"(rd42) : "l"(rd20), "l"(rd41));
  // PTX:113 red.global.add.f32 [%rd42], %f11
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (0)))), (float)(f11));
  // PTX:114 add.s64 %rd43, %rd42, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd43) : "l"(rd42));
  // PTX:115 red.global.add.f32 [%rd43], %f12
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (0)))), (float)(f12));
  // PTX:116 add.s64 %rd44, %rd42, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd44) : "l"(rd42));
  // PTX:117 red.global.add.f32 [%rd44], %f13
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))), (float)(f13));
  // PTX:118 add.s64 %rd45, %rd42, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd45) : "l"(rd42));
  // PTX:119 red.global.add.f32 [%rd45], %f12
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))), (float)(f12));
  // PTX:120 add.s64 %rd46, %rd42, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd46) : "l"(rd42));
  // PTX:121 red.global.add.f32 [%rd46], %f14
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (0)))), (float)(f14));
  // PTX:122 add.s64 %rd47, %rd42, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd47) : "l"(rd42));
  // PTX:123 red.global.add.f32 [%rd47], %f15
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))), (float)(f15));
  // PTX:124 add.s64 %rd48, %rd42, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd48) : "l"(rd42));
  // PTX:125 red.global.add.f32 [%rd48], %f13
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))), (float)(f13));
  // PTX:126 add.s64 %rd49, %rd42, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd49) : "l"(rd42));
  // PTX:127 red.global.add.f32 [%rd49], %f15
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))), (float)(f15));
  // PTX:128 add.s64 %rd50, %rd42, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd50) : "l"(rd42));
  // PTX:129 red.global.add.f32 [%rd50], %f16
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (0)))), (float)(f16));
  // PTX:130 add.s32 %r15, %r10, %r11
  asm("add.s32 %0, %1, %2;" : "=r"(r15) : "r"(r10), "r"(r11));
  // PTX:131 mul.wide.s32 %rd51, %r15, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd51) : "r"(r15));
  // PTX:132 add.s64 %rd52, %rd20, %rd51
  asm("add.s64 %0, %1, %2;" : "=l"(rd52) : "l"(rd20), "l"(rd51));
  // PTX:133 red.global.add.f32 [%rd52], %f11
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))), (float)(f11));
  // PTX:134 add.s64 %rd53, %rd52, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd53) : "l"(rd52));
  // PTX:135 red.global.add.f32 [%rd53], %f12
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))), (float)(f12));
  // PTX:136 add.s64 %rd54, %rd52, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd54) : "l"(rd52));
  // PTX:137 red.global.add.f32 [%rd54], %f13
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))), (float)(f13));
  // PTX:138 add.s64 %rd55, %rd52, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd55) : "l"(rd52));
  // PTX:139 red.global.add.f32 [%rd55], %f12
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))), (float)(f12));
  // PTX:140 add.s64 %rd56, %rd52, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd56) : "l"(rd52));
  // PTX:141 red.global.add.f32 [%rd56], %f14
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))), (float)(f14));
  // PTX:142 add.s64 %rd57, %rd52, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd57) : "l"(rd52));
  // PTX:143 red.global.add.f32 [%rd57], %f15
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))), (float)(f15));
  // PTX:144 add.s64 %rd58, %rd52, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd58) : "l"(rd52));
  // PTX:145 red.global.add.f32 [%rd58], %f13
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (0)))), (float)(f13));
  // PTX:146 add.s64 %rd59, %rd52, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd59) : "l"(rd52));
  // PTX:147 red.global.add.f32 [%rd59], %f15
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))), (float)(f15));
  // PTX:148 add.s64 %rd60, %rd52, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd60) : "l"(rd52));
  // PTX:149 red.global.add.f32 [%rd60], %f16
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))), (float)(f16));
  // PTX:151 $L__BB42_5:
L_BB42_5:;
  // PTX:152 ret
  return;
}
