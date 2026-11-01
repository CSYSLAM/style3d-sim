
/home/oem/code/agent/style3d-sim/style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so：     文件格式 elf64-x86-64


Disassembly of section .text:

0000000000127060 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)>:
  127060:	endbr64 
  127064:	push   %r14
  127066:	push   %r13
  127068:	mov    %rdx,%r13
  12706b:	push   %r12
  12706d:	mov    %rsi,%r12
  127070:	push   %rbp
  127071:	mov    %rcx,%rbp
  127074:	push   %rbx
  127075:	mov    %rdi,%rbx
  127078:	sub    $0x130,%rsp
  12707f:	mov    0x754(%rdi),%eax
  127085:	test   %eax,%eax
  127087:	jne    127097 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)+0x37>
  127089:	mov    0x758(%rdi),%edx
  12708f:	test   %edx,%edx
  127091:	je     1274e0 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)+0x480>
  127097:	movss  0xc86ed(%rip),%xmm2        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  12709f:	movaps %xmm0,%xmm1
  1270a2:	andps  0xc86f7(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  1270a9:	ucomiss %xmm1,%xmm2
  1270ac:	jb     7b148 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*) [clone .cold]>
  1270b2:	pxor   %xmm1,%xmm1
  1270b6:	comiss %xmm0,%xmm1
  1270b9:	jae    7b148 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*) [clone .cold]>
  1270bf:	test   %eax,%eax
  1270c1:	jne    127408 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)+0x3a8>
  1270c7:	mov    0x758(%rbx),%eax
  1270cd:	test   %eax,%eax
  1270cf:	jne    1270f0 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)+0x90>
  1270d1:	call   6c890 <cudaGetLastError@plt>
  1270d6:	add    $0x130,%rsp
  1270dd:	pop    %rbx
  1270de:	mov    %eax,%edi
  1270e0:	pop    %rbp
  1270e1:	pop    %r12
  1270e3:	pop    %r13
  1270e5:	pop    %r14
  1270e7:	jmp    6d030 <synreal::(anonymous namespace)::check(cudaError)@plt>
  1270ec:	nopl   0x0(%rax)
  1270f0:	lea    0xfe(%rax),%edx
  1270f6:	add    $0x7f,%eax
  1270f9:	mov    0xd1c48(%rip),%r14        # 1f8d48 <thrust::THRUST_200302_520_NS::system::detail::sequential::seq+0x7>
  127100:	mov    %rbp,%r9
  127103:	cmovs  %edx,%eax
  127106:	mov    $0x1,%ecx
  12710b:	xor    %r8d,%r8d
  12710e:	movss  %xmm0,0x760(%rbx)
  127116:	movabs $0x100000080,%rdx
  127120:	mov    %r14,0x30(%rsp)
  127125:	sar    $0x7,%eax
  127128:	movl   $0x1,0x38(%rsp)
  127130:	mov    %eax,0xb0(%rsp)
  127137:	movabs $0x100000001,%rax
  127141:	mov    %rax,0xb4(%rsp)
  127149:	mov    0xb0(%rsp),%rdi
  127151:	mov    0xb8(%rsp),%esi
  127158:	call   6efb0 <__cudaPushCallConfiguration@plt>
  12715d:	test   %eax,%eax
  12715f:	je     1276b0 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)+0x650>
  127165:	movslq 0x750(%rbx),%rdx
  12716c:	mov    0x770(%rbx),%rdi
  127173:	mov    %rbp,%rcx
  127176:	mov    $0xff,%esi
  12717b:	shl    $0x2,%rdx
  12717f:	call   6e930 <cudaMemsetAsync@plt>
  127184:	mov    %eax,%edi
  127186:	call   6d030 <synreal::(anonymous namespace)::check(cudaError)@plt>
  12718b:	mov    %r14,%rdx
  12718e:	mov    %rbp,%r9
  127191:	mov    %r14,0x20(%rsp)
  127196:	mov    0x748(%rbx),%ecx
  12719c:	movl   $0x1,0x28(%rsp)
  1271a4:	lea    0xfe(%rcx),%eax
  1271aa:	add    $0x7f,%ecx
  1271ad:	cmovns %ecx,%eax
  1271b0:	xor    %r8d,%r8d
  1271b3:	mov    $0x1,%ecx
  1271b8:	sar    $0x7,%eax
  1271bb:	mov    %eax,0xb0(%rsp)
  1271c2:	movabs $0x100000001,%rax
  1271cc:	mov    %rax,0xb4(%rsp)
  1271d4:	mov    0xb0(%rsp),%rdi
  1271dc:	mov    0xb8(%rsp),%esi
  1271e3:	call   6efb0 <__cudaPushCallConfiguration@plt>
  1271e8:	test   %eax,%eax
  1271ea:	je     1274f0 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)+0x490>
  1271f0:	mov    0x748(%rbx),%ecx
  1271f6:	mov    %r14,%rdx
  1271f9:	mov    %rbp,%r9
  1271fc:	lea    0xfe(%rcx),%eax
  127202:	add    $0x7f,%ecx
  127205:	cmovns %ecx,%eax
  127208:	xor    %r8d,%r8d
  12720b:	mov    $0x1,%ecx
  127210:	sar    $0x7,%eax
  127213:	mov    %eax,0x20(%rsp)
  127217:	movabs $0x100000001,%rax
  127221:	mov    %rax,0x24(%rsp)
  127226:	mov    0x20(%rsp),%rdi
  12722b:	mov    0x28(%rsp),%esi
  12722f:	call   6efb0 <__cudaPushCallConfiguration@plt>
  127234:	test   %eax,%eax
  127236:	jne    1270d1 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)+0x71>
  12723c:	movdqu 0x7d0(%rbx),%xmm5
  127244:	movdqu 0x890(%rbx),%xmm4
  12724c:	sub    $0x8,%rsp
  127250:	mov    $0xe9,%ecx
  127255:	movdqu 0x7b0(%rbx),%xmm3
  12725d:	movdqu 0x870(%rbx),%xmm0
  127265:	mov    %rbx,%rsi
  127268:	movdqu 0x850(%rbx),%xmm7
  127270:	movdqu 0x830(%rbx),%xmm1
  127278:	punpcklqdq %xmm5,%xmm3
  12727c:	punpcklqdq %xmm4,%xmm0
  127280:	movdqu 0x810(%rbx),%xmm6
  127288:	movdqu 0x7f0(%rbx),%xmm2
  127290:	movaps %xmm3,0xc8(%rsp)
  127298:	movd   0x750(%rbx),%xmm3
  1272a0:	punpcklqdq %xmm7,%xmm1
  1272a4:	movdqu 0x790(%rbx),%xmm5
  1272ac:	movaps %xmm0,0xf8(%rsp)
  1272b4:	movd   0x748(%rbx),%xmm0
  1272bc:	punpcklqdq %xmm6,%xmm2
  1272c0:	movdqu 0x770(%rbx),%xmm4
  1272c8:	movaps %xmm1,0xe8(%rsp)
  1272d0:	movss  0x12c(%rbx),%xmm1
  1272d8:	mov    0x8b0(%rbx),%rax
  1272df:	punpckldq %xmm3,%xmm0
  1272e3:	movaps %xmm2,0xd8(%rsp)
  1272eb:	movss  0x128(%rbx),%xmm2
  1272f3:	punpcklqdq %xmm5,%xmm4
  1272f7:	movaps %xmm4,0xb8(%rsp)
  1272ff:	mov    0x9b0(%rbx),%r11
  127306:	mov    0x990(%rbx),%r10
  12730d:	mov    %rax,0x108(%rsp)
  127315:	mov    0x9f0(%rbx),%r12
  12731c:	movq   %xmm0,0x110(%rsp)
  127325:	movss  0x130(%rbx),%xmm0
  12732d:	mov    0x9d0(%rbx),%rdx
  127334:	unpcklps %xmm0,%xmm1
  127337:	movss  0x75c(%rbx),%xmm0
  12733f:	unpcklps %xmm2,%xmm0
  127342:	movlhps %xmm1,%xmm0
  127345:	movaps %xmm0,0x118(%rsp)
  12734d:	movss  0x760(%rbx),%xmm0
  127355:	movss  %xmm0,0x128(%rsp)
  12735e:	push   0xa50(%rbx)
  127364:	push   0x130(%rsp)
  12736b:	push   0x130(%rsp)
  127372:	push   0x130(%rsp)
  127379:	push   0x130(%rsp)
  127380:	push   0x130(%rsp)
  127387:	push   0x130(%rsp)
  12738e:	push   0x130(%rsp)
  127395:	push   0x130(%rsp)
  12739c:	push   0x130(%rsp)
  1273a3:	push   0x130(%rsp)
  1273aa:	push   0x130(%rsp)
  1273b1:	push   0x130(%rsp)
  1273b8:	push   0x130(%rsp)
  1273bf:	push   0x130(%rsp)
  1273c6:	push   0x130(%rsp)
  1273cd:	sub    $0x748,%rsp
  1273d4:	mov    %rsp,%rdi
  1273d7:	rep movsq %ds:(%rsi),%es:(%rdi)
  1273da:	mov    0xa30(%rbx),%r9
  1273e1:	mov    %r12,%rcx
  1273e4:	mov    %r11,%rsi
  1273e7:	mov    0xa10(%rbx),%r8
  1273ee:	mov    %r10,%rdi
  1273f1:	call   6a9d0 <synreal::granular_kernel::form_bonds(synreal::Model, synreal::granular_kernel::View, int const*, int const*, int*, glm::vec<2, int, (glm::qualifier)0>*, float*, float*, int*)@plt>
  1273f6:	add    $0x7d0,%rsp
  1273fd:	jmp    1270d1 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)+0x71>
  127402:	nopw   0x0(%rax,%rax,1)
  127408:	mov    0xd1939(%rip),%rdx        # 1f8d48 <thrust::THRUST_200302_520_NS::system::detail::sequential::seq+0x7>
  12740f:	mov    %rbp,%r9
  127412:	mov    $0x1,%ecx
  127417:	movss  %xmm0,0xc(%rsp)
  12741d:	movl   $0x1,0x38(%rsp)
  127425:	mov    %rdx,0x30(%rsp)
  12742a:	lea    0xfe(%rax),%edx
  127430:	add    $0x7f,%eax
  127433:	cmovs  %edx,%eax
  127436:	xor    %r8d,%r8d
  127439:	movabs $0x100000080,%rdx
  127443:	sar    $0x7,%eax
  127446:	mov    %eax,0xb0(%rsp)
  12744d:	movabs $0x100000001,%rax
  127457:	mov    %rax,0xb4(%rsp)
  12745f:	mov    0xb0(%rsp),%rdi
  127467:	mov    0xb8(%rsp),%esi
  12746e:	call   6efb0 <__cudaPushCallConfiguration@plt>
  127473:	movss  0xc(%rsp),%xmm0
  127479:	test   %eax,%eax
  12747b:	jne    1270c7 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)+0x67>
  127481:	sub    $0x750,%rsp
  127488:	mov    $0xe9,%ecx
  12748d:	mov    %rbx,%rsi
  127490:	mov    0x950(%rbx),%r11
  127497:	mov    0x910(%rbx),%r10
  12749e:	mov    %rsp,%rdi
  1274a1:	mov    0x930(%rbx),%rdx
  1274a8:	rep movsq %ds:(%rsi),%es:(%rdi)
  1274ab:	mov    %r11,%rcx
  1274ae:	mov    %r12,%rdi
  1274b1:	mov    %r10,%rsi
  1274b4:	mov    0x754(%rbx),%r9d
  1274bb:	mov    0x970(%rbx),%r8
  1274c2:	call   6ab10 <synreal::granular_kernel::commit_bonds(synreal::Model, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, float const*, float*, int*, int)@plt>
  1274c7:	add    $0x750,%rsp
  1274ce:	movss  0xc(%rsp),%xmm0
  1274d4:	jmp    1270c7 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)+0x67>
  1274d9:	nopl   0x0(%rax)
  1274e0:	add    $0x130,%rsp
  1274e7:	pop    %rbx
  1274e8:	pop    %rbp
  1274e9:	pop    %r12
  1274eb:	pop    %r13
  1274ed:	pop    %r14
  1274ef:	ret    
  1274f0:	movdqu 0x790(%rbx),%xmm6
  1274f8:	movdqu 0x770(%rbx),%xmm1
  127500:	mov    $0xe9,%ecx
  127505:	mov    %rbx,%rsi
  127508:	movdqu 0x7d0(%rbx),%xmm7
  127510:	movdqu 0x890(%rbx),%xmm5
  127518:	punpcklqdq %xmm6,%xmm1
  12751c:	movdqu 0x870(%rbx),%xmm0
  127524:	movdqu 0x850(%rbx),%xmm6
  12752c:	movaps %xmm1,0x30(%rsp)
  127531:	movdqu 0x7b0(%rbx),%xmm1
  127539:	movss  0x128(%rbx),%xmm2
  127541:	punpcklqdq %xmm5,%xmm0
  127545:	movdqu 0x810(%rbx),%xmm5
  12754d:	mov    0x8b0(%rbx),%rax
  127554:	punpcklqdq %xmm7,%xmm1
  127558:	movaps %xmm0,0x70(%rsp)
  12755d:	movd   0x750(%rbx),%xmm7
  127565:	movd   0x748(%rbx),%xmm0
  12756d:	movaps %xmm1,0x40(%rsp)
  127572:	movdqu 0x7f0(%rbx),%xmm1
  12757a:	movq   %xmm5,%rdx
  12757f:	mov    0x830(%rbx),%r10
  127586:	punpckldq %xmm7,%xmm0
  12758a:	mov    %rax,0x80(%rsp)
  127592:	mov    0x790(%rbx),%rax
  127599:	movq   %xmm0,0x88(%rsp)
  1275a2:	punpcklqdq %xmm5,%xmm1
  1275a6:	movss  0x130(%rbx),%xmm0
  1275ae:	movaps %xmm1,0x50(%rsp)
  1275b3:	movdqu 0x830(%rbx),%xmm1
  1275bb:	punpcklqdq %xmm6,%xmm1
  1275bf:	movaps %xmm1,0x60(%rsp)
  1275c4:	movss  0x12c(%rbx),%xmm1
  1275cc:	unpcklps %xmm0,%xmm1
  1275cf:	movss  0x75c(%rbx),%xmm0
  1275d7:	unpcklps %xmm2,%xmm0
  1275da:	movlhps %xmm1,%xmm0
  1275dd:	movaps %xmm0,0x90(%rsp)
  1275e5:	movss  0x760(%rbx),%xmm0
  1275ed:	movss  %xmm0,0xa0(%rsp)
  1275f6:	push   %rax
  1275f7:	mov    0x770(%rbx),%rax
  1275fe:	push   %rax
  1275ff:	mov    0x7f0(%rbx),%rax
  127606:	push   %rax
  127607:	mov    0x7d0(%rbx),%rax
  12760e:	push   %rax
  12760f:	push   0xc0(%rsp)
  127616:	push   0xc0(%rsp)
  12761d:	push   0xc0(%rsp)
  127624:	push   0xc0(%rsp)
  12762b:	push   0xc0(%rsp)
  127632:	push   0xc0(%rsp)
  127639:	push   0xc0(%rsp)
  127640:	push   0xc0(%rsp)
  127647:	push   0xc0(%rsp)
  12764e:	push   0xc0(%rsp)
  127655:	push   0xc0(%rsp)
  12765c:	push   0xc0(%rsp)
  127663:	push   0xc0(%rsp)
  12766a:	push   0xc0(%rsp)
  127671:	push   0xc0(%rsp)
  127678:	sub    $0x748,%rsp
  12767f:	mov    %rsp,%rdi
  127682:	rep movsq %ds:(%rsi),%es:(%rdi)
  127685:	mov    %r10,%rcx
  127688:	mov    %r13,%rsi
  12768b:	mov    %r12,%rdi
  12768e:	mov    0x7b0(%rbx),%r9
  127695:	mov    0x850(%rbx),%r8
  12769c:	call   6acb0 <synreal::granular_kernel::build_grid(synreal::Model, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, synreal::granular_kernel::View, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, float*, int*, int*, glm::vec<3, int, (glm::qualifier)0>*, int*, int*)@plt>
  1276a1:	add    $0x7e0,%rsp
  1276a8:	jmp    1271f0 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)+0x190>
  1276ad:	nopl   (%rax)
  1276b0:	sub    $0x750,%rsp
  1276b7:	mov    $0xe9,%ecx
  1276bc:	mov    %rbx,%rsi
  1276bf:	mov    0xa30(%rbx),%r11
  1276c6:	mov    0x9f0(%rbx),%r10
  1276cd:	mov    0xa10(%rbx),%rdx
  1276d4:	mov    %rsp,%rdi
  1276d7:	rep movsq %ds:(%rsi),%es:(%rdi)
  1276da:	mov    %r11,%rcx
  1276dd:	mov    %r12,%rdi
  1276e0:	mov    %r10,%rsi
  1276e3:	mov    0x758(%rbx),%r9d
  1276ea:	mov    0xa50(%rbx),%r8
  1276f1:	call   6ab10 <synreal::granular_kernel::commit_bonds(synreal::Model, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, float const*, float*, int*, int)@plt>
  1276f6:	add    $0x750,%rsp
  1276fd:	jmp    127165 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)+0x105>
