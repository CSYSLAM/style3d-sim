// 机械还原自 PTX：synreal::kernel::prepare_inverse_preconditioner(float const*, float const*, int const*, float*, unsigned long, unsigned long)
// PTX SHA256: 59b09130dc091737a5f364ebf0101cb7fa93339ddb90fca8c37ebef0a5b334f1
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__prepare_inverse_preconditioner(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12;
  float f0, f1, f2, f3, f4, f5, f6;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27;
  // PTX:22 ld.param.u64 %rd5, [_ZN7synreal6kernel30prepare_inverse_preconditionerEPKfS2_PKiPfmm_param_0]
  rd5 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:23 ld.param.u64 %rd6, [_ZN7synreal6kernel30prepare_inverse_preconditionerEPKfS2_PKiPfmm_param_1]
  rd6 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:24 ld.param.u64 %rd7, [_ZN7synreal6kernel30prepare_inverse_preconditionerEPKfS2_PKiPfmm_param_2]
  rd7 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:25 ld.param.u64 %rd8, [_ZN7synreal6kernel30prepare_inverse_preconditionerEPKfS2_PKiPfmm_param_3]
  rd8 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:26 ld.param.u64 %rd10, [_ZN7synreal6kernel30prepare_inverse_preconditionerEPKfS2_PKiPfmm_param_4]
  rd10 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:27 ld.param.u64 %rd9, [_ZN7synreal6kernel30prepare_inverse_preconditionerEPKfS2_PKiPfmm_param_5]
  rd9 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:28 mov.u32 %r1, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r1) : "r"(blockIdx.x));
  // PTX:29 mov.u32 %r2, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockDim.x));
  // PTX:30 mul.wide.u32 %rd11, %r1, %r2
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd11) : "r"(r1), "r"(r2));
  // PTX:31 mov.u32 %r3, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(threadIdx.x));
  // PTX:32 cvt.u64.u32 %rd12, %r3
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd12) : "r"(r3));
  // PTX:33 add.s64 %rd1, %rd11, %rd12
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd11), "l"(rd12));
  // PTX:34 setp.ge.u64 %p3, %rd1, %rd10
  p3 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd10)));
  // PTX:35 @%p3 bra $L__BB49_10
  if (p3) { goto L_BB49_10; }
  // PTX:37 or.b64 %rd13, %rd1, %rd9
  asm("or.b64 %0, %1, %2;" : "=l"(rd13) : "l"(rd1), "l"(rd9));
  // PTX:38 and.b64 %rd14, %rd13, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd14) : "l"(rd13));
  // PTX:39 setp.eq.s64 %p4, %rd14, 0
  p4 = (((long long)(rd14)) == ((long long)(0)));
  // PTX:40 @%p4 bra $L__BB49_3
  if (p4) { goto L_BB49_3; }
  // PTX:42 rem.u64 %rd27, %rd1, %rd9
  asm("rem.u64 %0, %1, %2;" : "=l"(rd27) : "l"(rd1), "l"(rd9));
  // PTX:43 bra.uni $L__BB49_4
  goto L_BB49_4;
  // PTX:45 $L__BB49_3:
L_BB49_3:;
  // PTX:46 cvt.u32.u64 %r4, %rd9
  asm("cvt.u32.u64 %0, %1;" : "=r"(r4) : "l"(rd9));
  // PTX:47 cvt.u32.u64 %r5, %rd1
  asm("cvt.u32.u64 %0, %1;" : "=r"(r5) : "l"(rd1));
  // PTX:48 rem.u32 %r6, %r5, %r4
  asm("rem.u32 %0, %1, %2;" : "=r"(r6) : "r"(r5), "r"(r4));
  // PTX:49 cvt.u64.u32 %rd27, %r6
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd27) : "r"(r6));
  // PTX:51 $L__BB49_4:
L_BB49_4:;
  // PTX:52 cvta.to.global.u64 %rd15, %rd5
  rd15 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd5));
  // PTX:53 shl.b64 %rd16, %rd1, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd16) : "l"(rd1));
  // PTX:54 add.s64 %rd17, %rd15, %rd16
  asm("add.s64 %0, %1, %2;" : "=l"(rd17) : "l"(rd15), "l"(rd16));
  // PTX:55 ld.global.f32 %f1, [%rd17]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:56 cvta.to.global.u64 %rd18, %rd6
  rd18 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd6));
  // PTX:57 shl.b64 %rd19, %rd27, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd19) : "l"(rd27));
  // PTX:58 add.s64 %rd20, %rd18, %rd19
  asm("add.s64 %0, %1, %2;" : "=l"(rd20) : "l"(rd18), "l"(rd19));
  // PTX:59 ld.global.f32 %f4, [%rd20]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))));
  // PTX:60 setp.leu.f32 %p6, %f4, 0f00000000
  p6 = ((isnan(((float)(f4))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f4)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:61 mov.pred %p12, 0
  p12 = ((0) != 0);
  // PTX:62 @%p6 bra $L__BB49_7
  if (p6) { goto L_BB49_7; }
  // PTX:64 setp.eq.s64 %p8, %rd7, 0
  p8 = (((long long)(rd7)) == ((long long)(0)));
  // PTX:65 mov.pred %p12, -1
  p12 = ((-1) != 0);
  // PTX:66 @%p8 bra $L__BB49_7
  if (p8) { goto L_BB49_7; }
  // PTX:68 cvta.to.global.u64 %rd21, %rd7
  rd21 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd7));
  // PTX:69 add.s64 %rd23, %rd21, %rd19
  asm("add.s64 %0, %1, %2;" : "=l"(rd23) : "l"(rd21), "l"(rd19));
  // PTX:70 ld.global.u32 %r7, [%rd23]
  r7 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (0)))));
  // PTX:71 and.b32 %r8, %r7, 1
  asm("and.b32 %0, %1, 1;" : "=r"(r8) : "r"(r7));
  // PTX:72 setp.eq.b32 %p12, %r8, 1
  p12 = (((unsigned)(r8)) == ((unsigned)(1)));
  // PTX:74 $L__BB49_7:
L_BB49_7:;
  // PTX:75 setp.leu.f32 %p9, %f1, 0f00000000
  p9 = ((isnan(((float)(f1))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f1)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:76 mov.f32 %f6, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f6) : );
  // PTX:77 not.pred %p10, %p12
  p10 = !(p12);
  // PTX:78 or.pred %p11, %p9, %p10
  p11 = ((p9) || (p10));
  // PTX:79 @%p11 bra $L__BB49_9
  if (p11) { goto L_BB49_9; }
  // PTX:81 rcp.rn.f32 %f6, %f1
  asm("rcp.rn.f32 %0, %1;" : "=f"(f6) : "f"(f1));
  // PTX:83 $L__BB49_9:
L_BB49_9:;
  // PTX:84 cvta.to.global.u64 %rd24, %rd8
  rd24 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd8));
  // PTX:85 add.s64 %rd26, %rd24, %rd16
  asm("add.s64 %0, %1, %2;" : "=l"(rd26) : "l"(rd24), "l"(rd16));
  // PTX:86 st.global.f32 [%rd26], %f6
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd26) + (0))))) = (float)(f6);
  // PTX:88 $L__BB49_10:
L_BB49_10:;
  // PTX:89 ret
  return;
}
