
style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so：     文件格式 elf64-x86-64


Disassembly of section .text:

00000000000fb060 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)>:
   fb060:	endbr64 
   fb064:	push   %rbp
   fb065:	movq   %rsi,%xmm5
   fb06a:	movq   %rdi,%xmm6
   fb06f:	punpcklqdq %xmm6,%xmm5
   fb073:	mov    %rsp,%rbp
   fb076:	push   %r15
   fb078:	push   %r14
   fb07a:	mov    %r8,%r14
   fb07d:	push   %r13
   fb07f:	push   %r12
   fb081:	push   %rbx
   fb082:	mov    %rdi,%rbx
   fb085:	sub    $0xbd8,%rsp
   fb08c:	mov    %rsi,-0xaf8(%rbp)
   fb093:	mov    0xa8(%rdi),%esi
   fb099:	mov    %rdx,-0xb18(%rbp)
   fb0a0:	lea    -0xad4(%rbp),%rdx
   fb0a7:	mov    %rcx,-0xb88(%rbp)
   fb0ae:	movq   %rdx,%xmm6
   fb0b3:	mov    %r9,-0xaf0(%rbp)
   fb0ba:	movss  %xmm0,-0xae4(%rbp)
   fb0c2:	mov    %fs:0x28,%rax
   fb0cb:	mov    %rax,-0x38(%rbp)
   fb0cf:	xor    %eax,%eax
   fb0d1:	lea    -0xa70(%rbp),%rax
   fb0d8:	movaps %xmm5,-0xb70(%rbp)
   fb0df:	movq   %rax,%xmm7
   fb0e4:	lea    -0xaf0(%rbp),%rax
   fb0eb:	mov    %rsi,-0xaa8(%rbp)
   fb0f2:	mov    %rax,%rcx
   fb0f5:	mov    %rax,-0xb00(%rbp)
   fb0fc:	punpcklqdq %xmm7,%xmm6
   fb100:	lea    -0x6e0(%rbp),%rax
   fb107:	movq   %rax,%xmm5
   fb10c:	movq   %rcx,%xmm7
   fb111:	mov    0xac(%rdi),%eax
   fb117:	movaps %xmm6,-0xb30(%rbp)
   fb11e:	punpcklqdq %xmm5,%xmm7
   fb122:	movaps %xmm7,-0xb10(%rbp)
   fb129:	test   %eax,%eax
   fb12b:	je     fe240 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x31e0>
   fb131:	mov    %rax,-0xaa0(%rbp)
   fb138:	movaps %xmm0,%xmm2
   fb13b:	pxor   %xmm6,%xmm6
   fb13f:	comiss %xmm6,%xmm2
   fb142:	jbe    76e20 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x83e>
   fb148:	movss  0xf463c(%rip),%xmm0        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
   fb150:	movss  0xf4648(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
   fb158:	movaps %xmm2,%xmm3
   fb15b:	andps  %xmm1,%xmm3
   fb15e:	ucomiss %xmm3,%xmm0
   fb161:	jb     76e20 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x83e>
   fb167:	mov    -0xaf8(%rbp),%rcx
   fb16e:	cmp    %rax,0x8(%rcx)
   fb172:	jb     102939 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78d9>
   fb178:	cmp    %rax,0x18(%rcx)
   fb17c:	jb     76d8e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x7ac>
   fb182:	mov    0x28(%rcx),%rdx
   fb186:	cmp    %rax,%rdx
   fb189:	setb   -0xae8(%rbp)
   fb190:	test   %rdx,%rdx
   fb193:	movzbl -0xae8(%rbp),%ecx
   fb19a:	setne  %dl
   fb19d:	and    %cl,%dl
   fb19f:	mov    %edx,%r15d
   fb1a2:	jne    10296b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x790b>
   fb1a8:	mov    -0xb18(%rbp),%rdx
   fb1af:	cmp    %rax,0x8(%rdx)
   fb1b3:	jb     102966 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7906>
   fb1b9:	cmp    %rax,0x18(%rdx)
   fb1bd:	jb     76eb2 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x8d0>
   fb1c3:	mov    0x10(%r14),%ecx
   fb1c7:	test   %ecx,%ecx
   fb1c9:	je     fb24f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ef>
   fb1cf:	cmpq   $0x0,0x8(%r14)
   fb1d4:	je     7686c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x28a>
   fb1da:	mov    %ecx,%edx
   fb1dc:	cmp    0x20(%r14),%rdx
   fb1e0:	ja     7686c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x28a>
   fb1e6:	cmp    0x30(%r14),%rdx
   fb1ea:	ja     7686c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x28a>
   fb1f0:	cmp    0x40(%r14),%rdx
   fb1f4:	ja     7686c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x28a>
   fb1fa:	cmp    0x50(%r14),%rdx
   fb1fe:	ja     7686c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x28a>
   fb204:	cmp    0x80(%r14),%rdx
   fb20b:	ja     7686c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x28a>
   fb211:	cmp    0x90(%r14),%rdx
   fb218:	ja     7686c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x28a>
   fb21e:	cmp    0xa0(%r14),%rdx
   fb225:	ja     7686c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x28a>
   fb22b:	mov    0x60(%r14),%rdi
   fb22f:	test   %rdi,%rdi
   fb232:	je     fb23d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1dd>
   fb234:	cmp    %rdi,%rdx
   fb237:	ja     76646 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x64>
   fb23d:	mov    0x70(%r14),%rdi
   fb241:	test   %rdi,%rdi
   fb244:	je     fb24f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ef>
   fb246:	cmp    %rdi,%rdx
   fb249:	ja     76646 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x64>
   fb24f:	mov    0xb0(%r14),%rdx
   fb256:	test   %rdx,%rdx
   fb259:	je     fe260 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3200>
   fb25f:	cmp    %rdx,%rcx
   fb262:	ja     102970 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7910>
   fb268:	mov    0x130(%r14),%rdi
   fb26f:	mov    0xd0(%r14),%ecx
   fb276:	test   %rdi,%rdi
   fb279:	jne    fb289 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x229>
   fb27b:	cmpq   $0x0,0x140(%r14)
   fb283:	je     fe460 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3400>
   fb289:	mov    %ecx,%edx
   fb28b:	cmp    %rdi,%rdx
   fb28e:	ja     7680c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x22a>
   fb294:	cmp    0x140(%r14),%rdx
   fb29b:	ja     7680c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x22a>
   fb2a1:	test   %ecx,%ecx
   fb2a3:	je     100ff0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5f90>
   fb2a9:	cmpq   $0x0,0xc8(%r14)
   fb2b1:	je     10293e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78de>
   fb2b7:	cmpq   $0x0,0x150(%r14)
   fb2bf:	mov    $0x1,%r15d
   fb2c5:	jne    fe478 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3418>
   fb2cb:	cmp    %rdx,0xf0(%r14)
   fb2d2:	jb     76c6a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x688>
   fb2d8:	cmp    %rdx,0x100(%r14)
   fb2df:	jb     76c6a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x688>
   fb2e5:	cmp    %rdx,0x110(%r14)
   fb2ec:	jb     76c6a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x688>
   fb2f2:	cmp    %rdx,0x120(%r14)
   fb2f9:	jb     76c6a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x688>
   fb2ff:	mov    $0x1,%r12d
   fb305:	test   %rsi,%rsi
   fb308:	je     fb312 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2b2>
   fb30a:	xor    %edx,%edx
   fb30c:	div    %rsi
   fb30f:	mov    %rax,%r12
   fb312:	mov    -0xb88(%rbp),%rcx
   fb319:	mov    0x2e0(%rbx),%eax
   fb31f:	mov    0x48(%rcx),%rdx
   fb323:	imul   %r12,%rax
   fb327:	test   %rdx,%rdx
   fb32a:	setne  %cl
   fb32d:	cmp    %rdx,%rax
   fb330:	mov    %rax,-0xa98(%rbp)
   fb337:	seta   %al
   fb33a:	test   %al,%cl
   fb33c:	jne    76cfc <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x71a>
   fb342:	mov    0x5d4(%rbx),%eax
   fb348:	test   %eax,%eax
   fb34a:	je     fb392 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x332>
   fb34c:	mov    0x5d8(%rbx),%edx
   fb352:	mov    -0xb88(%rbp),%rsi
   fb359:	imul   %r12,%rdx
   fb35d:	cmp    0x8(%rsi),%rdx
   fb361:	ja     76d45 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x763>
   fb367:	mov    0x5dc(%rbx),%ecx
   fb36d:	imul   %r12,%rcx
   fb371:	cmp    0x18(%rsi),%rcx
   fb375:	ja     76d45 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x763>
   fb37b:	cmp    0x28(%rsi),%rdx
   fb37f:	ja     76d45 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x763>
   fb385:	mov    0x38(%rsi),%rdx
   fb389:	test   %rdx,%rdx
   fb38c:	jne    101be0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6b80>
   fb392:	cmpl   $0x3e7,0x20(%rbx)
   fb399:	ja     10295c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78fc>
   fb39f:	mov    0x24(%rbx),%eax
   fb3a2:	sub    $0x1,%eax
   fb3a5:	cmp    $0x3e6,%eax
   fb3aa:	ja     76bc1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x5df>
   fb3b0:	movss  0xc(%rbx),%xmm3
   fb3b5:	pxor   %xmm7,%xmm7
   fb3b9:	comiss %xmm7,%xmm3
   fb3bc:	jb     76bf3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x611>
   fb3c2:	andps  %xmm1,%xmm3
   fb3c5:	ucomiss %xmm3,%xmm0
   fb3c8:	jb     76bf3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x611>
   fb3ce:	mov    0x14(%rbx),%eax
   fb3d1:	sub    $0x1,%eax
   fb3d4:	cmp    $0x3e6,%eax
   fb3d9:	ja     102961 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7901>
   fb3df:	mov    0x18(%rbx),%eax
   fb3e2:	sub    $0x1,%eax
   fb3e5:	cmp    $0x3e6,%eax
   fb3ea:	ja     76738 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x156>
   fb3f0:	movss  0x74(%rbx),%xmm3
   fb3f5:	comiss %xmm7,%xmm3
   fb3f8:	jbe    76614 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x32>
   fb3fe:	andps  %xmm1,%xmm3
   fb401:	ucomiss %xmm3,%xmm0
   fb404:	jb     76614 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x32>
   fb40a:	movss  0x78(%rbx),%xmm3
   fb40f:	comiss %xmm7,%xmm3
   fb412:	jb     102928 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78c8>
   fb418:	andps  %xmm1,%xmm3
   fb41b:	ucomiss %xmm3,%xmm0
   fb41e:	jb     768b5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x2d3>
   fb424:	movss  0x7c(%rbx),%xmm3
   fb429:	comiss %xmm7,%xmm3
   fb42c:	jb     768b5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x2d3>
   fb432:	andps  %xmm1,%xmm3
   fb435:	ucomiss %xmm3,%xmm0
   fb438:	jb     768b5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x2d3>
   fb43e:	movss  0x80(%rbx),%xmm3
   fb446:	comiss %xmm7,%xmm3
   fb449:	jb     768b5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x2d3>
   fb44f:	andps  %xmm1,%xmm3
   fb452:	ucomiss %xmm3,%xmm0
   fb455:	jb     768b5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x2d3>
   fb45b:	movss  0x84(%rbx),%xmm3
   fb463:	comiss %xmm7,%xmm3
   fb466:	jb     768b5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x2d3>
   fb46c:	andps  %xmm1,%xmm3
   fb46f:	ucomiss %xmm3,%xmm0
   fb472:	jb     768b5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x2d3>
   fb478:	cmpl   $0x3,0x88(%rbx)
   fb47f:	ja     102943 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78e3>
   fb485:	cmpl   $0x1,0x10(%rbx)
   fb489:	ja     76930 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x34e>
   fb48f:	cmpl   $0x1,0x8(%rbx)
   fb493:	ja     76962 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x380>
   fb499:	mulss  %xmm2,%xmm2
   fb49d:	comiss %xmm7,%xmm2
   fb4a0:	jbe    769d9 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x3f7>
   fb4a6:	ucomiss %xmm2,%xmm0
   fb4a9:	jb     769d9 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x3f7>
   fb4af:	movss  0xfcac9(%rip),%xmm3        # 1f7f80 <cuda::std::__4::in_place+0x33>
   fb4b7:	divss  %xmm2,%xmm3
   fb4bb:	ucomiss %xmm3,%xmm0
   fb4be:	movss  %xmm3,-0xacc(%rbp)
   fb4c6:	jb     102948 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78e8>
   fb4cc:	movss  0x30(%rbx),%xmm2
   fb4d1:	movaps %xmm2,%xmm3
   fb4d4:	andps  %xmm1,%xmm3
   fb4d7:	ucomiss %xmm3,%xmm0
   fb4da:	jb     76a54 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x472>
   fb4e0:	comiss %xmm2,%xmm7
   fb4e3:	ja     76a54 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x472>
   fb4e9:	movss  0x34(%rbx),%xmm2
   fb4ee:	andps  %xmm1,%xmm2
   fb4f1:	ucomiss %xmm2,%xmm0
   fb4f4:	jb     76a54 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x472>
   fb4fa:	movss  0x38(%rbx),%xmm2
   fb4ff:	andps  %xmm1,%xmm2
   fb502:	ucomiss %xmm2,%xmm0
   fb505:	jb     76a54 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x472>
   fb50b:	movss  0x3c(%rbx),%xmm2
   fb510:	andps  %xmm1,%xmm2
   fb513:	ucomiss %xmm2,%xmm0
   fb516:	jb     76a54 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x472>
   fb51c:	movss  0x44(%rbx),%xmm2
   fb521:	comiss %xmm7,%xmm2
   fb524:	jbe    10294d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78ed>
   fb52a:	andps  %xmm1,%xmm2
   fb52d:	ucomiss %xmm2,%xmm0
   fb530:	jb     76ab4 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x4d2>
   fb536:	movss  0x48(%rbx),%xmm2
   fb53b:	comiss %xmm7,%xmm2
   fb53e:	jb     102952 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78f2>
   fb544:	andps  %xmm1,%xmm2
   fb547:	ucomiss %xmm2,%xmm0
   fb54a:	jb     76afd <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x51b>
   fb550:	movss  0x50(%rbx),%xmm2
   fb555:	comiss %xmm7,%xmm2
   fb558:	jb     102957 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78f7>
   fb55e:	movss  0xfca1a(%rip),%xmm6        # 1f7f80 <cuda::std::__4::in_place+0x33>
   fb566:	comiss %xmm2,%xmm6
   fb569:	jb     76b46 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x564>
   fb56f:	andps  %xmm1,%xmm2
   fb572:	ucomiss %xmm2,%xmm0
   fb575:	jb     76b46 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x564>
   fb57b:	movss  0x58(%rbx),%xmm2
   fb580:	comiss %xmm7,%xmm2
   fb583:	jb     102981 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7921>
   fb589:	comiss %xmm2,%xmm6
   fb58c:	jb     76f2d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x94b>
   fb592:	andps  %xmm1,%xmm2
   fb595:	ucomiss %xmm2,%xmm0
   fb598:	jb     76f2d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x94b>
   fb59e:	movss  0x54(%rbx),%xmm2
   fb5a3:	comiss %xmm7,%xmm2
   fb5a6:	jb     102986 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7926>
   fb5ac:	andps  %xmm1,%xmm2
   fb5af:	ucomiss %xmm2,%xmm0
   fb5b2:	jb     767da <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x1f8>
   fb5b8:	movss  0x5c(%rbx),%xmm2
   fb5bd:	comiss %xmm7,%xmm2
   fb5c0:	jb     767da <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x1f8>
   fb5c6:	andps  %xmm1,%xmm2
   fb5c9:	ucomiss %xmm2,%xmm0
   fb5cc:	jb     767da <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x1f8>
   fb5d2:	lea    0x8(%rbx),%rdi
   fb5d6:	call   6e200 <(anonymous namespace)::validate_cable_penalty_config(synreal::Config const&)@plt>
   fb5db:	mov    0x32b8(%rbx),%rax
   fb5e2:	mov    0x32f8(%rbx),%rdx
   fb5e9:	movss  0xf41af(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
   fb5f1:	movss  0xf4193(%rip),%xmm0        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
   fb5f9:	test   %rax,%rax
   fb5fc:	mov    %rax,-0xa90(%rbp)
   fb603:	mov    %rdx,-0xa88(%rbp)
   fb60a:	je     fb61b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5bb>
   fb60c:	movss  0x30(%rbx),%xmm2
   fb611:	pxor   %xmm7,%xmm7
   fb615:	comiss %xmm7,%xmm2
   fb618:	seta   %al
   fb61b:	mov    %al,-0xada(%rbp)
   fb621:	mov    0x714(%rbx),%eax
   fb627:	mov    %r12,-0xa80(%rbp)
   fb62e:	cmp    $0x1,%r12
   fb632:	je     101020 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5fc0>
   fb638:	mov    0x39c(%rbx),%edx
   fb63e:	mov    %eax,-0xac8(%rbp)
   fb644:	test   %edx,%edx
   fb646:	jne    fb64e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5ee>
   fb648:	mov    0x398(%rbx),%edx
   fb64e:	movss  0xc(%rbx),%xmm2
   fb653:	mulss  0x5d0(%rbx),%xmm2
   fb65b:	mov    %rdx,-0xa78(%rbp)
   fb662:	mov    0x10(%rbx),%eax
   fb665:	mulss  -0xacc(%rbp),%xmm2
   fb66d:	mov    0x17e8(%rbx),%r13d
   fb674:	mov    %eax,-0xb1c(%rbp)
   fb67a:	mov    0x8(%rbx),%eax
   fb67d:	test   %eax,%eax
   fb67f:	mov    %eax,-0xb74(%rbp)
   fb685:	movss  %xmm2,-0xac4(%rbp)
   fb68d:	sete   -0xb58(%rbp)
   fb694:	test   %r13d,%r13d
   fb697:	je     fb6e1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x681>
   fb699:	movss  0x28(%rbx),%xmm2
   fb69e:	movaps %xmm2,%xmm3
   fb6a1:	andps  %xmm1,%xmm3
   fb6a4:	ucomiss %xmm3,%xmm0
   fb6a7:	jb     76efb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x919>
   fb6ad:	pxor   %xmm6,%xmm6
   fb6b1:	comiss %xmm2,%xmm6
   fb6b4:	jae    76efb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x919>
   fb6ba:	comiss 0xfc8bf(%rip),%xmm2        # 1f7f80 <cuda::std::__4::in_place+0x33>
   fb6c1:	ja     76efb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x919>
   fb6c7:	movss  0x2c(%rbx),%xmm2
   fb6cc:	andps  %xmm2,%xmm1
   fb6cf:	ucomiss %xmm1,%xmm0
   fb6d2:	jb     76efb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x919>
   fb6d8:	comiss %xmm2,%xmm6
   fb6db:	ja     76efb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x919>
   fb6e1:	mov    -0xaa0(%rbp),%rdi
   fb6e8:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fb6ed:	mov    0x10(%r14),%esi
   fb6f1:	mov    %eax,-0xae8(%rbp)
   fb6f7:	mov    0x20(%rbx),%eax
   fb6fa:	mov    %eax,-0xb20(%rbp)
   fb700:	test   %esi,%esi
   fb702:	je     fb712 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6b2>
   fb704:	mov    0x398(%rbx),%edx
   fb70a:	test   %edx,%edx
   fb70c:	jne    101b78 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6b18>
   fb712:	movb   $0x0,-0xad9(%rbp)
   fb719:	xor    %r8d,%r8d
   fb71c:	lea    -0x2b0(%rbp),%rdi
   fb723:	xor    %eax,%eax
   fb725:	mov    $0x27,%ecx
   fb72a:	movb   $0x0,-0xad8(%rbp)
   fb731:	mov    %rdi,-0xba0(%rbp)
   fb738:	rep stos %rax,%es:(%rdi)
   fb73b:	mov    0xfc856(%rip),%rax        # 1f7f98 <cuda::std::__4::in_place+0x4b>
   fb742:	movl   $0x3f733333,-0x1c4(%rbp)
   fb74c:	movb   $0x1,-0x1b2(%rbp)
   fb753:	mov    %rax,-0x1bc(%rbp)
   fb75a:	lea    -0x500(%rbp),%rax
   fb761:	mov    %rax,-0xbb8(%rbp)
   fb768:	test   %r8b,%r8b
   fb76b:	je     fb77a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x71a>
   fb76d:	cmpb   $0x0,0x3341(%rbx)
   fb774:	jne    fe288 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3228>
   fb77a:	lea    -0x3b0(%rbp),%rdi
   fb781:	mov    $0x1f,%ecx
   fb786:	xor    %eax,%eax
   fb788:	movb   $0x0,-0xad7(%rbp)
   fb78f:	rep stos %rax,%es:(%rdi)
   fb792:	mov    0xd0(%r14),%edi
   fb799:	test   %edi,%edi
   fb79b:	je     fe456 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x33f6>
   fb7a1:	cmpl   $0x1,0x710(%rbx)
   fb7a8:	mov    0x710(%rbx),%r11d
   fb7af:	mov    %r15d,%ecx
   fb7b2:	sbb    %eax,%eax
   fb7b4:	xor    %edx,%edx
   fb7b6:	add    $0x1,%eax
   fb7b9:	test   %r11d,%r11d
   fb7bc:	cmove  %edx,%ecx
   fb7bf:	mov    %ecx,%r15d
   fb7c2:	mov    %al,-0xad6(%rbp)
   fb7c8:	mov    %r15b,-0xad5(%rbp)
   fb7cf:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fb7d4:	mov    $0x20,%edx
   fb7d9:	mov    $0x25,%ecx
   fb7de:	mov    -0xbb8(%rbp),%rdi
   fb7e5:	cmp    %edx,%eax
   fb7e7:	cmova  %edx,%eax
   fb7ea:	mov    %eax,-0xac0(%rbp)
   fb7f0:	xor    %eax,%eax
   fb7f2:	cmpb   $0x0,-0xad5(%rbp)
   fb7f9:	rep stos %rax,%es:(%rdi)
   fb7fc:	jne    100be0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5b80>
   fb802:	mov    -0xaa8(%rbp),%rsi
   fb809:	mov    -0xa80(%rbp),%rdx
   fb810:	mov    0x3d0(%rbx),%rcx
   fb817:	mov    0x3e0(%rbx),%r8
   fb81e:	mov    0x498(%rbx),%eax
   fb824:	movb   $0x0,-0xb45(%rbp)
   fb82b:	mov    %eax,-0xb50(%rbp)
   fb831:	mov    0x400(%rbx),%eax
   fb837:	test   %eax,%eax
   fb839:	setne  -0xad4(%rbp)
   fb840:	je     fb85b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7fb>
   fb842:	movss  0x60(%rbx),%xmm0
   fb847:	pxor   %xmm6,%xmm6
   fb84b:	movb   $0x1,-0xb45(%rbp)
   fb852:	comiss %xmm6,%xmm0
   fb855:	jbe    101cd0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6c70>
   fb85b:	mov    %rax,%rdi
   fb85e:	movq   %rax,%xmm0
   fb863:	movdqu 0x410(%rbx),%xmm1
   fb86b:	mov    0x438(%rbx),%rax
   fb872:	imul   %rdx,%rdi
   fb876:	movdqu 0x420(%rbx),%xmm5
   fb87e:	movdqu 0x3c0(%rbx),%xmm2
   fb886:	mov    %rcx,-0x6e0(%rbp)
   fb88d:	movdqu 0x400(%rbx),%xmm4
   fb895:	mov    %rax,-0x6b0(%rbp)
   fb89c:	xor    %eax,%eax
   fb89e:	punpckhqdq %xmm5,%xmm1
   fb8a2:	cmpb   $0x0,-0xb45(%rbp)
   fb8a9:	mov    %r8,-0x6d8(%rbp)
   fb8b0:	movq   %rdi,%xmm7
   fb8b5:	shufpd $0x2,%xmm4,%xmm2
   fb8ba:	mov    %rdi,-0xa70(%rbp)
   fb8c1:	punpcklqdq %xmm7,%xmm0
   fb8c5:	movaps %xmm2,-0x6d0(%rbp)
   fb8cc:	movaps %xmm1,-0x6c0(%rbp)
   fb8d3:	je     fb8dc <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x87c>
   fb8d5:	mov    0x3120(%rbx),%rax
   fb8dc:	movq   %rax,%xmm1
   fb8e1:	mov    0x458(%rbx),%rax
   fb8e8:	movhps 0x448(%rbx),%xmm1
   fb8ef:	mov    %rax,-0x698(%rbp)
   fb8f6:	xor    %eax,%eax
   fb8f8:	cmpq   $0x0,0x470(%rbx)
   fb900:	movups %xmm1,-0x6a8(%rbp)
   fb907:	je     fb910 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x8b0>
   fb909:	mov    0x468(%rbx),%rax
   fb910:	mov    %rax,-0x690(%rbp)
   fb917:	xor    %eax,%eax
   fb919:	cmpq   $0x0,0x480(%rbx)
   fb921:	je     fb92a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x8ca>
   fb923:	mov    0x478(%rbx),%rax
   fb92a:	mov    %rax,-0x688(%rbp)
   fb931:	xor    %eax,%eax
   fb933:	cmpq   $0x0,0x490(%rbx)
   fb93b:	je     fb944 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x8e4>
   fb93d:	mov    0x488(%rbx),%rax
   fb944:	movq   0x30c0(%rbx),%xmm2
   fb94c:	movq   %rax,%xmm1
   fb951:	mov    0x3100(%rbx),%rax
   fb958:	mov    %rsi,-0x648(%rbp)
   fb95f:	movhps 0x30a0(%rbx),%xmm1
   fb966:	cmpb   $0x0,-0xb45(%rbp)
   fb96d:	mov    -0xb50(%rbp),%r8d
   fb974:	movups %xmm0,-0x658(%rbp)
   fb97b:	movhps 0x30e0(%rbx),%xmm2
   fb982:	mov    %rax,-0x660(%rbp)
   fb989:	movaps %xmm1,-0x680(%rbp)
   fb990:	movaps %xmm2,-0x670(%rbp)
   fb997:	jne    101170 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6110>
   fb99d:	mov    0x49c(%rbx),%eax
   fb9a3:	mov    %r8d,%edi
   fb9a6:	movdqa -0xb70(%rbp),%xmm5
   fb9ae:	movq   %rcx,%xmm0
   fb9b3:	movq   0x620(%rbx),%xmm4
   fb9bb:	mov    0x568(%rbx),%r11d
   fb9c2:	lea    -0xae4(%rbp),%r15
   fb9c9:	movhps 0x5e0(%rbx),%xmm0
   fb9d0:	sub    %eax,%edi
   fb9d2:	imul   %rdx,%rax
   fb9d6:	movq   0x3570(%rbx),%xmm3
   fb9de:	movaps %xmm5,-0x7d0(%rbp)
   fb9e5:	movq   0x5f0(%rbx),%xmm5
   fb9ed:	mov    %rdi,-0xbc0(%rbp)
   fb9f4:	movhps 0x630(%rbx),%xmm4
   fb9fb:	mov    0x4f0(%rbx),%edi
   fba01:	movhps 0x3590(%rbx),%xmm3
   fba08:	movdqa -0xb30(%rbp),%xmm6
   fba10:	mov    %r11d,-0xb4c(%rbp)
   fba17:	mov    %rax,-0xba8(%rbp)
   fba1e:	mov    0x56c(%rbx),%eax
   fba24:	movhps 0x600(%rbx),%xmm5
   fba2b:	movdqa -0xb10(%rbp),%xmm7
   fba33:	movaps %xmm0,-0x760(%rbp)
   fba3a:	movq   0x35b0(%rbx),%xmm2
   fba42:	imul   %rdx,%rax
   fba46:	movaps %xmm4,-0x740(%rbp)
   fba4d:	movq   0x35f0(%rbx),%xmm1
   fba55:	movhps 0x35d0(%rbx),%xmm2
   fba5c:	mov    %r15,-0x7c0(%rbp)
   fba63:	movhps 0x650(%rbx),%xmm1
   fba6a:	mov    %edi,-0xb44(%rbp)
   fba70:	mov    %rax,-0xa68(%rbp)
   fba77:	mov    0x5d4(%rbx),%eax
   fba7d:	movaps %xmm6,-0x7f0(%rbp)
   fba84:	test   %eax,%eax
   fba86:	mov    %rax,%rcx
   fba89:	movq   %rax,%xmm0
   fba8e:	movaps %xmm7,-0x7e0(%rbp)
   fba95:	setne  -0xad3(%rbp)
   fba9c:	lea    -0x760(%rbp),%rax
   fbaa3:	movaps %xmm5,-0x750(%rbp)
   fbaaa:	imul   %rdx,%rcx
   fbaae:	movaps %xmm3,-0x730(%rbp)
   fbab5:	mov    0x2e0(%rbx),%r8d
   fbabc:	mov    -0xaf8(%rbp),%r11
   fbac3:	mov    %rax,-0x848(%rbp)
   fbaca:	mov    %rax,-0x810(%rbp)
   fbad1:	mov    0x318(%rbx),%eax
   fbad7:	test   %r8d,%r8d
   fbada:	movq   %rcx,%xmm4
   fbadf:	setne  -0xad2(%rbp)
   fbae6:	lea    -0xad3(%rbp),%rcx
   fbaed:	punpcklqdq %xmm4,%xmm0
   fbaf1:	imul   %rdx,%rax
   fbaf5:	mov    %rsi,-0x6f0(%rbp)
   fbafc:	mov    -0xb00(%rbp),%rsi
   fbb03:	mov    %rcx,-0x820(%rbp)
   fbb0a:	mov    %edi,%ecx
   fbb0c:	mov    %rbx,-0x850(%rbp)
   fbb13:	mov    %rax,-0xa60(%rbp)
   fbb1a:	movzbl 0x40(%rbx),%eax
   fbb1e:	mov    %rsi,-0x840(%rbp)
   fbb25:	mov    %r11,-0x838(%rbp)
   fbb2c:	mov    %r15,-0x830(%rbp)
   fbb33:	mov    %rbx,-0x818(%rbp)
   fbb3a:	mov    %rsi,-0x808(%rbp)
   fbb41:	mov    %r11,-0x800(%rbp)
   fbb48:	mov    %r15,-0x7f8(%rbp)
   fbb4f:	movaps %xmm2,-0x720(%rbp)
   fbb56:	movaps %xmm1,-0x710(%rbp)
   fbb5d:	movaps %xmm0,-0x700(%rbp)
   fbb64:	test   %al,%al
   fbb66:	jne    101820 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x67c0>
   fbb6c:	mov    0x88(%rbx),%esi
   fbb72:	mov    %al,-0xad1(%rbp)
   fbb78:	movl   $0x0,-0xb10(%rbp)
   fbb82:	mov    %esi,-0xb30(%rbp)
   fbb88:	mov    %esi,-0xabc(%rbp)
   fbb8e:	cmp    $0x2,%esi
   fbb91:	jne    fbba0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xb40>
   fbb93:	movss  0xc(%rbx),%xmm4
   fbb98:	movss  %xmm4,-0xb10(%rbp)
   fbba0:	imul   %rdx,%rcx
   fbba4:	lea    -0xad8(%rbp),%rdx
   fbbab:	mov    %r14,-0x7a8(%rbp)
   fbbb2:	mov    %rdx,-0x7b0(%rbp)
   fbbb9:	mov    -0xb00(%rbp),%rdx
   fbbc0:	mov    %rbx,-0x790(%rbp)
   fbbc7:	mov    %rcx,-0xb80(%rbp)
   fbbce:	mov    -0xba0(%rbp),%rcx
   fbbd5:	mov    %rdx,-0x7a0(%rbp)
   fbbdc:	lea    -0xa80(%rbp),%rdx
   fbbe3:	mov    %rcx,-0x798(%rbp)
   fbbea:	lea    -0xac8(%rbp),%rcx
   fbbf1:	mov    %rdx,-0xbc8(%rbp)
   fbbf8:	mov    %rdx,-0x780(%rbp)
   fbbff:	mov    -0xaf8(%rbp),%rdx
   fbc06:	mov    %rcx,-0xb60(%rbp)
   fbc0d:	mov    %rcx,-0x788(%rbp)
   fbc14:	lea    -0xaa8(%rbp),%rcx
   fbc1b:	mov    %rdx,-0x778(%rbp)
   fbc22:	mov    %r15,-0x770(%rbp)
   fbc29:	mov    %rcx,-0xb90(%rbp)
   fbc30:	mov    %rcx,-0x768(%rbp)
   fbc37:	test   %al,%al
   fbc39:	jne    101530 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x64d0>
   fbc3f:	cmpb   $0x0,-0xad8(%rbp)
   fbc46:	jne    1014a8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6448>
   fbc4c:	cmpq   $0x0,0x2c70(%rbx)
   fbc54:	jne    fbc64 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xc04>
   fbc56:	cmpq   $0x0,0x2cb0(%rbx)
   fbc5e:	je     fbce6 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xc86>
   fbc64:	mov    0xfc325(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fbc6b:	mov    0x2c30(%rbx),%rdi
   fbc72:	movl   $0x1,-0x638(%rbp)
   fbc7c:	mov    -0xaf0(%rbp),%r12
   fbc83:	mov    %rax,-0x640(%rbp)
   fbc8a:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fbc8f:	mov    -0x638(%rbp),%ecx
   fbc95:	xor    %r8d,%r8d
   fbc98:	mov    %r12,%r9
   fbc9b:	mov    %eax,-0x5a0(%rbp)
   fbca1:	mov    -0x640(%rbp),%rdx
   fbca8:	movabs $0x100000001,%rax
   fbcb2:	mov    %rax,-0x59c(%rbp)
   fbcb9:	mov    -0x5a0(%rbp),%rdi
   fbcc0:	mov    -0x598(%rbp),%esi
   fbcc6:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fbccb:	test   %eax,%eax
   fbccd:	je     102498 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7438>
   fbcd3:	call   6c890 <cudaGetLastError@plt>
   fbcd8:	lea    0xf9251(%rip),%rsi        # 1f4f30 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5030>
   fbcdf:	mov    %eax,%edi
   fbce1:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fbce6:	cmpq   $0x0,0x2cf0(%rbx)
   fbcee:	jne    101790 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6730>
   fbcf4:	mov    0xfc295(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fbcfb:	mov    0xfc28e(%rip),%rdx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fbd02:	xor    %r8d,%r8d
   fbd05:	mov    $0x1,%ecx
   fbd0a:	mov    -0xaf0(%rbp),%r9
   fbd11:	movl   $0x1,-0x638(%rbp)
   fbd1b:	mov    %rax,-0x640(%rbp)
   fbd22:	mov    -0xae8(%rbp),%eax
   fbd28:	mov    %eax,-0x5a0(%rbp)
   fbd2e:	movabs $0x100000001,%rax
   fbd38:	mov    %rax,-0x59c(%rbp)
   fbd3f:	mov    -0x5a0(%rbp),%rdi
   fbd46:	mov    -0x598(%rbp),%esi
   fbd4c:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fbd51:	test   %eax,%eax
   fbd53:	jne    fbe82 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xe22>
   fbd59:	mov    -0xaa8(%rbp),%rax
   fbd60:	mov    %rax,-0xb38(%rbp)
   fbd67:	mov    -0xaa0(%rbp),%rax
   fbd6e:	mov    %rax,-0xb40(%rbp)
   fbd75:	mov    0x2ee0(%rbx),%rax
   fbd7c:	mov    %rax,-0xb98(%rbp)
   fbd83:	mov    0x3080(%rbx),%rax
   fbd8a:	mov    %rax,-0xbb0(%rbp)
   fbd91:	mov    0x3060(%rbx),%rax
   fbd98:	mov    %rax,-0xbd0(%rbp)
   fbd9f:	mov    0x33b0(%rbx),%rax
   fbda6:	mov    %rax,-0xbd8(%rbp)
   fbdad:	xor    %eax,%eax
   fbdaf:	cmpq   $0x0,0x100(%rbx)
   fbdb7:	jne    101bc0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6b60>
   fbdbd:	cmpl   $0x1,-0xb1c(%rbp)
   fbdc4:	movss  0xc(%rbx),%xmm3
   fbdc9:	pxor   %xmm4,%xmm4
   fbdcd:	mov    0xc0(%rbx),%r13
   fbdd4:	mov    0x2ea0(%rbx),%r12
   fbddb:	jne    101bb0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6b50>
   fbde1:	mov    -0xaf8(%rbp),%rdx
   fbde8:	mov    0x2e80(%rbx),%r11
   fbdef:	mov    0x2e60(%rbx),%r10
   fbdf6:	mov    0x2e40(%rbx),%rdi
   fbdfd:	mov    (%rdx),%r8
   fbe00:	mov    0x10(%rdx),%rcx
   fbe04:	xor    %edx,%edx
   fbe06:	cmpl   $0x1,0x90(%rbx)
   fbe0d:	mov    0x2e20(%rbx),%rsi
   fbe14:	mov    0x2e00(%rbx),%r9
   fbe1b:	jbe    101ce8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6c88>
   fbe21:	sub    $0x8,%rsp
   fbe25:	push   -0xb38(%rbp)
   fbe2b:	movaps %xmm3,%xmm5
   fbe2e:	pxor   %xmm2,%xmm2
   fbe32:	movss  -0xb10(%rbp),%xmm1
   fbe3a:	push   -0xb40(%rbp)
   fbe40:	movss  -0xae4(%rbp),%xmm0
   fbe48:	push   -0xb98(%rbp)
   fbe4e:	push   -0xbb0(%rbp)
   fbe54:	push   -0xbd0(%rbp)
   fbe5a:	push   -0xbd8(%rbp)
   fbe60:	push   %rax
   fbe61:	push   %r13
   fbe63:	push   %r12
   fbe65:	push   %r11
   fbe67:	push   %r10
   fbe69:	push   %rdi
   fbe6a:	mov    0x98(%rbx),%rdi
   fbe71:	push   %rsi
   fbe72:	mov    0xa0(%rbx),%rsi
   fbe79:	call   6ad30 <synreal::kernel::initialize_step(float, glm::vec<3, float, (glm::qualifier)0> const*, unsigned long, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, float const*, float const*, float, float const*, float, float const*, float, float const*, float, float const*, float, float const*, int const*, int const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, float*, unsigned long, unsigned long)@plt>
   fbe7e:	add    $0x70,%rsp
   fbe82:	call   6c890 <cudaGetLastError@plt>
   fbe87:	lea    0xfb707(%rip),%rsi        # 1f7595 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x7695>
   fbe8e:	mov    %eax,%edi
   fbe90:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fbe95:	cmpb   $0x0,-0xad3(%rbp)
   fbe9c:	je     fbf36 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xed6>
   fbea2:	mov    -0xb88(%rbp),%rax
   fbea9:	mov    -0xaf0(%rbp),%r12
   fbeb0:	mov    -0x6f8(%rbp),%rdi
   fbeb7:	cmpq   $0x0,0x38(%rax)
   fbebc:	jne    101b40 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6ae0>
   fbec2:	mov    0xfc0c7(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fbec9:	movl   $0x1,-0x638(%rbp)
   fbed3:	mov    %rax,-0x640(%rbp)
   fbeda:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fbedf:	mov    -0x638(%rbp),%ecx
   fbee5:	xor    %r8d,%r8d
   fbee8:	mov    %r12,%r9
   fbeeb:	mov    %eax,-0x5a0(%rbp)
   fbef1:	mov    -0x640(%rbp),%rdx
   fbef8:	movabs $0x100000001,%rax
   fbf02:	mov    %rax,-0x59c(%rbp)
   fbf09:	mov    -0x5a0(%rbp),%rdi
   fbf10:	mov    -0x598(%rbp),%esi
   fbf16:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fbf1b:	test   %eax,%eax
   fbf1d:	je     1027c4 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7764>
   fbf23:	call   6c890 <cudaGetLastError@plt>
   fbf28:	lea    0xf9089(%rip),%rsi        # 1f4fb8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x50b8>
   fbf2f:	mov    %eax,%edi
   fbf31:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fbf36:	cmpb   $0x0,-0xada(%rbp)
   fbf3d:	jne    101700 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x66a0>
   fbf43:	mov    -0xaa0(%rbp),%rax
   fbf4a:	mov    0x2ee0(%rbx),%rsi
   fbf51:	mov    $0x3,%ecx
   fbf56:	mov    0x2ec0(%rbx),%rdi
   fbf5d:	mov    -0xaf0(%rbp),%r8
   fbf64:	lea    0x0(,%rax,4),%rdx
   fbf6c:	call   6e0b0 <cudaMemcpyAsync@plt>
   fbf71:	lea    0xf90a0(%rip),%rsi        # 1f5018 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5118>
   fbf78:	mov    %eax,%edi
   fbf7a:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fbf7f:	mov    -0xb44(%rbp),%ecx
   fbf85:	test   %ecx,%ecx
   fbf87:	jne    101678 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6618>
   fbf8d:	cmpl   $0x3,-0xb30(%rbp)
   fbf94:	je     101038 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5fd8>
   fbf9a:	cmpl   $0x1,-0xb1c(%rbp)
   fbfa1:	jne    fbfc1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf61>
   fbfa3:	cmpq   $0x0,-0xba8(%rbp)
   fbfab:	jne    102690 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7630>
   fbfb1:	mov    -0xa68(%rbp),%rdi
   fbfb8:	test   %rdi,%rdi
   fbfbb:	jne    102610 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x75b0>
   fbfc1:	mov    0xd0(%rbx),%r13d
   fbfc8:	test   %r13d,%r13d
   fbfcb:	jne    100b80 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5b20>
   fbfd1:	mov    0x398(%rbx),%r12d
   fbfd8:	xor    %edi,%edi
   fbfda:	test   %r12d,%r12d
   fbfdd:	jne    101ac8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6a68>
   fbfe3:	movb   $0x0,-0xad0(%rbp)
   fbfea:	xor    %r13d,%r13d
   fbfed:	xor    %edx,%edx
   fbfef:	xor    %eax,%eax
   fbff1:	cmpl   $0x1,-0xb1c(%rbp)
   fbff8:	mov    %dl,-0xacf(%rbp)
   fbffe:	jne    fc00e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xfae>
   fc000:	cmpq   $0x0,-0xa68(%rbp)
   fc008:	jne    101a98 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6a38>
   fc00e:	movb   $0x0,-0xbd0(%rbp)
   fc015:	xor    %esi,%esi
   fc017:	movzbl -0xad3(%rbp),%ecx
   fc01e:	test   %eax,%eax
   fc020:	movzbl -0xad5(%rbp),%r8d
   fc028:	mov    %sil,-0xace(%rbp)
   fc02f:	setne  %al
   fc032:	mov    %cl,-0xacd(%rbp)
   fc038:	test   %r8b,%r8b
   fc03b:	jne    fe490 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3430>
   fc041:	movzbl -0xb58(%rbp),%edx
   fc048:	cmpb   $0x0,-0xad7(%rbp)
   fc04f:	mov    %dl,-0xb10(%rbp)
   fc055:	jne    fe490 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3430>
   fc05b:	movzbl 0x41(%rbx),%edx
   fc05f:	test   %dl,%dl
   fc061:	je     fc078 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1018>
   fc063:	movzbl -0xad9(%rbp),%edx
   fc06a:	movzbl -0xad6(%rbp),%r9d
   fc072:	test   %dl,%dl
   fc074:	cmove  %r9d,%edx
   fc078:	mov    %r13b,-0xb40(%rbp)
   fc07f:	test   %r13b,%r13b
   fc082:	jne    fc0a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1040>
   fc084:	movzbl -0xad2(%rbp),%r13d
   fc08c:	or     -0xad1(%rbp),%r13b
   fc093:	mov    %r13b,-0xb40(%rbp)
   fc09a:	je     101a00 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x69a0>
   fc0a0:	test   %dil,%dil
   fc0a3:	lea    0x2b58(%rbx),%rdx
   fc0aa:	lea    0x2b28(%rbx),%rcx
   fc0b1:	mov    0x2ba8(%rbx),%r12
   fc0b8:	cmove  %rcx,%rdx
   fc0bc:	imul   -0xaa0(%rbp),%r12
   fc0c4:	and    0x1c(%rbx),%al
   fc0c7:	and    -0xb40(%rbp),%al
   fc0cd:	mov    %al,-0xb38(%rbp)
   fc0d3:	test   %r12,%r12
   fc0d6:	mov    %rdx,-0xb98(%rbp)
   fc0dd:	setne  %al
   fc0e0:	and    -0xb10(%rbp),%al
   fc0e6:	mov    %al,-0xbb0(%rbp)
   fc0ec:	jne    1010e0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6080>
   fc0f2:	movq   $0x0,-0x3c0(%rbp)
   fc0fd:	pxor   %xmm0,%xmm0
   fc101:	movq   $0x0,-0x3b8(%rbp)
   fc10c:	movaps %xmm0,-0x3d0(%rbp)
   fc113:	test   %r13b,%r13b
   fc116:	jne    101210 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x61b0>
   fc11c:	mov    -0xb20(%rbp),%ecx
   fc122:	test   %ecx,%ecx
   fc124:	jle    1027b8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7758>
   fc12a:	lea    (%r12,%r12,4),%rax
   fc12e:	lea    -0x9c0(%rbp),%rdx
   fc135:	movl   $0x0,-0xb00(%rbp)
   fc13f:	mov    -0xaf0(%rbp),%r12
   fc146:	shl    $0x3,%rax
   fc14a:	movq   %rdx,%xmm7
   fc14f:	cmpq   $0x0,-0xbc0(%rbp)
   fc157:	movabs $0x100000001,%r15
   fc161:	mov    %rax,-0xbd8(%rbp)
   fc168:	setne  %al
   fc16b:	and    -0xb58(%rbp),%al
   fc171:	mov    %al,-0xbc8(%rbp)
   fc177:	lea    -0x9b8(%rbp),%rax
   fc17e:	movq   %rax,%xmm5
   fc183:	punpcklqdq %xmm5,%xmm7
   fc187:	movaps %xmm7,-0xbf0(%rbp)
   fc18e:	xchg   %ax,%ax
   fc190:	cmpb   $0x0,-0xad4(%rbp)
   fc197:	je     fc2a3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1243>
   fc19d:	mov    0xfbdec(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fc1a4:	mov    -0xa70(%rbp),%rdi
   fc1ab:	movl   $0x1,-0x8a0(%rbp)
   fc1b5:	mov    %rax,-0x8a8(%rbp)
   fc1bc:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fc1c1:	mov    %r15,-0x898(%rbp)
   fc1c8:	mov    -0x8a0(%rbp),%ecx
   fc1ce:	mov    %r12,%r9
   fc1d1:	xor    %r8d,%r8d
   fc1d4:	mov    %eax,-0x89c(%rbp)
   fc1da:	mov    -0x8a8(%rbp),%rdx
   fc1e1:	mov    -0x89c(%rbp),%rdi
   fc1e8:	mov    -0x894(%rbp),%esi
   fc1ee:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fc1f3:	test   %eax,%eax
   fc1f5:	jne    fc289 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1229>
   fc1fb:	push   -0x648(%rbp)
   fc201:	push   -0x650(%rbp)
   fc207:	push   -0x658(%rbp)
   fc20d:	push   -0x660(%rbp)
   fc213:	push   -0x668(%rbp)
   fc219:	push   -0x670(%rbp)
   fc21f:	push   -0x678(%rbp)
   fc225:	push   -0x680(%rbp)
   fc22b:	push   -0x688(%rbp)
   fc231:	push   -0x690(%rbp)
   fc237:	push   -0x698(%rbp)
   fc23d:	push   -0x6a0(%rbp)
   fc243:	push   -0x6a8(%rbp)
   fc249:	push   -0x6b0(%rbp)
   fc24f:	push   -0x6b8(%rbp)
   fc255:	push   -0x6c0(%rbp)
   fc25b:	push   -0x6c8(%rbp)
   fc261:	mov    -0xaf8(%rbp),%rax
   fc268:	push   -0x6d0(%rbp)
   fc26e:	push   -0x6d8(%rbp)
   fc274:	push   -0x6e0(%rbp)
   fc27a:	mov    (%rax),%rdi
   fc27d:	call   6ac90 <synreal::kernel::prepare_cable_tangents(synreal::kernel::CableView, glm::vec<3, float, (glm::qualifier)0> const*)@plt>
   fc282:	add    $0xa0,%rsp
   fc289:	call   6c890 <cudaGetLastError@plt>
   fc28e:	mov    %eax,%edi
   fc290:	lea    0xf8ee1(%rip),%rsi        # 1f5178 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5278>
   fc297:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc29c:	mov    -0xaf0(%rbp),%r12
   fc2a3:	mov    -0xaa0(%rbp),%rax
   fc2aa:	mov    0x2ec0(%rbx),%rsi
   fc2b1:	mov    %r12,%r8
   fc2b4:	mov    $0x3,%ecx
   fc2b9:	mov    0x2ee0(%rbx),%rdi
   fc2c0:	lea    0x0(,%rax,4),%rdx
   fc2c8:	call   6e0b0 <cudaMemcpyAsync@plt>
   fc2cd:	mov    %eax,%edi
   fc2cf:	lea    0xf8eca(%rip),%rsi        # 1f51a0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x52a0>
   fc2d6:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc2db:	mov    0xfbcae(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fc2e2:	xor    %r8d,%r8d
   fc2e5:	mov    $0x1,%ecx
   fc2ea:	mov    %r15,-0x898(%rbp)
   fc2f1:	mov    0xfbc98(%rip),%rdx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fc2f8:	mov    -0x894(%rbp),%esi
   fc2fe:	movl   $0x1,-0x8a0(%rbp)
   fc308:	mov    %rax,-0x8a8(%rbp)
   fc30f:	mov    -0xae8(%rbp),%eax
   fc315:	mov    -0xaf0(%rbp),%r9
   fc31c:	mov    %eax,-0x89c(%rbp)
   fc322:	mov    -0x89c(%rbp),%rdi
   fc329:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fc32e:	test   %eax,%eax
   fc330:	jne    fc3be <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x135e>
   fc336:	xor    %edx,%edx
   fc338:	cmpq   $0x0,0x100(%rbx)
   fc340:	mov    -0xaa8(%rbp),%r9
   fc347:	mov    -0xaa0(%rbp),%r8
   fc34e:	mov    0x3040(%rbx),%rdi
   fc355:	je     fc35e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x12fe>
   fc357:	mov    0xf8(%rbx),%rdx
   fc35e:	mov    -0xaf8(%rbp),%rcx
   fc365:	xor    %eax,%eax
   fc367:	cmpq   $0x0,0x28(%rcx)
   fc36c:	je     fc372 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1312>
   fc36e:	mov    0x20(%rcx),%rax
   fc372:	sub    $0x8,%rsp
   fc376:	mov    0xc0(%rbx),%r10
   fc37d:	mov    0x2af8(%rbx),%rcx
   fc384:	mov    0x3080(%rbx),%rsi
   fc38b:	push   %r9
   fc38d:	push   %r8
   fc38f:	movss  -0xacc(%rbp),%xmm0
   fc397:	mov    0x2b18(%rbx),%r9
   fc39e:	mov    0x2b08(%rbx),%r8
   fc3a5:	push   %rdi
   fc3a6:	push   %rdx
   fc3a7:	mov    %r10,%rdx
   fc3aa:	push   %rax
   fc3ab:	mov    -0xaf8(%rbp),%rax
   fc3b2:	mov    (%rax),%rdi
   fc3b5:	call   6af50 <synreal::kernel::initialize_rhs(float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, int const*, synreal::NonZeroEntry const*, unsigned long, glm::vec<3, float, (glm::qualifier)0> const*, int const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long)@plt>
   fc3ba:	add    $0x30,%rsp
   fc3be:	call   6c890 <cudaGetLastError@plt>
   fc3c3:	mov    %eax,%edi
   fc3c5:	lea    0xfb1e7(%rip),%rsi        # 1f75b3 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x76b3>
   fc3cc:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc3d1:	mov    0x17e8(%rbx),%eax
   fc3d7:	test   %eax,%eax
   fc3d9:	jne    fec60 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3c00>
   fc3df:	mov    0x2180(%rbx),%eax
   fc3e5:	test   %eax,%eax
   fc3e7:	jne    feca1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3c41>
   fc3ed:	cmpb   $0x0,-0xada(%rbp)
   fc3f4:	je     fc4e5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1485>
   fc3fa:	mov    0xfbb8f(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fc401:	mov    -0xa88(%rbp),%rdi
   fc408:	movl   $0x1,-0x8a0(%rbp)
   fc412:	mov    -0xaf0(%rbp),%r12
   fc419:	mov    %rax,-0x8a8(%rbp)
   fc420:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fc425:	mov    %r15,-0x898(%rbp)
   fc42c:	mov    -0x8a0(%rbp),%ecx
   fc432:	mov    %r12,%r9
   fc435:	xor    %r8d,%r8d
   fc438:	mov    %eax,-0x89c(%rbp)
   fc43e:	mov    -0x8a8(%rbp),%rdx
   fc445:	mov    -0x89c(%rbp),%rdi
   fc44c:	mov    -0x894(%rbp),%esi
   fc452:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fc457:	test   %eax,%eax
   fc459:	jne    fc4d2 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1472>
   fc45b:	mov    -0xaf8(%rbp),%rax
   fc462:	movss  0x30(%rbx),%xmm0
   fc467:	sub    $0x8,%rsp
   fc46b:	mov    0x32c8(%rbx),%rcx
   fc472:	mov    0x32a8(%rbx),%rdx
   fc479:	mov    0x3060(%rbx),%rsi
   fc480:	push   -0xaa8(%rbp)
   fc486:	movq   0x34(%rbx),%xmm1
   fc48b:	push   -0xa90(%rbp)
   fc491:	movss  0x3c(%rbx),%xmm2
   fc496:	push   -0xa88(%rbp)
   fc49c:	movss  0xfbadc(%rip),%xmm3        # 1f7f80 <cuda::std::__4::in_place+0x33>
   fc4a4:	push   0x3328(%rbx)
   fc4aa:	divss  -0xae4(%rbp),%xmm3
   fc4b2:	mov    0x3308(%rbx),%r9
   fc4b9:	push   0x3040(%rbx)
   fc4bf:	mov    0x32e8(%rbx),%r8
   fc4c6:	mov    (%rax),%rdi
   fc4c9:	call   6abb0 <synreal::kernel::evaluate_triangle_drag(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, glm::vec<3, float, (glm::qualifier)0>, float, glm::vec<3, float, (glm::qualifier)0>*, float*, unsigned long, unsigned long, unsigned long)@plt>
   fc4ce:	add    $0x30,%rsp
   fc4d2:	call   6c890 <cudaGetLastError@plt>
   fc4d7:	mov    %eax,%edi
   fc4d9:	lea    0xf8ce8(%rip),%rsi        # 1f51c8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x52c8>
   fc4e0:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc4e5:	mov    0x3060(%rbx),%rax
   fc4ec:	movss  -0xae4(%rbp),%xmm6
   fc4f4:	cmpb   $0x0,-0xad9(%rbp)
   fc4fb:	mov    0x3040(%rbx),%r13
   fc502:	mov    %rax,-0xb60(%rbp)
   fc509:	mov    0x2ee0(%rbx),%rax
   fc510:	movss  %xmm6,-0xb70(%rbp)
   fc518:	mov    %rax,-0xb58(%rbp)
   fc51f:	je     fc5a7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1547>
   fc525:	mov    0xfba64(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fc52c:	cmpb   $0x0,-0xad8(%rbp)
   fc533:	movl   $0x1,-0x8a0(%rbp)
   fc53d:	mov    -0xaf0(%rbp),%r12
   fc544:	mov    0x10(%r14),%edi
   fc548:	mov    %rax,-0x8a8(%rbp)
   fc54f:	jne    ff510 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x44b0>
   fc555:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fc55a:	mov    %r15,-0x898(%rbp)
   fc561:	mov    -0x8a0(%rbp),%ecx
   fc567:	mov    %r12,%r9
   fc56a:	xor    %r8d,%r8d
   fc56d:	mov    %eax,-0x89c(%rbp)
   fc573:	mov    -0x8a8(%rbp),%rdx
   fc57a:	mov    -0x89c(%rbp),%rdi
   fc581:	mov    -0x894(%rbp),%esi
   fc587:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fc58c:	test   %eax,%eax
   fc58e:	je     1002d0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5270>
   fc594:	call   6c890 <cudaGetLastError@plt>
   fc599:	mov    %eax,%edi
   fc59b:	lea    0xf8c76(%rip),%rsi        # 1f5218 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5318>
   fc5a2:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc5a7:	cmpb   $0x0,-0xad7(%rbp)
   fc5ae:	je     fc6fa <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x169a>
   fc5b4:	mov    0xfb9d5(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fc5bb:	mov    0x10(%r14),%edi
   fc5bf:	movl   $0x1,-0x8a0(%rbp)
   fc5c9:	mov    -0xaf0(%rbp),%r12
   fc5d0:	mov    %rax,-0x8a8(%rbp)
   fc5d7:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fc5dc:	mov    %r15,-0x898(%rbp)
   fc5e3:	mov    -0x8a0(%rbp),%ecx
   fc5e9:	mov    %r12,%r9
   fc5ec:	xor    %r8d,%r8d
   fc5ef:	mov    %eax,-0x89c(%rbp)
   fc5f5:	mov    -0x8a8(%rbp),%rdx
   fc5fc:	mov    -0x89c(%rbp),%rdi
   fc603:	mov    -0x894(%rbp),%esi
   fc609:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fc60e:	test   %eax,%eax
   fc610:	jne    fc6e7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1687>
   fc616:	sub    $0x8,%rsp
   fc61a:	mov    0x3040(%rbx),%rdi
   fc621:	push   -0x2c0(%rbp)
   fc627:	push   -0x2c8(%rbp)
   fc62d:	push   -0x2d0(%rbp)
   fc633:	push   -0x2d8(%rbp)
   fc639:	push   -0x2e0(%rbp)
   fc63f:	push   -0x2e8(%rbp)
   fc645:	push   -0x2f0(%rbp)
   fc64b:	push   -0x2f8(%rbp)
   fc651:	push   -0x300(%rbp)
   fc657:	push   -0x308(%rbp)
   fc65d:	push   -0x310(%rbp)
   fc663:	push   -0x318(%rbp)
   fc669:	push   -0x320(%rbp)
   fc66f:	push   -0x328(%rbp)
   fc675:	push   -0x330(%rbp)
   fc67b:	push   -0x338(%rbp)
   fc681:	push   -0x340(%rbp)
   fc687:	push   -0x348(%rbp)
   fc68d:	push   -0x350(%rbp)
   fc693:	push   -0x358(%rbp)
   fc699:	push   -0x360(%rbp)
   fc69f:	push   -0x368(%rbp)
   fc6a5:	push   -0x370(%rbp)
   fc6ab:	push   -0x378(%rbp)
   fc6b1:	push   -0x380(%rbp)
   fc6b7:	push   -0x388(%rbp)
   fc6bd:	push   -0x390(%rbp)
   fc6c3:	push   -0x398(%rbp)
   fc6c9:	push   -0x3a0(%rbp)
   fc6cf:	push   -0x3a8(%rbp)
   fc6d5:	push   -0x3b0(%rbp)
   fc6db:	call   6a850 <synreal::kernel::evaluate_rolling_contact_force(synreal::kernel::RollingContactView, glm::vec<3, float, (glm::qualifier)0>*)@plt>
   fc6e0:	add    $0x100,%rsp
   fc6e7:	call   6c890 <cudaGetLastError@plt>
   fc6ec:	mov    %eax,%edi
   fc6ee:	lea    0xf8b4b(%rip),%rsi        # 1f5240 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5340>
   fc6f5:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc6fa:	mov    0x3060(%rbx),%rax
   fc701:	movss  -0xae4(%rbp),%xmm7
   fc709:	cmpb   $0x0,-0xad6(%rbp)
   fc710:	mov    0x3040(%rbx),%r12
   fc717:	mov    %rax,-0xb70(%rbp)
   fc71e:	mov    0x2ee0(%rbx),%rax
   fc725:	movss  %xmm7,-0xb58(%rbp)
   fc72d:	mov    %rax,-0xb60(%rbp)
   fc734:	je     fc96c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x190c>
   fc73a:	cmpb   $0x0,-0xad5(%rbp)
   fc741:	je     fc7c8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1768>
   fc747:	test   %r12,%r12
   fc74a:	je     fc7ba <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x175a>
   fc74c:	mov    0xfb83d(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fc753:	xor    %r8d,%r8d
   fc756:	mov    $0x1,%ecx
   fc75b:	mov    %r15,-0x898(%rbp)
   fc762:	mov    0xfb827(%rip),%rdx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fc769:	mov    -0x894(%rbp),%esi
   fc76f:	movl   $0x1,-0x8a0(%rbp)
   fc779:	mov    %rax,-0x8a8(%rbp)
   fc780:	mov    -0xac0(%rbp),%eax
   fc786:	mov    -0xaf0(%rbp),%r9
   fc78d:	mov    %eax,-0x89c(%rbp)
   fc793:	mov    -0x89c(%rbp),%rdi
   fc79a:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fc79f:	test   %eax,%eax
   fc7a1:	je     100890 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5830>
   fc7a7:	call   6c890 <cudaGetLastError@plt>
   fc7ac:	mov    %eax,%edi
   fc7ae:	lea    0xf8ab3(%rip),%rsi        # 1f5268 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5368>
   fc7b5:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc7ba:	cmpq   $0x0,0x150(%r14)
   fc7c2:	je     fc96c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x190c>
   fc7c8:	mov    0xfb7c1(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fc7cf:	mov    0xd0(%r14),%edi
   fc7d6:	movl   $0x1,-0x8a0(%rbp)
   fc7e0:	mov    -0xaf0(%rbp),%r13
   fc7e7:	mov    %rax,-0x8a8(%rbp)
   fc7ee:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fc7f3:	mov    %r15,-0x898(%rbp)
   fc7fa:	mov    -0x8a0(%rbp),%ecx
   fc800:	mov    %r13,%r9
   fc803:	xor    %r8d,%r8d
   fc806:	mov    %eax,-0x89c(%rbp)
   fc80c:	mov    -0x8a8(%rbp),%rdx
   fc813:	mov    -0x89c(%rbp),%rdi
   fc81a:	mov    -0x894(%rbp),%esi
   fc820:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fc825:	test   %eax,%eax
   fc827:	jne    fc959 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x18f9>
   fc82d:	xor    %eax,%eax
   fc82f:	cmpb   $0x0,-0xad5(%rbp)
   fc836:	mov    0x150(%r14),%r8
   fc83d:	je     fc846 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x17e6>
   fc83f:	mov    0x148(%r14),%rax
   fc846:	sub    $0x8,%rsp
   fc84a:	movss  0x7c8(%rbx),%xmm0
   fc852:	mov    0xe8(%r14),%rcx
   fc859:	mov    0xd8(%r14),%rdx
   fc860:	mov    0xd0(%r14),%esi
   fc867:	push   $0x0
   fc869:	push   $0x0
   fc86b:	mov    0xc0(%r14),%rdi
   fc872:	push   %r8
   fc874:	push   %rax
   fc875:	mov    -0xaf8(%rbp),%rax
   fc87c:	push   -0xb60(%rbp)
   fc882:	push   %r12
   fc884:	push   -0xb70(%rbp)
   fc88a:	push   0x10(%rax)
   fc88d:	push   (%rax)
   fc88f:	mov    0x398(%rbx),%eax
   fc895:	push   %rax
   fc896:	mov    -0xac8(%rbp),%eax
   fc89c:	push   0x3e0(%rbx)
   fc8a2:	push   0x3d0(%rbx)
   fc8a8:	push   0x3f0(%rbx)
   fc8ae:	push   -0xa80(%rbp)
   fc8b4:	push   %rax
   fc8b5:	mov    0x710(%rbx),%eax
   fc8bb:	push   %rax
   fc8bc:	movss  0xfb6bc(%rip),%xmm4        # 1f7f80 <cuda::std::__4::in_place+0x33>
   fc8c4:	divss  -0xb58(%rbp),%xmm4
   fc8cc:	push   0x788(%rbx)
   fc8d2:	push   0x778(%rbx)
   fc8d8:	push   0x768(%rbx)
   fc8de:	push   0x758(%rbx)
   fc8e4:	push   0x7b8(%rbx)
   fc8ea:	push   0x748(%rbx)
   fc8f0:	push   0x738(%rbx)
   fc8f6:	push   0x728(%rbx)
   fc8fc:	push   0x718(%rbx)
   fc902:	push   -0xaa0(%rbp)
   fc908:	push   -0xaa8(%rbp)
   fc90e:	push   0x33b0(%rbx)
   fc914:	push   0xc0(%rbx)
   fc91a:	push   0x118(%rbx)
   fc920:	push   0x118(%r14)
   fc927:	movss  0x7d4(%rbx),%xmm3
   fc92f:	movss  0x7d0(%rbx),%xmm2
   fc937:	movss  0x7cc(%rbx),%xmm1
   fc93f:	mov    0x108(%r14),%r9
   fc946:	mov    0xf8(%r14),%r8
   fc94d:	call   6aaa0 <synreal::kernel::evaluate_soft_contact_force(int const*, unsigned long, int const*, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, int const*, unsigned long, unsigned long, int const*, int const*, synreal::Transform const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float const*, float const*, float const*, unsigned long, unsigned long, unsigned long, float, float, float, float, int const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, unsigned long, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, float*, int const*, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
   fc952:	add    $0x100,%rsp
   fc959:	call   6c890 <cudaGetLastError@plt>
   fc95e:	mov    %eax,%edi
   fc960:	lea    0xf8931(%rip),%rsi        # 1f5298 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5398>
   fc967:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc96c:	cmpb   $0x0,-0xad1(%rbp)
   fc973:	je     fc9be <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x195e>
   fc975:	mov    -0xaa0(%rbp),%rax
   fc97c:	mov    0x2ee0(%rbx),%rsi
   fc983:	mov    $0x3,%ecx
   fc988:	mov    0x2f00(%rbx),%rdi
   fc98f:	mov    -0xaf0(%rbp),%r8
   fc996:	lea    0x0(,%rax,4),%rdx
   fc99e:	call   6e0b0 <cudaMemcpyAsync@plt>
   fc9a3:	mov    %eax,%edi
   fc9a5:	lea    0xf891c(%rip),%rsi        # 1f52c8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x53c8>
   fc9ac:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc9b1:	cmpb   $0x0,-0xad5(%rbp)
   fc9b8:	jne    ffe50 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4df0>
   fc9be:	mov    -0xb50(%rbp),%eax
   fc9c4:	mov    0x3040(%rbx),%r12
   fc9cb:	test   %eax,%eax
   fc9cd:	je     fca97 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1a37>
   fc9d3:	mov    0x498(%rbx),%r13d
   fc9da:	imul   -0xa80(%rbp),%r13
   fc9e2:	movl   $0x1,-0x8a0(%rbp)
   fc9ec:	mov    -0xaf0(%rbp),%rax
   fc9f3:	mov    0xfb596(%rip),%rcx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fc9fa:	mov    %r13,%rdi
   fc9fd:	mov    %rax,-0xb58(%rbp)
   fca04:	mov    %rcx,-0x8a8(%rbp)
   fca0b:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fca10:	mov    %r15,-0x898(%rbp)
   fca17:	mov    -0x8a0(%rbp),%ecx
   fca1d:	xor    %r8d,%r8d
   fca20:	mov    %eax,-0x89c(%rbp)
   fca26:	mov    -0xb58(%rbp),%r9
   fca2d:	mov    -0x8a8(%rbp),%rdx
   fca34:	mov    -0x89c(%rbp),%rdi
   fca3b:	mov    -0x894(%rbp),%esi
   fca41:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fca46:	test   %eax,%eax
   fca48:	je     fff80 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4f20>
   fca4e:	call   6c890 <cudaGetLastError@plt>
   fca53:	mov    %eax,%edi
   fca55:	lea    0xf88dc(%rip),%rsi        # 1f5338 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5438>
   fca5c:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fca61:	cmpl   $0x1,-0xb1c(%rbp)
   fca68:	jne    fca90 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1a30>
   fca6a:	mov    -0xba8(%rbp),%rdi
   fca71:	test   %rdi,%rdi
   fca74:	je     fca90 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1a30>
   fca76:	movss  0xc(%rbx),%xmm0
   fca7b:	pxor   %xmm6,%xmm6
   fca7f:	comiss %xmm6,%xmm0
   fca82:	ja     100ef0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5e90>
   fca88:	nopl   0x0(%rax,%rax,1)
   fca90:	mov    0x3040(%rbx),%r12
   fca97:	mov    -0xb44(%rbp),%eax
   fca9d:	test   %eax,%eax
   fca9f:	je     fcb30 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ad0>
   fcaa5:	pxor   %xmm5,%xmm5
   fcaa9:	ucomiss 0xc(%rbx),%xmm5
   fcaad:	jp     fcab1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1a51>
   fcaaf:	je     fcb30 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ad0>
   fcab1:	mov    0xfb4d8(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fcab8:	mov    -0xb80(%rbp),%rdi
   fcabf:	movl   $0x1,-0x8a0(%rbp)
   fcac9:	mov    -0xaf0(%rbp),%r13
   fcad0:	mov    %rax,-0x8a8(%rbp)
   fcad7:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fcadc:	mov    %r15,-0x898(%rbp)
   fcae3:	mov    -0x8a0(%rbp),%ecx
   fcae9:	mov    %r13,%r9
   fcaec:	xor    %r8d,%r8d
   fcaef:	mov    %eax,-0x89c(%rbp)
   fcaf5:	mov    -0x8a8(%rbp),%rdx
   fcafc:	mov    -0x89c(%rbp),%rdi
   fcb03:	mov    -0x894(%rbp),%esi
   fcb09:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fcb0e:	test   %eax,%eax
   fcb10:	je     1005b8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5558>
   fcb16:	call   6c890 <cudaGetLastError@plt>
   fcb1b:	mov    %eax,%edi
   fcb1d:	lea    0xf887c(%rip),%rsi        # 1f53a0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x54a0>
   fcb24:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fcb29:	mov    0x3040(%rbx),%r12
   fcb30:	mov    -0xb4c(%rbp),%r13d
   fcb37:	test   %r13d,%r13d
   fcb3a:	je     fcbff <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1b9f>
   fcb40:	mov    0x568(%rbx),%r13d
   fcb47:	imul   -0xa80(%rbp),%r13
   fcb4f:	movl   $0x1,-0x8a0(%rbp)
   fcb59:	mov    -0xaf0(%rbp),%rax
   fcb60:	mov    0xfb429(%rip),%rcx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fcb67:	mov    %r13,%rdi
   fcb6a:	mov    %rax,-0xb58(%rbp)
   fcb71:	mov    %rcx,-0x8a8(%rbp)
   fcb78:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fcb7d:	mov    %r15,-0x898(%rbp)
   fcb84:	mov    -0x8a0(%rbp),%ecx
   fcb8a:	xor    %r8d,%r8d
   fcb8d:	mov    %eax,-0x89c(%rbp)
   fcb93:	mov    -0xb58(%rbp),%r9
   fcb9a:	mov    -0x8a8(%rbp),%rdx
   fcba1:	mov    -0x89c(%rbp),%rdi
   fcba8:	mov    -0x894(%rbp),%esi
   fcbae:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fcbb3:	test   %eax,%eax
   fcbb5:	je     ffef0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4e90>
   fcbbb:	call   6c890 <cudaGetLastError@plt>
   fcbc0:	mov    %eax,%edi
   fcbc2:	lea    0xf880f(%rip),%rsi        # 1f53d8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x54d8>
   fcbc9:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fcbce:	cmpl   $0x1,-0xb1c(%rbp)
   fcbd5:	jne    fcbf8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1b98>
   fcbd7:	mov    -0xa68(%rbp),%rdi
   fcbde:	test   %rdi,%rdi
   fcbe1:	je     fcbf8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1b98>
   fcbe3:	movss  0xc(%rbx),%xmm0
   fcbe8:	pxor   %xmm7,%xmm7
   fcbec:	comiss %xmm7,%xmm0
   fcbef:	ja     100f70 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5f10>
   fcbf5:	nopl   (%rax)
   fcbf8:	mov    0x3040(%rbx),%r12
   fcbff:	cmpb   $0x0,-0xad3(%rbp)
   fcc06:	je     fcca1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1c41>
   fcc0c:	mov    0x5d4(%rbx),%r13d
   fcc13:	imul   -0xa80(%rbp),%r13
   fcc1b:	movl   $0x1,-0x8a0(%rbp)
   fcc25:	mov    -0xaf0(%rbp),%rax
   fcc2c:	mov    0xfb35d(%rip),%rcx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fcc33:	mov    %r13,%rdi
   fcc36:	mov    %rax,-0xb58(%rbp)
   fcc3d:	mov    %rcx,-0x8a8(%rbp)
   fcc44:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fcc49:	mov    %r15,-0x898(%rbp)
   fcc50:	mov    -0x8a0(%rbp),%ecx
   fcc56:	xor    %r8d,%r8d
   fcc59:	mov    %eax,-0x89c(%rbp)
   fcc5f:	mov    -0xb58(%rbp),%r9
   fcc66:	mov    -0x8a8(%rbp),%rdx
   fcc6d:	mov    -0x89c(%rbp),%rdi
   fcc74:	mov    -0x894(%rbp),%esi
   fcc7a:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fcc7f:	test   %eax,%eax
   fcc81:	je     100000 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4fa0>
   fcc87:	call   6c890 <cudaGetLastError@plt>
   fcc8c:	mov    %eax,%edi
   fcc8e:	lea    0xf87ab(%rip),%rsi        # 1f5440 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5540>
   fcc95:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fcc9a:	mov    0x3040(%rbx),%r12
   fcca1:	mov    -0x850(%rbp),%rax
   fcca8:	cmpb   $0x0,0x3298(%rax)
   fccaf:	je     fcd3b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1cdb>
   fccb5:	mov    -0x840(%rbp),%rax
   fccbc:	mov    (%rax),%r13
   fccbf:	mov    0xfb2ca(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fccc6:	movl   $0x1,-0x8a0(%rbp)
   fccd0:	mov    %rax,-0x8a8(%rbp)
   fccd7:	mov    -0x848(%rbp),%rax
   fccde:	mov    0x68(%rax),%rdi
   fcce2:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fcce7:	mov    %r15,-0x898(%rbp)
   fccee:	mov    -0x8a0(%rbp),%ecx
   fccf4:	mov    %r13,%r9
   fccf7:	xor    %r8d,%r8d
   fccfa:	mov    %eax,-0x89c(%rbp)
   fcd00:	mov    -0x8a8(%rbp),%rdx
   fcd07:	mov    -0x89c(%rbp),%rdi
   fcd0e:	mov    -0x894(%rbp),%esi
   fcd14:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fcd19:	test   %eax,%eax
   fcd1b:	je     1000e8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5088>
   fcd21:	call   6c890 <cudaGetLastError@plt>
   fcd26:	mov    %eax,%edi
   fcd28:	lea    0xf8739(%rip),%rsi        # 1f5468 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5568>
   fcd2f:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fcd34:	mov    0x3040(%rbx),%r12
   fcd3b:	mov    -0x7f0(%rbp),%rax
   fcd42:	cmpb   $0x0,(%rax)
   fcd45:	je     fcdd0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1d70>
   fcd4b:	mov    -0x7e0(%rbp),%rax
   fcd52:	mov    (%rax),%r13
   fcd55:	mov    0xfb234(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fcd5c:	movl   $0x1,-0x8a0(%rbp)
   fcd66:	mov    %rax,-0x8a8(%rbp)
   fcd6d:	mov    -0x7e8(%rbp),%rax
   fcd74:	mov    (%rax),%rdi
   fcd77:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fcd7c:	mov    %r15,-0x898(%rbp)
   fcd83:	mov    -0x8a0(%rbp),%ecx
   fcd89:	mov    %r13,%r9
   fcd8c:	xor    %r8d,%r8d
   fcd8f:	mov    %eax,-0x89c(%rbp)
   fcd95:	mov    -0x8a8(%rbp),%rdx
   fcd9c:	mov    -0x89c(%rbp),%rdi
   fcda3:	mov    -0x894(%rbp),%esi
   fcda9:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fcdae:	test   %eax,%eax
   fcdb0:	je     100170 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5110>
   fcdb6:	call   6c890 <cudaGetLastError@plt>
   fcdbb:	mov    %eax,%edi
   fcdbd:	lea    0xf86c4(%rip),%rsi        # 1f5488 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5588>
   fcdc4:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fcdc9:	mov    0x3040(%rbx),%r12
   fcdd0:	mov    -0x820(%rbp),%rax
   fcdd7:	cmpb   $0x0,(%rax)
   fcdda:	je     fcea0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1e40>
   fcde0:	mov    -0x818(%rbp),%rax
   fcde7:	cmpq   $0x0,0x6d8(%rax)
   fcdef:	je     fcea0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1e40>
   fcdf5:	movq   0x6f0(%rax),%xmm0
   fcdfd:	movq   0x6d0(%rax),%xmm1
   fce05:	movl   $0x1,-0x910(%rbp)
   fce0f:	movhps 0x700(%rax),%xmm0
   fce16:	movhps 0x6e0(%rax),%xmm1
   fce1d:	mov    -0x808(%rbp),%rax
   fce24:	movaps %xmm1,-0x890(%rbp)
   fce2b:	mov    (%rax),%r13
   fce2e:	mov    0xfb15b(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fce35:	movaps %xmm0,-0x880(%rbp)
   fce3c:	mov    %rax,-0x918(%rbp)
   fce43:	mov    -0x810(%rbp),%rax
   fce4a:	mov    0x68(%rax),%rdi
   fce4e:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fce53:	mov    %r15,-0x8d4(%rbp)
   fce5a:	mov    -0x910(%rbp),%ecx
   fce60:	mov    %r13,%r9
   fce63:	xor    %r8d,%r8d
   fce66:	mov    %eax,-0x8d8(%rbp)
   fce6c:	mov    -0x918(%rbp),%rdx
   fce73:	mov    -0x8d8(%rbp),%rdi
   fce7a:	mov    -0x8d0(%rbp),%esi
   fce80:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fce85:	test   %eax,%eax
   fce87:	je     100630 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x55d0>
   fce8d:	call   6c890 <cudaGetLastError@plt>
   fce92:	mov    %eax,%edi
   fce94:	lea    0xf8615(%rip),%rsi        # 1f54b0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x55b0>
   fce9b:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fcea0:	cmpb   $0x0,-0xad1(%rbp)
   fcea7:	mov    -0xaf0(%rbp),%r12
   fceae:	jne    fece0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3c80>
   fceb4:	mov    0x398(%rbx),%r11d
   fcebb:	test   %r11d,%r11d
   fcebe:	je     fcefe <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1e9e>
   fcec0:	movss  0xc(%rbx),%xmm0
   fcec5:	pxor   %xmm4,%xmm4
   fcec9:	comiss %xmm4,%xmm0
   fcecc:	seta   %al
   fcecf:	cmpl   $0x2,-0xb30(%rbp)
   fced6:	jne    fcee0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1e80>
   fced8:	test   %al,%al
   fceda:	jne    100df0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5d90>
   fcee0:	cmpl   $0x3,-0xb30(%rbp)
   fcee7:	jne    fcef1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1e91>
   fcee9:	test   %al,%al
   fceeb:	jne    100e70 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5e10>
   fcef1:	pxor   %xmm4,%xmm4
   fcef5:	comiss %xmm4,%xmm0
   fcef8:	ja     ffd30 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4cd0>
   fcefe:	mov    0x240(%rbx),%r13d
   fcf05:	test   %r13d,%r13d
   fcf08:	jne    feba0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3b40>
   fcf0e:	mov    0x278(%rbx),%r13d
   fcf15:	test   %r13d,%r13d
   fcf18:	jne    fead0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3a70>
   fcf1e:	cmpb   $0x0,-0xad2(%rbp)
   fcf25:	jne    fe9d0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3970>
   fcf2b:	mov    0x318(%rbx),%edx
   fcf31:	test   %edx,%edx
   fcf33:	jne    fe8f8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3898>
   fcf39:	cmpb   $0x0,-0xb40(%rbp)
   fcf40:	je     fe580 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3520>
   fcf46:	xor    %r13d,%r13d
   fcf49:	cmpb   $0x0,-0xb10(%rbp)
   fcf50:	jne    fcf59 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ef9>
   fcf52:	mov    0x2f60(%rbx),%r13
   fcf59:	mov    0xfb030(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fcf60:	mov    %r15,-0x898(%rbp)
   fcf67:	mov    %r12,%r9
   fcf6a:	xor    %r8d,%r8d
   fcf6d:	mov    0xfb01c(%rip),%rdx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fcf74:	mov    -0x894(%rbp),%esi
   fcf7a:	mov    $0x1,%ecx
   fcf7f:	movl   $0x1,-0x8a0(%rbp)
   fcf89:	mov    %rax,-0x8a8(%rbp)
   fcf90:	mov    -0xae8(%rbp),%eax
   fcf96:	mov    %eax,-0x89c(%rbp)
   fcf9c:	mov    -0x89c(%rbp),%rdi
   fcfa3:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fcfa8:	test   %eax,%eax
   fcfaa:	jne    fcfc9 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1f69>
   fcfac:	mov    0x2f40(%rbx),%rsi
   fcfb3:	mov    0x2ee0(%rbx),%rdi
   fcfba:	mov    %r13,%rdx
   fcfbd:	mov    -0xaa0(%rbp),%rcx
   fcfc4:	call   6add0 <synreal::kernel::initialize_block_diagonal(float const*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long)@plt>
   fcfc9:	call   6c890 <cudaGetLastError@plt>
   fcfce:	mov    %eax,%edi
   fcfd0:	lea    0xf8641(%rip),%rsi        # 1f5618 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5718>
   fcfd7:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fcfdc:	cmpb   $0x0,-0xb10(%rbp)
   fcfe3:	je     fd324 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x22c4>
   fcfe9:	mov    -0xaf0(%rbp),%r12
   fcff0:	mov    0x2de0(%rbx),%rax
   fcff7:	cmpb   $0x0,-0xbb0(%rbp)
   fcffe:	mov    %rax,-0xb70(%rbp)
   fd005:	jne    ffe00 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4da0>
   fd00b:	mov    0x2f40(%rbx),%rax
   fd012:	mov    %rax,-0xb58(%rbp)
   fd019:	mov    0x2b88(%rbx),%rax
   fd020:	mov    %rax,-0xb90(%rbp)
   fd027:	mov    0x2ba8(%rbx),%rax
   fd02e:	mov    %rax,-0xb60(%rbp)
   fd035:	mov    -0xb74(%rbp),%eax
   fd03b:	test   %eax,%eax
   fd03d:	jne    fef48 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3ee8>
   fd043:	mov    0x278(%rbx),%r13d
   fd04a:	test   %r13d,%r13d
   fd04d:	jne    1006d0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5670>
   fd053:	mov    0x240(%rbx),%r13d
   fd05a:	test   %r13d,%r13d
   fd05d:	jne    1007b9 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5759>
   fd063:	mov    0x398(%rbx),%eax
   fd069:	test   %eax,%eax
   fd06b:	je     fd07a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x201a>
   fd06d:	cmpl   $0x2,-0xb30(%rbp)
   fd074:	je     101000 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5fa0>
   fd07a:	cmpb   $0x0,-0xbc8(%rbp)
   fd081:	je     fd18c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x212c>
   fd087:	mov    -0xbc0(%rbp),%r13
   fd08e:	imul   -0xa80(%rbp),%r13
   fd096:	movl   $0x1,-0x8a0(%rbp)
   fd0a0:	mov    0xfaee9(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fd0a7:	mov    %r13,%rdi
   fd0aa:	mov    %rax,-0x8a8(%rbp)
   fd0b1:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fd0b6:	mov    %r15,-0x898(%rbp)
   fd0bd:	mov    -0x8a0(%rbp),%ecx
   fd0c3:	mov    %r12,%r9
   fd0c6:	xor    %r8d,%r8d
   fd0c9:	mov    %eax,-0x89c(%rbp)
   fd0cf:	mov    -0x8a8(%rbp),%rdx
   fd0d6:	mov    -0x89c(%rbp),%rdi
   fd0dd:	mov    -0x894(%rbp),%esi
   fd0e3:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fd0e8:	test   %eax,%eax
   fd0ea:	jne    fd164 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2104>
   fd0ec:	sub    $0x8,%rsp
   fd0f0:	mov    -0xaf8(%rbp),%rax
   fd0f7:	mov    0x4b0(%rbx),%rcx
   fd0fe:	mov    0x4a0(%rbx),%rdx
   fd105:	mov    0x3d0(%rbx),%rsi
   fd10c:	push   -0xaa0(%rbp)
   fd112:	mov    0x4c0(%rbx),%r8
   fd119:	push   -0xaa8(%rbp)
   fd11f:	mov    (%rax),%rdi
   fd122:	push   -0xbc0(%rbp)
   fd128:	push   %r13
   fd12a:	push   -0xb60(%rbp)
   fd130:	push   -0xb70(%rbp)
   fd136:	push   -0xb90(%rbp)
   fd13c:	push   -0xb58(%rbp)
   fd142:	push   0x4e0(%rbx)
   fd148:	push   0x4d0(%rbx)
   fd14e:	push   0x33f0(%rbx)
   fd154:	mov    0x33d0(%rbx),%r9
   fd15b:	call   6ae00 <synreal::kernel::add_body_spring_gauss_newton_hessian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
   fd160:	add    $0x60,%rsp
   fd164:	call   6c890 <cudaGetLastError@plt>
   fd169:	mov    %eax,%edi
   fd16b:	lea    0xf8586(%rip),%rsi        # 1f56f8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x57f8>
   fd172:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fd177:	mov    -0xb74(%rbp),%eax
   fd17d:	mov    -0xaf0(%rbp),%r12
   fd184:	test   %eax,%eax
   fd186:	jne    fd2d8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2278>
   fd18c:	mov    -0xb4c(%rbp),%eax
   fd192:	test   %eax,%eax
   fd194:	je     fd1d0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2170>
   fd196:	cmpl   $0x1,-0xb1c(%rbp)
   fd19d:	mov    0x568(%rbx),%eax
   fd1a3:	mov    -0xa80(%rbp),%r13
   fd1aa:	jne    100b50 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5af0>
   fd1b0:	mov    %eax,%edx
   fd1b2:	sub    0x56c(%rbx),%edx
   fd1b8:	imul   %rdx,%r13
   fd1bc:	mov    %rdx,-0xbe0(%rbp)
   fd1c3:	test   %r13,%r13
   fd1c6:	jne    1018f0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6890>
   fd1cc:	nopl   0x0(%rax)
   fd1d0:	cmpb   $0x0,-0xbd0(%rbp)
   fd1d7:	je     fd2d8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2278>
   fd1dd:	mov    0xfadac(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fd1e4:	mov    -0xa68(%rbp),%rdi
   fd1eb:	movl   $0x1,-0x8a0(%rbp)
   fd1f5:	mov    %rax,-0x8a8(%rbp)
   fd1fc:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fd201:	mov    %r15,-0x898(%rbp)
   fd208:	mov    -0x8a0(%rbp),%ecx
   fd20e:	mov    %r12,%r9
   fd211:	xor    %r8d,%r8d
   fd214:	mov    %eax,-0x89c(%rbp)
   fd21a:	mov    -0x8a8(%rbp),%rdx
   fd221:	mov    -0x89c(%rbp),%rdi
   fd228:	mov    -0x894(%rbp),%esi
   fd22e:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fd233:	test   %eax,%eax
   fd235:	jne    fd2be <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x225e>
   fd23b:	mov    0x56c(%rbx),%eax
   fd241:	sub    $0x8,%rsp
   fd245:	mov    0x34d0(%rbx),%rcx
   fd24c:	mov    0x34b0(%rbx),%rdx
   fd253:	mov    0x570(%rbx),%rsi
   fd25a:	mov    0x3d0(%rbx),%rdi
   fd261:	push   -0xaa0(%rbp)
   fd267:	movss  -0xac4(%rbp),%xmm0
   fd26f:	push   -0xaa8(%rbp)
   fd275:	mov    0x34f0(%rbx),%r8
   fd27c:	push   %rax
   fd27d:	mov    0x568(%rbx),%eax
   fd283:	push   %rax
   fd284:	push   -0xa68(%rbp)
   fd28a:	push   -0xb60(%rbp)
   fd290:	push   -0xb70(%rbp)
   fd296:	push   -0xb90(%rbp)
   fd29c:	push   -0xb58(%rbp)
   fd2a2:	push   0x3530(%rbx)
   fd2a8:	push   0x3510(%rbx)
   fd2ae:	mov    0x5b0(%rbx),%r9
   fd2b5:	call   6ab30 <synreal::kernel::add_joint_body_point_line_gauss_newton_hessian(glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
   fd2ba:	add    $0x60,%rsp
   fd2be:	call   6c890 <cudaGetLastError@plt>
   fd2c3:	mov    %eax,%edi
   fd2c5:	lea    0xf848c(%rip),%rsi        # 1f5758 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5858>
   fd2cc:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fd2d1:	mov    -0xaf0(%rbp),%r12
   fd2d8:	mov    -0xaa0(%rbp),%rax
   fd2df:	mov    0x2f60(%rbx),%rdi
   fd2e6:	mov    %r12,%r8
   fd2e9:	mov    $0x3,%ecx
   fd2ee:	mov    -0xb58(%rbp),%rsi
   fd2f5:	lea    (%rax,%rax,8),%rdx
   fd2f9:	shl    $0x2,%rdx
   fd2fd:	call   6e0b0 <cudaMemcpyAsync@plt>
   fd302:	mov    %eax,%edi
   fd304:	lea    0xf8485(%rip),%rsi        # 1f5790 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5890>
   fd30b:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fd310:	cmpb   $0x0,-0xb40(%rbp)
   fd317:	mov    -0xaf0(%rbp),%r12
   fd31e:	je     fe58d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x352d>
   fd324:	cmpb   $0x0,-0xb38(%rbp)
   fd32b:	je     fe538 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34d8>
   fd331:	cmpb   $0x0,-0xad8(%rbp)
   fd338:	je     fe538 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34d8>
   fd33e:	cmpb   $0x0,0x1d(%rbx)
   fd342:	je     fe538 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34d8>
   fd348:	cmpb   $0x0,0x41(%rbx)
   fd34c:	je     1010d0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6070>
   fd352:	mov    0x2f80(%rbx),%rdi
   fd359:	mov    %rdi,-0xb58(%rbp)
   fd360:	test   %rdi,%rdi
   fd363:	je     10046b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x540b>
   fd369:	mov    -0xa78(%rbp),%rax
   fd370:	mov    -0xaf0(%rbp),%rcx
   fd377:	xor    %esi,%esi
   fd379:	lea    (%rax,%rax,8),%rdx
   fd37d:	shl    $0x6,%rdx
   fd381:	call   6e930 <cudaMemsetAsync@plt>
   fd386:	mov    %eax,%edi
   fd388:	lea    0xf8439(%rip),%rsi        # 1f57c8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x58c8>
   fd38f:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fd394:	cmpb   $0x0,-0xad9(%rbp)
   fd39b:	je     fd3a7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2347>
   fd39d:	cmpb   $0x0,0x41(%rbx)
   fd3a1:	jne    100480 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5420>
   fd3a7:	cmpb   $0x0,-0xad6(%rbp)
   fd3ae:	je     fd5b8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2558>
   fd3b4:	mov    -0xb74(%rbp),%r13d
   fd3bb:	test   %r13d,%r13d
   fd3be:	je     fd3ca <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x236a>
   fd3c0:	cmpb   $0x0,0x41(%rbx)
   fd3c4:	je     fd5b8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2558>
   fd3ca:	mov    0x2f60(%rbx),%rax
   fd3d1:	movss  -0xae4(%rbp),%xmm7
   fd3d9:	cmpb   $0x0,-0xad5(%rbp)
   fd3e0:	mov    0x2f40(%rbx),%r13
   fd3e7:	mov    %rax,-0xb90(%rbp)
   fd3ee:	mov    0x3060(%rbx),%rax
   fd3f5:	movss  %xmm7,-0xb70(%rbp)
   fd3fd:	mov    %rax,-0xb60(%rbp)
   fd404:	je     fd414 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x23b4>
   fd406:	cmpq   $0x0,0x150(%r14)
   fd40e:	je     fd5b8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2558>
   fd414:	mov    0xfab75(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fd41b:	mov    0xd0(%r14),%edi
   fd422:	movl   $0x1,-0x8a0(%rbp)
   fd42c:	mov    -0xaf0(%rbp),%r12
   fd433:	mov    %rax,-0x8a8(%rbp)
   fd43a:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fd43f:	mov    %r15,-0x898(%rbp)
   fd446:	mov    -0x8a0(%rbp),%ecx
   fd44c:	mov    %r12,%r9
   fd44f:	xor    %r8d,%r8d
   fd452:	mov    %eax,-0x89c(%rbp)
   fd458:	mov    -0x8a8(%rbp),%rdx
   fd45f:	mov    -0x89c(%rbp),%rdi
   fd466:	mov    -0x894(%rbp),%esi
   fd46c:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fd471:	test   %eax,%eax
   fd473:	jne    fd5a2 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2542>
   fd479:	xor    %eax,%eax
   fd47b:	cmpb   $0x0,-0xad5(%rbp)
   fd482:	mov    0x150(%r14),%r8
   fd489:	jne    101c60 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6c00>
   fd48f:	sub    $0x8,%rsp
   fd493:	movss  0x7c8(%rbx),%xmm0
   fd49b:	push   -0xb90(%rbp)
   fd4a1:	mov    0xe8(%r14),%rcx
   fd4a8:	push   %r13
   fd4aa:	mov    0xd8(%r14),%rdx
   fd4b1:	mov    0xd0(%r14),%esi
   fd4b8:	push   %r8
   fd4ba:	push   %rax
   fd4bb:	mov    -0xaf8(%rbp),%rax
   fd4c2:	push   $0x0
   fd4c4:	mov    0xc0(%r14),%rdi
   fd4cb:	push   $0x0
   fd4cd:	push   -0xb60(%rbp)
   fd4d3:	push   0x10(%rax)
   fd4d6:	push   (%rax)
   fd4d8:	mov    0x398(%rbx),%eax
   fd4de:	push   %rax
   fd4df:	mov    -0xac8(%rbp),%eax
   fd4e5:	push   0x3e0(%rbx)
   fd4eb:	push   0x3d0(%rbx)
   fd4f1:	push   0x3f0(%rbx)
   fd4f7:	push   -0xa80(%rbp)
   fd4fd:	push   %rax
   fd4fe:	mov    0x710(%rbx),%eax
   fd504:	push   %rax
   fd505:	movss  0xfaa73(%rip),%xmm4        # 1f7f80 <cuda::std::__4::in_place+0x33>
   fd50d:	divss  -0xb70(%rbp),%xmm4
   fd515:	push   0x788(%rbx)
   fd51b:	push   0x778(%rbx)
   fd521:	push   0x768(%rbx)
   fd527:	push   0x758(%rbx)
   fd52d:	push   0x7b8(%rbx)
   fd533:	push   0x748(%rbx)
   fd539:	push   0x738(%rbx)
   fd53f:	push   0x728(%rbx)
   fd545:	push   0x718(%rbx)
   fd54b:	push   -0xaa0(%rbp)
   fd551:	push   -0xaa8(%rbp)
   fd557:	push   0x33b0(%rbx)
   fd55d:	push   0xc0(%rbx)
   fd563:	push   0x118(%rbx)
   fd569:	push   0x118(%r14)
   fd570:	movss  0x7d4(%rbx),%xmm3
   fd578:	movss  0x7d0(%rbx),%xmm2
   fd580:	movss  0x7cc(%rbx),%xmm1
   fd588:	mov    0x108(%r14),%r9
   fd58f:	mov    0xf8(%r14),%r8
   fd596:	call   6aaa0 <synreal::kernel::evaluate_soft_contact_force(int const*, unsigned long, int const*, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, int const*, unsigned long, unsigned long, int const*, int const*, synreal::Transform const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float const*, float const*, float const*, unsigned long, unsigned long, unsigned long, float, float, float, float, int const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, unsigned long, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, float*, int const*, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
   fd59b:	add    $0x100,%rsp
   fd5a2:	call   6c890 <cudaGetLastError@plt>
   fd5a7:	mov    %eax,%edi
   fd5a9:	lea    0xf7ce8(%rip),%rsi        # 1f5298 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5398>
   fd5b0:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fd5b5:	nopl   (%rax)
   fd5b8:	cmpb   $0x0,-0xad0(%rbp)
   fd5bf:	jne    ffc60 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4c00>
   fd5c5:	cmpb   $0x1,-0xacf(%rbp)
   fd5cc:	jne    fd5db <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x257b>
   fd5ce:	cmpb   $0x0,-0xb38(%rbp)
   fd5d5:	je     1003a8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5348>
   fd5db:	cmpb   $0x0,-0xad2(%rbp)
   fd5e2:	jne    ffb80 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4b20>
   fd5e8:	cmpb   $0x0,0x3340(%rbx)
   fd5ef:	jne    ffaa0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4a40>
   fd5f5:	cmpb   $0x0,-0xad1(%rbp)
   fd5fc:	jne    ffa80 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4a20>
   fd602:	mov    0x17e8(%rbx),%r8d
   fd609:	test   %r8d,%r8d
   fd60c:	jne    ffa58 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x49f8>
   fd612:	mov    0x2180(%rbx),%edi
   fd618:	test   %edi,%edi
   fd61a:	jne    ff6c0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4660>
   fd620:	cmpb   $0x0,-0xad5(%rbp)
   fd627:	jne    ff6e7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4687>
   fd62d:	cmpb   $0x0,-0xada(%rbp)
   fd634:	jne    ff78d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x472d>
   fd63a:	cmpb   $0x0,-0xace(%rbp)
   fd641:	jne    ff849 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x47e9>
   fd647:	cmpb   $0x0,-0xacd(%rbp)
   fd64e:	jne    ff935 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x48d5>
   fd654:	mov    -0x850(%rbp),%rax
   fd65b:	mov    0x2f60(%rbx),%r12
   fd662:	cmpb   $0x0,0x3298(%rax)
   fd669:	je     fd6f5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2695>
   fd66f:	mov    -0x840(%rbp),%rax
   fd676:	mov    (%rax),%r13
   fd679:	mov    0xfa910(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fd680:	movl   $0x1,-0x8a0(%rbp)
   fd68a:	mov    %rax,-0x8a8(%rbp)
   fd691:	mov    -0x848(%rbp),%rax
   fd698:	mov    0x68(%rax),%rdi
   fd69c:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fd6a1:	mov    %r15,-0x898(%rbp)
   fd6a8:	mov    -0x8a0(%rbp),%ecx
   fd6ae:	mov    %r13,%r9
   fd6b1:	xor    %r8d,%r8d
   fd6b4:	mov    %eax,-0x89c(%rbp)
   fd6ba:	mov    -0x8a8(%rbp),%rdx
   fd6c1:	mov    -0x89c(%rbp),%rdi
   fd6c8:	mov    -0x894(%rbp),%esi
   fd6ce:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fd6d3:	test   %eax,%eax
   fd6d5:	je     100530 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x54d0>
   fd6db:	call   6c890 <cudaGetLastError@plt>
   fd6e0:	mov    %eax,%edi
   fd6e2:	lea    0xf7d7f(%rip),%rsi        # 1f5468 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5568>
   fd6e9:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fd6ee:	mov    0x2f60(%rbx),%r12
   fd6f5:	cmpb   $0x0,-0xb38(%rbp)
   fd6fc:	jne    fd797 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2737>
   fd702:	mov    -0x7f0(%rbp),%rax
   fd709:	cmpb   $0x0,(%rax)
   fd70c:	je     fd797 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2737>
   fd712:	mov    -0x7e0(%rbp),%rax
   fd719:	mov    (%rax),%r13
   fd71c:	mov    0xfa86d(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fd723:	movl   $0x1,-0x8a0(%rbp)
   fd72d:	mov    %rax,-0x8a8(%rbp)
   fd734:	mov    -0x7e8(%rbp),%rax
   fd73b:	mov    (%rax),%rdi
   fd73e:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fd743:	mov    %r15,-0x898(%rbp)
   fd74a:	mov    -0x8a0(%rbp),%ecx
   fd750:	mov    %r13,%r9
   fd753:	xor    %r8d,%r8d
   fd756:	mov    %eax,-0x89c(%rbp)
   fd75c:	mov    -0x8a8(%rbp),%rdx
   fd763:	mov    -0x89c(%rbp),%rdi
   fd76a:	mov    -0x894(%rbp),%esi
   fd770:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fd775:	test   %eax,%eax
   fd777:	je     100998 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5938>
   fd77d:	call   6c890 <cudaGetLastError@plt>
   fd782:	mov    %eax,%edi
   fd784:	lea    0xf7cfd(%rip),%rsi        # 1f5488 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5588>
   fd78b:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fd790:	mov    0x2f60(%rbx),%r12
   fd797:	mov    -0x820(%rbp),%rax
   fd79e:	cmpb   $0x0,(%rax)
   fd7a1:	je     fd867 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2807>
   fd7a7:	mov    -0x818(%rbp),%rax
   fd7ae:	cmpq   $0x0,0x6d8(%rax)
   fd7b6:	je     fd867 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2807>
   fd7bc:	movq   0x6f0(%rax),%xmm0
   fd7c4:	movq   0x6d0(%rax),%xmm1
   fd7cc:	movl   $0x1,-0x900(%rbp)
   fd7d6:	movhps 0x700(%rax),%xmm0
   fd7dd:	movhps 0x6e0(%rax),%xmm1
   fd7e4:	mov    -0x808(%rbp),%rax
   fd7eb:	movaps %xmm1,-0x870(%rbp)
   fd7f2:	mov    (%rax),%r13
   fd7f5:	mov    0xfa794(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fd7fc:	movaps %xmm0,-0x860(%rbp)
   fd803:	mov    %rax,-0x908(%rbp)
   fd80a:	mov    -0x810(%rbp),%rax
   fd811:	mov    0x68(%rax),%rdi
   fd815:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fd81a:	mov    %r15,-0x8c8(%rbp)
   fd821:	mov    -0x900(%rbp),%ecx
   fd827:	mov    %r13,%r9
   fd82a:	xor    %r8d,%r8d
   fd82d:	mov    %eax,-0x8cc(%rbp)
   fd833:	mov    -0x908(%rbp),%rdx
   fd83a:	mov    -0x8cc(%rbp),%rdi
   fd841:	mov    -0x8c4(%rbp),%esi
   fd847:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fd84c:	test   %eax,%eax
   fd84e:	je     100a30 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x59d0>
   fd854:	call   6c890 <cudaGetLastError@plt>
   fd859:	mov    %eax,%edi
   fd85b:	lea    0xf7c4e(%rip),%rsi        # 1f54b0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x55b0>
   fd862:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fd867:	cmpb   $0x0,-0xad7(%rbp)
   fd86e:	mov    -0xaf0(%rbp),%r12
   fd875:	jne    ff570 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4510>
   fd87b:	cmpb   $0x0,-0xb38(%rbp)
   fd882:	je     fde24 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2dc4>
   fd888:	mov    0xfa701(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fd88f:	cmpb   $0x0,-0xb10(%rbp)
   fd896:	movl   $0x1,-0x8f0(%rbp)
   fd8a0:	mov    -0xa78(%rbp),%rdi
   fd8a7:	mov    %rax,-0x8f8(%rbp)
   fd8ae:	je     ff068 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4008>
   fd8b4:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fd8b9:	mov    %r15,-0x898(%rbp)
   fd8c0:	mov    -0x8f0(%rbp),%ecx
   fd8c6:	mov    %r12,%r9
   fd8c9:	xor    %r8d,%r8d
   fd8cc:	mov    %eax,-0x89c(%rbp)
   fd8d2:	mov    -0x8f8(%rbp),%rdx
   fd8d9:	mov    -0x89c(%rbp),%rdi
   fd8e0:	mov    -0x894(%rbp),%esi
   fd8e6:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fd8eb:	mov    %eax,%r8d
   fd8ee:	lea    -0xa58(%rbp),%rax
   fd8f5:	lea    -0x9f0(%rbp),%rdx
   fd8fc:	movq   %rax,%xmm9
   fd901:	lea    -0xa50(%rbp),%rax
   fd908:	movq   %rdx,%xmm10
   fd90d:	movq   %rax,%xmm7
   fd912:	lea    -0xa48(%rbp),%rax
   fd919:	lea    -0x9e0(%rbp),%rdx
   fd920:	movq   %rax,%xmm8
   fd925:	lea    -0xa40(%rbp),%rax
   fd92c:	punpcklqdq %xmm7,%xmm9
   fd931:	movq   %rax,%xmm5
   fd936:	lea    -0xa38(%rbp),%rax
   fd93d:	movq   %rax,%xmm7
   fd942:	lea    -0xa30(%rbp),%rax
   fd949:	punpcklqdq %xmm5,%xmm8
   fd94e:	movq   %rax,%xmm6
   fd953:	lea    -0xa28(%rbp),%rax
   fd95a:	punpcklqdq %xmm6,%xmm7
   fd95e:	movq   %rax,%xmm6
   fd963:	lea    -0xa20(%rbp),%rax
   fd96a:	movq   %rax,%xmm5
   fd96f:	lea    -0xa18(%rbp),%rax
   fd976:	punpcklqdq %xmm5,%xmm6
   fd97a:	movq   %rax,%xmm5
   fd97f:	lea    -0xa10(%rbp),%rax
   fd986:	movq   %rax,%xmm4
   fd98b:	lea    -0xab8(%rbp),%rax
   fd992:	punpcklqdq %xmm4,%xmm5
   fd996:	movq   %rax,%xmm4
   fd99b:	lea    -0x640(%rbp),%rax
   fd9a2:	movq   %rax,%xmm3
   fd9a7:	lea    -0xa08(%rbp),%rax
   fd9ae:	punpcklqdq %xmm3,%xmm4
   fd9b2:	movq   %rax,%xmm3
   fd9b7:	lea    -0xa00(%rbp),%rax
   fd9be:	movq   %rax,%xmm2
   fd9c3:	lea    -0xab4(%rbp),%rax
   fd9ca:	punpcklqdq %xmm2,%xmm3
   fd9ce:	movq   %rax,%xmm2
   fd9d3:	lea    -0x9f8(%rbp),%rax
   fd9da:	movq   %rax,%xmm1
   fd9df:	lea    -0x9e8(%rbp),%rax
   fd9e6:	punpcklqdq %xmm1,%xmm2
   fd9ea:	movq   %rax,%xmm1
   fd9ef:	lea    -0x9d8(%rbp),%rax
   fd9f6:	movq   %rax,%xmm0
   fd9fb:	punpcklqdq %xmm1,%xmm10
   fda00:	lea    -0x9d0(%rbp),%rax
   fda07:	movq   %rdx,%xmm1
   fda0c:	lea    -0x9c8(%rbp),%rdx
   fda13:	punpcklqdq %xmm0,%xmm1
   fda17:	movq   %rdx,%xmm14
   fda1c:	movq   %rax,%xmm0
   fda21:	punpcklqdq %xmm14,%xmm0
   fda26:	test   %r8d,%r8d
   fda29:	jne    fdd6c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2d0c>
   fda2f:	mov    -0xaa8(%rbp),%rax
   fda36:	cmpb   $0x0,-0xacf(%rbp)
   fda3d:	pxor   %xmm11,%xmm11
   fda42:	movss  0xfa535(%rip),%xmm13        # 1f7f80 <cuda::std::__4::in_place+0x33>
   fda4b:	movd   0x398(%rbx),%xmm12
   fda54:	divss  -0xae4(%rbp),%xmm13
   fda5d:	mov    %rax,-0xb70(%rbp)
   fda64:	mov    -0xa78(%rbp),%rax
   fda6b:	mov    0x2f80(%rbx),%rsi
   fda72:	mov    0x2fc0(%rbx),%rdi
   fda79:	mov    %rax,-0xb60(%rbp)
   fda80:	mov    0x2fa0(%rbx),%rax
   fda87:	mov    0x3000(%rbx),%r8
   fda8e:	mov    0x2fe0(%rbx),%r9
   fda95:	mov    %rax,-0xb90(%rbp)
   fda9c:	je     fdaad <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2a4d>
   fda9e:	movss  0xc(%rbx),%xmm11
   fdaa4:	mulss  -0xacc(%rbp),%xmm11
   fdaad:	mov    0x2bb0(%rbx),%rax
   fdab4:	mov    0x2f60(%rbx),%rdx
   fdabb:	mov    0x3350(%rbx),%r10
   fdac2:	mov    0x2ba8(%rbx),%r11
   fdac9:	test   %rax,%rax
   fdacc:	mov    %rdx,-0xbe0(%rbp)
   fdad3:	cmove  -0xaa0(%rbp),%rax
   fdadb:	xor    %edx,%edx
   fdadd:	cmpq   $0x0,0x100(%rbx)
   fdae5:	mov    0x2b98(%rbx),%r12
   fdaec:	mov    0x2b88(%rbx),%r13
   fdaf3:	je     fdafc <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2a9c>
   fdaf5:	mov    0xf8(%rbx),%rdx
   fdafc:	movdqa -0x6e0(%rbp),%xmm14
   fdb05:	mov    0x3d0(%rbx),%rcx
   fdb0c:	mov    %rdx,-0xa40(%rbp)
   fdb13:	movdqa -0x6d0(%rbp),%xmm15
   fdb1c:	mov    -0xbe0(%rbp),%rdx
   fdb23:	mov    %r13,-0xa30(%rbp)
   fdb2a:	movaps %xmm14,-0x640(%rbp)
   fdb32:	movdqa -0x6c0(%rbp),%xmm14
   fdb3b:	movaps %xmm15,-0x630(%rbp)
   fdb43:	movdqa -0x6b0(%rbp),%xmm15
   fdb4c:	movaps %xmm14,-0x620(%rbp)
   fdb54:	movdqa -0x6a0(%rbp),%xmm14
   fdb5d:	movaps %xmm15,-0x610(%rbp)
   fdb65:	movdqa -0x690(%rbp),%xmm15
   fdb6e:	mov    %rcx,-0xa58(%rbp)
   fdb75:	mov    0x3a0(%rbx),%rcx
   fdb7c:	movaps %xmm14,-0x600(%rbp)
   fdb84:	movdqa -0x680(%rbp),%xmm14
   fdb8d:	movaps %xmm15,-0x5f0(%rbp)
   fdb95:	movdqa -0x670(%rbp),%xmm15
   fdb9e:	mov    %rcx,-0xa50(%rbp)
   fdba5:	mov    0xc0(%rbx),%rcx
   fdbac:	movaps %xmm14,-0x5e0(%rbp)
   fdbb4:	movdqa -0x660(%rbp),%xmm14
   fdbbd:	movaps %xmm15,-0x5d0(%rbp)
   fdbc5:	movdqa -0x650(%rbp),%xmm15
   fdbce:	mov    %rcx,-0xa48(%rbp)
   fdbd5:	lea    -0x920(%rbp),%rcx
   fdbdc:	mov    %rdx,-0xa38(%rbp)
   fdbe3:	lea    -0x928(%rbp),%rdx
   fdbea:	mov    %r12,-0xa28(%rbp)
   fdbf1:	mov    %r11,-0xa20(%rbp)
   fdbf8:	movaps %xmm14,-0x5c0(%rbp)
   fdc00:	movaps %xmm15,-0x5b0(%rbp)
   fdc08:	mov    %rax,-0xa18(%rbp)
   fdc0f:	mov    -0xb58(%rbp),%rax
   fdc16:	mov    %rdi,-0x9f8(%rbp)
   fdc1d:	lea    -0x8e8(%rbp),%rdi
   fdc24:	mov    %rax,-0x9f0(%rbp)
   fdc2b:	mov    -0xb90(%rbp),%rax
   fdc32:	mov    %rsi,-0x9e8(%rbp)
   fdc39:	lea    -0x8a8(%rbp),%rsi
   fdc40:	mov    %rax,-0x9e0(%rbp)
   fdc47:	mov    -0xb60(%rbp),%rax
   fdc4e:	mov    %r10,-0xa10(%rbp)
   fdc55:	mov    %rax,-0x9d8(%rbp)
   fdc5c:	mov    -0xb70(%rbp),%rax
   fdc63:	mov    %r9,-0xa08(%rbp)
   fdc6a:	mov    %rax,-0x9c8(%rbp)
   fdc71:	mov    0xfa2f8(%rip),%rax        # 1f7f70 <cuda::std::__4::in_place+0x23>
   fdc78:	mov    %r8,-0xa00(%rbp)
   fdc7f:	mov    %rax,-0x8e8(%rbp)
   fdc86:	movl   $0x1,-0x8e0(%rbp)
   fdc90:	mov    %rax,-0x8a8(%rbp)
   fdc97:	movl   $0x1,-0x8a0(%rbp)
   fdca1:	movss  %xmm11,-0xab8(%rbp)
   fdcaa:	movss  %xmm13,-0xab4(%rbp)
   fdcb3:	movq   %xmm12,-0x9d0(%rbp)
   fdcbc:	movaps %xmm9,-0x170(%rbp)
   fdcc4:	movaps %xmm8,-0x160(%rbp)
   fdccc:	movaps %xmm7,-0x150(%rbp)
   fdcd3:	movaps %xmm6,-0x140(%rbp)
   fdcda:	movaps %xmm5,-0x130(%rbp)
   fdce1:	movaps %xmm4,-0x120(%rbp)
   fdce8:	movaps %xmm3,-0x110(%rbp)
   fdcef:	movaps %xmm2,-0x100(%rbp)
   fdcf6:	movaps %xmm10,-0xf0(%rbp)
   fdcfe:	movaps %xmm1,-0xe0(%rbp)
   fdd05:	movaps %xmm0,-0xd0(%rbp)
   fdd0c:	call   6eb40 <__cudaPopCallConfiguration@plt>
   fdd11:	test   %eax,%eax
   fdd13:	jne    fdd6c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2d0c>
   fdd15:	push   -0x920(%rbp)
   fdd1b:	mov    -0x8e8(%rbp),%rsi
   fdd22:	lea    -0x170(%rbp),%r9
   fdd29:	mov    -0x8e0(%rbp),%edx
   fdd2f:	push   -0x928(%rbp)
   fdd35:	mov    -0x8a8(%rbp),%rcx
   fdd3c:	mov    %rsi,-0x8b4(%rbp)
   fdd43:	mov    -0x8a0(%rbp),%r8d
   fdd4a:	mov    0x5b8e57(%rip),%rdi        # 6b6ba8 <void synreal::kernel::build_affine_body_preconditioner<synreal::BlockNonZeroEntry>(glm::vec<4, int, (glm::qualifier)0> const*, float const*, float const*, int const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, int const*, synreal::BlockNonZeroEntry const*, unsigned long, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, synreal::kernel::CableView, unsigned long const*, int const*, float, int const*, float const*, float*, int*, unsigned long, unsigned long, unsigned long)@@Base+0x5a74a8>
   fdd51:	mov    %edx,-0x8ac(%rbp)
   fdd57:	mov    %rcx,-0x8c0(%rbp)
   fdd5e:	mov    %r8d,-0x8b8(%rbp)
   fdd65:	call   6b4f0 <cudaLaunchKernel@plt>
   fdd6a:	pop    %rax
   fdd6b:	pop    %rdx
   fdd6c:	call   6c890 <cudaGetLastError@plt>
   fdd71:	mov    %eax,%edi
   fdd73:	lea    0xf7c96(%rip),%rsi        # 1f5a10 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5b10>
   fdd7a:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fdd7f:	cmpb   $0x0,-0xacf(%rbp)
   fdd86:	jne    100208 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x51a8>
   fdd8c:	mov    -0x7f0(%rbp),%rax
   fdd93:	mov    0x2f60(%rbx),%r12
   fdd9a:	cmpb   $0x0,(%rax)
   fdd9d:	je     fde1d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2dbd>
   fdd9f:	mov    -0x7e0(%rbp),%rax
   fdda6:	mov    (%rax),%r13
   fdda9:	mov    0xfa1e0(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fddb0:	movl   $0x1,-0x8a0(%rbp)
   fddba:	mov    %rax,-0x8a8(%rbp)
   fddc1:	mov    -0x7e8(%rbp),%rax
   fddc8:	mov    (%rax),%rdi
   fddcb:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fddd0:	mov    %r15,-0x898(%rbp)
   fddd7:	mov    -0x8a0(%rbp),%ecx
   fdddd:	mov    %r13,%r9
   fdde0:	xor    %r8d,%r8d
   fdde3:	mov    %eax,-0x89c(%rbp)
   fdde9:	mov    -0x8a8(%rbp),%rdx
   fddf0:	mov    -0x89c(%rbp),%rdi
   fddf7:	mov    -0x894(%rbp),%esi
   fddfd:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fde02:	test   %eax,%eax
   fde04:	je     100900 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x58a0>
   fde0a:	call   6c890 <cudaGetLastError@plt>
   fde0f:	mov    %eax,%edi
   fde11:	lea    0xf7670(%rip),%rsi        # 1f5488 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5588>
   fde18:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fde1d:	mov    -0xaf0(%rbp),%r12
   fde24:	mov    0xfa165(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fde2b:	mov    %r15,-0x898(%rbp)
   fde32:	mov    %r12,%r9
   fde35:	xor    %r8d,%r8d
   fde38:	mov    0xfa151(%rip),%rdx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fde3f:	mov    -0x894(%rbp),%esi
   fde45:	mov    $0x1,%ecx
   fde4a:	movl   $0x1,-0x8a0(%rbp)
   fde54:	mov    %rax,-0x8a8(%rbp)
   fde5b:	mov    -0xae8(%rbp),%eax
   fde61:	mov    %eax,-0x89c(%rbp)
   fde67:	mov    -0x89c(%rbp),%rdi
   fde6e:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fde73:	test   %eax,%eax
   fde75:	jne    fdeae <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2e4e>
   fde77:	xor    %edx,%edx
   fde79:	cmpq   $0x0,0x100(%rbx)
   fde81:	mov    -0xaa8(%rbp),%r9
   fde88:	mov    -0xaa0(%rbp),%r8
   fde8f:	mov    0x2f60(%rbx),%rdi
   fde96:	je     fde9f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2e3f>
   fde98:	mov    0xf8(%rbx),%rdx
   fde9f:	mov    0xc0(%rbx),%rsi
   fdea6:	mov    %rdi,%rcx
   fdea9:	call   6a920 <synreal::kernel::invert_block_preconditioner(glm::mat<3, 3, float, (glm::qualifier)0> const*, float const*, int const*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long)@plt>
   fdeae:	call   6c890 <cudaGetLastError@plt>
   fdeb3:	mov    %eax,%edi
   fdeb5:	lea    0xf7bac(%rip),%rsi        # 1f5a68 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5b68>
   fdebc:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fdec1:	cmpb   $0x0,-0xb10(%rbp)
   fdec8:	mov    -0xaa0(%rbp),%r10
   fdecf:	mov    0x3040(%rbx),%rdx
   fded6:	mov    -0xaf0(%rbp),%r9
   fdedd:	je     fe550 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34f0>
   fdee3:	mov    %rdx,%rsi
   fdee6:	lea    -0x3d0(%rbp),%r8
   fdeed:	mov    %r10,%rcx
   fdef0:	mov    %r10,%rdx
   fdef3:	mov    %rbx,%rdi
   fdef6:	call   6d9f0 <synreal::SolverNewton::solve_newton_system(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, std::function<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)> const&, CUstream_st*)@plt>
   fdefb:	mov    0x17e8(%rbx),%r9d
   fdf02:	mov    -0xaf0(%rbp),%r12
   fdf09:	test   %r9d,%r9d
   fdf0c:	je     fdf35 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2ed5>
   fdf0e:	movss  0x28(%rbx),%xmm0
   fdf13:	movss  0x2c(%rbx),%xmm1
   fdf18:	mov    %r12,%rdx
   fdf1b:	lea    0x1728(%rbx),%rdi
   fdf22:	mov    0x3020(%rbx),%rsi
   fdf29:	call   6e370 <synreal::Fluid::limit_step(glm::vec<3, float, (glm::qualifier)0>*, float, float, CUstream_st*)@plt>
   fdf2e:	mov    -0xaf0(%rbp),%r12
   fdf35:	mov    0xfa054(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fdf3c:	mov    %r15,-0x898(%rbp)
   fdf43:	mov    %r12,%r9
   fdf46:	xor    %r8d,%r8d
   fdf49:	mov    0xfa040(%rip),%rdx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fdf50:	mov    -0x894(%rbp),%esi
   fdf56:	mov    $0x1,%ecx
   fdf5b:	movl   $0x1,-0x8a0(%rbp)
   fdf65:	mov    %rax,-0x8a8(%rbp)
   fdf6c:	mov    -0xae8(%rbp),%eax
   fdf72:	mov    %eax,-0x89c(%rbp)
   fdf78:	mov    -0x89c(%rbp),%rdi
   fdf7f:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fdf84:	test   %eax,%eax
   fdf86:	jne    fdfaf <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2f4f>
   fdf88:	mov    -0xb18(%rbp),%rax
   fdf8f:	mov    0x3020(%rbx),%rdx
   fdf96:	mov    -0xaa0(%rbp),%rcx
   fdf9d:	mov    (%rax),%rsi
   fdfa0:	mov    -0xaf8(%rbp),%rax
   fdfa7:	mov    (%rax),%rdi
   fdfaa:	call   6aa20 <synreal::kernel::apply_nonlinear_step(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long)@plt>
   fdfaf:	call   6c890 <cudaGetLastError@plt>
   fdfb4:	mov    %eax,%edi
   fdfb6:	lea    0xf7b0b(%rip),%rsi        # 1f5ac8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5bc8>
   fdfbd:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fdfc2:	cmpb   $0x0,-0xb45(%rbp)
   fdfc9:	mov    -0xaf0(%rbp),%r12
   fdfd0:	jne    fe7e0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3780>
   fdfd6:	cmpb   $0x0,-0xad8(%rbp)
   fdfdd:	jne    fe718 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x36b8>
   fdfe3:	mov    -0xb44(%rbp),%r8d
   fdfea:	test   %r8d,%r8d
   fdfed:	jne    fe638 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x35d8>
   fdff3:	addl   $0x1,-0xb00(%rbp)
   fdffa:	mov    -0xb00(%rbp),%eax
   fe000:	cmp    %eax,-0xb20(%rbp)
   fe006:	jle    fe4c0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3460>
   fe00c:	cmp    %eax,0x18(%rbx)
   fe00f:	sete   %r13b
   fe013:	cmpl   $0x3,-0xb30(%rbp)
   fe01a:	je     fe4cc <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x346c>
   fe020:	mov    -0xb00(%rbp),%eax
   fe026:	cltd   
   fe027:	idivl  0x14(%rbx)
   fe02a:	test   %edx,%edx
   fe02c:	jne    fe500 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34a0>
   fe032:	cmpl   $0x1,-0xb1c(%rbp)
   fe039:	je     fed40 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3ce0>
   fe03f:	mov    -0xaf8(%rbp),%rax
   fe046:	mov    (%rax),%rdi
   fe049:	mov    -0xb18(%rbp),%rax
   fe050:	mov    (%rax),%rsi
   fe053:	cmp    %rsi,%rdi
   fe056:	je     fc190 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1130>
   fe05c:	nopl   0x0(%rax)
   fe060:	mov    -0xaa0(%rbp),%rax
   fe067:	mov    %r12,%r8
   fe06a:	mov    $0x3,%ecx
   fe06f:	lea    (%rax,%rax,2),%rdx
   fe073:	shl    $0x2,%rdx
   fe077:	call   6e0b0 <cudaMemcpyAsync@plt>
   fe07c:	mov    %eax,%edi
   fe07e:	lea    0xf7b5b(%rip),%rsi        # 1f5be0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5ce0>
   fe085:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fe08a:	mov    -0xaf0(%rbp),%r12
   fe091:	mov    -0xb00(%rbp),%ecx
   fe097:	cmp    %ecx,-0xb20(%rbp)
   fe09d:	jne    fc190 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1130>
   fe0a3:	cmpb   $0x0,-0xad8(%rbp)
   fe0aa:	jne    101558 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x64f8>
   fe0b0:	cmpq   $0x0,0x3230(%rbx)
   fe0b8:	jne    102468 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7408>
   fe0be:	mov    -0xb20(%rbp),%edx
   fe0c4:	test   %edx,%edx
   fe0c6:	jne    fe112 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x30b2>
   fe0c8:	mov    -0xaf8(%rbp),%rax
   fe0cf:	mov    (%rax),%rsi
   fe0d2:	mov    -0xb18(%rbp),%rax
   fe0d9:	mov    (%rax),%rdi
   fe0dc:	cmp    %rsi,%rdi
   fe0df:	je     fe112 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x30b2>
   fe0e1:	mov    -0xaa0(%rbp),%rax
   fe0e8:	mov    %r12,%r8
   fe0eb:	mov    $0x3,%ecx
   fe0f0:	lea    (%rax,%rax,2),%rdx
   fe0f4:	shl    $0x2,%rdx
   fe0f8:	call   6e0b0 <cudaMemcpyAsync@plt>
   fe0fd:	mov    %eax,%edi
   fe0ff:	lea    0xf7b52(%rip),%rsi        # 1f5c58 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5d58>
   fe106:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fe10b:	mov    -0xaf0(%rbp),%r12
   fe112:	mov    0x2180(%rbx),%eax
   fe118:	test   %eax,%eax
   fe11a:	je     fe14b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x30eb>
   fe11c:	mov    -0xb18(%rbp),%rax
   fe123:	mov    0x3060(%rbx),%rdx
   fe12a:	mov    %r12,%rcx
   fe12d:	lea    0x2070(%rbx),%rdi
   fe134:	movss  -0xae4(%rbp),%xmm0
   fe13c:	mov    (%rax),%rsi
   fe13f:	call   6d2a0 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)@plt>
   fe144:	mov    -0xaf0(%rbp),%r12
   fe14b:	mov    0xf9e3e(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fe152:	mov    0xf9e37(%rip),%rdx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fe159:	mov    %r12,%r9
   fe15c:	xor    %r8d,%r8d
   fe15f:	movl   $0x1,-0x8a0(%rbp)
   fe169:	mov    $0x1,%ecx
   fe16e:	mov    %rax,-0x8a8(%rbp)
   fe175:	mov    -0xae8(%rbp),%eax
   fe17b:	mov    %eax,-0x89c(%rbp)
   fe181:	movabs $0x100000001,%rax
   fe18b:	mov    %rax,-0x898(%rbp)
   fe192:	mov    -0x89c(%rbp),%rdi
   fe199:	mov    -0x894(%rbp),%esi
   fe19f:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fe1a4:	test   %eax,%eax
   fe1a6:	jne    fe1d9 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3179>
   fe1a8:	mov    -0xb18(%rbp),%rax
   fe1af:	mov    0x3060(%rbx),%rdi
   fe1b6:	mov    -0xaa0(%rbp),%rcx
   fe1bd:	movss  0xf9dbb(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
   fe1c5:	divss  -0xae4(%rbp),%xmm0
   fe1cd:	mov    0x10(%rax),%rdx
   fe1d1:	mov    (%rax),%rsi
   fe1d4:	call   6aae0 <synreal::kernel::update_velocity(float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long)@plt>
   fe1d9:	call   6c890 <cudaGetLastError@plt>
   fe1de:	mov    %eax,%edi
   fe1e0:	lea    0xf9407(%rip),%rsi        # 1f75ee <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x76ee>
   fe1e7:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fe1ec:	cmpb   $0x0,-0xad3(%rbp)
   fe1f3:	jne    1015e0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6580>
   fe1f9:	mov    -0x3c0(%rbp),%rax
   fe200:	test   %rax,%rax
   fe203:	je     fe216 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x31b6>
   fe205:	lea    -0x3d0(%rbp),%rdi
   fe20c:	mov    $0x3,%edx
   fe211:	mov    %rdi,%rsi
   fe214:	call   *%rax
   fe216:	mov    -0x38(%rbp),%rax
   fe21a:	sub    %fs:0x28,%rax
   fe223:	jne    102923 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78c3>
   fe229:	lea    -0x28(%rbp),%rsp
   fe22d:	pop    %rbx
   fe22e:	pop    %r12
   fe230:	pop    %r13
   fe232:	pop    %r14
   fe234:	pop    %r15
   fe236:	pop    %rbp
   fe237:	ret    
   fe238:	nopl   0x0(%rax,%rax,1)
   fe240:	mov    %rsi,-0xaa0(%rbp)
   fe247:	test   %rsi,%rsi
   fe24a:	je     fe216 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x31b6>
   fe24c:	mov    %rsi,%rax
   fe24f:	movaps %xmm0,%xmm2
   fe252:	jmp    fb13b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xdb>
   fe257:	nopw   0x0(%rax,%rax,1)
   fe260:	cmpb   $0x0,0x4c(%rbx)
   fe264:	je     fb268 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x208>
   fe26a:	cmpb   $0x0,0x4d(%rbx)
   fe26e:	je     fb268 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x208>
   fe274:	test   %ecx,%ecx
   fe276:	je     fb268 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x208>
   fe27c:	jmp    76706 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x124>
   fe281:	nopl   0x0(%rax)
   fe288:	mov    (%r14),%rax
   fe28b:	movdqu 0x60(%r14),%xmm5
   fe291:	movb   $0x1,-0xad7(%rbp)
   fe298:	movdqu 0x50(%r14),%xmm1
   fe29e:	movdqu 0x70(%r14),%xmm0
   fe2a4:	mov    %rax,-0x3b0(%rbp)
   fe2ab:	mov    %esi,%eax
   fe2ad:	movdqu 0x80(%r14),%xmm4
   fe2b6:	movdqu 0x40(%r14),%xmm6
   fe2bc:	mov    %rax,-0x3a8(%rbp)
   fe2c3:	punpckhqdq %xmm5,%xmm1
   fe2c7:	movdqu 0x30(%r14),%xmm2
   fe2cd:	punpckhqdq %xmm4,%xmm0
   fe2d1:	mov    0x98(%r14),%rax
   fe2d8:	movaps %xmm1,-0x380(%rbp)
   fe2df:	movdqu 0x10(%r14),%xmm3
   fe2e5:	movdqu 0x20(%r14),%xmm7
   fe2eb:	movaps %xmm0,-0x370(%rbp)
   fe2f2:	mov    %rax,-0x360(%rbp)
   fe2f9:	mov    0x758(%rbx),%rax
   fe300:	punpckhqdq %xmm6,%xmm2
   fe304:	movdqu 0x738(%rbx),%xmm0
   fe30c:	movdqu 0x748(%rbx),%xmm6
   fe314:	punpckhqdq %xmm7,%xmm3
   fe318:	movaps %xmm2,-0x390(%rbp)
   fe31f:	mov    %rax,-0x338(%rbp)
   fe326:	movdqu 0x718(%rbx),%xmm1
   fe32e:	mov    0x768(%rbx),%rax
   fe335:	movdqu 0x728(%rbx),%xmm5
   fe33d:	punpcklqdq %xmm6,%xmm0
   fe341:	movaps %xmm3,-0x3a0(%rbp)
   fe348:	movups %xmm0,-0x348(%rbp)
   fe34f:	mov    %rax,-0x330(%rbp)
   fe356:	punpcklqdq %xmm5,%xmm1
   fe35a:	xor    %eax,%eax
   fe35c:	cmpq   $0x0,0x7a0(%rbx)
   fe364:	movups %xmm1,-0x358(%rbp)
   fe36b:	jne    101b30 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6ad0>
   fe371:	mov    %rax,-0x328(%rbp)
   fe378:	xor    %eax,%eax
   fe37a:	cmpq   $0x0,0x7b0(%rbx)
   fe382:	jne    101b20 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6ac0>
   fe388:	movd   -0xac8(%rbp),%xmm1
   fe390:	movd   0x710(%rbx),%xmm0
   fe398:	mov    %rax,-0x320(%rbp)
   fe39f:	movdqu 0x3c0(%rbx),%xmm4
   fe3a7:	mov    -0xa80(%rbp),%rax
   fe3ae:	punpcklqdq %xmm1,%xmm0
   fe3b2:	movdqu 0x3d0(%rbx),%xmm7
   fe3ba:	movdqu 0x3f0(%rbx),%xmm1
   fe3c2:	movups %xmm0,-0x318(%rbp)
   fe3c9:	movdqu 0x3e0(%rbx),%xmm0
   fe3d1:	mov    0xd0(%r14),%edi
   fe3d8:	mov    %rax,-0x308(%rbp)
   fe3df:	mov    -0xaf8(%rbp),%rax
   fe3e6:	punpcklqdq %xmm7,%xmm1
   fe3ea:	punpcklqdq %xmm4,%xmm0
   fe3ee:	movaps %xmm1,-0x300(%rbp)
   fe3f5:	movss  0x44(%rbx),%xmm1
   fe3fa:	movaps %xmm0,-0x2f0(%rbp)
   fe401:	movd   0x398(%rbx),%xmm0
   fe409:	mov    (%rax),%rax
   fe40c:	movhps -0xaa8(%rbp),%xmm0
   fe413:	mov    %rax,-0xb38(%rbp)
   fe41a:	movaps %xmm0,-0x2e0(%rbp)
   fe421:	movq   %rax,%xmm0
   fe426:	movhps 0x3060(%rbx),%xmm0
   fe42d:	movaps %xmm0,-0x2d0(%rbp)
   fe434:	movss  0xf9b44(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
   fe43c:	divss  -0xae4(%rbp),%xmm0
   fe444:	unpcklps %xmm1,%xmm0
   fe447:	movlps %xmm0,-0x2c0(%rbp)
   fe44e:	test   %edi,%edi
   fe450:	jne    fb7a1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x741>
   fe456:	xor    %r15d,%r15d
   fe459:	xor    %eax,%eax
   fe45b:	jmp    fb7c2 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x762>
   fe460:	test   %ecx,%ecx
   fe462:	je     fb2ff <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x29f>
   fe468:	cmpq   $0x0,0xc8(%r14)
   fe470:	je     76c6a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x688>
   fe476:	mov    %ecx,%edx
   fe478:	cmp    %rdx,0xe0(%r14)
   fe47f:	jae    fb2cb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x26b>
   fe485:	jmp    76c6a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x688>
   fe48a:	nopw   0x0(%rax,%rax,1)
   fe490:	cmpl   $0x2,-0xb30(%rbp)
   fe497:	sete   %dl
   fe49a:	and    %al,%dl
   fe49c:	mov    %dl,-0xb10(%rbp)
   fe4a2:	jne    102790 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7730>
   fe4a8:	movzbl -0xb58(%rbp),%edx
   fe4af:	mov    %dl,-0xb10(%rbp)
   fe4b5:	jmp    fc05b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xffb>
   fe4ba:	nopw   0x0(%rax,%rax,1)
   fe4c0:	cmpl   $0x3,-0xb30(%rbp)
   fe4c7:	jne    fe500 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34a0>
   fe4c9:	xor    %r13d,%r13d
   fe4cc:	movss  0xc(%rbx),%xmm0
   fe4d1:	pxor   %xmm6,%xmm6
   fe4d5:	comiss %xmm6,%xmm0
   fe4d8:	jbe    fe4ea <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x348a>
   fe4da:	mov    -0xa78(%rbp),%rdi
   fe4e1:	test   %rdi,%rdi
   fe4e4:	jne    100ad0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5a70>
   fe4ea:	mov    -0xb00(%rbp),%ecx
   fe4f0:	cmp    %ecx,-0xb20(%rbp)
   fe4f6:	jg     fe020 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2fc0>
   fe4fc:	nopl   0x0(%rax)
   fe500:	xor    %r13d,%r13d
   fe503:	cmpl   $0x1,-0xb1c(%rbp)
   fe50a:	je     fee40 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3de0>
   fe510:	mov    -0xaf8(%rbp),%rax
   fe517:	mov    (%rax),%rdi
   fe51a:	mov    -0xb18(%rbp),%rax
   fe521:	mov    (%rax),%rsi
   fe524:	cmp    %rdi,%rsi
   fe527:	jne    fe060 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3000>
   fe52d:	jmp    fe091 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3031>
   fe532:	nopw   0x0(%rax,%rax,1)
   fe538:	movq   $0x0,-0xb58(%rbp)
   fe543:	jmp    fd394 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2334>
   fe548:	nopl   0x0(%rax,%rax,1)
   fe550:	lea    -0x3d0(%rbp),%rax
   fe557:	push   %r9
   fe559:	mov    %r10,%r8
   fe55c:	mov    %r10,%rcx
   fe55f:	push   %rax
   fe560:	movzbl -0xb40(%rbp),%r9d
   fe568:	mov    %rbx,%rdi
   fe56b:	mov    -0xb98(%rbp),%rsi
   fe572:	call   6cbf0 <synreal::SolverNewton::solve_pd_newton_system(synreal::SparseMatrixELL const&, synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, bool, std::function<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)> const&, CUstream_st*)@plt>
   fe577:	pop    %r10
   fe579:	pop    %r11
   fe57b:	jmp    fdefb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2e9b>
   fe580:	cmpb   $0x0,-0xb10(%rbp)
   fe587:	jne    fcff0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1f90>
   fe58d:	mov    0xf99fc(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fe594:	mov    %r15,-0x898(%rbp)
   fe59b:	mov    %r12,%r9
   fe59e:	xor    %r8d,%r8d
   fe5a1:	mov    0xf99e8(%rip),%rdx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fe5a8:	mov    -0x894(%rbp),%esi
   fe5ae:	mov    $0x1,%ecx
   fe5b3:	movl   $0x1,-0x8a0(%rbp)
   fe5bd:	mov    %rax,-0x8a8(%rbp)
   fe5c4:	mov    -0xae8(%rbp),%eax
   fe5ca:	mov    %eax,-0x89c(%rbp)
   fe5d0:	mov    -0x89c(%rbp),%rdi
   fe5d7:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fe5dc:	test   %eax,%eax
   fe5de:	jne    fe61b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x35bb>
   fe5e0:	xor    %edx,%edx
   fe5e2:	cmpq   $0x0,0x100(%rbx)
   fe5ea:	mov    -0xaa8(%rbp),%r9
   fe5f1:	mov    -0xaa0(%rbp),%r8
   fe5f8:	mov    0x2f20(%rbx),%rcx
   fe5ff:	je     fe608 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x35a8>
   fe601:	mov    0xf8(%rbx),%rdx
   fe608:	mov    0xc0(%rbx),%rsi
   fe60f:	mov    0x2ee0(%rbx),%rdi
   fe616:	call   6aaf0 <synreal::kernel::prepare_inverse_preconditioner(float const*, float const*, int const*, float*, unsigned long, unsigned long)@plt>
   fe61b:	call   6c890 <cudaGetLastError@plt>
   fe620:	mov    %eax,%edi
   fe622:	lea    0xf746f(%rip),%rsi        # 1f5a98 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5b98>
   fe629:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fe62e:	jmp    fdec1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2e61>
   fe633:	nopl   0x0(%rax,%rax,1)
   fe638:	mov    -0xb80(%rbp),%r13
   fe63f:	mov    0xf994a(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fe646:	movl   $0x1,-0x8a0(%rbp)
   fe650:	mov    %r13,%rdi
   fe653:	mov    %rax,-0x8a8(%rbp)
   fe65a:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fe65f:	mov    %r15,-0x898(%rbp)
   fe666:	mov    -0x8a0(%rbp),%ecx
   fe66c:	mov    %r12,%r9
   fe66f:	xor    %r8d,%r8d
   fe672:	mov    %eax,-0x89c(%rbp)
   fe678:	mov    -0x8a8(%rbp),%rdx
   fe67f:	mov    -0x89c(%rbp),%rdi
   fe686:	mov    -0x894(%rbp),%esi
   fe68c:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fe691:	test   %eax,%eax
   fe693:	jne    fe6f6 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3696>
   fe695:	mov    0x4f0(%rbx),%eax
   fe69b:	sub    $0x8,%rsp
   fe69f:	mov    0x508(%rbx),%rcx
   fe6a6:	mov    0x4f8(%rbx),%rdx
   fe6ad:	mov    0x3d0(%rbx),%rsi
   fe6b4:	push   -0xaa8(%rbp)
   fe6ba:	push   %rax
   fe6bb:	mov    -0xb18(%rbp),%rax
   fe6c2:	push   %r13
   fe6c4:	push   0x3490(%rbx)
   fe6ca:	push   0x3470(%rbx)
   fe6d0:	mov    0x518(%rbx),%r8
   fe6d7:	push   0x558(%rbx)
   fe6dd:	mov    (%rax),%rdi
   fe6e0:	push   0x3450(%rbx)
   fe6e6:	mov    0x3430(%rbx),%r9
   fe6ed:	call   6ab80 <synreal::kernel::update_body_distance_constraint_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   fe6f2:	add    $0x40,%rsp
   fe6f6:	call   6c890 <cudaGetLastError@plt>
   fe6fb:	mov    %eax,%edi
   fe6fd:	lea    0xf7414(%rip),%rsi        # 1f5b18 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5c18>
   fe704:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fe709:	mov    -0xaf0(%rbp),%r12
   fe710:	jmp    fdff3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2f93>
   fe715:	nopl   (%rax)
   fe718:	lea    -0x170(%rbp),%r13
   fe71f:	mov    -0xba0(%rbp),%rsi
   fe726:	mov    $0x27,%ecx
   fe72b:	mov    -0xb18(%rbp),%rax
   fe732:	movl   $0x1,-0x8a0(%rbp)
   fe73c:	mov    %r13,%rdi
   fe73f:	rep movsq %ds:(%rsi),%es:(%rdi)
   fe742:	mov    (%rax),%rax
   fe745:	mov    0x10(%r14),%edi
   fe749:	mov    %rax,-0x98(%rbp)
   fe750:	mov    0xf9839(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fe757:	mov    %rax,-0x8a8(%rbp)
   fe75e:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fe763:	mov    %r15,-0x898(%rbp)
   fe76a:	mov    -0x8a0(%rbp),%ecx
   fe770:	mov    %r12,%r9
   fe773:	xor    %r8d,%r8d
   fe776:	mov    %eax,-0x89c(%rbp)
   fe77c:	mov    -0x8a8(%rbp),%rdx
   fe783:	mov    -0x89c(%rbp),%rdi
   fe78a:	mov    -0x894(%rbp),%esi
   fe790:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fe795:	test   %eax,%eax
   fe797:	jne    fe7ba <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x375a>
   fe799:	sub    $0x140,%rsp
   fe7a0:	mov    $0x27,%ecx
   fe7a5:	mov    %r13,%rsi
   fe7a8:	mov    %rsp,%rdi
   fe7ab:	rep movsq %ds:(%rsi),%es:(%rdi)
   fe7ae:	call   6ad10 <synreal::kernel::update_hard_contact_duals(synreal::kernel::HardContactView)@plt>
   fe7b3:	add    $0x140,%rsp
   fe7ba:	call   6c890 <cudaGetLastError@plt>
   fe7bf:	mov    %eax,%edi
   fe7c1:	lea    0xf7328(%rip),%rsi        # 1f5af0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5bf0>
   fe7c8:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fe7cd:	mov    -0xaf0(%rbp),%r12
   fe7d4:	jmp    fdfe3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2f83>
   fe7d9:	nopl   0x0(%rax)
   fe7e0:	mov    0xf97a9(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fe7e7:	mov    -0xa70(%rbp),%rdi
   fe7ee:	movl   $0x1,-0x8a0(%rbp)
   fe7f8:	mov    %rax,-0x8a8(%rbp)
   fe7ff:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fe804:	mov    %r15,-0x898(%rbp)
   fe80b:	mov    -0x8a0(%rbp),%ecx
   fe811:	mov    %r12,%r9
   fe814:	xor    %r8d,%r8d
   fe817:	mov    %eax,-0x89c(%rbp)
   fe81d:	mov    -0x8a8(%rbp),%rdx
   fe824:	mov    -0x89c(%rbp),%rdi
   fe82b:	mov    -0x894(%rbp),%esi
   fe831:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fe836:	test   %eax,%eax
   fe838:	jne    fe8d6 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3876>
   fe83e:	movss  0x60(%rbx),%xmm0
   fe843:	push   -0x648(%rbp)
   fe849:	push   -0x650(%rbp)
   fe84f:	push   -0x658(%rbp)
   fe855:	push   -0x660(%rbp)
   fe85b:	push   -0x668(%rbp)
   fe861:	push   -0x670(%rbp)
   fe867:	push   -0x678(%rbp)
   fe86d:	push   -0x680(%rbp)
   fe873:	push   -0x688(%rbp)
   fe879:	push   -0x690(%rbp)
   fe87f:	push   -0x698(%rbp)
   fe885:	push   -0x6a0(%rbp)
   fe88b:	push   -0x6a8(%rbp)
   fe891:	push   -0x6b0(%rbp)
   fe897:	push   -0x6b8(%rbp)
   fe89d:	push   -0x6c0(%rbp)
   fe8a3:	mov    -0xb18(%rbp),%rax
   fe8aa:	push   -0x6c8(%rbp)
   fe8b0:	push   -0x6d0(%rbp)
   fe8b6:	push   -0x6d8(%rbp)
   fe8bc:	push   -0x6e0(%rbp)
   fe8c2:	movss  0x64(%rbx),%xmm1
   fe8c7:	mov    (%rax),%rdi
   fe8ca:	call   6a8b0 <synreal::kernel::update_cable_penalties(synreal::kernel::CableView, glm::vec<3, float, (glm::qualifier)0> const*, float, float)@plt>
   fe8cf:	add    $0xa0,%rsp
   fe8d6:	call   6c890 <cudaGetLastError@plt>
   fe8db:	mov    %eax,%edi
   fe8dd:	lea    0xf8cec(%rip),%rsi        # 1f75d0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x76d0>
   fe8e4:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fe8e9:	mov    -0xaf0(%rbp),%r12
   fe8f0:	jmp    fdfd6 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2f76>
   fe8f5:	nopl   (%rax)
   fe8f8:	mov    0xf9691(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fe8ff:	mov    -0xa60(%rbp),%rdi
   fe906:	movl   $0x1,-0x8a0(%rbp)
   fe910:	mov    %rax,-0x8a8(%rbp)
   fe917:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fe91c:	mov    %r15,-0x898(%rbp)
   fe923:	mov    -0x8a0(%rbp),%ecx
   fe929:	mov    %r12,%r9
   fe92c:	xor    %r8d,%r8d
   fe92f:	mov    %eax,-0x89c(%rbp)
   fe935:	mov    -0x8a8(%rbp),%rdx
   fe93c:	mov    -0x89c(%rbp),%rdi
   fe943:	mov    -0x894(%rbp),%esi
   fe949:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fe94e:	test   %eax,%eax
   fe950:	jne    fe9b1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3951>
   fe952:	mov    0x318(%rbx),%eax
   fe958:	mov    0x350(%rbx),%rcx
   fe95f:	mov    0x340(%rbx),%rdx
   fe966:	mov    0x3060(%rbx),%rsi
   fe96d:	push   -0xaa8(%rbp)
   fe973:	mov    0x330(%rbx),%r9
   fe97a:	push   %rax
   fe97b:	mov    -0xaf8(%rbp),%rax
   fe982:	push   -0xa60(%rbp)
   fe988:	mov    0x320(%rbx),%r8
   fe98f:	push   0x3040(%rbx)
   fe995:	mov    (%rax),%rdi
   fe998:	movss  0xf95e0(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
   fe9a0:	divss  -0xae4(%rbp),%xmm0
   fe9a8:	call   6a830 <synreal::kernel::evaluate_bending_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   fe9ad:	add    $0x20,%rsp
   fe9b1:	call   6c890 <cudaGetLastError@plt>
   fe9b6:	mov    %eax,%edi
   fe9b8:	lea    0xf6c31(%rip),%rsi        # 1f55f0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x56f0>
   fe9bf:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fe9c4:	mov    -0xaf0(%rbp),%r12
   fe9cb:	jmp    fcf39 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ed9>
   fe9d0:	mov    0xf95b9(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fe9d7:	mov    -0xa98(%rbp),%rdi
   fe9de:	movl   $0x1,-0x8a0(%rbp)
   fe9e8:	mov    %rax,-0x8a8(%rbp)
   fe9ef:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fe9f4:	mov    %r15,-0x898(%rbp)
   fe9fb:	mov    -0x8a0(%rbp),%ecx
   fea01:	mov    %r12,%r9
   fea04:	xor    %r8d,%r8d
   fea07:	mov    %eax,-0x89c(%rbp)
   fea0d:	mov    -0x8a8(%rbp),%rdx
   fea14:	mov    -0x89c(%rbp),%rdi
   fea1b:	mov    -0x894(%rbp),%esi
   fea21:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fea26:	test   %eax,%eax
   fea28:	jne    feab0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3a50>
   fea2e:	mov    -0xb88(%rbp),%rcx
   fea35:	xor    %eax,%eax
   fea37:	movss  0xf9541(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
   fea3f:	divss  -0xae4(%rbp),%xmm0
   fea47:	mov    -0xaa8(%rbp),%r10
   fea4e:	mov    0x2e0(%rbx),%r9d
   fea55:	cmpq   $0x0,0x48(%rcx)
   fea5a:	mov    -0xa98(%rbp),%r8
   fea61:	mov    0x3040(%rbx),%rdi
   fea68:	je     fea6e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3a0e>
   fea6a:	mov    0x40(%rcx),%rax
   fea6e:	sub    $0x8,%rsp
   fea72:	mov    0x2f8(%rbx),%rcx
   fea79:	mov    0x2e8(%rbx),%rdx
   fea80:	mov    0x3060(%rbx),%rsi
   fea87:	push   %r10
   fea89:	push   %r9
   fea8b:	push   %r8
   fea8d:	push   %rdi
   fea8e:	mov    0x308(%rbx),%r8
   fea95:	push   %rax
   fea96:	mov    -0xaf8(%rbp),%rax
   fea9d:	mov    0x3390(%rbx),%r9
   feaa4:	mov    (%rax),%rdi
   feaa7:	call   6ae60 <synreal::kernel::evaluate_tetrahedron_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   feaac:	add    $0x30,%rsp
   feab0:	call   6c890 <cudaGetLastError@plt>
   feab5:	mov    %eax,%edi
   feab7:	lea    0xf6b02(%rip),%rsi        # 1f55c0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x56c0>
   feabe:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   feac3:	mov    -0xaf0(%rbp),%r12
   feaca:	jmp    fcf2b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ecb>
   feacf:	nop
   fead0:	imul   -0xa80(%rbp),%r13
   fead8:	mov    0xf94b1(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   feadf:	movl   $0x1,-0x8a0(%rbp)
   feae9:	mov    %rax,-0x8a8(%rbp)
   feaf0:	mov    %r13,%rdi
   feaf3:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   feaf8:	mov    %r15,-0x898(%rbp)
   feaff:	mov    -0x8a0(%rbp),%ecx
   feb05:	mov    %r12,%r9
   feb08:	xor    %r8d,%r8d
   feb0b:	mov    %eax,-0x89c(%rbp)
   feb11:	mov    -0x8a8(%rbp),%rdx
   feb18:	mov    -0x89c(%rbp),%rdi
   feb1f:	mov    -0x894(%rbp),%esi
   feb25:	call   6efb0 <__cudaPushCallConfiguration@plt>
   feb2a:	test   %eax,%eax
   feb2c:	jne    feb77 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3b17>
   feb2e:	mov    0x278(%rbx),%eax
   feb34:	sub    $0x8,%rsp
   feb38:	mov    0x280(%rbx),%rcx
   feb3f:	mov    0x2a0(%rbx),%rdx
   feb46:	mov    0x290(%rbx),%rsi
   feb4d:	push   -0xaa8(%rbp)
   feb53:	mov    0x3040(%rbx),%r9
   feb5a:	push   %rax
   feb5b:	mov    -0xaf8(%rbp),%rax
   feb62:	mov    0x2c0(%rbx),%r8
   feb69:	push   %r13
   feb6b:	mov    (%rax),%rdi
   feb6e:	call   6af30 <synreal::kernel::evaluate_stretch_force(glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::mat<2, 2, float, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   feb73:	add    $0x20,%rsp
   feb77:	call   6c890 <cudaGetLastError@plt>
   feb7c:	mov    %eax,%edi
   feb7e:	lea    0xf6a13(%rip),%rsi        # 1f5598 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5698>
   feb85:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   feb8a:	mov    -0xaf0(%rbp),%r12
   feb91:	jmp    fcf1e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ebe>
   feb96:	cs nopw 0x0(%rax,%rax,1)
   feba0:	imul   -0xa80(%rbp),%r13
   feba8:	mov    0xf93e1(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   febaf:	movl   $0x1,-0x8a0(%rbp)
   febb9:	mov    %rax,-0x8a8(%rbp)
   febc0:	mov    %r13,%rdi
   febc3:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   febc8:	mov    %r15,-0x898(%rbp)
   febcf:	mov    -0x8a0(%rbp),%ecx
   febd5:	mov    %r12,%r9
   febd8:	xor    %r8d,%r8d
   febdb:	mov    %eax,-0x89c(%rbp)
   febe1:	mov    -0x8a8(%rbp),%rdx
   febe8:	mov    -0x89c(%rbp),%rdi
   febef:	mov    -0x894(%rbp),%esi
   febf5:	call   6efb0 <__cudaPushCallConfiguration@plt>
   febfa:	test   %eax,%eax
   febfc:	jne    fec3b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3bdb>
   febfe:	mov    0x240(%rbx),%eax
   fec04:	mov    0x268(%rbx),%rcx
   fec0b:	mov    %r13,%r9
   fec0e:	mov    0x258(%rbx),%rdx
   fec15:	mov    0x248(%rbx),%rsi
   fec1c:	push   -0xaa8(%rbp)
   fec22:	mov    0x3040(%rbx),%r8
   fec29:	push   %rax
   fec2a:	mov    -0xaf8(%rbp),%rax
   fec31:	mov    (%rax),%rdi
   fec34:	call   6abf0 <synreal::kernel::evaluate_spring_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, float const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   fec39:	pop    %rcx
   fec3a:	pop    %rsi
   fec3b:	call   6c890 <cudaGetLastError@plt>
   fec40:	mov    %eax,%edi
   fec42:	lea    0xf6927(%rip),%rsi        # 1f5570 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5670>
   fec49:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fec4e:	mov    -0xaf0(%rbp),%r12
   fec55:	jmp    fcf0e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1eae>
   fec5a:	nopw   0x0(%rax,%rax,1)
   fec60:	mov    -0xaf8(%rbp),%rax
   fec67:	mov    0x3040(%rbx),%rcx
   fec6e:	lea    0x1728(%rbx),%rdi
   fec75:	mov    0x3060(%rbx),%rdx
   fec7c:	mov    -0xaf0(%rbp),%r8
   fec83:	movss  -0xae4(%rbp),%xmm0
   fec8b:	mov    (%rax),%rsi
   fec8e:	call   6ebf0 <synreal::Fluid::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)@plt>
   fec93:	mov    0x2180(%rbx),%eax
   fec99:	test   %eax,%eax
   fec9b:	je     fc3ed <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x138d>
   feca1:	mov    -0xaf8(%rbp),%rax
   feca8:	mov    0x3040(%rbx),%rcx
   fecaf:	lea    0x2070(%rbx),%rdi
   fecb6:	mov    0x3060(%rbx),%rdx
   fecbd:	mov    -0xaf0(%rbp),%r8
   fecc4:	movss  -0xae4(%rbp),%xmm0
   feccc:	mov    (%rax),%rsi
   feccf:	call   6d720 <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)@plt>
   fecd4:	jmp    fc3ed <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x138d>
   fecd9:	nopl   0x0(%rax)
   fece0:	mov    -0xaf8(%rbp),%rax
   fece7:	movss  0x74(%rbx),%xmm0
   fecec:	mov    %r12,%r9
   fecef:	lea    0x8f0(%rbx),%rdi
   fecf6:	mov    0x3040(%rbx),%rcx
   fecfd:	mov    0x2f00(%rbx),%rdx
   fed04:	movzbl 0x41(%rbx),%r8d
   fed09:	movss  0x84(%rbx),%xmm4
   fed11:	movss  0x80(%rbx),%xmm3
   fed19:	movss  0x7c(%rbx),%xmm2
   fed1e:	movss  0x78(%rbx),%xmm1
   fed23:	mov    (%rax),%rsi
   fed26:	call   6b500 <synreal::SelfCollision::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, float, float, float, float, glm::vec<3, float, (glm::qualifier)0>*, bool, CUstream_st*)@plt>
   fed2b:	mov    -0xaf0(%rbp),%r12
   fed32:	jmp    fceb4 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1e54>
   fed37:	nopw   0x0(%rax,%rax,1)
   fed40:	movss  0xc(%rbx),%xmm0
   fed45:	pxor   %xmm6,%xmm6
   fed49:	mov    $0x1,%r13d
   fed4f:	comiss %xmm6,%xmm0
   fed52:	jbe    fee45 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3de5>
   fed58:	cmpq   $0x0,-0xba8(%rbp)
   fed60:	je     fee52 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3df2>
   fed66:	mov    -0xba8(%rbp),%r13
   fed6d:	mov    0xf921c(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fed74:	movl   $0x1,-0x8a0(%rbp)
   fed7e:	mov    %r13,%rdi
   fed81:	mov    %rax,-0x8a8(%rbp)
   fed88:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fed8d:	mov    %r15,-0x898(%rbp)
   fed94:	mov    -0x8a0(%rbp),%ecx
   fed9a:	mov    %r12,%r9
   fed9d:	xor    %r8d,%r8d
   feda0:	mov    %eax,-0x89c(%rbp)
   feda6:	mov    -0x8a8(%rbp),%rdx
   fedad:	mov    -0x89c(%rbp),%rdi
   fedb4:	mov    -0x894(%rbp),%esi
   fedba:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fedbf:	test   %eax,%eax
   fedc1:	jne    fee1b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3dbb>
   fedc3:	mov    0x49c(%rbx),%eax
   fedc9:	mov    0x4b0(%rbx),%rcx
   fedd0:	mov    0x4a0(%rbx),%rdx
   fedd7:	mov    0x3d0(%rbx),%rsi
   fedde:	push   -0xaa8(%rbp)
   fede4:	push   %rax
   fede5:	mov    0x498(%rbx),%eax
   fedeb:	push   %rax
   fedec:	mov    -0xb18(%rbp),%rax
   fedf3:	push   %r13
   fedf5:	push   0x3410(%rbx)
   fedfb:	mov    0x4c0(%rbx),%r8
   fee02:	mov    (%rax),%rdi
   fee05:	push   0x33f0(%rbx)
   fee0b:	mov    0x33d0(%rbx),%r9
   fee12:	call   6aab0 <synreal::kernel::update_joint_body_spring_augmented_lagrangian_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
   fee17:	add    $0x30,%rsp
   fee1b:	call   6c890 <cudaGetLastError@plt>
   fee20:	mov    %eax,%edi
   fee22:	lea    0xf6d57(%rip),%rsi        # 1f5b80 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5c80>
   fee29:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fee2e:	mov    -0xaf0(%rbp),%r12
   fee35:	mov    $0x1,%r13d
   fee3b:	nopl   0x0(%rax,%rax,1)
   fee40:	movss  0xc(%rbx),%xmm0
   fee45:	pxor   %xmm5,%xmm5
   fee49:	comiss %xmm5,%xmm0
   fee4c:	jbe    fe510 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34b0>
   fee52:	mov    -0xa68(%rbp),%rdi
   fee59:	test   %rdi,%rdi
   fee5c:	je     fe510 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34b0>
   fee62:	mov    0xf9127(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fee69:	movl   $0x1,-0x8a0(%rbp)
   fee73:	mov    %rax,-0x8a8(%rbp)
   fee7a:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fee7f:	mov    %r15,-0x898(%rbp)
   fee86:	mov    -0x8a0(%rbp),%ecx
   fee8c:	mov    %r12,%r9
   fee8f:	xor    %r8d,%r8d
   fee92:	mov    %eax,-0x89c(%rbp)
   fee98:	mov    -0x8a8(%rbp),%rdx
   fee9f:	mov    -0x89c(%rbp),%rdi
   feea6:	mov    -0x894(%rbp),%esi
   feeac:	call   6efb0 <__cudaPushCallConfiguration@plt>
   feeb1:	test   %eax,%eax
   feeb3:	jne    fef25 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3ec5>
   feeb5:	mov    0x56c(%rbx),%eax
   feebb:	mov    0x34b0(%rbx),%rcx
   feec2:	mov    0x570(%rbx),%rdx
   feec9:	mov    0x3d0(%rbx),%rsi
   feed0:	push   -0xaa8(%rbp)
   feed6:	mov    0x34f0(%rbx),%r9
   feedd:	push   %rax
   feede:	mov    0x568(%rbx),%eax
   feee4:	mov    0x34d0(%rbx),%r8
   feeeb:	push   %rax
   feeec:	mov    -0xb18(%rbp),%rax
   feef3:	push   -0xa68(%rbp)
   feef9:	push   %r13
   feefb:	push   0x3530(%rbx)
   fef01:	push   0x3550(%rbx)
   fef07:	push   0x3510(%rbx)
   fef0d:	push   0x5a0(%rbx)
   fef13:	push   0x590(%rbx)
   fef19:	mov    (%rax),%rdi
   fef1c:	call   6ae70 <synreal::kernel::update_joint_body_point_line_augmented_lagrangian_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, bool, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
   fef21:	add    $0x50,%rsp
   fef25:	call   6c890 <cudaGetLastError@plt>
   fef2a:	mov    %eax,%edi
   fef2c:	lea    0xf6c7d(%rip),%rsi        # 1f5bb0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5cb0>
   fef33:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fef38:	mov    -0xaf0(%rbp),%r12
   fef3f:	jmp    fe510 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34b0>
   fef44:	nopl   0x0(%rax)
   fef48:	mov    0x398(%rbx),%eax
   fef4e:	test   %eax,%eax
   fef50:	je     fd2d8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2278>
   fef56:	cmpl   $0x2,-0xb30(%rbp)
   fef5d:	jne    fd2d8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2278>
   fef63:	movss  0xc(%rbx),%xmm0
   fef68:	pxor   %xmm6,%xmm6
   fef6c:	comiss %xmm6,%xmm0
   fef6f:	jbe    fd2d8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2278>
   fef75:	mov    0xf9014(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fef7c:	mov    -0xa78(%rbp),%rdi
   fef83:	movl   $0x1,-0x8a0(%rbp)
   fef8d:	mov    %rax,-0x8a8(%rbp)
   fef94:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fef99:	mov    %r15,-0x898(%rbp)
   fefa0:	mov    -0x8a0(%rbp),%ecx
   fefa6:	mov    %r12,%r9
   fefa9:	xor    %r8d,%r8d
   fefac:	mov    %eax,-0x89c(%rbp)
   fefb2:	mov    -0x8a8(%rbp),%rdx
   fefb9:	mov    -0x89c(%rbp),%rdi
   fefc0:	mov    -0x894(%rbp),%esi
   fefc6:	call   6efb0 <__cudaPushCallConfiguration@plt>
   fefcb:	test   %eax,%eax
   fefcd:	jne    ff035 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3fd5>
   fefcf:	mov    0x398(%rbx),%eax
   fefd5:	movss  0xc(%rbx),%xmm0
   fefda:	sub    $0x8,%rsp
   fefde:	mulss  -0xacc(%rbp),%xmm0
   fefe6:	mov    0x3a0(%rbx),%rdx
   fefed:	mov    0x3d0(%rbx),%rsi
   feff4:	push   -0xaa0(%rbp)
   feffa:	mov    -0xb70(%rbp),%r9
   ff001:	push   -0xaa8(%rbp)
   ff007:	mov    -0xb90(%rbp),%r8
   ff00e:	push   %rax
   ff00f:	mov    -0xaf8(%rbp),%rax
   ff016:	push   -0xa78(%rbp)
   ff01c:	mov    -0xb58(%rbp),%rcx
   ff023:	push   -0xb60(%rbp)
   ff029:	mov    (%rax),%rdi
   ff02c:	call   6af00 <synreal::kernel::add_affine_body_spring_gauss_newton_hessian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
   ff031:	add    $0x30,%rsp
   ff035:	call   6c890 <cudaGetLastError@plt>
   ff03a:	mov    %eax,%edi
   ff03c:	lea    0xf667d(%rip),%rsi        # 1f56c0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x57c0>
   ff043:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ff048:	cmpb   $0x0,-0xbc8(%rbp)
   ff04f:	je     fd177 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2117>
   ff055:	mov    -0xaf0(%rbp),%r12
   ff05c:	jmp    fd087 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2027>
   ff061:	nopl   0x0(%rax)
   ff068:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   ff06d:	mov    %r15,-0x8b0(%rbp)
   ff074:	mov    -0x8f0(%rbp),%ecx
   ff07a:	mov    %r12,%r9
   ff07d:	xor    %r8d,%r8d
   ff080:	mov    %eax,-0x8b4(%rbp)
   ff086:	mov    -0x8f8(%rbp),%rdx
   ff08d:	mov    -0x8b4(%rbp),%rdi
   ff094:	mov    -0x8ac(%rbp),%esi
   ff09a:	call   6efb0 <__cudaPushCallConfiguration@plt>
   ff09f:	mov    %eax,%r8d
   ff0a2:	lea    -0x9b0(%rbp),%rax
   ff0a9:	lea    -0x958(%rbp),%rdx
   ff0b0:	movq   %rax,%xmm9
   ff0b5:	lea    -0x9a8(%rbp),%rax
   ff0bc:	movq   %rax,%xmm7
   ff0c1:	lea    -0x9a0(%rbp),%rax
   ff0c8:	movq   %rax,%xmm8
   ff0cd:	lea    -0x998(%rbp),%rax
   ff0d4:	punpcklqdq %xmm7,%xmm9
   ff0d9:	movq   %rax,%xmm6
   ff0de:	lea    -0x990(%rbp),%rax
   ff0e5:	movq   %rax,%xmm7
   ff0ea:	lea    -0x988(%rbp),%rax
   ff0f1:	punpcklqdq %xmm6,%xmm8
   ff0f6:	movq   %rax,%xmm5
   ff0fb:	lea    -0x980(%rbp),%rax
   ff102:	movq   %rax,%xmm6
   ff107:	lea    -0x978(%rbp),%rax
   ff10e:	punpcklqdq %xmm5,%xmm7
   ff112:	movq   %rax,%xmm4
   ff117:	lea    -0xab0(%rbp),%rax
   ff11e:	movq   %rax,%xmm5
   ff123:	lea    -0x5a0(%rbp),%rax
   ff12a:	punpcklqdq %xmm4,%xmm6
   ff12e:	movq   %rax,%xmm4
   ff133:	lea    -0x970(%rbp),%rax
   ff13a:	punpcklqdq %xmm4,%xmm5
   ff13e:	movq   %rax,%xmm4
   ff143:	lea    -0x968(%rbp),%rax
   ff14a:	movq   %rax,%xmm3
   ff14f:	lea    -0xaac(%rbp),%rax
   ff156:	punpcklqdq %xmm3,%xmm4
   ff15a:	movq   %rax,%xmm3
   ff15f:	lea    -0x960(%rbp),%rax
   ff166:	movq   %rax,%xmm2
   ff16b:	lea    -0x950(%rbp),%rax
   ff172:	movq   %rax,%xmm1
   ff177:	punpcklqdq %xmm2,%xmm3
   ff17b:	lea    -0x940(%rbp),%rax
   ff182:	movq   %rdx,%xmm2
   ff187:	lea    -0x948(%rbp),%rdx
   ff18e:	movq   %rax,%xmm0
   ff193:	punpcklqdq %xmm1,%xmm2
   ff197:	lea    -0x938(%rbp),%rax
   ff19e:	movq   %rdx,%xmm1
   ff1a3:	lea    -0x930(%rbp),%rdx
   ff1aa:	punpcklqdq %xmm0,%xmm1
   ff1ae:	movq   %rax,%xmm0
   ff1b3:	movq   %rdx,%xmm15
   ff1b8:	punpcklqdq %xmm15,%xmm0
   ff1bd:	test   %r8d,%r8d
   ff1c0:	jne    fdd6c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2d0c>
   ff1c6:	mov    -0xaa8(%rbp),%rax
   ff1cd:	cmpb   $0x0,-0xacf(%rbp)
   ff1d4:	pxor   %xmm10,%xmm10
   ff1d9:	movss  0xf8d9e(%rip),%xmm12        # 1f7f80 <cuda::std::__4::in_place+0x33>
   ff1e2:	movd   0x398(%rbx),%xmm11
   ff1eb:	divss  -0xae4(%rbp),%xmm12
   ff1f4:	mov    %rax,-0xb70(%rbp)
   ff1fb:	mov    -0xa78(%rbp),%rax
   ff202:	mov    0x2f80(%rbx),%rsi
   ff209:	mov    0x2fc0(%rbx),%rdi
   ff210:	mov    %rax,-0xb60(%rbp)
   ff217:	mov    0x2fa0(%rbx),%rax
   ff21e:	mov    0x3000(%rbx),%r8
   ff225:	mov    0x2fe0(%rbx),%r9
   ff22c:	mov    %rax,-0xb90(%rbp)
   ff233:	je     ff244 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x41e4>
   ff235:	movss  0xc(%rbx),%xmm10
   ff23b:	mulss  -0xacc(%rbp),%xmm10
   ff244:	mov    -0xb98(%rbp),%rdx
   ff24b:	mov    0x3350(%rbx),%r10
   ff252:	mov    0x28(%rdx),%rax
   ff256:	mov    0x20(%rdx),%r11
   ff25a:	mov    0x10(%rdx),%r12
   ff25e:	mov    (%rdx),%r13
   ff261:	mov    0x2f60(%rbx),%rdx
   ff268:	test   %rax,%rax
   ff26b:	cmove  -0xaa0(%rbp),%rax
   ff273:	mov    %rdx,-0xbe0(%rbp)
   ff27a:	xor    %edx,%edx
   ff27c:	cmpq   $0x0,0x100(%rbx)
   ff284:	je     ff28d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x422d>
   ff286:	mov    0xf8(%rbx),%rdx
   ff28d:	movdqa -0x6e0(%rbp),%xmm13
   ff296:	mov    0x3d0(%rbx),%rcx
   ff29d:	mov    %rdx,-0x9a8(%rbp)
   ff2a4:	movdqa -0x690(%rbp),%xmm14
   ff2ad:	mov    -0xbe0(%rbp),%rdx
   ff2b4:	mov    %r13,-0x998(%rbp)
   ff2bb:	movdqa -0x680(%rbp),%xmm15
   ff2c4:	movaps %xmm13,-0x5a0(%rbp)
   ff2cc:	movdqa -0x6d0(%rbp),%xmm13
   ff2d5:	mov    %rcx,-0x9c0(%rbp)
   ff2dc:	mov    0x3a0(%rbx),%rcx
   ff2e3:	movaps %xmm13,-0x590(%rbp)
   ff2eb:	movdqa -0x6c0(%rbp),%xmm13
   ff2f4:	mov    %rcx,-0x9b8(%rbp)
   ff2fb:	mov    0xc0(%rbx),%rcx
   ff302:	movaps %xmm13,-0x580(%rbp)
   ff30a:	movdqa -0x6b0(%rbp),%xmm13
   ff313:	movaps %xmm14,-0x550(%rbp)
   ff31b:	movdqa -0x660(%rbp),%xmm14
   ff324:	movaps %xmm13,-0x570(%rbp)
   ff32c:	movdqa -0x6a0(%rbp),%xmm13
   ff335:	movaps %xmm15,-0x540(%rbp)
   ff33d:	movdqa -0x650(%rbp),%xmm15
   ff346:	movaps %xmm13,-0x560(%rbp)
   ff34e:	movdqa -0x670(%rbp),%xmm13
   ff357:	mov    %rcx,-0x9b0(%rbp)
   ff35e:	lea    -0x920(%rbp),%rcx
   ff365:	mov    %rdx,-0x9a0(%rbp)
   ff36c:	lea    -0x928(%rbp),%rdx
   ff373:	mov    %r12,-0x990(%rbp)
   ff37a:	mov    %r11,-0x988(%rbp)
   ff381:	movaps %xmm13,-0x530(%rbp)
   ff389:	movaps %xmm14,-0x520(%rbp)
   ff391:	movaps %xmm15,-0x510(%rbp)
   ff399:	mov    %rax,-0x980(%rbp)
   ff3a0:	mov    -0xb58(%rbp),%rax
   ff3a7:	movq   %xmm11,-0x938(%rbp)
   ff3b0:	movdqa -0xbf0(%rbp),%xmm11
   ff3b9:	mov    %rax,-0x958(%rbp)
   ff3c0:	mov    -0xb90(%rbp),%rax
   ff3c7:	mov    %rdi,-0x960(%rbp)
   ff3ce:	lea    -0x8e8(%rbp),%rdi
   ff3d5:	mov    %rax,-0x948(%rbp)
   ff3dc:	mov    -0xb60(%rbp),%rax
   ff3e3:	mov    %rsi,-0x950(%rbp)
   ff3ea:	lea    -0x8c0(%rbp),%rsi
   ff3f1:	mov    %rax,-0x940(%rbp)
   ff3f8:	mov    -0xb70(%rbp),%rax
   ff3ff:	mov    %r10,-0x978(%rbp)
   ff406:	mov    %rax,-0x930(%rbp)
   ff40d:	mov    0xf8b5c(%rip),%rax        # 1f7f70 <cuda::std::__4::in_place+0x23>
   ff414:	mov    %r9,-0x970(%rbp)
   ff41b:	mov    %r8,-0x968(%rbp)
   ff422:	mov    %rax,-0x8e8(%rbp)
   ff429:	movl   $0x1,-0x8e0(%rbp)
   ff433:	mov    %rax,-0x8c0(%rbp)
   ff43a:	movss  %xmm10,-0xab0(%rbp)
   ff443:	movss  %xmm12,-0xaac(%rbp)
   ff44c:	movaps %xmm11,-0x170(%rbp)
   ff454:	movaps %xmm9,-0x160(%rbp)
   ff45c:	movaps %xmm8,-0x150(%rbp)
   ff464:	movaps %xmm7,-0x140(%rbp)
   ff46b:	movaps %xmm6,-0x130(%rbp)
   ff472:	movaps %xmm5,-0x120(%rbp)
   ff479:	movaps %xmm4,-0x110(%rbp)
   ff480:	movaps %xmm3,-0x100(%rbp)
   ff487:	movaps %xmm2,-0xf0(%rbp)
   ff48e:	movaps %xmm1,-0xe0(%rbp)
   ff495:	movaps %xmm0,-0xd0(%rbp)
   ff49c:	movl   $0x1,-0x8b8(%rbp)
   ff4a6:	call   6eb40 <__cudaPopCallConfiguration@plt>
   ff4ab:	test   %eax,%eax
   ff4ad:	jne    fdd6c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2d0c>
   ff4b3:	push   -0x920(%rbp)
   ff4b9:	mov    -0x8e8(%rbp),%rsi
   ff4c0:	lea    -0x170(%rbp),%r9
   ff4c7:	mov    -0x8e0(%rbp),%edx
   ff4cd:	push   -0x928(%rbp)
   ff4d3:	mov    -0x8c0(%rbp),%rcx
   ff4da:	mov    %rsi,-0x89c(%rbp)
   ff4e1:	mov    -0x8b8(%rbp),%r8d
   ff4e8:	mov    0x5b8099(%rip),%rdi        # 6b7588 <void synreal::kernel::build_affine_body_preconditioner<synreal::NonZeroEntry>(glm::vec<4, int, (glm::qualifier)0> const*, float const*, float const*, int const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, int const*, synreal::NonZeroEntry const*, unsigned long, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, synreal::kernel::CableView, unsigned long const*, int const*, float, int const*, float const*, float*, int*, unsigned long, unsigned long, unsigned long)@@Base+0x5a7b58>
   ff4ef:	mov    %edx,-0x894(%rbp)
   ff4f5:	mov    %rcx,-0x8a8(%rbp)
   ff4fc:	mov    %r8d,-0x8a0(%rbp)
   ff503:	call   6b4f0 <cudaLaunchKernel@plt>
   ff508:	jmp    fdd6a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2d0a>
   ff50d:	nopl   (%rax)
   ff510:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   ff515:	mov    %r15,-0x898(%rbp)
   ff51c:	mov    -0x8a0(%rbp),%ecx
   ff522:	mov    %r12,%r9
   ff525:	xor    %r8d,%r8d
   ff528:	mov    %eax,-0x89c(%rbp)
   ff52e:	mov    -0x8a8(%rbp),%rdx
   ff535:	mov    -0x89c(%rbp),%rdi
   ff53c:	mov    -0x894(%rbp),%esi
   ff542:	call   6efb0 <__cudaPushCallConfiguration@plt>
   ff547:	test   %eax,%eax
   ff549:	je     1008c0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5860>
   ff54f:	call   6c890 <cudaGetLastError@plt>
   ff554:	mov    %eax,%edi
   ff556:	lea    0xf5c93(%rip),%rsi        # 1f51f0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x52f0>
   ff55d:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ff562:	jmp    fc5a7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1547>
   ff567:	nopw   0x0(%rax,%rax,1)
   ff570:	mov    0xf8a19(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   ff577:	mov    0x10(%r14),%edi
   ff57b:	movl   $0x1,-0x8a0(%rbp)
   ff585:	mov    %rax,-0x8a8(%rbp)
   ff58c:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   ff591:	mov    %r15,-0x898(%rbp)
   ff598:	mov    -0x8a0(%rbp),%ecx
   ff59e:	mov    %r12,%r9
   ff5a1:	xor    %r8d,%r8d
   ff5a4:	mov    %eax,-0x89c(%rbp)
   ff5aa:	mov    -0x8a8(%rbp),%rdx
   ff5b1:	mov    -0x89c(%rbp),%rdi
   ff5b8:	mov    -0x894(%rbp),%esi
   ff5be:	call   6efb0 <__cudaPushCallConfiguration@plt>
   ff5c3:	test   %eax,%eax
   ff5c5:	jne    ff69c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x463c>
   ff5cb:	sub    $0x8,%rsp
   ff5cf:	mov    0x2f60(%rbx),%rdi
   ff5d6:	push   -0x2c0(%rbp)
   ff5dc:	push   -0x2c8(%rbp)
   ff5e2:	push   -0x2d0(%rbp)
   ff5e8:	push   -0x2d8(%rbp)
   ff5ee:	push   -0x2e0(%rbp)
   ff5f4:	push   -0x2e8(%rbp)
   ff5fa:	push   -0x2f0(%rbp)
   ff600:	push   -0x2f8(%rbp)
   ff606:	push   -0x300(%rbp)
   ff60c:	push   -0x308(%rbp)
   ff612:	push   -0x310(%rbp)
   ff618:	push   -0x318(%rbp)
   ff61e:	push   -0x320(%rbp)
   ff624:	push   -0x328(%rbp)
   ff62a:	push   -0x330(%rbp)
   ff630:	push   -0x338(%rbp)
   ff636:	push   -0x340(%rbp)
   ff63c:	push   -0x348(%rbp)
   ff642:	push   -0x350(%rbp)
   ff648:	push   -0x358(%rbp)
   ff64e:	push   -0x360(%rbp)
   ff654:	push   -0x368(%rbp)
   ff65a:	push   -0x370(%rbp)
   ff660:	push   -0x378(%rbp)
   ff666:	push   -0x380(%rbp)
   ff66c:	push   -0x388(%rbp)
   ff672:	push   -0x390(%rbp)
   ff678:	push   -0x398(%rbp)
   ff67e:	push   -0x3a0(%rbp)
   ff684:	push   -0x3a8(%rbp)
   ff68a:	push   -0x3b0(%rbp)
   ff690:	call   6a7c0 <synreal::kernel::add_rolling_contact_preconditioner(synreal::kernel::RollingContactView, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
   ff695:	add    $0x100,%rsp
   ff69c:	call   6c890 <cudaGetLastError@plt>
   ff6a1:	mov    %eax,%edi
   ff6a3:	lea    0xf6336(%rip),%rsi        # 1f59e0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5ae0>
   ff6aa:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ff6af:	mov    -0xaf0(%rbp),%r12
   ff6b6:	jmp    fd87b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x281b>
   ff6bb:	nopl   0x0(%rax,%rax,1)
   ff6c0:	mov    0x2f60(%rbx),%rsi
   ff6c7:	mov    -0xaf0(%rbp),%rdx
   ff6ce:	lea    0x2070(%rbx),%rdi
   ff6d5:	call   6b460 <synreal::Granular::add_preconditioner(glm::mat<3, 3, float, (glm::qualifier)0>*, CUstream_st*) const@plt>
   ff6da:	cmpb   $0x0,-0xad5(%rbp)
   ff6e1:	je     fd62d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x25cd>
   ff6e7:	mov    0xf88a2(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   ff6ee:	xor    %r8d,%r8d
   ff6f1:	mov    $0x1,%ecx
   ff6f6:	mov    %r15,-0x898(%rbp)
   ff6fd:	mov    0xf888c(%rip),%rdx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   ff704:	mov    -0x894(%rbp),%esi
   ff70a:	movl   $0x1,-0x8a0(%rbp)
   ff714:	mov    %rax,-0x8a8(%rbp)
   ff71b:	mov    -0xac0(%rbp),%eax
   ff721:	mov    -0xaf0(%rbp),%r9
   ff728:	mov    %eax,-0x89c(%rbp)
   ff72e:	mov    -0x89c(%rbp),%rdi
   ff735:	call   6efb0 <__cudaPushCallConfiguration@plt>
   ff73a:	test   %eax,%eax
   ff73c:	jne    ff76d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x470d>
   ff73e:	sub    $0x130,%rsp
   ff745:	mov    0x2f60(%rbx),%r8
   ff74c:	mov    $0x25,%ecx
   ff751:	mov    -0xbb8(%rbp),%rsi
   ff758:	mov    %rsp,%rdi
   ff75b:	rep movsq %ds:(%rsi),%es:(%rdi)
   ff75e:	mov    %r8,%rdi
   ff761:	call   6ad80 <synreal::kernel::add_surface_contact_preconditioner(synreal::kernel::SurfaceContactView, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
   ff766:	add    $0x130,%rsp
   ff76d:	call   6c890 <cudaGetLastError@plt>
   ff772:	mov    %eax,%edi
   ff774:	lea    0xf61ad(%rip),%rsi        # 1f5928 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5a28>
   ff77b:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ff780:	cmpb   $0x0,-0xada(%rbp)
   ff787:	je     fd63a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x25da>
   ff78d:	mov    0xf87fc(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   ff794:	mov    -0xa88(%rbp),%rdi
   ff79b:	movl   $0x1,-0x8a0(%rbp)
   ff7a5:	mov    -0xaf0(%rbp),%r12
   ff7ac:	mov    %rax,-0x8a8(%rbp)
   ff7b3:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   ff7b8:	mov    %r15,-0x898(%rbp)
   ff7bf:	mov    -0x8a0(%rbp),%ecx
   ff7c5:	mov    %r12,%r9
   ff7c8:	xor    %r8d,%r8d
   ff7cb:	mov    %eax,-0x89c(%rbp)
   ff7d1:	mov    -0x8a8(%rbp),%rdx
   ff7d8:	mov    -0x89c(%rbp),%rdi
   ff7df:	mov    -0x894(%rbp),%esi
   ff7e5:	call   6efb0 <__cudaPushCallConfiguration@plt>
   ff7ea:	test   %eax,%eax
   ff7ec:	jne    ff829 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x47c9>
   ff7ee:	mov    0x2f60(%rbx),%rcx
   ff7f5:	mov    0x3328(%rbx),%rdx
   ff7fc:	sub    $0x8,%rsp
   ff800:	mov    0x32e8(%rbx),%rsi
   ff807:	mov    0x32a8(%rbx),%rdi
   ff80e:	push   -0xaa8(%rbp)
   ff814:	mov    -0xa90(%rbp),%r9
   ff81b:	mov    -0xa88(%rbp),%r8
   ff822:	call   6abd0 <synreal::kernel::add_triangle_drag_preconditioner(glm::vec<3, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   ff827:	pop    %rcx
   ff828:	pop    %rsi
   ff829:	call   6c890 <cudaGetLastError@plt>
   ff82e:	mov    %eax,%edi
   ff830:	lea    0xf6121(%rip),%rsi        # 1f5958 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5a58>
   ff837:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ff83c:	cmpb   $0x0,-0xace(%rbp)
   ff843:	je     fd647 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x25e7>
   ff849:	mov    0xf8740(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   ff850:	mov    -0xa68(%rbp),%rdi
   ff857:	movl   $0x1,-0x8a0(%rbp)
   ff861:	mov    -0xaf0(%rbp),%r12
   ff868:	mov    %rax,-0x8a8(%rbp)
   ff86f:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   ff874:	mov    %r15,-0x898(%rbp)
   ff87b:	mov    -0x8a0(%rbp),%ecx
   ff881:	mov    %r12,%r9
   ff884:	xor    %r8d,%r8d
   ff887:	mov    %eax,-0x89c(%rbp)
   ff88d:	mov    -0x8a8(%rbp),%rdx
   ff894:	mov    -0x89c(%rbp),%rdi
   ff89b:	mov    -0x894(%rbp),%esi
   ff8a1:	call   6efb0 <__cudaPushCallConfiguration@plt>
   ff8a6:	test   %eax,%eax
   ff8a8:	jne    ff915 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x48b5>
   ff8aa:	mov    0x56c(%rbx),%eax
   ff8b0:	sub    $0x8,%rsp
   ff8b4:	mov    0x34d0(%rbx),%rcx
   ff8bb:	mov    0x34b0(%rbx),%rdx
   ff8c2:	mov    0x570(%rbx),%rsi
   ff8c9:	mov    0x3d0(%rbx),%rdi
   ff8d0:	push   -0xaa8(%rbp)
   ff8d6:	movss  -0xac4(%rbp),%xmm0
   ff8de:	push   %rax
   ff8df:	mov    0x568(%rbx),%eax
   ff8e5:	mov    0x34f0(%rbx),%r8
   ff8ec:	push   %rax
   ff8ed:	push   -0xa68(%rbp)
   ff8f3:	push   0x2f60(%rbx)
   ff8f9:	push   0x3530(%rbx)
   ff8ff:	push   0x3510(%rbx)
   ff905:	mov    0x5b0(%rbx),%r9
   ff90c:	call   6a940 <synreal::kernel::add_joint_body_point_line_augmented_lagrangian_preconditioner(glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
   ff911:	add    $0x40,%rsp
   ff915:	call   6c890 <cudaGetLastError@plt>
   ff91a:	mov    %eax,%edi
   ff91c:	lea    0xf605d(%rip),%rsi        # 1f5980 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5a80>
   ff923:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ff928:	cmpb   $0x0,-0xacd(%rbp)
   ff92f:	je     fd654 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x25f4>
   ff935:	mov    0x5d4(%rbx),%r12d
   ff93c:	imul   -0xa80(%rbp),%r12
   ff944:	movl   $0x1,-0x8a0(%rbp)
   ff94e:	mov    0xf863b(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   ff955:	mov    -0xaf0(%rbp),%r13
   ff95c:	mov    %r12,%rdi
   ff95f:	mov    %rax,-0x8a8(%rbp)
   ff966:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   ff96b:	mov    %r15,-0x898(%rbp)
   ff972:	mov    -0x8a0(%rbp),%ecx
   ff978:	mov    %r13,%r9
   ff97b:	xor    %r8d,%r8d
   ff97e:	mov    %eax,-0x89c(%rbp)
   ff984:	mov    -0x8a8(%rbp),%rdx
   ff98b:	mov    -0x89c(%rbp),%rdi
   ff992:	mov    -0x894(%rbp),%esi
   ff998:	call   6efb0 <__cudaPushCallConfiguration@plt>
   ff99d:	test   %eax,%eax
   ff99f:	jne    ffa3c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x49dc>
   ff9a5:	mov    0x5d4(%rbx),%eax
   ff9ab:	mov    0x5f0(%rbx),%rcx
   ff9b2:	mov    0x5e0(%rbx),%rdx
   ff9b9:	mov    0x3d0(%rbx),%rsi
   ff9c0:	push   -0xaa8(%rbp)
   ff9c6:	movss  0xf85b2(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
   ff9ce:	push   %rax
   ff9cf:	divss  -0xae4(%rbp),%xmm0
   ff9d7:	push   %r12
   ff9d9:	push   0x2f60(%rbx)
   ff9df:	push   0x680(%rbx)
   ff9e5:	push   0x6a0(%rbx)
   ff9eb:	push   0x690(%rbx)
   ff9f1:	push   0x650(%rbx)
   ff9f7:	push   0x35f0(%rbx)
   ff9fd:	push   0x35d0(%rbx)
   ffa03:	push   0x35b0(%rbx)
   ffa09:	push   0x3590(%rbx)
   ffa0f:	push   0x3570(%rbx)
   ffa15:	push   0x630(%rbx)
   ffa1b:	mov    0x620(%rbx),%r9
   ffa22:	mov    -0xaf8(%rbp),%rax
   ffa29:	mov    0x600(%rbx),%r8
   ffa30:	mov    (%rax),%rdi
   ffa33:	call   6aca0 <synreal::kernel::add_joint_drive_preconditioner(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, int const*, int const*, float const*, float const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   ffa38:	add    $0x70,%rsp
   ffa3c:	call   6c890 <cudaGetLastError@plt>
   ffa41:	mov    %eax,%edi
   ffa43:	lea    0xf5f6e(%rip),%rsi        # 1f59b8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5ab8>
   ffa4a:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ffa4f:	jmp    fd654 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x25f4>
   ffa54:	nopl   0x0(%rax)
   ffa58:	mov    0x2f60(%rbx),%rsi
   ffa5f:	mov    -0xaf0(%rbp),%rdx
   ffa66:	lea    0x1728(%rbx),%rdi
   ffa6d:	call   6db70 <synreal::Fluid::add_preconditioner(glm::mat<3, 3, float, (glm::qualifier)0>*, CUstream_st*) const@plt>
   ffa72:	jmp    fd612 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x25b2>
   ffa77:	nopw   0x0(%rax,%rax,1)
   ffa80:	mov    0x2f60(%rbx),%rsi
   ffa87:	mov    -0xaf0(%rbp),%rdx
   ffa8e:	lea    0x8f0(%rbx),%rdi
   ffa95:	call   6cf80 <synreal::SelfCollision::add_preconditioner(glm::mat<3, 3, float, (glm::qualifier)0>*, CUstream_st*) const@plt>
   ffa9a:	jmp    fd602 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x25a2>
   ffa9f:	nop
   ffaa0:	mov    0xf84e9(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   ffaa7:	mov    -0xa60(%rbp),%rdi
   ffaae:	movl   $0x1,-0x8a0(%rbp)
   ffab8:	mov    -0xaf0(%rbp),%r12
   ffabf:	mov    %rax,-0x8a8(%rbp)
   ffac6:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   ffacb:	mov    %r15,-0x898(%rbp)
   ffad2:	mov    -0x8a0(%rbp),%ecx
   ffad8:	mov    %r12,%r9
   ffadb:	xor    %r8d,%r8d
   ffade:	mov    %eax,-0x89c(%rbp)
   ffae4:	mov    -0x8a8(%rbp),%rdx
   ffaeb:	mov    -0x89c(%rbp),%rdi
   ffaf2:	mov    -0x894(%rbp),%esi
   ffaf8:	call   6efb0 <__cudaPushCallConfiguration@plt>
   ffafd:	test   %eax,%eax
   ffaff:	jne    ffb5e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4afe>
   ffb01:	mov    0x318(%rbx),%eax
   ffb07:	sub    $0x8,%rsp
   ffb0b:	mov    0x320(%rbx),%rcx
   ffb12:	mov    0x350(%rbx),%rdx
   ffb19:	mov    0x340(%rbx),%rsi
   ffb20:	push   -0xaa8(%rbp)
   ffb26:	mov    0x2f60(%rbx),%r9
   ffb2d:	push   %rax
   ffb2e:	mov    -0xaf8(%rbp),%rax
   ffb35:	push   -0xa60(%rbp)
   ffb3b:	mov    0x330(%rbx),%r8
   ffb42:	mov    (%rax),%rdi
   ffb45:	movss  0xf8433(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
   ffb4d:	divss  -0xae4(%rbp),%xmm0
   ffb55:	call   6a7b0 <synreal::kernel::add_bending_damping_preconditioner(glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, float, (glm::qualifier)0> const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   ffb5a:	add    $0x20,%rsp
   ffb5e:	call   6c890 <cudaGetLastError@plt>
   ffb63:	mov    %eax,%edi
   ffb65:	lea    0xf5d84(%rip),%rsi        # 1f58f0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x59f0>
   ffb6c:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ffb71:	jmp    fd5f5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2595>
   ffb76:	cs nopw 0x0(%rax,%rax,1)
   ffb80:	mov    0xf8409(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   ffb87:	mov    -0xa98(%rbp),%rdi
   ffb8e:	movl   $0x1,-0x8a0(%rbp)
   ffb98:	mov    -0xaf0(%rbp),%r12
   ffb9f:	mov    %rax,-0x8a8(%rbp)
   ffba6:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   ffbab:	mov    %r15,-0x898(%rbp)
   ffbb2:	mov    -0x8a0(%rbp),%ecx
   ffbb8:	mov    %r12,%r9
   ffbbb:	xor    %r8d,%r8d
   ffbbe:	mov    %eax,-0x89c(%rbp)
   ffbc4:	mov    -0x8a8(%rbp),%rdx
   ffbcb:	mov    -0x89c(%rbp),%rdi
   ffbd2:	mov    -0x894(%rbp),%esi
   ffbd8:	call   6efb0 <__cudaPushCallConfiguration@plt>
   ffbdd:	test   %eax,%eax
   ffbdf:	jne    ffc3e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4bde>
   ffbe1:	mov    0x2e0(%rbx),%eax
   ffbe7:	sub    $0x8,%rsp
   ffbeb:	mov    0x308(%rbx),%rcx
   ffbf2:	mov    0x2f8(%rbx),%rdx
   ffbf9:	mov    0x2e8(%rbx),%rsi
   ffc00:	push   -0xaa8(%rbp)
   ffc06:	mov    0x2f60(%rbx),%r9
   ffc0d:	push   %rax
   ffc0e:	mov    -0xaf8(%rbp),%rax
   ffc15:	push   -0xa98(%rbp)
   ffc1b:	mov    0x3390(%rbx),%r8
   ffc22:	mov    (%rax),%rdi
   ffc25:	movss  0xf8353(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
   ffc2d:	divss  -0xae4(%rbp),%xmm0
   ffc35:	call   6aa40 <synreal::kernel::add_tetrahedron_preconditioner(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   ffc3a:	add    $0x20,%rsp
   ffc3e:	call   6c890 <cudaGetLastError@plt>
   ffc43:	mov    %eax,%edi
   ffc45:	lea    0xf5c6c(%rip),%rsi        # 1f58b8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x59b8>
   ffc4c:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ffc51:	jmp    fd5e8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2588>
   ffc56:	cs nopw 0x0(%rax,%rax,1)
   ffc60:	mov    0xf8329(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   ffc67:	mov    -0xa78(%rbp),%rdi
   ffc6e:	movl   $0x1,-0x8a0(%rbp)
   ffc78:	mov    -0xaf0(%rbp),%r12
   ffc7f:	mov    %rax,-0x8a8(%rbp)
   ffc86:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   ffc8b:	mov    %r15,-0x898(%rbp)
   ffc92:	mov    -0x8a0(%rbp),%ecx
   ffc98:	mov    %r12,%r9
   ffc9b:	xor    %r8d,%r8d
   ffc9e:	mov    %eax,-0x89c(%rbp)
   ffca4:	mov    -0x8a8(%rbp),%rdx
   ffcab:	mov    -0x89c(%rbp),%rdi
   ffcb2:	mov    -0x894(%rbp),%esi
   ffcb8:	call   6efb0 <__cudaPushCallConfiguration@plt>
   ffcbd:	test   %eax,%eax
   ffcbf:	jne    ffd10 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4cb0>
   ffcc1:	mov    0x398(%rbx),%eax
   ffcc7:	movss  0xc(%rbx),%xmm0
   ffccc:	mulss  -0xacc(%rbp),%xmm0
   ffcd4:	mov    0x3a0(%rbx),%rdx
   ffcdb:	mov    0x3d0(%rbx),%rsi
   ffce2:	push   -0xaa8(%rbp)
   ffce8:	mov    -0xa78(%rbp),%r9
   ffcef:	push   %rax
   ffcf0:	mov    -0xaf8(%rbp),%rax
   ffcf7:	mov    0x2f60(%rbx),%r8
   ffcfe:	mov    -0xabc(%rbp),%ecx
   ffd04:	mov    (%rax),%rdi
   ffd07:	call   6aa00 <synreal::kernel::add_affine_body_constitutive_preconditioner(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, float, synreal::AffineBodyRigidityModel, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   ffd0c:	pop    %r11
   ffd0e:	pop    %r12
   ffd10:	call   6c890 <cudaGetLastError@plt>
   ffd15:	mov    %eax,%edi
   ffd17:	lea    0xf5b2a(%rip),%rsi        # 1f5848 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5948>
   ffd1e:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ffd23:	jmp    fd5c5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2565>
   ffd28:	nopl   0x0(%rax,%rax,1)
   ffd30:	mov    0xf8259(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   ffd37:	mov    -0xa78(%rbp),%rdi
   ffd3e:	movl   $0x1,-0x8a0(%rbp)
   ffd48:	mov    %rax,-0x8a8(%rbp)
   ffd4f:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   ffd54:	mov    %r15,-0x898(%rbp)
   ffd5b:	mov    -0x8a0(%rbp),%ecx
   ffd61:	mov    %r12,%r9
   ffd64:	xor    %r8d,%r8d
   ffd67:	mov    %eax,-0x89c(%rbp)
   ffd6d:	mov    -0x8a8(%rbp),%rdx
   ffd74:	mov    -0x89c(%rbp),%rdi
   ffd7b:	mov    -0x894(%rbp),%esi
   ffd81:	call   6efb0 <__cudaPushCallConfiguration@plt>
   ffd86:	test   %eax,%eax
   ffd88:	jne    ffdd8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4d78>
   ffd8a:	mov    0x398(%rbx),%eax
   ffd90:	movss  0xc(%rbx),%xmm0
   ffd95:	mulss  -0xacc(%rbp),%xmm0
   ffd9d:	mov    0x3a0(%rbx),%rdx
   ffda4:	mov    0x3d0(%rbx),%rsi
   ffdab:	push   -0xaa8(%rbp)
   ffdb1:	mov    -0xa78(%rbp),%r9
   ffdb8:	push   %rax
   ffdb9:	mov    -0xaf8(%rbp),%rax
   ffdc0:	mov    0x3040(%rbx),%r8
   ffdc7:	mov    -0xabc(%rbp),%ecx
   ffdcd:	mov    (%rax),%rdi
   ffdd0:	call   6a9b0 <synreal::kernel::evaluate_affine_body_constitutive_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, float, synreal::AffineBodyRigidityModel, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   ffdd5:	pop    %rdi
   ffdd6:	pop    %r8
   ffdd8:	call   6c890 <cudaGetLastError@plt>
   ffddd:	mov    %eax,%edi
   ffddf:	lea    0xf5752(%rip),%rsi        # 1f5538 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5638>
   ffde6:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ffdeb:	mov    -0xaf0(%rbp),%r12
   ffdf2:	jmp    fcefe <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1e9e>
   ffdf7:	nopw   0x0(%rax,%rax,1)
   ffe00:	mov    0x2dc0(%rbx),%rsi
   ffe07:	mov    %r12,%r8
   ffe0a:	mov    $0x3,%ecx
   ffe0f:	mov    %rax,%rdi
   ffe12:	mov    -0xbd8(%rbp),%rdx
   ffe19:	call   6e0b0 <cudaMemcpyAsync@plt>
   ffe1e:	mov    %eax,%edi
   ffe20:	lea    0xf5819(%rip),%rsi        # 1f5640 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5740>
   ffe27:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ffe2c:	mov    0x2de0(%rbx),%rax
   ffe33:	mov    -0xaf0(%rbp),%r12
   ffe3a:	mov    %rax,-0xb70(%rbp)
   ffe41:	jmp    fd00b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1fab>
   ffe46:	cs nopw 0x0(%rax,%rax,1)
   ffe50:	mov    0xf8139(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   ffe57:	xor    %r8d,%r8d
   ffe5a:	mov    $0x1,%ecx
   ffe5f:	mov    %r15,-0x898(%rbp)
   ffe66:	mov    0xf8123(%rip),%rdx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   ffe6d:	mov    -0x894(%rbp),%esi
   ffe73:	movl   $0x1,-0x8a0(%rbp)
   ffe7d:	mov    %rax,-0x8a8(%rbp)
   ffe84:	mov    -0xac0(%rbp),%eax
   ffe8a:	mov    -0xaf0(%rbp),%r9
   ffe91:	mov    %eax,-0x89c(%rbp)
   ffe97:	mov    -0x89c(%rbp),%rdi
   ffe9e:	call   6efb0 <__cudaPushCallConfiguration@plt>
   ffea3:	test   %eax,%eax
   ffea5:	jne    ffed6 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4e76>
   ffea7:	sub    $0x130,%rsp
   ffeae:	mov    0x2f00(%rbx),%r8
   ffeb5:	mov    $0x25,%ecx
   ffeba:	mov    -0xbb8(%rbp),%rsi
   ffec1:	mov    %rsp,%rdi
   ffec4:	rep movsq %ds:(%rsi),%es:(%rdi)
   ffec7:	mov    %r8,%rdi
   ffeca:	call   6abe0 <synreal::kernel::add_surface_contact_stiffness_scale(synreal::kernel::SurfaceContactView, float*)@plt>
   ffecf:	add    $0x130,%rsp
   ffed6:	call   6c890 <cudaGetLastError@plt>
   ffedb:	mov    %eax,%edi
   ffedd:	lea    0xf541c(%rip),%rsi        # 1f5300 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5400>
   ffee4:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ffee9:	jmp    fc9be <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x195e>
   ffeee:	xchg   %ax,%ax
   ffef0:	mov    0x568(%rbx),%eax
   ffef6:	mov    -0xaf8(%rbp),%rdi
   ffefd:	sub    $0x8,%rsp
   fff01:	mov    0x570(%rbx),%rcx
   fff08:	mov    0x3d0(%rbx),%rdx
   fff0f:	mov    0x10(%rdi),%rsi
   fff13:	push   -0xaa8(%rbp)
   fff19:	movss  -0xac4(%rbp),%xmm0
   fff21:	push   %rax
   fff22:	xor    %eax,%eax
   fff24:	cmpl   $0x1,-0xb1c(%rbp)
   fff2b:	push   %r13
   fff2d:	setne  %al
   fff30:	push   %r12
   fff32:	push   %rax
   fff33:	mov    0x56c(%rbx),%eax
   fff39:	push   %rax
   fff3a:	push   0x5c0(%rbx)
   fff40:	push   0x5b0(%rbx)
   fff46:	push   0x5a0(%rbx)
   fff4c:	push   0x590(%rbx)
   fff52:	mov    (%rdi),%rdi
   fff55:	push   0x34f0(%rbx)
   fff5b:	mov    0x34d0(%rbx),%r9
   fff62:	mov    0x34b0(%rbx),%r8
   fff69:	call   6af70 <synreal::kernel::evaluate_body_point_line_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float, unsigned long, bool, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   fff6e:	add    $0x60,%rsp
   fff72:	jmp    fcbbb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1b5b>
   fff77:	nopw   0x0(%rax,%rax,1)
   fff80:	mov    0x498(%rbx),%eax
   fff86:	sub    $0x8,%rsp
   fff8a:	mov    0x4b0(%rbx),%rcx
   fff91:	mov    0x4a0(%rbx),%rdx
   fff98:	mov    0x3d0(%rbx),%rsi
   fff9f:	push   -0xaa8(%rbp)
   fffa5:	movss  -0xac4(%rbp),%xmm0
   fffad:	push   %rax
   fffae:	xor    %eax,%eax
   fffb0:	cmpl   $0x1,-0xb1c(%rbp)
   fffb7:	push   %r13
   fffb9:	setne  %al
   fffbc:	push   %r12
   fffbe:	mov    0x4c0(%rbx),%r8
   fffc5:	push   %rax
   fffc6:	mov    0x49c(%rbx),%eax
   fffcc:	push   %rax
   fffcd:	mov    -0xaf8(%rbp),%rax
   fffd4:	push   0x4e0(%rbx)
   fffda:	mov    (%rax),%rdi
   fffdd:	push   0x4d0(%rbx)
   fffe3:	push   0x33f0(%rbx)
   fffe9:	mov    0x33d0(%rbx),%r9
   ffff0:	call   6ad70 <synreal::kernel::evaluate_body_spring_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, float const*, float, unsigned long, bool, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   ffff5:	add    $0x50,%rsp
   ffff9:	jmp    fca4e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x19ee>
   ffffe:	xchg   %ax,%ax
  100000:	mov    0x5dc(%rbx),%eax
  100006:	mov    0x3240(%rbx),%rcx
  10000d:	mov    0x3280(%rbx),%rdx
  100014:	mov    0x3060(%rbx),%rsi
  10001b:	push   %rax
  10001c:	mov    0x5d8(%rbx),%eax
  100022:	movss  0xf7f56(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  10002a:	divss  -0xae4(%rbp),%xmm0
  100032:	push   %rax
  100033:	mov    0x5d4(%rbx),%eax
  100039:	push   -0xaa8(%rbp)
  10003f:	push   %rax
  100040:	mov    -0xb88(%rbp),%rax
  100047:	push   %r13
  100049:	push   %r12
  10004b:	push   0x20(%rax)
  10004e:	push   0x10(%rax)
  100051:	push   (%rax)
  100053:	push   0x6a0(%rbx)
  100059:	push   0x690(%rbx)
  10005f:	push   0x6c0(%rbx)
  100065:	push   0x680(%rbx)
  10006b:	push   0x670(%rbx)
  100071:	push   0x660(%rbx)
  100077:	mov    -0xaf8(%rbp),%rax
  10007e:	push   0x650(%rbx)
  100084:	mov    0x3d0(%rbx),%r9
  10008b:	push   0x35f0(%rbx)
  100091:	push   0x35d0(%rbx)
  100097:	push   0x35b0(%rbx)
  10009d:	push   0x3590(%rbx)
  1000a3:	push   0x3570(%rbx)
  1000a9:	push   0x630(%rbx)
  1000af:	push   0x620(%rbx)
  1000b5:	push   0x600(%rbx)
  1000bb:	mov    (%rax),%rdi
  1000be:	push   0x5f0(%rbx)
  1000c4:	push   0x5e0(%rbx)
  1000ca:	mov    0x3260(%rbx),%r8
  1000d1:	call   6ab40 <synreal::kernel::evaluate_joint_drive_load(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float*, int*, glm::vec<4, int, (glm::qualifier)0> const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, int const*, int const*, float const*, float const*, float const*, int const*, float const*, float const*, float const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, float)@plt>
  1000d6:	add    $0xd0,%rsp
  1000dd:	jmp    fcc87 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1c27>
  1000e2:	nopw   0x0(%rax,%rax,1)
  1000e8:	mov    -0x850(%rbp),%rax
  1000ef:	mov    -0x830(%rbp),%rdx
  1000f6:	mov    %r12,%r9
  1000f9:	xor    %r8d,%r8d
  1000fc:	movss  0xf7e7c(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  100104:	mov    0x3280(%rax),%rcx
  10010b:	mov    0x6b0(%rax),%rdi
  100112:	divss  (%rdx),%xmm0
  100116:	mov    0x3060(%rax),%rdx
  10011d:	mov    -0x848(%rbp),%rax
  100124:	push   $0x0
  100126:	push   0x70(%rax)
  100129:	push   0x68(%rax)
  10012c:	push   0x60(%rax)
  10012f:	push   0x58(%rax)
  100132:	push   0x50(%rax)
  100135:	push   0x48(%rax)
  100138:	push   0x40(%rax)
  10013b:	push   0x38(%rax)
  10013e:	push   0x30(%rax)
  100141:	push   0x28(%rax)
  100144:	push   0x20(%rax)
  100147:	push   0x18(%rax)
  10014a:	push   0x10(%rax)
  10014d:	push   0x8(%rax)
  100150:	push   (%rax)
  100152:	mov    -0x838(%rbp),%rax
  100159:	mov    (%rax),%rsi
  10015c:	call   6aee0 <synreal::kernel::evaluate_joint_armature(synreal::kernel::JointCoordinateView, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  100161:	sub    $0xffffffffffffff80,%rsp
  100165:	jmp    fcd21 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1cc1>
  10016a:	nopw   0x0(%rax,%rax,1)
  100170:	mov    -0x7c0(%rbp),%rax
  100177:	xor    %r8d,%r8d
  10017a:	mov    %r12,%rcx
  10017d:	xor    %edx,%edx
  10017f:	movss  0xf7df9(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  100187:	divss  (%rax),%xmm0
  10018b:	mov    -0x7c8(%rbp),%rax
  100192:	mov    0x3060(%rax),%rsi
  100199:	mov    -0x7d8(%rbp),%rax
  1001a0:	push   0x98(%rax)
  1001a6:	push   0x90(%rax)
  1001ac:	push   0x88(%rax)
  1001b2:	push   0x80(%rax)
  1001b8:	push   0x78(%rax)
  1001bb:	push   0x70(%rax)
  1001be:	push   0x68(%rax)
  1001c1:	push   0x60(%rax)
  1001c4:	push   0x58(%rax)
  1001c7:	push   0x50(%rax)
  1001ca:	push   0x48(%rax)
  1001cd:	push   0x40(%rax)
  1001d0:	push   0x38(%rax)
  1001d3:	push   0x30(%rax)
  1001d6:	push   0x28(%rax)
  1001d9:	push   0x20(%rax)
  1001dc:	push   0x18(%rax)
  1001df:	push   0x10(%rax)
  1001e2:	push   0x8(%rax)
  1001e5:	push   (%rax)
  1001e7:	mov    -0x7d0(%rbp),%rax
  1001ee:	mov    (%rax),%rdi
  1001f1:	call   6aa60 <synreal::kernel::evaluate_cables(synreal::kernel::CableView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  1001f6:	add    $0xa0,%rsp
  1001fd:	jmp    fcdb6 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1d56>
  100202:	nopw   0x0(%rax,%rax,1)
  100208:	mov    0xf7d81(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  10020f:	mov    -0xa78(%rbp),%rdi
  100216:	movl   $0x1,-0x8a0(%rbp)
  100220:	mov    -0xaf0(%rbp),%r12
  100227:	mov    %rax,-0x8a8(%rbp)
  10022e:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  100233:	mov    %r15,-0x898(%rbp)
  10023a:	mov    -0x8a0(%rbp),%ecx
  100240:	mov    %r12,%r9
  100243:	xor    %r8d,%r8d
  100246:	mov    %eax,-0x89c(%rbp)
  10024c:	mov    -0x8a8(%rbp),%rdx
  100253:	mov    -0x89c(%rbp),%rdi
  10025a:	mov    -0x894(%rbp),%esi
  100260:	call   6efb0 <__cudaPushCallConfiguration@plt>
  100265:	test   %eax,%eax
  100267:	jne    1002b3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5253>
  100269:	movss  0xc(%rbx),%xmm0
  10026e:	mulss  -0xacc(%rbp),%xmm0
  100276:	sub    $0x8,%rsp
  10027a:	mov    0x2f60(%rbx),%rcx
  100281:	mov    0x3350(%rbx),%rdx
  100288:	mov    0x3a0(%rbx),%rsi
  10028f:	mov    0x3d0(%rbx),%rdi
  100296:	push   -0xaa8(%rbp)
  10029c:	mov    0x398(%rbx),%r9d
  1002a3:	mov    -0xa78(%rbp),%r8
  1002aa:	call   6ac80 <synreal::kernel::add_affine_body_so3_augmented_lagrangian_preconditioner(glm::vec<4, int, (glm::qualifier)0> const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  1002af:	pop    %r12
  1002b1:	pop    %r13
  1002b3:	call   6c890 <cudaGetLastError@plt>
  1002b8:	mov    %eax,%edi
  1002ba:	lea    0xf5777(%rip),%rsi        # 1f5a38 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5b38>
  1002c1:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  1002c6:	jmp    fdd8c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2d2c>
  1002cb:	nopl   0x0(%rax,%rax,1)
  1002d0:	mov    -0xaf8(%rbp),%rax
  1002d7:	movss  0x48(%rbx),%xmm0
  1002dc:	push   -0xb58(%rbp)
  1002e2:	mov    0x28(%r14),%rcx
  1002e6:	push   %r13
  1002e8:	mov    0x18(%r14),%rdx
  1002ec:	mov    0x10(%r14),%esi
  1002f0:	push   -0xb60(%rbp)
  1002f6:	push   0x10(%rax)
  1002f9:	push   (%rax)
  1002fb:	mov    0x398(%rbx),%eax
  100301:	push   -0xaa8(%rbp)
  100307:	push   %rax
  100308:	mov    -0xac8(%rbp),%eax
  10030e:	push   0x3e0(%rbx)
  100314:	push   0x3d0(%rbx)
  10031a:	push   0x3f0(%rbx)
  100320:	push   -0xa80(%rbp)
  100326:	push   %rax
  100327:	mov    0x710(%rbx),%eax
  10032d:	push   %rax
  10032e:	push   0x788(%rbx)
  100334:	push   0x778(%rbx)
  10033a:	mov    0x48(%r14),%r9
  10033e:	push   0x768(%rbx)
  100344:	mov    0x38(%r14),%r8
  100348:	push   0x758(%rbx)
  10034e:	mov    (%r14),%rdi
  100351:	push   0x748(%rbx)
  100357:	movss  0xf7c21(%rip),%xmm1        # 1f7f80 <cuda::std::__4::in_place+0x33>
  10035f:	push   0x738(%rbx)
  100365:	divss  -0xb70(%rbp),%xmm1
  10036d:	push   0x728(%rbx)
  100373:	push   0x718(%rbx)
  100379:	push   0x98(%r14)
  100380:	push   0x88(%r14)
  100387:	push   0x78(%r14)
  10038b:	push   0x68(%r14)
  10038f:	push   0x58(%r14)
  100393:	call   6a8d0 <synreal::kernel::evaluate_contact_force(int const*, unsigned long, int const*, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, int const*, int const*, synreal::Transform const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float const*, float const*, float, unsigned long, unsigned long, unsigned long, int const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, unsigned long, unsigned long, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, float*)@plt>
  100398:	add    $0xd0,%rsp
  10039f:	jmp    fc594 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1534>
  1003a4:	nopl   0x0(%rax)
  1003a8:	mov    0xf7be1(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  1003af:	mov    -0xa78(%rbp),%rdi
  1003b6:	movl   $0x1,-0x8a0(%rbp)
  1003c0:	mov    -0xaf0(%rbp),%r12
  1003c7:	mov    %rax,-0x8a8(%rbp)
  1003ce:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  1003d3:	mov    %r15,-0x898(%rbp)
  1003da:	mov    -0x8a0(%rbp),%ecx
  1003e0:	mov    %r12,%r9
  1003e3:	xor    %r8d,%r8d
  1003e6:	mov    %eax,-0x89c(%rbp)
  1003ec:	mov    -0x8a8(%rbp),%rdx
  1003f3:	mov    -0x89c(%rbp),%rdi
  1003fa:	mov    -0x894(%rbp),%esi
  100400:	call   6efb0 <__cudaPushCallConfiguration@plt>
  100405:	test   %eax,%eax
  100407:	jne    100453 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x53f3>
  100409:	movss  0xc(%rbx),%xmm0
  10040e:	mulss  -0xacc(%rbp),%xmm0
  100416:	sub    $0x8,%rsp
  10041a:	mov    0x2f60(%rbx),%rcx
  100421:	mov    0x3350(%rbx),%rdx
  100428:	mov    0x3a0(%rbx),%rsi
  10042f:	mov    0x3d0(%rbx),%rdi
  100436:	push   -0xaa8(%rbp)
  10043c:	mov    0x398(%rbx),%r9d
  100443:	mov    -0xa78(%rbp),%r8
  10044a:	call   6ac80 <synreal::kernel::add_affine_body_so3_augmented_lagrangian_preconditioner(glm::vec<4, int, (glm::qualifier)0> const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  10044f:	pop    %r9
  100451:	pop    %r10
  100453:	call   6c890 <cudaGetLastError@plt>
  100458:	mov    %eax,%edi
  10045a:	lea    0xf541f(%rip),%rsi        # 1f5880 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5980>
  100461:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  100466:	jmp    fd5db <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x257b>
  10046b:	cmpb   $0x0,-0xad9(%rbp)
  100472:	je     fd3a7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2347>
  100478:	nopl   0x0(%rax,%rax,1)
  100480:	mov    0x2f40(%rbx),%rax
  100487:	mov    0x2f60(%rbx),%r13
  10048e:	mov    %rax,-0xb70(%rbp)
  100495:	mov    -0x7a0(%rbp),%rax
  10049c:	mov    (%rax),%r12
  10049f:	mov    -0x7a8(%rbp),%rax
  1004a6:	mov    0x10(%rax),%edi
  1004a9:	mov    -0x7b0(%rbp),%rax
  1004b0:	cmpb   $0x0,(%rax)
  1004b3:	mov    0xf7ad6(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  1004ba:	movl   $0x1,-0x8a0(%rbp)
  1004c4:	mov    %rax,-0x8a8(%rbp)
  1004cb:	jne    101840 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x67e0>
  1004d1:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  1004d6:	mov    %r15,-0x898(%rbp)
  1004dd:	mov    -0x8a0(%rbp),%ecx
  1004e3:	mov    %r12,%r9
  1004e6:	xor    %r8d,%r8d
  1004e9:	mov    %eax,-0x89c(%rbp)
  1004ef:	mov    -0x8a8(%rbp),%rdx
  1004f6:	mov    -0x89c(%rbp),%rdi
  1004fd:	mov    -0x894(%rbp),%esi
  100503:	call   6efb0 <__cudaPushCallConfiguration@plt>
  100508:	test   %eax,%eax
  10050a:	je     1024f0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7490>
  100510:	call   6c890 <cudaGetLastError@plt>
  100515:	mov    %eax,%edi
  100517:	lea    0xf5302(%rip),%rsi        # 1f5820 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5920>
  10051e:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  100523:	jmp    fd3a7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2347>
  100528:	nopl   0x0(%rax,%rax,1)
  100530:	mov    -0x850(%rbp),%rax
  100537:	mov    -0x830(%rbp),%rdx
  10053e:	xor    %r9d,%r9d
  100541:	xor    %r8d,%r8d
  100544:	movss  0xf7a34(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  10054c:	mov    0x3280(%rax),%rcx
  100553:	mov    0x6b0(%rax),%rdi
  10055a:	divss  (%rdx),%xmm0
  10055e:	mov    0x3060(%rax),%rdx
  100565:	mov    -0x848(%rbp),%rax
  10056c:	push   %r12
  10056e:	push   0x70(%rax)
  100571:	push   0x68(%rax)
  100574:	push   0x60(%rax)
  100577:	push   0x58(%rax)
  10057a:	push   0x50(%rax)
  10057d:	push   0x48(%rax)
  100580:	push   0x40(%rax)
  100583:	push   0x38(%rax)
  100586:	push   0x30(%rax)
  100589:	push   0x28(%rax)
  10058c:	push   0x20(%rax)
  10058f:	push   0x18(%rax)
  100592:	push   0x10(%rax)
  100595:	push   0x8(%rax)
  100598:	push   (%rax)
  10059a:	mov    -0x838(%rbp),%rax
  1005a1:	mov    (%rax),%rsi
  1005a4:	call   6aee0 <synreal::kernel::evaluate_joint_armature(synreal::kernel::JointCoordinateView, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  1005a9:	sub    $0xffffffffffffff80,%rsp
  1005ad:	jmp    fd6db <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x267b>
  1005b2:	nopw   0x0(%rax,%rax,1)
  1005b8:	mov    0x4f0(%rbx),%eax
  1005be:	movss  0xc(%rbx),%xmm0
  1005c3:	mulss  -0xacc(%rbp),%xmm0
  1005cb:	mov    0x508(%rbx),%rcx
  1005d2:	mov    0x4f8(%rbx),%rdx
  1005d9:	mov    0x3d0(%rbx),%rsi
  1005e0:	push   -0xaa8(%rbp)
  1005e6:	push   %rax
  1005e7:	mov    -0xaf8(%rbp),%rax
  1005ee:	push   -0xb80(%rbp)
  1005f4:	push   %r12
  1005f6:	push   0x3490(%rbx)
  1005fc:	push   0x3470(%rbx)
  100602:	mov    0x518(%rbx),%r8
  100609:	push   0x548(%rbx)
  10060f:	mov    (%rax),%rdi
  100612:	push   0x3450(%rbx)
  100618:	mov    0x3430(%rbx),%r9
  10061f:	call   6a8a0 <synreal::kernel::evaluate_body_distance_constraint_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  100624:	add    $0x40,%rsp
  100628:	jmp    fcb16 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ab6>
  10062d:	nopl   (%rax)
  100630:	mov    -0x818(%rbp),%rax
  100637:	mov    -0x7f8(%rbp),%rdx
  10063e:	mov    %r12,%r9
  100641:	xor    %r8d,%r8d
  100644:	movss  0xf7934(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  10064c:	mov    0x3260(%rax),%rcx
  100653:	mov    0x3060(%rax),%rsi
  10065a:	divss  (%rdx),%xmm0
  10065e:	mov    0x3240(%rax),%rdx
  100665:	mov    -0x810(%rbp),%rax
  10066c:	push   $0x0
  10066e:	push   -0x878(%rbp)
  100674:	push   -0x880(%rbp)
  10067a:	push   -0x888(%rbp)
  100680:	push   -0x890(%rbp)
  100686:	push   0x70(%rax)
  100689:	push   0x68(%rax)
  10068c:	push   0x60(%rax)
  10068f:	push   0x58(%rax)
  100692:	push   0x50(%rax)
  100695:	push   0x48(%rax)
  100698:	push   0x40(%rax)
  10069b:	push   0x38(%rax)
  10069e:	push   0x30(%rax)
  1006a1:	push   0x28(%rax)
  1006a4:	push   0x20(%rax)
  1006a7:	push   0x18(%rax)
  1006aa:	push   0x10(%rax)
  1006ad:	push   0x8(%rax)
  1006b0:	push   (%rax)
  1006b2:	mov    -0x800(%rbp),%rax
  1006b9:	mov    (%rax),%rdi
  1006bc:	call   6ac30 <synreal::kernel::evaluate_angular_limits(synreal::kernel::JointCoordinateView, synreal::kernel::AngularLimitView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, int const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  1006c1:	add    $0xa0,%rsp
  1006c8:	jmp    fce8d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1e2d>
  1006cd:	nopl   (%rax)
  1006d0:	imul   -0xa80(%rbp),%r13
  1006d8:	mov    0xf78b1(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  1006df:	movl   $0x1,-0x8a0(%rbp)
  1006e9:	mov    %rax,-0x8a8(%rbp)
  1006f0:	mov    %r13,%rdi
  1006f3:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  1006f8:	mov    %r15,-0x898(%rbp)
  1006ff:	mov    -0x8a0(%rbp),%ecx
  100705:	mov    %r12,%r9
  100708:	xor    %r8d,%r8d
  10070b:	mov    %eax,-0x89c(%rbp)
  100711:	mov    -0x8a8(%rbp),%rdx
  100718:	mov    -0x89c(%rbp),%rdi
  10071f:	mov    -0x894(%rbp),%esi
  100725:	call   6efb0 <__cudaPushCallConfiguration@plt>
  10072a:	test   %eax,%eax
  10072c:	jne    10078f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x572f>
  10072e:	mov    0x278(%rbx),%eax
  100734:	sub    $0x8,%rsp
  100738:	mov    0x290(%rbx),%rcx
  10073f:	mov    0x2a0(%rbx),%rdx
  100746:	mov    0x280(%rbx),%rsi
  10074d:	push   -0xaa0(%rbp)
  100753:	mov    -0xb58(%rbp),%r9
  10075a:	push   -0xaa8(%rbp)
  100760:	mov    0x2c0(%rbx),%r8
  100767:	push   %rax
  100768:	mov    -0xaf8(%rbp),%rax
  10076f:	push   %r13
  100771:	push   -0xb60(%rbp)
  100777:	mov    (%rax),%rdi
  10077a:	push   -0xb70(%rbp)
  100780:	push   -0xb90(%rbp)
  100786:	call   6adf0 <synreal::kernel::add_cloth_membrane_gauss_newton_hessian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, glm::mat<2, 2, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
  10078b:	add    $0x40,%rsp
  10078f:	call   6c890 <cudaGetLastError@plt>
  100794:	mov    %eax,%edi
  100796:	lea    0xf4ecb(%rip),%rsi        # 1f5668 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5768>
  10079d:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  1007a2:	mov    0x240(%rbx),%r13d
  1007a9:	mov    -0xaf0(%rbp),%r12
  1007b0:	test   %r13d,%r13d
  1007b3:	je     fd063 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2003>
  1007b9:	imul   -0xa80(%rbp),%r13
  1007c1:	mov    0xf77c8(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  1007c8:	movl   $0x1,-0x8a0(%rbp)
  1007d2:	mov    %rax,-0x8a8(%rbp)
  1007d9:	mov    %r13,%rdi
  1007dc:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  1007e1:	mov    %r15,-0x898(%rbp)
  1007e8:	mov    -0x8a0(%rbp),%ecx
  1007ee:	mov    %r12,%r9
  1007f1:	xor    %r8d,%r8d
  1007f4:	mov    %eax,-0x89c(%rbp)
  1007fa:	mov    -0x8a8(%rbp),%rdx
  100801:	mov    -0x89c(%rbp),%rdi
  100808:	mov    -0x894(%rbp),%esi
  10080e:	call   6efb0 <__cudaPushCallConfiguration@plt>
  100813:	test   %eax,%eax
  100815:	jne    10086e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x580e>
  100817:	mov    0x240(%rbx),%eax
  10081d:	mov    0x268(%rbx),%rcx
  100824:	mov    0x258(%rbx),%rdx
  10082b:	mov    0x248(%rbx),%rsi
  100832:	push   -0xaa0(%rbp)
  100838:	mov    -0xb90(%rbp),%r9
  10083f:	push   -0xaa8(%rbp)
  100845:	mov    -0xb58(%rbp),%r8
  10084c:	push   %rax
  10084d:	mov    -0xaf8(%rbp),%rax
  100854:	push   %r13
  100856:	push   -0xb60(%rbp)
  10085c:	mov    (%rax),%rdi
  10085f:	push   -0xb70(%rbp)
  100865:	call   6ada0 <synreal::kernel::add_spring_gauss_newton_hessian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, float const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
  10086a:	add    $0x30,%rsp
  10086e:	call   6c890 <cudaGetLastError@plt>
  100873:	mov    %eax,%edi
  100875:	lea    0xf4e1c(%rip),%rsi        # 1f5698 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5798>
  10087c:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  100881:	mov    -0xaf0(%rbp),%r12
  100888:	jmp    fd063 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2003>
  10088d:	nopl   (%rax)
  100890:	sub    $0x130,%rsp
  100897:	mov    -0xbb8(%rbp),%rsi
  10089e:	mov    $0x25,%ecx
  1008a3:	mov    %rsp,%rdi
  1008a6:	rep movsq %ds:(%rsi),%es:(%rdi)
  1008a9:	mov    %r12,%rdi
  1008ac:	call   6ae40 <synreal::kernel::evaluate_surface_contact_force(synreal::kernel::SurfaceContactView, glm::vec<3, float, (glm::qualifier)0>*)@plt>
  1008b1:	add    $0x130,%rsp
  1008b8:	jmp    fc7a7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1747>
  1008bd:	nopl   (%rax)
  1008c0:	push   $0x0
  1008c2:	mov    -0xba0(%rbp),%rsi
  1008c9:	mov    $0x27,%ecx
  1008ce:	xor    %edx,%edx
  1008d0:	xor    %r9d,%r9d
  1008d3:	xor    %r8d,%r8d
  1008d6:	sub    $0x138,%rsp
  1008dd:	mov    %rsp,%rdi
  1008e0:	rep movsq %ds:(%rsi),%es:(%rdi)
  1008e3:	mov    %r13,%rdi
  1008e6:	mov    -0xb58(%rbp),%rsi
  1008ed:	call   6ae80 <synreal::kernel::evaluate_hard_contacts(synreal::kernel::HardContactView, glm::vec<3, float, (glm::qualifier)0>*, float*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, float*)@plt>
  1008f2:	add    $0x140,%rsp
  1008f9:	jmp    ff54f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x44ef>
  1008fe:	xchg   %ax,%ax
  100900:	mov    -0x7c0(%rbp),%rax
  100907:	mov    %r12,%r8
  10090a:	xor    %ecx,%ecx
  10090c:	xor    %edx,%edx
  10090e:	movss  0xf766a(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  100916:	divss  (%rax),%xmm0
  10091a:	mov    -0x7c8(%rbp),%rax
  100921:	mov    0x3060(%rax),%rsi
  100928:	mov    -0x7d8(%rbp),%rax
  10092f:	push   0x98(%rax)
  100935:	push   0x90(%rax)
  10093b:	push   0x88(%rax)
  100941:	push   0x80(%rax)
  100947:	push   0x78(%rax)
  10094a:	push   0x70(%rax)
  10094d:	push   0x68(%rax)
  100950:	push   0x60(%rax)
  100953:	push   0x58(%rax)
  100956:	push   0x50(%rax)
  100959:	push   0x48(%rax)
  10095c:	push   0x40(%rax)
  10095f:	push   0x38(%rax)
  100962:	push   0x30(%rax)
  100965:	push   0x28(%rax)
  100968:	push   0x20(%rax)
  10096b:	push   0x18(%rax)
  10096e:	push   0x10(%rax)
  100971:	push   0x8(%rax)
  100974:	push   (%rax)
  100976:	mov    -0x7d0(%rbp),%rax
  10097d:	mov    (%rax),%rdi
  100980:	call   6aa60 <synreal::kernel::evaluate_cables(synreal::kernel::CableView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  100985:	add    $0xa0,%rsp
  10098c:	jmp    fde0a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2daa>
  100991:	nopl   0x0(%rax)
  100998:	mov    -0x7c0(%rbp),%rax
  10099f:	mov    %r12,%r8
  1009a2:	xor    %ecx,%ecx
  1009a4:	xor    %edx,%edx
  1009a6:	movss  0xf75d2(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  1009ae:	divss  (%rax),%xmm0
  1009b2:	mov    -0x7c8(%rbp),%rax
  1009b9:	mov    0x3060(%rax),%rsi
  1009c0:	mov    -0x7d8(%rbp),%rax
  1009c7:	push   0x98(%rax)
  1009cd:	push   0x90(%rax)
  1009d3:	push   0x88(%rax)
  1009d9:	push   0x80(%rax)
  1009df:	push   0x78(%rax)
  1009e2:	push   0x70(%rax)
  1009e5:	push   0x68(%rax)
  1009e8:	push   0x60(%rax)
  1009eb:	push   0x58(%rax)
  1009ee:	push   0x50(%rax)
  1009f1:	push   0x48(%rax)
  1009f4:	push   0x40(%rax)
  1009f7:	push   0x38(%rax)
  1009fa:	push   0x30(%rax)
  1009fd:	push   0x28(%rax)
  100a00:	push   0x20(%rax)
  100a03:	push   0x18(%rax)
  100a06:	push   0x10(%rax)
  100a09:	push   0x8(%rax)
  100a0c:	push   (%rax)
  100a0e:	mov    -0x7d0(%rbp),%rax
  100a15:	mov    (%rax),%rdi
  100a18:	call   6aa60 <synreal::kernel::evaluate_cables(synreal::kernel::CableView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  100a1d:	add    $0xa0,%rsp
  100a24:	jmp    fd77d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x271d>
  100a29:	nopl   0x0(%rax)
  100a30:	mov    -0x818(%rbp),%rax
  100a37:	mov    -0x7f8(%rbp),%rdx
  100a3e:	xor    %r9d,%r9d
  100a41:	xor    %r8d,%r8d
  100a44:	movss  0xf7534(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  100a4c:	mov    0x3260(%rax),%rcx
  100a53:	mov    0x3060(%rax),%rsi
  100a5a:	divss  (%rdx),%xmm0
  100a5e:	mov    0x3240(%rax),%rdx
  100a65:	mov    -0x810(%rbp),%rax
  100a6c:	push   %r12
  100a6e:	push   -0x858(%rbp)
  100a74:	push   -0x860(%rbp)
  100a7a:	push   -0x868(%rbp)
  100a80:	push   -0x870(%rbp)
  100a86:	push   0x70(%rax)
  100a89:	push   0x68(%rax)
  100a8c:	push   0x60(%rax)
  100a8f:	push   0x58(%rax)
  100a92:	push   0x50(%rax)
  100a95:	push   0x48(%rax)
  100a98:	push   0x40(%rax)
  100a9b:	push   0x38(%rax)
  100a9e:	push   0x30(%rax)
  100aa1:	push   0x28(%rax)
  100aa4:	push   0x20(%rax)
  100aa7:	push   0x18(%rax)
  100aaa:	push   0x10(%rax)
  100aad:	push   0x8(%rax)
  100ab0:	push   (%rax)
  100ab2:	mov    -0x800(%rbp),%rax
  100ab9:	mov    (%rax),%rdi
  100abc:	call   6ac30 <synreal::kernel::evaluate_angular_limits(synreal::kernel::JointCoordinateView, synreal::kernel::AngularLimitView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, int const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  100ac1:	add    $0xa0,%rsp
  100ac8:	jmp    fd854 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x27f4>
  100acd:	nopl   (%rax)
  100ad0:	mov    0xf74b9(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  100ad7:	movl   $0x1,-0x8a0(%rbp)
  100ae1:	mov    %rax,-0x8a8(%rbp)
  100ae8:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  100aed:	mov    %r15,-0x898(%rbp)
  100af4:	mov    -0x8a0(%rbp),%ecx
  100afa:	mov    %r12,%r9
  100afd:	xor    %r8d,%r8d
  100b00:	mov    %eax,-0x89c(%rbp)
  100b06:	mov    -0x8a8(%rbp),%rdx
  100b0d:	mov    -0x89c(%rbp),%rdi
  100b14:	mov    -0x894(%rbp),%esi
  100b1a:	call   6efb0 <__cudaPushCallConfiguration@plt>
  100b1f:	test   %eax,%eax
  100b21:	je     1018a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6840>
  100b27:	call   6c890 <cudaGetLastError@plt>
  100b2c:	mov    %eax,%edi
  100b2e:	lea    0xf501b(%rip),%rsi        # 1f5b50 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5c50>
  100b35:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  100b3a:	mov    -0xaf0(%rbp),%r12
  100b41:	jmp    fe4ea <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x348a>
  100b46:	cs nopw 0x0(%rax,%rax,1)
  100b50:	imul   %rax,%r13
  100b54:	mov    %rax,-0xbe0(%rbp)
  100b5b:	test   %r13,%r13
  100b5e:	je     fd1d0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2170>
  100b64:	mov    0x56c(%rbx),%eax
  100b6a:	mov    %rax,-0xbf8(%rbp)
  100b71:	jmp    1018fb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x689b>
  100b76:	cs nopw 0x0(%rax,%rax,1)
  100b80:	mov    0x2db0(%rbx),%rdi
  100b87:	test   %rdi,%rdi
  100b8a:	jne    102368 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7308>
  100b90:	mov    0x398(%rbx),%eax
  100b96:	test   %eax,%eax
  100b98:	je     102358 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x72f8>
  100b9e:	mov    -0xb30(%rbp),%ecx
  100ba4:	lea    -0x2(%rcx),%edx
  100ba7:	cmp    $0x1,%edx
  100baa:	jbe    101af0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6a90>
  100bb0:	movss  0xc(%rbx),%xmm0
  100bb5:	pxor   %xmm6,%xmm6
  100bb9:	comiss %xmm6,%xmm0
  100bbc:	jbe    1025f0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7590>
  100bc2:	movb   $0x1,-0xad0(%rbp)
  100bc9:	xor    %edx,%edx
  100bcb:	mov    $0x1,%r13d
  100bd1:	mov    $0x1,%edi
  100bd6:	jmp    fbff1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf91>
  100bdb:	nopl   0x0(%rax,%rax,1)
  100be0:	mov    0xc0(%r14),%rax
  100be7:	xor    %edx,%edx
  100be9:	movdqu 0xe0(%r14),%xmm1
  100bf2:	movdqu 0xf0(%r14),%xmm6
  100bfb:	movdqu 0x100(%r14),%xmm0
  100c04:	movdqu 0x110(%r14),%xmm5
  100c0d:	mov    %rax,-0x500(%rbp)
  100c14:	mov    0xd0(%r14),%eax
  100c1b:	punpckhqdq %xmm6,%xmm1
  100c1f:	movdqu 0x120(%r14),%xmm2
  100c28:	movdqu 0x130(%r14),%xmm4
  100c31:	punpckhqdq %xmm5,%xmm0
  100c35:	movaps %xmm1,-0x4e0(%rbp)
  100c3c:	mov    %rax,-0x4f8(%rbp)
  100c43:	mov    0x150(%r14),%rax
  100c4a:	punpckhqdq %xmm4,%xmm2
  100c4e:	movaps %xmm0,-0x4d0(%rbp)
  100c55:	movaps %xmm2,-0x4f0(%rbp)
  100c5c:	test   %rax,%rax
  100c5f:	jne    101bf8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6b98>
  100c65:	movq   0x118(%rbx),%xmm0
  100c6d:	mov    %rax,-0x4b8(%rbp)
  100c74:	xor    %eax,%eax
  100c76:	cmpq   $0x0,0x100(%rbx)
  100c7e:	mov    %rdx,-0x4c0(%rbp)
  100c85:	movhps 0xc0(%rbx),%xmm0
  100c8c:	movaps %xmm0,-0x4b0(%rbp)
  100c93:	jne    101bd0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6b70>
  100c99:	mov    -0xaa8(%rbp),%rsi
  100ca0:	movq   %rax,%xmm0
  100ca5:	movdqu 0x7b0(%rbx),%xmm1
  100cad:	movhps 0x33b0(%rbx),%xmm0
  100cb4:	movdqu 0x750(%rbx),%xmm6
  100cbc:	movdqu 0x770(%rbx),%xmm5
  100cc4:	movaps %xmm0,-0x4a0(%rbp)
  100ccb:	movq   %rsi,%xmm0
  100cd0:	movdqu 0x740(%rbx),%xmm7
  100cd8:	mov    0x788(%rbx),%rax
  100cdf:	movhps -0xaa0(%rbp),%xmm0
  100ce6:	movdqu 0x730(%rbx),%xmm2
  100cee:	punpckhqdq %xmm6,%xmm1
  100cf2:	movdqu 0x710(%rbx),%xmm3
  100cfa:	movaps %xmm0,-0x490(%rbp)
  100d01:	movdqu 0x760(%rbx),%xmm0
  100d09:	movdqu 0x720(%rbx),%xmm4
  100d11:	movaps %xmm1,-0x460(%rbp)
  100d18:	movd   -0xac8(%rbp),%xmm1
  100d20:	mov    -0xa80(%rbp),%rdx
  100d27:	punpckhqdq %xmm7,%xmm2
  100d2b:	punpckhqdq %xmm5,%xmm0
  100d2f:	mov    %rax,-0x440(%rbp)
  100d36:	movups 0x7c8(%rbx),%xmm7
  100d3d:	punpckhqdq %xmm4,%xmm3
  100d41:	movaps %xmm0,-0x450(%rbp)
  100d48:	movd   0x710(%rbx),%xmm0
  100d50:	mov    0x3f0(%rbx),%rax
  100d57:	mov    0x3d0(%rbx),%rcx
  100d5e:	mov    0x3e0(%rbx),%r8
  100d65:	mov    %rdx,-0x428(%rbp)
  100d6c:	punpcklqdq %xmm1,%xmm0
  100d70:	mov    %rax,-0x410(%rbp)
  100d77:	movups %xmm0,-0x438(%rbp)
  100d7e:	mov    %rcx,-0x408(%rbp)
  100d85:	mov    %r8,-0x400(%rbp)
  100d8c:	movaps %xmm3,-0x480(%rbp)
  100d93:	movaps %xmm2,-0x470(%rbp)
  100d9a:	movaps %xmm7,-0x420(%rbp)
  100da1:	mov    0x398(%rbx),%eax
  100da7:	mov    %rax,-0x3f8(%rbp)
  100dae:	mov    -0xaf8(%rbp),%rax
  100db5:	mov    (%rax),%rax
  100db8:	movq   %rax,%xmm0
  100dbd:	mov    %rax,-0xb38(%rbp)
  100dc4:	movhps 0x3060(%rbx),%xmm0
  100dcb:	movaps %xmm0,-0x3f0(%rbp)
  100dd2:	movss  0xf71a6(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  100dda:	divss  -0xae4(%rbp),%xmm0
  100de2:	movss  %xmm0,-0x3e0(%rbp)
  100dea:	jmp    fb81e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7be>
  100def:	nop
  100df0:	mov    0xf7199(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  100df7:	mov    -0xa78(%rbp),%rdi
  100dfe:	movl   $0x1,-0x8a0(%rbp)
  100e08:	mov    %rax,-0x8a8(%rbp)
  100e0f:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  100e14:	mov    %r15,-0x898(%rbp)
  100e1b:	mov    -0x8a0(%rbp),%ecx
  100e21:	mov    %r12,%r9
  100e24:	xor    %r8d,%r8d
  100e27:	mov    %eax,-0x89c(%rbp)
  100e2d:	mov    -0x8a8(%rbp),%rdx
  100e34:	mov    -0x89c(%rbp),%rdi
  100e3b:	mov    -0x894(%rbp),%esi
  100e41:	call   6efb0 <__cudaPushCallConfiguration@plt>
  100e46:	test   %eax,%eax
  100e48:	je     101c08 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6ba8>
  100e4e:	call   6c890 <cudaGetLastError@plt>
  100e53:	mov    %eax,%edi
  100e55:	lea    0xf4674(%rip),%rsi        # 1f54d0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x55d0>
  100e5c:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  100e61:	jmp    ffdeb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4d8b>
  100e66:	cs nopw 0x0(%rax,%rax,1)
  100e70:	mov    0xf7119(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  100e77:	mov    -0xa78(%rbp),%rdi
  100e7e:	movl   $0x1,-0x8a0(%rbp)
  100e88:	mov    %rax,-0x8a8(%rbp)
  100e8f:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  100e94:	mov    %r15,-0x898(%rbp)
  100e9b:	mov    -0x8a0(%rbp),%ecx
  100ea1:	mov    %r12,%r9
  100ea4:	xor    %r8d,%r8d
  100ea7:	mov    %eax,-0x89c(%rbp)
  100ead:	mov    -0x8a8(%rbp),%rdx
  100eb4:	mov    -0x89c(%rbp),%rdi
  100ebb:	mov    -0x894(%rbp),%esi
  100ec1:	call   6efb0 <__cudaPushCallConfiguration@plt>
  100ec6:	test   %eax,%eax
  100ec8:	je     101c70 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6c10>
  100ece:	call   6c890 <cudaGetLastError@plt>
  100ed3:	mov    %eax,%edi
  100ed5:	lea    0xf4624(%rip),%rsi        # 1f5500 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5600>
  100edc:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  100ee1:	jmp    ffdeb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4d8b>
  100ee6:	cs nopw 0x0(%rax,%rax,1)
  100ef0:	mov    0xf7099(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  100ef7:	mov    -0xaf0(%rbp),%r13
  100efe:	movl   $0x1,-0x8a0(%rbp)
  100f08:	mov    %rax,-0x8a8(%rbp)
  100f0f:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  100f14:	mov    %r15,-0x898(%rbp)
  100f1b:	mov    -0x8a0(%rbp),%ecx
  100f21:	mov    %r13,%r9
  100f24:	xor    %r8d,%r8d
  100f27:	mov    %eax,-0x89c(%rbp)
  100f2d:	mov    -0x8a8(%rbp),%rdx
  100f34:	mov    -0x89c(%rbp),%rdi
  100f3b:	mov    -0x894(%rbp),%esi
  100f41:	call   6efb0 <__cudaPushCallConfiguration@plt>
  100f46:	test   %eax,%eax
  100f48:	je     101e50 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6df0>
  100f4e:	call   6c890 <cudaGetLastError@plt>
  100f53:	mov    %eax,%edi
  100f55:	lea    0xf440c(%rip),%rsi        # 1f5368 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5468>
  100f5c:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  100f61:	jmp    fca90 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1a30>
  100f66:	cs nopw 0x0(%rax,%rax,1)
  100f70:	mov    0xf7019(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  100f77:	mov    -0xaf0(%rbp),%r13
  100f7e:	movl   $0x1,-0x8a0(%rbp)
  100f88:	mov    %rax,-0x8a8(%rbp)
  100f8f:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  100f94:	mov    %r15,-0x898(%rbp)
  100f9b:	mov    -0x8a0(%rbp),%ecx
  100fa1:	mov    %r13,%r9
  100fa4:	xor    %r8d,%r8d
  100fa7:	mov    %eax,-0x89c(%rbp)
  100fad:	mov    -0x8a8(%rbp),%rdx
  100fb4:	mov    -0x89c(%rbp),%rdi
  100fbb:	mov    -0x894(%rbp),%esi
  100fc1:	call   6efb0 <__cudaPushCallConfiguration@plt>
  100fc6:	test   %eax,%eax
  100fc8:	je     101dc0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6d60>
  100fce:	call   6c890 <cudaGetLastError@plt>
  100fd3:	mov    %eax,%edi
  100fd5:	lea    0xf442c(%rip),%rsi        # 1f5408 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5508>
  100fdc:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  100fe1:	jmp    fcbf8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1b98>
  100fe6:	cs nopw 0x0(%rax,%rax,1)
  100ff0:	mov    $0x1,%r15d
  100ff6:	jmp    fb2ff <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x29f>
  100ffb:	nopl   0x0(%rax,%rax,1)
  101000:	movss  0xc(%rbx),%xmm0
  101005:	pxor   %xmm7,%xmm7
  101009:	comiss %xmm7,%xmm0
  10100c:	jbe    fd07a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x201a>
  101012:	jmp    fef75 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3f15>
  101017:	nopw   0x0(%rax,%rax,1)
  101020:	test   %eax,%eax
  101022:	jne    fb638 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5d8>
  101028:	mov    0x710(%rbx),%eax
  10102e:	jmp    fb638 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5d8>
  101033:	nopl   0x0(%rax,%rax,1)
  101038:	mov    -0xa78(%rbp),%rdi
  10103f:	test   %rdi,%rdi
  101042:	je     fbf9a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf3a>
  101048:	mov    0xf6f41(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  10104f:	mov    -0xaf0(%rbp),%r12
  101056:	movl   $0x1,-0x638(%rbp)
  101060:	mov    %rax,-0x640(%rbp)
  101067:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  10106c:	mov    -0x638(%rbp),%ecx
  101072:	xor    %r8d,%r8d
  101075:	mov    %r12,%r9
  101078:	mov    %eax,-0x5a0(%rbp)
  10107e:	mov    -0x640(%rbp),%rdx
  101085:	movabs $0x100000001,%rax
  10108f:	mov    %rax,-0x59c(%rbp)
  101096:	mov    -0x5a0(%rbp),%rdi
  10109d:	mov    -0x598(%rbp),%esi
  1010a3:	call   6efb0 <__cudaPushCallConfiguration@plt>
  1010a8:	test   %eax,%eax
  1010aa:	je     102851 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x77f1>
  1010b0:	call   6c890 <cudaGetLastError@plt>
  1010b5:	lea    0xf3fbc(%rip),%rsi        # 1f5078 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5178>
  1010bc:	mov    %eax,%edi
  1010be:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  1010c3:	jmp    fbf9a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf3a>
  1010c8:	nopl   0x0(%rax,%rax,1)
  1010d0:	movq   $0x0,-0xb58(%rbp)
  1010db:	jmp    fd3a7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2347>
  1010e0:	mov    -0xaf0(%rbp),%r9
  1010e7:	mov    %r12,%rdi
  1010ea:	mov    0xf6e9f(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  1010f1:	movl   $0x1,-0x638(%rbp)
  1010fb:	mov    %r9,-0xbd8(%rbp)
  101102:	mov    %rax,-0x640(%rbp)
  101109:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  10110e:	mov    -0x638(%rbp),%ecx
  101114:	mov    -0xbd8(%rbp),%r9
  10111b:	xor    %r8d,%r8d
  10111e:	mov    %eax,-0x5a0(%rbp)
  101124:	mov    -0x640(%rbp),%rdx
  10112b:	movabs $0x100000001,%rax
  101135:	mov    %rax,-0x59c(%rbp)
  10113c:	mov    -0x5a0(%rbp),%rdi
  101143:	mov    -0x598(%rbp),%esi
  101149:	call   6efb0 <__cudaPushCallConfiguration@plt>
  10114e:	test   %eax,%eax
  101150:	je     101ec8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6e68>
  101156:	call   6c890 <cudaGetLastError@plt>
  10115b:	lea    0xf3fde(%rip),%rsi        # 1f5140 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5240>
  101162:	mov    %eax,%edi
  101164:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  101169:	jmp    fc0f2 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1092>
  10116e:	xchg   %ax,%ax
  101170:	mov    0xf6e19(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  101177:	mov    -0xaf0(%rbp),%r12
  10117e:	movl   $0x1,-0x638(%rbp)
  101188:	mov    %rax,-0x640(%rbp)
  10118f:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  101194:	mov    -0x638(%rbp),%ecx
  10119a:	xor    %r8d,%r8d
  10119d:	mov    %r12,%r9
  1011a0:	mov    %eax,-0x5a0(%rbp)
  1011a6:	mov    -0x640(%rbp),%rdx
  1011ad:	movabs $0x100000001,%rax
  1011b7:	mov    %rax,-0x59c(%rbp)
  1011be:	mov    -0x5a0(%rbp),%rdi
  1011c5:	mov    -0x598(%rbp),%esi
  1011cb:	call   6efb0 <__cudaPushCallConfiguration@plt>
  1011d0:	test   %eax,%eax
  1011d2:	je     102020 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6fc0>
  1011d8:	call   6c890 <cudaGetLastError@plt>
  1011dd:	lea    0xf3cfc(%rip),%rsi        # 1f4ee0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x4fe0>
  1011e4:	mov    %eax,%edi
  1011e6:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  1011eb:	mov    0x498(%rbx),%r8d
  1011f2:	mov    -0xa80(%rbp),%rdx
  1011f9:	mov    -0xaa8(%rbp),%rsi
  101200:	mov    0x3d0(%rbx),%rcx
  101207:	jmp    fb99d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x93d>
  10120c:	nopl   0x0(%rax)
  101210:	mov    $0x120,%edi
  101215:	movaps %xmm0,-0x170(%rbp)
  10121c:	movq   $0x0,-0x160(%rbp)
  101227:	movq   $0x0,-0x158(%rbp)
  101232:	call   6d150 <operator new(unsigned long)@plt>
  101237:	lea    -0xaa0(%rbp),%rcx
  10123e:	lea    -0xa78(%rbp),%rdx
  101245:	movdqa -0xb70(%rbp),%xmm4
  10124d:	mov    %r14,0xa8(%rax)
  101254:	movq   %rcx,%xmm0
  101259:	lea    -0xad0(%rbp),%rcx
  101260:	movq   %rdx,%xmm5
  101265:	movhps -0xb00(%rbp),%xmm0
  10126c:	lea    -0xabc(%rbp),%rdx
  101273:	movups %xmm4,0x20(%rax)
  101277:	movups %xmm0,(%rax)
  10127a:	movq   %rcx,%xmm0
  10127f:	lea    -0xacc(%rbp),%rcx
  101286:	movq   %rdx,%xmm7
  10128b:	punpcklqdq %xmm5,%xmm0
  10128f:	lea    -0xacf(%rbp),%rdx
  101296:	movups %xmm0,0x10(%rax)
  10129a:	movq   %rcx,%xmm0
  10129f:	movq   %rdx,%xmm6
  1012a4:	lea    -0xad2(%rbp),%rcx
  1012ab:	punpcklqdq %xmm7,%xmm0
  1012af:	lea    -0xa98(%rbp),%rdx
  1012b6:	movups %xmm0,0x30(%rax)
  1012ba:	movq   %rdx,%xmm5
  1012bf:	lea    -0xa60(%rbp),%rdx
  1012c6:	movq   -0xb90(%rbp),%xmm0
  1012ce:	movq   %rdx,%xmm4
  1012d3:	lea    -0xad1(%rbp),%rdx
  1012da:	punpcklqdq %xmm6,%xmm0
  1012de:	movups %xmm0,0x40(%rax)
  1012e2:	movq   %rcx,%xmm0
  1012e7:	lea    -0xac0(%rbp),%rcx
  1012ee:	punpcklqdq %xmm5,%xmm0
  1012f2:	movups %xmm0,0x50(%rax)
  1012f6:	movq   %r15,%xmm0
  1012fb:	punpcklqdq %xmm4,%xmm0
  1012ff:	movups %xmm0,0x60(%rax)
  101303:	movq   %rdx,%xmm0
  101308:	lea    -0xad5(%rbp),%rdx
  10130f:	movq   %rdx,%xmm7
  101314:	lea    -0xad9(%rbp),%rdx
  10131b:	punpcklqdq %xmm7,%xmm0
  10131f:	movups %xmm0,0x70(%rax)
  101323:	movq   %rcx,%xmm0
  101328:	mov    -0xb60(%rbp),%rcx
  10132f:	movhps -0xbb8(%rbp),%xmm0
  101336:	movups %xmm0,0x80(%rax)
  10133d:	movq   %rdx,%xmm0
  101342:	lea    -0x7b0(%rbp),%rdx
  101349:	movq   %rdx,%xmm6
  10134e:	lea    -0xad6(%rbp),%rdx
  101355:	mov    %rcx,0xb0(%rax)
  10135c:	lea    -0x116b3(%rip),%rcx        # efcb0 <std::_Function_handler<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >), synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}>::_M_manager(std::_Any_data&, std::_Any_data const&, std::_Manager_operation)>
  101363:	mov    %rdx,0xa0(%rax)
  10136a:	mov    -0xbc8(%rbp),%rdx
  101371:	punpcklqdq %xmm6,%xmm0
  101375:	movups %xmm0,0x90(%rax)
  10137c:	mov    %rdx,0xb8(%rax)
  101383:	lea    -0xada(%rbp),%rdx
  10138a:	mov    %rdx,0xc0(%rax)
  101391:	lea    -0xa88(%rbp),%rdx
  101398:	mov    %rdx,0xc8(%rax)
  10139f:	lea    -0xa90(%rbp),%rdx
  1013a6:	mov    %rdx,0xd0(%rax)
  1013ad:	lea    -0xace(%rbp),%rdx
  1013b4:	mov    %rdx,0xd8(%rax)
  1013bb:	lea    -0xa68(%rbp),%rdx
  1013c2:	mov    %rdx,0xe0(%rax)
  1013c9:	lea    -0xac4(%rbp),%rdx
  1013d0:	mov    %rdx,0xe8(%rax)
  1013d7:	lea    -0xacd(%rbp),%rdx
  1013de:	mov    %rdx,0xf0(%rax)
  1013e5:	lea    -0x850(%rbp),%rdx
  1013ec:	mov    %rdx,0xf8(%rax)
  1013f3:	lea    -0x7f0(%rbp),%rdx
  1013fa:	mov    %rdx,0x100(%rax)
  101401:	lea    -0x820(%rbp),%rdx
  101408:	mov    %rdx,0x108(%rax)
  10140f:	lea    -0xad7(%rbp),%rdx
  101416:	mov    %rdx,0x110(%rax)
  10141d:	lea    -0x3b0(%rbp),%rdx
  101424:	mov    %rdx,0x118(%rax)
  10142b:	lea    0x26fe(%rip),%rdx        # 103b30 <std::_Function_handler<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >), synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}>::_M_invoke(std::_Any_data const&, synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>&&, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >&&)>
  101432:	mov    %rax,-0x170(%rbp)
  101439:	movdqa -0x170(%rbp),%xmm0
  101441:	movq   %rdx,%xmm7
  101446:	movdqa -0x3d0(%rbp),%xmm5
  10144e:	movdqa -0x3c0(%rbp),%xmm4
  101456:	mov    -0x3c0(%rbp),%rax
  10145d:	movaps %xmm0,-0x3d0(%rbp)
  101464:	movq   %rcx,%xmm0
  101469:	punpcklqdq %xmm7,%xmm0
  10146d:	movaps %xmm5,-0x170(%rbp)
  101474:	movaps %xmm4,-0x160(%rbp)
  10147b:	movaps %xmm0,-0x3c0(%rbp)
  101482:	test   %rax,%rax
  101485:	je     fc11c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x10bc>
  10148b:	lea    -0x170(%rbp),%rdi
  101492:	mov    $0x3,%edx
  101497:	mov    %rdi,%rsi
  10149a:	call   *%rax
  10149c:	jmp    fc11c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x10bc>
  1014a1:	nopl   0x0(%rax)
  1014a8:	mov    0xf6ae1(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  1014af:	mov    0x10(%r14),%edi
  1014b3:	movl   $0x1,-0x638(%rbp)
  1014bd:	mov    -0xaf0(%rbp),%r12
  1014c4:	mov    %rax,-0x640(%rbp)
  1014cb:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  1014d0:	mov    -0x638(%rbp),%ecx
  1014d6:	xor    %r8d,%r8d
  1014d9:	mov    %r12,%r9
  1014dc:	mov    %eax,-0x5a0(%rbp)
  1014e2:	mov    -0x640(%rbp),%rdx
  1014e9:	movabs $0x100000001,%rax
  1014f3:	mov    %rax,-0x59c(%rbp)
  1014fa:	mov    -0x5a0(%rbp),%rdi
  101501:	mov    -0x598(%rbp),%esi
  101507:	call   6efb0 <__cudaPushCallConfiguration@plt>
  10150c:	test   %eax,%eax
  10150e:	je     101f00 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6ea0>
  101514:	call   6c890 <cudaGetLastError@plt>
  101519:	lea    0xf39e8(%rip),%rsi        # 1f4f08 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5008>
  101520:	mov    %eax,%edi
  101522:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  101527:	jmp    fbc4c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xbec>
  10152c:	nopl   0x0(%rax)
  101530:	mov    %rdx,%rax
  101533:	movss  0x74(%rbx),%xmm0
  101538:	mov    -0xaf0(%rbp),%rdx
  10153f:	lea    0x8f0(%rbx),%rdi
  101546:	mov    (%rax),%rsi
  101549:	call   6d650 <synreal::SelfCollision::begin_frame(glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)@plt>
  10154e:	jmp    fbc3f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xbdf>
  101553:	nopl   0x0(%rax,%rax,1)
  101558:	mov    0xf6a31(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  10155f:	mov    0x10(%r14),%edi
  101563:	movl   $0x1,-0x8a0(%rbp)
  10156d:	mov    %rax,-0x8a8(%rbp)
  101574:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  101579:	mov    %eax,-0x89c(%rbp)
  10157f:	mov    -0x8a0(%rbp),%ecx
  101585:	mov    %r12,%r9
  101588:	xor    %r8d,%r8d
  10158b:	movabs $0x100000001,%rax
  101595:	mov    -0x8a8(%rbp),%rdx
  10159c:	mov    %rax,-0x898(%rbp)
  1015a3:	mov    -0x89c(%rbp),%rdi
  1015aa:	mov    -0x894(%rbp),%esi
  1015b0:	call   6efb0 <__cudaPushCallConfiguration@plt>
  1015b5:	test   %eax,%eax
  1015b7:	je     101d90 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6d30>
  1015bd:	call   6c890 <cudaGetLastError@plt>
  1015c2:	mov    %eax,%edi
  1015c4:	lea    0xf4635(%rip),%rsi        # 1f5c00 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5d00>
  1015cb:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  1015d0:	mov    -0xaf0(%rbp),%r12
  1015d7:	jmp    fe0be <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x305e>
  1015dc:	nopl   0x0(%rax)
  1015e0:	mov    0x5d4(%rbx),%r12d
  1015e7:	imul   -0xa80(%rbp),%r12
  1015ef:	movl   $0x1,-0x8a0(%rbp)
  1015f9:	mov    0xf6990(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  101600:	mov    -0xaf0(%rbp),%r13
  101607:	mov    %r12,%rdi
  10160a:	mov    %rax,-0x8a8(%rbp)
  101611:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  101616:	mov    %eax,-0x89c(%rbp)
  10161c:	mov    -0x8a0(%rbp),%ecx
  101622:	mov    %r13,%r9
  101625:	xor    %r8d,%r8d
  101628:	movabs $0x100000001,%rax
  101632:	mov    -0x8a8(%rbp),%rdx
  101639:	mov    %rax,-0x898(%rbp)
  101640:	mov    -0x89c(%rbp),%rdi
  101647:	mov    -0x894(%rbp),%esi
  10164d:	call   6efb0 <__cudaPushCallConfiguration@plt>
  101652:	test   %eax,%eax
  101654:	je     101d08 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6ca8>
  10165a:	call   6c890 <cudaGetLastError@plt>
  10165f:	mov    %eax,%edi
  101661:	lea    0xf4610(%rip),%rsi        # 1f5c78 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5d78>
  101668:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  10166d:	jmp    fe1f9 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3199>
  101672:	nopw   0x0(%rax,%rax,1)
  101678:	mov    0xf6911(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  10167f:	mov    -0xb80(%rbp),%rdi
  101686:	movl   $0x1,-0x638(%rbp)
  101690:	mov    -0xaf0(%rbp),%r12
  101697:	mov    %rax,-0x640(%rbp)
  10169e:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  1016a3:	mov    -0x638(%rbp),%ecx
  1016a9:	xor    %r8d,%r8d
  1016ac:	mov    %r12,%r9
  1016af:	mov    %eax,-0x5a0(%rbp)
  1016b5:	mov    -0x640(%rbp),%rdx
  1016bc:	movabs $0x100000001,%rax
  1016c6:	mov    %rax,-0x59c(%rbp)
  1016cd:	mov    -0x5a0(%rbp),%rdi
  1016d4:	mov    -0x598(%rbp),%esi
  1016da:	call   6efb0 <__cudaPushCallConfiguration@plt>
  1016df:	test   %eax,%eax
  1016e1:	je     101fb0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6f50>
  1016e7:	call   6c890 <cudaGetLastError@plt>
  1016ec:	lea    0xf394d(%rip),%rsi        # 1f5040 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5140>
  1016f3:	mov    %eax,%edi
  1016f5:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  1016fa:	jmp    fbf8d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf2d>
  1016ff:	nop
  101700:	mov    0xf6889(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  101707:	mov    -0xa88(%rbp),%rdi
  10170e:	movl   $0x1,-0x638(%rbp)
  101718:	mov    -0xaf0(%rbp),%r12
  10171f:	mov    %rax,-0x640(%rbp)
  101726:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  10172b:	mov    -0x638(%rbp),%ecx
  101731:	xor    %r8d,%r8d
  101734:	mov    %r12,%r9
  101737:	mov    %eax,-0x5a0(%rbp)
  10173d:	mov    -0x640(%rbp),%rdx
  101744:	movabs $0x100000001,%rax
  10174e:	mov    %rax,-0x59c(%rbp)
  101755:	mov    -0x5a0(%rbp),%rdi
  10175c:	mov    -0x598(%rbp),%esi
  101762:	call   6efb0 <__cudaPushCallConfiguration@plt>
  101767:	test   %eax,%eax
  101769:	je     101f68 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6f08>
  10176f:	call   6c890 <cudaGetLastError@plt>
  101774:	lea    0xf386d(%rip),%rsi        # 1f4fe8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x50e8>
  10177b:	mov    %eax,%edi
  10177d:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  101782:	jmp    fbf43 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xee3>
  101787:	nopw   0x0(%rax,%rax,1)
  101790:	mov    0xf67f9(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  101797:	mov    -0xaa8(%rbp),%rdi
  10179e:	movl   $0x1,-0x638(%rbp)
  1017a8:	mov    -0xaf0(%rbp),%r12
  1017af:	mov    %rax,-0x640(%rbp)
  1017b6:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  1017bb:	mov    -0x638(%rbp),%ecx
  1017c1:	xor    %r8d,%r8d
  1017c4:	mov    %r12,%r9
  1017c7:	mov    %eax,-0x5a0(%rbp)
  1017cd:	mov    -0x640(%rbp),%rdx
  1017d4:	movabs $0x100000001,%rax
  1017de:	mov    %rax,-0x59c(%rbp)
  1017e5:	mov    -0x5a0(%rbp),%rdi
  1017ec:	mov    -0x598(%rbp),%esi
  1017f2:	call   6efb0 <__cudaPushCallConfiguration@plt>
  1017f7:	test   %eax,%eax
  1017f9:	je     101f30 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6ed0>
  1017ff:	call   6c890 <cudaGetLastError@plt>
  101804:	lea    0xf3755(%rip),%rsi        # 1f4f60 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5060>
  10180b:	mov    %eax,%edi
  10180d:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  101812:	jmp    fbcf4 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xc94>
  101817:	nopw   0x0(%rax,%rax,1)
  101820:	lea    0x8f0(%rbx),%rdi
  101827:	call   6d680 <synreal::SelfCollision::available() const@plt>
  10182c:	mov    0x4f0(%rbx),%ecx
  101832:	mov    -0xa80(%rbp),%rdx
  101839:	jmp    fbb6c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xb0c>
  10183e:	xchg   %ax,%ax
  101840:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  101845:	mov    %r15,-0x898(%rbp)
  10184c:	mov    -0x8a0(%rbp),%ecx
  101852:	mov    %r12,%r9
  101855:	xor    %r8d,%r8d
  101858:	mov    %eax,-0x89c(%rbp)
  10185e:	mov    -0x8a8(%rbp),%rdx
  101865:	mov    -0x89c(%rbp),%rdi
  10186c:	mov    -0x894(%rbp),%esi
  101872:	call   6efb0 <__cudaPushCallConfiguration@plt>
  101877:	test   %eax,%eax
  101879:	je     102070 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7010>
  10187f:	call   6c890 <cudaGetLastError@plt>
  101884:	mov    %eax,%edi
  101886:	lea    0xf3f6b(%rip),%rsi        # 1f57f8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x58f8>
  10188d:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  101892:	jmp    fd3a7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2347>
  101897:	nopw   0x0(%rax,%rax,1)
  1018a0:	mov    0x398(%rbx),%eax
  1018a6:	mov    0x3370(%rbx),%rcx
  1018ad:	mov    %r13d,%r8d
  1018b0:	mov    0x3350(%rbx),%rdx
  1018b7:	mov    0x3d0(%rbx),%rsi
  1018be:	push   -0xaa8(%rbp)
  1018c4:	and    $0x1,%r8d
  1018c8:	mov    -0xa78(%rbp),%r9
  1018cf:	push   %rax
  1018d0:	mov    -0xb18(%rbp),%rax
  1018d7:	mov    (%rax),%rdi
  1018da:	call   6ae10 <synreal::kernel::update_affine_body_so3_augmented_lagrangian_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, bool, unsigned long, unsigned long, unsigned long)@plt>
  1018df:	pop    %rsi
  1018e0:	pop    %rdi
  1018e1:	jmp    100b27 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5ac7>
  1018e6:	cs nopw 0x0(%rax,%rax,1)
  1018f0:	movq   $0x0,-0xbf8(%rbp)
  1018fb:	mov    0xf668e(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  101902:	mov    %r13,%rdi
  101905:	movl   $0x1,-0x8a0(%rbp)
  10190f:	mov    %rax,-0x8a8(%rbp)
  101916:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  10191b:	mov    %r15,-0x898(%rbp)
  101922:	mov    -0x8a0(%rbp),%ecx
  101928:	mov    %r12,%r9
  10192b:	xor    %r8d,%r8d
  10192e:	mov    %eax,-0x89c(%rbp)
  101934:	mov    -0x8a8(%rbp),%rdx
  10193b:	mov    -0x89c(%rbp),%rdi
  101942:	mov    -0x894(%rbp),%esi
  101948:	call   6efb0 <__cudaPushCallConfiguration@plt>
  10194d:	test   %eax,%eax
  10194f:	jne    1019dd <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x697d>
  101955:	sub    $0x8,%rsp
  101959:	mov    -0xaf8(%rbp),%rax
  101960:	mov    0x34b0(%rbx),%rcx
  101967:	mov    0x570(%rbx),%rdx
  10196e:	mov    0x3d0(%rbx),%rsi
  101975:	push   -0xaa0(%rbp)
  10197b:	movss  -0xac4(%rbp),%xmm0
  101983:	push   -0xaa8(%rbp)
  101989:	mov    0x34f0(%rbx),%r9
  101990:	push   -0xbe0(%rbp)
  101996:	mov    0x34d0(%rbx),%r8
  10199d:	push   %r13
  10199f:	push   -0xb60(%rbp)
  1019a5:	push   -0xb70(%rbp)
  1019ab:	push   -0xb90(%rbp)
  1019b1:	push   -0xb58(%rbp)
  1019b7:	push   $0x1
  1019b9:	push   -0xbf8(%rbp)
  1019bf:	push   0x5b0(%rbx)
  1019c5:	push   0x5a0(%rbx)
  1019cb:	push   0x590(%rbx)
  1019d1:	mov    (%rax),%rdi
  1019d4:	call   6adb0 <synreal::kernel::add_body_point_line_gauss_newton_hessian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, unsigned long, bool, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
  1019d9:	add    $0x70,%rsp
  1019dd:	call   6c890 <cudaGetLastError@plt>
  1019e2:	mov    %eax,%edi
  1019e4:	lea    0xf3d3d(%rip),%rsi        # 1f5728 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5828>
  1019eb:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  1019f0:	mov    -0xaf0(%rbp),%r12
  1019f7:	jmp    fd1d0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2170>
  1019fc:	nopl   0x0(%rax)
  101a00:	movzbl 0x3340(%rbx),%r13d
  101a08:	mov    %r13b,-0xb40(%rbp)
  101a0f:	test   %r13b,%r13b
  101a12:	jne    fc0a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1040>
  101a18:	mov    0x17e8(%rbx),%r10d
  101a1f:	test   %r10d,%r10d
  101a22:	jne    1020b0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7050>
  101a28:	mov    0x2180(%rbx),%r9d
  101a2f:	test   %r9d,%r9d
  101a32:	jne    1020b0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7050>
  101a38:	or     %esi,%ecx
  101a3a:	mov    %cl,-0xb40(%rbp)
  101a40:	mov    %ecx,%r13d
  101a43:	test   %cl,%cl
  101a45:	jne    fc0a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1040>
  101a4b:	or     -0xada(%rbp),%r8b
  101a52:	mov    %r8b,-0xb40(%rbp)
  101a59:	mov    %r8d,%r13d
  101a5c:	jne    fc0a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1040>
  101a62:	or     -0xad7(%rbp),%dl
  101a68:	mov    %dl,-0xb40(%rbp)
  101a6e:	mov    %edx,%r13d
  101a71:	jne    fc0a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1040>
  101a77:	movzbl -0xad4(%rbp),%r13d
  101a7f:	movzbl -0xb58(%rbp),%ecx
  101a86:	or     %r13d,%ecx
  101a89:	mov    %cl,-0xb40(%rbp)
  101a8f:	jmp    fc0a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1040>
  101a94:	nopl   0x0(%rax)
  101a98:	movss  0xc(%rbx),%xmm0
  101a9d:	pxor   %xmm5,%xmm5
  101aa1:	comiss %xmm5,%xmm0
  101aa4:	jbe    fc00e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xfae>
  101aaa:	mov    -0xb74(%rbp),%r11d
  101ab1:	movb   $0x1,-0xbd0(%rbp)
  101ab8:	test   %r11d,%r11d
  101abb:	setne  %sil
  101abf:	jmp    fc017 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xfb7>
  101ac4:	nopl   0x0(%rax)
  101ac8:	mov    0x2db0(%rbx),%rdi
  101acf:	test   %rdi,%rdi
  101ad2:	jne    102368 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7308>
  101ad8:	mov    -0xb30(%rbp),%ecx
  101ade:	mov    0x398(%rbx),%eax
  101ae4:	lea    -0x2(%rcx),%edx
  101ae7:	cmp    $0x1,%edx
  101aea:	ja     100bb0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5b50>
  101af0:	cmpl   $0x3,-0xb30(%rbp)
  101af7:	movb   $0x0,-0xad0(%rbp)
  101afe:	jne    1025f7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7597>
  101b04:	movss  0xc(%rbx),%xmm0
  101b09:	pxor   %xmm6,%xmm6
  101b0d:	mov    $0x1,%edi
  101b12:	comiss %xmm6,%xmm0
  101b15:	seta   %dl
  101b18:	mov    %edx,%r13d
  101b1b:	jmp    fbff1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf91>
  101b20:	mov    0x7a8(%rbx),%rax
  101b27:	jmp    fe388 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3328>
  101b2c:	nopl   0x0(%rax)
  101b30:	mov    0x798(%rbx),%rax
  101b37:	jmp    fe371 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3311>
  101b3c:	nopl   0x0(%rax)
  101b40:	lea    0x0(,%rdi,4),%rdx
  101b48:	mov    0x30(%rax),%rsi
  101b4c:	mov    %r12,%r8
  101b4f:	mov    0x3280(%rbx),%rdi
  101b56:	mov    $0x3,%ecx
  101b5b:	call   6e0b0 <cudaMemcpyAsync@plt>
  101b60:	lea    0xf3421(%rip),%rsi        # 1f4f88 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5088>
  101b67:	mov    %eax,%edi
  101b69:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  101b6e:	jmp    fbf36 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xed6>
  101b73:	nopl   0x0(%rax,%rax,1)
  101b78:	mov    0x710(%rbx),%r9d
  101b7f:	test   %r9d,%r9d
  101b82:	je     fb712 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6b2>
  101b88:	movzbl 0x4c(%rbx),%r8d
  101b8d:	movb   $0x1,-0xad9(%rbp)
  101b94:	test   %r8b,%r8b
  101b97:	jne    1020c8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7068>
  101b9d:	mov    $0x1,%r8d
  101ba3:	jmp    fb71c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6bc>
  101ba8:	nopl   0x0(%rax,%rax,1)
  101bb0:	movaps %xmm3,%xmm4
  101bb3:	jmp    fbde1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xd81>
  101bb8:	nopl   0x0(%rax,%rax,1)
  101bc0:	mov    0xf8(%rbx),%rax
  101bc7:	jmp    fbdbd <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xd5d>
  101bcc:	nopl   0x0(%rax)
  101bd0:	mov    0xf8(%rbx),%rax
  101bd7:	jmp    100c99 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5c39>
  101bdc:	nopl   0x0(%rax)
  101be0:	imul   %r12,%rax
  101be4:	cmp    %rdx,%rax
  101be7:	jbe    fb392 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x332>
  101bed:	jmp    76678 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x96>
  101bf2:	nopw   0x0(%rax,%rax,1)
  101bf8:	mov    0x148(%r14),%rdx
  101bff:	jmp    100c65 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5c05>
  101c04:	nopl   0x0(%rax)
  101c08:	movss  0xc(%rbx),%xmm0
  101c0d:	mulss  -0xacc(%rbp),%xmm0
  101c15:	sub    $0x8,%rsp
  101c19:	mov    -0xaf8(%rbp),%rax
  101c20:	mov    0x3040(%rbx),%rcx
  101c27:	mov    0x3a0(%rbx),%rdx
  101c2e:	mov    0x3d0(%rbx),%rsi
  101c35:	push   -0xaa8(%rbp)
  101c3b:	mov    0x398(%rbx),%r9d
  101c42:	mov    -0xa78(%rbp),%r8
  101c49:	mov    (%rax),%rdi
  101c4c:	call   6a7d0 <synreal::kernel::evaluate_affine_body_spring_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  101c51:	pop    %r9
  101c53:	pop    %r10
  101c55:	jmp    100e4e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5dee>
  101c5a:	nopw   0x0(%rax,%rax,1)
  101c60:	mov    0x148(%r14),%rax
  101c67:	jmp    fd48f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x242f>
  101c6c:	nopl   0x0(%rax)
  101c70:	mov    0x398(%rbx),%eax
  101c76:	movss  0xc(%rbx),%xmm0
  101c7b:	sub    $0x8,%rsp
  101c7f:	mulss  -0xacc(%rbp),%xmm0
  101c87:	mov    0x3350(%rbx),%rcx
  101c8e:	mov    0x3a0(%rbx),%rdx
  101c95:	mov    0x3d0(%rbx),%rsi
  101c9c:	push   -0xaa8(%rbp)
  101ca2:	mov    0x3040(%rbx),%r9
  101ca9:	push   %rax
  101caa:	mov    -0xaf8(%rbp),%rax
  101cb1:	push   -0xa78(%rbp)
  101cb7:	mov    0x3370(%rbx),%r8
  101cbe:	mov    (%rax),%rdi
  101cc1:	call   6ad20 <synreal::kernel::evaluate_affine_body_so3_augmented_lagrangian_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  101cc6:	add    $0x20,%rsp
  101cca:	jmp    100ece <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5e6e>
  101ccf:	nop
  101cd0:	movss  0x64(%rbx),%xmm0
  101cd5:	comiss %xmm6,%xmm0
  101cd8:	seta   -0xb45(%rbp)
  101cdf:	jmp    fb85b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7fb>
  101ce4:	nopl   0x0(%rax)
  101ce8:	cmpq   $0x0,0x110(%rbx)
  101cf0:	je     fbe21 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xdc1>
  101cf6:	mov    0x108(%rbx),%rdx
  101cfd:	jmp    fbe21 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xdc1>
  101d02:	nopw   0x0(%rax,%rax,1)
  101d08:	mov    0x5d4(%rbx),%eax
  101d0e:	sub    $0x8,%rsp
  101d12:	mov    0x3d0(%rbx),%rcx
  101d19:	mov    0x3260(%rbx),%rdx
  101d20:	mov    0x3240(%rbx),%rsi
  101d27:	push   -0xaa8(%rbp)
  101d2d:	mov    0x5f0(%rbx),%r9
  101d34:	push   %rax
  101d35:	mov    -0xb18(%rbp),%rax
  101d3c:	mov    0x5e0(%rbx),%r8
  101d43:	push   %r12
  101d45:	push   0x35f0(%rbx)
  101d4b:	push   0x35d0(%rbx)
  101d51:	push   0x35b0(%rbx)
  101d57:	push   0x3590(%rbx)
  101d5d:	push   0x3570(%rbx)
  101d63:	push   0x630(%rbx)
  101d69:	push   0x620(%rbx)
  101d6f:	push   0x600(%rbx)
  101d75:	mov    (%rax),%rdi
  101d78:	call   6aa50 <synreal::kernel::update_joint_drive_angle_state(glm::vec<3, float, (glm::qualifier)0> const*, float*, int*, glm::vec<4, int, (glm::qualifier)0> const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, unsigned long, unsigned long, unsigned long)@plt>
  101d7d:	add    $0x60,%rsp
  101d81:	jmp    10165a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x65fa>
  101d86:	cs nopw 0x0(%rax,%rax,1)
  101d90:	sub    $0x140,%rsp
  101d97:	mov    -0xba0(%rbp),%rsi
  101d9e:	mov    $0x27,%ecx
  101da3:	mov    %rsp,%rdi
  101da6:	rep movsq %ds:(%rsi),%es:(%rdi)
  101da9:	call   6a8c0 <synreal::kernel::snapshot_hard_contacts(synreal::kernel::HardContactView)@plt>
  101dae:	add    $0x140,%rsp
  101db5:	jmp    1015bd <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x655d>
  101dba:	nopw   0x0(%rax,%rax,1)
  101dc0:	mov    0x56c(%rbx),%eax
  101dc6:	sub    $0x8,%rsp
  101dca:	mov    0x34b0(%rbx),%rcx
  101dd1:	mov    0x570(%rbx),%rdx
  101dd8:	mov    0x3d0(%rbx),%rsi
  101ddf:	push   -0xaa8(%rbp)
  101de5:	movss  -0xac4(%rbp),%xmm0
  101ded:	push   %rax
  101dee:	mov    0x568(%rbx),%eax
  101df4:	mov    0x34f0(%rbx),%r9
  101dfb:	mov    0x34d0(%rbx),%r8
  101e02:	push   %rax
  101e03:	mov    -0xaf8(%rbp),%rax
  101e0a:	push   -0xa68(%rbp)
  101e10:	push   %r12
  101e12:	push   0x3530(%rbx)
  101e18:	push   0x3550(%rbx)
  101e1e:	push   0x3510(%rbx)
  101e24:	push   0x5b0(%rbx)
  101e2a:	push   0x5a0(%rbx)
  101e30:	push   0x590(%rbx)
  101e36:	mov    (%rax),%rdi
  101e39:	call   6ab20 <synreal::kernel::evaluate_joint_body_point_line_augmented_lagrangian_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
  101e3e:	add    $0x60,%rsp
  101e42:	jmp    100fce <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5f6e>
  101e47:	nopw   0x0(%rax,%rax,1)
  101e50:	mov    0x49c(%rbx),%eax
  101e56:	mov    0x4b0(%rbx),%rcx
  101e5d:	mov    0x4a0(%rbx),%rdx
  101e64:	mov    0x3d0(%rbx),%rsi
  101e6b:	push   -0xaa8(%rbp)
  101e71:	movss  -0xac4(%rbp),%xmm0
  101e79:	push   %rax
  101e7a:	mov    0x498(%rbx),%eax
  101e80:	push   %rax
  101e81:	mov    -0xaf8(%rbp),%rax
  101e88:	push   -0xba8(%rbp)
  101e8e:	push   %r12
  101e90:	push   0x3410(%rbx)
  101e96:	mov    0x4c0(%rbx),%r8
  101e9d:	mov    (%rax),%rdi
  101ea0:	push   0x4d0(%rbx)
  101ea6:	push   0x33f0(%rbx)
  101eac:	mov    0x33d0(%rbx),%r9
  101eb3:	call   6a870 <synreal::kernel::evaluate_joint_body_spring_augmented_lagrangian_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
  101eb8:	add    $0x40,%rsp
  101ebc:	jmp    100f4e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5eee>
  101ec1:	nopl   0x0(%rax)
  101ec8:	mov    -0xb98(%rbp),%rax
  101ecf:	mov    -0xaa0(%rbp),%r9
  101ed6:	mov    0x2dc0(%rbx),%r8
  101edd:	mov    0x20(%rax),%rcx
  101ee1:	mov    0x28(%rax),%rdx
  101ee5:	mov    0x10(%rax),%rdi
  101ee9:	mov    (%rax),%rsi
  101eec:	call   6a900 <synreal::kernel::initialize_block_non_diagonal(synreal::NonZeroEntry const*, int const*, unsigned long, unsigned long, synreal::BlockNonZeroEntry*, unsigned long)@plt>
  101ef1:	jmp    101156 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x60f6>
  101ef6:	cs nopw 0x0(%rax,%rax,1)
  101f00:	sub    $0x140,%rsp
  101f07:	mov    -0xba0(%rbp),%rsi
  101f0e:	mov    $0x27,%ecx
  101f13:	mov    %rsp,%rdi
  101f16:	rep movsq %ds:(%rsi),%es:(%rdi)
  101f19:	call   6ad90 <synreal::kernel::initialize_hard_contacts(synreal::kernel::HardContactView)@plt>
  101f1e:	add    $0x140,%rsp
  101f25:	jmp    101514 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x64b4>
  101f2a:	nopw   0x0(%rax,%rax,1)
  101f30:	mov    0x2e20(%rbx),%rcx
  101f37:	mov    0x2ce0(%rbx),%rdx
  101f3e:	mov    0x2cc0(%rbx),%rsi
  101f45:	mov    0x3a0(%rbx),%rdi
  101f4c:	mov    -0xaa8(%rbp),%r9
  101f53:	mov    0x2e40(%rbx),%r8
  101f5a:	call   6ade0 <synreal::kernel::refresh_inertial_cache_diagonals(float const*, unsigned long const*, int const*, float*, float*, unsigned long)@plt>
  101f5f:	jmp    1017ff <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x679f>
  101f64:	nopl   0x0(%rax)
  101f68:	sub    $0x8,%rsp
  101f6c:	mov    0x32a8(%rbx),%rsi
  101f73:	mov    0x3060(%rbx),%rdi
  101f7a:	mov    0x3308(%rbx),%rcx
  101f81:	mov    0x32e8(%rbx),%rdx
  101f88:	push   -0xaa8(%rbp)
  101f8e:	mov    -0xa90(%rbp),%r9
  101f95:	mov    -0xa88(%rbp),%r8
  101f9c:	call   6ab00 <synreal::kernel::initialize_triangle_drag(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, float*, unsigned long, unsigned long, unsigned long)@plt>
  101fa1:	pop    %rsi
  101fa2:	pop    %rdi
  101fa3:	jmp    10176f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x670f>
  101fa8:	nopl   0x0(%rax,%rax,1)
  101fb0:	mov    0x4f0(%rbx),%eax
  101fb6:	sub    $0x8,%rsp
  101fba:	mov    0x508(%rbx),%rcx
  101fc1:	mov    0x4f8(%rbx),%rdx
  101fc8:	mov    0x3d0(%rbx),%rsi
  101fcf:	push   -0xaa8(%rbp)
  101fd5:	push   %rax
  101fd6:	mov    -0xaf8(%rbp),%rax
  101fdd:	push   -0xb80(%rbp)
  101fe3:	push   0x3490(%rbx)
  101fe9:	push   0x3470(%rbx)
  101fef:	mov    0x518(%rbx),%r8
  101ff6:	push   0x558(%rbx)
  101ffc:	mov    (%rax),%rdi
  101fff:	push   0x3450(%rbx)
  102005:	mov    0x3430(%rbx),%r9
  10200c:	call   6ad00 <synreal::kernel::initialize_body_distance_constraint_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  102011:	add    $0x40,%rsp
  102015:	jmp    1016e7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6687>
  10201a:	nopw   0x0(%rax,%rax,1)
  102020:	movss  0x60(%rbx),%xmm0
  102025:	mov    0x400(%rbx),%ecx
  10202b:	xor    %r9d,%r9d
  10202e:	mov    0x3140(%rbx),%rdx
  102035:	mov    0x3120(%rbx),%rsi
  10203c:	mov    0x438(%rbx),%rdi
  102043:	movss  0x70(%rbx),%xmm4
  102048:	push   $0x0
  10204a:	movss  0x6c(%rbx),%xmm3
  10204f:	movss  0x68(%rbx),%xmm2
  102054:	push   $0x1
  102056:	movss  0x64(%rbx),%xmm1
  10205b:	mov    -0xa70(%rbp),%r8
  102062:	call   6aa80 <synreal::kernel::prepare_cable_penalties(glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0>*, int*, unsigned long, unsigned long, float, float, float, float, float, bool, bool, int const*)@plt>
  102067:	pop    %r9
  102069:	pop    %r10
  10206b:	jmp    1011d8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6178>
  102070:	push   -0xb58(%rbp)
  102076:	mov    $0x27,%ecx
  10207b:	mov    %r13,%r9
  10207e:	xor    %edx,%edx
  102080:	mov    -0x798(%rbp),%rsi
  102087:	sub    $0x138,%rsp
  10208e:	mov    %rsp,%rdi
  102091:	rep movsq %ds:(%rsi),%es:(%rdi)
  102094:	xor    %esi,%esi
  102096:	xor    %edi,%edi
  102098:	mov    -0xb70(%rbp),%r8
  10209f:	call   6ae80 <synreal::kernel::evaluate_hard_contacts(synreal::kernel::HardContactView, glm::vec<3, float, (glm::qualifier)0>*, float*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, float*)@plt>
  1020a4:	add    $0x140,%rsp
  1020ab:	jmp    10187f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x681f>
  1020b0:	movb   $0x1,-0xb40(%rbp)
  1020b7:	mov    $0x1,%r13d
  1020bd:	jmp    fc0a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1040>
  1020c2:	nopw   0x0(%rax,%rax,1)
  1020c8:	lea    -0x2b0(%rbp),%rdi
  1020cf:	xor    %eax,%eax
  1020d1:	mov    $0x27,%ecx
  1020d6:	movb   $0x1,-0xad8(%rbp)
  1020dd:	mov    %rdi,-0xba0(%rbp)
  1020e4:	rep stos %rax,%es:(%rdi)
  1020e7:	mov    0xf5eaa(%rip),%rax        # 1f7f98 <cuda::std::__4::in_place+0x4b>
  1020ee:	movl   $0x3f733333,-0x1c4(%rbp)
  1020f8:	movb   $0x1,-0x1b2(%rbp)
  1020ff:	mov    %rax,-0x1bc(%rbp)
  102106:	mov    %esi,%eax
  102108:	cmp    0x3170(%rbx),%rax
  10210f:	ja     102720 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x76c0>
  102115:	lea    -0x500(%rbp),%rcx
  10211c:	mov    %rcx,-0xbb8(%rbp)
  102123:	movdqu 0x40(%r14),%xmm7
  102129:	movdqu 0x60(%r14),%xmm6
  10212f:	mov    %rax,-0x2a8(%rbp)
  102136:	movdqu 0x30(%r14),%xmm3
  10213c:	movdqu 0x50(%r14),%xmm2
  102142:	movdqu 0x80(%r14),%xmm5
  10214b:	movdqu 0x70(%r14),%xmm1
  102151:	punpckhqdq %xmm6,%xmm2
  102155:	movdqu 0x10(%r14),%xmm4
  10215b:	punpckhqdq %xmm7,%xmm3
  10215f:	movdqu 0x20(%r14),%xmm6
  102165:	movdqu 0xa0(%r14),%xmm7
  10216e:	punpckhqdq %xmm5,%xmm1
  102172:	mov    (%r14),%rcx
  102175:	movaps %xmm2,-0x280(%rbp)
  10217c:	movdqu 0x90(%r14),%xmm0
  102185:	movdqu 0x740(%rbx),%xmm5
  10218d:	punpckhqdq %xmm6,%xmm4
  102191:	movaps %xmm1,-0x270(%rbp)
  102198:	movdqu 0x730(%rbx),%xmm1
  1021a0:	movaps %xmm4,-0x2a0(%rbp)
  1021a7:	movdqu 0x760(%rbx),%xmm4
  1021af:	punpckhqdq %xmm7,%xmm0
  1021b3:	mov    0x788(%rbx),%rax
  1021ba:	movdqu 0x720(%rbx),%xmm7
  1021c2:	mov    %rcx,-0x2b0(%rbp)
  1021c9:	movaps %xmm0,-0x260(%rbp)
  1021d0:	movdqu 0x750(%rbx),%xmm0
  1021d8:	punpckhqdq %xmm5,%xmm1
  1021dc:	movdqu 0x710(%rbx),%xmm2
  1021e4:	movaps %xmm1,-0x240(%rbp)
  1021eb:	movd   -0xac8(%rbp),%xmm1
  1021f3:	punpckhqdq %xmm4,%xmm0
  1021f7:	mov    %rax,-0x220(%rbp)
  1021fe:	mov    -0xa80(%rbp),%rax
  102205:	punpckhqdq %xmm7,%xmm2
  102209:	movaps %xmm0,-0x230(%rbp)
  102210:	movd   %r9d,%xmm0
  102215:	punpcklqdq %xmm1,%xmm0
  102219:	movaps %xmm2,-0x250(%rbp)
  102220:	movups %xmm0,-0x218(%rbp)
  102227:	movaps %xmm3,-0x290(%rbp)
  10222e:	mov    %rax,-0x208(%rbp)
  102235:	mov    0x3e0(%rbx),%rax
  10223c:	movdqu 0x3f0(%rbx),%xmm0
  102244:	movdqu 0x3d0(%rbx),%xmm6
  10224c:	mov    %rax,-0x1f0(%rbp)
  102253:	mov    -0xaf8(%rbp),%rax
  10225a:	punpcklqdq %xmm6,%xmm0
  10225e:	movss  0x58(%rbx),%xmm2
  102263:	movss  0x54(%rbx),%xmm1
  102268:	mov    (%rax),%rax
  10226b:	movaps %xmm0,-0x200(%rbp)
  102272:	movd   %edx,%xmm0
  102276:	movdqu 0x3180(%rbx),%xmm5
  10227e:	movhps -0xaa8(%rbp),%xmm0
  102285:	unpcklps %xmm2,%xmm1
  102288:	movss  0x50(%rbx),%xmm2
  10228d:	movdqu 0x31c0(%rbx),%xmm4
  102295:	movups %xmm0,-0x1e8(%rbp)
  10229c:	movq   %rax,%xmm0
  1022a1:	movhps 0x3060(%rbx),%xmm0
  1022a8:	mov    %rax,-0xb38(%rbp)
  1022af:	xor    %eax,%eax
  1022b1:	mov    0x4d(%rbx),%al
  1022b4:	movups %xmm0,-0x1d8(%rbp)
  1022bb:	movss  0xf5cbd(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  1022c3:	mov    0x4e(%rbx),%ah
  1022c6:	divss  -0xae4(%rbp),%xmm0
  1022ce:	unpcklps %xmm2,%xmm0
  1022d1:	movlhps %xmm1,%xmm0
  1022d4:	mov    %ax,-0x1b4(%rbp)
  1022db:	movzbl 0xb8(%r14),%eax
  1022e3:	movups %xmm0,-0x1c8(%rbp)
  1022ea:	movss  0x5c(%rbx),%xmm0
  1022ef:	mov    %al,-0x1b2(%rbp)
  1022f5:	movss  %xmm0,-0x1b8(%rbp)
  1022fd:	movdqu 0x3160(%rbx),%xmm0
  102305:	punpcklqdq %xmm5,%xmm0
  102309:	movaps %xmm0,-0x1b0(%rbp)
  102310:	movdqu 0x31a0(%rbx),%xmm0
  102318:	punpcklqdq %xmm4,%xmm0
  10231c:	movaps %xmm0,-0x1a0(%rbp)
  102323:	movdqu 0x31e0(%rbx),%xmm0
  10232b:	movdqu 0x3200(%rbx),%xmm7
  102333:	mov    0x3220(%rbx),%rax
  10233a:	punpcklqdq %xmm7,%xmm0
  10233e:	mov    %rax,-0x180(%rbp)
  102345:	movaps %xmm0,-0x190(%rbp)
  10234c:	jmp    fb768 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x708>
  102351:	nopl   0x0(%rax)
  102358:	mov    $0x1,%edi
  10235d:	jmp    fbfe3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf83>
  102362:	nopw   0x0(%rax,%rax,1)
  102368:	mov    0xf5c21(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  10236f:	mov    -0xaf0(%rbp),%r12
  102376:	movl   $0x1,-0x638(%rbp)
  102380:	mov    %rax,-0x640(%rbp)
  102387:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  10238c:	mov    -0x638(%rbp),%ecx
  102392:	xor    %r8d,%r8d
  102395:	mov    %r12,%r9
  102398:	mov    %eax,-0x5a0(%rbp)
  10239e:	mov    -0x640(%rbp),%rdx
  1023a5:	movabs $0x100000001,%rax
  1023af:	mov    %rax,-0x59c(%rbp)
  1023b6:	mov    -0x5a0(%rbp),%rdi
  1023bd:	mov    -0x598(%rbp),%esi
  1023c3:	call   6efb0 <__cudaPushCallConfiguration@plt>
  1023c8:	test   %eax,%eax
  1023ca:	jne    10244a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x73ea>
  1023cc:	cmpl   $0x1,-0xb1c(%rbp)
  1023d3:	mov    0x2db0(%rbx),%r11
  1023da:	pxor   %xmm4,%xmm4
  1023de:	mov    0x2da0(%rbx),%r10
  1023e5:	mov    0x2d80(%rbx),%rax
  1023ec:	mov    0x2d60(%rbx),%r9
  1023f3:	mov    0x2d40(%rbx),%r8
  1023fa:	mov    0x2d20(%rbx),%rcx
  102401:	mov    0x2d00(%rbx),%rdx
  102408:	mov    0x2c20(%rbx),%rsi
  10240f:	mov    0x2c00(%rbx),%rdi
  102416:	movss  0xc(%rbx),%xmm3
  10241b:	jne    102849 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x77e9>
  102421:	sub    $0x8,%rsp
  102425:	movss  -0xb10(%rbp),%xmm1
  10242d:	movaps %xmm3,%xmm5
  102430:	pxor   %xmm2,%xmm2
  102434:	push   %r11
  102436:	movss  -0xacc(%rbp),%xmm0
  10243e:	push   %r10
  102440:	push   %rax
  102441:	call   6ac20 <synreal::kernel::combine_system_non_diagonal(float, float, float, float, float, float, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry*, unsigned long)@plt>
  102446:	add    $0x20,%rsp
  10244a:	call   6c890 <cudaGetLastError@plt>
  10244f:	lea    0xf2cba(%rip),%rsi        # 1f5110 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5210>
  102456:	mov    %eax,%edi
  102458:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  10245d:	jmp    100b90 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5b30>
  102462:	nopw   0x0(%rax,%rax,1)
  102468:	mov    0x3220(%rbx),%rdi
  10246f:	mov    %r12,%rcx
  102472:	mov    $0x4,%edx
  102477:	xor    %esi,%esi
  102479:	call   6e930 <cudaMemsetAsync@plt>
  10247e:	mov    %eax,%edi
  102480:	lea    0xf37a1(%rip),%rsi        # 1f5c28 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5d28>
  102487:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  10248c:	jmp    1015d0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6570>
  102491:	nopl   0x0(%rax)
  102498:	sub    $0x8,%rsp
  10249c:	mov    0x3a0(%rbx),%rcx
  1024a3:	mov    0x2c60(%rbx),%rdx
  1024aa:	mov    0x2c40(%rbx),%rsi
  1024b1:	mov    0xe8(%rbx),%rdi
  1024b8:	push   0x2c30(%rbx)
  1024be:	mov    0x2ca0(%rbx),%r9
  1024c5:	push   0x2d00(%rbx)
  1024cb:	mov    0x2c80(%rbx),%r8
  1024d2:	push   0x2c20(%rbx)
  1024d8:	call   6a960 <synreal::kernel::refresh_inertial_cache_nonzeros(float const*, unsigned long const*, int const*, float const*, unsigned long const*, int const*, synreal::NonZeroEntry*, synreal::NonZeroEntry*, unsigned long)@plt>
  1024dd:	add    $0x20,%rsp
  1024e1:	jmp    fbcd3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xc73>
  1024e6:	cs nopw 0x0(%rax,%rax,1)
  1024f0:	mov    -0x790(%rbp),%rax
  1024f7:	mov    -0x7a8(%rbp),%rdi
  1024fe:	sub    $0x8,%rsp
  102502:	mov    -0x770(%rbp),%rdx
  102509:	mov    -0x768(%rbp),%r10
  102510:	mov    0x48(%rdi),%r9
  102514:	mov    0x38(%rdi),%r8
  102518:	mov    0x28(%rdi),%rcx
  10251c:	mov    0x10(%rdi),%esi
  10251f:	movss  0x48(%rax),%xmm0
  102524:	movss  0xf5a54(%rip),%xmm1        # 1f7f80 <cuda::std::__4::in_place+0x33>
  10252c:	divss  (%rdx),%xmm1
  102530:	mov    0x18(%rdi),%rdx
  102534:	push   %r13
  102536:	push   -0xb70(%rbp)
  10253c:	push   (%r10)
  10253f:	mov    -0x778(%rbp),%r10
  102546:	push   $0x0
  102548:	push   $0x0
  10254a:	push   0x3060(%rax)
  102550:	push   (%r10)
  102553:	mov    0x398(%rax),%r10d
  10255a:	push   %r10
  10255c:	push   0x3e0(%rax)
  102562:	push   0x3d0(%rax)
  102568:	push   0x3f0(%rax)
  10256e:	mov    -0x780(%rbp),%r10
  102575:	push   (%r10)
  102578:	mov    -0x788(%rbp),%r10
  10257f:	mov    (%r10),%r10d
  102582:	push   %r10
  102584:	mov    0x710(%rax),%r10d
  10258b:	push   %r10
  10258d:	push   0x788(%rax)
  102593:	push   0x778(%rax)
  102599:	push   0x768(%rax)
  10259f:	push   0x758(%rax)
  1025a5:	push   0x748(%rax)
  1025ab:	push   0x738(%rax)
  1025b1:	push   0x728(%rax)
  1025b7:	push   0x718(%rax)
  1025bd:	push   0x98(%rdi)
  1025c3:	push   0x88(%rdi)
  1025c9:	push   0x78(%rdi)
  1025cc:	push   0x68(%rdi)
  1025cf:	push   0x58(%rdi)
  1025d2:	mov    (%rdi),%rdi
  1025d5:	call   6aed0 <synreal::kernel::evaluate_contact_tangent(int const*, unsigned long, int const*, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, int const*, int const*, synreal::Transform const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float const*, float const*, float, unsigned long, unsigned long, unsigned long, int const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, unsigned long, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, float, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  1025da:	add    $0xe0,%rsp
  1025e1:	jmp    100510 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x54b0>
  1025e6:	cs nopw 0x0(%rax,%rax,1)
  1025f0:	movb   $0x0,-0xad0(%rbp)
  1025f7:	xor    %r13d,%r13d
  1025fa:	xor    %edx,%edx
  1025fc:	mov    $0x1,%edi
  102601:	jmp    fbff1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf91>
  102606:	cs nopw 0x0(%rax,%rax,1)
  102610:	mov    0xf5979(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  102617:	mov    -0xaf0(%rbp),%r12
  10261e:	movl   $0x1,-0x638(%rbp)
  102628:	mov    %rax,-0x640(%rbp)
  10262f:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  102634:	mov    -0x638(%rbp),%ecx
  10263a:	xor    %r8d,%r8d
  10263d:	mov    %r12,%r9
  102640:	mov    %eax,-0x5a0(%rbp)
  102646:	mov    -0x640(%rbp),%rdx
  10264d:	movabs $0x100000001,%rax
  102657:	mov    %rax,-0x59c(%rbp)
  10265e:	mov    -0x5a0(%rbp),%rdi
  102665:	mov    -0x598(%rbp),%esi
  10266b:	call   6efb0 <__cudaPushCallConfiguration@plt>
  102670:	test   %eax,%eax
  102672:	je     102894 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7834>
  102678:	call   6c890 <cudaGetLastError@plt>
  10267d:	lea    0xf2a54(%rip),%rsi        # 1f50d8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x51d8>
  102684:	mov    %eax,%edi
  102686:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  10268b:	jmp    fbfc1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf61>
  102690:	mov    0xf58f9(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  102697:	mov    -0xba8(%rbp),%rdi
  10269e:	movl   $0x1,-0x638(%rbp)
  1026a8:	mov    -0xaf0(%rbp),%r12
  1026af:	mov    %rax,-0x640(%rbp)
  1026b6:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  1026bb:	mov    -0x638(%rbp),%ecx
  1026c1:	xor    %r8d,%r8d
  1026c4:	mov    %r12,%r9
  1026c7:	mov    %eax,-0x5a0(%rbp)
  1026cd:	mov    -0x640(%rbp),%rdx
  1026d4:	movabs $0x100000001,%rax
  1026de:	mov    %rax,-0x59c(%rbp)
  1026e5:	mov    -0x5a0(%rbp),%rdi
  1026ec:	mov    -0x598(%rbp),%esi
  1026f2:	call   6efb0 <__cudaPushCallConfiguration@plt>
  1026f7:	test   %eax,%eax
  1026f9:	je     10290b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78ab>
  1026ff:	call   6c890 <cudaGetLastError@plt>
  102704:	lea    0xf299d(%rip),%rsi        # 1f50a8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x51a8>
  10270b:	mov    %eax,%edi
  10270d:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  102712:	jmp    fbfb1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf51>
  102717:	nopw   0x0(%rax,%rax,1)
  102720:	lea    -0x500(%rbp),%rax
  102727:	mov    -0xaf0(%rbp),%rdi
  10272e:	mov    %rax,%rsi
  102731:	mov    %rax,-0xbb8(%rbp)
  102738:	call   6d710 <cudaStreamIsCapturing@plt>
  10273d:	lea    0xf271c(%rip),%rsi        # 1f4e60 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x4f60>
  102744:	mov    %eax,%edi
  102746:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  10274b:	mov    -0x500(%rbp),%r12d
  102752:	test   %r12d,%r12d
  102755:	jne    765e2 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]>
  10275b:	mov    (%rbx),%rax
  10275e:	mov    0x10(%r14),%esi
  102762:	mov    %rbx,%rdi
  102765:	call   *0x18(%rax)
  102768:	mov    0x10(%r14),%eax
  10276c:	mov    0x710(%rbx),%r9d
  102773:	mov    0x398(%rbx),%edx
  102779:	movzbl -0xad9(%rbp),%r8d
  102781:	mov    %rax,%rsi
  102784:	jmp    102123 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x70c3>
  102789:	nopl   0x0(%rax)
  102790:	movss  0xc(%rbx),%xmm0
  102795:	pxor   %xmm4,%xmm4
  102799:	movzbl -0xb58(%rbp),%r11d
  1027a1:	comiss %xmm4,%xmm0
  1027a4:	cmovbe %r11d,%edx
  1027a8:	mov    %dl,-0xb10(%rbp)
  1027ae:	jmp    fc05b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xffb>
  1027b3:	nopl   0x0(%rax,%rax,1)
  1027b8:	mov    -0xaf0(%rbp),%r12
  1027bf:	jmp    fe0a3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3043>
  1027c4:	mov    -0xaf8(%rbp),%rax
  1027cb:	sub    $0x8,%rsp
  1027cf:	mov    0x3280(%rbx),%rdx
  1027d6:	mov    0x3060(%rbx),%rdi
  1027dd:	mov    0x10(%rax),%rsi
  1027e1:	push   -0x6f0(%rbp)
  1027e7:	push   -0x6f8(%rbp)
  1027ed:	push   -0x700(%rbp)
  1027f3:	push   -0x708(%rbp)
  1027f9:	push   -0x710(%rbp)
  1027ff:	push   -0x718(%rbp)
  102805:	push   -0x720(%rbp)
  10280b:	push   -0x728(%rbp)
  102811:	push   -0x730(%rbp)
  102817:	push   -0x738(%rbp)
  10281d:	push   -0x740(%rbp)
  102823:	push   -0x748(%rbp)
  102829:	push   -0x750(%rbp)
  10282f:	push   -0x758(%rbp)
  102835:	push   -0x760(%rbp)
  10283b:	call   6ab90 <synreal::kernel::initialize_joint_coordinate_velocities(synreal::kernel::JointCoordinateView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float*)@plt>
  102840:	sub    $0xffffffffffffff80,%rsp
  102844:	jmp    fbf23 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xec3>
  102849:	movaps %xmm3,%xmm4
  10284c:	jmp    102421 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x73c1>
  102851:	mov    -0xaf8(%rbp),%rax
  102858:	sub    $0x8,%rsp
  10285c:	mov    0x3350(%rbx),%rdx
  102863:	mov    0x3370(%rbx),%rcx
  10286a:	mov    0x3d0(%rbx),%rsi
  102871:	push   -0xaa8(%rbp)
  102877:	mov    (%rax),%rdi
  10287a:	mov    0x398(%rbx),%r9d
  102881:	mov    -0xa78(%rbp),%r8
  102888:	call   6af90 <synreal::kernel::initialize_affine_body_so3_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  10288d:	pop    %rax
  10288e:	pop    %rdx
  10288f:	jmp    1010b0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6050>
  102894:	mov    0x56c(%rbx),%eax
  10289a:	sub    $0x8,%rsp
  10289e:	mov    0x34b0(%rbx),%rcx
  1028a5:	mov    0x570(%rbx),%rdx
  1028ac:	mov    0x3d0(%rbx),%rsi
  1028b3:	push   -0xaa8(%rbp)
  1028b9:	mov    0x34f0(%rbx),%r9
  1028c0:	push   %rax
  1028c1:	mov    0x568(%rbx),%eax
  1028c7:	mov    0x34d0(%rbx),%r8
  1028ce:	push   %rax
  1028cf:	mov    -0xaf8(%rbp),%rax
  1028d6:	push   -0xa68(%rbp)
  1028dc:	push   0x3530(%rbx)
  1028e2:	push   0x3550(%rbx)
  1028e8:	push   0x3510(%rbx)
  1028ee:	push   0x5a0(%rbx)
  1028f4:	push   0x590(%rbx)
  1028fa:	mov    (%rax),%rdi
  1028fd:	call   6a9c0 <synreal::kernel::initialize_joint_body_point_line_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
  102902:	add    $0x50,%rsp
  102906:	jmp    102678 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7618>
  10290b:	mov    0x3410(%rbx),%rdi
  102912:	mov    -0xba8(%rbp),%rsi
  102919:	call   6ab60 <synreal::kernel::initialize_joint_body_spring_state(glm::vec<3, float, (glm::qualifier)0>*, unsigned long)@plt>
  10291e:	jmp    1026ff <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x769f>
  102923:	call   6d5c0 <__stack_chk_fail@plt>
  102928:	jmp    768b5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x2d3>
  10292d:	endbr64 
  102931:	mov    %rax,%rbx
  102934:	jmp    767b5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x1d3>
  102939:	jmp    76d8e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x7ac>
  10293e:	jmp    76c6a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x688>
  102943:	jmp    768fe <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x31c>
  102948:	jmp    76a22 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x440>
  10294d:	jmp    76ab4 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x4d2>
  102952:	jmp    76afd <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x51b>
  102957:	jmp    76b46 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x564>
  10295c:	jmp    76b8f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x5ad>
  102961:	jmp    76c9c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x6ba>
  102966:	jmp    76eb2 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x8d0>
  10296b:	jmp    76dc0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x7de>
  102970:	jmp    76e52 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x870>
  102975:	endbr64 
  102979:	mov    %rax,%rbx
  10297c:	jmp    76798 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x1b6>
  102981:	jmp    76f2d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x94b>
  102986:	jmp    767da <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x1f8>
  10298b:	nop
  10298c:	nopl   0x0(%rax)

0000000000102990 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]>:
  102990:	push   %r15
  102992:	push   %r14
  102994:	push   %r13
  102996:	push   %r12
  102998:	mov    %rsi,%r12
  10299b:	xor    %esi,%esi
  10299d:	push   %rbp
  10299e:	mov    %rdx,%rbp
  1029a1:	push   %rbx
  1029a2:	mov    %rdi,%rbx
  1029a5:	sub    $0x78,%rsp
  1029a9:	mov    (%rdi),%rax
  1029ac:	mov    0x8(%rdi),%rcx
  1029b0:	mov    %rbp,%rdi
  1029b3:	mov    (%rax),%rax
  1029b6:	mov    (%rcx),%rcx
  1029b9:	lea    (%rax,%rax,2),%rdx
  1029bd:	shl    $0x2,%rdx
  1029c1:	call   6e930 <cudaMemsetAsync@plt>
  1029c6:	lea    0xf32d3(%rip),%rsi        # 1f5ca0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5da0>
  1029cd:	mov    %eax,%edi
  1029cf:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  1029d4:	mov    0x10(%rbx),%rax
  1029d8:	cmpb   $0x0,(%rax)
  1029db:	jne    103320 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x990>
  1029e1:	mov    0x48(%rbx),%rax
  1029e5:	cmpb   $0x0,(%rax)
  1029e8:	jne    1032a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x910>
  1029ee:	mov    0x50(%rbx),%rax
  1029f2:	cmpb   $0x0,(%rax)
  1029f5:	jne    103220 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x890>
  1029fb:	mov    0x28(%rbx),%rdi
  1029ff:	cmpb   $0x0,0x3340(%rdi)
  102a06:	jne    1031a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x810>
  102a0c:	mov    0x70(%rbx),%rax
  102a10:	cmpb   $0x0,(%rax)
  102a13:	jne    103178 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x7e8>
  102a19:	mov    0x17e8(%rdi),%esi
  102a1f:	test   %esi,%esi
  102a21:	jne    103150 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x7c0>
  102a27:	mov    0x2180(%rdi),%ecx
  102a2d:	test   %ecx,%ecx
  102a2f:	jne    103130 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x7a0>
  102a35:	mov    0x78(%rbx),%rax
  102a39:	cmpb   $0x0,(%rax)
  102a3c:	jne    1030b0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x720>
  102a42:	mov    0x28(%rbx),%rax
  102a46:	cmpb   $0x0,0x41(%rax)
  102a4a:	je     102a6c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0xdc>
  102a4c:	mov    0x90(%rbx),%rax
  102a53:	cmpb   $0x0,(%rax)
  102a56:	jne    1033a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0xa10>
  102a5c:	mov    0xa0(%rbx),%rax
  102a63:	cmpb   $0x0,(%rax)
  102a66:	jne    102c40 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x2b0>
  102a6c:	mov    0xc0(%rbx),%rax
  102a73:	cmpb   $0x0,(%rax)
  102a76:	jne    102e20 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x490>
  102a7c:	mov    0xd8(%rbx),%rax
  102a83:	cmpb   $0x0,(%rax)
  102a86:	jne    102ea5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x515>
  102a8c:	mov    0xf0(%rbx),%rax
  102a93:	cmpb   $0x0,(%rax)
  102a96:	jne    102f2a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x59a>
  102a9c:	mov    0xf8(%rbx),%r13
  102aa3:	mov    0x0(%r13),%rax
  102aa7:	cmpb   $0x0,0x3298(%rax)
  102aae:	jne    103030 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x6a0>
  102ab4:	mov    0x100(%rbx),%r13
  102abb:	mov    0x0(%r13),%rax
  102abf:	cmpb   $0x0,(%rax)
  102ac2:	jne    102fb8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x628>
  102ac8:	mov    0x108(%rbx),%r13
  102acf:	mov    0x0(%r13),%rax
  102ad3:	cmpb   $0x0,(%rax)
  102ad6:	je     102ae6 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x156>
  102ad8:	mov    0x8(%r13),%rax
  102adc:	cmpq   $0x0,0x6d8(%rax)
  102ae4:	jne    102b08 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x178>
  102ae6:	mov    0x110(%rbx),%rax
  102aed:	cmpb   $0x0,(%rax)
  102af0:	jne    102bb3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x223>
  102af6:	add    $0x78,%rsp
  102afa:	pop    %rbx
  102afb:	pop    %rbp
  102afc:	pop    %r12
  102afe:	pop    %r13
  102b00:	pop    %r14
  102b02:	pop    %r15
  102b04:	ret    
  102b05:	nopl   (%rax)
  102b08:	movq   0x6f0(%rax),%xmm0
  102b10:	movl   $0x1,0x30(%rsp)
  102b18:	movq   0x6d0(%rax),%xmm1
  102b20:	movhps 0x700(%rax),%xmm0
  102b27:	movhps 0x6e0(%rax),%xmm1
  102b2e:	mov    0x18(%r13),%rax
  102b32:	movaps %xmm0,0x60(%rsp)
  102b37:	movaps %xmm1,0x50(%rsp)
  102b3c:	mov    (%rax),%r14
  102b3f:	mov    0xf544a(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  102b46:	mov    %rax,0x28(%rsp)
  102b4b:	mov    0x10(%r13),%rax
  102b4f:	mov    0x68(%rax),%rdi
  102b53:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  102b58:	mov    0x30(%rsp),%ecx
  102b5c:	xor    %r8d,%r8d
  102b5f:	mov    %r14,%r9
  102b62:	mov    %eax,0x40(%rsp)
  102b66:	mov    0x28(%rsp),%rdx
  102b6b:	movabs $0x100000001,%rax
  102b75:	mov    %rax,0x44(%rsp)
  102b7a:	mov    0x40(%rsp),%rdi
  102b7f:	mov    0x48(%rsp),%esi
  102b83:	call   6efb0 <__cudaPushCallConfiguration@plt>
  102b88:	test   %eax,%eax
  102b8a:	je     103910 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0xf80>
  102b90:	call   6c890 <cudaGetLastError@plt>
  102b95:	lea    0xf2914(%rip),%rsi        # 1f54b0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x55b0>
  102b9c:	mov    %eax,%edi
  102b9e:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  102ba3:	mov    0x110(%rbx),%rax
  102baa:	cmpb   $0x0,(%rax)
  102bad:	je     102af6 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x166>
  102bb3:	mov    0x8(%rbx),%rax
  102bb7:	movl   $0x1,0x20(%rsp)
  102bbf:	mov    (%rax),%r13
  102bc2:	mov    0xf53c7(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  102bc9:	mov    %rax,0x18(%rsp)
  102bce:	mov    0xa8(%rbx),%rax
  102bd5:	mov    0x10(%rax),%edi
  102bd8:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  102bdd:	mov    0x20(%rsp),%ecx
  102be1:	xor    %r8d,%r8d
  102be4:	mov    %r13,%r9
  102be7:	mov    %eax,0x34(%rsp)
  102beb:	mov    0x18(%rsp),%rdx
  102bf0:	movabs $0x100000001,%rax
  102bfa:	mov    %rax,0x38(%rsp)
  102bff:	mov    0x34(%rsp),%rdi
  102c04:	mov    0x3c(%rsp),%esi
  102c08:	call   6efb0 <__cudaPushCallConfiguration@plt>
  102c0d:	test   %eax,%eax
  102c0f:	je     103598 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0xc08>
  102c15:	call   6c890 <cudaGetLastError@plt>
  102c1a:	add    $0x78,%rsp
  102c1e:	lea    0xf325b(%rip),%rsi        # 1f5e80 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5f80>
  102c25:	pop    %rbx
  102c26:	mov    %eax,%edi
  102c28:	pop    %rbp
  102c29:	pop    %r12
  102c2b:	pop    %r13
  102c2d:	pop    %r14
  102c2f:	pop    %r15
  102c31:	jmp    6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  102c36:	cs nopw 0x0(%rax,%rax,1)
  102c40:	mov    0x78(%rbx),%rax
  102c44:	cmpb   $0x0,(%rax)
  102c47:	je     102c5e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x2ce>
  102c49:	mov    0xa8(%rbx),%rax
  102c50:	cmpq   $0x0,0x150(%rax)
  102c58:	je     102a6c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0xdc>
  102c5e:	mov    0xf532b(%rip),%rdx        # 1f7f90 <cuda::std::__4::in_place+0x43>
  102c65:	mov    0x8(%rbx),%rax
  102c69:	xor    %r8d,%r8d
  102c6c:	movabs $0x100000001,%rcx
  102c76:	mov    %rcx,0x54(%rsp)
  102c7b:	mov    0x58(%rsp),%esi
  102c7f:	mov    $0x1,%ecx
  102c84:	mov    %rdx,0x40(%rsp)
  102c89:	mov    0x80(%rbx),%rdx
  102c90:	mov    (%rax),%r9
  102c93:	movl   $0x1,0x48(%rsp)
  102c9b:	mov    (%rdx),%edx
  102c9d:	mov    %edx,0x50(%rsp)
  102ca1:	mov    0x50(%rsp),%rdi
  102ca6:	movabs $0x100000100,%rdx
  102cb0:	call   6efb0 <__cudaPushCallConfiguration@plt>
  102cb5:	test   %eax,%eax
  102cb7:	jne    102dfd <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x46d>
  102cbd:	mov    0x78(%rbx),%rdx
  102cc1:	mov    0x28(%rbx),%rax
  102cc5:	mov    0xa8(%rbx),%rdi
  102ccc:	cmpb   $0x0,(%rdx)
  102ccf:	mov    0x3060(%rax),%r14
  102cd6:	mov    0x108(%rdi),%r13
  102cdd:	movss  0x7d4(%rax),%xmm4
  102ce5:	movss  0x7d0(%rax),%xmm3
  102ced:	mov    0x788(%rax),%r11
  102cf4:	mov    0x778(%rax),%r10
  102cfb:	jne    1039f8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x1068>
  102d01:	movq   $0x0,0x8(%rsp)
  102d0a:	xor    %r15d,%r15d
  102d0d:	mov    0x60(%rbx),%rdx
  102d11:	mov    0x118(%rdi),%r9
  102d18:	mov    0xf8(%rdi),%r8
  102d1f:	mov    0xe8(%rdi),%rcx
  102d26:	mov    0xd0(%rdi),%esi
  102d2c:	movss  0x7cc(%rax),%xmm2
  102d34:	movss  0x7c8(%rax),%xmm1
  102d3c:	movss  0xf523c(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  102d44:	divss  (%rdx),%xmm0
  102d48:	mov    0xd8(%rdi),%rdx
  102d4f:	mov    0xc0(%rdi),%rdi
  102d56:	push   %r14
  102d58:	push   %r13
  102d5a:	push   %r11
  102d5c:	push   %r10
  102d5e:	mov    (%rbx),%r10
  102d61:	push   %r15
  102d63:	push   0x30(%rsp)
  102d67:	push   (%r10)
  102d6a:	mov    0x40(%rbx),%r10
  102d6e:	push   (%r10)
  102d71:	mov    0x20(%rbx),%r10
  102d75:	push   %rbp
  102d76:	push   %r12
  102d78:	push   (%r10)
  102d7b:	mov    0x398(%rax),%r10d
  102d82:	push   %r10
  102d84:	push   0x3e0(%rax)
  102d8a:	mov    0xb8(%rbx),%r10
  102d91:	push   0x3d0(%rax)
  102d97:	push   0x3f0(%rax)
  102d9d:	push   (%r10)
  102da0:	mov    0xb0(%rbx),%r10
  102da7:	mov    (%r10),%r10d
  102daa:	push   %r10
  102dac:	mov    0x710(%rax),%r10d
  102db3:	push   %r10
  102db5:	push   0x768(%rax)
  102dbb:	push   0x758(%rax)
  102dc1:	push   0x7b8(%rax)
  102dc7:	push   0x33b0(%rax)
  102dcd:	push   0xc0(%rax)
  102dd3:	push   0x748(%rax)
  102dd9:	push   0x738(%rax)
  102ddf:	push   0x728(%rax)
  102de5:	push   0x718(%rax)
  102deb:	push   0x118(%rax)
  102df1:	call   6a9a0 <synreal::kernel::multiply_soft_contact_hessian_off_diagonal(int const*, unsigned long, int const*, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, int const*, int const*, synreal::Transform const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, int const*, float const*, float const*, float const*, unsigned long, unsigned long, unsigned long, int const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, unsigned long, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, float, unsigned long, float, float, unsigned long, int const*, unsigned long, float const*, float const*, float, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*)@plt>
  102df6:	add    $0xe0,%rsp
  102dfd:	call   6c890 <cudaGetLastError@plt>
  102e02:	lea    0xf2fbf(%rip),%rsi        # 1f5dc8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5ec8>
  102e09:	mov    %eax,%edi
  102e0b:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  102e10:	mov    0xc0(%rbx),%rax
  102e17:	cmpb   $0x0,(%rax)
  102e1a:	je     102a7c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0xec>
  102e20:	mov    0x8(%rbx),%rax
  102e24:	movl   $0x1,0x48(%rsp)
  102e2c:	mov    (%rax),%r13
  102e2f:	mov    0xf515a(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  102e36:	mov    %rax,0x40(%rsp)
  102e3b:	mov    0xc8(%rbx),%rax
  102e42:	mov    (%rax),%rdi
  102e45:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  102e4a:	mov    0x48(%rsp),%ecx
  102e4e:	xor    %r8d,%r8d
  102e51:	mov    %r13,%r9
  102e54:	mov    %eax,0x50(%rsp)
  102e58:	mov    0x40(%rsp),%rdx
  102e5d:	movabs $0x100000001,%rax
  102e67:	mov    %rax,0x54(%rsp)
  102e6c:	mov    0x50(%rsp),%rdi
  102e71:	mov    0x58(%rsp),%esi
  102e75:	call   6efb0 <__cudaPushCallConfiguration@plt>
  102e7a:	test   %eax,%eax
  102e7c:	je     103550 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0xbc0>
  102e82:	call   6c890 <cudaGetLastError@plt>
  102e87:	lea    0xf2f72(%rip),%rsi        # 1f5e00 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5f00>
  102e8e:	mov    %eax,%edi
  102e90:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  102e95:	mov    0xd8(%rbx),%rax
  102e9c:	cmpb   $0x0,(%rax)
  102e9f:	je     102a8c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0xfc>
  102ea5:	mov    0x8(%rbx),%rax
  102ea9:	movl   $0x1,0x48(%rsp)
  102eb1:	mov    (%rax),%r13
  102eb4:	mov    0xf50d5(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  102ebb:	mov    %rax,0x40(%rsp)
  102ec0:	mov    0xe0(%rbx),%rax
  102ec7:	mov    (%rax),%rdi
  102eca:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  102ecf:	mov    0x48(%rsp),%ecx
  102ed3:	xor    %r8d,%r8d
  102ed6:	mov    %r13,%r9
  102ed9:	mov    %eax,0x50(%rsp)
  102edd:	mov    0x40(%rsp),%rdx
  102ee2:	movabs $0x100000001,%rax
  102eec:	mov    %rax,0x54(%rsp)
  102ef1:	mov    0x50(%rsp),%rdi
  102ef6:	mov    0x58(%rsp),%esi
  102efa:	call   6efb0 <__cudaPushCallConfiguration@plt>
  102eff:	test   %eax,%eax
  102f01:	je     1037c0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0xe30>
  102f07:	call   6c890 <cudaGetLastError@plt>
  102f0c:	lea    0xf2f15(%rip),%rsi        # 1f5e28 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5f28>
  102f13:	mov    %eax,%edi
  102f15:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  102f1a:	mov    0xf0(%rbx),%rax
  102f21:	cmpb   $0x0,(%rax)
  102f24:	je     102a9c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x10c>
  102f2a:	mov    0x28(%rbx),%rax
  102f2e:	movl   $0x1,0x48(%rsp)
  102f36:	mov    0x5d4(%rax),%r13d
  102f3d:	mov    0xb8(%rbx),%rax
  102f44:	imul   (%rax),%r13
  102f48:	mov    0x8(%rbx),%rax
  102f4c:	mov    (%rax),%r14
  102f4f:	mov    0xf503a(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  102f56:	mov    %r13,%rdi
  102f59:	mov    %rax,0x40(%rsp)
  102f5e:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  102f63:	mov    0x48(%rsp),%ecx
  102f67:	xor    %r8d,%r8d
  102f6a:	mov    %r14,%r9
  102f6d:	mov    %eax,0x50(%rsp)
  102f71:	mov    0x40(%rsp),%rdx
  102f76:	movabs $0x100000001,%rax
  102f80:	mov    %rax,0x54(%rsp)
  102f85:	mov    0x50(%rsp),%rdi
  102f8a:	mov    0x58(%rsp),%esi
  102f8e:	call   6efb0 <__cudaPushCallConfiguration@plt>
  102f93:	test   %eax,%eax
  102f95:	je     103840 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0xeb0>
  102f9b:	call   6c890 <cudaGetLastError@plt>
  102fa0:	lea    0xf2eb1(%rip),%rsi        # 1f5e58 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5f58>
  102fa7:	mov    %eax,%edi
  102fa9:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  102fae:	jmp    102a9c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x10c>
  102fb3:	nopl   0x0(%rax,%rax,1)
  102fb8:	mov    0x10(%r13),%rax
  102fbc:	movl   $0x1,0x48(%rsp)
  102fc4:	mov    (%rax),%r14
  102fc7:	mov    0xf4fc2(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  102fce:	mov    %rax,0x40(%rsp)
  102fd3:	mov    0x8(%r13),%rax
  102fd7:	mov    (%rax),%rdi
  102fda:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  102fdf:	mov    0x48(%rsp),%ecx
  102fe3:	xor    %r8d,%r8d
  102fe6:	mov    %r14,%r9
  102fe9:	mov    %eax,0x50(%rsp)
  102fed:	mov    0x40(%rsp),%rdx
  102ff2:	movabs $0x100000001,%rax
  102ffc:	mov    %rax,0x54(%rsp)
  103001:	mov    0x50(%rsp),%rdi
  103006:	mov    0x58(%rsp),%esi
  10300a:	call   6efb0 <__cudaPushCallConfiguration@plt>
  10300f:	test   %eax,%eax
  103011:	je     1034c0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0xb30>
  103017:	call   6c890 <cudaGetLastError@plt>
  10301c:	lea    0xf2465(%rip),%rsi        # 1f5488 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5588>
  103023:	mov    %eax,%edi
  103025:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  10302a:	jmp    102ac8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x138>
  10302f:	nop
  103030:	mov    0x10(%r13),%rax
  103034:	movl   $0x1,0x48(%rsp)
  10303c:	mov    (%rax),%r14
  10303f:	mov    0xf4f4a(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  103046:	mov    %rax,0x40(%rsp)
  10304b:	mov    0x8(%r13),%rax
  10304f:	mov    0x68(%rax),%rdi
  103053:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  103058:	mov    0x48(%rsp),%ecx
  10305c:	xor    %r8d,%r8d
  10305f:	mov    %r14,%r9
  103062:	mov    %eax,0x50(%rsp)
  103066:	mov    0x40(%rsp),%rdx
  10306b:	movabs $0x100000001,%rax
  103075:	mov    %rax,0x54(%rsp)
  10307a:	mov    0x50(%rsp),%rdi
  10307f:	mov    0x58(%rsp),%esi
  103083:	call   6efb0 <__cudaPushCallConfiguration@plt>
  103088:	test   %eax,%eax
  10308a:	je     103440 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0xab0>
  103090:	call   6c890 <cudaGetLastError@plt>
  103095:	lea    0xf23cc(%rip),%rsi        # 1f5468 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5568>
  10309c:	mov    %eax,%edi
  10309e:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  1030a3:	jmp    102ab4 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x124>
  1030a8:	nopl   0x0(%rax,%rax,1)
  1030b0:	mov    0xf4ed9(%rip),%rdx        # 1f7f90 <cuda::std::__4::in_place+0x43>
  1030b7:	mov    0x8(%rbx),%rax
  1030bb:	xor    %r8d,%r8d
  1030be:	movabs $0x100000001,%rcx
  1030c8:	mov    %rcx,0x54(%rsp)
  1030cd:	mov    0x58(%rsp),%esi
  1030d1:	mov    $0x1,%ecx
  1030d6:	mov    %rdx,0x40(%rsp)
  1030db:	mov    0x80(%rbx),%rdx
  1030e2:	mov    (%rax),%r9
  1030e5:	movl   $0x1,0x48(%rsp)
  1030ed:	mov    (%rdx),%edx
  1030ef:	mov    %edx,0x50(%rsp)
  1030f3:	mov    0x50(%rsp),%rdi
  1030f8:	movabs $0x100000100,%rdx
  103102:	call   6efb0 <__cudaPushCallConfiguration@plt>
  103107:	test   %eax,%eax
  103109:	je     1038e0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0xf50>
  10310f:	call   6c890 <cudaGetLastError@plt>
  103114:	lea    0xf2c7d(%rip),%rsi        # 1f5d98 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5e98>
  10311b:	mov    %eax,%edi
  10311d:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  103122:	jmp    102a42 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0xb2>
  103127:	nopw   0x0(%rax,%rax,1)
  103130:	mov    0x8(%rbx),%rax
  103134:	add    $0x2070,%rdi
  10313b:	mov    %rbp,%rdx
  10313e:	mov    %r12,%rsi
  103141:	mov    (%rax),%rcx
  103144:	call   6e430 <synreal::Granular::multiply(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*) const@plt>
  103149:	jmp    102a35 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0xa5>
  10314e:	xchg   %ax,%ax
  103150:	mov    0x8(%rbx),%rax
  103154:	add    $0x1728,%rdi
  10315b:	mov    %rbp,%rdx
  10315e:	mov    %r12,%rsi
  103161:	mov    (%rax),%rcx
  103164:	call   6d000 <synreal::Fluid::multiply(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*) const@plt>
  103169:	mov    0x28(%rbx),%rdi
  10316d:	jmp    102a27 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x97>
  103172:	nopw   0x0(%rax,%rax,1)
  103178:	mov    0x8(%rbx),%rax
  10317c:	movzbl 0x41(%rdi),%ecx
  103180:	mov    %rbp,%rdx
  103183:	mov    %r12,%rsi
  103186:	add    $0x8f0,%rdi
  10318d:	mov    (%rax),%r8
  103190:	call   6ded0 <synreal::SelfCollision::multiply(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, bool, CUstream_st*) const@plt>
  103195:	mov    0x28(%rbx),%rdi
  103199:	jmp    102a19 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x89>
  10319e:	xchg   %ax,%ax
  1031a0:	mov    0x8(%rbx),%rax
  1031a4:	movl   $0x1,0x48(%rsp)
  1031ac:	mov    (%rax),%r13
  1031af:	mov    0xf4dda(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  1031b6:	mov    %rax,0x40(%rsp)
  1031bb:	mov    0x68(%rbx),%rax
  1031bf:	mov    (%rax),%rdi
  1031c2:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  1031c7:	mov    0x48(%rsp),%ecx
  1031cb:	xor    %r8d,%r8d
  1031ce:	mov    %r13,%r9
  1031d1:	mov    %eax,0x50(%rsp)
  1031d5:	mov    0x40(%rsp),%rdx
  1031da:	movabs $0x100000001,%rax
  1031e4:	mov    %rax,0x54(%rsp)
  1031e9:	mov    0x50(%rsp),%rdi
  1031ee:	mov    0x58(%rsp),%esi
  1031f2:	call   6efb0 <__cudaPushCallConfiguration@plt>
  1031f7:	test   %eax,%eax
  1031f9:	je     103760 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0xdd0>
  1031ff:	call   6c890 <cudaGetLastError@plt>
  103204:	lea    0xf2b5d(%rip),%rsi        # 1f5d68 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5e68>
  10320b:	mov    %eax,%edi
  10320d:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  103212:	mov    0x28(%rbx),%rdi
  103216:	jmp    102a0c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x7c>
  10321b:	nopl   0x0(%rax,%rax,1)
  103220:	mov    0x8(%rbx),%rax
  103224:	movl   $0x1,0x48(%rsp)
  10322c:	mov    (%rax),%r13
  10322f:	mov    0xf4d5a(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  103236:	mov    %rax,0x40(%rsp)
  10323b:	mov    0x58(%rbx),%rax
  10323f:	mov    (%rax),%rdi
  103242:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  103247:	mov    0x48(%rsp),%ecx
  10324b:	xor    %r8d,%r8d
  10324e:	mov    %r13,%r9
  103251:	mov    %eax,0x50(%rsp)
  103255:	mov    0x40(%rsp),%rdx
  10325a:	movabs $0x100000001,%rax
  103264:	mov    %rax,0x54(%rsp)
  103269:	mov    0x50(%rsp),%rdi
  10326e:	mov    0x58(%rsp),%esi
  103272:	call   6efb0 <__cudaPushCallConfiguration@plt>
  103277:	test   %eax,%eax
  103279:	je     103700 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0xd70>
  10327f:	call   6c890 <cudaGetLastError@plt>
  103284:	lea    0xf2aad(%rip),%rsi        # 1f5d38 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5e38>
  10328b:	mov    %eax,%edi
  10328d:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  103292:	jmp    1029fb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x6b>
  103297:	nopw   0x0(%rax,%rax,1)
  1032a0:	mov    0x8(%rbx),%rax
  1032a4:	movl   $0x1,0x48(%rsp)
  1032ac:	mov    (%rax),%r13
  1032af:	mov    0xf4cda(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  1032b6:	mov    %rax,0x40(%rsp)
  1032bb:	mov    0x18(%rbx),%rax
  1032bf:	mov    (%rax),%rdi
  1032c2:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  1032c7:	mov    0x48(%rsp),%ecx
  1032cb:	xor    %r8d,%r8d
  1032ce:	mov    %r13,%r9
  1032d1:	mov    %eax,0x50(%rsp)
  1032d5:	mov    0x40(%rsp),%rdx
  1032da:	movabs $0x100000001,%rax
  1032e4:	mov    %rax,0x54(%rsp)
  1032e9:	mov    0x50(%rsp),%rdi
  1032ee:	mov    0x58(%rsp),%esi
  1032f2:	call   6efb0 <__cudaPushCallConfiguration@plt>
  1032f7:	test   %eax,%eax
  1032f9:	je     1036a8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0xd18>
  1032ff:	call   6c890 <cudaGetLastError@plt>
  103304:	lea    0xf29f5(%rip),%rsi        # 1f5d00 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5e00>
  10330b:	mov    %eax,%edi
  10330d:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  103312:	jmp    1029ee <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x5e>
  103317:	nopw   0x0(%rax,%rax,1)
  103320:	mov    0x8(%rbx),%rax
  103324:	movl   $0x1,0x48(%rsp)
  10332c:	mov    (%rax),%r13
  10332f:	mov    0xf4c5a(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  103336:	mov    %rax,0x40(%rsp)
  10333b:	mov    0x18(%rbx),%rax
  10333f:	mov    (%rax),%rdi
  103342:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  103347:	mov    0x48(%rsp),%ecx
  10334b:	xor    %r8d,%r8d
  10334e:	mov    %r13,%r9
  103351:	mov    %eax,0x50(%rsp)
  103355:	mov    0x40(%rsp),%rdx
  10335a:	movabs $0x100000001,%rax
  103364:	mov    %rax,0x54(%rsp)
  103369:	mov    0x50(%rsp),%rdi
  10336e:	mov    0x58(%rsp),%esi
  103372:	call   6efb0 <__cudaPushCallConfiguration@plt>
  103377:	test   %eax,%eax
  103379:	je     103648 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0xcb8>
  10337f:	call   6c890 <cudaGetLastError@plt>
  103384:	lea    0xf293d(%rip),%rsi        # 1f5cc8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5dc8>
  10338b:	mov    %eax,%edi
  10338d:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  103392:	jmp    1029e1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x51>
  103397:	nopw   0x0(%rax,%rax,1)
  1033a0:	mov    0x98(%rbx),%r13
  1033a7:	movl   $0x1,0x48(%rsp)
  1033af:	mov    0x10(%r13),%rax
  1033b3:	mov    (%rax),%r14
  1033b6:	mov    0x8(%r13),%rax
  1033ba:	mov    0x10(%rax),%edi
  1033bd:	mov    0x0(%r13),%rax
  1033c1:	cmpb   $0x0,(%rax)
  1033c4:	mov    0xf4bc5(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  1033cb:	mov    %rax,0x40(%rsp)
  1033d0:	jne    1039a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x1010>
  1033d6:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  1033db:	mov    0x48(%rsp),%ecx
  1033df:	xor    %r8d,%r8d
  1033e2:	mov    %r14,%r9
  1033e5:	mov    %eax,0x50(%rsp)
  1033e9:	mov    0x40(%rsp),%rdx
  1033ee:	movabs $0x100000001,%rax
  1033f8:	mov    %rax,0x54(%rsp)
  1033fd:	mov    0x50(%rsp),%rdi
  103402:	mov    0x58(%rsp),%esi
  103406:	call   6efb0 <__cudaPushCallConfiguration@plt>
  10340b:	test   %eax,%eax
  10340d:	je     103a50 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x10c0>
  103413:	call   6c890 <cudaGetLastError@plt>
  103418:	lea    0xf2401(%rip),%rsi        # 1f5820 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5920>
  10341f:	mov    %eax,%edi
  103421:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  103426:	mov    0xa0(%rbx),%rax
  10342d:	cmpb   $0x0,(%rax)
  103430:	je     102a6c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0xdc>
  103436:	jmp    102c40 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x2b0>
  10343b:	nopl   0x0(%rax,%rax,1)
  103440:	mov    0x0(%r13),%rax
  103444:	mov    0x20(%r13),%rdx
  103448:	mov    %rbp,%r9
  10344b:	mov    %r12,%r8
  10344e:	mov    0x18(%r13),%rsi
  103452:	movss  0xf4b26(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  10345a:	mov    0x3280(%rax),%rcx
  103461:	mov    0x6b0(%rax),%rdi
  103468:	divss  (%rdx),%xmm0
  10346c:	mov    0x3060(%rax),%rdx
  103473:	push   $0x0
  103475:	mov    0x8(%r13),%rax
  103479:	push   0x70(%rax)
  10347c:	push   0x68(%rax)
  10347f:	push   0x60(%rax)
  103482:	push   0x58(%rax)
  103485:	push   0x50(%rax)
  103488:	push   0x48(%rax)
  10348b:	push   0x40(%rax)
  10348e:	push   0x38(%rax)
  103491:	push   0x30(%rax)
  103494:	push   0x28(%rax)
  103497:	push   0x20(%rax)
  10349a:	push   0x18(%rax)
  10349d:	push   0x10(%rax)
  1034a0:	push   0x8(%rax)
  1034a3:	push   (%rax)
  1034a5:	mov    (%rsi),%rsi
  1034a8:	call   6aee0 <synreal::kernel::evaluate_joint_armature(synreal::kernel::JointCoordinateView, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  1034ad:	sub    $0xffffffffffffff80,%rsp
  1034b1:	jmp    103090 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x700>
  1034b6:	cs nopw 0x0(%rax,%rax,1)
  1034c0:	mov    0x30(%r13),%rax
  1034c4:	mov    0x20(%r13),%rdi
  1034c8:	xor    %r8d,%r8d
  1034cb:	mov    %rbp,%rcx
  1034ce:	movss  0xf4aaa(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  1034d6:	mov    %r12,%rdx
  1034d9:	divss  (%rax),%xmm0
  1034dd:	mov    0x28(%r13),%rax
  1034e1:	mov    0x3060(%rax),%rsi
  1034e8:	mov    0x18(%r13),%rax
  1034ec:	push   0x98(%rax)
  1034f2:	push   0x90(%rax)
  1034f8:	push   0x88(%rax)
  1034fe:	push   0x80(%rax)
  103504:	push   0x78(%rax)
  103507:	push   0x70(%rax)
  10350a:	push   0x68(%rax)
  10350d:	push   0x60(%rax)
  103510:	push   0x58(%rax)
  103513:	push   0x50(%rax)
  103516:	push   0x48(%rax)
  103519:	push   0x40(%rax)
  10351c:	push   0x38(%rax)
  10351f:	push   0x30(%rax)
  103522:	push   0x28(%rax)
  103525:	push   0x20(%rax)
  103528:	push   0x18(%rax)
  10352b:	push   0x10(%rax)
  10352e:	push   0x8(%rax)
  103531:	push   (%rax)
  103533:	mov    (%rdi),%rdi
  103536:	call   6aa60 <synreal::kernel::evaluate_cables(synreal::kernel::CableView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  10353b:	add    $0xa0,%rsp
  103542:	jmp    103017 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x687>
  103547:	nopw   0x0(%rax,%rax,1)
  103550:	mov    0x28(%rbx),%rax
  103554:	mov    0xc8(%rbx),%rdi
  10355b:	mov    %rbp,%r8
  10355e:	mov    0x32e8(%rax),%rdx
  103565:	mov    0x3328(%rax),%rcx
  10356c:	mov    0x32a8(%rax),%rsi
  103573:	mov    0x40(%rbx),%rax
  103577:	push   (%rax)
  103579:	mov    0xd0(%rbx),%rax
  103580:	push   (%rax)
  103582:	mov    (%rdi),%r9
  103585:	mov    %r12,%rdi
  103588:	call   6aa70 <synreal::kernel::multiply_triangle_drag_tangent(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  10358d:	pop    %rax
  10358e:	pop    %rdx
  10358f:	jmp    102e82 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x4f2>
  103594:	nopl   0x0(%rax)
  103598:	mov    0x118(%rbx),%rax
  10359f:	sub    $0x8,%rsp
  1035a3:	mov    %rbp,%rsi
  1035a6:	mov    %r12,%rdi
  1035a9:	push   0xf0(%rax)
  1035af:	push   0xe8(%rax)
  1035b5:	push   0xe0(%rax)
  1035bb:	push   0xd8(%rax)
  1035c1:	push   0xd0(%rax)
  1035c7:	push   0xc8(%rax)
  1035cd:	push   0xc0(%rax)
  1035d3:	push   0xb8(%rax)
  1035d9:	push   0xb0(%rax)
  1035df:	push   0xa8(%rax)
  1035e5:	push   0xa0(%rax)
  1035eb:	push   0x98(%rax)
  1035f1:	push   0x90(%rax)
  1035f7:	push   0x88(%rax)
  1035fd:	push   0x80(%rax)
  103603:	push   0x78(%rax)
  103606:	push   0x70(%rax)
  103609:	push   0x68(%rax)
  10360c:	push   0x60(%rax)
  10360f:	push   0x58(%rax)
  103612:	push   0x50(%rax)
  103615:	push   0x48(%rax)
  103618:	push   0x40(%rax)
  10361b:	push   0x38(%rax)
  10361e:	push   0x30(%rax)
  103621:	push   0x28(%rax)
  103624:	push   0x20(%rax)
  103627:	push   0x18(%rax)
  10362a:	push   0x10(%rax)
  10362d:	push   0x8(%rax)
  103630:	push   (%rax)
  103632:	call   6aa10 <synreal::kernel::multiply_rolling_contact_tangent(synreal::kernel::RollingContactView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*)@plt>
  103637:	add    $0x100,%rsp
  10363e:	jmp    102c15 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x285>
  103643:	nopl   0x0(%rax,%rax,1)
  103648:	mov    0x28(%rbx),%rax
  10364c:	mov    0x30(%rbx),%rdx
  103650:	sub    $0x8,%rsp
  103654:	mov    %rbp,%r9
  103657:	mov    0x40(%rbx),%r8
  10365b:	mov    0x38(%rbx),%rsi
  10365f:	movss  (%rdx),%xmm0
  103663:	mov    0x3a0(%rax),%rcx
  10366a:	mulss  0xc(%rax),%xmm0
  10366f:	mov    0x3d0(%rax),%rdx
  103676:	push   (%r8)
  103679:	mov    0x398(%rax),%eax
  10367f:	mov    0x20(%rbx),%rdi
  103683:	push   %rax
  103684:	mov    0x18(%rbx),%rax
  103688:	push   (%rax)
  10368a:	mov    (%rsi),%r8d
  10368d:	mov    %r12,%rsi
  103690:	mov    (%rdi),%rdi
  103693:	call   6ad60 <synreal::kernel::multiply_affine_body_constitutive_tangent(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, float, synreal::AffineBodyRigidityModel, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  103698:	add    $0x20,%rsp
  10369c:	jmp    10337f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x9ef>
  1036a1:	nopl   0x0(%rax)
  1036a8:	mov    0x28(%rbx),%rax
  1036ac:	mov    0x30(%rbx),%rdx
  1036b0:	mov    0x40(%rbx),%r8
  1036b4:	mov    0x18(%rbx),%rdi
  1036b8:	movss  (%rdx),%xmm0
  1036bc:	mov    0x3350(%rax),%rcx
  1036c3:	mulss  0xc(%rax),%xmm0
  1036c8:	mov    0x3a0(%rax),%rdx
  1036cf:	mov    0x3d0(%rax),%rsi
  1036d6:	push   (%r8)
  1036d9:	mov    %rbp,%r8
  1036dc:	mov    0x398(%rax),%eax
  1036e2:	push   %rax
  1036e3:	mov    (%rdi),%r9
  1036e6:	mov    %r12,%rdi
  1036e9:	call   6a9f0 <synreal::kernel::multiply_affine_body_so3_augmented_lagrangian_tangent(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  1036ee:	pop    %rdi
  1036ef:	pop    %r8
  1036f1:	jmp    1032ff <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x96f>
  1036f6:	cs nopw 0x0(%rax,%rax,1)
  103700:	mov    0x28(%rbx),%rax
  103704:	mov    0x60(%rbx),%rdx
  103708:	mov    0x40(%rbx),%rsi
  10370c:	movss  0xf486c(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  103714:	mov    0x3390(%rax),%r9
  10371b:	mov    0x308(%rax),%r8
  103722:	divss  (%rdx),%xmm0
  103726:	mov    0x2f8(%rax),%rcx
  10372d:	mov    0x2e8(%rax),%rdx
  103734:	push   (%rsi)
  103736:	mov    %r12,%rsi
  103739:	mov    0x2e0(%rax),%eax
  10373f:	mov    0x20(%rbx),%rdi
  103743:	push   %rax
  103744:	mov    0x58(%rbx),%rax
  103748:	push   (%rax)
  10374a:	push   %rbp
  10374b:	mov    (%rdi),%rdi
  10374e:	call   6a880 <synreal::kernel::multiply_tetrahedron_tangent(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  103753:	add    $0x20,%rsp
  103757:	jmp    10327f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x8ef>
  10375c:	nopl   0x0(%rax)
  103760:	mov    0x28(%rbx),%rax
  103764:	mov    0x60(%rbx),%rdx
  103768:	mov    0x40(%rbx),%rsi
  10376c:	movss  0xf480c(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  103774:	mov    0x330(%rax),%r9
  10377b:	mov    0x320(%rax),%r8
  103782:	divss  (%rdx),%xmm0
  103786:	mov    0x350(%rax),%rcx
  10378d:	mov    0x340(%rax),%rdx
  103794:	push   (%rsi)
  103796:	mov    %r12,%rsi
  103799:	mov    0x318(%rax),%eax
  10379f:	mov    0x20(%rbx),%rdi
  1037a3:	push   %rax
  1037a4:	mov    0x68(%rbx),%rax
  1037a8:	push   (%rax)
  1037aa:	push   %rbp
  1037ab:	mov    (%rdi),%rdi
  1037ae:	call   6ac60 <synreal::kernel::multiply_bending_damping_tangent(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  1037b3:	add    $0x20,%rsp
  1037b7:	jmp    1031ff <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x86f>
  1037bc:	nopl   0x0(%rax)
  1037c0:	mov    0x28(%rbx),%rax
  1037c4:	mov    0x40(%rbx),%r10
  1037c8:	mov    0xe8(%rbx),%rdi
  1037cf:	mov    0x34f0(%rax),%r9
  1037d6:	mov    0x34d0(%rax),%r8
  1037dd:	mov    0x34b0(%rax),%rcx
  1037e4:	mov    0x570(%rax),%rdx
  1037eb:	mov    0x3d0(%rax),%rsi
  1037f2:	push   (%r10)
  1037f5:	mov    0x56c(%rax),%r10d
  1037fc:	push   %r10
  1037fe:	mov    0x568(%rax),%r10d
  103805:	push   %r10
  103807:	mov    0xe0(%rbx),%r10
  10380e:	push   (%r10)
  103811:	push   %rbp
  103812:	push   0x3530(%rax)
  103818:	push   0x3510(%rax)
  10381e:	push   0x5b0(%rax)
  103824:	movss  (%rdi),%xmm0
  103828:	mov    %r12,%rdi
  10382b:	call   6a990 <synreal::kernel::multiply_joint_body_point_line_augmented_lagrangian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
  103830:	add    $0x40,%rsp
  103834:	jmp    102f07 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x577>
  103839:	nopl   0x0(%rax)
  103840:	mov    0x28(%rbx),%rax
  103844:	mov    0x60(%rbx),%rdx
  103848:	sub    $0x8,%rsp
  10384c:	mov    0x40(%rbx),%rsi
  103850:	movss  0xf4728(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  103858:	mov    0x600(%rax),%r9
  10385f:	divss  (%rdx),%xmm0
  103863:	mov    0x5f0(%rax),%r8
  10386a:	mov    0x5e0(%rax),%rcx
  103871:	mov    0x3d0(%rax),%rdx
  103878:	push   (%rsi)
  10387a:	mov    0x5d4(%rax),%esi
  103880:	mov    0x20(%rbx),%rdi
  103884:	push   %rsi
  103885:	mov    %r12,%rsi
  103888:	push   %r13
  10388a:	push   %rbp
  10388b:	push   0x680(%rax)
  103891:	push   0x6a0(%rax)
  103897:	push   0x690(%rax)
  10389d:	push   0x650(%rax)
  1038a3:	push   0x35f0(%rax)
  1038a9:	push   0x35d0(%rax)
  1038af:	push   0x35b0(%rax)
  1038b5:	push   0x3590(%rax)
  1038bb:	push   0x3570(%rax)
  1038c1:	push   0x630(%rax)
  1038c7:	push   0x620(%rax)
  1038cd:	mov    (%rdi),%rdi
  1038d0:	call   6abc0 <synreal::kernel::multiply_joint_drive_tangent(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, int const*, int const*, float const*, float const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  1038d5:	sub    $0xffffffffffffff80,%rsp
  1038d9:	jmp    102f9b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x60b>
  1038de:	xchg   %ax,%ax
  1038e0:	sub    $0x130,%rsp
  1038e7:	mov    0x88(%rbx),%rsi
  1038ee:	mov    $0x25,%ecx
  1038f3:	mov    %rsp,%rdi
  1038f6:	rep movsq %ds:(%rsi),%es:(%rdi)
  1038f9:	mov    %rbp,%rsi
  1038fc:	mov    %r12,%rdi
  1038ff:	call   6ae50 <synreal::kernel::multiply_surface_contact_tangent(synreal::kernel::SurfaceContactView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*)@plt>
  103904:	add    $0x130,%rsp
  10390b:	jmp    10310f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x77f>
  103910:	mov    0x8(%r13),%rax
  103914:	mov    0x28(%r13),%rdx
  103918:	mov    %rbp,%r9
  10391b:	mov    %r12,%r8
  10391e:	mov    0x20(%r13),%rdi
  103922:	movss  0xf4656(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  10392a:	mov    0x3260(%rax),%rcx
  103931:	mov    0x3060(%rax),%rsi
  103938:	divss  (%rdx),%xmm0
  10393c:	mov    0x3240(%rax),%rdx
  103943:	push   $0x0
  103945:	push   0x70(%rsp)
  103949:	push   0x70(%rsp)
  10394d:	push   0x70(%rsp)
  103951:	push   0x70(%rsp)
  103955:	mov    0x10(%r13),%rax
  103959:	push   0x70(%rax)
  10395c:	push   0x68(%rax)
  10395f:	push   0x60(%rax)
  103962:	push   0x58(%rax)
  103965:	push   0x50(%rax)
  103968:	push   0x48(%rax)
  10396b:	push   0x40(%rax)
  10396e:	push   0x38(%rax)
  103971:	push   0x30(%rax)
  103974:	push   0x28(%rax)
  103977:	push   0x20(%rax)
  10397a:	push   0x18(%rax)
  10397d:	push   0x10(%rax)
  103980:	push   0x8(%rax)
  103983:	push   (%rax)
  103985:	mov    (%rdi),%rdi
  103988:	call   6ac30 <synreal::kernel::evaluate_angular_limits(synreal::kernel::JointCoordinateView, synreal::kernel::AngularLimitView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, int const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  10398d:	add    $0xa0,%rsp
  103994:	jmp    102b90 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x200>
  103999:	nopl   0x0(%rax)
  1039a0:	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  1039a5:	mov    0x48(%rsp),%ecx
  1039a9:	xor    %r8d,%r8d
  1039ac:	mov    %r14,%r9
  1039af:	mov    %eax,0x50(%rsp)
  1039b3:	mov    0x40(%rsp),%rdx
  1039b8:	movabs $0x100000001,%rax
  1039c2:	mov    %rax,0x54(%rsp)
  1039c7:	mov    0x50(%rsp),%rdi
  1039cc:	mov    0x58(%rsp),%esi
  1039d0:	call   6efb0 <__cudaPushCallConfiguration@plt>
  1039d5:	test   %eax,%eax
  1039d7:	je     103a10 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0x1080>
  1039d9:	call   6c890 <cudaGetLastError@plt>
  1039de:	lea    0xf1e13(%rip),%rsi        # 1f57f8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x58f8>
  1039e5:	mov    %eax,%edi
  1039e7:	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  1039ec:	jmp    102a5c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}::operator()(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >) const [clone .isra.0]+0xcc>
  1039f1:	nopl   0x0(%rax)
  1039f8:	mov    0x148(%rdi),%rcx
  1039ff:	rex.WR
