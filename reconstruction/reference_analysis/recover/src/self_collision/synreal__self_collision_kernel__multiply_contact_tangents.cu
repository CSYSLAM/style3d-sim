// 机械还原自 PTX：synreal::self_collision_kernel::multiply_contact_tangents(synreal::SelfCollisionContactTangent const*, unsigned int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*)
// PTX SHA256: b1ce96459eb7db5a191805094b7c952a061183dca2c32077717f6407943d8403
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__self_collision_kernel__multiply_contact_tangents(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3) {
  unsigned long long SP, SPL, rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74;
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53;
  __align__(4) unsigned char __local_depot12[60];
  // PTX:23 mov.u64 %SPL, __local_depot12
  SPL = (unsigned long long)__cvta_generic_to_local(__local_depot12);
  // PTX:24 ld.param.u64 %rd13, [_ZN7synreal21self_collision_kernel25multiply_contact_tangentsEPKNS_27SelfCollisionContactTangentEPKjPKN3glm3vecILi3EfLNS6_9qualifierE0EEEPS9__param_0]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:25 ld.param.u64 %rd14, [_ZN7synreal21self_collision_kernel25multiply_contact_tangentsEPKNS_27SelfCollisionContactTangentEPKjPKN3glm3vecILi3EfLNS6_9qualifierE0EEEPS9__param_1]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:26 ld.param.u64 %rd15, [_ZN7synreal21self_collision_kernel25multiply_contact_tangentsEPKNS_27SelfCollisionContactTangentEPKjPKN3glm3vecILi3EfLNS6_9qualifierE0EEEPS9__param_2]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:27 ld.param.u64 %rd16, [_ZN7synreal21self_collision_kernel25multiply_contact_tangentsEPKNS_27SelfCollisionContactTangentEPKjPKN3glm3vecILi3EfLNS6_9qualifierE0EEEPS9__param_3]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:28 cvta.to.global.u64 %rd1, %rd15
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd15));
  // PTX:29 cvta.to.global.u64 %rd2, %rd16
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd16));
  // PTX:30 add.u64 %rd3, %SPL, 0
  asm("add.u64 %0, %1, 0;" : "=l"(rd3) : "l"(SPL));
  // PTX:31 mov.u32 %r19, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r19) : "r"(blockIdx.x));
  // PTX:32 mov.u32 %r20, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r20) : "r"(blockDim.x));
  // PTX:33 cvt.u64.u32 %rd4, %r20
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd4) : "r"(r20));
  // PTX:34 mul.wide.u32 %rd18, %r19, %r20
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd18) : "r"(r19), "r"(r20));
  // PTX:35 mov.u32 %r21, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r21) : "r"(threadIdx.x));
  // PTX:36 cvt.u64.u32 %rd19, %r21
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd19) : "r"(r21));
  // PTX:37 add.s64 %rd74, %rd18, %rd19
  asm("add.s64 %0, %1, %2;" : "=l"(rd74) : "l"(rd18), "l"(rd19));
  // PTX:38 cvta.to.global.u64 %rd6, %rd14
  rd6 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd14));
  // PTX:39 ld.global.u32 %rd20, [%rd6]
  rd20 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd6) + (0)))));
  // PTX:40 setp.ge.u64 %p1, %rd74, %rd20
  p1 = (((unsigned long long)(rd74)) >= ((unsigned long long)(rd20)));
  // PTX:41 @%p1 bra $L__BB12_19
  if (p1) { goto L_BB12_19; }
  // PTX:43 mov.u32 %r22, %nctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r22) : "r"(gridDim.x));
  // PTX:44 cvt.u64.u32 %rd21, %r22
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd21) : "r"(r22));
  // PTX:45 mul.lo.s64 %rd7, %rd21, %rd4
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd7) : "l"(rd21), "l"(rd4));
  // PTX:46 cvta.to.global.u64 %rd8, %rd13
  rd8 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd13));
  // PTX:48 $L__BB12_2:
L_BB12_2:;
  // PTX:49 mul.lo.s64 %rd22, %rd74, 60
  asm("mul.lo.s64 %0, %1, 60;" : "=l"(rd22) : "l"(rd74));
  // PTX:50 add.s64 %rd23, %rd8, %rd22
  asm("add.s64 %0, %1, %2;" : "=l"(rd23) : "l"(rd8), "l"(rd22));
  // PTX:51 ld.global.u32 %r23, [%rd23]
  r23 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (0)))));
  // PTX:52 ld.global.u32 %r24, [%rd23+4]
  r24 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (4)))));
  // PTX:53 ld.global.u32 %r25, [%rd23+8]
  r25 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (8)))));
  // PTX:54 ld.global.u32 %r26, [%rd23+12]
  r26 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (12)))));
  // PTX:55 ld.global.u32 %r27, [%rd23+16]
  r27 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (16)))));
  // PTX:56 ld.global.f32 %f32, [%rd23+20]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (20)))));
  // PTX:57 ld.global.f32 %f33, [%rd23+24]
  f33 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (24)))));
  // PTX:58 ld.global.f32 %f34, [%rd23+28]
  f34 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (28)))));
  // PTX:59 ld.global.f32 %f35, [%rd23+32]
  f35 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (32)))));
  // PTX:60 ld.global.f32 %f36, [%rd23+36]
  f36 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (36)))));
  // PTX:61 ld.global.u32 %r1, [%rd23+40]
  r1 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (40)))));
  // PTX:62 ld.global.u32 %r2, [%rd23+44]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (44)))));
  // PTX:63 ld.global.u32 %r3, [%rd23+48]
  r3 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (48)))));
  // PTX:64 ld.global.f32 %f1, [%rd23+52]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (52)))));
  // PTX:65 ld.global.u32 %r4, [%rd23+56]
  r4 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (56)))));
  // PTX:66 st.local.u32 [%rd3], %r23
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (0))))) = (unsigned)(r23);
  // PTX:67 st.local.u32 [%rd3+4], %r24
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (4))))) = (unsigned)(r24);
  // PTX:68 st.local.u32 [%rd3+8], %r25
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (8))))) = (unsigned)(r25);
  // PTX:69 st.local.u32 [%rd3+12], %r26
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (12))))) = (unsigned)(r26);
  // PTX:70 st.local.u32 [%rd3+16], %r27
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (16))))) = (unsigned)(r27);
  // PTX:71 st.local.f32 [%rd3+20], %f32
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (20))))) = (float)(f32);
  // PTX:72 st.local.f32 [%rd3+24], %f33
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (24))))) = (float)(f33);
  // PTX:73 st.local.f32 [%rd3+28], %f34
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (28))))) = (float)(f34);
  // PTX:74 st.local.f32 [%rd3+32], %f35
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (32))))) = (float)(f35);
  // PTX:75 st.local.f32 [%rd3+36], %f36
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (36))))) = (float)(f36);
  // PTX:76 st.local.u32 [%rd3+40], %r1
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (40))))) = (unsigned)(r1);
  // PTX:77 st.local.u32 [%rd3+44], %r2
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (44))))) = (unsigned)(r2);
  // PTX:78 st.local.u32 [%rd3+48], %r3
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (48))))) = (unsigned)(r3);
  // PTX:79 st.local.f32 [%rd3+52], %f1
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (52))))) = (float)(f1);
  // PTX:80 st.local.u32 [%rd3+56], %r4
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (56))))) = (unsigned)(r4);
  // PTX:81 setp.lt.s32 %p2, %r4, 1
  p2 = (((int)(r4)) < ((int)(1)));
  // PTX:82 mov.f32 %f146, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f146) : );
  // PTX:83 mov.f32 %f147, %f146
  asm("mov.f32 %0, %1;" : "=f"(f147) : "f"(f146));
  // PTX:84 mov.f32 %f148, %f146
  asm("mov.f32 %0, %1;" : "=f"(f148) : "f"(f146));
  // PTX:85 @%p2 bra $L__BB12_10
  if (p2) { goto L_BB12_10; }
  // PTX:87 add.s32 %r29, %r4, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r29) : "r"(r4));
  // PTX:88 and.b32 %r5, %r4, 3
  asm("and.b32 %0, %1, 3;" : "=r"(r5) : "r"(r4));
  // PTX:89 setp.lt.u32 %p3, %r29, 3
  p3 = (((unsigned)(r29)) < ((unsigned)(3)));
  // PTX:90 mov.f32 %f148, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f148) : );
  // PTX:91 mov.u32 %r50, 0
  asm("mov.u32 %0, 0;" : "=r"(r50) : );
  // PTX:92 mov.f32 %f147, %f148
  asm("mov.f32 %0, %1;" : "=f"(f147) : "f"(f148));
  // PTX:93 mov.f32 %f146, %f148
  asm("mov.f32 %0, %1;" : "=f"(f146) : "f"(f148));
  // PTX:94 @%p3 bra $L__BB12_6
  if (p3) { goto L_BB12_6; }
  // PTX:96 sub.s32 %r49, %r4, %r5
  asm("sub.s32 %0, %1, %2;" : "=r"(r49) : "r"(r4), "r"(r5));
  // PTX:97 mov.f32 %f148, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f148) : );
  // PTX:98 mov.u32 %r50, 0
  asm("mov.u32 %0, 0;" : "=r"(r50) : );
  // PTX:100 $L__BB12_5:
L_BB12_5:;
  // PTX:101 mul.wide.s32 %rd24, %r50, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd24) : "r"(r50));
  // PTX:102 add.s64 %rd25, %rd3, %rd24
  asm("add.s64 %0, %1, %2;" : "=l"(rd25) : "l"(rd3), "l"(rd24));
  // PTX:103 ld.local.u32 %r31, [%rd25]
  r31 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd25) + (0)))));
  // PTX:104 mul.wide.s32 %rd26, %r31, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd26) : "r"(r31));
  // PTX:105 add.s64 %rd27, %rd1, %rd26
  asm("add.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd1), "l"(rd26));
  // PTX:106 ld.global.f32 %f44, [%rd27]
  f44 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))));
  // PTX:107 ld.local.f32 %f45, [%rd25+20]
  f45 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd25) + (20)))));
  // PTX:108 ld.global.f32 %f46, [%rd27+4]
  f46 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (4)))));
  // PTX:109 ld.global.f32 %f47, [%rd27+8]
  f47 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (8)))));
  // PTX:110 fma.rn.f32 %f48, %f45, %f44, %f146
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f48) : "f"(f45), "f"(f44), "f"(f146));
  // PTX:111 fma.rn.f32 %f49, %f45, %f46, %f147
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f49) : "f"(f45), "f"(f46), "f"(f147));
  // PTX:112 fma.rn.f32 %f50, %f45, %f47, %f148
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f50) : "f"(f45), "f"(f47), "f"(f148));
  // PTX:113 ld.local.u32 %r32, [%rd25+4]
  r32 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd25) + (4)))));
  // PTX:114 mul.wide.s32 %rd28, %r32, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd28) : "r"(r32));
  // PTX:115 add.s64 %rd29, %rd1, %rd28
  asm("add.s64 %0, %1, %2;" : "=l"(rd29) : "l"(rd1), "l"(rd28));
  // PTX:116 ld.global.f32 %f51, [%rd29]
  f51 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (0)))));
  // PTX:117 ld.local.f32 %f52, [%rd25+24]
  f52 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd25) + (24)))));
  // PTX:118 ld.global.f32 %f53, [%rd29+4]
  f53 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (4)))));
  // PTX:119 ld.global.f32 %f54, [%rd29+8]
  f54 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (8)))));
  // PTX:120 fma.rn.f32 %f55, %f52, %f51, %f48
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f55) : "f"(f52), "f"(f51), "f"(f48));
  // PTX:121 fma.rn.f32 %f56, %f52, %f53, %f49
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f56) : "f"(f52), "f"(f53), "f"(f49));
  // PTX:122 fma.rn.f32 %f57, %f52, %f54, %f50
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f57) : "f"(f52), "f"(f54), "f"(f50));
  // PTX:123 ld.local.u32 %r33, [%rd25+8]
  r33 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd25) + (8)))));
  // PTX:124 mul.wide.s32 %rd30, %r33, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd30) : "r"(r33));
  // PTX:125 add.s64 %rd31, %rd1, %rd30
  asm("add.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd1), "l"(rd30));
  // PTX:126 ld.global.f32 %f58, [%rd31]
  f58 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (0)))));
  // PTX:127 ld.local.f32 %f59, [%rd25+28]
  f59 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd25) + (28)))));
  // PTX:128 ld.global.f32 %f60, [%rd31+4]
  f60 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (4)))));
  // PTX:129 ld.global.f32 %f61, [%rd31+8]
  f61 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (8)))));
  // PTX:130 fma.rn.f32 %f62, %f59, %f58, %f55
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f62) : "f"(f59), "f"(f58), "f"(f55));
  // PTX:131 fma.rn.f32 %f63, %f59, %f60, %f56
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f63) : "f"(f59), "f"(f60), "f"(f56));
  // PTX:132 fma.rn.f32 %f64, %f59, %f61, %f57
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f64) : "f"(f59), "f"(f61), "f"(f57));
  // PTX:133 ld.local.u32 %r34, [%rd25+12]
  r34 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd25) + (12)))));
  // PTX:134 mul.wide.s32 %rd32, %r34, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd32) : "r"(r34));
  // PTX:135 add.s64 %rd33, %rd1, %rd32
  asm("add.s64 %0, %1, %2;" : "=l"(rd33) : "l"(rd1), "l"(rd32));
  // PTX:136 ld.global.f32 %f65, [%rd33]
  f65 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (0)))));
  // PTX:137 ld.local.f32 %f66, [%rd25+32]
  f66 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd25) + (32)))));
  // PTX:138 ld.global.f32 %f67, [%rd33+4]
  f67 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (4)))));
  // PTX:139 ld.global.f32 %f68, [%rd33+8]
  f68 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (8)))));
  // PTX:140 fma.rn.f32 %f146, %f66, %f65, %f62
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f146) : "f"(f66), "f"(f65), "f"(f62));
  // PTX:141 fma.rn.f32 %f147, %f66, %f67, %f63
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f147) : "f"(f66), "f"(f67), "f"(f63));
  // PTX:142 fma.rn.f32 %f148, %f66, %f68, %f64
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f148) : "f"(f66), "f"(f68), "f"(f64));
  // PTX:143 add.s32 %r50, %r50, 4
  asm("add.s32 %0, %1, 4;" : "=r"(r50) : "r"(r50));
  // PTX:144 add.s32 %r49, %r49, -4
  asm("add.s32 %0, %1, -4;" : "=r"(r49) : "r"(r49));
  // PTX:145 setp.ne.s32 %p4, %r49, 0
  p4 = (((int)(r49)) != ((int)(0)));
  // PTX:146 @%p4 bra $L__BB12_5
  if (p4) { goto L_BB12_5; }
  // PTX:148 $L__BB12_6:
L_BB12_6:;
  // PTX:149 setp.eq.s32 %p5, %r5, 0
  p5 = (((int)(r5)) == ((int)(0)));
  // PTX:150 @%p5 bra $L__BB12_10
  if (p5) { goto L_BB12_10; }
  // PTX:152 mul.wide.s32 %rd34, %r50, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd34) : "r"(r50));
  // PTX:153 add.s64 %rd35, %rd3, %rd34
  asm("add.s64 %0, %1, %2;" : "=l"(rd35) : "l"(rd3), "l"(rd34));
  // PTX:154 add.s64 %rd10, %rd35, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd10) : "l"(rd35));
  // PTX:155 ld.local.u32 %r35, [%rd35]
  r35 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd35) + (0)))));
  // PTX:156 mul.wide.s32 %rd36, %r35, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd36) : "r"(r35));
  // PTX:157 add.s64 %rd37, %rd1, %rd36
  asm("add.s64 %0, %1, %2;" : "=l"(rd37) : "l"(rd1), "l"(rd36));
  // PTX:158 ld.global.f32 %f69, [%rd37]
  f69 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (0)))));
  // PTX:159 ld.local.f32 %f70, [%rd35+20]
  f70 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd35) + (20)))));
  // PTX:160 ld.global.f32 %f71, [%rd37+4]
  f71 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (4)))));
  // PTX:161 ld.global.f32 %f72, [%rd37+8]
  f72 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (8)))));
  // PTX:162 fma.rn.f32 %f146, %f70, %f69, %f146
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f146) : "f"(f70), "f"(f69), "f"(f146));
  // PTX:163 fma.rn.f32 %f147, %f70, %f71, %f147
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f147) : "f"(f70), "f"(f71), "f"(f147));
  // PTX:164 fma.rn.f32 %f148, %f70, %f72, %f148
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f148) : "f"(f70), "f"(f72), "f"(f148));
  // PTX:165 setp.eq.s32 %p6, %r5, 1
  p6 = (((int)(r5)) == ((int)(1)));
  // PTX:166 @%p6 bra $L__BB12_10
  if (p6) { goto L_BB12_10; }
  // PTX:168 ld.local.u32 %r36, [%rd10+-16]
  r36 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd10) + (-16)))));
  // PTX:169 mul.wide.s32 %rd38, %r36, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd38) : "r"(r36));
  // PTX:170 add.s64 %rd39, %rd1, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd39) : "l"(rd1), "l"(rd38));
  // PTX:171 ld.global.f32 %f73, [%rd39]
  f73 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (0)))));
  // PTX:172 ld.local.f32 %f74, [%rd10+4]
  f74 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd10) + (4)))));
  // PTX:173 ld.global.f32 %f75, [%rd39+4]
  f75 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (4)))));
  // PTX:174 ld.global.f32 %f76, [%rd39+8]
  f76 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (8)))));
  // PTX:175 fma.rn.f32 %f146, %f74, %f73, %f146
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f146) : "f"(f74), "f"(f73), "f"(f146));
  // PTX:176 fma.rn.f32 %f147, %f74, %f75, %f147
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f147) : "f"(f74), "f"(f75), "f"(f147));
  // PTX:177 fma.rn.f32 %f148, %f74, %f76, %f148
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f148) : "f"(f74), "f"(f76), "f"(f148));
  // PTX:178 setp.eq.s32 %p7, %r5, 2
  p7 = (((int)(r5)) == ((int)(2)));
  // PTX:179 @%p7 bra $L__BB12_10
  if (p7) { goto L_BB12_10; }
  // PTX:181 ld.local.u32 %r37, [%rd10+-12]
  r37 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd10) + (-12)))));
  // PTX:182 mul.wide.s32 %rd40, %r37, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd40) : "r"(r37));
  // PTX:183 add.s64 %rd41, %rd1, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd41) : "l"(rd1), "l"(rd40));
  // PTX:184 ld.global.f32 %f77, [%rd41]
  f77 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (0)))));
  // PTX:185 ld.local.f32 %f78, [%rd10+8]
  f78 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd10) + (8)))));
  // PTX:186 ld.global.f32 %f79, [%rd41+4]
  f79 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (4)))));
  // PTX:187 ld.global.f32 %f80, [%rd41+8]
  f80 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (8)))));
  // PTX:188 fma.rn.f32 %f146, %f78, %f77, %f146
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f146) : "f"(f78), "f"(f77), "f"(f146));
  // PTX:189 fma.rn.f32 %f147, %f78, %f79, %f147
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f147) : "f"(f78), "f"(f79), "f"(f147));
  // PTX:190 fma.rn.f32 %f148, %f78, %f80, %f148
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f148) : "f"(f78), "f"(f80), "f"(f148));
  // PTX:192 $L__BB12_10:
L_BB12_10:;
  // PTX:193 mov.b32 %f81, %r1
  asm("mov.b32 %0, %1;" : "=f"(f81) : "r"(r1));
  // PTX:194 mov.b32 %f82, %r2
  asm("mov.b32 %0, %1;" : "=f"(f82) : "r"(r2));
  // PTX:195 mov.b32 %f83, %r3
  asm("mov.b32 %0, %1;" : "=f"(f83) : "r"(r3));
  // PTX:196 mul.f32 %f84, %f147, %f82
  asm("mul.f32 %0, %1, %2;" : "=f"(f84) : "f"(f147), "f"(f82));
  // PTX:197 fma.rn.f32 %f85, %f146, %f81, %f84
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f85) : "f"(f146), "f"(f81), "f"(f84));
  // PTX:198 fma.rn.f32 %f86, %f148, %f83, %f85
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f86) : "f"(f148), "f"(f83), "f"(f85));
  // PTX:199 mul.f32 %f87, %f1, %f86
  asm("mul.f32 %0, %1, %2;" : "=f"(f87) : "f"(f1), "f"(f86));
  // PTX:200 mul.f32 %f26, %f87, %f81
  asm("mul.f32 %0, %1, %2;" : "=f"(f26) : "f"(f87), "f"(f81));
  // PTX:201 mul.f32 %f27, %f87, %f82
  asm("mul.f32 %0, %1, %2;" : "=f"(f27) : "f"(f87), "f"(f82));
  // PTX:202 mul.f32 %f28, %f87, %f83
  asm("mul.f32 %0, %1, %2;" : "=f"(f28) : "f"(f87), "f"(f83));
  // PTX:203 @%p2 bra $L__BB12_18
  if (p2) { goto L_BB12_18; }
  // PTX:205 add.s32 %r39, %r4, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r39) : "r"(r4));
  // PTX:206 and.b32 %r12, %r4, 3
  asm("and.b32 %0, %1, 3;" : "=r"(r12) : "r"(r4));
  // PTX:207 setp.lt.u32 %p9, %r39, 3
  p9 = (((unsigned)(r39)) < ((unsigned)(3)));
  // PTX:208 mov.u32 %r53, 0
  asm("mov.u32 %0, 0;" : "=r"(r53) : );
  // PTX:209 @%p9 bra $L__BB12_14
  if (p9) { goto L_BB12_14; }
  // PTX:211 sub.s32 %r52, %r4, %r12
  asm("sub.s32 %0, %1, %2;" : "=r"(r52) : "r"(r4), "r"(r12));
  // PTX:212 mov.u32 %r53, 0
  asm("mov.u32 %0, 0;" : "=r"(r53) : );
  // PTX:214 $L__BB12_13:
L_BB12_13:;
  // PTX:215 mul.wide.s32 %rd42, %r53, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd42) : "r"(r53));
  // PTX:216 add.s64 %rd43, %rd3, %rd42
  asm("add.s64 %0, %1, %2;" : "=l"(rd43) : "l"(rd3), "l"(rd42));
  // PTX:217 ld.local.u32 %r41, [%rd43]
  r41 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd43) + (0)))));
  // PTX:218 mul.wide.s32 %rd44, %r41, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd44) : "r"(r41));
  // PTX:219 add.s64 %rd45, %rd2, %rd44
  asm("add.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd2), "l"(rd44));
  // PTX:220 ld.local.f32 %f88, [%rd43+20]
  f88 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd43) + (20)))));
  // PTX:221 mul.f32 %f89, %f26, %f88
  asm("mul.f32 %0, %1, %2;" : "=f"(f89) : "f"(f26), "f"(f88));
  // PTX:222 mul.f32 %f90, %f27, %f88
  asm("mul.f32 %0, %1, %2;" : "=f"(f90) : "f"(f27), "f"(f88));
  // PTX:223 mul.f32 %f91, %f28, %f88
  asm("mul.f32 %0, %1, %2;" : "=f"(f91) : "f"(f28), "f"(f88));
  // PTX:224 red.global.add.f32 [%rd45], %f89
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))), (float)(f89));
  // PTX:225 add.s64 %rd46, %rd45, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd46) : "l"(rd45));
  // PTX:226 red.global.add.f32 [%rd46], %f90
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (0)))), (float)(f90));
  // PTX:227 add.s64 %rd47, %rd45, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd47) : "l"(rd45));
  // PTX:228 red.global.add.f32 [%rd47], %f91
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))), (float)(f91));
  // PTX:229 ld.local.u32 %r42, [%rd43+4]
  r42 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd43) + (4)))));
  // PTX:230 mul.wide.s32 %rd48, %r42, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd48) : "r"(r42));
  // PTX:231 add.s64 %rd49, %rd2, %rd48
  asm("add.s64 %0, %1, %2;" : "=l"(rd49) : "l"(rd2), "l"(rd48));
  // PTX:232 ld.local.f32 %f95, [%rd43+24]
  f95 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd43) + (24)))));
  // PTX:233 mul.f32 %f96, %f26, %f95
  asm("mul.f32 %0, %1, %2;" : "=f"(f96) : "f"(f26), "f"(f95));
  // PTX:234 mul.f32 %f97, %f27, %f95
  asm("mul.f32 %0, %1, %2;" : "=f"(f97) : "f"(f27), "f"(f95));
  // PTX:235 mul.f32 %f98, %f28, %f95
  asm("mul.f32 %0, %1, %2;" : "=f"(f98) : "f"(f28), "f"(f95));
  // PTX:236 red.global.add.f32 [%rd49], %f96
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))), (float)(f96));
  // PTX:237 add.s64 %rd50, %rd49, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd50) : "l"(rd49));
  // PTX:238 red.global.add.f32 [%rd50], %f97
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (0)))), (float)(f97));
  // PTX:239 add.s64 %rd51, %rd49, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd51) : "l"(rd49));
  // PTX:240 red.global.add.f32 [%rd51], %f98
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))), (float)(f98));
  // PTX:241 ld.local.u32 %r43, [%rd43+8]
  r43 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd43) + (8)))));
  // PTX:242 mul.wide.s32 %rd52, %r43, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd52) : "r"(r43));
  // PTX:243 add.s64 %rd53, %rd2, %rd52
  asm("add.s64 %0, %1, %2;" : "=l"(rd53) : "l"(rd2), "l"(rd52));
  // PTX:244 ld.local.f32 %f102, [%rd43+28]
  f102 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd43) + (28)))));
  // PTX:245 mul.f32 %f103, %f26, %f102
  asm("mul.f32 %0, %1, %2;" : "=f"(f103) : "f"(f26), "f"(f102));
  // PTX:246 mul.f32 %f104, %f27, %f102
  asm("mul.f32 %0, %1, %2;" : "=f"(f104) : "f"(f27), "f"(f102));
  // PTX:247 mul.f32 %f105, %f28, %f102
  asm("mul.f32 %0, %1, %2;" : "=f"(f105) : "f"(f28), "f"(f102));
  // PTX:248 red.global.add.f32 [%rd53], %f103
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))), (float)(f103));
  // PTX:249 add.s64 %rd54, %rd53, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd54) : "l"(rd53));
  // PTX:250 red.global.add.f32 [%rd54], %f104
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))), (float)(f104));
  // PTX:251 add.s64 %rd55, %rd53, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd55) : "l"(rd53));
  // PTX:252 red.global.add.f32 [%rd55], %f105
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))), (float)(f105));
  // PTX:253 ld.local.u32 %r44, [%rd43+12]
  r44 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd43) + (12)))));
  // PTX:254 mul.wide.s32 %rd56, %r44, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd56) : "r"(r44));
  // PTX:255 add.s64 %rd57, %rd2, %rd56
  asm("add.s64 %0, %1, %2;" : "=l"(rd57) : "l"(rd2), "l"(rd56));
  // PTX:256 ld.local.f32 %f109, [%rd43+32]
  f109 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd43) + (32)))));
  // PTX:257 mul.f32 %f110, %f26, %f109
  asm("mul.f32 %0, %1, %2;" : "=f"(f110) : "f"(f26), "f"(f109));
  // PTX:258 mul.f32 %f111, %f27, %f109
  asm("mul.f32 %0, %1, %2;" : "=f"(f111) : "f"(f27), "f"(f109));
  // PTX:259 mul.f32 %f112, %f28, %f109
  asm("mul.f32 %0, %1, %2;" : "=f"(f112) : "f"(f28), "f"(f109));
  // PTX:260 red.global.add.f32 [%rd57], %f110
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))), (float)(f110));
  // PTX:261 add.s64 %rd58, %rd57, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd58) : "l"(rd57));
  // PTX:262 red.global.add.f32 [%rd58], %f111
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (0)))), (float)(f111));
  // PTX:263 add.s64 %rd59, %rd57, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd59) : "l"(rd57));
  // PTX:264 red.global.add.f32 [%rd59], %f112
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))), (float)(f112));
  // PTX:265 add.s32 %r53, %r53, 4
  asm("add.s32 %0, %1, 4;" : "=r"(r53) : "r"(r53));
  // PTX:266 add.s32 %r52, %r52, -4
  asm("add.s32 %0, %1, -4;" : "=r"(r52) : "r"(r52));
  // PTX:267 setp.ne.s32 %p10, %r52, 0
  p10 = (((int)(r52)) != ((int)(0)));
  // PTX:268 @%p10 bra $L__BB12_13
  if (p10) { goto L_BB12_13; }
  // PTX:270 $L__BB12_14:
L_BB12_14:;
  // PTX:271 setp.eq.s32 %p11, %r12, 0
  p11 = (((int)(r12)) == ((int)(0)));
  // PTX:272 @%p11 bra $L__BB12_18
  if (p11) { goto L_BB12_18; }
  // PTX:274 mul.wide.s32 %rd60, %r53, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd60) : "r"(r53));
  // PTX:275 add.s64 %rd11, %rd3, %rd60
  asm("add.s64 %0, %1, %2;" : "=l"(rd11) : "l"(rd3), "l"(rd60));
  // PTX:276 ld.local.u32 %r45, [%rd11]
  r45 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (0)))));
  // PTX:277 mul.wide.s32 %rd61, %r45, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd61) : "r"(r45));
  // PTX:278 add.s64 %rd62, %rd2, %rd61
  asm("add.s64 %0, %1, %2;" : "=l"(rd62) : "l"(rd2), "l"(rd61));
  // PTX:279 ld.local.f32 %f116, [%rd11+20]
  f116 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (20)))));
  // PTX:280 mul.f32 %f117, %f26, %f116
  asm("mul.f32 %0, %1, %2;" : "=f"(f117) : "f"(f26), "f"(f116));
  // PTX:281 mul.f32 %f118, %f27, %f116
  asm("mul.f32 %0, %1, %2;" : "=f"(f118) : "f"(f27), "f"(f116));
  // PTX:282 mul.f32 %f119, %f28, %f116
  asm("mul.f32 %0, %1, %2;" : "=f"(f119) : "f"(f28), "f"(f116));
  // PTX:283 red.global.add.f32 [%rd62], %f117
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))), (float)(f117));
  // PTX:284 add.s64 %rd63, %rd62, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd63) : "l"(rd62));
  // PTX:285 red.global.add.f32 [%rd63], %f118
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (0)))), (float)(f118));
  // PTX:286 add.s64 %rd64, %rd62, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd64) : "l"(rd62));
  // PTX:287 red.global.add.f32 [%rd64], %f119
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (0)))), (float)(f119));
  // PTX:288 setp.eq.s32 %p12, %r12, 1
  p12 = (((int)(r12)) == ((int)(1)));
  // PTX:289 @%p12 bra $L__BB12_18
  if (p12) { goto L_BB12_18; }
  // PTX:291 ld.local.u32 %r46, [%rd11+4]
  r46 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (4)))));
  // PTX:292 mul.wide.s32 %rd65, %r46, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd65) : "r"(r46));
  // PTX:293 add.s64 %rd66, %rd2, %rd65
  asm("add.s64 %0, %1, %2;" : "=l"(rd66) : "l"(rd2), "l"(rd65));
  // PTX:294 ld.local.f32 %f123, [%rd11+24]
  f123 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (24)))));
  // PTX:295 mul.f32 %f124, %f26, %f123
  asm("mul.f32 %0, %1, %2;" : "=f"(f124) : "f"(f26), "f"(f123));
  // PTX:296 mul.f32 %f125, %f27, %f123
  asm("mul.f32 %0, %1, %2;" : "=f"(f125) : "f"(f27), "f"(f123));
  // PTX:297 mul.f32 %f126, %f28, %f123
  asm("mul.f32 %0, %1, %2;" : "=f"(f126) : "f"(f28), "f"(f123));
  // PTX:298 red.global.add.f32 [%rd66], %f124
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (0)))), (float)(f124));
  // PTX:299 add.s64 %rd67, %rd66, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd67) : "l"(rd66));
  // PTX:300 red.global.add.f32 [%rd67], %f125
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0)))), (float)(f125));
  // PTX:301 add.s64 %rd68, %rd66, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd68) : "l"(rd66));
  // PTX:302 red.global.add.f32 [%rd68], %f126
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (0)))), (float)(f126));
  // PTX:303 setp.eq.s32 %p13, %r12, 2
  p13 = (((int)(r12)) == ((int)(2)));
  // PTX:304 @%p13 bra $L__BB12_18
  if (p13) { goto L_BB12_18; }
  // PTX:306 ld.local.u32 %r47, [%rd11+8]
  r47 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (8)))));
  // PTX:307 mul.wide.s32 %rd69, %r47, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd69) : "r"(r47));
  // PTX:308 add.s64 %rd70, %rd2, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd70) : "l"(rd2), "l"(rd69));
  // PTX:309 ld.local.f32 %f130, [%rd11+28]
  f130 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd11) + (28)))));
  // PTX:310 mul.f32 %f131, %f26, %f130
  asm("mul.f32 %0, %1, %2;" : "=f"(f131) : "f"(f26), "f"(f130));
  // PTX:311 mul.f32 %f132, %f27, %f130
  asm("mul.f32 %0, %1, %2;" : "=f"(f132) : "f"(f27), "f"(f130));
  // PTX:312 mul.f32 %f133, %f28, %f130
  asm("mul.f32 %0, %1, %2;" : "=f"(f133) : "f"(f28), "f"(f130));
  // PTX:313 red.global.add.f32 [%rd70], %f131
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0)))), (float)(f131));
  // PTX:314 add.s64 %rd71, %rd70, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd71) : "l"(rd70));
  // PTX:315 red.global.add.f32 [%rd71], %f132
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))), (float)(f132));
  // PTX:316 add.s64 %rd72, %rd70, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd72) : "l"(rd70));
  // PTX:317 red.global.add.f32 [%rd72], %f133
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (0)))), (float)(f133));
  // PTX:319 $L__BB12_18:
L_BB12_18:;
  // PTX:320 add.s64 %rd74, %rd74, %rd7
  asm("add.s64 %0, %1, %2;" : "=l"(rd74) : "l"(rd74), "l"(rd7));
  // PTX:321 ld.global.u32 %rd73, [%rd6]
  rd73 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd6) + (0)))));
  // PTX:322 setp.lt.u64 %p14, %rd74, %rd73
  p14 = (((unsigned long long)(rd74)) < ((unsigned long long)(rd73)));
  // PTX:323 @%p14 bra $L__BB12_2
  if (p14) { goto L_BB12_2; }
  // PTX:325 $L__BB12_19:
L_BB12_19:;
  // PTX:326 ret
  return;
}
