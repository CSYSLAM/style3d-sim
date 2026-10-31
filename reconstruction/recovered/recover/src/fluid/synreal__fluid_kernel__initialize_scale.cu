// 机械还原自 PTX：synreal::fluid_kernel::initialize_scale(float*, float, int)
// PTX SHA256: a85f94f7ced89bf56067f952d9e49ea2734cd156c74e10417dac91204083e240
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__fluid_kernel__initialize_scale(unsigned long long param0, float param1, unsigned param2) {
  int p0, p1;
  float f0, f1;
  unsigned r0, r1, r2, r3, r4, r5;
  unsigned long long rd0, rd1, rd2, rd3, rd4;
  // PTX:19 ld.param.u64 %rd1, [_ZN7synreal12fluid_kernel16initialize_scaleEPffi_param_0]
  rd1 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:20 ld.param.f32 %f1, [_ZN7synreal12fluid_kernel16initialize_scaleEPffi_param_1]
  f1 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param1 + (0))));
  // PTX:21 ld.param.u32 %r2, [_ZN7synreal12fluid_kernel16initialize_scaleEPffi_param_2]
  r2 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param2 + (0))));
  // PTX:22 mov.u32 %r3, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(blockIdx.x));
  // PTX:23 mov.u32 %r4, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r4) : "r"(blockDim.x));
  // PTX:24 mov.u32 %r5, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r5) : "r"(threadIdx.x));
  // PTX:25 mad.lo.s32 %r1, %r3, %r4, %r5
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r1) : "r"(r3), "r"(r4), "r"(r5));
  // PTX:26 setp.ge.s32 %p1, %r1, %r2
  p1 = (((int)(r1)) >= ((int)(r2)));
  // PTX:27 @%p1 bra $L__BB5_2
  if (p1) { goto L_BB5_2; }
  // PTX:29 cvta.to.global.u64 %rd2, %rd1
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd1));
  // PTX:30 mul.wide.s32 %rd3, %r1, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd3) : "r"(r1));
  // PTX:31 add.s64 %rd4, %rd2, %rd3
  asm("add.s64 %0, %1, %2;" : "=l"(rd4) : "l"(rd2), "l"(rd3));
  // PTX:32 st.global.f32 [%rd4], %f1
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd4) + (0))))) = (float)(f1);
  // PTX:34 $L__BB5_2:
L_BB5_2:;
  // PTX:35 ret
  return;
}
