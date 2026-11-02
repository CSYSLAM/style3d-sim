// 机械还原自 PTX：synreal::kernel::refresh_inertial_cache_diagonals(float const*, unsigned long const*, int const*, float*, float*, unsigned long)
// PTX SHA256: 256fa986aacc0ed8c886dc78d495eb5a779f8d26cad821a266f1c736b0d1b14e
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__refresh_inertial_cache_diagonals(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5) {
  int p0, p1, p2, p3, p4, p5, p6, p7;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58;
  // PTX:22 ld.param.u64 %rd24, [_ZN7synreal6kernel32refresh_inertial_cache_diagonalsEPKfPKmPKiPfS7_m_param_0]
  rd24 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:23 ld.param.u64 %rd21, [_ZN7synreal6kernel32refresh_inertial_cache_diagonalsEPKfPKmPKiPfS7_m_param_1]
  rd21 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:24 ld.param.u64 %rd25, [_ZN7synreal6kernel32refresh_inertial_cache_diagonalsEPKfPKmPKiPfS7_m_param_2]
  rd25 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:25 ld.param.u64 %rd22, [_ZN7synreal6kernel32refresh_inertial_cache_diagonalsEPKfPKmPKiPfS7_m_param_3]
  rd22 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:26 ld.param.u64 %rd23, [_ZN7synreal6kernel32refresh_inertial_cache_diagonalsEPKfPKmPKiPfS7_m_param_4]
  rd23 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:27 ld.param.u64 %rd26, [_ZN7synreal6kernel32refresh_inertial_cache_diagonalsEPKfPKmPKiPfS7_m_param_5]
  rd26 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:28 cvta.to.global.u64 %rd1, %rd24
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd24));
  // PTX:29 cvta.to.global.u64 %rd2, %rd25
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd25));
  // PTX:30 mov.u32 %r1, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r1) : "r"(blockIdx.x));
  // PTX:31 mov.u32 %r2, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockDim.x));
  // PTX:32 mul.wide.u32 %rd27, %r1, %r2
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd27) : "r"(r1), "r"(r2));
  // PTX:33 mov.u32 %r3, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(threadIdx.x));
  // PTX:34 cvt.u64.u32 %rd28, %r3
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd28) : "r"(r3));
  // PTX:35 add.s64 %rd3, %rd27, %rd28
  asm("add.s64 %0, %1, %2;" : "=l"(rd3) : "l"(rd27), "l"(rd28));
  // PTX:36 setp.ge.u64 %p1, %rd3, %rd26
  p1 = (((unsigned long long)(rd3)) >= ((unsigned long long)(rd26)));
  // PTX:37 @%p1 bra $L__BB9_10
  if (p1) { goto L_BB9_10; }
  // PTX:39 cvta.to.global.u64 %rd29, %rd21
  rd29 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd21));
  // PTX:40 shl.b64 %rd30, %rd3, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd30) : "l"(rd3));
  // PTX:41 add.s64 %rd31, %rd29, %rd30
  asm("add.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd29), "l"(rd30));
  // PTX:42 ld.global.u64 %rd4, [%rd31+8]
  rd4 = (*reinterpret_cast<volatile unsigned long long*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (8)))));
  // PTX:43 ld.global.u64 %rd5, [%rd31]
  rd5 = (*reinterpret_cast<volatile unsigned long long*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (0)))));
  // PTX:44 setp.eq.s64 %p2, %rd4, %rd5
  p2 = (((long long)(rd4)) == ((long long)(rd5)));
  // PTX:45 @%p2 bra $L__BB9_10
  if (p2) { goto L_BB9_10; }
  // PTX:47 setp.le.u64 %p3, %rd4, %rd5
  p3 = (((unsigned long long)(rd4)) <= ((unsigned long long)(rd5)));
  // PTX:48 mov.f32 %f25, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f25) : );
  // PTX:49 @%p3 bra $L__BB9_9
  if (p3) { goto L_BB9_9; }
  // PTX:51 sub.s64 %rd32, %rd4, %rd5
  asm("sub.s64 %0, %1, %2;" : "=l"(rd32) : "l"(rd4), "l"(rd5));
  // PTX:52 and.b64 %rd6, %rd32, 3
  asm("and.b64 %0, %1, 3;" : "=l"(rd6) : "l"(rd32));
  // PTX:53 setp.eq.s64 %p4, %rd6, 0
  p4 = (((long long)(rd6)) == ((long long)(0)));
  // PTX:54 mov.f32 %f25, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f25) : );
  // PTX:55 mov.u64 %rd56, %rd5
  asm("mov.u64 %0, %1;" : "=l"(rd56) : "l"(rd5));
  // PTX:56 @%p4 bra $L__BB9_6
  if (p4) { goto L_BB9_6; }
  // PTX:58 shl.b64 %rd33, %rd5, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd33) : "l"(rd5));
  // PTX:59 add.s64 %rd54, %rd2, %rd33
  asm("add.s64 %0, %1, %2;" : "=l"(rd54) : "l"(rd2), "l"(rd33));
  // PTX:60 neg.s64 %rd53, %rd6
  asm("neg.s64 %0, %1;" : "=l"(rd53) : "l"(rd6));
  // PTX:61 mov.f32 %f25, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f25) : );
  // PTX:62 mov.u64 %rd56, %rd5
  asm("mov.u64 %0, %1;" : "=l"(rd56) : "l"(rd5));
  // PTX:64 $L__BB9_5:
L_BB9_5:;
  // PTX:66 ld.global.u32 %r4, [%rd54]
  r4 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))));
  // PTX:67 mul.wide.s32 %rd34, %r4, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd34) : "r"(r4));
  // PTX:68 add.s64 %rd35, %rd1, %rd34
  asm("add.s64 %0, %1, %2;" : "=l"(rd35) : "l"(rd1), "l"(rd34));
  // PTX:69 ld.global.f32 %f12, [%rd35]
  f12 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (0)))));
  // PTX:70 add.f32 %f25, %f25, %f12
  asm("add.f32 %0, %1, %2;" : "=f"(f25) : "f"(f25), "f"(f12));
  // PTX:71 add.s64 %rd56, %rd56, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd56) : "l"(rd56));
  // PTX:72 add.s64 %rd54, %rd54, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd54) : "l"(rd54));
  // PTX:73 add.s64 %rd53, %rd53, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd53) : "l"(rd53));
  // PTX:74 setp.ne.s64 %p5, %rd53, 0
  p5 = (((long long)(rd53)) != ((long long)(0)));
  // PTX:75 @%p5 bra $L__BB9_5
  if (p5) { goto L_BB9_5; }
  // PTX:77 $L__BB9_6:
L_BB9_6:;
  // PTX:78 not.b64 %rd36, %rd5
  asm("not.b64 %0, %1;" : "=l"(rd36) : "l"(rd5));
  // PTX:79 add.s64 %rd37, %rd4, %rd36
  asm("add.s64 %0, %1, %2;" : "=l"(rd37) : "l"(rd4), "l"(rd36));
  // PTX:80 setp.lt.u64 %p6, %rd37, 3
  p6 = (((unsigned long long)(rd37)) < ((unsigned long long)(3)));
  // PTX:81 @%p6 bra $L__BB9_9
  if (p6) { goto L_BB9_9; }
  // PTX:83 shl.b64 %rd38, %rd56, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd38) : "l"(rd56));
  // PTX:84 add.s64 %rd39, %rd2, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd39) : "l"(rd2), "l"(rd38));
  // PTX:85 add.s64 %rd57, %rd39, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd57) : "l"(rd39));
  // PTX:87 $L__BB9_8:
L_BB9_8:;
  // PTX:88 ld.global.u32 %r5, [%rd57+-8]
  r5 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (-8)))));
  // PTX:89 mul.wide.s32 %rd40, %r5, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd40) : "r"(r5));
  // PTX:90 add.s64 %rd41, %rd1, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd41) : "l"(rd1), "l"(rd40));
  // PTX:91 ld.global.f32 %f13, [%rd41]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (0)))));
  // PTX:92 add.f32 %f14, %f25, %f13
  asm("add.f32 %0, %1, %2;" : "=f"(f14) : "f"(f25), "f"(f13));
  // PTX:93 ld.global.u32 %r6, [%rd57+-4]
  r6 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (-4)))));
  // PTX:94 mul.wide.s32 %rd42, %r6, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd42) : "r"(r6));
  // PTX:95 add.s64 %rd43, %rd1, %rd42
  asm("add.s64 %0, %1, %2;" : "=l"(rd43) : "l"(rd1), "l"(rd42));
  // PTX:96 ld.global.f32 %f15, [%rd43]
  f15 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (0)))));
  // PTX:97 add.f32 %f16, %f14, %f15
  asm("add.f32 %0, %1, %2;" : "=f"(f16) : "f"(f14), "f"(f15));
  // PTX:98 ld.global.u32 %r7, [%rd57]
  r7 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))));
  // PTX:99 mul.wide.s32 %rd44, %r7, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd44) : "r"(r7));
  // PTX:100 add.s64 %rd45, %rd1, %rd44
  asm("add.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd1), "l"(rd44));
  // PTX:101 ld.global.f32 %f17, [%rd45]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))));
  // PTX:102 add.f32 %f18, %f16, %f17
  asm("add.f32 %0, %1, %2;" : "=f"(f18) : "f"(f16), "f"(f17));
  // PTX:103 ld.global.u32 %r8, [%rd57+4]
  r8 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (4)))));
  // PTX:104 mul.wide.s32 %rd46, %r8, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd46) : "r"(r8));
  // PTX:105 add.s64 %rd47, %rd1, %rd46
  asm("add.s64 %0, %1, %2;" : "=l"(rd47) : "l"(rd1), "l"(rd46));
  // PTX:106 ld.global.f32 %f19, [%rd47]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))));
  // PTX:107 add.f32 %f25, %f18, %f19
  asm("add.f32 %0, %1, %2;" : "=f"(f25) : "f"(f18), "f"(f19));
  // PTX:108 add.s64 %rd57, %rd57, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd57) : "l"(rd57));
  // PTX:109 add.s64 %rd56, %rd56, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd56) : "l"(rd56));
  // PTX:110 setp.lt.u64 %p7, %rd56, %rd4
  p7 = (((unsigned long long)(rd56)) < ((unsigned long long)(rd4)));
  // PTX:111 @%p7 bra $L__BB9_8
  if (p7) { goto L_BB9_8; }
  // PTX:113 $L__BB9_9:
L_BB9_9:;
  // PTX:114 cvta.to.global.u64 %rd48, %rd22
  rd48 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd22));
  // PTX:115 shl.b64 %rd49, %rd3, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd49) : "l"(rd3));
  // PTX:116 add.s64 %rd50, %rd48, %rd49
  asm("add.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd48), "l"(rd49));
  // PTX:117 mul.f32 %f20, %f25, 0f40400000
  asm("mul.f32 %0, %1, 0f40400000;" : "=f"(f20) : "f"(f25));
  // PTX:118 st.global.f32 [%rd50], %f20
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (0))))) = (float)(f20);
  // PTX:119 cvta.to.global.u64 %rd51, %rd23
  rd51 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd23));
  // PTX:120 add.s64 %rd52, %rd51, %rd49
  asm("add.s64 %0, %1, %2;" : "=l"(rd52) : "l"(rd51), "l"(rd49));
  // PTX:121 st.global.f32 [%rd52], %f25
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0))))) = (float)(f25);
  // PTX:123 $L__BB9_10:
L_BB9_10:;
  // PTX:124 ret
  return;
}
