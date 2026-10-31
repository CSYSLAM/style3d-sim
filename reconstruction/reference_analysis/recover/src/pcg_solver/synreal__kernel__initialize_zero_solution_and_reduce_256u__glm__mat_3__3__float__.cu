// 机械还原自 PTX：void synreal::kernel::initialize_zero_solution_and_reduce<256u, glm::mat<3, 3, float, (glm::qualifier)0> >(glm::vec<3, float, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, float*, unsigned long)
// PTX SHA256: fd5710058e8d723f69472f2476a4625cb6a0961363921af88c5ac43381a42e20
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__initialize_zero_solution_and_reduce_256u__glm__mat_3__3__float__(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5) {
  int p0, p1, p2, p3, p4;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23;
  __shared__ __align__(4) unsigned char _ZZN7synreal6kernel35initialize_zero_solution_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEvPKNS2_3vecILi3EfLS4_0EEEPKT0_PS7_SD_PfmE17reduction_storage[44];
  // PTX:23 ld.param.u64 %rd3, [_ZN7synreal6kernel35initialize_zero_solution_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEvPKNS2_3vecILi3EfLS4_0EEEPKT0_PS7_SD_Pfm_param_0]
  rd3 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:24 ld.param.u64 %rd4, [_ZN7synreal6kernel35initialize_zero_solution_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEvPKNS2_3vecILi3EfLS4_0EEEPKT0_PS7_SD_Pfm_param_1]
  rd4 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:25 ld.param.u64 %rd5, [_ZN7synreal6kernel35initialize_zero_solution_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEvPKNS2_3vecILi3EfLS4_0EEEPKT0_PS7_SD_Pfm_param_2]
  rd5 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:26 ld.param.u64 %rd6, [_ZN7synreal6kernel35initialize_zero_solution_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEvPKNS2_3vecILi3EfLS4_0EEEPKT0_PS7_SD_Pfm_param_3]
  rd6 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:27 ld.param.u64 %rd7, [_ZN7synreal6kernel35initialize_zero_solution_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEvPKNS2_3vecILi3EfLS4_0EEEPKT0_PS7_SD_Pfm_param_4]
  rd7 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:28 ld.param.u64 %rd8, [_ZN7synreal6kernel35initialize_zero_solution_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEvPKNS2_3vecILi3EfLS4_0EEEPKT0_PS7_SD_Pfm_param_5]
  rd8 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:29 mov.u32 %r2, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockIdx.x));
  // PTX:30 cvt.u64.u32 %rd1, %r2
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd1) : "r"(r2));
  // PTX:31 mov.u32 %r3, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(blockDim.x));
  // PTX:32 mul.wide.u32 %rd9, %r2, %r3
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd9) : "r"(r2), "r"(r3));
  // PTX:33 mov.u32 %r1, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r1) : "r"(threadIdx.x));
  // PTX:34 cvt.u64.u32 %rd10, %r1
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd10) : "r"(r1));
  // PTX:35 add.s64 %rd2, %rd9, %rd10
  asm("add.s64 %0, %1, %2;" : "=l"(rd2) : "l"(rd9), "l"(rd10));
  // PTX:36 setp.ge.u64 %p1, %rd2, %rd8
  p1 = (((unsigned long long)(rd2)) >= ((unsigned long long)(rd8)));
  // PTX:37 mov.f32 %f58, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f58) : );
  // PTX:38 @%p1 bra $L__BB5_2
  if (p1) { goto L_BB5_2; }
  // PTX:40 cvta.to.global.u64 %rd11, %rd3
  rd11 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd3));
  // PTX:41 mul.lo.s64 %rd12, %rd2, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd12) : "l"(rd2));
  // PTX:42 add.s64 %rd13, %rd11, %rd12
  asm("add.s64 %0, %1, %2;" : "=l"(rd13) : "l"(rd11), "l"(rd12));
  // PTX:43 ld.global.u32 %r4, [%rd13]
  r4 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))));
  // PTX:44 ld.global.u32 %r5, [%rd13+4]
  r5 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4)))));
  // PTX:45 ld.global.u32 %r6, [%rd13+8]
  r6 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8)))));
  // PTX:46 cvta.to.global.u64 %rd14, %rd5
  rd14 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd5));
  // PTX:47 add.s64 %rd15, %rd14, %rd12
  asm("add.s64 %0, %1, %2;" : "=l"(rd15) : "l"(rd14), "l"(rd12));
  // PTX:48 st.global.u32 [%rd15], %r4
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0))))) = (unsigned)(r4);
  // PTX:49 st.global.u32 [%rd15+4], %r5
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (4))))) = (unsigned)(r5);
  // PTX:50 st.global.u32 [%rd15+8], %r6
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (8))))) = (unsigned)(r6);
  // PTX:51 cvta.to.global.u64 %rd16, %rd6
  rd16 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd6));
  // PTX:52 add.s64 %rd17, %rd16, %rd12
  asm("add.s64 %0, %1, %2;" : "=l"(rd17) : "l"(rd16), "l"(rd12));
  // PTX:53 mov.u32 %r7, 0
  asm("mov.u32 %0, 0;" : "=r"(r7) : );
  // PTX:54 st.global.u32 [%rd17], %r7
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0))))) = (unsigned)(r7);
  // PTX:55 st.global.u32 [%rd17+4], %r7
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (4))))) = (unsigned)(r7);
  // PTX:56 st.global.u32 [%rd17+8], %r7
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (8))))) = (unsigned)(r7);
  // PTX:57 cvta.to.global.u64 %rd18, %rd4
  rd18 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd4));
  // PTX:58 mul.lo.s64 %rd19, %rd2, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd19) : "l"(rd2));
  // PTX:59 add.s64 %rd20, %rd18, %rd19
  asm("add.s64 %0, %1, %2;" : "=l"(rd20) : "l"(rd18), "l"(rd19));
  // PTX:60 mov.b32 %f7, %r4
  asm("mov.b32 %0, %1;" : "=f"(f7) : "r"(r4));
  // PTX:61 ld.global.f32 %f8, [%rd20]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))));
  // PTX:62 mov.b32 %f9, %r5
  asm("mov.b32 %0, %1;" : "=f"(f9) : "r"(r5));
  // PTX:63 ld.global.f32 %f10, [%rd20+12]
  f10 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (12)))));
  // PTX:64 mul.f32 %f11, %f10, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f11) : "f"(f10), "f"(f9));
  // PTX:65 fma.rn.f32 %f12, %f8, %f7, %f11
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f12) : "f"(f8), "f"(f7), "f"(f11));
  // PTX:66 mov.b32 %f13, %r6
  asm("mov.b32 %0, %1;" : "=f"(f13) : "r"(r6));
  // PTX:67 ld.global.f32 %f14, [%rd20+24]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (24)))));
  // PTX:68 fma.rn.f32 %f15, %f14, %f13, %f12
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f15) : "f"(f14), "f"(f13), "f"(f12));
  // PTX:69 ld.global.f32 %f16, [%rd20+4]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (4)))));
  // PTX:70 ld.global.f32 %f17, [%rd20+16]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (16)))));
  // PTX:71 mul.f32 %f18, %f17, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f18) : "f"(f17), "f"(f9));
  // PTX:72 fma.rn.f32 %f19, %f16, %f7, %f18
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f19) : "f"(f16), "f"(f7), "f"(f18));
  // PTX:73 ld.global.f32 %f20, [%rd20+28]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (28)))));
  // PTX:74 fma.rn.f32 %f21, %f20, %f13, %f19
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f21) : "f"(f20), "f"(f13), "f"(f19));
  // PTX:75 ld.global.f32 %f22, [%rd20+8]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (8)))));
  // PTX:76 ld.global.f32 %f23, [%rd20+20]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (20)))));
  // PTX:77 mul.f32 %f24, %f23, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f24) : "f"(f23), "f"(f9));
  // PTX:78 fma.rn.f32 %f25, %f22, %f7, %f24
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f25) : "f"(f22), "f"(f7), "f"(f24));
  // PTX:79 ld.global.f32 %f26, [%rd20+32]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (32)))));
  // PTX:80 fma.rn.f32 %f27, %f26, %f13, %f25
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f27) : "f"(f26), "f"(f13), "f"(f25));
  // PTX:81 mul.f32 %f28, %f21, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f28) : "f"(f21), "f"(f9));
  // PTX:82 fma.rn.f32 %f29, %f15, %f7, %f28
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f29) : "f"(f15), "f"(f7), "f"(f28));
  // PTX:83 fma.rn.f32 %f58, %f27, %f13, %f29
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f58) : "f"(f27), "f"(f13), "f"(f29));
  // PTX:85 $L__BB5_2:
L_BB5_2:;
  // PTX:87 mov.u32 %r8, %laneid
  asm("mov.u32 %0, %1;" : "=r"(r8) : "r"((threadIdx.x & 31u)));
  // PTX:89 mov.u32 %r10, 1
  asm("mov.u32 %0, 1;" : "=r"(r10) : );
  // PTX:90 mov.u32 %r23, 31
  asm("mov.u32 %0, 31;" : "=r"(r23) : );
  // PTX:91 mov.u32 %r24, -1
  asm("mov.u32 %0, -1;" : "=r"(r24) : );
  // PTX:93 { .reg .f32 r0; .reg .pred p; shfl.sync.down.b32 r0|p, %f58, %r10, %r23, %r24; @p add.f32 r0, r0, %f58; mov.f32 %f30, r0;}
  asm volatile("{ .reg .f32 v; .reg .pred q; shfl.sync.down.b32 v|q, %1, %2, %3, %4; @q add.f32 v, v, %1; mov.f32 %0, v; }" : "=f"(f30) : "f"(f58), "r"(r10), "r"(r23), "r"(r24));
  // PTX:95 mov.u32 %r13, 2
  asm("mov.u32 %0, 2;" : "=r"(r13) : );
  // PTX:97 { .reg .f32 r0; .reg .pred p; shfl.sync.down.b32 r0|p, %f30, %r13, %r23, %r24; @p add.f32 r0, r0, %f30; mov.f32 %f33, r0;}
  asm volatile("{ .reg .f32 v; .reg .pred q; shfl.sync.down.b32 v|q, %1, %2, %3, %4; @q add.f32 v, v, %1; mov.f32 %0, v; }" : "=f"(f33) : "f"(f30), "r"(r13), "r"(r23), "r"(r24));
  // PTX:99 mov.u32 %r16, 4
  asm("mov.u32 %0, 4;" : "=r"(r16) : );
  // PTX:101 { .reg .f32 r0; .reg .pred p; shfl.sync.down.b32 r0|p, %f33, %r16, %r23, %r24; @p add.f32 r0, r0, %f33; mov.f32 %f36, r0;}
  asm volatile("{ .reg .f32 v; .reg .pred q; shfl.sync.down.b32 v|q, %1, %2, %3, %4; @q add.f32 v, v, %1; mov.f32 %0, v; }" : "=f"(f36) : "f"(f33), "r"(r16), "r"(r23), "r"(r24));
  // PTX:103 mov.u32 %r19, 8
  asm("mov.u32 %0, 8;" : "=r"(r19) : );
  // PTX:105 { .reg .f32 r0; .reg .pred p; shfl.sync.down.b32 r0|p, %f36, %r19, %r23, %r24; @p add.f32 r0, r0, %f36; mov.f32 %f39, r0;}
  asm volatile("{ .reg .f32 v; .reg .pred q; shfl.sync.down.b32 v|q, %1, %2, %3, %4; @q add.f32 v, v, %1; mov.f32 %0, v; }" : "=f"(f39) : "f"(f36), "r"(r19), "r"(r23), "r"(r24));
  // PTX:107 mov.u32 %r22, 16
  asm("mov.u32 %0, 16;" : "=r"(r22) : );
  // PTX:109 { .reg .f32 r0; .reg .pred p; shfl.sync.down.b32 r0|p, %f39, %r22, %r23, %r24; @p add.f32 r0, r0, %f39; mov.f32 %f59, r0;}
  asm volatile("{ .reg .f32 v; .reg .pred q; shfl.sync.down.b32 v|q, %1, %2, %3, %4; @q add.f32 v, v, %1; mov.f32 %0, v; }" : "=f"(f59) : "f"(f39), "r"(r22), "r"(r23), "r"(r24));
  // PTX:111 setp.ne.s32 %p2, %r8, 0
  p2 = (((int)(r8)) != ((int)(0)));
  // PTX:112 @%p2 bra $L__BB5_4
  if (p2) { goto L_BB5_4; }
  // PTX:114 shr.s32 %r25, %r1, 31
  asm("shr.s32 %0, %1, 31;" : "=r"(r25) : "r"(r1));
  // PTX:115 shr.u32 %r26, %r25, 27
  asm("shr.u32 %0, %1, 27;" : "=r"(r26) : "r"(r25));
  // PTX:116 add.s32 %r27, %r1, %r26
  asm("add.s32 %0, %1, %2;" : "=r"(r27) : "r"(r1), "r"(r26));
  // PTX:117 shr.s32 %r28, %r27, 5
  asm("shr.s32 %0, %1, 5;" : "=r"(r28) : "r"(r27));
  // PTX:118 shl.b32 %r29, %r28, 2
  asm("shl.b32 %0, %1, 2;" : "=r"(r29) : "r"(r28));
  // PTX:119 mov.u32 %r30, _ZZN7synreal6kernel35initialize_zero_solution_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEvPKNS2_3vecILi3EfLS4_0EEEPKT0_PS7_SD_PfmE17reduction_storage
  r30 = (unsigned)__cvta_generic_to_shared(_ZZN7synreal6kernel35initialize_zero_solution_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEvPKNS2_3vecILi3EfLS4_0EEEPKT0_PS7_SD_PfmE17reduction_storage);
  // PTX:120 add.s32 %r31, %r30, %r29
  asm("add.s32 %0, %1, %2;" : "=r"(r31) : "r"(r30), "r"(r29));
  // PTX:121 st.shared.f32 [%r31+8], %f59
  (*reinterpret_cast<volatile float*>(__cvta_shared_to_generic(((uintptr_t)(r31) + (8))))) = (float)(f59);
  // PTX:123 $L__BB5_4:
L_BB5_4:;
  // PTX:124 bar.sync 0
  __syncthreads();
  // PTX:125 setp.ne.s32 %p3, %r1, 0
  p3 = (((int)(r1)) != ((int)(0)));
  // PTX:126 @%p3 bra $L__BB5_6
  if (p3) { goto L_BB5_6; }
  // PTX:128 ld.shared.f32 %f45, [_ZZN7synreal6kernel35initialize_zero_solution_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEvPKNS2_3vecILi3EfLS4_0EEEPKT0_PS7_SD_PfmE17reduction_storage+12]
  f45 = (*reinterpret_cast<volatile float*>(__cvta_shared_to_generic(((uintptr_t)((unsigned)__cvta_generic_to_shared(_ZZN7synreal6kernel35initialize_zero_solution_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEvPKNS2_3vecILi3EfLS4_0EEEPKT0_PS7_SD_PfmE17reduction_storage)) + (12)))));
  // PTX:129 add.f32 %f46, %f59, %f45
  asm("add.f32 %0, %1, %2;" : "=f"(f46) : "f"(f59), "f"(f45));
  // PTX:130 ld.shared.f32 %f47, [_ZZN7synreal6kernel35initialize_zero_solution_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEvPKNS2_3vecILi3EfLS4_0EEEPKT0_PS7_SD_PfmE17reduction_storage+16]
  f47 = (*reinterpret_cast<volatile float*>(__cvta_shared_to_generic(((uintptr_t)((unsigned)__cvta_generic_to_shared(_ZZN7synreal6kernel35initialize_zero_solution_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEvPKNS2_3vecILi3EfLS4_0EEEPKT0_PS7_SD_PfmE17reduction_storage)) + (16)))));
  // PTX:131 add.f32 %f48, %f46, %f47
  asm("add.f32 %0, %1, %2;" : "=f"(f48) : "f"(f46), "f"(f47));
  // PTX:132 ld.shared.f32 %f49, [_ZZN7synreal6kernel35initialize_zero_solution_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEvPKNS2_3vecILi3EfLS4_0EEEPKT0_PS7_SD_PfmE17reduction_storage+20]
  f49 = (*reinterpret_cast<volatile float*>(__cvta_shared_to_generic(((uintptr_t)((unsigned)__cvta_generic_to_shared(_ZZN7synreal6kernel35initialize_zero_solution_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEvPKNS2_3vecILi3EfLS4_0EEEPKT0_PS7_SD_PfmE17reduction_storage)) + (20)))));
  // PTX:133 add.f32 %f50, %f48, %f49
  asm("add.f32 %0, %1, %2;" : "=f"(f50) : "f"(f48), "f"(f49));
  // PTX:134 ld.shared.f32 %f51, [_ZZN7synreal6kernel35initialize_zero_solution_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEvPKNS2_3vecILi3EfLS4_0EEEPKT0_PS7_SD_PfmE17reduction_storage+24]
  f51 = (*reinterpret_cast<volatile float*>(__cvta_shared_to_generic(((uintptr_t)((unsigned)__cvta_generic_to_shared(_ZZN7synreal6kernel35initialize_zero_solution_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEvPKNS2_3vecILi3EfLS4_0EEEPKT0_PS7_SD_PfmE17reduction_storage)) + (24)))));
  // PTX:135 add.f32 %f52, %f50, %f51
  asm("add.f32 %0, %1, %2;" : "=f"(f52) : "f"(f50), "f"(f51));
  // PTX:136 ld.shared.f32 %f53, [_ZZN7synreal6kernel35initialize_zero_solution_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEvPKNS2_3vecILi3EfLS4_0EEEPKT0_PS7_SD_PfmE17reduction_storage+28]
  f53 = (*reinterpret_cast<volatile float*>(__cvta_shared_to_generic(((uintptr_t)((unsigned)__cvta_generic_to_shared(_ZZN7synreal6kernel35initialize_zero_solution_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEvPKNS2_3vecILi3EfLS4_0EEEPKT0_PS7_SD_PfmE17reduction_storage)) + (28)))));
  // PTX:137 add.f32 %f54, %f52, %f53
  asm("add.f32 %0, %1, %2;" : "=f"(f54) : "f"(f52), "f"(f53));
  // PTX:138 ld.shared.f32 %f55, [_ZZN7synreal6kernel35initialize_zero_solution_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEvPKNS2_3vecILi3EfLS4_0EEEPKT0_PS7_SD_PfmE17reduction_storage+32]
  f55 = (*reinterpret_cast<volatile float*>(__cvta_shared_to_generic(((uintptr_t)((unsigned)__cvta_generic_to_shared(_ZZN7synreal6kernel35initialize_zero_solution_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEvPKNS2_3vecILi3EfLS4_0EEEPKT0_PS7_SD_PfmE17reduction_storage)) + (32)))));
  // PTX:139 add.f32 %f56, %f54, %f55
  asm("add.f32 %0, %1, %2;" : "=f"(f56) : "f"(f54), "f"(f55));
  // PTX:140 ld.shared.f32 %f57, [_ZZN7synreal6kernel35initialize_zero_solution_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEvPKNS2_3vecILi3EfLS4_0EEEPKT0_PS7_SD_PfmE17reduction_storage+36]
  f57 = (*reinterpret_cast<volatile float*>(__cvta_shared_to_generic(((uintptr_t)((unsigned)__cvta_generic_to_shared(_ZZN7synreal6kernel35initialize_zero_solution_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEvPKNS2_3vecILi3EfLS4_0EEEPKT0_PS7_SD_PfmE17reduction_storage)) + (36)))));
  // PTX:141 add.f32 %f59, %f56, %f57
  asm("add.f32 %0, %1, %2;" : "=f"(f59) : "f"(f56), "f"(f57));
  // PTX:143 $L__BB5_6:
L_BB5_6:;
  // PTX:144 @%p3 bra $L__BB5_8
  if (p3) { goto L_BB5_8; }
  // PTX:146 cvta.to.global.u64 %rd21, %rd7
  rd21 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd7));
  // PTX:147 shl.b64 %rd22, %rd1, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd22) : "l"(rd1));
  // PTX:148 add.s64 %rd23, %rd21, %rd22
  asm("add.s64 %0, %1, %2;" : "=l"(rd23) : "l"(rd21), "l"(rd22));
  // PTX:149 st.global.f32 [%rd23], %f59
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (0))))) = (float)(f59);
  // PTX:151 $L__BB5_8:
L_BB5_8:;
  // PTX:152 ret
  return;
}
