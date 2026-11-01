
style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so：     文件格式 elf64-x86-64


Disassembly of section .text:

00000000000fb060 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)>:
   fb060:	f3 0f 1e fa          	endbr64 
   fb064:	55                   	push   %rbp
   fb065:	66 48 0f 6e ee       	movq   %rsi,%xmm5
   fb06a:	66 48 0f 6e f7       	movq   %rdi,%xmm6
   fb06f:	66 0f 6c ee          	punpcklqdq %xmm6,%xmm5
   fb073:	48 89 e5             	mov    %rsp,%rbp
   fb076:	41 57                	push   %r15
   fb078:	41 56                	push   %r14
   fb07a:	4d 89 c6             	mov    %r8,%r14
   fb07d:	41 55                	push   %r13
   fb07f:	41 54                	push   %r12
   fb081:	53                   	push   %rbx
   fb082:	48 89 fb             	mov    %rdi,%rbx
   fb085:	48 81 ec d8 0b 00 00 	sub    $0xbd8,%rsp
   fb08c:	48 89 b5 08 f5 ff ff 	mov    %rsi,-0xaf8(%rbp)
   fb093:	8b b7 a8 00 00 00    	mov    0xa8(%rdi),%esi
   fb099:	48 89 95 e8 f4 ff ff 	mov    %rdx,-0xb18(%rbp)
   fb0a0:	48 8d 95 2c f5 ff ff 	lea    -0xad4(%rbp),%rdx
   fb0a7:	48 89 8d 78 f4 ff ff 	mov    %rcx,-0xb88(%rbp)
   fb0ae:	66 48 0f 6e f2       	movq   %rdx,%xmm6
   fb0b3:	4c 89 8d 10 f5 ff ff 	mov    %r9,-0xaf0(%rbp)
   fb0ba:	f3 0f 11 85 1c f5 ff 	movss  %xmm0,-0xae4(%rbp)
   fb0c1:	ff 
   fb0c2:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
   fb0c9:	00 00 
   fb0cb:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   fb0cf:	31 c0                	xor    %eax,%eax
   fb0d1:	48 8d 85 90 f5 ff ff 	lea    -0xa70(%rbp),%rax
   fb0d8:	0f 29 ad 90 f4 ff ff 	movaps %xmm5,-0xb70(%rbp)
   fb0df:	66 48 0f 6e f8       	movq   %rax,%xmm7
   fb0e4:	48 8d 85 10 f5 ff ff 	lea    -0xaf0(%rbp),%rax
   fb0eb:	48 89 b5 58 f5 ff ff 	mov    %rsi,-0xaa8(%rbp)
   fb0f2:	48 89 c1             	mov    %rax,%rcx
   fb0f5:	48 89 85 00 f5 ff ff 	mov    %rax,-0xb00(%rbp)
   fb0fc:	66 0f 6c f7          	punpcklqdq %xmm7,%xmm6
   fb100:	48 8d 85 20 f9 ff ff 	lea    -0x6e0(%rbp),%rax
   fb107:	66 48 0f 6e e8       	movq   %rax,%xmm5
   fb10c:	66 48 0f 6e f9       	movq   %rcx,%xmm7
   fb111:	8b 87 ac 00 00 00    	mov    0xac(%rdi),%eax
   fb117:	0f 29 b5 d0 f4 ff ff 	movaps %xmm6,-0xb30(%rbp)
   fb11e:	66 0f 6c fd          	punpcklqdq %xmm5,%xmm7
   fb122:	0f 29 bd f0 f4 ff ff 	movaps %xmm7,-0xb10(%rbp)
   fb129:	85 c0                	test   %eax,%eax
   fb12b:	0f 84 0f 31 00 00    	je     fe240 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x31e0>
   fb131:	48 89 85 60 f5 ff ff 	mov    %rax,-0xaa0(%rbp)
   fb138:	0f 28 d0             	movaps %xmm0,%xmm2
   fb13b:	66 0f ef f6          	pxor   %xmm6,%xmm6
   fb13f:	0f 2f d6             	comiss %xmm6,%xmm2
   fb142:	0f 86 d8 bc f7 ff    	jbe    76e20 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x83e>
   fb148:	f3 0f 10 05 3c 46 0f 	movss  0xf463c(%rip),%xmm0        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
   fb14f:	00 
   fb150:	f3 0f 10 0d 48 46 0f 	movss  0xf4648(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
   fb157:	00 
   fb158:	0f 28 da             	movaps %xmm2,%xmm3
   fb15b:	0f 54 d9             	andps  %xmm1,%xmm3
   fb15e:	0f 2e c3             	ucomiss %xmm3,%xmm0
   fb161:	0f 82 b9 bc f7 ff    	jb     76e20 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x83e>
   fb167:	48 8b 8d 08 f5 ff ff 	mov    -0xaf8(%rbp),%rcx
   fb16e:	48 39 41 08          	cmp    %rax,0x8(%rcx)
   fb172:	0f 82 c1 77 00 00    	jb     102939 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78d9>
   fb178:	48 39 41 18          	cmp    %rax,0x18(%rcx)
   fb17c:	0f 82 0c bc f7 ff    	jb     76d8e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x7ac>
   fb182:	48 8b 51 28          	mov    0x28(%rcx),%rdx
   fb186:	48 39 c2             	cmp    %rax,%rdx
   fb189:	0f 92 85 18 f5 ff ff 	setb   -0xae8(%rbp)
   fb190:	48 85 d2             	test   %rdx,%rdx
   fb193:	0f b6 8d 18 f5 ff ff 	movzbl -0xae8(%rbp),%ecx
   fb19a:	0f 95 c2             	setne  %dl
   fb19d:	20 ca                	and    %cl,%dl
   fb19f:	41 89 d7             	mov    %edx,%r15d
   fb1a2:	0f 85 c3 77 00 00    	jne    10296b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x790b>
   fb1a8:	48 8b 95 e8 f4 ff ff 	mov    -0xb18(%rbp),%rdx
   fb1af:	48 39 42 08          	cmp    %rax,0x8(%rdx)
   fb1b3:	0f 82 ad 77 00 00    	jb     102966 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7906>
   fb1b9:	48 39 42 18          	cmp    %rax,0x18(%rdx)
   fb1bd:	0f 82 ef bc f7 ff    	jb     76eb2 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x8d0>
   fb1c3:	41 8b 4e 10          	mov    0x10(%r14),%ecx
   fb1c7:	85 c9                	test   %ecx,%ecx
   fb1c9:	0f 84 80 00 00 00    	je     fb24f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ef>
   fb1cf:	49 83 7e 08 00       	cmpq   $0x0,0x8(%r14)
   fb1d4:	0f 84 92 b6 f7 ff    	je     7686c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x28a>
   fb1da:	89 ca                	mov    %ecx,%edx
   fb1dc:	49 3b 56 20          	cmp    0x20(%r14),%rdx
   fb1e0:	0f 87 86 b6 f7 ff    	ja     7686c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x28a>
   fb1e6:	49 3b 56 30          	cmp    0x30(%r14),%rdx
   fb1ea:	0f 87 7c b6 f7 ff    	ja     7686c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x28a>
   fb1f0:	49 3b 56 40          	cmp    0x40(%r14),%rdx
   fb1f4:	0f 87 72 b6 f7 ff    	ja     7686c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x28a>
   fb1fa:	49 3b 56 50          	cmp    0x50(%r14),%rdx
   fb1fe:	0f 87 68 b6 f7 ff    	ja     7686c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x28a>
   fb204:	49 3b 96 80 00 00 00 	cmp    0x80(%r14),%rdx
   fb20b:	0f 87 5b b6 f7 ff    	ja     7686c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x28a>
   fb211:	49 3b 96 90 00 00 00 	cmp    0x90(%r14),%rdx
   fb218:	0f 87 4e b6 f7 ff    	ja     7686c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x28a>
   fb21e:	49 3b 96 a0 00 00 00 	cmp    0xa0(%r14),%rdx
   fb225:	0f 87 41 b6 f7 ff    	ja     7686c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x28a>
   fb22b:	49 8b 7e 60          	mov    0x60(%r14),%rdi
   fb22f:	48 85 ff             	test   %rdi,%rdi
   fb232:	74 09                	je     fb23d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1dd>
   fb234:	48 39 fa             	cmp    %rdi,%rdx
   fb237:	0f 87 09 b4 f7 ff    	ja     76646 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x64>
   fb23d:	49 8b 7e 70          	mov    0x70(%r14),%rdi
   fb241:	48 85 ff             	test   %rdi,%rdi
   fb244:	74 09                	je     fb24f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ef>
   fb246:	48 39 fa             	cmp    %rdi,%rdx
   fb249:	0f 87 f7 b3 f7 ff    	ja     76646 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x64>
   fb24f:	49 8b 96 b0 00 00 00 	mov    0xb0(%r14),%rdx
   fb256:	48 85 d2             	test   %rdx,%rdx
   fb259:	0f 84 01 30 00 00    	je     fe260 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3200>
   fb25f:	48 39 d1             	cmp    %rdx,%rcx
   fb262:	0f 87 08 77 00 00    	ja     102970 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7910>
   fb268:	49 8b be 30 01 00 00 	mov    0x130(%r14),%rdi
   fb26f:	41 8b 8e d0 00 00 00 	mov    0xd0(%r14),%ecx
   fb276:	48 85 ff             	test   %rdi,%rdi
   fb279:	75 0e                	jne    fb289 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x229>
   fb27b:	49 83 be 40 01 00 00 	cmpq   $0x0,0x140(%r14)
   fb282:	00 
   fb283:	0f 84 d7 31 00 00    	je     fe460 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3400>
   fb289:	89 ca                	mov    %ecx,%edx
   fb28b:	48 39 fa             	cmp    %rdi,%rdx
   fb28e:	0f 87 78 b5 f7 ff    	ja     7680c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x22a>
   fb294:	49 3b 96 40 01 00 00 	cmp    0x140(%r14),%rdx
   fb29b:	0f 87 6b b5 f7 ff    	ja     7680c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x22a>
   fb2a1:	85 c9                	test   %ecx,%ecx
   fb2a3:	0f 84 47 5d 00 00    	je     100ff0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5f90>
   fb2a9:	49 83 be c8 00 00 00 	cmpq   $0x0,0xc8(%r14)
   fb2b0:	00 
   fb2b1:	0f 84 87 76 00 00    	je     10293e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78de>
   fb2b7:	49 83 be 50 01 00 00 	cmpq   $0x0,0x150(%r14)
   fb2be:	00 
   fb2bf:	41 bf 01 00 00 00    	mov    $0x1,%r15d
   fb2c5:	0f 85 ad 31 00 00    	jne    fe478 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3418>
   fb2cb:	49 39 96 f0 00 00 00 	cmp    %rdx,0xf0(%r14)
   fb2d2:	0f 82 92 b9 f7 ff    	jb     76c6a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x688>
   fb2d8:	49 39 96 00 01 00 00 	cmp    %rdx,0x100(%r14)
   fb2df:	0f 82 85 b9 f7 ff    	jb     76c6a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x688>
   fb2e5:	49 39 96 10 01 00 00 	cmp    %rdx,0x110(%r14)
   fb2ec:	0f 82 78 b9 f7 ff    	jb     76c6a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x688>
   fb2f2:	49 39 96 20 01 00 00 	cmp    %rdx,0x120(%r14)
   fb2f9:	0f 82 6b b9 f7 ff    	jb     76c6a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x688>
   fb2ff:	41 bc 01 00 00 00    	mov    $0x1,%r12d
   fb305:	48 85 f6             	test   %rsi,%rsi
   fb308:	74 08                	je     fb312 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2b2>
   fb30a:	31 d2                	xor    %edx,%edx
   fb30c:	48 f7 f6             	div    %rsi
   fb30f:	49 89 c4             	mov    %rax,%r12
   fb312:	48 8b 8d 78 f4 ff ff 	mov    -0xb88(%rbp),%rcx
   fb319:	8b 83 e0 02 00 00    	mov    0x2e0(%rbx),%eax
   fb31f:	48 8b 51 48          	mov    0x48(%rcx),%rdx
   fb323:	49 0f af c4          	imul   %r12,%rax
   fb327:	48 85 d2             	test   %rdx,%rdx
   fb32a:	0f 95 c1             	setne  %cl
   fb32d:	48 39 d0             	cmp    %rdx,%rax
   fb330:	48 89 85 68 f5 ff ff 	mov    %rax,-0xa98(%rbp)
   fb337:	0f 97 c0             	seta   %al
   fb33a:	84 c1                	test   %al,%cl
   fb33c:	0f 85 ba b9 f7 ff    	jne    76cfc <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x71a>
   fb342:	8b 83 d4 05 00 00    	mov    0x5d4(%rbx),%eax
   fb348:	85 c0                	test   %eax,%eax
   fb34a:	74 46                	je     fb392 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x332>
   fb34c:	8b 93 d8 05 00 00    	mov    0x5d8(%rbx),%edx
   fb352:	48 8b b5 78 f4 ff ff 	mov    -0xb88(%rbp),%rsi
   fb359:	49 0f af d4          	imul   %r12,%rdx
   fb35d:	48 3b 56 08          	cmp    0x8(%rsi),%rdx
   fb361:	0f 87 de b9 f7 ff    	ja     76d45 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x763>
   fb367:	8b 8b dc 05 00 00    	mov    0x5dc(%rbx),%ecx
   fb36d:	49 0f af cc          	imul   %r12,%rcx
   fb371:	48 3b 4e 18          	cmp    0x18(%rsi),%rcx
   fb375:	0f 87 ca b9 f7 ff    	ja     76d45 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x763>
   fb37b:	48 3b 56 28          	cmp    0x28(%rsi),%rdx
   fb37f:	0f 87 c0 b9 f7 ff    	ja     76d45 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x763>
   fb385:	48 8b 56 38          	mov    0x38(%rsi),%rdx
   fb389:	48 85 d2             	test   %rdx,%rdx
   fb38c:	0f 85 4e 68 00 00    	jne    101be0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6b80>
   fb392:	81 7b 20 e7 03 00 00 	cmpl   $0x3e7,0x20(%rbx)
   fb399:	0f 87 bd 75 00 00    	ja     10295c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78fc>
   fb39f:	8b 43 24             	mov    0x24(%rbx),%eax
   fb3a2:	83 e8 01             	sub    $0x1,%eax
   fb3a5:	3d e6 03 00 00       	cmp    $0x3e6,%eax
   fb3aa:	0f 87 11 b8 f7 ff    	ja     76bc1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x5df>
   fb3b0:	f3 0f 10 5b 0c       	movss  0xc(%rbx),%xmm3
   fb3b5:	66 0f ef ff          	pxor   %xmm7,%xmm7
   fb3b9:	0f 2f df             	comiss %xmm7,%xmm3
   fb3bc:	0f 82 31 b8 f7 ff    	jb     76bf3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x611>
   fb3c2:	0f 54 d9             	andps  %xmm1,%xmm3
   fb3c5:	0f 2e c3             	ucomiss %xmm3,%xmm0
   fb3c8:	0f 82 25 b8 f7 ff    	jb     76bf3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x611>
   fb3ce:	8b 43 14             	mov    0x14(%rbx),%eax
   fb3d1:	83 e8 01             	sub    $0x1,%eax
   fb3d4:	3d e6 03 00 00       	cmp    $0x3e6,%eax
   fb3d9:	0f 87 82 75 00 00    	ja     102961 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7901>
   fb3df:	8b 43 18             	mov    0x18(%rbx),%eax
   fb3e2:	83 e8 01             	sub    $0x1,%eax
   fb3e5:	3d e6 03 00 00       	cmp    $0x3e6,%eax
   fb3ea:	0f 87 48 b3 f7 ff    	ja     76738 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x156>
   fb3f0:	f3 0f 10 5b 74       	movss  0x74(%rbx),%xmm3
   fb3f5:	0f 2f df             	comiss %xmm7,%xmm3
   fb3f8:	0f 86 16 b2 f7 ff    	jbe    76614 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x32>
   fb3fe:	0f 54 d9             	andps  %xmm1,%xmm3
   fb401:	0f 2e c3             	ucomiss %xmm3,%xmm0
   fb404:	0f 82 0a b2 f7 ff    	jb     76614 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x32>
   fb40a:	f3 0f 10 5b 78       	movss  0x78(%rbx),%xmm3
   fb40f:	0f 2f df             	comiss %xmm7,%xmm3
   fb412:	0f 82 10 75 00 00    	jb     102928 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78c8>
   fb418:	0f 54 d9             	andps  %xmm1,%xmm3
   fb41b:	0f 2e c3             	ucomiss %xmm3,%xmm0
   fb41e:	0f 82 91 b4 f7 ff    	jb     768b5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x2d3>
   fb424:	f3 0f 10 5b 7c       	movss  0x7c(%rbx),%xmm3
   fb429:	0f 2f df             	comiss %xmm7,%xmm3
   fb42c:	0f 82 83 b4 f7 ff    	jb     768b5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x2d3>
   fb432:	0f 54 d9             	andps  %xmm1,%xmm3
   fb435:	0f 2e c3             	ucomiss %xmm3,%xmm0
   fb438:	0f 82 77 b4 f7 ff    	jb     768b5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x2d3>
   fb43e:	f3 0f 10 9b 80 00 00 	movss  0x80(%rbx),%xmm3
   fb445:	00 
   fb446:	0f 2f df             	comiss %xmm7,%xmm3
   fb449:	0f 82 66 b4 f7 ff    	jb     768b5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x2d3>
   fb44f:	0f 54 d9             	andps  %xmm1,%xmm3
   fb452:	0f 2e c3             	ucomiss %xmm3,%xmm0
   fb455:	0f 82 5a b4 f7 ff    	jb     768b5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x2d3>
   fb45b:	f3 0f 10 9b 84 00 00 	movss  0x84(%rbx),%xmm3
   fb462:	00 
   fb463:	0f 2f df             	comiss %xmm7,%xmm3
   fb466:	0f 82 49 b4 f7 ff    	jb     768b5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x2d3>
   fb46c:	0f 54 d9             	andps  %xmm1,%xmm3
   fb46f:	0f 2e c3             	ucomiss %xmm3,%xmm0
   fb472:	0f 82 3d b4 f7 ff    	jb     768b5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x2d3>
   fb478:	83 bb 88 00 00 00 03 	cmpl   $0x3,0x88(%rbx)
   fb47f:	0f 87 be 74 00 00    	ja     102943 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78e3>
   fb485:	83 7b 10 01          	cmpl   $0x1,0x10(%rbx)
   fb489:	0f 87 a1 b4 f7 ff    	ja     76930 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x34e>
   fb48f:	83 7b 08 01          	cmpl   $0x1,0x8(%rbx)
   fb493:	0f 87 c9 b4 f7 ff    	ja     76962 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x380>
   fb499:	f3 0f 59 d2          	mulss  %xmm2,%xmm2
   fb49d:	0f 2f d7             	comiss %xmm7,%xmm2
   fb4a0:	0f 86 33 b5 f7 ff    	jbe    769d9 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x3f7>
   fb4a6:	0f 2e c2             	ucomiss %xmm2,%xmm0
   fb4a9:	0f 82 2a b5 f7 ff    	jb     769d9 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x3f7>
   fb4af:	f3 0f 10 1d c9 ca 0f 	movss  0xfcac9(%rip),%xmm3        # 1f7f80 <cuda::std::__4::in_place+0x33>
   fb4b6:	00 
   fb4b7:	f3 0f 5e da          	divss  %xmm2,%xmm3
   fb4bb:	0f 2e c3             	ucomiss %xmm3,%xmm0
   fb4be:	f3 0f 11 9d 34 f5 ff 	movss  %xmm3,-0xacc(%rbp)
   fb4c5:	ff 
   fb4c6:	0f 82 7c 74 00 00    	jb     102948 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78e8>
   fb4cc:	f3 0f 10 53 30       	movss  0x30(%rbx),%xmm2
   fb4d1:	0f 28 da             	movaps %xmm2,%xmm3
   fb4d4:	0f 54 d9             	andps  %xmm1,%xmm3
   fb4d7:	0f 2e c3             	ucomiss %xmm3,%xmm0
   fb4da:	0f 82 74 b5 f7 ff    	jb     76a54 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x472>
   fb4e0:	0f 2f fa             	comiss %xmm2,%xmm7
   fb4e3:	0f 87 6b b5 f7 ff    	ja     76a54 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x472>
   fb4e9:	f3 0f 10 53 34       	movss  0x34(%rbx),%xmm2
   fb4ee:	0f 54 d1             	andps  %xmm1,%xmm2
   fb4f1:	0f 2e c2             	ucomiss %xmm2,%xmm0
   fb4f4:	0f 82 5a b5 f7 ff    	jb     76a54 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x472>
   fb4fa:	f3 0f 10 53 38       	movss  0x38(%rbx),%xmm2
   fb4ff:	0f 54 d1             	andps  %xmm1,%xmm2
   fb502:	0f 2e c2             	ucomiss %xmm2,%xmm0
   fb505:	0f 82 49 b5 f7 ff    	jb     76a54 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x472>
   fb50b:	f3 0f 10 53 3c       	movss  0x3c(%rbx),%xmm2
   fb510:	0f 54 d1             	andps  %xmm1,%xmm2
   fb513:	0f 2e c2             	ucomiss %xmm2,%xmm0
   fb516:	0f 82 38 b5 f7 ff    	jb     76a54 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x472>
   fb51c:	f3 0f 10 53 44       	movss  0x44(%rbx),%xmm2
   fb521:	0f 2f d7             	comiss %xmm7,%xmm2
   fb524:	0f 86 23 74 00 00    	jbe    10294d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78ed>
   fb52a:	0f 54 d1             	andps  %xmm1,%xmm2
   fb52d:	0f 2e c2             	ucomiss %xmm2,%xmm0
   fb530:	0f 82 7e b5 f7 ff    	jb     76ab4 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x4d2>
   fb536:	f3 0f 10 53 48       	movss  0x48(%rbx),%xmm2
   fb53b:	0f 2f d7             	comiss %xmm7,%xmm2
   fb53e:	0f 82 0e 74 00 00    	jb     102952 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78f2>
   fb544:	0f 54 d1             	andps  %xmm1,%xmm2
   fb547:	0f 2e c2             	ucomiss %xmm2,%xmm0
   fb54a:	0f 82 ad b5 f7 ff    	jb     76afd <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x51b>
   fb550:	f3 0f 10 53 50       	movss  0x50(%rbx),%xmm2
   fb555:	0f 2f d7             	comiss %xmm7,%xmm2
   fb558:	0f 82 f9 73 00 00    	jb     102957 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78f7>
   fb55e:	f3 0f 10 35 1a ca 0f 	movss  0xfca1a(%rip),%xmm6        # 1f7f80 <cuda::std::__4::in_place+0x33>
   fb565:	00 
   fb566:	0f 2f f2             	comiss %xmm2,%xmm6
   fb569:	0f 82 d7 b5 f7 ff    	jb     76b46 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x564>
   fb56f:	0f 54 d1             	andps  %xmm1,%xmm2
   fb572:	0f 2e c2             	ucomiss %xmm2,%xmm0
   fb575:	0f 82 cb b5 f7 ff    	jb     76b46 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x564>
   fb57b:	f3 0f 10 53 58       	movss  0x58(%rbx),%xmm2
   fb580:	0f 2f d7             	comiss %xmm7,%xmm2
   fb583:	0f 82 f8 73 00 00    	jb     102981 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7921>
   fb589:	0f 2f f2             	comiss %xmm2,%xmm6
   fb58c:	0f 82 9b b9 f7 ff    	jb     76f2d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x94b>
   fb592:	0f 54 d1             	andps  %xmm1,%xmm2
   fb595:	0f 2e c2             	ucomiss %xmm2,%xmm0
   fb598:	0f 82 8f b9 f7 ff    	jb     76f2d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x94b>
   fb59e:	f3 0f 10 53 54       	movss  0x54(%rbx),%xmm2
   fb5a3:	0f 2f d7             	comiss %xmm7,%xmm2
   fb5a6:	0f 82 da 73 00 00    	jb     102986 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7926>
   fb5ac:	0f 54 d1             	andps  %xmm1,%xmm2
   fb5af:	0f 2e c2             	ucomiss %xmm2,%xmm0
   fb5b2:	0f 82 22 b2 f7 ff    	jb     767da <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x1f8>
   fb5b8:	f3 0f 10 53 5c       	movss  0x5c(%rbx),%xmm2
   fb5bd:	0f 2f d7             	comiss %xmm7,%xmm2
   fb5c0:	0f 82 14 b2 f7 ff    	jb     767da <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x1f8>
   fb5c6:	0f 54 d1             	andps  %xmm1,%xmm2
   fb5c9:	0f 2e c2             	ucomiss %xmm2,%xmm0
   fb5cc:	0f 82 08 b2 f7 ff    	jb     767da <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x1f8>
   fb5d2:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
   fb5d6:	e8 25 2c f7 ff       	call   6e200 <(anonymous namespace)::validate_cable_penalty_config(synreal::Config const&)@plt>
   fb5db:	48 8b 83 b8 32 00 00 	mov    0x32b8(%rbx),%rax
   fb5e2:	48 8b 93 f8 32 00 00 	mov    0x32f8(%rbx),%rdx
   fb5e9:	f3 0f 10 0d af 41 0f 	movss  0xf41af(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
   fb5f0:	00 
   fb5f1:	f3 0f 10 05 93 41 0f 	movss  0xf4193(%rip),%xmm0        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
   fb5f8:	00 
   fb5f9:	48 85 c0             	test   %rax,%rax
   fb5fc:	48 89 85 70 f5 ff ff 	mov    %rax,-0xa90(%rbp)
   fb603:	48 89 95 78 f5 ff ff 	mov    %rdx,-0xa88(%rbp)
   fb60a:	74 0f                	je     fb61b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5bb>
   fb60c:	f3 0f 10 53 30       	movss  0x30(%rbx),%xmm2
   fb611:	66 0f ef ff          	pxor   %xmm7,%xmm7
   fb615:	0f 2f d7             	comiss %xmm7,%xmm2
   fb618:	0f 97 c0             	seta   %al
   fb61b:	88 85 26 f5 ff ff    	mov    %al,-0xada(%rbp)
   fb621:	8b 83 14 07 00 00    	mov    0x714(%rbx),%eax
   fb627:	4c 89 a5 80 f5 ff ff 	mov    %r12,-0xa80(%rbp)
   fb62e:	49 83 fc 01          	cmp    $0x1,%r12
   fb632:	0f 84 e8 59 00 00    	je     101020 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5fc0>
   fb638:	8b 93 9c 03 00 00    	mov    0x39c(%rbx),%edx
   fb63e:	89 85 38 f5 ff ff    	mov    %eax,-0xac8(%rbp)
   fb644:	85 d2                	test   %edx,%edx
   fb646:	75 06                	jne    fb64e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5ee>
   fb648:	8b 93 98 03 00 00    	mov    0x398(%rbx),%edx
   fb64e:	f3 0f 10 53 0c       	movss  0xc(%rbx),%xmm2
   fb653:	f3 0f 59 93 d0 05 00 	mulss  0x5d0(%rbx),%xmm2
   fb65a:	00 
   fb65b:	48 89 95 88 f5 ff ff 	mov    %rdx,-0xa78(%rbp)
   fb662:	8b 43 10             	mov    0x10(%rbx),%eax
   fb665:	f3 0f 59 95 34 f5 ff 	mulss  -0xacc(%rbp),%xmm2
   fb66c:	ff 
   fb66d:	44 8b ab e8 17 00 00 	mov    0x17e8(%rbx),%r13d
   fb674:	89 85 e4 f4 ff ff    	mov    %eax,-0xb1c(%rbp)
   fb67a:	8b 43 08             	mov    0x8(%rbx),%eax
   fb67d:	85 c0                	test   %eax,%eax
   fb67f:	89 85 8c f4 ff ff    	mov    %eax,-0xb74(%rbp)
   fb685:	f3 0f 11 95 3c f5 ff 	movss  %xmm2,-0xac4(%rbp)
   fb68c:	ff 
   fb68d:	0f 94 85 a8 f4 ff ff 	sete   -0xb58(%rbp)
   fb694:	45 85 ed             	test   %r13d,%r13d
   fb697:	74 48                	je     fb6e1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x681>
   fb699:	f3 0f 10 53 28       	movss  0x28(%rbx),%xmm2
   fb69e:	0f 28 da             	movaps %xmm2,%xmm3
   fb6a1:	0f 54 d9             	andps  %xmm1,%xmm3
   fb6a4:	0f 2e c3             	ucomiss %xmm3,%xmm0
   fb6a7:	0f 82 4e b8 f7 ff    	jb     76efb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x919>
   fb6ad:	66 0f ef f6          	pxor   %xmm6,%xmm6
   fb6b1:	0f 2f f2             	comiss %xmm2,%xmm6
   fb6b4:	0f 83 41 b8 f7 ff    	jae    76efb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x919>
   fb6ba:	0f 2f 15 bf c8 0f 00 	comiss 0xfc8bf(%rip),%xmm2        # 1f7f80 <cuda::std::__4::in_place+0x33>
   fb6c1:	0f 87 34 b8 f7 ff    	ja     76efb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x919>
   fb6c7:	f3 0f 10 53 2c       	movss  0x2c(%rbx),%xmm2
   fb6cc:	0f 54 ca             	andps  %xmm2,%xmm1
   fb6cf:	0f 2e c1             	ucomiss %xmm1,%xmm0
   fb6d2:	0f 82 23 b8 f7 ff    	jb     76efb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x919>
   fb6d8:	0f 2f f2             	comiss %xmm2,%xmm6
   fb6db:	0f 87 1a b8 f7 ff    	ja     76efb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x919>
   fb6e1:	48 8b bd 60 f5 ff ff 	mov    -0xaa0(%rbp),%rdi
   fb6e8:	e8 73 16 f7 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fb6ed:	41 8b 76 10          	mov    0x10(%r14),%esi
   fb6f1:	89 85 18 f5 ff ff    	mov    %eax,-0xae8(%rbp)
   fb6f7:	8b 43 20             	mov    0x20(%rbx),%eax
   fb6fa:	89 85 e0 f4 ff ff    	mov    %eax,-0xb20(%rbp)
   fb700:	85 f6                	test   %esi,%esi
   fb702:	74 0e                	je     fb712 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6b2>
   fb704:	8b 93 98 03 00 00    	mov    0x398(%rbx),%edx
   fb70a:	85 d2                	test   %edx,%edx
   fb70c:	0f 85 66 64 00 00    	jne    101b78 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6b18>
   fb712:	c6 85 27 f5 ff ff 00 	movb   $0x0,-0xad9(%rbp)
   fb719:	45 31 c0             	xor    %r8d,%r8d
   fb71c:	48 8d bd 50 fd ff ff 	lea    -0x2b0(%rbp),%rdi
   fb723:	31 c0                	xor    %eax,%eax
   fb725:	b9 27 00 00 00       	mov    $0x27,%ecx
   fb72a:	c6 85 28 f5 ff ff 00 	movb   $0x0,-0xad8(%rbp)
   fb731:	48 89 bd 60 f4 ff ff 	mov    %rdi,-0xba0(%rbp)
   fb738:	f3 48 ab             	rep stos %rax,%es:(%rdi)
   fb73b:	48 8b 05 56 c8 0f 00 	mov    0xfc856(%rip),%rax        # 1f7f98 <cuda::std::__4::in_place+0x4b>
   fb742:	c7 85 3c fe ff ff 33 	movl   $0x3f733333,-0x1c4(%rbp)
   fb749:	33 73 3f 
   fb74c:	c6 85 4e fe ff ff 01 	movb   $0x1,-0x1b2(%rbp)
   fb753:	48 89 85 44 fe ff ff 	mov    %rax,-0x1bc(%rbp)
   fb75a:	48 8d 85 00 fb ff ff 	lea    -0x500(%rbp),%rax
   fb761:	48 89 85 48 f4 ff ff 	mov    %rax,-0xbb8(%rbp)
   fb768:	45 84 c0             	test   %r8b,%r8b
   fb76b:	74 0d                	je     fb77a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x71a>
   fb76d:	80 bb 41 33 00 00 00 	cmpb   $0x0,0x3341(%rbx)
   fb774:	0f 85 0e 2b 00 00    	jne    fe288 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3228>
   fb77a:	48 8d bd 50 fc ff ff 	lea    -0x3b0(%rbp),%rdi
   fb781:	b9 1f 00 00 00       	mov    $0x1f,%ecx
   fb786:	31 c0                	xor    %eax,%eax
   fb788:	c6 85 29 f5 ff ff 00 	movb   $0x0,-0xad7(%rbp)
   fb78f:	f3 48 ab             	rep stos %rax,%es:(%rdi)
   fb792:	41 8b be d0 00 00 00 	mov    0xd0(%r14),%edi
   fb799:	85 ff                	test   %edi,%edi
   fb79b:	0f 84 b5 2c 00 00    	je     fe456 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x33f6>
   fb7a1:	83 bb 10 07 00 00 01 	cmpl   $0x1,0x710(%rbx)
   fb7a8:	44 8b 9b 10 07 00 00 	mov    0x710(%rbx),%r11d
   fb7af:	44 89 f9             	mov    %r15d,%ecx
   fb7b2:	19 c0                	sbb    %eax,%eax
   fb7b4:	31 d2                	xor    %edx,%edx
   fb7b6:	83 c0 01             	add    $0x1,%eax
   fb7b9:	45 85 db             	test   %r11d,%r11d
   fb7bc:	0f 44 ca             	cmove  %edx,%ecx
   fb7bf:	41 89 cf             	mov    %ecx,%r15d
   fb7c2:	88 85 2a f5 ff ff    	mov    %al,-0xad6(%rbp)
   fb7c8:	44 88 bd 2b f5 ff ff 	mov    %r15b,-0xad5(%rbp)
   fb7cf:	e8 8c 15 f7 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fb7d4:	ba 20 00 00 00       	mov    $0x20,%edx
   fb7d9:	b9 25 00 00 00       	mov    $0x25,%ecx
   fb7de:	48 8b bd 48 f4 ff ff 	mov    -0xbb8(%rbp),%rdi
   fb7e5:	39 d0                	cmp    %edx,%eax
   fb7e7:	0f 47 c2             	cmova  %edx,%eax
   fb7ea:	89 85 40 f5 ff ff    	mov    %eax,-0xac0(%rbp)
   fb7f0:	31 c0                	xor    %eax,%eax
   fb7f2:	80 bd 2b f5 ff ff 00 	cmpb   $0x0,-0xad5(%rbp)
   fb7f9:	f3 48 ab             	rep stos %rax,%es:(%rdi)
   fb7fc:	0f 85 de 53 00 00    	jne    100be0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5b80>
   fb802:	48 8b b5 58 f5 ff ff 	mov    -0xaa8(%rbp),%rsi
   fb809:	48 8b 95 80 f5 ff ff 	mov    -0xa80(%rbp),%rdx
   fb810:	48 8b 8b d0 03 00 00 	mov    0x3d0(%rbx),%rcx
   fb817:	4c 8b 83 e0 03 00 00 	mov    0x3e0(%rbx),%r8
   fb81e:	8b 83 98 04 00 00    	mov    0x498(%rbx),%eax
   fb824:	c6 85 bb f4 ff ff 00 	movb   $0x0,-0xb45(%rbp)
   fb82b:	89 85 b0 f4 ff ff    	mov    %eax,-0xb50(%rbp)
   fb831:	8b 83 00 04 00 00    	mov    0x400(%rbx),%eax
   fb837:	85 c0                	test   %eax,%eax
   fb839:	0f 95 85 2c f5 ff ff 	setne  -0xad4(%rbp)
   fb840:	74 19                	je     fb85b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7fb>
   fb842:	f3 0f 10 43 60       	movss  0x60(%rbx),%xmm0
   fb847:	66 0f ef f6          	pxor   %xmm6,%xmm6
   fb84b:	c6 85 bb f4 ff ff 01 	movb   $0x1,-0xb45(%rbp)
   fb852:	0f 2f c6             	comiss %xmm6,%xmm0
   fb855:	0f 86 75 64 00 00    	jbe    101cd0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6c70>
   fb85b:	48 89 c7             	mov    %rax,%rdi
   fb85e:	66 48 0f 6e c0       	movq   %rax,%xmm0
   fb863:	f3 0f 6f 8b 10 04 00 	movdqu 0x410(%rbx),%xmm1
   fb86a:	00 
   fb86b:	48 8b 83 38 04 00 00 	mov    0x438(%rbx),%rax
   fb872:	48 0f af fa          	imul   %rdx,%rdi
   fb876:	f3 0f 6f ab 20 04 00 	movdqu 0x420(%rbx),%xmm5
   fb87d:	00 
   fb87e:	f3 0f 6f 93 c0 03 00 	movdqu 0x3c0(%rbx),%xmm2
   fb885:	00 
   fb886:	48 89 8d 20 f9 ff ff 	mov    %rcx,-0x6e0(%rbp)
   fb88d:	f3 0f 6f a3 00 04 00 	movdqu 0x400(%rbx),%xmm4
   fb894:	00 
   fb895:	48 89 85 50 f9 ff ff 	mov    %rax,-0x6b0(%rbp)
   fb89c:	31 c0                	xor    %eax,%eax
   fb89e:	66 0f 6d cd          	punpckhqdq %xmm5,%xmm1
   fb8a2:	80 bd bb f4 ff ff 00 	cmpb   $0x0,-0xb45(%rbp)
   fb8a9:	4c 89 85 28 f9 ff ff 	mov    %r8,-0x6d8(%rbp)
   fb8b0:	66 48 0f 6e ff       	movq   %rdi,%xmm7
   fb8b5:	66 0f c6 d4 02       	shufpd $0x2,%xmm4,%xmm2
   fb8ba:	48 89 bd 90 f5 ff ff 	mov    %rdi,-0xa70(%rbp)
   fb8c1:	66 0f 6c c7          	punpcklqdq %xmm7,%xmm0
   fb8c5:	0f 29 95 30 f9 ff ff 	movaps %xmm2,-0x6d0(%rbp)
   fb8cc:	0f 29 8d 40 f9 ff ff 	movaps %xmm1,-0x6c0(%rbp)
   fb8d3:	74 07                	je     fb8dc <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x87c>
   fb8d5:	48 8b 83 20 31 00 00 	mov    0x3120(%rbx),%rax
   fb8dc:	66 48 0f 6e c8       	movq   %rax,%xmm1
   fb8e1:	48 8b 83 58 04 00 00 	mov    0x458(%rbx),%rax
   fb8e8:	0f 16 8b 48 04 00 00 	movhps 0x448(%rbx),%xmm1
   fb8ef:	48 89 85 68 f9 ff ff 	mov    %rax,-0x698(%rbp)
   fb8f6:	31 c0                	xor    %eax,%eax
   fb8f8:	48 83 bb 70 04 00 00 	cmpq   $0x0,0x470(%rbx)
   fb8ff:	00 
   fb900:	0f 11 8d 58 f9 ff ff 	movups %xmm1,-0x6a8(%rbp)
   fb907:	74 07                	je     fb910 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x8b0>
   fb909:	48 8b 83 68 04 00 00 	mov    0x468(%rbx),%rax
   fb910:	48 89 85 70 f9 ff ff 	mov    %rax,-0x690(%rbp)
   fb917:	31 c0                	xor    %eax,%eax
   fb919:	48 83 bb 80 04 00 00 	cmpq   $0x0,0x480(%rbx)
   fb920:	00 
   fb921:	74 07                	je     fb92a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x8ca>
   fb923:	48 8b 83 78 04 00 00 	mov    0x478(%rbx),%rax
   fb92a:	48 89 85 78 f9 ff ff 	mov    %rax,-0x688(%rbp)
   fb931:	31 c0                	xor    %eax,%eax
   fb933:	48 83 bb 90 04 00 00 	cmpq   $0x0,0x490(%rbx)
   fb93a:	00 
   fb93b:	74 07                	je     fb944 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x8e4>
   fb93d:	48 8b 83 88 04 00 00 	mov    0x488(%rbx),%rax
   fb944:	f3 0f 7e 93 c0 30 00 	movq   0x30c0(%rbx),%xmm2
   fb94b:	00 
   fb94c:	66 48 0f 6e c8       	movq   %rax,%xmm1
   fb951:	48 8b 83 00 31 00 00 	mov    0x3100(%rbx),%rax
   fb958:	48 89 b5 b8 f9 ff ff 	mov    %rsi,-0x648(%rbp)
   fb95f:	0f 16 8b a0 30 00 00 	movhps 0x30a0(%rbx),%xmm1
   fb966:	80 bd bb f4 ff ff 00 	cmpb   $0x0,-0xb45(%rbp)
   fb96d:	44 8b 85 b0 f4 ff ff 	mov    -0xb50(%rbp),%r8d
   fb974:	0f 11 85 a8 f9 ff ff 	movups %xmm0,-0x658(%rbp)
   fb97b:	0f 16 93 e0 30 00 00 	movhps 0x30e0(%rbx),%xmm2
   fb982:	48 89 85 a0 f9 ff ff 	mov    %rax,-0x660(%rbp)
   fb989:	0f 29 8d 80 f9 ff ff 	movaps %xmm1,-0x680(%rbp)
   fb990:	0f 29 95 90 f9 ff ff 	movaps %xmm2,-0x670(%rbp)
   fb997:	0f 85 d3 57 00 00    	jne    101170 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6110>
   fb99d:	8b 83 9c 04 00 00    	mov    0x49c(%rbx),%eax
   fb9a3:	44 89 c7             	mov    %r8d,%edi
   fb9a6:	66 0f 6f ad 90 f4 ff 	movdqa -0xb70(%rbp),%xmm5
   fb9ad:	ff 
   fb9ae:	66 48 0f 6e c1       	movq   %rcx,%xmm0
   fb9b3:	f3 0f 7e a3 20 06 00 	movq   0x620(%rbx),%xmm4
   fb9ba:	00 
   fb9bb:	44 8b 9b 68 05 00 00 	mov    0x568(%rbx),%r11d
   fb9c2:	4c 8d bd 1c f5 ff ff 	lea    -0xae4(%rbp),%r15
   fb9c9:	0f 16 83 e0 05 00 00 	movhps 0x5e0(%rbx),%xmm0
   fb9d0:	29 c7                	sub    %eax,%edi
   fb9d2:	48 0f af c2          	imul   %rdx,%rax
   fb9d6:	f3 0f 7e 9b 70 35 00 	movq   0x3570(%rbx),%xmm3
   fb9dd:	00 
   fb9de:	0f 29 ad 30 f8 ff ff 	movaps %xmm5,-0x7d0(%rbp)
   fb9e5:	f3 0f 7e ab f0 05 00 	movq   0x5f0(%rbx),%xmm5
   fb9ec:	00 
   fb9ed:	48 89 bd 40 f4 ff ff 	mov    %rdi,-0xbc0(%rbp)
   fb9f4:	0f 16 a3 30 06 00 00 	movhps 0x630(%rbx),%xmm4
   fb9fb:	8b bb f0 04 00 00    	mov    0x4f0(%rbx),%edi
   fba01:	0f 16 9b 90 35 00 00 	movhps 0x3590(%rbx),%xmm3
   fba08:	66 0f 6f b5 d0 f4 ff 	movdqa -0xb30(%rbp),%xmm6
   fba0f:	ff 
   fba10:	44 89 9d b4 f4 ff ff 	mov    %r11d,-0xb4c(%rbp)
   fba17:	48 89 85 58 f4 ff ff 	mov    %rax,-0xba8(%rbp)
   fba1e:	8b 83 6c 05 00 00    	mov    0x56c(%rbx),%eax
   fba24:	0f 16 ab 00 06 00 00 	movhps 0x600(%rbx),%xmm5
   fba2b:	66 0f 6f bd f0 f4 ff 	movdqa -0xb10(%rbp),%xmm7
   fba32:	ff 
   fba33:	0f 29 85 a0 f8 ff ff 	movaps %xmm0,-0x760(%rbp)
   fba3a:	f3 0f 7e 93 b0 35 00 	movq   0x35b0(%rbx),%xmm2
   fba41:	00 
   fba42:	48 0f af c2          	imul   %rdx,%rax
   fba46:	0f 29 a5 c0 f8 ff ff 	movaps %xmm4,-0x740(%rbp)
   fba4d:	f3 0f 7e 8b f0 35 00 	movq   0x35f0(%rbx),%xmm1
   fba54:	00 
   fba55:	0f 16 93 d0 35 00 00 	movhps 0x35d0(%rbx),%xmm2
   fba5c:	4c 89 bd 40 f8 ff ff 	mov    %r15,-0x7c0(%rbp)
   fba63:	0f 16 8b 50 06 00 00 	movhps 0x650(%rbx),%xmm1
   fba6a:	89 bd bc f4 ff ff    	mov    %edi,-0xb44(%rbp)
   fba70:	48 89 85 98 f5 ff ff 	mov    %rax,-0xa68(%rbp)
   fba77:	8b 83 d4 05 00 00    	mov    0x5d4(%rbx),%eax
   fba7d:	0f 29 b5 10 f8 ff ff 	movaps %xmm6,-0x7f0(%rbp)
   fba84:	85 c0                	test   %eax,%eax
   fba86:	48 89 c1             	mov    %rax,%rcx
   fba89:	66 48 0f 6e c0       	movq   %rax,%xmm0
   fba8e:	0f 29 bd 20 f8 ff ff 	movaps %xmm7,-0x7e0(%rbp)
   fba95:	0f 95 85 2d f5 ff ff 	setne  -0xad3(%rbp)
   fba9c:	48 8d 85 a0 f8 ff ff 	lea    -0x760(%rbp),%rax
   fbaa3:	0f 29 ad b0 f8 ff ff 	movaps %xmm5,-0x750(%rbp)
   fbaaa:	48 0f af ca          	imul   %rdx,%rcx
   fbaae:	0f 29 9d d0 f8 ff ff 	movaps %xmm3,-0x730(%rbp)
   fbab5:	44 8b 83 e0 02 00 00 	mov    0x2e0(%rbx),%r8d
   fbabc:	4c 8b 9d 08 f5 ff ff 	mov    -0xaf8(%rbp),%r11
   fbac3:	48 89 85 b8 f7 ff ff 	mov    %rax,-0x848(%rbp)
   fbaca:	48 89 85 f0 f7 ff ff 	mov    %rax,-0x810(%rbp)
   fbad1:	8b 83 18 03 00 00    	mov    0x318(%rbx),%eax
   fbad7:	45 85 c0             	test   %r8d,%r8d
   fbada:	66 48 0f 6e e1       	movq   %rcx,%xmm4
   fbadf:	0f 95 85 2e f5 ff ff 	setne  -0xad2(%rbp)
   fbae6:	48 8d 8d 2d f5 ff ff 	lea    -0xad3(%rbp),%rcx
   fbaed:	66 0f 6c c4          	punpcklqdq %xmm4,%xmm0
   fbaf1:	48 0f af c2          	imul   %rdx,%rax
   fbaf5:	48 89 b5 10 f9 ff ff 	mov    %rsi,-0x6f0(%rbp)
   fbafc:	48 8b b5 00 f5 ff ff 	mov    -0xb00(%rbp),%rsi
   fbb03:	48 89 8d e0 f7 ff ff 	mov    %rcx,-0x820(%rbp)
   fbb0a:	89 f9                	mov    %edi,%ecx
   fbb0c:	48 89 9d b0 f7 ff ff 	mov    %rbx,-0x850(%rbp)
   fbb13:	48 89 85 a0 f5 ff ff 	mov    %rax,-0xa60(%rbp)
   fbb1a:	0f b6 43 40          	movzbl 0x40(%rbx),%eax
   fbb1e:	48 89 b5 c0 f7 ff ff 	mov    %rsi,-0x840(%rbp)
   fbb25:	4c 89 9d c8 f7 ff ff 	mov    %r11,-0x838(%rbp)
   fbb2c:	4c 89 bd d0 f7 ff ff 	mov    %r15,-0x830(%rbp)
   fbb33:	48 89 9d e8 f7 ff ff 	mov    %rbx,-0x818(%rbp)
   fbb3a:	48 89 b5 f8 f7 ff ff 	mov    %rsi,-0x808(%rbp)
   fbb41:	4c 89 9d 00 f8 ff ff 	mov    %r11,-0x800(%rbp)
   fbb48:	4c 89 bd 08 f8 ff ff 	mov    %r15,-0x7f8(%rbp)
   fbb4f:	0f 29 95 e0 f8 ff ff 	movaps %xmm2,-0x720(%rbp)
   fbb56:	0f 29 8d f0 f8 ff ff 	movaps %xmm1,-0x710(%rbp)
   fbb5d:	0f 29 85 00 f9 ff ff 	movaps %xmm0,-0x700(%rbp)
   fbb64:	84 c0                	test   %al,%al
   fbb66:	0f 85 b4 5c 00 00    	jne    101820 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x67c0>
   fbb6c:	8b b3 88 00 00 00    	mov    0x88(%rbx),%esi
   fbb72:	88 85 2f f5 ff ff    	mov    %al,-0xad1(%rbp)
   fbb78:	c7 85 f0 f4 ff ff 00 	movl   $0x0,-0xb10(%rbp)
   fbb7f:	00 00 00 
   fbb82:	89 b5 d0 f4 ff ff    	mov    %esi,-0xb30(%rbp)
   fbb88:	89 b5 44 f5 ff ff    	mov    %esi,-0xabc(%rbp)
   fbb8e:	83 fe 02             	cmp    $0x2,%esi
   fbb91:	75 0d                	jne    fbba0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xb40>
   fbb93:	f3 0f 10 63 0c       	movss  0xc(%rbx),%xmm4
   fbb98:	f3 0f 11 a5 f0 f4 ff 	movss  %xmm4,-0xb10(%rbp)
   fbb9f:	ff 
   fbba0:	48 0f af ca          	imul   %rdx,%rcx
   fbba4:	48 8d 95 28 f5 ff ff 	lea    -0xad8(%rbp),%rdx
   fbbab:	4c 89 b5 58 f8 ff ff 	mov    %r14,-0x7a8(%rbp)
   fbbb2:	48 89 95 50 f8 ff ff 	mov    %rdx,-0x7b0(%rbp)
   fbbb9:	48 8b 95 00 f5 ff ff 	mov    -0xb00(%rbp),%rdx
   fbbc0:	48 89 9d 70 f8 ff ff 	mov    %rbx,-0x790(%rbp)
   fbbc7:	48 89 8d 80 f4 ff ff 	mov    %rcx,-0xb80(%rbp)
   fbbce:	48 8b 8d 60 f4 ff ff 	mov    -0xba0(%rbp),%rcx
   fbbd5:	48 89 95 60 f8 ff ff 	mov    %rdx,-0x7a0(%rbp)
   fbbdc:	48 8d 95 80 f5 ff ff 	lea    -0xa80(%rbp),%rdx
   fbbe3:	48 89 8d 68 f8 ff ff 	mov    %rcx,-0x798(%rbp)
   fbbea:	48 8d 8d 38 f5 ff ff 	lea    -0xac8(%rbp),%rcx
   fbbf1:	48 89 95 38 f4 ff ff 	mov    %rdx,-0xbc8(%rbp)
   fbbf8:	48 89 95 80 f8 ff ff 	mov    %rdx,-0x780(%rbp)
   fbbff:	48 8b 95 08 f5 ff ff 	mov    -0xaf8(%rbp),%rdx
   fbc06:	48 89 8d a0 f4 ff ff 	mov    %rcx,-0xb60(%rbp)
   fbc0d:	48 89 8d 78 f8 ff ff 	mov    %rcx,-0x788(%rbp)
   fbc14:	48 8d 8d 58 f5 ff ff 	lea    -0xaa8(%rbp),%rcx
   fbc1b:	48 89 95 88 f8 ff ff 	mov    %rdx,-0x778(%rbp)
   fbc22:	4c 89 bd 90 f8 ff ff 	mov    %r15,-0x770(%rbp)
   fbc29:	48 89 8d 70 f4 ff ff 	mov    %rcx,-0xb90(%rbp)
   fbc30:	48 89 8d 98 f8 ff ff 	mov    %rcx,-0x768(%rbp)
   fbc37:	84 c0                	test   %al,%al
   fbc39:	0f 85 f1 58 00 00    	jne    101530 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x64d0>
   fbc3f:	80 bd 28 f5 ff ff 00 	cmpb   $0x0,-0xad8(%rbp)
   fbc46:	0f 85 5c 58 00 00    	jne    1014a8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6448>
   fbc4c:	48 83 bb 70 2c 00 00 	cmpq   $0x0,0x2c70(%rbx)
   fbc53:	00 
   fbc54:	75 0e                	jne    fbc64 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xc04>
   fbc56:	48 83 bb b0 2c 00 00 	cmpq   $0x0,0x2cb0(%rbx)
   fbc5d:	00 
   fbc5e:	0f 84 82 00 00 00    	je     fbce6 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xc86>
   fbc64:	48 8b 05 25 c3 0f 00 	mov    0xfc325(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fbc6b:	48 8b bb 30 2c 00 00 	mov    0x2c30(%rbx),%rdi
   fbc72:	c7 85 c8 f9 ff ff 01 	movl   $0x1,-0x638(%rbp)
   fbc79:	00 00 00 
   fbc7c:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fbc83:	48 89 85 c0 f9 ff ff 	mov    %rax,-0x640(%rbp)
   fbc8a:	e8 d1 10 f7 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fbc8f:	8b 8d c8 f9 ff ff    	mov    -0x638(%rbp),%ecx
   fbc95:	45 31 c0             	xor    %r8d,%r8d
   fbc98:	4d 89 e1             	mov    %r12,%r9
   fbc9b:	89 85 60 fa ff ff    	mov    %eax,-0x5a0(%rbp)
   fbca1:	48 8b 95 c0 f9 ff ff 	mov    -0x640(%rbp),%rdx
   fbca8:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
   fbcaf:	00 00 00 
   fbcb2:	48 89 85 64 fa ff ff 	mov    %rax,-0x59c(%rbp)
   fbcb9:	48 8b bd 60 fa ff ff 	mov    -0x5a0(%rbp),%rdi
   fbcc0:	8b b5 68 fa ff ff    	mov    -0x598(%rbp),%esi
   fbcc6:	e8 e5 32 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fbccb:	85 c0                	test   %eax,%eax
   fbccd:	0f 84 c5 67 00 00    	je     102498 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7438>
   fbcd3:	e8 b8 0b f7 ff       	call   6c890 <cudaGetLastError@plt>
   fbcd8:	48 8d 35 51 92 0f 00 	lea    0xf9251(%rip),%rsi        # 1f4f30 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5030>
   fbcdf:	89 c7                	mov    %eax,%edi
   fbce1:	e8 1a 20 f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fbce6:	48 83 bb f0 2c 00 00 	cmpq   $0x0,0x2cf0(%rbx)
   fbced:	00 
   fbcee:	0f 85 9c 5a 00 00    	jne    101790 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6730>
   fbcf4:	48 8b 05 95 c2 0f 00 	mov    0xfc295(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fbcfb:	48 8b 15 8e c2 0f 00 	mov    0xfc28e(%rip),%rdx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fbd02:	45 31 c0             	xor    %r8d,%r8d
   fbd05:	b9 01 00 00 00       	mov    $0x1,%ecx
   fbd0a:	4c 8b 8d 10 f5 ff ff 	mov    -0xaf0(%rbp),%r9
   fbd11:	c7 85 c8 f9 ff ff 01 	movl   $0x1,-0x638(%rbp)
   fbd18:	00 00 00 
   fbd1b:	48 89 85 c0 f9 ff ff 	mov    %rax,-0x640(%rbp)
   fbd22:	8b 85 18 f5 ff ff    	mov    -0xae8(%rbp),%eax
   fbd28:	89 85 60 fa ff ff    	mov    %eax,-0x5a0(%rbp)
   fbd2e:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
   fbd35:	00 00 00 
   fbd38:	48 89 85 64 fa ff ff 	mov    %rax,-0x59c(%rbp)
   fbd3f:	48 8b bd 60 fa ff ff 	mov    -0x5a0(%rbp),%rdi
   fbd46:	8b b5 68 fa ff ff    	mov    -0x598(%rbp),%esi
   fbd4c:	e8 5f 32 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fbd51:	85 c0                	test   %eax,%eax
   fbd53:	0f 85 29 01 00 00    	jne    fbe82 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xe22>
   fbd59:	48 8b 85 58 f5 ff ff 	mov    -0xaa8(%rbp),%rax
   fbd60:	48 89 85 c8 f4 ff ff 	mov    %rax,-0xb38(%rbp)
   fbd67:	48 8b 85 60 f5 ff ff 	mov    -0xaa0(%rbp),%rax
   fbd6e:	48 89 85 c0 f4 ff ff 	mov    %rax,-0xb40(%rbp)
   fbd75:	48 8b 83 e0 2e 00 00 	mov    0x2ee0(%rbx),%rax
   fbd7c:	48 89 85 68 f4 ff ff 	mov    %rax,-0xb98(%rbp)
   fbd83:	48 8b 83 80 30 00 00 	mov    0x3080(%rbx),%rax
   fbd8a:	48 89 85 50 f4 ff ff 	mov    %rax,-0xbb0(%rbp)
   fbd91:	48 8b 83 60 30 00 00 	mov    0x3060(%rbx),%rax
   fbd98:	48 89 85 30 f4 ff ff 	mov    %rax,-0xbd0(%rbp)
   fbd9f:	48 8b 83 b0 33 00 00 	mov    0x33b0(%rbx),%rax
   fbda6:	48 89 85 28 f4 ff ff 	mov    %rax,-0xbd8(%rbp)
   fbdad:	31 c0                	xor    %eax,%eax
   fbdaf:	48 83 bb 00 01 00 00 	cmpq   $0x0,0x100(%rbx)
   fbdb6:	00 
   fbdb7:	0f 85 03 5e 00 00    	jne    101bc0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6b60>
   fbdbd:	83 bd e4 f4 ff ff 01 	cmpl   $0x1,-0xb1c(%rbp)
   fbdc4:	f3 0f 10 5b 0c       	movss  0xc(%rbx),%xmm3
   fbdc9:	66 0f ef e4          	pxor   %xmm4,%xmm4
   fbdcd:	4c 8b ab c0 00 00 00 	mov    0xc0(%rbx),%r13
   fbdd4:	4c 8b a3 a0 2e 00 00 	mov    0x2ea0(%rbx),%r12
   fbddb:	0f 85 cf 5d 00 00    	jne    101bb0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6b50>
   fbde1:	48 8b 95 08 f5 ff ff 	mov    -0xaf8(%rbp),%rdx
   fbde8:	4c 8b 9b 80 2e 00 00 	mov    0x2e80(%rbx),%r11
   fbdef:	4c 8b 93 60 2e 00 00 	mov    0x2e60(%rbx),%r10
   fbdf6:	48 8b bb 40 2e 00 00 	mov    0x2e40(%rbx),%rdi
   fbdfd:	4c 8b 02             	mov    (%rdx),%r8
   fbe00:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
   fbe04:	31 d2                	xor    %edx,%edx
   fbe06:	83 bb 90 00 00 00 01 	cmpl   $0x1,0x90(%rbx)
   fbe0d:	48 8b b3 20 2e 00 00 	mov    0x2e20(%rbx),%rsi
   fbe14:	4c 8b 8b 00 2e 00 00 	mov    0x2e00(%rbx),%r9
   fbe1b:	0f 86 c7 5e 00 00    	jbe    101ce8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6c88>
   fbe21:	48 83 ec 08          	sub    $0x8,%rsp
   fbe25:	ff b5 c8 f4 ff ff    	push   -0xb38(%rbp)
   fbe2b:	0f 28 eb             	movaps %xmm3,%xmm5
   fbe2e:	66 0f ef d2          	pxor   %xmm2,%xmm2
   fbe32:	f3 0f 10 8d f0 f4 ff 	movss  -0xb10(%rbp),%xmm1
   fbe39:	ff 
   fbe3a:	ff b5 c0 f4 ff ff    	push   -0xb40(%rbp)
   fbe40:	f3 0f 10 85 1c f5 ff 	movss  -0xae4(%rbp),%xmm0
   fbe47:	ff 
   fbe48:	ff b5 68 f4 ff ff    	push   -0xb98(%rbp)
   fbe4e:	ff b5 50 f4 ff ff    	push   -0xbb0(%rbp)
   fbe54:	ff b5 30 f4 ff ff    	push   -0xbd0(%rbp)
   fbe5a:	ff b5 28 f4 ff ff    	push   -0xbd8(%rbp)
   fbe60:	50                   	push   %rax
   fbe61:	41 55                	push   %r13
   fbe63:	41 54                	push   %r12
   fbe65:	41 53                	push   %r11
   fbe67:	41 52                	push   %r10
   fbe69:	57                   	push   %rdi
   fbe6a:	48 8b bb 98 00 00 00 	mov    0x98(%rbx),%rdi
   fbe71:	56                   	push   %rsi
   fbe72:	48 8b b3 a0 00 00 00 	mov    0xa0(%rbx),%rsi
   fbe79:	e8 b2 ee f6 ff       	call   6ad30 <synreal::kernel::initialize_step(float, glm::vec<3, float, (glm::qualifier)0> const*, unsigned long, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, float const*, float const*, float, float const*, float, float const*, float, float const*, float, float const*, float, float const*, int const*, int const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, float*, unsigned long, unsigned long)@plt>
   fbe7e:	48 83 c4 70          	add    $0x70,%rsp
   fbe82:	e8 09 0a f7 ff       	call   6c890 <cudaGetLastError@plt>
   fbe87:	48 8d 35 07 b7 0f 00 	lea    0xfb707(%rip),%rsi        # 1f7595 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x7695>
   fbe8e:	89 c7                	mov    %eax,%edi
   fbe90:	e8 6b 1e f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fbe95:	80 bd 2d f5 ff ff 00 	cmpb   $0x0,-0xad3(%rbp)
   fbe9c:	0f 84 94 00 00 00    	je     fbf36 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xed6>
   fbea2:	48 8b 85 78 f4 ff ff 	mov    -0xb88(%rbp),%rax
   fbea9:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fbeb0:	48 8b bd 08 f9 ff ff 	mov    -0x6f8(%rbp),%rdi
   fbeb7:	48 83 78 38 00       	cmpq   $0x0,0x38(%rax)
   fbebc:	0f 85 7e 5c 00 00    	jne    101b40 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6ae0>
   fbec2:	48 8b 05 c7 c0 0f 00 	mov    0xfc0c7(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fbec9:	c7 85 c8 f9 ff ff 01 	movl   $0x1,-0x638(%rbp)
   fbed0:	00 00 00 
   fbed3:	48 89 85 c0 f9 ff ff 	mov    %rax,-0x640(%rbp)
   fbeda:	e8 81 0e f7 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fbedf:	8b 8d c8 f9 ff ff    	mov    -0x638(%rbp),%ecx
   fbee5:	45 31 c0             	xor    %r8d,%r8d
   fbee8:	4d 89 e1             	mov    %r12,%r9
   fbeeb:	89 85 60 fa ff ff    	mov    %eax,-0x5a0(%rbp)
   fbef1:	48 8b 95 c0 f9 ff ff 	mov    -0x640(%rbp),%rdx
   fbef8:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
   fbeff:	00 00 00 
   fbf02:	48 89 85 64 fa ff ff 	mov    %rax,-0x59c(%rbp)
   fbf09:	48 8b bd 60 fa ff ff 	mov    -0x5a0(%rbp),%rdi
   fbf10:	8b b5 68 fa ff ff    	mov    -0x598(%rbp),%esi
   fbf16:	e8 95 30 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fbf1b:	85 c0                	test   %eax,%eax
   fbf1d:	0f 84 a1 68 00 00    	je     1027c4 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7764>
   fbf23:	e8 68 09 f7 ff       	call   6c890 <cudaGetLastError@plt>
   fbf28:	48 8d 35 89 90 0f 00 	lea    0xf9089(%rip),%rsi        # 1f4fb8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x50b8>
   fbf2f:	89 c7                	mov    %eax,%edi
   fbf31:	e8 ca 1d f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fbf36:	80 bd 26 f5 ff ff 00 	cmpb   $0x0,-0xada(%rbp)
   fbf3d:	0f 85 bd 57 00 00    	jne    101700 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x66a0>
   fbf43:	48 8b 85 60 f5 ff ff 	mov    -0xaa0(%rbp),%rax
   fbf4a:	48 8b b3 e0 2e 00 00 	mov    0x2ee0(%rbx),%rsi
   fbf51:	b9 03 00 00 00       	mov    $0x3,%ecx
   fbf56:	48 8b bb c0 2e 00 00 	mov    0x2ec0(%rbx),%rdi
   fbf5d:	4c 8b 85 10 f5 ff ff 	mov    -0xaf0(%rbp),%r8
   fbf64:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   fbf6b:	00 
   fbf6c:	e8 3f 21 f7 ff       	call   6e0b0 <cudaMemcpyAsync@plt>
   fbf71:	48 8d 35 a0 90 0f 00 	lea    0xf90a0(%rip),%rsi        # 1f5018 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5118>
   fbf78:	89 c7                	mov    %eax,%edi
   fbf7a:	e8 81 1d f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fbf7f:	8b 8d bc f4 ff ff    	mov    -0xb44(%rbp),%ecx
   fbf85:	85 c9                	test   %ecx,%ecx
   fbf87:	0f 85 eb 56 00 00    	jne    101678 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6618>
   fbf8d:	83 bd d0 f4 ff ff 03 	cmpl   $0x3,-0xb30(%rbp)
   fbf94:	0f 84 9e 50 00 00    	je     101038 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5fd8>
   fbf9a:	83 bd e4 f4 ff ff 01 	cmpl   $0x1,-0xb1c(%rbp)
   fbfa1:	75 1e                	jne    fbfc1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf61>
   fbfa3:	48 83 bd 58 f4 ff ff 	cmpq   $0x0,-0xba8(%rbp)
   fbfaa:	00 
   fbfab:	0f 85 df 66 00 00    	jne    102690 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7630>
   fbfb1:	48 8b bd 98 f5 ff ff 	mov    -0xa68(%rbp),%rdi
   fbfb8:	48 85 ff             	test   %rdi,%rdi
   fbfbb:	0f 85 4f 66 00 00    	jne    102610 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x75b0>
   fbfc1:	44 8b ab d0 00 00 00 	mov    0xd0(%rbx),%r13d
   fbfc8:	45 85 ed             	test   %r13d,%r13d
   fbfcb:	0f 85 af 4b 00 00    	jne    100b80 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5b20>
   fbfd1:	44 8b a3 98 03 00 00 	mov    0x398(%rbx),%r12d
   fbfd8:	31 ff                	xor    %edi,%edi
   fbfda:	45 85 e4             	test   %r12d,%r12d
   fbfdd:	0f 85 e5 5a 00 00    	jne    101ac8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6a68>
   fbfe3:	c6 85 30 f5 ff ff 00 	movb   $0x0,-0xad0(%rbp)
   fbfea:	45 31 ed             	xor    %r13d,%r13d
   fbfed:	31 d2                	xor    %edx,%edx
   fbfef:	31 c0                	xor    %eax,%eax
   fbff1:	83 bd e4 f4 ff ff 01 	cmpl   $0x1,-0xb1c(%rbp)
   fbff8:	88 95 31 f5 ff ff    	mov    %dl,-0xacf(%rbp)
   fbffe:	75 0e                	jne    fc00e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xfae>
   fc000:	48 83 bd 98 f5 ff ff 	cmpq   $0x0,-0xa68(%rbp)
   fc007:	00 
   fc008:	0f 85 8a 5a 00 00    	jne    101a98 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6a38>
   fc00e:	c6 85 30 f4 ff ff 00 	movb   $0x0,-0xbd0(%rbp)
   fc015:	31 f6                	xor    %esi,%esi
   fc017:	0f b6 8d 2d f5 ff ff 	movzbl -0xad3(%rbp),%ecx
   fc01e:	85 c0                	test   %eax,%eax
   fc020:	44 0f b6 85 2b f5 ff 	movzbl -0xad5(%rbp),%r8d
   fc027:	ff 
   fc028:	40 88 b5 32 f5 ff ff 	mov    %sil,-0xace(%rbp)
   fc02f:	0f 95 c0             	setne  %al
   fc032:	88 8d 33 f5 ff ff    	mov    %cl,-0xacd(%rbp)
   fc038:	45 84 c0             	test   %r8b,%r8b
   fc03b:	0f 85 4f 24 00 00    	jne    fe490 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3430>
   fc041:	0f b6 95 a8 f4 ff ff 	movzbl -0xb58(%rbp),%edx
   fc048:	80 bd 29 f5 ff ff 00 	cmpb   $0x0,-0xad7(%rbp)
   fc04f:	88 95 f0 f4 ff ff    	mov    %dl,-0xb10(%rbp)
   fc055:	0f 85 35 24 00 00    	jne    fe490 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3430>
   fc05b:	0f b6 53 41          	movzbl 0x41(%rbx),%edx
   fc05f:	84 d2                	test   %dl,%dl
   fc061:	74 15                	je     fc078 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1018>
   fc063:	0f b6 95 27 f5 ff ff 	movzbl -0xad9(%rbp),%edx
   fc06a:	44 0f b6 8d 2a f5 ff 	movzbl -0xad6(%rbp),%r9d
   fc071:	ff 
   fc072:	84 d2                	test   %dl,%dl
   fc074:	41 0f 44 d1          	cmove  %r9d,%edx
   fc078:	44 88 ad c0 f4 ff ff 	mov    %r13b,-0xb40(%rbp)
   fc07f:	45 84 ed             	test   %r13b,%r13b
   fc082:	75 1c                	jne    fc0a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1040>
   fc084:	44 0f b6 ad 2e f5 ff 	movzbl -0xad2(%rbp),%r13d
   fc08b:	ff 
   fc08c:	44 0a ad 2f f5 ff ff 	or     -0xad1(%rbp),%r13b
   fc093:	44 88 ad c0 f4 ff ff 	mov    %r13b,-0xb40(%rbp)
   fc09a:	0f 84 60 59 00 00    	je     101a00 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x69a0>
   fc0a0:	40 84 ff             	test   %dil,%dil
   fc0a3:	48 8d 93 58 2b 00 00 	lea    0x2b58(%rbx),%rdx
   fc0aa:	48 8d 8b 28 2b 00 00 	lea    0x2b28(%rbx),%rcx
   fc0b1:	4c 8b a3 a8 2b 00 00 	mov    0x2ba8(%rbx),%r12
   fc0b8:	48 0f 44 d1          	cmove  %rcx,%rdx
   fc0bc:	4c 0f af a5 60 f5 ff 	imul   -0xaa0(%rbp),%r12
   fc0c3:	ff 
   fc0c4:	22 43 1c             	and    0x1c(%rbx),%al
   fc0c7:	22 85 c0 f4 ff ff    	and    -0xb40(%rbp),%al
   fc0cd:	88 85 c8 f4 ff ff    	mov    %al,-0xb38(%rbp)
   fc0d3:	4d 85 e4             	test   %r12,%r12
   fc0d6:	48 89 95 68 f4 ff ff 	mov    %rdx,-0xb98(%rbp)
   fc0dd:	0f 95 c0             	setne  %al
   fc0e0:	22 85 f0 f4 ff ff    	and    -0xb10(%rbp),%al
   fc0e6:	88 85 50 f4 ff ff    	mov    %al,-0xbb0(%rbp)
   fc0ec:	0f 85 ee 4f 00 00    	jne    1010e0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6080>
   fc0f2:	48 c7 85 40 fc ff ff 	movq   $0x0,-0x3c0(%rbp)
   fc0f9:	00 00 00 00 
   fc0fd:	66 0f ef c0          	pxor   %xmm0,%xmm0
   fc101:	48 c7 85 48 fc ff ff 	movq   $0x0,-0x3b8(%rbp)
   fc108:	00 00 00 00 
   fc10c:	0f 29 85 30 fc ff ff 	movaps %xmm0,-0x3d0(%rbp)
   fc113:	45 84 ed             	test   %r13b,%r13b
   fc116:	0f 85 f4 50 00 00    	jne    101210 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x61b0>
   fc11c:	8b 8d e0 f4 ff ff    	mov    -0xb20(%rbp),%ecx
   fc122:	85 c9                	test   %ecx,%ecx
   fc124:	0f 8e 8e 66 00 00    	jle    1027b8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7758>
   fc12a:	4b 8d 04 a4          	lea    (%r12,%r12,4),%rax
   fc12e:	48 8d 95 40 f6 ff ff 	lea    -0x9c0(%rbp),%rdx
   fc135:	c7 85 00 f5 ff ff 00 	movl   $0x0,-0xb00(%rbp)
   fc13c:	00 00 00 
   fc13f:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fc146:	48 c1 e0 03          	shl    $0x3,%rax
   fc14a:	66 48 0f 6e fa       	movq   %rdx,%xmm7
   fc14f:	48 83 bd 40 f4 ff ff 	cmpq   $0x0,-0xbc0(%rbp)
   fc156:	00 
   fc157:	49 bf 01 00 00 00 01 	movabs $0x100000001,%r15
   fc15e:	00 00 00 
   fc161:	48 89 85 28 f4 ff ff 	mov    %rax,-0xbd8(%rbp)
   fc168:	0f 95 c0             	setne  %al
   fc16b:	22 85 a8 f4 ff ff    	and    -0xb58(%rbp),%al
   fc171:	88 85 38 f4 ff ff    	mov    %al,-0xbc8(%rbp)
   fc177:	48 8d 85 48 f6 ff ff 	lea    -0x9b8(%rbp),%rax
   fc17e:	66 48 0f 6e e8       	movq   %rax,%xmm5
   fc183:	66 0f 6c fd          	punpcklqdq %xmm5,%xmm7
   fc187:	0f 29 bd 10 f4 ff ff 	movaps %xmm7,-0xbf0(%rbp)
   fc18e:	66 90                	xchg   %ax,%ax
   fc190:	80 bd 2c f5 ff ff 00 	cmpb   $0x0,-0xad4(%rbp)
   fc197:	0f 84 06 01 00 00    	je     fc2a3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1243>
   fc19d:	48 8b 05 ec bd 0f 00 	mov    0xfbdec(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fc1a4:	48 8b bd 90 f5 ff ff 	mov    -0xa70(%rbp),%rdi
   fc1ab:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fc1b2:	00 00 00 
   fc1b5:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fc1bc:	e8 9f 0b f7 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fc1c1:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fc1c8:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   fc1ce:	4d 89 e1             	mov    %r12,%r9
   fc1d1:	45 31 c0             	xor    %r8d,%r8d
   fc1d4:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fc1da:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   fc1e1:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fc1e8:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fc1ee:	e8 bd 2d f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fc1f3:	85 c0                	test   %eax,%eax
   fc1f5:	0f 85 8e 00 00 00    	jne    fc289 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1229>
   fc1fb:	ff b5 b8 f9 ff ff    	push   -0x648(%rbp)
   fc201:	ff b5 b0 f9 ff ff    	push   -0x650(%rbp)
   fc207:	ff b5 a8 f9 ff ff    	push   -0x658(%rbp)
   fc20d:	ff b5 a0 f9 ff ff    	push   -0x660(%rbp)
   fc213:	ff b5 98 f9 ff ff    	push   -0x668(%rbp)
   fc219:	ff b5 90 f9 ff ff    	push   -0x670(%rbp)
   fc21f:	ff b5 88 f9 ff ff    	push   -0x678(%rbp)
   fc225:	ff b5 80 f9 ff ff    	push   -0x680(%rbp)
   fc22b:	ff b5 78 f9 ff ff    	push   -0x688(%rbp)
   fc231:	ff b5 70 f9 ff ff    	push   -0x690(%rbp)
   fc237:	ff b5 68 f9 ff ff    	push   -0x698(%rbp)
   fc23d:	ff b5 60 f9 ff ff    	push   -0x6a0(%rbp)
   fc243:	ff b5 58 f9 ff ff    	push   -0x6a8(%rbp)
   fc249:	ff b5 50 f9 ff ff    	push   -0x6b0(%rbp)
   fc24f:	ff b5 48 f9 ff ff    	push   -0x6b8(%rbp)
   fc255:	ff b5 40 f9 ff ff    	push   -0x6c0(%rbp)
   fc25b:	ff b5 38 f9 ff ff    	push   -0x6c8(%rbp)
   fc261:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   fc268:	ff b5 30 f9 ff ff    	push   -0x6d0(%rbp)
   fc26e:	ff b5 28 f9 ff ff    	push   -0x6d8(%rbp)
   fc274:	ff b5 20 f9 ff ff    	push   -0x6e0(%rbp)
   fc27a:	48 8b 38             	mov    (%rax),%rdi
   fc27d:	e8 0e ea f6 ff       	call   6ac90 <synreal::kernel::prepare_cable_tangents(synreal::kernel::CableView, glm::vec<3, float, (glm::qualifier)0> const*)@plt>
   fc282:	48 81 c4 a0 00 00 00 	add    $0xa0,%rsp
   fc289:	e8 02 06 f7 ff       	call   6c890 <cudaGetLastError@plt>
   fc28e:	89 c7                	mov    %eax,%edi
   fc290:	48 8d 35 e1 8e 0f 00 	lea    0xf8ee1(%rip),%rsi        # 1f5178 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5278>
   fc297:	e8 64 1a f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc29c:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fc2a3:	48 8b 85 60 f5 ff ff 	mov    -0xaa0(%rbp),%rax
   fc2aa:	48 8b b3 c0 2e 00 00 	mov    0x2ec0(%rbx),%rsi
   fc2b1:	4d 89 e0             	mov    %r12,%r8
   fc2b4:	b9 03 00 00 00       	mov    $0x3,%ecx
   fc2b9:	48 8b bb e0 2e 00 00 	mov    0x2ee0(%rbx),%rdi
   fc2c0:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   fc2c7:	00 
   fc2c8:	e8 e3 1d f7 ff       	call   6e0b0 <cudaMemcpyAsync@plt>
   fc2cd:	89 c7                	mov    %eax,%edi
   fc2cf:	48 8d 35 ca 8e 0f 00 	lea    0xf8eca(%rip),%rsi        # 1f51a0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x52a0>
   fc2d6:	e8 25 1a f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc2db:	48 8b 05 ae bc 0f 00 	mov    0xfbcae(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fc2e2:	45 31 c0             	xor    %r8d,%r8d
   fc2e5:	b9 01 00 00 00       	mov    $0x1,%ecx
   fc2ea:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fc2f1:	48 8b 15 98 bc 0f 00 	mov    0xfbc98(%rip),%rdx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fc2f8:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fc2fe:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fc305:	00 00 00 
   fc308:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fc30f:	8b 85 18 f5 ff ff    	mov    -0xae8(%rbp),%eax
   fc315:	4c 8b 8d 10 f5 ff ff 	mov    -0xaf0(%rbp),%r9
   fc31c:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fc322:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fc329:	e8 82 2c f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fc32e:	85 c0                	test   %eax,%eax
   fc330:	0f 85 88 00 00 00    	jne    fc3be <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x135e>
   fc336:	31 d2                	xor    %edx,%edx
   fc338:	48 83 bb 00 01 00 00 	cmpq   $0x0,0x100(%rbx)
   fc33f:	00 
   fc340:	4c 8b 8d 58 f5 ff ff 	mov    -0xaa8(%rbp),%r9
   fc347:	4c 8b 85 60 f5 ff ff 	mov    -0xaa0(%rbp),%r8
   fc34e:	48 8b bb 40 30 00 00 	mov    0x3040(%rbx),%rdi
   fc355:	74 07                	je     fc35e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x12fe>
   fc357:	48 8b 93 f8 00 00 00 	mov    0xf8(%rbx),%rdx
   fc35e:	48 8b 8d 08 f5 ff ff 	mov    -0xaf8(%rbp),%rcx
   fc365:	31 c0                	xor    %eax,%eax
   fc367:	48 83 79 28 00       	cmpq   $0x0,0x28(%rcx)
   fc36c:	74 04                	je     fc372 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1312>
   fc36e:	48 8b 41 20          	mov    0x20(%rcx),%rax
   fc372:	48 83 ec 08          	sub    $0x8,%rsp
   fc376:	4c 8b 93 c0 00 00 00 	mov    0xc0(%rbx),%r10
   fc37d:	48 8b 8b f8 2a 00 00 	mov    0x2af8(%rbx),%rcx
   fc384:	48 8b b3 80 30 00 00 	mov    0x3080(%rbx),%rsi
   fc38b:	41 51                	push   %r9
   fc38d:	41 50                	push   %r8
   fc38f:	f3 0f 10 85 34 f5 ff 	movss  -0xacc(%rbp),%xmm0
   fc396:	ff 
   fc397:	4c 8b 8b 18 2b 00 00 	mov    0x2b18(%rbx),%r9
   fc39e:	4c 8b 83 08 2b 00 00 	mov    0x2b08(%rbx),%r8
   fc3a5:	57                   	push   %rdi
   fc3a6:	52                   	push   %rdx
   fc3a7:	4c 89 d2             	mov    %r10,%rdx
   fc3aa:	50                   	push   %rax
   fc3ab:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   fc3b2:	48 8b 38             	mov    (%rax),%rdi
   fc3b5:	e8 96 eb f6 ff       	call   6af50 <synreal::kernel::initialize_rhs(float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, int const*, synreal::NonZeroEntry const*, unsigned long, glm::vec<3, float, (glm::qualifier)0> const*, int const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long)@plt>
   fc3ba:	48 83 c4 30          	add    $0x30,%rsp
   fc3be:	e8 cd 04 f7 ff       	call   6c890 <cudaGetLastError@plt>
   fc3c3:	89 c7                	mov    %eax,%edi
   fc3c5:	48 8d 35 e7 b1 0f 00 	lea    0xfb1e7(%rip),%rsi        # 1f75b3 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x76b3>
   fc3cc:	e8 2f 19 f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc3d1:	8b 83 e8 17 00 00    	mov    0x17e8(%rbx),%eax
   fc3d7:	85 c0                	test   %eax,%eax
   fc3d9:	0f 85 81 28 00 00    	jne    fec60 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3c00>
   fc3df:	8b 83 80 21 00 00    	mov    0x2180(%rbx),%eax
   fc3e5:	85 c0                	test   %eax,%eax
   fc3e7:	0f 85 b4 28 00 00    	jne    feca1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3c41>
   fc3ed:	80 bd 26 f5 ff ff 00 	cmpb   $0x0,-0xada(%rbp)
   fc3f4:	0f 84 eb 00 00 00    	je     fc4e5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1485>
   fc3fa:	48 8b 05 8f bb 0f 00 	mov    0xfbb8f(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fc401:	48 8b bd 78 f5 ff ff 	mov    -0xa88(%rbp),%rdi
   fc408:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fc40f:	00 00 00 
   fc412:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fc419:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fc420:	e8 3b 09 f7 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fc425:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fc42c:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   fc432:	4d 89 e1             	mov    %r12,%r9
   fc435:	45 31 c0             	xor    %r8d,%r8d
   fc438:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fc43e:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   fc445:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fc44c:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fc452:	e8 59 2b f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fc457:	85 c0                	test   %eax,%eax
   fc459:	75 77                	jne    fc4d2 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1472>
   fc45b:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   fc462:	f3 0f 10 43 30       	movss  0x30(%rbx),%xmm0
   fc467:	48 83 ec 08          	sub    $0x8,%rsp
   fc46b:	48 8b 8b c8 32 00 00 	mov    0x32c8(%rbx),%rcx
   fc472:	48 8b 93 a8 32 00 00 	mov    0x32a8(%rbx),%rdx
   fc479:	48 8b b3 60 30 00 00 	mov    0x3060(%rbx),%rsi
   fc480:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
   fc486:	f3 0f 7e 4b 34       	movq   0x34(%rbx),%xmm1
   fc48b:	ff b5 70 f5 ff ff    	push   -0xa90(%rbp)
   fc491:	f3 0f 10 53 3c       	movss  0x3c(%rbx),%xmm2
   fc496:	ff b5 78 f5 ff ff    	push   -0xa88(%rbp)
   fc49c:	f3 0f 10 1d dc ba 0f 	movss  0xfbadc(%rip),%xmm3        # 1f7f80 <cuda::std::__4::in_place+0x33>
   fc4a3:	00 
   fc4a4:	ff b3 28 33 00 00    	push   0x3328(%rbx)
   fc4aa:	f3 0f 5e 9d 1c f5 ff 	divss  -0xae4(%rbp),%xmm3
   fc4b1:	ff 
   fc4b2:	4c 8b 8b 08 33 00 00 	mov    0x3308(%rbx),%r9
   fc4b9:	ff b3 40 30 00 00    	push   0x3040(%rbx)
   fc4bf:	4c 8b 83 e8 32 00 00 	mov    0x32e8(%rbx),%r8
   fc4c6:	48 8b 38             	mov    (%rax),%rdi
   fc4c9:	e8 e2 e6 f6 ff       	call   6abb0 <synreal::kernel::evaluate_triangle_drag(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, glm::vec<3, float, (glm::qualifier)0>, float, glm::vec<3, float, (glm::qualifier)0>*, float*, unsigned long, unsigned long, unsigned long)@plt>
   fc4ce:	48 83 c4 30          	add    $0x30,%rsp
   fc4d2:	e8 b9 03 f7 ff       	call   6c890 <cudaGetLastError@plt>
   fc4d7:	89 c7                	mov    %eax,%edi
   fc4d9:	48 8d 35 e8 8c 0f 00 	lea    0xf8ce8(%rip),%rsi        # 1f51c8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x52c8>
   fc4e0:	e8 1b 18 f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc4e5:	48 8b 83 60 30 00 00 	mov    0x3060(%rbx),%rax
   fc4ec:	f3 0f 10 b5 1c f5 ff 	movss  -0xae4(%rbp),%xmm6
   fc4f3:	ff 
   fc4f4:	80 bd 27 f5 ff ff 00 	cmpb   $0x0,-0xad9(%rbp)
   fc4fb:	4c 8b ab 40 30 00 00 	mov    0x3040(%rbx),%r13
   fc502:	48 89 85 a0 f4 ff ff 	mov    %rax,-0xb60(%rbp)
   fc509:	48 8b 83 e0 2e 00 00 	mov    0x2ee0(%rbx),%rax
   fc510:	f3 0f 11 b5 90 f4 ff 	movss  %xmm6,-0xb70(%rbp)
   fc517:	ff 
   fc518:	48 89 85 a8 f4 ff ff 	mov    %rax,-0xb58(%rbp)
   fc51f:	0f 84 82 00 00 00    	je     fc5a7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1547>
   fc525:	48 8b 05 64 ba 0f 00 	mov    0xfba64(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fc52c:	80 bd 28 f5 ff ff 00 	cmpb   $0x0,-0xad8(%rbp)
   fc533:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fc53a:	00 00 00 
   fc53d:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fc544:	41 8b 7e 10          	mov    0x10(%r14),%edi
   fc548:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fc54f:	0f 85 bb 2f 00 00    	jne    ff510 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x44b0>
   fc555:	e8 06 08 f7 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fc55a:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fc561:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   fc567:	4d 89 e1             	mov    %r12,%r9
   fc56a:	45 31 c0             	xor    %r8d,%r8d
   fc56d:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fc573:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   fc57a:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fc581:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fc587:	e8 24 2a f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fc58c:	85 c0                	test   %eax,%eax
   fc58e:	0f 84 3c 3d 00 00    	je     1002d0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5270>
   fc594:	e8 f7 02 f7 ff       	call   6c890 <cudaGetLastError@plt>
   fc599:	89 c7                	mov    %eax,%edi
   fc59b:	48 8d 35 76 8c 0f 00 	lea    0xf8c76(%rip),%rsi        # 1f5218 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5318>
   fc5a2:	e8 59 17 f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc5a7:	80 bd 29 f5 ff ff 00 	cmpb   $0x0,-0xad7(%rbp)
   fc5ae:	0f 84 46 01 00 00    	je     fc6fa <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x169a>
   fc5b4:	48 8b 05 d5 b9 0f 00 	mov    0xfb9d5(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fc5bb:	41 8b 7e 10          	mov    0x10(%r14),%edi
   fc5bf:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fc5c6:	00 00 00 
   fc5c9:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fc5d0:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fc5d7:	e8 84 07 f7 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fc5dc:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fc5e3:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   fc5e9:	4d 89 e1             	mov    %r12,%r9
   fc5ec:	45 31 c0             	xor    %r8d,%r8d
   fc5ef:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fc5f5:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   fc5fc:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fc603:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fc609:	e8 a2 29 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fc60e:	85 c0                	test   %eax,%eax
   fc610:	0f 85 d1 00 00 00    	jne    fc6e7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1687>
   fc616:	48 83 ec 08          	sub    $0x8,%rsp
   fc61a:	48 8b bb 40 30 00 00 	mov    0x3040(%rbx),%rdi
   fc621:	ff b5 40 fd ff ff    	push   -0x2c0(%rbp)
   fc627:	ff b5 38 fd ff ff    	push   -0x2c8(%rbp)
   fc62d:	ff b5 30 fd ff ff    	push   -0x2d0(%rbp)
   fc633:	ff b5 28 fd ff ff    	push   -0x2d8(%rbp)
   fc639:	ff b5 20 fd ff ff    	push   -0x2e0(%rbp)
   fc63f:	ff b5 18 fd ff ff    	push   -0x2e8(%rbp)
   fc645:	ff b5 10 fd ff ff    	push   -0x2f0(%rbp)
   fc64b:	ff b5 08 fd ff ff    	push   -0x2f8(%rbp)
   fc651:	ff b5 00 fd ff ff    	push   -0x300(%rbp)
   fc657:	ff b5 f8 fc ff ff    	push   -0x308(%rbp)
   fc65d:	ff b5 f0 fc ff ff    	push   -0x310(%rbp)
   fc663:	ff b5 e8 fc ff ff    	push   -0x318(%rbp)
   fc669:	ff b5 e0 fc ff ff    	push   -0x320(%rbp)
   fc66f:	ff b5 d8 fc ff ff    	push   -0x328(%rbp)
   fc675:	ff b5 d0 fc ff ff    	push   -0x330(%rbp)
   fc67b:	ff b5 c8 fc ff ff    	push   -0x338(%rbp)
   fc681:	ff b5 c0 fc ff ff    	push   -0x340(%rbp)
   fc687:	ff b5 b8 fc ff ff    	push   -0x348(%rbp)
   fc68d:	ff b5 b0 fc ff ff    	push   -0x350(%rbp)
   fc693:	ff b5 a8 fc ff ff    	push   -0x358(%rbp)
   fc699:	ff b5 a0 fc ff ff    	push   -0x360(%rbp)
   fc69f:	ff b5 98 fc ff ff    	push   -0x368(%rbp)
   fc6a5:	ff b5 90 fc ff ff    	push   -0x370(%rbp)
   fc6ab:	ff b5 88 fc ff ff    	push   -0x378(%rbp)
   fc6b1:	ff b5 80 fc ff ff    	push   -0x380(%rbp)
   fc6b7:	ff b5 78 fc ff ff    	push   -0x388(%rbp)
   fc6bd:	ff b5 70 fc ff ff    	push   -0x390(%rbp)
   fc6c3:	ff b5 68 fc ff ff    	push   -0x398(%rbp)
   fc6c9:	ff b5 60 fc ff ff    	push   -0x3a0(%rbp)
   fc6cf:	ff b5 58 fc ff ff    	push   -0x3a8(%rbp)
   fc6d5:	ff b5 50 fc ff ff    	push   -0x3b0(%rbp)
   fc6db:	e8 70 e1 f6 ff       	call   6a850 <synreal::kernel::evaluate_rolling_contact_force(synreal::kernel::RollingContactView, glm::vec<3, float, (glm::qualifier)0>*)@plt>
   fc6e0:	48 81 c4 00 01 00 00 	add    $0x100,%rsp
   fc6e7:	e8 a4 01 f7 ff       	call   6c890 <cudaGetLastError@plt>
   fc6ec:	89 c7                	mov    %eax,%edi
   fc6ee:	48 8d 35 4b 8b 0f 00 	lea    0xf8b4b(%rip),%rsi        # 1f5240 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5340>
   fc6f5:	e8 06 16 f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc6fa:	48 8b 83 60 30 00 00 	mov    0x3060(%rbx),%rax
   fc701:	f3 0f 10 bd 1c f5 ff 	movss  -0xae4(%rbp),%xmm7
   fc708:	ff 
   fc709:	80 bd 2a f5 ff ff 00 	cmpb   $0x0,-0xad6(%rbp)
   fc710:	4c 8b a3 40 30 00 00 	mov    0x3040(%rbx),%r12
   fc717:	48 89 85 90 f4 ff ff 	mov    %rax,-0xb70(%rbp)
   fc71e:	48 8b 83 e0 2e 00 00 	mov    0x2ee0(%rbx),%rax
   fc725:	f3 0f 11 bd a8 f4 ff 	movss  %xmm7,-0xb58(%rbp)
   fc72c:	ff 
   fc72d:	48 89 85 a0 f4 ff ff 	mov    %rax,-0xb60(%rbp)
   fc734:	0f 84 32 02 00 00    	je     fc96c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x190c>
   fc73a:	80 bd 2b f5 ff ff 00 	cmpb   $0x0,-0xad5(%rbp)
   fc741:	0f 84 81 00 00 00    	je     fc7c8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1768>
   fc747:	4d 85 e4             	test   %r12,%r12
   fc74a:	74 6e                	je     fc7ba <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x175a>
   fc74c:	48 8b 05 3d b8 0f 00 	mov    0xfb83d(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fc753:	45 31 c0             	xor    %r8d,%r8d
   fc756:	b9 01 00 00 00       	mov    $0x1,%ecx
   fc75b:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fc762:	48 8b 15 27 b8 0f 00 	mov    0xfb827(%rip),%rdx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fc769:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fc76f:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fc776:	00 00 00 
   fc779:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fc780:	8b 85 40 f5 ff ff    	mov    -0xac0(%rbp),%eax
   fc786:	4c 8b 8d 10 f5 ff ff 	mov    -0xaf0(%rbp),%r9
   fc78d:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fc793:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fc79a:	e8 11 28 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fc79f:	85 c0                	test   %eax,%eax
   fc7a1:	0f 84 e9 40 00 00    	je     100890 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5830>
   fc7a7:	e8 e4 00 f7 ff       	call   6c890 <cudaGetLastError@plt>
   fc7ac:	89 c7                	mov    %eax,%edi
   fc7ae:	48 8d 35 b3 8a 0f 00 	lea    0xf8ab3(%rip),%rsi        # 1f5268 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5368>
   fc7b5:	e8 46 15 f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc7ba:	49 83 be 50 01 00 00 	cmpq   $0x0,0x150(%r14)
   fc7c1:	00 
   fc7c2:	0f 84 a4 01 00 00    	je     fc96c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x190c>
   fc7c8:	48 8b 05 c1 b7 0f 00 	mov    0xfb7c1(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fc7cf:	41 8b be d0 00 00 00 	mov    0xd0(%r14),%edi
   fc7d6:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fc7dd:	00 00 00 
   fc7e0:	4c 8b ad 10 f5 ff ff 	mov    -0xaf0(%rbp),%r13
   fc7e7:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fc7ee:	e8 6d 05 f7 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fc7f3:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fc7fa:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   fc800:	4d 89 e9             	mov    %r13,%r9
   fc803:	45 31 c0             	xor    %r8d,%r8d
   fc806:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fc80c:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   fc813:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fc81a:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fc820:	e8 8b 27 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fc825:	85 c0                	test   %eax,%eax
   fc827:	0f 85 2c 01 00 00    	jne    fc959 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x18f9>
   fc82d:	31 c0                	xor    %eax,%eax
   fc82f:	80 bd 2b f5 ff ff 00 	cmpb   $0x0,-0xad5(%rbp)
   fc836:	4d 8b 86 50 01 00 00 	mov    0x150(%r14),%r8
   fc83d:	74 07                	je     fc846 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x17e6>
   fc83f:	49 8b 86 48 01 00 00 	mov    0x148(%r14),%rax
   fc846:	48 83 ec 08          	sub    $0x8,%rsp
   fc84a:	f3 0f 10 83 c8 07 00 	movss  0x7c8(%rbx),%xmm0
   fc851:	00 
   fc852:	49 8b 8e e8 00 00 00 	mov    0xe8(%r14),%rcx
   fc859:	49 8b 96 d8 00 00 00 	mov    0xd8(%r14),%rdx
   fc860:	41 8b b6 d0 00 00 00 	mov    0xd0(%r14),%esi
   fc867:	6a 00                	push   $0x0
   fc869:	6a 00                	push   $0x0
   fc86b:	49 8b be c0 00 00 00 	mov    0xc0(%r14),%rdi
   fc872:	41 50                	push   %r8
   fc874:	50                   	push   %rax
   fc875:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   fc87c:	ff b5 a0 f4 ff ff    	push   -0xb60(%rbp)
   fc882:	41 54                	push   %r12
   fc884:	ff b5 90 f4 ff ff    	push   -0xb70(%rbp)
   fc88a:	ff 70 10             	push   0x10(%rax)
   fc88d:	ff 30                	push   (%rax)
   fc88f:	8b 83 98 03 00 00    	mov    0x398(%rbx),%eax
   fc895:	50                   	push   %rax
   fc896:	8b 85 38 f5 ff ff    	mov    -0xac8(%rbp),%eax
   fc89c:	ff b3 e0 03 00 00    	push   0x3e0(%rbx)
   fc8a2:	ff b3 d0 03 00 00    	push   0x3d0(%rbx)
   fc8a8:	ff b3 f0 03 00 00    	push   0x3f0(%rbx)
   fc8ae:	ff b5 80 f5 ff ff    	push   -0xa80(%rbp)
   fc8b4:	50                   	push   %rax
   fc8b5:	8b 83 10 07 00 00    	mov    0x710(%rbx),%eax
   fc8bb:	50                   	push   %rax
   fc8bc:	f3 0f 10 25 bc b6 0f 	movss  0xfb6bc(%rip),%xmm4        # 1f7f80 <cuda::std::__4::in_place+0x33>
   fc8c3:	00 
   fc8c4:	f3 0f 5e a5 a8 f4 ff 	divss  -0xb58(%rbp),%xmm4
   fc8cb:	ff 
   fc8cc:	ff b3 88 07 00 00    	push   0x788(%rbx)
   fc8d2:	ff b3 78 07 00 00    	push   0x778(%rbx)
   fc8d8:	ff b3 68 07 00 00    	push   0x768(%rbx)
   fc8de:	ff b3 58 07 00 00    	push   0x758(%rbx)
   fc8e4:	ff b3 b8 07 00 00    	push   0x7b8(%rbx)
   fc8ea:	ff b3 48 07 00 00    	push   0x748(%rbx)
   fc8f0:	ff b3 38 07 00 00    	push   0x738(%rbx)
   fc8f6:	ff b3 28 07 00 00    	push   0x728(%rbx)
   fc8fc:	ff b3 18 07 00 00    	push   0x718(%rbx)
   fc902:	ff b5 60 f5 ff ff    	push   -0xaa0(%rbp)
   fc908:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
   fc90e:	ff b3 b0 33 00 00    	push   0x33b0(%rbx)
   fc914:	ff b3 c0 00 00 00    	push   0xc0(%rbx)
   fc91a:	ff b3 18 01 00 00    	push   0x118(%rbx)
   fc920:	41 ff b6 18 01 00 00 	push   0x118(%r14)
   fc927:	f3 0f 10 9b d4 07 00 	movss  0x7d4(%rbx),%xmm3
   fc92e:	00 
   fc92f:	f3 0f 10 93 d0 07 00 	movss  0x7d0(%rbx),%xmm2
   fc936:	00 
   fc937:	f3 0f 10 8b cc 07 00 	movss  0x7cc(%rbx),%xmm1
   fc93e:	00 
   fc93f:	4d 8b 8e 08 01 00 00 	mov    0x108(%r14),%r9
   fc946:	4d 8b 86 f8 00 00 00 	mov    0xf8(%r14),%r8
   fc94d:	e8 4e e1 f6 ff       	call   6aaa0 <synreal::kernel::evaluate_soft_contact_force(int const*, unsigned long, int const*, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, int const*, unsigned long, unsigned long, int const*, int const*, synreal::Transform const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float const*, float const*, float const*, unsigned long, unsigned long, unsigned long, float, float, float, float, int const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, unsigned long, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, float*, int const*, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
   fc952:	48 81 c4 00 01 00 00 	add    $0x100,%rsp
   fc959:	e8 32 ff f6 ff       	call   6c890 <cudaGetLastError@plt>
   fc95e:	89 c7                	mov    %eax,%edi
   fc960:	48 8d 35 31 89 0f 00 	lea    0xf8931(%rip),%rsi        # 1f5298 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5398>
   fc967:	e8 94 13 f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc96c:	80 bd 2f f5 ff ff 00 	cmpb   $0x0,-0xad1(%rbp)
   fc973:	74 49                	je     fc9be <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x195e>
   fc975:	48 8b 85 60 f5 ff ff 	mov    -0xaa0(%rbp),%rax
   fc97c:	48 8b b3 e0 2e 00 00 	mov    0x2ee0(%rbx),%rsi
   fc983:	b9 03 00 00 00       	mov    $0x3,%ecx
   fc988:	48 8b bb 00 2f 00 00 	mov    0x2f00(%rbx),%rdi
   fc98f:	4c 8b 85 10 f5 ff ff 	mov    -0xaf0(%rbp),%r8
   fc996:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   fc99d:	00 
   fc99e:	e8 0d 17 f7 ff       	call   6e0b0 <cudaMemcpyAsync@plt>
   fc9a3:	89 c7                	mov    %eax,%edi
   fc9a5:	48 8d 35 1c 89 0f 00 	lea    0xf891c(%rip),%rsi        # 1f52c8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x53c8>
   fc9ac:	e8 4f 13 f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fc9b1:	80 bd 2b f5 ff ff 00 	cmpb   $0x0,-0xad5(%rbp)
   fc9b8:	0f 85 92 34 00 00    	jne    ffe50 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4df0>
   fc9be:	8b 85 b0 f4 ff ff    	mov    -0xb50(%rbp),%eax
   fc9c4:	4c 8b a3 40 30 00 00 	mov    0x3040(%rbx),%r12
   fc9cb:	85 c0                	test   %eax,%eax
   fc9cd:	0f 84 c4 00 00 00    	je     fca97 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1a37>
   fc9d3:	44 8b ab 98 04 00 00 	mov    0x498(%rbx),%r13d
   fc9da:	4c 0f af ad 80 f5 ff 	imul   -0xa80(%rbp),%r13
   fc9e1:	ff 
   fc9e2:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fc9e9:	00 00 00 
   fc9ec:	48 8b 85 10 f5 ff ff 	mov    -0xaf0(%rbp),%rax
   fc9f3:	48 8b 0d 96 b5 0f 00 	mov    0xfb596(%rip),%rcx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fc9fa:	4c 89 ef             	mov    %r13,%rdi
   fc9fd:	48 89 85 a8 f4 ff ff 	mov    %rax,-0xb58(%rbp)
   fca04:	48 89 8d 58 f7 ff ff 	mov    %rcx,-0x8a8(%rbp)
   fca0b:	e8 50 03 f7 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fca10:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fca17:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   fca1d:	45 31 c0             	xor    %r8d,%r8d
   fca20:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fca26:	4c 8b 8d a8 f4 ff ff 	mov    -0xb58(%rbp),%r9
   fca2d:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   fca34:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fca3b:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fca41:	e8 6a 25 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fca46:	85 c0                	test   %eax,%eax
   fca48:	0f 84 32 35 00 00    	je     fff80 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4f20>
   fca4e:	e8 3d fe f6 ff       	call   6c890 <cudaGetLastError@plt>
   fca53:	89 c7                	mov    %eax,%edi
   fca55:	48 8d 35 dc 88 0f 00 	lea    0xf88dc(%rip),%rsi        # 1f5338 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5438>
   fca5c:	e8 9f 12 f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fca61:	83 bd e4 f4 ff ff 01 	cmpl   $0x1,-0xb1c(%rbp)
   fca68:	75 26                	jne    fca90 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1a30>
   fca6a:	48 8b bd 58 f4 ff ff 	mov    -0xba8(%rbp),%rdi
   fca71:	48 85 ff             	test   %rdi,%rdi
   fca74:	74 1a                	je     fca90 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1a30>
   fca76:	f3 0f 10 43 0c       	movss  0xc(%rbx),%xmm0
   fca7b:	66 0f ef f6          	pxor   %xmm6,%xmm6
   fca7f:	0f 2f c6             	comiss %xmm6,%xmm0
   fca82:	0f 87 68 44 00 00    	ja     100ef0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5e90>
   fca88:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   fca8f:	00 
   fca90:	4c 8b a3 40 30 00 00 	mov    0x3040(%rbx),%r12
   fca97:	8b 85 bc f4 ff ff    	mov    -0xb44(%rbp),%eax
   fca9d:	85 c0                	test   %eax,%eax
   fca9f:	0f 84 8b 00 00 00    	je     fcb30 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ad0>
   fcaa5:	66 0f ef ed          	pxor   %xmm5,%xmm5
   fcaa9:	0f 2e 6b 0c          	ucomiss 0xc(%rbx),%xmm5
   fcaad:	7a 02                	jp     fcab1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1a51>
   fcaaf:	74 7f                	je     fcb30 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ad0>
   fcab1:	48 8b 05 d8 b4 0f 00 	mov    0xfb4d8(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fcab8:	48 8b bd 80 f4 ff ff 	mov    -0xb80(%rbp),%rdi
   fcabf:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fcac6:	00 00 00 
   fcac9:	4c 8b ad 10 f5 ff ff 	mov    -0xaf0(%rbp),%r13
   fcad0:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fcad7:	e8 84 02 f7 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fcadc:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fcae3:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   fcae9:	4d 89 e9             	mov    %r13,%r9
   fcaec:	45 31 c0             	xor    %r8d,%r8d
   fcaef:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fcaf5:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   fcafc:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fcb03:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fcb09:	e8 a2 24 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fcb0e:	85 c0                	test   %eax,%eax
   fcb10:	0f 84 a2 3a 00 00    	je     1005b8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5558>
   fcb16:	e8 75 fd f6 ff       	call   6c890 <cudaGetLastError@plt>
   fcb1b:	89 c7                	mov    %eax,%edi
   fcb1d:	48 8d 35 7c 88 0f 00 	lea    0xf887c(%rip),%rsi        # 1f53a0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x54a0>
   fcb24:	e8 d7 11 f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fcb29:	4c 8b a3 40 30 00 00 	mov    0x3040(%rbx),%r12
   fcb30:	44 8b ad b4 f4 ff ff 	mov    -0xb4c(%rbp),%r13d
   fcb37:	45 85 ed             	test   %r13d,%r13d
   fcb3a:	0f 84 bf 00 00 00    	je     fcbff <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1b9f>
   fcb40:	44 8b ab 68 05 00 00 	mov    0x568(%rbx),%r13d
   fcb47:	4c 0f af ad 80 f5 ff 	imul   -0xa80(%rbp),%r13
   fcb4e:	ff 
   fcb4f:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fcb56:	00 00 00 
   fcb59:	48 8b 85 10 f5 ff ff 	mov    -0xaf0(%rbp),%rax
   fcb60:	48 8b 0d 29 b4 0f 00 	mov    0xfb429(%rip),%rcx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fcb67:	4c 89 ef             	mov    %r13,%rdi
   fcb6a:	48 89 85 a8 f4 ff ff 	mov    %rax,-0xb58(%rbp)
   fcb71:	48 89 8d 58 f7 ff ff 	mov    %rcx,-0x8a8(%rbp)
   fcb78:	e8 e3 01 f7 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fcb7d:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fcb84:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   fcb8a:	45 31 c0             	xor    %r8d,%r8d
   fcb8d:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fcb93:	4c 8b 8d a8 f4 ff ff 	mov    -0xb58(%rbp),%r9
   fcb9a:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   fcba1:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fcba8:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fcbae:	e8 fd 23 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fcbb3:	85 c0                	test   %eax,%eax
   fcbb5:	0f 84 35 33 00 00    	je     ffef0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4e90>
   fcbbb:	e8 d0 fc f6 ff       	call   6c890 <cudaGetLastError@plt>
   fcbc0:	89 c7                	mov    %eax,%edi
   fcbc2:	48 8d 35 0f 88 0f 00 	lea    0xf880f(%rip),%rsi        # 1f53d8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x54d8>
   fcbc9:	e8 32 11 f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fcbce:	83 bd e4 f4 ff ff 01 	cmpl   $0x1,-0xb1c(%rbp)
   fcbd5:	75 21                	jne    fcbf8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1b98>
   fcbd7:	48 8b bd 98 f5 ff ff 	mov    -0xa68(%rbp),%rdi
   fcbde:	48 85 ff             	test   %rdi,%rdi
   fcbe1:	74 15                	je     fcbf8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1b98>
   fcbe3:	f3 0f 10 43 0c       	movss  0xc(%rbx),%xmm0
   fcbe8:	66 0f ef ff          	pxor   %xmm7,%xmm7
   fcbec:	0f 2f c7             	comiss %xmm7,%xmm0
   fcbef:	0f 87 7b 43 00 00    	ja     100f70 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5f10>
   fcbf5:	0f 1f 00             	nopl   (%rax)
   fcbf8:	4c 8b a3 40 30 00 00 	mov    0x3040(%rbx),%r12
   fcbff:	80 bd 2d f5 ff ff 00 	cmpb   $0x0,-0xad3(%rbp)
   fcc06:	0f 84 95 00 00 00    	je     fcca1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1c41>
   fcc0c:	44 8b ab d4 05 00 00 	mov    0x5d4(%rbx),%r13d
   fcc13:	4c 0f af ad 80 f5 ff 	imul   -0xa80(%rbp),%r13
   fcc1a:	ff 
   fcc1b:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fcc22:	00 00 00 
   fcc25:	48 8b 85 10 f5 ff ff 	mov    -0xaf0(%rbp),%rax
   fcc2c:	48 8b 0d 5d b3 0f 00 	mov    0xfb35d(%rip),%rcx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fcc33:	4c 89 ef             	mov    %r13,%rdi
   fcc36:	48 89 85 a8 f4 ff ff 	mov    %rax,-0xb58(%rbp)
   fcc3d:	48 89 8d 58 f7 ff ff 	mov    %rcx,-0x8a8(%rbp)
   fcc44:	e8 17 01 f7 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fcc49:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fcc50:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   fcc56:	45 31 c0             	xor    %r8d,%r8d
   fcc59:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fcc5f:	4c 8b 8d a8 f4 ff ff 	mov    -0xb58(%rbp),%r9
   fcc66:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   fcc6d:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fcc74:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fcc7a:	e8 31 23 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fcc7f:	85 c0                	test   %eax,%eax
   fcc81:	0f 84 79 33 00 00    	je     100000 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4fa0>
   fcc87:	e8 04 fc f6 ff       	call   6c890 <cudaGetLastError@plt>
   fcc8c:	89 c7                	mov    %eax,%edi
   fcc8e:	48 8d 35 ab 87 0f 00 	lea    0xf87ab(%rip),%rsi        # 1f5440 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5540>
   fcc95:	e8 66 10 f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fcc9a:	4c 8b a3 40 30 00 00 	mov    0x3040(%rbx),%r12
   fcca1:	48 8b 85 b0 f7 ff ff 	mov    -0x850(%rbp),%rax
   fcca8:	80 b8 98 32 00 00 00 	cmpb   $0x0,0x3298(%rax)
   fccaf:	0f 84 86 00 00 00    	je     fcd3b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1cdb>
   fccb5:	48 8b 85 c0 f7 ff ff 	mov    -0x840(%rbp),%rax
   fccbc:	4c 8b 28             	mov    (%rax),%r13
   fccbf:	48 8b 05 ca b2 0f 00 	mov    0xfb2ca(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fccc6:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fcccd:	00 00 00 
   fccd0:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fccd7:	48 8b 85 b8 f7 ff ff 	mov    -0x848(%rbp),%rax
   fccde:	48 8b 78 68          	mov    0x68(%rax),%rdi
   fcce2:	e8 79 00 f7 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fcce7:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fccee:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   fccf4:	4d 89 e9             	mov    %r13,%r9
   fccf7:	45 31 c0             	xor    %r8d,%r8d
   fccfa:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fcd00:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   fcd07:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fcd0e:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fcd14:	e8 97 22 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fcd19:	85 c0                	test   %eax,%eax
   fcd1b:	0f 84 c7 33 00 00    	je     1000e8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5088>
   fcd21:	e8 6a fb f6 ff       	call   6c890 <cudaGetLastError@plt>
   fcd26:	89 c7                	mov    %eax,%edi
   fcd28:	48 8d 35 39 87 0f 00 	lea    0xf8739(%rip),%rsi        # 1f5468 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5568>
   fcd2f:	e8 cc 0f f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fcd34:	4c 8b a3 40 30 00 00 	mov    0x3040(%rbx),%r12
   fcd3b:	48 8b 85 10 f8 ff ff 	mov    -0x7f0(%rbp),%rax
   fcd42:	80 38 00             	cmpb   $0x0,(%rax)
   fcd45:	0f 84 85 00 00 00    	je     fcdd0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1d70>
   fcd4b:	48 8b 85 20 f8 ff ff 	mov    -0x7e0(%rbp),%rax
   fcd52:	4c 8b 28             	mov    (%rax),%r13
   fcd55:	48 8b 05 34 b2 0f 00 	mov    0xfb234(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fcd5c:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fcd63:	00 00 00 
   fcd66:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fcd6d:	48 8b 85 18 f8 ff ff 	mov    -0x7e8(%rbp),%rax
   fcd74:	48 8b 38             	mov    (%rax),%rdi
   fcd77:	e8 e4 ff f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fcd7c:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fcd83:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   fcd89:	4d 89 e9             	mov    %r13,%r9
   fcd8c:	45 31 c0             	xor    %r8d,%r8d
   fcd8f:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fcd95:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   fcd9c:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fcda3:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fcda9:	e8 02 22 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fcdae:	85 c0                	test   %eax,%eax
   fcdb0:	0f 84 ba 33 00 00    	je     100170 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5110>
   fcdb6:	e8 d5 fa f6 ff       	call   6c890 <cudaGetLastError@plt>
   fcdbb:	89 c7                	mov    %eax,%edi
   fcdbd:	48 8d 35 c4 86 0f 00 	lea    0xf86c4(%rip),%rsi        # 1f5488 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5588>
   fcdc4:	e8 37 0f f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fcdc9:	4c 8b a3 40 30 00 00 	mov    0x3040(%rbx),%r12
   fcdd0:	48 8b 85 e0 f7 ff ff 	mov    -0x820(%rbp),%rax
   fcdd7:	80 38 00             	cmpb   $0x0,(%rax)
   fcdda:	0f 84 c0 00 00 00    	je     fcea0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1e40>
   fcde0:	48 8b 85 e8 f7 ff ff 	mov    -0x818(%rbp),%rax
   fcde7:	48 83 b8 d8 06 00 00 	cmpq   $0x0,0x6d8(%rax)
   fcdee:	00 
   fcdef:	0f 84 ab 00 00 00    	je     fcea0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1e40>
   fcdf5:	f3 0f 7e 80 f0 06 00 	movq   0x6f0(%rax),%xmm0
   fcdfc:	00 
   fcdfd:	f3 0f 7e 88 d0 06 00 	movq   0x6d0(%rax),%xmm1
   fce04:	00 
   fce05:	c7 85 f0 f6 ff ff 01 	movl   $0x1,-0x910(%rbp)
   fce0c:	00 00 00 
   fce0f:	0f 16 80 00 07 00 00 	movhps 0x700(%rax),%xmm0
   fce16:	0f 16 88 e0 06 00 00 	movhps 0x6e0(%rax),%xmm1
   fce1d:	48 8b 85 f8 f7 ff ff 	mov    -0x808(%rbp),%rax
   fce24:	0f 29 8d 70 f7 ff ff 	movaps %xmm1,-0x890(%rbp)
   fce2b:	4c 8b 28             	mov    (%rax),%r13
   fce2e:	48 8b 05 5b b1 0f 00 	mov    0xfb15b(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fce35:	0f 29 85 80 f7 ff ff 	movaps %xmm0,-0x880(%rbp)
   fce3c:	48 89 85 e8 f6 ff ff 	mov    %rax,-0x918(%rbp)
   fce43:	48 8b 85 f0 f7 ff ff 	mov    -0x810(%rbp),%rax
   fce4a:	48 8b 78 68          	mov    0x68(%rax),%rdi
   fce4e:	e8 0d ff f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fce53:	4c 89 bd 2c f7 ff ff 	mov    %r15,-0x8d4(%rbp)
   fce5a:	8b 8d f0 f6 ff ff    	mov    -0x910(%rbp),%ecx
   fce60:	4d 89 e9             	mov    %r13,%r9
   fce63:	45 31 c0             	xor    %r8d,%r8d
   fce66:	89 85 28 f7 ff ff    	mov    %eax,-0x8d8(%rbp)
   fce6c:	48 8b 95 e8 f6 ff ff 	mov    -0x918(%rbp),%rdx
   fce73:	48 8b bd 28 f7 ff ff 	mov    -0x8d8(%rbp),%rdi
   fce7a:	8b b5 30 f7 ff ff    	mov    -0x8d0(%rbp),%esi
   fce80:	e8 2b 21 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fce85:	85 c0                	test   %eax,%eax
   fce87:	0f 84 a3 37 00 00    	je     100630 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x55d0>
   fce8d:	e8 fe f9 f6 ff       	call   6c890 <cudaGetLastError@plt>
   fce92:	89 c7                	mov    %eax,%edi
   fce94:	48 8d 35 15 86 0f 00 	lea    0xf8615(%rip),%rsi        # 1f54b0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x55b0>
   fce9b:	e8 60 0e f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fcea0:	80 bd 2f f5 ff ff 00 	cmpb   $0x0,-0xad1(%rbp)
   fcea7:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fceae:	0f 85 2c 1e 00 00    	jne    fece0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3c80>
   fceb4:	44 8b 9b 98 03 00 00 	mov    0x398(%rbx),%r11d
   fcebb:	45 85 db             	test   %r11d,%r11d
   fcebe:	74 3e                	je     fcefe <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1e9e>
   fcec0:	f3 0f 10 43 0c       	movss  0xc(%rbx),%xmm0
   fcec5:	66 0f ef e4          	pxor   %xmm4,%xmm4
   fcec9:	0f 2f c4             	comiss %xmm4,%xmm0
   fcecc:	0f 97 c0             	seta   %al
   fcecf:	83 bd d0 f4 ff ff 02 	cmpl   $0x2,-0xb30(%rbp)
   fced6:	75 08                	jne    fcee0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1e80>
   fced8:	84 c0                	test   %al,%al
   fceda:	0f 85 10 3f 00 00    	jne    100df0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5d90>
   fcee0:	83 bd d0 f4 ff ff 03 	cmpl   $0x3,-0xb30(%rbp)
   fcee7:	75 08                	jne    fcef1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1e91>
   fcee9:	84 c0                	test   %al,%al
   fceeb:	0f 85 7f 3f 00 00    	jne    100e70 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5e10>
   fcef1:	66 0f ef e4          	pxor   %xmm4,%xmm4
   fcef5:	0f 2f c4             	comiss %xmm4,%xmm0
   fcef8:	0f 87 32 2e 00 00    	ja     ffd30 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4cd0>
   fcefe:	44 8b ab 40 02 00 00 	mov    0x240(%rbx),%r13d
   fcf05:	45 85 ed             	test   %r13d,%r13d
   fcf08:	0f 85 92 1c 00 00    	jne    feba0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3b40>
   fcf0e:	44 8b ab 78 02 00 00 	mov    0x278(%rbx),%r13d
   fcf15:	45 85 ed             	test   %r13d,%r13d
   fcf18:	0f 85 b2 1b 00 00    	jne    fead0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3a70>
   fcf1e:	80 bd 2e f5 ff ff 00 	cmpb   $0x0,-0xad2(%rbp)
   fcf25:	0f 85 a5 1a 00 00    	jne    fe9d0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3970>
   fcf2b:	8b 93 18 03 00 00    	mov    0x318(%rbx),%edx
   fcf31:	85 d2                	test   %edx,%edx
   fcf33:	0f 85 bf 19 00 00    	jne    fe8f8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3898>
   fcf39:	80 bd c0 f4 ff ff 00 	cmpb   $0x0,-0xb40(%rbp)
   fcf40:	0f 84 3a 16 00 00    	je     fe580 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3520>
   fcf46:	45 31 ed             	xor    %r13d,%r13d
   fcf49:	80 bd f0 f4 ff ff 00 	cmpb   $0x0,-0xb10(%rbp)
   fcf50:	75 07                	jne    fcf59 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ef9>
   fcf52:	4c 8b ab 60 2f 00 00 	mov    0x2f60(%rbx),%r13
   fcf59:	48 8b 05 30 b0 0f 00 	mov    0xfb030(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fcf60:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fcf67:	4d 89 e1             	mov    %r12,%r9
   fcf6a:	45 31 c0             	xor    %r8d,%r8d
   fcf6d:	48 8b 15 1c b0 0f 00 	mov    0xfb01c(%rip),%rdx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fcf74:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fcf7a:	b9 01 00 00 00       	mov    $0x1,%ecx
   fcf7f:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fcf86:	00 00 00 
   fcf89:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fcf90:	8b 85 18 f5 ff ff    	mov    -0xae8(%rbp),%eax
   fcf96:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fcf9c:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fcfa3:	e8 08 20 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fcfa8:	85 c0                	test   %eax,%eax
   fcfaa:	75 1d                	jne    fcfc9 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1f69>
   fcfac:	48 8b b3 40 2f 00 00 	mov    0x2f40(%rbx),%rsi
   fcfb3:	48 8b bb e0 2e 00 00 	mov    0x2ee0(%rbx),%rdi
   fcfba:	4c 89 ea             	mov    %r13,%rdx
   fcfbd:	48 8b 8d 60 f5 ff ff 	mov    -0xaa0(%rbp),%rcx
   fcfc4:	e8 07 de f6 ff       	call   6add0 <synreal::kernel::initialize_block_diagonal(float const*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long)@plt>
   fcfc9:	e8 c2 f8 f6 ff       	call   6c890 <cudaGetLastError@plt>
   fcfce:	89 c7                	mov    %eax,%edi
   fcfd0:	48 8d 35 41 86 0f 00 	lea    0xf8641(%rip),%rsi        # 1f5618 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5718>
   fcfd7:	e8 24 0d f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fcfdc:	80 bd f0 f4 ff ff 00 	cmpb   $0x0,-0xb10(%rbp)
   fcfe3:	0f 84 3b 03 00 00    	je     fd324 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x22c4>
   fcfe9:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fcff0:	48 8b 83 e0 2d 00 00 	mov    0x2de0(%rbx),%rax
   fcff7:	80 bd 50 f4 ff ff 00 	cmpb   $0x0,-0xbb0(%rbp)
   fcffe:	48 89 85 90 f4 ff ff 	mov    %rax,-0xb70(%rbp)
   fd005:	0f 85 f5 2d 00 00    	jne    ffe00 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4da0>
   fd00b:	48 8b 83 40 2f 00 00 	mov    0x2f40(%rbx),%rax
   fd012:	48 89 85 a8 f4 ff ff 	mov    %rax,-0xb58(%rbp)
   fd019:	48 8b 83 88 2b 00 00 	mov    0x2b88(%rbx),%rax
   fd020:	48 89 85 70 f4 ff ff 	mov    %rax,-0xb90(%rbp)
   fd027:	48 8b 83 a8 2b 00 00 	mov    0x2ba8(%rbx),%rax
   fd02e:	48 89 85 a0 f4 ff ff 	mov    %rax,-0xb60(%rbp)
   fd035:	8b 85 8c f4 ff ff    	mov    -0xb74(%rbp),%eax
   fd03b:	85 c0                	test   %eax,%eax
   fd03d:	0f 85 05 1f 00 00    	jne    fef48 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3ee8>
   fd043:	44 8b ab 78 02 00 00 	mov    0x278(%rbx),%r13d
   fd04a:	45 85 ed             	test   %r13d,%r13d
   fd04d:	0f 85 7d 36 00 00    	jne    1006d0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5670>
   fd053:	44 8b ab 40 02 00 00 	mov    0x240(%rbx),%r13d
   fd05a:	45 85 ed             	test   %r13d,%r13d
   fd05d:	0f 85 56 37 00 00    	jne    1007b9 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5759>
   fd063:	8b 83 98 03 00 00    	mov    0x398(%rbx),%eax
   fd069:	85 c0                	test   %eax,%eax
   fd06b:	74 0d                	je     fd07a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x201a>
   fd06d:	83 bd d0 f4 ff ff 02 	cmpl   $0x2,-0xb30(%rbp)
   fd074:	0f 84 86 3f 00 00    	je     101000 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5fa0>
   fd07a:	80 bd 38 f4 ff ff 00 	cmpb   $0x0,-0xbc8(%rbp)
   fd081:	0f 84 05 01 00 00    	je     fd18c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x212c>
   fd087:	4c 8b ad 40 f4 ff ff 	mov    -0xbc0(%rbp),%r13
   fd08e:	4c 0f af ad 80 f5 ff 	imul   -0xa80(%rbp),%r13
   fd095:	ff 
   fd096:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fd09d:	00 00 00 
   fd0a0:	48 8b 05 e9 ae 0f 00 	mov    0xfaee9(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fd0a7:	4c 89 ef             	mov    %r13,%rdi
   fd0aa:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fd0b1:	e8 aa fc f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fd0b6:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fd0bd:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   fd0c3:	4d 89 e1             	mov    %r12,%r9
   fd0c6:	45 31 c0             	xor    %r8d,%r8d
   fd0c9:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fd0cf:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   fd0d6:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fd0dd:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fd0e3:	e8 c8 1e f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fd0e8:	85 c0                	test   %eax,%eax
   fd0ea:	75 78                	jne    fd164 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2104>
   fd0ec:	48 83 ec 08          	sub    $0x8,%rsp
   fd0f0:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   fd0f7:	48 8b 8b b0 04 00 00 	mov    0x4b0(%rbx),%rcx
   fd0fe:	48 8b 93 a0 04 00 00 	mov    0x4a0(%rbx),%rdx
   fd105:	48 8b b3 d0 03 00 00 	mov    0x3d0(%rbx),%rsi
   fd10c:	ff b5 60 f5 ff ff    	push   -0xaa0(%rbp)
   fd112:	4c 8b 83 c0 04 00 00 	mov    0x4c0(%rbx),%r8
   fd119:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
   fd11f:	48 8b 38             	mov    (%rax),%rdi
   fd122:	ff b5 40 f4 ff ff    	push   -0xbc0(%rbp)
   fd128:	41 55                	push   %r13
   fd12a:	ff b5 a0 f4 ff ff    	push   -0xb60(%rbp)
   fd130:	ff b5 90 f4 ff ff    	push   -0xb70(%rbp)
   fd136:	ff b5 70 f4 ff ff    	push   -0xb90(%rbp)
   fd13c:	ff b5 a8 f4 ff ff    	push   -0xb58(%rbp)
   fd142:	ff b3 e0 04 00 00    	push   0x4e0(%rbx)
   fd148:	ff b3 d0 04 00 00    	push   0x4d0(%rbx)
   fd14e:	ff b3 f0 33 00 00    	push   0x33f0(%rbx)
   fd154:	4c 8b 8b d0 33 00 00 	mov    0x33d0(%rbx),%r9
   fd15b:	e8 a0 dc f6 ff       	call   6ae00 <synreal::kernel::add_body_spring_gauss_newton_hessian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
   fd160:	48 83 c4 60          	add    $0x60,%rsp
   fd164:	e8 27 f7 f6 ff       	call   6c890 <cudaGetLastError@plt>
   fd169:	89 c7                	mov    %eax,%edi
   fd16b:	48 8d 35 86 85 0f 00 	lea    0xf8586(%rip),%rsi        # 1f56f8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x57f8>
   fd172:	e8 89 0b f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fd177:	8b 85 8c f4 ff ff    	mov    -0xb74(%rbp),%eax
   fd17d:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fd184:	85 c0                	test   %eax,%eax
   fd186:	0f 85 4c 01 00 00    	jne    fd2d8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2278>
   fd18c:	8b 85 b4 f4 ff ff    	mov    -0xb4c(%rbp),%eax
   fd192:	85 c0                	test   %eax,%eax
   fd194:	74 3a                	je     fd1d0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2170>
   fd196:	83 bd e4 f4 ff ff 01 	cmpl   $0x1,-0xb1c(%rbp)
   fd19d:	8b 83 68 05 00 00    	mov    0x568(%rbx),%eax
   fd1a3:	4c 8b ad 80 f5 ff ff 	mov    -0xa80(%rbp),%r13
   fd1aa:	0f 85 a0 39 00 00    	jne    100b50 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5af0>
   fd1b0:	89 c2                	mov    %eax,%edx
   fd1b2:	2b 93 6c 05 00 00    	sub    0x56c(%rbx),%edx
   fd1b8:	4c 0f af ea          	imul   %rdx,%r13
   fd1bc:	48 89 95 20 f4 ff ff 	mov    %rdx,-0xbe0(%rbp)
   fd1c3:	4d 85 ed             	test   %r13,%r13
   fd1c6:	0f 85 24 47 00 00    	jne    1018f0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6890>
   fd1cc:	0f 1f 40 00          	nopl   0x0(%rax)
   fd1d0:	80 bd 30 f4 ff ff 00 	cmpb   $0x0,-0xbd0(%rbp)
   fd1d7:	0f 84 fb 00 00 00    	je     fd2d8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2278>
   fd1dd:	48 8b 05 ac ad 0f 00 	mov    0xfadac(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fd1e4:	48 8b bd 98 f5 ff ff 	mov    -0xa68(%rbp),%rdi
   fd1eb:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fd1f2:	00 00 00 
   fd1f5:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fd1fc:	e8 5f fb f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fd201:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fd208:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   fd20e:	4d 89 e1             	mov    %r12,%r9
   fd211:	45 31 c0             	xor    %r8d,%r8d
   fd214:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fd21a:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   fd221:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fd228:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fd22e:	e8 7d 1d f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fd233:	85 c0                	test   %eax,%eax
   fd235:	0f 85 83 00 00 00    	jne    fd2be <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x225e>
   fd23b:	8b 83 6c 05 00 00    	mov    0x56c(%rbx),%eax
   fd241:	48 83 ec 08          	sub    $0x8,%rsp
   fd245:	48 8b 8b d0 34 00 00 	mov    0x34d0(%rbx),%rcx
   fd24c:	48 8b 93 b0 34 00 00 	mov    0x34b0(%rbx),%rdx
   fd253:	48 8b b3 70 05 00 00 	mov    0x570(%rbx),%rsi
   fd25a:	48 8b bb d0 03 00 00 	mov    0x3d0(%rbx),%rdi
   fd261:	ff b5 60 f5 ff ff    	push   -0xaa0(%rbp)
   fd267:	f3 0f 10 85 3c f5 ff 	movss  -0xac4(%rbp),%xmm0
   fd26e:	ff 
   fd26f:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
   fd275:	4c 8b 83 f0 34 00 00 	mov    0x34f0(%rbx),%r8
   fd27c:	50                   	push   %rax
   fd27d:	8b 83 68 05 00 00    	mov    0x568(%rbx),%eax
   fd283:	50                   	push   %rax
   fd284:	ff b5 98 f5 ff ff    	push   -0xa68(%rbp)
   fd28a:	ff b5 a0 f4 ff ff    	push   -0xb60(%rbp)
   fd290:	ff b5 90 f4 ff ff    	push   -0xb70(%rbp)
   fd296:	ff b5 70 f4 ff ff    	push   -0xb90(%rbp)
   fd29c:	ff b5 a8 f4 ff ff    	push   -0xb58(%rbp)
   fd2a2:	ff b3 30 35 00 00    	push   0x3530(%rbx)
   fd2a8:	ff b3 10 35 00 00    	push   0x3510(%rbx)
   fd2ae:	4c 8b 8b b0 05 00 00 	mov    0x5b0(%rbx),%r9
   fd2b5:	e8 76 d8 f6 ff       	call   6ab30 <synreal::kernel::add_joint_body_point_line_gauss_newton_hessian(glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
   fd2ba:	48 83 c4 60          	add    $0x60,%rsp
   fd2be:	e8 cd f5 f6 ff       	call   6c890 <cudaGetLastError@plt>
   fd2c3:	89 c7                	mov    %eax,%edi
   fd2c5:	48 8d 35 8c 84 0f 00 	lea    0xf848c(%rip),%rsi        # 1f5758 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5858>
   fd2cc:	e8 2f 0a f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fd2d1:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fd2d8:	48 8b 85 60 f5 ff ff 	mov    -0xaa0(%rbp),%rax
   fd2df:	48 8b bb 60 2f 00 00 	mov    0x2f60(%rbx),%rdi
   fd2e6:	4d 89 e0             	mov    %r12,%r8
   fd2e9:	b9 03 00 00 00       	mov    $0x3,%ecx
   fd2ee:	48 8b b5 a8 f4 ff ff 	mov    -0xb58(%rbp),%rsi
   fd2f5:	48 8d 14 c0          	lea    (%rax,%rax,8),%rdx
   fd2f9:	48 c1 e2 02          	shl    $0x2,%rdx
   fd2fd:	e8 ae 0d f7 ff       	call   6e0b0 <cudaMemcpyAsync@plt>
   fd302:	89 c7                	mov    %eax,%edi
   fd304:	48 8d 35 85 84 0f 00 	lea    0xf8485(%rip),%rsi        # 1f5790 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5890>
   fd30b:	e8 f0 09 f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fd310:	80 bd c0 f4 ff ff 00 	cmpb   $0x0,-0xb40(%rbp)
   fd317:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fd31e:	0f 84 69 12 00 00    	je     fe58d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x352d>
   fd324:	80 bd c8 f4 ff ff 00 	cmpb   $0x0,-0xb38(%rbp)
   fd32b:	0f 84 07 12 00 00    	je     fe538 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34d8>
   fd331:	80 bd 28 f5 ff ff 00 	cmpb   $0x0,-0xad8(%rbp)
   fd338:	0f 84 fa 11 00 00    	je     fe538 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34d8>
   fd33e:	80 7b 1d 00          	cmpb   $0x0,0x1d(%rbx)
   fd342:	0f 84 f0 11 00 00    	je     fe538 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34d8>
   fd348:	80 7b 41 00          	cmpb   $0x0,0x41(%rbx)
   fd34c:	0f 84 7e 3d 00 00    	je     1010d0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6070>
   fd352:	48 8b bb 80 2f 00 00 	mov    0x2f80(%rbx),%rdi
   fd359:	48 89 bd a8 f4 ff ff 	mov    %rdi,-0xb58(%rbp)
   fd360:	48 85 ff             	test   %rdi,%rdi
   fd363:	0f 84 02 31 00 00    	je     10046b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x540b>
   fd369:	48 8b 85 88 f5 ff ff 	mov    -0xa78(%rbp),%rax
   fd370:	48 8b 8d 10 f5 ff ff 	mov    -0xaf0(%rbp),%rcx
   fd377:	31 f6                	xor    %esi,%esi
   fd379:	48 8d 14 c0          	lea    (%rax,%rax,8),%rdx
   fd37d:	48 c1 e2 06          	shl    $0x6,%rdx
   fd381:	e8 aa 15 f7 ff       	call   6e930 <cudaMemsetAsync@plt>
   fd386:	89 c7                	mov    %eax,%edi
   fd388:	48 8d 35 39 84 0f 00 	lea    0xf8439(%rip),%rsi        # 1f57c8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x58c8>
   fd38f:	e8 6c 09 f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fd394:	80 bd 27 f5 ff ff 00 	cmpb   $0x0,-0xad9(%rbp)
   fd39b:	74 0a                	je     fd3a7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2347>
   fd39d:	80 7b 41 00          	cmpb   $0x0,0x41(%rbx)
   fd3a1:	0f 85 d9 30 00 00    	jne    100480 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5420>
   fd3a7:	80 bd 2a f5 ff ff 00 	cmpb   $0x0,-0xad6(%rbp)
   fd3ae:	0f 84 04 02 00 00    	je     fd5b8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2558>
   fd3b4:	44 8b ad 8c f4 ff ff 	mov    -0xb74(%rbp),%r13d
   fd3bb:	45 85 ed             	test   %r13d,%r13d
   fd3be:	74 0a                	je     fd3ca <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x236a>
   fd3c0:	80 7b 41 00          	cmpb   $0x0,0x41(%rbx)
   fd3c4:	0f 84 ee 01 00 00    	je     fd5b8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2558>
   fd3ca:	48 8b 83 60 2f 00 00 	mov    0x2f60(%rbx),%rax
   fd3d1:	f3 0f 10 bd 1c f5 ff 	movss  -0xae4(%rbp),%xmm7
   fd3d8:	ff 
   fd3d9:	80 bd 2b f5 ff ff 00 	cmpb   $0x0,-0xad5(%rbp)
   fd3e0:	4c 8b ab 40 2f 00 00 	mov    0x2f40(%rbx),%r13
   fd3e7:	48 89 85 70 f4 ff ff 	mov    %rax,-0xb90(%rbp)
   fd3ee:	48 8b 83 60 30 00 00 	mov    0x3060(%rbx),%rax
   fd3f5:	f3 0f 11 bd 90 f4 ff 	movss  %xmm7,-0xb70(%rbp)
   fd3fc:	ff 
   fd3fd:	48 89 85 a0 f4 ff ff 	mov    %rax,-0xb60(%rbp)
   fd404:	74 0e                	je     fd414 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x23b4>
   fd406:	49 83 be 50 01 00 00 	cmpq   $0x0,0x150(%r14)
   fd40d:	00 
   fd40e:	0f 84 a4 01 00 00    	je     fd5b8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2558>
   fd414:	48 8b 05 75 ab 0f 00 	mov    0xfab75(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fd41b:	41 8b be d0 00 00 00 	mov    0xd0(%r14),%edi
   fd422:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fd429:	00 00 00 
   fd42c:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fd433:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fd43a:	e8 21 f9 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fd43f:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fd446:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   fd44c:	4d 89 e1             	mov    %r12,%r9
   fd44f:	45 31 c0             	xor    %r8d,%r8d
   fd452:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fd458:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   fd45f:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fd466:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fd46c:	e8 3f 1b f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fd471:	85 c0                	test   %eax,%eax
   fd473:	0f 85 29 01 00 00    	jne    fd5a2 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2542>
   fd479:	31 c0                	xor    %eax,%eax
   fd47b:	80 bd 2b f5 ff ff 00 	cmpb   $0x0,-0xad5(%rbp)
   fd482:	4d 8b 86 50 01 00 00 	mov    0x150(%r14),%r8
   fd489:	0f 85 d1 47 00 00    	jne    101c60 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6c00>
   fd48f:	48 83 ec 08          	sub    $0x8,%rsp
   fd493:	f3 0f 10 83 c8 07 00 	movss  0x7c8(%rbx),%xmm0
   fd49a:	00 
   fd49b:	ff b5 70 f4 ff ff    	push   -0xb90(%rbp)
   fd4a1:	49 8b 8e e8 00 00 00 	mov    0xe8(%r14),%rcx
   fd4a8:	41 55                	push   %r13
   fd4aa:	49 8b 96 d8 00 00 00 	mov    0xd8(%r14),%rdx
   fd4b1:	41 8b b6 d0 00 00 00 	mov    0xd0(%r14),%esi
   fd4b8:	41 50                	push   %r8
   fd4ba:	50                   	push   %rax
   fd4bb:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   fd4c2:	6a 00                	push   $0x0
   fd4c4:	49 8b be c0 00 00 00 	mov    0xc0(%r14),%rdi
   fd4cb:	6a 00                	push   $0x0
   fd4cd:	ff b5 a0 f4 ff ff    	push   -0xb60(%rbp)
   fd4d3:	ff 70 10             	push   0x10(%rax)
   fd4d6:	ff 30                	push   (%rax)
   fd4d8:	8b 83 98 03 00 00    	mov    0x398(%rbx),%eax
   fd4de:	50                   	push   %rax
   fd4df:	8b 85 38 f5 ff ff    	mov    -0xac8(%rbp),%eax
   fd4e5:	ff b3 e0 03 00 00    	push   0x3e0(%rbx)
   fd4eb:	ff b3 d0 03 00 00    	push   0x3d0(%rbx)
   fd4f1:	ff b3 f0 03 00 00    	push   0x3f0(%rbx)
   fd4f7:	ff b5 80 f5 ff ff    	push   -0xa80(%rbp)
   fd4fd:	50                   	push   %rax
   fd4fe:	8b 83 10 07 00 00    	mov    0x710(%rbx),%eax
   fd504:	50                   	push   %rax
   fd505:	f3 0f 10 25 73 aa 0f 	movss  0xfaa73(%rip),%xmm4        # 1f7f80 <cuda::std::__4::in_place+0x33>
   fd50c:	00 
   fd50d:	f3 0f 5e a5 90 f4 ff 	divss  -0xb70(%rbp),%xmm4
   fd514:	ff 
   fd515:	ff b3 88 07 00 00    	push   0x788(%rbx)
   fd51b:	ff b3 78 07 00 00    	push   0x778(%rbx)
   fd521:	ff b3 68 07 00 00    	push   0x768(%rbx)
   fd527:	ff b3 58 07 00 00    	push   0x758(%rbx)
   fd52d:	ff b3 b8 07 00 00    	push   0x7b8(%rbx)
   fd533:	ff b3 48 07 00 00    	push   0x748(%rbx)
   fd539:	ff b3 38 07 00 00    	push   0x738(%rbx)
   fd53f:	ff b3 28 07 00 00    	push   0x728(%rbx)
   fd545:	ff b3 18 07 00 00    	push   0x718(%rbx)
   fd54b:	ff b5 60 f5 ff ff    	push   -0xaa0(%rbp)
   fd551:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
   fd557:	ff b3 b0 33 00 00    	push   0x33b0(%rbx)
   fd55d:	ff b3 c0 00 00 00    	push   0xc0(%rbx)
   fd563:	ff b3 18 01 00 00    	push   0x118(%rbx)
   fd569:	41 ff b6 18 01 00 00 	push   0x118(%r14)
   fd570:	f3 0f 10 9b d4 07 00 	movss  0x7d4(%rbx),%xmm3
   fd577:	00 
   fd578:	f3 0f 10 93 d0 07 00 	movss  0x7d0(%rbx),%xmm2
   fd57f:	00 
   fd580:	f3 0f 10 8b cc 07 00 	movss  0x7cc(%rbx),%xmm1
   fd587:	00 
   fd588:	4d 8b 8e 08 01 00 00 	mov    0x108(%r14),%r9
   fd58f:	4d 8b 86 f8 00 00 00 	mov    0xf8(%r14),%r8
   fd596:	e8 05 d5 f6 ff       	call   6aaa0 <synreal::kernel::evaluate_soft_contact_force(int const*, unsigned long, int const*, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, int const*, unsigned long, unsigned long, int const*, int const*, synreal::Transform const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float const*, float const*, float const*, unsigned long, unsigned long, unsigned long, float, float, float, float, int const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, unsigned long, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, float*, int const*, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
   fd59b:	48 81 c4 00 01 00 00 	add    $0x100,%rsp
   fd5a2:	e8 e9 f2 f6 ff       	call   6c890 <cudaGetLastError@plt>
   fd5a7:	89 c7                	mov    %eax,%edi
   fd5a9:	48 8d 35 e8 7c 0f 00 	lea    0xf7ce8(%rip),%rsi        # 1f5298 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5398>
   fd5b0:	e8 4b 07 f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fd5b5:	0f 1f 00             	nopl   (%rax)
   fd5b8:	80 bd 30 f5 ff ff 00 	cmpb   $0x0,-0xad0(%rbp)
   fd5bf:	0f 85 9b 26 00 00    	jne    ffc60 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4c00>
   fd5c5:	80 bd 31 f5 ff ff 01 	cmpb   $0x1,-0xacf(%rbp)
   fd5cc:	75 0d                	jne    fd5db <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x257b>
   fd5ce:	80 bd c8 f4 ff ff 00 	cmpb   $0x0,-0xb38(%rbp)
   fd5d5:	0f 84 cd 2d 00 00    	je     1003a8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5348>
   fd5db:	80 bd 2e f5 ff ff 00 	cmpb   $0x0,-0xad2(%rbp)
   fd5e2:	0f 85 98 25 00 00    	jne    ffb80 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4b20>
   fd5e8:	80 bb 40 33 00 00 00 	cmpb   $0x0,0x3340(%rbx)
   fd5ef:	0f 85 ab 24 00 00    	jne    ffaa0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4a40>
   fd5f5:	80 bd 2f f5 ff ff 00 	cmpb   $0x0,-0xad1(%rbp)
   fd5fc:	0f 85 7e 24 00 00    	jne    ffa80 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4a20>
   fd602:	44 8b 83 e8 17 00 00 	mov    0x17e8(%rbx),%r8d
   fd609:	45 85 c0             	test   %r8d,%r8d
   fd60c:	0f 85 46 24 00 00    	jne    ffa58 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x49f8>
   fd612:	8b bb 80 21 00 00    	mov    0x2180(%rbx),%edi
   fd618:	85 ff                	test   %edi,%edi
   fd61a:	0f 85 a0 20 00 00    	jne    ff6c0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4660>
   fd620:	80 bd 2b f5 ff ff 00 	cmpb   $0x0,-0xad5(%rbp)
   fd627:	0f 85 ba 20 00 00    	jne    ff6e7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4687>
   fd62d:	80 bd 26 f5 ff ff 00 	cmpb   $0x0,-0xada(%rbp)
   fd634:	0f 85 53 21 00 00    	jne    ff78d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x472d>
   fd63a:	80 bd 32 f5 ff ff 00 	cmpb   $0x0,-0xace(%rbp)
   fd641:	0f 85 02 22 00 00    	jne    ff849 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x47e9>
   fd647:	80 bd 33 f5 ff ff 00 	cmpb   $0x0,-0xacd(%rbp)
   fd64e:	0f 85 e1 22 00 00    	jne    ff935 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x48d5>
   fd654:	48 8b 85 b0 f7 ff ff 	mov    -0x850(%rbp),%rax
   fd65b:	4c 8b a3 60 2f 00 00 	mov    0x2f60(%rbx),%r12
   fd662:	80 b8 98 32 00 00 00 	cmpb   $0x0,0x3298(%rax)
   fd669:	0f 84 86 00 00 00    	je     fd6f5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2695>
   fd66f:	48 8b 85 c0 f7 ff ff 	mov    -0x840(%rbp),%rax
   fd676:	4c 8b 28             	mov    (%rax),%r13
   fd679:	48 8b 05 10 a9 0f 00 	mov    0xfa910(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fd680:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fd687:	00 00 00 
   fd68a:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fd691:	48 8b 85 b8 f7 ff ff 	mov    -0x848(%rbp),%rax
   fd698:	48 8b 78 68          	mov    0x68(%rax),%rdi
   fd69c:	e8 bf f6 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fd6a1:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fd6a8:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   fd6ae:	4d 89 e9             	mov    %r13,%r9
   fd6b1:	45 31 c0             	xor    %r8d,%r8d
   fd6b4:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fd6ba:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   fd6c1:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fd6c8:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fd6ce:	e8 dd 18 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fd6d3:	85 c0                	test   %eax,%eax
   fd6d5:	0f 84 55 2e 00 00    	je     100530 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x54d0>
   fd6db:	e8 b0 f1 f6 ff       	call   6c890 <cudaGetLastError@plt>
   fd6e0:	89 c7                	mov    %eax,%edi
   fd6e2:	48 8d 35 7f 7d 0f 00 	lea    0xf7d7f(%rip),%rsi        # 1f5468 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5568>
   fd6e9:	e8 12 06 f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fd6ee:	4c 8b a3 60 2f 00 00 	mov    0x2f60(%rbx),%r12
   fd6f5:	80 bd c8 f4 ff ff 00 	cmpb   $0x0,-0xb38(%rbp)
   fd6fc:	0f 85 95 00 00 00    	jne    fd797 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2737>
   fd702:	48 8b 85 10 f8 ff ff 	mov    -0x7f0(%rbp),%rax
   fd709:	80 38 00             	cmpb   $0x0,(%rax)
   fd70c:	0f 84 85 00 00 00    	je     fd797 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2737>
   fd712:	48 8b 85 20 f8 ff ff 	mov    -0x7e0(%rbp),%rax
   fd719:	4c 8b 28             	mov    (%rax),%r13
   fd71c:	48 8b 05 6d a8 0f 00 	mov    0xfa86d(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fd723:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fd72a:	00 00 00 
   fd72d:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fd734:	48 8b 85 18 f8 ff ff 	mov    -0x7e8(%rbp),%rax
   fd73b:	48 8b 38             	mov    (%rax),%rdi
   fd73e:	e8 1d f6 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fd743:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fd74a:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   fd750:	4d 89 e9             	mov    %r13,%r9
   fd753:	45 31 c0             	xor    %r8d,%r8d
   fd756:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fd75c:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   fd763:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fd76a:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fd770:	e8 3b 18 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fd775:	85 c0                	test   %eax,%eax
   fd777:	0f 84 1b 32 00 00    	je     100998 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5938>
   fd77d:	e8 0e f1 f6 ff       	call   6c890 <cudaGetLastError@plt>
   fd782:	89 c7                	mov    %eax,%edi
   fd784:	48 8d 35 fd 7c 0f 00 	lea    0xf7cfd(%rip),%rsi        # 1f5488 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5588>
   fd78b:	e8 70 05 f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fd790:	4c 8b a3 60 2f 00 00 	mov    0x2f60(%rbx),%r12
   fd797:	48 8b 85 e0 f7 ff ff 	mov    -0x820(%rbp),%rax
   fd79e:	80 38 00             	cmpb   $0x0,(%rax)
   fd7a1:	0f 84 c0 00 00 00    	je     fd867 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2807>
   fd7a7:	48 8b 85 e8 f7 ff ff 	mov    -0x818(%rbp),%rax
   fd7ae:	48 83 b8 d8 06 00 00 	cmpq   $0x0,0x6d8(%rax)
   fd7b5:	00 
   fd7b6:	0f 84 ab 00 00 00    	je     fd867 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2807>
   fd7bc:	f3 0f 7e 80 f0 06 00 	movq   0x6f0(%rax),%xmm0
   fd7c3:	00 
   fd7c4:	f3 0f 7e 88 d0 06 00 	movq   0x6d0(%rax),%xmm1
   fd7cb:	00 
   fd7cc:	c7 85 00 f7 ff ff 01 	movl   $0x1,-0x900(%rbp)
   fd7d3:	00 00 00 
   fd7d6:	0f 16 80 00 07 00 00 	movhps 0x700(%rax),%xmm0
   fd7dd:	0f 16 88 e0 06 00 00 	movhps 0x6e0(%rax),%xmm1
   fd7e4:	48 8b 85 f8 f7 ff ff 	mov    -0x808(%rbp),%rax
   fd7eb:	0f 29 8d 90 f7 ff ff 	movaps %xmm1,-0x870(%rbp)
   fd7f2:	4c 8b 28             	mov    (%rax),%r13
   fd7f5:	48 8b 05 94 a7 0f 00 	mov    0xfa794(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fd7fc:	0f 29 85 a0 f7 ff ff 	movaps %xmm0,-0x860(%rbp)
   fd803:	48 89 85 f8 f6 ff ff 	mov    %rax,-0x908(%rbp)
   fd80a:	48 8b 85 f0 f7 ff ff 	mov    -0x810(%rbp),%rax
   fd811:	48 8b 78 68          	mov    0x68(%rax),%rdi
   fd815:	e8 46 f5 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fd81a:	4c 89 bd 38 f7 ff ff 	mov    %r15,-0x8c8(%rbp)
   fd821:	8b 8d 00 f7 ff ff    	mov    -0x900(%rbp),%ecx
   fd827:	4d 89 e9             	mov    %r13,%r9
   fd82a:	45 31 c0             	xor    %r8d,%r8d
   fd82d:	89 85 34 f7 ff ff    	mov    %eax,-0x8cc(%rbp)
   fd833:	48 8b 95 f8 f6 ff ff 	mov    -0x908(%rbp),%rdx
   fd83a:	48 8b bd 34 f7 ff ff 	mov    -0x8cc(%rbp),%rdi
   fd841:	8b b5 3c f7 ff ff    	mov    -0x8c4(%rbp),%esi
   fd847:	e8 64 17 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fd84c:	85 c0                	test   %eax,%eax
   fd84e:	0f 84 dc 31 00 00    	je     100a30 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x59d0>
   fd854:	e8 37 f0 f6 ff       	call   6c890 <cudaGetLastError@plt>
   fd859:	89 c7                	mov    %eax,%edi
   fd85b:	48 8d 35 4e 7c 0f 00 	lea    0xf7c4e(%rip),%rsi        # 1f54b0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x55b0>
   fd862:	e8 99 04 f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fd867:	80 bd 29 f5 ff ff 00 	cmpb   $0x0,-0xad7(%rbp)
   fd86e:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fd875:	0f 85 f5 1c 00 00    	jne    ff570 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4510>
   fd87b:	80 bd c8 f4 ff ff 00 	cmpb   $0x0,-0xb38(%rbp)
   fd882:	0f 84 9c 05 00 00    	je     fde24 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2dc4>
   fd888:	48 8b 05 01 a7 0f 00 	mov    0xfa701(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fd88f:	80 bd f0 f4 ff ff 00 	cmpb   $0x0,-0xb10(%rbp)
   fd896:	c7 85 10 f7 ff ff 01 	movl   $0x1,-0x8f0(%rbp)
   fd89d:	00 00 00 
   fd8a0:	48 8b bd 88 f5 ff ff 	mov    -0xa78(%rbp),%rdi
   fd8a7:	48 89 85 08 f7 ff ff 	mov    %rax,-0x8f8(%rbp)
   fd8ae:	0f 84 b4 17 00 00    	je     ff068 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4008>
   fd8b4:	e8 a7 f4 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fd8b9:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fd8c0:	8b 8d 10 f7 ff ff    	mov    -0x8f0(%rbp),%ecx
   fd8c6:	4d 89 e1             	mov    %r12,%r9
   fd8c9:	45 31 c0             	xor    %r8d,%r8d
   fd8cc:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fd8d2:	48 8b 95 08 f7 ff ff 	mov    -0x8f8(%rbp),%rdx
   fd8d9:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fd8e0:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fd8e6:	e8 c5 16 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fd8eb:	41 89 c0             	mov    %eax,%r8d
   fd8ee:	48 8d 85 a8 f5 ff ff 	lea    -0xa58(%rbp),%rax
   fd8f5:	48 8d 95 10 f6 ff ff 	lea    -0x9f0(%rbp),%rdx
   fd8fc:	66 4c 0f 6e c8       	movq   %rax,%xmm9
   fd901:	48 8d 85 b0 f5 ff ff 	lea    -0xa50(%rbp),%rax
   fd908:	66 4c 0f 6e d2       	movq   %rdx,%xmm10
   fd90d:	66 48 0f 6e f8       	movq   %rax,%xmm7
   fd912:	48 8d 85 b8 f5 ff ff 	lea    -0xa48(%rbp),%rax
   fd919:	48 8d 95 20 f6 ff ff 	lea    -0x9e0(%rbp),%rdx
   fd920:	66 4c 0f 6e c0       	movq   %rax,%xmm8
   fd925:	48 8d 85 c0 f5 ff ff 	lea    -0xa40(%rbp),%rax
   fd92c:	66 44 0f 6c cf       	punpcklqdq %xmm7,%xmm9
   fd931:	66 48 0f 6e e8       	movq   %rax,%xmm5
   fd936:	48 8d 85 c8 f5 ff ff 	lea    -0xa38(%rbp),%rax
   fd93d:	66 48 0f 6e f8       	movq   %rax,%xmm7
   fd942:	48 8d 85 d0 f5 ff ff 	lea    -0xa30(%rbp),%rax
   fd949:	66 44 0f 6c c5       	punpcklqdq %xmm5,%xmm8
   fd94e:	66 48 0f 6e f0       	movq   %rax,%xmm6
   fd953:	48 8d 85 d8 f5 ff ff 	lea    -0xa28(%rbp),%rax
   fd95a:	66 0f 6c fe          	punpcklqdq %xmm6,%xmm7
   fd95e:	66 48 0f 6e f0       	movq   %rax,%xmm6
   fd963:	48 8d 85 e0 f5 ff ff 	lea    -0xa20(%rbp),%rax
   fd96a:	66 48 0f 6e e8       	movq   %rax,%xmm5
   fd96f:	48 8d 85 e8 f5 ff ff 	lea    -0xa18(%rbp),%rax
   fd976:	66 0f 6c f5          	punpcklqdq %xmm5,%xmm6
   fd97a:	66 48 0f 6e e8       	movq   %rax,%xmm5
   fd97f:	48 8d 85 f0 f5 ff ff 	lea    -0xa10(%rbp),%rax
   fd986:	66 48 0f 6e e0       	movq   %rax,%xmm4
   fd98b:	48 8d 85 48 f5 ff ff 	lea    -0xab8(%rbp),%rax
   fd992:	66 0f 6c ec          	punpcklqdq %xmm4,%xmm5
   fd996:	66 48 0f 6e e0       	movq   %rax,%xmm4
   fd99b:	48 8d 85 c0 f9 ff ff 	lea    -0x640(%rbp),%rax
   fd9a2:	66 48 0f 6e d8       	movq   %rax,%xmm3
   fd9a7:	48 8d 85 f8 f5 ff ff 	lea    -0xa08(%rbp),%rax
   fd9ae:	66 0f 6c e3          	punpcklqdq %xmm3,%xmm4
   fd9b2:	66 48 0f 6e d8       	movq   %rax,%xmm3
   fd9b7:	48 8d 85 00 f6 ff ff 	lea    -0xa00(%rbp),%rax
   fd9be:	66 48 0f 6e d0       	movq   %rax,%xmm2
   fd9c3:	48 8d 85 4c f5 ff ff 	lea    -0xab4(%rbp),%rax
   fd9ca:	66 0f 6c da          	punpcklqdq %xmm2,%xmm3
   fd9ce:	66 48 0f 6e d0       	movq   %rax,%xmm2
   fd9d3:	48 8d 85 08 f6 ff ff 	lea    -0x9f8(%rbp),%rax
   fd9da:	66 48 0f 6e c8       	movq   %rax,%xmm1
   fd9df:	48 8d 85 18 f6 ff ff 	lea    -0x9e8(%rbp),%rax
   fd9e6:	66 0f 6c d1          	punpcklqdq %xmm1,%xmm2
   fd9ea:	66 48 0f 6e c8       	movq   %rax,%xmm1
   fd9ef:	48 8d 85 28 f6 ff ff 	lea    -0x9d8(%rbp),%rax
   fd9f6:	66 48 0f 6e c0       	movq   %rax,%xmm0
   fd9fb:	66 44 0f 6c d1       	punpcklqdq %xmm1,%xmm10
   fda00:	48 8d 85 30 f6 ff ff 	lea    -0x9d0(%rbp),%rax
   fda07:	66 48 0f 6e ca       	movq   %rdx,%xmm1
   fda0c:	48 8d 95 38 f6 ff ff 	lea    -0x9c8(%rbp),%rdx
   fda13:	66 0f 6c c8          	punpcklqdq %xmm0,%xmm1
   fda17:	66 4c 0f 6e f2       	movq   %rdx,%xmm14
   fda1c:	66 48 0f 6e c0       	movq   %rax,%xmm0
   fda21:	66 41 0f 6c c6       	punpcklqdq %xmm14,%xmm0
   fda26:	45 85 c0             	test   %r8d,%r8d
   fda29:	0f 85 3d 03 00 00    	jne    fdd6c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2d0c>
   fda2f:	48 8b 85 58 f5 ff ff 	mov    -0xaa8(%rbp),%rax
   fda36:	80 bd 31 f5 ff ff 00 	cmpb   $0x0,-0xacf(%rbp)
   fda3d:	66 45 0f ef db       	pxor   %xmm11,%xmm11
   fda42:	f3 44 0f 10 2d 35 a5 	movss  0xfa535(%rip),%xmm13        # 1f7f80 <cuda::std::__4::in_place+0x33>
   fda49:	0f 00 
   fda4b:	66 44 0f 6e a3 98 03 	movd   0x398(%rbx),%xmm12
   fda52:	00 00 
   fda54:	f3 44 0f 5e ad 1c f5 	divss  -0xae4(%rbp),%xmm13
   fda5b:	ff ff 
   fda5d:	48 89 85 90 f4 ff ff 	mov    %rax,-0xb70(%rbp)
   fda64:	48 8b 85 88 f5 ff ff 	mov    -0xa78(%rbp),%rax
   fda6b:	48 8b b3 80 2f 00 00 	mov    0x2f80(%rbx),%rsi
   fda72:	48 8b bb c0 2f 00 00 	mov    0x2fc0(%rbx),%rdi
   fda79:	48 89 85 a0 f4 ff ff 	mov    %rax,-0xb60(%rbp)
   fda80:	48 8b 83 a0 2f 00 00 	mov    0x2fa0(%rbx),%rax
   fda87:	4c 8b 83 00 30 00 00 	mov    0x3000(%rbx),%r8
   fda8e:	4c 8b 8b e0 2f 00 00 	mov    0x2fe0(%rbx),%r9
   fda95:	48 89 85 70 f4 ff ff 	mov    %rax,-0xb90(%rbp)
   fda9c:	74 0f                	je     fdaad <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2a4d>
   fda9e:	f3 44 0f 10 5b 0c    	movss  0xc(%rbx),%xmm11
   fdaa4:	f3 44 0f 59 9d 34 f5 	mulss  -0xacc(%rbp),%xmm11
   fdaab:	ff ff 
   fdaad:	48 8b 83 b0 2b 00 00 	mov    0x2bb0(%rbx),%rax
   fdab4:	48 8b 93 60 2f 00 00 	mov    0x2f60(%rbx),%rdx
   fdabb:	4c 8b 93 50 33 00 00 	mov    0x3350(%rbx),%r10
   fdac2:	4c 8b 9b a8 2b 00 00 	mov    0x2ba8(%rbx),%r11
   fdac9:	48 85 c0             	test   %rax,%rax
   fdacc:	48 89 95 20 f4 ff ff 	mov    %rdx,-0xbe0(%rbp)
   fdad3:	48 0f 44 85 60 f5 ff 	cmove  -0xaa0(%rbp),%rax
   fdada:	ff 
   fdadb:	31 d2                	xor    %edx,%edx
   fdadd:	48 83 bb 00 01 00 00 	cmpq   $0x0,0x100(%rbx)
   fdae4:	00 
   fdae5:	4c 8b a3 98 2b 00 00 	mov    0x2b98(%rbx),%r12
   fdaec:	4c 8b ab 88 2b 00 00 	mov    0x2b88(%rbx),%r13
   fdaf3:	74 07                	je     fdafc <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2a9c>
   fdaf5:	48 8b 93 f8 00 00 00 	mov    0xf8(%rbx),%rdx
   fdafc:	66 44 0f 6f b5 20 f9 	movdqa -0x6e0(%rbp),%xmm14
   fdb03:	ff ff 
   fdb05:	48 8b 8b d0 03 00 00 	mov    0x3d0(%rbx),%rcx
   fdb0c:	48 89 95 c0 f5 ff ff 	mov    %rdx,-0xa40(%rbp)
   fdb13:	66 44 0f 6f bd 30 f9 	movdqa -0x6d0(%rbp),%xmm15
   fdb1a:	ff ff 
   fdb1c:	48 8b 95 20 f4 ff ff 	mov    -0xbe0(%rbp),%rdx
   fdb23:	4c 89 ad d0 f5 ff ff 	mov    %r13,-0xa30(%rbp)
   fdb2a:	44 0f 29 b5 c0 f9 ff 	movaps %xmm14,-0x640(%rbp)
   fdb31:	ff 
   fdb32:	66 44 0f 6f b5 40 f9 	movdqa -0x6c0(%rbp),%xmm14
   fdb39:	ff ff 
   fdb3b:	44 0f 29 bd d0 f9 ff 	movaps %xmm15,-0x630(%rbp)
   fdb42:	ff 
   fdb43:	66 44 0f 6f bd 50 f9 	movdqa -0x6b0(%rbp),%xmm15
   fdb4a:	ff ff 
   fdb4c:	44 0f 29 b5 e0 f9 ff 	movaps %xmm14,-0x620(%rbp)
   fdb53:	ff 
   fdb54:	66 44 0f 6f b5 60 f9 	movdqa -0x6a0(%rbp),%xmm14
   fdb5b:	ff ff 
   fdb5d:	44 0f 29 bd f0 f9 ff 	movaps %xmm15,-0x610(%rbp)
   fdb64:	ff 
   fdb65:	66 44 0f 6f bd 70 f9 	movdqa -0x690(%rbp),%xmm15
   fdb6c:	ff ff 
   fdb6e:	48 89 8d a8 f5 ff ff 	mov    %rcx,-0xa58(%rbp)
   fdb75:	48 8b 8b a0 03 00 00 	mov    0x3a0(%rbx),%rcx
   fdb7c:	44 0f 29 b5 00 fa ff 	movaps %xmm14,-0x600(%rbp)
   fdb83:	ff 
   fdb84:	66 44 0f 6f b5 80 f9 	movdqa -0x680(%rbp),%xmm14
   fdb8b:	ff ff 
   fdb8d:	44 0f 29 bd 10 fa ff 	movaps %xmm15,-0x5f0(%rbp)
   fdb94:	ff 
   fdb95:	66 44 0f 6f bd 90 f9 	movdqa -0x670(%rbp),%xmm15
   fdb9c:	ff ff 
   fdb9e:	48 89 8d b0 f5 ff ff 	mov    %rcx,-0xa50(%rbp)
   fdba5:	48 8b 8b c0 00 00 00 	mov    0xc0(%rbx),%rcx
   fdbac:	44 0f 29 b5 20 fa ff 	movaps %xmm14,-0x5e0(%rbp)
   fdbb3:	ff 
   fdbb4:	66 44 0f 6f b5 a0 f9 	movdqa -0x660(%rbp),%xmm14
   fdbbb:	ff ff 
   fdbbd:	44 0f 29 bd 30 fa ff 	movaps %xmm15,-0x5d0(%rbp)
   fdbc4:	ff 
   fdbc5:	66 44 0f 6f bd b0 f9 	movdqa -0x650(%rbp),%xmm15
   fdbcc:	ff ff 
   fdbce:	48 89 8d b8 f5 ff ff 	mov    %rcx,-0xa48(%rbp)
   fdbd5:	48 8d 8d e0 f6 ff ff 	lea    -0x920(%rbp),%rcx
   fdbdc:	48 89 95 c8 f5 ff ff 	mov    %rdx,-0xa38(%rbp)
   fdbe3:	48 8d 95 d8 f6 ff ff 	lea    -0x928(%rbp),%rdx
   fdbea:	4c 89 a5 d8 f5 ff ff 	mov    %r12,-0xa28(%rbp)
   fdbf1:	4c 89 9d e0 f5 ff ff 	mov    %r11,-0xa20(%rbp)
   fdbf8:	44 0f 29 b5 40 fa ff 	movaps %xmm14,-0x5c0(%rbp)
   fdbff:	ff 
   fdc00:	44 0f 29 bd 50 fa ff 	movaps %xmm15,-0x5b0(%rbp)
   fdc07:	ff 
   fdc08:	48 89 85 e8 f5 ff ff 	mov    %rax,-0xa18(%rbp)
   fdc0f:	48 8b 85 a8 f4 ff ff 	mov    -0xb58(%rbp),%rax
   fdc16:	48 89 bd 08 f6 ff ff 	mov    %rdi,-0x9f8(%rbp)
   fdc1d:	48 8d bd 18 f7 ff ff 	lea    -0x8e8(%rbp),%rdi
   fdc24:	48 89 85 10 f6 ff ff 	mov    %rax,-0x9f0(%rbp)
   fdc2b:	48 8b 85 70 f4 ff ff 	mov    -0xb90(%rbp),%rax
   fdc32:	48 89 b5 18 f6 ff ff 	mov    %rsi,-0x9e8(%rbp)
   fdc39:	48 8d b5 58 f7 ff ff 	lea    -0x8a8(%rbp),%rsi
   fdc40:	48 89 85 20 f6 ff ff 	mov    %rax,-0x9e0(%rbp)
   fdc47:	48 8b 85 a0 f4 ff ff 	mov    -0xb60(%rbp),%rax
   fdc4e:	4c 89 95 f0 f5 ff ff 	mov    %r10,-0xa10(%rbp)
   fdc55:	48 89 85 28 f6 ff ff 	mov    %rax,-0x9d8(%rbp)
   fdc5c:	48 8b 85 90 f4 ff ff 	mov    -0xb70(%rbp),%rax
   fdc63:	4c 89 8d f8 f5 ff ff 	mov    %r9,-0xa08(%rbp)
   fdc6a:	48 89 85 38 f6 ff ff 	mov    %rax,-0x9c8(%rbp)
   fdc71:	48 8b 05 f8 a2 0f 00 	mov    0xfa2f8(%rip),%rax        # 1f7f70 <cuda::std::__4::in_place+0x23>
   fdc78:	4c 89 85 00 f6 ff ff 	mov    %r8,-0xa00(%rbp)
   fdc7f:	48 89 85 18 f7 ff ff 	mov    %rax,-0x8e8(%rbp)
   fdc86:	c7 85 20 f7 ff ff 01 	movl   $0x1,-0x8e0(%rbp)
   fdc8d:	00 00 00 
   fdc90:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fdc97:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fdc9e:	00 00 00 
   fdca1:	f3 44 0f 11 9d 48 f5 	movss  %xmm11,-0xab8(%rbp)
   fdca8:	ff ff 
   fdcaa:	f3 44 0f 11 ad 4c f5 	movss  %xmm13,-0xab4(%rbp)
   fdcb1:	ff ff 
   fdcb3:	66 44 0f d6 a5 30 f6 	movq   %xmm12,-0x9d0(%rbp)
   fdcba:	ff ff 
   fdcbc:	44 0f 29 8d 90 fe ff 	movaps %xmm9,-0x170(%rbp)
   fdcc3:	ff 
   fdcc4:	44 0f 29 85 a0 fe ff 	movaps %xmm8,-0x160(%rbp)
   fdccb:	ff 
   fdccc:	0f 29 bd b0 fe ff ff 	movaps %xmm7,-0x150(%rbp)
   fdcd3:	0f 29 b5 c0 fe ff ff 	movaps %xmm6,-0x140(%rbp)
   fdcda:	0f 29 ad d0 fe ff ff 	movaps %xmm5,-0x130(%rbp)
   fdce1:	0f 29 a5 e0 fe ff ff 	movaps %xmm4,-0x120(%rbp)
   fdce8:	0f 29 9d f0 fe ff ff 	movaps %xmm3,-0x110(%rbp)
   fdcef:	0f 29 95 00 ff ff ff 	movaps %xmm2,-0x100(%rbp)
   fdcf6:	44 0f 29 95 10 ff ff 	movaps %xmm10,-0xf0(%rbp)
   fdcfd:	ff 
   fdcfe:	0f 29 8d 20 ff ff ff 	movaps %xmm1,-0xe0(%rbp)
   fdd05:	0f 29 85 30 ff ff ff 	movaps %xmm0,-0xd0(%rbp)
   fdd0c:	e8 2f 0e f7 ff       	call   6eb40 <__cudaPopCallConfiguration@plt>
   fdd11:	85 c0                	test   %eax,%eax
   fdd13:	75 57                	jne    fdd6c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2d0c>
   fdd15:	ff b5 e0 f6 ff ff    	push   -0x920(%rbp)
   fdd1b:	48 8b b5 18 f7 ff ff 	mov    -0x8e8(%rbp),%rsi
   fdd22:	4c 8d 8d 90 fe ff ff 	lea    -0x170(%rbp),%r9
   fdd29:	8b 95 20 f7 ff ff    	mov    -0x8e0(%rbp),%edx
   fdd2f:	ff b5 d8 f6 ff ff    	push   -0x928(%rbp)
   fdd35:	48 8b 8d 58 f7 ff ff 	mov    -0x8a8(%rbp),%rcx
   fdd3c:	48 89 b5 4c f7 ff ff 	mov    %rsi,-0x8b4(%rbp)
   fdd43:	44 8b 85 60 f7 ff ff 	mov    -0x8a0(%rbp),%r8d
   fdd4a:	48 8b 3d 57 8e 5b 00 	mov    0x5b8e57(%rip),%rdi        # 6b6ba8 <void synreal::kernel::build_affine_body_preconditioner<synreal::BlockNonZeroEntry>(glm::vec<4, int, (glm::qualifier)0> const*, float const*, float const*, int const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, int const*, synreal::BlockNonZeroEntry const*, unsigned long, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, synreal::kernel::CableView, unsigned long const*, int const*, float, int const*, float const*, float*, int*, unsigned long, unsigned long, unsigned long)@@Base+0x5a74a8>
   fdd51:	89 95 54 f7 ff ff    	mov    %edx,-0x8ac(%rbp)
   fdd57:	48 89 8d 40 f7 ff ff 	mov    %rcx,-0x8c0(%rbp)
   fdd5e:	44 89 85 48 f7 ff ff 	mov    %r8d,-0x8b8(%rbp)
   fdd65:	e8 86 d7 f6 ff       	call   6b4f0 <cudaLaunchKernel@plt>
   fdd6a:	58                   	pop    %rax
   fdd6b:	5a                   	pop    %rdx
   fdd6c:	e8 1f eb f6 ff       	call   6c890 <cudaGetLastError@plt>
   fdd71:	89 c7                	mov    %eax,%edi
   fdd73:	48 8d 35 96 7c 0f 00 	lea    0xf7c96(%rip),%rsi        # 1f5a10 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5b10>
   fdd7a:	e8 81 ff f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fdd7f:	80 bd 31 f5 ff ff 00 	cmpb   $0x0,-0xacf(%rbp)
   fdd86:	0f 85 7c 24 00 00    	jne    100208 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x51a8>
   fdd8c:	48 8b 85 10 f8 ff ff 	mov    -0x7f0(%rbp),%rax
   fdd93:	4c 8b a3 60 2f 00 00 	mov    0x2f60(%rbx),%r12
   fdd9a:	80 38 00             	cmpb   $0x0,(%rax)
   fdd9d:	74 7e                	je     fde1d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2dbd>
   fdd9f:	48 8b 85 20 f8 ff ff 	mov    -0x7e0(%rbp),%rax
   fdda6:	4c 8b 28             	mov    (%rax),%r13
   fdda9:	48 8b 05 e0 a1 0f 00 	mov    0xfa1e0(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fddb0:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fddb7:	00 00 00 
   fddba:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fddc1:	48 8b 85 18 f8 ff ff 	mov    -0x7e8(%rbp),%rax
   fddc8:	48 8b 38             	mov    (%rax),%rdi
   fddcb:	e8 90 ef f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fddd0:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fddd7:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   fdddd:	4d 89 e9             	mov    %r13,%r9
   fdde0:	45 31 c0             	xor    %r8d,%r8d
   fdde3:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fdde9:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   fddf0:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fddf7:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fddfd:	e8 ae 11 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fde02:	85 c0                	test   %eax,%eax
   fde04:	0f 84 f6 2a 00 00    	je     100900 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x58a0>
   fde0a:	e8 81 ea f6 ff       	call   6c890 <cudaGetLastError@plt>
   fde0f:	89 c7                	mov    %eax,%edi
   fde11:	48 8d 35 70 76 0f 00 	lea    0xf7670(%rip),%rsi        # 1f5488 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5588>
   fde18:	e8 e3 fe f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fde1d:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fde24:	48 8b 05 65 a1 0f 00 	mov    0xfa165(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fde2b:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fde32:	4d 89 e1             	mov    %r12,%r9
   fde35:	45 31 c0             	xor    %r8d,%r8d
   fde38:	48 8b 15 51 a1 0f 00 	mov    0xfa151(%rip),%rdx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fde3f:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fde45:	b9 01 00 00 00       	mov    $0x1,%ecx
   fde4a:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fde51:	00 00 00 
   fde54:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fde5b:	8b 85 18 f5 ff ff    	mov    -0xae8(%rbp),%eax
   fde61:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fde67:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fde6e:	e8 3d 11 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fde73:	85 c0                	test   %eax,%eax
   fde75:	75 37                	jne    fdeae <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2e4e>
   fde77:	31 d2                	xor    %edx,%edx
   fde79:	48 83 bb 00 01 00 00 	cmpq   $0x0,0x100(%rbx)
   fde80:	00 
   fde81:	4c 8b 8d 58 f5 ff ff 	mov    -0xaa8(%rbp),%r9
   fde88:	4c 8b 85 60 f5 ff ff 	mov    -0xaa0(%rbp),%r8
   fde8f:	48 8b bb 60 2f 00 00 	mov    0x2f60(%rbx),%rdi
   fde96:	74 07                	je     fde9f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2e3f>
   fde98:	48 8b 93 f8 00 00 00 	mov    0xf8(%rbx),%rdx
   fde9f:	48 8b b3 c0 00 00 00 	mov    0xc0(%rbx),%rsi
   fdea6:	48 89 f9             	mov    %rdi,%rcx
   fdea9:	e8 72 ca f6 ff       	call   6a920 <synreal::kernel::invert_block_preconditioner(glm::mat<3, 3, float, (glm::qualifier)0> const*, float const*, int const*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long)@plt>
   fdeae:	e8 dd e9 f6 ff       	call   6c890 <cudaGetLastError@plt>
   fdeb3:	89 c7                	mov    %eax,%edi
   fdeb5:	48 8d 35 ac 7b 0f 00 	lea    0xf7bac(%rip),%rsi        # 1f5a68 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5b68>
   fdebc:	e8 3f fe f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fdec1:	80 bd f0 f4 ff ff 00 	cmpb   $0x0,-0xb10(%rbp)
   fdec8:	4c 8b 95 60 f5 ff ff 	mov    -0xaa0(%rbp),%r10
   fdecf:	48 8b 93 40 30 00 00 	mov    0x3040(%rbx),%rdx
   fded6:	4c 8b 8d 10 f5 ff ff 	mov    -0xaf0(%rbp),%r9
   fdedd:	0f 84 6d 06 00 00    	je     fe550 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34f0>
   fdee3:	48 89 d6             	mov    %rdx,%rsi
   fdee6:	4c 8d 85 30 fc ff ff 	lea    -0x3d0(%rbp),%r8
   fdeed:	4c 89 d1             	mov    %r10,%rcx
   fdef0:	4c 89 d2             	mov    %r10,%rdx
   fdef3:	48 89 df             	mov    %rbx,%rdi
   fdef6:	e8 f5 fa f6 ff       	call   6d9f0 <synreal::SolverNewton::solve_newton_system(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, std::function<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)> const&, CUstream_st*)@plt>
   fdefb:	44 8b 8b e8 17 00 00 	mov    0x17e8(%rbx),%r9d
   fdf02:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fdf09:	45 85 c9             	test   %r9d,%r9d
   fdf0c:	74 27                	je     fdf35 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2ed5>
   fdf0e:	f3 0f 10 43 28       	movss  0x28(%rbx),%xmm0
   fdf13:	f3 0f 10 4b 2c       	movss  0x2c(%rbx),%xmm1
   fdf18:	4c 89 e2             	mov    %r12,%rdx
   fdf1b:	48 8d bb 28 17 00 00 	lea    0x1728(%rbx),%rdi
   fdf22:	48 8b b3 20 30 00 00 	mov    0x3020(%rbx),%rsi
   fdf29:	e8 42 04 f7 ff       	call   6e370 <synreal::Fluid::limit_step(glm::vec<3, float, (glm::qualifier)0>*, float, float, CUstream_st*)@plt>
   fdf2e:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fdf35:	48 8b 05 54 a0 0f 00 	mov    0xfa054(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fdf3c:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fdf43:	4d 89 e1             	mov    %r12,%r9
   fdf46:	45 31 c0             	xor    %r8d,%r8d
   fdf49:	48 8b 15 40 a0 0f 00 	mov    0xfa040(%rip),%rdx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fdf50:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fdf56:	b9 01 00 00 00       	mov    $0x1,%ecx
   fdf5b:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fdf62:	00 00 00 
   fdf65:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fdf6c:	8b 85 18 f5 ff ff    	mov    -0xae8(%rbp),%eax
   fdf72:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fdf78:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fdf7f:	e8 2c 10 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fdf84:	85 c0                	test   %eax,%eax
   fdf86:	75 27                	jne    fdfaf <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2f4f>
   fdf88:	48 8b 85 e8 f4 ff ff 	mov    -0xb18(%rbp),%rax
   fdf8f:	48 8b 93 20 30 00 00 	mov    0x3020(%rbx),%rdx
   fdf96:	48 8b 8d 60 f5 ff ff 	mov    -0xaa0(%rbp),%rcx
   fdf9d:	48 8b 30             	mov    (%rax),%rsi
   fdfa0:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   fdfa7:	48 8b 38             	mov    (%rax),%rdi
   fdfaa:	e8 71 ca f6 ff       	call   6aa20 <synreal::kernel::apply_nonlinear_step(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long)@plt>
   fdfaf:	e8 dc e8 f6 ff       	call   6c890 <cudaGetLastError@plt>
   fdfb4:	89 c7                	mov    %eax,%edi
   fdfb6:	48 8d 35 0b 7b 0f 00 	lea    0xf7b0b(%rip),%rsi        # 1f5ac8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5bc8>
   fdfbd:	e8 3e fd f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fdfc2:	80 bd bb f4 ff ff 00 	cmpb   $0x0,-0xb45(%rbp)
   fdfc9:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fdfd0:	0f 85 0a 08 00 00    	jne    fe7e0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3780>
   fdfd6:	80 bd 28 f5 ff ff 00 	cmpb   $0x0,-0xad8(%rbp)
   fdfdd:	0f 85 35 07 00 00    	jne    fe718 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x36b8>
   fdfe3:	44 8b 85 bc f4 ff ff 	mov    -0xb44(%rbp),%r8d
   fdfea:	45 85 c0             	test   %r8d,%r8d
   fdfed:	0f 85 45 06 00 00    	jne    fe638 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x35d8>
   fdff3:	83 85 00 f5 ff ff 01 	addl   $0x1,-0xb00(%rbp)
   fdffa:	8b 85 00 f5 ff ff    	mov    -0xb00(%rbp),%eax
   fe000:	39 85 e0 f4 ff ff    	cmp    %eax,-0xb20(%rbp)
   fe006:	0f 8e b4 04 00 00    	jle    fe4c0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3460>
   fe00c:	39 43 18             	cmp    %eax,0x18(%rbx)
   fe00f:	41 0f 94 c5          	sete   %r13b
   fe013:	83 bd d0 f4 ff ff 03 	cmpl   $0x3,-0xb30(%rbp)
   fe01a:	0f 84 ac 04 00 00    	je     fe4cc <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x346c>
   fe020:	8b 85 00 f5 ff ff    	mov    -0xb00(%rbp),%eax
   fe026:	99                   	cltd   
   fe027:	f7 7b 14             	idivl  0x14(%rbx)
   fe02a:	85 d2                	test   %edx,%edx
   fe02c:	0f 85 ce 04 00 00    	jne    fe500 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34a0>
   fe032:	83 bd e4 f4 ff ff 01 	cmpl   $0x1,-0xb1c(%rbp)
   fe039:	0f 84 01 0d 00 00    	je     fed40 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3ce0>
   fe03f:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   fe046:	48 8b 38             	mov    (%rax),%rdi
   fe049:	48 8b 85 e8 f4 ff ff 	mov    -0xb18(%rbp),%rax
   fe050:	48 8b 30             	mov    (%rax),%rsi
   fe053:	48 39 f7             	cmp    %rsi,%rdi
   fe056:	0f 84 34 e1 ff ff    	je     fc190 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1130>
   fe05c:	0f 1f 40 00          	nopl   0x0(%rax)
   fe060:	48 8b 85 60 f5 ff ff 	mov    -0xaa0(%rbp),%rax
   fe067:	4d 89 e0             	mov    %r12,%r8
   fe06a:	b9 03 00 00 00       	mov    $0x3,%ecx
   fe06f:	48 8d 14 40          	lea    (%rax,%rax,2),%rdx
   fe073:	48 c1 e2 02          	shl    $0x2,%rdx
   fe077:	e8 34 00 f7 ff       	call   6e0b0 <cudaMemcpyAsync@plt>
   fe07c:	89 c7                	mov    %eax,%edi
   fe07e:	48 8d 35 5b 7b 0f 00 	lea    0xf7b5b(%rip),%rsi        # 1f5be0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5ce0>
   fe085:	e8 76 fc f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fe08a:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fe091:	8b 8d 00 f5 ff ff    	mov    -0xb00(%rbp),%ecx
   fe097:	39 8d e0 f4 ff ff    	cmp    %ecx,-0xb20(%rbp)
   fe09d:	0f 85 ed e0 ff ff    	jne    fc190 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1130>
   fe0a3:	80 bd 28 f5 ff ff 00 	cmpb   $0x0,-0xad8(%rbp)
   fe0aa:	0f 85 a8 34 00 00    	jne    101558 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x64f8>
   fe0b0:	48 83 bb 30 32 00 00 	cmpq   $0x0,0x3230(%rbx)
   fe0b7:	00 
   fe0b8:	0f 85 aa 43 00 00    	jne    102468 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7408>
   fe0be:	8b 95 e0 f4 ff ff    	mov    -0xb20(%rbp),%edx
   fe0c4:	85 d2                	test   %edx,%edx
   fe0c6:	75 4a                	jne    fe112 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x30b2>
   fe0c8:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   fe0cf:	48 8b 30             	mov    (%rax),%rsi
   fe0d2:	48 8b 85 e8 f4 ff ff 	mov    -0xb18(%rbp),%rax
   fe0d9:	48 8b 38             	mov    (%rax),%rdi
   fe0dc:	48 39 f7             	cmp    %rsi,%rdi
   fe0df:	74 31                	je     fe112 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x30b2>
   fe0e1:	48 8b 85 60 f5 ff ff 	mov    -0xaa0(%rbp),%rax
   fe0e8:	4d 89 e0             	mov    %r12,%r8
   fe0eb:	b9 03 00 00 00       	mov    $0x3,%ecx
   fe0f0:	48 8d 14 40          	lea    (%rax,%rax,2),%rdx
   fe0f4:	48 c1 e2 02          	shl    $0x2,%rdx
   fe0f8:	e8 b3 ff f6 ff       	call   6e0b0 <cudaMemcpyAsync@plt>
   fe0fd:	89 c7                	mov    %eax,%edi
   fe0ff:	48 8d 35 52 7b 0f 00 	lea    0xf7b52(%rip),%rsi        # 1f5c58 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5d58>
   fe106:	e8 f5 fb f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fe10b:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fe112:	8b 83 80 21 00 00    	mov    0x2180(%rbx),%eax
   fe118:	85 c0                	test   %eax,%eax
   fe11a:	74 2f                	je     fe14b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x30eb>
   fe11c:	48 8b 85 e8 f4 ff ff 	mov    -0xb18(%rbp),%rax
   fe123:	48 8b 93 60 30 00 00 	mov    0x3060(%rbx),%rdx
   fe12a:	4c 89 e1             	mov    %r12,%rcx
   fe12d:	48 8d bb 70 20 00 00 	lea    0x2070(%rbx),%rdi
   fe134:	f3 0f 10 85 1c f5 ff 	movss  -0xae4(%rbp),%xmm0
   fe13b:	ff 
   fe13c:	48 8b 30             	mov    (%rax),%rsi
   fe13f:	e8 5c f1 f6 ff       	call   6d2a0 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)@plt>
   fe144:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fe14b:	48 8b 05 3e 9e 0f 00 	mov    0xf9e3e(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fe152:	48 8b 15 37 9e 0f 00 	mov    0xf9e37(%rip),%rdx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fe159:	4d 89 e1             	mov    %r12,%r9
   fe15c:	45 31 c0             	xor    %r8d,%r8d
   fe15f:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fe166:	00 00 00 
   fe169:	b9 01 00 00 00       	mov    $0x1,%ecx
   fe16e:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fe175:	8b 85 18 f5 ff ff    	mov    -0xae8(%rbp),%eax
   fe17b:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fe181:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
   fe188:	00 00 00 
   fe18b:	48 89 85 68 f7 ff ff 	mov    %rax,-0x898(%rbp)
   fe192:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fe199:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fe19f:	e8 0c 0e f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fe1a4:	85 c0                	test   %eax,%eax
   fe1a6:	75 31                	jne    fe1d9 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3179>
   fe1a8:	48 8b 85 e8 f4 ff ff 	mov    -0xb18(%rbp),%rax
   fe1af:	48 8b bb 60 30 00 00 	mov    0x3060(%rbx),%rdi
   fe1b6:	48 8b 8d 60 f5 ff ff 	mov    -0xaa0(%rbp),%rcx
   fe1bd:	f3 0f 10 05 bb 9d 0f 	movss  0xf9dbb(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
   fe1c4:	00 
   fe1c5:	f3 0f 5e 85 1c f5 ff 	divss  -0xae4(%rbp),%xmm0
   fe1cc:	ff 
   fe1cd:	48 8b 50 10          	mov    0x10(%rax),%rdx
   fe1d1:	48 8b 30             	mov    (%rax),%rsi
   fe1d4:	e8 07 c9 f6 ff       	call   6aae0 <synreal::kernel::update_velocity(float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long)@plt>
   fe1d9:	e8 b2 e6 f6 ff       	call   6c890 <cudaGetLastError@plt>
   fe1de:	89 c7                	mov    %eax,%edi
   fe1e0:	48 8d 35 07 94 0f 00 	lea    0xf9407(%rip),%rsi        # 1f75ee <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x76ee>
   fe1e7:	e8 14 fb f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fe1ec:	80 bd 2d f5 ff ff 00 	cmpb   $0x0,-0xad3(%rbp)
   fe1f3:	0f 85 e7 33 00 00    	jne    1015e0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6580>
   fe1f9:	48 8b 85 40 fc ff ff 	mov    -0x3c0(%rbp),%rax
   fe200:	48 85 c0             	test   %rax,%rax
   fe203:	74 11                	je     fe216 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x31b6>
   fe205:	48 8d bd 30 fc ff ff 	lea    -0x3d0(%rbp),%rdi
   fe20c:	ba 03 00 00 00       	mov    $0x3,%edx
   fe211:	48 89 fe             	mov    %rdi,%rsi
   fe214:	ff d0                	call   *%rax
   fe216:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   fe21a:	64 48 2b 04 25 28 00 	sub    %fs:0x28,%rax
   fe221:	00 00 
   fe223:	0f 85 fa 46 00 00    	jne    102923 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78c3>
   fe229:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
   fe22d:	5b                   	pop    %rbx
   fe22e:	41 5c                	pop    %r12
   fe230:	41 5d                	pop    %r13
   fe232:	41 5e                	pop    %r14
   fe234:	41 5f                	pop    %r15
   fe236:	5d                   	pop    %rbp
   fe237:	c3                   	ret    
   fe238:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   fe23f:	00 
   fe240:	48 89 b5 60 f5 ff ff 	mov    %rsi,-0xaa0(%rbp)
   fe247:	48 85 f6             	test   %rsi,%rsi
   fe24a:	74 ca                	je     fe216 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x31b6>
   fe24c:	48 89 f0             	mov    %rsi,%rax
   fe24f:	0f 28 d0             	movaps %xmm0,%xmm2
   fe252:	e9 e4 ce ff ff       	jmp    fb13b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xdb>
   fe257:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   fe25e:	00 00 
   fe260:	80 7b 4c 00          	cmpb   $0x0,0x4c(%rbx)
   fe264:	0f 84 fe cf ff ff    	je     fb268 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x208>
   fe26a:	80 7b 4d 00          	cmpb   $0x0,0x4d(%rbx)
   fe26e:	0f 84 f4 cf ff ff    	je     fb268 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x208>
   fe274:	85 c9                	test   %ecx,%ecx
   fe276:	0f 84 ec cf ff ff    	je     fb268 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x208>
   fe27c:	e9 85 84 f7 ff       	jmp    76706 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x124>
   fe281:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   fe288:	49 8b 06             	mov    (%r14),%rax
   fe28b:	f3 41 0f 6f 6e 60    	movdqu 0x60(%r14),%xmm5
   fe291:	c6 85 29 f5 ff ff 01 	movb   $0x1,-0xad7(%rbp)
   fe298:	f3 41 0f 6f 4e 50    	movdqu 0x50(%r14),%xmm1
   fe29e:	f3 41 0f 6f 46 70    	movdqu 0x70(%r14),%xmm0
   fe2a4:	48 89 85 50 fc ff ff 	mov    %rax,-0x3b0(%rbp)
   fe2ab:	89 f0                	mov    %esi,%eax
   fe2ad:	f3 41 0f 6f a6 80 00 	movdqu 0x80(%r14),%xmm4
   fe2b4:	00 00 
   fe2b6:	f3 41 0f 6f 76 40    	movdqu 0x40(%r14),%xmm6
   fe2bc:	48 89 85 58 fc ff ff 	mov    %rax,-0x3a8(%rbp)
   fe2c3:	66 0f 6d cd          	punpckhqdq %xmm5,%xmm1
   fe2c7:	f3 41 0f 6f 56 30    	movdqu 0x30(%r14),%xmm2
   fe2cd:	66 0f 6d c4          	punpckhqdq %xmm4,%xmm0
   fe2d1:	49 8b 86 98 00 00 00 	mov    0x98(%r14),%rax
   fe2d8:	0f 29 8d 80 fc ff ff 	movaps %xmm1,-0x380(%rbp)
   fe2df:	f3 41 0f 6f 5e 10    	movdqu 0x10(%r14),%xmm3
   fe2e5:	f3 41 0f 6f 7e 20    	movdqu 0x20(%r14),%xmm7
   fe2eb:	0f 29 85 90 fc ff ff 	movaps %xmm0,-0x370(%rbp)
   fe2f2:	48 89 85 a0 fc ff ff 	mov    %rax,-0x360(%rbp)
   fe2f9:	48 8b 83 58 07 00 00 	mov    0x758(%rbx),%rax
   fe300:	66 0f 6d d6          	punpckhqdq %xmm6,%xmm2
   fe304:	f3 0f 6f 83 38 07 00 	movdqu 0x738(%rbx),%xmm0
   fe30b:	00 
   fe30c:	f3 0f 6f b3 48 07 00 	movdqu 0x748(%rbx),%xmm6
   fe313:	00 
   fe314:	66 0f 6d df          	punpckhqdq %xmm7,%xmm3
   fe318:	0f 29 95 70 fc ff ff 	movaps %xmm2,-0x390(%rbp)
   fe31f:	48 89 85 c8 fc ff ff 	mov    %rax,-0x338(%rbp)
   fe326:	f3 0f 6f 8b 18 07 00 	movdqu 0x718(%rbx),%xmm1
   fe32d:	00 
   fe32e:	48 8b 83 68 07 00 00 	mov    0x768(%rbx),%rax
   fe335:	f3 0f 6f ab 28 07 00 	movdqu 0x728(%rbx),%xmm5
   fe33c:	00 
   fe33d:	66 0f 6c c6          	punpcklqdq %xmm6,%xmm0
   fe341:	0f 29 9d 60 fc ff ff 	movaps %xmm3,-0x3a0(%rbp)
   fe348:	0f 11 85 b8 fc ff ff 	movups %xmm0,-0x348(%rbp)
   fe34f:	48 89 85 d0 fc ff ff 	mov    %rax,-0x330(%rbp)
   fe356:	66 0f 6c cd          	punpcklqdq %xmm5,%xmm1
   fe35a:	31 c0                	xor    %eax,%eax
   fe35c:	48 83 bb a0 07 00 00 	cmpq   $0x0,0x7a0(%rbx)
   fe363:	00 
   fe364:	0f 11 8d a8 fc ff ff 	movups %xmm1,-0x358(%rbp)
   fe36b:	0f 85 bf 37 00 00    	jne    101b30 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6ad0>
   fe371:	48 89 85 d8 fc ff ff 	mov    %rax,-0x328(%rbp)
   fe378:	31 c0                	xor    %eax,%eax
   fe37a:	48 83 bb b0 07 00 00 	cmpq   $0x0,0x7b0(%rbx)
   fe381:	00 
   fe382:	0f 85 98 37 00 00    	jne    101b20 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6ac0>
   fe388:	66 0f 6e 8d 38 f5 ff 	movd   -0xac8(%rbp),%xmm1
   fe38f:	ff 
   fe390:	66 0f 6e 83 10 07 00 	movd   0x710(%rbx),%xmm0
   fe397:	00 
   fe398:	48 89 85 e0 fc ff ff 	mov    %rax,-0x320(%rbp)
   fe39f:	f3 0f 6f a3 c0 03 00 	movdqu 0x3c0(%rbx),%xmm4
   fe3a6:	00 
   fe3a7:	48 8b 85 80 f5 ff ff 	mov    -0xa80(%rbp),%rax
   fe3ae:	66 0f 6c c1          	punpcklqdq %xmm1,%xmm0
   fe3b2:	f3 0f 6f bb d0 03 00 	movdqu 0x3d0(%rbx),%xmm7
   fe3b9:	00 
   fe3ba:	f3 0f 6f 8b f0 03 00 	movdqu 0x3f0(%rbx),%xmm1
   fe3c1:	00 
   fe3c2:	0f 11 85 e8 fc ff ff 	movups %xmm0,-0x318(%rbp)
   fe3c9:	f3 0f 6f 83 e0 03 00 	movdqu 0x3e0(%rbx),%xmm0
   fe3d0:	00 
   fe3d1:	41 8b be d0 00 00 00 	mov    0xd0(%r14),%edi
   fe3d8:	48 89 85 f8 fc ff ff 	mov    %rax,-0x308(%rbp)
   fe3df:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   fe3e6:	66 0f 6c cf          	punpcklqdq %xmm7,%xmm1
   fe3ea:	66 0f 6c c4          	punpcklqdq %xmm4,%xmm0
   fe3ee:	0f 29 8d 00 fd ff ff 	movaps %xmm1,-0x300(%rbp)
   fe3f5:	f3 0f 10 4b 44       	movss  0x44(%rbx),%xmm1
   fe3fa:	0f 29 85 10 fd ff ff 	movaps %xmm0,-0x2f0(%rbp)
   fe401:	66 0f 6e 83 98 03 00 	movd   0x398(%rbx),%xmm0
   fe408:	00 
   fe409:	48 8b 00             	mov    (%rax),%rax
   fe40c:	0f 16 85 58 f5 ff ff 	movhps -0xaa8(%rbp),%xmm0
   fe413:	48 89 85 c8 f4 ff ff 	mov    %rax,-0xb38(%rbp)
   fe41a:	0f 29 85 20 fd ff ff 	movaps %xmm0,-0x2e0(%rbp)
   fe421:	66 48 0f 6e c0       	movq   %rax,%xmm0
   fe426:	0f 16 83 60 30 00 00 	movhps 0x3060(%rbx),%xmm0
   fe42d:	0f 29 85 30 fd ff ff 	movaps %xmm0,-0x2d0(%rbp)
   fe434:	f3 0f 10 05 44 9b 0f 	movss  0xf9b44(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
   fe43b:	00 
   fe43c:	f3 0f 5e 85 1c f5 ff 	divss  -0xae4(%rbp),%xmm0
   fe443:	ff 
   fe444:	0f 14 c1             	unpcklps %xmm1,%xmm0
   fe447:	0f 13 85 40 fd ff ff 	movlps %xmm0,-0x2c0(%rbp)
   fe44e:	85 ff                	test   %edi,%edi
   fe450:	0f 85 4b d3 ff ff    	jne    fb7a1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x741>
   fe456:	45 31 ff             	xor    %r15d,%r15d
   fe459:	31 c0                	xor    %eax,%eax
   fe45b:	e9 62 d3 ff ff       	jmp    fb7c2 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x762>
   fe460:	85 c9                	test   %ecx,%ecx
   fe462:	0f 84 97 ce ff ff    	je     fb2ff <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x29f>
   fe468:	49 83 be c8 00 00 00 	cmpq   $0x0,0xc8(%r14)
   fe46f:	00 
   fe470:	0f 84 f4 87 f7 ff    	je     76c6a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x688>
   fe476:	89 ca                	mov    %ecx,%edx
   fe478:	49 39 96 e0 00 00 00 	cmp    %rdx,0xe0(%r14)
   fe47f:	0f 83 46 ce ff ff    	jae    fb2cb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x26b>
   fe485:	e9 e0 87 f7 ff       	jmp    76c6a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x688>
   fe48a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   fe490:	83 bd d0 f4 ff ff 02 	cmpl   $0x2,-0xb30(%rbp)
   fe497:	0f 94 c2             	sete   %dl
   fe49a:	20 c2                	and    %al,%dl
   fe49c:	88 95 f0 f4 ff ff    	mov    %dl,-0xb10(%rbp)
   fe4a2:	0f 85 e8 42 00 00    	jne    102790 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7730>
   fe4a8:	0f b6 95 a8 f4 ff ff 	movzbl -0xb58(%rbp),%edx
   fe4af:	88 95 f0 f4 ff ff    	mov    %dl,-0xb10(%rbp)
   fe4b5:	e9 a1 db ff ff       	jmp    fc05b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xffb>
   fe4ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   fe4c0:	83 bd d0 f4 ff ff 03 	cmpl   $0x3,-0xb30(%rbp)
   fe4c7:	75 37                	jne    fe500 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34a0>
   fe4c9:	45 31 ed             	xor    %r13d,%r13d
   fe4cc:	f3 0f 10 43 0c       	movss  0xc(%rbx),%xmm0
   fe4d1:	66 0f ef f6          	pxor   %xmm6,%xmm6
   fe4d5:	0f 2f c6             	comiss %xmm6,%xmm0
   fe4d8:	76 10                	jbe    fe4ea <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x348a>
   fe4da:	48 8b bd 88 f5 ff ff 	mov    -0xa78(%rbp),%rdi
   fe4e1:	48 85 ff             	test   %rdi,%rdi
   fe4e4:	0f 85 e6 25 00 00    	jne    100ad0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5a70>
   fe4ea:	8b 8d 00 f5 ff ff    	mov    -0xb00(%rbp),%ecx
   fe4f0:	39 8d e0 f4 ff ff    	cmp    %ecx,-0xb20(%rbp)
   fe4f6:	0f 8f 24 fb ff ff    	jg     fe020 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2fc0>
   fe4fc:	0f 1f 40 00          	nopl   0x0(%rax)
   fe500:	45 31 ed             	xor    %r13d,%r13d
   fe503:	83 bd e4 f4 ff ff 01 	cmpl   $0x1,-0xb1c(%rbp)
   fe50a:	0f 84 30 09 00 00    	je     fee40 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3de0>
   fe510:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   fe517:	48 8b 38             	mov    (%rax),%rdi
   fe51a:	48 8b 85 e8 f4 ff ff 	mov    -0xb18(%rbp),%rax
   fe521:	48 8b 30             	mov    (%rax),%rsi
   fe524:	48 39 fe             	cmp    %rdi,%rsi
   fe527:	0f 85 33 fb ff ff    	jne    fe060 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3000>
   fe52d:	e9 5f fb ff ff       	jmp    fe091 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3031>
   fe532:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   fe538:	48 c7 85 a8 f4 ff ff 	movq   $0x0,-0xb58(%rbp)
   fe53f:	00 00 00 00 
   fe543:	e9 4c ee ff ff       	jmp    fd394 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2334>
   fe548:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   fe54f:	00 
   fe550:	48 8d 85 30 fc ff ff 	lea    -0x3d0(%rbp),%rax
   fe557:	41 51                	push   %r9
   fe559:	4d 89 d0             	mov    %r10,%r8
   fe55c:	4c 89 d1             	mov    %r10,%rcx
   fe55f:	50                   	push   %rax
   fe560:	44 0f b6 8d c0 f4 ff 	movzbl -0xb40(%rbp),%r9d
   fe567:	ff 
   fe568:	48 89 df             	mov    %rbx,%rdi
   fe56b:	48 8b b5 68 f4 ff ff 	mov    -0xb98(%rbp),%rsi
   fe572:	e8 79 e6 f6 ff       	call   6cbf0 <synreal::SolverNewton::solve_pd_newton_system(synreal::SparseMatrixELL const&, synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, bool, std::function<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)> const&, CUstream_st*)@plt>
   fe577:	41 5a                	pop    %r10
   fe579:	41 5b                	pop    %r11
   fe57b:	e9 7b f9 ff ff       	jmp    fdefb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2e9b>
   fe580:	80 bd f0 f4 ff ff 00 	cmpb   $0x0,-0xb10(%rbp)
   fe587:	0f 85 63 ea ff ff    	jne    fcff0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1f90>
   fe58d:	48 8b 05 fc 99 0f 00 	mov    0xf99fc(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fe594:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fe59b:	4d 89 e1             	mov    %r12,%r9
   fe59e:	45 31 c0             	xor    %r8d,%r8d
   fe5a1:	48 8b 15 e8 99 0f 00 	mov    0xf99e8(%rip),%rdx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fe5a8:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fe5ae:	b9 01 00 00 00       	mov    $0x1,%ecx
   fe5b3:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fe5ba:	00 00 00 
   fe5bd:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fe5c4:	8b 85 18 f5 ff ff    	mov    -0xae8(%rbp),%eax
   fe5ca:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fe5d0:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fe5d7:	e8 d4 09 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fe5dc:	85 c0                	test   %eax,%eax
   fe5de:	75 3b                	jne    fe61b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x35bb>
   fe5e0:	31 d2                	xor    %edx,%edx
   fe5e2:	48 83 bb 00 01 00 00 	cmpq   $0x0,0x100(%rbx)
   fe5e9:	00 
   fe5ea:	4c 8b 8d 58 f5 ff ff 	mov    -0xaa8(%rbp),%r9
   fe5f1:	4c 8b 85 60 f5 ff ff 	mov    -0xaa0(%rbp),%r8
   fe5f8:	48 8b 8b 20 2f 00 00 	mov    0x2f20(%rbx),%rcx
   fe5ff:	74 07                	je     fe608 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x35a8>
   fe601:	48 8b 93 f8 00 00 00 	mov    0xf8(%rbx),%rdx
   fe608:	48 8b b3 c0 00 00 00 	mov    0xc0(%rbx),%rsi
   fe60f:	48 8b bb e0 2e 00 00 	mov    0x2ee0(%rbx),%rdi
   fe616:	e8 d5 c4 f6 ff       	call   6aaf0 <synreal::kernel::prepare_inverse_preconditioner(float const*, float const*, int const*, float*, unsigned long, unsigned long)@plt>
   fe61b:	e8 70 e2 f6 ff       	call   6c890 <cudaGetLastError@plt>
   fe620:	89 c7                	mov    %eax,%edi
   fe622:	48 8d 35 6f 74 0f 00 	lea    0xf746f(%rip),%rsi        # 1f5a98 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5b98>
   fe629:	e8 d2 f6 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fe62e:	e9 8e f8 ff ff       	jmp    fdec1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2e61>
   fe633:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   fe638:	4c 8b ad 80 f4 ff ff 	mov    -0xb80(%rbp),%r13
   fe63f:	48 8b 05 4a 99 0f 00 	mov    0xf994a(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fe646:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fe64d:	00 00 00 
   fe650:	4c 89 ef             	mov    %r13,%rdi
   fe653:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fe65a:	e8 01 e7 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fe65f:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fe666:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   fe66c:	4d 89 e1             	mov    %r12,%r9
   fe66f:	45 31 c0             	xor    %r8d,%r8d
   fe672:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fe678:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   fe67f:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fe686:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fe68c:	e8 1f 09 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fe691:	85 c0                	test   %eax,%eax
   fe693:	75 61                	jne    fe6f6 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3696>
   fe695:	8b 83 f0 04 00 00    	mov    0x4f0(%rbx),%eax
   fe69b:	48 83 ec 08          	sub    $0x8,%rsp
   fe69f:	48 8b 8b 08 05 00 00 	mov    0x508(%rbx),%rcx
   fe6a6:	48 8b 93 f8 04 00 00 	mov    0x4f8(%rbx),%rdx
   fe6ad:	48 8b b3 d0 03 00 00 	mov    0x3d0(%rbx),%rsi
   fe6b4:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
   fe6ba:	50                   	push   %rax
   fe6bb:	48 8b 85 e8 f4 ff ff 	mov    -0xb18(%rbp),%rax
   fe6c2:	41 55                	push   %r13
   fe6c4:	ff b3 90 34 00 00    	push   0x3490(%rbx)
   fe6ca:	ff b3 70 34 00 00    	push   0x3470(%rbx)
   fe6d0:	4c 8b 83 18 05 00 00 	mov    0x518(%rbx),%r8
   fe6d7:	ff b3 58 05 00 00    	push   0x558(%rbx)
   fe6dd:	48 8b 38             	mov    (%rax),%rdi
   fe6e0:	ff b3 50 34 00 00    	push   0x3450(%rbx)
   fe6e6:	4c 8b 8b 30 34 00 00 	mov    0x3430(%rbx),%r9
   fe6ed:	e8 8e c4 f6 ff       	call   6ab80 <synreal::kernel::update_body_distance_constraint_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   fe6f2:	48 83 c4 40          	add    $0x40,%rsp
   fe6f6:	e8 95 e1 f6 ff       	call   6c890 <cudaGetLastError@plt>
   fe6fb:	89 c7                	mov    %eax,%edi
   fe6fd:	48 8d 35 14 74 0f 00 	lea    0xf7414(%rip),%rsi        # 1f5b18 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5c18>
   fe704:	e8 f7 f5 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fe709:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fe710:	e9 de f8 ff ff       	jmp    fdff3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2f93>
   fe715:	0f 1f 00             	nopl   (%rax)
   fe718:	4c 8d ad 90 fe ff ff 	lea    -0x170(%rbp),%r13
   fe71f:	48 8b b5 60 f4 ff ff 	mov    -0xba0(%rbp),%rsi
   fe726:	b9 27 00 00 00       	mov    $0x27,%ecx
   fe72b:	48 8b 85 e8 f4 ff ff 	mov    -0xb18(%rbp),%rax
   fe732:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fe739:	00 00 00 
   fe73c:	4c 89 ef             	mov    %r13,%rdi
   fe73f:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
   fe742:	48 8b 00             	mov    (%rax),%rax
   fe745:	41 8b 7e 10          	mov    0x10(%r14),%edi
   fe749:	48 89 85 68 ff ff ff 	mov    %rax,-0x98(%rbp)
   fe750:	48 8b 05 39 98 0f 00 	mov    0xf9839(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fe757:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fe75e:	e8 fd e5 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fe763:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fe76a:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   fe770:	4d 89 e1             	mov    %r12,%r9
   fe773:	45 31 c0             	xor    %r8d,%r8d
   fe776:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fe77c:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   fe783:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fe78a:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fe790:	e8 1b 08 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fe795:	85 c0                	test   %eax,%eax
   fe797:	75 21                	jne    fe7ba <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x375a>
   fe799:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
   fe7a0:	b9 27 00 00 00       	mov    $0x27,%ecx
   fe7a5:	4c 89 ee             	mov    %r13,%rsi
   fe7a8:	48 89 e7             	mov    %rsp,%rdi
   fe7ab:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
   fe7ae:	e8 5d c5 f6 ff       	call   6ad10 <synreal::kernel::update_hard_contact_duals(synreal::kernel::HardContactView)@plt>
   fe7b3:	48 81 c4 40 01 00 00 	add    $0x140,%rsp
   fe7ba:	e8 d1 e0 f6 ff       	call   6c890 <cudaGetLastError@plt>
   fe7bf:	89 c7                	mov    %eax,%edi
   fe7c1:	48 8d 35 28 73 0f 00 	lea    0xf7328(%rip),%rsi        # 1f5af0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5bf0>
   fe7c8:	e8 33 f5 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fe7cd:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fe7d4:	e9 0a f8 ff ff       	jmp    fdfe3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2f83>
   fe7d9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   fe7e0:	48 8b 05 a9 97 0f 00 	mov    0xf97a9(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fe7e7:	48 8b bd 90 f5 ff ff 	mov    -0xa70(%rbp),%rdi
   fe7ee:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fe7f5:	00 00 00 
   fe7f8:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fe7ff:	e8 5c e5 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fe804:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fe80b:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   fe811:	4d 89 e1             	mov    %r12,%r9
   fe814:	45 31 c0             	xor    %r8d,%r8d
   fe817:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fe81d:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   fe824:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fe82b:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fe831:	e8 7a 07 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fe836:	85 c0                	test   %eax,%eax
   fe838:	0f 85 98 00 00 00    	jne    fe8d6 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3876>
   fe83e:	f3 0f 10 43 60       	movss  0x60(%rbx),%xmm0
   fe843:	ff b5 b8 f9 ff ff    	push   -0x648(%rbp)
   fe849:	ff b5 b0 f9 ff ff    	push   -0x650(%rbp)
   fe84f:	ff b5 a8 f9 ff ff    	push   -0x658(%rbp)
   fe855:	ff b5 a0 f9 ff ff    	push   -0x660(%rbp)
   fe85b:	ff b5 98 f9 ff ff    	push   -0x668(%rbp)
   fe861:	ff b5 90 f9 ff ff    	push   -0x670(%rbp)
   fe867:	ff b5 88 f9 ff ff    	push   -0x678(%rbp)
   fe86d:	ff b5 80 f9 ff ff    	push   -0x680(%rbp)
   fe873:	ff b5 78 f9 ff ff    	push   -0x688(%rbp)
   fe879:	ff b5 70 f9 ff ff    	push   -0x690(%rbp)
   fe87f:	ff b5 68 f9 ff ff    	push   -0x698(%rbp)
   fe885:	ff b5 60 f9 ff ff    	push   -0x6a0(%rbp)
   fe88b:	ff b5 58 f9 ff ff    	push   -0x6a8(%rbp)
   fe891:	ff b5 50 f9 ff ff    	push   -0x6b0(%rbp)
   fe897:	ff b5 48 f9 ff ff    	push   -0x6b8(%rbp)
   fe89d:	ff b5 40 f9 ff ff    	push   -0x6c0(%rbp)
   fe8a3:	48 8b 85 e8 f4 ff ff 	mov    -0xb18(%rbp),%rax
   fe8aa:	ff b5 38 f9 ff ff    	push   -0x6c8(%rbp)
   fe8b0:	ff b5 30 f9 ff ff    	push   -0x6d0(%rbp)
   fe8b6:	ff b5 28 f9 ff ff    	push   -0x6d8(%rbp)
   fe8bc:	ff b5 20 f9 ff ff    	push   -0x6e0(%rbp)
   fe8c2:	f3 0f 10 4b 64       	movss  0x64(%rbx),%xmm1
   fe8c7:	48 8b 38             	mov    (%rax),%rdi
   fe8ca:	e8 e1 bf f6 ff       	call   6a8b0 <synreal::kernel::update_cable_penalties(synreal::kernel::CableView, glm::vec<3, float, (glm::qualifier)0> const*, float, float)@plt>
   fe8cf:	48 81 c4 a0 00 00 00 	add    $0xa0,%rsp
   fe8d6:	e8 b5 df f6 ff       	call   6c890 <cudaGetLastError@plt>
   fe8db:	89 c7                	mov    %eax,%edi
   fe8dd:	48 8d 35 ec 8c 0f 00 	lea    0xf8cec(%rip),%rsi        # 1f75d0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x76d0>
   fe8e4:	e8 17 f4 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fe8e9:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fe8f0:	e9 e1 f6 ff ff       	jmp    fdfd6 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2f76>
   fe8f5:	0f 1f 00             	nopl   (%rax)
   fe8f8:	48 8b 05 91 96 0f 00 	mov    0xf9691(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fe8ff:	48 8b bd a0 f5 ff ff 	mov    -0xa60(%rbp),%rdi
   fe906:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fe90d:	00 00 00 
   fe910:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fe917:	e8 44 e4 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fe91c:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fe923:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   fe929:	4d 89 e1             	mov    %r12,%r9
   fe92c:	45 31 c0             	xor    %r8d,%r8d
   fe92f:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fe935:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   fe93c:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fe943:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fe949:	e8 62 06 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fe94e:	85 c0                	test   %eax,%eax
   fe950:	75 5f                	jne    fe9b1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3951>
   fe952:	8b 83 18 03 00 00    	mov    0x318(%rbx),%eax
   fe958:	48 8b 8b 50 03 00 00 	mov    0x350(%rbx),%rcx
   fe95f:	48 8b 93 40 03 00 00 	mov    0x340(%rbx),%rdx
   fe966:	48 8b b3 60 30 00 00 	mov    0x3060(%rbx),%rsi
   fe96d:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
   fe973:	4c 8b 8b 30 03 00 00 	mov    0x330(%rbx),%r9
   fe97a:	50                   	push   %rax
   fe97b:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   fe982:	ff b5 a0 f5 ff ff    	push   -0xa60(%rbp)
   fe988:	4c 8b 83 20 03 00 00 	mov    0x320(%rbx),%r8
   fe98f:	ff b3 40 30 00 00    	push   0x3040(%rbx)
   fe995:	48 8b 38             	mov    (%rax),%rdi
   fe998:	f3 0f 10 05 e0 95 0f 	movss  0xf95e0(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
   fe99f:	00 
   fe9a0:	f3 0f 5e 85 1c f5 ff 	divss  -0xae4(%rbp),%xmm0
   fe9a7:	ff 
   fe9a8:	e8 83 be f6 ff       	call   6a830 <synreal::kernel::evaluate_bending_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   fe9ad:	48 83 c4 20          	add    $0x20,%rsp
   fe9b1:	e8 da de f6 ff       	call   6c890 <cudaGetLastError@plt>
   fe9b6:	89 c7                	mov    %eax,%edi
   fe9b8:	48 8d 35 31 6c 0f 00 	lea    0xf6c31(%rip),%rsi        # 1f55f0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x56f0>
   fe9bf:	e8 3c f3 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fe9c4:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fe9cb:	e9 69 e5 ff ff       	jmp    fcf39 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ed9>
   fe9d0:	48 8b 05 b9 95 0f 00 	mov    0xf95b9(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fe9d7:	48 8b bd 68 f5 ff ff 	mov    -0xa98(%rbp),%rdi
   fe9de:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fe9e5:	00 00 00 
   fe9e8:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fe9ef:	e8 6c e3 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fe9f4:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fe9fb:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   fea01:	4d 89 e1             	mov    %r12,%r9
   fea04:	45 31 c0             	xor    %r8d,%r8d
   fea07:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fea0d:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   fea14:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fea1b:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fea21:	e8 8a 05 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fea26:	85 c0                	test   %eax,%eax
   fea28:	0f 85 82 00 00 00    	jne    feab0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3a50>
   fea2e:	48 8b 8d 78 f4 ff ff 	mov    -0xb88(%rbp),%rcx
   fea35:	31 c0                	xor    %eax,%eax
   fea37:	f3 0f 10 05 41 95 0f 	movss  0xf9541(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
   fea3e:	00 
   fea3f:	f3 0f 5e 85 1c f5 ff 	divss  -0xae4(%rbp),%xmm0
   fea46:	ff 
   fea47:	4c 8b 95 58 f5 ff ff 	mov    -0xaa8(%rbp),%r10
   fea4e:	44 8b 8b e0 02 00 00 	mov    0x2e0(%rbx),%r9d
   fea55:	48 83 79 48 00       	cmpq   $0x0,0x48(%rcx)
   fea5a:	4c 8b 85 68 f5 ff ff 	mov    -0xa98(%rbp),%r8
   fea61:	48 8b bb 40 30 00 00 	mov    0x3040(%rbx),%rdi
   fea68:	74 04                	je     fea6e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3a0e>
   fea6a:	48 8b 41 40          	mov    0x40(%rcx),%rax
   fea6e:	48 83 ec 08          	sub    $0x8,%rsp
   fea72:	48 8b 8b f8 02 00 00 	mov    0x2f8(%rbx),%rcx
   fea79:	48 8b 93 e8 02 00 00 	mov    0x2e8(%rbx),%rdx
   fea80:	48 8b b3 60 30 00 00 	mov    0x3060(%rbx),%rsi
   fea87:	41 52                	push   %r10
   fea89:	41 51                	push   %r9
   fea8b:	41 50                	push   %r8
   fea8d:	57                   	push   %rdi
   fea8e:	4c 8b 83 08 03 00 00 	mov    0x308(%rbx),%r8
   fea95:	50                   	push   %rax
   fea96:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   fea9d:	4c 8b 8b 90 33 00 00 	mov    0x3390(%rbx),%r9
   feaa4:	48 8b 38             	mov    (%rax),%rdi
   feaa7:	e8 b4 c3 f6 ff       	call   6ae60 <synreal::kernel::evaluate_tetrahedron_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   feaac:	48 83 c4 30          	add    $0x30,%rsp
   feab0:	e8 db dd f6 ff       	call   6c890 <cudaGetLastError@plt>
   feab5:	89 c7                	mov    %eax,%edi
   feab7:	48 8d 35 02 6b 0f 00 	lea    0xf6b02(%rip),%rsi        # 1f55c0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x56c0>
   feabe:	e8 3d f2 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   feac3:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   feaca:	e9 5c e4 ff ff       	jmp    fcf2b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ecb>
   feacf:	90                   	nop
   fead0:	4c 0f af ad 80 f5 ff 	imul   -0xa80(%rbp),%r13
   fead7:	ff 
   fead8:	48 8b 05 b1 94 0f 00 	mov    0xf94b1(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   feadf:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   feae6:	00 00 00 
   feae9:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   feaf0:	4c 89 ef             	mov    %r13,%rdi
   feaf3:	e8 68 e2 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   feaf8:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   feaff:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   feb05:	4d 89 e1             	mov    %r12,%r9
   feb08:	45 31 c0             	xor    %r8d,%r8d
   feb0b:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   feb11:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   feb18:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   feb1f:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   feb25:	e8 86 04 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   feb2a:	85 c0                	test   %eax,%eax
   feb2c:	75 49                	jne    feb77 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3b17>
   feb2e:	8b 83 78 02 00 00    	mov    0x278(%rbx),%eax
   feb34:	48 83 ec 08          	sub    $0x8,%rsp
   feb38:	48 8b 8b 80 02 00 00 	mov    0x280(%rbx),%rcx
   feb3f:	48 8b 93 a0 02 00 00 	mov    0x2a0(%rbx),%rdx
   feb46:	48 8b b3 90 02 00 00 	mov    0x290(%rbx),%rsi
   feb4d:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
   feb53:	4c 8b 8b 40 30 00 00 	mov    0x3040(%rbx),%r9
   feb5a:	50                   	push   %rax
   feb5b:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   feb62:	4c 8b 83 c0 02 00 00 	mov    0x2c0(%rbx),%r8
   feb69:	41 55                	push   %r13
   feb6b:	48 8b 38             	mov    (%rax),%rdi
   feb6e:	e8 bd c3 f6 ff       	call   6af30 <synreal::kernel::evaluate_stretch_force(glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::mat<2, 2, float, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   feb73:	48 83 c4 20          	add    $0x20,%rsp
   feb77:	e8 14 dd f6 ff       	call   6c890 <cudaGetLastError@plt>
   feb7c:	89 c7                	mov    %eax,%edi
   feb7e:	48 8d 35 13 6a 0f 00 	lea    0xf6a13(%rip),%rsi        # 1f5598 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5698>
   feb85:	e8 76 f1 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   feb8a:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   feb91:	e9 88 e3 ff ff       	jmp    fcf1e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ebe>
   feb96:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   feb9d:	00 00 00 
   feba0:	4c 0f af ad 80 f5 ff 	imul   -0xa80(%rbp),%r13
   feba7:	ff 
   feba8:	48 8b 05 e1 93 0f 00 	mov    0xf93e1(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   febaf:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   febb6:	00 00 00 
   febb9:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   febc0:	4c 89 ef             	mov    %r13,%rdi
   febc3:	e8 98 e1 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   febc8:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   febcf:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   febd5:	4d 89 e1             	mov    %r12,%r9
   febd8:	45 31 c0             	xor    %r8d,%r8d
   febdb:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   febe1:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   febe8:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   febef:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   febf5:	e8 b6 03 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   febfa:	85 c0                	test   %eax,%eax
   febfc:	75 3d                	jne    fec3b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3bdb>
   febfe:	8b 83 40 02 00 00    	mov    0x240(%rbx),%eax
   fec04:	48 8b 8b 68 02 00 00 	mov    0x268(%rbx),%rcx
   fec0b:	4d 89 e9             	mov    %r13,%r9
   fec0e:	48 8b 93 58 02 00 00 	mov    0x258(%rbx),%rdx
   fec15:	48 8b b3 48 02 00 00 	mov    0x248(%rbx),%rsi
   fec1c:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
   fec22:	4c 8b 83 40 30 00 00 	mov    0x3040(%rbx),%r8
   fec29:	50                   	push   %rax
   fec2a:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   fec31:	48 8b 38             	mov    (%rax),%rdi
   fec34:	e8 b7 bf f6 ff       	call   6abf0 <synreal::kernel::evaluate_spring_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, float const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   fec39:	59                   	pop    %rcx
   fec3a:	5e                   	pop    %rsi
   fec3b:	e8 50 dc f6 ff       	call   6c890 <cudaGetLastError@plt>
   fec40:	89 c7                	mov    %eax,%edi
   fec42:	48 8d 35 27 69 0f 00 	lea    0xf6927(%rip),%rsi        # 1f5570 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5670>
   fec49:	e8 b2 f0 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fec4e:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fec55:	e9 b4 e2 ff ff       	jmp    fcf0e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1eae>
   fec5a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   fec60:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   fec67:	48 8b 8b 40 30 00 00 	mov    0x3040(%rbx),%rcx
   fec6e:	48 8d bb 28 17 00 00 	lea    0x1728(%rbx),%rdi
   fec75:	48 8b 93 60 30 00 00 	mov    0x3060(%rbx),%rdx
   fec7c:	4c 8b 85 10 f5 ff ff 	mov    -0xaf0(%rbp),%r8
   fec83:	f3 0f 10 85 1c f5 ff 	movss  -0xae4(%rbp),%xmm0
   fec8a:	ff 
   fec8b:	48 8b 30             	mov    (%rax),%rsi
   fec8e:	e8 5d ff f6 ff       	call   6ebf0 <synreal::Fluid::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)@plt>
   fec93:	8b 83 80 21 00 00    	mov    0x2180(%rbx),%eax
   fec99:	85 c0                	test   %eax,%eax
   fec9b:	0f 84 4c d7 ff ff    	je     fc3ed <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x138d>
   feca1:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   feca8:	48 8b 8b 40 30 00 00 	mov    0x3040(%rbx),%rcx
   fecaf:	48 8d bb 70 20 00 00 	lea    0x2070(%rbx),%rdi
   fecb6:	48 8b 93 60 30 00 00 	mov    0x3060(%rbx),%rdx
   fecbd:	4c 8b 85 10 f5 ff ff 	mov    -0xaf0(%rbp),%r8
   fecc4:	f3 0f 10 85 1c f5 ff 	movss  -0xae4(%rbp),%xmm0
   feccb:	ff 
   feccc:	48 8b 30             	mov    (%rax),%rsi
   feccf:	e8 4c ea f6 ff       	call   6d720 <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)@plt>
   fecd4:	e9 14 d7 ff ff       	jmp    fc3ed <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x138d>
   fecd9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   fece0:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   fece7:	f3 0f 10 43 74       	movss  0x74(%rbx),%xmm0
   fecec:	4d 89 e1             	mov    %r12,%r9
   fecef:	48 8d bb f0 08 00 00 	lea    0x8f0(%rbx),%rdi
   fecf6:	48 8b 8b 40 30 00 00 	mov    0x3040(%rbx),%rcx
   fecfd:	48 8b 93 00 2f 00 00 	mov    0x2f00(%rbx),%rdx
   fed04:	44 0f b6 43 41       	movzbl 0x41(%rbx),%r8d
   fed09:	f3 0f 10 a3 84 00 00 	movss  0x84(%rbx),%xmm4
   fed10:	00 
   fed11:	f3 0f 10 9b 80 00 00 	movss  0x80(%rbx),%xmm3
   fed18:	00 
   fed19:	f3 0f 10 53 7c       	movss  0x7c(%rbx),%xmm2
   fed1e:	f3 0f 10 4b 78       	movss  0x78(%rbx),%xmm1
   fed23:	48 8b 30             	mov    (%rax),%rsi
   fed26:	e8 d5 c7 f6 ff       	call   6b500 <synreal::SelfCollision::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, float, float, float, float, glm::vec<3, float, (glm::qualifier)0>*, bool, CUstream_st*)@plt>
   fed2b:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fed32:	e9 7d e1 ff ff       	jmp    fceb4 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1e54>
   fed37:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   fed3e:	00 00 
   fed40:	f3 0f 10 43 0c       	movss  0xc(%rbx),%xmm0
   fed45:	66 0f ef f6          	pxor   %xmm6,%xmm6
   fed49:	41 bd 01 00 00 00    	mov    $0x1,%r13d
   fed4f:	0f 2f c6             	comiss %xmm6,%xmm0
   fed52:	0f 86 ed 00 00 00    	jbe    fee45 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3de5>
   fed58:	48 83 bd 58 f4 ff ff 	cmpq   $0x0,-0xba8(%rbp)
   fed5f:	00 
   fed60:	0f 84 ec 00 00 00    	je     fee52 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3df2>
   fed66:	4c 8b ad 58 f4 ff ff 	mov    -0xba8(%rbp),%r13
   fed6d:	48 8b 05 1c 92 0f 00 	mov    0xf921c(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fed74:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fed7b:	00 00 00 
   fed7e:	4c 89 ef             	mov    %r13,%rdi
   fed81:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fed88:	e8 d3 df f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fed8d:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fed94:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   fed9a:	4d 89 e1             	mov    %r12,%r9
   fed9d:	45 31 c0             	xor    %r8d,%r8d
   feda0:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   feda6:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   fedad:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fedb4:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fedba:	e8 f1 01 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fedbf:	85 c0                	test   %eax,%eax
   fedc1:	75 58                	jne    fee1b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3dbb>
   fedc3:	8b 83 9c 04 00 00    	mov    0x49c(%rbx),%eax
   fedc9:	48 8b 8b b0 04 00 00 	mov    0x4b0(%rbx),%rcx
   fedd0:	48 8b 93 a0 04 00 00 	mov    0x4a0(%rbx),%rdx
   fedd7:	48 8b b3 d0 03 00 00 	mov    0x3d0(%rbx),%rsi
   fedde:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
   fede4:	50                   	push   %rax
   fede5:	8b 83 98 04 00 00    	mov    0x498(%rbx),%eax
   fedeb:	50                   	push   %rax
   fedec:	48 8b 85 e8 f4 ff ff 	mov    -0xb18(%rbp),%rax
   fedf3:	41 55                	push   %r13
   fedf5:	ff b3 10 34 00 00    	push   0x3410(%rbx)
   fedfb:	4c 8b 83 c0 04 00 00 	mov    0x4c0(%rbx),%r8
   fee02:	48 8b 38             	mov    (%rax),%rdi
   fee05:	ff b3 f0 33 00 00    	push   0x33f0(%rbx)
   fee0b:	4c 8b 8b d0 33 00 00 	mov    0x33d0(%rbx),%r9
   fee12:	e8 99 bc f6 ff       	call   6aab0 <synreal::kernel::update_joint_body_spring_augmented_lagrangian_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
   fee17:	48 83 c4 30          	add    $0x30,%rsp
   fee1b:	e8 70 da f6 ff       	call   6c890 <cudaGetLastError@plt>
   fee20:	89 c7                	mov    %eax,%edi
   fee22:	48 8d 35 57 6d 0f 00 	lea    0xf6d57(%rip),%rsi        # 1f5b80 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5c80>
   fee29:	e8 d2 ee f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fee2e:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fee35:	41 bd 01 00 00 00    	mov    $0x1,%r13d
   fee3b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   fee40:	f3 0f 10 43 0c       	movss  0xc(%rbx),%xmm0
   fee45:	66 0f ef ed          	pxor   %xmm5,%xmm5
   fee49:	0f 2f c5             	comiss %xmm5,%xmm0
   fee4c:	0f 86 be f6 ff ff    	jbe    fe510 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34b0>
   fee52:	48 8b bd 98 f5 ff ff 	mov    -0xa68(%rbp),%rdi
   fee59:	48 85 ff             	test   %rdi,%rdi
   fee5c:	0f 84 ae f6 ff ff    	je     fe510 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34b0>
   fee62:	48 8b 05 27 91 0f 00 	mov    0xf9127(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fee69:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fee70:	00 00 00 
   fee73:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fee7a:	e8 e1 de f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fee7f:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fee86:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   fee8c:	4d 89 e1             	mov    %r12,%r9
   fee8f:	45 31 c0             	xor    %r8d,%r8d
   fee92:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fee98:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   fee9f:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   feea6:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   feeac:	e8 ff 00 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   feeb1:	85 c0                	test   %eax,%eax
   feeb3:	75 70                	jne    fef25 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3ec5>
   feeb5:	8b 83 6c 05 00 00    	mov    0x56c(%rbx),%eax
   feebb:	48 8b 8b b0 34 00 00 	mov    0x34b0(%rbx),%rcx
   feec2:	48 8b 93 70 05 00 00 	mov    0x570(%rbx),%rdx
   feec9:	48 8b b3 d0 03 00 00 	mov    0x3d0(%rbx),%rsi
   feed0:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
   feed6:	4c 8b 8b f0 34 00 00 	mov    0x34f0(%rbx),%r9
   feedd:	50                   	push   %rax
   feede:	8b 83 68 05 00 00    	mov    0x568(%rbx),%eax
   feee4:	4c 8b 83 d0 34 00 00 	mov    0x34d0(%rbx),%r8
   feeeb:	50                   	push   %rax
   feeec:	48 8b 85 e8 f4 ff ff 	mov    -0xb18(%rbp),%rax
   feef3:	ff b5 98 f5 ff ff    	push   -0xa68(%rbp)
   feef9:	41 55                	push   %r13
   feefb:	ff b3 30 35 00 00    	push   0x3530(%rbx)
   fef01:	ff b3 50 35 00 00    	push   0x3550(%rbx)
   fef07:	ff b3 10 35 00 00    	push   0x3510(%rbx)
   fef0d:	ff b3 a0 05 00 00    	push   0x5a0(%rbx)
   fef13:	ff b3 90 05 00 00    	push   0x590(%rbx)
   fef19:	48 8b 38             	mov    (%rax),%rdi
   fef1c:	e8 4f bf f6 ff       	call   6ae70 <synreal::kernel::update_joint_body_point_line_augmented_lagrangian_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, bool, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
   fef21:	48 83 c4 50          	add    $0x50,%rsp
   fef25:	e8 66 d9 f6 ff       	call   6c890 <cudaGetLastError@plt>
   fef2a:	89 c7                	mov    %eax,%edi
   fef2c:	48 8d 35 7d 6c 0f 00 	lea    0xf6c7d(%rip),%rsi        # 1f5bb0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5cb0>
   fef33:	e8 c8 ed f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fef38:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fef3f:	e9 cc f5 ff ff       	jmp    fe510 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x34b0>
   fef44:	0f 1f 40 00          	nopl   0x0(%rax)
   fef48:	8b 83 98 03 00 00    	mov    0x398(%rbx),%eax
   fef4e:	85 c0                	test   %eax,%eax
   fef50:	0f 84 82 e3 ff ff    	je     fd2d8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2278>
   fef56:	83 bd d0 f4 ff ff 02 	cmpl   $0x2,-0xb30(%rbp)
   fef5d:	0f 85 75 e3 ff ff    	jne    fd2d8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2278>
   fef63:	f3 0f 10 43 0c       	movss  0xc(%rbx),%xmm0
   fef68:	66 0f ef f6          	pxor   %xmm6,%xmm6
   fef6c:	0f 2f c6             	comiss %xmm6,%xmm0
   fef6f:	0f 86 63 e3 ff ff    	jbe    fd2d8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2278>
   fef75:	48 8b 05 14 90 0f 00 	mov    0xf9014(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fef7c:	48 8b bd 88 f5 ff ff 	mov    -0xa78(%rbp),%rdi
   fef83:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   fef8a:	00 00 00 
   fef8d:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   fef94:	e8 c7 dd f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fef99:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   fefa0:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   fefa6:	4d 89 e1             	mov    %r12,%r9
   fefa9:	45 31 c0             	xor    %r8d,%r8d
   fefac:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   fefb2:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   fefb9:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   fefc0:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   fefc6:	e8 e5 ff f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fefcb:	85 c0                	test   %eax,%eax
   fefcd:	75 66                	jne    ff035 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3fd5>
   fefcf:	8b 83 98 03 00 00    	mov    0x398(%rbx),%eax
   fefd5:	f3 0f 10 43 0c       	movss  0xc(%rbx),%xmm0
   fefda:	48 83 ec 08          	sub    $0x8,%rsp
   fefde:	f3 0f 59 85 34 f5 ff 	mulss  -0xacc(%rbp),%xmm0
   fefe5:	ff 
   fefe6:	48 8b 93 a0 03 00 00 	mov    0x3a0(%rbx),%rdx
   fefed:	48 8b b3 d0 03 00 00 	mov    0x3d0(%rbx),%rsi
   feff4:	ff b5 60 f5 ff ff    	push   -0xaa0(%rbp)
   feffa:	4c 8b 8d 90 f4 ff ff 	mov    -0xb70(%rbp),%r9
   ff001:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
   ff007:	4c 8b 85 70 f4 ff ff 	mov    -0xb90(%rbp),%r8
   ff00e:	50                   	push   %rax
   ff00f:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   ff016:	ff b5 88 f5 ff ff    	push   -0xa78(%rbp)
   ff01c:	48 8b 8d a8 f4 ff ff 	mov    -0xb58(%rbp),%rcx
   ff023:	ff b5 a0 f4 ff ff    	push   -0xb60(%rbp)
   ff029:	48 8b 38             	mov    (%rax),%rdi
   ff02c:	e8 cf be f6 ff       	call   6af00 <synreal::kernel::add_affine_body_spring_gauss_newton_hessian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
   ff031:	48 83 c4 30          	add    $0x30,%rsp
   ff035:	e8 56 d8 f6 ff       	call   6c890 <cudaGetLastError@plt>
   ff03a:	89 c7                	mov    %eax,%edi
   ff03c:	48 8d 35 7d 66 0f 00 	lea    0xf667d(%rip),%rsi        # 1f56c0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x57c0>
   ff043:	e8 b8 ec f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ff048:	80 bd 38 f4 ff ff 00 	cmpb   $0x0,-0xbc8(%rbp)
   ff04f:	0f 84 22 e1 ff ff    	je     fd177 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2117>
   ff055:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   ff05c:	e9 26 e0 ff ff       	jmp    fd087 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2027>
   ff061:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   ff068:	e8 f3 dc f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   ff06d:	4c 89 bd 50 f7 ff ff 	mov    %r15,-0x8b0(%rbp)
   ff074:	8b 8d 10 f7 ff ff    	mov    -0x8f0(%rbp),%ecx
   ff07a:	4d 89 e1             	mov    %r12,%r9
   ff07d:	45 31 c0             	xor    %r8d,%r8d
   ff080:	89 85 4c f7 ff ff    	mov    %eax,-0x8b4(%rbp)
   ff086:	48 8b 95 08 f7 ff ff 	mov    -0x8f8(%rbp),%rdx
   ff08d:	48 8b bd 4c f7 ff ff 	mov    -0x8b4(%rbp),%rdi
   ff094:	8b b5 54 f7 ff ff    	mov    -0x8ac(%rbp),%esi
   ff09a:	e8 11 ff f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   ff09f:	41 89 c0             	mov    %eax,%r8d
   ff0a2:	48 8d 85 50 f6 ff ff 	lea    -0x9b0(%rbp),%rax
   ff0a9:	48 8d 95 a8 f6 ff ff 	lea    -0x958(%rbp),%rdx
   ff0b0:	66 4c 0f 6e c8       	movq   %rax,%xmm9
   ff0b5:	48 8d 85 58 f6 ff ff 	lea    -0x9a8(%rbp),%rax
   ff0bc:	66 48 0f 6e f8       	movq   %rax,%xmm7
   ff0c1:	48 8d 85 60 f6 ff ff 	lea    -0x9a0(%rbp),%rax
   ff0c8:	66 4c 0f 6e c0       	movq   %rax,%xmm8
   ff0cd:	48 8d 85 68 f6 ff ff 	lea    -0x998(%rbp),%rax
   ff0d4:	66 44 0f 6c cf       	punpcklqdq %xmm7,%xmm9
   ff0d9:	66 48 0f 6e f0       	movq   %rax,%xmm6
   ff0de:	48 8d 85 70 f6 ff ff 	lea    -0x990(%rbp),%rax
   ff0e5:	66 48 0f 6e f8       	movq   %rax,%xmm7
   ff0ea:	48 8d 85 78 f6 ff ff 	lea    -0x988(%rbp),%rax
   ff0f1:	66 44 0f 6c c6       	punpcklqdq %xmm6,%xmm8
   ff0f6:	66 48 0f 6e e8       	movq   %rax,%xmm5
   ff0fb:	48 8d 85 80 f6 ff ff 	lea    -0x980(%rbp),%rax
   ff102:	66 48 0f 6e f0       	movq   %rax,%xmm6
   ff107:	48 8d 85 88 f6 ff ff 	lea    -0x978(%rbp),%rax
   ff10e:	66 0f 6c fd          	punpcklqdq %xmm5,%xmm7
   ff112:	66 48 0f 6e e0       	movq   %rax,%xmm4
   ff117:	48 8d 85 50 f5 ff ff 	lea    -0xab0(%rbp),%rax
   ff11e:	66 48 0f 6e e8       	movq   %rax,%xmm5
   ff123:	48 8d 85 60 fa ff ff 	lea    -0x5a0(%rbp),%rax
   ff12a:	66 0f 6c f4          	punpcklqdq %xmm4,%xmm6
   ff12e:	66 48 0f 6e e0       	movq   %rax,%xmm4
   ff133:	48 8d 85 90 f6 ff ff 	lea    -0x970(%rbp),%rax
   ff13a:	66 0f 6c ec          	punpcklqdq %xmm4,%xmm5
   ff13e:	66 48 0f 6e e0       	movq   %rax,%xmm4
   ff143:	48 8d 85 98 f6 ff ff 	lea    -0x968(%rbp),%rax
   ff14a:	66 48 0f 6e d8       	movq   %rax,%xmm3
   ff14f:	48 8d 85 54 f5 ff ff 	lea    -0xaac(%rbp),%rax
   ff156:	66 0f 6c e3          	punpcklqdq %xmm3,%xmm4
   ff15a:	66 48 0f 6e d8       	movq   %rax,%xmm3
   ff15f:	48 8d 85 a0 f6 ff ff 	lea    -0x960(%rbp),%rax
   ff166:	66 48 0f 6e d0       	movq   %rax,%xmm2
   ff16b:	48 8d 85 b0 f6 ff ff 	lea    -0x950(%rbp),%rax
   ff172:	66 48 0f 6e c8       	movq   %rax,%xmm1
   ff177:	66 0f 6c da          	punpcklqdq %xmm2,%xmm3
   ff17b:	48 8d 85 c0 f6 ff ff 	lea    -0x940(%rbp),%rax
   ff182:	66 48 0f 6e d2       	movq   %rdx,%xmm2
   ff187:	48 8d 95 b8 f6 ff ff 	lea    -0x948(%rbp),%rdx
   ff18e:	66 48 0f 6e c0       	movq   %rax,%xmm0
   ff193:	66 0f 6c d1          	punpcklqdq %xmm1,%xmm2
   ff197:	48 8d 85 c8 f6 ff ff 	lea    -0x938(%rbp),%rax
   ff19e:	66 48 0f 6e ca       	movq   %rdx,%xmm1
   ff1a3:	48 8d 95 d0 f6 ff ff 	lea    -0x930(%rbp),%rdx
   ff1aa:	66 0f 6c c8          	punpcklqdq %xmm0,%xmm1
   ff1ae:	66 48 0f 6e c0       	movq   %rax,%xmm0
   ff1b3:	66 4c 0f 6e fa       	movq   %rdx,%xmm15
   ff1b8:	66 41 0f 6c c7       	punpcklqdq %xmm15,%xmm0
   ff1bd:	45 85 c0             	test   %r8d,%r8d
   ff1c0:	0f 85 a6 eb ff ff    	jne    fdd6c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2d0c>
   ff1c6:	48 8b 85 58 f5 ff ff 	mov    -0xaa8(%rbp),%rax
   ff1cd:	80 bd 31 f5 ff ff 00 	cmpb   $0x0,-0xacf(%rbp)
   ff1d4:	66 45 0f ef d2       	pxor   %xmm10,%xmm10
   ff1d9:	f3 44 0f 10 25 9e 8d 	movss  0xf8d9e(%rip),%xmm12        # 1f7f80 <cuda::std::__4::in_place+0x33>
   ff1e0:	0f 00 
   ff1e2:	66 44 0f 6e 9b 98 03 	movd   0x398(%rbx),%xmm11
   ff1e9:	00 00 
   ff1eb:	f3 44 0f 5e a5 1c f5 	divss  -0xae4(%rbp),%xmm12
   ff1f2:	ff ff 
   ff1f4:	48 89 85 90 f4 ff ff 	mov    %rax,-0xb70(%rbp)
   ff1fb:	48 8b 85 88 f5 ff ff 	mov    -0xa78(%rbp),%rax
   ff202:	48 8b b3 80 2f 00 00 	mov    0x2f80(%rbx),%rsi
   ff209:	48 8b bb c0 2f 00 00 	mov    0x2fc0(%rbx),%rdi
   ff210:	48 89 85 a0 f4 ff ff 	mov    %rax,-0xb60(%rbp)
   ff217:	48 8b 83 a0 2f 00 00 	mov    0x2fa0(%rbx),%rax
   ff21e:	4c 8b 83 00 30 00 00 	mov    0x3000(%rbx),%r8
   ff225:	4c 8b 8b e0 2f 00 00 	mov    0x2fe0(%rbx),%r9
   ff22c:	48 89 85 70 f4 ff ff 	mov    %rax,-0xb90(%rbp)
   ff233:	74 0f                	je     ff244 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x41e4>
   ff235:	f3 44 0f 10 53 0c    	movss  0xc(%rbx),%xmm10
   ff23b:	f3 44 0f 59 95 34 f5 	mulss  -0xacc(%rbp),%xmm10
   ff242:	ff ff 
   ff244:	48 8b 95 68 f4 ff ff 	mov    -0xb98(%rbp),%rdx
   ff24b:	4c 8b 93 50 33 00 00 	mov    0x3350(%rbx),%r10
   ff252:	48 8b 42 28          	mov    0x28(%rdx),%rax
   ff256:	4c 8b 5a 20          	mov    0x20(%rdx),%r11
   ff25a:	4c 8b 62 10          	mov    0x10(%rdx),%r12
   ff25e:	4c 8b 2a             	mov    (%rdx),%r13
   ff261:	48 8b 93 60 2f 00 00 	mov    0x2f60(%rbx),%rdx
   ff268:	48 85 c0             	test   %rax,%rax
   ff26b:	48 0f 44 85 60 f5 ff 	cmove  -0xaa0(%rbp),%rax
   ff272:	ff 
   ff273:	48 89 95 20 f4 ff ff 	mov    %rdx,-0xbe0(%rbp)
   ff27a:	31 d2                	xor    %edx,%edx
   ff27c:	48 83 bb 00 01 00 00 	cmpq   $0x0,0x100(%rbx)
   ff283:	00 
   ff284:	74 07                	je     ff28d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x422d>
   ff286:	48 8b 93 f8 00 00 00 	mov    0xf8(%rbx),%rdx
   ff28d:	66 44 0f 6f ad 20 f9 	movdqa -0x6e0(%rbp),%xmm13
   ff294:	ff ff 
   ff296:	48 8b 8b d0 03 00 00 	mov    0x3d0(%rbx),%rcx
   ff29d:	48 89 95 58 f6 ff ff 	mov    %rdx,-0x9a8(%rbp)
   ff2a4:	66 44 0f 6f b5 70 f9 	movdqa -0x690(%rbp),%xmm14
   ff2ab:	ff ff 
   ff2ad:	48 8b 95 20 f4 ff ff 	mov    -0xbe0(%rbp),%rdx
   ff2b4:	4c 89 ad 68 f6 ff ff 	mov    %r13,-0x998(%rbp)
   ff2bb:	66 44 0f 6f bd 80 f9 	movdqa -0x680(%rbp),%xmm15
   ff2c2:	ff ff 
   ff2c4:	44 0f 29 ad 60 fa ff 	movaps %xmm13,-0x5a0(%rbp)
   ff2cb:	ff 
   ff2cc:	66 44 0f 6f ad 30 f9 	movdqa -0x6d0(%rbp),%xmm13
   ff2d3:	ff ff 
   ff2d5:	48 89 8d 40 f6 ff ff 	mov    %rcx,-0x9c0(%rbp)
   ff2dc:	48 8b 8b a0 03 00 00 	mov    0x3a0(%rbx),%rcx
   ff2e3:	44 0f 29 ad 70 fa ff 	movaps %xmm13,-0x590(%rbp)
   ff2ea:	ff 
   ff2eb:	66 44 0f 6f ad 40 f9 	movdqa -0x6c0(%rbp),%xmm13
   ff2f2:	ff ff 
   ff2f4:	48 89 8d 48 f6 ff ff 	mov    %rcx,-0x9b8(%rbp)
   ff2fb:	48 8b 8b c0 00 00 00 	mov    0xc0(%rbx),%rcx
   ff302:	44 0f 29 ad 80 fa ff 	movaps %xmm13,-0x580(%rbp)
   ff309:	ff 
   ff30a:	66 44 0f 6f ad 50 f9 	movdqa -0x6b0(%rbp),%xmm13
   ff311:	ff ff 
   ff313:	44 0f 29 b5 b0 fa ff 	movaps %xmm14,-0x550(%rbp)
   ff31a:	ff 
   ff31b:	66 44 0f 6f b5 a0 f9 	movdqa -0x660(%rbp),%xmm14
   ff322:	ff ff 
   ff324:	44 0f 29 ad 90 fa ff 	movaps %xmm13,-0x570(%rbp)
   ff32b:	ff 
   ff32c:	66 44 0f 6f ad 60 f9 	movdqa -0x6a0(%rbp),%xmm13
   ff333:	ff ff 
   ff335:	44 0f 29 bd c0 fa ff 	movaps %xmm15,-0x540(%rbp)
   ff33c:	ff 
   ff33d:	66 44 0f 6f bd b0 f9 	movdqa -0x650(%rbp),%xmm15
   ff344:	ff ff 
   ff346:	44 0f 29 ad a0 fa ff 	movaps %xmm13,-0x560(%rbp)
   ff34d:	ff 
   ff34e:	66 44 0f 6f ad 90 f9 	movdqa -0x670(%rbp),%xmm13
   ff355:	ff ff 
   ff357:	48 89 8d 50 f6 ff ff 	mov    %rcx,-0x9b0(%rbp)
   ff35e:	48 8d 8d e0 f6 ff ff 	lea    -0x920(%rbp),%rcx
   ff365:	48 89 95 60 f6 ff ff 	mov    %rdx,-0x9a0(%rbp)
   ff36c:	48 8d 95 d8 f6 ff ff 	lea    -0x928(%rbp),%rdx
   ff373:	4c 89 a5 70 f6 ff ff 	mov    %r12,-0x990(%rbp)
   ff37a:	4c 89 9d 78 f6 ff ff 	mov    %r11,-0x988(%rbp)
   ff381:	44 0f 29 ad d0 fa ff 	movaps %xmm13,-0x530(%rbp)
   ff388:	ff 
   ff389:	44 0f 29 b5 e0 fa ff 	movaps %xmm14,-0x520(%rbp)
   ff390:	ff 
   ff391:	44 0f 29 bd f0 fa ff 	movaps %xmm15,-0x510(%rbp)
   ff398:	ff 
   ff399:	48 89 85 80 f6 ff ff 	mov    %rax,-0x980(%rbp)
   ff3a0:	48 8b 85 a8 f4 ff ff 	mov    -0xb58(%rbp),%rax
   ff3a7:	66 44 0f d6 9d c8 f6 	movq   %xmm11,-0x938(%rbp)
   ff3ae:	ff ff 
   ff3b0:	66 44 0f 6f 9d 10 f4 	movdqa -0xbf0(%rbp),%xmm11
   ff3b7:	ff ff 
   ff3b9:	48 89 85 a8 f6 ff ff 	mov    %rax,-0x958(%rbp)
   ff3c0:	48 8b 85 70 f4 ff ff 	mov    -0xb90(%rbp),%rax
   ff3c7:	48 89 bd a0 f6 ff ff 	mov    %rdi,-0x960(%rbp)
   ff3ce:	48 8d bd 18 f7 ff ff 	lea    -0x8e8(%rbp),%rdi
   ff3d5:	48 89 85 b8 f6 ff ff 	mov    %rax,-0x948(%rbp)
   ff3dc:	48 8b 85 a0 f4 ff ff 	mov    -0xb60(%rbp),%rax
   ff3e3:	48 89 b5 b0 f6 ff ff 	mov    %rsi,-0x950(%rbp)
   ff3ea:	48 8d b5 40 f7 ff ff 	lea    -0x8c0(%rbp),%rsi
   ff3f1:	48 89 85 c0 f6 ff ff 	mov    %rax,-0x940(%rbp)
   ff3f8:	48 8b 85 90 f4 ff ff 	mov    -0xb70(%rbp),%rax
   ff3ff:	4c 89 95 88 f6 ff ff 	mov    %r10,-0x978(%rbp)
   ff406:	48 89 85 d0 f6 ff ff 	mov    %rax,-0x930(%rbp)
   ff40d:	48 8b 05 5c 8b 0f 00 	mov    0xf8b5c(%rip),%rax        # 1f7f70 <cuda::std::__4::in_place+0x23>
   ff414:	4c 89 8d 90 f6 ff ff 	mov    %r9,-0x970(%rbp)
   ff41b:	4c 89 85 98 f6 ff ff 	mov    %r8,-0x968(%rbp)
   ff422:	48 89 85 18 f7 ff ff 	mov    %rax,-0x8e8(%rbp)
   ff429:	c7 85 20 f7 ff ff 01 	movl   $0x1,-0x8e0(%rbp)
   ff430:	00 00 00 
   ff433:	48 89 85 40 f7 ff ff 	mov    %rax,-0x8c0(%rbp)
   ff43a:	f3 44 0f 11 95 50 f5 	movss  %xmm10,-0xab0(%rbp)
   ff441:	ff ff 
   ff443:	f3 44 0f 11 a5 54 f5 	movss  %xmm12,-0xaac(%rbp)
   ff44a:	ff ff 
   ff44c:	44 0f 29 9d 90 fe ff 	movaps %xmm11,-0x170(%rbp)
   ff453:	ff 
   ff454:	44 0f 29 8d a0 fe ff 	movaps %xmm9,-0x160(%rbp)
   ff45b:	ff 
   ff45c:	44 0f 29 85 b0 fe ff 	movaps %xmm8,-0x150(%rbp)
   ff463:	ff 
   ff464:	0f 29 bd c0 fe ff ff 	movaps %xmm7,-0x140(%rbp)
   ff46b:	0f 29 b5 d0 fe ff ff 	movaps %xmm6,-0x130(%rbp)
   ff472:	0f 29 ad e0 fe ff ff 	movaps %xmm5,-0x120(%rbp)
   ff479:	0f 29 a5 f0 fe ff ff 	movaps %xmm4,-0x110(%rbp)
   ff480:	0f 29 9d 00 ff ff ff 	movaps %xmm3,-0x100(%rbp)
   ff487:	0f 29 95 10 ff ff ff 	movaps %xmm2,-0xf0(%rbp)
   ff48e:	0f 29 8d 20 ff ff ff 	movaps %xmm1,-0xe0(%rbp)
   ff495:	0f 29 85 30 ff ff ff 	movaps %xmm0,-0xd0(%rbp)
   ff49c:	c7 85 48 f7 ff ff 01 	movl   $0x1,-0x8b8(%rbp)
   ff4a3:	00 00 00 
   ff4a6:	e8 95 f6 f6 ff       	call   6eb40 <__cudaPopCallConfiguration@plt>
   ff4ab:	85 c0                	test   %eax,%eax
   ff4ad:	0f 85 b9 e8 ff ff    	jne    fdd6c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2d0c>
   ff4b3:	ff b5 e0 f6 ff ff    	push   -0x920(%rbp)
   ff4b9:	48 8b b5 18 f7 ff ff 	mov    -0x8e8(%rbp),%rsi
   ff4c0:	4c 8d 8d 90 fe ff ff 	lea    -0x170(%rbp),%r9
   ff4c7:	8b 95 20 f7 ff ff    	mov    -0x8e0(%rbp),%edx
   ff4cd:	ff b5 d8 f6 ff ff    	push   -0x928(%rbp)
   ff4d3:	48 8b 8d 40 f7 ff ff 	mov    -0x8c0(%rbp),%rcx
   ff4da:	48 89 b5 64 f7 ff ff 	mov    %rsi,-0x89c(%rbp)
   ff4e1:	44 8b 85 48 f7 ff ff 	mov    -0x8b8(%rbp),%r8d
   ff4e8:	48 8b 3d 99 80 5b 00 	mov    0x5b8099(%rip),%rdi        # 6b7588 <void synreal::kernel::build_affine_body_preconditioner<synreal::NonZeroEntry>(glm::vec<4, int, (glm::qualifier)0> const*, float const*, float const*, int const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, int const*, synreal::NonZeroEntry const*, unsigned long, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, synreal::kernel::CableView, unsigned long const*, int const*, float, int const*, float const*, float*, int*, unsigned long, unsigned long, unsigned long)@@Base+0x5a7b58>
   ff4ef:	89 95 6c f7 ff ff    	mov    %edx,-0x894(%rbp)
   ff4f5:	48 89 8d 58 f7 ff ff 	mov    %rcx,-0x8a8(%rbp)
   ff4fc:	44 89 85 60 f7 ff ff 	mov    %r8d,-0x8a0(%rbp)
   ff503:	e8 e8 bf f6 ff       	call   6b4f0 <cudaLaunchKernel@plt>
   ff508:	e9 5d e8 ff ff       	jmp    fdd6a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2d0a>
   ff50d:	0f 1f 00             	nopl   (%rax)
   ff510:	e8 4b d8 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   ff515:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   ff51c:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   ff522:	4d 89 e1             	mov    %r12,%r9
   ff525:	45 31 c0             	xor    %r8d,%r8d
   ff528:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   ff52e:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   ff535:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   ff53c:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   ff542:	e8 69 fa f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   ff547:	85 c0                	test   %eax,%eax
   ff549:	0f 84 71 13 00 00    	je     1008c0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5860>
   ff54f:	e8 3c d3 f6 ff       	call   6c890 <cudaGetLastError@plt>
   ff554:	89 c7                	mov    %eax,%edi
   ff556:	48 8d 35 93 5c 0f 00 	lea    0xf5c93(%rip),%rsi        # 1f51f0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x52f0>
   ff55d:	e8 9e e7 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ff562:	e9 40 d0 ff ff       	jmp    fc5a7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1547>
   ff567:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   ff56e:	00 00 
   ff570:	48 8b 05 19 8a 0f 00 	mov    0xf8a19(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   ff577:	41 8b 7e 10          	mov    0x10(%r14),%edi
   ff57b:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   ff582:	00 00 00 
   ff585:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   ff58c:	e8 cf d7 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   ff591:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   ff598:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   ff59e:	4d 89 e1             	mov    %r12,%r9
   ff5a1:	45 31 c0             	xor    %r8d,%r8d
   ff5a4:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   ff5aa:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   ff5b1:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   ff5b8:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   ff5be:	e8 ed f9 f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   ff5c3:	85 c0                	test   %eax,%eax
   ff5c5:	0f 85 d1 00 00 00    	jne    ff69c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x463c>
   ff5cb:	48 83 ec 08          	sub    $0x8,%rsp
   ff5cf:	48 8b bb 60 2f 00 00 	mov    0x2f60(%rbx),%rdi
   ff5d6:	ff b5 40 fd ff ff    	push   -0x2c0(%rbp)
   ff5dc:	ff b5 38 fd ff ff    	push   -0x2c8(%rbp)
   ff5e2:	ff b5 30 fd ff ff    	push   -0x2d0(%rbp)
   ff5e8:	ff b5 28 fd ff ff    	push   -0x2d8(%rbp)
   ff5ee:	ff b5 20 fd ff ff    	push   -0x2e0(%rbp)
   ff5f4:	ff b5 18 fd ff ff    	push   -0x2e8(%rbp)
   ff5fa:	ff b5 10 fd ff ff    	push   -0x2f0(%rbp)
   ff600:	ff b5 08 fd ff ff    	push   -0x2f8(%rbp)
   ff606:	ff b5 00 fd ff ff    	push   -0x300(%rbp)
   ff60c:	ff b5 f8 fc ff ff    	push   -0x308(%rbp)
   ff612:	ff b5 f0 fc ff ff    	push   -0x310(%rbp)
   ff618:	ff b5 e8 fc ff ff    	push   -0x318(%rbp)
   ff61e:	ff b5 e0 fc ff ff    	push   -0x320(%rbp)
   ff624:	ff b5 d8 fc ff ff    	push   -0x328(%rbp)
   ff62a:	ff b5 d0 fc ff ff    	push   -0x330(%rbp)
   ff630:	ff b5 c8 fc ff ff    	push   -0x338(%rbp)
   ff636:	ff b5 c0 fc ff ff    	push   -0x340(%rbp)
   ff63c:	ff b5 b8 fc ff ff    	push   -0x348(%rbp)
   ff642:	ff b5 b0 fc ff ff    	push   -0x350(%rbp)
   ff648:	ff b5 a8 fc ff ff    	push   -0x358(%rbp)
   ff64e:	ff b5 a0 fc ff ff    	push   -0x360(%rbp)
   ff654:	ff b5 98 fc ff ff    	push   -0x368(%rbp)
   ff65a:	ff b5 90 fc ff ff    	push   -0x370(%rbp)
   ff660:	ff b5 88 fc ff ff    	push   -0x378(%rbp)
   ff666:	ff b5 80 fc ff ff    	push   -0x380(%rbp)
   ff66c:	ff b5 78 fc ff ff    	push   -0x388(%rbp)
   ff672:	ff b5 70 fc ff ff    	push   -0x390(%rbp)
   ff678:	ff b5 68 fc ff ff    	push   -0x398(%rbp)
   ff67e:	ff b5 60 fc ff ff    	push   -0x3a0(%rbp)
   ff684:	ff b5 58 fc ff ff    	push   -0x3a8(%rbp)
   ff68a:	ff b5 50 fc ff ff    	push   -0x3b0(%rbp)
   ff690:	e8 2b b1 f6 ff       	call   6a7c0 <synreal::kernel::add_rolling_contact_preconditioner(synreal::kernel::RollingContactView, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
   ff695:	48 81 c4 00 01 00 00 	add    $0x100,%rsp
   ff69c:	e8 ef d1 f6 ff       	call   6c890 <cudaGetLastError@plt>
   ff6a1:	89 c7                	mov    %eax,%edi
   ff6a3:	48 8d 35 36 63 0f 00 	lea    0xf6336(%rip),%rsi        # 1f59e0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5ae0>
   ff6aa:	e8 51 e6 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ff6af:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   ff6b6:	e9 c0 e1 ff ff       	jmp    fd87b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x281b>
   ff6bb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   ff6c0:	48 8b b3 60 2f 00 00 	mov    0x2f60(%rbx),%rsi
   ff6c7:	48 8b 95 10 f5 ff ff 	mov    -0xaf0(%rbp),%rdx
   ff6ce:	48 8d bb 70 20 00 00 	lea    0x2070(%rbx),%rdi
   ff6d5:	e8 86 bd f6 ff       	call   6b460 <synreal::Granular::add_preconditioner(glm::mat<3, 3, float, (glm::qualifier)0>*, CUstream_st*) const@plt>
   ff6da:	80 bd 2b f5 ff ff 00 	cmpb   $0x0,-0xad5(%rbp)
   ff6e1:	0f 84 46 df ff ff    	je     fd62d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x25cd>
   ff6e7:	48 8b 05 a2 88 0f 00 	mov    0xf88a2(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   ff6ee:	45 31 c0             	xor    %r8d,%r8d
   ff6f1:	b9 01 00 00 00       	mov    $0x1,%ecx
   ff6f6:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   ff6fd:	48 8b 15 8c 88 0f 00 	mov    0xf888c(%rip),%rdx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   ff704:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   ff70a:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   ff711:	00 00 00 
   ff714:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   ff71b:	8b 85 40 f5 ff ff    	mov    -0xac0(%rbp),%eax
   ff721:	4c 8b 8d 10 f5 ff ff 	mov    -0xaf0(%rbp),%r9
   ff728:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   ff72e:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   ff735:	e8 76 f8 f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   ff73a:	85 c0                	test   %eax,%eax
   ff73c:	75 2f                	jne    ff76d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x470d>
   ff73e:	48 81 ec 30 01 00 00 	sub    $0x130,%rsp
   ff745:	4c 8b 83 60 2f 00 00 	mov    0x2f60(%rbx),%r8
   ff74c:	b9 25 00 00 00       	mov    $0x25,%ecx
   ff751:	48 8b b5 48 f4 ff ff 	mov    -0xbb8(%rbp),%rsi
   ff758:	48 89 e7             	mov    %rsp,%rdi
   ff75b:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
   ff75e:	4c 89 c7             	mov    %r8,%rdi
   ff761:	e8 1a b6 f6 ff       	call   6ad80 <synreal::kernel::add_surface_contact_preconditioner(synreal::kernel::SurfaceContactView, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
   ff766:	48 81 c4 30 01 00 00 	add    $0x130,%rsp
   ff76d:	e8 1e d1 f6 ff       	call   6c890 <cudaGetLastError@plt>
   ff772:	89 c7                	mov    %eax,%edi
   ff774:	48 8d 35 ad 61 0f 00 	lea    0xf61ad(%rip),%rsi        # 1f5928 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5a28>
   ff77b:	e8 80 e5 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ff780:	80 bd 26 f5 ff ff 00 	cmpb   $0x0,-0xada(%rbp)
   ff787:	0f 84 ad de ff ff    	je     fd63a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x25da>
   ff78d:	48 8b 05 fc 87 0f 00 	mov    0xf87fc(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   ff794:	48 8b bd 78 f5 ff ff 	mov    -0xa88(%rbp),%rdi
   ff79b:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   ff7a2:	00 00 00 
   ff7a5:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   ff7ac:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   ff7b3:	e8 a8 d5 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   ff7b8:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   ff7bf:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   ff7c5:	4d 89 e1             	mov    %r12,%r9
   ff7c8:	45 31 c0             	xor    %r8d,%r8d
   ff7cb:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   ff7d1:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   ff7d8:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   ff7df:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   ff7e5:	e8 c6 f7 f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   ff7ea:	85 c0                	test   %eax,%eax
   ff7ec:	75 3b                	jne    ff829 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x47c9>
   ff7ee:	48 8b 8b 60 2f 00 00 	mov    0x2f60(%rbx),%rcx
   ff7f5:	48 8b 93 28 33 00 00 	mov    0x3328(%rbx),%rdx
   ff7fc:	48 83 ec 08          	sub    $0x8,%rsp
   ff800:	48 8b b3 e8 32 00 00 	mov    0x32e8(%rbx),%rsi
   ff807:	48 8b bb a8 32 00 00 	mov    0x32a8(%rbx),%rdi
   ff80e:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
   ff814:	4c 8b 8d 70 f5 ff ff 	mov    -0xa90(%rbp),%r9
   ff81b:	4c 8b 85 78 f5 ff ff 	mov    -0xa88(%rbp),%r8
   ff822:	e8 a9 b3 f6 ff       	call   6abd0 <synreal::kernel::add_triangle_drag_preconditioner(glm::vec<3, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   ff827:	59                   	pop    %rcx
   ff828:	5e                   	pop    %rsi
   ff829:	e8 62 d0 f6 ff       	call   6c890 <cudaGetLastError@plt>
   ff82e:	89 c7                	mov    %eax,%edi
   ff830:	48 8d 35 21 61 0f 00 	lea    0xf6121(%rip),%rsi        # 1f5958 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5a58>
   ff837:	e8 c4 e4 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ff83c:	80 bd 32 f5 ff ff 00 	cmpb   $0x0,-0xace(%rbp)
   ff843:	0f 84 fe dd ff ff    	je     fd647 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x25e7>
   ff849:	48 8b 05 40 87 0f 00 	mov    0xf8740(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   ff850:	48 8b bd 98 f5 ff ff 	mov    -0xa68(%rbp),%rdi
   ff857:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   ff85e:	00 00 00 
   ff861:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   ff868:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   ff86f:	e8 ec d4 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   ff874:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   ff87b:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   ff881:	4d 89 e1             	mov    %r12,%r9
   ff884:	45 31 c0             	xor    %r8d,%r8d
   ff887:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   ff88d:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   ff894:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   ff89b:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   ff8a1:	e8 0a f7 f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   ff8a6:	85 c0                	test   %eax,%eax
   ff8a8:	75 6b                	jne    ff915 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x48b5>
   ff8aa:	8b 83 6c 05 00 00    	mov    0x56c(%rbx),%eax
   ff8b0:	48 83 ec 08          	sub    $0x8,%rsp
   ff8b4:	48 8b 8b d0 34 00 00 	mov    0x34d0(%rbx),%rcx
   ff8bb:	48 8b 93 b0 34 00 00 	mov    0x34b0(%rbx),%rdx
   ff8c2:	48 8b b3 70 05 00 00 	mov    0x570(%rbx),%rsi
   ff8c9:	48 8b bb d0 03 00 00 	mov    0x3d0(%rbx),%rdi
   ff8d0:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
   ff8d6:	f3 0f 10 85 3c f5 ff 	movss  -0xac4(%rbp),%xmm0
   ff8dd:	ff 
   ff8de:	50                   	push   %rax
   ff8df:	8b 83 68 05 00 00    	mov    0x568(%rbx),%eax
   ff8e5:	4c 8b 83 f0 34 00 00 	mov    0x34f0(%rbx),%r8
   ff8ec:	50                   	push   %rax
   ff8ed:	ff b5 98 f5 ff ff    	push   -0xa68(%rbp)
   ff8f3:	ff b3 60 2f 00 00    	push   0x2f60(%rbx)
   ff8f9:	ff b3 30 35 00 00    	push   0x3530(%rbx)
   ff8ff:	ff b3 10 35 00 00    	push   0x3510(%rbx)
   ff905:	4c 8b 8b b0 05 00 00 	mov    0x5b0(%rbx),%r9
   ff90c:	e8 2f b0 f6 ff       	call   6a940 <synreal::kernel::add_joint_body_point_line_augmented_lagrangian_preconditioner(glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
   ff911:	48 83 c4 40          	add    $0x40,%rsp
   ff915:	e8 76 cf f6 ff       	call   6c890 <cudaGetLastError@plt>
   ff91a:	89 c7                	mov    %eax,%edi
   ff91c:	48 8d 35 5d 60 0f 00 	lea    0xf605d(%rip),%rsi        # 1f5980 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5a80>
   ff923:	e8 d8 e3 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ff928:	80 bd 33 f5 ff ff 00 	cmpb   $0x0,-0xacd(%rbp)
   ff92f:	0f 84 1f dd ff ff    	je     fd654 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x25f4>
   ff935:	44 8b a3 d4 05 00 00 	mov    0x5d4(%rbx),%r12d
   ff93c:	4c 0f af a5 80 f5 ff 	imul   -0xa80(%rbp),%r12
   ff943:	ff 
   ff944:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   ff94b:	00 00 00 
   ff94e:	48 8b 05 3b 86 0f 00 	mov    0xf863b(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   ff955:	4c 8b ad 10 f5 ff ff 	mov    -0xaf0(%rbp),%r13
   ff95c:	4c 89 e7             	mov    %r12,%rdi
   ff95f:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   ff966:	e8 f5 d3 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   ff96b:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   ff972:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   ff978:	4d 89 e9             	mov    %r13,%r9
   ff97b:	45 31 c0             	xor    %r8d,%r8d
   ff97e:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   ff984:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   ff98b:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   ff992:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   ff998:	e8 13 f6 f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   ff99d:	85 c0                	test   %eax,%eax
   ff99f:	0f 85 97 00 00 00    	jne    ffa3c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x49dc>
   ff9a5:	8b 83 d4 05 00 00    	mov    0x5d4(%rbx),%eax
   ff9ab:	48 8b 8b f0 05 00 00 	mov    0x5f0(%rbx),%rcx
   ff9b2:	48 8b 93 e0 05 00 00 	mov    0x5e0(%rbx),%rdx
   ff9b9:	48 8b b3 d0 03 00 00 	mov    0x3d0(%rbx),%rsi
   ff9c0:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
   ff9c6:	f3 0f 10 05 b2 85 0f 	movss  0xf85b2(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
   ff9cd:	00 
   ff9ce:	50                   	push   %rax
   ff9cf:	f3 0f 5e 85 1c f5 ff 	divss  -0xae4(%rbp),%xmm0
   ff9d6:	ff 
   ff9d7:	41 54                	push   %r12
   ff9d9:	ff b3 60 2f 00 00    	push   0x2f60(%rbx)
   ff9df:	ff b3 80 06 00 00    	push   0x680(%rbx)
   ff9e5:	ff b3 a0 06 00 00    	push   0x6a0(%rbx)
   ff9eb:	ff b3 90 06 00 00    	push   0x690(%rbx)
   ff9f1:	ff b3 50 06 00 00    	push   0x650(%rbx)
   ff9f7:	ff b3 f0 35 00 00    	push   0x35f0(%rbx)
   ff9fd:	ff b3 d0 35 00 00    	push   0x35d0(%rbx)
   ffa03:	ff b3 b0 35 00 00    	push   0x35b0(%rbx)
   ffa09:	ff b3 90 35 00 00    	push   0x3590(%rbx)
   ffa0f:	ff b3 70 35 00 00    	push   0x3570(%rbx)
   ffa15:	ff b3 30 06 00 00    	push   0x630(%rbx)
   ffa1b:	4c 8b 8b 20 06 00 00 	mov    0x620(%rbx),%r9
   ffa22:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   ffa29:	4c 8b 83 00 06 00 00 	mov    0x600(%rbx),%r8
   ffa30:	48 8b 38             	mov    (%rax),%rdi
   ffa33:	e8 68 b2 f6 ff       	call   6aca0 <synreal::kernel::add_joint_drive_preconditioner(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, int const*, int const*, float const*, float const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   ffa38:	48 83 c4 70          	add    $0x70,%rsp
   ffa3c:	e8 4f ce f6 ff       	call   6c890 <cudaGetLastError@plt>
   ffa41:	89 c7                	mov    %eax,%edi
   ffa43:	48 8d 35 6e 5f 0f 00 	lea    0xf5f6e(%rip),%rsi        # 1f59b8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5ab8>
   ffa4a:	e8 b1 e2 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ffa4f:	e9 00 dc ff ff       	jmp    fd654 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x25f4>
   ffa54:	0f 1f 40 00          	nopl   0x0(%rax)
   ffa58:	48 8b b3 60 2f 00 00 	mov    0x2f60(%rbx),%rsi
   ffa5f:	48 8b 95 10 f5 ff ff 	mov    -0xaf0(%rbp),%rdx
   ffa66:	48 8d bb 28 17 00 00 	lea    0x1728(%rbx),%rdi
   ffa6d:	e8 fe e0 f6 ff       	call   6db70 <synreal::Fluid::add_preconditioner(glm::mat<3, 3, float, (glm::qualifier)0>*, CUstream_st*) const@plt>
   ffa72:	e9 9b db ff ff       	jmp    fd612 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x25b2>
   ffa77:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   ffa7e:	00 00 
   ffa80:	48 8b b3 60 2f 00 00 	mov    0x2f60(%rbx),%rsi
   ffa87:	48 8b 95 10 f5 ff ff 	mov    -0xaf0(%rbp),%rdx
   ffa8e:	48 8d bb f0 08 00 00 	lea    0x8f0(%rbx),%rdi
   ffa95:	e8 e6 d4 f6 ff       	call   6cf80 <synreal::SelfCollision::add_preconditioner(glm::mat<3, 3, float, (glm::qualifier)0>*, CUstream_st*) const@plt>
   ffa9a:	e9 63 db ff ff       	jmp    fd602 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x25a2>
   ffa9f:	90                   	nop
   ffaa0:	48 8b 05 e9 84 0f 00 	mov    0xf84e9(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   ffaa7:	48 8b bd a0 f5 ff ff 	mov    -0xa60(%rbp),%rdi
   ffaae:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   ffab5:	00 00 00 
   ffab8:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   ffabf:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   ffac6:	e8 95 d2 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   ffacb:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   ffad2:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   ffad8:	4d 89 e1             	mov    %r12,%r9
   ffadb:	45 31 c0             	xor    %r8d,%r8d
   ffade:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   ffae4:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   ffaeb:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   ffaf2:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   ffaf8:	e8 b3 f4 f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   ffafd:	85 c0                	test   %eax,%eax
   ffaff:	75 5d                	jne    ffb5e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4afe>
   ffb01:	8b 83 18 03 00 00    	mov    0x318(%rbx),%eax
   ffb07:	48 83 ec 08          	sub    $0x8,%rsp
   ffb0b:	48 8b 8b 20 03 00 00 	mov    0x320(%rbx),%rcx
   ffb12:	48 8b 93 50 03 00 00 	mov    0x350(%rbx),%rdx
   ffb19:	48 8b b3 40 03 00 00 	mov    0x340(%rbx),%rsi
   ffb20:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
   ffb26:	4c 8b 8b 60 2f 00 00 	mov    0x2f60(%rbx),%r9
   ffb2d:	50                   	push   %rax
   ffb2e:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   ffb35:	ff b5 a0 f5 ff ff    	push   -0xa60(%rbp)
   ffb3b:	4c 8b 83 30 03 00 00 	mov    0x330(%rbx),%r8
   ffb42:	48 8b 38             	mov    (%rax),%rdi
   ffb45:	f3 0f 10 05 33 84 0f 	movss  0xf8433(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
   ffb4c:	00 
   ffb4d:	f3 0f 5e 85 1c f5 ff 	divss  -0xae4(%rbp),%xmm0
   ffb54:	ff 
   ffb55:	e8 56 ac f6 ff       	call   6a7b0 <synreal::kernel::add_bending_damping_preconditioner(glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, float, (glm::qualifier)0> const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   ffb5a:	48 83 c4 20          	add    $0x20,%rsp
   ffb5e:	e8 2d cd f6 ff       	call   6c890 <cudaGetLastError@plt>
   ffb63:	89 c7                	mov    %eax,%edi
   ffb65:	48 8d 35 84 5d 0f 00 	lea    0xf5d84(%rip),%rsi        # 1f58f0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x59f0>
   ffb6c:	e8 8f e1 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ffb71:	e9 7f da ff ff       	jmp    fd5f5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2595>
   ffb76:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   ffb7d:	00 00 00 
   ffb80:	48 8b 05 09 84 0f 00 	mov    0xf8409(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   ffb87:	48 8b bd 68 f5 ff ff 	mov    -0xa98(%rbp),%rdi
   ffb8e:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   ffb95:	00 00 00 
   ffb98:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   ffb9f:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   ffba6:	e8 b5 d1 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   ffbab:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   ffbb2:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   ffbb8:	4d 89 e1             	mov    %r12,%r9
   ffbbb:	45 31 c0             	xor    %r8d,%r8d
   ffbbe:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   ffbc4:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   ffbcb:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   ffbd2:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   ffbd8:	e8 d3 f3 f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   ffbdd:	85 c0                	test   %eax,%eax
   ffbdf:	75 5d                	jne    ffc3e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4bde>
   ffbe1:	8b 83 e0 02 00 00    	mov    0x2e0(%rbx),%eax
   ffbe7:	48 83 ec 08          	sub    $0x8,%rsp
   ffbeb:	48 8b 8b 08 03 00 00 	mov    0x308(%rbx),%rcx
   ffbf2:	48 8b 93 f8 02 00 00 	mov    0x2f8(%rbx),%rdx
   ffbf9:	48 8b b3 e8 02 00 00 	mov    0x2e8(%rbx),%rsi
   ffc00:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
   ffc06:	4c 8b 8b 60 2f 00 00 	mov    0x2f60(%rbx),%r9
   ffc0d:	50                   	push   %rax
   ffc0e:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   ffc15:	ff b5 68 f5 ff ff    	push   -0xa98(%rbp)
   ffc1b:	4c 8b 83 90 33 00 00 	mov    0x3390(%rbx),%r8
   ffc22:	48 8b 38             	mov    (%rax),%rdi
   ffc25:	f3 0f 10 05 53 83 0f 	movss  0xf8353(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
   ffc2c:	00 
   ffc2d:	f3 0f 5e 85 1c f5 ff 	divss  -0xae4(%rbp),%xmm0
   ffc34:	ff 
   ffc35:	e8 06 ae f6 ff       	call   6aa40 <synreal::kernel::add_tetrahedron_preconditioner(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   ffc3a:	48 83 c4 20          	add    $0x20,%rsp
   ffc3e:	e8 4d cc f6 ff       	call   6c890 <cudaGetLastError@plt>
   ffc43:	89 c7                	mov    %eax,%edi
   ffc45:	48 8d 35 6c 5c 0f 00 	lea    0xf5c6c(%rip),%rsi        # 1f58b8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x59b8>
   ffc4c:	e8 af e0 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ffc51:	e9 92 d9 ff ff       	jmp    fd5e8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2588>
   ffc56:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   ffc5d:	00 00 00 
   ffc60:	48 8b 05 29 83 0f 00 	mov    0xf8329(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   ffc67:	48 8b bd 88 f5 ff ff 	mov    -0xa78(%rbp),%rdi
   ffc6e:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   ffc75:	00 00 00 
   ffc78:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   ffc7f:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   ffc86:	e8 d5 d0 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   ffc8b:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   ffc92:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   ffc98:	4d 89 e1             	mov    %r12,%r9
   ffc9b:	45 31 c0             	xor    %r8d,%r8d
   ffc9e:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   ffca4:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   ffcab:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   ffcb2:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   ffcb8:	e8 f3 f2 f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   ffcbd:	85 c0                	test   %eax,%eax
   ffcbf:	75 4f                	jne    ffd10 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4cb0>
   ffcc1:	8b 83 98 03 00 00    	mov    0x398(%rbx),%eax
   ffcc7:	f3 0f 10 43 0c       	movss  0xc(%rbx),%xmm0
   ffccc:	f3 0f 59 85 34 f5 ff 	mulss  -0xacc(%rbp),%xmm0
   ffcd3:	ff 
   ffcd4:	48 8b 93 a0 03 00 00 	mov    0x3a0(%rbx),%rdx
   ffcdb:	48 8b b3 d0 03 00 00 	mov    0x3d0(%rbx),%rsi
   ffce2:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
   ffce8:	4c 8b 8d 88 f5 ff ff 	mov    -0xa78(%rbp),%r9
   ffcef:	50                   	push   %rax
   ffcf0:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   ffcf7:	4c 8b 83 60 2f 00 00 	mov    0x2f60(%rbx),%r8
   ffcfe:	8b 8d 44 f5 ff ff    	mov    -0xabc(%rbp),%ecx
   ffd04:	48 8b 38             	mov    (%rax),%rdi
   ffd07:	e8 f4 ac f6 ff       	call   6aa00 <synreal::kernel::add_affine_body_constitutive_preconditioner(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, float, synreal::AffineBodyRigidityModel, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   ffd0c:	41 5b                	pop    %r11
   ffd0e:	41 5c                	pop    %r12
   ffd10:	e8 7b cb f6 ff       	call   6c890 <cudaGetLastError@plt>
   ffd15:	89 c7                	mov    %eax,%edi
   ffd17:	48 8d 35 2a 5b 0f 00 	lea    0xf5b2a(%rip),%rsi        # 1f5848 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5948>
   ffd1e:	e8 dd df f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ffd23:	e9 9d d8 ff ff       	jmp    fd5c5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2565>
   ffd28:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   ffd2f:	00 
   ffd30:	48 8b 05 59 82 0f 00 	mov    0xf8259(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   ffd37:	48 8b bd 88 f5 ff ff 	mov    -0xa78(%rbp),%rdi
   ffd3e:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   ffd45:	00 00 00 
   ffd48:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   ffd4f:	e8 0c d0 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   ffd54:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   ffd5b:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
   ffd61:	4d 89 e1             	mov    %r12,%r9
   ffd64:	45 31 c0             	xor    %r8d,%r8d
   ffd67:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   ffd6d:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
   ffd74:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   ffd7b:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   ffd81:	e8 2a f2 f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   ffd86:	85 c0                	test   %eax,%eax
   ffd88:	75 4e                	jne    ffdd8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4d78>
   ffd8a:	8b 83 98 03 00 00    	mov    0x398(%rbx),%eax
   ffd90:	f3 0f 10 43 0c       	movss  0xc(%rbx),%xmm0
   ffd95:	f3 0f 59 85 34 f5 ff 	mulss  -0xacc(%rbp),%xmm0
   ffd9c:	ff 
   ffd9d:	48 8b 93 a0 03 00 00 	mov    0x3a0(%rbx),%rdx
   ffda4:	48 8b b3 d0 03 00 00 	mov    0x3d0(%rbx),%rsi
   ffdab:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
   ffdb1:	4c 8b 8d 88 f5 ff ff 	mov    -0xa78(%rbp),%r9
   ffdb8:	50                   	push   %rax
   ffdb9:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   ffdc0:	4c 8b 83 40 30 00 00 	mov    0x3040(%rbx),%r8
   ffdc7:	8b 8d 44 f5 ff ff    	mov    -0xabc(%rbp),%ecx
   ffdcd:	48 8b 38             	mov    (%rax),%rdi
   ffdd0:	e8 db ab f6 ff       	call   6a9b0 <synreal::kernel::evaluate_affine_body_constitutive_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, float, synreal::AffineBodyRigidityModel, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   ffdd5:	5f                   	pop    %rdi
   ffdd6:	41 58                	pop    %r8
   ffdd8:	e8 b3 ca f6 ff       	call   6c890 <cudaGetLastError@plt>
   ffddd:	89 c7                	mov    %eax,%edi
   ffddf:	48 8d 35 52 57 0f 00 	lea    0xf5752(%rip),%rsi        # 1f5538 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5638>
   ffde6:	e8 15 df f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ffdeb:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   ffdf2:	e9 07 d1 ff ff       	jmp    fcefe <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1e9e>
   ffdf7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   ffdfe:	00 00 
   ffe00:	48 8b b3 c0 2d 00 00 	mov    0x2dc0(%rbx),%rsi
   ffe07:	4d 89 e0             	mov    %r12,%r8
   ffe0a:	b9 03 00 00 00       	mov    $0x3,%ecx
   ffe0f:	48 89 c7             	mov    %rax,%rdi
   ffe12:	48 8b 95 28 f4 ff ff 	mov    -0xbd8(%rbp),%rdx
   ffe19:	e8 92 e2 f6 ff       	call   6e0b0 <cudaMemcpyAsync@plt>
   ffe1e:	89 c7                	mov    %eax,%edi
   ffe20:	48 8d 35 19 58 0f 00 	lea    0xf5819(%rip),%rsi        # 1f5640 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5740>
   ffe27:	e8 d4 de f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ffe2c:	48 8b 83 e0 2d 00 00 	mov    0x2de0(%rbx),%rax
   ffe33:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   ffe3a:	48 89 85 90 f4 ff ff 	mov    %rax,-0xb70(%rbp)
   ffe41:	e9 c5 d1 ff ff       	jmp    fd00b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1fab>
   ffe46:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   ffe4d:	00 00 00 
   ffe50:	48 8b 05 39 81 0f 00 	mov    0xf8139(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   ffe57:	45 31 c0             	xor    %r8d,%r8d
   ffe5a:	b9 01 00 00 00       	mov    $0x1,%ecx
   ffe5f:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
   ffe66:	48 8b 15 23 81 0f 00 	mov    0xf8123(%rip),%rdx        # 1f7f90 <cuda::std::__4::in_place+0x43>
   ffe6d:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
   ffe73:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
   ffe7a:	00 00 00 
   ffe7d:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
   ffe84:	8b 85 40 f5 ff ff    	mov    -0xac0(%rbp),%eax
   ffe8a:	4c 8b 8d 10 f5 ff ff 	mov    -0xaf0(%rbp),%r9
   ffe91:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
   ffe97:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
   ffe9e:	e8 0d f1 f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   ffea3:	85 c0                	test   %eax,%eax
   ffea5:	75 2f                	jne    ffed6 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4e76>
   ffea7:	48 81 ec 30 01 00 00 	sub    $0x130,%rsp
   ffeae:	4c 8b 83 00 2f 00 00 	mov    0x2f00(%rbx),%r8
   ffeb5:	b9 25 00 00 00       	mov    $0x25,%ecx
   ffeba:	48 8b b5 48 f4 ff ff 	mov    -0xbb8(%rbp),%rsi
   ffec1:	48 89 e7             	mov    %rsp,%rdi
   ffec4:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
   ffec7:	4c 89 c7             	mov    %r8,%rdi
   ffeca:	e8 11 ad f6 ff       	call   6abe0 <synreal::kernel::add_surface_contact_stiffness_scale(synreal::kernel::SurfaceContactView, float*)@plt>
   ffecf:	48 81 c4 30 01 00 00 	add    $0x130,%rsp
   ffed6:	e8 b5 c9 f6 ff       	call   6c890 <cudaGetLastError@plt>
   ffedb:	89 c7                	mov    %eax,%edi
   ffedd:	48 8d 35 1c 54 0f 00 	lea    0xf541c(%rip),%rsi        # 1f5300 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5400>
   ffee4:	e8 17 de f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   ffee9:	e9 d0 ca ff ff       	jmp    fc9be <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x195e>
   ffeee:	66 90                	xchg   %ax,%ax
   ffef0:	8b 83 68 05 00 00    	mov    0x568(%rbx),%eax
   ffef6:	48 8b bd 08 f5 ff ff 	mov    -0xaf8(%rbp),%rdi
   ffefd:	48 83 ec 08          	sub    $0x8,%rsp
   fff01:	48 8b 8b 70 05 00 00 	mov    0x570(%rbx),%rcx
   fff08:	48 8b 93 d0 03 00 00 	mov    0x3d0(%rbx),%rdx
   fff0f:	48 8b 77 10          	mov    0x10(%rdi),%rsi
   fff13:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
   fff19:	f3 0f 10 85 3c f5 ff 	movss  -0xac4(%rbp),%xmm0
   fff20:	ff 
   fff21:	50                   	push   %rax
   fff22:	31 c0                	xor    %eax,%eax
   fff24:	83 bd e4 f4 ff ff 01 	cmpl   $0x1,-0xb1c(%rbp)
   fff2b:	41 55                	push   %r13
   fff2d:	0f 95 c0             	setne  %al
   fff30:	41 54                	push   %r12
   fff32:	50                   	push   %rax
   fff33:	8b 83 6c 05 00 00    	mov    0x56c(%rbx),%eax
   fff39:	50                   	push   %rax
   fff3a:	ff b3 c0 05 00 00    	push   0x5c0(%rbx)
   fff40:	ff b3 b0 05 00 00    	push   0x5b0(%rbx)
   fff46:	ff b3 a0 05 00 00    	push   0x5a0(%rbx)
   fff4c:	ff b3 90 05 00 00    	push   0x590(%rbx)
   fff52:	48 8b 3f             	mov    (%rdi),%rdi
   fff55:	ff b3 f0 34 00 00    	push   0x34f0(%rbx)
   fff5b:	4c 8b 8b d0 34 00 00 	mov    0x34d0(%rbx),%r9
   fff62:	4c 8b 83 b0 34 00 00 	mov    0x34b0(%rbx),%r8
   fff69:	e8 02 b0 f6 ff       	call   6af70 <synreal::kernel::evaluate_body_point_line_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float, unsigned long, bool, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   fff6e:	48 83 c4 60          	add    $0x60,%rsp
   fff72:	e9 44 cc ff ff       	jmp    fcbbb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1b5b>
   fff77:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   fff7e:	00 00 
   fff80:	8b 83 98 04 00 00    	mov    0x498(%rbx),%eax
   fff86:	48 83 ec 08          	sub    $0x8,%rsp
   fff8a:	48 8b 8b b0 04 00 00 	mov    0x4b0(%rbx),%rcx
   fff91:	48 8b 93 a0 04 00 00 	mov    0x4a0(%rbx),%rdx
   fff98:	48 8b b3 d0 03 00 00 	mov    0x3d0(%rbx),%rsi
   fff9f:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
   fffa5:	f3 0f 10 85 3c f5 ff 	movss  -0xac4(%rbp),%xmm0
   fffac:	ff 
   fffad:	50                   	push   %rax
   fffae:	31 c0                	xor    %eax,%eax
   fffb0:	83 bd e4 f4 ff ff 01 	cmpl   $0x1,-0xb1c(%rbp)
   fffb7:	41 55                	push   %r13
   fffb9:	0f 95 c0             	setne  %al
   fffbc:	41 54                	push   %r12
   fffbe:	4c 8b 83 c0 04 00 00 	mov    0x4c0(%rbx),%r8
   fffc5:	50                   	push   %rax
   fffc6:	8b 83 9c 04 00 00    	mov    0x49c(%rbx),%eax
   fffcc:	50                   	push   %rax
   fffcd:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   fffd4:	ff b3 e0 04 00 00    	push   0x4e0(%rbx)
   fffda:	48 8b 38             	mov    (%rax),%rdi
   fffdd:	ff b3 d0 04 00 00    	push   0x4d0(%rbx)
   fffe3:	ff b3 f0 33 00 00    	push   0x33f0(%rbx)
   fffe9:	4c 8b 8b d0 33 00 00 	mov    0x33d0(%rbx),%r9
   ffff0:	e8 7b ad f6 ff       	call   6ad70 <synreal::kernel::evaluate_body_spring_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, float const*, float, unsigned long, bool, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
   ffff5:	48 83 c4 50          	add    $0x50,%rsp
   ffff9:	e9 50 ca ff ff       	jmp    fca4e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x19ee>
   ffffe:	66 90                	xchg   %ax,%ax
  100000:	8b 83 dc 05 00 00    	mov    0x5dc(%rbx),%eax
  100006:	48 8b 8b 40 32 00 00 	mov    0x3240(%rbx),%rcx
  10000d:	48 8b 93 80 32 00 00 	mov    0x3280(%rbx),%rdx
  100014:	48 8b b3 60 30 00 00 	mov    0x3060(%rbx),%rsi
  10001b:	50                   	push   %rax
  10001c:	8b 83 d8 05 00 00    	mov    0x5d8(%rbx),%eax
  100022:	f3 0f 10 05 56 7f 0f 	movss  0xf7f56(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  100029:	00 
  10002a:	f3 0f 5e 85 1c f5 ff 	divss  -0xae4(%rbp),%xmm0
  100031:	ff 
  100032:	50                   	push   %rax
  100033:	8b 83 d4 05 00 00    	mov    0x5d4(%rbx),%eax
  100039:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
  10003f:	50                   	push   %rax
  100040:	48 8b 85 78 f4 ff ff 	mov    -0xb88(%rbp),%rax
  100047:	41 55                	push   %r13
  100049:	41 54                	push   %r12
  10004b:	ff 70 20             	push   0x20(%rax)
  10004e:	ff 70 10             	push   0x10(%rax)
  100051:	ff 30                	push   (%rax)
  100053:	ff b3 a0 06 00 00    	push   0x6a0(%rbx)
  100059:	ff b3 90 06 00 00    	push   0x690(%rbx)
  10005f:	ff b3 c0 06 00 00    	push   0x6c0(%rbx)
  100065:	ff b3 80 06 00 00    	push   0x680(%rbx)
  10006b:	ff b3 70 06 00 00    	push   0x670(%rbx)
  100071:	ff b3 60 06 00 00    	push   0x660(%rbx)
  100077:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
  10007e:	ff b3 50 06 00 00    	push   0x650(%rbx)
  100084:	4c 8b 8b d0 03 00 00 	mov    0x3d0(%rbx),%r9
  10008b:	ff b3 f0 35 00 00    	push   0x35f0(%rbx)
  100091:	ff b3 d0 35 00 00    	push   0x35d0(%rbx)
  100097:	ff b3 b0 35 00 00    	push   0x35b0(%rbx)
  10009d:	ff b3 90 35 00 00    	push   0x3590(%rbx)
  1000a3:	ff b3 70 35 00 00    	push   0x3570(%rbx)
  1000a9:	ff b3 30 06 00 00    	push   0x630(%rbx)
  1000af:	ff b3 20 06 00 00    	push   0x620(%rbx)
  1000b5:	ff b3 00 06 00 00    	push   0x600(%rbx)
  1000bb:	48 8b 38             	mov    (%rax),%rdi
  1000be:	ff b3 f0 05 00 00    	push   0x5f0(%rbx)
  1000c4:	ff b3 e0 05 00 00    	push   0x5e0(%rbx)
  1000ca:	4c 8b 83 60 32 00 00 	mov    0x3260(%rbx),%r8
  1000d1:	e8 6a aa f6 ff       	call   6ab40 <synreal::kernel::evaluate_joint_drive_load(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float*, int*, glm::vec<4, int, (glm::qualifier)0> const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, int const*, int const*, float const*, float const*, float const*, int const*, float const*, float const*, float const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, float)@plt>
  1000d6:	48 81 c4 d0 00 00 00 	add    $0xd0,%rsp
  1000dd:	e9 a5 cb ff ff       	jmp    fcc87 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1c27>
  1000e2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  1000e8:	48 8b 85 b0 f7 ff ff 	mov    -0x850(%rbp),%rax
  1000ef:	48 8b 95 d0 f7 ff ff 	mov    -0x830(%rbp),%rdx
  1000f6:	4d 89 e1             	mov    %r12,%r9
  1000f9:	45 31 c0             	xor    %r8d,%r8d
  1000fc:	f3 0f 10 05 7c 7e 0f 	movss  0xf7e7c(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  100103:	00 
  100104:	48 8b 88 80 32 00 00 	mov    0x3280(%rax),%rcx
  10010b:	48 8b b8 b0 06 00 00 	mov    0x6b0(%rax),%rdi
  100112:	f3 0f 5e 02          	divss  (%rdx),%xmm0
  100116:	48 8b 90 60 30 00 00 	mov    0x3060(%rax),%rdx
  10011d:	48 8b 85 b8 f7 ff ff 	mov    -0x848(%rbp),%rax
  100124:	6a 00                	push   $0x0
  100126:	ff 70 70             	push   0x70(%rax)
  100129:	ff 70 68             	push   0x68(%rax)
  10012c:	ff 70 60             	push   0x60(%rax)
  10012f:	ff 70 58             	push   0x58(%rax)
  100132:	ff 70 50             	push   0x50(%rax)
  100135:	ff 70 48             	push   0x48(%rax)
  100138:	ff 70 40             	push   0x40(%rax)
  10013b:	ff 70 38             	push   0x38(%rax)
  10013e:	ff 70 30             	push   0x30(%rax)
  100141:	ff 70 28             	push   0x28(%rax)
  100144:	ff 70 20             	push   0x20(%rax)
  100147:	ff 70 18             	push   0x18(%rax)
  10014a:	ff 70 10             	push   0x10(%rax)
  10014d:	ff 70 08             	push   0x8(%rax)
  100150:	ff 30                	push   (%rax)
  100152:	48 8b 85 c8 f7 ff ff 	mov    -0x838(%rbp),%rax
  100159:	48 8b 30             	mov    (%rax),%rsi
  10015c:	e8 7f ad f6 ff       	call   6aee0 <synreal::kernel::evaluate_joint_armature(synreal::kernel::JointCoordinateView, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  100161:	48 83 ec 80          	sub    $0xffffffffffffff80,%rsp
  100165:	e9 b7 cb ff ff       	jmp    fcd21 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1cc1>
  10016a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  100170:	48 8b 85 40 f8 ff ff 	mov    -0x7c0(%rbp),%rax
  100177:	45 31 c0             	xor    %r8d,%r8d
  10017a:	4c 89 e1             	mov    %r12,%rcx
  10017d:	31 d2                	xor    %edx,%edx
  10017f:	f3 0f 10 05 f9 7d 0f 	movss  0xf7df9(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  100186:	00 
  100187:	f3 0f 5e 00          	divss  (%rax),%xmm0
  10018b:	48 8b 85 38 f8 ff ff 	mov    -0x7c8(%rbp),%rax
  100192:	48 8b b0 60 30 00 00 	mov    0x3060(%rax),%rsi
  100199:	48 8b 85 28 f8 ff ff 	mov    -0x7d8(%rbp),%rax
  1001a0:	ff b0 98 00 00 00    	push   0x98(%rax)
  1001a6:	ff b0 90 00 00 00    	push   0x90(%rax)
  1001ac:	ff b0 88 00 00 00    	push   0x88(%rax)
  1001b2:	ff b0 80 00 00 00    	push   0x80(%rax)
  1001b8:	ff 70 78             	push   0x78(%rax)
  1001bb:	ff 70 70             	push   0x70(%rax)
  1001be:	ff 70 68             	push   0x68(%rax)
  1001c1:	ff 70 60             	push   0x60(%rax)
  1001c4:	ff 70 58             	push   0x58(%rax)
  1001c7:	ff 70 50             	push   0x50(%rax)
  1001ca:	ff 70 48             	push   0x48(%rax)
  1001cd:	ff 70 40             	push   0x40(%rax)
  1001d0:	ff 70 38             	push   0x38(%rax)
  1001d3:	ff 70 30             	push   0x30(%rax)
  1001d6:	ff 70 28             	push   0x28(%rax)
  1001d9:	ff 70 20             	push   0x20(%rax)
  1001dc:	ff 70 18             	push   0x18(%rax)
  1001df:	ff 70 10             	push   0x10(%rax)
  1001e2:	ff 70 08             	push   0x8(%rax)
  1001e5:	ff 30                	push   (%rax)
  1001e7:	48 8b 85 30 f8 ff ff 	mov    -0x7d0(%rbp),%rax
  1001ee:	48 8b 38             	mov    (%rax),%rdi
  1001f1:	e8 6a a8 f6 ff       	call   6aa60 <synreal::kernel::evaluate_cables(synreal::kernel::CableView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  1001f6:	48 81 c4 a0 00 00 00 	add    $0xa0,%rsp
  1001fd:	e9 b4 cb ff ff       	jmp    fcdb6 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1d56>
  100202:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  100208:	48 8b 05 81 7d 0f 00 	mov    0xf7d81(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  10020f:	48 8b bd 88 f5 ff ff 	mov    -0xa78(%rbp),%rdi
  100216:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
  10021d:	00 00 00 
  100220:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
  100227:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
  10022e:	e8 2d cb f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  100233:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
  10023a:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
  100240:	4d 89 e1             	mov    %r12,%r9
  100243:	45 31 c0             	xor    %r8d,%r8d
  100246:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
  10024c:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
  100253:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
  10025a:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
  100260:	e8 4b ed f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
  100265:	85 c0                	test   %eax,%eax
  100267:	75 4a                	jne    1002b3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5253>
  100269:	f3 0f 10 43 0c       	movss  0xc(%rbx),%xmm0
  10026e:	f3 0f 59 85 34 f5 ff 	mulss  -0xacc(%rbp),%xmm0
  100275:	ff 
  100276:	48 83 ec 08          	sub    $0x8,%rsp
  10027a:	48 8b 8b 60 2f 00 00 	mov    0x2f60(%rbx),%rcx
  100281:	48 8b 93 50 33 00 00 	mov    0x3350(%rbx),%rdx
  100288:	48 8b b3 a0 03 00 00 	mov    0x3a0(%rbx),%rsi
  10028f:	48 8b bb d0 03 00 00 	mov    0x3d0(%rbx),%rdi
  100296:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
  10029c:	44 8b 8b 98 03 00 00 	mov    0x398(%rbx),%r9d
  1002a3:	4c 8b 85 88 f5 ff ff 	mov    -0xa78(%rbp),%r8
  1002aa:	e8 d1 a9 f6 ff       	call   6ac80 <synreal::kernel::add_affine_body_so3_augmented_lagrangian_preconditioner(glm::vec<4, int, (glm::qualifier)0> const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  1002af:	41 5c                	pop    %r12
  1002b1:	41 5d                	pop    %r13
  1002b3:	e8 d8 c5 f6 ff       	call   6c890 <cudaGetLastError@plt>
  1002b8:	89 c7                	mov    %eax,%edi
  1002ba:	48 8d 35 77 57 0f 00 	lea    0xf5777(%rip),%rsi        # 1f5a38 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5b38>
  1002c1:	e8 3a da f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  1002c6:	e9 c1 da ff ff       	jmp    fdd8c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2d2c>
  1002cb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1002d0:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
  1002d7:	f3 0f 10 43 48       	movss  0x48(%rbx),%xmm0
  1002dc:	ff b5 a8 f4 ff ff    	push   -0xb58(%rbp)
  1002e2:	49 8b 4e 28          	mov    0x28(%r14),%rcx
  1002e6:	41 55                	push   %r13
  1002e8:	49 8b 56 18          	mov    0x18(%r14),%rdx
  1002ec:	41 8b 76 10          	mov    0x10(%r14),%esi
  1002f0:	ff b5 a0 f4 ff ff    	push   -0xb60(%rbp)
  1002f6:	ff 70 10             	push   0x10(%rax)
  1002f9:	ff 30                	push   (%rax)
  1002fb:	8b 83 98 03 00 00    	mov    0x398(%rbx),%eax
  100301:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
  100307:	50                   	push   %rax
  100308:	8b 85 38 f5 ff ff    	mov    -0xac8(%rbp),%eax
  10030e:	ff b3 e0 03 00 00    	push   0x3e0(%rbx)
  100314:	ff b3 d0 03 00 00    	push   0x3d0(%rbx)
  10031a:	ff b3 f0 03 00 00    	push   0x3f0(%rbx)
  100320:	ff b5 80 f5 ff ff    	push   -0xa80(%rbp)
  100326:	50                   	push   %rax
  100327:	8b 83 10 07 00 00    	mov    0x710(%rbx),%eax
  10032d:	50                   	push   %rax
  10032e:	ff b3 88 07 00 00    	push   0x788(%rbx)
  100334:	ff b3 78 07 00 00    	push   0x778(%rbx)
  10033a:	4d 8b 4e 48          	mov    0x48(%r14),%r9
  10033e:	ff b3 68 07 00 00    	push   0x768(%rbx)
  100344:	4d 8b 46 38          	mov    0x38(%r14),%r8
  100348:	ff b3 58 07 00 00    	push   0x758(%rbx)
  10034e:	49 8b 3e             	mov    (%r14),%rdi
  100351:	ff b3 48 07 00 00    	push   0x748(%rbx)
  100357:	f3 0f 10 0d 21 7c 0f 	movss  0xf7c21(%rip),%xmm1        # 1f7f80 <cuda::std::__4::in_place+0x33>
  10035e:	00 
  10035f:	ff b3 38 07 00 00    	push   0x738(%rbx)
  100365:	f3 0f 5e 8d 90 f4 ff 	divss  -0xb70(%rbp),%xmm1
  10036c:	ff 
  10036d:	ff b3 28 07 00 00    	push   0x728(%rbx)
  100373:	ff b3 18 07 00 00    	push   0x718(%rbx)
  100379:	41 ff b6 98 00 00 00 	push   0x98(%r14)
  100380:	41 ff b6 88 00 00 00 	push   0x88(%r14)
  100387:	41 ff 76 78          	push   0x78(%r14)
  10038b:	41 ff 76 68          	push   0x68(%r14)
  10038f:	41 ff 76 58          	push   0x58(%r14)
  100393:	e8 38 a5 f6 ff       	call   6a8d0 <synreal::kernel::evaluate_contact_force(int const*, unsigned long, int const*, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, int const*, int const*, synreal::Transform const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float const*, float const*, float, unsigned long, unsigned long, unsigned long, int const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, unsigned long, unsigned long, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, float*)@plt>
  100398:	48 81 c4 d0 00 00 00 	add    $0xd0,%rsp
  10039f:	e9 f0 c1 ff ff       	jmp    fc594 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1534>
  1003a4:	0f 1f 40 00          	nopl   0x0(%rax)
  1003a8:	48 8b 05 e1 7b 0f 00 	mov    0xf7be1(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  1003af:	48 8b bd 88 f5 ff ff 	mov    -0xa78(%rbp),%rdi
  1003b6:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
  1003bd:	00 00 00 
  1003c0:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
  1003c7:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
  1003ce:	e8 8d c9 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  1003d3:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
  1003da:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
  1003e0:	4d 89 e1             	mov    %r12,%r9
  1003e3:	45 31 c0             	xor    %r8d,%r8d
  1003e6:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
  1003ec:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
  1003f3:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
  1003fa:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
  100400:	e8 ab eb f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
  100405:	85 c0                	test   %eax,%eax
  100407:	75 4a                	jne    100453 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x53f3>
  100409:	f3 0f 10 43 0c       	movss  0xc(%rbx),%xmm0
  10040e:	f3 0f 59 85 34 f5 ff 	mulss  -0xacc(%rbp),%xmm0
  100415:	ff 
  100416:	48 83 ec 08          	sub    $0x8,%rsp
  10041a:	48 8b 8b 60 2f 00 00 	mov    0x2f60(%rbx),%rcx
  100421:	48 8b 93 50 33 00 00 	mov    0x3350(%rbx),%rdx
  100428:	48 8b b3 a0 03 00 00 	mov    0x3a0(%rbx),%rsi
  10042f:	48 8b bb d0 03 00 00 	mov    0x3d0(%rbx),%rdi
  100436:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
  10043c:	44 8b 8b 98 03 00 00 	mov    0x398(%rbx),%r9d
  100443:	4c 8b 85 88 f5 ff ff 	mov    -0xa78(%rbp),%r8
  10044a:	e8 31 a8 f6 ff       	call   6ac80 <synreal::kernel::add_affine_body_so3_augmented_lagrangian_preconditioner(glm::vec<4, int, (glm::qualifier)0> const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  10044f:	41 59                	pop    %r9
  100451:	41 5a                	pop    %r10
  100453:	e8 38 c4 f6 ff       	call   6c890 <cudaGetLastError@plt>
  100458:	89 c7                	mov    %eax,%edi
  10045a:	48 8d 35 1f 54 0f 00 	lea    0xf541f(%rip),%rsi        # 1f5880 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5980>
  100461:	e8 9a d8 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  100466:	e9 70 d1 ff ff       	jmp    fd5db <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x257b>
  10046b:	80 bd 27 f5 ff ff 00 	cmpb   $0x0,-0xad9(%rbp)
  100472:	0f 84 2f cf ff ff    	je     fd3a7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2347>
  100478:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  10047f:	00 
  100480:	48 8b 83 40 2f 00 00 	mov    0x2f40(%rbx),%rax
  100487:	4c 8b ab 60 2f 00 00 	mov    0x2f60(%rbx),%r13
  10048e:	48 89 85 90 f4 ff ff 	mov    %rax,-0xb70(%rbp)
  100495:	48 8b 85 60 f8 ff ff 	mov    -0x7a0(%rbp),%rax
  10049c:	4c 8b 20             	mov    (%rax),%r12
  10049f:	48 8b 85 58 f8 ff ff 	mov    -0x7a8(%rbp),%rax
  1004a6:	8b 78 10             	mov    0x10(%rax),%edi
  1004a9:	48 8b 85 50 f8 ff ff 	mov    -0x7b0(%rbp),%rax
  1004b0:	80 38 00             	cmpb   $0x0,(%rax)
  1004b3:	48 8b 05 d6 7a 0f 00 	mov    0xf7ad6(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  1004ba:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
  1004c1:	00 00 00 
  1004c4:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
  1004cb:	0f 85 6f 13 00 00    	jne    101840 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x67e0>
  1004d1:	e8 8a c8 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  1004d6:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
  1004dd:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
  1004e3:	4d 89 e1             	mov    %r12,%r9
  1004e6:	45 31 c0             	xor    %r8d,%r8d
  1004e9:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
  1004ef:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
  1004f6:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
  1004fd:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
  100503:	e8 a8 ea f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
  100508:	85 c0                	test   %eax,%eax
  10050a:	0f 84 e0 1f 00 00    	je     1024f0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7490>
  100510:	e8 7b c3 f6 ff       	call   6c890 <cudaGetLastError@plt>
  100515:	89 c7                	mov    %eax,%edi
  100517:	48 8d 35 02 53 0f 00 	lea    0xf5302(%rip),%rsi        # 1f5820 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5920>
  10051e:	e8 dd d7 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  100523:	e9 7f ce ff ff       	jmp    fd3a7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2347>
  100528:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  10052f:	00 
  100530:	48 8b 85 b0 f7 ff ff 	mov    -0x850(%rbp),%rax
  100537:	48 8b 95 d0 f7 ff ff 	mov    -0x830(%rbp),%rdx
  10053e:	45 31 c9             	xor    %r9d,%r9d
  100541:	45 31 c0             	xor    %r8d,%r8d
  100544:	f3 0f 10 05 34 7a 0f 	movss  0xf7a34(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  10054b:	00 
  10054c:	48 8b 88 80 32 00 00 	mov    0x3280(%rax),%rcx
  100553:	48 8b b8 b0 06 00 00 	mov    0x6b0(%rax),%rdi
  10055a:	f3 0f 5e 02          	divss  (%rdx),%xmm0
  10055e:	48 8b 90 60 30 00 00 	mov    0x3060(%rax),%rdx
  100565:	48 8b 85 b8 f7 ff ff 	mov    -0x848(%rbp),%rax
  10056c:	41 54                	push   %r12
  10056e:	ff 70 70             	push   0x70(%rax)
  100571:	ff 70 68             	push   0x68(%rax)
  100574:	ff 70 60             	push   0x60(%rax)
  100577:	ff 70 58             	push   0x58(%rax)
  10057a:	ff 70 50             	push   0x50(%rax)
  10057d:	ff 70 48             	push   0x48(%rax)
  100580:	ff 70 40             	push   0x40(%rax)
  100583:	ff 70 38             	push   0x38(%rax)
  100586:	ff 70 30             	push   0x30(%rax)
  100589:	ff 70 28             	push   0x28(%rax)
  10058c:	ff 70 20             	push   0x20(%rax)
  10058f:	ff 70 18             	push   0x18(%rax)
  100592:	ff 70 10             	push   0x10(%rax)
  100595:	ff 70 08             	push   0x8(%rax)
  100598:	ff 30                	push   (%rax)
  10059a:	48 8b 85 c8 f7 ff ff 	mov    -0x838(%rbp),%rax
  1005a1:	48 8b 30             	mov    (%rax),%rsi
  1005a4:	e8 37 a9 f6 ff       	call   6aee0 <synreal::kernel::evaluate_joint_armature(synreal::kernel::JointCoordinateView, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  1005a9:	48 83 ec 80          	sub    $0xffffffffffffff80,%rsp
  1005ad:	e9 29 d1 ff ff       	jmp    fd6db <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x267b>
  1005b2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  1005b8:	8b 83 f0 04 00 00    	mov    0x4f0(%rbx),%eax
  1005be:	f3 0f 10 43 0c       	movss  0xc(%rbx),%xmm0
  1005c3:	f3 0f 59 85 34 f5 ff 	mulss  -0xacc(%rbp),%xmm0
  1005ca:	ff 
  1005cb:	48 8b 8b 08 05 00 00 	mov    0x508(%rbx),%rcx
  1005d2:	48 8b 93 f8 04 00 00 	mov    0x4f8(%rbx),%rdx
  1005d9:	48 8b b3 d0 03 00 00 	mov    0x3d0(%rbx),%rsi
  1005e0:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
  1005e6:	50                   	push   %rax
  1005e7:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
  1005ee:	ff b5 80 f4 ff ff    	push   -0xb80(%rbp)
  1005f4:	41 54                	push   %r12
  1005f6:	ff b3 90 34 00 00    	push   0x3490(%rbx)
  1005fc:	ff b3 70 34 00 00    	push   0x3470(%rbx)
  100602:	4c 8b 83 18 05 00 00 	mov    0x518(%rbx),%r8
  100609:	ff b3 48 05 00 00    	push   0x548(%rbx)
  10060f:	48 8b 38             	mov    (%rax),%rdi
  100612:	ff b3 50 34 00 00    	push   0x3450(%rbx)
  100618:	4c 8b 8b 30 34 00 00 	mov    0x3430(%rbx),%r9
  10061f:	e8 7c a2 f6 ff       	call   6a8a0 <synreal::kernel::evaluate_body_distance_constraint_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  100624:	48 83 c4 40          	add    $0x40,%rsp
  100628:	e9 e9 c4 ff ff       	jmp    fcb16 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1ab6>
  10062d:	0f 1f 00             	nopl   (%rax)
  100630:	48 8b 85 e8 f7 ff ff 	mov    -0x818(%rbp),%rax
  100637:	48 8b 95 08 f8 ff ff 	mov    -0x7f8(%rbp),%rdx
  10063e:	4d 89 e1             	mov    %r12,%r9
  100641:	45 31 c0             	xor    %r8d,%r8d
  100644:	f3 0f 10 05 34 79 0f 	movss  0xf7934(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  10064b:	00 
  10064c:	48 8b 88 60 32 00 00 	mov    0x3260(%rax),%rcx
  100653:	48 8b b0 60 30 00 00 	mov    0x3060(%rax),%rsi
  10065a:	f3 0f 5e 02          	divss  (%rdx),%xmm0
  10065e:	48 8b 90 40 32 00 00 	mov    0x3240(%rax),%rdx
  100665:	48 8b 85 f0 f7 ff ff 	mov    -0x810(%rbp),%rax
  10066c:	6a 00                	push   $0x0
  10066e:	ff b5 88 f7 ff ff    	push   -0x878(%rbp)
  100674:	ff b5 80 f7 ff ff    	push   -0x880(%rbp)
  10067a:	ff b5 78 f7 ff ff    	push   -0x888(%rbp)
  100680:	ff b5 70 f7 ff ff    	push   -0x890(%rbp)
  100686:	ff 70 70             	push   0x70(%rax)
  100689:	ff 70 68             	push   0x68(%rax)
  10068c:	ff 70 60             	push   0x60(%rax)
  10068f:	ff 70 58             	push   0x58(%rax)
  100692:	ff 70 50             	push   0x50(%rax)
  100695:	ff 70 48             	push   0x48(%rax)
  100698:	ff 70 40             	push   0x40(%rax)
  10069b:	ff 70 38             	push   0x38(%rax)
  10069e:	ff 70 30             	push   0x30(%rax)
  1006a1:	ff 70 28             	push   0x28(%rax)
  1006a4:	ff 70 20             	push   0x20(%rax)
  1006a7:	ff 70 18             	push   0x18(%rax)
  1006aa:	ff 70 10             	push   0x10(%rax)
  1006ad:	ff 70 08             	push   0x8(%rax)
  1006b0:	ff 30                	push   (%rax)
  1006b2:	48 8b 85 00 f8 ff ff 	mov    -0x800(%rbp),%rax
  1006b9:	48 8b 38             	mov    (%rax),%rdi
  1006bc:	e8 6f a5 f6 ff       	call   6ac30 <synreal::kernel::evaluate_angular_limits(synreal::kernel::JointCoordinateView, synreal::kernel::AngularLimitView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, int const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  1006c1:	48 81 c4 a0 00 00 00 	add    $0xa0,%rsp
  1006c8:	e9 c0 c7 ff ff       	jmp    fce8d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1e2d>
  1006cd:	0f 1f 00             	nopl   (%rax)
  1006d0:	4c 0f af ad 80 f5 ff 	imul   -0xa80(%rbp),%r13
  1006d7:	ff 
  1006d8:	48 8b 05 b1 78 0f 00 	mov    0xf78b1(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  1006df:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
  1006e6:	00 00 00 
  1006e9:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
  1006f0:	4c 89 ef             	mov    %r13,%rdi
  1006f3:	e8 68 c6 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  1006f8:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
  1006ff:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
  100705:	4d 89 e1             	mov    %r12,%r9
  100708:	45 31 c0             	xor    %r8d,%r8d
  10070b:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
  100711:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
  100718:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
  10071f:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
  100725:	e8 86 e8 f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
  10072a:	85 c0                	test   %eax,%eax
  10072c:	75 61                	jne    10078f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x572f>
  10072e:	8b 83 78 02 00 00    	mov    0x278(%rbx),%eax
  100734:	48 83 ec 08          	sub    $0x8,%rsp
  100738:	48 8b 8b 90 02 00 00 	mov    0x290(%rbx),%rcx
  10073f:	48 8b 93 a0 02 00 00 	mov    0x2a0(%rbx),%rdx
  100746:	48 8b b3 80 02 00 00 	mov    0x280(%rbx),%rsi
  10074d:	ff b5 60 f5 ff ff    	push   -0xaa0(%rbp)
  100753:	4c 8b 8d a8 f4 ff ff 	mov    -0xb58(%rbp),%r9
  10075a:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
  100760:	4c 8b 83 c0 02 00 00 	mov    0x2c0(%rbx),%r8
  100767:	50                   	push   %rax
  100768:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
  10076f:	41 55                	push   %r13
  100771:	ff b5 a0 f4 ff ff    	push   -0xb60(%rbp)
  100777:	48 8b 38             	mov    (%rax),%rdi
  10077a:	ff b5 90 f4 ff ff    	push   -0xb70(%rbp)
  100780:	ff b5 70 f4 ff ff    	push   -0xb90(%rbp)
  100786:	e8 65 a6 f6 ff       	call   6adf0 <synreal::kernel::add_cloth_membrane_gauss_newton_hessian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, glm::mat<2, 2, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
  10078b:	48 83 c4 40          	add    $0x40,%rsp
  10078f:	e8 fc c0 f6 ff       	call   6c890 <cudaGetLastError@plt>
  100794:	89 c7                	mov    %eax,%edi
  100796:	48 8d 35 cb 4e 0f 00 	lea    0xf4ecb(%rip),%rsi        # 1f5668 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5768>
  10079d:	e8 5e d5 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  1007a2:	44 8b ab 40 02 00 00 	mov    0x240(%rbx),%r13d
  1007a9:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
  1007b0:	45 85 ed             	test   %r13d,%r13d
  1007b3:	0f 84 aa c8 ff ff    	je     fd063 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2003>
  1007b9:	4c 0f af ad 80 f5 ff 	imul   -0xa80(%rbp),%r13
  1007c0:	ff 
  1007c1:	48 8b 05 c8 77 0f 00 	mov    0xf77c8(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  1007c8:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
  1007cf:	00 00 00 
  1007d2:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
  1007d9:	4c 89 ef             	mov    %r13,%rdi
  1007dc:	e8 7f c5 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  1007e1:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
  1007e8:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
  1007ee:	4d 89 e1             	mov    %r12,%r9
  1007f1:	45 31 c0             	xor    %r8d,%r8d
  1007f4:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
  1007fa:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
  100801:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
  100808:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
  10080e:	e8 9d e7 f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
  100813:	85 c0                	test   %eax,%eax
  100815:	75 57                	jne    10086e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x580e>
  100817:	8b 83 40 02 00 00    	mov    0x240(%rbx),%eax
  10081d:	48 8b 8b 68 02 00 00 	mov    0x268(%rbx),%rcx
  100824:	48 8b 93 58 02 00 00 	mov    0x258(%rbx),%rdx
  10082b:	48 8b b3 48 02 00 00 	mov    0x248(%rbx),%rsi
  100832:	ff b5 60 f5 ff ff    	push   -0xaa0(%rbp)
  100838:	4c 8b 8d 70 f4 ff ff 	mov    -0xb90(%rbp),%r9
  10083f:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
  100845:	4c 8b 85 a8 f4 ff ff 	mov    -0xb58(%rbp),%r8
  10084c:	50                   	push   %rax
  10084d:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
  100854:	41 55                	push   %r13
  100856:	ff b5 a0 f4 ff ff    	push   -0xb60(%rbp)
  10085c:	48 8b 38             	mov    (%rax),%rdi
  10085f:	ff b5 90 f4 ff ff    	push   -0xb70(%rbp)
  100865:	e8 36 a5 f6 ff       	call   6ada0 <synreal::kernel::add_spring_gauss_newton_hessian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, float const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
  10086a:	48 83 c4 30          	add    $0x30,%rsp
  10086e:	e8 1d c0 f6 ff       	call   6c890 <cudaGetLastError@plt>
  100873:	89 c7                	mov    %eax,%edi
  100875:	48 8d 35 1c 4e 0f 00 	lea    0xf4e1c(%rip),%rsi        # 1f5698 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5798>
  10087c:	e8 7f d4 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  100881:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
  100888:	e9 d6 c7 ff ff       	jmp    fd063 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2003>
  10088d:	0f 1f 00             	nopl   (%rax)
  100890:	48 81 ec 30 01 00 00 	sub    $0x130,%rsp
  100897:	48 8b b5 48 f4 ff ff 	mov    -0xbb8(%rbp),%rsi
  10089e:	b9 25 00 00 00       	mov    $0x25,%ecx
  1008a3:	48 89 e7             	mov    %rsp,%rdi
  1008a6:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
  1008a9:	4c 89 e7             	mov    %r12,%rdi
  1008ac:	e8 8f a5 f6 ff       	call   6ae40 <synreal::kernel::evaluate_surface_contact_force(synreal::kernel::SurfaceContactView, glm::vec<3, float, (glm::qualifier)0>*)@plt>
  1008b1:	48 81 c4 30 01 00 00 	add    $0x130,%rsp
  1008b8:	e9 ea be ff ff       	jmp    fc7a7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1747>
  1008bd:	0f 1f 00             	nopl   (%rax)
  1008c0:	6a 00                	push   $0x0
  1008c2:	48 8b b5 60 f4 ff ff 	mov    -0xba0(%rbp),%rsi
  1008c9:	b9 27 00 00 00       	mov    $0x27,%ecx
  1008ce:	31 d2                	xor    %edx,%edx
  1008d0:	45 31 c9             	xor    %r9d,%r9d
  1008d3:	45 31 c0             	xor    %r8d,%r8d
  1008d6:	48 81 ec 38 01 00 00 	sub    $0x138,%rsp
  1008dd:	48 89 e7             	mov    %rsp,%rdi
  1008e0:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
  1008e3:	4c 89 ef             	mov    %r13,%rdi
  1008e6:	48 8b b5 a8 f4 ff ff 	mov    -0xb58(%rbp),%rsi
  1008ed:	e8 8e a5 f6 ff       	call   6ae80 <synreal::kernel::evaluate_hard_contacts(synreal::kernel::HardContactView, glm::vec<3, float, (glm::qualifier)0>*, float*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, float*)@plt>
  1008f2:	48 81 c4 40 01 00 00 	add    $0x140,%rsp
  1008f9:	e9 51 ec ff ff       	jmp    ff54f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x44ef>
  1008fe:	66 90                	xchg   %ax,%ax
  100900:	48 8b 85 40 f8 ff ff 	mov    -0x7c0(%rbp),%rax
  100907:	4d 89 e0             	mov    %r12,%r8
  10090a:	31 c9                	xor    %ecx,%ecx
  10090c:	31 d2                	xor    %edx,%edx
  10090e:	f3 0f 10 05 6a 76 0f 	movss  0xf766a(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  100915:	00 
  100916:	f3 0f 5e 00          	divss  (%rax),%xmm0
  10091a:	48 8b 85 38 f8 ff ff 	mov    -0x7c8(%rbp),%rax
  100921:	48 8b b0 60 30 00 00 	mov    0x3060(%rax),%rsi
  100928:	48 8b 85 28 f8 ff ff 	mov    -0x7d8(%rbp),%rax
  10092f:	ff b0 98 00 00 00    	push   0x98(%rax)
  100935:	ff b0 90 00 00 00    	push   0x90(%rax)
  10093b:	ff b0 88 00 00 00    	push   0x88(%rax)
  100941:	ff b0 80 00 00 00    	push   0x80(%rax)
  100947:	ff 70 78             	push   0x78(%rax)
  10094a:	ff 70 70             	push   0x70(%rax)
  10094d:	ff 70 68             	push   0x68(%rax)
  100950:	ff 70 60             	push   0x60(%rax)
  100953:	ff 70 58             	push   0x58(%rax)
  100956:	ff 70 50             	push   0x50(%rax)
  100959:	ff 70 48             	push   0x48(%rax)
  10095c:	ff 70 40             	push   0x40(%rax)
  10095f:	ff 70 38             	push   0x38(%rax)
  100962:	ff 70 30             	push   0x30(%rax)
  100965:	ff 70 28             	push   0x28(%rax)
  100968:	ff 70 20             	push   0x20(%rax)
  10096b:	ff 70 18             	push   0x18(%rax)
  10096e:	ff 70 10             	push   0x10(%rax)
  100971:	ff 70 08             	push   0x8(%rax)
  100974:	ff 30                	push   (%rax)
  100976:	48 8b 85 30 f8 ff ff 	mov    -0x7d0(%rbp),%rax
  10097d:	48 8b 38             	mov    (%rax),%rdi
  100980:	e8 db a0 f6 ff       	call   6aa60 <synreal::kernel::evaluate_cables(synreal::kernel::CableView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  100985:	48 81 c4 a0 00 00 00 	add    $0xa0,%rsp
  10098c:	e9 79 d4 ff ff       	jmp    fde0a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2daa>
  100991:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  100998:	48 8b 85 40 f8 ff ff 	mov    -0x7c0(%rbp),%rax
  10099f:	4d 89 e0             	mov    %r12,%r8
  1009a2:	31 c9                	xor    %ecx,%ecx
  1009a4:	31 d2                	xor    %edx,%edx
  1009a6:	f3 0f 10 05 d2 75 0f 	movss  0xf75d2(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  1009ad:	00 
  1009ae:	f3 0f 5e 00          	divss  (%rax),%xmm0
  1009b2:	48 8b 85 38 f8 ff ff 	mov    -0x7c8(%rbp),%rax
  1009b9:	48 8b b0 60 30 00 00 	mov    0x3060(%rax),%rsi
  1009c0:	48 8b 85 28 f8 ff ff 	mov    -0x7d8(%rbp),%rax
  1009c7:	ff b0 98 00 00 00    	push   0x98(%rax)
  1009cd:	ff b0 90 00 00 00    	push   0x90(%rax)
  1009d3:	ff b0 88 00 00 00    	push   0x88(%rax)
  1009d9:	ff b0 80 00 00 00    	push   0x80(%rax)
  1009df:	ff 70 78             	push   0x78(%rax)
  1009e2:	ff 70 70             	push   0x70(%rax)
  1009e5:	ff 70 68             	push   0x68(%rax)
  1009e8:	ff 70 60             	push   0x60(%rax)
  1009eb:	ff 70 58             	push   0x58(%rax)
  1009ee:	ff 70 50             	push   0x50(%rax)
  1009f1:	ff 70 48             	push   0x48(%rax)
  1009f4:	ff 70 40             	push   0x40(%rax)
  1009f7:	ff 70 38             	push   0x38(%rax)
  1009fa:	ff 70 30             	push   0x30(%rax)
  1009fd:	ff 70 28             	push   0x28(%rax)
  100a00:	ff 70 20             	push   0x20(%rax)
  100a03:	ff 70 18             	push   0x18(%rax)
  100a06:	ff 70 10             	push   0x10(%rax)
  100a09:	ff 70 08             	push   0x8(%rax)
  100a0c:	ff 30                	push   (%rax)
  100a0e:	48 8b 85 30 f8 ff ff 	mov    -0x7d0(%rbp),%rax
  100a15:	48 8b 38             	mov    (%rax),%rdi
  100a18:	e8 43 a0 f6 ff       	call   6aa60 <synreal::kernel::evaluate_cables(synreal::kernel::CableView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  100a1d:	48 81 c4 a0 00 00 00 	add    $0xa0,%rsp
  100a24:	e9 54 cd ff ff       	jmp    fd77d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x271d>
  100a29:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  100a30:	48 8b 85 e8 f7 ff ff 	mov    -0x818(%rbp),%rax
  100a37:	48 8b 95 08 f8 ff ff 	mov    -0x7f8(%rbp),%rdx
  100a3e:	45 31 c9             	xor    %r9d,%r9d
  100a41:	45 31 c0             	xor    %r8d,%r8d
  100a44:	f3 0f 10 05 34 75 0f 	movss  0xf7534(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  100a4b:	00 
  100a4c:	48 8b 88 60 32 00 00 	mov    0x3260(%rax),%rcx
  100a53:	48 8b b0 60 30 00 00 	mov    0x3060(%rax),%rsi
  100a5a:	f3 0f 5e 02          	divss  (%rdx),%xmm0
  100a5e:	48 8b 90 40 32 00 00 	mov    0x3240(%rax),%rdx
  100a65:	48 8b 85 f0 f7 ff ff 	mov    -0x810(%rbp),%rax
  100a6c:	41 54                	push   %r12
  100a6e:	ff b5 a8 f7 ff ff    	push   -0x858(%rbp)
  100a74:	ff b5 a0 f7 ff ff    	push   -0x860(%rbp)
  100a7a:	ff b5 98 f7 ff ff    	push   -0x868(%rbp)
  100a80:	ff b5 90 f7 ff ff    	push   -0x870(%rbp)
  100a86:	ff 70 70             	push   0x70(%rax)
  100a89:	ff 70 68             	push   0x68(%rax)
  100a8c:	ff 70 60             	push   0x60(%rax)
  100a8f:	ff 70 58             	push   0x58(%rax)
  100a92:	ff 70 50             	push   0x50(%rax)
  100a95:	ff 70 48             	push   0x48(%rax)
  100a98:	ff 70 40             	push   0x40(%rax)
  100a9b:	ff 70 38             	push   0x38(%rax)
  100a9e:	ff 70 30             	push   0x30(%rax)
  100aa1:	ff 70 28             	push   0x28(%rax)
  100aa4:	ff 70 20             	push   0x20(%rax)
  100aa7:	ff 70 18             	push   0x18(%rax)
  100aaa:	ff 70 10             	push   0x10(%rax)
  100aad:	ff 70 08             	push   0x8(%rax)
  100ab0:	ff 30                	push   (%rax)
  100ab2:	48 8b 85 00 f8 ff ff 	mov    -0x800(%rbp),%rax
  100ab9:	48 8b 38             	mov    (%rax),%rdi
  100abc:	e8 6f a1 f6 ff       	call   6ac30 <synreal::kernel::evaluate_angular_limits(synreal::kernel::JointCoordinateView, synreal::kernel::AngularLimitView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, int const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  100ac1:	48 81 c4 a0 00 00 00 	add    $0xa0,%rsp
  100ac8:	e9 87 cd ff ff       	jmp    fd854 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x27f4>
  100acd:	0f 1f 00             	nopl   (%rax)
  100ad0:	48 8b 05 b9 74 0f 00 	mov    0xf74b9(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  100ad7:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
  100ade:	00 00 00 
  100ae1:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
  100ae8:	e8 73 c2 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  100aed:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
  100af4:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
  100afa:	4d 89 e1             	mov    %r12,%r9
  100afd:	45 31 c0             	xor    %r8d,%r8d
  100b00:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
  100b06:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
  100b0d:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
  100b14:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
  100b1a:	e8 91 e4 f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
  100b1f:	85 c0                	test   %eax,%eax
  100b21:	0f 84 79 0d 00 00    	je     1018a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6840>
  100b27:	e8 64 bd f6 ff       	call   6c890 <cudaGetLastError@plt>
  100b2c:	89 c7                	mov    %eax,%edi
  100b2e:	48 8d 35 1b 50 0f 00 	lea    0xf501b(%rip),%rsi        # 1f5b50 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5c50>
  100b35:	e8 c6 d1 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  100b3a:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
  100b41:	e9 a4 d9 ff ff       	jmp    fe4ea <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x348a>
  100b46:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  100b4d:	00 00 00 
  100b50:	4c 0f af e8          	imul   %rax,%r13
  100b54:	48 89 85 20 f4 ff ff 	mov    %rax,-0xbe0(%rbp)
  100b5b:	4d 85 ed             	test   %r13,%r13
  100b5e:	0f 84 6c c6 ff ff    	je     fd1d0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2170>
  100b64:	8b 83 6c 05 00 00    	mov    0x56c(%rbx),%eax
  100b6a:	48 89 85 08 f4 ff ff 	mov    %rax,-0xbf8(%rbp)
  100b71:	e9 85 0d 00 00       	jmp    1018fb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x689b>
  100b76:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  100b7d:	00 00 00 
  100b80:	48 8b bb b0 2d 00 00 	mov    0x2db0(%rbx),%rdi
  100b87:	48 85 ff             	test   %rdi,%rdi
  100b8a:	0f 85 d8 17 00 00    	jne    102368 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7308>
  100b90:	8b 83 98 03 00 00    	mov    0x398(%rbx),%eax
  100b96:	85 c0                	test   %eax,%eax
  100b98:	0f 84 ba 17 00 00    	je     102358 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x72f8>
  100b9e:	8b 8d d0 f4 ff ff    	mov    -0xb30(%rbp),%ecx
  100ba4:	8d 51 fe             	lea    -0x2(%rcx),%edx
  100ba7:	83 fa 01             	cmp    $0x1,%edx
  100baa:	0f 86 40 0f 00 00    	jbe    101af0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6a90>
  100bb0:	f3 0f 10 43 0c       	movss  0xc(%rbx),%xmm0
  100bb5:	66 0f ef f6          	pxor   %xmm6,%xmm6
  100bb9:	0f 2f c6             	comiss %xmm6,%xmm0
  100bbc:	0f 86 2e 1a 00 00    	jbe    1025f0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7590>
  100bc2:	c6 85 30 f5 ff ff 01 	movb   $0x1,-0xad0(%rbp)
  100bc9:	31 d2                	xor    %edx,%edx
  100bcb:	41 bd 01 00 00 00    	mov    $0x1,%r13d
  100bd1:	bf 01 00 00 00       	mov    $0x1,%edi
  100bd6:	e9 16 b4 ff ff       	jmp    fbff1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf91>
  100bdb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  100be0:	49 8b 86 c0 00 00 00 	mov    0xc0(%r14),%rax
  100be7:	31 d2                	xor    %edx,%edx
  100be9:	f3 41 0f 6f 8e e0 00 	movdqu 0xe0(%r14),%xmm1
  100bf0:	00 00 
  100bf2:	f3 41 0f 6f b6 f0 00 	movdqu 0xf0(%r14),%xmm6
  100bf9:	00 00 
  100bfb:	f3 41 0f 6f 86 00 01 	movdqu 0x100(%r14),%xmm0
  100c02:	00 00 
  100c04:	f3 41 0f 6f ae 10 01 	movdqu 0x110(%r14),%xmm5
  100c0b:	00 00 
  100c0d:	48 89 85 00 fb ff ff 	mov    %rax,-0x500(%rbp)
  100c14:	41 8b 86 d0 00 00 00 	mov    0xd0(%r14),%eax
  100c1b:	66 0f 6d ce          	punpckhqdq %xmm6,%xmm1
  100c1f:	f3 41 0f 6f 96 20 01 	movdqu 0x120(%r14),%xmm2
  100c26:	00 00 
  100c28:	f3 41 0f 6f a6 30 01 	movdqu 0x130(%r14),%xmm4
  100c2f:	00 00 
  100c31:	66 0f 6d c5          	punpckhqdq %xmm5,%xmm0
  100c35:	0f 29 8d 20 fb ff ff 	movaps %xmm1,-0x4e0(%rbp)
  100c3c:	48 89 85 08 fb ff ff 	mov    %rax,-0x4f8(%rbp)
  100c43:	49 8b 86 50 01 00 00 	mov    0x150(%r14),%rax
  100c4a:	66 0f 6d d4          	punpckhqdq %xmm4,%xmm2
  100c4e:	0f 29 85 30 fb ff ff 	movaps %xmm0,-0x4d0(%rbp)
  100c55:	0f 29 95 10 fb ff ff 	movaps %xmm2,-0x4f0(%rbp)
  100c5c:	48 85 c0             	test   %rax,%rax
  100c5f:	0f 85 93 0f 00 00    	jne    101bf8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6b98>
  100c65:	f3 0f 7e 83 18 01 00 	movq   0x118(%rbx),%xmm0
  100c6c:	00 
  100c6d:	48 89 85 48 fb ff ff 	mov    %rax,-0x4b8(%rbp)
  100c74:	31 c0                	xor    %eax,%eax
  100c76:	48 83 bb 00 01 00 00 	cmpq   $0x0,0x100(%rbx)
  100c7d:	00 
  100c7e:	48 89 95 40 fb ff ff 	mov    %rdx,-0x4c0(%rbp)
  100c85:	0f 16 83 c0 00 00 00 	movhps 0xc0(%rbx),%xmm0
  100c8c:	0f 29 85 50 fb ff ff 	movaps %xmm0,-0x4b0(%rbp)
  100c93:	0f 85 37 0f 00 00    	jne    101bd0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6b70>
  100c99:	48 8b b5 58 f5 ff ff 	mov    -0xaa8(%rbp),%rsi
  100ca0:	66 48 0f 6e c0       	movq   %rax,%xmm0
  100ca5:	f3 0f 6f 8b b0 07 00 	movdqu 0x7b0(%rbx),%xmm1
  100cac:	00 
  100cad:	0f 16 83 b0 33 00 00 	movhps 0x33b0(%rbx),%xmm0
  100cb4:	f3 0f 6f b3 50 07 00 	movdqu 0x750(%rbx),%xmm6
  100cbb:	00 
  100cbc:	f3 0f 6f ab 70 07 00 	movdqu 0x770(%rbx),%xmm5
  100cc3:	00 
  100cc4:	0f 29 85 60 fb ff ff 	movaps %xmm0,-0x4a0(%rbp)
  100ccb:	66 48 0f 6e c6       	movq   %rsi,%xmm0
  100cd0:	f3 0f 6f bb 40 07 00 	movdqu 0x740(%rbx),%xmm7
  100cd7:	00 
  100cd8:	48 8b 83 88 07 00 00 	mov    0x788(%rbx),%rax
  100cdf:	0f 16 85 60 f5 ff ff 	movhps -0xaa0(%rbp),%xmm0
  100ce6:	f3 0f 6f 93 30 07 00 	movdqu 0x730(%rbx),%xmm2
  100ced:	00 
  100cee:	66 0f 6d ce          	punpckhqdq %xmm6,%xmm1
  100cf2:	f3 0f 6f 9b 10 07 00 	movdqu 0x710(%rbx),%xmm3
  100cf9:	00 
  100cfa:	0f 29 85 70 fb ff ff 	movaps %xmm0,-0x490(%rbp)
  100d01:	f3 0f 6f 83 60 07 00 	movdqu 0x760(%rbx),%xmm0
  100d08:	00 
  100d09:	f3 0f 6f a3 20 07 00 	movdqu 0x720(%rbx),%xmm4
  100d10:	00 
  100d11:	0f 29 8d a0 fb ff ff 	movaps %xmm1,-0x460(%rbp)
  100d18:	66 0f 6e 8d 38 f5 ff 	movd   -0xac8(%rbp),%xmm1
  100d1f:	ff 
  100d20:	48 8b 95 80 f5 ff ff 	mov    -0xa80(%rbp),%rdx
  100d27:	66 0f 6d d7          	punpckhqdq %xmm7,%xmm2
  100d2b:	66 0f 6d c5          	punpckhqdq %xmm5,%xmm0
  100d2f:	48 89 85 c0 fb ff ff 	mov    %rax,-0x440(%rbp)
  100d36:	0f 10 bb c8 07 00 00 	movups 0x7c8(%rbx),%xmm7
  100d3d:	66 0f 6d dc          	punpckhqdq %xmm4,%xmm3
  100d41:	0f 29 85 b0 fb ff ff 	movaps %xmm0,-0x450(%rbp)
  100d48:	66 0f 6e 83 10 07 00 	movd   0x710(%rbx),%xmm0
  100d4f:	00 
  100d50:	48 8b 83 f0 03 00 00 	mov    0x3f0(%rbx),%rax
  100d57:	48 8b 8b d0 03 00 00 	mov    0x3d0(%rbx),%rcx
  100d5e:	4c 8b 83 e0 03 00 00 	mov    0x3e0(%rbx),%r8
  100d65:	48 89 95 d8 fb ff ff 	mov    %rdx,-0x428(%rbp)
  100d6c:	66 0f 6c c1          	punpcklqdq %xmm1,%xmm0
  100d70:	48 89 85 f0 fb ff ff 	mov    %rax,-0x410(%rbp)
  100d77:	0f 11 85 c8 fb ff ff 	movups %xmm0,-0x438(%rbp)
  100d7e:	48 89 8d f8 fb ff ff 	mov    %rcx,-0x408(%rbp)
  100d85:	4c 89 85 00 fc ff ff 	mov    %r8,-0x400(%rbp)
  100d8c:	0f 29 9d 80 fb ff ff 	movaps %xmm3,-0x480(%rbp)
  100d93:	0f 29 95 90 fb ff ff 	movaps %xmm2,-0x470(%rbp)
  100d9a:	0f 29 bd e0 fb ff ff 	movaps %xmm7,-0x420(%rbp)
  100da1:	8b 83 98 03 00 00    	mov    0x398(%rbx),%eax
  100da7:	48 89 85 08 fc ff ff 	mov    %rax,-0x3f8(%rbp)
  100dae:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
  100db5:	48 8b 00             	mov    (%rax),%rax
  100db8:	66 48 0f 6e c0       	movq   %rax,%xmm0
  100dbd:	48 89 85 c8 f4 ff ff 	mov    %rax,-0xb38(%rbp)
  100dc4:	0f 16 83 60 30 00 00 	movhps 0x3060(%rbx),%xmm0
  100dcb:	0f 29 85 10 fc ff ff 	movaps %xmm0,-0x3f0(%rbp)
  100dd2:	f3 0f 10 05 a6 71 0f 	movss  0xf71a6(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  100dd9:	00 
  100dda:	f3 0f 5e 85 1c f5 ff 	divss  -0xae4(%rbp),%xmm0
  100de1:	ff 
  100de2:	f3 0f 11 85 20 fc ff 	movss  %xmm0,-0x3e0(%rbp)
  100de9:	ff 
  100dea:	e9 2f aa ff ff       	jmp    fb81e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7be>
  100def:	90                   	nop
  100df0:	48 8b 05 99 71 0f 00 	mov    0xf7199(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  100df7:	48 8b bd 88 f5 ff ff 	mov    -0xa78(%rbp),%rdi
  100dfe:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
  100e05:	00 00 00 
  100e08:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
  100e0f:	e8 4c bf f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  100e14:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
  100e1b:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
  100e21:	4d 89 e1             	mov    %r12,%r9
  100e24:	45 31 c0             	xor    %r8d,%r8d
  100e27:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
  100e2d:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
  100e34:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
  100e3b:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
  100e41:	e8 6a e1 f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
  100e46:	85 c0                	test   %eax,%eax
  100e48:	0f 84 ba 0d 00 00    	je     101c08 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6ba8>
  100e4e:	e8 3d ba f6 ff       	call   6c890 <cudaGetLastError@plt>
  100e53:	89 c7                	mov    %eax,%edi
  100e55:	48 8d 35 74 46 0f 00 	lea    0xf4674(%rip),%rsi        # 1f54d0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x55d0>
  100e5c:	e8 9f ce f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  100e61:	e9 85 ef ff ff       	jmp    ffdeb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4d8b>
  100e66:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  100e6d:	00 00 00 
  100e70:	48 8b 05 19 71 0f 00 	mov    0xf7119(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  100e77:	48 8b bd 88 f5 ff ff 	mov    -0xa78(%rbp),%rdi
  100e7e:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
  100e85:	00 00 00 
  100e88:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
  100e8f:	e8 cc be f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  100e94:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
  100e9b:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
  100ea1:	4d 89 e1             	mov    %r12,%r9
  100ea4:	45 31 c0             	xor    %r8d,%r8d
  100ea7:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
  100ead:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
  100eb4:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
  100ebb:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
  100ec1:	e8 ea e0 f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
  100ec6:	85 c0                	test   %eax,%eax
  100ec8:	0f 84 a2 0d 00 00    	je     101c70 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6c10>
  100ece:	e8 bd b9 f6 ff       	call   6c890 <cudaGetLastError@plt>
  100ed3:	89 c7                	mov    %eax,%edi
  100ed5:	48 8d 35 24 46 0f 00 	lea    0xf4624(%rip),%rsi        # 1f5500 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5600>
  100edc:	e8 1f ce f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  100ee1:	e9 05 ef ff ff       	jmp    ffdeb <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4d8b>
  100ee6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  100eed:	00 00 00 
  100ef0:	48 8b 05 99 70 0f 00 	mov    0xf7099(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  100ef7:	4c 8b ad 10 f5 ff ff 	mov    -0xaf0(%rbp),%r13
  100efe:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
  100f05:	00 00 00 
  100f08:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
  100f0f:	e8 4c be f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  100f14:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
  100f1b:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
  100f21:	4d 89 e9             	mov    %r13,%r9
  100f24:	45 31 c0             	xor    %r8d,%r8d
  100f27:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
  100f2d:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
  100f34:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
  100f3b:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
  100f41:	e8 6a e0 f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
  100f46:	85 c0                	test   %eax,%eax
  100f48:	0f 84 02 0f 00 00    	je     101e50 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6df0>
  100f4e:	e8 3d b9 f6 ff       	call   6c890 <cudaGetLastError@plt>
  100f53:	89 c7                	mov    %eax,%edi
  100f55:	48 8d 35 0c 44 0f 00 	lea    0xf440c(%rip),%rsi        # 1f5368 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5468>
  100f5c:	e8 9f cd f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  100f61:	e9 2a bb ff ff       	jmp    fca90 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1a30>
  100f66:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  100f6d:	00 00 00 
  100f70:	48 8b 05 19 70 0f 00 	mov    0xf7019(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  100f77:	4c 8b ad 10 f5 ff ff 	mov    -0xaf0(%rbp),%r13
  100f7e:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
  100f85:	00 00 00 
  100f88:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
  100f8f:	e8 cc bd f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  100f94:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
  100f9b:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
  100fa1:	4d 89 e9             	mov    %r13,%r9
  100fa4:	45 31 c0             	xor    %r8d,%r8d
  100fa7:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
  100fad:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
  100fb4:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
  100fbb:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
  100fc1:	e8 ea df f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
  100fc6:	85 c0                	test   %eax,%eax
  100fc8:	0f 84 f2 0d 00 00    	je     101dc0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6d60>
  100fce:	e8 bd b8 f6 ff       	call   6c890 <cudaGetLastError@plt>
  100fd3:	89 c7                	mov    %eax,%edi
  100fd5:	48 8d 35 2c 44 0f 00 	lea    0xf442c(%rip),%rsi        # 1f5408 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5508>
  100fdc:	e8 1f cd f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  100fe1:	e9 12 bc ff ff       	jmp    fcbf8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1b98>
  100fe6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  100fed:	00 00 00 
  100ff0:	41 bf 01 00 00 00    	mov    $0x1,%r15d
  100ff6:	e9 04 a3 ff ff       	jmp    fb2ff <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x29f>
  100ffb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  101000:	f3 0f 10 43 0c       	movss  0xc(%rbx),%xmm0
  101005:	66 0f ef ff          	pxor   %xmm7,%xmm7
  101009:	0f 2f c7             	comiss %xmm7,%xmm0
  10100c:	0f 86 68 c0 ff ff    	jbe    fd07a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x201a>
  101012:	e9 5e df ff ff       	jmp    fef75 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3f15>
  101017:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  10101e:	00 00 
  101020:	85 c0                	test   %eax,%eax
  101022:	0f 85 10 a6 ff ff    	jne    fb638 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5d8>
  101028:	8b 83 10 07 00 00    	mov    0x710(%rbx),%eax
  10102e:	e9 05 a6 ff ff       	jmp    fb638 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5d8>
  101033:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  101038:	48 8b bd 88 f5 ff ff 	mov    -0xa78(%rbp),%rdi
  10103f:	48 85 ff             	test   %rdi,%rdi
  101042:	0f 84 52 af ff ff    	je     fbf9a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf3a>
  101048:	48 8b 05 41 6f 0f 00 	mov    0xf6f41(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  10104f:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
  101056:	c7 85 c8 f9 ff ff 01 	movl   $0x1,-0x638(%rbp)
  10105d:	00 00 00 
  101060:	48 89 85 c0 f9 ff ff 	mov    %rax,-0x640(%rbp)
  101067:	e8 f4 bc f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  10106c:	8b 8d c8 f9 ff ff    	mov    -0x638(%rbp),%ecx
  101072:	45 31 c0             	xor    %r8d,%r8d
  101075:	4d 89 e1             	mov    %r12,%r9
  101078:	89 85 60 fa ff ff    	mov    %eax,-0x5a0(%rbp)
  10107e:	48 8b 95 c0 f9 ff ff 	mov    -0x640(%rbp),%rdx
  101085:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
  10108c:	00 00 00 
  10108f:	48 89 85 64 fa ff ff 	mov    %rax,-0x59c(%rbp)
  101096:	48 8b bd 60 fa ff ff 	mov    -0x5a0(%rbp),%rdi
  10109d:	8b b5 68 fa ff ff    	mov    -0x598(%rbp),%esi
  1010a3:	e8 08 df f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
  1010a8:	85 c0                	test   %eax,%eax
  1010aa:	0f 84 a1 17 00 00    	je     102851 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x77f1>
  1010b0:	e8 db b7 f6 ff       	call   6c890 <cudaGetLastError@plt>
  1010b5:	48 8d 35 bc 3f 0f 00 	lea    0xf3fbc(%rip),%rsi        # 1f5078 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5178>
  1010bc:	89 c7                	mov    %eax,%edi
  1010be:	e8 3d cc f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  1010c3:	e9 d2 ae ff ff       	jmp    fbf9a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf3a>
  1010c8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  1010cf:	00 
  1010d0:	48 c7 85 a8 f4 ff ff 	movq   $0x0,-0xb58(%rbp)
  1010d7:	00 00 00 00 
  1010db:	e9 c7 c2 ff ff       	jmp    fd3a7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2347>
  1010e0:	4c 8b 8d 10 f5 ff ff 	mov    -0xaf0(%rbp),%r9
  1010e7:	4c 89 e7             	mov    %r12,%rdi
  1010ea:	48 8b 05 9f 6e 0f 00 	mov    0xf6e9f(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  1010f1:	c7 85 c8 f9 ff ff 01 	movl   $0x1,-0x638(%rbp)
  1010f8:	00 00 00 
  1010fb:	4c 89 8d 28 f4 ff ff 	mov    %r9,-0xbd8(%rbp)
  101102:	48 89 85 c0 f9 ff ff 	mov    %rax,-0x640(%rbp)
  101109:	e8 52 bc f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  10110e:	8b 8d c8 f9 ff ff    	mov    -0x638(%rbp),%ecx
  101114:	4c 8b 8d 28 f4 ff ff 	mov    -0xbd8(%rbp),%r9
  10111b:	45 31 c0             	xor    %r8d,%r8d
  10111e:	89 85 60 fa ff ff    	mov    %eax,-0x5a0(%rbp)
  101124:	48 8b 95 c0 f9 ff ff 	mov    -0x640(%rbp),%rdx
  10112b:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
  101132:	00 00 00 
  101135:	48 89 85 64 fa ff ff 	mov    %rax,-0x59c(%rbp)
  10113c:	48 8b bd 60 fa ff ff 	mov    -0x5a0(%rbp),%rdi
  101143:	8b b5 68 fa ff ff    	mov    -0x598(%rbp),%esi
  101149:	e8 62 de f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
  10114e:	85 c0                	test   %eax,%eax
  101150:	0f 84 72 0d 00 00    	je     101ec8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6e68>
  101156:	e8 35 b7 f6 ff       	call   6c890 <cudaGetLastError@plt>
  10115b:	48 8d 35 de 3f 0f 00 	lea    0xf3fde(%rip),%rsi        # 1f5140 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5240>
  101162:	89 c7                	mov    %eax,%edi
  101164:	e8 97 cb f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  101169:	e9 84 af ff ff       	jmp    fc0f2 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1092>
  10116e:	66 90                	xchg   %ax,%ax
  101170:	48 8b 05 19 6e 0f 00 	mov    0xf6e19(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  101177:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
  10117e:	c7 85 c8 f9 ff ff 01 	movl   $0x1,-0x638(%rbp)
  101185:	00 00 00 
  101188:	48 89 85 c0 f9 ff ff 	mov    %rax,-0x640(%rbp)
  10118f:	e8 cc bb f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  101194:	8b 8d c8 f9 ff ff    	mov    -0x638(%rbp),%ecx
  10119a:	45 31 c0             	xor    %r8d,%r8d
  10119d:	4d 89 e1             	mov    %r12,%r9
  1011a0:	89 85 60 fa ff ff    	mov    %eax,-0x5a0(%rbp)
  1011a6:	48 8b 95 c0 f9 ff ff 	mov    -0x640(%rbp),%rdx
  1011ad:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
  1011b4:	00 00 00 
  1011b7:	48 89 85 64 fa ff ff 	mov    %rax,-0x59c(%rbp)
  1011be:	48 8b bd 60 fa ff ff 	mov    -0x5a0(%rbp),%rdi
  1011c5:	8b b5 68 fa ff ff    	mov    -0x598(%rbp),%esi
  1011cb:	e8 e0 dd f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
  1011d0:	85 c0                	test   %eax,%eax
  1011d2:	0f 84 48 0e 00 00    	je     102020 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6fc0>
  1011d8:	e8 b3 b6 f6 ff       	call   6c890 <cudaGetLastError@plt>
  1011dd:	48 8d 35 fc 3c 0f 00 	lea    0xf3cfc(%rip),%rsi        # 1f4ee0 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x4fe0>
  1011e4:	89 c7                	mov    %eax,%edi
  1011e6:	e8 15 cb f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  1011eb:	44 8b 83 98 04 00 00 	mov    0x498(%rbx),%r8d
  1011f2:	48 8b 95 80 f5 ff ff 	mov    -0xa80(%rbp),%rdx
  1011f9:	48 8b b5 58 f5 ff ff 	mov    -0xaa8(%rbp),%rsi
  101200:	48 8b 8b d0 03 00 00 	mov    0x3d0(%rbx),%rcx
  101207:	e9 91 a7 ff ff       	jmp    fb99d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x93d>
  10120c:	0f 1f 40 00          	nopl   0x0(%rax)
  101210:	bf 20 01 00 00       	mov    $0x120,%edi
  101215:	0f 29 85 90 fe ff ff 	movaps %xmm0,-0x170(%rbp)
  10121c:	48 c7 85 a0 fe ff ff 	movq   $0x0,-0x160(%rbp)
  101223:	00 00 00 00 
  101227:	48 c7 85 a8 fe ff ff 	movq   $0x0,-0x158(%rbp)
  10122e:	00 00 00 00 
  101232:	e8 19 bf f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  101237:	48 8d 8d 60 f5 ff ff 	lea    -0xaa0(%rbp),%rcx
  10123e:	48 8d 95 88 f5 ff ff 	lea    -0xa78(%rbp),%rdx
  101245:	66 0f 6f a5 90 f4 ff 	movdqa -0xb70(%rbp),%xmm4
  10124c:	ff 
  10124d:	4c 89 b0 a8 00 00 00 	mov    %r14,0xa8(%rax)
  101254:	66 48 0f 6e c1       	movq   %rcx,%xmm0
  101259:	48 8d 8d 30 f5 ff ff 	lea    -0xad0(%rbp),%rcx
  101260:	66 48 0f 6e ea       	movq   %rdx,%xmm5
  101265:	0f 16 85 00 f5 ff ff 	movhps -0xb00(%rbp),%xmm0
  10126c:	48 8d 95 44 f5 ff ff 	lea    -0xabc(%rbp),%rdx
  101273:	0f 11 60 20          	movups %xmm4,0x20(%rax)
  101277:	0f 11 00             	movups %xmm0,(%rax)
  10127a:	66 48 0f 6e c1       	movq   %rcx,%xmm0
  10127f:	48 8d 8d 34 f5 ff ff 	lea    -0xacc(%rbp),%rcx
  101286:	66 48 0f 6e fa       	movq   %rdx,%xmm7
  10128b:	66 0f 6c c5          	punpcklqdq %xmm5,%xmm0
  10128f:	48 8d 95 31 f5 ff ff 	lea    -0xacf(%rbp),%rdx
  101296:	0f 11 40 10          	movups %xmm0,0x10(%rax)
  10129a:	66 48 0f 6e c1       	movq   %rcx,%xmm0
  10129f:	66 48 0f 6e f2       	movq   %rdx,%xmm6
  1012a4:	48 8d 8d 2e f5 ff ff 	lea    -0xad2(%rbp),%rcx
  1012ab:	66 0f 6c c7          	punpcklqdq %xmm7,%xmm0
  1012af:	48 8d 95 68 f5 ff ff 	lea    -0xa98(%rbp),%rdx
  1012b6:	0f 11 40 30          	movups %xmm0,0x30(%rax)
  1012ba:	66 48 0f 6e ea       	movq   %rdx,%xmm5
  1012bf:	48 8d 95 a0 f5 ff ff 	lea    -0xa60(%rbp),%rdx
  1012c6:	f3 0f 7e 85 70 f4 ff 	movq   -0xb90(%rbp),%xmm0
  1012cd:	ff 
  1012ce:	66 48 0f 6e e2       	movq   %rdx,%xmm4
  1012d3:	48 8d 95 2f f5 ff ff 	lea    -0xad1(%rbp),%rdx
  1012da:	66 0f 6c c6          	punpcklqdq %xmm6,%xmm0
  1012de:	0f 11 40 40          	movups %xmm0,0x40(%rax)
  1012e2:	66 48 0f 6e c1       	movq   %rcx,%xmm0
  1012e7:	48 8d 8d 40 f5 ff ff 	lea    -0xac0(%rbp),%rcx
  1012ee:	66 0f 6c c5          	punpcklqdq %xmm5,%xmm0
  1012f2:	0f 11 40 50          	movups %xmm0,0x50(%rax)
  1012f6:	66 49 0f 6e c7       	movq   %r15,%xmm0
  1012fb:	66 0f 6c c4          	punpcklqdq %xmm4,%xmm0
  1012ff:	0f 11 40 60          	movups %xmm0,0x60(%rax)
  101303:	66 48 0f 6e c2       	movq   %rdx,%xmm0
  101308:	48 8d 95 2b f5 ff ff 	lea    -0xad5(%rbp),%rdx
  10130f:	66 48 0f 6e fa       	movq   %rdx,%xmm7
  101314:	48 8d 95 27 f5 ff ff 	lea    -0xad9(%rbp),%rdx
  10131b:	66 0f 6c c7          	punpcklqdq %xmm7,%xmm0
  10131f:	0f 11 40 70          	movups %xmm0,0x70(%rax)
  101323:	66 48 0f 6e c1       	movq   %rcx,%xmm0
  101328:	48 8b 8d a0 f4 ff ff 	mov    -0xb60(%rbp),%rcx
  10132f:	0f 16 85 48 f4 ff ff 	movhps -0xbb8(%rbp),%xmm0
  101336:	0f 11 80 80 00 00 00 	movups %xmm0,0x80(%rax)
  10133d:	66 48 0f 6e c2       	movq   %rdx,%xmm0
  101342:	48 8d 95 50 f8 ff ff 	lea    -0x7b0(%rbp),%rdx
  101349:	66 48 0f 6e f2       	movq   %rdx,%xmm6
  10134e:	48 8d 95 2a f5 ff ff 	lea    -0xad6(%rbp),%rdx
  101355:	48 89 88 b0 00 00 00 	mov    %rcx,0xb0(%rax)
  10135c:	48 8d 0d 4d e9 fe ff 	lea    -0x116b3(%rip),%rcx        # efcb0 <std::_Function_handler<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >), synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}>::_M_manager(std::_Any_data&, std::_Any_data const&, std::_Manager_operation)>
  101363:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
  10136a:	48 8b 95 38 f4 ff ff 	mov    -0xbc8(%rbp),%rdx
  101371:	66 0f 6c c6          	punpcklqdq %xmm6,%xmm0
  101375:	0f 11 80 90 00 00 00 	movups %xmm0,0x90(%rax)
  10137c:	48 89 90 b8 00 00 00 	mov    %rdx,0xb8(%rax)
  101383:	48 8d 95 26 f5 ff ff 	lea    -0xada(%rbp),%rdx
  10138a:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
  101391:	48 8d 95 78 f5 ff ff 	lea    -0xa88(%rbp),%rdx
  101398:	48 89 90 c8 00 00 00 	mov    %rdx,0xc8(%rax)
  10139f:	48 8d 95 70 f5 ff ff 	lea    -0xa90(%rbp),%rdx
  1013a6:	48 89 90 d0 00 00 00 	mov    %rdx,0xd0(%rax)
  1013ad:	48 8d 95 32 f5 ff ff 	lea    -0xace(%rbp),%rdx
  1013b4:	48 89 90 d8 00 00 00 	mov    %rdx,0xd8(%rax)
  1013bb:	48 8d 95 98 f5 ff ff 	lea    -0xa68(%rbp),%rdx
  1013c2:	48 89 90 e0 00 00 00 	mov    %rdx,0xe0(%rax)
  1013c9:	48 8d 95 3c f5 ff ff 	lea    -0xac4(%rbp),%rdx
  1013d0:	48 89 90 e8 00 00 00 	mov    %rdx,0xe8(%rax)
  1013d7:	48 8d 95 33 f5 ff ff 	lea    -0xacd(%rbp),%rdx
  1013de:	48 89 90 f0 00 00 00 	mov    %rdx,0xf0(%rax)
  1013e5:	48 8d 95 b0 f7 ff ff 	lea    -0x850(%rbp),%rdx
  1013ec:	48 89 90 f8 00 00 00 	mov    %rdx,0xf8(%rax)
  1013f3:	48 8d 95 10 f8 ff ff 	lea    -0x7f0(%rbp),%rdx
  1013fa:	48 89 90 00 01 00 00 	mov    %rdx,0x100(%rax)
  101401:	48 8d 95 e0 f7 ff ff 	lea    -0x820(%rbp),%rdx
  101408:	48 89 90 08 01 00 00 	mov    %rdx,0x108(%rax)
  10140f:	48 8d 95 29 f5 ff ff 	lea    -0xad7(%rbp),%rdx
  101416:	48 89 90 10 01 00 00 	mov    %rdx,0x110(%rax)
  10141d:	48 8d 95 50 fc ff ff 	lea    -0x3b0(%rbp),%rdx
  101424:	48 89 90 18 01 00 00 	mov    %rdx,0x118(%rax)
  10142b:	48 8d 15 fe 26 00 00 	lea    0x26fe(%rip),%rdx        # 103b30 <std::_Function_handler<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >), synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)::{lambda(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)#11}>::_M_invoke(std::_Any_data const&, synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>&&, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >&&)>
  101432:	48 89 85 90 fe ff ff 	mov    %rax,-0x170(%rbp)
  101439:	66 0f 6f 85 90 fe ff 	movdqa -0x170(%rbp),%xmm0
  101440:	ff 
  101441:	66 48 0f 6e fa       	movq   %rdx,%xmm7
  101446:	66 0f 6f ad 30 fc ff 	movdqa -0x3d0(%rbp),%xmm5
  10144d:	ff 
  10144e:	66 0f 6f a5 40 fc ff 	movdqa -0x3c0(%rbp),%xmm4
  101455:	ff 
  101456:	48 8b 85 40 fc ff ff 	mov    -0x3c0(%rbp),%rax
  10145d:	0f 29 85 30 fc ff ff 	movaps %xmm0,-0x3d0(%rbp)
  101464:	66 48 0f 6e c1       	movq   %rcx,%xmm0
  101469:	66 0f 6c c7          	punpcklqdq %xmm7,%xmm0
  10146d:	0f 29 ad 90 fe ff ff 	movaps %xmm5,-0x170(%rbp)
  101474:	0f 29 a5 a0 fe ff ff 	movaps %xmm4,-0x160(%rbp)
  10147b:	0f 29 85 40 fc ff ff 	movaps %xmm0,-0x3c0(%rbp)
  101482:	48 85 c0             	test   %rax,%rax
  101485:	0f 84 91 ac ff ff    	je     fc11c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x10bc>
  10148b:	48 8d bd 90 fe ff ff 	lea    -0x170(%rbp),%rdi
  101492:	ba 03 00 00 00       	mov    $0x3,%edx
  101497:	48 89 fe             	mov    %rdi,%rsi
  10149a:	ff d0                	call   *%rax
  10149c:	e9 7b ac ff ff       	jmp    fc11c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x10bc>
  1014a1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  1014a8:	48 8b 05 e1 6a 0f 00 	mov    0xf6ae1(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  1014af:	41 8b 7e 10          	mov    0x10(%r14),%edi
  1014b3:	c7 85 c8 f9 ff ff 01 	movl   $0x1,-0x638(%rbp)
  1014ba:	00 00 00 
  1014bd:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
  1014c4:	48 89 85 c0 f9 ff ff 	mov    %rax,-0x640(%rbp)
  1014cb:	e8 90 b8 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  1014d0:	8b 8d c8 f9 ff ff    	mov    -0x638(%rbp),%ecx
  1014d6:	45 31 c0             	xor    %r8d,%r8d
  1014d9:	4d 89 e1             	mov    %r12,%r9
  1014dc:	89 85 60 fa ff ff    	mov    %eax,-0x5a0(%rbp)
  1014e2:	48 8b 95 c0 f9 ff ff 	mov    -0x640(%rbp),%rdx
  1014e9:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
  1014f0:	00 00 00 
  1014f3:	48 89 85 64 fa ff ff 	mov    %rax,-0x59c(%rbp)
  1014fa:	48 8b bd 60 fa ff ff 	mov    -0x5a0(%rbp),%rdi
  101501:	8b b5 68 fa ff ff    	mov    -0x598(%rbp),%esi
  101507:	e8 a4 da f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
  10150c:	85 c0                	test   %eax,%eax
  10150e:	0f 84 ec 09 00 00    	je     101f00 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6ea0>
  101514:	e8 77 b3 f6 ff       	call   6c890 <cudaGetLastError@plt>
  101519:	48 8d 35 e8 39 0f 00 	lea    0xf39e8(%rip),%rsi        # 1f4f08 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5008>
  101520:	89 c7                	mov    %eax,%edi
  101522:	e8 d9 c7 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  101527:	e9 20 a7 ff ff       	jmp    fbc4c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xbec>
  10152c:	0f 1f 40 00          	nopl   0x0(%rax)
  101530:	48 89 d0             	mov    %rdx,%rax
  101533:	f3 0f 10 43 74       	movss  0x74(%rbx),%xmm0
  101538:	48 8b 95 10 f5 ff ff 	mov    -0xaf0(%rbp),%rdx
  10153f:	48 8d bb f0 08 00 00 	lea    0x8f0(%rbx),%rdi
  101546:	48 8b 30             	mov    (%rax),%rsi
  101549:	e8 02 c1 f6 ff       	call   6d650 <synreal::SelfCollision::begin_frame(glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)@plt>
  10154e:	e9 ec a6 ff ff       	jmp    fbc3f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xbdf>
  101553:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  101558:	48 8b 05 31 6a 0f 00 	mov    0xf6a31(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  10155f:	41 8b 7e 10          	mov    0x10(%r14),%edi
  101563:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
  10156a:	00 00 00 
  10156d:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
  101574:	e8 e7 b7 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  101579:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
  10157f:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
  101585:	4d 89 e1             	mov    %r12,%r9
  101588:	45 31 c0             	xor    %r8d,%r8d
  10158b:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
  101592:	00 00 00 
  101595:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
  10159c:	48 89 85 68 f7 ff ff 	mov    %rax,-0x898(%rbp)
  1015a3:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
  1015aa:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
  1015b0:	e8 fb d9 f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
  1015b5:	85 c0                	test   %eax,%eax
  1015b7:	0f 84 d3 07 00 00    	je     101d90 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6d30>
  1015bd:	e8 ce b2 f6 ff       	call   6c890 <cudaGetLastError@plt>
  1015c2:	89 c7                	mov    %eax,%edi
  1015c4:	48 8d 35 35 46 0f 00 	lea    0xf4635(%rip),%rsi        # 1f5c00 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5d00>
  1015cb:	e8 30 c7 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  1015d0:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
  1015d7:	e9 e2 ca ff ff       	jmp    fe0be <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x305e>
  1015dc:	0f 1f 40 00          	nopl   0x0(%rax)
  1015e0:	44 8b a3 d4 05 00 00 	mov    0x5d4(%rbx),%r12d
  1015e7:	4c 0f af a5 80 f5 ff 	imul   -0xa80(%rbp),%r12
  1015ee:	ff 
  1015ef:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
  1015f6:	00 00 00 
  1015f9:	48 8b 05 90 69 0f 00 	mov    0xf6990(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  101600:	4c 8b ad 10 f5 ff ff 	mov    -0xaf0(%rbp),%r13
  101607:	4c 89 e7             	mov    %r12,%rdi
  10160a:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
  101611:	e8 4a b7 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  101616:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
  10161c:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
  101622:	4d 89 e9             	mov    %r13,%r9
  101625:	45 31 c0             	xor    %r8d,%r8d
  101628:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
  10162f:	00 00 00 
  101632:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
  101639:	48 89 85 68 f7 ff ff 	mov    %rax,-0x898(%rbp)
  101640:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
  101647:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
  10164d:	e8 5e d9 f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
  101652:	85 c0                	test   %eax,%eax
  101654:	0f 84 ae 06 00 00    	je     101d08 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6ca8>
  10165a:	e8 31 b2 f6 ff       	call   6c890 <cudaGetLastError@plt>
  10165f:	89 c7                	mov    %eax,%edi
  101661:	48 8d 35 10 46 0f 00 	lea    0xf4610(%rip),%rsi        # 1f5c78 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5d78>
  101668:	e8 93 c6 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  10166d:	e9 87 cb ff ff       	jmp    fe1f9 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3199>
  101672:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  101678:	48 8b 05 11 69 0f 00 	mov    0xf6911(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  10167f:	48 8b bd 80 f4 ff ff 	mov    -0xb80(%rbp),%rdi
  101686:	c7 85 c8 f9 ff ff 01 	movl   $0x1,-0x638(%rbp)
  10168d:	00 00 00 
  101690:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
  101697:	48 89 85 c0 f9 ff ff 	mov    %rax,-0x640(%rbp)
  10169e:	e8 bd b6 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  1016a3:	8b 8d c8 f9 ff ff    	mov    -0x638(%rbp),%ecx
  1016a9:	45 31 c0             	xor    %r8d,%r8d
  1016ac:	4d 89 e1             	mov    %r12,%r9
  1016af:	89 85 60 fa ff ff    	mov    %eax,-0x5a0(%rbp)
  1016b5:	48 8b 95 c0 f9 ff ff 	mov    -0x640(%rbp),%rdx
  1016bc:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
  1016c3:	00 00 00 
  1016c6:	48 89 85 64 fa ff ff 	mov    %rax,-0x59c(%rbp)
  1016cd:	48 8b bd 60 fa ff ff 	mov    -0x5a0(%rbp),%rdi
  1016d4:	8b b5 68 fa ff ff    	mov    -0x598(%rbp),%esi
  1016da:	e8 d1 d8 f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
  1016df:	85 c0                	test   %eax,%eax
  1016e1:	0f 84 c9 08 00 00    	je     101fb0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6f50>
  1016e7:	e8 a4 b1 f6 ff       	call   6c890 <cudaGetLastError@plt>
  1016ec:	48 8d 35 4d 39 0f 00 	lea    0xf394d(%rip),%rsi        # 1f5040 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5140>
  1016f3:	89 c7                	mov    %eax,%edi
  1016f5:	e8 06 c6 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  1016fa:	e9 8e a8 ff ff       	jmp    fbf8d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf2d>
  1016ff:	90                   	nop
  101700:	48 8b 05 89 68 0f 00 	mov    0xf6889(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  101707:	48 8b bd 78 f5 ff ff 	mov    -0xa88(%rbp),%rdi
  10170e:	c7 85 c8 f9 ff ff 01 	movl   $0x1,-0x638(%rbp)
  101715:	00 00 00 
  101718:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
  10171f:	48 89 85 c0 f9 ff ff 	mov    %rax,-0x640(%rbp)
  101726:	e8 35 b6 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  10172b:	8b 8d c8 f9 ff ff    	mov    -0x638(%rbp),%ecx
  101731:	45 31 c0             	xor    %r8d,%r8d
  101734:	4d 89 e1             	mov    %r12,%r9
  101737:	89 85 60 fa ff ff    	mov    %eax,-0x5a0(%rbp)
  10173d:	48 8b 95 c0 f9 ff ff 	mov    -0x640(%rbp),%rdx
  101744:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
  10174b:	00 00 00 
  10174e:	48 89 85 64 fa ff ff 	mov    %rax,-0x59c(%rbp)
  101755:	48 8b bd 60 fa ff ff 	mov    -0x5a0(%rbp),%rdi
  10175c:	8b b5 68 fa ff ff    	mov    -0x598(%rbp),%esi
  101762:	e8 49 d8 f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
  101767:	85 c0                	test   %eax,%eax
  101769:	0f 84 f9 07 00 00    	je     101f68 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6f08>
  10176f:	e8 1c b1 f6 ff       	call   6c890 <cudaGetLastError@plt>
  101774:	48 8d 35 6d 38 0f 00 	lea    0xf386d(%rip),%rsi        # 1f4fe8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x50e8>
  10177b:	89 c7                	mov    %eax,%edi
  10177d:	e8 7e c5 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  101782:	e9 bc a7 ff ff       	jmp    fbf43 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xee3>
  101787:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  10178e:	00 00 
  101790:	48 8b 05 f9 67 0f 00 	mov    0xf67f9(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  101797:	48 8b bd 58 f5 ff ff 	mov    -0xaa8(%rbp),%rdi
  10179e:	c7 85 c8 f9 ff ff 01 	movl   $0x1,-0x638(%rbp)
  1017a5:	00 00 00 
  1017a8:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
  1017af:	48 89 85 c0 f9 ff ff 	mov    %rax,-0x640(%rbp)
  1017b6:	e8 a5 b5 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  1017bb:	8b 8d c8 f9 ff ff    	mov    -0x638(%rbp),%ecx
  1017c1:	45 31 c0             	xor    %r8d,%r8d
  1017c4:	4d 89 e1             	mov    %r12,%r9
  1017c7:	89 85 60 fa ff ff    	mov    %eax,-0x5a0(%rbp)
  1017cd:	48 8b 95 c0 f9 ff ff 	mov    -0x640(%rbp),%rdx
  1017d4:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
  1017db:	00 00 00 
  1017de:	48 89 85 64 fa ff ff 	mov    %rax,-0x59c(%rbp)
  1017e5:	48 8b bd 60 fa ff ff 	mov    -0x5a0(%rbp),%rdi
  1017ec:	8b b5 68 fa ff ff    	mov    -0x598(%rbp),%esi
  1017f2:	e8 b9 d7 f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
  1017f7:	85 c0                	test   %eax,%eax
  1017f9:	0f 84 31 07 00 00    	je     101f30 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6ed0>
  1017ff:	e8 8c b0 f6 ff       	call   6c890 <cudaGetLastError@plt>
  101804:	48 8d 35 55 37 0f 00 	lea    0xf3755(%rip),%rsi        # 1f4f60 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5060>
  10180b:	89 c7                	mov    %eax,%edi
  10180d:	e8 ee c4 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  101812:	e9 dd a4 ff ff       	jmp    fbcf4 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xc94>
  101817:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  10181e:	00 00 
  101820:	48 8d bb f0 08 00 00 	lea    0x8f0(%rbx),%rdi
  101827:	e8 54 be f6 ff       	call   6d680 <synreal::SelfCollision::available() const@plt>
  10182c:	8b 8b f0 04 00 00    	mov    0x4f0(%rbx),%ecx
  101832:	48 8b 95 80 f5 ff ff 	mov    -0xa80(%rbp),%rdx
  101839:	e9 2e a3 ff ff       	jmp    fbb6c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xb0c>
  10183e:	66 90                	xchg   %ax,%ax
  101840:	e8 1b b5 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  101845:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
  10184c:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
  101852:	4d 89 e1             	mov    %r12,%r9
  101855:	45 31 c0             	xor    %r8d,%r8d
  101858:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
  10185e:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
  101865:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
  10186c:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
  101872:	e8 39 d7 f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
  101877:	85 c0                	test   %eax,%eax
  101879:	0f 84 f1 07 00 00    	je     102070 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7010>
  10187f:	e8 0c b0 f6 ff       	call   6c890 <cudaGetLastError@plt>
  101884:	89 c7                	mov    %eax,%edi
  101886:	48 8d 35 6b 3f 0f 00 	lea    0xf3f6b(%rip),%rsi        # 1f57f8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x58f8>
  10188d:	e8 6e c4 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  101892:	e9 10 bb ff ff       	jmp    fd3a7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2347>
  101897:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  10189e:	00 00 
  1018a0:	8b 83 98 03 00 00    	mov    0x398(%rbx),%eax
  1018a6:	48 8b 8b 70 33 00 00 	mov    0x3370(%rbx),%rcx
  1018ad:	45 89 e8             	mov    %r13d,%r8d
  1018b0:	48 8b 93 50 33 00 00 	mov    0x3350(%rbx),%rdx
  1018b7:	48 8b b3 d0 03 00 00 	mov    0x3d0(%rbx),%rsi
  1018be:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
  1018c4:	41 83 e0 01          	and    $0x1,%r8d
  1018c8:	4c 8b 8d 88 f5 ff ff 	mov    -0xa78(%rbp),%r9
  1018cf:	50                   	push   %rax
  1018d0:	48 8b 85 e8 f4 ff ff 	mov    -0xb18(%rbp),%rax
  1018d7:	48 8b 38             	mov    (%rax),%rdi
  1018da:	e8 31 95 f6 ff       	call   6ae10 <synreal::kernel::update_affine_body_so3_augmented_lagrangian_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, bool, unsigned long, unsigned long, unsigned long)@plt>
  1018df:	5e                   	pop    %rsi
  1018e0:	5f                   	pop    %rdi
  1018e1:	e9 41 f2 ff ff       	jmp    100b27 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5ac7>
  1018e6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  1018ed:	00 00 00 
  1018f0:	48 c7 85 08 f4 ff ff 	movq   $0x0,-0xbf8(%rbp)
  1018f7:	00 00 00 00 
  1018fb:	48 8b 05 8e 66 0f 00 	mov    0xf668e(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  101902:	4c 89 ef             	mov    %r13,%rdi
  101905:	c7 85 60 f7 ff ff 01 	movl   $0x1,-0x8a0(%rbp)
  10190c:	00 00 00 
  10190f:	48 89 85 58 f7 ff ff 	mov    %rax,-0x8a8(%rbp)
  101916:	e8 45 b4 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  10191b:	4c 89 bd 68 f7 ff ff 	mov    %r15,-0x898(%rbp)
  101922:	8b 8d 60 f7 ff ff    	mov    -0x8a0(%rbp),%ecx
  101928:	4d 89 e1             	mov    %r12,%r9
  10192b:	45 31 c0             	xor    %r8d,%r8d
  10192e:	89 85 64 f7 ff ff    	mov    %eax,-0x89c(%rbp)
  101934:	48 8b 95 58 f7 ff ff 	mov    -0x8a8(%rbp),%rdx
  10193b:	48 8b bd 64 f7 ff ff 	mov    -0x89c(%rbp),%rdi
  101942:	8b b5 6c f7 ff ff    	mov    -0x894(%rbp),%esi
  101948:	e8 63 d6 f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
  10194d:	85 c0                	test   %eax,%eax
  10194f:	0f 85 88 00 00 00    	jne    1019dd <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x697d>
  101955:	48 83 ec 08          	sub    $0x8,%rsp
  101959:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
  101960:	48 8b 8b b0 34 00 00 	mov    0x34b0(%rbx),%rcx
  101967:	48 8b 93 70 05 00 00 	mov    0x570(%rbx),%rdx
  10196e:	48 8b b3 d0 03 00 00 	mov    0x3d0(%rbx),%rsi
  101975:	ff b5 60 f5 ff ff    	push   -0xaa0(%rbp)
  10197b:	f3 0f 10 85 3c f5 ff 	movss  -0xac4(%rbp),%xmm0
  101982:	ff 
  101983:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
  101989:	4c 8b 8b f0 34 00 00 	mov    0x34f0(%rbx),%r9
  101990:	ff b5 20 f4 ff ff    	push   -0xbe0(%rbp)
  101996:	4c 8b 83 d0 34 00 00 	mov    0x34d0(%rbx),%r8
  10199d:	41 55                	push   %r13
  10199f:	ff b5 a0 f4 ff ff    	push   -0xb60(%rbp)
  1019a5:	ff b5 90 f4 ff ff    	push   -0xb70(%rbp)
  1019ab:	ff b5 70 f4 ff ff    	push   -0xb90(%rbp)
  1019b1:	ff b5 a8 f4 ff ff    	push   -0xb58(%rbp)
  1019b7:	6a 01                	push   $0x1
  1019b9:	ff b5 08 f4 ff ff    	push   -0xbf8(%rbp)
  1019bf:	ff b3 b0 05 00 00    	push   0x5b0(%rbx)
  1019c5:	ff b3 a0 05 00 00    	push   0x5a0(%rbx)
  1019cb:	ff b3 90 05 00 00    	push   0x590(%rbx)
  1019d1:	48 8b 38             	mov    (%rax),%rdi
  1019d4:	e8 d7 93 f6 ff       	call   6adb0 <synreal::kernel::add_body_point_line_gauss_newton_hessian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, unsigned long, bool, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
  1019d9:	48 83 c4 70          	add    $0x70,%rsp
  1019dd:	e8 ae ae f6 ff       	call   6c890 <cudaGetLastError@plt>
  1019e2:	89 c7                	mov    %eax,%edi
  1019e4:	48 8d 35 3d 3d 0f 00 	lea    0xf3d3d(%rip),%rsi        # 1f5728 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5828>
  1019eb:	e8 10 c3 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  1019f0:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
  1019f7:	e9 d4 b7 ff ff       	jmp    fd1d0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x2170>
  1019fc:	0f 1f 40 00          	nopl   0x0(%rax)
  101a00:	44 0f b6 ab 40 33 00 	movzbl 0x3340(%rbx),%r13d
  101a07:	00 
  101a08:	44 88 ad c0 f4 ff ff 	mov    %r13b,-0xb40(%rbp)
  101a0f:	45 84 ed             	test   %r13b,%r13b
  101a12:	0f 85 88 a6 ff ff    	jne    fc0a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1040>
  101a18:	44 8b 93 e8 17 00 00 	mov    0x17e8(%rbx),%r10d
  101a1f:	45 85 d2             	test   %r10d,%r10d
  101a22:	0f 85 88 06 00 00    	jne    1020b0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7050>
  101a28:	44 8b 8b 80 21 00 00 	mov    0x2180(%rbx),%r9d
  101a2f:	45 85 c9             	test   %r9d,%r9d
  101a32:	0f 85 78 06 00 00    	jne    1020b0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7050>
  101a38:	09 f1                	or     %esi,%ecx
  101a3a:	88 8d c0 f4 ff ff    	mov    %cl,-0xb40(%rbp)
  101a40:	41 89 cd             	mov    %ecx,%r13d
  101a43:	84 c9                	test   %cl,%cl
  101a45:	0f 85 55 a6 ff ff    	jne    fc0a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1040>
  101a4b:	44 0a 85 26 f5 ff ff 	or     -0xada(%rbp),%r8b
  101a52:	44 88 85 c0 f4 ff ff 	mov    %r8b,-0xb40(%rbp)
  101a59:	45 89 c5             	mov    %r8d,%r13d
  101a5c:	0f 85 3e a6 ff ff    	jne    fc0a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1040>
  101a62:	0a 95 29 f5 ff ff    	or     -0xad7(%rbp),%dl
  101a68:	88 95 c0 f4 ff ff    	mov    %dl,-0xb40(%rbp)
  101a6e:	41 89 d5             	mov    %edx,%r13d
  101a71:	0f 85 29 a6 ff ff    	jne    fc0a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1040>
  101a77:	44 0f b6 ad 2c f5 ff 	movzbl -0xad4(%rbp),%r13d
  101a7e:	ff 
  101a7f:	0f b6 8d a8 f4 ff ff 	movzbl -0xb58(%rbp),%ecx
  101a86:	44 09 e9             	or     %r13d,%ecx
  101a89:	88 8d c0 f4 ff ff    	mov    %cl,-0xb40(%rbp)
  101a8f:	e9 0c a6 ff ff       	jmp    fc0a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1040>
  101a94:	0f 1f 40 00          	nopl   0x0(%rax)
  101a98:	f3 0f 10 43 0c       	movss  0xc(%rbx),%xmm0
  101a9d:	66 0f ef ed          	pxor   %xmm5,%xmm5
  101aa1:	0f 2f c5             	comiss %xmm5,%xmm0
  101aa4:	0f 86 64 a5 ff ff    	jbe    fc00e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xfae>
  101aaa:	44 8b 9d 8c f4 ff ff 	mov    -0xb74(%rbp),%r11d
  101ab1:	c6 85 30 f4 ff ff 01 	movb   $0x1,-0xbd0(%rbp)
  101ab8:	45 85 db             	test   %r11d,%r11d
  101abb:	40 0f 95 c6          	setne  %sil
  101abf:	e9 53 a5 ff ff       	jmp    fc017 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xfb7>
  101ac4:	0f 1f 40 00          	nopl   0x0(%rax)
  101ac8:	48 8b bb b0 2d 00 00 	mov    0x2db0(%rbx),%rdi
  101acf:	48 85 ff             	test   %rdi,%rdi
  101ad2:	0f 85 90 08 00 00    	jne    102368 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7308>
  101ad8:	8b 8d d0 f4 ff ff    	mov    -0xb30(%rbp),%ecx
  101ade:	8b 83 98 03 00 00    	mov    0x398(%rbx),%eax
  101ae4:	8d 51 fe             	lea    -0x2(%rcx),%edx
  101ae7:	83 fa 01             	cmp    $0x1,%edx
  101aea:	0f 87 c0 f0 ff ff    	ja     100bb0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5b50>
  101af0:	83 bd d0 f4 ff ff 03 	cmpl   $0x3,-0xb30(%rbp)
  101af7:	c6 85 30 f5 ff ff 00 	movb   $0x0,-0xad0(%rbp)
  101afe:	0f 85 f3 0a 00 00    	jne    1025f7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7597>
  101b04:	f3 0f 10 43 0c       	movss  0xc(%rbx),%xmm0
  101b09:	66 0f ef f6          	pxor   %xmm6,%xmm6
  101b0d:	bf 01 00 00 00       	mov    $0x1,%edi
  101b12:	0f 2f c6             	comiss %xmm6,%xmm0
  101b15:	0f 97 c2             	seta   %dl
  101b18:	41 89 d5             	mov    %edx,%r13d
  101b1b:	e9 d1 a4 ff ff       	jmp    fbff1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf91>
  101b20:	48 8b 83 a8 07 00 00 	mov    0x7a8(%rbx),%rax
  101b27:	e9 5c c8 ff ff       	jmp    fe388 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3328>
  101b2c:	0f 1f 40 00          	nopl   0x0(%rax)
  101b30:	48 8b 83 98 07 00 00 	mov    0x798(%rbx),%rax
  101b37:	e9 35 c8 ff ff       	jmp    fe371 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3311>
  101b3c:	0f 1f 40 00          	nopl   0x0(%rax)
  101b40:	48 8d 14 bd 00 00 00 	lea    0x0(,%rdi,4),%rdx
  101b47:	00 
  101b48:	48 8b 70 30          	mov    0x30(%rax),%rsi
  101b4c:	4d 89 e0             	mov    %r12,%r8
  101b4f:	48 8b bb 80 32 00 00 	mov    0x3280(%rbx),%rdi
  101b56:	b9 03 00 00 00       	mov    $0x3,%ecx
  101b5b:	e8 50 c5 f6 ff       	call   6e0b0 <cudaMemcpyAsync@plt>
  101b60:	48 8d 35 21 34 0f 00 	lea    0xf3421(%rip),%rsi        # 1f4f88 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5088>
  101b67:	89 c7                	mov    %eax,%edi
  101b69:	e8 92 c1 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  101b6e:	e9 c3 a3 ff ff       	jmp    fbf36 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xed6>
  101b73:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  101b78:	44 8b 8b 10 07 00 00 	mov    0x710(%rbx),%r9d
  101b7f:	45 85 c9             	test   %r9d,%r9d
  101b82:	0f 84 8a 9b ff ff    	je     fb712 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6b2>
  101b88:	44 0f b6 43 4c       	movzbl 0x4c(%rbx),%r8d
  101b8d:	c6 85 27 f5 ff ff 01 	movb   $0x1,-0xad9(%rbp)
  101b94:	45 84 c0             	test   %r8b,%r8b
  101b97:	0f 85 2b 05 00 00    	jne    1020c8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7068>
  101b9d:	41 b8 01 00 00 00    	mov    $0x1,%r8d
  101ba3:	e9 74 9b ff ff       	jmp    fb71c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6bc>
  101ba8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  101baf:	00 
  101bb0:	0f 28 e3             	movaps %xmm3,%xmm4
  101bb3:	e9 29 a2 ff ff       	jmp    fbde1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xd81>
  101bb8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  101bbf:	00 
  101bc0:	48 8b 83 f8 00 00 00 	mov    0xf8(%rbx),%rax
  101bc7:	e9 f1 a1 ff ff       	jmp    fbdbd <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xd5d>
  101bcc:	0f 1f 40 00          	nopl   0x0(%rax)
  101bd0:	48 8b 83 f8 00 00 00 	mov    0xf8(%rbx),%rax
  101bd7:	e9 bd f0 ff ff       	jmp    100c99 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5c39>
  101bdc:	0f 1f 40 00          	nopl   0x0(%rax)
  101be0:	49 0f af c4          	imul   %r12,%rax
  101be4:	48 39 d0             	cmp    %rdx,%rax
  101be7:	0f 86 a5 97 ff ff    	jbe    fb392 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x332>
  101bed:	e9 86 4a f7 ff       	jmp    76678 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x96>
  101bf2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  101bf8:	49 8b 96 48 01 00 00 	mov    0x148(%r14),%rdx
  101bff:	e9 61 f0 ff ff       	jmp    100c65 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5c05>
  101c04:	0f 1f 40 00          	nopl   0x0(%rax)
  101c08:	f3 0f 10 43 0c       	movss  0xc(%rbx),%xmm0
  101c0d:	f3 0f 59 85 34 f5 ff 	mulss  -0xacc(%rbp),%xmm0
  101c14:	ff 
  101c15:	48 83 ec 08          	sub    $0x8,%rsp
  101c19:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
  101c20:	48 8b 8b 40 30 00 00 	mov    0x3040(%rbx),%rcx
  101c27:	48 8b 93 a0 03 00 00 	mov    0x3a0(%rbx),%rdx
  101c2e:	48 8b b3 d0 03 00 00 	mov    0x3d0(%rbx),%rsi
  101c35:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
  101c3b:	44 8b 8b 98 03 00 00 	mov    0x398(%rbx),%r9d
  101c42:	4c 8b 85 88 f5 ff ff 	mov    -0xa78(%rbp),%r8
  101c49:	48 8b 38             	mov    (%rax),%rdi
  101c4c:	e8 7f 8b f6 ff       	call   6a7d0 <synreal::kernel::evaluate_affine_body_spring_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  101c51:	41 59                	pop    %r9
  101c53:	41 5a                	pop    %r10
  101c55:	e9 f4 f1 ff ff       	jmp    100e4e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5dee>
  101c5a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  101c60:	49 8b 86 48 01 00 00 	mov    0x148(%r14),%rax
  101c67:	e9 23 b8 ff ff       	jmp    fd48f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x242f>
  101c6c:	0f 1f 40 00          	nopl   0x0(%rax)
  101c70:	8b 83 98 03 00 00    	mov    0x398(%rbx),%eax
  101c76:	f3 0f 10 43 0c       	movss  0xc(%rbx),%xmm0
  101c7b:	48 83 ec 08          	sub    $0x8,%rsp
  101c7f:	f3 0f 59 85 34 f5 ff 	mulss  -0xacc(%rbp),%xmm0
  101c86:	ff 
  101c87:	48 8b 8b 50 33 00 00 	mov    0x3350(%rbx),%rcx
  101c8e:	48 8b 93 a0 03 00 00 	mov    0x3a0(%rbx),%rdx
  101c95:	48 8b b3 d0 03 00 00 	mov    0x3d0(%rbx),%rsi
  101c9c:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
  101ca2:	4c 8b 8b 40 30 00 00 	mov    0x3040(%rbx),%r9
  101ca9:	50                   	push   %rax
  101caa:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
  101cb1:	ff b5 88 f5 ff ff    	push   -0xa78(%rbp)
  101cb7:	4c 8b 83 70 33 00 00 	mov    0x3370(%rbx),%r8
  101cbe:	48 8b 38             	mov    (%rax),%rdi
  101cc1:	e8 5a 90 f6 ff       	call   6ad20 <synreal::kernel::evaluate_affine_body_so3_augmented_lagrangian_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  101cc6:	48 83 c4 20          	add    $0x20,%rsp
  101cca:	e9 ff f1 ff ff       	jmp    100ece <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5e6e>
  101ccf:	90                   	nop
  101cd0:	f3 0f 10 43 64       	movss  0x64(%rbx),%xmm0
  101cd5:	0f 2f c6             	comiss %xmm6,%xmm0
  101cd8:	0f 97 85 bb f4 ff ff 	seta   -0xb45(%rbp)
  101cdf:	e9 77 9b ff ff       	jmp    fb85b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7fb>
  101ce4:	0f 1f 40 00          	nopl   0x0(%rax)
  101ce8:	48 83 bb 10 01 00 00 	cmpq   $0x0,0x110(%rbx)
  101cef:	00 
  101cf0:	0f 84 2b a1 ff ff    	je     fbe21 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xdc1>
  101cf6:	48 8b 93 08 01 00 00 	mov    0x108(%rbx),%rdx
  101cfd:	e9 1f a1 ff ff       	jmp    fbe21 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xdc1>
  101d02:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  101d08:	8b 83 d4 05 00 00    	mov    0x5d4(%rbx),%eax
  101d0e:	48 83 ec 08          	sub    $0x8,%rsp
  101d12:	48 8b 8b d0 03 00 00 	mov    0x3d0(%rbx),%rcx
  101d19:	48 8b 93 60 32 00 00 	mov    0x3260(%rbx),%rdx
  101d20:	48 8b b3 40 32 00 00 	mov    0x3240(%rbx),%rsi
  101d27:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
  101d2d:	4c 8b 8b f0 05 00 00 	mov    0x5f0(%rbx),%r9
  101d34:	50                   	push   %rax
  101d35:	48 8b 85 e8 f4 ff ff 	mov    -0xb18(%rbp),%rax
  101d3c:	4c 8b 83 e0 05 00 00 	mov    0x5e0(%rbx),%r8
  101d43:	41 54                	push   %r12
  101d45:	ff b3 f0 35 00 00    	push   0x35f0(%rbx)
  101d4b:	ff b3 d0 35 00 00    	push   0x35d0(%rbx)
  101d51:	ff b3 b0 35 00 00    	push   0x35b0(%rbx)
  101d57:	ff b3 90 35 00 00    	push   0x3590(%rbx)
  101d5d:	ff b3 70 35 00 00    	push   0x3570(%rbx)
  101d63:	ff b3 30 06 00 00    	push   0x630(%rbx)
  101d69:	ff b3 20 06 00 00    	push   0x620(%rbx)
  101d6f:	ff b3 00 06 00 00    	push   0x600(%rbx)
  101d75:	48 8b 38             	mov    (%rax),%rdi
  101d78:	e8 d3 8c f6 ff       	call   6aa50 <synreal::kernel::update_joint_drive_angle_state(glm::vec<3, float, (glm::qualifier)0> const*, float*, int*, glm::vec<4, int, (glm::qualifier)0> const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, unsigned long, unsigned long, unsigned long)@plt>
  101d7d:	48 83 c4 60          	add    $0x60,%rsp
  101d81:	e9 d4 f8 ff ff       	jmp    10165a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x65fa>
  101d86:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  101d8d:	00 00 00 
  101d90:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  101d97:	48 8b b5 60 f4 ff ff 	mov    -0xba0(%rbp),%rsi
  101d9e:	b9 27 00 00 00       	mov    $0x27,%ecx
  101da3:	48 89 e7             	mov    %rsp,%rdi
  101da6:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
  101da9:	e8 12 8b f6 ff       	call   6a8c0 <synreal::kernel::snapshot_hard_contacts(synreal::kernel::HardContactView)@plt>
  101dae:	48 81 c4 40 01 00 00 	add    $0x140,%rsp
  101db5:	e9 03 f8 ff ff       	jmp    1015bd <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x655d>
  101dba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  101dc0:	8b 83 6c 05 00 00    	mov    0x56c(%rbx),%eax
  101dc6:	48 83 ec 08          	sub    $0x8,%rsp
  101dca:	48 8b 8b b0 34 00 00 	mov    0x34b0(%rbx),%rcx
  101dd1:	48 8b 93 70 05 00 00 	mov    0x570(%rbx),%rdx
  101dd8:	48 8b b3 d0 03 00 00 	mov    0x3d0(%rbx),%rsi
  101ddf:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
  101de5:	f3 0f 10 85 3c f5 ff 	movss  -0xac4(%rbp),%xmm0
  101dec:	ff 
  101ded:	50                   	push   %rax
  101dee:	8b 83 68 05 00 00    	mov    0x568(%rbx),%eax
  101df4:	4c 8b 8b f0 34 00 00 	mov    0x34f0(%rbx),%r9
  101dfb:	4c 8b 83 d0 34 00 00 	mov    0x34d0(%rbx),%r8
  101e02:	50                   	push   %rax
  101e03:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
  101e0a:	ff b5 98 f5 ff ff    	push   -0xa68(%rbp)
  101e10:	41 54                	push   %r12
  101e12:	ff b3 30 35 00 00    	push   0x3530(%rbx)
  101e18:	ff b3 50 35 00 00    	push   0x3550(%rbx)
  101e1e:	ff b3 10 35 00 00    	push   0x3510(%rbx)
  101e24:	ff b3 b0 05 00 00    	push   0x5b0(%rbx)
  101e2a:	ff b3 a0 05 00 00    	push   0x5a0(%rbx)
  101e30:	ff b3 90 05 00 00    	push   0x590(%rbx)
  101e36:	48 8b 38             	mov    (%rax),%rdi
  101e39:	e8 e2 8c f6 ff       	call   6ab20 <synreal::kernel::evaluate_joint_body_point_line_augmented_lagrangian_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
  101e3e:	48 83 c4 60          	add    $0x60,%rsp
  101e42:	e9 87 f1 ff ff       	jmp    100fce <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5f6e>
  101e47:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  101e4e:	00 00 
  101e50:	8b 83 9c 04 00 00    	mov    0x49c(%rbx),%eax
  101e56:	48 8b 8b b0 04 00 00 	mov    0x4b0(%rbx),%rcx
  101e5d:	48 8b 93 a0 04 00 00 	mov    0x4a0(%rbx),%rdx
  101e64:	48 8b b3 d0 03 00 00 	mov    0x3d0(%rbx),%rsi
  101e6b:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
  101e71:	f3 0f 10 85 3c f5 ff 	movss  -0xac4(%rbp),%xmm0
  101e78:	ff 
  101e79:	50                   	push   %rax
  101e7a:	8b 83 98 04 00 00    	mov    0x498(%rbx),%eax
  101e80:	50                   	push   %rax
  101e81:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
  101e88:	ff b5 58 f4 ff ff    	push   -0xba8(%rbp)
  101e8e:	41 54                	push   %r12
  101e90:	ff b3 10 34 00 00    	push   0x3410(%rbx)
  101e96:	4c 8b 83 c0 04 00 00 	mov    0x4c0(%rbx),%r8
  101e9d:	48 8b 38             	mov    (%rax),%rdi
  101ea0:	ff b3 d0 04 00 00    	push   0x4d0(%rbx)
  101ea6:	ff b3 f0 33 00 00    	push   0x33f0(%rbx)
  101eac:	4c 8b 8b d0 33 00 00 	mov    0x33d0(%rbx),%r9
  101eb3:	e8 b8 89 f6 ff       	call   6a870 <synreal::kernel::evaluate_joint_body_spring_augmented_lagrangian_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
  101eb8:	48 83 c4 40          	add    $0x40,%rsp
  101ebc:	e9 8d f0 ff ff       	jmp    100f4e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5eee>
  101ec1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  101ec8:	48 8b 85 68 f4 ff ff 	mov    -0xb98(%rbp),%rax
  101ecf:	4c 8b 8d 60 f5 ff ff 	mov    -0xaa0(%rbp),%r9
  101ed6:	4c 8b 83 c0 2d 00 00 	mov    0x2dc0(%rbx),%r8
  101edd:	48 8b 48 20          	mov    0x20(%rax),%rcx
  101ee1:	48 8b 50 28          	mov    0x28(%rax),%rdx
  101ee5:	48 8b 78 10          	mov    0x10(%rax),%rdi
  101ee9:	48 8b 30             	mov    (%rax),%rsi
  101eec:	e8 0f 8a f6 ff       	call   6a900 <synreal::kernel::initialize_block_non_diagonal(synreal::NonZeroEntry const*, int const*, unsigned long, unsigned long, synreal::BlockNonZeroEntry*, unsigned long)@plt>
  101ef1:	e9 60 f2 ff ff       	jmp    101156 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x60f6>
  101ef6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  101efd:	00 00 00 
  101f00:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  101f07:	48 8b b5 60 f4 ff ff 	mov    -0xba0(%rbp),%rsi
  101f0e:	b9 27 00 00 00       	mov    $0x27,%ecx
  101f13:	48 89 e7             	mov    %rsp,%rdi
  101f16:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
  101f19:	e8 72 8e f6 ff       	call   6ad90 <synreal::kernel::initialize_hard_contacts(synreal::kernel::HardContactView)@plt>
  101f1e:	48 81 c4 40 01 00 00 	add    $0x140,%rsp
  101f25:	e9 ea f5 ff ff       	jmp    101514 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x64b4>
  101f2a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  101f30:	48 8b 8b 20 2e 00 00 	mov    0x2e20(%rbx),%rcx
  101f37:	48 8b 93 e0 2c 00 00 	mov    0x2ce0(%rbx),%rdx
  101f3e:	48 8b b3 c0 2c 00 00 	mov    0x2cc0(%rbx),%rsi
  101f45:	48 8b bb a0 03 00 00 	mov    0x3a0(%rbx),%rdi
  101f4c:	4c 8b 8d 58 f5 ff ff 	mov    -0xaa8(%rbp),%r9
  101f53:	4c 8b 83 40 2e 00 00 	mov    0x2e40(%rbx),%r8
  101f5a:	e8 81 8e f6 ff       	call   6ade0 <synreal::kernel::refresh_inertial_cache_diagonals(float const*, unsigned long const*, int const*, float*, float*, unsigned long)@plt>
  101f5f:	e9 9b f8 ff ff       	jmp    1017ff <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x679f>
  101f64:	0f 1f 40 00          	nopl   0x0(%rax)
  101f68:	48 83 ec 08          	sub    $0x8,%rsp
  101f6c:	48 8b b3 a8 32 00 00 	mov    0x32a8(%rbx),%rsi
  101f73:	48 8b bb 60 30 00 00 	mov    0x3060(%rbx),%rdi
  101f7a:	48 8b 8b 08 33 00 00 	mov    0x3308(%rbx),%rcx
  101f81:	48 8b 93 e8 32 00 00 	mov    0x32e8(%rbx),%rdx
  101f88:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
  101f8e:	4c 8b 8d 70 f5 ff ff 	mov    -0xa90(%rbp),%r9
  101f95:	4c 8b 85 78 f5 ff ff 	mov    -0xa88(%rbp),%r8
  101f9c:	e8 5f 8b f6 ff       	call   6ab00 <synreal::kernel::initialize_triangle_drag(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, float*, unsigned long, unsigned long, unsigned long)@plt>
  101fa1:	5e                   	pop    %rsi
  101fa2:	5f                   	pop    %rdi
  101fa3:	e9 c7 f7 ff ff       	jmp    10176f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x670f>
  101fa8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  101faf:	00 
  101fb0:	8b 83 f0 04 00 00    	mov    0x4f0(%rbx),%eax
  101fb6:	48 83 ec 08          	sub    $0x8,%rsp
  101fba:	48 8b 8b 08 05 00 00 	mov    0x508(%rbx),%rcx
  101fc1:	48 8b 93 f8 04 00 00 	mov    0x4f8(%rbx),%rdx
  101fc8:	48 8b b3 d0 03 00 00 	mov    0x3d0(%rbx),%rsi
  101fcf:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
  101fd5:	50                   	push   %rax
  101fd6:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
  101fdd:	ff b5 80 f4 ff ff    	push   -0xb80(%rbp)
  101fe3:	ff b3 90 34 00 00    	push   0x3490(%rbx)
  101fe9:	ff b3 70 34 00 00    	push   0x3470(%rbx)
  101fef:	4c 8b 83 18 05 00 00 	mov    0x518(%rbx),%r8
  101ff6:	ff b3 58 05 00 00    	push   0x558(%rbx)
  101ffc:	48 8b 38             	mov    (%rax),%rdi
  101fff:	ff b3 50 34 00 00    	push   0x3450(%rbx)
  102005:	4c 8b 8b 30 34 00 00 	mov    0x3430(%rbx),%r9
  10200c:	e8 ef 8c f6 ff       	call   6ad00 <synreal::kernel::initialize_body_distance_constraint_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  102011:	48 83 c4 40          	add    $0x40,%rsp
  102015:	e9 cd f6 ff ff       	jmp    1016e7 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6687>
  10201a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  102020:	f3 0f 10 43 60       	movss  0x60(%rbx),%xmm0
  102025:	8b 8b 00 04 00 00    	mov    0x400(%rbx),%ecx
  10202b:	45 31 c9             	xor    %r9d,%r9d
  10202e:	48 8b 93 40 31 00 00 	mov    0x3140(%rbx),%rdx
  102035:	48 8b b3 20 31 00 00 	mov    0x3120(%rbx),%rsi
  10203c:	48 8b bb 38 04 00 00 	mov    0x438(%rbx),%rdi
  102043:	f3 0f 10 63 70       	movss  0x70(%rbx),%xmm4
  102048:	6a 00                	push   $0x0
  10204a:	f3 0f 10 5b 6c       	movss  0x6c(%rbx),%xmm3
  10204f:	f3 0f 10 53 68       	movss  0x68(%rbx),%xmm2
  102054:	6a 01                	push   $0x1
  102056:	f3 0f 10 4b 64       	movss  0x64(%rbx),%xmm1
  10205b:	4c 8b 85 90 f5 ff ff 	mov    -0xa70(%rbp),%r8
  102062:	e8 19 8a f6 ff       	call   6aa80 <synreal::kernel::prepare_cable_penalties(glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0>*, int*, unsigned long, unsigned long, float, float, float, float, float, bool, bool, int const*)@plt>
  102067:	41 59                	pop    %r9
  102069:	41 5a                	pop    %r10
  10206b:	e9 68 f1 ff ff       	jmp    1011d8 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6178>
  102070:	ff b5 a8 f4 ff ff    	push   -0xb58(%rbp)
  102076:	b9 27 00 00 00       	mov    $0x27,%ecx
  10207b:	4d 89 e9             	mov    %r13,%r9
  10207e:	31 d2                	xor    %edx,%edx
  102080:	48 8b b5 68 f8 ff ff 	mov    -0x798(%rbp),%rsi
  102087:	48 81 ec 38 01 00 00 	sub    $0x138,%rsp
  10208e:	48 89 e7             	mov    %rsp,%rdi
  102091:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
  102094:	31 f6                	xor    %esi,%esi
  102096:	31 ff                	xor    %edi,%edi
  102098:	4c 8b 85 90 f4 ff ff 	mov    -0xb70(%rbp),%r8
  10209f:	e8 dc 8d f6 ff       	call   6ae80 <synreal::kernel::evaluate_hard_contacts(synreal::kernel::HardContactView, glm::vec<3, float, (glm::qualifier)0>*, float*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, float*)@plt>
  1020a4:	48 81 c4 40 01 00 00 	add    $0x140,%rsp
  1020ab:	e9 cf f7 ff ff       	jmp    10187f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x681f>
  1020b0:	c6 85 c0 f4 ff ff 01 	movb   $0x1,-0xb40(%rbp)
  1020b7:	41 bd 01 00 00 00    	mov    $0x1,%r13d
  1020bd:	e9 de 9f ff ff       	jmp    fc0a0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1040>
  1020c2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  1020c8:	48 8d bd 50 fd ff ff 	lea    -0x2b0(%rbp),%rdi
  1020cf:	31 c0                	xor    %eax,%eax
  1020d1:	b9 27 00 00 00       	mov    $0x27,%ecx
  1020d6:	c6 85 28 f5 ff ff 01 	movb   $0x1,-0xad8(%rbp)
  1020dd:	48 89 bd 60 f4 ff ff 	mov    %rdi,-0xba0(%rbp)
  1020e4:	f3 48 ab             	rep stos %rax,%es:(%rdi)
  1020e7:	48 8b 05 aa 5e 0f 00 	mov    0xf5eaa(%rip),%rax        # 1f7f98 <cuda::std::__4::in_place+0x4b>
  1020ee:	c7 85 3c fe ff ff 33 	movl   $0x3f733333,-0x1c4(%rbp)
  1020f5:	33 73 3f 
  1020f8:	c6 85 4e fe ff ff 01 	movb   $0x1,-0x1b2(%rbp)
  1020ff:	48 89 85 44 fe ff ff 	mov    %rax,-0x1bc(%rbp)
  102106:	89 f0                	mov    %esi,%eax
  102108:	48 3b 83 70 31 00 00 	cmp    0x3170(%rbx),%rax
  10210f:	0f 87 0b 06 00 00    	ja     102720 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x76c0>
  102115:	48 8d 8d 00 fb ff ff 	lea    -0x500(%rbp),%rcx
  10211c:	48 89 8d 48 f4 ff ff 	mov    %rcx,-0xbb8(%rbp)
  102123:	f3 41 0f 6f 7e 40    	movdqu 0x40(%r14),%xmm7
  102129:	f3 41 0f 6f 76 60    	movdqu 0x60(%r14),%xmm6
  10212f:	48 89 85 58 fd ff ff 	mov    %rax,-0x2a8(%rbp)
  102136:	f3 41 0f 6f 5e 30    	movdqu 0x30(%r14),%xmm3
  10213c:	f3 41 0f 6f 56 50    	movdqu 0x50(%r14),%xmm2
  102142:	f3 41 0f 6f ae 80 00 	movdqu 0x80(%r14),%xmm5
  102149:	00 00 
  10214b:	f3 41 0f 6f 4e 70    	movdqu 0x70(%r14),%xmm1
  102151:	66 0f 6d d6          	punpckhqdq %xmm6,%xmm2
  102155:	f3 41 0f 6f 66 10    	movdqu 0x10(%r14),%xmm4
  10215b:	66 0f 6d df          	punpckhqdq %xmm7,%xmm3
  10215f:	f3 41 0f 6f 76 20    	movdqu 0x20(%r14),%xmm6
  102165:	f3 41 0f 6f be a0 00 	movdqu 0xa0(%r14),%xmm7
  10216c:	00 00 
  10216e:	66 0f 6d cd          	punpckhqdq %xmm5,%xmm1
  102172:	49 8b 0e             	mov    (%r14),%rcx
  102175:	0f 29 95 80 fd ff ff 	movaps %xmm2,-0x280(%rbp)
  10217c:	f3 41 0f 6f 86 90 00 	movdqu 0x90(%r14),%xmm0
  102183:	00 00 
  102185:	f3 0f 6f ab 40 07 00 	movdqu 0x740(%rbx),%xmm5
  10218c:	00 
  10218d:	66 0f 6d e6          	punpckhqdq %xmm6,%xmm4
  102191:	0f 29 8d 90 fd ff ff 	movaps %xmm1,-0x270(%rbp)
  102198:	f3 0f 6f 8b 30 07 00 	movdqu 0x730(%rbx),%xmm1
  10219f:	00 
  1021a0:	0f 29 a5 60 fd ff ff 	movaps %xmm4,-0x2a0(%rbp)
  1021a7:	f3 0f 6f a3 60 07 00 	movdqu 0x760(%rbx),%xmm4
  1021ae:	00 
  1021af:	66 0f 6d c7          	punpckhqdq %xmm7,%xmm0
  1021b3:	48 8b 83 88 07 00 00 	mov    0x788(%rbx),%rax
  1021ba:	f3 0f 6f bb 20 07 00 	movdqu 0x720(%rbx),%xmm7
  1021c1:	00 
  1021c2:	48 89 8d 50 fd ff ff 	mov    %rcx,-0x2b0(%rbp)
  1021c9:	0f 29 85 a0 fd ff ff 	movaps %xmm0,-0x260(%rbp)
  1021d0:	f3 0f 6f 83 50 07 00 	movdqu 0x750(%rbx),%xmm0
  1021d7:	00 
  1021d8:	66 0f 6d cd          	punpckhqdq %xmm5,%xmm1
  1021dc:	f3 0f 6f 93 10 07 00 	movdqu 0x710(%rbx),%xmm2
  1021e3:	00 
  1021e4:	0f 29 8d c0 fd ff ff 	movaps %xmm1,-0x240(%rbp)
  1021eb:	66 0f 6e 8d 38 f5 ff 	movd   -0xac8(%rbp),%xmm1
  1021f2:	ff 
  1021f3:	66 0f 6d c4          	punpckhqdq %xmm4,%xmm0
  1021f7:	48 89 85 e0 fd ff ff 	mov    %rax,-0x220(%rbp)
  1021fe:	48 8b 85 80 f5 ff ff 	mov    -0xa80(%rbp),%rax
  102205:	66 0f 6d d7          	punpckhqdq %xmm7,%xmm2
  102209:	0f 29 85 d0 fd ff ff 	movaps %xmm0,-0x230(%rbp)
  102210:	66 41 0f 6e c1       	movd   %r9d,%xmm0
  102215:	66 0f 6c c1          	punpcklqdq %xmm1,%xmm0
  102219:	0f 29 95 b0 fd ff ff 	movaps %xmm2,-0x250(%rbp)
  102220:	0f 11 85 e8 fd ff ff 	movups %xmm0,-0x218(%rbp)
  102227:	0f 29 9d 70 fd ff ff 	movaps %xmm3,-0x290(%rbp)
  10222e:	48 89 85 f8 fd ff ff 	mov    %rax,-0x208(%rbp)
  102235:	48 8b 83 e0 03 00 00 	mov    0x3e0(%rbx),%rax
  10223c:	f3 0f 6f 83 f0 03 00 	movdqu 0x3f0(%rbx),%xmm0
  102243:	00 
  102244:	f3 0f 6f b3 d0 03 00 	movdqu 0x3d0(%rbx),%xmm6
  10224b:	00 
  10224c:	48 89 85 10 fe ff ff 	mov    %rax,-0x1f0(%rbp)
  102253:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
  10225a:	66 0f 6c c6          	punpcklqdq %xmm6,%xmm0
  10225e:	f3 0f 10 53 58       	movss  0x58(%rbx),%xmm2
  102263:	f3 0f 10 4b 54       	movss  0x54(%rbx),%xmm1
  102268:	48 8b 00             	mov    (%rax),%rax
  10226b:	0f 29 85 00 fe ff ff 	movaps %xmm0,-0x200(%rbp)
  102272:	66 0f 6e c2          	movd   %edx,%xmm0
  102276:	f3 0f 6f ab 80 31 00 	movdqu 0x3180(%rbx),%xmm5
  10227d:	00 
  10227e:	0f 16 85 58 f5 ff ff 	movhps -0xaa8(%rbp),%xmm0
  102285:	0f 14 ca             	unpcklps %xmm2,%xmm1
  102288:	f3 0f 10 53 50       	movss  0x50(%rbx),%xmm2
  10228d:	f3 0f 6f a3 c0 31 00 	movdqu 0x31c0(%rbx),%xmm4
  102294:	00 
  102295:	0f 11 85 18 fe ff ff 	movups %xmm0,-0x1e8(%rbp)
  10229c:	66 48 0f 6e c0       	movq   %rax,%xmm0
  1022a1:	0f 16 83 60 30 00 00 	movhps 0x3060(%rbx),%xmm0
  1022a8:	48 89 85 c8 f4 ff ff 	mov    %rax,-0xb38(%rbp)
  1022af:	31 c0                	xor    %eax,%eax
  1022b1:	8a 43 4d             	mov    0x4d(%rbx),%al
  1022b4:	0f 11 85 28 fe ff ff 	movups %xmm0,-0x1d8(%rbp)
  1022bb:	f3 0f 10 05 bd 5c 0f 	movss  0xf5cbd(%rip),%xmm0        # 1f7f80 <cuda::std::__4::in_place+0x33>
  1022c2:	00 
  1022c3:	8a 63 4e             	mov    0x4e(%rbx),%ah
  1022c6:	f3 0f 5e 85 1c f5 ff 	divss  -0xae4(%rbp),%xmm0
  1022cd:	ff 
  1022ce:	0f 14 c2             	unpcklps %xmm2,%xmm0
  1022d1:	0f 16 c1             	movlhps %xmm1,%xmm0
  1022d4:	66 89 85 4c fe ff ff 	mov    %ax,-0x1b4(%rbp)
  1022db:	41 0f b6 86 b8 00 00 	movzbl 0xb8(%r14),%eax
  1022e2:	00 
  1022e3:	0f 11 85 38 fe ff ff 	movups %xmm0,-0x1c8(%rbp)
  1022ea:	f3 0f 10 43 5c       	movss  0x5c(%rbx),%xmm0
  1022ef:	88 85 4e fe ff ff    	mov    %al,-0x1b2(%rbp)
  1022f5:	f3 0f 11 85 48 fe ff 	movss  %xmm0,-0x1b8(%rbp)
  1022fc:	ff 
  1022fd:	f3 0f 6f 83 60 31 00 	movdqu 0x3160(%rbx),%xmm0
  102304:	00 
  102305:	66 0f 6c c5          	punpcklqdq %xmm5,%xmm0
  102309:	0f 29 85 50 fe ff ff 	movaps %xmm0,-0x1b0(%rbp)
  102310:	f3 0f 6f 83 a0 31 00 	movdqu 0x31a0(%rbx),%xmm0
  102317:	00 
  102318:	66 0f 6c c4          	punpcklqdq %xmm4,%xmm0
  10231c:	0f 29 85 60 fe ff ff 	movaps %xmm0,-0x1a0(%rbp)
  102323:	f3 0f 6f 83 e0 31 00 	movdqu 0x31e0(%rbx),%xmm0
  10232a:	00 
  10232b:	f3 0f 6f bb 00 32 00 	movdqu 0x3200(%rbx),%xmm7
  102332:	00 
  102333:	48 8b 83 20 32 00 00 	mov    0x3220(%rbx),%rax
  10233a:	66 0f 6c c7          	punpcklqdq %xmm7,%xmm0
  10233e:	48 89 85 80 fe ff ff 	mov    %rax,-0x180(%rbp)
  102345:	0f 29 85 70 fe ff ff 	movaps %xmm0,-0x190(%rbp)
  10234c:	e9 17 94 ff ff       	jmp    fb768 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x708>
  102351:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  102358:	bf 01 00 00 00       	mov    $0x1,%edi
  10235d:	e9 81 9c ff ff       	jmp    fbfe3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf83>
  102362:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  102368:	48 8b 05 21 5c 0f 00 	mov    0xf5c21(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  10236f:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
  102376:	c7 85 c8 f9 ff ff 01 	movl   $0x1,-0x638(%rbp)
  10237d:	00 00 00 
  102380:	48 89 85 c0 f9 ff ff 	mov    %rax,-0x640(%rbp)
  102387:	e8 d4 a9 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  10238c:	8b 8d c8 f9 ff ff    	mov    -0x638(%rbp),%ecx
  102392:	45 31 c0             	xor    %r8d,%r8d
  102395:	4d 89 e1             	mov    %r12,%r9
  102398:	89 85 60 fa ff ff    	mov    %eax,-0x5a0(%rbp)
  10239e:	48 8b 95 c0 f9 ff ff 	mov    -0x640(%rbp),%rdx
  1023a5:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
  1023ac:	00 00 00 
  1023af:	48 89 85 64 fa ff ff 	mov    %rax,-0x59c(%rbp)
  1023b6:	48 8b bd 60 fa ff ff 	mov    -0x5a0(%rbp),%rdi
  1023bd:	8b b5 68 fa ff ff    	mov    -0x598(%rbp),%esi
  1023c3:	e8 e8 cb f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
  1023c8:	85 c0                	test   %eax,%eax
  1023ca:	75 7e                	jne    10244a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x73ea>
  1023cc:	83 bd e4 f4 ff ff 01 	cmpl   $0x1,-0xb1c(%rbp)
  1023d3:	4c 8b 9b b0 2d 00 00 	mov    0x2db0(%rbx),%r11
  1023da:	66 0f ef e4          	pxor   %xmm4,%xmm4
  1023de:	4c 8b 93 a0 2d 00 00 	mov    0x2da0(%rbx),%r10
  1023e5:	48 8b 83 80 2d 00 00 	mov    0x2d80(%rbx),%rax
  1023ec:	4c 8b 8b 60 2d 00 00 	mov    0x2d60(%rbx),%r9
  1023f3:	4c 8b 83 40 2d 00 00 	mov    0x2d40(%rbx),%r8
  1023fa:	48 8b 8b 20 2d 00 00 	mov    0x2d20(%rbx),%rcx
  102401:	48 8b 93 00 2d 00 00 	mov    0x2d00(%rbx),%rdx
  102408:	48 8b b3 20 2c 00 00 	mov    0x2c20(%rbx),%rsi
  10240f:	48 8b bb 00 2c 00 00 	mov    0x2c00(%rbx),%rdi
  102416:	f3 0f 10 5b 0c       	movss  0xc(%rbx),%xmm3
  10241b:	0f 85 28 04 00 00    	jne    102849 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x77e9>
  102421:	48 83 ec 08          	sub    $0x8,%rsp
  102425:	f3 0f 10 8d f0 f4 ff 	movss  -0xb10(%rbp),%xmm1
  10242c:	ff 
  10242d:	0f 28 eb             	movaps %xmm3,%xmm5
  102430:	66 0f ef d2          	pxor   %xmm2,%xmm2
  102434:	41 53                	push   %r11
  102436:	f3 0f 10 85 34 f5 ff 	movss  -0xacc(%rbp),%xmm0
  10243d:	ff 
  10243e:	41 52                	push   %r10
  102440:	50                   	push   %rax
  102441:	e8 da 87 f6 ff       	call   6ac20 <synreal::kernel::combine_system_non_diagonal(float, float, float, float, float, float, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry*, unsigned long)@plt>
  102446:	48 83 c4 20          	add    $0x20,%rsp
  10244a:	e8 41 a4 f6 ff       	call   6c890 <cudaGetLastError@plt>
  10244f:	48 8d 35 ba 2c 0f 00 	lea    0xf2cba(%rip),%rsi        # 1f5110 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5210>
  102456:	89 c7                	mov    %eax,%edi
  102458:	e8 a3 b8 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  10245d:	e9 2e e7 ff ff       	jmp    100b90 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x5b30>
  102462:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  102468:	48 8b bb 20 32 00 00 	mov    0x3220(%rbx),%rdi
  10246f:	4c 89 e1             	mov    %r12,%rcx
  102472:	ba 04 00 00 00       	mov    $0x4,%edx
  102477:	31 f6                	xor    %esi,%esi
  102479:	e8 b2 c4 f6 ff       	call   6e930 <cudaMemsetAsync@plt>
  10247e:	89 c7                	mov    %eax,%edi
  102480:	48 8d 35 a1 37 0f 00 	lea    0xf37a1(%rip),%rsi        # 1f5c28 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x5d28>
  102487:	e8 74 b8 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  10248c:	e9 3f f1 ff ff       	jmp    1015d0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6570>
  102491:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  102498:	48 83 ec 08          	sub    $0x8,%rsp
  10249c:	48 8b 8b a0 03 00 00 	mov    0x3a0(%rbx),%rcx
  1024a3:	48 8b 93 60 2c 00 00 	mov    0x2c60(%rbx),%rdx
  1024aa:	48 8b b3 40 2c 00 00 	mov    0x2c40(%rbx),%rsi
  1024b1:	48 8b bb e8 00 00 00 	mov    0xe8(%rbx),%rdi
  1024b8:	ff b3 30 2c 00 00    	push   0x2c30(%rbx)
  1024be:	4c 8b 8b a0 2c 00 00 	mov    0x2ca0(%rbx),%r9
  1024c5:	ff b3 00 2d 00 00    	push   0x2d00(%rbx)
  1024cb:	4c 8b 83 80 2c 00 00 	mov    0x2c80(%rbx),%r8
  1024d2:	ff b3 20 2c 00 00    	push   0x2c20(%rbx)
  1024d8:	e8 83 84 f6 ff       	call   6a960 <synreal::kernel::refresh_inertial_cache_nonzeros(float const*, unsigned long const*, int const*, float const*, unsigned long const*, int const*, synreal::NonZeroEntry*, synreal::NonZeroEntry*, unsigned long)@plt>
  1024dd:	48 83 c4 20          	add    $0x20,%rsp
  1024e1:	e9 ed 97 ff ff       	jmp    fbcd3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xc73>
  1024e6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  1024ed:	00 00 00 
  1024f0:	48 8b 85 70 f8 ff ff 	mov    -0x790(%rbp),%rax
  1024f7:	48 8b bd 58 f8 ff ff 	mov    -0x7a8(%rbp),%rdi
  1024fe:	48 83 ec 08          	sub    $0x8,%rsp
  102502:	48 8b 95 90 f8 ff ff 	mov    -0x770(%rbp),%rdx
  102509:	4c 8b 95 98 f8 ff ff 	mov    -0x768(%rbp),%r10
  102510:	4c 8b 4f 48          	mov    0x48(%rdi),%r9
  102514:	4c 8b 47 38          	mov    0x38(%rdi),%r8
  102518:	48 8b 4f 28          	mov    0x28(%rdi),%rcx
  10251c:	8b 77 10             	mov    0x10(%rdi),%esi
  10251f:	f3 0f 10 40 48       	movss  0x48(%rax),%xmm0
  102524:	f3 0f 10 0d 54 5a 0f 	movss  0xf5a54(%rip),%xmm1        # 1f7f80 <cuda::std::__4::in_place+0x33>
  10252b:	00 
  10252c:	f3 0f 5e 0a          	divss  (%rdx),%xmm1
  102530:	48 8b 57 18          	mov    0x18(%rdi),%rdx
  102534:	41 55                	push   %r13
  102536:	ff b5 90 f4 ff ff    	push   -0xb70(%rbp)
  10253c:	41 ff 32             	push   (%r10)
  10253f:	4c 8b 95 88 f8 ff ff 	mov    -0x778(%rbp),%r10
  102546:	6a 00                	push   $0x0
  102548:	6a 00                	push   $0x0
  10254a:	ff b0 60 30 00 00    	push   0x3060(%rax)
  102550:	41 ff 32             	push   (%r10)
  102553:	44 8b 90 98 03 00 00 	mov    0x398(%rax),%r10d
  10255a:	41 52                	push   %r10
  10255c:	ff b0 e0 03 00 00    	push   0x3e0(%rax)
  102562:	ff b0 d0 03 00 00    	push   0x3d0(%rax)
  102568:	ff b0 f0 03 00 00    	push   0x3f0(%rax)
  10256e:	4c 8b 95 80 f8 ff ff 	mov    -0x780(%rbp),%r10
  102575:	41 ff 32             	push   (%r10)
  102578:	4c 8b 95 78 f8 ff ff 	mov    -0x788(%rbp),%r10
  10257f:	45 8b 12             	mov    (%r10),%r10d
  102582:	41 52                	push   %r10
  102584:	44 8b 90 10 07 00 00 	mov    0x710(%rax),%r10d
  10258b:	41 52                	push   %r10
  10258d:	ff b0 88 07 00 00    	push   0x788(%rax)
  102593:	ff b0 78 07 00 00    	push   0x778(%rax)
  102599:	ff b0 68 07 00 00    	push   0x768(%rax)
  10259f:	ff b0 58 07 00 00    	push   0x758(%rax)
  1025a5:	ff b0 48 07 00 00    	push   0x748(%rax)
  1025ab:	ff b0 38 07 00 00    	push   0x738(%rax)
  1025b1:	ff b0 28 07 00 00    	push   0x728(%rax)
  1025b7:	ff b0 18 07 00 00    	push   0x718(%rax)
  1025bd:	ff b7 98 00 00 00    	push   0x98(%rdi)
  1025c3:	ff b7 88 00 00 00    	push   0x88(%rdi)
  1025c9:	ff 77 78             	push   0x78(%rdi)
  1025cc:	ff 77 68             	push   0x68(%rdi)
  1025cf:	ff 77 58             	push   0x58(%rdi)
  1025d2:	48 8b 3f             	mov    (%rdi),%rdi
  1025d5:	e8 f6 88 f6 ff       	call   6aed0 <synreal::kernel::evaluate_contact_tangent(int const*, unsigned long, int const*, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, int const*, int const*, synreal::Transform const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float const*, float const*, float, unsigned long, unsigned long, unsigned long, int const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, unsigned long, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, float, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  1025da:	48 81 c4 e0 00 00 00 	add    $0xe0,%rsp
  1025e1:	e9 2a df ff ff       	jmp    100510 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x54b0>
  1025e6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  1025ed:	00 00 00 
  1025f0:	c6 85 30 f5 ff ff 00 	movb   $0x0,-0xad0(%rbp)
  1025f7:	45 31 ed             	xor    %r13d,%r13d
  1025fa:	31 d2                	xor    %edx,%edx
  1025fc:	bf 01 00 00 00       	mov    $0x1,%edi
  102601:	e9 eb 99 ff ff       	jmp    fbff1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf91>
  102606:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  10260d:	00 00 00 
  102610:	48 8b 05 79 59 0f 00 	mov    0xf5979(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  102617:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
  10261e:	c7 85 c8 f9 ff ff 01 	movl   $0x1,-0x638(%rbp)
  102625:	00 00 00 
  102628:	48 89 85 c0 f9 ff ff 	mov    %rax,-0x640(%rbp)
  10262f:	e8 2c a7 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  102634:	8b 8d c8 f9 ff ff    	mov    -0x638(%rbp),%ecx
  10263a:	45 31 c0             	xor    %r8d,%r8d
  10263d:	4d 89 e1             	mov    %r12,%r9
  102640:	89 85 60 fa ff ff    	mov    %eax,-0x5a0(%rbp)
  102646:	48 8b 95 c0 f9 ff ff 	mov    -0x640(%rbp),%rdx
  10264d:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
  102654:	00 00 00 
  102657:	48 89 85 64 fa ff ff 	mov    %rax,-0x59c(%rbp)
  10265e:	48 8b bd 60 fa ff ff 	mov    -0x5a0(%rbp),%rdi
  102665:	8b b5 68 fa ff ff    	mov    -0x598(%rbp),%esi
  10266b:	e8 40 c9 f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
  102670:	85 c0                	test   %eax,%eax
  102672:	0f 84 1c 02 00 00    	je     102894 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7834>
  102678:	e8 13 a2 f6 ff       	call   6c890 <cudaGetLastError@plt>
  10267d:	48 8d 35 54 2a 0f 00 	lea    0xf2a54(%rip),%rsi        # 1f50d8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x51d8>
  102684:	89 c7                	mov    %eax,%edi
  102686:	e8 75 b6 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  10268b:	e9 31 99 ff ff       	jmp    fbfc1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf61>
  102690:	48 8b 05 f9 58 0f 00 	mov    0xf58f9(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
  102697:	48 8b bd 58 f4 ff ff 	mov    -0xba8(%rbp),%rdi
  10269e:	c7 85 c8 f9 ff ff 01 	movl   $0x1,-0x638(%rbp)
  1026a5:	00 00 00 
  1026a8:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
  1026af:	48 89 85 c0 f9 ff ff 	mov    %rax,-0x640(%rbp)
  1026b6:	e8 a5 a6 f6 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
  1026bb:	8b 8d c8 f9 ff ff    	mov    -0x638(%rbp),%ecx
  1026c1:	45 31 c0             	xor    %r8d,%r8d
  1026c4:	4d 89 e1             	mov    %r12,%r9
  1026c7:	89 85 60 fa ff ff    	mov    %eax,-0x5a0(%rbp)
  1026cd:	48 8b 95 c0 f9 ff ff 	mov    -0x640(%rbp),%rdx
  1026d4:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
  1026db:	00 00 00 
  1026de:	48 89 85 64 fa ff ff 	mov    %rax,-0x59c(%rbp)
  1026e5:	48 8b bd 60 fa ff ff 	mov    -0x5a0(%rbp),%rdi
  1026ec:	8b b5 68 fa ff ff    	mov    -0x598(%rbp),%esi
  1026f2:	e8 b9 c8 f6 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
  1026f7:	85 c0                	test   %eax,%eax
  1026f9:	0f 84 0c 02 00 00    	je     10290b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x78ab>
  1026ff:	e8 8c a1 f6 ff       	call   6c890 <cudaGetLastError@plt>
  102704:	48 8d 35 9d 29 0f 00 	lea    0xf299d(%rip),%rsi        # 1f50a8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x51a8>
  10270b:	89 c7                	mov    %eax,%edi
  10270d:	e8 ee b5 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  102712:	e9 9a 98 ff ff       	jmp    fbfb1 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xf51>
  102717:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  10271e:	00 00 
  102720:	48 8d 85 00 fb ff ff 	lea    -0x500(%rbp),%rax
  102727:	48 8b bd 10 f5 ff ff 	mov    -0xaf0(%rbp),%rdi
  10272e:	48 89 c6             	mov    %rax,%rsi
  102731:	48 89 85 48 f4 ff ff 	mov    %rax,-0xbb8(%rbp)
  102738:	e8 d3 af f6 ff       	call   6d710 <cudaStreamIsCapturing@plt>
  10273d:	48 8d 35 1c 27 0f 00 	lea    0xf271c(%rip),%rsi        # 1f4e60 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x4f60>
  102744:	89 c7                	mov    %eax,%edi
  102746:	e8 b5 b5 f6 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
  10274b:	44 8b a5 00 fb ff ff 	mov    -0x500(%rbp),%r12d
  102752:	45 85 e4             	test   %r12d,%r12d
  102755:	0f 85 87 3e f7 ff    	jne    765e2 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]>
  10275b:	48 8b 03             	mov    (%rbx),%rax
  10275e:	41 8b 76 10          	mov    0x10(%r14),%esi
  102762:	48 89 df             	mov    %rbx,%rdi
  102765:	ff 50 18             	call   *0x18(%rax)
  102768:	41 8b 46 10          	mov    0x10(%r14),%eax
  10276c:	44 8b 8b 10 07 00 00 	mov    0x710(%rbx),%r9d
  102773:	8b 93 98 03 00 00    	mov    0x398(%rbx),%edx
  102779:	44 0f b6 85 27 f5 ff 	movzbl -0xad9(%rbp),%r8d
  102780:	ff 
  102781:	48 89 c6             	mov    %rax,%rsi
  102784:	e9 9a f9 ff ff       	jmp    102123 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x70c3>
  102789:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  102790:	f3 0f 10 43 0c       	movss  0xc(%rbx),%xmm0
  102795:	66 0f ef e4          	pxor   %xmm4,%xmm4
  102799:	44 0f b6 9d a8 f4 ff 	movzbl -0xb58(%rbp),%r11d
  1027a0:	ff 
  1027a1:	0f 2f c4             	comiss %xmm4,%xmm0
  1027a4:	41 0f 46 d3          	cmovbe %r11d,%edx
  1027a8:	88 95 f0 f4 ff ff    	mov    %dl,-0xb10(%rbp)
  1027ae:	e9 a8 98 ff ff       	jmp    fc05b <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xffb>
  1027b3:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1027b8:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
  1027bf:	e9 df b8 ff ff       	jmp    fe0a3 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3043>
  1027c4:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
  1027cb:	48 83 ec 08          	sub    $0x8,%rsp
  1027cf:	48 8b 93 80 32 00 00 	mov    0x3280(%rbx),%rdx
  1027d6:	48 8b bb 60 30 00 00 	mov    0x3060(%rbx),%rdi
  1027dd:	48 8b 70 10          	mov    0x10(%rax),%rsi
  1027e1:	ff b5 10 f9 ff ff    	push   -0x6f0(%rbp)
  1027e7:	ff b5 08 f9 ff ff    	push   -0x6f8(%rbp)
  1027ed:	ff b5 00 f9 ff ff    	push   -0x700(%rbp)
  1027f3:	ff b5 f8 f8 ff ff    	push   -0x708(%rbp)
  1027f9:	ff b5 f0 f8 ff ff    	push   -0x710(%rbp)
  1027ff:	ff b5 e8 f8 ff ff    	push   -0x718(%rbp)
  102805:	ff b5 e0 f8 ff ff    	push   -0x720(%rbp)
  10280b:	ff b5 d8 f8 ff ff    	push   -0x728(%rbp)
  102811:	ff b5 d0 f8 ff ff    	push   -0x730(%rbp)
  102817:	ff b5 c8 f8 ff ff    	push   -0x738(%rbp)
  10281d:	ff b5 c0 f8 ff ff    	push   -0x740(%rbp)
  102823:	ff b5 b8 f8 ff ff    	push   -0x748(%rbp)
  102829:	ff b5 b0 f8 ff ff    	push   -0x750(%rbp)
  10282f:	ff b5 a8 f8 ff ff    	push   -0x758(%rbp)
  102835:	ff b5 a0 f8 ff ff    	push   -0x760(%rbp)
  10283b:	e8 50 83 f6 ff       	call   6ab90 <synreal::kernel::initialize_joint_coordinate_velocities(synreal::kernel::JointCoordinateView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float*)@plt>
  102840:	48 83 ec 80          	sub    $0xffffffffffffff80,%rsp
  102844:	e9 da 96 ff ff       	jmp    fbf23 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0xec3>
  102849:	0f 28 e3             	movaps %xmm3,%xmm4
  10284c:	e9 d0 fb ff ff       	jmp    102421 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x73c1>
  102851:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
  102858:	48 83 ec 08          	sub    $0x8,%rsp
  10285c:	48 8b 93 50 33 00 00 	mov    0x3350(%rbx),%rdx
  102863:	48 8b 8b 70 33 00 00 	mov    0x3370(%rbx),%rcx
  10286a:	48 8b b3 d0 03 00 00 	mov    0x3d0(%rbx),%rsi
  102871:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
  102877:	48 8b 38             	mov    (%rax),%rdi
  10287a:	44 8b 8b 98 03 00 00 	mov    0x398(%rbx),%r9d
  102881:	4c 8b 85 88 f5 ff ff 	mov    -0xa78(%rbp),%r8
  102888:	e8 03 87 f6 ff       	call   6af90 <synreal::kernel::initialize_affine_body_so3_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)@plt>
  10288d:	58                   	pop    %rax
  10288e:	5a                   	pop    %rdx
  10288f:	e9 1c e8 ff ff       	jmp    1010b0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x6050>
  102894:	8b 83 6c 05 00 00    	mov    0x56c(%rbx),%eax
  10289a:	48 83 ec 08          	sub    $0x8,%rsp
  10289e:	48 8b 8b b0 34 00 00 	mov    0x34b0(%rbx),%rcx
  1028a5:	48 8b 93 70 05 00 00 	mov    0x570(%rbx),%rdx
  1028ac:	48 8b b3 d0 03 00 00 	mov    0x3d0(%rbx),%rsi
  1028b3:	ff b5 58 f5 ff ff    	push   -0xaa8(%rbp)
  1028b9:	4c 8b 8b f0 34 00 00 	mov    0x34f0(%rbx),%r9
  1028c0:	50                   	push   %rax
  1028c1:	8b 83 68 05 00 00    	mov    0x568(%rbx),%eax
  1028c7:	4c 8b 83 d0 34 00 00 	mov    0x34d0(%rbx),%r8
  1028ce:	50                   	push   %rax
  1028cf:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
  1028d6:	ff b5 98 f5 ff ff    	push   -0xa68(%rbp)
  1028dc:	ff b3 30 35 00 00    	push   0x3530(%rbx)
  1028e2:	ff b3 50 35 00 00    	push   0x3550(%rbx)
  1028e8:	ff b3 10 35 00 00    	push   0x3510(%rbx)
  1028ee:	ff b3 a0 05 00 00    	push   0x5a0(%rbx)
  1028f4:	ff b3 90 05 00 00    	push   0x590(%rbx)
  1028fa:	48 8b 38             	mov    (%rax),%rdi
  1028fd:	e8 be 80 f6 ff       	call   6a9c0 <synreal::kernel::initialize_joint_body_point_line_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long)@plt>
  102902:	48 83 c4 50          	add    $0x50,%rsp
  102906:	e9 6d fd ff ff       	jmp    102678 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x7618>
  10290b:	48 8b bb 10 34 00 00 	mov    0x3410(%rbx),%rdi
  102912:	48 8b b5 58 f4 ff ff 	mov    -0xba8(%rbp),%rsi
  102919:	e8 42 82 f6 ff       	call   6ab60 <synreal::kernel::initialize_joint_body_spring_state(glm::vec<3, float, (glm::qualifier)0>*, unsigned long)@plt>
  10291e:	e9 dc fd ff ff       	jmp    1026ff <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x769f>
  102923:	e8 98 ac f6 ff       	call   6d5c0 <__stack_chk_fail@plt>
  102928:	e9 88 3f f7 ff       	jmp    768b5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x2d3>
  10292d:	f3 0f 1e fa          	endbr64 
  102931:	48 89 c3             	mov    %rax,%rbx
  102934:	e9 7c 3e f7 ff       	jmp    767b5 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x1d3>
  102939:	e9 50 44 f7 ff       	jmp    76d8e <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x7ac>
  10293e:	e9 27 43 f7 ff       	jmp    76c6a <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x688>
  102943:	e9 b6 3f f7 ff       	jmp    768fe <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x31c>
  102948:	e9 d5 40 f7 ff       	jmp    76a22 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x440>
  10294d:	e9 62 41 f7 ff       	jmp    76ab4 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x4d2>
  102952:	e9 a6 41 f7 ff       	jmp    76afd <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x51b>
  102957:	e9 ea 41 f7 ff       	jmp    76b46 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x564>
  10295c:	e9 2e 42 f7 ff       	jmp    76b8f <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x5ad>
  102961:	e9 36 43 f7 ff       	jmp    76c9c <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x6ba>
  102966:	e9 47 45 f7 ff       	jmp    76eb2 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x8d0>
  10296b:	e9 50 44 f7 ff       	jmp    76dc0 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x7de>
  102970:	e9 dd 44 f7 ff       	jmp    76e52 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x870>
  102975:	f3 0f 1e fa          	endbr64 
  102979:	48 89 c3             	mov    %rax,%rbx
  10297c:	e9 17 3e f7 ff       	jmp    76798 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x1b6>
  102981:	e9 a7 45 f7 ff       	jmp    76f2d <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x94b>
  102986:	e9 4f 3e f7 ff       	jmp    767da <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*) [clone .cold]+0x1f8>
