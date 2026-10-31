// 机械还原自 PTX：synreal::kernel::combine_system_non_diagonal(float, float, float, float, float, float, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry*, unsigned long)
// PTX SHA256: f4e968f4fbf1bca7c5fbd843477f563f4052c409edd07f3e6263da16d344a8cd
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__combine_system_non_diagonal(float param0, float param1, float param2, float param3, float param4, float param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10, unsigned long long param11, unsigned long long param12, unsigned long long param13, unsigned long long param14) {
  int p0, p1;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19;
  unsigned r0, r1, r2, r3, r4;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29;
  // PTX:31 ld.param.f32 %f1, [_ZN7synreal6kernel27combine_system_non_diagonalEffffffPKNS_12NonZeroEntryES3_S3_S3_S3_S3_S3_PS1_m_param_0]
  f1 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (0))));
  // PTX:32 ld.param.f32 %f2, [_ZN7synreal6kernel27combine_system_non_diagonalEffffffPKNS_12NonZeroEntryES3_S3_S3_S3_S3_S3_PS1_m_param_1]
  f2 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param1 + (0))));
  // PTX:33 ld.param.f32 %f3, [_ZN7synreal6kernel27combine_system_non_diagonalEffffffPKNS_12NonZeroEntryES3_S3_S3_S3_S3_S3_PS1_m_param_2]
  f3 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param2 + (0))));
  // PTX:34 ld.param.f32 %f4, [_ZN7synreal6kernel27combine_system_non_diagonalEffffffPKNS_12NonZeroEntryES3_S3_S3_S3_S3_S3_PS1_m_param_3]
  f4 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param3 + (0))));
  // PTX:35 ld.param.f32 %f5, [_ZN7synreal6kernel27combine_system_non_diagonalEffffffPKNS_12NonZeroEntryES3_S3_S3_S3_S3_S3_PS1_m_param_4]
  f5 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param4 + (0))));
  // PTX:36 ld.param.f32 %f6, [_ZN7synreal6kernel27combine_system_non_diagonalEffffffPKNS_12NonZeroEntryES3_S3_S3_S3_S3_S3_PS1_m_param_5]
  f6 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param5 + (0))));
  // PTX:37 ld.param.u64 %rd2, [_ZN7synreal6kernel27combine_system_non_diagonalEffffffPKNS_12NonZeroEntryES3_S3_S3_S3_S3_S3_PS1_m_param_6]
  rd2 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:38 ld.param.u64 %rd3, [_ZN7synreal6kernel27combine_system_non_diagonalEffffffPKNS_12NonZeroEntryES3_S3_S3_S3_S3_S3_PS1_m_param_7]
  rd3 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:39 ld.param.u64 %rd4, [_ZN7synreal6kernel27combine_system_non_diagonalEffffffPKNS_12NonZeroEntryES3_S3_S3_S3_S3_S3_PS1_m_param_8]
  rd4 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:40 ld.param.u64 %rd5, [_ZN7synreal6kernel27combine_system_non_diagonalEffffffPKNS_12NonZeroEntryES3_S3_S3_S3_S3_S3_PS1_m_param_9]
  rd5 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:41 ld.param.u64 %rd6, [_ZN7synreal6kernel27combine_system_non_diagonalEffffffPKNS_12NonZeroEntryES3_S3_S3_S3_S3_S3_PS1_m_param_10]
  rd6 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:42 ld.param.u64 %rd7, [_ZN7synreal6kernel27combine_system_non_diagonalEffffffPKNS_12NonZeroEntryES3_S3_S3_S3_S3_S3_PS1_m_param_11]
  rd7 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:43 ld.param.u64 %rd8, [_ZN7synreal6kernel27combine_system_non_diagonalEffffffPKNS_12NonZeroEntryES3_S3_S3_S3_S3_S3_PS1_m_param_12]
  rd8 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:44 ld.param.u64 %rd9, [_ZN7synreal6kernel27combine_system_non_diagonalEffffffPKNS_12NonZeroEntryES3_S3_S3_S3_S3_S3_PS1_m_param_13]
  rd9 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:45 ld.param.u64 %rd10, [_ZN7synreal6kernel27combine_system_non_diagonalEffffffPKNS_12NonZeroEntryES3_S3_S3_S3_S3_S3_PS1_m_param_14]
  rd10 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:46 mov.u32 %r1, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r1) : "r"(blockIdx.x));
  // PTX:47 mov.u32 %r2, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockDim.x));
  // PTX:48 mul.wide.u32 %rd11, %r1, %r2
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd11) : "r"(r1), "r"(r2));
  // PTX:49 mov.u32 %r3, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(threadIdx.x));
  // PTX:50 cvt.u64.u32 %rd12, %r3
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd12) : "r"(r3));
  // PTX:51 add.s64 %rd1, %rd11, %rd12
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd11), "l"(rd12));
  // PTX:52 setp.ge.u64 %p1, %rd1, %rd10
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd10)));
  // PTX:53 @%p1 bra $L__BB10_2
  if (p1) { goto L_BB10_2; }
  // PTX:55 cvta.to.global.u64 %rd13, %rd3
  rd13 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd3));
  // PTX:56 cvta.to.global.u64 %rd14, %rd2
  rd14 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd2));
  // PTX:57 shl.b64 %rd15, %rd1, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd15) : "l"(rd1));
  // PTX:58 add.s64 %rd16, %rd14, %rd15
  asm("add.s64 %0, %1, %2;" : "=l"(rd16) : "l"(rd14), "l"(rd15));
  // PTX:59 ld.global.u32 %r4, [%rd16]
  r4 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:60 cvta.to.global.u64 %rd17, %rd9
  rd17 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd9));
  // PTX:61 add.s64 %rd18, %rd17, %rd15
  asm("add.s64 %0, %1, %2;" : "=l"(rd18) : "l"(rd17), "l"(rd15));
  // PTX:62 st.global.u32 [%rd18], %r4
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (0))))) = (unsigned)(r4);
  // PTX:63 add.s64 %rd19, %rd13, %rd15
  asm("add.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd13), "l"(rd15));
  // PTX:64 cvta.to.global.u64 %rd20, %rd4
  rd20 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd4));
  // PTX:65 add.s64 %rd21, %rd20, %rd15
  asm("add.s64 %0, %1, %2;" : "=l"(rd21) : "l"(rd20), "l"(rd15));
  // PTX:66 ld.global.f32 %f7, [%rd21+4]
  f7 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (4)))));
  // PTX:67 ld.global.f32 %f8, [%rd19+4]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (4)))));
  // PTX:68 fma.rn.f32 %f9, %f7, %f2, %f8
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f9) : "f"(f7), "f"(f2), "f"(f8));
  // PTX:69 cvta.to.global.u64 %rd22, %rd5
  rd22 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd5));
  // PTX:70 add.s64 %rd23, %rd22, %rd15
  asm("add.s64 %0, %1, %2;" : "=l"(rd23) : "l"(rd22), "l"(rd15));
  // PTX:71 ld.global.f32 %f10, [%rd23+4]
  f10 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (4)))));
  // PTX:72 fma.rn.f32 %f11, %f10, %f3, %f9
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f11) : "f"(f10), "f"(f3), "f"(f9));
  // PTX:73 cvta.to.global.u64 %rd24, %rd6
  rd24 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd6));
  // PTX:74 add.s64 %rd25, %rd24, %rd15
  asm("add.s64 %0, %1, %2;" : "=l"(rd25) : "l"(rd24), "l"(rd15));
  // PTX:75 ld.global.f32 %f12, [%rd25+4]
  f12 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (4)))));
  // PTX:76 fma.rn.f32 %f13, %f12, %f4, %f11
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f13) : "f"(f12), "f"(f4), "f"(f11));
  // PTX:77 cvta.to.global.u64 %rd26, %rd7
  rd26 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd7));
  // PTX:78 add.s64 %rd27, %rd26, %rd15
  asm("add.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd26), "l"(rd15));
  // PTX:79 ld.global.f32 %f14, [%rd27+4]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (4)))));
  // PTX:80 fma.rn.f32 %f15, %f14, %f5, %f13
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f15) : "f"(f14), "f"(f5), "f"(f13));
  // PTX:81 cvta.to.global.u64 %rd28, %rd8
  rd28 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd8));
  // PTX:82 add.s64 %rd29, %rd28, %rd15
  asm("add.s64 %0, %1, %2;" : "=l"(rd29) : "l"(rd28), "l"(rd15));
  // PTX:83 ld.global.f32 %f16, [%rd29+4]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd29) + (4)))));
  // PTX:84 fma.rn.f32 %f17, %f16, %f6, %f15
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f17) : "f"(f16), "f"(f6), "f"(f15));
  // PTX:85 ld.global.f32 %f18, [%rd16+4]
  f18 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (4)))));
  // PTX:86 fma.rn.f32 %f19, %f17, %f1, %f18
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f19) : "f"(f17), "f"(f1), "f"(f18));
  // PTX:87 st.global.f32 [%rd18+4], %f19
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (4))))) = (float)(f19);
  // PTX:89 $L__BB10_2:
L_BB10_2:;
  // PTX:90 ret
  return;
}
