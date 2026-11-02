// 机械还原自 PTX：synreal::kernel::snapshot_hard_contacts(synreal::kernel::HardContactView)
// PTX SHA256: 92ba559c2329a5cf6ed1243815376c9a40a64d560df73e332ea1313bb18a075a
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__snapshot_hard_contacts(ByVal<312, 8> param0) {
  int p0, p1, p2, p3, p4, p5, p6, p7;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35;
  // PTX:17 mov.b64 %rd6, _ZN7synreal6kernel22snapshot_hard_contactsENS0_15HardContactViewE_param_0
  rd6 = (unsigned long long)(uintptr_t)&param0;
  // PTX:18 mov.u32 %r9, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r9) : "r"(blockIdx.x));
  // PTX:19 mov.u32 %r10, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r10) : "r"(blockDim.x));
  // PTX:20 mul.wide.u32 %rd7, %r9, %r10
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd7) : "r"(r9), "r"(r10));
  // PTX:21 mov.u32 %r11, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r11) : "r"(threadIdx.x));
  // PTX:22 cvt.u64.u32 %rd8, %r11
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd8) : "r"(r11));
  // PTX:23 add.s64 %rd1, %rd7, %rd8
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd7), "l"(rd8));
  // PTX:24 setp.ne.s64 %p1, %rd1, 0
  p1 = (((long long)(rd1)) != ((long long)(0)));
  // PTX:25 @%p1 bra $L__BB80_4
  if (p1) { goto L_BB80_4; }
  // PTX:27 ld.param.u64 %rd3, [%rd6]
  rd3 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd6) + (0))));
  // PTX:28 setp.eq.s64 %p2, %rd3, 0
  p2 = (((long long)(rd3)) == ((long long)(0)));
  // PTX:29 mov.u32 %r24, 0
  asm("mov.u32 %0, 0;" : "=r"(r24) : );
  // PTX:30 @%p2 bra $L__BB80_3
  if (p2) { goto L_BB80_3; }
  // PTX:32 cvta.to.global.u64 %rd9, %rd3
  rd9 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd3));
  // PTX:33 ld.global.u32 %r13, [%rd9]
  r13 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd9) + (0)))));
  // PTX:34 max.s32 %r14, %r13, 0
  asm("max.s32 %0, %1, 0;" : "=r"(r14) : "r"(r13));
  // PTX:35 ld.param.u32 %r15, [%rd6+8]
  r15 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)(rd6) + (8))));
  // PTX:36 min.s32 %r24, %r14, %r15
  asm("min.s32 %0, %1, %2;" : "=r"(r24) : "r"(r14), "r"(r15));
  // PTX:38 $L__BB80_3:
L_BB80_3:;
  // PTX:39 ld.param.u64 %rd10, [%rd6+304]
  rd10 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd6) + (304))));
  // PTX:40 cvta.to.global.u64 %rd11, %rd10
  rd11 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd10));
  // PTX:41 st.global.u32 [%rd11], %r24
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd11) + (0))))) = (unsigned)(r24);
  // PTX:43 $L__BB80_4:
L_BB80_4:;
  // PTX:44 ld.param.u64 %rd12, [%rd6+8]
  rd12 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd6) + (8))));
  // PTX:45 setp.le.u64 %p3, %rd12, %rd1
  p3 = (((unsigned long long)(rd12)) <= ((unsigned long long)(rd1)));
  // PTX:46 ld.param.u64 %rd5, [%rd6]
  rd5 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd6) + (0))));
  // PTX:47 setp.eq.s64 %p4, %rd5, 0
  p4 = (((long long)(rd5)) == ((long long)(0)));
  // PTX:48 or.pred %p5, %p3, %p4
  p5 = ((p3) || (p4));
  // PTX:49 @%p5 bra $L__BB80_9
  if (p5) { goto L_BB80_9; }
  // PTX:51 cvta.to.global.u64 %rd13, %rd5
  rd13 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd5));
  // PTX:52 ld.global.u32 %r16, [%rd13]
  r16 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))));
  // PTX:53 max.s32 %r17, %r16, 0
  asm("max.s32 %0, %1, 0;" : "=r"(r17) : "r"(r16));
  // PTX:54 cvt.s64.s32 %rd14, %r17
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd14) : "r"(r17));
  // PTX:55 setp.ge.u64 %p6, %rd1, %rd14
  p6 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd14)));
  // PTX:56 @%p6 bra $L__BB80_9
  if (p6) { goto L_BB80_9; }
  // PTX:58 ld.param.u64 %rd15, [%rd6+256]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd6) + (256))));
  // PTX:59 cvta.to.global.u64 %rd16, %rd15
  rd16 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd15));
  // PTX:60 shl.b64 %rd17, %rd1, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd17) : "l"(rd1));
  // PTX:61 add.s64 %rd18, %rd16, %rd17
  asm("add.s64 %0, %1, %2;" : "=l"(rd18) : "l"(rd16), "l"(rd17));
  // PTX:62 ld.global.f32 %f5, [%rd18]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (0)))));
  // PTX:63 ld.param.u64 %rd19, [%rd6+280]
  rd19 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd6) + (280))));
  // PTX:64 cvta.to.global.u64 %rd20, %rd19
  rd20 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd19));
  // PTX:65 add.s64 %rd21, %rd20, %rd17
  asm("add.s64 %0, %1, %2;" : "=l"(rd21) : "l"(rd20), "l"(rd17));
  // PTX:66 st.global.f32 [%rd21], %f5
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (0))))) = (float)(f5);
  // PTX:67 ld.param.u64 %rd22, [%rd6+288]
  rd22 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd6) + (288))));
  // PTX:68 cvta.to.global.u64 %rd23, %rd22
  rd23 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd22));
  // PTX:69 ld.param.u64 %rd24, [%rd6+264]
  rd24 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd6) + (264))));
  // PTX:70 cvta.to.global.u64 %rd25, %rd24
  rd25 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd24));
  // PTX:71 mul.lo.s64 %rd26, %rd1, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd26) : "l"(rd1));
  // PTX:72 add.s64 %rd27, %rd25, %rd26
  asm("add.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd25), "l"(rd26));
  // PTX:73 ld.global.u32 %r21, [%rd27]
  r21 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))));
  // PTX:74 ld.global.u32 %r22, [%rd27+4]
  r22 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (4)))));
  // PTX:75 ld.global.u32 %r23, [%rd27+8]
  r23 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (8)))));
  // PTX:76 add.s64 %rd28, %rd23, %rd26
  asm("add.s64 %0, %1, %2;" : "=l"(rd28) : "l"(rd23), "l"(rd26));
  // PTX:77 st.global.u32 [%rd28], %r21
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (0))))) = (unsigned)(r21);
  // PTX:78 st.global.u32 [%rd28+4], %r22
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (4))))) = (unsigned)(r22);
  // PTX:79 st.global.u32 [%rd28+8], %r23
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (8))))) = (unsigned)(r23);
  // PTX:80 ld.param.u64 %rd29, [%rd6+64]
  rd29 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd6) + (64))));
  // PTX:81 cvta.to.global.u64 %rd30, %rd29
  rd30 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd29));
  // PTX:82 add.s64 %rd31, %rd30, %rd26
  asm("add.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd30), "l"(rd26));
  // PTX:83 ld.global.f32 %f1, [%rd31]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (0)))));
  // PTX:84 ld.global.f32 %f2, [%rd31+4]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (4)))));
  // PTX:85 mul.f32 %f6, %f2, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f6) : "f"(f2), "f"(f2));
  // PTX:86 ld.global.f32 %f3, [%rd31+8]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (8)))));
  // PTX:87 fma.rn.f32 %f7, %f1, %f1, %f6
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f7) : "f"(f1), "f"(f1), "f"(f6));
  // PTX:88 fma.rn.f32 %f8, %f3, %f3, %f7
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f8) : "f"(f3), "f"(f3), "f"(f7));
  // PTX:89 sqrt.rn.f32 %f4, %f8
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f4) : "f"(f8));
  // PTX:90 setp.leu.f32 %p7, %f4, 0f00000000
  p7 = ((isnan(((float)(f4))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f4)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:91 mov.u32 %r25, 0
  asm("mov.u32 %0, 0;" : "=r"(r25) : );
  // PTX:92 mov.u32 %r26, %r25
  asm("mov.u32 %0, %1;" : "=r"(r26) : "r"(r25));
  // PTX:93 mov.u32 %r27, %r25
  asm("mov.u32 %0, %1;" : "=r"(r27) : "r"(r25));
  // PTX:94 @%p7 bra $L__BB80_8
  if (p7) { goto L_BB80_8; }
  // PTX:96 div.rn.f32 %f9, %f1, %f4
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f9) : "f"(f1), "f"(f4));
  // PTX:97 div.rn.f32 %f10, %f2, %f4
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f10) : "f"(f2), "f"(f4));
  // PTX:98 div.rn.f32 %f11, %f3, %f4
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f11) : "f"(f3), "f"(f4));
  // PTX:99 mov.b32 %r27, %f11
  asm("mov.b32 %0, %1;" : "=r"(r27) : "f"(f11));
  // PTX:100 mov.b32 %r26, %f10
  asm("mov.b32 %0, %1;" : "=r"(r26) : "f"(f10));
  // PTX:101 mov.b32 %r25, %f9
  asm("mov.b32 %0, %1;" : "=r"(r25) : "f"(f9));
  // PTX:103 $L__BB80_8:
L_BB80_8:;
  // PTX:104 ld.param.u64 %rd32, [%rd6+296]
  rd32 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd6) + (296))));
  // PTX:105 cvta.to.global.u64 %rd33, %rd32
  rd33 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd32));
  // PTX:106 add.s64 %rd35, %rd33, %rd26
  asm("add.s64 %0, %1, %2;" : "=l"(rd35) : "l"(rd33), "l"(rd26));
  // PTX:107 st.global.u32 [%rd35], %r25
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (0))))) = (unsigned)(r25);
  // PTX:108 st.global.u32 [%rd35+4], %r26
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (4))))) = (unsigned)(r26);
  // PTX:109 st.global.u32 [%rd35+8], %r27
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (8))))) = (unsigned)(r27);
  // PTX:111 $L__BB80_9:
L_BB80_9:;
  // PTX:112 ret
  return;
}
