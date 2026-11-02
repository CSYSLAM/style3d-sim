// 机械还原自 PTX：synreal::kernel::build_radix_tree(int*, glm::vec<2, int, (glm::qualifier)0>*, unsigned int const*, unsigned int)
// PTX SHA256: 4926245d702b29129f98eb0391792bfe1b564f3dd6737cce4d38a099cd3c766f
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__build_radix_tree(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned param3) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27;
  // PTX:19 ld.param.u64 %rd5, [_ZN7synreal6kernel16build_radix_treeEPiPN3glm3vecILi2EiLNS2_9qualifierE0EEEPKjj_param_0]
  rd5 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:20 ld.param.u64 %rd6, [_ZN7synreal6kernel16build_radix_treeEPiPN3glm3vecILi2EiLNS2_9qualifierE0EEEPKjj_param_1]
  rd6 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:21 ld.param.u64 %rd7, [_ZN7synreal6kernel16build_radix_treeEPiPN3glm3vecILi2EiLNS2_9qualifierE0EEEPKjj_param_2]
  rd7 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:22 ld.param.u32 %r53, [_ZN7synreal6kernel16build_radix_treeEPiPN3glm3vecILi2EiLNS2_9qualifierE0EEEPKjj_param_3]
  r53 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param3 + (0))));
  // PTX:23 cvta.to.global.u64 %rd1, %rd7
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd7));
  // PTX:24 mov.u32 %r54, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r54) : "r"(blockDim.x));
  // PTX:25 mov.u32 %r55, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r55) : "r"(blockIdx.x));
  // PTX:26 mov.u32 %r56, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r56) : "r"(threadIdx.x));
  // PTX:27 mad.lo.s32 %r1, %r55, %r54, %r56
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r1) : "r"(r55), "r"(r54), "r"(r56));
  // PTX:28 add.s32 %r2, %r1, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r2) : "r"(r1));
  // PTX:29 setp.ge.u32 %p1, %r2, %r53
  p1 = (((unsigned)(r2)) >= ((unsigned)(r53)));
  // PTX:30 @%p1 bra $L__BB1_41
  if (p1) { goto L_BB1_41; }
  // PTX:32 setp.lt.s32 %p2, %r1, -1
  p2 = (((int)(r1)) < ((int)(-1)));
  // PTX:33 mov.u32 %r107, -1
  asm("mov.u32 %0, -1;" : "=r"(r107) : );
  // PTX:34 setp.ge.s32 %p3, %r2, %r53
  p3 = (((int)(r2)) >= ((int)(r53)));
  // PTX:35 or.pred %p4, %p2, %p3
  p4 = ((p2) || (p3));
  // PTX:36 mul.wide.s32 %rd8, %r1, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd8) : "r"(r1));
  // PTX:37 add.s64 %rd2, %rd1, %rd8
  asm("add.s64 %0, %1, %2;" : "=l"(rd2) : "l"(rd1), "l"(rd8));
  // PTX:38 mov.u32 %r106, %r107
  asm("mov.u32 %0, %1;" : "=r"(r106) : "r"(r107));
  // PTX:39 @%p4 bra $L__BB1_5
  if (p4) { goto L_BB1_5; }
  // PTX:41 ld.global.u32 %r58, [%rd2]
  r58 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (0)))));
  // PTX:42 ld.global.u32 %r59, [%rd2+4]
  r59 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (4)))));
  // PTX:43 xor.b32 %r3, %r59, %r58
  asm("xor.b32 %0, %1, %2;" : "=r"(r3) : "r"(r59), "r"(r58));
  // PTX:44 setp.eq.s32 %p5, %r3, 0
  p5 = (((int)(r3)) == ((int)(0)));
  // PTX:45 @%p5 bra $L__BB1_4
  if (p5) { goto L_BB1_4; }
  // PTX:47 clz.b32 %r106, %r3
  asm("clz.b32 %0, %1;" : "=r"(r106) : "r"(r3));
  // PTX:48 bra.uni $L__BB1_5
  goto L_BB1_5;
  // PTX:50 $L__BB1_4:
L_BB1_4:;
  // PTX:51 xor.b32 %r60, %r2, %r1
  asm("xor.b32 %0, %1, %2;" : "=r"(r60) : "r"(r2), "r"(r1));
  // PTX:52 clz.b32 %r61, %r60
  asm("clz.b32 %0, %1;" : "=r"(r61) : "r"(r60));
  // PTX:53 add.s32 %r106, %r61, 32
  asm("add.s32 %0, %1, 32;" : "=r"(r106) : "r"(r61));
  // PTX:55 $L__BB1_5:
L_BB1_5:;
  // PTX:56 setp.gt.s32 %p6, %r1, %r53
  p6 = (((int)(r1)) > ((int)(r53)));
  // PTX:57 setp.lt.s32 %p7, %r1, 1
  p7 = (((int)(r1)) < ((int)(1)));
  // PTX:58 or.pred %p8, %p7, %p6
  p8 = ((p7) || (p6));
  // PTX:59 @%p8 bra $L__BB1_9
  if (p8) { goto L_BB1_9; }
  // PTX:61 ld.global.u32 %r63, [%rd2]
  r63 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (0)))));
  // PTX:62 ld.global.u32 %r64, [%rd2+-4]
  r64 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (-4)))));
  // PTX:63 xor.b32 %r7, %r64, %r63
  asm("xor.b32 %0, %1, %2;" : "=r"(r7) : "r"(r64), "r"(r63));
  // PTX:64 setp.eq.s32 %p9, %r7, 0
  p9 = (((int)(r7)) == ((int)(0)));
  // PTX:65 @%p9 bra $L__BB1_8
  if (p9) { goto L_BB1_8; }
  // PTX:67 clz.b32 %r107, %r7
  asm("clz.b32 %0, %1;" : "=r"(r107) : "r"(r7));
  // PTX:68 bra.uni $L__BB1_9
  goto L_BB1_9;
  // PTX:70 $L__BB1_8:
L_BB1_8:;
  // PTX:71 add.s32 %r65, %r1, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r65) : "r"(r1));
  // PTX:72 xor.b32 %r66, %r65, %r1
  asm("xor.b32 %0, %1, %2;" : "=r"(r66) : "r"(r65), "r"(r1));
  // PTX:73 clz.b32 %r67, %r66
  asm("clz.b32 %0, %1;" : "=r"(r67) : "r"(r66));
  // PTX:74 add.s32 %r107, %r67, 32
  asm("add.s32 %0, %1, 32;" : "=r"(r107) : "r"(r67));
  // PTX:76 $L__BB1_9:
L_BB1_9:;
  // PTX:77 setp.lt.s32 %p10, %r106, %r107
  p10 = (((int)(r106)) < ((int)(r107)));
  // PTX:78 selp.b32 %r11, -1, 1, %p10
  r11 = p10 ? -1 : 1;
  // PTX:79 sub.s32 %r12, %r1, %r11
  asm("sub.s32 %0, %1, %2;" : "=r"(r12) : "r"(r1), "r"(r11));
  // PTX:80 setp.lt.s32 %p11, %r12, 0
  p11 = (((int)(r12)) < ((int)(0)));
  // PTX:81 setp.ge.s32 %p12, %r12, %r53
  p12 = (((int)(r12)) >= ((int)(r53)));
  // PTX:82 or.pred %p13, %p11, %p12
  p13 = ((p11) || (p12));
  // PTX:83 @%p13 bra $L__BB1_13
  if (p13) { goto L_BB1_13; }
  // PTX:84 bra.uni $L__BB1_10
  goto L_BB1_10;
  // PTX:86 $L__BB1_13:
L_BB1_13:;
  // PTX:87 mov.u32 %r108, -1
  asm("mov.u32 %0, -1;" : "=r"(r108) : );
  // PTX:88 bra.uni $L__BB1_14
  goto L_BB1_14;
  // PTX:90 $L__BB1_10:
L_BB1_10:;
  // PTX:91 ld.global.u32 %r68, [%rd2]
  r68 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (0)))));
  // PTX:92 mul.wide.s32 %rd9, %r12, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd9) : "r"(r12));
  // PTX:93 add.s64 %rd10, %rd1, %rd9
  asm("add.s64 %0, %1, %2;" : "=l"(rd10) : "l"(rd1), "l"(rd9));
  // PTX:94 ld.global.u32 %r69, [%rd10]
  r69 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (0)))));
  // PTX:95 xor.b32 %r13, %r69, %r68
  asm("xor.b32 %0, %1, %2;" : "=r"(r13) : "r"(r69), "r"(r68));
  // PTX:96 setp.eq.s32 %p14, %r13, 0
  p14 = (((int)(r13)) == ((int)(0)));
  // PTX:97 @%p14 bra $L__BB1_12
  if (p14) { goto L_BB1_12; }
  // PTX:99 clz.b32 %r108, %r13
  asm("clz.b32 %0, %1;" : "=r"(r108) : "r"(r13));
  // PTX:100 bra.uni $L__BB1_14
  goto L_BB1_14;
  // PTX:102 $L__BB1_12:
L_BB1_12:;
  // PTX:103 xor.b32 %r70, %r12, %r1
  asm("xor.b32 %0, %1, %2;" : "=r"(r70) : "r"(r12), "r"(r1));
  // PTX:104 clz.b32 %r71, %r70
  asm("clz.b32 %0, %1;" : "=r"(r71) : "r"(r70));
  // PTX:105 add.s32 %r108, %r71, 32
  asm("add.s32 %0, %1, 32;" : "=r"(r108) : "r"(r71));
  // PTX:107 $L__BB1_14:
L_BB1_14:;
  // PTX:108 cvt.s64.s32 %rd3, %r1
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd3) : "r"(r1));
  // PTX:109 mov.u32 %r109, 2
  asm("mov.u32 %0, 2;" : "=r"(r109) : );
  // PTX:111 $L__BB1_15:
L_BB1_15:;
  // PTX:112 mov.u32 %r111, %r109
  asm("mov.u32 %0, %1;" : "=r"(r111) : "r"(r109));
  // PTX:113 mul.lo.s32 %r18, %r111, %r11
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r18) : "r"(r111), "r"(r11));
  // PTX:114 add.s32 %r19, %r18, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r19) : "r"(r18), "r"(r1));
  // PTX:115 setp.lt.s32 %p15, %r19, 0
  p15 = (((int)(r19)) < ((int)(0)));
  // PTX:116 setp.ge.s32 %p16, %r19, %r53
  p16 = (((int)(r19)) >= ((int)(r53)));
  // PTX:117 or.pred %p17, %p15, %p16
  p17 = ((p15) || (p16));
  // PTX:118 mov.u32 %r110, -1
  asm("mov.u32 %0, -1;" : "=r"(r110) : );
  // PTX:119 @%p17 bra $L__BB1_19
  if (p17) { goto L_BB1_19; }
  // PTX:121 ld.global.u32 %r75, [%rd2]
  r75 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (0)))));
  // PTX:122 mul.wide.s32 %rd11, %r18, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd11) : "r"(r18));
  // PTX:123 add.s64 %rd12, %rd2, %rd11
  asm("add.s64 %0, %1, %2;" : "=l"(rd12) : "l"(rd2), "l"(rd11));
  // PTX:124 ld.global.u32 %r76, [%rd12]
  r76 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (0)))));
  // PTX:125 xor.b32 %r20, %r76, %r75
  asm("xor.b32 %0, %1, %2;" : "=r"(r20) : "r"(r76), "r"(r75));
  // PTX:126 setp.eq.s32 %p18, %r20, 0
  p18 = (((int)(r20)) == ((int)(0)));
  // PTX:127 @%p18 bra $L__BB1_18
  if (p18) { goto L_BB1_18; }
  // PTX:129 clz.b32 %r110, %r20
  asm("clz.b32 %0, %1;" : "=r"(r110) : "r"(r20));
  // PTX:130 bra.uni $L__BB1_19
  goto L_BB1_19;
  // PTX:132 $L__BB1_18:
L_BB1_18:;
  // PTX:133 xor.b32 %r77, %r19, %r1
  asm("xor.b32 %0, %1, %2;" : "=r"(r77) : "r"(r19), "r"(r1));
  // PTX:134 clz.b32 %r78, %r77
  asm("clz.b32 %0, %1;" : "=r"(r78) : "r"(r77));
  // PTX:135 add.s32 %r110, %r78, 32
  asm("add.s32 %0, %1, 32;" : "=r"(r110) : "r"(r78));
  // PTX:137 $L__BB1_19:
L_BB1_19:;
  // PTX:138 shl.b32 %r109, %r111, 1
  asm("shl.b32 %0, %1, 1;" : "=r"(r109) : "r"(r111));
  // PTX:139 setp.gt.s32 %p19, %r110, %r108
  p19 = (((int)(r110)) > ((int)(r108)));
  // PTX:140 @%p19 bra $L__BB1_15
  if (p19) { goto L_BB1_15; }
  // PTX:142 setp.lt.s32 %p20, %r111, 2
  p20 = (((int)(r111)) < ((int)(2)));
  // PTX:143 mov.u32 %r114, 0
  asm("mov.u32 %0, 0;" : "=r"(r114) : );
  // PTX:144 @%p20 bra $L__BB1_27
  if (p20) { goto L_BB1_27; }
  // PTX:146 mov.u32 %r114, 0
  asm("mov.u32 %0, 0;" : "=r"(r114) : );
  // PTX:148 $L__BB1_22:
L_BB1_22:;
  // PTX:149 mov.u32 %r25, %r111
  asm("mov.u32 %0, %1;" : "=r"(r25) : "r"(r111));
  // PTX:150 shr.s32 %r111, %r25, 1
  asm("shr.s32 %0, %1, 1;" : "=r"(r111) : "r"(r25));
  // PTX:151 add.s32 %r82, %r111, %r114
  asm("add.s32 %0, %1, %2;" : "=r"(r82) : "r"(r111), "r"(r114));
  // PTX:152 mul.lo.s32 %r28, %r82, %r11
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r28) : "r"(r82), "r"(r11));
  // PTX:153 add.s32 %r29, %r28, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r29) : "r"(r28), "r"(r1));
  // PTX:154 setp.lt.s32 %p21, %r29, 0
  p21 = (((int)(r29)) < ((int)(0)));
  // PTX:155 setp.ge.s32 %p22, %r29, %r53
  p22 = (((int)(r29)) >= ((int)(r53)));
  // PTX:156 or.pred %p23, %p21, %p22
  p23 = ((p21) || (p22));
  // PTX:157 mov.u32 %r113, -1
  asm("mov.u32 %0, -1;" : "=r"(r113) : );
  // PTX:158 @%p23 bra $L__BB1_26
  if (p23) { goto L_BB1_26; }
  // PTX:160 ld.global.u32 %r83, [%rd2]
  r83 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (0)))));
  // PTX:161 mul.wide.s32 %rd13, %r28, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd13) : "r"(r28));
  // PTX:162 add.s64 %rd14, %rd2, %rd13
  asm("add.s64 %0, %1, %2;" : "=l"(rd14) : "l"(rd2), "l"(rd13));
  // PTX:163 ld.global.u32 %r84, [%rd14]
  r84 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:164 xor.b32 %r30, %r84, %r83
  asm("xor.b32 %0, %1, %2;" : "=r"(r30) : "r"(r84), "r"(r83));
  // PTX:165 setp.eq.s32 %p24, %r30, 0
  p24 = (((int)(r30)) == ((int)(0)));
  // PTX:166 @%p24 bra $L__BB1_25
  if (p24) { goto L_BB1_25; }
  // PTX:168 clz.b32 %r113, %r30
  asm("clz.b32 %0, %1;" : "=r"(r113) : "r"(r30));
  // PTX:169 bra.uni $L__BB1_26
  goto L_BB1_26;
  // PTX:171 $L__BB1_25:
L_BB1_25:;
  // PTX:172 xor.b32 %r85, %r29, %r1
  asm("xor.b32 %0, %1, %2;" : "=r"(r85) : "r"(r29), "r"(r1));
  // PTX:173 clz.b32 %r86, %r85
  asm("clz.b32 %0, %1;" : "=r"(r86) : "r"(r85));
  // PTX:174 add.s32 %r113, %r86, 32
  asm("add.s32 %0, %1, 32;" : "=r"(r113) : "r"(r86));
  // PTX:176 $L__BB1_26:
L_BB1_26:;
  // PTX:177 setp.gt.s32 %p25, %r113, %r108
  p25 = (((int)(r113)) > ((int)(r108)));
  // PTX:178 selp.b32 %r87, %r111, 0, %p25
  r87 = p25 ? r111 : 0;
  // PTX:179 add.s32 %r114, %r87, %r114
  asm("add.s32 %0, %1, %2;" : "=r"(r114) : "r"(r87), "r"(r114));
  // PTX:180 setp.gt.s32 %p26, %r25, 3
  p26 = (((int)(r25)) > ((int)(3)));
  // PTX:181 @%p26 bra $L__BB1_22
  if (p26) { goto L_BB1_22; }
  // PTX:183 $L__BB1_27:
L_BB1_27:;
  // PTX:184 mad.lo.s32 %r88, %r114, %r11, %r1
  asm("mad.lo.s32 %0, %1, %2, %3;" : "=r"(r88) : "r"(r114), "r"(r11), "r"(r1));
  // PTX:185 min.s32 %r36, %r1, %r88
  asm("min.s32 %0, %1, %2;" : "=r"(r36) : "r"(r1), "r"(r88));
  // PTX:186 max.s32 %r37, %r1, %r88
  asm("max.s32 %0, %1, %2;" : "=r"(r37) : "r"(r1), "r"(r88));
  // PTX:187 setp.lt.s32 %p27, %r37, 0
  p27 = (((int)(r37)) < ((int)(0)));
  // PTX:188 setp.ge.s32 %p28, %r37, %r53
  p28 = (((int)(r37)) >= ((int)(r53)));
  // PTX:189 or.pred %p29, %p27, %p28
  p29 = ((p27) || (p28));
  // PTX:190 mul.wide.s32 %rd15, %r36, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd15) : "r"(r36));
  // PTX:191 add.s64 %rd4, %rd1, %rd15
  asm("add.s64 %0, %1, %2;" : "=l"(rd4) : "l"(rd1), "l"(rd15));
  // PTX:192 @%p29 bra $L__BB1_31
  if (p29) { goto L_BB1_31; }
  // PTX:193 bra.uni $L__BB1_28
  goto L_BB1_28;
  // PTX:195 $L__BB1_31:
L_BB1_31:;
  // PTX:196 mov.u32 %r115, -1
  asm("mov.u32 %0, -1;" : "=r"(r115) : );
  // PTX:197 bra.uni $L__BB1_32
  goto L_BB1_32;
  // PTX:199 $L__BB1_28:
L_BB1_28:;
  // PTX:200 ld.global.u32 %r89, [%rd4]
  r89 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd4) + (0)))));
  // PTX:201 mul.wide.s32 %rd16, %r37, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd16) : "r"(r37));
  // PTX:202 add.s64 %rd17, %rd1, %rd16
  asm("add.s64 %0, %1, %2;" : "=l"(rd17) : "l"(rd1), "l"(rd16));
  // PTX:203 ld.global.u32 %r90, [%rd17]
  r90 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:204 xor.b32 %r38, %r90, %r89
  asm("xor.b32 %0, %1, %2;" : "=r"(r38) : "r"(r90), "r"(r89));
  // PTX:205 setp.eq.s32 %p30, %r38, 0
  p30 = (((int)(r38)) == ((int)(0)));
  // PTX:206 @%p30 bra $L__BB1_30
  if (p30) { goto L_BB1_30; }
  // PTX:208 clz.b32 %r115, %r38
  asm("clz.b32 %0, %1;" : "=r"(r115) : "r"(r38));
  // PTX:209 bra.uni $L__BB1_32
  goto L_BB1_32;
  // PTX:211 $L__BB1_30:
L_BB1_30:;
  // PTX:212 xor.b32 %r91, %r36, %r37
  asm("xor.b32 %0, %1, %2;" : "=r"(r91) : "r"(r36), "r"(r37));
  // PTX:213 clz.b32 %r92, %r91
  asm("clz.b32 %0, %1;" : "=r"(r92) : "r"(r91));
  // PTX:214 add.s32 %r115, %r92, 32
  asm("add.s32 %0, %1, 32;" : "=r"(r115) : "r"(r92));
  // PTX:216 $L__BB1_32:
L_BB1_32:;
  // PTX:217 sub.s32 %r117, %r37, %r36
  asm("sub.s32 %0, %1, %2;" : "=r"(r117) : "r"(r37), "r"(r36));
  // PTX:218 mov.u32 %r119, %r36
  asm("mov.u32 %0, %1;" : "=r"(r119) : "r"(r36));
  // PTX:220 $L__BB1_33:
L_BB1_33:;
  // PTX:221 add.s32 %r94, %r117, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r94) : "r"(r117));
  // PTX:222 shr.s32 %r45, %r94, 1
  asm("shr.s32 %0, %1, 1;" : "=r"(r45) : "r"(r94));
  // PTX:223 add.s32 %r46, %r45, %r119
  asm("add.s32 %0, %1, %2;" : "=r"(r46) : "r"(r45), "r"(r119));
  // PTX:224 setp.ge.s32 %p31, %r46, %r37
  p31 = (((int)(r46)) >= ((int)(r37)));
  // PTX:225 @%p31 bra $L__BB1_39
  if (p31) { goto L_BB1_39; }
  // PTX:227 setp.lt.s32 %p32, %r46, 0
  p32 = (((int)(r46)) < ((int)(0)));
  // PTX:228 setp.ge.s32 %p33, %r46, %r53
  p33 = (((int)(r46)) >= ((int)(r53)));
  // PTX:229 or.pred %p34, %p32, %p33
  p34 = ((p32) || (p33));
  // PTX:230 mov.u32 %r118, -1
  asm("mov.u32 %0, -1;" : "=r"(r118) : );
  // PTX:231 @%p34 bra $L__BB1_38
  if (p34) { goto L_BB1_38; }
  // PTX:233 ld.global.u32 %r96, [%rd4]
  r96 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd4) + (0)))));
  // PTX:234 mul.wide.s32 %rd18, %r46, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd18) : "r"(r46));
  // PTX:235 add.s64 %rd19, %rd1, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd1), "l"(rd18));
  // PTX:236 ld.global.u32 %r97, [%rd19]
  r97 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))));
  // PTX:237 xor.b32 %r47, %r97, %r96
  asm("xor.b32 %0, %1, %2;" : "=r"(r47) : "r"(r97), "r"(r96));
  // PTX:238 setp.eq.s32 %p35, %r47, 0
  p35 = (((int)(r47)) == ((int)(0)));
  // PTX:239 @%p35 bra $L__BB1_37
  if (p35) { goto L_BB1_37; }
  // PTX:241 clz.b32 %r118, %r47
  asm("clz.b32 %0, %1;" : "=r"(r118) : "r"(r47));
  // PTX:242 bra.uni $L__BB1_38
  goto L_BB1_38;
  // PTX:244 $L__BB1_37:
L_BB1_37:;
  // PTX:245 xor.b32 %r98, %r46, %r36
  asm("xor.b32 %0, %1, %2;" : "=r"(r98) : "r"(r46), "r"(r36));
  // PTX:246 clz.b32 %r99, %r98
  asm("clz.b32 %0, %1;" : "=r"(r99) : "r"(r98));
  // PTX:247 add.s32 %r118, %r99, 32
  asm("add.s32 %0, %1, 32;" : "=r"(r118) : "r"(r99));
  // PTX:249 $L__BB1_38:
L_BB1_38:;
  // PTX:250 setp.gt.s32 %p36, %r118, %r115
  p36 = (((int)(r118)) > ((int)(r115)));
  // PTX:251 selp.b32 %r119, %r46, %r119, %p36
  r119 = p36 ? r46 : r119;
  // PTX:253 $L__BB1_39:
L_BB1_39:;
  // PTX:254 setp.gt.s32 %p37, %r117, 2
  p37 = (((int)(r117)) > ((int)(2)));
  // PTX:255 mov.u32 %r117, %r45
  asm("mov.u32 %0, %1;" : "=r"(r117) : "r"(r45));
  // PTX:256 @%p37 bra $L__BB1_33
  if (p37) { goto L_BB1_33; }
  // PTX:258 add.s32 %r100, %r53, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r100) : "r"(r53));
  // PTX:259 setp.eq.s32 %p38, %r119, %r36
  p38 = (((int)(r119)) == ((int)(r36)));
  // PTX:260 selp.b32 %r101, %r100, 0, %p38
  r101 = p38 ? r100 : 0;
  // PTX:261 add.s32 %r102, %r101, %r119
  asm("add.s32 %0, %1, %2;" : "=r"(r102) : "r"(r101), "r"(r119));
  // PTX:262 add.s32 %r103, %r119, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r103) : "r"(r119));
  // PTX:263 setp.eq.s32 %p39, %r103, %r37
  p39 = (((int)(r103)) == ((int)(r37)));
  // PTX:264 selp.b32 %r104, %r53, 1, %p39
  r104 = p39 ? r53 : 1;
  // PTX:265 add.s32 %r105, %r104, %r119
  asm("add.s32 %0, %1, %2;" : "=r"(r105) : "r"(r104), "r"(r119));
  // PTX:266 cvta.to.global.u64 %rd20, %rd6
  rd20 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd6));
  // PTX:267 shl.b64 %rd21, %rd3, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd21) : "l"(rd3));
  // PTX:268 add.s64 %rd22, %rd20, %rd21
  asm("add.s64 %0, %1, %2;" : "=l"(rd22) : "l"(rd20), "l"(rd21));
  // PTX:269 st.global.u32 [%rd22], %r102
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (0))))) = (unsigned)(r102);
  // PTX:270 st.global.u32 [%rd22+4], %r105
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (4))))) = (unsigned)(r105);
  // PTX:271 cvta.to.global.u64 %rd23, %rd5
  rd23 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd5));
  // PTX:272 mul.wide.s32 %rd24, %r105, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd24) : "r"(r105));
  // PTX:273 add.s64 %rd25, %rd23, %rd24
  asm("add.s64 %0, %1, %2;" : "=l"(rd25) : "l"(rd23), "l"(rd24));
  // PTX:274 st.global.u32 [%rd25], %r1
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (0))))) = (unsigned)(r1);
  // PTX:275 mul.wide.s32 %rd26, %r102, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd26) : "r"(r102));
  // PTX:276 add.s64 %rd27, %rd23, %rd26
  asm("add.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd23), "l"(rd26));
  // PTX:277 st.global.u32 [%rd27], %r1
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0))))) = (unsigned)(r1);
  // PTX:279 $L__BB1_41:
L_BB1_41:;
  // PTX:280 ret
  return;
}
