// 机械还原自 PTX：synreal::self_collision_kernel::add_hessian_diagonal(glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long)
// PTX SHA256: 707416c7b7081c91c92d37a7866004d075ae7a55a0bb040e9eff7bd03696fba5
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__self_collision_kernel__add_hessian_diagonal(unsigned long long param0, unsigned long long param1, unsigned long long param2) {
  int p0, p1;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27;
  unsigned r0, r1, r2, r3;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11;
  // PTX:19 ld.param.u64 %rd2, [_ZN7synreal21self_collision_kernel20add_hessian_diagonalEPKN3glm3matILi3ELi3EfLNS1_9qualifierE0EEEPS4_m_param_0]
  rd2 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:20 ld.param.u64 %rd3, [_ZN7synreal21self_collision_kernel20add_hessian_diagonalEPKN3glm3matILi3ELi3EfLNS1_9qualifierE0EEEPS4_m_param_1]
  rd3 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:21 ld.param.u64 %rd4, [_ZN7synreal21self_collision_kernel20add_hessian_diagonalEPKN3glm3matILi3ELi3EfLNS1_9qualifierE0EEEPS4_m_param_2]
  rd4 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:22 mov.u32 %r1, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r1) : "r"(blockIdx.x));
  // PTX:23 mov.u32 %r2, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockDim.x));
  // PTX:24 mul.wide.u32 %rd5, %r1, %r2
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd5) : "r"(r1), "r"(r2));
  // PTX:25 mov.u32 %r3, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(threadIdx.x));
  // PTX:26 cvt.u64.u32 %rd6, %r3
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd6) : "r"(r3));
  // PTX:27 add.s64 %rd1, %rd5, %rd6
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd5), "l"(rd6));
  // PTX:28 setp.ge.u64 %p1, %rd1, %rd4
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd4)));
  // PTX:29 @%p1 bra $L__BB13_2
  if (p1) { goto L_BB13_2; }
  // PTX:31 cvta.to.global.u64 %rd7, %rd3
  rd7 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd3));
  // PTX:32 mul.lo.s64 %rd8, %rd1, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd8) : "l"(rd1));
  // PTX:33 add.s64 %rd9, %rd7, %rd8
  asm("add.s64 %0, %1, %2;" : "=l"(rd9) : "l"(rd7), "l"(rd8));
  // PTX:34 cvta.to.global.u64 %rd10, %rd2
  rd10 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd2));
  // PTX:35 add.s64 %rd11, %rd10, %rd8
  asm("add.s64 %0, %1, %2;" : "=l"(rd11) : "l"(rd10), "l"(rd8));
  // PTX:36 ld.global.f32 %f1, [%rd11]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (0)))));
  // PTX:37 ld.global.f32 %f2, [%rd9]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (0)))));
  // PTX:38 add.f32 %f3, %f2, %f1
  asm("add.f32 %0, %1, %2;" : "=f"(f3) : "f"(f2), "f"(f1));
  // PTX:39 ld.global.f32 %f4, [%rd11+4]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (4)))));
  // PTX:40 ld.global.f32 %f5, [%rd9+4]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (4)))));
  // PTX:41 add.f32 %f6, %f5, %f4
  asm("add.f32 %0, %1, %2;" : "=f"(f6) : "f"(f5), "f"(f4));
  // PTX:42 ld.global.f32 %f7, [%rd11+8]
  f7 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (8)))));
  // PTX:43 ld.global.f32 %f8, [%rd9+8]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (8)))));
  // PTX:44 add.f32 %f9, %f8, %f7
  asm("add.f32 %0, %1, %2;" : "=f"(f9) : "f"(f8), "f"(f7));
  // PTX:45 ld.global.f32 %f10, [%rd11+12]
  f10 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (12)))));
  // PTX:46 ld.global.f32 %f11, [%rd9+12]
  f11 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (12)))));
  // PTX:47 add.f32 %f12, %f11, %f10
  asm("add.f32 %0, %1, %2;" : "=f"(f12) : "f"(f11), "f"(f10));
  // PTX:48 ld.global.f32 %f13, [%rd11+16]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (16)))));
  // PTX:49 ld.global.f32 %f14, [%rd9+16]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (16)))));
  // PTX:50 add.f32 %f15, %f14, %f13
  asm("add.f32 %0, %1, %2;" : "=f"(f15) : "f"(f14), "f"(f13));
  // PTX:51 ld.global.f32 %f16, [%rd11+20]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (20)))));
  // PTX:52 ld.global.f32 %f17, [%rd9+20]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (20)))));
  // PTX:53 add.f32 %f18, %f17, %f16
  asm("add.f32 %0, %1, %2;" : "=f"(f18) : "f"(f17), "f"(f16));
  // PTX:54 ld.global.f32 %f19, [%rd11+24]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (24)))));
  // PTX:55 ld.global.f32 %f20, [%rd9+24]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (24)))));
  // PTX:56 add.f32 %f21, %f20, %f19
  asm("add.f32 %0, %1, %2;" : "=f"(f21) : "f"(f20), "f"(f19));
  // PTX:57 ld.global.f32 %f22, [%rd11+28]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (28)))));
  // PTX:58 ld.global.f32 %f23, [%rd9+28]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (28)))));
  // PTX:59 add.f32 %f24, %f23, %f22
  asm("add.f32 %0, %1, %2;" : "=f"(f24) : "f"(f23), "f"(f22));
  // PTX:60 ld.global.f32 %f25, [%rd11+32]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (32)))));
  // PTX:61 ld.global.f32 %f26, [%rd9+32]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (32)))));
  // PTX:62 add.f32 %f27, %f26, %f25
  asm("add.f32 %0, %1, %2;" : "=f"(f27) : "f"(f26), "f"(f25));
  // PTX:63 st.global.f32 [%rd9], %f3
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (0))))) = (float)(f3);
  // PTX:64 st.global.f32 [%rd9+4], %f6
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (4))))) = (float)(f6);
  // PTX:65 st.global.f32 [%rd9+8], %f9
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (8))))) = (float)(f9);
  // PTX:66 st.global.f32 [%rd9+12], %f12
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (12))))) = (float)(f12);
  // PTX:67 st.global.f32 [%rd9+16], %f15
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (16))))) = (float)(f15);
  // PTX:68 st.global.f32 [%rd9+20], %f18
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (20))))) = (float)(f18);
  // PTX:69 st.global.f32 [%rd9+24], %f21
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (24))))) = (float)(f21);
  // PTX:70 st.global.f32 [%rd9+28], %f24
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (28))))) = (float)(f24);
  // PTX:71 st.global.f32 [%rd9+32], %f27
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (32))))) = (float)(f27);
  // PTX:73 $L__BB13_2:
L_BB13_2:;
  // PTX:74 ret
  return;
}
