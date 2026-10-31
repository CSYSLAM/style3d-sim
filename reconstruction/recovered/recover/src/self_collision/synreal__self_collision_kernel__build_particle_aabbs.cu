// 机械还原自 PTX：synreal::self_collision_kernel::build_particle_aabbs(glm::vec<3, float, (glm::qualifier)0> const*, int const*, float const*, synreal::Aabb*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: c623e385beb8dfa5d7c581d1ee99a8538803c61f6417dcc8933dda5932cb833a
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__self_collision_kernel__build_particle_aabbs(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6) {
  int p0, p1, p2;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36;
  // PTX:23 ld.param.u64 %rd8, [_ZN7synreal21self_collision_kernel20build_particle_aabbsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPNS_4AabbEmmm_param_0]
  rd8 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:24 ld.param.u64 %rd9, [_ZN7synreal21self_collision_kernel20build_particle_aabbsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPNS_4AabbEmmm_param_1]
  rd9 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:25 ld.param.u64 %rd10, [_ZN7synreal21self_collision_kernel20build_particle_aabbsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPNS_4AabbEmmm_param_2]
  rd10 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:26 ld.param.u64 %rd11, [_ZN7synreal21self_collision_kernel20build_particle_aabbsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPNS_4AabbEmmm_param_3]
  rd11 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:27 ld.param.u64 %rd14, [_ZN7synreal21self_collision_kernel20build_particle_aabbsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPNS_4AabbEmmm_param_4]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:28 ld.param.u64 %rd12, [_ZN7synreal21self_collision_kernel20build_particle_aabbsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPNS_4AabbEmmm_param_5]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:29 ld.param.u64 %rd13, [_ZN7synreal21self_collision_kernel20build_particle_aabbsEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKiPKfPNS_4AabbEmmm_param_6]
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
  // PTX:37 @%p1 bra $L__BB2_5
  if (p1) { goto L_BB2_5; }
  // PTX:39 or.b64 %rd17, %rd1, %rd12
  asm("or.b64 %0, %1, %2;" : "=l"(rd17) : "l"(rd1), "l"(rd12));
  // PTX:40 and.b64 %rd18, %rd17, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd18) : "l"(rd17));
  // PTX:41 setp.eq.s64 %p2, %rd18, 0
  p2 = (((long long)(rd18)) == ((long long)(0)));
  // PTX:42 @%p2 bra $L__BB2_3
  if (p2) { goto L_BB2_3; }
  // PTX:44 div.u64 %rd35, %rd1, %rd12
  asm("div.u64 %0, %1, %2;" : "=l"(rd35) : "l"(rd1), "l"(rd12));
  // PTX:45 mul.lo.s64 %rd19, %rd35, %rd12
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd35), "l"(rd12));
  // PTX:46 sub.s64 %rd36, %rd1, %rd19
  asm("sub.s64 %0, %1, %2;" : "=l"(rd36) : "l"(rd1), "l"(rd19));
  // PTX:47 bra.uni $L__BB2_4
  goto L_BB2_4;
  // PTX:49 $L__BB2_3:
L_BB2_3:;
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
  // PTX:55 cvt.u64.u32 %rd35, %r6
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd35) : "r"(r6));
  // PTX:56 cvt.u64.u32 %rd36, %r8
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd36) : "r"(r8));
  // PTX:58 $L__BB2_4:
L_BB2_4:;
  // PTX:59 cvta.to.global.u64 %rd20, %rd9
  rd20 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd9));
  // PTX:60 shl.b64 %rd21, %rd36, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd21) : "l"(rd36));
  // PTX:61 add.s64 %rd22, %rd20, %rd21
  asm("add.s64 %0, %1, %2;" : "=l"(rd22) : "l"(rd20), "l"(rd21));
  // PTX:62 ld.global.u32 %r9, [%rd22]
  r9 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (0)))));
  // PTX:63 cvt.s64.s32 %rd23, %r9
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd23) : "r"(r9));
  // PTX:64 mul.lo.s64 %rd24, %rd35, %rd13
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd24) : "l"(rd35), "l"(rd13));
  // PTX:65 add.s64 %rd25, %rd24, %rd23
  asm("add.s64 %0, %1, %2;" : "=l"(rd25) : "l"(rd24), "l"(rd23));
  // PTX:66 cvta.to.global.u64 %rd26, %rd8
  rd26 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd8));
  // PTX:67 mul.lo.s64 %rd27, %rd25, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd27) : "l"(rd25));
  // PTX:68 add.s64 %rd28, %rd26, %rd27
  asm("add.s64 %0, %1, %2;" : "=l"(rd28) : "l"(rd26), "l"(rd27));
  // PTX:69 cvta.to.global.u64 %rd29, %rd10
  rd29 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd10));
  // PTX:70 mul.wide.s32 %rd30, %r9, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd30) : "r"(r9));
  // PTX:71 add.s64 %rd31, %rd29, %rd30
  asm("add.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd29), "l"(rd30));
  // PTX:72 ld.global.f32 %f1, [%rd31]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (0)))));
  // PTX:73 ld.global.f32 %f2, [%rd28]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (0)))));
  // PTX:74 sub.f32 %f3, %f2, %f1
  asm("sub.f32 %0, %1, %2;" : "=f"(f3) : "f"(f2), "f"(f1));
  // PTX:75 ld.global.f32 %f4, [%rd28+4]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (4)))));
  // PTX:76 sub.f32 %f5, %f4, %f1
  asm("sub.f32 %0, %1, %2;" : "=f"(f5) : "f"(f4), "f"(f1));
  // PTX:77 ld.global.f32 %f6, [%rd28+8]
  f6 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (8)))));
  // PTX:78 sub.f32 %f7, %f6, %f1
  asm("sub.f32 %0, %1, %2;" : "=f"(f7) : "f"(f6), "f"(f1));
  // PTX:79 add.f32 %f8, %f2, %f1
  asm("add.f32 %0, %1, %2;" : "=f"(f8) : "f"(f2), "f"(f1));
  // PTX:80 add.f32 %f9, %f4, %f1
  asm("add.f32 %0, %1, %2;" : "=f"(f9) : "f"(f4), "f"(f1));
  // PTX:81 add.f32 %f10, %f6, %f1
  asm("add.f32 %0, %1, %2;" : "=f"(f10) : "f"(f6), "f"(f1));
  // PTX:82 cvta.to.global.u64 %rd32, %rd11
  rd32 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd11));
  // PTX:83 mul.lo.s64 %rd33, %rd1, 24
  asm("mul.lo.s64 %0, %1, 24;" : "=l"(rd33) : "l"(rd1));
  // PTX:84 add.s64 %rd34, %rd32, %rd33
  asm("add.s64 %0, %1, %2;" : "=l"(rd34) : "l"(rd32), "l"(rd33));
  // PTX:85 st.global.f32 [%rd34], %f3
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (0))))) = (float)(f3);
  // PTX:86 st.global.f32 [%rd34+4], %f5
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (4))))) = (float)(f5);
  // PTX:87 st.global.f32 [%rd34+8], %f7
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (8))))) = (float)(f7);
  // PTX:88 st.global.f32 [%rd34+12], %f8
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (12))))) = (float)(f8);
  // PTX:89 st.global.f32 [%rd34+16], %f9
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (16))))) = (float)(f9);
  // PTX:90 st.global.f32 [%rd34+20], %f10
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd34) + (20))))) = (float)(f10);
  // PTX:92 $L__BB2_5:
L_BB2_5:;
  // PTX:93 ret
  return;
}
