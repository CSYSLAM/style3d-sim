
../_core.cpython-312-x86_64-linux-gnu.so：     文件格式 elf64-x86-64


Disassembly of section .text:

00000000000fb160 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)>:
   fb160:	endbr64 
   fb164:	push   %rbp
   fb165:	movq   %rsi,%xmm5
   fb16a:	movq   %rdi,%xmm6
   fb16f:	punpcklqdq %xmm6,%xmm5
   fb173:	mov    %rsp,%rbp
   fb176:	push   %r15
   fb178:	push   %r14
   fb17a:	mov    %r8,%r14
   fb17d:	push   %r13
   fb17f:	push   %r12
   fb181:	push   %rbx
   fb182:	mov    %rdi,%rbx
   fb185:	sub    $0xbd8,%rsp
   fb18c:	mov    %rsi,-0xaf8(%rbp)
   fb193:	mov    0xa8(%rdi),%esi
   fb199:	mov    %rdx,-0xb18(%rbp)
   fb1a0:	lea    -0xad4(%rbp),%rdx
   fb1a7:	mov    %rcx,-0xb88(%rbp)
   fb1ae:	movq   %rdx,%xmm6
   fb1b3:	mov    %r9,-0xaf0(%rbp)
   fb1ba:	movss  %xmm0,-0xae4(%rbp)
   fb1c2:	mov    %fs:0x28,%rax
   fb1cb:	mov    %rax,-0x38(%rbp)
   fb1cf:	xor    %eax,%eax
   fb1d1:	lea    -0xa70(%rbp),%rax
   fb1d8:	movaps %xmm5,-0xb70(%rbp)
   fb1df:	movq   %rax,%xmm7
   fb1e4:	lea    -0xaf0(%rbp),%rax
   fb1eb:	mov    %rsi,-0xaa8(%rbp)
   fb1f2:	mov    %rax,%rcx
   fb1f5:	mov    %rax,-0xb00(%rbp)
   fb1fc:	punpcklqdq %xmm7,%xmm6
   fb200:	lea    -0x6e0(%rbp),%rax
   fb207:	movq   %rax,%xmm5
   fb20c:	movq   %rcx,%xmm7
   fb211:	mov    0xac(%rdi),%eax
   fb217:	movaps %xmm6,-0xb30(%rbp)
   fb21e:	punpcklqdq %xmm5,%xmm7
   fb222:	movaps %xmm7,-0xb10(%rbp)
   fb229:	test   %eax,%eax
   fb22b:	je     fe340 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x31e0>
   fb231:	mov    %rax,-0xaa0(%rbp)
   fb238:	movaps %xmm0,%xmm2
   fb23b:	pxor   %xmm6,%xmm6
   fb23f:	comiss %xmm6,%xmm2
   fb242:	jbe    76e80 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x83e>
   fb248:	movss  0xf953c(%rip),%xmm0        # 1f478c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
   fb250:	movss  0xf9548(%rip),%xmm1        # 1f47a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
   fb258:	movaps %xmm2,%xmm3
   fb25b:	andps  %xmm1,%xmm3
   fb25e:	ucomiss %xmm3,%xmm0
   fb261:	jb     76e80 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x83e>
   fb267:	mov    -0xaf8(%rbp),%rcx
   fb26e:	cmp    %rax,0x8(%rcx)
   fb272:	jb     102a39 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78d9>
   fb278:	cmp    %rax,0x18(%rcx)
   fb27c:	jb     76dee <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x7ac>
   fb282:	mov    0x28(%rcx),%rdx
   fb286:	cmp    %rax,%rdx
   fb289:	setb   -0xae8(%rbp)
   fb290:	test   %rdx,%rdx
   fb293:	movzbl -0xae8(%rbp),%ecx
   fb29a:	setne  %dl
   fb29d:	and    %cl,%dl
   fb29f:	mov    %edx,%r15d
   fb2a2:	jne    102a6b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x790b>
   fb2a8:	mov    -0xb18(%rbp),%rdx
   fb2af:	cmp    %rax,0x8(%rdx)
   fb2b3:	jb     102a66 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7906>
   fb2b9:	cmp    %rax,0x18(%rdx)
   fb2bd:	jb     76f12 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x8d0>
   fb2c3:	mov    0x10(%r14),%ecx
   fb2c7:	test   %ecx,%ecx
   fb2c9:	je     fb34f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ef>
   fb2cf:	cmpq   $0x0,0x8(%r14)
   fb2d4:	je     768cc <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x28a>
   fb2da:	mov    %ecx,%edx
   fb2dc:	cmp    0x20(%r14),%rdx
   fb2e0:	ja     768cc <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x28a>
   fb2e6:	cmp    0x30(%r14),%rdx
   fb2ea:	ja     768cc <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x28a>
   fb2f0:	cmp    0x40(%r14),%rdx
   fb2f4:	ja     768cc <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x28a>
   fb2fa:	cmp    0x50(%r14),%rdx
   fb2fe:	ja     768cc <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x28a>
   fb304:	cmp    0x80(%r14),%rdx
   fb30b:	ja     768cc <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x28a>
   fb311:	cmp    0x90(%r14),%rdx
   fb318:	ja     768cc <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x28a>
   fb31e:	cmp    0xa0(%r14),%rdx
   fb325:	ja     768cc <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x28a>
   fb32b:	mov    0x60(%r14),%rdi
   fb32f:	test   %rdi,%rdi
   fb332:	je     fb33d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1dd>
   fb334:	cmp    %rdi,%rdx
   fb337:	ja     766a6 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x64>
   fb33d:	mov    0x70(%r14),%rdi
   fb341:	test   %rdi,%rdi
   fb344:	je     fb34f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ef>
   fb346:	cmp    %rdi,%rdx
   fb349:	ja     766a6 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x64>
   fb34f:	mov    0xb0(%r14),%rdx
   fb356:	test   %rdx,%rdx
   fb359:	je     fe360 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3200>
   fb35f:	cmp    %rdx,%rcx
   fb362:	ja     102a70 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7910>
   fb368:	mov    0x130(%r14),%rdi
   fb36f:	mov    0xd0(%r14),%ecx
   fb376:	test   %rdi,%rdi
   fb379:	jne    fb389 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x229>
   fb37b:	cmpq   $0x0,0x140(%r14)
   fb383:	je     fe560 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3400>
   fb389:	mov    %ecx,%edx
   fb38b:	cmp    %rdi,%rdx
   fb38e:	ja     7686c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x22a>
   fb394:	cmp    0x140(%r14),%rdx
   fb39b:	ja     7686c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x22a>
   fb3a1:	test   %ecx,%ecx
   fb3a3:	je     1010f0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5f90>
   fb3a9:	cmpq   $0x0,0xc8(%r14)
   fb3b1:	je     102a3e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78de>
   fb3b7:	cmpq   $0x0,0x150(%r14)
   fb3bf:	mov    $0x1,%r15d
   fb3c5:	jne    fe578 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3418>
   fb3cb:	cmp    %rdx,0xf0(%r14)
   fb3d2:	jb     76cca <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x688>
   fb3d8:	cmp    %rdx,0x100(%r14)
   fb3df:	jb     76cca <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x688>
   fb3e5:	cmp    %rdx,0x110(%r14)
   fb3ec:	jb     76cca <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x688>
   fb3f2:	cmp    %rdx,0x120(%r14)
   fb3f9:	jb     76cca <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x688>
   fb3ff:	mov    $0x1,%r12d
   fb405:	test   %rsi,%rsi
   fb408:	je     fb412 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2b2>
   fb40a:	xor    %edx,%edx
   fb40c:	div    %rsi
   fb40f:	mov    %rax,%r12
   fb412:	mov    -0xb88(%rbp),%rcx
   fb419:	mov    0x2e0(%rbx),%eax
   fb41f:	mov    0x48(%rcx),%rdx
   fb423:	imul   %r12,%rax
   fb427:	test   %rdx,%rdx
   fb42a:	setne  %cl
   fb42d:	cmp    %rdx,%rax
   fb430:	mov    %rax,-0xa98(%rbp)
   fb437:	seta   %al
   fb43a:	test   %al,%cl
   fb43c:	jne    76d5c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x71a>
   fb442:	mov    0x5d4(%rbx),%eax
   fb448:	test   %eax,%eax
   fb44a:	je     fb492 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x332>
   fb44c:	mov    0x5d8(%rbx),%edx
   fb452:	mov    -0xb88(%rbp),%rsi
   fb459:	imul   %r12,%rdx
   fb45d:	cmp    0x8(%rsi),%rdx
   fb461:	ja     76da5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x763>
   fb467:	mov    0x5dc(%rbx),%ecx
   fb46d:	imul   %r12,%rcx
   fb471:	cmp    0x18(%rsi),%rcx
   fb475:	ja     76da5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x763>
   fb47b:	cmp    0x28(%rsi),%rdx
   fb47f:	ja     76da5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x763>
   fb485:	mov    0x38(%rsi),%rdx
   fb489:	test   %rdx,%rdx
   fb48c:	jne    101ce0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6b80>
   fb492:	cmpl   $0x3e7,0x20(%rbx)
   fb499:	ja     102a5c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78fc>
   fb49f:	mov    0x24(%rbx),%eax
   fb4a2:	sub    $0x1,%eax
   fb4a5:	cmp    $0x3e6,%eax
   fb4aa:	ja     76c21 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x5df>
   fb4b0:	movss  0xc(%rbx),%xmm3
   fb4b5:	pxor   %xmm7,%xmm7
   fb4b9:	comiss %xmm7,%xmm3
   fb4bc:	jb     76c53 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x611>
   fb4c2:	andps  %xmm1,%xmm3
   fb4c5:	ucomiss %xmm3,%xmm0
   fb4c8:	jb     76c53 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x611>
   fb4ce:	mov    0x14(%rbx),%eax
   fb4d1:	sub    $0x1,%eax
   fb4d4:	cmp    $0x3e6,%eax
   fb4d9:	ja     102a61 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7901>
   fb4df:	mov    0x18(%rbx),%eax
   fb4e2:	sub    $0x1,%eax
   fb4e5:	cmp    $0x3e6,%eax
   fb4ea:	ja     76798 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x156>
   fb4f0:	movss  0x74(%rbx),%xmm3
   fb4f5:	comiss %xmm7,%xmm3
   fb4f8:	jbe    76674 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x32>
   fb4fe:	andps  %xmm1,%xmm3
   fb501:	ucomiss %xmm3,%xmm0
   fb504:	jb     76674 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x32>
   fb50a:	movss  0x78(%rbx),%xmm3
   fb50f:	comiss %xmm7,%xmm3
   fb512:	jb     102a28 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78c8>
   fb518:	andps  %xmm1,%xmm3
   fb51b:	ucomiss %xmm3,%xmm0
   fb51e:	jb     76915 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x2d3>
   fb524:	movss  0x7c(%rbx),%xmm3
   fb529:	comiss %xmm7,%xmm3
   fb52c:	jb     76915 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x2d3>
   fb532:	andps  %xmm1,%xmm3
   fb535:	ucomiss %xmm3,%xmm0
   fb538:	jb     76915 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x2d3>
   fb53e:	movss  0x80(%rbx),%xmm3
   fb546:	comiss %xmm7,%xmm3
   fb549:	jb     76915 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x2d3>
   fb54f:	andps  %xmm1,%xmm3
   fb552:	ucomiss %xmm3,%xmm0
   fb555:	jb     76915 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x2d3>
   fb55b:	movss  0x84(%rbx),%xmm3
   fb563:	comiss %xmm7,%xmm3
   fb566:	jb     76915 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x2d3>
   fb56c:	andps  %xmm1,%xmm3
   fb56f:	ucomiss %xmm3,%xmm0
   fb572:	jb     76915 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x2d3>
   fb578:	cmpl   $0x3,0x88(%rbx)
   fb57f:	ja     102a43 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78e3>
   fb585:	cmpl   $0x1,0x10(%rbx)
   fb589:	ja     76990 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x34e>
   fb58f:	cmpl   $0x1,0x8(%rbx)
   fb593:	ja     769c2 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x380>
   fb599:	mulss  %xmm2,%xmm2
   fb59d:	comiss %xmm7,%xmm2
   fb5a0:	jbe    76a39 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x3f7>
   fb5a6:	ucomiss %xmm2,%xmm0
   fb5a9:	jb     76a39 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x3f7>
   fb5af:	movss  0x1019c9(%rip),%xmm3        # 1fcf80 <cuda::std::__4::in_place+0x33>
   fb5b7:	divss  %xmm2,%xmm3
   fb5bb:	ucomiss %xmm3,%xmm0
   fb5be:	movss  %xmm3,-0xacc(%rbp)
   fb5c6:	jb     102a48 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78e8>
   fb5cc:	movss  0x30(%rbx),%xmm2
   fb5d1:	movaps %xmm2,%xmm3
   fb5d4:	andps  %xmm1,%xmm3
   fb5d7:	ucomiss %xmm3,%xmm0
   fb5da:	jb     76ab4 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x472>
   fb5e0:	comiss %xmm2,%xmm7
   fb5e3:	ja     76ab4 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x472>
   fb5e9:	movss  0x34(%rbx),%xmm2
   fb5ee:	andps  %xmm1,%xmm2
   fb5f1:	ucomiss %xmm2,%xmm0
   fb5f4:	jb     76ab4 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x472>
   fb5fa:	movss  0x38(%rbx),%xmm2
   fb5ff:	andps  %xmm1,%xmm2
   fb602:	ucomiss %xmm2,%xmm0
   fb605:	jb     76ab4 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x472>
   fb60b:	movss  0x3c(%rbx),%xmm2
   fb610:	andps  %xmm1,%xmm2
   fb613:	ucomiss %xmm2,%xmm0
   fb616:	jb     76ab4 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x472>
   fb61c:	movss  0x44(%rbx),%xmm2
   fb621:	comiss %xmm7,%xmm2
   fb624:	jbe    102a4d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78ed>
   fb62a:	andps  %xmm1,%xmm2
   fb62d:	ucomiss %xmm2,%xmm0
   fb630:	jb     76b14 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x4d2>
   fb636:	movss  0x48(%rbx),%xmm2
   fb63b:	comiss %xmm7,%xmm2
   fb63e:	jb     102a52 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78f2>
   fb644:	andps  %xmm1,%xmm2
   fb647:	ucomiss %xmm2,%xmm0
   fb64a:	jb     76b5d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x51b>
   fb650:	movss  0x50(%rbx),%xmm2
   fb655:	comiss %xmm7,%xmm2
   fb658:	jb     102a57 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78f7>
   fb65e:	movss  0x10191a(%rip),%xmm6        # 1fcf80 <cuda::std::__4::in_place+0x33>
   fb666:	comiss %xmm2,%xmm6
   fb669:	jb     76ba6 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x564>
   fb66f:	andps  %xmm1,%xmm2
   fb672:	ucomiss %xmm2,%xmm0
   fb675:	jb     76ba6 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x564>
   fb67b:	movss  0x58(%rbx),%xmm2
   fb680:	comiss %xmm7,%xmm2
   fb683:	jb     102a81 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7921>
   fb689:	comiss %xmm2,%xmm6
   fb68c:	jb     76f8d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x94b>
   fb692:	andps  %xmm1,%xmm2
   fb695:	ucomiss %xmm2,%xmm0
   fb698:	jb     76f8d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x94b>
   fb69e:	movss  0x54(%rbx),%xmm2
   fb6a3:	comiss %xmm7,%xmm2
   fb6a6:	jb     102a86 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7926>
   fb6ac:	andps  %xmm1,%xmm2
   fb6af:	ucomiss %xmm2,%xmm0
   fb6b2:	jb     7683a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x1f8>
   fb6b8:	movss  0x5c(%rbx),%xmm2
   fb6bd:	comiss %xmm7,%xmm2
   fb6c0:	jb     7683a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x1f8>
   fb6c6:	andps  %xmm1,%xmm2
   fb6c9:	ucomiss %xmm2,%xmm0
   fb6cc:	jb     7683a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x1f8>
   fb6d2:	lea    0x8(%rbx),%rdi
   fb6d6:	call   6e270 <(anonymous namespace)::validate_cable_penalty_config(synreal::Config const&)@plt>
   fb6db:	mov    0x32e8(%rbx),%rax
   fb6e2:	mov    0x3328(%rbx),%rdx
   fb6e9:	movss  0xf90af(%rip),%xmm1        # 1f47a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
   fb6f1:	movss  0xf9093(%rip),%xmm0        # 1f478c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
   fb6f9:	test   %rax,%rax
   fb6fc:	mov    %rax,-0xa90(%rbp)
   fb703:	mov    %rdx,-0xa88(%rbp)
   fb70a:	je     fb71b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5bb>
   fb70c:	movss  0x30(%rbx),%xmm2
   fb711:	pxor   %xmm7,%xmm7
   fb715:	comiss %xmm7,%xmm2
   fb718:	seta   %al
   fb71b:	mov    %al,-0xada(%rbp)
   fb721:	mov    0x714(%rbx),%eax
   fb727:	mov    %r12,-0xa80(%rbp)
   fb72e:	cmp    $0x1,%r12
   fb732:	je     101120 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5fc0>
   fb738:	mov    0x39c(%rbx),%edx
   fb73e:	mov    %eax,-0xac8(%rbp)
   fb744:	test   %edx,%edx
   fb746:	jne    fb74e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5ee>
   fb748:	mov    0x398(%rbx),%edx
   fb74e:	movss  0xc(%rbx),%xmm2
   fb753:	mulss  0x5d0(%rbx),%xmm2
   fb75b:	mov    %rdx,-0xa78(%rbp)
   fb762:	mov    0x10(%rbx),%eax
   fb765:	mulss  -0xacc(%rbp),%xmm2
   fb76d:	mov    0x1818(%rbx),%r13d
   fb774:	mov    %eax,-0xb1c(%rbp)
   fb77a:	mov    0x8(%rbx),%eax
   fb77d:	test   %eax,%eax
   fb77f:	mov    %eax,-0xb74(%rbp)
   fb785:	movss  %xmm2,-0xac4(%rbp)
   fb78d:	sete   -0xb58(%rbp)
   fb794:	test   %r13d,%r13d
   fb797:	je     fb7e1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x681>
   fb799:	movss  0x28(%rbx),%xmm2
   fb79e:	movaps %xmm2,%xmm3
   fb7a1:	andps  %xmm1,%xmm3
   fb7a4:	ucomiss %xmm3,%xmm0
   fb7a7:	jb     76f5b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x919>
   fb7ad:	pxor   %xmm6,%xmm6
   fb7b1:	comiss %xmm2,%xmm6
   fb7b4:	jae    76f5b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x919>
   fb7ba:	comiss 0x1017bf(%rip),%xmm2        # 1fcf80 <cuda::std::__4::in_place+0x33>
   fb7c1:	ja     76f5b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x919>
   fb7c7:	movss  0x2c(%rbx),%xmm2
   fb7cc:	andps  %xmm2,%xmm1
   fb7cf:	ucomiss %xmm1,%xmm0
   fb7d2:	jb     76f5b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x919>
   fb7d8:	comiss %xmm2,%xmm6
   fb7db:	ja     76f5b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x919>
   fb7e1:	mov    -0xaa0(%rbp),%rdi
   fb7e8:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fb7ed:	mov    0x10(%r14),%esi
   fb7f1:	mov    %eax,-0xae8(%rbp)
   fb7f7:	mov    0x20(%rbx),%eax
   fb7fa:	mov    %eax,-0xb20(%rbp)
   fb800:	test   %esi,%esi
   fb802:	je     fb812 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6b2>
   fb804:	mov    0x398(%rbx),%edx
   fb80a:	test   %edx,%edx
   fb80c:	jne    101c78 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6b18>
   fb812:	movb   $0x0,-0xad9(%rbp)
   fb819:	xor    %r8d,%r8d
   fb81c:	lea    -0x2b0(%rbp),%rdi
   fb823:	xor    %eax,%eax
   fb825:	mov    $0x27,%ecx
   fb82a:	movb   $0x0,-0xad8(%rbp)
   fb831:	mov    %rdi,-0xba0(%rbp)
   fb838:	rep stos %rax,%es:(%rdi)
   fb83b:	mov    0x101756(%rip),%rax        # 1fcf98 <cuda::std::__4::in_place+0x4b>
   fb842:	movl   $0x3f733333,-0x1c4(%rbp)
   fb84c:	movb   $0x1,-0x1b2(%rbp)
   fb853:	mov    %rax,-0x1bc(%rbp)
   fb85a:	lea    -0x500(%rbp),%rax
   fb861:	mov    %rax,-0xbb8(%rbp)
   fb868:	test   %r8b,%r8b
   fb86b:	je     fb87a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x71a>
   fb86d:	cmpb   $0x0,0x3371(%rbx)
   fb874:	jne    fe388 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3228>
   fb87a:	lea    -0x3b0(%rbp),%rdi
   fb881:	mov    $0x1f,%ecx
   fb886:	xor    %eax,%eax
   fb888:	movb   $0x0,-0xad7(%rbp)
   fb88f:	rep stos %rax,%es:(%rdi)
   fb892:	mov    0xd0(%r14),%edi
   fb899:	test   %edi,%edi
   fb89b:	je     fe556 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x33f6>
   fb8a1:	cmpl   $0x1,0x710(%rbx)
   fb8a8:	mov    0x710(%rbx),%r11d
   fb8af:	mov    %r15d,%ecx
   fb8b2:	sbb    %eax,%eax
   fb8b4:	xor    %edx,%edx
   fb8b6:	add    $0x1,%eax
   fb8b9:	test   %r11d,%r11d
   fb8bc:	cmove  %edx,%ecx
   fb8bf:	mov    %ecx,%r15d
   fb8c2:	mov    %al,-0xad6(%rbp)
   fb8c8:	mov    %r15b,-0xad5(%rbp)
   fb8cf:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fb8d4:	mov    $0x20,%edx
   fb8d9:	mov    $0x25,%ecx
   fb8de:	mov    -0xbb8(%rbp),%rdi
   fb8e5:	cmp    %edx,%eax
   fb8e7:	cmova  %edx,%eax
   fb8ea:	mov    %eax,-0xac0(%rbp)
   fb8f0:	xor    %eax,%eax
   fb8f2:	cmpb   $0x0,-0xad5(%rbp)
   fb8f9:	rep stos %rax,%es:(%rdi)
   fb8fc:	jne    100ce0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5b80>
   fb902:	mov    -0xaa8(%rbp),%rsi
   fb909:	mov    -0xa80(%rbp),%rdx
   fb910:	mov    0x3d0(%rbx),%rcx
   fb917:	mov    0x3e0(%rbx),%r8
   fb91e:	mov    0x498(%rbx),%eax
   fb924:	movb   $0x0,-0xb45(%rbp)
   fb92b:	mov    %eax,-0xb50(%rbp)
   fb931:	mov    0x400(%rbx),%eax
   fb937:	test   %eax,%eax
   fb939:	setne  -0xad4(%rbp)
   fb940:	je     fb95b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7fb>
   fb942:	movss  0x60(%rbx),%xmm0
   fb947:	pxor   %xmm6,%xmm6
   fb94b:	movb   $0x1,-0xb45(%rbp)
   fb952:	comiss %xmm6,%xmm0
   fb955:	jbe    101dd0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6c70>
   fb95b:	mov    %rax,%rdi
   fb95e:	movq   %rax,%xmm0
   fb963:	movdqu 0x410(%rbx),%xmm1
   fb96b:	mov    0x438(%rbx),%rax
   fb972:	imul   %rdx,%rdi
   fb976:	movdqu 0x420(%rbx),%xmm5
   fb97e:	movdqu 0x3c0(%rbx),%xmm2
   fb986:	mov    %rcx,-0x6e0(%rbp)
   fb98d:	movdqu 0x400(%rbx),%xmm4
   fb995:	mov    %rax,-0x6b0(%rbp)
   fb99c:	xor    %eax,%eax
   fb99e:	punpckhqdq %xmm5,%xmm1
   fb9a2:	cmpb   $0x0,-0xb45(%rbp)
   fb9a9:	mov    %r8,-0x6d8(%rbp)
   fb9b0:	movq   %rdi,%xmm7
   fb9b5:	shufpd $0x2,%xmm4,%xmm2
   fb9ba:	mov    %rdi,-0xa70(%rbp)
   fb9c1:	punpcklqdq %xmm7,%xmm0
   fb9c5:	movaps %xmm2,-0x6d0(%rbp)
   fb9cc:	movaps %xmm1,-0x6c0(%rbp)
   fb9d3:	je     fb9dc <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x87c>
   fb9d5:	mov    0x3150(%rbx),%rax
   fb9dc:	movq   %rax,%xmm1
   fb9e1:	mov    0x458(%rbx),%rax
   fb9e8:	movhps 0x448(%rbx),%xmm1
   fb9ef:	mov    %rax,-0x698(%rbp)
   fb9f6:	xor    %eax,%eax
   fb9f8:	cmpq   $0x0,0x470(%rbx)
   fba00:	movups %xmm1,-0x6a8(%rbp)
   fba07:	je     fba10 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x8b0>
   fba09:	mov    0x468(%rbx),%rax
   fba10:	mov    %rax,-0x690(%rbp)
   fba17:	xor    %eax,%eax
   fba19:	cmpq   $0x0,0x480(%rbx)
   fba21:	je     fba2a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x8ca>
   fba23:	mov    0x478(%rbx),%rax
   fba2a:	mov    %rax,-0x688(%rbp)
   fba31:	xor    %eax,%eax
   fba33:	cmpq   $0x0,0x490(%rbx)
   fba3b:	je     fba44 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x8e4>
   fba3d:	mov    0x488(%rbx),%rax
   fba44:	movq   0x30f0(%rbx),%xmm2
   fba4c:	movq   %rax,%xmm1
   fba51:	mov    0x3130(%rbx),%rax
   fba58:	mov    %rsi,-0x648(%rbp)
   fba5f:	movhps 0x30d0(%rbx),%xmm1
   fba66:	cmpb   $0x0,-0xb45(%rbp)
   fba6d:	mov    -0xb50(%rbp),%r8d
   fba74:	movups %xmm0,-0x658(%rbp)
   fba7b:	movhps 0x3110(%rbx),%xmm2
   fba82:	mov    %rax,-0x660(%rbp)
   fba89:	movaps %xmm1,-0x680(%rbp)
   fba90:	movaps %xmm2,-0x670(%rbp)
   fba97:	jne    101270 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6110>
   fba9d:	mov    0x49c(%rbx),%eax
   fbaa3:	mov    %r8d,%edi
   fbaa6:	movdqa -0xb70(%rbp),%xmm5
   fbaae:	movq   %rcx,%xmm0
   fbab3:	movq   0x620(%rbx),%xmm4
   fbabb:	mov    0x568(%rbx),%r11d
   fbac2:	lea    -0xae4(%rbp),%r15
   fbac9:	movhps 0x5e0(%rbx),%xmm0
   fbad0:	sub    %eax,%edi
   fbad2:	imul   %rdx,%rax
   fbad6:	movq   0x35a0(%rbx),%xmm3
   fbade:	movaps %xmm5,-0x7d0(%rbp)
   fbae5:	movq   0x5f0(%rbx),%xmm5
   fbaed:	mov    %rdi,-0xbc0(%rbp)
   fbaf4:	movhps 0x630(%rbx),%xmm4
   fbafb:	mov    0x4f0(%rbx),%edi
   fbb01:	movhps 0x35c0(%rbx),%xmm3
   fbb08:	movdqa -0xb30(%rbp),%xmm6
   fbb10:	mov    %r11d,-0xb4c(%rbp)
   fbb17:	mov    %rax,-0xba8(%rbp)
   fbb1e:	mov    0x56c(%rbx),%eax
   fbb24:	movhps 0x600(%rbx),%xmm5
   fbb2b:	movdqa -0xb10(%rbp),%xmm7
   fbb33:	movaps %xmm0,-0x760(%rbp)
   fbb3a:	movq   0x35e0(%rbx),%xmm2
   fbb42:	imul   %rdx,%rax
   fbb46:	movaps %xmm4,-0x740(%rbp)
   fbb4d:	movq   0x3620(%rbx),%xmm1
   fbb55:	movhps 0x3600(%rbx),%xmm2
   fbb5c:	mov    %r15,-0x7c0(%rbp)
   fbb63:	movhps 0x650(%rbx),%xmm1
   fbb6a:	mov    %edi,-0xb44(%rbp)
   fbb70:	mov    %rax,-0xa68(%rbp)
   fbb77:	mov    0x5d4(%rbx),%eax
   fbb7d:	movaps %xmm6,-0x7f0(%rbp)
   fbb84:	test   %eax,%eax
   fbb86:	mov    %rax,%rcx
   fbb89:	movq   %rax,%xmm0
   fbb8e:	movaps %xmm7,-0x7e0(%rbp)
   fbb95:	setne  -0xad3(%rbp)
   fbb9c:	lea    -0x760(%rbp),%rax
   fbba3:	movaps %xmm5,-0x750(%rbp)
   fbbaa:	imul   %rdx,%rcx
   fbbae:	movaps %xmm3,-0x730(%rbp)
   fbbb5:	mov    0x2e0(%rbx),%r8d
   fbbbc:	mov    -0xaf8(%rbp),%r11
   fbbc3:	mov    %rax,-0x848(%rbp)
   fbbca:	mov    %rax,-0x810(%rbp)
   fbbd1:	mov    0x318(%rbx),%eax
   fbbd7:	test   %r8d,%r8d
   fbbda:	movq   %rcx,%xmm4
   fbbdf:	setne  -0xad2(%rbp)
   fbbe6:	lea    -0xad3(%rbp),%rcx
   fbbed:	punpcklqdq %xmm4,%xmm0
   fbbf1:	imul   %rdx,%rax
   fbbf5:	mov    %rsi,-0x6f0(%rbp)
   fbbfc:	mov    -0xb00(%rbp),%rsi
   fbc03:	mov    %rcx,-0x820(%rbp)
   fbc0a:	mov    %edi,%ecx
   fbc0c:	mov    %rbx,-0x850(%rbp)
   fbc13:	mov    %rax,-0xa60(%rbp)
   fbc1a:	movzbl 0x40(%rbx),%eax
   fbc1e:	mov    %rsi,-0x840(%rbp)
   fbc25:	mov    %r11,-0x838(%rbp)
   fbc2c:	mov    %r15,-0x830(%rbp)
   fbc33:	mov    %rbx,-0x818(%rbp)
   fbc3a:	mov    %rsi,-0x808(%rbp)
   fbc41:	mov    %r11,-0x800(%rbp)
   fbc48:	mov    %r15,-0x7f8(%rbp)
   fbc4f:	movaps %xmm2,-0x720(%rbp)
   fbc56:	movaps %xmm1,-0x710(%rbp)
   fbc5d:	movaps %xmm0,-0x700(%rbp)
   fbc64:	test   %al,%al
   fbc66:	jne    101920 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x67c0>
   fbc6c:	mov    0x88(%rbx),%esi
   fbc72:	mov    %al,-0xad1(%rbp)
   fbc78:	movl   $0x0,-0xb10(%rbp)
   fbc82:	mov    %esi,-0xb30(%rbp)
   fbc88:	mov    %esi,-0xabc(%rbp)
   fbc8e:	cmp    $0x2,%esi
   fbc91:	jne    fbca0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xb40>
   fbc93:	movss  0xc(%rbx),%xmm4
   fbc98:	movss  %xmm4,-0xb10(%rbp)
   fbca0:	imul   %rdx,%rcx
   fbca4:	lea    -0xad8(%rbp),%rdx
   fbcab:	mov    %r14,-0x7a8(%rbp)
   fbcb2:	mov    %rdx,-0x7b0(%rbp)
   fbcb9:	mov    -0xb00(%rbp),%rdx
   fbcc0:	mov    %rbx,-0x790(%rbp)
   fbcc7:	mov    %rcx,-0xb80(%rbp)
   fbcce:	mov    -0xba0(%rbp),%rcx
   fbcd5:	mov    %rdx,-0x7a0(%rbp)
   fbcdc:	lea    -0xa80(%rbp),%rdx
   fbce3:	mov    %rcx,-0x798(%rbp)
   fbcea:	lea    -0xac8(%rbp),%rcx
   fbcf1:	mov    %rdx,-0xbc8(%rbp)
   fbcf8:	mov    %rdx,-0x780(%rbp)
   fbcff:	mov    -0xaf8(%rbp),%rdx
   fbd06:	mov    %rcx,-0xb60(%rbp)
   fbd0d:	mov    %rcx,-0x788(%rbp)
   fbd14:	lea    -0xaa8(%rbp),%rcx
   fbd1b:	mov    %rdx,-0x778(%rbp)
   fbd22:	mov    %r15,-0x770(%rbp)
   fbd29:	mov    %rcx,-0xb90(%rbp)
   fbd30:	mov    %rcx,-0x768(%rbp)
   fbd37:	test   %al,%al
   fbd39:	jne    101630 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x64d0>
   fbd3f:	cmpb   $0x0,-0xad8(%rbp)
   fbd46:	jne    1015a8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6448>
   fbd4c:	cmpq   $0x0,0x2ca0(%rbx)
   fbd54:	jne    fbd64 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xc04>
   fbd56:	cmpq   $0x0,0x2ce0(%rbx)
   fbd5e:	je     fbde6 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xc86>
   fbd64:	mov    0x101225(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fbd6b:	mov    0x2c60(%rbx),%rdi
   fbd72:	movl   $0x1,-0x638(%rbp)
   fbd7c:	mov    -0xaf0(%rbp),%r12
   fbd83:	mov    %rax,-0x640(%rbp)
   fbd8a:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fbd8f:	mov    -0x638(%rbp),%ecx
   fbd95:	xor    %r8d,%r8d
   fbd98:	mov    %r12,%r9
   fbd9b:	mov    %eax,-0x5a0(%rbp)
   fbda1:	mov    -0x640(%rbp),%rdx
   fbda8:	movabs $0x100000001,%rax
   fbdb2:	mov    %rax,-0x59c(%rbp)
   fbdb9:	mov    -0x5a0(%rbp),%rdi
   fbdc0:	mov    -0x598(%rbp),%esi
   fbdc6:	call   6f040 <__cudaPushCallConfiguration@plt>
   fbdcb:	test   %eax,%eax
   fbdcd:	je     102598 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7438>
   fbdd3:	call   6c900 <cudaGetLastError@plt>
   fbdd8:	lea    0xfe181(%rip),%rsi        # 1f9f60 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5060>
   fbddf:	mov    %eax,%edi
   fbde1:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fbde6:	cmpq   $0x0,0x2d20(%rbx)
   fbdee:	jne    101890 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6730>
   fbdf4:	mov    0x101195(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fbdfb:	mov    0x10118e(%rip),%rdx        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fbe02:	xor    %r8d,%r8d
   fbe05:	mov    $0x1,%ecx
   fbe0a:	mov    -0xaf0(%rbp),%r9
   fbe11:	movl   $0x1,-0x638(%rbp)
   fbe1b:	mov    %rax,-0x640(%rbp)
   fbe22:	mov    -0xae8(%rbp),%eax
   fbe28:	mov    %eax,-0x5a0(%rbp)
   fbe2e:	movabs $0x100000001,%rax
   fbe38:	mov    %rax,-0x59c(%rbp)
   fbe3f:	mov    -0x5a0(%rbp),%rdi
   fbe46:	mov    -0x598(%rbp),%esi
   fbe4c:	call   6f040 <__cudaPushCallConfiguration@plt>
   fbe51:	test   %eax,%eax
   fbe53:	jne    fbf82 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xe22>
   fbe59:	mov    -0xaa8(%rbp),%rax
   fbe60:	mov    %rax,-0xb38(%rbp)
   fbe67:	mov    -0xaa0(%rbp),%rax
   fbe6e:	mov    %rax,-0xb40(%rbp)
   fbe75:	mov    0x2f10(%rbx),%rax
   fbe7c:	mov    %rax,-0xb98(%rbp)
   fbe83:	mov    0x30b0(%rbx),%rax
   fbe8a:	mov    %rax,-0xbb0(%rbp)
   fbe91:	mov    0x3090(%rbx),%rax
   fbe98:	mov    %rax,-0xbd0(%rbp)
   fbe9f:	mov    0x33e0(%rbx),%rax
   fbea6:	mov    %rax,-0xbd8(%rbp)
   fbead:	xor    %eax,%eax
   fbeaf:	cmpq   $0x0,0x100(%rbx)
   fbeb7:	jne    101cc0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6b60>
   fbebd:	cmpl   $0x1,-0xb1c(%rbp)
   fbec4:	movss  0xc(%rbx),%xmm3
   fbec9:	pxor   %xmm4,%xmm4
   fbecd:	mov    0xc0(%rbx),%r13
   fbed4:	mov    0x2ed0(%rbx),%r12
   fbedb:	jne    101cb0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6b50>
   fbee1:	mov    -0xaf8(%rbp),%rdx
   fbee8:	mov    0x2eb0(%rbx),%r11
   fbeef:	mov    0x2e90(%rbx),%r10
   fbef6:	mov    0x2e70(%rbx),%rdi
   fbefd:	mov    (%rdx),%r8
   fbf00:	mov    0x10(%rdx),%rcx
   fbf04:	xor    %edx,%edx
   fbf06:	cmpl   $0x1,0x90(%rbx)
   fbf0d:	mov    0x2e50(%rbx),%rsi
   fbf14:	mov    0x2e30(%rbx),%r9
   fbf1b:	jbe    101de8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6c88>
   fbf21:	sub    $0x8,%rsp
   fbf25:	push   -0xb38(%rbp)
   fbf2b:	movaps %xmm3,%xmm5
   fbf2e:	pxor   %xmm2,%xmm2
   fbf32:	movss  -0xb10(%rbp),%xmm1
   fbf3a:	push   -0xb40(%rbp)
   fbf40:	movss  -0xae4(%rbp),%xmm0
   fbf48:	push   -0xb98(%rbp)
   fbf4e:	push   -0xbb0(%rbp)
   fbf54:	push   -0xbd0(%rbp)
   fbf5a:	push   -0xbd8(%rbp)
   fbf60:	push   %rax
   fbf61:	push   %r13
   fbf63:	push   %r12
   fbf65:	push   %r11
   fbf67:	push   %r10
   fbf69:	push   %rdi
   fbf6a:	mov    0x98(%rbx),%rdi
   fbf71:	push   %rsi
   fbf72:	mov    0xa0(%rbx),%rsi
   fbf79:	call   6ad60 <synreal::kernel::initialize_step(float, glm::vec<3, float, (glm::qualifier)0> const*, unsigned long, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, float const*, float const*, float, float const*, float, float const*, float, float const*, float, float const*, float, float const*, int const*, int const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, float*, unsigned long, unsigned long)@plt>
   fbf7e:	add    $0x70,%rsp
   fbf82:	call   6c900 <cudaGetLastError@plt>
   fbf87:	lea    0x100637(%rip),%rsi        # 1fc5c5 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x76c5>
   fbf8e:	mov    %eax,%edi
   fbf90:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fbf95:	cmpb   $0x0,-0xad3(%rbp)
   fbf9c:	je     fc036 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xed6>
   fbfa2:	mov    -0xb88(%rbp),%rax
   fbfa9:	mov    -0xaf0(%rbp),%r12
   fbfb0:	mov    -0x6f8(%rbp),%rdi
   fbfb7:	cmpq   $0x0,0x38(%rax)
   fbfbc:	jne    101c40 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6ae0>
   fbfc2:	mov    0x100fc7(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fbfc9:	movl   $0x1,-0x638(%rbp)
   fbfd3:	mov    %rax,-0x640(%rbp)
   fbfda:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fbfdf:	mov    -0x638(%rbp),%ecx
   fbfe5:	xor    %r8d,%r8d
   fbfe8:	mov    %r12,%r9
   fbfeb:	mov    %eax,-0x5a0(%rbp)
   fbff1:	mov    -0x640(%rbp),%rdx
   fbff8:	movabs $0x100000001,%rax
   fc002:	mov    %rax,-0x59c(%rbp)
   fc009:	mov    -0x5a0(%rbp),%rdi
   fc010:	mov    -0x598(%rbp),%esi
   fc016:	call   6f040 <__cudaPushCallConfiguration@plt>
   fc01b:	test   %eax,%eax
   fc01d:	je     1028c4 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7764>
   fc023:	call   6c900 <cudaGetLastError@plt>
   fc028:	lea    0xfdfb9(%rip),%rsi        # 1f9fe8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x50e8>
   fc02f:	mov    %eax,%edi
   fc031:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc036:	cmpb   $0x0,-0xada(%rbp)
   fc03d:	jne    101800 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x66a0>
   fc043:	mov    -0xaa0(%rbp),%rax
   fc04a:	mov    0x2f10(%rbx),%rsi
   fc051:	mov    $0x3,%ecx
   fc056:	mov    0x2ef0(%rbx),%rdi
   fc05d:	mov    -0xaf0(%rbp),%r8
   fc064:	lea    0x0(,%rax,4),%rdx
   fc06c:	call   6e130 <cudaMemcpyAsync@plt>
   fc071:	lea    0xfdfd0(%rip),%rsi        # 1fa048 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5148>
   fc078:	mov    %eax,%edi
   fc07a:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc07f:	mov    -0xb44(%rbp),%ecx
   fc085:	test   %ecx,%ecx
   fc087:	jne    101778 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6618>
   fc08d:	cmpl   $0x3,-0xb30(%rbp)
   fc094:	je     101138 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5fd8>
   fc09a:	cmpl   $0x1,-0xb1c(%rbp)
   fc0a1:	jne    fc0c1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf61>
   fc0a3:	cmpq   $0x0,-0xba8(%rbp)
   fc0ab:	jne    102790 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7630>
   fc0b1:	mov    -0xa68(%rbp),%rdi
   fc0b8:	test   %rdi,%rdi
   fc0bb:	jne    102710 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x75b0>
   fc0c1:	mov    0xd0(%rbx),%r13d
   fc0c8:	test   %r13d,%r13d
   fc0cb:	jne    100c80 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5b20>
   fc0d1:	mov    0x398(%rbx),%r12d
   fc0d8:	xor    %edi,%edi
   fc0da:	test   %r12d,%r12d
   fc0dd:	jne    101bc8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6a68>
   fc0e3:	movb   $0x0,-0xad0(%rbp)
   fc0ea:	xor    %r13d,%r13d
   fc0ed:	xor    %edx,%edx
   fc0ef:	xor    %eax,%eax
   fc0f1:	cmpl   $0x1,-0xb1c(%rbp)
   fc0f8:	mov    %dl,-0xacf(%rbp)
   fc0fe:	jne    fc10e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xfae>
   fc100:	cmpq   $0x0,-0xa68(%rbp)
   fc108:	jne    101b98 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6a38>
   fc10e:	movb   $0x0,-0xbd0(%rbp)
   fc115:	xor    %esi,%esi
   fc117:	movzbl -0xad3(%rbp),%ecx
   fc11e:	test   %eax,%eax
   fc120:	movzbl -0xad5(%rbp),%r8d
   fc128:	mov    %sil,-0xace(%rbp)
   fc12f:	setne  %al
   fc132:	mov    %cl,-0xacd(%rbp)
   fc138:	test   %r8b,%r8b
   fc13b:	jne    fe590 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3430>
   fc141:	movzbl -0xb58(%rbp),%edx
   fc148:	cmpb   $0x0,-0xad7(%rbp)
   fc14f:	mov    %dl,-0xb10(%rbp)
   fc155:	jne    fe590 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3430>
   fc15b:	movzbl 0x41(%rbx),%edx
   fc15f:	test   %dl,%dl
   fc161:	je     fc178 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1018>
   fc163:	movzbl -0xad9(%rbp),%edx
   fc16a:	movzbl -0xad6(%rbp),%r9d
   fc172:	test   %dl,%dl
   fc174:	cmove  %r9d,%edx
   fc178:	mov    %r13b,-0xb40(%rbp)
   fc17f:	test   %r13b,%r13b
   fc182:	jne    fc1a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1040>
   fc184:	movzbl -0xad2(%rbp),%r13d
   fc18c:	or     -0xad1(%rbp),%r13b
   fc193:	mov    %r13b,-0xb40(%rbp)
   fc19a:	je     101b00 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x69a0>
   fc1a0:	test   %dil,%dil
   fc1a3:	lea    0x2b88(%rbx),%rdx
   fc1aa:	lea    0x2b58(%rbx),%rcx
   fc1b1:	mov    0x2bd8(%rbx),%r12
   fc1b8:	cmove  %rcx,%rdx
   fc1bc:	imul   -0xaa0(%rbp),%r12
   fc1c4:	and    0x1c(%rbx),%al
   fc1c7:	and    -0xb40(%rbp),%al
   fc1cd:	mov    %al,-0xb38(%rbp)
   fc1d3:	test   %r12,%r12
   fc1d6:	mov    %rdx,-0xb98(%rbp)
   fc1dd:	setne  %al
   fc1e0:	and    -0xb10(%rbp),%al
   fc1e6:	mov    %al,-0xbb0(%rbp)
   fc1ec:	jne    1011e0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6080>
   fc1f2:	movq   $0x0,-0x3c0(%rbp)
   fc1fd:	pxor   %xmm0,%xmm0
   fc201:	movq   $0x0,-0x3b8(%rbp)
   fc20c:	movaps %xmm0,-0x3d0(%rbp)
   fc213:	test   %r13b,%r13b
   fc216:	jne    101310 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x61b0>
   fc21c:	mov    -0xb20(%rbp),%ecx
   fc222:	test   %ecx,%ecx
   fc224:	jle    1028b8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7758>
   fc22a:	lea    (%r12,%r12,4),%rax
   fc22e:	lea    -0x9c0(%rbp),%rdx
   fc235:	movl   $0x0,-0xb00(%rbp)
   fc23f:	mov    -0xaf0(%rbp),%r12
   fc246:	shl    $0x3,%rax
   fc24a:	movq   %rdx,%xmm7
   fc24f:	cmpq   $0x0,-0xbc0(%rbp)
   fc257:	movabs $0x100000001,%r15
   fc261:	mov    %rax,-0xbd8(%rbp)
   fc268:	setne  %al
   fc26b:	and    -0xb58(%rbp),%al
   fc271:	mov    %al,-0xbc8(%rbp)
   fc277:	lea    -0x9b8(%rbp),%rax
   fc27e:	movq   %rax,%xmm5
   fc283:	punpcklqdq %xmm5,%xmm7
   fc287:	movaps %xmm7,-0xbf0(%rbp)
   fc28e:	xchg   %ax,%ax
   fc290:	cmpb   $0x0,-0xad4(%rbp)
   fc297:	je     fc3a3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1243>
   fc29d:	mov    0x100cec(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fc2a4:	mov    -0xa70(%rbp),%rdi
   fc2ab:	movl   $0x1,-0x8a0(%rbp)
   fc2b5:	mov    %rax,-0x8a8(%rbp)
   fc2bc:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fc2c1:	mov    %r15,-0x898(%rbp)
   fc2c8:	mov    -0x8a0(%rbp),%ecx
   fc2ce:	mov    %r12,%r9
   fc2d1:	xor    %r8d,%r8d
   fc2d4:	mov    %eax,-0x89c(%rbp)
   fc2da:	mov    -0x8a8(%rbp),%rdx
   fc2e1:	mov    -0x89c(%rbp),%rdi
   fc2e8:	mov    -0x894(%rbp),%esi
   fc2ee:	call   6f040 <__cudaPushCallConfiguration@plt>
   fc2f3:	test   %eax,%eax
   fc2f5:	jne    fc389 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1229>
   fc2fb:	push   -0x648(%rbp)
   fc301:	push   -0x650(%rbp)
   fc307:	push   -0x658(%rbp)
   fc30d:	push   -0x660(%rbp)
   fc313:	push   -0x668(%rbp)
   fc319:	push   -0x670(%rbp)
   fc31f:	push   -0x678(%rbp)
   fc325:	push   -0x680(%rbp)
   fc32b:	push   -0x688(%rbp)
   fc331:	push   -0x690(%rbp)
   fc337:	push   -0x698(%rbp)
   fc33d:	push   -0x6a0(%rbp)
   fc343:	push   -0x6a8(%rbp)
   fc349:	push   -0x6b0(%rbp)
   fc34f:	push   -0x6b8(%rbp)
   fc355:	push   -0x6c0(%rbp)
   fc35b:	push   -0x6c8(%rbp)
   fc361:	mov    -0xaf8(%rbp),%rax
   fc368:	push   -0x6d0(%rbp)
   fc36e:	push   -0x6d8(%rbp)
   fc374:	push   -0x6e0(%rbp)
   fc37a:	mov    (%rax),%rdi
   fc37d:	call   6acc0 <synreal::kernel::prepare_cable_tangents(synreal::kernel::CableView, glm::vec<3, float, (glm::qualifier)0> const*)@plt>
   fc382:	add    $0xa0,%rsp
   fc389:	call   6c900 <cudaGetLastError@plt>
   fc38e:	mov    %eax,%edi
   fc390:	lea    0xfde11(%rip),%rsi        # 1fa1a8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x52a8>
   fc397:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc39c:	mov    -0xaf0(%rbp),%r12
   fc3a3:	mov    -0xaa0(%rbp),%rax
   fc3aa:	mov    0x2ef0(%rbx),%rsi
   fc3b1:	mov    %r12,%r8
   fc3b4:	mov    $0x3,%ecx
   fc3b9:	mov    0x2f10(%rbx),%rdi
   fc3c0:	lea    0x0(,%rax,4),%rdx
   fc3c8:	call   6e130 <cudaMemcpyAsync@plt>
   fc3cd:	mov    %eax,%edi
   fc3cf:	lea    0xfddfa(%rip),%rsi        # 1fa1d0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x52d0>
   fc3d6:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc3db:	mov    0x100bae(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fc3e2:	xor    %r8d,%r8d
   fc3e5:	mov    $0x1,%ecx
   fc3ea:	mov    %r15,-0x898(%rbp)
   fc3f1:	mov    0x100b98(%rip),%rdx        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fc3f8:	mov    -0x894(%rbp),%esi
   fc3fe:	movl   $0x1,-0x8a0(%rbp)
   fc408:	mov    %rax,-0x8a8(%rbp)
   fc40f:	mov    -0xae8(%rbp),%eax
   fc415:	mov    -0xaf0(%rbp),%r9
   fc41c:	mov    %eax,-0x89c(%rbp)
   fc422:	mov    -0x89c(%rbp),%rdi
   fc429:	call   6f040 <__cudaPushCallConfiguration@plt>
   fc42e:	test   %eax,%eax
   fc430:	jne    fc4be <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x135e>
   fc436:	xor    %edx,%edx
   fc438:	cmpq   $0x0,0x100(%rbx)
   fc440:	mov    -0xaa8(%rbp),%r9
   fc447:	mov    -0xaa0(%rbp),%r8
   fc44e:	mov    0x3070(%rbx),%rdi
   fc455:	je     fc45e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x12fe>
   fc457:	mov    0xf8(%rbx),%rdx
   fc45e:	mov    -0xaf8(%rbp),%rcx
   fc465:	xor    %eax,%eax
   fc467:	cmpq   $0x0,0x28(%rcx)
   fc46c:	je     fc472 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1312>
   fc46e:	mov    0x20(%rcx),%rax
   fc472:	sub    $0x8,%rsp
   fc476:	mov    0xc0(%rbx),%r10
   fc47d:	mov    0x2b28(%rbx),%rcx
   fc484:	mov    0x30b0(%rbx),%rsi
   fc48b:	push   %r9
   fc48d:	push   %r8
   fc48f:	movss  -0xacc(%rbp),%xmm0
   fc497:	mov    0x2b48(%rbx),%r9
   fc49e:	mov    0x2b38(%rbx),%r8
   fc4a5:	push   %rdi
   fc4a6:	push   %rdx
   fc4a7:	mov    %r10,%rdx
   fc4aa:	push   %rax
   fc4ab:	mov    -0xaf8(%rbp),%rax
   fc4b2:	mov    (%rax),%rdi
   fc4b5:	call   6af80 <synreal::kernel::initialize_rhs(float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, int const*, synreal::NonZeroEntry const*, unsigned long, glm::vec<3, float, (glm::qualifier)0> const*, int const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long)@plt>
   fc4ba:	add    $0x30,%rsp
   fc4be:	call   6c900 <cudaGetLastError@plt>
   fc4c3:	mov    %eax,%edi
   fc4c5:	lea    0x100117(%rip),%rsi        # 1fc5e3 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x76e3>
   fc4cc:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc4d1:	mov    0x1818(%rbx),%eax
   fc4d7:	test   %eax,%eax
   fc4d9:	jne    fed60 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3c00>
   fc4df:	mov    0x21b0(%rbx),%eax
   fc4e5:	test   %eax,%eax
   fc4e7:	jne    feda1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3c41>
   fc4ed:	cmpb   $0x0,-0xada(%rbp)
   fc4f4:	je     fc5e5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1485>
   fc4fa:	mov    0x100a8f(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fc501:	mov    -0xa88(%rbp),%rdi
   fc508:	movl   $0x1,-0x8a0(%rbp)
   fc512:	mov    -0xaf0(%rbp),%r12
   fc519:	mov    %rax,-0x8a8(%rbp)
   fc520:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fc525:	mov    %r15,-0x898(%rbp)
   fc52c:	mov    -0x8a0(%rbp),%ecx
   fc532:	mov    %r12,%r9
   fc535:	xor    %r8d,%r8d
   fc538:	mov    %eax,-0x89c(%rbp)
   fc53e:	mov    -0x8a8(%rbp),%rdx
   fc545:	mov    -0x89c(%rbp),%rdi
   fc54c:	mov    -0x894(%rbp),%esi
   fc552:	call   6f040 <__cudaPushCallConfiguration@plt>
   fc557:	test   %eax,%eax
   fc559:	jne    fc5d2 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1472>
   fc55b:	mov    -0xaf8(%rbp),%rax
   fc562:	movss  0x30(%rbx),%xmm0
   fc567:	sub    $0x8,%rsp
   fc56b:	mov    0x32f8(%rbx),%rcx
   fc572:	mov    0x32d8(%rbx),%rdx
   fc579:	mov    0x3090(%rbx),%rsi
   fc580:	push   -0xaa8(%rbp)
   fc586:	movq   0x34(%rbx),%xmm1
   fc58b:	push   -0xa90(%rbp)
   fc591:	movss  0x3c(%rbx),%xmm2
   fc596:	push   -0xa88(%rbp)
   fc59c:	movss  0x1009dc(%rip),%xmm3        # 1fcf80 <cuda::std::__4::in_place+0x33>
   fc5a4:	push   0x3358(%rbx)
   fc5aa:	divss  -0xae4(%rbp),%xmm3
   fc5b2:	mov    0x3338(%rbx),%r9
   fc5b9:	push   0x3070(%rbx)
   fc5bf:	mov    0x3318(%rbx),%r8
   fc5c6:	mov    (%rax),%rdi
   fc5c9:	call   6abd0 <synreal::kernel::evaluate_triangle_drag(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, glm::vec<3, float, (glm::qualifier)0>, float, glm::vec<3, float, (glm::qualifier)0>*, float*, unsigned long, unsigned long, unsigned long)@plt>
   fc5ce:	add    $0x30,%rsp
   fc5d2:	call   6c900 <cudaGetLastError@plt>
   fc5d7:	mov    %eax,%edi
   fc5d9:	lea    0xfdc18(%rip),%rsi        # 1fa1f8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x52f8>
   fc5e0:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc5e5:	mov    0x3090(%rbx),%rax
   fc5ec:	movss  -0xae4(%rbp),%xmm6
   fc5f4:	cmpb   $0x0,-0xad9(%rbp)
   fc5fb:	mov    0x3070(%rbx),%r13
   fc602:	mov    %rax,-0xb60(%rbp)
   fc609:	mov    0x2f10(%rbx),%rax
   fc610:	movss  %xmm6,-0xb70(%rbp)
   fc618:	mov    %rax,-0xb58(%rbp)
   fc61f:	je     fc6a7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1547>
   fc625:	mov    0x100964(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fc62c:	cmpb   $0x0,-0xad8(%rbp)
   fc633:	movl   $0x1,-0x8a0(%rbp)
   fc63d:	mov    -0xaf0(%rbp),%r12
   fc644:	mov    0x10(%r14),%edi
   fc648:	mov    %rax,-0x8a8(%rbp)
   fc64f:	jne    ff610 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x44b0>
   fc655:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fc65a:	mov    %r15,-0x898(%rbp)
   fc661:	mov    -0x8a0(%rbp),%ecx
   fc667:	mov    %r12,%r9
   fc66a:	xor    %r8d,%r8d
   fc66d:	mov    %eax,-0x89c(%rbp)
   fc673:	mov    -0x8a8(%rbp),%rdx
   fc67a:	mov    -0x89c(%rbp),%rdi
   fc681:	mov    -0x894(%rbp),%esi
   fc687:	call   6f040 <__cudaPushCallConfiguration@plt>
   fc68c:	test   %eax,%eax
   fc68e:	je     1003d0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5270>
   fc694:	call   6c900 <cudaGetLastError@plt>
   fc699:	mov    %eax,%edi
   fc69b:	lea    0xfdba6(%rip),%rsi        # 1fa248 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5348>
   fc6a2:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc6a7:	cmpb   $0x0,-0xad7(%rbp)
   fc6ae:	je     fc7fa <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x169a>
   fc6b4:	mov    0x1008d5(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fc6bb:	mov    0x10(%r14),%edi
   fc6bf:	movl   $0x1,-0x8a0(%rbp)
   fc6c9:	mov    -0xaf0(%rbp),%r12
   fc6d0:	mov    %rax,-0x8a8(%rbp)
   fc6d7:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fc6dc:	mov    %r15,-0x898(%rbp)
   fc6e3:	mov    -0x8a0(%rbp),%ecx
   fc6e9:	mov    %r12,%r9
   fc6ec:	xor    %r8d,%r8d
   fc6ef:	mov    %eax,-0x89c(%rbp)
   fc6f5:	mov    -0x8a8(%rbp),%rdx
   fc6fc:	mov    -0x89c(%rbp),%rdi
   fc703:	mov    -0x894(%rbp),%esi
   fc709:	call   6f040 <__cudaPushCallConfiguration@plt>
   fc70e:	test   %eax,%eax
   fc710:	jne    fc7e7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1687>
   fc716:	sub    $0x8,%rsp
   fc71a:	mov    0x3070(%rbx),%rdi
   fc721:	push   -0x2c0(%rbp)
   fc727:	push   -0x2c8(%rbp)
   fc72d:	push   -0x2d0(%rbp)
   fc733:	push   -0x2d8(%rbp)
   fc739:	push   -0x2e0(%rbp)
   fc73f:	push   -0x2e8(%rbp)
   fc745:	push   -0x2f0(%rbp)
   fc74b:	push   -0x2f8(%rbp)
   fc751:	push   -0x300(%rbp)
   fc757:	push   -0x308(%rbp)
   fc75d:	push   -0x310(%rbp)
   fc763:	push   -0x318(%rbp)
   fc769:	push   -0x320(%rbp)
   fc76f:	push   -0x328(%rbp)
   fc775:	push   -0x330(%rbp)
   fc77b:	push   -0x338(%rbp)
   fc781:	push   -0x340(%rbp)
   fc787:	push   -0x348(%rbp)
   fc78d:	push   -0x350(%rbp)
   fc793:	push   -0x358(%rbp)
   fc799:	push   -0x360(%rbp)
   fc79f:	push   -0x368(%rbp)
   fc7a5:	push   -0x370(%rbp)
   fc7ab:	push   -0x378(%rbp)
   fc7b1:	push   -0x380(%rbp)
   fc7b7:	push   -0x388(%rbp)
   fc7bd:	push   -0x390(%rbp)
   fc7c3:	push   -0x398(%rbp)
   fc7c9:	push   -0x3a0(%rbp)
   fc7cf:	push   -0x3a8(%rbp)
   fc7d5:	push   -0x3b0(%rbp)
   fc7db:	call   6a870 <synreal::kernel::evaluate_rolling_contact_force(synreal::kernel::RollingContactView, glm::vec<3, float, (glm::qualifier)0>*)@plt>
   fc7e0:	add    $0x100,%rsp
   fc7e7:	call   6c900 <cudaGetLastError@plt>
   fc7ec:	mov    %eax,%edi
   fc7ee:	lea    0xfda7b(%rip),%rsi        # 1fa270 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5370>
   fc7f5:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc7fa:	mov    0x3090(%rbx),%rax
   fc801:	movss  -0xae4(%rbp),%xmm7
   fc809:	cmpb   $0x0,-0xad6(%rbp)
   fc810:	mov    0x3070(%rbx),%r12
   fc817:	mov    %rax,-0xb70(%rbp)
   fc81e:	mov    0x2f10(%rbx),%rax
   fc825:	movss  %xmm7,-0xb58(%rbp)
   fc82d:	mov    %rax,-0xb60(%rbp)
   fc834:	je     fca6c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x190c>
   fc83a:	cmpb   $0x0,-0xad5(%rbp)
   fc841:	je     fc8c8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1768>
   fc847:	test   %r12,%r12
   fc84a:	je     fc8ba <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x175a>
   fc84c:	mov    0x10073d(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fc853:	xor    %r8d,%r8d
   fc856:	mov    $0x1,%ecx
   fc85b:	mov    %r15,-0x898(%rbp)
   fc862:	mov    0x100727(%rip),%rdx        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fc869:	mov    -0x894(%rbp),%esi
   fc86f:	movl   $0x1,-0x8a0(%rbp)
   fc879:	mov    %rax,-0x8a8(%rbp)
   fc880:	mov    -0xac0(%rbp),%eax
   fc886:	mov    -0xaf0(%rbp),%r9
   fc88d:	mov    %eax,-0x89c(%rbp)
   fc893:	mov    -0x89c(%rbp),%rdi
   fc89a:	call   6f040 <__cudaPushCallConfiguration@plt>
   fc89f:	test   %eax,%eax
   fc8a1:	je     100990 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5830>
   fc8a7:	call   6c900 <cudaGetLastError@plt>
   fc8ac:	mov    %eax,%edi
   fc8ae:	lea    0xfd9e3(%rip),%rsi        # 1fa298 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5398>
   fc8b5:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc8ba:	cmpq   $0x0,0x150(%r14)
   fc8c2:	je     fca6c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x190c>
   fc8c8:	mov    0x1006c1(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fc8cf:	mov    0xd0(%r14),%edi
   fc8d6:	movl   $0x1,-0x8a0(%rbp)
   fc8e0:	mov    -0xaf0(%rbp),%r13
   fc8e7:	mov    %rax,-0x8a8(%rbp)
   fc8ee:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fc8f3:	mov    %r15,-0x898(%rbp)
   fc8fa:	mov    -0x8a0(%rbp),%ecx
   fc900:	mov    %r13,%r9
   fc903:	xor    %r8d,%r8d
   fc906:	mov    %eax,-0x89c(%rbp)
   fc90c:	mov    -0x8a8(%rbp),%rdx
   fc913:	mov    -0x89c(%rbp),%rdi
   fc91a:	mov    -0x894(%rbp),%esi
   fc920:	call   6f040 <__cudaPushCallConfiguration@plt>
   fc925:	test   %eax,%eax
   fc927:	jne    fca59 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x18f9>
   fc92d:	xor    %eax,%eax
   fc92f:	cmpb   $0x0,-0xad5(%rbp)
   fc936:	mov    0x150(%r14),%r8
   fc93d:	je     fc946 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x17e6>
   fc93f:	mov    0x148(%r14),%rax
   fc946:	sub    $0x8,%rsp
   fc94a:	movss  0x7c8(%rbx),%xmm0
   fc952:	mov    0xe8(%r14),%rcx
   fc959:	mov    0xd8(%r14),%rdx
   fc960:	mov    0xd0(%r14),%esi
   fc967:	push   $0x0
   fc969:	push   $0x0
   fc96b:	mov    0xc0(%r14),%rdi
   fc972:	push   %r8
   fc974:	push   %rax
   fc975:	mov    -0xaf8(%rbp),%rax
   fc97c:	push   -0xb60(%rbp)
   fc982:	push   %r12
   fc984:	push   -0xb70(%rbp)
   fc98a:	push   0x10(%rax)
   fc98d:	push   (%rax)
   fc98f:	mov    0x398(%rbx),%eax
   fc995:	push   %rax
   fc996:	mov    -0xac8(%rbp),%eax
   fc99c:	push   0x3e0(%rbx)
   fc9a2:	push   0x3d0(%rbx)
   fc9a8:	push   0x3f0(%rbx)
   fc9ae:	push   -0xa80(%rbp)
   fc9b4:	push   %rax
   fc9b5:	mov    0x710(%rbx),%eax
   fc9bb:	push   %rax
   fc9bc:	movss  0x1005bc(%rip),%xmm4        # 1fcf80 <cuda::std::__4::in_place+0x33>
   fc9c4:	divss  -0xb58(%rbp),%xmm4
   fc9cc:	push   0x788(%rbx)
   fc9d2:	push   0x778(%rbx)
   fc9d8:	push   0x768(%rbx)
   fc9de:	push   0x758(%rbx)
   fc9e4:	push   0x7b8(%rbx)
   fc9ea:	push   0x748(%rbx)
   fc9f0:	push   0x738(%rbx)
   fc9f6:	push   0x728(%rbx)
   fc9fc:	push   0x718(%rbx)
   fca02:	push   -0xaa0(%rbp)
   fca08:	push   -0xaa8(%rbp)
   fca0e:	push   0x33e0(%rbx)
   fca14:	push   0xc0(%rbx)
   fca1a:	push   0x118(%rbx)
   fca20:	push   0x118(%r14)
   fca27:	movss  0x7d4(%rbx),%xmm3
   fca2f:	movss  0x7d0(%rbx),%xmm2
   fca37:	movss  0x7cc(%rbx),%xmm1
   fca3f:	mov    0x108(%r14),%r9
   fca46:	mov    0xf8(%r14),%r8
   fca4d:	call   6aac0 <synreal::kernel::evaluate_soft_contact_force(int const*, unsigned long, int const*, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, int const*, unsigned long, unsigned long, int const*, int const*, synreal::Transform const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float const*, float const*, float const*, unsigned long, unsigned long, unsigned long, float, float, float, float, int const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, unsigned long, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, float*, int const*, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
   fca52:	add    $0x100,%rsp
   fca59:	call   6c900 <cudaGetLastError@plt>
   fca5e:	mov    %eax,%edi
   fca60:	lea    0xfd861(%rip),%rsi        # 1fa2c8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x53c8>
   fca67:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fca6c:	cmpb   $0x0,-0xad1(%rbp)
   fca73:	je     fcabe <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x195e>
   fca75:	mov    -0xaa0(%rbp),%rax
   fca7c:	mov    0x2f10(%rbx),%rsi
   fca83:	mov    $0x3,%ecx
   fca88:	mov    0x2f30(%rbx),%rdi
   fca8f:	mov    -0xaf0(%rbp),%r8
   fca96:	lea    0x0(,%rax,4),%rdx
   fca9e:	call   6e130 <cudaMemcpyAsync@plt>
   fcaa3:	mov    %eax,%edi
   fcaa5:	lea    0xfd84c(%rip),%rsi        # 1fa2f8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x53f8>
   fcaac:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fcab1:	cmpb   $0x0,-0xad5(%rbp)
   fcab8:	jne    fff50 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4df0>
   fcabe:	mov    -0xb50(%rbp),%eax
   fcac4:	mov    0x3070(%rbx),%r12
   fcacb:	test   %eax,%eax
   fcacd:	je     fcb97 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1a37>
   fcad3:	mov    0x498(%rbx),%r13d
   fcada:	imul   -0xa80(%rbp),%r13
   fcae2:	movl   $0x1,-0x8a0(%rbp)
   fcaec:	mov    -0xaf0(%rbp),%rax
   fcaf3:	mov    0x100496(%rip),%rcx        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fcafa:	mov    %r13,%rdi
   fcafd:	mov    %rax,-0xb58(%rbp)
   fcb04:	mov    %rcx,-0x8a8(%rbp)
   fcb0b:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fcb10:	mov    %r15,-0x898(%rbp)
   fcb17:	mov    -0x8a0(%rbp),%ecx
   fcb1d:	xor    %r8d,%r8d
   fcb20:	mov    %eax,-0x89c(%rbp)
   fcb26:	mov    -0xb58(%rbp),%r9
   fcb2d:	mov    -0x8a8(%rbp),%rdx
   fcb34:	mov    -0x89c(%rbp),%rdi
   fcb3b:	mov    -0x894(%rbp),%esi
   fcb41:	call   6f040 <__cudaPushCallConfiguration@plt>
   fcb46:	test   %eax,%eax
   fcb48:	je     100080 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4f20>
   fcb4e:	call   6c900 <cudaGetLastError@plt>
   fcb53:	mov    %eax,%edi
   fcb55:	lea    0xfd80c(%rip),%rsi        # 1fa368 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5468>
   fcb5c:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fcb61:	cmpl   $0x1,-0xb1c(%rbp)
   fcb68:	jne    fcb90 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1a30>
   fcb6a:	mov    -0xba8(%rbp),%rdi
   fcb71:	test   %rdi,%rdi
   fcb74:	je     fcb90 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1a30>
   fcb76:	movss  0xc(%rbx),%xmm0
   fcb7b:	pxor   %xmm6,%xmm6
   fcb7f:	comiss %xmm6,%xmm0
   fcb82:	ja     100ff0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5e90>
   fcb88:	nopl   0x0(%rax,%rax,1)
   fcb90:	mov    0x3070(%rbx),%r12
   fcb97:	mov    -0xb44(%rbp),%eax
   fcb9d:	test   %eax,%eax
   fcb9f:	je     fcc30 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ad0>
   fcba5:	pxor   %xmm5,%xmm5
   fcba9:	ucomiss 0xc(%rbx),%xmm5
   fcbad:	jp     fcbb1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1a51>
   fcbaf:	je     fcc30 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ad0>
   fcbb1:	mov    0x1003d8(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fcbb8:	mov    -0xb80(%rbp),%rdi
   fcbbf:	movl   $0x1,-0x8a0(%rbp)
   fcbc9:	mov    -0xaf0(%rbp),%r13
   fcbd0:	mov    %rax,-0x8a8(%rbp)
   fcbd7:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fcbdc:	mov    %r15,-0x898(%rbp)
   fcbe3:	mov    -0x8a0(%rbp),%ecx
   fcbe9:	mov    %r13,%r9
   fcbec:	xor    %r8d,%r8d
   fcbef:	mov    %eax,-0x89c(%rbp)
   fcbf5:	mov    -0x8a8(%rbp),%rdx
   fcbfc:	mov    -0x89c(%rbp),%rdi
   fcc03:	mov    -0x894(%rbp),%esi
   fcc09:	call   6f040 <__cudaPushCallConfiguration@plt>
   fcc0e:	test   %eax,%eax
   fcc10:	je     1006b8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5558>
   fcc16:	call   6c900 <cudaGetLastError@plt>
   fcc1b:	mov    %eax,%edi
   fcc1d:	lea    0xfd7ac(%rip),%rsi        # 1fa3d0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x54d0>
   fcc24:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fcc29:	mov    0x3070(%rbx),%r12
   fcc30:	mov    -0xb4c(%rbp),%r13d
   fcc37:	test   %r13d,%r13d
   fcc3a:	je     fccff <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1b9f>
   fcc40:	mov    0x568(%rbx),%r13d
   fcc47:	imul   -0xa80(%rbp),%r13
   fcc4f:	movl   $0x1,-0x8a0(%rbp)
   fcc59:	mov    -0xaf0(%rbp),%rax
   fcc60:	mov    0x100329(%rip),%rcx        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fcc67:	mov    %r13,%rdi
   fcc6a:	mov    %rax,-0xb58(%rbp)
   fcc71:	mov    %rcx,-0x8a8(%rbp)
   fcc78:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fcc7d:	mov    %r15,-0x898(%rbp)
   fcc84:	mov    -0x8a0(%rbp),%ecx
   fcc8a:	xor    %r8d,%r8d
   fcc8d:	mov    %eax,-0x89c(%rbp)
   fcc93:	mov    -0xb58(%rbp),%r9
   fcc9a:	mov    -0x8a8(%rbp),%rdx
   fcca1:	mov    -0x89c(%rbp),%rdi
   fcca8:	mov    -0x894(%rbp),%esi
   fccae:	call   6f040 <__cudaPushCallConfiguration@plt>
   fccb3:	test   %eax,%eax
   fccb5:	je     ffff0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4e90>
   fccbb:	call   6c900 <cudaGetLastError@plt>
   fccc0:	mov    %eax,%edi
   fccc2:	lea    0xfd73f(%rip),%rsi        # 1fa408 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5508>
   fccc9:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fccce:	cmpl   $0x1,-0xb1c(%rbp)
   fccd5:	jne    fccf8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1b98>
   fccd7:	mov    -0xa68(%rbp),%rdi
   fccde:	test   %rdi,%rdi
   fcce1:	je     fccf8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1b98>
   fcce3:	movss  0xc(%rbx),%xmm0
   fcce8:	pxor   %xmm7,%xmm7
   fccec:	comiss %xmm7,%xmm0
   fccef:	ja     101070 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5f10>
   fccf5:	nopl   (%rax)
   fccf8:	mov    0x3070(%rbx),%r12
   fccff:	cmpb   $0x0,-0xad3(%rbp)
   fcd06:	je     fcda1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1c41>
   fcd0c:	mov    0x5d4(%rbx),%r13d
   fcd13:	imul   -0xa80(%rbp),%r13
   fcd1b:	movl   $0x1,-0x8a0(%rbp)
   fcd25:	mov    -0xaf0(%rbp),%rax
   fcd2c:	mov    0x10025d(%rip),%rcx        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fcd33:	mov    %r13,%rdi
   fcd36:	mov    %rax,-0xb58(%rbp)
   fcd3d:	mov    %rcx,-0x8a8(%rbp)
   fcd44:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fcd49:	mov    %r15,-0x898(%rbp)
   fcd50:	mov    -0x8a0(%rbp),%ecx
   fcd56:	xor    %r8d,%r8d
   fcd59:	mov    %eax,-0x89c(%rbp)
   fcd5f:	mov    -0xb58(%rbp),%r9
   fcd66:	mov    -0x8a8(%rbp),%rdx
   fcd6d:	mov    -0x89c(%rbp),%rdi
   fcd74:	mov    -0x894(%rbp),%esi
   fcd7a:	call   6f040 <__cudaPushCallConfiguration@plt>
   fcd7f:	test   %eax,%eax
   fcd81:	je     100100 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4fa0>
   fcd87:	call   6c900 <cudaGetLastError@plt>
   fcd8c:	mov    %eax,%edi
   fcd8e:	lea    0xfd6db(%rip),%rsi        # 1fa470 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5570>
   fcd95:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fcd9a:	mov    0x3070(%rbx),%r12
   fcda1:	mov    -0x850(%rbp),%rax
   fcda8:	cmpb   $0x0,0x32c8(%rax)
   fcdaf:	je     fce3b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1cdb>
   fcdb5:	mov    -0x840(%rbp),%rax
   fcdbc:	mov    (%rax),%r13
   fcdbf:	mov    0x1001ca(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fcdc6:	movl   $0x1,-0x8a0(%rbp)
   fcdd0:	mov    %rax,-0x8a8(%rbp)
   fcdd7:	mov    -0x848(%rbp),%rax
   fcdde:	mov    0x68(%rax),%rdi
   fcde2:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fcde7:	mov    %r15,-0x898(%rbp)
   fcdee:	mov    -0x8a0(%rbp),%ecx
   fcdf4:	mov    %r13,%r9
   fcdf7:	xor    %r8d,%r8d
   fcdfa:	mov    %eax,-0x89c(%rbp)
   fce00:	mov    -0x8a8(%rbp),%rdx
   fce07:	mov    -0x89c(%rbp),%rdi
   fce0e:	mov    -0x894(%rbp),%esi
   fce14:	call   6f040 <__cudaPushCallConfiguration@plt>
   fce19:	test   %eax,%eax
   fce1b:	je     1001e8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5088>
   fce21:	call   6c900 <cudaGetLastError@plt>
   fce26:	mov    %eax,%edi
   fce28:	lea    0xfd669(%rip),%rsi        # 1fa498 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5598>
   fce2f:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fce34:	mov    0x3070(%rbx),%r12
   fce3b:	mov    -0x7f0(%rbp),%rax
   fce42:	cmpb   $0x0,(%rax)
   fce45:	je     fced0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1d70>
   fce4b:	mov    -0x7e0(%rbp),%rax
   fce52:	mov    (%rax),%r13
   fce55:	mov    0x100134(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fce5c:	movl   $0x1,-0x8a0(%rbp)
   fce66:	mov    %rax,-0x8a8(%rbp)
   fce6d:	mov    -0x7e8(%rbp),%rax
   fce74:	mov    (%rax),%rdi
   fce77:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fce7c:	mov    %r15,-0x898(%rbp)
   fce83:	mov    -0x8a0(%rbp),%ecx
   fce89:	mov    %r13,%r9
   fce8c:	xor    %r8d,%r8d
   fce8f:	mov    %eax,-0x89c(%rbp)
   fce95:	mov    -0x8a8(%rbp),%rdx
   fce9c:	mov    -0x89c(%rbp),%rdi
   fcea3:	mov    -0x894(%rbp),%esi
   fcea9:	call   6f040 <__cudaPushCallConfiguration@plt>
   fceae:	test   %eax,%eax
   fceb0:	je     100270 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5110>
   fceb6:	call   6c900 <cudaGetLastError@plt>
   fcebb:	mov    %eax,%edi
   fcebd:	lea    0xfd5f4(%rip),%rsi        # 1fa4b8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x55b8>
   fcec4:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fcec9:	mov    0x3070(%rbx),%r12
   fced0:	mov    -0x820(%rbp),%rax
   fced7:	cmpb   $0x0,(%rax)
   fceda:	je     fcfa0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1e40>
   fcee0:	mov    -0x818(%rbp),%rax
   fcee7:	cmpq   $0x0,0x6d8(%rax)
   fceef:	je     fcfa0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1e40>
   fcef5:	movq   0x6f0(%rax),%xmm0
   fcefd:	movq   0x6d0(%rax),%xmm1
   fcf05:	movl   $0x1,-0x910(%rbp)
   fcf0f:	movhps 0x700(%rax),%xmm0
   fcf16:	movhps 0x6e0(%rax),%xmm1
   fcf1d:	mov    -0x808(%rbp),%rax
   fcf24:	movaps %xmm1,-0x890(%rbp)
   fcf2b:	mov    (%rax),%r13
   fcf2e:	mov    0x10005b(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fcf35:	movaps %xmm0,-0x880(%rbp)
   fcf3c:	mov    %rax,-0x918(%rbp)
   fcf43:	mov    -0x810(%rbp),%rax
   fcf4a:	mov    0x68(%rax),%rdi
   fcf4e:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fcf53:	mov    %r15,-0x8d4(%rbp)
   fcf5a:	mov    -0x910(%rbp),%ecx
   fcf60:	mov    %r13,%r9
   fcf63:	xor    %r8d,%r8d
   fcf66:	mov    %eax,-0x8d8(%rbp)
   fcf6c:	mov    -0x918(%rbp),%rdx
   fcf73:	mov    -0x8d8(%rbp),%rdi
   fcf7a:	mov    -0x8d0(%rbp),%esi
   fcf80:	call   6f040 <__cudaPushCallConfiguration@plt>
   fcf85:	test   %eax,%eax
   fcf87:	je     100730 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x55d0>
   fcf8d:	call   6c900 <cudaGetLastError@plt>
   fcf92:	mov    %eax,%edi
   fcf94:	lea    0xfd545(%rip),%rsi        # 1fa4e0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x55e0>
   fcf9b:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fcfa0:	cmpb   $0x0,-0xad1(%rbp)
   fcfa7:	mov    -0xaf0(%rbp),%r12
   fcfae:	jne    fede0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3c80>
   fcfb4:	mov    0x398(%rbx),%r11d
   fcfbb:	test   %r11d,%r11d
   fcfbe:	je     fcffe <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1e9e>
   fcfc0:	movss  0xc(%rbx),%xmm0
   fcfc5:	pxor   %xmm4,%xmm4
   fcfc9:	comiss %xmm4,%xmm0
   fcfcc:	seta   %al
   fcfcf:	cmpl   $0x2,-0xb30(%rbp)
   fcfd6:	jne    fcfe0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1e80>
   fcfd8:	test   %al,%al
   fcfda:	jne    100ef0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5d90>
   fcfe0:	cmpl   $0x3,-0xb30(%rbp)
   fcfe7:	jne    fcff1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1e91>
   fcfe9:	test   %al,%al
   fcfeb:	jne    100f70 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5e10>
   fcff1:	pxor   %xmm4,%xmm4
   fcff5:	comiss %xmm4,%xmm0
   fcff8:	ja     ffe30 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4cd0>
   fcffe:	mov    0x240(%rbx),%r13d
   fd005:	test   %r13d,%r13d
   fd008:	jne    feca0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3b40>
   fd00e:	mov    0x278(%rbx),%r13d
   fd015:	test   %r13d,%r13d
   fd018:	jne    febd0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3a70>
   fd01e:	cmpb   $0x0,-0xad2(%rbp)
   fd025:	jne    fead0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3970>
   fd02b:	mov    0x318(%rbx),%edx
   fd031:	test   %edx,%edx
   fd033:	jne    fe9f8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3898>
   fd039:	cmpb   $0x0,-0xb40(%rbp)
   fd040:	je     fe680 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3520>
   fd046:	xor    %r13d,%r13d
   fd049:	cmpb   $0x0,-0xb10(%rbp)
   fd050:	jne    fd059 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ef9>
   fd052:	mov    0x2f90(%rbx),%r13
   fd059:	mov    0xfff30(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fd060:	mov    %r15,-0x898(%rbp)
   fd067:	mov    %r12,%r9
   fd06a:	xor    %r8d,%r8d
   fd06d:	mov    0xfff1c(%rip),%rdx        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fd074:	mov    -0x894(%rbp),%esi
   fd07a:	mov    $0x1,%ecx
   fd07f:	movl   $0x1,-0x8a0(%rbp)
   fd089:	mov    %rax,-0x8a8(%rbp)
   fd090:	mov    -0xae8(%rbp),%eax
   fd096:	mov    %eax,-0x89c(%rbp)
   fd09c:	mov    -0x89c(%rbp),%rdi
   fd0a3:	call   6f040 <__cudaPushCallConfiguration@plt>
   fd0a8:	test   %eax,%eax
   fd0aa:	jne    fd0c9 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1f69>
   fd0ac:	mov    0x2f70(%rbx),%rsi
   fd0b3:	mov    0x2f10(%rbx),%rdi
   fd0ba:	mov    %r13,%rdx
   fd0bd:	mov    -0xaa0(%rbp),%rcx
   fd0c4:	call   6ae00 <synreal::kernel::initialize_block_diagonal(float const*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long)@plt>
   fd0c9:	call   6c900 <cudaGetLastError@plt>
   fd0ce:	mov    %eax,%edi
   fd0d0:	lea    0xfd571(%rip),%rsi        # 1fa648 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5748>
   fd0d7:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fd0dc:	cmpb   $0x0,-0xb10(%rbp)
   fd0e3:	je     fd424 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x22c4>
   fd0e9:	mov    -0xaf0(%rbp),%r12
   fd0f0:	mov    0x2e10(%rbx),%rax
   fd0f7:	cmpb   $0x0,-0xbb0(%rbp)
   fd0fe:	mov    %rax,-0xb70(%rbp)
   fd105:	jne    fff00 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4da0>
   fd10b:	mov    0x2f70(%rbx),%rax
   fd112:	mov    %rax,-0xb58(%rbp)
   fd119:	mov    0x2bb8(%rbx),%rax
   fd120:	mov    %rax,-0xb90(%rbp)
   fd127:	mov    0x2bd8(%rbx),%rax
   fd12e:	mov    %rax,-0xb60(%rbp)
   fd135:	mov    -0xb74(%rbp),%eax
   fd13b:	test   %eax,%eax
   fd13d:	jne    ff048 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3ee8>
   fd143:	mov    0x278(%rbx),%r13d
   fd14a:	test   %r13d,%r13d
   fd14d:	jne    1007d0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5670>
   fd153:	mov    0x240(%rbx),%r13d
   fd15a:	test   %r13d,%r13d
   fd15d:	jne    1008b9 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5759>
   fd163:	mov    0x398(%rbx),%eax
   fd169:	test   %eax,%eax
   fd16b:	je     fd17a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x201a>
   fd16d:	cmpl   $0x2,-0xb30(%rbp)
   fd174:	je     101100 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5fa0>
   fd17a:	cmpb   $0x0,-0xbc8(%rbp)
   fd181:	je     fd28c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x212c>
   fd187:	mov    -0xbc0(%rbp),%r13
   fd18e:	imul   -0xa80(%rbp),%r13
   fd196:	movl   $0x1,-0x8a0(%rbp)
   fd1a0:	mov    0xffde9(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fd1a7:	mov    %r13,%rdi
   fd1aa:	mov    %rax,-0x8a8(%rbp)
   fd1b1:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fd1b6:	mov    %r15,-0x898(%rbp)
   fd1bd:	mov    -0x8a0(%rbp),%ecx
   fd1c3:	mov    %r12,%r9
   fd1c6:	xor    %r8d,%r8d
   fd1c9:	mov    %eax,-0x89c(%rbp)
   fd1cf:	mov    -0x8a8(%rbp),%rdx
   fd1d6:	mov    -0x89c(%rbp),%rdi
   fd1dd:	mov    -0x894(%rbp),%esi
   fd1e3:	call   6f040 <__cudaPushCallConfiguration@plt>
   fd1e8:	test   %eax,%eax
   fd1ea:	jne    fd264 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2104>
   fd1ec:	sub    $0x8,%rsp
   fd1f0:	mov    -0xaf8(%rbp),%rax
   fd1f7:	mov    0x4b0(%rbx),%rcx
   fd1fe:	mov    0x4a0(%rbx),%rdx
   fd205:	mov    0x3d0(%rbx),%rsi
   fd20c:	push   -0xaa0(%rbp)
   fd212:	mov    0x4c0(%rbx),%r8
   fd219:	push   -0xaa8(%rbp)
   fd21f:	mov    (%rax),%rdi
   fd222:	push   -0xbc0(%rbp)
   fd228:	push   %r13
   fd22a:	push   -0xb60(%rbp)
   fd230:	push   -0xb70(%rbp)
   fd236:	push   -0xb90(%rbp)
   fd23c:	push   -0xb58(%rbp)
   fd242:	push   0x4e0(%rbx)
   fd248:	push   0x4d0(%rbx)
   fd24e:	push   0x3420(%rbx)
   fd254:	mov    0x3400(%rbx),%r9
   fd25b:	call   6ae30 <synreal::kernel::add_body_spring_gauss_newton_hessian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
   fd260:	add    $0x60,%rsp
   fd264:	call   6c900 <cudaGetLastError@plt>
   fd269:	mov    %eax,%edi
   fd26b:	lea    0xfd4b6(%rip),%rsi        # 1fa728 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5828>
   fd272:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fd277:	mov    -0xb74(%rbp),%eax
   fd27d:	mov    -0xaf0(%rbp),%r12
   fd284:	test   %eax,%eax
   fd286:	jne    fd3d8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2278>
   fd28c:	mov    -0xb4c(%rbp),%eax
   fd292:	test   %eax,%eax
   fd294:	je     fd2d0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2170>
   fd296:	cmpl   $0x1,-0xb1c(%rbp)
   fd29d:	mov    0x568(%rbx),%eax
   fd2a3:	mov    -0xa80(%rbp),%r13
   fd2aa:	jne    100c50 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5af0>
   fd2b0:	mov    %eax,%edx
   fd2b2:	sub    0x56c(%rbx),%edx
   fd2b8:	imul   %rdx,%r13
   fd2bc:	mov    %rdx,-0xbe0(%rbp)
   fd2c3:	test   %r13,%r13
   fd2c6:	jne    1019f0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6890>
   fd2cc:	nopl   0x0(%rax)
   fd2d0:	cmpb   $0x0,-0xbd0(%rbp)
   fd2d7:	je     fd3d8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2278>
   fd2dd:	mov    0xffcac(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fd2e4:	mov    -0xa68(%rbp),%rdi
   fd2eb:	movl   $0x1,-0x8a0(%rbp)
   fd2f5:	mov    %rax,-0x8a8(%rbp)
   fd2fc:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fd301:	mov    %r15,-0x898(%rbp)
   fd308:	mov    -0x8a0(%rbp),%ecx
   fd30e:	mov    %r12,%r9
   fd311:	xor    %r8d,%r8d
   fd314:	mov    %eax,-0x89c(%rbp)
   fd31a:	mov    -0x8a8(%rbp),%rdx
   fd321:	mov    -0x89c(%rbp),%rdi
   fd328:	mov    -0x894(%rbp),%esi
   fd32e:	call   6f040 <__cudaPushCallConfiguration@plt>
   fd333:	test   %eax,%eax
   fd335:	jne    fd3be <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x225e>
   fd33b:	mov    0x56c(%rbx),%eax
   fd341:	sub    $0x8,%rsp
   fd345:	mov    0x3500(%rbx),%rcx
   fd34c:	mov    0x34e0(%rbx),%rdx
   fd353:	mov    0x570(%rbx),%rsi
   fd35a:	mov    0x3d0(%rbx),%rdi
   fd361:	push   -0xaa0(%rbp)
   fd367:	movss  -0xac4(%rbp),%xmm0
   fd36f:	push   -0xaa8(%rbp)
   fd375:	mov    0x3520(%rbx),%r8
   fd37c:	push   %rax
   fd37d:	mov    0x568(%rbx),%eax
   fd383:	push   %rax
   fd384:	push   -0xa68(%rbp)
   fd38a:	push   -0xb60(%rbp)
   fd390:	push   -0xb70(%rbp)
   fd396:	push   -0xb90(%rbp)
   fd39c:	push   -0xb58(%rbp)
   fd3a2:	push   0x3560(%rbx)
   fd3a8:	push   0x3540(%rbx)
   fd3ae:	mov    0x5b0(%rbx),%r9
   fd3b5:	call   6ab50 <synreal::kernel::add_joint_body_point_line_gauss_newton_hessian(glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
   fd3ba:	add    $0x60,%rsp
   fd3be:	call   6c900 <cudaGetLastError@plt>
   fd3c3:	mov    %eax,%edi
   fd3c5:	lea    0xfd3bc(%rip),%rsi        # 1fa788 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5888>
   fd3cc:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fd3d1:	mov    -0xaf0(%rbp),%r12
   fd3d8:	mov    -0xaa0(%rbp),%rax
   fd3df:	mov    0x2f90(%rbx),%rdi
   fd3e6:	mov    %r12,%r8
   fd3e9:	mov    $0x3,%ecx
   fd3ee:	mov    -0xb58(%rbp),%rsi
   fd3f5:	lea    (%rax,%rax,8),%rdx
   fd3f9:	shl    $0x2,%rdx
   fd3fd:	call   6e130 <cudaMemcpyAsync@plt>
   fd402:	mov    %eax,%edi
   fd404:	lea    0xfd3b5(%rip),%rsi        # 1fa7c0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x58c0>
   fd40b:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fd410:	cmpb   $0x0,-0xb40(%rbp)
   fd417:	mov    -0xaf0(%rbp),%r12
   fd41e:	je     fe68d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x352d>
   fd424:	cmpb   $0x0,-0xb38(%rbp)
   fd42b:	je     fe638 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34d8>
   fd431:	cmpb   $0x0,-0xad8(%rbp)
   fd438:	je     fe638 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34d8>
   fd43e:	cmpb   $0x0,0x1d(%rbx)
   fd442:	je     fe638 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34d8>
   fd448:	cmpb   $0x0,0x41(%rbx)
   fd44c:	je     1011d0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6070>
   fd452:	mov    0x2fb0(%rbx),%rdi
   fd459:	mov    %rdi,-0xb58(%rbp)
   fd460:	test   %rdi,%rdi
   fd463:	je     10056b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x540b>
   fd469:	mov    -0xa78(%rbp),%rax
   fd470:	mov    -0xaf0(%rbp),%rcx
   fd477:	xor    %esi,%esi
   fd479:	lea    (%rax,%rax,8),%rdx
   fd47d:	shl    $0x6,%rdx
   fd481:	call   6e9d0 <cudaMemsetAsync@plt>
   fd486:	mov    %eax,%edi
   fd488:	lea    0xfd369(%rip),%rsi        # 1fa7f8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x58f8>
   fd48f:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fd494:	cmpb   $0x0,-0xad9(%rbp)
   fd49b:	je     fd4a7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2347>
   fd49d:	cmpb   $0x0,0x41(%rbx)
   fd4a1:	jne    100580 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5420>
   fd4a7:	cmpb   $0x0,-0xad6(%rbp)
   fd4ae:	je     fd6b8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2558>
   fd4b4:	mov    -0xb74(%rbp),%r13d
   fd4bb:	test   %r13d,%r13d
   fd4be:	je     fd4ca <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x236a>
   fd4c0:	cmpb   $0x0,0x41(%rbx)
   fd4c4:	je     fd6b8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2558>
   fd4ca:	mov    0x2f90(%rbx),%rax
   fd4d1:	movss  -0xae4(%rbp),%xmm7
   fd4d9:	cmpb   $0x0,-0xad5(%rbp)
   fd4e0:	mov    0x2f70(%rbx),%r13
   fd4e7:	mov    %rax,-0xb90(%rbp)
   fd4ee:	mov    0x3090(%rbx),%rax
   fd4f5:	movss  %xmm7,-0xb70(%rbp)
   fd4fd:	mov    %rax,-0xb60(%rbp)
   fd504:	je     fd514 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x23b4>
   fd506:	cmpq   $0x0,0x150(%r14)
   fd50e:	je     fd6b8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2558>
   fd514:	mov    0xffa75(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fd51b:	mov    0xd0(%r14),%edi
   fd522:	movl   $0x1,-0x8a0(%rbp)
   fd52c:	mov    -0xaf0(%rbp),%r12
   fd533:	mov    %rax,-0x8a8(%rbp)
   fd53a:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fd53f:	mov    %r15,-0x898(%rbp)
   fd546:	mov    -0x8a0(%rbp),%ecx
   fd54c:	mov    %r12,%r9
   fd54f:	xor    %r8d,%r8d
   fd552:	mov    %eax,-0x89c(%rbp)
   fd558:	mov    -0x8a8(%rbp),%rdx
   fd55f:	mov    -0x89c(%rbp),%rdi
   fd566:	mov    -0x894(%rbp),%esi
   fd56c:	call   6f040 <__cudaPushCallConfiguration@plt>
   fd571:	test   %eax,%eax
   fd573:	jne    fd6a2 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2542>
   fd579:	xor    %eax,%eax
   fd57b:	cmpb   $0x0,-0xad5(%rbp)
   fd582:	mov    0x150(%r14),%r8
   fd589:	jne    101d60 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6c00>
   fd58f:	sub    $0x8,%rsp
   fd593:	movss  0x7c8(%rbx),%xmm0
   fd59b:	push   -0xb90(%rbp)
   fd5a1:	mov    0xe8(%r14),%rcx
   fd5a8:	push   %r13
   fd5aa:	mov    0xd8(%r14),%rdx
   fd5b1:	mov    0xd0(%r14),%esi
   fd5b8:	push   %r8
   fd5ba:	push   %rax
   fd5bb:	mov    -0xaf8(%rbp),%rax
   fd5c2:	push   $0x0
   fd5c4:	mov    0xc0(%r14),%rdi
   fd5cb:	push   $0x0
   fd5cd:	push   -0xb60(%rbp)
   fd5d3:	push   0x10(%rax)
   fd5d6:	push   (%rax)
   fd5d8:	mov    0x398(%rbx),%eax
   fd5de:	push   %rax
   fd5df:	mov    -0xac8(%rbp),%eax
   fd5e5:	push   0x3e0(%rbx)
   fd5eb:	push   0x3d0(%rbx)
   fd5f1:	push   0x3f0(%rbx)
   fd5f7:	push   -0xa80(%rbp)
   fd5fd:	push   %rax
   fd5fe:	mov    0x710(%rbx),%eax
   fd604:	push   %rax
   fd605:	movss  0xff973(%rip),%xmm4        # 1fcf80 <cuda::std::__4::in_place+0x33>
   fd60d:	divss  -0xb70(%rbp),%xmm4
   fd615:	push   0x788(%rbx)
   fd61b:	push   0x778(%rbx)
   fd621:	push   0x768(%rbx)
   fd627:	push   0x758(%rbx)
   fd62d:	push   0x7b8(%rbx)
   fd633:	push   0x748(%rbx)
   fd639:	push   0x738(%rbx)
   fd63f:	push   0x728(%rbx)
   fd645:	push   0x718(%rbx)
   fd64b:	push   -0xaa0(%rbp)
   fd651:	push   -0xaa8(%rbp)
   fd657:	push   0x33e0(%rbx)
   fd65d:	push   0xc0(%rbx)
   fd663:	push   0x118(%rbx)
   fd669:	push   0x118(%r14)
   fd670:	movss  0x7d4(%rbx),%xmm3
   fd678:	movss  0x7d0(%rbx),%xmm2
   fd680:	movss  0x7cc(%rbx),%xmm1
   fd688:	mov    0x108(%r14),%r9
   fd68f:	mov    0xf8(%r14),%r8
   fd696:	call   6aac0 <synreal::kernel::evaluate_soft_contact_force(int const*, unsigned long, int const*, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, int const*, unsigned long, unsigned long, int const*, int const*, synreal::Transform const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float const*, float const*, float const*, unsigned long, unsigned long, unsigned long, float, float, float, float, int const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, unsigned long, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, float*, int const*, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
   fd69b:	add    $0x100,%rsp
   fd6a2:	call   6c900 <cudaGetLastError@plt>
   fd6a7:	mov    %eax,%edi
   fd6a9:	lea    0xfcc18(%rip),%rsi        # 1fa2c8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x53c8>
   fd6b0:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fd6b5:	nopl   (%rax)
   fd6b8:	cmpb   $0x0,-0xad0(%rbp)
   fd6bf:	jne    ffd60 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4c00>
   fd6c5:	cmpb   $0x1,-0xacf(%rbp)
   fd6cc:	jne    fd6db <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x257b>
   fd6ce:	cmpb   $0x0,-0xb38(%rbp)
   fd6d5:	je     1004a8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5348>
   fd6db:	cmpb   $0x0,-0xad2(%rbp)
   fd6e2:	jne    ffc80 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4b20>
   fd6e8:	cmpb   $0x0,0x3370(%rbx)
   fd6ef:	jne    ffba0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4a40>
   fd6f5:	cmpb   $0x0,-0xad1(%rbp)
   fd6fc:	jne    ffb80 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4a20>
   fd702:	mov    0x1818(%rbx),%r8d
   fd709:	test   %r8d,%r8d
   fd70c:	jne    ffb58 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x49f8>
   fd712:	mov    0x21b0(%rbx),%edi
   fd718:	test   %edi,%edi
   fd71a:	jne    ff7c0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4660>
   fd720:	cmpb   $0x0,-0xad5(%rbp)
   fd727:	jne    ff7e7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4687>
   fd72d:	cmpb   $0x0,-0xada(%rbp)
   fd734:	jne    ff88d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x472d>
   fd73a:	cmpb   $0x0,-0xace(%rbp)
   fd741:	jne    ff949 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x47e9>
   fd747:	cmpb   $0x0,-0xacd(%rbp)
   fd74e:	jne    ffa35 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x48d5>
   fd754:	mov    -0x850(%rbp),%rax
   fd75b:	mov    0x2f90(%rbx),%r12
   fd762:	cmpb   $0x0,0x32c8(%rax)
   fd769:	je     fd7f5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2695>
   fd76f:	mov    -0x840(%rbp),%rax
   fd776:	mov    (%rax),%r13
   fd779:	mov    0xff810(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fd780:	movl   $0x1,-0x8a0(%rbp)
   fd78a:	mov    %rax,-0x8a8(%rbp)
   fd791:	mov    -0x848(%rbp),%rax
   fd798:	mov    0x68(%rax),%rdi
   fd79c:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fd7a1:	mov    %r15,-0x898(%rbp)
   fd7a8:	mov    -0x8a0(%rbp),%ecx
   fd7ae:	mov    %r13,%r9
   fd7b1:	xor    %r8d,%r8d
   fd7b4:	mov    %eax,-0x89c(%rbp)
   fd7ba:	mov    -0x8a8(%rbp),%rdx
   fd7c1:	mov    -0x89c(%rbp),%rdi
   fd7c8:	mov    -0x894(%rbp),%esi
   fd7ce:	call   6f040 <__cudaPushCallConfiguration@plt>
   fd7d3:	test   %eax,%eax
   fd7d5:	je     100630 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x54d0>
   fd7db:	call   6c900 <cudaGetLastError@plt>
   fd7e0:	mov    %eax,%edi
   fd7e2:	lea    0xfccaf(%rip),%rsi        # 1fa498 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5598>
   fd7e9:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fd7ee:	mov    0x2f90(%rbx),%r12
   fd7f5:	cmpb   $0x0,-0xb38(%rbp)
   fd7fc:	jne    fd897 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2737>
   fd802:	mov    -0x7f0(%rbp),%rax
   fd809:	cmpb   $0x0,(%rax)
   fd80c:	je     fd897 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2737>
   fd812:	mov    -0x7e0(%rbp),%rax
   fd819:	mov    (%rax),%r13
   fd81c:	mov    0xff76d(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fd823:	movl   $0x1,-0x8a0(%rbp)
   fd82d:	mov    %rax,-0x8a8(%rbp)
   fd834:	mov    -0x7e8(%rbp),%rax
   fd83b:	mov    (%rax),%rdi
   fd83e:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fd843:	mov    %r15,-0x898(%rbp)
   fd84a:	mov    -0x8a0(%rbp),%ecx
   fd850:	mov    %r13,%r9
   fd853:	xor    %r8d,%r8d
   fd856:	mov    %eax,-0x89c(%rbp)
   fd85c:	mov    -0x8a8(%rbp),%rdx
   fd863:	mov    -0x89c(%rbp),%rdi
   fd86a:	mov    -0x894(%rbp),%esi
   fd870:	call   6f040 <__cudaPushCallConfiguration@plt>
   fd875:	test   %eax,%eax
   fd877:	je     100a98 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5938>
   fd87d:	call   6c900 <cudaGetLastError@plt>
   fd882:	mov    %eax,%edi
   fd884:	lea    0xfcc2d(%rip),%rsi        # 1fa4b8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x55b8>
   fd88b:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fd890:	mov    0x2f90(%rbx),%r12
   fd897:	mov    -0x820(%rbp),%rax
   fd89e:	cmpb   $0x0,(%rax)
   fd8a1:	je     fd967 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2807>
   fd8a7:	mov    -0x818(%rbp),%rax
   fd8ae:	cmpq   $0x0,0x6d8(%rax)
   fd8b6:	je     fd967 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2807>
   fd8bc:	movq   0x6f0(%rax),%xmm0
   fd8c4:	movq   0x6d0(%rax),%xmm1
   fd8cc:	movl   $0x1,-0x900(%rbp)
   fd8d6:	movhps 0x700(%rax),%xmm0
   fd8dd:	movhps 0x6e0(%rax),%xmm1
   fd8e4:	mov    -0x808(%rbp),%rax
   fd8eb:	movaps %xmm1,-0x870(%rbp)
   fd8f2:	mov    (%rax),%r13
   fd8f5:	mov    0xff694(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fd8fc:	movaps %xmm0,-0x860(%rbp)
   fd903:	mov    %rax,-0x908(%rbp)
   fd90a:	mov    -0x810(%rbp),%rax
   fd911:	mov    0x68(%rax),%rdi
   fd915:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fd91a:	mov    %r15,-0x8c8(%rbp)
   fd921:	mov    -0x900(%rbp),%ecx
   fd927:	mov    %r13,%r9
   fd92a:	xor    %r8d,%r8d
   fd92d:	mov    %eax,-0x8cc(%rbp)
   fd933:	mov    -0x908(%rbp),%rdx
   fd93a:	mov    -0x8cc(%rbp),%rdi
   fd941:	mov    -0x8c4(%rbp),%esi
   fd947:	call   6f040 <__cudaPushCallConfiguration@plt>
   fd94c:	test   %eax,%eax
   fd94e:	je     100b30 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x59d0>
   fd954:	call   6c900 <cudaGetLastError@plt>
   fd959:	mov    %eax,%edi
   fd95b:	lea    0xfcb7e(%rip),%rsi        # 1fa4e0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x55e0>
   fd962:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fd967:	cmpb   $0x0,-0xad7(%rbp)
   fd96e:	mov    -0xaf0(%rbp),%r12
   fd975:	jne    ff670 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4510>
   fd97b:	cmpb   $0x0,-0xb38(%rbp)
   fd982:	je     fdf24 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2dc4>
   fd988:	mov    0xff601(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fd98f:	cmpb   $0x0,-0xb10(%rbp)
   fd996:	movl   $0x1,-0x8f0(%rbp)
   fd9a0:	mov    -0xa78(%rbp),%rdi
   fd9a7:	mov    %rax,-0x8f8(%rbp)
   fd9ae:	je     ff168 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4008>
   fd9b4:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fd9b9:	mov    %r15,-0x898(%rbp)
   fd9c0:	mov    -0x8f0(%rbp),%ecx
   fd9c6:	mov    %r12,%r9
   fd9c9:	xor    %r8d,%r8d
   fd9cc:	mov    %eax,-0x89c(%rbp)
   fd9d2:	mov    -0x8f8(%rbp),%rdx
   fd9d9:	mov    -0x89c(%rbp),%rdi
   fd9e0:	mov    -0x894(%rbp),%esi
   fd9e6:	call   6f040 <__cudaPushCallConfiguration@plt>
   fd9eb:	mov    %eax,%r8d
   fd9ee:	lea    -0xa58(%rbp),%rax
   fd9f5:	lea    -0x9f0(%rbp),%rdx
   fd9fc:	movq   %rax,%xmm9
   fda01:	lea    -0xa50(%rbp),%rax
   fda08:	movq   %rdx,%xmm10
   fda0d:	movq   %rax,%xmm7
   fda12:	lea    -0xa48(%rbp),%rax
   fda19:	lea    -0x9e0(%rbp),%rdx
   fda20:	movq   %rax,%xmm8
   fda25:	lea    -0xa40(%rbp),%rax
   fda2c:	punpcklqdq %xmm7,%xmm9
   fda31:	movq   %rax,%xmm5
   fda36:	lea    -0xa38(%rbp),%rax
   fda3d:	movq   %rax,%xmm7
   fda42:	lea    -0xa30(%rbp),%rax
   fda49:	punpcklqdq %xmm5,%xmm8
   fda4e:	movq   %rax,%xmm6
   fda53:	lea    -0xa28(%rbp),%rax
   fda5a:	punpcklqdq %xmm6,%xmm7
   fda5e:	movq   %rax,%xmm6
   fda63:	lea    -0xa20(%rbp),%rax
   fda6a:	movq   %rax,%xmm5
   fda6f:	lea    -0xa18(%rbp),%rax
   fda76:	punpcklqdq %xmm5,%xmm6
   fda7a:	movq   %rax,%xmm5
   fda7f:	lea    -0xa10(%rbp),%rax
   fda86:	movq   %rax,%xmm4
   fda8b:	lea    -0xab8(%rbp),%rax
   fda92:	punpcklqdq %xmm4,%xmm5
   fda96:	movq   %rax,%xmm4
   fda9b:	lea    -0x640(%rbp),%rax
   fdaa2:	movq   %rax,%xmm3
   fdaa7:	lea    -0xa08(%rbp),%rax
   fdaae:	punpcklqdq %xmm3,%xmm4
   fdab2:	movq   %rax,%xmm3
   fdab7:	lea    -0xa00(%rbp),%rax
   fdabe:	movq   %rax,%xmm2
   fdac3:	lea    -0xab4(%rbp),%rax
   fdaca:	punpcklqdq %xmm2,%xmm3
   fdace:	movq   %rax,%xmm2
   fdad3:	lea    -0x9f8(%rbp),%rax
   fdada:	movq   %rax,%xmm1
   fdadf:	lea    -0x9e8(%rbp),%rax
   fdae6:	punpcklqdq %xmm1,%xmm2
   fdaea:	movq   %rax,%xmm1
   fdaef:	lea    -0x9d8(%rbp),%rax
   fdaf6:	movq   %rax,%xmm0
   fdafb:	punpcklqdq %xmm1,%xmm10
   fdb00:	lea    -0x9d0(%rbp),%rax
   fdb07:	movq   %rdx,%xmm1
   fdb0c:	lea    -0x9c8(%rbp),%rdx
   fdb13:	punpcklqdq %xmm0,%xmm1
   fdb17:	movq   %rdx,%xmm14
   fdb1c:	movq   %rax,%xmm0
   fdb21:	punpcklqdq %xmm14,%xmm0
   fdb26:	test   %r8d,%r8d
   fdb29:	jne    fde6c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2d0c>
   fdb2f:	mov    -0xaa8(%rbp),%rax
   fdb36:	cmpb   $0x0,-0xacf(%rbp)
   fdb3d:	pxor   %xmm11,%xmm11
   fdb42:	movss  0xff435(%rip),%xmm13        # 1fcf80 <cuda::std::__4::in_place+0x33>
   fdb4b:	movd   0x398(%rbx),%xmm12
   fdb54:	divss  -0xae4(%rbp),%xmm13
   fdb5d:	mov    %rax,-0xb70(%rbp)
   fdb64:	mov    -0xa78(%rbp),%rax
   fdb6b:	mov    0x2fb0(%rbx),%rsi
   fdb72:	mov    0x2ff0(%rbx),%rdi
   fdb79:	mov    %rax,-0xb60(%rbp)
   fdb80:	mov    0x2fd0(%rbx),%rax
   fdb87:	mov    0x3030(%rbx),%r8
   fdb8e:	mov    0x3010(%rbx),%r9
   fdb95:	mov    %rax,-0xb90(%rbp)
   fdb9c:	je     fdbad <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2a4d>
   fdb9e:	movss  0xc(%rbx),%xmm11
   fdba4:	mulss  -0xacc(%rbp),%xmm11
   fdbad:	mov    0x2be0(%rbx),%rax
   fdbb4:	mov    0x2f90(%rbx),%rdx
   fdbbb:	mov    0x3380(%rbx),%r10
   fdbc2:	mov    0x2bd8(%rbx),%r11
   fdbc9:	test   %rax,%rax
   fdbcc:	mov    %rdx,-0xbe0(%rbp)
   fdbd3:	cmove  -0xaa0(%rbp),%rax
   fdbdb:	xor    %edx,%edx
   fdbdd:	cmpq   $0x0,0x100(%rbx)
   fdbe5:	mov    0x2bc8(%rbx),%r12
   fdbec:	mov    0x2bb8(%rbx),%r13
   fdbf3:	je     fdbfc <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2a9c>
   fdbf5:	mov    0xf8(%rbx),%rdx
   fdbfc:	movdqa -0x6e0(%rbp),%xmm14
   fdc05:	mov    0x3d0(%rbx),%rcx
   fdc0c:	mov    %rdx,-0xa40(%rbp)
   fdc13:	movdqa -0x6d0(%rbp),%xmm15
   fdc1c:	mov    -0xbe0(%rbp),%rdx
   fdc23:	mov    %r13,-0xa30(%rbp)
   fdc2a:	movaps %xmm14,-0x640(%rbp)
   fdc32:	movdqa -0x6c0(%rbp),%xmm14
   fdc3b:	movaps %xmm15,-0x630(%rbp)
   fdc43:	movdqa -0x6b0(%rbp),%xmm15
   fdc4c:	movaps %xmm14,-0x620(%rbp)
   fdc54:	movdqa -0x6a0(%rbp),%xmm14
   fdc5d:	movaps %xmm15,-0x610(%rbp)
   fdc65:	movdqa -0x690(%rbp),%xmm15
   fdc6e:	mov    %rcx,-0xa58(%rbp)
   fdc75:	mov    0x3a0(%rbx),%rcx
   fdc7c:	movaps %xmm14,-0x600(%rbp)
   fdc84:	movdqa -0x680(%rbp),%xmm14
   fdc8d:	movaps %xmm15,-0x5f0(%rbp)
   fdc95:	movdqa -0x670(%rbp),%xmm15
   fdc9e:	mov    %rcx,-0xa50(%rbp)
   fdca5:	mov    0xc0(%rbx),%rcx
   fdcac:	movaps %xmm14,-0x5e0(%rbp)
   fdcb4:	movdqa -0x660(%rbp),%xmm14
   fdcbd:	movaps %xmm15,-0x5d0(%rbp)
   fdcc5:	movdqa -0x650(%rbp),%xmm15
   fdcce:	mov    %rcx,-0xa48(%rbp)
   fdcd5:	lea    -0x920(%rbp),%rcx
   fdcdc:	mov    %rdx,-0xa38(%rbp)
   fdce3:	lea    -0x928(%rbp),%rdx
   fdcea:	mov    %r12,-0xa28(%rbp)
   fdcf1:	mov    %r11,-0xa20(%rbp)
   fdcf8:	movaps %xmm14,-0x5c0(%rbp)
   fdd00:	movaps %xmm15,-0x5b0(%rbp)
   fdd08:	mov    %rax,-0xa18(%rbp)
   fdd0f:	mov    -0xb58(%rbp),%rax
   fdd16:	mov    %rdi,-0x9f8(%rbp)
   fdd1d:	lea    -0x8e8(%rbp),%rdi
   fdd24:	mov    %rax,-0x9f0(%rbp)
   fdd2b:	mov    -0xb90(%rbp),%rax
   fdd32:	mov    %rsi,-0x9e8(%rbp)
   fdd39:	lea    -0x8a8(%rbp),%rsi
   fdd40:	mov    %rax,-0x9e0(%rbp)
   fdd47:	mov    -0xb60(%rbp),%rax
   fdd4e:	mov    %r10,-0xa10(%rbp)
   fdd55:	mov    %rax,-0x9d8(%rbp)
   fdd5c:	mov    -0xb70(%rbp),%rax
   fdd63:	mov    %r9,-0xa08(%rbp)
   fdd6a:	mov    %rax,-0x9c8(%rbp)
   fdd71:	mov    0xff1f8(%rip),%rax        # 1fcf70 <cuda::std::__4::in_place+0x23>
   fdd78:	mov    %r8,-0xa00(%rbp)
   fdd7f:	mov    %rax,-0x8e8(%rbp)
   fdd86:	movl   $0x1,-0x8e0(%rbp)
   fdd90:	mov    %rax,-0x8a8(%rbp)
   fdd97:	movl   $0x1,-0x8a0(%rbp)
   fdda1:	movss  %xmm11,-0xab8(%rbp)
   fddaa:	movss  %xmm13,-0xab4(%rbp)
   fddb3:	movq   %xmm12,-0x9d0(%rbp)
   fddbc:	movaps %xmm9,-0x170(%rbp)
   fddc4:	movaps %xmm8,-0x160(%rbp)
   fddcc:	movaps %xmm7,-0x150(%rbp)
   fddd3:	movaps %xmm6,-0x140(%rbp)
   fddda:	movaps %xmm5,-0x130(%rbp)
   fdde1:	movaps %xmm4,-0x120(%rbp)
   fdde8:	movaps %xmm3,-0x110(%rbp)
   fddef:	movaps %xmm2,-0x100(%rbp)
   fddf6:	movaps %xmm10,-0xf0(%rbp)
   fddfe:	movaps %xmm1,-0xe0(%rbp)
   fde05:	movaps %xmm0,-0xd0(%rbp)
   fde0c:	call   6ebe0 <__cudaPopCallConfiguration@plt>
   fde11:	test   %eax,%eax
   fde13:	jne    fde6c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2d0c>
   fde15:	push   -0x920(%rbp)
   fde1b:	mov    -0x8e8(%rbp),%rsi
   fde22:	lea    -0x170(%rbp),%r9
   fde29:	mov    -0x8e0(%rbp),%edx
   fde2f:	push   -0x928(%rbp)
   fde35:	mov    -0x8a8(%rbp),%rcx
   fde3c:	mov    %rsi,-0x8b4(%rbp)
   fde43:	mov    -0x8a0(%rbp),%r8d
   fde4a:	mov    0x604d2f(%rip),%rdi        # 702b80 <void synreal::kernel::build_affine_body_preconditioner<synreal::BlockNonZeroEntry>(glm::vec<4, int, (glm::qualifier)0> const*, float const*, float const*, int const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, int const*, synreal::BlockNonZeroEntry const*, unsigned long, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, synreal::kernel::CableView, unsigned long const*, int const*, float, int const*, float const*, float*, int*, unsigned long, unsigned long, unsigned long)@@Base+0x5f36e0>
   fde51:	mov    %edx,-0x8ac(%rbp)
   fde57:	mov    %rcx,-0x8c0(%rbp)
   fde5e:	mov    %r8d,-0x8b8(%rbp)
   fde65:	call   6b560 <cudaLaunchKernel@plt>
   fde6a:	pop    %rax
   fde6b:	pop    %rdx
   fde6c:	call   6c900 <cudaGetLastError@plt>
   fde71:	mov    %eax,%edi
   fde73:	lea    0xfcbc6(%rip),%rsi        # 1faa40 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5b40>
   fde7a:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fde7f:	cmpb   $0x0,-0xacf(%rbp)
   fde86:	jne    100308 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x51a8>
   fde8c:	mov    -0x7f0(%rbp),%rax
   fde93:	mov    0x2f90(%rbx),%r12
   fde9a:	cmpb   $0x0,(%rax)
   fde9d:	je     fdf1d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2dbd>
   fde9f:	mov    -0x7e0(%rbp),%rax
   fdea6:	mov    (%rax),%r13
   fdea9:	mov    0xff0e0(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fdeb0:	movl   $0x1,-0x8a0(%rbp)
   fdeba:	mov    %rax,-0x8a8(%rbp)
   fdec1:	mov    -0x7e8(%rbp),%rax
   fdec8:	mov    (%rax),%rdi
   fdecb:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fded0:	mov    %r15,-0x898(%rbp)
   fded7:	mov    -0x8a0(%rbp),%ecx
   fdedd:	mov    %r13,%r9
   fdee0:	xor    %r8d,%r8d
   fdee3:	mov    %eax,-0x89c(%rbp)
   fdee9:	mov    -0x8a8(%rbp),%rdx
   fdef0:	mov    -0x89c(%rbp),%rdi
   fdef7:	mov    -0x894(%rbp),%esi
   fdefd:	call   6f040 <__cudaPushCallConfiguration@plt>
   fdf02:	test   %eax,%eax
   fdf04:	je     100a00 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x58a0>
   fdf0a:	call   6c900 <cudaGetLastError@plt>
   fdf0f:	mov    %eax,%edi
   fdf11:	lea    0xfc5a0(%rip),%rsi        # 1fa4b8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x55b8>
   fdf18:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fdf1d:	mov    -0xaf0(%rbp),%r12
   fdf24:	mov    0xff065(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fdf2b:	mov    %r15,-0x898(%rbp)
   fdf32:	mov    %r12,%r9
   fdf35:	xor    %r8d,%r8d
   fdf38:	mov    0xff051(%rip),%rdx        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fdf3f:	mov    -0x894(%rbp),%esi
   fdf45:	mov    $0x1,%ecx
   fdf4a:	movl   $0x1,-0x8a0(%rbp)
   fdf54:	mov    %rax,-0x8a8(%rbp)
   fdf5b:	mov    -0xae8(%rbp),%eax
   fdf61:	mov    %eax,-0x89c(%rbp)
   fdf67:	mov    -0x89c(%rbp),%rdi
   fdf6e:	call   6f040 <__cudaPushCallConfiguration@plt>
   fdf73:	test   %eax,%eax
   fdf75:	jne    fdfae <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2e4e>
   fdf77:	xor    %edx,%edx
   fdf79:	cmpq   $0x0,0x100(%rbx)
   fdf81:	mov    -0xaa8(%rbp),%r9
   fdf88:	mov    -0xaa0(%rbp),%r8
   fdf8f:	mov    0x2f90(%rbx),%rdi
   fdf96:	je     fdf9f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2e3f>
   fdf98:	mov    0xf8(%rbx),%rdx
   fdf9f:	mov    0xc0(%rbx),%rsi
   fdfa6:	mov    %rdi,%rcx
   fdfa9:	call   6a940 <synreal::kernel::invert_block_preconditioner(glm::mat<3, 3, float, (glm::qualifier)0> const*, float const*, int const*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long)@plt>
   fdfae:	call   6c900 <cudaGetLastError@plt>
   fdfb3:	mov    %eax,%edi
   fdfb5:	lea    0xfcadc(%rip),%rsi        # 1faa98 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5b98>
   fdfbc:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fdfc1:	cmpb   $0x0,-0xb10(%rbp)
   fdfc8:	mov    -0xaa0(%rbp),%r10
   fdfcf:	mov    0x3070(%rbx),%rdx
   fdfd6:	mov    -0xaf0(%rbp),%r9
   fdfdd:	je     fe650 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34f0>
   fdfe3:	mov    %rdx,%rsi
   fdfe6:	lea    -0x3d0(%rbp),%r8
   fdfed:	mov    %r10,%rcx
   fdff0:	mov    %r10,%rdx
   fdff3:	mov    %rbx,%rdi
   fdff6:	call   6da70 <synreal::SolverNewton::solve_newton_system(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, std::function<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)> const&, CUstream_st*)@plt>
   fdffb:	mov    0x1818(%rbx),%r9d
   fe002:	mov    -0xaf0(%rbp),%r12
   fe009:	test   %r9d,%r9d
   fe00c:	je     fe035 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2ed5>
   fe00e:	movss  0x28(%rbx),%xmm0
   fe013:	movss  0x2c(%rbx),%xmm1
   fe018:	mov    %r12,%rdx
   fe01b:	lea    0x1758(%rbx),%rdi
   fe022:	mov    0x3050(%rbx),%rsi
   fe029:	call   6e3f0 <synreal::Fluid::limit_step(glm::vec<3, float, (glm::qualifier)0>*, float, float, CUstream_st*)@plt>
   fe02e:	mov    -0xaf0(%rbp),%r12
   fe035:	mov    0xfef54(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fe03c:	mov    %r15,-0x898(%rbp)
   fe043:	mov    %r12,%r9
   fe046:	xor    %r8d,%r8d
   fe049:	mov    0xfef40(%rip),%rdx        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fe050:	mov    -0x894(%rbp),%esi
   fe056:	mov    $0x1,%ecx
   fe05b:	movl   $0x1,-0x8a0(%rbp)
   fe065:	mov    %rax,-0x8a8(%rbp)
   fe06c:	mov    -0xae8(%rbp),%eax
   fe072:	mov    %eax,-0x89c(%rbp)
   fe078:	mov    -0x89c(%rbp),%rdi
   fe07f:	call   6f040 <__cudaPushCallConfiguration@plt>
   fe084:	test   %eax,%eax
   fe086:	jne    fe0af <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2f4f>
   fe088:	mov    -0xb18(%rbp),%rax
   fe08f:	mov    0x3050(%rbx),%rdx
   fe096:	mov    -0xaa0(%rbp),%rcx
   fe09d:	mov    (%rax),%rsi
   fe0a0:	mov    -0xaf8(%rbp),%rax
   fe0a7:	mov    (%rax),%rdi
   fe0aa:	call   6aa40 <synreal::kernel::apply_nonlinear_step(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long)@plt>
   fe0af:	call   6c900 <cudaGetLastError@plt>
   fe0b4:	mov    %eax,%edi
   fe0b6:	lea    0xfca3b(%rip),%rsi        # 1faaf8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5bf8>
   fe0bd:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fe0c2:	cmpb   $0x0,-0xb45(%rbp)
   fe0c9:	mov    -0xaf0(%rbp),%r12
   fe0d0:	jne    fe8e0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3780>
   fe0d6:	cmpb   $0x0,-0xad8(%rbp)
   fe0dd:	jne    fe818 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x36b8>
   fe0e3:	mov    -0xb44(%rbp),%r8d
   fe0ea:	test   %r8d,%r8d
   fe0ed:	jne    fe738 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x35d8>
   fe0f3:	addl   $0x1,-0xb00(%rbp)
   fe0fa:	mov    -0xb00(%rbp),%eax
   fe100:	cmp    %eax,-0xb20(%rbp)
   fe106:	jle    fe5c0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3460>
   fe10c:	cmp    %eax,0x18(%rbx)
   fe10f:	sete   %r13b
   fe113:	cmpl   $0x3,-0xb30(%rbp)
   fe11a:	je     fe5cc <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x346c>
   fe120:	mov    -0xb00(%rbp),%eax
   fe126:	cltd   
   fe127:	idivl  0x14(%rbx)
   fe12a:	test   %edx,%edx
   fe12c:	jne    fe600 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34a0>
   fe132:	cmpl   $0x1,-0xb1c(%rbp)
   fe139:	je     fee40 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3ce0>
   fe13f:	mov    -0xaf8(%rbp),%rax
   fe146:	mov    (%rax),%rdi
   fe149:	mov    -0xb18(%rbp),%rax
   fe150:	mov    (%rax),%rsi
   fe153:	cmp    %rsi,%rdi
   fe156:	je     fc290 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1130>
   fe15c:	nopl   0x0(%rax)
   fe160:	mov    -0xaa0(%rbp),%rax
   fe167:	mov    %r12,%r8
   fe16a:	mov    $0x3,%ecx
   fe16f:	lea    (%rax,%rax,2),%rdx
   fe173:	shl    $0x2,%rdx
   fe177:	call   6e130 <cudaMemcpyAsync@plt>
   fe17c:	mov    %eax,%edi
   fe17e:	lea    0xfca8b(%rip),%rsi        # 1fac10 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5d10>
   fe185:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fe18a:	mov    -0xaf0(%rbp),%r12
   fe191:	mov    -0xb00(%rbp),%ecx
   fe197:	cmp    %ecx,-0xb20(%rbp)
   fe19d:	jne    fc290 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1130>
   fe1a3:	cmpb   $0x0,-0xad8(%rbp)
   fe1aa:	jne    101658 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x64f8>
   fe1b0:	cmpq   $0x0,0x3260(%rbx)
   fe1b8:	jne    102568 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7408>
   fe1be:	mov    -0xb20(%rbp),%edx
   fe1c4:	test   %edx,%edx
   fe1c6:	jne    fe212 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x30b2>
   fe1c8:	mov    -0xaf8(%rbp),%rax
   fe1cf:	mov    (%rax),%rsi
   fe1d2:	mov    -0xb18(%rbp),%rax
   fe1d9:	mov    (%rax),%rdi
   fe1dc:	cmp    %rsi,%rdi
   fe1df:	je     fe212 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x30b2>
   fe1e1:	mov    -0xaa0(%rbp),%rax
   fe1e8:	mov    %r12,%r8
   fe1eb:	mov    $0x3,%ecx
   fe1f0:	lea    (%rax,%rax,2),%rdx
   fe1f4:	shl    $0x2,%rdx
   fe1f8:	call   6e130 <cudaMemcpyAsync@plt>
   fe1fd:	mov    %eax,%edi
   fe1ff:	lea    0xfca82(%rip),%rsi        # 1fac88 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5d88>
   fe206:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fe20b:	mov    -0xaf0(%rbp),%r12
   fe212:	mov    0x21b0(%rbx),%eax
   fe218:	test   %eax,%eax
   fe21a:	je     fe24b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x30eb>
   fe21c:	mov    -0xb18(%rbp),%rax
   fe223:	mov    0x3090(%rbx),%rdx
   fe22a:	mov    %r12,%rcx
   fe22d:	lea    0x20a0(%rbx),%rdi
   fe234:	movss  -0xae4(%rbp),%xmm0
   fe23c:	mov    (%rax),%rsi
   fe23f:	call   6d310 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)@plt>
   fe244:	mov    -0xaf0(%rbp),%r12
   fe24b:	mov    0xfed3e(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fe252:	mov    0xfed37(%rip),%rdx        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fe259:	mov    %r12,%r9
   fe25c:	xor    %r8d,%r8d
   fe25f:	movl   $0x1,-0x8a0(%rbp)
   fe269:	mov    $0x1,%ecx
   fe26e:	mov    %rax,-0x8a8(%rbp)
   fe275:	mov    -0xae8(%rbp),%eax
   fe27b:	mov    %eax,-0x89c(%rbp)
   fe281:	movabs $0x100000001,%rax
   fe28b:	mov    %rax,-0x898(%rbp)
   fe292:	mov    -0x89c(%rbp),%rdi
   fe299:	mov    -0x894(%rbp),%esi
   fe29f:	call   6f040 <__cudaPushCallConfiguration@plt>
   fe2a4:	test   %eax,%eax
   fe2a6:	jne    fe2d9 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3179>
   fe2a8:	mov    -0xb18(%rbp),%rax
   fe2af:	mov    0x3090(%rbx),%rdi
   fe2b6:	mov    -0xaa0(%rbp),%rcx
   fe2bd:	movss  0xfecbb(%rip),%xmm0        # 1fcf80 <cuda::std::__4::in_place+0x33>
   fe2c5:	divss  -0xae4(%rbp),%xmm0
   fe2cd:	mov    0x10(%rax),%rdx
   fe2d1:	mov    (%rax),%rsi
   fe2d4:	call   6ab00 <synreal::kernel::update_velocity(float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long)@plt>
   fe2d9:	call   6c900 <cudaGetLastError@plt>
   fe2de:	mov    %eax,%edi
   fe2e0:	lea    0xfe337(%rip),%rsi        # 1fc61e <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x771e>
   fe2e7:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fe2ec:	cmpb   $0x0,-0xad3(%rbp)
   fe2f3:	jne    1016e0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6580>
   fe2f9:	mov    -0x3c0(%rbp),%rax
   fe300:	test   %rax,%rax
   fe303:	je     fe316 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x31b6>
   fe305:	lea    -0x3d0(%rbp),%rdi
   fe30c:	mov    $0x3,%edx
   fe311:	mov    %rdi,%rsi
   fe314:	call   *%rax
   fe316:	mov    -0x38(%rbp),%rax
   fe31a:	sub    %fs:0x28,%rax
   fe323:	jne    102a23 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78c3>
   fe329:	lea    -0x28(%rbp),%rsp
   fe32d:	pop    %rbx
   fe32e:	pop    %r12
   fe330:	pop    %r13
   fe332:	pop    %r14
   fe334:	pop    %r15
   fe336:	pop    %rbp
   fe337:	ret    
   fe338:	nopl   0x0(%rax,%rax,1)
   fe340:	mov    %rsi,-0xaa0(%rbp)
   fe347:	test   %rsi,%rsi
   fe34a:	je     fe316 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x31b6>
   fe34c:	mov    %rsi,%rax
   fe34f:	movaps %xmm0,%xmm2
   fe352:	jmp    fb23b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xdb>
   fe357:	nopw   0x0(%rax,%rax,1)
   fe360:	cmpb   $0x0,0x4c(%rbx)
   fe364:	je     fb368 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x208>
   fe36a:	cmpb   $0x0,0x4d(%rbx)
   fe36e:	je     fb368 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x208>
   fe374:	test   %ecx,%ecx
   fe376:	je     fb368 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x208>
   fe37c:	jmp    76766 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x124>
   fe381:	nopl   0x0(%rax)
   fe388:	mov    (%r14),%rax
   fe38b:	movdqu 0x60(%r14),%xmm5
   fe391:	movb   $0x1,-0xad7(%rbp)
   fe398:	movdqu 0x50(%r14),%xmm1
   fe39e:	movdqu 0x70(%r14),%xmm0
   fe3a4:	mov    %rax,-0x3b0(%rbp)
   fe3ab:	mov    %esi,%eax
   fe3ad:	movdqu 0x80(%r14),%xmm4
   fe3b6:	movdqu 0x40(%r14),%xmm6
   fe3bc:	mov    %rax,-0x3a8(%rbp)
   fe3c3:	punpckhqdq %xmm5,%xmm1
   fe3c7:	movdqu 0x30(%r14),%xmm2
   fe3cd:	punpckhqdq %xmm4,%xmm0
   fe3d1:	mov    0x98(%r14),%rax
   fe3d8:	movaps %xmm1,-0x380(%rbp)
   fe3df:	movdqu 0x10(%r14),%xmm3
   fe3e5:	movdqu 0x20(%r14),%xmm7
   fe3eb:	movaps %xmm0,-0x370(%rbp)
   fe3f2:	mov    %rax,-0x360(%rbp)
   fe3f9:	mov    0x758(%rbx),%rax
   fe400:	punpckhqdq %xmm6,%xmm2
   fe404:	movdqu 0x738(%rbx),%xmm0
   fe40c:	movdqu 0x748(%rbx),%xmm6
   fe414:	punpckhqdq %xmm7,%xmm3
   fe418:	movaps %xmm2,-0x390(%rbp)
   fe41f:	mov    %rax,-0x338(%rbp)
   fe426:	movdqu 0x718(%rbx),%xmm1
   fe42e:	mov    0x768(%rbx),%rax
   fe435:	movdqu 0x728(%rbx),%xmm5
   fe43d:	punpcklqdq %xmm6,%xmm0
   fe441:	movaps %xmm3,-0x3a0(%rbp)
   fe448:	movups %xmm0,-0x348(%rbp)
   fe44f:	mov    %rax,-0x330(%rbp)
   fe456:	punpcklqdq %xmm5,%xmm1
   fe45a:	xor    %eax,%eax
   fe45c:	cmpq   $0x0,0x7a0(%rbx)
   fe464:	movups %xmm1,-0x358(%rbp)
   fe46b:	jne    101c30 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6ad0>
   fe471:	mov    %rax,-0x328(%rbp)
   fe478:	xor    %eax,%eax
   fe47a:	cmpq   $0x0,0x7b0(%rbx)
   fe482:	jne    101c20 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6ac0>
   fe488:	movd   -0xac8(%rbp),%xmm1
   fe490:	movd   0x710(%rbx),%xmm0
   fe498:	mov    %rax,-0x320(%rbp)
   fe49f:	movdqu 0x3c0(%rbx),%xmm4
   fe4a7:	mov    -0xa80(%rbp),%rax
   fe4ae:	punpcklqdq %xmm1,%xmm0
   fe4b2:	movdqu 0x3d0(%rbx),%xmm7
   fe4ba:	movdqu 0x3f0(%rbx),%xmm1
   fe4c2:	movups %xmm0,-0x318(%rbp)
   fe4c9:	movdqu 0x3e0(%rbx),%xmm0
   fe4d1:	mov    0xd0(%r14),%edi
   fe4d8:	mov    %rax,-0x308(%rbp)
   fe4df:	mov    -0xaf8(%rbp),%rax
   fe4e6:	punpcklqdq %xmm7,%xmm1
   fe4ea:	punpcklqdq %xmm4,%xmm0
   fe4ee:	movaps %xmm1,-0x300(%rbp)
   fe4f5:	movss  0x44(%rbx),%xmm1
   fe4fa:	movaps %xmm0,-0x2f0(%rbp)
   fe501:	movd   0x398(%rbx),%xmm0
   fe509:	mov    (%rax),%rax
   fe50c:	movhps -0xaa8(%rbp),%xmm0
   fe513:	mov    %rax,-0xb38(%rbp)
   fe51a:	movaps %xmm0,-0x2e0(%rbp)
   fe521:	movq   %rax,%xmm0
   fe526:	movhps 0x3090(%rbx),%xmm0
   fe52d:	movaps %xmm0,-0x2d0(%rbp)
   fe534:	movss  0xfea44(%rip),%xmm0        # 1fcf80 <cuda::std::__4::in_place+0x33>
   fe53c:	divss  -0xae4(%rbp),%xmm0
   fe544:	unpcklps %xmm1,%xmm0
   fe547:	movlps %xmm0,-0x2c0(%rbp)
   fe54e:	test   %edi,%edi
   fe550:	jne    fb8a1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x741>
   fe556:	xor    %r15d,%r15d
   fe559:	xor    %eax,%eax
   fe55b:	jmp    fb8c2 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x762>
   fe560:	test   %ecx,%ecx
   fe562:	je     fb3ff <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x29f>
   fe568:	cmpq   $0x0,0xc8(%r14)
   fe570:	je     76cca <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x688>
   fe576:	mov    %ecx,%edx
   fe578:	cmp    %rdx,0xe0(%r14)
   fe57f:	jae    fb3cb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x26b>
   fe585:	jmp    76cca <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x688>
   fe58a:	nopw   0x0(%rax,%rax,1)
   fe590:	cmpl   $0x2,-0xb30(%rbp)
   fe597:	sete   %dl
   fe59a:	and    %al,%dl
   fe59c:	mov    %dl,-0xb10(%rbp)
   fe5a2:	jne    102890 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7730>
   fe5a8:	movzbl -0xb58(%rbp),%edx
   fe5af:	mov    %dl,-0xb10(%rbp)
   fe5b5:	jmp    fc15b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xffb>
   fe5ba:	nopw   0x0(%rax,%rax,1)
   fe5c0:	cmpl   $0x3,-0xb30(%rbp)
   fe5c7:	jne    fe600 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34a0>
   fe5c9:	xor    %r13d,%r13d
   fe5cc:	movss  0xc(%rbx),%xmm0
   fe5d1:	pxor   %xmm6,%xmm6
   fe5d5:	comiss %xmm6,%xmm0
   fe5d8:	jbe    fe5ea <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x348a>
   fe5da:	mov    -0xa78(%rbp),%rdi
   fe5e1:	test   %rdi,%rdi
   fe5e4:	jne    100bd0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5a70>
   fe5ea:	mov    -0xb00(%rbp),%ecx
   fe5f0:	cmp    %ecx,-0xb20(%rbp)
   fe5f6:	jg     fe120 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2fc0>
   fe5fc:	nopl   0x0(%rax)
   fe600:	xor    %r13d,%r13d
   fe603:	cmpl   $0x1,-0xb1c(%rbp)
   fe60a:	je     fef40 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3de0>
   fe610:	mov    -0xaf8(%rbp),%rax
   fe617:	mov    (%rax),%rdi
   fe61a:	mov    -0xb18(%rbp),%rax
   fe621:	mov    (%rax),%rsi
   fe624:	cmp    %rdi,%rsi
   fe627:	jne    fe160 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3000>
   fe62d:	jmp    fe191 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3031>
   fe632:	nopw   0x0(%rax,%rax,1)
   fe638:	movq   $0x0,-0xb58(%rbp)
   fe643:	jmp    fd494 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2334>
   fe648:	nopl   0x0(%rax,%rax,1)
   fe650:	lea    -0x3d0(%rbp),%rax
   fe657:	push   %r9
   fe659:	mov    %r10,%r8
   fe65c:	mov    %r10,%rcx
   fe65f:	push   %rax
   fe660:	movzbl -0xb40(%rbp),%r9d
   fe668:	mov    %rbx,%rdi
   fe66b:	mov    -0xb98(%rbp),%rsi
   fe672:	call   6cc60 <synreal::SolverNewton::solve_pd_newton_system(synreal::SparseMatrixELL const&, synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, bool, std::function<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)> const&, CUstream_st*)@plt>
   fe677:	pop    %r10
   fe679:	pop    %r11
   fe67b:	jmp    fdffb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2e9b>
   fe680:	cmpb   $0x0,-0xb10(%rbp)
   fe687:	jne    fd0f0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1f90>
   fe68d:	mov    0xfe8fc(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fe694:	mov    %r15,-0x898(%rbp)
   fe69b:	mov    %r12,%r9
   fe69e:	xor    %r8d,%r8d
   fe6a1:	mov    0xfe8e8(%rip),%rdx        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fe6a8:	mov    -0x894(%rbp),%esi
   fe6ae:	mov    $0x1,%ecx
   fe6b3:	movl   $0x1,-0x8a0(%rbp)
   fe6bd:	mov    %rax,-0x8a8(%rbp)
   fe6c4:	mov    -0xae8(%rbp),%eax
   fe6ca:	mov    %eax,-0x89c(%rbp)
   fe6d0:	mov    -0x89c(%rbp),%rdi
   fe6d7:	call   6f040 <__cudaPushCallConfiguration@plt>
   fe6dc:	test   %eax,%eax
   fe6de:	jne    fe71b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x35bb>
   fe6e0:	xor    %edx,%edx
   fe6e2:	cmpq   $0x0,0x100(%rbx)
   fe6ea:	mov    -0xaa8(%rbp),%r9
   fe6f1:	mov    -0xaa0(%rbp),%r8
   fe6f8:	mov    0x2f50(%rbx),%rcx
   fe6ff:	je     fe708 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x35a8>
   fe701:	mov    0xf8(%rbx),%rdx
   fe708:	mov    0xc0(%rbx),%rsi
   fe70f:	mov    0x2f10(%rbx),%rdi
   fe716:	call   6ab10 <synreal::kernel::prepare_inverse_preconditioner(float const*, float const*, int const*, float*, unsigned long, unsigned long)@plt>
   fe71b:	call   6c900 <cudaGetLastError@plt>
   fe720:	mov    %eax,%edi
   fe722:	lea    0xfc39f(%rip),%rsi        # 1faac8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5bc8>
   fe729:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fe72e:	jmp    fdfc1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2e61>
   fe733:	nopl   0x0(%rax,%rax,1)
   fe738:	mov    -0xb80(%rbp),%r13
   fe73f:	mov    0xfe84a(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fe746:	movl   $0x1,-0x8a0(%rbp)
   fe750:	mov    %r13,%rdi
   fe753:	mov    %rax,-0x8a8(%rbp)
   fe75a:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fe75f:	mov    %r15,-0x898(%rbp)
   fe766:	mov    -0x8a0(%rbp),%ecx
   fe76c:	mov    %r12,%r9
   fe76f:	xor    %r8d,%r8d
   fe772:	mov    %eax,-0x89c(%rbp)
   fe778:	mov    -0x8a8(%rbp),%rdx
   fe77f:	mov    -0x89c(%rbp),%rdi
   fe786:	mov    -0x894(%rbp),%esi
   fe78c:	call   6f040 <__cudaPushCallConfiguration@plt>
   fe791:	test   %eax,%eax
   fe793:	jne    fe7f6 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3696>
   fe795:	mov    0x4f0(%rbx),%eax
   fe79b:	sub    $0x8,%rsp
   fe79f:	mov    0x508(%rbx),%rcx
   fe7a6:	mov    0x4f8(%rbx),%rdx
   fe7ad:	mov    0x3d0(%rbx),%rsi
   fe7b4:	push   -0xaa8(%rbp)
   fe7ba:	push   %rax
   fe7bb:	mov    -0xb18(%rbp),%rax
   fe7c2:	push   %r13
   fe7c4:	push   0x34c0(%rbx)
   fe7ca:	push   0x34a0(%rbx)
   fe7d0:	mov    0x518(%rbx),%r8
   fe7d7:	push   0x558(%rbx)
   fe7dd:	mov    (%rax),%rdi
   fe7e0:	push   0x3480(%rbx)
   fe7e6:	mov    0x3460(%rbx),%r9
   fe7ed:	call   6aba0 <synreal::kernel::update_body_distance_constraint_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   fe7f2:	add    $0x40,%rsp
   fe7f6:	call   6c900 <cudaGetLastError@plt>
   fe7fb:	mov    %eax,%edi
   fe7fd:	lea    0xfc344(%rip),%rsi        # 1fab48 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5c48>
   fe804:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fe809:	mov    -0xaf0(%rbp),%r12
   fe810:	jmp    fe0f3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2f93>
   fe815:	nopl   (%rax)
   fe818:	lea    -0x170(%rbp),%r13
   fe81f:	mov    -0xba0(%rbp),%rsi
   fe826:	mov    $0x27,%ecx
   fe82b:	mov    -0xb18(%rbp),%rax
   fe832:	movl   $0x1,-0x8a0(%rbp)
   fe83c:	mov    %r13,%rdi
   fe83f:	rep movsq %ds:(%rsi),%es:(%rdi)
   fe842:	mov    (%rax),%rax
   fe845:	mov    0x10(%r14),%edi
   fe849:	mov    %rax,-0x98(%rbp)
   fe850:	mov    0xfe739(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fe857:	mov    %rax,-0x8a8(%rbp)
   fe85e:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fe863:	mov    %r15,-0x898(%rbp)
   fe86a:	mov    -0x8a0(%rbp),%ecx
   fe870:	mov    %r12,%r9
   fe873:	xor    %r8d,%r8d
   fe876:	mov    %eax,-0x89c(%rbp)
   fe87c:	mov    -0x8a8(%rbp),%rdx
   fe883:	mov    -0x89c(%rbp),%rdi
   fe88a:	mov    -0x894(%rbp),%esi
   fe890:	call   6f040 <__cudaPushCallConfiguration@plt>
   fe895:	test   %eax,%eax
   fe897:	jne    fe8ba <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x375a>
   fe899:	sub    $0x140,%rsp
   fe8a0:	mov    $0x27,%ecx
   fe8a5:	mov    %r13,%rsi
   fe8a8:	mov    %rsp,%rdi
   fe8ab:	rep movsq %ds:(%rsi),%es:(%rdi)
   fe8ae:	call   6ad40 <synreal::kernel::update_hard_contact_duals(synreal::kernel::HardContactView)@plt>
   fe8b3:	add    $0x140,%rsp
   fe8ba:	call   6c900 <cudaGetLastError@plt>
   fe8bf:	mov    %eax,%edi
   fe8c1:	lea    0xfc258(%rip),%rsi        # 1fab20 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5c20>
   fe8c8:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fe8cd:	mov    -0xaf0(%rbp),%r12
   fe8d4:	jmp    fe0e3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2f83>
   fe8d9:	nopl   0x0(%rax)
   fe8e0:	mov    0xfe6a9(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fe8e7:	mov    -0xa70(%rbp),%rdi
   fe8ee:	movl   $0x1,-0x8a0(%rbp)
   fe8f8:	mov    %rax,-0x8a8(%rbp)
   fe8ff:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fe904:	mov    %r15,-0x898(%rbp)
   fe90b:	mov    -0x8a0(%rbp),%ecx
   fe911:	mov    %r12,%r9
   fe914:	xor    %r8d,%r8d
   fe917:	mov    %eax,-0x89c(%rbp)
   fe91d:	mov    -0x8a8(%rbp),%rdx
   fe924:	mov    -0x89c(%rbp),%rdi
   fe92b:	mov    -0x894(%rbp),%esi
   fe931:	call   6f040 <__cudaPushCallConfiguration@plt>
   fe936:	test   %eax,%eax
   fe938:	jne    fe9d6 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3876>
   fe93e:	movss  0x60(%rbx),%xmm0
   fe943:	push   -0x648(%rbp)
   fe949:	push   -0x650(%rbp)
   fe94f:	push   -0x658(%rbp)
   fe955:	push   -0x660(%rbp)
   fe95b:	push   -0x668(%rbp)
   fe961:	push   -0x670(%rbp)
   fe967:	push   -0x678(%rbp)
   fe96d:	push   -0x680(%rbp)
   fe973:	push   -0x688(%rbp)
   fe979:	push   -0x690(%rbp)
   fe97f:	push   -0x698(%rbp)
   fe985:	push   -0x6a0(%rbp)
   fe98b:	push   -0x6a8(%rbp)
   fe991:	push   -0x6b0(%rbp)
   fe997:	push   -0x6b8(%rbp)
   fe99d:	push   -0x6c0(%rbp)
   fe9a3:	mov    -0xb18(%rbp),%rax
   fe9aa:	push   -0x6c8(%rbp)
   fe9b0:	push   -0x6d0(%rbp)
   fe9b6:	push   -0x6d8(%rbp)
   fe9bc:	push   -0x6e0(%rbp)
   fe9c2:	movss  0x64(%rbx),%xmm1
   fe9c7:	mov    (%rax),%rdi
   fe9ca:	call   6a8d0 <synreal::kernel::update_cable_penalties(synreal::kernel::CableView, glm::vec<3, float, (glm::qualifier)0> const*, float, float)@plt>
   fe9cf:	add    $0xa0,%rsp
   fe9d6:	call   6c900 <cudaGetLastError@plt>
   fe9db:	mov    %eax,%edi
   fe9dd:	lea    0xfdc1c(%rip),%rsi        # 1fc600 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x7700>
   fe9e4:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fe9e9:	mov    -0xaf0(%rbp),%r12
   fe9f0:	jmp    fe0d6 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2f76>
   fe9f5:	nopl   (%rax)
   fe9f8:	mov    0xfe591(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fe9ff:	mov    -0xa60(%rbp),%rdi
   fea06:	movl   $0x1,-0x8a0(%rbp)
   fea10:	mov    %rax,-0x8a8(%rbp)
   fea17:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fea1c:	mov    %r15,-0x898(%rbp)
   fea23:	mov    -0x8a0(%rbp),%ecx
   fea29:	mov    %r12,%r9
   fea2c:	xor    %r8d,%r8d
   fea2f:	mov    %eax,-0x89c(%rbp)
   fea35:	mov    -0x8a8(%rbp),%rdx
   fea3c:	mov    -0x89c(%rbp),%rdi
   fea43:	mov    -0x894(%rbp),%esi
   fea49:	call   6f040 <__cudaPushCallConfiguration@plt>
   fea4e:	test   %eax,%eax
   fea50:	jne    feab1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3951>
   fea52:	mov    0x318(%rbx),%eax
   fea58:	mov    0x350(%rbx),%rcx
   fea5f:	mov    0x340(%rbx),%rdx
   fea66:	mov    0x3090(%rbx),%rsi
   fea6d:	push   -0xaa8(%rbp)
   fea73:	mov    0x330(%rbx),%r9
   fea7a:	push   %rax
   fea7b:	mov    -0xaf8(%rbp),%rax
   fea82:	push   -0xa60(%rbp)
   fea88:	mov    0x320(%rbx),%r8
   fea8f:	push   0x3070(%rbx)
   fea95:	mov    (%rax),%rdi
   fea98:	movss  0xfe4e0(%rip),%xmm0        # 1fcf80 <cuda::std::__4::in_place+0x33>
   feaa0:	divss  -0xae4(%rbp),%xmm0
   feaa8:	call   6a850 <synreal::kernel::evaluate_bending_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   feaad:	add    $0x20,%rsp
   feab1:	call   6c900 <cudaGetLastError@plt>
   feab6:	mov    %eax,%edi
   feab8:	lea    0xfbb61(%rip),%rsi        # 1fa620 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5720>
   feabf:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   feac4:	mov    -0xaf0(%rbp),%r12
   feacb:	jmp    fd039 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ed9>
   fead0:	mov    0xfe4b9(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fead7:	mov    -0xa98(%rbp),%rdi
   feade:	movl   $0x1,-0x8a0(%rbp)
   feae8:	mov    %rax,-0x8a8(%rbp)
   feaef:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   feaf4:	mov    %r15,-0x898(%rbp)
   feafb:	mov    -0x8a0(%rbp),%ecx
   feb01:	mov    %r12,%r9
   feb04:	xor    %r8d,%r8d
   feb07:	mov    %eax,-0x89c(%rbp)
   feb0d:	mov    -0x8a8(%rbp),%rdx
   feb14:	mov    -0x89c(%rbp),%rdi
   feb1b:	mov    -0x894(%rbp),%esi
   feb21:	call   6f040 <__cudaPushCallConfiguration@plt>
   feb26:	test   %eax,%eax
   feb28:	jne    febb0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3a50>
   feb2e:	mov    -0xb88(%rbp),%rcx
   feb35:	xor    %eax,%eax
   feb37:	movss  0xfe441(%rip),%xmm0        # 1fcf80 <cuda::std::__4::in_place+0x33>
   feb3f:	divss  -0xae4(%rbp),%xmm0
   feb47:	mov    -0xaa8(%rbp),%r10
   feb4e:	mov    0x2e0(%rbx),%r9d
   feb55:	cmpq   $0x0,0x48(%rcx)
   feb5a:	mov    -0xa98(%rbp),%r8
   feb61:	mov    0x3070(%rbx),%rdi
   feb68:	je     feb6e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3a0e>
   feb6a:	mov    0x40(%rcx),%rax
   feb6e:	sub    $0x8,%rsp
   feb72:	mov    0x2f8(%rbx),%rcx
   feb79:	mov    0x2e8(%rbx),%rdx
   feb80:	mov    0x3090(%rbx),%rsi
   feb87:	push   %r10
   feb89:	push   %r9
   feb8b:	push   %r8
   feb8d:	push   %rdi
   feb8e:	mov    0x308(%rbx),%r8
   feb95:	push   %rax
   feb96:	mov    -0xaf8(%rbp),%rax
   feb9d:	mov    0x33c0(%rbx),%r9
   feba4:	mov    (%rax),%rdi
   feba7:	call   6ae90 <synreal::kernel::evaluate_tetrahedron_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   febac:	add    $0x30,%rsp
   febb0:	call   6c900 <cudaGetLastError@plt>
   febb5:	mov    %eax,%edi
   febb7:	lea    0xfba32(%rip),%rsi        # 1fa5f0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x56f0>
   febbe:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   febc3:	mov    -0xaf0(%rbp),%r12
   febca:	jmp    fd02b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ecb>
   febcf:	nop
   febd0:	imul   -0xa80(%rbp),%r13
   febd8:	mov    0xfe3b1(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   febdf:	movl   $0x1,-0x8a0(%rbp)
   febe9:	mov    %rax,-0x8a8(%rbp)
   febf0:	mov    %r13,%rdi
   febf3:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   febf8:	mov    %r15,-0x898(%rbp)
   febff:	mov    -0x8a0(%rbp),%ecx
   fec05:	mov    %r12,%r9
   fec08:	xor    %r8d,%r8d
   fec0b:	mov    %eax,-0x89c(%rbp)
   fec11:	mov    -0x8a8(%rbp),%rdx
   fec18:	mov    -0x89c(%rbp),%rdi
   fec1f:	mov    -0x894(%rbp),%esi
   fec25:	call   6f040 <__cudaPushCallConfiguration@plt>
   fec2a:	test   %eax,%eax
   fec2c:	jne    fec77 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3b17>
   fec2e:	mov    0x278(%rbx),%eax
   fec34:	sub    $0x8,%rsp
   fec38:	mov    0x280(%rbx),%rcx
   fec3f:	mov    0x2a0(%rbx),%rdx
   fec46:	mov    0x290(%rbx),%rsi
   fec4d:	push   -0xaa8(%rbp)
   fec53:	mov    0x3070(%rbx),%r9
   fec5a:	push   %rax
   fec5b:	mov    -0xaf8(%rbp),%rax
   fec62:	mov    0x2c0(%rbx),%r8
   fec69:	push   %r13
   fec6b:	mov    (%rax),%rdi
   fec6e:	call   6af60 <synreal::kernel::evaluate_stretch_force(glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::mat<2, 2, float, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   fec73:	add    $0x20,%rsp
   fec77:	call   6c900 <cudaGetLastError@plt>
   fec7c:	mov    %eax,%edi
   fec7e:	lea    0xfb943(%rip),%rsi        # 1fa5c8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x56c8>
   fec85:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fec8a:	mov    -0xaf0(%rbp),%r12
   fec91:	jmp    fd01e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ebe>
   fec96:	cs nopw 0x0(%rax,%rax,1)
   feca0:	imul   -0xa80(%rbp),%r13
   feca8:	mov    0xfe2e1(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fecaf:	movl   $0x1,-0x8a0(%rbp)
   fecb9:	mov    %rax,-0x8a8(%rbp)
   fecc0:	mov    %r13,%rdi
   fecc3:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fecc8:	mov    %r15,-0x898(%rbp)
   feccf:	mov    -0x8a0(%rbp),%ecx
   fecd5:	mov    %r12,%r9
   fecd8:	xor    %r8d,%r8d
   fecdb:	mov    %eax,-0x89c(%rbp)
   fece1:	mov    -0x8a8(%rbp),%rdx
   fece8:	mov    -0x89c(%rbp),%rdi
   fecef:	mov    -0x894(%rbp),%esi
   fecf5:	call   6f040 <__cudaPushCallConfiguration@plt>
   fecfa:	test   %eax,%eax
   fecfc:	jne    fed3b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3bdb>
   fecfe:	mov    0x240(%rbx),%eax
   fed04:	mov    0x268(%rbx),%rcx
   fed0b:	mov    %r13,%r9
   fed0e:	mov    0x258(%rbx),%rdx
   fed15:	mov    0x248(%rbx),%rsi
   fed1c:	push   -0xaa8(%rbp)
   fed22:	mov    0x3070(%rbx),%r8
   fed29:	push   %rax
   fed2a:	mov    -0xaf8(%rbp),%rax
   fed31:	mov    (%rax),%rdi
   fed34:	call   6ac20 <synreal::kernel::evaluate_spring_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, float const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   fed39:	pop    %rcx
   fed3a:	pop    %rsi
   fed3b:	call   6c900 <cudaGetLastError@plt>
   fed40:	mov    %eax,%edi
   fed42:	lea    0xfb857(%rip),%rsi        # 1fa5a0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x56a0>
   fed49:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fed4e:	mov    -0xaf0(%rbp),%r12
   fed55:	jmp    fd00e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1eae>
   fed5a:	nopw   0x0(%rax,%rax,1)
   fed60:	mov    -0xaf8(%rbp),%rax
   fed67:	mov    0x3070(%rbx),%rcx
   fed6e:	lea    0x1758(%rbx),%rdi
   fed75:	mov    0x3090(%rbx),%rdx
   fed7c:	mov    -0xaf0(%rbp),%r8
   fed83:	movss  -0xae4(%rbp),%xmm0
   fed8b:	mov    (%rax),%rsi
   fed8e:	call   6ec90 <synreal::Fluid::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)@plt>
   fed93:	mov    0x21b0(%rbx),%eax
   fed99:	test   %eax,%eax
   fed9b:	je     fc4ed <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x138d>
   feda1:	mov    -0xaf8(%rbp),%rax
   feda8:	mov    0x3070(%rbx),%rcx
   fedaf:	lea    0x20a0(%rbx),%rdi
   fedb6:	mov    0x3090(%rbx),%rdx
   fedbd:	mov    -0xaf0(%rbp),%r8
   fedc4:	movss  -0xae4(%rbp),%xmm0
   fedcc:	mov    (%rax),%rsi
   fedcf:	call   6d7a0 <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)@plt>
   fedd4:	jmp    fc4ed <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x138d>
   fedd9:	nopl   0x0(%rax)
   fede0:	mov    -0xaf8(%rbp),%rax
   fede7:	movss  0x74(%rbx),%xmm0
   fedec:	mov    %r12,%r9
   fedef:	lea    0x920(%rbx),%rdi
   fedf6:	mov    0x3070(%rbx),%rcx
   fedfd:	mov    0x2f30(%rbx),%rdx
   fee04:	movzbl 0x41(%rbx),%r8d
   fee09:	movss  0x84(%rbx),%xmm4
   fee11:	movss  0x80(%rbx),%xmm3
   fee19:	movss  0x7c(%rbx),%xmm2
   fee1e:	movss  0x78(%rbx),%xmm1
   fee23:	mov    (%rax),%rsi
   fee26:	call   6b570 <synreal::SelfCollision::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, float, float, float, float, glm::vec<3, float, (glm::qualifier)0>*, bool, CUstream_st*)@plt>
   fee2b:	mov    -0xaf0(%rbp),%r12
   fee32:	jmp    fcfb4 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1e54>
   fee37:	nopw   0x0(%rax,%rax,1)
   fee40:	movss  0xc(%rbx),%xmm0
   fee45:	pxor   %xmm6,%xmm6
   fee49:	mov    $0x1,%r13d
   fee4f:	comiss %xmm6,%xmm0
   fee52:	jbe    fef45 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3de5>
   fee58:	cmpq   $0x0,-0xba8(%rbp)
   fee60:	je     fef52 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3df2>
   fee66:	mov    -0xba8(%rbp),%r13
   fee6d:	mov    0xfe11c(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fee74:	movl   $0x1,-0x8a0(%rbp)
   fee7e:	mov    %r13,%rdi
   fee81:	mov    %rax,-0x8a8(%rbp)
   fee88:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fee8d:	mov    %r15,-0x898(%rbp)
   fee94:	mov    -0x8a0(%rbp),%ecx
   fee9a:	mov    %r12,%r9
   fee9d:	xor    %r8d,%r8d
   feea0:	mov    %eax,-0x89c(%rbp)
   feea6:	mov    -0x8a8(%rbp),%rdx
   feead:	mov    -0x89c(%rbp),%rdi
   feeb4:	mov    -0x894(%rbp),%esi
   feeba:	call   6f040 <__cudaPushCallConfiguration@plt>
   feebf:	test   %eax,%eax
   feec1:	jne    fef1b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3dbb>
   feec3:	mov    0x49c(%rbx),%eax
   feec9:	mov    0x4b0(%rbx),%rcx
   feed0:	mov    0x4a0(%rbx),%rdx
   feed7:	mov    0x3d0(%rbx),%rsi
   feede:	push   -0xaa8(%rbp)
   feee4:	push   %rax
   feee5:	mov    0x498(%rbx),%eax
   feeeb:	push   %rax
   feeec:	mov    -0xb18(%rbp),%rax
   feef3:	push   %r13
   feef5:	push   0x3440(%rbx)
   feefb:	mov    0x4c0(%rbx),%r8
   fef02:	mov    (%rax),%rdi
   fef05:	push   0x3420(%rbx)
   fef0b:	mov    0x3400(%rbx),%r9
   fef12:	call   6aad0 <synreal::kernel::update_joint_body_spring_augmented_lagrangian_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
   fef17:	add    $0x30,%rsp
   fef1b:	call   6c900 <cudaGetLastError@plt>
   fef20:	mov    %eax,%edi
   fef22:	lea    0xfbc87(%rip),%rsi        # 1fabb0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5cb0>
   fef29:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fef2e:	mov    -0xaf0(%rbp),%r12
   fef35:	mov    $0x1,%r13d
   fef3b:	nopl   0x0(%rax,%rax,1)
   fef40:	movss  0xc(%rbx),%xmm0
   fef45:	pxor   %xmm5,%xmm5
   fef49:	comiss %xmm5,%xmm0
   fef4c:	jbe    fe610 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34b0>
   fef52:	mov    -0xa68(%rbp),%rdi
   fef59:	test   %rdi,%rdi
   fef5c:	je     fe610 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34b0>
   fef62:	mov    0xfe027(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fef69:	movl   $0x1,-0x8a0(%rbp)
   fef73:	mov    %rax,-0x8a8(%rbp)
   fef7a:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   fef7f:	mov    %r15,-0x898(%rbp)
   fef86:	mov    -0x8a0(%rbp),%ecx
   fef8c:	mov    %r12,%r9
   fef8f:	xor    %r8d,%r8d
   fef92:	mov    %eax,-0x89c(%rbp)
   fef98:	mov    -0x8a8(%rbp),%rdx
   fef9f:	mov    -0x89c(%rbp),%rdi
   fefa6:	mov    -0x894(%rbp),%esi
   fefac:	call   6f040 <__cudaPushCallConfiguration@plt>
   fefb1:	test   %eax,%eax
   fefb3:	jne    ff025 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3ec5>
   fefb5:	mov    0x56c(%rbx),%eax
   fefbb:	mov    0x34e0(%rbx),%rcx
   fefc2:	mov    0x570(%rbx),%rdx
   fefc9:	mov    0x3d0(%rbx),%rsi
   fefd0:	push   -0xaa8(%rbp)
   fefd6:	mov    0x3520(%rbx),%r9
   fefdd:	push   %rax
   fefde:	mov    0x568(%rbx),%eax
   fefe4:	mov    0x3500(%rbx),%r8
   fefeb:	push   %rax
   fefec:	mov    -0xb18(%rbp),%rax
   feff3:	push   -0xa68(%rbp)
   feff9:	push   %r13
   feffb:	push   0x3560(%rbx)
   ff001:	push   0x3580(%rbx)
   ff007:	push   0x3540(%rbx)
   ff00d:	push   0x5a0(%rbx)
   ff013:	push   0x590(%rbx)
   ff019:	mov    (%rax),%rdi
   ff01c:	call   6aea0 <synreal::kernel::update_joint_body_point_line_augmented_lagrangian_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, bool, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
   ff021:	add    $0x50,%rsp
   ff025:	call   6c900 <cudaGetLastError@plt>
   ff02a:	mov    %eax,%edi
   ff02c:	lea    0xfbbad(%rip),%rsi        # 1fabe0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5ce0>
   ff033:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ff038:	mov    -0xaf0(%rbp),%r12
   ff03f:	jmp    fe610 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34b0>
   ff044:	nopl   0x0(%rax)
   ff048:	mov    0x398(%rbx),%eax
   ff04e:	test   %eax,%eax
   ff050:	je     fd3d8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2278>
   ff056:	cmpl   $0x2,-0xb30(%rbp)
   ff05d:	jne    fd3d8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2278>
   ff063:	movss  0xc(%rbx),%xmm0
   ff068:	pxor   %xmm6,%xmm6
   ff06c:	comiss %xmm6,%xmm0
   ff06f:	jbe    fd3d8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2278>
   ff075:	mov    0xfdf14(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   ff07c:	mov    -0xa78(%rbp),%rdi
   ff083:	movl   $0x1,-0x8a0(%rbp)
   ff08d:	mov    %rax,-0x8a8(%rbp)
   ff094:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   ff099:	mov    %r15,-0x898(%rbp)
   ff0a0:	mov    -0x8a0(%rbp),%ecx
   ff0a6:	mov    %r12,%r9
   ff0a9:	xor    %r8d,%r8d
   ff0ac:	mov    %eax,-0x89c(%rbp)
   ff0b2:	mov    -0x8a8(%rbp),%rdx
   ff0b9:	mov    -0x89c(%rbp),%rdi
   ff0c0:	mov    -0x894(%rbp),%esi
   ff0c6:	call   6f040 <__cudaPushCallConfiguration@plt>
   ff0cb:	test   %eax,%eax
   ff0cd:	jne    ff135 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3fd5>
   ff0cf:	mov    0x398(%rbx),%eax
   ff0d5:	movss  0xc(%rbx),%xmm0
   ff0da:	sub    $0x8,%rsp
   ff0de:	mulss  -0xacc(%rbp),%xmm0
   ff0e6:	mov    0x3a0(%rbx),%rdx
   ff0ed:	mov    0x3d0(%rbx),%rsi
   ff0f4:	push   -0xaa0(%rbp)
   ff0fa:	mov    -0xb70(%rbp),%r9
   ff101:	push   -0xaa8(%rbp)
   ff107:	mov    -0xb90(%rbp),%r8
   ff10e:	push   %rax
   ff10f:	mov    -0xaf8(%rbp),%rax
   ff116:	push   -0xa78(%rbp)
   ff11c:	mov    -0xb58(%rbp),%rcx
   ff123:	push   -0xb60(%rbp)
   ff129:	mov    (%rax),%rdi
   ff12c:	call   6af30 <synreal::kernel::add_affine_body_spring_gauss_newton_hessian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
   ff131:	add    $0x30,%rsp
   ff135:	call   6c900 <cudaGetLastError@plt>
   ff13a:	mov    %eax,%edi
   ff13c:	lea    0xfb5ad(%rip),%rsi        # 1fa6f0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x57f0>
   ff143:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ff148:	cmpb   $0x0,-0xbc8(%rbp)
   ff14f:	je     fd277 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2117>
   ff155:	mov    -0xaf0(%rbp),%r12
   ff15c:	jmp    fd187 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2027>
   ff161:	nopl   0x0(%rax)
   ff168:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   ff16d:	mov    %r15,-0x8b0(%rbp)
   ff174:	mov    -0x8f0(%rbp),%ecx
   ff17a:	mov    %r12,%r9
   ff17d:	xor    %r8d,%r8d
   ff180:	mov    %eax,-0x8b4(%rbp)
   ff186:	mov    -0x8f8(%rbp),%rdx
   ff18d:	mov    -0x8b4(%rbp),%rdi
   ff194:	mov    -0x8ac(%rbp),%esi
   ff19a:	call   6f040 <__cudaPushCallConfiguration@plt>
   ff19f:	mov    %eax,%r8d
   ff1a2:	lea    -0x9b0(%rbp),%rax
   ff1a9:	lea    -0x958(%rbp),%rdx
   ff1b0:	movq   %rax,%xmm9
   ff1b5:	lea    -0x9a8(%rbp),%rax
   ff1bc:	movq   %rax,%xmm7
   ff1c1:	lea    -0x9a0(%rbp),%rax
   ff1c8:	movq   %rax,%xmm8
   ff1cd:	lea    -0x998(%rbp),%rax
   ff1d4:	punpcklqdq %xmm7,%xmm9
   ff1d9:	movq   %rax,%xmm6
   ff1de:	lea    -0x990(%rbp),%rax
   ff1e5:	movq   %rax,%xmm7
   ff1ea:	lea    -0x988(%rbp),%rax
   ff1f1:	punpcklqdq %xmm6,%xmm8
   ff1f6:	movq   %rax,%xmm5
   ff1fb:	lea    -0x980(%rbp),%rax
   ff202:	movq   %rax,%xmm6
   ff207:	lea    -0x978(%rbp),%rax
   ff20e:	punpcklqdq %xmm5,%xmm7
   ff212:	movq   %rax,%xmm4
   ff217:	lea    -0xab0(%rbp),%rax
   ff21e:	movq   %rax,%xmm5
   ff223:	lea    -0x5a0(%rbp),%rax
   ff22a:	punpcklqdq %xmm4,%xmm6
   ff22e:	movq   %rax,%xmm4
   ff233:	lea    -0x970(%rbp),%rax
   ff23a:	punpcklqdq %xmm4,%xmm5
   ff23e:	movq   %rax,%xmm4
   ff243:	lea    -0x968(%rbp),%rax
   ff24a:	movq   %rax,%xmm3
   ff24f:	lea    -0xaac(%rbp),%rax
   ff256:	punpcklqdq %xmm3,%xmm4
   ff25a:	movq   %rax,%xmm3
   ff25f:	lea    -0x960(%rbp),%rax
   ff266:	movq   %rax,%xmm2
   ff26b:	lea    -0x950(%rbp),%rax
   ff272:	movq   %rax,%xmm1
   ff277:	punpcklqdq %xmm2,%xmm3
   ff27b:	lea    -0x940(%rbp),%rax
   ff282:	movq   %rdx,%xmm2
   ff287:	lea    -0x948(%rbp),%rdx
   ff28e:	movq   %rax,%xmm0
   ff293:	punpcklqdq %xmm1,%xmm2
   ff297:	lea    -0x938(%rbp),%rax
   ff29e:	movq   %rdx,%xmm1
   ff2a3:	lea    -0x930(%rbp),%rdx
   ff2aa:	punpcklqdq %xmm0,%xmm1
   ff2ae:	movq   %rax,%xmm0
   ff2b3:	movq   %rdx,%xmm15
   ff2b8:	punpcklqdq %xmm15,%xmm0
   ff2bd:	test   %r8d,%r8d
   ff2c0:	jne    fde6c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2d0c>
   ff2c6:	mov    -0xaa8(%rbp),%rax
   ff2cd:	cmpb   $0x0,-0xacf(%rbp)
   ff2d4:	pxor   %xmm10,%xmm10
   ff2d9:	movss  0xfdc9e(%rip),%xmm12        # 1fcf80 <cuda::std::__4::in_place+0x33>
   ff2e2:	movd   0x398(%rbx),%xmm11
   ff2eb:	divss  -0xae4(%rbp),%xmm12
   ff2f4:	mov    %rax,-0xb70(%rbp)
   ff2fb:	mov    -0xa78(%rbp),%rax
   ff302:	mov    0x2fb0(%rbx),%rsi
   ff309:	mov    0x2ff0(%rbx),%rdi
   ff310:	mov    %rax,-0xb60(%rbp)
   ff317:	mov    0x2fd0(%rbx),%rax
   ff31e:	mov    0x3030(%rbx),%r8
   ff325:	mov    0x3010(%rbx),%r9
   ff32c:	mov    %rax,-0xb90(%rbp)
   ff333:	je     ff344 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x41e4>
   ff335:	movss  0xc(%rbx),%xmm10
   ff33b:	mulss  -0xacc(%rbp),%xmm10
   ff344:	mov    -0xb98(%rbp),%rdx
   ff34b:	mov    0x3380(%rbx),%r10
   ff352:	mov    0x28(%rdx),%rax
   ff356:	mov    0x20(%rdx),%r11
   ff35a:	mov    0x10(%rdx),%r12
   ff35e:	mov    (%rdx),%r13
   ff361:	mov    0x2f90(%rbx),%rdx
   ff368:	test   %rax,%rax
   ff36b:	cmove  -0xaa0(%rbp),%rax
   ff373:	mov    %rdx,-0xbe0(%rbp)
   ff37a:	xor    %edx,%edx
   ff37c:	cmpq   $0x0,0x100(%rbx)
   ff384:	je     ff38d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x422d>
   ff386:	mov    0xf8(%rbx),%rdx
   ff38d:	movdqa -0x6e0(%rbp),%xmm13
   ff396:	mov    0x3d0(%rbx),%rcx
   ff39d:	mov    %rdx,-0x9a8(%rbp)
   ff3a4:	movdqa -0x690(%rbp),%xmm14
   ff3ad:	mov    -0xbe0(%rbp),%rdx
   ff3b4:	mov    %r13,-0x998(%rbp)
   ff3bb:	movdqa -0x680(%rbp),%xmm15
   ff3c4:	movaps %xmm13,-0x5a0(%rbp)
   ff3cc:	movdqa -0x6d0(%rbp),%xmm13
   ff3d5:	mov    %rcx,-0x9c0(%rbp)
   ff3dc:	mov    0x3a0(%rbx),%rcx
   ff3e3:	movaps %xmm13,-0x590(%rbp)
   ff3eb:	movdqa -0x6c0(%rbp),%xmm13
   ff3f4:	mov    %rcx,-0x9b8(%rbp)
   ff3fb:	mov    0xc0(%rbx),%rcx
   ff402:	movaps %xmm13,-0x580(%rbp)
   ff40a:	movdqa -0x6b0(%rbp),%xmm13
   ff413:	movaps %xmm14,-0x550(%rbp)
   ff41b:	movdqa -0x660(%rbp),%xmm14
   ff424:	movaps %xmm13,-0x570(%rbp)
   ff42c:	movdqa -0x6a0(%rbp),%xmm13
   ff435:	movaps %xmm15,-0x540(%rbp)
   ff43d:	movdqa -0x650(%rbp),%xmm15
   ff446:	movaps %xmm13,-0x560(%rbp)
   ff44e:	movdqa -0x670(%rbp),%xmm13
   ff457:	mov    %rcx,-0x9b0(%rbp)
   ff45e:	lea    -0x920(%rbp),%rcx
   ff465:	mov    %rdx,-0x9a0(%rbp)
   ff46c:	lea    -0x928(%rbp),%rdx
   ff473:	mov    %r12,-0x990(%rbp)
   ff47a:	mov    %r11,-0x988(%rbp)
   ff481:	movaps %xmm13,-0x530(%rbp)
   ff489:	movaps %xmm14,-0x520(%rbp)
   ff491:	movaps %xmm15,-0x510(%rbp)
   ff499:	mov    %rax,-0x980(%rbp)
   ff4a0:	mov    -0xb58(%rbp),%rax
   ff4a7:	movq   %xmm11,-0x938(%rbp)
   ff4b0:	movdqa -0xbf0(%rbp),%xmm11
   ff4b9:	mov    %rax,-0x958(%rbp)
   ff4c0:	mov    -0xb90(%rbp),%rax
   ff4c7:	mov    %rdi,-0x960(%rbp)
   ff4ce:	lea    -0x8e8(%rbp),%rdi
   ff4d5:	mov    %rax,-0x948(%rbp)
   ff4dc:	mov    -0xb60(%rbp),%rax
   ff4e3:	mov    %rsi,-0x950(%rbp)
   ff4ea:	lea    -0x8c0(%rbp),%rsi
   ff4f1:	mov    %rax,-0x940(%rbp)
   ff4f8:	mov    -0xb70(%rbp),%rax
   ff4ff:	mov    %r10,-0x978(%rbp)
   ff506:	mov    %rax,-0x930(%rbp)
   ff50d:	mov    0xfda5c(%rip),%rax        # 1fcf70 <cuda::std::__4::in_place+0x23>
   ff514:	mov    %r9,-0x970(%rbp)
   ff51b:	mov    %r8,-0x968(%rbp)
   ff522:	mov    %rax,-0x8e8(%rbp)
   ff529:	movl   $0x1,-0x8e0(%rbp)
   ff533:	mov    %rax,-0x8c0(%rbp)
   ff53a:	movss  %xmm10,-0xab0(%rbp)
   ff543:	movss  %xmm12,-0xaac(%rbp)
   ff54c:	movaps %xmm11,-0x170(%rbp)
   ff554:	movaps %xmm9,-0x160(%rbp)
   ff55c:	movaps %xmm8,-0x150(%rbp)
   ff564:	movaps %xmm7,-0x140(%rbp)
   ff56b:	movaps %xmm6,-0x130(%rbp)
   ff572:	movaps %xmm5,-0x120(%rbp)
   ff579:	movaps %xmm4,-0x110(%rbp)
   ff580:	movaps %xmm3,-0x100(%rbp)
   ff587:	movaps %xmm2,-0xf0(%rbp)
   ff58e:	movaps %xmm1,-0xe0(%rbp)
   ff595:	movaps %xmm0,-0xd0(%rbp)
   ff59c:	movl   $0x1,-0x8b8(%rbp)
   ff5a6:	call   6ebe0 <__cudaPopCallConfiguration@plt>
   ff5ab:	test   %eax,%eax
   ff5ad:	jne    fde6c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2d0c>
   ff5b3:	push   -0x920(%rbp)
   ff5b9:	mov    -0x8e8(%rbp),%rsi
   ff5c0:	lea    -0x170(%rbp),%r9
   ff5c7:	mov    -0x8e0(%rbp),%edx
   ff5cd:	push   -0x928(%rbp)
   ff5d3:	mov    -0x8c0(%rbp),%rcx
   ff5da:	mov    %rsi,-0x89c(%rbp)
   ff5e1:	mov    -0x8b8(%rbp),%r8d
   ff5e8:	mov    0x603f79(%rip),%rdi        # 703568 <void synreal::kernel::build_affine_body_preconditioner<synreal::NonZeroEntry>(glm::vec<4, int, (glm::qualifier)0> const*, float const*, float const*, int const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, int const*, synreal::NonZeroEntry const*, unsigned long, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, synreal::kernel::CableView, unsigned long const*, int const*, float, int const*, float const*, float*, int*, unsigned long, unsigned long, unsigned long)@@Base+0x5f3d98>
   ff5ef:	mov    %edx,-0x894(%rbp)
   ff5f5:	mov    %rcx,-0x8a8(%rbp)
   ff5fc:	mov    %r8d,-0x8a0(%rbp)
   ff603:	call   6b560 <cudaLaunchKernel@plt>
   ff608:	jmp    fde6a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2d0a>
   ff60d:	nopl   (%rax)
   ff610:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   ff615:	mov    %r15,-0x898(%rbp)
   ff61c:	mov    -0x8a0(%rbp),%ecx
   ff622:	mov    %r12,%r9
   ff625:	xor    %r8d,%r8d
   ff628:	mov    %eax,-0x89c(%rbp)
   ff62e:	mov    -0x8a8(%rbp),%rdx
   ff635:	mov    -0x89c(%rbp),%rdi
   ff63c:	mov    -0x894(%rbp),%esi
   ff642:	call   6f040 <__cudaPushCallConfiguration@plt>
   ff647:	test   %eax,%eax
   ff649:	je     1009c0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5860>
   ff64f:	call   6c900 <cudaGetLastError@plt>
   ff654:	mov    %eax,%edi
   ff656:	lea    0xfabc3(%rip),%rsi        # 1fa220 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5320>
   ff65d:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ff662:	jmp    fc6a7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1547>
   ff667:	nopw   0x0(%rax,%rax,1)
   ff670:	mov    0xfd919(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   ff677:	mov    0x10(%r14),%edi
   ff67b:	movl   $0x1,-0x8a0(%rbp)
   ff685:	mov    %rax,-0x8a8(%rbp)
   ff68c:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   ff691:	mov    %r15,-0x898(%rbp)
   ff698:	mov    -0x8a0(%rbp),%ecx
   ff69e:	mov    %r12,%r9
   ff6a1:	xor    %r8d,%r8d
   ff6a4:	mov    %eax,-0x89c(%rbp)
   ff6aa:	mov    -0x8a8(%rbp),%rdx
   ff6b1:	mov    -0x89c(%rbp),%rdi
   ff6b8:	mov    -0x894(%rbp),%esi
   ff6be:	call   6f040 <__cudaPushCallConfiguration@plt>
   ff6c3:	test   %eax,%eax
   ff6c5:	jne    ff79c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x463c>
   ff6cb:	sub    $0x8,%rsp
   ff6cf:	mov    0x2f90(%rbx),%rdi
   ff6d6:	push   -0x2c0(%rbp)
   ff6dc:	push   -0x2c8(%rbp)
   ff6e2:	push   -0x2d0(%rbp)
   ff6e8:	push   -0x2d8(%rbp)
   ff6ee:	push   -0x2e0(%rbp)
   ff6f4:	push   -0x2e8(%rbp)
   ff6fa:	push   -0x2f0(%rbp)
   ff700:	push   -0x2f8(%rbp)
   ff706:	push   -0x300(%rbp)
   ff70c:	push   -0x308(%rbp)
   ff712:	push   -0x310(%rbp)
   ff718:	push   -0x318(%rbp)
   ff71e:	push   -0x320(%rbp)
   ff724:	push   -0x328(%rbp)
   ff72a:	push   -0x330(%rbp)
   ff730:	push   -0x338(%rbp)
   ff736:	push   -0x340(%rbp)
   ff73c:	push   -0x348(%rbp)
   ff742:	push   -0x350(%rbp)
   ff748:	push   -0x358(%rbp)
   ff74e:	push   -0x360(%rbp)
   ff754:	push   -0x368(%rbp)
   ff75a:	push   -0x370(%rbp)
   ff760:	push   -0x378(%rbp)
   ff766:	push   -0x380(%rbp)
   ff76c:	push   -0x388(%rbp)
   ff772:	push   -0x390(%rbp)
   ff778:	push   -0x398(%rbp)
   ff77e:	push   -0x3a0(%rbp)
   ff784:	push   -0x3a8(%rbp)
   ff78a:	push   -0x3b0(%rbp)
   ff790:	call   6a7e0 <synreal::kernel::add_rolling_contact_preconditioner(synreal::kernel::RollingContactView, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
   ff795:	add    $0x100,%rsp
   ff79c:	call   6c900 <cudaGetLastError@plt>
   ff7a1:	mov    %eax,%edi
   ff7a3:	lea    0xfb266(%rip),%rsi        # 1faa10 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5b10>
   ff7aa:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ff7af:	mov    -0xaf0(%rbp),%r12
   ff7b6:	jmp    fd97b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x281b>
   ff7bb:	nopl   0x0(%rax,%rax,1)
   ff7c0:	mov    0x2f90(%rbx),%rsi
   ff7c7:	mov    -0xaf0(%rbp),%rdx
   ff7ce:	lea    0x20a0(%rbx),%rdi
   ff7d5:	call   6b4b0 <synreal::Granular::add_preconditioner(glm::mat<3, 3, float, (glm::qualifier)0>*, CUstream_st*) const@plt>
   ff7da:	cmpb   $0x0,-0xad5(%rbp)
   ff7e1:	je     fd72d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x25cd>
   ff7e7:	mov    0xfd7a2(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   ff7ee:	xor    %r8d,%r8d
   ff7f1:	mov    $0x1,%ecx
   ff7f6:	mov    %r15,-0x898(%rbp)
   ff7fd:	mov    0xfd78c(%rip),%rdx        # 1fcf90 <cuda::std::__4::in_place+0x43>
   ff804:	mov    -0x894(%rbp),%esi
   ff80a:	movl   $0x1,-0x8a0(%rbp)
   ff814:	mov    %rax,-0x8a8(%rbp)
   ff81b:	mov    -0xac0(%rbp),%eax
   ff821:	mov    -0xaf0(%rbp),%r9
   ff828:	mov    %eax,-0x89c(%rbp)
   ff82e:	mov    -0x89c(%rbp),%rdi
   ff835:	call   6f040 <__cudaPushCallConfiguration@plt>
   ff83a:	test   %eax,%eax
   ff83c:	jne    ff86d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x470d>
   ff83e:	sub    $0x130,%rsp
   ff845:	mov    0x2f90(%rbx),%r8
   ff84c:	mov    $0x25,%ecx
   ff851:	mov    -0xbb8(%rbp),%rsi
   ff858:	mov    %rsp,%rdi
   ff85b:	rep movsq %ds:(%rsi),%es:(%rdi)
   ff85e:	mov    %r8,%rdi
   ff861:	call   6adb0 <synreal::kernel::add_surface_contact_preconditioner(synreal::kernel::SurfaceContactView, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
   ff866:	add    $0x130,%rsp
   ff86d:	call   6c900 <cudaGetLastError@plt>
   ff872:	mov    %eax,%edi
   ff874:	lea    0xfb0dd(%rip),%rsi        # 1fa958 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5a58>
   ff87b:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ff880:	cmpb   $0x0,-0xada(%rbp)
   ff887:	je     fd73a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x25da>
   ff88d:	mov    0xfd6fc(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   ff894:	mov    -0xa88(%rbp),%rdi
   ff89b:	movl   $0x1,-0x8a0(%rbp)
   ff8a5:	mov    -0xaf0(%rbp),%r12
   ff8ac:	mov    %rax,-0x8a8(%rbp)
   ff8b3:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   ff8b8:	mov    %r15,-0x898(%rbp)
   ff8bf:	mov    -0x8a0(%rbp),%ecx
   ff8c5:	mov    %r12,%r9
   ff8c8:	xor    %r8d,%r8d
   ff8cb:	mov    %eax,-0x89c(%rbp)
   ff8d1:	mov    -0x8a8(%rbp),%rdx
   ff8d8:	mov    -0x89c(%rbp),%rdi
   ff8df:	mov    -0x894(%rbp),%esi
   ff8e5:	call   6f040 <__cudaPushCallConfiguration@plt>
   ff8ea:	test   %eax,%eax
   ff8ec:	jne    ff929 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x47c9>
   ff8ee:	mov    0x2f90(%rbx),%rcx
   ff8f5:	mov    0x3358(%rbx),%rdx
   ff8fc:	sub    $0x8,%rsp
   ff900:	mov    0x3318(%rbx),%rsi
   ff907:	mov    0x32d8(%rbx),%rdi
   ff90e:	push   -0xaa8(%rbp)
   ff914:	mov    -0xa90(%rbp),%r9
   ff91b:	mov    -0xa88(%rbp),%r8
   ff922:	call   6ac00 <synreal::kernel::add_triangle_drag_preconditioner(glm::vec<3, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   ff927:	pop    %rcx
   ff928:	pop    %rsi
   ff929:	call   6c900 <cudaGetLastError@plt>
   ff92e:	mov    %eax,%edi
   ff930:	lea    0xfb051(%rip),%rsi        # 1fa988 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5a88>
   ff937:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ff93c:	cmpb   $0x0,-0xace(%rbp)
   ff943:	je     fd747 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x25e7>
   ff949:	mov    0xfd640(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   ff950:	mov    -0xa68(%rbp),%rdi
   ff957:	movl   $0x1,-0x8a0(%rbp)
   ff961:	mov    -0xaf0(%rbp),%r12
   ff968:	mov    %rax,-0x8a8(%rbp)
   ff96f:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   ff974:	mov    %r15,-0x898(%rbp)
   ff97b:	mov    -0x8a0(%rbp),%ecx
   ff981:	mov    %r12,%r9
   ff984:	xor    %r8d,%r8d
   ff987:	mov    %eax,-0x89c(%rbp)
   ff98d:	mov    -0x8a8(%rbp),%rdx
   ff994:	mov    -0x89c(%rbp),%rdi
   ff99b:	mov    -0x894(%rbp),%esi
   ff9a1:	call   6f040 <__cudaPushCallConfiguration@plt>
   ff9a6:	test   %eax,%eax
   ff9a8:	jne    ffa15 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x48b5>
   ff9aa:	mov    0x56c(%rbx),%eax
   ff9b0:	sub    $0x8,%rsp
   ff9b4:	mov    0x3500(%rbx),%rcx
   ff9bb:	mov    0x34e0(%rbx),%rdx
   ff9c2:	mov    0x570(%rbx),%rsi
   ff9c9:	mov    0x3d0(%rbx),%rdi
   ff9d0:	push   -0xaa8(%rbp)
   ff9d6:	movss  -0xac4(%rbp),%xmm0
   ff9de:	push   %rax
   ff9df:	mov    0x568(%rbx),%eax
   ff9e5:	mov    0x3520(%rbx),%r8
   ff9ec:	push   %rax
   ff9ed:	push   -0xa68(%rbp)
   ff9f3:	push   0x2f90(%rbx)
   ff9f9:	push   0x3560(%rbx)
   ff9ff:	push   0x3540(%rbx)
   ffa05:	mov    0x5b0(%rbx),%r9
   ffa0c:	call   6a960 <synreal::kernel::add_joint_body_point_line_augmented_lagrangian_preconditioner(glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
   ffa11:	add    $0x40,%rsp
   ffa15:	call   6c900 <cudaGetLastError@plt>
   ffa1a:	mov    %eax,%edi
   ffa1c:	lea    0xfaf8d(%rip),%rsi        # 1fa9b0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5ab0>
   ffa23:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ffa28:	cmpb   $0x0,-0xacd(%rbp)
   ffa2f:	je     fd754 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x25f4>
   ffa35:	mov    0x5d4(%rbx),%r12d
   ffa3c:	imul   -0xa80(%rbp),%r12
   ffa44:	movl   $0x1,-0x8a0(%rbp)
   ffa4e:	mov    0xfd53b(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   ffa55:	mov    -0xaf0(%rbp),%r13
   ffa5c:	mov    %r12,%rdi
   ffa5f:	mov    %rax,-0x8a8(%rbp)
   ffa66:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   ffa6b:	mov    %r15,-0x898(%rbp)
   ffa72:	mov    -0x8a0(%rbp),%ecx
   ffa78:	mov    %r13,%r9
   ffa7b:	xor    %r8d,%r8d
   ffa7e:	mov    %eax,-0x89c(%rbp)
   ffa84:	mov    -0x8a8(%rbp),%rdx
   ffa8b:	mov    -0x89c(%rbp),%rdi
   ffa92:	mov    -0x894(%rbp),%esi
   ffa98:	call   6f040 <__cudaPushCallConfiguration@plt>
   ffa9d:	test   %eax,%eax
   ffa9f:	jne    ffb3c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x49dc>
   ffaa5:	mov    0x5d4(%rbx),%eax
   ffaab:	mov    0x5f0(%rbx),%rcx
   ffab2:	mov    0x5e0(%rbx),%rdx
   ffab9:	mov    0x3d0(%rbx),%rsi
   ffac0:	push   -0xaa8(%rbp)
   ffac6:	movss  0xfd4b2(%rip),%xmm0        # 1fcf80 <cuda::std::__4::in_place+0x33>
   fface:	push   %rax
   ffacf:	divss  -0xae4(%rbp),%xmm0
   ffad7:	push   %r12
   ffad9:	push   0x2f90(%rbx)
   ffadf:	push   0x680(%rbx)
   ffae5:	push   0x6a0(%rbx)
   ffaeb:	push   0x690(%rbx)
   ffaf1:	push   0x650(%rbx)
   ffaf7:	push   0x3620(%rbx)
   ffafd:	push   0x3600(%rbx)
   ffb03:	push   0x35e0(%rbx)
   ffb09:	push   0x35c0(%rbx)
   ffb0f:	push   0x35a0(%rbx)
   ffb15:	push   0x630(%rbx)
   ffb1b:	mov    0x620(%rbx),%r9
   ffb22:	mov    -0xaf8(%rbp),%rax
   ffb29:	mov    0x600(%rbx),%r8
   ffb30:	mov    (%rax),%rdi
   ffb33:	call   6acd0 <synreal::kernel::add_joint_drive_preconditioner(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, int const*, int const*, float const*, float const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   ffb38:	add    $0x70,%rsp
   ffb3c:	call   6c900 <cudaGetLastError@plt>
   ffb41:	mov    %eax,%edi
   ffb43:	lea    0xfae9e(%rip),%rsi        # 1fa9e8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5ae8>
   ffb4a:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ffb4f:	jmp    fd754 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x25f4>
   ffb54:	nopl   0x0(%rax)
   ffb58:	mov    0x2f90(%rbx),%rsi
   ffb5f:	mov    -0xaf0(%rbp),%rdx
   ffb66:	lea    0x1758(%rbx),%rdi
   ffb6d:	call   6dbf0 <synreal::Fluid::add_preconditioner(glm::mat<3, 3, float, (glm::qualifier)0>*, CUstream_st*) const@plt>
   ffb72:	jmp    fd712 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x25b2>
   ffb77:	nopw   0x0(%rax,%rax,1)
   ffb80:	mov    0x2f90(%rbx),%rsi
   ffb87:	mov    -0xaf0(%rbp),%rdx
   ffb8e:	lea    0x920(%rbx),%rdi
   ffb95:	call   6cff0 <synreal::SelfCollision::add_preconditioner(glm::mat<3, 3, float, (glm::qualifier)0>*, CUstream_st*) const@plt>
   ffb9a:	jmp    fd702 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x25a2>
   ffb9f:	nop
   ffba0:	mov    0xfd3e9(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   ffba7:	mov    -0xa60(%rbp),%rdi
   ffbae:	movl   $0x1,-0x8a0(%rbp)
   ffbb8:	mov    -0xaf0(%rbp),%r12
   ffbbf:	mov    %rax,-0x8a8(%rbp)
   ffbc6:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   ffbcb:	mov    %r15,-0x898(%rbp)
   ffbd2:	mov    -0x8a0(%rbp),%ecx
   ffbd8:	mov    %r12,%r9
   ffbdb:	xor    %r8d,%r8d
   ffbde:	mov    %eax,-0x89c(%rbp)
   ffbe4:	mov    -0x8a8(%rbp),%rdx
   ffbeb:	mov    -0x89c(%rbp),%rdi
   ffbf2:	mov    -0x894(%rbp),%esi
   ffbf8:	call   6f040 <__cudaPushCallConfiguration@plt>
   ffbfd:	test   %eax,%eax
   ffbff:	jne    ffc5e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4afe>
   ffc01:	mov    0x318(%rbx),%eax
   ffc07:	sub    $0x8,%rsp
   ffc0b:	mov    0x320(%rbx),%rcx
   ffc12:	mov    0x350(%rbx),%rdx
   ffc19:	mov    0x340(%rbx),%rsi
   ffc20:	push   -0xaa8(%rbp)
   ffc26:	mov    0x2f90(%rbx),%r9
   ffc2d:	push   %rax
   ffc2e:	mov    -0xaf8(%rbp),%rax
   ffc35:	push   -0xa60(%rbp)
   ffc3b:	mov    0x330(%rbx),%r8
   ffc42:	mov    (%rax),%rdi
   ffc45:	movss  0xfd333(%rip),%xmm0        # 1fcf80 <cuda::std::__4::in_place+0x33>
   ffc4d:	divss  -0xae4(%rbp),%xmm0
   ffc55:	call   6a7d0 <synreal::kernel::add_bending_damping_preconditioner(glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, float, (glm::qualifier)0> const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   ffc5a:	add    $0x20,%rsp
   ffc5e:	call   6c900 <cudaGetLastError@plt>
   ffc63:	mov    %eax,%edi
   ffc65:	lea    0xfacb4(%rip),%rsi        # 1fa920 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5a20>
   ffc6c:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ffc71:	jmp    fd6f5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2595>
   ffc76:	cs nopw 0x0(%rax,%rax,1)
   ffc80:	mov    0xfd309(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   ffc87:	mov    -0xa98(%rbp),%rdi
   ffc8e:	movl   $0x1,-0x8a0(%rbp)
   ffc98:	mov    -0xaf0(%rbp),%r12
   ffc9f:	mov    %rax,-0x8a8(%rbp)
   ffca6:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   ffcab:	mov    %r15,-0x898(%rbp)
   ffcb2:	mov    -0x8a0(%rbp),%ecx
   ffcb8:	mov    %r12,%r9
   ffcbb:	xor    %r8d,%r8d
   ffcbe:	mov    %eax,-0x89c(%rbp)
   ffcc4:	mov    -0x8a8(%rbp),%rdx
   ffccb:	mov    -0x89c(%rbp),%rdi
   ffcd2:	mov    -0x894(%rbp),%esi
   ffcd8:	call   6f040 <__cudaPushCallConfiguration@plt>
   ffcdd:	test   %eax,%eax
   ffcdf:	jne    ffd3e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4bde>
   ffce1:	mov    0x2e0(%rbx),%eax
   ffce7:	sub    $0x8,%rsp
   ffceb:	mov    0x308(%rbx),%rcx
   ffcf2:	mov    0x2f8(%rbx),%rdx
   ffcf9:	mov    0x2e8(%rbx),%rsi
   ffd00:	push   -0xaa8(%rbp)
   ffd06:	mov    0x2f90(%rbx),%r9
   ffd0d:	push   %rax
   ffd0e:	mov    -0xaf8(%rbp),%rax
   ffd15:	push   -0xa98(%rbp)
   ffd1b:	mov    0x33c0(%rbx),%r8
   ffd22:	mov    (%rax),%rdi
   ffd25:	movss  0xfd253(%rip),%xmm0        # 1fcf80 <cuda::std::__4::in_place+0x33>
   ffd2d:	divss  -0xae4(%rbp),%xmm0
   ffd35:	call   6aa60 <synreal::kernel::add_tetrahedron_preconditioner(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   ffd3a:	add    $0x20,%rsp
   ffd3e:	call   6c900 <cudaGetLastError@plt>
   ffd43:	mov    %eax,%edi
   ffd45:	lea    0xfab9c(%rip),%rsi        # 1fa8e8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x59e8>
   ffd4c:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ffd51:	jmp    fd6e8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2588>
   ffd56:	cs nopw 0x0(%rax,%rax,1)
   ffd60:	mov    0xfd229(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   ffd67:	mov    -0xa78(%rbp),%rdi
   ffd6e:	movl   $0x1,-0x8a0(%rbp)
   ffd78:	mov    -0xaf0(%rbp),%r12
   ffd7f:	mov    %rax,-0x8a8(%rbp)
   ffd86:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   ffd8b:	mov    %r15,-0x898(%rbp)
   ffd92:	mov    -0x8a0(%rbp),%ecx
   ffd98:	mov    %r12,%r9
   ffd9b:	xor    %r8d,%r8d
   ffd9e:	mov    %eax,-0x89c(%rbp)
   ffda4:	mov    -0x8a8(%rbp),%rdx
   ffdab:	mov    -0x89c(%rbp),%rdi
   ffdb2:	mov    -0x894(%rbp),%esi
   ffdb8:	call   6f040 <__cudaPushCallConfiguration@plt>
   ffdbd:	test   %eax,%eax
   ffdbf:	jne    ffe10 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4cb0>
   ffdc1:	mov    0x398(%rbx),%eax
   ffdc7:	movss  0xc(%rbx),%xmm0
   ffdcc:	mulss  -0xacc(%rbp),%xmm0
   ffdd4:	mov    0x3a0(%rbx),%rdx
   ffddb:	mov    0x3d0(%rbx),%rsi
   ffde2:	push   -0xaa8(%rbp)
   ffde8:	mov    -0xa78(%rbp),%r9
   ffdef:	push   %rax
   ffdf0:	mov    -0xaf8(%rbp),%rax
   ffdf7:	mov    0x2f90(%rbx),%r8
   ffdfe:	mov    -0xabc(%rbp),%ecx
   ffe04:	mov    (%rax),%rdi
   ffe07:	call   6aa20 <synreal::kernel::add_affine_body_constitutive_preconditioner(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, float, synreal::AffineBodyRigidityModel, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   ffe0c:	pop    %r11
   ffe0e:	pop    %r12
   ffe10:	call   6c900 <cudaGetLastError@plt>
   ffe15:	mov    %eax,%edi
   ffe17:	lea    0xfaa5a(%rip),%rsi        # 1fa878 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5978>
   ffe1e:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ffe23:	jmp    fd6c5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2565>
   ffe28:	nopl   0x0(%rax,%rax,1)
   ffe30:	mov    0xfd159(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   ffe37:	mov    -0xa78(%rbp),%rdi
   ffe3e:	movl   $0x1,-0x8a0(%rbp)
   ffe48:	mov    %rax,-0x8a8(%rbp)
   ffe4f:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
   ffe54:	mov    %r15,-0x898(%rbp)
   ffe5b:	mov    -0x8a0(%rbp),%ecx
   ffe61:	mov    %r12,%r9
   ffe64:	xor    %r8d,%r8d
   ffe67:	mov    %eax,-0x89c(%rbp)
   ffe6d:	mov    -0x8a8(%rbp),%rdx
   ffe74:	mov    -0x89c(%rbp),%rdi
   ffe7b:	mov    -0x894(%rbp),%esi
   ffe81:	call   6f040 <__cudaPushCallConfiguration@plt>
   ffe86:	test   %eax,%eax
   ffe88:	jne    ffed8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4d78>
   ffe8a:	mov    0x398(%rbx),%eax
   ffe90:	movss  0xc(%rbx),%xmm0
   ffe95:	mulss  -0xacc(%rbp),%xmm0
   ffe9d:	mov    0x3a0(%rbx),%rdx
   ffea4:	mov    0x3d0(%rbx),%rsi
   ffeab:	push   -0xaa8(%rbp)
   ffeb1:	mov    -0xa78(%rbp),%r9
   ffeb8:	push   %rax
   ffeb9:	mov    -0xaf8(%rbp),%rax
   ffec0:	mov    0x3070(%rbx),%r8
   ffec7:	mov    -0xabc(%rbp),%ecx
   ffecd:	mov    (%rax),%rdi
   ffed0:	call   6a9d0 <synreal::kernel::evaluate_affine_body_constitutive_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, float, synreal::AffineBodyRigidityModel, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   ffed5:	pop    %rdi
   ffed6:	pop    %r8
   ffed8:	call   6c900 <cudaGetLastError@plt>
   ffedd:	mov    %eax,%edi
   ffedf:	lea    0xfa682(%rip),%rsi        # 1fa568 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5668>
   ffee6:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ffeeb:	mov    -0xaf0(%rbp),%r12
   ffef2:	jmp    fcffe <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1e9e>
   ffef7:	nopw   0x0(%rax,%rax,1)
   fff00:	mov    0x2df0(%rbx),%rsi
   fff07:	mov    %r12,%r8
   fff0a:	mov    $0x3,%ecx
   fff0f:	mov    %rax,%rdi
   fff12:	mov    -0xbd8(%rbp),%rdx
   fff19:	call   6e130 <cudaMemcpyAsync@plt>
   fff1e:	mov    %eax,%edi
   fff20:	lea    0xfa749(%rip),%rsi        # 1fa670 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5770>
   fff27:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fff2c:	mov    0x2e10(%rbx),%rax
   fff33:	mov    -0xaf0(%rbp),%r12
   fff3a:	mov    %rax,-0xb70(%rbp)
   fff41:	jmp    fd10b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1fab>
   fff46:	cs nopw 0x0(%rax,%rax,1)
   fff50:	mov    0xfd039(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fff57:	xor    %r8d,%r8d
   fff5a:	mov    $0x1,%ecx
   fff5f:	mov    %r15,-0x898(%rbp)
   fff66:	mov    0xfd023(%rip),%rdx        # 1fcf90 <cuda::std::__4::in_place+0x43>
   fff6d:	mov    -0x894(%rbp),%esi
   fff73:	movl   $0x1,-0x8a0(%rbp)
   fff7d:	mov    %rax,-0x8a8(%rbp)
   fff84:	mov    -0xac0(%rbp),%eax
   fff8a:	mov    -0xaf0(%rbp),%r9
   fff91:	mov    %eax,-0x89c(%rbp)
   fff97:	mov    -0x89c(%rbp),%rdi
   fff9e:	call   6f040 <__cudaPushCallConfiguration@plt>
   fffa3:	test   %eax,%eax
   fffa5:	jne    fffd6 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4e76>
   fffa7:	sub    $0x130,%rsp
   fffae:	mov    0x2f30(%rbx),%r8
   fffb5:	mov    $0x25,%ecx
   fffba:	mov    -0xbb8(%rbp),%rsi
   fffc1:	mov    %rsp,%rdi
   fffc4:	rep movsq %ds:(%rsi),%es:(%rdi)
   fffc7:	mov    %r8,%rdi
   fffca:	call   6ac10 <synreal::kernel::add_surface_contact_stiffness_scale(synreal::kernel::SurfaceContactView, float*)@plt>
   fffcf:	add    $0x130,%rsp
   fffd6:	call   6c900 <cudaGetLastError@plt>
   fffdb:	mov    %eax,%edi
   fffdd:	lea    0xfa34c(%rip),%rsi        # 1fa330 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5430>
   fffe4:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fffe9:	jmp    fcabe <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x195e>
   fffee:	xchg   %ax,%ax
   ffff0:	mov    0x568(%rbx),%eax
   ffff6:	mov    -0xaf8(%rbp),%rdi
   ffffd:	sub    $0x8,%rsp
  100001:	mov    0x570(%rbx),%rcx
  100008:	mov    0x3d0(%rbx),%rdx
  10000f:	mov    0x10(%rdi),%rsi
  100013:	push   -0xaa8(%rbp)
  100019:	movss  -0xac4(%rbp),%xmm0
  100021:	push   %rax
  100022:	xor    %eax,%eax
  100024:	cmpl   $0x1,-0xb1c(%rbp)
  10002b:	push   %r13
  10002d:	setne  %al
  100030:	push   %r12
  100032:	push   %rax
  100033:	mov    0x56c(%rbx),%eax
  100039:	push   %rax
  10003a:	push   0x5c0(%rbx)
  100040:	push   0x5b0(%rbx)
  100046:	push   0x5a0(%rbx)
  10004c:	push   0x590(%rbx)
  100052:	mov    (%rdi),%rdi
  100055:	push   0x3520(%rbx)
  10005b:	mov    0x3500(%rbx),%r9
  100062:	mov    0x34e0(%rbx),%r8
  100069:	call   6afa0 <synreal::kernel::evaluate_body_point_line_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float, unsigned long, bool, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  10006e:	add    $0x60,%rsp
  100072:	jmp    fccbb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1b5b>
  100077:	nopw   0x0(%rax,%rax,1)
  100080:	mov    0x498(%rbx),%eax
  100086:	sub    $0x8,%rsp
  10008a:	mov    0x4b0(%rbx),%rcx
  100091:	mov    0x4a0(%rbx),%rdx
  100098:	mov    0x3d0(%rbx),%rsi
  10009f:	push   -0xaa8(%rbp)
  1000a5:	movss  -0xac4(%rbp),%xmm0
  1000ad:	push   %rax
  1000ae:	xor    %eax,%eax
  1000b0:	cmpl   $0x1,-0xb1c(%rbp)
  1000b7:	push   %r13
  1000b9:	setne  %al
  1000bc:	push   %r12
  1000be:	mov    0x4c0(%rbx),%r8
  1000c5:	push   %rax
  1000c6:	mov    0x49c(%rbx),%eax
  1000cc:	push   %rax
  1000cd:	mov    -0xaf8(%rbp),%rax
  1000d4:	push   0x4e0(%rbx)
  1000da:	mov    (%rax),%rdi
  1000dd:	push   0x4d0(%rbx)
  1000e3:	push   0x3420(%rbx)
  1000e9:	mov    0x3400(%rbx),%r9
  1000f0:	call   6ada0 <synreal::kernel::evaluate_body_spring_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, float const*, float, unsigned long, bool, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  1000f5:	add    $0x50,%rsp
  1000f9:	jmp    fcb4e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x19ee>
  1000fe:	xchg   %ax,%ax
  100100:	mov    0x5dc(%rbx),%eax
  100106:	mov    0x3270(%rbx),%rcx
  10010d:	mov    0x32b0(%rbx),%rdx
  100114:	mov    0x3090(%rbx),%rsi
  10011b:	push   %rax
  10011c:	mov    0x5d8(%rbx),%eax
  100122:	movss  0xfce56(%rip),%xmm0        # 1fcf80 <cuda::std::__4::in_place+0x33>
  10012a:	divss  -0xae4(%rbp),%xmm0
  100132:	push   %rax
  100133:	mov    0x5d4(%rbx),%eax
  100139:	push   -0xaa8(%rbp)
  10013f:	push   %rax
  100140:	mov    -0xb88(%rbp),%rax
  100147:	push   %r13
  100149:	push   %r12
  10014b:	push   0x20(%rax)
  10014e:	push   0x10(%rax)
  100151:	push   (%rax)
  100153:	push   0x6a0(%rbx)
  100159:	push   0x690(%rbx)
  10015f:	push   0x6c0(%rbx)
  100165:	push   0x680(%rbx)
  10016b:	push   0x670(%rbx)
  100171:	push   0x660(%rbx)
  100177:	mov    -0xaf8(%rbp),%rax
  10017e:	push   0x650(%rbx)
  100184:	mov    0x3d0(%rbx),%r9
  10018b:	push   0x3620(%rbx)
  100191:	push   0x3600(%rbx)
  100197:	push   0x35e0(%rbx)
  10019d:	push   0x35c0(%rbx)
  1001a3:	push   0x35a0(%rbx)
  1001a9:	push   0x630(%rbx)
  1001af:	push   0x620(%rbx)
  1001b5:	push   0x600(%rbx)
  1001bb:	mov    (%rax),%rdi
  1001be:	push   0x5f0(%rbx)
  1001c4:	push   0x5e0(%rbx)
  1001ca:	mov    0x3290(%rbx),%r8
  1001d1:	call   6ab60 <synreal::kernel::evaluate_joint_drive_load(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float*, int*, glm::vec<4, int, (glm::qualifier)0> const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, int const*, int const*, float const*, float const*, float const*, int const*, float const*, float const*, float const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, float)@plt>
  1001d6:	add    $0xd0,%rsp
  1001dd:	jmp    fcd87 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1c27>
  1001e2:	nopw   0x0(%rax,%rax,1)
  1001e8:	mov    -0x850(%rbp),%rax
  1001ef:	mov    -0x830(%rbp),%rdx
  1001f6:	mov    %r12,%r9
  1001f9:	xor    %r8d,%r8d
  1001fc:	movss  0xfcd7c(%rip),%xmm0        # 1fcf80 <cuda::std::__4::in_place+0x33>
  100204:	mov    0x32b0(%rax),%rcx
  10020b:	mov    0x6b0(%rax),%rdi
  100212:	divss  (%rdx),%xmm0
  100216:	mov    0x3090(%rax),%rdx
  10021d:	mov    -0x848(%rbp),%rax
  100224:	push   $0x0
  100226:	push   0x70(%rax)
  100229:	push   0x68(%rax)
  10022c:	push   0x60(%rax)
  10022f:	push   0x58(%rax)
  100232:	push   0x50(%rax)
  100235:	push   0x48(%rax)
  100238:	push   0x40(%rax)
  10023b:	push   0x38(%rax)
  10023e:	push   0x30(%rax)
  100241:	push   0x28(%rax)
  100244:	push   0x20(%rax)
  100247:	push   0x18(%rax)
  10024a:	push   0x10(%rax)
  10024d:	push   0x8(%rax)
  100250:	push   (%rax)
  100252:	mov    -0x838(%rbp),%rax
  100259:	mov    (%rax),%rsi
  10025c:	call   6af10 <synreal::kernel::evaluate_joint_armature(synreal::kernel::JointCoordinateView, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  100261:	sub    $0xffffffffffffff80,%rsp
  100265:	jmp    fce21 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1cc1>
  10026a:	nopw   0x0(%rax,%rax,1)
  100270:	mov    -0x7c0(%rbp),%rax
  100277:	xor    %r8d,%r8d
  10027a:	mov    %r12,%rcx
  10027d:	xor    %edx,%edx
  10027f:	movss  0xfccf9(%rip),%xmm0        # 1fcf80 <cuda::std::__4::in_place+0x33>
  100287:	divss  (%rax),%xmm0
  10028b:	mov    -0x7c8(%rbp),%rax
  100292:	mov    0x3090(%rax),%rsi
  100299:	mov    -0x7d8(%rbp),%rax
  1002a0:	push   0x98(%rax)
  1002a6:	push   0x90(%rax)
  1002ac:	push   0x88(%rax)
  1002b2:	push   0x80(%rax)
  1002b8:	push   0x78(%rax)
  1002bb:	push   0x70(%rax)
  1002be:	push   0x68(%rax)
  1002c1:	push   0x60(%rax)
  1002c4:	push   0x58(%rax)
  1002c7:	push   0x50(%rax)
  1002ca:	push   0x48(%rax)
  1002cd:	push   0x40(%rax)
  1002d0:	push   0x38(%rax)
  1002d3:	push   0x30(%rax)
  1002d6:	push   0x28(%rax)
  1002d9:	push   0x20(%rax)
  1002dc:	push   0x18(%rax)
  1002df:	push   0x10(%rax)
  1002e2:	push   0x8(%rax)
  1002e5:	push   (%rax)
  1002e7:	mov    -0x7d0(%rbp),%rax
  1002ee:	mov    (%rax),%rdi
  1002f1:	call   6aa80 <synreal::kernel::evaluate_cables(synreal::kernel::CableView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  1002f6:	add    $0xa0,%rsp
  1002fd:	jmp    fceb6 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1d56>
  100302:	nopw   0x0(%rax,%rax,1)
  100308:	mov    0xfcc81(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
  10030f:	mov    -0xa78(%rbp),%rdi
  100316:	movl   $0x1,-0x8a0(%rbp)
  100320:	mov    -0xaf0(%rbp),%r12
  100327:	mov    %rax,-0x8a8(%rbp)
  10032e:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
  100333:	mov    %r15,-0x898(%rbp)
  10033a:	mov    -0x8a0(%rbp),%ecx
  100340:	mov    %r12,%r9
  100343:	xor    %r8d,%r8d
  100346:	mov    %eax,-0x89c(%rbp)
  10034c:	mov    -0x8a8(%rbp),%rdx
  100353:	mov    -0x89c(%rbp),%rdi
  10035a:	mov    -0x894(%rbp),%esi
  100360:	call   6f040 <__cudaPushCallConfiguration@plt>
  100365:	test   %eax,%eax
  100367:	jne    1003b3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5253>
  100369:	movss  0xc(%rbx),%xmm0
  10036e:	mulss  -0xacc(%rbp),%xmm0
  100376:	sub    $0x8,%rsp
  10037a:	mov    0x2f90(%rbx),%rcx
  100381:	mov    0x3380(%rbx),%rdx
  100388:	mov    0x3a0(%rbx),%rsi
  10038f:	mov    0x3d0(%rbx),%rdi
  100396:	push   -0xaa8(%rbp)
  10039c:	mov    0x398(%rbx),%r9d
  1003a3:	mov    -0xa78(%rbp),%r8
  1003aa:	call   6acb0 <synreal::kernel::add_affine_body_so3_augmented_lagrangian_preconditioner(glm::vec<4, int, (glm::qualifier)0> const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  1003af:	pop    %r12
  1003b1:	pop    %r13
  1003b3:	call   6c900 <cudaGetLastError@plt>
  1003b8:	mov    %eax,%edi
  1003ba:	lea    0xfa6a7(%rip),%rsi        # 1faa68 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5b68>
  1003c1:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  1003c6:	jmp    fde8c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2d2c>
  1003cb:	nopl   0x0(%rax,%rax,1)
  1003d0:	mov    -0xaf8(%rbp),%rax
  1003d7:	movss  0x48(%rbx),%xmm0
  1003dc:	push   -0xb58(%rbp)
  1003e2:	mov    0x28(%r14),%rcx
  1003e6:	push   %r13
  1003e8:	mov    0x18(%r14),%rdx
  1003ec:	mov    0x10(%r14),%esi
  1003f0:	push   -0xb60(%rbp)
  1003f6:	push   0x10(%rax)
  1003f9:	push   (%rax)
  1003fb:	mov    0x398(%rbx),%eax
  100401:	push   -0xaa8(%rbp)
  100407:	push   %rax
  100408:	mov    -0xac8(%rbp),%eax
  10040e:	push   0x3e0(%rbx)
  100414:	push   0x3d0(%rbx)
  10041a:	push   0x3f0(%rbx)
  100420:	push   -0xa80(%rbp)
  100426:	push   %rax
  100427:	mov    0x710(%rbx),%eax
  10042d:	push   %rax
  10042e:	push   0x788(%rbx)
  100434:	push   0x778(%rbx)
  10043a:	mov    0x48(%r14),%r9
  10043e:	push   0x768(%rbx)
  100444:	mov    0x38(%r14),%r8
  100448:	push   0x758(%rbx)
  10044e:	mov    (%r14),%rdi
  100451:	push   0x748(%rbx)
  100457:	movss  0xfcb21(%rip),%xmm1        # 1fcf80 <cuda::std::__4::in_place+0x33>
  10045f:	push   0x738(%rbx)
  100465:	divss  -0xb70(%rbp),%xmm1
  10046d:	push   0x728(%rbx)
  100473:	push   0x718(%rbx)
  100479:	push   0x98(%r14)
  100480:	push   0x88(%r14)
  100487:	push   0x78(%r14)
  10048b:	push   0x68(%r14)
  10048f:	push   0x58(%r14)
  100493:	call   6a8f0 <synreal::kernel::evaluate_contact_force(int const*, unsigned long, int const*, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, int const*, int const*, synreal::Transform const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float const*, float const*, float, unsigned long, unsigned long, unsigned long, int const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, unsigned long, unsigned long, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, float*)@plt>
  100498:	add    $0xd0,%rsp
  10049f:	jmp    fc694 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1534>
  1004a4:	nopl   0x0(%rax)
  1004a8:	mov    0xfcae1(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
  1004af:	mov    -0xa78(%rbp),%rdi
  1004b6:	movl   $0x1,-0x8a0(%rbp)
  1004c0:	mov    -0xaf0(%rbp),%r12
  1004c7:	mov    %rax,-0x8a8(%rbp)
  1004ce:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
  1004d3:	mov    %r15,-0x898(%rbp)
  1004da:	mov    -0x8a0(%rbp),%ecx
  1004e0:	mov    %r12,%r9
  1004e3:	xor    %r8d,%r8d
  1004e6:	mov    %eax,-0x89c(%rbp)
  1004ec:	mov    -0x8a8(%rbp),%rdx
  1004f3:	mov    -0x89c(%rbp),%rdi
  1004fa:	mov    -0x894(%rbp),%esi
  100500:	call   6f040 <__cudaPushCallConfiguration@plt>
  100505:	test   %eax,%eax
  100507:	jne    100553 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x53f3>
  100509:	movss  0xc(%rbx),%xmm0
  10050e:	mulss  -0xacc(%rbp),%xmm0
  100516:	sub    $0x8,%rsp
  10051a:	mov    0x2f90(%rbx),%rcx
  100521:	mov    0x3380(%rbx),%rdx
  100528:	mov    0x3a0(%rbx),%rsi
  10052f:	mov    0x3d0(%rbx),%rdi
  100536:	push   -0xaa8(%rbp)
  10053c:	mov    0x398(%rbx),%r9d
  100543:	mov    -0xa78(%rbp),%r8
  10054a:	call   6acb0 <synreal::kernel::add_affine_body_so3_augmented_lagrangian_preconditioner(glm::vec<4, int, (glm::qualifier)0> const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  10054f:	pop    %r9
  100551:	pop    %r10
  100553:	call   6c900 <cudaGetLastError@plt>
  100558:	mov    %eax,%edi
  10055a:	lea    0xfa34f(%rip),%rsi        # 1fa8b0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x59b0>
  100561:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  100566:	jmp    fd6db <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x257b>
  10056b:	cmpb   $0x0,-0xad9(%rbp)
  100572:	je     fd4a7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2347>
  100578:	nopl   0x0(%rax,%rax,1)
  100580:	mov    0x2f70(%rbx),%rax
  100587:	mov    0x2f90(%rbx),%r13
  10058e:	mov    %rax,-0xb70(%rbp)
  100595:	mov    -0x7a0(%rbp),%rax
  10059c:	mov    (%rax),%r12
  10059f:	mov    -0x7a8(%rbp),%rax
  1005a6:	mov    0x10(%rax),%edi
  1005a9:	mov    -0x7b0(%rbp),%rax
  1005b0:	cmpb   $0x0,(%rax)
  1005b3:	mov    0xfc9d6(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
  1005ba:	movl   $0x1,-0x8a0(%rbp)
  1005c4:	mov    %rax,-0x8a8(%rbp)
  1005cb:	jne    101940 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x67e0>
  1005d1:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
  1005d6:	mov    %r15,-0x898(%rbp)
  1005dd:	mov    -0x8a0(%rbp),%ecx
  1005e3:	mov    %r12,%r9
  1005e6:	xor    %r8d,%r8d
  1005e9:	mov    %eax,-0x89c(%rbp)
  1005ef:	mov    -0x8a8(%rbp),%rdx
  1005f6:	mov    -0x89c(%rbp),%rdi
  1005fd:	mov    -0x894(%rbp),%esi
  100603:	call   6f040 <__cudaPushCallConfiguration@plt>
  100608:	test   %eax,%eax
  10060a:	je     1025f0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7490>
  100610:	call   6c900 <cudaGetLastError@plt>
  100615:	mov    %eax,%edi
  100617:	lea    0xfa232(%rip),%rsi        # 1fa850 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5950>
  10061e:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  100623:	jmp    fd4a7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2347>
  100628:	nopl   0x0(%rax,%rax,1)
  100630:	mov    -0x850(%rbp),%rax
  100637:	mov    -0x830(%rbp),%rdx
  10063e:	xor    %r9d,%r9d
  100641:	xor    %r8d,%r8d
  100644:	movss  0xfc934(%rip),%xmm0        # 1fcf80 <cuda::std::__4::in_place+0x33>
  10064c:	mov    0x32b0(%rax),%rcx
  100653:	mov    0x6b0(%rax),%rdi
  10065a:	divss  (%rdx),%xmm0
  10065e:	mov    0x3090(%rax),%rdx
  100665:	mov    -0x848(%rbp),%rax
  10066c:	push   %r12
  10066e:	push   0x70(%rax)
  100671:	push   0x68(%rax)
  100674:	push   0x60(%rax)
  100677:	push   0x58(%rax)
  10067a:	push   0x50(%rax)
  10067d:	push   0x48(%rax)
  100680:	push   0x40(%rax)
  100683:	push   0x38(%rax)
  100686:	push   0x30(%rax)
  100689:	push   0x28(%rax)
  10068c:	push   0x20(%rax)
  10068f:	push   0x18(%rax)
  100692:	push   0x10(%rax)
  100695:	push   0x8(%rax)
  100698:	push   (%rax)
  10069a:	mov    -0x838(%rbp),%rax
  1006a1:	mov    (%rax),%rsi
  1006a4:	call   6af10 <synreal::kernel::evaluate_joint_armature(synreal::kernel::JointCoordinateView, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  1006a9:	sub    $0xffffffffffffff80,%rsp
  1006ad:	jmp    fd7db <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x267b>
  1006b2:	nopw   0x0(%rax,%rax,1)
  1006b8:	mov    0x4f0(%rbx),%eax
  1006be:	movss  0xc(%rbx),%xmm0
  1006c3:	mulss  -0xacc(%rbp),%xmm0
  1006cb:	mov    0x508(%rbx),%rcx
  1006d2:	mov    0x4f8(%rbx),%rdx
  1006d9:	mov    0x3d0(%rbx),%rsi
  1006e0:	push   -0xaa8(%rbp)
  1006e6:	push   %rax
  1006e7:	mov    -0xaf8(%rbp),%rax
  1006ee:	push   -0xb80(%rbp)
  1006f4:	push   %r12
  1006f6:	push   0x34c0(%rbx)
  1006fc:	push   0x34a0(%rbx)
  100702:	mov    0x518(%rbx),%r8
  100709:	push   0x548(%rbx)
  10070f:	mov    (%rax),%rdi
  100712:	push   0x3480(%rbx)
  100718:	mov    0x3460(%rbx),%r9
  10071f:	call   6a8c0 <synreal::kernel::evaluate_body_distance_constraint_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  100724:	add    $0x40,%rsp
  100728:	jmp    fcc16 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ab6>
  10072d:	nopl   (%rax)
  100730:	mov    -0x818(%rbp),%rax
  100737:	mov    -0x7f8(%rbp),%rdx
  10073e:	mov    %r12,%r9
  100741:	xor    %r8d,%r8d
  100744:	movss  0xfc834(%rip),%xmm0        # 1fcf80 <cuda::std::__4::in_place+0x33>
  10074c:	mov    0x3290(%rax),%rcx
  100753:	mov    0x3090(%rax),%rsi
  10075a:	divss  (%rdx),%xmm0
  10075e:	mov    0x3270(%rax),%rdx
  100765:	mov    -0x810(%rbp),%rax
  10076c:	push   $0x0
  10076e:	push   -0x878(%rbp)
  100774:	push   -0x880(%rbp)
  10077a:	push   -0x888(%rbp)
  100780:	push   -0x890(%rbp)
  100786:	push   0x70(%rax)
  100789:	push   0x68(%rax)
  10078c:	push   0x60(%rax)
  10078f:	push   0x58(%rax)
  100792:	push   0x50(%rax)
  100795:	push   0x48(%rax)
  100798:	push   0x40(%rax)
  10079b:	push   0x38(%rax)
  10079e:	push   0x30(%rax)
  1007a1:	push   0x28(%rax)
  1007a4:	push   0x20(%rax)
  1007a7:	push   0x18(%rax)
  1007aa:	push   0x10(%rax)
  1007ad:	push   0x8(%rax)
  1007b0:	push   (%rax)
  1007b2:	mov    -0x800(%rbp),%rax
  1007b9:	mov    (%rax),%rdi
  1007bc:	call   6ac60 <synreal::kernel::evaluate_angular_limits(synreal::kernel::JointCoordinateView, synreal::kernel::AngularLimitView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, int const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  1007c1:	add    $0xa0,%rsp
  1007c8:	jmp    fcf8d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1e2d>
  1007cd:	nopl   (%rax)
  1007d0:	imul   -0xa80(%rbp),%r13
  1007d8:	mov    0xfc7b1(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
  1007df:	movl   $0x1,-0x8a0(%rbp)
  1007e9:	mov    %rax,-0x8a8(%rbp)
  1007f0:	mov    %r13,%rdi
  1007f3:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
  1007f8:	mov    %r15,-0x898(%rbp)
  1007ff:	mov    -0x8a0(%rbp),%ecx
  100805:	mov    %r12,%r9
  100808:	xor    %r8d,%r8d
  10080b:	mov    %eax,-0x89c(%rbp)
  100811:	mov    -0x8a8(%rbp),%rdx
  100818:	mov    -0x89c(%rbp),%rdi
  10081f:	mov    -0x894(%rbp),%esi
  100825:	call   6f040 <__cudaPushCallConfiguration@plt>
  10082a:	test   %eax,%eax
  10082c:	jne    10088f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x572f>
  10082e:	mov    0x278(%rbx),%eax
  100834:	sub    $0x8,%rsp
  100838:	mov    0x290(%rbx),%rcx
  10083f:	mov    0x2a0(%rbx),%rdx
  100846:	mov    0x280(%rbx),%rsi
  10084d:	push   -0xaa0(%rbp)
  100853:	mov    -0xb58(%rbp),%r9
  10085a:	push   -0xaa8(%rbp)
  100860:	mov    0x2c0(%rbx),%r8
  100867:	push   %rax
  100868:	mov    -0xaf8(%rbp),%rax
  10086f:	push   %r13
  100871:	push   -0xb60(%rbp)
  100877:	mov    (%rax),%rdi
  10087a:	push   -0xb70(%rbp)
  100880:	push   -0xb90(%rbp)
  100886:	call   6ae20 <synreal::kernel::add_cloth_membrane_gauss_newton_hessian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, glm::mat<2, 2, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
  10088b:	add    $0x40,%rsp
  10088f:	call   6c900 <cudaGetLastError@plt>
  100894:	mov    %eax,%edi
  100896:	lea    0xf9dfb(%rip),%rsi        # 1fa698 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5798>
  10089d:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  1008a2:	mov    0x240(%rbx),%r13d
  1008a9:	mov    -0xaf0(%rbp),%r12
  1008b0:	test   %r13d,%r13d
  1008b3:	je     fd163 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2003>
  1008b9:	imul   -0xa80(%rbp),%r13
  1008c1:	mov    0xfc6c8(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
  1008c8:	movl   $0x1,-0x8a0(%rbp)
  1008d2:	mov    %rax,-0x8a8(%rbp)
  1008d9:	mov    %r13,%rdi
  1008dc:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
  1008e1:	mov    %r15,-0x898(%rbp)
  1008e8:	mov    -0x8a0(%rbp),%ecx
  1008ee:	mov    %r12,%r9
  1008f1:	xor    %r8d,%r8d
  1008f4:	mov    %eax,-0x89c(%rbp)
  1008fa:	mov    -0x8a8(%rbp),%rdx
  100901:	mov    -0x89c(%rbp),%rdi
  100908:	mov    -0x894(%rbp),%esi
  10090e:	call   6f040 <__cudaPushCallConfiguration@plt>
  100913:	test   %eax,%eax
  100915:	jne    10096e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x580e>
  100917:	mov    0x240(%rbx),%eax
  10091d:	mov    0x268(%rbx),%rcx
  100924:	mov    0x258(%rbx),%rdx
  10092b:	mov    0x248(%rbx),%rsi
  100932:	push   -0xaa0(%rbp)
  100938:	mov    -0xb90(%rbp),%r9
  10093f:	push   -0xaa8(%rbp)
  100945:	mov    -0xb58(%rbp),%r8
  10094c:	push   %rax
  10094d:	mov    -0xaf8(%rbp),%rax
  100954:	push   %r13
  100956:	push   -0xb60(%rbp)
  10095c:	mov    (%rax),%rdi
  10095f:	push   -0xb70(%rbp)
  100965:	call   6add0 <synreal::kernel::add_spring_gauss_newton_hessian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, float const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
  10096a:	add    $0x30,%rsp
  10096e:	call   6c900 <cudaGetLastError@plt>
  100973:	mov    %eax,%edi
  100975:	lea    0xf9d4c(%rip),%rsi        # 1fa6c8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x57c8>
  10097c:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  100981:	mov    -0xaf0(%rbp),%r12
  100988:	jmp    fd163 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2003>
  10098d:	nopl   (%rax)
  100990:	sub    $0x130,%rsp
  100997:	mov    -0xbb8(%rbp),%rsi
  10099e:	mov    $0x25,%ecx
  1009a3:	mov    %rsp,%rdi
  1009a6:	rep movsq %ds:(%rsi),%es:(%rdi)
  1009a9:	mov    %r12,%rdi
  1009ac:	call   6ae70 <synreal::kernel::evaluate_surface_contact_force(synreal::kernel::SurfaceContactView, glm::vec<3, float, (glm::qualifier)0>*)@plt>
  1009b1:	add    $0x130,%rsp
  1009b8:	jmp    fc8a7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1747>
  1009bd:	nopl   (%rax)
  1009c0:	push   $0x0
  1009c2:	mov    -0xba0(%rbp),%rsi
  1009c9:	mov    $0x27,%ecx
  1009ce:	xor    %edx,%edx
  1009d0:	xor    %r9d,%r9d
  1009d3:	xor    %r8d,%r8d
  1009d6:	sub    $0x138,%rsp
  1009dd:	mov    %rsp,%rdi
  1009e0:	rep movsq %ds:(%rsi),%es:(%rdi)
  1009e3:	mov    %r13,%rdi
  1009e6:	mov    -0xb58(%rbp),%rsi
  1009ed:	call   6aeb0 <synreal::kernel::evaluate_hard_contacts(synreal::kernel::HardContactView, glm::vec<3, float, (glm::qualifier)0>*, float*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, float*)@plt>
  1009f2:	add    $0x140,%rsp
  1009f9:	jmp    ff64f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x44ef>
  1009fe:	xchg   %ax,%ax
  100a00:	mov    -0x7c0(%rbp),%rax
  100a07:	mov    %r12,%r8
  100a0a:	xor    %ecx,%ecx
  100a0c:	xor    %edx,%edx
  100a0e:	movss  0xfc56a(%rip),%xmm0        # 1fcf80 <cuda::std::__4::in_place+0x33>
  100a16:	divss  (%rax),%xmm0
  100a1a:	mov    -0x7c8(%rbp),%rax
  100a21:	mov    0x3090(%rax),%rsi
  100a28:	mov    -0x7d8(%rbp),%rax
  100a2f:	push   0x98(%rax)
  100a35:	push   0x90(%rax)
  100a3b:	push   0x88(%rax)
  100a41:	push   0x80(%rax)
  100a47:	push   0x78(%rax)
  100a4a:	push   0x70(%rax)
  100a4d:	push   0x68(%rax)
  100a50:	push   0x60(%rax)
  100a53:	push   0x58(%rax)
  100a56:	push   0x50(%rax)
  100a59:	push   0x48(%rax)
  100a5c:	push   0x40(%rax)
  100a5f:	push   0x38(%rax)
  100a62:	push   0x30(%rax)
  100a65:	push   0x28(%rax)
  100a68:	push   0x20(%rax)
  100a6b:	push   0x18(%rax)
  100a6e:	push   0x10(%rax)
  100a71:	push   0x8(%rax)
  100a74:	push   (%rax)
  100a76:	mov    -0x7d0(%rbp),%rax
  100a7d:	mov    (%rax),%rdi
  100a80:	call   6aa80 <synreal::kernel::evaluate_cables(synreal::kernel::CableView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  100a85:	add    $0xa0,%rsp
  100a8c:	jmp    fdf0a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2daa>
  100a91:	nopl   0x0(%rax)
  100a98:	mov    -0x7c0(%rbp),%rax
  100a9f:	mov    %r12,%r8
  100aa2:	xor    %ecx,%ecx
  100aa4:	xor    %edx,%edx
  100aa6:	movss  0xfc4d2(%rip),%xmm0        # 1fcf80 <cuda::std::__4::in_place+0x33>
  100aae:	divss  (%rax),%xmm0
  100ab2:	mov    -0x7c8(%rbp),%rax
  100ab9:	mov    0x3090(%rax),%rsi
  100ac0:	mov    -0x7d8(%rbp),%rax
  100ac7:	push   0x98(%rax)
  100acd:	push   0x90(%rax)
  100ad3:	push   0x88(%rax)
  100ad9:	push   0x80(%rax)
  100adf:	push   0x78(%rax)
  100ae2:	push   0x70(%rax)
  100ae5:	push   0x68(%rax)
  100ae8:	push   0x60(%rax)
  100aeb:	push   0x58(%rax)
  100aee:	push   0x50(%rax)
  100af1:	push   0x48(%rax)
  100af4:	push   0x40(%rax)
  100af7:	push   0x38(%rax)
  100afa:	push   0x30(%rax)
  100afd:	push   0x28(%rax)
  100b00:	push   0x20(%rax)
  100b03:	push   0x18(%rax)
  100b06:	push   0x10(%rax)
  100b09:	push   0x8(%rax)
  100b0c:	push   (%rax)
  100b0e:	mov    -0x7d0(%rbp),%rax
  100b15:	mov    (%rax),%rdi
  100b18:	call   6aa80 <synreal::kernel::evaluate_cables(synreal::kernel::CableView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  100b1d:	add    $0xa0,%rsp
  100b24:	jmp    fd87d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x271d>
  100b29:	nopl   0x0(%rax)
  100b30:	mov    -0x818(%rbp),%rax
  100b37:	mov    -0x7f8(%rbp),%rdx
  100b3e:	xor    %r9d,%r9d
  100b41:	xor    %r8d,%r8d
  100b44:	movss  0xfc434(%rip),%xmm0        # 1fcf80 <cuda::std::__4::in_place+0x33>
  100b4c:	mov    0x3290(%rax),%rcx
  100b53:	mov    0x3090(%rax),%rsi
  100b5a:	divss  (%rdx),%xmm0
  100b5e:	mov    0x3270(%rax),%rdx
  100b65:	mov    -0x810(%rbp),%rax
  100b6c:	push   %r12
  100b6e:	push   -0x858(%rbp)
  100b74:	push   -0x860(%rbp)
  100b7a:	push   -0x868(%rbp)
  100b80:	push   -0x870(%rbp)
  100b86:	push   0x70(%rax)
  100b89:	push   0x68(%rax)
  100b8c:	push   0x60(%rax)
  100b8f:	push   0x58(%rax)
  100b92:	push   0x50(%rax)
  100b95:	push   0x48(%rax)
  100b98:	push   0x40(%rax)
  100b9b:	push   0x38(%rax)
  100b9e:	push   0x30(%rax)
  100ba1:	push   0x28(%rax)
  100ba4:	push   0x20(%rax)
  100ba7:	push   0x18(%rax)
  100baa:	push   0x10(%rax)
  100bad:	push   0x8(%rax)
  100bb0:	push   (%rax)
  100bb2:	mov    -0x800(%rbp),%rax
  100bb9:	mov    (%rax),%rdi
  100bbc:	call   6ac60 <synreal::kernel::evaluate_angular_limits(synreal::kernel::JointCoordinateView, synreal::kernel::AngularLimitView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, int const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  100bc1:	add    $0xa0,%rsp
  100bc8:	jmp    fd954 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x27f4>
  100bcd:	nopl   (%rax)
  100bd0:	mov    0xfc3b9(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
  100bd7:	movl   $0x1,-0x8a0(%rbp)
  100be1:	mov    %rax,-0x8a8(%rbp)
  100be8:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
  100bed:	mov    %r15,-0x898(%rbp)
  100bf4:	mov    -0x8a0(%rbp),%ecx
  100bfa:	mov    %r12,%r9
  100bfd:	xor    %r8d,%r8d
  100c00:	mov    %eax,-0x89c(%rbp)
  100c06:	mov    -0x8a8(%rbp),%rdx
  100c0d:	mov    -0x89c(%rbp),%rdi
  100c14:	mov    -0x894(%rbp),%esi
  100c1a:	call   6f040 <__cudaPushCallConfiguration@plt>
  100c1f:	test   %eax,%eax
  100c21:	je     1019a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6840>
  100c27:	call   6c900 <cudaGetLastError@plt>
  100c2c:	mov    %eax,%edi
  100c2e:	lea    0xf9f4b(%rip),%rsi        # 1fab80 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5c80>
  100c35:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  100c3a:	mov    -0xaf0(%rbp),%r12
  100c41:	jmp    fe5ea <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x348a>
  100c46:	cs nopw 0x0(%rax,%rax,1)
  100c50:	imul   %rax,%r13
  100c54:	mov    %rax,-0xbe0(%rbp)
  100c5b:	test   %r13,%r13
  100c5e:	je     fd2d0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2170>
  100c64:	mov    0x56c(%rbx),%eax
  100c6a:	mov    %rax,-0xbf8(%rbp)
  100c71:	jmp    1019fb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x689b>
  100c76:	cs nopw 0x0(%rax,%rax,1)
  100c80:	mov    0x2de0(%rbx),%rdi
  100c87:	test   %rdi,%rdi
  100c8a:	jne    102468 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7308>
  100c90:	mov    0x398(%rbx),%eax
  100c96:	test   %eax,%eax
  100c98:	je     102458 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x72f8>
  100c9e:	mov    -0xb30(%rbp),%ecx
  100ca4:	lea    -0x2(%rcx),%edx
  100ca7:	cmp    $0x1,%edx
  100caa:	jbe    101bf0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6a90>
  100cb0:	movss  0xc(%rbx),%xmm0
  100cb5:	pxor   %xmm6,%xmm6
  100cb9:	comiss %xmm6,%xmm0
  100cbc:	jbe    1026f0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7590>
  100cc2:	movb   $0x1,-0xad0(%rbp)
  100cc9:	xor    %edx,%edx
  100ccb:	mov    $0x1,%r13d
  100cd1:	mov    $0x1,%edi
  100cd6:	jmp    fc0f1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf91>
  100cdb:	nopl   0x0(%rax,%rax,1)
  100ce0:	mov    0xc0(%r14),%rax
  100ce7:	xor    %edx,%edx
  100ce9:	movdqu 0xe0(%r14),%xmm1
  100cf2:	movdqu 0xf0(%r14),%xmm6
  100cfb:	movdqu 0x100(%r14),%xmm0
  100d04:	movdqu 0x110(%r14),%xmm5
  100d0d:	mov    %rax,-0x500(%rbp)
  100d14:	mov    0xd0(%r14),%eax
  100d1b:	punpckhqdq %xmm6,%xmm1
  100d1f:	movdqu 0x120(%r14),%xmm2
  100d28:	movdqu 0x130(%r14),%xmm4
  100d31:	punpckhqdq %xmm5,%xmm0
  100d35:	movaps %xmm1,-0x4e0(%rbp)
  100d3c:	mov    %rax,-0x4f8(%rbp)
  100d43:	mov    0x150(%r14),%rax
  100d4a:	punpckhqdq %xmm4,%xmm2
  100d4e:	movaps %xmm0,-0x4d0(%rbp)
  100d55:	movaps %xmm2,-0x4f0(%rbp)
  100d5c:	test   %rax,%rax
  100d5f:	jne    101cf8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6b98>
  100d65:	movq   0x118(%rbx),%xmm0
  100d6d:	mov    %rax,-0x4b8(%rbp)
  100d74:	xor    %eax,%eax
  100d76:	cmpq   $0x0,0x100(%rbx)
  100d7e:	mov    %rdx,-0x4c0(%rbp)
  100d85:	movhps 0xc0(%rbx),%xmm0
  100d8c:	movaps %xmm0,-0x4b0(%rbp)
  100d93:	jne    101cd0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6b70>
  100d99:	mov    -0xaa8(%rbp),%rsi
  100da0:	movq   %rax,%xmm0
  100da5:	movdqu 0x7b0(%rbx),%xmm1
  100dad:	movhps 0x33e0(%rbx),%xmm0
  100db4:	movdqu 0x750(%rbx),%xmm6
  100dbc:	movdqu 0x770(%rbx),%xmm5
  100dc4:	movaps %xmm0,-0x4a0(%rbp)
  100dcb:	movq   %rsi,%xmm0
  100dd0:	movdqu 0x740(%rbx),%xmm7
  100dd8:	mov    0x788(%rbx),%rax
  100ddf:	movhps -0xaa0(%rbp),%xmm0
  100de6:	movdqu 0x730(%rbx),%xmm2
  100dee:	punpckhqdq %xmm6,%xmm1
  100df2:	movdqu 0x710(%rbx),%xmm3
  100dfa:	movaps %xmm0,-0x490(%rbp)
  100e01:	movdqu 0x760(%rbx),%xmm0
  100e09:	movdqu 0x720(%rbx),%xmm4
  100e11:	movaps %xmm1,-0x460(%rbp)
  100e18:	movd   -0xac8(%rbp),%xmm1
  100e20:	mov    -0xa80(%rbp),%rdx
  100e27:	punpckhqdq %xmm7,%xmm2
  100e2b:	punpckhqdq %xmm5,%xmm0
  100e2f:	mov    %rax,-0x440(%rbp)
  100e36:	movups 0x7c8(%rbx),%xmm7
  100e3d:	punpckhqdq %xmm4,%xmm3
  100e41:	movaps %xmm0,-0x450(%rbp)
  100e48:	movd   0x710(%rbx),%xmm0
  100e50:	mov    0x3f0(%rbx),%rax
  100e57:	mov    0x3d0(%rbx),%rcx
  100e5e:	mov    0x3e0(%rbx),%r8
  100e65:	mov    %rdx,-0x428(%rbp)
  100e6c:	punpcklqdq %xmm1,%xmm0
  100e70:	mov    %rax,-0x410(%rbp)
  100e77:	movups %xmm0,-0x438(%rbp)
  100e7e:	mov    %rcx,-0x408(%rbp)
  100e85:	mov    %r8,-0x400(%rbp)
  100e8c:	movaps %xmm3,-0x480(%rbp)
  100e93:	movaps %xmm2,-0x470(%rbp)
  100e9a:	movaps %xmm7,-0x420(%rbp)
  100ea1:	mov    0x398(%rbx),%eax
  100ea7:	mov    %rax,-0x3f8(%rbp)
  100eae:	mov    -0xaf8(%rbp),%rax
  100eb5:	mov    (%rax),%rax
  100eb8:	movq   %rax,%xmm0
  100ebd:	mov    %rax,-0xb38(%rbp)
  100ec4:	movhps 0x3090(%rbx),%xmm0
  100ecb:	movaps %xmm0,-0x3f0(%rbp)
  100ed2:	movss  0xfc0a6(%rip),%xmm0        # 1fcf80 <cuda::std::__4::in_place+0x33>
  100eda:	divss  -0xae4(%rbp),%xmm0
  100ee2:	movss  %xmm0,-0x3e0(%rbp)
  100eea:	jmp    fb91e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7be>
  100eef:	nop
  100ef0:	mov    0xfc099(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
  100ef7:	mov    -0xa78(%rbp),%rdi
  100efe:	movl   $0x1,-0x8a0(%rbp)
  100f08:	mov    %rax,-0x8a8(%rbp)
  100f0f:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
  100f14:	mov    %r15,-0x898(%rbp)
  100f1b:	mov    -0x8a0(%rbp),%ecx
  100f21:	mov    %r12,%r9
  100f24:	xor    %r8d,%r8d
  100f27:	mov    %eax,-0x89c(%rbp)
  100f2d:	mov    -0x8a8(%rbp),%rdx
  100f34:	mov    -0x89c(%rbp),%rdi
  100f3b:	mov    -0x894(%rbp),%esi
  100f41:	call   6f040 <__cudaPushCallConfiguration@plt>
  100f46:	test   %eax,%eax
  100f48:	je     101d08 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6ba8>
  100f4e:	call   6c900 <cudaGetLastError@plt>
  100f53:	mov    %eax,%edi
  100f55:	lea    0xf95a4(%rip),%rsi        # 1fa500 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5600>
  100f5c:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  100f61:	jmp    ffeeb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4d8b>
  100f66:	cs nopw 0x0(%rax,%rax,1)
  100f70:	mov    0xfc019(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
  100f77:	mov    -0xa78(%rbp),%rdi
  100f7e:	movl   $0x1,-0x8a0(%rbp)
  100f88:	mov    %rax,-0x8a8(%rbp)
  100f8f:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
  100f94:	mov    %r15,-0x898(%rbp)
  100f9b:	mov    -0x8a0(%rbp),%ecx
  100fa1:	mov    %r12,%r9
  100fa4:	xor    %r8d,%r8d
  100fa7:	mov    %eax,-0x89c(%rbp)
  100fad:	mov    -0x8a8(%rbp),%rdx
  100fb4:	mov    -0x89c(%rbp),%rdi
  100fbb:	mov    -0x894(%rbp),%esi
  100fc1:	call   6f040 <__cudaPushCallConfiguration@plt>
  100fc6:	test   %eax,%eax
  100fc8:	je     101d70 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6c10>
  100fce:	call   6c900 <cudaGetLastError@plt>
  100fd3:	mov    %eax,%edi
  100fd5:	lea    0xf9554(%rip),%rsi        # 1fa530 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5630>
  100fdc:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  100fe1:	jmp    ffeeb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4d8b>
  100fe6:	cs nopw 0x0(%rax,%rax,1)
  100ff0:	mov    0xfbf99(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
  100ff7:	mov    -0xaf0(%rbp),%r13
  100ffe:	movl   $0x1,-0x8a0(%rbp)
  101008:	mov    %rax,-0x8a8(%rbp)
  10100f:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
  101014:	mov    %r15,-0x898(%rbp)
  10101b:	mov    -0x8a0(%rbp),%ecx
  101021:	mov    %r13,%r9
  101024:	xor    %r8d,%r8d
  101027:	mov    %eax,-0x89c(%rbp)
  10102d:	mov    -0x8a8(%rbp),%rdx
  101034:	mov    -0x89c(%rbp),%rdi
  10103b:	mov    -0x894(%rbp),%esi
  101041:	call   6f040 <__cudaPushCallConfiguration@plt>
  101046:	test   %eax,%eax
  101048:	je     101f50 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6df0>
  10104e:	call   6c900 <cudaGetLastError@plt>
  101053:	mov    %eax,%edi
  101055:	lea    0xf933c(%rip),%rsi        # 1fa398 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5498>
  10105c:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  101061:	jmp    fcb90 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1a30>
  101066:	cs nopw 0x0(%rax,%rax,1)
  101070:	mov    0xfbf19(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
  101077:	mov    -0xaf0(%rbp),%r13
  10107e:	movl   $0x1,-0x8a0(%rbp)
  101088:	mov    %rax,-0x8a8(%rbp)
  10108f:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
  101094:	mov    %r15,-0x898(%rbp)
  10109b:	mov    -0x8a0(%rbp),%ecx
  1010a1:	mov    %r13,%r9
  1010a4:	xor    %r8d,%r8d
  1010a7:	mov    %eax,-0x89c(%rbp)
  1010ad:	mov    -0x8a8(%rbp),%rdx
  1010b4:	mov    -0x89c(%rbp),%rdi
  1010bb:	mov    -0x894(%rbp),%esi
  1010c1:	call   6f040 <__cudaPushCallConfiguration@plt>
  1010c6:	test   %eax,%eax
  1010c8:	je     101ec0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6d60>
  1010ce:	call   6c900 <cudaGetLastError@plt>
  1010d3:	mov    %eax,%edi
  1010d5:	lea    0xf935c(%rip),%rsi        # 1fa438 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5538>
  1010dc:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  1010e1:	jmp    fccf8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1b98>
  1010e6:	cs nopw 0x0(%rax,%rax,1)
  1010f0:	mov    $0x1,%r15d
  1010f6:	jmp    fb3ff <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x29f>
  1010fb:	nopl   0x0(%rax,%rax,1)
  101100:	movss  0xc(%rbx),%xmm0
  101105:	pxor   %xmm7,%xmm7
  101109:	comiss %xmm7,%xmm0
  10110c:	jbe    fd17a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x201a>
  101112:	jmp    ff075 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3f15>
  101117:	nopw   0x0(%rax,%rax,1)
  101120:	test   %eax,%eax
  101122:	jne    fb738 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5d8>
  101128:	mov    0x710(%rbx),%eax
  10112e:	jmp    fb738 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5d8>
  101133:	nopl   0x0(%rax,%rax,1)
  101138:	mov    -0xa78(%rbp),%rdi
  10113f:	test   %rdi,%rdi
  101142:	je     fc09a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf3a>
  101148:	mov    0xfbe41(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
  10114f:	mov    -0xaf0(%rbp),%r12
  101156:	movl   $0x1,-0x638(%rbp)
  101160:	mov    %rax,-0x640(%rbp)
  101167:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
  10116c:	mov    -0x638(%rbp),%ecx
  101172:	xor    %r8d,%r8d
  101175:	mov    %r12,%r9
  101178:	mov    %eax,-0x5a0(%rbp)
  10117e:	mov    -0x640(%rbp),%rdx
  101185:	movabs $0x100000001,%rax
  10118f:	mov    %rax,-0x59c(%rbp)
  101196:	mov    -0x5a0(%rbp),%rdi
  10119d:	mov    -0x598(%rbp),%esi
  1011a3:	call   6f040 <__cudaPushCallConfiguration@plt>
  1011a8:	test   %eax,%eax
  1011aa:	je     102951 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x77f1>
  1011b0:	call   6c900 <cudaGetLastError@plt>
  1011b5:	lea    0xf8eec(%rip),%rsi        # 1fa0a8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x51a8>
  1011bc:	mov    %eax,%edi
  1011be:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  1011c3:	jmp    fc09a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf3a>
  1011c8:	nopl   0x0(%rax,%rax,1)
  1011d0:	movq   $0x0,-0xb58(%rbp)
  1011db:	jmp    fd4a7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2347>
  1011e0:	mov    -0xaf0(%rbp),%r9
  1011e7:	mov    %r12,%rdi
  1011ea:	mov    0xfbd9f(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
  1011f1:	movl   $0x1,-0x638(%rbp)
  1011fb:	mov    %r9,-0xbd8(%rbp)
  101202:	mov    %rax,-0x640(%rbp)
  101209:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
  10120e:	mov    -0x638(%rbp),%ecx
  101214:	mov    -0xbd8(%rbp),%r9
  10121b:	xor    %r8d,%r8d
  10121e:	mov    %eax,-0x5a0(%rbp)
  101224:	mov    -0x640(%rbp),%rdx
  10122b:	movabs $0x100000001,%rax
  101235:	mov    %rax,-0x59c(%rbp)
  10123c:	mov    -0x5a0(%rbp),%rdi
  101243:	mov    -0x598(%rbp),%esi
  101249:	call   6f040 <__cudaPushCallConfiguration@plt>
  10124e:	test   %eax,%eax
  101250:	je     101fc8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6e68>
  101256:	call   6c900 <cudaGetLastError@plt>
  10125b:	lea    0xf8f0e(%rip),%rsi        # 1fa170 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5270>
  101262:	mov    %eax,%edi
  101264:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  101269:	jmp    fc1f2 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1092>
  10126e:	xchg   %ax,%ax
  101270:	mov    0xfbd19(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
  101277:	mov    -0xaf0(%rbp),%r12
  10127e:	movl   $0x1,-0x638(%rbp)
  101288:	mov    %rax,-0x640(%rbp)
  10128f:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
  101294:	mov    -0x638(%rbp),%ecx
  10129a:	xor    %r8d,%r8d
  10129d:	mov    %r12,%r9
  1012a0:	mov    %eax,-0x5a0(%rbp)
  1012a6:	mov    -0x640(%rbp),%rdx
  1012ad:	movabs $0x100000001,%rax
  1012b7:	mov    %rax,-0x59c(%rbp)
  1012be:	mov    -0x5a0(%rbp),%rdi
  1012c5:	mov    -0x598(%rbp),%esi
  1012cb:	call   6f040 <__cudaPushCallConfiguration@plt>
  1012d0:	test   %eax,%eax
  1012d2:	je     102120 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6fc0>
  1012d8:	call   6c900 <cudaGetLastError@plt>
  1012dd:	lea    0xf8c2c(%rip),%rsi        # 1f9f10 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5010>
  1012e4:	mov    %eax,%edi
  1012e6:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  1012eb:	mov    0x498(%rbx),%r8d
  1012f2:	mov    -0xa80(%rbp),%rdx
  1012f9:	mov    -0xaa8(%rbp),%rsi
  101300:	mov    0x3d0(%rbx),%rcx
  101307:	jmp    fba9d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x93d>
  10130c:	nopl   0x0(%rax)
  101310:	mov    $0x120,%edi
  101315:	movaps %xmm0,-0x170(%rbp)
  10131c:	movq   $0x0,-0x160(%rbp)
  101327:	movq   $0x0,-0x158(%rbp)
  101332:	call   6d1c0 <operator new(unsigned long)@plt>
  101337:	lea    -0xaa0(%rbp),%rcx
  10133e:	lea    -0xa78(%rbp),%rdx
  101345:	movdqa -0xb70(%rbp),%xmm4
  10134d:	mov    %r14,0xa8(%rax)
  101354:	movq   %rcx,%xmm0
  101359:	lea    -0xad0(%rbp),%rcx
  101360:	movq   %rdx,%xmm5
  101365:	movhps -0xb00(%rbp),%xmm0
  10136c:	lea    -0xabc(%rbp),%rdx
  101373:	movups %xmm4,0x20(%rax)
  101377:	movups %xmm0,(%rax)
  10137a:	movq   %rcx,%xmm0
  10137f:	lea    -0xacc(%rbp),%rcx
  101386:	movq   %rdx,%xmm7
  10138b:	punpcklqdq %xmm5,%xmm0
  10138f:	lea    -0xacf(%rbp),%rdx
  101396:	movups %xmm0,0x10(%rax)
  10139a:	movq   %rcx,%xmm0
  10139f:	movq   %rdx,%xmm6
  1013a4:	lea    -0xad2(%rbp),%rcx
  1013ab:	punpcklqdq %xmm7,%xmm0
  1013af:	lea    -0xa98(%rbp),%rdx
  1013b6:	movups %xmm0,0x30(%rax)
  1013ba:	movq   %rdx,%xmm5
  1013bf:	lea    -0xa60(%rbp),%rdx
  1013c6:	movq   -0xb90(%rbp),%xmm0
  1013ce:	movq   %rdx,%xmm4
  1013d3:	lea    -0xad1(%rbp),%rdx
  1013da:	punpcklqdq %xmm6,%xmm0
  1013de:	movups %xmm0,0x40(%rax)
  1013e2:	movq   %rcx,%xmm0
  1013e7:	lea    -0xac0(%rbp),%rcx
  1013ee:	punpcklqdq %xmm5,%xmm0
  1013f2:	movups %xmm0,0x50(%rax)
  1013f6:	movq   %r15,%xmm0
  1013fb:	punpcklqdq %xmm4,%xmm0
  1013ff:	movups %xmm0,0x60(%rax)
  101403:	movq   %rdx,%xmm0
  101408:	lea    -0xad5(%rbp),%rdx
  10140f:	movq   %rdx,%xmm7
  101414:	lea    -0xad9(%rbp),%rdx
  10141b:	punpcklqdq %xmm7,%xmm0
  10141f:	movups %xmm0,0x70(%rax)
  101423:	movq   %rcx,%xmm0
  101428:	mov    -0xb60(%rbp),%rcx
  10142f:	movhps -0xbb8(%rbp),%xmm0
  101436:	movups %xmm0,0x80(%rax)
  10143d:	movq   %rdx,%xmm0
  101442:	lea    -0x7b0(%rbp),%rdx
  101449:	movq   %rdx,%xmm6
  10144e:	lea    -0xad6(%rbp),%rdx
  101455:	mov    %rcx,0xb0(%rax)
  10145c:	lea    -0x114e3(%rip),%rcx        # eff80 <std::_Function_handler<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >), synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}>::_M_manager(std::_Any_data&, std::_Any_data const&, std::_Manager_operation)>
  101463:	mov    %rdx,0xa0(%rax)
  10146a:	mov    -0xbc8(%rbp),%rdx
  101471:	punpcklqdq %xmm6,%xmm0
  101475:	movups %xmm0,0x90(%rax)
  10147c:	mov    %rdx,0xb8(%rax)
  101483:	lea    -0xada(%rbp),%rdx
  10148a:	mov    %rdx,0xc0(%rax)
  101491:	lea    -0xa88(%rbp),%rdx
  101498:	mov    %rdx,0xc8(%rax)
  10149f:	lea    -0xa90(%rbp),%rdx
  1014a6:	mov    %rdx,0xd0(%rax)
  1014ad:	lea    -0xace(%rbp),%rdx
  1014b4:	mov    %rdx,0xd8(%rax)
  1014bb:	lea    -0xa68(%rbp),%rdx
  1014c2:	mov    %rdx,0xe0(%rax)
  1014c9:	lea    -0xac4(%rbp),%rdx
  1014d0:	mov    %rdx,0xe8(%rax)
  1014d7:	lea    -0xacd(%rbp),%rdx
  1014de:	mov    %rdx,0xf0(%rax)
  1014e5:	lea    -0x850(%rbp),%rdx
  1014ec:	mov    %rdx,0xf8(%rax)
  1014f3:	lea    -0x7f0(%rbp),%rdx
  1014fa:	mov    %rdx,0x100(%rax)
  101501:	lea    -0x820(%rbp),%rdx
  101508:	mov    %rdx,0x108(%rax)
  10150f:	lea    -0xad7(%rbp),%rdx
  101516:	mov    %rdx,0x110(%rax)
  10151d:	lea    -0x3b0(%rbp),%rdx
  101524:	mov    %rdx,0x118(%rax)
  10152b:	lea    0x26fe(%rip),%rdx        # 103c30 <std::_Function_handler<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >), synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}>::_M_invoke(std::_Any_data const&, synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>&&, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >&&)>
  101532:	mov    %rax,-0x170(%rbp)
  101539:	movdqa -0x170(%rbp),%xmm0
  101541:	movq   %rdx,%xmm7
  101546:	movdqa -0x3d0(%rbp),%xmm5
  10154e:	movdqa -0x3c0(%rbp),%xmm4
  101556:	mov    -0x3c0(%rbp),%rax
  10155d:	movaps %xmm0,-0x3d0(%rbp)
  101564:	movq   %rcx,%xmm0
  101569:	punpcklqdq %xmm7,%xmm0
  10156d:	movaps %xmm5,-0x170(%rbp)
  101574:	movaps %xmm4,-0x160(%rbp)
  10157b:	movaps %xmm0,-0x3c0(%rbp)
  101582:	test   %rax,%rax
  101585:	je     fc21c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x10bc>
  10158b:	lea    -0x170(%rbp),%rdi
  101592:	mov    $0x3,%edx
  101597:	mov    %rdi,%rsi
  10159a:	call   *%rax
  10159c:	jmp    fc21c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x10bc>
  1015a1:	nopl   0x0(%rax)
  1015a8:	mov    0xfb9e1(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
  1015af:	mov    0x10(%r14),%edi
  1015b3:	movl   $0x1,-0x638(%rbp)
  1015bd:	mov    -0xaf0(%rbp),%r12
  1015c4:	mov    %rax,-0x640(%rbp)
  1015cb:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
  1015d0:	mov    -0x638(%rbp),%ecx
  1015d6:	xor    %r8d,%r8d
  1015d9:	mov    %r12,%r9
  1015dc:	mov    %eax,-0x5a0(%rbp)
  1015e2:	mov    -0x640(%rbp),%rdx
  1015e9:	movabs $0x100000001,%rax
  1015f3:	mov    %rax,-0x59c(%rbp)
  1015fa:	mov    -0x5a0(%rbp),%rdi
  101601:	mov    -0x598(%rbp),%esi
  101607:	call   6f040 <__cudaPushCallConfiguration@plt>
  10160c:	test   %eax,%eax
  10160e:	je     102000 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6ea0>
  101614:	call   6c900 <cudaGetLastError@plt>
  101619:	lea    0xf8918(%rip),%rsi        # 1f9f38 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5038>
  101620:	mov    %eax,%edi
  101622:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  101627:	jmp    fbd4c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xbec>
  10162c:	nopl   0x0(%rax)
  101630:	mov    %rdx,%rax
  101633:	movss  0x74(%rbx),%xmm0
  101638:	mov    -0xaf0(%rbp),%rdx
  10163f:	lea    0x920(%rbx),%rdi
  101646:	mov    (%rax),%rsi
  101649:	call   6d6d0 <synreal::SelfCollision::begin_frame(glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)@plt>
  10164e:	jmp    fbd3f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xbdf>
  101653:	nopl   0x0(%rax,%rax,1)
  101658:	mov    0xfb931(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
  10165f:	mov    0x10(%r14),%edi
  101663:	movl   $0x1,-0x8a0(%rbp)
  10166d:	mov    %rax,-0x8a8(%rbp)
  101674:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
  101679:	mov    %eax,-0x89c(%rbp)
  10167f:	mov    -0x8a0(%rbp),%ecx
  101685:	mov    %r12,%r9
  101688:	xor    %r8d,%r8d
  10168b:	movabs $0x100000001,%rax
  101695:	mov    -0x8a8(%rbp),%rdx
  10169c:	mov    %rax,-0x898(%rbp)
  1016a3:	mov    -0x89c(%rbp),%rdi
  1016aa:	mov    -0x894(%rbp),%esi
  1016b0:	call   6f040 <__cudaPushCallConfiguration@plt>
  1016b5:	test   %eax,%eax
  1016b7:	je     101e90 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6d30>
  1016bd:	call   6c900 <cudaGetLastError@plt>
  1016c2:	mov    %eax,%edi
  1016c4:	lea    0xf9565(%rip),%rsi        # 1fac30 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5d30>
  1016cb:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  1016d0:	mov    -0xaf0(%rbp),%r12
  1016d7:	jmp    fe1be <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x305e>
  1016dc:	nopl   0x0(%rax)
  1016e0:	mov    0x5d4(%rbx),%r12d
  1016e7:	imul   -0xa80(%rbp),%r12
  1016ef:	movl   $0x1,-0x8a0(%rbp)
  1016f9:	mov    0xfb890(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
  101700:	mov    -0xaf0(%rbp),%r13
  101707:	mov    %r12,%rdi
  10170a:	mov    %rax,-0x8a8(%rbp)
  101711:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
  101716:	mov    %eax,-0x89c(%rbp)
  10171c:	mov    -0x8a0(%rbp),%ecx
  101722:	mov    %r13,%r9
  101725:	xor    %r8d,%r8d
  101728:	movabs $0x100000001,%rax
  101732:	mov    -0x8a8(%rbp),%rdx
  101739:	mov    %rax,-0x898(%rbp)
  101740:	mov    -0x89c(%rbp),%rdi
  101747:	mov    -0x894(%rbp),%esi
  10174d:	call   6f040 <__cudaPushCallConfiguration@plt>
  101752:	test   %eax,%eax
  101754:	je     101e08 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6ca8>
  10175a:	call   6c900 <cudaGetLastError@plt>
  10175f:	mov    %eax,%edi
  101761:	lea    0xf9540(%rip),%rsi        # 1faca8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5da8>
  101768:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  10176d:	jmp    fe2f9 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3199>
  101772:	nopw   0x0(%rax,%rax,1)
  101778:	mov    0xfb811(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
  10177f:	mov    -0xb80(%rbp),%rdi
  101786:	movl   $0x1,-0x638(%rbp)
  101790:	mov    -0xaf0(%rbp),%r12
  101797:	mov    %rax,-0x640(%rbp)
  10179e:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
  1017a3:	mov    -0x638(%rbp),%ecx
  1017a9:	xor    %r8d,%r8d
  1017ac:	mov    %r12,%r9
  1017af:	mov    %eax,-0x5a0(%rbp)
  1017b5:	mov    -0x640(%rbp),%rdx
  1017bc:	movabs $0x100000001,%rax
  1017c6:	mov    %rax,-0x59c(%rbp)
  1017cd:	mov    -0x5a0(%rbp),%rdi
  1017d4:	mov    -0x598(%rbp),%esi
  1017da:	call   6f040 <__cudaPushCallConfiguration@plt>
  1017df:	test   %eax,%eax
  1017e1:	je     1020b0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6f50>
  1017e7:	call   6c900 <cudaGetLastError@plt>
  1017ec:	lea    0xf887d(%rip),%rsi        # 1fa070 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5170>
  1017f3:	mov    %eax,%edi
  1017f5:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  1017fa:	jmp    fc08d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf2d>
  1017ff:	nop
  101800:	mov    0xfb789(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
  101807:	mov    -0xa88(%rbp),%rdi
  10180e:	movl   $0x1,-0x638(%rbp)
  101818:	mov    -0xaf0(%rbp),%r12
  10181f:	mov    %rax,-0x640(%rbp)
  101826:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
  10182b:	mov    -0x638(%rbp),%ecx
  101831:	xor    %r8d,%r8d
  101834:	mov    %r12,%r9
  101837:	mov    %eax,-0x5a0(%rbp)
  10183d:	mov    -0x640(%rbp),%rdx
  101844:	movabs $0x100000001,%rax
  10184e:	mov    %rax,-0x59c(%rbp)
  101855:	mov    -0x5a0(%rbp),%rdi
  10185c:	mov    -0x598(%rbp),%esi
  101862:	call   6f040 <__cudaPushCallConfiguration@plt>
  101867:	test   %eax,%eax
  101869:	je     102068 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6f08>
  10186f:	call   6c900 <cudaGetLastError@plt>
  101874:	lea    0xf879d(%rip),%rsi        # 1fa018 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5118>
  10187b:	mov    %eax,%edi
  10187d:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  101882:	jmp    fc043 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xee3>
  101887:	nopw   0x0(%rax,%rax,1)
  101890:	mov    0xfb6f9(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
  101897:	mov    -0xaa8(%rbp),%rdi
  10189e:	movl   $0x1,-0x638(%rbp)
  1018a8:	mov    -0xaf0(%rbp),%r12
  1018af:	mov    %rax,-0x640(%rbp)
  1018b6:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
  1018bb:	mov    -0x638(%rbp),%ecx
  1018c1:	xor    %r8d,%r8d
  1018c4:	mov    %r12,%r9
  1018c7:	mov    %eax,-0x5a0(%rbp)
  1018cd:	mov    -0x640(%rbp),%rdx
  1018d4:	movabs $0x100000001,%rax
  1018de:	mov    %rax,-0x59c(%rbp)
  1018e5:	mov    -0x5a0(%rbp),%rdi
  1018ec:	mov    -0x598(%rbp),%esi
  1018f2:	call   6f040 <__cudaPushCallConfiguration@plt>
  1018f7:	test   %eax,%eax
  1018f9:	je     102030 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6ed0>
  1018ff:	call   6c900 <cudaGetLastError@plt>
  101904:	lea    0xf8685(%rip),%rsi        # 1f9f90 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5090>
  10190b:	mov    %eax,%edi
  10190d:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  101912:	jmp    fbdf4 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xc94>
  101917:	nopw   0x0(%rax,%rax,1)
  101920:	lea    0x920(%rbx),%rdi
  101927:	call   6d700 <synreal::SelfCollision::available() const@plt>
  10192c:	mov    0x4f0(%rbx),%ecx
  101932:	mov    -0xa80(%rbp),%rdx
  101939:	jmp    fbc6c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xb0c>
  10193e:	xchg   %ax,%ax
  101940:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
  101945:	mov    %r15,-0x898(%rbp)
  10194c:	mov    -0x8a0(%rbp),%ecx
  101952:	mov    %r12,%r9
  101955:	xor    %r8d,%r8d
  101958:	mov    %eax,-0x89c(%rbp)
  10195e:	mov    -0x8a8(%rbp),%rdx
  101965:	mov    -0x89c(%rbp),%rdi
  10196c:	mov    -0x894(%rbp),%esi
  101972:	call   6f040 <__cudaPushCallConfiguration@plt>
  101977:	test   %eax,%eax
  101979:	je     102170 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7010>
  10197f:	call   6c900 <cudaGetLastError@plt>
  101984:	mov    %eax,%edi
  101986:	lea    0xf8e9b(%rip),%rsi        # 1fa828 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5928>
  10198d:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  101992:	jmp    fd4a7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2347>
  101997:	nopw   0x0(%rax,%rax,1)
  1019a0:	mov    0x398(%rbx),%eax
  1019a6:	mov    0x33a0(%rbx),%rcx
  1019ad:	mov    %r13d,%r8d
  1019b0:	mov    0x3380(%rbx),%rdx
  1019b7:	mov    0x3d0(%rbx),%rsi
  1019be:	push   -0xaa8(%rbp)
  1019c4:	and    $0x1,%r8d
  1019c8:	mov    -0xa78(%rbp),%r9
  1019cf:	push   %rax
  1019d0:	mov    -0xb18(%rbp),%rax
  1019d7:	mov    (%rax),%rdi
  1019da:	call   6ae40 <synreal::kernel::update_affine_body_so3_augmented_lagrangian_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, bool, unsigned long, unsigned long, unsigned long)@plt>
  1019df:	pop    %rsi
  1019e0:	pop    %rdi
  1019e1:	jmp    100c27 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5ac7>
  1019e6:	cs nopw 0x0(%rax,%rax,1)
  1019f0:	movq   $0x0,-0xbf8(%rbp)
  1019fb:	mov    0xfb58e(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
  101a02:	mov    %r13,%rdi
  101a05:	movl   $0x1,-0x8a0(%rbp)
  101a0f:	mov    %rax,-0x8a8(%rbp)
  101a16:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
  101a1b:	mov    %r15,-0x898(%rbp)
  101a22:	mov    -0x8a0(%rbp),%ecx
  101a28:	mov    %r12,%r9
  101a2b:	xor    %r8d,%r8d
  101a2e:	mov    %eax,-0x89c(%rbp)
  101a34:	mov    -0x8a8(%rbp),%rdx
  101a3b:	mov    -0x89c(%rbp),%rdi
  101a42:	mov    -0x894(%rbp),%esi
  101a48:	call   6f040 <__cudaPushCallConfiguration@plt>
  101a4d:	test   %eax,%eax
  101a4f:	jne    101add <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x697d>
  101a55:	sub    $0x8,%rsp
  101a59:	mov    -0xaf8(%rbp),%rax
  101a60:	mov    0x34e0(%rbx),%rcx
  101a67:	mov    0x570(%rbx),%rdx
  101a6e:	mov    0x3d0(%rbx),%rsi
  101a75:	push   -0xaa0(%rbp)
  101a7b:	movss  -0xac4(%rbp),%xmm0
  101a83:	push   -0xaa8(%rbp)
  101a89:	mov    0x3520(%rbx),%r9
  101a90:	push   -0xbe0(%rbp)
  101a96:	mov    0x3500(%rbx),%r8
  101a9d:	push   %r13
  101a9f:	push   -0xb60(%rbp)
  101aa5:	push   -0xb70(%rbp)
  101aab:	push   -0xb90(%rbp)
  101ab1:	push   -0xb58(%rbp)
  101ab7:	push   $0x1
  101ab9:	push   -0xbf8(%rbp)
  101abf:	push   0x5b0(%rbx)
  101ac5:	push   0x5a0(%rbx)
  101acb:	push   0x590(%rbx)
  101ad1:	mov    (%rax),%rdi
  101ad4:	call   6ade0 <synreal::kernel::add_body_point_line_gauss_newton_hessian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, unsigned long, bool, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
  101ad9:	add    $0x70,%rsp
  101add:	call   6c900 <cudaGetLastError@plt>
  101ae2:	mov    %eax,%edi
  101ae4:	lea    0xf8c6d(%rip),%rsi        # 1fa758 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5858>
  101aeb:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  101af0:	mov    -0xaf0(%rbp),%r12
  101af7:	jmp    fd2d0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2170>
  101afc:	nopl   0x0(%rax)
  101b00:	movzbl 0x3370(%rbx),%r13d
  101b08:	mov    %r13b,-0xb40(%rbp)
  101b0f:	test   %r13b,%r13b
  101b12:	jne    fc1a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1040>
  101b18:	mov    0x1818(%rbx),%r10d
  101b1f:	test   %r10d,%r10d
  101b22:	jne    1021b0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7050>
  101b28:	mov    0x21b0(%rbx),%r9d
  101b2f:	test   %r9d,%r9d
  101b32:	jne    1021b0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7050>
  101b38:	or     %esi,%ecx
  101b3a:	mov    %cl,-0xb40(%rbp)
  101b40:	mov    %ecx,%r13d
  101b43:	test   %cl,%cl
  101b45:	jne    fc1a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1040>
  101b4b:	or     -0xada(%rbp),%r8b
  101b52:	mov    %r8b,-0xb40(%rbp)
  101b59:	mov    %r8d,%r13d
  101b5c:	jne    fc1a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1040>
  101b62:	or     -0xad7(%rbp),%dl
  101b68:	mov    %dl,-0xb40(%rbp)
  101b6e:	mov    %edx,%r13d
  101b71:	jne    fc1a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1040>
  101b77:	movzbl -0xad4(%rbp),%r13d
  101b7f:	movzbl -0xb58(%rbp),%ecx
  101b86:	or     %r13d,%ecx
  101b89:	mov    %cl,-0xb40(%rbp)
  101b8f:	jmp    fc1a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1040>
  101b94:	nopl   0x0(%rax)
  101b98:	movss  0xc(%rbx),%xmm0
  101b9d:	pxor   %xmm5,%xmm5
  101ba1:	comiss %xmm5,%xmm0
  101ba4:	jbe    fc10e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xfae>
  101baa:	mov    -0xb74(%rbp),%r11d
  101bb1:	movb   $0x1,-0xbd0(%rbp)
  101bb8:	test   %r11d,%r11d
  101bbb:	setne  %sil
  101bbf:	jmp    fc117 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xfb7>
  101bc4:	nopl   0x0(%rax)
  101bc8:	mov    0x2de0(%rbx),%rdi
  101bcf:	test   %rdi,%rdi
  101bd2:	jne    102468 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7308>
  101bd8:	mov    -0xb30(%rbp),%ecx
  101bde:	mov    0x398(%rbx),%eax
  101be4:	lea    -0x2(%rcx),%edx
  101be7:	cmp    $0x1,%edx
  101bea:	ja     100cb0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5b50>
  101bf0:	cmpl   $0x3,-0xb30(%rbp)
  101bf7:	movb   $0x0,-0xad0(%rbp)
  101bfe:	jne    1026f7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7597>
  101c04:	movss  0xc(%rbx),%xmm0
  101c09:	pxor   %xmm6,%xmm6
  101c0d:	mov    $0x1,%edi
  101c12:	comiss %xmm6,%xmm0
  101c15:	seta   %dl
  101c18:	mov    %edx,%r13d
  101c1b:	jmp    fc0f1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf91>
  101c20:	mov    0x7a8(%rbx),%rax
  101c27:	jmp    fe488 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3328>
  101c2c:	nopl   0x0(%rax)
  101c30:	mov    0x798(%rbx),%rax
  101c37:	jmp    fe471 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3311>
  101c3c:	nopl   0x0(%rax)
  101c40:	lea    0x0(,%rdi,4),%rdx
  101c48:	mov    0x30(%rax),%rsi
  101c4c:	mov    %r12,%r8
  101c4f:	mov    0x32b0(%rbx),%rdi
  101c56:	mov    $0x3,%ecx
  101c5b:	call   6e130 <cudaMemcpyAsync@plt>
  101c60:	lea    0xf8351(%rip),%rsi        # 1f9fb8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x50b8>
  101c67:	mov    %eax,%edi
  101c69:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  101c6e:	jmp    fc036 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xed6>
  101c73:	nopl   0x0(%rax,%rax,1)
  101c78:	mov    0x710(%rbx),%r9d
  101c7f:	test   %r9d,%r9d
  101c82:	je     fb812 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6b2>
  101c88:	movzbl 0x4c(%rbx),%r8d
  101c8d:	movb   $0x1,-0xad9(%rbp)
  101c94:	test   %r8b,%r8b
  101c97:	jne    1021c8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7068>
  101c9d:	mov    $0x1,%r8d
  101ca3:	jmp    fb81c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6bc>
  101ca8:	nopl   0x0(%rax,%rax,1)
  101cb0:	movaps %xmm3,%xmm4
  101cb3:	jmp    fbee1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xd81>
  101cb8:	nopl   0x0(%rax,%rax,1)
  101cc0:	mov    0xf8(%rbx),%rax
  101cc7:	jmp    fbebd <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xd5d>
  101ccc:	nopl   0x0(%rax)
  101cd0:	mov    0xf8(%rbx),%rax
  101cd7:	jmp    100d99 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5c39>
  101cdc:	nopl   0x0(%rax)
  101ce0:	imul   %r12,%rax
  101ce4:	cmp    %rdx,%rax
  101ce7:	jbe    fb492 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x332>
  101ced:	jmp    766d8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x96>
  101cf2:	nopw   0x0(%rax,%rax,1)
  101cf8:	mov    0x148(%r14),%rdx
  101cff:	jmp    100d65 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5c05>
  101d04:	nopl   0x0(%rax)
  101d08:	movss  0xc(%rbx),%xmm0
  101d0d:	mulss  -0xacc(%rbp),%xmm0
  101d15:	sub    $0x8,%rsp
  101d19:	mov    -0xaf8(%rbp),%rax
  101d20:	mov    0x3070(%rbx),%rcx
  101d27:	mov    0x3a0(%rbx),%rdx
  101d2e:	mov    0x3d0(%rbx),%rsi
  101d35:	push   -0xaa8(%rbp)
  101d3b:	mov    0x398(%rbx),%r9d
  101d42:	mov    -0xa78(%rbp),%r8
  101d49:	mov    (%rax),%rdi
  101d4c:	call   6a7f0 <synreal::kernel::evaluate_affine_body_spring_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  101d51:	pop    %r9
  101d53:	pop    %r10
  101d55:	jmp    100f4e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5dee>
  101d5a:	nopw   0x0(%rax,%rax,1)
  101d60:	mov    0x148(%r14),%rax
  101d67:	jmp    fd58f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x242f>
  101d6c:	nopl   0x0(%rax)
  101d70:	mov    0x398(%rbx),%eax
  101d76:	movss  0xc(%rbx),%xmm0
  101d7b:	sub    $0x8,%rsp
  101d7f:	mulss  -0xacc(%rbp),%xmm0
  101d87:	mov    0x3380(%rbx),%rcx
  101d8e:	mov    0x3a0(%rbx),%rdx
  101d95:	mov    0x3d0(%rbx),%rsi
  101d9c:	push   -0xaa8(%rbp)
  101da2:	mov    0x3070(%rbx),%r9
  101da9:	push   %rax
  101daa:	mov    -0xaf8(%rbp),%rax
  101db1:	push   -0xa78(%rbp)
  101db7:	mov    0x33a0(%rbx),%r8
  101dbe:	mov    (%rax),%rdi
  101dc1:	call   6ad50 <synreal::kernel::evaluate_affine_body_so3_augmented_lagrangian_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  101dc6:	add    $0x20,%rsp
  101dca:	jmp    100fce <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5e6e>
  101dcf:	nop
  101dd0:	movss  0x64(%rbx),%xmm0
  101dd5:	comiss %xmm6,%xmm0
  101dd8:	seta   -0xb45(%rbp)
  101ddf:	jmp    fb95b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7fb>
  101de4:	nopl   0x0(%rax)
  101de8:	cmpq   $0x0,0x110(%rbx)
  101df0:	je     fbf21 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xdc1>
  101df6:	mov    0x108(%rbx),%rdx
  101dfd:	jmp    fbf21 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xdc1>
  101e02:	nopw   0x0(%rax,%rax,1)
  101e08:	mov    0x5d4(%rbx),%eax
  101e0e:	sub    $0x8,%rsp
  101e12:	mov    0x3d0(%rbx),%rcx
  101e19:	mov    0x3290(%rbx),%rdx
  101e20:	mov    0x3270(%rbx),%rsi
  101e27:	push   -0xaa8(%rbp)
  101e2d:	mov    0x5f0(%rbx),%r9
  101e34:	push   %rax
  101e35:	mov    -0xb18(%rbp),%rax
  101e3c:	mov    0x5e0(%rbx),%r8
  101e43:	push   %r12
  101e45:	push   0x3620(%rbx)
  101e4b:	push   0x3600(%rbx)
  101e51:	push   0x35e0(%rbx)
  101e57:	push   0x35c0(%rbx)
  101e5d:	push   0x35a0(%rbx)
  101e63:	push   0x630(%rbx)
  101e69:	push   0x620(%rbx)
  101e6f:	push   0x600(%rbx)
  101e75:	mov    (%rax),%rdi
  101e78:	call   6aa70 <synreal::kernel::update_joint_drive_angle_state(glm::vec<3, float, (glm::qualifier)0> const*, float*, int*, glm::vec<4, int, (glm::qualifier)0> const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, unsigned long, unsigned long, unsigned long)@plt>
  101e7d:	add    $0x60,%rsp
  101e81:	jmp    10175a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x65fa>
  101e86:	cs nopw 0x0(%rax,%rax,1)
  101e90:	sub    $0x140,%rsp
  101e97:	mov    -0xba0(%rbp),%rsi
  101e9e:	mov    $0x27,%ecx
  101ea3:	mov    %rsp,%rdi
  101ea6:	rep movsq %ds:(%rsi),%es:(%rdi)
  101ea9:	call   6a8e0 <synreal::kernel::snapshot_hard_contacts(synreal::kernel::HardContactView)@plt>
  101eae:	add    $0x140,%rsp
  101eb5:	jmp    1016bd <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x655d>
  101eba:	nopw   0x0(%rax,%rax,1)
  101ec0:	mov    0x56c(%rbx),%eax
  101ec6:	sub    $0x8,%rsp
  101eca:	mov    0x34e0(%rbx),%rcx
  101ed1:	mov    0x570(%rbx),%rdx
  101ed8:	mov    0x3d0(%rbx),%rsi
  101edf:	push   -0xaa8(%rbp)
  101ee5:	movss  -0xac4(%rbp),%xmm0
  101eed:	push   %rax
  101eee:	mov    0x568(%rbx),%eax
  101ef4:	mov    0x3520(%rbx),%r9
  101efb:	mov    0x3500(%rbx),%r8
  101f02:	push   %rax
  101f03:	mov    -0xaf8(%rbp),%rax
  101f0a:	push   -0xa68(%rbp)
  101f10:	push   %r12
  101f12:	push   0x3560(%rbx)
  101f18:	push   0x3580(%rbx)
  101f1e:	push   0x3540(%rbx)
  101f24:	push   0x5b0(%rbx)
  101f2a:	push   0x5a0(%rbx)
  101f30:	push   0x590(%rbx)
  101f36:	mov    (%rax),%rdi
  101f39:	call   6ab40 <synreal::kernel::evaluate_joint_body_point_line_augmented_lagrangian_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
  101f3e:	add    $0x60,%rsp
  101f42:	jmp    1010ce <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5f6e>
  101f47:	nopw   0x0(%rax,%rax,1)
  101f50:	mov    0x49c(%rbx),%eax
  101f56:	mov    0x4b0(%rbx),%rcx
  101f5d:	mov    0x4a0(%rbx),%rdx
  101f64:	mov    0x3d0(%rbx),%rsi
  101f6b:	push   -0xaa8(%rbp)
  101f71:	movss  -0xac4(%rbp),%xmm0
  101f79:	push   %rax
  101f7a:	mov    0x498(%rbx),%eax
  101f80:	push   %rax
  101f81:	mov    -0xaf8(%rbp),%rax
  101f88:	push   -0xba8(%rbp)
  101f8e:	push   %r12
  101f90:	push   0x3440(%rbx)
  101f96:	mov    0x4c0(%rbx),%r8
  101f9d:	mov    (%rax),%rdi
  101fa0:	push   0x4d0(%rbx)
  101fa6:	push   0x3420(%rbx)
  101fac:	mov    0x3400(%rbx),%r9
  101fb3:	call   6a890 <synreal::kernel::evaluate_joint_body_spring_augmented_lagrangian_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
  101fb8:	add    $0x40,%rsp
  101fbc:	jmp    10104e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5eee>
  101fc1:	nopl   0x0(%rax)
  101fc8:	mov    -0xb98(%rbp),%rax
  101fcf:	mov    -0xaa0(%rbp),%r9
  101fd6:	mov    0x2df0(%rbx),%r8
  101fdd:	mov    0x20(%rax),%rcx
  101fe1:	mov    0x28(%rax),%rdx
  101fe5:	mov    0x10(%rax),%rdi
  101fe9:	mov    (%rax),%rsi
  101fec:	call   6a920 <synreal::kernel::initialize_block_non_diagonal(synreal::NonZeroEntry const*, int const*, unsigned long, unsigned long, synreal::BlockNonZeroEntry*, unsigned long)@plt>
  101ff1:	jmp    101256 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x60f6>
  101ff6:	cs nopw 0x0(%rax,%rax,1)
  102000:	sub    $0x140,%rsp
  102007:	mov    -0xba0(%rbp),%rsi
  10200e:	mov    $0x27,%ecx
  102013:	mov    %rsp,%rdi
  102016:	rep movsq %ds:(%rsi),%es:(%rdi)
  102019:	call   6adc0 <synreal::kernel::initialize_hard_contacts(synreal::kernel::HardContactView)@plt>
  10201e:	add    $0x140,%rsp
  102025:	jmp    101614 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x64b4>
  10202a:	nopw   0x0(%rax,%rax,1)
  102030:	mov    0x2e50(%rbx),%rcx
  102037:	mov    0x2d10(%rbx),%rdx
  10203e:	mov    0x2cf0(%rbx),%rsi
  102045:	mov    0x3a0(%rbx),%rdi
  10204c:	mov    -0xaa8(%rbp),%r9
  102053:	mov    0x2e70(%rbx),%r8
  10205a:	call   6ae10 <synreal::kernel::refresh_inertial_cache_diagonals(float const*, unsigned long const*, int const*, float*, float*, unsigned long)@plt>
  10205f:	jmp    1018ff <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x679f>
  102064:	nopl   0x0(%rax)
  102068:	sub    $0x8,%rsp
  10206c:	mov    0x32d8(%rbx),%rsi
  102073:	mov    0x3090(%rbx),%rdi
  10207a:	mov    0x3338(%rbx),%rcx
  102081:	mov    0x3318(%rbx),%rdx
  102088:	push   -0xaa8(%rbp)
  10208e:	mov    -0xa90(%rbp),%r9
  102095:	mov    -0xa88(%rbp),%r8
  10209c:	call   6ab20 <synreal::kernel::initialize_triangle_drag(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, float*, unsigned long, unsigned long, unsigned long)@plt>
  1020a1:	pop    %rsi
  1020a2:	pop    %rdi
  1020a3:	jmp    10186f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x670f>
  1020a8:	nopl   0x0(%rax,%rax,1)
  1020b0:	mov    0x4f0(%rbx),%eax
  1020b6:	sub    $0x8,%rsp
  1020ba:	mov    0x508(%rbx),%rcx
  1020c1:	mov    0x4f8(%rbx),%rdx
  1020c8:	mov    0x3d0(%rbx),%rsi
  1020cf:	push   -0xaa8(%rbp)
  1020d5:	push   %rax
  1020d6:	mov    -0xaf8(%rbp),%rax
  1020dd:	push   -0xb80(%rbp)
  1020e3:	push   0x34c0(%rbx)
  1020e9:	push   0x34a0(%rbx)
  1020ef:	mov    0x518(%rbx),%r8
  1020f6:	push   0x558(%rbx)
  1020fc:	mov    (%rax),%rdi
  1020ff:	push   0x3480(%rbx)
  102105:	mov    0x3460(%rbx),%r9
  10210c:	call   6ad30 <synreal::kernel::initialize_body_distance_constraint_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  102111:	add    $0x40,%rsp
  102115:	jmp    1017e7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6687>
  10211a:	nopw   0x0(%rax,%rax,1)
  102120:	movss  0x60(%rbx),%xmm0
  102125:	mov    0x400(%rbx),%ecx
  10212b:	xor    %r9d,%r9d
  10212e:	mov    0x3170(%rbx),%rdx
  102135:	mov    0x3150(%rbx),%rsi
  10213c:	mov    0x438(%rbx),%rdi
  102143:	movss  0x70(%rbx),%xmm4
  102148:	push   $0x0
  10214a:	movss  0x6c(%rbx),%xmm3
  10214f:	movss  0x68(%rbx),%xmm2
  102154:	push   $0x1
  102156:	movss  0x64(%rbx),%xmm1
  10215b:	mov    -0xa70(%rbp),%r8
  102162:	call   6aaa0 <synreal::kernel::prepare_cable_penalties(glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0>*, int*, unsigned long, unsigned long, float, float, float, float, float, bool, bool, int const*)@plt>
  102167:	pop    %r9
  102169:	pop    %r10
  10216b:	jmp    1012d8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6178>
  102170:	push   -0xb58(%rbp)
  102176:	mov    $0x27,%ecx
  10217b:	mov    %r13,%r9
  10217e:	xor    %edx,%edx
  102180:	mov    -0x798(%rbp),%rsi
  102187:	sub    $0x138,%rsp
  10218e:	mov    %rsp,%rdi
  102191:	rep movsq %ds:(%rsi),%es:(%rdi)
  102194:	xor    %esi,%esi
  102196:	xor    %edi,%edi
  102198:	mov    -0xb70(%rbp),%r8
  10219f:	call   6aeb0 <synreal::kernel::evaluate_hard_contacts(synreal::kernel::HardContactView, glm::vec<3, float, (glm::qualifier)0>*, float*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, float*)@plt>
  1021a4:	add    $0x140,%rsp
  1021ab:	jmp    10197f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x681f>
  1021b0:	movb   $0x1,-0xb40(%rbp)
  1021b7:	mov    $0x1,%r13d
  1021bd:	jmp    fc1a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1040>
  1021c2:	nopw   0x0(%rax,%rax,1)
  1021c8:	lea    -0x2b0(%rbp),%rdi
  1021cf:	xor    %eax,%eax
  1021d1:	mov    $0x27,%ecx
  1021d6:	movb   $0x1,-0xad8(%rbp)
  1021dd:	mov    %rdi,-0xba0(%rbp)
  1021e4:	rep stos %rax,%es:(%rdi)
  1021e7:	mov    0xfadaa(%rip),%rax        # 1fcf98 <cuda::std::__4::in_place+0x4b>
  1021ee:	movl   $0x3f733333,-0x1c4(%rbp)
  1021f8:	movb   $0x1,-0x1b2(%rbp)
  1021ff:	mov    %rax,-0x1bc(%rbp)
  102206:	mov    %esi,%eax
  102208:	cmp    0x31a0(%rbx),%rax
  10220f:	ja     102820 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x76c0>
  102215:	lea    -0x500(%rbp),%rcx
  10221c:	mov    %rcx,-0xbb8(%rbp)
  102223:	movdqu 0x40(%r14),%xmm7
  102229:	movdqu 0x60(%r14),%xmm6
  10222f:	mov    %rax,-0x2a8(%rbp)
  102236:	movdqu 0x30(%r14),%xmm3
  10223c:	movdqu 0x50(%r14),%xmm2
  102242:	movdqu 0x80(%r14),%xmm5
  10224b:	movdqu 0x70(%r14),%xmm1
  102251:	punpckhqdq %xmm6,%xmm2
  102255:	movdqu 0x10(%r14),%xmm4
  10225b:	punpckhqdq %xmm7,%xmm3
  10225f:	movdqu 0x20(%r14),%xmm6
  102265:	movdqu 0xa0(%r14),%xmm7
  10226e:	punpckhqdq %xmm5,%xmm1
  102272:	mov    (%r14),%rcx
  102275:	movaps %xmm2,-0x280(%rbp)
  10227c:	movdqu 0x90(%r14),%xmm0
  102285:	movdqu 0x740(%rbx),%xmm5
  10228d:	punpckhqdq %xmm6,%xmm4
  102291:	movaps %xmm1,-0x270(%rbp)
  102298:	movdqu 0x730(%rbx),%xmm1
  1022a0:	movaps %xmm4,-0x2a0(%rbp)
  1022a7:	movdqu 0x760(%rbx),%xmm4
  1022af:	punpckhqdq %xmm7,%xmm0
  1022b3:	mov    0x788(%rbx),%rax
  1022ba:	movdqu 0x720(%rbx),%xmm7
  1022c2:	mov    %rcx,-0x2b0(%rbp)
  1022c9:	movaps %xmm0,-0x260(%rbp)
  1022d0:	movdqu 0x750(%rbx),%xmm0
  1022d8:	punpckhqdq %xmm5,%xmm1
  1022dc:	movdqu 0x710(%rbx),%xmm2
  1022e4:	movaps %xmm1,-0x240(%rbp)
  1022eb:	movd   -0xac8(%rbp),%xmm1
  1022f3:	punpckhqdq %xmm4,%xmm0
  1022f7:	mov    %rax,-0x220(%rbp)
  1022fe:	mov    -0xa80(%rbp),%rax
  102305:	punpckhqdq %xmm7,%xmm2
  102309:	movaps %xmm0,-0x230(%rbp)
  102310:	movd   %r9d,%xmm0
  102315:	punpcklqdq %xmm1,%xmm0
  102319:	movaps %xmm2,-0x250(%rbp)
  102320:	movups %xmm0,-0x218(%rbp)
  102327:	movaps %xmm3,-0x290(%rbp)
  10232e:	mov    %rax,-0x208(%rbp)
  102335:	mov    0x3e0(%rbx),%rax
  10233c:	movdqu 0x3f0(%rbx),%xmm0
  102344:	movdqu 0x3d0(%rbx),%xmm6
  10234c:	mov    %rax,-0x1f0(%rbp)
  102353:	mov    -0xaf8(%rbp),%rax
  10235a:	punpcklqdq %xmm6,%xmm0
  10235e:	movss  0x58(%rbx),%xmm2
  102363:	movss  0x54(%rbx),%xmm1
  102368:	mov    (%rax),%rax
  10236b:	movaps %xmm0,-0x200(%rbp)
  102372:	movd   %edx,%xmm0
  102376:	movdqu 0x31b0(%rbx),%xmm5
  10237e:	movhps -0xaa8(%rbp),%xmm0
  102385:	unpcklps %xmm2,%xmm1
  102388:	movss  0x50(%rbx),%xmm2
  10238d:	movdqu 0x31f0(%rbx),%xmm4
  102395:	movups %xmm0,-0x1e8(%rbp)
  10239c:	movq   %rax,%xmm0
  1023a1:	movhps 0x3090(%rbx),%xmm0
  1023a8:	mov    %rax,-0xb38(%rbp)
  1023af:	xor    %eax,%eax
  1023b1:	mov    0x4d(%rbx),%al
  1023b4:	movups %xmm0,-0x1d8(%rbp)
  1023bb:	movss  0xfabbd(%rip),%xmm0        # 1fcf80 <cuda::std::__4::in_place+0x33>
  1023c3:	mov    0x4e(%rbx),%ah
  1023c6:	divss  -0xae4(%rbp),%xmm0
  1023ce:	unpcklps %xmm2,%xmm0
  1023d1:	movlhps %xmm1,%xmm0
  1023d4:	mov    %ax,-0x1b4(%rbp)
  1023db:	movzbl 0xb8(%r14),%eax
  1023e3:	movups %xmm0,-0x1c8(%rbp)
  1023ea:	movss  0x5c(%rbx),%xmm0
  1023ef:	mov    %al,-0x1b2(%rbp)
  1023f5:	movss  %xmm0,-0x1b8(%rbp)
  1023fd:	movdqu 0x3190(%rbx),%xmm0
  102405:	punpcklqdq %xmm5,%xmm0
  102409:	movaps %xmm0,-0x1b0(%rbp)
  102410:	movdqu 0x31d0(%rbx),%xmm0
  102418:	punpcklqdq %xmm4,%xmm0
  10241c:	movaps %xmm0,-0x1a0(%rbp)
  102423:	movdqu 0x3210(%rbx),%xmm0
  10242b:	movdqu 0x3230(%rbx),%xmm7
  102433:	mov    0x3250(%rbx),%rax
  10243a:	punpcklqdq %xmm7,%xmm0
  10243e:	mov    %rax,-0x180(%rbp)
  102445:	movaps %xmm0,-0x190(%rbp)
  10244c:	jmp    fb868 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x708>
  102451:	nopl   0x0(%rax)
  102458:	mov    $0x1,%edi
  10245d:	jmp    fc0e3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf83>
  102462:	nopw   0x0(%rax,%rax,1)
  102468:	mov    0xfab21(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
  10246f:	mov    -0xaf0(%rbp),%r12
  102476:	movl   $0x1,-0x638(%rbp)
  102480:	mov    %rax,-0x640(%rbp)
  102487:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
  10248c:	mov    -0x638(%rbp),%ecx
  102492:	xor    %r8d,%r8d
  102495:	mov    %r12,%r9
  102498:	mov    %eax,-0x5a0(%rbp)
  10249e:	mov    -0x640(%rbp),%rdx
  1024a5:	movabs $0x100000001,%rax
  1024af:	mov    %rax,-0x59c(%rbp)
  1024b6:	mov    -0x5a0(%rbp),%rdi
  1024bd:	mov    -0x598(%rbp),%esi
  1024c3:	call   6f040 <__cudaPushCallConfiguration@plt>
  1024c8:	test   %eax,%eax
  1024ca:	jne    10254a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x73ea>
  1024cc:	cmpl   $0x1,-0xb1c(%rbp)
  1024d3:	mov    0x2de0(%rbx),%r11
  1024da:	pxor   %xmm4,%xmm4
  1024de:	mov    0x2dd0(%rbx),%r10
  1024e5:	mov    0x2db0(%rbx),%rax
  1024ec:	mov    0x2d90(%rbx),%r9
  1024f3:	mov    0x2d70(%rbx),%r8
  1024fa:	mov    0x2d50(%rbx),%rcx
  102501:	mov    0x2d30(%rbx),%rdx
  102508:	mov    0x2c50(%rbx),%rsi
  10250f:	mov    0x2c30(%rbx),%rdi
  102516:	movss  0xc(%rbx),%xmm3
  10251b:	jne    102949 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x77e9>
  102521:	sub    $0x8,%rsp
  102525:	movss  -0xb10(%rbp),%xmm1
  10252d:	movaps %xmm3,%xmm5
  102530:	pxor   %xmm2,%xmm2
  102534:	push   %r11
  102536:	movss  -0xacc(%rbp),%xmm0
  10253e:	push   %r10
  102540:	push   %rax
  102541:	call   6ac50 <synreal::kernel::combine_system_non_diagonal(float, float, float, float, float, float, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry*, unsigned long)@plt>
  102546:	add    $0x20,%rsp
  10254a:	call   6c900 <cudaGetLastError@plt>
  10254f:	lea    0xf7bea(%rip),%rsi        # 1fa140 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5240>
  102556:	mov    %eax,%edi
  102558:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  10255d:	jmp    100c90 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5b30>
  102562:	nopw   0x0(%rax,%rax,1)
  102568:	mov    0x3250(%rbx),%rdi
  10256f:	mov    %r12,%rcx
  102572:	mov    $0x4,%edx
  102577:	xor    %esi,%esi
  102579:	call   6e9d0 <cudaMemsetAsync@plt>
  10257e:	mov    %eax,%edi
  102580:	lea    0xf86d1(%rip),%rsi        # 1fac58 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5d58>
  102587:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  10258c:	jmp    1016d0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6570>
  102591:	nopl   0x0(%rax)
  102598:	sub    $0x8,%rsp
  10259c:	mov    0x3a0(%rbx),%rcx
  1025a3:	mov    0x2c90(%rbx),%rdx
  1025aa:	mov    0x2c70(%rbx),%rsi
  1025b1:	mov    0xe8(%rbx),%rdi
  1025b8:	push   0x2c60(%rbx)
  1025be:	mov    0x2cd0(%rbx),%r9
  1025c5:	push   0x2d30(%rbx)
  1025cb:	mov    0x2cb0(%rbx),%r8
  1025d2:	push   0x2c50(%rbx)
  1025d8:	call   6a980 <synreal::kernel::refresh_inertial_cache_nonzeros(float const*, unsigned long const*, int const*, float const*, unsigned long const*, int const*, synreal::NonZeroEntry*, synreal::NonZeroEntry*, unsigned long)@plt>
  1025dd:	add    $0x20,%rsp
  1025e1:	jmp    fbdd3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xc73>
  1025e6:	cs nopw 0x0(%rax,%rax,1)
  1025f0:	mov    -0x790(%rbp),%rax
  1025f7:	mov    -0x7a8(%rbp),%rdi
  1025fe:	sub    $0x8,%rsp
  102602:	mov    -0x770(%rbp),%rdx
  102609:	mov    -0x768(%rbp),%r10
  102610:	mov    0x48(%rdi),%r9
  102614:	mov    0x38(%rdi),%r8
  102618:	mov    0x28(%rdi),%rcx
  10261c:	mov    0x10(%rdi),%esi
  10261f:	movss  0x48(%rax),%xmm0
  102624:	movss  0xfa954(%rip),%xmm1        # 1fcf80 <cuda::std::__4::in_place+0x33>
  10262c:	divss  (%rdx),%xmm1
  102630:	mov    0x18(%rdi),%rdx
  102634:	push   %r13
  102636:	push   -0xb70(%rbp)
  10263c:	push   (%r10)
  10263f:	mov    -0x778(%rbp),%r10
  102646:	push   $0x0
  102648:	push   $0x0
  10264a:	push   0x3090(%rax)
  102650:	push   (%r10)
  102653:	mov    0x398(%rax),%r10d
  10265a:	push   %r10
  10265c:	push   0x3e0(%rax)
  102662:	push   0x3d0(%rax)
  102668:	push   0x3f0(%rax)
  10266e:	mov    -0x780(%rbp),%r10
  102675:	push   (%r10)
  102678:	mov    -0x788(%rbp),%r10
  10267f:	mov    (%r10),%r10d
  102682:	push   %r10
  102684:	mov    0x710(%rax),%r10d
  10268b:	push   %r10
  10268d:	push   0x788(%rax)
  102693:	push   0x778(%rax)
  102699:	push   0x768(%rax)
  10269f:	push   0x758(%rax)
  1026a5:	push   0x748(%rax)
  1026ab:	push   0x738(%rax)
  1026b1:	push   0x728(%rax)
  1026b7:	push   0x718(%rax)
  1026bd:	push   0x98(%rdi)
  1026c3:	push   0x88(%rdi)
  1026c9:	push   0x78(%rdi)
  1026cc:	push   0x68(%rdi)
  1026cf:	push   0x58(%rdi)
  1026d2:	mov    (%rdi),%rdi
  1026d5:	call   6af00 <synreal::kernel::evaluate_contact_tangent(int const*, unsigned long, int const*, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, int const*, int const*, synreal::Transform const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float const*, float const*, float, unsigned long, unsigned long, unsigned long, int const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, unsigned long, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, float, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  1026da:	add    $0xe0,%rsp
  1026e1:	jmp    100610 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x54b0>
  1026e6:	cs nopw 0x0(%rax,%rax,1)
  1026f0:	movb   $0x0,-0xad0(%rbp)
  1026f7:	xor    %r13d,%r13d
  1026fa:	xor    %edx,%edx
  1026fc:	mov    $0x1,%edi
  102701:	jmp    fc0f1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf91>
  102706:	cs nopw 0x0(%rax,%rax,1)
  102710:	mov    0xfa879(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
  102717:	mov    -0xaf0(%rbp),%r12
  10271e:	movl   $0x1,-0x638(%rbp)
  102728:	mov    %rax,-0x640(%rbp)
  10272f:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
  102734:	mov    -0x638(%rbp),%ecx
  10273a:	xor    %r8d,%r8d
  10273d:	mov    %r12,%r9
  102740:	mov    %eax,-0x5a0(%rbp)
  102746:	mov    -0x640(%rbp),%rdx
  10274d:	movabs $0x100000001,%rax
  102757:	mov    %rax,-0x59c(%rbp)
  10275e:	mov    -0x5a0(%rbp),%rdi
  102765:	mov    -0x598(%rbp),%esi
  10276b:	call   6f040 <__cudaPushCallConfiguration@plt>
  102770:	test   %eax,%eax
  102772:	je     102994 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7834>
  102778:	call   6c900 <cudaGetLastError@plt>
  10277d:	lea    0xf7984(%rip),%rsi        # 1fa108 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5208>
  102784:	mov    %eax,%edi
  102786:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  10278b:	jmp    fc0c1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf61>
  102790:	mov    0xfa7f9(%rip),%rax        # 1fcf90 <cuda::std::__4::in_place+0x43>
  102797:	mov    -0xba8(%rbp),%rdi
  10279e:	movl   $0x1,-0x638(%rbp)
  1027a8:	mov    -0xaf0(%rbp),%r12
  1027af:	mov    %rax,-0x640(%rbp)
  1027b6:	call   6cdd0 <(anonymous namespace)::block_count(unsigned long)@plt>
  1027bb:	mov    -0x638(%rbp),%ecx
  1027c1:	xor    %r8d,%r8d
  1027c4:	mov    %r12,%r9
  1027c7:	mov    %eax,-0x5a0(%rbp)
  1027cd:	mov    -0x640(%rbp),%rdx
  1027d4:	movabs $0x100000001,%rax
  1027de:	mov    %rax,-0x59c(%rbp)
  1027e5:	mov    -0x5a0(%rbp),%rdi
  1027ec:	mov    -0x598(%rbp),%esi
  1027f2:	call   6f040 <__cudaPushCallConfiguration@plt>
  1027f7:	test   %eax,%eax
  1027f9:	je     102a0b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78ab>
  1027ff:	call   6c900 <cudaGetLastError@plt>
  102804:	lea    0xf78cd(%rip),%rsi        # 1fa0d8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x51d8>
  10280b:	mov    %eax,%edi
  10280d:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  102812:	jmp    fc0b1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf51>
  102817:	nopw   0x0(%rax,%rax,1)
  102820:	lea    -0x500(%rbp),%rax
  102827:	mov    -0xaf0(%rbp),%rdi
  10282e:	mov    %rax,%rsi
  102831:	mov    %rax,-0xbb8(%rbp)
  102838:	call   6d790 <cudaStreamIsCapturing@plt>
  10283d:	lea    0xf764c(%rip),%rsi        # 1f9e90 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x4f90>
  102844:	mov    %eax,%edi
  102846:	call   6dd80 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  10284b:	mov    -0x500(%rbp),%r12d
  102852:	test   %r12d,%r12d
  102855:	jne    76642 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]>
  10285b:	mov    (%rbx),%rax
  10285e:	mov    0x10(%r14),%esi
  102862:	mov    %rbx,%rdi
  102865:	call   *0x18(%rax)
  102868:	mov    0x10(%r14),%eax
  10286c:	mov    0x710(%rbx),%r9d
  102873:	mov    0x398(%rbx),%edx
  102879:	movzbl -0xad9(%rbp),%r8d
  102881:	mov    %rax,%rsi
  102884:	jmp    102223 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x70c3>
  102889:	nopl   0x0(%rax)
  102890:	movss  0xc(%rbx),%xmm0
  102895:	pxor   %xmm4,%xmm4
  102899:	movzbl -0xb58(%rbp),%r11d
  1028a1:	comiss %xmm4,%xmm0
  1028a4:	cmovbe %r11d,%edx
  1028a8:	mov    %dl,-0xb10(%rbp)
  1028ae:	jmp    fc15b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xffb>
  1028b3:	nopl   0x0(%rax,%rax,1)
  1028b8:	mov    -0xaf0(%rbp),%r12
  1028bf:	jmp    fe1a3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3043>
  1028c4:	mov    -0xaf8(%rbp),%rax
  1028cb:	sub    $0x8,%rsp
  1028cf:	mov    0x32b0(%rbx),%rdx
  1028d6:	mov    0x3090(%rbx),%rdi
  1028dd:	mov    0x10(%rax),%rsi
  1028e1:	push   -0x6f0(%rbp)
  1028e7:	push   -0x6f8(%rbp)
  1028ed:	push   -0x700(%rbp)
  1028f3:	push   -0x708(%rbp)
  1028f9:	push   -0x710(%rbp)
  1028ff:	push   -0x718(%rbp)
  102905:	push   -0x720(%rbp)
  10290b:	push   -0x728(%rbp)
  102911:	push   -0x730(%rbp)
  102917:	push   -0x738(%rbp)
  10291d:	push   -0x740(%rbp)
  102923:	push   -0x748(%rbp)
  102929:	push   -0x750(%rbp)
  10292f:	push   -0x758(%rbp)
  102935:	push   -0x760(%rbp)
  10293b:	call   6abb0 <synreal::kernel::initialize_joint_coordinate_velocities(synreal::kernel::JointCoordinateView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float*)@plt>
  102940:	sub    $0xffffffffffffff80,%rsp
  102944:	jmp    fc023 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xec3>
  102949:	movaps %xmm3,%xmm4
  10294c:	jmp    102521 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x73c1>
  102951:	mov    -0xaf8(%rbp),%rax
  102958:	sub    $0x8,%rsp
  10295c:	mov    0x3380(%rbx),%rdx
  102963:	mov    0x33a0(%rbx),%rcx
  10296a:	mov    0x3d0(%rbx),%rsi
  102971:	push   -0xaa8(%rbp)
  102977:	mov    (%rax),%rdi
  10297a:	mov    0x398(%rbx),%r9d
  102981:	mov    -0xa78(%rbp),%r8
  102988:	call   6afc0 <synreal::kernel::initialize_affine_body_so3_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  10298d:	pop    %rax
  10298e:	pop    %rdx
  10298f:	jmp    1011b0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6050>
  102994:	mov    0x56c(%rbx),%eax
  10299a:	sub    $0x8,%rsp
  10299e:	mov    0x34e0(%rbx),%rcx
  1029a5:	mov    0x570(%rbx),%rdx
  1029ac:	mov    0x3d0(%rbx),%rsi
  1029b3:	push   -0xaa8(%rbp)
  1029b9:	mov    0x3520(%rbx),%r9
  1029c0:	push   %rax
  1029c1:	mov    0x568(%rbx),%eax
  1029c7:	mov    0x3500(%rbx),%r8
  1029ce:	push   %rax
  1029cf:	mov    -0xaf8(%rbp),%rax
  1029d6:	push   -0xa68(%rbp)
  1029dc:	push   0x3560(%rbx)
  1029e2:	push   0x3580(%rbx)
  1029e8:	push   0x3540(%rbx)
  1029ee:	push   0x5a0(%rbx)
  1029f4:	push   0x590(%rbx)
  1029fa:	mov    (%rax),%rdi
  1029fd:	call   6a9e0 <synreal::kernel::initialize_joint_body_point_line_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
  102a02:	add    $0x50,%rsp
  102a06:	jmp    102778 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7618>
  102a0b:	mov    0x3440(%rbx),%rdi
  102a12:	mov    -0xba8(%rbp),%rsi
  102a19:	call   6ab80 <synreal::kernel::initialize_joint_body_spring_state(glm::vec<3, float, (glm::qualifier)0>*, unsigned long)@plt>
  102a1e:	jmp    1027ff <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x769f>
  102a23:	call   6d630 <__stack_chk_fail@plt>
  102a28:	jmp    76915 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x2d3>
  102a2d:	endbr64 
  102a31:	mov    %rax,%rbx
  102a34:	jmp    76815 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x1d3>
  102a39:	jmp    76dee <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x7ac>
  102a3e:	jmp    76cca <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x688>
  102a43:	jmp    7695e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x31c>
  102a48:	jmp    76a82 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x440>
  102a4d:	jmp    76b14 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x4d2>
  102a52:	jmp    76b5d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x51b>
  102a57:	jmp    76ba6 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x564>
  102a5c:	jmp    76bef <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x5ad>
  102a61:	jmp    76cfc <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x6ba>
  102a66:	jmp    76f12 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x8d0>
  102a6b:	jmp    76e20 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x7de>
  102a70:	jmp    76eb2 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x870>
  102a75:	endbr64 
  102a79:	mov    %rax,%rbx
  102a7c:	jmp    767f8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x1b6>
  102a81:	jmp    76f8d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x94b>
  102a86:	jmp    7683a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x1f8>
  102a8b:	nop
  102a8c:	nopl   0x0(%rax)
