// 机械还原自 PTX：synreal::kernel::apply_block_diagonal_preconditioner(glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long)
// PTX SHA256: 72ffe0e92766800b11e3293233839cab397fdbf0b1658079f8fedd3b4f13fb33
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__apply_block_diagonal_preconditioner(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3) {
  int p0, p1;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21;
  unsigned r0, r1, r2, r3;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15;
  // PTX:20 ld.param.u64 %rd2, [_ZN7synreal6kernel35apply_block_diagonal_preconditionerEPKN3glm3matILi3ELi3EfLNS1_9qualifierE0EEEPKNS1_3vecILi3EfLS3_0EEEPS8_m_param_0]
  rd2 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:21 ld.param.u64 %rd3, [_ZN7synreal6kernel35apply_block_diagonal_preconditionerEPKN3glm3matILi3ELi3EfLNS1_9qualifierE0EEEPKNS1_3vecILi3EfLS3_0EEEPS8_m_param_1]
  rd3 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:22 ld.param.u64 %rd4, [_ZN7synreal6kernel35apply_block_diagonal_preconditionerEPKN3glm3matILi3ELi3EfLNS1_9qualifierE0EEEPKNS1_3vecILi3EfLS3_0EEEPS8_m_param_2]
  rd4 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:23 ld.param.u64 %rd5, [_ZN7synreal6kernel35apply_block_diagonal_preconditionerEPKN3glm3matILi3ELi3EfLNS1_9qualifierE0EEEPKNS1_3vecILi3EfLS3_0EEEPS8_m_param_3]
  rd5 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:24 mov.u32 %r1, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r1) : "r"(blockIdx.x));
  // PTX:25 mov.u32 %r2, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockDim.x));
  // PTX:26 mul.wide.u32 %rd6, %r1, %r2
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd6) : "r"(r1), "r"(r2));
  // PTX:27 mov.u32 %r3, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(threadIdx.x));
  // PTX:28 cvt.u64.u32 %rd7, %r3
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd7) : "r"(r3));
  // PTX:29 add.s64 %rd1, %rd6, %rd7
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd6), "l"(rd7));
  // PTX:30 setp.ge.u64 %p1, %rd1, %rd5
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd5)));
  // PTX:31 @%p1 bra $L__BB75_2
  if (p1) { goto L_BB75_2; }
  // PTX:33 cvta.to.global.u64 %rd8, %rd3
  rd8 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd3));
  // PTX:34 mul.lo.s64 %rd9, %rd1, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd9) : "l"(rd1));
  // PTX:35 add.s64 %rd10, %rd8, %rd9
  asm("add.s64 %0, %1, %2;" : "=l"(rd10) : "l"(rd8), "l"(rd9));
  // PTX:36 cvta.to.global.u64 %rd11, %rd2
  rd11 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd2));
  // PTX:37 mul.lo.s64 %rd12, %rd1, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd12) : "l"(rd1));
  // PTX:38 add.s64 %rd13, %rd11, %rd12
  asm("add.s64 %0, %1, %2;" : "=l"(rd13) : "l"(rd11), "l"(rd12));
  // PTX:39 ld.global.f32 %f1, [%rd10]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (0)))));
  // PTX:40 ld.global.f32 %f2, [%rd13]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))));
  // PTX:41 ld.global.f32 %f3, [%rd10+4]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (4)))));
  // PTX:42 ld.global.f32 %f4, [%rd13+12]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (12)))));
  // PTX:43 mul.f32 %f5, %f4, %f3
  asm("mul.f32 %0, %1, %2;" : "=f"(f5) : "f"(f4), "f"(f3));
  // PTX:44 fma.rn.f32 %f6, %f2, %f1, %f5
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f6) : "f"(f2), "f"(f1), "f"(f5));
  // PTX:45 ld.global.f32 %f7, [%rd10+8]
  f7 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (8)))));
  // PTX:46 ld.global.f32 %f8, [%rd13+24]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (24)))));
  // PTX:47 fma.rn.f32 %f9, %f8, %f7, %f6
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f9) : "f"(f8), "f"(f7), "f"(f6));
  // PTX:48 ld.global.f32 %f10, [%rd13+4]
  f10 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4)))));
  // PTX:49 ld.global.f32 %f11, [%rd13+16]
  f11 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (16)))));
  // PTX:50 mul.f32 %f12, %f11, %f3
  asm("mul.f32 %0, %1, %2;" : "=f"(f12) : "f"(f11), "f"(f3));
  // PTX:51 fma.rn.f32 %f13, %f10, %f1, %f12
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f13) : "f"(f10), "f"(f1), "f"(f12));
  // PTX:52 ld.global.f32 %f14, [%rd13+28]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (28)))));
  // PTX:53 fma.rn.f32 %f15, %f14, %f7, %f13
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f15) : "f"(f14), "f"(f7), "f"(f13));
  // PTX:54 ld.global.f32 %f16, [%rd13+8]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8)))));
  // PTX:55 ld.global.f32 %f17, [%rd13+20]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (20)))));
  // PTX:56 mul.f32 %f18, %f17, %f3
  asm("mul.f32 %0, %1, %2;" : "=f"(f18) : "f"(f17), "f"(f3));
  // PTX:57 fma.rn.f32 %f19, %f16, %f1, %f18
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f19) : "f"(f16), "f"(f1), "f"(f18));
  // PTX:58 ld.global.f32 %f20, [%rd13+32]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (32)))));
  // PTX:59 fma.rn.f32 %f21, %f20, %f7, %f19
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f21) : "f"(f20), "f"(f7), "f"(f19));
  // PTX:60 cvta.to.global.u64 %rd14, %rd4
  rd14 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd4));
  // PTX:61 add.s64 %rd15, %rd14, %rd9
  asm("add.s64 %0, %1, %2;" : "=l"(rd15) : "l"(rd14), "l"(rd9));
  // PTX:62 st.global.f32 [%rd15], %f9
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0))))) = (float)(f9);
  // PTX:63 st.global.f32 [%rd15+4], %f15
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (4))))) = (float)(f15);
  // PTX:64 st.global.f32 [%rd15+8], %f21
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (8))))) = (float)(f21);
  // PTX:66 $L__BB75_2:
L_BB75_2:;
  // PTX:67 ret
  return;
}
