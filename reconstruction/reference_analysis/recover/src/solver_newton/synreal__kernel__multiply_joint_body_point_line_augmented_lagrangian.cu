// 机械还原自 PTX：synreal::kernel::multiply_joint_body_point_line_augmented_lagrangian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 5e71388b09185975280d2358371a0ca557c7c7477110358f9746d147c5ed48a4
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__multiply_joint_body_point_line_augmented_lagrangian(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, float param9, unsigned long long param10, unsigned long long param11, unsigned long long param12, unsigned long long param13, unsigned long long param14) {
  int p0, p1, p2, p3, p4;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110;
  // PTX:31 ld.param.u64 %rd27, [_ZN7synreal6kernel51multiply_joint_body_point_line_augmented_lagrangianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_PKfSH_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_0]
  rd27 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:32 ld.param.u64 %rd28, [_ZN7synreal6kernel51multiply_joint_body_point_line_augmented_lagrangianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_PKfSH_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_1]
  rd28 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:33 ld.param.u64 %rd17, [_ZN7synreal6kernel51multiply_joint_body_point_line_augmented_lagrangianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_PKfSH_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_2]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:34 ld.param.u64 %rd18, [_ZN7synreal6kernel51multiply_joint_body_point_line_augmented_lagrangianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_PKfSH_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_3]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:35 ld.param.u64 %rd19, [_ZN7synreal6kernel51multiply_joint_body_point_line_augmented_lagrangianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_PKfSH_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_4]
  rd19 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:36 ld.param.u64 %rd20, [_ZN7synreal6kernel51multiply_joint_body_point_line_augmented_lagrangianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_PKfSH_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_5]
  rd20 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:37 ld.param.u64 %rd21, [_ZN7synreal6kernel51multiply_joint_body_point_line_augmented_lagrangianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_PKfSH_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_6]
  rd21 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:38 ld.param.u64 %rd22, [_ZN7synreal6kernel51multiply_joint_body_point_line_augmented_lagrangianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_PKfSH_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_7]
  rd22 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:39 ld.param.u64 %rd23, [_ZN7synreal6kernel51multiply_joint_body_point_line_augmented_lagrangianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_PKfSH_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_8]
  rd23 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:40 ld.param.f32 %f21, [_ZN7synreal6kernel51multiply_joint_body_point_line_augmented_lagrangianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_PKfSH_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_9]
  f21 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param9 + (0))));
  // PTX:41 ld.param.u64 %rd29, [_ZN7synreal6kernel51multiply_joint_body_point_line_augmented_lagrangianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_PKfSH_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_10]
  rd29 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:42 ld.param.u64 %rd30, [_ZN7synreal6kernel51multiply_joint_body_point_line_augmented_lagrangianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_PKfSH_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_11]
  rd30 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:43 ld.param.u64 %rd24, [_ZN7synreal6kernel51multiply_joint_body_point_line_augmented_lagrangianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_PKfSH_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_12]
  rd24 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:44 ld.param.u64 %rd25, [_ZN7synreal6kernel51multiply_joint_body_point_line_augmented_lagrangianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_PKfSH_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_13]
  rd25 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:45 ld.param.u64 %rd26, [_ZN7synreal6kernel51multiply_joint_body_point_line_augmented_lagrangianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_PKfSH_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_14]
  rd26 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:46 cvta.to.global.u64 %rd1, %rd29
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd29));
  // PTX:47 cvta.to.global.u64 %rd2, %rd27
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd27));
  // PTX:48 cvta.to.global.u64 %rd3, %rd28
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd28));
  // PTX:49 mov.u32 %r10, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r10) : "r"(blockIdx.x));
  // PTX:50 mov.u32 %r11, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r11) : "r"(blockDim.x));
  // PTX:51 mul.wide.u32 %rd31, %r10, %r11
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd31) : "r"(r10), "r"(r11));
  // PTX:52 mov.u32 %r12, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r12) : "r"(threadIdx.x));
  // PTX:53 cvt.u64.u32 %rd32, %r12
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd32) : "r"(r12));
  // PTX:54 add.s64 %rd4, %rd31, %rd32
  asm("add.s64 %0, %1, %2;" : "=l"(rd4) : "l"(rd31), "l"(rd32));
  // PTX:55 setp.ge.u64 %p1, %rd4, %rd30
  p1 = (((unsigned long long)(rd4)) >= ((unsigned long long)(rd30)));
  // PTX:56 @%p1 bra $L__BB37_8
  if (p1) { goto L_BB37_8; }
  // PTX:58 or.b64 %rd33, %rd4, %rd25
  asm("or.b64 %0, %1, %2;" : "=l"(rd33) : "l"(rd4), "l"(rd25));
  // PTX:59 and.b64 %rd34, %rd33, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd34) : "l"(rd33));
  // PTX:60 setp.eq.s64 %p2, %rd34, 0
  p2 = (((long long)(rd34)) == ((long long)(0)));
  // PTX:61 @%p2 bra $L__BB37_3
  if (p2) { goto L_BB37_3; }
  // PTX:63 div.u64 %rd109, %rd4, %rd25
  asm("div.u64 %0, %1, %2;" : "=l"(rd109) : "l"(rd4), "l"(rd25));
  // PTX:64 mul.lo.s64 %rd35, %rd109, %rd25
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd35) : "l"(rd109), "l"(rd25));
  // PTX:65 sub.s64 %rd110, %rd4, %rd35
  asm("sub.s64 %0, %1, %2;" : "=l"(rd110) : "l"(rd4), "l"(rd35));
  // PTX:66 bra.uni $L__BB37_4
  goto L_BB37_4;
  // PTX:68 $L__BB37_3:
L_BB37_3:;
  // PTX:69 cvt.u32.u64 %r13, %rd25
  asm("cvt.u32.u64 %0, %1;" : "=r"(r13) : "l"(rd25));
  // PTX:70 cvt.u32.u64 %r14, %rd4
  asm("cvt.u32.u64 %0, %1;" : "=r"(r14) : "l"(rd4));
  // PTX:71 div.u32 %r15, %r14, %r13
  asm("div.u32 %0, %1, %2;" : "=r"(r15) : "r"(r14), "r"(r13));
  // PTX:72 mul.lo.s32 %r16, %r15, %r13
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r16) : "r"(r15), "r"(r13));
  // PTX:73 sub.s32 %r17, %r14, %r16
  asm("sub.s32 %0, %1, %2;" : "=r"(r17) : "r"(r14), "r"(r16));
  // PTX:74 cvt.u64.u32 %rd109, %r15
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd109) : "r"(r15));
  // PTX:75 cvt.u64.u32 %rd110, %r17
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd110) : "r"(r17));
  // PTX:77 $L__BB37_4:
L_BB37_4:;
  // PTX:78 sub.s64 %rd36, %rd24, %rd25
  asm("sub.s64 %0, %1, %2;" : "=l"(rd36) : "l"(rd24), "l"(rd25));
  // PTX:79 add.s64 %rd11, %rd110, %rd36
  asm("add.s64 %0, %1, %2;" : "=l"(rd11) : "l"(rd110), "l"(rd36));
  // PTX:80 mul.lo.s64 %rd37, %rd109, %rd26
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd37) : "l"(rd109), "l"(rd26));
  // PTX:81 cvt.u32.u64 %r1, %rd37
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd37));
  // PTX:82 cvta.to.global.u64 %rd38, %rd17
  rd38 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd17));
  // PTX:83 shl.b64 %rd39, %rd11, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd39) : "l"(rd11));
  // PTX:84 add.s64 %rd40, %rd38, %rd39
  asm("add.s64 %0, %1, %2;" : "=l"(rd40) : "l"(rd38), "l"(rd39));
  // PTX:85 ld.global.s32 %rd12, [%rd40+4]
  rd12 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (4)))));
  // PTX:86 ld.global.u32 %r22, [%rd40]
  r22 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (0)))));
  // PTX:87 mul.wide.s32 %rd41, %r22, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd41) : "r"(r22));
  // PTX:88 add.s64 %rd42, %rd3, %rd41
  asm("add.s64 %0, %1, %2;" : "=l"(rd42) : "l"(rd3), "l"(rd41));
  // PTX:89 ld.global.u32 %r23, [%rd42]
  r23 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (0)))));
  // PTX:90 add.s32 %r24, %r23, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r24) : "r"(r23), "r"(r1));
  // PTX:91 ld.global.u32 %r25, [%rd42+4]
  r25 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (4)))));
  // PTX:92 add.s32 %r26, %r25, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r26) : "r"(r25), "r"(r1));
  // PTX:93 ld.global.u32 %r27, [%rd42+8]
  r27 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (8)))));
  // PTX:94 add.s32 %r28, %r27, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r28) : "r"(r27), "r"(r1));
  // PTX:95 ld.global.u32 %r29, [%rd42+12]
  r29 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (12)))));
  // PTX:96 add.s32 %r30, %r29, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r30) : "r"(r29), "r"(r1));
  // PTX:97 cvta.to.global.u64 %rd43, %rd19
  rd43 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd19));
  // PTX:98 shl.b64 %rd44, %rd11, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd44) : "l"(rd11));
  // PTX:99 add.s64 %rd45, %rd43, %rd44
  asm("add.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd43), "l"(rd44));
  // PTX:100 cvta.to.global.u64 %rd46, %rd20
  rd46 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd20));
  // PTX:101 add.s64 %rd47, %rd46, %rd44
  asm("add.s64 %0, %1, %2;" : "=l"(rd47) : "l"(rd46), "l"(rd44));
  // PTX:102 ld.global.f32 %f25, [%rd47]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))));
  // PTX:103 ld.global.f32 %f26, [%rd45]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))));
  // PTX:104 add.f32 %f27, %f26, %f25
  asm("add.f32 %0, %1, %2;" : "=f"(f27) : "f"(f26), "f"(f25));
  // PTX:105 ld.global.f32 %f28, [%rd47+4]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (4)))));
  // PTX:106 ld.global.f32 %f29, [%rd45+4]
  f29 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (4)))));
  // PTX:107 add.f32 %f30, %f29, %f28
  asm("add.f32 %0, %1, %2;" : "=f"(f30) : "f"(f29), "f"(f28));
  // PTX:108 ld.global.f32 %f31, [%rd47+8]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (8)))));
  // PTX:109 ld.global.f32 %f32, [%rd45+8]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (8)))));
  // PTX:110 add.f32 %f33, %f32, %f31
  asm("add.f32 %0, %1, %2;" : "=f"(f33) : "f"(f32), "f"(f31));
  // PTX:111 ld.global.f32 %f34, [%rd47+12]
  f34 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (12)))));
  // PTX:112 ld.global.f32 %f35, [%rd45+12]
  f35 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (12)))));
  // PTX:113 add.f32 %f36, %f35, %f34
  asm("add.f32 %0, %1, %2;" : "=f"(f36) : "f"(f35), "f"(f34));
  // PTX:114 sub.f32 %f37, %f25, %f26
  asm("sub.f32 %0, %1, %2;" : "=f"(f37) : "f"(f25), "f"(f26));
  // PTX:115 sub.f32 %f38, %f28, %f29
  asm("sub.f32 %0, %1, %2;" : "=f"(f38) : "f"(f28), "f"(f29));
  // PTX:116 sub.f32 %f39, %f31, %f32
  asm("sub.f32 %0, %1, %2;" : "=f"(f39) : "f"(f31), "f"(f32));
  // PTX:117 sub.f32 %f40, %f34, %f35
  asm("sub.f32 %0, %1, %2;" : "=f"(f40) : "f"(f34), "f"(f35));
  // PTX:118 cvta.to.global.u64 %rd48, %rd22
  rd48 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd22));
  // PTX:119 shl.b64 %rd49, %rd4, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd49) : "l"(rd4));
  // PTX:120 add.s64 %rd50, %rd48, %rd49
  asm("add.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd48), "l"(rd49));
  // PTX:121 ld.global.f32 %f41, [%rd50]
  f41 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (0)))));
  // PTX:122 mul.f32 %f42, %f41, %f37
  asm("mul.f32 %0, %1, %2;" : "=f"(f42) : "f"(f41), "f"(f37));
  // PTX:123 mul.f32 %f43, %f41, %f38
  asm("mul.f32 %0, %1, %2;" : "=f"(f43) : "f"(f41), "f"(f38));
  // PTX:124 mul.f32 %f44, %f41, %f39
  asm("mul.f32 %0, %1, %2;" : "=f"(f44) : "f"(f41), "f"(f39));
  // PTX:125 mul.f32 %f45, %f41, %f40
  asm("mul.f32 %0, %1, %2;" : "=f"(f45) : "f"(f41), "f"(f40));
  // PTX:126 fma.rn.f32 %f1, %f27, 0f3F000000, %f42
  asm("fma.rn.f32 %0, %1, 0f3F000000, %2;" : "=f"(f1) : "f"(f27), "f"(f42));
  // PTX:127 fma.rn.f32 %f2, %f30, 0f3F000000, %f43
  asm("fma.rn.f32 %0, %1, 0f3F000000, %2;" : "=f"(f2) : "f"(f30), "f"(f43));
  // PTX:128 fma.rn.f32 %f3, %f33, 0f3F000000, %f44
  asm("fma.rn.f32 %0, %1, 0f3F000000, %2;" : "=f"(f3) : "f"(f33), "f"(f44));
  // PTX:129 fma.rn.f32 %f4, %f36, 0f3F000000, %f45
  asm("fma.rn.f32 %0, %1, 0f3F000000, %2;" : "=f"(f4) : "f"(f36), "f"(f45));
  // PTX:130 cvta.to.global.u64 %rd51, %rd18
  rd51 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd18));
  // PTX:131 add.s64 %rd52, %rd51, %rd44
  asm("add.s64 %0, %1, %2;" : "=l"(rd52) : "l"(rd51), "l"(rd44));
  // PTX:132 cvt.s64.s32 %rd13, %r24
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd13) : "r"(r24));
  // PTX:133 mul.wide.s32 %rd53, %r24, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd53) : "r"(r24));
  // PTX:134 add.s64 %rd54, %rd2, %rd53
  asm("add.s64 %0, %1, %2;" : "=l"(rd54) : "l"(rd2), "l"(rd53));
  // PTX:135 ld.global.f32 %f46, [%rd54]
  f46 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))));
  // PTX:136 ld.global.f32 %f5, [%rd52]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))));
  // PTX:137 ld.global.f32 %f47, [%rd54+4]
  f47 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (4)))));
  // PTX:138 ld.global.f32 %f48, [%rd54+8]
  f48 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (8)))));
  // PTX:139 cvt.s64.s32 %rd14, %r26
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd14) : "r"(r26));
  // PTX:140 mul.wide.s32 %rd55, %r26, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd55) : "r"(r26));
  // PTX:141 add.s64 %rd56, %rd2, %rd55
  asm("add.s64 %0, %1, %2;" : "=l"(rd56) : "l"(rd2), "l"(rd55));
  // PTX:142 ld.global.f32 %f49, [%rd56]
  f49 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))));
  // PTX:143 ld.global.f32 %f6, [%rd52+4]
  f6 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (4)))));
  // PTX:144 mul.f32 %f50, %f6, %f49
  asm("mul.f32 %0, %1, %2;" : "=f"(f50) : "f"(f6), "f"(f49));
  // PTX:145 ld.global.f32 %f51, [%rd56+4]
  f51 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (4)))));
  // PTX:146 mul.f32 %f52, %f6, %f51
  asm("mul.f32 %0, %1, %2;" : "=f"(f52) : "f"(f6), "f"(f51));
  // PTX:147 ld.global.f32 %f53, [%rd56+8]
  f53 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (8)))));
  // PTX:148 mul.f32 %f54, %f6, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f54) : "f"(f6), "f"(f53));
  // PTX:149 fma.rn.f32 %f55, %f5, %f46, %f50
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f55) : "f"(f5), "f"(f46), "f"(f50));
  // PTX:150 fma.rn.f32 %f56, %f5, %f47, %f52
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f56) : "f"(f5), "f"(f47), "f"(f52));
  // PTX:151 fma.rn.f32 %f57, %f5, %f48, %f54
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f57) : "f"(f5), "f"(f48), "f"(f54));
  // PTX:152 cvt.s64.s32 %rd15, %r28
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd15) : "r"(r28));
  // PTX:153 mul.wide.s32 %rd57, %r28, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd57) : "r"(r28));
  // PTX:154 add.s64 %rd58, %rd2, %rd57
  asm("add.s64 %0, %1, %2;" : "=l"(rd58) : "l"(rd2), "l"(rd57));
  // PTX:155 ld.global.f32 %f58, [%rd58]
  f58 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (0)))));
  // PTX:156 ld.global.f32 %f7, [%rd52+8]
  f7 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (8)))));
  // PTX:157 ld.global.f32 %f59, [%rd58+4]
  f59 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (4)))));
  // PTX:158 ld.global.f32 %f60, [%rd58+8]
  f60 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (8)))));
  // PTX:159 fma.rn.f32 %f61, %f7, %f58, %f55
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f61) : "f"(f7), "f"(f58), "f"(f55));
  // PTX:160 fma.rn.f32 %f62, %f7, %f59, %f56
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f62) : "f"(f7), "f"(f59), "f"(f56));
  // PTX:161 fma.rn.f32 %f63, %f7, %f60, %f57
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f63) : "f"(f7), "f"(f60), "f"(f57));
  // PTX:162 cvt.s64.s32 %rd16, %r30
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd16) : "r"(r30));
  // PTX:163 mul.wide.s32 %rd59, %r30, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd59) : "r"(r30));
  // PTX:164 add.s64 %rd60, %rd2, %rd59
  asm("add.s64 %0, %1, %2;" : "=l"(rd60) : "l"(rd2), "l"(rd59));
  // PTX:165 ld.global.f32 %f64, [%rd60]
  f64 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))));
  // PTX:166 ld.global.f32 %f8, [%rd52+12]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (12)))));
  // PTX:167 ld.global.f32 %f65, [%rd60+4]
  f65 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (4)))));
  // PTX:168 ld.global.f32 %f66, [%rd60+8]
  f66 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (8)))));
  // PTX:169 fma.rn.f32 %f9, %f8, %f64, %f61
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f9) : "f"(f8), "f"(f64), "f"(f61));
  // PTX:170 fma.rn.f32 %f10, %f8, %f65, %f62
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f10) : "f"(f8), "f"(f65), "f"(f62));
  // PTX:171 fma.rn.f32 %f11, %f8, %f66, %f63
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f11) : "f"(f8), "f"(f66), "f"(f63));
  // PTX:172 setp.lt.s64 %p3, %rd12, 0
  p3 = (((long long)(rd12)) < ((long long)(0)));
  // PTX:173 mov.u32 %r36, 0
  asm("mov.u32 %0, 0;" : "=r"(r36) : );
  // PTX:174 mov.f32 %f162, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f162) : );
  // PTX:175 mov.f32 %f163, %f162
  asm("mov.f32 %0, %1;" : "=f"(f163) : "f"(f162));
  // PTX:176 mov.f32 %f164, %f162
  asm("mov.f32 %0, %1;" : "=f"(f164) : "f"(f162));
  // PTX:177 mov.u32 %r37, %r36
  asm("mov.u32 %0, %1;" : "=r"(r37) : "r"(r36));
  // PTX:178 mov.u32 %r38, %r36
  asm("mov.u32 %0, %1;" : "=r"(r38) : "r"(r36));
  // PTX:179 mov.u32 %r39, %r36
  asm("mov.u32 %0, %1;" : "=r"(r39) : "r"(r36));
  // PTX:180 @%p3 bra $L__BB37_6
  if (p3) { goto L_BB37_6; }
  // PTX:182 shl.b64 %rd61, %rd12, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd61) : "l"(rd12));
  // PTX:183 add.s64 %rd62, %rd3, %rd61
  asm("add.s64 %0, %1, %2;" : "=l"(rd62) : "l"(rd3), "l"(rd61));
  // PTX:184 ld.global.u32 %r31, [%rd62]
  r31 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))));
  // PTX:185 ld.global.u32 %r32, [%rd62+4]
  r32 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (4)))));
  // PTX:186 ld.global.u32 %r33, [%rd62+8]
  r33 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (8)))));
  // PTX:187 ld.global.u32 %r34, [%rd62+12]
  r34 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (12)))));
  // PTX:188 add.s32 %r39, %r34, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r39) : "r"(r34), "r"(r1));
  // PTX:189 add.s32 %r38, %r33, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r38) : "r"(r33), "r"(r1));
  // PTX:190 add.s32 %r37, %r32, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r37) : "r"(r32), "r"(r1));
  // PTX:191 add.s32 %r36, %r31, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r36) : "r"(r31), "r"(r1));
  // PTX:192 mul.wide.s32 %rd63, %r36, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd63) : "r"(r36));
  // PTX:193 add.s64 %rd64, %rd2, %rd63
  asm("add.s64 %0, %1, %2;" : "=l"(rd64) : "l"(rd2), "l"(rd63));
  // PTX:194 ld.global.f32 %f67, [%rd64]
  f67 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (0)))));
  // PTX:195 ld.global.f32 %f68, [%rd64+4]
  f68 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (4)))));
  // PTX:196 ld.global.f32 %f69, [%rd64+8]
  f69 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (8)))));
  // PTX:197 mul.wide.s32 %rd65, %r37, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd65) : "r"(r37));
  // PTX:198 add.s64 %rd66, %rd2, %rd65
  asm("add.s64 %0, %1, %2;" : "=l"(rd66) : "l"(rd2), "l"(rd65));
  // PTX:199 ld.global.f32 %f70, [%rd66]
  f70 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (0)))));
  // PTX:200 mul.f32 %f71, %f2, %f70
  asm("mul.f32 %0, %1, %2;" : "=f"(f71) : "f"(f2), "f"(f70));
  // PTX:201 ld.global.f32 %f72, [%rd66+4]
  f72 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (4)))));
  // PTX:202 mul.f32 %f73, %f2, %f72
  asm("mul.f32 %0, %1, %2;" : "=f"(f73) : "f"(f2), "f"(f72));
  // PTX:203 ld.global.f32 %f74, [%rd66+8]
  f74 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (8)))));
  // PTX:204 mul.f32 %f75, %f2, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f75) : "f"(f2), "f"(f74));
  // PTX:205 fma.rn.f32 %f76, %f1, %f67, %f71
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f76) : "f"(f1), "f"(f67), "f"(f71));
  // PTX:206 fma.rn.f32 %f77, %f1, %f68, %f73
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f77) : "f"(f1), "f"(f68), "f"(f73));
  // PTX:207 fma.rn.f32 %f78, %f1, %f69, %f75
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f78) : "f"(f1), "f"(f69), "f"(f75));
  // PTX:208 mul.wide.s32 %rd67, %r38, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd67) : "r"(r38));
  // PTX:209 add.s64 %rd68, %rd2, %rd67
  asm("add.s64 %0, %1, %2;" : "=l"(rd68) : "l"(rd2), "l"(rd67));
  // PTX:210 ld.global.f32 %f79, [%rd68]
  f79 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (0)))));
  // PTX:211 ld.global.f32 %f80, [%rd68+4]
  f80 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (4)))));
  // PTX:212 ld.global.f32 %f81, [%rd68+8]
  f81 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (8)))));
  // PTX:213 fma.rn.f32 %f82, %f3, %f79, %f76
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f82) : "f"(f3), "f"(f79), "f"(f76));
  // PTX:214 fma.rn.f32 %f83, %f3, %f80, %f77
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f83) : "f"(f3), "f"(f80), "f"(f77));
  // PTX:215 fma.rn.f32 %f84, %f3, %f81, %f78
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f84) : "f"(f3), "f"(f81), "f"(f78));
  // PTX:216 mul.wide.s32 %rd69, %r39, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd69) : "r"(r39));
  // PTX:217 add.s64 %rd70, %rd2, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd70) : "l"(rd2), "l"(rd69));
  // PTX:218 ld.global.f32 %f85, [%rd70]
  f85 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0)))));
  // PTX:219 ld.global.f32 %f86, [%rd70+4]
  f86 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (4)))));
  // PTX:220 ld.global.f32 %f87, [%rd70+8]
  f87 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (8)))));
  // PTX:221 fma.rn.f32 %f162, %f4, %f85, %f82
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f162) : "f"(f4), "f"(f85), "f"(f82));
  // PTX:222 fma.rn.f32 %f163, %f4, %f86, %f83
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f163) : "f"(f4), "f"(f86), "f"(f83));
  // PTX:223 fma.rn.f32 %f164, %f4, %f87, %f84
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f164) : "f"(f4), "f"(f87), "f"(f84));
  // PTX:225 $L__BB37_6:
L_BB37_6:;
  // PTX:226 cvt.u32.u64 %r35, %rd12
  asm("cvt.u32.u64 %0, %1;" : "=r"(r35) : "l"(rd12));
  // PTX:227 setp.lt.s32 %p4, %r35, 0
  p4 = (((int)(r35)) < ((int)(0)));
  // PTX:228 cvta.to.global.u64 %rd71, %rd21
  rd71 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd21));
  // PTX:229 shl.b64 %rd72, %rd11, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd72) : "l"(rd11));
  // PTX:230 add.s64 %rd73, %rd71, %rd72
  asm("add.s64 %0, %1, %2;" : "=l"(rd73) : "l"(rd71), "l"(rd72));
  // PTX:231 ld.global.f32 %f88, [%rd73]
  f88 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (0)))));
  // PTX:232 mul.f32 %f89, %f88, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f89) : "f"(f88), "f"(f21));
  // PTX:233 cvta.to.global.u64 %rd74, %rd23
  rd74 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd23));
  // PTX:234 mul.lo.s64 %rd75, %rd4, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd75) : "l"(rd4));
  // PTX:235 add.s64 %rd76, %rd74, %rd75
  asm("add.s64 %0, %1, %2;" : "=l"(rd76) : "l"(rd74), "l"(rd75));
  // PTX:236 ld.global.f32 %f90, [%rd76]
  f90 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (0)))));
  // PTX:237 sub.f32 %f91, %f9, %f162
  asm("sub.f32 %0, %1, %2;" : "=f"(f91) : "f"(f9), "f"(f162));
  // PTX:238 ld.global.f32 %f92, [%rd76+12]
  f92 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (12)))));
  // PTX:239 sub.f32 %f93, %f10, %f163
  asm("sub.f32 %0, %1, %2;" : "=f"(f93) : "f"(f10), "f"(f163));
  // PTX:240 mul.f32 %f94, %f93, %f92
  asm("mul.f32 %0, %1, %2;" : "=f"(f94) : "f"(f93), "f"(f92));
  // PTX:241 fma.rn.f32 %f95, %f91, %f90, %f94
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f95) : "f"(f91), "f"(f90), "f"(f94));
  // PTX:242 ld.global.f32 %f96, [%rd76+24]
  f96 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (24)))));
  // PTX:243 sub.f32 %f97, %f11, %f164
  asm("sub.f32 %0, %1, %2;" : "=f"(f97) : "f"(f11), "f"(f164));
  // PTX:244 fma.rn.f32 %f98, %f97, %f96, %f95
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f98) : "f"(f97), "f"(f96), "f"(f95));
  // PTX:245 ld.global.f32 %f99, [%rd76+4]
  f99 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (4)))));
  // PTX:246 ld.global.f32 %f100, [%rd76+16]
  f100 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (16)))));
  // PTX:247 mul.f32 %f101, %f93, %f100
  asm("mul.f32 %0, %1, %2;" : "=f"(f101) : "f"(f93), "f"(f100));
  // PTX:248 fma.rn.f32 %f102, %f91, %f99, %f101
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f102) : "f"(f91), "f"(f99), "f"(f101));
  // PTX:249 ld.global.f32 %f103, [%rd76+28]
  f103 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (28)))));
  // PTX:250 fma.rn.f32 %f104, %f97, %f103, %f102
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f104) : "f"(f97), "f"(f103), "f"(f102));
  // PTX:251 ld.global.f32 %f105, [%rd76+8]
  f105 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (8)))));
  // PTX:252 ld.global.f32 %f106, [%rd76+20]
  f106 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (20)))));
  // PTX:253 mul.f32 %f107, %f93, %f106
  asm("mul.f32 %0, %1, %2;" : "=f"(f107) : "f"(f93), "f"(f106));
  // PTX:254 fma.rn.f32 %f108, %f91, %f105, %f107
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f108) : "f"(f91), "f"(f105), "f"(f107));
  // PTX:255 ld.global.f32 %f109, [%rd76+32]
  f109 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (32)))));
  // PTX:256 fma.rn.f32 %f110, %f97, %f109, %f108
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f110) : "f"(f97), "f"(f109), "f"(f108));
  // PTX:257 mul.f32 %f18, %f89, %f98
  asm("mul.f32 %0, %1, %2;" : "=f"(f18) : "f"(f89), "f"(f98));
  // PTX:258 mul.f32 %f19, %f89, %f104
  asm("mul.f32 %0, %1, %2;" : "=f"(f19) : "f"(f89), "f"(f104));
  // PTX:259 mul.f32 %f20, %f89, %f110
  asm("mul.f32 %0, %1, %2;" : "=f"(f20) : "f"(f89), "f"(f110));
  // PTX:260 mul.f32 %f111, %f18, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f111) : "f"(f18), "f"(f5));
  // PTX:261 mul.f32 %f112, %f19, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f112) : "f"(f19), "f"(f5));
  // PTX:262 mul.f32 %f113, %f5, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f113) : "f"(f5), "f"(f20));
  // PTX:263 mul.f32 %f114, %f18, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f114) : "f"(f18), "f"(f6));
  // PTX:264 mul.f32 %f115, %f19, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f115) : "f"(f19), "f"(f6));
  // PTX:265 mul.f32 %f116, %f6, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f116) : "f"(f6), "f"(f20));
  // PTX:266 mul.f32 %f117, %f18, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f117) : "f"(f18), "f"(f7));
  // PTX:267 mul.f32 %f118, %f19, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f118) : "f"(f19), "f"(f7));
  // PTX:268 mul.f32 %f119, %f20, %f7
  asm("mul.f32 %0, %1, %2;" : "=f"(f119) : "f"(f20), "f"(f7));
  // PTX:269 mul.f32 %f120, %f18, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f120) : "f"(f18), "f"(f8));
  // PTX:270 mul.f32 %f121, %f19, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f121) : "f"(f19), "f"(f8));
  // PTX:271 mul.f32 %f122, %f20, %f8
  asm("mul.f32 %0, %1, %2;" : "=f"(f122) : "f"(f20), "f"(f8));
  // PTX:272 mul.lo.s64 %rd77, %rd13, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd77) : "l"(rd13));
  // PTX:273 add.s64 %rd78, %rd1, %rd77
  asm("add.s64 %0, %1, %2;" : "=l"(rd78) : "l"(rd1), "l"(rd77));
  // PTX:274 red.global.add.f32 [%rd78], %f111
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd78) + (0)))), (float)(f111));
  // PTX:275 add.s64 %rd79, %rd78, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd79) : "l"(rd78));
  // PTX:276 red.global.add.f32 [%rd79], %f112
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (0)))), (float)(f112));
  // PTX:277 add.s64 %rd80, %rd78, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd80) : "l"(rd78));
  // PTX:278 red.global.add.f32 [%rd80], %f113
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (0)))), (float)(f113));
  // PTX:279 mul.lo.s64 %rd81, %rd14, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd81) : "l"(rd14));
  // PTX:280 add.s64 %rd82, %rd1, %rd81
  asm("add.s64 %0, %1, %2;" : "=l"(rd82) : "l"(rd1), "l"(rd81));
  // PTX:281 red.global.add.f32 [%rd82], %f114
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (0)))), (float)(f114));
  // PTX:282 add.s64 %rd83, %rd82, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd83) : "l"(rd82));
  // PTX:283 red.global.add.f32 [%rd83], %f115
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (0)))), (float)(f115));
  // PTX:284 add.s64 %rd84, %rd82, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd84) : "l"(rd82));
  // PTX:285 red.global.add.f32 [%rd84], %f116
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (0)))), (float)(f116));
  // PTX:286 mul.lo.s64 %rd85, %rd15, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd85) : "l"(rd15));
  // PTX:287 add.s64 %rd86, %rd1, %rd85
  asm("add.s64 %0, %1, %2;" : "=l"(rd86) : "l"(rd1), "l"(rd85));
  // PTX:288 red.global.add.f32 [%rd86], %f117
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd86) + (0)))), (float)(f117));
  // PTX:289 add.s64 %rd87, %rd86, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd87) : "l"(rd86));
  // PTX:290 red.global.add.f32 [%rd87], %f118
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (0)))), (float)(f118));
  // PTX:291 add.s64 %rd88, %rd86, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd88) : "l"(rd86));
  // PTX:292 red.global.add.f32 [%rd88], %f119
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (0)))), (float)(f119));
  // PTX:293 mul.lo.s64 %rd89, %rd16, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd89) : "l"(rd16));
  // PTX:294 add.s64 %rd90, %rd1, %rd89
  asm("add.s64 %0, %1, %2;" : "=l"(rd90) : "l"(rd1), "l"(rd89));
  // PTX:295 red.global.add.f32 [%rd90], %f120
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (0)))), (float)(f120));
  // PTX:296 add.s64 %rd91, %rd90, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd91) : "l"(rd90));
  // PTX:297 red.global.add.f32 [%rd91], %f121
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (0)))), (float)(f121));
  // PTX:298 add.s64 %rd92, %rd90, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd92) : "l"(rd90));
  // PTX:299 red.global.add.f32 [%rd92], %f122
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (0)))), (float)(f122));
  // PTX:300 @%p4 bra $L__BB37_8
  if (p4) { goto L_BB37_8; }
  // PTX:302 neg.f32 %f135, %f18
  asm("neg.f32 %0, %1;" : "=f"(f135) : "f"(f18));
  // PTX:303 mul.f32 %f136, %f1, %f135
  asm("mul.f32 %0, %1, %2;" : "=f"(f136) : "f"(f1), "f"(f135));
  // PTX:304 neg.f32 %f137, %f19
  asm("neg.f32 %0, %1;" : "=f"(f137) : "f"(f19));
  // PTX:305 mul.f32 %f138, %f1, %f137
  asm("mul.f32 %0, %1, %2;" : "=f"(f138) : "f"(f1), "f"(f137));
  // PTX:306 neg.f32 %f139, %f20
  asm("neg.f32 %0, %1;" : "=f"(f139) : "f"(f20));
  // PTX:307 mul.f32 %f140, %f1, %f139
  asm("mul.f32 %0, %1, %2;" : "=f"(f140) : "f"(f1), "f"(f139));
  // PTX:308 mul.f32 %f141, %f2, %f135
  asm("mul.f32 %0, %1, %2;" : "=f"(f141) : "f"(f2), "f"(f135));
  // PTX:309 mul.f32 %f142, %f2, %f137
  asm("mul.f32 %0, %1, %2;" : "=f"(f142) : "f"(f2), "f"(f137));
  // PTX:310 mul.f32 %f143, %f2, %f139
  asm("mul.f32 %0, %1, %2;" : "=f"(f143) : "f"(f2), "f"(f139));
  // PTX:311 mul.f32 %f144, %f3, %f135
  asm("mul.f32 %0, %1, %2;" : "=f"(f144) : "f"(f3), "f"(f135));
  // PTX:312 mul.f32 %f145, %f3, %f137
  asm("mul.f32 %0, %1, %2;" : "=f"(f145) : "f"(f3), "f"(f137));
  // PTX:313 mul.f32 %f146, %f3, %f139
  asm("mul.f32 %0, %1, %2;" : "=f"(f146) : "f"(f3), "f"(f139));
  // PTX:314 mul.f32 %f147, %f4, %f135
  asm("mul.f32 %0, %1, %2;" : "=f"(f147) : "f"(f4), "f"(f135));
  // PTX:315 mul.f32 %f148, %f4, %f137
  asm("mul.f32 %0, %1, %2;" : "=f"(f148) : "f"(f4), "f"(f137));
  // PTX:316 mul.f32 %f149, %f4, %f139
  asm("mul.f32 %0, %1, %2;" : "=f"(f149) : "f"(f4), "f"(f139));
  // PTX:317 mul.wide.s32 %rd93, %r36, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd93) : "r"(r36));
  // PTX:318 add.s64 %rd94, %rd1, %rd93
  asm("add.s64 %0, %1, %2;" : "=l"(rd94) : "l"(rd1), "l"(rd93));
  // PTX:319 red.global.add.f32 [%rd94], %f136
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd94) + (0)))), (float)(f136));
  // PTX:320 add.s64 %rd95, %rd94, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd95) : "l"(rd94));
  // PTX:321 red.global.add.f32 [%rd95], %f138
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd95) + (0)))), (float)(f138));
  // PTX:322 add.s64 %rd96, %rd94, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd96) : "l"(rd94));
  // PTX:323 red.global.add.f32 [%rd96], %f140
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (0)))), (float)(f140));
  // PTX:324 mul.wide.s32 %rd97, %r37, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd97) : "r"(r37));
  // PTX:325 add.s64 %rd98, %rd1, %rd97
  asm("add.s64 %0, %1, %2;" : "=l"(rd98) : "l"(rd1), "l"(rd97));
  // PTX:326 red.global.add.f32 [%rd98], %f141
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (0)))), (float)(f141));
  // PTX:327 add.s64 %rd99, %rd98, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd99) : "l"(rd98));
  // PTX:328 red.global.add.f32 [%rd99], %f142
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (0)))), (float)(f142));
  // PTX:329 add.s64 %rd100, %rd98, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd100) : "l"(rd98));
  // PTX:330 red.global.add.f32 [%rd100], %f143
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (0)))), (float)(f143));
  // PTX:331 mul.wide.s32 %rd101, %r38, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd101) : "r"(r38));
  // PTX:332 add.s64 %rd102, %rd1, %rd101
  asm("add.s64 %0, %1, %2;" : "=l"(rd102) : "l"(rd1), "l"(rd101));
  // PTX:333 red.global.add.f32 [%rd102], %f144
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd102) + (0)))), (float)(f144));
  // PTX:334 add.s64 %rd103, %rd102, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd103) : "l"(rd102));
  // PTX:335 red.global.add.f32 [%rd103], %f145
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd103) + (0)))), (float)(f145));
  // PTX:336 add.s64 %rd104, %rd102, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd104) : "l"(rd102));
  // PTX:337 red.global.add.f32 [%rd104], %f146
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd104) + (0)))), (float)(f146));
  // PTX:338 mul.wide.s32 %rd105, %r39, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd105) : "r"(r39));
  // PTX:339 add.s64 %rd106, %rd1, %rd105
  asm("add.s64 %0, %1, %2;" : "=l"(rd106) : "l"(rd1), "l"(rd105));
  // PTX:340 red.global.add.f32 [%rd106], %f147
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (0)))), (float)(f147));
  // PTX:341 add.s64 %rd107, %rd106, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd107) : "l"(rd106));
  // PTX:342 red.global.add.f32 [%rd107], %f148
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd107) + (0)))), (float)(f148));
  // PTX:343 add.s64 %rd108, %rd106, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd108) : "l"(rd106));
  // PTX:344 red.global.add.f32 [%rd108], %f149
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd108) + (0)))), (float)(f149));
  // PTX:346 $L__BB37_8:
L_BB37_8:;
  // PTX:347 ret
  return;
}
