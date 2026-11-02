// 机械还原自 PTX：synreal::kernel::initialize_block_non_diagonal(synreal::NonZeroEntry const*, int const*, unsigned long, unsigned long, synreal::BlockNonZeroEntry*, unsigned long)
// PTX SHA256: 219dc72537da9557b736772624a88a5d97c8bfe6cc8e5973e8101e0a38da9ef9
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__initialize_block_non_diagonal(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5) {
  int p0, p1, p2, p3, p4;
  float f0, f1, f2;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40;
  // PTX:22 ld.param.u64 %rd11, [_ZN7synreal6kernel29initialize_block_non_diagonalEPKNS_12NonZeroEntryEPKimmPNS_17BlockNonZeroEntryEm_param_0]
  rd11 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:23 ld.param.u64 %rd12, [_ZN7synreal6kernel29initialize_block_non_diagonalEPKNS_12NonZeroEntryEPKimmPNS_17BlockNonZeroEntryEm_param_1]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:24 ld.param.u64 %rd13, [_ZN7synreal6kernel29initialize_block_non_diagonalEPKNS_12NonZeroEntryEPKimmPNS_17BlockNonZeroEntryEm_param_2]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:25 ld.param.u64 %rd16, [_ZN7synreal6kernel29initialize_block_non_diagonalEPKNS_12NonZeroEntryEPKimmPNS_17BlockNonZeroEntryEm_param_3]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:26 ld.param.u64 %rd14, [_ZN7synreal6kernel29initialize_block_non_diagonalEPKNS_12NonZeroEntryEPKimmPNS_17BlockNonZeroEntryEm_param_4]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:27 ld.param.u64 %rd15, [_ZN7synreal6kernel29initialize_block_non_diagonalEPKNS_12NonZeroEntryEPKimmPNS_17BlockNonZeroEntryEm_param_5]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:28 mov.u32 %r1, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r1) : "r"(blockIdx.x));
  // PTX:29 mov.u32 %r2, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockDim.x));
  // PTX:30 mul.wide.u32 %rd17, %r1, %r2
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd17) : "r"(r1), "r"(r2));
  // PTX:31 mov.u32 %r3, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(threadIdx.x));
  // PTX:32 cvt.u64.u32 %rd18, %r3
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd18) : "r"(r3));
  // PTX:33 add.s64 %rd1, %rd17, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd17), "l"(rd18));
  // PTX:34 mul.lo.s64 %rd19, %rd15, %rd16
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd15), "l"(rd16));
  // PTX:35 setp.ge.u64 %p1, %rd1, %rd19
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd19)));
  // PTX:36 @%p1 bra $L__BB51_9
  if (p1) { goto L_BB51_9; }
  // PTX:38 or.b64 %rd20, %rd1, %rd15
  asm("or.b64 %0, %1, %2;" : "=l"(rd20) : "l"(rd1), "l"(rd15));
  // PTX:39 and.b64 %rd21, %rd20, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd21) : "l"(rd20));
  // PTX:40 setp.eq.s64 %p2, %rd21, 0
  p2 = (((long long)(rd21)) == ((long long)(0)));
  // PTX:41 @%p2 bra $L__BB51_3
  if (p2) { goto L_BB51_3; }
  // PTX:43 div.u64 %rd38, %rd1, %rd15
  asm("div.u64 %0, %1, %2;" : "=l"(rd38) : "l"(rd1), "l"(rd15));
  // PTX:44 mul.lo.s64 %rd22, %rd38, %rd15
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd22) : "l"(rd38), "l"(rd15));
  // PTX:45 sub.s64 %rd39, %rd1, %rd22
  asm("sub.s64 %0, %1, %2;" : "=l"(rd39) : "l"(rd1), "l"(rd22));
  // PTX:46 bra.uni $L__BB51_4
  goto L_BB51_4;
  // PTX:48 $L__BB51_3:
L_BB51_3:;
  // PTX:49 cvt.u32.u64 %r4, %rd15
  asm("cvt.u32.u64 %0, %1;" : "=r"(r4) : "l"(rd15));
  // PTX:50 cvt.u32.u64 %r5, %rd1
  asm("cvt.u32.u64 %0, %1;" : "=r"(r5) : "l"(rd1));
  // PTX:51 div.u32 %r6, %r5, %r4
  asm("div.u32 %0, %1, %2;" : "=r"(r6) : "r"(r5), "r"(r4));
  // PTX:52 mul.lo.s32 %r7, %r6, %r4
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r7) : "r"(r6), "r"(r4));
  // PTX:53 sub.s32 %r8, %r5, %r7
  asm("sub.s32 %0, %1, %2;" : "=r"(r8) : "r"(r5), "r"(r7));
  // PTX:54 cvt.u64.u32 %rd38, %r6
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd38) : "r"(r6));
  // PTX:55 cvt.u64.u32 %rd39, %r8
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd39) : "r"(r8));
  // PTX:57 $L__BB51_4:
L_BB51_4:;
  // PTX:58 or.b64 %rd23, %rd39, %rd13
  asm("or.b64 %0, %1, %2;" : "=l"(rd23) : "l"(rd39), "l"(rd13));
  // PTX:59 and.b64 %rd24, %rd23, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd24) : "l"(rd23));
  // PTX:60 setp.eq.s64 %p3, %rd24, 0
  p3 = (((long long)(rd24)) == ((long long)(0)));
  // PTX:61 @%p3 bra $L__BB51_6
  if (p3) { goto L_BB51_6; }
  // PTX:63 rem.u64 %rd40, %rd39, %rd13
  asm("rem.u64 %0, %1, %2;" : "=l"(rd40) : "l"(rd39), "l"(rd13));
  // PTX:64 bra.uni $L__BB51_7
  goto L_BB51_7;
  // PTX:66 $L__BB51_6:
L_BB51_6:;
  // PTX:67 cvt.u32.u64 %r9, %rd13
  asm("cvt.u32.u64 %0, %1;" : "=r"(r9) : "l"(rd13));
  // PTX:68 cvt.u32.u64 %r10, %rd39
  asm("cvt.u32.u64 %0, %1;" : "=r"(r10) : "l"(rd39));
  // PTX:69 rem.u32 %r11, %r10, %r9
  asm("rem.u32 %0, %1, %2;" : "=r"(r11) : "r"(r10), "r"(r9));
  // PTX:70 cvt.u64.u32 %rd40, %r11
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd40) : "r"(r11));
  // PTX:72 $L__BB51_7:
L_BB51_7:;
  // PTX:73 cvta.to.global.u64 %rd25, %rd12
  rd25 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd12));
  // PTX:74 shl.b64 %rd26, %rd40, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd26) : "l"(rd40));
  // PTX:75 add.s64 %rd27, %rd25, %rd26
  asm("add.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd25), "l"(rd26));
  // PTX:76 ld.global.s32 %rd28, [%rd27]
  rd28 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))));
  // PTX:77 setp.ge.u64 %p4, %rd38, %rd28
  p4 = (((unsigned long long)(rd38)) >= ((unsigned long long)(rd28)));
  // PTX:78 @%p4 bra $L__BB51_9
  if (p4) { goto L_BB51_9; }
  // PTX:80 sub.s64 %rd29, %rd39, %rd40
  asm("sub.s64 %0, %1, %2;" : "=l"(rd29) : "l"(rd39), "l"(rd40));
  // PTX:81 mul.lo.s64 %rd30, %rd38, %rd13
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd30) : "l"(rd38), "l"(rd13));
  // PTX:82 add.s64 %rd31, %rd30, %rd40
  asm("add.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd30), "l"(rd40));
  // PTX:83 cvta.to.global.u64 %rd32, %rd11
  rd32 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd11));
  // PTX:84 shl.b64 %rd33, %rd31, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd33) : "l"(rd31));
  // PTX:85 add.s64 %rd34, %rd32, %rd33
  asm("add.s64 %0, %1, %2;" : "=l"(rd34) : "l"(rd32), "l"(rd33));
  // PTX:86 ld.global.f32 %f1, [%rd34+4]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (4)))));
  // PTX:87 cvt.u32.u64 %r12, %rd29
  asm("cvt.u32.u64 %0, %1;" : "=r"(r12) : "l"(rd29));
  // PTX:88 ld.global.u32 %r13, [%rd34]
  r13 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (0)))));
  // PTX:89 add.s32 %r14, %r13, %r12
  asm("add.s32 %0, %1, %2;" : "=r"(r14) : "r"(r13), "r"(r12));
  // PTX:90 cvta.to.global.u64 %rd35, %rd14
  rd35 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd14));
  // PTX:91 mul.lo.s64 %rd36, %rd1, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd36) : "l"(rd1));
  // PTX:92 add.s64 %rd37, %rd35, %rd36
  asm("add.s64 %0, %1, %2;" : "=l"(rd37) : "l"(rd35), "l"(rd36));
  // PTX:93 st.global.u32 [%rd37], %r14
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (0))))) = (unsigned)(r14);
  // PTX:94 mul.f32 %f2, %f1, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f2) : "f"(f1));
  // PTX:95 st.global.f32 [%rd37+4], %f1
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (4))))) = (float)(f1);
  // PTX:96 st.global.f32 [%rd37+8], %f2
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (8))))) = (float)(f2);
  // PTX:97 st.global.f32 [%rd37+12], %f2
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (12))))) = (float)(f2);
  // PTX:98 st.global.f32 [%rd37+16], %f2
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (16))))) = (float)(f2);
  // PTX:99 st.global.f32 [%rd37+20], %f1
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (20))))) = (float)(f1);
  // PTX:100 st.global.f32 [%rd37+24], %f2
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (24))))) = (float)(f2);
  // PTX:101 st.global.f32 [%rd37+28], %f2
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (28))))) = (float)(f2);
  // PTX:102 st.global.f32 [%rd37+32], %f2
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (32))))) = (float)(f2);
  // PTX:103 st.global.f32 [%rd37+36], %f1
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (36))))) = (float)(f1);
  // PTX:105 $L__BB51_9:
L_BB51_9:;
  // PTX:106 ret
  return;
}
