// 机械还原自 PTX：synreal::granular_kernel::add_diagonal(glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0>*, int)
// PTX SHA256: 0943e105da43d867c9dd2b2727f72e32e94e2c4c5aae6914cb6904be6765060b
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__granular_kernel__add_diagonal(unsigned long long param0, unsigned long long param1, unsigned param2) {
  int p0, p1;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27;
  unsigned r0, r1, r2, r3, r4, r5;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7;
  // PTX:19 ld.param.u64 %rd1, [_ZN7synreal15granular_kernel12add_diagonalEPKN3glm3matILi3ELi3EfLNS1_9qualifierE0EEEPS4_i_param_0]
  rd1 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:20 ld.param.u64 %rd2, [_ZN7synreal15granular_kernel12add_diagonalEPKN3glm3matILi3ELi3EfLNS1_9qualifierE0EEEPS4_i_param_1]
  rd2 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:21 ld.param.u32 %r2, [_ZN7synreal15granular_kernel12add_diagonalEPKN3glm3matILi3ELi3EfLNS1_9qualifierE0EEEPS4_i_param_2]
  r2 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param2 + (0))));
  // PTX:22 mov.u32 %r3, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(blockDim.x));
  // PTX:23 mov.u32 %r4, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r4) : "r"(blockIdx.x));
  // PTX:24 mov.u32 %r5, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r5) : "r"(threadIdx.x));
  // PTX:25 mad.lo.s32 %r1, %r4, %r3, %r5
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r1) : "r"(r4), "r"(r3), "r"(r5));
  // PTX:26 setp.ge.s32 %p1, %r1, %r2
  p1 = (((int)(r1)) >= ((int)(r2)));
  // PTX:27 @%p1 bra $L__BB7_2
  if (p1) { goto L_BB7_2; }
  // PTX:29 cvta.to.global.u64 %rd3, %rd2
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd2));
  // PTX:30 mul.wide.s32 %rd4, %r1, 36
  asm("mul.wide.s32 %0, %1, 36;" : "=l"(rd4) : "r"(r1));
  // PTX:31 add.s64 %rd5, %rd3, %rd4
  asm("add.s64 %0, %1, %2;" : "=l"(rd5) : "l"(rd3), "l"(rd4));
  // PTX:32 cvta.to.global.u64 %rd6, %rd1
  rd6 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd1));
  // PTX:33 add.s64 %rd7, %rd6, %rd4
  asm("add.s64 %0, %1, %2;" : "=l"(rd7) : "l"(rd6), "l"(rd4));
  // PTX:34 ld.global.f32 %f1, [%rd5]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (0)))));
  // PTX:35 ld.global.f32 %f2, [%rd7]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd7) + (0)))));
  // PTX:36 add.f32 %f3, %f2, %f1
  asm("add.f32 %0, %1, %2;" : "=f"(f3) : "f"(f2), "f"(f1));
  // PTX:37 st.global.f32 [%rd5], %f3
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (0))))) = (float)(f3);
  // PTX:38 ld.global.f32 %f4, [%rd5+4]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (4)))));
  // PTX:39 ld.global.f32 %f5, [%rd7+4]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd7) + (4)))));
  // PTX:40 add.f32 %f6, %f5, %f4
  asm("add.f32 %0, %1, %2;" : "=f"(f6) : "f"(f5), "f"(f4));
  // PTX:41 st.global.f32 [%rd5+4], %f6
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (4))))) = (float)(f6);
  // PTX:42 ld.global.f32 %f7, [%rd5+8]
  f7 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (8)))));
  // PTX:43 ld.global.f32 %f8, [%rd7+8]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd7) + (8)))));
  // PTX:44 add.f32 %f9, %f8, %f7
  asm("add.f32 %0, %1, %2;" : "=f"(f9) : "f"(f8), "f"(f7));
  // PTX:45 st.global.f32 [%rd5+8], %f9
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (8))))) = (float)(f9);
  // PTX:46 ld.global.f32 %f10, [%rd5+12]
  f10 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (12)))));
  // PTX:47 ld.global.f32 %f11, [%rd7+12]
  f11 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd7) + (12)))));
  // PTX:48 add.f32 %f12, %f11, %f10
  asm("add.f32 %0, %1, %2;" : "=f"(f12) : "f"(f11), "f"(f10));
  // PTX:49 st.global.f32 [%rd5+12], %f12
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (12))))) = (float)(f12);
  // PTX:50 ld.global.f32 %f13, [%rd5+16]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (16)))));
  // PTX:51 ld.global.f32 %f14, [%rd7+16]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd7) + (16)))));
  // PTX:52 add.f32 %f15, %f14, %f13
  asm("add.f32 %0, %1, %2;" : "=f"(f15) : "f"(f14), "f"(f13));
  // PTX:53 st.global.f32 [%rd5+16], %f15
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (16))))) = (float)(f15);
  // PTX:54 ld.global.f32 %f16, [%rd5+20]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (20)))));
  // PTX:55 ld.global.f32 %f17, [%rd7+20]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd7) + (20)))));
  // PTX:56 add.f32 %f18, %f17, %f16
  asm("add.f32 %0, %1, %2;" : "=f"(f18) : "f"(f17), "f"(f16));
  // PTX:57 st.global.f32 [%rd5+20], %f18
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (20))))) = (float)(f18);
  // PTX:58 ld.global.f32 %f19, [%rd5+24]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (24)))));
  // PTX:59 ld.global.f32 %f20, [%rd7+24]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd7) + (24)))));
  // PTX:60 add.f32 %f21, %f20, %f19
  asm("add.f32 %0, %1, %2;" : "=f"(f21) : "f"(f20), "f"(f19));
  // PTX:61 st.global.f32 [%rd5+24], %f21
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (24))))) = (float)(f21);
  // PTX:62 ld.global.f32 %f22, [%rd5+28]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (28)))));
  // PTX:63 ld.global.f32 %f23, [%rd7+28]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd7) + (28)))));
  // PTX:64 add.f32 %f24, %f23, %f22
  asm("add.f32 %0, %1, %2;" : "=f"(f24) : "f"(f23), "f"(f22));
  // PTX:65 st.global.f32 [%rd5+28], %f24
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (28))))) = (float)(f24);
  // PTX:66 ld.global.f32 %f25, [%rd5+32]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (32)))));
  // PTX:67 ld.global.f32 %f26, [%rd7+32]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd7) + (32)))));
  // PTX:68 add.f32 %f27, %f26, %f25
  asm("add.f32 %0, %1, %2;" : "=f"(f27) : "f"(f26), "f"(f25));
  // PTX:69 st.global.f32 [%rd5+32], %f27
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd5) + (32))))) = (float)(f27);
  // PTX:71 $L__BB7_2:
L_BB7_2:;
  // PTX:72 ret
  return;
}
